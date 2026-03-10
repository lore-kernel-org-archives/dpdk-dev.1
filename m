Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A95ABFD4F04
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 16:17:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D3DB4111B;
	Tue, 10 Mar 2026 17:14:29 +0100 (CET)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com
 [209.85.210.41]) by mails.dpdk.org (Postfix) with ESMTP id ACBFE410DC
 for <dev@dpdk.org>; Tue, 10 Mar 2026 17:14:25 +0100 (CET)
Received: by mail-ot1-f41.google.com with SMTP id
 46e09a7af769-7d738fe814cso3174109a34.3
 for <dev@dpdk.org>; Tue, 10 Mar 2026 09:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773159265;
 x=1773764065; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WV/zCfNjskTD8OmXm2jdXHFdAn285zXDNC97lt3eQbg=;
 b=0cOSq6x3hSZhEpph0W1nmHBiXdqxf14wMXHM25c2PG/9WdOL0rc1249eDHWWTPbjUj
 4P29UnqBpnu8uNlcHkuNTJZIXtynYTd2Bq1T8zbc6F0C7vjeO9JNOOgZBDgXxJ6sNWtu
 lwZQssreid7bS8/G3t40j/vCL+Oq9raet0rorQwX+cDMlfYkdD2pE6ZBx8aumSsulC0q
 /PvZhLiOIJG+vzG56A7SMlU+heDiPOFRS5RdCdt278AhIwoiU2Gk4yDmEtgXVlEnpBBF
 fksgbGL4VZKxFCnNE7Hn6GhAbphda7PsXDg538zxSk01SwFNTJklZ0AMo1A47iMv3keP
 pZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773159265; x=1773764065;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WV/zCfNjskTD8OmXm2jdXHFdAn285zXDNC97lt3eQbg=;
 b=Ee01KJQ77YJlylmioDjgt/VYRlWlOMKcczEzUdj7PkBKw2/ZOZg4y1748B5oOX8pdY
 441l0k4pHr08Ueri/VHv7reG/HTb+dlGLX24DSGfD4EDvUAb9369lXt1n7/VxsGXTDQ+
 xJzzPc9X1/lC+ueiSw2PEW5cAeGZ/lWZyCAxDGccoc8v3mP8IP1s0SdE7zgvDgE9ntI4
 rR9DEzIIdrQ5UREAyfJ+Y5+pe9kEK/RPsJlmsHQv2G4vhuVAWESEuPEOpmo1lvcYOvPw
 fWMUeJjLcEV52U0OoNkFKHmj58ztTS86LHU7pWQDkj47d5jjxeBs72b/yh+Ozjgx9LAp
 btkA==
X-Gm-Message-State: AOJu0YzOlCsCYWE9vjUEofu9VRjwnaUiop5nGHf59TAzbliUoZaj7VdA
 PEU0BS2OG2vtQddbrKvFqufEQoemcpmsF3F0x6MUFteCe/Sxr7IczNzrwI+pM/hLfaMJ65pu60N
 g/fKnrzc=
X-Gm-Gg: ATEYQzxDus0IdLI5UcG+Vh1b/cqx7kgORGmQSlHokfkjtjBX4aT9X8lWo/I8yqGUHvI
 3+TLIJxkZVcp3vzmDstZwfjkPEAbKdUE3If4GSqICm91LGpmcAl/UD4QQE+tfHO8W4/7lpJZIsk
 jZafgirDREDXKIRNgV/mAtQnqJS/9WKazAPZvJsptIpwoWOJixlOIlYpx47jEtkv/oE360y9CPH
 9a21pbzfpyv+oiRHDr+w4mJVVTnz4jDo4+amxTklJ6hu9mS/xSEt72V/xmjE7hcwFVG7WZA4RP2
 X8cy3mFw49hrPquetGFjEj/LxJ1gCLC2dlxJAyxEhZQ8z60jP4Suj2YeMo4ByWchtGp7lplnPAV
 Qcq9P3HqfxzHyK2EsVqnE1CjwV5uFIXqDUGm+DiMs/5L4f2egXjiNLEKINwR6TLZcaxvmX53WVK
 vgXNvPFYbQGFsFsq6MpEPKCsZm3vEA1UUZ
X-Received: by 2002:a05:6830:2650:b0:7d7:51af:4aac with SMTP id
 46e09a7af769-7d751af5552mr3190404a34.30.1773159264803; 
 Tue, 10 Mar 2026 09:14:24 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d738e3f421sm7304004a34.25.2026.03.10.09.14.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 09:14:24 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v20 22/25] net/pcap: add link status change support for iface
 mode
Date: Tue, 10 Mar 2026 09:10:00 -0700
Message-ID: <20260310161356.194553-23-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260310161356.194553-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260310161356.194553-1-stephen@networkplumber.org>
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
index dc3a0fa81f..d1bc6ba493 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -124,6 +124,7 @@ New Features
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

