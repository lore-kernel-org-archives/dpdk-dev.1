Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320C5EEA84E
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 17:05:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 16BD84067C;
	Fri, 13 Feb 2026 18:04:10 +0100 (CET)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46]) by mails.dpdk.org (Postfix) with ESMTP id E2E1740A82
 for <dev@dpdk.org>; Fri, 13 Feb 2026 18:04:08 +0100 (CET)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso8762555e9.1
 for <dev@dpdk.org>; Fri, 13 Feb 2026 09:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771002248;
 x=1771607048; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mLgeFVjBkxdVfWMCHrHueWkudtsUDBwL9TpNm4v63XI=;
 b=k6+MN9d8Q6ZIfPSHVb+3DydXbcNR24UdYymj5y9OqeAx8s5X5wbUIXAmeRS1gFL5Yo
 cnTRp0dt1v9IeG4eo/jwvt3oylvqOXygzYavq8AD4gPnq1myOYElPdUxzPRXlbkubOFv
 xMK1RaQnVB6s1gYm+lluQJg3vKcWZGlee/FN2SRmkNjNYJbYtw16ZsL3uuJw8XL/kppO
 XAZJIgKbpd3qGN+oXRDZe8FICd6I9eJRYC6uxTuOVFmWPFt40j/gJyIrho9UGDSTIAdY
 O/3y9ekxR/MKACQpzorx+stfK8hPl+vRBc6SlJOhZbH4mCIqHUSb6c+KDm7Q+IVrmFWH
 9erQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771002248; x=1771607048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mLgeFVjBkxdVfWMCHrHueWkudtsUDBwL9TpNm4v63XI=;
 b=UpEfmJQ+B/s0muYHvdLid7zYpq9m4bNHhnOHX5IhCV0T42bFfpRhLfwJ2uBrWofi71
 1bSQJc2gvnFDB/GHUILFIEhZKSb9qIqArBkhNLMDsG9hxLoTCXfvNU5fWzVMW49MgqxZ
 ybn0HED8Ln5vDp2I2pcuIGoyEp88m1LByqn2XM1iWriHarasKXIejC7hz6A3eYIlCTs2
 c13Dbzuel25nxCppIDQJ5VzZ46dmtmlcyfB3kz98Yt5JFbtcuWeq1+8Sh6A/ImIE8Ckx
 FAvoTUmJYb8F/ZYvAR7lPQdW6ZkPP4rJkZXBvLiYxTfB8+cWdOyuiz9X4XQRTKhGRDWl
 v6xg==
X-Gm-Message-State: AOJu0YwBkW81nyNbqNFZQ8+s15YJuhwBi566dV68v3SZUDabCSgYgwhI
 7vOIjryS1qPkRio1fuVwIXKoItq426DOP+bm4aeM0BLO6SOvO6IcAQ83ZRL59p9rs8h0gHg4Jei
 ivVRN
X-Gm-Gg: AZuq6aKVs90EOv9tHDXkHSQHlqkvxc4glWGyHE3RNd8IHb5KEmyNqEaTsR9jy1s7YAJ
 2cMbIkyHqgPZ/4E3Xp9dDNIOcLL9ZzSsdjKK2p+MTuf3lc3o7n0ItV89yY/IslJYDn07F5qRh2Y
 KQnZBFnxg+40SKistv7JvaCbkZgDRZRaIW9YlsFO2QnGp1vdEwj/fmfaJKRRk17mcKJ7/a0C1Md
 8KgOiAnGljwlbXuqQn1UDr1R2SCGRYkVMVZoPTrYwjfNGzRMrczOEelL580UuUZvC8a2Kf6nzF1
 gkMrRWX0ExW/ppBL5mazTL29ZbKSk0pWdVy7rK+Jfswf1DFy3ZOTVjR2YJeRmoeXL0k7xoTLNtU
 80HXAhfJ3sRKTxIMUGrEDzEDoXDqY2GbiTgKfb13GC7gk2iFjwUyVEeHGmSMYNw4ydkAsDWy+TT
 dTgpUNqVCdiCM1OnB3dJk44ezWZDXnfGmtzuGLaCB4I9BSDOaxTA9qkeFNFVfRGA==
X-Received: by 2002:a05:600c:19c6:b0:480:690e:f14a with SMTP id
 5b1f17b1804b1-48373a1da83mr45827175e9.14.1771002248413; 
 Fri, 13 Feb 2026 09:04:08 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483740be167sm40963035e9.15.2026.02.13.09.04.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 09:04:07 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v15 16/18] net/pcap: add link status change support for iface
 mode
Date: Fri, 13 Feb 2026 09:01:39 -0800
Message-ID: <20260213170333.40089-17-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260213170333.40089-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260213170333.40089-1-stephen@networkplumber.org>
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
index 70179a454e..1db54a005a 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -94,6 +94,7 @@ New Features
   * Receive timestamp offload is only done if offload flag set.
   * Receive timestamps support nanosecond precision.
   * Added ``snaplen`` devarg to configure packet capture snapshot length.
+  * Added support for Link State interrupt in ``iface`` mode.
 
 
 Removed Items
diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index e9200f9aac..00f6e4e33d 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -17,6 +17,7 @@
 #include <net/if.h>
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
@@ -113,6 +116,7 @@ struct pmd_internals {
 	bool infinite_rx;
 	bool vlan_strip;
 	bool timestamp_offloading;
+	bool lsc_active;
 };
 
 struct pmd_process_private {
@@ -159,9 +163,10 @@ static const char *valid_arguments[] = {
 
 RTE_LOG_REGISTER_DEFAULT(eth_pcap_logtype, NOTICE);
 
-/* Forward declaration */
+/* Forward declarations */
 static inline int set_iface_direction(const char *iface, pcap_t *pcap,
 				      pcap_direction_t direction);
+static int eth_link_update(struct rte_eth_dev *dev, int wait_to_complete);
 
 static struct queue_missed_stat*
 queue_missed_stat_update(struct rte_eth_dev *dev, unsigned int qid)
@@ -783,6 +788,28 @@ count_packets_in_pcap(pcap_t **pcap, struct pcap_rx_queue *pcap_q)
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
@@ -850,6 +877,13 @@ eth_dev_start(struct rte_eth_dev *dev)
 
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
 
@@ -867,6 +901,12 @@ eth_dev_stop(struct rte_eth_dev *dev)
 
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
@@ -1704,6 +1744,9 @@ eth_from_pcaps(struct rte_vdev_device *vdev,
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

