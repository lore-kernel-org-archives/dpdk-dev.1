Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DBFCA1015
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Sep 2025 14:18:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D48C54275D;
	Thu,  4 Sep 2025 16:18:58 +0200 (CEST)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49]) by mails.dpdk.org (Postfix) with ESMTP id 6763C415D7
 for <dev@dpdk.org>; Thu,  4 Sep 2025 16:18:57 +0200 (CEST)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-45cb5492350so7496485e9.1
 for <dev@dpdk.org>; Thu, 04 Sep 2025 07:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756995537; x=1757600337; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gw2VWbTkG93PrWAWcvt6W1RuLPX+ZQ33W5nt4AaH7mY=;
 b=YFg/q6XswzA7KF+aViI1BafE319bFMhgi8aHsoDDlTJEhnCxDgWID6utij43TIG/Ak
 0CadqTBLSrcvoA6Aom9vzD7hoB025ADpfogqbNVT/oixflkJy/VFnG7wcwPqQTK6lIoW
 IpOO7jNU0fVJqNWugbwMS/f8aLiP5U9vs3fS8aDmCARZHa88h6/WF0l0le/CIfL4Nows
 Jlos6z9SLaHyLjAGqhE7LUxxOlOTEjQXvJxLQVTrs+FrBRNqpWdCHP5k38EZM0myDI2M
 syVhs+IelyIdk3Sk4yHVt0nRjs6Pq96jcYzH+wfYsKOY1ItJxn3fJ1JEcfvzXGYubTJ2
 //wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756995537; x=1757600337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gw2VWbTkG93PrWAWcvt6W1RuLPX+ZQ33W5nt4AaH7mY=;
 b=SpFrNkYxJiNlgtsk8a3zYYlmuqd5mNgPB8kEnE7SntNKC1AIbXD0km4DasyasDSsfS
 8WGzY1i+qsYY8MpHWRHCCE6LJJunq7tU4ZJ5kayBP8rGs2bZ5rkdiu6eqkpqg6uPJU4F
 WY3iPUuj8n2l2ABwI5bezmx2BjvJNkI7G/HL4CjjBR7a4vEDwMUIYEFuX2VJ4NbloJXr
 OTpB7oizHCX9WTTkyGWJAKv7PtAIATPP0hsMQidTEOyAiqz+wJIdxn4P3BQlyvT9HxNw
 nREImb1okdzUpUcEfb6qi2Wm+D5kQ4w/b1NrVFD6DQ4yuiRBL8PqcsV7OFmu9bJCn1Lg
 o2Rw==
X-Gm-Message-State: AOJu0YwE5G/cBe4XSjNdaIOlbjFFhwzn6/r4HuXTDmPuu1SIioZl9uAK
 70AxAbrsm9aw2XFzLRSuXxXApFo+mNr1zMmUYMSNyrlIO/TmT1yLdswjX1Ue/w==
X-Gm-Gg: ASbGnctLBin8dlpYuKNxnjO8YvVRX7CBP7fAS5TqjiAhxn9bps37KTdYqymDxRdiC5z
 4E6GjhMDm3Gf/7xXqPa9k4QDQB+k8MnNtIB67Q6mHLfYSB/NKmvnpM2cRbkJFpwDqX3WFtjVP5l
 HG0U8rDbzICxVeUNyBBrXO7leLocscNrWPainDUNVrN/R9uQV+hoqnElWwJW7XcZ6wt9RJjZ8wv
 UG3sSeizpx/QPDJPrkMc/Q5xE3Dl+/78fPDavCZXypqIlPS29u4Q3iH9xHVJcKT6vAVt+4r3Sdi
 xy26ucnGPAxm6EIzFWIybRbP/gIe2TywkotMGRNldggQSuC2CPeos469ilYAS+w29aZgwHqHOiJ
 qPS0iRTwLyEqZMC8y1nK9iG+AKkgXc/L9AeYBDoU=
X-Google-Smtp-Source: AGHT+IF0DiiM0yHf++ni1XzKCFllI7fHx8zONjnWzvAvl8i6sQVRbwfAxi/Gz3enFXWGP3QCQGQRUw==
X-Received: by 2002:a05:600c:4f08:b0:45b:8866:510e with SMTP id
 5b1f17b1804b1-45b886652abmr141434975e9.25.1756995536615; 
 Thu, 04 Sep 2025 07:18:56 -0700 (PDT)
Received: from localhost ([2a01:4b00:d036:ae00:8ca1:db3d:f1ea:cfc9])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-3cf33fb9db4sm27907318f8f.47.2025.09.04.07.18.55
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Sep 2025 07:18:56 -0700 (PDT)
From: luca.boccassi@gmail.com
To: dev@dpdk.org
Subject: [PATCH v2] net/zxdh: fix building check for arm64
Date: Thu,  4 Sep 2025 15:18:36 +0100
Message-ID: <20250904141854.55944-1-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250904141059.54626-1-luca.boccassi@gmail.com>
References: <20250904141059.54626-1-luca.boccassi@gmail.com>
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

From: Luca Boccassi <luca.boccassi@gmail.com>

The comment and docs say this should be built on x86_64 and aarch64,
but RTE_ARCH_64 is not aarch64, that's RTE_ARCH_ARM64, so fix it.

Also the check makes the build skip unless RTE_ARCH_X86_64 is true,
so switch it to an 'and' instead of an 'or', to build on both arm64
and x86_64, and skip elsewhere.

Fixes: 29e89288ff14 ("net/zxdh: add driver skeleton")
Cc: stable@dpdk.org

Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
---
v2: use dpdk_conf.has() instead of .get()

 drivers/net/zxdh/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/zxdh/meson.build b/drivers/net/zxdh/meson.build
index a48a0d43c2..5e1bc42b28 100644
--- a/drivers/net/zxdh/meson.build
+++ b/drivers/net/zxdh/meson.build
@@ -7,7 +7,7 @@ if not is_linux
     subdir_done()
 endif
 
-if not dpdk_conf.has('RTE_ARCH_X86_64') or not dpdk_conf.get('RTE_ARCH_64')
+if not dpdk_conf.has('RTE_ARCH_X86_64') and not dpdk_conf.has('RTE_ARCH_ARM64')
     build = false
     reason = 'only supported on x86_64 and aarch64'
     subdir_done()
-- 
2.47.3

