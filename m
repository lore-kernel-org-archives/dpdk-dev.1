Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C59C5DF7D
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 19:33:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A92B640E1B;
	Fri, 21 Aug 2026 21:31:42 +0200 (CEST)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by mails.dpdk.org (Postfix) with ESMTP id C0C0C40E38
 for <dev@dpdk.org>; Fri, 21 Aug 2026 21:31:37 +0200 (CEST)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-cc16c6dcae2so1428054a12.2
 for <dev@dpdk.org>; Fri, 21 Aug 2026 12:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787340697;
 x=1787945497; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hwZxBYUQZNZPJi9vhB3XcJuz0b/bArSiGY+bg8COM24=;
 b=BUcpsuoUiZZz+k+YvLYygCnm44klBUwy640rSg88lRaQugdmjLRE+uOmmsxptPWVte
 P5VJp77j02n6bz9xnZMoj6sf8wNojJboyjDIze5eURvOvQaCjWf0mj8KwH04BDdxirFj
 psfBAGZYoZ938vsKTrdqDqVVOVtafxSKAzbKgga86WiiqIE13J8mE/nMnQT1PStwnEjH
 Jb9XJ0r3cUhFCh+ekegP1EoKKM2IrBTwcGx9HJKs5qvygHhMHG9MaUYu0bsK7haoE7H+
 syG/1xtxNA4QfzlaWHRw7K7oNgbTGhFYVebrfEFbg3s3/4axZRPIXEhIodCPuDtI35LE
 yn/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787340697; x=1787945497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hwZxBYUQZNZPJi9vhB3XcJuz0b/bArSiGY+bg8COM24=;
 b=U5LyRcl2VPETuIqfyYCbI7b7GWmIe5sszs7ukFu3b9hpl0oLfND5k5jLtA/DEczUWi
 r+l7ZDHgC6gmYGjmVH17NORvBeZ7npeHPG5Le250N7dBJQLpEOArz9Db154ikB8JDwX/
 x+Urt54pBGeJzUMM4ZCVwxTEEjbjN4ZtJx/LfN4CercIcwLQfLs9Lwn9i5YadFP3by2z
 1FJdxTXisOwYPotzSrK5MV80toGxdeyVJD84Ir8Z6AzOVnTJYIMizB9/IrnHiY6/2yn2
 jAGJ2izRD1QhXA+ZPoBDT/5Xh7HPEvHLEcudZNg+VN/FT6FVIasbNK+JB2I9y42TNbym
 4jyw==
X-Gm-Message-State: AFuF++ngMJwkngWdgzZlejP/VBfwZqqWCn6tL99koQTgEHEIhsDVrKCr
 yePC/MU6ulsp0M/N16Y8o80b3/DUu5CGtp6PeAH7corcZHIOZ97/u/KiUk9DQAXg8n/CkCuwyAI
 I317RtqU=
X-Gm-Gg: AR+sD13pSHHOGnsQ4pCAxD1RXfFOjMH7b6YLHCb2cIjTsCsUupHmu935hwBqnerar3l
 2SkWEblcS059C0ngSL5B3S125VljlsRaG3nj4xj0ta2QxWuYJ+Kg6QpPP6osh36RtTTrbURf2S9
 zf7se40Xgi2Jhj0lKNGY1DHYUFZgKqwA0019LjvKGzlur3o8VHQiPLfSCPXQP9yPH+xB78GHWcJ
 wFZA2vyHZJUyRjYJLUR78UIDODm73W5VVwRueW+evvnxvYgk4f+HMcjPLYojJNQCEWMD8uTfVEI
 wvYtOsaATXg+a3VQ5lfPxhZ2q5a7zLhHg1xEOHCPVir5tEMErbdaP5BZlprJpPCk1plpADt3kJL
 TWhhAf12t44kph/mAwGHQ2ZRMUi3ojtl/tWPM/rdicK4OzG/qZjpekDnCvxK+7ykPUra57/D24L
 2cU3SH5qYGoDIQOmcFY8Mw8HpChqKah2TKYbHVWpUbvq+8dfNPsQxY8ZLe4+V4pvs7SXss3Tg0T
 fHM3+q71TH3OW4uS/07zBu+Cow=
X-Received: by 2002:a05:6a20:c70a:b0:3c3:704d:57c4 with SMTP id
 adf61e73a8af0-3cd3008be8amr18697820637.12.1787340696968; 
 Fri, 21 Aug 2026 12:31:36 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc16c6dd2f4sm1860304a12.17.2026.08.21.12.31.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 12:31:36 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v2 62/68] hash: replace use of rte_memcpy
Date: Fri, 21 Aug 2026 12:24:57 -0700
Message-ID: <20260821192646.146382-63-stephen@networkplumber.org>
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

Don't need to use rte_memcpy to copy small key value here.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/hash/rte_thash.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/hash/rte_thash.c b/lib/hash/rte_thash.c
index fcd41248b9..931bb55f0e 100644
--- a/lib/hash/rte_thash.c
+++ b/lib/hash/rte_thash.c
@@ -3,13 +3,13 @@
  */
 
 #include <stdalign.h>
+#include <string.h>
 #include <sys/queue.h>
 
 #include <eal_export.h>
 #include <rte_thash.h>
 #include <rte_tailq.h>
 #include <rte_random.h>
-#include <rte_memcpy.h>
 #include <rte_errno.h>
 #include <rte_eal_memconfig.h>
 #include <rte_log.h>
@@ -263,7 +263,7 @@ rte_thash_init_ctx(const char *name, uint32_t key_len, uint32_t reta_sz,
 	ctx->flags = flags;
 
 	if (key)
-		rte_memcpy(ctx->hash_key, key, key_len);
+		memcpy(ctx->hash_key, key, key_len);
 	else {
 		for (i = 0; i < key_len; i++)
 			ctx->hash_key[i] = rte_rand();
-- 
2.53.0

