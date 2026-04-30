Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF3ECCFA13
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Apr 2026 22:07:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 740324068E;
	Fri,  1 May 2026 00:06:48 +0200 (CEST)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com
 [209.85.221.182])
 by mails.dpdk.org (Postfix) with ESMTP id E9EBF40659
 for <dev@dpdk.org>; Fri,  1 May 2026 00:06:45 +0200 (CEST)
Received: by mail-vk1-f182.google.com with SMTP id
 71dfb90a1353d-56eec951db1so494639e0c.3
 for <dev@dpdk.org>; Thu, 30 Apr 2026 15:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1777586805; x=1778191605; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TPCPst9vo3Xsc8FHL6NQx7VvJJy86rHjS0ttv0htqGc=;
 b=DH94BmaGhhJ7kKWAD47Aoulugvc9VCwP8GfTpaNwNfw4ABFZbSZpQNajgNVEh5+XFC
 T3rYISm16VbrS+lGEqY0w3NaqfDpatJRo9nCGML4RKrattXFsOC3HvZVOdmlp8sXeWj+
 OFuTUR6UbRAcDqx1j2O9Ydjxv3H8+rJTJKdSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777586805; x=1778191605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TPCPst9vo3Xsc8FHL6NQx7VvJJy86rHjS0ttv0htqGc=;
 b=PPHmBJnu2BW+DQlkMaZyo1+fv1zi+Xwv+rT1v2+0Kf9wiOHSCTXuzjT6EL9prgKd+C
 VT5b+4AdRB55gk6BD5PnB+9rigG7H6NMbHKfH/LRMxb97W8ecI9drykE1stb6Bf635MG
 m0v3WwJ69kTBwvtUy+5qJFDNI4WWFVd2L/BoS8gSJM3X/ZUkrTjdZogRRLGgZCed5ad1
 9k41H+p498ojiW59Jb+F/gW9FKvApaDVtiq3/yasAeMSsjFh4MQOsGZ+YEs+UU5W4UL4
 cV6Q4UPzmsWwM6KyoDugp1bgJWrioUs3mpS2lITo/Q9AWI9QUO6jEua97A+EriTTBc3f
 hrtg==
X-Gm-Message-State: AOJu0YwLKn5Zuo22EO4Ol9NWDn08J0FzmnU/1Iwh7UO/D/40LsGaVErO
 qThnqIcILPp3OQ6TZrB7iaYfzPVh08uaJPzo1Nh0K7lo1cXetsaQKPyCbnG23wt0FmY=
X-Gm-Gg: AeBDietWPb+RdgU0zbTT8T0YYzqdEpRigZSTxYxdntQt1eNnmxhp6tR+sB+ZU+zpVbI
 MpfZ2OQKQXCQdCd8HOCHox41g3i6SsAH7hEY3zSXypic+6mVfsEnnDJ48oaU8231ZTCU0vTnCQs
 eLNU7l8AgyqTlJz4vFBy8utNKOGLiZRpGnqQysBB2SNnHy2tO2hKMf/kElcQwf17rDYa0uM0ZEo
 WY54rmnl7qagzDNRbtt70L1+AAWJkqR3ZnhKO1xLs5jxT52ETmxk9bGOZPOFjqYALqcYM2DTMHl
 /Lg7PBt2/hehfXdjTnKlhXpH8qtSxCWlCb06dcs1T5AW4OVaQHFQu1eAvAcPMgGxk6YQVmwFTct
 y67sGSvwbpp397zZzWmE9sq5+YaK1HVemDecUoJAzu8H9TPONuGGAX/xcGZTD/Wkf2xkp7hWyB+
 y9ii6cQeVCp+cYxnIE/yD33Gri8BPZZbCQGncEtKqLcRbVx+3o5YedSDvBNjg0jODPYjg99l5V
X-Received: by 2002:a05:6122:c82:b0:56f:b2df:1791 with SMTP id
 71dfb90a1353d-574beafcceamr273042e0c.9.1777586805026; 
 Thu, 30 Apr 2026 15:06:45 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:ac5d:4186:4dc6:47eb])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b53d83114fsm3146136d6.48.2026.04.30.15.06.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 15:06:44 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: patrickrobb1997@gmail.com, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v4 3/7] dts: move context from framework to API
Date: Thu, 30 Apr 2026 18:06:34 -0400
Message-ID: <20260430220638.30666-4-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260430220638.30666-1-dmarx@iol.unh.edu>
References: <20260424170139.20592-1-dmarx@iol.unh.edu>
 <20260430220638.30666-1-dmarx@iol.unh.edu>
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

