Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15064CDB46F
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Jun 2026 17:02:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE33F402E9;
	Mon, 22 Jun 2026 19:02:35 +0200 (CEST)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com
 [209.85.219.43]) by mails.dpdk.org (Postfix) with ESMTP id 50DF54021F
 for <dev@dpdk.org>; Mon, 22 Jun 2026 19:02:34 +0200 (CEST)
Received: by mail-qv1-f43.google.com with SMTP id
 6a1803df08f44-8db35680d0cso873886d6.1
 for <dev@dpdk.org>; Mon, 22 Jun 2026 10:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1782147753; x=1782752553; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D2J8ubpEAke/QskO5WkPXYBjxHIDH7JzpdPTyYV3cxE=;
 b=PbaoXA5L1xTWUjhVa7khJsDDyOfb91jBA3WBedpar85n3rJQPpJVQ36TPX46L3Rhx9
 xLC81d1akJFSJMLX7igonUpEKdNFmLE0pkEkhfqqteiEmhDQPMdMjqgLGMM2ttLx1rjD
 kUt1T/sH2zcHcTNGgQHkdDFFq3grx6oqLgJoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782147753; x=1782752553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=D2J8ubpEAke/QskO5WkPXYBjxHIDH7JzpdPTyYV3cxE=;
 b=gxBaKVHKcjpN/y+Mw18uY2Juby6RUL13ZWfbPnkvmCRPWVumr/AZkzQscp6a64kwz8
 47oBKqJPgoFfx/Sd7jnzuk6/75+JuLXwUPA36v79dYBl8CF6DU+kEdmd6jiTVYua+oba
 UNJ9GHK/7jb8zuhQlzVB4uKB5i7gGnnazh2ItZ0vFNC2BnVUZ8fxJ9YucTDnkqCazuEP
 oNYeDELwMCPjAsqb/RBudQ3fSgCt0LRiNL19tSblXU1TvvDk8nJNxM/S/23OMk0RHr5N
 xPkOL2NhiVruG5+V4Mo3b/rVsMgJm/Mk+hEED2ozYLczd4pLZM6hBHsSsO20n0WnnZMk
 D5oQ==
X-Gm-Message-State: AOJu0YxudMVPo7WoyTbBPTZD5PO4EDEgyS+VzqmVv1YM8vQCpBjhlHis
 ZbGfsr8mKk/nhfGB5kNNex29dTnlZfeiZ3RqXD2NV/P9FOcBQoeG/VHQGX8gRsI5MdU=
X-Gm-Gg: AfdE7cnjWIEaczdWrYttQjmh2YoiKVyD9LQonYoQFjw7DcZ1Fq6Wq25CjVA3w4SRewH
 QWYwuMtUPly2vl/Qty2+f3DEOS2K3RoGFZZxLFm8/O0pFdkJ2QBLY9pqCc46+8O2dLBlW3YRoFk
 7Cw/QpagibJoreL8t48gqIoX2ehJSD81R0d37tj5gdkmbKg2OrNwNVrwNcC090uubBa0X0lctic
 02mvuxgDKWSKbd8W8Fl0Pf1eVNR9ZkBOvsb1FjXuWtbvvRpgPJQs/EtbKr8MYDCa/Rn3qKHNh8J
 LeVXuU9Z8zAChduna9uw5WFmQ7F82MA/qNjLtyJ3QCFAIaXIxff/u5biF4fRhPl5K7nRbRk6LrC
 GCNGyj4P5BQ6NBy6skAOQmoFVKQcScVRyzP+rA1X8hzSbKSg1CaYrdniuU2WBAwOw7YIaSzsCBM
 ratB4lh1ezq2a2gHPGbFhizQiJcuEq38n8CXUTXwF4u4NLsLkA0k3aVwPM1DV/qZ1YbRg7wgy0f
 cBwTQBQKeHTZYnziyD+rrqR0B5Q2zezwt3GQzKWm6rVouhi9mS7kU9p6b2Cag4St0N39bhBR3yi
 mUFwQb+4MAe6lw==
X-Received: by 2002:a05:6214:420f:b0:8cc:6c12:eaa1 with SMTP id
 6a1803df08f44-8e3b6b272ecmr3945716d6.12.1782147753304; 
 Mon, 22 Jun 2026 10:02:33 -0700 (PDT)
Received: from d122166.iol.unh.edu ([2606:4100:3880:1220:ff12:f4a1:a541:db45])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8df81cde319sm100840426d6.31.2026.06.22.10.02.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 10:02:32 -0700 (PDT)
From: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
To: luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: dev@dpdk.org, abailey@iol.unh.edu, ahassick@iol.unh.edu,
 lylavoie@iol.unh.edu, Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Subject: [PATCH v3 1/2] dts: add code coverage reporting to DTS
Date: Mon, 22 Jun 2026 13:02:22 -0400
Message-ID: <20260622170223.1152746-1-knimoji@iol.unh.edu>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522154637.952588-1-knimoji@iol.unh.edu>
References: <20260522154637.952588-1-knimoji@iol.unh.edu>
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

Previously, DTS had no code coverage. This patch adds a command line
argument in order to build DPDK with code coverage enabled. This allows
users to create and view code coverage reports of what code and functions
were called during a DTS run.

Signed-off-by: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
---
v2:
    *Fixed error in lcov/gcov tool detection
v3:
    *Fixed type hints and error message typos    
---
 .mailmap                                      |  1 +
 doc/guides/tools/dts.rst                      | 15 +++++++++++++
 dts/README.md                                 |  5 +++++
 dts/framework/remote_session/dpdk.py          | 19 ++++++++++++++++
 .../remote_session/remote_session.py          |  5 ++++-
 dts/framework/settings.py                     | 10 +++++++++
 dts/framework/testbed_model/os_session.py     | 10 +++++++++
 dts/framework/testbed_model/posix_session.py  | 22 +++++++++++++++++++
 dts/framework/utils.py                        |  8 +++++++
 9 files changed, 94 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index e052b85213..a1209150ad 100644
--- a/.mailmap
+++ b/.mailmap
@@ -877,6 +877,7 @@ Klaus Degner <kd@allegro-packets.com>
 Kommula Shiva Shankar <kshankar@marvell.com>
 Konstantin Ananyev <konstantin.ananyev@huawei.com> <konstantin.v.ananyev@yandex.ru>
 Konstantin Ananyev <konstantin.ananyev@huawei.com> <konstantin.ananyev@intel.com>
+Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
 Krishna Murthy <krishna.j.murthy@intel.com>
 Krzysztof Galazka <krzysztof.galazka@intel.com>
 Krzysztof Kanas <kkanas@marvell.com> <krzysztof.kanas@caviumnetworks.com>
diff --git a/doc/guides/tools/dts.rst b/doc/guides/tools/dts.rst
index 5b9a348016..a838a317ee 100644
--- a/doc/guides/tools/dts.rst
+++ b/doc/guides/tools/dts.rst
@@ -352,6 +352,10 @@ DTS is run with ``main.py`` located in the ``dts`` directory using the ``poetry
      --precompiled-build-dir DIR_NAME
                            [DTS_PRECOMPILED_BUILD_DIR] Define the subdirectory under the DPDK tree root directory or tarball where the pre-
                            compiled binaries are located. (default: None)
+     --code-coverage       Builds DPDK on the SUT node with code coverage enabled. Generates a code coverage report which can be found on
+                           the local filesystem at dts/output/coverage_reports/meson-logs/coveragereport/index.html, or the specified output
+                           directory. To use code coverage, please ensure lcov v1.15 and gcov v8.0 or higher (included in gcc package) are
+                           installed on the SUT node.
 
 
 The brackets contain the names of environment variables that set the same thing.
@@ -367,6 +371,17 @@ Results are stored in the output dir by default
 which be changed with the ``--output-dir`` command line argument.
 The results contain basic statistics of passed/failed test cases and DPDK version.
 
+Code Coverage
+~~~~~~~~~~~~~
+
+DTS has the ablilty to track code usage during test runs, and generate an HTML
+coverage report with that data. This can be done by using the "--code-coverage"
+CLI parameter when running DTS.
+
+To use code coverage, please make sure the following dependencies are available
+on the SUT node:
+- lcov v1.15
+- gcov v8.0 or greater (included in gcc package)
 
 Contributing to DTS
 -------------------
diff --git a/dts/README.md b/dts/README.md
index d257b7a167..51f824e077 100644
--- a/dts/README.md
+++ b/dts/README.md
@@ -64,6 +64,11 @@ $ poetry run ./main.py
 These commands will give you a bash shell inside a docker container
 with all DTS Python dependencies installed.
 
+# Code Coverage
+
+To generate code coverage reports, ensure the SUT has lcov v1.15 and gcov v8.0 or greater
+installed, and that DTS is run using the '--code-coverage' argument.
+
 ## Visual Studio Code
 
 Usage of VScode devcontainers is NOT required for developing on DTS and running DTS,
diff --git a/dts/framework/remote_session/dpdk.py b/dts/framework/remote_session/dpdk.py
index c3575cfcaf..865f97f6ca 100644
--- a/dts/framework/remote_session/dpdk.py
+++ b/dts/framework/remote_session/dpdk.py
@@ -29,6 +29,7 @@
 from framework.logger import DTSLogger, get_dts_logger
 from framework.params.eal import EalParams
 from framework.remote_session.remote_session import CommandResult
+from framework.settings import SETTINGS
 from framework.testbed_model.cpu import LogicalCore, LogicalCoreCount, LogicalCoreList, lcore_filter
 from framework.testbed_model.node import Node
 from framework.testbed_model.os_session import OSSession
@@ -107,7 +108,22 @@ def teardown(self) -> None:
         """Teardown the DPDK build on the target node.
 
         Removes the DPDK tree and/or build directory/tarball depending on the configuration.
+        If code coverage is enabled, the coverage report and .info file are generated and
+        copied onto the local filesystem before teardown.
         """
+        if SETTINGS.code_coverage:
+            report_folder = PurePath(self.remote_dpdk_build_dir / "meson-logs")
+            output_dir = SETTINGS.output_dir
+            Path(output_dir).mkdir(parents=True, exist_ok=True)
+
+            coverage_status = self._session.generate_coverage_report(self.remote_dpdk_build_dir)
+            if coverage_status:
+                self._session.copy_dir_from(report_folder, output_dir)
+                self._logger.info(
+                    "Coverage HTML report generated, "
+                    f"available at {output_dir}/meson-logs/coveragereports/index.html"
+                )
+
         match self.config.dpdk_location:
             case LocalDPDKTreeLocation():
                 self._node.main_session.remove_remote_dir(self.remote_dpdk_tree_path)
@@ -272,6 +288,9 @@ def _build_dpdk(self) -> None:
         else:
             meson_args = MesonArgs(default_library="static", libdir="lib")
 
+        if SETTINGS.code_coverage:
+            meson_args._add_arg("-Db_coverage=true")
+
         self._session.build_dpdk(
             self._env_vars,
             meson_args,
diff --git a/dts/framework/remote_session/remote_session.py b/dts/framework/remote_session/remote_session.py
index 158325bb7f..d2440dc2d8 100644
--- a/dts/framework/remote_session/remote_session.py
+++ b/dts/framework/remote_session/remote_session.py
@@ -252,7 +252,10 @@ def copy_from(self, source_file: str | PurePath, destination_dir: str | Path) ->
             destination_dir: The directory path on the local filesystem where the `source_file`
                 will be saved.
         """
-        self.session.get(str(source_file), str(destination_dir))
+        source_file = PurePath(source_file)
+        destination_dir = Path(destination_dir)
+        local_path = destination_dir / source_file.name
+        self.session.get(str(source_file), str(local_path))
 
     def copy_to(self, source_file: str | Path, destination_dir: str | PurePath) -> None:
         """Copy a file from local filesystem to the remote Node.
diff --git a/dts/framework/settings.py b/dts/framework/settings.py
index b08373b7ea..7df535bd84 100644
--- a/dts/framework/settings.py
+++ b/dts/framework/settings.py
@@ -159,6 +159,8 @@ class Settings:
     re_run: int = 0
     #:
     random_seed: int | None = None
+    #:
+    code_coverage: bool = False
 
 
 SETTINGS: Settings = Settings()
@@ -489,6 +491,14 @@ def _get_parser() -> _DTSArgumentParser:
     )
     _add_env_var_to_action(action)
 
+    action = parser.add_argument(
+        "--code-coverage",
+        action="store_true",
+        default=False,
+        help="Used to build DPDK with code coverage enabled.",
+    )
+    _add_env_var_to_action(action)
+
     return parser
 
 
diff --git a/dts/framework/testbed_model/os_session.py b/dts/framework/testbed_model/os_session.py
index 2c267afed1..742b074948 100644
--- a/dts/framework/testbed_model/os_session.py
+++ b/dts/framework/testbed_model/os_session.py
@@ -480,6 +480,16 @@ def build_dpdk(
             timeout: Wait at most this long in seconds for the build execution to complete.
         """
 
+    @abstractmethod
+    def generate_coverage_report(self, remote_build_dir: PurePath | None) -> bool:
+        """Generates a code coverage report for a DTS run.
+
+        Args:
+            remote_build_dir: The remote DPDK build directory
+        Returns:
+            Whether the coverage report was able to be created or not.
+        """
+
     @abstractmethod
     def get_dpdk_version(self, version_path: str | PurePath) -> str:
         """Inspect the DPDK version on the remote node.
diff --git a/dts/framework/testbed_model/posix_session.py b/dts/framework/testbed_model/posix_session.py
index dec952685a..d18ce27de2 100644
--- a/dts/framework/testbed_model/posix_session.py
+++ b/dts/framework/testbed_model/posix_session.py
@@ -295,6 +295,28 @@ def build_dpdk(
         except RemoteCommandExecutionError as e:
             raise DPDKBuildError(f"DPDK build failed when doing '{e.command}'.")
 
+    def generate_coverage_report(self, remote_build_dir: PurePath | None) -> bool:
+        """Overrides :meth:`~.os_session.OSSession.generate_coverage_report`."""
+        command_result = self.send_command(r"lcov --version | grep -oP '\d+\.\d+'")
+        lcov_version = float(
+            command_result.stdout if command_result.return_code == 0 and command_result else -1
+        )
+        command_result = self.send_command(
+            r"gcov --version | head -n 1 | grep -oP '\d+\.\d+' | tail -n 1"
+        )
+        gcov_version = float(
+            command_result.stdout if command_result.return_code == 0 and command_result else -1
+        )
+
+        if lcov_version >= 1.15 and gcov_version >= 8.0:
+            self.send_command(f"ninja -C {remote_build_dir} coverage-html", timeout=600)
+            return True
+        else:
+            self._logger.info(
+                "Unable to generate code coverage report, ensure lcov v1.15 and at least gcov v8.0"
+            )
+            return False
+
     def get_dpdk_version(self, build_dir: str | PurePath) -> str:
         """Overrides :meth:`~.os_session.OSSession.get_dpdk_version`."""
         out = self.send_command(f"cat {self.join_remote_path(build_dir, 'VERSION')}", verify=True)
diff --git a/dts/framework/utils.py b/dts/framework/utils.py
index 9917ffbfaa..38da88cd9c 100644
--- a/dts/framework/utils.py
+++ b/dts/framework/utils.py
@@ -125,6 +125,14 @@ def __str__(self) -> str:
         """The actual args."""
         return " ".join(f"{self._default_library} {self._dpdk_args}".split())
 
+    def _add_arg(self, arg: str):
+        """Used to add a meson build argument to the DPDK build.
+
+        Args:
+            arg: The meson build argument to be added.
+        """
+        self._dpdk_args = self._dpdk_args + " " + arg
+
 
 class TarCompressionFormat(StrEnum):
     """Compression formats that tar can use.
-- 
2.54.0

