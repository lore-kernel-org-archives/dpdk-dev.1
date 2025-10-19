Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FECDCCD184
	for <dpdk-dev@archiver.kernel.org>; Sun, 19 Oct 2025 16:05:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1BA92402AC;
	Sun, 19 Oct 2025 18:05:18 +0200 (CEST)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id 0EF414013F
 for <dev@dpdk.org>; Sun, 19 Oct 2025 18:05:15 +0200 (CEST)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-290aaff555eso33970265ad.2
 for <dev@dpdk.org>; Sun, 19 Oct 2025 09:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760889915;
 x=1761494715; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cAnzgJG+EZ7gYB6it8mNtuvGawNI48qaoHq7coFGb4Q=;
 b=y0mYFwR6YOxwmmcEKydouRY8YfOCtH8Kn0yrus3vt3060JUURM4Vygb4D3ys5E9XAR
 LLK0hmARE3cHwJZ2zAz0GHHVfjIEWzpHdkHFku+XLU8GI0R36N+TVGXwCOmkZ1fTRi65
 SxqWYSBLKZjzQDTfWu9KAlGVJ8+9wgiBGLeuaBbQ9oB/nRBtlB0uLeMyFwXDMgbs1pzp
 7Dneiy+2AS+mGX2JTQsUHrF3IdTk6Gd71Pbii1PJj60HJpLiSuBz5PbuDMYY9NUCpFoy
 JxX78PGsyF4HMzJr59FVMptZj6U13VJKyUJxs3WiW2XKaBPXmo0PVfTzD89CIpOQ/59r
 E7CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760889915; x=1761494715;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cAnzgJG+EZ7gYB6it8mNtuvGawNI48qaoHq7coFGb4Q=;
 b=bk7+zhdZ1lgQQQbtNp+73rj2YMzDiHlenBF3C+cja/opMdZpgnWqLoZL6fq6/8iZkn
 v3lQCMwasIj0O0MzFYLOYD/qP9+ll6XGvO3Z3QB3UkfBqVUn27kEKVEl9AkzQhi29y8Y
 y4AbH/tXOYAqLsHF9Mg/Gf9VyLz8x5+8/1DZt2XEo/meY3Y8o3Kt4BEju6U3azdvKUkb
 mMCOtE6NkhtTUW27dejYDttamX445xHk9eNN35JxKWSC2RUGwyLdtTm4BKuB0AlZVV99
 1rv1BJ87qaucPpsIG6+gBK5Rp0fvtiJ+6MvAIZu+V+qW/Iq+dUedraETUERnZ/uBaeAe
 YrBQ==
X-Gm-Message-State: AOJu0YxRIbWVxgZluy65X5iZx3YjtWkZFAssjzlWhHKzx9vohCqS/3eY
 uVBVjf4tLZWWIoOhgBkkKOmRqNFNXxqtYFm3uJunBlN03MINNUi3b5B+tN0WaFWUCZWPLCL2npw
 irX87vhE=
X-Gm-Gg: ASbGncth6ICjQCPaBzemsHFwzGJ3CP0cj8qxvcnByuN3Mkw3uM6IjEekWu9Tnn5xash
 cBH3arlvMTAOuTOcunacDRLp3jCad1dAdjH6BU4a96PP1KDRJlFlrCZLL6IULI3NeRIQMjlr31l
 UJ7DxRK50C3M0SpWgTqZsxOchZK5ddJQYkZSQd64VLFU/Fn5X721gHxc6Dzd+dU7+EucaYCNz1W
 hN21AUTbueZY91MR7fS9sFKTGDGceZeOchgHx8L+h1Nv2zpAUF9w7SNjTj3fKl5UW3pVzIuxLKA
 GlsPBxPjKjJABjroDgj8HmLf7oCT37Pda5OfyKrE8Y/Ej77FdpzIgglTrKVPwzZsS3TmaQ6CbtG
 haqaF9JYwMyp7MaKPiM4pC0SBtlLV7F0e65NUjL6h0v2Tj2AEMbID1YoO2Paacs202GSjHHB4VX
 j1hDCzkQKv1zWitWjXw/L09o4NQOJhpVYC/PLTlKQorjVhrCXskw==
X-Google-Smtp-Source: AGHT+IEyMF9aUsf6Tc+kr7oi2MiTcclfkBcxtPevoyPW/2VVJpjxx1PUvgasXiQqC8bkFBlOcTTubg==
X-Received: by 2002:a17:902:db11:b0:240:48f4:40f7 with SMTP id
 d9443c01a7336-290cba4efc9mr148677735ad.39.1760889914902; 
 Sun, 19 Oct 2025 09:05:14 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33ba9270049sm4966856a91.0.2025.10.19.09.05.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Oct 2025 09:05:14 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: david.marchand@redhat.com, Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH] devtools: fix awk regular expression
Date: Sun, 19 Oct 2025 09:05:11 -0700
Message-ID: <20251019160511.18173-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
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

The latest version of awk (in Debian testing) will give a warning
about invalid regular expression error.

	awk: line 6: regular expression compile failed (syntax error ^* or ^+)
	^+++ b/

Fix by using additional backslash escape.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 devtools/checkpatches.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/devtools/checkpatches.sh b/devtools/checkpatches.sh
index 9fb8fd0a07..646d5d1513 100755
--- a/devtools/checkpatches.sh
+++ b/devtools/checkpatches.sh
@@ -320,10 +320,10 @@ check_experimental_tags() { # <patch>
 		current_file = "";
 		ret = 0;
 	}
-	/^+++ b\// {
+	/^\+++ b\// {
 		current_file = $2;
 	}
-	/^+.*__rte_experimental/ {
+	/^\+.*__rte_experimental/ {
 		if (current_file ~ ".c$" ) {
 			print "Please only put __rte_experimental tags in " \
 				"headers ("current_file")";
@@ -350,10 +350,10 @@ check_internal_tags() { # <patch>
 		current_file = "";
 		ret = 0;
 	}
-	/^+++ b\// {
+	/^\+++ b\// {
 		current_file = $2;
 	}
-	/^+.*__rte_internal/ {
+	/^\+.*__rte_internal/ {
 		if (current_file ~ ".c$" ) {
 			print "Please only put __rte_internal tags in " \
 				"headers ("current_file")";
-- 
2.51.0

