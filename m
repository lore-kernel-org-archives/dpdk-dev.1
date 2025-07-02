Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA13C77B7C
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Jul 2025 13:37:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6258340E26;
	Wed,  2 Jul 2025 15:37:02 +0200 (CEST)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id 93BD6402E8
 for <dev@dpdk.org>; Wed,  2 Jul 2025 15:37:00 +0200 (CEST)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-23636167afeso42078185ad.3
 for <dev@dpdk.org>; Wed, 02 Jul 2025 06:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1751463419;
 x=1752068219; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1oRyFbrVN65vpt98NYomY/7L7jAo+CavEoW/0kmTUM8=;
 b=C65/4s7rm39QTfKCKcck0Og9vOwOPCAoZIZT1PKsRRu970XHcL45TafyH2aHETloH3
 hHeqTAf1NTcDZ1osBQE5+M+VqHkky3tbExljqd9jsxfNtMYF1A9S1iCEdxop6Bet0ZIi
 MpmdTgaxiXGzx0gvudpRQTAtH11a5r//1KOnqGa4cFfVko4lYmUFEmT4CDrkRvkw1Bix
 4Yy0uOb0h0saQllpC6KuHorelk1YZiq1Q64JQ8iT2qB4ubO1FjeDrLRgFA8rkjoHDP28
 WTp0+4tMEBZ5PxJiUy+xBfZr9TpdmfhI2yv0q2/D9scl7ozbCZ3Dki3cL/9zMY7UKl9A
 8v1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751463419; x=1752068219;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1oRyFbrVN65vpt98NYomY/7L7jAo+CavEoW/0kmTUM8=;
 b=Fob9FB4dL2JbVQL0YFBB+Y/UiSLCfwEW8ny64akXR1IW4qZLpoJFeuXgOnAynehlHe
 gcQlyZL1qlsOkIQxJogOdJBM0O/idCixAr2vV7w3Abn9kxkstV9HxhdXSYtUry+SIh8m
 63DbtiuUABVh6fT/Ck+MLESw8lP/Y1Fe5C40VTWnG9Nnz/kPZa2HOyKiowRkYYOcKjia
 G9hm+NTH/wzdTZSX4xzJHWQ7QXSMjjCFEEoTeE4ZNKx3xG/MGf/hoZ/8gWIlal7vC1Fn
 p8ifFigJUYQ9/FOD/6lyJwKtdWnSgSuZbOVgdtgU9V2j3JaEgSr38L7QC7ObPhzHKGM3
 fzZA==
X-Gm-Message-State: AOJu0Yzpv9lTggsg2fmjrWCc6QRoEo+q1KYDjDL7mMFX/nUWe97RfW+T
 AjBo4BT5A+9XiJRXkGwwlghc3TMqCDcsuGXyOl5uJZdPGS0WXZ/r/z1gQDUOYZO65pOdYVhxiAu
 HCUF9Cqo=
X-Gm-Gg: ASbGncuH6dPCFDFXL9RZBfhq6AnhWcXT1V6kC3mPPESM1rZwRK6/IEfo6t9jGPo318H
 zrE6ntue+ongihP6OSyM13XZ1+PTHlSSWTVcSqdK0xxIx9ojeyXzOEPxfjbFgtuYvaDD4j+8vKx
 GyYuHX2J+FhxImlT2KhMizcrKC4M9zQCo2HOpuyD7Gnx4EVhEn2clEOOPuD6urqAwzKONm68Eye
 k3obHRb7r617njnCJp3dairbgCmWCaMvFv8LLshXNygT3SYLkf7AZkVwz21GuVgPJkNhGWm7UJP
 ISTLNnngERBVLkz59hOJ3qwgX860eAK5V1PBrfStPkXQvv9f/wKN6S4BbJt7wuqBRykhCsNX0U3
 6yDn9fVEdZ/KTKtc0S1vT43c=
X-Google-Smtp-Source: AGHT+IGkkpVmyA1xSr412TGZNtt5RuIeTGUsT8tfef2CxIkjmojlu3rnnXNnvXq2jYfqpnqOQO/o8g==
X-Received: by 2002:a17:903:b8f:b0:234:b735:dca8 with SMTP id
 d9443c01a7336-23c6e4dbe0bmr43419835ad.6.1751463419480; 
 Wed, 02 Jul 2025 06:36:59 -0700 (PDT)
Received: from localhost.localdomain ([64.62.143.197])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23acb2e325bsm132094905ad.29.2025.07.02.06.36.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 06:36:59 -0700 (PDT)
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, stable@dpdk.org,
 Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Subject: [PATCH] doc: clarify disabling AVX-512 when building on Haswell CPUs
Date: Wed,  2 Jul 2025 09:36:49 -0400
Message-ID: <20250702133649.1931134-1-14pwcse1224@uetpeshawar.edu.pk>
X-Mailer: git-send-email 2.43.0
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

Some Intel Xeon processors (e.g., E5 v3 Haswell) do not support AVX-512
instructions, and building DPDK targeting 'native' instruction set can
fail with 'target specific option mismatch' errors.

This patch updates the build guide with instructions for configuring
Meson to disable AVX-512 and target the Haswell architecture.

Bugzilla ID: 1736
Cc: stable@dpdk.org

Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
---
 doc/guides/linux_gsg/build_dpdk.rst | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/doc/guides/linux_gsg/build_dpdk.rst b/doc/guides/linux_gsg/build_dpdk.rst
index 9c0dd9daf6..57d3fd484b 100644
--- a/doc/guides/linux_gsg/build_dpdk.rst
+++ b/doc/guides/linux_gsg/build_dpdk.rst
@@ -123,6 +123,28 @@ The instruction set will be set automatically by default according to these rule
 
 To override what instruction set will be used, set the ``cpu_instruction_set``
 parameter to the instruction set of your choice (such as ``corei7``, ``power8``, etc.).
+.. note::
+
+   **Disabling AVX-512 instructions when targeting older Intel CPUs**
+
+   On some Intel CPUs (e.g., Xeon E5 v3 "Haswell"), building with
+   ``cpu_instruction_set=native`` or not specifying it at all can cause
+   errors like::
+
+       inlining failed in call to always_inline '_mm512_maskz_broadcast_i32x4': target specific option mismatch
+
+   or::
+
+       AVX512F vector return without AVX512F enabled
+
+   This happens because the compiler tries to use AVX-512 instructions that the CPU does not support.
+
+   To avoid these errors, you can disable AVX-512 explicitly and set the architecture to Haswell by configuring with:
+
+   .. code-block:: console
+
+      meson setup build -Dc_args="-march=haswell -mno-avx512f" -Dcpu_instruction_set=haswell
+
 
 ``cpu_instruction_set`` is not used in Arm builds, as setting the instruction set
 without other parameters leads to inferior builds. The way to tailor Arm builds
-- 
2.43.0

