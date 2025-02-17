Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B645FC021A9
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Feb 2025 18:58:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1ADF14065F;
	Mon, 17 Feb 2025 19:58:04 +0100 (CET)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mails.dpdk.org (Postfix) with ESMTP id 7D398402F2
 for <dev@dpdk.org>; Mon, 17 Feb 2025 19:57:59 +0100 (CET)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-221057b6ac4so34931865ad.2
 for <dev@dpdk.org>; Mon, 17 Feb 2025 10:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739818679;
 x=1740423479; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7P6BvNMMvdMKdqrrKBpIZQpCCCrXiSk+16i0y6I1yqY=;
 b=oIQG11XmUfYdYVKTf8ke1sUjdkZ5EHgke6/IN+ZSxSihf17xFfgn2ZTUqSE4TywnSj
 vXJbildY/T6s5QAGcacn9tpbYRjJqOPeWHIfHx7HOOR4sHbimI/FpL+LPuoiGywyKd+h
 GOhUhWCPR3EMU7VVGVectzmaaoASNWtyMPl//+q6L1imQA2kmcQVxe1mDCDhUt5WTCBL
 336bNIi7tFE5m594i/CW74K4MPIRtiLH2hjdZs9DW43JQWox4eMB2qw229yqrvovcjd1
 +hBbsTe/dldCRgEn4pvWSd1fOND2TWpTs5j2xiO2uyPIkYvI1DPt9IXo+TFt+TGAT8f2
 UjvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739818679; x=1740423479;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7P6BvNMMvdMKdqrrKBpIZQpCCCrXiSk+16i0y6I1yqY=;
 b=ih0YB0mxS2Nh+DI2i17pvkMrjGEJt5Lz4atf20J6bKeNJUkRGhsM+L4y4TGsaQ9R4O
 lsArrxeBrn5DpR6S3Z2ifncUeE8IG8H3ASL6aqfRaA/lclui5AxY+EUR6AZf6CdV5+cA
 /8zYO2BZyIJ7ZxGfi5hzq6h5YVqtqah9xolWcCHNmCauwZCERVslT/ik7Z2kn6K+5xOq
 70cVkMR/L/32phPIwOHLKQ0g16lRVGpZHbNrqaVPbUi3tXZkObZniAdlPdf27y0PdVp/
 M04ImpEc/c6RtqJ5kxF9adXks4LB8dC0q9EIZggl/HE2IeVpnxo5+r2cAwEmxzkCk00C
 z3MA==
X-Gm-Message-State: AOJu0YyugZWoOTTi7nIG9mILfF+GIk3TH05hA96fKfSu2g5xWJ6oRBrY
 eai0GvD/1c75UFwVgGUn2hhc/D2ZgHRN9ZZQy6EQVPJv1W/cEpovBwt682yORDaptymFLUt5mfh
 7b3A=
X-Gm-Gg: ASbGncsVGkqOErE87+cCAew3k/5RLFnhOiTvlK591VV8x5B81h7RPtVxsyRwL3xSRme
 df2ZnmyVdgQR37nlIarh2pzZYC3t67ckrQGKV0msMF+n9ACnHfXqsBkt50jKsXdOQ1TWaGk6tNE
 BwgSjxPiIGgkE3ljUra6v2LSmyzDCwIlTK2XGctcwPxk3XLFnfA9gTB9sZ6ZyRY36/9Rl1J+kMg
 hNs2wwxMaZJNpOYaa4wGVglyvH7rNCOMfGe1C7OiPmPvY1jiHB6jpaMMD0LRWFHeaAwJnETcAQa
 L/MiqBPBC4U91RIUttQBzb7gYNZpPYOKhwfXAhe8wX3MnnXYcZXuj4StVa4Q2KHfeVs3
X-Google-Smtp-Source: AGHT+IGG8rRCRMVeBlHS48Mfyngy8nbyLSxOX8KuT2iHmRvs4LDYiKhmN3qq09hdWXMBeLcmAptslg==
X-Received: by 2002:a05:6a21:3287:b0:1ee:66ce:16f4 with SMTP id
 adf61e73a8af0-1ee8cbfe3f6mr19922925637.36.1739818678695; 
 Mon, 17 Feb 2025 10:57:58 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-adb57c5dc68sm7815149a12.9.2025.02.17.10.57.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 10:57:58 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC 06/11] crypto/scheduler: remove unnecessary dereference
Date: Mon, 17 Feb 2025 10:54:05 -0800
Message-ID: <20250217185743.169778-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250217185743.169778-1-stephen@networkplumber.org>
References: <20250217185743.169778-1-stephen@networkplumber.org>
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

The expression *dev->dev_ops->sym_session_get_size and
dev->dev_ops->sym_session_get_size are equivalent.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/crypto/scheduler/scheduler_pmd_ops.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/scheduler/scheduler_pmd_ops.c b/drivers/crypto/scheduler/scheduler_pmd_ops.c
index 6e43438469..5f6c637682 100644
--- a/drivers/crypto/scheduler/scheduler_pmd_ops.c
+++ b/drivers/crypto/scheduler/scheduler_pmd_ops.c
@@ -195,10 +195,9 @@ scheduler_session_size_get(struct scheduler_ctx *sched_ctx,
 		uint32_t priv_sess_size = 0;
 
 		if (session_type == RTE_CRYPTO_OP_WITH_SESSION) {
-			priv_sess_size =
-				(*dev->dev_ops->sym_session_get_size)(dev);
+			priv_sess_size = dev->dev_ops->sym_session_get_size(dev);
 		} else {
-			priv_sess_size = (*sec_ctx->ops->session_get_size)(dev);
+			priv_sess_size = sec_ctx->ops->session_get_size(dev);
 		}
 
 		max_priv_sess_size = RTE_MAX(max_priv_sess_size, priv_sess_size);
-- 
2.47.2

