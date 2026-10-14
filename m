Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 559FDCC6B1D
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 02:08:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D0B8840664;
	Wed, 14 Oct 2026 04:08:00 +0200 (CEST)
Received: from esa.hc5801-97.iphmx.com (esa.hc5801-97.iphmx.com
 [139.138.58.96])
 by mails.dpdk.org (Postfix) with ESMTP id 1CDC840612;
 Wed, 14 Oct 2026 04:07:57 +0200 (CEST)
X-CSE-ConnectionGUID: VeNLmMsUSe2UsRbmICBsug==
X-CSE-MsgGUID: VBE97e/eSPaQuCCr629TvA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO se3ccprlyapp01.olympus.f5net.com)
 ([104.219.104.72])
 by esa1.hc5801-97.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 19:08:01 -0700
Received: from K6FNKPXYVK.olympus.f5net.com ([172.18.4.35]) by
 se3ccprlyapp01.olympus.f5net.com over TLS secured channel with Microsoft
 SMTPSVC(10.0.17763.1697); Tue, 13 Oct 2026 19:07:55 -0700
From: Shrey Khandelwal <s.khandelwal@f5.com>
To: weh@microsoft.com
Cc: longli@microsoft.com, stephen@networkplumber.org, dev@dpdk.org,
 stable@dpdk.org
Subject: [PATCH 2/2] net/netvsc: fix link status not updated on host indication
Date: Tue, 13 Oct 2026 19:07:44 -0700
Message-ID: <20261014020744.13605-3-s.khandelwal@f5.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014020744.13605-1-s.khandelwal@f5.com>
References: <20261014020744.13605-1-s.khandelwal@f5.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 14 Oct 2026 02:07:55.0508 (UTC)
 FILETIME=[D39B1340:01DD5B80]
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

With LSC enabled and the port started, rte_eth_link_get() returns
the cached link. When the host reports a link change, the alarm only
calls the LSC callback and nothing updates the cached link, so the
application keeps seeing the old link status and speed.

The indication already has the new state: media connect or disconnect
for the status, and the new speed in the status buffer. Save it when
the indication is received, and apply it to the cached link in the
alarm before calling the LSC callback. The callback is only called if
the link changed. If several indications arrive before the alarm
runs, the latest state is used. Indications received while the port
is stopped are dropped, as the link is queried when the port starts.

Querying the host from the alarm instead could block the interrupt
thread for up to 60 seconds, and fails with -EBUSY while another
RNDIS request is pending.

Check the message length before reading it, and the status buffer
offset and length before reading the speed.

Fixes: 501a7e573564 ("net/netvsc: process link change messages in alarm")
Cc: stable@dpdk.org

Signed-off-by: Shrey Khandelwal <s.khandelwal@f5.com>
---
 drivers/net/netvsc/hn_rndis.c | 90 +++++++++++++++++++++++++++++++++--
 drivers/net/netvsc/hn_rndis.h |  3 +-
 drivers/net/netvsc/hn_rxtx.c  |  2 +-
 drivers/net/netvsc/hn_var.h   |  4 ++
 4 files changed, 93 insertions(+), 6 deletions(-)

diff --git a/drivers/net/netvsc/hn_rndis.c b/drivers/net/netvsc/hn_rndis.c
index 4e13d7c38f..5a965564b2 100644
--- a/drivers/net/netvsc/hn_rndis.c
+++ b/drivers/net/netvsc/hn_rndis.c
@@ -294,12 +294,76 @@ static int hn_nvs_send_rndis_ctrl(struct hn_data *hv,
  */
 static void hn_rndis_link_alarm(void *arg)
 {
-	rte_eth_dev_callback_process(arg, RTE_ETH_EVENT_INTR_LSC, NULL);
+	struct rte_eth_dev *dev = arg;
+	struct hn_data *hv = dev->data->dev_private;
+	struct rte_eth_link link, old;
+	uint32_t status, speed;
+
+	status = rte_atomic_exchange_explicit(&hv->link_ind_status, 0,
+					      rte_memory_order_relaxed);
+	speed = rte_atomic_exchange_explicit(&hv->link_ind_speed, 0,
+					     rte_memory_order_relaxed);
+
+	/* If stopped, the link is queried when the port starts. */
+	if ((status == 0 && speed == 0) || !dev->data->dev_started)
+		return;
+
+	rte_eth_linkstatus_get(dev, &old);
+	link = old;
+	if (status == RNDIS_STATUS_MEDIA_CONNECT)
+		link.link_status = RTE_ETH_LINK_UP;
+	else if (status == RNDIS_STATUS_MEDIA_DISCONNECT)
+		link.link_status = RTE_ETH_LINK_DOWN;
+	if (speed != 0)
+		link.link_speed = speed / 10000;
+	if (link.link_status == old.link_status &&
+	    link.link_speed == old.link_speed)
+		return;
+
+	rte_eth_linkstatus_set(dev, &link);
+	rte_eth_dev_callback_process(dev, RTE_ETH_EVENT_INTR_LSC, NULL);
+}
+
+static void
+hn_rndis_link_alarm_set(struct rte_eth_dev *dev)
+{
+	if (rte_eal_alarm_set(10, hn_rndis_link_alarm, dev) != 0)
+		PMD_DRV_LOG(ERR, "port %u: cannot schedule link update",
+			    dev->data->port_id);
+}
+
+/*
+ * Get the link speed, in 100 bps units, from the status buffer.
+ * Use the received length, as older hosts do not count the status
+ * buffer in the message length.
+ */
+static int
+hn_rndis_link_speed_get(const struct rndis_status_msg *indicate,
+			uint32_t len, uint32_t *speed)
+{
+	uint32_t ofs;
+
+	ofs = RNDIS_STBUFOFFSET_ABS(indicate->stbufoffset);
+	if (indicate->stbuflen < sizeof(*speed) ||
+	    ofs < sizeof(*indicate) || ofs > len ||
+	    len - ofs < indicate->stbuflen)
+		return -EINVAL;
+
+	memcpy(speed, (const uint8_t *)indicate + ofs, sizeof(*speed));
+	return 0;
 }
 
-void hn_rndis_link_status(struct rte_eth_dev *dev, const void *msg)
+void hn_rndis_link_status(struct rte_eth_dev *dev, const void *msg,
+			  uint32_t len)
 {
 	const struct rndis_status_msg *indicate = msg;
+	struct hn_data *hv = dev->data->dev_private;
+	uint32_t speed;
+
+	if (len < sizeof(*indicate)) {
+		PMD_DRV_LOG(ERR, "truncated RNDIS status message: len %u", len);
+		return;
+	}
 
 	hn_rndis_dump(msg);
 
@@ -312,10 +376,28 @@ void hn_rndis_link_status(struct rte_eth_dev *dev, const void *msg)
 		break;
 
 	case RNDIS_STATUS_LINK_SPEED_CHANGE:
+		if (!dev->data->dev_conf.intr_conf.lsc)
+			break;
+		if (hn_rndis_link_speed_get(indicate, len, &speed) != 0) {
+			PMD_DRV_LOG(ERR,
+				    "invalid link speed indication: len %u buf %u:%u",
+				    len, indicate->stbufoffset,
+				    indicate->stbuflen);
+			break;
+		}
+		rte_atomic_store_explicit(&hv->link_ind_speed, speed,
+					  rte_memory_order_relaxed);
+		hn_rndis_link_alarm_set(dev);
+		break;
+
 	case RNDIS_STATUS_MEDIA_CONNECT:
 	case RNDIS_STATUS_MEDIA_DISCONNECT:
-		if (dev->data->dev_conf.intr_conf.lsc)
-			rte_eal_alarm_set(10, hn_rndis_link_alarm, dev);
+		if (!dev->data->dev_conf.intr_conf.lsc)
+			break;
+		rte_atomic_store_explicit(&hv->link_ind_status,
+					  indicate->status,
+					  rte_memory_order_relaxed);
+		hn_rndis_link_alarm_set(dev);
 		break;
 	default:
 		PMD_DRV_LOG(NOTICE, "unknown RNDIS indication: %#x",
diff --git a/drivers/net/netvsc/hn_rndis.h b/drivers/net/netvsc/hn_rndis.h
index 7f40f6221d..524b8f221f 100644
--- a/drivers/net/netvsc/hn_rndis.h
+++ b/drivers/net/netvsc/hn_rndis.h
@@ -6,7 +6,8 @@ struct hn_data;
 
 void hn_rndis_receive_response(struct hn_data *hv,
 			      const void *data, uint32_t len);
-void	hn_rndis_link_status(struct rte_eth_dev *dev, const void *msg);
+void	hn_rndis_link_status(struct rte_eth_dev *dev, const void *msg,
+			     uint32_t len);
 int	hn_rndis_attach(struct hn_data *hv);
 void	hn_rndis_detach(struct hn_data *hv);
 int	hn_rndis_get_eaddr(struct hn_data *hv, uint8_t *eaddr);
diff --git a/drivers/net/netvsc/hn_rxtx.c b/drivers/net/netvsc/hn_rxtx.c
index 6f536610f2..9a04861005 100644
--- a/drivers/net/netvsc/hn_rxtx.c
+++ b/drivers/net/netvsc/hn_rxtx.c
@@ -774,7 +774,7 @@ hn_rndis_receive(struct rte_eth_dev *dev, struct hn_rx_queue *rxq,
 		break;
 
 	case RNDIS_INDICATE_STATUS_MSG:
-		hn_rndis_link_status(dev, buf);
+		hn_rndis_link_status(dev, buf, len);
 		break;
 
 	case RNDIS_INITIALIZE_CMPLT:
diff --git a/drivers/net/netvsc/hn_var.h b/drivers/net/netvsc/hn_var.h
index d7124a7df9..7d9a950816 100644
--- a/drivers/net/netvsc/hn_var.h
+++ b/drivers/net/netvsc/hn_var.h
@@ -144,6 +144,10 @@ struct hn_data {
 	uint32_t	link_status;
 	uint32_t	link_speed;
 
+	/* Pending host link indication, applied by the link alarm */
+	RTE_ATOMIC(uint32_t) link_ind_status;	/* RNDIS_STATUS_MEDIA_* or 0 */
+	RTE_ATOMIC(uint32_t) link_ind_speed;	/* in 100 bps, or 0 */
+
 	struct rte_mem_resource rxbuf_res;	/* UIO resource for Rx */
 	uint32_t	rxbuf_section_cnt;	/* # of Rx sections */
 	uint32_t	rx_copybreak;
-- 
2.55.0

