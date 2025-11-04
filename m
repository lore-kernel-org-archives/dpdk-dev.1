Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10319CCFA07
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 16:09:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E611140673;
	Tue,  4 Nov 2025 17:08:53 +0100 (CET)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by mails.dpdk.org (Postfix) with ESMTP id 2BC9140668
 for <dev@dpdk.org>; Tue,  4 Nov 2025 17:08:52 +0100 (CET)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-b996c8db896so2810802a12.3
 for <dev@dpdk.org>; Tue, 04 Nov 2025 08:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762272531;
 x=1762877331; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rS/rdp3aq5MCfQAWnKzAAUpzoZeeZrixJxmaUF/F18U=;
 b=TG9Ngzs52K1WLPD7kDF5Gph2SYaH8Fv3EDfl8Wk1HjEcD0rRMgF69QJ6S3tPZKSIuz
 Y5ZmPdYCqXpMVIu3v3kxEyVyQIh1vmTOIdLSbpH7VXVKPyG6cCiJcypIKifmHhpBQYbA
 bEQnMzkFnsJ2ffMfYZVKoE2mtbKqZgCWEfzM2QvHYmojiE8Ic+Smve1MplCA+SP5fvU+
 SoAU9CK2isUArGmlpRSvqfV/gja0OPg+bWz9eS4fy0rtt5jKaoBXJIUW0gRxlzTvvBD5
 zKRZCe+ylE9HK4fHI0Vdco44QikXljMa6CXW4zrgbwFJ+i92t8bO3QAmI4Hk13Zus2Vr
 gVYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762272531; x=1762877331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rS/rdp3aq5MCfQAWnKzAAUpzoZeeZrixJxmaUF/F18U=;
 b=eoAHKyMPzE5TlPZIaciSpFr2MKW9VqhQxDEurR1P3iKfM4tnQY6YWnZ53OB75ONTjM
 U4fEJ8Yd6pO1Rd+RZsKZdD/eppkcQ6GvpBz7UKNQ4opwbFqLP8sOVtis6dkfHbehYrsX
 od3YqFJGA2+X9vf8oCj0AxUVoihKbdRPTa3stNv/RQrFxc6SmN57ddMLVLrKrCToXkBE
 7xo/ZynLT75GWqjxpKe9cwTMz68L9RaqoYMQ+n10mF+dncNJiY+c11dQH1XOOjE6nvhP
 MezIgmBma/q4lopIffryw3YVIzJjyPwFSQd7pNOi9GkKJm5wEJfZKmNmMqjtb4WyLLB8
 RZpg==
X-Gm-Message-State: AOJu0Yw5Tn1/wBlN/3AD/qTEnbBcliSvkkVLPOrkQKgkSiIy3Fz1llu8
 /NaDcAkg7N/JMQBvJuwJB1B7Ni4e51ekRr2k3U6m41QhLzeMw/YtakHY8pmcPu3tI2zY2Kq2AWt
 81dW6
X-Gm-Gg: ASbGncstESNCB9yOtJl6VDDbC2q7YH4k2e0IVkecIGS9bZ56Do9wHHTrJA8Aw6bWmGm
 LYGWHvLPwldVBEfUlmZx/X4gcAcOhk5Pd+Z2kgS6jzkxTiJMkdNCBJKx3qnRTKFmNVNnOrkFTUr
 un12wKQ+2JyaIBawY2TYTG36BFqLcog1sOzoWo2gUgLxhbZ2XlPgdJE51DxlJx911hk0Ajf+p65
 wBBEwxmuwnKktU2HBuisib6CbY3p5sUlskggWVyL+09wx5j5+n3wxx+eANwl8hgx4kaTF98Hz1n
 9QHSHgxwqfHIvqk9BzIUyHVMABd7YVbxGK2zmhGQTTzvZBwQQ7786F6xO7cXfvc3OYaVVhiHYPK
 q+1oGkQj5ZkHN595luF8Onv6dQPB+YAiFU82YiBMj8HgyGj80vUykwEl+rLTwjdI5gvFIprSU8n
 PpcZczk3l8E9Yw8SzNUW6Efok44DLBTtqynODf0T4=
X-Google-Smtp-Source: AGHT+IGcWRbQURFXcO955C8XFn556mG0RwhL/hn5Jek6lO9XfCBbyc0wzY+z7fL7oekne655J/+LBQ==
X-Received: by 2002:a05:6a20:6a08:b0:2be:81e3:1124 with SMTP id
 adf61e73a8af0-348ca56567emr22773200637.2.1762272531121; 
 Tue, 04 Nov 2025 08:08:51 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34159941803sm5084800a91.6.2025.11.04.08.08.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 08:08:50 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v4 3/5] bpf: add a test for BPF ELF load
Date: Tue,  4 Nov 2025 08:07:28 -0800
Message-ID: <20251104160843.304044-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104160843.304044-1-stephen@networkplumber.org>
References: <20251030173732.246435-1-stephen@networkplumber.org>
 <20251104160843.304044-1-stephen@networkplumber.org>
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

