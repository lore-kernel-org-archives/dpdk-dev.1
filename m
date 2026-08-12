Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41125C5B56A
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Aug 2026 17:55:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 61C40402B8;
	Wed, 12 Aug 2026 19:55:41 +0200 (CEST)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by mails.dpdk.org (Postfix) with ESMTP id 6106440264
 for <dev@dpdk.org>; Wed, 12 Aug 2026 19:55:40 +0200 (CEST)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2cc97653887so19165715ad.1
 for <dev@dpdk.org>; Wed, 12 Aug 2026 10:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786557339;
 x=1787162139; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=t94sQToyJwcz2QxbSbIHjhlXwogfsfV1+LBPF2zFmkk=;
 b=VnXWPdJjWGpauz70XjU3qwdPoO5ns/YkL+FkVZetZ8M2SXPQJxyzld6TdD0ZsXs0oO
 sCtzFd/sSgBuyF4SSaQ+kBin7pJYeXCSSBXipQw3GqmbPi4NEQT1J2+n9EYIk9oiESLC
 qr5Qi894NhSU2z/eWtIm0Kl7EeU+ORakHIyl7os7z+9RKIHrgacpKAyWmM2vaEUKFJjd
 diRllVGdtDnBK/k+P5yTqNu4OJt1SqT9p1Zp1jyVcLlzsABqNr4o3xm0VlwGtGU0st8/
 87jFmZA/2Rrzuvk/sa1PC7fCR+1Y/glz8tzlum2PmQ2JirFxP4cSlCEfj8tR8OdbLj5E
 Nmzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786557339; x=1787162139;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=t94sQToyJwcz2QxbSbIHjhlXwogfsfV1+LBPF2zFmkk=;
 b=m5BuRdM6hlxKrwB2O8OdqNt386B0jvx6oAgryPgeo1HoQM1zAJkRIZBbh+orv1ZcdO
 OXcpxQb8uRbTD54c31UVL2Hc7cumrrjnFe0g30JLUOU5YYFPlWx+JI2qsSerjcTgaU5p
 xQlfR5lO/yoNW8Fjp19metEDr7M0M46jPvFNqAWxmXB8qndVHRz6xOb6UBR8ql8rKy9J
 V6bb4+tVu0ZPuRoGYDYfXE0Q9g7cU4ZY+WDBrtaqIeU6HWIlZtlQLT7TYnKQSQRIALJw
 /euWbPHq+oJm/mE9TbsoEzj0ZFmV/RhvkkGiEZxm7LTkV32fDYMcz5Y/66gweYUlfbag
 2sIg==
X-Gm-Message-State: AOJu0YwSTvgF0TOEvlxvc/brYql6UOvoF6Jj3eWP9PtrOldvg20SD6Ol
 1UNIfbRJ/z28xuXMbV3k13pPPJvEKxm28Z1/oAu8VpqYJC9tA4t1L8R82R9Nni/BUEFVhTKe6SO
 gXQDq
X-Gm-Gg: AR+sD12cFQSR25ARiqNx0ToZWaJg6ggIzjn4W+fGECnZlYmW5lPC0/1BzqRfcyfir1j
 r5RnGRGq7lynlXrQPcP6874+wmsnFZxj5rgWRt8IQq6yCtj6033M3a5Mu3DvS/zwm92SuNYRIYK
 HyhbuJme9qi12uCBwCCzjHd7z+u7gqtwm+qZ05Sr45ZQTjq2sHwz/IJYp+Bi0jIse9EZI97CsrT
 GpA15JeAjrmNM1PKJcd+nAOsH9L9gnZct5EY7OjtKtMeK0i8xZrZIAW/M/vrMhP0uO9Yu3YjCIk
 2ccw6+IsV0E4g2IqSNfOR3RC8K9+qunAkiPkTCG3fAU3tu/uCbGY6zA28Dxwd4ewafsTqGO82/l
 LcWpeEOnbnGcbgmFlsUsQCz05CDDKzzjAhwwnI/7HtivNq7fHm4XcabG4JB+hz/a7Ywn0UM++8B
 pH6kr3n4LS3hoN8s7X9FfRZRreT3tAIp5lSAX6nCrzJZgO39BFIZ3X3cdfrgnJAmDtB7tqq1PHt
 BcPLjkShzUiP0YkdTimIrfH630=
X-Received: by 2002:a17:90b:3c11:b0:38e:2860:253f with SMTP id
 98e67ed59e1d1-39301480f31mr8253379a91.12.1786557339258; 
 Wed, 12 Aug 2026 10:55:39 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3931cd91899sm283249a91.14.2026.08.12.10.55.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 10:55:38 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH] net/sxe2: fix build when optional libraries are disabled
Date: Wed, 12 Aug 2026 10:55:31 -0700
Message-ID: <20260812175531.375636-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

This was found by AI sandbox build when doing other fixes
to EAL. The sxe2 driver was doing handrolled meson to pick
up AVX which fails if security library not present.

Fix build failure when building with
"meson setup build -Denable_libs=eal":

  drivers/net/sxe2/meson.build:37:24: ERROR:
  Unknown variable name "static_rte_security".

Use sources_avx2 and sources_avx512 instead of hand-rolled
static libraries.

Fixes: 59d866861188 ("net/sxe2: add AVX2 Rx and Tx")
Fixes: 0af0bdcdcf83 ("net/sxe2: add AVX512 Rx and Tx")
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/sxe2/meson.build | 35 ++---------------------------------
 1 file changed, 2 insertions(+), 33 deletions(-)

diff --git a/drivers/net/sxe2/meson.build b/drivers/net/sxe2/meson.build
index d653d071a9..409e3be248 100644
--- a/drivers/net/sxe2/meson.build
+++ b/drivers/net/sxe2/meson.build
@@ -15,39 +15,8 @@ includes += include_directories('../../common/sxe2')
 
 if arch_subdir == 'x86'
         sources += files('sxe2_txrx_vec_sse.c')
-
-        sxe2_avx512_cpu_support =(
-                cc.get_define('__AVX512F__', args: machine_args) != '' and
-                cc.get_define('__AVX512BW__', args: machine_args) != '')
-
-        sxe2_avx512_cc_support = (
-                not machine_args.contains('-mno-avx512f') and
-                cc.has_argument('-mavx512f') and
-                cc.has_argument('-mavx512bw'))
-
-        if sxe2_avx512_cpu_support == true or sxe2_avx512_cc_support == true
-                cflags += ['-DCC_AVX512_SUPPORT']
-                avx512_args = [cflags, '-mavx512f', '-mavx512bw']
-                if cc.has_argument('-march=skylake-avx512')
-                        avx512_args += '-march=skylake-avx512'
-                endif
-                sxe2_avx512_lib = static_library('sxe2_avx512_lib', 'sxe2_txrx_vec_avx512.c',
-                        dependencies: [static_rte_ethdev,
-                        static_rte_kvargs, static_rte_hash,
-                        static_rte_security, static_rte_cryptodev, static_rte_bus_pci],
-                        include_directories: includes,
-                        c_args: avx512_args)
-                objs += sxe2_avx512_lib.extract_objects('sxe2_txrx_vec_avx512.c')
-        endif
-        sxe2_avx2_lib = static_library('sxe2_avx2_lib',
-                'sxe2_txrx_vec_avx2.c',
-                dependencies: [static_rte_ethdev,
-                        static_rte_kvargs, static_rte_hash,
-                        static_rte_security, static_rte_cryptodev,
-                        static_rte_bus_pci],
-                include_directories: includes,
-                c_args: [cflags, '-mavx2'])
-        objs += sxe2_avx2_lib.extract_objects('sxe2_txrx_vec_avx2.c')
+        sources_avx2 += files('sxe2_txrx_vec_avx2.c')
+        sources_avx512 += files('sxe2_txrx_vec_avx512.c')
 elif arch_subdir == 'arm'
         sources += files('sxe2_txrx_vec_neon.c')
 endif
-- 
2.53.0

