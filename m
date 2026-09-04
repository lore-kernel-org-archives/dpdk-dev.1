Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5F6C624D3
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Sep 2026 19:17:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 00CB942E1C;
	Fri,  4 Sep 2026 21:17:21 +0200 (CEST)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mails.dpdk.org (Postfix) with ESMTP id 1C992427D1
 for <dev@dpdk.org>; Fri,  4 Sep 2026 21:17:20 +0200 (CEST)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2d6e954afbdso8946675ad.2
 for <dev@dpdk.org>; Fri, 04 Sep 2026 12:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788549439;
 x=1789154239; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EzVWSNjpzS5N/dpdcXjMU41DK1zUYAHPeQ0dtbdwg2w=;
 b=et6aOdq3El7GMIq2gk7f+mGBM4/x81P0uj24dLdhFCDROe/ToXdpmTT4Dq8oTupQce
 TFemyuntmuZj6tCZwAufYtlLKfMQhor4VPXhnm+0gEqlgoTAIJG03irj1OOnmxxogt6u
 V4A9qqVCqjnOdjhamHVHB3+F/lCz1C+M1YDDf+RTb+1DBAbAAj0x0Ij6FgQCKysv549v
 LzvXFn14rbdUJBREP1A4HryQuuN5X8ORz4YcvBEsuEYNKjBuG915TSaVWWECkd7C3uHG
 0RvjCGKfThHgdZUUIE00N3IbrjFVAQy/mIhzXxGzv5BZeOFAzQwj1x8fBdR6e8nw8KPE
 OKFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788549439; x=1789154239;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EzVWSNjpzS5N/dpdcXjMU41DK1zUYAHPeQ0dtbdwg2w=;
 b=gu9HwmM5odHXkyFI2z9G9xTGQYOVLiHcxb6JqGx8zcPabWY/hL3JoJPJS/wCsgFw9k
 9ywfqVJktk8f6MdTe3f4ZAqb6MdSuKFEBAdUtNqbSR8LG7HrWbcTJG4TfKzzQyh8l8hf
 Zgnb2PE0fWDWe9uCrkwwhmDHcYH12aGD537+6srPL49WYenwBOO7XX7htZhq58lmBNhr
 uFiv9zZW75AxaxeOA7lE2GZaBbpU8hAKa0j5XPmfHD6zN78m20DpGtGQS4hEiLCDV5l0
 TeYjnLbzEsRLVbUUqhknrqHNtKmU1zpIazn4P9oB6/GSLVyLyYsqDfYJQpfrEsWC+gM5
 ovPg==
X-Gm-Message-State: AFuF++mps5cGPznQ+xVUr35DttPz5R4Bq4Flex29NQODidS56/Omsgd+
 OYjEmY7PxIkOW01dBq4ekUPZ25A7X0PxHUUiu8AoGX5BL5YsDbZ6WWvUb/Px1XgIXo9HR7BQXiG
 kRWzI
X-Gm-Gg: AYBFou398NAMmBmbqPAx/WbnsTw6uJjTd83mp3ddgyR247u0URZwQrHjbcfpPp8OdFy
 bqBLbMX3t3RyXXy58ixMjr5i55QiymPmTDGmLP/IsMiwtoulVCSjFhkt9dTx/PuR8bLl9GXGRBy
 Yz2v2Botxb71h7ZHDWAJz0tYRv8dEa231W9WBsn4+r1wGRTfDB1d9Q20PEPiYM9bKLbeZJOs80K
 2VPLsr0VmstmFzQVO+iEL7R59PcWU2naEsJqNvSdz6SnJwotdlxAtTAyDQCEM7o1l92sYVg4Gh1
 MPf4tQam0loee8ELL+rrgk1jr3Bq4Bn7dLIQRarbiSfhdy98Tqq3Oc+XX8wFb/xEwqlyP0vrW0Q
 NUBkkAXZUs1jW00xQEWO7nunnEs+Fb/DjiecEp8AaXNzxmL4er5LGxeTbEeizQThbh5uOnf9g2K
 puEHeflFNl2X9rAJ0GggcbRvE8VFBJF6PF0RMKe8pcwGP7wuZWq9HY7T4SdzzVsanN71NIjid0O
 fPlTzTJDXjclOwjJksK2w7EBjw=
X-Received: by 2002:a17:902:d586:b0:2cf:b68a:340 with SMTP id
 d9443c01a7336-2db125f0cf2mr117921125ad.10.1788549439125; 
 Fri, 04 Sep 2026 12:17:19 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2db1499f07asm13335975ad.57.2026.09.04.12.17.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 12:17:18 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Kai Ji <kai.ji@intel.com>, Pablo de Lara <pablo.de.lara.guarch@intel.com>,
 Akhil Goyal <gakhil@marvell.com>, Ciara Power <ciara.power@intel.com>,
 Piotr Bronowski <piotrx.bronowski@intel.com>, Ray Kinsella <mdr@ashroe.eu>,
 Fan Zhang <fanzhang.oss@gmail.com>
Subject: [PATCH 4/7] crypto/ipsec_mb: fix missing header for debug build
Date: Fri,  4 Sep 2026 12:12:39 -0700
Message-ID: <20260904191652.2399074-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904191652.2399074-1-stephen@networkplumber.org>
References: <20260904191652.2399074-1-stephen@networkplumber.org>
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

Building with RTE_LIBRTE_PMD_AESNI_GCM_DEBUG fails with an implicit
declaration of rte_hexdump()

Fixes: 746825e5c0ea ("crypto/ipsec_mb: move aesni_gcm PMD")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/crypto/ipsec_mb/pmd_aesni_gcm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/crypto/ipsec_mb/pmd_aesni_gcm.c b/drivers/crypto/ipsec_mb/pmd_aesni_gcm.c
index 8c35820ef7..3c266cc47e 100644
--- a/drivers/crypto/ipsec_mb/pmd_aesni_gcm.c
+++ b/drivers/crypto/ipsec_mb/pmd_aesni_gcm.c
@@ -2,6 +2,8 @@
  * Copyright(c) 2016-2021 Intel Corporation
  */
 
+#include <rte_hexdump.h>
+
 #include "pmd_aesni_gcm_priv.h"
 
 static void
-- 
2.53.0

