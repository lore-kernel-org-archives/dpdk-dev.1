Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464F4C88E67
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 05:55:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C9EB42E5D;
	Mon, 14 Sep 2026 07:52:45 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id 16D6742E5D
 for <dev@dpdk.org>; Mon, 14 Sep 2026 07:52:44 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-39b350c6920so1252877a91.1
 for <dev@dpdk.org>; Sun, 13 Sep 2026 22:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789365163;
 x=1789969963; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ah6/u7uhmp7Ra/32uPxEi3SYUBcAL5CxfLyqK+R4OmM=;
 b=MEQT/QPT7oGO0Fo9mCqp2d9n/jdrKrT2YFA6jRdvgRqxIRGLjX29gH7YTrPByg2aQy
 kmrRwgAqvL4wN5aJ+R3RjZX/2EGL3nX2eMMmXLJEVOppQGXVK8y1ETps1AaAFaWoNhpF
 R/D44RBGZT39XBKioSQT3XBlqp8M+uOQ9DY8G07XIvapBPghUFcEJhdL08t5sVoghBjK
 jkzoEwPqgT+eVGgKIMkqqYh04U5bQMQnAwnpZ0Wc/iIgJfOi414ykj6Q9z9J7drYfVLc
 fufNEw/YFP2ptC5Fb6VaWHDe4hcsbwBZxs2qnURFMmWpf1r1Sfeqmw2GOff5SoPZgGeG
 Btdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789365163; x=1789969963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ah6/u7uhmp7Ra/32uPxEi3SYUBcAL5CxfLyqK+R4OmM=;
 b=m+J8ReyVtKO3xZF2jkfaFhgRVaM7HCv/5uBs+QOoApj83aTreDhELmSr/9Vfa3R8X8
 XovNoURXTvES78G6E8CAOKg3IPKr5oEAuoOu+85blkn8H6gF6BDYdwqXVFwefHKVPZU4
 6kfrjlpyyGRfSNhzKFFxl3yUhcBIu9m1EjCQdk/NJ53XSVQMM7HH68i9/s9v2YYSgFm3
 sJqfhxdWg7nvwV2Q/1B9pqBkC5atXnBuPSW1kffXmZjoqKmXX1YmwdpzsBkXZ8x69rtp
 yrIqryirI44S5UvzHSI7AmU09kiDtsDgEo6J8vooyDOt8GH+XNH6+nE+gjHwY5eLVhZh
 umJQ==
X-Gm-Message-State: AFuF++k45hC/o7Ct3h9fWfwt0NHpfEjqaPYITldPaUWvOW3aeBRu6+IT
 jJ1G433r03EBAGjAMs56mwpfVMVcf0wDr1Wjoou+IZbdWZVoM6XUrqSvYoITe8rQNuW47gxmG1E
 hauM9IU8=
X-Gm-Gg: AYBFou12fMeenMX3e2p/TCbmRepoc1dlryORjx9j8yJU4BZHHmOy+FHZPR5YkRAJiPY
 dJuxup/gicznIQ73zhDd5An0JkYijY/C8KODD3p9QmHzA5d7i69Sk7u8arxPbxKYoWOcprf7wIq
 7nqZ1As23NoOh3MWBOcaEhuUgX8jU6NHKhdsOUqJTFXij7UXBVMyD8JtjiVYeDD+9f7kdGvsF6U
 OGp2cAcwi3sltPTqC3aQ2Zu9rzpPddCOumZpVBEf0xTEf3AwiNQesSveQ6vHRBmY1aO8s5NYtn+
 Spyl8hBd8ND6hhJp9h3dL+WL+UHZSsGeYPSTNBmZs0d0mcVBEJMlN2x6TN2WVWA8EwCgQq6mmpu
 iROH/phm5amAr0P9vHtW0Q0QFNdHGBaaH9lifigohDUCPR2ySjygtjLlGHTEJkyWej64NZzibdH
 6kbHEQFo2lK6w7kDUr3Iywea4UBnBJddl06AgCQO2/Xo4Yk8/1ltPBBPVO3Ke01G36LNOxLCF/I
 HEjde3TtmmNbTgY1qY7pRdG8SlyAhdUC6rPsw==
X-Received: by 2002:a17:90b:380c:b0:39d:e1ed:fae0 with SMTP id
 98e67ed59e1d1-39debf50149mr2388316a91.5.1789365162993; 
 Sun, 13 Sep 2026 22:52:42 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d95864b4fsm19794492a91.15.2026.09.13.22.52.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 22:52:42 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH 59/62] net/ice: use kvargs hex helper for debug mask
Date: Sun, 13 Sep 2026 22:47:30 -0700
Message-ID: <20260914054912.755403-60-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914054912.755403-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
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
index af859f2174..77112bd499 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -2140,25 +2140,6 @@ ice_base_queue_get(struct ice_pf *pf)
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
@@ -2423,7 +2404,7 @@ static int ice_parse_devargs(struct rte_eth_dev *dev)
 		goto bail;
 
 	ret = rte_kvargs_process(kvlist, ICE_HW_DEBUG_MASK_ARG,
-				 &parse_u64, &ad->hw.debug_mask);
+				 rte_kvargs_handle_hex64, &ad->hw.debug_mask);
 	if (ret)
 		goto bail;
 
-- 
2.53.0

