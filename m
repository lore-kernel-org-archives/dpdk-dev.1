Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AEE5C021A6
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 13:30:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5013E410D5;
	Mon, 24 Feb 2025 14:30:14 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 029F940EDC
 for <dev@dpdk.org>; Mon, 24 Feb 2025 14:30:10 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 270881CE0;
 Mon, 24 Feb 2025 05:30:26 -0800 (PST)
Received: from localhost.localdomain (JR4XG4HTQC.cambridge.arm.com
 [10.1.32.39])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CD1893F5A1;
 Mon, 24 Feb 2025 05:30:08 -0800 (PST)
From: Luca Vizzarro <luca.vizzarro@arm.com>
To: dev@dpdk.org
Cc: Luca Vizzarro <luca.vizzarro@arm.com>,
 Paul Szczepanek <paul.szczepanek@arm.com>, Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH 3/6] dts: add tmp directory facility
Date: Mon, 24 Feb 2025 13:28:20 +0000
Message-ID: <20250224132823.196509-4-luca.vizzarro@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224132823.196509-1-luca.vizzarro@arm.com>
References: <20250224132823.196509-1-luca.vizzarro@arm.com>
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

Add a facility to create and ues a temporary runtime directory on the
remote nodes for each test run.

This requires adding setup and teardown steps for Node. To ensure that
setup is not performed twice in case of a loopback setup where the same
node is used both as SUT and TG, an internal state about the setup is
held.

Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
Reviewed-by: Paul Szczepanek <paul.szczepanek@arm.com>
---
 dts/framework/test_run.py                    |  4 +++
 dts/framework/testbed_model/node.py          | 31 +++++++++++++++++++-
 dts/framework/testbed_model/os_session.py    | 12 ++++++++
 dts/framework/testbed_model/posix_session.py |  5 ++++
 4 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py
index 9f37c4bb6c..69cc76bc25 100644
--- a/dts/framework/test_run.py
+++ b/dts/framework/test_run.py
@@ -333,6 +333,8 @@ def next(self) -> State | None:
         test_run.init_random_seed()
         test_run.remaining_tests = deque(test_run.selected_tests)
 
+        test_run.ctx.sut_node.setup()
+        test_run.ctx.tg_node.setup()
         test_run.ctx.dpdk.setup(test_run.ctx.topology.sut_ports)
 
         self.result.ports = test_run.ctx.topology.sut_ports + test_run.ctx.topology.tg_ports
@@ -417,6 +419,8 @@ def description(self) -> str:
     def next(self) -> State | None:
         """Next state."""
         self.test_run.ctx.dpdk.teardown(self.test_run.ctx.topology.sut_ports)
+        self.test_run.ctx.tg_node.teardown()
+        self.test_run.ctx.sut_node.teardown()
         self.result.update_teardown(Result.PASS)
         return None
 
diff --git a/dts/framework/testbed_model/node.py b/dts/framework/testbed_model/node.py
index be1b4ac2ac..e6737cd173 100644
--- a/dts/framework/testbed_model/node.py
+++ b/dts/framework/testbed_model/node.py
@@ -14,12 +14,13 @@
 """
 
 from functools import cached_property
+from pathlib import PurePath
 
 from framework.config.node import (
     OS,
     NodeConfiguration,
 )
-from framework.exception import ConfigurationError
+from framework.exception import ConfigurationError, InternalError
 from framework.logger import DTSLogger, get_dts_logger
 
 from .cpu import Architecture, LogicalCore
@@ -56,6 +57,7 @@ class Node:
     _other_sessions: list[OSSession]
     _node_info: OSSessionInfo | None
     _compiler_version: str | None
+    _setup: bool
 
     def __init__(self, node_config: NodeConfiguration):
         """Connect to the node and gather info during initialization.
@@ -77,9 +79,36 @@ def __init__(self, node_config: NodeConfiguration):
         self._logger.info(f"Connected to node: {self.name}")
         self._get_remote_cpus()
         self._other_sessions = []
+        self._setup = False
         self.ports = [Port(self, port_config) for port_config in self.config.ports]
         self._logger.info(f"Created node: {self.name}")
 
+    def setup(self) -> None:
+        """Node setup."""
+        if self._setup:
+            return
+
+        self.tmp_dir = self.main_session.create_tmp_dir()
+        self._setup = True
+
+    def teardown(self) -> None:
+        """Node teardown."""
+        if not self._setup:
+            return
+
+        self.main_session.remove_remote_dir(self.tmp_dir)
+        del self.tmp_dir
+        self._setup = False
+
+    @cached_property
+    def tmp_dir(self) -> PurePath:
+        """Path to the temporary directory.
+
+        Raises:
+            InternalError: If called before the node has been setup.
+        """
+        raise InternalError("Temporary directory requested before setup.")
+
     @cached_property
     def ports_by_name(self) -> dict[str, Port]:
         """Ports mapped by the name assigned at configuration."""
diff --git a/dts/framework/testbed_model/os_session.py b/dts/framework/testbed_model/os_session.py
index 3c7b2a4f47..354c607357 100644
--- a/dts/framework/testbed_model/os_session.py
+++ b/dts/framework/testbed_model/os_session.py
@@ -195,6 +195,18 @@ def remote_path_exists(self, remote_path: str | PurePath) -> bool:
             :data:`True` if the path exists, :data:`False` otherwise.
         """
 
+    @abstractmethod
+    def create_tmp_dir(self, template: str = "dts.XXXXX") -> PurePath:
+        """Create a temporary directory on the remote node.
+
+        Args:
+            template: The template to use for the name of the directory. "X"s are treated
+                as placeholder.
+
+        Returns:
+            The path to the created directory.
+        """
+
     @abstractmethod
     def copy_from(self, source_file: str | PurePath, destination_dir: str | Path) -> None:
         """Copy a file from the remote node to the local filesystem.
diff --git a/dts/framework/testbed_model/posix_session.py b/dts/framework/testbed_model/posix_session.py
index eab08a90ce..2d2701e1cf 100644
--- a/dts/framework/testbed_model/posix_session.py
+++ b/dts/framework/testbed_model/posix_session.py
@@ -96,6 +96,11 @@ def remote_path_exists(self, remote_path: str | PurePath) -> bool:
         result = self.send_command(f"test -e {remote_path}")
         return not result.return_code
 
+    def create_tmp_dir(self, template: str = "dts.XXXXX") -> PurePath:
+        """Overrides :meth:`~.os_session.OSSession.create_tmp_dir`."""
+        result = self.send_command(f'mktemp -dp "" {template}')
+        return PurePath(result.stdout)
+
     def copy_from(self, source_file: str | PurePath, destination_dir: str | Path) -> None:
         """Overrides :meth:`~.os_session.OSSession.copy_from`."""
         self.remote_session.copy_from(source_file, destination_dir)
-- 
2.43.0

