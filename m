Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8334CFCC9AE
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 02:50:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B23240BA2;
	Tue, 10 Mar 2026 03:49:45 +0100 (CET)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com
 [209.85.210.52]) by mails.dpdk.org (Postfix) with ESMTP id 5DECD40A82
 for <dev@dpdk.org>; Tue, 10 Mar 2026 03:49:41 +0100 (CET)
Received: by mail-ot1-f52.google.com with SMTP id
 46e09a7af769-7d75371d873so1431341a34.3
 for <dev@dpdk.org>; Mon, 09 Mar 2026 19:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773110980;
 x=1773715780; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ss1RvhYgyWWlW0u9kUw2lQDOXXQGzfATiCWob7Xq4jA=;
 b=yGqz3DNeuDFBvp0VTKg0FnGjv7EzktPDZYQwkJ4mA6PYq0XYMLgVY4H48BEFmx1176
 xBBhbxCYfq8iI3yQVTGh3tB6nX5wQjDgDKGOQzpCYfD/guM+DweWdbeQ2wXj17wzqbNx
 DfWlZFM99CGbHxqwFeVUENK1vHhbbFf7LXNHWxmDn6v2vIj7HkQOiXtNmidsEZle0kwk
 dJdhiTdWY/FEE/zZMVhO7Zk2ojY6J+ehF6LGTBTSHjbmXtoBAsyj9om4TDGVybrZxPDA
 mbwQEb8c9UBaWPG4SsJmH9tExBX1nFD2dtzpnjZLr2tiVpQEGmUNO+A7KceibpidPp60
 ETiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773110980; x=1773715780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ss1RvhYgyWWlW0u9kUw2lQDOXXQGzfATiCWob7Xq4jA=;
 b=lerOSQs+xDFS933r7anRCvtJEd1/Lnv/Le82DCCFN1O//vgr0srYfqaBjxoNmWAILp
 RTO9Ap8pm+ouOgs/zNe4B0OCXWM8IexN95CWV2N88pom4OoNez4z31XywuYqt4lunRNS
 2oAKckfjtGDgQK3I/CcNQW8+skkptg1F18IKb+YNDvrM3jk7OMHe6rBTbkIyHhAicAyZ
 X2BFr8quN0M2yUvg9YcxYmFLKBbOlSN+aRL/Tg1pRwYC3K/4A1g/+gxUpX43Ib4fDNlM
 snXZDs7IplhbAb9/LWUEDArNGU+Z/wFY28fXlvvyvEcsBn5lpJJ1dPiPljxHMBxhrGog
 HM5Q==
X-Gm-Message-State: AOJu0Yy5SU+xPuBud82+pI69LeMF5EFFxgAOGayxJHf6pCFDlQu6e+uR
 sWoUyWufKjbTYyyAsjvWoyIjJLpT9AlEF1cS2v/LHgCX2bh60UevMdg2WflXZzRJgY9pVq/DwLH
 3pAlPSF0=
X-Gm-Gg: ATEYQzzVSVpqdP5Oj61tM+0IHQ/eg2ZC5vSCbP8AcqCbadH3lDdRRpJexiFX+vLID5m
 GD2VQnYuc5HYVwdllO1Rau4n47zx1o8iORz3TaYhvjotMWQSuHnxFhLPdCszyjeQpetHB5PxuDq
 q9z2tj9C/vjkUifFW7jsNZm6Dcl9Pb7I0MFrNpCiQLxwVjIsmKdtLgvtROEKFxAj1JWW06AA4HL
 gDNhQaj4l2t1nwTpOwmQ9n1G9c6jRu6MIU52Xg7YQWX0KhJYR0NGySLMq5jW3dxD2AGAeM6ABa7
 +RiVMcNxdIlWuX5DL1oGsAPG+raSDBr3AZeRd+TAclAsN6abBW2v7soIU0wZb+T3jx2uTzbCZJ/
 utdbJtCFkIAfbzpfuNCMXfzIG+hDuY/qT7eSWKafgdnLkkLuw2zfcFvulgrJxv4eRc5nlRIR2vG
 oZ909mUproxKpGYpsN5VGaTYr8gl88tt42
X-Received: by 2002:a05:6830:6083:b0:7d1:8e7c:c54 with SMTP id
 46e09a7af769-7d726fd39bbmr8259596a34.21.1773110980600; 
 Mon, 09 Mar 2026 19:49:40 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d728d1238csm7808572a34.15.2026.03.09.19.49.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 19:49:40 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v19 11/25] net/pcap: consolidate boolean flag handling
Date: Mon,  9 Mar 2026 19:47:46 -0700
Message-ID: <20260310024925.476543-12-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260310024925.476543-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260310024925.476543-1-stephen@networkplumber.org>
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

