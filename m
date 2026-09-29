Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE837CA5FA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 16:45:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BA3E442FA3;
	Tue, 29 Sep 2026 18:40:37 +0200 (CEST)
Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com
 [74.125.228.41]) by mails.dpdk.org (Postfix) with ESMTP id 04CD642E15
 for <dev@dpdk.org>; Tue, 29 Sep 2026 18:39:00 +0200 (CEST)
Received: by mail-pz2-f41.google.com with SMTP id
 d2e1a72fcca58-85f0fc1fd8eso2201973b3a.1
 for <dev@dpdk.org>; Tue, 29 Sep 2026 09:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790699939;
 x=1791304739; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sDLiUUnbKLszE9aUjcjOZPUklL30BkbCGxMAPtpFsmg=;
 b=cKLUUCNtky3BIkRzHDvmbXIIhijRcicYJsOBgox/g46KPjfHbmcga/zjmeUZUgOBAG
 aobcubhpx8FKr2LWSGaheXgMvKZetPcrZStr0fpnfXI9ZWz19NdtXx8CfdQuzk0EB/Hp
 lB8+59SW836aScucwU/lqB2ednpxdO6rcOAWxeAp1bVxc5NrhmemOR3o+H0M2y7Iu95v
 FybJrj65vKvuKYHjroD3lhV0XWU9YnO9MiJB8qpl5p3hZHwvzRjWvzzeUWQfnJ2lDN6y
 c4gZWWPlBuohB9F+nX3eN3K/rm7qBl1A+eH5ot2LtppiYRwypfgbssHS2wmUOYAombbF
 wVUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790699939; x=1791304739;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sDLiUUnbKLszE9aUjcjOZPUklL30BkbCGxMAPtpFsmg=;
 b=Z1GkB2YwL94aek88PNSuQ82Pi4I5X+pSuXjlDDQ++55nRv2BL+ylYq630UHQE6tZZq
 8mvnSS5h2zcuiP/0uqmnEGXpmWewR2ZCCe5n7UeWC6JPlUdiD23peY9GCZ/rsEAPMI0Z
 uD6kD+9xjmRCFgk31/k1Nar/Ooo8u3zGAm9l5FvLewv7rdeGfx2g2RLnTM/A2svS47j3
 /j/tMWpLebnya2QFQdaP3oKrxzR9s/Ybp7oJCECE+22mPw4sCVrlxeDtJ5s6pXTpnu5q
 /YpnYWd6iV8TxYPBLksfM/a2s/R7GlQ6uHW4ymAVBWb42WD0b4R0W8INr5iPXpdasSda
 Xt9A==
X-Gm-Message-State: AFuF++lD1Cp4bcis9cWv03SeUbPAaPUxHNnhCtdvrtYLaIpPKQ446YOQ
 wAPzZhiS/tD48+jmeY8rtXSa89gVu75/3HCq2fCUdloMcIa5+Nw0wEbigtCN1Tb9gUsuRe00gi3
 7G5gVwTrf4w==
X-Gm-Gg: AYBFou2d/7sD56fUepPs46p2MaA88048iETn/mqQ38bOmuO2wn1vQ+E7clxrL5DEU/y
 6YFJatDJoQ5BT9gkS/NbcUqge95Q5dN4Fu3zjyr4bZzM0HVMMHsKRm7QgeVJ9MbG8aokOAxXHkl
 KGli5lFsHr4lD6VP5b9+71xLW7ShyxcrmDjRAIUhDtX2wtk6LQc6IKzPA2NCOjhEidsDp+16kT7
 IuN5FlcYcILSUTowuGnFIe+hVBoQOECuC88iB6Ihr9uat5u36m6xjTtIeYa4j0aUjlW/J6qD5Q1
 6HJvsGM9RF5XFQLNaeies0Tz9ZLIUMxQ84eJOugIj9EtbzFjafJBXn1+erjFT9bSDmO3zIo4E4d
 qt3OcJgZMgNPtTws1u0nX4XlJ7BpvPggPYgeb8+CJa+dVrWSGw6Z4LWX15x765tXNXQwEDqJYaw
 tX6Mew18a5+50/8DCDIXYI6v/tyk9KHxou8hAPgRxPkyeVBGnDjbLyxq9rhFe7jbjZVVnCgeCXC
 CjZKRKgY1gMxokWH7ePsUsmlcMaGhW+rMC81r21Beux3O/v
X-Received: by 2002:a05:6a21:328b:b0:3dd:ebf7:a21e with SMTP id
 adf61e73a8af0-3de0e7f02ffmr16363847637.35.1790699939133; 
 Tue, 29 Sep 2026 09:38:59 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8868ba02d02sm232392b3a.21.2026.09.29.09.38.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:38:58 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v2 58/61] net/ice: use kvargs hex helper for debug mask
Date: Tue, 29 Sep 2026 09:37:01 -0700
Message-ID: <20260929163800.1108305-59-stephen@networkplumber.org>
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

