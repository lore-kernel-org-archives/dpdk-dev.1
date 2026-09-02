Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B394C61DD6
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Sep 2026 18:14:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A953D410FC;
	Wed,  2 Sep 2026 20:13:56 +0200 (CEST)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com
 [209.85.160.174])
 by mails.dpdk.org (Postfix) with ESMTP id 86AAF410F1
 for <dev@dpdk.org>; Wed,  2 Sep 2026 20:13:55 +0200 (CEST)
Received: by mail-qt1-f174.google.com with SMTP id
 d75a77b69052e-53031a57d7fso15945531cf.0
 for <dev@dpdk.org>; Wed, 02 Sep 2026 11:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1788372835; x=1788977635; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EIOo+CPBcXUEGuLN1qy/0Pdxnfs2AxwRB8ILzy9eI7E=;
 b=GxdTbS/1ULJnxGEaI01iLDfDcyZdYfxOS+oWOSfY9i9nZfFqD6OLy/rMk9/Vh2epFr
 Hq93P3uPEut7OM4ihOYsGz2aCbHeutrtLsKupZ/2cf7wYFXMMLkXykc4dz2k1kJsexxk
 Tdci73T2NMyllhh4w8+/eOBOyAIYv/4MV11hE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788372835; x=1788977635;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EIOo+CPBcXUEGuLN1qy/0Pdxnfs2AxwRB8ILzy9eI7E=;
 b=tZB6LksLuHKdeaej9R3yO87YD+GVkcw0f/9s1JEbuFrj77MemJ7Dz767VCqsipEkEK
 j5vEdklvEubp991ofCQdAGkds57sIAoBEC/sLy293bX3QNshObkJz6q15/6tPWpdJBbd
 40YHQW0UgfzaDVW+HXZSmjkWkTBghgfuB0n03rFn+DWwN/y6fkxn036iajMdGdwSRaNT
 HgxA5dNzYvp6WhabkpGUuY+OruYa/eXgu0jJ2Whnc4C60JNUn/VjJyIIQ0N9+0ThpT2P
 iykmNZ6VSqwN5zna7sDsDWJCJeT1n/RnClIZ6B/AAEbkze+MgWSzZ3wfIZeuJHBoBgHn
 BwLw==
X-Gm-Message-State: AFuF++kEST12cXzaROVtXnFjlYj8lQEJZuAzYZsBF8HcmpKoqMu5w/TN
 DnJrA2YQXXbyKSU45L8l2sIVoB1lSYpyQ4ox9mLpZv8pth9jiqfDEwBhWcZAoTLGCjxg2t9yZ/v
 XDaT3AKmCpzmV6PNdRci5bwGu1xBA8Riro8gpAUHAQYqtMoGM7Zdmx0ZhQ3D3PtC+9R2T/nDvp0
 rNzw1Fni+9bfYxZdJ/NREHqMq/iRo=
X-Gm-Gg: AYBFou1q5Zty5rvKBO6wRnNMOmKyDIP+nmJWqlIuKtlOeVMn43FKJVMqFdkney1xhX+
 g3NmqazCH/99QGBASYuiCXjb00tmNsfgka1UiDHwVqji1OLm98c5dE70MDBNzY//c2eHl3TVtPx
 ymAJHGyRUa+4ez0vavQVnMuMPRgKTsTeseNtSnQNJUzuZtigM+cJNRnIzpqzep9hFJZaMe29DhF
 9AemhdXh/IBtN2acGq9o7mntdZifOwu/BUnhn+bV1gzhTH122O2r8DeS2M/W0yJynyw1BS383Tu
 jmH4cC9ZM8FxvCpi5YyElWpJKTvY78eXzxP9lGS/3pFEj4yav6qXfVg4Iyyvo1S435mNTO2pfVK
 WsmPQYZguEjPkEiq1yK6kqPLrrLQ68rgIrd+49boG7b7gTBepOFE58ma+R4e07JBmGeKJiE75JB
 Ff31UWHWf/qj9NNmAKis0b5nzm2ArSPKan9/LY+4mtGlQov2Zk9tTYArBoxqloNclzCJ1N7jWf+
 eKIlNc4xHM=
X-Received: by 2002:a05:622a:2592:b0:530:26fa:41b8 with SMTP id
 d75a77b69052e-53036c4b52bmr82794061cf.17.1788372834613; 
 Wed, 02 Sep 2026 11:13:54 -0700 (PDT)
Received: from d121029.iol.unh.edu ([2606:4100:3880:1210::219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-530331d9cbcsm24660101cf.16.2026.09.02.11.13.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 11:13:54 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: dev@dpdk.org,
	luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: knimoji@iol.unh.edu, lylavoie@iol.unh.edu, dladd@iol.unh.edu,
 Andrew Bailey <abailey@iol.unh.edu>, Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v6 3/8] dts: move context from framework to API
Date: Wed,  2 Sep 2026 14:13:27 -0400
Message-ID: <20260902181333.461556-4-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902181333.461556-1-abailey@iol.unh.edu>
References: <20260806135346.568766-1-abailey@iol.unh.edu>
 <20260902181333.461556-1-abailey@iol.unh.edu>
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

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
---
 ...{framework.context.rst => api.context.rst} |  2 +-
 doc/api/dts/index.rst                         |  2 +-
 dts/api/artifact.py                           |  2 +-
 dts/api/context.py                            | 30 +++++++++++++++++++
 dts/api/cryptodev/__init__.py                 |  2 +-
 dts/api/packet.py                             |  4 +--
 dts/api/test.py                               |  2 +-
 dts/api/testpmd/__init__.py                   |  2 +-
 dts/framework/remote_session/blocking_app.py  |  2 +-
 dts/framework/remote_session/dpdk.py          |  2 +-
 dts/framework/remote_session/dpdk_shell.py    |  2 +-
 .../remote_session/interactive_shell.py       |  2 +-
 dts/framework/test_run.py                     |  2 +-
 dts/framework/test_suite.py                   |  4 +--
 dts/framework/testbed_model/node.py           |  2 +-
 dts/framework/testbed_model/topology.py       | 14 ++++-----
 dts/tests/TestSuite_cryptodev_latency.py      |  2 +-
 dts/tests/TestSuite_cryptodev_throughput.py   |  2 +-
 dts/tests/TestSuite_l2fwd.py                  |  2 +-
 19 files changed, 56 insertions(+), 26 deletions(-)
 rename doc/api/dts/{framework.context.rst => api.context.rst} (80%)
 create mode 100644 dts/api/context.py

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
diff --git a/dts/api/context.py b/dts/api/context.py
new file mode 100644
index 0000000000..a3cee7f17a
--- /dev/null
+++ b/dts/api/context.py
@@ -0,0 +1,30 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2025 Arm Limited
+
+"""Runtime contexts."""
+
+from collections.abc import Callable
+
+from framework.context import Context
+from framework.context import filter_cores as _filter_cores
+from framework.context import get_ctx as _get_ctx
+from framework.context import init_ctx as _init_ctx
+from framework.testbed_model.capability import TestProtocol
+from framework.testbed_model.cpu import LogicalCoreCount, LogicalCoreList
+
+
+def get_ctx() -> Context:
+    """Retrieve the current runtime context."""
+    return _get_ctx()
+
+
+def init_ctx(ctx: Context) -> None:
+    """Initialize context."""
+    _init_ctx(ctx)
+
+
+def filter_cores(
+    specifier: LogicalCoreCount | LogicalCoreList, ascending_cores: bool | None = None
+) -> Callable[[type["TestProtocol"]], Callable]:
+    """Decorates functions that require a temporary update to the lcore specifier."""
+    return _filter_cores(specifier, ascending_cores)
diff --git a/dts/api/cryptodev/__init__.py b/dts/api/cryptodev/__init__.py
index 335b811620..198607696f 100644
--- a/dts/api/cryptodev/__init__.py
+++ b/dts/api/cryptodev/__init__.py
@@ -14,6 +14,7 @@
 
 from typing_extensions import Unpack
 
+from api.context import get_ctx
 from api.cryptodev.config import CryptoPmdParams, TestType
 from api.cryptodev.types import (
     CryptodevResults,
@@ -23,7 +24,6 @@
     VerifyResults,
 )
 from api.exception import RemoteCommandExecutionError, SkippedTestException
-from framework.context import get_ctx
 from framework.remote_session.dpdk_shell import compute_eal_params
 
 if TYPE_CHECKING:
diff --git a/dts/api/packet.py b/dts/api/packet.py
index e18765bfb1..3fd6060234 100644
--- a/dts/api/packet.py
+++ b/dts/api/packet.py
@@ -27,10 +27,10 @@
 from scapy.layers.l2 import Ether
 from scapy.packet import Packet, Padding, raw
 
+from api.context import get_ctx
 from api.exception import InternalError
 from api.test import fail, log_debug
 from api.utils import get_packet_summaries
-from framework.context import get_ctx
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
index 29d6842111..b6caf5c1ae 100644
--- a/dts/api/test.py
+++ b/dts/api/test.py
@@ -11,8 +11,8 @@
 
 from api.artifact import Artifact
 from api.capabilities import LinkTopology
+from api.context import get_ctx
 from api.exception import InternalError, SkippedTestException, TestCaseVerifyError
-from framework.context import get_ctx
 from framework.logger import DTSLogger
 
 
diff --git a/dts/api/testpmd/__init__.py b/dts/api/testpmd/__init__.py
index e0b58e54fe..d8985e429b 100644
--- a/dts/api/testpmd/__init__.py
+++ b/dts/api/testpmd/__init__.py
@@ -32,6 +32,7 @@
 from typing_extensions import Unpack
 
 from api.capabilities import LinkTopology, NicCapability
+from api.context import get_ctx
 from api.exception import InteractiveCommandExecutionError, InternalError
 from api.testpmd.config import PortTopology, SimpleForwardingModes, TestPmdParams
 from api.testpmd.types import (
@@ -55,7 +56,6 @@
     TxOffloadConfiguration,
     VLANOffloadFlag,
 )
-from framework.context import get_ctx
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
index 8b85e118da..2d8bc7844e 100644
--- a/dts/framework/remote_session/dpdk.py
+++ b/dts/framework/remote_session/dpdk.py
@@ -14,6 +14,7 @@
 from typing import ClassVar, Final
 
 from api.capabilities import LinkTopology
+from api.context import get_ctx
 from api.exception import ConfigurationError, RemoteFileNotFoundError
 from api.utils import MesonArgs, TarCompressionFormat
 from framework.config.test_run import (
@@ -27,7 +28,6 @@
     RemoteDPDKTarballLocation,
     RemoteDPDKTreeLocation,
 )
-from framework.context import get_ctx
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
index 367a01714d..362bc2a352 100644
--- a/dts/framework/remote_session/interactive_shell.py
+++ b/dts/framework/remote_session/interactive_shell.py
@@ -29,12 +29,12 @@
 from paramiko import Channel, channel
 from typing_extensions import Self
 
+from api.context import get_ctx
 from api.exception import (
     InteractiveCommandExecutionError,
     InteractiveSSHSessionDeadError,
     InteractiveSSHTimeoutError,
 )
-from framework.context import get_ctx
 from framework.logger import DTSLogger, get_dts_logger
 from framework.params import Params
 from framework.settings import SETTINGS
diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py
index 75d82c1104..8b9ae4a49a 100644
--- a/dts/framework/test_run.py
+++ b/dts/framework/test_run.py
@@ -108,9 +108,9 @@
 from typing import ClassVar, Protocol, Union
 
 from api.capabilities import LinkTopology
+from api.context import Context, init_ctx
 from api.exception import InternalError, SkippedTestException, TestCaseVerifyError
 from framework.config.test_run import TestRunConfiguration
-from framework.context import Context, init_ctx
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
index 002faf0b7f..6b8c5edee5 100644
--- a/dts/framework/testbed_model/topology.py
+++ b/dts/framework/testbed_model/topology.py
@@ -98,7 +98,7 @@ def node_and_ports_from_id(self, node_identifier: NodeIdentifier) -> tuple[Node,
         Raises:
             InternalError: If the given `node_identifier` is invalid.
         """
-        from framework.context import get_ctx
+        from api.context import get_ctx
 
         ctx = get_ctx()
         match node_identifier:
@@ -188,7 +188,7 @@ def instantiate_crypto_ports(self) -> None:
         Raises:
             InternalError: If crypto virtual functions could not be created on a port.
         """
-        from framework.context import get_ctx
+        from api.context import get_ctx
 
         ctx = get_ctx()
         for port in ctx.sut_node.cryptodevs:
@@ -214,7 +214,7 @@ def instantiate_vf_ports(self) -> None:
         Raises:
             InternalError: If virtual function creation fails.
         """
-        from framework.context import get_ctx
+        from api.context import get_ctx
 
         ctx = get_ctx()
 
@@ -243,7 +243,7 @@ def instantiate_vf_ports(self) -> None:
 
     def delete_vf_ports(self) -> None:
         """Delete virtual functions from the SUT node during test run teardown."""
-        from framework.context import get_ctx
+        from api.context import get_ctx
 
         ctx = get_ctx()
 
@@ -254,7 +254,7 @@ def delete_vf_ports(self) -> None:
 
     def delete_crypto_vf_ports(self) -> None:
         """Delete crypto virtual functions from the SUT node during test run teardown."""
-        from framework.context import get_ctx
+        from api.context import get_ctx
 
         ctx = get_ctx()
 
@@ -267,7 +267,7 @@ def bind_cryptodevs(self, driver: DriverKind):
         Args:
             driver: The driver to bind the crypto functions
         """
-        from framework.context import get_ctx
+        from api.context import get_ctx
 
         self._bind_ports_to_drivers(get_ctx().sut_node, self.crypto_vf_ports, driver)
 
@@ -326,7 +326,7 @@ def _prepare_devbind_script(self) -> None:
         Raises:
             InternalError: If dpdk-devbind.py could not be found.
         """
-        from framework.context import get_ctx
+        from api.context import get_ctx
 
         local_script_path = Path("..", "usertools", "dpdk-devbind.py").resolve()
         valid_script_path = local_script_path.exists()
diff --git a/dts/tests/TestSuite_cryptodev_latency.py b/dts/tests/TestSuite_cryptodev_latency.py
index 4e7d814faa..ed6423eb26 100644
--- a/dts/tests/TestSuite_cryptodev_latency.py
+++ b/dts/tests/TestSuite_cryptodev_latency.py
@@ -13,6 +13,7 @@
     LinkTopology,
     requires_link_topology,
 )
+from api.context import get_ctx
 from api.cryptodev import Cryptodev
 from api.cryptodev.config import (
     AeadAlgName,
@@ -30,7 +31,6 @@
     CryptodevResults,
 )
 from api.test import skip, verify
-from framework.context import get_ctx
 from framework.test_suite import BaseConfig, TestSuite, crypto_test
 from framework.testbed_model.virtual_device import VirtualDevice
 
diff --git a/dts/tests/TestSuite_cryptodev_throughput.py b/dts/tests/TestSuite_cryptodev_throughput.py
index 53682f35fa..d69714e1fa 100644
--- a/dts/tests/TestSuite_cryptodev_throughput.py
+++ b/dts/tests/TestSuite_cryptodev_throughput.py
@@ -13,6 +13,7 @@
     LinkTopology,
     requires_link_topology,
 )
+from api.context import get_ctx
 from api.cryptodev import Cryptodev
 from api.cryptodev.config import (
     AeadAlgName,
@@ -30,7 +31,6 @@
     CryptodevResults,
 )
 from api.test import skip, verify
-from framework.context import get_ctx
 from framework.test_suite import BaseConfig, TestSuite, crypto_test
 from framework.testbed_model.virtual_device import VirtualDevice
 
diff --git a/dts/tests/TestSuite_l2fwd.py b/dts/tests/TestSuite_l2fwd.py
index 1e99b82b8c..574842e2e4 100644
--- a/dts/tests/TestSuite_l2fwd.py
+++ b/dts/tests/TestSuite_l2fwd.py
@@ -13,6 +13,7 @@
     requires_link_topology,
     requires_nic_capability,
 )
+from api.context import filter_cores
 from api.packet import (
     get_expected_packets,
     match_all_packets,
@@ -21,7 +22,6 @@
 from api.testpmd import TestPmd
 from api.testpmd.config import EthPeer, SimpleForwardingModes
 from api.utils import generate_random_packets
-from framework.context import filter_cores
 from framework.test_suite import TestSuite, func_test
 from framework.testbed_model.cpu import LogicalCoreCount
 
-- 
2.55.0

