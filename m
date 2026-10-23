Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0726E60A2609
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:48:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2164D410EE;
	Fri, 23 Oct 2026 15:44:45 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 3ACD340693
 for <dev@dpdk.org>; Fri, 23 Oct 2026 15:44:35 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1EF6120002B;
 Fri, 23 Oct 2026 15:44:35 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id DEC41200020;
 Fri, 23 Oct 2026 15:44:34 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 62AF318000B5;
 Fri, 23 Oct 2026 21:44:33 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v4-S3 39/65] event/dpaa2: limit attached Rx flows per event
 queue
Date: Fri, 23 Oct 2026 19:13:19 +0530
Message-ID: <20261023134346.37727-40-prashant.gupta_3@nxp.com>
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

The array tracking Rx queues attached to an event queue used a
separate DPAA2_EVENTQ_DPNI_RXQ_ATTACH_MAX (128) bound, which was
unrelated to the event queue flow limit. Reuse the existing
DPAA2_EVENT_MAX_QUEUE_FLOWS limit instead so a single value governs
how many flows can target one event queue.

Reduce DPAA2_EVENT_MAX_QUEUE_FLOWS from 2048 to 1024, size the
dpni_rxqs[] array by that limit, and drop the now unused
DPAA2_EVENTQ_DPNI_RXQ_ATTACH_MAX define. Widen dpni_rxq_num and the
local attach index to uint16_t so they can hold the larger count, and
update the attach error message to report the offending event queue.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/event/dpaa2/dpaa2_eventdev.c | 6 +++---
 drivers/event/dpaa2/dpaa2_eventdev.h | 7 +++----
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/event/dpaa2/dpaa2_eventdev.c b/drivers/event/dpaa2/dpaa2_eventdev.c
index be6d8bc3da..cd2b00c3c9 100644
--- a/drivers/event/dpaa2/dpaa2_eventdev.c
+++ b/drivers/event/dpaa2/dpaa2_eventdev.c
@@ -48,11 +48,11 @@ dpaa2_eventdev_attach_eth_rxq(const struct rte_eth_dev *dev,
 {
 	int ret;
 	uint8_t ev_qid = queue_conf->ev.queue_id;
-	uint8_t idx = priv->evq_info[ev_qid].dpni_rxq_num;
+	uint16_t idx = priv->evq_info[ev_qid].dpni_rxq_num;
 	struct dpaa2_dpcon_dev *dpcon = priv->evq_info[ev_qid].dpcon;
 
-	if (idx >= DPAA2_EVENTQ_DPNI_RXQ_ATTACH_MAX) {
-		DPAA2_EVENTDEV_ERR("Too many queues to attach.");
+	if (idx >= DPAA2_EVENT_MAX_QUEUE_FLOWS) {
+		DPAA2_EVENTDEV_ERR("Too many flows to attach eventq%d", ev_qid);
 		return -ENOMEM;
 	}
 	ret = dpaa2_eth_eventq_attach(dev, rxq_id, dpcon, queue_conf);
diff --git a/drivers/event/dpaa2/dpaa2_eventdev.h b/drivers/event/dpaa2/dpaa2_eventdev.h
index 0a98088fe1..adeb22bda6 100644
--- a/drivers/event/dpaa2/dpaa2_eventdev.h
+++ b/drivers/event/dpaa2/dpaa2_eventdev.h
@@ -19,7 +19,7 @@
 #define DPAA2_EVENT_MIN_DEQUEUE_TIMEOUT		1
 #define DPAA2_EVENT_MAX_DEQUEUE_TIMEOUT		(UINT32_MAX - 1)
 #define DPAA2_EVENT_PORT_DEQUEUE_TIMEOUT_NS	100UL
-#define DPAA2_EVENT_MAX_QUEUE_FLOWS		2048
+#define DPAA2_EVENT_MAX_QUEUE_FLOWS		1024
 #define DPAA2_EVENT_MAX_QUEUE_PRIORITY_LEVELS	8
 #define DPAA2_EVENT_MAX_EVENT_PRIORITY_LEVELS	0
 #define DPAA2_EVENT_MAX_NUM_EVENTS		(INT32_MAX - 1)
@@ -52,7 +52,6 @@ enum {
  */
 
 #define DPAA2_EVENTQ_LINK_CONF_MAX 4 /** Max schedule type + 1.*/
-#define DPAA2_EVENTQ_DPNI_RXQ_ATTACH_MAX 128
 struct dpaa2_eventq {
 	int valid;
 	void *event_port;
@@ -64,8 +63,8 @@ struct dpaa2_eventq {
 	uint32_t event_queue_cfg;
 	uint32_t event_queue_id;
 	struct dpaa2_queue *dpci_txqs[DPAA2_EVENTQ_LINK_CONF_MAX];
-	uint8_t dpni_rxq_num;
-	struct dpaa2_queue *dpni_rxqs[DPAA2_EVENTQ_DPNI_RXQ_ATTACH_MAX];
+	uint16_t dpni_rxq_num;
+	struct dpaa2_queue *dpni_rxqs[DPAA2_EVENT_MAX_QUEUE_FLOWS];
 };
 
 struct dpaa2_port {
-- 
2.43.0

