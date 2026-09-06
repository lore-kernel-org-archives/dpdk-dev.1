Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD14C79FA0
	for <dpdk-dev@archiver.kernel.org>; Sun,  6 Sep 2026 23:27:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B48F40613;
	Mon,  7 Sep 2026 01:27:30 +0200 (CEST)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by mails.dpdk.org (Postfix) with ESMTP id 2F35D40609
 for <dev@dpdk.org>; Mon,  7 Sep 2026 01:27:29 +0200 (CEST)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-cbee846deecso3680255a12.1
 for <dev@dpdk.org>; Sun, 06 Sep 2026 16:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788737248;
 x=1789342048; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2iINhAakEIP+fWyn4wgUTajvJWAlnSt/3p/P+FHxN6E=;
 b=XOgwdv8OpoWpQcaP7KCf5ckEZcSm3UrR6ifOj4w/9wsCyr/uhDGxJOlE8QZbXyOgpX
 7QBzL3xa6fGd3d1Mi/TqufBFRxuuM1Q6Xm4p9Qn9oyoJnmhl07isX2zOmslP15u/+x8x
 pKC7hU5kwQwMcXQTfPpA00MbQS5pS+5n4K4yF8kF9nPqPldjePJbD1uuIXKDCK0yb/tC
 gHtdQNvslLv/PaO/w9xwm2cbh8WE6GXbgnnXeNxspa7gkD2DHCIh91D8OLC5rmk59xR/
 1uhJqUG2fECZ5zov6epi/Ap03VEtmUkk5r1Vwur3CSM+JYKFD3PNgADcQOeCKVQwqDo7
 gqTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788737248; x=1789342048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2iINhAakEIP+fWyn4wgUTajvJWAlnSt/3p/P+FHxN6E=;
 b=VARzeXIyJHimypJ2NRgLbMU5m5l2XLuxtySI/NQ5JHvCiUVhXF7oDhgNbExkW2Jx7H
 RM04Xc9t+mIb0f3fyfmkO7xXmc9DENePzE8alBBXjdRE5eMZCHVcjEBVbeViFwu/5J6y
 sE1eeCAN9y5aUNcoM/tMqons4uAS52Crxx+ehPx+Z3RpQf318ZdG7ORghjwi8e0AVGTC
 GwYG7ujPigOV3c3zUaVr2Odxwc2cXZ071Qmgvbdu8dyRNAWRwhc5nKI5a4CVmg7jnxAA
 fzz5oSGsgrJ/p8KbZbfm52xaOqNh9qsA9mfgKQyP0Hp8BKewa7KrU+pya02C+kcBFDXn
 wYQA==
X-Gm-Message-State: AFuF++mS0yj0aSy3nDn2CRSR0OAolSuaxRagGdyaVbqmTwwoU7tkxzWh
 a7IfwTcTVubhWEW0q/vOyy2u348YPcCQP0sdhlV2/WeZqVjFtKiLm6Bckvyq8bw6mzqZKpLUak0
 2bj0Z
X-Gm-Gg: AYBFou0xYzZd9EAUmoVyW5gIyvOptLWFdA05J9G2d6FHTKlCHCtjHzWGLEmtGlrygtS
 msiROmRLE/ky7ncXDVpiKEu20ueYt1XJBXkJ7NyfcEPvDsQPfKkdxOpK+YytBcEskjuYZxNHQ0z
 +b5iSDKho3XNFWKGArlbx41Od26frkBWq5XMTFS0rJy0/2Is4H/AD3rfZVxnjwvozL3O4mifGG2
 L7fVI+ipEhWJZ11JBvW0kMYpgqwl4BTAK54lv2CwqgqE1H0YN/JEGuFnslgslizKXFFcC3py2Ab
 ZYbuCMVi3aqvEDFv2yaGgoWAQeX5wc8XM3yeexSGsqBeBOiFk5IIiR2pwCcNO/QqmfSGDGoYf7v
 9uGgb9hwuew15m4vQixf3V8Q9sTPhI3SkJqvExmnHr7HO4nTEL3qzYLxGJdXdOX6JjU4cLoHNSF
 pDAEOuzU6/Lopc/I+XIDw6uxpWSPuwtwaOueOxOro8dZOYzLPY6dieILf4QvkFNfln/KreTNjLe
 sy/8KFCm9aaMvlKRgBN5/nrLec=
X-Received: by 2002:a17:90b:544b:b0:38a:c3f:3b87 with SMTP id
 98e67ed59e1d1-39b261e3b72mr29443705a91.12.1788737248122; 
 Sun, 06 Sep 2026 16:27:28 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b3312f9a8sm14491741a91.2.2026.09.06.16.27.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 16:27:27 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Sunil Kumar Kori <skori@marvell.com>,
 Rakesh Kudurumalla <rkudurumalla@marvell.com>
Subject: [PATCH 01/13] graph: do not call printf in signal
Date: Sun,  6 Sep 2026 16:24:36 -0700
Message-ID: <20260906232716.496546-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260906232716.496546-1-stephen@networkplumber.org>
References: <20260906232716.496546-1-stephen@networkplumber.org>
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

Printf is not signal safe and calling it in a signal handler
get flagged as an error by GCC analyzer.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/graph/main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/app/graph/main.c b/app/graph/main.c
index 56294f2693..d36d60bf94 100644
--- a/app/graph/main.c
+++ b/app/graph/main.c
@@ -49,10 +49,8 @@ static struct app_params {
 static void
 signal_handler(int signum)
 {
-	if (signum == SIGINT || signum == SIGTERM) {
-		printf("\n\nSignal %d received, preparing to exit...\n", signum);
+	if (signum == SIGINT || signum == SIGTERM)
 		force_quit = true;
-	}
 }
 
 static int
-- 
2.53.0

