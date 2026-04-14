Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A84F9D0E2
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Apr 2026 16:12:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3895E40DF5;
	Tue, 14 Apr 2026 18:10:43 +0200 (CEST)
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com
 [209.85.160.45]) by mails.dpdk.org (Postfix) with ESMTP id 2ABD840DDA
 for <dev@dpdk.org>; Tue, 14 Apr 2026 18:10:40 +0200 (CEST)
Received: by mail-oa1-f45.google.com with SMTP id
 586e51a60fabf-4043b27ddeaso2993329fac.1
 for <dev@dpdk.org>; Tue, 14 Apr 2026 09:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776183039;
 x=1776787839; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6QcwuAKLbTtEJzZI6UZ5JwhmkS1y1Ay0WbuG0cXi3LY=;
 b=iEpCkKHZwV8gByQYrxJdc8Cznui+zDFcUOXntpLb0ZTkmNbUd8p6wLNDR5HqSxp7t6
 A4DG94OfGGrIe0NTgJnDTyovJzNNWuDrJx0csOt5FzSJH5L7WATt9Yo2SQBLrwusQHnt
 0hd2c1K/dRZeEWFuNRS1wEFOPn5J+U6+498Uwpj6/vZ6AosZOIysjQ05BbxX/jhiFQ7c
 DCc+TwnqvpL6RrRyGdjD/5jx62UejrqjE67FL0mLfXmA5Va7505Nn/SCKsy2VD2PTK+w
 s40DGGnwKp1meCjoMsYu80HIgnHC0Et2KN9PEY4092h7mQ3qBjCKR5q7WcJi1Dn2pQq2
 yJdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776183039; x=1776787839;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6QcwuAKLbTtEJzZI6UZ5JwhmkS1y1Ay0WbuG0cXi3LY=;
 b=UkJck86u5jKhJ93ly9he8g+cXL8Inh2MY/b9R+c92+/hYyFBkGckU5LlKwZFq1Ke57
 AfNx6Cm9w7R0Yjk0jGbDm0y9e8T0JxO931IRtccyikXvAFktkdNaeMpp8we7uyNjSydX
 eRoq/pGO3NmD4z2RUPKMea/TlAne/oThMnKiCak788s3DY6ivRLEbwFe9NzPzbT4gZiq
 uvamezGJS0fjfmU3Q0ZVX1c1LFr2ws9l+PxeaA+vuz1JSxTMk8g2vrhDXxmOueKE8qfc
 zC+LD7Z2+vCj9QVZ0Nr6D0uqEisYSwNarT5MwYJROcqtkQpOVC1szeK8YMom4E6rR8zK
 9EPg==
X-Gm-Message-State: AOJu0Yz1apgRAjURiPDLgp6ki5HZW2Dzgn2/6BmJU/hoXW8p5hwKCqQQ
 rofO+gri42+EO0qgkXLz4FEdC4ZuUlWo/vy2oNrBL8p3bMRgDl0TkMgc5/k+AoidVQy99xbA9f5
 uzWG6
X-Gm-Gg: AeBDieubo/LD/y2dH5522C67PRIX4GwlyR6JXvWL7DoVveiB5CET2BVA4Z7jww5aIg5
 p5gS+eY62dnQ1YFBHWSa0RCvTLZZG9alF2Vn0FWH4h57NpsefRYKxhdfv9sHxdlO000gtFq/KkI
 eT46yQTuX7+kEuMnkWVMdw0/N8uXWW/E6ugzWGV1h5M7SDwdjUV4oaZ7enqMxCetGwJlVnXtGVt
 qv/qMv4hap+IsUDSNWnzRo0CwkVMDo4/kpImUSHxUAaPTycdbT+kQ6OOErwcDHqalUc40F8GPWf
 uyap+XcliJo0ukAR2OaJFd4Zwkqhd6MGD73leSLrLwR8520ST7GzNqwT6QnUe3WelcK2GAMDNQg
 PYoDdL0BXt9wo6uVKMrUa1V1t203O+sTLjUc4OAGDS+zzW6G7PC/RhdvSvLxo2nMsY3hoi4MJJM
 ZCjtzD9+VgfJLZGlFAPXPbmfmZnZ5aXXSJDMB9N2aqLgc=
X-Received: by 2002:a05:6871:a841:b0:417:6237:cf7e with SMTP id
 586e51a60fabf-423e0e5d2bdmr9891923fac.8.1776183039280; 
 Tue, 14 Apr 2026 09:10:39 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-423dd396960sm11809554fac.2.2026.04.14.09.10.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 09:10:38 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v22 22/24] net/pcap: add link status change support for iface
 mode
Date: Tue, 14 Apr 2026 09:08:13 -0700
Message-ID: <20260414161011.756101-23-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414161011.756101-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260414161011.756101-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add LSC interrupt support for pass-through (iface=) mode so
applications can receive link state change notifications via
the standard ethdev callback mechanism.

Uses alarm-based polling to periodically check the underlying
interface state via osdep_iface_link_get(). The LSC flag is
advertised only for iface mode devices, and polling is gated
on the application enabling intr_conf.lsc in port configuration.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/nics/features/pcap.ini      |  1 +
 doc/guides/nics/pcap.rst               |  5 +++
 doc/guides/rel_notes/release_26_07.rst |  1 +
 drivers/net/pcap/pcap_ethdev.c         | 45 ++++++++++++++++++++++++++
 4 files changed, 52 insertions(+)

diff --git a/doc/guides/nics/features/pcap.ini b/doc/guides/nics/features/pcap.ini
index 9f234aa7b9..38dd298603 100644
--- a/doc/guides/nics/features/pcap.ini
+++ b/doc/guides/nics/features/pcap.ini
@@ -5,6 +5,7 @@
 ;
 [Features]
 Link status          = Y
+Link status event    = Y
 Queue start/stop     = Y
 Timestamp offload    = P
 Basic stats          = Y
diff --git a/doc/guides/nics/pcap.rst b/doc/guides/nics/pcap.rst
index b66202e125..91763c27c0 100644
--- a/doc/guides/nics/pcap.rst
+++ b/doc/guides/nics/pcap.rst
@@ -277,3 +277,8 @@ Features and Limitations
 
 *  If ``RTE_ETH_RX_OFFLOAD_TIMESTAMP`` is enabled then the timestamp
    from the pcap file is converted to DPDK format.
+
+*  In ``iface`` mode, the PMD supports link status change (LSC) notifications.
+   When the application enables ``intr_conf.lsc`` in the port configuration,
+   the driver polls the underlying network interface once per second and
+   generates a ``RTE_ETH_EVENT_INTR_LSC`` callback when the link state changes.
diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index d34ed3a8bd..38c2a67749 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -61,6 +61,7 @@ New Features
   * Added support for reporting link state in ``iface`` mode.
   * Receive timestamps support nanosecond precision.
   * Added ``snaplen`` devarg to configure packet capture snapshot length.
+  * Added support for Link State interrupt in ``iface`` mode.
 
 
 Removed Items
diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index c2dec9167d..2276aaf513 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -17,6 +17,7 @@
 
 #include <pcap.h>
 
+#include <rte_alarm.h>
 #include <rte_cycles.h>
 #include <rte_ring.h>
 #include <rte_ethdev.h>
@@ -48,6 +49,8 @@
 /* This is defined in libpcap but not exposed in headers */
 #define ETH_PCAP_MAXIMUM_SNAPLEN      262144
 
+#define ETH_PCAP_LSC_POLL_INTERVAL_US (1000 * 1000) /* 1 second */
+
 #define ETH_PCAP_ARG_MAXLEN	64
 
 #define RTE_PMD_PCAP_MAX_QUEUES 16
@@ -115,6 +118,7 @@ struct pmd_internals {
 	bool vlan_strip;
 	bool rx_scatter;
 	bool timestamp_offloading;
+	bool lsc_active;
 };
 
 struct pmd_process_private {
@@ -163,6 +167,9 @@ static const char *valid_arguments[] = {
 
 RTE_LOG_REGISTER_DEFAULT(eth_pcap_logtype, NOTICE);
 
+/* Forward declarations */
+static int eth_link_update(struct rte_eth_dev *dev, int wait_to_complete);
+
 static struct queue_missed_stat*
 queue_missed_stat_update(struct rte_eth_dev *dev, unsigned int qid)
 {
@@ -785,6 +792,28 @@ count_packets_in_pcap(pcap_t **pcap, struct pcap_rx_queue *pcap_q)
 	return pcap_pkt_count;
 }
 
+/*
+ * Periodic alarm to poll link state.
+ * Enabled when link state interrupt is enabled in single_iface mode.
+ */
+static void
+eth_pcap_lsc_alarm(void *arg)
+{
+	struct rte_eth_dev *dev = arg;
+	struct pmd_internals *internals = dev->data->dev_private;
+	struct rte_eth_link old_link, new_link;
+
+	rte_eth_linkstatus_get(dev, &old_link);
+	eth_link_update(dev, 0);
+	rte_eth_linkstatus_get(dev, &new_link);
+
+	if (old_link.link_status != new_link.link_status)
+		rte_eth_dev_callback_process(dev, RTE_ETH_EVENT_INTR_LSC, NULL);
+
+	if (internals->lsc_active)
+		rte_eal_alarm_set(ETH_PCAP_LSC_POLL_INTERVAL_US, eth_pcap_lsc_alarm, dev);
+}
+
 static int
 set_iface_direction(const char *iface, pcap_t *pcap,
 		pcap_direction_t direction)
@@ -867,6 +896,13 @@ eth_dev_start(struct rte_eth_dev *dev)
 
 	dev->data->dev_link.link_status = RTE_ETH_LINK_UP;
 
+	/* Start LSC polling for iface mode if application requested it */
+	if (internals->single_iface && dev->data->dev_conf.intr_conf.lsc) {
+		internals->lsc_active = true;
+		rte_eal_alarm_set(ETH_PCAP_LSC_POLL_INTERVAL_US,
+				  eth_pcap_lsc_alarm, dev);
+	}
+
 	return 0;
 }
 
@@ -884,6 +920,12 @@ eth_dev_stop(struct rte_eth_dev *dev)
 
 	/* Special iface case. Single pcap is open and shared between tx/rx. */
 	if (internals->single_iface) {
+		/* Cancel LSC polling before closing pcap handles */
+		if (internals->lsc_active) {
+			internals->lsc_active = false;
+			rte_eal_alarm_cancel(eth_pcap_lsc_alarm, dev);
+		}
+
 		queue_missed_stat_on_stop_update(dev, 0);
 		if (pp->tx_pcap[0] != NULL) {
 			pcap_close(pp->tx_pcap[0]);
@@ -1691,6 +1733,9 @@ eth_from_pcaps(struct rte_vdev_device *vdev,
 		internals->if_index =
 			osdep_iface_index_get(rx_queues->queue[0].name);
 
+		/* Enable LSC interrupt support for iface mode */
+		eth_dev->data->dev_flags |= RTE_ETH_DEV_INTR_LSC;
+
 		/* phy_mac arg is applied only if "iface" devarg is provided */
 		if (rx_queues->phy_mac) {
 			if (eth_pcap_update_mac(rx_queues->queue[0].name,
-- 
2.53.0

