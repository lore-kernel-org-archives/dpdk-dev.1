Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3E2D31A00
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 01:52:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A0FA440658;
	Wed, 14 Jan 2026 02:51:59 +0100 (CET)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48]) by mails.dpdk.org (Postfix) with ESMTP id 6C87F40658
 for <dev@dpdk.org>; Wed, 14 Jan 2026 02:51:58 +0100 (CET)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-47775fb6c56so78126545e9.1
 for <dev@dpdk.org>; Tue, 13 Jan 2026 17:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768355518;
 x=1768960318; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fGLGalZNdkwhkVUgPXNRi9cK6k6be9bFKc0+vinlPuI=;
 b=3C6jpU5lbwGvV7UPl/be/WB7m7SEuhSIwpr77Sl8tgFe/O6EInXbcveFdm9loBOOBb
 1I8+9t1KOI8DYoqsZhnbRk3cI64hnz859guwqTk87cAokOVjj9kMukhKX6uany7EyFmi
 9mFwvzZ0YGvWL/8RT8egNLBw6YPpBlc6uMs/xRArZhIPpdUJRrFvg4APLbJG0jfKAJrd
 rZYGTwE1RcjuX8VZUIamt3DzNQC97PRSZ1YKx7V/7ahSx48GJsVwcWnEMJ7kDwwUJqWr
 qaEyI8vaYHDL6YPEgXGBk1kPaLHzgWn0YsizR52PNMLqC+I2DiRr/2qWQzQjZHictmpF
 H0JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768355518; x=1768960318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fGLGalZNdkwhkVUgPXNRi9cK6k6be9bFKc0+vinlPuI=;
 b=Tcr8Fkzzq8gMxHLJFltPgjllxuekPGRhuKM8WTst2h1ScU8sLe9RC3NaIENZb7ysOC
 r9gwIgFoljkt1Cj/kRIhVtoqJ/R9DVIrgjCWh5F8I5VogwrOq6HfslDvUNXmSfqNeNgL
 j5R9QlzMlcQixqZFOvfUjaH8E068vIcA+C8yQPJyhWZmuSlLPkfxy1+WxkKJePwQx5Fk
 2afDjt/TPq3y/F6Sng2zmS7lokzEYH6epMSYa+ja9HXEqQ4qtSyInrpQvNpjCdpZ+Igz
 nI6khHNrn+iHQTQqq4z7yHZy2/Y1z0Kr7sNLPabPn8btmy7w4ZGxmLnhH2L6zhJd5gHp
 cYtw==
X-Gm-Message-State: AOJu0Yx9zRKlHGiKFXujyimDbuxY8jnL+hw6iyuNgAsBHZfiPiP3nL9E
 irNvzTyQ7iFddwS/B1V5bFVLQ+vOAbvFKe86RKzs4Ri+y7wXWCfzCM3/3NZACU7mOGg9LBVrvep
 rPhcB
X-Gm-Gg: AY/fxX7NDO0EQpY0k5WnQqWRR+g6CFThKBtf74ZOejD8Cm5ui6HNS7U6UuFektpDBQ0
 vHUaCrl5AdQ52WnwDslkW2mXh40bC86+7JasTVjdBDGZ1J4zQvEn0Zex0t0Bb9+qq0JhLMF0FhS
 ZY/OF9JzC7PguGINcxBJGjUxIbYelD7uvUzxbRf49kJI50JerEiYgoOSstPcl3KQa8tD/0pKPSn
 q9tSz995VR8LftMsxZDk7ln8W3Q//GGFkfRC6JT4qVS0hIV44SabXOKe9kpoXDlUgLyf0Erh8gn
 fUeJ0ykjsj/Von/xV9b1F3pR65YtGGziKvao4TcGUTmKt25uCO9J6ngOEtIJZipnbTd/i831v+S
 PCRLiNQf7loEWYu0AvgJ2OtY2OeIs714SkFUSkoYvjeoe0Bktmlr/T6ZwfsQ67hlDQXH+lOmp8P
 1tDuR1pIxQ8+UQoy9Nw1hZ2kLFqEePjvdn/AjqoYem/4F0alFNkA==
X-Received: by 2002:a05:6000:18a6:b0:430:fc5a:40ac with SMTP id
 ffacd0b85a97d-4342c553815mr768590f8f.54.1768355517548; 
 Tue, 13 Jan 2026 17:51:57 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e1adbsm47619810f8f.17.2026.01.13.17.51.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 17:51:57 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>
Subject: [PATCH v2 1/3] common/cnxk: replace variable length state array
Date: Tue, 13 Jan 2026 17:49:59 -0800
Message-ID: <20260114015149.70983-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114015149.70983-1-stephen@networkplumber.org>
References: <20251023194237.197681-1-stephen@networkplumber.org>
 <20260114015149.70983-1-stephen@networkplumber.org>
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

The cipher function is always called with in_len = 16
and there is an existing define for that.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/common/cnxk/roc_aes.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/common/cnxk/roc_aes.c b/drivers/common/cnxk/roc_aes.c
index d84feb546a..b42c785249 100644
--- a/drivers/common/cnxk/roc_aes.c
+++ b/drivers/common/cnxk/roc_aes.c
@@ -157,9 +157,10 @@ static void
 cipher(uint8_t *in, uint8_t *out, uint32_t *ks, uint32_t key_rounds, uint8_t in_len)
 {
 	uint8_t data_word_len = in_len / sizeof(uint32_t);
-	uint32_t state[data_word_len];
+	uint32_t state[AES_HASH_KEY_LEN / sizeof(uint32_t)];
 	unsigned int i, round;
 
+	RTE_ASSERT(in_len <= AES_HASH_KEY_LEN);
 	memcpy(state, in, sizeof(state));
 
 	/* AddRoundKey(state, w[0, Nb-1]) // See Sec. 5.1.4 */
-- 
2.51.0

