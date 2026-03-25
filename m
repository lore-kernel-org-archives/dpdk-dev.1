Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B28103A99F
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 02:41:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D2ED40E4A;
	Wed, 25 Mar 2026 03:40:39 +0100 (CET)
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170]) by mails.dpdk.org (Postfix) with ESMTP id 9DC5740E25
 for <dev@dpdk.org>; Wed, 25 Mar 2026 03:40:36 +0100 (CET)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-2c0bb213b16so10840666eec.0
 for <dev@dpdk.org>; Tue, 24 Mar 2026 19:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774406436;
 x=1775011236; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+FntGUuayIiIG3a6l10GPMlr1kD9ux4MIQzJGx66yRU=;
 b=e8Pfw/pCTZgo0beDA2HqvXU/FByBsgUEWpId4rpAEKey/E9Av++MDaRzzXcsUklZnM
 fSS/vnU3MHQ0ncaZCqdy5EaptPxhv/jumbihILgQg3h9KFg14bVNFU4i2JE9eST+atV/
 DQ+vKMnSfXFG7Ij2i4kNhep90knhEMuNpshtxgXZgacSpWv8cZPnmEIhUdZ0pOVjldyQ
 KCoh0yuZuFpNQF/oFp418DL0I77FenHAhE3B+G3wJ+jlUXr2nTpdlihnqEluh2cLj4TI
 qm3lArWfCxY9ONnWTtn9EOm0uvLr2SlUcJIp8PM2FPi7rEbsRGyk+8aZfbA5ytxtYb1h
 YD7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774406436; x=1775011236;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+FntGUuayIiIG3a6l10GPMlr1kD9ux4MIQzJGx66yRU=;
 b=W7jU6X6z45PwvSMNaDW0xSj/LmIsmV1nFEZXEm5SnSMqg3BtztrAfOBeX8HT3fQ91U
 4U2s5MywI58Jgpqf6iuSgnpPs5vWsOLxDxRB4MHVgQyrt+rdtsy0+36+sVrZJ7Bp+Exs
 5gBv4I1gEX0IGYAAhzLgW5MMCytz/hqGvtaT7RF4LPNHGjURwdpRVA6iLIrj8DlTB5RB
 UHe6gpYdqa6IUAHusS3wgYdE7AakGk4KraUDsgrE36vBHloVI7MIy3NrdDeQFoamd4RB
 26W0ugd1kdn9rJNQC3oxu7manjV41qA7UiJbTRKpvcEvLcDwGAOReMVmOnIw/hb2sx32
 LaAQ==
X-Gm-Message-State: AOJu0YzHXkMLXwbtnysZatnBcvKq7fQpEdeCOXa7exQ6V/V4Prb42y4Z
 or4VyhXkEQNJHwCBm/9sspuGZyhi1mwcRQ1kk9oIUOrU+D85ovxDfo5V7RpzDw14E71eIFQU/Ur
 qw8bq
X-Gm-Gg: ATEYQzwEOyBlPaVfjz7xf5IUcUr/A1r3SiOUZ+XbImpBAK/z7r/cOCDhdQ7vsh3fV7G
 atly5ZDIM9GAVNBqgwMKtt+AOA5R6j08LCVdx2yOTPBCuJw3uw4O6ttGf2YZ1TNFZpqgby+AC0n
 ZP0ur5T1G0mjVLFYxkioXjd/0SiHXk7tXFT2CT3DHyH0wu5F4hAhk3gQP4wpjQYgldVnMa4FwBH
 +4qCYuVDyMc5hV9jH02Q9vt/Sl2vpOzdDpjeV9Nal5gzVZtTy4jgqCDPtjt3oFh8jJDwjFR+sIS
 tfmw/6BPWE2h+gblO1u8KE4iJsIOtHRPSEF89ObE5MG/XSjRK73yh5JFIU/GtoYOjXbo74Tzjgq
 YTSOVeMG9pv/4ZJu6j2V3vjsO7bX/9CuncxBb91WLl/gloQtdBJ5A+Uc8YgL07Bawq0tmitLpFT
 Gtgn5nQEJLkR0T/ZpAmOwqxbynzTODyr2S
X-Received: by 2002:a05:7300:cd46:b0:2c1:4a7b:9aea with SMTP id
 5a478bee46e88-2c15d3c9644mr978835eec.25.1774406435633; 
 Tue, 24 Mar 2026 19:40:35 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b29b447sm17209452eec.16.2026.03.24.19.40.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 19:40:35 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v21 12/25] net/pcap: consolidate boolean flag handling
Date: Tue, 24 Mar 2026 19:37:43 -0700
Message-ID: <20260325024018.1275209-13-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325024018.1275209-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260325024018.1275209-1-stephen@networkplumber.org>
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
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/pcap/pcap_ethdev.c | 67 +++++++++++++++-------------------
 1 file changed, 29 insertions(+), 38 deletions(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index cfdbf3eace..955eaf17e2 100644
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
@@ -881,7 +882,7 @@ eth_dev_close(struct rte_eth_dev *dev)
 		}
 	}
 
-	if (internals->phy_mac == 0)
+	if (!internals->phy_mac)
 		/* not dynamically allocated, must not be freed */
 		dev->data->mac_addrs = NULL;
 
@@ -1206,29 +1207,19 @@ open_tx_iface(const char *key, const char *value, void *extra_args)
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
@@ -1503,7 +1494,7 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
 		dumpers.queue[0] = pcaps.queue[0];
 
 		ret = rte_kvargs_process(kvlist, ETH_PCAP_PHY_MAC_ARG,
-				&select_phy_mac, &pcaps.phy_mac);
+					 &process_bool_flag, &pcaps.phy_mac);
 		if (ret < 0)
 			goto free_kvlist;
 
@@ -1543,8 +1534,8 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
 		if (infinite_rx_arg_cnt == 1) {
 			ret = rte_kvargs_process(kvlist,
 					ETH_PCAP_INFINITE_RX_ARG,
-					&get_infinite_rx_arg,
-					&devargs_all.infinite_rx);
+					 &process_bool_flag,
+					 &devargs_all.infinite_rx);
 			if (ret < 0)
 				goto free_kvlist;
 			PMD_LOG(INFO, "infinite_rx has been %s for %s",
@@ -1693,5 +1684,5 @@ RTE_PMD_REGISTER_PARAM_STRING(net_pcap,
 	ETH_PCAP_RX_IFACE_IN_ARG "=<ifc> "
 	ETH_PCAP_TX_IFACE_ARG "=<ifc> "
 	ETH_PCAP_IFACE_ARG "=<ifc> "
-	ETH_PCAP_PHY_MAC_ARG "=<int>"
+	ETH_PCAP_PHY_MAC_ARG "=<0|1> "
 	ETH_PCAP_INFINITE_RX_ARG "=<0|1>");
-- 
2.53.0

