Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B89D2F32D
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 19:26:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1038240664;
	Tue, 13 Jan 2026 20:25:48 +0100 (CET)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
 [209.85.218.42]) by mails.dpdk.org (Postfix) with ESMTP id BA01A4028B
 for <dev@dpdk.org>; Tue, 13 Jan 2026 20:25:45 +0100 (CET)
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-b8718187eb6so370661566b.2
 for <dev@dpdk.org>; Tue, 13 Jan 2026 11:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768332345;
 x=1768937145; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WysPwmKw10YhG/ic2ay8ZI7w4v6MmOiogXywLLbS1Ik=;
 b=m+eECuuwmqFKg8bSfETOfLd2t3yt7p7Fo1BqDvYAayLlpm4s+DgqSSl5tbHSQMxB3m
 kP+ie9Dy8smqMA640djE/0rka4A0jopfW7c+uSees4cedkOfwgDhYaQ4y+1er8bfrCZF
 HxGhvnj1OS20RVgiUTPVtmSpaH9U5zMs/3uHnEcYk8eXdLDQUvQ5ktiAl0ev6PjvIHoh
 FNARJi+uHYyhu1J/y99PkQ+2k6w221Sl0s/B1NWTTiZdEERjl1idAd9Yp1WR2S6f+LXb
 /Mg8rPvF0/2CP0f42KJ99czKde3s3d2Nffq8kc88Z6w2nQugKumGd5gSCrn+XlBaxBPl
 Zo3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768332345; x=1768937145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WysPwmKw10YhG/ic2ay8ZI7w4v6MmOiogXywLLbS1Ik=;
 b=WnjyHyr7tK4xuU+/jF1/F2VCgFWA+45bgaCh4m6GAmReCmy5gkF/+3bLMqzlEl5XxR
 S4dzOsA9ibDVMzW8+q08rCmDmAH+hu7+b63ELJYctIs6iJXGCU/9hDTao4g8idhhKStz
 7uJYZ9NkEKTqH3xK2u4BaFY2pwC0JTX0aYxS/l+vop8Tr4f4YIiNwNiCHtAatnmi01qx
 IdkFYeAQIl17eKyTyrOPvHRHfwRyhw07KUUY0r2fBjv6rnbl0hWCYB5PNUrshvz9Va9e
 Z2nyzLrJH13B/I3lwyD1RkWQfEHI+8JPnxjC/ziB3ZFS5hI4jjyi/Bnpn8yL8K3Zz7/w
 ODHA==
X-Gm-Message-State: AOJu0Yyd8FZfv/aE6LCD9EspOVu8v+1fqFbqwW0Bn42rYwwMGMY3talM
 eeO+GXfrz101eTxJFvWB5kzU6CQJXhvskhwlocqxGtHAAoSHD2M+Piq6gUVsUPfRvaDDpduhDcu
 bTxFf
X-Gm-Gg: AY/fxX4juoyVr+awD7KG2xTgW3EVh/8Y0X5TccYx4G912jgXwDmwwDZYCwaOqyWQ6hc
 HdXNaa+nLOKjOXViyqZKmgs7WMGmdhc0ZzLMW7e1akTx4AKx6EzgcfUdzmYcj9wuELeZkt2VSvv
 rVvmxq6IJ0dsUqbaAovPT6vBYSH5ZruXBcrQP4J9PnpYKc4jZr/HLJOUlYIexd0jP8Y9T9jch3i
 1ck8bAwOdW5xyW3ayDuC0LTU/0pPnTgElNxJzxKKEKe4r3RwJThLAooj9DJ3X0SUCIn1zsO42QZ
 qFQzTiGJhP1y4RJUgT+PGiQUOOoLl15R69asy+N5iKRwyX5ZeSdUL/UGZnqIj6WH9HoSAsiUBbI
 C0sJMO5h9wv7qwY8KoZ8DBBADavFm4/ToNQ7MwPgk9oNz61tg6qqM1ymCJAKr4ZFO1udM0eCJRE
 bebOyNl/5m4/4BeAvoHxaJ0CwmqfK88a+mWcbAqFDSxWiVAeBTx4gwNbkduxsb
X-Received: by 2002:a17:907:a47:b0:b87:2fdf:1ed2 with SMTP id
 a640c23a62f3a-b87612c2473mr15326066b.48.1768332345303; 
 Tue, 13 Jan 2026 11:25:45 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6507b22c3absm20945603a12.0.2026.01.13.11.25.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 11:25:44 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 4/9] net/pcap: use bool for flags
Date: Tue, 13 Jan 2026 11:23:36 -0800
Message-ID: <20260113192530.116470-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260113192530.116470-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260113192530.116470-1-stephen@networkplumber.org>
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
index 564c40e26e..7002f8034a 100644
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
@@ -858,7 +859,7 @@ eth_dev_close(struct rte_eth_dev *dev)
 		}
 	}
 
-	if (internals->phy_mac == 0)
+	if (!internals->phy_mac)
 		/* not dynamically allocated, must not be freed */
 		dev->data->mac_addrs = NULL;
 
@@ -1179,29 +1180,19 @@ open_tx_iface(const char *key, const char *value, void *extra_args)
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
@@ -1478,7 +1469,7 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
 		dumpers.queue[0] = pcaps.queue[0];
 
 		ret = rte_kvargs_process(kvlist, ETH_PCAP_PHY_MAC_ARG,
-				&select_phy_mac, &pcaps.phy_mac);
+					 &process_bool_flag, &pcaps.phy_mac);
 		if (ret < 0)
 			goto free_kvlist;
 
@@ -1517,9 +1508,9 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
 
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

