Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA51606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:48:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E7AB340E4C;
	Fri, 23 Oct 2026 15:44:53 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 5847640DD7
 for <dev@dpdk.org>; Fri, 23 Oct 2026 15:44:39 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3BB1F1A0038;
 Fri, 23 Oct 2026 15:44:39 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 04E621A000A;
 Fri, 23 Oct 2026 15:44:39 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 9FD4118000BA;
 Fri, 23 Oct 2026 21:44:37 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v4-S3 43/65] event/dpaa2: use event port DPIO for dequeue wait
Date: Fri, 23 Oct 2026 19:13:23 +0530
Message-ID: <20261023134346.37727-44-prashant.gupta_3@nxp.com>
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

dpaa2_eventdev_dequeue_wait() cleared the interrupt status and armed
epoll_wait() using the per-lcore portal and DPIO
(DPAA2_PER_LCORE_PORTAL / DPAA2_PER_LCORE_DPIO). Those per-lcore
handles are only valid on the polling path and do not correspond to
the DPIO backing the event port, so the interrupt fd waited on could
belong to the wrong portal.

Pass the event port's dpio_dev into dpaa2_eventdev_dequeue_wait() and
use its software portal and epoll fd, matching the DPIO actually used
by the dequeue burst.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/event/dpaa2/dpaa2_eventdev.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/event/dpaa2/dpaa2_eventdev.c b/drivers/event/dpaa2/dpaa2_eventdev.c
index 5badc17af7..be23dbf4dc 100644
--- a/drivers/event/dpaa2/dpaa2_eventdev.c
+++ b/drivers/event/dpaa2/dpaa2_eventdev.c
@@ -230,15 +230,13 @@ dpaa2_eventdev_enqueue_burst(void *port, const struct rte_event ev[],
 	return num_tx;
 }
 
-static void dpaa2_eventdev_dequeue_wait(uint64_t timeout_ticks)
+static void dpaa2_eventdev_dequeue_wait(struct dpaa2_dpio_dev *dpio_dev,
+	uint64_t timeout_ticks)
 {
 	struct epoll_event epoll_ev;
 
-	qbman_swp_interrupt_clear_status(DPAA2_PER_LCORE_PORTAL,
-					 QBMAN_SWP_INTERRUPT_DQRI);
-
-	epoll_wait(DPAA2_PER_LCORE_DPIO->epoll_fd,
-			 &epoll_ev, 1, timeout_ticks);
+	qbman_swp_interrupt_clear_status(dpio_dev->sw_portal, QBMAN_SWP_INTERRUPT_DQRI);
+	epoll_wait(dpio_dev->epoll_fd, &epoll_ev, 1, timeout_ticks);
 }
 
 static void dpaa2_eventdev_process_parallel(struct dpaa2_dpio_dev *dpio_dev,
@@ -316,7 +314,7 @@ dpaa2_eventdev_dequeue_burst(void *port, struct rte_event ev[],
 			 */
 			qbman_swp_dqrr_consume(swp, NULL);
 			if (!num_pkts && timeout_ticks) {
-				dpaa2_eventdev_dequeue_wait(timeout_ticks);
+				dpaa2_eventdev_dequeue_wait(dpio_dev, timeout_ticks);
 				timeout_ticks = 0;
 				continue;
 			}
-- 
2.43.0

