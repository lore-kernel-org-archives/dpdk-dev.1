Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C1B0FEE4F2
	for <dpdk-dev@archiver.kernel.org>; Sat, 28 Feb 2026 17:56:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 69C7340DD2;
	Sat, 28 Feb 2026 18:56:15 +0100 (CET)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172]) by mails.dpdk.org (Postfix) with ESMTP id 29B1B40DCA
 for <dev@dpdk.org>; Sat, 28 Feb 2026 18:56:08 +0100 (CET)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-2bdecd00ebdso3530416eec.0
 for <dev@dpdk.org>; Sat, 28 Feb 2026 09:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772301367;
 x=1772906167; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XpAImIqdiKI3ORDfVNUbCgEJX96HHNq/Se4eWcZHQmo=;
 b=mUEz5m14I8amkZtkYVNdctbD7dK/28K1+BrxOW9hiv+U01RSnOXLHRpkpXHgByV3j6
 NJm6RWq/UL2zjrEP75ruJmGTbNzV8wFofPUM/AOWHb/2ELmdtTRQQPB9H2fs16BwWZvo
 /ujJpJpYWQZSJ2qvHdVxbSQwAQ5ikjRBSeLUsETRHaBJqbNtZnji4gPpzSBpvBvqTu9L
 TL4H7SZ+ol9GXaqm/1kIEM2jG/gLxwAjsF/o9NeRuV+9Kn3c9OyJ2GczUgPbCuoG9n9i
 R0aM4FpM8nrvTfFb9InrNFeAYhs0/upTdw8g7V1qgsX/3wC3Fj6aBC88zUZjHk1JQxer
 UgsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772301367; x=1772906167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XpAImIqdiKI3ORDfVNUbCgEJX96HHNq/Se4eWcZHQmo=;
 b=qUHifYR2iHImKzp5itcm63AST4V3NzalHfUu+ZLhij3r042mGXLKjMNPYh77h6oETy
 /vmOBS93wq/URlGJigTI1HhhZECjJ7cX1g8WIYrQ9JKqIiVrDisCY3G7ILapdeLxH+V6
 KNQ7YlF4Nk49riavWe5bSWEbldhU9F5JiKIKFOrPrgfh+YXQyMVrC2zNT3VwrDV+85c4
 PxwtsOIJtxxPQnkyNH+/ZDqnty/IpnOiQA79dWCD3lCQUnUlF4vzVw8WXsDJjQCEK+Ai
 57eIoqxmFU7+Om8Ms0OoiQNpbXFklDo6mB93drKoedKQabhIRet07aTGBYbpKCZ6T+BC
 HkZg==
X-Gm-Message-State: AOJu0YwTmCf9xrXrmXKiSDcVZ96pyvSYIsj1O7UvH95OWhS4wQqqxq+v
 10Cs5D7VtLtBEMu3Dhl+x0s/ORe/4raQ69vP3SvWT9v96MOJaB+EJS5HeK+07qqWS/D75FG/whK
 8mEO9
X-Gm-Gg: ATEYQzx8FNKcDlaux9MHchrHLdO4SYRrC5LlaBnnaCgg9tDrvuguNmAhAiK1DpJCzrL
 9h7bmin0VlLc0Flh2OpS9bt8PEWQnwbie7A3OOQby/Mi059iute4VXssOmF/B205RaXVC3oD9y2
 5iUE4xfHvYL9avQocOAY3kARwfzmoJIDLDqGPRKkmDe8ZFijBp95m969FkGwUjPWBK/HZJs5NR8
 u02+AqR53Gna2lqIPeQXCfF6a2DOpORPrOjuzbfhcExS/IeDhv0v9cUUB0lid4ylmhfvhWRb+9V
 0ugZMMPOHDSVx20opvYe0ZAUlvAbj+aKcuDvUP5j8XFsEt2t2dHGWGMqoA/H6T44vD+b30iFQGt
 ltSR75jomJ/r09KiQhAsIigL87lO7Xbw/KRc8Es3Llrin9ZzA6/agFV+7r6NG/my6crLJX0aUh2
 UGLFypr0jAN4LmBrxbOp8Tunz9NeKMzhDI5EME0lutKm3j7MrL42ZVXXdTnyIzNw==
X-Received: by 2002:a05:7301:1015:b0:2b7:f522:992f with SMTP id
 5a478bee46e88-2bde1c89a8bmr3006135eec.10.1772301367117; 
 Sat, 28 Feb 2026 09:56:07 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2bdfb3f898asm824584eec.29.2026.02.28.09.56.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Feb 2026 09:56:06 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH v3 4/5] pcapng: handle packets copied before file open
Date: Sat, 28 Feb 2026 09:35:03 -0800
Message-ID: <20260228175601.585102-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228175601.585102-1-stephen@networkplumber.org>
References: <20260220184255.306368-1-stephen@networkplumber.org>
 <20260228175601.585102-1-stephen@networkplumber.org>
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

Either through misuse of the API, or races it might happen
that rte_pcapng_copy() is called before rte_pcapng_fdopen().

Simplest solution to handle this is to modify the logic for
TSC to nanosecond epoch conversion to handle the case where
the difference is negative.

Bugzilla ID: 1291
Fixes: 166591931b72 ("pcapng: modify timestamp calculation")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/pcapng/rte_pcapng.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c
index b93af418aa..b5d1026891 100644
--- a/lib/pcapng/rte_pcapng.c
+++ b/lib/pcapng/rte_pcapng.c
@@ -157,11 +157,15 @@ tsc_to_ns_epoch(const struct tsc_clock *clk, uint64_t tsc)
 {
 	uint64_t delta, ns;
 
+	if (unlikely(tsc < clk->tsc_base)) {
+		delta = clk->tsc_base - tsc;
+		ns = (delta >> clk->shift) * NSEC_PER_SEC;
+		return clk->ns_base - rte_reciprocal_divide_u64(ns, &clk->tsc_hz_inv);
+	}
+
 	delta = tsc - clk->tsc_base;
 	ns = (delta >> clk->shift) * NSEC_PER_SEC;
-	ns = rte_reciprocal_divide_u64(ns, &clk->tsc_hz_inv);
-
-	return clk->ns_base + ns;
+	return clk->ns_base + rte_reciprocal_divide_u64(ns, &clk->tsc_hz_inv);
 }
 
 /* length of option including padding */
-- 
2.51.0

