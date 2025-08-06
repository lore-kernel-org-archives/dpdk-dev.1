Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDFBAC87FCB
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 Aug 2025 16:29:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AA64840291;
	Wed,  6 Aug 2025 18:29:38 +0200 (CEST)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com
 [209.85.160.175])
 by mails.dpdk.org (Postfix) with ESMTP id 1DF86400D6
 for <dev@dpdk.org>; Wed,  6 Aug 2025 18:29:37 +0200 (CEST)
Received: by mail-qt1-f175.google.com with SMTP id
 d75a77b69052e-4aeb2f73fc0so976891cf.2
 for <dev@dpdk.org>; Wed, 06 Aug 2025 09:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1754497776; x=1755102576; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uXTx+PnWzGyFA5wLMJFeI3aOZQPkFFi7uFVlhq1MkHc=;
 b=RKbaHoQzkVrDSGnF6ioOz2n3RpqFGP30TfGJ4ZI7Ic9SXSzq76DVggfkJsPvlwZPWU
 wcj3gN5Jq7xf6REYL39bTPYkifImC/218pwLJIHdKlczTao8kajItdSkvVVWyUic65Um
 4CU8VAdRwNVp/wzl4YoUQ33OFP26eucWrFgX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754497776; x=1755102576;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uXTx+PnWzGyFA5wLMJFeI3aOZQPkFFi7uFVlhq1MkHc=;
 b=wceKYGI5pBc1zNJZoQqjbHvi9r42JxDLjBCc+7U/tKshn186OFUYjtc6rl0vPUH0RP
 CkyDPwXtkn1ZAEAAIUCCY93oYPNjpQOl6GIdVO89Nmw5uZOOLWYFVVh4I4uXhhIpe02k
 URzWVCDuvEVElnOHzv/u3OXLxzP3uaXdhAAorG02tz161VtPfXIrYBIaGHwX0YPkD1UL
 le0K1yMPZLOeli3wWu5YsjVVlqdKkdwMBnM7tjdpupekS7MBbVytw7Rn8a02LacZEMG5
 5bMTlm9Y1cDuAYVPs8jM7dyZEYOCuL5Rpb3mrNouOrqirsfjvghzP5PUbPj79ILsvXU1
 kt4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTVklU9EOn2Vql62arOnbGFxqYVhdqBrVFCUUtvwDU9VUkh5JnoN3EfhdzaLMVrN0sMwk=@dpdk.org
X-Gm-Message-State: AOJu0YylnAjGymyl1D/Je1o/NEQYmHGIMxNqvgositfZFiF88jKuIDig
 5ElpxlBkcMoxriC31B/Sd9a6cXOBidec4H0gYJ40yoqy2KW6C6vHrCzyGgpThyC1bKE=
X-Gm-Gg: ASbGnctzJ4SXKeNDi5fU9pvYnU5xrqJPOmWmsOExskmRkXls9CXxHMYKWI599OqansZ
 MAtQ/1fTdeGcu7XD6xFSQgyyIYObly9kHKhQQMMK0S7u9HsUplKAQetmfiQSn/XsNJgrcEqqT/T
 WQ3VgLsxGGMCKBLBsgiBSpnayuQ7+Lqlk3zErzu2yIzoENloe7ERlPmDL6qf/m6KbLIJDviobPw
 FI21bCNAIrZPup/ijqLzDQptqCcv+nGyM+RRgEVpxqQFzPYsJ1vTJxDcbT3I1lHNri7L4ZpZ5Ee
 yfMoioojAO/bug7kL59DnKRrnPe+5nXI/7BwOr0Or6A9ALlckvL17oIPbGkVShtMAbdc0o5/YUo
 fHnRUBXfzMB6RjwCw3hRPtFVhnfUqs8Vp+2k=
X-Google-Smtp-Source: AGHT+IG8C1kmRIkJGJ+jYF+XnslfeboQYXUA3f8t6ig1ww9xlFDhTRvS1wQKaUGJ93jTIxqYTrvMBw==
X-Received: by 2002:ac8:5f8d:0:b0:494:b3eb:a4b9 with SMTP id
 d75a77b69052e-4b0915f2035mr46404731cf.51.1754497775750; 
 Wed, 06 Aug 2025 09:29:35 -0700 (PDT)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4af230d8a21sm49731261cf.51.2025.08.06.09.29.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 09:29:35 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com
Cc: abailey@iol.unh.edu, dev@dpdk.org, dmarx@iol.unh.edu, probb@iol.unh.edu
Subject: [PATCH v2] dts: type hints updated for method arguments and return
 types
Date: Wed,  6 Aug 2025 12:29:00 -0400
Message-ID: <20250806162900.273571-1-abailey@iol.unh.edu>
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

Mypy does not check functions and methods that are not entirely type
hinted. This prevents full checks, so they have been added where missing.
Full checks revealed typing errors. One was fixed in this patch, while
others were not applied and left not type hinted.

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
---
 dts/framework/context.py                      | 10 ++++---
 dts/framework/exception.py                    |  8 +++---
 dts/framework/logger.py                       |  6 ++---
 dts/framework/params/__init__.py              |  2 +-
 dts/framework/remote_session/dpdk.py          | 14 +++++-----
 .../remote_session/interactive_shell.py       |  6 ++---
 dts/framework/remote_session/python_shell.py  |  2 +-
 .../remote_session/remote_session.py          |  2 +-
 dts/framework/remote_session/shell_pool.py    | 10 +++----
 dts/framework/remote_session/testpmd_shell.py | 25 ++++++++++++------
 dts/framework/runner.py                       |  2 +-
 dts/framework/settings.py                     |  2 +-
 dts/framework/test_result.py                  |  4 +--
 dts/framework/test_run.py                     |  8 +++---
 dts/framework/test_suite.py                   |  4 +--
 dts/framework/testbed_model/capability.py     |  6 ++---
 dts/framework/testbed_model/cpu.py            |  4 +--
 dts/framework/testbed_model/node.py           |  2 +-
 dts/framework/testbed_model/os_session.py     |  8 +++---
 dts/framework/testbed_model/port.py           |  4 +--
 dts/framework/testbed_model/posix_session.py  |  9 ++++---
 .../testbed_model/traffic_generator/scapy.py  | 12 ++++-----
 .../traffic_generator/traffic_generator.py    |  8 +++---
 dts/framework/testbed_model/virtual_device.py |  2 +-
 dts/framework/utils.py                        | 26 +++++++++----------
 dts/tests/TestSuite_blocklist.py              |  8 +++---
 dts/tests/TestSuite_dynamic_queue_conf.py     |  8 +++---
 ...stSuite_port_restart_config_persistency.py |  2 +-
 28 files changed, 109 insertions(+), 95 deletions(-)

diff --git a/dts/framework/context.py b/dts/framework/context.py
index 4360bc8699..ba2fdf55b3 100644
--- a/dts/framework/context.py
+++ b/dts/framework/context.py
@@ -4,12 +4,14 @@
 """Runtime contexts."""
 
 import functools
+from collections.abc import Callable
 from dataclasses import MISSING, dataclass, field, fields
-from typing import TYPE_CHECKING, ParamSpec
+from typing import TYPE_CHECKING, ParamSpec, Type
 
 from framework.exception import InternalError
 from framework.remote_session.shell_pool import ShellPool
 from framework.settings import SETTINGS
+from framework.testbed_model.capability import TestProtocol
 from framework.testbed_model.cpu import LogicalCoreCount, LogicalCoreList
 from framework.testbed_model.node import Node
 from framework.testbed_model.topology import Topology
@@ -97,12 +99,12 @@ def init_ctx(ctx: Context) -> None:
 
 def filter_cores(
     specifier: LogicalCoreCount | LogicalCoreList, ascending_cores: bool | None = None
-):
+) -> Callable[[Callable], Callable[[], Type[TestProtocol]]]:
     """Decorates functions that require a temporary update to the lcore specifier."""
 
-    def decorator(func):
+    def decorator(func: Callable) -> Callable[[], Type[TestProtocol]]:
         @functools.wraps(func)
-        def wrapper(*args: P.args, **kwargs: P.kwargs):
+        def wrapper(*args: P.args, **kwargs: P.kwargs) -> Type[TestProtocol]:
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
index f43b442bc9..fe5737f285 100644
--- a/dts/framework/logger.py
+++ b/dts/framework/logger.py
@@ -15,7 +15,7 @@
 import logging
 from logging import FileHandler, StreamHandler
 from pathlib import Path
-from typing import ClassVar
+from typing import Any, ClassVar
 
 date_fmt = "%Y/%m/%d %H:%M:%S"
 stream_fmt = "%(asctime)s - %(stage)s - %(name)s - %(levelname)s - %(message)s"
@@ -36,12 +36,12 @@ class DTSLogger(logging.Logger):
     _stage: ClassVar[str] = "pre_run"
     _extra_file_handlers: list[FileHandler] = []
 
-    def __init__(self, *args, **kwargs):
+    def __init__(self, *args: str, **kwargs: str) -> None:
         """Extend the constructor with extra file handlers."""
         self._extra_file_handlers = []
         super().__init__(*args, **kwargs)
 
-    def makeRecord(self, *args, **kwargs) -> logging.LogRecord:
+    def makeRecord(self, *args: Any, **kwargs: Any) -> logging.LogRecord:
         """Generates a record with additional stage information.
 
         This is the default method for the :class:`~logging.Logger` class. We extend it
diff --git a/dts/framework/params/__init__.py b/dts/framework/params/__init__.py
index 1ae227d7b4..03476681ee 100644
--- a/dts/framework/params/__init__.py
+++ b/dts/framework/params/__init__.py
@@ -44,7 +44,7 @@ def _reduce_functions(funcs: Iterable[FnPtr]) -> FnPtr:
         FnPtr: A function that calls the given functions from left to right.
     """
 
-    def reduced_fn(value):
+    def reduced_fn(value: Any) -> Any:
         for fn in funcs:
             value = fn(value)
         return value
diff --git a/dts/framework/remote_session/dpdk.py b/dts/framework/remote_session/dpdk.py
index 606d6e22fe..6a0a8911c9 100644
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
@@ -155,7 +155,7 @@ def _copy_dpdk_tree(self, dpdk_tree_path: Path) -> None:
             dpdk_tree_path,
             self.remote_dpdk_tree_path,
             exclude=[".git", "*.o"],
-            compress_format=TarCompressionFormat.gzip,
+            compress_format=TarCompressionFormat.gz,
         )
 
     def _validate_remote_dpdk_tarball(self, dpdk_tarball: PurePath) -> None:
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
diff --git a/dts/framework/remote_session/interactive_shell.py b/dts/framework/remote_session/interactive_shell.py
index ba8489eafa..ce93247051 100644
--- a/dts/framework/remote_session/interactive_shell.py
+++ b/dts/framework/remote_session/interactive_shell.py
@@ -24,7 +24,7 @@
 from abc import ABC, abstractmethod
 from collections.abc import Callable
 from pathlib import PurePath
-from typing import ClassVar, Concatenate, ParamSpec, TypeAlias, TypeVar
+from typing import Any, ClassVar, Concatenate, ParamSpec, TypeAlias, TypeVar
 
 from paramiko import Channel, channel
 from typing_extensions import Self
@@ -126,7 +126,7 @@ def __init__(
         self._privileged = privileged
         self._timeout = SETTINGS.timeout
 
-    def _setup_ssh_channel(self):
+    def _setup_ssh_channel(self) -> None:
         self._ssh_channel = self._node.main_session.interactive_session.session.invoke_shell()
         self._stdin = self._ssh_channel.makefile_stdin("w")
         self._stdout = self._ssh_channel.makefile("r")
@@ -277,7 +277,7 @@ def __enter__(self) -> Self:
         self.start_application()
         return self
 
-    def __exit__(self, *_) -> None:
+    def __exit__(self, *_: Any) -> None:
         """Exit the context block.
 
         Upon exiting a context block with this class, we want to ensure that the instance of the
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
index ad8cb273dc..c80de55d34 100644
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
+    def from_str_dict(cls, d: dict) -> Self:
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
+    def _wrapper(self: "TestPmdShell", *args: P.args, **kwargs: P.kwargs) -> TestPmdShellMethod:
         if self.ports_started:
             self._logger.debug("Ports need to be stopped to continue.")
             self.stop_all_ports()
@@ -1470,7 +1479,7 @@ def requires_started_ports(func: TestPmdShellMethod) -> TestPmdShellMethod:
     """
 
     @functools.wraps(func)
-    def _wrapper(self: "TestPmdShell", *args: P.args, **kwargs: P.kwargs):
+    def _wrapper(self: "TestPmdShell", *args: P.args, **kwargs: P.kwargs) -> TestPmdShellMethod:
         if not self.ports_started:
             self._logger.debug("Ports need to be started to continue.")
             self.start_all_ports()
@@ -1492,7 +1501,7 @@ def add_remove_mtu(mtu: int = 1500) -> Callable[[TestPmdShellMethod], TestPmdShe
 
     def decorator(func: TestPmdShellMethod) -> TestPmdShellMethod:
         @functools.wraps(func)
-        def wrapper(self: "TestPmdShell", *args: P.args, **kwargs: P.kwargs):
+        def wrapper(self: "TestPmdShell", *args: P.args, **kwargs: P.kwargs) -> TestPmdShellMethod:
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
index 3f21615223..5ca7e68833 100644
--- a/dts/framework/settings.py
+++ b/dts/framework/settings.py
@@ -257,7 +257,7 @@ def error(self, message):
 class _EnvVarHelpFormatter(ArgumentDefaultsHelpFormatter):
     """Custom formatter to add environment variables to the help page."""
 
-    def _get_help_string(self, action):
+    def _get_help_string(self, action: Action) -> str | None:
         """Overrides :meth:`ArgumentDefaultsHelpFormatter._get_help_string`."""
         help = super()._get_help_string(action)
 
diff --git a/dts/framework/test_result.py b/dts/framework/test_result.py
index 8ce6cc8fbf..78fd9e5ea4 100644
--- a/dts/framework/test_result.py
+++ b/dts/framework/test_result.py
@@ -77,13 +77,13 @@ class ResultLeaf(BaseModel):
     result: Result
     reason: DTSError | None = None
 
-    def __lt__(self, other):
+    def __lt__(self, other: object) -> bool:
         """Compare another instance of the same class by :attr:`~ResultLeaf.result`."""
         if isinstance(other, ResultLeaf):
             return self.result < other.result
         return True
 
-    def __eq__(self, other):
+    def __eq__(self, other: object) -> bool:
         """Compare equality with compatible classes by :attr:`~ResultLeaf.result`."""
         match other:
             case ResultLeaf(result=result):
diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py
index 4355aeeb4b..f5f0834dc3 100644
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
index d4e06a567a..5ee5a039d7 100644
--- a/dts/framework/test_suite.py
+++ b/dts/framework/test_suite.py
@@ -92,7 +92,7 @@ class TestSuite(TestProtocol):
     _tg_ip_address_ingress: Union[IPv4Interface, IPv6Interface]
     _tg_ip_address_egress: Union[IPv4Interface, IPv6Interface]
 
-    def __init__(self, config: BaseConfig):
+    def __init__(self, config: BaseConfig) -> None:
         """Initialize the test suite testbed information and basic configuration.
 
         Args:
@@ -681,7 +681,7 @@ def class_obj(self) -> type[TestSuite]:
             InternalError: If the test suite class is missing from the module.
         """
 
-        def is_test_suite(obj) -> bool:
+        def is_test_suite(obj: type) -> bool:
             """Check whether `obj` is a :class:`TestSuite`.
 
             The `obj` is a subclass of :class:`TestSuite`, but not :class:`TestSuite` itself.
diff --git a/dts/framework/testbed_model/capability.py b/dts/framework/testbed_model/capability.py
index f895b22bb3..db5753405b 100644
--- a/dts/framework/testbed_model/capability.py
+++ b/dts/framework/testbed_model/capability.py
@@ -385,7 +385,7 @@ def __eq__(self, other) -> bool:
         """
         return self.topology_type == other.topology_type
 
-    def __lt__(self, other) -> bool:
+    def __lt__(self, other: Self) -> bool:
         """Compare the :attr:`~TopologyCapability.topology_type`s.
 
         Args:
@@ -396,7 +396,7 @@ def __lt__(self, other) -> bool:
         """
         return self.topology_type < other.topology_type
 
-    def __gt__(self, other) -> bool:
+    def __gt__(self, other: Self) -> bool:
         """Compare the :attr:`~TopologyCapability.topology_type`s.
 
         Args:
@@ -407,7 +407,7 @@ def __gt__(self, other) -> bool:
         """
         return other < self
 
-    def __le__(self, other) -> bool:
+    def __le__(self, other: Self) -> bool:
         """Compare the :attr:`~TopologyCapability.topology_type`s.
 
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
index b6e03aa83d..de507ffe6a 100644
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
@@ -266,7 +266,7 @@ def copy_dir_from(
         self,
         source_dir: str | PurePath,
         destination_dir: str | Path,
-        compress_format: TarCompressionFormat = TarCompressionFormat.none,
+        compress_format: TarCompressionFormat = TarCompressionFormat.tar,
         exclude: str | list[str] | None = None,
     ) -> None:
         """Copy a directory from the remote node to the local filesystem.
@@ -306,7 +306,7 @@ def copy_dir_to(
         self,
         source_dir: str | Path,
         destination_dir: str | PurePath,
-        compress_format: TarCompressionFormat = TarCompressionFormat.none,
+        compress_format: TarCompressionFormat = TarCompressionFormat.tar,
         exclude: str | list[str] | None = None,
     ) -> None:
         """Copy a directory from the local filesystem to the remote node.
@@ -375,7 +375,7 @@ def remove_remote_dir(
     def create_remote_tarball(
         self,
         remote_dir_path: str | PurePath,
-        compress_format: TarCompressionFormat = TarCompressionFormat.none,
+        compress_format: TarCompressionFormat = TarCompressionFormat.tar,
         exclude: str | list[str] | None = None,
     ) -> PurePosixPath:
         """Create a tarball from the contents of the specified remote directory.
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
diff --git a/dts/framework/testbed_model/posix_session.py b/dts/framework/testbed_model/posix_session.py
index c71bc93f0b..992017f113 100644
--- a/dts/framework/testbed_model/posix_session.py
+++ b/dts/framework/testbed_model/posix_session.py
@@ -15,6 +15,7 @@
 import re
 from collections.abc import Iterable
 from pathlib import Path, PurePath, PurePosixPath
+from typing import Any
 
 from framework.exception import DPDKBuildError, RemoteCommandExecutionError
 from framework.settings import SETTINGS
@@ -116,7 +117,7 @@ def copy_dir_from(
         self,
         source_dir: str | PurePath,
         destination_dir: str | Path,
-        compress_format: TarCompressionFormat = TarCompressionFormat.none,
+        compress_format: TarCompressionFormat = TarCompressionFormat.tar,
         exclude: str | list[str] | None = None,
     ) -> None:
         """Overrides :meth:`~.os_session.OSSession.copy_dir_from`."""
@@ -135,7 +136,7 @@ def copy_dir_to(
         self,
         source_dir: str | Path,
         destination_dir: str | PurePath,
-        compress_format: TarCompressionFormat = TarCompressionFormat.none,
+        compress_format: TarCompressionFormat = TarCompressionFormat.tar,
         exclude: str | list[str] | None = None,
     ) -> None:
         """Overrides :meth:`~.os_session.OSSession.copy_dir_to`."""
@@ -178,12 +179,12 @@ def remove_remote_dir(
     def create_remote_tarball(
         self,
         remote_dir_path: str | PurePath,
-        compress_format: TarCompressionFormat = TarCompressionFormat.none,
+        compress_format: TarCompressionFormat = TarCompressionFormat.tar,
         exclude: str | list[str] | None = None,
     ) -> PurePosixPath:
         """Overrides :meth:`~.os_session.OSSession.create_remote_tarball`."""
 
-        def generate_tar_exclude_args(exclude_patterns) -> str:
+        def generate_tar_exclude_args(exclude_patterns: Any) -> str:
             """Generate args to exclude patterns when creating a tarball.
 
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
index 8f53b07daf..8b5fa98b89 100644
--- a/dts/framework/testbed_model/traffic_generator/traffic_generator.py
+++ b/dts/framework/testbed_model/traffic_generator/traffic_generator.py
@@ -34,7 +34,9 @@ class TrafficGenerator(ABC):
     _tg_node: Node
     _logger: DTSLogger
 
-    def __init__(self, tg_node: Node, config: TrafficGeneratorConfig, **kwargs):
+    def __init__(
+        self, tg_node: Node, config: TrafficGeneratorConfig, **kwargs: Node | TrafficGeneratorConfig
+    ) -> None:
         """Initialize the traffic generator.
 
         Additional keyword arguments can be passed through `kwargs` if needed for fulfilling other
@@ -49,10 +51,10 @@ def __init__(self, tg_node: Node, config: TrafficGeneratorConfig, **kwargs):
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
index 0c81ab1b95..51f9a3c541 100644
--- a/dts/framework/utils.py
+++ b/dts/framework/utils.py
@@ -19,7 +19,7 @@
 import os
 import random
 import tarfile
-from enum import Enum, Flag
+from enum import Enum, Flag, auto
 from pathlib import Path
 from typing import Any, Callable
 
@@ -136,15 +136,15 @@ class TarCompressionFormat(StrEnum):
     Its value is set to 'tar' to indicate that the file is an uncompressed tar archive.
     """
 
-    none = "tar"
-    gzip = "gz"
-    compress = "Z"
-    bzip2 = "bz2"
-    lzip = "lz"
-    lzma = "lzma"
-    lzop = "lzo"
-    xz = "xz"
-    zstd = "zst"
+    tar = auto()
+    gz = auto()
+    Z = auto()
+    bz2 = auto()
+    lz = auto()
+    lzma = auto()
+    lzo = auto()
+    xz = auto()
+    zst = auto()
 
     @property
     def extension(self):
@@ -154,7 +154,7 @@ def extension(self):
         For other compression formats, the extension will be in the format
         'tar.{compression format}'.
         """
-        return f"{self.value}" if self == self.none else f"{self.none.value}.{self.value}"
+        return f"{self.value}" if self == self.tar else f"{self.tar.value}.{self.value}"
 
 
 def convert_to_list_of_string(value: Any | list[Any]) -> list[str]:
@@ -164,7 +164,7 @@ def convert_to_list_of_string(value: Any | list[Any]) -> list[str]:
 
 def create_tarball(
     dir_path: Path,
-    compress_format: TarCompressionFormat = TarCompressionFormat.none,
+    compress_format: TarCompressionFormat = TarCompressionFormat.tar,
     exclude: Any | list[Any] | None = None,
 ) -> Path:
     """Create a tarball from the contents of the specified directory.
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
diff --git a/dts/tests/TestSuite_port_restart_config_persistency.py b/dts/tests/TestSuite_port_restart_config_persistency.py
index 42ea221586..b773bdfade 100644
--- a/dts/tests/TestSuite_port_restart_config_persistency.py
+++ b/dts/tests/TestSuite_port_restart_config_persistency.py
@@ -21,7 +21,7 @@
 class TestPortRestartConfigPersistency(TestSuite):
     """Port config persistency test suite."""
 
-    def restart_port_and_verify(self, id, testpmd, changed_value) -> None:
+    def restart_port_and_verify(self, id: int, testpmd: TestPmdShell, changed_value: str) -> None:
         """Fetch port config, restart and verify persistency."""
         testpmd.start_all_ports()
         testpmd.wait_link_status_up(port_id=id, timeout=10)
-- 
2.50.1

