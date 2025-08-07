Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE578C87FCF
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 Aug 2025 17:35:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CB16B40664;
	Thu,  7 Aug 2025 19:34:54 +0200 (CEST)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41]) by mails.dpdk.org (Postfix) with ESMTP id C788140270
 for <dev@dpdk.org>; Thu,  7 Aug 2025 19:34:53 +0200 (CEST)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-458bdde7dedso9600725e9.0
 for <dev@dpdk.org>; Thu, 07 Aug 2025 10:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754588093;
 x=1755192893; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5XqBerqhvIr6Ec7GGIIrIYT/trIW7RuY/i9Lx/kn9zs=;
 b=LOyPyxEBAnAMZqisGO1aFjL1tkJJDU2emTHhfWaZj8IBVQf4smwC/mcQuzY9K/xzsO
 BFM7d4uSOErrtiIgwD78+jrgDm3LYfuyoI1dD2z5NvviY+SIp/z/A3nXzvttcmElhBa+
 WpF8YT/dnm43gKL2w5KwQRWnxIQLiJ392WuZenjBuJ8sRSX3vefy20DS8UHyGWaw6CRo
 V+pfrCUvll37ZqJK2BgHbx4zTqxqA2Upkvu3Qzr0Xy+N/3SmW9PNmrhN3c1AX0A6CEq/
 FiOG9BXbeDdoP7bRVz8cMhj6V2MJ6SEyQtBmDMs6EGNX5EGP35GGM/bHPfQUOvxuSxv/
 KEZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754588093; x=1755192893;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5XqBerqhvIr6Ec7GGIIrIYT/trIW7RuY/i9Lx/kn9zs=;
 b=ZD69PKKtmZR2PnTqoeGvaZkyqivbFbZQPag48vf99kwa56hQFaaCuw6LApo6Mkh6EA
 qoeLSIH5qVWL96RIgTN6V7okvVv6di8/5JxjVFVv3ol9cGWmTCaKAKR/meGg2wFcqEGb
 44PMTi16CyN1A2vFE3a4ovLwtlTGjoEjvhIGgsPxNKhnIV9bT0H/ICPTAdL7rNsPcWFi
 Kpz29j7ZhB/u5VMidMfR8/WX4bP9QfheMVFnVBDgdtANuEQ/nbVDYG0aFDIchb6GbOJ5
 J20nv58UGFAeDV1bXA5O2/G7viGUX22P+GTpbO4xyXi2zMulQ0qIRt0fsfDqB900NtHc
 BO7A==
X-Gm-Message-State: AOJu0YyvpvEadaArAqToMuKOmZm4ZJ/5y0sut/NqIXnu0h9uG7n2YmBQ
 kLANdD/TgGlH8KHkF4k2qbheVi1XJW1qnVeNB1n2uAX9MXq6XqC2b5IWQA8rol6R6yR0yLrk91A
 +V+4e
X-Gm-Gg: ASbGnctzWjB62OAMZ14eRd5p8qxeIbSyZ/Oydl1Rgv0zwgQ7XrXfSoh2Tj9c+UfThHG
 7XwtRZnbh0Da3bpcEyXESZFAr6je/lEeF4KqX2/ooFhoKtvPzYsgb8iMeGVu/45m+Zf1UhqLxn3
 dvgnmJc/Se1Sn32c8637SzFDGsbLJPG9oJClgQ4Z/R5P83y5S9xo2d+RFqNlamnDcBoLlIaTtQh
 h8p88gEV8OWZRyU9XWe9rkhIpegbHLD+Obq3wsK838eSwYHGKLGYx//un04pB7NX3HF3R5MMQmE
 Ci4SV1wj0ILT7DwYKtGRp64umVh+4FTbJIoZlrWB0mY+1R+SS4H9DQxfG6hVqYduSFlxSGGsHCc
 MaKBMUL3wkxC0MgKlDdO8nauFTTwweK5bNWB0Puguf3R8ai0pwsc6M7id/tqukAwIZz0zJ4EZ
X-Google-Smtp-Source: AGHT+IGrcMJuOOqPvxl56MJDHmCUU36M1VNM4V7Ddo38ka+aCVU7uBQlh6UZnaKpjTo2v5cGC/ocHQ==
X-Received: by 2002:a05:600c:1907:b0:456:285b:db3c with SMTP id
 5b1f17b1804b1-459f43619e6mr6298555e9.3.1754588093400; 
 Thu, 07 Aug 2025 10:34:53 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b8e9464f46sm13242838f8f.19.2025.08.07.10.34.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 10:34:53 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v10 03/14] ethdev: reorder bpf and ethdev dependency
Date: Thu,  7 Aug 2025 10:33:17 -0700
Message-ID: <20250807173437.11442-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250807173437.11442-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250807173437.11442-1-stephen@networkplumber.org>
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

In order to allow use of BPF in the mirror code in ethdev.
Need to switch so that ethdev library depends on BPF library.

Since meson doesn't allow co-dependency, move the BPF ethdev
callback portion into the ethdev lib. And cleanup usage
of VLA in that code.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/meson.build                       |  6 ++--
 lib/bpf/meson.build                        |  9 ++----
 lib/{bpf/bpf_pkt.c => ethdev/ethdev_bpf.c} | 35 ++++++++++++----------
 lib/ethdev/meson.build                     |  6 ++++
 lib/{bpf => ethdev}/rte_bpf_ethdev.h       |  0
 lib/meson.build                            |  4 +--
 6 files changed, 33 insertions(+), 27 deletions(-)
 rename lib/{bpf/bpf_pkt.c => ethdev/ethdev_bpf.c} (95%)
 rename lib/{bpf => ethdev}/rte_bpf_ethdev.h (100%)

diff --git a/app/test/meson.build b/app/test/meson.build
index 7d38f51918..ae947c4cbd 100644
--- a/app/test/meson.build
+++ b/app/test/meson.build
@@ -51,7 +51,7 @@ source_file_deps = {
     'test_compressdev.c': ['compressdev'],
     'test_cpuflags.c': [],
     'test_crc.c': ['net'],
-    'test_cryptodev.c': test_cryptodev_deps,
+    'test_cryptodev.c': ['ethdev'] + test_cryptodev_deps,
     'test_cryptodev_asym.c': ['bus_vdev'] + test_cryptodev_deps,
     'test_cryptodev_blockcipher.c': test_cryptodev_deps,
     'test_cryptodev_crosscheck.c': test_cryptodev_deps,
@@ -60,7 +60,7 @@ source_file_deps = {
     'test_cryptodev_security_tls_record.c': ['cryptodev', 'security'],
     'test_cycles.c': [],
     'test_debug.c': [],
-    'test_devargs.c': ['kvargs'],
+    'test_devargs.c': ['ethdev', 'kvargs'],
     'test_dispatcher.c': ['dispatcher'],
     'test_distributor.c': ['distributor'],
     'test_distributor_perf.c': ['distributor'],
@@ -80,7 +80,7 @@ source_file_deps = {
     'test_event_ring.c': ['eventdev'],
     'test_event_timer_adapter.c': ['ethdev', 'eventdev', 'bus_vdev'],
     'test_event_vector_adapter.c': ['eventdev', 'bus_vdev'],
-    'test_eventdev.c': ['eventdev', 'bus_vdev'],
+    'test_eventdev.c': ['ethdev', 'eventdev', 'bus_vdev'],
     'test_external_mem.c': [],
     'test_fbarray.c': [],
     'test_fib.c': ['net', 'fib'],
diff --git a/lib/bpf/meson.build b/lib/bpf/meson.build
index 28df7f469a..bc76cc7209 100644
--- a/lib/bpf/meson.build
+++ b/lib/bpf/meson.build
@@ -7,8 +7,6 @@ if is_windows
     subdir_done()
 endif
 
-cflags += no_wvla_cflag
-
 if arch_subdir == 'x86' and dpdk_conf.get('RTE_ARCH_32')
     build = false
     reason = 'not supported on 32-bit x86'
@@ -19,7 +17,6 @@ sources = files('bpf.c',
         'bpf_dump.c',
         'bpf_exec.c',
         'bpf_load.c',
-        'bpf_pkt.c',
         'bpf_stub.c',
         'bpf_validate.c')
 
@@ -29,11 +26,9 @@ elif dpdk_conf.has('RTE_ARCH_ARM64')
     sources += files('bpf_jit_arm64.c')
 endif
 
-headers = files('bpf_def.h',
-        'rte_bpf.h',
-        'rte_bpf_ethdev.h')
+headers = files('bpf_def.h', 'rte_bpf.h')
 
-deps += ['mbuf', 'net', 'ethdev']
+deps += ['mbuf', 'net']
 
 dep = dependency('libelf', required: false, method: 'pkg-config')
 if dep.found()
diff --git a/lib/bpf/bpf_pkt.c b/lib/ethdev/ethdev_bpf.c
similarity index 95%
rename from lib/bpf/bpf_pkt.c
rename to lib/ethdev/ethdev_bpf.c
index 01f813c56b..712afdc3df 100644
--- a/lib/bpf/bpf_pkt.c
+++ b/lib/ethdev/ethdev_bpf.c
@@ -6,19 +6,23 @@
 #include <string.h>
 #include <errno.h>
 #include <stdint.h>
+#include <stdlib.h>
 
 #include <sys/queue.h>
 
 #include <eal_export.h>
+#include <rte_atomic.h>
+#include <rte_bpf.h>
+#include <rte_bpf_ethdev.h>
 #include <rte_common.h>
-#include <rte_malloc.h>
+#include <rte_config.h>
+#include <rte_errno.h>
+#include <rte_ethdev.h>
 #include <rte_log.h>
-#include <rte_atomic.h>
+#include <rte_malloc.h>
 #include <rte_mbuf.h>
-#include <rte_ethdev.h>
-
-#include <rte_bpf_ethdev.h>
-#include "bpf_impl.h"
+#include <rte_spinlock.h>
+#include <rte_stdatomic.h>
 
 /*
  * information about installed BPF rx/tx callback
@@ -163,10 +167,11 @@ apply_filter(struct rte_mbuf *mb[], const uint64_t rc[], uint32_t num,
 	uint32_t drop)
 {
 	uint32_t i, j, k;
-	struct rte_mbuf *dr[num];
+	struct rte_mbuf **dr;
 
-	for (i = 0, j = 0, k = 0; i != num; i++) {
+	dr = alloca(sizeof(struct rte_mbuf *) * num);
 
+	for (i = 0, j = 0, k = 0; i != num; i++) {
 		/* filter matches */
 		if (rc[i] != 0)
 			mb[j++] = mb[i];
@@ -193,8 +198,8 @@ pkt_filter_vm(const struct rte_bpf *bpf, struct rte_mbuf *mb[], uint32_t num,
 	uint32_t drop)
 {
 	uint32_t i;
-	void *dp[num];
-	uint64_t rc[num];
+	void **dp = alloca(sizeof(void *) * num);
+	uint64_t *rc = alloca(sizeof(uint64_t) * num);
 
 	for (i = 0; i != num; i++)
 		dp[i] = rte_pktmbuf_mtod(mb[i], void *);
@@ -209,7 +214,7 @@ pkt_filter_jit(const struct rte_bpf_jit *jit, struct rte_mbuf *mb[],
 {
 	uint32_t i, n;
 	void *dp;
-	uint64_t rc[num];
+	uint64_t *rc = alloca(sizeof(uint64_t) * num);
 
 	n = 0;
 	for (i = 0; i != num; i++) {
@@ -228,7 +233,7 @@ static inline uint32_t
 pkt_filter_mb_vm(const struct rte_bpf *bpf, struct rte_mbuf *mb[], uint32_t num,
 	uint32_t drop)
 {
-	uint64_t rc[num];
+	uint64_t *rc = alloca(sizeof(uint64_t) * num);
 
 	rte_bpf_exec_burst(bpf, (void **)mb, rc, num);
 	return apply_filter(mb, rc, num, drop);
@@ -239,7 +244,7 @@ pkt_filter_mb_jit(const struct rte_bpf_jit *jit, struct rte_mbuf *mb[],
 	uint32_t num, uint32_t drop)
 {
 	uint32_t i, n;
-	uint64_t rc[num];
+	uint64_t *rc = alloca(sizeof(uint64_t) * num);
 
 	n = 0;
 	for (i = 0; i != num; i++) {
@@ -515,7 +520,7 @@ bpf_eth_elf_load(struct bpf_eth_cbh *cbh, uint16_t port, uint16_t queue,
 		ftx = select_tx_callback(prm->prog_arg.type, flags);
 
 	if (frx == NULL && ftx == NULL) {
-		RTE_BPF_LOG_LINE(ERR, "%s(%u, %u): no callback selected;",
+		RTE_ETHDEV_LOG_LINE(ERR, "%s(%u, %u): no callback selected;",
 			__func__, port, queue);
 		return -EINVAL;
 	}
@@ -527,7 +532,7 @@ bpf_eth_elf_load(struct bpf_eth_cbh *cbh, uint16_t port, uint16_t queue,
 	rte_bpf_get_jit(bpf, &jit);
 
 	if ((flags & RTE_BPF_ETH_F_JIT) != 0 && jit.func == NULL) {
-		RTE_BPF_LOG_LINE(ERR, "%s(%u, %u): no JIT generated;",
+		RTE_ETHDEV_LOG_LINE(ERR, "%s(%u, %u): no JIT generated;",
 			__func__, port, queue);
 		rte_bpf_destroy(bpf);
 		return -ENOTSUP;
diff --git a/lib/ethdev/meson.build b/lib/ethdev/meson.build
index f1d2586591..5d2dc240fd 100644
--- a/lib/ethdev/meson.build
+++ b/lib/ethdev/meson.build
@@ -55,6 +55,12 @@ endif
 
 deps += ['net', 'kvargs', 'meter', 'telemetry']
 
+if not is_windows
+    deps += ['bpf']
+    headers += files('rte_bpf_ethdev.h')
+    sources += files('ethdev_bpf.c')
+endif
+
 if is_freebsd
     annotate_locks = false
 endif
diff --git a/lib/bpf/rte_bpf_ethdev.h b/lib/ethdev/rte_bpf_ethdev.h
similarity index 100%
rename from lib/bpf/rte_bpf_ethdev.h
rename to lib/ethdev/rte_bpf_ethdev.h
diff --git a/lib/meson.build b/lib/meson.build
index 0d56b2083b..8b68aa0356 100644
--- a/lib/meson.build
+++ b/lib/meson.build
@@ -22,7 +22,8 @@ libraries = [
         'mbuf',
         'net',
         'meter',
-        'ethdev',
+        'bpf',
+        'ethdev', # ethdev depends on bpf
         'pci', # core
         'cmdline',
         'metrics', # bitrate/latency stats depends on this
@@ -31,7 +32,6 @@ libraries = [
         'acl',
         'bbdev',
         'bitratestats',
-        'bpf',
         'cfgfile',
         'compressdev',
         'cryptodev',
-- 
2.47.2

