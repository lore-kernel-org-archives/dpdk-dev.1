Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE22C606A31B
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:49:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F3D66427AA;
	Fri, 23 Oct 2026 15:45:01 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id D508940A67
 for <dev@dpdk.org>; Fri, 23 Oct 2026 15:44:50 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id BAA7320002B;
 Fri, 23 Oct 2026 15:44:50 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8708220003C;
 Fri, 23 Oct 2026 15:44:50 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 532EC18000B7;
 Fri, 23 Oct 2026 21:44:49 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v4-S3 54/65] event/dpaa2: fix DQRR held buffer accounting on
 enqueue
Date: Fri, 23 Oct 2026 19:13:34 +0530
Message-ID: <20261023134346.37727-55-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023134346.37727-1-prashant.gupta_3@nxp.com>
References: <20260915120208.4185877-1-prashant.gupta_3@nxp.com>
 <20261023134346.37727-1-prashant.gupta_3@nxp.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jun Yang <jun.yang@nxp.com>

In the atomic enqueue path, the DQRR held-buffer state (dqrr_size and
dqrr_held) was updated while building the enqueue descriptors, before
the frames were actually enqueued to the hardware. If the subsequent
qbman_swp_enqueue_multiple_desc() only accepted a subset of the frames
(or none, requiring a retry), the accounting had already been cleared
for frames that were never sent. This left the held-buffer bookkeeping
out of sync with the DQRR entries still owned by the portal, leading to
premature consumption of DQRR slots and incorrect atomic context
release.

Defer the held-buffer update until after each enqueue reports how many
frames were accepted. The per-slot DQRR size and bitmask are recorded
while preparing the descriptors and applied only for the frames that
were actually enqueued.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/event/dpaa2/dpaa2_eventdev.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/event/dpaa2/dpaa2_eventdev.c b/drivers/event/dpaa2/dpaa2_eventdev.c
index 01c71fc0d2..127397e681 100644
--- a/drivers/event/dpaa2/dpaa2_eventdev.c
+++ b/drivers/event/dpaa2/dpaa2_eventdev.c
@@ -129,8 +129,9 @@ dpaa2_eventdev_enqueue_burst(void *port, const struct rte_event ev[],
 	struct qbman_fd fd_arr[MAX_TX_RING_SLOTS];
 	struct qbman_eq_desc eqdesc[MAX_TX_RING_SLOTS];
 	uint16_t num_tx = 0;
+	uint64_t dqrr_held[MAX_TX_RING_SLOTS];
 	int ret;
-	uint8_t dqrr_index;
+	uint8_t dqrr_index, dqrr_size[MAX_TX_RING_SLOTS];
 	const struct rte_event *event;
 	struct dpaa2_queue *dpci_txq[MAX_TX_RING_SLOTS];
 	struct rte_event *ev_tx[MAX_TX_RING_SLOTS];
@@ -180,13 +181,15 @@ dpaa2_eventdev_enqueue_burst(void *port, const struct rte_event ev[],
 			qbman_eq_desc_set_fq(&eqdesc[loop], dpci_txq[loop]->fqid);
 			qbman_eq_desc_set_no_orp(&eqdesc[loop], 0);
 			qbman_eq_desc_set_response(&eqdesc[loop], 0, 0);
+			dqrr_held[loop] = 0;
+			dqrr_size[loop] = 0;
 
 			if (event->sched_type == RTE_SCHED_TYPE_ATOMIC &&
 				*dpaa2_seqn(event->mbuf)) {
 				dqrr_index = *dpaa2_seqn(event->mbuf) - 1;
 				qbman_eq_desc_set_dca(&eqdesc[loop], 1, dqrr_index, 0);
-				dpio_dev->dpaa2_held_bufs.dqrr_size--;
-				dpio_dev->dpaa2_held_bufs.dqrr_held &= ~(1 << dqrr_index);
+				dqrr_size[loop] = 1;
+				dqrr_held[loop] = UINT64_C(1) << dqrr_index;
 			}
 
 			memset(&fd_arr[loop], 0, sizeof(struct qbman_fd));
@@ -218,6 +221,10 @@ dpaa2_eventdev_enqueue_burst(void *port, const struct rte_event ev[],
 					goto quit;
 				}
 			} else {
+				for (i = loop; i < (loop + ret); i++) {
+					dpio_dev->dpaa2_held_bufs.dqrr_size -= dqrr_size[i];
+					dpio_dev->dpaa2_held_bufs.dqrr_held &= ~dqrr_held[i];
+				}
 				loop += ret;
 				retry_count = 0;
 			}
-- 
2.43.0

