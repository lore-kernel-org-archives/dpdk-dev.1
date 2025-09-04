Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80FCCA1015
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Sep 2025 11:47:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9A8954113C;
	Thu,  4 Sep 2025 13:47:18 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 53BAE410F1
 for <dev@dpdk.org>; Thu,  4 Sep 2025 13:47:16 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3623D2EC6;
 Thu,  4 Sep 2025 04:47:07 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.57.57.136])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EF3F63F6A8;
 Thu,  4 Sep 2025 04:47:14 -0700 (PDT)
From: Luca Vizzarro <luca.vizzarro@arm.com>
To: dev@dpdk.org
Cc: Luca Vizzarro <luca.vizzarro@arm.com>,
 Paul Szczepanek <paul.szczepanek@arm.com>, Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH v2 3/7] dts: add current test suite and cases to context
Date: Thu,  4 Sep 2025 12:45:03 +0100
Message-ID: <20250904114653.199080-4-luca.vizzarro@arm.com>
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

Add the current test suite and case to the context, so that they can be
accessed by helper functions, etc.

Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
Reviewed-by: Paul Szczepanek <paul.szczepanek@arm.com>
---
 dts/framework/context.py  | 7 ++++++-
 dts/framework/test_run.py | 2 ++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/dts/framework/context.py b/dts/framework/context.py
index 4360bc8699..b99a5a4a69 100644
--- a/dts/framework/context.py
+++ b/dts/framework/context.py
@@ -5,7 +5,7 @@
 
 import functools
 from dataclasses import MISSING, dataclass, field, fields
-from typing import TYPE_CHECKING, ParamSpec
+from typing import TYPE_CHECKING, ParamSpec, Union
 
 from framework.exception import InternalError
 from framework.remote_session.shell_pool import ShellPool
@@ -16,6 +16,7 @@
 
 if TYPE_CHECKING:
     from framework.remote_session.dpdk import DPDKBuildEnvironment, DPDKRuntimeEnvironment
+    from framework.test_suite import TestCase, TestSuite
     from framework.testbed_model.traffic_generator.traffic_generator import TrafficGenerator
 
 P = ParamSpec("P")
@@ -26,6 +27,8 @@ class LocalContext:
     """Updatable context local to test suites and cases.
 
     Attributes:
+        current_test_suite: The currently running test suite, if any.
+        current_test_case: The currently running test case, if any.
         lcore_filter_specifier: A number of lcores/cores/sockets to use or a list of lcore ids to
             use. The default will select one lcore for each of two cores on one socket, in ascending
             order of core ids.
@@ -37,6 +40,8 @@ class LocalContext:
             and no output is gathered within the timeout, an exception is thrown.
     """
 
+    current_test_suite: Union["TestSuite", None] = None
+    current_test_case: Union[type["TestCase"], None] = None
     lcore_filter_specifier: LogicalCoreCount | LogicalCoreList = field(
         default_factory=LogicalCoreCount
     )
diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py
index 4355aeeb4b..614022e2b6 100644
--- a/dts/framework/test_run.py
+++ b/dts/framework/test_run.py
@@ -406,6 +406,7 @@ def next(self) -> State | None:
                 return self
 
             test_run.ctx.local.reset()
+            test_run.ctx.local.current_test_suite = test_suite
             return TestSuiteSetup(test_run, test_suite, test_suite_result)
         except IndexError:
             # No more test suites. We are done here.
@@ -529,6 +530,7 @@ def next(self) -> State | None:
                 test_case_result.mark_result_as(Result.SKIP, e)
                 return self
 
+            self.test_run.ctx.local.current_test_case = test_case
             return TestCaseSetup(
                 self.test_run,
                 self.test_suite,
-- 
2.43.0

