Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DC6C28B2E
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Mar 2025 23:28:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2A08D40E4B;
	Thu, 13 Mar 2025 00:27:59 +0100 (CET)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mails.dpdk.org (Postfix) with ESMTP id 2713840E3A
 for <dev@dpdk.org>; Thu, 13 Mar 2025 00:27:56 +0100 (CET)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2255003f4c6so7164885ad.0
 for <dev@dpdk.org>; Wed, 12 Mar 2025 16:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1741822075;
 x=1742426875; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VnYgmpzBIku50kxJCy34TSSYRReJkc1+viPJACdNxdI=;
 b=fBaSzsWznK9rGZ8LRZnI1NAM593iIg3IkNTlovr7ZHhg6VvhyNPd4b/1AwGqZpQv3t
 Ui+PtK2xnfxkmtTknJEqs6eITlEENT/h/zCRGOViGA5ftUG9PAkxqmV6JAxbBPr/Dbke
 a/qR418Id+JsKpgs5VplM/XrN400+b2iwAlUdCs5u/b2K66shlW10Pgs2/Wp3FFS0b/G
 B4K76oFFYCviyPrOOe+cgvU9mk8sLRH9PLyB+4rPUIAvKQOwF0m0Y2ynqpwz0p1ilTGw
 LWqOmqweJWOUl60HWWQbPU6Pvv+Dnw+jsba3zvBXKquOQilUjUK314hVU6nkTxG6PZf6
 MCLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741822075; x=1742426875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VnYgmpzBIku50kxJCy34TSSYRReJkc1+viPJACdNxdI=;
 b=wEqrpX8iHz5YQQRwjOluNeqs2SdZQcZHfcJWornYBFZsK82QfcUcU1VGFsZGAD9Igu
 mkiIxGC4Fc81lYAFss/+43DMQ9FD/mmQNxceFim3mlCBtM2PesM3RPXuQspHSuMiAkhq
 02PZU0ay4D6M6G/9QkWXEdDeY+ZutnccwcYNjlVc/THSnV5YDuZ1xkjAguI3B0xt9qNy
 w1adaLIWcl65ZKkiZFl4zWI+4rCmlUgAymKyCHo/hXG5N471gFf26QOJJuJ01ya7LtKf
 K8ZXt/7Xj1fp2fHrWWygZ02xo9vqLHVDxMhvJId5xc93SXoa2GTGaph/aH/LPR5L0t5q
 gn8g==
X-Gm-Message-State: AOJu0YxJI9/WC6DeMUuqlpUC0tuJ/atdnNNReFPZFyPAkKouwm7D97aZ
 NN6WbA7kBc9wbS/X8oU5fRDJIWBTRd/ufMz6lqdwFrg+aC8ZAjY592BZNYI4wwuYqt/CGCIeDGi
 9
X-Gm-Gg: ASbGncsrdvlC2vU+92JwnhPeU594uY20H51maPyyvajqv7RcHxikJcjQutIsSGYtp3D
 db3pDh0diMK2IkuqkHXtPK5kpOF9kijyB2wJCAK7Nqyr989u+G3LdKvd07Zk9jpkHWjtfrTxEol
 +7EXkwUkRA0lWiXphpczFg9joSHyLg+SZGcJ7L0612q7+1fE/iIT+yLTuorIqx14Nfd5fSy41o2
 i16/gYV2g5V7fiomKBHZnGFTWOril5kJt5tVAi1ktbwe/hoqVucoTPs3Fyr827srzy007RlhtlJ
 kwHHb6WMAeViRdvD8pjS46lgrQv834JwZONkR2GZggdabCCym0byep6lJFNIkQ5NSh1c2OV/waX
 BhlW3b8BnUtBmNKtHoALepA==
X-Google-Smtp-Source: AGHT+IGhjGSOUDrPECkhNX+L9f2tHyAlmR4Rg5qDkK/0mFPjtDnO0oI1AMRDKiyNQKgAA/JEpTI2gA==
X-Received: by 2002:a05:6a21:497:b0:1f5:8179:4f42 with SMTP id
 adf61e73a8af0-1f58caf4c7fmr15603805637.6.1741822075377; 
 Wed, 12 Mar 2025 16:27:55 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56ea95651sm111917a12.73.2025.03.12.16.27.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 16:27:55 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, Ori Kam <orika@nvidia.com>,
 Aman Singh <aman.deep.singh@intel.com>
Subject: [RFC 7/7] app/testpmd: replace comma operator with bracket
Date: Wed, 12 Mar 2025 16:27:04 -0700
Message-ID: <20250312232739.228295-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250312232739.228295-1-stephen@networkplumber.org>
References: <20250312232739.228295-1-stephen@networkplumber.org>
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

Use while with brackets in favor of comma operator.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test-pmd/cmdline_flow.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/app/test-pmd/cmdline_flow.c b/app/test-pmd/cmdline_flow.c
index ad646444f0..26807b0465 100644
--- a/app/test-pmd/cmdline_flow.c
+++ b/app/test-pmd/cmdline_flow.c
@@ -8333,8 +8333,10 @@ parse_prefix(struct context *ctx, const struct token *token,
 		if (!ctx->object)
 			return len;
 		extra -= u;
-		while (u--)
-			(v <<= 1, v |= 1);
+		while (u--) {
+			v <<= 1;
+			v |= 1;
+		}
 		v <<= extra;
 		if (!arg_entry_bf_fill(ctx->object, v, arg) ||
 		    !arg_entry_bf_fill(ctx->objmask, -1, arg))
-- 
2.47.2

