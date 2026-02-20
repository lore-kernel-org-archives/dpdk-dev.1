Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C154C54EFC
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 05:49:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BDBCD40A6D;
	Fri, 20 Feb 2026 06:48:54 +0100 (CET)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com
 [209.85.222.174])
 by mails.dpdk.org (Postfix) with ESMTP id 9B2DF40677
 for <dev@dpdk.org>; Fri, 20 Feb 2026 06:48:50 +0100 (CET)
Received: by mail-qk1-f174.google.com with SMTP id
 af79cd13be357-8cb4136d865so204657685a.1
 for <dev@dpdk.org>; Thu, 19 Feb 2026 21:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771566530;
 x=1772171330; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v64Ft4t93JFRbOxFNwFvPXWAOnHyg5CuaZq8G8s9nmw=;
 b=lVfUKn5OfPstQMTM8Qhws4Q4ca6TCVo9olaNGyn1lI4rzMktNSkVQyqC72kfPHI36G
 7OnbHFzAksNUWYBfSO3IzGoTCxnMna/JvMdos4jzzkCbBpd67Wq8bu7kFMalazVbxFeK
 81jcFTZKONncRLlbj4s0DxNyBmtkpOVn9xHNwbd+fTP/bO637sa3aPJGPh3WclOCacbb
 jzykCxw5tScN5X3Hz52t1IHl4IDmLdTOTSJ+rHAxaQ+CfNGNVCNjujkLGTpoPn6ZPM4D
 jnbsaiwqy3SzSDTFuxkZvplInIVqGckrBr3MMKM3EX8HmrQimkEuJKGukRrVCQQg56Dh
 NBnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771566530; x=1772171330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=v64Ft4t93JFRbOxFNwFvPXWAOnHyg5CuaZq8G8s9nmw=;
 b=kQw8PPbZ4HRxEM6PISvTbs8EfCwI25UPZNFiqINK+RjFokt0eTJe/J0dOv0jf2bwvJ
 DKnlwrb/EIm6UkPCbmODj5OT3tE9zUo3Wq4zvvBu+KkN0rmLwakgVZ5p+cXGAYV6UYPq
 NVmdCASD9M9VtRfajzx44ycGZ1dv9qdzpnPaDfGGo1BkTP2QdEs94x20B2trygBEp9cN
 7HtGj9naK8hQVqqaQUIPEkHM55gTa6fG5bM+5DgQJKIXRwv1XsY+gJmDy8Q6kAw/YPxK
 Awklq7hsbGAiCH3yfxKIHVOUmHEnONqHW/vkNZDkdKX6B79rov7mHUeIneJFQ794vBrJ
 mN8w==
X-Gm-Message-State: AOJu0Yz7K9haR6zao2bp+dLO2PzcUdtp87lJI0+601RlaKL36QliJM2A
 Vog7kyUttT6OwgDv/YrHKohZVxdR1gtrvitgxnabvveGtCaVP5TBbfLXCcJU80zQNM6Lbzw9NrT
 AowZ7
X-Gm-Gg: AZuq6aIFs5x7aGQ5sDYevEyb9K5QwgDAwLz3HB+kPcHPZmzBiJ2E9FxUW0e2LZHvskJ
 w2S9Id8zs3BQ3aiWwvwmKp86lkDlbxpErqB4I2hk4IXGDqew9RkIstXHkGd/UfbtqNBV3GKaef4
 RmAA1cxXbnSxNc7J6R9Q9MJPxF/METmvd/krwCdAi+2NFlM1hdDlUjPKJzlHq1HGGYmgvXkhwit
 9xvTFmgY9G8HdHdkLNEwM+qOtGt/POt9+titI+SE4iQ7AQ3xY2SRzTnxkU570V3qFBXhH0xrdOz
 l+CduE0R77SNaoMp8C6EmIRHQ1ejCBbIBywqRD92gCY1NEde3VOsTE/E6R1WiIsg5jVQLI0hhga
 YAkLuCzongqsFm7B1Fw9Tua6QVxyXQh3xXUpXulahiIM9b8FXX2UPqpKYUpbT2vbKEKo7dpwNh2
 x1DJxzseOhPYNmzeVMm1Qx3NnOzlcV6g1osEMnmUkJOVLGIjE7qYKEX3egGPWqBg==
X-Received: by 2002:a05:620a:280b:b0:8c9:ea1c:f218 with SMTP id
 af79cd13be357-8cb4bf97d39mr2508922085a.15.1771566529823; 
 Thu, 19 Feb 2026 21:48:49 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8971cdad6c1sm229078096d6.39.2026.02.19.21.48.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 21:48:49 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v17 11/23] net/pcap: consolidate boolean flag handling
Date: Thu, 19 Feb 2026 21:45:46 -0800
Message-ID: <20260220054834.1632201-12-stephen@networkplumber.org>
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
index 5b59e9d813..a2f0bf5687 100644
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
@@ -890,7 +891,7 @@ eth_dev_close(struct rte_eth_dev *dev)
 		}
 	}
 
-	if (internals->phy_mac == 0)
+	if (!internals->phy_mac)
 		/* not dynamically allocated, must not be freed */
 		dev->data->mac_addrs = NULL;
 
@@ -1215,29 +1216,19 @@ open_tx_iface(const char *key, const char *value, void *extra_args)
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
@@ -1513,7 +1504,7 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
 		dumpers.queue[0] = pcaps.queue[0];
 
 		ret = rte_kvargs_process(kvlist, ETH_PCAP_PHY_MAC_ARG,
-				&select_phy_mac, &pcaps.phy_mac);
+					 &process_bool_flag, &pcaps.phy_mac);
 		if (ret < 0)
 			goto free_kvlist;
 
@@ -1552,9 +1543,9 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
 
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
@@ -1704,5 +1695,5 @@ RTE_PMD_REGISTER_PARAM_STRING(net_pcap,
 	ETH_PCAP_RX_IFACE_IN_ARG "=<ifc> "
 	ETH_PCAP_TX_IFACE_ARG "=<ifc> "
 	ETH_PCAP_IFACE_ARG "=<ifc> "
-	ETH_PCAP_PHY_MAC_ARG "=<int>"
+	ETH_PCAP_PHY_MAC_ARG "=<0|1> "
 	ETH_PCAP_INFINITE_RX_ARG "=<0|1>");
-- 
2.51.0

