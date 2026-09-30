Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DF8CA5FC4
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 22:45:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B3AE142E95;
	Thu,  1 Oct 2026 00:44:02 +0200 (CEST)
Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com
 [74.125.227.170])
 by mails.dpdk.org (Postfix) with ESMTP id 5A9DD42E5A
 for <dev@dpdk.org>; Thu,  1 Oct 2026 00:43:59 +0200 (CEST)
Received: by mail-pj2-f42.google.com with SMTP id
 98e67ed59e1d1-396ccb65437so3506098a91.3
 for <dev@dpdk.org>; Wed, 30 Sep 2026 15:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790808238;
 x=1791413038; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=T/WAQD5oaNv4lxfHcblbwU4iJfnsR7jKB5NaEQ4aPGI=;
 b=bK3NbTotFXWtdINBVP5w2wGuZPha75Tmy9M5IW74hCWhfsL16HERDj9rR+IwJFTxgK
 AvAq5OqoQu7OL+DG05gLZ9bSmAa12Jsyo5ULduP2br/vBNcFw7O8g2Dece7yoTcVFAw3
 wNAWCMQEAzve3E/7gbBDdkwfAjJk38RHH/w7ldFaDBh2UHQI/Fz8UCttnX6T36DTIGE/
 mYYtkgcUxUdSPJ4io2PyXLYbvf6A4youMx7MLpPcv2nQ9i+PMDjnjlOTm8O7RevQ8137
 8WZSsYzzzGoJxTrAo3NtaOpcKk9fxSOlv/acprrDWPemO+/bxC816U2tcvLxl1hen6WV
 tG+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790808238; x=1791413038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=T/WAQD5oaNv4lxfHcblbwU4iJfnsR7jKB5NaEQ4aPGI=;
 b=tDH1HcDrXnS1yHAP0KBZsIELjivmrZAV2VPmihkFC5hAU/gw/X2mIY5ZzgeMX9SLXj
 Gg1PMO4UBbl+9yW4HpoZqcBVpNTUiC4Ehz+Zu4VYFThKZXevegxeTHa+FxhQCtxQWE4d
 t0MBM7cQ3rRuTIypBikWBOPPUQA3tqvJyvKH5Hs5OpQuxbAG0aRrF9lEaRYhTu0JQB8r
 cBmkvRkofZ1qgUfDWHljo/kfMEWk33YMEcGiPdPWGQNQhBx8h54nCs2qH7kGGrMLJyFs
 H7mzWaLhSg51eGwiakN4sDr8fh4GaUlUkvp3sT1vrAtTJq1O1Lerq/7/OLmnVUg17Yn3
 oGrA==
X-Gm-Message-State: AFq9FYJOfENvV+YGSF1QJd8TYxHTFLXbh96GjrR7dRUhx4Vr0VeOtyfz
 YS3fpWsUEFNAUfjP0z5QWE8YIWB8iukGlnQobBPs9NHZGa9vyjvSMm3GH/NcGBSkeLf1DifQp/I
 XzXAYDf0=
X-Gm-Gg: AYBFou0Zr+g+WEoWLJAu7YS44VwP5PuEXT/L7/GhLbhXaOxrEb+tQK5U7YbLNc2EYjA
 SEOo3Uoox0h6wlo9287sIG7QDmEQl3cP0zmTRpG+5AdsocDecHmtyAYT9GfpypnU9+ahEOKYUsk
 dc6FfHekJSBLh76fSdg6wb5b32suI3oA1M8IqiH+8heIlK9YOaJpcUK07Om+uznkNpYNyKiCMB1
 3F3ls92pj6a7KMiBWS3KPBDW6UOhUdx6NY5o9Y9XjRsedifVSk8Ne9vbSP2h7Ct9gjJPXXz4ewm
 +9JHzlagHgikrAZgTq9nN2LoeqZ7yGUCUHGfZBQ/0f+NeTboUxiv/jJi234IX4mxT1KLn8QddKb
 GlUI0OOtqzS5KlKut2zAMcn8PPkqWUpnU96akpOi6WCImV+4NYSr2aPnwP6Cxt/wv7cm1rL9xLj
 jgsYT8FlUQFSTv9c6EfYQtC93zlRxqRuvT7bBq1/SRSrwlrLRr1KBsyrh4pYGyIAiG31LPdP1tI
 5JWw523Jn3NYP7T6obE5IkygjZfDucey+r0XA==
X-Received: by 2002:a17:90b:2687:b0:3a4:b8f2:7686 with SMTP id
 98e67ed59e1d1-3a4d197e470mr1881338a91.12.1790808238434; 
 Wed, 30 Sep 2026 15:43:58 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f4371383sm1258985a91.2.2026.09.30.15.43.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 15:43:58 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 15/65] net/pcap: use kvargs numeric helpers
Date: Wed, 30 Sep 2026 15:40:33 -0700
Message-ID: <20260930224340.58580-16-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930224340.58580-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260930224340.58580-1-stephen@networkplumber.org>
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

The open coded conversion is correct, but the same checks are now
available from kvargs.

process_bool_flag() duplicated what rte_kvargs_handle_bool() does, so
drop it and use the helper for phy_mac, infinite_rx and eof. The
process_opt() form newly enables the bare "infinite_rx" spelling: the
value == NULL branch of process_bool_flag() was dead, since
rte_kvargs_process() rejects a missing value before the handler runs.
The usual words such as "on" and "true" are now accepted as well,
while an empty "infinite_rx=" is rejected rather than taken as true.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pcap/pcap_ethdev.c | 51 ++++++++--------------------------
 1 file changed, 12 insertions(+), 39 deletions(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index b1f3718c8a..df3a480f97 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -1584,46 +1584,19 @@ open_tx_iface(const char *key, const char *value, void *extra_args)
 	return open_iface(key, value, extra_args);
 }
 
-static int
-process_bool_flag(const char *key, const char *value, void *extra_args)
-{
-	bool *flag = extra_args;
-
-	if (value == NULL || *value == '\0') {
-		*flag = true; /* default with no additional argument */
-	} else if (strcmp(value, "0") == 0) {
-		*flag = false;
-	} else if (strcmp(value, "1") == 0) {
-		*flag = true;
-	} else {
-		PMD_LOG(ERR, "Invalid '%s' value '%s'", key, value);
-		return -1;
-	}
-	return 0;
-}
-
 static int
 process_snapshot_len(const char *key, const char *value, void *extra_args)
 {
-	uint32_t *snaplen = extra_args;
-	unsigned long val;
-	char *endptr;
-
-	if (value == NULL || *value == '\0') {
-		PMD_LOG(ERR, "Argument '%s' requires a value", key);
-		return -1;
-	}
+	uint64_t val;
 
-	errno = 0;
-	val = strtoul(value, &endptr, 10);
-	if (errno != 0 || *endptr != '\0' ||
-	    val < RTE_ETHER_HDR_LEN ||
-	    val > ETH_PCAP_MAXIMUM_SNAPLEN) {
-		PMD_LOG(ERR, "Invalid '%s' value '%s'", key, value);
+	if (rte_kvargs_to_uint(value, RTE_ETHER_HDR_LEN,
+			       ETH_PCAP_MAXIMUM_SNAPLEN, &val) < 0) {
+		PMD_LOG(ERR, "Invalid '%s' value '%s'", key,
+			value == NULL ? "" : value);
 		return -1;
 	}
 
-	*snaplen = (uint32_t)val;
+	*(uint32_t *)extra_args = val;
 	return 0;
 }
 
@@ -1932,8 +1905,8 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
 
 		dumpers.queue[0] = pcaps.queue[0];
 
-		ret = rte_kvargs_process(kvlist, ETH_PCAP_PHY_MAC_ARG,
-					 &process_bool_flag, &pcaps.phy_mac);
+		ret = rte_kvargs_process_opt(kvlist, ETH_PCAP_PHY_MAC_ARG,
+					 rte_kvargs_handle_bool, &pcaps.phy_mac);
 		if (ret < 0)
 			goto free_kvlist;
 
@@ -1971,9 +1944,9 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
 				ETH_PCAP_INFINITE_RX_ARG);
 
 		if (infinite_rx_arg_cnt == 1) {
-			ret = rte_kvargs_process(kvlist,
+			ret = rte_kvargs_process_opt(kvlist,
 					ETH_PCAP_INFINITE_RX_ARG,
-					 &process_bool_flag,
+					 rte_kvargs_handle_bool,
 					 &devargs_all.infinite_rx);
 			if (ret < 0)
 				goto free_kvlist;
@@ -1991,8 +1964,8 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
 		 * Check whether to signal EOF via link status change.
 		 */
 		if (rte_kvargs_count(kvlist, ETH_PCAP_EOF_ARG) == 1) {
-			ret = rte_kvargs_process(kvlist, ETH_PCAP_EOF_ARG,
-						 &process_bool_flag,
+			ret = rte_kvargs_process_opt(kvlist, ETH_PCAP_EOF_ARG,
+						 rte_kvargs_handle_bool,
 						 &devargs_all.eof);
 			if (ret < 0)
 				goto free_kvlist;
-- 
2.53.0

