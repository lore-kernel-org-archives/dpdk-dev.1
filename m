Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F7C6E6BF31
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 17:36:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 05B0040689;
	Fri, 30 Jan 2026 18:35:25 +0100 (CET)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48]) by mails.dpdk.org (Postfix) with ESMTP id 4F6FB40647
 for <dev@dpdk.org>; Fri, 30 Jan 2026 18:35:13 +0100 (CET)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-47edd6111b4so24874425e9.1
 for <dev@dpdk.org>; Fri, 30 Jan 2026 09:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769794513;
 x=1770399313; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F7HrpBKqgPlpoI4KBRl9oPgRacp7AzKW5xkVmWiFvZw=;
 b=A/bDBor5aGm19585Cxg7MtJZI8MMo0HPIWR0egDzYJ1Rnpke0Ovy2cY1O+TDoX1NLz
 pm/YbV5n8rReotauZIMYVkwKzOu6xFANBBL2aJpBp0PiapLCrtX0OzRH3/WeM6hu2asZ
 0h5ySNnsj3G+n1l2FoaEzoRPj2QMTWi+Sv4Gkl3xXuuiTwjNqVU+dEwOHR9zyk2V6n8/
 nMrCyJr+9jgpDJUBVP7OuS1/av6pGseCncbefDU2wLrhKB2yKSeicOXZRqgCrbFgIM4g
 CasAxJe6qUaJvnDvP6AvP9Ki2VQppUhgr2tBxmFxcQsfNWnKJGu96OvbOa4wiceqGUCm
 AaDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769794513; x=1770399313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=F7HrpBKqgPlpoI4KBRl9oPgRacp7AzKW5xkVmWiFvZw=;
 b=qFUMnQPsaJm2Hw9sB4y3SUQr5Cf0h69nzBHU/VZt9DpH9vmUU8EuBuFBtdee9BqOVl
 ilIdZ5v68aWXRa1fAVUHaOsg5RIbg81X5h5JJpL9bB5f14NQdIGt5uZmw7jrgLrS5UBL
 wRN13fKzRJQlOADDmN5D6YC3wXk2O6O1w4mORJJLGy/kbXiUvqcYGN9fqw19lYjSUcxu
 MianloPzrWcSiTNnzG1Vw8LjBZe4inPNKe/cykifxm5I6/ScgOa08RWSLp0Y2wCnnnce
 Y6zUyX2jVYDtMtBmeCQwvyxVkAchLfx9OXDGQ3URFxiccxMIZ6Ds2TNQjCfXhsBaxhmd
 QoEA==
X-Gm-Message-State: AOJu0YyWNoXIo1jZ1Won3crgGeBcAQMQqJYrSPC6OEMYEDZGCCvMbUSQ
 GTpvPv1xe4oN/b1u5gBbGA0/lMw2eKy3+UBczVOBJFMzKaDq75eHAMZajEwUXgi+SALMf0TAtUU
 pOV3i
X-Gm-Gg: AZuq6aK+G3ahWJGUx7TTGsdvXNCA+DNYme8VWnRuQxRo8jw891Zm1aeUu/5asUgQOaN
 gHhFR+fA3HM9wg7P27GvVGUgHV1h053I47WDNLzDDGuoRlS0VqPZ5xA9RD4XzxTry5NAiocoPjC
 mtT3+zGkmu/ia0Q59Q1Vg0Oj2gCjjk7V8HREXISM0tIPZyM9QSCmjqflCSPzb8Uih3IeZqU17JZ
 WE+w9gAHI8Ok8PAlCSAxkl6n1t6TgehdHA2ptFFwdVUM9jeMmGWcefBc8m/WjeL4UtI7S7sbWYU
 zxXk5WU6+fMZE14k07Ri08XNF7dMTAWxM8LnmO5yHZAy+swxxdmwymY9UGS9YW5jLM1xxU71afZ
 XvOVSMPdl9ar3g2mNARN0Es33e/0EF/iB6u0Qn0u7ViZmxn18BFgstT5+lw3RrPFOjQYIad3bUm
 EfiRjx2+kvfkIh4SVhzU/hJ6QrR77f5Rv6Z/l5npGYUl9ttYUVDg==
X-Received: by 2002:a05:600c:628b:b0:477:9ce2:a0d8 with SMTP id
 5b1f17b1804b1-482db013172mr51260525e9.0.1769794512890; 
 Fri, 30 Jan 2026 09:35:12 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806ce56490sm201085325e9.12.2026.01.30.09.35.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jan 2026 09:35:12 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v11 10/19] net/pcap: consolidate boolean flag handling
Date: Fri, 30 Jan 2026 09:33:23 -0800
Message-ID: <20260130173447.14546-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260130173447.14546-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260130173447.14546-1-stephen@networkplumber.org>
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

