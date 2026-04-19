Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9630EEA71A1
	for <dpdk-dev@archiver.kernel.org>; Sun, 19 Apr 2026 16:13:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0418740DD5;
	Sun, 19 Apr 2026 18:11:38 +0200 (CEST)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com
 [209.85.210.49]) by mails.dpdk.org (Postfix) with ESMTP id B4EFA40DCF
 for <dev@dpdk.org>; Sun, 19 Apr 2026 18:11:36 +0200 (CEST)
Received: by mail-ot1-f49.google.com with SMTP id
 46e09a7af769-7dbba5076c8so1209618a34.0
 for <dev@dpdk.org>; Sun, 19 Apr 2026 09:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776615096;
 x=1777219896; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jmfk/1c4mPbGvSI+BWWqEGc8J7q+XhkGp9GTUofu6Lo=;
 b=YxviWgNB+9j0on3zwJI705nWlUaK2xJ5Ed+AAXaMlGmZqUC5mZrNzEzHxuCU+VTcfV
 uDDMiIjV/J5Jj6sSxqD325eZiAdloTITmKFRNhGW5r9epkAyUVWKHWCGzor0xJkGJ9Iw
 pK8AK/vSSDgO0eUiIFt+Zn6Vt+ngxhUeNNA+oXD5hTk/lK9LJmamskoYeqQwsiR7nLgQ
 rr+JNrId1aaMnc5Aa+5klg4Q4nGJ93ZjlnVqcaXrW3Ttcd8h+42L8Brql5t2Q0AgjYza
 TAkVAqHsHmbI/zmWmn5aeEk/0O3c3f6F9Q1hNZptvyxVghBAYUB8C3XWJyDmwo4zKu/W
 PS3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776615096; x=1777219896;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Jmfk/1c4mPbGvSI+BWWqEGc8J7q+XhkGp9GTUofu6Lo=;
 b=R/exk7nBD8Fr/SNmSCoOcaZbTM/NyUOA3S6jZHLsGoKJEYS2KvymjJ0sTFMj338blM
 Gtsnc8cU7nEE5A1XNHU4UXANjCmoAkMleSZ/yZgtsIFzuuXvBvmsIMb42f0TaoaaFgYZ
 rAHIGS+XDtOthJU9TkZX7hTYAUo1h1YMllXgDrUAPt46MRmkFLo3D2qw/ETnCyCDFVXl
 reWUFCEr8s6ZZv+2R4/3rvGx5xArisMZz7yppVS9TV6u/F5+gSEqfzyDJPgkL9bN9gp9
 d8HlPJJk1wD5RsYJTg9bUpVCZZzjA31sVnf72s8ioyeAW+LLn2oxxZA2XlFFzQ4NRYEO
 fSuw==
X-Gm-Message-State: AOJu0YylCbAhiwf0rszA6yBMTDJ9AEueeMvR3itJEiIQHCq4MzbeNNiF
 J7vVANEB+M1CAFbtMk6m9oz1f3kwB2bBQaU2jYbxzj3O932hd+1630gJ1tczVhEQ1aAD4Nc2Dz0
 obFjg
X-Gm-Gg: AeBDievJO4Myl6bhhfto7/JH8sEYceb4MFLqMbET8lpu8/obFl2EQc0QQ6UgDHeOcUM
 sxUiTnqQ2ysqaZgC5VT1HaRgeglVge7faf1KPkuzaTSH9vEoSkXoSvEER/5FlC6jhrtr4cUrzMb
 sZHzt2Im+h/Z2Ue1l5dmNakJjv+EqUhsQrGSkYU2gsmz+AZAk/FkwbIBjPA0H8YFqwyBlB/8bBM
 XtQqbWTKSocfmtlT6IsztSRwvlmL/EXstenOQ5ql8qvuPJA9JD1QLzke2mAgTSGw8Mx5GCR3Upo
 On+hxhGfScsSND15ZGU5mxdBrzQ5/08CsqE3VS4/F7htiVhxrxat8jogK9GonasK6QxBAjEVGSh
 Z7kJ82xSA7CVsTJCEDPfSsHKl8f0b+RZjIVT09ENgIKdoVrH9fX9BnPpfaZUgBa3DiJxuOFvcug
 MqvVsOxAIBD0mzyHHKw3YYunHEec0kWQFaQ98kySyQm2U=
X-Received: by 2002:a05:6830:648e:b0:7d7:ef00:2909 with SMTP id
 46e09a7af769-7dc951c74fcmr6676019a34.13.1776615095909; 
 Sun, 19 Apr 2026 09:11:35 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b930bca47sm5970632fac.7.2026.04.19.09.11.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2026 09:11:35 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v25 22/24] net/pcap: add link status change support for iface
 mode
Date: Sun, 19 Apr 2026 09:09:55 -0700
Message-ID: <20260419161059.205954-23-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260419161059.205954-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260419161059.205954-1-stephen@networkplumber.org>
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
index bbce14e8a4..741b987977 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -69,6 +69,7 @@ New Features
   * Added support for reporting link state in ``iface`` mode.
   * Receive timestamps support nanosecond precision.
   * Added ``snaplen`` devarg to configure packet capture snapshot length.
+  * Added support for Link State interrupt in ``iface`` mode.
 
 
 
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

