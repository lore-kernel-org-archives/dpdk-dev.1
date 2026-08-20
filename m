Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E4FCC5DF85
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 05:28:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8E01A40ED6;
	Thu, 20 Aug 2026 07:26:28 +0200 (CEST)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by mails.dpdk.org (Postfix) with ESMTP id D9E9040ED9
 for <dev@dpdk.org>; Thu, 20 Aug 2026 07:26:27 +0200 (CEST)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-8518b3ff3e9so1429511b3a.2
 for <dev@dpdk.org>; Wed, 19 Aug 2026 22:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787203587;
 x=1787808387; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=J5ugwEKJwCsgPdKtnlofRRbf+C5Ww5IwMnkDYg0hEZo=;
 b=tgZHLB2bDSnbbYXjzhr/zK3pE9UhOBdHebh9R1kA6U+S1yMR5271MFp/RNW4jctAJ8
 2bjXgfo7oUB4toXEh4VMX3gCGsM+o3U3JMLkgLnHmEBKcN+hWTDYb7Ad8QueIbLw4yvk
 4slEVOKlMYnIXeU2qX1uIKpHnLEbPRHQdrazImiM2uSBgBE6JpQ2c3FlZraJEeWZbj2m
 xCcqX3DEjQY/b3K+LrTp49R7vAFSJGrSZWkHnQ1mm9rx5hm2PWES601eR82EtFW8PUZw
 A4RL5wrNbHK4OFty8aC+jJ9DhXk/zG6mDrd5sy6ZTWSUji2x4LaXsst58YoNDvztpl2H
 dIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787203587; x=1787808387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=J5ugwEKJwCsgPdKtnlofRRbf+C5Ww5IwMnkDYg0hEZo=;
 b=koFCMN/3O9eo+EeycyDaOm/xpXptR5lRQMD95QUfQhqPOZlLsnP9mdfgbttSoMM3DO
 +WWCbmNhZO9oeLwhrS7s2fhpahgn7OR6ojgk3A9s/XOnVBBYMWq9UAC9lJHu1yj/PYmz
 RxXfN0EFLPO2vwPXLvSwVKr1eiEK0zMqnZ1r6WJIhOPvdLHOV6vX3aavSE+bEwGKYlHS
 Qx7wxdXolGJj5/whTwbV4hMBDt//EjHkL6LEWMH/SKMs+wPh2BzxnQ8pwEbVNjyshas9
 0YtpY9ABwgPukXeE5SoEvzPTZARri/OrxIT21gKjND1xUgwxMFa1EAxlQOmIqWmpUVjE
 ZQzA==
X-Gm-Message-State: AOJu0YzswMp0Nz/O1O7Mpjvgt3+9/7wyrEGB2bvzh7E72sBQ2fryq2Ws
 mx/qjsKt900eUh7LnmxmleuDajUQ6b5SslIq8sOwS5fdON2ULFWhHixyy1Z3RpDqarduxA5roCo
 QWtB/
X-Gm-Gg: AR+sD12CGm4n3Vge1QI3GHvNjFaFVR1l7AsmvfKWqeLMlKA4gVMk4JJXc8yNp9PQflr
 2Uv+I93but+bvlANr+MWk/RQ6o8H0P3HTJCqSLgo7m59Mx0cyFvp/Qx58XGU6ignQl92M3LxPuf
 3PgSDZsliLHiS0Hb0WJapM9At34GI8wOBE67ImwMv57FCMNrUqKozBdqNwDEo7Yf5aI6zqBPCLr
 ODYcVaeJm4ywWzdyZdnU5Itz/gCSt4QHx7k+K318bHKTHdzljBilsXF5Z2X/b0AuIKTtdYitTQJ
 a7gOUFwK8wI3y1Y7PPGQxjDx1iihGeKr3/fwqPgw0kb8wfNbCa4/oyMhN6MrmmgUBcd2uE2bIJQ
 R1Y9YoC/jKd0iSJ+FfR4DQ+CRgjdvxjp1FGyQRpptcsXkyzaFi1jewJFnOkmvhYuUU5g1MUhrJK
 FGQcrjkoe6DqrDOj3n7Mc2mGaqOMnOXKIOSpuZDjR9gXPohhCVo2xYnSuBefIq2LmJ9+AGeJMXd
 0fZpHjCWqGYZ0vpXos1qFNOOCmanZ7c+icd/Q==
X-Received: by 2002:a05:6a21:700d:b0:3c3:a41f:ce7d with SMTP id
 adf61e73a8af0-3cd00ac067bmr20563204637.0.1787203587028; 
 Wed, 19 Aug 2026 22:26:27 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bef3bb5csm13700974eec.2.2026.08.19.22.26.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 22:26:26 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH 56/61] rib: remove rte_memcpy include
Date: Wed, 19 Aug 2026 22:12:46 -0700
Message-ID: <20260820052251.1453273-57-stephen@networkplumber.org>
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

The rte_memcpy function is no longer used in this library.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/rib/rte_rib6.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/rib/rte_rib6.h b/lib/rib/rte_rib6.h
index e3fb464ae6..2e554579d1 100644
--- a/lib/rib/rte_rib6.h
+++ b/lib/rib/rte_rib6.h
@@ -14,7 +14,6 @@
  * Level compressed tree implementation for IPv6 Longest Prefix Match
  */
 
-#include <rte_memcpy.h>
 #include <rte_ip6.h>
 
 #ifdef __cplusplus
-- 
2.53.0

