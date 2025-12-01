Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E1FD116F1
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Dec 2025 11:48:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CCB7240E37;
	Mon,  1 Dec 2025 12:45:43 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 9CBB740691
 for <dev@dpdk.org>; Mon,  1 Dec 2025 12:45:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764589536; x=1796125536;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mpJ0mBKiqzULKLmsjtE4xmNL2rgcpXlaRI/Vv+1WOfQ=;
 b=kstQ0qChXBA++XFfd3BHQt2b7DaL526DJId0D1IkF8Z6uAO+Ep+b4gZN
 enwQ/pNUWvUDcm7Li9Cu2WkcF5OWl6cRtCF2jbZPvhXLTwSq3gDSAzI6o
 mlv1lFUY1LxVxV4TeerHck4iHjPo4bVieyjx1S2K0Uy5ieYWkFy7eDGx1
 EFprs4SJr9/RRcYdhzKj44jZ1hhtflVSOhz0D6yBTqyGJ7Nwd4HLQw2iQ
 BHWl4ITezyYEiyxsflb0pmsIXdL6o7IeJiimtPKpXfQGavYWmiRnbYJAb
 2NeVmQJ9p8Ar1dskEutJ87fFNH9drPjSzoYhgxkWitCheq3UXi22gnE2Q Q==;
X-CSE-ConnectionGUID: mScMlD+uQ4SkSvoGynJHTg==
X-CSE-MsgGUID: 8/xsOwcbR8Oq8Ev4YOf8cA==
X-IronPort-AV: E=McAfee;i="6800,10657,11629"; a="77991784"
X-IronPort-AV: E=Sophos;i="6.20,240,1758610800"; d="scan'208";a="77991784"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Dec 2025 03:45:35 -0800
X-CSE-ConnectionGUID: LTwmXOTOQeCPmQSqsdkGpw==
X-CSE-MsgGUID: jGrMHQx3QW60QTnIvC6LXA==
X-ExtLoop1: 1
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa003.fm.intel.com with ESMTP; 01 Dec 2025 03:45:34 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Chengwen Feng <fengchengwen@huawei.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 30/31] examples: ignore variable shadowing warnings
Date: Mon,  1 Dec 2025 11:44:47 +0000
Message-ID: <20251201114448.1441377-31-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251201114448.1441377-1-bruce.richardson@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20251201114448.1441377-1-bruce.richardson@intel.com>
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

For examples which don't compile with -Wshadow, explicitly disable those
warnings.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Chengwen Feng <fengchengwen@huawei.com>
Acked-by: Stephen Hemminger <stephen@networkplumber.org>
---
 examples/bbdev_app/meson.build                                | 1 +
 examples/bond/meson.build                                     | 1 +
 examples/dma/meson.build                                      | 1 +
 examples/ethtool/meson.build                                  | 1 +
 examples/eventdev_pipeline/meson.build                        | 1 +
 examples/flow_filtering/meson.build                           | 1 +
 examples/ip_pipeline/meson.build                              | 1 +
 examples/ipsec-secgw/meson.build                              | 1 +
 examples/l2fwd-crypto/meson.build                             | 1 +
 examples/l2fwd-event/meson.build                              | 1 +
 examples/l2fwd-jobstats/meson.build                           | 1 +
 examples/l2fwd-keepalive/meson.build                          | 1 +
 examples/l3fwd-graph/meson.build                              | 1 +
 examples/l3fwd-power/meson.build                              | 1 +
 examples/l3fwd/meson.build                                    | 1 +
 examples/multi_process/client_server_mp/mp_server/meson.build | 1 +
 examples/packet_ordering/meson.build                          | 1 +
 examples/ptpclient/meson.build                                | 1 +
 examples/qos_sched/meson.build                                | 1 +
 examples/server_node_efd/efd_server/meson.build               | 1 +
 examples/vhost/meson.build                                    | 1 +
 examples/vm_power_manager/guest_cli/meson.build               | 1 +
 examples/vm_power_manager/meson.build                         | 1 +
 examples/vmdq/meson.build                                     | 1 +
 24 files changed, 24 insertions(+)

diff --git a/examples/bbdev_app/meson.build b/examples/bbdev_app/meson.build
index ea588e8706..283a9551b3 100644
--- a/examples/bbdev_app/meson.build
+++ b/examples/bbdev_app/meson.build
@@ -11,3 +11,4 @@ allow_experimental_apis = true
 sources = files(
         'main.c',
 )
+cflags += no_shadow_cflag
diff --git a/examples/bond/meson.build b/examples/bond/meson.build
index 5a6db9a870..45389998e4 100644
--- a/examples/bond/meson.build
+++ b/examples/bond/meson.build
@@ -11,6 +11,7 @@ allow_experimental_apis = true
 sources = files(
         'main.c',
 )
+cflags += no_shadow_cflag
 
 cmd_h = custom_target('commands_hdr',
         output: 'commands.h',
diff --git a/examples/dma/meson.build b/examples/dma/meson.build
index 124f9476fc..6a65de127e 100644
--- a/examples/dma/meson.build
+++ b/examples/dma/meson.build
@@ -13,3 +13,4 @@ deps += ['argparse', 'dmadev']
 sources = files(
         'dmafwd.c',
 )
+cflags += no_shadow_cflag
diff --git a/examples/ethtool/meson.build b/examples/ethtool/meson.build
index d7f63d48af..3ad948d109 100644
--- a/examples/ethtool/meson.build
+++ b/examples/ethtool/meson.build
@@ -17,6 +17,7 @@ sources = files(
         'ethtool-app/main.c',
 )
 includes = include_directories('lib', 'ethtool-app')
+cflags += no_shadow_cflag
 
 deps += 'bus_pci'
 if dpdk_conf.has('RTE_NET_IXGBE')
diff --git a/examples/eventdev_pipeline/meson.build b/examples/eventdev_pipeline/meson.build
index b8f5cfe109..c317f4b3e2 100644
--- a/examples/eventdev_pipeline/meson.build
+++ b/examples/eventdev_pipeline/meson.build
@@ -13,3 +13,4 @@ sources = files(
         'pipeline_worker_generic.c',
         'pipeline_worker_tx.c',
 )
+cflags += no_shadow_cflag
diff --git a/examples/flow_filtering/meson.build b/examples/flow_filtering/meson.build
index d62d3eddc2..3e0d1627e8 100644
--- a/examples/flow_filtering/meson.build
+++ b/examples/flow_filtering/meson.build
@@ -25,3 +25,4 @@ sources = files(
 
 # The code snippets are not utilized.
 cflags += '-Wno-unused-function'
+cflags += no_shadow_cflag
diff --git a/examples/ip_pipeline/meson.build b/examples/ip_pipeline/meson.build
index 68049157e4..c5cda980f9 100644
--- a/examples/ip_pipeline/meson.build
+++ b/examples/ip_pipeline/meson.build
@@ -28,3 +28,4 @@ sources = files(
         'thread.c',
         'tmgr.c',
 )
+cflags += no_shadow_cflag
diff --git a/examples/ipsec-secgw/meson.build b/examples/ipsec-secgw/meson.build
index e6a0e18a73..20fd7c6c5f 100644
--- a/examples/ipsec-secgw/meson.build
+++ b/examples/ipsec-secgw/meson.build
@@ -25,6 +25,7 @@ sources = files(
 )
 
 cflags += no_wvla_cflag
+cflags += no_shadow_cflag
 
 app_cflags = ['-Wno-address-of-packed-member']
 foreach flag:app_cflags
diff --git a/examples/l2fwd-crypto/meson.build b/examples/l2fwd-crypto/meson.build
index c21722b85c..8c5432cb7f 100644
--- a/examples/l2fwd-crypto/meson.build
+++ b/examples/l2fwd-crypto/meson.build
@@ -15,3 +15,4 @@ sources = files(
         'main.c',
 )
 cflags += no_wvla_cflag
+cflags += no_shadow_cflag
diff --git a/examples/l2fwd-event/meson.build b/examples/l2fwd-event/meson.build
index 5bc8188086..ff171189ba 100644
--- a/examples/l2fwd-event/meson.build
+++ b/examples/l2fwd-event/meson.build
@@ -17,3 +17,4 @@ sources = files(
         'l2fwd_event_internal_port.c',
         'l2fwd_poll.c',
 )
+cflags += no_shadow_cflag
diff --git a/examples/l2fwd-jobstats/meson.build b/examples/l2fwd-jobstats/meson.build
index d59d3d6555..51da6e277e 100644
--- a/examples/l2fwd-jobstats/meson.build
+++ b/examples/l2fwd-jobstats/meson.build
@@ -12,3 +12,4 @@ sources = files(
         'main.c',
 )
 cflags += no_wvla_cflag
+cflags += no_shadow_cflag
diff --git a/examples/l2fwd-keepalive/meson.build b/examples/l2fwd-keepalive/meson.build
index e3f72aedb8..258f3baf08 100644
--- a/examples/l2fwd-keepalive/meson.build
+++ b/examples/l2fwd-keepalive/meson.build
@@ -19,3 +19,4 @@ sources = files(
         'main.c',
         'shm.c',
 )
+cflags += no_shadow_cflag
diff --git a/examples/l3fwd-graph/meson.build b/examples/l3fwd-graph/meson.build
index b3ceaadb59..e3f4fa8df2 100644
--- a/examples/l3fwd-graph/meson.build
+++ b/examples/l3fwd-graph/meson.build
@@ -11,3 +11,4 @@ sources = files(
         'main.c',
 )
 allow_experimental_apis = true
+cflags += no_shadow_cflag
diff --git a/examples/l3fwd-power/meson.build b/examples/l3fwd-power/meson.build
index 5ff4466cac..e45cda86f9 100644
--- a/examples/l3fwd-power/meson.build
+++ b/examples/l3fwd-power/meson.build
@@ -13,3 +13,4 @@ sources = files(
         'perf_core.c',
 )
 cflags += no_wvla_cflag
+cflags += no_shadow_cflag
diff --git a/examples/l3fwd/meson.build b/examples/l3fwd/meson.build
index 74144c7979..a5c47c02b4 100644
--- a/examples/l3fwd/meson.build
+++ b/examples/l3fwd/meson.build
@@ -22,3 +22,4 @@ if dpdk_conf.has('RTE_LIB_EVENTDEV')
     deps += 'eventdev'
 endif
 cflags += no_wvla_cflag
+cflags += no_shadow_cflag
diff --git a/examples/multi_process/client_server_mp/mp_server/meson.build b/examples/multi_process/client_server_mp/mp_server/meson.build
index 9e585e80b9..a31eea764e 100644
--- a/examples/multi_process/client_server_mp/mp_server/meson.build
+++ b/examples/multi_process/client_server_mp/mp_server/meson.build
@@ -14,3 +14,4 @@ sources = files(
         'init.c',
         'main.c',
 )
+cflags += no_shadow_cflag
diff --git a/examples/packet_ordering/meson.build b/examples/packet_ordering/meson.build
index f8be053fb0..092a5258ef 100644
--- a/examples/packet_ordering/meson.build
+++ b/examples/packet_ordering/meson.build
@@ -11,3 +11,4 @@ deps += 'reorder'
 sources = files(
         'main.c',
 )
+cflags += no_shadow_cflag
diff --git a/examples/ptpclient/meson.build b/examples/ptpclient/meson.build
index 47d091ea21..2e9b7625fc 100644
--- a/examples/ptpclient/meson.build
+++ b/examples/ptpclient/meson.build
@@ -10,3 +10,4 @@ allow_experimental_apis = true
 sources = files(
         'ptpclient.c',
 )
+cflags += no_shadow_cflag
diff --git a/examples/qos_sched/meson.build b/examples/qos_sched/meson.build
index 92657ce8a5..4657c756a1 100644
--- a/examples/qos_sched/meson.build
+++ b/examples/qos_sched/meson.build
@@ -18,3 +18,4 @@ sources = files(
         'stats.c',
 )
 cflags += no_wvla_cflag
+cflags += no_shadow_cflag
diff --git a/examples/server_node_efd/efd_server/meson.build b/examples/server_node_efd/efd_server/meson.build
index f1a6616738..fa0e15d73a 100644
--- a/examples/server_node_efd/efd_server/meson.build
+++ b/examples/server_node_efd/efd_server/meson.build
@@ -10,3 +10,4 @@ allow_experimental_apis = true
 deps += 'efd'
 sources += files('args.c', 'init.c', 'main.c')
 includes += include_directories('../shared')
+cflags += no_shadow_cflag
diff --git a/examples/vhost/meson.build b/examples/vhost/meson.build
index e938be8f45..af5049c7ef 100644
--- a/examples/vhost/meson.build
+++ b/examples/vhost/meson.build
@@ -19,3 +19,4 @@ sources = files(
         'virtio_net.c',
 )
 cflags += no_wvla_cflag
+cflags += no_shadow_cflag
diff --git a/examples/vm_power_manager/guest_cli/meson.build b/examples/vm_power_manager/guest_cli/meson.build
index 6a6809240e..45f2edab22 100644
--- a/examples/vm_power_manager/guest_cli/meson.build
+++ b/examples/vm_power_manager/guest_cli/meson.build
@@ -13,6 +13,7 @@ sources = files(
         'parse.c',
         'vm_power_cli_guest.c',
 )
+cflags += no_shadow_cflag
 
 allow_experimental_apis = true
 
diff --git a/examples/vm_power_manager/meson.build b/examples/vm_power_manager/meson.build
index 53949ce6d8..6bc84d752d 100644
--- a/examples/vm_power_manager/meson.build
+++ b/examples/vm_power_manager/meson.build
@@ -29,6 +29,7 @@ sources = files(
         'power_manager.c',
         'vm_power_cli.c',
 )
+cflags += no_shadow_cflag
 
 # If we're on X86, pull in the x86 code for the branch monitor algo.
 if dpdk_conf.has('RTE_ARCH_X86_64')
diff --git a/examples/vmdq/meson.build b/examples/vmdq/meson.build
index 441678bbe5..6fcde9815c 100644
--- a/examples/vmdq/meson.build
+++ b/examples/vmdq/meson.build
@@ -10,3 +10,4 @@ allow_experimental_apis = true
 sources = files(
         'main.c',
 )
+cflags += no_shadow_cflag
-- 
2.51.0

