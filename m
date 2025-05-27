Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53DDC54ED1
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 14:04:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C6AA74028D;
	Tue, 27 May 2025 16:04:56 +0200 (CEST)
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com
 [209.85.160.53]) by mails.dpdk.org (Postfix) with ESMTP id F12FC40144
 for <dev@dpdk.org>; Tue, 27 May 2025 16:04:54 +0200 (CEST)
Received: by mail-oa1-f53.google.com with SMTP id
 586e51a60fabf-2e41064e247so1631144fac.3
 for <dev@dpdk.org>; Tue, 27 May 2025 07:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748354694; x=1748959494; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4hx8jgbB7h+RI+DzDMuejqN4gOu1rQh3XmhyfM6d0fQ=;
 b=RA1PC4jXFvd5LT9CfUE3Hk8wRfNlSszzK4tfkoAl/kK5sbPouUU2no9fhxOFkgUzHs
 UOYmK1APcRpS1NPdvs902Vx7jBnw/2ovmn/AyTDf5486h8IrgmvR/LeMEKb68Yh4uc0z
 DukxiCZfMGdXE6sCpFrdyD0STCGk7H2d4AiZLFiAqiZEa3WF77Q4FveAOzK41jRlAuFp
 wvnisTDzcIEuovpmGV3wsTOq6yc2HDFtdQZOmly81pZpFHrFdzAg3pQJ+b579ojlH1w2
 q/F/AVlzg+KXZZDCZhAHguUeWqZbF68JzhaBRnHw1wAmZWGu5577nVvNX4KCkMUat7l3
 komA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748354694; x=1748959494;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4hx8jgbB7h+RI+DzDMuejqN4gOu1rQh3XmhyfM6d0fQ=;
 b=osNTsndUxE69PCWi7bIeHGISnvEhwj478Pk6qeHSg29oCzAFl07BqoalCIOcvujGRq
 Gd2IfRqUtrYbdL2yFAvlc7cHtCwHDwPKe7p807HXZMBwZk6oqswAEFruQgJCHjFiKk8G
 wvM6GzrlP81Oddt8nCM7iNa5iBfmvpGW16vkba85okBV/0GMFHXiES+h96uGTxhS5gqm
 /kZmHmiIzGkc8fEbsYHRL7TvvbagtAHZWWJLQ19y6IvHOES/bENKlgRS8LnkPci+lHCy
 gpK09Gn+sWsF+dj7mXGoYrR7t97tcaaaaKnhq0CoAmEkg4w4mFcRfxcGcHxyIau65g/r
 RIDA==
X-Gm-Message-State: AOJu0YxzhfaHnsshgDvo418O8dGVLUv74pjNbjzvbFHAGuv6LvrFdnvt
 1hq86fQwaQv3XoLkP9gukAbVzCCW0yDr9sEzG4P0nN3DCh1pdLbuuvWh
X-Gm-Gg: ASbGncsEM5VebLwxYpgS5wM0wOdLMMO4PkQBJWTpTItX95cop6BS+SA8xb8vRApZxHq
 LctWO9m6sMkGTvcY8qJe2R1RWBNlLOfe5uaDQvmggaK1JRdkrB6om6RpRz2HmWoV1qQvz9iLWEn
 pbuB5zu6/2/Zrrb79/Sa7z2spKtwdLU26zcz1sV+td7akBQ64fUv7WPdK+BzPu7KofiQAXt1NV9
 LJCWoR92Yt6xT6nnLqrRxO71wWDGys2TOa4fVyiiVFujNmmtuEghWidrKwI63iKd5rhiwYqTvQI
 RRcy/2eCZmwaxCQIQX9dm46a//Y0ObZt23B+WRGOwCzNn+GQeb14N1lL7xMsWnvwm8nwT4iTJ2Y
 1lbqimWP6FvE=
X-Google-Smtp-Source: AGHT+IH/h6Y2SNKWFJdiNqwMXhmG/c2mCjnrIbHMXgzAPG1O9Y3qJhNyLv+tfll+Q2AiumEyx4Gyyw==
X-Received: by 2002:a05:6871:aa0d:b0:2c8:33ab:e80e with SMTP id
 586e51a60fabf-2e861f043a4mr5759145fac.19.1748354693831; 
 Tue, 27 May 2025 07:04:53 -0700 (PDT)
Received: from localhost.localdomain ([47.189.31.106])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2e3c06b0aeesm5327666fac.18.2025.05.27.07.04.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 07:04:53 -0700 (PDT)
From: Nandini Persad <nandinipersad361@gmail.com>
To: Bruce Richardson <bruce.richardson@intel.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Ciara Loftus <ciara.loftus@intel.com>, Maryam Tahhan <mtahhan@redhat.com>,
 Julien Aube <julien_dpdk@jaube.fr>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>,
 Potnuri Bharat Teja <bharat@chelsio.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, John Daley <johndale@cisco.com>,
 Hyong Youb Kim <hyonkim@cisco.com>, Ian Stokes <ian.stokes@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Matan Azrad <matan@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Liron Himi <lironh@marvell.com>, Long Li <longli@microsoft.com>,
 Wei Hu <weh@microsoft.com>, Devendra Singh Rawat <dsinghrawat@marvell.com>,
 Alok Prasad <palok@marvell.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>,
 Jochen Behrens <jochen.behrens@broadcom.com>,
 Paul Szczepanek <paul.szczepanek@arm.com>, Patrick Robb <probb@iol.unh.edu>
Cc: dev@dpdk.org
Subject: [PATCH] doc: fix anchors namespace in guides
Date: Tue, 27 May 2025 07:04:35 -0700
Message-Id: <20250527140435.21361-1-nandinipersad361@gmail.com>
X-Mailer: git-send-email 2.34.1
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

I modified the anchors names within the guides to have a
a clear prefix so that they don't collide, based on
advice from Thomas.

Signed-off-by: Nandini Persad <nandinipersad361@gmail.com>
---
 doc/guides/freebsd_gsg/build_dpdk.rst          |  8 ++++----
 doc/guides/freebsd_gsg/build_sample_apps.rst   |  6 +++---
 doc/guides/freebsd_gsg/install_from_ports.rst  |  2 +-
 doc/guides/linux_gsg/build_dpdk.rst            |  4 ++--
 .../linux_gsg/cross_build_dpdk_for_arm64.rst   |  4 ++--
 doc/guides/linux_gsg/enable_func.rst           |  6 +++---
 doc/guides/linux_gsg/linux_drivers.rst         |  6 +++---
 doc/guides/nics/af_xdp.rst                     |  6 +++---
 doc/guides/nics/bnx2x.rst                      |  2 +-
 doc/guides/nics/build_and_test.rst             |  2 +-
 doc/guides/nics/cnxk.rst                       |  2 +-
 doc/guides/nics/cxgbe.rst                      | 12 ++++++------
 doc/guides/nics/dpaa.rst                       |  2 +-
 doc/guides/nics/dpaa2.rst                      |  4 ++--
 doc/guides/nics/enic.rst                       |  6 +++---
 doc/guides/nics/i40e.rst                       |  4 ++--
 doc/guides/nics/ice.rst                        |  2 +-
 doc/guides/nics/intel_vf.rst                   | 10 +++++-----
 doc/guides/nics/ixgbe.rst                      |  2 +-
 doc/guides/nics/mlx4.rst                       | 10 +++++-----
 doc/guides/nics/mlx5.rst                       |  4 ++--
 doc/guides/nics/mvpp2.rst                      | 12 ++++++------
 doc/guides/nics/netvsc.rst                     |  4 ++--
 doc/guides/nics/overview.rst                   |  2 +-
 doc/guides/nics/qede.rst                       |  4 ++--
 doc/guides/nics/virtio.rst                     |  4 ++--
 doc/guides/nics/vmxnet3.rst                    |  6 +++---
 doc/guides/platform/cnxk.rst                   |  8 ++++----
 doc/guides/platform/dpaa.rst                   |  2 +-
 doc/guides/platform/dpaa2.rst                  |  2 +-
 doc/guides/platform/mlx5.rst                   | 18 +++++++++---------
 doc/guides/platform/octeontx.rst               |  2 +-
 doc/guides/tools/dts.rst                       | 10 +++++-----
 33 files changed, 89 insertions(+), 89 deletions(-)

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
index 7bdd88e56d..535738617b 100644
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
@@ -96,7 +96,7 @@ Other options, specific to Linux and are not supported under FreeBSD are as foll
 
 The ``-c`` or ``-l`` option is mandatory; the others are optional.
 
-.. _running_non_root:
+.. _freebsd_gsg_running_non_root:
 
 Running DPDK Applications Without Root Privileges
 -------------------------------------------------
diff --git a/doc/guides/freebsd_gsg/install_from_ports.rst b/doc/guides/freebsd_gsg/install_from_ports.rst
index 3c98c46b29..b9e9bc4bac 100644
--- a/doc/guides/freebsd_gsg/install_from_ports.rst
+++ b/doc/guides/freebsd_gsg/install_from_ports.rst
@@ -1,7 +1,7 @@
 ..  SPDX-License-Identifier: BSD-3-Clause
     Copyright(c) 2010-2014 Intel Corporation.
 
-.. _install_from_ports:
+.. _freebsd_gsg_install_from_ports:
 
 Installing DPDK from the Ports Collection
 =========================================
diff --git a/doc/guides/linux_gsg/build_dpdk.rst b/doc/guides/linux_gsg/build_dpdk.rst
index 9c0dd9daf6..5c52fb5136 100644
--- a/doc/guides/linux_gsg/build_dpdk.rst
+++ b/doc/guides/linux_gsg/build_dpdk.rst
@@ -82,7 +82,7 @@ and the last step causing the dynamic loader `ld.so` to update its cache to take
    distributions, `/usr/local/lib` and `/usr/local/lib64` should be added
    to a file in `/etc/ld.so.conf.d/` before running `ldconfig`.
 
-.. _adjusting_build_options:
+.. _linux_gsg_adjusting_build_options:
 
 Adjusting Build Options
 ~~~~~~~~~~~~~~~~~~~~~~~
@@ -177,7 +177,7 @@ Once the build directory has been configured,
 DPDK can be compiled using ``ninja`` as described above.
 
 
-.. _building_app_using_installed_dpdk:
+.. _linux_gsg_building_app_using_installed_dpdk:
 
 Building Applications Using Installed DPDK
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/doc/guides/linux_gsg/cross_build_dpdk_for_arm64.rst b/doc/guides/linux_gsg/cross_build_dpdk_for_arm64.rst
index e4de5c8d18..fd990f9ba9 100644
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
diff --git a/doc/guides/linux_gsg/enable_func.rst b/doc/guides/linux_gsg/enable_func.rst
index 5511640cb8..a2af60e067 100644
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
@@ -157,7 +157,7 @@ Also see
 `CPU isolation example <https://www.suse.com/c/cpu-isolation-practical-example-part-5/>`_
 and `systemd core isolation example <https://www.rcannings.com/systemd-core-isolation/>`_.
 
-.. _High_Precision_Event_Timer:
+.. _linux_gsg_High_Precision_Event_Timer:
 
 High Precision Event Timer (HPET) Functionality
 -----------------------------------------------
diff --git a/doc/guides/linux_gsg/linux_drivers.rst b/doc/guides/linux_gsg/linux_drivers.rst
index 852a60f5c0..5ffcb5f2b6 100644
--- a/doc/guides/linux_gsg/linux_drivers.rst
+++ b/doc/guides/linux_gsg/linux_drivers.rst
@@ -135,7 +135,7 @@ For proper operation of VFIO when running DPDK applications as a non-privileged
 For more information, please refer to :ref:`Running_Without_Root_Privileges`.
 
 
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
diff --git a/doc/guides/nics/af_xdp.rst b/doc/guides/nics/af_xdp.rst
index 8bd17f04ae..5fc4d5bd8c 100644
--- a/doc/guides/nics/af_xdp.rst
+++ b/doc/guides/nics/af_xdp.rst
@@ -157,7 +157,7 @@ use_cni
 The EAL vdev argument ``use_cni`` is used to indicate that the user wishes to
 enable the `AF_XDP Device Plugin for Kubernetes`_ with a DPDK application/pod.
 
-.. _AF_XDP Device Plugin for Kubernetes: https://github.com/redhat-et/afxdp-plugins-for-kubernetes
+.. _nics_AF_XDP Device Plugin for Kubernetes: https://github.com/redhat-et/afxdp-plugins-for-kubernetes
 
 .. code-block:: console
 
@@ -178,7 +178,7 @@ The EAL vdev argument ``use_pinned_map`` is used to indicate that the user wishe
 load a pinned xskmap mounted by `AF_XDP Device Plugin for Kubernetes`_ in the DPDK
 application/pod.
 
-.. _AF_XDP Device Plugin for Kubernetes: https://github.com/redhat-et/afxdp-plugins-for-kubernetes
+.. _nics_AF_XDP Device Plugin for Kubernetes: https://github.com/redhat-et/afxdp-plugins-for-kubernetes
 
 .. code-block:: console
 
@@ -202,7 +202,7 @@ to explicitly tell the AF_XDP PMD where to find either:
 If this argument is not passed alongside the ``use_cni`` or ``use_pinned_map`` arguments then
 the AF_XDP PMD configures it internally to the `AF_XDP Device Plugin for Kubernetes`_.
 
-.. _AF_XDP Device Plugin for Kubernetes: https://github.com/redhat-et/afxdp-plugins-for-kubernetes
+.. _nics_AF_XDP Device Plugin for Kubernetes: https://github.com/redhat-et/afxdp-plugins-for-kubernetes
 
 .. code-block:: console
 
diff --git a/doc/guides/nics/bnx2x.rst b/doc/guides/nics/bnx2x.rst
index c24d32b9ab..c4d292e8f2 100644
--- a/doc/guides/nics/bnx2x.rst
+++ b/doc/guides/nics/bnx2x.rst
@@ -99,7 +99,7 @@ enabling debugging options may affect system performance.
 
   Toggle display of register reads and writes.
 
-.. _bnx2x_driver-compilation:
+.. _nics_bnx2x_driver-compilation:
 
 Driver compilation and testing
 ------------------------------
diff --git a/doc/guides/nics/build_and_test.rst b/doc/guides/nics/build_and_test.rst
index 08310234ac..75f627c89d 100644
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
index 35f95dcc0a..ce15eda698 100644
--- a/doc/guides/nics/cnxk.rst
+++ b/doc/guides/nics/cnxk.rst
@@ -716,7 +716,7 @@ Port representor PMD supports following operations:
 Debugging Options
 -----------------
 
-.. _table_cnxk_ethdev_debug_options:
+.. _nics_table_cnxk_ethdev_debug_options:
 
 .. table:: cnxk ethdev debug options
 
diff --git a/doc/guides/nics/cxgbe.rst b/doc/guides/nics/cxgbe.rst
index 1f0b848ede..cd71e03645 100644
--- a/doc/guides/nics/cxgbe.rst
+++ b/doc/guides/nics/cxgbe.rst
@@ -15,7 +15,7 @@ and has support for the latest Linux operating systems.
 More information can be found at `Chelsio Communications Official Website
 <http://www.chelsio.com>`_.
 
-.. _t5-nics:
+.. _nics_t5-nics:
 
 Supported Chelsio T5 NICs
 -------------------------
@@ -25,7 +25,7 @@ Supported Chelsio T5 NICs
 - 40G NICs: T580-CR, T580-LP-CR, T580-SO-CR
 - Other T5 NICs: T522-CR
 
-.. _t6-nics:
+.. _nics_t6-nics:
 
 Supported Chelsio T6 NICs
 -------------------------
@@ -319,7 +319,7 @@ CXGBE PF Only Runtime Options
 
      dpdk-testpmd -a 02:00.4,filtermode=0x88,filtermask=0x80 -- -i
 
-.. _driver-compilation:
+.. _nics_driver-compilation:
 
 Driver compilation and testing
 ------------------------------
@@ -330,7 +330,7 @@ for details.
 Linux
 -----
 
-.. _linux-installation:
+.. _nics_linux-installation:
 
 Linux Installation
 ~~~~~~~~~~~~~~~~~~
@@ -582,7 +582,7 @@ virtual functions.
 FreeBSD
 -------
 
-.. _freebsd-installation:
+.. _nics_freebsd-installation:
 
 FreeBSD Installation
 ~~~~~~~~~~~~~~~~~~~~
@@ -784,7 +784,7 @@ devices managed by librte_net_cxgbe in FreeBSD operating system.
 Sample Application Notes
 ------------------------
 
-.. _flow-control:
+.. _nics_flow-control:
 
 Enable/Disable Flow Control
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/doc/guides/nics/dpaa.rst b/doc/guides/nics/dpaa.rst
index de3ae96e07..89d6ec0bf0 100644
--- a/doc/guides/nics/dpaa.rst
+++ b/doc/guides/nics/dpaa.rst
@@ -23,7 +23,7 @@ Contents summary
 - DPAA driver architecture overview
 - FMAN configuration tools and library
 
-.. _dpaa_overview:
+.. _nics_dpaa_overview:
 
 DPAA Overview
 ~~~~~~~~~~~~~
diff --git a/doc/guides/nics/dpaa2.rst b/doc/guides/nics/dpaa2.rst
index 3175a8b421..0dc377e467 100644
--- a/doc/guides/nics/dpaa2.rst
+++ b/doc/guides/nics/dpaa2.rst
@@ -23,7 +23,7 @@ Contents summary
 - Overview of DPAA2 objects
 - DPAA2 driver architecture overview
 
-.. _dpaa2_overview:
+.. _nics_dpaa2_overview:
 
 DPAA2 Overview
 ~~~~~~~~~~~~~~
@@ -555,7 +555,7 @@ Other Limitations
 - RSS hash key cannot be modified.
 - RSS RETA cannot be configured.
 
-.. _dptmapi:
+.. _nics_dptmapi:
 
 Traffic Management API
 ----------------------
diff --git a/doc/guides/nics/enic.rst b/doc/guides/nics/enic.rst
index a400bbc4f7..89ac6dbd9d 100644
--- a/doc/guides/nics/enic.rst
+++ b/doc/guides/nics/enic.rst
@@ -219,7 +219,7 @@ There are two known limitations of the current SR-IOV implementation.
    and assign them to VMs as passthrough devices.
 
 
-.. _enic-generic-flow-api:
+.. _nics_enic-generic-flow-api:
 
 Generic Flow API support
 ------------------------
@@ -279,7 +279,7 @@ the (stripped) VLAN header whether stripping is enabled or disabled.
 More features may be added in future firmware and new versions of the VIC.
 Please refer to the release notes.
 
-.. _overlay_offload:
+.. _nics_overlay_offload:
 
 Overlay Offload
 ---------------
@@ -429,7 +429,7 @@ To verify the selected entry size, enable debug logging
     PMD: rte_enic_pmd: Supported CQ entry sizes: 16 32
     PMD: rte_enic_pmd: Using 16B CQ entry size
 
-.. _enic_limitations:
+.. _nics_enic_limitations:
 
 Limitations
 -----------
diff --git a/doc/guides/nics/i40e.rst b/doc/guides/nics/i40e.rst
index ba592d23fe..48c5454bc3 100644
--- a/doc/guides/nics/i40e.rst
+++ b/doc/guides/nics/i40e.rst
@@ -763,7 +763,7 @@ Mirror rule limitation for X722
 
 Due to firmware restriction of X722, the same VSI cannot have more than one mirror rule.
 
-.. _net_i40e_testpmd_commands:
+.. _nics_net_i40e_testpmd_commands:
 
 Testpmd driver specific commands
 --------------------------------
@@ -991,7 +991,7 @@ server with Intel Xeon processors and Intel Ethernet CNA XL710.
 The example scenario is to get best performance with two Intel Ethernet CNA XL710 40GbE ports.
 See :numref:`figure_intel_perf_test_setup` for the performance test setup.
 
-.. _figure_intel_perf_test_setup:
+.. _nics_figure_intel_perf_test_setup:
 
 .. figure:: img/intel_perf_test_setup.*
 
diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
index 77985ae5a2..b94cc8abef 100644
--- a/doc/guides/nics/ice.rst
+++ b/doc/guides/nics/ice.rst
@@ -497,7 +497,7 @@ Additional Options
 
     -a 18:01.0,cap=dcf,acl=off
 
-.. _figure_ice_dcf:
+.. _nics_figure_ice_dcf:
 
 .. figure:: img/ice_dcf.*
 
diff --git a/doc/guides/nics/intel_vf.rst b/doc/guides/nics/intel_vf.rst
index 4780ee7add..3905d0a1ea 100644
--- a/doc/guides/nics/intel_vf.rst
+++ b/doc/guides/nics/intel_vf.rst
@@ -47,7 +47,7 @@ For more detail on SR-IOV, please refer to the following documents:
 
 *   `Scalable I/O Virtualized Servers <http://www.intel.com/content/www/us/en/virtualization/server-virtualization/scalable-i-o-virtualized-servers-paper.html>`_
 
-.. _figure_single_port_nic:
+.. _linux_gsg_nics_figure_single_port_nic:
 
 .. figure:: img/single_port_nic.*
 
@@ -338,7 +338,7 @@ The expected guest operating systems in a virtualized environment are:
 
 For supported kernel versions, refer to the *DPDK Release Notes*.
 
-.. _intel_vf_kvm:
+.. _linux_gsg_nics_intel_vf_kvm:
 
 Setting Up a KVM Virtual Machine Monitor
 ----------------------------------------
@@ -552,7 +552,7 @@ The setup procedure is as follows:
 
     *   The Virtual Machine Monitor (see :numref:`figure_perf_benchmark`) is equivalent to a Host OS with KVM installed as described in the instructions.
 
-.. _figure_perf_benchmark:
+.. _linux_gsg_nics_figure_perf_benchmark:
 
 .. figure:: img/perf_benchmark.*
 
@@ -575,7 +575,7 @@ DPI can be offloaded on the host fast path.
 :numref:`figure_fast_pkt_proc` shows the scenario where some VMs directly communicate externally via a VFs,
 while others connect to a virtual switch and share the same uplink bandwidth.
 
-.. _figure_fast_pkt_proc:
+.. _linux_gsg_nics_figure_fast_pkt_proc:
 
 .. figure:: img/fast_pkt_proc.*
 
@@ -602,7 +602,7 @@ that is, the packet is forwarded to the correct PF pool.
 The SR-IOV NIC switch forwards the packet to a specific VM according to the MAC destination address
 which belongs to the destination VF on the VM.
 
-.. _figure_inter_vm_comms:
+.. _linux_gsg_nics_figure_inter_vm_comms:
 
 .. figure:: img/inter_vm_comms.*
 
diff --git a/doc/guides/nics/ixgbe.rst b/doc/guides/nics/ixgbe.rst
index a03ec7a7e8..c4696ccaa2 100644
--- a/doc/guides/nics/ixgbe.rst
+++ b/doc/guides/nics/ixgbe.rst
@@ -356,7 +356,7 @@ the VFs which are required.::
 Currently hot-plugging of representor ports is not supported so all required
 representors must be specified on the creation of the PF.
 
-.. _net_ixgbe_testpmd_commands:
+.. _nics_net_ixgbe_testpmd_commands:
 
 Testpmd driver specific commands
 --------------------------------
diff --git a/doc/guides/nics/mlx4.rst b/doc/guides/nics/mlx4.rst
index ecc5a32913..7e5b1d471a 100644
--- a/doc/guides/nics/mlx4.rst
+++ b/doc/guides/nics/mlx4.rst
@@ -228,9 +228,9 @@ Current RDMA core package and Linux kernel (recommended)
     ninja
     ninja install
 
-.. _`RDMA core installation documentation`: https://raw.githubusercontent.com/linux-rdma/rdma-core/master/README.md
+.. _nics_`RDMA core installation documentation`: https://raw.githubusercontent.com/linux-rdma/rdma-core/master/README.md
 
-.. _OFED_as_a_fallback:
+.. _nics_OFED_as_a_fallback:
 
 NVIDIA MLNX_OFED as a fallback
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -238,7 +238,7 @@ NVIDIA MLNX_OFED as a fallback
 - `NVIDIA MLNX_OFED`_ version: **4.4, 4.5, 4.6**.
 - firmware version: **2.42.5000** and above.
 
-.. _`NVIDIA MLNX_OFED`: https://network.nvidia.com/products/infiniband-drivers/linux/mlnx_ofed/
+.. _nics_`NVIDIA MLNX_OFED`: https://network.nvidia.com/products/infiniband-drivers/linux/mlnx_ofed/
 
 .. note::
 
@@ -276,7 +276,7 @@ Installing NVIDIA MLNX_OFED
 
 #. Continue with :ref:`section 2 of the Quick Start Guide <QSG_2>`.
 
-.. _qsg:
+.. _nics_qsg:
 
 Quick Start Guide
 -----------------
@@ -293,7 +293,7 @@ Quick Start Guide
         to Ethernet using connectx_port_config tool provided by it.
         :ref:`OFED_as_a_fallback`:
 
-.. _QSG_2:
+.. _nics_QSG_2:
 
 #. In case of bare metal or hypervisor, configure optimized steering mode
    by adding the following line to ``/etc/modprobe.d/mlx4_core.conf``::
diff --git a/doc/guides/nics/mlx5.rst b/doc/guides/nics/mlx5.rst
index 08f3648e99..dbce70c6a6 100644
--- a/doc/guides/nics/mlx5.rst
+++ b/doc/guides/nics/mlx5.rst
@@ -412,7 +412,7 @@ Limitations
      - Supported also with ``FLEX_PARSER_PROFILE_ENABLE`` = 0 for single DW only.
      - Supported for FW version **xx.37.0142** and above.
 
-  .. _geneve_parser_api:
+  .. _nics_geneve_parser_api:
 
   - An API (``rte_pmd_mlx5_create_geneve_tlv_parser``)
     is available for the flexible parser used in HW steering:
@@ -1919,7 +1919,7 @@ There are multiple Rx burst functions with different advantages and limitations.
    |                   || RxQs >= rxqs_min_mprq |         |                 |      |       |
    +-------------------+------------------------+---------+-----------------+------+-------+
 
-.. _mlx5_offloads_support:
+.. _nics_mlx5_offloads_support:
 
 Supported hardware offloads
 ---------------------------
diff --git a/doc/guides/nics/mvpp2.rst b/doc/guides/nics/mvpp2.rst
index 4e42abd70e..2d444a81ed 100644
--- a/doc/guides/nics/mvpp2.rst
+++ b/doc/guides/nics/mvpp2.rst
@@ -2,7 +2,7 @@
     Copyright(c) 2017 Marvell International Ltd.
     Copyright(c) 2017 Semihalf.
 
-.. _mvpp2_poll_mode_driver:
+.. _nics_mvpp2_poll_mode_driver:
 
 MVPP2 Poll Mode Driver
 ======================
@@ -166,7 +166,7 @@ In order to run testpmd example application following command can be used:
      --burst=128 --txd=2048 --rxd=1024 --rxq=2 --txq=2  --nb-cores=2 \
      -i -a --rss-udp
 
-.. _extstats:
+.. _nics_extstats:
 
 Extended stats
 --------------
@@ -188,7 +188,7 @@ MVPP2 PMD supports the following extended statistics:
 	- ``tx_errors``: number of TX MAC errors
 
 
-.. _extconf:
+.. _nics_extconf:
 
 External Configuration
 ----------------------
@@ -393,7 +393,7 @@ Usage example
    ./dpdk-testpmd --vdev=eth_mvpp2,iface=eth0,iface=eth2,cfg=/home/user/mrvl.conf \
      -c 7 -- -i -a --disable-hw-vlan-strip --rxq=3 --txq=3
 
-.. _flowapi:
+.. _nics_flowapi:
 
 Flow API
 --------
@@ -565,7 +565,7 @@ Following limitations need to be taken into account while creating flow rules:
 For additional information about classifier please consult
 ``doc/musdk_cls_user_guide.txt``.
 
-.. _mtrapi:
+.. _nics_mtrapi:
 
 Traffic metering and policing
 -----------------------------
@@ -622,7 +622,7 @@ For a detailed usage description please refer to "Traffic Metering and Policing"
 
 
 
-.. _tmapi:
+.. _nics_tmapi:
 
 Traffic Management API
 ----------------------
diff --git a/doc/guides/nics/netvsc.rst b/doc/guides/nics/netvsc.rst
index 2c0ea6ac9e..c1dac3caa0 100644
--- a/doc/guides/nics/netvsc.rst
+++ b/doc/guides/nics/netvsc.rst
@@ -60,7 +60,7 @@ store it in a shell variable:
 	DEV_UUID=$(basename $(readlink /sys/class/net/eth1/device))
 
 
-.. _`UUID`: https://en.wikipedia.org/wiki/Universally_unique_identifier
+.. _nics_`UUID`: https://en.wikipedia.org/wiki/Universally_unique_identifier
 
 There are several possible ways to assign the UIO device driver for a device.
 The easiest way (but only on 4.18 or later)
@@ -71,7 +71,7 @@ the normal kernel device.
 
 	driverctl -b vmbus set-override $DEV_UUID uio_hv_generic
 
-.. _`driverctl Device Driver control utility`: https://gitlab.com/driverctl/driverctl
+.. _nics_`driverctl Device Driver control utility`: https://gitlab.com/driverctl/driverctl
 
 Any settings done with driverctl are by default persistent and will be reapplied
 on reboot.
diff --git a/doc/guides/nics/overview.rst b/doc/guides/nics/overview.rst
index 4553076481..b7a78ab45e 100644
--- a/doc/guides/nics/overview.rst
+++ b/doc/guides/nics/overview.rst
@@ -26,7 +26,7 @@ More details about features can be found in :doc:`features`.
 
 .. rst-class:: widepage
 
-.. _table_net_pmd_features:
+.. _nics_table_net_pmd_features:
 
 .. include:: overview_table.txt
 
diff --git a/doc/guides/nics/qede.rst b/doc/guides/nics/qede.rst
index 38d5cbb1f3..7bd2a3e518 100644
--- a/doc/guides/nics/qede.rst
+++ b/doc/guides/nics/qede.rst
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
 
diff --git a/doc/guides/nics/virtio.rst b/doc/guides/nics/virtio.rst
index 0615abfaaf..a0ff742b23 100644
--- a/doc/guides/nics/virtio.rst
+++ b/doc/guides/nics/virtio.rst
@@ -93,7 +93,7 @@ The following prerequisites apply:
 Virtio with qemu virtio Back End
 --------------------------------
 
-.. _figure_host_vm_comms_qemu:
+.. _linux_gsg_nics_figure_host_vm_comms_qemu:
 
 .. figure:: img/host_vm_comms_qemu.*
 
@@ -202,7 +202,7 @@ in-order feature.
 Interrupt mode
 --------------
 
-.. _virtio_interrupt_mode:
+.. _linux_gsg_nics_virtio_interrupt_mode:
 
 There are three kinds of interrupts from a virtio device over PCI bus: config
 interrupt, Rx interrupts, and Tx interrupts. Config interrupt is used for
diff --git a/doc/guides/nics/vmxnet3.rst b/doc/guides/nics/vmxnet3.rst
index 3f498b905d..10a83047ee 100644
--- a/doc/guides/nics/vmxnet3.rst
+++ b/doc/guides/nics/vmxnet3.rst
@@ -110,7 +110,7 @@ The following prerequisites apply:
 *   Before starting a VM, a VMXNET3 interface to a VM through VMware vSphere Client must be assigned.
     This is shown in the figure below.
 
-.. _figure_vmxnet3_int:
+.. _nics_figure_vmxnet3_int:
 
 .. figure:: img/vmxnet3_int.*
 
@@ -135,7 +135,7 @@ VMXNET3 with a Native NIC Connected to a vSwitch
 
 This section describes an example setup for Phy-vSwitch-VM-Phy communication.
 
-.. _figure_vswitch_vm:
+.. _nics_figure_vswitch_vm:
 
 .. figure:: img/vswitch_vm.*
 
@@ -162,7 +162,7 @@ VMXNET3 Chaining VMs Connected to a vSwitch
 
 The following figure shows an example VM-to-VM communication over a Phy-VM-vSwitch-VM-Phy communication channel.
 
-.. _figure_vm_vm_comms:
+.. _nics_figure_vm_vm_comms:
 
 .. figure:: img/vm_vm_comms.*
 
diff --git a/doc/guides/platform/cnxk.rst b/doc/guides/platform/cnxk.rst
index 4aa900dd63..a0229883dd 100644
--- a/doc/guides/platform/cnxk.rst
+++ b/doc/guides/platform/cnxk.rst
@@ -26,7 +26,7 @@ Resource Virtualization Unit architecture
 The :numref:`figure_cnxk_resource_virtualization` diagram depicts the
 RVU architecture and a resource provisioning example.
 
-.. _figure_cnxk_resource_virtualization:
+.. _platform_figure_cnxk_resource_virtualization:
 
 .. figure:: img/cnxk_resource_virtualization.*
 
@@ -45,7 +45,7 @@ The :numref:`table_cnxk_rvu_dpdk_mapping` shows the various local
 functions (LFs) provided by the RVU and its functional mapping to
 DPDK subsystem.
 
-.. _table_cnxk_rvu_dpdk_mapping:
+.. _platform_table_cnxk_rvu_dpdk_mapping:
 
 .. table:: RVU managed functional blocks and its mapping to DPDK subsystem
 
@@ -148,7 +148,7 @@ cnxk packet flow
 The :numref:`figure_cnxk_packet_flow_hw_accelerators` diagram depicts
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
index 282a2f45ee..0954117788 100644
--- a/doc/guides/platform/dpaa.rst
+++ b/doc/guides/platform/dpaa.rst
@@ -96,7 +96,7 @@ separately:
   SDK and related information can be obtained from:  `NXP QorIQ SDK  <http://www.nxp.com/products/software-and-tools/run-time-software/linux-sdk/linux-sdk-for-qoriq-processors:SDKLINUX>`_.
 
 
-.. _extra_scripts:
+.. _platform_extra_scripts:
 
 - **DPDK Extra Scripts**
 
diff --git a/doc/guides/platform/dpaa2.rst b/doc/guides/platform/dpaa2.rst
index c9ec21334f..9b311ff398 100644
--- a/doc/guides/platform/dpaa2.rst
+++ b/doc/guides/platform/dpaa2.rst
@@ -94,7 +94,7 @@ separately:
   SDK and related information can be obtained from:  `NXP QorIQ SDK  <http://www.nxp.com/products/software-and-tools/run-time-software/linux-sdk/linux-sdk-for-qoriq-processors:SDKLINUX>`_.
 
 
-.. _extra_scripts:
+.. _platform_extra_scripts:
 
 - **DPDK Extra Scripts**
 
diff --git a/doc/guides/platform/mlx5.rst b/doc/guides/platform/mlx5.rst
index ab3107209a..6cf9c6e509 100644
--- a/doc/guides/platform/mlx5.rst
+++ b/doc/guides/platform/mlx5.rst
@@ -53,7 +53,7 @@ On Windows, DevX is the only requirement from the above list.
 See :ref:`mlx5_windows_prerequisites` for DevX SDK package installation.
 
 
-.. _mlx5_classes:
+.. _platform_mlx5_classes:
 
 Classes
 -------
@@ -88,12 +88,12 @@ Limitations
 - On Windows, only ``eth`` and ``crypto`` are supported.
 
 
-.. _mlx5_common_compilation:
+.. _platform_mlx5_common_compilation:
 
 Compilation Prerequisites
 -------------------------
 
-.. _mlx5_linux_prerequisites:
+.. _platform_mlx5_linux_prerequisites:
 
 Linux Prerequisites
 ~~~~~~~~~~~~~~~~~~~
@@ -223,7 +223,7 @@ to match the kernel modules and libraries they come with.
    Please check the "Tested Platforms" section in the :doc:`../../rel_notes/index`.
 
 
-.. _mlx5_windows_prerequisites:
+.. _platform_mlx5_windows_prerequisites:
 
 Windows Prerequisites
 ~~~~~~~~~~~~~~~~~~~~~
@@ -278,7 +278,7 @@ or::
    set CFLAGS=-I"%DEVX_INC_PATH%" && set LDFLAGS=-L"%DEVX_LIB_PATH%" && meson.exe setup ...
 
 
-.. _mlx5_common_env:
+.. _platform_mlx5_common_env:
 
 Environment Configuration
 -------------------------
@@ -331,7 +331,7 @@ If link type was changed, firmware must be reset as well::
    mlxfwreset -d <mst device> reset
 
 
-.. _mlx5_vf:
+.. _platform_mlx5_vf:
 
 SR-IOV Virtual Function with MLNX_OFED/EN
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
@@ -360,7 +360,7 @@ Then the virtual functions can be instantiated::
    echo [num_vfs] > /sys/class/infiniband/mlx5_0/device/sriov_numvfs
 
 
-.. _mlx5_sub_function:
+.. _platform_mlx5_sub_function:
 
 Sub-Function with MLNX_OFED/EN
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
@@ -471,7 +471,7 @@ The keys ``DevxEnabled`` and ``DevxFsRules`` must be set.
 Additional information can be found in the WinOF2 user manual.
 
 
-.. _mlx5_firmware_config:
+.. _platform_mlx5_firmware_config:
 
 Firmware Configuration
 ~~~~~~~~~~~~~~~~~~~~~~
@@ -574,7 +574,7 @@ Below are some firmware configurations listed.
    MEMIC_SIZE_LIMIT=0
 
 
-.. _mlx5_common_driver_options:
+.. _platform_mlx5_common_driver_options:
 
 Device Arguments
 ----------------
diff --git a/doc/guides/platform/octeontx.rst b/doc/guides/platform/octeontx.rst
index b01f51ba4d..c8a256c565 100644
--- a/doc/guides/platform/octeontx.rst
+++ b/doc/guides/platform/octeontx.rst
@@ -62,7 +62,7 @@ OCTEON TX compatible board:
 
 #. Follow the DPDK :doc:`../linux_gsg/index` to setup the basic DPDK environment.
 
-.. _setup_platform_using_OCTEON_TX_SDK:
+.. _platform_setup_platform_using_OCTEON_TX_SDK:
 
 Setup Platform Using OCTEON TX SDK
 ----------------------------------
diff --git a/doc/guides/tools/dts.rst b/doc/guides/tools/dts.rst
index fcc6d22036..dce50d409d 100644
--- a/doc/guides/tools/dts.rst
+++ b/doc/guides/tools/dts.rst
@@ -147,7 +147,7 @@ There are two areas that need to be set up on a System Under Test:
 
 #. **User with administrator privileges**
 
-.. _sut_admin_user:
+.. _dts_sut_admin_user:
 
    DTS needs administrator privileges to run DPDK applications (such as testpmd) on the SUT.
    The SUT user must be able run commands in privileged mode without asking for password.
@@ -444,7 +444,7 @@ the DTS code check and format script.
 Refer to the script for usage: ``devtools/dts-check-format.sh -h``.
 
 
-.. _building_api_docs:
+.. _dts_building_api_docs:
 
 Building DTS API docs
 ---------------------
@@ -472,7 +472,7 @@ The output is generated in ``build/doc/api/dts/html``.
 
    Make sure to fix any Sphinx warnings when adding or updating docstrings.
 
-.. _configuration_example:
+.. _dts_configuration_example:
 
 Configuration Example
 ---------------------
@@ -489,7 +489,7 @@ And they both have two network ports which are physically connected to each othe
    This example assumes that you have setup SSH keys in both the system under test
    and traffic generator nodes.
 
-.. _test_run_configuration_example:
+.. _dts_test_run_configuration_example:
 
 ``dts/test_run.example.yaml``
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -498,7 +498,7 @@ And they both have two network ports which are physically connected to each othe
    :language: yaml
    :start-at: # Define
 
-.. _nodes_configuration_example:
+.. _dts_nodes_configuration_example:
 
 
 ``dts/nodes.example.yaml``
-- 
2.34.1

