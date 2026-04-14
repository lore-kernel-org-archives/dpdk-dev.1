Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB8FF9D0DA
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Apr 2026 16:11:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E9FE140A7D;
	Tue, 14 Apr 2026 18:10:31 +0200 (CEST)
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com
 [209.85.160.47]) by mails.dpdk.org (Postfix) with ESMTP id E915E406BC
 for <dev@dpdk.org>; Tue, 14 Apr 2026 18:10:28 +0200 (CEST)
Received: by mail-oa1-f47.google.com with SMTP id
 586e51a60fabf-409de4132b5so3692329fac.1
 for <dev@dpdk.org>; Tue, 14 Apr 2026 09:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776183028;
 x=1776787828; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+FntGUuayIiIG3a6l10GPMlr1kD9ux4MIQzJGx66yRU=;
 b=rKUQEH5r/wXxp5Q/i6SzUS6QfL5H+OVS8MwrE01MW65sseC0GiCh66FkTUvc2QErB0
 URvMtzoYXZJt6WiImjrKVh+LQhlnyTvHRj4h9V5nSV2odM2H4au68K16uD/1OpxlMviL
 S+C83QLYKj+bjnhVU+AolFGVQknOJlPS6qrYspBRDdqGITub3A4zOX/exbEeixgUmjfJ
 OaTiAY6N43iHb82fzHObaV2XE9cdQTpaqbkRbW6gQO9J5L6SdBKFASkFsdtfLS5ORTsG
 bfBttlkUW1mJUscWK0PBuvF2gG6UjEhyRO+V4NHtrOUmS9oLr5HxZRv/eTK/57FWayw4
 PZ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776183028; x=1776787828;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+FntGUuayIiIG3a6l10GPMlr1kD9ux4MIQzJGx66yRU=;
 b=K7K7ipv+dTfyIczJgde/zRsT+01hTTkJ6IHndHjBISQ6qEDHCRqdFJtpYYgfJXRPZF
 dHFGTgHYQ/3Fh++EyIosHv132Ctsko1e9mbcSyyhvlLh7mZtVWFKzAIvzApW0/qu07Ik
 yCx5ajeatbkJGrKjFayGo7goGqRXpKV/pd9UHrWjPlv+ki3Uk5BQu0rPnzE27BeW16ct
 QjYLjfOAJxKsUpZrZRJl/YIlZuZIeh0+0kp2lkuYqT52sZHkDZI8+OPzX0DNvrpzcYQ3
 25TIYk6AtAIkwjlbw4YGN/zwCMnubS6YWNKpL0Dg1xIBXk8wsKHWvkVmSAcPQ6j7VXUp
 9WdA==
X-Gm-Message-State: AOJu0YxjgaILGnr2yKG7lfF5LTNWbHqW9T6mflDjAoL9rd2Zkn6hbDvD
 eue4sgdCOxv7REwo6Hl/RYHt5bXIVIZakcaGs5ZbB9sTUfhcqrrJzPDZc6BwoFr5gn9IuVVhJnI
 cXnor
X-Gm-Gg: AeBDietA7l3odcSFKMBWoPLxdxPR1Gsi9V+/Y1avNYyCQZBsD2nEqevfuayYnNCdaCT
 zmsICjLZjn/bPbNFq6e4ssFC9IB2gmpMr7Otw1SvWYNxsZhtNoNAaJ7jwyS/mSzQp/EYq1WXnVW
 TJvQ++CWl48NnEStxc/o/nLsR0Q/fpldFEIOQmYzEnijKrJhZbcIbegjxr3JvLfkmA39HSw/Bhd
 lBrZLq0S4dUjx6gwXt45h1RgjkutNYdOimU9/XEznX2f4a4muyGJfazI4jOvct2W+cd7V9zaFLT
 2Mx5PJZAiVcCUWxEVTjYlSs41gRPLoDSJZeqxBd+lHbIPaIQXcdQXeOl2Ei7IKlvCGwEDTOF59U
 +RmbUZO7PK5EPY2pQMiWtGi7VECLKbgLai4QMXixkH6EKQ2y5NK3O4ZBfUagbvnEUCsz7yo7w1o
 SpnW0C1+YPbSMOom0gv6E+Q99BtL837r3VlILmGgWatOk=
X-Received: by 2002:a05:6870:a18c:b0:417:b01:2239 with SMTP id
 586e51a60fabf-423e10dc4bemr9705724fac.22.1776183028076; 
 Tue, 14 Apr 2026 09:10:28 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-423dd396960sm11809554fac.2.2026.04.14.09.10.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 09:10:27 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v22 12/24] net/pcap: consolidate boolean flag handling
Date: Tue, 14 Apr 2026 09:08:03 -0700
Message-ID: <20260414161011.756101-13-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414161011.756101-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260414161011.756101-1-stephen@networkplumber.org>
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

