Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39DCACD6E49
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 May 2026 17:14:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6249040662;
	Fri, 29 May 2026 19:14:25 +0200 (CEST)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178]) by mails.dpdk.org (Postfix) with ESMTP id DA62D40647
 for <dev@dpdk.org>; Fri, 29 May 2026 19:14:23 +0200 (CEST)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-304e83724bfso1636676eec.0
 for <dev@dpdk.org>; Fri, 29 May 2026 10:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780074863;
 x=1780679663; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gSxdddvU5l2ub4z5pO9g4HMbk6ie7D61GQGxVJUESAQ=;
 b=XklWb1j4VcLLMKPVvL4EeA25QL3cyhHE3i4eantvz8WzMtl2nkHpFpU4IFUzZ+vjYK
 Xtt4dAU9WXKHU3oHi0RknEx1xhPEjJ+jHf1F6j6oYfZHn3afXC73k7+zL35r2wEjAEek
 y9GbGvfimENfy4GGuDagm5raC5veanrITOq/aWGDbDTdcxsewhzpVi9O86KMVIGEjqSg
 fjS8+c1VrD1ECsqPqDdoNpIl9RaSfmsJoEtW67Tf4Q0vdZck5qoX7+Jpat4J4xvBECdt
 OFPWe1cJEYvS8rPD52REcThs5LV3+kDUYJBc8dofvC23JZtEBbbJJypYVVtKeZ1wcpPt
 /YkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780074863; x=1780679663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gSxdddvU5l2ub4z5pO9g4HMbk6ie7D61GQGxVJUESAQ=;
 b=jFXkqJZesG3Y2GCDviKc7/NtokZZ1TcX+h7GZ2STEQyqCrzD+1VvgbFT37XZyYZ0dJ
 Vi0/fofZLYOF6e4V1D0iEgiLtsaRMoTV8t38TQZoFKX7KObxwgfarvPPN7Xz50Hsobrb
 DKYKFJKyoRXpNFC4g3fRHy4qrTzeBZ0rKmm59/ymWwYbXItfmxh6YP4cYmjurvDvhmZr
 CSYMP7qK/SfrrYwUiDXqiu1E2kYDffNX2jeRI+tXrqnGKoO0RvrgrU3blsqJL7+NH04v
 s9dvoX6faGGb3z+Q95GeMpbtuA3tiNJdJTjfIyWWxEyMX9HcETCI9FX09hsiirWFPx9B
 ac4g==
X-Gm-Message-State: AOJu0Yxc2lAGBzsStDdF1KFrvU5BeUstiE8Njtvp1CfgYWI3EK9qTaMP
 GBjDL+5HQU9HEtiz17UwA3Byrt1AG0SQFgpIMzT6Pc3QAz+oYB/cOzbdhc9+Y7NlWoGt7y4d6OD
 uyCl4
X-Gm-Gg: Acq92OGG3rd7+kaGxxWS+lnotUqRHW1YRDCM14eQq9/UHKJmuxgAs3rqCONccORHAu8
 g7pmQFgZdzntGc/AZiX1Gmu2WN6Lfdn40zL7N0/qMLDWeJIXrJ8+naJqk3uCjec8UPBwyLGXa6p
 pTY5Qb/J58XKmHm/k1yu83qIuO9M8b7p9vLkt5DzsqZ8aEflGfl1jFvEb936eCx7D1mNvKw5q1w
 vsTvm6IjmK7TgVIxr6km1l5XySh7MfpX7Zn6LFSjCD6DEWfq3gSqysj/bCzwpfcY/QUC8eDwyO9
 ulF16OusaGL9Dr4/3zkfm57i4DkNK9L7+8uAdbkxJFSLpZLoy9wwRng8zRyWA/Fhpo9fRPC4pih
 UvI6kjuw3QsvAKBZEd7JCHMhPkKkjHJE4jP9Nn1pZTrKIBn7PimVVRHRZrCjI3ubjUG1Tdn6Q0K
 TbCwZW5vTHnESDfSnG+CvzCtMOHVVC/fuVhueGvnmDeV059PgokokQMCetopsShIA0yzu5JTbnI
 +3V/+jKSbg=
X-Received: by 2002:a05:7300:724f:b0:2f3:986d:2d01 with SMTP id
 5a478bee46e88-304fa5ee9bcmr385644eec.19.1780074862743; 
 Fri, 29 May 2026 10:14:22 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed2c120csm1880350eec.4.2026.05.29.10.14.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 10:14:22 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 2/7] app/test/reciprocal_division_perf: reduce test time
Date: Fri, 29 May 2026 10:10:55 -0700
Message-ID: <20260529171417.526892-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529171417.526892-1-stephen@networkplumber.org>
References: <20260529171417.526892-1-stephen@networkplumber.org>
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

The test time was excessively long it does not need to go
for 2^32 iterations.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_reciprocal_division_perf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/app/test/test_reciprocal_division_perf.c b/app/test/test_reciprocal_division_perf.c
index 6c8afc6e36..046a77f5f2 100644
--- a/app/test/test_reciprocal_division_perf.c
+++ b/app/test/test_reciprocal_division_perf.c
@@ -13,8 +13,8 @@
 #include <rte_random.h>
 #include <rte_reciprocal.h>
 
-#define MAX_ITERATIONS	(1ULL << 32)
-#define DIVIDE_ITER	(1ULL << 28)
+#define MAX_ITERATIONS	(1ULL << 24)
+#define DIVIDE_ITER	(1ULL << 10)
 
 static int
 test_reciprocal_division_perf(void)
-- 
2.53.0

