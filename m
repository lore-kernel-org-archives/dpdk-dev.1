Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33311C5DF8C
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 19:31:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0000040DDD;
	Fri, 21 Aug 2026 21:30:18 +0200 (CEST)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by mails.dpdk.org (Postfix) with ESMTP id C9A8C40E39
 for <dev@dpdk.org>; Fri, 21 Aug 2026 21:30:17 +0200 (CEST)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-cc16c6dcae2so1426855a12.2
 for <dev@dpdk.org>; Fri, 21 Aug 2026 12:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787340617;
 x=1787945417; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SrneBVNvtGWnMc4B2t8jukY1Zmfrp5JyVcjD9lSeh0E=;
 b=m5yf6G1Vi4eL1CcXyaqs9tSZtVsaxxwveYN8iTm833L7eM8dsUCBqVQn9o/K9J+n3K
 8O8UWPRleH4wzhhakb46l6C67GXU+Fc6+WKVZBwHzznSFdrf0m7IZ8gjYz3NzQxj5TKI
 +T/Ppr2m2ZHiO+Tnur/+6jC/HQvU8B/KQVP2BVY3LCgrDYwuwIre6MLGDtFMRZxR12OM
 w5rypihr8Xh/XhWp+wgMJfFD7QJXwWR4BbR1r7WYNKWJ3Zndzj8HY7FlokKRph3Dltm7
 ef3/cl4j7PfGVc2QJ13k1XeV6tTQ95pYsP9jn9kTt2WXK95RPtOgnQ2Ky5JYj4HX2LlN
 YviA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787340617; x=1787945417;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SrneBVNvtGWnMc4B2t8jukY1Zmfrp5JyVcjD9lSeh0E=;
 b=sXdgivq98VEku0PniB/oknhKhZGrxBPvcg/+gjVBByht0OxC7gj79NNchB3Z8F0k3t
 krEtxlB8M1HCW9dA8IXzf87mQivxVqqK9emWc4/gI8pMEYSEHTWx3XGioJ5XLvHaxLcw
 v5XCfoPvqg4AZRYQAPQFn1/TpD5ulJsFZlw9BGBC3LDiJpGcU8GQbHtAFo+ZAMtk0K8u
 euY/jID3xNXbpbM8fNLD0xk4io/XexiYSEQXhStAA31UWXmq3ES4rdf/yCrluCwJFbS0
 Ri4ipMz+wuAuORf4JPiWJZEfdwY+tPWKXMa8FPCpoSwmrCAl5fpEskSpdMLjBXvQgkgu
 p74g==
X-Gm-Message-State: AFuF++lHRpqEiKgt70/8pZLHn3xd+yGouGKB+7PVnLlCFiDsJJJBHzgu
 xl3Q+sQHCrY40CVkTez8wj3rQF8T8v17DfcwbJFezZC/cDq1OB7b01A2MWUYf9jcelF29LuHFNB
 2VcwZZwE=
X-Gm-Gg: AR+sD13RuMirgjDKqLSTszaDI/Ldmhc/0a+W2Ad36/e14Dsgk0pirL1Ry//IXSivBA7
 NFmyNZuGWsjzMthCAVtNoOIPQ0rUVG3fV99DvyfahTt5aFO4DcdAhqXmq9ob+582PSHLV2JdkBl
 ZORPCahFLm7IcnVw6KVsYvWQWTROfQZUP88F1QjC/m/J58z69IeNeWQm6TXo21yOrluDVOTnCte
 yMr0EjFa9jtg9bFoNYkvT13WftCHr32g8/HAp4SP9jCc0KdYsMcE+WKshD7DCYVXqhwF8WufKr/
 a/UjrRRyErV2P9DOZNx65eIszqsJMiWScTVN4KhC6GcsjhyW59BUKbhZxnteA0vrEP4y5tmXUKI
 J9LqUYLW7U8AZ2iIc5Xd0Fpw4yfeta8klnzdpu3FgDOe0qoSex2+mIcNFMujbtCusEcjI+mJqLM
 5AOi/Hgr6Dx7QDLZjjxygB3pF3WmNQHE8KP3rxd8d8B73sLbnYxfAo7nNE59BmxhA6KhLYC83DI
 l4tLQ8+NUPOTw4QNJx033xV+2AabkuMSMCOvA==
X-Received: by 2002:a05:6a20:a10a:b0:3c3:8d86:9856 with SMTP id
 adf61e73a8af0-3cd3013d226mr13455427637.14.1787340616984; 
 Fri, 21 Aug 2026 12:30:16 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc16c6dd2f4sm1860304a12.17.2026.08.21.12.30.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 12:30:16 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Liron Himi <lironh@marvell.com>
Subject: [PATCH v2 39/68] net/mvpp2: replace use of rte_memcpy
Date: Fri, 21 Aug 2026 12:24:34 -0700
Message-ID: <20260821192646.146382-40-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821192646.146382-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
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

Don't need rte_memcpy for fixed size value.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/mvpp2/mrvl_tm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/mvpp2/mrvl_tm.c b/drivers/net/mvpp2/mrvl_tm.c
index c5046490ae..3fb343506c 100644
--- a/drivers/net/mvpp2/mrvl_tm.c
+++ b/drivers/net/mvpp2/mrvl_tm.c
@@ -437,7 +437,7 @@ mrvl_shaper_profile_add(struct rte_eth_dev *dev, uint32_t shaper_profile_id,
 					 NULL, NULL);
 
 	profile->id = shaper_profile_id;
-	rte_memcpy(&profile->params, params, sizeof(profile->params));
+	memcpy(&profile->params, params, sizeof(profile->params));
 
 	LIST_INSERT_HEAD(&priv->shaper_profiles, profile, next);
 
-- 
2.53.0

