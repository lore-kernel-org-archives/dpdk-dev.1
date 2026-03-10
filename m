Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DE8FD4F04
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 16:15:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6742340E5E;
	Tue, 10 Mar 2026 17:14:16 +0100 (CET)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com
 [209.85.210.41]) by mails.dpdk.org (Postfix) with ESMTP id 6380840E41
 for <dev@dpdk.org>; Tue, 10 Mar 2026 17:14:13 +0100 (CET)
Received: by mail-ot1-f41.google.com with SMTP id
 46e09a7af769-7d75e74f5adso718393a34.3
 for <dev@dpdk.org>; Tue, 10 Mar 2026 09:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773159253;
 x=1773764053; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ss1RvhYgyWWlW0u9kUw2lQDOXXQGzfATiCWob7Xq4jA=;
 b=EGw0+UuyboFmQ5JtYZfoEyDbY1X50ZZkLYgfA7Y/QptNjx6Rx+VteD1ybFtthHMmr7
 AGmvOagnY+3yDBmv9D7jZiKUTvdzZ4U2MSuvWTBG0RyFUt3F6TRFuQQoGnsw9+uNJwQ0
 ti5NQzCusXn75Co45U3X/yvLRd1m63tPjR4KC5Q0rWfksxKk7QQ73rcLf2lim1+ZOWPM
 XaH1VCjERJCibZ6AdxvtCp524Ds9jeMPo7HLc2wleuRTFtQsfZxVm9lopQtT3l2UYIdw
 kQAthZUmY/jtBuxxpSLwmGtdeCwMFd1NT0VBexQ4u0UEQ2lBmBsvQGR2BA/tD9+GdkQF
 GizQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773159253; x=1773764053;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ss1RvhYgyWWlW0u9kUw2lQDOXXQGzfATiCWob7Xq4jA=;
 b=p+1r/VykTs5MyrEMrQ2MgAg78ONZbCO8QBUBTnZmolVwNavOJjFzqFseKNGfs6HtUb
 xjTG/tbm/3bv7NeeDzOMDo6LoXkav2TqG6d3wNmZ9s9tJpxWEvOJ2LZeLrLUQ4BbEPtS
 GSY1RTDGBG4VyxXCJGBWTBYaFE8zhRO8EUH1LQUKA/91UjryFgPIIVkBjjHdf+Vm0/DK
 14kyNX4CfZzWj72HEMjiqlghf/89kaYGO1GsDxMlceVLccCqTcxvOJkz76hsOBfUuvCP
 pUi4ARwDI5z+td24LZfjVggDb9ltaqfko0vPC8cimfkKd7J1T41zkKdiSahfMmeGnlgE
 J30g==
X-Gm-Message-State: AOJu0YwwqeiYPbnuAbBRsB8ou66fGonFVuvXs7QqZvL9VldAzPkROfqa
 7yN3OZF4JVesV6E2xHRSnfHSVWWLBXL6ET85Xs9TCWotQfbHUnAyxMN9RRkgiIKPIf9jZKUMyUB
 5w4SzKnI=
X-Gm-Gg: ATEYQzzvD8T3ApoayfvBXQnLMZZIoFVYHft3WUXv+W/L8b+MSQU+MRCsIfTVG8qBscq
 4pm7wNXkms8A5ObJDuQfoMcW6UyC2RgQS7F6ANv3YM/7h5WkQb1y47jU4otmM3PzA6QYVhaTrMC
 uvUXHkX/1uxXP4KoIPpnQNtH2O/IPYtytb5WF4AtVRGobgdXM6USPlAbZ8BRTPvSeencj2Gz0HB
 dn0LgXSW9kLsPaFxrL/lE0lNf/eldE6arDj0sOFNmy2/Hh/q2vGR0tqbFF+U5c7xJk1GO74LqQX
 KsMw1FTX1ix5a/Ap+L2dwsOJxG3YBsuryh9+SqOl5jxpvQZpqw9VlWY7c2BvZzeMPsnCYsPacKv
 mqd2yjrmL0nTE7zFr7DbhVjd5gWibeynYmf5RYhX+Wju4RapMDfe2ENq6W/WhK1Clp6hVq00Eof
 rdVT3iFo1JCJKh080eL42jL0K631aC9V6T
X-Received: by 2002:a05:6830:2e05:b0:7d7:4666:69be with SMTP id
 46e09a7af769-7d746666b8amr6794309a34.18.1773159252602; 
 Tue, 10 Mar 2026 09:14:12 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d738e3f421sm7304004a34.25.2026.03.10.09.14.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 09:14:12 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v20 11/25] net/pcap: consolidate boolean flag handling
Date: Tue, 10 Mar 2026 09:09:49 -0700
Message-ID: <20260310161356.194553-12-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260310161356.194553-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260310161356.194553-1-stephen@networkplumber.org>
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
index 258cffb813..c3270a676c 100644
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
@@ -884,7 +885,7 @@ eth_dev_close(struct rte_eth_dev *dev)
 		}
 	}
 
-	if (internals->phy_mac == 0)
+	if (!internals->phy_mac)
 		/* not dynamically allocated, must not be freed */
 		dev->data->mac_addrs = NULL;
 
@@ -1209,29 +1210,19 @@ open_tx_iface(const char *key, const char *value, void *extra_args)
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
@@ -1507,7 +1498,7 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
 		dumpers.queue[0] = pcaps.queue[0];
 
 		ret = rte_kvargs_process(kvlist, ETH_PCAP_PHY_MAC_ARG,
-				&select_phy_mac, &pcaps.phy_mac);
+					 &process_bool_flag, &pcaps.phy_mac);
 		if (ret < 0)
 			goto free_kvlist;
 
@@ -1546,9 +1537,9 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
 
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
@@ -1698,5 +1689,5 @@ RTE_PMD_REGISTER_PARAM_STRING(net_pcap,
 	ETH_PCAP_RX_IFACE_IN_ARG "=<ifc> "
 	ETH_PCAP_TX_IFACE_ARG "=<ifc> "
 	ETH_PCAP_IFACE_ARG "=<ifc> "
-	ETH_PCAP_PHY_MAC_ARG "=<int>"
+	ETH_PCAP_PHY_MAC_ARG "=<0|1> "
 	ETH_PCAP_INFINITE_RX_ARG "=<0|1>");
-- 
2.51.0

