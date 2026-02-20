Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD03C54EFC
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 05:51:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 175A640DD2;
	Fri, 20 Feb 2026 06:49:07 +0100 (CET)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com
 [209.85.219.51]) by mails.dpdk.org (Postfix) with ESMTP id 26D7640B98
 for <dev@dpdk.org>; Fri, 20 Feb 2026 06:49:01 +0100 (CET)
Received: by mail-qv1-f51.google.com with SMTP id
 6a1803df08f44-896f9397ecdso18182986d6.3
 for <dev@dpdk.org>; Thu, 19 Feb 2026 21:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771566540;
 x=1772171340; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/amZJFM2kcRe2JfP2uMEqn1/Lk/yiVkGiWD1VVdmZpQ=;
 b=s5nBM7HU/BxDO8C/p5Nb+TFYU+SSkB4J8Izgwk2BCs2KtAijKCO85TlhALuZIOg96r
 v30wCSj0WJyOdQlcaog6V409x35PjXeFamgqMW6ul1xIXW8XzaVD5qMGNtEmKRNrnbto
 EqYrm0MpSw5dNtvpW+M+rXWL+XxgGzsTSjG9nPwvb39QzLyoZM6U4Oc47Xxn2W/nSbJM
 2XufKI2CGKOKM0aR+SfUS0j760bk0eeATzaqRqOs8fcKRfguQBRhx4j7k5nmXvW3VBUv
 4tRW+9UZqYQXsl3rWB4SLA652HrdlvyigcXhSfiPW315LdmLvvYVIqZxwHRK2So8+ybV
 Flaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771566540; x=1772171340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/amZJFM2kcRe2JfP2uMEqn1/Lk/yiVkGiWD1VVdmZpQ=;
 b=Y+HWg1g8KLuz1icyRyo5DG3vykv6W+DaezFnIkTHEjNkF9zvcqhIJiQlwdJnpOQ3/J
 a3mybN/eOUVReAClE9UGyiArhKq3Oqqm3nLsTlqgbOnmxjyS396Pwy2sPggflQx4h/MM
 dNbHQ7Uuj3YXhFNIZnNM/VzqZm4+ckfQbxSDD5GN298XuY1uYBExAcObU5GaF2eAseul
 SRRBL6VV8Hw0NeV2BFl9/6gmQc4srr5JB19F740VvZKrtRM/djHsE07L+YIjCaqi3Z/H
 1NlRouYihy9z3VIWPRmJEAxjTigbMduwb+l4RNVHs2rMZP6W4C0mrfnDSGmvu3lghBM3
 aPtg==
X-Gm-Message-State: AOJu0YwEmjgapJXN97Cj/p7oEDBclWHRHxWfDjnsIyjR15aqIm1MbvZe
 GnQwp7uHG48es0W7LIU5OO1LM3HRuwlSLssqM/6GJ0gcIbtDk4dNdX/pSz4Z+KIm1LuWQEOIGEf
 fHad6
X-Gm-Gg: AZuq6aLkypX0EavQPn6P/8tllAzVqju49AzlWExmclSkGFMKfJRfb+c7W4PL/l2dV1o
 JjN/qBMfYtGMuEal7nXiRLepW/+m52/jx0uKcIepmBOWgTpB2qFMieUyC1RcbC4dDjq4PQiJ7pR
 5yg0hlREADyPwZWSXU5TGAg/QbViuBzxqi8UNYwC8EBdam4HuppK4gfdEcd457dekptNDe6ERgH
 C7IZLx/LuFLxMb23NpQAUG9AdyToSdJO7FvpZFxEUg+w9HgLEvy+k2TKrgz0PR5RewDoIAU73sa
 z+Yd0uzL4eRmkGCXF/E7OPBfblBhPtd9u9o3IORTrAAN5jtRfmm94baZK18Gp127r48J3d6QnQm
 SrvKCErd67Hc+790nwSU9MDpuS4e9ix733RJNVhunhgW9tSHeG4GEWU4srz9bZPgEmYU6dGzSoC
 Z+3/Fioie3p7sQ2gkqtxLvCLo2DAHArpMsdze7WywRa3Cb5niEvt9oUfqlw6Eqmw==
X-Received: by 2002:ad4:576a:0:b0:882:44cc:f572 with SMTP id
 6a1803df08f44-89957f78d00mr117756586d6.20.1771566540422; 
 Thu, 19 Feb 2026 21:49:00 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8971cdad6c1sm229078096d6.39.2026.02.19.21.48.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 21:49:00 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v17 21/23] net/pcap: add link status change support for iface
 mode
Date: Thu, 19 Feb 2026 21:45:56 -0800
Message-ID: <20260220054834.1632201-22-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260220054834.1632201-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260220054834.1632201-1-stephen@networkplumber.org>
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
index 526e157dd4..39ce14ffe7 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -113,6 +113,7 @@ New Features
   * Receive timestamp offload is only done if offload flag set.
   * Receive timestamps support nanosecond precision.
   * Added ``snaplen`` devarg to configure packet capture snapshot length.
+  * Added support for Link State interrupt in ``iface`` mode.
 
 
 Removed Items
diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 1ddd0c36d1..00659764dc 100644
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
@@ -789,6 +794,28 @@ count_packets_in_pcap(pcap_t **pcap, struct pcap_rx_queue *pcap_q)
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
@@ -856,6 +883,13 @@ eth_dev_start(struct rte_eth_dev *dev)
 
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
 
@@ -873,6 +907,12 @@ eth_dev_stop(struct rte_eth_dev *dev)
 
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

