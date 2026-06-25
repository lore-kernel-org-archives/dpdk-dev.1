Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B64CDE001
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 16:02:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DADCC40E12;
	Thu, 25 Jun 2026 18:02:11 +0200 (CEST)
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
 by mails.dpdk.org (Postfix) with ESMTP id 2723740616
 for <dev@dpdk.org>; Thu, 25 Jun 2026 18:02:09 +0200 (CEST)
Received: by mail-dl1-f46.google.com with SMTP id
 a92af1059eb24-139a5f4ca15so29842c88.1
 for <dev@dpdk.org>; Thu, 25 Jun 2026 09:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782403328;
 x=1783008128; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iOGZp6WWxuD5iHG2bBL7gEiRe/bnEIx3rsoGWpMk4p8=;
 b=q5DJM9UBT3ZY0oExG/FoleicLA3KebvSt3A3AgMZh6H2Ev63eDpPxDLpZZaXLOo877
 rYGTTHiWIMbqbhYl7R90MhKQrCKmlNvRTyvaPiKnKaFHTDsP5Uk09f2Ar87W5axjQOXy
 6JKnotW1nUikrSK8sqr0BQHmGg6LECWOgDm21JfR8VdCfvvzOn3jtsCyxyPe5jbXX4cY
 OIBs1+J16FuhrRhKb5G3uZC3s/a8LRAYsad3lMaRy6ep/5zfD/PEnf/O44yugPlmNp6w
 j+jEdMAOT8LPxZB3T8JK4KGm+oXTmYxewPwXy8gRl1pOZdxZWcs0n75fo/GOeWpcuWqW
 xBEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782403328; x=1783008128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iOGZp6WWxuD5iHG2bBL7gEiRe/bnEIx3rsoGWpMk4p8=;
 b=Q1o9yISHzlY3OFcrKA3jcO5RYrIIH02thIkYiF+7NrWbWGqBIOwPytBzyBDX/HdKfB
 bPdVvTR2DyJ8fRpvOBsE1Apm0+nUyLUImXbByO0keLkvezBgzZj5rqpacJztV2iPiGm0
 /KCU6kjcnsA/WpFidu5qZpSi1tZ+g246m2v93vvl83jrQXhJ0xWycG42145CCR/4emSC
 PdBW9ZB4PKQYPR9/hcuppPZLvFfBWYoMZhargDUq+PiwBwy16xLcokMs/6mgfrIgoiqM
 T9FPZu2EE41HDR/Smq0gWIAo3fBJhWGygrquujEfK0XhMdgfA1eDCEjDi93eo0rIphEB
 LfAA==
X-Gm-Message-State: AOJu0Yy1Up67cKHeCN6QsTOuVhpdygUDUrZSeS+/U2qPy3w2FcgEoE7I
 kktg+ysHFZgIvGlDfM+ScBHTheCVjAI0WZoKE3bOM3HJbN+Awp/bBtFH5UTB8WFRGxwKXO6BiZB
 DxFdX
X-Gm-Gg: AfdE7cnJcb81ZKz6RYRJx+yFsDAD8150Y0+YSa9tOz5tK1j4ZQknvw5/ZsQSH9lJOu2
 rDSt2AdD/H05moju4/A8ZRB4l3YH21jlgjHnj7bpAI1wHRnS134O9Ck6ZWqlB6Oh1ZFNMMgPSrA
 sJ3sQ6XSqNO6cxlfHiyYoFx02uYFDge3UbDUSt0VRPShJNnH23KRcZ1nNgcSnR0GBkP0xfVydkx
 OBadT3XE6UKiNCj7PpuNKrh3BlyOVPUnsdjV7tUvl4hQ07vqOuX9cCGJ3ZFNTq4pBK9asVb7b4E
 Xq9KETUMTgPwvdGLctz8OKAFuRBI92ZMP4oTueUTaTT7hOguM5UYC4ya/v/zO4mN0uQFJZlQGFq
 jnmFhQ2Jk3KmlAH+0i4KsB+3p86Kf1NLDX9Fojmm/eL0X/oQoTp4M0U9gQ4g9iyECz+rB9PlZdO
 6Iyn33mopqsU+GiZTWcGqnb0DDWBxHqZhrj6YIRqoflc5Qn5gSN6Q=
X-Received: by 2002:a05:7022:20f:b0:137:edc4:a5e6 with SMTP id
 a92af1059eb24-139dbaf01c9mr2752602c88.29.1782403328044; 
 Thu, 25 Jun 2026 09:02:08 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d90e940asm9121569c88.9.2026.06.25.09.02.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 09:02:07 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Siraj Luthfi Ananda <sirajluthfi@gmail.com>
Subject: [PATCH 4/5] crypto/armv8: use timing-safe digest comparison
Date: Thu, 25 Jun 2026 08:56:37 -0700
Message-ID: <20260625160200.24170-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260625160200.24170-1-stephen@networkplumber.org>
References: <20260625160200.24170-1-stephen@networkplumber.org>
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

The chained-op verify path compared the computed and expected MAC
with memcmp(), whose run time depends on the number of matching
leading bytes and can leak the digest to an attacker submitting
forged values.

Use rte_memeq_timingsafe() for the verify comparison.

Bugzilla ID: 1773
Fixes: 169ca3db550c ("crypto/armv8: add PMD optimized for ARMv8 processors")
Cc: stable@dpdk.org

Reported-by: Siraj Luthfi Ananda <sirajluthfi@gmail.com>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/crypto/armv8/rte_armv8_pmd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/armv8/rte_armv8_pmd.c b/drivers/crypto/armv8/rte_armv8_pmd.c
index 320e2d4b3b..a7caac186d 100644
--- a/drivers/crypto/armv8/rte_armv8_pmd.c
+++ b/drivers/crypto/armv8/rte_armv8_pmd.c
@@ -631,8 +631,8 @@ process_armv8_chained_op(struct armv8_crypto_qp *qp, struct rte_crypto_op *op,
 
 	op->status = RTE_CRYPTO_OP_STATUS_SUCCESS;
 	if (sess->auth.operation == RTE_CRYPTO_AUTH_OP_VERIFY) {
-		if (memcmp(adst, op->sym->auth.digest.data,
-				sess->auth.digest_length) != 0) {
+		if (!rte_memeq_timingsafe(adst, op->sym->auth.digest.data,
+					  sess->auth.digest_length)) {
 			op->status = RTE_CRYPTO_OP_STATUS_AUTH_FAILED;
 		}
 	}
-- 
2.53.0

