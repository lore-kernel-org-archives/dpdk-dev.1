Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7C9CA5FC5
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 22:46:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E65E442F00;
	Thu,  1 Oct 2026 00:44:15 +0200 (CEST)
Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com
 [74.125.227.171])
 by mails.dpdk.org (Postfix) with ESMTP id 2AB1942EF2
 for <dev@dpdk.org>; Thu,  1 Oct 2026 00:44:14 +0200 (CEST)
Received: by mail-pj2-f43.google.com with SMTP id
 98e67ed59e1d1-39dacf053eeso3027887a91.2
 for <dev@dpdk.org>; Wed, 30 Sep 2026 15:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790808253;
 x=1791413053; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vPcgafvEFDD2lNnPzleYBGM772lgfV+Hr/ka2dkEPDU=;
 b=VugiGswicjJZyQ7CxSaGVJQqPoKnXZnU5TQrjJhh5E6yy8ocq+H/FpTdZLsn3lCsA8
 +hMIJgVyUwLK61Zht1hMG9VX5MLe2xnP7m1dPJdluf7jJUu6U/UUzSwyDiv86Ll/2My8
 HxSHF+7pgo19MXX2GF7YHrelwShG6ae78NZBryGEe1Huz3OyaUFnQJoDQLnoTV58idEy
 o+FtKpSWFjK1W01XvzqmZLrobXR2w+rJgMn1o0i3O5JoZbRfrWzc/AbOTtqZMZh1UK+A
 hlAWx/LQLnh7G6y0lEBid96B+J4ogfEz0SYMVUj5HZmM3sQFgeXzTrxqjOhMIrNd9noT
 mopw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790808253; x=1791413053;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vPcgafvEFDD2lNnPzleYBGM772lgfV+Hr/ka2dkEPDU=;
 b=i+hFT010gkb2/RycRNBB0Otyqb9bjCGzSIcPghdQNmiMGBMnOSNHZrxuHtRs94BEAf
 WjtsSyjxDTYPb/NwZyK9ka5bHfjyXnIl9eqsAisA7c4+7F8m0uv0ttuNMi1kxBievjrx
 9Trz1OHTk4edAp1aaDS5xKIcMuJdWJ79nvdP2YFUA11rJ9FZA3ufibCr42g9OcuBUMn8
 deYiDql1X9GcHOgkLDd9v5B9oAmKKtoBFXNLYfxiOOYDs7LhcW+yat/pI+Itwm61Dhvx
 HP3ZjJkH2aFbMz8lprP+5mbdvX+RGJpbRQo8wakY5n+37fHz8kRupbQGNJ35P9l1kkf8
 E30w==
X-Gm-Message-State: AFq9FYJ7VuVBkZjy0r//K9Fgrn1WkNpzCJELSABho63VVyHFe/0KPXc1
 ezFeuzK2RP3PPfDtOceY7yCaQukwiJoONIkDBgRp4AFeefkpM83ZAjNxns/CtvQUejRJ7cqssVf
 xHROgHZg=
X-Gm-Gg: AYBFou1RVq0s8a2y6zp0zNbd6XlKrkW+3lNAGIGMo+sJw+U4V24qN614u67c2nZ5aD2
 kubDFf/LQzbzB2V1BLtcnLUa3BIRVyRWBbmRpOIwhHF++XG60NaJLmYhdcQO90gwmX+CLqiSWH+
 y7/1tcucpFusHGAvoiq6GSlE5BSsmIV7Pt5ZGykF1Akg+4q0tJpzNfD+QI8htEtYltLvFK7ojox
 2ZPhqQpFDnLLWNuE57KAGDwJZ7P/JkBek+wkHqJGyXCuAl18Ij2DaP3Cr6xaZ068hfeCzJTqSAx
 Dpi1dMMFKC2qVpp/y0V9esUEiBLya9h0ZFWcfSNuS0ynzpaLHnD1ZgPiMrgiNM79B+oSvjVfahi
 6D8Jl/CHWj7aGnTR6ecM5iegNkrgmAIdBAuTQ4AnG5043YnNgjzDkzCuQxNQCLQLM/TRdWNN0+9
 2WMeRzAQqrmXS8eyWgV2TU+QJ0OvjnOdFlW/vaozJ6261vH/avNMCBQM564GWkR7VrRD/XCC0fT
 gJIuI1nuGhaocERuYKVNt6kNWzZDVnJiXcSHw==
X-Received: by 2002:a17:90b:3d8f:b0:3a2:11c1:fe77 with SMTP id
 98e67ed59e1d1-3a4d1ddb1c9mr1872331a91.67.1790808253259; 
 Wed, 30 Sep 2026 15:44:13 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f4371383sm1258985a91.2.2026.09.30.15.44.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 15:44:12 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Praveen Shetty <praveen.shetty@intel.com>,
 Mingxia Liu <mingxia.liu@intel.com>
Subject: [PATCH v3 28/65] net/cpfl: use kvargs numeric helpers
Date: Wed, 30 Sep 2026 15:40:46 -0700
Message-ID: <20260930224340.58580-29-stephen@networkplumber.org>
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

parse_bool() only tested errno for ERANGE and ignored the end pointer, so
"1junk" was accepted.

It also stored through an int pointer, but both device arguments are bool
fields, so parsing either wrote four bytes into a one byte object.

The handler did nothing beyond a range checked store of a boolean, so
drop it and pass rte_kvargs_handle_bool() directly, which stores a bool
and also accepts the usual spellings such as "on" and "true".

The booleans use rte_kvargs_process_opt(), so that a bare key with no
value enables the option.

Bugzilla ID: 2042
Fixes: 2d823ecd671c ("net/cpfl: support device initialization")

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/intel/cpfl/cpfl_ethdev.c | 26 +++-----------------------
 1 file changed, 3 insertions(+), 23 deletions(-)

diff --git a/drivers/net/intel/cpfl/cpfl_ethdev.c b/drivers/net/intel/cpfl/cpfl_ethdev.c
index 32e0f81d99..60ec5af31b 100644
--- a/drivers/net/intel/cpfl/cpfl_ethdev.c
+++ b/drivers/net/intel/cpfl/cpfl_ethdev.c
@@ -3,6 +3,7 @@
  */
 
 #include <rte_atomic.h>
+#include <rte_kvargs.h>
 #include <rte_eal.h>
 #include <rte_ether.h>
 #include <rte_malloc.h>
@@ -1558,27 +1559,6 @@ parse_vport(const char *key, const char *value, void *args)
 	return 0;
 }
 
-static int
-parse_bool(const char *key, const char *value, void *args)
-{
-	bool *i = args;
-	char *end;
-	int num;
-
-	errno = 0;
-
-	num = strtoul(value, &end, 10);
-
-	if (errno == ERANGE || (num != 0 && num != 1)) {
-		PMD_INIT_LOG(ERR, "invalid value:\"%s\" for key:\"%s\", value must be 0 or 1",
-			value, key);
-		return -EINVAL;
-	}
-
-	*i = (num == 1);
-	return 0;
-}
-
 static int
 enlist(uint16_t *list, uint16_t *len_list, const uint16_t max_list, uint16_t val)
 {
@@ -1756,12 +1736,12 @@ cpfl_parse_devargs(struct rte_pci_device *pci_dev, struct cpfl_adapter_ext *adap
 	if (ret != 0)
 		goto fail;
 
-	ret = rte_kvargs_process(kvlist, CPFL_TX_SINGLE_Q, &parse_bool,
+	ret = rte_kvargs_process_opt(kvlist, CPFL_TX_SINGLE_Q, rte_kvargs_handle_bool,
 				 &adapter->base.is_tx_singleq);
 	if (ret != 0)
 		goto fail;
 
-	ret = rte_kvargs_process(kvlist, CPFL_RX_SINGLE_Q, &parse_bool,
+	ret = rte_kvargs_process_opt(kvlist, CPFL_RX_SINGLE_Q, rte_kvargs_handle_bool,
 				 &adapter->base.is_rx_singleq);
 	if (ret != 0)
 		goto fail;
-- 
2.53.0

