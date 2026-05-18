Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8F7CD4F3C
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 May 2026 16:34:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 32A5F4065B;
	Mon, 18 May 2026 18:34:08 +0200 (CEST)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180]) by mails.dpdk.org (Postfix) with ESMTP id B5199402EF
 for <dev@dpdk.org>; Mon, 18 May 2026 18:34:06 +0200 (CEST)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-2f30a4601bbso2205800eec.1
 for <dev@dpdk.org>; Mon, 18 May 2026 09:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779122046;
 x=1779726846; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LFKL0OOx0JPb1p1LcCpw9j8WW5oixJqsypR1MwUG4pg=;
 b=ccYtaDNTBSX7Hce/Yxt/h3SlH51vTtju4kBtpoz6ZSSoDPRyLrKa86Z+wmvx+jXaFK
 TIpeW/3uRuqgD21fz/6GunDCZuQ8lBf8G5Jy64CqXMDI+tVwprQFxXgVHCv6IKTIdYqa
 Qn7Cty0vE3o3E9W+UomP+DoJepmzKnCpZwF76iOl5YoNUroRUcpZVRKzxoJnTcZCR5cY
 UqAkEwFRXmZdAB+o360Xfw3IPXmz30oCZvGJwnKI5bYtAfM51t17LZkNsTeAYrzHl3ui
 NhVxIqDu4qr4unGY1qwAvheynjyA4/v8PUJeM7XmyRlG2WZECBAWZMN2dpl6jorfd78G
 35sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779122046; x=1779726846;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LFKL0OOx0JPb1p1LcCpw9j8WW5oixJqsypR1MwUG4pg=;
 b=jC2dtHDl1fccGb6OPRepT5RuG1s4K6wUBzoOPbbPQr6OIIOIIFCitDYtY/ZBJP99z+
 qGjG5c0cX4GvHW3obS/DjKOF3WoksiE9gjuoxaFDOSln7ytIB8pwhKco6SIuspnrTB89
 5S2RQyeit8kcOPx9YeeAVfOie693YPiDaPL4aLyrt5SNLqgUgYdiUXUCsZtm8aCN5JRT
 2suAu9dRREZEqpCwEel6fdIlai5MfRfZ8gzywnw/27dLl1oFSkGB0hP7/+TzjC4Vpue4
 NJHekySmy1fzkFxyYtvCNNStYCQRdLpyUgWAuVTcKFEluGAj0hKOnuxCojXCR85eR0/Y
 9aTQ==
X-Gm-Message-State: AOJu0Yx/o1BwpuKTttUYpek0mUMUAqN3fsrYUQXXsTSHIS89ggTQZ3Li
 NKUrY4uSYpcLCBXFu63eNW2/okPo1Ev2lj1WVnDqii8gkgXp+C0kmDuZRobtGpRMGtSr+6NgVwg
 J7KDg
X-Gm-Gg: Acq92OFLP/CyrxnwhrXVWUnMScIUEQ2LosYtAHlff50c9A8KKsQzWgKqa8wmOzEdyUB
 o2zMP0MSmyFxQsmgTL8iwTqDjYi0S+DwR41IZemUxadXx+0MQrQT2JRxAsEL8nwHeXJ7yiowG9n
 iuTNnYyLENoWyvDFgi6aY4aJHskGUGSTC+YmfmA9k7gCn8DcfX6BLAl8tEahQ3lkmGzK/2eyzOu
 I3V+9VWg8QbLvXPnc9+YGeL0Hg1kaXFmq3K79XN4tCJ5U5hyTz2ukLAtmmIzPdL+BqOPCQpM4Ym
 Q3137QO5ibg008mCbabEthnbLuqb1pmGZWXOEDPKpFNlk1A3lzYGH/KJ4SX4i2ZTx2nraNodfd9
 QP6wbsFF5kPkMXDj1iLKO2AihDy7+64rykYnMesSdmq+S2aEPSFPnWJS1Jgj6q8ENDMXxlf7gii
 MqpwKHoFqbDArUec4JWYByyNSfotlB6QvRtBEzUM8JX2k=
X-Received: by 2002:a05:693c:2c84:b0:2ed:e14:7f56 with SMTP id
 5a478bee46e88-303986c63c4mr6700577eec.32.1779122045644; 
 Mon, 18 May 2026 09:34:05 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30296dcb6c3sm17129941eec.19.2026.05.18.09.34.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 09:34:05 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Jack Bond-Preston <jack.bond-preston@foss.arm.com>,
 Gavin Hu <gahu@nvidia.com>,
 Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>,
 Pablo de Lara <pablo.de.lara.guarch@intel.com>
Subject: [PATCH] eal: silence -Wconstant-logical-operand in RTE_IS_POWER_OF_2
Date: Mon, 18 May 2026 09:33:31 -0700
Message-ID: <20260518163401.580696-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

Newer GCC warns when a non-boolean constant is an operand of &&, which
trips whenever RTE_IS_POWER_OF_2 is used in a static_assert with a
power-of-two literal. Make the zero check explicit.

Fixes: 7c872b96983a ("hash: validate hash bucket entries while compiling")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/include/rte_bitops.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/eal/include/rte_bitops.h b/lib/eal/include/rte_bitops.h
index aa6ac73abb..d2719ecd5e 100644
--- a/lib/eal/include/rte_bitops.h
+++ b/lib/eal/include/rte_bitops.h
@@ -1299,7 +1299,7 @@ rte_fls_u64(uint64_t x)
 /**
  * Macro to return 1 if n is a power of 2, 0 otherwise
  */
-#define RTE_IS_POWER_OF_2(n) ((n) && !(((n) - 1) & (n)))
+#define RTE_IS_POWER_OF_2(n) ((n) != 0 && !(((n) - 1) & (n)))
 
 /**
  * Returns true if n is a power of 2
-- 
2.53.0

