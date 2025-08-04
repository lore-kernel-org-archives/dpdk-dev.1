Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E13FC87FCF
	for <dpdk-dev@archiver.kernel.org>; Mon,  4 Aug 2025 20:00:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 20B8D40653;
	Mon,  4 Aug 2025 22:00:26 +0200 (CEST)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com
 [209.85.160.182])
 by mails.dpdk.org (Postfix) with ESMTP id A41834028C
 for <dev@dpdk.org>; Mon,  4 Aug 2025 22:00:24 +0200 (CEST)
Received: by mail-qt1-f182.google.com with SMTP id
 d75a77b69052e-4aedd1b006bso48445621cf.0
 for <dev@dpdk.org>; Mon, 04 Aug 2025 13:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1754337624; x=1754942424; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3Y4YMZJZJYUisK3/VqDiVQOKF5oKHGYJBWVuMJyih/E=;
 b=f1DtgtRT6TKpQe8Owx1UZQI/ma2hoznpF5ovlzDVc1uKaDjfAf6HiFlF/jXCickrbj
 a4g+HPNQFXghugtNXW/1AlfeaTVpzXr9camzp5x22GrykGilgIV7TKSO+ht6tOzEzWKv
 sCH5A8mEdLh3GhPDJRhu8n9ljEMp//AjIj6oU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754337624; x=1754942424;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3Y4YMZJZJYUisK3/VqDiVQOKF5oKHGYJBWVuMJyih/E=;
 b=XYjMvn8y6XNRz0/f1n9pxnvTqQdB2LJkG08Sc72ksjldoLNhuyVIqGLONec0I38Ux5
 cEkIjdYNC41uToa0j5ehP0iiDH5ZlmJDu0YjE4L6uIuA0bkj/LZwwCoBCOVWksgzZ+1/
 c6vXPTPK8q2ReEEu310fof3OOBh49kHao0ZHlimgxvJ4TReKj75QveSabhaT77SRjgPI
 feGzfLjxLBZftpmEoA8JYMJ+P1RhtOQu5ZiNy7dOYFi99Yw/s/25mwEOcaF8dQ/6WWDF
 lmLDwYgeumCfs+MLXzblwZnIQ8uBM47m8oFJBIuUWsUNHa7U27/K1G2qaePx/xm8N6DP
 R8YQ==
X-Gm-Message-State: AOJu0YzwBQsZsbcL5jawZG0EtGmKx1MUbL0/332XhHq6DXxqpRVvWbky
 aRvVHpkI7IUiDb68qvUFQ8mBhcic5jglQfqCDwmT6mXhJOm7OXCk8m5I6Gtp5arcIfY=
X-Gm-Gg: ASbGncvEtwmSdqGGdQJtQxeWrnLbtUo1fPoN9f5A0LBp8wsxzAJYImcloqXWngQl39b
 IcqwQijyRmR//NoR+DUEBqY44axjkRMuUuIgMrWQDLdU0cR7WcaikJHCU4xR7oPvHgwy+6ADOij
 63K7Z2rt+/4n4LY0qZ1Wsde8cx3B74phV7RCCgrHCpDckZN12/EvL9qOXs4S5UcaZsLW0SeJLu1
 dEUjIyWbYgHO+YRSZX+wyLnAEyJgKimXdCkBf8mhHftcBKMqm3SI6xWggMoA1Fd8Ry619HRjgb1
 E7UeTlAiIUSlxG0K341w6x36DDF3+hPGpHZNZ+Ahbj31a/C1sxQo88N3cVgcY0rF5ZOjPP94XwS
 JMvr/z8nuad4vL/T3p2hq6ZIsKqoRQlhJ1XMgqIUJwZljwA==
X-Google-Smtp-Source: AGHT+IGvt/a605E8mR24toiNVBGDiXtgPzxiEM1E9bm8rODLHUvLGMkY9ug1YEPuqZSTd87NTIuI+g==
X-Received: by 2002:a05:622a:1e11:b0:4b0:38b2:3808 with SMTP id
 d75a77b69052e-4b038b23b6cmr95857071cf.43.1754337623477; 
 Mon, 04 Aug 2025 13:00:23 -0700 (PDT)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4af1bc47cd9sm28832281cf.13.2025.08.04.13.00.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 13:00:22 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com
Cc: dev@dpdk.org, dmarx@iol.unh.edu, probb@iol.unh.edu,
 Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH] dts: update hinted return types of various methods
Date: Mon,  4 Aug 2025 16:00:19 -0400
Message-ID: <20250804200019.219458-1-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
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

Added return type hints for every method, function, and constructor in
DTS where they were missing.

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
---
 dts/framework/context.py                      |  7 +++---
 dts/framework/exception.py                    |  8 +++---
 dts/framework/logger.py                       |  2 +-
 dts/framework/params/__init__.py              |  2 +-
 dts/framework/remote_session/dpdk.py          | 12 ++++-----
 dts/framework/remote_session/dpdk_shell.py    |  2 +-
 .../remote_session/interactive_shell.py       |  2 +-
 dts/framework/remote_session/python_shell.py  |  2 +-
 .../remote_session/remote_session.py          |  2 +-
 dts/framework/remote_session/shell_pool.py    | 10 ++++----
 dts/framework/remote_session/testpmd_shell.py | 25 +++++++++++++------
 dts/framework/runner.py                       |  2 +-
 dts/framework/settings.py                     |  4 +--
 dts/framework/test_result.py                  |  4 +--
 dts/framework/test_run.py                     | 10 ++++----
 dts/framework/test_suite.py                   |  2 +-
 dts/framework/testbed_model/cpu.py            |  4 +--
 dts/framework/testbed_model/node.py           |  2 +-
 dts/framework/testbed_model/os_session.py     |  2 +-
 dts/framework/testbed_model/port.py           |  4 +--
 .../testbed_model/traffic_generator/scapy.py  | 12 ++++-----
 .../traffic_generator/traffic_generator.py    |  6 ++---
 dts/framework/testbed_model/virtual_device.py |  2 +-
 dts/framework/utils.py                        |  6 ++---
 dts/tests/TestSuite_blocklist.py              |  8 +++---
 dts/tests/TestSuite_dynamic_queue_conf.py     |  8 +++---
 26 files changed, 80 insertions(+), 70 deletions(-)

diff --git a/dts/framework/context.py b/dts/framework/context.py
index 4360bc8699..969c541975 100644
--- a/dts/framework/context.py
+++ b/dts/framework/context.py
@@ -4,6 +4,7 @@
 """Runtime contexts."""
 
 import functools
+from _collections_abc import Callable
 from dataclasses import MISSING, dataclass, field, fields
 from typing import TYPE_CHECKING, ParamSpec
 
@@ -97,12 +98,12 @@ def init_ctx(ctx: Context) -> None:
 
 def filter_cores(
     specifier: LogicalCoreCount | LogicalCoreList, ascending_cores: bool | None = None
-):
+) -> Callable:
     """Decorates functions that require a temporary update to the lcore specifier."""
 
-    def decorator(func):
+    def decorator(func) -> Callable:
         @functools.wraps(func)
-        def wrapper(*args: P.args, **kwargs: P.kwargs):
+        def wrapper(*args: P.args, **kwargs: P.kwargs) -> Callable:
             local_ctx = get_ctx().local
 
             old_specifier = local_ctx.lcore_filter_specifier
diff --git a/dts/framework/exception.py b/dts/framework/exception.py
index 47e3fac05c..84d42c7779 100644
--- a/dts/framework/exception.py
+++ b/dts/framework/exception.py
@@ -59,7 +59,7 @@ class SSHConnectionError(DTSError):
     _host: str
     _errors: list[str]
 
-    def __init__(self, host: str, errors: list[str] | None = None):
+    def __init__(self, host: str, errors: list[str] | None = None) -> None:
         """Define the meaning of the first two arguments.
 
         Args:
@@ -88,7 +88,7 @@ class _SSHTimeoutError(DTSError):
     severity: ClassVar[ErrorSeverity] = ErrorSeverity.SSH_ERR
     _command: str
 
-    def __init__(self, command: str):
+    def __init__(self, command: str) -> None:
         """Define the meaning of the first argument.
 
         Args:
@@ -119,7 +119,7 @@ class _SSHSessionDeadError(DTSError):
     severity: ClassVar[ErrorSeverity] = ErrorSeverity.SSH_ERR
     _host: str
 
-    def __init__(self, host: str):
+    def __init__(self, host: str) -> None:
         """Define the meaning of the first argument.
 
         Args:
@@ -157,7 +157,7 @@ class RemoteCommandExecutionError(DTSError):
     _command_stderr: str
     _command_return_code: int
 
-    def __init__(self, command: str, command_stderr: str, command_return_code: int):
+    def __init__(self, command: str, command_stderr: str, command_return_code: int) -> None:
         """Define the meaning of the first two arguments.
 
         Args:
diff --git a/dts/framework/logger.py b/dts/framework/logger.py
index f43b442bc9..b073d8b8e0 100644
--- a/dts/framework/logger.py
+++ b/dts/framework/logger.py
@@ -36,7 +36,7 @@ class DTSLogger(logging.Logger):
     _stage: ClassVar[str] = "pre_run"
     _extra_file_handlers: list[FileHandler] = []
 
-    def __init__(self, *args, **kwargs):
+    def __init__(self, *args, **kwargs) -> None:
         """Extend the constructor with extra file handlers."""
         self._extra_file_handlers = []
         super().__init__(*args, **kwargs)
diff --git a/dts/framework/params/__init__.py b/dts/framework/params/__init__.py
index 1ae227d7b4..e1c47c7fc4 100644
--- a/dts/framework/params/__init__.py
+++ b/dts/framework/params/__init__.py
@@ -75,7 +75,7 @@ class BitMask(enum.Flag):
         will allow ``BitMask`` to render as a hexadecimal value.
     """
 
-    def _class_decorator(original_class):
+    def _class_decorator(original_class) -> Any:
         original_class.__str__ = _reduce_functions(funcs)
         return original_class
 
diff --git a/dts/framework/remote_session/dpdk.py b/dts/framework/remote_session/dpdk.py
index 606d6e22fe..6e7a4c2a01 100644
--- a/dts/framework/remote_session/dpdk.py
+++ b/dts/framework/remote_session/dpdk.py
@@ -62,7 +62,7 @@ class DPDKBuildEnvironment:
 
     compiler_version: str | None
 
-    def __init__(self, config: DPDKBuildConfiguration, node: Node):
+    def __init__(self, config: DPDKBuildConfiguration, node: Node) -> None:
         """DPDK build environment class constructor."""
         self.config = config
         self._node = node
@@ -74,7 +74,7 @@ def __init__(self, config: DPDKBuildConfiguration, node: Node):
 
         self.compiler_version = None
 
-    def setup(self):
+    def setup(self) -> None:
         """Set up the DPDK build on the target node.
 
         DPDK setup includes setting all internals needed for the build, the copying of DPDK
@@ -118,7 +118,7 @@ def teardown(self) -> None:
                 )
                 self._node.main_session.remove_remote_file(tarball_path)
 
-    def _set_remote_dpdk_tree_path(self, dpdk_tree: PurePath):
+    def _set_remote_dpdk_tree_path(self, dpdk_tree: PurePath) -> None:
         """Set the path to the remote DPDK source tree based on the provided DPDK location.
 
         Verify DPDK source tree existence on the SUT node, if exists sets the
@@ -205,7 +205,7 @@ def _prepare_and_extract_dpdk_tarball(self, remote_tarball_path: PurePath) -> No
             strip_root_dir=True,
         )
 
-    def _set_remote_dpdk_build_dir(self, build_dir: str):
+    def _set_remote_dpdk_build_dir(self, build_dir: str) -> None:
         """Set the `remote_dpdk_build_dir` on the SUT.
 
         Check existence on the SUT node and sets the
@@ -323,7 +323,7 @@ def __init__(
         config: DPDKRuntimeConfiguration,
         node: Node,
         build_env: DPDKBuildEnvironment | None = None,
-    ):
+    ) -> None:
         """DPDK environment constructor.
 
         Args:
@@ -354,7 +354,7 @@ def __init__(
         self._ports_bound_to_dpdk = False
         self._kill_session = None
 
-    def setup(self):
+    def setup(self) -> None:
         """Set up the DPDK runtime on the target node."""
         if self.build:
             self.build.setup()
diff --git a/dts/framework/remote_session/dpdk_shell.py b/dts/framework/remote_session/dpdk_shell.py
index d4aa02f39b..51b97d4ff6 100644
--- a/dts/framework/remote_session/dpdk_shell.py
+++ b/dts/framework/remote_session/dpdk_shell.py
@@ -78,7 +78,7 @@ def __init__(
     def path(self) -> PurePath:
         """Relative path to the shell executable from the build folder."""
 
-    def _make_real_path(self):
+    def _make_real_path(self) -> PurePath:
         """Overrides :meth:`~.interactive_shell.InteractiveShell._make_real_path`.
 
         Adds the remote DPDK build directory to the path.
diff --git a/dts/framework/remote_session/interactive_shell.py b/dts/framework/remote_session/interactive_shell.py
index ba8489eafa..dc541b894d 100644
--- a/dts/framework/remote_session/interactive_shell.py
+++ b/dts/framework/remote_session/interactive_shell.py
@@ -126,7 +126,7 @@ def __init__(
         self._privileged = privileged
         self._timeout = SETTINGS.timeout
 
-    def _setup_ssh_channel(self):
+    def _setup_ssh_channel(self) -> None:
         self._ssh_channel = self._node.main_session.interactive_session.session.invoke_shell()
         self._stdin = self._ssh_channel.makefile_stdin("w")
         self._stdout = self._ssh_channel.makefile("r")
diff --git a/dts/framework/remote_session/python_shell.py b/dts/framework/remote_session/python_shell.py
index 5b380a5c7a..5f39a244d6 100644
--- a/dts/framework/remote_session/python_shell.py
+++ b/dts/framework/remote_session/python_shell.py
@@ -33,6 +33,6 @@ def path(self) -> PurePath:
         return PurePath("python3")
 
     @only_active
-    def close(self):
+    def close(self) -> None:
         """Close Python shell."""
         return super().close()
diff --git a/dts/framework/remote_session/remote_session.py b/dts/framework/remote_session/remote_session.py
index 89d4618c41..f616b92f1c 100644
--- a/dts/framework/remote_session/remote_session.py
+++ b/dts/framework/remote_session/remote_session.py
@@ -99,7 +99,7 @@ def __init__(
         node_config: NodeConfiguration,
         session_name: str,
         logger: DTSLogger,
-    ):
+    ) -> None:
         """Connect to the node during initialization.
 
         Args:
diff --git a/dts/framework/remote_session/shell_pool.py b/dts/framework/remote_session/shell_pool.py
index da956950d5..241737eab3 100644
--- a/dts/framework/remote_session/shell_pool.py
+++ b/dts/framework/remote_session/shell_pool.py
@@ -32,7 +32,7 @@ class ShellPool:
     _logger: DTSLogger
     _pools: list[set["InteractiveShell"]]
 
-    def __init__(self):
+    def __init__(self) -> None:
         """Shell pool constructor."""
         self._logger = get_dts_logger("shell_pool")
         self._pools = [set()]
@@ -50,12 +50,12 @@ def _current_pool(self) -> set["InteractiveShell"]:
         """The pool in use for the current scope."""
         return self._pools[-1]
 
-    def register_shell(self, shell: "InteractiveShell"):
+    def register_shell(self, shell: "InteractiveShell") -> None:
         """Register a new shell to the current pool."""
         self._logger.debug(f"Registering shell {shell} to pool level {self.pool_level}.")
         self._current_pool.add(shell)
 
-    def unregister_shell(self, shell: "InteractiveShell"):
+    def unregister_shell(self, shell: "InteractiveShell") -> None:
         """Unregister a shell from any pool."""
         for level, pool in enumerate(self._pools):
             try:
@@ -72,12 +72,12 @@ def unregister_shell(self, shell: "InteractiveShell"):
             except KeyError:
                 pass
 
-    def start_new_pool(self):
+    def start_new_pool(self) -> None:
         """Start a new shell pool."""
         self._logger.debug(f"Starting new shell pool and advancing to level {self.pool_level+1}.")
         self._pools.append(set())
 
-    def terminate_current_pool(self):
+    def terminate_current_pool(self) -> None:
         """Terminate all the shells in the current pool, and restore the previous pool if any.
 
         If any failure occurs while closing any shell, this is tolerated allowing the termination
diff --git a/dts/framework/remote_session/testpmd_shell.py b/dts/framework/remote_session/testpmd_shell.py
index ad8cb273dc..58655c96b1 100644
--- a/dts/framework/remote_session/testpmd_shell.py
+++ b/dts/framework/remote_session/testpmd_shell.py
@@ -22,7 +22,16 @@
 from enum import Flag, auto
 from os import environ
 from pathlib import PurePath
-from typing import TYPE_CHECKING, Any, ClassVar, Concatenate, Literal, ParamSpec, Tuple, TypeAlias
+from typing import (
+    TYPE_CHECKING,
+    Any,
+    ClassVar,
+    Concatenate,
+    Literal,
+    ParamSpec,
+    Tuple,
+    TypeAlias,
+)
 
 from framework.context import get_ctx
 from framework.remote_session.interactive_shell import only_active
@@ -64,7 +73,7 @@ class TestPmdDevice:
 
     pci_address: str
 
-    def __init__(self, pci_address_line: str):
+    def __init__(self, pci_address_line: str) -> None:
         """Initialize the device from the testpmd output line string.
 
         Args:
@@ -90,7 +99,7 @@ class VLANOffloadFlag(Flag):
     QINQ_STRIP = auto()
 
     @classmethod
-    def from_str_dict(cls, d):
+    def from_str_dict(cls, d) -> Self:
         """Makes an instance from a dict containing the flag member names with an "on" value.
 
         Args:
@@ -405,7 +414,7 @@ def make_device_private_info_parser() -> ParserFn:
             function that parses the device private info from the TestPmd port info output.
     """
 
-    def _validate(info: str):
+    def _validate(info: str) -> str | None:
         info = info.strip()
         if info == "none" or info.startswith("Invalid file") or info.startswith("Failed to dump"):
             return None
@@ -1449,7 +1458,7 @@ def requires_stopped_ports(func: TestPmdShellMethod) -> TestPmdShellMethod:
     """
 
     @functools.wraps(func)
-    def _wrapper(self: "TestPmdShell", *args: P.args, **kwargs: P.kwargs):
+    def _wrapper(self: "TestPmdShell", *args: P.args, **kwargs: P.kwargs) -> Any:
         if self.ports_started:
             self._logger.debug("Ports need to be stopped to continue.")
             self.stop_all_ports()
@@ -1470,7 +1479,7 @@ def requires_started_ports(func: TestPmdShellMethod) -> TestPmdShellMethod:
     """
 
     @functools.wraps(func)
-    def _wrapper(self: "TestPmdShell", *args: P.args, **kwargs: P.kwargs):
+    def _wrapper(self: "TestPmdShell", *args: P.args, **kwargs: P.kwargs) -> Any:
         if not self.ports_started:
             self._logger.debug("Ports need to be started to continue.")
             self.start_all_ports()
@@ -1492,7 +1501,7 @@ def add_remove_mtu(mtu: int = 1500) -> Callable[[TestPmdShellMethod], TestPmdShe
 
     def decorator(func: TestPmdShellMethod) -> TestPmdShellMethod:
         @functools.wraps(func)
-        def wrapper(self: "TestPmdShell", *args: P.args, **kwargs: P.kwargs):
+        def wrapper(self: "TestPmdShell", *args: P.args, **kwargs: P.kwargs) -> Any:
             original_mtu = self.ports[0].mtu
             self.set_port_mtu_all(mtu=mtu, verify=False)
             retval = func(self, *args, **kwargs)
@@ -1644,7 +1653,7 @@ def wait_link_status_up(self, port_id: int, timeout=SETTINGS.timeout) -> bool:
             self._logger.error(f"The link for port {port_id} did not come up in the given timeout.")
         return "Link status: up" in port_info
 
-    def set_forward_mode(self, mode: SimpleForwardingModes, verify: bool = True):
+    def set_forward_mode(self, mode: SimpleForwardingModes, verify: bool = True) -> None:
         """Set packet forwarding mode.
 
         Args:
diff --git a/dts/framework/runner.py b/dts/framework/runner.py
index 0a3d92b0c8..4f2c05bd2f 100644
--- a/dts/framework/runner.py
+++ b/dts/framework/runner.py
@@ -31,7 +31,7 @@ class DTSRunner:
     _logger: DTSLogger
     _result: TestRunResult
 
-    def __init__(self):
+    def __init__(self) -> None:
         """Initialize the instance with configuration, logger, result and string constants."""
         try:
             self._configuration = load_config(ValidationContext(settings=SETTINGS))
diff --git a/dts/framework/settings.py b/dts/framework/settings.py
index 3f21615223..b7dbf0bba6 100644
--- a/dts/framework/settings.py
+++ b/dts/framework/settings.py
@@ -237,7 +237,7 @@ def find_action(
 
         return action
 
-    def error(self, message):
+    def error(self, message) -> None:
         """Augments :meth:`~argparse.ArgumentParser.error` with environment variable awareness."""
         for action in self._actions:
             if _is_from_env(action):
@@ -257,7 +257,7 @@ def error(self, message):
 class _EnvVarHelpFormatter(ArgumentDefaultsHelpFormatter):
     """Custom formatter to add environment variables to the help page."""
 
-    def _get_help_string(self, action):
+    def _get_help_string(self, action) -> str | None:
         """Overrides :meth:`ArgumentDefaultsHelpFormatter._get_help_string`."""
         help = super()._get_help_string(action)
 
diff --git a/dts/framework/test_result.py b/dts/framework/test_result.py
index 8ce6cc8fbf..f6ae91c142 100644
--- a/dts/framework/test_result.py
+++ b/dts/framework/test_result.py
@@ -77,13 +77,13 @@ class ResultLeaf(BaseModel):
     result: Result
     reason: DTSError | None = None
 
-    def __lt__(self, other):
+    def __lt__(self, other) -> bool:
         """Compare another instance of the same class by :attr:`~ResultLeaf.result`."""
         if isinstance(other, ResultLeaf):
             return self.result < other.result
         return True
 
-    def __eq__(self, other):
+    def __eq__(self, other) -> bool:
         """Compare equality with compatible classes by :attr:`~ResultLeaf.result`."""
         match other:
             case ResultLeaf(result=result):
diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py
index 4355aeeb4b..48f05e292b 100644
--- a/dts/framework/test_run.py
+++ b/dts/framework/test_run.py
@@ -178,7 +178,7 @@ def __init__(
         tests_config: dict[str, BaseConfig],
         nodes: Iterable[Node],
         result: TestRunResult,
-    ):
+    ) -> None:
         """Test run constructor.
 
         Args:
@@ -226,7 +226,7 @@ def required_capabilities(self) -> set[Capability]:
 
         return caps
 
-    def spin(self):
+    def spin(self) -> None:
         """Spin the internal state machine that executes the test run."""
         self.logger.info(f"Running test run with SUT '{self.ctx.sut_node.name}'.")
 
@@ -258,11 +258,11 @@ class State(Protocol):
     test_run: TestRun
     result: TestRunResult | ResultNode
 
-    def before(self):
+    def before(self) -> None:
         """Hook before the state is processed."""
         self.logger.set_stage(self.logger_name, self.log_file_path)
 
-    def after(self):
+    def after(self) -> None:
         """Hook after the state is processed."""
         return
 
@@ -577,7 +577,7 @@ def on_error(self, ex: Exception) -> State | None:
         self.result.mark_step_as("teardown", Result.ERROR, ex)
         return TestRunExecution(self.test_run, self.test_run.result)
 
-    def after(self):
+    def after(self) -> None:
         """Hook after state is processed."""
         if (
             self.result.get_overall_result() in [Result.FAIL, Result.ERROR]
diff --git a/dts/framework/test_suite.py b/dts/framework/test_suite.py
index d4e06a567a..7fe6a43b0e 100644
--- a/dts/framework/test_suite.py
+++ b/dts/framework/test_suite.py
@@ -92,7 +92,7 @@ class TestSuite(TestProtocol):
     _tg_ip_address_ingress: Union[IPv4Interface, IPv6Interface]
     _tg_ip_address_egress: Union[IPv4Interface, IPv6Interface]
 
-    def __init__(self, config: BaseConfig):
+    def __init__(self, config: BaseConfig) -> None:
         """Initialize the test suite testbed information and basic configuration.
 
         Args:
diff --git a/dts/framework/testbed_model/cpu.py b/dts/framework/testbed_model/cpu.py
index b8bc601c22..6e2ecca080 100644
--- a/dts/framework/testbed_model/cpu.py
+++ b/dts/framework/testbed_model/cpu.py
@@ -80,7 +80,7 @@ class LogicalCoreList:
     _lcore_list: list[int]
     _lcore_str: str
 
-    def __init__(self, lcore_list: list[int] | list[str] | list[LogicalCore] | str):
+    def __init__(self, lcore_list: list[int] | list[str] | list[LogicalCore] | str) -> None:
         """Process `lcore_list`, then sort.
 
         There are four supported logical core list formats::
@@ -169,7 +169,7 @@ def __init__(
         lcore_list: list[LogicalCore],
         filter_specifier: LogicalCoreCount | LogicalCoreList,
         ascending: bool = True,
-    ):
+    ) -> None:
         """Filter according to the input filter specifier.
 
         The input `lcore_list` is copied and sorted by physical core before filtering.
diff --git a/dts/framework/testbed_model/node.py b/dts/framework/testbed_model/node.py
index 35cf6f1452..4f6150f18c 100644
--- a/dts/framework/testbed_model/node.py
+++ b/dts/framework/testbed_model/node.py
@@ -59,7 +59,7 @@ class Node:
     _compiler_version: str | None
     _setup: bool
 
-    def __init__(self, node_config: NodeConfiguration):
+    def __init__(self, node_config: NodeConfiguration) -> None:
         """Connect to the node and gather info during initialization.
 
         Extra gathered information:
diff --git a/dts/framework/testbed_model/os_session.py b/dts/framework/testbed_model/os_session.py
index b6e03aa83d..b182c3bde4 100644
--- a/dts/framework/testbed_model/os_session.py
+++ b/dts/framework/testbed_model/os_session.py
@@ -115,7 +115,7 @@ def __init__(
         node_config: NodeConfiguration,
         name: str,
         logger: DTSLogger,
-    ):
+    ) -> None:
         """Initialize the OS-aware session.
 
         Connect to the node right away and also create an interactive remote session.
diff --git a/dts/framework/testbed_model/port.py b/dts/framework/testbed_model/port.py
index fc58e2b993..2c0276971f 100644
--- a/dts/framework/testbed_model/port.py
+++ b/dts/framework/testbed_model/port.py
@@ -49,7 +49,7 @@ class Port:
     config: Final[PortConfig]
     _original_driver: str | None
 
-    def __init__(self, node: "Node", config: PortConfig):
+    def __init__(self, node: "Node", config: PortConfig) -> None:
         """Initialize the port from `node` and `config`.
 
         Args:
@@ -128,7 +128,7 @@ def bound_for_dpdk(self) -> bool:
         """Is the port bound to the driver for DPDK?"""
         return self.current_driver == self.config.os_driver_for_dpdk
 
-    def configure_mtu(self, mtu: int):
+    def configure_mtu(self, mtu: int) -> None:
         """Configure the port's MTU value.
 
         Args:
diff --git a/dts/framework/testbed_model/traffic_generator/scapy.py b/dts/framework/testbed_model/traffic_generator/scapy.py
index e21ba4ed96..40030abe7b 100644
--- a/dts/framework/testbed_model/traffic_generator/scapy.py
+++ b/dts/framework/testbed_model/traffic_generator/scapy.py
@@ -57,7 +57,7 @@ class ScapyAsyncSniffer(PythonShell):
 
     def __init__(
         self, node: Node, recv_port: Port, name: str | None = None, privileged: bool = True
-    ):
+    ) -> None:
         """Sniffer constructor.
 
         Args:
@@ -189,7 +189,7 @@ def close(self) -> None:
         self._sniffer.join()
         super().close()
 
-    def _sniff(self, recv_port: Port):
+    def _sniff(self, recv_port: Port) -> None:
         """Sniff packets and use events and queue to communicate with the main thread.
 
         Raises:
@@ -229,7 +229,7 @@ def _sniff(self, recv_port: Port):
         self._logger.debug("Stop sniffing.")
         self.send_command("\x03")  # send Ctrl+C to trigger a KeyboardInterrupt in `sniff`.
 
-    def _set_packet_filter(self, filter_config: PacketFilteringConfig):
+    def _set_packet_filter(self, filter_config: PacketFilteringConfig) -> None:
         """Make and set a filtering function from `filter_config`.
 
         Args:
@@ -296,7 +296,7 @@ class also extends :class:`.capturing_traffic_generator.CapturingTrafficGenerato
     #: Padding to add to the start of a line for python syntax compliance.
     _python_indentation: ClassVar[str] = " " * 4
 
-    def __init__(self, tg_node: Node, config: ScapyTrafficGeneratorConfig, **kwargs):
+    def __init__(self, tg_node: Node, config: ScapyTrafficGeneratorConfig, **kwargs) -> None:
         """Extend the constructor with Scapy TG specifics.
 
         Initializes both the traffic generator and the interactive shell used to handle Scapy
@@ -315,7 +315,7 @@ def __init__(self, tg_node: Node, config: ScapyTrafficGeneratorConfig, **kwargs)
 
         super().__init__(tg_node=tg_node, config=config, **kwargs)
 
-    def setup(self, topology: Topology):
+    def setup(self, topology: Topology) -> None:
         """Extends :meth:`.traffic_generator.TrafficGenerator.setup`.
 
         Binds the TG node ports to the kernel drivers and starts up the async sniffer.
@@ -332,7 +332,7 @@ def setup(self, topology: Topology):
         self._shell.send_command("from scapy.all import *")
         self._shell.send_command("from scapy.contrib.lldp import *")
 
-    def close(self):
+    def close(self) -> None:
         """Overrides :meth:`.traffic_generator.TrafficGenerator.close`.
 
         Stops the traffic generator and sniffer shells.
diff --git a/dts/framework/testbed_model/traffic_generator/traffic_generator.py b/dts/framework/testbed_model/traffic_generator/traffic_generator.py
index 8f53b07daf..a4bea71bbf 100644
--- a/dts/framework/testbed_model/traffic_generator/traffic_generator.py
+++ b/dts/framework/testbed_model/traffic_generator/traffic_generator.py
@@ -34,7 +34,7 @@ class TrafficGenerator(ABC):
     _tg_node: Node
     _logger: DTSLogger
 
-    def __init__(self, tg_node: Node, config: TrafficGeneratorConfig, **kwargs):
+    def __init__(self, tg_node: Node, config: TrafficGeneratorConfig, **kwargs) -> None:
         """Initialize the traffic generator.
 
         Additional keyword arguments can be passed through `kwargs` if needed for fulfilling other
@@ -49,10 +49,10 @@ def __init__(self, tg_node: Node, config: TrafficGeneratorConfig, **kwargs):
         self._tg_node = tg_node
         self._logger = get_dts_logger(f"{self._tg_node.name} {self._config.type}")
 
-    def setup(self, topology: Topology):
+    def setup(self, topology: Topology) -> None:
         """Setup the traffic generator."""
 
-    def teardown(self):
+    def teardown(self) -> None:
         """Teardown the traffic generator."""
         self.close()
 
diff --git a/dts/framework/testbed_model/virtual_device.py b/dts/framework/testbed_model/virtual_device.py
index 569d67b007..1a4794e695 100644
--- a/dts/framework/testbed_model/virtual_device.py
+++ b/dts/framework/testbed_model/virtual_device.py
@@ -16,7 +16,7 @@ class VirtualDevice:
 
     name: str
 
-    def __init__(self, name: str):
+    def __init__(self, name: str) -> None:
         """Initialize the virtual device.
 
         Args:
diff --git a/dts/framework/utils.py b/dts/framework/utils.py
index 0c81ab1b95..ebf1a1993c 100644
--- a/dts/framework/utils.py
+++ b/dts/framework/utils.py
@@ -99,7 +99,7 @@ class MesonArgs:
 
     _default_library: str
 
-    def __init__(self, default_library: str | None = None, **dpdk_args: str | bool):
+    def __init__(self, default_library: str | None = None, **dpdk_args: str | bool) -> None:
         """Initialize the meson arguments.
 
         Args:
@@ -147,7 +147,7 @@ class TarCompressionFormat(StrEnum):
     zstd = "zst"
 
     @property
-    def extension(self):
+    def extension(self) -> str:
         """Return the extension associated with the compression format.
 
         If the compression format is 'none', the extension will be in the format 'tar'.
@@ -213,7 +213,7 @@ def filter_func(tarinfo: tarfile.TarInfo) -> tarfile.TarInfo | None:
     return target_tarball_path
 
 
-def extract_tarball(tar_path: str | Path):
+def extract_tarball(tar_path: str | Path) -> None:
     """Extract the contents of a tarball.
 
     The tarball will be extracted in the same path as `tar_path` parent path.
diff --git a/dts/tests/TestSuite_blocklist.py b/dts/tests/TestSuite_blocklist.py
index ce7da1cc8f..c668bcd86c 100644
--- a/dts/tests/TestSuite_blocklist.py
+++ b/dts/tests/TestSuite_blocklist.py
@@ -16,7 +16,7 @@
 class TestBlocklist(TestSuite):
     """DPDK device blocklisting test suite."""
 
-    def verify_blocklisted_ports(self, ports_to_block: list[Port]):
+    def verify_blocklisted_ports(self, ports_to_block: list[Port]) -> None:
         """Runs testpmd with the given ports blocklisted and verifies the ports."""
         with TestPmdShell(allowed_ports=[], blocked_ports=ports_to_block) as testpmd:
             allowlisted_ports = {port.device_name for port in testpmd.show_port_info_all()}
@@ -30,7 +30,7 @@ def verify_blocklisted_ports(self, ports_to_block: list[Port]):
             self.verify(blocked, "At least one port was not blocklisted")
 
     @func_test
-    def no_blocklisted(self):
+    def no_blocklisted(self) -> None:
         """Run testpmd with no blocklisted device.
 
         Steps:
@@ -41,7 +41,7 @@ def no_blocklisted(self):
         self.verify_blocklisted_ports([])
 
     @func_test
-    def one_port_blocklisted(self):
+    def one_port_blocklisted(self) -> None:
         """Run testpmd with one blocklisted port.
 
         Steps:
@@ -52,7 +52,7 @@ def one_port_blocklisted(self):
         self.verify_blocklisted_ports(self.topology.sut_ports[:1])
 
     @func_test
-    def all_but_one_port_blocklisted(self):
+    def all_but_one_port_blocklisted(self) -> None:
         """Run testpmd with all but one blocklisted port.
 
         Steps:
diff --git a/dts/tests/TestSuite_dynamic_queue_conf.py b/dts/tests/TestSuite_dynamic_queue_conf.py
index f8c7dbfb71..b5077f7d06 100644
--- a/dts/tests/TestSuite_dynamic_queue_conf.py
+++ b/dts/tests/TestSuite_dynamic_queue_conf.py
@@ -277,24 +277,24 @@ def stop_queues(
 
     @requires(NicCapability.RUNTIME_RX_QUEUE_SETUP)
     @func_test
-    def test_rx_queue_stop(self):
+    def test_rx_queue_stop(self) -> None:
         """Run method for stopping queues with flag for Rx testing set to :data:`True`."""
         self.stop_queues(True)
 
     @requires(NicCapability.RUNTIME_RX_QUEUE_SETUP)
     @func_test
-    def test_rx_queue_configuration(self):
+    def test_rx_queue_configuration(self) -> None:
         """Run method for configuring queues with flag for Rx testing set to :data:`True`."""
         self.modify_ring_size(True)
 
     @requires(NicCapability.RUNTIME_TX_QUEUE_SETUP)
     @func_test
-    def test_tx_queue_stop(self):
+    def test_tx_queue_stop(self) -> None:
         """Run method for stopping queues with flag for Rx testing set to :data:`False`."""
         self.stop_queues(False)
 
     @requires(NicCapability.RUNTIME_TX_QUEUE_SETUP)
     @func_test
-    def test_tx_queue_configuration(self):
+    def test_tx_queue_configuration(self) -> None:
         """Run method for configuring queues with flag for Rx testing set to :data:`False`."""
         self.modify_ring_size(False)
-- 
2.50.1

