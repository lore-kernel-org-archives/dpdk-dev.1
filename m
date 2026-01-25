Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64553E63CA4
	for <dpdk-dev@archiver.kernel.org>; Sun, 25 Jan 2026 19:24:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3596740611;
	Sun, 25 Jan 2026 20:23:33 +0100 (CET)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49]) by mails.dpdk.org (Postfix) with ESMTP id 0D5CC402E8
 for <dev@dpdk.org>; Sun, 25 Jan 2026 20:23:25 +0100 (CET)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4801c731d0aso29943795e9.1
 for <dev@dpdk.org>; Sun, 25 Jan 2026 11:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769369004;
 x=1769973804; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZcLYPZSN50PLk6pnpFzvQWwBIrWrBhI1Hy/FjKH9U54=;
 b=D2tAPsCXLQoIys8dGFjwePJ4FM6k/aqDBzwagpYC30vHn6n8JFcDiRIIDXKH4RHTAn
 sH5ry652Ehv9TNrqllM5AEDuVd17KjAV6OCpImq8iWzpv3pUym6yUkU1MVggsOBtaWTO
 UdFZ9fQX4uNqETUp7mpbIXtfga5DP1r8XmbWDpPx7Rt//5Pl43pG7M6jJB0Ipbglmt/B
 /WbgcDEIia08VGNTx8ArNxXkEQ+RHg6fNhr/pH5jXDAUrNHPKQIXDtIxhBay9qfWcsVm
 rZRcQCZYPmwBgNRnJlLBWjBHZdaNHj3YOtG7WsoqFihKb30JRV1qLOjZtag0Tp0/24xg
 86NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769369004; x=1769973804;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZcLYPZSN50PLk6pnpFzvQWwBIrWrBhI1Hy/FjKH9U54=;
 b=Da5DT44HDrpleLp10yaoK6xWpHDMOILgOHz16aOc4cFYsrffXXrcnkVhwKBWNHW59S
 +NmmnugVDsHzPtFbCmDGNz6B4DWoAY0bntW25JprEEplUedYsfsCxlvJXYwhpI1zuemE
 j+A3q3agzTODLQsreXdhSBNju4wtcmMJq4yW8y/jbhROMkyDr8cnm/lwxQyCXahDwZ00
 TU1OoHFBnQlYlvNX74tvQ2sWcFHq3MZH38qttgK0gvN8wL/9S2tNPtOZaDCiYgvCwnuG
 d6+ZTOp3Yd7452HmxHxM366GNMML4xD4njtUy2GpgeX2HZP/VJYvq5Fk/N4GEeAa67bS
 LHmA==
X-Gm-Message-State: AOJu0YymwK7srwyHuQgnHnu1J6ZdsnShnSklLebaknAnKDVUd1ihAopQ
 pdT9RC8LcyNaIhrhTHQWUDCYOF8DyVnxVcCUoFS6Pm95XoUMw58x5GaWZiplK2q+NZ7cUesWS6A
 4BPw6
X-Gm-Gg: AZuq6aJaMQdMILuRDlzxZY/JWbqi7tde4Ve7B1j0dk4C0LGg9ev/nwd8TJARPMwONNQ
 O3s+I8SvlFPVm+kAvefI6/yIDYUdcXPnARRTOQ/Qljx8f/Rj3zkuM8gnVAi9ZSpH8iKXg8JLQtZ
 hRGHFfcDLX4r8O4YLbjo2Gw64BUr7un+/zfXybawHllGCiTjV2uSQo/dpZjdsAgih/tlm/Arc+y
 bAdB3IVMbEs4KznWCxws9dfUFCcSIdUgNDYR6RYRuzLe3hLiGBt6GCvZAEoRSpgy8j8YR+twrTZ
 sUFqI5CZcYKnvqawLEdq4zIlBVtlw97XYmcpHi5MitlMRn4XZMwVxp6nhbPkPe57SC3hvN2en48
 b8sgYG6558mcwX8FWO8MZqMCxY1RfpZHwA8FHzNonM5jxXzDy5vuz6iSbbfiVH0DYguujpqogTf
 XkaIy65aO907tuvRhBTbgc1zz8fHPkGvYZ7WLY4itZ8tjNw38nCg==
X-Received: by 2002:a05:600c:6812:b0:480:41f2:b212 with SMTP id
 5b1f17b1804b1-4805cf665e7mr39007105e9.25.1769369004538; 
 Sun, 25 Jan 2026 11:23:24 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1f7b4d8sm22854362f8f.38.2026.01.25.11.23.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jan 2026 11:23:24 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v6 08/13] net/pcap: consolidate boolean flag handling
Date: Sun, 25 Jan 2026 11:20:06 -0800
Message-ID: <20260125192248.497563-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260125192248.497563-2-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260125192248.497563-2-stephen@networkplumber.org>
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
 drivers/net/pcap/pcap_ethdev.c | 67 +++++++++++++++-------------------
 1 file changed, 29 insertions(+), 38 deletions(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 54f71fa17f..9ebb9c8633 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -6,6 +6,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <stdbool.h>
 #include <time.h>
 #include <inttypes.h>
 #include <errno.h>
@@ -99,9 +100,9 @@ struct pmd_internals {
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
@@ -111,25 +112,25 @@ struct pmd_process_private {
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
@@ -869,7 +870,7 @@ eth_dev_close(struct rte_eth_dev *dev)
 		}
 	}
 
-	if (internals->phy_mac == 0)
+	if (!internals->phy_mac)
 		/* not dynamically allocated, must not be freed */
 		dev->data->mac_addrs = NULL;
 
@@ -1190,29 +1191,19 @@ open_tx_iface(const char *key, const char *value, void *extra_args)
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
@@ -1488,7 +1479,7 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
 		dumpers.queue[0] = pcaps.queue[0];
 
 		ret = rte_kvargs_process(kvlist, ETH_PCAP_PHY_MAC_ARG,
-				&select_phy_mac, &pcaps.phy_mac);
+					 &process_bool_flag, &pcaps.phy_mac);
 		if (ret < 0)
 			goto free_kvlist;
 
@@ -1527,9 +1518,9 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
 
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

