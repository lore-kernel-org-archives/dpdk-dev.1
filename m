Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4465ECD994
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 17:58:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C0A8A4279C;
	Thu,  5 Feb 2026 18:57:58 +0100 (CET)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50]) by mails.dpdk.org (Postfix) with ESMTP id EBA4142798
 for <dev@dpdk.org>; Thu,  5 Feb 2026 18:57:57 +0100 (CET)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-482f454be5bso19328305e9.0
 for <dev@dpdk.org>; Thu, 05 Feb 2026 09:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770314277;
 x=1770919077; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QGNuRblYumtwqpN+9gqA2URFkAOSBLjfXWBeuth59Rc=;
 b=Z4aUdvcCiSd63C+ZbBPxJYrbtnnquuuKpFHFZ7iyAj54KCpxdHCnvrHFjgPJKd6Nqu
 X7hbFTHD2OxwTjOW0KFKah1oiefzDI2gyVCgcZptQUUNfm1ukK2BsCJJvn2/Zw/MTPGV
 7zVTz7qTnleTnG7JiHYQORcc8x4G6Axv8Pt1LQuGOnLWOAPoIpLXPCpD9nPdBsPXIGyc
 G36iZI4sSvXhvCjNxo54U+thYEezUykR9mYDFKjWCVSA+eY0LiYKhwn10tzVs4h4TO0X
 kRXbVcp0smpc9NHngAEGs0TvOVsm/YID1TAviuC9sYLlR7Mv76dun/Jq6Xl63rCWfzmO
 8kqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770314277; x=1770919077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QGNuRblYumtwqpN+9gqA2URFkAOSBLjfXWBeuth59Rc=;
 b=b3kqfM4xuF1WIax7LDtHUbP3ZzKHbpUAVCrtLUAbxs209byMEbY6rk0vswmB8Jqmuw
 HA/p4EWl0mcaeQxzE1QVbjde88UFDJeSgol0y6jYldA4hrPzxY68gcNokR+cmchypINN
 LT1sbTO20iAT5iNfXbHjr/LnaOYW3HGL2E13aJKguiqmd6epAzvebr8FQ3WYC/pElPf7
 bVxjpLd5Sd/c5KjY6sGRnmR2i6dTCTtPorFJrif6wednixUfVhycoxFBSij2R8y0LYiB
 tm2J1MD5jANs53EJZwpGKCS7mknU3gKywPhUBwJvNI5rncO7PAASFfvIlK/cjNzfRnP7
 0kaA==
X-Gm-Message-State: AOJu0YyatV+g1j2RT7BDLH5GS2v+xWOxgod5Fp4M0YxyjoW/YnVzpcS0
 ap85i6tVr2Bl7ntMhDowHa97C4aqpb5VxC/bMXGJTKPyl39kLZJYnScgm0ECdcSKVDFSP+OZ5Po
 3DumM
X-Gm-Gg: AZuq6aJkA1fea4iLh1fHg6c3fBSNkZ1PoTkUSqpgWLa38PRtM34Oq5SvJuNXLW6A5xV
 jnPYcLjDKy6oqY9JFUdOv1Cvyp+kF19vylah5X6Lbie7JHlTPZrKpA3cIKOUftsfBrfp5Pek87I
 R8dOHt581HgZuqTPmeSxg1e7GsTnQfUrJWk6BlBpM2MAB32nSqIKvJXnq/FKKux3OYbhJGdqPEQ
 O1Ovk0YWVcNTF8SgIH5B74mpiaazGAESpzOix90la5rtMQutXCbcCE3hsAtem8fZr3mqkAFSu6z
 c0JsYRsU+pWqDx8XU2r5ITHMVLW8UHUm4njwL1cpTNVnXOBExk3sQxamm2/YSP77jlMGAk5cu5U
 cMRwo3rd4B2ZsNyA4b3Giehh2l0P/j3Lj7Gy0JqkgPOhEtb0Z/VouGovSSm+DDAog/iG+Nz6e1k
 D0YeUrZVaPesa9OOUNzlOhFYtHYkqbIropIkuweelWDSJWbIMmNQ==
X-Received: by 2002:a05:600c:8b6b:b0:46e:59bd:f7e2 with SMTP id
 5b1f17b1804b1-483203d074emr1543985e9.11.1770314277558; 
 Thu, 05 Feb 2026 09:57:57 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43618057f7csm15465594f8f.23.2026.02.05.09.57.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 09:57:56 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>
Subject: [PATCH v6 1/6] common/cnxk: replace variable length state array
Date: Thu,  5 Feb 2026 09:55:53 -0800
Message-ID: <20260205175750.653353-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260205175750.653353-1-stephen@networkplumber.org>
References: <20260120195418.466318-1-stephen@networkplumber.org>
 <20260205175750.653353-1-stephen@networkplumber.org>
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
index d84feb546a..babf149ccf 100644
--- a/drivers/common/cnxk/roc_aes.c
+++ b/drivers/common/cnxk/roc_aes.c
@@ -157,9 +157,10 @@ static void
 cipher(uint8_t *in, uint8_t *out, uint32_t *ks, uint32_t key_rounds, uint8_t in_len)
 {
 	uint8_t data_word_len = in_len / sizeof(uint32_t);
-	uint32_t state[data_word_len];
+	uint32_t state[AES_HASH_KEY_LEN / sizeof(uint32_t)];
 	unsigned int i, round;
 
+	PLT_ASSERT(in_len <= AES_HASH_KEY_LEN);
 	memcpy(state, in, sizeof(state));
 
 	/* AddRoundKey(state, w[0, Nb-1]) // See Sec. 5.1.4 */
-- 
2.51.0

