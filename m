Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B55C5B572
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Aug 2026 17:48:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 93AAE4026E;
	Wed, 12 Aug 2026 19:48:03 +0200 (CEST)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49]) by mails.dpdk.org (Postfix) with ESMTP id 156EA40264
 for <dev@dpdk.org>; Wed, 12 Aug 2026 19:48:01 +0200 (CEST)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-38e58034d05so1272501a91.2
 for <dev@dpdk.org>; Wed, 12 Aug 2026 10:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786556881;
 x=1787161681; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=t94sQToyJwcz2QxbSbIHjhlXwogfsfV1+LBPF2zFmkk=;
 b=wY0z0WU0LC21jZTzz7Af076hBQIOe0feAzKj7k5ozloRHBIePWw7dTEFXk/IeD1F19
 T4+Kb4NKpp7MnnvkxXw7ATLJvQP3OqG+n6sEcntpvvmOTBhiNrV3qWyL5BU1dkb9UaOv
 02sHyFEWktAZXFMgIwIR349Q9pjCRn005MPkDyjjcCvvxxdj3GVHz7vliCXEexDhzKdu
 za/qCWxrMmK8Yjt/eyclD6fhw14JBOEBmZ6MQkKF7oL0lquXhF2tFqhXIky22DxNGn+m
 5O8GXVOCukpzBbzxYBtf/VHK5+BFdVJVeBaio+aLlhCUJm1E3yBkB5ixL66sgqn+JOA3
 yKpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786556881; x=1787161681;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=t94sQToyJwcz2QxbSbIHjhlXwogfsfV1+LBPF2zFmkk=;
 b=JjYxek6xk4GecNpW6NqkDOxAxq21phMJhoSMzIuPA/q+sYWO9ObznS+e55czA0WCvz
 IsSblaZjhEmWiEX9lpZwVHLrgkyUTEfzbg27si+ePIXGxxWeO7spXTCEWEGhCUnLaBH6
 3Z+RhnGa5gGc6BiqCyJYmT7xLjdYL5TQe7qP9APhP6FjtJgTcpkTY8am0KmxrWFPB4/6
 wwWUZne2nCmeYS5UU935RmpbegcqxUHGbsEH/1i1MiipZOZ8lfoH6qtrT3nfm9OE5Bkl
 Okaud4pBUzMCnLiqPM3V8mG4TEhqqtDMao+27aByEL8DaSRAN+2kJefsHNBX1CdfxEJe
 pUHg==
X-Gm-Message-State: AOJu0Yyq2ckEyeojlpwZFAbRgF4BRy+p9CSR2XBbK9HE36phX7O41262
 gJeiDyatXd65xIkkPULLi1nRqsqCZ0HsMtypqN9LCA7ChQiqOeWi1wS2iigFko+02vCxhFhguas
 ZiWJG
X-Gm-Gg: AR+sD10E/rLMCudkpIho5dwczrYpcYoERsHGdLTspkogQf4Y3T/wpwEWisSBzJIkECi
 s30pQyhmAiChzXkGjrxYTmzASoWDyEUI9O2vl/MatGM7O2qhPnxe2H+rAXl5kiv5HkJ0nUIxLZr
 4LLo1aje/RRlKbpG+qt9iPLikefpunUjIARIv6Hkzml8e65V4xWqmPWsmi87YbvGFFFd/ay9mlU
 fMXCybvQgLYEPbx/+efMIUDnKTQQhKVjJVr3hHTAvsE/IMhInjU+hZAT0R2oVqcZpLUMwz76nRV
 F2qc+9CmwkfVFTYTDwyt5qJZldWlxC7OfaoiR/kb3N2DMg4+KVHZzADpxo7at6Bqzhi5b0afVnN
 8fXT46i9ragywy3iSYfpD3fKGql5bkL0GtvfUXRLOJPr9wUZJmFIPJGv6BhSa790aMzTdTlotWv
 mOzs7XaHeQgmBQ35AnOyE6P+aS+VxuZ+rT9lfzCDuu0UHQ7pu+9RjJTHE/jYA69sebw+3jkD07D
 bLJnQsFSmSAL/tzqwTkXUHqw7Y=
X-Received: by 2002:a17:90b:4406:b0:37f:fb1d:63fa with SMTP id
 98e67ed59e1d1-39301663a8fmr6601682a91.15.1786556880851; 
 Wed, 12 Aug 2026 10:48:00 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3931cce8a4asm256115a91.2.2026.08.12.10.47.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 10:48:00 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH] net/sxe2: fix build when optional libraries are disabled
Date: Wed, 12 Aug 2026 10:47:49 -0700
Message-ID: <20260812174749.336648-1-stephen@networkplumber.org>
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

