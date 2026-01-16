Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB0BD4A605
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 06:47:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EDFC742DD3;
	Fri, 16 Jan 2026 07:47:04 +0100 (CET)
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com
 [209.85.218.66]) by mails.dpdk.org (Postfix) with ESMTP id 23B2042DD1
 for <dev@dpdk.org>; Fri, 16 Jan 2026 07:47:04 +0100 (CET)
Received: by mail-ej1-f66.google.com with SMTP id
 a640c23a62f3a-b8719aeebc8so310136966b.3
 for <dev@dpdk.org>; Thu, 15 Jan 2026 22:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768546024;
 x=1769150824; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aFTCgao5yj0XCFm0nApcd5Uxw9YJxVQR9XnXrRYnOQ0=;
 b=DirEwWSxmONKncpsaGZnwmz+O58wQy0pMe4aeHfmMRQ+I0Z6wjgN5bwbsaNfJQgrov
 EeWz9gls7Dd6Cypxqd8Rjbrug9gMEwYl+AhykJM/HHPaRZLqvdAdoYs/BNqOHymB5yZA
 Wr/GE7N0lHbtTDSe5NliCu0LbnTvWToznV9zvDYXfFSrClO552B0aSQ9CSXNgnrPhRLk
 wjXxQQjDxMom+YvKg4c5V8dToSrUe/U3IJPrAjpBV1UvJEoEnkxbLoE7oR+jYutun3kz
 Gc4a0FPKZWFkHNw6NmOpCzqe7QesbE2GapHejtr40FZdzahcQK7BPHykuG2pD6Jf//f7
 LPUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768546024; x=1769150824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aFTCgao5yj0XCFm0nApcd5Uxw9YJxVQR9XnXrRYnOQ0=;
 b=psyTzBhcoQnDmVQ0qn4rB8aMiy1EURI5FcLBKhH+3hmMs10lXEIUfcbo1+sC5QxkqA
 sfo9L9cAdsRCUnWQE4wD76t8He/IzMJvPd+h/8XCAKwdaoED79d33+FnSNiARofY7bfm
 3E6KELgBXCKnHdqUt8QFPuJ47ze10UG3/ka+dlf+mlpzfc4SKurP0nvPU7JJHdEzDhcM
 YA2JH/YoU20/inKFCAaTteyPvVUAcpztCxLyetLATnOPaT3/5MIvB+SbZAf2rY92imE7
 4XLE22/CyTybTQDAiCDhJhZF0P6uwRBUIUu2gZtHQ4at5hXWMJbvf/WDdum4O2RiMJOt
 1pXw==
X-Gm-Message-State: AOJu0YxE53dxuvboytPfuzCeuFmZEBbowXW4nDFHB8e7axKzm8nIQhjk
 equyiowjQZEBTMzMX9nbFIKqBEftvLvIyxDvGoGhlXUTaFITPLCWB9lqvMp5q9pbzVngd5rJMZ8
 an3w4xlg=
X-Gm-Gg: AY/fxX7fd2rnY9o1YJDDaZv6ojn3GnlFIAG/UUhnfm1Rm4Sn2omtjgp8HBCuek+Jhz/
 LcSKwHt3ub9kFOj42TQx5Yz2IXOD4OX1RUR4Z5Cr0x7oob3ABC/wq8C1FX5ywxPpOIUpIERcvz3
 1CSGi9ilQX9BQ/bsyVOO+kBE19ricKe4roBGToHfqfjDOTCEQAu6anbuiko+H4bAGKvkqvk+Qn1
 meXr7K/MkksHi3/J/6dvX/w76myqbG9K1reDU7/1RZEg7bdKisUWK9BbZCRbJrAS4sdKzkoMtzq
 XJg/Frdq/2PFssZ0nz+omgrh3lxP8XtvUmGfV+rMqZO/cxOAQ/hKjkPVTxIW67cL9HHG80s4QHZ
 k1rjPQeP9VP6z7QyOy3tx8YCE/3Mf7HkqqWIswMb5pX5iscimkuek+w+oOHqtlOy3j+W2Tec6vW
 a3Cvp+sBX1FH/PsmyGQMIUw8K1glapmSU6dqVlyzNSvExWZP3oxg==
X-Received: by 2002:a17:907:7b9b:b0:b87:173f:630 with SMTP id
 a640c23a62f3a-b8792f85a10mr178260866b.40.1768546023544; 
 Thu, 15 Jan 2026 22:47:03 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b879ae74639sm97172866b.9.2026.01.15.22.47.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 22:47:03 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>
Subject: [PATCH v3 5/6] common/cnxk: fix buffer overflow in reassembly SA setup
Date: Thu, 15 Jan 2026 22:46:26 -0800
Message-ID: <20260116064646.224254-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260116064646.224254-1-stephen@networkplumber.org>
References: <20251023194237.197681-1-stephen@networkplumber.org>
 <20260116064646.224254-1-stephen@networkplumber.org>
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

The nix_inl_reass_inb_sa_tbl_setup() function initializes inb_sa_sz
to 1 byte, then allocates a buffer of that size. However, the buffer
is subsequently passed to roc_ow_reass_inb_sa_init() which performs:

    memset(sa, 0, sizeof(struct roc_ow_ipsec_inb_sa));

This writes 808 bytes into a 1-byte allocation, causing heap corruption.

This bug was detected by GCC's -Wstringop-overflow warning when
building with LTO, which enables cross-compilation-unit inlining
and allows the compiler to track the allocation size through to
the memset call.

Fix by initializing inb_sa_sz to ROC_NIX_INL_OW_IPSEC_INB_SA_SZ,
which is the standard macro used elsewhere in this file for OW
(Sobek) inbound SA allocations.

Fixes: 75e073242acb ("common/cnxk: support reassembly with inline IPsec")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/common/cnxk/roc_nix_inl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/common/cnxk/roc_nix_inl.c b/drivers/common/cnxk/roc_nix_inl.c
index f8be98efd5..1766f68c17 100644
--- a/drivers/common/cnxk/roc_nix_inl.c
+++ b/drivers/common/cnxk/roc_nix_inl.c
@@ -583,7 +583,7 @@ nix_inl_reass_inb_sa_tbl_setup(struct roc_nix *roc_nix)
 	uint64_t sa_idx_w, lenm1_max;
 	uint64_t res_addr_offset = 0;
 	uint64_t def_cptq = 0;
-	size_t inb_sa_sz = 1;
+	size_t inb_sa_sz = ROC_NIX_INL_OW_IPSEC_INB_SA_SZ;
 	uint8_t profile_id;
 	struct mbox *mbox;
 	void *sa;
-- 
2.51.0

