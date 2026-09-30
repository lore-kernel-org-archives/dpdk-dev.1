Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A189BCA5FC5
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 22:46:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC2F042EE0;
	Thu,  1 Oct 2026 00:44:12 +0200 (CEST)
Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com
 [74.125.227.168])
 by mails.dpdk.org (Postfix) with ESMTP id 7F7DD42ECF
 for <dev@dpdk.org>; Thu,  1 Oct 2026 00:44:10 +0200 (CEST)
Received: by mail-pj2-f40.google.com with SMTP id
 98e67ed59e1d1-3a0f64df6a6so2435715a91.3
 for <dev@dpdk.org>; Wed, 30 Sep 2026 15:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790808250;
 x=1791413050; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sOJAsh+fNZvoVQ/e8BMhJYDNnd2sqRiLjcUR7J9vnHk=;
 b=dQPmwWpAkpqMZ9H6BNOu2pbgBDMBhxWorNXg8ei99ceoucn+8CCXc4G+flCua5jFLA
 Tgb+wJnDhJiK2NfQpFtKBp0Yruoz7L/2qJ6++PAEPgDKfRrTbGm8DyFclom2fBGAD1qq
 j2z35hZ3/CuWH/U35Q606ls1KcSYOLsOzKBWjr2bD1Y29mhlgdfA/YsxXyvPfJrAg1o/
 GQ5zc9+97kuA9NHdSy2u4sxl5apxvcidwjwVasfRw1Tu/mw9wNEaFDjG0gUJ6b9SUbuT
 My1+lPN9K6Ns9oIaYp1icLMEwC0HVc5tqDAUwMEzimPrG5EBXhMo57BNoqGRPffdbnAq
 UbZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790808250; x=1791413050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sOJAsh+fNZvoVQ/e8BMhJYDNnd2sqRiLjcUR7J9vnHk=;
 b=RA1Z1V7GSROXvxtQqNfJqLum/dC1GBZItuMWfrAbg2B3+3/5zM8PA/P0uWWOfGPBvy
 AK2HXAfhagsYYq2yjLRYOXnZJ+Y+xGDdvatSiszDBLjjx26OfC3Sq63lkBilydrls3by
 gMk7Q8W7oJG9wyr6TsjVvg8PHK1Ksk23YMWqcar7CBfD/HRQweCexR+4YJyVGzjK3I1h
 3Mxu3T65U5T1CbRJvLTlYSA8IyCxLzV/hLSbNkCizOC8YlFLdKH7Sc2x+K2KSrAp2VUE
 SLtJlDRsZJmkqmEqzoTCgTVJ+wMsmBb4R0o6nWNzK6MndiV7X7PBjLLDm1CDnpY0W7hW
 12tg==
X-Gm-Message-State: AFq9FYJ8PFIjpuF2ByCMw4nH+yd8zBGig2NrTXM1BVxDNOEdoorL9WNQ
 1c8u9s5eMx+UWSLZQg2PRVk/2uie/L1VUC53558ZKLXHKuhPPEW55/S/k05ckea8EXmdw3GYAN/
 SNOGA858=
X-Gm-Gg: AYBFou1mdBHZlzDb+nk5+oxZv2pB0McINr1FWRAzDaO7I00T8ibPSGWuS1Nwb3AdkqV
 hpM1wIJ8IDT7LNcKA/Uhiwt7U8PkqnVGcaYko72M6Ve4uSxneuVqg94gVNIA/grj3tuAhjkBEG3
 inriYEKaOuOES2EleElDELgj1nrFrglmyfBfgvbrL08jZHbVyJuXd9BzFFBHuSP0hqAAuzR9Qwo
 R3ivcckBd9LNCJ2n2FsUGsg5NdnfG0jfDWsYlNMWwSF6DHdz4xYbkgUTyzYM77TIlMR3Ldjr6ad
 0FefobtNRjlzgJsT7ZmNPq9eUr6qGJrnHK57jKhYvJ8ynCFL7ZJN8Zs/X5Q7uQ/V16D6tHzKvXJ
 3t3dvcLOfqbERUOxN1W4jX46JKpAifBi1d58haG4vM5TTNeGv7BCnl8sLcvhzOpQSiTWtbq6z2m
 cfkaLN7GNRxZU0kru6hXZGYcUUs8PKVgqT9DSLNbYE93jOvaSWM4oZJn7xXPkvfGE55xfiywudC
 LUgXpZPNqbNt9C+MRksvc9vg9forNAs4wtXmN0=
X-Received: by 2002:a17:90b:3ccb:b0:39e:6a80:b796 with SMTP id
 98e67ed59e1d1-3a4d18c4d32mr2528977a91.38.1790808249604; 
 Wed, 30 Sep 2026 15:44:09 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f4371383sm1258985a91.2.2026.09.30.15.44.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 15:44:09 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v3 25/65] net/iavf: use kvargs numeric helpers
Date: Wed, 30 Sep 2026 15:40:43 -0700
Message-ID: <20260930224340.58580-26-stephen@networkplumber.org>
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

parse_u16() ignores the end pointer, so "8junk" is accepted, and assigns
a u64 into a u16 without a range check, so "65536" wraps to zero. Zero
is still rejected, as it is the unset marker for quanta_size.

parse_bool() checks neither errno nor the end pointer.

iavf_parse_watchdog_period() uses atoi(), which cannot report an error
at all, so a malformed value becomes zero and the negative check never
fires.

no-poll-on-link-down, auto_reset and enable_lldp are booleans, so make
the fields bool and use rte_kvargs_handle_bool(). That is every caller
of the local parse_bool(), so it goes away too. A bare key now enables
the option, and the usual spellings are accepted.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/intel/iavf/iavf.h        |  6 +--
 drivers/net/intel/iavf/iavf_ethdev.c | 55 +++++++++-------------------
 2 files changed, 20 insertions(+), 41 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
index eb7cf2b58d..8f31fbabbf 100644
--- a/drivers/net/intel/iavf/iavf.h
+++ b/drivers/net/intel/iavf/iavf.h
@@ -324,10 +324,10 @@ struct iavf_devargs {
 	uint8_t proto_xtr[IAVF_MAX_QUEUE_NUM];
 	uint16_t quanta_size;
 	uint32_t watchdog_period;
-	int auto_reset;
-	int no_poll_on_link_down;
+	bool auto_reset;
+	bool no_poll_on_link_down;
 	uint64_t mbuf_check;
-	int enable_lldp;
+	bool enable_lldp;
 };
 
 struct iavf_security_ctx;
diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index a8abe0154c..27d6f73b94 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -3,6 +3,7 @@
  */
 
 #include <ctype.h>
+#include <limits.h>
 #include <sys/queue.h>
 #include <stdalign.h>
 #include <stdio.h>
@@ -13,6 +14,7 @@
 #include <stdarg.h>
 #include <inttypes.h>
 #include <rte_byteorder.h>
+#include <rte_kvargs.h>
 #include <rte_common.h>
 #include <rte_os_shim.h>
 
@@ -2401,11 +2403,10 @@ static int
 parse_u16(__rte_unused const char *key, const char *value, void *args)
 {
 	u16 *num = (u16 *)args;
-	u16 tmp;
+	uint64_t tmp;
 
-	errno = 0;
-	tmp = strtoull(value, NULL, 10);
-	if (errno || !tmp) {
+	/* zero is not accepted, it is the "unset" marker for this argument */
+	if (rte_kvargs_to_uint(value, 1, UINT16_MAX, &tmp) < 0) {
 		PMD_DRV_LOG(WARNING, "%s: \"%s\" is not a valid u16",
 			    key, value);
 		return -1;
@@ -2416,35 +2417,13 @@ parse_u16(__rte_unused const char *key, const char *value, void *args)
 	return 0;
 }
 
-static int
-parse_bool(const char *key, const char *value, void *args)
-{
-	int *i = (int *)args;
-	char *end;
-	int num;
-
-	num = strtoul(value, &end, 10);
-
-	if (num != 0 && num != 1) {
-		PMD_DRV_LOG(WARNING, "invalid value:\"%s\" for key:\"%s\", "
-			"value must be 0 or 1",
-			value, key);
-		return -1;
-	}
-
-	*i = num;
-	return 0;
-}
-
 static int
 iavf_parse_watchdog_period(__rte_unused const char *key, const char *value, void *args)
 {
 	int *num = (int *)args;
-	int tmp;
+	uint64_t tmp;
 
-	errno = 0;
-	tmp = atoi(value);
-	if (tmp < 0) {
+	if (rte_kvargs_to_uint(value, 0, INT_MAX, &tmp) < 0) {
 		PMD_DRV_LOG(WARNING, "%s: \"%s\" is not greater than or equal to zero",
 				key, value);
 		return -1;
@@ -2515,8 +2494,8 @@ static int iavf_parse_devargs(struct rte_eth_dev *dev)
 	int ret;
 	int watchdog_period = -1;
 
-	ad->devargs.auto_reset = 1;
-	ad->devargs.no_poll_on_link_down = 1;
+	ad->devargs.auto_reset = true;
+	ad->devargs.no_poll_on_link_down = true;
 
 	if (!devargs)
 		return 0;
@@ -2550,8 +2529,8 @@ static int iavf_parse_devargs(struct rte_eth_dev *dev)
 	else
 		ad->devargs.watchdog_period = watchdog_period;
 
-	ret = rte_kvargs_process(kvlist, IAVF_NO_POLL_ON_LINK_DOWN_ARG,
-				 &parse_bool, &ad->devargs.no_poll_on_link_down);
+	ret = rte_kvargs_process_opt(kvlist, IAVF_NO_POLL_ON_LINK_DOWN_ARG,
+				 rte_kvargs_handle_bool, &ad->devargs.no_poll_on_link_down);
 	if (ret)
 		goto bail;
 
@@ -2568,15 +2547,15 @@ static int iavf_parse_devargs(struct rte_eth_dev *dev)
 	if (ret)
 		goto bail;
 
-	ret = rte_kvargs_process(kvlist, IAVF_ENABLE_AUTO_RESET_ARG,
-				 &parse_bool, &ad->devargs.auto_reset);
+	ret = rte_kvargs_process_opt(kvlist, IAVF_ENABLE_AUTO_RESET_ARG,
+				 rte_kvargs_handle_bool, &ad->devargs.auto_reset);
 	if (ret)
 		goto bail;
 
-	if (ad->devargs.auto_reset != 0 && ad->devargs.no_poll_on_link_down == 0) {
+	if (ad->devargs.auto_reset && !ad->devargs.no_poll_on_link_down) {
 		PMD_INIT_LOG(WARNING,
 			"no-poll-on-link-down=0 is incompatible with auto_reset=1, ignoring");
-		ad->devargs.no_poll_on_link_down = 1;
+		ad->devargs.no_poll_on_link_down = true;
 	}
 
 	if (rte_kvargs_count(kvlist, IAVF_ENABLE_PTYPE_LLDP_ARG) > 0) {
@@ -2586,8 +2565,8 @@ static int iavf_parse_devargs(struct rte_eth_dev *dev)
 		goto bail;
 	}
 
-	ret = rte_kvargs_process(kvlist, IAVF_ENABLE_LLDP_ARG,
-				 &parse_bool, &ad->devargs.enable_lldp);
+	ret = rte_kvargs_process_opt(kvlist, IAVF_ENABLE_LLDP_ARG,
+				 rte_kvargs_handle_bool, &ad->devargs.enable_lldp);
 	if (ret)
 		goto bail;
 
-- 
2.53.0

