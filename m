Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC77BD2FEC4
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Jan 2026 17:22:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8C26B410EE;
	Tue, 27 Jan 2026 18:21:57 +0100 (CET)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53]) by mails.dpdk.org (Postfix) with ESMTP id 2EBFA410D0
 for <dev@dpdk.org>; Tue, 27 Jan 2026 18:21:50 +0100 (CET)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4801c731d0aso47236925e9.1
 for <dev@dpdk.org>; Tue, 27 Jan 2026 09:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769534510;
 x=1770139310; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rRDUntMtglAIqr5iTE0s7JkluPjS4LPZYKAuPfzx35E=;
 b=LUXARmPY9KhIpZmZ/08Ew6rV0vGnk3W8frcfSRvhSZ3Uxs8J1Jxt/MZ8SgenC3OAWm
 PI6Et9X98NEHPRgtga2XiVcvd8ge3Lo89d3VDtv4a5mEv8BhNGqUGzFC8h3VSwLhlhp4
 TfjlWIjMmkS5kI+TVcjJQ+M9W/YVw+jwaOgmT04Q7kZXZwoOvwma6Jk2NmWLbY8kRt2V
 6Sx7z6pWUAt0QrRDSRd6Yk4UEDwLN2l1EByqfACro9L2mfjAhESo4OOgV1dz1mBAU6Oz
 /M7WVvWIBAXldvCEOlisJTJbM2v32q1I9BwCRT/jKaow+XyHwtRmF7vdRUy1XaulzhSp
 TCuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769534510; x=1770139310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rRDUntMtglAIqr5iTE0s7JkluPjS4LPZYKAuPfzx35E=;
 b=Z6cnKwuja/VCjQYk5ZoDhsqu4CLYJnOsvTrFQ9AtucKXmQeiGx/qYVaP8/0N21wX6q
 K97zvNILpa4s1ZjKs6FQ528HTI9Eq3esIv6NoFZrHFj4Tv24y97CHXt0K819fgpN5XUG
 sg2kgHLNL16id3PIN46bbzvyWIdBwTNF9NkYfuA3aK26Hr4D0Z3sGFoh3D9nMdy5+53M
 9kd4P/D1im2JBFbt5H0UVDecueBQinjUXBxSN3904sx17nR7Rwf/9gwbnTDieEZ0z4qQ
 xtor5Bi7ZYRRUzmP6mTIaSoTeZCfHfzZR/vhOBoHgu5cveFdayQC7OU5pVB9jzMk61SK
 7Fdw==
X-Gm-Message-State: AOJu0YwwXAtvmYEbpizGh8PGD+RqBz68RDQvjFIkYCxMlMSBLPX4JNT3
 MNG1zZLTWGCiMZKBkdxEyoUI5qca2Q8wjhxx0ryzWy7ahLTbdlisnM8otGQDwqzShYMj3EDVi72
 MhJHM
X-Gm-Gg: AZuq6aJVRMv3LIyoUCvGn67FC7QJJ2UEwVd07VyZXMmVFCmgyXqm1O9DxBRRg1wI6Zn
 t9maIUTGI1FLFUZmtowoSdx7tqCv+Z0Pac+uHVF7jYYC6sXPpZvqJhPMoOnPqJ999KHbzHXD7OW
 tdWdkvrkjCJLVaFBCdpGdLtXf5cXj4jTEql1KWjztKXbFyO5kdhaul++9buTyDdbJy356L5F7mv
 eKvueyP3XckUAjz9s8WFFtqrN9IA8RIdWiqg0oG0m3buw+mC9Q+OkgQnOAysvSVt+R7H+qo+HO+
 QRHt2Eb3HjYGDKUNi1j9NUHYYtGcaT4ApmbnrPYK3JUn/gdRWDwAF8lbzJCxByp4z3wsX9xtqxO
 lb4saHHIvUOFiSwcWbAVfdV3KID3El7qQBjzEhk/8iMxzMUtT2+i/eePw9ourm/9+Su8d/+6xFG
 MtOznOFzSS0WX7CTA3rI9Iwnl9BRRRFcX1/3RR8gBSI5JZTGfLUQ==
X-Received: by 2002:a05:600c:46d5:b0:47d:264e:b435 with SMTP id
 5b1f17b1804b1-48069c489c9mr30069295e9.22.1769534509706; 
 Tue, 27 Jan 2026 09:21:49 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806ce56490sm4769395e9.12.2026.01.27.09.21.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 09:21:49 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v8 07/14] net/pcap: consolidate boolean flag handling
Date: Tue, 27 Jan 2026 09:18:48 -0800
Message-ID: <20260127172128.124473-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260127172128.124473-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260127172128.124473-1-stephen@networkplumber.org>
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

