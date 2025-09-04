Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B46CA1002
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Sep 2025 11:47:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 510F741148;
	Thu,  4 Sep 2025 13:47:21 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id E6615410FA
 for <dev@dpdk.org>; Thu,  4 Sep 2025 13:47:17 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3CC92E98;
 Thu,  4 Sep 2025 04:47:08 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.57.57.136])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B689B3F6A8;
 Thu,  4 Sep 2025 04:47:16 -0700 (PDT)
From: Luca Vizzarro <luca.vizzarro@arm.com>
To: dev@dpdk.org
Cc: Luca Vizzarro <luca.vizzarro@arm.com>,
 Paul Szczepanek <paul.szczepanek@arm.com>, Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH v2 5/7] dts: make log files into artifacts
Date: Thu,  4 Sep 2025 12:45:05 +0100
Message-ID: <20250904114653.199080-6-luca.vizzarro@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250904114653.199080-1-luca.vizzarro@arm.com>
References: <20250725151503.87374-1-luca.vizzarro@arm.com>
 <20250904114653.199080-1-luca.vizzarro@arm.com>
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

Make log files behave like artifacts as dictated by the Artifact class.
Implicitly, this will automatically place all the logs in a structured
manner.

Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
Reviewed-by: Paul Szczepanek <paul.szczepanek@arm.com>
---
 dts/framework/logger.py   | 126 ++++++++++++++++++++++----------------
 dts/framework/runner.py   |   5 +-
 dts/framework/test_run.py |  33 +++-------
 3 files changed, 83 insertions(+), 81 deletions(-)

diff --git a/dts/framework/logger.py b/dts/framework/logger.py
index f43b442bc9..f69020f20b 100644
--- a/dts/framework/logger.py
+++ b/dts/framework/logger.py
@@ -2,43 +2,54 @@
 # Copyright(c) 2010-2014 Intel Corporation
 # Copyright(c) 2022-2023 PANTHEON.tech s.r.o.
 # Copyright(c) 2022-2023 University of New Hampshire
+# Copyright(c) 2025 Arm Limited
 
 """DTS logger module.
 
 The module provides several additional features:
 
     * The storage of DTS execution stages,
-    * Logging to console, a human-readable log file and a machine-readable log file,
-    * Optional log files for specific stages.
+    * Logging to console, a human-readable log artifact and a machine-readable log artifact,
+    * Optional log artifacts for specific stages.
 """
 
 import logging
-from logging import FileHandler, StreamHandler
-from pathlib import Path
-from typing import ClassVar
+from logging import StreamHandler
+from typing import TYPE_CHECKING, ClassVar, NamedTuple
+
+if TYPE_CHECKING:
+    from framework.testbed_model.artifact import Artifact
 
 date_fmt = "%Y/%m/%d %H:%M:%S"
 stream_fmt = "%(asctime)s - %(stage)s - %(name)s - %(levelname)s - %(message)s"
 dts_root_logger_name = "dts"
 
 
+class ArtifactHandler(NamedTuple):
+    """A logger handler with an associated artifact."""
+
+    artifact: "Artifact"
+    handler: StreamHandler
+
+
 class DTSLogger(logging.Logger):
     """The DTS logger class.
 
     The class extends the :class:`~logging.Logger` class to add the DTS execution stage information
     to log records. The stage is common to all loggers, so it's stored in a class variable.
 
-    Any time we switch to a new stage, we have the ability to log to an additional log file along
-    with a supplementary log file with machine-readable format. These two log files are used until
-    a new stage switch occurs. This is useful mainly for logging per test suite.
+    Any time we switch to a new stage, we have the ability to log to an additional log artifact
+    along with a supplementary log artifact with machine-readable format. These two log artifacts
+    are used until a new stage switch occurs. This is useful mainly for logging per test suite.
     """
 
     _stage: ClassVar[str] = "pre_run"
-    _extra_file_handlers: list[FileHandler] = []
+    _root_artifact_handlers: list[ArtifactHandler] = []
+    _extra_artifact_handlers: list[ArtifactHandler] = []
 
     def __init__(self, *args, **kwargs):
-        """Extend the constructor with extra file handlers."""
-        self._extra_file_handlers = []
+        """Extend the constructor with extra artifact handlers."""
+        self._extra_artifact_handlers = []
         super().__init__(*args, **kwargs)
 
     def makeRecord(self, *args, **kwargs) -> logging.LogRecord:
@@ -56,7 +67,7 @@ def makeRecord(self, *args, **kwargs) -> logging.LogRecord:
         record.stage = DTSLogger._stage
         return record
 
-    def add_dts_root_logger_handlers(self, verbose: bool, output_dir: str) -> None:
+    def add_dts_root_logger_handlers(self, verbose: bool) -> None:
         """Add logger handlers to the DTS root logger.
 
         This method should be called only on the DTS root logger.
@@ -65,18 +76,16 @@ def add_dts_root_logger_handlers(self, verbose: bool, output_dir: str) -> None:
         Three handlers are added:
 
             * A console handler,
-            * A file handler,
-            * A supplementary file handler with machine-readable logs
+            * An artifact handler,
+            * A supplementary artifact handler with machine-readable logs
               containing more debug information.
 
-        All log messages will be logged to files. The log level of the console handler
+        All log messages will be logged to artifacts. The log level of the console handler
         is configurable with `verbose`.
 
         Args:
             verbose: If :data:`True`, log all messages to the console.
                 If :data:`False`, log to console with the :data:`logging.INFO` level.
-            output_dir: The directory where the log files will be located.
-                The names of the log files correspond to the name of the logger instance.
         """
         self.setLevel(1)
 
@@ -86,70 +95,81 @@ def add_dts_root_logger_handlers(self, verbose: bool, output_dir: str) -> None:
             sh.setLevel(logging.INFO)
         self.addHandler(sh)
 
-        self._add_file_handlers(Path(output_dir, self.name))
+        self._root_artifact_handlers = self._add_artifact_handlers(self.name)
 
-    def set_stage(self, stage: str, log_file_path: Path | None = None) -> None:
-        """Set the DTS execution stage and optionally log to files.
-
-        Set the DTS execution stage of the DTSLog class and optionally add
-        file handlers to the instance if the log file name is provided.
-
-        The file handlers log all messages. One is a regular human-readable log file and
-        the other one is a machine-readable log file with extra debug information.
+    def set_stage(self, stage: str) -> None:
+        """Set the DTS execution stage.
 
         Args:
             stage: The DTS stage to set.
-            log_file_path: An optional path of the log file to use. This should be a full path
-                (either relative or absolute) without suffix (which will be appended).
         """
-        self._remove_extra_file_handlers()
-
         if DTSLogger._stage != stage:
             self.info(f"Moving from stage '{DTSLogger._stage}' to stage '{stage}'.")
             DTSLogger._stage = stage
 
-        if log_file_path:
-            self._extra_file_handlers.extend(self._add_file_handlers(log_file_path))
+    def set_custom_log_file(self, log_file_name: str | None) -> None:
+        """Set a custom log file.
 
-    def _add_file_handlers(self, log_file_path: Path) -> list[FileHandler]:
-        """Add file handlers to the DTS root logger.
+        Add artifact handlers to the instance if the log artifact file name is provided. Otherwise,
+        stop logging to any custom log file.
 
-        Add two type of file handlers:
+        The artifact handlers log all messages. One is a regular human-readable log artifact and
+        the other one is a machine-readable log artifact with extra debug information.
 
-            * A regular file handler with suffix ".log",
-            * A machine-readable file handler with suffix ".verbose.log".
+        Args:
+            log_file_name: An optional name of the log artifact file to use. This should be without
+                suffix (which will be appended).
+        """
+        self._remove_extra_artifact_handlers()
+
+        if log_file_name:
+            self._extra_artifact_handlers.extend(self._add_artifact_handlers(log_file_name))
+
+    def _add_artifact_handlers(self, log_file_name: str) -> list[ArtifactHandler]:
+        """Add artifact handlers to the DTS root logger.
+
+        Add two type of artifact handlers:
+
+            * A regular artifact handler with suffix ".log",
+            * A machine-readable artifact handler with suffix ".verbose.log".
               This format provides extensive information for debugging and detailed analysis.
 
         Args:
-            log_file_path: The full path to the log file without suffix.
+            log_file_name: The name of the artifact log file without suffix.
 
         Returns:
-            The newly created file handlers.
-
+            The newly created artifact handlers.
         """
-        fh = FileHandler(f"{log_file_path}.log")
-        fh.setFormatter(logging.Formatter(stream_fmt, date_fmt))
-        self.addHandler(fh)
+        from framework.testbed_model.artifact import Artifact
+
+        log_artifact = Artifact("local", f"{log_file_name}.log")
+        handler = StreamHandler(log_artifact.open("w"))
+        handler.setFormatter(logging.Formatter(stream_fmt, date_fmt))
+        self.addHandler(handler)
 
-        verbose_fh = FileHandler(f"{log_file_path}.verbose.log")
-        verbose_fh.setFormatter(
+        verbose_log_artifact = Artifact("local", f"{log_file_name}.verbose.log")
+        verbose_handler = StreamHandler(verbose_log_artifact.open("w"))
+        verbose_handler.setFormatter(
             logging.Formatter(
                 "%(asctime)s|%(stage)s|%(name)s|%(levelname)s|%(pathname)s|%(lineno)d|"
                 "%(funcName)s|%(process)d|%(thread)d|%(threadName)s|%(message)s",
                 datefmt=date_fmt,
             )
         )
-        self.addHandler(verbose_fh)
+        self.addHandler(verbose_handler)
 
-        return [fh, verbose_fh]
+        return [
+            ArtifactHandler(log_artifact, handler),
+            ArtifactHandler(verbose_log_artifact, verbose_handler),
+        ]
 
-    def _remove_extra_file_handlers(self) -> None:
-        """Remove any extra file handlers that have been added to the logger."""
-        if self._extra_file_handlers:
-            for extra_file_handler in self._extra_file_handlers:
-                self.removeHandler(extra_file_handler)
+    def _remove_extra_artifact_handlers(self) -> None:
+        """Remove any extra artifact handlers that have been added to the logger."""
+        if self._extra_artifact_handlers:
+            for extra_artifact_handler in self._extra_artifact_handlers:
+                self.removeHandler(extra_artifact_handler.handler)
 
-            self._extra_file_handlers = []
+            self._extra_artifact_handlers = []
 
 
 def get_dts_logger(name: str | None = None) -> DTSLogger:
diff --git a/dts/framework/runner.py b/dts/framework/runner.py
index 0a3d92b0c8..ae5ac014e2 100644
--- a/dts/framework/runner.py
+++ b/dts/framework/runner.py
@@ -9,7 +9,6 @@
 The module is responsible for preparing DTS and running the test run.
 """
 
-import os
 import sys
 import textwrap
 
@@ -45,9 +44,7 @@ def __init__(self):
             sys.exit(e.severity)
 
         self._logger = get_dts_logger()
-        if not os.path.exists(SETTINGS.output_dir):
-            os.makedirs(SETTINGS.output_dir)
-        self._logger.add_dts_root_logger_handlers(SETTINGS.verbose, SETTINGS.output_dir)
+        self._logger.add_dts_root_logger_handlers(SETTINGS.verbose)
 
         test_suites_result = ResultNode(label="test_suites")
         self._result = TestRunResult(test_suites=test_suites_result)
diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py
index f70580f8fd..3b7e99b4b0 100644
--- a/dts/framework/test_run.py
+++ b/dts/framework/test_run.py
@@ -103,7 +103,6 @@
 from collections.abc import Iterable
 from dataclasses import dataclass
 from functools import cached_property
-from pathlib import Path
 from types import MethodType
 from typing import ClassVar, Protocol, Union
 
@@ -115,7 +114,6 @@
 from framework.settings import SETTINGS
 from framework.test_result import Result, ResultNode, TestRunResult
 from framework.test_suite import BaseConfig, TestCase, TestSuite
-from framework.testbed_model.artifact import Artifact
 from framework.testbed_model.capability import (
     Capability,
     get_supported_capabilities,
@@ -259,11 +257,11 @@ class State(Protocol):
     test_run: TestRun
     result: TestRunResult | ResultNode
 
-    def before(self):
+    def before(self) -> None:
         """Hook before the state is processed."""
-        self.logger.set_stage(self.logger_name, self.log_file_path)
+        self.logger.set_stage(self.logger_name)
 
-    def after(self):
+    def after(self) -> None:
         """Hook after the state is processed."""
         return
 
@@ -276,17 +274,6 @@ def logger(self) -> DTSLogger:
         """A reference to the root logger."""
         return get_dts_logger()
 
-    def get_log_file_name(self) -> str | None:
-        """Name of the log file for this state."""
-        return None
-
-    @property
-    def log_file_path(self) -> Path | None:
-        """Path to the log file for this state."""
-        if file_name := self.get_log_file_name():
-            return Path(SETTINGS.output_dir, file_name)
-        return None
-
     def next(self) -> Union["State", None]:
         """Next state."""
 
@@ -463,10 +450,6 @@ class TestSuiteState(State):
     test_suite: TestSuite
     result: ResultNode
 
-    def get_log_file_name(self) -> str | None:
-        """Get the log file name."""
-        return self.test_suite.name
-
 
 @dataclass
 class TestSuiteSetup(TestSuiteState):
@@ -474,6 +457,11 @@ class TestSuiteSetup(TestSuiteState):
 
     logger_name: ClassVar[str] = "test_suite_setup"
 
+    def before(self) -> None:
+        """Hook before the state is processed."""
+        super().before()
+        self.logger.set_custom_log_file(self.test_suite.name)
+
     @property
     def description(self) -> str:
         """State description."""
@@ -591,6 +579,7 @@ def after(self) -> None:
                 "The remaining test suites will be skipped."
             )
             self.test_run.blocked = True
+        self.logger.set_custom_log_file(None)
 
 
 @dataclass
@@ -602,10 +591,6 @@ class TestCaseState(State):
     test_case: type[TestCase]
     result: ResultNode
 
-    def get_log_file_name(self) -> str | None:
-        """Get the log file name."""
-        return self.test_suite.name
-
 
 @dataclass
 class TestCaseSetup(TestCaseState):
-- 
2.43.0

