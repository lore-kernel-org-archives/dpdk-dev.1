Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1876ECEFCE6
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Jan 2026 18:33:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1348740E0B;
	Tue,  6 Jan 2026 19:33:22 +0100 (CET)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com
 [209.85.208.46]) by mails.dpdk.org (Postfix) with ESMTP id E4FC140E01
 for <dev@dpdk.org>; Tue,  6 Jan 2026 19:33:20 +0100 (CET)
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-64d1ef53cf3so1817771a12.0
 for <dev@dpdk.org>; Tue, 06 Jan 2026 10:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767724400;
 x=1768329200; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3qhN9KInipgpzkPvfJqicnwRvQCn8fPq4LvjWpWHvhQ=;
 b=1LpcZ+Cc+q3VMWI+nKcXBVzx43Jzua/QLNh0wWh1HEkeMSFT9Z50giEIw2IgcMnazJ
 a8hn7zWaUrh2hTLNbmEVFTVFTT1YNqXE05zmT3AICpkYDOEIGNXzLW4gZZgy7VMvyt27
 VMEdsDD/J9lROLj+J2qiBlth8/FaKTGM2z60eUbvBUAX8azZK18M0KwUJmjD35G7KEB0
 t4L1NEU2eB5C/lGte+pC59XAQwGuIeKbW3HcydIrmszNEnrHT0WiX0JhZnP23t3fs4HS
 DhHA/ncRNslr9WjUZ5cm356xrwd3GlDw62U70qtaOmn3j93vTq4t5VhL1ukdZR+hjpnT
 qUPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767724400; x=1768329200;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3qhN9KInipgpzkPvfJqicnwRvQCn8fPq4LvjWpWHvhQ=;
 b=KK+tX95U0mtmGSGjXLihWPpK58HUVtO0WwQ6xiriTFYpIwhisjs6hoaSr0BrWy4l9l
 O0bv08hW7O5nJobbPYBeNIQkbuB7jwMaqE20kBtXpY6nkrewLPcw60mvpxBXWpG7AlZ5
 3lzHzWlqdpARY4AA3LG3dHd0szxxveF0nFikvi20TYfzvpWKvLZXNe+y7TwWJK/yaSwp
 ADC9u4F0MJH9FXkDSexHA3ahGp1ZZHGMr6yQDclGWVHsstu2yOqyt8ug5q7h1stBvIm+
 jVC196DGUR7JG9d1o60ODls0yGFUNHvCbPKzxiO+1b37S+E0j7t+kfufM/8Dc1ikUDOA
 cveQ==
X-Gm-Message-State: AOJu0YwgYBMP58g9XyfqpMQkO5ksac5XWQI0LiMrpfynT0iLCA6cfzFX
 44TYO8FBHeDeQx5ICbqIGLtm3uGHmbmUBior2uL4m2PAlQpVorMqqpYtEcspuNrTz81aE/wpVTp
 tpj5qb0I=
X-Gm-Gg: AY/fxX5xI6cpSZcFapYvGQjoaYz3GKd4B6FFLQCJQTDdQLDuFyUAaJTEnvu7Q2g3bYY
 rB/4fcfuhdj+d/313eCxanU13qs/RsFGONCS9F/cQ/scGBYGKJPWlbvblU0IAL7jpE1dKQGuDmT
 GE2P/n5YIlsUumwKq0jC6EwqTYvEnmM7DyS8cSGdmSQLLPm4Bw/+mHLoFsww3h/adRzzZQAepPa
 UzotT4eZsw6j2OzMWizOGbTUn+G6YnQc5/9jSRAio6SPn/MglVCeMa4U0b7MywwQ+ipUH0c9rwW
 FOi8cLOegBQkpTfNevdaE+Azhk1zBqylIqqBoTLJZfB3fu/MckzfN+fbbdHxSvqU6HHok56bBHD
 XKvrLs6meKaAyiYzSUnSGK9VpaGF7uQZbrkJWI7flCRlX5Zgu+Azm2fgPZmNOtROS2viMqHUc3b
 c1NcT0Cw10inbn5Ap6il6X9dcStqOgj0miB2rT+YrN1ikjlUKd+g==
X-Google-Smtp-Source: AGHT+IG8mhpzjsH4SAG2PEIEAfJkMueaCUhFiPkcd46pRpTlQzVIqPXgPhP+70/UyIyS1CB6iC/NXw==
X-Received: by 2002:a17:907:f815:b0:b80:2315:b4ca with SMTP id
 a640c23a62f3a-b844536c1e4mr6240366b.46.1767724400197; 
 Tue, 06 Jan 2026 10:33:20 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6507bf6d4acsm2728525a12.30.2026.01.06.10.33.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 10:33:19 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 03/12] net/pcap: use bool for flags
Date: Tue,  6 Jan 2026 10:26:42 -0800
Message-ID: <20260106182823.192350-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260106182823.192350-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
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
Use common code to parse value of a boolean flag.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pcap/pcap_ethdev.c | 73 +++++++++++++++++-----------------
 1 file changed, 36 insertions(+), 37 deletions(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index f4cb444395..6a3e89aeab 100644
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
 
@@ -1180,31 +1181,29 @@ open_tx_iface(const char *key, const char *value, void *extra_args)
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
+	bool *flag = extra_args;
+	/* table of possible representation of boolean */
+	static const char * const values[] = {
+		"false", "true",
+		"0", "1",
+		"disable", "enable",
+		"on", "off",
+	};
 
-static int
-get_infinite_rx_arg(const char *key __rte_unused,
-		const char *value, void *extra_args)
-{
-	if (extra_args) {
-		const int infinite_rx = atoi(value);
-		int *enable_infinite_rx = extra_args;
+	for (unsigned int i = 0; i < RTE_DIM(values); i++) {
+		if (strcmp(value, values[i]) == 0) {
+			*flag = !!(i & 1);
 
-		if (infinite_rx > 0)
-			*enable_infinite_rx = 1;
+			PMD_LOG(INFO, "%s set to %s",
+				key, *flag ? "true" : "false");
+			return 0;
+		}
 	}
-	return 0;
+
+	PMD_LOG(ERR, "Invalid '%s' value '%s'", key, value);
+	return -1;
 }
 
 static int
@@ -1479,7 +1478,7 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
 		dumpers.queue[0] = pcaps.queue[0];
 
 		ret = rte_kvargs_process(kvlist, ETH_PCAP_PHY_MAC_ARG,
-				&select_phy_mac, &pcaps.phy_mac);
+					 &process_bool_flag, &pcaps.phy_mac);
 		if (ret < 0)
 			goto free_kvlist;
 
@@ -1518,9 +1517,9 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
 
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

