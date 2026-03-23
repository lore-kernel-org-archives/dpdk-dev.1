Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C243DD58CBE
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 04:08:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AA7EB40268;
	Mon, 23 Mar 2026 05:08:25 +0100 (CET)
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com
 [209.85.214.195])
 by mails.dpdk.org (Postfix) with ESMTP id DBA9A4025F
 for <dev@dpdk.org>; Mon, 23 Mar 2026 05:08:24 +0100 (CET)
Received: by mail-pl1-f195.google.com with SMTP id
 d9443c01a7336-2b05761bec1so21169505ad.1
 for <dev@dpdk.org>; Sun, 22 Mar 2026 21:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774238904; x=1774843704; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RrZ6B+bgmqv7UoopZy0oKgFlM5A8fvxUSq/ivnBDRUQ=;
 b=DCM+9fOtuvqXZpzkkVA87aLwLb6XCIKU7dqIDqvhzO2AjEMn00aavh3gpjFb1hEGIS
 C18+k7hjOrHurTL37OQcDdQ0GTIY0jko5GmYooTUXgvruWEsurAHHzR96nxjizGMxtOR
 F4pT9ukiGqBXGmBZLi1XHVcMliVQoFQssyYIYx0wMtikxmi8VeB5Tk+6VRBxfFzB+KxS
 jVRTx8arJkBJmsgSU/fpL2uYF9oTK9AqE7DvZkf4xjK/nz7+VjCwdi3PlaPwxvebgjgG
 y/5tZtA3S6Bn/UPSNeqr1AZxhXyOUz1qPFDs9t8wwBXgLe55MbRuD/MmzjPv0YOx2bKv
 RjKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774238904; x=1774843704;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RrZ6B+bgmqv7UoopZy0oKgFlM5A8fvxUSq/ivnBDRUQ=;
 b=h0K/3zjPXRbMpuI6gvyBNbAKmN5vqQCi5kQfYjfCoR8UJBp+wYuqIkjNBlOxoiv8nD
 UlGxgDRRLFPMw9rvUXZjIrt48qJF8rUak0H/tlATCA5Tk1oUw0A/B4KLuKPJ0ya3/jZy
 5ggkgzjpLkX9BZdBic2DWAhKEjfQR1M0GZp/i4zR2JkQqgb9fZf/82a4UcaGW1kjgfHC
 lCVxLmL/HQMBlLsoD47exRloBpANbcEK8VHr7/22roP5Oil4geEiaiu90meP6EjrbyCg
 VOCDHL9Yon5a9fGh4frpo3YqRc3l3AkVpfgnKmvTFDbUKO5stbWSKe7jD2A5UkC7P+Kt
 Jc3g==
X-Gm-Message-State: AOJu0YwKwcbdoJ+0T1RqS4W0dM4xFwx1T8ZUNcWTQq10XRegoyWaxx+P
 J/iI1khBqESAme350z6jxcbzpHF+MMZjadWtZrVBiMKfehQX/gOennBSODLtOsDKWCVd1w2D
X-Gm-Gg: ATEYQzymbaVoX+R57hcEx+L0g+X/YQxj9Uj+OcTg5N53iB9fY6rQ3riJZq26jacvU5u
 XOX5NPmna8XXRoOoWartVs/sSxLKpCYlNJfWz2C5qs6oFjFK1Ae6PAi5EzRZ5ieHJ64dWxPJ3gJ
 HsBvOeAP+wWiCZc64XjhWlbSebTzUd+QAlMWcuSv4/rC3qN4XotIQCam6++iUPW17RxWNEWtSQr
 z30LUni6mtq+F4RNkR5FONjwlibxblyULoQ+YtvFqN0WiY2BCJKzT23t4Mmjs1kspn7bMhsI6G7
 PsCmU2NfCv0mOnA5BPTADTIm36WIy4OJl1H5n2PFm3j1hyet3lRxrvG6N4zm4vMHUs4OjsQ0phu
 Z1R/AG4TAjZDAQ8zh4LicH3ckgvBgqCS4zLYe0PBHEIP7yKUMe1T2N62TlE/hRJ7S0tMZHpt5Dh
 4VyKVVV82uIuKhGplMIb2o07uaZIJ0VFv8ImRGbbdtrdjilXfG5K8kiA==
X-Received: by 2002:a17:903:1a67:b0:2b0:427b:909d with SMTP id
 d9443c01a7336-2b0771ee090mr126849295ad.20.1774238903436; 
 Sun, 22 Mar 2026 21:08:23 -0700 (PDT)
Received: from localhost.localdomain ([180.101.235.28])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b083688ca4sm119344025ad.67.2026.03.22.21.08.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Mar 2026 21:08:22 -0700 (PDT)
From: dangshiwei <1138222970gg@gmail.com>
To: dev@dpdk.org
Cc: stanislaw.kardach@gmail.com, sunyuechi@iscas.ac.cn, thomas@monjalon.net,
 dangshiwei <1138222970gg@gmail.com>
Subject: [PATCH v2] eal/riscv: add Z sub-extension detection via hwprobe
 syscall
Date: Mon, 23 Mar 2026 12:07:54 +0800
Message-ID: <20260323040754.4197-1-1138222970gg@gmail.com>
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

The existing RISC-V rte_cpuflags implementation only detects
single-letter ISA extensions (A, C, D, F, M, V, etc.) via
AT_HWCAP. Z sub-extensions such as Zba, Zbb, Zbc, Zawrs and
cryptography extensions (Zksed, Zksh, Zknd, Zkne) are not
visible through AT_HWCAP and therefore cannot be used for
runtime dispatch.

Linux 6.4 introduced the riscv_hwprobe syscall (NR 258) which
exposes Z sub-extensions via the RISCV_HWPROBE_KEY_IMA_EXT_0
key as a 64-bit bitmask. This patch adds support for querying
Z sub-extensions through this interface.

Changes:
- Add REG_HWPROBE_EXT0 source to cpu_register_t
- Fix hwcap_registers_t type from uint32_t to uint64_t to
  avoid truncation of AT_HWCAP on 64-bit platforms
- Call riscv_hwprobe at EAL init via RTE_INIT and cache the
  result; falls back silently on kernels older than 6.4
- Add 56 new enum values for Z sub-extensions in rte_cpuflags.h
- Extend cpuflags_autotest to cover all new flags

Signed-off-by: dangshiwei <1138222970gg@gmail.com>
---
 app/test/test_cpuflags.c             | 167 +++++++++++++++++
 lib/eal/riscv/include/rte_cpuflags.h |  79 +++++++-
 lib/eal/riscv/rte_cpuflags.c         | 262 +++++++++++++++++++++++----
 3 files changed, 474 insertions(+), 34 deletions(-)

diff --git a/app/test/test_cpuflags.c b/app/test/test_cpuflags.c
index a0ad099815..d83c54e9f6 100644
--- a/app/test/test_cpuflags.c
+++ b/app/test/test_cpuflags.c
@@ -281,6 +281,173 @@ test_cpuflags(void)
 
 	printf("Check for RISCV_ISA_Z:\t");
 	CHECK_FOR_FLAG(RTE_CPUFLAG_RISCV_ISA_Z);
+	printf("Check for RISCV_ZBA:\t");
+	CHECK_FOR_FLAG(RTE_CPUFLAG_RISCV_ZBA);
+
+	printf("Check for RISCV_ZBB:\t");
+	CHECK_FOR_FLAG(RTE_CPUFLAG_RISCV_ZBB);
+
+	printf("Check for RISCV_ZBC:\t");
+	CHECK_FOR_FLAG(RTE_CPUFLAG_RISCV_ZBC);
+
+	printf("Check for RISCV_ZBS:\t");
+	CHECK_FOR_FLAG(RTE_CPUFLAG_RISCV_ZBS);
+
+	printf("Check for RISCV_ZBKB:\t");
+	CHECK_FOR_FLAG(RTE_CPUFLAG_RISCV_ZBKB);
+
+	printf("Check for RISCV_ZBKC:\t");
+	CHECK_FOR_FLAG(RTE_CPUFLAG_RISCV_ZBKC);
+
+	printf("Check for RISCV_ZBKX:\t");
+	CHECK_FOR_FLAG(RTE_CPUFLAG_RISCV_ZBKX);
+
+	printf("Check for RISCV_ZICBOM:\t");
+	CHECK_FOR_FLAG(RTE_CPUFLAG_RISCV_ZICBOM);
+
+	printf("Check for RISCV_ZICBOZ:\t");
+	CHECK_FOR_FLAG(RTE_CPUFLAG_RISCV_ZICBOZ);
+
+	printf("Check for RISCV_ZKND:\t");
+	CHECK_FOR_FLAG(RTE_CPUFLAG_RISCV_ZKND);
+
+	printf("Check for RISCV_ZKNE:\t");
+	CHECK_FOR_FLAG(RTE_CPUFLAG_RISCV_ZKNE);
+
+	printf("Check for RISCV_ZKNH:\t");
+	CHECK_FOR_FLAG(RTE_CPUFLAG_RISCV_ZKNH);
+
+	printf("Check for RISCV_ZKSED:\t");
+	CHECK_FOR_FLAG(RTE_CPUFLAG_RISCV_ZKSED);
+
+	printf("Check for RISCV_ZKSH:\t");
+	CHECK_FOR_FLAG(RTE_CPUFLAG_RISCV_ZKSH);
+
+	printf("Check for RISCV_ZKT:\t");
+	CHECK_FOR_FLAG(RTE_CPUFLAG_RISCV_ZKT);
+
+	printf("Check for RISCV_ZFA:\t");
+	CHECK_FOR_FLAG(RTE_CPUFLAG_RISCV_ZFA);
+
+	printf("Check for RISCV_ZFH:\t");
+	CHECK_FOR_FLAG(RTE_CPUFLAG_RISCV_ZFH);
+
+	printf("Check for RISCV_ZFHMIN:\t");
+	CHECK_FOR_FLAG(RTE_CPUFLAG_RISCV_ZFHMIN);
+
+	printf("Check for RISCV_ZFBFMIN:\t");
+	CHECK_FOR_FLAG(RTE_CPUFLAG_RISCV_ZFBFMIN);
+
+	printf("Check for RISCV_ZCA:\t");
+	CHECK_FOR_FLAG(RTE_CPUFLAG_RISCV_ZCA);
+
+	printf("Check for RISCV_ZCB:\t");
+	CHECK_FOR_FLAG(RTE_CPUFLAG_RISCV_ZCB);
+
+	printf("Check for RISCV_ZCD:\t");
+	CHECK_FOR_FLAG(RTE_CPUFLAG_RISCV_ZCD);
+
+	printf("Check for RISCV_ZCF:\t");
+	CHECK_FOR_FLAG(RTE_CPUFLAG_RISCV_ZCF);
+
+	printf("Check for RISCV_ZCMOP:\t");
+	CHECK_FOR_FLAG(RTE_CPUFLAG_RISCV_ZCMOP);
+
+	printf("Check for RISCV_ZAAMO:\t");
+	CHECK_FOR_FLAG(RTE_CPUFLAG_RISCV_ZAAMO);
+
+	printf("Check for RISCV_ZALRSC:\t");
+	CHECK_FOR_FLAG(RTE_CPUFLAG_RISCV_ZALRSC);
+
+	printf("Check for RISCV_ZABHA:\t");
+	CHECK_FOR_FLAG(RTE_CPUFLAG_RISCV_ZABHA);
+
+	printf("Check for RISCV_ZACAS:\t");
+	CHECK_FOR_FLAG(RTE_CPUFLAG_RISCV_ZACAS);
+
+	printf("Check for RISCV_ZAWRS:\t");
+	CHECK_FOR_FLAG(RTE_CPUFLAG_RISCV_ZAWRS);
+
+	printf("Check for RISCV_ZICOND:\t");
+	CHECK_FOR_FLAG(RTE_CPUFLAG_RISCV_ZICOND);
+
+	printf("Check for RISCV_ZIHINTNTL:\t");
+	CHECK_FOR_FLAG(RTE_CPUFLAG_RISCV_ZIHINTNTL);
+
+	printf("Check for RISCV_ZIHINTPAUSE:\t");
+	CHECK_FOR_FLAG(RTE_CPUFLAG_RISCV_ZIHINTPAUSE);
+
+	printf("Check for RISCV_ZIMOP:\t");
+	CHECK_FOR_FLAG(RTE_CPUFLAG_RISCV_ZIMOP);
+
+	printf("Check for RISCV_ZICNTR:\t");
+	CHECK_FOR_FLAG(RTE_CPUFLAG_RISCV_ZICNTR);
+
+	printf("Check for RISCV_ZIHPM:\t");
+	CHECK_FOR_FLAG(RTE_CPUFLAG_RISCV_ZIHPM);
+
+	printf("Check for RISCV_ZTSO:\t");
+	CHECK_FOR_FLAG(RTE_CPUFLAG_RISCV_ZTSO);
+
+	printf("Check for RISCV_SUPM:\t");
+	CHECK_FOR_FLAG(RTE_CPUFLAG_RISCV_SUPM);
+
+	printf("Check for RISCV_ZVBB:\t");
+	CHECK_FOR_FLAG(RTE_CPUFLAG_RISCV_ZVBB);
+
+	printf("Check for RISCV_ZVBC:\t");
+	CHECK_FOR_FLAG(RTE_CPUFLAG_RISCV_ZVBC);
+
+	printf("Check for RISCV_ZVKB:\t");
+	CHECK_FOR_FLAG(RTE_CPUFLAG_RISCV_ZVKB);
+
+	printf("Check for RISCV_ZVKG:\t");
+	CHECK_FOR_FLAG(RTE_CPUFLAG_RISCV_ZVKG);
+
+	printf("Check for RISCV_ZVKNED:\t");
+	CHECK_FOR_FLAG(RTE_CPUFLAG_RISCV_ZVKNED);
+
+	printf("Check for RISCV_ZVKNHA:\t");
+	CHECK_FOR_FLAG(RTE_CPUFLAG_RISCV_ZVKNHA);
+
+	printf("Check for RISCV_ZVKNHB:\t");
+	CHECK_FOR_FLAG(RTE_CPUFLAG_RISCV_ZVKNHB);
+
+	printf("Check for RISCV_ZVKSED:\t");
+	CHECK_FOR_FLAG(RTE_CPUFLAG_RISCV_ZVKSED);
+
+	printf("Check for RISCV_ZVKSH:\t");
+	CHECK_FOR_FLAG(RTE_CPUFLAG_RISCV_ZVKSH);
+
+	printf("Check for RISCV_ZVKT:\t");
+	CHECK_FOR_FLAG(RTE_CPUFLAG_RISCV_ZVKT);
+
+	printf("Check for RISCV_ZVFH:\t");
+	CHECK_FOR_FLAG(RTE_CPUFLAG_RISCV_ZVFH);
+
+	printf("Check for RISCV_ZVFHMIN:\t");
+	CHECK_FOR_FLAG(RTE_CPUFLAG_RISCV_ZVFHMIN);
+
+	printf("Check for RISCV_ZVFBFMIN:\t");
+	CHECK_FOR_FLAG(RTE_CPUFLAG_RISCV_ZVFBFMIN);
+
+	printf("Check for RISCV_ZVFBFWMA:\t");
+	CHECK_FOR_FLAG(RTE_CPUFLAG_RISCV_ZVFBFWMA);
+
+	printf("Check for RISCV_ZVE32X:\t");
+	CHECK_FOR_FLAG(RTE_CPUFLAG_RISCV_ZVE32X);
+
+	printf("Check for RISCV_ZVE32F:\t");
+	CHECK_FOR_FLAG(RTE_CPUFLAG_RISCV_ZVE32F);
+
+	printf("Check for RISCV_ZVE64X:\t");
+	CHECK_FOR_FLAG(RTE_CPUFLAG_RISCV_ZVE64X);
+
+	printf("Check for RISCV_ZVE64F:\t");
+	CHECK_FOR_FLAG(RTE_CPUFLAG_RISCV_ZVE64F);
+
+	printf("Check for RISCV_ZVE64D:\t");
+	CHECK_FOR_FLAG(RTE_CPUFLAG_RISCV_ZVE64D);
 #endif
 
 #if defined(RTE_ARCH_LOONGARCH)
diff --git a/lib/eal/riscv/include/rte_cpuflags.h b/lib/eal/riscv/include/rte_cpuflags.h
index b1bd7953d4..58477fdb63 100644
--- a/lib/eal/riscv/include/rte_cpuflags.h
+++ b/lib/eal/riscv/include/rte_cpuflags.h
@@ -4,7 +4,6 @@
  * Copyright(c) 2022 SiFive
  * Copyright(c) 2022 Semihalf
  */
-
 #ifndef RTE_CPUFLAGS_RISCV_H
 #define RTE_CPUFLAGS_RISCV_H
 
@@ -12,10 +11,11 @@
  * Enumeration of all CPU features supported
  */
 enum rte_cpu_flag_t {
+	/* Single-letter ISA extensions (detected via AT_HWCAP) */
 	RTE_CPUFLAG_RISCV_ISA_A, /* Atomic */
 	RTE_CPUFLAG_RISCV_ISA_B, /* Bit-Manipulation */
 	RTE_CPUFLAG_RISCV_ISA_C, /* Compressed instruction */
-	RTE_CPUFLAG_RISCV_ISA_D, /* Double precision floating-point  */
+	RTE_CPUFLAG_RISCV_ISA_D, /* Double precision floating-point */
 	RTE_CPUFLAG_RISCV_ISA_E, /* RV32E ISA */
 	RTE_CPUFLAG_RISCV_ISA_F, /* Single precision floating-point */
 	RTE_CPUFLAG_RISCV_ISA_G, /* Extension pack (IMAFD, Zicsr, Zifencei) */
@@ -38,8 +38,81 @@ enum rte_cpu_flag_t {
 	RTE_CPUFLAG_RISCV_ISA_X, /* Non-standard extension present */
 	RTE_CPUFLAG_RISCV_ISA_Y, /* Reserved */
 	RTE_CPUFLAG_RISCV_ISA_Z, /* Reserved */
+
+	/* Z sub-extensions (detected via riscv_hwprobe syscall) */
+
+	/* Bit-manipulation */
+	RTE_CPUFLAG_RISCV_ZBA,      /* Address generation (sh1add/sh2add/sh3add) */
+	RTE_CPUFLAG_RISCV_ZBB,      /* Basic bit-manipulation (clz/ctz/cpop/rev8) */
+	RTE_CPUFLAG_RISCV_ZBC,      /* Carry-less multiply (clmul/clmulh/clmulr) */
+	RTE_CPUFLAG_RISCV_ZBS,      /* Single-bit instructions (bset/bclr/binv/bext) */
+	RTE_CPUFLAG_RISCV_ZBKB,     /* Bit-manipulation for cryptography */
+	RTE_CPUFLAG_RISCV_ZBKC,     /* Carry-less multiply for cryptography */
+	RTE_CPUFLAG_RISCV_ZBKX,     /* Crossbar permutations */
+
+	/* Cache management */
+	RTE_CPUFLAG_RISCV_ZICBOM,   /* Cache-block management operations */
+	RTE_CPUFLAG_RISCV_ZICBOZ,   /* Cache-block zero */
+
+	/* Scalar cryptography */
+	RTE_CPUFLAG_RISCV_ZKND,     /* AES decryption */
+	RTE_CPUFLAG_RISCV_ZKNE,     /* AES encryption */
+	RTE_CPUFLAG_RISCV_ZKNH,     /* SHA-256/512 hash */
+	RTE_CPUFLAG_RISCV_ZKSED,    /* SM4 block cipher */
+	RTE_CPUFLAG_RISCV_ZKSH,     /* SM3 hash */
+	RTE_CPUFLAG_RISCV_ZKT,      /* Data-independent execution latency */
+
+	/* Floating-point */
+	RTE_CPUFLAG_RISCV_ZFA,      /* Additional floating-point instructions */
+	RTE_CPUFLAG_RISCV_ZFH,      /* Half-precision floating-point */
+	RTE_CPUFLAG_RISCV_ZFHMIN,   /* Minimal half-precision floating-point */
+	RTE_CPUFLAG_RISCV_ZFBFMIN,  /* BFloat16 conversions */
+
+	/* Compressed instructions */
+	RTE_CPUFLAG_RISCV_ZCA,      /* Compressed integer instructions */
+	RTE_CPUFLAG_RISCV_ZCB,      /* Additional compressed instructions */
+	RTE_CPUFLAG_RISCV_ZCD,      /* Compressed double-precision float */
+	RTE_CPUFLAG_RISCV_ZCF,      /* Compressed single-precision float */
+	RTE_CPUFLAG_RISCV_ZCMOP,    /* Compressed may-be-operations */
+
+	/* Atomic extensions */
+	RTE_CPUFLAG_RISCV_ZAAMO,    /* Atomic memory operations */
+	RTE_CPUFLAG_RISCV_ZALRSC,   /* Load-reserved/store-conditional */
+	RTE_CPUFLAG_RISCV_ZABHA,    /* Byte/halfword atomics */
+	RTE_CPUFLAG_RISCV_ZACAS,    /* Compare-and-swap */
+
+	/* Hints and misc */
+	RTE_CPUFLAG_RISCV_ZAWRS,    /* Wait-on-reservation-set instructions */
+	RTE_CPUFLAG_RISCV_ZICOND,   /* Integer conditional operations */
+	RTE_CPUFLAG_RISCV_ZIHINTNTL,/* Non-temporal locality hints */
+	RTE_CPUFLAG_RISCV_ZIHINTPAUSE, /* Pause hint */
+	RTE_CPUFLAG_RISCV_ZIMOP,    /* May-be-operations */
+	RTE_CPUFLAG_RISCV_ZICNTR,   /* Base counters and timers */
+	RTE_CPUFLAG_RISCV_ZIHPM,    /* Hardware performance counters */
+	RTE_CPUFLAG_RISCV_ZTSO,     /* Total store ordering */
+	RTE_CPUFLAG_RISCV_SUPM,     /* Pointer masking for U-mode */
+
+	/* Vector sub-extensions */
+	RTE_CPUFLAG_RISCV_ZVBB,     /* Vector bit-manipulation */
+	RTE_CPUFLAG_RISCV_ZVBC,     /* Vector carry-less multiply */
+	RTE_CPUFLAG_RISCV_ZVKB,     /* Vector cryptography bit-manipulation */
+	RTE_CPUFLAG_RISCV_ZVKG,     /* Vector GCM/GMAC */
+	RTE_CPUFLAG_RISCV_ZVKNED,   /* Vector AES block cipher */
+	RTE_CPUFLAG_RISCV_ZVKNHA,   /* Vector SHA-256 */
+	RTE_CPUFLAG_RISCV_ZVKNHB,   /* Vector SHA-512 */
+	RTE_CPUFLAG_RISCV_ZVKSED,   /* Vector SM4 block cipher */
+	RTE_CPUFLAG_RISCV_ZVKSH,    /* Vector SM3 hash */
+	RTE_CPUFLAG_RISCV_ZVKT,     /* Vector data-independent execution latency */
+	RTE_CPUFLAG_RISCV_ZVFH,     /* Vector half-precision float */
+	RTE_CPUFLAG_RISCV_ZVFHMIN,  /* Vector minimal half-precision float */
+	RTE_CPUFLAG_RISCV_ZVFBFMIN, /* Vector BFloat16 conversions */
+	RTE_CPUFLAG_RISCV_ZVFBFWMA, /* Vector BFloat16 widening mul-add */
+	RTE_CPUFLAG_RISCV_ZVE32X,   /* Vector 32-bit integer */
+	RTE_CPUFLAG_RISCV_ZVE32F,   /* Vector 32-bit float */
+	RTE_CPUFLAG_RISCV_ZVE64X,   /* Vector 64-bit integer */
+	RTE_CPUFLAG_RISCV_ZVE64F,   /* Vector 64-bit float */
+	RTE_CPUFLAG_RISCV_ZVE64D,   /* Vector 64-bit double */
 };
 
 #include "generic/rte_cpuflags.h"
-
 #endif /* RTE_CPUFLAGS_RISCV_H */
diff --git a/lib/eal/riscv/rte_cpuflags.c b/lib/eal/riscv/rte_cpuflags.c
index 4dec491b0d..6b79af3d13 100644
--- a/lib/eal/riscv/rte_cpuflags.c
+++ b/lib/eal/riscv/rte_cpuflags.c
@@ -3,7 +3,6 @@
  * Copyright(c) 2022 SiFive
  * Copyright(c) 2022 Semihalf
  */
-
 #include <eal_export.h>
 #include "rte_cpuflags.h"
 
@@ -12,6 +11,8 @@
 #include <assert.h>
 #include <unistd.h>
 #include <string.h>
+#include <sys/syscall.h>
+#include <stdbool.h>
 
 #ifndef AT_HWCAP
 #define AT_HWCAP 16
@@ -25,15 +26,93 @@
 #define AT_PLATFORM 15
 #endif
 
+/*
+ * riscv_hwprobe syscall (Linux 6.4+, syscall number 258).
+ * Allows userspace to query ISA extensions not visible via AT_HWCAP.
+ * See: linux/arch/riscv/include/uapi/asm/hwprobe.h
+ */
+#ifndef __NR_riscv_hwprobe
+#define __NR_riscv_hwprobe 258
+#endif
+
+#ifndef RISCV_HWPROBE_KEY_IMA_EXT_0
+#define RISCV_HWPROBE_KEY_IMA_EXT_0	4
+#endif
+
+/*
+ * Extension bitmasks for RISCV_HWPROBE_KEY_IMA_EXT_0.
+ * Defined here for cross-compilation compatibility; guarded to avoid
+ * conflicts when the system hwprobe.h is available.
+ */
+#ifndef RISCV_HWPROBE_EXT_ZBA
+#define RISCV_HWPROBE_EXT_ZBA		(1ULL << 3)
+#define RISCV_HWPROBE_EXT_ZBB		(1ULL << 4)
+#define RISCV_HWPROBE_EXT_ZBS		(1ULL << 5)
+#define RISCV_HWPROBE_EXT_ZICBOZ	(1ULL << 6)
+#define RISCV_HWPROBE_EXT_ZBC		(1ULL << 7)
+#define RISCV_HWPROBE_EXT_ZBKB		(1ULL << 8)
+#define RISCV_HWPROBE_EXT_ZBKC		(1ULL << 9)
+#define RISCV_HWPROBE_EXT_ZBKX		(1ULL << 10)
+#define RISCV_HWPROBE_EXT_ZKND		(1ULL << 11)
+#define RISCV_HWPROBE_EXT_ZKNE		(1ULL << 12)
+#define RISCV_HWPROBE_EXT_ZKNH		(1ULL << 13)
+#define RISCV_HWPROBE_EXT_ZKSED		(1ULL << 14)
+#define RISCV_HWPROBE_EXT_ZKSH		(1ULL << 15)
+#define RISCV_HWPROBE_EXT_ZKT		(1ULL << 16)
+#define RISCV_HWPROBE_EXT_ZVBB		(1ULL << 17)
+#define RISCV_HWPROBE_EXT_ZVBC		(1ULL << 18)
+#define RISCV_HWPROBE_EXT_ZVKB		(1ULL << 19)
+#define RISCV_HWPROBE_EXT_ZVKG		(1ULL << 20)
+#define RISCV_HWPROBE_EXT_ZVKNED	(1ULL << 21)
+#define RISCV_HWPROBE_EXT_ZVKNHA	(1ULL << 22)
+#define RISCV_HWPROBE_EXT_ZVKNHB	(1ULL << 23)
+#define RISCV_HWPROBE_EXT_ZVKSED	(1ULL << 24)
+#define RISCV_HWPROBE_EXT_ZVKSH		(1ULL << 25)
+#define RISCV_HWPROBE_EXT_ZVKT		(1ULL << 26)
+#define RISCV_HWPROBE_EXT_ZFH		(1ULL << 27)
+#define RISCV_HWPROBE_EXT_ZFHMIN	(1ULL << 28)
+#define RISCV_HWPROBE_EXT_ZIHINTNTL	(1ULL << 29)
+#define RISCV_HWPROBE_EXT_ZVFH		(1ULL << 30)
+#define RISCV_HWPROBE_EXT_ZVFHMIN	(1ULL << 31)
+#define RISCV_HWPROBE_EXT_ZFA		(1ULL << 32)
+#define RISCV_HWPROBE_EXT_ZTSO		(1ULL << 33)
+#define RISCV_HWPROBE_EXT_ZACAS		(1ULL << 34)
+#define RISCV_HWPROBE_EXT_ZICOND	(1ULL << 35)
+#define RISCV_HWPROBE_EXT_ZIHINTPAUSE	(1ULL << 36)
+#define RISCV_HWPROBE_EXT_ZVE32X	(1ULL << 37)
+#define RISCV_HWPROBE_EXT_ZVE32F	(1ULL << 38)
+#define RISCV_HWPROBE_EXT_ZVE64X	(1ULL << 39)
+#define RISCV_HWPROBE_EXT_ZVE64F	(1ULL << 40)
+#define RISCV_HWPROBE_EXT_ZVE64D	(1ULL << 41)
+#define RISCV_HWPROBE_EXT_ZIMOP		(1ULL << 42)
+#define RISCV_HWPROBE_EXT_ZCA		(1ULL << 43)
+#define RISCV_HWPROBE_EXT_ZCB		(1ULL << 44)
+#define RISCV_HWPROBE_EXT_ZCD		(1ULL << 45)
+#define RISCV_HWPROBE_EXT_ZCF		(1ULL << 46)
+#define RISCV_HWPROBE_EXT_ZCMOP		(1ULL << 47)
+#define RISCV_HWPROBE_EXT_ZAWRS		(1ULL << 48)
+#define RISCV_HWPROBE_EXT_SUPM		(1ULL << 49)
+#define RISCV_HWPROBE_EXT_ZICNTR	(1ULL << 50)
+#define RISCV_HWPROBE_EXT_ZIHPM		(1ULL << 51)
+#define RISCV_HWPROBE_EXT_ZFBFMIN	(1ULL << 52)
+#define RISCV_HWPROBE_EXT_ZVFBFMIN	(1ULL << 53)
+#define RISCV_HWPROBE_EXT_ZVFBFWMA	(1ULL << 54)
+#define RISCV_HWPROBE_EXT_ZICBOM	(1ULL << 55)
+#define RISCV_HWPROBE_EXT_ZAAMO		(1ULL << 56)
+#define RISCV_HWPROBE_EXT_ZALRSC	(1ULL << 57)
+#define RISCV_HWPROBE_EXT_ZABHA		(1ULL << 58)
+#endif /* RISCV_HWPROBE_EXT_ZBA */
+
 enum cpu_register_t {
 	REG_NONE = 0,
 	REG_HWCAP,
 	REG_HWCAP2,
 	REG_PLATFORM,
+	REG_HWPROBE_EXT0,  /* riscv_hwprobe RISCV_HWPROBE_KEY_IMA_EXT_0 */
 	REG_MAX
 };
 
-typedef uint32_t hwcap_registers_t[REG_MAX];
+typedef uint64_t hwcap_registers_t[REG_MAX];
 
 /**
  * Struct to hold a processor feature entry
@@ -51,41 +130,162 @@ struct feature_entry {
 typedef Elf64_auxv_t _Elfx_auxv_t;
 
 const struct feature_entry rte_cpu_feature_table[] = {
-	FEAT_DEF(RISCV_ISA_A, REG_HWCAP,    0)
-	FEAT_DEF(RISCV_ISA_B, REG_HWCAP,    1)
-	FEAT_DEF(RISCV_ISA_C, REG_HWCAP,    2)
-	FEAT_DEF(RISCV_ISA_D, REG_HWCAP,    3)
-	FEAT_DEF(RISCV_ISA_E, REG_HWCAP,    4)
-	FEAT_DEF(RISCV_ISA_F, REG_HWCAP,    5)
-	FEAT_DEF(RISCV_ISA_G, REG_HWCAP,    6)
-	FEAT_DEF(RISCV_ISA_H, REG_HWCAP,    7)
-	FEAT_DEF(RISCV_ISA_I, REG_HWCAP,    8)
-	FEAT_DEF(RISCV_ISA_J, REG_HWCAP,    9)
-	FEAT_DEF(RISCV_ISA_K, REG_HWCAP,   10)
-	FEAT_DEF(RISCV_ISA_L, REG_HWCAP,   11)
-	FEAT_DEF(RISCV_ISA_M, REG_HWCAP,   12)
-	FEAT_DEF(RISCV_ISA_N, REG_HWCAP,   13)
-	FEAT_DEF(RISCV_ISA_O, REG_HWCAP,   14)
-	FEAT_DEF(RISCV_ISA_P, REG_HWCAP,   15)
-	FEAT_DEF(RISCV_ISA_Q, REG_HWCAP,   16)
-	FEAT_DEF(RISCV_ISA_R, REG_HWCAP,   17)
-	FEAT_DEF(RISCV_ISA_S, REG_HWCAP,   18)
-	FEAT_DEF(RISCV_ISA_T, REG_HWCAP,   19)
-	FEAT_DEF(RISCV_ISA_U, REG_HWCAP,   20)
-	FEAT_DEF(RISCV_ISA_V, REG_HWCAP,   21)
-	FEAT_DEF(RISCV_ISA_W, REG_HWCAP,   22)
-	FEAT_DEF(RISCV_ISA_X, REG_HWCAP,   23)
-	FEAT_DEF(RISCV_ISA_Y, REG_HWCAP,   24)
-	FEAT_DEF(RISCV_ISA_Z, REG_HWCAP,   25)
+	/* Single-letter ISA extensions via AT_HWCAP */
+	FEAT_DEF(RISCV_ISA_A,  REG_HWCAP,  0)
+	FEAT_DEF(RISCV_ISA_B,  REG_HWCAP,  1)
+	FEAT_DEF(RISCV_ISA_C,  REG_HWCAP,  2)
+	FEAT_DEF(RISCV_ISA_D,  REG_HWCAP,  3)
+	FEAT_DEF(RISCV_ISA_E,  REG_HWCAP,  4)
+	FEAT_DEF(RISCV_ISA_F,  REG_HWCAP,  5)
+	FEAT_DEF(RISCV_ISA_G,  REG_HWCAP,  6)
+	FEAT_DEF(RISCV_ISA_H,  REG_HWCAP,  7)
+	FEAT_DEF(RISCV_ISA_I,  REG_HWCAP,  8)
+	FEAT_DEF(RISCV_ISA_J,  REG_HWCAP,  9)
+	FEAT_DEF(RISCV_ISA_K,  REG_HWCAP, 10)
+	FEAT_DEF(RISCV_ISA_L,  REG_HWCAP, 11)
+	FEAT_DEF(RISCV_ISA_M,  REG_HWCAP, 12)
+	FEAT_DEF(RISCV_ISA_N,  REG_HWCAP, 13)
+	FEAT_DEF(RISCV_ISA_O,  REG_HWCAP, 14)
+	FEAT_DEF(RISCV_ISA_P,  REG_HWCAP, 15)
+	FEAT_DEF(RISCV_ISA_Q,  REG_HWCAP, 16)
+	FEAT_DEF(RISCV_ISA_R,  REG_HWCAP, 17)
+	FEAT_DEF(RISCV_ISA_S,  REG_HWCAP, 18)
+	FEAT_DEF(RISCV_ISA_T,  REG_HWCAP, 19)
+	FEAT_DEF(RISCV_ISA_U,  REG_HWCAP, 20)
+	FEAT_DEF(RISCV_ISA_V,  REG_HWCAP, 21)
+	FEAT_DEF(RISCV_ISA_W,  REG_HWCAP, 22)
+	FEAT_DEF(RISCV_ISA_X,  REG_HWCAP, 23)
+	FEAT_DEF(RISCV_ISA_Y,  REG_HWCAP, 24)
+	FEAT_DEF(RISCV_ISA_Z,  REG_HWCAP, 25)
+
+	/* Z sub-extensions via riscv_hwprobe syscall */
+
+	/* Bit-manipulation */
+	FEAT_DEF(RISCV_ZBA, REG_HWPROBE_EXT0, __builtin_ctzll(RISCV_HWPROBE_EXT_ZBA))
+	FEAT_DEF(RISCV_ZBB, REG_HWPROBE_EXT0, __builtin_ctzll(RISCV_HWPROBE_EXT_ZBB))
+	FEAT_DEF(RISCV_ZBC, REG_HWPROBE_EXT0, __builtin_ctzll(RISCV_HWPROBE_EXT_ZBC))
+	FEAT_DEF(RISCV_ZBS, REG_HWPROBE_EXT0, __builtin_ctzll(RISCV_HWPROBE_EXT_ZBS))
+	FEAT_DEF(RISCV_ZBKB, REG_HWPROBE_EXT0, __builtin_ctzll(RISCV_HWPROBE_EXT_ZBKB))
+	FEAT_DEF(RISCV_ZBKC, REG_HWPROBE_EXT0, __builtin_ctzll(RISCV_HWPROBE_EXT_ZBKC))
+	FEAT_DEF(RISCV_ZBKX, REG_HWPROBE_EXT0, __builtin_ctzll(RISCV_HWPROBE_EXT_ZBKX))
+
+	/* Cache management */
+	FEAT_DEF(RISCV_ZICBOM, REG_HWPROBE_EXT0, __builtin_ctzll(RISCV_HWPROBE_EXT_ZICBOM))
+	FEAT_DEF(RISCV_ZICBOZ, REG_HWPROBE_EXT0, __builtin_ctzll(RISCV_HWPROBE_EXT_ZICBOZ))
+
+	/* Scalar cryptography */
+	FEAT_DEF(RISCV_ZKND, REG_HWPROBE_EXT0, __builtin_ctzll(RISCV_HWPROBE_EXT_ZKND))
+	FEAT_DEF(RISCV_ZKNE, REG_HWPROBE_EXT0, __builtin_ctzll(RISCV_HWPROBE_EXT_ZKNE))
+	FEAT_DEF(RISCV_ZKNH, REG_HWPROBE_EXT0, __builtin_ctzll(RISCV_HWPROBE_EXT_ZKNH))
+	FEAT_DEF(RISCV_ZKSED, REG_HWPROBE_EXT0, __builtin_ctzll(RISCV_HWPROBE_EXT_ZKSED))
+	FEAT_DEF(RISCV_ZKSH, REG_HWPROBE_EXT0, __builtin_ctzll(RISCV_HWPROBE_EXT_ZKSH))
+	FEAT_DEF(RISCV_ZKT, REG_HWPROBE_EXT0, __builtin_ctzll(RISCV_HWPROBE_EXT_ZKT))
+
+	/* Floating-point */
+	FEAT_DEF(RISCV_ZFA, REG_HWPROBE_EXT0, __builtin_ctzll(RISCV_HWPROBE_EXT_ZFA))
+	FEAT_DEF(RISCV_ZFH, REG_HWPROBE_EXT0, __builtin_ctzll(RISCV_HWPROBE_EXT_ZFH))
+	FEAT_DEF(RISCV_ZFHMIN, REG_HWPROBE_EXT0, __builtin_ctzll(RISCV_HWPROBE_EXT_ZFHMIN))
+	FEAT_DEF(RISCV_ZFBFMIN, REG_HWPROBE_EXT0, __builtin_ctzll(RISCV_HWPROBE_EXT_ZFBFMIN))
+
+	/* Compressed instructions */
+	FEAT_DEF(RISCV_ZCA, REG_HWPROBE_EXT0, __builtin_ctzll(RISCV_HWPROBE_EXT_ZCA))
+	FEAT_DEF(RISCV_ZCB, REG_HWPROBE_EXT0, __builtin_ctzll(RISCV_HWPROBE_EXT_ZCB))
+	FEAT_DEF(RISCV_ZCD, REG_HWPROBE_EXT0, __builtin_ctzll(RISCV_HWPROBE_EXT_ZCD))
+	FEAT_DEF(RISCV_ZCF, REG_HWPROBE_EXT0, __builtin_ctzll(RISCV_HWPROBE_EXT_ZCF))
+	FEAT_DEF(RISCV_ZCMOP, REG_HWPROBE_EXT0, __builtin_ctzll(RISCV_HWPROBE_EXT_ZCMOP))
+
+	/* Atomic extensions */
+	FEAT_DEF(RISCV_ZAAMO, REG_HWPROBE_EXT0, __builtin_ctzll(RISCV_HWPROBE_EXT_ZAAMO))
+	FEAT_DEF(RISCV_ZALRSC, REG_HWPROBE_EXT0, __builtin_ctzll(RISCV_HWPROBE_EXT_ZALRSC))
+	FEAT_DEF(RISCV_ZABHA, REG_HWPROBE_EXT0, __builtin_ctzll(RISCV_HWPROBE_EXT_ZABHA))
+	FEAT_DEF(RISCV_ZACAS, REG_HWPROBE_EXT0, __builtin_ctzll(RISCV_HWPROBE_EXT_ZACAS))
+
+	/* Hints and misc */
+	FEAT_DEF(RISCV_ZAWRS, REG_HWPROBE_EXT0, __builtin_ctzll(RISCV_HWPROBE_EXT_ZAWRS))
+	FEAT_DEF(RISCV_ZICOND, REG_HWPROBE_EXT0, __builtin_ctzll(RISCV_HWPROBE_EXT_ZICOND))
+	FEAT_DEF(RISCV_ZIHINTNTL, REG_HWPROBE_EXT0, __builtin_ctzll(RISCV_HWPROBE_EXT_ZIHINTNTL))
+	FEAT_DEF(RISCV_ZIHINTPAUSE, REG_HWPROBE_EXT0,
+		__builtin_ctzll(RISCV_HWPROBE_EXT_ZIHINTPAUSE))
+	FEAT_DEF(RISCV_ZIMOP, REG_HWPROBE_EXT0, __builtin_ctzll(RISCV_HWPROBE_EXT_ZIMOP))
+	FEAT_DEF(RISCV_ZICNTR, REG_HWPROBE_EXT0, __builtin_ctzll(RISCV_HWPROBE_EXT_ZICNTR))
+	FEAT_DEF(RISCV_ZIHPM, REG_HWPROBE_EXT0, __builtin_ctzll(RISCV_HWPROBE_EXT_ZIHPM))
+	FEAT_DEF(RISCV_ZTSO, REG_HWPROBE_EXT0, __builtin_ctzll(RISCV_HWPROBE_EXT_ZTSO))
+	FEAT_DEF(RISCV_SUPM, REG_HWPROBE_EXT0, __builtin_ctzll(RISCV_HWPROBE_EXT_SUPM))
+
+	/* Vector sub-extensions */
+	FEAT_DEF(RISCV_ZVBB, REG_HWPROBE_EXT0, __builtin_ctzll(RISCV_HWPROBE_EXT_ZVBB))
+	FEAT_DEF(RISCV_ZVBC, REG_HWPROBE_EXT0, __builtin_ctzll(RISCV_HWPROBE_EXT_ZVBC))
+	FEAT_DEF(RISCV_ZVKB, REG_HWPROBE_EXT0, __builtin_ctzll(RISCV_HWPROBE_EXT_ZVKB))
+	FEAT_DEF(RISCV_ZVKG, REG_HWPROBE_EXT0, __builtin_ctzll(RISCV_HWPROBE_EXT_ZVKG))
+	FEAT_DEF(RISCV_ZVKNED, REG_HWPROBE_EXT0, __builtin_ctzll(RISCV_HWPROBE_EXT_ZVKNED))
+	FEAT_DEF(RISCV_ZVKNHA, REG_HWPROBE_EXT0, __builtin_ctzll(RISCV_HWPROBE_EXT_ZVKNHA))
+	FEAT_DEF(RISCV_ZVKNHB, REG_HWPROBE_EXT0, __builtin_ctzll(RISCV_HWPROBE_EXT_ZVKNHB))
+	FEAT_DEF(RISCV_ZVKSED, REG_HWPROBE_EXT0, __builtin_ctzll(RISCV_HWPROBE_EXT_ZVKSED))
+	FEAT_DEF(RISCV_ZVKSH, REG_HWPROBE_EXT0, __builtin_ctzll(RISCV_HWPROBE_EXT_ZVKSH))
+	FEAT_DEF(RISCV_ZVKT, REG_HWPROBE_EXT0, __builtin_ctzll(RISCV_HWPROBE_EXT_ZVKT))
+	FEAT_DEF(RISCV_ZVFH, REG_HWPROBE_EXT0, __builtin_ctzll(RISCV_HWPROBE_EXT_ZVFH))
+	FEAT_DEF(RISCV_ZVFHMIN, REG_HWPROBE_EXT0, __builtin_ctzll(RISCV_HWPROBE_EXT_ZVFHMIN))
+	FEAT_DEF(RISCV_ZVFBFMIN, REG_HWPROBE_EXT0, __builtin_ctzll(RISCV_HWPROBE_EXT_ZVFBFMIN))
+	FEAT_DEF(RISCV_ZVFBFWMA, REG_HWPROBE_EXT0, __builtin_ctzll(RISCV_HWPROBE_EXT_ZVFBFWMA))
+	FEAT_DEF(RISCV_ZVE32X, REG_HWPROBE_EXT0, __builtin_ctzll(RISCV_HWPROBE_EXT_ZVE32X))
+	FEAT_DEF(RISCV_ZVE32F, REG_HWPROBE_EXT0, __builtin_ctzll(RISCV_HWPROBE_EXT_ZVE32F))
+	FEAT_DEF(RISCV_ZVE64X, REG_HWPROBE_EXT0, __builtin_ctzll(RISCV_HWPROBE_EXT_ZVE64X))
+	FEAT_DEF(RISCV_ZVE64F, REG_HWPROBE_EXT0, __builtin_ctzll(RISCV_HWPROBE_EXT_ZVE64F))
+	FEAT_DEF(RISCV_ZVE64D, REG_HWPROBE_EXT0, __builtin_ctzll(RISCV_HWPROBE_EXT_ZVE64D))
 };
+
+/*
+ * Cache for riscv_hwprobe result. hwprobe is a syscall (unlike getauxval
+ * which reads in-process memory), so we call it once at startup and cache
+ * the result here.
+ */
+static uint64_t hwprobe_ext0_value;
+static bool hwprobe_ext0_valid;
+
+/*
+ * Minimal struct matching the kernel's riscv_hwprobe layout.
+ * Defined locally for cross-compilation compatibility.
+ */
+struct rte_riscv_hwprobe {
+	int64_t  key;
+	uint64_t value;
+};
+
+/*
+ * Call riscv_hwprobe syscall to query ISA extensions.
+ * cpusetsize=0, cpus=NULL means: query all CPUs, return intersection.
+ * Silently fails on kernels < 6.4 (returns -ENOSYS); all Z sub-extension
+ * flags will report unsupported in that case.
+ */
+static void
+riscv_hwprobe_init(void)
+{
+	struct rte_riscv_hwprobe pairs[1] = {
+		{ .key = RISCV_HWPROBE_KEY_IMA_EXT_0, .value = 0 },
+	};
+	long ret;
+
+	ret = syscall(__NR_riscv_hwprobe, pairs, 1, 0, NULL, 0);
+	if (ret == 0 && pairs[0].key >= 0) {
+		hwprobe_ext0_value = pairs[0].value;
+		hwprobe_ext0_valid = true;
+	}
+}
+
+RTE_INIT(riscv_cpu_init)
+{
+	riscv_hwprobe_init();
+}
+
 /*
- * Read AUXV software register and get cpu features for ARM
+ * Read all CPU feature sources into the registers array.
  */
 static void
 rte_cpu_get_features(hwcap_registers_t out)
 {
-	out[REG_HWCAP] = rte_cpu_getauxval(AT_HWCAP);
-	out[REG_HWCAP2] = rte_cpu_getauxval(AT_HWCAP2);
+	out[REG_HWCAP]        = rte_cpu_getauxval(AT_HWCAP);
+	out[REG_HWCAP2]       = rte_cpu_getauxval(AT_HWCAP2);
+	out[REG_HWPROBE_EXT0] = hwprobe_ext0_valid ? hwprobe_ext0_value : 0;
 }
 
 /*
-- 
2.43.0

