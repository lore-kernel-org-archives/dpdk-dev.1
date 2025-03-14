Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA37C28B30
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Mar 2025 13:20:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7AA1440667;
	Fri, 14 Mar 2025 14:19:30 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 216E740430
 for <dev@dpdk.org>; Fri, 14 Mar 2025 14:19:27 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 990C21424;
 Fri, 14 Mar 2025 06:19:36 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.57.40.184])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D6BCE3F673;
 Fri, 14 Mar 2025 06:19:25 -0700 (PDT)
From: Luca Vizzarro <luca.vizzarro@arm.com>
To: dev@dpdk.org
Cc: Luca Vizzarro <luca.vizzarro@arm.com>,
 Paul Szczepanek <paul.szczepanek@arm.com>, Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH v2 7/7] dts: enable shell pooling
Date: Fri, 14 Mar 2025 15:18:57 +0200
Message-ID: <20250314131857.1298247-8-luca.vizzarro@arm.com>
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

Enable the ShellPool class to be used in the test run, and let
InteractiveShells register themselves to the pool upon shell startup.
Moreover, to avoid the ShellPool to call InteractiveShell.close more
than once if the shell was not unregistered correctly, add a way to
prevent the method to be called if the shell has already been closed.

Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
Reviewed-by: Paul Szczepanek <paul.szczepanek@arm.com>
---
 .../remote_session/interactive_shell.py       | 24 ++++++++++++++++++-
 dts/framework/remote_session/python_shell.py  |  3 ++-
 dts/framework/remote_session/testpmd_shell.py |  2 ++
 dts/framework/test_run.py                     |  5 ++++
 4 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/dts/framework/remote_session/interactive_shell.py b/dts/framework/remote_session/interactive_shell.py
index d7e566e5c4..ba8489eafa 100644
--- a/dts/framework/remote_session/interactive_shell.py
+++ b/dts/framework/remote_session/interactive_shell.py
@@ -22,12 +22,14 @@
 """
 
 from abc import ABC, abstractmethod
+from collections.abc import Callable
 from pathlib import PurePath
-from typing import ClassVar
+from typing import ClassVar, Concatenate, ParamSpec, TypeAlias, TypeVar
 
 from paramiko import Channel, channel
 from typing_extensions import Self
 
+from framework.context import get_ctx
 from framework.exception import (
     InteractiveCommandExecutionError,
     InteractiveSSHSessionDeadError,
@@ -38,6 +40,23 @@
 from framework.settings import SETTINGS
 from framework.testbed_model.node import Node
 
+P = ParamSpec("P")
+T = TypeVar("T", bound="InteractiveShell")
+R = TypeVar("R")
+InteractiveShellMethod = Callable[Concatenate[T, P], R]
+InteractiveShellDecorator: TypeAlias = Callable[[InteractiveShellMethod], InteractiveShellMethod]
+
+
+def only_active(func: InteractiveShellMethod) -> InteractiveShellMethod:
+    """This decorator will skip running the method if the SSH channel is not active."""
+
+    def _wrapper(self: "InteractiveShell", *args: P.args, **kwargs: P.kwargs) -> R | None:
+        if self._ssh_channel.active:
+            return func(self, *args, **kwargs)
+        return None
+
+    return _wrapper
+
 
 class InteractiveShell(ABC):
     """The base class for managing interactive shells.
@@ -155,6 +174,7 @@ def start_application(self, prompt: str | None = None) -> None:
             self.is_alive = False  # update state on failure to start
             raise InteractiveCommandExecutionError("Failed to start application.")
         self._ssh_channel.settimeout(self._timeout)
+        get_ctx().shell_pool.register_shell(self)
 
     def send_command(
         self, command: str, prompt: str | None = None, skip_first_line: bool = False
@@ -219,6 +239,7 @@ def send_command(
             self._logger.debug(f"Got output: {out}")
         return out
 
+    @only_active
     def close(self) -> None:
         """Close the shell.
 
@@ -234,6 +255,7 @@ def close(self) -> None:
             self._logger.debug("Application failed to exit before set timeout.")
             raise InteractiveSSHTimeoutError("Application 'exit' command") from e
         self._ssh_channel.close()
+        get_ctx().shell_pool.unregister_shell(self)
 
     @property
     @abstractmethod
diff --git a/dts/framework/remote_session/python_shell.py b/dts/framework/remote_session/python_shell.py
index 6331d047c4..5b380a5c7a 100644
--- a/dts/framework/remote_session/python_shell.py
+++ b/dts/framework/remote_session/python_shell.py
@@ -15,7 +15,7 @@
 from pathlib import PurePath
 from typing import ClassVar
 
-from .interactive_shell import InteractiveShell
+from .interactive_shell import InteractiveShell, only_active
 
 
 class PythonShell(InteractiveShell):
@@ -32,6 +32,7 @@ def path(self) -> PurePath:
         """Path to the Python3 executable."""
         return PurePath("python3")
 
+    @only_active
     def close(self):
         """Close Python shell."""
         return super().close()
diff --git a/dts/framework/remote_session/testpmd_shell.py b/dts/framework/remote_session/testpmd_shell.py
index 19437b6233..b1939e4a51 100644
--- a/dts/framework/remote_session/testpmd_shell.py
+++ b/dts/framework/remote_session/testpmd_shell.py
@@ -33,6 +33,7 @@
 )
 
 from framework.context import get_ctx
+from framework.remote_session.interactive_shell import only_active
 from framework.testbed_model.topology import TopologyType
 
 if TYPE_CHECKING or environ.get("DTS_DOC_BUILD"):
@@ -2314,6 +2315,7 @@ def rx_vxlan(self, vxlan_id: int, port_id: int, enable: bool, verify: bool = Tru
                 self._logger.debug(f"Failed to set VXLAN:\n{vxlan_output}")
                 raise InteractiveCommandExecutionError(f"Failed to set VXLAN:\n{vxlan_output}")
 
+    @only_active
     def close(self) -> None:
         """Overrides :meth:`~.interactive_shell.close`."""
         self.stop()
diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py
index f9cfe5e908..7708fe31bd 100644
--- a/dts/framework/test_run.py
+++ b/dts/framework/test_run.py
@@ -430,6 +430,7 @@ def description(self) -> str:
 
     def next(self) -> State | None:
         """Next state."""
+        self.test_run.ctx.shell_pool.terminate_current_pool()
         self.test_run.ctx.tg.teardown(self.test_run.ctx.topology.tg_ports)
         self.test_run.ctx.dpdk.teardown(self.test_run.ctx.topology.sut_ports)
         self.test_run.ctx.tg_node.teardown()
@@ -473,6 +474,7 @@ def description(self) -> str:
 
     def next(self) -> State | None:
         """Next state."""
+        self.test_run.ctx.shell_pool.start_new_pool()
         self.test_suite.set_up_suite()
         self.result.update_setup(Result.PASS)
         return TestSuiteExecution(self.test_run, self.test_suite, self.result)
@@ -544,6 +546,7 @@ def next(self) -> State | None:
         """Next state."""
         self.test_suite.tear_down_suite()
         self.test_run.ctx.dpdk.kill_cleanup_dpdk_apps()
+        self.test_run.ctx.shell_pool.terminate_current_pool()
         self.result.update_teardown(Result.PASS)
         return TestRunExecution(self.test_run, self.test_run.result)
 
@@ -594,6 +597,7 @@ def description(self) -> str:
 
     def next(self) -> State | None:
         """Next state."""
+        self.test_run.ctx.shell_pool.start_new_pool()
         self.test_suite.set_up_test_case()
         self.result.update_setup(Result.PASS)
         return TestCaseExecution(
@@ -670,6 +674,7 @@ def description(self) -> str:
     def next(self) -> State | None:
         """Next state."""
         self.test_suite.tear_down_test_case()
+        self.test_run.ctx.shell_pool.terminate_current_pool()
         self.result.update_teardown(Result.PASS)
         return TestSuiteExecution(self.test_run, self.test_suite, self.test_suite_result)
 
-- 
2.43.0

