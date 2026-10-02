Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A63CA5FD4
	for <dpdk-dev@archiver.kernel.org>; Fri,  2 Oct 2026 12:53:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E4F442E7E;
	Fri,  2 Oct 2026 14:53:06 +0200 (CEST)
Received: from forward500d.mail.yandex.net (forward500d.mail.yandex.net
 [31.44.14.16]) by mails.dpdk.org (Postfix) with ESMTP id 195484003C
 for <dev@dpdk.org>; Fri,  2 Oct 2026 14:53:04 +0200 (CEST)
Received: from mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:49a1:0:640:3edd:0])
 by forward500d.mail.yandex.net (postfix) with ESMTPS id C245887649;
 Fri, 02 Oct 2026 15:53:03 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net (smtp)
 with ESMTPSA id fqkvm6Ydb8c0-Gxurc405; 
 Fri, 02 Oct 2026 15:53:03 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1790945583; bh=NP4tW28q1QgaDPZ57txCj6nYSLBjAxu0e0ymnEL/LlM=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=j7aYjYimQ0VhZbC7LKWP0cU52UCBZFXEda/ZsT0QFJEcALKNXWWVmbsl/zs02pZl1
 cATOaYRKn1UfeyiK4RTrJDTktkbh17agGcGwVQgClv5ZeUzlksb++67Rbhqgg6zpKD
 d31frm6+h3OYW/lJYfQvM+ud81vXAh0/Nw3wxpMo=
Authentication-Results: mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex.ru
From: Roman Khromenok <roma55592@yandex.ru>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH 2/3] ethdev: round SFF-8472 calibrated values
Date: Fri,  2 Oct 2026 14:52:36 +0200
Message-ID: <767a4a04efa1c6ec99da1caf809a6ed69dc9ba6e.1790935333.git.roma55592@yandex.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1790935333.git.roma55592@yandex.ru>
References: <cover.1790935333.git.roma55592@yandex.ru>
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

The externally calibrated SFF-8472 values were truncated when stored
in their 16-bit fields. Coefficients that are not exact in binary
floating point lose one unit this way: RX_PWR(1) = 0.7 is stored as
0.69999999, and a raw reading of 1000 gave 699 instead of 700.

Round the calibrated values to the nearest integer instead.

Signed-off-by: Roman Khromenok <roma55592@yandex.ru>
---
 lib/ethdev/sff_8472.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/lib/ethdev/sff_8472.c b/lib/ethdev/sff_8472.c
index 8cd41161e3..88d1f4a0a5 100644
--- a/lib/ethdev/sff_8472.c
+++ b/lib/ethdev/sff_8472.c
@@ -3,6 +3,7 @@
  * Implements SFF-8472 optics diagnostics.
  */
 
+#include <math.h>
 #include <stdio.h>
 #include <string.h>
 
@@ -186,14 +187,17 @@ static float befloattoh(const uint8_t *source)
 	return converter.dst;
 }
 
-/* Calibrated values are stored in 16-bit fields, saturate the out of range ones */
+/*
+ * Calibrated values are stored in 16-bit fields:
+ * round to the nearest integer and saturate the out of range ones.
+ */
 static uint16_t sff_8472_cal_to_u16(double value)
 {
 	if (!(value > 0))
 		return 0;
 	if (value >= UINT16_MAX)
 		return UINT16_MAX;
-	return value;
+	return lround(value);
 }
 
 static int16_t sff_8472_cal_to_s16(double value)
@@ -202,7 +206,7 @@ static int16_t sff_8472_cal_to_s16(double value)
 		return INT16_MIN;
 	if (value >= INT16_MAX)
 		return INT16_MAX;
-	return value;
+	return lround(value);
 }
 
 static void sff_8472_calibration(const uint8_t *data, struct sff_diags *sd)
-- 
2.47.3

