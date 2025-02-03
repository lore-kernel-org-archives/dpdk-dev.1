Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1654FC02198
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Feb 2025 15:18:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DADDD40A84;
	Mon,  3 Feb 2025 16:17:56 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id E52AA4060C
 for <dev@dpdk.org>; Mon,  3 Feb 2025 16:17:48 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA46111FB;
 Mon,  3 Feb 2025 07:18:12 -0800 (PST)
Received: from localhost.localdomain (JR4XG4HTQC.cambridge.arm.com
 [10.1.32.49])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DF0703F63F;
 Mon,  3 Feb 2025 07:17:47 -0800 (PST)
From: Luca Vizzarro <luca.vizzarro@arm.com>
To: dev@dpdk.org
Cc: Luca Vizzarro <luca.vizzarro@arm.com>, Patrick Robb <probb@iol.unh.edu>,
 Paul Szczepanek <paul.szczepanek@arm.com>
Subject: [RFC PATCH 5/7] dts: add runtime status
Date: Mon,  3 Feb 2025 15:16:10 +0000
Message-ID: <20250203151613.2436570-6-luca.vizzarro@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250203151613.2436570-1-luca.vizzarro@arm.com>
References: <20250203151613.2436570-1-luca.vizzarro@arm.com>
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

Add a new module which defines the global runtime status of DTS and the
distinct execution stages and steps.

Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
---
 doc/api/dts/framework.status.rst |  8 ++++
 doc/api/dts/index.rst            |  1 +
 dts/framework/logger.py          | 36 ++++--------------
 dts/framework/status.py          | 64 ++++++++++++++++++++++++++++++++
 4 files changed, 81 insertions(+), 28 deletions(-)
 create mode 100644 doc/api/dts/framework.status.rst
 create mode 100644 dts/framework/status.py

diff --git a/doc/api/dts/framework.status.rst b/doc/api/dts/framework.status.rst
new file mode 100644
index 0000000000..07277b5301
--- /dev/null
+++ b/doc/api/dts/framework.status.rst
@@ -0,0 +1,8 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+
+status - DTS status definitions
+===========================================================
+
+.. automodule:: framework.status
+   :members:
+   :show-inheritance:
diff --git a/doc/api/dts/index.rst b/doc/api/dts/index.rst
index 534512dc17..cde603576c 100644
--- a/doc/api/dts/index.rst
+++ b/doc/api/dts/index.rst
@@ -29,6 +29,7 @@ Modules
    framework.test_suite
    framework.test_result
    framework.settings
+   framework.status
    framework.logger
    framework.parser
    framework.utils
diff --git a/dts/framework/logger.py b/dts/framework/logger.py
index d2b8e37da4..7b1c8e6637 100644
--- a/dts/framework/logger.py
+++ b/dts/framework/logger.py
@@ -13,37 +13,17 @@
 """
 
 import logging
-from enum import auto
 from logging import FileHandler, StreamHandler
 from pathlib import Path
 from typing import ClassVar
 
-from .utils import StrEnum
+from framework.status import PRE_RUN, State
 
 date_fmt = "%Y/%m/%d %H:%M:%S"
 stream_fmt = "%(asctime)s - %(stage)s - %(name)s - %(levelname)s - %(message)s"
 dts_root_logger_name = "dts"
 
 
-class DtsStage(StrEnum):
-    """The DTS execution stage."""
-
-    #:
-    pre_run = auto()
-    #:
-    test_run_setup = auto()
-    #:
-    test_suite_setup = auto()
-    #:
-    test_suite = auto()
-    #:
-    test_suite_teardown = auto()
-    #:
-    test_run_teardown = auto()
-    #:
-    post_run = auto()
-
-
 class DTSLogger(logging.Logger):
     """The DTS logger class.
 
@@ -55,7 +35,7 @@ class DTSLogger(logging.Logger):
     a new stage switch occurs. This is useful mainly for logging per test suite.
     """
 
-    _stage: ClassVar[DtsStage] = DtsStage.pre_run
+    _stage: ClassVar[State] = PRE_RUN
     _extra_file_handlers: list[FileHandler] = []
 
     def __init__(self, *args, **kwargs):
@@ -75,7 +55,7 @@ def makeRecord(self, *args, **kwargs) -> logging.LogRecord:
             record: The generated record with the stage information.
         """
         record = super().makeRecord(*args, **kwargs)
-        record.stage = DTSLogger._stage
+        record.stage = str(DTSLogger._stage)
         return record
 
     def add_dts_root_logger_handlers(self, verbose: bool, output_dir: str) -> None:
@@ -110,7 +90,7 @@ def add_dts_root_logger_handlers(self, verbose: bool, output_dir: str) -> None:
 
         self._add_file_handlers(Path(output_dir, self.name))
 
-    def set_stage(self, stage: DtsStage, log_file_path: Path | None = None) -> None:
+    def set_stage(self, state: State, log_file_path: Path | None = None) -> None:
         """Set the DTS execution stage and optionally log to files.
 
         Set the DTS execution stage of the DTSLog class and optionally add
@@ -120,15 +100,15 @@ def set_stage(self, stage: DtsStage, log_file_path: Path | None = None) -> None:
         the other one is a machine-readable log file with extra debug information.
 
         Args:
-            stage: The DTS stage to set.
+            state: The DTS execution state to set.
             log_file_path: An optional path of the log file to use. This should be a full path
                 (either relative or absolute) without suffix (which will be appended).
         """
         self._remove_extra_file_handlers()
 
-        if DTSLogger._stage != stage:
-            self.info(f"Moving from stage '{DTSLogger._stage}' to stage '{stage}'.")
-            DTSLogger._stage = stage
+        if DTSLogger._stage != state:
+            self.info(f"Moving from stage '{DTSLogger._stage}' " f"to stage '{state}'.")
+            DTSLogger._stage = state
 
         if log_file_path:
             self._extra_file_handlers.extend(self._add_file_handlers(log_file_path))
diff --git a/dts/framework/status.py b/dts/framework/status.py
new file mode 100644
index 0000000000..4a59aa50e6
--- /dev/null
+++ b/dts/framework/status.py
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2025 Arm Limited
+
+"""Running status of DTS.
+
+This module contains the definitions that represent the different states of execution within DTS.
+"""
+
+from enum import auto
+from typing import NamedTuple
+
+from .utils import StrEnum
+
+
+class Stage(StrEnum):
+    """Execution stage."""
+
+    #:
+    PRE_RUN = auto()
+    #:
+    TEST_RUN = auto()
+    #:
+    TEST_SUITE = auto()
+    #:
+    TEST_CASE = auto()
+    #:
+    POST_RUN = auto()
+
+
+class InternalState(StrEnum):
+    """Internal state of the current execution stage."""
+
+    #:
+    BEGIN = auto()
+    #:
+    SETUP = auto()
+    #:
+    RUN = auto()
+    #:
+    TEARDOWN = auto()
+    #:
+    END = auto()
+
+
+class State(NamedTuple):
+    """Representation of the DTS execution state."""
+
+    #:
+    stage: Stage
+    #:
+    state: InternalState
+
+    def __str__(self) -> str:
+        """A formatted name."""
+        name = self.stage.value.lower()
+        if self.state is not InternalState.RUN:
+            return f"{name}_{self.state.value.lower()}"
+        return name
+
+
+#: A ready-made pre-run DTS state.
+PRE_RUN = State(Stage.PRE_RUN, InternalState.RUN)
+#: A ready-made post-run DTS state.
+POST_RUN = State(Stage.POST_RUN, InternalState.RUN)
-- 
2.43.0

