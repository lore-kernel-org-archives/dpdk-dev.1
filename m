Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DD1C369B4
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Apr 2025 13:09:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CB7C940693;
	Tue, 15 Apr 2025 15:09:19 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 93AE24066D
 for <dev@dpdk.org>; Tue, 15 Apr 2025 15:09:17 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4DEC91D14;
 Tue, 15 Apr 2025 06:09:15 -0700 (PDT)
Received: from e132991.cambridge.arm.com (e132991.arm.com [10.1.30.26])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D59593F59E;
 Tue, 15 Apr 2025 06:09:15 -0700 (PDT)
From: Thomas Wilks <thomas.wilks@arm.com>
To: dev@dpdk.org
Cc: Paul Szczepanek <paul.szczepanek@arm.com>,
 Luca Vizzarro <luca.vizzarro@arm.com>, Patrick Robb <probb@iol.unh.edu>,
 Thomas Wilks <thomas.wilks@arm.com>,
 Paul Szczepanek <Paul.Szczepanek@arm.com>
Subject: [PATCH 2/2] dts: use tmp dir and DPDK tree dir
Date: Tue, 15 Apr 2025 14:09:03 +0100
Message-ID: <20250415130903.224858-3-thomas.wilks@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415130903.224858-1-thomas.wilks@arm.com>
References: <20250415130903.224858-1-thomas.wilks@arm.com>
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

File operations were not consistently using the same
dedicated directory for the test run. Moreover the DPDK
tree temporary directory was inconsistent and relying on
the name chosen by the user.

Update all the file operations to use the dedicated temporary
directory, and make sure that the DPDK tree temporary directory
is fixed to a predefined directory name. Make extraction
verbose to avoid timeout for big tarballs.

Signed-off-by: Thomas Wilks <thomas.wilks@arm.com>
Reviewed-by: Luca Vizzarro <luca.vizzarro@arm.com>
Reviewed-by: Paul Szczepanek <Paul.Szczepanek@arm.com>
---
 dts/framework/remote_session/dpdk.py         | 74 ++++++--------------
 dts/framework/testbed_model/os_session.py    | 10 +--
 dts/framework/testbed_model/posix_session.py | 22 +++---
 dts/tests/TestSuite_softnic.py               |  2 +-
 4 files changed, 41 insertions(+), 67 deletions(-)

diff --git a/dts/framework/remote_session/dpdk.py b/dts/framework/remote_session/dpdk.py
index 401e3a7277..59fc50c3af 100644
--- a/dts/framework/remote_session/dpdk.py
+++ b/dts/framework/remote_session/dpdk.py
@@ -11,7 +11,7 @@
 from dataclasses import dataclass
 from functools import cached_property
 from pathlib import Path, PurePath
-from typing import Final
+from typing import ClassVar, Final
 
 from framework.config.test_run import (
     DPDKBuildConfiguration,
@@ -56,10 +56,9 @@ class DPDKBuildEnvironment:
     _node: Node
     _session: OSSession
     _logger: DTSLogger
-    _remote_tmp_dir: PurePath
-    _remote_dpdk_tree_path: str | PurePath | None
     _remote_dpdk_build_dir: PurePath | None
     _app_compile_timeout: float
+    _remote_tmp_dpdk_tree_dir: ClassVar[str] = "dpdk"
 
     compiler_version: str | None
 
@@ -70,8 +69,6 @@ def __init__(self, config: DPDKBuildConfiguration, node: Node):
         self._logger = get_dts_logger()
         self._session = node.create_session("dpdk_build")
 
-        self._remote_tmp_dir = node.main_session.get_remote_tmp_dir()
-        self._remote_dpdk_tree_path = None
         self._remote_dpdk_build_dir = None
         self._app_compile_timeout = 90
 
@@ -84,6 +81,9 @@ def setup(self):
         sources and then building DPDK or using the exist ones from the `dpdk_location`. The drivers
         are bound to those that DPDK needs.
         """
+        if not isinstance(self.config.dpdk_location, RemoteDPDKTreeLocation):
+            self._node.main_session.create_directory(self.remote_dpdk_tree_path)
+
         match self.config.dpdk_location:
             case RemoteDPDKTreeLocation(dpdk_tree=dpdk_tree):
                 self._set_remote_dpdk_tree_path(dpdk_tree)
@@ -114,7 +114,7 @@ def teardown(self) -> None:
             case LocalDPDKTarballLocation(tarball=tarball):
                 self._node.main_session.remove_remote_dir(self.remote_dpdk_tree_path)
                 tarball_path = self._node.main_session.join_remote_path(
-                    self._remote_tmp_dir, tarball.name
+                    self._node.tmp_dir, tarball.name
                 )
                 self._node.main_session.remove_remote_file(tarball_path)
 
@@ -122,7 +122,7 @@ def _set_remote_dpdk_tree_path(self, dpdk_tree: PurePath):
         """Set the path to the remote DPDK source tree based on the provided DPDK location.
 
         Verify DPDK source tree existence on the SUT node, if exists sets the
-        `_remote_dpdk_tree_path` property, otherwise sets nothing.
+        `remote_dpdk_tree_path` property, otherwise sets nothing.
 
         Args:
             dpdk_tree: The path to the DPDK source tree directory.
@@ -139,7 +139,7 @@ def _set_remote_dpdk_tree_path(self, dpdk_tree: PurePath):
         if not self._session.is_remote_dir(dpdk_tree):
             raise ConfigurationError(f"Remote DPDK source tree '{dpdk_tree}' must be a directory.")
 
-        self._remote_dpdk_tree_path = dpdk_tree
+        self.remote_dpdk_tree_path = dpdk_tree
 
     def _copy_dpdk_tree(self, dpdk_tree_path: Path) -> None:
         """Copy the DPDK source tree to the SUT.
@@ -148,19 +148,16 @@ def _copy_dpdk_tree(self, dpdk_tree_path: Path) -> None:
             dpdk_tree_path: The path to DPDK source tree on local filesystem.
         """
         self._logger.info(
-            f"Copying DPDK source tree to SUT: '{dpdk_tree_path}' into '{self._remote_tmp_dir}'."
+            f"Copying DPDK source tree to SUT: '{dpdk_tree_path}' into "
+            f"'{self.remote_dpdk_tree_path}'."
         )
         self._session.copy_dir_to(
             dpdk_tree_path,
-            self._remote_tmp_dir,
+            self.remote_dpdk_tree_path,
             exclude=[".git", "*.o"],
             compress_format=TarCompressionFormat.gzip,
         )
 
-        self._remote_dpdk_tree_path = self._session.join_remote_path(
-            self._remote_tmp_dir, PurePath(dpdk_tree_path).name
-        )
-
     def _validate_remote_dpdk_tarball(self, dpdk_tarball: PurePath) -> None:
         """Validate the DPDK tarball on the SUT node.
 
@@ -187,42 +184,17 @@ def _copy_dpdk_tarball_to_remote(self, dpdk_tarball: Path) -> PurePath:
             The path of the copied tarball on the SUT node.
         """
         self._logger.info(
-            f"Copying DPDK tarball to SUT: '{dpdk_tarball}' into '{self._remote_tmp_dir}'."
+            f"Copying DPDK tarball to SUT: '{dpdk_tarball}' into '{self._node.tmp_dir}'."
         )
-        self._session.copy_to(dpdk_tarball, self._remote_tmp_dir)
-        return self._session.join_remote_path(self._remote_tmp_dir, dpdk_tarball.name)
+        self._session.copy_to(dpdk_tarball, self._node.tmp_dir)
+        return self._session.join_remote_path(self._node.tmp_dir, dpdk_tarball.name)
 
     def _prepare_and_extract_dpdk_tarball(self, remote_tarball_path: PurePath) -> None:
         """Prepare the remote DPDK tree path and extract the tarball.
 
-        This method extracts the remote tarball and sets the `_remote_dpdk_tree_path` property to
-        the path of the extracted DPDK tree on the SUT node.
-
         Args:
             remote_tarball_path: The path to the DPDK tarball on the SUT node.
         """
-
-        def remove_tarball_suffix(remote_tarball_path: PurePath) -> PurePath:
-            """Remove the tarball suffix from the path.
-
-            Args:
-                remote_tarball_path: The path to the remote tarball.
-
-            Returns:
-                The path without the tarball suffix.
-            """
-            if len(remote_tarball_path.suffixes) > 1:
-                if remote_tarball_path.suffixes[-2] == ".tar":
-                    suffixes_to_remove = "".join(remote_tarball_path.suffixes[-2:])
-                    return PurePath(str(remote_tarball_path).replace(suffixes_to_remove, ""))
-            return remote_tarball_path.with_suffix("")
-
-        tarball_top_dir = self._session.get_tarball_top_dir(remote_tarball_path)
-        self._remote_dpdk_tree_path = self._session.join_remote_path(
-            remote_tarball_path.parent,
-            tarball_top_dir or remove_tarball_suffix(remote_tarball_path),
-        )
-
         self._logger.info(
             "Extracting DPDK tarball on SUT: "
             f"'{remote_tarball_path}' into '{self.remote_dpdk_tree_path}'."
@@ -230,13 +202,14 @@ def remove_tarball_suffix(remote_tarball_path: PurePath) -> PurePath:
         self._session.extract_remote_tarball(
             remote_tarball_path,
             self.remote_dpdk_tree_path,
+            strip_root_dir=True,
         )
 
     def _set_remote_dpdk_build_dir(self, build_dir: str):
         """Set the `remote_dpdk_build_dir` on the SUT.
 
         Check existence on the SUT node and sets the
-        `remote_dpdk_build_dir` property by joining the `_remote_dpdk_tree_path` and `build_dir`.
+        `remote_dpdk_build_dir` property by joining the `remote_dpdk_tree_path` and `build_dir`.
         Otherwise, sets nothing.
 
         Args:
@@ -285,7 +258,7 @@ def _build_dpdk(self) -> None:
         """Build DPDK.
 
         Uses the already configured DPDK build configuration. Assumes that the
-        `_remote_dpdk_tree_path` has already been set on the SUT node.
+        `remote_dpdk_tree_path` has already been set on the SUT node.
         """
         self._session.build_dpdk(
             self._env_vars,
@@ -325,17 +298,10 @@ def build_dpdk_app(self, app_name: str, **meson_dpdk_args: str | bool) -> PurePa
             self.remote_dpdk_build_dir, "examples", f"dpdk-{app_name}"
         )
 
-    @property
-    def remote_dpdk_tree_path(self) -> str | PurePath:
+    @cached_property
+    def remote_dpdk_tree_path(self) -> PurePath:
         """The remote DPDK tree path."""
-        if self._remote_dpdk_tree_path:
-            return self._remote_dpdk_tree_path
-
-        self._logger.warning(
-            "Failed to get remote dpdk tree path because we don't know the "
-            "location on the SUT node."
-        )
-        return ""
+        return self._node.tmp_dir.joinpath(self._remote_tmp_dpdk_tree_dir)
 
     @property
     def remote_dpdk_build_dir(self) -> str | PurePath:
diff --git a/dts/framework/testbed_model/os_session.py b/dts/framework/testbed_model/os_session.py
index 2be4f78ac0..4a6f563fc3 100644
--- a/dts/framework/testbed_model/os_session.py
+++ b/dts/framework/testbed_model/os_session.py
@@ -368,14 +368,16 @@ def create_directory(self, path: PurePath) -> None:
     def extract_remote_tarball(
         self,
         remote_tarball_path: str | PurePath,
-        expected_dir: str | PurePath | None = None,
+        destination_path: str | PurePath,
+        strip_root_dir: bool = False,
     ) -> None:
-        """Extract remote tarball in its remote directory.
+        """Extract remote tarball in the given path.
 
         Args:
             remote_tarball_path: The tarball path on the remote node.
-            expected_dir: If non-empty, check whether `expected_dir` exists after extracting
-                the archive.
+            destination_path: The location the tarball will be extracted to.
+            strip_root_dir: If :data:`True` and the root of the tarball is a folder, strip it and
+                extract its contents only.
         """
 
     @abstractmethod
diff --git a/dts/framework/testbed_model/posix_session.py b/dts/framework/testbed_model/posix_session.py
index 57d58030b4..1688084994 100644
--- a/dts/framework/testbed_model/posix_session.py
+++ b/dts/framework/testbed_model/posix_session.py
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2023 PANTHEON.tech s.r.o.
 # Copyright(c) 2023 University of New Hampshire
+# Copyright(c) 2025 Arm Limited
 
 """POSIX compliant OS translator.
 
@@ -103,10 +104,12 @@ def create_tmp_dir(self, template: str = "dts.XXXXX") -> PurePath:
 
     def copy_from(self, source_file: str | PurePath, destination_dir: str | Path) -> None:
         """Overrides :meth:`~.os_session.OSSession.copy_from`."""
+        self._logger.debug(f"Copying file '{source_file}' to local '{destination_dir}'.")
         self.remote_session.copy_from(source_file, destination_dir)
 
     def copy_to(self, source_file: str | Path, destination_dir: str | PurePath) -> None:
         """Overrides :meth:`~.os_session.OSSession.copy_to`."""
+        self._logger.debug(f"Copying file '{source_file}' to remote '{destination_dir}'.")
         self.remote_session.copy_to(source_file, destination_dir)
 
     def copy_dir_from(
@@ -117,6 +120,7 @@ def copy_dir_from(
         exclude: str | list[str] | None = None,
     ) -> None:
         """Overrides :meth:`~.os_session.OSSession.copy_dir_from`."""
+        self._logger.debug(f"Copying directory '{source_dir}' to local '{destination_dir}'.")
         source_dir = PurePath(source_dir)
         remote_tarball_path = self.create_remote_tarball(source_dir, compress_format, exclude)
 
@@ -135,6 +139,7 @@ def copy_dir_to(
         exclude: str | list[str] | None = None,
     ) -> None:
         """Overrides :meth:`~.os_session.OSSession.copy_dir_to`."""
+        self._logger.debug(f"Copying directory '{source_dir}' to remote '{destination_dir}'.")
         source_dir = Path(source_dir)
         tarball_path = create_tarball(source_dir, compress_format, exclude=exclude)
         self.copy_to(tarball_path, destination_dir)
@@ -143,7 +148,7 @@ def copy_dir_to(
         remote_tar_path = self.join_remote_path(
             destination_dir, f"{source_dir.name}.{compress_format.extension}"
         )
-        self.extract_remote_tarball(remote_tar_path)
+        self.extract_remote_tarball(remote_tar_path, destination_dir, strip_root_dir=True)
         self.remove_remote_file(remote_tar_path)
 
     def remove_remote_file(self, remote_file_path: str | PurePath, force: bool = True) -> None:
@@ -202,15 +207,16 @@ def create_directory(self, path: PurePath) -> None:
     def extract_remote_tarball(
         self,
         remote_tarball_path: str | PurePath,
-        expected_dir: str | PurePath | None = None,
+        destination_path: str | PurePath,
+        strip_root_dir: bool = False,
     ) -> None:
         """Overrides :meth:`~.os_session.OSSession.extract_remote_tarball`."""
-        self.send_command(
-            f"tar xfm {remote_tarball_path} -C {PurePosixPath(remote_tarball_path).parent}",
-            60,
-        )
-        if expected_dir:
-            self.send_command(f"ls {expected_dir}", verify=True)
+        cmd = f"tar xfmv {remote_tarball_path} -C {destination_path}"
+        if strip_root_dir and self.get_tarball_top_dir(remote_tarball_path):
+            cmd += " --strip-components=1"
+
+        self.send_command(cmd)
+        self.send_command(f"ls {destination_path}", verify=True)
 
     def is_remote_dir(self, remote_path: PurePath) -> bool:
         """Overrides :meth:`~.os_session.OSSession.is_remote_dir`."""
diff --git a/dts/tests/TestSuite_softnic.py b/dts/tests/TestSuite_softnic.py
index 9cd4e37746..c1873dca4c 100644
--- a/dts/tests/TestSuite_softnic.py
+++ b/dts/tests/TestSuite_softnic.py
@@ -46,7 +46,7 @@ def prepare_softnic_files(self) -> PurePath:
         spec_file = Path("rx_tx.spec")
         rx_tx_1_file = Path("rx_tx_1.io")
         rx_tx_2_file = Path("rx_tx_2.io")
-        path_sut = self._ctx.dpdk_build.remote_dpdk_build_dir
+        path_sut = self._ctx.sut_node.tmp_dir
         cli_file_sut = self.sut_node.main_session.join_remote_path(path_sut, cli_file)
         spec_file_sut = self.sut_node.main_session.join_remote_path(path_sut, spec_file)
         rx_tx_1_file_sut = self.sut_node.main_session.join_remote_path(path_sut, rx_tx_1_file)
-- 
2.43.0

