Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 853FCFD0049
	for <dpdk-dev@archiver.kernel.org>; Sun,  1 Mar 2026 02:08:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5107C40E2C;
	Sun,  1 Mar 2026 03:07:50 +0100 (CET)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com
 [209.85.222.179])
 by mails.dpdk.org (Postfix) with ESMTP id 5C47440E25
 for <dev@dpdk.org>; Sun,  1 Mar 2026 03:07:47 +0100 (CET)
Received: by mail-qk1-f179.google.com with SMTP id
 af79cd13be357-8cb3bae8d3eso308835785a.1
 for <dev@dpdk.org>; Sat, 28 Feb 2026 18:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772330867;
 x=1772935667; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lGZmIm0E7B8srSL7KwYsxgSkZuwtES0Rk/MAKvGnlD0=;
 b=e13Mo16l/XkFWNEani7vnwjTp7i8acs93zCQfOIX9E5JvsL4AGjabVIERA5glOkTqZ
 WjijByOM+PbOHC8wzXGh8G4PPDDQtJlDNEmTe0Xo9rd0DIGzSVNLYspYGsZPELL+/6fp
 vZYaehMXY7hbiGhOIRz44iwNhHjDvcMMyxVdU62AfIL67iCA8Yw+UcyagTkh/vToa4BY
 WpaIWScePMUfcqkRhPoIS1bSgvHzEeb2qheImlOIGaLFQmZBOEh5CIG9VBedDHV7o6eS
 gtijuIpAlJw4DThn+QbVW7VGlL4JvIPW1cQOCkdaOo9+O2q9XndoM3ucVJnc9qie4IUI
 p7SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772330867; x=1772935667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lGZmIm0E7B8srSL7KwYsxgSkZuwtES0Rk/MAKvGnlD0=;
 b=NjZuG4klcam84/Lzdoehn3Egj8QYavUKbp4/oSMtubtb161UBEOkHBGjm7glDaabrn
 4fiC+IvQsgc3Cvug6GjiKm0QIE4VhwrpOkLEowBRyIS7qg3ySdGKrATSOZz2ZZ27BYqz
 KNrle5Mx51fqRva5DTqZEkglIb/3su/kAWI+2CjOrc78BUpahVhWquwf0iJOp+nMOObK
 Gn+1ydhxfkzKJ0cbWFHLddLmtn3KwagQYJSFGIZRu2gr1poRohkzeXixWpqn3E42exTn
 mii0iCm8H/vEtpwKIO4SmSp+KuLz5dUvJ4giNT9gtMDY9JKQa6YJRNZVUXFGGJlIruv4
 3ydw==
X-Gm-Message-State: AOJu0YzGG5lhmb0BuUZZeBRG8ZMSs/aG3ctFqN0qTLckMHAZOd1YS4hN
 z8Zb2QsA4ObTQS/54/VwFvBpwOb37CZXtDDDrEupFs88M5Z28tKJjf+3H5aC0hwX90H3OCCwL63
 LcCQ9
X-Gm-Gg: ATEYQzzVjKzN/1nH9b0nC1JGMiloxSSVG8JbEcejSjY8x+QHpA8M0d3PoXiD5ogvnNq
 5AFUHBey9PmTefGmmX5MjGUsee1xsSgjm13wUjxiQAY67ZuCrQQuyekarDXj8pp1tuDymzVwG8g
 U6INjcVQYRUZuTmmQ9UyyB+gUz3pI4IdsGNksNTcVBm+BBQ/6eGb1b7PnsLiHYkKtTRcTIj3dsv
 J2rjIJmeDiZDhxcBUjTGF08PwS3F5Y9VFVO3uiMNfCt+g9EKAkMStof3EJe/ijcLs4o7qfkt1va
 gud3QYxZuaPCMFZl2lw1Gl24jCicJbsXYZGEqKLji8/eBRMuJpcAKlP7ix9m68cjewYEJGDUOy6
 9XdmjBGXDiDtJvmEghIKYHYfzB5NAvZP5z7S2CHLPx7Hl1QZbZ/IoI0AU6odMYiWK0ah8WWSqwn
 itWWU+gVTxcyludeteanXwZ7zd93xQf86mH4rrSVAP3HMXLHX1cpn/LCyCBhGlyQ==
X-Received: by 2002:a05:620a:1996:b0:8c7:6f8:ae4c with SMTP id
 af79cd13be357-8cbc8df6f10mr1019583885a.43.1772330866671; 
 Sat, 28 Feb 2026 18:07:46 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf736bffsm802292985a.50.2026.02.28.18.07.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Feb 2026 18:07:46 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v18 11/23] net/pcap: consolidate boolean flag handling
Date: Sat, 28 Feb 2026 18:05:44 -0800
Message-ID: <20260301020726.852401-12-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260301020726.852401-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260301020726.852401-1-stephen@networkplumber.org>
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
index 4ae08d3b3c..a369c029c3 100644
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
@@ -891,7 +892,7 @@ eth_dev_close(struct rte_eth_dev *dev)
 		}
 	}
 
-	if (internals->phy_mac == 0)
+	if (!internals->phy_mac)
 		/* not dynamically allocated, must not be freed */
 		dev->data->mac_addrs = NULL;
 
@@ -1216,29 +1217,19 @@ open_tx_iface(const char *key, const char *value, void *extra_args)
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
@@ -1514,7 +1505,7 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
 		dumpers.queue[0] = pcaps.queue[0];
 
 		ret = rte_kvargs_process(kvlist, ETH_PCAP_PHY_MAC_ARG,
-				&select_phy_mac, &pcaps.phy_mac);
+					 &process_bool_flag, &pcaps.phy_mac);
 		if (ret < 0)
 			goto free_kvlist;
 
@@ -1553,9 +1544,9 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
 
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
@@ -1705,5 +1696,5 @@ RTE_PMD_REGISTER_PARAM_STRING(net_pcap,
 	ETH_PCAP_RX_IFACE_IN_ARG "=<ifc> "
 	ETH_PCAP_TX_IFACE_ARG "=<ifc> "
 	ETH_PCAP_IFACE_ARG "=<ifc> "
-	ETH_PCAP_PHY_MAC_ARG "=<int>"
+	ETH_PCAP_PHY_MAC_ARG "=<0|1> "
 	ETH_PCAP_INFINITE_RX_ARG "=<0|1>");
-- 
2.51.0

