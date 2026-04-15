Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DDB8F43830
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Apr 2026 14:49:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 70DF440A79;
	Wed, 15 Apr 2026 16:48:26 +0200 (CEST)
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com
 [209.85.160.51]) by mails.dpdk.org (Postfix) with ESMTP id 2FA7040A67
 for <dev@dpdk.org>; Wed, 15 Apr 2026 16:48:24 +0200 (CEST)
Received: by mail-oa1-f51.google.com with SMTP id
 586e51a60fabf-40efc77933fso4474099fac.3
 for <dev@dpdk.org>; Wed, 15 Apr 2026 07:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776264503;
 x=1776869303; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+FntGUuayIiIG3a6l10GPMlr1kD9ux4MIQzJGx66yRU=;
 b=gsjOo3PV7wX2uRWGwLlYRO/PaUVBP/t2HflOeHll4bQdbIMFbla1MF+eOJ7yf9qZZt
 JXnoKu79B94psx6E4kAy6d5LtQsOZVR7V9FpE79BkcF1tJmhsmtcl4ZFRVd4JbEfxxpL
 QY23ozMPdRvkbffuQtYbWkBpQyJBB2sftmBW18SNJOO2cWAVVZhoFk4A9jDa/BRMw5aZ
 Jy7jvxAqOOe0LnEraFO+IpBP60eYvObfS8d3/CWQ/5i3fCq13a/qbogPsXHBN5LG2D0J
 MZ5s91dYIt2rgDQ+12TXQTxLHdgh7PtsPmJt4s4NialV8llw2GADfgSJFm+b+49Tpna3
 ruDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776264503; x=1776869303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+FntGUuayIiIG3a6l10GPMlr1kD9ux4MIQzJGx66yRU=;
 b=PgRbY7Hem8UNCwmwyP9v1bk8SwjulV+03aUcNUPJl3iIpE0drFOY6da9TNaSp6XpAH
 CDUP/o7nTY/erpPIIypBK3+tEYXHS8OHurvUWtysmF38Ju5KUvCYF0bWMl7XnLnvfWVS
 EsuAERW8tDlcmtsrSfkK7LY6tE01QfNzJYRlHScXHvgJ0pWn3i0lrIt9btw0/ho/Ia4X
 6BU4raJxmQ8/8deFHSSATzF58lWdWLIitXjiC7cxIk1Tkh5r43b+LWflvJ7YuYw4Iviw
 S3L+G8/cmtNvRct0QszTAgl2jnnELqgLqq5gEh2os7jHcZBM3jHkBAk6wHi0FmFYP1Kd
 uhdw==
X-Gm-Message-State: AOJu0YzDuJuWN4O0l6Z2fHd42v5uVLpGY4ttUeLNW5YxIS+qDaIf6BjK
 JObt88Pb5q5lbYu9Oa29fZPhLDQWhem9v6tvI0MaiY8zUj937LocJhxQeAEUq7VwM9EjRlPyEuU
 8gz0A
X-Gm-Gg: AeBDieuo4woSCIaBq0Gfn7fMb/JvaaHLjo59c0DwIavspxkns/x6Ys9dpy17d2b9OFo
 E8BbYHGbqt8ZqwEfAUVQZhxwEZtBwUlmRrxVuRZRWEvlMoZUkvhp6CyVbb7C3DTOql+ek/pJYW6
 +cw3wKu6a67RbNesJo67kyyQkRaPT318BJyvydGfKnL74PFzClNmJ+TBRvbuMyXBXD/ls8fO5Lh
 7W+rq7C+nNix4SY/CD18G2o4t+VqSBbta+TFnkWg9sguFkiHts4ZyNvz4VxiTstMdwJM9mOyTdd
 bLinSWz2TnRgBwSVPCWjrSacEwU8NRF4UL1BUH91f5CD4FzL95d5JtHupAS8oEMyQldTeXBD727
 30ts6trJ3Ur1PviRzPxrLfzkKFGTZeoHuhsS+ZmGEU4uWdgaSda0P5zdj/Ppuxu1TaEg7UbLnCH
 mnErglnKc6aefkNa+IrfEzvQMJ3+Zb2jSXpiC3+Er4OXc=
X-Received: by 2002:a05:6808:c1f7:b0:45c:75ec:b9b3 with SMTP id
 5614622812f47-4789ca3b128mr11390746b6e.9.1776264503395; 
 Wed, 15 Apr 2026 07:48:23 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4797a53b1fesm945798b6e.16.2026.04.15.07.48.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 07:48:23 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v23 12/24] net/pcap: consolidate boolean flag handling
Date: Wed, 15 Apr 2026 07:46:01 -0700
Message-ID: <20260415144717.226161-13-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415144717.226161-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260415144717.226161-1-stephen@networkplumber.org>
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
index cfdbf3eace..955eaf17e2 100644
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

