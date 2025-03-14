Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B278C282EC
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Mar 2025 13:19:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4944F40650;
	Fri, 14 Mar 2025 14:19:27 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id E4BDA4060A
 for <dev@dpdk.org>; Fri, 14 Mar 2025 14:19:24 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 666851424;
 Fri, 14 Mar 2025 06:19:34 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.57.40.184])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A49F63F673;
 Fri, 14 Mar 2025 06:19:23 -0700 (PDT)
From: Luca Vizzarro <luca.vizzarro@arm.com>
To: dev@dpdk.org
Cc: Luca Vizzarro <luca.vizzarro@arm.com>,
 Paul Szczepanek <paul.szczepanek@arm.com>, Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH v2 5/7] dts: make shells path dynamic
Date: Fri, 14 Mar 2025 15:18:55 +0200
Message-ID: <20250314131857.1298247-6-luca.vizzarro@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250314131857.1298247-1-luca.vizzarro@arm.com>
References: <20241220172337.2194523-1-luca.vizzarro@arm.com>
 <20250314131857.1298247-1-luca.vizzarro@arm.com>
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

Turn the `path` attribute of InteractiveShell into a method property.
This allows path to both be defined statically by the class
implementation and also to be defined dynamically as part of the class
construction.

Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
Reviewed-by: Paul Szczepanek <paul.szczepanek@arm.com>
---
 dts/framework/remote_session/dpdk_app.py      |  9 +++++++-
 dts/framework/remote_session/dpdk_shell.py    | 18 ++++++++-------
 .../remote_session/interactive_shell.py       | 22 ++++++++-----------
 dts/framework/remote_session/python_shell.py  |  6 +++--
 dts/framework/remote_session/testpmd_shell.py |  8 ++++---
 5 files changed, 36 insertions(+), 27 deletions(-)

diff --git a/dts/framework/remote_session/dpdk_app.py b/dts/framework/remote_session/dpdk_app.py
index c5aae05e02..dc4b817bdd 100644
--- a/dts/framework/remote_session/dpdk_app.py
+++ b/dts/framework/remote_session/dpdk_app.py
@@ -54,7 +54,14 @@ def __init__(
             eal_params.append_str(app_params)
             app_params = eal_params
 
-        super().__init__(name, privileged, path, app_params)
+        self._path = path
+
+        super().__init__(name, privileged, app_params)
+
+    @property
+    def path(self) -> PurePath:
+        """The path of the DPDK app relative to the DPDK build folder."""
+        return self._path
 
     def wait_until_ready(self, end_token: str) -> None:
         """Start app and wait until ready.
diff --git a/dts/framework/remote_session/dpdk_shell.py b/dts/framework/remote_session/dpdk_shell.py
index 24a39482ce..2d4f91052d 100644
--- a/dts/framework/remote_session/dpdk_shell.py
+++ b/dts/framework/remote_session/dpdk_shell.py
@@ -6,7 +6,7 @@
 Provides a base class to create interactive shells based on DPDK.
 """
 
-from abc import ABC
+from abc import ABC, abstractmethod
 from pathlib import PurePath
 
 from framework.context import get_ctx
@@ -65,20 +65,22 @@ def __init__(
         self,
         name: str | None = None,
         privileged: bool = True,
-        path: PurePath | None = None,
         app_params: EalParams = EalParams(),
     ) -> None:
         """Extends :meth:`~.interactive_shell.InteractiveShell.__init__`."""
         app_params = compute_eal_params(app_params)
         node = get_ctx().sut_node
 
-        super().__init__(node, name, privileged, path, app_params)
+        super().__init__(node, name, privileged, app_params)
 
-    def _update_real_path(self, path: PurePath) -> None:
-        """Extends :meth:`~.interactive_shell.InteractiveShell._update_real_path`.
+    @property
+    @abstractmethod
+    def path(self) -> PurePath:
+        """Relative path to the shell executable from the build folder."""
+
+    def _make_real_path(self):
+        """Overrides :meth:`~.interactive_shell.InteractiveShell._make_real_path`.
 
         Adds the remote DPDK build directory to the path.
         """
-        super()._update_real_path(
-            PurePath(get_ctx().dpdk_build.remote_dpdk_build_dir).joinpath(path)
-        )
+        return get_ctx().dpdk_build.remote_dpdk_build_dir.joinpath(self.path)
diff --git a/dts/framework/remote_session/interactive_shell.py b/dts/framework/remote_session/interactive_shell.py
index 62f9984d3b..6b7ca0b6af 100644
--- a/dts/framework/remote_session/interactive_shell.py
+++ b/dts/framework/remote_session/interactive_shell.py
@@ -21,7 +21,7 @@
 environment variable configure the timeout of getting the output from command execution.
 """
 
-from abc import ABC
+from abc import ABC, abstractmethod
 from pathlib import PurePath
 from typing import ClassVar
 
@@ -66,7 +66,6 @@ class InteractiveShell(MultiInheritanceBaseClass, ABC):
     _timeout: float
     _app_params: Params
     _privileged: bool
-    _real_path: PurePath
 
     #: The number of times to try starting the application before considering it a failure.
     _init_attempts: ClassVar[int] = 5
@@ -83,9 +82,6 @@ class InteractiveShell(MultiInheritanceBaseClass, ABC):
     #: the expected prompt.
     _command_extra_chars: ClassVar[str] = ""
 
-    #: Path to the executable to start the interactive application.
-    path: ClassVar[PurePath]
-
     is_alive: bool = False
 
     def __init__(
@@ -93,7 +89,6 @@ def __init__(
         node: Node,
         name: str | None = None,
         privileged: bool = False,
-        path: PurePath | None = None,
         app_params: Params = Params(),
         **kwargs,
     ) -> None:
@@ -107,7 +102,6 @@ def __init__(
             name: Name for the interactive shell to use for logging. This name will be appended to
                 the name of the underlying node which it is running on.
             privileged: Enables the shell to run as superuser.
-            path: Path to the executable. If :data:`None`, then the class' path attribute is used.
             app_params: The command line parameters to be passed to the application on startup.
             **kwargs: Any additional arguments if any.
         """
@@ -118,8 +112,6 @@ def __init__(
         self._app_params = app_params
         self._privileged = privileged
         self._timeout = SETTINGS.timeout
-        # Ensure path is properly formatted for the host
-        self._update_real_path(path or self.path)
         super().__init__(**kwargs)
 
     def _setup_ssh_channel(self):
@@ -131,7 +123,7 @@ def _setup_ssh_channel(self):
 
     def _make_start_command(self) -> str:
         """Makes the command that starts the interactive shell."""
-        start_command = f"{self._real_path} {self._app_params or ''}"
+        start_command = f"{self._make_real_path()} {self._app_params or ''}"
         if self._privileged:
             start_command = self._node.main_session._get_privileged_command(start_command)
         return start_command
@@ -250,9 +242,13 @@ def close(self) -> None:
             raise InteractiveSSHTimeoutError("Application 'exit' command") from e
         self._ssh_channel.close()
 
-    def _update_real_path(self, path: PurePath) -> None:
-        """Updates the interactive shell's real path used at command line."""
-        self._real_path = self._node.main_session.join_remote_path(path)
+    @property
+    @abstractmethod
+    def path(self) -> PurePath:
+        """Path to the shell executable."""
+
+    def _make_real_path(self) -> PurePath:
+        return self._node.main_session.join_remote_path(self.path)
 
     def __enter__(self) -> Self:
         """Enter the context block.
diff --git a/dts/framework/remote_session/python_shell.py b/dts/framework/remote_session/python_shell.py
index 17e6c2559d..6331d047c4 100644
--- a/dts/framework/remote_session/python_shell.py
+++ b/dts/framework/remote_session/python_shell.py
@@ -27,8 +27,10 @@ class PythonShell(InteractiveShell):
     #: This forces the prompt to appear after sending a command.
     _command_extra_chars: ClassVar[str] = "\n"
 
-    #: The Python executable.
-    path: ClassVar[PurePath] = PurePath("python3")
+    @property
+    def path(self) -> PurePath:
+        """Path to the Python3 executable."""
+        return PurePath("python3")
 
     def close(self):
         """Close Python shell."""
diff --git a/dts/framework/remote_session/testpmd_shell.py b/dts/framework/remote_session/testpmd_shell.py
index b83b0c82a0..19437b6233 100644
--- a/dts/framework/remote_session/testpmd_shell.py
+++ b/dts/framework/remote_session/testpmd_shell.py
@@ -1520,9 +1520,6 @@ class TestPmdShell(DPDKShell):
     _app_params: TestPmdParams
     _ports: list[TestPmdPort] | None
 
-    #: The path to the testpmd executable.
-    path: ClassVar[PurePath] = PurePath("app", "dpdk-testpmd")
-
     #: The testpmd's prompt.
     _default_prompt: ClassVar[str] = "testpmd>"
 
@@ -1544,6 +1541,11 @@ def __init__(
         self.ports_started = not self._app_params.disable_device_start
         self._ports = None
 
+    @property
+    def path(self) -> PurePath:
+        """The path to the testpmd executable."""
+        return PurePath("app/dpdk-testpmd")
+
     @property
     def ports(self) -> list[TestPmdPort]:
         """The ports of the instance.
-- 
2.43.0

