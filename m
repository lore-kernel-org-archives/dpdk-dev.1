Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1666CA5FA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 16:41:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9863942E65;
	Tue, 29 Sep 2026 18:39:26 +0200 (CEST)
Received: from mail-pz2-f38.google.com (mail-pz2-f38.google.com
 [74.125.228.38]) by mails.dpdk.org (Postfix) with ESMTP id 9098E4026E
 for <dev@dpdk.org>; Tue, 29 Sep 2026 18:38:30 +0200 (CEST)
Received: by mail-pz2-f38.google.com with SMTP id
 d2e1a72fcca58-88582e2153eso764443b3a.2
 for <dev@dpdk.org>; Tue, 29 Sep 2026 09:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790699910;
 x=1791304710; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sOJAsh+fNZvoVQ/e8BMhJYDNnd2sqRiLjcUR7J9vnHk=;
 b=vMYz5u8iXi6yWgiqzJypz4YsUvGoAV6a5U7BOT+Zf3NUK5rbq527/3/fdxW5aq+2LM
 +5pKM0D0G+IPUNadIRXKnFA2QjOBerf1X7shjsrlpd3BZOd5MaBuJ07TDTx2qpJERbAM
 2MDwHfOSrKYvPD6k0mr33566zmhdIFZGzOwy79YA/Y01G9/NK06qxKNj4+lhIlmKztKw
 9JFV2zziJrEs3nwPKkYzau1Mttd/S0wjj7IEwOEOM0qqBT+06mBOx2/qSRRE2oN7XCXx
 v2U2T8TheVE+vWKDVXFWL/sNQJWnnDBymKZE9prnhm4KNJLgDZjrFzAzRsoyuMh9QG+0
 Ye5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790699910; x=1791304710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sOJAsh+fNZvoVQ/e8BMhJYDNnd2sqRiLjcUR7J9vnHk=;
 b=f7gEtTkPnBbJj8/f83uXg6KFsAPVPn9cyGGOCFaNdU9EVcrDIkkTJp9s4kPDT0yyWj
 ePpTdLiJTqx2Rrwbbw7mv49qZR7FgwsdURfjjYZkSHokyAK+GluHHYij8S4coeY23Q+s
 1vwH7FgW6xekHGHZJZ/VGIJQBZxdHWZZVNT23WcGrGeDX6gZEclNPIAqVTCoS8zQqTIV
 EZ9PVimO5emMedIHPi1EOkMNmWqK03GUGVt4YCyO7rJnxjeHchhKaqXj7JdSJZSueeRZ
 UPwIpQTPTxQrYqYHKZLWDjnahfHvKdv1FmC2aCIgdLUdoRKOMos5F0er+fw4fl/80Zla
 A9Jw==
X-Gm-Message-State: AFuF++nLCtkfn9dOUmOQF59IObnqObIAjkRRXrVcz1YJCSmTfqjDVjxG
 KQH9FQATP255QVkZ6F2qDUGDTmVIOERUo17lQNOl1ao/bkCGwIvjqzrD7sMWqhLjaclR4waVHJ+
 7gGYZ4Io=
X-Gm-Gg: AYBFou0F9mxRdJZNo4iwp7HuXCYjtaWn77ZOSxOjQ4Q5Y0L9LWTPhR5yirBeUw9lg1n
 PpHNSSrpUTNdUfhm5M5qDTTYWnnobTQJQVm30duSZcuMNs+gz1UTApWWgJZzgHeGy5Y7bnEWp45
 Btjs8Z7tiC87hHmn9IFTfpwIMWXxSwPa/wqJC7VreHmWp+vnrYKKiTPn61FrLg0GD6QvjzstvJj
 0opaH+LAUz11WxODckw3TaCgum8qvMfiWgylNKhGUOdE6XQSwhzgvuqbplL9P6xZQNuKvf2lkrd
 AylehOZZZ2/Ak+ukzmEyGVZRTHfBO4iMxDPKrNOqMtEj4I6Brxh0VLf/oBVeFz6xOq9yuZsWNpq
 8+k3ESR8nHAcxGrowhM+EzJi8Ew8572BpeD8Mbay7BK8Thm+MYvhyT81NNp3Pch0AeYJGiflqAD
 KOM1UewNl8DX0qEoN6T9O5QzjFyjSDVVJS4QLKqagUJRI2Y08b7VYxPqjc21NEYrSNj0MSrBN9Y
 TvinuEqr+o3PhSWCNA7Ihmy5rLmFZInTiPrQg==
X-Received: by 2002:a05:6a00:3409:b0:874:478a:f7e1 with SMTP id
 d2e1a72fcca58-87e9d1f8f79mr13083287b3a.25.1790699909757; 
 Tue, 29 Sep 2026 09:38:29 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8868ba02d02sm232392b3a.21.2026.09.29.09.38.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:38:29 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v2 24/61] net/iavf: use kvargs numeric helpers
Date: Tue, 29 Sep 2026 09:36:27 -0700
Message-ID: <20260929163800.1108305-25-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929163800.1108305-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260929163800.1108305-1-stephen@networkplumber.org>
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

