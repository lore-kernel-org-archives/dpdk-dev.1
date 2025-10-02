Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A88CAC5B8
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Oct 2025 11:33:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7223940DD0;
	Thu,  2 Oct 2025 13:33:02 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id A235440BA4
 for <dev@dpdk.org>; Thu,  2 Oct 2025 13:33:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759404780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qvpThoU2rRPSpUwTsdlAYJyE8H59FweCCP2eyFjanVc=;
 b=Ar9YCWs4BL4mqPCJroWjCNBvFZjAERsbsWyGD3Q9RJbBHWBCodgq6/QqpuEHtmkhR4aYwf
 FvOmotAmezt3s1qvJkPQyaSazm/9NdeF/8NHmOr7ZaNGG0eDwRiN14HlBpkFIwtUBHGcJP
 e2g+AfhPD7k0tHvD8ZlgTPkuvFSbzps=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-WQcdl-ngOKylSnCtsp9DtQ-1; Thu,
 02 Oct 2025 07:32:58 -0400
X-MC-Unique: WQcdl-ngOKylSnCtsp9DtQ-1
X-Mimecast-MFC-AGG-ID: WQcdl-ngOKylSnCtsp9DtQ_1759404772
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CDB381956094; Thu,  2 Oct 2025 11:32:51 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.224.213])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5755C1800446; Thu,  2 Oct 2025 11:32:31 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Nandini Persad <nandinipersad361@gmail.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Gagandeep Singh <g.singh@nxp.com>,
 Matan Azrad <matan@nvidia.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Shepard Siegel <shepard.siegel@atomicrules.com>,
 Ed Czeck <ed.czeck@atomicrules.com>,
 John Miller <john.miller@atomicrules.com>,
 Selwin Sebastian <selwin.sebastian@amd.com>,
 Julien Aube <julien_dpdk@jaube.fr>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>,
 Potnuri Bharat Teja <bharat@chelsio.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Shai Brandes <shaibran@amazon.com>,
 Evgeny Schemeilin <evgenys@amazon.com>, Ron Beider <rbeider@amazon.com>,
 Amit Bernstein <amitbern@amazon.com>, Wajeeh Atrash <atrwajee@amazon.com>,
 John Daley <johndale@cisco.com>, Hyong Youb Kim <hyonkim@cisco.com>,
 Gaetan Rivet <grive@u256.net>, Ziyang Xuan <xuanziyang2@huawei.com>,
 Xiaoyun Wang <cloud.wangxiaoyun@huawei.com>,
 Xingui Yang <yangxingui@huawei.com>,
 Chengwen Feng <fengchengwen@huawei.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Rosen Xu <rosen.xu@altera.com>, Long Li <longli@microsoft.com>,
 Wei Hu <weh@microsoft.com>, Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Liron Himi <lironh@marvell.com>, Chaoyong He <chaoyong.he@corigine.com>,
 Jiawen Wu <jiawenwu@trustnetic.com>, Zaiyu Wang <zaiyuwang@trustnetic.com>,
 Devendra Singh Rawat <dsinghrawat@marvell.com>,
 Alok Prasad <palok@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
 Maciej Czekaj <mczekaj@marvell.com>, Jian Wang <jianwang@trustnetic.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>, Junlong Wang <wang.junlong1@zte.com.cn>,
 Lijie Shan <shan.lijie@zte.com.cn>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Aman Singh <aman.deep.singh@intel.com>,
 Luca Vizzarro <luca.vizzarro@arm.com>, Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH v2 2/2] doc: fix anchors namespace in guides
Date: Thu,  2 Oct 2025 13:32:03 +0200
Message-ID: <20251002113208.3415704-2-david.marchand@redhat.com>
In-Reply-To: <20251002113208.3415704-1-david.marchand@redhat.com>
References: <20250527140435.21361-1-nandinipersad361@gmail.com>
 <20251002113208.3415704-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XyTrV8pCAP2Rgg51FFXJg32Tljq8t9XhiSdl5bIptTU_1759404772
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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

From: Nandini Persad <nandinipersad361@gmail.com>

I modified the anchors names within the guides to have a
a clear prefix so that they don't collide, based on
advice from Thomas.

Signed-off-by: Nandini Persad <nandinipersad361@gmail.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
Signed-off-by: David Marchand <david.marchand@redhat.com>
---
Changes since v1:
- rebased,
- used Claude to fix documentation generation, and generated content:
  - update references to renamed anchors,
  - drop changes on anchors for external links,
  - fix some anchors definition/usage order,
- asked Claude to go further:
  - rename EAL anchors too,
  - prefix with nics_<driver_name>_ instead of simple nics_,

---
 doc/guides/compressdevs/mlx5.rst              |  4 +-
 doc/guides/cryptodevs/dpaa2_sec.rst           |  6 +--
 doc/guides/cryptodevs/dpaa_sec.rst            |  4 +-
 doc/guides/cryptodevs/mlx5.rst                |  8 ++--
 doc/guides/freebsd_gsg/build_dpdk.rst         |  8 ++--
 doc/guides/freebsd_gsg/build_sample_apps.rst  |  8 ++--
 doc/guides/freebsd_gsg/install_from_ports.rst | 12 ++---
 doc/guides/freebsd_gsg/intro.rst              |  2 +-
 doc/guides/howto/avx512.rst                   |  2 +-
 doc/guides/howto/flow_bifurcation.rst         |  2 +-
 doc/guides/linux_gsg/build_dpdk.rst           |  2 +-
 doc/guides/linux_gsg/build_sample_apps.rst    |  2 +-
 .../linux_gsg/cross_build_dpdk_for_arm64.rst  |  8 ++--
 doc/guides/linux_gsg/enable_func.rst          |  8 ++--
 doc/guides/linux_gsg/linux_drivers.rst        | 14 +++---
 doc/guides/linux_gsg/sys_reqs.rst             |  4 +-
 doc/guides/nics/ark.rst                       |  2 +-
 doc/guides/nics/axgbe.rst                     |  2 +-
 doc/guides/nics/bnx2x.rst                     |  4 +-
 doc/guides/nics/build_and_test.rst            |  2 +-
 doc/guides/nics/cnxk.rst                      |  6 +--
 doc/guides/nics/cxgbe.rst                     | 28 ++++++------
 doc/guides/nics/dpaa.rst                      |  6 +--
 doc/guides/nics/dpaa2.rst                     | 10 ++---
 doc/guides/nics/ena.rst                       |  2 +-
 doc/guides/nics/enetc.rst                     |  2 +-
 doc/guides/nics/enic.rst                      |  2 +-
 doc/guides/nics/fail_safe.rst                 |  2 +-
 doc/guides/nics/hinic.rst                     |  2 +-
 doc/guides/nics/hns3.rst                      |  2 +-
 doc/guides/nics/i40e.rst                      | 10 ++---
 doc/guides/nics/ice.rst                       |  2 +-
 doc/guides/nics/igc.rst                       |  2 +-
 doc/guides/nics/intel_vf.rst                  | 22 +++++-----
 doc/guides/nics/ipn3ke.rst                    |  2 +-
 doc/guides/nics/ixgbe.rst                     |  2 +-
 doc/guides/nics/mana.rst                      |  2 +-
 doc/guides/nics/mlx4.rst                      | 13 +++---
 doc/guides/nics/mlx5.rst                      | 44 +++++++++----------
 doc/guides/nics/mvpp2.rst                     | 24 +++++-----
 doc/guides/nics/netvsc.rst                    |  4 +-
 doc/guides/nics/nfp.rst                       |  2 +-
 doc/guides/nics/ngbe.rst                      |  2 +-
 doc/guides/nics/octeontx.rst                  |  4 +-
 doc/guides/nics/overview.rst                  |  2 +-
 doc/guides/nics/pfe.rst                       |  2 +-
 doc/guides/nics/qede.rst                      |  8 ++--
 doc/guides/nics/thunderx.rst                  |  4 +-
 doc/guides/nics/txgbe.rst                     |  2 +-
 doc/guides/nics/vdev_netvsc.rst               |  6 +--
 doc/guides/nics/virtio.rst                    |  2 +-
 doc/guides/nics/zxdh.rst                      |  2 +-
 doc/guides/platform/cnxk.rst                  | 16 +++----
 doc/guides/platform/dpaa.rst                  |  4 +-
 doc/guides/platform/dpaa2.rst                 |  2 +-
 doc/guides/platform/mlx5.rst                  | 28 ++++++------
 doc/guides/platform/octeontx.rst              |  6 +--
 .../prog_guide/env_abstraction_layer.rst      | 22 +++++-----
 .../prog_guide/packet_classif_access_ctrl.rst |  2 +-
 doc/guides/regexdevs/mlx5.rst                 |  6 +--
 doc/guides/rel_notes/release_17_02.rst        |  2 +-
 doc/guides/sample_app_ug/compiling.rst        |  4 +-
 doc/guides/testpmd_app_ug/testpmd_funcs.rst   |  4 +-
 doc/guides/tools/dts.rst                      | 20 ++++-----
 doc/guides/vdpadevs/mlx5.rst                  |  4 +-
 65 files changed, 225 insertions(+), 224 deletions(-)

diff --git a/doc/guides/compressdevs/mlx5.rst b/doc/guides/compressdevs/mlx5.rst
index b64818444a..f41cc2da25 100644
--- a/doc/guides/compressdevs/mlx5.rst
+++ b/doc/guides/compressdevs/mlx5.rst
@@ -98,7 +98,7 @@ Limitations
 Driver options
 --------------
 
-Please refer to :ref:`mlx5 common options <mlx5_common_driver_options>`
+Please refer to :ref:`mlx5 common options <platform_mlx5_common_driver_options>`
 for an additional list of options shared with other mlx5 drivers.
 
 - ``log-block-size`` parameter [int]
@@ -118,4 +118,4 @@ Prerequisites
 -------------
 
 - NVIDIA MLNX_OFED version: **5.2**
-  See :ref:`mlx5 common prerequisites <mlx5_linux_prerequisites>` for more details.
+  See :ref:`mlx5 common prerequisites <platform_mlx5_linux_prerequisites>` for more details.
diff --git a/doc/guides/cryptodevs/dpaa2_sec.rst b/doc/guides/cryptodevs/dpaa2_sec.rst
index 6b1357d78a..021bfe5d48 100644
--- a/doc/guides/cryptodevs/dpaa2_sec.rst
+++ b/doc/guides/cryptodevs/dpaa2_sec.rst
@@ -22,7 +22,7 @@ higher-level cryptographic operations than previous NXP cryptographic
 accelerators. This provides significant improvement to system level performance.
 
 DPAA2_SEC is one of the hardware resource in DPAA2 Architecture. More information
-on DPAA2 Architecture is described in :ref:`dpaa2_overview`.
+on DPAA2 Architecture is described in :ref:`nics_dpaa2_overview`.
 
 DPAA2_SEC PMD is one of DPAA2 drivers which interacts with Management Complex (MC)
 portal to access the hardware object - DPSECI. The MC provides access to create,
@@ -32,7 +32,7 @@ DPAA2_SEC PMD also uses some of the other hardware resources like buffer pools,
 queues, queue portals to store and to enqueue/dequeue data to the hardware SEC.
 
 DPSECI objects are detected by PMD using a resource container called DPRC (like
-in :ref:`dpaa2_overview`).
+in :ref:`nics_dpaa2_overview`).
 
 For example:
 
@@ -158,7 +158,7 @@ Limitations
 Prerequisites
 -------------
 
-DPAA2_SEC driver has similar pre-requisites as described in :ref:`dpaa2_overview`.
+DPAA2_SEC driver has similar pre-requisites as described in :ref:`nics_dpaa2_overview`.
 The following dependencies are not part of DPDK and must be installed separately:
 
 See :doc:`../platform/dpaa2` for setup information
diff --git a/doc/guides/cryptodevs/dpaa_sec.rst b/doc/guides/cryptodevs/dpaa_sec.rst
index 0c8d6cf3da..c560604206 100644
--- a/doc/guides/cryptodevs/dpaa_sec.rst
+++ b/doc/guides/cryptodevs/dpaa_sec.rst
@@ -22,7 +22,7 @@ higher-level cryptographic operations than previous NXP cryptographic
 accelerators. This provides significant improvement to system level performance.
 
 DPAA_SEC is one of the hardware resource in DPAA Architecture. More information
-on DPAA Architecture is described in :ref:`dpaa_overview`.
+on DPAA Architecture is described in :ref:`nics_dpaa_overview`.
 
 DPAA_SEC PMD is one of DPAA drivers which interacts with QBMAN to create,
 configure and destroy the device instance using queue pair with CAAM portal.
@@ -104,7 +104,7 @@ Limitations
 Prerequisites
 -------------
 
-DPAA_SEC driver has similar pre-requisites as described in :ref:`dpaa_overview`.
+DPAA_SEC driver has similar pre-requisites as described in :ref:`nics_dpaa_overview`.
 
 See :doc:`../platform/dpaa` for setup information
 
diff --git a/doc/guides/cryptodevs/mlx5.rst b/doc/guides/cryptodevs/mlx5.rst
index 8a2ec20e74..6e20ffe6e6 100644
--- a/doc/guides/cryptodevs/mlx5.rst
+++ b/doc/guides/cryptodevs/mlx5.rst
@@ -64,7 +64,7 @@ Or, for non-continuous operations, extra UMR WQE will be used.
 Configuration
 -------------
 
-See the :ref:`mlx5 common configuration <mlx5_common_env>`.
+See the :ref:`mlx5 common configuration <platform_mlx5_common_env>`.
 
 A device comes out of NVIDIA factory with pre-defined import methods.
 There are two possible import methods: wrapped or plaintext (valid for AES-XTS only).
@@ -140,7 +140,7 @@ DEK is passed in plaintext without keytag.
 Driver options
 --------------
 
-Please refer to :ref:`mlx5 common options <mlx5_common_driver_options>`
+Please refer to :ref:`mlx5 common options <platform_mlx5_common_driver_options>`
 for an additional list of options shared with other mlx5 drivers.
 
 - ``algo`` parameter [int]
@@ -243,10 +243,10 @@ Linux Prerequisites
 - NVIDIA MLNX_OFED version: **5.3**.
 - Compilation can be done also with rdma-core v15+.
 
-  See :ref:`mlx5 common prerequisites <mlx5_linux_prerequisites>` for more details.
+  See :ref:`mlx5 common prerequisites <platform_mlx5_linux_prerequisites>` for more details.
 
 Windows Prerequisites
 ~~~~~~~~~~~~~~~~~~~~~
 
 - NVIDIA WINOF-2 version: **2.60** or higher.
-  See :ref:`mlx5 common prerequisites <mlx5_windows_prerequisites>` for more details.
+  See :ref:`mlx5 common prerequisites <platform_mlx5_windows_prerequisites>` for more details.
diff --git a/doc/guides/freebsd_gsg/build_dpdk.rst b/doc/guides/freebsd_gsg/build_dpdk.rst
index f98292bf41..a14b9e9f24 100644
--- a/doc/guides/freebsd_gsg/build_dpdk.rst
+++ b/doc/guides/freebsd_gsg/build_dpdk.rst
@@ -3,7 +3,7 @@
 
 .. include:: <isonum.txt>
 
-.. _building_from_source:
+.. _freebsd_gsg_building_from_source:
 
 Compiling the DPDK Target from Source
 =====================================
@@ -67,7 +67,7 @@ the next section.
         variable.
 
 
-.. _loading_contigmem:
+.. _freebsd_loading_contigmem:
 
 Loading the DPDK contigmem Module
 ---------------------------------
@@ -148,7 +148,7 @@ available and can be verified via dmesg or ``/var/log/messages``::
 
 To avoid this error, reduce the number of buffers or the buffer size.
 
-.. _loading_nic_uio:
+.. _freebsd_gsg_loading_nic_uio:
 
 Loading the DPDK nic_uio Module
 -------------------------------
@@ -185,7 +185,7 @@ already bound to a driver other than ``nic_uio``. The following sub-section desc
 how to query and modify the device ownership of the ports to be used by
 DPDK applications.
 
-.. _binding_network_ports:
+.. _freebsd_gsg_binding_network_ports:
 
 Binding Network Ports to the nic_uio Module
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/doc/guides/freebsd_gsg/build_sample_apps.rst b/doc/guides/freebsd_gsg/build_sample_apps.rst
index db01b16e18..290851902e 100644
--- a/doc/guides/freebsd_gsg/build_sample_apps.rst
+++ b/doc/guides/freebsd_gsg/build_sample_apps.rst
@@ -1,7 +1,7 @@
 ..  SPDX-License-Identifier: BSD-3-Clause
     Copyright(c) 2010-2014 Intel Corporation.
 
-.. _compiling_sample_apps:
+.. _freebsd_gsg_compiling_sample_apps:
 
 Compiling and Running Sample Applications
 =========================================
@@ -44,7 +44,7 @@ the installation of DPDK using `meson install` as described previously::
         ln -sf helloworld-shared build/helloworld
 
 
-.. _running_sample_app:
+.. _freebsd_gsg_running_sample_app:
 
 Running a Sample Application
 ----------------------------
@@ -52,14 +52,14 @@ Running a Sample Application
 #.  The ``contigmem`` and ``nic_uio`` modules must be set up prior to running an application.
 
 #.  Any ports to be used by the application must be already bound to the ``nic_uio`` module,
-    as described in section :ref:`binding_network_ports`, prior to running the application.
+    as described in section :ref:`freebsd_gsg_binding_network_ports`, prior to running the application.
     The application is linked with the DPDK target environment's Environment
     Abstraction Layer (EAL) library, which provides some options that are generic
     to every DPDK application.
 
 You can refer to :doc:`freebsd_eal_parameters` for the list of EAL options.
 
-.. _running_non_root:
+.. _freebsd_gsg_running_non_root:
 
 Running DPDK Applications Without Root Privileges
 -------------------------------------------------
diff --git a/doc/guides/freebsd_gsg/install_from_ports.rst b/doc/guides/freebsd_gsg/install_from_ports.rst
index 3c98c46b29..6e37f5665a 100644
--- a/doc/guides/freebsd_gsg/install_from_ports.rst
+++ b/doc/guides/freebsd_gsg/install_from_ports.rst
@@ -1,7 +1,7 @@
 ..  SPDX-License-Identifier: BSD-3-Clause
     Copyright(c) 2010-2014 Intel Corporation.
 
-.. _install_from_ports:
+.. _freebsd_gsg_install_from_ports:
 
 Installing DPDK from the Ports Collection
 =========================================
@@ -28,7 +28,7 @@ DPDK can be installed on FreeBSD using the command::
 After the installation of the DPDK package, instructions will be printed on
 how to install the kernel modules required to use the DPDK. A more
 complete version of these instructions can be found in the sections
-:ref:`loading_contigmem` and :ref:`loading_nic_uio`. Normally, lines like
+:ref:`freebsd_loading_contigmem` and :ref:`freebsd_gsg_loading_nic_uio`. Normally, lines like
 those below would be added to the file ``/boot/loader.conf``.
 
 .. code-block:: shell
@@ -61,7 +61,7 @@ Compiling and Running the Example Applications
 
 When the DPDK has been installed from the ports collection it installs
 its example applications in ``/usr/local/share/dpdk/examples``.
-These examples can be compiled and run as described in :ref:`compiling_sample_apps`.
+These examples can be compiled and run as described in :ref:`freebsd_gsg_compiling_sample_apps`.
 
 .. note::
 
@@ -73,7 +73,7 @@ These examples can be compiled and run as described in :ref:`compiling_sample_ap
 
    To install a copy of the DPDK compiled using gcc, please download the
    official DPDK package from https://core.dpdk.org/download/ and install manually using
-   the instructions given in the next chapter, :ref:`building_from_source`
+   the instructions given in the next chapter, :ref:`freebsd_gsg_building_from_source`
 
 An example application can therefore be copied to a user's home directory and
 compiled and run as below, where we have 2 memory blocks of size 1G reserved
@@ -117,9 +117,9 @@ via the contigmem module, and 4 NIC ports bound to the nic_uio module::
 
    To run a DPDK process as a non-root user, adjust the permissions on
    the ``/dev/contigmem`` and ``/dev/uio device`` nodes as described in section
-   :ref:`running_non_root`
+   :ref:`freebsd_gsg_running_non_root`
 
 .. note::
 
    For an explanation of the command-line parameters that can be passed to an
-   DPDK application, see section :ref:`running_sample_app`.
+   DPDK application, see section :ref:`freebsd_gsg_running_sample_app`.
diff --git a/doc/guides/freebsd_gsg/intro.rst b/doc/guides/freebsd_gsg/intro.rst
index fca647efad..c95859b595 100644
--- a/doc/guides/freebsd_gsg/intro.rst
+++ b/doc/guides/freebsd_gsg/intro.rst
@@ -18,7 +18,7 @@ handbook is available from the FreeBSD Documentation Project:
 
    DPDK is now available as part of the FreeBSD ports collection and as a pre-built package.
    Installing via the ports collection or FreeBSD `pkg` infrastructure is now the recommended
-   way to install DPDK on FreeBSD, and is documented in the next chapter, :ref:`install_from_ports`.
+   way to install DPDK on FreeBSD, and is documented in the next chapter, :ref:`freebsd_gsg_install_from_ports`.
 
 Documentation Roadmap
 ---------------------
diff --git a/doc/guides/howto/avx512.rst b/doc/guides/howto/avx512.rst
index 6c034b617d..03630d279c 100644
--- a/doc/guides/howto/avx512.rst
+++ b/doc/guides/howto/avx512.rst
@@ -22,7 +22,7 @@ which does not allow for AVX-512.
    rte_vect_set_max_simd_bitwidth(RTE_VECT_SIMD_512);
 
 This API should only be called once at initialization, before EAL init.
-For more information on the possible enum values to use as a parameter, go to :ref:`max_simd_bitwidth`:
+For more information on the possible enum values to use as a parameter, go to :ref:`eal_max_simd_bitwidth`:
 
 
 Using the command-line argument
diff --git a/doc/guides/howto/flow_bifurcation.rst b/doc/guides/howto/flow_bifurcation.rst
index 3a3a779ad0..217a3ef355 100644
--- a/doc/guides/howto/flow_bifurcation.rst
+++ b/doc/guides/howto/flow_bifurcation.rst
@@ -45,7 +45,7 @@ module.
 Using Flow Bifurcation on NVIDIA ConnectX
 -----------------------------------------
 
-The NVIDIA devices are :ref:`natively bifurcated <bifurcated_driver>`,
+The NVIDIA devices are :ref:`natively bifurcated <linux_gsg_bifurcated_driver>`,
 so there is no need to split into SR-IOV PF/VF
 in order to get the flow bifurcation mechanism.
 The full device is already shared with the kernel driver.
diff --git a/doc/guides/linux_gsg/build_dpdk.rst b/doc/guides/linux_gsg/build_dpdk.rst
index 8d2b1708b8..61f51c0bab 100644
--- a/doc/guides/linux_gsg/build_dpdk.rst
+++ b/doc/guides/linux_gsg/build_dpdk.rst
@@ -294,7 +294,7 @@ By adhering to these guidelines, you will ensure the most optimized build
 for ARM-based DPDK targets.
 
 
-.. _building_app_using_installed_dpdk:
+.. _linux_gsg_building_app_using_installed_dpdk:
 
 Building Applications Using Installed DPDK
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/doc/guides/linux_gsg/build_sample_apps.rst b/doc/guides/linux_gsg/build_sample_apps.rst
index cae17f0e33..a1f43b9506 100644
--- a/doc/guides/linux_gsg/build_sample_apps.rst
+++ b/doc/guides/linux_gsg/build_sample_apps.rst
@@ -10,7 +10,7 @@ It also provides a pointer to where sample applications are stored.
 Compiling a Sample Application
 ------------------------------
 
-Please refer to :ref:`building_app_using_installed_dpdk` for detail on compiling sample apps.
+Please refer to :ref:`linux_gsg_building_app_using_installed_dpdk` for detail on compiling sample apps.
 
 Running a Sample Application
 ----------------------------
diff --git a/doc/guides/linux_gsg/cross_build_dpdk_for_arm64.rst b/doc/guides/linux_gsg/cross_build_dpdk_for_arm64.rst
index e4de5c8d18..34416dde08 100644
--- a/doc/guides/linux_gsg/cross_build_dpdk_for_arm64.rst
+++ b/doc/guides/linux_gsg/cross_build_dpdk_for_arm64.rst
@@ -64,7 +64,7 @@ For aarch32, install ``pkg-config-arm-linux-gnueabihf``::
 GNU toolchain
 -------------
 
-.. _obtain_GNU_toolchain:
+.. _linux_gsg_obtain_GNU_toolchain:
 
 Get the cross toolchain
 ~~~~~~~~~~~~~~~~~~~~~~~
@@ -94,7 +94,7 @@ For aarch32::
    For the host requirements and other info, refer to the release note section:
    https://releases.linaro.org/components/toolchain/binaries/
 
-.. _augment_the_gnu_toolchain_with_numa_support:
+.. _linux_gsg_augment_the_gnu_toolchain_with_numa_support:
 
 Augment the GNU toolchain with NUMA support
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -198,7 +198,7 @@ https://developer.arm.com/tools-and-software/open-source-software/developer-tool
 
 The LLVM/Clang toolchain does not implement the standard c library.
 The GNU toolchain ships an implementation we can use.
-Refer to obtain_GNU_toolchain_ to get the GNU toolchain.
+Refer to linux_gsg_obtain_GNU_toolchain_ to get the GNU toolchain.
 
 Unzip and add into the PATH
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -214,7 +214,7 @@ Cross Compiling DPDK with LLVM/Clang toolchain using Meson
 .. note::
 
    To use the NUMA library follow the same steps as for
-   augment_the_gnu_toolchain_with_numa_support_.
+   linux_gsg_augment_the_gnu_toolchain_with_numa_support_.
 
 The paths to GNU stdlib must be specified in a cross file.
 Augmenting the default cross-file's ``c_args`` and ``c_link_args``
diff --git a/doc/guides/linux_gsg/enable_func.rst b/doc/guides/linux_gsg/enable_func.rst
index a551ddebec..0e47047805 100644
--- a/doc/guides/linux_gsg/enable_func.rst
+++ b/doc/guides/linux_gsg/enable_func.rst
@@ -3,12 +3,12 @@
 
 .. include:: <isonum.txt>
 
-.. _Enabling_Additional_Functionality:
+.. _linux_gsg_Enabling_Additional_Functionality:
 
 Enabling Additional Functionality
 =================================
 
-.. _Running_Without_Root_Privileges:
+.. _linux_gsg_Running_Without_Root_Privileges:
 
 Running DPDK Applications Without Root Privileges
 -------------------------------------------------
@@ -85,7 +85,7 @@ need to be adjusted in order to ensure normal DPDK operation:
 The above limits can usually be adjusted by editing
 ``/etc/security/limits.conf`` file, and rebooting.
 
-See :ref:`Hugepage Mapping <hugepage_mapping>` section to learn how these limits affect EAL.
+See :ref:`Hugepage Mapping <eal_hugepage_mapping>` section to learn how these limits affect EAL.
 
 Device Control
 ~~~~~~~~~~~~~~
@@ -162,7 +162,7 @@ Also see
 `CPU isolation example <https://www.suse.com/c/cpu-isolation-practical-example-part-5/>`_
 and `systemd core isolation example <https://www.rcannings.com/systemd-core-isolation/>`_.
 
-.. _High_Precision_Event_Timer:
+.. _linux_gsg_High_Precision_Event_Timer:
 
 High Precision Event Timer (HPET) Functionality
 -----------------------------------------------
diff --git a/doc/guides/linux_gsg/linux_drivers.rst b/doc/guides/linux_gsg/linux_drivers.rst
index 039823d61e..649af2df87 100644
--- a/doc/guides/linux_gsg/linux_drivers.rst
+++ b/doc/guides/linux_gsg/linux_drivers.rst
@@ -23,14 +23,14 @@ Binding and Unbinding Network Ports to/from the Kernel Modules
 
    PMDs which use the bifurcated driver should not be unbound from their kernel drivers.
    This section is for PMDs which use the UIO or VFIO drivers.
-   See :ref:`bifurcated_driver` section for more details.
+   See :ref:`linux_gsg_bifurcated_driver` section for more details.
 
 .. note::
 
    It is recommended that ``vfio-pci`` be used as the kernel module for DPDK-bound ports in all cases.
-   If an IOMMU is unavailable, the ``vfio-pci`` can be used in :ref:`no-iommu<vfio_noiommu>` mode.
+   If an IOMMU is unavailable, the ``vfio-pci`` can be used in :ref:`no-iommu <linux_gsg_vfio_noiommu>` mode.
    If, for some reason, vfio is unavailable, then UIO-based modules, ``igb_uio`` and ``uio_pci_generic`` may be used.
-   See section :ref:`uio` for details.
+   See section :ref:`linux_gsg_uio` for details.
 
 Most devices require that the hardware to be used by DPDK be unbound from the kernel driver it uses,
 and instead be bound to the ``vfio-pci`` kernel module before the application is run.
@@ -132,10 +132,10 @@ to use IO virtualization (such as Intel\ |reg| VT-d).
    configure the Linux kernel to use IOMMU.
 
 For proper operation of VFIO when running DPDK applications as a non-privileged user, correct permissions should also be set up.
-For more information, please refer to :ref:`Running_Without_Root_Privileges`.
+For more information, please refer to :ref:`linux_gsg_Running_Without_Root_Privileges`.
 
 
-.. _vfio_noiommu:
+.. _linux_gsg_vfio_noiommu:
 
 VFIO no-IOMMU mode
 ~~~~~~~~~~~~~~~~~~
@@ -361,7 +361,7 @@ running on these systems.
 Consult your distributions documentation to make sure that is the case.
 
 
-.. _bifurcated_driver:
+.. _linux_gsg_bifurcated_driver:
 
 Bifurcated Driver
 -----------------
@@ -386,7 +386,7 @@ More about the bifurcated driver can be found in
 NVIDIA `bifurcated PMD
 <https://www.dpdk.org/wp-content/uploads/sites/35/2016/10/Day02-Session04-RonyEfraim-Userspace2016.pdf>`_ presentation.
 
-.. _uio:
+.. _linux_gsg_uio:
 
 UIO
 ---
diff --git a/doc/guides/linux_gsg/sys_reqs.rst b/doc/guides/linux_gsg/sys_reqs.rst
index 52a840fbe9..68c7f3eb8a 100644
--- a/doc/guides/linux_gsg/sys_reqs.rst
+++ b/doc/guides/linux_gsg/sys_reqs.rst
@@ -14,7 +14,7 @@ BIOS Setting Prerequisite on x86
 For the majority of platforms, no special BIOS settings are needed to use basic DPDK functionality.
 However, for additional HPET timer and power management functionality,
 and high performance of small packets, BIOS setting changes may be needed.
-Consult the section on :ref:`Enabling Additional Functionality <Enabling_Additional_Functionality>`
+Consult the section on :ref:`Enabling Additional Functionality <linux_gsg_Enabling_Additional_Functionality>`
 for more information on the required changes.
 
 Compilation of the DPDK
@@ -130,7 +130,7 @@ System Software
     *   PROC_PAGE_MONITOR  support
 
     *   HPET and HPET_MMAP configuration options should also be enabled if HPET  support is required.
-        See the section on :ref:`High Precision Event Timer (HPET) Functionality <High_Precision_Event_Timer>` for more details.
+        See the section on :ref:`High Precision Event Timer (HPET) Functionality <linux_gsg_High_Precision_Event_Timer>` for more details.
 
 .. _linux_gsg_hugepages:
 
diff --git a/doc/guides/nics/ark.rst b/doc/guides/nics/ark.rst
index 6aabde2ed5..1bc73d76d6 100644
--- a/doc/guides/nics/ark.rst
+++ b/doc/guides/nics/ark.rst
@@ -390,7 +390,7 @@ Usage Example
 -------------
 
 Follow instructions available in the document
-:ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>` to launch
+:ref:`compiling and testing a PMD for a NIC <nics_pmd_build_and_test>` to launch
 **testpmd** with Atomic Rules ARK devices managed by librte_net_ark.
 
 Example output:
diff --git a/doc/guides/nics/axgbe.rst b/doc/guides/nics/axgbe.rst
index 961b5c967d..eba3c282a8 100644
--- a/doc/guides/nics/axgbe.rst
+++ b/doc/guides/nics/axgbe.rst
@@ -51,7 +51,7 @@ Now system is ready to run DPDK application.
 Usage Example
 -------------
 
-Refer to the document :ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>`
+Refer to the document :ref:`compiling and testing a PMD for a NIC <nics_pmd_build_and_test>`
 for details.
 
 Example output:
diff --git a/doc/guides/nics/bnx2x.rst b/doc/guides/nics/bnx2x.rst
index fad62d2d52..d64ec1bafb 100644
--- a/doc/guides/nics/bnx2x.rst
+++ b/doc/guides/nics/bnx2x.rst
@@ -103,7 +103,7 @@ enabling debugging options may affect system performance.
 Driver compilation and testing
 ------------------------------
 
-Refer to the document :ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>`
+Refer to the document :ref:`compiling and testing a PMD for a NIC <nics_pmd_build_and_test>`
 for details.
 
 Jumbo: Limitation
@@ -197,7 +197,7 @@ This section provides instructions to configure SR-IOV with Linux OS.
    (Supply ``--log-level="pmd.net.bnx2x.driver",7`` to view informational messages):
 
    Follow instructions available in the document
-   :ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>`
+   :ref:`compiling and testing a PMD for a NIC <nics_pmd_build_and_test>`
    to run testpmd.
 
    Example output:
diff --git a/doc/guides/nics/build_and_test.rst b/doc/guides/nics/build_and_test.rst
index 65264b9dbc..9eaf7c0cef 100644
--- a/doc/guides/nics/build_and_test.rst
+++ b/doc/guides/nics/build_and_test.rst
@@ -1,7 +1,7 @@
 ..  SPDX-License-Identifier: BSD-3-Clause
     Copyright(c) 2017 Cavium, Inc
 
-.. _pmd_build_and_test:
+.. _nics_pmd_build_and_test:
 
 Compiling and testing a PMD for a NIC
 =====================================
diff --git a/doc/guides/nics/cnxk.rst b/doc/guides/nics/cnxk.rst
index 667a876710..8f6364a99c 100644
--- a/doc/guides/nics/cnxk.rst
+++ b/doc/guides/nics/cnxk.rst
@@ -50,13 +50,13 @@ See :doc:`../platform/cnxk` for setup information.
 Driver compilation and testing
 ------------------------------
 
-Refer to the document :ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>`
+Refer to the document :ref:`compiling and testing a PMD for a NIC <nics_pmd_build_and_test>`
 for details.
 
 #. Running testpmd:
 
    Follow instructions available in the document
-   :ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>`
+   :ref:`compiling and testing a PMD for a NIC <nics_pmd_build_and_test>`
    to run testpmd.
 
    Example output:
@@ -739,7 +739,7 @@ Port representor PMD supports following operations:
 Debugging Options
 -----------------
 
-.. _table_cnxk_ethdev_debug_options:
+.. _nics_cnxk_table_ethdev_debug_options:
 
 .. table:: cnxk ethdev debug options
 
diff --git a/doc/guides/nics/cxgbe.rst b/doc/guides/nics/cxgbe.rst
index 487190ff60..f020d56b70 100644
--- a/doc/guides/nics/cxgbe.rst
+++ b/doc/guides/nics/cxgbe.rst
@@ -15,7 +15,7 @@ and has support for the latest Linux operating systems.
 More information can be found at `Chelsio Communications Official Website
 <http://www.chelsio.com>`_.
 
-.. _t5-nics:
+.. _nics_cxgbe_t5_nics:
 
 Supported Chelsio T5 NICs
 -------------------------
@@ -25,7 +25,7 @@ Supported Chelsio T5 NICs
 - 40G NICs: T580-CR, T580-LP-CR, T580-SO-CR
 - Other T5 NICs: T522-CR
 
-.. _t6-nics:
+.. _nics_cxgbe_t6_nics:
 
 Supported Chelsio T6 NICs
 -------------------------
@@ -37,7 +37,7 @@ Supported SR-IOV Chelsio NICs
 -----------------------------
 
 SR-IOV virtual functions are supported on all the Chelsio NICs listed
-in :ref:`t5-nics` and :ref:`t6-nics`.
+in :ref:`nics_cxgbe_t5_nics` and :ref:`nics_cxgbe_t6_nics`.
 
 Features
 --------
@@ -73,7 +73,7 @@ Prerequisites
   repository.
 
   Instructions on how to manually flash the firmware are given in section
-  :ref:`linux-installation` for Linux and section :ref:`freebsd-installation`
+  :ref:`nics_cxgbe_linux_installation` for Linux and section :ref:`nics_cxgbe_freebsd_installation`
   for FreeBSD.
 
 
@@ -319,18 +319,18 @@ CXGBE PF Only Runtime Options
 
      dpdk-testpmd -a 02:00.4,filtermode=0x88,filtermask=0x80 -- -i
 
-.. _driver-compilation:
+.. _nics_cxgbe_driver_compilation:
 
 Driver compilation and testing
 ------------------------------
 
-Refer to the document :ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>`
+Refer to the document :ref:`compiling and testing a PMD for a NIC <nics_pmd_build_and_test>`
 for details.
 
 Linux
 -----
 
-.. _linux-installation:
+.. _nics_cxgbe_linux_installation:
 
 Linux Installation
 ~~~~~~~~~~~~~~~~~~
@@ -434,7 +434,7 @@ devices managed by librte_net_cxgbe in Linux operating system.
 #. Running testpmd
 
    Follow instructions available in the document
-   :ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>`
+   :ref:`compiling and testing a PMD for a NIC <nics_pmd_build_and_test>`
    to run testpmd.
 
    .. note::
@@ -469,7 +469,7 @@ devices managed by librte_net_cxgbe in Linux operating system.
    .. note::
 
       Flow control pause TX/RX is disabled by default and can be enabled via
-      testpmd. Refer section :ref:`flow-control` for more details.
+      testpmd. Refer section :ref:`nics_cxgbe_flow_control` for more details.
 
 Configuring SR-IOV Virtual Functions
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -547,7 +547,7 @@ virtual functions.
 #. Running testpmd
 
    Follow instructions available in the document
-   :ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>`
+   :ref:`compiling and testing a PMD for a NIC <nics_pmd_build_and_test>`
    to bind virtual functions and run testpmd.
 
    Example output:
@@ -582,7 +582,7 @@ virtual functions.
 FreeBSD
 -------
 
-.. _freebsd-installation:
+.. _nics_cxgbe_freebsd_installation:
 
 FreeBSD Installation
 ~~~~~~~~~~~~~~~~~~~~
@@ -652,7 +652,7 @@ This section demonstrates how to launch **testpmd** with Chelsio
 devices managed by librte_net_cxgbe in FreeBSD operating system.
 
 #. Change to DPDK source directory where the target has been compiled in
-   section :ref:`driver-compilation`:
+   section :ref:`nics_cxgbe_driver_compilation`:
 
    .. code-block:: console
 
@@ -779,12 +779,12 @@ devices managed by librte_net_cxgbe in FreeBSD operating system.
 .. note::
 
    Flow control pause TX/RX is disabled by default and can be enabled via
-   testpmd. Refer section :ref:`flow-control` for more details.
+   testpmd. Refer section :ref:`nics_cxgbe_flow_control` for more details.
 
 Sample Application Notes
 ------------------------
 
-.. _flow-control:
+.. _nics_cxgbe_flow_control:
 
 Enable/Disable Flow Control
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/doc/guides/nics/dpaa.rst b/doc/guides/nics/dpaa.rst
index 8cd57b21f3..42de62f014 100644
--- a/doc/guides/nics/dpaa.rst
+++ b/doc/guides/nics/dpaa.rst
@@ -23,7 +23,7 @@ Contents summary
 - DPAA driver architecture overview
 - FMAN configuration tools and library
 
-.. _dpaa_overview:
+.. _nics_dpaa_overview:
 
 DPAA Overview
 ~~~~~~~~~~~~~
@@ -241,13 +241,13 @@ state during application initialization:
 Driver compilation and testing
 ------------------------------
 
-Refer to the document :ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>`
+Refer to the document :ref:`compiling and testing a PMD for a NIC <nics_pmd_build_and_test>`
 for details.
 
 #. Running testpmd:
 
    Follow instructions available in the document
-   :ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>`
+   :ref:`compiling and testing a PMD for a NIC <nics_pmd_build_and_test>`
    to run testpmd.
 
    Example output:
diff --git a/doc/guides/nics/dpaa2.rst b/doc/guides/nics/dpaa2.rst
index 94bf1907df..e1745f77d8 100644
--- a/doc/guides/nics/dpaa2.rst
+++ b/doc/guides/nics/dpaa2.rst
@@ -23,7 +23,7 @@ Contents summary
 - Overview of DPAA2 objects
 - DPAA2 driver architecture overview
 
-.. _dpaa2_overview:
+.. _nics_dpaa2_overview:
 
 DPAA2 Overview
 ~~~~~~~~~~~~~~
@@ -406,7 +406,7 @@ Features of the DPAA2 PMD are:
 - Jumbo frames
 - Link flow control
 - Scattered and gather for TX and RX
-- :ref:`Traffic Management API <dptmapi>`
+- :ref:`Traffic Management API <nics_dpaa2_dptmapi>`
 
 
 Supported DPAA2 SoCs
@@ -432,13 +432,13 @@ See :doc:`../platform/dpaa2` for setup information
 Driver compilation and testing
 ------------------------------
 
-Refer to the document :ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>`
+Refer to the document :ref:`compiling and testing a PMD for a NIC <nics_pmd_build_and_test>`
 for details.
 
 #. Running testpmd:
 
    Follow instructions available in the document
-   :ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>`
+   :ref:`compiling and testing a PMD for a NIC <nics_pmd_build_and_test>`
    to run testpmd.
 
    Example output:
@@ -555,7 +555,7 @@ Other Limitations
 - RSS hash key cannot be modified.
 - RSS RETA cannot be configured.
 
-.. _dptmapi:
+.. _nics_dpaa2_dptmapi:
 
 Traffic Management API
 ----------------------
diff --git a/doc/guides/nics/ena.rst b/doc/guides/nics/ena.rst
index cfc78f1e6a..90f8c92d38 100644
--- a/doc/guides/nics/ena.rst
+++ b/doc/guides/nics/ena.rst
@@ -290,7 +290,7 @@ Usage example
 -------------
 
 Follow instructions available in the document
-:ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>` to launch
+:ref:`compiling and testing a PMD for a NIC <nics_pmd_build_and_test>` to launch
 **testpmd** with Amazon ENA devices managed by librte_net_ena.
 
 Example output:
diff --git a/doc/guides/nics/enetc.rst b/doc/guides/nics/enetc.rst
index e96260f96a..9f7f3360cf 100644
--- a/doc/guides/nics/enetc.rst
+++ b/doc/guides/nics/enetc.rst
@@ -108,5 +108,5 @@ Driver compilation and testing
 ------------------------------
 
 Follow instructions available in the document
-:ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>`
+:ref:`compiling and testing a PMD for a NIC <nics_pmd_build_and_test>`
 to launch **testpmd**
diff --git a/doc/guides/nics/enic.rst b/doc/guides/nics/enic.rst
index 77578b4913..4228a89d37 100644
--- a/doc/guides/nics/enic.rst
+++ b/doc/guides/nics/enic.rst
@@ -521,7 +521,7 @@ The build instructions for the DPDK suite should be followed. By default
 the ENIC PMD library will be built into the DPDK library.
 
 Refer to the document :ref:`compiling and testing a PMD for a NIC
-<pmd_build_and_test>` for details.
+<nics_pmd_build_and_test>` for details.
 
 For configuring and using UIO and VFIO frameworks, please refer to the
 documentation that comes with DPDK suite.
diff --git a/doc/guides/nics/fail_safe.rst b/doc/guides/nics/fail_safe.rst
index c3922b9c39..a264f10b73 100644
--- a/doc/guides/nics/fail_safe.rst
+++ b/doc/guides/nics/fail_safe.rst
@@ -109,7 +109,7 @@ Usage example
 This section shows some example of using **testpmd** with a fail-safe PMD.
 
 #. To build a PMD and configure DPDK, refer to the document
-   :ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>`.
+   :ref:`compiling and testing a PMD for a NIC <nics_pmd_build_and_test>`.
 
 #. Start testpmd. The sub-device ``84:00.0`` should be blocked from normal EAL
    operations to avoid probing it twice, as the PCI bus is in blocklist mode.
diff --git a/doc/guides/nics/hinic.rst b/doc/guides/nics/hinic.rst
index c47737c714..faccdeb16d 100644
--- a/doc/guides/nics/hinic.rst
+++ b/doc/guides/nics/hinic.rst
@@ -50,7 +50,7 @@ Prerequisites
 Driver compilation and testing
 ------------------------------
 
-Refer to the document :ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>`
+Refer to the document :ref:`compiling and testing a PMD for a NIC <nics_pmd_build_and_test>`
 for details.
 
 Limitations or Known issues
diff --git a/doc/guides/nics/hns3.rst b/doc/guides/nics/hns3.rst
index 5e0fdd5bbb..b7bde7bd25 100644
--- a/doc/guides/nics/hns3.rst
+++ b/doc/guides/nics/hns3.rst
@@ -206,7 +206,7 @@ Runtime Configuration
 Driver compilation and testing
 ------------------------------
 
-Refer to the document :ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>`
+Refer to the document :ref:`compiling and testing a PMD for a NIC <nics_pmd_build_and_test>`
 for details.
 
 Sample Application Notes
diff --git a/doc/guides/nics/i40e.rst b/doc/guides/nics/i40e.rst
index 6f9dab73e2..931e5227a6 100644
--- a/doc/guides/nics/i40e.rst
+++ b/doc/guides/nics/i40e.rst
@@ -319,7 +319,7 @@ can use this assumption to do a bit mask using ``ring_size - 1``.
 Driver compilation and testing
 ------------------------------
 
-Refer to the document :ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>`
+Refer to the document :ref:`compiling and testing a PMD for a NIC <nics_pmd_build_and_test>`
 for details.
 
 
@@ -376,7 +376,7 @@ SR-IOV: Prerequisites and sample Application Notes
 #. Running testpmd:
 
    Follow instructions available in the document
-   :ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>`
+   :ref:`compiling and testing a PMD for a NIC <nics_pmd_build_and_test>`
    to run testpmd.
 
    Example output:
@@ -767,7 +767,7 @@ Mirror rule limitation for X722
 
 Due to firmware restriction of X722, the same VSI cannot have more than one mirror rule.
 
-.. _net_i40e_testpmd_commands:
+.. _nics_i40e_testpmd_commands:
 
 Testpmd driver specific commands
 --------------------------------
@@ -995,9 +995,9 @@ The following is an example of running the DPDK ``l3fwd`` sample application to
 server with Intel Xeon processors and Intel Ethernet CNA XL710.
 
 The example scenario is to get best performance with two Intel Ethernet CNA XL710 40GbE ports.
-See :numref:`figure_intel_perf_test_setup` for the performance test setup.
+See :numref:`nics_i40e_figure_intel_perf_test_setup` for the performance test setup.
 
-.. _figure_intel_perf_test_setup:
+.. _nics_i40e_figure_intel_perf_test_setup:
 
 .. figure:: img/intel_perf_test_setup.*
 
diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
index 7056d9709f..0971d85946 100644
--- a/doc/guides/nics/ice.rst
+++ b/doc/guides/nics/ice.rst
@@ -379,7 +379,7 @@ Runtime Configuration
 Driver compilation and testing
 ------------------------------
 
-Refer to the document :ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>`
+Refer to the document :ref:`compiling and testing a PMD for a NIC <nics_pmd_build_and_test>`
 for details.
 
 Features
diff --git a/doc/guides/nics/igc.rst b/doc/guides/nics/igc.rst
index 9790b58102..854303b974 100644
--- a/doc/guides/nics/igc.rst
+++ b/doc/guides/nics/igc.rst
@@ -23,7 +23,7 @@ Supported Chipsets and NICs
 Driver compilation and testing
 ------------------------------
 
-Refer to the document :ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>`
+Refer to the document :ref:`compiling and testing a PMD for a NIC <nics_pmd_build_and_test>`
 for details.
 
 
diff --git a/doc/guides/nics/intel_vf.rst b/doc/guides/nics/intel_vf.rst
index bc600e4b58..4be70b95e0 100644
--- a/doc/guides/nics/intel_vf.rst
+++ b/doc/guides/nics/intel_vf.rst
@@ -24,9 +24,9 @@ SR-IOV Mode Utilization in a DPDK Environment
 The DPDK uses the SR-IOV feature for hardware-based I/O sharing in IOV mode.
 Therefore, it is possible to partition SR-IOV capability on Ethernet controller NIC resources logically and
 expose them to a virtual machine as a separate PCI function called a "Virtual Function".
-Refer to :numref:`figure_single_port_nic`.
+Refer to :numref:`linux_gsg_nics_figure_single_port_nic`.
 
-Therefore, a NIC is logically distributed among multiple virtual machines (as shown in :numref:`figure_single_port_nic`),
+Therefore, a NIC is logically distributed among multiple virtual machines (as shown in :numref:`linux_gsg_nics_figure_single_port_nic`),
 while still having global data in common to share with the Physical Function and other Virtual Functions.
 The DPDK fm10kvf, iavf, igbvf or ixgbevf as a Poll Mode Driver (PMD) serves for the Intel® 82576 Gigabit Ethernet Controller,
 Intel® Ethernet Controller I350 family, Intel® 82599 10 Gigabit Ethernet Controller NIC,
@@ -47,7 +47,7 @@ For more detail on SR-IOV, please refer to the following documents:
 
 *   `Scalable I/O Virtualized Servers <http://www.intel.com/content/www/us/en/virtualization/server-virtualization/scalable-i-o-virtualized-servers-paper.html>`_
 
-.. _figure_single_port_nic:
+.. _linux_gsg_nics_figure_single_port_nic:
 
 .. figure:: img/single_port_nic.*
 
@@ -362,7 +362,7 @@ The expected guest operating systems in a virtualized environment are:
 
 For supported kernel versions, refer to the *DPDK Release Notes*.
 
-.. _intel_vf_kvm:
+.. _linux_gsg_nics_intel_vf_kvm:
 
 Setting Up a KVM Virtual Machine Monitor
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -574,9 +574,9 @@ The setup procedure is as follows:
         can also be used to bind and unbind devices to a virtual machine in Ubuntu.
         If this option is used, step 6 in the instructions provided will be different.
 
-    *   The Virtual Machine Monitor (see :numref:`figure_perf_benchmark`) is equivalent to a Host OS with KVM installed as described in the instructions.
+    *   The Virtual Machine Monitor (see :numref:`linux_gsg_nics_figure_perf_benchmark`) is equivalent to a Host OS with KVM installed as described in the instructions.
 
-.. _figure_perf_benchmark:
+.. _linux_gsg_nics_figure_perf_benchmark:
 
 .. figure:: img/perf_benchmark.*
 
@@ -596,10 +596,10 @@ the DPDK VF PMD performs the same throughput result as a non-VT native environme
 With such host instance fast packet processing, lots of services such as filtering, QoS,
 DPI can be offloaded on the host fast path.
 
-:numref:`figure_fast_pkt_proc` shows the scenario where some VMs directly communicate externally via a VFs,
+:numref:`linux_gsg_nics_figure_fast_pkt_proc` shows the scenario where some VMs directly communicate externally via a VFs,
 while others connect to a virtual switch and share the same uplink bandwidth.
 
-.. _figure_fast_pkt_proc:
+.. _linux_gsg_nics_figure_fast_pkt_proc:
 
 .. figure:: img/fast_pkt_proc.*
 
@@ -615,7 +615,7 @@ So VF-to-VF traffic within the same physical port (VM0<->VM1) have hardware acce
 However, when VF crosses physical ports (VM0<->VM2), there is no such hardware bridge.
 In this case, the DPDK PMD PF driver provides host forwarding between such VMs.
 
-:numref:`figure_inter_vm_comms` shows an example.
+:numref:`linux_gsg_nics_figure_inter_vm_comms` shows an example.
 In this case an update of the MAC address lookup tables in both the NIC and host DPDK application is required.
 
 In the NIC, writing the destination of a MAC address belongs to another cross device VM to the PF specific pool.
@@ -626,7 +626,7 @@ that is, the packet is forwarded to the correct PF pool.
 The SR-IOV NIC switch forwards the packet to a specific VM according to the MAC destination address
 which belongs to the destination VF on the VM.
 
-.. _figure_inter_vm_comms:
+.. _linux_gsg_nics_figure_inter_vm_comms:
 
 .. figure:: img/inter_vm_comms.*
 
@@ -642,7 +642,7 @@ Windows Support
     into Windows VM using SR-IOV pass-through feature.
 
 *   Create a Windows guest on Linux host using KVM hypervisor.
-    Refer to the steps mentioned in the above section: :ref:`intel_vf_kvm`.
+    Refer to the steps mentioned in the above section: :ref:`linux_gsg_nics_intel_vf_kvm`.
 
 *   In the Host machine, download and install the kernel Ethernet driver
     for `i40e <https://downloadcenter.intel.com/download/24411>`_
diff --git a/doc/guides/nics/ipn3ke.rst b/doc/guides/nics/ipn3ke.rst
index 82a0489178..e55c3d865d 100644
--- a/doc/guides/nics/ipn3ke.rst
+++ b/doc/guides/nics/ipn3ke.rst
@@ -61,7 +61,7 @@ Runtime Configuration
 Driver compilation and testing
 ------------------------------
 
-Refer to the document :ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>`
+Refer to the document :ref:`compiling and testing a PMD for a NIC <nics_pmd_build_and_test>`
 for details.
 
 Sample Application Notes
diff --git a/doc/guides/nics/ixgbe.rst b/doc/guides/nics/ixgbe.rst
index a03ec7a7e8..eaf9cb433a 100644
--- a/doc/guides/nics/ixgbe.rst
+++ b/doc/guides/nics/ixgbe.rst
@@ -356,7 +356,7 @@ the VFs which are required.::
 Currently hot-plugging of representor ports is not supported so all required
 representors must be specified on the creation of the PF.
 
-.. _net_ixgbe_testpmd_commands:
+.. _nics_ixgbe_testpmd_commands:
 
 Testpmd driver specific commands
 --------------------------------
diff --git a/doc/guides/nics/mana.rst b/doc/guides/nics/mana.rst
index 0fcab6e2f6..847129d079 100644
--- a/doc/guides/nics/mana.rst
+++ b/doc/guides/nics/mana.rst
@@ -55,7 +55,7 @@ Driver compilation and testing
 ------------------------------
 
 Refer to the document
-:ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>` for details.
+:ref:`compiling and testing a PMD for a NIC <nics_pmd_build_and_test>` for details.
 
 Runtime Configuration
 ---------------------
diff --git a/doc/guides/nics/mlx4.rst b/doc/guides/nics/mlx4.rst
index 364f2c3741..446c3c2b7a 100644
--- a/doc/guides/nics/mlx4.rst
+++ b/doc/guides/nics/mlx4.rst
@@ -221,9 +221,9 @@ Current RDMA core package and Linux kernel (recommended)
     ninja
     ninja install
 
-.. _`RDMA core installation documentation`: https://raw.githubusercontent.com/linux-rdma/rdma-core/master/README.md
+.. _RDMA core installation documentation: https://raw.githubusercontent.com/linux-rdma/rdma-core/master/README.md
 
-.. _OFED_as_a_fallback:
+.. _nics_mlx4_OFED_as_a_fallback:
 
 NVIDIA MLNX_OFED as a fallback
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -231,7 +231,7 @@ NVIDIA MLNX_OFED as a fallback
 - `NVIDIA MLNX_OFED`_ version: **4.4, 4.5, 4.6**.
 - firmware version: **2.42.5000** and above.
 
-.. _`NVIDIA MLNX_OFED`: https://network.nvidia.com/products/infiniband-drivers/linux/mlnx_ofed/
+.. _NVIDIA MLNX_OFED: https://network.nvidia.com/products/infiniband-drivers/linux/mlnx_ofed/
 
 .. note::
 
@@ -267,8 +267,9 @@ Installing NVIDIA MLNX_OFED
 
         connectx_port_config
 
-#. Continue with :ref:`section 2 of the Quick Start Guide <mlx4_QSG_2>`.
+#. Continue with :ref:`section 2 of the Quick Start Guide <nics_mlx4_QSG_2>`.
 
+.. _nics_mlx4_qsg:
 
 Quick Start Guide
 -----------------
@@ -283,9 +284,9 @@ Quick Start Guide
 
         If using NVIDIA MLNX_OFED one can permanently set the port link
         to Ethernet using connectx_port_config tool provided by it.
-        :ref:`OFED_as_a_fallback`:
+        :ref:`nics_mlx4_OFED_as_a_fallback`:
 
-.. _mlx4_QSG_2:
+.. _nics_mlx4_QSG_2:
 
 #. In case of bare metal or hypervisor, configure optimized steering mode
    by adding the following line to ``/etc/modprobe.d/mlx4_core.conf``::
diff --git a/doc/guides/nics/mlx5.rst b/doc/guides/nics/mlx5.rst
index 20056f61d6..ef07f88d13 100644
--- a/doc/guides/nics/mlx5.rst
+++ b/doc/guides/nics/mlx5.rst
@@ -160,7 +160,7 @@ Compilation
 -----------
 
 The dependencies and steps are described in
-the :ref:`common compilation chapter <mlx5_common_compilation>`
+the :ref:`common compilation chapter <platform_mlx5_common_compilation>`
 for all mlx5 drivers.
 
 
@@ -171,7 +171,7 @@ Environment Configuration
 ~~~~~~~~~~~~~~~~~~~~~~~~~
 
 The variables and tools are described in
-the :ref:`common environment configuration chapter <mlx5_common_env>`
+the :ref:`common environment configuration chapter <platform_mlx5_common_env>`
 for all mlx5 drivers.
 
 Firmware Configuration
@@ -181,13 +181,13 @@ The firmware variables required for specific networking features
 are described as part of each feature in this guide.
 
 All the variables and tools are described in
-the :ref:`common firmware configuration chapter <mlx5_firmware_config>`
+the :ref:`common firmware configuration chapter <platform_mlx5_firmware_config>`
 for all mlx5 drivers.
 
 Runtime Configuration
 ~~~~~~~~~~~~~~~~~~~~~
 
-Please refer to :ref:`mlx5 common options <mlx5_common_driver_options>`
+Please refer to :ref:`mlx5 common options <platform_mlx5_common_driver_options>`
 for an additional list of options shared with other mlx5 drivers.
 
 - ``probe_opt_en`` parameter [int]
@@ -546,7 +546,7 @@ for an additional list of options shared with other mlx5 drivers.
 
   This parameter name is deprecated and ignored.
   The new name for this parameter is ``sq_db_nc``.
-  See :ref:`common driver options <mlx5_common_driver_options>`.
+  See :ref:`common driver options <platform_mlx5_common_driver_options>`.
 
 .. _mlx5_tx_pp_param:
 
@@ -860,7 +860,7 @@ Extended statistics can be queried using ``rte_eth_xstats_get()``.
 The extended statistics expose a wider set of counters counted by the device.
 The extended port statistics counts the number of packets
 received or sent successfully by the port.
-As NVIDIA NICs are using a :ref:`bifurcated Linux driver <bifurcated_driver>`,
+As NVIDIA NICs are using a :ref:`bifurcated Linux driver <linux_gsg_bifurcated_driver>`,
 those counters counts also packet received or sent by the Linux kernel.
 
 Finally per-flow statistics can by queried using ``rte_flow_query()``
@@ -1207,12 +1207,12 @@ Supported Operating Systems
 The mlx5 PMD is designed to run on Linux and Windows.
 It requires a kernel driver and some libraries.
 
-The :ref:`Linux prerequisites <mlx5_linux_prerequisites>`
+The :ref:`Linux prerequisites <platform_mlx5_linux_prerequisites>`
 are Linux kernel driver and rdma-core libraries.
 These dependencies are also packaged in MLNX_OFED or MLNX_EN,
 shortened below as "OFED".
 
-The :ref:`Windows prerequisites <mlx5_windows_prerequisites>`
+The :ref:`Windows prerequisites <platform_mlx5_windows_prerequisites>`
 are Windows kernel driver and DevX library.
 These dependencies are packaged in WinOF2.
 
@@ -1407,7 +1407,7 @@ Limitations
 Bifurcated Driver
 ~~~~~~~~~~~~~~~~~
 
-The same device is managed by both :ref:`kernel <bifurcated_driver>` and DPDK drivers.
+The same device is managed by both :ref:`kernel <linux_gsg_bifurcated_driver>` and DPDK drivers.
 
 After enabling the :ref:`isolated mode <flow_isolated_mode>`,
 non-matched packets are routed directly from the hardware to the kernel.
@@ -1609,7 +1609,7 @@ Limitations
 Sub-Function
 ~~~~~~~~~~~~
 
-See :ref:`mlx5_sub_function`.
+See :ref:`platform_mlx5_sub_function`.
 
 A SF netdev supports E-Switch representation offload
 similar to PF and VF representors.
@@ -1673,7 +1673,7 @@ Firmware configuration
 ^^^^^^^^^^^^^^^^^^^^^^
 
 Hairpin Rx queue data may be stored in locked internal device memory
-if enabled by setting these values (see :ref:`mlx5_firmware_config`)::
+if enabled by setting these values (see :ref:`platform_mlx5_firmware_config`)::
 
    HAIRPIN_DATA_BUFFER_LOCK=1
    MEMIC_SIZE_LIMIT=0
@@ -1875,7 +1875,7 @@ Firmware configuration
 ^^^^^^^^^^^^^^^^^^^^^^
 
 Real-time timestamp format is enabled
-by setting this value (see :ref:`mlx5_firmware_config`)::
+by setting this value (see :ref:`platform_mlx5_firmware_config`)::
 
    REAL_TIME_CLOCK_ENABLE=1
 
@@ -2991,7 +2991,7 @@ by setting these values::
    PROG_PARSE_GRAPH=1
 
 Other protocols may require a different firmware configuration.
-See :ref:`mlx5_firmware_config` for more details about the flex parser profile.
+See :ref:`platform_mlx5_firmware_config` for more details about the flex parser profile.
 
 Limitations
 ^^^^^^^^^^^
@@ -3116,7 +3116,7 @@ Limitations
 
 #. Modification of GENEVE network ID is not supported when configured
    ``FLEX_PARSER_PROFILE_ENABLE`` supports GENEVE TLV options.
-   See :ref:`mlx5_firmware_config` for more flex parser information.
+   See :ref:`platform_mlx5_firmware_config` for more flex parser information.
 
 #. Modification of GENEVE TLV option fields
    is supported only for :ref:`HW steering <mlx5_hws>`.
@@ -3295,7 +3295,7 @@ Matching ICMP flow is enabled by setting this value::
    FLEX_PARSER_PROFILE_ENABLE=2
 
 Other protocols may require a different firmware configuration.
-See :ref:`mlx5_firmware_config` for more details about the flex parser profile.
+See :ref:`platform_mlx5_firmware_config` for more details about the flex parser profile.
 
 
 .. _mlx5_ip:
@@ -3321,7 +3321,7 @@ Matching IP-in-IP tunnel flow is enabled by setting this value::
    FLEX_PARSER_PROFILE_ENABLE=0
 
 Other protocols may require a different firmware configuration.
-See :ref:`mlx5_firmware_config` for more details about the flex parser profile.
+See :ref:`platform_mlx5_firmware_config` for more details about the flex parser profile.
 
 Limitations
 ^^^^^^^^^^^
@@ -3639,7 +3639,7 @@ Matching VXLAN-GPE flow is enabled by setting one of these values::
    FLEX_PARSER_PROFILE_ENABLE=2
 
 Other protocols may require a different firmware configuration.
-See :ref:`mlx5_firmware_config` for more details about the flex parser profile.
+See :ref:`platform_mlx5_firmware_config` for more details about the flex parser profile.
 
 The UDP destination port may be changed::
 
@@ -3820,7 +3820,7 @@ with the sync API requires this value::
    FLEX_PARSER_PROFILE_ENABLE=0
 
 Other protocols may require a different firmware configuration.
-See :ref:`mlx5_firmware_config` for more details about the flex parser profile.
+See :ref:`platform_mlx5_firmware_config` for more details about the flex parser profile.
 
 Limitations
 ^^^^^^^^^^^
@@ -3916,7 +3916,7 @@ Matching GTP flow is enabled by setting this value::
    FLEX_PARSER_PROFILE_ENABLE=3
 
 Other protocols may require a different firmware configuration.
-See :ref:`mlx5_firmware_config` for more details about the flex parser profile.
+See :ref:`platform_mlx5_firmware_config` for more details about the flex parser profile.
 
 Limitations
 ^^^^^^^^^^^
@@ -3940,7 +3940,7 @@ Matching MPLS flow is enabled by setting this value::
    FLEX_PARSER_PROFILE_ENABLE=1
 
 Other protocols may require a different firmware configuration.
-See :ref:`mlx5_firmware_config` for more details about the flex parser profile.
+See :ref:`platform_mlx5_firmware_config` for more details about the flex parser profile.
 
 Limitations
 ^^^^^^^^^^^
@@ -4013,7 +4013,7 @@ Matching eCPRI flow is enabled by setting these values::
    PROG_PARSE_GRAPH=1
 
 Other protocols may require a different firmware configuration.
-See :ref:`mlx5_firmware_config` for more details about the flex parser profile.
+See :ref:`platform_mlx5_firmware_config` for more details about the flex parser profile.
 
 
 .. _mlx5_host_shaper:
@@ -4450,7 +4450,7 @@ This command performs:
 
 #. Add two device arguments for context (``cmd_fd``)
    and protection domain (``pd_handle``) to the device identifier.
-   See :ref:`mlx5 driver options <mlx5_common_driver_options>` for more
+   See :ref:`mlx5 driver options <platform_mlx5_common_driver_options>` for more
    information about these device arguments.
 
 #. Call the regular ``port attach`` function with updated identifier.
diff --git a/doc/guides/nics/mvpp2.rst b/doc/guides/nics/mvpp2.rst
index 07be97dfb8..54ffc75f54 100644
--- a/doc/guides/nics/mvpp2.rst
+++ b/doc/guides/nics/mvpp2.rst
@@ -2,7 +2,7 @@
     Copyright(c) 2017 Marvell International Ltd.
     Copyright(c) 2017 Semihalf.
 
-.. _mvpp2_poll_mode_driver:
+.. _nics_mvpp2_poll_mode_driver:
 
 MVPP2 Poll Mode Driver
 ======================
@@ -37,13 +37,13 @@ Features of the MVPP2 PMD are:
 - L4 checksum offload
 - Packet type parsing
 - Basic stats
-- :ref:`Extended stats <extstats>`
+- :ref:`Extended stats <nics_mvpp2_extstats>`
 - RX flow control
 - Scattered TX frames
-- :ref:`QoS <extconf>`
-- :ref:`Flow API <flowapi>`
-- :ref:`Traffic metering and policing <mtrapi>`
-- :ref:`Traffic Management API <tmapi>`
+- :ref:`QoS <nics_mvpp2_extconf>`
+- :ref:`Flow API <nics_mvpp2_flowapi>`
+- :ref:`Traffic metering and policing <nics_mvpp2_mtrapi>`
+- :ref:`Traffic Management API <nics_mvpp2_tmapi>`
 
 Limitations
 -----------
@@ -166,7 +166,7 @@ In order to run testpmd example application following command can be used:
      --burst=128 --txd=2048 --rxd=1024 --rxq=2 --txq=2  --nb-cores=2 \
      -i -a --rss-udp
 
-.. _extstats:
+.. _nics_mvpp2_extstats:
 
 Extended stats
 --------------
@@ -188,7 +188,7 @@ MVPP2 PMD supports the following extended statistics:
 	- ``tx_errors``: number of TX MAC errors
 
 
-.. _extconf:
+.. _nics_mvpp2_extconf:
 
 External Configuration
 ----------------------
@@ -393,7 +393,7 @@ Usage example
    ./dpdk-testpmd --vdev=eth_mvpp2,iface=eth0,iface=eth2,cfg=/home/user/mrvl.conf \
      -l 0-2 -- -i -a --disable-hw-vlan-strip --rxq=3 --txq=3
 
-.. _flowapi:
+.. _nics_mvpp2_flowapi:
 
 Flow API
 --------
@@ -565,7 +565,7 @@ Following limitations need to be taken into account while creating flow rules:
 For additional information about classifier please consult
 ``doc/musdk_cls_user_guide.txt``.
 
-.. _mtrapi:
+.. _nics_mvpp2_mtrapi:
 
 Traffic metering and policing
 -----------------------------
@@ -580,7 +580,7 @@ MVPP2 PMD supports DPDK traffic metering and policing that allows the following:
 
 For an additional description please refer to DPDK :doc:`../prog_guide/ethdev/traffic_metering_and_policing`.
 
-The policer objects defined by this feature can work with the default policer defined via config file as described in :ref:`QoS Support <extconf>`.
+The policer objects defined by this feature can work with the default policer defined via config file as described in :ref:`QoS Support <nics_mvpp2_extconf>`.
 
 Limitations
 ~~~~~~~~~~~
@@ -622,7 +622,7 @@ For a detailed usage description please refer to "Traffic Metering and Policing"
 
 
 
-.. _tmapi:
+.. _nics_mvpp2_tmapi:
 
 Traffic Management API
 ----------------------
diff --git a/doc/guides/nics/netvsc.rst b/doc/guides/nics/netvsc.rst
index 213d6d4745..de2754bf2d 100644
--- a/doc/guides/nics/netvsc.rst
+++ b/doc/guides/nics/netvsc.rst
@@ -60,7 +60,7 @@ store it in a shell variable:
 	DEV_UUID=$(basename $(readlink /sys/class/net/eth1/device))
 
 
-.. _`UUID`: https://en.wikipedia.org/wiki/Universally_unique_identifier
+.. _UUID: https://en.wikipedia.org/wiki/Universally_unique_identifier
 
 There are several possible ways to assign the UIO device driver for a device.
 The easiest way (but only on 4.18 or later)
@@ -71,7 +71,7 @@ the normal kernel device.
 
 	driverctl -b vmbus set-override $DEV_UUID uio_hv_generic
 
-.. _`driverctl Device Driver control utility`: https://gitlab.com/driverctl/driverctl
+.. _driverctl Device Driver control utility: https://gitlab.com/driverctl/driverctl
 
 Any settings done with driverctl are by default persistent and will be reapplied
 on reboot.
diff --git a/doc/guides/nics/nfp.rst b/doc/guides/nics/nfp.rst
index d756d7cc07..b900de8a1d 100644
--- a/doc/guides/nics/nfp.rst
+++ b/doc/guides/nics/nfp.rst
@@ -58,7 +58,7 @@ Driver compilation and testing
 ------------------------------
 
 Refer to the document
-:ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>` for details.
+:ref:`compiling and testing a PMD for a NIC <nics_pmd_build_and_test>` for details.
 
 Using the PF
 ------------
diff --git a/doc/guides/nics/ngbe.rst b/doc/guides/nics/ngbe.rst
index fe9fb1b07d..5fde774deb 100644
--- a/doc/guides/nics/ngbe.rst
+++ b/doc/guides/nics/ngbe.rst
@@ -74,7 +74,7 @@ NGBE PMD provides the following log types available for control:
 Driver compilation and testing
 ------------------------------
 
-Refer to the document :ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>`
+Refer to the document :ref:`compiling and testing a PMD for a NIC <nics_pmd_build_and_test>`
 for details.
 
 
diff --git a/doc/guides/nics/octeontx.rst b/doc/guides/nics/octeontx.rst
index f963eca648..89ec5c800d 100644
--- a/doc/guides/nics/octeontx.rst
+++ b/doc/guides/nics/octeontx.rst
@@ -55,13 +55,13 @@ Configuration
 Driver compilation and testing
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-Refer to the document :ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>`
+Refer to the document :ref:`compiling and testing a PMD for a NIC <nics_pmd_build_and_test>`
 for details.
 
 #. Running testpmd:
 
    Follow instructions available in the document
-   :ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>`
+   :ref:`compiling and testing a PMD for a NIC <nics_pmd_build_and_test>`
    to run testpmd.
 
    Example output:
diff --git a/doc/guides/nics/overview.rst b/doc/guides/nics/overview.rst
index 4553076481..b7a78ab45e 100644
--- a/doc/guides/nics/overview.rst
+++ b/doc/guides/nics/overview.rst
@@ -26,7 +26,7 @@ More details about features can be found in :doc:`features`.
 
 .. rst-class:: widepage
 
-.. _table_net_pmd_features:
+.. _nics_table_net_pmd_features:
 
 .. include:: overview_table.txt
 
diff --git a/doc/guides/nics/pfe.rst b/doc/guides/nics/pfe.rst
index 172ae80984..c2a30c24fc 100644
--- a/doc/guides/nics/pfe.rst
+++ b/doc/guides/nics/pfe.rst
@@ -157,7 +157,7 @@ Driver compilation and testing
 ------------------------------
 
 Follow instructions available in the document
-:ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>`
+:ref:`compiling and testing a PMD for a NIC <nics_pmd_build_and_test>`
 to launch **testpmd**
 
 Additionally, PFE driver needs `--vdev` as an input with value `net_pfe`
diff --git a/doc/guides/nics/qede.rst b/doc/guides/nics/qede.rst
index c067a4c796..2eb1052640 100644
--- a/doc/guides/nics/qede.rst
+++ b/doc/guides/nics/qede.rst
@@ -144,7 +144,7 @@ following error.
 Driver compilation and testing
 ------------------------------
 
-Refer to the document :ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>`
+Refer to the document :ref:`compiling and testing a PMD for a NIC <nics_pmd_build_and_test>`
 for details.
 
 RTE Flow Support
@@ -155,7 +155,7 @@ actions.
 
 Patterns:
 
-.. _table_qede_supported_flow_item_types:
+.. _linux_gsg_nics_table_qede_supported_flow_item_types:
 
 .. table:: Item types
 
@@ -173,7 +173,7 @@ Patterns:
 
 Actions:
 
-.. _table_qede_supported_ingress_action_types:
+.. _linux_gsg_nics_table_qede_supported_ingress_action_types:
 
 .. table:: Ingress action types
 
@@ -265,7 +265,7 @@ This section provides instructions to configure SR-IOV with Linux OS.
    (Supply ``--log-level="pmd.net.qede.driver:info`` to view informational messages):
 
    Refer to the document
-   :ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>` to run
+   :ref:`compiling and testing a PMD for a NIC <nics_pmd_build_and_test>` to run
    ``testpmd`` application.
 
    Example output:
diff --git a/doc/guides/nics/thunderx.rst b/doc/guides/nics/thunderx.rst
index 0b8584e00f..347fbc4497 100644
--- a/doc/guides/nics/thunderx.rst
+++ b/doc/guides/nics/thunderx.rst
@@ -47,7 +47,7 @@ Prerequisites
 Driver compilation and testing
 ------------------------------
 
-Refer to the document :ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>`
+Refer to the document :ref:`compiling and testing a PMD for a NIC <nics_pmd_build_and_test>`
 for details.
 
 Use config/arm/arm64-thunderx-linux-gcc as a meson cross-file when cross-compiling.
@@ -150,7 +150,7 @@ This section provides instructions to configure SR-IOV with Linux OS.
 #. Running testpmd:
 
    Follow instructions available in the document
-   :ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>`
+   :ref:`compiling and testing a PMD for a NIC <nics_pmd_build_and_test>`
    to run testpmd.
 
    Example output:
diff --git a/doc/guides/nics/txgbe.rst b/doc/guides/nics/txgbe.rst
index 93fb592759..0cd3b3e8cd 100644
--- a/doc/guides/nics/txgbe.rst
+++ b/doc/guides/nics/txgbe.rst
@@ -142,7 +142,7 @@ Please note that following ``devargs`` are only set for backplane NICs.
 Driver compilation and testing
 ------------------------------
 
-Refer to the document :ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>`
+Refer to the document :ref:`compiling and testing a PMD for a NIC <nics_pmd_build_and_test>`
 for details.
 
 Sample Application Notes
diff --git a/doc/guides/nics/vdev_netvsc.rst b/doc/guides/nics/vdev_netvsc.rst
index 8dd5981947..46d96c6a11 100644
--- a/doc/guides/nics/vdev_netvsc.rst
+++ b/doc/guides/nics/vdev_netvsc.rst
@@ -5,13 +5,13 @@
 VDEV_NETVSC driver
 ==================
 
+.. _Hyper-V: https://docs.microsoft.com/en-us/windows-hardware/drivers/network/overview-of-hyper-v
+
 The VDEV_NETVSC driver (**librte_net_vdev_netvsc**) provides support for NetVSC
 interfaces and associated SR-IOV virtual function (VF) devices found in
-Linux virtual machines running on Microsoft Hyper-V_ (including Azure)
+Linux virtual machines running on Microsoft `Hyper-V`_ (including Azure)
 platforms.
 
-.. _Hyper-V: https://docs.microsoft.com/en-us/windows-hardware/drivers/network/overview-of-hyper-v
-
 Implementation details
 ----------------------
 
diff --git a/doc/guides/nics/virtio.rst b/doc/guides/nics/virtio.rst
index 588ac41464..228d05c9c7 100644
--- a/doc/guides/nics/virtio.rst
+++ b/doc/guides/nics/virtio.rst
@@ -201,7 +201,7 @@ in-order feature.
 Interrupt mode
 --------------
 
-.. _virtio_interrupt_mode:
+.. _linux_gsg_nics_virtio_interrupt_mode:
 
 There are three kinds of interrupts from a virtio device over PCI bus: config
 interrupt, Rx interrupts, and Tx interrupts. Config interrupt is used for
diff --git a/doc/guides/nics/zxdh.rst b/doc/guides/nics/zxdh.rst
index 47dabde97e..8a2a7c65e6 100644
--- a/doc/guides/nics/zxdh.rst
+++ b/doc/guides/nics/zxdh.rst
@@ -47,7 +47,7 @@ Features of the ZXDH PMD are:
 Driver compilation and testing
 ------------------------------
 
-Refer to the document :ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>`
+Refer to the document :ref:`compiling and testing a PMD for a NIC <nics_pmd_build_and_test>`
 for details.
 
 
diff --git a/doc/guides/platform/cnxk.rst b/doc/guides/platform/cnxk.rst
index 4aa900dd63..ea610a1058 100644
--- a/doc/guides/platform/cnxk.rst
+++ b/doc/guides/platform/cnxk.rst
@@ -23,10 +23,10 @@ Supported OCTEON cnxk SoCs
 Resource Virtualization Unit architecture
 -----------------------------------------
 
-The :numref:`figure_cnxk_resource_virtualization` diagram depicts the
+The :numref:`platform_figure_cnxk_resource_virtualization` diagram depicts the
 RVU architecture and a resource provisioning example.
 
-.. _figure_cnxk_resource_virtualization:
+.. _platform_figure_cnxk_resource_virtualization:
 
 .. figure:: img/cnxk_resource_virtualization.*
 
@@ -41,11 +41,11 @@ Each functional block has multiple local functions (LFs) for
 provisioning to different PCIe devices. RVU supports multiple PCIe SRIOV
 physical functions (PFs) and virtual functions (VFs).
 
-The :numref:`table_cnxk_rvu_dpdk_mapping` shows the various local
+The :numref:`platform_table_cnxk_rvu_dpdk_mapping` shows the various local
 functions (LFs) provided by the RVU and its functional mapping to
 DPDK subsystem.
 
-.. _table_cnxk_rvu_dpdk_mapping:
+.. _platform_table_cnxk_rvu_dpdk_mapping:
 
 .. table:: RVU managed functional blocks and its mapping to DPDK subsystem
 
@@ -94,7 +94,7 @@ handle provisioning/configuration requests sent by any device from any domain.
 The AF driver does not receive or process any data.
 It is only a configuration driver used in control path.
 
-The :numref:`figure_cnxk_resource_virtualization` diagram also shows a
+The :numref:`platform_figure_cnxk_resource_virtualization` diagram also shows a
 resource provisioning example where,
 
 #. PFx and PFx-VF0 bound to Linux netdev driver.
@@ -145,10 +145,10 @@ The primary use case for SDP is to enable the smart NIC use case. Typical usage
 cnxk packet flow
 ----------------------
 
-The :numref:`figure_cnxk_packet_flow_hw_accelerators` diagram depicts
+The :numref:`platform_figure_cnxk_packet_flow_hw_accelerators` diagram depicts
 the packet flow on cnxk SoC in conjunction with use of various HW accelerators.
 
-.. _figure_cnxk_packet_flow_hw_accelerators:
+.. _platform_figure_cnxk_packet_flow_hw_accelerators:
 
 .. figure:: img/cnxk_packet_flow_hw_accelerators.*
 
@@ -248,7 +248,7 @@ compatible board:
 Debugging Options
 -----------------
 
-.. _table_cnxk_common_debug_options:
+.. _platform_table_cnxk_common_debug_options:
 
 .. table:: cnxk common debug options
 
diff --git a/doc/guides/platform/dpaa.rst b/doc/guides/platform/dpaa.rst
index 282a2f45ee..9cdbfad8d6 100644
--- a/doc/guides/platform/dpaa.rst
+++ b/doc/guides/platform/dpaa.rst
@@ -67,7 +67,7 @@ compatible board:
    This tool can be obtained from `NXP (Freescale) Public Git Repository <https://source.codeaurora.org/external/qoriq/qoriq-components/fmc>`_.
 
    This tool needs configuration files which are available in the
-   :ref:`DPDK Extra Scripts <extra_scripts>`, described below for DPDK usages.
+   :ref:`DPDK Extra Scripts <platform_dpaa_extra_scripts>`, described below for DPDK usages.
 
    Note that DPAA PMD can also be executed using images provided
    as part of SDK from NXP. The SDK includes all the above prerequisites
@@ -96,7 +96,7 @@ separately:
   SDK and related information can be obtained from:  `NXP QorIQ SDK  <http://www.nxp.com/products/software-and-tools/run-time-software/linux-sdk/linux-sdk-for-qoriq-processors:SDKLINUX>`_.
 
 
-.. _extra_scripts:
+.. _platform_dpaa_extra_scripts:
 
 - **DPDK Extra Scripts**
 
diff --git a/doc/guides/platform/dpaa2.rst b/doc/guides/platform/dpaa2.rst
index c9ec21334f..6ea5f44361 100644
--- a/doc/guides/platform/dpaa2.rst
+++ b/doc/guides/platform/dpaa2.rst
@@ -94,7 +94,7 @@ separately:
   SDK and related information can be obtained from:  `NXP QorIQ SDK  <http://www.nxp.com/products/software-and-tools/run-time-software/linux-sdk/linux-sdk-for-qoriq-processors:SDKLINUX>`_.
 
 
-.. _extra_scripts:
+.. _platform_dpaa2_extra_scripts:
 
 - **DPDK Extra Scripts**
 
diff --git a/doc/guides/platform/mlx5.rst b/doc/guides/platform/mlx5.rst
index f386980fdd..6cea46ace9 100644
--- a/doc/guides/platform/mlx5.rst
+++ b/doc/guides/platform/mlx5.rst
@@ -41,13 +41,13 @@ which are used to get the best performance:
 - **Direct Rules** manages flow steering at the low-level hardware layer
 
 On Linux, above interfaces are provided by linking with `libibverbs` and `libmlx5`.
-See :ref:`mlx5_linux_prerequisites` for installation.
+See :ref:`platform_mlx5_linux_prerequisites` for installation.
 
 On Windows, DevX is the only requirement from the above list.
-See :ref:`mlx5_windows_prerequisites` for DevX SDK package installation.
+See :ref:`platform_mlx5_windows_prerequisites` for DevX SDK package installation.
 
 
-.. _mlx5_classes:
+.. _platform_mlx5_classes:
 
 Classes
 -------
@@ -82,12 +82,12 @@ Limitations
 - On Windows, only ``eth`` and ``crypto`` are supported.
 
 
-.. _mlx5_common_compilation:
+.. _platform_mlx5_common_compilation:
 
 Compilation Prerequisites
 -------------------------
 
-.. _mlx5_linux_prerequisites:
+.. _platform_mlx5_linux_prerequisites:
 
 Linux Prerequisites
 ~~~~~~~~~~~~~~~~~~~
@@ -216,7 +216,7 @@ to match the kernel modules and libraries they come with.
    Please check the "Tested Platforms" section in the :doc:`../../rel_notes/index`.
 
 
-.. _mlx5_windows_prerequisites:
+.. _platform_mlx5_windows_prerequisites:
 
 Windows Prerequisites
 ~~~~~~~~~~~~~~~~~~~~~
@@ -290,7 +290,7 @@ or::
    meson.exe setup ...
 
 
-.. _mlx5_common_env:
+.. _platform_mlx5_common_env:
 
 Environment Configuration
 -------------------------
@@ -343,7 +343,7 @@ If link type was changed, firmware must be reset as well::
    mlxfwreset -d <mst device> reset
 
 
-.. _mlx5_vf:
+.. _platform_mlx5_vf:
 
 SR-IOV Virtual Function with MLNX_OFED/EN
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
@@ -372,7 +372,7 @@ Then the virtual functions can be instantiated::
    echo [num_vfs] > /sys/class/infiniband/mlx5_0/device/sriov_numvfs
 
 
-.. _mlx5_sub_function:
+.. _platform_mlx5_sub_function:
 
 Sub-Function with MLNX_OFED/EN
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
@@ -424,7 +424,7 @@ that assuming there are no offload flows, each packet that is sent from the VF o
 will be received by the corresponding representor.
 While each packet that is sent to a representor will be received by the VF or SF.
 
-After :ref:`configuring VF <mlx5_vf>`, the device must be unbound::
+After :ref:`configuring VF <platform_mlx5_vf>`, the device must be unbound::
 
    printf "<device pci address>" > /sys/bus/pci/drivers/mlx5_core/unbind
 
@@ -439,7 +439,7 @@ Run as Non-Root
 ^^^^^^^^^^^^^^^
 
 Hugepage and resource limit setup are documented
-in the :ref:`common Linux guide <Running_Without_Root_Privileges>`.
+in the :ref:`common Linux guide <linux_gsg_Running_Without_Root_Privileges>`.
 This PMD can operate without access to physical addresses,
 therefore it does not require ``SYS_ADMIN`` to access ``/proc/self/pagemaps``.
 Note that this requirement may still come from other drivers.
@@ -485,7 +485,7 @@ The keys ``DevxEnabled`` and ``DevxFsRules`` must be set.
 Additional information can be found in the WinOF2 user manual.
 
 
-.. _mlx5_firmware_config:
+.. _platform_mlx5_firmware_config:
 
 Firmware Configuration
 ~~~~~~~~~~~~~~~~~~~~~~
@@ -607,7 +607,7 @@ dyn flex           4
 ========== = = = = = =
 
 
-.. _mlx5_common_driver_options:
+.. _platform_mlx5_common_driver_options:
 
 Device Arguments
 ----------------
@@ -631,7 +631,7 @@ and below are the arguments supported by the common mlx5 layer.
 - ``class`` parameter [string]
 
   Select the classes of the drivers that should probe the device.
-  See :ref:`mlx5_classes` for more explanation and details.
+  See :ref:`platform_mlx5_classes` for more explanation and details.
 
   The default value is ``eth``.
 
diff --git a/doc/guides/platform/octeontx.rst b/doc/guides/platform/octeontx.rst
index b01f51ba4d..fdc66f926d 100644
--- a/doc/guides/platform/octeontx.rst
+++ b/doc/guides/platform/octeontx.rst
@@ -43,7 +43,7 @@ OCTEON TX compatible board:
 
       The PF driver and the required microcode for the crypto offload block will be
       available with OCTEON TX SDK only. So for using crypto offload, follow the steps
-      mentioned in :ref:`setup_platform_using_OCTEON_TX_SDK`.
+      mentioned in :ref:`platform_setup_platform_using_OCTEON_TX_SDK`.
 
 #. **ARM64 Tool Chain**
 
@@ -58,11 +58,11 @@ OCTEON TX compatible board:
 
    As an alternative method, Platform drivers can also be executed using images provided
    as part of SDK from Cavium. The SDK includes all the above prerequisites necessary
-   to bring up a OCTEON TX board. Please refer :ref:`setup_platform_using_OCTEON_TX_SDK`.
+   to bring up a OCTEON TX board. Please refer :ref:`platform_setup_platform_using_OCTEON_TX_SDK`.
 
 #. Follow the DPDK :doc:`../linux_gsg/index` to setup the basic DPDK environment.
 
-.. _setup_platform_using_OCTEON_TX_SDK:
+.. _platform_setup_platform_using_OCTEON_TX_SDK:
 
 Setup Platform Using OCTEON TX SDK
 ----------------------------------
diff --git a/doc/guides/prog_guide/env_abstraction_layer.rst b/doc/guides/prog_guide/env_abstraction_layer.rst
index ce97d8551f..a5877ad2f6 100644
--- a/doc/guides/prog_guide/env_abstraction_layer.rst
+++ b/doc/guides/prog_guide/env_abstraction_layer.rst
@@ -223,7 +223,7 @@ Normally, these options do not need to be changed.
     can later be mapped into that preallocated VA space (if dynamic memory mode
     is enabled), and can optionally be mapped into it at startup.
 
-.. _hugepage_mapping:
+.. _eal_hugepage_mapping:
 
 Hugepage Mapping
 ^^^^^^^^^^^^^^^^
@@ -259,7 +259,7 @@ that share a hugetlbfs mount point.
 Each backing file by default corresponds to one hugepage,
 it is opened and locked for the entire time the hugepage is used.
 This may exhaust the number of open files limit (``NOFILE``).
-See :ref:`segment-file-descriptors` section
+See :ref:`eal_segment_file_descriptors` section
 on how the number of open backing file descriptors can be reduced.
 
 In dynamic memory mode, EAL removes a backing hugepage file
@@ -273,7 +273,7 @@ if ``--huge-unlink`` is given to avoid polluting hugetlbfs.
 However, since it disables multi-process anyway,
 using anonymous mapping (``--in-memory``) is recommended instead.
 
-:ref:`EAL memory allocator <malloc>` relies on hugepages being zero-filled.
+:ref:`EAL memory allocator <eal_malloc>` relies on hugepages being zero-filled.
 Hugepages are cleared by the kernel when a file in hugetlbfs or its part
 is mapped for the first time system-wide
 to prevent data leaks from previous users of the same hugepage.
@@ -302,10 +302,10 @@ DPDK memory manager can provide file descriptors for memory segments,
 which are required for VirtIO with vhost-user backend.
 This can exhaust the number of open files limit (``NOFILE``)
 despite not creating any visible files.
-See :ref:`segment-file-descriptors` section
+See :ref:`eal_segment_file_descriptors` section
 on how the number of open file descriptors used by EAL can be reduced.
 
-.. _segment-file-descriptors:
+.. _eal_segment_file_descriptors:
 
 Segment File Descriptors
 ^^^^^^^^^^^^^^^^^^^^^^^^
@@ -645,7 +645,7 @@ the desired addressing mode when virtual devices that are not directly attached
 To facilitate forcing the IOVA mode to a specific value the EAL command line option ``--iova-mode`` can
 be used to select either physical addressing('pa') or virtual addressing('va').
 
-.. _max_simd_bitwidth:
+.. _eal_max_simd_bitwidth:
 
 
 Max SIMD bitwidth
@@ -764,7 +764,7 @@ There are two kinds of non-EAL pthreads:
 
 For non registered non-EAL pthread (with a LCORE_ID_ANY *_lcore_id*), some libraries will use an alternative unique ID (e.g. TID), some will not be impacted at all, and some will work but with limitations (e.g. timer and mempool libraries).
 
-All these impacts are mentioned in :ref:`known_issue_label` section.
+All these impacts are mentioned in :ref:`eal_known_issue_label` section.
 
 Public Thread API
 ~~~~~~~~~~~~~~~~~
@@ -801,7 +801,7 @@ controlled with tools like taskset (Linux) or cpuset (FreeBSD),
 - with affinity restricted to 2-3, the Control Threads will end up on
   CPU 2 (main lcore, which is the default when no CPU is available).
 
-.. _known_issue_label:
+.. _eal_known_issue_label:
 
 Known Issues
 ~~~~~~~~~~~~
@@ -959,7 +959,7 @@ We expect only 50% of CPU spend on packet IO.
     echo 100000 > pkt_io/cpu.cfs_period_us
     echo  50000 > pkt_io/cpu.cfs_quota_us
 
-.. _malloc:
+.. _eal_malloc:
 
 Malloc
 ------
@@ -1044,7 +1044,7 @@ The key fields of the heap structure and their function are described below
    Example of a malloc heap and malloc elements within the malloc library
 
 
-.. _malloc_elem:
+.. _eal_malloc_elem:
 
 Structure: malloc_elem
 """"""""""""""""""""""
@@ -1125,7 +1125,7 @@ Memory Allocation
 ^^^^^^^^^^^^^^^^^
 
 On EAL initialization, all preallocated memory segments are setup as part of the
-malloc heap. This setup involves placing an :ref:`element header<malloc_elem>`
+malloc heap. This setup involves placing an :ref:`element header <eal_malloc_elem>`
 with ``FREE`` at the start of each virtually contiguous segment of memory.
 The ``FREE`` element is then added to the ``free_list`` for the malloc heap.
 
diff --git a/doc/guides/prog_guide/packet_classif_access_ctrl.rst b/doc/guides/prog_guide/packet_classif_access_ctrl.rst
index e2cd60fb47..c931c88ff9 100644
--- a/doc/guides/prog_guide/packet_classif_access_ctrl.rst
+++ b/doc/guides/prog_guide/packet_classif_access_ctrl.rst
@@ -397,7 +397,7 @@ At startup ACL library determines the highest available classify method for the
 .. note::
 
      Runtime algorithm selection obeys EAL max SIMD bitwidth parameter.
-     For more details about expected behaviour please see :ref:`max_simd_bitwidth`
+     For more details about expected behaviour please see :ref:`eal_max_simd_bitwidth`
 
 Application Programming Interface (API) Usage
 ---------------------------------------------
diff --git a/doc/guides/regexdevs/mlx5.rst b/doc/guides/regexdevs/mlx5.rst
index 814228c5e3..227c1fff6e 100644
--- a/doc/guides/regexdevs/mlx5.rst
+++ b/doc/guides/regexdevs/mlx5.rst
@@ -27,9 +27,9 @@ Features
 Configuration
 -------------
 
-See :ref:`mlx5 common compilation <mlx5_common_compilation>`,
-:ref:`mlx5 firmware configuration <mlx5_firmware_config>`,
-and :ref:`mlx5 common driver options <mlx5_common_driver_options>`.
+See :ref:`mlx5 common compilation <platform_mlx5_common_compilation>`,
+:ref:`mlx5 firmware configuration <platform_mlx5_firmware_config>`,
+and :ref:`mlx5 common driver options <platform_mlx5_common_driver_options>`.
 
 
 Supported NICs
diff --git a/doc/guides/rel_notes/release_17_02.rst b/doc/guides/rel_notes/release_17_02.rst
index 929ba770ae..b1d80001f0 100644
--- a/doc/guides/rel_notes/release_17_02.rst
+++ b/doc/guides/rel_notes/release_17_02.rst
@@ -163,7 +163,7 @@ New Features
   power. It can work on both legacy and modern virtio devices. In this mode,
   each ``rxq`` is mapped with an excluded MSIx interrupt.
 
-  See the :ref:`Virtio Interrupt Mode <virtio_interrupt_mode>` documentation
+  See the :ref:`Virtio Interrupt Mode <linux_gsg_nics_virtio_interrupt_mode>` documentation
   for more information.
 
 * **Added ARMv8 crypto PMD.**
diff --git a/doc/guides/sample_app_ug/compiling.rst b/doc/guides/sample_app_ug/compiling.rst
index adde775d4e..e58c239a94 100644
--- a/doc/guides/sample_app_ug/compiling.rst
+++ b/doc/guides/sample_app_ug/compiling.rst
@@ -29,7 +29,7 @@ Build:
 
 For additional information on compiling see
 :ref:`Compiling DPDK on Linux <linux_gsg_compiling_dpdk>` or
-:ref:`Compiling DPDK on FreeBSD <building_from_source>`.
+:ref:`Compiling DPDK on FreeBSD <freebsd_gsg_building_from_source>`.
 Applications are output to: ``dpdk/<build_dir>/examples``.
 
 
@@ -63,7 +63,7 @@ Using Make
 ~~~~~~~~~~
 
 Pkg-config is used when building an example app standalone using make, please
-see :ref:`building_app_using_installed_dpdk` for more information.
+see :ref:`linux_gsg_building_app_using_installed_dpdk` for more information.
 
 Go to the sample application directory. Unless otherwise specified the sample
 applications are located in ``dpdk/examples/``.
diff --git a/doc/guides/testpmd_app_ug/testpmd_funcs.rst b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
index fefcf5b419..f8f4b68760 100644
--- a/doc/guides/testpmd_app_ug/testpmd_funcs.rst
+++ b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
@@ -5667,5 +5667,5 @@ Some drivers provide specific features.
 See:
 
 - :ref:`net/bonding testpmd driver specific commands <bonding_testpmd_commands>`
-- :ref:`net/i40e testpmd driver specific commands <net_i40e_testpmd_commands>`
-- :ref:`net/ixgbe testpmd driver specific commands <net_ixgbe_testpmd_commands>`
+- :ref:`net/i40e testpmd driver specific commands <nics_i40e_testpmd_commands>`
+- :ref:`net/ixgbe testpmd driver specific commands <nics_ixgbe_testpmd_commands>`
diff --git a/doc/guides/tools/dts.rst b/doc/guides/tools/dts.rst
index 0bb8da3e46..6aad701a9c 100644
--- a/doc/guides/tools/dts.rst
+++ b/doc/guides/tools/dts.rst
@@ -147,7 +147,7 @@ There are two areas that need to be set up on a System Under Test:
 
 #. **User with administrator privileges**
 
-.. _sut_admin_user:
+.. _dts_sut_admin_user:
 
    DTS needs administrator privileges to run DPDK applications (such as testpmd) on the SUT.
    The SUT user must be able run commands in privileged mode without asking for password.
@@ -237,7 +237,7 @@ These need to be set up on a Traffic Generator Node:
 
    Similarly to the System Under Test, traffic generators need administrator privileges
    to be able to use the devices.
-   Refer to the `System Under Test section <sut_admin_user>` for details.
+   Refer to the `System Under Test section <dts_sut_admin_user>` for details.
 
 
 Running DTS
@@ -259,12 +259,12 @@ and must respect the model definitions
 as documented in the DTS API docs under the ``config`` page.
 The root of the configuration is represented by the ``Configuration`` model.
 By default, DTS will try to use the ``dts/test_run.example.yaml``
-:ref:`config file <test_run_configuration_example>`,
+:ref:`config file <dts_test_run_configuration_example>`,
 and ``dts/nodes.example.yaml``
-:ref:`config file <nodes_configuration_example>`
+:ref:`config file <dts_nodes_configuration_example>`
 which are templates that illustrate what can be configured in DTS.
 
-The user must have :ref:`administrator privileges <sut_admin_user>`
+The user must have :ref:`administrator privileges <dts_sut_admin_user>`
 which don't require password authentication.
 
 
@@ -360,11 +360,11 @@ When adding code to the DTS framework, pay attention to the rest of the code
 and try not to divert much from it.
 The :ref:`DTS developer tools <dts_dev_tools>` will issue warnings
 when some of the basics are not met.
-You should also build the :ref:`API documentation <building_api_docs>`
+You should also build the :ref:`API documentation <dts_building_api_docs>`
 to address any issues found during the build.
 
 The API documentation, which is a helpful reference when developing, may be accessed
-in the code directly or generated with the :ref:`API docs build steps <building_api_docs>`.
+in the code directly or generated with the :ref:`API docs build steps <dts_building_api_docs>`.
 When adding new files or modifying the directory structure,
 the corresponding changes must be made to DTS API doc sources in ``doc/api/dts``.
 
@@ -498,7 +498,7 @@ the DTS code check and format script.
 Refer to the script for usage: ``devtools/dts-check-format.sh -h``.
 
 
-.. _building_api_docs:
+.. _dts_building_api_docs:
 
 Building DTS API docs
 ---------------------
@@ -542,7 +542,7 @@ And they both have two network ports which are physically connected to each othe
    This example assumes that you have setup SSH keys in both the system under test
    and traffic generator nodes.
 
-.. _test_run_configuration_example:
+.. _dts_test_run_configuration_example:
 
 ``dts/test_run.example.yaml``
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -551,7 +551,7 @@ And they both have two network ports which are physically connected to each othe
    :language: yaml
    :start-at: # Define
 
-.. _nodes_configuration_example:
+.. _dts_nodes_configuration_example:
 
 
 ``dts/nodes.example.yaml``
diff --git a/doc/guides/vdpadevs/mlx5.rst b/doc/guides/vdpadevs/mlx5.rst
index 6cea1f43e9..204446fdf9 100644
--- a/doc/guides/vdpadevs/mlx5.rst
+++ b/doc/guides/vdpadevs/mlx5.rst
@@ -36,7 +36,7 @@ Prerequisites
 -------------
 
 - NVIDIA MLNX_OFED version: **5.0**
-  See :ref:`mlx5 common prerequisites <mlx5_linux_prerequisites>` for more details.
+  See :ref:`mlx5 common prerequisites <platform_mlx5_linux_prerequisites>` for more details.
 
 Run-time configuration
 ~~~~~~~~~~~~~~~~~~~~~~
@@ -44,7 +44,7 @@ Run-time configuration
 Driver options
 ^^^^^^^^^^^^^^
 
-Please refer to :ref:`mlx5 common options <mlx5_common_driver_options>`
+Please refer to :ref:`mlx5 common options <platform_mlx5_common_driver_options>`
 for an additional list of options shared with other mlx5 drivers.
 
 - ``event_mode`` parameter [int]
-- 
2.51.0

