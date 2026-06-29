Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 658C7C43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Jun 2026 19:01:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 66D154065B;
	Mon, 29 Jun 2026 21:00:43 +0200 (CEST)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com
 [209.85.128.171])
 by mails.dpdk.org (Postfix) with ESMTP id AEC01402DD
 for <dev@dpdk.org>; Mon, 29 Jun 2026 21:00:37 +0200 (CEST)
Received: by mail-yw1-f171.google.com with SMTP id
 00721157ae682-80bb41f7f3cso35800857b3.2
 for <dev@dpdk.org>; Mon, 29 Jun 2026 12:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782759637;
 x=1783364437; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8whq3tWfRyuJCTTzNADPHzH9AURJAa8R2qISyrqPPKo=;
 b=JXwL+w7B2ztBYqgtlMoTZ3wvxGdmkfW7XTnWIDEl4RWKqtHXi7ado7wabO1ARwzkoo
 gxnwvpDnNRR7ZRi4aNCKz2/8T5tWtoDG14UPbAfYvCROhYy3hf0hhOui074eUlZbmqQL
 /RFQnpcOBBmc/bO657TQTKp4GOQd3YjrOKTgs6TANg5WV20m4rQ9Zajyzv+Tr5EUzYtD
 wXNNbtVuJhbRbq3YR1qQpdfDXYnYfZyBJEQ5TKw29cv0VfiAQ6BIJa9sVly1xed2aSHZ
 rnr5xeSloQoqMUdwyJJLU/qov4A0beZuuXzb+INR9RrOm4nZkHJ1V4G7jkc6cqFKZBeu
 W6Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782759637; x=1783364437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8whq3tWfRyuJCTTzNADPHzH9AURJAa8R2qISyrqPPKo=;
 b=sMoFgHo7M1y3YknqcHLSzq7PSHBaUuk77RCLRyIeCRXF9yoWpIftCT2uOvAe1oAnOa
 dximcJo1W/GxoTYY6qKUvinhUZNGVuvBUBRtP2UgHq3V9c0JgeWtrbCGBI1d+NgV57B8
 36lhAMdB9BqqXibKA/K484QhDWnYWEEi+OkfLE4R+YUHlYR/c5FSDhaHoqrC5iSuZsun
 V+c40iDkW3M2Sdt8gdV90UTGmzhyC3QudVcs3auj71TKJn2ZiVjmuvD2wOm+v7zb0tRe
 IujHwJdKYxUtJvxhshRu9QmY6sQQZSDBfMLUI1mpUvkzQXOg5ptwarem9EHRP1W7kjTP
 ypzA==
X-Gm-Message-State: AOJu0YwIVLNds9wjW1DADtUma1ThEva8LIXituUryzgmxGUkoVqLbHJY
 B8z8nsKNhi/3K6euDQAtlOyXMSv9sC8g0U47Vn5UiNonJJs9I7cj6nLa5az3amftsVXtpIIsIcn
 C2Kb2
X-Gm-Gg: AfdE7cl/69fp9mO2v3T3Njnvq2N+/GouWx4PH68UFb23BJLWFHyAbXreOmFb72JpLDC
 zKujCu9g4DWyNkMHUTxtlTswQH3t6AzZH6TDwaz3qFqZEHx9lMrFdcSKLbkSEIue9r3klCMsIhL
 PU0FxWvVCSwbqr+g3eASop0611onmVq5SfrcD7cIYCzwONIK6Z8C8/P3gxl4V0IZXv8Z/mSWU00
 kCxRffIkyuiyzI9VryDo3ZigEnFQRGGdz3uiieBJThMwuukxGbvEgNiSIaxIbXvk8OU5/uKKUQU
 wgWYqKWyl3kFhsM3wMdBuycQxvQidcnwkMzjiLFct+GnPmHfx1myMBKRn6brgsFsxpDdzF+cj6I
 rl15zd8dmilEuZxPGg9r/tW1xe2eyoUjvNC436fLSQYk3IQnQDUjqRa1Btsz1yYt9RRR2+cucsI
 H6ZkdviwO83hZukx6h/qJSYSyHiG4HDi5BtC6vZr+nzxU3Ae59+DU=
X-Received: by 2002:a05:690c:4b01:b0:80c:85e5:8740 with SMTP id
 00721157ae682-810da814031mr7406727b3.62.1782759637035; 
 Mon, 29 Jun 2026 12:00:37 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-810e728a009sm1747287b3.5.2026.06.29.12.00.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 12:00:36 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Siraj Luthfi Ananda <sirajluthfi@gmail.com>,
 Jack Bond-Preston <jack.bond-preston@foss.arm.com>,
 Jerin Jacob <jerinj@marvell.com>,
 Zbigniew Bodek <zbigniew.bodek@caviumnetworks.com>
Subject: [PATCH v2 4/6] crypto/armv8: use timing-safe digest comparison
Date: Mon, 29 Jun 2026 11:59:27 -0700
Message-ID: <20260629190027.2071745-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260629190027.2071745-1-stephen@networkplumber.org>
References: <20260625160200.24170-1-stephen@networkplumber.org>
 <20260629190027.2071745-1-stephen@networkplumber.org>
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
Acked-by: Jack Bond-Preston <jack.bond-preston@foss.arm.com>
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

