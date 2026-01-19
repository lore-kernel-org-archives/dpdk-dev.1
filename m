Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C2FD2ECEF
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Jan 2026 22:46:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1767E40671;
	Mon, 19 Jan 2026 23:46:11 +0100 (CET)
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
 [209.85.128.68]) by mails.dpdk.org (Postfix) with ESMTP id BB4B340670
 for <dev@dpdk.org>; Mon, 19 Jan 2026 23:46:09 +0100 (CET)
Received: by mail-wm1-f68.google.com with SMTP id
 5b1f17b1804b1-4801bc328easo39160755e9.3
 for <dev@dpdk.org>; Mon, 19 Jan 2026 14:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768862769;
 x=1769467569; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Siav5wb58so5O2h51qbRcyHKEETKf+HS7ZDF+vCjbxg=;
 b=CIzw8UUekuArqf4dCy7CcTd9dOUob80uTih8o0Ery/Hp7YlnBcmgf41jAZf9oq4+21
 f/lVlhISP4d1PpTBoNq0akyWCNK9WJ5U4NJdVslrnUrHAgzKkp0z3liNAExC2j+O5wkn
 x9b3LFxiLgX1Ipv3tN44k4eNqyXyhYv9ED6NeHHuct7TaoOsYeAn8e0BGPMP2cTrWtQs
 vkJVGIYEFkY5855tnbIXcYaZE0z58Qn0ljhPxQAd6ei+5P3OeC+RKm5RIpMg+dFTqh6l
 IP08002sc85mFElN/r2BmMzAhOJYdlEYTcl2rM0em2pFNWCXhSO7ToMxeBH2PzubF+TI
 nYzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768862769; x=1769467569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Siav5wb58so5O2h51qbRcyHKEETKf+HS7ZDF+vCjbxg=;
 b=scOr3mvVtjOsv871f6ok0CKW2MDIwKn6spGwWtPtbMO0ITY0n/71RP6mIH1bJ0pF9z
 7dPbMty9VWj+F1rD8Qv7Lw8l8pDoOlz5fzKmsW5gaSOC3BG32qVsiaFdEgb2sTo8J4kj
 xYN0Oj+zuJYhNHIVxxNW+KOZQMzNOzni8qZ9QFriSum98xWAlKvCvwIgWDEnErOwcOXm
 mTrGQIbtkwrIa95rgCkGncoIO5HxWI/9hzueRx8Pg86rZY0FPO0I+8oDczdospA7ICXA
 0zlZVOJyE6B+iVimy6zlNCliqoPoR0CDw+InmpPIxaYKHTyMMaVGSAb5Sttu7AUy1wv4
 vo/Q==
X-Gm-Message-State: AOJu0YzWkLnZ71gjpFLzMlAA7CEiDM7iw0SQ/P62Gc8U1fIeyPVIJJo0
 xdJ6Cr4wKVe9sZZPRrHPbXNn7HuPk50iJpdy5SBez9Ky1EgZIaRVY/lws/ekSkF69T853LzWa7R
 mp2wBwQs=
X-Gm-Gg: AY/fxX5Ris5Zf5zgkziaRsUjmZ6llTj9IRlf8q1AeiSwOgGEhGaiFSuIwpgseno23N1
 nKwFMi1BWril92M8LhAgNwtZluFc5sBG1QspcFjARIgFx6ySJL5Ke03fF+/wbwwmKhnPAeitoVk
 46opE2ihs6z7gfaCBUZDABtwB/sBwPkjei4VgKIH8N5wiqxk2OAA6nucP9uzg/+LOyKJAMCMfP3
 ur4SudXzynsQ8NKvv/ruF7SIcQEOsYYFegwwbNKTkHaay9Y6uY2jaFCFWFIp9kgojKS/V315z6i
 RB0oK3XMevVO9+H6p+jIRGdT54hiWQREl+xMKLm0C2y625d6J3dgHb/ZNYSlT/N2ULdZ/7Em1EK
 /qv0Ad1/a1FIdIoLwx1xYwkFpIcCFlIm+glc8zWESpRX3UAqmAkR5eDIz1NpELFZ+xIaPbOPsHG
 ZVVtUoEne4t88T09mEs2zHcCMhhwFcMuAiQ+cmoQrJhd7O0OoDXsKfxptwRC4I
X-Received: by 2002:a05:600c:1d28:b0:45d:5c71:769a with SMTP id
 5b1f17b1804b1-4801eb0d727mr163345545e9.26.1768862769345; 
 Mon, 19 Jan 2026 14:46:09 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801fe2b936sm88180485e9.11.2026.01.19.14.46.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 14:46:08 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, rbhansali@marvell.com,
 stable@dpdk.org, Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>
Subject: [PATCH v4 4/6] common/cnxk: fix buffer overflow in reassembly SA setup
Date: Mon, 19 Jan 2026 14:44:11 -0800
Message-ID: <20260119224553.226243-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260119224553.226243-1-stephen@networkplumber.org>
References: <20251023194237.197681-1-stephen@networkplumber.org>
 <20260119224553.226243-1-stephen@networkplumber.org>
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

Bugzilla ID: 1513
Fixes: fc9a711b5c8f ("common/cnxk: add NIX inline reassembly profile config")
Cc: rbhansali@marvell.com
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

