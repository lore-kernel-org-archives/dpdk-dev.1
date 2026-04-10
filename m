Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3566EF45A0C
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Apr 2026 20:16:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 496BB4042C;
	Fri, 10 Apr 2026 22:15:54 +0200 (CEST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id C8EBF400D5
 for <dev@dpdk.org>; Fri, 10 Apr 2026 22:15:52 +0200 (CEST)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-48374014a77so34044085e9.3
 for <dev@dpdk.org>; Fri, 10 Apr 2026 13:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dyna-nic.com; s=google; t=1775852152; x=1776456952; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IjuaRo7mlZhpuSJ87Y5zvyYU9rG1siQVkSAiNrWoGBI=;
 b=mekVeFcxRCaJ2p/UO9Par0qfeBelwhcb/q5hkrKygq2AaF9b8dVPMGEEET8XAlSuhU
 t1F3bq9n2Nn5E48BLm2UGToEPmEEK34rmNa9D9p04b+TIq6F7FJU7wm9LYHoWB7YwbXO
 xRbAikkz7HnN61RvDRMbFNx7jt7vrKcaKBJIWLKo3T4UYSou+5XAA+8aV9BjjSYF5zxk
 f/faKY4QpF8aB83vu+Wlh/gQ/NDATE4JTmUF80HSa0TiIQHFvV+K7Rt+6Dfj+g35JW8/
 THoufSZQWMm0I5LgqAY0vXJb9zmKFVTcHPyhlZ21PjD1aAcG+WQlEoMzFd5ycQ0H3gbF
 1PLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775852152; x=1776456952;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IjuaRo7mlZhpuSJ87Y5zvyYU9rG1siQVkSAiNrWoGBI=;
 b=ohEiIZq/z98ySDMiW16r8QChpZdY+vD9zUN4s+eItVc/7lMZKax1lCXZhROrLVr5GF
 nXN9mZHsE08erRyz6X9uEWDqOXaKGXV4MnFSEDvlUYdJuMgKd/0r1KSfztv9GY8Arl8r
 mMo66LudPp4K5pxx3367h43D3nPVau1juPGwXTcM515cpzm6oLvjHVi93ToN+0DgA8ND
 CSV7gqu1WK6HE2i/z3zw1vBZqYzeG8N2xluB1sAzWo41C0gnZ7Sv532BuFRBuMLRWDkg
 z/9GHR59i+oEQ3Ae4W6xYYcm7TbWLV7QklqJwcH/aws0H4bF+ihKejL/yKUaql4yNnQj
 IXfA==
X-Gm-Message-State: AOJu0Yy3JD/FTdkN/8xo7+b690SXsOkOH9BtaBk/yEi/aj7FtZHyYlda
 K1i8PpMDeFe8kElo7igIjFu0g/ly8be22tSd5jKyWaJ6wfGrf8Qc/0YmZ+FPdVHB3/908gvubqh
 boA4p
X-Gm-Gg: AeBDietfKJdE8KYTkZFQIIUePJ8d4RtNpD7X9E8vvxSuPpPs7RBKhvjEz83htvuqfnu
 WrneDS6/x/6tvgZumC02oWfTg1DpTIZoJeM7wvZA2PuQLPVmuZJ19zwicYmYa8rxWz8AmoRABig
 wn5oyK2JpT1sGpgwQ7F2WHL3jzoJlNCGA7IJhElGIOW1HiImXDfe6j6U1OgM83fzdRnNgoz5JiD
 S7o4zJSqkR6EGDLVUAMRahdshuq29bX5r6mQGCAopt+jRG3gDoHCXoc9bHPAVvYaNcJsgQ+ICdx
 9ZA66uLD7/1Mv+sLqOts+0ezSDI9qNrs5hbiwe905axI6BOPP8eO0Fuz9XMWqJJVMY+DOI6StTQ
 R4Fbn69saV7cmvNL/yjiF+Ywr+C7n7MfnNA7sL9P54u4oC6Gf5po+8jqESXOntxLvGAZERkz+JG
 cl7V4ytZTXFat7ShxNHVEQDgjuZdOt4amKaC1G//T/FDQvM2D6yBMtK2R/oVgCKwY=
X-Received: by 2002:a05:600c:8706:b0:488:a62d:76d7 with SMTP id
 5b1f17b1804b1-488d67df53cmr61959765e9.1.1775852152415; 
 Fri, 10 Apr 2026 13:15:52 -0700 (PDT)
Received: from dpdk-test6.liberouter.org (rt-tmc-kou.liberouter.org.
 [195.113.172.126]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d684406bsm26044405e9.24.2026.04.10.13.15.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 13:15:51 -0700 (PDT)
From: Lukas Sismis <sismis@dyna-nic.com>
To: orika@nvidia.com
Cc: dev@dpdk.org, stephen@networkplumber.org, thomas@monjalon.net,
 Lukas Sismis <sismis@dyna-nic.com>
Subject: [PATCH v11 1/6] cmdline: include stddef.h for MSVC compatibility
Date: Fri, 10 Apr 2026 22:15:39 +0200
Message-ID: <e6b37bf0359f847e14b84eeca3718e98cb6aaecd.1775850858.git.sismis@dyna-nic.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1775850858.git.sismis@dyna-nic.com>
References: <cover.1775850858.git.sismis@dyna-nic.com>
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

Include <stddef.h> at the top of cmdline_parse.h before the
fallback offsetof macro definition. This improves MSVC build
compatibility by ensuring the standard offsetof is available
before the fallback definition, avoiding macro redefinition
warnings when building with /WX (warnings as errors).

The standard header provides offsetof on all platforms, and
including it first ensures the fallback is only used when truly
needed.

Signed-off-by: Lukas Sismis <sismis@dyna-nic.com>
---
 lib/cmdline/cmdline_parse.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/cmdline/cmdline_parse.h b/lib/cmdline/cmdline_parse.h
index d9a7d86256..c4131e4af5 100644
--- a/lib/cmdline/cmdline_parse.h
+++ b/lib/cmdline/cmdline_parse.h
@@ -7,6 +7,8 @@
 #ifndef _CMDLINE_PARSE_H_
 #define _CMDLINE_PARSE_H_
 
+#include <stddef.h>
+
 #ifdef __cplusplus
 extern "C" {
 #endif
-- 
2.43.7

