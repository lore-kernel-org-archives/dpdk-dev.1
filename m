Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F386CA5FE6
	for <dpdk-dev@archiver.kernel.org>; Sat, 17 Jan 2026 22:01:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D85742F1B;
	Sat, 17 Jan 2026 23:00:51 +0100 (CET)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48]) by mails.dpdk.org (Postfix) with ESMTP id 1253742F47
 for <dev@dpdk.org>; Sat, 17 Jan 2026 23:00:50 +0100 (CET)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-430f9ffd4e8so1901177f8f.0
 for <dev@dpdk.org>; Sat, 17 Jan 2026 14:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768687250;
 x=1769292050; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HS0Tl3pjdsVRlGR/MVKxP5mjdZlHD22x0tkLMYxDYCE=;
 b=e5vGD4CFcxQMzXX+OKxIUaie5+C1tLlPjG5twrrPZ9sbxllnolAKZNaQUYruUBBK3/
 o+TEsIrpA3Qk133Y+HlZRU3NX5idZm15JjqdF2KDVjCJa0TTCUesv14k7wWUqLWFxg+t
 9ENYefof4XUCg9m82FoGacpfYY5DhS5DUxYEGhupf8QzkT57eFv6gZBixaHn5Iz5EB33
 0PF3tbbF66RJsSSbPy8kGDiTxo8FKoklr5caOBCj5BqnbyiyijboPB9IfMT1Dw9YmD3O
 +CfvxFdI3OWh/WUJOB7pFdtfTXyDZGj2nR1GLGCLDLCfU32t1RvW7mFBHpZEd0/4lHtu
 +ZEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768687250; x=1769292050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HS0Tl3pjdsVRlGR/MVKxP5mjdZlHD22x0tkLMYxDYCE=;
 b=WoWQn7v/lc/LZo1iqQ7HlPNxx7Nf5SwGgZFNN4iGv3NFybG29Y+fYza+yCu8eOUqY8
 BRsAEFjlRFvQXgLLEnKRwGZOONNihCsBUkJFEAqtr5jzAfD8NA0Xl0EO0ISPAFYOX1bd
 YDsbdNRBimuDooi3jmHRFqQWMaUYnqi2+yDbSQditUbS6dCwAEFOA1AsdZmYMV7QaDgb
 7fZvjbvG8NsvksIJkNus5TS++CSxmKMeUcZQv/HxtZDOnhujIfU/0XUduw0dDNgdyKjJ
 vczgYfnRpEJlV47e4+jHRyx5mAgeQ+w+KJiPl+6Px/Nk1qEJ91TCY3uN7DFrxxSaFtPq
 YEUg==
X-Gm-Message-State: AOJu0Yw7wmbSO16/qXx7oX5FO500LCxVizu6mDG3T0VqO0Md8B3jpg7j
 8CyR0/JlyNoFW3rkk/ReVqSy98jFqds/NWVRgZGW1TIm/tyxiBvEzkIiZ11+JxmLJaDjYEhYXsI
 kxzKq
X-Gm-Gg: AY/fxX6EaOdb9ilGsJvLkZ4OfmS6lBrT65q5QFSkCIOrTOmP2BSwcQcHzt/LX2kM8DA
 NmHU51fHrmAFxeV4OFav/2xTkieEczgzT637uNONYbW3QvNqzv32gPpBWumVX8RcfiaiJisEi8T
 Sw+HcwKCmFDkYxnNWj5gq+8KzXYRGmdjUX8vhlP3gVtS4RrpcYV2RF4vPzcOBEiiEl0SVTD+pCj
 pzxR67q/JbkWvb6oFtxUm7DV5bIiexUpBGP8kTXzk2e/2J4wFGELiRNtfaWqrD6fkt/uIQD/A9G
 RXUTRBBR8UOaSSNor4YoaI3spMF8Wa/EpeZzAkU4Xq3UPzpTrQuukLWsFm15qyCSYUaFlUuRoK8
 S37tWoRW70XEiF6mnUjU9wXuIe6+fvnXUgdbj5sIvtIYO05TrqgK/f7ziI/y6s+XTfefDjzbNCV
 68gc5Eno7FAWKI2lWG0mTl9O3iicOt915KFKNyINkS6zMccKrSqQ==
X-Received: by 2002:a05:6000:310a:b0:430:f74d:6e9f with SMTP id
 ffacd0b85a97d-434d75c172emr14027610f8f.14.1768687249557; 
 Sat, 17 Jan 2026 14:00:49 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356992681esm13309352f8f.11.2026.01.17.14.00.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Jan 2026 14:00:49 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 05/11] net/pcap: use bool for flags
Date: Sat, 17 Jan 2026 13:57:04 -0800
Message-ID: <20260117220030.273471-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260117220030.273471-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260117220030.273471-1-stephen@networkplumber.org>
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

Save some space by using bool for flag values.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pcap/pcap_ethdev.c | 67 +++++++++++++++-------------------
 1 file changed, 29 insertions(+), 38 deletions(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 0c65a2dffc..62f073e214 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -5,6 +5,7 @@
  */
 
 #include <stdlib.h>
+#include <stdbool.h>
 #include <time.h>
 
 #include <pcap.h>
@@ -91,9 +92,9 @@ struct pmd_internals {
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
@@ -103,25 +104,25 @@ struct pmd_process_private {
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
@@ -871,7 +872,7 @@ eth_dev_close(struct rte_eth_dev *dev)
 		}
 	}
 
-	if (internals->phy_mac == 0)
+	if (!internals->phy_mac)
 		/* not dynamically allocated, must not be freed */
 		dev->data->mac_addrs = NULL;
 
@@ -1192,29 +1193,19 @@ open_tx_iface(const char *key, const char *value, void *extra_args)
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
@@ -1491,7 +1482,7 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
 		dumpers.queue[0] = pcaps.queue[0];
 
 		ret = rte_kvargs_process(kvlist, ETH_PCAP_PHY_MAC_ARG,
-				&select_phy_mac, &pcaps.phy_mac);
+					 &process_bool_flag, &pcaps.phy_mac);
 		if (ret < 0)
 			goto free_kvlist;
 
@@ -1530,9 +1521,9 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
 
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
-- 
2.51.0

