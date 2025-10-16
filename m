Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B25AFCCD199
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 22:10:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D1B9F427CF;
	Fri, 17 Oct 2025 00:10:08 +0200 (CEST)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44]) by mails.dpdk.org (Postfix) with ESMTP id 8E815427AD
 for <dev@dpdk.org>; Fri, 17 Oct 2025 00:10:06 +0200 (CEST)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-33bb1701ca5so948379a91.3
 for <dev@dpdk.org>; Thu, 16 Oct 2025 15:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760652606;
 x=1761257406; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YEUQb/ZOPgR+Ke7u7NDLmJRZr0wmZ/leG7G/BJ8SCKc=;
 b=B2DsJIakbg/+TNCPC2Dx5cmC7GGh6hRm1DXLJm/E4RtNYwvg/v0bSwp69lg1SxfAay
 SbK/R29TJQJXg2g/mnO2s6P0g1uUqYzWgArZaP6jlDy4atgudKkTPmY03nCzi2gmkMGj
 RS6Dmu85TUCjXd52H2UZvv/RkAu12wMnX7J7SGq9lSmm+qg4TCtRKBwIzIKyFslwsQPs
 1Ep2kdnbhIyLlcOg0vkRK4XAjOHk6vLrHM3qi65h2Ff+VvuIriYk0p51dTsfOEN0BDes
 zMSoLO+oBFdv8Ufc+G0iq3vUI3ZkFzRsu/w4Zsk2cgehFpn8jDn8J8xAZoGGlYrdNiSQ
 FgDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760652606; x=1761257406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YEUQb/ZOPgR+Ke7u7NDLmJRZr0wmZ/leG7G/BJ8SCKc=;
 b=ugbqrwpV2fabdia9EV6us/CYWqa5haObkRMODHCUB7YMogQAMlq9flOx2aLvInmAE5
 mHnN2pjsOHbhvcIq8urQoO+y7Zr/sRKBdhtWIKturAmbhf+Htv+el9op80nT27NtL8Sf
 xXP9mu1rRfWQWbK7b0qITIczV863pdQN0ZcJAnWj/J5hpt/f2lpmCwrW2fGiCgcRrV0A
 ufkvAXxC8CAjFxiNaIqg+NK67YfBrL3caUC6Z1Na+ZF4UpxAURvOVeuyNntoIAluoQI6
 TH7GA59GJIe46RNvwHmgra9q2egK30qQ79Y9YIxePFbWZUW88uQHDqAjMGc5mSrH6Bto
 ZGYw==
X-Gm-Message-State: AOJu0YyaAY1b0c0Dn4HllW+X9Ni4GdxoHF1KUXH7+6jO4Xk7nImyMk17
 KwE4l8VmCkoFETuDFvrwqb8wa1pi1FQSDAZsCBdm+aF2hYSB04IyaHqQ6rIbxCiOdNMzOn4otg1
 lbYnwiVg=
X-Gm-Gg: ASbGncscTlukd8hPY0nn2/szn9QAUejuuHD4KR+cPwrE45XzttN6BYQEklRERZven8e
 zWcPG5ou6okJ72wmV4yR3VsNDJenjHABAKKIHX/embI6SHsOfgo8ZXij7i6dvLBohk9TTYyqsKM
 UBHD/3QcLkTFser1Ck0rs7QH1pMomT6nn/ysvA4jGBj1QNTRxtDMimYlnLps4GOKhSqkSYZOisl
 4B7NQ33sFL9W640txbhKXR/S2JxIAWyGZ5NqGdXcc5suIdCfQhmroluILSW3JQ/plAqvfbVkFrd
 LImS/0rvoFafJUpRnlyNwHF3RgCPJD5rxnCAhzfBp+ilMWB+z40RULXHXUFsdBNbRrP1Id35zjr
 6FHP2eZje2Kpi2urxAGZVXizUnb04/d7CBOaNPvuAFmjg1tO+EZmihnK9TvlRCZpjhtu4yGSjnQ
 BJ/xfSqjZHpV5CSBTIJ+VoJ0VaxQx4qGoxc1RqqCleqI9jWXnOmQ==
X-Google-Smtp-Source: AGHT+IGks8LY5CYK73fQgra3a5NXQ0l4K6V4rFixacnRZi7g9JjiuRKXu00pIJ5M6dEVJCI4ryy9HQ==
X-Received: by 2002:a17:90b:1d88:b0:32b:df0e:9283 with SMTP id
 98e67ed59e1d1-33bcf90e86cmr1423660a91.34.1760652605710; 
 Thu, 16 Oct 2025 15:10:05 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33bae2a4e03sm1731259a91.4.2025.10.16.15.10.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Oct 2025 15:10:05 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v2 3/3] net/dpaa2: make total_rx_descriptors static
Date: Thu, 16 Oct 2025 15:09:03 -0700
Message-ID: <20251016220959.15671-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251016220959.15671-1-stephen@networkplumber.org>
References: <20251015230933.875860-1-stephen@networkplumber.org>
 <20251016220959.15671-1-stephen@networkplumber.org>
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

Do not expose total_nb_rx_desc, can be static.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/dpaa2/dpaa2_ethdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 41678ce09b..33e3917ae5 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -79,7 +79,7 @@ bool dpaa2_enable_err_queue;
 bool dpaa2_print_parser_result;
 
 #define MAX_NB_RX_DESC		11264
-int total_nb_rx_desc;
+static int total_nb_rx_desc;
 
 int dpaa2_valid_dev;
 struct rte_mempool *dpaa2_tx_sg_pool;
-- 
2.47.3

