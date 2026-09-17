Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15168C982D6
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 14:37:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2F0B642F6F;
	Thu, 17 Sep 2026 16:36:45 +0200 (CEST)
Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com
 [74.125.228.76]) by mails.dpdk.org (Postfix) with ESMTP id A942B42F1B
 for <dev@dpdk.org>; Thu, 17 Sep 2026 16:36:43 +0200 (CEST)
Received: by mail-ed2-f12.google.com with SMTP id
 4fb4d7f45d1cf-6a9a2b95b72so1466034a12.2
 for <dev@dpdk.org>; Thu, 17 Sep 2026 07:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789655803; x=1790260603; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JiKVEpgbv7U45Hxxf54cJwGlCyiui2YldjmAwIYr7Tk=;
 b=S0LfT3zkmqNTYulImY9vUZf+7KrCozTKTc12I42qHPHHn0UnqzjSCcpCwHMEzdnfvw
 MTWxLggDs+kbe/R9300zvDhhO4OffAtKCrFC5wWCLlG/x1S8eUpynb6TZdU1khKJVERj
 oW4Oy1rHYh4ymrGo6HbEylAqwtZ366Jf7ByfptBXO8V+jG6MjJdUXE1AMVejczo4TRE1
 HTDQGMX+IuC4BOSfQNZ9/gXuciG5tyuzu2yJOf/MqrBHUviGJLKk4NZTc0yDq0i+2dGM
 F9uMdfDU9srKbrT+tNAUWigyNHhX5Ra6orDQJwsCGZjo3PZL0SUt8efZann75R5m8Dfk
 bk2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789655803; x=1790260603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JiKVEpgbv7U45Hxxf54cJwGlCyiui2YldjmAwIYr7Tk=;
 b=FPvkgolL6LMY26nKIIprCscOfVqd26HEMIj+E1dzgv1sPCHvRif5tamPMYOqnxOkq1
 JSOgdUkYs7HwIoiaUxHEsf30xQ5dPGwltrsam6m2AnuP+Z0Sxk8xhvLx2g18ApXUGzok
 tC+DzM8pHv0UoXaFsZaFVy7zsiqDo0w0PxE6agaS5vRLpic7fT6qFwMrxJ6FjIqA+8eP
 NZDzxG9mMFmrLInDlmqVOhXKL8cLOJcCFJE63aIvTIFjKWs1KTAYFs7dk9ldzOfcvMFl
 eyqllZ3B4pspE1imw/X6MFIUOz9Lu9c9Xf4X28cUNfcKMdBl713uPdCp0e9vfU21MhkM
 D8mA==
X-Gm-Message-State: AFuF++n6JqZeIMGoWIYXyM6vpW4O0T72oRGtQBOR5deh7wfySxziGoDl
 ULygS+brW1flp8sPXsmqwcPmyQNFnJ99j9ExwPaMahhjDgAL1oz1+r+J
X-Gm-Gg: AYBFou1CQO60u1/CXtvJhDNEZqjrohSTyUgrbEWoIbI1wpC1ZLiVSltWvLFTlIgWBpK
 9ZEz6ldOq6aJUgM5Gmx+E3SEQ/LKl5oYcllqcAdE/UQSsp5VlpEVbq72J8+RJirqac2vvKjDdNJ
 e9gZH7cuX7Nh/mGAV3HwmEAIvW6ZVErQ+RA4STNRqp4AnzXo7MC+3qc1WEWX23yIr2or25Qa9Z4
 BkkwwGvqH9DzCn5JMDgmgPMmZlvXhaTFMPnAwPTmJdJ7ggWS2OY9Lew9SIxe9dcOjT/EHl6RI/O
 Vt1tYj3EnL966gtsf8pOJsklf+v35982wGCMcwJsi5cB5cTAta52/478Up3W/iHrBnx//l97zDd
 Yp9c+G+5aTIipr/ZZwp4EkxAh1WKzKAbaJ0fKnCvr4Bw9dOxwET5Da1asEouJTjAINjyRgHHcku
 iofA4wvJyxV01Ga4ptpse0Wgmp0oVhZ3S2XBQoGflT1mvaVEbIcciPICY4cdU=
X-Received: by 2002:a05:6402:44da:b0:6a9:a5d6:622d with SMTP id
 4fb4d7f45d1cf-6aa2223ac18mr4018330a12.3.1789655802425; 
 Thu, 17 Sep 2026 07:36:42 -0700 (PDT)
Received: from dpdk.lxd ([89.101.57.120]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6aa1d2727bfsm3440986a12.20.2026.09.17.07.36.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 07:36:41 -0700 (PDT)
From: Marat Khalili <qm2k21@gmail.com>
To: Thomas Monjalon <thomas@monjalon.net>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <qm2k21@gmail.com>
Cc: dev@dpdk.org, Marat Khalili <marat.khalili@huawei.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 7/7] app/validate-bpf: add BPF validation application
Date: Thu, 17 Sep 2026 14:35:37 +0000
Message-ID: <20260917143539.46951-8-qm2k21@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917143539.46951-1-qm2k21@gmail.com>
References: <20260915192626.48125-1-marat.khalili@huawei.com>
 <20260917143539.46951-1-qm2k21@gmail.com>
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

From: Marat Khalili <marat.khalili@huawei.com>

Add a new DPDK application, dpdk-validate-bpf, for pre-validating eBPF
programs for compatibility with the lib/bpf execution context.

The application allows evaluating eBPF programs against the DPDK verifier
before loading them into a real application. It includes an interactive
debugging mode to trace state changes per instruction and understand the
validator's decisions.

Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
---
 MAINTAINERS                            |    2 +
 app/meson.build                        |    1 +
 app/validate-bpf/alloc_list.c          |   53 ++
 app/validate-bpf/args.c                |  262 ++++++
 app/validate-bpf/debug.c               | 1087 ++++++++++++++++++++++++
 app/validate-bpf/debug_command.c       |  383 +++++++++
 app/validate-bpf/debug_command.h       |   65 ++
 app/validate-bpf/eal_init_args.c       |   57 ++
 app/validate-bpf/internal.h            |  151 ++++
 app/validate-bpf/main.c                |   90 ++
 app/validate-bpf/meson.build           |   13 +
 app/validate-bpf/parse_decl.c          |  616 ++++++++++++++
 doc/guides/rel_notes/release_26_11.rst |    5 +
 doc/guides/tools/index.rst             |    1 +
 doc/guides/tools/validate_bpf.rst      |   97 +++
 15 files changed, 2883 insertions(+)
 create mode 100644 app/validate-bpf/alloc_list.c
 create mode 100644 app/validate-bpf/args.c
 create mode 100644 app/validate-bpf/debug.c
 create mode 100644 app/validate-bpf/debug_command.c
 create mode 100644 app/validate-bpf/debug_command.h
 create mode 100644 app/validate-bpf/eal_init_args.c
 create mode 100644 app/validate-bpf/internal.h
 create mode 100644 app/validate-bpf/main.c
 create mode 100644 app/validate-bpf/meson.build
 create mode 100644 app/validate-bpf/parse_decl.c
 create mode 100644 doc/guides/tools/validate_bpf.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index 8c50c52933..affaf57492 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1917,8 +1917,10 @@ F: lib/bpf/
 F: examples/bpf/
 F: app/test/test_bpf*
 F: app/test/bpf/
+F: app/validate-bpf/
 F: app/test-pmd/bpf_cmd.*
 F: doc/guides/prog_guide/bpf_lib.rst
+F: doc/guides/tools/validate_bpf.rst
 
 Graph
 M: Jerin Jacob <jerinj@marvell.com>
diff --git a/app/meson.build b/app/meson.build
index 1798db3ae4..9b59ae4830 100644
--- a/app/meson.build
+++ b/app/meson.build
@@ -33,6 +33,7 @@ apps = [
         'test-regex',
         'test-sad',
         'test-security-perf',
+        'validate-bpf',
 ]
 
 if get_option('tests')
diff --git a/app/validate-bpf/alloc_list.c b/app/validate-bpf/alloc_list.c
new file mode 100644
index 0000000000..2f4d18ad3d
--- /dev/null
+++ b/app/validate-bpf/alloc_list.c
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd
+ */
+
+#include "internal.h"
+#include <stdlib.h>
+
+
+/* Needs to be a power of two. */
+#define START_CAPACITY (1u << 3)
+
+size_t
+alloc_list_append(struct alloc_list *alloc_list, void *ptr)
+{
+	if (alloc_list->count == 0) {
+		RTE_ASSERT(alloc_list->ptrs == NULL);
+		alloc_list->ptrs = malloc(
+			sizeof(alloc_list->ptrs[0]) * START_CAPACITY);
+		RTE_VERIFY(alloc_list->ptrs != NULL);
+	} else if (alloc_list->count >= START_CAPACITY &&
+			/* Power of two detection */
+			(alloc_list->count & (alloc_list->count - 1)) == 0) {
+		/*
+		 * We allocate in powers of two, and current count is one of
+		 * these powers, so need to reallocate to larger capacity.
+		 */
+		RTE_ASSERT(alloc_list->ptrs != NULL);
+		const size_t new_capacity = alloc_list->count * 2;
+		alloc_list->ptrs = realloc(alloc_list->ptrs,
+			sizeof(alloc_list->ptrs[0]) * new_capacity);
+		RTE_VERIFY(alloc_list->ptrs != NULL);
+	}
+	alloc_list->ptrs[alloc_list->count] = ptr;
+	return alloc_list->count++;
+}
+
+void alloc_list_replace(struct alloc_list *alloc_list, size_t index, void *ptr)
+{
+	RTE_ASSERT(index < alloc_list->count);
+	alloc_list->ptrs[index] = ptr;
+}
+
+void alloc_list_free_all(struct alloc_list *alloc_list)
+{
+	/* Copy and clear fields first in case alloc_list itself gets freed. */
+	size_t count = alloc_list->count;
+	void ** const ptrs = alloc_list->ptrs;
+	*alloc_list = (struct alloc_list){};
+
+	while (count != 0)
+		free(ptrs[--count]);
+	free(ptrs);
+}
diff --git a/app/validate-bpf/args.c b/app/validate-bpf/args.c
new file mode 100644
index 0000000000..b11591ee70
--- /dev/null
+++ b/app/validate-bpf/args.c
@@ -0,0 +1,262 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd
+ */
+
+#include "internal.h"
+
+#include <ctype.h>
+#include <getopt.h>
+#include <stdlib.h>
+
+#include <rte_errno.h>
+
+
+/* Values to be used in getopt_long option.val. */
+enum app_args {
+	ARG_UNRECOGNIZED = '?',
+	ARG_AUTO = 0,	/* Value set by getopt_long when flag is non-NULL. */
+	ARG_HELP,	/* Keep this one in the beginning for UX reasons. */
+	ARG_DEBUG,
+	ARG_MBUF_BUF_SIZE,
+	ARG_NO_PROG_ARGS,
+	ARG_PROG_ARG,
+	ARG_SECTION,
+	ARG_XSYM,
+};
+
+/* Program options. */
+static struct option app_options[] = {
+	{
+		.name = "help",
+		.val = ARG_HELP,
+	},
+	{
+		.name = "debug",
+		.val = ARG_DEBUG,
+	},
+	{
+		.name = "mbuf-buf-size",
+		.has_arg = required_argument,
+		.val = ARG_MBUF_BUF_SIZE,
+	},
+	{
+		.name = "no-prog-arg",
+		.val = ARG_NO_PROG_ARGS,
+	},
+	{
+		.name = "no-prog-args",
+		.val = ARG_NO_PROG_ARGS,
+	},
+	{
+		.name = "prog-arg",
+		.has_arg = required_argument,
+		.val = ARG_PROG_ARG,
+	},
+	{
+		.name = "section",
+		.has_arg = required_argument,
+		.val = ARG_SECTION,
+	},
+	{
+		.name = "xsym",
+		.has_arg = required_argument,
+		.val = ARG_XSYM,
+	},
+	{ /* terminating zero record */ }
+};
+
+/* Default args value. */
+static const struct args args_default = {
+	.bpf_prm = {
+		.sz = sizeof(struct rte_bpf_prm_ex),
+		.origin = RTE_BPF_ORIGIN_ELF_FILE,
+		.elf_file.section = ".text",
+	},
+	.mbuf_buf_size = RTE_MBUF_DEFAULT_BUF_SIZE,
+};
+
+/* Default --prog-arg argument value. */
+static const char * const prog_arg_default = "struct rte_mbuf *";
+
+
+void
+print_usage(const char *program_name)
+{
+	static const char *const options[][2] = {
+		{ "--help", "Display help and exit." },
+		{ "--debug", "Enable interactive debug mode." },
+		{ "--mbuf-buf-size=MBUF_BUF_SIZE", "Size of the mbuf data buffer (in bytes)." },
+		{ "--prog-arg=TYPE", "Expected type of the next BPF program argument (up to 5)." },
+		{ "--no-prog-args", "BPF program does not take any arguments." },
+		{ "--section=SECTION", "ELF section name in the BPF object file to load." },
+		{ "--xsym='TYPE NAME[(TYPE, ...)]'", "External symbol BPF program can access." },
+	};
+
+	printf("USAGE: %s [OPTIONS]... BPF_PATH\n", program_name);
+	printf("OPTIONS:\n");
+	for (int oi = 0; oi != RTE_DIM(options); ++oi)
+		printf("\t%-31s %s\n", options[oi][0], options[oi][1]);
+}
+
+void
+print_defaults(void)
+{
+	printf("DEFAULTS:"
+			" --mbuf-buf-size=%#zx"
+			" --prog-arg='%s'"
+			" --section='%s'\n",
+		(size_t)RTE_MBUF_DEFAULT_BUF_SIZE,
+		prog_arg_default,
+		args_default.bpf_prm.elf_file.section);
+}
+
+static int
+parse_size(size_t *result, const char *text)
+{
+	char *parse_end = NULL;
+
+	errno = 0;
+	const unsigned long strtoul_result = strtoul(text, &parse_end, 0);
+	if (errno != 0 || *parse_end != '\0' || strtoul_result == 0)
+		return -1;
+
+	*result = strtoul_result;
+	return 0;
+}
+
+struct args *
+args_parse(int argc, char *argv[])
+{
+	int val;
+	size_t xsym_alloc_index;
+	struct rte_bpf_xsym *xsym = NULL;
+	const char * const program_name = argv[0];
+
+	/* Allocate args and set aliases for some of its members. */
+	struct args * const args = malloc(sizeof(*args));
+	RTE_VERIFY(args != NULL);
+	struct alloc_list * const alloc_list = &args->_alloc_list;
+	struct rte_bpf_prm_ex * const bpf_prm = &args->bpf_prm;
+
+	/* Set default values. */
+	*args = args_default;
+	RTE_VERIFY(parse_arg(&bpf_prm->prog_arg[bpf_prm->nb_prog_arg++],
+		prog_arg_default) >= 0);
+	bool default_prog_args = true;
+
+	/* Reserve space for xsym in alloc_list. */
+	xsym_alloc_index = alloc_list_append(alloc_list, xsym);
+
+	while ((val = getopt_long(argc, argv, "", app_options, NULL)) != EOF) {
+		int rc = 0;
+		switch (val) {
+		case ARG_AUTO:
+			/* getopt_long made the assignment, nothing to do */
+			break;
+		case ARG_HELP:
+			args->show_help = true;
+			break;
+		case ARG_DEBUG:
+			if (bpf_prm->debug == NULL)
+				bpf_prm->debug = debug_create();
+			if (bpf_prm->debug == NULL) {
+				rc = -rte_errno;
+				fprintf(stderr,
+					"%s: error %d creating debug session\n",
+					program_name, -rc);
+			}
+			break;
+		case ARG_MBUF_BUF_SIZE:
+			rc = parse_size(&args->mbuf_buf_size, optarg);
+			if (rc < 0)
+				fprintf(stderr,
+					"%s: invalid mbuf buf size '%s'\n",
+					program_name, optarg);
+			break;
+		case ARG_NO_PROG_ARGS:
+			bpf_prm->nb_prog_arg = 0;
+			default_prog_args = false;
+			break;
+		case ARG_PROG_ARG:
+			if (default_prog_args) {
+				bpf_prm->nb_prog_arg = 0;
+				default_prog_args = false;
+			}
+
+			if (bpf_prm->nb_prog_arg == RTE_DIM(bpf_prm->prog_arg)) {
+				fprintf(stderr,
+					"%s: at most %d program arguments allowed\n",
+					program_name,
+					(int)RTE_DIM(bpf_prm->prog_arg));
+				rc = -EINVAL;
+				break;
+			}
+
+			rc = parse_arg(&bpf_prm->prog_arg[bpf_prm->nb_prog_arg++],
+				optarg);
+			if (rc < 0)
+				fprintf(stderr,
+					"%s: unrecognized prog arg '%s'\n",
+					program_name, optarg);
+
+			break;
+		case ARG_SECTION:
+			bpf_prm->elf_file.section = optarg;
+			break;
+		case ARG_XSYM:
+			bpf_prm->xsym = xsym = realloc(xsym,
+				sizeof(xsym[0]) * (bpf_prm->nb_xsym + 1));
+			RTE_VERIFY(xsym != NULL);
+			alloc_list_replace(alloc_list, xsym_alloc_index, xsym);
+			rc = parse_xsym(&xsym[bpf_prm->nb_xsym++], optarg,
+					alloc_list);
+			if (rc < 0)
+				fprintf(stderr, "%s: invalid xsym '%s'\n",
+					program_name, optarg);
+			break;
+		case ARG_UNRECOGNIZED:
+			args_destroy(args);
+			return NULL;
+		default:
+			rte_panic("Unexpected getopt_long return value %d\n",
+				val);
+		}
+		if (rc < 0) {
+			args_destroy(args);
+			return NULL;
+		}
+	}
+
+	/* Set buf_size to the value specified in command line arguments. */
+	adjust_arg_buf_size(bpf_prm->prog_arg, args->mbuf_buf_size);
+	for (size_t xsymi = 0; xsymi != bpf_prm->nb_xsym; ++xsymi)
+		adjust_xsym_buf_size(&xsym[xsymi], args->mbuf_buf_size);
+
+	/* getopt_long moves all non-options to the end, starting at optind. */
+	const int nb_bpf_path = argc - optind;
+	switch (nb_bpf_path) {
+	case 0:
+		break;
+	case 1:
+		bpf_prm->elf_file.path = argv[optind];
+		break;
+	default:
+		fprintf(stderr, "%s: too many positional arguments\n",
+			program_name);
+		args_destroy(args);
+		return NULL;
+	}
+
+	return args;
+}
+
+void
+args_destroy(struct args *args)
+{
+	if (args == NULL)
+		return;
+	if (args->bpf_prm.debug != NULL)
+		debug_destroy(args->bpf_prm.debug);
+	alloc_list_free_all(&args->_alloc_list);
+	free(args);
+}
diff --git a/app/validate-bpf/debug.c b/app/validate-bpf/debug.c
new file mode 100644
index 0000000000..33fabad511
--- /dev/null
+++ b/app/validate-bpf/debug.c
@@ -0,0 +1,1087 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd
+ */
+
+#include "debug_command.h"
+#include "internal.h"
+
+#include <rte_bpf_validate_debug.h>
+#include <rte_errno.h>
+
+#include <inttypes.h>
+#include <stdlib.h>
+
+
+/* Write single line to the user, currently just to stdout. */
+#define PRINTLN(fmt, ...) do { \
+	RTE_LOG_CHECK_NO_NEWLINE(fmt); \
+	printf(fmt "\n", ##__VA_ARGS__); \
+} while (0)
+
+#define PROMPT "(validate) "
+
+#define INITIAL_CAPACITY 8u
+
+static const char *const event_names[] = {
+	[RTE_BPF_VALIDATE_DEBUG_EVENT_INVALID_STATE] = "invalid-state",
+	[RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_ENTER] = "branch-enter",
+	[RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_PRUNE] = "branch-prune",
+	[RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_RETURN] = "branch-return",
+	[RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_UNREACHABLE] = "branch-unreachable",
+	[RTE_BPF_VALIDATE_DEBUG_EVENT_JUMP_ALWAYS] = "jump-always",
+	[RTE_BPF_VALIDATE_DEBUG_EVENT_JUMP_CONDITIONAL] = "jump-conditional",
+};
+
+static const char *const register_names[] = {
+	[EBPF_REG_0] = "r0",
+	[EBPF_REG_1] = "r1",
+	[EBPF_REG_2] = "r2",
+	[EBPF_REG_3] = "r3",
+	[EBPF_REG_4] = "r4",
+	[EBPF_REG_5] = "r5",
+	[EBPF_REG_6] = "r6",
+	[EBPF_REG_7] = "r7",
+	[EBPF_REG_8] = "r8",
+	[EBPF_REG_9] = "r9",
+	[EBPF_REG_10] = "r10",
+};
+
+static const char *const comparison_operator_names[] = {
+	[BPF_JEQ] = "==",
+	[BPF_JGT] = ">",
+	[BPF_JGE] = ">=",
+	[EBPF_JNE] = "!=",
+	[EBPF_JSGT] = "s>",
+	[EBPF_JSGE] = "s>=",
+	[EBPF_JLT] = "<",
+	[EBPF_JLE] = "<=",
+	[EBPF_JSLT] = "s<",
+	[EBPF_JSLE] = "s<=",
+};
+
+enum point_type {
+	POINT_TYPE_BREAK,
+	POINT_TYPE_CATCH,
+};
+
+/* Local representation of points with additional info for UI. */
+struct point_info {
+	struct rte_bpf_validate_debug_point *point;
+	enum point_type type;
+	union {
+		uint32_t pc;
+		enum rte_bpf_validate_debug_event event;
+	};
+};
+
+/* Dynamically growing list of point infos. */
+struct point_infos {
+	struct point_info *elements;
+	uint32_t length;
+	uint32_t capacity;
+};
+
+/* Information about a single conditional or unconditional jump in code path. */
+struct branch_info {
+	uint32_t jump_pc;
+	uint32_t target_pc;
+	bool is_conditional;
+};
+
+/* Dynamically growing stack to track code path. */
+struct branch_stack {
+	struct branch_info *branches;
+	uint32_t length;
+	uint32_t capacity;
+};
+
+/* Flags telling if we should validate again, stopping or not at start. */
+static bool validate_again;
+
+/* List of point infos; element index is its ID for UI. */
+static struct point_infos point_infos;
+
+/* Catchpoint invisible to the user used for step-by-step validation. */
+static struct rte_bpf_validate_debug_point *step_point;
+
+/* Tracking entered branches. */
+static struct branch_stack branch_stack;
+static uint32_t pending_jump_pc = UINT32_MAX;
+static struct rte_bpf_validate_debug_point *jump_always_step_point;
+
+static int
+step_cb(struct rte_bpf_validate_debug *debug, void *ctx);
+static int
+point_cb(struct rte_bpf_validate_debug *debug, void *ctx);
+
+/* Find index of the string in the list. */
+static int
+find_name(const char *name, const char *const *names, int nb_names)
+{
+	if (nb_names < 0)
+		return -EINVAL;
+
+	for (int index = 0; index != nb_names; ++index)
+		if (names[index] != NULL && strcmp(names[index], name) == 0)
+			return index;
+
+	return -ENOENT;
+}
+
+/* Convert event name to its enum value. */
+static enum rte_bpf_validate_debug_event
+parse_event_name(const char *name)
+{
+	const int rc = find_name(name, event_names, RTE_DIM(event_names));
+	if (rc < 0)
+		PRINTLN("Error: invalid event name.");
+
+	return rc;
+}
+
+/* Convert comparison operator name to opcode. */
+static int
+parse_comparison_operator(const char *name)
+{
+	const int rc = find_name(name, comparison_operator_names,
+		RTE_DIM(comparison_operator_names));
+	if (rc < 0)
+		PRINTLN("Error: invalid comparison operator name.");
+
+	return rc;
+}
+
+/* Convert register name to its number. */
+static int
+parse_register(const char *name)
+{
+	const int rc = find_name(name, register_names, RTE_DIM(register_names));
+	if (rc < 0)
+		PRINTLN("Error: invalid register name.");
+
+	return rc;
+}
+
+/* Free local list of point infos (do not destroy points). */
+static void
+point_infos_free(void)
+{
+	free(point_infos.elements);
+	point_infos = (struct point_infos){};
+}
+
+/* Free local branch stack. */
+static void
+branch_stack_free(void)
+{
+	free(branch_stack.branches);
+	branch_stack = (struct branch_stack){};
+}
+
+/* Return existing element from the list of point infos. */
+static struct point_info *
+point_infos_at(uint32_t point_number)
+{
+	RTE_ASSERT(point_number < point_infos.length);
+	RTE_ASSERT(point_infos.elements[point_number].point != NULL);
+	return &point_infos.elements[point_number];
+}
+
+/* Print existing element from the list of point infos. */
+static void
+point_infos_print_at(uint32_t point_number)
+{
+	const struct point_info *const point_info = point_infos_at(point_number);
+
+	switch (point_info->type) {
+	case POINT_TYPE_BREAK:
+		PRINTLN("Breakpoint %d at %d.", point_number,
+			point_info->pc);
+		break;
+	case POINT_TYPE_CATCH:
+		PRINTLN("Catchpoint %d on %s.", point_number,
+			event_names[point_info->event]);
+		break;
+	default:
+		PRINTLN("Point %d of unknown type", point_number);
+		break;
+	}
+}
+
+/* Print all point infos. */
+static int
+point_infos_print_all(void)
+{
+	uint32_t nb_printed = 0;
+	for (uint32_t pn = 0; pn != point_infos.length; ++pn) {
+		const struct point_info *const point_info =
+			&point_infos.elements[pn];
+		if (point_info->point != NULL) {
+			point_infos_print_at(pn);
+			++nb_printed;
+		}
+	}
+
+	if (nb_printed == 0) {
+		PRINTLN("No breakpoints or catchpoints set.");
+		return -ENOENT;
+	}
+
+	return nb_printed;
+}
+
+/* Allocate space for a new element in the list of point infos. */
+static uint32_t
+point_infos_append(void)
+{
+	if (point_infos.length == point_infos.capacity) {
+		/* Set to initial capacity or double previous one. */
+		point_infos.capacity = RTE_MAX(INITIAL_CAPACITY,
+			point_infos.capacity * 2);
+		point_infos.elements = realloc(point_infos.elements,
+			point_infos.capacity * sizeof(point_infos.elements[0]));
+		RTE_VERIFY(point_infos.elements != NULL);
+	}
+	return point_infos.length++;
+}
+
+/* Allocate space for a new element in the branch stack. */
+static void
+branch_stack_append(const struct branch_info *branch)
+{
+	if (branch_stack.length == branch_stack.capacity) {
+		/* Set to initial capacity or double previous one. */
+		branch_stack.capacity = RTE_MAX(INITIAL_CAPACITY,
+			branch_stack.capacity * 2);
+		branch_stack.branches = realloc(branch_stack.branches,
+			branch_stack.capacity * sizeof(branch_stack.branches[0]));
+		RTE_VERIFY(branch_stack.branches != NULL);
+	}
+	branch_stack.branches[branch_stack.length++] = *branch;
+}
+
+/* Destroy existing element from the list of point infos, printing it first. */
+static void
+point_infos_destroy_existing(uint32_t point_number)
+{
+	point_infos_print_at(point_number);
+
+	struct point_info *const point_info = point_infos_at(point_number);
+	rte_bpf_validate_debug_point_destroy(point_info->point);
+	*point_info = (struct point_info){};
+}
+
+/* Destroy point with specified number if it exists. */
+static int
+point_infos_destroy_at(uint32_t point_number)
+{
+	if (point_number >= point_infos.length ||
+			point_infos.elements[point_number].point == NULL) {
+		PRINTLN("No breakpoint number %d.", point_number);
+		return -ENOENT;
+	}
+
+	point_infos_destroy_existing(point_number);
+	return 1;
+}
+
+/* Destroy all point infos. */
+static void
+point_infos_destroy_all(void)
+{
+	uint32_t nb_destroyed = 0;
+	for (uint32_t pn = 0; pn < point_infos.length; ++pn) {
+		const struct point_info *const point_info =
+			&point_infos.elements[pn];
+		if (point_info->point != NULL) {
+			point_infos_destroy_existing(pn);
+			++nb_destroyed;
+		}
+	}
+
+	if (nb_destroyed == 0)
+		PRINTLN("No breakpoints or catchpoints set.");
+}
+
+/* Destroy all breakpoints at specified location. */
+static void
+point_infos_destroy_breakpoints(uint32_t pc)
+{
+	uint32_t nb_destroyed = 0;
+	for (uint32_t pn = 0; pn < point_infos.length; ++pn) {
+		const struct point_info *const point_info =
+			&point_infos.elements[pn];
+		if (point_info->point != NULL &&
+				point_info->type == POINT_TYPE_BREAK &&
+				point_info->pc == pc) {
+			point_infos_destroy_existing(pn);
+			++nb_destroyed;
+		}
+	}
+
+	if (nb_destroyed == 0)
+		PRINTLN("No breakpoint at %u.", pc);
+}
+
+/* Destroy all catchpoints for specified event. */
+static void
+point_infos_destroy_catchpoints(int event)
+{
+	if (event < 0)
+		/* Error was already printed by parse_event_name. */
+		return;
+
+	uint32_t nb_destroyed = 0;
+	for (uint32_t pn = 0; pn < point_infos.length; ++pn) {
+		const struct point_info *const point_info =
+			&point_infos.elements[pn];
+		if (point_info->point != NULL &&
+				point_info->type == POINT_TYPE_CATCH &&
+				(int)point_info->event == event) {
+			point_infos_destroy_existing(pn);
+			++nb_destroyed;
+		}
+	}
+
+	if (nb_destroyed == 0)
+		PRINTLN("No catchpoint on %s.", event_names[event]);
+}
+
+/* Create new breakpoint at specified location. */
+static int
+add_breakpoint(struct rte_bpf_validate_debug *debug, uint32_t nb_ins, uint32_t pc)
+{
+	const uint32_t point_number = point_infos_append();
+
+	if (pc >= nb_ins) {
+		PRINTLN("Error: program only has %u instructions.", nb_ins);
+		return -ENOENT;
+	}
+
+	struct rte_bpf_validate_debug_point *const point =
+		rte_bpf_validate_debug_break(debug, pc,
+			&(struct rte_bpf_validate_debug_callback){
+				.fn = point_cb,
+				.ctx = (void *)(uintptr_t)point_number,
+			});
+	if (point == NULL) {
+		PRINTLN("Library error %d.", rte_errno);
+		return -rte_errno;
+	}
+
+	point_infos.elements[point_number] = (struct point_info){
+			.point = point,
+			.type = POINT_TYPE_BREAK,
+			.pc = pc,
+		};
+	point_infos_print_at(point_number);
+	return 0;
+}
+
+/* Create new catchpoint at specified location. */
+static int
+add_catchpoint(struct rte_bpf_validate_debug *debug, int event)
+{
+	if (event < 0)
+		/* Error was already printed by parse_event_name. */
+		return event;
+
+	const uint32_t point_number = point_infos_append();
+	struct rte_bpf_validate_debug_point *const point =
+		rte_bpf_validate_debug_catch(debug, event,
+			&(struct rte_bpf_validate_debug_callback){
+				.fn = point_cb,
+				.ctx = (void *)(uintptr_t)point_number,
+			});
+	if (point == NULL) {
+		PRINTLN("Library error %d.", rte_errno);
+		return -rte_errno;
+	}
+
+	point_infos.elements[point_number] = (struct point_info){
+			.point = point,
+			.type = POINT_TYPE_CATCH,
+			.event = event,
+		};
+	point_infos_print_at(point_number);
+	return 0;
+}
+
+static bool
+is_step_enabled(void)
+{
+	return step_point != NULL;
+}
+
+/* Enable step-by-step validation: make sure catchpoint is set on step event. */
+static int
+enable_step(struct rte_bpf_validate_debug *debug)
+{
+	if (is_step_enabled())
+		return 0;
+
+	step_point = rte_bpf_validate_debug_catch(debug,
+		RTE_BPF_VALIDATE_DEBUG_EVENT_STEP,
+		&(struct rte_bpf_validate_debug_callback){ step_cb });
+	if (step_point == NULL) {
+		PRINTLN("Library error %d.", rte_errno);
+		return -rte_errno;
+	}
+
+	return 0;
+}
+
+/* Disable step-by-step validation: destroy catchpoint on step event if any. */
+static void
+disable_step(void)
+{
+	rte_bpf_validate_debug_point_destroy(step_point);
+	step_point = NULL;
+}
+
+/* Format and print information about specified frame offset. */
+static int
+print_frame_offset(struct rte_bpf_validate_debug *debug, int32_t offset)
+{
+	char *info;
+	int info_size, rc;
+
+	if (offset >= 0 || offset % sizeof(uint64_t) != 0) {
+		PRINTLN("Invalid frame offset, must be a negative multiple of %zu.",
+			sizeof(uint64_t));
+		return -EINVAL;
+	}
+
+	rc = rte_bpf_validate_debug_format_frame_info(debug, NULL, 0, offset);
+	if (rc == -ERANGE) {
+		PRINTLN("Offset is out of frame range.");
+		return rc;
+	}
+	if (rc < 0) {
+		PRINTLN("Error %d printing information.", -rc);
+		return rc;
+	}
+
+	info_size = rc + 1;
+	info = malloc(info_size);
+	RTE_VERIFY(info != NULL);
+
+	rc = rte_bpf_validate_debug_format_frame_info(debug, info, info_size,
+		offset);
+	if (rc + 1 != info_size) {
+		if (rc >= 0) {
+			PRINTLN("Expect format return value %d, got %d.",
+				info_size, rc);
+			rc = -EINVAL;
+		} else
+			PRINTLN("Error %d printing information.", -rc);
+		free(info);
+		return rc;
+	}
+
+	printf("%5" PRId32 ": \t%s\n", offset, info);
+	free(info);
+	return 0;
+}
+
+/* Format and print informatiion about the frame. */
+static int
+print_frame(struct rte_bpf_validate_debug *debug)
+{
+	int32_t frame_size;
+	int rc;
+
+	frame_size = rte_bpf_validate_debug_get_frame_size(debug);
+	if (frame_size < 0) {
+		PRINTLN("Error %d getting frame size.", -frame_size);
+		return frame_size;
+	}
+
+	for (int32_t neg_ofs = sizeof(uint64_t); neg_ofs <= frame_size;
+			neg_ofs += sizeof(uint64_t)) {
+		rc = print_frame_offset(debug, -neg_ofs);
+		if (rc < 0)
+			return rc;
+	}
+
+	return 0;
+}
+
+/* Format and print informatiion about specified register. */
+static int
+print_register(struct rte_bpf_validate_debug *debug, int reg)
+{
+	char *info;
+	int info_size, rc;
+
+	if (reg < 0)
+		/* Error was already printed by parse_register. */
+		return reg;
+
+	rc = rte_bpf_validate_debug_format_register_info(debug, NULL, 0, reg);
+	if (rc < 0) {
+		PRINTLN("Error %d printing information.", -rc);
+		return rc;
+	}
+
+	info_size = rc + 1;
+	info = malloc(info_size);
+	RTE_VERIFY(info != NULL);
+
+	rc = rte_bpf_validate_debug_format_register_info(debug, info, info_size,
+		reg);
+	if (rc + 1 != info_size) {
+		if (rc >= 0) {
+			PRINTLN("Expect format return value %d, got %d.",
+				info_size, rc);
+			rc = -EINVAL;
+		} else
+			PRINTLN("Error %d printing information.", -rc);
+		free(info);
+		return rc;
+	}
+
+	printf("%5s: \t%s\n", register_names[reg], info);
+	free(info);
+	return 0;
+}
+
+/* Format and print informatiion about all registers. */
+static int
+print_registers(struct rte_bpf_validate_debug *debug)
+{
+	int rc = 0;
+
+	for (int reg = 0; reg != EBPF_REG_NUM; ++reg)
+		rc = rc < 0 ? rc : print_register(debug, reg);
+
+	return rc;
+}
+
+/* List one eBPF program instruction. */
+static int
+list_one(const struct ebpf_insn *ins, uint32_t nb_ins, uint32_t offset,
+	uint32_t pc, const char *comment)
+{
+	char hexadecimal[256], disassembly[256];
+
+	if (offset >= nb_ins) {
+		PRINTLN("Error: program only has %u instructions.", nb_ins);
+		return -EINVAL;
+	}
+
+	ins += offset;
+
+	if (offset == nb_ins - 1 && rte_bpf_insn_is_wide(ins)) {
+		PRINTLN("Error: truncated last instruction.");
+		return -EINVAL;
+	}
+
+	rte_bpf_format(hexadecimal, sizeof(hexadecimal), ins, 0,
+		RTE_BPF_FORMAT_FLAG_HEXADECIMAL |
+		RTE_BPF_FORMAT_FLAG_NEVER_WIDE);
+	rte_bpf_format(disassembly, sizeof(disassembly), ins, offset,
+		RTE_BPF_FORMAT_FLAG_DISASSEMBLY |
+		RTE_BPF_FORMAT_FLAG_ABSOLUTE_JUMPS);
+
+	if (comment == NULL)
+		comment = "";
+	PRINTLN("%2s %10u: \t%s \t%s%s%s",
+		offset == pc ? "=>" : "", offset, hexadecimal, disassembly,
+		comment[0] != '\0' ? " \t; " : "", comment);
+
+	if (rte_bpf_insn_is_wide(ins)) {
+		rte_bpf_format(hexadecimal, sizeof(hexadecimal), ins + 1, 0,
+			RTE_BPF_FORMAT_FLAG_HEXADECIMAL |
+			RTE_BPF_FORMAT_FLAG_NEVER_WIDE);
+		PRINTLN("%15s\t%s", "", hexadecimal);
+	}
+
+	return 0;
+}
+
+/* List specified range of eBPF program instructions, updating start offset. */
+static int
+list(const struct ebpf_insn *ins, uint32_t nb_ins, uint32_t *offset,
+	uint32_t count, uint32_t pc)
+{
+	uint32_t local_offset = 0;
+	if (offset == NULL)
+		offset = &local_offset;
+
+	if (*offset > nb_ins) {
+		PRINTLN("Error: program only has %u instructions.", nb_ins);
+		return -EINVAL;
+	}
+
+	const uint32_t end =
+		/* Calculate end in a way preventing overflow: */
+		*offset + RTE_MIN(nb_ins - *offset, count);
+	while (*offset < end) {
+		const int rc = list_one(ins, nb_ins, *offset, pc, NULL);
+		if (rc < 0)
+			return rc;
+
+		*offset += 1 + rte_bpf_insn_is_wide(&ins[*offset]);
+	}
+
+	return 0;
+}
+
+/* Print if specified conditional jump _may_ be executed. */
+static int
+print_if_may(struct rte_bpf_validate_debug *debug, const struct ebpf_insn *jump,
+	uint64_t imm64)
+{
+	const int result = rte_bpf_validate_debug_may_jump(debug, jump, imm64);
+
+	switch (result) {
+	case 0:
+	case RTE_BPF_VALIDATE_DEBUG_MAY_BE_FALSE:
+		PRINTLN("NO");
+		break;
+	case RTE_BPF_VALIDATE_DEBUG_MAY_BE_TRUE:
+	case RTE_BPF_VALIDATE_DEBUG_MAY_BE_FALSE | RTE_BPF_VALIDATE_DEBUG_MAY_BE_TRUE:
+		PRINTLN("YES");
+		break;
+	default:
+		PRINTLN("Error %d getting result.", -result);
+		break;
+	}
+
+	return result;
+}
+
+/* Print if specified condition with literal right hand side _may_ be true. */
+static int
+print_if_may_literal_rhs(struct rte_bpf_validate_debug *debug,
+	const struct debug_command_comparison *comparison)
+{
+	const int lhs = parse_register(comparison->lhs);
+	const int op = parse_comparison_operator(comparison->op);
+	const int64_t rhs = comparison->literal_rhs;
+
+	if (lhs < 0 || op < 0)
+		/* Error was already printed by parse function. */
+		return lhs < 0 ? lhs : op;
+
+	return print_if_may(debug, &(struct ebpf_insn){
+		.code = BPF_JMP | op | BPF_K,
+		.dst_reg = lhs,
+	}, /* imm64 = */ rhs);
+}
+
+/* Print if specified condition with register right hand side _may_ be true. */
+static int
+print_if_may_register_rhs(struct rte_bpf_validate_debug *debug,
+	const struct debug_command_comparison *comparison)
+{
+	const int lhs = parse_register(comparison->lhs);
+	const int op = parse_comparison_operator(comparison->op);
+	const int rhs = parse_register(comparison->register_rhs);
+
+	if (lhs < 0 || op < 0 || rhs < 0)
+		/* Error was already printed by parse function. */
+		return lhs < 0 ? lhs : op < 0 ? op : rhs;
+
+	return print_if_may(debug, &(struct ebpf_insn){
+		.code = BPF_JMP | op | BPF_X,
+		.dst_reg = lhs,
+		.src_reg = rhs,
+	}, /* imm64 = */ 0);
+}
+
+/* Return 1 on validation success, 0 on failure, -EAGAIN if still running. */
+static int
+get_validation_success(struct rte_bpf_validate_debug *debug)
+{
+	int validation_result, rc;
+
+	rc = rte_bpf_validate_debug_get_validation_result(debug,
+		&validation_result);
+	return rc < 0 ? rc : (validation_result >= 0);
+}
+
+static void
+print_status(const struct ebpf_insn *ins, uint32_t nb_ins,
+	int validation_success, uint32_t pc)
+{
+	if (validation_success == 1) {
+		PRINTLN("Validation succeeded.");
+		return;
+	}
+
+	list_one(ins, nb_ins, pc, pc, NULL);
+
+	if (validation_success == 0)
+		PRINTLN("Validation failed.");
+}
+
+static void
+debug_command_where(const struct ebpf_insn *ins, uint32_t nb_ins,
+	int validation_success, uint32_t pc)
+{
+	for (uint32_t bi = 0; bi != branch_stack.length; ++bi) {
+		const uint32_t jump_pc = branch_stack.branches[bi].jump_pc;
+		const uint32_t target_pc = branch_stack.branches[bi].target_pc;
+		const char *const comment =
+			!branch_stack.branches[bi].is_conditional ? NULL :
+			target_pc == jump_pc + 1 ? "fallen-through" : "taken";
+		list_one(ins, nb_ins, jump_pc, UINT32_MAX, comment);
+	}
+	print_status(ins, nb_ins, validation_success, pc);
+}
+
+/* Return true if pc is defined, otherwise print an error message. */
+static bool
+ensure_pc_defined(uint32_t pc)
+{
+	if (pc != UINT32_MAX)
+		return true;
+
+	PRINTLN("No current instruction.");
+	return false;
+}
+
+/* Return true if still validating, otherwise print an error message. */
+static bool
+ensure_still_validating(int validation_success)
+{
+	if (validation_success == -EAGAIN)
+		return true;
+
+	PRINTLN("Finished, use `start` or `run` to restart, `quit` to quit.");
+	return false;
+}
+
+/* Step-by-step validation callback: read and process user commands. */
+static int
+step_cb(struct rte_bpf_validate_debug *debug, __rte_unused void *ctx)
+{
+	int rc;
+	int validation_success;
+	const struct ebpf_insn *ins;
+	uint32_t nb_ins, pc, list_offset;
+
+	validate_again = false;
+
+	rc = rte_bpf_validate_debug_get_ins(debug, &ins, &nb_ins);
+	if (rc < 0) {
+		PRINTLN("Error %d getting program instructions.", -rc);
+		return rc;
+	}
+
+	validation_success = get_validation_success(debug);
+	if (validation_success < 0 && validation_success != -EAGAIN) {
+		PRINTLN("Error %d getting validation result.",
+			-validation_success);
+		return validation_success;
+	}
+
+	pc = validation_success == 1 ? UINT32_MAX :
+		rte_bpf_validate_debug_get_pc(debug);
+
+	print_status(ins, nb_ins, validation_success, pc);
+
+	list_offset = pc;
+
+	while (true) {
+		switch (debug_command_get(PROMPT)) {
+		case DEBUG_COMMAND_BREAK:
+			if (ensure_pc_defined(pc))
+				add_breakpoint(debug, nb_ins, pc);
+			continue;
+		case DEBUG_COMMAND_BREAK_PC:
+			add_breakpoint(debug, nb_ins, debug_command_parsed.pc);
+			continue;
+		case DEBUG_COMMAND_CATCH:
+			add_catchpoint(debug,
+				parse_event_name(debug_command_parsed.event));
+			continue;
+		case DEBUG_COMMAND_CLEAR:
+			if (ensure_pc_defined(pc))
+				point_infos_destroy_breakpoints(pc);
+			continue;
+		case DEBUG_COMMAND_CLEAR_EVENT:
+			point_infos_destroy_catchpoints(
+				parse_event_name(debug_command_parsed.event));
+			continue;
+		case DEBUG_COMMAND_CLEAR_PC:
+			point_infos_destroy_breakpoints(
+				debug_command_parsed.pc);
+			continue;
+		case DEBUG_COMMAND_CONTINUE:
+			if (ensure_still_validating(validation_success)) {
+				disable_step();
+				return 0;
+			}
+			continue;
+		case DEBUG_COMMAND_DELETE:
+			point_infos_destroy_all();
+			continue;
+		case DEBUG_COMMAND_DELETE_NUMBER:
+			point_infos_destroy_at(
+				debug_command_parsed.point_number);
+			continue;
+		case DEBUG_COMMAND_INFO_FRAME:
+			print_frame(debug);
+			continue;
+		case DEBUG_COMMAND_INFO_FRAME_OFFSET:
+			print_frame_offset(debug,
+				debug_command_parsed.frame_offset);
+			continue;
+		case DEBUG_COMMAND_INFO_POINTS:
+			point_infos_print_all();
+			continue;
+		case DEBUG_COMMAND_INFO_REGISTER:
+			print_register(debug,
+				parse_register(debug_command_parsed.register_));
+			continue;
+		case DEBUG_COMMAND_INFO_REGISTERS:
+			print_registers(debug);
+			continue;
+		case DEBUG_COMMAND_LIST:
+			if (ensure_pc_defined(pc))
+				list(ins, nb_ins, &list_offset, 10, pc);
+			continue;
+		case DEBUG_COMMAND_LIST_COUNT:
+			if (ensure_pc_defined(pc))
+				list(ins, nb_ins, &list_offset,
+					debug_command_parsed.instruction_count, pc);
+			continue;
+		case DEBUG_COMMAND_LIST_PROGRAM:
+			if (ensure_pc_defined(pc))
+				list(ins, nb_ins, NULL, UINT32_MAX, pc);
+			continue;
+		case DEBUG_COMMAND_MAY_LITERAL_RHS:
+			print_if_may_literal_rhs(debug,
+				&debug_command_parsed.comparison);
+			continue;
+		case DEBUG_COMMAND_MAY_REGISTER_RHS:
+			print_if_may_register_rhs(debug,
+				&debug_command_parsed.comparison);
+			continue;
+		case DEBUG_COMMAND_EOF:
+		case DEBUG_COMMAND_QUIT:
+			PRINTLN("Quitting...");
+			return validation_success == -EAGAIN ? -ECANCELED : 0;
+		case DEBUG_COMMAND_RUN:
+			PRINTLN("Re-running...");
+			disable_step();
+			validate_again = true;
+			return -ECANCELED;
+		case DEBUG_COMMAND_START:
+			PRINTLN("Re-starting...");
+			rc = enable_step(debug);
+			if (rc < 0)
+				return rc;
+			validate_again = true;
+			return -ECANCELED;
+		case DEBUG_COMMAND_STEP:
+			if (ensure_still_validating(validation_success))
+				return 0;
+			continue;
+		case DEBUG_COMMAND_WHERE:
+			debug_command_where(ins, nb_ins, validation_success, pc);
+			continue;
+		default:
+			PRINTLN("INTERNAL ERROR");
+			return -ENOTSUP;
+		}
+	}
+}
+
+/* Any point callback: print it and enable step-by-step validation. */
+static int
+point_cb(struct rte_bpf_validate_debug *debug, void *ctx)
+{
+	const uint32_t point_number = (uintptr_t)ctx;
+	point_infos_print_at(point_number);
+	return enable_step(debug);
+}
+
+/* Branch stack machinery. */
+
+static void
+clear_jump_always_step_point(void)
+{
+	rte_bpf_validate_debug_point_destroy(jump_always_step_point);
+	jump_always_step_point = NULL;
+}
+
+static int
+reset_branch_tracking(struct rte_bpf_validate_debug *debug __rte_unused,
+	void *ctx __rte_unused)
+{
+	branch_stack.length = 0;
+	pending_jump_pc = UINT32_MAX;
+	clear_jump_always_step_point();
+	return 0;
+}
+
+/*
+ * Handling the jump-always instructions:
+ * - upon a jump-always event save the pc and set a custom step callback;
+ * - ignore the first custom step callback call (still on the same jump);
+ * - on the second call push the jump pc into stack and delete the callback;
+ */
+
+static int
+jump_always_step_cb(struct rte_bpf_validate_debug *debug, void *ctx __rte_unused)
+{
+	/* Step event is also emitted at the end of the jump instruction itself. */
+	if (rte_bpf_validate_debug_get_pc(debug) == pending_jump_pc)
+		return 0;
+
+	branch_stack_append(&(struct branch_info){
+		.jump_pc = pending_jump_pc,
+		.target_pc = rte_bpf_validate_debug_get_pc(debug),
+		.is_conditional = false,
+	});
+	clear_jump_always_step_point();
+	return 0;
+}
+
+static int
+jump_always_cb(struct rte_bpf_validate_debug *debug, void *ctx __rte_unused)
+{
+	pending_jump_pc = rte_bpf_validate_debug_get_pc(debug);
+	clear_jump_always_step_point();
+	jump_always_step_point = rte_bpf_validate_debug_catch(debug,
+		RTE_BPF_VALIDATE_DEBUG_EVENT_STEP,
+		&(struct rte_bpf_validate_debug_callback){ jump_always_step_cb });
+	return 0;
+}
+
+/*
+ * Handling the jump-conditional instructions:
+ * - upon a jump-conditional event save the pc;
+ * - upon a branch-enter event push the conditional jump pc into stack;
+ * - upon a branch-return event pop conditional jump and all unconditional jumps
+ *   preceding it from the stack;
+ * - during step execution notify the user about the step events;
+ */
+
+static int
+jump_conditional_cb(struct rte_bpf_validate_debug *debug, void *ctx __rte_unused)
+{
+	pending_jump_pc = rte_bpf_validate_debug_get_pc(debug);
+	return 0;
+}
+
+static int
+branch_enter_cb(struct rte_bpf_validate_debug *debug, void *ctx __rte_unused)
+{
+	branch_stack_append(&(struct branch_info){
+		.jump_pc = pending_jump_pc,
+		.target_pc = rte_bpf_validate_debug_get_pc(debug),
+		.is_conditional = true,
+	});
+	if (is_step_enabled())
+		PRINTLN("Entered new branch at pc %u.", pending_jump_pc);
+	return 0;
+}
+
+static int
+branch_return_cb(struct rte_bpf_validate_debug *debug __rte_unused,
+	void *ctx __rte_unused)
+{
+	clear_jump_always_step_point();
+
+	while (branch_stack.length > 0) {
+		const struct branch_info branch_info =
+			branch_stack.branches[--branch_stack.length];
+		pending_jump_pc = branch_info.jump_pc;
+		if (branch_info.is_conditional)
+			break;
+	}
+	if (is_step_enabled())
+		PRINTLN("Returned from branch at pc %u.", pending_jump_pc);
+	return 0;
+}
+
+/* Notify user when skipping branches in step mode. */
+
+static int
+branch_prune_cb(struct rte_bpf_validate_debug *debug __rte_unused,
+	void *ctx __rte_unused)
+{
+	if (is_step_enabled())
+		PRINTLN("Prunned branch at pc %u.", pending_jump_pc);
+	return 0;
+}
+
+static int
+branch_unreachable_cb(struct rte_bpf_validate_debug *debug __rte_unused,
+	void *ctx __rte_unused)
+{
+	if (is_step_enabled())
+		PRINTLN("Unreachable branch at pc %u.", pending_jump_pc);
+	return 0;
+}
+
+/* Global initialization and cleanup functions. */
+
+static int
+set_callbacks(struct rte_bpf_validate_debug *debug)
+{
+	static const struct rte_bpf_validate_debug_callback events_callback[
+			RTE_BPF_VALIDATE_DEBUG_EVENT_END] = {
+		[RTE_BPF_VALIDATE_DEBUG_EVENT_VALIDATION_START] = { reset_branch_tracking },
+		[RTE_BPF_VALIDATE_DEBUG_EVENT_VALIDATION_SUCCESS] = { step_cb },
+		[RTE_BPF_VALIDATE_DEBUG_EVENT_VALIDATION_FAILURE] = { step_cb },
+		[RTE_BPF_VALIDATE_DEBUG_EVENT_JUMP_CONDITIONAL] = { jump_conditional_cb },
+		[RTE_BPF_VALIDATE_DEBUG_EVENT_JUMP_ALWAYS] = { jump_always_cb },
+		[RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_ENTER] = { branch_enter_cb },
+		[RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_RETURN] = { branch_return_cb },
+		[RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_PRUNE] = { branch_prune_cb },
+		[RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_UNREACHABLE] = { branch_unreachable_cb },
+	};
+
+	for (enum rte_bpf_validate_debug_event event = 0;
+			event < RTE_BPF_VALIDATE_DEBUG_EVENT_END; ++event)
+		if (events_callback[event].fn != NULL &&
+				rte_bpf_validate_debug_catch(debug, event,
+					&events_callback[event]) == NULL)
+			return -rte_errno;
+
+	return 0;
+}
+
+struct rte_bpf_validate_debug *
+debug_create(void)
+{
+
+	int rc = 0;
+
+	struct rte_bpf_validate_debug *const debug = rte_bpf_validate_debug_create();
+	if (debug == NULL)
+		rc = -rte_errno;
+
+	rc = rc < 0 ? rc : set_callbacks(debug);
+
+	rc = rc < 0 ? rc : enable_step(debug);
+
+	if (rc < 0) {
+		debug_destroy(debug);
+		rte_errno = -rc;
+		return NULL;
+	}
+
+	return debug;
+}
+
+void
+debug_destroy(struct rte_bpf_validate_debug *debug)
+{
+	/* No need to destroy created points, destroying debug will do it. */
+	point_infos_free();
+	branch_stack_free();
+	rte_bpf_validate_debug_destroy(debug);
+}
+
+bool
+debug_validate_again(void)
+{
+	return validate_again;
+}
diff --git a/app/validate-bpf/debug_command.c b/app/validate-bpf/debug_command.c
new file mode 100644
index 0000000000..505ae389c9
--- /dev/null
+++ b/app/validate-bpf/debug_command.c
@@ -0,0 +1,383 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd
+ */
+
+#include "debug_command.h"
+
+#include <rte_debug.h>
+#include <cmdline.h>
+#include <cmdline_socket.h>
+#include <cmdline_parse_num.h>
+
+#include <string.h>
+
+
+#define EVENT_PATTERN \
+	"invalid-state#" \
+	"branch-enter#branch-prune#branch-return#branch-unreachable#" \
+	"jump-always#jump-conditional"
+
+#define REGISTER_PATTERN "r0#r1#r2#r3#r4#r5#r6#r7#r8#r9#r10"
+
+#define COMPARISON_OP_PATTERN "==#!=#<#<=#>#>=#s<#s<=#s>#s>="
+
+static void
+handle_command(void *parsed_result, struct cmdline *cl, void *data);
+
+/* Keywords */
+static cmdline_parse_token_string_t break_tok =
+	TOKEN_STRING_INITIALIZER(struct debug_command_parsed, keyword, "b#break");
+static cmdline_parse_token_string_t may_tok =
+	TOKEN_STRING_INITIALIZER(struct debug_command_parsed, keyword, "may");
+static cmdline_parse_token_string_t catch_tok =
+	TOKEN_STRING_INITIALIZER(struct debug_command_parsed, keyword, "catch");
+static cmdline_parse_token_string_t clear_tok =
+	TOKEN_STRING_INITIALIZER(struct debug_command_parsed, keyword, "clear");
+static cmdline_parse_token_string_t continue_tok =
+	TOKEN_STRING_INITIALIZER(struct debug_command_parsed, keyword, "c#continue");
+static cmdline_parse_token_string_t delete_tok =
+	TOKEN_STRING_INITIALIZER(struct debug_command_parsed, keyword, "delete");
+static cmdline_parse_token_string_t info_tok =
+	TOKEN_STRING_INITIALIZER(struct debug_command_parsed, keyword, "i#info");
+static cmdline_parse_token_string_t info_points_tok =
+	TOKEN_STRING_INITIALIZER(struct debug_command_parsed, keyword,
+		"b#break#breakpoints#points");
+static cmdline_parse_token_string_t info_frame_tok =
+	TOKEN_STRING_INITIALIZER(struct debug_command_parsed, keyword, "f#frame");
+static cmdline_parse_token_string_t info_registers_tok =
+	TOKEN_STRING_INITIALIZER(struct debug_command_parsed, keyword, "r#registers");
+static cmdline_parse_token_string_t list_tok =
+	TOKEN_STRING_INITIALIZER(struct debug_command_parsed, keyword, "l#list");
+static cmdline_parse_token_string_t program_tok =
+	TOKEN_STRING_INITIALIZER(struct debug_command_parsed, keyword, "program");
+static cmdline_parse_token_string_t quit_tok =
+	TOKEN_STRING_INITIALIZER(struct debug_command_parsed, keyword, "q#quit");
+static cmdline_parse_token_string_t run_tok =
+	TOKEN_STRING_INITIALIZER(struct debug_command_parsed, keyword, "run");
+static cmdline_parse_token_string_t start_tok =
+	TOKEN_STRING_INITIALIZER(struct debug_command_parsed, keyword, "start");
+static cmdline_parse_token_string_t step_tok =
+	TOKEN_STRING_INITIALIZER(struct debug_command_parsed, keyword, "s#step");
+static cmdline_parse_token_string_t where_tok =
+	TOKEN_STRING_INITIALIZER(struct debug_command_parsed, keyword, "where");
+
+/* Variable tokens */
+static cmdline_parse_token_string_t comparison_lhs_tok =
+	TOKEN_STRING_INITIALIZER(struct debug_command_parsed, comparison.lhs, REGISTER_PATTERN);
+static cmdline_parse_token_string_t comparison_op_tok =
+	TOKEN_STRING_INITIALIZER(struct debug_command_parsed, comparison.op, COMPARISON_OP_PATTERN);
+static cmdline_parse_token_num_t comparison_rhs_literal_tok =
+	TOKEN_NUM_INITIALIZER(struct debug_command_parsed, comparison.literal_rhs, RTE_INT64);
+static cmdline_parse_token_string_t comparison_rhs_register_tok =
+	TOKEN_STRING_INITIALIZER(struct debug_command_parsed, comparison.register_rhs,
+		REGISTER_PATTERN);
+static cmdline_parse_token_string_t event_tok =
+	TOKEN_STRING_INITIALIZER(struct debug_command_parsed, event, EVENT_PATTERN);
+static cmdline_parse_token_num_t frame_offset_tok =
+	TOKEN_NUM_INITIALIZER(struct debug_command_parsed, frame_offset, RTE_INT64);
+static cmdline_parse_token_num_t instruction_count_tok =
+	TOKEN_NUM_INITIALIZER(struct debug_command_parsed, instruction_count, RTE_UINT32);
+static cmdline_parse_token_num_t pc_tok =
+	TOKEN_NUM_INITIALIZER(struct debug_command_parsed, instruction_offset, RTE_UINT32);
+static cmdline_parse_token_num_t point_number_tok =
+	TOKEN_NUM_INITIALIZER(struct debug_command_parsed, point_number, RTE_UINT32);
+static cmdline_parse_token_string_t register_tok =
+	TOKEN_STRING_INITIALIZER(struct debug_command_parsed, register_, REGISTER_PATTERN);
+
+
+/* Commands */
+static cmdline_parse_inst_t cmd_break = {
+	.f = handle_command,
+	.data = (void *)DEBUG_COMMAND_BREAK,
+	.help_str = "b|break: break at current instruction",
+	.tokens = {
+		(void *)&break_tok,
+		NULL,
+	}
+};
+static cmdline_parse_inst_t cmd_break_pc = {
+	.f = handle_command,
+	.data = (void *)DEBUG_COMMAND_BREAK_PC,
+	.help_str = "b|break <pc>: break at specified instruction",
+	.tokens = {
+		(void *)&break_tok,
+		(void *)&pc_tok,
+		NULL,
+	}
+};
+static cmdline_parse_inst_t cmd_catch = {
+	.f = handle_command,
+	.data = (void *)DEBUG_COMMAND_CATCH,
+	.help_str = "catch <event>: catch specified event",
+	.tokens = {
+		(void *)&catch_tok,
+		(void *)&event_tok,
+		NULL,
+	}
+};
+static cmdline_parse_inst_t cmd_clear = {
+	.f = handle_command,
+	.data = (void *)DEBUG_COMMAND_CLEAR,
+	.help_str = "clear: delete all breakpoints at current instruction",
+	.tokens = {
+		(void *)&clear_tok,
+		NULL,
+	}
+};
+static cmdline_parse_inst_t cmd_clear_event = {
+	.f = handle_command,
+	.data = (void *)DEBUG_COMMAND_CLEAR_EVENT,
+	.help_str = "clear <event>: delete all catchpoints for specified event",
+	.tokens = {
+		(void *)&clear_tok,
+		(void *)&event_tok,
+		NULL,
+	}
+};
+static cmdline_parse_inst_t cmd_clear_pc = {
+	.f = handle_command,
+	.data = (void *)DEBUG_COMMAND_CLEAR_PC,
+	.help_str = "clear <pc>: delete all breakpoints at specified instruction",
+	.tokens = {
+		(void *)&clear_tok,
+		(void *)&pc_tok,
+		NULL,
+	}
+};
+static cmdline_parse_inst_t cmd_continue = {
+	.f = handle_command,
+	.data = (void *)DEBUG_COMMAND_CONTINUE,
+	.help_str = "c|continue: continue validation",
+	.tokens = {
+		(void *)&continue_tok,
+		NULL,
+	}
+};
+static cmdline_parse_inst_t cmd_delete = {
+	.f = handle_command,
+	.data = (void *)DEBUG_COMMAND_DELETE,
+	.help_str = "delete: delete all breakpoints and catchpoints",
+	.tokens = {
+		(void *)&delete_tok,
+		NULL,
+	}
+};
+static cmdline_parse_inst_t cmd_delete_number = {
+	.f = handle_command,
+	.data = (void *)DEBUG_COMMAND_DELETE_NUMBER,
+	.help_str = "delete <point>: delete specified breakpoint or catchpoint",
+	.tokens = {
+		(void *)&delete_tok,
+		(void *)&point_number_tok,
+		NULL,
+	}
+};
+static cmdline_parse_inst_t cmd_info_frame = {
+	.f = handle_command,
+	.data = (void *)DEBUG_COMMAND_INFO_FRAME,
+	.help_str = "i|info f|frame: show information about all frame locations",
+	.tokens = {
+		(void *)&info_tok,
+		(void *)&info_frame_tok,
+		NULL,
+	}
+};
+static cmdline_parse_inst_t cmd_info_frame_offset = {
+	.f = handle_command,
+	.data = (void *)DEBUG_COMMAND_INFO_FRAME_OFFSET,
+	.help_str = "i|info f|frame -<offset>: show information about specified frame location",
+	.tokens = {
+		(void *)&info_tok,
+		(void *)&info_frame_tok,
+		(void *)&frame_offset_tok,
+		NULL,
+	}
+};
+static cmdline_parse_inst_t cmd_info_points = {
+	.f = handle_command,
+	.data = (void *)DEBUG_COMMAND_INFO_POINTS,
+	.help_str = "i|info b|break|breakpoints|points: "
+		"show information about all breakpoints and catchpoints",
+	.tokens = {
+		(void *)&info_tok,
+		(void *)&info_points_tok,
+		NULL,
+	}
+};
+static cmdline_parse_inst_t cmd_info_register = {
+	.f = handle_command,
+	.data = (void *)DEBUG_COMMAND_INFO_REGISTER,
+	.help_str = "i|info <register>: show information about specified register",
+	.tokens = {
+		(void *)&info_tok,
+		(void *)&register_tok,
+		NULL,
+	}
+};
+static cmdline_parse_inst_t cmd_info_registers = {
+	.f = handle_command,
+	.data = (void *)DEBUG_COMMAND_INFO_REGISTERS,
+	.help_str = "i|info r|registers: show information about all registers",
+	.tokens = {
+		(void *)&info_tok,
+		(void *)&info_registers_tok,
+		NULL,
+	}
+};
+static cmdline_parse_inst_t cmd_list = {
+	.f = handle_command,
+	.data = (void *)DEBUG_COMMAND_LIST,
+	.help_str = "l|list: list ten instructions",
+	.tokens = {
+		(void *)&list_tok,
+		NULL,
+	}
+};
+static cmdline_parse_inst_t cmd_list_count = {
+	.f = handle_command,
+	.data = (void *)DEBUG_COMMAND_LIST_COUNT,
+	.help_str = "l|list <number>: list specified number of instructions",
+	.tokens = {
+		(void *)&list_tok,
+		(void *)&instruction_count_tok,
+		NULL,
+	}
+};
+static cmdline_parse_inst_t cmd_list_program = {
+	.f = handle_command,
+	.data = (void *)DEBUG_COMMAND_LIST_PROGRAM,
+	.help_str = "l|list program: list whole program",
+	.tokens = {
+		(void *)&list_tok,
+		(void *)&program_tok,
+		NULL,
+	}
+};
+static cmdline_parse_inst_t cmd_may_literal_rhs = {
+	.f = handle_command,
+	.data = (void *)DEBUG_COMMAND_MAY_LITERAL_RHS,
+	.help_str = "may <register> <comparison> <number>: "
+		"check if specified condition _may_ be true",
+	.tokens = {
+		(void *)&may_tok,
+		(void *)&comparison_lhs_tok,
+		(void *)&comparison_op_tok,
+		(void *)&comparison_rhs_literal_tok,
+		NULL,
+	}
+};
+static cmdline_parse_inst_t cmd_may_register_rhs = {
+	.f = handle_command,
+	.data = (void *)DEBUG_COMMAND_MAY_REGISTER_RHS,
+	.help_str = "may <register> <comparison> <register>: "
+		"check if specified condition _may_ be true",
+	.tokens = {
+		(void *)&may_tok,
+		(void *)&comparison_lhs_tok,
+		(void *)&comparison_op_tok,
+		(void *)&comparison_rhs_register_tok,
+		NULL,
+	}
+};
+static cmdline_parse_inst_t cmd_quit = {
+	.f = handle_command,
+	.data = (void *)DEBUG_COMMAND_QUIT,
+	.help_str = "quit: q|quit debugger",
+	.tokens = {
+		(void *)&quit_tok,
+		NULL,
+	}
+};
+static cmdline_parse_inst_t cmd_run = {
+	.f = handle_command,
+	.data = (void *)DEBUG_COMMAND_RUN,
+	.help_str = "run: re-run validation from the start",
+	.tokens = {
+		(void *)&run_tok,
+		NULL,
+	}
+};
+static cmdline_parse_inst_t cmd_start = {
+	.f = handle_command,
+	.data = (void *)DEBUG_COMMAND_START,
+	.help_str = "start: re-start validation and stop at start",
+	.tokens = {
+		(void *)&start_tok,
+		NULL,
+	}
+};
+static cmdline_parse_inst_t cmd_step = {
+	.f = handle_command,
+	.data = (void *)DEBUG_COMMAND_STEP,
+	.help_str = "s|step: validate one instruction",
+	.tokens = {
+		(void *)&step_tok,
+		NULL,
+	}
+};
+static cmdline_parse_inst_t cmd_where = {
+	.f = handle_command,
+	.data = (void *)DEBUG_COMMAND_WHERE,
+	.help_str = "where: show current branch stack",
+	.tokens = {
+		(void *)&where_tok,
+		NULL,
+	}
+};
+
+static cmdline_parse_ctx_t debug_ctx[] = {
+	&cmd_break,
+	&cmd_break_pc,
+	&cmd_catch,
+	&cmd_clear,
+	&cmd_clear_event,
+	&cmd_clear_pc,
+	&cmd_continue,
+	&cmd_delete,
+	&cmd_delete_number,
+	&cmd_info_frame,
+	&cmd_info_frame_offset,
+	&cmd_info_points,
+	&cmd_info_register,
+	&cmd_info_registers,
+	&cmd_list,
+	&cmd_list_count,
+	&cmd_list_program,
+	&cmd_may_literal_rhs,
+	&cmd_may_register_rhs,
+	&cmd_quit,
+	&cmd_run,
+	&cmd_start,
+	&cmd_step,
+	&cmd_where,
+	NULL
+};
+
+/* Receive, fill and return one command. */
+
+static enum debug_command debug_command;
+
+struct debug_command_parsed debug_command_parsed;
+
+static void
+handle_command(void *parsed_result, struct cmdline *cl, void *data)
+{
+	RTE_BUILD_BUG_ON(sizeof(debug_command_parsed) > CMDLINE_PARSE_RESULT_BUFSIZE);
+	memcpy(&debug_command_parsed, parsed_result, sizeof(debug_command_parsed));
+	debug_command = (uintptr_t)data;
+	cmdline_quit(cl);
+}
+
+enum debug_command
+debug_command_get(const char *prompt)
+{
+	debug_command = DEBUG_COMMAND_EOF;
+	struct cmdline *const cmdline = cmdline_stdin_new(debug_ctx, prompt);
+	RTE_VERIFY(cmdline != NULL);
+	cmdline_interact(cmdline);
+	cmdline_stdin_exit(cmdline);
+	/* Clear prompt, or it would prepend first message that follows. */
+	printf("\r%*s\r", (int)strlen(prompt), "");
+	fflush(stdout);
+	return debug_command;
+}
diff --git a/app/validate-bpf/debug_command.h b/app/validate-bpf/debug_command.h
new file mode 100644
index 0000000000..1a59ab251e
--- /dev/null
+++ b/app/validate-bpf/debug_command.h
@@ -0,0 +1,65 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd
+ */
+
+#include <cmdline_parse_string.h>
+
+#include <stdint.h>
+
+
+struct debug_command_comparison {
+	cmdline_fixed_string_t lhs;
+	cmdline_fixed_string_t op;
+	union {
+		cmdline_fixed_string_t register_rhs;
+		int64_t literal_rhs;
+	};
+};
+
+struct debug_command_parsed {
+	cmdline_fixed_string_t keyword;  /* Any keyword we don't need */
+	union {
+		struct debug_command_comparison comparison;
+		cmdline_fixed_string_t event;
+		int32_t frame_offset;
+		uint32_t instruction_count;
+		uint32_t instruction_offset;
+		uint32_t pc;
+		uint32_t point_number;
+		cmdline_fixed_string_t register_;
+	};
+};
+
+enum debug_command {
+	DEBUG_COMMAND_EOF,
+	DEBUG_COMMAND_BREAK,
+	DEBUG_COMMAND_BREAK_PC,
+	DEBUG_COMMAND_CATCH,
+	DEBUG_COMMAND_CLEAR,
+	DEBUG_COMMAND_CLEAR_EVENT,
+	DEBUG_COMMAND_CLEAR_PC,
+	DEBUG_COMMAND_CONTINUE,
+	DEBUG_COMMAND_DELETE,
+	DEBUG_COMMAND_DELETE_NUMBER,
+	DEBUG_COMMAND_INFO_FRAME,
+	DEBUG_COMMAND_INFO_FRAME_OFFSET,
+	DEBUG_COMMAND_INFO_POINTS,
+	DEBUG_COMMAND_INFO_REGISTER,
+	DEBUG_COMMAND_INFO_REGISTERS,
+	DEBUG_COMMAND_LIST,
+	DEBUG_COMMAND_LIST_COUNT,
+	DEBUG_COMMAND_LIST_PROGRAM,
+	DEBUG_COMMAND_MAY_LITERAL_RHS,
+	DEBUG_COMMAND_MAY_REGISTER_RHS,
+	DEBUG_COMMAND_QUIT,
+	DEBUG_COMMAND_RUN,
+	DEBUG_COMMAND_START,
+	DEBUG_COMMAND_STEP,
+	DEBUG_COMMAND_WHERE,
+};
+
+extern struct debug_command_parsed debug_command_parsed;
+
+/** Get and return one command line command, storing its data in the struct above. */
+enum debug_command
+debug_command_get(const char *prompt);
diff --git a/app/validate-bpf/eal_init_args.c b/app/validate-bpf/eal_init_args.c
new file mode 100644
index 0000000000..6ce9d561e0
--- /dev/null
+++ b/app/validate-bpf/eal_init_args.c
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd
+ */
+
+#include "internal.h"
+
+
+#define APP_EAL_INIT_ARG_SIZE_MAX sizeof("--log-level=lib.eal:warning")
+
+static const char APP_EAL_INIT_ARGS[][APP_EAL_INIT_ARG_SIZE_MAX] = {
+	"--log-level=lib.eal:warning",
+	"--no-huge",
+	"--no-pci",
+	"--no-hpet",
+	"--no-shconf",
+};
+
+#define APP_EAL_INIT_ARGC (/* program name */ 1 + RTE_DIM(APP_EAL_INIT_ARGS))
+
+int
+get_eal_init_argc(void)
+{
+	return APP_EAL_INIT_ARGC;
+}
+
+/*
+ * We cannot just return literal strings here, because rte_eal_init accepts
+ * an array of mutable pointers to mutable strings, so literals won't work.
+ * Instead we build a copy of APP_EAL_INIT_ARGS in a static mutable area.
+ */
+char**
+get_eal_init_argv(char *prog_name)
+{
+	/* Static arrays for mutable copies of actual args */
+	static char mutable_args[RTE_DIM(APP_EAL_INIT_ARGS)]
+		[APP_EAL_INIT_ARG_SIZE_MAX];
+	/*
+	 * Static array for pointers to args. First element will hold pointer
+	 * to the prog_name, last will be set to NULL, the rest will point to
+	 * elements of mutable_args with index one smaller.
+	 */
+	static char *mutable_ptrs[APP_EAL_INIT_ARGC + /* terminating NULL */ 1];
+
+	mutable_ptrs[0] = prog_name;
+	for (int argi = 0; argi != RTE_DIM(APP_EAL_INIT_ARGS); ++argi) {
+		const char * const const_arg = APP_EAL_INIT_ARGS[argi];
+		char * const mutable_arg = mutable_args[argi];
+		const int snprintf_rc = snprintf(mutable_arg,
+			APP_EAL_INIT_ARG_SIZE_MAX, "%s", const_arg);
+		RTE_VERIFY(snprintf_rc >= 0 &&
+			(size_t)snprintf_rc < APP_EAL_INIT_ARG_SIZE_MAX);
+		mutable_ptrs[1 + argi] = mutable_arg;
+	}
+	mutable_ptrs[RTE_DIM(mutable_ptrs) - 1] = NULL;
+
+	return mutable_ptrs;
+}
diff --git a/app/validate-bpf/internal.h b/app/validate-bpf/internal.h
new file mode 100644
index 0000000000..e134e68314
--- /dev/null
+++ b/app/validate-bpf/internal.h
@@ -0,0 +1,151 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd
+ */
+
+#include <rte_bpf.h>
+#include <rte_log.h>
+
+
+extern int validate_bpf_logtype;
+#define RTE_LOGTYPE_VALIDATE_BPF validate_bpf_logtype
+#define VALIDATE_BPF_LOG(level, ...) \
+	RTE_LOG_LINE(level, VALIDATE_BPF, "" __VA_ARGS__)
+
+struct rte_bpf_validate_debug;
+
+/**
+ * List of pointers to allocations, to keep track of things to free.
+ *
+ * May contain NULLs. May contain itself directly or via an outer struct.
+ */
+struct alloc_list {
+	size_t count;
+	void **ptrs;
+};
+
+/** Add new pointer to the alloc list, return its index. */
+size_t alloc_list_append(struct alloc_list *alloc_list, void *ptr);
+
+/** Replace pointer at the specified index in the alloc list. */
+void alloc_list_replace(struct alloc_list *alloc_list, size_t index, void *ptr);
+
+/** Free all allocations in the alloc list */
+void alloc_list_free_all(struct alloc_list *alloc_list);
+
+
+/** Parsed program arguments */
+struct args {
+	/* Allocations list, args.c internal use only. */
+	struct alloc_list _alloc_list;
+
+	/* Set if command line contains --help */
+	bool show_help;
+
+	/* BPF load parameters. */
+	struct rte_bpf_prm_ex bpf_prm;
+
+	/* Size of the mbuf data buffer. */
+	size_t mbuf_buf_size;
+};
+
+/** Print program usage information */
+void
+print_usage(const char *program_name);
+
+/** Print program defaults. */
+void
+print_defaults(void);
+
+/**
+ * Parse command-line arguments
+ *
+ * @param argc
+ *   Command-line arguments count, as received by main.
+ * @param argv
+ *   Command-line arguments array, as received by main.
+ *   Modified during the call due to the use of getopt_long.
+ *   Modifying it after the call invalidates the return value.
+ * @return
+ *   - parse results in case of success;
+ *   - NULL in case of an error (diagnostic will be printed to stderr)
+ */
+struct args *
+args_parse(int argc, char *argv[]);
+
+/** Destroy args struct returned by args_parse */
+void
+args_destroy(struct args *args);
+
+
+/** Value for the rte_eal_init argc argument */
+int
+get_eal_init_argc(void);
+
+/**
+ * Value for the rte_eal_init argv argument
+ *
+ * @param prog_name
+ *   Program name, can be obtained from argv[0]
+ */
+char **
+get_eal_init_argv(char *prog_name);
+
+
+/** Print types supported in command-line. */
+void
+print_supported_types(void);
+
+/**
+ * Parse text into arg.
+ * @param arg
+ *   Pointer to a variable to put parse result to.
+ *   Member `buf_size` of types related to `struct rte_mbuf` is set to
+ *   `RTE_MBUF_DEFAULT_BUF_SIZE`, adjust using `adjust_arg_buf_size` if needed.
+ * @param text
+ *   Text representation of the type, e.g. "struct rte_mbuf *".
+ * @param alloc_list
+ *   Alloc list to use for new allocations.
+ * @return
+ *   0 on success
+ *   -1 on failure
+ */
+int
+parse_arg(struct rte_bpf_arg *arg, const char *text);
+
+/**
+ * Parse text into xsym.
+ * @param arg
+ *   Pointer to a variable to put parse result to.
+ *   Member `buf_size` of types related to `struct rte_mbuf` is set to
+ *   `RTE_MBUF_DEFAULT_BUF_SIZE`, adjust using `adjust_xsym_buf_size` if needed.
+ * @param text
+ *   Text representation of the external symbol, e.g. "void exit(uint32_t)".
+ * @param alloc_list
+ *   Alloc list to use for new allocations.
+ * @return
+ *   0 on success
+ *   -1 on failure
+ */
+int
+parse_xsym(struct rte_bpf_xsym *xsym, const char *text,
+	struct alloc_list *alloc_list);
+
+/** If arg->buf_size is non-zero, set it to mbuf_buf_size */
+void
+adjust_arg_buf_size(struct rte_bpf_arg *arg, size_t mbuf_buf_size);
+
+/** If buf_size members are non-zero, set them to mbuf_buf_size */
+void
+adjust_xsym_buf_size(struct rte_bpf_xsym *xsym, size_t mbuf_buf_size);
+
+/** Create and set up global debugging session. */
+struct rte_bpf_validate_debug *
+debug_create(void);
+
+/** Clear and destroy global debugging session. */
+void
+debug_destroy(struct rte_bpf_validate_debug *debug);
+
+/** Tells caller if validation should be re-tried. */
+bool
+debug_validate_again(void);
diff --git a/app/validate-bpf/main.c b/app/validate-bpf/main.c
new file mode 100644
index 0000000000..c2f7399376
--- /dev/null
+++ b/app/validate-bpf/main.c
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd
+ */
+
+#include "internal.h"
+
+#include <stdio.h>
+#include <stdlib.h>
+
+#include <rte_bpf.h>
+#include <rte_debug.h>
+#include <rte_eal.h>
+#include <rte_errno.h>
+
+RTE_LOG_REGISTER(validate_bpf_logtype, validate-bpf, NOTICE);
+
+static int
+test_bpf_load(struct rte_bpf_prm_ex *prm)
+{
+	struct rte_bpf * const bpf = rte_bpf_load_ex(prm);
+
+	const int rc = -rte_errno;
+
+	rte_bpf_destroy(bpf);
+
+	return bpf == NULL ? rc : 0;
+}
+
+/* Re-starts validation of asked from interactive debugger. */
+static int
+test_bpf_load_with_restarts(struct rte_bpf_prm_ex *prm)
+{
+	for (;;) {
+		const int rc = test_bpf_load(prm);
+
+		if (rc == -ECANCELED && debug_validate_again())
+			continue;
+
+		if (rc != 0)
+			fprintf(stderr, "Error %d loading BPF: %s\n",
+				-rc, strerror(-rc));
+		else
+			fprintf(stderr, "Validation succeeded.\n");
+
+		return rc;
+	}
+}
+
+int
+main(int argc, char *argv[])
+{
+	int rc;
+
+	struct args * const args = args_parse(argc, argv);
+	if (args == NULL || args->show_help
+			|| args->bpf_prm.elf_file.path == NULL) {
+		args_destroy(args);
+		print_usage(argv[0]);
+		if (args == NULL)
+			/* Could not parse arguments. */
+			return 2;
+		print_supported_types();
+		print_defaults();
+		return 0;
+	}
+
+	const int eal_init_argc = get_eal_init_argc();
+	char ** const eal_init_argv = get_eal_init_argv(argv[0]);
+	rc = rte_eal_init(eal_init_argc, eal_init_argv);
+	if (rc < 0) {
+		fprintf(stderr, "Error %d initializing EAL: %s\n",
+			rte_errno, strerror(rte_errno));
+		args_destroy(args);
+		return EXIT_FAILURE;
+	}
+	RTE_VERIFY(rc == eal_init_argc - 1);
+
+	const int ret = test_bpf_load_with_restarts(&args->bpf_prm);
+
+	args_destroy(args);
+
+	rc = rte_eal_cleanup();
+	if (rc < 0) {
+		fprintf(stderr, "Error %d cleaning up EAL: %s\n",
+			rte_errno, strerror(rte_errno));
+		return EXIT_FAILURE;
+	}
+
+	return ret < 0 ? EXIT_FAILURE : EXIT_SUCCESS;
+}
diff --git a/app/validate-bpf/meson.build b/app/validate-bpf/meson.build
new file mode 100644
index 0000000000..03cfc329ef
--- /dev/null
+++ b/app/validate-bpf/meson.build
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2025 Huawei Technologies Co., Ltd
+
+sources = files(
+        'alloc_list.c',
+        'args.c',
+        'debug.c',
+        'debug_command.c',
+        'eal_init_args.c',
+        'main.c',
+        'parse_decl.c',
+)
+deps = ['bpf', 'cmdline']
diff --git a/app/validate-bpf/parse_decl.c b/app/validate-bpf/parse_decl.c
new file mode 100644
index 0000000000..1f95d90d37
--- /dev/null
+++ b/app/validate-bpf/parse_decl.c
@@ -0,0 +1,616 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd
+ */
+
+#include "internal.h"
+
+#include <ctype.h>
+#include <stdlib.h>
+
+#include <rte_ether.h>
+#include <rte_ip.h>
+#include <rte_mbuf_core.h>
+#include <rte_tcp.h>
+#include <rte_udp.h>
+
+#define RETURN_TEXT_ERROR(text, text_start, message, ...) do {                \
+	const int _offset = (text) - (text_start);                            \
+	VALIDATE_BPF_LOG(ERR, "at offset %d: " message,                       \
+		_offset, ## __VA_ARGS__);                                     \
+	VALIDATE_BPF_LOG(NOTICE, "%s", text_start);                           \
+	VALIDATE_BPF_LOG(NOTICE, "%*c", _offset + 1, '^');                    \
+	return -1;                                                            \
+} while (0)
+
+/* Used in place of any signature, this is not really being checked. */
+static uint64_t
+dummy_function(uint64_t arg1, uint64_t arg2, uint64_t arg3, uint64_t arg4,
+	uint64_t arg5)
+{
+	RTE_SET_USED(arg1);
+	RTE_SET_USED(arg2);
+	RTE_SET_USED(arg3);
+	RTE_SET_USED(arg4);
+	RTE_SET_USED(arg5);
+	return 0;
+}
+
+
+/* TOKENS AND TYPES */
+
+enum token {
+	TOKEN_UNRECOGNIZED = -1,
+	TOKEN_END = 0,
+
+	TOKEN_ASTERISK,
+	TOKEN_BRACKET_CLOSE,
+	TOKEN_BRACKET_OPEN,
+	TOKEN_COMMA,
+	TOKEN_PARENTHESIS_CLOSE,
+	TOKEN_PARENTHESIS_OPEN,
+	TOKEN_STRUCT,
+
+	TOKEN_TYPES_BEGIN,
+
+	TOKEN_TYPE_CHAR,
+	TOKEN_TYPE_ETHER_HEADER,
+	TOKEN_TYPE_INT32_T,
+	TOKEN_TYPE_IP_HEADER,
+	TOKEN_TYPE_IP_HEADERS,
+	TOKEN_TYPE_RTE_MBUF,
+	TOKEN_TYPE_TCP_HEADER,
+	TOKEN_TYPE_TCP_HEADERS,
+	TOKEN_TYPE_UDP_HEADER,
+	TOKEN_TYPE_UDP_HEADERS,
+	TOKEN_TYPE_UINT32_T,
+	TOKEN_TYPE_UINT64_T,
+	TOKEN_TYPE_UINTPTR_T,
+	TOKEN_TYPE_VOID,
+
+	TOKEN_TYPES_END,
+};
+
+/* Return true if the token is a type token */
+static bool
+is_type_token(enum token token)
+{
+	return token > TOKEN_TYPES_BEGIN && token < TOKEN_TYPES_END;
+}
+
+struct text_token {
+	const char *text;
+	unsigned int length;  /* Not size_t to fit this struct in 2 regs. */
+	enum token token;
+};
+
+#define TEXT_TOKEN_DEF(text_, token_) {                                       \
+	.text = text_,                                                        \
+	.length = sizeof(text_) - 1,                                          \
+	.token = token_,                                                      \
+}
+
+/* Token search table, MUST BE SORTED! */
+const struct text_token text_tokens[] = {
+	TEXT_TOKEN_DEF("(",			TOKEN_PARENTHESIS_OPEN),
+	TEXT_TOKEN_DEF(")",			TOKEN_PARENTHESIS_CLOSE),
+	TEXT_TOKEN_DEF("*",			TOKEN_ASTERISK),
+	TEXT_TOKEN_DEF(",",			TOKEN_COMMA),
+	TEXT_TOKEN_DEF("[",			TOKEN_BRACKET_OPEN),
+	TEXT_TOKEN_DEF("]",			TOKEN_BRACKET_CLOSE),
+	TEXT_TOKEN_DEF("char",			TOKEN_TYPE_CHAR),
+	TEXT_TOKEN_DEF("ether_header",		TOKEN_TYPE_ETHER_HEADER),
+	TEXT_TOKEN_DEF("int32_t",		TOKEN_TYPE_INT32_T),
+	TEXT_TOKEN_DEF("ip_header",		TOKEN_TYPE_IP_HEADER),
+	TEXT_TOKEN_DEF("ip_headers",		TOKEN_TYPE_IP_HEADERS),
+	TEXT_TOKEN_DEF("rte_ether_hdr",		TOKEN_TYPE_ETHER_HEADER),
+	TEXT_TOKEN_DEF("rte_ipv4_hdr",		TOKEN_TYPE_IP_HEADER),
+	TEXT_TOKEN_DEF("rte_mbuf",		TOKEN_TYPE_RTE_MBUF),
+	TEXT_TOKEN_DEF("rte_tcp_hdr",		TOKEN_TYPE_TCP_HEADER),
+	TEXT_TOKEN_DEF("rte_udp_hdr",		TOKEN_TYPE_UDP_HEADER),
+	TEXT_TOKEN_DEF("struct",		TOKEN_STRUCT),
+	TEXT_TOKEN_DEF("tcp_header",		TOKEN_TYPE_TCP_HEADER),
+	TEXT_TOKEN_DEF("tcp_headers",		TOKEN_TYPE_TCP_HEADERS),
+	TEXT_TOKEN_DEF("udp_header",		TOKEN_TYPE_UDP_HEADER),
+	TEXT_TOKEN_DEF("udp_headers",		TOKEN_TYPE_UDP_HEADERS),
+	TEXT_TOKEN_DEF("uint32_t",		TOKEN_TYPE_UINT32_T),
+	TEXT_TOKEN_DEF("uint64_t",		TOKEN_TYPE_UINT64_T),
+	TEXT_TOKEN_DEF("uintptr_t",		TOKEN_TYPE_UINTPTR_T),
+	TEXT_TOKEN_DEF("void",			TOKEN_TYPE_VOID),
+};
+
+const struct text_token text_token_unrecognized = { "", 0, TOKEN_UNRECOGNIZED };
+const struct text_token text_token_end = { "", 0, TOKEN_END };
+
+/* IP header maximum possible size with options. */
+#define IP_HEADER_MAX_SIZE 60
+#define IP_HEADERS_MAX_SIZE (sizeof(struct rte_ether_hdr) + IP_HEADER_MAX_SIZE)
+#define TCP_HEADERS_MAX_SIZE (IP_HEADERS_MAX_SIZE + sizeof(struct rte_tcp_hdr))
+#define UDP_HEADERS_MAX_SIZE (IP_HEADERS_MAX_SIZE + sizeof(struct rte_udp_hdr))
+
+#define POINTER_SIZE (sizeof(char *))
+
+const size_t type_token_size[] = {
+	[TOKEN_TYPE_CHAR]		= sizeof(char),
+	[TOKEN_TYPE_ETHER_HEADER]	= sizeof(struct rte_ether_hdr),
+	[TOKEN_TYPE_INT32_T]		= sizeof(int32_t),
+	[TOKEN_TYPE_IP_HEADERS]		= IP_HEADERS_MAX_SIZE,
+	[TOKEN_TYPE_IP_HEADER]		= sizeof(struct rte_ipv4_hdr),
+	[TOKEN_TYPE_TCP_HEADERS]	= TCP_HEADERS_MAX_SIZE,
+	[TOKEN_TYPE_TCP_HEADER]		= sizeof(struct rte_tcp_hdr),
+	[TOKEN_TYPE_UDP_HEADERS]	= UDP_HEADERS_MAX_SIZE,
+	[TOKEN_TYPE_UDP_HEADER]		= sizeof(struct rte_udp_hdr),
+	[TOKEN_TYPE_UINT32_T]		= sizeof(uint32_t),
+	[TOKEN_TYPE_UINT64_T]		= sizeof(uint64_t),
+	[TOKEN_TYPE_UINTPTR_T]		= sizeof(uintptr_t),
+};
+
+/*
+ * Struct rte_bpf_arg augmented with a type of pointer to it, since rte_bpf_arg
+ * by itself may not contain enough information to determine its pointer type.
+ */
+struct arg_info {
+	struct rte_bpf_arg value;
+	enum rte_bpf_arg_type ptr_type;
+	bool is_array;
+};
+
+/* Return arg_info struct described by the specified type token. */
+static struct arg_info
+get_type_token_arg(enum token type)
+{
+	RTE_ASSERT(is_type_token(type));
+	switch (type) {
+	case TOKEN_TYPE_VOID:
+		return (struct arg_info){
+			.value = { .type = RTE_BPF_ARG_UNDEF },
+			.ptr_type = RTE_BPF_ARG_PTR,
+		};
+	case TOKEN_TYPE_RTE_MBUF:
+		return (struct arg_info){
+			.value = {
+				.type = RTE_BPF_ARG_RAW,
+				.size = sizeof(struct rte_mbuf),
+				.buf_size = RTE_MBUF_DEFAULT_BUF_SIZE,
+			},
+			.ptr_type = RTE_BPF_ARG_PTR_MBUF,
+		};
+	default:
+		/* Should only reach here for normal sized types. */
+		RTE_ASSERT((size_t)type < RTE_DIM(type_token_size) &&
+			type_token_size[type] != 0);
+		return (struct arg_info){
+			.value = {
+				.type = RTE_BPF_ARG_RAW,
+				.size = type_token_size[type],
+			},
+			.ptr_type = RTE_BPF_ARG_PTR,
+		};
+	}
+}
+
+
+/* PARSING TEXT INTO TOKENS */
+
+/* Return true if character matches [a-zA-Z0-9_] in regex */
+static bool
+iswordchar(char character)
+{
+	return isalnum(character) || character == '_';
+}
+
+/*
+ * Compare pointer to text with pointer to struct text_token to determine
+ * if text starts with the specified token.
+ */
+static int
+text_and_text_token_cmp(const void *text_void_ptr, const void *text_token_void_ptr)
+{
+	int result;
+	const char * const text = text_void_ptr;
+	const struct text_token * const text_token = text_token_void_ptr;
+
+	result = strncmp(text, text_token->text, text_token->length);
+
+	/* Checking the case of a partial word match. */
+	if (result == 0 && iswordchar(text[text_token->length - 1]) &&
+			iswordchar(text[text_token->length]))
+		/* Text word is longer than the token. */
+		result = 1;
+
+	return result;
+}
+
+/* Advance pointed character pointer to the first non-space character. */
+static void
+skip_space(const char **text_ptr)
+{
+	while (isspace(**text_ptr))
+		++*text_ptr;
+}
+
+/*
+ * Recognize and return a token starting text.
+ * Return text_token_end if text is empty.
+ * Return text_token_unrecognized if text starts with unknown token.
+ */
+static struct text_token
+peek_text_token(const char *text)
+{
+	if (*text == '\0')
+		return text_token_end;
+	const struct text_token * const text_token = bsearch(text, text_tokens,
+		RTE_DIM(text_tokens), sizeof(text_tokens[0]),
+		text_and_text_token_cmp);
+	if (text_token == NULL)
+		return text_token_unrecognized;
+	return *text_token;
+}
+
+/*
+ * Advance pointed text starting with the specified token to the first
+ * non-space character after it.
+ * Do nothing if called for text_token_end or text_token_unrecognized.
+ */
+static void
+consume_text_token(const char **text_ptr, struct text_token text_token)
+{
+	RTE_ASSERT(memcmp(*text_ptr, text_token.text, text_token.length) == 0);
+	*text_ptr += text_token.length;
+	skip_space(text_ptr);
+}
+
+/* Return length of the word starting at `text`. */
+static size_t
+find_word_length(const char *text)
+{
+	size_t word_length = 0;
+	while (iswordchar(text[word_length]))
+		++word_length;
+	return word_length;
+}
+
+/* Create a copy of the word starting text, advance to next token. */
+static const char *
+take_name(const char **text_ptr, struct alloc_list *alloc_list)
+{
+	const size_t word_length = find_word_length(*text_ptr);
+	if (word_length == 0)
+		/* Text does not start with a word. */
+		return NULL;
+
+	/* Allocate memory for the word and add it to the alloc_list */
+	char *word = malloc(word_length + 1);
+	RTE_VERIFY(word != NULL);
+	alloc_list_append(alloc_list, word);
+
+	/* Copy and terminate word contents. */
+	memcpy(word, *text_ptr, word_length);
+	word[word_length] = '\0';
+
+	/* Advance text pointer. */
+	*text_ptr += word_length;
+	skip_space(text_ptr);
+
+	return word;
+}
+
+/* Read a number starting text, advance to next token. */
+static int
+take_number(size_t *number, const char **text_ptr)
+{
+	/* Read a word and let strtoull to decide if it's a number. */
+	const size_t word_length = find_word_length(*text_ptr);
+	if (word_length == 0)
+		/* Text does not start with a word. */
+		return -ENOENT;
+
+	errno = 0;
+	char *number_end;
+	unsigned long long_number = strtoul(*text_ptr, &number_end, 0);
+	if (errno > 0)
+		return -errno;
+	if (number_end != *text_ptr + word_length)
+		/* Could not parse whole word. */
+		return -EINVAL;
+
+	*number = long_number;
+
+	/* Advance text pointer. */
+	*text_ptr += word_length;
+	skip_space(text_ptr);
+
+	return 0;
+}
+
+
+/* PARSING DECLARATION PARTS */
+
+/* Change arg into a reference. */
+static void
+change_into_reference(struct arg_info *arg)
+{
+	if (RTE_BPF_ARG_PTR_TYPE(arg->value.type) != 0) {
+		VALIDATE_BPF_LOG(WARNING,
+			"After taking reference to a pointer the latter "
+			"will be described as an opaque pointer-size blob.");
+		RTE_ASSERT(arg->ptr_type == RTE_BPF_ARG_PTR);
+		arg->value.size = POINTER_SIZE;
+	}
+	arg->value.type = arg->ptr_type;
+	arg->ptr_type = RTE_BPF_ARG_PTR;
+	arg->is_array = false;
+}
+
+/*
+ * Recognize and consume arg starting text, advance to next token.
+ */
+static int
+take_arg(struct arg_info *arg, const char **text_ptr, const char *text_start)
+{
+	struct text_token next = peek_text_token(*text_ptr);
+
+	if (next.token == TOKEN_STRUCT) {
+		consume_text_token(text_ptr, next);
+		next = peek_text_token(*text_ptr);
+	}
+
+	if (!is_type_token(next.token))
+		RETURN_TEXT_ERROR(*text_ptr, text_start, "expect type");
+	const enum token type = next.token;
+	consume_text_token(text_ptr, next);
+	next = peek_text_token(*text_ptr);
+
+	*arg = get_type_token_arg(type);
+
+	while (next.token == TOKEN_ASTERISK) {
+		consume_text_token(text_ptr, next);
+		next = peek_text_token(*text_ptr);
+		change_into_reference(arg);
+	}
+
+	while (next.token == TOKEN_BRACKET_OPEN) {
+		consume_text_token(text_ptr, next);
+
+		/* Initialize to zero to avoid spurious compiler warnings. */
+		size_t array_length = 0;
+		if (take_number(&array_length, text_ptr) < 0)
+			RETURN_TEXT_ERROR(*text_ptr, text_start, "expect length");
+		next = peek_text_token(*text_ptr);
+
+		if (arg->value.size != 0 &&
+				array_length > SIZE_MAX / arg->value.size)
+			RETURN_TEXT_ERROR(*text_ptr, text_start, "type too big");
+
+		if (next.token != TOKEN_BRACKET_CLOSE)
+			RETURN_TEXT_ERROR(*text_ptr, text_start, "expect ']'");
+		consume_text_token(text_ptr, next);
+		next = peek_text_token(*text_ptr);
+
+		change_into_reference(arg);
+		arg->value.size *= array_length;
+		arg->is_array = true;
+	}
+
+	return 0;
+}
+
+/* Fill struct rte_bpf_arg within xsym trying not to unzero the padding. */
+static void
+fill_xsym_arg(struct rte_bpf_arg *target, struct rte_bpf_arg source)
+{
+	/* Copy fields individually to try and prevent copying the padding. */
+	target->type = source.type;
+	target->size = source.size;
+	target->buf_size = source.buf_size;
+}
+
+/* Build and return struct rte_bpf_arg of type RTE_BPF_XTYPE_VAR */
+static int
+fill_var_xsym(struct rte_bpf_xsym *xsym, struct arg_info arg, const char *name,
+	struct alloc_list *alloc_list)
+{
+	/* Variables are passed by reference, except for arrays. */
+	if (!arg.is_array) {
+		if (RTE_BPF_ARG_PTR_TYPE(arg.value.type) != 0)
+			VALIDATE_BPF_LOG(WARNING,
+				"External pointers may not work as expected "
+				"because all external variables are passed by "
+				"reference but there is currently no way to "
+				"describe double pointer to the validator.");
+		change_into_reference(&arg);
+	}
+
+	/* Allocate something to assign to a val pointer. */
+	void * const val = calloc(1, RTE_MAX(1u, arg.value.size));
+	if (val == NULL) {
+		VALIDATE_BPF_LOG(ERR, "could not allocate enough memory");
+		return -1;
+	}
+	alloc_list_append(alloc_list, val);
+
+	/* Need all padding and unused fields to be zero-filled. */
+	memset(xsym, 0, sizeof(*xsym));
+	xsym->name = name;
+	xsym->type = RTE_BPF_XTYPE_VAR;
+	xsym->var.val = val;
+	fill_xsym_arg(&xsym->var.desc, arg.value);
+
+	return 0;
+}
+
+/* Build and return struct rte_bpf_arg of type RTE_BPF_XTYPE_FUNC */
+static void
+fill_func_xsym(struct rte_bpf_xsym *xsym, struct arg_info arg, const char *name)
+{
+	/* Need all padding and unused fields to be zero-filled. */
+	memset(xsym, 0, sizeof(*xsym));
+	xsym->name = name;
+	xsym->type = RTE_BPF_XTYPE_FUNC;
+	xsym->func.val = &dummy_function;
+	fill_xsym_arg(&xsym->func.ret, arg.value);
+}
+
+/*
+ * Parse and store function arguments, advance to next token after ')'.
+ * Value of *text_ptr should point to the next token after '('.
+ */
+static int
+take_func_xsym_args(struct rte_bpf_xsym *xsym, const char **text_ptr,
+	const char *text_start)
+{
+	struct arg_info arg;
+	struct text_token delimiter = peek_text_token(*text_ptr);
+
+	while (delimiter.token != TOKEN_PARENTHESIS_CLOSE) {
+		if (xsym->func.nb_args == EBPF_FUNC_MAX_ARGS)
+			RETURN_TEXT_ERROR(*text_ptr, text_start,
+				"too many arguments, maximum %d allowed",
+				EBPF_FUNC_MAX_ARGS);
+
+		if (take_arg(&arg, text_ptr, text_start) < 0)
+			return -1;
+		if (arg.value.type == RTE_BPF_ARG_UNDEF &&
+				xsym->func.nb_args != 0)
+			RETURN_TEXT_ERROR(*text_ptr, text_start,
+				"arguments of type void are not allowed");
+		fill_xsym_arg(&xsym->func.args[xsym->func.nb_args++],
+			arg.value);
+
+		delimiter = peek_text_token(*text_ptr);
+		switch (delimiter.token) {
+		case TOKEN_COMMA:
+			consume_text_token(text_ptr, delimiter);
+			continue;
+		case TOKEN_PARENTHESIS_CLOSE:
+			break;
+		default:
+			RETURN_TEXT_ERROR(*text_ptr, text_start,
+				"expect ')' or ','");
+		}
+	}
+	consume_text_token(text_ptr, delimiter);
+
+	/* Special case of single void argument. */
+	if (xsym->func.nb_args == 1 &&
+			xsym->func.args[0].type == RTE_BPF_ARG_UNDEF) {
+		xsym->func.nb_args = 0;
+		/* Need all padding and unused fields to be zero-filled. */
+		fill_xsym_arg(&xsym->func.args[0], (struct rte_bpf_arg){});
+	}
+
+	return 0;
+}
+
+/* Make sure text has ended. */
+static int
+ensure_end(const char *text, const char *text_start)
+{
+	if (peek_text_token(text).token != TOKEN_END)
+		RETURN_TEXT_ERROR(text, text_start, "trailing garbage");
+	return 0;
+}
+
+/* Parse and store xsym, advance to next token. */
+static int
+take_xsym(struct rte_bpf_xsym *xsym, const char **text_ptr,
+	const char *text_start, struct alloc_list *alloc_list)
+{
+	struct arg_info arg;
+
+	if (take_arg(&arg, text_ptr, text_start) < 0)
+		return -1;
+
+	const char * const name = take_name(text_ptr, alloc_list);
+	if (name == NULL)
+		RETURN_TEXT_ERROR(*text_ptr, text_start, "expect name");
+
+	const struct text_token next = peek_text_token(*text_ptr);
+	switch (next.token) {
+	case TOKEN_END:
+		if (fill_var_xsym(xsym, arg, name, alloc_list) < 0)
+			return -1;
+		break;
+	case TOKEN_PARENTHESIS_OPEN:
+		consume_text_token(text_ptr, next);
+		fill_func_xsym(xsym, arg, name);
+		if (take_func_xsym_args(xsym, text_ptr, text_start) < 0)
+			return -1;
+		break;
+	default:
+		RETURN_TEXT_ERROR(*text_ptr, text_start,
+			"expect '(' or text end");
+	}
+	return 0;
+}
+
+
+/* PUBLIC FUNCTIONS */
+
+void
+print_supported_types(void)
+{
+	printf("TYPE: [struct] BASIC_TYPE [*]... [[N]]...\n");
+	printf("BASIC_TYPE: one of\n");
+	for (int tti = 0; tti != RTE_DIM(text_tokens); ++tti) {
+		if (is_type_token(text_tokens[tti].token))
+			printf("\t%s\n", text_tokens[tti].text);
+	}
+}
+
+int
+parse_arg(struct rte_bpf_arg *arg, const char *text)
+{
+	struct arg_info arg_info;
+	const char * const text_start = text;
+	skip_space(&text);
+	if (take_arg(&arg_info, &text, text_start) < 0)
+		return -1;
+	if (ensure_end(text, text_start) < 0)
+		return -1;
+	if (arg_info.ptr_type != RTE_BPF_ARG_PTR)
+		VALIDATE_BPF_LOG(WARNING,
+			"`%s` has a special pointer type which was left unused; "
+			"argument was set to an opaque blob.",
+			text_start);
+	*arg = arg_info.value;
+	return 0;
+}
+
+int
+parse_xsym(struct rte_bpf_xsym *xsym, const char *text,
+	struct alloc_list *alloc_list)
+{
+	const char * const text_start = text;
+	skip_space(&text);
+	if (take_xsym(xsym, &text, text_start, alloc_list) < 0)
+		return -1;
+	if (ensure_end(text, text_start) < 0)
+		return -1;
+	return 0;
+}
+
+void
+adjust_arg_buf_size(struct rte_bpf_arg *arg, size_t mbuf_buf_size)
+{
+	if (arg->buf_size != 0)
+		/* Non-zero buf_size indicates mbuf or a pointer to it. */
+		arg->buf_size = mbuf_buf_size;
+}
+
+void
+adjust_xsym_buf_size(struct rte_bpf_xsym *xsym, size_t mbuf_buf_size)
+{
+	switch (xsym->type) {
+	case RTE_BPF_XTYPE_FUNC:
+		for (uint32_t argi = 0; argi != xsym->func.nb_args; ++argi)
+			adjust_arg_buf_size(&xsym->func.args[argi],
+				mbuf_buf_size);
+		adjust_arg_buf_size(&xsym->func.ret, mbuf_buf_size);
+		break;
+	case RTE_BPF_XTYPE_VAR:
+		adjust_arg_buf_size(&xsym->var.desc, mbuf_buf_size);
+		break;
+	default:
+		rte_panic("Unexpected xsym type %d\n", xsym->type);
+	}
+}
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 4b3e5d995c..7bd4ae773f 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -55,6 +55,11 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Added BPF validation application.**
+
+  Added ``dpdk-validate-bpf`` tool to pre-validate eBPF programs for
+  compatibility with the ``lib/bpf`` execution context.
+
 
 Removed Items
 -------------
diff --git a/doc/guides/tools/index.rst b/doc/guides/tools/index.rst
index 13f75a5bc6..1c43060e15 100644
--- a/doc/guides/tools/index.rst
+++ b/doc/guides/tools/index.rst
@@ -26,3 +26,4 @@ DPDK Tools User Guides
     testmldev
     graph
     dts
+    validate_bpf
diff --git a/doc/guides/tools/validate_bpf.rst b/doc/guides/tools/validate_bpf.rst
new file mode 100644
index 0000000000..9e2d58cfbe
--- /dev/null
+++ b/doc/guides/tools/validate_bpf.rst
@@ -0,0 +1,97 @@
+..  SPDX-License-Identifier: BSD-3-Clause
+    Copyright(c) 2026 The DPDK contributors
+
+dpdk-validate-bpf Application
+=============================
+
+The ``dpdk-validate-bpf`` tool is an application that allows evaluating BPF
+programs against the ``lib/bpf`` library.  It can be used to pre-validate BPF
+programs before loading them in a real application to ensure that they pass the
+internal verifier. This makes it a useful tool for integrating into build
+systems and continuous integration (CI) pipelines to verify the correctness
+of BPF programs during compilation, as well as for debugging validation issues.
+
+Running the Application
+-----------------------
+
+The tool requires a path to a compiled BPF object file. It also provides options
+to configure the execution environment and external symbol definitions.
+
+For a comprehensive list of options and their meanings, refer to the
+built-in help by running ``dpdk-validate-bpf --help``.
+
+The most important options for a minimal example are:
+
+*   ``--prog-arg <type>``
+
+    Define program arguments, if different from ``struct rte_mbuf *``.
+    This argument may be repeated up to 5 times.
+
+*   ``--xsym '<type> <name> | <type> <name>(<type>, ...)'``
+
+    Define an external symbol (variable or function) that the BPF program uses.
+    This allows the validator to recognize external calls and memory accesses.
+    Multiple external symbols can be defined by repeating this option.
+
+*   ``--section <name>``
+
+    Specify the ELF section name in the BPF object file to load and validate.
+    The default section name is ``.text``, which is typically fine in cases
+    where the object file contains only one program.
+
+Interactive Debugging Mode
+--------------------------
+
+The interactive mode (enabled with the ``--debug`` flag) allows the user to
+debug the BPF validation process itself. This is particularly useful when
+BPF program fails verification, allowing you to trace the state changes per
+instruction and understand the validator's decisions.
+
+Design
+~~~~~~
+
+The interactive debugger provides a command-line interface similar to GDB.
+It allows setting breakpoints at specific instructions, or catchpoints on
+validator events (such as ``branch-enter`` or ``branch-prune``).
+Users can step through the validation process,
+inspect the state of registers, and query if certain conditional jumps may
+be taken based on the validator's knowledge of the program state.
+
+Usage Example
+~~~~~~~~~~~~~
+
+Launch the tool in debug mode with a compiled BPF object file:
+
+.. code-block:: console
+
+   $ dpdk-validate-bpf bpf_prog.o --prog-arg={'void *',uint64_t} --debug
+    =>          0:  b7 00 00 00 01 00 00 00         mov r0, #0x1
+    (validate) list 3
+    =>          0:  b7 00 00 00 01 00 00 00         mov r0, #0x1
+                1:  25 02 01 00 0e 00 00 00         jgt r2, #0xe, L3
+                2:  b7 00 00 00 00 00 00 00         mov r0, #0x0
+    (validate) break 2
+    Breakpoint 0 at 2.
+    (validate) catch branch-enter
+    Catchpoint 1 on branch-enter.
+    (validate) continue
+    Catchpoint 1 on branch-enter.
+    Entered new branch at pc 1.
+    =>          3:  95 00 00 00 00 00 00 00         exit
+    (validate) where
+                1:  25 02 01 00 0e 00 00 00         jgt r2, #0xe, L3        ; taken
+    =>          3:  95 00 00 00 00 00 00 00         exit
+    (validate) info r1
+       r1:  %buffer<0> + 0
+    (validate) info r2
+       r2:  0xf..UINT64_MAX
+    (validate) may r2 <= 14
+    NO
+    (validate) continue
+    Catchpoint 1 on branch-enter.
+    Entered new branch at pc 1.
+    Breakpoint 0 at 2.
+    =>          2:  b7 00 00 00 00 00 00 00         mov r0, #0x0
+    (validate) continue
+    Validation succeeded.
+    (validate) quit
-- 
2.43.0

