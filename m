Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8062CA9EBD
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 02:29:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F1E054065A;
	Sat, 10 Oct 2026 04:29:00 +0200 (CEST)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53]) by mails.dpdk.org (Postfix) with ESMTP id 0DA76402DA
 for <dev@dpdk.org>; Sat, 10 Oct 2026 04:28:57 +0200 (CEST)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-38ec1402b05so91451a91.2
 for <dev@dpdk.org>; Fri, 09 Oct 2026 19:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791599336;
 x=1792204136; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wsiTfJ2owh0xMa4AwNgW2k6BkAaTt0BfMTre0gLX82w=;
 b=uO8R4x1hioPE+kiLO4qQgqFkz+BPvQwBzvh1eXRQv4PsqN3gHB3rdtR9e4kws/tv+j
 +TuJLDg1p7l0oODoJ2IfTyk5VPm3Xh1rX5k9/JUxpsQfsd6vGnGreAzdiPJJXvzNFgDA
 IPBAomsJxxFgIDJxuYKaIxYA5W/TF9BfD87f+Tenmdly4xQ98//wosknadggPCCWKQ8L
 2zZRxbiob3UY37jd3JEJDDtqjZ3S8jnFtvrbWjvRv0opnb32negGyxe31slvWlBYfm5W
 jrWvsbd50qb4hdIXJNvqMDZUScugoHtCVxAya8pS4SQMneBzrTKhm7qjochkIw2ynK9+
 GGWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791599336; x=1792204136;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wsiTfJ2owh0xMa4AwNgW2k6BkAaTt0BfMTre0gLX82w=;
 b=IQRcGBpwRBL/+U5eJB5oWt3FvxU39gWseuPkqJn7xdotpPc0QvqZvCwnPKrmrC81EB
 Xyf5uxWz4g3Zjoxl275wxSAvZfj79pqyw3EeD5PWmj2d+78qT3yi31NQGiPseHtTJTeF
 xgUqNnfsnAiC5EMB5KQ8aI9Q2O70I+iooFEs1DwOAOr9hFgz4+w7hQIiTZmlcdqiVMvZ
 r4gYyK39RTj6mMTfI7hT50mDuNGzHKGGg6KbxujSRbAtmTuYMnw23gn4KXN7JH8hJEor
 6ua+P884t1TR8aDhXglyvwkJlfxVc3r+Zat4wRfXe9v80s8HfYGk7Br0kmNfsIGu5+5g
 FUnw==
X-Gm-Message-State: AFq9FYKLKbKjjbmuQdXUIyfEc/5qSpIAfNz6S9s7yZ+4xmq4+Rjc3XcF
 7M/KNMOLRr8nxBkwbmFTFU/tZ/tUgJTLbuCZ8pe25iLuVE32u8U+LmmkCPz7hr3KFM0Erq0tgVc
 Oek5LwyI=
X-Gm-Gg: AYBFou1qrRM7cEcbN+jqMC99b/M4fuTgqMZic61uRwd9mCRAb/yBBC5zDR0eJUDip1e
 jWRffIE0JcmwiD9JHUrXYz/ZSl8NPVab8dSwqwIlDS6duHNvStlLtmeOwkLCeLxeBD8Q1m8lVL+
 7oRcxK7ADWmbQer3dB99LVZmHrMUEo6+G51LWPUFJsc4TSfPho5v9jpIINtJ4MdOnuJw6HZ2RIU
 TbOf116WuclSVomJ4IVnxAuMOzzEfya2f5DyjbelaD9o7qAIeWJqCpIR5D5DXP1cUzQ+hq2b72n
 J3pbt5MTuS4syefvbbdrOvZmIoufdvLT/qg05RsI/zrM23dVio+7Rjfnd//CoBLlJmDnPE4vYWZ
 DnVnC+W9xvfCEhZf9afeORMQ8f3y/svJdJQTTFsI2GZXay4+n2/kVtyVDS9AhyjFrtZ9IFGWIWY
 XcZuN13MIADTGxeX6PnQn9ZFq+cNL+YxCTQdw3DrGoyEHbZOsy0JMPKvqV+lrwkOWlBoZk8FIq7
 /nv/LVUetRgpfcl4QhMx8rklXPGkwHdR2rTMjI95KovVQTd
X-Received: by 2002:a17:90b:1a90:b0:39e:6a80:dd9d with SMTP id
 98e67ed59e1d1-3ab3a9aa92bmr3986717a91.36.1791599336099; 
 Fri, 09 Oct 2026 19:28:56 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab3690474esm6202882a91.0.2026.10.09.19.28.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 19:28:55 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 4/5] random: remove RDSEED fallback for initial seed
Date: Fri,  9 Oct 2026 19:27:06 -0700
Message-ID: <20261010022851.1872825-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261010022851.1872825-1-stephen@networkplumber.org>
References: <20260915192207.3926217-1-stephen@networkplumber.org>
 <20261010022851.1872825-1-stephen@networkplumber.org>
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

RDSEED is an x86 instruction that returns random bits from a hardware
source. It has well known reliability problems: it can fail
persistently when many cores use it at once, and several processors
have errata affecting it. Since "random: always use getentropy"
earlier in this series it was only reachable if getentropy() failed,
which does not happen in practice.

Nothing is lost by removing it. The kernel already mixes RDSEED into
its own entropy pool as one of several sources, so what it provides is
present in the getentropy() result anyway, combined with other sources
rather than trusted on its own.

The remaining fallback, the timestamp counter, still logs an error so
that a low entropy seed is reported.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/common/rte_random.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/lib/eal/common/rte_random.c b/lib/eal/common/rte_random.c
index 3c5b36aa2c..c14df2cce7 100644
--- a/lib/eal/common/rte_random.c
+++ b/lib/eal/common/rte_random.c
@@ -2,11 +2,6 @@
  * Copyright(c) 2019 Ericsson AB
  */
 
-#ifdef __RDSEED__
-#ifndef RTE_TOOLCHAIN_MSVC
-#include <x86intrin.h>
-#endif
-#endif
 #include <errno.h>
 #include <string.h>
 #include <unistd.h>
@@ -226,16 +221,8 @@ __rte_random_initial_seed(void)
 
 	if (ge_rc == 0)
 		return ge_seed;
-#ifdef __RDSEED__
-	unsigned int rdseed_low;
-	unsigned int rdseed_high;
-
-	/* first fallback: rdseed instruction, if available */
-	if (_rdseed32_step(&rdseed_low) == 1 &&
-	    _rdseed32_step(&rdseed_high) == 1)
-		return (uint64_t)rdseed_low | ((uint64_t)rdseed_high << 32);
-#endif
-	/* second fallback: seed using rdtsc */
+
+	/* fallback: seed using rdtsc */
 	EAL_LOG(ERR, "getentropy() failed (%s), seeding PRNG from TSC: seed has low entropy",
 		strerror(errno));
 	return rte_get_tsc_cycles();
-- 
2.53.0

