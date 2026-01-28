Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0C7D46BEF
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 18:42:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2C8B7409FA;
	Wed, 28 Jan 2026 19:41:56 +0100 (CET)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41]) by mails.dpdk.org (Postfix) with ESMTP id A29B140687
 for <dev@dpdk.org>; Wed, 28 Jan 2026 19:41:46 +0100 (CET)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-47f5c2283b6so1250745e9.1
 for <dev@dpdk.org>; Wed, 28 Jan 2026 10:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769625706;
 x=1770230506; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rRDUntMtglAIqr5iTE0s7JkluPjS4LPZYKAuPfzx35E=;
 b=2gfH72W3kZpDKMDBoTFxqxoOKkBIL6XN2wmSJrmXkkU0pMfaPJL23wf/NKAtTJZOh4
 PaahVqL/CRfAxAp+fxruVkk5g2/u7bkgfbouSm+IpxkO8clkBj2Xj0NM5JpAcaaEHjrf
 c/6wSL18NdF8pIZTye8yiBZJdRi9Expawa/7yONeiyn4NXGoQPO/gpHqlW5WfQoL+77R
 vo8AdR+AJu4ifcBCsw+HtZ5wvRMPvCcIlMFOLuEwM0slyQeY71hM2qzWCRvCX/2EpSTr
 Rnfx1IXHGLLOt5JuFfDvyrlgU5YyuMFKlQ3w8AN/ATgPvmoBkIg4rWjWxmURk6GAkFKf
 ooEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769625706; x=1770230506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rRDUntMtglAIqr5iTE0s7JkluPjS4LPZYKAuPfzx35E=;
 b=i75JZx6Oqan7Ac0lON8I4VknPm/3SnDdw7o6ZTSTMYn+eZi2xHHujnnozmC8yJb3v4
 JR/pSAuTUOrouUH0Kiw+vneiFk1QwNvUc/gkVeI9DJyX1BkR2OF73cCpTcuIcILdLQop
 oMczyeskAeKHcmjJSGbt2g1v9J+eG55CtK5O+thAXmyMTl6G+X+zWqxyQNXvovopzoCr
 oQu7wT3Hn36m5UCIZgcpCYwYhDMrL9FdZ4vIDQ64qbu4YFsB9cp/B1ioVrCX+DbROe5M
 FSlUpd7jPO1pdEaZPrSLZaKBXjvFXyzIsRrK8Nd+I0A2aSUN2Pk8c9aVE/3fjVvxwIIK
 KmuQ==
X-Gm-Message-State: AOJu0YxtPCCXHEEcQLArYqpMX0zRjOD8FTW3iSBCpQkiJ4wZqQcddKXM
 ZbSQmvEhZ+OjyR8r/ZJB0dR1M8AzO+0RL0wRWt79CkmmJLi4cyKlDsd+nxn/9ZkJHsSpFtdyCGs
 GgYsV
X-Gm-Gg: AZuq6aLTzlWJ6UMKYCXJqJX/kddeKfOzQzvtFqZo/KUiMB4JaD4xfj9XELgif30OUqG
 w1Cqh8iJV9+7L0vYUn+glYWfQo1GISbWMStLOfnHcxJdYq5fKLMmkpytM9aBbIuDlUocKfJ+2TR
 QrZ+G5IzE61Ne+J/4h+R7ArUs75S6cjRceQLP9pNUVs+5tufNlqBAhKpsXyC6HMJmO8YjbSfcjH
 mgvRynfs4LYm3wEsd7OyjnEZX63NauPRK1ORRy7HNV18HZZGdXlSb5Oov1Dh/TkWFm9OF9nhb3J
 oV3kCIfft8h01rhmE57MSmmoljQhOp06WdficruZ6bgDYR6gNh3NFkm5C1ehjHt6jv+soh9gG94
 ukUhHAcdCQ1CUdhZYUJDQJEVZVPBoJ+iVvl8v0LxDL2a0w2/zncI3cb0/CWjhz/ZWk9o2zUHaNm
 xd71xxzaz9lzsOkrD29/aVNWmHMrp3wgxasasns+3abookVi/r8mZZfl/UskIX
X-Received: by 2002:a05:600c:8b24:b0:477:5c58:3d42 with SMTP id
 5b1f17b1804b1-48069c20e88mr80841785e9.10.1769625706217; 
 Wed, 28 Jan 2026 10:41:46 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10ee562sm9015430f8f.18.2026.01.28.10.41.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 10:41:45 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v9 07/15] net/pcap: consolidate boolean flag handling
Date: Wed, 28 Jan 2026 10:40:36 -0800
Message-ID: <20260128184130.445567-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260128184130.445567-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260128184130.445567-1-stephen@networkplumber.org>
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
index 93b3fe229d..63a4f92c9c 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -6,6 +6,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <stdbool.h>
 #include <time.h>
 #include <inttypes.h>
 #include <errno.h>
@@ -98,9 +99,9 @@ struct pmd_internals {
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
@@ -110,25 +111,25 @@ struct pmd_process_private {
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
@@ -866,7 +867,7 @@ eth_dev_close(struct rte_eth_dev *dev)
 		}
 	}
 
-	if (internals->phy_mac == 0)
+	if (!internals->phy_mac)
 		/* not dynamically allocated, must not be freed */
 		dev->data->mac_addrs = NULL;
 
@@ -1175,29 +1176,19 @@ open_tx_iface(const char *key, const char *value, void *extra_args)
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
@@ -1473,7 +1464,7 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
 		dumpers.queue[0] = pcaps.queue[0];
 
 		ret = rte_kvargs_process(kvlist, ETH_PCAP_PHY_MAC_ARG,
-				&select_phy_mac, &pcaps.phy_mac);
+					 &process_bool_flag, &pcaps.phy_mac);
 		if (ret < 0)
 			goto free_kvlist;
 
@@ -1512,9 +1503,9 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
 
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

