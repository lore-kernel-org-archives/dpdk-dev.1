Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32859E83822
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 18:15:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CFDFC406FF;
	Mon, 16 Feb 2026 19:14:29 +0100 (CET)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52]) by mails.dpdk.org (Postfix) with ESMTP id D8DD440696
 for <dev@dpdk.org>; Mon, 16 Feb 2026 19:14:26 +0100 (CET)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-4359a16a400so3445676f8f.1
 for <dev@dpdk.org>; Mon, 16 Feb 2026 10:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771265666;
 x=1771870466; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZAcvldq2db1GFzfSKIMy+XNZ4M+bGHfRTGZlCgBbOLw=;
 b=xtP9dKnCQyL3o5crG1L9AXtpGZ/2N9hmWIpTfDz7Vyk/BDhYSOgr7gPNvK/h6QCPVG
 o9y2pdSdDvPGDSu824+ljdZF7zMuNk7LVEdfUhjvlf5JxO1IUwy0KoNVa7QihTRkuxuz
 AgQuJSSLWnOElaAmz+R66at+HVKn/yQXMKuhhciPv2XxaEPxfcg6W35VxSyqMuKoavUH
 lj+C1pXsziUa0cXNE4SutLLg19ca6Hplm7HYTq+L7sNWrNJ9we3GfC3YSvEptcFAz9+c
 k4nZUrUgNMyIt6vGQPCvzASOIe+tKqNWq6vv4pcOas/gxcIb1XfCkKcn6ycWkzwKVj02
 lN0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771265666; x=1771870466;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZAcvldq2db1GFzfSKIMy+XNZ4M+bGHfRTGZlCgBbOLw=;
 b=tThFDdAKOVaCBMspGnEG5ieTbApute99yBla8Zs6TA6jiWsxYeR1tkZDHQLDSeh1wq
 HUGfjO2+mOZKxOS/jTKpqTWKNjIOI0UuLFWwDAxUfuPq++Fai3ZLkRHVselr2I96SzGb
 h4TjXB9nZqp8iAnszsOG9hG2GCXmqH3ulzplimrEI13rDR47KDB/017gx+OZaJwoOPvy
 kzR5FYNhtge4m+If6xyXkabPCUZq1H4U5BaE1bmt4ZfiQBltuBJBpxl1Hb1+Cc5+RKkQ
 +xRfOf9LMKGQUBXNWohbRStQwBcT0RIh+8EuY+baatHes7v41e1d3GIPNHYWoJzLggVw
 KsuQ==
X-Gm-Message-State: AOJu0YzZEMKvPBqELdfbBxEv83TEGXnBosv17gAZNSq4vsiXci36XAX7
 7sTBu0hkva5lLt/vxkX+8YC1EekMLRbHOGRJ44YuWb3FDafDJzlCQlWBOXewLB6eMrOF5jhDQP0
 TdDCTdho=
X-Gm-Gg: AZuq6aKnrfQTuypRDAQcLYIaQbYq4onzbJ+6wLRzNEvXZ+qHKuIG1WpEIuuPn2aFY4h
 ATH9UJ9rcpa6e3zxsMXJzD2KeEOl2yhiG5sVaScoYTz8eVxy0562YHj7CS/1xsqa+bco4A4SWUP
 fsOFw7ScJ35GpeuQa8CUj0pvF1dtJoQPbulD9RjHikcOx9dl8Wy2ekEVtNNtqNRtnGMtrup2OBH
 5zHC9mWiHp05SmQeYSfpKIpnuJwBrdPQnC8DTnjWgteEntiw7ewwnrZsvL/dotzEFnSMcB5SKtJ
 NsiOcwsir+8MdqVvbples5Lw7y7UVfHtcjzW5+6zwX6+uIcsrx99adnpTY6JsbeZ8d1/I7t0Kju
 8YAa+luAWUA+bsc4tTL+VkjYqc10POcCfMZmPGiy2E8ieKaE3spNobSZj2RNs56K1QA6J0j5n8f
 lHV+fv7qSGNKGSoE7OcO0N1KPiiuQVZjAIHbv7Q+wrzGMalgj6GgX7I7hM5htNsqkAQ9/k69+a
X-Received: by 2002:a05:6000:1acc:b0:437:678b:83c2 with SMTP id
 ffacd0b85a97d-4379793eddamr21484344f8f.54.1771265666352; 
 Mon, 16 Feb 2026 10:14:26 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796acffcesm26064725f8f.37.2026.02.16.10.14.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 10:14:25 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v16 10/21] net/pcap: consolidate boolean flag handling
Date: Mon, 16 Feb 2026 10:12:05 -0800
Message-ID: <20260216181407.428877-11-stephen@networkplumber.org>
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
index 8162e611e4..2742e0ca80 100644
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
@@ -102,9 +103,9 @@ struct pmd_internals {
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
@@ -114,25 +115,25 @@ struct pmd_process_private {
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
@@ -888,7 +889,7 @@ eth_dev_close(struct rte_eth_dev *dev)
 		}
 	}
 
-	if (internals->phy_mac == 0)
+	if (!internals->phy_mac)
 		/* not dynamically allocated, must not be freed */
 		dev->data->mac_addrs = NULL;
 
@@ -1213,29 +1214,19 @@ open_tx_iface(const char *key, const char *value, void *extra_args)
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
@@ -1511,7 +1502,7 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
 		dumpers.queue[0] = pcaps.queue[0];
 
 		ret = rte_kvargs_process(kvlist, ETH_PCAP_PHY_MAC_ARG,
-				&select_phy_mac, &pcaps.phy_mac);
+					 &process_bool_flag, &pcaps.phy_mac);
 		if (ret < 0)
 			goto free_kvlist;
 
@@ -1550,9 +1541,9 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
 
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
@@ -1702,5 +1693,5 @@ RTE_PMD_REGISTER_PARAM_STRING(net_pcap,
 	ETH_PCAP_RX_IFACE_IN_ARG "=<ifc> "
 	ETH_PCAP_TX_IFACE_ARG "=<ifc> "
 	ETH_PCAP_IFACE_ARG "=<ifc> "
-	ETH_PCAP_PHY_MAC_ARG "=<int>"
+	ETH_PCAP_PHY_MAC_ARG "=<0|1> "
 	ETH_PCAP_INFINITE_RX_ARG "=<0|1>");
-- 
2.51.0

