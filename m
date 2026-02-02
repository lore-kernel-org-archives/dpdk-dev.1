Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659ECE7FDE0
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 23:13:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 316FE406FF;
	Tue,  3 Feb 2026 00:13:12 +0100 (CET)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54]) by mails.dpdk.org (Postfix) with ESMTP id 72C28406B8
 for <dev@dpdk.org>; Tue,  3 Feb 2026 00:13:10 +0100 (CET)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-435903c4040so3341163f8f.3
 for <dev@dpdk.org>; Mon, 02 Feb 2026 15:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770073990;
 x=1770678790; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rP20RBdekrnrAiqRHjHp+FzDu+Vf4BRA2uEYIMA9iGw=;
 b=mjZQNqBzKSl4N/pdWPixceVRjj0wnmGiYFGXKYnWYaXHodVeBQ88jZUy8jxfgNGmsh
 uaff3LEshJ2KOyx0CrxySvTnA3YF1qwrMmEjz98x6Z1qLqedfvYxmLwQCYPp3y2ebYKp
 fkTkJw7VnikJBkV8Bdxr76OYvUnKssEsozByYcZuNJnY8dwUorkoaPYcSd5u0xl/JdeI
 Rnolv9Y8LZb88rHGpwpnWYxJaxSSFhjhAvKfPE/VcA5OGrXQ1btEjx3Wb56YvqRZx+Db
 OHjJKiFZeBVmFQIQ7+n6QnwTQugNi9cYbcuTyZ1v9wuTzx646RNzhT0r956O4nDK3xNt
 ZZFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770073990; x=1770678790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rP20RBdekrnrAiqRHjHp+FzDu+Vf4BRA2uEYIMA9iGw=;
 b=HBbBLnLqtCbSeQhhgDhlLw0r7FThUmmxHkbqEX6fU1RrIS8cjI2O2JVq3RXugGxtzm
 w6IJxI/p05O94M7ZqP4WHlxUhy5Gapcdpnzrk8Pka+jOtcmFRJ5RD4I5/UeUQBdUIQVy
 ihpxIUIIAzR5W4q/XGtF4yGYLRP6+kM54WpDJSP00zLBqbBpCRSPoljokwdvU2c7Q/fR
 bsK+VDJBhbONOzTxNbiSM1mzYe6YIFc2SpIFuL1CKGL8AciZChZmw8DHmI2iSSfXAtbY
 a6V6NIDMutUkQrXRhD2GRLZk08ey7mzmICiD8bVU013C4vgcwRzwKPh5rdqwcNn50myv
 +lig==
X-Gm-Message-State: AOJu0YxZGQ2K652ALeqa6NtvA5FKXFfm3PyN2oK6+gbu2K3rU4RtRwb9
 OxHW+pvDTAP3RT0e7+h8TxQT8iNUyt37FJezXMfFpHUI+mf4HFLSGS/4qFKVqp9sgVfO0o/7Rhm
 mln/8
X-Gm-Gg: AZuq6aLR9gWiMgJMKrJDxEpANtiCCrKI64S0J61jQ3k4kcqT2ZqURTMbzmSQElIzqAl
 fde3xp8n4qy3kJOEiA4NP6DMYrOwRtv+dHGWkR3IgisV6HcHIFaTtSS1pygKsNIUNZoMz0SWAcj
 J1zA/f0SWgKal4QCkO3QfUHKTTi/Ci8a0qZDnv7K2No7hxQ2stb60pD8xG0ov773xOt/5w9jYkn
 SQXv4n+97fcUBfka8NYIIxYyjcZcFPpfzmqAMsA1TDdC2iTgEPidPR+6BD6AsrRAEXqUhi6jRyF
 1e2nMRXrIUtGXo3F1yO6tnrumFQW5zt7U5l2mpTFkc0IkTY++frGrPX/9N+6YoCKyV2Y874CbxO
 pa67MhNyiKiIQ/ucJDusCPZorHMm0pXD4GS3YFosrXKptIdoUUJWOTFt8AH7wHAsAiIM4pLb4dt
 73HKavxYwbPDfRfPF0ncI/byY57A8DYip0pQeOfo4FKJLfsV8oVg==
X-Received: by 2002:a05:6000:40ce:b0:435:9247:66fd with SMTP id
 ffacd0b85a97d-435f3a8687bmr19105128f8f.22.1770073990014; 
 Mon, 02 Feb 2026 15:13:10 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e48a6sm45799474f8f.8.2026.02.02.15.13.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 15:13:09 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v12 10/19] net/pcap: consolidate boolean flag handling
Date: Mon,  2 Feb 2026 15:09:13 -0800
Message-ID: <20260202231245.216433-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260202231245.216433-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260202231245.216433-1-stephen@networkplumber.org>
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
index d983135a4a..dcfd636fa0 100644
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
@@ -868,7 +869,7 @@ eth_dev_close(struct rte_eth_dev *dev)
 		}
 	}
 
-	if (internals->phy_mac == 0)
+	if (!internals->phy_mac)
 		/* not dynamically allocated, must not be freed */
 		dev->data->mac_addrs = NULL;
 
@@ -1193,29 +1194,19 @@ open_tx_iface(const char *key, const char *value, void *extra_args)
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
@@ -1682,5 +1673,5 @@ RTE_PMD_REGISTER_PARAM_STRING(net_pcap,
 	ETH_PCAP_RX_IFACE_IN_ARG "=<ifc> "
 	ETH_PCAP_TX_IFACE_ARG "=<ifc> "
 	ETH_PCAP_IFACE_ARG "=<ifc> "
-	ETH_PCAP_PHY_MAC_ARG "=<int>"
+	ETH_PCAP_PHY_MAC_ARG "=<0|1> "
 	ETH_PCAP_INFINITE_RX_ARG "=<0|1>");
-- 
2.51.0

