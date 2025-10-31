Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B329CCFA00
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Oct 2025 16:44:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CFD714065A;
	Fri, 31 Oct 2025 17:44:26 +0100 (CET)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by mails.dpdk.org (Postfix) with ESMTP id 3F43840657
 for <dev@dpdk.org>; Fri, 31 Oct 2025 17:44:24 +0100 (CET)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-b5a631b9c82so1636676a12.1
 for <dev@dpdk.org>; Fri, 31 Oct 2025 09:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761929063;
 x=1762533863; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v0ywnLOu+LsAI7/T2hc1BXwvZJNmje6XAeCmAIekDcQ=;
 b=TFKlCH1DlfCd+Il9PMelRJbwn3f95JvZRt7lGw7fpDjxPpCcemXrmP3xu1cL6tSAOf
 Hg8xlMwRivSMrB+JBSIwDtHfjU8O41rU6M7VU0nKf0ftlZobHxKVBAwphbWG9/3VESbt
 dHni9yBooh4/dbDa1DBhS4qfWm/vwR4qUeO5m7slvXKHVuq670vNN1pxPAH49G3zQn4Q
 Vf05a7bWYZbXnvKRC5eF5bVDSHwzZ9e080de64aRCmbOyKOWwS5WWgHC40xY8SLgvoob
 BGil43Iu1gblgI9N7wC9k4+ZPPdyGDMiatkjPkUU1TF0t+t7mbBGYAJJ3T08oKV+nU/1
 4qyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761929063; x=1762533863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v0ywnLOu+LsAI7/T2hc1BXwvZJNmje6XAeCmAIekDcQ=;
 b=RpdT+e68YhxSciFW2/PYKerSb2sO5hpfx1mOaXhQy/uRyZbcsyjcKcOvJBasIuccDi
 TFV7u/hQpo/xikR9DXHSODmVQxLCsNMRhYHatqtzL0ePYx7kGFBRuF7cExzTl7VaAzrI
 OrutcoFFD+9hxlwRJnj3/mhKK5GrNTZii6kw8ucNtVOlTit5r7BjuXCbRJbu1gtjKPfV
 7Uj8UhL6xfDQfpJ2WBkVRQDyp39sNmgCljBzYxXgapWGJzaSghi+hawDrmPWXJ0Fw0zd
 e6pXj4jJIsEf+iNPWIRKX13t9YeWHWfQMxCJZLFsAB719dfopzOkhsn8ZiO2tqu3iZ+F
 RZbQ==
X-Gm-Message-State: AOJu0YzHYlPpijdzYKCwc2WJ3MJl8BVWV0vQVaB7i0VNX51dolzU3N15
 tRCdKj1HIZ8aprxXOVFOF2fRTNr3rmlVzYEJAiO+q7VdO8KboJuhymlgo+2ksWDUPlCiYV7CqVA
 xOj8s
X-Gm-Gg: ASbGncv0KyTmi3l8X6BM94TK9GStwA1RY8SyTwlZc4b5Xg/GRTTIAYn4HPoMPFCRbsD
 gLRKtE0TEdACkgIf50wZZCPLsfTQEnozJe5hetX0K8lu6IOyn4uiyXGwvfx2pbuv2rPC7M1gfGJ
 nzC1SZzg6x0c1M4HxZQkqu0Uho1HOq+OlN1pPYUsjERjFj8IN+awO356QncArfW9qkiqJrchmNW
 LRFOTI7vlNA9P22Zp5j0AYnnRsmFyxsK9NS0GVfPZ/qfVVgoHq7Y6yddxDi0xVuqBwvnv//wSgq
 DUXT0rdo/Xd/KKpmzfL5yxDYvWT+GqKya4bRk5/iwMClP4eTBlegmOwcR1oILFwFZ4i1ve/w4MX
 ZU9ZKji4tfN/eMWtFjqjh4pD+Ns/0Bsx7TujHmFXZf5YwfUl5XU22EHN+zH74rzfoRHail1Zybf
 3x5fr1r3nyUORWPB06TFTazlS7Dp5g+UFho+OGz3k=
X-Google-Smtp-Source: AGHT+IFCb8D4Ygt6deE/rWelbrmR5DVZPGcrwCNCMJyXhn1cc9TdI6uMcxlIigfw8yA/9ho9eFbj7w==
X-Received: by 2002:a17:902:d48a:b0:295:3d5d:fe3b with SMTP id
 d9443c01a7336-2953d5e051amr19748135ad.28.1761929063244; 
 Fri, 31 Oct 2025 09:44:23 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-295269a8ddcsm28391845ad.91.2025.10.31.09.44.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 09:44:22 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v2 3/5] bpf: add a test for BPF ELF load
Date: Fri, 31 Oct 2025 09:41:47 -0700
Message-ID: <20251031164417.14166-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031164417.14166-1-stephen@networkplumber.org>
References: <20251030173732.246435-1-stephen@networkplumber.org>
 <20251031164417.14166-1-stephen@networkplumber.org>
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
 app/test/bpf/meson.build     |  52 +++++++++++++
 app/test/bpf/test_bpf_load.c |  62 +++++++++++++++
 app/test/meson.build         |   2 +
 app/test/test_bpf.c          | 146 +++++++++++++++++++++++++++++++++++
 4 files changed, 262 insertions(+)
 create mode 100644 app/test/bpf/meson.build
 create mode 100644 app/test/bpf/test_bpf_load.c

diff --git a/app/test/bpf/meson.build b/app/test/bpf/meson.build
new file mode 100644
index 0000000000..2b944f5ea9
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
+test_bpf_progs = [
+    'test_bpf_load'
+]
+
+foreach test_name : test_bpf_progs
+    # Compile BPF C source to object file
+    bpf_obj = custom_target(test_name + '_o',
+        input: test_name + '.c',
+        output: test_name + '.o',
+        command: [ clang, bpf_cflags, '@INPUT@', '-o', '@OUTPUT@'])
+
+    # Convert object file to C header using xxd
+    bpf_test_h = custom_target(test_name + '_h',
+        input: bpf_obj,
+        output: test_name + '.h',
+        command: [ xxd, '-i', '-n', test_name + '_data','@INPUT@', '@OUTPUT@'])
+
+    resources += bpf_test_h
+
+endforeach
diff --git a/app/test/bpf/test_bpf_load.c b/app/test/bpf/test_bpf_load.c
new file mode 100644
index 0000000000..9678c110d9
--- /dev/null
+++ b/app/test/bpf/test_bpf_load.c
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
index 90e10d7d2c..855fdc8ad1 100644
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
@@ -3278,6 +3281,149 @@ test_bpf(void)
 
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
+	char *tmpfile = create_temp_bpf_file(test_bpf_load_data,
+				       test_bpf_load_data_len, "load");
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

