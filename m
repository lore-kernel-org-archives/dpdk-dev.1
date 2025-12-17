Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B5DD65C7C
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Dec 2025 16:57:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4191740647;
	Wed, 17 Dec 2025 17:57:44 +0100 (CET)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com
 [209.85.219.52]) by mails.dpdk.org (Postfix) with ESMTP id DB8214060A
 for <dev@dpdk.org>; Wed, 17 Dec 2025 17:57:42 +0100 (CET)
Received: by mail-qv1-f52.google.com with SMTP id
 6a1803df08f44-88267973e5cso33729256d6.3
 for <dev@dpdk.org>; Wed, 17 Dec 2025 08:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1765990662; x=1766595462; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X277re70UjiBtkEKB7vRVzIEViOrFXboWYCqlRY/t88=;
 b=Fop/sBNULcI6ix2Hb22n+uovBSGhsAyt44EyxoGzVQewmS/CF0ivjaA3bOQCrVh5CG
 SYbYSesh+TgfhiWWq/S3mVm9ZRvN4ZM3Gxfmm229FX78ja+ZhjU12FIwzN9a2Z5OM+6r
 clZOFLtcBclW7B4SEzsdZZmJ6IoJYlK74MZE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765990662; x=1766595462;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X277re70UjiBtkEKB7vRVzIEViOrFXboWYCqlRY/t88=;
 b=dms/wuHzK+OmdDMm4jNB4xZU+TeG4eSCyavpA4felHZ2H+ja5/e3XuAdmjV0fHmvnR
 7DPoEEqzI3WxHOurBF647yRap3U+/aPVXO812fq0PgqszLzu0dKNBtVkJ4Vzj47pVtHV
 1H6btkVZb2dHxdXYXhYbWNy9Hnfkg+xMqSdXr+6uOCho+5Yc7BviAAO0KUkVEtTUWxg2
 lPqc3Jiz8t8LOCMlBJ9qARiaDdruBBzCtyJ/uynww7LeWqMX+2pomjyRPuYiBAkqe3DZ
 LHwADXwWvG09uG/0GKcoskO5fLl/s+HolfalYnLLuhF3GilpXOc8lNtAffoLe9gTKk64
 Un9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2Q2EYFE6mX0GGF8VEdk7/dYpAy1fbjVquPim5m3c30o8JJp+5VGihzcTU4KchGZY29cM=@dpdk.org
X-Gm-Message-State: AOJu0YyrMukk6c1pB/Sts2xRpJFcePzhHPWWRuJhg3L2KCX/ylyRgnU0
 vPN1DqAhL6d7E1aHtfRhwaO484aPD01sMOLuZaJ4VTV5hl1juhiaHqjll4+i8CMlEgI=
X-Gm-Gg: AY/fxX7U25B3nZvUZL6DaW1PD761Lpr0OwT+mxi194fwFyUO3b54aPjzueNbf3OB4vV
 OkTGqDVeT/9hQpqxo0KZj/U1dpFxjNVxqhz2KVwgg+tiPh6LQWUZTepnuycvWeJSyUWNyR14nuz
 qU+Afht7usPWKicN62xwORAphPQdD40APMQNtR2oxRO134OVv5rOY2j4nrhM/ChyRi/X9c7sYzl
 P5lKPA5EQRRHeeeodvD/PzsCMgF4s5F4ti/aNTsGgYBsFUAAdAE0ZEV4gT498ttRCKN6ewC5dkU
 fFslBnqNlga8+FGmVovxkJJOxX8JNLmPouUgLxLJB8OnAouHYXQ4sqLgWEhU2nwaRNKpkjNGU6o
 6gHZbHOZaw8IEkFa/QXjLj/e1cV0q7q41sUj1ZAl07vdwzYeFdXgdVYHzBTcVCkS2rA+GBIOrR5
 zPk+wf6REi4Iwn2auMCegXxGX3+3vDcPLfyg==
X-Google-Smtp-Source: AGHT+IEMQd7IcKEMdoutbmF4IhA7bppK3/9bO3aY9YnWdoaw7G/TGjI4l616+AD0ItDWd/ZVhUo88Q==
X-Received: by 2002:a0c:ef01:0:b0:880:63b1:3f57 with SMTP id
 6a1803df08f44-8887e7a0811mr218675636d6.38.1765990662004; 
 Wed, 17 Dec 2025 08:57:42 -0800 (PST)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88993b4204asm99300326d6.7.2025.12.17.08.57.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Dec 2025 08:57:41 -0800 (PST)
From: Andrew Bailey <abailey@iol.unh.edu>
To: probb@iol.unh.edu
Cc: luca.vizzarro@iol.unh.edu, dmarx@iol.unh.edu, dev@dpdk.org,
 Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v5 2/2] dts: rewrite two link topology requirements
Date: Wed, 17 Dec 2025 11:57:16 -0500
Message-ID: <20251217165716.705128-2-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251217165716.705128-1-abailey@iol.unh.edu>
References: <20251121195511.322005-1-abailey@iol.unh.edu>
 <20251217165716.705128-1-abailey@iol.unh.edu>
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

