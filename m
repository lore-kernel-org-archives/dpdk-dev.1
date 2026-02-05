Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799D0ECD993
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 17:58:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 392D4427C6;
	Thu,  5 Feb 2026 18:58:07 +0100 (CET)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54]) by mails.dpdk.org (Postfix) with ESMTP id F0DA1427C4
 for <dev@dpdk.org>; Thu,  5 Feb 2026 18:58:05 +0100 (CET)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-482f2599980so14406265e9.0
 for <dev@dpdk.org>; Thu, 05 Feb 2026 09:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770314285;
 x=1770919085; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Siav5wb58so5O2h51qbRcyHKEETKf+HS7ZDF+vCjbxg=;
 b=070OAiQ2TQIpWyciMyUjT85QXykoWXsBGTCzdCkP6UtsVtKdmxBfnm4gp5atk2q+AW
 jheQt42jfVQxhLFMIx8DTTXekjIQR8BKX33qDrWEDeN0uqIOI1HmVXpjMrNcP4RySRFw
 1ZAUH7z7QdXD8LRoJSDLZ+aVNqs0IB8RgMQnkMqm525PXpTWqrnw6IKyfYFyxY85WpUM
 +G8oFw1/vB997DdPJ35UNL2bXu1n+ZoyinlqZ3nhP2KG1CyuTRculUyPr26K8GG5qPrc
 xtNMEEsIxMESc/Df1RBsG+cUPsj1DVrr5zs04H4711w7N4t4oMbxhdu187pYbBkYpvX8
 7eLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770314285; x=1770919085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Siav5wb58so5O2h51qbRcyHKEETKf+HS7ZDF+vCjbxg=;
 b=Vb5ma8QxoCiZdOeM2NFVdOWvBMbLq+MwZ/tSqaSFh42zw6Qfl4VPukLg8s2Dmslf/G
 a+kgwhWg440IAu5NLzjgl1SlvkMrPAiy/PWr+xtaUalpHhEKFT0a5dwJq8FJhGLUIm+q
 a9KTgCJYF6AD9syHHnMtrGy0D6nQGNm/dcwGG45qM8uyPo5mnTrQ/PbOj4wQQ0nTTREN
 KC8GLobcmcl0cepa1DylsfGr7wC/xgBy6n051Omr0YcCu3ph8kxh/S0EajabkOUnfBSM
 pEmnWC3f9Vu2k9arOwDAQZVs0CGi94vQdEvVbVAlCCfueAaMWwElwvXM7MB320GKritt
 Txsw==
X-Gm-Message-State: AOJu0YzaM8uDdXUkaesMTRsxGGN/dnElW1vQABYKQj9dOrqHQqnXbcta
 h/6SibmrTGF9YKfTbamC/yiklVLOxXLrjzDZcLaOU+WEmVsSs8+y4m0w/TB8Fze4BporylO7kt9
 BOD9T
X-Gm-Gg: AZuq6aLjofraeyL6N03CRan4Gi4dTnu9da7bVFp8oQbtYBJ82fTUfNJ3U43AwXQcyta
 doo6j97f2TUAm52p+O5G3s7lWZTlB+Q136U6kq/v3oLHxyOraxXS/+vHSLbi/kPJ10LAnEtuIBk
 AEC7O1kODhAXLwKb9Zi4uhv2fMw+9WIsWLvX5IgOz0Ul6L7Ir6SFsDopUpefIH9DmZw69htHuPA
 szgF9Yp6piveXGYwoxo4WEgkxEaP7ly51ZwqWFIjERD+Vscgy0TauqyavY60eUvEnku9IWW9ZBB
 QbOXEgRvGJo3vjPiebqX0rNNImz59DEMQfKu5jtK9brtaW59NA5g8m51aVQLIo+fk56Jy4K1+mS
 I4sQJOwvF9eAw5z0ifh47fcNWG/rs6rju2i4zxCJtHP/Pf9bHM45QgrKE+GqzRPrR46X57SKIO+
 zi6eZeoeG/5iGgNaaM91jxkKVShqHg5KrpHt3iub2agZEf1A04Hw==
X-Received: by 2002:a05:600c:45cb:b0:477:8985:4036 with SMTP id
 5b1f17b1804b1-483201dd216mr4052725e9.1.1770314285491; 
 Thu, 05 Feb 2026 09:58:05 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43618057f7csm15465594f8f.23.2026.02.05.09.58.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 09:58:05 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, rbhansali@marvell.com,
 stable@dpdk.org, Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>
Subject: [PATCH v6 4/6] common/cnxk: fix buffer overflow in SA setup
Date: Thu,  5 Feb 2026 09:55:56 -0800
Message-ID: <20260205175750.653353-5-stephen@networkplumber.org>
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

