Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37AFEC77B7F
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Jun 2025 19:59:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 08E9A402DB;
	Tue, 24 Jun 2025 21:59:28 +0200 (CEST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com
 [209.85.208.169])
 by mails.dpdk.org (Postfix) with ESMTP id 6913A4025E
 for <dev@dpdk.org>; Tue, 24 Jun 2025 21:59:26 +0200 (CEST)
Received: by mail-lj1-f169.google.com with SMTP id
 38308e7fff4ca-310447fe59aso72370681fa.0
 for <dev@dpdk.org>; Tue, 24 Jun 2025 12:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750795165; x=1751399965; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nqNOMY1wgov2V5rK0aqKJG2Qi/2pAJHF1rT7FrkqRJE=;
 b=WN4Cz6JtNGxh7Eu/08+Mf5k0UvtTwSruUQVmYBBv4X6vND6Kk+NdnF367G67B3Th8t
 BdzJyaw9HXCp3TPukZO3aoe/1eVZaXWuX+Co12hjafpe+P+gSSupPNpTZ6PW+Re1m0FB
 xuqbQReZ7DtNKdJ1cqzpuzgRpQycMZMo6RSdO2eXw6Qo6L9jhgTL++EfYAmHBqJXtdAz
 49F9xcJxem6TpGDz5jP0CRUnjBKfsTDLMQpb4CpU4ybG16WJs9MxV+uecPq5Jly39I+n
 hb7aamtBEWF3NLn+hKuwrk95Tha6+j1IF1N6ChMQr9fU+i06r48C+uaxo2FA882x1tAE
 rWFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750795165; x=1751399965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nqNOMY1wgov2V5rK0aqKJG2Qi/2pAJHF1rT7FrkqRJE=;
 b=EIVRRgTWNC00alGWDi5j/SkAik+rdsF9PR/3N80eMAVQLLiGu6YE/g3Alp0BOPqQq+
 O2ylAXoJsYe41cGtc2jFd2jPex2CmGwghvVDFuRnxFgTyZxOeB8VBdvj/hvQzoj7Z9yH
 zSj8b/em7CP6WT73B8g/fCgmM5UjFH8G8C204QvAlTvi06FWJIgc/qfnfcXVKfw2ZFQU
 3G4k8WO4rXNi54kP3o5M5vXzgYLesXDcOvYYkPUBjWrbuX654fodNPRKWkjN9rdBydBF
 cz+2Mq1VrQtKulMBDcmkxlCgP1meyafKUwhPufiSliPHvZHwLimMwgmTZhoama4aHvRw
 PDIg==
X-Gm-Message-State: AOJu0YxseH69fAhQT9gR4VwIfOPKdMRUjJCoWnWCPi7PnTAt644cQs25
 MqgXpVF4mJymc3sfCIiTx+j3/g5HPmKIIcfohSakKK1J8O+nai20kBi5dZfRTlqR3G0=
X-Gm-Gg: ASbGncto3CowcIqAB+iLKgJecqciSau08/lDPRDzSyyc+n5whBDRXzqaWCL2InV9JHZ
 1iO0VtiOAn2Nr5yQGLEnZBl1rT1DSK9Qb32L10DSkBelLjfPvhXIs+waMNZJ1Fc3YTfTViuu/Qx
 UE7tIZRhEMxntr4qyHsU7uK777OlkGjiaUepVJQu5IvAEg0/8iVN7T0LSYtYax4KbeSbGv9fnja
 m6xOhkJNLctvwMxxorhs+wyPiJLED/mkRyNG13RD7fWuHv90t31i4hs+XTfHIQw+s5Jz0DVUddZ
 Wh/zhUHVhsflaDZqc1vA2GWzlbj8RhnIR0tmraZhbsNQY3+e60cluw69MVBvZ6+r7aWHrodzs1a
 V7ruBsalp1Yw=
X-Google-Smtp-Source: AGHT+IEGSXSrrJHLlFKX93dCI1bAolLG8QSZZ+UAe9paiY01tRScZaElDpTLiPI0fvg64u2pB0hw1A==
X-Received: by 2002:a05:6512:3c9d:b0:550:d4f3:8491 with SMTP id
 2adb3069b0e04-554fdd3a860mr56306e87.41.1750795165154; 
 Tue, 24 Jun 2025 12:59:25 -0700 (PDT)
Received: from loota.corp.supercell.net ([194.100.101.5])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-553e41cc008sm1936965e87.198.2025.06.24.12.59.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Jun 2025 12:59:24 -0700 (PDT)
From: Edvard Fagerholm <edvard.fagerholm@gmail.com>
To: dev@dpdk.org
Cc: Edvard Fagerholm <edvard.fagerholm@gmail.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
Subject: [PATCH v2] cpp: Fix missing extern "C" closing bracket
Date: Tue, 24 Jun 2025 22:58:10 +0300
Message-Id: <20250624195810.2350988-1-edvard.fagerholm@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250624111253.2074168-1-edvard.fagerholm@gmail.com>
References: <20250624111253.2074168-1-edvard.fagerholm@gmail.com>
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

RTE_FORCE_INTRINSICS with a C++ compiler causes rte_atomic.h and
rte_byteorder.h to emit on x86 an extern "C" without a closing
brace.

Signed-off-by: Edvard Fagerholm <edvard.fagerholm@gmail.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/x86/include/rte_atomic.h    | 6 +++---
 lib/eal/x86/include/rte_byteorder.h | 9 +++++----
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/lib/eal/x86/include/rte_atomic.h b/lib/eal/x86/include/rte_atomic.h
index c72c47c83e..7ba1722683 100644
--- a/lib/eal/x86/include/rte_atomic.h
+++ b/lib/eal/x86/include/rte_atomic.h
@@ -282,18 +282,18 @@ static inline int rte_atomic32_dec_and_test(rte_atomic32_t *v)
 	return ret != 0;
 }
 
+#endif /* RTE_FORCE_INTRINSICS */
+
 #ifdef __cplusplus
 }
 #endif
 
-#endif
-
 #ifdef RTE_ARCH_I686
 #include "rte_atomic_32.h"
 #else
 #include "rte_atomic_64.h"
 #endif
 
-#endif
+#endif /* RTE_TOOLCHAIN_MSVC */
 
 #endif /* _RTE_ATOMIC_X86_H_ */
diff --git a/lib/eal/x86/include/rte_byteorder.h b/lib/eal/x86/include/rte_byteorder.h
index 5a49ffcd50..f54bb07cd0 100644
--- a/lib/eal/x86/include/rte_byteorder.h
+++ b/lib/eal/x86/include/rte_byteorder.h
@@ -48,10 +48,6 @@ static inline uint32_t rte_arch_bswap32(uint32_t _x)
 	return x;
 }
 
-#ifdef __cplusplus
-}
-#endif
-
 #define rte_bswap16(x) ((uint16_t)(__builtin_constant_p(x) ?		\
 				   rte_constant_bswap16(x) :		\
 				   rte_arch_bswap16(x)))
@@ -69,6 +65,11 @@ static inline uint32_t rte_arch_bswap32(uint32_t _x)
 #else
 #include "rte_byteorder_64.h"
 #endif
+
+#endif /* RTE_FORCE_INTRINSICS */
+
+#ifdef __cplusplus
+}
 #endif
 
 #define rte_cpu_to_le_16(x) (x)
-- 
2.34.1

