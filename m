Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1459CD8CA4
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 14:36:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2199F4025E;
	Tue,  9 Jun 2026 16:36:57 +0200 (CEST)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com
 [209.85.222.181])
 by mails.dpdk.org (Postfix) with ESMTP id 7C1BB400D5
 for <dev@dpdk.org>; Tue,  9 Jun 2026 16:36:56 +0200 (CEST)
Received: by mail-qk1-f181.google.com with SMTP id
 af79cd13be357-9156ceb55ffso485116185a.0
 for <dev@dpdk.org>; Tue, 09 Jun 2026 07:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1781015816; x=1781620616; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nYsnz/wUZdGTVD5rTMhDHtqhuMg2G9scPwI4qEZ4OnE=;
 b=PYC5DjAocLrQNXisPb7hriT/bmbpq24AfdlqNSOy4YcBeJTfH+HHgOHgvYdvSwTZQa
 e5repTvPKh/NQ5KkVGxrVt7xZZykxRDXvhYBcRQL7nKD/G3m8X94ojIzb/rSpan9/mUF
 t4uSsMxwpcSYU56VVgVk0cvFujUwyLqIcUao8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781015816; x=1781620616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nYsnz/wUZdGTVD5rTMhDHtqhuMg2G9scPwI4qEZ4OnE=;
 b=dnt/K2kQVemwBOLog8WkkuhYLK2nlN6xFpU/OMYw8B0+oUErqYTkzrRZi0Y07VS9+D
 62IyMyVMRaTwi/jX1M2WVSjCI5ETgaVwGIFtFihGjTcuxEXSYTR42EfsyKHOVk+hbV9E
 mnHSvRSbK3zl6gZy1vxqtHZGwcOg7PIu2JgdVWgkwXs+YVtubgiGJKe3O2cx+q7KE0Lu
 K+wqgZNRzvmpRJRLpDbLXQKvlyuX+D5SoH8zsvg6gH3Gz+Ohj/0nWAe3bhuYa2Ud31ld
 Z39Ut1LqSuH8pr5NLywzcGRXSkNZDlDTfzv+RAGoravOw6SZZK9VOdZ4+UYOSaLYNMSG
 mIwA==
X-Gm-Message-State: AOJu0YyUUWKayZtWYG4L0yctVSWWx+RyaSvrmjSNCqcJPngiW0KIalvW
 ImMwv8ND8NIS3rC7kRnLbB4/0Il/zUlk3MSEYYXn07AaH6nlp+C3jgHFCv4fZXPDS2E=
X-Gm-Gg: Acq92OGfH5edf623RlAkxBFKTxZ7m+tWnLrB00B8yn1vPj0W6eAwtc6p/7L6g61wtr3
 BUnAtHVu395Si66QY7LcthFNW8ruOzzSlIxH0lEiVjR6HmwS1s1NwPxw0Ch19YeHqMgDdM2xhYr
 pRWt/YTM5X+vfO8mFS+7V8KbVAdWvSFGZTR9tQDhHBJnBMprlObij9xYX8P+q1joKABOh8Iqgza
 qFIlPLWLLlBsGfIk4obkXm26wzxmTqAPJzS57AqbqvHmoSrEB1XnTmEvDs3YqcAnyYiBN0vae8Z
 DYPNfhpU6z+cEjk8CdYNHHJLUqxFfz0UZq0X+GpEYAcRUFbQ+X69/qbKCRd117ORMNSBncP1odp
 f6mPfHXRyGK0UjDIMShIyN0V2UO4xMKcs5UODKCPyNFdM2GWya2AMUTztYAWx7m2WMLSKfT87l9
 jp6GFRT+TAokgGGROFvbN3X15F13QBOVSR/Iy7jOYHjQxgnQRRdC5V3eGQh+iSP35iMGNbOt6Gr
 ibVMmuYI45I4NcS8Hgu9xnZt8FMUOVDi5rDJ+WmTwg+9o6iM7xs/UKOs3ug86zwgKhKTX3zwSDK
 pbbJ733NU3Cbv5CFKvxbgsD3sL88KQ+ObGs=
X-Received: by 2002:a05:620a:2892:b0:915:c12f:f085 with SMTP id
 af79cd13be357-915e82e7d12mr446340585a.33.1781015815643; 
 Tue, 09 Jun 2026 07:36:55 -0700 (PDT)
Received: from d122166.iol.unh.edu ([2606:4100:3880:1220:ff12:f4a1:a541:db45])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9158a3eea49sm2100328385a.44.2026.06.09.07.36.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 07:36:55 -0700 (PDT)
From: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
To: luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: dev@dpdk.org, abailey@iol.unh.edu, ahassick@iol.unh.edu,
 lylavoie@iol.unh.edu, Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Subject: [PATCH v2 1/2] dts: add code coverage reporting to DTS
Date: Tue,  9 Jun 2026 10:36:46 -0400
Message-ID: <20260609143647.1434076-1-knimoji@iol.unh.edu>
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
 .mailmap                                      |  1 +
 doc/guides/tools/dts.rst                      | 15 +++++++++++++
 dts/README.md                                 |  5 +++++
 dts/framework/remote_session/dpdk.py          | 19 ++++++++++++++++
 .../remote_session/remote_session.py          |  5 ++++-
 dts/framework/settings.py                     | 10 +++++++++
 dts/framework/testbed_model/os_session.py     |  8 +++++++
 dts/framework/testbed_model/posix_session.py  | 22 +++++++++++++++++++
 dts/framework/utils.py                        |  8 +++++++
 9 files changed, 92 insertions(+), 1 deletion(-)

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
index dec952685a..36ac9be7cf 100644
--- a/dts/framework/testbed_model/posix_session.py
+++ b/dts/framework/testbed_model/posix_session.py
@@ -295,6 +295,28 @@ def build_dpdk(
         except RemoteCommandExecutionError as e:
             raise DPDKBuildError(f"DPDK build failed when doing '{e.command}'.")
 
+    def generate_coverage_report(self, remote_build_dir: PurePath | None):
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

