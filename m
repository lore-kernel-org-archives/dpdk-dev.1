Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B0A606A338
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Nov 2026 13:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=XmJiWOOG;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=QOssRWgc
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BD22F40682;
	Thu, 12 Nov 2026 14:05:27 +0100 (CET)
Received: from fout-a4-smtp.messagingengine.com
 (fout-a4-smtp.messagingengine.com [103.168.172.147])
 by mails.dpdk.org (Postfix) with ESMTPS id B440B402A2
 for <dev@dpdk.org>; Thu, 12 Nov 2026 14:05:25 +0100 (CET)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id 0087DEC00BB
 for <dev@dpdk.org>; Thu, 12 Nov 2026 08:05:25 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Thu, 12 Nov 2026 08:05:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm3; t=1794488724; x=1794575124; bh=9y6ziM/QK7Ov7ZMWQvdue
 ZlBsgLWHVa40frcuy6+jEY=; b=XmJiWOOGoj3u94nSLSJ/F2QzUaESDN2OXofNa
 R3sNIDv33rqS3Zt1xUOOhuAMnJdjDG8D5Zec6B8+JHSXFOG734dfy3/QhXBVhBHt
 yr9Zy/8FOCzLlBbNYjwYexU4fW6gzmIwlCD3aSwZAxwB7hsSrC1eMaX6SrBPnGI/
 7Y4FGIJMKh7bDyyUCx1vJmV1lYEy+VPz+6CXJldmKUZtJuJyO+p9nWnKyklg8+CY
 TyMtf7WTIaoXYg/kG3bPYoorlQ79gnDLCTup5DVDkqZb3kqDVD7Vlnxvsd2rH1M+
 cBetaHgc/Ibi0CQM58sAVKXP8r53ljTZHa/osZJrtreDNrUnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1794488724; x=1794575124; bh=9y6ziM/QK7Ov7ZMWQvdueZlBsgLWHVa40fr
 cuy6+jEY=; b=QOssRWgcKI99DDGJviOZFnDtjyLtupbG2OZg8Edt672NSaHIjHe
 DL3owL1LzfiSlKMRva2stPyFWm8c47w19KYgDxeQMhbG6r4epqteh08PkT3jkVVG
 0Nfxa29ZFKMJR2GJPPaU5QAGpNTNxqtGvYiInKinGfZnwOOTo+Nh+WRamz5Zuxtm
 q4w3NaZJmf3TNkmqCBQB+pZ++QJZu+KIQcgg7I24qiDEo2VBvs+8dP6WQkZrT5qA
 02/7vOeM3avf13AzQ8bstCX61CxOJPruBrzIeYvGo+hJejQG4vKEW0JoChaGrLcT
 /IGAnSbvfS+GuzZjV8p5HUUdJdjW+wOaVqw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794488724; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm3:rsa-sha256:2x+Cy38PlkRkfHee6lptHCWkk+zqQOHiaOtC0009m7zBMdS
 4fcr/wCBMxvP3ww68CgKRc1V9MyaQ4XbNO5VAgbZMlfNEuXvyFAT9lq52uJtp/Rp
 1euke+k5oNVlNYkVURpE+LICppdgFqzNPihbEjd88neJ2qb3wpeviq03qK+4TSX7
 Q59Ib9KzFcoG3rVTbJAJWcTMpVzDXoKDy1bDjs5PxIw8Xo1cN5fXtQ+yTBvGxq82
 dWZhzoL1/MBf3xx1BEicYRfIx3j7/vppaID7kSddy1gn5d6kYHrOzDO0KHnkwCdF
 hs88k9RxJ/Nl4B55Ys1NBTI5wDSgaACf7hIcTkg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=9;
 hn=cc,content-transfer-encoding,date,feedback-id,from,
 message-id,mime-version,subject,to;
Message-Instance: m=1;
 h=sha256:HZLfpoZlZvJu6kQHArCWMfDAK83/GxJJe2WWkEQ7xw4=:S596spRAVG9oc2AD3Tr+ZDyYnFyJJjMfotABlVl0YpA=;
X-ME-Sender: <xms:lLn1am5ZHrDsbjtfBGe-aYNAIe12hO5D-Ypk66SQQOt-aScRfVCLbA>
 <xme:lLn1akPTRLQ5llL5hB5W3-G0UccS6HK5yxASKzkxaQz79ILUBSlfzNnQR5Qu5ZFu_
 fQSj4O3VBf2yc67bzzl6VCDQcLqdOBA99zCm4rz_xf12la70rXsKg>
X-ME-Received: <xmr:lLn1aknYdE4mIxrpMvfTbA8qHE_QcOIavfoiSp4tgVG8Bp1bLd6iXD5xvpa3xdP2hsPbm626neLlnJq1AfQSm0Glq0Py>
X-ME-Proxy-Cause: dmFkZTGyJM4T20uNPXfI521ZoXD3pFxg6aOznRU/SVup1KCHL8EZPD1ZvB4t9QeTZmESDE
 OGt13gXdsGJLitG4vk+iDSiH3VavOO8BMDLPLMrsqUzKL8FJIVB+lCUVKyCILE5GhZ7ZdZ
 1v+cgBzkpzWFLbnqji1rfxqt28uUCLMep3+lzPAqNOfwE+xHXr7h5uauNc4JDJbro17w1v
 9w8U0WFDvMhUF9Zv0S3SkwQ3Pi6pPIZ/Ru8z4U1593B/dc8Z8QHOrYz6ApYdg3jrrWKg8O
 uj+b9Ef677KHP3OENkk8dSXNk8RvmsVnXCy7x+wElzRVk6FSmZY7MZ6jaEaVCrSosdx1Tx
 wtnSHdzVxbwaK87cJkGSbbkWuoLM1FT5bqlKUQ86wLaFyW+cJyw1tdZe6N2n96wo1P9eRk
 /iIuylSirjM6lhfwPmpTjYJEh9YHK7vMxLmUPC3NCqc7W+g/5f4EPPaBzR+sXM2Oldb1zK
 eCm3/NVZsen9Eqo1Vdz31YXRojdRCOsLp7NU/PPv9nXehRLntLynonBrHD2cZpZeO8+dID
 PzijfdK+DcjLKjWCD8tNhr8VEvNlJ0sgfwESoLQiPSKitghQIIkciAmaQF7k1rgbM6FZ0Z
 5NMzmblARcw3i0s47vARfMbnROfRDdhf7ruyGldfWLYgKHutMO39NxyWax4w
X-ME-Proxy: <xmx:lLn1arSkL8VivcBaZIv1IPrPZRTpNteeCV50Tl4LWXbUQCaTXJIVzA>
 <xmx:lLn1agDhsOUuGUVyVhV0tVHpD4YfSp84_3Ol8XfM3XGgtZcazc2aCA>
 <xmx:lLn1aqRQQAvyeifQX1Xub7y4JVFeOiubIpJARzNcaBW2zrDLynNCsA>
 <xmx:lLn1amopZ4yz7WPWsS5vxahYsnRvnZoxvlrpRoF55DvbQYy7MVqj3A>
 <xmx:lLn1ai4HDHwPDXkHpDzgo42_OwEjR6yNpIbil5XDC9IB8_Mj0hiZcVy2>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Nov 2026 08:05:24 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Kai Ji <kai.ji@intel.com>,
	Radu Nicolau <radu.nicolau@intel.com>
Subject: [PATCH] crypto/ipsec_mb: remove unused ML-DSA helper
Date: Thu, 12 Nov 2026 14:05:02 +0100
Message-ID: <20261112130510.945641-1-thomas@monjalon.net>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

With IPsec MB 3.0 or newer,
Clang reports aesni_mb_ml_dsa_sig_sz() as unused.

Remove the helper, which has no callers.

Fixes: 4ff2a4d23d84 ("crypto/ipsec_mb: support ML-KEM and ML-DSA")

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 drivers/crypto/ipsec_mb/pmd_aesni_mb.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c b/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
index ac0a48572d..ab917b3fe4 100644
--- a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
+++ b/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
@@ -2606,18 +2606,6 @@ static inline size_t aesni_mb_ml_dsa_sk_sz(const IMB_ML_DSA_ALG alg)
 		}
 		return 0;
 }
-static inline size_t aesni_mb_ml_dsa_sig_sz(const IMB_ML_DSA_ALG alg)
-{
-		switch (alg) {
-		case IMB_ML_DSA_44:
-				return IMB_ML_DSA_44_SIG_BYTES;
-		case IMB_ML_DSA_65:
-				return IMB_ML_DSA_65_SIG_BYTES;
-		case IMB_ML_DSA_87:
-				return IMB_ML_DSA_87_SIG_BYTES;
-		}
-		return 0;
-}
 
 static void
 aesni_mb_asym_process(struct rte_crypto_op *op)
-- 
2.55.0

