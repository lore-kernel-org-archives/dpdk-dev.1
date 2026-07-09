Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D47C43458
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Jul 2026 17:28:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A44C9402CC;
	Thu,  9 Jul 2026 19:28:28 +0200 (CEST)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com
 [209.85.219.41]) by mails.dpdk.org (Postfix) with ESMTP id 5173740268
 for <dev@dpdk.org>; Thu,  9 Jul 2026 19:28:27 +0200 (CEST)
Received: by mail-qv1-f41.google.com with SMTP id
 6a1803df08f44-8ef1dc934d1so1323126d6.0
 for <dev@dpdk.org>; Thu, 09 Jul 2026 10:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1783618106; x=1784222906; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wN9XCDSB0C/XUUy221XIoqYtgh10ewSBgoxvbP3nm8E=;
 b=BJ82hv+/Tn4aExd468KZVmQVXAlml6wpp96cnMP+fAqodXTvWctcanIfLZP8EwGyPR
 U+eDk1qYZ5czyGn8GUXL27vSB72FSrF3qJxuIGyiNDjaYmCBASCGCdu32qjrmW9RBCdr
 3rh3p8bjBRWJSyxmbsMNeQDBlux4GPx6JOC9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783618106; x=1784222906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wN9XCDSB0C/XUUy221XIoqYtgh10ewSBgoxvbP3nm8E=;
 b=RNAHq1FUN19mXqbdgNbjpYaTJEMCbtj2GR+itj47QPvsZtQR/pzLCPBFQaIBwJqsfY
 ZC+UyvasTz1A0+G+2xWY78ZsvvwTS+lT+TKCOyNDy2V2i3LeTzV9U+tOuYq/M1MjigKz
 pc7thMxHGKLegAzhdhDnBhQMaOJq0EVNkVkD3GtG3nROVCha1Eg0RphUlO1LfJwHdd5C
 O0M6592aIqzYaAHeRPXCv1/ObOBh8qULMq/7Io/ssXDH/IvkgIra6QRA7Wz4LWU9tU4L
 P5QGUI/CcHrUYU8lVB6o0Q3UWvdsgpnL8sYBxpCjM03KFvJ6JnYQS1ttYKQ/h4d/rA7u
 R59g==
X-Gm-Message-State: AOJu0YykkT3sTvU3ooeTu93kbEfkRQzBVfjFrDLrwv3IvFQh/ZHP7MCm
 WQmVyPXa+owgyZc2hrF0QnqWrxatqdTFC2ZOtiGZFaJBSqhACTmdnSl1OOMujDnPC7U=
X-Gm-Gg: AfdE7cnoBv5puhWvMkgMFSG7EZCJ9M4glPWY7iocb6Bat10KuEAuCcQm8TOnodvhy0D
 6WUZV1C210vBgwgoXxIzW3WJo2M5krPGLEn4TtzfgO0PDu13AB5ymUlzDfVlOTwdNbqOB26YMVn
 rN7BWQmjFFIURH0URLhZ7n074iYRTQXSRl1Ve59DPUb9r/TxgIehK2EqZcKYqP5XGxD0kTkSFqc
 zWhEfgvYCk62lgl3luz6kJFPmhoOltNKxAmP+QBpV1kOpO7Y2KdZq/nbxOngNytVUx/EXU8HQF4
 3OuwVeWYh+dPbGuKIpzqZiS5YZe/qhjTdWDSxZ//u7Rc/g4fXlvhz6mjhw7zG+RO3ex6a8bYJjy
 mziKDvt6m20Kv8cbHMC+XpB9oVdOyrs+CtVFncYuW/D7KXvfCcVrkeQ2Jp5lI7TExTHpLBFEHls
 Suyt+90ICzrnzpoSN3REtTehmI3hndfqR2b6TYi9Ji9VvHK9W6irD6BbmJ+RxwJJMo+uVgBvSfR
 zYPRG+yyIyWDzodWQr1voesvX80Q8y4X8hJJsfzpJ+2C/HNkBHh0MHbIJT++B6ClbzBPoaSydco
 pzdr0KVPCbYAZOFWoL+dQEw=
X-Received: by 2002:a05:6214:4344:b0:8fd:6e22:6631 with SMTP id
 6a1803df08f44-9025b086e36mr836576d6.29.1783618106491; 
 Thu, 09 Jul 2026 10:28:26 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:af2f:903c:2ca9:975f])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ffd56bdcdbsm22103326d6.11.2026.07.09.10.28.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 10:28:26 -0700 (PDT)
From: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
To: luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: dev@dpdk.org, abailey@iol.unh.edu, ahassick@iol.unh.edu,
 lylavoie@iol.unh.edu, Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Subject: [PATCH v5 1/2] dts: add code coverage reporting to DTS
Date: Thu,  9 Jul 2026 13:28:22 -0400
Message-ID: <20260709172823.972163-1-knimoji@iol.unh.edu>
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
v4:
    *Fixed documentation and docstring comments
    *Added a check to make sure code coverage is
     not enabled on a DTS run with a precompiled
     build directory
v5:
    *Fixed issue where teardown fails when code
     coverage report generation fails
---
 .mailmap                                      |  1 +
 doc/guides/tools/dts.rst                      | 18 +++++++++++
 dts/README.md                                 |  5 +++
 dts/framework/remote_session/dpdk.py          | 31 +++++++++++++++++++
 .../remote_session/remote_session.py          |  5 ++-
 dts/framework/settings.py                     | 10 ++++++
 dts/framework/testbed_model/os_session.py     | 10 ++++++
 dts/framework/testbed_model/posix_session.py  | 22 +++++++++++++
 dts/framework/utils.py                        |  8 +++++
 9 files changed, 109 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 05a55c0bd6..ed1553c6c3 100644
--- a/.mailmap
+++ b/.mailmap
@@ -887,6 +887,7 @@ Klaus Degner <kd@allegro-packets.com>
 Kommula Shiva Shankar <kshankar@marvell.com>
 Konstantin Ananyev <konstantin.ananyev@huawei.com> <konstantin.v.ananyev@yandex.ru>
 Konstantin Ananyev <konstantin.ananyev@huawei.com> <konstantin.ananyev@intel.com>
+Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
 Krishna Murthy <krishna.j.murthy@intel.com>
 Krzysztof Galazka <krzysztof.galazka@intel.com>
 Krzysztof Kanas <kkanas@marvell.com> <krzysztof.kanas@caviumnetworks.com>
diff --git a/doc/guides/tools/dts.rst b/doc/guides/tools/dts.rst
index 5b9a348016..0ffebdc713 100644
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
diff --git a/dts/framework/remote_session/dpdk.py b/dts/framework/remote_session/dpdk.py
index c3575cfcaf..31610f14c4 100644
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
@@ -80,6 +81,10 @@ def setup(self) -> None:
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
@@ -98,6 +103,10 @@ def setup(self) -> None:
 
         match self.config:
             case DPDKPrecompiledBuildConfiguration(precompiled_build_dir=build_dir):
+                if SETTINGS.code_coverage:
+                    raise ConfigurationError(
+                        "Cannot create code coverage report using a precompiled build directory."
+                    )
                 self._set_remote_dpdk_build_dir(build_dir)
             case DPDKUncompiledBuildConfiguration(build_options=build_options):
                 self._configure_dpdk_build(build_options)
@@ -107,7 +116,26 @@ def teardown(self) -> None:
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
+
+        except Exception as e:
+            self._logger.info(f"Unable to create code coverage report due to an error: {e}")
+
         match self.config.dpdk_location:
             case LocalDPDKTreeLocation():
                 self._node.main_session.remove_remote_dir(self.remote_dpdk_tree_path)
@@ -272,6 +300,9 @@ def _build_dpdk(self) -> None:
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
index f2dc9b20a9..c2874051a7 100644
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
index dec952685a..0a281f658c 100644
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
+                "Unable to generate code coverage report, ensure at least lcov v1.15 and gcov v8.0"
+            )
+            return False
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
2.54.0

