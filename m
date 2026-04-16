Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592AAF8D766
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Apr 2026 18:53:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2F73040E3A;
	Thu, 16 Apr 2026 20:52:15 +0200 (CEST)
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by mails.dpdk.org (Postfix) with ESMTP id 027EA40E28
 for <dev@dpdk.org>; Thu, 16 Apr 2026 20:52:10 +0200 (CEST)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-12c42a23c8eso7203341c88.1
 for <dev@dpdk.org>; Thu, 16 Apr 2026 11:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776365530;
 x=1776970330; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jmfk/1c4mPbGvSI+BWWqEGc8J7q+XhkGp9GTUofu6Lo=;
 b=CgJhfB4MgiMACbrV3VKLthdOKP4rJpKOqe/nuy3crXozKmJ2rJrIs2CPBGYBE5plMu
 4stZa5DKtm+8EG6adzLgxBUIjUZafgdEuyl1WAG9Ums4vW9a/OSjrMezRHbg7zKXuaUK
 F/Hom304TCX7D+RNQIF6AcE4QW2nUGy4uTEhMLdxgwYpC0817DRjmrTSL/VrxYPim4Iy
 y+psUZ3qGbjPwJDVjekvkjxp520uGcAEN++m2VMj3TJ9oyHPm1RkyXtIlIBMontU/5N9
 iWeuo9e8w5Ciyfii5igO0871FZaOjh8oyuuXsBvlkiZ0bLHBbWtKkMkJbPva4Rvs6RTs
 qTGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776365530; x=1776970330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Jmfk/1c4mPbGvSI+BWWqEGc8J7q+XhkGp9GTUofu6Lo=;
 b=EeRE0cQJ+Z/gQJU2wnAxda0WbH9GxID9hrNcgebc8YgBkfGizuBFjIhmX2NMhVzKxc
 mBURgoT4MEj1zjhe+jT3Sr9m7DCS9/fcXxdOAju8i9BXCHElPgNeycDcNFygpxoMjL9U
 TNG1NAcwuAULF1Z6mH74GXvdW5QpzneEOQkNuCCGj4Uv4Ki/AVNn+zz0U/Es3O3dPNN+
 W2/tN0BkeR4IEkVxAzLffjKG8RNujdMQsRI2sEoLzyHPj40geEpCvHjy8gMIveycDje5
 clL/d9++uLxgHkeGSwpldg9LcW/H1ykhWcFpzV09m3VZIdJ4rhCHgW2ZZipI8Mabv96v
 BUOg==
X-Gm-Message-State: AOJu0YyAUIT/rTl16cXTSWbMBasrHtSRCvndXybFOUIwgwCODfY4fEIo
 am+Lq8UwjmJz21kYwjZaNAxzyZucE4Biaop1bnFGuDK22xcmYdijlX+pV77WSxqD5Dq6aMT87mr
 s+pbT
X-Gm-Gg: AeBDies2vLvs2DcHzCHNb0DEV76HOHu04JBpfOKkdkgjoYgWc1Bl3TnVRc3p+3/3kuE
 mZy3l775Ob7Fbe7Lw9mI+wBck0yefBDlDwZx8i4dub1aZ+Qzucy/zKNzIgzaP6Ztp2GJEoad7y0
 9mwqO32BXmB5tufhM++fUWALsjFPSN3pBIhVsA/Bv4hNMdn7GzLjs8iO5NqFdq/i15sYJNpOMTI
 40wK7cbQg0oZA2pYKBWmwSAyjT0aFNmz2SJBwwTxrh5Jn2Sln5LdryfSvb6K+Byj+QmdLTfYtsg
 8biCA2SM6PL+Tf/ZXKzbxuh2r1tJPpONBPx0cJJ5zskc7d51j3cOiZSwVHI6UaXOWOhkUQa/Y+G
 a9mf2M6+gR2sqt7M9JTZ/yZAEjV4ICEKFpPIFcy/2lbZT8hqlZdeIw3C2MARiqJz4stWGx98vr9
 /U6clxAQNMS8SgbH1PJITE3phEvtqF6I8nDSVkJtDUNdc=
X-Received: by 2002:a05:7022:2398:b0:12a:6e97:c21f with SMTP id
 a92af1059eb24-12c7276ecdemr267451c88.0.1776365529932; 
 Thu, 16 Apr 2026 11:52:09 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2de8f6615d5sm10602510eec.24.2026.04.16.11.52.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 11:52:09 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v24 22/24] net/pcap: add link status change support for iface
 mode
Date: Thu, 16 Apr 2026 11:48:39 -0700
Message-ID: <20260416185144.1359260-23-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416185144.1359260-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260416185144.1359260-1-stephen@networkplumber.org>
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

