Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17535FDEE2C
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Apr 2026 17:04:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6275040679;
	Thu, 23 Apr 2026 19:03:44 +0200 (CEST)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com
 [209.85.222.182])
 by mails.dpdk.org (Postfix) with ESMTP id 60C734028F
 for <dev@dpdk.org>; Thu, 23 Apr 2026 19:03:40 +0200 (CEST)
Received: by mail-qk1-f182.google.com with SMTP id
 af79cd13be357-8d65f4073bfso938427585a.3
 for <dev@dpdk.org>; Thu, 23 Apr 2026 10:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1776963820; x=1777568620; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8RBklNFhlE98ftxQ5bG4U7awf3k0vlcmr4LR9KkZP0Q=;
 b=QcmTgmtSEzB2WrykcSJPovONOFJqRmYYGvMaU6QZOw/j+oSvWMwcLKwsdnfucByuI+
 7rqfefoH9gbG5h2V6IeXIXMIRzp+4ZyRMp2kzdVeEXuM4UQuSKoPdafUDo2DGkvEX58V
 KkeEqx3euu3Mk4PujJPWUnrMPRlkPzTrhk42M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776963820; x=1777568620;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8RBklNFhlE98ftxQ5bG4U7awf3k0vlcmr4LR9KkZP0Q=;
 b=JO891IDcUHstOXV9xxGIK7K2KC60FrCHiT7spR5NLf/Ot4DemouHhHAFDMaTuRT5MN
 dILqDGnwH7Vk8ztGUDUim1/hhZKY/BERFk87IU0St1DusYVfClde7ImtwkuON0gFdVoM
 tWorZZO+Mu2T4Wvo/aL3P3WiWm4r/mBorHNy/w4wG+hqn5uIwTt+Q1RdnN5ArJlRnnne
 wFUrd9gJjzGeVVD1Bb+bDy91j4i5ZSwNBJMEBCuJdC+EpNFOb7GqcrgbK+ZcnE0IyoUh
 UYQ1ENIO1QpBWE9DO+QMBjETCwvyYAxS1Be1neqySIoRwHhJJ996RMCK6JW6fNim9hJj
 9pyA==
X-Gm-Message-State: AOJu0YwacgkskQF00gswnxAjaXmsyBNMpfO/PniiclbIwN1JiuAO2r1t
 7VPYGbwIHGT3xOvNT9ma/8CpBNT3jzU5xikD9BNhgNdxvFGyJXzgnlhYbg1muetWQpQ=
X-Gm-Gg: AeBDievuvF0uGHw1L11pMnNR3MnH64bR991M47J9VnRYzeUe6NWAXjz4LXe83DYCkGJ
 kuviLRK+KP8uGcSs0jiFiw2FhAehQhiwPHlcCuXKiy8s6MAH3pW+FPmvAxXTCZAGkvZrCmNVVUO
 0o6sK1hnCxSDl5gofvEA+WVMMUQ28Wz9W2w3qdQKZP0WE1OFrRd1WorQbDH9/Q2+Dk2z/hmu6c7
 47vwzC5CNrQJulteAYrWAdXarb3VVz9obyZAIRTtAyFy32S3sMfBTyu3O6pPv38jb3kcB7jwiYa
 MIw0C5EXf9m3cqYgTtICSU0HqBNL0CClRSPDoTVHMyhtrD/yw3PQUDhIWEKMesFvwbJn1avObB7
 jWRO9Yl/1N+hiBQhkgYaP8Iv9nwc/c2M2AIYc/jjYUmXUv1mY4aO0AUWb7DvQwXj44UY7N/00BO
 hwtKyW3jXxhKNZcMpOgH7PS4Wi1SvP1bHVkOio+zX4Besn+5od8gZVEH6A6IoNh6+iabn/AkaF
X-Received: by 2002:a05:620a:400d:b0:8ed:e1d4:1644 with SMTP id
 af79cd13be357-8ede1d44bc1mr2029852085a.3.1776963819453; 
 Thu, 23 Apr 2026 10:03:39 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:ac5d:4186:4dc6:47eb])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8e7d8edb734sm1869831585a.29.2026.04.23.10.03.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 10:03:38 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: patrickrobb1997@gmail.com, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v1 5/8] dts: move context from framework to API
Date: Thu, 23 Apr 2026 13:03:17 -0400
Message-ID: <20260423170331.33193-6-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260423170331.33193-1-dmarx@iol.unh.edu>
References: <20240925192013.17446-1-jspewock@iol.unh.edu>
 <20260423170331.33193-1-dmarx@iol.unh.edu>
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
 dts/api/artifact.py                               |  2 +-
 dts/{framework => api}/context.py                 |  0
 dts/api/cryptodev/__init__.py                     |  2 +-
 dts/api/packet.py                                 |  4 ++--
 dts/api/test.py                                   |  2 +-
 dts/api/test_suite.py                             |  4 ++--
 dts/api/testbed_model/node.py                     |  2 +-
 dts/api/testbed_model/topology.py                 | 14 +++++++-------
 dts/api/testpmd/__init__.py                       |  2 +-
 dts/framework/remote_session/blocking_app.py      |  2 +-
 dts/framework/remote_session/dpdk.py              |  2 +-
 dts/framework/remote_session/dpdk_shell.py        |  2 +-
 dts/framework/remote_session/interactive_shell.py |  2 +-
 dts/framework/test_run.py                         |  2 +-
 dts/tests/TestSuite_cryptodev_throughput.py       |  2 +-
 dts/tests/TestSuite_l2fwd.py                      |  2 +-
 16 files changed, 23 insertions(+), 23 deletions(-)
 rename dts/{framework => api}/context.py (100%)

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

