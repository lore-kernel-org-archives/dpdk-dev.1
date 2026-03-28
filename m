Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B57110BA423
	for <dpdk-dev@archiver.kernel.org>; Sat, 28 Mar 2026 18:55:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7B6A54021F;
	Sat, 28 Mar 2026 19:55:05 +0100 (CET)
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com
 [209.85.216.67]) by mails.dpdk.org (Postfix) with ESMTP id F36E1400D6
 for <dev@dpdk.org>; Sat, 28 Mar 2026 19:55:04 +0100 (CET)
Received: by mail-pj1-f67.google.com with SMTP id
 98e67ed59e1d1-35c124d2613so2147341a91.2
 for <dev@dpdk.org>; Sat, 28 Mar 2026 11:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774724104; x=1775328904; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l8G2faP2Ugaom2hQ4wf3XOV/FhdyFdn5yfyzCXyG3K4=;
 b=HkRZr+7xjJOnB3rQSUaIDn6+f88mI3MlF0b0heRGtXRpjQ5+cOQKpu2kGn1oW1fWLx
 Ttty7OQCi8L2FNK/Ae1vQIIsGzNnySMhpyhj6/YT9I91M2tv1R6O2+aD/I4qutZDG6Ci
 C71PF7th40alroM7AWgWecWFeJoyYJJIS9jn7VjjneywFM9v2PcGJs2qojdcQJhy51A5
 3hQtp4pZMF0DXQYf9V42a1toDqf5S/aDijX2kfX3fYEDtyHvWpel1VhA7i/Ra40YvRQq
 tSkQ/CfghaAczdvOIWSlA1hyxgsnsEIr3+3OCWOgLN9C8UxU9iN6ebOBCNELBdZubdWH
 xqXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774724104; x=1775328904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l8G2faP2Ugaom2hQ4wf3XOV/FhdyFdn5yfyzCXyG3K4=;
 b=jMdehUHBRr63+kU+/5bPkLG9VaQpd8QvuVxPR7XC6nHJsDVOPSn+d4MPz2Wm8/VUoP
 07/PXCYK6hS4FJAfF3YlZUMVUfQjPrhjUYPu9It1VV+cX1NVclT2sQezjz0ijogLuwsm
 waFlashIirLFOCPrDwnPjbs1UJkjJkUegc5VdrXxWlGGguDZibKK1eNGMoDohEuix874
 cfLJ+hlD3siJEXKpAh+ChZFQWrKhHNqt67OEcbWlPpBCh4gt4UELlNVj7fLz2P7xvemD
 J02T3xLlMcZfzFcAJ4snM+k4zNmmrsCVFAPHDWZvYnSUXndyAM4q9BJyMXzUbeUL5Fi+
 C9IQ==
X-Gm-Message-State: AOJu0YxVPRoQHliNLwPLnc0wjNMszWRmJg5uICY5z+caoxDw5jhlF+dO
 LEZWJ7oUZbi2k8WELEtsq3Jvx0YNeRqtOI2fjuJyixlsoTah+mBpk13HNTOfBA+C4xeSug==
X-Gm-Gg: ATEYQzwoOxXsNVs0nu2uQmT4RuCnSVod5RWaixSNFRVCzBNNMrpUBEnkyDn3GUPt4C9
 LN+jtE3fCT5OjFwoR8kQu8lHaT6cvyDV7y8gheyjRNod01uv9T0RETHoKzY/868bITcoisJb+a3
 ItvW5+2abE+XqhDDx+oJeI4SxVnIXoTNHZHW+xfRKhPf5h3oxxZncfMJwe6qnu9WTIetcMu3Nbs
 mTC56hJbXTvvJpMzJJSHiqarAewXIxItJUIJWiRtwI0pIO+AEPn4EZKrqTQUqsgnohVthCsAZIA
 N0jMBMFdheTtngRUEL09WUplu2U7Qe5Mt91puuNPSsEynmJlGqB8JsdMwR14vdTT1e0w2eJ9vO+
 HS2pzHPzTkVlvVJZBn1JbIpI99JyCHwYiUUMtiaSUWxBmUA0igAptvMHJpijoOcROHLiDYJihVU
 m408J8rz7zOTfHjbvtyp6wOBCnfoMvoZteuW/0vg==
X-Received: by 2002:a17:90b:4cc6:b0:34c:fe7e:84fe with SMTP id
 98e67ed59e1d1-35c3011512cmr6460001a91.28.1774724103711; 
 Sat, 28 Mar 2026 11:55:03 -0700 (PDT)
Received: from LAPTOP-GPQVQV7E ([2409:8a20:f61:a30:b9db:8230:1cc:4f69])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35c22db12f7sm8138126a91.13.2026.03.28.11.55.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Mar 2026 11:55:03 -0700 (PDT)
From: dangshiwei <1138222970gg@gmail.com>
To: dev@dpdk.org
Cc: stanislaw.kardach@gmail.com, sunyuechi@iscas.ac.cn, thomas@monjalon.net,
 dangshiwei <1138222970gg@gmail.com>
Subject: [PATCH v2 2/3] eal/riscv: add RISC-V specific I/O device memory
 operations
Date: Sun, 29 Mar 2026 02:54:57 +0800
Message-ID: <20260328185457.960-1-1138222970gg@gmail.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20260313140836.3847-1-1138222970gg@gmail.com>
References: <20260313140836.3847-1-1138222970gg@gmail.com>
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

Signed-off-by: Dang Shiwei <1138222970gg@gmail.com>
---
 lib/eal/riscv/include/rte_io.h | 152 ++++++++++++++++++++++++++++++++-
 1 file changed, 149 insertions(+), 3 deletions(-)

diff --git a/lib/eal/riscv/include/rte_io.h b/lib/eal/riscv/include/rte_io.h
index 4ae1f087ba..e67b5c1c9c 100644
--- a/lib/eal/riscv/include/rte_io.h
+++ b/lib/eal/riscv/include/rte_io.h
@@ -5,9 +5,155 @@
  * Copyright(c) 2022 Semihalf
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
+static __rte_always_inline uint8_t
+rte_read8_relaxed(const volatile void *addr)
+{
+	uint8_t val;
+	asm volatile("lbu %0, 0(%1)" : "=r"(val) : "r"(addr));
+	return val;
+}
+
+static __rte_always_inline uint16_t
+rte_read16_relaxed(const volatile void *addr)
+{
+	uint16_t val;
+	asm volatile("lhu %0, 0(%1)" : "=r"(val) : "r"(addr));
+	return val;
+}
+
+static __rte_always_inline uint32_t
+rte_read32_relaxed(const volatile void *addr)
+{
+	uint32_t val;
+	asm volatile("lwu %0, 0(%1)" : "=r"(val) : "r"(addr));
+	return val;
+}
+
+static __rte_always_inline uint64_t
+rte_read64_relaxed(const volatile void *addr)
+{
+	uint64_t val;
+	asm volatile("ld %0, 0(%1)" : "=r"(val) : "r"(addr));
+	return val;
+}
+
+static __rte_always_inline void
+rte_write8_relaxed(uint8_t val, volatile void *addr)
+{
+	asm volatile("sb %1, 0(%0)" : : "r"(addr), "r"(val));
+}
+
+static __rte_always_inline void
+rte_write16_relaxed(uint16_t val, volatile void *addr)
+{
+	asm volatile("sh %1, 0(%0)" : : "r"(addr), "r"(val));
+}
+
+static __rte_always_inline void
+rte_write32_relaxed(uint32_t val, volatile void *addr)
+{
+	asm volatile("sw %1, 0(%0)" : : "r"(addr), "r"(val));
+}
+
+static __rte_always_inline void
+rte_write64_relaxed(uint64_t val, volatile void *addr)
+{
+	asm volatile("sd %1, 0(%0)" : : "r"(addr), "r"(val));
+}
+
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
+static __rte_always_inline uint64_t
+rte_read64(const volatile void *addr)
+{
+	uint64_t val = rte_read64_relaxed(addr);
+	rte_io_rmb();
+	return val;
+}
+
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
+static __rte_always_inline void
+rte_write64(uint64_t val, volatile void *addr)
+{
+	rte_io_wmb();
+	rte_write64_relaxed(val, addr);
+}
+
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

