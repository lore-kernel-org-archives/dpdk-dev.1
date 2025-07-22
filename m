Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256D5C83F1A
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Jul 2025 17:19:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 093DD40283;
	Tue, 22 Jul 2025 19:19:05 +0200 (CEST)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com
 [209.85.222.178])
 by mails.dpdk.org (Postfix) with ESMTP id 2F1634003C
 for <dev@dpdk.org>; Tue, 22 Jul 2025 19:19:04 +0200 (CEST)
Received: by mail-qk1-f178.google.com with SMTP id
 af79cd13be357-7dfdcded923so9376585a.1
 for <dev@dpdk.org>; Tue, 22 Jul 2025 10:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1753204743; x=1753809543; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WQFG3z9rGKSNTYaMu1yfB2SGbQ5Dxy4A6EpzNEBKYtY=;
 b=FQ147lklRl/k0A0Lu5WWPZwlhR7J34DDYP27pf6PcIWE74R1KG58Hjq9aT9FuszFcZ
 qymdi3hhIyW/ttAug7ew/0ChqM8BYbyGMDVsgCDIt4pJTTAM4ba5KVLFRSwK0c+XOaMe
 S0dkahkACpmuMj2ekN58g/DxNaTUVL4fI1oc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753204743; x=1753809543;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WQFG3z9rGKSNTYaMu1yfB2SGbQ5Dxy4A6EpzNEBKYtY=;
 b=RiSdTlkoLtfg+VaPqqF5zj+tfBQE66X1vkc7dco1L1ztSMpW+XgY5XKLeM1fqONz5+
 XOtSvI5CYd8VABBBfc5QhM2xz8qSh5/UYeGsDMU8cqJ/I1fOHYtu3CH2aky4uAVw4IIm
 3konGAO9e4tNX18/QI/GS08WJ8UbHKKXiZA6E/MKYEtAHWgkeLyP9AJ527xa07EUKkA2
 ZnOfYMMxbmyd8FtIuD8H0Wxyen7KRn4QbTHaqZSV7kjq6Itw/eMj8azUJcM7LU/Rn+yd
 P7bpsHelxAF0K6QTgU5f4VP02U0jZSfyGmDAkqguckjnQO3YiODiINJoXJnKONjVYJwa
 yZqA==
X-Gm-Message-State: AOJu0YwVVqBq9row6n0T7ZeTMmiobp88jnVfhhm9EZTyKp0N3Qi038na
 l5+ux7sGBJ3xfqvYw+PuAOcj9Uf5vFTHJ7bI9+nJHQ2gPhV9tQTN6VW7Gj5ir3WpjSxEYeenbnF
 8UqCQ
X-Gm-Gg: ASbGncvthcmPOzhM2QWW4I8eYb2F9o36P3kkZ5QFvI3X63nDpFMlaJ5ipypANa2Q5Bf
 sbaUFV+Grl6b4YebMpRwsLrRDHAE7UWoz2oL1aSifGIJ8CPVCDj5WNWkkUKRWMGE0xOW4WXYCPY
 YLlw7PLnUHQF9CQP8HT5T+mSiJysG1+KAPuxRYiMzoMvy/WBDX4h3WJukjOHNUD5Cocr3XQc8vZ
 S/CncbGyYmc6UG+wIJ5sOjEU0Kfb2uDx75dlvJkQDpPJyzJLWxb1/12ikqaFLwaE3TFEokInmTi
 l98ovrtehuZwaaX1z2EUN6PI0zsyogsJ256EK5J9hzOt5ezV+tErK1KfjxHrg3bl+QQkXyj9lZl
 9Y5IbjX7W6l2Mh51NIsg2FSKvZz0S2h2J+xAPtivvm+dshJyKUzVSyFfmFiyBUFU=
X-Google-Smtp-Source: AGHT+IEYzMdZh1xmBSyWFRgoXBg8QmUQH/OUJYqEPMmpfpaGPHUYa90mtQSQZPLluJjJ20Gj9PEXvQ==
X-Received: by 2002:a05:620a:4688:b0:7e3:35aa:7707 with SMTP id
 af79cd13be357-7e62122a80emr551896085a.25.1753204743362; 
 Tue, 22 Jul 2025 10:19:03 -0700 (PDT)
Received: from fedora.iol.unh.edu ([132.177.125.192])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e356b61634sm562244385a.44.2025.07.22.10.19.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 10:19:03 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v1] dts: rewrite two link topology requirements
Date: Tue, 22 Jul 2025 13:19:01 -0400
Message-ID: <20250722171901.199958-1-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
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

