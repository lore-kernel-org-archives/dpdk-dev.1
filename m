Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEBF606A31E
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Nov 2026 19:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=d3loKB77
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 275734067A;
	Fri, 27 Nov 2026 20:42:20 +0100 (CET)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by mails.dpdk.org (Postfix) with ESMTPS id 5E36540616
 for <dev@dpdk.org>; Fri, 27 Nov 2026 20:42:16 +0100 (CET)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-8c5ebbc5150so5756725b3a.3
 for <dev@dpdk.org>; Fri, 27 Nov 2026 11:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1795808535;
 x=1796413335; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wsiTfJ2owh0xMa4AwNgW2k6BkAaTt0BfMTre0gLX82w=;
 b=d3loKB77FYn9LYy4dpwELO0vk16QY+t7Wun+fmvQutYrwRC+TDk5kj93tL0+OInOCn
 GIaAmHE8vJfYHs4603FqRBgzTh7JxS+7aDLQXoanbfdT4fdqi6QUVFkLtZaiq7FbbWXu
 4Mdu6TBVz80kOiIG5pCX3ch7nNdvQqLG/K7+zEboEdAT0/1fcBelx4KDl3slXU24RDP1
 tB6MNLBWcxqfvrwJ4oTRdRy5hGJS8rOiH2/aPhtecwnHO8qBO+ASscQQu9mZBlSv70Vd
 mLzlC5018FieLVRitpyVhRyyX3AGGeHpFnIU4dYp7+g4k5tktUp4v93tfyZYHxM9T3qK
 iFig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795808535; x=1796413335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wsiTfJ2owh0xMa4AwNgW2k6BkAaTt0BfMTre0gLX82w=;
 b=DetfTq0kQ+klCTCFPMvMubWbHra+bXmqO6xvX2mWsA2e8Md9fwbEkuLiDw6TUp8Vy8
 qdIG+ovem4AemAlhpLXAyks31wtOJtS31oXVUBXjHkqaqqBHy3gkTKvjEp4R2X5NS5fY
 xqC/SKmMgrZAL03XHXTruJ1oi9vL5ZZM9pgnK50ro9RIP4X6y+uloiYVOdwj8dWSfXmX
 AUL6mppLYzMf2UBYqdy4YzsnM6bFNEFQsHlB5N2MhbHM7UQ6PYp0SOvq90ZHn4+ye+x+
 bx8mCekSZIDra+Wmmrvtl0P7U6FhLBiRkLn5EzGDIBF3QEBTi+R/+kxxs090eNnXxdrk
 lCrw==
X-Gm-Message-State: APuU4Z9+Xp6Qoy+cbm4JajglRli5JLNE+h3SbLVTg+vmszkg4+RSgLSl
 hzuRUEz3lYk90tx3B99P6Kyr1MjyKMZuNZ0cFCIx/7W+1iGuV82TB8VOxRkXxzevLPLjt6w1vnX
 Szg2AdEo=
X-Gm-Gg: AZFdTZdll00nbkmhokSiVulYt7Yve1/69fVLq1nl7l4qIfjCaeK9I/b1l7IXP79cSYN
 isQADzfP7e4xWEsjU2KAEuQEmJdJMGJjG5L16eOc+ccxM2o90O/yYgDpyl1K/DbyfZYTcqV+b6J
 y8wBH+DcdExw8GfRdxcFKPwNIGPdvRoqIVuUnIbMQRczKoLdtA+TSufC8uYEXsM3Y2hat3RRDNK
 mylsmNzaKWxij9QBGP+4obGSytX5Y6lzh/Q3zBuAbNp5nbVlNl2Lnk1PmCFYCiy84WkVQIqUFIB
 fpsPfldPA+omHdUTAQh9P5Qe3zlHnJckpivHqCyux8Crf4TMWl52A0L2qqbAAihVqsDcLJVJMFO
 NEQJMnKkJ5HNAxGmU08kdItPrkOArAJz9lVYQblgOCWucFJQcGwAckyWM3Qzx5eY5enZDvqIVwA
 otwDu5ZMVkQ2CXtvPpELKFq+BQ46eeWnjGzLdUmnt8Oxd7pQ7eZD3C54o2yUP7Y9SQPbcJcf8Kx
 HrDhjDvLAfwdlYssuNIen/bYASgjJn6nEmBJm7oEUCQkAkIvan1s9HXvdTiCdInghmTY3G5f0Oe
 D6fKE01iKM7DN0ag9q134wf1iPKHSfjh5Txw8MJfS8QAt1aHI8iJZQjwOfm+B7cfw0Rn
X-Received: by 2002:a05:6a21:3b8e:b0:3de:4c08:174 with SMTP id
 adf61e73a8af0-4014d457f6emr28715473637.33.1795808534857; 
 Fri, 27 Nov 2026 11:42:14 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c872951febsm12881051b3a.14.2026.11.27.11.42.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 11:42:14 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>
Subject: [PATCH v3 4/5] random: remove RDSEED fallback for initial seed
Date: Fri, 27 Nov 2026 11:39:36 -0800
Message-ID: <20261127194209.107396-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261127194209.107396-1-stephen@networkplumber.org>
References: <20260915192207.3926217-1-stephen@networkplumber.org>
 <20261127194209.107396-1-stephen@networkplumber.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

