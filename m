Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD05EE94625
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 00:02:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8FBDB4068E;
	Tue, 10 Feb 2026 01:02:21 +0100 (CET)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52]) by mails.dpdk.org (Postfix) with ESMTP id 6259B4068E
 for <dev@dpdk.org>; Tue, 10 Feb 2026 01:02:20 +0100 (CET)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-4376acce52eso170679f8f.1
 for <dev@dpdk.org>; Mon, 09 Feb 2026 16:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770681740;
 x=1771286540; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hsxIiFFYUlBYhpMCvBncGkE2MeU8+QueBza9vF08oNs=;
 b=0sZ6wjRP/n6JBssrwAtnTAyxVcSr7PR+rIChdZ+JtujSU3F4VpzQFDRA4VdY9duGgy
 d4EfLA4xf6lHwaKMBamRxRLibfxq7PqKODW11SEIqTAjGia1mO06vVaP0IzAEC/VltlP
 Wbsq8YXmUe/RHqOZqlsCYJ3onBQuI+amsleGIpJpxTY35OP5ymeFurvUfq2T4+rrRUyo
 FabcCyjNVLQr0B/+us40vuOflaWHmVA/TkgVjMHr75jdtLkiKD3p1szKXtgQHQ02rGyb
 j0PlYxdIz0mvrm4OiyvY3No03E/kFA6cWbO75KmU9WAwIaG9T/8pCe0IECtX8jeEbn+B
 2KmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770681740; x=1771286540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hsxIiFFYUlBYhpMCvBncGkE2MeU8+QueBza9vF08oNs=;
 b=d+rXiO4SA1i96TJ5ZK/5tXDL6mBo6Cp1o2Pkru1yUqdWFixix5B+ev8KEEhwrZmfGi
 sJmUXmYerznpW084oV6AbG7VPIPiJQwD31rgoDZj/4GA/BbTCf7nrQj0Benhk6MewE3Y
 rfaxb1OpYzRLwNB6eeAW0JZJjlNPCn0ZRh0YOgG85AwlXtTID9uX+/Fch4c8Jeh5W6L1
 iHSyl5ZlKMHTA92ltafJhBx/bmhoA6KoUgflrZOCg3Vc5dsPquc9MCF/7vcic/oC7pnM
 AlThgwMatCCSIHghaAfaZtsPQQpsyYPplRGSvzfy/+GQ8tTI86WQuIm9MtvNTF9Nhra/
 qZGA==
X-Gm-Message-State: AOJu0YyucJxDLBfeuzCxb6rlRk0ltXjeE5UmVtJppc37oVmwhy+XXY/F
 tbTNWHtFWu8XRam1yloDjhT66AZLwDKfy9fnOyxEhzi17ThQClztUAGyuYtQTwfAJvKgMvod9LD
 Hheqs
X-Gm-Gg: AZuq6aL0/fbKIBqZOLB2GHu+XYCQEYkl58yH1mR9tws6/uHr8rCsSvrCZ18euMYE2Rn
 XBEl+xcIeR5kODO2gQPwYnzlxeZR4jfi/rs2g57lNKPGnESgMYb3ABcgycBNsbt4m0Og48o5zqt
 /lz3qIfKR+nuFL6djJ1IRB7exAqfyLpiPogi6l3alRfq0CHRCEj5v9Guvs6hdOqHXGuCrTdeTwm
 7TaVGmM6dPXFiqAJunXLg+MWhIP8rvzq0s2KZgZwv39pYLFC67QdqXTINEW/BkXpK8CenFUhMHR
 wiysK8VVPOy9C+KsDinfkYAQwJJPd0oGYyQLHt++GAj1rReQpP5/EUwY/m4cKuCloVP6nWWbGRN
 m99kxEKGe02Fsi2XuSIdOrdiOCzpr09OIIJBH+9xefJ0Jd8iCn3hfy8sLrJOsAYrR0w2S57j8Sy
 4cE+L42TwMlmezdUt1NzXRug1QYUqf2RU+xffDgRV4KBNMiZEtjQ==
X-Received: by 2002:a05:6000:2905:b0:430:f463:b6bb with SMTP id
 ffacd0b85a97d-4362923ed4dmr18934195f8f.16.1770681739540; 
 Mon, 09 Feb 2026 16:02:19 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-436296bd211sm31529133f8f.13.2026.02.09.16.02.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 16:02:19 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v13 07/16] net/pcap: consolidate boolean flag handling
Date: Mon,  9 Feb 2026 16:00:38 -0800
Message-ID: <20260210000201.295839-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260210000201.295839-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260210000201.295839-1-stephen@networkplumber.org>
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
index 84da41542b..b77fa85dd4 100644
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
@@ -875,7 +876,7 @@ eth_dev_close(struct rte_eth_dev *dev)
 		}
 	}
 
-	if (internals->phy_mac == 0)
+	if (!internals->phy_mac)
 		/* not dynamically allocated, must not be freed */
 		dev->data->mac_addrs = NULL;
 
@@ -1200,29 +1201,19 @@ open_tx_iface(const char *key, const char *value, void *extra_args)
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
@@ -1498,7 +1489,7 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
 		dumpers.queue[0] = pcaps.queue[0];
 
 		ret = rte_kvargs_process(kvlist, ETH_PCAP_PHY_MAC_ARG,
-				&select_phy_mac, &pcaps.phy_mac);
+					 &process_bool_flag, &pcaps.phy_mac);
 		if (ret < 0)
 			goto free_kvlist;
 
@@ -1537,9 +1528,9 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
 
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
@@ -1689,5 +1680,5 @@ RTE_PMD_REGISTER_PARAM_STRING(net_pcap,
 	ETH_PCAP_RX_IFACE_IN_ARG "=<ifc> "
 	ETH_PCAP_TX_IFACE_ARG "=<ifc> "
 	ETH_PCAP_IFACE_ARG "=<ifc> "
-	ETH_PCAP_PHY_MAC_ARG "=<int>"
+	ETH_PCAP_PHY_MAC_ARG "=<0|1> "
 	ETH_PCAP_INFINITE_RX_ARG "=<0|1>");
-- 
2.51.0

