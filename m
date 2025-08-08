Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D48C87FCB
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 Aug 2025 16:59:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2371A40677;
	Fri,  8 Aug 2025 18:58:57 +0200 (CEST)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53]) by mails.dpdk.org (Postfix) with ESMTP id 999EE40695
 for <dev@dpdk.org>; Fri,  8 Aug 2025 18:58:55 +0200 (CEST)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-459e1338565so22001685e9.2
 for <dev@dpdk.org>; Fri, 08 Aug 2025 09:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754672335;
 x=1755277135; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J2I1Jotv7tjQAn+4leF+yvYkKgVTJkgQ4M+vZoOgsCA=;
 b=wUsulZJWrQIgKjr/R+K2myXtPYW9j73Az3lWbEw9XHBBVrBeSj1q5892/PnJXP31cx
 M08sDKWgqsYrDLjLQ25WOhnCMRE7ykCE5VZGYZAeHi/cIrDy7Xq0aPxY/RUf5qJStIfh
 1ti0XI5E0SYIWOZ3p4BobpxuN/S+EuvrDnpiScF0pQCKUzLWhndUlnlEYCFNMZEt+9r0
 v1SRwtUCtw6vRYxJqqsfu8m2HqBtJAkvfCdZJK2gG2fvPsDND38Mv+HzrjxUl0qO+4a+
 t8QFkn6/GbclveVbbBLt8E+UOCBBfvnXyPt+Lsj7wlPeck27TeqVjgKMDyzrzY4EiXdo
 spBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754672335; x=1755277135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J2I1Jotv7tjQAn+4leF+yvYkKgVTJkgQ4M+vZoOgsCA=;
 b=hlhP7tNA5H8pxFkpvS7wPX0aJR4VtNLjlm92IWbhD189y8NMs0FFDj8YrDC2teDMeW
 RUig0MrU9JOJTzfLZ2v4PUnFOt0EnZD2J+9YPPAVMk6i84bumrM+lV1WlljgANWVhXaR
 TnF8MQRQUNc8wCeM36rSYJ0GB/u/L7MjGvvHi5B3svgqnWsgHgYhZvMLQpTcx9gnuVm0
 yZyoyzgm8+l1E2TxAPlvDui/LFxp0rUJwdN2TaF1Xd6Wxr9Q4FIt+8l9Wih5huFg29bD
 FHeczBs0lor7mmKP9MVKVQXIozHZ9T5HZO/XyfuQl6vvUkKGnTlnO03E3934f2sEoKZN
 mzuw==
X-Gm-Message-State: AOJu0YzG7redPRRaQz24tjY4Bjs0/zcVSPYbRf3DOsh+r7d9Hqr3bxCp
 Yad07WPq/y35F42IOhQrQDHGJOTSvSog35PDwdZyRBGR59e35aJd2QcZz3XiloypuiYIg4FzalE
 qh4+V
X-Gm-Gg: ASbGncuXX8Zg6XxU/k30qr9RqfsNAYsZ6r4V9wVkj+c7YZjOf3PpibRVjYFe0rc5nRV
 qDg2tL55Kw9c7SkI7StDukOvICmwOMyui0vjV74rEBkSJawJDO13Nyo8UCLrClAtmL2qwxTW154
 18Xx0HTy3hh3pD/Pe2OMMymZ/Sd32v68iYdaEaepfUqCwNOVXL9caBYjTd6gYUImRO4WQkmwrgC
 +4E70jPDAMQMXafx7SaHMWP8z4txjET8V/dpxu9YzmJp7gwc2n/v1mg9IBE++BmPKSGdP1mfvKy
 +d7TsYDc9/g3ObD6s1re9AOlW9kT68i4aatoR+S7ZLGMW0JC6S2vhRpyigbKXAmx8RGGtFdUy4K
 GZ2bnSHJzdIi02kwvGtunPNzRL/OaeNjycjjoCcPFiuKgAxlFH4BUBXm3IoigZI6bAoedVuYz
X-Google-Smtp-Source: AGHT+IFq9/vWvG3BFXOskUQ0+ZAUCgW8AGVXqTuno4z4ZqNqMaoFQaOf6keLn3P0SGQpjX140cYjPg==
X-Received: by 2002:a05:600c:474a:b0:456:dc0:7d4e with SMTP id
 5b1f17b1804b1-459f4f0376fmr38405395e9.18.1754672335212; 
 Fri, 08 Aug 2025 09:58:55 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3ac115sm30997531f8f.12.2025.08.08.09.58.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 09:58:54 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v11 03/14] ethdev: reorder bpf and ethdev dependency
Date: Fri,  8 Aug 2025 09:55:41 -0700
Message-ID: <20250808165843.39075-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250808165843.39075-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250808165843.39075-1-stephen@networkplumber.org>
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
index f1d2586591..1d68d5348c 100644
--- a/lib/ethdev/meson.build
+++ b/lib/ethdev/meson.build
@@ -55,6 +55,12 @@ endif
 
 deps += ['net', 'kvargs', 'meter', 'telemetry']
 
+if dpdk_conf.has('RTE_LIB_BPF')
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

