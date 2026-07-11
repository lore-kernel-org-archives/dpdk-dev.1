Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B2B6C43458
	for <dpdk-dev@archiver.kernel.org>; Sat, 11 Jul 2026 00:02:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ECCC14027F;
	Sat, 11 Jul 2026 02:02:31 +0200 (CEST)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com
 [209.85.219.47]) by mails.dpdk.org (Postfix) with ESMTP id ABBAE40270
 for <dev@dpdk.org>; Sat, 11 Jul 2026 02:02:30 +0200 (CEST)
Received: by mail-qv1-f47.google.com with SMTP id
 6a1803df08f44-8f256eaedf8so14804186d6.2
 for <dev@dpdk.org>; Fri, 10 Jul 2026 17:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1783728150; x=1784332950; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/HCzbVCMWg5IS7yDLeHtWllMxWxhEFlcnGR3todvzns=;
 b=Rrx5jbosG6asjDCzEdbt0wGXyDzj5xMR91pWghwvBZFeqeA4SEqLcgc76HbS/hTrxI
 BkrV5gCSWdD3gEeG4td7d8SI0I76YNZObWmcdUzNC0wNDGm+YdP07B1iUARkT1Tw+JL/
 zcjimjDf0uNGLPMMao8ALzJU/TpSwxEZKBOOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783728150; x=1784332950;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/HCzbVCMWg5IS7yDLeHtWllMxWxhEFlcnGR3todvzns=;
 b=tJ0gbxBLwXvkFh9zG603DDDgf1e5G7B1djH50lHmjsu4FN2JJvg0NR2x7imTLZcndc
 RPQG8FYNrJQc0lfhjbYi8BZpFmz0hfvxSHNCdbsMQk1Ter/IBK8ZT73Y/lwXVep8jUg2
 6KtbVfhaIGEAE9SwzjxdJzXy8RGv0U4Ev/2LnSGqh5zpPNbkGd3B78g7vWnJQvb28bwa
 MBvM57vzjTwZeo4WrMXPD6INkMzRKyDUJVWhy92gl+BPya6jBBANP2nyUDwKR1zjjQaM
 x+DCXqYf7zmstY/cQzBBK/NS75ZxsPA9fA5Zd/0rArb7F6mYBcLoNGi9RFgEGXDtwb/j
 pHwA==
X-Gm-Message-State: AOJu0YxNXSPaMqg1DZ7Ogne5Dyuf/rW3eOHKhxhaz/7awIEQrWxg8ihz
 8tdtfvQYk9EtmccdBPrCcaYaQhYWp2tcL/cyIefNapMx7xkz0odPJdumzPlssa2cwQo=
X-Gm-Gg: AfdE7clIAVDIS/Fniw9jsA2kHjWBlkfvEG0HlIwFxcAgFVvTRdpwWYeVazWyKyZyX/N
 LoO/wvIb3iAVHL62svnHkwEbF77E+QEgTi2J69dRydwXeeDFxhjZjlqFbW8+IwU9mjSEPgm/neF
 VixCK07jz3UnlxOcZYYSc2aj+/OXqdQjjm2dZzDapoRcBe5IqDn42W/stmQ2k9Oaptw2DkfSynT
 6F8d0oCaK8U1889124WcOdDI0MP0tXT2Wk9NioHel19fNKq9MqZrTpZwAKHSQR8key2qBevMM30
 68cCPcbUAvNHCLTjQpQSKX4tiZClwBhtv/x1+RJ50zKvWVeMe1EqDKaIbdsTvhQIpP0zxsX1MeG
 R9AcuO+lE8vaHrBniJv+rbY1Xz6XOYdQTPTLPPsUPLMfw2pIFlSMds4s7igtJhB7eJWy9AWN1VW
 oQr3CqVPdC/F09i1TjLTVw6RzTgQq4IJLBd40ZnTVVvOYGfPLeTDeyAt+8EPTzA76OHHyTWEjRA
 PzH2ISQuL0Ts+Pa/7P2rpGeNc2a7dQkST8b5HmQPA==
X-Received: by 2002:a05:6214:2522:b0:8e9:f5de:d612 with SMTP id
 6a1803df08f44-90402969e34mr16125506d6.49.1783728149781; 
 Fri, 10 Jul 2026 17:02:29 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1257::1006])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ffd50e081dsm53393706d6.9.2026.07.10.17.02.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 17:02:29 -0700 (PDT)
From: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
To: luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: dev@dpdk.org, abailey@iol.unh.edu, ahassick@iol.unh.edu,
 lylavoie@iol.unh.edu, Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Subject: [PATCH v6 1/2] dts: add code coverage reporting to DTS
Date: Fri, 10 Jul 2026 20:02:24 -0400
Message-ID: <20260711000225.1836433-1-knimoji@iol.unh.edu>
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
v6:
    *Fixed error reporting when coverage report fails to generate
     and resolved error where coverage report wouldnt generate due
     to insuffucuent priviledges     
---
 .mailmap                                      |  1 +
 doc/guides/tools/dts.rst                      | 18 ++++++++++
 dts/README.md                                 |  5 +++
 dts/framework/remote_session/dpdk.py          | 36 +++++++++++++++++++
 .../remote_session/remote_session.py          |  5 ++-
 dts/framework/settings.py                     | 10 ++++++
 dts/framework/testbed_model/os_session.py     | 10 ++++++
 dts/framework/testbed_model/posix_session.py  | 24 +++++++++++++
 dts/framework/utils.py                        |  8 +++++
 9 files changed, 116 insertions(+), 1 deletion(-)

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
2.54.0

