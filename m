Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30DF0D2629A
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 19:54:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 722794114B;
	Tue, 20 Jan 2026 20:54:38 +0100 (CET)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42]) by mails.dpdk.org (Postfix) with ESMTP id B380F410F6
 for <dev@dpdk.org>; Tue, 20 Jan 2026 20:54:33 +0100 (CET)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-42fb2314f52so3253624f8f.0
 for <dev@dpdk.org>; Tue, 20 Jan 2026 11:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768938873;
 x=1769543673; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Siav5wb58so5O2h51qbRcyHKEETKf+HS7ZDF+vCjbxg=;
 b=u07yIli7VgZoUGrHHwCkHCmAcufanBBDIiz33keE6fJFxl8M4tBq2d3sW2ls8HE2P/
 AR299JslsAJwJdQZh3wY75jF37hpHS3XAOmwF71kcmQrGn/QnH/6ByWt3O/kUt47fcQu
 RFtXoIv737bBuwtmkxMJ16LPR/hQZCn8E6Gncv4aMnI2Y9a3a+mvmfOBEqMVz5FoHWzF
 UJz86NDjHqgMaPcU0wsuBFrRPwKDFTp7wVuj9OjZMIf+xIM8wMpQlx7F6jCQ8bfAoUPd
 3Oxt6LYNLcY6PYGcpYS0twy1u6Z87AvdxsghGz5hOw+l+FykcOiayf+brPv9Do/I2FmN
 MttA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768938873; x=1769543673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Siav5wb58so5O2h51qbRcyHKEETKf+HS7ZDF+vCjbxg=;
 b=jdUYjEEcy0QRgNn++IOUNJNFHc55lVVeiUTt961wAXWNGKUofuh7WOy39gDtauodbI
 oT+JbQFXnKc5CKTKrD3OfmugGsOBwtMCtKuA/NkiY08NK9o/Jyh7T/vB8p7HMX31G93n
 /4JEzGK9J+Mm9qABFFZU8sAwPRdqEOGesTHFFB1LjpVQJ7KW/2lrrfaN46fVYPFETRXg
 FIF7SENRkTfHiabsz+9N2AHGmPNUy/cRlnE/+wuqg7ucFL21VJMgY2os4kZa2SZnL690
 PfphxjDOOaZPpNEnLXSAw1+kljdVJZHNpQhUCXeZZ3lD9poY1G0ph/EjuRbl2i+qdHN6
 qt8g==
X-Gm-Message-State: AOJu0YwMdtyjhjB8/xJSIHHgqAnjGen7cJOlRw3q9n+yLndgTyfLnnUm
 F3rydPd2Iae+Iq7nxuFCHX6BFFFk91/HSQ5sWtGKqyEbuK6JugI/2XS0+hewBGHpk3U9uGm9Xk7
 0qwnU
X-Gm-Gg: AZuq6aL9A9sOSv8tO31heT1WlFr8wi0hT5CtuYFLfjnw2GgiVZYsLXNW8dwpiwnv6sB
 zh+eqqK29qb3FyzS27QfYumSn/Js6Sr7VofZ84Ib80j7HaAI+B3tZfzV9JI78l+Mwnw5QSsY0Gn
 yl9wDMFFJ8pQoHCpZykAwHp6/QgQDnBvwMMjzsXCdBpkFY6cvYJn2b1JL7oFFosIQlohO0NuDJ2
 ZkXHd/TpQpDJkFGCRSfZqF591wzkz+9P6sXlWRzmukVLuGo4Teo1lSqOod291Mx6n0TaeHNzj3a
 9S4BPfWpINJgwNaYeoIsXlxlIq+Y2z/99FSu5zQO5RTF4GcZKV9H/XcfAQ2cW579Eg4APWsFg9l
 aPwy0+5iopzg3TCn9MPi1RRMjbBDGLzIZhQ5Ics3G9HU7DQpCPqeYhpKHZAHE6Xa+IRcZ5GDD1o
 XkpVwcfW6zXAgp9xFegpOQAU65eIiYezu3Rjre4I2EkFOzSU6bXA==
X-Received: by 2002:a5d:4a92:0:b0:435:94dc:8c78 with SMTP id
 ffacd0b85a97d-43594dc8d0emr3090353f8f.40.1768938873291; 
 Tue, 20 Jan 2026 11:54:33 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43597bda41esm1354644f8f.28.2026.01.20.11.54.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 11:54:32 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, rbhansali@marvell.com,
 stable@dpdk.org, Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>
Subject: [PATCH v5 4/6] common/cnxk: fix buffer overflow in SA setup
Date: Tue, 20 Jan 2026 11:52:09 -0800
Message-ID: <20260120195418.466318-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260120195418.466318-1-stephen@networkplumber.org>
References: <20251023194237.197681-1-stephen@networkplumber.org>
 <20260120195418.466318-1-stephen@networkplumber.org>
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

