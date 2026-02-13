Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4AFEEA84E
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 17:04:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 60B9B4066B;
	Fri, 13 Feb 2026 18:03:54 +0100 (CET)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id 9114A40662
 for <dev@dpdk.org>; Fri, 13 Feb 2026 18:03:51 +0100 (CET)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4834826e5a0so11041535e9.2
 for <dev@dpdk.org>; Fri, 13 Feb 2026 09:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771002231;
 x=1771607031; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W7TBf4j1Q6I9GVIEbBS7yjiusRsA6Ii/B/IRvVLQMP8=;
 b=bWzXreNnrNdN8rt1ht0u+BOjQWzTGVs8PbCf4QhS+JeZVrWKNIRrBkvsfToNbaf3xp
 Vj7ebElQn8h72iqbwfZDoFOEfosRVLZcQyyMOEfJLYXfyXdh/TEMZid28P/QdNuyxXK3
 rcqg+P/QGyWsFKlhP/nDvk+o4n7nGSceJ5D9L6SOqLbWz2tUeplRcI7/9f9cX+dUe4Tr
 OkfZjIXRU/BkBz1dpsRITradBUDD+pu9LHwmC6Yovk6a0qR1z/K0AhGZRzN4V6eTdP6O
 TaUdhyoxNUR8lEkqUBqdwKtTneIYXRabRG6GrtW06TWyNQvrg+jMY3fSylVYiuDcm6F8
 NeZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771002231; x=1771607031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W7TBf4j1Q6I9GVIEbBS7yjiusRsA6Ii/B/IRvVLQMP8=;
 b=B5vYavolQ6F0Ic6+KdAEzZV3ViRozFv9cKmWeZTOArSamTi8cKKgQnpKvt6YmubBo4
 kJfMHyfHgifTMVaZOb3lNW3ZGza5wZqBC0Ordnw9VLp6H8xXWUVT7n6zCfW98n0ItIaK
 KqiG+rFNn3OmrKDDM1uEOgqiKR8HnB7eglQgr5EB28iQUnhFMqKGM0yOiEaJpJVvFq4d
 mH1VBC41EbXCZYlPdWzcnbfOMAemKe89JZlrLIQio784TiO67CY6lf60jJVOKOvGAFn3
 7D5/8RAH6cgmSTzwlfwqShlDHopoOxSuXFjt11WbTTaBr9c4giyNKrzG3G65hQpuAyuk
 gy5w==
X-Gm-Message-State: AOJu0YyFyig8HvfikpShGOGyUU3+g3f6wvuZbElqbltpCL86UrAlhkju
 m/Ilf7Tners7eCuCt8N3k9on4usSE12ttrBApduVFfxFaEwQgk6JMfFtDrGKi2HMREByqnKZcqM
 NKq0m
X-Gm-Gg: AZuq6aI917WBTVH/OfiYmpUrTSb6PVwK82ZGzdITxxH3PeTtO6XbV2pWNhKoEWdazcA
 WTIlH6NEWBasCNNdVuMtutX9t11ImqBF7iSO6Eg3K5wkknwXqCk/G/yimz5rRJnRu1ulBCU7+eC
 ZrCqjg2ZIRTmYE35HVJ1/kLLJMce8PzrAvauMxZ+rqYspyPPMcblFo2IhkGei+sQ80Uqmb+KxXD
 vMK0UJ8dNKHEiiYH/JXm1dmwylRQn1W1JhrI7KKvmPspkV8mDiKx0L+hTjwSt/NI4ucMEc9vDuv
 N0zQZV00Zb2vtszgZM3wCscKXKKrMSXJ5/ORKdm1pJiB0euw7Tc96blxb0z7ADKktc78llRWTa9
 eHeHHUy7PCGiABeU8iBmCLztmrcAYHP/G/ElmKSBCHNxjlqhFgSBoyEgMlBpQcU6oTZCYnttmmp
 b68QZfvVGSmQKWFIW6x3PZXZ7+556apDdQXQViX42DB3V7kV9koYrCJF2keg53Zw==
X-Received: by 2002:a05:600c:1908:b0:479:1b0f:dfff with SMTP id
 5b1f17b1804b1-48373a1bbb9mr46179345e9.10.1771002231132; 
 Fri, 13 Feb 2026 09:03:51 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483740be167sm40963035e9.15.2026.02.13.09.03.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 09:03:50 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v15 07/18] net/pcap: consolidate boolean flag handling
Date: Fri, 13 Feb 2026 09:01:30 -0800
Message-ID: <20260213170333.40089-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260213170333.40089-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260213170333.40089-1-stephen@networkplumber.org>
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
index 4761741edd..f6adc23463 100644
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
@@ -889,7 +890,7 @@ eth_dev_close(struct rte_eth_dev *dev)
 		}
 	}
 
-	if (internals->phy_mac == 0)
+	if (!internals->phy_mac)
 		/* not dynamically allocated, must not be freed */
 		dev->data->mac_addrs = NULL;
 
@@ -1214,29 +1215,19 @@ open_tx_iface(const char *key, const char *value, void *extra_args)
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
@@ -1512,7 +1503,7 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
 		dumpers.queue[0] = pcaps.queue[0];
 
 		ret = rte_kvargs_process(kvlist, ETH_PCAP_PHY_MAC_ARG,
-				&select_phy_mac, &pcaps.phy_mac);
+					 &process_bool_flag, &pcaps.phy_mac);
 		if (ret < 0)
 			goto free_kvlist;
 
@@ -1551,9 +1542,9 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
 
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
@@ -1703,5 +1694,5 @@ RTE_PMD_REGISTER_PARAM_STRING(net_pcap,
 	ETH_PCAP_RX_IFACE_IN_ARG "=<ifc> "
 	ETH_PCAP_TX_IFACE_ARG "=<ifc> "
 	ETH_PCAP_IFACE_ARG "=<ifc> "
-	ETH_PCAP_PHY_MAC_ARG "=<int>"
+	ETH_PCAP_PHY_MAC_ARG "=<0|1> "
 	ETH_PCAP_INFINITE_RX_ARG "=<0|1>");
-- 
2.51.0

