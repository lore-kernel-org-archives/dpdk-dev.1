Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 626C0C88E75
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 19:23:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1048142E9E;
	Tue, 15 Sep 2026 21:23:09 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id 497FF42EAB
 for <dev@dpdk.org>; Tue, 15 Sep 2026 21:23:08 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-39e03468a5fso104138a91.0
 for <dev@dpdk.org>; Tue, 15 Sep 2026 12:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789500187;
 x=1790104987; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0RP29ELuiCcYMSd4b0CtRANBR1VVOkOtMwFLMT2i8tw=;
 b=wMoDIDocZ551v4oUGuI4tJQnb9BvOi6xQ8F78BU/OqOKDKslnQOc/oOKs9J4hs+1Gk
 UKeckahUCR/1/UMdidi3Oq/ha5IIsvHjmAswfQpVKNO6moUMY/vboLZ5w4cLtFGteXRM
 h4hAJWnZp/rmRCNlitGjzqE73sONccsfVr78RBYVlF2NrzlEJRU3SNtNZHbQrq4r/p3J
 2+KdxtLskd0RW+zQ/gpp6AZXHgPw4FDVb0oxfzaxAEzZvj6JgxCS38UMf4r5D6hEkwCY
 u6WTexIGe3+IuCMRPKDHw4Uy1ju+6o5YukQKOSYqah/41Dc0HWSy803UyKRPUyzSERTB
 27Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789500187; x=1790104987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0RP29ELuiCcYMSd4b0CtRANBR1VVOkOtMwFLMT2i8tw=;
 b=kHaBFXeclewfGu5V42Keah8LmpPkLjvvMEuvzZ/59Cakib/j0h2ekCEIHHh1mrzVlY
 A6XkwuulWpuL7x+QG2ptYxY+pBbk8okz0KuX8nbPs5CgvmWq2xeUZJnaBv1MhTDj1IZE
 iRaJEeeyMa4s12jYf9JEjHYTj8qZDWB+m7arlD4KbcnaAkP/phPh7j3o+SWe9Ji9tY76
 pHoDzxX2trrHjkZHowNqhbIQBUsVc7bnNo/2qwCWHD8jOHOGSxmkZxkT1Gkr0yAHYofJ
 9h6tlgPFDz4CyOJATXBZJ10hE5ah+IU7Yq3X70YuQDzgDFc5gXuHy3FWbBxKOlIFsf/0
 +2+g==
X-Gm-Message-State: AFuF++mPv1oVOU1OZsCDWDgA1Hg/Hy3ikxTcvbWvmHpplPFCmkJ2tokI
 0lNsDAUVAMxKtD2I3E8vftHYDtnWAMq7DNOcGAyevnw7VSpQrSg9tjD2U57Ywm3ptJAxriJDsOY
 fhALITQKFcQ==
X-Gm-Gg: AYBFou13cJvFweNQFAX0vn5gUgpMf61ol7slC7BlCSdrjJ1zH5DTaAa0sXiW4yG03Sj
 lNy9WbAu0TQZ57JS2HOdB+h7pxW9XatmobDgBjDs4SE7BPuP3t4XiI2x8QfXwC9oSdcN6Lb+PdD
 oLM2S9DE+YbOl3sn7L5OC5RRvB6Ha85D9H4c1rwdztsFxVWdZ2czHg+DYLo5ap/q7WIOgxWHRoj
 fI9/322Tw3Q+ATdfvuFHh0equOkdAc63btKdeHOtHC8geTd2aBB8bePXty0mADVsomTu2XPC3OF
 fE2LeAwN2c3TfeRXN2+q1q/i7TmIQeXo8BRCe6B3+1d0I+FUf4MRH+wk+OvYJaJy1zTdsrIzJAg
 JvUDmeTZyTpi3ArMGekBr9c21sfoIumWK/STlNcmOChvz7HpP+wiEJz0GbIG58u2wY6xLpZp0PG
 73KyJrVeJx2nNAJFuHAOMJMW1Zoc78kfH+drbfrJ6hrmc9ipzOOrq/wVuL53WYkqEKfREmHRJks
 Kh9ONB6VdD4UHXdSDuQqvgeExgd2gIRZdrXjIVhazIkSvoM
X-Received: by 2002:a17:90b:3c92:b0:395:4de0:b78f with SMTP id
 98e67ed59e1d1-39debf6f1ddmr14732580a91.1.1789500187408; 
 Tue, 15 Sep 2026 12:23:07 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e1bbfdd49sm217535a91.11.2026.09.15.12.23.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 12:23:06 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>
Subject: [PATCH 15/18] random: remove RDSEED fallback for initial seed
Date: Tue, 15 Sep 2026 12:21:13 -0700
Message-ID: <20260915192207.3926217-16-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915192207.3926217-1-stephen@networkplumber.org>
References: <20260915192207.3926217-1-stephen@networkplumber.org>
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
have errata affecting it. Since commit bfb3c5b9ffe7 ("random: always
use getentropy") it was only reachable if getentropy() failed, which
does not happen in practice.

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
index db4e19b414..c6f3136408 100644
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
@@ -276,16 +271,8 @@ __rte_random_initial_seed(void)
 
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

