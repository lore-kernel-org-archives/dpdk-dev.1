Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E47FF5106
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 15:19:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 70D6440670;
	Tue,  7 Apr 2026 17:18:44 +0200 (CEST)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by mails.dpdk.org (Postfix) with ESMTP id D537840659
 for <dev@dpdk.org>; Tue,  7 Apr 2026 17:18:42 +0200 (CEST)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-c74f0c3fc16so1749758a12.2
 for <dev@dpdk.org>; Tue, 07 Apr 2026 08:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775575122;
 x=1776179922; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VAbgAEY0TXqFX9g1MMumoWFUlqbJ9yuyo1sKRpe25VY=;
 b=T5O8cJZSV89HVqDOC1Fa9BqRTZWDWCOSa+0rxwsO02FC4hK+cFyxXsGO5Qygaogc3B
 HMyyFsg26B3h+JzOpfw1U1CDcQWzI5OFCzsVXMhbH/cEGdZFKk7YFjCzayH0Hs0j5R99
 l34I2VAhqrKsGwLHrFy0Sxc+4RbweixxWPwS7a5O8QoBC8X6BrlPgunBhkQJWFIms0yw
 yaffR8vKNUK1rgqQ/2qT9+hJ7NKDYhVY+dI8ftWCn9m5pfUSd8vFOghaylI9Zqhml0yz
 ZhM49puCQIBKTUU26QfzZgUxwya9MPrObaukpHEMJYBNfgsMAWA7TP9LxBStBT6aQwnE
 kaYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775575122; x=1776179922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VAbgAEY0TXqFX9g1MMumoWFUlqbJ9yuyo1sKRpe25VY=;
 b=gQrD6C2AXBAkcenDBu6uiOuoPXmeCezUfMq0FF1QLGfp/teuYY1RAv2shpKnBMtmtT
 gjYXaSsc88fErQcIz1FNQkYiffBCjy5PFwMT8jYYBG8ptHebwA4t99IiMdVuNUj8Fnx0
 IUnekn9byIlLuM52ElxycHGdp4JCclCzYt0v0RgkYM/xeR3hlB4RQVQiftgqmNI0O1aE
 EmHpfyW/H1tb32QoA9ZF1FHy1YRtgG0UxhwLhhzpn/GO1CSm3deEaSP/IBQ08YalscLo
 3VEnedhdlAd1z/kV00LTwi054os8klAP6oktVsemdTrNHEtFALUb/XVZHL4nlhidOX6O
 NfAg==
X-Gm-Message-State: AOJu0YzgXQWxsLqbuYHG/+6Jy18YxkORp/6ph1OHkM1he/1SaHy4JrxF
 q70TeV820uh4phaLYFJNiOYB6bFEc7MuPNKuTx72uB6HZBYCiRPu1uxQ2U89DXjWzT0EiCqEurR
 88M3+
X-Gm-Gg: AeBDievkkSLoidN4GKq7JIk36A5pbEbUkOA1K93OgExRfxCC6LBzNZI2ELJbnhzDW5F
 e5J0H1Ap6XbcOoX4ArbaJ19+2/d/IbdAZTVfyAqhLylDbQuce/UpXoym9CLrkLz2dsR04sGZve2
 PjC7Y0jpOHgxUPYerNohTbJLE2JyPmQ/ZD07xlfAFm2NRuZoZwUeebS0dTQVAfvw5Ydj52SjUG3
 Li+FWx8x+Pj5OZJ/ZqJR1ZbBb0P7ImyZrE1+HCSAx4xoogCmvST8GMHPib2M1s9pRIEyNIsPP7N
 JaT/CK/TFwHZ1MexM9up3mHODpmYWXES7rn377kCLmk2zm8y+UDhaDAseRjPNKgBdv6VEGRhlV3
 +y4enxyt4X3WjweCwWHzyrAQMQfX8RetmGsl6M/Ui6ekJv05A8GiPnbxIRJ7jxnEu4gLoZ+R5zN
 lePhwfF3XAowefhLDmFfQBs4uXNlc6Px+2
X-Received: by 2002:a05:6a20:ce48:b0:39f:59c8:f302 with SMTP id
 adf61e73a8af0-39f59c92317mr12126224637.37.1775575121799; 
 Tue, 07 Apr 2026 08:18:41 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76c6477bbcsm15842933a12.3.2026.04.07.08.18.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 08:18:41 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Akhil Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>
Subject: [PATCH v2 18/23] examples/l2fwd-crypto: resolve shadow variable
Date: Tue,  7 Apr 2026 08:16:14 -0700
Message-ID: <20260407151732.272195-19-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407151732.272195-1-stephen@networkplumber.org>
References: <20260407035209.650419-1-stephen@networkplumber.org>
 <20260407151732.272195-1-stephen@networkplumber.org>
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

Replace shadowed optarg with parameter named arg.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 examples/l2fwd-crypto/main.c      | 50 +++++++++++++++----------------
 examples/l2fwd-crypto/meson.build |  1 -
 2 files changed, 25 insertions(+), 26 deletions(-)

diff --git a/examples/l2fwd-crypto/main.c b/examples/l2fwd-crypto/main.c
index a441312f55..ff189b5fab 100644
--- a/examples/l2fwd-crypto/main.c
+++ b/examples/l2fwd-crypto/main.c
@@ -1030,15 +1030,15 @@ l2fwd_crypto_usage(const char *prgname)
 
 /** Parse crypto device type command line argument */
 static int
-parse_cryptodev_type(enum cdev_type *type, char *optarg)
+parse_cryptodev_type(enum cdev_type *type, const char *arg)
 {
-	if (strcmp("HW", optarg) == 0) {
+	if (strcmp("HW", arg) == 0) {
 		*type = CDEV_TYPE_HW;
 		return 0;
-	} else if (strcmp("SW", optarg) == 0) {
+	} else if (strcmp("SW", arg) == 0) {
 		*type = CDEV_TYPE_SW;
 		return 0;
-	} else if (strcmp("ANY", optarg) == 0) {
+	} else if (strcmp("ANY", arg) == 0) {
 		*type = CDEV_TYPE_ANY;
 		return 0;
 	}
@@ -1048,21 +1048,21 @@ parse_cryptodev_type(enum cdev_type *type, char *optarg)
 
 /** Parse crypto chain xform command line argument */
 static int
-parse_crypto_opt_chain(struct l2fwd_crypto_options *options, char *optarg)
+parse_crypto_opt_chain(struct l2fwd_crypto_options *options, const char *arg)
 {
-	if (strcmp("CIPHER_HASH", optarg) == 0) {
+	if (strcmp("CIPHER_HASH", arg) == 0) {
 		options->xform_chain = L2FWD_CRYPTO_CIPHER_HASH;
 		return 0;
-	} else if (strcmp("HASH_CIPHER", optarg) == 0) {
+	} else if (strcmp("HASH_CIPHER", arg) == 0) {
 		options->xform_chain = L2FWD_CRYPTO_HASH_CIPHER;
 		return 0;
-	} else if (strcmp("CIPHER_ONLY", optarg) == 0) {
+	} else if (strcmp("CIPHER_ONLY", arg) == 0) {
 		options->xform_chain = L2FWD_CRYPTO_CIPHER_ONLY;
 		return 0;
-	} else if (strcmp("HASH_ONLY", optarg) == 0) {
+	} else if (strcmp("HASH_ONLY", arg) == 0) {
 		options->xform_chain = L2FWD_CRYPTO_HASH_ONLY;
 		return 0;
-	} else if (strcmp("AEAD", optarg) == 0) {
+	} else if (strcmp("AEAD", arg) == 0) {
 		options->xform_chain = L2FWD_CRYPTO_AEAD;
 		return 0;
 	}
@@ -1072,10 +1072,10 @@ parse_crypto_opt_chain(struct l2fwd_crypto_options *options, char *optarg)
 
 /** Parse crypto cipher algo option command line argument */
 static int
-parse_cipher_algo(enum rte_crypto_cipher_algorithm *algo, char *optarg)
+parse_cipher_algo(enum rte_crypto_cipher_algorithm *algo, const char *arg)
 {
 
-	if (rte_cryptodev_get_cipher_algo_enum(algo, optarg) < 0) {
+	if (rte_cryptodev_get_cipher_algo_enum(algo, arg) < 0) {
 		RTE_LOG(ERR, USER1, "Cipher algorithm specified "
 				"not supported!\n");
 		return -1;
@@ -1086,12 +1086,12 @@ parse_cipher_algo(enum rte_crypto_cipher_algorithm *algo, char *optarg)
 
 /** Parse crypto cipher operation command line argument */
 static int
-parse_cipher_op(enum rte_crypto_cipher_operation *op, char *optarg)
+parse_cipher_op(enum rte_crypto_cipher_operation *op, const char *arg)
 {
-	if (strcmp("ENCRYPT", optarg) == 0) {
+	if (strcmp("ENCRYPT", arg) == 0) {
 		*op = RTE_CRYPTO_CIPHER_OP_ENCRYPT;
 		return 0;
-	} else if (strcmp("DECRYPT", optarg) == 0) {
+	} else if (strcmp("DECRYPT", arg) == 0) {
 		*op = RTE_CRYPTO_CIPHER_OP_DECRYPT;
 		return 0;
 	}
@@ -1146,9 +1146,9 @@ parse_size(int *size, const char *q_arg)
 
 /** Parse crypto cipher operation command line argument */
 static int
-parse_auth_algo(enum rte_crypto_auth_algorithm *algo, char *optarg)
+parse_auth_algo(enum rte_crypto_auth_algorithm *algo, const char *arg)
 {
-	if (rte_cryptodev_get_auth_algo_enum(algo, optarg) < 0) {
+	if (rte_cryptodev_get_auth_algo_enum(algo, arg) < 0) {
 		RTE_LOG(ERR, USER1, "Authentication algorithm specified "
 				"not supported!\n");
 		return -1;
@@ -1158,12 +1158,12 @@ parse_auth_algo(enum rte_crypto_auth_algorithm *algo, char *optarg)
 }
 
 static int
-parse_auth_op(enum rte_crypto_auth_operation *op, char *optarg)
+parse_auth_op(enum rte_crypto_auth_operation *op, const char *arg)
 {
-	if (strcmp("VERIFY", optarg) == 0) {
+	if (strcmp("VERIFY", arg) == 0) {
 		*op = RTE_CRYPTO_AUTH_OP_VERIFY;
 		return 0;
-	} else if (strcmp("GENERATE", optarg) == 0) {
+	} else if (strcmp("GENERATE", arg) == 0) {
 		*op = RTE_CRYPTO_AUTH_OP_GENERATE;
 		return 0;
 	}
@@ -1173,9 +1173,9 @@ parse_auth_op(enum rte_crypto_auth_operation *op, char *optarg)
 }
 
 static int
-parse_aead_algo(enum rte_crypto_aead_algorithm *algo, char *optarg)
+parse_aead_algo(enum rte_crypto_aead_algorithm *algo, const char *arg)
 {
-	if (rte_cryptodev_get_aead_algo_enum(algo, optarg) < 0) {
+	if (rte_cryptodev_get_aead_algo_enum(algo, arg) < 0) {
 		RTE_LOG(ERR, USER1, "AEAD algorithm specified "
 				"not supported!\n");
 		return -1;
@@ -1185,12 +1185,12 @@ parse_aead_algo(enum rte_crypto_aead_algorithm *algo, char *optarg)
 }
 
 static int
-parse_aead_op(enum rte_crypto_aead_operation *op, char *optarg)
+parse_aead_op(enum rte_crypto_aead_operation *op, const char *arg)
 {
-	if (strcmp("ENCRYPT", optarg) == 0) {
+	if (strcmp("ENCRYPT", arg) == 0) {
 		*op = RTE_CRYPTO_AEAD_OP_ENCRYPT;
 		return 0;
-	} else if (strcmp("DECRYPT", optarg) == 0) {
+	} else if (strcmp("DECRYPT", arg) == 0) {
 		*op = RTE_CRYPTO_AEAD_OP_DECRYPT;
 		return 0;
 	}
diff --git a/examples/l2fwd-crypto/meson.build b/examples/l2fwd-crypto/meson.build
index 8c5432cb7f..c21722b85c 100644
--- a/examples/l2fwd-crypto/meson.build
+++ b/examples/l2fwd-crypto/meson.build
@@ -15,4 +15,3 @@ sources = files(
         'main.c',
 )
 cflags += no_wvla_cflag
-cflags += no_shadow_cflag
-- 
2.53.0

