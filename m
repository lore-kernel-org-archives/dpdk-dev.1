Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E01CCFA18
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 22:57:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B92BE402E1;
	Tue, 11 Nov 2025 23:57:25 +0100 (CET)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47]) by mails.dpdk.org (Postfix) with ESMTP id 79CC34026A
 for <dev@dpdk.org>; Tue, 11 Nov 2025 23:57:24 +0100 (CET)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-343684a06b2so209239a91.1
 for <dev@dpdk.org>; Tue, 11 Nov 2025 14:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762901843;
 x=1763506643; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DoT4Kr2WE/unVmeHvu1S9a6vuB+AMS1g/dRu/qIMh+k=;
 b=MoMAe61ipaCiGT6gYXwGKp29n1FNN0eIL1Es2Ds2BvvdOMxMk6JbS5/0gc8p0uXd41
 Zh8tqTsYqxvy5Q4/7zTQaePktDz+i4u56OOTC1mP3NPDjsTQ0/YXH7yvguVthbUgNaqR
 WKzy3/x1BpOOfbUV3G1XxvmU/5apV8DklgHrWnTareTEwcgyjXgPvZzXI14l9JvpkKad
 WEsRrJOMrtGKy0/fyDR7KMI3U3EwIGzmAAiskdL7k0xlSJTkhCbiSwVQOgqaIyJDMPln
 VUMjStPUOBy3VnknQerlREaIf/EnMzKlkaZMyzk5Wxtl0YYS39RtSri2CcDzbwh/Ej9w
 og0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762901843; x=1763506643;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DoT4Kr2WE/unVmeHvu1S9a6vuB+AMS1g/dRu/qIMh+k=;
 b=m3X7DkrG9KNan7gwEuVQmQRrpdJ827G5t1FRdNTvCPSVPiAwyk/TWnhxHA8ss3Mbl3
 0lKeqO2mKDGldtqGIJolXBnrtVC+uVq4ybq6fFpRlEW0IuJ6BGYEKv7HD7gAm3mFIPiP
 JrnY9lwo9UKMQ1UhtSOB/UPgk2187gXksyTMvUh9w48x5brsMhROjBTNqT2pGrP91brq
 j6+jtrImICmWb6oSlHT8LlGE5LmXTe9vK4p8GN9CrkSaGdRswzhsRJpWlGo0ng8gLlFx
 goLFyEfJCF2893et2PojFvfJfAFmUECG3N12wGHTICrmd+f0xJInrHpf6nKJP8Bujg4v
 h5bA==
X-Gm-Message-State: AOJu0Yx8nOlS5fNypelUXWeN9/eJWBgcZdWB/xmOGpDvI7FedzpwulCC
 7FVF5BRO2JNm9Dws/VKPNHXcUete+wzok2HRa+A0MGSBZnJRkHzC+VnVv+pWvZ4duagCwOlxTzm
 Rg5nQ
X-Gm-Gg: ASbGncv4B9oC4/SFsrsSryIVOVWPXVYuIYH4QLgsmJqe87RMq5UX2/ZCoWQrPwoQ+to
 YndPzK081lRcEHYT4oBxybBrLd4Fqd5UELSbOmfbLyiMAar5uOsBPh3tCDJHfLMRr1g51Mpqp2n
 DkQ0pSnJXjf8cUIDBCu3wWo8YMP2Vrq8Bh750U/Poa6uctL9G76dzfY1oKGtBs1OB1QIQOyhXjo
 sz4Knecd+U50Df0ZAKZZouv+T7b3Cc62gyGltYo/0NaN8PZR7lV0h7486WnpA7U3Ih0aA/KSjPu
 2bPmpJdsKNDOFdGGDqJvXmjncr4ztlm2RUxxj1QuSg0G6HeFRyFQ0ENn9MvLaIY2UYDsATdyS04
 5x4MhjMTC7C02PWPZG5Yvj3DCy8fOKLBgUwfJgN1fz2xiAX/jt6mvGa+FVoUA+HIPFtRS3HIr1V
 nsTe2najg3uvTVTvjilZ4vnrd0P80ztJIH4ZcgtFxHGHg4y6t8BVdXh7CpZ0kI
X-Google-Smtp-Source: AGHT+IHAI9I1CDBFVs4EpNIc/VQEVAJ0Evjr2e4AnHcjwaYAj6WPYn0LzX5tjZnb7eDKpU26isCmXg==
X-Received: by 2002:a17:90b:3904:b0:343:bd86:b5a6 with SMTP id
 98e67ed59e1d1-343dded4ed4mr1017361a91.34.1762901843468; 
 Tue, 11 Nov 2025 14:57:23 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-343c4f6f78bsm1920831a91.3.2025.11.11.14.57.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 14:57:23 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Marat Khalili <marat.khalili@huawei.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v6 1/2] bpf: add a test for BPF ELF load
Date: Tue, 11 Nov 2025 14:55:46 -0800
Message-ID: <20251111225719.540140-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251111225719.540140-1-stephen@networkplumber.org>
References: <20251109200854.45942-1-stephen@networkplumber.org>
 <20251111225719.540140-1-stephen@networkplumber.org>
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

If libelf library is not available, then DPDK bpf
will return -ENOTSUP to the test and the test will be skipped.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Marat Khalili <marat.khalili@huawei.com>
---
 app/test/bpf/load.c      |  51 +++++++++++++
 app/test/bpf/meson.build |  52 +++++++++++++
 app/test/meson.build     |   2 +
 app/test/test_bpf.c      | 159 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 264 insertions(+)
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
index 90e10d7d2c..c460002358 100644
--- a/app/test/test_bpf.c
+++ b/app/test/test_bpf.c
@@ -6,6 +6,7 @@
 #include <string.h>
 #include <stdint.h>
 #include <inttypes.h>
+#include <unistd.h>
 
 #include <rte_memory.h>
 #include <rte_debug.h>
@@ -14,6 +15,7 @@
 #include <rte_random.h>
 #include <rte_byteorder.h>
 #include <rte_errno.h>
+
 #include "test.h"
 
 #if !defined(RTE_LIB_BPF)
@@ -3278,6 +3280,163 @@ test_bpf(void)
 
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
+	/* If libelf support is not available */
+	if (bpf == NULL && rte_errno == ENOTSUP)
+		return TEST_SKIPPED;
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

