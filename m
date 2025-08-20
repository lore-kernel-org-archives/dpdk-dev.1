Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21BFCA0EE4
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 Aug 2025 14:07:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E50640669;
	Wed, 20 Aug 2025 16:07:03 +0200 (CEST)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com
 [209.85.219.52]) by mails.dpdk.org (Postfix) with ESMTP id CDD384027D
 for <dev@dpdk.org>; Wed, 20 Aug 2025 16:07:00 +0200 (CEST)
Received: by mail-qv1-f52.google.com with SMTP id
 6a1803df08f44-70a9f556d65so50285686d6.2
 for <dev@dpdk.org>; Wed, 20 Aug 2025 07:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1755698820; x=1756303620; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8r1yiZiUivdObykBu6yon7tgVt3h3LkMVtuEm79b2pc=;
 b=KQXSGTqq85bkpHAt1/ir0iyNeFHaFX4qvI/TXwBjC0HC7L3ZSGMpEgwmfsa/9YeVGF
 C/GRZIzyNi3l+rVZHXZWEPVZwdaBJOPXwdlP0YmtaUu1woWGmLozvgTf91O7f0kREOsg
 M/mF0oc49S5cMEYO6Q985uAkmkAUgvi2T57rM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755698820; x=1756303620;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8r1yiZiUivdObykBu6yon7tgVt3h3LkMVtuEm79b2pc=;
 b=rg/75F1dengkqcM+YHkeXCwEbRsH3uyab3SvOi+JJdfMc2YwS7TJ7xHReWg381MAfA
 aK/vcdKAt9sM6IcQlDcu9DQFyJqhUzRhJy21YtTKqnmoKczB9ohNUbwbMbP0gqWAdxsz
 FTnpAUyW1HA/WrLsM4Iur75aCJ7KuZQM7DR8X2JWXCIVV9nKlWyzbK+DY7KPNwHDBJiF
 iUT+0u1FQFjA6YtJN6wAkq+BYr4kIYJzBTx+OMU3ZDRdAVW8nkPs9yFfsEW+lFh3kZ6r
 UeC2nYXByR1XvJMBPxwaAU6jPNH8Hfj9W4dp2gEnC8eHLCIiMl7UABjPLQB6nUeuMxAF
 otug==
X-Gm-Message-State: AOJu0YyWaiWHD5POWBQT8wY1IadPUc38L4fKbOPyHC15iHRV/qbAd1Ny
 ULFyZYCRN9LpCyAuGG3sE7PLTpNqfToW/zJF19ylgMeGhrJxhxOhVmW5Ks4wTdRJu2c=
X-Gm-Gg: ASbGnct3JBuluJ/UQcX/mVGm/2Y8PlIUvfuKHDUAK4cdsQlfuVMAQEGorMr0nLRsuiv
 tdW3S4GMwms0VXWrYq434BbATPEEtra+5I7NJokFRxbyg4R/MLHcENQsv5Iz20flNjkPWMKBNxT
 Dxr36yWlzIykx4M/IfVk7644MTH/l7ROlk9Tj4l0qhUkZxvTXKxeO5KeLotnlmmal0sv+mEDyel
 2BmsKn3mRt/OaLMwTFHwP5xh3lwrSj0eC7UWEztpGMPF91A5gM/UhuRKx4vGnBJb7JMj0gdwfvV
 YArXrK3d8QrCEnYh7PWQUDXyYqjgQdzqtiPlJaRCsG1ZvvQztwYPn0AnwPIpmmLj2BHlWZyOwDz
 vPIxZu2mqijGAoGTxPi1UmHph
X-Google-Smtp-Source: AGHT+IF/IrLNBqWgjWCDcYzUJm8FQDkmrszeJvVYn0MrlcL6fPfly8ltpCXTK/C1sudl2I2XvFlNng==
X-Received: by 2002:a05:6214:509b:b0:709:dd30:fc7b with SMTP id
 6a1803df08f44-70d770bf581mr27557376d6.38.1755698819750; 
 Wed, 20 Aug 2025 07:06:59 -0700 (PDT)
Received: from d121016.iol.unh.edu ([2606:4100:3880:1210::202])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-70ba92f924bsm88806816d6.46.2025.08.20.07.06.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Aug 2025 07:06:58 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v3 2/2] dts: rewrite two link topology requirements
Date: Wed, 20 Aug 2025 10:06:51 -0400
Message-ID: <20250820140651.39604-3-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820140651.39604-1-dmarx@iol.unh.edu>
References: <20250807140730.292639-1-dmarx@iol.unh.edu>
 <20250820140651.39604-1-dmarx@iol.unh.edu>
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

Bugzilla ID: 1755

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
---
 dts/tests/TestSuite_blocklist.py        | 3 ++-
 dts/tests/TestSuite_checksum_offload.py | 3 +--
 dts/tests/TestSuite_dynamic_config.py   | 3 +--
 dts/tests/TestSuite_port_control.py     | 3 +--
 dts/tests/TestSuite_uni_pkt.py          | 3 +--
 dts/tests/TestSuite_vlan.py             | 3 +--
 6 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/dts/tests/TestSuite_blocklist.py b/dts/tests/TestSuite_blocklist.py
index ce7da1cc8f..6c0507c51e 100644
--- a/dts/tests/TestSuite_blocklist.py
+++ b/dts/tests/TestSuite_blocklist.py
@@ -12,7 +12,6 @@
 from framework.testbed_model.port import Port
 
 
-@requires(topology_type=TopologyType.two_links)
 class TestBlocklist(TestSuite):
     """DPDK device blocklisting test suite."""
 
@@ -40,6 +39,7 @@ def no_blocklisted(self):
         """
         self.verify_blocklisted_ports([])
 
+    @requires(topology_type=TopologyType.two_links)
     @func_test
     def one_port_blocklisted(self):
         """Run testpmd with one blocklisted port.
@@ -51,6 +51,7 @@ def one_port_blocklisted(self):
         """
         self.verify_blocklisted_ports(self.topology.sut_ports[:1])
 
+    @requires(topology_type=TopologyType.two_links)
     @func_test
     def all_but_one_port_blocklisted(self):
         """Run testpmd with all but one blocklisted port.
diff --git a/dts/tests/TestSuite_checksum_offload.py b/dts/tests/TestSuite_checksum_offload.py
index d411af70a9..0487ef3ac1 100644
--- a/dts/tests/TestSuite_checksum_offload.py
+++ b/dts/tests/TestSuite_checksum_offload.py
@@ -26,10 +26,9 @@
     TestPmdShell,
 )
 from framework.test_suite import TestSuite, func_test
-from framework.testbed_model.capability import NicCapability, TopologyType, requires
+from framework.testbed_model.capability import NicCapability, requires
 
 
-@requires(topology_type=TopologyType.two_links)
 @requires(NicCapability.RX_OFFLOAD_IPV4_CKSUM)
 @requires(NicCapability.RX_OFFLOAD_UDP_CKSUM)
 @requires(NicCapability.RX_OFFLOAD_TCP_CKSUM)
diff --git a/dts/tests/TestSuite_dynamic_config.py b/dts/tests/TestSuite_dynamic_config.py
index 49f295a39a..99c2b67810 100644
--- a/dts/tests/TestSuite_dynamic_config.py
+++ b/dts/tests/TestSuite_dynamic_config.py
@@ -22,11 +22,10 @@
 from framework.params.testpmd import SimpleForwardingModes
 from framework.remote_session.testpmd_shell import NicCapability, TestPmdShell
 from framework.test_suite import TestSuite, func_test
-from framework.testbed_model.capability import TopologyType, requires
+from framework.testbed_model.capability import requires
 
 
 @requires(NicCapability.PHYSICAL_FUNCTION)
-@requires(topology_type=TopologyType.two_links)
 class TestDynamicConfig(TestSuite):
     """Dynamic config suite.
 
diff --git a/dts/tests/TestSuite_port_control.py b/dts/tests/TestSuite_port_control.py
index 58783f1d18..ba06858640 100644
--- a/dts/tests/TestSuite_port_control.py
+++ b/dts/tests/TestSuite_port_control.py
@@ -15,11 +15,10 @@
 from framework.params.testpmd import SimpleForwardingModes
 from framework.remote_session.testpmd_shell import NicCapability, TestPmdShell
 from framework.test_suite import TestSuite, func_test
-from framework.testbed_model.capability import TopologyType, requires
+from framework.testbed_model.capability import requires
 
 
 @requires(NicCapability.PHYSICAL_FUNCTION)
-@requires(topology_type=TopologyType.two_links)
 class TestPortControl(TestSuite):
     """DPDK Port Control Testing Suite."""
 
diff --git a/dts/tests/TestSuite_uni_pkt.py b/dts/tests/TestSuite_uni_pkt.py
index 690c5d4fd1..7cba5cb56b 100644
--- a/dts/tests/TestSuite_uni_pkt.py
+++ b/dts/tests/TestSuite_uni_pkt.py
@@ -27,10 +27,9 @@
     TestPmdVerbosePacket,
 )
 from framework.test_suite import TestSuite, func_test
-from framework.testbed_model.capability import TopologyType, requires
+from framework.testbed_model.capability import requires
 
 
-@requires(topology_type=TopologyType.two_links)
 class TestUniPkt(TestSuite):
     """DPDK Unified packet test suite.
 
diff --git a/dts/tests/TestSuite_vlan.py b/dts/tests/TestSuite_vlan.py
index d2a9e614d4..eeeb036a1d 100644
--- a/dts/tests/TestSuite_vlan.py
+++ b/dts/tests/TestSuite_vlan.py
@@ -17,11 +17,10 @@
 
 from framework.remote_session.testpmd_shell import SimpleForwardingModes, TestPmdShell
 from framework.test_suite import TestSuite, func_test
-from framework.testbed_model.capability import NicCapability, TopologyType, requires
+from framework.testbed_model.capability import NicCapability, requires
 
 
 @requires(NicCapability.RX_OFFLOAD_VLAN_FILTER)
-@requires(topology_type=TopologyType.two_links)
 class TestVlan(TestSuite):
     """DPDK VLAN test suite.
 
-- 
2.50.1

