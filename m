Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F5CDC77B7F
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Jun 2025 11:16:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0378440275;
	Tue, 24 Jun 2025 13:16:32 +0200 (CEST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com
 [209.85.167.50]) by mails.dpdk.org (Postfix) with ESMTP id 8189140264
 for <dev@dpdk.org>; Tue, 24 Jun 2025 13:16:30 +0200 (CEST)
Received: by mail-lf1-f50.google.com with SMTP id
 2adb3069b0e04-54b10594812so5238004e87.1
 for <dev@dpdk.org>; Tue, 24 Jun 2025 04:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750763789; x=1751368589; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1XQYIdS3AN8qeBR8oF3ZRAuOD6tDoqaybmiNKSOULvk=;
 b=Fj5RNoAR9mF5Td7I+QzEqvMW8/f/yD4/ekCweyimm0Adjk1F2rzSUzpsNF9S8BkEw/
 lGoL/uSmLF0zpYanuq1/vtNLlgRxcjmXmU37DhzNZij1ZJvIlU44uZ3IMOtfFlO90qP8
 qcMtLmL0xHAi5/Q6l4cX2MD/jd7TnQVUC0R0vswK63AJegMsZA/aFq0fTW3TF2JdUfvm
 4E9RBCqwc76tY0qArSYtKt/vyPqT/dgrIBx3PEbCRUUoJWytHbllDlQXT2PqI9kUKBn1
 gecP+phWQCg+/u861fGfOc3mOKSjxLe3GobzvHQiJ7J2gMKfbHnHZ9VAQds4MhDK0lNo
 iaMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750763789; x=1751368589;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1XQYIdS3AN8qeBR8oF3ZRAuOD6tDoqaybmiNKSOULvk=;
 b=F/wkjhU44f65YXpDaIQyCYN+ltvTqxEpwrCOhCKM3wlrMhf8YvgVjESsbdtKUUjViA
 YEPfp+I8TNOpLfRcaT12XLJ+9eVUveAJ1cv7qhkeMmhnJaP/9D5iYEl76QTqMmGmj1A+
 D8t+s612qfYEs9EIbpSS/tYZ0jQxeOKcsoLDWnhBIvtOM1X/UfTYZVnb4i2tueRyUBWD
 wSnNuewNntZXrUz5UK1ZhvMR3CXNLSOVXw3K/EgnRCdJ8cVwlUHhOF2koU/5fGW5G0J6
 hX/J6luhSRqqkzWOEsSHJuoqx6GOYNpE4xsSZfLQFK9xd+7JhImRdy9onstSlsrgMTYP
 xn2Q==
X-Gm-Message-State: AOJu0YztEb2aI5ogFcEBxSy1U91fKMAiWY5YiHY5TwXyNaCHFyzrFP6l
 D9VBt9EKAeFGwHdGbNKA56iTuaCwAP51NZkmWjvGvJ6j32sS/VCwTxwjyuwY0XmrY0U=
X-Gm-Gg: ASbGncuZNBu+fDVsFXYyhb9/R8rjQYuIY+6YMYR+aZL1AFfFYJgERI6UX7bm7r+uODL
 FTvCzTgOX2aW4Vc9uQEa/dm7AYibxk0fAOF5O4zrEW2jPbqjnrRo9Ev8i+O7oKVpQuKnKytjbfm
 ytAFCPKMdTZFmWxeGAqGn6++m45maigoeejk0BrnOAjhmOZEG64OQl7nniz66A8PEXfc6NEKIiB
 RL4y3LRGOzYYfmv+07OgOQw7e3U2GcsQClcCbgV71U4mBRu1b5F4ibaEJKcxYRxszbFatedmEfW
 +nXU7k1DWkMalCFdEC+OJvFEszaoP+5wGOwTsFU9GjAdSdPcOWDV52cE6Z1PQGUwFaGQ2ZXKfD5
 7JXUYZA1xFck=
X-Google-Smtp-Source: AGHT+IHnrlasuPpvD3GFFjTBPVnbtdIkwyjs9IH4ekCS5AJ1Ego2/z5aOHOUdMWCEgvxwCYMa4m+2w==
X-Received: by 2002:a05:6512:3f23:b0:553:3892:5ead with SMTP id
 2adb3069b0e04-553e3ba8024mr4429027e87.2.1750763789366; 
 Tue, 24 Jun 2025 04:16:29 -0700 (PDT)
Received: from loota.corp.supercell.net ([194.100.101.5])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-553e41d7026sm1809320e87.247.2025.06.24.04.16.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Jun 2025 04:16:28 -0700 (PDT)
From: Edvard Fagerholm <edvard.fagerholm@gmail.com>
To: dev@dpdk.org
Cc: Edvard Fagerholm <edvard.fagerholm@gmail.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
Subject: [PATCH] cpp: Fix missing extern "C" closing bracket
Date: Tue, 24 Jun 2025 14:12:53 +0300
Message-Id: <20250624111253.2074168-1-edvard.fagerholm@gmail.com>
X-Mailer: git-send-email 2.34.1
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
---
 lib/eal/x86/include/rte_atomic.h    | 4 ++--
 lib/eal/x86/include/rte_byteorder.h | 9 +++++----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/lib/eal/x86/include/rte_atomic.h b/lib/eal/x86/include/rte_atomic.h
index c72c47c83e..68629016b4 100644
--- a/lib/eal/x86/include/rte_atomic.h
+++ b/lib/eal/x86/include/rte_atomic.h
@@ -282,10 +282,10 @@ static inline int rte_atomic32_dec_and_test(rte_atomic32_t *v)
 	return ret != 0;
 }
 
-#ifdef __cplusplus
-}
 #endif
 
+#ifdef __cplusplus
+}
 #endif
 
 #ifdef RTE_ARCH_I686
diff --git a/lib/eal/x86/include/rte_byteorder.h b/lib/eal/x86/include/rte_byteorder.h
index 5a49ffcd50..62a87c1aa6 100644
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
+#endif
+
+#ifdef __cplusplus
+}
 #endif
 
 #define rte_cpu_to_le_16(x) (x)
-- 
2.34.1

