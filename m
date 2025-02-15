Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC78AC021A4
	for <dpdk-dev@archiver.kernel.org>; Sat, 15 Feb 2025 19:07:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8F4C940DFB;
	Sat, 15 Feb 2025 20:06:09 +0100 (CET)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by mails.dpdk.org (Postfix) with ESMTP id CECC540BA0
 for <dev@dpdk.org>; Sat, 15 Feb 2025 20:06:04 +0100 (CET)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-220dc3831e3so43200655ad.0
 for <dev@dpdk.org>; Sat, 15 Feb 2025 11:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739646364;
 x=1740251164; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HNJHgWrp7PrghusG1EGUIcrHmq1efQC46Cm2w7NVkN8=;
 b=0erX4OO1o6vtCNho3FGaht+WLNgDCm6UKImYMtx19S/sjpizXmlvSj/H0bMXsRPss7
 3QuSAcBuyVVYAg5FFUEG2aHqCTwEBYjA/hWgUUP/b01d3WZnU6EZCebzne3dyJHLTVUD
 4QMlX01Jk2XfZn/2Cp5pAgvZxpXXm8JX997uSpdnyIj88yk8TR6KRX0V6LIuFWjGacTY
 Vh3p934dHj3vVNJGJCXSCgAYgCk9VHdwlsELPsMB+fIk1qQ8fkOrI+UL7q0Lx+1qPJo5
 KAlAyIpYI2l7+ENAwJ/FxFS+5dnjgxi2i3XEyHTve/9y2UJ9jfdI/x+aC6myl2QtHezp
 CKcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739646364; x=1740251164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HNJHgWrp7PrghusG1EGUIcrHmq1efQC46Cm2w7NVkN8=;
 b=OLbJOqFxDhwHHPYutYgawEuv+aEjk5O1n5JUub/gkmgVsKwAlI+Ld0lML/NttloCcg
 PgnUtPzjFtYkj+I/gGIM3ocYau8rzzzPG6dXVkLTbO1cUQ04ZSA0JE/L0kQYWAKxpRtq
 lQfP0ZTlbZOfybS+7ZRG6332diGXbB0KSp5+UPfTnOoZ49ypQFUpyHwEzXB0rWbsI6L8
 0kfHwzAsd+zq5jZjnnieZXgkBYe7Gb1yOJOYt0Tio3g6AH+KMd3hfq/bFd3CEQCSwZyh
 dY0A1wBJZdLIFavrGNmDH/9nfHLUBPa5ZiDgKS1wDxbPjB4cekDEWJvD0ZN7SsKxW9DS
 Gthg==
X-Gm-Message-State: AOJu0YwH+UP7oMKoBYPzQrXu7vD3Oap1YbjXY9dt33dvYzoHLcYjr5T+
 +erkFPfDHM/Kc8ma0H8QCyzFcQRAahzB9Pxh/kcEh+52w0wB7iwf7sdrAOOmxwvWTq03Qi5lmUI
 O
X-Gm-Gg: ASbGncu1UsCb+yPqmVIxqybLCYqLzVLhqqYtztWANFYevJ/z52BdDhGUr6v5EyuWstu
 GE/Fx6FZ5Oi1Dtpuimc+GxXwtM31YDDbIkP6PPZkRnVvWWjHfBAPjQHzJWGM/QJQRN8LeuJRAhV
 YyVYPIUJp1gln7gXvUAgb8AjkqEU5DoDYQmEehZgZHpudyK4vikvFGswg5ep+XKizPXvIF5le4e
 nTTwCRpfClnt5GPn12U+Bltswl6soHBVoL2d1ruyGl66HDH7RWEUjx+hLCdLuZJvY/oebL2KwgK
 GIhXcZgp5jD7HA8vDqZYSivQycOVBF4nerd8Np0SqSl+nSej7eaSe1DUBKxHBnSv1nOF
X-Google-Smtp-Source: AGHT+IG9GHqtz5F41nhLaqjKTeAyhs7Z7/aFAI1+QBfNNFb3zvQhK3o1yrAj8UpPSPMl3etLLnsQrA==
X-Received: by 2002:a05:6a21:4d14:b0:1ed:d780:feaf with SMTP id
 adf61e73a8af0-1ee8d6a16cfmr6942014637.6.1739646364064; 
 Sat, 15 Feb 2025 11:06:04 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7324254685csm5080179b3a.4.2025.02.15.11.06.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2025 11:06:03 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>, Kai Ji <kai.ji@intel.com>
Subject: [PATCH v7 10/16] crypto/qat: use secure free for keys
Date: Sat, 15 Feb 2025 11:04:38 -0800
Message-ID: <20250215190544.988310-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250215190544.988310-1-stephen@networkplumber.org>
References: <20241114011129.451243-1-stephen@networkplumber.org>
 <20250215190544.988310-1-stephen@networkplumber.org>
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

Regular memset maybe removed by compiler if done before a free
function. Use new rte_free_sensitive instead.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/crypto/qat/qat_asym.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/crypto/qat/qat_asym.c b/drivers/crypto/qat/qat_asym.c
index f5b56b2f71..d8a1406819 100644
--- a/drivers/crypto/qat/qat_asym.c
+++ b/drivers/crypto/qat/qat_asym.c
@@ -102,10 +102,7 @@ static const struct rte_driver cryptodev_qat_asym_driver = {
 		curve.p.data, curve.bytesize)
 
 #define PARAM_CLR(what) \
-	do { \
-		memset(what.data, 0, what.length); \
-		rte_free(what.data);	\
-	} while (0)
+	rte_free_sensitive(what.data)
 
 static void
 request_init(struct icp_qat_fw_pke_request *qat_req)
-- 
2.47.2

