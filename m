Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B429BE9A03E
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 10:19:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB595402C5;
	Wed, 18 Feb 2026 11:19:24 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id DFF88402A3
 for <dev@dpdk.org>; Wed, 18 Feb 2026 11:19:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771409963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mFGVbudX2KeuWRLx49fZjxWJOq3N4RtztniCJovJItg=;
 b=dlJFA1w9vbTXhWL1gRsUo+QR/jaA5D8NiQB32H4ge9nU5ZlhQASLw/NzDSSixdQ3hv4WSJ
 4s8muuHuo16ZBqmcgLuO7N5kjMynqkcPcZVmmIxTRLPNqU0g6uvWRcnEoPfN/GWLX+X8ws
 cb2DCsaRs4M5pxhjMsWuGMkeJ9AQm7g=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-167-8IIBqbhGN_-o67pAcAtTqA-1; Wed,
 18 Feb 2026 05:19:21 -0500
X-MC-Unique: 8IIBqbhGN_-o67pAcAtTqA-1
X-Mimecast-MFC-AGG-ID: 8IIBqbhGN_-o67pAcAtTqA_1771409961
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 147B9180025C
 for <dev@dpdk.org>; Wed, 18 Feb 2026 10:19:21 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.225.11])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4BF1A30001A5
 for <dev@dpdk.org>; Wed, 18 Feb 2026 10:19:20 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Subject: [PATCH] eal/linux: fix HPET symbols export
Date: Wed, 18 Feb 2026 11:18:59 +0100
Message-ID: <20260218101859.3028581-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6x96Tq16nQRhUzCEfNA4aJOOOwKfkhkO8woo-T-upII_1771409961
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

The .map generation script has no clue about build configuration as it
relies only on the presence of RTE_EXPORT* and RTE_VERSION* markers in
a source file.

As a consequence, Linux eal_exports.map contains references to
HPET symbols regardless of the use_hpet meson option value.

$ meson configure build -Duse_hpet=false
$ ninja -C build
...
$ grep hpet build/lib/eal_exports.map
	rte_eal_hpet_init;
	rte_get_hpet_cycles;
	rte_get_hpet_hz;

As far as I have seen, superfluous exports have no impact on generating
a shared library with the GNU linker, yet it might be different with
other linkers (MSVC linker would complain, for example).

Moving those symbols to a dedicated source file solves this (non?) issue.

Fixes: 57c194d142d9 ("build: use dynamically generated version maps")

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 lib/eal/linux/eal_timer.c      | 175 --------------------------------
 lib/eal/linux/eal_timer_hpet.c | 179 +++++++++++++++++++++++++++++++++
 lib/eal/linux/meson.build      |   4 +
 3 files changed, 183 insertions(+), 175 deletions(-)
 create mode 100644 lib/eal/linux/eal_timer_hpet.c

diff --git a/lib/eal/linux/eal_timer.c b/lib/eal/linux/eal_timer.c
index 0e670a0af6..39f975b6b9 100644
--- a/lib/eal/linux/eal_timer.c
+++ b/lib/eal/linux/eal_timer.c
@@ -6,11 +6,6 @@
 #include <stdio.h>
 #include <stdint.h>
 #include <inttypes.h>
-#ifdef RTE_LIBEAL_USE_HPET
-#include <fcntl.h>
-#include <sys/mman.h>
-#include <unistd.h>
-#endif
 
 #include <rte_common.h>
 #include <rte_cycles.h>
@@ -22,176 +17,6 @@
 RTE_EXPORT_SYMBOL(eal_timer_source)
 enum timer_source eal_timer_source = EAL_TIMER_HPET;
 
-#ifdef RTE_LIBEAL_USE_HPET
-
-#define DEV_HPET "/dev/hpet"
-
-/* Maximum number of counters. */
-#define HPET_TIMER_NUM 3
-
-/* General capabilities register */
-#define CLK_PERIOD_SHIFT     32 /* Clock period shift. */
-#define CLK_PERIOD_MASK      0xffffffff00000000ULL /* Clock period mask. */
-
-/**
- * HPET timer registers. From the Intel IA-PC HPET (High Precision Event
- * Timers) Specification.
- */
-struct eal_hpet_regs {
-	/* Memory-mapped, software visible registers */
-	uint64_t capabilities;      /**< RO General Capabilities Register. */
-	uint64_t reserved0;         /**< Reserved for future use. */
-	uint64_t config;            /**< RW General Configuration Register. */
-	uint64_t reserved1;         /**< Reserved for future use. */
-	uint64_t isr;               /**< RW Clear General Interrupt Status. */
-	uint64_t reserved2[25];     /**< Reserved for future use. */
-	union {
-		uint64_t counter;   /**< RW Main Counter Value Register. */
-		struct {
-			uint32_t counter_l; /**< RW Main Counter Low. */
-			uint32_t counter_h; /**< RW Main Counter High. */
-		};
-	};
-	uint64_t reserved3;         /**< Reserved for future use. */
-	struct {
-		uint64_t config;    /**< RW Timer Config and Capability Reg. */
-		uint64_t comp;      /**< RW Timer Comparator Value Register. */
-		uint64_t fsb;       /**< RW FSB Interrupt Route Register. */
-		uint64_t reserved4; /**< Reserved for future use. */
-	} timers[HPET_TIMER_NUM]; /**< Set of HPET timers. */
-};
-
-/* Mmap'd hpet registers */
-static volatile struct eal_hpet_regs *eal_hpet = NULL;
-
-/* Period at which the HPET counter increments in
- * femtoseconds (10^-15 seconds). */
-static uint32_t eal_hpet_resolution_fs = 0;
-
-/* Frequency of the HPET counter in Hz */
-static uint64_t eal_hpet_resolution_hz = 0;
-
-/* Incremented 4 times during one 32bits hpet full count */
-static uint32_t eal_hpet_msb;
-
-static rte_thread_t msb_inc_thread_id;
-
-/*
- * This function runs on a specific thread to update a global variable
- * containing used to process MSB of the HPET (unfortunately, we need
- * this because hpet is 32 bits by default under linux).
- */
-static uint32_t
-hpet_msb_inc(__rte_unused void *arg)
-{
-	uint32_t t;
-
-	while (1) {
-		t = (eal_hpet->counter_l >> 30);
-		if (t != (eal_hpet_msb & 3))
-			eal_hpet_msb ++;
-		sleep(10);
-	}
-	return 0;
-}
-
-RTE_EXPORT_SYMBOL(rte_get_hpet_hz)
-uint64_t
-rte_get_hpet_hz(void)
-{
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
-
-	if (internal_conf->no_hpet)
-		rte_panic("Error, HPET called, but no HPET present\n");
-
-	return eal_hpet_resolution_hz;
-}
-
-RTE_EXPORT_SYMBOL(rte_get_hpet_cycles)
-uint64_t
-rte_get_hpet_cycles(void)
-{
-	uint32_t t, msb;
-	uint64_t ret;
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
-
-	if (internal_conf->no_hpet)
-		rte_panic("Error, HPET called, but no HPET present\n");
-
-	t = eal_hpet->counter_l;
-	msb = eal_hpet_msb;
-	ret = (msb + 2 - (t >> 30)) / 4;
-	ret <<= 32;
-	ret += t;
-	return ret;
-}
-
-#endif
-
-#ifdef RTE_LIBEAL_USE_HPET
-/*
- * Open and mmap /dev/hpet (high precision event timer) that will
- * provide our time reference.
- */
-RTE_EXPORT_SYMBOL(rte_eal_hpet_init)
-int
-rte_eal_hpet_init(int make_default)
-{
-	int fd, ret;
-	struct internal_config *internal_conf =
-		eal_get_internal_configuration();
-
-	if (internal_conf->no_hpet) {
-		EAL_LOG(NOTICE, "HPET is disabled");
-		return -1;
-	}
-
-	fd = open(DEV_HPET, O_RDONLY);
-	if (fd < 0) {
-		EAL_LOG(ERR, "ERROR: Cannot open "DEV_HPET": %s!",
-			strerror(errno));
-		internal_conf->no_hpet = 1;
-		return -1;
-	}
-	eal_hpet = mmap(NULL, 1024, PROT_READ, MAP_SHARED, fd, 0);
-	if (eal_hpet == MAP_FAILED) {
-		EAL_LOG(ERR, "ERROR: Cannot mmap "DEV_HPET"!");
-		close(fd);
-		internal_conf->no_hpet = 1;
-		return -1;
-	}
-	close(fd);
-
-	eal_hpet_resolution_fs = (uint32_t)((eal_hpet->capabilities &
-					CLK_PERIOD_MASK) >>
-					CLK_PERIOD_SHIFT);
-
-	eal_hpet_resolution_hz = (1000ULL*1000ULL*1000ULL*1000ULL*1000ULL) /
-		(uint64_t)eal_hpet_resolution_fs;
-
-	EAL_LOG(INFO, "HPET frequency is ~%"PRIu64" kHz",
-			eal_hpet_resolution_hz/1000);
-
-	eal_hpet_msb = (eal_hpet->counter_l >> 30);
-
-	/* create a thread that will increment a global variable for
-	 * msb (hpet is 32 bits by default under linux) */
-	ret = rte_thread_create_internal_control(&msb_inc_thread_id, "hpet-msb",
-			hpet_msb_inc, NULL);
-	if (ret != 0) {
-		EAL_LOG(ERR, "ERROR: Cannot create HPET timer thread!");
-		internal_conf->no_hpet = 1;
-		return -1;
-	}
-
-	if (make_default)
-		eal_timer_source = EAL_TIMER_HPET;
-	return 0;
-}
-#endif
-
 /* Check if the kernel deems the arch provided TSC frequency trustworthy. */
 
 static bool
diff --git a/lib/eal/linux/eal_timer_hpet.c b/lib/eal/linux/eal_timer_hpet.c
new file mode 100644
index 0000000000..63e38bd53e
--- /dev/null
+++ b/lib/eal/linux/eal_timer_hpet.c
@@ -0,0 +1,179 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2010-2014 Intel Corporation.
+ * Copyright(c) 2012-2013 6WIND S.A.
+ */
+
+#include <fcntl.h>
+#include <inttypes.h>
+#include <sys/mman.h>
+#include <unistd.h>
+
+#include <rte_cycles.h>
+#include <rte_thread.h>
+
+#include <eal_export.h>
+#include "eal_private.h"
+
+#define DEV_HPET "/dev/hpet"
+
+/* Maximum number of counters. */
+#define HPET_TIMER_NUM 3
+
+/* General capabilities register */
+#define CLK_PERIOD_SHIFT     32 /* Clock period shift. */
+#define CLK_PERIOD_MASK      0xffffffff00000000ULL /* Clock period mask. */
+
+/**
+ * HPET timer registers. From the Intel IA-PC HPET (High Precision Event
+ * Timers) Specification.
+ */
+struct eal_hpet_regs {
+	/* Memory-mapped, software visible registers */
+	uint64_t capabilities;      /**< RO General Capabilities Register. */
+	uint64_t reserved0;         /**< Reserved for future use. */
+	uint64_t config;            /**< RW General Configuration Register. */
+	uint64_t reserved1;         /**< Reserved for future use. */
+	uint64_t isr;               /**< RW Clear General Interrupt Status. */
+	uint64_t reserved2[25];     /**< Reserved for future use. */
+	union {
+		uint64_t counter;   /**< RW Main Counter Value Register. */
+		struct {
+			uint32_t counter_l; /**< RW Main Counter Low. */
+			uint32_t counter_h; /**< RW Main Counter High. */
+		};
+	};
+	uint64_t reserved3;         /**< Reserved for future use. */
+	struct {
+		uint64_t config;    /**< RW Timer Config and Capability Reg. */
+		uint64_t comp;      /**< RW Timer Comparator Value Register. */
+		uint64_t fsb;       /**< RW FSB Interrupt Route Register. */
+		uint64_t reserved4; /**< Reserved for future use. */
+	} timers[HPET_TIMER_NUM]; /**< Set of HPET timers. */
+};
+
+/* Mmap'd hpet registers */
+static volatile struct eal_hpet_regs *eal_hpet;
+
+/* Period at which the HPET counter increments in femtoseconds (10^-15 seconds). */
+static uint32_t eal_hpet_resolution_fs;
+
+/* Frequency of the HPET counter in Hz */
+static uint64_t eal_hpet_resolution_hz;
+
+/* Incremented 4 times during one 32bits hpet full count */
+static uint32_t eal_hpet_msb;
+
+static rte_thread_t msb_inc_thread_id;
+
+/*
+ * This function runs on a specific thread to update a global variable
+ * containing used to process MSB of the HPET (unfortunately, we need
+ * this because hpet is 32 bits by default under linux).
+ */
+static uint32_t
+hpet_msb_inc(__rte_unused void *arg)
+{
+	uint32_t t;
+
+	while (1) {
+		t = (eal_hpet->counter_l >> 30);
+		if (t != (eal_hpet_msb & 3))
+			eal_hpet_msb++;
+		sleep(10);
+	}
+	return 0;
+}
+
+RTE_EXPORT_SYMBOL(rte_get_hpet_hz)
+uint64_t
+rte_get_hpet_hz(void)
+{
+	const struct internal_config *internal_conf =
+		eal_get_internal_configuration();
+
+	if (internal_conf->no_hpet)
+		rte_panic("Error, HPET called, but no HPET present\n");
+
+	return eal_hpet_resolution_hz;
+}
+
+RTE_EXPORT_SYMBOL(rte_get_hpet_cycles)
+uint64_t
+rte_get_hpet_cycles(void)
+{
+	uint32_t t, msb;
+	uint64_t ret;
+	const struct internal_config *internal_conf =
+		eal_get_internal_configuration();
+
+	if (internal_conf->no_hpet)
+		rte_panic("Error, HPET called, but no HPET present\n");
+
+	t = eal_hpet->counter_l;
+	msb = eal_hpet_msb;
+	ret = (msb + 2 - (t >> 30)) / 4;
+	ret <<= 32;
+	ret += t;
+	return ret;
+}
+
+/*
+ * Open and mmap /dev/hpet (high precision event timer) that will
+ * provide our time reference.
+ */
+RTE_EXPORT_SYMBOL(rte_eal_hpet_init)
+int
+rte_eal_hpet_init(int make_default)
+{
+	int fd, ret;
+	struct internal_config *internal_conf =
+		eal_get_internal_configuration();
+
+	if (internal_conf->no_hpet) {
+		EAL_LOG(NOTICE, "HPET is disabled");
+		return -1;
+	}
+
+	fd = open(DEV_HPET, O_RDONLY);
+	if (fd < 0) {
+		EAL_LOG(ERR, "ERROR: Cannot open "DEV_HPET": %s!",
+			strerror(errno));
+		internal_conf->no_hpet = 1;
+		return -1;
+	}
+	eal_hpet = mmap(NULL, 1024, PROT_READ, MAP_SHARED, fd, 0);
+	if (eal_hpet == MAP_FAILED) {
+		EAL_LOG(ERR, "ERROR: Cannot mmap "DEV_HPET"!");
+		close(fd);
+		internal_conf->no_hpet = 1;
+		return -1;
+	}
+	close(fd);
+
+	eal_hpet_resolution_fs = (uint32_t)((eal_hpet->capabilities &
+					CLK_PERIOD_MASK) >>
+					CLK_PERIOD_SHIFT);
+
+	eal_hpet_resolution_hz = (1000ULL*1000ULL*1000ULL*1000ULL*1000ULL) /
+		(uint64_t)eal_hpet_resolution_fs;
+
+	EAL_LOG(INFO, "HPET frequency is ~%"PRIu64" kHz",
+			eal_hpet_resolution_hz/1000);
+
+	eal_hpet_msb = (eal_hpet->counter_l >> 30);
+
+	/* create a thread that will increment a global variable for
+	 * msb (hpet is 32 bits by default under linux)
+	 */
+	ret = rte_thread_create_internal_control(&msb_inc_thread_id, "hpet-msb",
+			hpet_msb_inc, NULL);
+	if (ret != 0) {
+		EAL_LOG(ERR, "ERROR: Cannot create HPET timer thread!");
+		internal_conf->no_hpet = 1;
+		return -1;
+	}
+
+	if (make_default)
+		eal_timer_source = EAL_TIMER_HPET;
+	return 0;
+}
diff --git a/lib/eal/linux/meson.build b/lib/eal/linux/meson.build
index e99ebed256..29ba313218 100644
--- a/lib/eal/linux/meson.build
+++ b/lib/eal/linux/meson.build
@@ -19,6 +19,10 @@ sources += files(
         'eal_vfio_mp_sync.c',
 )
 
+if dpdk_conf.get('RTE_LIBEAL_USE_HPET')
+    sources += files('eal_timer_hpet.c')
+endif
+
 deps += ['kvargs', 'telemetry']
 if has_libnuma
     dpdk_conf.set10('RTE_EAL_NUMA_AWARE_HUGEPAGES', true)
-- 
2.53.0

