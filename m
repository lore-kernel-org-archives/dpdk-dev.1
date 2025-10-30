Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FA0CCF9F0
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Oct 2025 12:52:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6061B402A6;
	Thu, 30 Oct 2025 13:52:43 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 92C234026F
 for <dev@dpdk.org>; Thu, 30 Oct 2025 13:52:41 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E49201AC1;
 Thu, 30 Oct 2025 05:52:32 -0700 (PDT)
Received: from paul-pc.localdomain (unknown [10.57.2.143])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E04673F673;
 Thu, 30 Oct 2025 05:52:39 -0700 (PDT)
From: Paul Szczepanek <paul.szczepanek@arm.com>
To: dev@dpdk.org
Cc: probb@iol.unh.edu, Paul Szczepanek <paul.szczepanek@arm.com>,
 Luca Vizzarro <luca.vizzarro@arm.com>
Subject: [PATCH v1] dts: move artifact class to API
Date: Thu, 30 Oct 2025 12:52:31 +0000
Message-Id: <20251030125231.114295-1-paul.szczepanek@arm.com>
X-Mailer: git-send-email 2.39.5
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

Moved the artifact module to API and
updated docs and tests to match the move.

Signed-off-by: Paul Szczepanek <paul.szczepanek@arm.com>
Reviewed-by: Luca Vizzarro <luca.vizzarro@arm.com>
---
 ...{framework.testbed_model.artifact.rst => api.artifact.rst} | 2 +-
 doc/api/dts/api.rst                                           | 1 +
 doc/api/dts/framework.testbed_model.rst                       | 1 -
 dts/{framework/testbed_model => api}/artifact.py              | 2 +-
 dts/framework/logger.py                                       | 4 ++--
 .../traffic_generator/capturing_traffic_generator.py          | 2 +-
 dts/tests/TestSuite_packet_capture.py                         | 2 +-
 dts/tests/TestSuite_softnic.py                                | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)
 rename doc/api/dts/{framework.testbed_model.artifact.rst => api.artifact.rst} (72%)
 rename dts/{framework/testbed_model => api}/artifact.py (99%)

diff --git a/doc/api/dts/framework.testbed_model.artifact.rst b/doc/api/dts/api.artifact.rst
similarity index 72%
rename from doc/api/dts/framework.testbed_model.artifact.rst
rename to doc/api/dts/api.artifact.rst
index 1b941b9a95..3a55473d28 100644
--- a/doc/api/dts/framework.testbed_model.artifact.rst
+++ b/doc/api/dts/api.artifact.rst
@@ -3,6 +3,6 @@
 artifact - File Management
 ==========================

-.. automodule:: framework.testbed_model.artifact
+.. automodule:: api.artifact
    :members:
    :show-inheritance:
diff --git a/doc/api/dts/api.rst b/doc/api/dts/api.rst
index 2734b633be..ec9d2beda7 100644
--- a/doc/api/dts/api.rst
+++ b/doc/api/dts/api.rst
@@ -17,6 +17,7 @@ api - DTS API
    :hidden:
    :maxdepth: 1

+   api.artifact
    api.capabilities
    api.packet
    api.test
diff --git a/doc/api/dts/framework.testbed_model.rst b/doc/api/dts/framework.testbed_model.rst
index 59429e5cd9..f283178f6a 100644
--- a/doc/api/dts/framework.testbed_model.rst
+++ b/doc/api/dts/framework.testbed_model.rst
@@ -17,7 +17,6 @@ testbed\_model - Testbed Modelling Package
    :hidden:
    :maxdepth: 1

-   framework.testbed_model.artifact
    framework.testbed_model.os_session
    framework.testbed_model.linux_session
    framework.testbed_model.posix_session
diff --git a/dts/framework/testbed_model/artifact.py b/dts/api/artifact.py
similarity index 99%
rename from dts/framework/testbed_model/artifact.py
rename to dts/api/artifact.py
index 9b4caacae2..24a2b05063 100644
--- a/dts/framework/testbed_model/artifact.py
+++ b/dts/api/artifact.py
@@ -10,7 +10,7 @@

     .. code:: python

-        from framework.testbed_model.artifact import Artifact
+        from api.artifact import Artifact

         # Create an artifact on a remote node
         artifact = Artifact(node="sut", file_name="example.txt")
diff --git a/dts/framework/logger.py b/dts/framework/logger.py
index 58f26f93ef..67b180bca2 100644
--- a/dts/framework/logger.py
+++ b/dts/framework/logger.py
@@ -18,7 +18,7 @@
 from typing import TYPE_CHECKING, Any, ClassVar, NamedTuple

 if TYPE_CHECKING:
-    from framework.testbed_model.artifact import Artifact
+    from api.artifact import Artifact

 date_fmt = "%Y/%m/%d %H:%M:%S"
 stream_fmt = "%(asctime)s - %(stage)s - %(name)s - %(levelname)s - %(message)s"
@@ -140,7 +140,7 @@ def _add_artifact_handlers(self, log_file_name: str) -> list[ArtifactHandler]:
         Returns:
             The newly created artifact handlers.
         """
-        from framework.testbed_model.artifact import Artifact
+        from api.artifact import Artifact

         log_artifact = Artifact("local", f"{log_file_name}.log")
         handler = StreamHandler(log_artifact.open("w"))
diff --git a/dts/framework/testbed_model/traffic_generator/capturing_traffic_generator.py b/dts/framework/testbed_model/traffic_generator/capturing_traffic_generator.py
index ec0993e6b7..6f7ae022dd 100644
--- a/dts/framework/testbed_model/traffic_generator/capturing_traffic_generator.py
+++ b/dts/framework/testbed_model/traffic_generator/capturing_traffic_generator.py
@@ -16,7 +16,7 @@
 import scapy.utils
 from scapy.packet import Packet

-from framework.testbed_model.artifact import Artifact
+from api.artifact import Artifact
 from framework.testbed_model.port import Port
 from framework.utils import get_packet_summaries

diff --git a/dts/tests/TestSuite_packet_capture.py b/dts/tests/TestSuite_packet_capture.py
index 3873cf622f..4bd15e2401 100644
--- a/dts/tests/TestSuite_packet_capture.py
+++ b/dts/tests/TestSuite_packet_capture.py
@@ -25,6 +25,7 @@
 from scapy.packet import Packet, Raw, raw
 from scapy.utils import rdpcap

+from api.artifact import Artifact
 from api.capabilities import (
     LinkTopology,
     requires_link_topology,
@@ -40,7 +41,6 @@
 from framework.remote_session.blocking_app import BlockingApp
 from framework.remote_session.dpdk_shell import compute_eal_params
 from framework.test_suite import TestSuite, func_test
-from framework.testbed_model.artifact import Artifact
 from framework.testbed_model.cpu import LogicalCoreList
 from framework.testbed_model.traffic_generator.capturing_traffic_generator import (
     PacketFilteringConfig,
diff --git a/dts/tests/TestSuite_softnic.py b/dts/tests/TestSuite_softnic.py
index c786e23d33..fa91f7ee2f 100644
--- a/dts/tests/TestSuite_softnic.py
+++ b/dts/tests/TestSuite_softnic.py
@@ -6,6 +6,7 @@
 Create a softnic virtual device and verify it successfully forwards packets.
 """

+from api.artifact import Artifact
 from api.capabilities import (
     LinkTopology,
     NicCapability,
@@ -20,7 +21,6 @@
 from api.testpmd import TestPmd
 from api.testpmd.config import EthPeer
 from framework.test_suite import TestSuite, func_test
-from framework.testbed_model.artifact import Artifact
 from framework.testbed_model.virtual_device import VirtualDevice
 from framework.utils import generate_random_packets

--
2.39.5

