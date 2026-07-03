Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA24C43458
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Jul 2026 14:42:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 09CA94026F;
	Fri,  3 Jul 2026 16:42:37 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id E523F4003C
 for <dev@dpdk.org>; Fri,  3 Jul 2026 16:42:35 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gsGfZ2K2XzJ468W;
 Fri,  3 Jul 2026 22:41:42 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id F2AA840575;
 Fri,  3 Jul 2026 22:42:33 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 3 Jul 2026 16:42:33 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: 
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <stephen@networkplumber.org>
Subject: [PATCH] test/suites: clean up per-test directories
Date: Fri, 3 Jul 2026 15:42:16 +0100
Message-ID: <20260703144216.43804-1-marat.khalili@huawei.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapema100003.china.huawei.com (7.182.19.100) To
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

After commit 5ef166838394 ("test: add file-prefix for all fast-tests on
Linux") each test within a suite has its own --file-prefix filled with
the test name to enable parallel execution. It brought a couple of
drawbacks though:
* Solution only applied to one test suite.
* Each working directory occupied ~25MB, with hundreds of tests this
  easily overfilled /run filesystems of small VMs. Currently executing
  fast-tests suite consumes 2.8GB of RAM, and adding more tests created
  problems for github CI.
* While it enabled parallel execution of tests within a single build
  directory, --file-prefix argument could no longer be specified
  externally (caused duplicate argument error). Specifying custom
  --file-prefix was necessary when multiple builds ran in the same
  environment, so the corresponding workflow became broken.

Move --file-prefix logic into a separate shell script, preserving
existing argument and cleaning the work directory after the test.
Apply it uniformly to all tests.

Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
---
 app/test/suites/meson.build                  | 34 ++++----
 app/test/suites/run_test_with_temp_prefix.sh | 82 ++++++++++++++++++++
 2 files changed, 102 insertions(+), 14 deletions(-)
 create mode 100755 app/test/suites/run_test_with_temp_prefix.sh

diff --git a/app/test/suites/meson.build b/app/test/suites/meson.build
index 786c459c24b3..3d75a8a66924 100644
--- a/app/test/suites/meson.build
+++ b/app/test/suites/meson.build
@@ -23,6 +23,16 @@ if not has_hugepage
     endif
 endif
 
+if is_linux
+    # use wrapper providing per-test work directories to allow parallel runs
+    test_args_prefix = [dpdk_test]
+    dpdk_test = find_program('run_test_with_temp_prefix.sh')
+    dpdk_test_as_arg = dpdk_test.full_path()
+else
+    test_args_prefix = []
+    dpdk_test_as_arg = dpdk_test
+endif
+
 # process source files to determine the different unit test suites
 # - fast_tests
 # - perf_tests
@@ -42,6 +52,7 @@ foreach suite:test_suites
                 warning('Test "@0@" is not defined in any test suite'.format(t))
             endif
             test(t, dpdk_test,
+                    args: test_args_prefix,
                     env: ['DPDK_TEST=' + t],
                     timeout: timeout_seconds,
                     is_parallel: false)
@@ -49,6 +60,7 @@ foreach suite:test_suites
     elif suite_name == 'stress-tests'
         foreach t: suite_tests
             test(t, dpdk_test,
+                    args: test_args_prefix,
                     env: ['DPDK_TEST=' + t],
                     timeout: timeout_seconds_stress,
                     is_parallel: false,
@@ -58,6 +70,7 @@ foreach suite:test_suites
         # simple cases - tests without parameters or special handling
         foreach t: suite_tests
             test(t, dpdk_test,
+                    args: test_args_prefix,
                     env: ['DPDK_TEST=' + t],
                     timeout: timeout_seconds,
                     is_parallel: false,
@@ -81,7 +94,7 @@ foreach suite:test_suites
             nohuge = params[1] == 'NOHUGE_OK'
             asan = params[2] == 'ASAN_OK'
 
-            test_args = []
+            test_args = test_args_prefix
             if nohuge
                 test_args += test_no_huge_args
             elif not has_hugepage
@@ -94,25 +107,17 @@ foreach suite:test_suites
                 test_args += ['-d', dpdk_drivers_build_dir]
             endif
 
-            # use unique file-prefix to allow parallel runs
-            file_prefix = []
-            trace_prefix = []
-            if is_linux
-                file_prefix = ['--file-prefix=' + test_name.underscorify()]
-                trace_prefix = [file_prefix[0] + '_with_traces']
-            endif
-
             test(test_name, dpdk_test,
-                args : test_args + file_prefix,
+                args: test_args,
                 env: ['DPDK_TEST=' + test_name],
                 timeout : timeout_seconds_fast,
                 is_parallel : false,
                 suite : 'fast-tests')
             if not is_windows and test_name == 'trace_autotest'
-                trace_extra = ['--trace=.*',
-                               '--trace-dir=@0@'.format(meson.current_build_dir())]
+                test_args += ['--trace=.*']
+                test_args += ['--trace-dir=@0@'.format(meson.current_build_dir())]
                 test(test_name + '_with_traces', dpdk_test,
-                    args : test_args + trace_extra + trace_prefix,
+                    args: test_args,
                     env: ['DPDK_TEST=' + test_name],
                     timeout : timeout_seconds_fast,
                     is_parallel : false,
@@ -124,7 +129,7 @@ endforeach
 
 # standalone test for telemetry
 if not is_windows and dpdk_conf.has('RTE_LIB_TELEMETRY')
-    test_args = [dpdk_test]
+    test_args = [dpdk_test_as_arg] + test_args_prefix
     test_args += test_no_huge_args
     if get_option('default_library') == 'shared'
         test_args += ['-d', dpdk_drivers_build_dir]
@@ -166,6 +171,7 @@ dump_test_names = [
 ]
 foreach arg : dump_test_names
     test(arg, dpdk_test,
+                args : test_args,
                 env : ['DPDK_TEST=' + arg],
                 timeout : timeout_seconds_fast,
                 is_parallel : false,
diff --git a/app/test/suites/run_test_with_temp_prefix.sh b/app/test/suites/run_test_with_temp_prefix.sh
new file mode 100755
index 000000000000..0c466ec25ea1
--- /dev/null
+++ b/app/test/suites/run_test_with_temp_prefix.sh
@@ -0,0 +1,82 @@
+#!/bin/bash
+# Run dpdk test with a temporary prefix and clean it up afterwards
+set -eEuo pipefail
+
+# Get value of the long option with name in the first argument, from the rest.
+get_arg_value() {
+	local arg_name="$1"
+	shift 1
+
+	local arg_value=''
+	local grab_next=false
+	local arg
+
+	for arg in "$@"; do
+		if $grab_next; then
+			arg_value="$arg"
+			grab_next=false
+		elif [[ "$arg" == "${arg_name}="* ]]; then
+			arg_value="${arg#*=}"
+		elif [[ "$arg" == "$arg_name" ]]; then
+			grab_next=true
+		fi
+	done
+
+	printf "%s\n" "$arg_value"
+}
+
+# Delete work directory passing through the return code
+delete_work_directory() {
+	local -r test_rc="$1"
+	[[ -z "${WORK_DIRECTORY:-}" ]] || rm -rf "$WORK_DIRECTORY"
+	return "$test_rc"
+}
+
+main() {
+	if [[ $# -eq 0 ]]; then
+		printf "Usage: %s <test_command> [arguments...]\n" "$0" >&2
+		printf "%s %s\n" \
+			"Runs a DPDK test with a temporary file prefix" \
+			"and cleans up the working directory." >&2
+		printf "Ensure the DPDK_TEST environment variable is set.\n" >&2
+		exit 1
+	fi
+	local test_command=("$@")
+
+	if [[ -z "${DPDK_TEST:-}" ]]; then
+		printf "Ensure the DPDK_TEST environment variable is set.\n" >&2
+		exit 1
+	fi
+	local -r dpdk_test="$DPDK_TEST"
+
+	# Make sure file prefix is determined and set in test args
+	local file_prefix="$(get_arg_value --file-prefix "${test_command[@]}")"
+	if [[ -z "$file_prefix" ]]; then
+		# If not yet specified, set --file-prefix to test name
+		file_prefix="$dpdk_test"
+		if [[ -n "$(get_arg_value --trace "${test_command[@]}")" ]]; then
+			# Some tests runs twice, with and without traces
+			file_prefix="${file_prefix}_with_traces"
+		fi
+		test_command+=("--file-prefix=$file_prefix")
+	fi
+
+	# Make sure runtime directory is determined and set in the environment
+	local runtime_directory="${RUNTIME_DIRECTORY:-}"
+	if [[ -z "$runtime_directory" ]]; then
+		# Follow the algorithm in eal_filesystem.c
+		if [[ "$EUID" -eq 0 ]]; then
+		    runtime_directory='/var/run'
+		else
+		    runtime_directory="${XDG_RUNTIME_DIR:-/tmp}"
+		fi
+		export RUNTIME_DIRECTORY="$runtime_directory"
+	fi
+
+	WORK_DIRECTORY="$runtime_directory/dpdk/$file_prefix"
+	trap 'delete_work_directory "$?"' EXIT
+
+	"${test_command[@]}"
+}
+
+main "$@"
-- 
2.43.0

