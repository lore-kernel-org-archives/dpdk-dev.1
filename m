Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 081C4CFC29F
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Nov 2025 19:55:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 408CB402E7;
	Fri, 21 Nov 2025 20:55:48 +0100 (CET)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 by mails.dpdk.org (Postfix) with ESMTP id 5A74B402DB
 for <dev@dpdk.org>; Fri, 21 Nov 2025 20:55:47 +0100 (CET)
Received: by mail-qk1-f175.google.com with SMTP id
 af79cd13be357-8b2ec756de0so247149385a.3
 for <dev@dpdk.org>; Fri, 21 Nov 2025 11:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1763754947; x=1764359747; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X277re70UjiBtkEKB7vRVzIEViOrFXboWYCqlRY/t88=;
 b=JRqrCHnzE/HMfNeNPXfkp5KDqJ2u+/ctR2Lk5UjxS285K4GXWY9XRZf5O9xzYR6fDM
 mQWJufRcMmTg10Rgfno4QkZboxJVdkAU1DQLnPe7Z+oopX7AhvHlAHJBKdDDzIoR+zel
 ATEOMYaDOn91j32gaVFnuLwEkXGiSecJebat4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763754947; x=1764359747;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X277re70UjiBtkEKB7vRVzIEViOrFXboWYCqlRY/t88=;
 b=D1zxmic9xAiqzowbMLPDR2gIUe9YQkCsWzNbIGyQEdi/oYxs5CZm4VBKDRW+E5WMu2
 OLWJdd2droOJnEFjem3jKRrqTV6WeG5Nm6y2D87YXSDzDwSX2807rIjxQrJoZEuBn3mP
 /wiudCUSSQHQhJM+W/reEzI8/tuDjkBh29tlvN4HG/7uMV/sC2jUf9VQDt6CA6Kjsvk3
 0ZStbPXWq/RkD1+AZ0X31A+s5t0XHxs2i/VyN/YnMSKF5ZD32H8N0UzUc2rg78pQdRb4
 ZV4Mhw0SXtPQ14WInh8gb4VxW5LCWPAPPLN3gGjn62GXscUaxX7CodrkvZI0Y//Uipd1
 Vjsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxY/bSg7usONerIrw1GvuVMEhzwCSTQM5ll8omJLThWPkKm75pfDBtViHpg4i4j/JOVIM=@dpdk.org
X-Gm-Message-State: AOJu0YwpHEAEEbzcoPNyGpZSEeqmvKUsvfeyzKf4cyvA1EDN6UDbwmGi
 wKlypVF0/Kz7y8knQ/6l8ko5IUM6pQjQI15sIoRBgnWtHrVrOJtKUjcElavr/35stEErRv55xUH
 3DYiR
X-Gm-Gg: ASbGncvapQtuiGEKe2LgTLsf8bNnekYqUCuBpx6PDCJonIo9Dp8uOXT9azsuPgR2nU/
 LTrvRmrqzqv3RVj6vJe1iDsxZzSeXoWI381nHQ2NVSWRwZ9h2n1xs2xWlHfiKiz/HRNcpGg7GMj
 ZMu6DWf5A/3wYHtY2cANf5m/YE83kpwM3dgxl6BxyZkZlBj/Y5v+68UsIon7SB7X62nVyRRus5/
 2TE45EJqpKUmHo/dBKVtVkDDWHDG2+ZqpltOzqfGhrvVvmwBxU7OSIMHVQzvkR7ZL64aH2rS3Hr
 O9KgMrLktu7OHQgrXVxu9DynwkaBs/5Pg+Ckxw1hGEdknnIkxdFFAAcm1TMJERZilE2XBe01HYe
 b5dAItbzRbZAvjWEO7Pokj+n+2jY4tlDXRojLelJnyqsvmH833OvCHWcTHbeS9dOK2HrN9Pgop4
 GFuR6YUeu1EjTrAzONEU9CKhY=
X-Google-Smtp-Source: AGHT+IFuoCODM6RcXC+yFtfxcpmMcud3K+Gux3d5+0eHQDMNnzcHvu/d151XT1VeFRjbjh5D7MnxYQ==
X-Received: by 2002:a05:620a:1708:b0:8b2:5af3:7fe9 with SMTP id
 af79cd13be357-8b33d479f2fmr450168685a.55.1763754946616; 
 Fri, 21 Nov 2025 11:55:46 -0800 (PST)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b3294336e4sm427471685a.21.2025.11.21.11.55.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Nov 2025 11:55:46 -0800 (PST)
From: Andrew Bailey <abailey@iol.unh.edu>
To: probb@iol.unh.edu
Cc: luca.vizzarro@arm.com, dmarx@iol.unh.edu, dev@dpdk.org,
 Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v4 2/2] dts: rewrite two link topology requirements
Date: Fri, 21 Nov 2025 14:55:11 -0500
Message-ID: <20251121195511.322005-2-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251121195511.322005-1-abailey@iol.unh.edu>
References: <20250723135021.218084-1-dmarx@iol.unh.edu>
 <20251121195511.322005-1-abailey@iol.unh.edu>
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

Some of the DTS test suites require two link topologies
in order to run, but not all truly require two links
for proper testing. Rewrite the topology requirements
on these test suites to reflect the actual
requirements.

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
---
 dts/framework/test_suite.py             | 6 +++---
 dts/tests/TestSuite_blocklist.py        | 3 ++-
 dts/tests/TestSuite_checksum_offload.py | 3 ---
 dts/tests/TestSuite_port_control.py     | 3 ---
 dts/tests/TestSuite_uni_pkt.py          | 3 ---
 dts/tests/TestSuite_vlan.py             | 3 ---
 6 files changed, 5 insertions(+), 16 deletions(-)

diff --git a/dts/framework/test_suite.py b/dts/framework/test_suite.py
index 9c57e343ac..48e0366b61 100644
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
@@ -328,9 +328,9 @@ def _decorator(func: TestSuiteMethodType) -> type[TestCase]:
 
 
 #: The decorator for functional test cases.
-func_test: Callable = TestCase.make_decorator(TestCaseType.FUNCTIONAL)
+func_test: Callable[[Any], type["TestCase"]] = TestCase.make_decorator(TestCaseType.FUNCTIONAL)
 #: The decorator for performance test cases.
-perf_test: Callable = TestCase.make_decorator(TestCaseType.PERFORMANCE)
+perf_test: Callable[[Any], type["TestCase"]] = TestCase.make_decorator(TestCaseType.PERFORMANCE)
 
 
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
index 2c5abd68bf..1b5f8d0b12 100644
--- a/dts/tests/TestSuite_vlan.py
+++ b/dts/tests/TestSuite_vlan.py
@@ -16,9 +16,7 @@
 from scapy.packet import Raw
 
 from api.capabilities import (
-    LinkTopology,
     NicCapability,
-    requires_link_topology,
     requires_nic_capability,
 )
 from api.packet import send_packet_and_capture
@@ -29,7 +27,6 @@
 
 
 @requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_VLAN_FILTER)
-@requires_link_topology(LinkTopology.TWO_LINKS)
 class TestVlan(TestSuite):
     """DPDK VLAN test suite.
 
-- 
2.50.1

