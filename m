Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D7E112584E
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Mar 2026 16:06:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BD35040ED1;
	Wed, 11 Mar 2026 17:06:07 +0100 (CET)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com
 [209.85.221.169])
 by mails.dpdk.org (Postfix) with ESMTP id A03FF40E2E
 for <dev@dpdk.org>; Wed, 11 Mar 2026 17:06:06 +0100 (CET)
Received: by mail-vk1-f169.google.com with SMTP id
 71dfb90a1353d-56a8fdaddebso53171e0c.0
 for <dev@dpdk.org>; Wed, 11 Mar 2026 09:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1773245166; x=1773849966; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CGGChfEw33RCnQBivkJftGoc9BTuV3cbT6Ow2vS1MJ0=;
 b=C4AAcpqaA3qi8id+qF4tjKMimT5IpIX1hOs1uMQMKtT6zEWcfFk+dy23e45zZaVbkL
 jNegwBPjePLEVL0SjPrUGb7eO6ZcHIwSEIum6DkNUIYf4r+EieFuOu8i0P64RIzf0W4j
 CyXeSj+lRixnZ8g2a0S0/Uc4SwQPhgrlmwk6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773245166; x=1773849966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CGGChfEw33RCnQBivkJftGoc9BTuV3cbT6Ow2vS1MJ0=;
 b=YDBJDQcFtvBrufzT+zpxrLm7vsbC9p73qFChZF/3IIUMn4R1LWO05NF0ot02I+aSGj
 IHJa+jjjiUUI/YblclTBlRyWfZENsRqEp5QMAgAeinmfvNONCxSEVcWLSu9MQ1Lyvw4R
 cZryBDkG8Es/YrZnv00fuNKWYQXURdRgNmy6mD4LIus/JawhgcLGVaJRABPbbV50Yzg3
 oYSCfNcraBm6rojJo0puOQ9L13RXgBCjZwtRzRsAHa9gfrV4tRoO7xJHtp0KXXXpuqd3
 zYIpjQLLEF4DJKBiH5xrAU1wrKxGE4p6NiX4sMgKuDDi2QGAZQ98wn8hbmgWn0DHDkNB
 Cysg==
X-Gm-Message-State: AOJu0Yzoo4IOqloSUajeZ5ZnKpM5ngid5Vc9KBBcUKaIwM78uCQDxWiS
 ykB7RFLr0KJAQMjMZ2ITaSx2Tz81U91G/6jlVJCagEcKVx0JDxpTq4TU3uL3IWjzl1s=
X-Gm-Gg: ATEYQzwwmXmk48OpoYtnlzKGuquNgYcGQl9K7qnJH6kqG7HXeQSER9mL/uUGDJXeYHu
 GvUJCuWkebOpGS5ZOtFWycDNfvWPP1j21kHH0GCmYWGWIFoC18sziPh3Vk8oG0JVsMu+9G888aF
 80jwgT1TCEbYY4M5r+4scXlLny5qo0dDcVEMXodgpyjnMrWm4uQAQeZff4KG2GD+K2IdP4Ep5mx
 dX/KUCQ5GdHtWQzKz3Yt39pwjFGpmsQb3RA4Ki+SkZGDF1L3Xel59Q1jkE11DpKksM4/usQQcnL
 KdVQMulypuTL48nAFSSZDHEyxjBwM7gTTDfm4pBVUdCqFZmkM9smXJd2WGIHbSits4hbpMrVK3x
 NnWYQhemgXJ01+8mtN+DzMj6CAx71q61hQrr0MiKoMjrDxjrqpYeDT4gRbFwutM/ZcIsSHUtNId
 WhLbkhpf6md1Ut6EQeLLzp5NQchEMpB/agbGOGV5/1RBGgrCXLTk0kvDQ2lJqXpN7ZQGUQDK+fK
 Gpp98E4v4bUrOM6sPWnXeLQBtA5xoA=
X-Received: by 2002:a05:6102:440b:b0:5f9:35a4:f5e3 with SMTP id
 ada2fe7eead31-601ded0a064mr1082624137.12.1773245165721; 
 Wed, 11 Mar 2026 09:06:05 -0700 (PDT)
Received: from patrick-laptop.iol.unh.edu
 ([2606:4100:3880:1271:8c70:5b9e:ecd3:14e])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a65ce1c9esm16863136d6.27.2026.03.11.09.06.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 09:06:05 -0700 (PDT)
From: Patrick Robb <probb@iol.unh.edu>
To: luca.vizzarro@arm.com
Cc: dev@dpdk.org, dmarx@iol.unh.edu, abailey@iol.unh.edu,
 manjunathgouda.hosamani@intel.com, Paul.Szczepanek@arm.com,
 thomas@monjalon.net, Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH v6 2/2] dts: rewrite two link topology requirements
Date: Wed, 11 Mar 2026 12:03:07 -0400
Message-ID: <20260311160307.441948-2-probb@iol.unh.edu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260311160307.441948-1-probb@iol.unh.edu>
References: <20250820140651.39604-1-dmarx@iol.unh.edu>
 <20260311160307.441948-1-probb@iol.unh.edu>
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

From: Andrew Bailey <abailey@iol.unh.edu>

Some of the DTS test suites require two link topologies
in order to run, but not all truly require two links
for proper testing. Rewrite the topology requirements
on these test suites to reflect the actual
requirements.

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
Reviewed-by: Patrick Robb <probb@iol.unh.edu>
---
 dts/framework/test_suite.py             | 8 ++++----
 dts/tests/TestSuite_blocklist.py        | 3 ++-
 dts/tests/TestSuite_checksum_offload.py | 3 ---
 dts/tests/TestSuite_dual_vlan.py        | 2 ++
 dts/tests/TestSuite_port_control.py     | 3 ---
 dts/tests/TestSuite_uni_pkt.py          | 3 ---
 dts/tests/TestSuite_vlan.py             | 2 +-
 7 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/dts/framework/test_suite.py b/dts/framework/test_suite.py
index e86096cefe..69ce26040a 100644
--- a/dts/framework/test_suite.py
+++ b/dts/framework/test_suite.py
@@ -23,7 +23,7 @@
 from ipaddress import IPv4Interface, IPv6Interface, ip_interface
 from pkgutil import iter_modules
 from types import ModuleType
-from typing import TYPE_CHECKING, ClassVar, Protocol, TypeVar, Union, cast
+from typing import TYPE_CHECKING, Any, ClassVar, Protocol, TypeVar, Union, cast
 
 from scapy.layers.inet import IP
 from scapy.packet import Packet
@@ -332,11 +332,11 @@ def _decorator(func: TestSuiteMethodType) -> type[TestCase]:
 
 
 #: The decorator for functional test cases.
-func_test: Callable = TestCase.make_decorator(TestCaseType.FUNCTIONAL)
+func_test: Callable[[Any], type["TestCase"]] = TestCase.make_decorator(TestCaseType.FUNCTIONAL)
 #: The decorator for performance test cases.
-perf_test: Callable = TestCase.make_decorator(TestCaseType.PERFORMANCE)
+perf_test: Callable[[Any], type["TestCase"]] = TestCase.make_decorator(TestCaseType.PERFORMANCE)
 #: The decorator for cryptography test cases.
-crypto_test: Callable = TestCase.make_decorator(TestCaseType.CRYPTO)
+crypto_test: Callable[[Any], type["TestCase"]] = TestCase.make_decorator(TestCaseType.CRYPTO)
 
 
 @dataclass
diff --git a/dts/tests/TestSuite_blocklist.py b/dts/tests/TestSuite_blocklist.py
index ba37f39ab3..c57231de22 100644
--- a/dts/tests/TestSuite_blocklist.py
+++ b/dts/tests/TestSuite_blocklist.py
@@ -16,7 +16,6 @@
 from framework.testbed_model.port import Port
 
 
-@requires_link_topology(LinkTopology.TWO_LINKS)
 class TestBlocklist(TestSuite):
     """DPDK device blocklisting test suite."""
 
@@ -45,6 +44,7 @@ def no_blocklisted(self) -> None:
         """
         self._verify_blocklisted_ports([])
 
+    @requires_link_topology(LinkTopology.TWO_LINKS)
     @func_test
     def one_port_blocklisted(self) -> None:
         """Run testpmd with one blocklisted port.
@@ -57,6 +57,7 @@ def one_port_blocklisted(self) -> None:
         """
         self._verify_blocklisted_ports(self.topology.sut_ports[:1])
 
+    @requires_link_topology(LinkTopology.TWO_LINKS)
     @func_test
     def all_but_one_port_blocklisted(self) -> None:
         """Run testpmd with all but one blocklisted port.
diff --git a/dts/tests/TestSuite_checksum_offload.py b/dts/tests/TestSuite_checksum_offload.py
index 394a73c31d..90ca798e56 100644
--- a/dts/tests/TestSuite_checksum_offload.py
+++ b/dts/tests/TestSuite_checksum_offload.py
@@ -20,9 +20,7 @@
 from scapy.packet import Packet, Raw
 
 from api.capabilities import (
-    LinkTopology,
     NicCapability,
-    requires_link_topology,
     requires_nic_capability,
 )
 from api.packet import send_packet_and_capture
@@ -33,7 +31,6 @@
 from framework.test_suite import TestSuite, func_test
 
 
-@requires_link_topology(LinkTopology.TWO_LINKS)
 @requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_IPV4_CKSUM)
 @requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_UDP_CKSUM)
 @requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_TCP_CKSUM)
diff --git a/dts/tests/TestSuite_dual_vlan.py b/dts/tests/TestSuite_dual_vlan.py
index 860eae7424..1b77dd2b47 100644
--- a/dts/tests/TestSuite_dual_vlan.py
+++ b/dts/tests/TestSuite_dual_vlan.py
@@ -18,6 +18,7 @@
 from scapy.layers.l2 import Dot1Q, Ether
 from scapy.packet import Packet, Raw
 
+from api.capabilities import LinkTopology, requires_link_topology
 from api.packet import send_packet_and_capture
 from api.test import verify
 from api.testpmd import TestPmd
@@ -161,6 +162,7 @@ def _configure_testpmd(self, shell: TestPmd, options: TestCaseOptions, add: bool
         if self.TestCaseOptions.VLAN_STRIP in options:
             shell.set_vlan_strip(self.rx_port, add)
 
+    @requires_link_topology(LinkTopology.TWO_LINKS)
     @func_test
     def insert_second_vlan(self) -> None:
         """Test that a packet with a single VLAN can have an additional one inserted into it.
diff --git a/dts/tests/TestSuite_port_control.py b/dts/tests/TestSuite_port_control.py
index d9cc5ff4c9..6be47838d0 100644
--- a/dts/tests/TestSuite_port_control.py
+++ b/dts/tests/TestSuite_port_control.py
@@ -13,9 +13,7 @@
 from scapy.packet import Packet, Raw
 
 from api.capabilities import (
-    LinkTopology,
     NicCapability,
-    requires_link_topology,
     requires_nic_capability,
 )
 from api.packet import send_packets_and_capture
@@ -26,7 +24,6 @@
 
 
 @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
-@requires_link_topology(LinkTopology.TWO_LINKS)
 class TestPortControl(TestSuite):
     """DPDK Port Control Testing Suite."""
 
diff --git a/dts/tests/TestSuite_uni_pkt.py b/dts/tests/TestSuite_uni_pkt.py
index 97d61cd03a..222276ce67 100644
--- a/dts/tests/TestSuite_uni_pkt.py
+++ b/dts/tests/TestSuite_uni_pkt.py
@@ -20,9 +20,7 @@
 from scapy.packet import Packet, Raw
 
 from api.capabilities import (
-    LinkTopology,
     NicCapability,
-    requires_link_topology,
     requires_nic_capability,
 )
 from api.packet import send_packet_and_capture
@@ -33,7 +31,6 @@
 from framework.test_suite import TestSuite, func_test
 
 
-@requires_link_topology(LinkTopology.TWO_LINKS)
 class TestUniPkt(TestSuite):
     """DPDK Unified packet test suite.
 
diff --git a/dts/tests/TestSuite_vlan.py b/dts/tests/TestSuite_vlan.py
index 2c5abd68bf..898673fc86 100644
--- a/dts/tests/TestSuite_vlan.py
+++ b/dts/tests/TestSuite_vlan.py
@@ -29,7 +29,6 @@
 
 
 @requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_VLAN_FILTER)
-@requires_link_topology(LinkTopology.TWO_LINKS)
 class TestVlan(TestSuite):
     """DPDK VLAN test suite.
 
@@ -178,6 +177,7 @@ def vlan_no_receipt(self) -> None:
             testpmd.start()
             self._send_vlan_packet_and_verify(should_receive=False, strip=False, vlan_id=2)
 
+    @requires_link_topology(LinkTopology.TWO_LINKS)
     @func_test
     def vlan_header_insertion(self) -> None:
         """Ensure that VLAN packet is received with the correct inserted VLAN tag.
-- 
2.49.0

