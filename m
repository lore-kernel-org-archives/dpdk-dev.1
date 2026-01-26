Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D536BD1950F
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Jan 2026 18:08:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C982040662;
	Mon, 26 Jan 2026 19:08:33 +0100 (CET)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51]) by mails.dpdk.org (Postfix) with ESMTP id 638AE40648
 for <dev@dpdk.org>; Mon, 26 Jan 2026 19:08:23 +0100 (CET)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-432755545fcso3548237f8f.1
 for <dev@dpdk.org>; Mon, 26 Jan 2026 10:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769450903;
 x=1770055703; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R2ZsTfEtjVr5WVlJGT32K0K2cXqnhQOwK6vCHp/sEzA=;
 b=jJeFS1hVYmaFNbF+unPmdBvpHgz47Iwe+6qoqUS/u63bkBE/KZw7ypLkiZ7imz42Rs
 sGE8QtrRsSqCXiiJJGMJ5G/G5OtfUN9MPP0WEKIIf9CJadYP+TWZF5mAl+kcX3W3fbS6
 7FlNbXcqrbFfc+BnsT1Xj4ewBjiBcx4QeAySkDGPkZP42nSysu1v1iGWCHiaiXVga/YY
 Ru6m3OnfEJ3LxxfHkWE9rgvfvpgOLHmgyagkix2XQbHjPFVD+Ugd5+WT40AtJRmVvrgO
 ty5R58ua/fNl/BzVgzQX5dWYuImRHdBYckKMJZlIRrXCI7rlKWNvP0GaX3BivJq+EjTc
 G7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769450903; x=1770055703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=R2ZsTfEtjVr5WVlJGT32K0K2cXqnhQOwK6vCHp/sEzA=;
 b=iCCO6kXMZsUNSdnP8YyowQStWyrW3oe7Fh/VOcMEBlw5zte3jSem8hNhgx8yq5KJP4
 vKaVIKjtnWOFjlVarM7xUpS2cL+0JQBz+mf/MEVL329o2ZgtjqpPqQCYLlsSTjWrNzWB
 AZwR8tq0IWH+6yYmtzo1qXNo3lZmzQp/M4Kwxoaf3eY++cmimmfosSZTmEl/V2s5ew56
 K5Qe1ZywQStMLTIT0epvNKhkUPDwIkB9wTpO1X698QdA3/QHCeD/+kW6z6qJOz0+nm4m
 2/g/URut5nsWI+EmLogn/SC+L3rxPdgxsXDJ2INmx7g7gWyE+XEXq583vhBta2pnbG4z
 KfLw==
X-Gm-Message-State: AOJu0YzS+fvilv2TLSD0/ZmHnlYENfoI3b3zOarRFCaxhv4g6AUh/v7S
 j29Ml5GnQlW5RCM09B4hB9V3fs0fkC8Elh66G3pgCSQbXr8mvRw1/m09cMx0qmN34N2mykYGwLk
 tj3LK
X-Gm-Gg: AZuq6aIgVTL/9hzVCQebI44sJ+5SStgOZxX0FRycnSJFeZUdkKrz7aaevd0v6oJz/SD
 Xq8WUS8+Zcklk5LxsUeYzHEb2tRkQjrGeedVSKkrN+64we6y6xOyFQXS73GX0tC/rLF//geznD9
 fvCJFRvnnAMXAM8i4jimK1xp0D4HHR/qtl/kJlTn6IsotWOzTBzjQVCLEh1mH7gvoONKFRHVloA
 ZmMHntpb4zNGI2GpustTdWvHmJvkFkuJupWfns3fjInqivnJypSxeJvDC8zgpmiE9yM8SboD4FS
 XxLFxkdGuT9QcnZMb7QNcK31LzbC0vtQkUuTGHhR+6U3wH+zVcf+2qEoTtFQWO2EyiEX9A/1OB1
 1iEwg1DAODy/SybeSFtwxvBY+l8i29d8b+ID4mGBCOI6AbnyPV8/5ZafjR22e/RXao2sNkyQNR8
 JcZOwp0XQXNbj4Qicpz2k3eauAl84ZXrhj5zXZlir/hsKPueaH3MiAl1XpNHe4
X-Received: by 2002:a5d:5d0a:0:b0:42b:3806:2ba0 with SMTP id
 ffacd0b85a97d-435ca0dd74amr7978596f8f.2.1769450902940; 
 Mon, 26 Jan 2026 10:08:22 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c02c91sm31845864f8f.9.2026.01.26.10.08.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 10:08:22 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v7 07/13] net/pcap: consolidate boolean flag handling
Date: Mon, 26 Jan 2026 10:06:44 -0800
Message-ID: <20260126180807.100891-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260126180807.100891-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260126180807.100891-1-stephen@networkplumber.org>
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
index 537d66ed30..641d345df4 100644
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
@@ -867,7 +868,7 @@ eth_dev_close(struct rte_eth_dev *dev)
 		}
 	}
 
-	if (internals->phy_mac == 0)
+	if (!internals->phy_mac)
 		/* not dynamically allocated, must not be freed */
 		dev->data->mac_addrs = NULL;
 
@@ -1176,29 +1177,19 @@ open_tx_iface(const char *key, const char *value, void *extra_args)
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
@@ -1474,7 +1465,7 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
 		dumpers.queue[0] = pcaps.queue[0];
 
 		ret = rte_kvargs_process(kvlist, ETH_PCAP_PHY_MAC_ARG,
-				&select_phy_mac, &pcaps.phy_mac);
+					 &process_bool_flag, &pcaps.phy_mac);
 		if (ret < 0)
 			goto free_kvlist;
 
@@ -1513,9 +1504,9 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
 
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

