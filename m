Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E2A3C87FCF
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 Aug 2025 14:07:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 088064027C;
	Thu,  7 Aug 2025 16:07:35 +0200 (CEST)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com
 [209.85.160.172])
 by mails.dpdk.org (Postfix) with ESMTP id D216840270
 for <dev@dpdk.org>; Thu,  7 Aug 2025 16:07:33 +0200 (CEST)
Received: by mail-qt1-f172.google.com with SMTP id
 d75a77b69052e-4b07d777d5bso11910731cf.2
 for <dev@dpdk.org>; Thu, 07 Aug 2025 07:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1754575653; x=1755180453; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WQFG3z9rGKSNTYaMu1yfB2SGbQ5Dxy4A6EpzNEBKYtY=;
 b=bX2Rbv5/GSMpTuiibCLc4OyBa19P6Zfiy4qk0Mqq72LUNHkX5x1K9DFQvsRDoeYVc2
 Ag23uJQgZiD25O0TvOgpsSP1OmzsKNGsh8Iv0OuUBY0pGxVEeJGvdayM3183rK/AArWq
 FoRUW8X+F8twVUZpMgPtPIOxbw4zzFzS7VsY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754575653; x=1755180453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WQFG3z9rGKSNTYaMu1yfB2SGbQ5Dxy4A6EpzNEBKYtY=;
 b=K4jKqmiWk1ZQpFwpCbXoSLX5jXOV1NUPVWEN6Y7kfJEs0gvMqFK/VdJ4z3XMAZy26k
 x24ZmS1LJQcoBKHB2n/0nUd7ja41tDADH32+RJeRd0+skMciOA/CbxZcsB/PV8Sptx0G
 jPFvpZo7QjagdhOI6H4n0YCpf1h4Xw3MFmO6K8Klny5q/So24c4Pq11f3BNTiYu0M9wu
 JLqK4HaQkuznuLj6BdvcPkj7ZX4mwepsS4Ur7Jb9jdOCLsgF59F7NQJUFXzVsxNPFI+9
 nRiNJ512jc2XU/OuDzp9ZZyG70DdnV1OTTlpe3OxhiOqJ65xbetLx24VLeMSxNce/oO+
 a2nQ==
X-Gm-Message-State: AOJu0Yx+xenFn4R7hVl2ONbnrIKHgkn0rERh+sv9AnXDtcLWaecawGEm
 QgHrF9zZc/QjarzVn8//Ws7i3ZDc6tUmCaLqZUBv1vwQKIq84gPjsVd8Y7NRPwrx3wk=
X-Gm-Gg: ASbGncvLlRzgv5YcS8E9aFnUsEJdaNlApGFKcubKdwE6BIXOvsJLna5TIyZVfuVh443
 LZcQUYh0ndxjpLXZ/u+QV5aurB7zwfkxXs20m2dEewOHiHsyegDwu1oNs7UCTK9wywni3qKQte/
 WERt78TxUDRZgczyxXcdvtYUmItLyr6S/jRYfY9KJQNWC1FxVeAYAAr2w+7JXvxeeBXXqw1/rD7
 BUS+UH954yUGiVpaZV/9x60pTEroBpvvw6M/pxFzqzyWgus/T/oyT3B2LpmzE4WJ8jJs8OiDPXY
 O29jtZ3WEgokJRcdkkAMli+1n/B34IQ7EsNzCo4HoE7NcStjryvK7rsGPuc+VOW1ABXfhsNzaCK
 xw3JZdqHIdLwLAr+fh+zcLjGcE+ByelVC
X-Google-Smtp-Source: AGHT+IEL+RO9bLQDeFo3nSgcANHqJx41QJCAJPTjo/Ge8zdbMYZZS2AvzH84d3UUfUZtVm7Zgku0ZQ==
X-Received: by 2002:ac8:5f96:0:b0:4a9:ab9b:65da with SMTP id
 d75a77b69052e-4b0a15457e8mr47022511cf.13.1754575652876; 
 Thu, 07 Aug 2025 07:07:32 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:ac5d:4186:4dc6:47eb])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b06ac5bd99sm50835031cf.21.2025.08.07.07.07.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 07:07:32 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v2 1/2] dts: rewrite two link topology requirements
Date: Thu,  7 Aug 2025 10:07:29 -0400
Message-ID: <20250807140730.292639-1-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250723135021.218084-1-dmarx@iol.unh.edu>
References: <20250723135021.218084-1-dmarx@iol.unh.edu>
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
 dts/tests/TestSuite_checksum_offload.py | 2 +-
 dts/tests/TestSuite_dynamic_config.py   | 2 +-
 dts/tests/TestSuite_port_control.py     | 2 +-
 dts/tests/TestSuite_uni_pkt.py          | 2 +-
 dts/tests/TestSuite_vlan.py             | 2 +-
 6 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/dts/tests/TestSuite_blocklist.py b/dts/tests/TestSuite_blocklist.py
index ce7da1cc8f..c75be247b5 100644
--- a/dts/tests/TestSuite_blocklist.py
+++ b/dts/tests/TestSuite_blocklist.py
@@ -12,7 +12,7 @@
 from framework.testbed_model.port import Port
 
 
-@requires(topology_type=TopologyType.two_links)
+@requires(topology_type=TopologyType.one_link)
 class TestBlocklist(TestSuite):
     """DPDK device blocklisting test suite."""
 
@@ -51,6 +51,7 @@ def one_port_blocklisted(self):
         """
         self.verify_blocklisted_ports(self.topology.sut_ports[:1])
 
+    @requires(topology_type=TopologyType.two_links)
     @func_test
     def all_but_one_port_blocklisted(self):
         """Run testpmd with all but one blocklisted port.
diff --git a/dts/tests/TestSuite_checksum_offload.py b/dts/tests/TestSuite_checksum_offload.py
index c9efdcaa1c..54606676d5 100644
--- a/dts/tests/TestSuite_checksum_offload.py
+++ b/dts/tests/TestSuite_checksum_offload.py
@@ -29,7 +29,7 @@
 from framework.testbed_model.capability import NicCapability, TopologyType, requires
 
 
-@requires(topology_type=TopologyType.two_links)
+@requires(topology_type=TopologyType.one_link)
 @requires(NicCapability.RX_OFFLOAD_IPV4_CKSUM)
 @requires(NicCapability.RX_OFFLOAD_UDP_CKSUM)
 @requires(NicCapability.RX_OFFLOAD_TCP_CKSUM)
diff --git a/dts/tests/TestSuite_dynamic_config.py b/dts/tests/TestSuite_dynamic_config.py
index 49f295a39a..f713cbf945 100644
--- a/dts/tests/TestSuite_dynamic_config.py
+++ b/dts/tests/TestSuite_dynamic_config.py
@@ -26,7 +26,7 @@
 
 
 @requires(NicCapability.PHYSICAL_FUNCTION)
-@requires(topology_type=TopologyType.two_links)
+@requires(topology_type=TopologyType.one_link)
 class TestDynamicConfig(TestSuite):
     """Dynamic config suite.
 
diff --git a/dts/tests/TestSuite_port_control.py b/dts/tests/TestSuite_port_control.py
index 58783f1d18..c117b8b7ca 100644
--- a/dts/tests/TestSuite_port_control.py
+++ b/dts/tests/TestSuite_port_control.py
@@ -19,7 +19,7 @@
 
 
 @requires(NicCapability.PHYSICAL_FUNCTION)
-@requires(topology_type=TopologyType.two_links)
+@requires(topology_type=TopologyType.one_link)
 class TestPortControl(TestSuite):
     """DPDK Port Control Testing Suite."""
 
diff --git a/dts/tests/TestSuite_uni_pkt.py b/dts/tests/TestSuite_uni_pkt.py
index 690c5d4fd1..c767ecdeb0 100644
--- a/dts/tests/TestSuite_uni_pkt.py
+++ b/dts/tests/TestSuite_uni_pkt.py
@@ -30,7 +30,7 @@
 from framework.testbed_model.capability import TopologyType, requires
 
 
-@requires(topology_type=TopologyType.two_links)
+@requires(topology_type=TopologyType.one_link)
 class TestUniPkt(TestSuite):
     """DPDK Unified packet test suite.
 
diff --git a/dts/tests/TestSuite_vlan.py b/dts/tests/TestSuite_vlan.py
index d2a9e614d4..56ef8c431e 100644
--- a/dts/tests/TestSuite_vlan.py
+++ b/dts/tests/TestSuite_vlan.py
@@ -21,7 +21,7 @@
 
 
 @requires(NicCapability.RX_OFFLOAD_VLAN_FILTER)
-@requires(topology_type=TopologyType.two_links)
+@requires(topology_type=TopologyType.one_link)
 class TestVlan(TestSuite):
     """DPDK VLAN test suite.
 
-- 
2.50.1

