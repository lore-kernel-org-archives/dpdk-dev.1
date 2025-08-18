Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A3F7CA0EE4
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 16:18:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AE1414065F;
	Mon, 18 Aug 2025 18:18:37 +0200 (CEST)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45]) by mails.dpdk.org (Postfix) with ESMTP id 47EBB40664
 for <dev@dpdk.org>; Mon, 18 Aug 2025 18:18:36 +0200 (CEST)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-3b9a342e8ffso3105471f8f.0
 for <dev@dpdk.org>; Mon, 18 Aug 2025 09:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755533916;
 x=1756138716; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IhJvwbCaw4RLyFTd1rsBSAdysENJJO4NX/0bl97dNFs=;
 b=dbfZ0Cb9Znmu5Xzh1Ba5Hp7cjJcxGYNZZuE6MC4Ah/PbhhRnahfQq2enYSP+OnOw0p
 f8yHH79jey0wshc5xfj8eS9Gh+UJbpI4ebCEZXBrscHAWEYk96T3RWymPOTDyC1us1nW
 HQOZcq2If2JvF8MirwwVgTIey2kkEFcY+gR5KWv+mY0dii2qVS2IyBVYKgqLY5CygA8z
 Fj85h7H61iR6A82GNO2SBg8lKa0lCL51u5Z6cCMJd48vkAmse1Bc5RlJGH4QA2T37V/5
 p69i2Eo6PdGOYL3beNFKHWgbUcjDFV0rILFCHFyqL3ssPhYuak0+4N5FdxfdVm5/6iih
 gDSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755533916; x=1756138716;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IhJvwbCaw4RLyFTd1rsBSAdysENJJO4NX/0bl97dNFs=;
 b=Fygiugg61g5WmXE7rwCqVRwpByvMkFjJqLENam+jHdqsuXyGfeWUeFgkverG+/ADK8
 svTMX/xXO2TweQ+SV0fwB+gUcQnsW3Goch4+MGMSstoivmXJD5XoIzbuFFkl30+3u/7H
 2v8lPLwb7blGtOobwFvnB/C5sNA8JUg3KUSPdtaEnFXEc9y6gFGOjggqYF3BNUj/2k0o
 aV4ORxbyPATfn5yYQtdSdpYkiTuL0mH947Bbvik+ZbK0aHAwT1rLKWhl3O4pugKGR8JC
 mmE5rdiwFU4dGDcSHfPs8WQOk2oEkFo8W33os0gdplMC8Ed8l1JfFfIwArxa0dVGWdA8
 RWMQ==
X-Gm-Message-State: AOJu0Yyt6kdJNgB9yH4kgwfi2cZ3E0IfUt9t1xR9eiqvV657ciEajFfs
 kAbkunAYOT8lt0nPKmCJpVhlYlLHes+uJY4xsD8hJ9wtvDi5zFCoJysxa6sT8DRhAcls03P/lZ+
 UTmHP
X-Gm-Gg: ASbGnct4MXE6ZPHRAmnOoU70wwy7KRMM/PyMJawMomnv40WHI0QCeM9TgbDuOZy2keK
 rGoBWa8S1HYZ1u9SR/fCNLI8v20Byfc3r+EWYkCKtWCazJAPdr0UQSOvnho9Sf9NFLuyIRdWioI
 w/waHVemoTGlFTj8lAKJbka7mjiiHMuCXjL8ABcprLjmsuCQS9MlxwkIuYrVfitGqXHrgXuRuOd
 /yVWPCeCPJhwibLQ733210nHhrSIxPLCAgM9+Y+2umCa46fsqQpe0iR6IOBE9pA34cBy4nwKFSP
 w9TVVL9sq/Xe5YlCcISXhXaT2m5GGPQfVicu5QKkA/nwvEDnY1rHMvCyUMPAupa7t5+sniuag8l
 qZNPdRDpx7zq/zdRmF+4e/xqMBjIsYcGS92qLJOyRxMUkjEFlBQ9Xrlx5spbTquAzvD+8esXk
X-Google-Smtp-Source: AGHT+IEc+hUbvPeVLXH0aVdFMurDHP6nkaGb0n5FywoKEFI5J+wyFng4V2w4MWjdm0zZjJ9wIOgBSw==
X-Received: by 2002:a05:6000:2dc1:b0:3a5:8934:4959 with SMTP id
 ffacd0b85a97d-3c074784220mr132844f8f.27.1755533915885; 
 Mon, 18 Aug 2025 09:18:35 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c074879fcbsm147865f8f.9.2025.08.18.09.18.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 09:18:35 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Chengwen Feng <fengchengwen@huawei.com>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Bruce Richardson <bruce.richardson@intel.com>, Ori Kam <orika@nvidia.com>,
 Aman Singh <aman.deep.singh@intel.com>
Subject: [PATCH v4 5/9] app/testpmd: replace comma operator with bracket
Date: Mon, 18 Aug 2025 09:18:10 -0700
Message-ID: <20250818161815.23611-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250818161815.23611-1-stephen@networkplumber.org>
References: <20250312232739.228295-1-stephen@networkplumber.org>
 <20250818161815.23611-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

In flow print replace with temporary variable.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Chengwen Feng <fengchengwen@huawei.com>
Acked-by: Morten Brørup <mb@smartsharesystems.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test-pmd/cmdline_flow.c |  6 ++++--
 app/test-pmd/config.c       | 10 ++++++----
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/app/test-pmd/cmdline_flow.c b/app/test-pmd/cmdline_flow.c
index 83d398f8ee..a54463f718 100644
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
diff --git a/app/test-pmd/config.c b/app/test-pmd/config.c
index 0fda8e99f8..14af69bce5 100644
--- a/app/test-pmd/config.c
+++ b/app/test-pmd/config.c
@@ -1497,7 +1497,7 @@ port_flow_complain(struct rte_flow_error *error)
 		[RTE_FLOW_ERROR_TYPE_ACTION] = "specific action",
 	};
 	const char *errstr;
-	char buf[32];
+	char cause_buf[32] = "";
 	int err = rte_errno;
 
 	if ((unsigned int)error->type >= RTE_DIM(errstrlist) ||
@@ -1505,10 +1505,12 @@ port_flow_complain(struct rte_flow_error *error)
 		errstr = "unknown type";
 	else
 		errstr = errstrlist[error->type];
+
+	if (error->cause)
+		snprintf(cause_buf, sizeof(cause_buf), "cause: %p, ", error->cause);
+
 	fprintf(stderr, "%s(): Caught PMD error type %d (%s): %s%s: %s\n",
-		__func__, error->type, errstr,
-		error->cause ? (snprintf(buf, sizeof(buf), "cause: %p, ",
-					 error->cause), buf) : "",
+		__func__, error->type, errstr, cause_buf,
 		error->message ? error->message : "(no stated reason)",
 		rte_strerror(err));
 
-- 
2.47.2

