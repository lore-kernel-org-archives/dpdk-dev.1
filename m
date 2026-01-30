Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3661DD73EA9
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 01:15:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 80B52406FF;
	Fri, 30 Jan 2026 02:14:19 +0100 (CET)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50]) by mails.dpdk.org (Postfix) with ESMTP id BD1C440671
 for <dev@dpdk.org>; Fri, 30 Jan 2026 02:14:06 +0100 (CET)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-47edd6111b4so15961705e9.1
 for <dev@dpdk.org>; Thu, 29 Jan 2026 17:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769735646;
 x=1770340446; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F7HrpBKqgPlpoI4KBRl9oPgRacp7AzKW5xkVmWiFvZw=;
 b=mqNtHTAzafGY+V/IQ3LhbkRwDz3cY5wvifyENlCEg1R0Stug5GDYLMtAGeBY9QepGZ
 Dk/7qb3yK6sRhNS257ecggItw2LIklIIiijL9lvsIkR2C3awG9iBYfVOfS9Ylc1JV43s
 Kasb4gRVgyUym8HX5NGyqbY8bBiKotCzL1OWI/OI/2v7U4Cc3gkWxdTIRm4X4y0zNiIc
 5P5Esds1YK5ARtD7SjpFVnlXFmYG7gZBDaUPJcYajP3a21aUoF/V1cVz807n7Cyvd5BO
 8SCMniHEvHjEgnh+yiZTkExxI+B6DK1S8aJ/ZY8+mfNOnJJUx8avKjiWUfL14+xlWHUE
 V+qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769735646; x=1770340446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=F7HrpBKqgPlpoI4KBRl9oPgRacp7AzKW5xkVmWiFvZw=;
 b=nfIRTbhgEyfUhW5ZqX1P/dv3ruecTKksFfcQpX/ffuPRCSL5zk36IMQ+RvCoScj98k
 f4G4xtUDJIVWTVkTXmbMGtHN9BqLlGOuIVsk58hAjVqMgIdL3KmL7h2CWCVolQSauSLX
 9SPBoSyPqQn9D/u8YMvQLUVM1IcSjcCKp6AkdAUtMFckJO3qnzNGVgVwQrQaQ4qCrSp7
 tI6lK3EQHykb7IGMGck91z0HNS7lV57JRslU7Fv/pikuKSzofvIb5WqimUvvYOz5sK0K
 bRXlUbBSaNJGY7UvcNnVDwQOLVPfJ9AlLkmgKBIaWEsxg0OOI71tJncBv6axyD33QQJj
 QbrQ==
X-Gm-Message-State: AOJu0YwqTy2LS8Uj0xgx5l3NfzZpMIS9qTMFMUfFa+LTYQtm0fEMZNok
 vgvNCymBopieyWcSzUa2RzRpGiAUqe/NULKd25U+t+QcoDdEHPQwPrSDRyvIwQUou5cp27pmtcj
 EbwWk
X-Gm-Gg: AZuq6aJYYRmphYvJMFxvgmNSOvCtklGFXzOcRhvfXJdcLi9ZNFUGcLgdpE5fzT1+iZr
 fppgIDFISYLQbIU7UtbphOEsBDG+KMQo8QAMlpmDMeK7uFx7e8i4UD97YEMeJkt6J92Dp0mB5D0
 6IsEq6Sz4sAgv7EoiD73sk3nti6ggdxq0Qsz/J50RbzMitpcO0uBucD0K0Z2Ft7HluFNNr/E4CT
 P4BYiDTbAWT/76jxCBzpMSEp8CJeJCO+36/8JBo76/k3v88weFvLkmjgildZFRtNKyIflta2GS7
 lJcgC3hK+ulsNjnE/y+uVhUv7cdtzqul/Txf5dv0u0oL9cSZ/AkDaA2vzcuvtswe++mo5iADddG
 92Z943X9t+dliLLR1XtNHl6bqqT9jH0uh1dmnNb794Kh5ZTxX3yNJqS6nGGH9gzXu7mEcEQoMZl
 fJt5n3p6hCPOekEnwioGyuvOx+O+oZWt78kjaIjGxW6P7+73pmYg==
X-Received: by 2002:a05:600c:628b:b0:477:9ce2:a0d8 with SMTP id
 5b1f17b1804b1-482db013172mr13377055e9.0.1769735646337; 
 Thu, 29 Jan 2026 17:14:06 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-481a5e1d0f9sm2934825e9.18.2026.01.29.17.14.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 17:14:05 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v10 10/19] net/pcap: consolidate boolean flag handling
Date: Thu, 29 Jan 2026 17:12:26 -0800
Message-ID: <20260130011344.204233-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260130011344.204233-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260130011344.204233-1-stephen@networkplumber.org>
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
index bd33e72a02..201eb97745 100644
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
@@ -856,7 +857,7 @@ eth_dev_close(struct rte_eth_dev *dev)
 		}
 	}
 
-	if (internals->phy_mac == 0)
+	if (!internals->phy_mac)
 		/* not dynamically allocated, must not be freed */
 		dev->data->mac_addrs = NULL;
 
@@ -1181,29 +1182,19 @@ open_tx_iface(const char *key, const char *value, void *extra_args)
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
@@ -1479,7 +1470,7 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
 		dumpers.queue[0] = pcaps.queue[0];
 
 		ret = rte_kvargs_process(kvlist, ETH_PCAP_PHY_MAC_ARG,
-				&select_phy_mac, &pcaps.phy_mac);
+					 &process_bool_flag, &pcaps.phy_mac);
 		if (ret < 0)
 			goto free_kvlist;
 
@@ -1518,9 +1509,9 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
 
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
@@ -1670,5 +1661,5 @@ RTE_PMD_REGISTER_PARAM_STRING(net_pcap,
 	ETH_PCAP_RX_IFACE_IN_ARG "=<ifc> "
 	ETH_PCAP_TX_IFACE_ARG "=<ifc> "
 	ETH_PCAP_IFACE_ARG "=<ifc> "
-	ETH_PCAP_PHY_MAC_ARG "=<int>"
+	ETH_PCAP_PHY_MAC_ARG "=<0|1> "
 	ETH_PCAP_INFINITE_RX_ARG "=<0|1>");
-- 
2.51.0

