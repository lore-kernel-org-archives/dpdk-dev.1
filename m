Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12693C624D3
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Sep 2026 18:14:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2109B4161A;
	Wed,  2 Sep 2026 20:14:00 +0200 (CEST)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com
 [209.85.160.176])
 by mails.dpdk.org (Postfix) with ESMTP id 61B59410DD
 for <dev@dpdk.org>; Wed,  2 Sep 2026 20:13:58 +0200 (CEST)
Received: by mail-qt1-f176.google.com with SMTP id
 d75a77b69052e-52cd38ddcdfso13050781cf.3
 for <dev@dpdk.org>; Wed, 02 Sep 2026 11:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1788372838; x=1788977638; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=F+kpsNT6sLcJR/+40lGHXC2aazF/yWzyGs2Ka/uPJG0=;
 b=Z1sxqDyTFHwo7OSequI7k/Y5LqJ7umacRvT41ASDBlECCFEssHh8GpV4BHbmV8gqSm
 UCz2rX3+PmWhj7OjLAxJZWIhycZY//twl1RRscDLsoHKE7eMIERJPrJssPMl3aTxY1/x
 C28xYO1v2UAV0AHMrx2Ptpst9opYz8qc70dDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788372838; x=1788977638;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=F+kpsNT6sLcJR/+40lGHXC2aazF/yWzyGs2Ka/uPJG0=;
 b=m1p3XDzBmxFCeuNWRsIomySB7FNIR/IKcBZaIboCEVCogv9CZOZaF735AW/glrlRBD
 vIXRWCXYSz+TRKpkuk21ZJB0MQzzj88O8Sib8LjGAGV1YHXZD8HZcKpJi5+bFI8/3/6g
 JnyMUv+shi4Cs9KwDNnm1obEKmMCsLFhg39qnyv9y8KA9lLvVJtTQ7x0v3om4mvipSbM
 lc2BWFIbzwlGJ97uGbgLAR2PbwDhoV4e2ErEU7OnI2Wtp1ll6BYzZ6yRPaDz4pj4/l86
 KHqbr46rLy51GGFLgg2SL2T54UMyKZAFUZ6ieD3jAAHVD3uHWSmut7FO0DnHgWSzmL8l
 aIEQ==
X-Gm-Message-State: AFuF++mUQbyw0eRpmMbE4xkUwzkdREgR2Zk6/Q4eU/VsNsuOfJKHQX9s
 WmszU5icMveQVPMn7M5ASl3WOIDhxUVB/oErFeA1/ipGcdnWgzcWSVu4A4JB5UJjDoljb8tjiP+
 M6Qh9cvwz556ZlzL7z+3Fdo+9QeBRLCPR9qFRy4Xhtiv6QXRXYk2J5e/HjrHgKIizN454KyaGqb
 FTCnT+eiOVO5OiIEyDxujzdQ0rss4=
X-Gm-Gg: AR+sD12s0W8c6iyJuA6pH8Lc39BsnhJAz1GZ3fBAYZoBcAl10eaKZ2wroc+1wp8+TnB
 vw7AUs7r9NPI5r7UUwMCNlkEdRFa252PmLHqRd/MBn/7Dl78dmjzN6ZdRwsdMThV6JJLyt82dIG
 wT9myAtgwqXts+pOtorh1Knq+NJhy5wwNOJBCDLoO1mY20JE5nbouy004lF7uIioXpBTBkEbag+
 imN7ZwYQRRrgu0bCmqblBkLLn/Y8/ukRm4HILqPjw9o5XDMjT9tEcHpncb9KOpp2Wsd4yOSfjDB
 6jpfPV4IyC04fvCdQvo5D2YD5FU/KU2JE5XtSMXV8yyzBcz3/7BneNUs9MFvGoaK84IEG6Bkpdz
 FimX6NaJD3c91kyUQ7Y7IzEvIoYw4ascSsgvrbSMBZmRWcYYyFWHA1FAJG+QIeTbzv3bChk0+cf
 3w7JNSMxqvUq2JIRCp+nM9HlHtvh3mWwc29NZHtIcABufoWMtUGcCe2fBmQzlRmxOSATr99mLH7
 hPDIZQINHs=
X-Received: by 2002:a05:622a:1822:b0:530:2f98:ccde with SMTP id
 d75a77b69052e-53036b895b0mr80170241cf.9.1788372837337; 
 Wed, 02 Sep 2026 11:13:57 -0700 (PDT)
Received: from d121029.iol.unh.edu ([2606:4100:3880:1210::219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-530331d9cbcsm24660101cf.16.2026.09.02.11.13.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 11:13:55 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: dev@dpdk.org,
	luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: knimoji@iol.unh.edu, lylavoie@iol.unh.edu, dladd@iol.unh.edu,
 Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v6 5/8] dts: port base traffic generators to API
Date: Wed,  2 Sep 2026 14:13:29 -0400
Message-ID: <20260902181333.461556-6-abailey@iol.unh.edu>
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

Some test suites import from the traffic generator package. Separate
this package into interface and logic for user import.

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
---
 doc/api/dts/api.testbed_model.rst                  | 14 ++++++++++++++
 ...ffic_generator.capturing_traffic_generator.rst} |  2 +-
 ...rst => api.testbed_model.traffic_generator.rst} |  6 +++---
 ..._model.traffic_generator.traffic_generator.rst} |  2 +-
 doc/api/dts/framework.testbed_model.rst            |  6 ------
 doc/api/dts/index.rst                              |  1 +
 dts/api/packet.py                                  | 12 +++++-------
 .../capturing_traffic_generator.py                 |  3 +--
 .../performance_traffic_generator.py               |  2 +-
 .../traffic_generator/traffic_generator.py         |  0
 dts/framework/context.py                           |  2 +-
 .../testbed_model/traffic_generator/__init__.py    |  2 +-
 .../testbed_model/traffic_generator/scapy.py       |  9 ++++-----
 .../testbed_model/traffic_generator/trex.py        |  8 ++++----
 dts/tests/TestSuite_packet_capture.py              |  4 +---
 dts/tests/TestSuite_virtio_forward.py              |  9 ++++-----
 16 files changed, 42 insertions(+), 40 deletions(-)
 create mode 100644 doc/api/dts/api.testbed_model.rst
 rename doc/api/dts/{framework.testbed_model.traffic_generator.capturing_traffic_generator.rst => api.testbed_model.traffic_generator.capturing_traffic_generator.rst} (68%)
 rename doc/api/dts/{framework.testbed_model.traffic_generator.rst => api.testbed_model.traffic_generator.rst} (54%)
 rename doc/api/dts/{framework.testbed_model.traffic_generator.traffic_generator.rst => api.testbed_model.traffic_generator.traffic_generator.rst} (65%)
 rename dts/{framework => api}/testbed_model/traffic_generator/capturing_traffic_generator.py (98%)
 rename dts/{framework => api}/testbed_model/traffic_generator/performance_traffic_generator.py (95%)
 rename dts/{framework => api}/testbed_model/traffic_generator/traffic_generator.py (100%)

diff --git a/doc/api/dts/api.testbed_model.rst b/doc/api/dts/api.testbed_model.rst
new file mode 100644
index 0000000000..900d8851fe
--- /dev/null
+++ b/doc/api/dts/api.testbed_model.rst
@@ -0,0 +1,14 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+
+testbed\_model - Testbed Modelling Package
+==========================================
+
+.. automodule:: api.testbed_model
+   :members:
+   :show-inheritance:
+
+.. toctree::
+   :hidden:
+   :maxdepth: 2
+
+   api.testbed_model.traffic_generator
\ No newline at end of file
diff --git a/doc/api/dts/framework.testbed_model.traffic_generator.capturing_traffic_generator.rst b/doc/api/dts/api.testbed_model.traffic_generator.capturing_traffic_generator.rst
similarity index 68%
rename from doc/api/dts/framework.testbed_model.traffic_generator.capturing_traffic_generator.rst
rename to doc/api/dts/api.testbed_model.traffic_generator.capturing_traffic_generator.rst
index 29fa834042..cfe03201a7 100644
--- a/doc/api/dts/framework.testbed_model.traffic_generator.capturing_traffic_generator.rst
+++ b/doc/api/dts/api.testbed_model.traffic_generator.capturing_traffic_generator.rst
@@ -3,6 +3,6 @@
 capturing\_traffic\_generator - Base Capturing TG ABC
 =====================================================
 
-.. automodule:: framework.testbed_model.traffic_generator.capturing_traffic_generator
+.. automodule:: api.testbed_model.traffic_generator.capturing_traffic_generator
    :members:
    :show-inheritance:
diff --git a/doc/api/dts/framework.testbed_model.traffic_generator.rst b/doc/api/dts/api.testbed_model.traffic_generator.rst
similarity index 54%
rename from doc/api/dts/framework.testbed_model.traffic_generator.rst
rename to doc/api/dts/api.testbed_model.traffic_generator.rst
index 24c250ee3a..a22e27a58b 100644
--- a/doc/api/dts/framework.testbed_model.traffic_generator.rst
+++ b/doc/api/dts/api.testbed_model.traffic_generator.rst
@@ -3,7 +3,7 @@
 traffic\_generator Subpackage
 =============================
 
-.. automodule:: framework.testbed_model.traffic_generator
+.. automodule:: api.testbed_model.traffic_generator
    :members:
    :show-inheritance:
 
@@ -11,6 +11,6 @@ traffic\_generator Subpackage
    :hidden:
    :maxdepth: 1
 
-   framework.testbed_model.traffic_generator.traffic_generator
-   framework.testbed_model.traffic_generator.capturing_traffic_generator
+   api.testbed_model.traffic_generator.traffic_generator
+   api.testbed_model.traffic_generator.capturing_traffic_generator
    framework.testbed_model.traffic_generator.scapy
diff --git a/doc/api/dts/framework.testbed_model.traffic_generator.traffic_generator.rst b/doc/api/dts/api.testbed_model.traffic_generator.traffic_generator.rst
similarity index 65%
rename from doc/api/dts/framework.testbed_model.traffic_generator.traffic_generator.rst
rename to doc/api/dts/api.testbed_model.traffic_generator.traffic_generator.rst
index bfec728dee..1045e534b5 100644
--- a/doc/api/dts/framework.testbed_model.traffic_generator.traffic_generator.rst
+++ b/doc/api/dts/api.testbed_model.traffic_generator.traffic_generator.rst
@@ -3,6 +3,6 @@
 traffic\_generator - Base TG ABC
 ================================
 
-.. automodule:: framework.testbed_model.traffic_generator.traffic_generator
+.. automodule:: api.testbed_model.traffic_generator.traffic_generator
    :members:
    :show-inheritance:
diff --git a/doc/api/dts/framework.testbed_model.rst b/doc/api/dts/framework.testbed_model.rst
index f283178f6a..f6fb410133 100644
--- a/doc/api/dts/framework.testbed_model.rst
+++ b/doc/api/dts/framework.testbed_model.rst
@@ -7,12 +7,6 @@ testbed\_model - Testbed Modelling Package
    :members:
    :show-inheritance:
 
-.. toctree::
-   :hidden:
-   :maxdepth: 2
-
-   framework.testbed_model.traffic_generator
-
 .. toctree::
    :hidden:
    :maxdepth: 1
diff --git a/doc/api/dts/index.rst b/doc/api/dts/index.rst
index 98269d6e80..d02bc59d2b 100644
--- a/doc/api/dts/index.rst
+++ b/doc/api/dts/index.rst
@@ -16,6 +16,7 @@ Packages
 
    tests
    api
+   api.testbed_model
    framework.testbed_model
    framework.remote_session
    framework.params
diff --git a/dts/api/packet.py b/dts/api/packet.py
index 3fd6060234..c6d014765f 100644
--- a/dts/api/packet.py
+++ b/dts/api/packet.py
@@ -30,13 +30,11 @@
 from api.context import get_ctx
 from api.exception import InternalError
 from api.test import fail, log_debug
-from api.utils import get_packet_summaries
-from framework.testbed_model.traffic_generator.capturing_traffic_generator import (
-    PacketFilteringConfig,
-)
-from framework.testbed_model.traffic_generator.performance_traffic_generator import (
+from api.testbed_model.traffic_generator.capturing_traffic_generator import PacketFilteringConfig
+from api.testbed_model.traffic_generator.performance_traffic_generator import (
     PerformanceTrafficStats,
 )
+from api.utils import get_packet_summaries
 
 
 def send_packet_and_capture(
@@ -83,7 +81,7 @@ def send_packets_and_capture(
         A list of received packets.
     """
     from api.context import get_ctx
-    from framework.testbed_model.traffic_generator.capturing_traffic_generator import (
+    from api.testbed_model.traffic_generator.capturing_traffic_generator import (
         CapturingTrafficGenerator,
     )
 
@@ -339,7 +337,7 @@ def assess_performance_by_packet(
     Returns:
         Performance statistics of the generated test.
     """
-    from framework.testbed_model.traffic_generator.performance_traffic_generator import (
+    from api.testbed_model.traffic_generator.performance_traffic_generator import (
         PerformanceTrafficGenerator,
     )
 
diff --git a/dts/framework/testbed_model/traffic_generator/capturing_traffic_generator.py b/dts/api/testbed_model/traffic_generator/capturing_traffic_generator.py
similarity index 98%
rename from dts/framework/testbed_model/traffic_generator/capturing_traffic_generator.py
rename to dts/api/testbed_model/traffic_generator/capturing_traffic_generator.py
index 2804d64990..dbe0e72c0f 100644
--- a/dts/framework/testbed_model/traffic_generator/capturing_traffic_generator.py
+++ b/dts/api/testbed_model/traffic_generator/capturing_traffic_generator.py
@@ -17,11 +17,10 @@
 from scapy.packet import Packet
 
 from api.artifact import Artifact
+from api.testbed_model.traffic_generator.traffic_generator import TrafficGenerator
 from api.utils import get_packet_summaries
 from framework.testbed_model.port import Port
 
-from .traffic_generator import TrafficGenerator
-
 
 def _get_default_capture_name() -> str:
     return str(uuid.uuid4())
diff --git a/dts/framework/testbed_model/traffic_generator/performance_traffic_generator.py b/dts/api/testbed_model/traffic_generator/performance_traffic_generator.py
similarity index 95%
rename from dts/framework/testbed_model/traffic_generator/performance_traffic_generator.py
rename to dts/api/testbed_model/traffic_generator/performance_traffic_generator.py
index 5be846361c..7953d0b419 100644
--- a/dts/framework/testbed_model/traffic_generator/performance_traffic_generator.py
+++ b/dts/api/testbed_model/traffic_generator/performance_traffic_generator.py
@@ -8,7 +8,7 @@
 
 from scapy.packet import Packet
 
-from .traffic_generator import TrafficGenerator
+from api.testbed_model.traffic_generator.traffic_generator import TrafficGenerator
 
 
 @dataclass(slots=True)
diff --git a/dts/framework/testbed_model/traffic_generator/traffic_generator.py b/dts/api/testbed_model/traffic_generator/traffic_generator.py
similarity index 100%
rename from dts/framework/testbed_model/traffic_generator/traffic_generator.py
rename to dts/api/testbed_model/traffic_generator/traffic_generator.py
diff --git a/dts/framework/context.py b/dts/framework/context.py
index 709b99421e..6ebe4e0249 100644
--- a/dts/framework/context.py
+++ b/dts/framework/context.py
@@ -16,10 +16,10 @@
 from framework.testbed_model.topology import Topology
 
 if TYPE_CHECKING:
+    from api.testbed_model.traffic_generator.traffic_generator import TrafficGenerator
     from framework.remote_session.dpdk import DPDKBuildEnvironment, DPDKRuntimeEnvironment
     from framework.test_suite import TestCase, TestSuite
     from framework.testbed_model.capability import TestProtocol
-    from framework.testbed_model.traffic_generator.traffic_generator import TrafficGenerator
 
 P = ParamSpec("P")
 
diff --git a/dts/framework/testbed_model/traffic_generator/__init__.py b/dts/framework/testbed_model/traffic_generator/__init__.py
index 324b5e88f3..d630efa6c2 100644
--- a/dts/framework/testbed_model/traffic_generator/__init__.py
+++ b/dts/framework/testbed_model/traffic_generator/__init__.py
@@ -15,6 +15,7 @@
 """
 
 from api.exception import ConfigurationError
+from api.testbed_model.traffic_generator.traffic_generator import TrafficGenerator
 from framework.config.test_run import (
     ScapyTrafficGeneratorConfig,
     TrafficGeneratorConfig,
@@ -23,7 +24,6 @@
 from framework.testbed_model.node import Node
 
 from .scapy import ScapyTrafficGenerator
-from .traffic_generator import TrafficGenerator
 from .trex import TrexTrafficGenerator
 
 
diff --git a/dts/framework/testbed_model/traffic_generator/scapy.py b/dts/framework/testbed_model/traffic_generator/scapy.py
index 70856cc1f0..0bd1eb39bb 100644
--- a/dts/framework/testbed_model/traffic_generator/scapy.py
+++ b/dts/framework/testbed_model/traffic_generator/scapy.py
@@ -26,17 +26,16 @@
 from scapy.packet import Packet
 
 from api.exception import InteractiveSSHSessionDeadError, InternalError
+from api.testbed_model.traffic_generator.capturing_traffic_generator import (
+    CapturingTrafficGenerator,
+    PacketFilteringConfig,
+)
 from framework.config.node import OS
 from framework.config.test_run import ScapyTrafficGeneratorConfig
 from framework.remote_session.python_shell import PythonShell
 from framework.testbed_model.node import Node
 from framework.testbed_model.port import Port
 from framework.testbed_model.topology import Topology
-from framework.testbed_model.traffic_generator.capturing_traffic_generator import (
-    PacketFilteringConfig,
-)
-
-from .capturing_traffic_generator import CapturingTrafficGenerator
 
 
 class ScapyAsyncSniffer(PythonShell):
diff --git a/dts/framework/testbed_model/traffic_generator/trex.py b/dts/framework/testbed_model/traffic_generator/trex.py
index eea37ba1d6..7ce1d40d79 100644
--- a/dts/framework/testbed_model/traffic_generator/trex.py
+++ b/dts/framework/testbed_model/traffic_generator/trex.py
@@ -13,6 +13,10 @@
 from scapy.packet import Packet
 
 from api.exception import SSHTimeoutError
+from api.testbed_model.traffic_generator.performance_traffic_generator import (
+    PerformanceTrafficGenerator,
+    PerformanceTrafficStats,
+)
 from api.utils import StrEnum
 from framework.config.node import OS, NodeConfiguration
 from framework.config.test_run import TrexTrafficGeneratorConfig
@@ -22,10 +26,6 @@
 from framework.testbed_model.node import Node, create_session
 from framework.testbed_model.os_session import OSSession
 from framework.testbed_model.topology import Topology
-from framework.testbed_model.traffic_generator.performance_traffic_generator import (
-    PerformanceTrafficGenerator,
-    PerformanceTrafficStats,
-)
 
 
 @dataclass(slots=True)
diff --git a/dts/tests/TestSuite_packet_capture.py b/dts/tests/TestSuite_packet_capture.py
index 4bd15e2401..dc71991a91 100644
--- a/dts/tests/TestSuite_packet_capture.py
+++ b/dts/tests/TestSuite_packet_capture.py
@@ -36,15 +36,13 @@
     send_packets_and_capture,
 )
 from api.test import verify
+from api.testbed_model.traffic_generator.capturing_traffic_generator import PacketFilteringConfig
 from api.testpmd import TestPmd
 from framework.params import Params
 from framework.remote_session.blocking_app import BlockingApp
 from framework.remote_session.dpdk_shell import compute_eal_params
 from framework.test_suite import TestSuite, func_test
 from framework.testbed_model.cpu import LogicalCoreList
-from framework.testbed_model.traffic_generator.capturing_traffic_generator import (
-    PacketFilteringConfig,
-)
 
 
 @dataclass(kw_only=True)
diff --git a/dts/tests/TestSuite_virtio_forward.py b/dts/tests/TestSuite_virtio_forward.py
index 6c4d7532c7..fe1257800e 100644
--- a/dts/tests/TestSuite_virtio_forward.py
+++ b/dts/tests/TestSuite_virtio_forward.py
@@ -9,14 +9,13 @@
 from scapy.layers.inet import IP
 from scapy.layers.l2 import Ether
 
-from api.capabilities import LinkTopology
+from api.capabilities import LinkTopology, requires_link_topology
 from api.packet import send_packets_and_capture
 from api.test import log, verify
 from api.testbed_model.linux_session import LinuxSession
 from api.testpmd import TestPmd
 from api.testpmd.config import PortTopology, SimpleForwardingModes
 from framework.test_suite import TestSuite, func_test
-from framework.testbed_model.capability import requires
 from framework.testbed_model.virtual_device import VirtualDevice
 
 
@@ -28,7 +27,7 @@ class TestVirtioForward(TestSuite):
     )
     vhost_user_vdev = VirtualDevice("eth_vhost0,iface=/tmp/vhost-net,client=1")
 
-    @requires(topology_type=LinkTopology.NO_LINK)
+    @requires_link_topology(LinkTopology.NO_LINK)
     @func_test
     def virtio_server(self) -> None:
         """Test virtio server packet transmission.
@@ -77,7 +76,7 @@ def virtio_server(self) -> None:
                 "Vhost session failed to receive packets from virtio session.",
             )
 
-    @requires(topology_type=LinkTopology.NO_LINK)
+    @requires_link_topology(LinkTopology.NO_LINK)
     @func_test
     def virtio_server_reconnect(self) -> None:
         """Test virtio server reconnection.
@@ -132,7 +131,7 @@ def virtio_server_reconnect(self) -> None:
                     "Vhost session failed to receive packets from virtio session.",
                 )
 
-    @requires(topology_type=LinkTopology.ONE_LINK)
+    @requires_link_topology(LinkTopology.ONE_LINK)
     @func_test
     def pvp_loop(self) -> None:
         """Test vhost/virtio physical-virtual-physical topology.
-- 
2.55.0

