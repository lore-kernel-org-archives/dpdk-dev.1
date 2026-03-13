Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D335B105F7AE
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Mar 2026 14:08:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D7CD840279;
	Fri, 13 Mar 2026 15:08:47 +0100 (CET)
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com
 [209.85.216.66]) by mails.dpdk.org (Postfix) with ESMTP id 6B3144026C
 for <dev@dpdk.org>; Fri, 13 Mar 2026 15:08:46 +0100 (CET)
Received: by mail-pj1-f66.google.com with SMTP id
 98e67ed59e1d1-359832fc558so1886915a91.0
 for <dev@dpdk.org>; Fri, 13 Mar 2026 07:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773410925; x=1774015725; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VXs78/zzacCqKW1/Dz5WTr1PxZ8XsN0hMpGfyoQSkVY=;
 b=T4DKktI/g4GC2Nk3/9ZIop8Ltu5IdqhlL84MiF984OAqfr8VN82xNVYcoBS5XK3hb0
 MZOG5YUBiRJtgSdf3WWMLC6bGsbC5KEq3ztSzAEugsReo3zlMCDod86sKpMfyOlRbHEN
 s8qitVk8Xa3eiPjxnzM72DOH7vxhvxHEju+rOVe16qCN0rMFwikeeizcIMDerkNZdOPM
 3qx+b751XSpIj5k96bs7hJnP+WE4Tnb8bM0M82bUBg19XmFAUVrCmB2vttH4TSIRIZDr
 wkTllQ6LqncRoESqA1Yxlm5djpDhlv0/KDKEVqfwCTkw/rbGOTWz6GQOUtpToacx05rw
 bkoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773410925; x=1774015725;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VXs78/zzacCqKW1/Dz5WTr1PxZ8XsN0hMpGfyoQSkVY=;
 b=WsiAGwoQRMal5R2D71sU3TBfUDvHQ4qZu7huhMS1dVdsGAjeUP2hnS6DRJczqL1lsB
 4bPH+XAUrl0oxEoMKiOTwcAM3F83MjB8MbfuhYf6qdOETEhAVaWTs58WEbXkx28oe9+M
 N7FV2lpkqiP9OUgQhJ1Ldi6whP6Wc6hdRZkCPEi4ddIw92yXTrWqJx07dLISTj8ixmEi
 FTNcFWfQtfF1eEMXd5iu30vYckGK8d5PnRSY2dN+rMpMp6y4+9JVZRmS9gAabbAm/OYM
 miXms1yXndXNeBC8j4g81VzzkZMXtjFIXyHBn2I9kBdsw4nxtorKLhwb5ccAnKexDvxp
 Evzw==
X-Gm-Message-State: AOJu0YzDJEGZrccgI8Yv4Lypr37oTQSBHqF/nsQ+qCOx+NqYfHeJ7zSX
 WYFkammkA2BoVqo5Xo5AW4geZCIpLqEznKhNNtPjrljixtmmLQ3VducKN3rNDZeujVe3C8A4Igw
 =
X-Gm-Gg: ATEYQzzwZesyIzCd3JsZ/9RW7z4qn76zT2V7O1VEk4BJPE/xCCh/EBYvlGeEE1EBt8B
 /L2FKNBemO5QfFe9OrMx6/826oT8NBcgo/nkdglVLlj6UgravewzPuZcmsBRKD40P6kqcvkBSkx
 8bxcEwjEqCLz+gsSDsgS++oldSM23ca/YQg2fIGCKcy9GbE4RxpI0e3XCvCiHjeLzPD+GmkY70k
 6kj94ScP7mN94dVty/msAqtGDrVTUwL88OC/YyFQFnD5/1ef3ilYSzzreKrk0ks7GgVMzWTLI4l
 ShN6OVJrhVIarRkrUkiJgMkZI+uvz6pIZkC1fbzXNZVOgOBFx4GYqval7BnVF19XnDwGN2Mbc1v
 bEYBG3MYMKpSWbAKdFa1bktllI6VG0Dqnw6U51jYSJhNohWNBnsKgmcdRn5hF8D2AOi0FxXvRCD
 9XE0lEg8fAjTDMYRRi4URLfR/IWF5bLzGHXqTjpSxrIOSCsmd3DA==
X-Received: by 2002:a17:90a:d006:b0:359:8e1c:53e with SMTP id
 98e67ed59e1d1-35a220b54d6mr3140669a91.31.1773410924967; 
 Fri, 13 Mar 2026 07:08:44 -0700 (PDT)
Received: from localhost.localdomain ([112.1.32.68])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35a02fc9454sm9167075a91.12.2026.03.13.07.08.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 07:08:44 -0700 (PDT)
From: dangshiwei <1138222970gg@gmail.com>
To: dev@dpdk.org
Cc: stanislaw.kardach@gmail.com, sunyuechi@iscas.ac.cn, thomas@monjalon.net,
 dangshiwei <1138222970gg@gmail.com>
Subject: [PATCH] eal/riscv: add RISC-V specific I/O device memory operations
Date: Fri, 13 Mar 2026 22:08:35 +0800
Message-ID: <20260313140836.3847-1-1138222970gg@gmail.com>
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

The current rte_io.h for RISC-V only includes generic/rte_io.h,
which uses volatile pointer casts for MMIO read/write. While this
prevents compiler optimizations, it does not prevent CPU-level
reordering on RISC-V, which is a weak-ordered architecture.

This patch adds a RISC-V specific implementation using explicit
load/store instructions:
- lbu/lhu/lwu/ld for reads (zero-extending to avoid sign-bit pollution)
- sb/sh/sw/sd for writes
- lwu is used for 32-bit reads on RV64 for correct zero-extension;
  lw is used on RV32 where it is naturally full-width
- 64-bit operations are guarded with RTE_ARCH_64 for RV32 compatibility

The "memory" clobber is retained in relaxed variants to prevent the
compiler from reordering these accesses with respect to other memory
operations, while still omitting the hardware fence instructions.
Unlike ARM64 which is a strong-ordered architecture, this additional
constraint is necessary on RISC-V.

Signed-off-by: dangshiwei <1138222970gg@gmail.com>
---
 lib/eal/riscv/include/rte_io.h | 185 ++++++++++++++++++++++++++++++++-
 1 file changed, 182 insertions(+), 3 deletions(-)

diff --git a/lib/eal/riscv/include/rte_io.h b/lib/eal/riscv/include/rte_io.h
index 4ae1f087ba..ffb6dcad68 100644
--- a/lib/eal/riscv/include/rte_io.h
+++ b/lib/eal/riscv/include/rte_io.h
@@ -3,11 +3,190 @@
  * Copyright(c) 2022 StarFive
  * Copyright(c) 2022 SiFive
  * Copyright(c) 2022 Semihalf
+ * Copyright(c) 2026 Dangshiwei
  */
 
-#ifndef RTE_IO_RISCV_H
-#define RTE_IO_RISCV_H
+#ifndef _RTE_IO_RISCV_H_
+#define _RTE_IO_RISCV_H_
+
+#include <stdint.h>
+
+#define RTE_OVERRIDE_IO_H
 
 #include "generic/rte_io.h"
+#include <rte_compat.h>
+#include "rte_atomic.h"
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/*
+ * Unlike ARM64 which is a strong-ordered architecture, RISC-V is a
+ * weak-ordered architecture. The "memory" clobber is added to the relaxed
+ * variants to prevent the compiler from reordering these accesses with
+ * respect to other memory operations, while still omitting the hardware
+ * fence instructions.
+ */
+
+/* relaxed read */
+
+static __rte_always_inline uint8_t
+rte_read8_relaxed(const volatile void *addr)
+{
+	uint8_t val;
+	asm volatile("lbu %0, 0(%1)" : "=r"(val) : "r"(addr) : "memory");
+	return val;
+}
+
+static __rte_always_inline uint16_t
+rte_read16_relaxed(const volatile void *addr)
+{
+	uint16_t val;
+	asm volatile("lhu %0, 0(%1)" : "=r"(val) : "r"(addr) : "memory");
+	return val;
+}
+
+static __rte_always_inline uint32_t
+rte_read32_relaxed(const volatile void *addr)
+{
+	uint32_t val;
+#ifdef RTE_ARCH_64
+	/* lwu is RV64-only: zero-extends to avoid sign-bit pollution */
+	asm volatile("lwu %0, 0(%1)" : "=r"(val) : "r"(addr) : "memory");
+#else
+	/* on RV32, lw is full-width, no extension needed */
+	asm volatile("lw %0, 0(%1)" : "=r"(val) : "r"(addr) : "memory");
+#endif
+	return val;
+}
+
+#ifdef RTE_ARCH_64
+static __rte_always_inline uint64_t
+rte_read64_relaxed(const volatile void *addr)
+{
+	uint64_t val;
+	asm volatile("ld %0, 0(%1)" : "=r"(val) : "r"(addr) : "memory");
+	return val;
+}
+#endif
+
+/* relaxed write */
+
+static __rte_always_inline void
+rte_write8_relaxed(uint8_t val, volatile void *addr)
+{
+	asm volatile("sb %1, 0(%0)" : : "r"(addr), "r"(val) : "memory");
+}
+
+static __rte_always_inline void
+rte_write16_relaxed(uint16_t val, volatile void *addr)
+{
+	asm volatile("sh %1, 0(%0)" : : "r"(addr), "r"(val) : "memory");
+}
+
+static __rte_always_inline void
+rte_write32_relaxed(uint32_t val, volatile void *addr)
+{
+	asm volatile("sw %1, 0(%0)" : : "r"(addr), "r"(val) : "memory");
+}
+
+#ifdef RTE_ARCH_64
+static __rte_always_inline void
+rte_write64_relaxed(uint64_t val, volatile void *addr)
+{
+	asm volatile("sd %1, 0(%0)" : : "r"(addr), "r"(val) : "memory");
+}
+#endif
+
+/* read with I/O memory barrier */
+
+static __rte_always_inline uint8_t
+rte_read8(const volatile void *addr)
+{
+	uint8_t val = rte_read8_relaxed(addr);
+	rte_io_rmb();
+	return val;
+}
+
+static __rte_always_inline uint16_t
+rte_read16(const volatile void *addr)
+{
+	uint16_t val = rte_read16_relaxed(addr);
+	rte_io_rmb();
+	return val;
+}
+
+static __rte_always_inline uint32_t
+rte_read32(const volatile void *addr)
+{
+	uint32_t val = rte_read32_relaxed(addr);
+	rte_io_rmb();
+	return val;
+}
+
+#ifdef RTE_ARCH_64
+static __rte_always_inline uint64_t
+rte_read64(const volatile void *addr)
+{
+	uint64_t val = rte_read64_relaxed(addr);
+	rte_io_rmb();
+	return val;
+}
+#endif
+
+/* write with I/O memory barrier */
+
+static __rte_always_inline void
+rte_write8(uint8_t val, volatile void *addr)
+{
+	rte_io_wmb();
+	rte_write8_relaxed(val, addr);
+}
+
+static __rte_always_inline void
+rte_write16(uint16_t val, volatile void *addr)
+{
+	rte_io_wmb();
+	rte_write16_relaxed(val, addr);
+}
+
+static __rte_always_inline void
+rte_write32(uint32_t val, volatile void *addr)
+{
+	rte_io_wmb();
+	rte_write32_relaxed(val, addr);
+}
+
+#ifdef RTE_ARCH_64
+static __rte_always_inline void
+rte_write64(uint64_t val, volatile void *addr)
+{
+	rte_io_wmb();
+	rte_write64_relaxed(val, addr);
+}
+#endif
+
+/*
+ * RISC-V currently has no write-combining store instructions.
+ * Fall back to normal write.
+ */
+__rte_experimental
+static __rte_always_inline void
+rte_write32_wc(uint32_t val, volatile void *addr)
+{
+	rte_write32(val, addr);
+}
+
+__rte_experimental
+static __rte_always_inline void
+rte_write32_wc_relaxed(uint32_t val, volatile void *addr)
+{
+	rte_write32_relaxed(val, addr);
+}
+
+#ifdef __cplusplus
+}
+#endif
 
-#endif /* RTE_IO_RISCV_H */
+#endif /* _RTE_IO_RISCV_H_ */
-- 
2.43.0

