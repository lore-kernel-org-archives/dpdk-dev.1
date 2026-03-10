Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C6EFCC9AA
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 02:52:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5590F40DFB;
	Tue, 10 Mar 2026 03:49:58 +0100 (CET)
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com
 [209.85.210.43]) by mails.dpdk.org (Postfix) with ESMTP id F2AB540E0F
 for <dev@dpdk.org>; Tue, 10 Mar 2026 03:49:52 +0100 (CET)
Received: by mail-ot1-f43.google.com with SMTP id
 46e09a7af769-7d7412cfb9eso1531902a34.1
 for <dev@dpdk.org>; Mon, 09 Mar 2026 19:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773110992;
 x=1773715792; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MUWwR498sGVKgZUUtMR56uLir1RQU/oq5xfwZ2WCJFA=;
 b=U4FRYlfym7EU9gwCVjFDboyEFs7BrXmuqz04Ot88amSZxaHp8bB0+6ZbjxhaE/sGo9
 Z4WUgCZij2OvBBzmRvgpOXP6DvU3UhSpnzIsjdaxw8GbvF1A9anJXOJ/6jzYzNadOx/6
 H9sm4IilIGnM6idiL1DORVUG4Yqi8cgFsGltxHysYQPihXzPDxAVcTtomE4dzqB0t7Wb
 oNRhW3iUkirJ4/OuQprdJ6wIboKtW7RwpgfN6/HWc+I5YPwglzrTMDHNIlNTkzatMJpB
 F9MRqgifaPA/y1q2naATA/ZOMy2CVaGL6KwHCuVEg276JCz+qUgzBECEO2qhwJY2d0FP
 uF+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773110992; x=1773715792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MUWwR498sGVKgZUUtMR56uLir1RQU/oq5xfwZ2WCJFA=;
 b=o8fS2qjE+X+ZC0Lkpqmy7f4Gqn4Kc3Xng/CCF6o6fDG3jREyqADtf4lHUl3sirW3rn
 7fS+u2DtRlIDXAz+jZtrLAfATSGNHKyaTv4mjT8H431tPMo0VhU9bwsNUsWeouD0QF7L
 XjxsywbcRIRIylGTbXmHMwXlfIcJcfyddk8KclhpJ/RQzdi6CQhT7nuY9hGK5MfctYaP
 EaRBR2GcTi2iUTFkOoyoCYo5gjKEabUx6tNLabp2+2AvLPktGJNUCSmrLqrI5wd56ksp
 pXOYTQHvV9HUEHcJmCaLnhbSRYGh+HRuopQ76TXQGhMlCIP1Z3dRIWXaet9crTNTrIK2
 /chg==
X-Gm-Message-State: AOJu0YwtHEgT0iDEQtogLwnKHbXebrmjhtDtjMcy8Xpxft5GSKq/7gWR
 indDtq/9hF0fRIr6UiLuHeTJCEedGWTWV6YU3UE0tw0DoSzqesjoJAaI4dRUEoa0GbVO6Vnn7/w
 jK42q06Q=
X-Gm-Gg: ATEYQzw5UA9T2J1VngDOP6xFJD5+pKYJ8YXm1Kx/h0DV+JxaR6wdi4ckfdIqs9ZCXbV
 kEKUJ3BC1mxcr3N/UxYAGH/8fcqoSfLLxwVYPHI/CaPRg3nOIpJrZDZ8jkFJiTXyo47k7nuYFJQ
 UTQXHhOYtTgXgICU/8tEBnHirfMuC68HDqERUhWpbloR5Zbo5Zi/l+RYntO6pCAuQ71FRaQbhx1
 /9liBoQv+zDn532awWx2ysAl/yEob4viS/YT7yUlrgyhDJaf0Fg6i3M4TOmvjo0Jsx82f8NUyBK
 aXpnvksK3I21OMtsC++H+WoZNOA3sZGZsobFqMKn8D8+hyQy4ZeFT4awpNZNsy4oJoXZKgu3QMf
 XlVQmsD/oVAnAFs3WdEQsFwUla/4So/oEOEikbNjeVQvd0V8TwvYSTByY/isqF7J5AiDa4Xup0J
 kbBOrl6G9ZrDNzLtc6sekPr6pP/cD3cnpb
X-Received: by 2002:a05:6830:7306:b0:7d7:58b0:7685 with SMTP id
 46e09a7af769-7d758b08832mr1622262a34.13.1773110992272; 
 Mon, 09 Mar 2026 19:49:52 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d728d1238csm7808572a34.15.2026.03.09.19.49.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 19:49:51 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v19 22/25] net/pcap: add link status change support for iface
 mode
Date: Mon,  9 Mar 2026 19:47:57 -0700
Message-ID: <20260310024925.476543-23-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260310024925.476543-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260310024925.476543-1-stephen@networkplumber.org>
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
 doc/guides/rel_notes/release_26_03.rst |  1 +
 drivers/net/pcap/pcap_ethdev.c         | 45 ++++++++++++++++++++++++++
 4 files changed, 52 insertions(+)

diff --git a/doc/guides/nics/features/pcap.ini b/doc/guides/nics/features/pcap.ini
index ec7c91c650..b409ecd597 100644
--- a/doc/guides/nics/features/pcap.ini
+++ b/doc/guides/nics/features/pcap.ini
@@ -5,6 +5,7 @@
 ;
 [Features]
 Link status          = Y
+Link status event    = Y
 Queue start/stop     = Y
 Timestamp offload    = Y
 Basic stats          = Y
diff --git a/doc/guides/nics/pcap.rst b/doc/guides/nics/pcap.rst
index 2754e205c7..72f2250790 100644
--- a/doc/guides/nics/pcap.rst
+++ b/doc/guides/nics/pcap.rst
@@ -278,3 +278,8 @@ Features and Limitations
 
 *  The PMD will insert the pcap header packet timestamp with nanoseconds resolution and
    UNIX origin, i.e. time since 1-JAN-1970 UTC, if ``RTE_ETH_RX_OFFLOAD_TIMESTAMP`` is enabled.
+
+*  In ``iface`` mode, the PMD supports link status change (LSC) notifications.
+   When the application enables ``intr_conf.lsc`` in the port configuration,
+   the driver polls the underlying network interface once per second and generates an
+   ``RTE_ETH_EVENT_INTR_LSC`` callback when the link state changes.
diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index 49e2c0cf2b..c1bb808195 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -112,6 +112,7 @@ New Features
   * Added support for reporting link state in ``iface`` mode.
   * Receive timestamps support nanosecond precision.
   * Added ``snaplen`` devarg to configure packet capture snapshot length.
+  * Added support for Link State interrupt in ``iface`` mode.
 
 
 Removed Items
diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index d8a924b0cd..2d64032474 100644
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
@@ -766,6 +773,28 @@ count_packets_in_pcap(pcap_t **pcap, struct pcap_rx_queue *pcap_q)
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
@@ -848,6 +877,13 @@ eth_dev_start(struct rte_eth_dev *dev)
 
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
 
@@ -865,6 +901,12 @@ eth_dev_stop(struct rte_eth_dev *dev)
 
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
@@ -1661,6 +1703,9 @@ eth_from_pcaps(struct rte_vdev_device *vdev,
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

