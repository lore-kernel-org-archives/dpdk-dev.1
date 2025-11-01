Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 005F2CCFA00
	for <dpdk-dev@archiver.kernel.org>; Sat,  1 Nov 2025 18:07:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A186402ED;
	Sat,  1 Nov 2025 19:07:08 +0100 (CET)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by mails.dpdk.org (Postfix) with ESMTP id 83A02402DA
 for <dev@dpdk.org>; Sat,  1 Nov 2025 19:07:06 +0100 (CET)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-781206cce18so3645910b3a.0
 for <dev@dpdk.org>; Sat, 01 Nov 2025 11:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762020426;
 x=1762625226; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rS/rdp3aq5MCfQAWnKzAAUpzoZeeZrixJxmaUF/F18U=;
 b=KvRTAhVGCH+Sy21SfBerNmSa8bJ4HDvCeR2hZofHBboEvf14DPgzp33sq3eETcLqmG
 m15lLyloaPUAUZqPERmMTPavYpFiK7nfw9uP/1g6dUMOAVZ7UidB9qLfG1YhNeundaUs
 jbZffzPx/Qf8uJZDGndCPcLqXdDBnXfhBqNzcYvoBs6urqs2647enB7hPJkPGzyBYVDH
 ag1syUcZKH0Ce2vxP3Zek8Wn1QzCDEL/7OjCqr0QuRWILclBej69CZRNeSYxrzlzRaSC
 0aYP0nUh0a0CcirDOpIJlimH8FqF60I+MqSuSMyPSmUsSM+a0D1qEUDdi0TOFMNAmoeW
 0xoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762020426; x=1762625226;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rS/rdp3aq5MCfQAWnKzAAUpzoZeeZrixJxmaUF/F18U=;
 b=JF4m5Ivgh1LUnWFz6JLqbpbQ/re6/jqGYUOyhI28RWBWXwybQ9prTm/OZZ7y3Bx0QH
 66iXB6Imi8T1q48OBapE98aLbogCOK1zLu2XYLCZRHY7tAJw+EScpiT/ESCIHnQI32Vp
 dmSoR+VL7XDqFxXl1atf5nd3fG3FqQAWzSbdgSReWfTtHh9uTdIQiPeFwz45KYFuzx+I
 P3JJxZVl7iQa3gvJZG9EgGCKwXrU33B4cqAhbB5ae6Oq6jopswIs/3DlGGOoJErPXFc9
 Y3Lfg6mzc/81XllSWBfTkwAHRgRZhrEkYlQj4WKzzKsp3pRv5UWDOac8bBcgcsh1eYt7
 fvEA==
X-Gm-Message-State: AOJu0Yzt1P3IozEcgVUpYDstEbAex1rJuXkgGRgOe899FQouCNLac/50
 vPYd7IX+Aw6hZ6hHUllIrBmHbdJe4kpi+05FMhIEBWQxCaTLa/suhkua6OrIgSwTf6kGHG9950A
 3r7Gt
X-Gm-Gg: ASbGnctWLSQGELIvmxmvaaw9xpSTfhlHcgGyhgiPi0BMB1glaB0JYxPfT/z0tNfX8Du
 VwRFlVfFZHSXOWGvuImOWXT+/QheOyH1GYAdlDMB7lmfz8C5DmD2mK3IabfERryOJmU5ld2RYDj
 lHSVVTyC8dVLbUGoK+xNIbcy27GYl88QYwhTxLI0goJuf32Y/FVZLexZHR3uOG+nrbziBUnx0VI
 +98hWUaNf822uJG7VH6XHQk1v7Uj6rzeURnjL1EzUJcjzIIVLDc3jaCbS8+2nP2be5EUXa0KHca
 z7aXiaGzue2u5cENswwsCBZwq7eEsJ84SiZlpRXFPwBcOQjl8Vr9XMrX0k1QfEpNcB9XUBAixDG
 JDByNlt9mOLt1x4shrF/HgCNKWjN+FTE63w3vBXm+5XWcRdS36UBUKKL2kIJL0mPLgtiOk8LZVR
 nQkUaViSz6XWOwaV3baDLAvPal2zVH5brlCf7Hq9s=
X-Google-Smtp-Source: AGHT+IHxWq1RcMXX+5u8PHGUeifbvA+nBPhyevoU/VJgfdprwDEjemz45381S6MlNMe0wJk/8zQKlg==
X-Received: by 2002:a05:6a00:94d5:b0:7a2:7058:ab89 with SMTP id
 d2e1a72fcca58-7a756c57a46mr9466496b3a.7.1762020425634; 
 Sat, 01 Nov 2025 11:07:05 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a7db0a019csm5861606b3a.42.2025.11.01.11.07.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Nov 2025 11:07:05 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v3 3/5] bpf: add a test for BPF ELF load
Date: Sat,  1 Nov 2025 11:04:45 -0700
Message-ID: <20251101180659.43883-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251101180659.43883-1-stephen@networkplumber.org>
References: <20251030173732.246435-1-stephen@networkplumber.org>
 <20251101180659.43883-1-stephen@networkplumber.org>
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

Create an ELF file to load using clang.
Repackage the object into an array using xdd.
Write a test to see load and run the BPF.

Draft version made with Claude AI, but it didn't work.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/bpf/load.c      |  62 +++++++++++++++++
 app/test/bpf/meson.build |  52 ++++++++++++++
 app/test/meson.build     |   2 +
 app/test/test_bpf.c      | 147 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 263 insertions(+)
 create mode 100644 app/test/bpf/load.c
 create mode 100644 app/test/bpf/meson.build

diff --git a/app/test/bpf/load.c b/app/test/bpf/load.c
new file mode 100644
index 0000000000..9678c110d9
--- /dev/null
+++ b/app/test/bpf/load.c
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * BPF program for testing rte_bpf_elf_load
+ */
+
+typedef unsigned char uint8_t;
+typedef unsigned short uint16_t;
+typedef unsigned int uint32_t;
+typedef unsigned long uint64_t;
+
+/* Match the structures from test_bpf.c */
+struct dummy_offset {
+	uint64_t u64;
+	uint32_t u32;
+	uint16_t u16;
+	uint8_t  u8;
+} __attribute__((packed));
+
+struct dummy_vect8 {
+	struct dummy_offset in[8];
+	struct dummy_offset out[8];
+};
+
+/* External function declaration - provided by test via xsym */
+extern void dummy_func1(const void *p, uint32_t *v32, uint64_t *v64);
+
+/*
+ * Test BPF function that will be loaded from ELF
+ * This function:
+ * 1. Reads values from input structure
+ * 2. Performs some computations
+ * 3. Writes results to output structure
+ * 4. Returns sum of values
+ */
+__attribute__((section("func"), used))
+uint64_t
+test_func(struct dummy_vect8 *arg)
+{
+	uint64_t sum = 0;
+	uint32_t v32;
+	uint64_t v64;
+
+	/* Load input values */
+	v32 = arg->in[0].u32;
+	v64 = arg->in[0].u64;
+
+	/* Call external function */
+	dummy_func1(arg, &v32, &v64);
+
+	/* Store results */
+	arg->out[0].u32 = v32;
+	arg->out[0].u64 = v64;
+
+	/* Calculate sum */
+	sum = arg->in[0].u64;
+	sum += arg->in[0].u32;
+	sum += arg->in[0].u16;
+	sum += arg->in[0].u8;
+	sum += v32;
+	sum += v64;
+
+	return sum;
+}
diff --git a/app/test/bpf/meson.build b/app/test/bpf/meson.build
new file mode 100644
index 0000000000..b4f54aa976
--- /dev/null
+++ b/app/test/bpf/meson.build
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright 2025 Stephen Hemminger <stephen@networkplumber.org>
+
+bpf_test_hdrs = [ ]
+
+# use clang to compile to bpf
+clang_supports_bpf = false
+clang = find_program('clang', required: false)
+if clang.found()
+    clang_supports_bpf = run_command(clang, '-target', 'bpf', '--print-supported-cpus',
+                                     check: false).returncode() == 0
+endif
+
+if not clang_supports_bpf
+    message('app/test_bpf: no BPF load tests missing clang BPF support')
+    subdir_done()
+
+endif
+
+xxd = find_program('xxd', required: false)
+if not xxd.found()
+    message('app/test_bpf: missing xxd required to convert object to array')
+    subdir_done()
+endif
+
+# BPF compiler flags
+bpf_cflags = [ '-O2', '-target', 'bpf', '-g', '-c']
+
+# Enable test in test_bpf.c
+cflags += '-DTEST_BPF_ELF_LOAD'
+
+# BPF sources to compile
+bpf_progs = {
+    'load' : 'test_bpf_load',
+}
+
+foreach bpf_src, bpf_hdr : bpf_progs
+    # Compile BPF C source to object file
+    bpf_obj = custom_target(bpf_src + '_o',
+        input: bpf_src + '.c',
+        output: bpf_src + '.o',
+        command: [ clang, bpf_cflags, '@INPUT@', '-o', '@OUTPUT@'])
+
+    # Convert object file to C header using xxd
+    bpf_test_h = custom_target(bpf_src + '_h',
+        input: bpf_obj,
+        output: bpf_hdr + '.h',
+        command: [ xxd, '-i', '@INPUT@', '@OUTPUT@'])
+
+    resources += bpf_test_h
+
+endforeach
diff --git a/app/test/meson.build b/app/test/meson.build
index 8df8d3edd1..efec42a6bf 100644
--- a/app/test/meson.build
+++ b/app/test/meson.build
@@ -281,6 +281,8 @@ if not is_windows
             install: false)
 endif
 
+subdir('bpf')
+
 subdir('test_cfgfiles')
 
 resources += test_cfgfile_h
diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
index 90e10d7d2c..ec84b85f1c 100644
--- a/app/test/test_bpf.c
+++ b/app/test/test_bpf.c
@@ -6,6 +6,7 @@
 #include <string.h>
 #include <stdint.h>
 #include <inttypes.h>
+#include <unistd.h>
 
 #include <rte_memory.h>
 #include <rte_debug.h>
@@ -14,6 +15,8 @@
 #include <rte_random.h>
 #include <rte_byteorder.h>
 #include <rte_errno.h>
+#include <rte_bpf.h>
+
 #include "test.h"
 
 #if !defined(RTE_LIB_BPF)
@@ -3278,6 +3281,150 @@ test_bpf(void)
 
 REGISTER_FAST_TEST(bpf_autotest, true, true, test_bpf);
 
+#ifdef TEST_BPF_ELF_LOAD
+
+/*
+ * Helper function to write BPF object data to temporary file.
+ * Returns temp file path on success, NULL on failure.
+ * Caller must free the returned path and unlink the file.
+ */
+static char *
+create_temp_bpf_file(const uint8_t *data, size_t size, const char *suffix)
+{
+	char *tmpfile = NULL;
+	int fd;
+	ssize_t written;
+
+	if (asprintf(&tmpfile, "/tmp/dpdk_bpf_%s_XXXXXX", suffix) < 0) {
+		printf("%s@%d: asprintf failed: %s\n",
+		       __func__, __LINE__, strerror(errno));
+		return NULL;
+	}
+
+	/* Create and open temp file */
+	fd = mkstemp(tmpfile);
+	if (fd < 0) {
+		printf("%s@%d: mkstemp(%s) failed: %s\n",
+		       __func__, __LINE__, tmpfile, strerror(errno));
+		free(tmpfile);
+		return NULL;
+	}
+
+	/* Write BPF object data */
+	written = write(fd, data, size);
+	close(fd);
+
+	if (written != (ssize_t)size) {
+		printf("%s@%d: write failed: %s\n",
+		       __func__, __LINE__, strerror(errno));
+		unlink(tmpfile);
+		free(tmpfile);
+		return NULL;
+	}
+
+	return tmpfile;
+}
+
+#include "test_bpf_load.h"
+
+static int
+test_bpf_elf_load(void)
+{
+	uint8_t tbuf[sizeof(struct dummy_vect8)];
+	const struct rte_bpf_xsym xsym[] = {
+		{
+			.name = RTE_STR(dummy_func1),
+			.type = RTE_BPF_XTYPE_FUNC,
+			.func = {
+				.val = (void *)dummy_func1,
+				.nb_args = 3,
+				.args = {
+					[0] = {
+						.type = RTE_BPF_ARG_PTR,
+						.size = sizeof(struct dummy_offset),
+					},
+					[1] = {
+						.type = RTE_BPF_ARG_PTR,
+						.size = sizeof(uint32_t),
+					},
+					[2] = {
+						.type = RTE_BPF_ARG_PTR,
+						.size = sizeof(uint64_t),
+					},
+				},
+			},
+		},
+	};
+	int ret;
+
+	/* Create temp file from embedded BPF object */
+	char *tmpfile = create_temp_bpf_file(app_test_bpf_load_o,
+					     app_test_bpf_load_o_len,
+					     "load");
+	if (tmpfile == NULL)
+		return -1;
+
+	/* Try to load BPF program from temp file */
+	const struct rte_bpf_prm prm = {
+		.xsym = xsym,
+		.nb_xsym = RTE_DIM(xsym),
+		.prog_arg = {
+			.type = RTE_BPF_ARG_PTR,
+			.size = sizeof(tbuf),
+		},
+	};
+	struct rte_bpf *bpf = rte_bpf_elf_load(&prm, tmpfile, "func");
+	TEST_ASSERT(bpf != NULL, "failed to load BPF from %s %d:%s",
+		    tmpfile, rte_errno, strerror(rte_errno));
+
+	/* Prepare test data */
+	struct dummy_vect8 *dv = (struct dummy_vect8 *)tbuf;
+	memset(dv, 0, sizeof(*dv));
+	dv->in[0].u64 = (int32_t)TEST_FILL_1;
+	dv->in[0].u32 = dv->in[0].u64;
+	dv->in[0].u16 = dv->in[0].u64;
+	dv->in[0].u8 = dv->in[0].u64;
+
+	/* Execute loaded BPF program */
+	uint64_t sum = rte_bpf_exec(bpf, tbuf);
+	TEST_ASSERT(sum != 0, "BPF execution returned: %" PRIu64, sum);
+
+	/* Test JIT if available */
+	struct rte_bpf_jit jit;
+	ret = rte_bpf_get_jit(bpf, &jit);
+	TEST_ASSERT(ret == 0, "rte_bpf_get_jit failed: %d", ret);
+
+	if (jit.func != NULL) {
+		memset(dv, 0, sizeof(*dv));
+		dv->in[0].u64 = (int32_t)TEST_FILL_1;
+		dv->in[0].u32 = dv->in[0].u64;
+		dv->in[0].u16 = dv->in[0].u64;
+		dv->in[0].u8 = dv->in[0].u64;
+
+		uint64_t jsum  = jit.func(tbuf);
+		TEST_ASSERT_EQUAL(sum, jsum, "BPF JIT execution difference");
+	}
+
+	rte_bpf_destroy(bpf);
+	unlink(tmpfile);
+	free(tmpfile);
+
+	printf("%s: ELF load test passed\n", __func__);
+	return TEST_SUCCESS;
+}
+#else
+
+static int
+test_bpf_elf_load(void)
+{
+	printf("BPF compile not supported, skipping test\n");
+	return TEST_SKIPPED;
+}
+
+#endif /* !TEST_BPF_ELF_LOAD */
+
+REGISTER_FAST_TEST(bpf_elf_load_autotest, true, true, test_bpf_elf_load);
+
 #ifndef RTE_HAS_LIBPCAP
 
 static int
-- 
2.51.0

