Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EAB8C55822
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Aug 2026 15:48:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7676B40A70;
	Tue,  4 Aug 2026 17:47:17 +0200 (CEST)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com
 [209.85.160.178])
 by mails.dpdk.org (Postfix) with ESMTP id E9B6A40A70
 for <dev@dpdk.org>; Tue,  4 Aug 2026 17:47:16 +0200 (CEST)
Received: by mail-qt1-f178.google.com with SMTP id
 d75a77b69052e-51a868b6962so46908661cf.2
 for <dev@dpdk.org>; Tue, 04 Aug 2026 08:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1785858436; x=1786463236; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aMcc8cGCUB91iTI5oxcabXeQhXx1P5J3mtPu9l1nhK4=;
 b=UdInWG1Yb+tKhup3dTlgknjC+SgsSMYdtjRot4Z6qTwY2VseNxtF8MY7kodvDlYVN9
 /DOVminI9KsE1gHqXqg7Zz5WoMz9BSfz0/+X/LGjJcLQ07BIMgNvF4CNjcwPr2VeFRDw
 nCwlP/68CY6XWdRrjA1OFPnJQk2fWBMPlHUos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785858436; x=1786463236;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aMcc8cGCUB91iTI5oxcabXeQhXx1P5J3mtPu9l1nhK4=;
 b=Dg4JidoqJdvbJ8ZiBUv3oNR8/6PbM6wrzsVWsMVLpC9liuzWNGZPiE/qwz75AYtwUQ
 l/wkooEt8h3XqXri8NdepuLFpRT9qZdeo8QHoU02jIrUvwNIDaOqn45CdgiTP32DxT0o
 eooQdgxheH+ET3ElY19OsAul86riH2ArkV8LPmGpPhaR3p4rO5o676MPb0Al1qNUmXre
 5NMtBvZHsSCYETjdzCEJ85iIcZuC+bTOzib6ibAyC55sVa5wrjpwXg/9WVqiZbFrSD7P
 FHAmWuyCptEwYsXKFEaCl/YczUix0xqNgeICBC5zZColrsejEg43nnQDIKRKZqieRJtL
 5gfA==
X-Gm-Message-State: AOJu0YznWmAN7CeM4neOZbcD0zi0LCNi+wIshkFP06NOpmNtco0nUIEA
 S4v5MCYu17uf4gHd9GBrZZaF/Rt/IwNAR2zaySlONmAfr+V4VU1fC72zOz8kR2Sb0nj+B9JeiZe
 iDMMr
X-Gm-Gg: AR+sD12zLCuogSbMxSxLTjbfiN1qmmZ/3lCiBOgg/hoQ8cp8AUaKVrk/p75nXyzUKLf
 Rn/bYzf0H/KT1JAEI4s38KK/EQQlmnzFoFV4dFpqJqiQJYt9eFLEr5AbGyVuQb3BaRnDLx+QSWK
 Mq5AT+sN0UtZItK+cREVHt9CgZBYQyPrat3ZQFdNP+LTxoC5IlNOuVYWH3Yx2wFhgy7fF8hVa/t
 HizbqUgCp/8zVBLIch7SG71fHn3k9gPICZLUtVh8MQkXokaY7Q4KCD8G+Zwvtl5F1XqnU6Mix+V
 KtW1mfnlm8GkiaeTwn/u958a6GMG37Uidu+mKesaRzWzQM85E/NMUsPheXsWUrrvgDPE0APEAot
 0Qn3EHOlNll9IxOGL2T7eqdw8fuBWSU90J56RB5vrj74K5HWgFf2si1dm89kIFmhSpyu/T/Gqka
 HsZ5tybksozMJ63l9UEpe20Z19kVAIkL0FLa0bv5brHqEi4AbvQuXiKZlpqP9QNKCodJmyKwVHx
 FErzN5eM0aVV5lx6gv363aOEgR2NDnnEsjARzgQB1eHF0hl4HpX5PtMLjQwkvG/E/tzG+7ln+U1
 PNU+mSqgCB3tojRElv0oXBYZPmEFrQivEjZkPGmFytoJ/l7qaV2J7zJ1m/hANvtffb8UWtYL
X-Received: by 2002:a05:622a:5595:b0:51c:103:fb56 with SMTP id
 d75a77b69052e-52b566abe2dmr318289131cf.15.1785858436026; 
 Tue, 04 Aug 2026 08:47:16 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:af2f:903c:2ca9:975f])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52ce4fc0200sm2120561cf.0.2026.08.04.08.47.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 08:47:15 -0700 (PDT)
From: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
To: luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: dev@dpdk.org, abailey@iol.unh.edu, lylavoie@iol.unh.edu,
 Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Subject: [PATCH v7 1/2] dts: add code coverage reporting to DTS
Date: Tue,  4 Aug 2026 11:47:11 -0400
Message-ID: <20260804154712.436889-1-knimoji@iol.unh.edu>
X-Mailer: git-send-email 2.55.0
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
v4:
    *Fixed documentation and docstring comments
    *Added a check to make sure code coverage is
     not enabled on a DTS run with a precompiled
     build directory
v5:
    *Fixed issue where teardown fails when code
     coverage report generation fails
v6:
    *Fixed error reporting when coverage report fails to generate
     and resolved error where coverage report wouldnt generate due
     to insuffucuent priviledges
v7:
    *Added a one second sleep to testpmd's close method when code coverage
     is enabled to allow testpmd to create the required files for code 
     coverage
---
 doc/guides/tools/dts.rst                      | 18 ++++++++++
 dts/README.md                                 |  5 +++
 dts/api/testpmd/__init__.py                   |  2 ++
 dts/framework/remote_session/dpdk.py          | 36 +++++++++++++++++++
 .../remote_session/remote_session.py          |  5 ++-
 dts/framework/settings.py                     | 10 ++++++
 dts/framework/testbed_model/os_session.py     | 10 ++++++
 dts/framework/testbed_model/posix_session.py  | 24 +++++++++++++
 dts/framework/utils.py                        |  8 +++++
 9 files changed, 117 insertions(+), 1 deletion(-)

diff --git a/doc/guides/tools/dts.rst b/doc/guides/tools/dts.rst
index 9cdd1ccd77..9bb791d4a6 100644
--- a/doc/guides/tools/dts.rst
+++ b/doc/guides/tools/dts.rst
@@ -352,6 +352,10 @@ DTS is run with ``main.py`` located in the ``dts`` directory using the ``poetry
      --precompiled-build-dir DIR_NAME
                            [DTS_PRECOMPILED_BUILD_DIR] Define the subdirectory under the DPDK tree root directory or tarball where the pre-
                            compiled binaries are located. (default: None)
+     --code-coverage       Builds DPDK on the SUT node with code coverage enabled. Generates a code coverage report which can be found on
+                           the DTS execution hosts local filesystem at dts/output/coverage_reports/meson-logs/coveragereport/index.html,
+                           or the specified output directory. To use code coverage, please ensure lcov v1.15 and gcov v8.0 or higher
+                           (included in gcc package) are installed on the SUT node.
 
 
 The brackets contain the names of environment variables that set the same thing.
@@ -367,6 +371,20 @@ Results are stored in the output dir by default
 which be changed with the ``--output-dir`` command line argument.
 The results contain basic statistics of passed/failed test cases and DPDK version.
 
+Code Coverage
+~~~~~~~~~~~~~
+
+DTS has the ablilty to track code usage during test runs, and generate an HTML
+coverage report which shows the coverage percentage for the various DPDK
+libraries and drivers utilized during execution. The DPDK build directory must
+be compiled on the SUT node, as a pre-built build directory may not be properly
+configured for code coverage. Code coverage can be enabled by using the
+"--code-coverage" CLI parameter when running DTS.
+
+To use code coverage, please make sure the following dependencies are available
+on the SUT node:
+- lcov v1.15 or greater
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
diff --git a/dts/api/testpmd/__init__.py b/dts/api/testpmd/__init__.py
index b41a21300e..bd41730e37 100644
--- a/dts/api/testpmd/__init__.py
+++ b/dts/api/testpmd/__init__.py
@@ -1183,6 +1183,8 @@ def close(self) -> None:
         """Overrides :meth:`~.dpdk_shell.close`."""
         self.stop()
         self.send_command("quit", "Bye...")
+        if SETTINGS.code_coverage:
+            time.sleep(1)
         return super().close()
 
     """
diff --git a/dts/framework/remote_session/dpdk.py b/dts/framework/remote_session/dpdk.py
index e43e1f2123..683bc3470e 100644
--- a/dts/framework/remote_session/dpdk.py
+++ b/dts/framework/remote_session/dpdk.py
@@ -30,6 +30,7 @@
 from framework.logger import DTSLogger, get_dts_logger
 from framework.params.eal import EalParams
 from framework.remote_session.remote_session import CommandResult
+from framework.settings import SETTINGS
 from framework.testbed_model.cpu import LogicalCore, LogicalCoreCount, LogicalCoreList, lcore_filter
 from framework.testbed_model.node import Node
 from framework.testbed_model.os_session import OSSession
@@ -81,6 +82,10 @@ def setup(self) -> None:
         DPDK setup includes setting all internals needed for the build, the copying of DPDK
         sources and then building DPDK or using the exist ones from the `dpdk_location`. The drivers
         are bound to those that DPDK needs.
+
+        Raises:
+            ConfigurationError: When DTS is run with code coverage enabled, but is also provided
+            a precompiled build directory.
         """
         if not isinstance(self.config.dpdk_location, RemoteDPDKTreeLocation):
             self._node.main_session.create_directory(self.remote_dpdk_tree_path)
@@ -99,6 +104,10 @@ def setup(self) -> None:
 
         match self.config:
             case DPDKPrecompiledBuildConfiguration(precompiled_build_dir=build_dir):
+                if SETTINGS.code_coverage:
+                    raise ConfigurationError(
+                        "Cannot create code coverage report using a precompiled build directory."
+                    )
                 self._set_remote_dpdk_build_dir(build_dir)
             case DPDKUncompiledBuildConfiguration(build_options=build_options):
                 self._configure_dpdk_build(build_options)
@@ -108,7 +117,31 @@ def teardown(self) -> None:
         """Teardown the DPDK build on the target node.
 
         Removes the DPDK tree and/or build directory/tarball depending on the configuration.
+        If code coverage is enabled, the coverage report and .info file are generated and
+        copied onto the local filesystem before teardown.
         """
+        try:
+            if SETTINGS.code_coverage:
+                report_folder = PurePath(self.remote_dpdk_build_dir / "meson-logs")
+                output_dir = SETTINGS.output_dir
+                Path(output_dir).mkdir(parents=True, exist_ok=True)
+
+                coverage_status = self._session.generate_coverage_report(self.remote_dpdk_build_dir)
+                if coverage_status:
+                    self._session.copy_dir_from(report_folder, output_dir)
+                    self._logger.info(
+                        "Coverage HTML report generated, "
+                        f"available at {output_dir}/meson-logs/coveragereport/index.html"
+                    )
+                    self._session.send_command(
+                        f"rm -r {self.remote_dpdk_build_dir}/meson-logs/", privileged=True
+                    )
+                else:
+                    self._logger.info("Failed to generate code coverage report")
+
+        except Exception as e:
+            self._logger.info(f"Unable to create code coverage report due to an error: {e}")
+
         match self.config.dpdk_location:
             case LocalDPDKTreeLocation():
                 self._node.main_session.remove_remote_dir(self.remote_dpdk_tree_path)
@@ -274,6 +307,9 @@ def _build_dpdk(self) -> None:
         else:
             meson_args = MesonArgs(default_library="static", libdir="lib")
 
+        if SETTINGS.code_coverage:
+            meson_args._add_arg("-Db_coverage=true")
+
         self._session.build_dpdk(
             self._env_vars,
             meson_args,
diff --git a/dts/framework/remote_session/remote_session.py b/dts/framework/remote_session/remote_session.py
index fb5f6fedf5..cc1f1f6a4f 100644
--- a/dts/framework/remote_session/remote_session.py
+++ b/dts/framework/remote_session/remote_session.py
@@ -250,7 +250,10 @@ def copy_from(self, source_file: str | PurePath, destination_dir: str | Path) ->
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
index f329677804..6e2fc78b78 100644
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
index f88427a53d..4551c7fffe 100644
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
index dec952685a..e7b3e78333 100644
--- a/dts/framework/testbed_model/posix_session.py
+++ b/dts/framework/testbed_model/posix_session.py
@@ -295,6 +295,30 @@ def build_dpdk(
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
+        if lcov_version < 1.15 or gcov_version < 8.0:
+            self._logger.info(
+                "lcov/gcov version mismatch, please ensure at least lcov v1.15 and gcov v8.0"
+            )
+            return False
+
+        coverage_command = self.send_command(
+            f"ninja -C {remote_build_dir} coverage-html", timeout=600, privileged=True
+        )
+        return coverage_command.return_code == 0
+
     def get_dpdk_version(self, build_dir: str | PurePath) -> str:
         """Overrides :meth:`~.os_session.OSSession.get_dpdk_version`."""
         out = self.send_command(f"cat {self.join_remote_path(build_dir, 'VERSION')}", verify=True)
diff --git a/dts/framework/utils.py b/dts/framework/utils.py
index 5753c1b7fe..55d6dfc337 100644
--- a/dts/framework/utils.py
+++ b/dts/framework/utils.py
@@ -127,6 +127,14 @@ def __str__(self) -> str:
         """The actual args."""
         return " ".join(f"{self._default_library} {self._dpdk_args}".split())
 
+    def _add_arg(self, arg: str):
+        """Adds an argument to the meson setup command.
+
+        Args:
+            arg: The meson build argument to be added.
+        """
+        self._dpdk_args = self._dpdk_args + " " + arg
+
 
 class TarCompressionFormat(StrEnum):
     """Compression formats that tar can use.
-- 
2.55.0

