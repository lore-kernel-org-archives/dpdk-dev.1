Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6213CA0EED
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 Aug 2025 18:21:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2377440E1D;
	Fri, 22 Aug 2025 20:21:22 +0200 (CEST)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53]) by mails.dpdk.org (Postfix) with ESMTP id F0F1940E0B
 for <dev@dpdk.org>; Fri, 22 Aug 2025 20:21:20 +0200 (CEST)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-3b9dc5c6521so1265371f8f.1
 for <dev@dpdk.org>; Fri, 22 Aug 2025 11:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755886880;
 x=1756491680; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sXDVVpgHKvazqMixfzcVCRi6zGkFf2WtTbms3AvFmhs=;
 b=hn8QNM+aSD56LdYzfagKuyNZ9/g1PT8a/6jz2hAYwltANN/AbR1CDYxZllUxIx/Dau
 1gAqViEiqHSGBJP6GV0Eyhra5HNQP4+GyrpzD5+GV23RRCawBUKrmAhkoNAVUXeBUNQn
 Ml9D71q2mWw5XulTRghKkm4ybX+yR7mxJ5wVo7TkXVGbfOW+2Qp3mgTq9VptVB5ppZdY
 jRzMe7VllSUzc5xSEdFqGrvXHl7wX3S2i27ee9he1ebK7P7nn13c9klmJ79EuiyN+pqM
 FS/cST5ntwCmOH9NehyurGn6fQ8ZPy4zgrBSM6lRTpirWU+bhIGbx5lnaKq+kI4sXy68
 vBkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755886880; x=1756491680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sXDVVpgHKvazqMixfzcVCRi6zGkFf2WtTbms3AvFmhs=;
 b=em6YpVHIcqWCXeC19tJufyeLHQjFYXCefGtnZhvh+MtSAIhmIJ8s97NUNW2DYy2Tkn
 f0Qsx577Ug3AsWcF2pjDmmNy8ylEhb3CSiNA+FViEVvEb8tuEcJhGJ7AWHA4aq96LXR7
 xRHU6Ee9qz7pYyCKVShvZs890TaYQrDOZm4p+ASflVCgrPCBO3HAPeDmAeuakgQNP3iM
 ADNpilERqk7cH43kEdTfBF+cwrF+wBzw62o5UJHs+mp6EWGe8Z6tEaKCYOuiO3j6yP4P
 emRm7WfSyKxMG64oK4xSNWAe4OsR1wRvbmWdzSaXRDwJqUGN6yTDefraWel5JlyxNhP5
 PrDA==
X-Gm-Message-State: AOJu0YzDBZU2bYkItyGRHH716mp2r5OpUj+YYBIgGeao1519DZ3en+zq
 b1O+VdEQ3QHVTPHbmXcbYKqeJPkVg1g9BnChmhoOO1NkHsObvD1rjDL2aLQAkSYEfA2jRlwZa51
 k2NTC
X-Gm-Gg: ASbGncv9eJpsz7Q77SPlTg5AtPNO22kdqI0tRxitugCKHfDW5oO/VfkF7wTJZtPfqcO
 KB2Juy2xqbkbIKx5WJfoCPi6hW0iYhNrNnYnKu86y0iZ+FSnzXl2Wgef+bKXxCapWgSPb4xSRF2
 6dbre3dngVT2GV51lOHfeAHiUBFTcG7pem9dsHCCW31nHdYyj8U8yvcFKkwosV7D28wPmKrsCqz
 YCFwpie7eHaig6aQ9zp0HGACyZ2RDJdpPxr75rHHYPqNun/PbZocxZJqfmaCewn+k29FKRb59eo
 FpHT1hV2B+IGqVYIXDmvK5NHG1yi+hWPx2CBH+V41Ikxw7ATwSofIDxyP2g6h8IxN9SyWmwc/fW
 yNCxVns/kCLzHoNthdAOipxq1ku2MPXA8bKbL/XmHo8FU7tu1rd3GcH8gHRVnfb/uouefZBd5
X-Google-Smtp-Source: AGHT+IFeOJpG4pzSdf9cM/pm0h57e5VHEDzWvs3avQ6/PBWE+DSdkzeUE4RN5bqCsLRizp/JSFa8/g==
X-Received: by 2002:a05:6000:400e:b0:3b9:48f:1960 with SMTP id
 ffacd0b85a97d-3c5dcdfc37amr3094923f8f.49.1755886880504; 
 Fri, 22 Aug 2025 11:21:20 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c711ca61d8sm376441f8f.61.2025.08.22.11.21.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Aug 2025 11:21:19 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v2 2/4] hash: use static_assert
Date: Fri, 22 Aug 2025 11:19:32 -0700
Message-ID: <20250822182110.27599-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250822182110.27599-1-stephen@networkplumber.org>
References: <20250821203646.133506-1-stephen@networkplumber.org>
 <20250822182110.27599-1-stephen@networkplumber.org>
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

Now that static_assert is available, better than pre-processor
use of #if condition.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/hash/rte_cuckoo_hash.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/hash/rte_cuckoo_hash.h b/lib/hash/rte_cuckoo_hash.h
index 16fe999c4c..90fda7d7e0 100644
--- a/lib/hash/rte_cuckoo_hash.h
+++ b/lib/hash/rte_cuckoo_hash.h
@@ -24,9 +24,8 @@
  */
 #define RTE_HASH_BUCKET_ENTRIES		8
 
-#if !RTE_IS_POWER_OF_2(RTE_HASH_BUCKET_ENTRIES)
-#error RTE_HASH_BUCKET_ENTRIES must be a power of 2
-#endif
+static_assert(RTE_IS_POWER_OF_2(RTE_HASH_BUCKET_ENTRIES),
+	      "RTE_HASH_BUCKET_ENTRIES must be a power of 2");
 
 #define NULL_SIGNATURE			0
 
-- 
2.47.2

