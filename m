Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90E5C282D2
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Mar 2025 14:58:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A62540657;
	Mon,  3 Mar 2025 15:57:29 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 4D7CC40613
 for <dev@dpdk.org>; Mon,  3 Mar 2025 15:57:26 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D730D175A;
 Mon,  3 Mar 2025 06:57:39 -0800 (PST)
Received: from localhost.localdomain (unknown [10.57.64.81])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 13A423F66E;
 Mon,  3 Mar 2025 06:57:24 -0800 (PST)
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
To: dev@dpdk.org
Cc: Luca Vizzarro <luca.vizzarro@arm.com>,
 Paul Szczepanek <paul.szczepanek@arm.com>, Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH v4 7/7] dts: improve configuration errors
Date: Mon,  3 Mar 2025 16:57:09 +0200
Message-ID: <20250303145709.126126-8-Luca.Vizzarro@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250303145709.126126-1-Luca.Vizzarro@arm.com>
References: <20241108134532.130681-1-luca.vizzarro@arm.com>
 <20250303145709.126126-1-Luca.Vizzarro@arm.com>
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

From: Luca Vizzarro <luca.vizzarro@arm.com>

Improve the way that configuration errors are displayed to the user.

Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
Reviewed-by: Paul Szczepanek <paul.szczepanek@arm.com>
---
 dts/framework/config/__init__.py |  4 ++--
 dts/framework/config/test_run.py |  2 +-
 dts/framework/runner.py          | 14 +++++++++++++-
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/dts/framework/config/__init__.py b/dts/framework/config/__init__.py
index 129e6f3222..1ec744d1d4 100644
--- a/dts/framework/config/__init__.py
+++ b/dts/framework/config/__init__.py
@@ -141,7 +141,7 @@ def _load_and_parse_model(file_path: Path, model_type: type[T], ctx: ValidationC
             data = yaml.safe_load(f)
             return TypeAdapter(model_type).validate_python(data, context=cast(dict[str, Any], ctx))
         except ValidationError as e:
-            msg = f"failed to load the configuration file {file_path}"
+            msg = f"Failed to load the configuration file {file_path}."
             raise ConfigurationError(msg) from e
 
 
@@ -190,4 +190,4 @@ def load_config(ctx: ValidationContext) -> Configuration:
             {"test_run": test_run, "nodes": nodes, "tests_config": dict(tests_config)}, context=ctx
         )
     except ValidationError as e:
-        raise ConfigurationError("the configurations supplied are invalid") from e
+        raise ConfigurationError("The configurations supplied are invalid.") from e
diff --git a/dts/framework/config/test_run.py b/dts/framework/config/test_run.py
index 688688e88e..06fe28143c 100644
--- a/dts/framework/config/test_run.py
+++ b/dts/framework/config/test_run.py
@@ -445,7 +445,7 @@ def use_first_core(self) -> bool:
 class DPDKConfiguration(DPDKRuntimeConfiguration):
     """The DPDK configuration needed to test."""
 
-    #: The DPDKD build configuration used to test.
+    #: The DPDK build configuration used to test.
     build: DPDKBuildConfiguration
 
 
diff --git a/dts/framework/runner.py b/dts/framework/runner.py
index f822e8a8fc..f20aa3576a 100644
--- a/dts/framework/runner.py
+++ b/dts/framework/runner.py
@@ -11,8 +11,10 @@
 
 import os
 import sys
+import textwrap
 
 from framework.config.common import ValidationContext
+from framework.exception import ConfigurationError
 from framework.test_run import TestRun
 from framework.testbed_model.node import Node
 
@@ -37,7 +39,17 @@ class DTSRunner:
 
     def __init__(self):
         """Initialize the instance with configuration, logger, result and string constants."""
-        self._configuration = load_config(ValidationContext(settings=SETTINGS))
+        try:
+            self._configuration = load_config(ValidationContext(settings=SETTINGS))
+        except ConfigurationError as e:
+            if e.__cause__:
+                print(f"{e} Reason:", file=sys.stderr)
+                print(file=sys.stderr)
+                print(textwrap.indent(str(e.__cause__), prefix=" " * 2), file=sys.stderr)
+            else:
+                print(e, file=sys.stderr)
+            sys.exit(e.severity)
+
         self._logger = get_dts_logger()
         if not os.path.exists(SETTINGS.output_dir):
             os.makedirs(SETTINGS.output_dir)
-- 
2.43.0

