Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120A0EA71A1
	for <dpdk-dev@archiver.kernel.org>; Sun, 19 Apr 2026 16:12:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 21F9840A4B;
	Sun, 19 Apr 2026 18:11:23 +0200 (CEST)
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com
 [209.85.160.53]) by mails.dpdk.org (Postfix) with ESMTP id 39A55402D9
 for <dev@dpdk.org>; Sun, 19 Apr 2026 18:11:21 +0200 (CEST)
Received: by mail-oa1-f53.google.com with SMTP id
 586e51a60fabf-41708f6c3feso1494350fac.3
 for <dev@dpdk.org>; Sun, 19 Apr 2026 09:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776615080;
 x=1777219880; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qSj3EHrq8mIN0pgpodHkBCFn7bbeyihjtBya7H0ghXU=;
 b=OOZP1mbMNR+NHIPQT23nKEJMNCyHSmar2IK4M2hrDQsZbaSb5c669Fc313xzLLHdu3
 /Xw2vvlRm1ucsg/sYHKrs41d9MX13mAh26tSRTsr4HfKkOxdziG/rVFkvHjQzEcOFoBr
 p0iVpWtioaXkUBfaxnOgOEZDB0i9SVFx2GgOTmqJc4DPGemxZB12kp/tGsUhZrwbdB3A
 /GVOswUXFaa7vUh+HgMBQdlu/PRf3c2zlpUmpNX5RJaQMODdvMWPaHuY4qd/k3lNdYzj
 phDSxtNhYhDSaqkSHbg7+SOWDifs+s/22uVoROLPs2rbHmVYbCqWGx4t8qdk4XfCF8By
 ZQ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776615080; x=1777219880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qSj3EHrq8mIN0pgpodHkBCFn7bbeyihjtBya7H0ghXU=;
 b=i7hrDKCkHwnimRHVwoNRXz4SbmN5/xNbAyGhdhPkfKMisw0VVBWdAtt5XY3reP/Cgj
 46hRo36L3pP75kP0goHGixhGNKWHpN5osQHUffFVODkOKU+kKVbU/k6ZVmwd827sei+s
 /8Ic1h6WnAo6jLgMgJzqAv03WZKWeRnsVd1E/xFG3UEeYrnYH/UsuGB2Lk6k+SGfY19u
 BIFCp7bJXTCVvgVVC17S2zR8pCmzOWqQw4zf1d+AKsVrzbLUXj4cOhDmCmxeMCbnbeYU
 6/8wYS9OEcduHbHw43BHXGZpqodSdcpJ0q+c3/KYWANYk/iJ82oE0z/4CqILgnTT8fsi
 210A==
X-Gm-Message-State: AOJu0YyBblEZ0KD1/2mSMOQlyCNtfnByjUAFUH9lH5lxrZD1djlQSze3
 nvjs880Jv/hxibgk8W97AJfFg57Uezc7TdW9ZyL55SKnXIjoKbQ4BrJKD3zFACtZkKtZfYkya1c
 SBzfW
X-Gm-Gg: AeBDietIiO95rAsGbmaOT3DChs7QZfe7sTAFXD+9TuDnQnwRsnGsEZx8gUDNqKtTOJN
 XIn+U6C04j/ZjJqC29BlQwDmHIKdvNZSbwidZBQTJfcVLx4wC2yZGmEcTVoXzp16SSD7y0MyePO
 cVs3t5NumKoK9M09XojotnsgI+3wW4LUo0pswrNRmY1DsBvy5PsoqqMeyzNVsb4vIAVrymn4d4O
 EVk6KmaUNUCqW002RvegcNflACWGQ+28XkbYOP+kfJpM2xnBZtcgpHvrJDpaVHSeqkUA03pd86N
 LXM5ZrUW3jSeRnWoKg0A1B1gp/JgGV8X0DtPuencljQIM9QO7qq5NCDtJs//7vAEjKSjig8SdHL
 1VhKFpXNoVGByVvcUAnOm2pOYeopYDA/hs52WQMxT6oQW2IcP3tZoKtgWsND2UgtwHgY+A2yBT/
 FbFeKe8O2TR6CbRXZdGL3u4dccTiPmdGurAYmgDoL50ck=
X-Received: by 2002:a05:6870:b50c:b0:416:414:bbd7 with SMTP id
 586e51a60fabf-42adecf70a8mr6317706fac.21.1776615080516; 
 Sun, 19 Apr 2026 09:11:20 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b930bca47sm5970632fac.7.2026.04.19.09.11.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2026 09:11:19 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v25 12/24] net/pcap: consolidate boolean flag handling
Date: Sun, 19 Apr 2026 09:09:45 -0700
Message-ID: <20260419161059.205954-13-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260419161059.205954-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260419161059.205954-1-stephen@networkplumber.org>
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
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/pcap/pcap_ethdev.c | 67 +++++++++++++++-------------------
 1 file changed, 29 insertions(+), 38 deletions(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 707d71fe81..2ca6837052 100644
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
@@ -881,7 +882,7 @@ eth_dev_close(struct rte_eth_dev *dev)
 		}
 	}
 
-	if (internals->phy_mac == 0)
+	if (!internals->phy_mac)
 		/* not dynamically allocated, must not be freed */
 		dev->data->mac_addrs = NULL;
 
@@ -1206,29 +1207,19 @@ open_tx_iface(const char *key, const char *value, void *extra_args)
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
@@ -1503,7 +1494,7 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
 		dumpers.queue[0] = pcaps.queue[0];
 
 		ret = rte_kvargs_process(kvlist, ETH_PCAP_PHY_MAC_ARG,
-				&select_phy_mac, &pcaps.phy_mac);
+					 &process_bool_flag, &pcaps.phy_mac);
 		if (ret < 0)
 			goto free_kvlist;
 
@@ -1543,8 +1534,8 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
 		if (infinite_rx_arg_cnt == 1) {
 			ret = rte_kvargs_process(kvlist,
 					ETH_PCAP_INFINITE_RX_ARG,
-					&get_infinite_rx_arg,
-					&devargs_all.infinite_rx);
+					 &process_bool_flag,
+					 &devargs_all.infinite_rx);
 			if (ret < 0)
 				goto free_kvlist;
 			PMD_LOG(INFO, "infinite_rx has been %s for %s",
@@ -1693,5 +1684,5 @@ RTE_PMD_REGISTER_PARAM_STRING(net_pcap,
 	ETH_PCAP_RX_IFACE_IN_ARG "=<ifc> "
 	ETH_PCAP_TX_IFACE_ARG "=<ifc> "
 	ETH_PCAP_IFACE_ARG "=<ifc> "
-	ETH_PCAP_PHY_MAC_ARG "=<int>"
+	ETH_PCAP_PHY_MAC_ARG "=<0|1> "
 	ETH_PCAP_INFINITE_RX_ARG "=<0|1>");
-- 
2.53.0

