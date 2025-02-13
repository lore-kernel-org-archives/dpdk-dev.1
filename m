Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3059AC021A4
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Feb 2025 22:19:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 40D5240A70;
	Thu, 13 Feb 2025 23:18:49 +0100 (CET)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47]) by mails.dpdk.org (Postfix) with ESMTP id 2F705406B7
 for <dev@dpdk.org>; Thu, 13 Feb 2025 23:18:46 +0100 (CET)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-2fa2eb7eb45so4147181a91.1
 for <dev@dpdk.org>; Thu, 13 Feb 2025 14:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739485125;
 x=1740089925; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4njUr5dkOHDc4bLiHbc9hRxitSjOZs14bwKzJu4y3NM=;
 b=pbZ2FECuBL8ztZkcczs1288nj6wJBVVOYUQ9rm2ghq+2Iv5TNG5P3CzMgCV/fhXuTR
 e5qs2VrwcZhgfTWriltIf5CqM1OWe/BXWtuE487Qr/2rrFnRsdXh0aL0gWWl5e5wT1Ty
 SOju0nlZjoqrooobBLYY6gWaFPdbN7+lQFQn32o05pgYywTYQ8+Sqkxk4PvrgBA4pFBL
 B48/uMcv9UsEDcPP23z2u82eIQdfvIfDKkhesu2Gwg1RDKIFhz550TWR1wmEubi2LgaN
 0Ruu2zJPqBPnh5ijckfcLGtOkiBTV8Cp0v3wbAcxBLwo1o5ha+OJV6SD2sc5khSG2IbA
 bILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739485125; x=1740089925;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4njUr5dkOHDc4bLiHbc9hRxitSjOZs14bwKzJu4y3NM=;
 b=reDTFfWjw7x5wh+aitV2AQ6v/cFulNlOVmLJGY0THkm8y65IBTGctUdVQ29vLIN+ha
 KpztnAbBK4vCRGFkBH/LQmc+ezfhIwJL2VenyWqvqfg6GINxH0cirQumc80cJT6F9yEu
 SjrD8i6PT1os/FC7Dd119icULHEF5D09PR7YSSV8MAHgr4ISFquM4bJH5g6LjQc7IVE7
 zYmyL42R6sDjn43trYfBGUxck36qbke47d4Juw49yvbAoyBRR5pUGvBXX4uF6wGDURMR
 Z2fIQRPehyd7q6RBpgEtDVp9zxHN6H0WHQA1zz0AvCvhRgCVJuAdTSljo79TVHI/xfuy
 sofA==
X-Gm-Message-State: AOJu0Yxt7oxJEI9+kTohXR5SEKV5wMV/0Fkl6+d/fL1pj3TZZoTT2oG1
 as2otVjsfCv2OG0SxYuHyB7O9g462XwmnAT2l/Pm6iJIS+nvT7JirB/k4dkChEE8gvIxogClkYL
 O
X-Gm-Gg: ASbGnctk8s9umh4k3PuVcCl/m6scHW3KlpgZXXJZ03rh/jHIioPnr7Ml6RvYeslELrE
 SDdAUGwpOQdC6041vONubhZFntTTIVrayU3Xpresb7e2MjJXqbw7iw1pqNIb63Nd4EjBm4R/iEn
 evlYWWkBVdJ+uGBn1W3RIyuNM1M0zY4UPNLvRCHm+Luj91m3PWv8aZiQF2aiElgfzMrq5ItLowF
 HSLN0eEpj99w14X60Km+bTxQizkU3E3wJtoL+eFCnRUcqJy7vyWNCEES11AfcxFPujCcM3dU7F0
 8f/p9OKFyflD7kRJ8InxtUbxYoTajBPqn21mgMWAI1Je9tB8pbgwX5lNw1fo+e7VR+0U
X-Google-Smtp-Source: AGHT+IF46HT0dlaUJs7+praPZpZC47H0lQvR3RaoB+I8cdL9BTzguWRcqJyMGoAODouDRjwA4eBSlw==
X-Received: by 2002:a17:90b:1b0b:b0:2fa:1c09:3cee with SMTP id
 98e67ed59e1d1-2fc0f9827d4mr7063572a91.9.1739485125361; 
 Thu, 13 Feb 2025 14:18:45 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fc13ad726bsm1706826a91.28.2025.02.13.14.18.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 14:18:45 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v6 11/11] devtools/cocci: add script to find problematic memset
Date: Thu, 13 Feb 2025 14:16:24 -0800
Message-ID: <20250213221819.1856769-12-stephen@networkplumber.org>
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

Script that converts memset before free into rte_memset_sensitive
and memset before rte_free into rte_free_sensitive

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 devtools/cocci/memset_free.cocci | 9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 devtools/cocci/memset_free.cocci

diff --git a/devtools/cocci/memset_free.cocci b/devtools/cocci/memset_free.cocci
new file mode 100644
index 0000000000..96334dc8c0
--- /dev/null
+++ b/devtools/cocci/memset_free.cocci
@@ -0,0 +1,9 @@
+// Replace calls to memset before free
+@@
+expression E, size;
+@@
+(
+- memset(E, 0, size);
+- rte_free(E);
++ rte_free_sensitive(E);
+)
-- 
2.47.2

