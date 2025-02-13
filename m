Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D19C021A4
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Feb 2025 22:19:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 648A1406BC;
	Thu, 13 Feb 2025 23:18:46 +0100 (CET)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52]) by mails.dpdk.org (Postfix) with ESMTP id 9DA2740685
 for <dev@dpdk.org>; Thu, 13 Feb 2025 23:18:43 +0100 (CET)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-2fa7465baceso2881770a91.0
 for <dev@dpdk.org>; Thu, 13 Feb 2025 14:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739485123;
 x=1740089923; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BWlABOBDjT+D93lC4xk3UAjMk4KNQQKjBPILflrvYnM=;
 b=mgCvXLTZt2sgwG7/klMhftm00EawyTSd4vAGCLmmHCNHa0Hisz2o0JW3fbLw7BOIds
 HpqyNN8rsLgPbZ6hxZ0a7gBuLMN8vvIIHykWPUqcWloMfHVhCZa7bLTTD0eJWAdPjhho
 wcmhY1Lvx3yvx4l0tKxO67ts4wZj4L8GIKyxnzJ87Ktpe6baPyjZ8Zbea9D4rF9rPqyW
 wp+qf5hLFLqA3MHRKc5ALAc54VM12/5Fvl4VXhvuGxHNcHqPFnZcbdupT9oK1JBWx/ig
 o93H5MYr3nWyIroP4pQqwFfVKbpGwVv5e3uQEGkvO93V2mUDCnYR/6i1n+AU/Vtu3tNg
 RlyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739485123; x=1740089923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BWlABOBDjT+D93lC4xk3UAjMk4KNQQKjBPILflrvYnM=;
 b=For93NBIUBPLv+pE2mZ5CMKl3lm/Iukl/YGFk/ohLH3gm8Mj+3ZOOK83m3aYzSDiFG
 g0j/mcaB25EyA6h0XCyWD5wsAxyN/3iHT6FInU872uW8SRI1reeoaN9MWfoo5Urjj27o
 WAT8WD+/PWWKkNt8bvfuxZdlZPEU+PAAuoR2SB29aSLzvlAwBTnrlizM7EZcGbPGVSmj
 mCv4elA4QAgOI/yFEZjzi8IBqKeF/qcc2yB51i1st+9dm3RHW97vmHKoXPUYjKj5ruqA
 fK0Pn79WDF9xIyO/yvm7hiHJ9/J2dlXIS1DBsiX0+J1VfYMD6lDCeBqQKiG5+EE7w9PW
 Rxsg==
X-Gm-Message-State: AOJu0YyDyGjf6fvwp3Sa6KGe+AMTMUHngLHm6DHsBL36sbmJ984ZAacC
 pth9HtpqVLdKn9nNxx+RzBiM6AP62ycjIgfnm0/Ijq5CVcLZTSf3UiuchpOxFHB+rklGqP7TUKY
 g
X-Gm-Gg: ASbGnctuN+1J97fTkZ01RplRv4ioRvNY9o6CGghi89YnY59nCoNTHJnWE95emMvT+8d
 RmafkQsyvdGvOI0QbEcJZhtlUiUVO64/lLw6Q7GfdmJ07mgZa6gqK9CjsyghznRVukHOcYJzZnK
 T3svHiIDzGOmv1TFqRo3S+4FuUOx7nEUOWHA0nJyOHfioL8+8TKH39J+9pz54M+TAZv9zKN7Qh9
 odCoabvoV4cdSXNYnVgJIsKeJ18X1p/ZSApIirr6iLE06D7u4h3MbyT6rFUYO9I5ibXSVT0LrNv
 oZkZGevFObxZfdy2b8q6w0NOc3x+ta7AvbJgLir5gqsHEJt+bhzEo1fvrupK/OOq+jxP
X-Google-Smtp-Source: AGHT+IHWpZ9hvmldZjMe1EFjreCJQ2C2OpQSk9yoqqLwI/+eWpF4aGpjHzWRtJkCZnvXATgiNxzE7w==
X-Received: by 2002:a17:90b:3f05:b0:2ee:b8ac:73b0 with SMTP id
 98e67ed59e1d1-2fc0ded15admr7824105a91.2.1739485122827; 
 Thu, 13 Feb 2025 14:18:42 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fc13ad726bsm1706826a91.28.2025.02.13.14.18.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 14:18:42 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Christian Koue Muf <ckm@napatech.com>,
 Serhii Iliushyk <sil-plv@napatech.com>, Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v6 09/11] net/ntnic: check result of malloc
Date: Thu, 13 Feb 2025 14:16:22 -0800
Message-ID: <20250213221819.1856769-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250213221819.1856769-1-stephen@networkplumber.org>
References: <20241114011129.451243-1-stephen@networkplumber.org>
 <20250213221819.1856769-1-stephen@networkplumber.org>
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

Need to check the result of malloc() before calling memset.
This is only place in this driver that forgot, other code
does check.

Fixes: 0d9bca480e26 ("net/ntnic: add FPGA modules for initialization")
cc: stable@dpdk.org
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/ntnic/nthw/nthw_rac.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ntnic/nthw/nthw_rac.c b/drivers/net/ntnic/nthw/nthw_rac.c
index ca6aba6db2..f275e64da3 100644
--- a/drivers/net/ntnic/nthw/nthw_rac.c
+++ b/drivers/net/ntnic/nthw/nthw_rac.c
@@ -31,7 +31,9 @@
 nthw_rac_t *nthw_rac_new(void)
 {
 	nthw_rac_t *p = malloc(sizeof(nthw_rac_t));
-	memset(p, 0, sizeof(nthw_rac_t));
+
+	if (p)
+		memset(p, 0, sizeof(nthw_rac_t));
 	return p;
 }
 
-- 
2.47.2

