Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B867103A99F
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 02:42:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6DA95410E4;
	Wed, 25 Mar 2026 03:40:52 +0100 (CET)
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by mails.dpdk.org (Postfix) with ESMTP id E549340ED8
 for <dev@dpdk.org>; Wed, 25 Mar 2026 03:40:47 +0100 (CET)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-1271257ae53so2144286c88.1
 for <dev@dpdk.org>; Tue, 24 Mar 2026 19:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774406447;
 x=1775011247; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YiMXfVehZT8pS7O4c3urbLvdy4dv8kVc3eRQcTiVxfs=;
 b=apM+MnT0nIQZjIeM8udC/moUdpn2s4TlzMB5LTM7w1WqIaKf20DSUi52Qj7wNlZ3Wb
 uJMxiCEu3zk8PkaWtyL4LUUu4JjE5PYW8xNHRcFz4/r30m7Mh1ytspHeFVvMVxPuG28O
 m9vCrJmcXNjUa45krFZtndeXdv3wgkeFiZkveQ1m8L3Sbvs5WhUPO1ymYtX6fMff/gYr
 kI/VuH4oc4ffKhEvMe0Cu6HiKm9b3MUeWN0n5AXj4rscw8e1xSDw6MPwj4JbmdGo9DhM
 pzX26NBXByN5zgHeCRj3T4A0GZg1ZxhGnpaBY0P0g7NbZoIHSzpX2gdTVT978ePWiqc7
 iBUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774406447; x=1775011247;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YiMXfVehZT8pS7O4c3urbLvdy4dv8kVc3eRQcTiVxfs=;
 b=WVKoz4z95gA1zIs9md88NeM1pAmKJe9oln8L1kciCCujbkjGGvvlrAZEkQW/fdN3k4
 ZqcwbNqFQPpdnxhyXDxi1go8QBT+gaErxWcWZSEyVI64M2HbAZ/rBDD03/iIbThGH1x0
 JUlznXrSCXP2wgHYMI4iE+h3YbyDn0ylC+jvwucwyuNiCB3AnwvYkHnXyWulCRz3lE4q
 oVjPrsgd7Ccfl4n7fTISYzsWtXuX30aYTz31BBQRXwylZXfcGWFja5umPOa+m6UujJpo
 MyHe04lSeJUxDmbR0BKcfzq1/vz6s8tuLVofRelgeWIry6aUz2wXvpEP1JM9nOw/5luI
 0n+g==
X-Gm-Message-State: AOJu0Yyove0dySwTgA+DWXnQ23+KCqb5JTvWb9DzxO0AMLuzB13AVi1o
 YB5bO0fWc/XXGCbBZYYyjniTsRRMAWAOyq+k62CrC1ZdB3lY1Z2wV+nvx93YPt7bmzA5thgyLHR
 PNljJ
X-Gm-Gg: ATEYQzwccfyJAkGjDi2WYFa/uYl9wUjOlvt5OJittnpXYeBRVD1/UsgLgf4/MGLU3xF
 DQ2i3aSn94jxDF8HZmDV+9a7iWH9XTiec1PwFtssXheMK44EB5hj9Ffr+uKzuHWqLRnJ3EoFzV5
 z2Hu9yaXiF9MvHSMBOSnrIpx7E5x+XFOXoXkIDCedm0q22njCVULJKTykWpZeiBOojWNEySI3RV
 x+EXrOpzmWDXfNlCtW8/5ydv2rlJI5UjbCgC5ifIqxbb3nrQlUaXVwG+oddKYYd9uXWRWJKtYfj
 XM6efE0lS7UOk7Br4PoSSijn5+OhUe9XRSrFHUPngNZPPzBkhkKMIbL6JR6ptgU0AJRoOLRh9Ks
 eR02PhOjpXzR4pyP9S2Nr6he42cLJKYmI3usOC+uahRfVKXBymNaYnaTxdoItREsH1qsfCzLIFS
 Wbt8QoVoTUHEDMH9Kg8omnKscFGFAl0SLv
X-Received: by 2002:a05:7022:62a3:b0:12a:7181:2eff with SMTP id
 a92af1059eb24-12a96e48d02mr806247c88.4.1774406446874; 
 Tue, 24 Mar 2026 19:40:46 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b29b447sm17209452eec.16.2026.03.24.19.40.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 19:40:46 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v21 23/25] net/pcap: add link status change support for iface
 mode
Date: Tue, 24 Mar 2026 19:37:54 -0700
Message-ID: <20260325024018.1275209-24-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325024018.1275209-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260325024018.1275209-1-stephen@networkplumber.org>
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
index 869084d4cd..feb080aa3f 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -142,6 +142,7 @@ New Features
   * Added support for reporting link state in ``iface`` mode.
   * Receive timestamps support nanosecond precision.
   * Added ``snaplen`` devarg to configure packet capture snapshot length.
+  * Added support for Link State interrupt in ``iface`` mode.
 
 
 Removed Items
diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 9b1fbdba3d..aca9ff189c 100644
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
@@ -763,6 +770,28 @@ count_packets_in_pcap(pcap_t **pcap, struct pcap_rx_queue *pcap_q)
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
@@ -845,6 +874,13 @@ eth_dev_start(struct rte_eth_dev *dev)
 
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
 
@@ -862,6 +898,12 @@ eth_dev_stop(struct rte_eth_dev *dev)
 
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
@@ -1669,6 +1711,9 @@ eth_from_pcaps(struct rte_vdev_device *vdev,
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

