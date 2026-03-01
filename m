Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E9DBFD0048
	for <dpdk-dev@archiver.kernel.org>; Sun,  1 Mar 2026 02:10:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A3E840EF1;
	Sun,  1 Mar 2026 03:08:03 +0100 (CET)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 by mails.dpdk.org (Postfix) with ESMTP id 1205640EAB
 for <dev@dpdk.org>; Sun,  1 Mar 2026 03:07:58 +0100 (CET)
Received: by mail-qk1-f170.google.com with SMTP id
 af79cd13be357-8cb3fb47559so402030285a.1
 for <dev@dpdk.org>; Sat, 28 Feb 2026 18:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772330877;
 x=1772935677; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=erMih5TeTgkwGyonkw95S3xZzodFeEoXqsVTti+i2pY=;
 b=dbJiFcgtDHMpi7eHjwCezIX5pdrMpYBhf8U/FMH9A4yIW8Q+JXsBYu2Fn0tZ4Wkch/
 4v1nIpTt9XMLgWVi/pW5e6KYLGqv2DeOCdTk7uLb2ypxJ/5D4/MIdX5CSuZ4pseP/VYy
 Zzf++FX9PmzBTHqGYh0AWS4bYaCfwiaDtenOZ9zQFM/ar9poqNnDoM0vfDbU3TWZ8qhg
 +d/1ua+lLz9j2OUAY05m5tOYfKDSxQBOwdibmZdcG2vfmjowsMMwPoPVmq1UpZ1hRmcV
 RZY+h6EABDWRhh+kFWCb4DhHjUNG3GC8ZbdsMtTh091zhrAZowIn9NQeDaQ9ArFHnAtY
 SUqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772330877; x=1772935677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=erMih5TeTgkwGyonkw95S3xZzodFeEoXqsVTti+i2pY=;
 b=pl9sKbpfidXtdS+sFRIBLTQP0QZvWCLFDIwVLzEk1ZtL8sMGjtQ3evD+nLoQ+EQBU5
 iwLqBZPIzOaZ0xb2HFmwV2C8gJEfgD7ofnN5nQXNwNXFG7siQLE+UIx7Q/Q7BOKyperx
 I0Q1i8Gz40mniE5TIvbe2vdCoB1Vd4VM5rP/zmxNVfs336Fjv+bZVLpioW/hgpvz9Ppy
 1W4PHFtAU4rbJTL3/Wroz4cYPT/bufqPZKICb27SL4cERODydGQM9KM3Gf57Pb9boPtc
 ZJl/qMZBT+5c2Z6YQjhhUwDP4o5Rxc7woo3UMMGd2ruzm3Ptlz5ptFyd5c6sFGqxmDX+
 BPPA==
X-Gm-Message-State: AOJu0YzgrRQHwMXT5OceKynwrqDDM4JMBgxKzdoyZCDGNrY60SVH4ogA
 Q6aR7NcEcxzkH7q0dssyo6gbJJwo4RJhqeIdXXgS8XYAvHgyFjsLs4fnKZqnET7dPenI1ZsvKaV
 nbp1o
X-Gm-Gg: ATEYQzyc9fISkoMeQqxEi27CmUu4M9ys1b4+sG/eYn/Vq4kb0i5unilJ7D1kPF14N5B
 P2GSbb0loIZ6IYuHkLx5Fev9iYRJuMNSNSA7ci/Uio0wKLFn6Xj6sDB8gh/jJG5XB0ITE0RhynD
 9b0wIwmsni5WcYWc4KYl3TIhanJ0yTL4DBSHZyDPY2eIE09zJIQ5tMYryPPCllYt9HU5EscbjeA
 MVez39Wr12ASna2TVzV3SdGKxGsCdSDOAYu4i8f3vN9c3BBB87eGveb3kW7QWJm5uQc3FyDuUcN
 BBgCnKrteIiSeKL3pa8NM02pf4DeZi6zkg+RJotqI3joLa+zF/p+UvpHepwxbH7qjTlhJCNWA+g
 5LQVWWei9naq2DrRijrb7Vfe4ic7I4cN2tgyOkw8iaOSR7473q4C3Py/nbgiuboA3uowKPU/QlC
 WJFyIMxrrxLKe4xFayJaQcBTKcm6ovWLdOQNjqWbcu6Pjw4ySEjRyaWXcADuntRA==
X-Received: by 2002:a05:620a:7012:b0:8c6:af5b:d50a with SMTP id
 af79cd13be357-8cbc8de839fmr1096041185a.43.1772330877308; 
 Sat, 28 Feb 2026 18:07:57 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf736bffsm802292985a.50.2026.02.28.18.07.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Feb 2026 18:07:57 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v18 21/23] net/pcap: add link status change support for iface
 mode
Date: Sat, 28 Feb 2026 18:05:54 -0800
Message-ID: <20260301020726.852401-22-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260301020726.852401-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260301020726.852401-1-stephen@networkplumber.org>
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
index 5b5cbb38a2..de28eb1dec 100644
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
@@ -161,6 +165,9 @@ static const char *valid_arguments[] = {
 
 RTE_LOG_REGISTER_DEFAULT(eth_pcap_logtype, NOTICE);
 
+/* Forward declarations */
+static int eth_link_update(struct rte_eth_dev *dev, int wait_to_complete);
+
 static struct queue_missed_stat*
 queue_missed_stat_update(struct rte_eth_dev *dev, unsigned int qid)
 {
@@ -760,6 +767,28 @@ count_packets_in_pcap(pcap_t **pcap, struct pcap_rx_queue *pcap_q)
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
@@ -842,6 +871,13 @@ eth_dev_start(struct rte_eth_dev *dev)
 
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
 
@@ -859,6 +895,12 @@ eth_dev_stop(struct rte_eth_dev *dev)
 
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
@@ -1621,6 +1663,9 @@ eth_from_pcaps(struct rte_vdev_device *vdev,
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

