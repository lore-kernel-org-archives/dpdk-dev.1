Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97253C77B7C
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Jun 2025 13:34:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F39E340A72;
	Tue, 24 Jun 2025 15:34:51 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id C00AF40A67
 for <dev@dpdk.org>; Tue, 24 Jun 2025 15:34:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750772091; x=1782308091;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vQImWxYwXEt1kkZ4Pj1SzaaYkExlh1xKdAHcOJao1AY=;
 b=b16C9yFeIIyRfZBEv6OyQUjEEmKaNLKr5JxnB/l/R6I6Z7iQnlwObkJq
 Pv9ApSuHCahJdb07RurWwd6Dv31/uPO2dlrsQ+ukgYXbLEMAJHWfWXsJW
 j1/wJiZeF1emJA8ddhAQnP16CBQUP/nH+7A9qUsa+MGN/hqaQ77y9Lflz
 NI8scgqsUWy8hqxJAeg1LOKcZQfVUCJwGNwTSHpcWrA45BBYRkt4GB6+o
 Rnifh2OvQrPp6+ArBruI1Zfq66L/m0XpPGdRFnPCDQFpMqDNoOqz779B8
 pxIHqnZXYM6dlKo45nzs5o/E4GC5Acb8uuuhJa6GNmhNI0U+gzq07xhRB Q==;
X-CSE-ConnectionGUID: sxjiTB2lTeG2FXdG74BVYQ==
X-CSE-MsgGUID: 54iJH2yNQPaC5Dlu9amkDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="53112078"
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; d="scan'208";a="53112078"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2025 06:34:32 -0700
X-CSE-ConnectionGUID: KiRbSHpzRhOZfSfLSlr4iw==
X-CSE-MsgGUID: Ddv3ERTTSYW9RNEaBAVTNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; d="scan'208";a="157410781"
Received: from silpixa00401385.ir.intel.com ([10.237.214.33])
 by fmviesa004.fm.intel.com with ESMTP; 24 Jun 2025 06:34:25 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Nicolas Chautru <nicolas.chautru@intel.com>,
 Anoob Joseph <anoobj@marvell.com>, Pravin Pathak <pravin.pathak@intel.com>,
 Ashwin Sekhar T K <asekhar@marvell.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>,
 Praveen Shetty <praveen.shetty@intel.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Gaetan Rivet <grive@u256.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Harry van Haaren <harry.van.haaren@intel.com>,
 Radu Nicolau <radu.nicolau@intel.com>, Akhil Goyal <gakhil@marvell.com>,
 Jingjing Wu <jingjing.wu@intel.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>, Kai Ji <kai.ji@intel.com>,
 Rakesh Kudurumalla <rkudurumalla@marvell.com>,
 Jerin Jacob <jerinj@marvell.com>,
 Srikanth Yalavarthi <syalavarthi@marvell.com>
Subject: [PATCH 2/2] doc: use core lists rather than masks in guides
Date: Tue, 24 Jun 2025 14:34:08 +0100
Message-ID: <20250624133409.550372-3-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250624133409.550372-1-bruce.richardson@intel.com>
References: <20250624133409.550372-1-bruce.richardson@intel.com>
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

For the guides for applications and examples, use the "-l" flag rather
than the "-c" flag to pass in core lists rather than core masks. While
for the trivial examples given, core masks work fine and may be easier;
in real-world cases, with potentially hundreds of cores, core lists are
a much better fix, so update the docs to reflect this.

Similarly replace instances of "-s <service-coremask>" with
"-S <service-core-list>".

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 doc/guides/bbdevs/acc100.rst                  |  2 +-
 doc/guides/bbdevs/fpga_5gnr_fec.rst           |  4 +-
 doc/guides/bbdevs/fpga_lte_fec.rst            |  2 +-
 doc/guides/bbdevs/vrb1.rst                    |  2 +-
 doc/guides/bbdevs/vrb2.rst                    |  2 +-
 doc/guides/cryptodevs/octeontx.rst            |  2 +-
 doc/guides/eventdevs/dlb2.rst                 |  6 +--
 doc/guides/faq/faq.rst                        |  8 ++--
 doc/guides/freebsd_gsg/build_sample_apps.rst  |  8 ++--
 doc/guides/howto/packet_capture_framework.rst |  2 +-
 doc/guides/linux_gsg/build_sample_apps.rst    | 10 ++---
 doc/guides/mempool/cnxk.rst                   |  2 +-
 doc/guides/mempool/octeontx.rst               |  2 +-
 doc/guides/nics/cnxk.rst                      |  2 +-
 doc/guides/nics/cpfl.rst                      |  2 +-
 doc/guides/nics/dpaa.rst                      |  2 +-
 doc/guides/nics/dpaa2.rst                     |  4 +-
 doc/guides/nics/fail_safe.rst                 |  8 ++--
 doc/guides/nics/ice.rst                       |  4 +-
 doc/guides/nics/softnic.rst                   |  4 +-
 doc/guides/prog_guide/meson_ut.rst            |  2 +-
 doc/guides/prog_guide/multi_proc_support.rst  |  2 +-
 doc/guides/prog_guide/service_cores.rst       |  8 ++--
 doc/guides/sample_app_ug/bbdev_app.rst        |  6 +--
 doc/guides/sample_app_ug/ip_pipeline.rst      |  2 +-
 doc/guides/sample_app_ug/ipsec_secgw.rst      |  4 +-
 .../sample_app_ug/l2_forward_macsec.rst       |  4 +-
 doc/guides/sample_app_ug/l3_forward.rst       |  2 +-
 doc/guides/sample_app_ug/multi_process.rst    |  8 ++--
 doc/guides/sample_app_ug/ntb.rst              |  2 +-
 doc/guides/sample_app_ug/pipeline.rst         |  2 +-
 doc/guides/sample_app_ug/qos_scheduler.rst    |  2 +-
 doc/guides/sample_app_ug/test_pipeline.rst    |  2 +-
 doc/guides/sample_app_ug/vdpa.rst             |  2 +-
 doc/guides/tools/comp_perf.rst                |  5 +--
 doc/guides/tools/cryptoperf.rst               |  5 +--
 doc/guides/tools/graph.rst                    | 13 +++----
 doc/guides/tools/testbbdev.rst                |  2 +-
 doc/guides/tools/testeventdev.rst             | 39 +++++++++----------
 doc/guides/tools/testmldev.rst                | 27 +++++++------
 40 files changed, 105 insertions(+), 112 deletions(-)

diff --git a/doc/guides/bbdevs/acc100.rst b/doc/guides/bbdevs/acc100.rst
index 38a7a11d4e..6843e38c55 100644
--- a/doc/guides/bbdevs/acc100.rst
+++ b/doc/guides/bbdevs/acc100.rst
@@ -153,4 +153,4 @@ Specifically for the BBDEV ACC100 PMD, the command below can be used:
 .. code-block:: console

   ./pf_bb_config ACC100 -c acc100/acc100_config_vf_5g.cfg
-  ./test-bbdev.py -e="-c 0xff0 -a${VF_PCI_ADDR}" -c validation -n 64 -b 32 -l 1 -v ./ldpc_dec_default.data
+  ./test-bbdev.py -e="-l 4-11 -a${VF_PCI_ADDR}" -c validation -n 64 -b 32 -l 1 -v ./ldpc_dec_default.data
diff --git a/doc/guides/bbdevs/fpga_5gnr_fec.rst b/doc/guides/bbdevs/fpga_5gnr_fec.rst
index 5301076d93..58d19ffbd2 100644
--- a/doc/guides/bbdevs/fpga_5gnr_fec.rst
+++ b/doc/guides/bbdevs/fpga_5gnr_fec.rst
@@ -231,11 +231,11 @@ Vista Creek (N3000)
 .. code-block:: console

   ./pf_bb_config FPGA_5GNR -c fpga_5gnr/fpga_5gnr_config_vf.cfg
-  ./test-bbdev.py -e="-c 0xff0 -a${VF_PCI_ADDR}" -c validation -n 64 -b 32 -l 1 -v ./ldpc_dec_default.data
+  ./test-bbdev.py -e="-l 4-11 -a${VF_PCI_ADDR}" -c validation -n 64 -b 32 -l 1 -v ./ldpc_dec_default.data

 Arrow Creek (N6000)

 .. code-block:: console

   ./pf_bb_config AGX100 -c agx100/agx100_config_1vf.cfg
-  ./test-bbdev.py -e="-c 0xff0 -a${VF_PCI_ADDR}" -c validation -n 64 -b 32 -l 1 -v ./ldpc_dec_default.data
+  ./test-bbdev.py -e="-l 4-11 -a${VF_PCI_ADDR}" -c validation -n 64 -b 32 -l 1 -v ./ldpc_dec_default.data
diff --git a/doc/guides/bbdevs/fpga_lte_fec.rst b/doc/guides/bbdevs/fpga_lte_fec.rst
index 34ca18ecc6..7e3748222c 100644
--- a/doc/guides/bbdevs/fpga_lte_fec.rst
+++ b/doc/guides/bbdevs/fpga_lte_fec.rst
@@ -211,4 +211,4 @@ Specifically for the BBDEV FPGA LTE FEC PMD, the command below can be used:
 .. code-block:: console

   ./pf_bb_config FPGA_LTE -c fpga_lte/fpga_lte_config_vf.cfg
-  ./test-bbdev.py -e="-c 0xff0 -a${VF_PCI_ADDR}" -c validation -n 64 -b 32 -l 1 -v ./turbo_dec_default.data
+  ./test-bbdev.py -e="-l 4-11 -a${VF_PCI_ADDR}" -c validation -n 64 -b 32 -l 1 -v ./turbo_dec_default.data
diff --git a/doc/guides/bbdevs/vrb1.rst b/doc/guides/bbdevs/vrb1.rst
index e450e0061f..255c4ea040 100644
--- a/doc/guides/bbdevs/vrb1.rst
+++ b/doc/guides/bbdevs/vrb1.rst
@@ -163,4 +163,4 @@ Specifically for the bbdev Intel vRAN Boost v1 PMD, the command below can be use
 .. code-block:: console

    pf_bb_config ACC200 -c ./acc200/acc200_config_vf_5g.cfg
-   test-bbdev.py -e="-c 0xff0 -a${VF_PCI_ADDR}" -c validation -n 64 -b 64 -l 1 -v ./ldpc_dec_default.data
+   test-bbdev.py -e="-l 4-11 -a${VF_PCI_ADDR}" -c validation -n 64 -b 64 -l 1 -v ./ldpc_dec_default.data
diff --git a/doc/guides/bbdevs/vrb2.rst b/doc/guides/bbdevs/vrb2.rst
index 5389d533f5..45c83e875f 100644
--- a/doc/guides/bbdevs/vrb2.rst
+++ b/doc/guides/bbdevs/vrb2.rst
@@ -175,4 +175,4 @@ Specifically for the bbdev Intel vRAN Boost v2 PMD, the command below can be use
 .. code-block:: console

    pf_bb_config VRB2 -c ./vrb2/vrb2_config_vf_5g.cfg
-   test-bbdev.py -e="-c 0xff0 -a${VF_PCI_ADDR}" -c validation -n 64 -b 64 -l 1 -v ./ldpc_dec_default.data
+   test-bbdev.py -e="-l 4-11 -a${VF_PCI_ADDR}" -c validation -n 64 -b 64 -l 1 -v ./ldpc_dec_default.data
diff --git a/doc/guides/cryptodevs/octeontx.rst b/doc/guides/cryptodevs/octeontx.rst
index a39f3f3d02..8b0eb8a979 100644
--- a/doc/guides/cryptodevs/octeontx.rst
+++ b/doc/guides/cryptodevs/octeontx.rst
@@ -114,7 +114,7 @@ OCTEON TX crypto PMD.

 .. code-block:: console

-        ./build/ipsec-secgw --log-level=8 -c 0xff -- -P -p 0x3 -u 0x2 --config
+        ./build/ipsec-secgw --log-level=8 -l 0-7 -- -P -p 0x3 -u 0x2 --config
         "(1,0,0),(0,0,0)" -f ep1.cfg

 Testing
diff --git a/doc/guides/eventdevs/dlb2.rst b/doc/guides/eventdevs/dlb2.rst
index 8ec7168f20..daa8bf27fb 100644
--- a/doc/guides/eventdevs/dlb2.rst
+++ b/doc/guides/eventdevs/dlb2.rst
@@ -408,9 +408,9 @@ the DLB device locally available on the same tile along with other
 resources. To allocate optimal resources, probing is done for each
 producer port (PP) for a given CPU and the best performing ports are
 allocated to producers. The cpu used for probing is either the first
-core of producer coremask (if present) or the second core of EAL
-coremask. This will be extended later to probe for all CPUs in the
-producer coremask or EAL coremask. Producer coremask can be passed
+core of producer coremask DLB2 device parameter (if present) or the second core of EAL
+core list. This will be extended later to probe for all CPUs in the
+producer coremask or EAL core list. Producer coremask can be passed
 along with the BDF of the DLB devices.

     .. code-block:: console
diff --git a/doc/guides/faq/faq.rst b/doc/guides/faq/faq.rst
index c7a774da2a..d675c870ff 100644
--- a/doc/guides/faq/faq.rst
+++ b/doc/guides/faq/faq.rst
@@ -47,11 +47,9 @@ therefore all the hugepages are allocated on the wrong socket.
 To avoid this scenario, either lower the amount of hugepage memory available to 1 GB size (or less), or run the application with taskset
 affinitizing the application to a would-be main core.

-For example, if your EAL coremask is 0xff0, the main core will usually be the first core in the coremask (0x10); this is what you have to supply to taskset::
+For example, if your EAL core list is '4-11', the main core will usually be the first core in the list (core 4); this is what you have to supply to taskset::

-   taskset 0x10 ./l2fwd -l 4-11 -n 2
-
-.. Note: Instead of '-c 0xff0' use the '-l 4-11' as a cleaner way to define lcores.
+   taskset -c 4 ./l2fwd -l 4-11 -n 2

 In this way, the hugepages have a greater chance of being allocated to the correct socket.
 Additionally, a ``--numa-mem`` option could be used to ensure the availability of memory for each socket, so that if hugepages were allocated on
@@ -167,7 +165,7 @@ Can I split packet RX to use DPDK and have an application's higher order functio
 ----------------------------------------------------------------------------------------------------------------

 The DPDK's lcore threads are Linux pthreads bound onto specific cores. Configure the DPDK to do work on the same
-cores and run the application's other work on other cores using the DPDK's "coremask" setting to specify which
+cores and run the application's other work on other cores using the DPDK's "core list" (-l/--lcores) setting to specify which
 cores it should launch itself on.


diff --git a/doc/guides/freebsd_gsg/build_sample_apps.rst b/doc/guides/freebsd_gsg/build_sample_apps.rst
index 7bdd88e56d..112c524a43 100644
--- a/doc/guides/freebsd_gsg/build_sample_apps.rst
+++ b/doc/guides/freebsd_gsg/build_sample_apps.rst
@@ -61,10 +61,10 @@ A large number of options can be given to the EAL when running an
 application. A full list of options can be got by passing `--help` to a
 DPDK application. Some of the EAL options for FreeBSD are as follows:

-*   ``-c COREMASK`` or ``-l CORELIST``:
-    A hexadecimal bit mask of the cores to run on.  Note that core numbering
-    can change between platforms and should be determined beforehand. The corelist
-    is a list of cores to use instead of a core mask.
+*   ``-l CORELIST``:
+    A comma-separated list of the cores, or ranges of cores to run on.
+    For example, ``-l 0,1,4-6`` will run on cores 0, 1, 4, 5 and 6.
+    Note that core numbering can change between platforms and should be determined beforehand.

 *   ``-b <domain:bus:devid.func>``:
     Blocklisting of ports; prevent EAL from using specified PCI device
diff --git a/doc/guides/howto/packet_capture_framework.rst b/doc/guides/howto/packet_capture_framework.rst
index 24d4bd0e73..8e64e7a83e 100644
--- a/doc/guides/howto/packet_capture_framework.rst
+++ b/doc/guides/howto/packet_capture_framework.rst
@@ -89,7 +89,7 @@ inspect them using ``tcpdump``.

 #. Launch testpmd as the primary application::

-     sudo <build_dir>/app/dpdk-testpmd -c 0xf0 -n 4 -- -i --port-topology=chained
+     sudo <build_dir>/app/dpdk-testpmd -l 4-7 -n 4 -- -i --port-topology=chained

 #. Launch the dpdk-dumpcap as follows::

diff --git a/doc/guides/linux_gsg/build_sample_apps.rst b/doc/guides/linux_gsg/build_sample_apps.rst
index 5746a623f8..8b8026705b 100644
--- a/doc/guides/linux_gsg/build_sample_apps.rst
+++ b/doc/guides/linux_gsg/build_sample_apps.rst
@@ -33,16 +33,16 @@ The following is the list of options that can be given to the EAL:

 .. code-block:: console

-    ./rte-app [-c COREMASK | -l CORELIST] [-n NUM] [-b <domain:bus:devid.func>] \
+    ./rte-app [ -l CORELIST] [-n NUM] [-b <domain:bus:devid.func>] \
               [--numa-mem=MB,...] [-d LIB.so|DIR] [-m MB] [-r NUM] [-v] [--file-prefix] \
 	      [--proc-type <primary|secondary|auto>]

 The EAL options are as follows:

-* ``-c COREMASK`` or ``-l CORELIST``:
-  An hexadecimal bit mask of the cores to run on. Note that core numbering can
-  change between platforms and should be determined beforehand. The corelist is
-  a set of core numbers instead of a bitmap core mask.
+* ``-l CORELIST``:
+  A comma-separated list of the cores, or ranges of cores to run on.
+  For example, ``-l 0,1,4-6`` will run on cores 0, 1, 4, 5 and 6.
+  Note that core numbering can change between platforms and should be determined beforehand.

 * ``-n NUM``:
   Number of memory channels per processor socket.
diff --git a/doc/guides/mempool/cnxk.rst b/doc/guides/mempool/cnxk.rst
index ffd9a6de86..3d0729245a 100644
--- a/doc/guides/mempool/cnxk.rst
+++ b/doc/guides/mempool/cnxk.rst
@@ -88,4 +88,4 @@ Standalone mempool device

    Example command to run ``mempool_autotest`` test with standalone CN10K NPA device::

-     echo "mempool_autotest" | <build_dir>/app/test/dpdk-test -c 0xf0 --mbuf-pool-ops-name="cn10k_mempool_ops"
+     echo "mempool_autotest" | <build_dir>/app/test/dpdk-test -l 4-7 --mbuf-pool-ops-name="cn10k_mempool_ops"
diff --git a/doc/guides/mempool/octeontx.rst b/doc/guides/mempool/octeontx.rst
index 51915af96a..eeaa7fb1dc 100644
--- a/doc/guides/mempool/octeontx.rst
+++ b/doc/guides/mempool/octeontx.rst
@@ -60,5 +60,5 @@ Example:

 .. code-block:: console

-    ./<build_dir>/app/test/dpdk-test -c 0xf --base-virtaddr=0x100000000000 \
+    ./<build_dir>/app/test/dpdk-test -l 0-3 --base-virtaddr=0x100000000000 \
                         --mbuf-pool-ops-name="octeontx_fpavf"
diff --git a/doc/guides/nics/cnxk.rst b/doc/guides/nics/cnxk.rst
index 3c1baed478..2ba0c9e058 100644
--- a/doc/guides/nics/cnxk.rst
+++ b/doc/guides/nics/cnxk.rst
@@ -63,7 +63,7 @@ for details.

    .. code-block:: console

-      ./<build_dir>/app/dpdk-testpmd -c 0xc -a 0002:02:00.0 -- --portmask=0x1 --nb-cores=1 --port-topology=loop --rxq=1 --txq=1
+      ./<build_dir>/app/dpdk-testpmd -l 2,3 -a 0002:02:00.0 -- --portmask=0x1 --nb-cores=1 --port-topology=loop --rxq=1 --txq=1
       EAL: Detected 4 lcore(s)
       EAL: Detected 1 NUMA nodes
       EAL: Multi-process socket /var/run/dpdk/rte/mp_socket
diff --git a/doc/guides/nics/cpfl.rst b/doc/guides/nics/cpfl.rst
index 3bfab2136d..e8bb1966cf 100644
--- a/doc/guides/nics/cpfl.rst
+++ b/doc/guides/nics/cpfl.rst
@@ -213,7 +213,7 @@ low level hardware resources.

    .. code-block:: console

-      dpdk-testpmd -c 0x3 -n 4 -a 0000:af:00.6,vport=[0-1],flow_parser="refpkg.json" -- -i
+      dpdk-testpmd -l 0,1 -n 4 -a 0000:af:00.6,vport=[0-1],flow_parser="refpkg.json" -- -i

 #. Create one flow to forward ETH-IPV4-TCP from I/O port to a local(CPF's) vport. Flow should be created on
    vport X. Group M should match fxp module. Action port_representor Y means forward packet to local vport Y::
diff --git a/doc/guides/nics/dpaa.rst b/doc/guides/nics/dpaa.rst
index de3ae96e07..8748ee767e 100644
--- a/doc/guides/nics/dpaa.rst
+++ b/doc/guides/nics/dpaa.rst
@@ -254,7 +254,7 @@ for details.

    .. code-block:: console

-      ./<build_dir>/app/dpdk-testpmd -c 0xff -n 1 \
+      ./<build_dir>/app/dpdk-testpmd -l 0-7 -n 1 \
         -- -i --portmask=0x3 --nb-cores=1 --no-flush-rx

       .....
diff --git a/doc/guides/nics/dpaa2.rst b/doc/guides/nics/dpaa2.rst
index 3175a8b421..94bf1907df 100644
--- a/doc/guides/nics/dpaa2.rst
+++ b/doc/guides/nics/dpaa2.rst
@@ -445,7 +445,7 @@ for details.

    .. code-block:: console

-      ./dpdk-testpmd -c 0xff -n 1 -- -i --portmask=0x3 --nb-cores=1 --no-flush-rx
+      ./dpdk-testpmd -l 0-7 -n 1 -- -i --portmask=0x3 --nb-cores=1 --no-flush-rx

       .....
       EAL: Registered [pci] bus.
@@ -607,7 +607,7 @@ For a detailed usage description please refer to "Traffic Management" section in

    .. code-block:: console

-	./dpdk-testpmd  -c 0xf -n 1 -- -i --portmask 0x3 --nb-cores=1 --txq=4 --rxq=4
+	./dpdk-testpmd  -l 0-3 -n 1 -- -i --portmask 0x3 --nb-cores=1 --txq=4 --rxq=4

 #. Stop all ports:

diff --git a/doc/guides/nics/fail_safe.rst b/doc/guides/nics/fail_safe.rst
index ae9f08ec8d..58307360a4 100644
--- a/doc/guides/nics/fail_safe.rst
+++ b/doc/guides/nics/fail_safe.rst
@@ -116,7 +116,7 @@ This section shows some example of using **testpmd** with a fail-safe PMD.

    .. code-block:: console

-      ./<build_dir>/app/dpdk-testpmd -c 0xff -n 4 \
+      ./<build_dir>/app/dpdk-testpmd -l 0-7 -n 4 \
          --vdev 'net_failsafe0,mac=de:ad:be:ef:01:02,dev(84:00.0),dev(net_ring0)' \
          -b 84:00.0 -b 00:04.0 -- -i

@@ -130,7 +130,7 @@ This section shows some example of using **testpmd** with a fail-safe PMD.

    .. code-block:: console

-      ./<build_dir>/app/dpdk-testpmd -c 0xff -n 4 \
+      ./<build_dir>/app/dpdk-testpmd -l 0-7 -n 4 \
          --vdev 'net_failsafe0,mac=de:ad:be:ef:01:02,dev(84:00.0),dev(net_ring0)' \
          -a 81:00.0 -- -i

@@ -138,7 +138,7 @@ This section shows some example of using **testpmd** with a fail-safe PMD.

    .. code-block:: console

-      ./<build_dir>/app/dpdk-testpmd -c 0xff -n 4 -a ff:ff.f \
+      ./<build_dir>/app/dpdk-testpmd -l 0-7 -n 4 -a ff:ff.f \
          --vdev='net_failsafe0,exec(echo 84:00.0)' -- -i

 #. Start testpmd, automatically probing the device 84:00.0 and using it with
@@ -146,7 +146,7 @@ This section shows some example of using **testpmd** with a fail-safe PMD.

    .. code-block:: console

-      ./<build_dir>/app/dpdk-testpmd -c 0xff -n 4 \
+      ./<build_dir>/app/dpdk-testpmd -l 0-7 -n 4 \
          --vdev 'net_failsafe0,dev(0000:84:00.0),dev(net_ring0)' -- -i


diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
index 77985ae5a2..86dec50c27 100644
--- a/doc/guides/nics/ice.rst
+++ b/doc/guides/nics/ice.rst
@@ -189,7 +189,7 @@ Runtime Configuration

   .. code-block:: console

-    dpdk-testpmd -c 0xff -- -i
+    dpdk-testpmd -l 0-7 -- -i
     port stop 0
     port detach 0
     port attach 18:00.0,proto_xtr='[(1,2-3,8-9):tcp,10-13:vlan]',field_offs=92,field_name=pmd_dyn
@@ -200,7 +200,7 @@ Runtime Configuration

   .. code-block:: console

-    dpdk-testpmd -c 0xff -- -i
+    dpdk-testpmd -l 0-7 -- -i
     port stop 0
     port detach 0
     port attach 18:00.0,proto_xtr=vlan,proto_xtr='[(1,2-3,8-9):tcp,10-23:ipv6]', \
diff --git a/doc/guides/nics/softnic.rst b/doc/guides/nics/softnic.rst
index 64939fd484..4e841cb9a3 100644
--- a/doc/guides/nics/softnic.rst
+++ b/doc/guides/nics/softnic.rst
@@ -121,7 +121,7 @@ Soft NIC testing

     .. code-block:: console

-         ./dpdk-testpmd -c 0x7 -s 0x4 --vdev 'net_softnic0,firmware=<script path>/firmware.cli,cpu_id=0,conn_port=8086' -- -i
+         ./dpdk-testpmd -l 0-2 -S 2 --vdev 'net_softnic0,firmware=<script path>/firmware.cli,cpu_id=0,conn_port=8086' -- -i
               --portmask=0x2

     .. code-block:: console
@@ -366,7 +366,7 @@ commands.

     .. code-block:: console

-        ./<build_dir>/app/dpdk-testpmd -c 0x7 -s 0x4 -n 4 \
+        ./<build_dir>/app/dpdk-testpmd -l 0-2 -S 2 -n 4 \
                                     --vdev 'net_softnic0, \
                                     firmware=./drivers/net/softnic/ \
                                         firmware.cli, \
diff --git a/doc/guides/prog_guide/meson_ut.rst b/doc/guides/prog_guide/meson_ut.rst
index 78cf3f845c..9bc52a30fc 100644
--- a/doc/guides/prog_guide/meson_ut.rst
+++ b/doc/guides/prog_guide/meson_ut.rst
@@ -60,7 +60,7 @@ Arguments of ``test()`` that can be provided in meson.build are as below:

 Note: the content of meson ``--test-args`` option and the content of ``args``
 are appended when invoking the DPDK test binary.
-Because of this, it is recommended not to set any default coremask or memory
+Because of this, it is recommended not to set any default corelist or memory
 configuration in per test ``args`` and rather let users select what best fits
 their environment. If a test can't run, then it should be skipped, as described
 below.
diff --git a/doc/guides/prog_guide/multi_proc_support.rst b/doc/guides/prog_guide/multi_proc_support.rst
index 3082ffe183..a73918a5da 100644
--- a/doc/guides/prog_guide/multi_proc_support.rst
+++ b/doc/guides/prog_guide/multi_proc_support.rst
@@ -166,7 +166,7 @@ Some of these are documented below:
     so it is recommended that it be disabled only when absolutely necessary,
     and only when the implications of this change have been understood.

-*   All DPDK processes running as a single application and using shared memory must have distinct coremask/corelist arguments.
+*   All DPDK processes running as a single application and using shared memory must have distinct corelist arguments.
     It is not possible to have a primary and secondary instance, or two secondary instances,
     using any of the same logical cores.
     Attempting to do so can cause corruption of memory pool caches, among other issues.
diff --git a/doc/guides/prog_guide/service_cores.rst b/doc/guides/prog_guide/service_cores.rst
index d4e6c3d6e6..5284eeb96a 100644
--- a/doc/guides/prog_guide/service_cores.rst
+++ b/doc/guides/prog_guide/service_cores.rst
@@ -26,10 +26,10 @@ Service Core Initialization
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~

 There are two methods to having service cores in a DPDK application, either by
-using the service coremask, or by dynamically adding cores using the API.
-The simpler of the two is to pass the `-s` coremask argument to EAL, which will
-take any cores available in the main DPDK coremask, and if the bits are also set
-in the service coremask the cores become service-cores instead of DPDK
+using the service corelist, or by dynamically adding cores using the API.
+The simpler of the two is to pass the `-S` corelist argument to EAL, which will
+take any cores available in the main DPDK corelist, and if also set
+in the service corelist the cores become service-cores instead of DPDK
 application lcores.

 Enabling Services on Cores
diff --git a/doc/guides/sample_app_ug/bbdev_app.rst b/doc/guides/sample_app_ug/bbdev_app.rst
index bd1387cb5c..a699e8a61d 100644
--- a/doc/guides/sample_app_ug/bbdev_app.rst
+++ b/doc/guides/sample_app_ug/bbdev_app.rst
@@ -67,7 +67,7 @@ issue the command:
 .. code-block:: console

     $ ./<build_dir>/examples/dpdk-bbdev --vdev='baseband_turbo_sw' -a <NIC0PCIADDR> \
-    -c 0x38 --numa-mem=2,2 --file-prefix=bbdev -- -e 0x10 -d 0x20
+    -l 3,4,5 --numa-mem=2,2 --file-prefix=bbdev -- -e 0x10 -d 0x20

 where, NIC0PCIADDR is the PCI address of the Rx port

@@ -98,12 +98,12 @@ ports.

 .. code-block:: console

-    $ ./pktgen-3.4.0/app/x86_64-native-linux-gcc/pktgen -c 0x3 \
+    $ ./pktgen-3.4.0/app/x86_64-native-linux-gcc/pktgen -l 1,2 \
     --numa-mem=1,1 --file-prefix=pg -a <NIC1PCIADDR> -- -m 1.0 -P

 where:

-* ``-c COREMASK``: A hexadecimal bitmask of cores to run on
+* ``-l CORELIST``: A list of cores on which the app should run
 * ``--numa-mem``: Memory to allocate on specific sockets (use comma separated values)
 * ``--file-prefix``: Prefix for hugepage filenames
 * ``-a <NIC1PCIADDR>``: Add a PCI device in allow list. The argument format is <[domain:]bus:devid.func>.
diff --git a/doc/guides/sample_app_ug/ip_pipeline.rst b/doc/guides/sample_app_ug/ip_pipeline.rst
index ff5ee67ec2..f9e8caa0a8 100644
--- a/doc/guides/sample_app_ug/ip_pipeline.rst
+++ b/doc/guides/sample_app_ug/ip_pipeline.rst
@@ -71,7 +71,7 @@ The following is an example command to run ip pipeline application configured fo

 .. code-block:: console

-    $ ./<build_dir>/examples/dpdk-ip_pipeline -c 0x3 -- -s examples/route_ecmp.cli
+    $ ./<build_dir>/examples/dpdk-ip_pipeline -l 0,1 -- -s examples/route_ecmp.cli

 The application should start successfully and display as follows:

diff --git a/doc/guides/sample_app_ug/ipsec_secgw.rst b/doc/guides/sample_app_ug/ipsec_secgw.rst
index 7dce577de9..e1d987a94e 100644
--- a/doc/guides/sample_app_ug/ipsec_secgw.rst
+++ b/doc/guides/sample_app_ug/ipsec_secgw.rst
@@ -322,14 +322,14 @@ where each option means:
 Similarly for example, given the following command line to run application in
 event app mode::

-    ./<build_dir>/examples/dpdk-ipsec-secgw -c 0x3 -- -P -p 0x3 -u 0x1       \
+    ./<build_dir>/examples/dpdk-ipsec-secgw -l 0,1 -- -P -p 0x3 -u 0x1       \
            -f /path/to/config_file --transfer-mode event \
            --event-schedule-type parallel --event-vector --vector-size 32    \
            --vector-tmo 102400                           \

 where each option means:

-*   The ``-c`` option selects cores 0 and 1 to run on.
+*   The ``-l`` option selects cores 0 and 1 to run on.

 *   The ``-P`` option enables promiscuous mode.

diff --git a/doc/guides/sample_app_ug/l2_forward_macsec.rst b/doc/guides/sample_app_ug/l2_forward_macsec.rst
index 5ae27ff2de..7e6c971465 100644
--- a/doc/guides/sample_app_ug/l2_forward_macsec.rst
+++ b/doc/guides/sample_app_ug/l2_forward_macsec.rst
@@ -75,7 +75,7 @@ issue the command:
 .. code-block:: console

    $ ./<build_dir>/examples/dpdk-l2fwd-macsec -a 0002:04:00.0 -a 0002:05:00.0 \
-       -a 0002:06:00.0 -a 0002:07:00.0 -c 0x1E -- -p 0xf                      \
+       -a 0002:06:00.0 -a 0002:07:00.0 -l 1-4 -- -p 0xf                      \
        --mcs-tx-portmask 0x5 --mcs-rx-portmask 0xA                            \
        --mcs-port-config '(0,02:03:04:05:06:07,01:02:03:04:05:06),            \
        (1,02:03:04:05:06:17,01:02:03:04:05:16),                               \
@@ -89,7 +89,7 @@ issue the command:
 .. code-block:: console

    $ ./<build_dir>/examples/dpdk-l2fwd-macsec -a 0002:04:00.0 -a 0002:05:00.0 \
-       -a 0002:06:00.0 -a 0002:07:00.0 -c 0x1E -- -p 0xf                      \
+       -a 0002:06:00.0 -a 0002:07:00.0 -l 1-4 -- -p 0xf                      \
        --mcs-tx-portmask 0x5 --mcs-rx-portmask 0xA                            \
        --mcs-port-config="(0,02:03:04:05:06:07,01:02:03:04:05:06),            \
        (1,02:03:04:05:06:17,01:02:03:04:05:16),                               \
diff --git a/doc/guides/sample_app_ug/l3_forward.rst b/doc/guides/sample_app_ug/l3_forward.rst
index de347eeeb1..6f3cca7a9c 100644
--- a/doc/guides/sample_app_ug/l3_forward.rst
+++ b/doc/guides/sample_app_ug/l3_forward.rst
@@ -218,7 +218,7 @@ scheduler. The following is the sample command:

 .. code-block:: console

-    ./<build_dir>/examples/dpdk-l3fwd -l 0-7 -s 0xf0000 -n 4 --vdev event_sw0 -- -p 0x3 --mode=eventdev --eventq-sched=ordered --rule_ipv4="rule_ipv4.cfg" --rule_ipv6="rule_ipv6.cfg"
+    ./<build_dir>/examples/dpdk-l3fwd -l 0-7 -S 16-19 -n 4 --vdev event_sw0 -- -p 0x3 --mode=eventdev --eventq-sched=ordered --rule_ipv4="rule_ipv4.cfg" --rule_ipv6="rule_ipv6.cfg"

 In case of eventdev mode, *--config* option is not used for ethernet port
 configuration. Instead, each ethernet port will be configured with this
diff --git a/doc/guides/sample_app_ug/multi_process.rst b/doc/guides/sample_app_ug/multi_process.rst
index 64026e2c92..1f77dd4bd6 100644
--- a/doc/guides/sample_app_ug/multi_process.rst
+++ b/doc/guides/sample_app_ug/multi_process.rst
@@ -36,7 +36,7 @@ Running the Application
 ^^^^^^^^^^^^^^^^^^^^^^^

 To run the application, start ``simple_mp`` binary in one terminal,
-passing at least two cores in the coremask/corelist:
+passing at least two cores in the corelist:

 .. code-block:: console

@@ -65,7 +65,7 @@ The process should start successfully and display a command prompt as follows:
     simple_mp >

 To run the secondary process to communicate with the primary process,
-again run the same binary setting at least two cores in the coremask/corelist:
+again run the same binary setting at least two cores in the corelist:

 .. code-block:: console

@@ -230,8 +230,8 @@ In addition to the EAL parameters, the application-specific parameters are:
 .. note::

    In the server process, has a single thread using the lowest numbered lcore
-   in the coremask/corelist, performs all packet I/O.
-   If coremask/corelist parameter specifies with more than a single lcore bit set,
+   in the corelist, performs all packet I/O.
+   If corelist parameter specifies with more than a single lcore,
    an additional lcore will be used for a thread to print packet count periodically.

 The server application stores configuration data in shared memory,
diff --git a/doc/guides/sample_app_ug/ntb.rst b/doc/guides/sample_app_ug/ntb.rst
index f80b221db7..f54de6cecd 100644
--- a/doc/guides/sample_app_ug/ntb.rst
+++ b/doc/guides/sample_app_ug/ntb.rst
@@ -32,7 +32,7 @@ The only available options are the standard ones for the EAL:

 .. code-block:: console

-    ./<build_dir>/examples/dpdk-ntb -c 0xf -n 6 -- -i
+    ./<build_dir>/examples/dpdk-ntb -l 0-3 -n 6 -- -i

 Refer to the *DPDK Getting Started Guide* for general information on
 running applications and the Environment Abstraction Layer (EAL)
diff --git a/doc/guides/sample_app_ug/pipeline.rst b/doc/guides/sample_app_ug/pipeline.rst
index 58ed0d296a..2d7c977068 100644
--- a/doc/guides/sample_app_ug/pipeline.rst
+++ b/doc/guides/sample_app_ug/pipeline.rst
@@ -58,7 +58,7 @@ The following is an example command to run the application configured for the VX

 .. code-block:: console

-    $ ./<build_dir>/examples/dpdk-pipeline -c 0x3 -- -s examples/pipeline/examples/vxlan.cli
+    $ ./<build_dir>/examples/dpdk-pipeline -l 0,1 -- -s examples/pipeline/examples/vxlan.cli

 The application should start successfully and display as follows:

diff --git a/doc/guides/sample_app_ug/qos_scheduler.rst b/doc/guides/sample_app_ug/qos_scheduler.rst
index 9936b99172..36ada4902c 100644
--- a/doc/guides/sample_app_ug/qos_scheduler.rst
+++ b/doc/guides/sample_app_ug/qos_scheduler.rst
@@ -194,7 +194,7 @@ Another example with 2 packet flow configurations using different ports but shar
 Note that independent cores for the packet flow configurations for each of the RX, WT and TX thread are also supported,
 providing flexibility to balance the work.

-The EAL coremask/corelist is constrained to contain the default main core 1 and the RX, WT and TX cores only.
+The EAL corelist is constrained to contain the default main core 1 and the RX, WT and TX cores only.

 Explanation
 -----------
diff --git a/doc/guides/sample_app_ug/test_pipeline.rst b/doc/guides/sample_app_ug/test_pipeline.rst
index d57d08fb2c..818be93cd6 100644
--- a/doc/guides/sample_app_ug/test_pipeline.rst
+++ b/doc/guides/sample_app_ug/test_pipeline.rst
@@ -47,7 +47,7 @@ The application execution command line is:

     ./dpdk-test-pipeline [EAL options] -- -p PORTMASK --TABLE_TYPE

-The -c or -l EAL CPU coremask/corelist option has to contain exactly 3 CPU cores.
+The ``-l/--lcores`` EAL CPU corelist option has to contain exactly 3 CPU cores.
 The first CPU core in the core mask is assigned for core A, the second for core B and the third for core C.

 The PORTMASK parameter must contain 2 or 4 ports.
diff --git a/doc/guides/sample_app_ug/vdpa.rst b/doc/guides/sample_app_ug/vdpa.rst
index f3e96f36d7..38be28945d 100644
--- a/doc/guides/sample_app_ug/vdpa.rst
+++ b/doc/guides/sample_app_ug/vdpa.rst
@@ -54,7 +54,7 @@ Take IFCVF driver for example:

 .. code-block:: console

-        ./dpdk-vdpa -c 0x2 -n 4 --numa-mem 1024,1024 \
+        ./dpdk-vdpa -l 1 -n 4 --numa-mem 1024,1024 \
                 -a 0000:06:00.3,vdpa=1 -a 0000:06:00.4,vdpa=1 \
                 -- --interactive

diff --git a/doc/guides/tools/comp_perf.rst b/doc/guides/tools/comp_perf.rst
index d8b8aa96a2..4299ef0b3f 100644
--- a/doc/guides/tools/comp_perf.rst
+++ b/doc/guides/tools/comp_perf.rst
@@ -43,10 +43,9 @@ The following are the EAL command-line options that can be used in conjunction
 with the ``dpdk-test-compress-perf`` application.
 See the DPDK Getting Started Guides for more information on these options.

-*   ``-c <COREMASK>`` or ``-l <CORELIST>``
+*   ``-l <CORELIST>``

-	Set the hexadecimal bitmask of the cores to run on. The corelist is a
-	list cores to use.
+	Specify the cores to be used by the application.

 .. Note::

diff --git a/doc/guides/tools/cryptoperf.rst b/doc/guides/tools/cryptoperf.rst
index 4b8352de71..5924a247ba 100644
--- a/doc/guides/tools/cryptoperf.rst
+++ b/doc/guides/tools/cryptoperf.rst
@@ -60,10 +60,9 @@ The following are the EAL command-line options that can be used in conjunction
 with the ``dpdk-test-crypto-perf`` application.
 See the DPDK Getting Started Guides for more information on these options.

-*   ``-c <COREMASK>`` or ``-l <CORELIST>``
+*   ``-l <CORELIST>``

-        Set the hexadecimal bitmask of the cores to run on. The corelist is a
-        list cores to use.
+        Specify the cores to be used by the application.

 *   ``-a <PCI>``

diff --git a/doc/guides/tools/graph.rst b/doc/guides/tools/graph.rst
index c53fe02b5b..0ffd29e41f 100644
--- a/doc/guides/tools/graph.rst
+++ b/doc/guides/tools/graph.rst
@@ -31,10 +31,9 @@ Following are the EAL command-line options that can be used in conjunction
 with the ``dpdk-graph`` application.
 See the DPDK Getting Started Guides for more information on these options.

-``-c <COREMASK>`` or ``-l <CORELIST>``
+``-l <CORELIST>``

-   Set the hexadecimal bit mask of the cores to run on.
-   The CORELIST is a list of cores to be used.
+   List the set of cores to be used.

 Application Options
 ~~~~~~~~~~~~~~~~~~~
@@ -95,21 +94,21 @@ For H/W devices

 .. code-block:: console

-   ./dpdk-graph -c 0xff -a 0002:02:00.0 -a 0002:03:00.0 --
+   ./dpdk-graph -l 0-7 -a 0002:02:00.0 -a 0002:03:00.0 --
                 -s <dpdk_root_dir>/app/graph/examples/l3fwd.cli

-   ./dpdk-graph -c 0xff -a 0002:02:00.0 -a 0002:03:00.0 --
+   ./dpdk-graph -l 0-7 -a 0002:02:00.0 -a 0002:03:00.0 --
                 -s <dpdk_root_dir>/app/graph/examples/l2fwd.cli

 For net_pcapX devices

 .. code-block:: console

-   ./dpdk-graph -c 0xff --vdev=net_pcap0,rx_pcap=in_net_pcap0.pcap,tx_pcap=out_net_pcap1.pcap
+   ./dpdk-graph -l 0-7 --vdev=net_pcap0,rx_pcap=in_net_pcap0.pcap,tx_pcap=out_net_pcap1.pcap
                         --vdev=net_pcap1,rx_pcap=in_net_pcap1.pcap,tx_pcap=out_net_pcap0.pcap
                         -- -s <dpdk_root_dir>/app/graph/examples/l3fwd_pcap.cli

-   ./dpdk-graph -c 0xff --vdev=net_pcap0,rx_pcap=in_net_pcap0.pcap,tx_pcap=out_net_pcap1.pcap
+   ./dpdk-graph -l 0-7 --vdev=net_pcap0,rx_pcap=in_net_pcap0.pcap,tx_pcap=out_net_pcap1.pcap
                         --vdev=net_pcap1,rx_pcap=in_net_pcap1.pcap,tx_pcap=out_net_pcap0.pcap
                         -- -s <dpdk_root_dir>/app/graph/examples/l2fwd_pcap.cli

diff --git a/doc/guides/tools/testbbdev.rst b/doc/guides/tools/testbbdev.rst
index ddb8d787be..8677cd2c43 100644
--- a/doc/guides/tools/testbbdev.rst
+++ b/doc/guides/tools/testbbdev.rst
@@ -78,7 +78,7 @@ The following are the command-line options:

 ``-l NUM_LCORES, --num_lcores NUM_LCORES``
  Specifies number of lcores to run. If not specified num_lcores is set
- according to value from RTE configuration (EAL coremask)
+ according to value from RTE configuration (EAL corelist)

 ``-b BURST_SIZE [BURST_SIZE ...], --burst-size BURST_SIZE [BURST_SIZE ...]``
  Specifies operations enqueue/dequeue burst size. If not specified burst_size is
diff --git a/doc/guides/tools/testeventdev.rst b/doc/guides/tools/testeventdev.rst
index c4e1047fbb..cd367eb2a2 100644
--- a/doc/guides/tools/testeventdev.rst
+++ b/doc/guides/tools/testeventdev.rst
@@ -27,10 +27,9 @@ The following are the EAL command-line options that can be used in conjunction
 with the ``dpdk-test-eventdev`` application.
 See the DPDK Getting Started Guides for more information on these options.

-*   ``-c <COREMASK>`` or ``-l <CORELIST>``
+*   ``-l <CORELIST>``

-        Set the hexadecimal bitmask of the cores to run on. The corelist is a
-        list of cores to use.
+        List the set of cores to use.

 *   ``--vdev <driver><id>``

@@ -329,7 +328,7 @@ Example command to run order queue test:

 .. code-block:: console

-   sudo <build_dir>/app/dpdk-test-eventdev -c 0x1f -s 0x10 --vdev=event_sw0 -- \
+   sudo <build_dir>/app/dpdk-test-eventdev -l 0-4 -S 4 --vdev=event_sw0 -- \
                 --test=order_queue --plcores 1 --wlcores 2,3


@@ -416,14 +415,14 @@ Example command to run with the software event device:

 .. code-block:: console

-   sudo <build_dir>/app/dpdk-test-eventdev -c 0x1f -s 0x10 --vdev=event_sw0 -- \
+   sudo <build_dir>/app/dpdk-test-eventdev -l 0-4 -S 4 --vdev=event_sw0 -- \
                 --test=atomic_queue --plcores 1 --wlcores 2,3

 Example command to run with the distributed software event device:

 .. code-block:: console

-   sudo <build_dir>/app/dpdk-test-eventdev -c 0x1f --vdev=event_dsw0 -- \
+   sudo <build_dir>/app/dpdk-test-eventdev -l 0-4 --vdev=event_dsw0 -- \
                 --test=atomic_queue --plcores 1 --wlcores 2,3,4


@@ -486,7 +485,7 @@ Example command to run order ``all types queue`` test:

 .. code-block:: console

-   sudo <build_dir>/app/dpdk-test-eventdev -c 0x1f -- \
+   sudo <build_dir>/app/dpdk-test-eventdev -l 0-4 -- \
                         --test=order_atq --plcores 1 --wlcores 2,3


@@ -550,7 +549,7 @@ Example command to run order ``all types queue`` test:

 .. code-block:: console

-   sudo <build_dir>/app/dpdk-test-eventdev -c 0x1f -- \
+   sudo <build_dir>/app/dpdk-test-eventdev -l 0-4 -- \
                         --test=atomic_atq --plcores 1 --wlcores 2,3


@@ -657,14 +656,14 @@ Example command to run perf queue test:

 .. code-block:: console

-   sudo <build_dir>/app/dpdk-test-eventdev -c 0xf -s 0x2 --vdev=event_sw0 -- \
+   sudo <build_dir>/app/dpdk-test-eventdev -l 0-3 -S 1 --vdev=event_sw0 -- \
         --test=perf_queue --plcores=2 --wlcore=3 --stlist=p --nb_pkts=0

 Example command to run perf queue test with producer enqueuing a burst of events:

 .. code-block:: console

-   sudo <build_dir>/app/dpdk-test-eventdev -c 0xf -s 0x2 --vdev=event_sw0 -- \
+   sudo <build_dir>/app/dpdk-test-eventdev -l 0-3 -S 1 --vdev=event_sw0 -- \
         --test=perf_queue --plcores=2 --wlcore=3 --stlist=p --nb_pkts=0 \
         --prod_enq_burst_sz=32

@@ -672,14 +671,14 @@ Example command to run perf queue test with ethernet ports:

 .. code-block:: console

-   sudo build/app/dpdk-test-eventdev -c 0xf -s 0x2 --vdev=event_sw0 -- \
+   sudo build/app/dpdk-test-eventdev -l 0-3 -S 1 --vdev=event_sw0 -- \
         --test=perf_queue --plcores=2 --wlcore=3 --stlist=p --prod_type_ethdev

 Example command to run perf queue test with event timer adapter:

 .. code-block:: console

-   sudo  <build_dir>/app/dpdk-test-eventdev -c 0xfff1 \
+   sudo  <build_dir>/app/dpdk-test-eventdev -l 0,4-15 \
                 -- --wlcores 4 --plcores 12 --test perf_queue --stlist=a \
                 --prod_type_timerdev --fwd_latency

@@ -687,7 +686,7 @@ Example command to run perf queue test with event DMA adapter:

 .. code-block:: console

-   sudo <build_dir>/app/dpdk-test-eventdev -c 0x1f -s 0x2 \
+   sudo <build_dir>/app/dpdk-test-eventdev -l 0-4 -S 1 \
                -- --test=perf_queue --plcores= 2 --wlcore=3 --stlist=a \
                --prod_type_dmadev --dma_adptr_mode=1

@@ -778,14 +777,14 @@ Example command to run perf ``all types queue`` test:

 .. code-block:: console

-   sudo <build_dir>/app/dpdk-test-eventdev -c 0xf -- \
+   sudo <build_dir>/app/dpdk-test-eventdev -l 0-3 -- \
                 --test=perf_atq --plcores=2 --wlcore=3 --stlist=p --nb_pkts=0

 Example command to run perf ``all types queue`` test with event timer adapter:

 .. code-block:: console

-   sudo  <build_dir>/app/dpdk-test-eventdev -c 0xfff1 \
+   sudo  <build_dir>/app/dpdk-test-eventdev -l 0,4-15 \
                 -- --wlcores 4 --plcores 12 --test perf_atq --verbose 20 \
                 --stlist=a --prod_type_timerdev --fwd_latency

@@ -793,7 +792,7 @@ Example command to run perf atq test with event DMA adapter:

 .. code-block:: console

-   sudo <build_dir>/app/dpdk-test-eventdev -c 0x1f -s 0x2 \
+   sudo <build_dir>/app/dpdk-test-eventdev -l 0-4 -S 1 \
                -- --test=perf_atq --plcores= 2 --wlcore=3 --stlist=a \
                --prod_type_dmadev --dma_adptr_mode=1

@@ -911,14 +910,14 @@ Example command to run pipeline queue test:

 .. code-block:: console

-    sudo <build_dir>/app/dpdk-test-eventdev -c 0xf -s 0x8 --vdev=event_sw0 -- \
+    sudo <build_dir>/app/dpdk-test-eventdev -l 0-3 -S 3 --vdev=event_sw0 -- \
         --test=pipeline_queue --wlcore=1 --prod_type_ethdev --stlist=a

 Example command to run pipeline atq test with vector events:

 .. code-block:: console

-    sudo <build_dir>/app/dpdk-test-eventdev -c 0xf -s 0x8 --vdev=event_sw0 -- \
+    sudo <build_dir>/app/dpdk-test-eventdev -l 0-3 -S 3 --vdev=event_sw0 -- \
         --test=pipeline_queue --wlcore=1 --prod_type_ethdev --stlist=a \
         --enable_vector  --vector_size 512

@@ -1017,13 +1016,13 @@ Example command to run pipeline atq test:

 .. code-block:: console

-    sudo <build_dir>/app/dpdk-test-eventdev -c 0xf -- \
+    sudo <build_dir>/app/dpdk-test-eventdev -l 0-3 -- \
         --test=pipeline_atq --wlcore=1 --prod_type_ethdev --stlist=a

 Example command to run pipeline atq test with vector events:

 .. code-block:: console

-    sudo <build_dir>/app/dpdk-test-eventdev -c 0xf -- \
+    sudo <build_dir>/app/dpdk-test-eventdev -l 0-3 -- \
         --test=pipeline_atq --wlcore=1 --prod_type_ethdev --stlist=a \
         --enable_vector  --vector_size 512
diff --git a/doc/guides/tools/testmldev.rst b/doc/guides/tools/testmldev.rst
index 55e26eed08..e3182c960f 100644
--- a/doc/guides/tools/testmldev.rst
+++ b/doc/guides/tools/testmldev.rst
@@ -28,9 +28,8 @@ The following are the EAL command-line options that can be used
 with the ``dpdk-test-mldev`` application.
 See the DPDK Getting Started Guides for more information on these options.

-``-c <COREMASK>`` or ``-l <CORELIST>``
-  Set the hexadecimal bitmask of the cores to run on.
-  The corelist is a list of cores to use.
+``-l <CORELIST>``
+  List the set of cores to use.

 ``-a <PCI_ID>``
   Attach a PCI based ML device.
@@ -160,14 +159,14 @@ Command to run ``device_ops`` test:

 .. code-block:: console

-   sudo <build_dir>/app/dpdk-test-mldev -c 0xf -a <PCI_ID> -- \
+   sudo <build_dir>/app/dpdk-test-mldev -l 0-3 -a <PCI_ID> -- \
         --test=device_ops

 Command to run ``device_ops`` test with user options:

 .. code-block:: console

-   sudo <build_dir>/app/dpdk-test-mldev -c 0xf -a <PCI_ID> -- \
+   sudo <build_dir>/app/dpdk-test-mldev -l 0-3 -a <PCI_ID> -- \
         --test=device_ops --queue_pairs <M> --queue_size <N>


@@ -254,7 +253,7 @@ Command to run ``model_ops`` test:

 .. code-block:: console

-   sudo <build_dir>/app/dpdk-test-mldev -c 0xf -a <PCI_ID> -- \
+   sudo <build_dir>/app/dpdk-test-mldev -l 0-3 -a <PCI_ID> -- \
         --test=model_ops --models model_1.bin,model_2.bin,model_3.bin, model_4.bin


@@ -349,14 +348,14 @@ Example command to run ``inference_ordered`` test:

 .. code-block:: console

-   sudo <build_dir>/app/dpdk-test-mldev -c 0xf -a <PCI_ID> -- \
+   sudo <build_dir>/app/dpdk-test-mldev -l 0-3 -a <PCI_ID> -- \
         --test=inference_ordered --filelist model.bin,input.bin,output.bin

 Example command to run ``inference_ordered`` test with a specific burst size:

 .. code-block:: console

-   sudo <build_dir>/app/dpdk-test-mldev -c 0xf -a <PCI_ID> -- \
+   sudo <build_dir>/app/dpdk-test-mldev -l 0-3 -a <PCI_ID> -- \
         --test=inference_ordered --filelist model.bin,input.bin,output.bin \
         --burst_size 12

@@ -364,7 +363,7 @@ Example command to run ``inference_ordered`` test with multiple queue-pairs and

 .. code-block:: console

-   sudo <build_dir>/app/dpdk-test-mldev -c 0xf -a <PCI_ID> -- \
+   sudo <build_dir>/app/dpdk-test-mldev -l 0-3 -a <PCI_ID> -- \
         --test=inference_ordered --filelist model.bin,input.bin,output.bin \
         --queue_pairs 4 --queue_size 16

@@ -372,7 +371,7 @@ Example command to run ``inference_ordered`` with output validation using tolera

 .. code-block:: console

-   sudo <build_dir>/app/dpdk-test-mldev -c 0xf -a <PCI_ID> -- \
+   sudo <build_dir>/app/dpdk-test-mldev -l 0-3 -a <PCI_ID> -- \
         --test=inference_ordered --filelist model.bin,input.bin,output.bin,reference.bin \
         --tolerance 1.0

@@ -405,14 +404,14 @@ Example command to run ``inference_interleave`` test:

 .. code-block:: console

-   sudo <build_dir>/app/dpdk-test-mldev -c 0xf -a <PCI_ID> -- \
+   sudo <build_dir>/app/dpdk-test-mldev -l 0-3 -a <PCI_ID> -- \
         --test=inference_interleave --filelist model.bin,input.bin,output.bin

 Example command to run ``inference_interleave`` test with multiple models:

 .. code-block:: console

-   sudo <build_dir>/app/dpdk-test-mldev -c 0xf -a <PCI_ID> -- \
+   sudo <build_dir>/app/dpdk-test-mldev -l 0-3 -a <PCI_ID> -- \
         --test=inference_interleave --filelist model_A.bin,input_A.bin,output_A.bin \
         --filelist model_B.bin,input_B.bin,output_B.bin

@@ -421,7 +420,7 @@ with a specific burst size, multiple queue-pairs and queue size:

 .. code-block:: console

-   sudo <build_dir>/app/dpdk-test-mldev -c 0xf -a <PCI_ID> -- \
+   sudo <build_dir>/app/dpdk-test-mldev -l 0-3 -a <PCI_ID> -- \
         --test=inference_interleave --filelist model.bin,input.bin,output.bin \
         --queue_pairs 8 --queue_size 12 --burst_size 16

@@ -430,7 +429,7 @@ with multiple models and output validation using tolerance of ``2.0%``:

 .. code-block:: console

-   sudo <build_dir>/app/dpdk-test-mldev -c 0xf -a <PCI_ID> -- \
+   sudo <build_dir>/app/dpdk-test-mldev -l 0-3 -a <PCI_ID> -- \
         --test=inference_interleave \
         --filelist model_A.bin,input_A.bin,output_A.bin,reference_A.bin \
         --filelist model_B.bin,input_B.bin,output_B.bin,reference_B.bin \
--
2.48.1

