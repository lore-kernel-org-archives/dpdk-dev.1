Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B63ECECD6F6
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 22:22:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D1CA340697;
	Wed, 11 Feb 2026 23:21:55 +0100 (CET)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42]) by mails.dpdk.org (Postfix) with ESMTP id EFE0D40691
 for <dev@dpdk.org>; Wed, 11 Feb 2026 23:21:53 +0100 (CET)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-436356740e6so5144938f8f.2
 for <dev@dpdk.org>; Wed, 11 Feb 2026 14:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770848513;
 x=1771453313; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W7TBf4j1Q6I9GVIEbBS7yjiusRsA6Ii/B/IRvVLQMP8=;
 b=mh04pK3uCYzVWyGLbAxbMoVvAfzSJQMz25hBncnKZXkZm4IKu0behslTbf32fR3Uv6
 peUt6awZJccC+JBsKf1Uw1mJms1lAF7MZrORGAuxgZStq2zyXbFC6/3d/24Hpx/XQDFc
 6oo70aVNj6SjC3MMBTvL/4OeF1WAswtY8r7yEFT/kcBZmm3n+YEI6EfQLKqkIymmzNmy
 Pg7omQjHZ8r6TwyGFgjVNwfPekSEzCW1+hVnxKRVmzpbhoRlFhL1mg8igKYSvk+YEGdO
 2Gwb0IjkKsD6UrL/zZOHq/td8sWn/wwYv9lJ5lMaQx/zJo/iZ5Een6uUcmM8W2G10g3S
 LoGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770848513; x=1771453313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W7TBf4j1Q6I9GVIEbBS7yjiusRsA6Ii/B/IRvVLQMP8=;
 b=xSM1XANk8Yn6zV0rti6EWiruzZrMumChF8wAfZ0wi+/Hn6GmgZ2agYKBb3cgFoRJ4K
 rRwaeDNW6eCNO7vvyn+bIzHem5DTtlCfy6iuJr164WUSmOAJJ21ohMN9nOEOpgqvy97s
 hriKBuJAtALkPmiesv7JDCviSVHaX2L76BbyjMmmbZNlFOXl3t7+5vE9HgduShKsf1WM
 22qhBsGkQWdUcQ9RIVGruAKHP+/HarRmeVpS9cLLLyb1smplS9ULP8tJp+wz0UphG241
 H9ePfv7mz7rhKq3hy3tBNKAC6IJFYq3iRZIoKbw783+NKUJBan8NCmdgXIQIH4tOKlwX
 4xqw==
X-Gm-Message-State: AOJu0Ywmq3q6w/20yzqEIbx7X5TXsFiidFQgrCjVZEO6ZaNsRsY6Qwsx
 8ykxN7O5FUbpWrLTR3EiOeSEzxw2d98Pq1oKJqLi/ZcvPXNY1iYJx303LGDmWFdg9iOAfLmHX01
 PTbBb
X-Gm-Gg: AZuq6aKkrv7beeFv+7g9XGXLIQ30rHYeFKbx2mv+mcWT62wpz07RHgTZrywenFV1XCF
 r3MQtUDT7XindD6kXEnZLiOk8qQ2B2ckqyK5D8dq+0dSBUNnYmausHifmgwlPush/v6jOsVrIdJ
 78wnaB3jYvhzkZKfrSjMm4xqJln88mbPW+kWff/m7Xhin9MWwjCny7+qkFKmng9wPxgEMSKLSiB
 7s4Io49HxV9RTW+Qk/VrMQPwqidpoiio+0g5upRiCf+RBk3QGMdcmIKvsB3rDlljsGSOGuAOBgU
 cLLakW1sH2fLE5ERKc0Tja3BGfhrpHjRsJpBjvJ9/dvjsV+0SKrDUgzab8DmLJ+IaDgsCzyepGW
 N85L1agq20+6PD66hDXvtt1oybXYQPrLH5JtDjXAOc0qXz3e1VIMwy/NRAkMghmqehp6ZvlfNkx
 8D5ht5L95HJ/2cTc/TCL/kBZ93aFCXBPIVZqG0tz5G1MIpYVcaDLHZ11mxCgZS/Q==
X-Received: by 2002:a5d:5f84:0:b0:436:1707:2884 with SMTP id
 ffacd0b85a97d-4378acb1963mr1587973f8f.56.1770848513560; 
 Wed, 11 Feb 2026 14:21:53 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43783e0196bsm7877965f8f.23.2026.02.11.14.21.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 14:21:52 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v14 07/18] net/pcap: consolidate boolean flag handling
Date: Wed, 11 Feb 2026 13:09:40 -0800
Message-ID: <20260211222130.338797-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260211222130.338797-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260211222130.338797-1-stephen@networkplumber.org>
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

Convert internal flag fields from int/unsigned int to bool for clarity
and reduced structure size.

Merge the separate select_phy_mac() and get_infinite_rx_arg() functions
into a single process_bool_flag() handler. The new function also adds
proper validation, rejecting values other than "0", "1", or empty (which
defaults to true).

Also change num_of_queue from unsigned int to uint16_t since it cannot
exceed RTE_PMD_PCAP_MAX_QUEUES.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pcap/pcap_ethdev.c | 69 +++++++++++++++-------------------
 1 file changed, 30 insertions(+), 39 deletions(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 4761741edd..f6adc23463 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -7,6 +7,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <stdbool.h>
 #include <time.h>
 #include <inttypes.h>
 #include <errno.h>
@@ -103,9 +104,9 @@ struct pmd_internals {
 	char devargs[ETH_PCAP_ARG_MAXLEN];
 	struct rte_ether_addr eth_addr;
 	int if_index;
-	int single_iface;
-	int phy_mac;
-	unsigned int infinite_rx;
+	bool single_iface;
+	bool phy_mac;
+	bool infinite_rx;
 };
 
 struct pmd_process_private {
@@ -115,25 +116,25 @@ struct pmd_process_private {
 };
 
 struct pmd_devargs {
-	unsigned int num_of_queue;
+	uint16_t num_of_queue;
+	bool phy_mac;
 	struct devargs_queue {
 		pcap_dumper_t *dumper;
 		pcap_t *pcap;
 		const char *name;
 		const char *type;
 	} queue[RTE_PMD_PCAP_MAX_QUEUES];
-	int phy_mac;
 };
 
 struct pmd_devargs_all {
 	struct pmd_devargs rx_queues;
 	struct pmd_devargs tx_queues;
-	int single_iface;
-	unsigned int is_tx_pcap;
-	unsigned int is_tx_iface;
-	unsigned int is_rx_pcap;
-	unsigned int is_rx_iface;
-	unsigned int infinite_rx;
+	bool single_iface;
+	bool is_tx_pcap;
+	bool is_tx_iface;
+	bool is_rx_pcap;
+	bool is_rx_iface;
+	bool infinite_rx;
 };
 
 static const char *valid_arguments[] = {
@@ -889,7 +890,7 @@ eth_dev_close(struct rte_eth_dev *dev)
 		}
 	}
 
-	if (internals->phy_mac == 0)
+	if (!internals->phy_mac)
 		/* not dynamically allocated, must not be freed */
 		dev->data->mac_addrs = NULL;
 
@@ -1214,29 +1215,19 @@ open_tx_iface(const char *key, const char *value, void *extra_args)
 }
 
 static int
-select_phy_mac(const char *key __rte_unused, const char *value,
-		void *extra_args)
+process_bool_flag(const char *key, const char *value, void *extra_args)
 {
-	if (extra_args) {
-		const int phy_mac = atoi(value);
-		int *enable_phy_mac = extra_args;
-
-		if (phy_mac)
-			*enable_phy_mac = 1;
-	}
-	return 0;
-}
-
-static int
-get_infinite_rx_arg(const char *key __rte_unused,
-		const char *value, void *extra_args)
-{
-	if (extra_args) {
-		const int infinite_rx = atoi(value);
-		int *enable_infinite_rx = extra_args;
-
-		if (infinite_rx > 0)
-			*enable_infinite_rx = 1;
+	bool *flag = extra_args;
+
+	if (value == NULL || *value == '\0') {
+		*flag = true; /* default with no additional argument */
+	} else if (strcmp(value, "0") == 0) {
+		*flag = false;
+	} else if (strcmp(value, "1") == 0) {
+		*flag = true;
+	} else {
+		PMD_LOG(ERR, "Invalid '%s' value '%s'", key, value);
+		return -1;
 	}
 	return 0;
 }
@@ -1512,7 +1503,7 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
 		dumpers.queue[0] = pcaps.queue[0];
 
 		ret = rte_kvargs_process(kvlist, ETH_PCAP_PHY_MAC_ARG,
-				&select_phy_mac, &pcaps.phy_mac);
+					 &process_bool_flag, &pcaps.phy_mac);
 		if (ret < 0)
 			goto free_kvlist;
 
@@ -1551,9 +1542,9 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
 
 		if (infinite_rx_arg_cnt == 1) {
 			ret = rte_kvargs_process(kvlist,
-					ETH_PCAP_INFINITE_RX_ARG,
-					&get_infinite_rx_arg,
-					&devargs_all.infinite_rx);
+						 ETH_PCAP_INFINITE_RX_ARG,
+						 &process_bool_flag,
+						 &devargs_all.infinite_rx);
 			if (ret < 0)
 				goto free_kvlist;
 			PMD_LOG(INFO, "infinite_rx has been %s for %s",
@@ -1703,5 +1694,5 @@ RTE_PMD_REGISTER_PARAM_STRING(net_pcap,
 	ETH_PCAP_RX_IFACE_IN_ARG "=<ifc> "
 	ETH_PCAP_TX_IFACE_ARG "=<ifc> "
 	ETH_PCAP_IFACE_ARG "=<ifc> "
-	ETH_PCAP_PHY_MAC_ARG "=<int>"
+	ETH_PCAP_PHY_MAC_ARG "=<0|1> "
 	ETH_PCAP_INFINITE_RX_ARG "=<0|1>");
-- 
2.51.0

