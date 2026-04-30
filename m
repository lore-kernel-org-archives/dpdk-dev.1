Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225BACD13D2
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Apr 2026 21:09:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7068240685;
	Thu, 30 Apr 2026 23:09:26 +0200 (CEST)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com
 [209.85.222.181])
 by mails.dpdk.org (Postfix) with ESMTP id 9B96C402A0
 for <dev@dpdk.org>; Thu, 30 Apr 2026 23:09:22 +0200 (CEST)
Received: by mail-qk1-f181.google.com with SMTP id
 af79cd13be357-8d68f702851so149320685a.0
 for <dev@dpdk.org>; Thu, 30 Apr 2026 14:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1777583362; x=1778188162; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TPCPst9vo3Xsc8FHL6NQx7VvJJy86rHjS0ttv0htqGc=;
 b=NXX8yBZuntLJy6HjM/jJ9HZy+1mLkFdBhMtRbaTfTlFWJ8MsfutWi4UYjv5D3T+eWZ
 LrEEgcAxIpbukASv+TzFAGE7ov8vvUQQ3nkJVUCzqqlD/61b8vIIAX1oRQ+hzK952sg5
 d3U8YdfyoYgeaDjCEMEYZ+TlSoip8+nR8yH/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777583362; x=1778188162;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TPCPst9vo3Xsc8FHL6NQx7VvJJy86rHjS0ttv0htqGc=;
 b=doEpkaCjLdmb/tqqGqRQTlcmpvF60WexooRB9OeXFFtyn1Vf8WrYtgxsNU738wCQrA
 jLqFrPW7otj+ArTHLOeQ6bOu3ja9ZbyPZWR5UyPofB2ljHICdsRhF2BCi4CKBEeXWzeJ
 KzHJjwQl9JutgR2qpjdVD8ZI0RwSfa5yoDaIj8BRF8uk/2W5XOKijmbyRlx7we/vVAze
 dHbhGpJeLhVKyKDV9QMAHyU3Y6+MkSGt19egsF9bEvjFsERDb7FQNRWiGH75wwoN6y2J
 fHQy5ruTv93iIW9qJno+8f42oXMLn8SolK6ANZ2oa0mrfwE4tn7mYIIZJJz3PKn1Kixn
 0FBQ==
X-Gm-Message-State: AOJu0Yw4iNhZYdnX0hyb4u67sqwVr7IIxkcHFIKEJkFVs6BbkQD6g0YJ
 x0fcJJc/x+zDAXhgKQQkvqsJcB92eY+1lHdvxjVmFY2p+746cAmue33g6nPNUtI7cto=
X-Gm-Gg: AeBDievYbZUNZ4dJ30PIccP3uBYi0xOKfkc8wtlJP3HN9Spg1BrOAj8QGPJRWpAzoC0
 YersgZNvcLlD+4cJSKHwpV6K1jT6WIrkftuk5sjm37p+A4NqfhBW2b691HgbuSHnwWLwnIgN/5L
 h81/wzkJ3knGjEViNzsZb1PTku0Lud0eAxw4/rwYPU4ip1WqJxuXgOOK3B2ThEwhYvWNNu4uzK9
 yex3Kjs2pka7dKqOeNV7iWEESVbKZqrBvzIT63hABrCfGnwQWxDKGdFlzm4XTrJvwQCnJYHbQLP
 U8wmbyEuo49vqwTwsTO+IDx0ngfgsF1U+7Xgl1thGq5yMZU4JOs6na/PY6s7vkdmct/irS5gUGT
 WoqmHvVOUVcyogJYcnW76xWJUFx3rJyKVwASQMVARDtYSrKZxWjtKrOns6EY9wtLfnzrPEyiFaK
 qHDBlArrvEmkW/x2MN1fh/aKaJwe21+8DJDeu5Iubu6iuwwNclTWQ6wC93z8KycE7EMemlpNj0
X-Received: by 2002:a05:620a:44d0:b0:8d6:39c0:e6a0 with SMTP id
 af79cd13be357-8fbf3f1ef71mr43339985a.54.1777583361868; 
 Thu, 30 Apr 2026 14:09:21 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:ac5d:4186:4dc6:47eb])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8fbf3f2141fsm15434385a.41.2026.04.30.14.09.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 14:09:21 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: patrickrobb1997@gmail.com, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v4 3/7] dts: move context from framework to API
Date: Thu, 30 Apr 2026 17:09:13 -0400
Message-ID: <20260430210917.25186-4-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260430210917.25186-1-dmarx@iol.unh.edu>
References: <20260424170139.20592-1-dmarx@iol.unh.edu>
 <20260430210917.25186-1-dmarx@iol.unh.edu>
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
 dts/api/testpmd/__init__.py                        |  2 +-
 dts/framework/remote_session/blocking_app.py       |  2 +-
 dts/framework/remote_session/dpdk.py               |  2 +-
 dts/framework/remote_session/dpdk_shell.py         |  2 +-
 dts/framework/remote_session/interactive_shell.py  |  2 +-
 dts/framework/test_run.py                          |  2 +-
 dts/framework/test_suite.py                        |  4 ++--
 dts/framework/testbed_model/node.py                |  2 +-
 dts/framework/testbed_model/topology.py            | 14 +++++++-------
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
index 783270f6e9..98269d6e80 100644
--- a/doc/api/dts/index.rst
+++ b/doc/api/dts/index.rst
@@ -32,7 +32,7 @@ Modules
    framework.test_suite
    framework.test_result
    framework.settings
-   framework.context
+   api.context
    framework.logger
    framework.parser
    api.utils
diff --git a/dts/api/artifact.py b/dts/api/artifact.py
index 7d04c7ab49..f3dd07de56 100644
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
index b7a9bb28bf..59f26da833 100644
--- a/dts/api/packet.py
+++ b/dts/api/packet.py
@@ -30,7 +30,7 @@
 from api.exception import InternalError
 from api.test import fail, log_debug
 from api.utils import get_packet_summaries
-from framework.context import get_ctx
+from api.context import get_ctx
 from framework.testbed_model.traffic_generator.capturing_traffic_generator import (
     PacketFilteringConfig,
 )
@@ -82,7 +82,7 @@ def send_packets_and_capture(
     Returns:
         A list of received packets.
     """
-    from framework.context import get_ctx
+    from api.context import get_ctx
     from framework.testbed_model.traffic_generator.capturing_traffic_generator import (
         CapturingTrafficGenerator,
     )
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
index c3b02dcc62..07db6dfeb0 100644
--- a/dts/framework/remote_session/blocking_app.py
+++ b/dts/framework/remote_session/blocking_app.py
@@ -30,7 +30,7 @@
 
 from typing_extensions import Self
 
-from framework.context import get_ctx
+from api.context import get_ctx
 from framework.params import Params
 from framework.params.eal import EalParams
 from framework.remote_session.dpdk_shell import compute_eal_params
diff --git a/dts/framework/remote_session/dpdk.py b/dts/framework/remote_session/dpdk.py
index 69b47b823b..9f7cd60dfe 100644
--- a/dts/framework/remote_session/dpdk.py
+++ b/dts/framework/remote_session/dpdk.py
@@ -26,7 +26,7 @@
     RemoteDPDKTarballLocation,
     RemoteDPDKTreeLocation,
 )
-from framework.context import get_ctx
+from api.context import get_ctx
 from framework.logger import DTSLogger, get_dts_logger
 from framework.params.eal import EalParams
 from framework.remote_session.remote_session import CommandResult
diff --git a/dts/framework/remote_session/dpdk_shell.py b/dts/framework/remote_session/dpdk_shell.py
index 269c2cada4..a8f169787c 100644
--- a/dts/framework/remote_session/dpdk_shell.py
+++ b/dts/framework/remote_session/dpdk_shell.py
@@ -10,7 +10,7 @@
 from abc import ABC, abstractmethod
 from pathlib import PurePath
 
-from framework.context import get_ctx
+from api.context import get_ctx
 from framework.params.eal import EalParams
 from framework.remote_session.interactive_shell import (
     InteractiveShell,
diff --git a/dts/framework/remote_session/interactive_shell.py b/dts/framework/remote_session/interactive_shell.py
index fdd074be3a..d138727c85 100644
--- a/dts/framework/remote_session/interactive_shell.py
+++ b/dts/framework/remote_session/interactive_shell.py
@@ -34,7 +34,7 @@
     InteractiveSSHSessionDeadError,
     InteractiveSSHTimeoutError,
 )
-from framework.context import get_ctx
+from api.context import get_ctx
 from framework.logger import DTSLogger, get_dts_logger
 from framework.params import Params
 from framework.settings import SETTINGS
diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py
index bbaf4f1fdf..605a916ebb 100644
--- a/dts/framework/test_run.py
+++ b/dts/framework/test_run.py
@@ -108,7 +108,7 @@
 
 from api.exception import InternalError, SkippedTestException, TestCaseVerifyError
 from framework.config.test_run import TestRunConfiguration
-from framework.context import Context, init_ctx
+from api.context import Context, init_ctx
 from framework.logger import DTSLogger, get_dts_logger
 from framework.remote_session.dpdk import DPDKBuildEnvironment, DPDKRuntimeEnvironment
 from framework.settings import SETTINGS
diff --git a/dts/framework/test_suite.py b/dts/framework/test_suite.py
index 426c98fdf6..6066f7a77a 100644
--- a/dts/framework/test_suite.py
+++ b/dts/framework/test_suite.py
@@ -38,7 +38,7 @@
 from .logger import DTSLogger, get_dts_logger
 
 if TYPE_CHECKING:
-    from framework.context import Context
+    from api.context import Context
 
 
 class BaseConfig(FrozenModel):
@@ -92,7 +92,7 @@ def __init__(self, config: BaseConfig) -> None:
         Args:
             config: The test suite configuration.
         """
-        from framework.context import get_ctx
+        from api.context import get_ctx
 
         self.config = config
         self._ctx = get_ctx()
diff --git a/dts/framework/testbed_model/node.py b/dts/framework/testbed_model/node.py
index 4f42bf6aeb..40dd7f0666 100644
--- a/dts/framework/testbed_model/node.py
+++ b/dts/framework/testbed_model/node.py
@@ -242,7 +242,7 @@ def get_node(node_identifier: NodeIdentifier) -> Node | None:
     if node_identifier == "local":
         return None
 
-    from framework.context import get_ctx
+    from api.context import get_ctx
 
     ctx = get_ctx()
     if node_identifier == "sut":
diff --git a/dts/framework/testbed_model/topology.py b/dts/framework/testbed_model/topology.py
index 805a762c19..5b6ff2add5 100644
--- a/dts/framework/testbed_model/topology.py
+++ b/dts/framework/testbed_model/topology.py
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
diff --git a/dts/tests/TestSuite_cryptodev_throughput.py b/dts/tests/TestSuite_cryptodev_throughput.py
index f36b48a153..39784cbcac 100644
--- a/dts/tests/TestSuite_cryptodev_throughput.py
+++ b/dts/tests/TestSuite_cryptodev_throughput.py
@@ -31,7 +31,7 @@
 )
 from api.exception import SkippedTestException
 from api.test import verify
-from framework.context import get_ctx
+from api.context import get_ctx
 from framework.test_suite import BaseConfig, TestSuite, crypto_test
 from framework.testbed_model.virtual_device import VirtualDevice
 
diff --git a/dts/tests/TestSuite_l2fwd.py b/dts/tests/TestSuite_l2fwd.py
index 1e99b82b8c..c018efb1f7 100644
--- a/dts/tests/TestSuite_l2fwd.py
+++ b/dts/tests/TestSuite_l2fwd.py
@@ -21,7 +21,7 @@
 from api.testpmd import TestPmd
 from api.testpmd.config import EthPeer, SimpleForwardingModes
 from api.utils import generate_random_packets
-from framework.context import filter_cores
+from api.context import filter_cores
 from framework.test_suite import TestSuite, func_test
 from framework.testbed_model.cpu import LogicalCoreCount
 
-- 
2.52.0

