Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28CDFC9832F
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 17:00:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3477840A75;
	Sun, 18 Jan 2026 18:00:04 +0100 (CET)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46]) by mails.dpdk.org (Postfix) with ESMTP id 9EF1040691
 for <dev@dpdk.org>; Sun, 18 Jan 2026 18:00:00 +0100 (CET)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-47fedb7c68dso23184725e9.2
 for <dev@dpdk.org>; Sun, 18 Jan 2026 09:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768755600;
 x=1769360400; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Y+f9Q2hJRTAeG73s/648JH7yqKaVQzGCxDLN3MiTW4=;
 b=PzBiexfQvS+BfcuGPmdTe1XhcDr1s0Rfb2moA8Ug/10lFsLGicUyiyKIHS15cr7KQK
 Mrjn/hBYbXtj2Ub1YaFuIMxrpEd8vJO1LNuztqP41sQaSYhB5W33jo2YFw5zxupmOqfQ
 VZXRXFK35TZkzEcFYWeM/qyE+slxZ3QDlrwoegFaJ1WOhx4NPI2/2Rbya9IpK3kSKBbE
 oafSk3DO2uJ4SNDfolilCn/KukBwJJpVBhmSvWvkVtBDAwXFRnbLuU57oMDr2TuqfCF2
 7QSzjgMZQOudZ00UIx5Kue76IQoSiP7Jh/saYNpmjHjbRooSvXmDU88ffA6QghnfvpSy
 X3Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768755600; x=1769360400;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2Y+f9Q2hJRTAeG73s/648JH7yqKaVQzGCxDLN3MiTW4=;
 b=VUocuE6Ufay/gTTsUOK0byHpt5t3w0MxzYmdrVQk4IS+pipmeq5PZNl3dCE+UbifBP
 L9p+Skb2Ww5++HgYYiD1aM1Fx9X5zYq6M08IOhJguzGU6U4xvRZ3iyS7NDLw8HLpJ9bU
 zEZOroJLSsr8K3culSmu5SINOh0VR8VEZub8s4ua40CLgw9bv8vP7iTUKdB0Ick3m9rR
 bGvpki8RVwcY0wiXZ7ajT4iDVxLEKnJvDy/sVfCoKto7QfovETAqb/2ItkYP4HgGL9dw
 Ss3eBYChvmyHP7B3m4XFOmSi2/Tk+Qv0F1FOtJCNFIIeyO/2L1sXZPvR82BKjhovx/KU
 2XqQ==
X-Gm-Message-State: AOJu0Ywd3i9Fisro+aZQ3KO+NQ4FyKJJu44u8QUnjQqKBnTfak7rcukD
 85loo7/QlMIB0xM60B/0lPVtch2SunlI8o6ZQxScnHDC6x2zLQ0TOJznajhjgC0yu/fGSpUlLK6
 xULAj
X-Gm-Gg: AY/fxX5n9Xahfhs7IAQzq5Pq6chz1dmiCgqRXhXLCMQPVuCMbgN3YOgJBGENP93i/8X
 j6hrddwYFz8DzMAHZlkbTAhMcjvXV/WiJW2CdOEk0NZq5remun6qDulbN76S3O0WlfcFLwfwfH1
 NHJbDPhlK0cCgx4uhNpta1UAVWlUQk1S6vQLrViad3mNXT2ZPnq+Y3a6TFzMy/D8S15s7cLkZGt
 qK3eChRa4lNQVj0TUtrFFDFpcoIXWkftOoAQbLA5gG4X/4nVrX7bUteH3pd080fRcTRZ2380kLC
 qzVUvTIoccASs5l/OOcatSpsjkfAytswREKfRJGs2FhethavoUjZPH3mNozxkE9Z3QYAzrGwgC1
 X0leKziBR/k7mwO+2/Jdvbbf7nj/inTYNO8dpQyWdk+OH0zjsil1THSXdXrhZUn+R1KFgEx2xuL
 cvXPXZicEy0uk0ptQk6gQHI+Dh6G7OgA0gQA+E6PEndInnR4hPDn1DLF/ypd/4
X-Received: by 2002:a05:600c:1d0a:b0:477:8ba7:fe0a with SMTP id
 5b1f17b1804b1-4801e343051mr121750225e9.24.1768755600202; 
 Sun, 18 Jan 2026 09:00:00 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801e86c1b2sm146849365e9.3.2026.01.18.08.59.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 08:59:59 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 05/11] net/pcap: use bool for flags
Date: Sun, 18 Jan 2026 08:58:40 -0800
Message-ID: <20260118165944.41374-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118165944.41374-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260118165944.41374-1-stephen@networkplumber.org>
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
index 5683c44892..1b3a86cb50 100644
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
@@ -870,7 +871,7 @@ eth_dev_close(struct rte_eth_dev *dev)
 		}
 	}
 
-	if (internals->phy_mac == 0)
+	if (!internals->phy_mac)
 		/* not dynamically allocated, must not be freed */
 		dev->data->mac_addrs = NULL;
 
@@ -1191,29 +1192,19 @@ open_tx_iface(const char *key, const char *value, void *extra_args)
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
@@ -1490,7 +1481,7 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
 		dumpers.queue[0] = pcaps.queue[0];
 
 		ret = rte_kvargs_process(kvlist, ETH_PCAP_PHY_MAC_ARG,
-				&select_phy_mac, &pcaps.phy_mac);
+					 &process_bool_flag, &pcaps.phy_mac);
 		if (ret < 0)
 			goto free_kvlist;
 
@@ -1529,9 +1520,9 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
 
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

