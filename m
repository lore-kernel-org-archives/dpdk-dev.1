Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5310CCFA1A
	for <dpdk-dev@archiver.kernel.org>; Sun,  9 Nov 2025 20:09:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5BF31402E7;
	Sun,  9 Nov 2025 21:09:05 +0100 (CET)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47]) by mails.dpdk.org (Postfix) with ESMTP id 5D31B402E2
 for <dev@dpdk.org>; Sun,  9 Nov 2025 21:09:03 +0100 (CET)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-3437c093ef5so652923a91.0
 for <dev@dpdk.org>; Sun, 09 Nov 2025 12:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762718942;
 x=1763323742; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HEIo2u1IaKTN2gT/m4EhzT+lIfZORhHbWUY2Xe+VVcE=;
 b=J0NvsgaghHijn3w2m5hq4vJWOCy90Ell099AhysNpnsBLUIvEiayKyEvj1k8JAhS9a
 jVOpUeQM3kj1LBwR1ScPfXUngEpLWHBj9KMGOpoIzKOH6qmPGrclx/VvCjyzbh5Ifx6Q
 tlOWuYRw+tGhVaYmz+bvCXD3JzKO7IUzYgynis4fISvELXfdNKCypZkbgFdbPFkjwgRr
 kTHJK6qg9OFAtjwTa0AlqbUiImQARdj0V6TsiSi7VoQwLchbP7WsEGj8c6GRSzkc4DFF
 pgqhmp7iNRwpvQB2ioN29c29OiJtxvAz8BoVWrbE4qpyiPL3SWCU3nvivqPBiwaFXi7c
 uh4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762718942; x=1763323742;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HEIo2u1IaKTN2gT/m4EhzT+lIfZORhHbWUY2Xe+VVcE=;
 b=gUdf2BP5GOjnGmqlbsN0PIdwUQ0nrIVAWKQHpyrsmcYYgSr+vWabViu1s9MtY+6fBp
 tGHQGJot58KTDN9Sku43rydyLUZKP0qlbFYjHWW+Wh7F1uVyg1hExw9Sik2kU5IJBsaP
 3g55ZyOxJS5xRFFnQwCdDLO268PmIvsMdG1YSYM+AFwp+yjqd6AI6btXDZsMedOhKW56
 kkJcwUhOCeq1iNp+/HaPbDtDLNrTKBLwNV0Cynmy6d8tdRBCjvL0V1DxcD0YhiF8T3jt
 6FcokR13NyMZbgoRhVTB/QYK4aQ1IBf17QxcO6HafLccwIEICnw/lkxikBvpHlWfEat2
 m0Cw==
X-Gm-Message-State: AOJu0YziDmC2V8/J8ROd2DTNETor4eA2abMLK070jGypfa8BfGiLOv+o
 2XTnf3S/Ch83qOdWXbylaGeWYtyyl4huEskdMe5E+yb/NhsG00smEKF6pyeXdKs8vgobVx8ZMGl
 Ehn9Azng=
X-Gm-Gg: ASbGncvakD8Jw2ysxjlVPWWyhoK8gCUN1kNTRehddmJNM+IdoeHHjCGsFBFOBQ3iEBM
 YLR6FSciS4mlsDfkH7jytWqZat6FZ+LLMaXA83F+FPKAcjjJ5KQAMsJAfgRmbplj7yGChKx4ihc
 ZUhndCL/Y+KTXBLU1oRaQiLoj4zbc7M33aaigsZmALlJerJEysy2GcYFexVPgy11E2Z6W2oQkG+
 D3Pm+ARNRKwEbX5LtB4hVNdAGmhMsaflq7pVppoihjIoePtxholboz69PMRb1zxCx5VCknKr0Ht
 579ScqgRbLZvpoiUhjocPu6cfPYndhHKaGMLLo77Y2Vt2L/5JyiZHoblBVXNOfXruFRMmZaDNj4
 gMOZClUBTrsBHe2qJr1VMCKSgKLB6on9lWAbvy/W9UUd4uMa4zOppgfYhg8bch7aFdy7Q9x71mQ
 4QKNJxxUXLDoYAX9PRncxzbe7/Ow1mBjrKEPj5h4zr4up4YaEIQA==
X-Google-Smtp-Source: AGHT+IFqsQgO7zB86pROyOvVIf+zQWkhMPXxmvp3XahdE78RFkOj0KPFL8RsSt36TzWd0PBuoKlubg==
X-Received: by 2002:a17:90b:1f8f:b0:340:2a3a:71b7 with SMTP id
 98e67ed59e1d1-3436cb89aacmr9481181a91.12.1762718942490; 
 Sun, 09 Nov 2025 12:09:02 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-341a699d6dfsm15396648a91.16.2025.11.09.12.09.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Nov 2025 12:09:01 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v5 3/5] bpf: add a test for BPF ELF load
Date: Sun,  9 Nov 2025 12:07:36 -0800
Message-ID: <20251109200854.45942-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251109200854.45942-1-stephen@networkplumber.org>
References: <20251030173732.246435-1-stephen@networkplumber.org>
 <20251109200854.45942-1-stephen@networkplumber.org>
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
 app/test/bpf/load.c      |  51 +++++++++++++
 app/test/bpf/meson.build |  52 +++++++++++++
 app/test/meson.build     |   2 +
 app/test/test_bpf.c      | 156 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 261 insertions(+)
 create mode 100644 app/test/bpf/load.c
 create mode 100644 app/test/bpf/meson.build

diff --git a/app/test/bpf/load.c b/app/test/bpf/load.c
new file mode 100644
index 0000000000..a4d3d61d7a
--- /dev/null
+++ b/app/test/bpf/load.c
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ *
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
+ * This function is compiled version of code used in test_call1
+ */
+__attribute__((section("call1"), used))
+uint64_t
+test_call1(struct dummy_vect8 *arg)
+{
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
+	v64 += v32;
+	return v64;
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
index 90e10d7d2c..a80f41a543 100644
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
@@ -3278,6 +3281,159 @@ test_bpf(void)
 
 REGISTER_FAST_TEST(bpf_autotest, true, true, test_bpf);
 
+#ifdef TEST_BPF_ELF_LOAD
+
+/*
+ * Helper function to write BPF object data to temporary file.
+ * Returns temp file path on success, NULL on failure.
+ * Caller must free the returned path and unlink the file.
+ */
+static char *
+create_temp_bpf_file(const uint8_t *data, size_t size, const char *name)
+{
+	char *tmpfile = NULL;
+	int fd;
+	ssize_t written;
+
+	if (asprintf(&tmpfile, "/tmp/dpdk_bpf_%s_XXXXXX.o", name) < 0) {
+		printf("%s@%d: asprintf failed: %s\n",
+		       __func__, __LINE__, strerror(errno));
+		return NULL;
+	}
+
+	/* Create and open temp file */
+	fd = mkstemps(tmpfile, strlen(".o"));
+	if (fd < 0) {
+		printf("%s@%d: mkstemps(%s) failed: %s\n",
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
+/*
+ * Test loading BPF program from an object file.
+ * This test uses same arguments as previous test_call1 example.
+ */
+static int
+test_bpf_elf_load(void)
+{
+	static const char test_section[] = "call1";
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
+
+	struct rte_bpf *bpf = rte_bpf_elf_load(&prm, tmpfile, test_section);
+	unlink(tmpfile);
+	free(tmpfile);
+
+	TEST_ASSERT(bpf != NULL, "failed to load BPF %d:%s", rte_errno, strerror(rte_errno));
+
+	/* Prepare test data */
+	struct dummy_vect8 *dv = (struct dummy_vect8 *)tbuf;
+
+	memset(dv, 0, sizeof(*dv));
+	dv->in[0].u64 = (int32_t)TEST_FILL_1;
+	dv->in[0].u32 = dv->in[0].u64;
+	dv->in[0].u16 = dv->in[0].u64;
+	dv->in[0].u8 = dv->in[0].u64;
+
+	/* Execute loaded BPF program */
+	uint64_t rc = rte_bpf_exec(bpf, tbuf);
+	ret = test_call1_check(rc, tbuf);
+	TEST_ASSERT(ret == 0, "test_call1_check failed: %d", ret);
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
+		rc = jit.func(tbuf);
+		ret = test_call1_check(rc, tbuf);
+		TEST_ASSERT(ret == 0, "jit test_call1_check failed: %d", ret);
+	}
+
+	rte_bpf_destroy(bpf);
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

