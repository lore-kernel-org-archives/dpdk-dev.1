Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471B2CA0EE4
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 16:51:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9687F40267;
	Mon, 18 Aug 2025 18:51:27 +0200 (CEST)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com
 [209.85.222.172])
 by mails.dpdk.org (Postfix) with ESMTP id 6ABE140262
 for <dev@dpdk.org>; Mon, 18 Aug 2025 18:51:25 +0200 (CEST)
Received: by mail-qk1-f172.google.com with SMTP id
 af79cd13be357-7e87067b15aso538001685a.3
 for <dev@dpdk.org>; Mon, 18 Aug 2025 09:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1755535885; x=1756140685; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gaKNDeSEkbUVovacyYiO/AjQf6IAVMm5NUCQN5KBbJo=;
 b=WMCc/myAYW9Iq4uiKcWZrJwAsfrp0iyndGqmOZ3/d8d/ud862E9a/nXtRZ3AcM2wgL
 Q3sa0RYRSOGvwtMIlR6fcPUq4cb9Jbk4xFB7fkowPCAU4sJgxLtdu0Le+0TP6K8llXB+
 wiXUngslWFl8pq7NNoSDvGueq1bg4uF6qbqJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755535885; x=1756140685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gaKNDeSEkbUVovacyYiO/AjQf6IAVMm5NUCQN5KBbJo=;
 b=nQC/srtc6P541dnmbCDKF89gxzKV+hzdNICOvKV4cN4MQR8W4TwUbUXUIg2+CZ+hxq
 KKxTJRNYH2vTa1+yE2DlFlCGpzTKvgd50ISuBo7SOUs7a8o977NtvqEL0N01ymTLiSoD
 QrSVMQB/uDxxmnlfe88KHE9towWcLZdt2hgVgy4IKqLVH1v8y6bF8kLEMmdUdb8I5JiQ
 Sjofr9M026OXHHZUyRswE74c1OXikIqe57Fg+i8kskmf/Dh5e4F3xD0CphLFjbhljKwq
 +3gu+hZ/CpvakIXT0Etlhps4M5/1bGOlC7MTye0bfi9GBAqi45xLgoA0B2d04z8dkL3S
 PrBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQ46qoqvLVazQQ2ZOxjHxyq5UIaELBLgElVMk35nDILZU7ZIfUxFUULsh+F8goxtFD4oU=@dpdk.org
X-Gm-Message-State: AOJu0Yzd5CF85i0VzGojyUEl0jmiZO4exNBh9m6aqhDooeV+ilQi5CAp
 PtBtRYnQnwQVGjHtWtzhCMwoHCT9RVAZTX4j7klAtzoS/TyjRtHfUfMZfAYEXA4DhbpZYDGcomS
 ZW3F6
X-Gm-Gg: ASbGncvF/BB5B3JMviNPcig/eSKOjR1VZ6HeV8UcR7D3XX4YcaVk+1H9bf0MZeHLwEv
 mLyoWeYfLlpvAoxDn4XZUHIwMJ6vEvXxmdbPKClPKiAdtW5UQWjn93leTWK+ZZTJ104rfkJrksW
 WJWTNcVmLiBRRJN6Q+8heuC+QP8xPLGFxkaGFhc26EiWRy0bIy/QhGQOUHS5+JC1Ujz1pbX0kv0
 WJEJwf7U72AHK7YwX42f8uk4Luqa3qa77ratJb/Q6P0lPC55TrtVGOCfdu/0XQQf98/dfTnx9Ej
 iQtg+D60iAThTHRmURmqUqBpYhtUe3Ql2LndgEUcTW1dX6/9f1E6oJgTfosqDsndifXQujx+baK
 3lbjsCJseX9C134GzH6jYU3WaNOzvlgH4jNw=
X-Google-Smtp-Source: AGHT+IE39czm2hfkGEnQxi95YcKnviAk1bPjX7r5G/o63uPeqb8H+B+WEOo3z0PYv3V/lNi6Vr1QoQ==
X-Received: by 2002:a05:620a:1a8d:b0:7e6:9753:db16 with SMTP id
 af79cd13be357-7e87df878bbmr1732439985a.14.1755535884070; 
 Mon, 18 Aug 2025 09:51:24 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:9fe3:eb14:f850:6555])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-70ba90bcc80sm55450156d6.32.2025.08.18.09.51.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 09:51:23 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com
Cc: abailey@iol.unh.edu, dev@dpdk.org, dmarx@iol.unh.edu, probb@iol.unh.edu
Subject: [PATCH v3] dts: add missing type hints to method signatures
Date: Mon, 18 Aug 2025 12:50:54 -0400
Message-ID: <20250818165054.447127-1-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250806162900.273571-1-abailey@iol.unh.edu>
References: <20250806162900.273571-1-abailey@iol.unh.edu>
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
Full checks revealed some typing errors, pattern matching was applied
where appropriate to ensure these types were handled properly.
Additionally, the linter raised an error "unable to assign to a method"
that occurred within a decorator trying to manipulate the str method of
a given class. This was changed to use the set_attr function to pass the
linter.

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
---
 .mailmap                                      |  1 +
 dts/framework/context.py                      | 10 +++++---
 dts/framework/exception.py                    |  8 +++---
 dts/framework/logger.py                       |  6 ++---
 dts/framework/params/__init__.py              |  9 ++++---
 dts/framework/remote_session/dpdk.py          | 12 ++++-----
 dts/framework/remote_session/dpdk_shell.py    |  9 +++++--
 .../interactive_remote_session.py             |  2 +-
 .../remote_session/interactive_shell.py       |  8 +++---
 dts/framework/remote_session/python_shell.py  |  2 +-
 .../remote_session/remote_session.py          |  6 ++---
 dts/framework/remote_session/shell_pool.py    | 12 ++++-----
 dts/framework/remote_session/testpmd_shell.py | 25 +++++++++++++------
 dts/framework/runner.py                       |  2 +-
 dts/framework/settings.py                     | 16 +++++++-----
 dts/framework/test_result.py                  |  4 +--
 dts/framework/test_run.py                     | 14 +++++------
 dts/framework/test_suite.py                   |  4 +--
 dts/framework/testbed_model/capability.py     | 10 ++++----
 dts/framework/testbed_model/cpu.py            |  6 ++---
 dts/framework/testbed_model/node.py           |  2 +-
 dts/framework/testbed_model/os_session.py     |  2 +-
 dts/framework/testbed_model/port.py           |  4 +--
 dts/framework/testbed_model/posix_session.py  |  2 +-
 .../testbed_model/traffic_generator/scapy.py  | 14 +++++------
 .../traffic_generator/traffic_generator.py    |  6 ++---
 dts/framework/testbed_model/virtual_device.py |  2 +-
 dts/framework/utils.py                        |  6 ++---
 dts/tests/TestSuite_blocklist.py              |  8 +++---
 dts/tests/TestSuite_dynamic_queue_conf.py     |  8 +++---
 ...stSuite_port_restart_config_persistency.py |  2 +-
 31 files changed, 121 insertions(+), 101 deletions(-)

diff --git a/.mailmap b/.mailmap
index 34a99f93a1..df06862d8b 100644
--- a/.mailmap
+++ b/.mailmap
@@ -104,6 +104,7 @@ Andre Muezerie <andremue@linux.microsoft.com> <andremue@microsoft.com>
 Andrea Arcangeli <aarcange@redhat.com>
 Andrea Grandi <andrea.grandi@intel.com>
 Andre Richter <andre.o.richter@gmail.com>
+Andrew Bailey <abailey@iol.unh.edu>
 Andrew Boyer <andrew.boyer@amd.com> <aboyer@pensando.io>
 Andrew Harvey <agh@cisco.com>
 Andrew Jackson <ajackson@solarflare.com>
diff --git a/dts/framework/context.py b/dts/framework/context.py
index 4360bc8699..f98d31d3c1 100644
--- a/dts/framework/context.py
+++ b/dts/framework/context.py
@@ -4,8 +4,9 @@
 """Runtime contexts."""
 
 import functools
+from collections.abc import Callable
 from dataclasses import MISSING, dataclass, field, fields
-from typing import TYPE_CHECKING, ParamSpec
+from typing import TYPE_CHECKING, Any, ParamSpec
 
 from framework.exception import InternalError
 from framework.remote_session.shell_pool import ShellPool
@@ -16,6 +17,7 @@
 
 if TYPE_CHECKING:
     from framework.remote_session.dpdk import DPDKBuildEnvironment, DPDKRuntimeEnvironment
+    from framework.testbed_model.capability import TestProtocol
     from framework.testbed_model.traffic_generator.traffic_generator import TrafficGenerator
 
 P = ParamSpec("P")
@@ -97,12 +99,12 @@ def init_ctx(ctx: Context) -> None:
 
 def filter_cores(
     specifier: LogicalCoreCount | LogicalCoreList, ascending_cores: bool | None = None
-):
+) -> Callable[[type["TestProtocol"]], Callable]:
     """Decorates functions that require a temporary update to the lcore specifier."""
 
-    def decorator(func):
+    def decorator(func: type["TestProtocol"]) -> Callable:
         @functools.wraps(func)
-        def wrapper(*args: P.args, **kwargs: P.kwargs):
+        def wrapper(*args: P.args, **kwargs: P.kwargs) -> Any:
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
index f43b442bc9..a0c81c3c47 100644
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
+    def __init__(self, *args: Any, **kwargs: Any) -> None:
         """Extend the constructor with extra file handlers."""
         self._extra_file_handlers = []
         super().__init__(*args, **kwargs)
 
-    def makeRecord(self, *args, **kwargs) -> logging.LogRecord:
+    def makeRecord(self, *args: Any, **kwargs: Any) -> logging.LogRecord:
         """Generates a record with additional stage information.
 
         This is the default method for the :class:`~logging.Logger` class. We extend it
diff --git a/dts/framework/params/__init__.py b/dts/framework/params/__init__.py
index 1ae227d7b4..360f85fbd1 100644
--- a/dts/framework/params/__init__.py
+++ b/dts/framework/params/__init__.py
@@ -25,7 +25,7 @@
 T = TypeVar("T")
 
 #: Type for a function taking one argument.
-FnPtr = Callable[[Any], Any]
+FnPtr = Callable[[T], T]
 #: Type for a switch parameter.
 Switch = Literal[True, None]
 #: Type for a yes/no switch parameter.
@@ -44,7 +44,7 @@ def _reduce_functions(funcs: Iterable[FnPtr]) -> FnPtr:
         FnPtr: A function that calls the given functions from left to right.
     """
 
-    def reduced_fn(value):
+    def reduced_fn(value: T) -> T:
         for fn in funcs:
             value = fn(value)
         return value
@@ -75,8 +75,9 @@ class BitMask(enum.Flag):
         will allow ``BitMask`` to render as a hexadecimal value.
     """
 
-    def _class_decorator(original_class):
-        original_class.__str__ = _reduce_functions(funcs)
+    def _class_decorator(original_class: T) -> T:
+        setattr(original_class, "__str__", _reduce_functions(funcs))
+        # original_class.__str__ = _reduce_functions(funcs)
         return original_class
 
     return _class_decorator
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
index d4aa02f39b..18ce4e6011 100644
--- a/dts/framework/remote_session/dpdk_shell.py
+++ b/dts/framework/remote_session/dpdk_shell.py
@@ -78,9 +78,14 @@ def __init__(
     def path(self) -> PurePath:
         """Relative path to the shell executable from the build folder."""
 
-    def _make_real_path(self):
+    def _make_real_path(self) -> PurePath | str:
         """Overrides :meth:`~.interactive_shell.InteractiveShell._make_real_path`.
 
         Adds the remote DPDK build directory to the path.
         """
-        return get_ctx().dpdk_build.remote_dpdk_build_dir.joinpath(self.path)
+        real_path = get_ctx().dpdk_build.remote_dpdk_build_dir
+        match real_path:
+            case PurePath():
+                return real_path.joinpath(self.path)
+            case _:
+                return ""
diff --git a/dts/framework/remote_session/interactive_remote_session.py b/dts/framework/remote_session/interactive_remote_session.py
index c8156b4345..fc42e862bc 100644
--- a/dts/framework/remote_session/interactive_remote_session.py
+++ b/dts/framework/remote_session/interactive_remote_session.py
@@ -109,7 +109,7 @@ def _connect(self) -> None:
                 self._logger.debug(traceback.format_exc())
                 self._logger.warning(e)
                 self._logger.info(
-                    f"Retrying interactive session connection: retry number {retry_attempt +1}"
+                    f"Retrying interactive session connection: retry number {retry_attempt + 1}"
                 )
             else:
                 break
diff --git a/dts/framework/remote_session/interactive_shell.py b/dts/framework/remote_session/interactive_shell.py
index ba8489eafa..610d1e80c0 100644
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
@@ -166,7 +166,7 @@ def start_application(self, prompt: str | None = None) -> None:
                 break
             except InteractiveSSHTimeoutError:
                 self._logger.info(
-                    f"Interactive shell failed to start (attempt {attempt+1} out of "
+                    f"Interactive shell failed to start (attempt {attempt + 1} out of "
                     f"{self._init_attempts})"
                 )
         else:
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
index 89d4618c41..ba15b3baa3 100644
--- a/dts/framework/remote_session/remote_session.py
+++ b/dts/framework/remote_session/remote_session.py
@@ -57,9 +57,7 @@ def __post_init__(self, init_stdout: str, init_stderr: str) -> None:
     def __str__(self) -> str:
         """Format the command outputs."""
         return (
-            f"stdout: '{self.stdout}'\n"
-            f"stderr: '{self.stderr}'\n"
-            f"return_code: '{self.return_code}'"
+            f"stdout: '{self.stdout}'\nstderr: '{self.stderr}'\nreturn_code: '{self.return_code}'"
         )
 
 
@@ -99,7 +97,7 @@ def __init__(
         node_config: NodeConfiguration,
         session_name: str,
         logger: DTSLogger,
-    ):
+    ) -> None:
         """Connect to the node during initialization.
 
         Args:
diff --git a/dts/framework/remote_session/shell_pool.py b/dts/framework/remote_session/shell_pool.py
index da956950d5..710107c6cb 100644
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
-        self._logger.debug(f"Starting new shell pool and advancing to level {self.pool_level+1}.")
+        self._logger.debug(f"Starting new shell pool and advancing to level {self.pool_level + 1}.")
         self._pools.append(set())
 
-    def terminate_current_pool(self):
+    def terminate_current_pool(self) -> None:
         """Terminate all the shells in the current pool, and restore the previous pool if any.
 
         If any failure occurs while closing any shell, this is tolerated allowing the termination
diff --git a/dts/framework/remote_session/testpmd_shell.py b/dts/framework/remote_session/testpmd_shell.py
index ad8cb273dc..7b981111f6 100644
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
+    def from_str_dict(cls, d: dict[str, str]) -> Self:
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
index 3f21615223..c59b4097d4 100644
--- a/dts/framework/settings.py
+++ b/dts/framework/settings.py
@@ -108,7 +108,7 @@
 from argparse import Action, ArgumentDefaultsHelpFormatter, _get_action_name
 from dataclasses import dataclass, field
 from pathlib import Path
-from typing import Callable
+from typing import Callable, NoReturn
 
 from pydantic import ValidationError
 
@@ -174,7 +174,7 @@ def _make_env_var_name(action: Action, env_var_name: str | None) -> str:
     return env_var_name
 
 
-def _get_env_var_name(action: Action) -> str | None:
+def _get_env_var_name(action: Action | None) -> str | None:
     """Get the environment variable name of the given action."""
     return getattr(action, _ENV_VAR_NAME_ATTR, None)
 
@@ -237,13 +237,17 @@ def find_action(
 
         return action
 
-    def error(self, message):
+    def error(self, message) -> NoReturn:
         """Augments :meth:`~argparse.ArgumentParser.error` with environment variable awareness."""
         for action in self._actions:
             if _is_from_env(action):
                 action_name = _get_action_name(action)
                 env_var_name = _get_env_var_name(action)
-                env_var_value = os.environ.get(env_var_name)
+                match env_var_name:
+                    case None:
+                        env_var_value = None
+                    case nonEmpty:
+                        env_var_value = os.environ.get(nonEmpty)
 
                 message = message.replace(
                     f"argument {action_name}",
@@ -251,13 +255,13 @@ def error(self, message):
                 )
 
         print(f"{self.prog}: error: {message}\n", file=sys.stderr)
-        self.exit(2, "For help and usage, " "run the command with the --help flag.\n")
+        self.exit(2, "For help and usage, run the command with the --help flag.\n")
 
 
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
index 4355aeeb4b..4db7de2487 100644
--- a/dts/framework/test_run.py
+++ b/dts/framework/test_run.py
@@ -162,7 +162,7 @@ class TestRun:
     config: TestRunConfiguration
     logger: DTSLogger
 
-    state: "State"
+    state: "State" | None
     ctx: Context
     result: TestRunResult
     selected_tests: list[TestScenario]
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
 
@@ -235,7 +235,7 @@ def spin(self):
                 self.state.before()
                 next_state = self.state.next()
             except (KeyboardInterrupt, Exception) as e:
-                next_state = self.state.handle_exception(e)
+                next_state = self.state.handle_exception(Exception(e))
             finally:
                 self.state.after()
             if next_state is not None:
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
index f895b22bb3..87be7e6b93 100644
--- a/dts/framework/testbed_model/capability.py
+++ b/dts/framework/testbed_model/capability.py
@@ -50,7 +50,7 @@ def test_scatter_mbuf_2048(self):
 from abc import ABC, abstractmethod
 from collections.abc import MutableSet
 from dataclasses import dataclass
-from typing import TYPE_CHECKING, Callable, ClassVar, Protocol
+from typing import TYPE_CHECKING, Any, Callable, ClassVar, Protocol
 
 from typing_extensions import Self
 
@@ -374,7 +374,7 @@ def set_required(self, test_case_or_suite: type["TestProtocol"]) -> None:
         else:
             self.add_to_required(test_case_or_suite)
 
-    def __eq__(self, other) -> bool:
+    def __eq__(self, other: Any) -> bool:
         """Compare the :attr:`~TopologyCapability.topology_type`s.
 
         Args:
@@ -385,7 +385,7 @@ def __eq__(self, other) -> bool:
         """
         return self.topology_type == other.topology_type
 
-    def __lt__(self, other) -> bool:
+    def __lt__(self, other: Any) -> bool:
         """Compare the :attr:`~TopologyCapability.topology_type`s.
 
         Args:
@@ -396,7 +396,7 @@ def __lt__(self, other) -> bool:
         """
         return self.topology_type < other.topology_type
 
-    def __gt__(self, other) -> bool:
+    def __gt__(self, other: Any) -> bool:
         """Compare the :attr:`~TopologyCapability.topology_type`s.
 
         Args:
@@ -407,7 +407,7 @@ def __gt__(self, other) -> bool:
         """
         return other < self
 
-    def __le__(self, other) -> bool:
+    def __le__(self, other: Any) -> bool:
         """Compare the :attr:`~TopologyCapability.topology_type`s.
 
         Args:
diff --git a/dts/framework/testbed_model/cpu.py b/dts/framework/testbed_model/cpu.py
index b8bc601c22..a9471709dd 100644
--- a/dts/framework/testbed_model/cpu.py
+++ b/dts/framework/testbed_model/cpu.py
@@ -80,7 +80,7 @@ class LogicalCoreList:
     _lcore_list: list[int]
     _lcore_str: str
 
-    def __init__(self, lcore_list: list[int] | list[str] | list[LogicalCore] | str):
+    def __init__(self, lcore_list: list[int] | list[str] | list[LogicalCore] | str) -> None:
         """Process `lcore_list`, then sort.
 
         There are four supported logical core list formats::
@@ -105,7 +105,7 @@ def __init__(self, lcore_list: list[int] | list[str] | list[LogicalCore] | str):
 
         # the input lcores may not be sorted
         self._lcore_list.sort()
-        self._lcore_str = f'{",".join(self._get_consecutive_lcores_range(self._lcore_list))}'
+        self._lcore_str = f"{','.join(self._get_consecutive_lcores_range(self._lcore_list))}"
 
     @property
     def lcore_list(self) -> list[int]:
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
diff --git a/dts/framework/testbed_model/posix_session.py b/dts/framework/testbed_model/posix_session.py
index c71bc93f0b..dec952685a 100644
--- a/dts/framework/testbed_model/posix_session.py
+++ b/dts/framework/testbed_model/posix_session.py
@@ -183,7 +183,7 @@ def create_remote_tarball(
     ) -> PurePosixPath:
         """Overrides :meth:`~.os_session.OSSession.create_remote_tarball`."""
 
-        def generate_tar_exclude_args(exclude_patterns) -> str:
+        def generate_tar_exclude_args(exclude_patterns: str | list[str] | None) -> str:
             """Generate args to exclude patterns when creating a tarball.
 
             Args:
diff --git a/dts/framework/testbed_model/traffic_generator/scapy.py b/dts/framework/testbed_model/traffic_generator/scapy.py
index e21ba4ed96..a31807e8e4 100644
--- a/dts/framework/testbed_model/traffic_generator/scapy.py
+++ b/dts/framework/testbed_model/traffic_generator/scapy.py
@@ -16,7 +16,7 @@
 from collections.abc import Callable
 from queue import Empty, SimpleQueue
 from threading import Event, Thread
-from typing import ClassVar
+from typing import Any, ClassVar
 
 from scapy.compat import base64_bytes
 from scapy.data import ETHER_TYPES, IP_PROTOS
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
+    def __init__(self, tg_node: Node, config: ScapyTrafficGeneratorConfig, **kwargs: Any) -> None:
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
index 8f53b07daf..d7e983aabd 100644
--- a/dts/framework/testbed_model/traffic_generator/traffic_generator.py
+++ b/dts/framework/testbed_model/traffic_generator/traffic_generator.py
@@ -34,7 +34,7 @@ class TrafficGenerator(ABC):
     _tg_node: Node
     _logger: DTSLogger
 
-    def __init__(self, tg_node: Node, config: TrafficGeneratorConfig, **kwargs):
+    def __init__(self, tg_node: Node, config: TrafficGeneratorConfig) -> None:
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
index 0c81ab1b95..a70c9c7d95 100644
--- a/dts/framework/utils.py
+++ b/dts/framework/utils.py
@@ -147,14 +147,14 @@ class TarCompressionFormat(StrEnum):
     zstd = "zst"
 
     @property
-    def extension(self):
+    def extension(self) -> str:
         """Return the extension associated with the compression format.
 
         If the compression format is 'none', the extension will be in the format 'tar'.
         For other compression formats, the extension will be in the format
         'tar.{compression format}'.
         """
-        return f"{self.value}" if self == self.none else f"{self.none.value}.{self.value}"
+        return f"{self.value}" if self == self.none else f"{type(self).none.value}.{self.value}"
 
 
 def convert_to_list_of_string(value: Any | list[Any]) -> list[str]:
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

