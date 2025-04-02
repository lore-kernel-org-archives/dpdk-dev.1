Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF969C36014
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Apr 2025 09:35:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D66D140273;
	Wed,  2 Apr 2025 11:35:32 +0200 (CEST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com
 [209.85.167.51]) by mails.dpdk.org (Postfix) with ESMTP id D7B0340273
 for <dev@dpdk.org>; Wed,  2 Apr 2025 11:35:31 +0200 (CEST)
Received: by mail-lf1-f51.google.com with SMTP id
 2adb3069b0e04-54afb5fcebaso875356e87.3
 for <dev@dpdk.org>; Wed, 02 Apr 2025 02:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=interfacemasters.com; s=google; t=1743586531; x=1744191331; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tNlf2qgNUQSDezqY2JYgZ43QeCY62uoDIUXliVo6yok=;
 b=XriOWtsF0jDHlqGcrV5SAE9CX0GKQNmBRupQnsX81gSlsU6VbuD4EE6i+/LM7xDbWQ
 jtk6tmdwFUYA1BGl2fkuTYETIfm4ovJOQ5zOH4EwN4dwN7JOo3M6pJlhhSGFpfSqmGnK
 vZNgG8D8U8lrCe+8mT9fIIlZ1csrlu7h0/Ep8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743586531; x=1744191331;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tNlf2qgNUQSDezqY2JYgZ43QeCY62uoDIUXliVo6yok=;
 b=dp8pzLYu0M+N5duURlMigriusbHx8wfH+y75sASS+nxhgNHgaWwHEq8hT/MwuVA5Kt
 NThv+ouMZiVEjiLTv2DSXDBFRXElUwJTJiMq3WlUx0RFwrjDOmggkyhVJEhGVggElvX3
 y22AQw8A/qsUMumC0jz9oqZe58APIZ6tX6M3gqhDrhoFopjR2UsLs/xk77EjR00aLsR7
 E7s/d/B+ySrDXPYSfvLPdx9pb8GC8ul7SSKDGMaICF84M+WEdkKFIIxSO8ym5qbRSBhr
 7XD8f6Lb+llccGiGRPCl9d5mEf3KbX5WWyk0FxrldCS1yX7J3YqSJaj7sxeXCh9bitHb
 9JBg==
X-Gm-Message-State: AOJu0YwIQu/yxcEM0h+outlxWEyI++xVRuHl/J5oNi8Y05H5v8g9ouik
 aw1ukjjJh18FNFtXl0KqB/3oPw+ZtWLNPQ+Gxv0t6rBmjmgTtJy0hzvH/ONX1Ek=
X-Gm-Gg: ASbGncv3PU59W0m5VWArU4ofW3DOSdJCdnvG6+p6gG76WPrPiTfiBhgavLnT+9LyiLT
 /9Btht3Zu05S8JPQhiLQAwl9EpWY98ib4NEL2W9vaFTDahKQoGPZMs2WCRgk0su30GAGigM10CZ
 lHINkkGQm1AfsiMpWYyuN4rFafWPW5J/rsc7RPbda0lV9b2eq3JW6JLcGqNW4bYJJ06l19B3bgH
 v7GVJClUuoIWrYSnf1HOJq613lLDTIizcaZgY/v+we1DQgpgUQ3rzJk9QcJ2E8VtHryNwZfYtZH
 +YxfZS/gJiCb935o/6h5viVARGrz2yK0bgDfQyXLFYGsUhhVVI/fmmZPww==
X-Google-Smtp-Source: AGHT+IEkVAOVS8a8pvMiArWMm4OR7Bk8FEWODsCSmKTKtw6qB30DWpX5e56P2cHiD69ZBV8vTPIyhQ==
X-Received: by 2002:a05:6512:3f1e:b0:549:912a:d051 with SMTP id
 2adb3069b0e04-54c19c1adfamr535495e87.0.1743586531098; 
 Wed, 02 Apr 2025 02:35:31 -0700 (PDT)
Received: from fedora.. ([185.143.144.104]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-54b0959324bsm1578465e87.163.2025.04.02.02.35.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Apr 2025 02:35:30 -0700 (PDT)
From: Oleksandr Nahnybida <oleksandrn@interfacemasters.com>
To: Jerin Jacob <jerinj@marvell.com>, Sunil Kumar Kori <skori@marvell.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, stable@dpdk.org,
 Oleksandr Nahnybida <oleksandrn@interfacemasters.com>
Subject: [PATCH] trace: fix out of bounds write in __rte_trace_mem_get
Date: Wed,  2 Apr 2025 12:33:09 +0300
Message-ID: <20250402093309.10394-1-oleksandrn@interfacemasters.com>
X-Mailer: git-send-email 2.49.0
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

Offset should be aligned first before checking if there is free space for
another write.

Bugzilla ID: 1665
Fixes: ebaee6409702 ("trace: simplify trace point headers")

Signed-off-by: Oleksandr Nahnybida <oleksandrn@interfacemasters.com>
---
 lib/eal/include/rte_trace_point.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/lib/eal/include/rte_trace_point.h b/lib/eal/include/rte_trace_point.h
index 8a317d31d2..343e0271b3 100644
--- a/lib/eal/include/rte_trace_point.h
+++ b/lib/eal/include/rte_trace_point.h
@@ -328,7 +328,7 @@ __rte_trace_mem_get(uint64_t in)
 			return NULL;
 	}
 	/* Check the wrap around case */
-	uint32_t offset = trace->offset;
+	uint32_t offset = RTE_ALIGN_CEIL(trace->offset, __RTE_TRACE_EVENT_HEADER_SZ);
 	if (unlikely((offset + sz) >= trace->len)) {
 		/* Disable the trace event if it in DISCARD mode */
 		if (unlikely(in & __RTE_TRACE_FIELD_ENABLE_DISCARD))
@@ -336,8 +336,6 @@ __rte_trace_mem_get(uint64_t in)
 
 		offset = 0;
 	}
-	/* Align to event header size */
-	offset = RTE_ALIGN_CEIL(offset, __RTE_TRACE_EVENT_HEADER_SZ);
 	void *mem = RTE_PTR_ADD(&trace->mem[0], offset);
 	offset += sz;
 	trace->offset = offset;
-- 
2.49.0

