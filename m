Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBAECD3439
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 May 2026 17:23:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C1F75406B4;
	Wed,  6 May 2026 19:22:53 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 60FA340666
 for <dev@dpdk.org>; Wed,  6 May 2026 19:22:50 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4g9hyw5ZfvzJ46DS
 for <dev@dpdk.org>; Thu,  7 May 2026 01:22:32 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id 3709740571
 for <dev@dpdk.org>; Thu,  7 May 2026 01:22:50 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 6 May 2026 19:22:49 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
CC: <dev@dpdk.org>
Subject: [PATCH 04/10] bpf: add cBPF origin to rte_bpf_load_ex
Date: Wed, 6 May 2026 18:22:01 +0100
Message-ID: <20260506172209.6805-5-marat.khalili@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260506172209.6805-1-marat.khalili@huawei.com>
References: <20260506172209.6805-1-marat.khalili@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapema500001.china.huawei.com (7.182.19.243) To
 frapema500003.china.huawei.com (7.182.19.114)
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

Add cBPF origin to rte_bpf_load_ex to allow loading PCAP filters and
other cBPF code through the unified interface.

Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
---
 lib/bpf/bpf_convert.c | 79 +++++++++++++++++++++++++++++++++++++++++--
 lib/bpf/bpf_impl.h    | 11 ++++++
 lib/bpf/bpf_load.c    | 12 ++++++-
 lib/bpf/bpf_stub.c    | 27 ---------------
 lib/bpf/meson.build   | 11 +++---
 lib/bpf/rte_bpf.h     |  8 ++++-
 6 files changed, 111 insertions(+), 37 deletions(-)
 delete mode 100644 lib/bpf/bpf_stub.c

diff --git a/lib/bpf/bpf_convert.c b/lib/bpf/bpf_convert.c
index 953ca80670c4..c997116c691f 100644
--- a/lib/bpf/bpf_convert.c
+++ b/lib/bpf/bpf_convert.c
@@ -9,6 +9,12 @@
  * Copyright (c) 2011 - 2014 PLUMgrid, http://plumgrid.com
  */
 
+#include "bpf_impl.h"
+#include <eal_export.h>
+#include <rte_errno.h>
+
+#ifdef RTE_HAS_LIBPCAP
+
 #include <assert.h>
 #include <errno.h>
 #include <stdbool.h>
@@ -17,17 +23,14 @@
 #include <stdlib.h>
 #include <string.h>
 
-#include <eal_export.h>
 #include <rte_common.h>
 #include <rte_bpf.h>
 #include <rte_log.h>
 #include <rte_malloc.h>
-#include <rte_errno.h>
 
 #include <pcap/pcap.h>
 #include <pcap/bpf.h>
 
-#include "bpf_impl.h"
 #include "bpf_def.h"
 
 #ifndef BPF_MAXINSNS
@@ -572,3 +575,73 @@ rte_bpf_convert(const struct bpf_program *prog)
 
 	return prm;
 }
+
+void
+__rte_bpf_convert_cleanup(struct __rte_bpf_load *load)
+{
+	free(load->ins);
+}
+
+int __rte_bpf_convert(struct __rte_bpf_load *load)
+{
+	struct rte_bpf_prm_ex *const prm = &load->prm;
+	uint32_t nb_ins = 0;
+	int ret;
+
+	RTE_ASSERT(prm->origin == RTE_BPF_ORIGIN_CBPF);
+
+	if (prm->cbpf.ins == NULL || prm->cbpf.nb_ins == 0)
+		return -EINVAL;
+
+	/* 1st pass: calculate the eBPF program length */
+	ret = bpf_convert_filter(prm->cbpf.ins, prm->cbpf.nb_ins, NULL, &nb_ins);
+	if (ret < 0) {
+		RTE_BPF_LOG_FUNC_LINE(ERR, "cannot get eBPF length");
+		return ret;
+	}
+
+	RTE_ASSERT(load->ins == NULL);
+	load->ins = malloc(nb_ins * sizeof(load->ins[0]));
+	if (load->ins == NULL)
+		return -ENOMEM;
+
+	/* 2nd pass: remap cBPF to eBPF instructions  */
+	ret = bpf_convert_filter(prm->cbpf.ins, prm->cbpf.nb_ins, load->ins, &nb_ins);
+	if (ret < 0) {
+		RTE_BPF_LOG_FUNC_LINE(ERR, "cannot convert cBPF to eBPF");
+		return ret;
+	}
+
+	prm->origin = RTE_BPF_ORIGIN_RAW;
+	prm->raw.ins = load->ins;
+	prm->raw.nb_ins = nb_ins;
+
+	return 0;
+}
+
+#else /* RTE_HAS_LIBPCAP */
+
+RTE_EXPORT_SYMBOL(rte_bpf_convert)
+struct rte_bpf_prm *
+rte_bpf_convert(const struct bpf_program *prog)
+{
+	RTE_SET_USED(prog);
+	RTE_BPF_LOG_FUNC_LINE(ERR, "not supported, rebuild with libpcap installed");
+	rte_errno = ENOTSUP;
+	return NULL;
+}
+
+void
+__rte_bpf_convert_cleanup(struct __rte_bpf_load *load)
+{
+	RTE_ASSERT(load->ins == NULL);
+}
+
+int __rte_bpf_convert(struct __rte_bpf_load *load)
+{
+	RTE_SET_USED(load);
+	RTE_BPF_LOG_FUNC_LINE(ERR, "not supported, rebuild with libpcap installed");
+	return -ENOTSUP;
+}
+
+#endif /* RTE_HAS_LIBPCAP */
diff --git a/lib/bpf/bpf_impl.h b/lib/bpf/bpf_impl.h
index 4a98b3373067..92d03583d977 100644
--- a/lib/bpf/bpf_impl.h
+++ b/lib/bpf/bpf_impl.h
@@ -21,6 +21,9 @@ struct rte_bpf {
 struct __rte_bpf_load {
 	struct rte_bpf_prm_ex prm;
 
+	/* Conversion from cBPF. */
+	struct ebpf_insn *ins;
+
 	/* Loading ELF and applying relocations. */
 	int elf_fd;  /* ELF fd, must be negative (not zero) by default. */
 	void *elf;  /* Using void to avoid dependency on libelf. */
@@ -34,6 +37,14 @@ struct __rte_bpf_load {
  * to avoid potential name conflict with other libraries.
  */
 
+/* Free temporary resources created by converting from cBPF to eBPF. */
+void
+__rte_bpf_convert_cleanup(struct __rte_bpf_load *load);
+
+/* Convert program from cBPF to eBPF. */
+int
+__rte_bpf_convert(struct __rte_bpf_load *load);
+
 /* Free temporary resources created by opening ELF. */
 void
 __rte_bpf_load_elf_cleanup(struct __rte_bpf_load *load);
diff --git a/lib/bpf/bpf_load.c b/lib/bpf/bpf_load.c
index c9cbaf6ded7e..c3c49ac49b1b 100644
--- a/lib/bpf/bpf_load.c
+++ b/lib/bpf/bpf_load.c
@@ -230,6 +230,9 @@ load_try(struct __rte_bpf_load *load, const struct rte_bpf_prm_ex *app_prm)
 	switch (load->prm.origin) {
 	case RTE_BPF_ORIGIN_RAW:
 		break;
+	case RTE_BPF_ORIGIN_CBPF:
+		rc = rc < 0 ? rc : __rte_bpf_convert(load);
+		break;
 	case RTE_BPF_ORIGIN_ELF_FILE:
 		rc = rc < 0 ? rc : __rte_bpf_load_elf_file(load);
 		rc = rc < 0 ? rc : __rte_bpf_load_elf_code(load);
@@ -244,6 +247,13 @@ load_try(struct __rte_bpf_load *load, const struct rte_bpf_prm_ex *app_prm)
 	return rc;
 }
 
+static void
+load_cleanup(struct __rte_bpf_load *load)
+{
+	__rte_bpf_convert_cleanup(load);
+	__rte_bpf_load_elf_cleanup(load);
+}
+
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_bpf_load_ex, 26.11)
 struct rte_bpf *
 rte_bpf_load_ex(const struct rte_bpf_prm_ex *prm)
@@ -252,7 +262,7 @@ rte_bpf_load_ex(const struct rte_bpf_prm_ex *prm)
 
 	const int rc = load_try(&load, prm);
 
-	__rte_bpf_load_elf_cleanup(&load);
+	load_cleanup(&load);
 
 	RTE_ASSERT((rc < 0) == (load.bpf == NULL));
 
diff --git a/lib/bpf/bpf_stub.c b/lib/bpf/bpf_stub.c
deleted file mode 100644
index 4c329832c264..000000000000
--- a/lib/bpf/bpf_stub.c
+++ /dev/null
@@ -1,27 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2018-2021 Intel Corporation
- */
-
-#include "bpf_impl.h"
-#include <eal_export.h>
-#include <rte_errno.h>
-
-/**
- * Contains stubs for unimplemented public API functions
- */
-
-#ifndef RTE_HAS_LIBPCAP
-RTE_EXPORT_SYMBOL(rte_bpf_convert)
-struct rte_bpf_prm *
-rte_bpf_convert(const struct bpf_program *prog)
-{
-	if (prog == NULL) {
-		rte_errno = EINVAL;
-		return NULL;
-	}
-
-	RTE_BPF_LOG_FUNC_LINE(ERR, "not supported, rebuild with libpcap installed");
-	rte_errno = ENOTSUP;
-	return NULL;
-}
-#endif
diff --git a/lib/bpf/meson.build b/lib/bpf/meson.build
index 4901b6ee1463..7e8a300e3f87 100644
--- a/lib/bpf/meson.build
+++ b/lib/bpf/meson.build
@@ -15,14 +15,16 @@ if arch_subdir == 'x86' and dpdk_conf.get('RTE_ARCH_32')
     subdir_done()
 endif
 
-sources = files('bpf.c',
+sources = files(
+        'bpf.c',
+        'bpf_convert.c',
         'bpf_dump.c',
         'bpf_exec.c',
         'bpf_load.c',
         'bpf_load_elf.c',
         'bpf_pkt.c',
-        'bpf_stub.c',
-        'bpf_validate.c')
+        'bpf_validate.c',
+)
 
 if arch_subdir == 'x86' and dpdk_conf.get('RTE_ARCH_64')
     sources += files('bpf_jit_x86.c')
@@ -45,8 +47,7 @@ else
 endif
 
 if dpdk_conf.has('RTE_HAS_LIBPCAP')
-    sources += files('bpf_convert.c')
     ext_deps += pcap_dep
 else
-    warning('libpcap is missing, rte_bpf_convert API will be disabled')
+    warning('libpcap is missing, cBPF API will be disabled')
 endif
diff --git a/lib/bpf/rte_bpf.h b/lib/bpf/rte_bpf.h
index 751b879bb7fd..dcb709352e17 100644
--- a/lib/bpf/rte_bpf.h
+++ b/lib/bpf/rte_bpf.h
@@ -95,10 +95,12 @@ struct rte_bpf_xsym {
  */
 enum rte_bpf_origin {
 	RTE_BPF_ORIGIN_RAW,		/**< code loaded from raw array */
-	RTE_BPF_ORIGIN_RESERVED,	/**< reserved for cBPF */
+	RTE_BPF_ORIGIN_CBPF,		/**< code converted from cbpf */
 	RTE_BPF_ORIGIN_ELF_FILE,	/**< code loaded from elf_file */
 };
 
+struct bpf_insn;
+
 /**
  * Input parameters for loading eBPF code, extensible version.
  *
@@ -117,6 +119,10 @@ struct rte_bpf_prm_ex {
 			const struct ebpf_insn *ins;  /**< eBPF instructions */
 			uint32_t nb_ins;  /**< number of instructions in ins */
 		} raw;
+		struct {
+			const struct bpf_insn *ins;  /**< cBPF instructions */
+			uint32_t nb_ins;  /**< number of instructions in ins */
+		} cbpf;
 		struct {
 			const char *path;  /**< path to the ELF file */
 			const char *section;  /**< ELF section with the code */
-- 
2.43.0

