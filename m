Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D621BCA5FC5
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 22:49:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F4A843274;
	Thu,  1 Oct 2026 00:44:50 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id CC6F343250
 for <dev@dpdk.org>; Thu,  1 Oct 2026 00:44:45 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-396ccb652d7so4299695a91.0
 for <dev@dpdk.org>; Wed, 30 Sep 2026 15:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790808285;
 x=1791413085; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sDLiUUnbKLszE9aUjcjOZPUklL30BkbCGxMAPtpFsmg=;
 b=cL1wDPetXC9vd2MSlzuOeMzxJxa4hQKXHnQj2Wy5OUCCpWODSoYQhVVA5IgNKQVM1i
 cr/V9Bkihtv6Cfdzwg1m/w77YX6VF7KskUsaYtE7fUldbtm1fmF/u+Au09rGcLbTxHpC
 2RjUNs1S2xlKe7xuOhhyWpWQ9MO4eJfsArBDsjEMu6++D6nj3e/pIBpRAcPLmGgldpgc
 rr9CTo+nyW8bis6KmV0eCF9nXww1U4THGyiNLIaDV63pZ8FbmPVkhPesyZgjIJg4BO3l
 jwcAoG1Xme9RkzrLCqixhh1kV/tYfHGJ/iRyIdc67JzA5u07Hhkn7n5fc3p1NgJWj5G7
 qx9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790808285; x=1791413085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sDLiUUnbKLszE9aUjcjOZPUklL30BkbCGxMAPtpFsmg=;
 b=jjxzZyU5spngwoweh1LZ/6XhddL03RzqygUHSwotqb0vQ3IxEcE7ff9RNEOqyNQGf8
 MMUqexAMyHpUMDf32dlxigplCesQNWSQt9S/UzuqReZ9sXPpWqTBpgOypxRSXssuldw+
 XErIESfZzNo13cQ/tNLSIXH9dJHx+rD0x42/FPMR1s5p0HRWvIPo/SFyKzDSpNtt1Mjd
 6UyGzDJnMdAsub+cf1qnoBkEtF3lydDp6/miv5aeEVcnatmSHITENlav6i32VhTDeKRm
 jrkbLweVNbKBwgzhAUYJuP2QXyxlv8jt0z7hC9KUozlBMKyRWLv4GxrtiF08D5gj98W4
 waug==
X-Gm-Message-State: AFq9FYIZNHTXbHMZuGRGw8HGFn/VZmSYodJRBSrT/omZMszAA+fhgS+o
 dRPioQ6CJ9/dlpi5rw1zjDSUVKv68MoP3EPDLbbCtWjBSmXja2FvBkYPHyMhJ/i6x3ItwsYZAum
 ikCMzSxc=
X-Gm-Gg: AYBFou0CPtWd6+hpXkAR8VKAJnXyv3hJnp0yB7pW4+A7fGWFXvQasbgjzAsVGcNcFzf
 A1njKZNpzfTmCsjS3otsi9V/i3JQgQU2auoxmanBLyr/A9gIw7LpeHOj/gtkBJR+v8pOl1PuZLN
 54TvM+GbFGSzTUcyBamK9LmRe4/0uR2u5IkUtb+DIFaWHs0sM4dL4zZWZt6G0wpuZgF0NlA4oNE
 oz6okGQxah3ny7J6eWVd6Ev8rEQhAcPrGqQeNpxaaGvbHMkQtFrNRb5EoYB8u49dCVqjY3wBx3+
 137yXXs7me0uJobcA/o4fdZj6QrLYbOQFcoqF/3ZPyHbn2O+YS2drtdjllAfJ3HV0uAQtuCz+Xt
 W6nlGENgz4hHCp2d6zdwLofCoSjEPLynzypayr1YaeSvv4kXCSeWYUavanxPPwDxgv07WJXFnB3
 RDhUFG/dm5Vndmy0blIkOyi83XB2nbtGiVNzpTzHgWoDe7qRfA1mqGw38XbOETQrEaur+vzwRL6
 AblZcx4HvavRRqUCeRS1i1ds94lqLhOSrKKxw==
X-Received: by 2002:a17:90b:1d46:b0:3a4:cfc2:3517 with SMTP id
 98e67ed59e1d1-3a4d1b5dee4mr2475440a91.49.1790808284975; 
 Wed, 30 Sep 2026 15:44:44 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f4371383sm1258985a91.2.2026.09.30.15.44.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 15:44:44 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v3 59/65] net/ice: use kvargs hex helper for debug mask
Date: Wed, 30 Sep 2026 15:41:17 -0700
Message-ID: <20260930224340.58580-60-stephen@networkplumber.org>
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

parse_u64() checks errno but not the end pointer, so "hw_debug_mask=junk"
is silently accepted as zero, and a trailing-garbage value such as
"0x80zz" is taken as 0x80.

The value is documented as a hexadecimal mask, so use
rte_kvargs_handle_hex64(), which reads it as hexadecimal with or without
a 0x prefix and validates the whole string. The documented form
"hw_debug_mask=0x80" is unchanged, and so is a bare "80".

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/intel/ice/ice_ethdev.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 4c3db27812..a1ed6b5b6f 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -2144,25 +2144,6 @@ ice_base_queue_get(struct ice_pf *pf)
 	}
 }
 
-static int
-parse_u64(const char *key, const char *value, void *args)
-{
-	u64 *num = (u64 *)args;
-	u64 tmp;
-
-	errno = 0;
-	tmp = strtoull(value, NULL, 16);
-	if (errno) {
-		PMD_DRV_LOG(WARNING, "%s: \"%s\" is not a valid u64",
-			    key, value);
-		return -1;
-	}
-
-	*num = tmp;
-
-	return 0;
-}
-
 static int
 parse_tx_sched_levels(const char *key, const char *value, void *args)
 {
@@ -2427,7 +2408,7 @@ static int ice_parse_devargs(struct rte_eth_dev *dev)
 		goto bail;
 
 	ret = rte_kvargs_process(kvlist, ICE_HW_DEBUG_MASK_ARG,
-				 &parse_u64, &ad->hw.debug_mask);
+				 rte_kvargs_handle_hex64, &ad->hw.debug_mask);
 	if (ret)
 		goto bail;
 
-- 
2.53.0

