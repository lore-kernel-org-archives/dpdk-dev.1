Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70190FDEE46
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Apr 2026 19:05:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2BDA54068A;
	Thu, 23 Apr 2026 21:04:36 +0200 (CEST)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com
 [209.85.160.182])
 by mails.dpdk.org (Postfix) with ESMTP id 0BD8E40270
 for <dev@dpdk.org>; Thu, 23 Apr 2026 21:04:32 +0200 (CEST)
Received: by mail-qt1-f182.google.com with SMTP id
 d75a77b69052e-50e63771d91so52286161cf.0
 for <dev@dpdk.org>; Thu, 23 Apr 2026 12:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1776971071; x=1777575871; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pTHXEuYxsl7tjbPGIelXvt7Pl+owObhipaON3ko6R/o=;
 b=dg+Hrr81BdBw+7JXKInSdBSCfDFB78VguRkGi/5KQw0tLPL+fzAf3fdaQYcwB59hIv
 laewKjutQW7XOw/fixmKE5cvs3/pjBVUmzFFUHQMz40JsngvZ2awc4BF/IvuwTpMsabo
 z4x06VMtcQzTsZcDiqJxiaPXj4D3e1Ggy53LU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776971071; x=1777575871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pTHXEuYxsl7tjbPGIelXvt7Pl+owObhipaON3ko6R/o=;
 b=T6fXwIN/R7QzyH6aV9F5ZK2OExD+WEtDdu8yPh+QWOqV9CX1k2yvSGtKie++mm4ac6
 895P3uRoyFZzBml/izODobIHP/zUF8NMc2TmDoU04ldpjqOPjY+LU7Eq9Yr9MVG2D5/2
 +KrnLNRXTn18pKSry9WIA2WyG+5k5wY6lMZLfY2LjyHW6jrHWQ2IaN9+9O4BNcKzZtSX
 Ttdnb90WLJpTCyFdKDTnZfGqQqYsJtWbZru3exZoGOjoYA9blDOazYRdYmqjQ7U2ldcu
 dXPLloj5t/n5cBh8mXhfds8mktERzEvVzyR3PFQvrRSgEa6aQdwZrOme4SvrBiAhkhF7
 LLNw==
X-Gm-Message-State: AOJu0Yxf7cjaDaxUAhUF4npyymMGZ8JBpzo7mcYqYbiHy9wVwoCMZn8E
 tY6lPeu5Nkoc2tqhJ9ZtIz9/3Bl3zO+Y+R9QPgr7/Zt0Viso2+S9B+Ui1Tn9Vu0z8VI=
X-Gm-Gg: AeBDiestLaqqupT/wFDRk2K4vBtRCjb36KxKybJIu++gJexJ/4IHExXg9Z7o8hSAojs
 e9fiUUKSzvqpVe8z/kbu6d8boQnT0V7Hvi2XVsBk1o6JWa9jJi5r4W06DOymhXoq2i9Dw8f8TOj
 4MqpYpPgaXuxbO0A1qCKr2+hTWmOK3/AseZo0UAH8wuTXVjfv+xp+8nR7pUI4xqXnlugVOo2IyQ
 0uA8I6I/trLQsOlLSwCLQ6ANgEL5OkfM9fMSrxjOvqjvEgEYlnqOswzF6MlizIdfNVmrUp57O4v
 YEBevbP/txgcYyGq6hWapIn+6H3drsCBR6L1oRfOZ4QKXuIooeaR906PuWEmsYeMKp863wTkmoe
 C8dq46fKicM1jciCP9I2XA5zPsPEostcNsl3veZpDXN1qHrloky5A+Y2eVv34yEQI1rmqeP9uf4
 9c5C+X+RZOViiTd1RKo7pxcHHegOcq5Axu734BNb/+U48qMRadIzIyJMXXxvKj2sAx/RdyBVhS
X-Received: by 2002:a05:622a:258d:b0:50f:bb54:d3d2 with SMTP id
 d75a77b69052e-50fbb54daefmr172272141cf.51.1776971071313; 
 Thu, 23 Apr 2026 12:04:31 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:ac5d:4186:4dc6:47eb])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50fc9715610sm34624441cf.10.2026.04.23.12.04.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 12:04:30 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: patrickrobb1997@gmail.com, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v2 5/7] dts: move context from framework to API
Date: Thu, 23 Apr 2026 15:04:20 -0400
Message-ID: <20260423190424.41619-6-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260423190424.41619-1-dmarx@iol.unh.edu>
References: <20260423170331.33193-1-dmarx@iol.unh.edu>
 <20260423190424.41619-1-dmarx@iol.unh.edu>
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

A couple test suites import and get the run context
during execution. Move this to the API.

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
---
 .../dts/{framework.context.rst => api.context.rst} |  2 +-
 doc/api/dts/index.rst                              |  2 +-
 dts/api/artifact.py                                |  2 +-
 dts/{framework => api}/context.py                  |  0
 dts/api/cryptodev/__init__.py                      |  2 +-
 dts/api/packet.py                                  |  4 ++--
 dts/api/test.py                                    |  2 +-
 dts/api/test_suite.py                              |  4 ++--
 dts/api/testbed_model/node.py                      |  2 +-
 dts/api/testbed_model/topology.py                  | 14 +++++++-------
 dts/api/testpmd/__init__.py                        |  2 +-
 dts/framework/remote_session/blocking_app.py       |  2 +-
 dts/framework/remote_session/dpdk.py               |  2 +-
 dts/framework/remote_session/dpdk_shell.py         |  2 +-
 dts/framework/remote_session/interactive_shell.py  |  2 +-
 dts/framework/test_run.py                          |  2 +-
 dts/tests/TestSuite_cryptodev_throughput.py        |  2 +-
 dts/tests/TestSuite_l2fwd.py                       |  2 +-
 18 files changed, 25 insertions(+), 25 deletions(-)
 rename doc/api/dts/{framework.context.rst => api.context.rst} (80%)
 rename dts/{framework => api}/context.py (100%)

diff --git a/doc/api/dts/framework.context.rst b/doc/api/dts/api.context.rst
similarity index 80%
rename from doc/api/dts/framework.context.rst
rename to doc/api/dts/api.context.rst
index 925c160360..65b4ab9a47 100644
--- a/doc/api/dts/framework.context.rst
+++ b/doc/api/dts/api.context.rst
@@ -3,6 +3,6 @@
 context - DTS execution context
 ===============================
 
-.. automodule:: framework.context
+.. automodule:: api.context
    :members:
    :show-inheritance:
diff --git a/doc/api/dts/index.rst b/doc/api/dts/index.rst
index ced42ac241..7c282bbba1 100644
--- a/doc/api/dts/index.rst
+++ b/doc/api/dts/index.rst
@@ -32,7 +32,7 @@ Modules
    api.test_suite
    framework.test_result
    framework.settings
-   framework.context
+   api.context
    framework.logger
    framework.parser
    api.utils
diff --git a/dts/api/artifact.py b/dts/api/artifact.py
index 02d807241f..74a8ac667f 100644
--- a/dts/api/artifact.py
+++ b/dts/api/artifact.py
@@ -86,7 +86,7 @@ def make_file_path(
 
         path /= custom_path
     else:
-        from framework.context import get_ctx
+        from api.context import get_ctx
 
         try:
             ctx = get_ctx()
diff --git a/dts/framework/context.py b/dts/api/context.py
similarity index 100%
rename from dts/framework/context.py
rename to dts/api/context.py
diff --git a/dts/api/cryptodev/__init__.py b/dts/api/cryptodev/__init__.py
index c6a220dced..67dcb02130 100644
--- a/dts/api/cryptodev/__init__.py
+++ b/dts/api/cryptodev/__init__.py
@@ -23,7 +23,7 @@
     VerifyResults,
 )
 from api.exception import RemoteCommandExecutionError, SkippedTestException
-from framework.context import get_ctx
+from api.context import get_ctx
 from framework.remote_session.dpdk_shell import compute_eal_params
 
 if TYPE_CHECKING:
diff --git a/dts/api/packet.py b/dts/api/packet.py
index 2be00ad48a..393fee542b 100644
--- a/dts/api/packet.py
+++ b/dts/api/packet.py
@@ -36,7 +36,7 @@
     PerformanceTrafficStats,
 )
 from api.utils import get_packet_summaries
-from framework.context import get_ctx
+from api.context import get_ctx
 
 
 def send_packet_and_capture(
@@ -85,7 +85,7 @@ def send_packets_and_capture(
     from api.testbed_model.traffic_generator.capturing_traffic_generator import (
         CapturingTrafficGenerator,
     )
-    from framework.context import get_ctx
+    from api.context import get_ctx
 
     assert isinstance(
         get_ctx().func_tg, CapturingTrafficGenerator
diff --git a/dts/api/test.py b/dts/api/test.py
index 9cad9a9495..a1f2326075 100644
--- a/dts/api/test.py
+++ b/dts/api/test.py
@@ -11,7 +11,7 @@
 
 from api.artifact import Artifact
 from api.exception import InternalError, SkippedTestException, TestCaseVerifyError
-from framework.context import get_ctx
+from api.context import get_ctx
 from framework.logger import DTSLogger
 
 
diff --git a/dts/api/test_suite.py b/dts/api/test_suite.py
index 7feb35a9f8..0822f9bfe5 100644
--- a/dts/api/test_suite.py
+++ b/dts/api/test_suite.py
@@ -37,7 +37,7 @@
 from framework.logger import DTSLogger, get_dts_logger
 
 if TYPE_CHECKING:
-    from framework.context import Context
+    from api.context import Context
 
 
 class BaseConfig(FrozenModel):
@@ -91,7 +91,7 @@ def __init__(self, config: BaseConfig) -> None:
         Args:
             config: The test suite configuration.
         """
-        from framework.context import get_ctx
+        from api.context import get_ctx
 
         self.config = config
         self._ctx = get_ctx()
diff --git a/dts/api/testbed_model/node.py b/dts/api/testbed_model/node.py
index 4f42bf6aeb..40dd7f0666 100644
--- a/dts/api/testbed_model/node.py
+++ b/dts/api/testbed_model/node.py
@@ -242,7 +242,7 @@ def get_node(node_identifier: NodeIdentifier) -> Node | None:
     if node_identifier == "local":
         return None
 
-    from framework.context import get_ctx
+    from api.context import get_ctx
 
     ctx = get_ctx()
     if node_identifier == "sut":
diff --git a/dts/api/testbed_model/topology.py b/dts/api/testbed_model/topology.py
index 5b8fe03836..11593d64d5 100644
--- a/dts/api/testbed_model/topology.py
+++ b/dts/api/testbed_model/topology.py
@@ -96,7 +96,7 @@ def node_and_ports_from_id(self, node_identifier: NodeIdentifier) -> tuple[Node,
         Raises:
             InternalError: If the given `node_identifier` is invalid.
         """
-        from framework.context import get_ctx
+        from api.context import get_ctx
 
         ctx = get_ctx()
         match node_identifier:
@@ -180,7 +180,7 @@ def instantiate_crypto_ports(self) -> None:
         Raises:
             InternalError: If crypto virtual functions could not be created on a port.
         """
-        from framework.context import get_ctx
+        from api.context import get_ctx
 
         ctx = get_ctx()
         for port in ctx.sut_node.cryptodevs:
@@ -206,7 +206,7 @@ def instantiate_vf_ports(self) -> None:
         Raises:
             InternalError: If virtual function creation fails.
         """
-        from framework.context import get_ctx
+        from api.context import get_ctx
 
         ctx = get_ctx()
 
@@ -235,7 +235,7 @@ def instantiate_vf_ports(self) -> None:
 
     def delete_vf_ports(self) -> None:
         """Delete virtual functions from the SUT node during test run teardown."""
-        from framework.context import get_ctx
+        from api.context import get_ctx
 
         ctx = get_ctx()
 
@@ -246,7 +246,7 @@ def delete_vf_ports(self) -> None:
 
     def delete_crypto_vf_ports(self) -> None:
         """Delete crypto virtual functions from the SUT node during test run teardown."""
-        from framework.context import get_ctx
+        from api.context import get_ctx
 
         ctx = get_ctx()
 
@@ -259,7 +259,7 @@ def bind_cryptodevs(self, driver: DriverKind):
         Args:
             driver: The driver to bind the crypto functions
         """
-        from framework.context import get_ctx
+        from api.context import get_ctx
 
         self._bind_ports_to_drivers(get_ctx().sut_node, self.crypto_vf_ports, driver)
 
@@ -318,7 +318,7 @@ def _prepare_devbind_script(self) -> None:
         Raises:
             InternalError: If dpdk-devbind.py could not be found.
         """
-        from framework.context import get_ctx
+        from api.context import get_ctx
 
         local_script_path = Path("..", "usertools", "dpdk-devbind.py").resolve()
         valid_script_path = local_script_path.exists()
diff --git a/dts/api/testpmd/__init__.py b/dts/api/testpmd/__init__.py
index 9498d723d5..a528663c21 100644
--- a/dts/api/testpmd/__init__.py
+++ b/dts/api/testpmd/__init__.py
@@ -55,7 +55,7 @@
     TxOffloadConfiguration,
     VLANOffloadFlag,
 )
-from framework.context import get_ctx
+from api.context import get_ctx
 from framework.params.types import TestPmdParamsDict
 from framework.remote_session.dpdk_shell import DPDKShell
 from framework.remote_session.interactive_shell import only_active
diff --git a/dts/framework/remote_session/blocking_app.py b/dts/framework/remote_session/blocking_app.py
index 4181c20e43..955a7ccdba 100644
--- a/dts/framework/remote_session/blocking_app.py
+++ b/dts/framework/remote_session/blocking_app.py
@@ -31,7 +31,7 @@
 from typing_extensions import Self
 
 from api.testbed_model.node import Node
-from framework.context import get_ctx
+from api.context import get_ctx
 from framework.params import Params
 from framework.params.eal import EalParams
 from framework.remote_session.dpdk_shell import compute_eal_params
diff --git a/dts/framework/remote_session/dpdk.py b/dts/framework/remote_session/dpdk.py
index 1a4fec8ec9..68897bfefe 100644
--- a/dts/framework/remote_session/dpdk.py
+++ b/dts/framework/remote_session/dpdk.py
@@ -30,7 +30,7 @@
     RemoteDPDKTarballLocation,
     RemoteDPDKTreeLocation,
 )
-from framework.context import get_ctx
+from api.context import get_ctx
 from framework.logger import DTSLogger, get_dts_logger
 from framework.params.eal import EalParams
 from framework.remote_session.remote_session import CommandResult
diff --git a/dts/framework/remote_session/dpdk_shell.py b/dts/framework/remote_session/dpdk_shell.py
index ac89ec0459..947f60f75c 100644
--- a/dts/framework/remote_session/dpdk_shell.py
+++ b/dts/framework/remote_session/dpdk_shell.py
@@ -11,7 +11,7 @@
 from pathlib import PurePath
 
 from api.testbed_model.cpu import LogicalCoreList
-from framework.context import get_ctx
+from api.context import get_ctx
 from framework.params.eal import EalParams
 from framework.remote_session.interactive_shell import (
     InteractiveShell,
diff --git a/dts/framework/remote_session/interactive_shell.py b/dts/framework/remote_session/interactive_shell.py
index 15743949e7..6aebef3f45 100644
--- a/dts/framework/remote_session/interactive_shell.py
+++ b/dts/framework/remote_session/interactive_shell.py
@@ -35,7 +35,7 @@
     InteractiveSSHTimeoutError,
 )
 from api.testbed_model.node import Node
-from framework.context import get_ctx
+from api.context import get_ctx
 from framework.logger import DTSLogger, get_dts_logger
 from framework.params import Params
 from framework.settings import SETTINGS
diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py
index 9972d26b04..914bf9491d 100644
--- a/dts/framework/test_run.py
+++ b/dts/framework/test_run.py
@@ -117,7 +117,7 @@
 from api.testbed_model.topology import PortLink, Topology
 from api.testbed_model.traffic_generator import create_traffic_generator
 from framework.config.test_run import TestRunConfiguration
-from framework.context import Context, init_ctx
+from api.context import Context, init_ctx
 from framework.logger import DTSLogger, get_dts_logger
 from framework.remote_session.dpdk import DPDKBuildEnvironment, DPDKRuntimeEnvironment
 from framework.settings import SETTINGS
diff --git a/dts/tests/TestSuite_cryptodev_throughput.py b/dts/tests/TestSuite_cryptodev_throughput.py
index fb6fda3bac..67ebbc64c2 100644
--- a/dts/tests/TestSuite_cryptodev_throughput.py
+++ b/dts/tests/TestSuite_cryptodev_throughput.py
@@ -33,7 +33,7 @@
 from api.test import verify
 from api.test_suite import BaseConfig, TestSuite, crypto_test
 from api.testbed_model.virtual_device import VirtualDevice
-from framework.context import get_ctx
+from api.context import get_ctx
 
 config_list: list[dict[str, int | float | str]] = [
     {"buff_size": 64, "Gbps": 1.00},
diff --git a/dts/tests/TestSuite_l2fwd.py b/dts/tests/TestSuite_l2fwd.py
index 0b0b7bc931..f4833340a6 100644
--- a/dts/tests/TestSuite_l2fwd.py
+++ b/dts/tests/TestSuite_l2fwd.py
@@ -23,7 +23,7 @@
 from api.testpmd import TestPmd
 from api.testpmd.config import EthPeer, SimpleForwardingModes
 from api.utils import generate_random_packets
-from framework.context import filter_cores
+from api.context import filter_cores
 
 
 @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
-- 
2.52.0

