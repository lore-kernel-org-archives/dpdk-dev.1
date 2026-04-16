Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59EDAF8D765
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Apr 2026 18:52:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A11240A87;
	Thu, 16 Apr 2026 20:52:05 +0200 (CEST)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178]) by mails.dpdk.org (Postfix) with ESMTP id 96DDC40A75
 for <dev@dpdk.org>; Thu, 16 Apr 2026 20:52:00 +0200 (CEST)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-2d96243c91fso2129239eec.1
 for <dev@dpdk.org>; Thu, 16 Apr 2026 11:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776365520;
 x=1776970320; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+FntGUuayIiIG3a6l10GPMlr1kD9ux4MIQzJGx66yRU=;
 b=z9KkYeGgcwI3xNWQ7RS8zUTewEH1qKyF3kWoap0jYn3gfXzG0fdYeMbrItjDGFpD8p
 A6gquQzF03SU6xCwerGyn0kDkeZh39EoMcMR5WV9Aibr12qdDnxk6CKORTsArhwGiWfs
 pwRiF06UsyX/zdWBWmN0fuLKlGvYUydhqsOjfAlk3/2IhUQ1cUKDA/VeNHwf5SK0lbCS
 Oe4jVYoym9aav+62+k37HHU6+EgjzvwcH3qq/mBITqA/OJ8YUgAI3DLV8xIU3PVAI4Mx
 x8OztLIyjz2SzYJ75MBxtxZEiTwWGUWWkaH2pd9IfWA7vuWBjlkPxUDwonnYOPy2BCyW
 F5FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776365520; x=1776970320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+FntGUuayIiIG3a6l10GPMlr1kD9ux4MIQzJGx66yRU=;
 b=n67tl1Rfp7ZHi6ygGPtKki1BLKkTDKhoRy2SW2IHv3DcAh6qXKNb+1mGarf1rlNaYJ
 E/0yKrX2enJ5ZoMOEhIE+Uhpf9EHYRPJrKk3Ffqjs4Gp6DDpu73qpgkQDnEsV3ohB20F
 XZvKcA5S7CoLBQR0rxbUOiRyL5CeTjhU31KKJBj6dHe0OOCIQtFvKisHOpq6cgfuvzUF
 QHERNLZuiR/LogesVKPqj5ixortjUA03JhDKRBze1J2ltefabhtwG9eh1cd0D3UY7Mw7
 c5LRPsbd6IDCq7Rthd774UFPye5xX9epVyVZJaALAD3NTz6y7N40ob+2hOusJEL+hrTp
 qL4Q==
X-Gm-Message-State: AOJu0YwojeCwDt6tOc/opcHZbaIRGubaRTpn8j8o96RgECd9Fhrk6TW/
 exjWSxMHXOf5cugPdsXUqoIgaKeLlQ63zyoE2ArNG2zf7Tz6Bn4Im5CG3pYZIFAJN3GCFgdvwz+
 9YjK3
X-Gm-Gg: AeBDiesd08o2gK99kRfvmWUPmR2GRU8ziDH5lnpmg0kWrR0/9D5iTW1otldXENRcBcP
 /nyKPRf3kqpuaHBq7gV2Luxb3tkIaFxYNY8ZIDQs5aFIkaoSiFnTpUfgkfOQejhAUIO6kGR3k6U
 5DAx2nhz8xjkEizaZm91bxLBAK313UjxVD3DisZ/0qaiiFGb66pSyU083AcauZzwjgKww4ohlk8
 YKMsuekkZWMuO8570OE5dOfWBcQlOQ2VM82881UzlHIss22eHKzXYG5k8psVzpc2pDy0iZ40xOA
 kH/zDDJ8hqKw1wnBHP6VOPVqnTPR1Z92/HFnDRVAgVoyg/lHc2um2Ewx8pjciSVuTDVErGSZVu9
 RcVAclFADuat4Qbf25ewD4FcRb5KAwjchN9GOBYHLRXZmELkqoua6q3JIHZcX223fYBR+OKSqOL
 UfFBITRQmmnBhJcyrIAZ4iLsFxaiSAugBALK0zeEx5SK4=
X-Received: by 2002:a05:7300:a191:b0:2d4:2cc8:67e with SMTP id
 5a478bee46e88-2e2e5e010b9mr251456eec.23.1776365519548; 
 Thu, 16 Apr 2026 11:51:59 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2de8f6615d5sm10602510eec.24.2026.04.16.11.51.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 11:51:59 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v24 12/24] net/pcap: consolidate boolean flag handling
Date: Thu, 16 Apr 2026 11:48:29 -0700
Message-ID: <20260416185144.1359260-13-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416185144.1359260-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260416185144.1359260-1-stephen@networkplumber.org>
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

