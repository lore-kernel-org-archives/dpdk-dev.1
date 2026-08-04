Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13AFCC55ABA
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Aug 2026 19:38:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DF24340608;
	Tue,  4 Aug 2026 21:38:51 +0200 (CEST)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com
 [209.85.160.178])
 by mails.dpdk.org (Postfix) with ESMTP id A209A40285
 for <dev@dpdk.org>; Tue,  4 Aug 2026 21:38:50 +0200 (CEST)
Received: by mail-qt1-f178.google.com with SMTP id
 d75a77b69052e-517dc520840so1012731cf.3
 for <dev@dpdk.org>; Tue, 04 Aug 2026 12:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1785872330; x=1786477130; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nRCU6jhLEWOh44+l24oymKSZNIay0ar8Fz7g5MxJPhY=;
 b=Nr0r2qF7DEstjRKwm6vOyEuKnEm5LG537JvljUiLEJ7OZXv20HnGXz1sAVwqbiYO39
 ZCeRsjPSnYzxbbVGI6zaJqawE6BX2+0PJ2P6GMKCaxxCNy82iTgC9md4sbEckarp+UUU
 kUt2x1LqNVkTJxyvpH70KlcJtBr/nQ2mvzfsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785872330; x=1786477130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nRCU6jhLEWOh44+l24oymKSZNIay0ar8Fz7g5MxJPhY=;
 b=ASptgyT1pqzflgiKXPx1EeUN28xOHOZNGimhlFs1Sf5kwJpoH2gKYCDvEMz1l4Nr2q
 UC/Q7HFnAgB6YF0WQ9rDCX2Yzkoi2+eqhSWN/gejtaOO5eAGFoHoRfruxn0OusQLJxi5
 uSfnYGSuO/G63YM2tGdT5GVIFvTQ6w3MWRxRgKCWS9p+9n7ANjPqSqEr5EjaApLnrCDy
 k9AjzHAxKm++mfP2RvmLzw9W9rplhBl+qOKyYVHMsYbhlg71UgkNBWaOm361BRTvVtx0
 J1AjqiMgUON+sFt5XQRFJ9RvebAmbJg2NQhiTyd6Tiub3/aasbDib7oQWfC3Dfm+yIc9
 KLGA==
X-Gm-Message-State: AOJu0YwZhDstt8Aywjt6sJIve0xLwDe/J+fh79f9VmOTsgYvbkRl/CIw
 xcvK2j869E92wB9QeUkoHJilk80xoFzIZ4e4tBVbY71l6FWM58j0mV6gtc3UJ2B+J5k=
X-Gm-Gg: AR+sD12caH3VpqeRpOAA0LvHXf37lPMz0bl2XRQONBlW3U2brQovsWHeo8MzT+zRHbt
 qS66QmOA0iBvJGr3WaqGiu7jOEWKI0OizfWTbmDOddpd0oNba5Xa8KXlXMLgPhJoyod5yHD6hnJ
 YEy7XvaLw259wQ38rkHIjGnL+HF7BB9UEom+74wPNVEoqPOHye69p+uT6M9jzRzEYHwA6K5bEda
 6QivWacGyiV4xiOdi31xUILwecaIwb65Jc5YrnFhgMIgTra3Xsj1CM0JKcIbyXjR07SlVTOMhLk
 PENsW9QD8u0FcB3oFVp5983UtmTZ3ArqMVwgWtpXPD+6yer4Nr2DukLHmr1Q9yg0wO108dY1bRF
 mkkIjiFdkp6/yc/wiAigp4ntZ9oRhuMwO6kn3PFnTzLNLt2A1mB96PwZ3ERP7As0uOZ8gQ45a0t
 jm2Zs/cLLL+yOczM4tR7lY4OLs5MBDQDwaXGg1UGsqw8wWpmplz1JQv3J85bY4ES036u713Sji9
 BIw6XrQlv7QCgNIV4IWtW1psiSpPT3av1wH75vu+0PqZ/71F1hQYJspRPcQSUNaOoxn01VK4PHA
 LVQdlsaTqc6YvsMVxAFj0UyMbLP9QetTYEWPsUgLsBFDuTKqflXY38EhF0V3CeUcneafTFA=
X-Received: by 2002:a05:622a:34c:b0:517:9570:c1bd with SMTP id
 d75a77b69052e-52ce612ecbbmr14683541cf.25.1785872329741; 
 Tue, 04 Aug 2026 12:38:49 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:af2f:903c:2ca9:975f])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-908800cabedsm8739746d6.46.2026.08.04.12.38.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 12:38:49 -0700 (PDT)
From: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
To: luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: dev@dpdk.org, abailey@iol.unh.edu, lylavoie@iol.unh.edu,
 Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Subject: [PATCH v8 1/2] dts: add code coverage reporting to DTS
Date: Tue,  4 Aug 2026 15:38:45 -0400
Message-ID: <20260804193846.556368-1-knimoji@iol.unh.edu>
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
v8:
    *Changed the one second sleep logic in testpmd's close method
     to properly wait for the testpmd process to die before continuing
---
 doc/guides/tools/dts.rst                      | 18 ++++++++++
 dts/README.md                                 |  5 +++
 dts/api/testpmd/__init__.py                   | 14 ++++++++
 dts/framework/remote_session/dpdk.py          | 36 +++++++++++++++++++
 .../remote_session/remote_session.py          |  5 ++-
 dts/framework/settings.py                     | 10 ++++++
 dts/framework/testbed_model/os_session.py     | 10 ++++++
 dts/framework/testbed_model/posix_session.py  | 24 +++++++++++++
 dts/framework/utils.py                        |  8 +++++
 9 files changed, 129 insertions(+), 1 deletion(-)

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
index b41a21300e..7118f9470f 100644
--- a/dts/api/testpmd/__init__.py
+++ b/dts/api/testpmd/__init__.py
@@ -1183,6 +1183,20 @@ def close(self) -> None:
         """Overrides :meth:`~.dpdk_shell.close`."""
         self.stop()
         self.send_command("quit", "Bye...")
+
+        # gives testpmd enough time to write .gcda files for code coverage before quitting
+        if SETTINGS.code_coverage:
+            timeout = 10
+            interval = 0.2
+            start_time = time.time()
+            while time.time() - start_time < timeout:
+                pgrep_result = self._node.main_session.send_command(
+                    "pgrep dpdk-testpmd", verify=False
+                )
+                if pgrep_result.return_code != 0 or not pgrep_result.stdout.strip():
+                    break
+                time.sleep(interval)
+
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

