Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82A5D232C7
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Jan 2026 01:18:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CF48840674;
	Fri,  9 Jan 2026 02:18:07 +0100 (CET)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com
 [209.85.218.44]) by mails.dpdk.org (Postfix) with ESMTP id 45BB640687
 for <dev@dpdk.org>; Fri,  9 Jan 2026 02:18:05 +0100 (CET)
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-b7a6e56193cso632320866b.3
 for <dev@dpdk.org>; Thu, 08 Jan 2026 17:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767921485;
 x=1768526285; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NhypjK/qg3HmwYQihbeKVvOK8zxERIvAwjfRdSO+lbI=;
 b=hJI3gPZgV8Am48DIgeoS+WOE4Fi6nNtuppjsvRbFaVCYKhKJvec/AUfDDg2RuXMkdk
 TDaMRqZybeYds/q7yWFlMjzO6kmUyeGEV1VqJBRa4LZUZZ0jpRcknmNkyUahp6aSj9jz
 hUoPwI2gUkdvs17bP+5Mmp1dZ4KC31f99WARwf5Ij8r2ap5q57s9ljGe35kMTUHdsmZ0
 innQ0hm1lW8OWbqF+5pGLVUTDwHJ0m5umOpreoAdfelQA4o2tLlly2HTK2A265EuMLT1
 fh4thHmnYMHN7gjvdcKbzFKvYGrf3NcCcnU9d20ApLrCCtoyT9vxDmpZXg4+4j9ae9m/
 jTSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767921485; x=1768526285;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NhypjK/qg3HmwYQihbeKVvOK8zxERIvAwjfRdSO+lbI=;
 b=byKXlYhSnEmTuOXVqWWebO3KHHXYlsvjTvl47SawFggCVgeCKXgkCdd+kIBc+wmkMD
 B6KfAOHNBpBuB3vNo92GSk8xM/yFNqzWdawK1ermQiLAGjsGv3wSVXTt4Dhx4+4aeJ1g
 A2AtKJFmo/Ay4yZ3Nfy924RzCDFsFlg9jza/kpaZb5mCSxvHhdEQ8ZyHsIckKwJhBPVM
 V3nFu91np+Rxhc72uLsOxs77h98Eq16bMu6W0dFn2pfMmulfSjAZFayLjh47x1UXSy/o
 jeL7mrLFs0yBkMbma1IY0jmCFG6U6FrgM1/ulqHI1M5AiVfw2MksVEDRybEwn5gFL+EB
 gW5g==
X-Gm-Message-State: AOJu0YwB5oaV1KPoINVKYebeLXoIdRmyEY+yEg8X0C2c9wnAjw21W/Jq
 wt5Gt1GJI32EoMgUmn668keOOqeEBazscAK3NW6brUpB82lFHwAZCKfF3z9yLa0sxZHk2QbCLTA
 3Q2qs
X-Gm-Gg: AY/fxX4pT3K4wianIhzmiks/P8Xh0+MGzm7VGUFNoOjpgR4kFqiEuNuTq3g2oKFFMOT
 00z/S9+59m7ZJpWJz/eNM/cDaN+p27DptDLcFm8NAC8AiU3/+pWTk1lRbLNyXWVS3rQE2EYwYeQ
 hw7aVSi+2Sy8QxBzIn9dPioDRyWBVyUtxoolecPgv7bT55G6Xm8MQiKaWkcNzmFUv/6A6pEsHGb
 ps9yn5tpu6x98xcfaxy4Vf+Z+q3uaB9BhWhoGtx8MEnxbsYdaSxFOLzxwb0+pKI5F3RmJHvPPHz
 xTC8vBPe560JxF2XqfQyXKR2KZqdtM7P3cmiO7yiuDeiqRjnO2cVZ6jaGCM2ndkdR8hxuEQPBSK
 y6JDd8Iua/ECSIOLr7VJNc6traVkJrMWPlvuUQOPNlEC6Sw658Gq7GJ4nfmRnaB5mv25GIQtZaO
 v5ldjbK6l6ErqSOw1dtXAEWZwF5RZMEopVqK52gl3k1hHHfjc8FO8EiIlcZry5
X-Google-Smtp-Source: AGHT+IHkKMQT4zcUoKZJ0EiXhB3ocfHBP9sbKMtYbgO8xY7RVFgA0vu3ciYNZI3ANeBga2vwclMpkQ==
X-Received: by 2002:a17:907:3d0b:b0:b83:a88c:b4e7 with SMTP id
 a640c23a62f3a-b8445461628mr628692466b.65.1767921484780; 
 Thu, 08 Jan 2026 17:18:04 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a27cac3sm954886566b.20.2026.01.08.17.18.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 17:18:04 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 3/9] net/pcap: use bool for flags
Date: Thu,  8 Jan 2026 17:16:20 -0800
Message-ID: <20260109011755.362857-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260109011755.362857-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260109011755.362857-1-stephen@networkplumber.org>
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
index f4cb444395..5db44ab1ea 100644
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
 
@@ -1180,29 +1181,19 @@ open_tx_iface(const char *key, const char *value, void *extra_args)
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
-- 
2.51.0

