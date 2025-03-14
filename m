Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C246C282EC
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Mar 2025 13:19:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E92A34060F;
	Fri, 14 Mar 2025 14:19:24 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id C725E402E6
 for <dev@dpdk.org>; Fri, 14 Mar 2025 14:19:22 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34A071F02;
 Fri, 14 Mar 2025 06:19:32 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.57.40.184])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 746EF3F673;
 Fri, 14 Mar 2025 06:19:21 -0700 (PDT)
From: Luca Vizzarro <luca.vizzarro@arm.com>
To: dev@dpdk.org
Cc: Luca Vizzarro <luca.vizzarro@arm.com>,
 Paul Szczepanek <paul.szczepanek@arm.com>, Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH v2 3/7] dts: add shells pool
Date: Fri, 14 Mar 2025 15:18:53 +0200
Message-ID: <20250314131857.1298247-4-luca.vizzarro@arm.com>
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

Add a new class ShellPool which acts as a management component for
InteractiveShells. It pools together all the currently active shells,
which are meant to be registered to the pool upon start up. This way,
DTS can control the shells and make sure that these are stopped and
closed correctly when they go out of scope.

The implementation of ShellPool consists of a stack of pools, as each
pool in the stack is meant to own and control shells in the different
layers of execution. For example, if a shell is created in a test case,
which is considered a layer of execution on its own, this can be cleaned
up properly without affecting shells created on a lower level, like the
test suite.

Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
Reviewed-by: Paul Szczepanek <paul.szczepanek@arm.com>
---
 doc/api/dts/framework.remote_session.rst      |   1 +
 .../framework.remote_session.shell_pool.rst   |   8 ++
 dts/framework/context.py                      |   2 +
 dts/framework/remote_session/shell_pool.py    | 106 ++++++++++++++++++
 4 files changed, 117 insertions(+)
 create mode 100644 doc/api/dts/framework.remote_session.shell_pool.rst
 create mode 100644 dts/framework/remote_session/shell_pool.py

diff --git a/doc/api/dts/framework.remote_session.rst b/doc/api/dts/framework.remote_session.rst
index 79d65e3444..27c9153e64 100644
--- a/doc/api/dts/framework.remote_session.rst
+++ b/doc/api/dts/framework.remote_session.rst
@@ -15,6 +15,7 @@ remote\_session - Node Connections Package
    framework.remote_session.ssh_session
    framework.remote_session.interactive_remote_session
    framework.remote_session.interactive_shell
+   framework.remote_session.shell_pool
    framework.remote_session.dpdk
    framework.remote_session.dpdk_shell
    framework.remote_session.testpmd_shell
diff --git a/doc/api/dts/framework.remote_session.shell_pool.rst b/doc/api/dts/framework.remote_session.shell_pool.rst
new file mode 100644
index 0000000000..ef506cdd80
--- /dev/null
+++ b/doc/api/dts/framework.remote_session.shell_pool.rst
@@ -0,0 +1,8 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+
+shell\_pool- Shell Pooling Manager
+===========================================
+
+.. automodule:: framework.remote_session.shell_pool
+   :members:
+   :show-inheritance:
diff --git a/dts/framework/context.py b/dts/framework/context.py
index ddd7ed4d36..4360bc8699 100644
--- a/dts/framework/context.py
+++ b/dts/framework/context.py
@@ -8,6 +8,7 @@
 from typing import TYPE_CHECKING, ParamSpec
 
 from framework.exception import InternalError
+from framework.remote_session.shell_pool import ShellPool
 from framework.settings import SETTINGS
 from framework.testbed_model.cpu import LogicalCoreCount, LogicalCoreList
 from framework.testbed_model.node import Node
@@ -70,6 +71,7 @@ class Context:
     dpdk: "DPDKRuntimeEnvironment"
     tg: "TrafficGenerator"
     local: LocalContext = field(default_factory=LocalContext)
+    shell_pool: ShellPool = field(default_factory=ShellPool)
 
 
 __current_ctx: Context | None = None
diff --git a/dts/framework/remote_session/shell_pool.py b/dts/framework/remote_session/shell_pool.py
new file mode 100644
index 0000000000..173aa8fd36
--- /dev/null
+++ b/dts/framework/remote_session/shell_pool.py
@@ -0,0 +1,106 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2025 Arm Limited
+
+"""Module defining the shell pool class.
+
+The shell pool is used by the test run state machine to control
+the shells spawned by the test suites. Each layer of execution can
+stash the current pool and create a new layer of shells by calling `start_new_pool`.
+You can go back to the previous pool by calling `terminate_current_pool`. These layers are
+identified in the pool as levels where the higher the number, the deeper the layer of execution.
+As an example layers of execution could be: test run, test suite and test case.
+Which could appropriately identified with level numbers 0, 1 and 2 respectively.
+
+The shell pool layers are implemented as a stack. Therefore, when creating a new pool, this is
+pushed on top of the stack. Similarly, terminating the current pool also means removing the one
+at the top of the stack.
+"""
+
+from typing import TYPE_CHECKING
+
+from framework.logger import DTSLogger, get_dts_logger
+
+if TYPE_CHECKING:
+    from framework.remote_session.interactive_shell import (
+        InteractiveShell,
+    )
+
+
+class ShellPool:
+    """A pool managing active shells."""
+
+    _logger: DTSLogger
+    _pools: list[set["InteractiveShell"]]
+
+    def __init__(self):
+        """Shell pool constructor."""
+        self._logger = get_dts_logger("shell_pool")
+        self._pools = [set()]
+
+    @property
+    def pool_level(self) -> int:
+        """The current level of shell pool.
+
+        The higher level, the deeper we are in the execution state.
+        """
+        return len(self._pools) - 1
+
+    @property
+    def _current_pool(self) -> set["InteractiveShell"]:
+        """The pool in use for the current scope."""
+        return self._pools[-1]
+
+    def register_shell(self, shell: "InteractiveShell"):
+        """Register a new shell to the current pool."""
+        self._logger.debug(f"Registering shell {shell} to pool level {self.pool_level}.")
+        self._current_pool.add(shell)
+
+    def unregister_shell(self, shell: "InteractiveShell"):
+        """Unregister a shell from any pool."""
+        for level, pool in enumerate(self._pools):
+            try:
+                pool.remove(shell)
+                if pool == self._current_pool:
+                    self._logger.debug(
+                        f"Unregistering shell {shell} from pool level {self.pool_level}."
+                    )
+                else:
+                    self._logger.debug(
+                        f"Unregistering shell {shell} from pool level {level}, "
+                        f"but we currently are in level {self.pool_level}. Is this expected?"
+                    )
+            except KeyError:
+                pass
+
+    def start_new_pool(self):
+        """Start a new shell pool."""
+        self._logger.debug(f"Starting new shell pool and advancing to level {self.pool_level+1}.")
+        self._pools.append(set())
+
+    def terminate_current_pool(self):
+        """Terminate all the shells in the current pool, and restore the previous pool if any.
+
+        If any failure occurs while closing any shell, this is tolerated allowing the termination
+        to continue until the current pool is empty and removed. But this function will re-raise the
+        last occurred exception back to the caller.
+        """
+        occurred_exception = None
+        current_pool_level = self.pool_level
+        self._logger.debug(f"Terminating shell pool level {current_pool_level}.")
+        for shell in self._pools.pop():
+            self._logger.debug(f"Closing shell {shell} in shell pool level {current_pool_level}.")
+            try:
+                shell._close()
+            except Exception as e:
+                self._logger.error(f"An exception has occurred while closing shell {shell}:")
+                self._logger.exception(e)
+                occurred_exception = e
+
+        if current_pool_level == 0:
+            self.start_new_pool()
+        else:
+            self._logger.debug(f"Restoring shell pool from level {self.pool_level}.")
+
+        # Raise the last occurred exception again to let the system register a failure.
+        if occurred_exception is not None:
+            raise occurred_exception
-- 
2.43.0

