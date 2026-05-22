Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22553CD5BB0
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 May 2026 15:46:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 57A5B4065B;
	Fri, 22 May 2026 17:46:56 +0200 (CEST)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com
 [209.85.128.179])
 by mails.dpdk.org (Postfix) with ESMTP id D8AD540616
 for <dev@dpdk.org>; Fri, 22 May 2026 17:46:54 +0200 (CEST)
Received: by mail-yw1-f179.google.com with SMTP id
 00721157ae682-7bb0d18c7f9so68870447b3.0
 for <dev@dpdk.org>; Fri, 22 May 2026 08:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1779464814; x=1780069614; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jZL1PlSARiHKY848yAsurK16PGZgxzuKrsqfTMu7VNo=;
 b=bINn/+YOs/jN13itE90cy9dcEuXs80HyJPpGetDHrum5lPFO60kXGitGMs1Ixyr0Zu
 R4Wkk3huvZ912De+XR5UkUHGSGfOGDMwRmk4JnEK/nEwFaP2pDeRtDE+CrIfoCgSjSed
 GUWvMO7TDkyNnfU5cse0K3QQVehhZOwmlOeFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779464814; x=1780069614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jZL1PlSARiHKY848yAsurK16PGZgxzuKrsqfTMu7VNo=;
 b=lM15aiMoqpQPWYOzGOcCqJdLNVcye3L8dQiEFzUeQ89jvv1rLphmkTh3pg0wVlk8zj
 m/q/retO0sxyG2DaoS63rWnrAa/FKKKQt0JY3Qk0YQEHdEoWR4mz9C+nvbPKLeUIaqrY
 TeL8QhFHWFSasqT/d5atnVZFG7xV3/W/sjdLgHoXzZ3gHGmqp4wIlBS8ttNWbzdB9Mej
 vtbUx/hT4N1ijXTT4saGezUstFIK1Mz0SkoevGpaaVIsuKyY7lAyLiP0tLLd89YU+Mqd
 EyTDMBfFiaYD4UcrVv+J/oxPy/nNu484nD/7QPoEoCK54wnzCcaEa/qC/1sFZl4+dcW5
 j/Eg==
X-Gm-Message-State: AOJu0Yxhp7jFH1wYP5YcZBiBjtWm4IdnTQd38+msbprRCYENvoUpQ+a1
 5zhKyTXKI4vg7nqHpFD7vWiG1oneBcyqs/Sb2cONEXtFJb0tzb+sPSqXIFDNgblJC4Q=
X-Gm-Gg: Acq92OHD3jgVirfneYRUUWbSCsIOiKqHBYH9OP9edMCjp+vHCa8C7UeMrLX+NB6wRSP
 rSM9PSAjNt26cON0h3YR2Ut8iO0OWKACyspZcyDWUxE2UVQblgIzMN2VUErkL/2b/VcbX4YGBEi
 WS7iuWMAT+s6fbD12NmjsnZqBFd5I86FmREym75hwBpDIPOXntiIod1ICoykw6vDiu1wc421gpe
 bHwWGt0ykQW/Oy54J+g0/em4Qxd/o0VBRWywDJoz+fXVkDQrXESFUsobp5QKmN6rBBweBLhF8k9
 nY7Ye14bnrE5FF8gRT6Hck+dTpTp/nf3/BraDoSn8+wLoPKiwHv74cUh98ZowcNW1/rA+HbLLj+
 p1oaaPC+sRpkHTj+Xik5IGujxOO7dgeCi5nYQnTykCJgVt95A7Ypk9ZBtHPiwmoorC6DY6H2pbv
 xnSQMuBMy9+7UfYxlM97CDsrLgqwo7r+1TRbveTFv7fsa21DimHAQDvBYv0mctxgVmb/c3jgZe7
 Et6LcSezi1c2Jdhxw52chuCfegFUo3bAt8FUIBQHJ1cROa9HnFi8IFgsxToYxZ1vubn9hE7J9MC
 e/Nj+CqlzrbciqaLMS/aBo8t
X-Received: by 2002:a05:690c:6086:b0:7b3:f33:35e2 with SMTP id
 00721157ae682-7d337dafe01mr49918287b3.10.1779464813918; 
 Fri, 22 May 2026 08:46:53 -0700 (PDT)
Received: from d122166.iol.unh.edu ([2606:4100:3880:1220:ff12:f4a1:a541:db45])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-516d8cba4easm16299911cf.24.2026.05.22.08.46.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 08:46:53 -0700 (PDT)
From: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
To: luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: dev@dpdk.org, abailey@iol.unh.edu, ahassick@iol.unh.edu,
 lylavoie@iol.unh.edu, Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Subject: [PATCH v1 1/2] dts: add code coverage reporting to DTS
Date: Fri, 22 May 2026 11:46:36 -0400
Message-ID: <20260522154637.952588-1-knimoji@iol.unh.edu>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430192911.297180-1-knimoji@iol.unh.edu>
References: <20260430192911.297180-1-knimoji@iol.unh.edu>
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
 .mailmap                                      |  1 +
 doc/guides/tools/dts.rst                      | 15 +++++++++++++++
 dts/README.md                                 |  5 +++++
 dts/framework/remote_session/dpdk.py          | 19 +++++++++++++++++++
 .../remote_session/remote_session.py          |  5 ++++-
 dts/framework/settings.py                     | 10 ++++++++++
 dts/framework/testbed_model/os_session.py     |  8 ++++++++
 dts/framework/testbed_model/posix_session.py  | 17 +++++++++++++++++
 dts/framework/utils.py                        |  8 ++++++++
 9 files changed, 87 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index beccc84425..15ce27ef83 100644
--- a/.mailmap
+++ b/.mailmap
@@ -868,6 +868,7 @@ Klaus Degner <kd@allegro-packets.com>
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
index 2c267afed1..a48383d1f1 100644
--- a/dts/framework/testbed_model/os_session.py
+++ b/dts/framework/testbed_model/os_session.py
@@ -480,6 +480,14 @@ def build_dpdk(
             timeout: Wait at most this long in seconds for the build execution to complete.
         """
 
+    @abstractmethod
+    def generate_coverage_report(self, remote_build_dir: PurePath | None) -> int:
+        """Generates a code coverage report for a DTS run.
+
+        Args:
+            remote_build_dir: The remote DPDK build directory
+        """
+
     @abstractmethod
     def get_dpdk_version(self, version_path: str | PurePath) -> str:
         """Inspect the DPDK version on the remote node.
diff --git a/dts/framework/testbed_model/posix_session.py b/dts/framework/testbed_model/posix_session.py
index dec952685a..c021000a29 100644
--- a/dts/framework/testbed_model/posix_session.py
+++ b/dts/framework/testbed_model/posix_session.py
@@ -295,6 +295,23 @@ def build_dpdk(
         except RemoteCommandExecutionError as e:
             raise DPDKBuildError(f"DPDK build failed when doing '{e.command}'.")
 
+    def generate_coverage_report(self, remote_build_dir: PurePath | None):
+        """Overrides :meth:`~.os_session.OSSession.generate_coverage_report`."""
+        lcov_version = float(self.send_command(r"lcov --version | grep -oP '\d+\.\d+'").stdout)
+        gcov_version = float(
+            self.send_command(
+                r"gcov --version | head -n 1 | grep -oP '\d+\.\d+' | tail -n 1"
+            ).stdout
+        )
+        if lcov_version == 1.15 and gcov_version >= 8.0:
+            self.send_command(f"ninja -C {remote_build_dir} coverage-html", timeout=600)
+            return True
+        else:
+            self._logger.info(
+                "Unable to generate code coverage report, ensure lcov v1.5 and at least gcov v8.0"
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

