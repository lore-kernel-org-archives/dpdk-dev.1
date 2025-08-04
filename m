Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6066AC87FCF
	for <dpdk-dev@archiver.kernel.org>; Mon,  4 Aug 2025 16:31:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 47A4440A72;
	Mon,  4 Aug 2025 18:30:56 +0200 (CEST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id DB60040A6B
 for <dev@dpdk.org>; Mon,  4 Aug 2025 18:30:54 +0200 (CEST)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4538bc52a8dso28388935e9.2
 for <dev@dpdk.org>; Mon, 04 Aug 2025 09:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754325054;
 x=1754929854; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dkGGhx23C7wHMKwDMGU8DK1B/PfTXKh6ovgk3kEu3YI=;
 b=N13FV8UhMqg0+eqoR5+jB/26l3bxUTeaI/8bxv7MD70S3e3UTniUltkTBKruFQ6uhL
 TlKwmHcKJw2DroHkVEqzpqiNZWYt0e6IyS1ysLsFU5of+eVLiNu6koAYaROj3WNhWxYI
 chbxVKQXPO9u0oijFiKwgd+weW5biXCLQ/NGdCL/+wRbB4hN6vBJdYUHSVkbN0Nhl77K
 MivfkK6wiP7+mFFpkO7HGVik/m73hz6Yi+w0maQQqpe+uEoRqjC6Z2nduajfKaxNquYu
 /FxqfprRYP5tKKNATyHFMBOZd4EdRTbZQEZf4DYDKf/RPw+c4rS6x0rxhgoHUoP5hlyA
 pKBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754325054; x=1754929854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dkGGhx23C7wHMKwDMGU8DK1B/PfTXKh6ovgk3kEu3YI=;
 b=a0ps+c4/vzQlUVZOXpWgkxvoMB56hW13rLe9a5HipkU0ZmttF+YnTpXAv9iaZYgv5T
 usiW/CMRWa8HluIRik6WiCNgX1PXAi/X7ntFsf9wFB9ogOKKIgRnbuNGXSOs8W4nlsGA
 wF+h6r8EMwh94/J8TFNqflYN+4iWmXgUcVAA/oQkoXFheAQn70Oz3H8z16W2JSOVpft4
 v4eVPDeTpGtpnzf1c5uywOEm0IG08iMoxm+K5jb5U+dAQY3jHjkL4fhFTrsKC1qPNxo+
 MlrHzWnW2yKWUO5/ZgxDGCYA8S5hB7EhOAsBYSLW3DWyHVFjD/Y5WpEm57mlFUFVs7/E
 Aq6g==
X-Gm-Message-State: AOJu0YyY9JPlSQzmNnKd0uSdc8txJVjAwC2rZE4w4ys5CVzI+3XQuXKp
 CldXC4DPFfVIiksBx7AMIRXkpm7X5OJrCTm3K16gzJOip1Jnp+EPc2D3sNOkV4uAoWIAbPR7lb+
 /iiR6
X-Gm-Gg: ASbGncuyIVxR2Am0MmLpjX9cBsPkz6rMhUb1TI1XEHBjIx2EeAQcrSo7iSXiPgOhr3B
 itimp/1vEs+hSYmp6tY54eT9rUP9vNM+JUXi3bqA82+Ba5zE/iIRUI029DfkzalRIQxVQx5qO1z
 5TDL4GwPMyi3pU8H49m95KNfRC4GURv4akwGmdmJLetoODf5jHUScmReTkRLgBFV8k+iphaayGk
 pwEuUsiU19K6Pcv1JFGzu2KM+9wVrKr50CKP0KWh5iNIq/jSZmTkHS8xdP7wvh031qEGuzkPhnV
 PfLgWczdQL1bwoX/iPl+dnr878W5RR1QP8o60pYGk+UKzzRjaYJk1U2x+kdxeL8MDKjmz3qWTT+
 8qSTZ2sXcN9+rcq/9EOgomkz1D2Oo6+da5w+u863qDlJ8U0aKkMcG3CMbxINUWMcP9W1Doc9/
X-Google-Smtp-Source: AGHT+IGRi//L/P3DrNt98HoKJSV31yzke8UeX+B5LT0MXTZvwyrJiSWgdoH7sJ4BgRuJhkKpQEFp8Q==
X-Received: by 2002:a05:600c:1554:b0:450:d37d:7c with SMTP id
 5b1f17b1804b1-458b6b2ff8amr76501675e9.21.1754325054269; 
 Mon, 04 Aug 2025 09:30:54 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458b5fc556bsm105891405e9.31.2025.08.04.09.30.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 09:30:53 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v8 04/13] ethdev: swap bpf and ethdev dependency
Date: Mon,  4 Aug 2025 09:27:35 -0700
Message-ID: <20250804163039.138959-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250804163039.138959-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250804163039.138959-1-stephen@networkplumber.org>
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
There maybe a better solution?

 lib/bpf/meson.build                        |  9 ++----
 lib/{bpf/bpf_pkt.c => ethdev/ethdev_bpf.c} | 35 ++++++++++++----------
 lib/ethdev/meson.build                     |  6 ++++
 lib/{bpf => ethdev}/rte_bpf_ethdev.h       |  0
 lib/meson.build                            |  4 +--
 5 files changed, 30 insertions(+), 24 deletions(-)
 rename lib/{bpf/bpf_pkt.c => ethdev/ethdev_bpf.c} (95%)
 rename lib/{bpf => ethdev}/rte_bpf_ethdev.h (100%)

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

