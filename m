Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24461C0219B
	for <dpdk-dev@archiver.kernel.org>; Sat,  8 Feb 2025 20:34:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6DF8740DDC;
	Sat,  8 Feb 2025 21:32:37 +0100 (CET)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42]) by mails.dpdk.org (Postfix) with ESMTP id 12AA140608
 for <dev@dpdk.org>; Sat,  8 Feb 2025 21:32:33 +0100 (CET)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-2fa1e25e337so3373285a91.1
 for <dev@dpdk.org>; Sat, 08 Feb 2025 12:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739046752;
 x=1739651552; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jamikUKVHIVt/j0Nj9txcipDyZKo2sG2vntbFoi2xdU=;
 b=PawEj+V6Jxk3cuKHzivYAPoJpZWGi73oXes44rRQC1QPI6Zl6/CaVRsjBMp5f2bEdC
 uUCJScwSHiu/8+xv6D1gfBR8HdcdaB4xj9wyzrl1n+D2IdojnoNDe/eGnPyRcgYR69G6
 lT/RZ+wq2e1LvWeTjZAoGyB1zaLjfy1E/SQzRrLtmaLbiwkI8YzboytX8eVvGzlhnRfn
 pf3nm7++pPvPvdzoCntQFQO46kl2R7sbw+cKSJn4fe9z48y42qBKBMOtt7H575TvPv43
 QQSxTEwHPNcp4+YoH+Fk4zdioVMpcAH66yOGTstZ7qkbPkkr+uL4cvMYC1hziBarn5Ca
 6CVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739046752; x=1739651552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jamikUKVHIVt/j0Nj9txcipDyZKo2sG2vntbFoi2xdU=;
 b=AxMoGM9AUaqTE1ys3cZBYCjLS5hvmuN7Ko9byXXX1G/JJBRJUy6NVgPrvJ6MsJEdrW
 0rcB5hu/nId6m5rOyGW7K5ixUkr/Aefub6kgbX6rRwyU6VY88xvYtSN2EHr4qyiqdUS7
 UML4B/aNT9TFWoT0vl2pJ6FIZa14XcJsAlNAf3mhmHT1QBDhXuJJcSjMDpZPgQ4pJizo
 EppaM0CxC8PERnUl8/BGegoeGhEMvPMFt+Hk1D44DR9B8ObwEhPEBqwtvyrux7jjzL5m
 z1MppwdF48TZMdSdn4B/LBMTbYfmUq/ojbbEbMDdhU+fvBYM+pLY8U+9pv1g+2rU0ZQF
 wiaA==
X-Gm-Message-State: AOJu0YwWh9qDFMWg/Q7G3R4cVr8VcrJFyJDGjpfjTKHn9DcQAVu4xL/O
 qgvWA3tohBwh2JAj96/LAoyWH69A9e14ZaTFDg9DnrKTEp0OC6EzZVW0QczfOVqGFzq9lyrIdHB
 JOLs=
X-Gm-Gg: ASbGnctvIzN2ViP1GVZPYlCaWiuM5PNdYN6dPdhOe2CP8Kw0+8hPXvcIkVCqCnD8eg6
 OWczRxg9mT0DErxb6NU2SzWBq+Jfn7cJjSBLgUSBaUsSSwW90wWJxdIIyMZf+E9VgSOISTCx418
 /HCB/LTvIRwktaMkad19X9kFMtO4+fPAkjHNVMZZl6JBChv1ZjPt/qqGqRLlqjll1Hxvd7AA1MN
 ULYEzN0HVRW1D8kSvC/hyRkz/ax7AlRm2lcOrvuQl8F/9GPi96l2alc+AQ63a74mOKCV2brJyt2
 CP3sfERdvJ0VoraY4eDR7poGX7J4/DVNUKLBDoKK3MyE1Mswe3uFxrpsWM5MVjQL4usw
X-Google-Smtp-Source: AGHT+IGIs6F9q9yQq+qfs6tzwtlf/jwdYYUwmsFhX90bJeWMnxA1sYd3mCXb7++Q0kaOafZEU2vrBA==
X-Received: by 2002:a05:6a00:2d10:b0:72a:bc54:be9e with SMTP id
 d2e1a72fcca58-7305d549e4emr13009005b3a.15.1739046752166; 
 Sat, 08 Feb 2025 12:32:32 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7304c780da5sm4882019b3a.69.2025.02.08.12.32.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 12:32:31 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Akhil Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>
Subject: [PATCH 32/32] test/cryptodev: replace memcpy with structure assignment
Date: Sat,  8 Feb 2025 12:22:24 -0800
Message-ID: <20250208203142.242284-33-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250208203142.242284-1-stephen@networkplumber.org>
References: <20250208203142.242284-1-stephen@networkplumber.org>
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

Prefer structure assignment over memcpy.
Found by cocci/struct_assign.cocci

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_cryptodev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/app/test/test_cryptodev.c b/app/test/test_cryptodev.c
index 441ecc6ad5..50518dc5c6 100644
--- a/app/test/test_cryptodev.c
+++ b/app/test/test_cryptodev.c
@@ -14837,8 +14837,7 @@ test_multi_session_random_usage(void)
 
 	for (i = 0; i < MB_SESSION_NUMBER; i++) {
 
-		rte_memcpy(&ut_paramz[i].ut_params, &unittest_params,
-				sizeof(struct crypto_unittest_params));
+		ut_paramz[i].ut_params = unittest_params;
 
 		test_AES_CBC_HMAC_SHA512_decrypt_create_session_params(
 				&ut_paramz[i].ut_params,
-- 
2.47.2

