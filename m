Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1D5C61DBD
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Aug 2026 02:01:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A4B2E4064A;
	Wed, 26 Aug 2026 04:01:50 +0200 (CEST)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id 951B0400D5
 for <dev@dpdk.org>; Wed, 26 Aug 2026 04:01:48 +0200 (CEST)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2d5cad1a6baso4485275ad.3
 for <dev@dpdk.org>; Tue, 25 Aug 2026 19:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787709707;
 x=1788314507; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gSxdddvU5l2ub4z5pO9g4HMbk6ie7D61GQGxVJUESAQ=;
 b=ns2Eb7VvdP1rSGltSIGEJf2GsuwKKPFcq3EVGVb+GuMwkVL2zOIbt4V4Ld9mToc7OV
 lmsMtTU6tNChOFVORgb2EJBDG6E7vyb1aAKr6iUtshHWnDI93R5+CtF6njgyGJSQAvxR
 AYWx/pchcD5cBBNLDdyyOKxdcXuzmQGGZR3NxWDXJAKBsKkbYQNuQAOmrNeFv//lZXRB
 0MJHt/jEwSRWEN7a5/yLo8qbjuO+59cIaVd/isqomJLJS3khZUXgyiWYI7Jdie4iN79n
 YCtMBCF0ABNfL6l/N6XFCdV+sPd+cHJODCcTS951HCm8Q+CWzsqYX278B+V4sTvNp4t+
 y3kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787709707; x=1788314507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gSxdddvU5l2ub4z5pO9g4HMbk6ie7D61GQGxVJUESAQ=;
 b=Og5KDNoupcCJQZI0KrlV3CE92qzs77ca4dAj5V5Jqu8/rkaz2lPpCGbV+lBD+PVYYV
 4MB2anGvJ5qBzdCBGBimKXo69PafDuI0L9/2SjNHkfQvN1S4ZKIxqP/7eeb4+nqfdYcJ
 ah6agCoeREC6WiUTRF2JLzoQsu9IyoWmnKGDebFVxjupRBa+ProC9TUc8vhkU2oXPvE6
 RTFUvjKnaTDnlfUrM92S3vJuKtxH42ALTwh1QjtbpYwNqwqJ7XozO/VzIzlveRuSaNFO
 VmDAcxIMlcXDuoVtjW7RIJGOaEPriyVaoLOlo9SKtGJDc2+hGrnXKpSF9oa0BvJCaMKq
 jO8A==
X-Gm-Message-State: AFuF++mTlpZ/6/JVjeCgiWB17+tstjeX7jhFa5LTWUfUf9oSekzXXQjG
 bq+G7laoQ7j8NW62KxinPQrx4BgrNw4iQZaNagGOxIbXie/jHQpNY1PoA/ekeqhjLyPa8KRnGtQ
 M63j1
X-Gm-Gg: AR+sD13h8fAY98QXIQ1YElLOM9I9VOp5bgB15iEYfEVzpVACMAiVGlP4+09lE4sMXsY
 jDa1c3cR/DzQud7rBvrnISFBVfapmowG1gMhwoKReWgC2pjmPmbIRbJQfBEat+o89kmcysJHs0C
 fnao4ZqC4WiX1A6rhwK+IvpeQPC+MIGhzWvW+zHKSdC4r5fr7+cxzmxZjjHC8NAdXxnbxQ9fhP4
 cLB56JHVFyCHAuEQMeTkhKgciL449H2wiDS6GSpbh2nWDkJlMD4xa8gIcCPYHfjv6xXPpE6W2aH
 YH599T/PnJPFTpAVxKMC8jr0SR5tiCIiIkQgLOXEho2TCUtraS6RLUFfK/6SMORoLpW6BhHDfsk
 eiX2u2Uu5yEhpBAHUYqLsbCRC86hSNZwjayzrndNPUeT2qVe1E54bu0iE/yO8o1OvYrwyU5pCfh
 4eyq9ONtYBUThv8ViqDWYK/kG17+s6Zu0I/QFZZgy7/X0nFsLVl8x2w7PTa0iDQive0hO1VvNGL
 +JAXhv0bQPH3xNajD9k8fm+TXw=
X-Received: by 2002:a17:90b:3cc3:b0:393:194d:5366 with SMTP id
 98e67ed59e1d1-3966d85de70mr7133357a91.10.1787709707139; 
 Tue, 25 Aug 2026 19:01:47 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396686e8aa2sm1935636a91.3.2026.08.25.19.01.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 19:01:46 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 2/5] app/test/reciprocal_division_perf: reduce test time
Date: Tue, 25 Aug 2026 18:56:44 -0700
Message-ID: <20260826020133.2644805-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826020133.2644805-1-stephen@networkplumber.org>
References: <20260529171417.526892-1-stephen@networkplumber.org>
 <20260826020133.2644805-1-stephen@networkplumber.org>
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

