Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD90C5DF85
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 05:24:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 148374028C;
	Thu, 20 Aug 2026 07:23:54 +0200 (CEST)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by mails.dpdk.org (Postfix) with ESMTP id 863F040A89
 for <dev@dpdk.org>; Thu, 20 Aug 2026 07:23:52 +0200 (CEST)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-c9d1fff21edso1195200a12.1
 for <dev@dpdk.org>; Wed, 19 Aug 2026 22:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787203432;
 x=1787808232; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aIT++unJwIwuU+aCgjdBPE+0+JgMyMKnC4RXBYg/jy0=;
 b=sadS2FHPxhvYFKAnTaHrzxJ/lHfEorHJr/D7J8LJU9745bWiw4vWQnA3uNycYEYx+X
 NYkVenCjsWvpj9ZO+k6G/dTNu5NNIk+z7vLFuKjerArUoF/1B4mB5TIVo2Buubq92ucO
 dTFvRnCaAGLn3Z3jJaV/gKezMQA9BjEZ6VkH5czsHuXa18nddM+sxpeHgpZxBvVNLh2L
 z2a7XV3Ng3fGHvDShBzskbsEXCErxuYYOkmCJDszCfqkhbVLCWxudhYoBE/oPz6qG1Tw
 9GYtMkpFr3Iypm2jktqA542w5Yg3AuzbZMrdU5he9qRu9YXF+p6dm27XEXhlRMHbpY+a
 th9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787203432; x=1787808232;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aIT++unJwIwuU+aCgjdBPE+0+JgMyMKnC4RXBYg/jy0=;
 b=N484jyn9Vn0MGi1kysbVq+KutkSGaMyVPdYauIIycZK+qAiWXFKg6dXf+a2AqD8AaB
 VSzRanCHF7ijseK2pS4hK4tuLN+xyNMg9JHLnISy466z1Upxfd0gevuPFdtm7594OPhZ
 y8Wz6/au0Bba7Zas9cNFS4H/X75J/hFhruFI6KeSl4G6sUKTxNf9UwmAJncbpdp5MjO7
 y530FX/cffegTWGcMory0XT0ubx+OakmmLKxtTPpXd6EBZ7Cyofpcw0IzL6+zOLlON6N
 dECuxpGE4ydYbqqP/miKQ5biXP5WhsXbZu0CU6dRm+7yZEhG1Rp+XeWTKRu3boM5jEAd
 hLpw==
X-Gm-Message-State: AFuF++lGEhuzcQefiJqzCNqqeapoB2CWMTaO8xWL3jEPFUhiJaxirMVY
 0hPjGjOI2I4zOT24YmMg3LPgzjm9Y7knFrcPt44BqG7O1j6b7L+W+8CtGrN063jh/xHkF4a6PEk
 I97IC
X-Gm-Gg: AR+sD13WDTyIPUYBhMWTuH1dqjvbysZ0tLIUU3BawLsHoRF/lTMsbX6GS/Or1NpKfLP
 FUUamURPHCiMaW3f/QEl2IKZNjxttPBwm6eOZnnr671xBiQgKjF0v0/2JbbbW5fj6T1h8kZQIhd
 j1Ff7xV8ZDh6NCBlxgESEDitUWNiyW8+TEIHkEfD0vvRhGvzWFSn5P78Fs6C5uVLMLpngMsIPDH
 0USKOSbxe5x1fNqNB8AnP2AwkkG/yQyyIcLR9b71QDgALnhnda6L0s6nnt7cKFi8HQCq2c/Q742
 f5wphUvJ9qO520QiBsOY64/SGey6RoSggX2SfYU1UcGzSIYgDgMi+wj+d3i7uX6JnxHqTstqwTH
 2AXMVShT4/BndOqNmmWdKFTkaSam0WYXgtJN+ZTaXqL7HASVW+BtsKB2YWCgWtdXZlB31f5zj1Y
 S0Z+Ako1iKJcFcShZHdAh5xYDnowtOaHE1Nr4nz7574QEJSnUzmCSRPFYYYedQ+/Pmljp5fL6yV
 6iE2Zb7uT3VhuaNn8Jbvt6VYgQ=
X-Received: by 2002:a17:90b:2e90:b0:38e:c7b0:84ad with SMTP id
 98e67ed59e1d1-395804993b6mr18266245a91.0.1787203431646; 
 Wed, 19 Aug 2026 22:23:51 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bef3bb5csm13700974eec.2.2026.08.19.22.23.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 22:23:51 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 13/61] eal: replace rte_memcpy of cpuset
Date: Wed, 19 Aug 2026 22:12:03 -0700
Message-ID: <20260820052251.1453273-14-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820052251.1453273-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
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

Simple structure assignment is better than rte_memcpy.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/common/eal_common_options.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index 42cdef632f..c0e97d21ae 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -29,7 +29,6 @@
 #include <rte_tailq.h>
 #include <rte_version.h>
 #include <rte_devargs.h>
-#include <rte_memcpy.h>
 #ifndef RTE_EXEC_ENV_WINDOWS
 #include <rte_telemetry.h>
 #endif
@@ -1446,7 +1445,7 @@ eal_parse_lcores(const char *lcores)
 
 		/* without '@', by default using lcore_set as cpuset */
 		if (*lcores != '@')
-			rte_memcpy(&cpuset, &lcore_set, sizeof(cpuset));
+			cpuset = lcore_set;
 
 		set_count = CPU_COUNT(&lcore_set);
 		/* start to update lcore_set */
@@ -1469,8 +1468,7 @@ eal_parse_lcores(const char *lcores)
 
 			if (check_cpuset(&cpuset) < 0)
 				goto err;
-			rte_memcpy(&lcore_config[idx].cpuset, &cpuset,
-				   sizeof(rte_cpuset_t));
+			lcore_config[idx].cpuset = cpuset;
 		}
 
 		/* some cores from the lcore_set can't be handled by EAL */
-- 
2.53.0

