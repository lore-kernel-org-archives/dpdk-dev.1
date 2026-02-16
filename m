Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA51FE83822
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 18:16:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8471340DC9;
	Mon, 16 Feb 2026 19:14:43 +0100 (CET)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id AA23B40430
 for <dev@dpdk.org>; Mon, 16 Feb 2026 19:14:40 +0100 (CET)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4837907f535so22528765e9.3
 for <dev@dpdk.org>; Mon, 16 Feb 2026 10:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771265680;
 x=1771870480; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nSGGOhfn76Mm061xSomH6djfg061FZ5Ml35tfICVnKI=;
 b=2B+0jzX9QH95Du5clThOObtOzfm0qUbX32ykM/csxIffHLqSBx98MKGYcyxKbzIf8F
 /GA4hrmbq8TJkUNTj1PHUZZz6TQrsoZjngNMLQjiYWHdk1RJHgkg3qyhXg92ySfvxzap
 lhUb/9z6R1ZxY/8jsdUXM8ManolE05h83CuuhiCwCqCvYb53BBM9OFdshaHCzeK0yba8
 eIWS0eOfGGniPF6wczIDCxJD/gxsaF4BO1uBjE2EX22LEsa/yS3tl4in3KNtu9/zJ76z
 9xKYFwNyUdUZOP0l1W2oUxZrlVpiQ57JZzicL0splj2skX5tayc5Q+iRZCN2cDhLHLu3
 f5xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771265680; x=1771870480;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nSGGOhfn76Mm061xSomH6djfg061FZ5Ml35tfICVnKI=;
 b=bzkL9hLl2y2Y1QMEAXaZI5OPY1iQK7/LKFnHXq8ONOMzKIV3w+Hqy3CVcZ0KDIVkl6
 AWsLVxXF06wuPP3ocj9sADb2c2Dvf3NzEPbCluBomGvKusG6dkPxZ8U8//yeXqJ0GT8g
 wtrFgL7rC7cgCC2rjHBDMYNR68TN9+n6afkNdVKawy7pwGBhjY2UNhh/jeid8ZjcCGhc
 UuMQEQdg7jqyR4Qh9FPXwQFPkDZI1m/Evh01CFk+sT9IsVZSRMcidQdgvM70jR3v7NB8
 V4R5b/0Uo1eqMpciJTw0Jrrh1z/KLKpMjdpgYFM8DI7bUtXR6N3LVpbM+z6lLEr7uLXR
 wFEw==
X-Gm-Message-State: AOJu0Yx6s20HDSpfpcN4V3yILXJUlQdZ+4wDz8rabj7DQLw4Uzz4F9/5
 g9rjKVfoFL9NR57rjk+8HxCg0/p1IP+pvFeMO0YfTRn14W/4ov5YdOaFb637y61yagECccECep5
 PYn0lBB0=
X-Gm-Gg: AZuq6aI5K/tGKhaO/sTqTCHMsb3opP1OgFAwqP+//C+jktlkiSCshJIaBFWzpxUQEfm
 JI2ve0rBEHfsrzNgJbMKraxwlZEualDSWZj+r6vE5EnwUE3VcT0iAsF1xLdeZAcFjzYL3PgzBRK
 HwK6P9v1lDLKk2eeT0ZcdykOFb/S2Vgrv5a5QaV+PspEQ6PSm1xeWElEg5M+a9NUoJG+NVHZNUn
 ImOPvoKzROm0rBpTAY6/lu5jLvs7gZ1+tAt4yS146E3nFZFogcbs4OshwqZUoTPyEwJnFMpe+yx
 kQrt44CHhyRSSqxusl7OcsSjCLUibpOF47UPI4FBXL7B7qbl1/Kl+81nc0fr/cBDwLpC4w5E4u9
 isZsbedt/LxvFT6cNwPW64otdj6nn9tGq6aAs78ZcW76CMhkpzF+THLphiWbLEhn0iB+6LVre/k
 ySD9Sd6r0081WGCUJhZ0hCr8lm+b93UptmhDJt/WAEuxavKfGw4g+HLm7va/wN8g==
X-Received: by 2002:a05:600c:c095:b0:483:7f4e:fef6 with SMTP id
 5b1f17b1804b1-4837f4f00f8mr101123415e9.26.1771265680212; 
 Mon, 16 Feb 2026 10:14:40 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796acffcesm26064725f8f.37.2026.02.16.10.14.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 10:14:39 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v16 19/21] net/pcap: add link status change support for iface
 mode
Date: Mon, 16 Feb 2026 10:12:14 -0800
Message-ID: <20260216181407.428877-20-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260216181407.428877-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260216181407.428877-1-stephen@networkplumber.org>
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
 doc/guides/rel_notes/release_26_03.rst |  1 +
 drivers/net/pcap/pcap_ethdev.c         | 45 +++++++++++++++++++++++++-
 3 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/doc/guides/nics/features/pcap.ini b/doc/guides/nics/features/pcap.ini
index 814bc2119f..084fefbbbb 100644
--- a/doc/guides/nics/features/pcap.ini
+++ b/doc/guides/nics/features/pcap.ini
@@ -5,6 +5,7 @@
 ;
 [Features]
 Link status          = Y
+Link status event    = Y
 Queue start/stop     = Y
 Scattered Rx         = Y
 Timestamp offload    = Y
diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index 3e82b51d3c..314f6d615b 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -99,6 +99,7 @@ New Features
   * Receive timestamp offload is only done if offload flag set.
   * Receive timestamps support nanosecond precision.
   * Added ``snaplen`` devarg to configure packet capture snapshot length.
+  * Added support for Link State interrupt in ``iface`` mode.
 
 
 Removed Items
diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index b0e2728990..5fc534014e 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -18,6 +18,7 @@
 
 #include <pcap.h>
 
+#include <rte_alarm.h>
 #include <rte_cycles.h>
 #include <rte_ring.h>
 #include <rte_ethdev.h>
@@ -49,6 +50,8 @@
 /* This is defined in libpcap but not exposed in headers */
 #define ETH_PCAP_MAXIMUM_SNAPLEN      262144
 
+#define ETH_PCAP_LSC_POLL_INTERVAL_US (1000 * 1000) /* 1 second */
+
 #define ETH_PCAP_ARG_MAXLEN	64
 
 #define RTE_PMD_PCAP_MAX_QUEUES 16
@@ -114,6 +117,7 @@ struct pmd_internals {
 	bool infinite_rx;
 	bool vlan_strip;
 	bool timestamp_offloading;
+	bool lsc_active;
 };
 
 struct pmd_process_private {
@@ -160,9 +164,10 @@ static const char *valid_arguments[] = {
 
 RTE_LOG_REGISTER_DEFAULT(eth_pcap_logtype, NOTICE);
 
-/* Forward declaration */
+/* Forward declarations */
 static inline int set_iface_direction(const char *iface, pcap_t *pcap,
 				      pcap_direction_t direction);
+static int eth_link_update(struct rte_eth_dev *dev, int wait_to_complete);
 
 static struct queue_missed_stat*
 queue_missed_stat_update(struct rte_eth_dev *dev, unsigned int qid)
@@ -787,6 +792,28 @@ count_packets_in_pcap(pcap_t **pcap, struct pcap_rx_queue *pcap_q)
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
 eth_dev_start(struct rte_eth_dev *dev)
 {
@@ -854,6 +881,13 @@ eth_dev_start(struct rte_eth_dev *dev)
 
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
 
@@ -871,6 +905,12 @@ eth_dev_stop(struct rte_eth_dev *dev)
 
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
@@ -1708,6 +1748,9 @@ eth_from_pcaps(struct rte_vdev_device *vdev,
 		internals->if_index =
 			osdep_iface_index_get(rx_queues->queue[0].name);
 
+		/* Enable LSC interrupt support for iface mode */
+		eth_dev->data->dev_flags |= RTE_ETH_DEV_INTR_LSC;
+
 		/* phy_mac arg is applied only if "iface" devarg is provided */
 		if (rx_queues->phy_mac) {
 			if (eth_pcap_update_mac(rx_queues->queue[0].name,
-- 
2.51.0

