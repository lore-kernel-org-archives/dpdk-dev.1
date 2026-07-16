Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6421BC44501
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Jul 2026 10:38:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CCFF1406B4;
	Thu, 16 Jul 2026 12:38:14 +0200 (CEST)
Received: from flow-a7-smtp.messagingengine.com
 (flow-a7-smtp.messagingengine.com [103.168.172.142])
 by mails.dpdk.org (Postfix) with ESMTP id A1974400D5
 for <dev@dpdk.org>; Thu, 16 Jul 2026 12:38:12 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailflow.phl.internal (Postfix) with ESMTP id 545C313804A0;
 Thu, 16 Jul 2026 06:38:12 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Thu, 16 Jul 2026 06:38:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1784198292; x=
 1784205492; bh=6pv4gQkSTNuKsKH99AmA+r0IoUYpklT+Raz5TwILI7o=; b=Y
 0DnzMw7MDtqOTKg5CIP3TjTF16u9aD7ANFUOHrJ7Vk8yPCEdyHlWo57Jsmk6liIK
 wPoBcSHN1TCqeM/vwzsdgbyuTfxGyBD0afpeh0fgcW7vWCKKUz9rZ62Fwt79Smm3
 9wXTLe2i+KXHRQ305oVv7FqTjq5KGqbf1Qbamqptmi4i2+ConeNqCYtVurOCzshT
 hP2bOqpBmXOeYU2W6IS9i6c7kcdiNs2C14rMaRO1FX8tcf1AbzkNLwh7S9dn/ZhF
 fy4EK+hGO2ce7WqFUnFFI9VyW1vXPBpe07u9Vm+zVtA916dyRfrCluOWDkcj4tbk
 uT9LpKFyicE3PSbxC+fjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1784198292; x=1784205492; bh=6
 pv4gQkSTNuKsKH99AmA+r0IoUYpklT+Raz5TwILI7o=; b=dKvFJ6/6GadGP5T4i
 dWFJQL+0WtCsSFg+2ilzUnMxTQrMrJAOXYSSdTGBDdFKD6flGBTRYZn+HoNXpehF
 2aqQLAuce2VnE2fPiA6qyEIE2wp2MgDO8aw1eTQs0j4ryZN78wF9QiLawV9JTMhP
 qck5KL9u4Rrl2lo7E93Dryu/iCpA5q9ZqDL7Jp4j/4JexdmiG7rC7yeH03S5K+mt
 6Nd+u/KpfZGVMMcjmGBwpGKjKt9qA33WIz+fhsAh93s7HgSIy5ZmMtjQGs1GctoF
 iuhwUK2o9LJlxcVEK79bzTxv6c/EI0OVaA/Y71PKo3g/uY3BgC1b+zEdwSz9X+j5
 l3VQQ==
X-ME-Sender: <xms:k7RYapMJFHHNkHgm-ZMfk1k8qHbdUAQUhEqfPkJOFOVMNsuhkrm79Q>
 <xme:k7RYajgFHy_kl8X-SAxbocHFnHooiYkILLSHzdY0fXpaG8wEESNjYKBsg8IomsFJY
 nQe9FNw4-vCEFM-ymFJnmpSuIxAImK1A_8C4Y9E4uVlXk8AipWKzA>
X-ME-Received: <xmr:k7RYav2lvfKgkscyRHX6_7zEUcStRgGGyk8uMSy6_RYaFSCEjww2rTFmvsTEsCWHEbiTbEZujrsnusqgdfgucJs>
X-ME-Proxy-Cause: dmFkZTFoRWHhNdF7OAHqh0hT6qRcpIVfCmkCFmevDIYOa/U03N/Cqk7MRPt6gx3rqjOJze
 +YPaQCTtaJgruuSq6Wx5MZWbb20KA/p8SJaojiok6or7fdGo6yWODLroMETvtIvuHz1aOm
 YV2AWjscivTb0Ie1RUaZ+yTlWID14zjdL2+GERUaZpqSc616vTBHHf14B5sw/2BU8aF5Ib
 1aY4KlQ8cRXFDue6Z/jw7cP4lGztUP6NITv3KEQMeKsCPlQkSgh/SadAvk2mFwx7A6jxo+
 6ej99u5D+uk88n891JZTJzgPepuvl77+2EJLVXU2XvbGJgw/jbrTX8TCX0jiWmqNBp/klB
 m2WRk9Cpx/7xFJ2Lrt986gvYjIoAcraWkkbO6jCp/BBO7XNUbavZUc11T979NLeEvPeMG6
 K8IrDV3E2070VM9wDMNhvvfD5sDexGIZDZCYjXTKxYBCRS3qcjS/qm5RF3DmFyX+YfrVFO
 mgE21h7zfdC1Bt+8e8EwyAja9JhLvleg+zBkuXDrs5hsidJwElSjFZMTKt55o1aSmGvwJc
 EafOhIe3mHgBbh2gK1RhrJtgAOIiAcCj0RY9SnP59eYrrJDEBGPBWlxiQ46u0Y/lIPkT/r
 tFzMIm5epMs7SuFl9862nNWJSQpANlGBvJMtIL5jcjfOelz2ppABgN+q7UiQ
X-ME-Proxy: <xmx:k7RYalqCT7Z4Lt04gZugg-VNDwoS_wR0pmFzNFEjN1CFVk16z2MRmg>
 <xmx:k7RYas2096zWEW6pFC58RcEWl7Cx2LQWR4iEN9F_h-zk7SWqpuxPsw>
 <xmx:k7RYaiwAMUDXf77pXBNnuPOq56gOGhlvS8HqDi_de0PT_qGyoNEftg>
 <xmx:k7RYarySBngg06GrP6zUt-Hk6UU-4Z__EJnph0gCyb4vzZIFzLScEA>
 <xmx:lLRYapQhiABfpSASIRbKP0iXM7V5M-Z8Hbil9sgKzXcfzWCw2y8LcdzI>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 06:38:00 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Nicolas Chautru <nicolas.chautru@intel.com>,
 Gagandeep Singh <g.singh@nxp.com>, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>,
 Tirthendu Sarkar <tirthendu.sarkar@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Shepard Siegel <shepard.siegel@atomicrules.com>,
 Ed Czeck <ed.czeck@atomicrules.com>,
 John Miller <john.miller@atomicrules.com>,
 Selwin Sebastian <selwin.sebastian@amd.com>,
 Julien Aube <julien_dpdk@jaube.fr>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>,	Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>,
 Potnuri Bharat Teja <bharat@chelsio.com>,
 Shai Brandes <shaibran@amazon.com>,
 Evgeny Schemeilin <evgenys@amazon.com>,	Ron Beider <rbeider@amazon.com>,
 Amit Bernstein <amitbern@amazon.com>, Wajeeh Atrash <atrwajee@amazon.com>,
 Vanshika Shukla <vanshika.shukla@nxp.com>,
 John Daley <johndale@cisco.com>,	Hyong Youb Kim <hyonkim@cisco.com>,
 Gaetan Rivet <grive@u256.net>, Xiaoyun Wang <cloud.wangxiaoyun@huawei.com>,
 Feifei Wang <wangfeifei40@huawei.com>, Xingui Yang <yangxingui@huawei.com>,
 Chengwen Feng <fengchengwen@huawei.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Rosen Xu <rosen.xu@altera.com>,	Long Li <longli@microsoft.com>,
 Wei Hu <weh@microsoft.com>,	Zyta Szpak <zyta@marvell.com>,
 Liron Himi <lironh@marvell.com>, Dimon Zhao <dimon.zhao@nebula-matrix.com>,
 Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>,
 Chaoyong He <chaoyong.he@corigine.com>,
 Jiawen Wu <jiawenwu@trustnetic.com>, Zaiyu Wang <zaiyuwang@trustnetic.com>,
 Devendra Singh Rawat <dsinghrawat@marvell.com>,
 Alok Prasad <palok@marvell.com>,	Jerin Jacob <jerinj@marvell.com>,
 Maciej Czekaj <mczekaj@marvell.com>,	Renyong Wan <wanry@yunsilicon.com>,
 Na Na <nana@yunsilicon.com>,	Rong Qian <qianr@yunsilicon.com>,
 Xiaoxiong Zhang <zhangxx@yunsilicon.com>, Dongwei Xu <xudw@yunsilicon.com>,
 Junlong Wang <wang.junlong1@zte.com.cn>,	Ming Ran <ran.ming@zte.com.cn>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Aman Singh <aman.deep.singh@intel.com>
Subject: [PATCH v3 5/8] doc: link whole-guide references to pages
Date: Thu, 16 Jul 2026 12:31:23 +0200
Message-ID: <20260716103632.711164-6-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260716103632.711164-1-thomas@monjalon.net>
References: <20250527140435.21361-1-nandinipersad361@gmail.com>
 <20260716103632.711164-1-thomas@monjalon.net>
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

Some references point to labels placed at the beginning of a file
only to link to the page as a whole.

Use :doc: links instead.

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 doc/guides/bbdevs/acc100.rst                       |  2 +-
 doc/guides/bbdevs/fpga_lte_fec.rst                 |  2 +-
 doc/guides/bbdevs/la12xx.rst                       |  4 ++--
 doc/guides/bbdevs/vrb1.rst                         |  2 +-
 doc/guides/bbdevs/vrb2.rst                         |  2 +-
 doc/guides/contributing/abi_policy.rst             | 10 +++++-----
 doc/guides/contributing/abi_versioning.rst         |  2 --
 doc/guides/contributing/coding_style.rst           |  2 --
 doc/guides/contributing/documentation.rst          |  4 +---
 doc/guides/contributing/patches.rst                |  6 +++---
 doc/guides/contributing/stable.rst                 |  2 --
 doc/guides/cryptodevs/caam_jr.rst                  |  2 +-
 doc/guides/cryptodevs/dpaa2_sec.rst                |  2 +-
 doc/guides/cryptodevs/dpaa_sec.rst                 |  2 +-
 doc/guides/dmadevs/dpaa.rst                        |  2 +-
 doc/guides/dmadevs/dpaa2.rst                       |  2 +-
 doc/guides/eventdevs/dlb2.rst                      |  3 +--
 doc/guides/eventdevs/dpaa.rst                      |  2 +-
 doc/guides/eventdevs/dpaa2.rst                     |  2 +-
 doc/guides/freebsd_gsg/build_dpdk.rst              |  2 --
 doc/guides/freebsd_gsg/build_sample_apps.rst       |  2 --
 doc/guides/freebsd_gsg/index.rst                   |  2 --
 doc/guides/freebsd_gsg/install_from_ports.rst      |  6 ++----
 doc/guides/freebsd_gsg/intro.rst                   |  2 +-
 doc/guides/howto/virtio_user_as_exception_path.rst |  2 +-
 doc/guides/linux_gsg/build_dpdk.rst                |  2 --
 doc/guides/linux_gsg/build_sample_apps.rst         |  2 +-
 doc/guides/linux_gsg/enable_func.rst               |  2 --
 doc/guides/linux_gsg/index.rst                     |  2 --
 doc/guides/linux_gsg/linux_drivers.rst             |  2 --
 doc/guides/linux_gsg/nic_perf_intel_platform.rst   |  2 +-
 doc/guides/linux_gsg/sys_reqs.rst                  |  3 +--
 doc/guides/nics/ark.rst                            |  6 ++----
 doc/guides/nics/axgbe.rst                          |  6 ++----
 doc/guides/nics/bnx2x.rst                          |  7 ++-----
 doc/guides/nics/build_and_test.rst                 |  9 +++------
 doc/guides/nics/cnxk.rst                           |  7 ++-----
 doc/guides/nics/cxgbe.rst                          |  6 +++---
 doc/guides/nics/dpaa.rst                           |  9 +++------
 doc/guides/nics/dpaa2.rst                          |  9 +++------
 doc/guides/nics/ena.rst                            |  7 +++----
 doc/guides/nics/enetc.rst                          |  4 +---
 doc/guides/nics/enetc4.rst                         |  4 +---
 doc/guides/nics/enic.rst                           |  3 +--
 doc/guides/nics/fail_safe.rst                      |  3 +--
 doc/guides/nics/hinic.rst                          |  5 ++---
 doc/guides/nics/hinic3.rst                         |  6 ++----
 doc/guides/nics/hns3.rst                           |  6 ++----
 doc/guides/nics/i40e.rst                           |  9 +++------
 doc/guides/nics/ice.rst                            |  5 ++---
 doc/guides/nics/igc.rst                            |  3 +--
 doc/guides/nics/ipn3ke.rst                         |  5 ++---
 doc/guides/nics/mana.rst                           |  3 +--
 doc/guides/nics/mvneta.rst                         |  3 +--
 doc/guides/nics/mvpp2.rst                          |  3 +--
 doc/guides/nics/nbl.rst                            |  3 +--
 doc/guides/nics/nfp.rst                            |  3 +--
 doc/guides/nics/ngbe.rst                           |  5 ++---
 doc/guides/nics/octeontx.rst                       |  7 ++-----
 doc/guides/nics/pfe.rst                            |  4 +---
 doc/guides/nics/qede.rst                           |  7 ++-----
 doc/guides/nics/thunderx.rst                       |  9 +++------
 doc/guides/nics/txgbe.rst                          |  5 ++---
 doc/guides/nics/xsc.rst                            |  3 +--
 doc/guides/nics/zxdh.rst                           |  3 +--
 doc/guides/platform/dpaa.rst                       |  3 +--
 doc/guides/platform/dpaa2.rst                      |  3 +--
 doc/guides/prog_guide/asan.rst                     |  2 +-
 doc/guides/rawdevs/dpaa2_cmdif.rst                 |  2 +-
 doc/guides/sample_app_ug/compiling.rst             |  4 ++--
 doc/guides/sample_app_ug/server_node_efd.rst       |  4 ++--
 doc/guides/testpmd_app_ug/index.rst                |  2 --
 doc/guides/testpmd_app_ug/run_app.rst              |  2 +-
 doc/guides/testpmd_app_ug/testpmd_funcs.rst        |  2 --
 doc/guides/tools/testbbdev.rst                     |  2 --
 75 files changed, 99 insertions(+), 190 deletions(-)

diff --git a/doc/guides/bbdevs/acc100.rst b/doc/guides/bbdevs/acc100.rst
index 253ed3e81f..985fbb4d24 100644
--- a/doc/guides/bbdevs/acc100.rst
+++ b/doc/guides/bbdevs/acc100.rst
@@ -126,7 +126,7 @@ BBDEV provides a test application, ``test-bbdev.py`` and range of test data for
 the functionality of the device, depending on the device's capabilities.
 
 For more details on how to use the test application,
-see :ref:`test_bbdev_application`.
+see :doc:`/tools/testbbdev`.
 
 
 Test Vectors
diff --git a/doc/guides/bbdevs/fpga_lte_fec.rst b/doc/guides/bbdevs/fpga_lte_fec.rst
index b85112dae4..74151cbef9 100644
--- a/doc/guides/bbdevs/fpga_lte_fec.rst
+++ b/doc/guides/bbdevs/fpga_lte_fec.rst
@@ -166,7 +166,7 @@ BBDEV provides a test application, ``test-bbdev.py`` and range of test data for
 the functionality of the device, depending on the device's capabilities.
 
 For more details on how to use the test application,
-see :ref:`test_bbdev_application`.
+see :doc:`/tools/testbbdev`.
 
 Test Vectors
 ~~~~~~~~~~~~
diff --git a/doc/guides/bbdevs/la12xx.rst b/doc/guides/bbdevs/la12xx.rst
index 9df4a39725..b2224cc90b 100644
--- a/doc/guides/bbdevs/la12xx.rst
+++ b/doc/guides/bbdevs/la12xx.rst
@@ -56,7 +56,7 @@ Currently supported by DPDK:
 - NXP LA1224 BSP **1.0+**.
 - NXP LA1224 PCIe Modem card connected to ARM host.
 
-- Follow the DPDK :ref:`Getting Started Guide for Linux <linux_gsg>` to setup the basic DPDK environment.
+- Follow the DPDK :doc:`/linux_gsg/index` to setup the basic DPDK environment.
 
 * Use dev arg option ``modem=0`` to identify the modem instance for a given
   device. This is required only if more than 1 modem cards are attached to host.
@@ -86,7 +86,7 @@ BBDEV provides a test application, ``test-bbdev.py`` and range of test data for
 the functionality of the device, depending on the device's capabilities.
 
 For more details on how to use the test application,
-see :ref:`test_bbdev_application`.
+see :doc:`/tools/testbbdev`.
 
 
 Test Vectors
diff --git a/doc/guides/bbdevs/vrb1.rst b/doc/guides/bbdevs/vrb1.rst
index 134dc246e7..e16d6b9dbe 100644
--- a/doc/guides/bbdevs/vrb1.rst
+++ b/doc/guides/bbdevs/vrb1.rst
@@ -134,7 +134,7 @@ BBDEV provides a test application, ``test-bbdev.py`` and range of test data for
 the functionality of the device, depending on the device's capabilities.
 
 For more details on how to use the test application,
-see :ref:`test_bbdev_application`.
+see :doc:`/tools/testbbdev`.
 
 
 Test Vectors
diff --git a/doc/guides/bbdevs/vrb2.rst b/doc/guides/bbdevs/vrb2.rst
index 4420780452..3a9ae1bf82 100644
--- a/doc/guides/bbdevs/vrb2.rst
+++ b/doc/guides/bbdevs/vrb2.rst
@@ -148,7 +148,7 @@ BBDEV provides a test application, ``test-bbdev.py`` and range of test data for
 the functionality of the device, depending on the device's capabilities.
 
 For more details on how to use the test application,
-see :ref:`test_bbdev_application`.
+see :doc:`/tools/testbbdev`.
 
 
 Test Vectors
diff --git a/doc/guides/contributing/abi_policy.rst b/doc/guides/contributing/abi_policy.rst
index 09e72ef3aa..ee7775c1ec 100644
--- a/doc/guides/contributing/abi_policy.rst
+++ b/doc/guides/contributing/abi_policy.rst
@@ -17,13 +17,13 @@ General Guidelines
    with the major ABI version is mandatory in subsequent releases until a
    :ref:`new major ABI version <new_abi_version>` is declared.
 #. Major ABI versions are usually but not always declared aligned with a
-   :ref:`LTS release <stable_lts_releases>`.
+   :doc:`LTS release <stable>`.
 #. The ABI version is managed at a project level in DPDK, and is reflected in
    all non-experimental :ref:`library's soname <what_is_soname>`.
 #. The ABI should be preserved and not changed lightly. ABI changes must follow
    the outlined :ref:`deprecation process <abi_changes>`.
-#. The addition of symbols is generally not problematic. The modification of
-   symbols is managed with :ref:`ABI Versioning <abi_versioning>`.
+#. The addition of symbols is generally not problematic.
+   The modification of symbols is managed with :doc:`abi_versioning`.
 #. The removal of symbols is considered an :ref:`ABI breakage <abi_breakages>`,
    once approved these will form part of the next ABI version.
 #. Libraries or APIs marked as :ref:`experimental <experimental_apis>`
@@ -143,7 +143,7 @@ The requirements for changing the ABI are:
      CPU vendors, end-users, etc.
 
 #. Backward compatibility with the major ABI version must be maintained through
-   :ref:`abi_versioning`, with :ref:`forward-only <forward-only>` compatibility
+   :doc:`abi_versioning`, with :ref:`forward-only <forward-only>` compatibility
    offered for any ABI changes that are indicated to be part of the next ABI
    version.
 
@@ -225,7 +225,7 @@ declarations of major ABI versions.
 
 * DPDK 21.02 release defines a new function ``rte_foo(uint8_t bar)``.
   This is not a problem as long as the symbol ``rte_foo@DPDK_21`` is
-  preserved through :ref:`abi_versioning`.
+  preserved through :doc:`abi_versioning`.
 
   - The new function may be marked with the ``__rte_experimental`` tag for a
     number of releases, as described in the section :ref:`experimental_apis`.
diff --git a/doc/guides/contributing/abi_versioning.rst b/doc/guides/contributing/abi_versioning.rst
index d81b9aeea6..933abcba57 100644
--- a/doc/guides/contributing/abi_versioning.rst
+++ b/doc/guides/contributing/abi_versioning.rst
@@ -1,8 +1,6 @@
 ..  SPDX-License-Identifier: BSD-3-Clause
     Copyright 2018 The DPDK contributors
 
-.. _abi_versioning:
-
 ABI Versioning
 ==============
 
diff --git a/doc/guides/contributing/coding_style.rst b/doc/guides/contributing/coding_style.rst
index d6219cb6af..d5acbd3b97 100644
--- a/doc/guides/contributing/coding_style.rst
+++ b/doc/guides/contributing/coding_style.rst
@@ -1,8 +1,6 @@
 ..  SPDX-License-Identifier: BSD-3-Clause
     Copyright 2018 The DPDK contributors
 
-.. _coding_style:
-
 DPDK Coding Style
 =================
 
diff --git a/doc/guides/contributing/documentation.rst b/doc/guides/contributing/documentation.rst
index 8cca859c73..41cbd03a4f 100644
--- a/doc/guides/contributing/documentation.rst
+++ b/doc/guides/contributing/documentation.rst
@@ -1,8 +1,6 @@
 ..  SPDX-License-Identifier: BSD-3-Clause
     Copyright 2018 The DPDK contributors
 
-.. _doc_guidelines:
-
 DPDK Documentation Guidelines
 =============================
 
@@ -685,7 +683,7 @@ The following are some guidelines for use of Doxygen in the DPDK API documentati
      }
 
   Note: postfix comments should be aligned with spaces not tabs in accordance
-  with the :ref:`coding_style`.
+  with the :doc:`coding_style`.
 
 * If a single comment type can't be used, due to line length limitations then
   prefix comments should be preferred.
diff --git a/doc/guides/contributing/patches.rst b/doc/guides/contributing/patches.rst
index 53cd20ff9c..0ffa447af1 100644
--- a/doc/guides/contributing/patches.rst
+++ b/doc/guides/contributing/patches.rst
@@ -140,7 +140,7 @@ Make your Changes
 
 Make your planned changes in the cloned ``dpdk`` repo. Here are some guidelines and requirements:
 
-* Follow the :ref:`coding_style` guidelines.
+* Follow the :doc:`coding_style` guidelines.
 
 * If you are a new contributor, or if your mail address changed,
   you may update the ``.mailmap`` file.
@@ -161,7 +161,7 @@ Make your planned changes in the cloned ``dpdk`` repo. Here are some guidelines
   * For other PMDs and more info, refer to the ``MAINTAINERS`` file.
 
 * New external functions should be exported.
-  See the :doc:`ABI policy <abi_policy>` and :ref:`ABI versioning <abi_versioning>`
+  See the :doc:`ABI policy <abi_policy>` and :doc:`abi_versioning`
   guides.
 
 * Any new API function should be used in ``/app`` test directory.
@@ -179,7 +179,7 @@ Make your planned changes in the cloned ``dpdk`` repo. Here are some guidelines
 * Add tests to the ``app/test`` unit test framework where possible.
 
 * Add documentation, if relevant, in the form of Doxygen comments or a User Guide in RST format.
-  See the :ref:`Documentation Guidelines <doc_guidelines>`.
+  See the :doc:`documentation`.
 
 * Code and related documentation must be updated atomically in the same patch.
 
diff --git a/doc/guides/contributing/stable.rst b/doc/guides/contributing/stable.rst
index 808e7fa779..9a59a95ec7 100644
--- a/doc/guides/contributing/stable.rst
+++ b/doc/guides/contributing/stable.rst
@@ -1,8 +1,6 @@
 ..  SPDX-License-Identifier: BSD-3-Clause
     Copyright 2018 The DPDK contributors
 
-.. _stable_lts_releases:
-
 DPDK Stable Releases and Long Term Support
 ==========================================
 
diff --git a/doc/guides/cryptodevs/caam_jr.rst b/doc/guides/cryptodevs/caam_jr.rst
index ac1a26c5e6..422b697323 100644
--- a/doc/guides/cryptodevs/caam_jr.rst
+++ b/doc/guides/cryptodevs/caam_jr.rst
@@ -107,7 +107,7 @@ Currently supported by DPDK:
 * NXP SDK **18.09+**.
 * Supported architectures:  **arm64 LE**.
 
-* Follow the DPDK :ref:`Getting Started Guide for Linux <linux_gsg>` to setup the basic DPDK environment.
+* Follow the DPDK :doc:`/linux_gsg/index` to setup the basic DPDK environment.
 
 
 Enabling logs
diff --git a/doc/guides/cryptodevs/dpaa2_sec.rst b/doc/guides/cryptodevs/dpaa2_sec.rst
index 209f56305c..f95c6282bb 100644
--- a/doc/guides/cryptodevs/dpaa2_sec.rst
+++ b/doc/guides/cryptodevs/dpaa2_sec.rst
@@ -163,7 +163,7 @@ The following dependencies are not part of DPDK and must be installed separately
 
 See :doc:`/platform/dpaa2` for setup information
 
-- Follow the DPDK :ref:`Getting Started Guide for Linux <linux_gsg>` to setup the basic DPDK environment.
+- Follow the DPDK :doc:`/linux_gsg/index` to setup the basic DPDK environment.
 
 
 Enabling logs
diff --git a/doc/guides/cryptodevs/dpaa_sec.rst b/doc/guides/cryptodevs/dpaa_sec.rst
index 5ca0d90c41..eae88a8f85 100644
--- a/doc/guides/cryptodevs/dpaa_sec.rst
+++ b/doc/guides/cryptodevs/dpaa_sec.rst
@@ -109,7 +109,7 @@ DPAA_SEC driver has similar pre-requisites as described in :ref:`dpaa_overview`.
 See :doc:`/platform/dpaa` for setup information
 
 
-- Follow the DPDK :ref:`Getting Started Guide for Linux <linux_gsg>` to setup the basic DPDK environment.
+- Follow the DPDK :doc:`/linux_gsg/index` to setup the basic DPDK environment.
 
 
 Enabling logs
diff --git a/doc/guides/dmadevs/dpaa.rst b/doc/guides/dmadevs/dpaa.rst
index 4056173fc1..01104d7f1e 100644
--- a/doc/guides/dmadevs/dpaa.rst
+++ b/doc/guides/dmadevs/dpaa.rst
@@ -29,7 +29,7 @@ Prerequisites
 
 See :doc:`/platform/dpaa` for setup information
 
-- Follow the DPDK :ref:`Getting Started Guide for Linux <linux_gsg>` to setup the basic DPDK environment.
+- Follow the DPDK :doc:`/linux_gsg/index` to setup the basic DPDK environment.
 
 .. note::
 
diff --git a/doc/guides/dmadevs/dpaa2.rst b/doc/guides/dmadevs/dpaa2.rst
index 3d75b5ed48..c2babefba6 100644
--- a/doc/guides/dmadevs/dpaa2.rst
+++ b/doc/guides/dmadevs/dpaa2.rst
@@ -36,7 +36,7 @@ Prerequisites
 
 See :doc:`/platform/dpaa2` for setup information
 
-- Follow the DPDK :ref:`Getting Started Guide for Linux <linux_gsg>` to setup the basic DPDK environment.
+- Follow the DPDK :doc:`/linux_gsg/index` to setup the basic DPDK environment.
 
 .. note::
 
diff --git a/doc/guides/eventdevs/dlb2.rst b/doc/guides/eventdevs/dlb2.rst
index f784204b20..06841ba312 100644
--- a/doc/guides/eventdevs/dlb2.rst
+++ b/doc/guides/eventdevs/dlb2.rst
@@ -16,8 +16,7 @@ Please follow the links below to download the Programmer Guides.
 Prerequisites
 -------------
 
-Follow the DPDK :ref:`Getting Started Guide for Linux <linux_gsg>` to setup
-the basic DPDK environment.
+Follow the DPDK :doc:`/linux_gsg/index` to setup the basic DPDK environment.
 
 Configuration
 -------------
diff --git a/doc/guides/eventdevs/dpaa.rst b/doc/guides/eventdevs/dpaa.rst
index 578c133f82..a467841e16 100644
--- a/doc/guides/eventdevs/dpaa.rst
+++ b/doc/guides/eventdevs/dpaa.rst
@@ -38,7 +38,7 @@ Currently supported by DPDK:
 - NXP SDK **2.0+** or LSDK **18.09+**
 - Supported architectures:  **arm64 LE**.
 
-- Follow the DPDK :ref:`Getting Started Guide for Linux <linux_gsg>` to setup the basic DPDK environment.
+- Follow the DPDK :doc:`/linux_gsg/index` to setup the basic DPDK environment.
 
 
 Initialization
diff --git a/doc/guides/eventdevs/dpaa2.rst b/doc/guides/eventdevs/dpaa2.rst
index 5b28999ceb..b1e0a1435d 100644
--- a/doc/guides/eventdevs/dpaa2.rst
+++ b/doc/guides/eventdevs/dpaa2.rst
@@ -36,7 +36,7 @@ Prerequisites
 
 See :doc:`/platform/dpaa2` for setup information
 
-- Follow the DPDK :ref:`Getting Started Guide for Linux <linux_gsg>` to setup the basic DPDK environment.
+- Follow the DPDK :doc:`/linux_gsg/index` to setup the basic DPDK environment.
 
 .. note::
 
diff --git a/doc/guides/freebsd_gsg/build_dpdk.rst b/doc/guides/freebsd_gsg/build_dpdk.rst
index 8de28f0314..faedee1384 100644
--- a/doc/guides/freebsd_gsg/build_dpdk.rst
+++ b/doc/guides/freebsd_gsg/build_dpdk.rst
@@ -3,8 +3,6 @@
 
 .. include:: <isonum.txt>
 
-.. _building_from_source:
-
 Compiling the DPDK Target from Source
 =====================================
 
diff --git a/doc/guides/freebsd_gsg/build_sample_apps.rst b/doc/guides/freebsd_gsg/build_sample_apps.rst
index db01b16e18..a89518daa5 100644
--- a/doc/guides/freebsd_gsg/build_sample_apps.rst
+++ b/doc/guides/freebsd_gsg/build_sample_apps.rst
@@ -1,8 +1,6 @@
 ..  SPDX-License-Identifier: BSD-3-Clause
     Copyright(c) 2010-2014 Intel Corporation.
 
-.. _compiling_sample_apps:
-
 Compiling and Running Sample Applications
 =========================================
 
diff --git a/doc/guides/freebsd_gsg/index.rst b/doc/guides/freebsd_gsg/index.rst
index 9af5988dc6..8f3bd4203d 100644
--- a/doc/guides/freebsd_gsg/index.rst
+++ b/doc/guides/freebsd_gsg/index.rst
@@ -1,8 +1,6 @@
 ..  SPDX-License-Identifier: BSD-3-Clause
     Copyright(c) 2010-2014 Intel Corporation.
 
-.. _freebsd_gsg:
-
 Getting Started Guide for FreeBSD
 =================================
 
diff --git a/doc/guides/freebsd_gsg/install_from_ports.rst b/doc/guides/freebsd_gsg/install_from_ports.rst
index 3c98c46b29..d2e19a1248 100644
--- a/doc/guides/freebsd_gsg/install_from_ports.rst
+++ b/doc/guides/freebsd_gsg/install_from_ports.rst
@@ -1,8 +1,6 @@
 ..  SPDX-License-Identifier: BSD-3-Clause
     Copyright(c) 2010-2014 Intel Corporation.
 
-.. _install_from_ports:
-
 Installing DPDK from the Ports Collection
 =========================================
 
@@ -61,7 +59,7 @@ Compiling and Running the Example Applications
 
 When the DPDK has been installed from the ports collection it installs
 its example applications in ``/usr/local/share/dpdk/examples``.
-These examples can be compiled and run as described in :ref:`compiling_sample_apps`.
+These examples can be compiled and run as described in :doc:`build_sample_apps`.
 
 .. note::
 
@@ -73,7 +71,7 @@ These examples can be compiled and run as described in :ref:`compiling_sample_ap
 
    To install a copy of the DPDK compiled using gcc, please download the
    official DPDK package from https://core.dpdk.org/download/ and install manually using
-   the instructions given in the next chapter, :ref:`building_from_source`
+   the instructions given in the next chapter, :doc:`build_dpdk`
 
 An example application can therefore be copied to a user's home directory and
 compiled and run as below, where we have 2 memory blocks of size 1G reserved
diff --git a/doc/guides/freebsd_gsg/intro.rst b/doc/guides/freebsd_gsg/intro.rst
index fca647efad..1524129533 100644
--- a/doc/guides/freebsd_gsg/intro.rst
+++ b/doc/guides/freebsd_gsg/intro.rst
@@ -18,7 +18,7 @@ handbook is available from the FreeBSD Documentation Project:
 
    DPDK is now available as part of the FreeBSD ports collection and as a pre-built package.
    Installing via the ports collection or FreeBSD `pkg` infrastructure is now the recommended
-   way to install DPDK on FreeBSD, and is documented in the next chapter, :ref:`install_from_ports`.
+   way to install DPDK on FreeBSD, and is documented in the next chapter, :doc:`install_from_ports`.
 
 Documentation Roadmap
 ---------------------
diff --git a/doc/guides/howto/virtio_user_as_exception_path.rst b/doc/guides/howto/virtio_user_as_exception_path.rst
index bb4b6e6fa2..9593831575 100644
--- a/doc/guides/howto/virtio_user_as_exception_path.rst
+++ b/doc/guides/howto/virtio_user_as_exception_path.rst
@@ -59,7 +59,7 @@ Example Usage With Testpmd
 
 To run a simple test of virtio-user as exception path using testpmd:
 
-#. Compile DPDK and bind a NIC to vfio-pci as documented in :ref:`linux_gsg_linux_drivers`.
+#. Compile DPDK and bind a NIC to vfio-pci as documented in :doc:`/linux_gsg/linux_drivers`.
 
    This physical NIC is for communicating with the outside world,
    and serves as a packet source in this example.
diff --git a/doc/guides/linux_gsg/build_dpdk.rst b/doc/guides/linux_gsg/build_dpdk.rst
index 242c07718d..4388e0a1ec 100644
--- a/doc/guides/linux_gsg/build_dpdk.rst
+++ b/doc/guides/linux_gsg/build_dpdk.rst
@@ -1,8 +1,6 @@
 ..  SPDX-License-Identifier: BSD-3-Clause
     Copyright(c) 2010-2015 Intel Corporation.
 
-.. _linux_gsg_compiling_dpdk:
-
 Compiling the DPDK Target from Source
 =====================================
 
diff --git a/doc/guides/linux_gsg/build_sample_apps.rst b/doc/guides/linux_gsg/build_sample_apps.rst
index 4d233c7d05..4f5930a5f6 100644
--- a/doc/guides/linux_gsg/build_sample_apps.rst
+++ b/doc/guides/linux_gsg/build_sample_apps.rst
@@ -24,7 +24,7 @@ Running a Sample Application
     - In case needed, ports being used by the application should be
       bound to the corresponding kernel driver.
 
-    Refer to :ref:`linux_gsg_linux_drivers` for more details.
+    Refer to :doc:`linux_drivers` for more details.
 
 The application is linked with the DPDK target environment's Environmental Abstraction Layer (EAL) library,
 which provides some options that are generic to every DPDK application.
diff --git a/doc/guides/linux_gsg/enable_func.rst b/doc/guides/linux_gsg/enable_func.rst
index 4e1a939f35..49c5afaeb4 100644
--- a/doc/guides/linux_gsg/enable_func.rst
+++ b/doc/guides/linux_gsg/enable_func.rst
@@ -3,8 +3,6 @@
 
 .. include:: <isonum.txt>
 
-.. _Enabling_Additional_Functionality:
-
 Enabling Additional Functionality
 =================================
 
diff --git a/doc/guides/linux_gsg/index.rst b/doc/guides/linux_gsg/index.rst
index ecdaf35eec..f739edd6ca 100644
--- a/doc/guides/linux_gsg/index.rst
+++ b/doc/guides/linux_gsg/index.rst
@@ -1,8 +1,6 @@
 ..  SPDX-License-Identifier: BSD-3-Clause
     Copyright(c) 2010-2015 Intel Corporation.
 
-.. _linux_gsg:
-
 Getting Started Guide for Linux
 ===============================
 
diff --git a/doc/guides/linux_gsg/linux_drivers.rst b/doc/guides/linux_gsg/linux_drivers.rst
index 8ffd281330..08e72ace56 100644
--- a/doc/guides/linux_gsg/linux_drivers.rst
+++ b/doc/guides/linux_gsg/linux_drivers.rst
@@ -5,8 +5,6 @@
 
 .. include:: <isonum.txt>
 
-.. _linux_gsg_linux_drivers:
-
 Linux Drivers
 =============
 
diff --git a/doc/guides/linux_gsg/nic_perf_intel_platform.rst b/doc/guides/linux_gsg/nic_perf_intel_platform.rst
index 601d7bdc7a..13ba461671 100644
--- a/doc/guides/linux_gsg/nic_perf_intel_platform.rst
+++ b/doc/guides/linux_gsg/nic_perf_intel_platform.rst
@@ -182,4 +182,4 @@ Configurations before running DPDK
    In the example above ``85:00.0`` is on socket 1 and should be used by cores on socket 1 for the best performance.
 
 #. Check which kernel drivers need to be loaded and whether there is a need to unbind the network ports from their kernel drivers.
-   More details about DPDK setup and Linux kernel requirements see :ref:`linux_gsg_compiling_dpdk` and :ref:`linux_gsg_linux_drivers`.
+   More details about DPDK setup and Linux kernel requirements see :doc:`build_dpdk` and :doc:`linux_drivers`.
diff --git a/doc/guides/linux_gsg/sys_reqs.rst b/doc/guides/linux_gsg/sys_reqs.rst
index 3e0c902555..0c9ad64776 100644
--- a/doc/guides/linux_gsg/sys_reqs.rst
+++ b/doc/guides/linux_gsg/sys_reqs.rst
@@ -14,8 +14,7 @@ BIOS Setting Prerequisite on x86
 For the majority of platforms, no special BIOS settings are needed to use basic DPDK functionality.
 However, for additional HPET timer and power management functionality,
 and high performance of small packets, BIOS setting changes may be needed.
-Consult the section on :ref:`Enabling Additional Functionality <Enabling_Additional_Functionality>`
-for more information on the required changes.
+Consult the section on :doc:`enable_func` for more information on the required changes.
 
 Compilation of the DPDK
 -----------------------
diff --git a/doc/guides/nics/ark.rst b/doc/guides/nics/ark.rst
index 078435cfe7..77ecf7ba0c 100644
--- a/doc/guides/nics/ark.rst
+++ b/doc/guides/nics/ark.rst
@@ -276,8 +276,7 @@ See :doc:`/linux_gsg/build_dpdk` for instructions.
 
 By default the ARK PMD library will be built into the DPDK library.
 
-For configuring and using UIO and VFIO frameworks, please also refer :ref:`the
-documentation that comes with DPDK suite <linux_gsg>`.
+For configuring and using UIO and VFIO frameworks, please also refer :doc:`the documentation that comes with DPDK suite </linux_gsg/index>`.
 
 To build with a non-zero minimum tx packet length, set the above macro in your
 CFLAGS environment prior to the meson build step. I.e.,
@@ -395,8 +394,7 @@ application runs to completion, the ARK PMD can be detached from igb_uio if nece
 Usage Example
 -------------
 
-Follow instructions available in the document
-:ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>` to launch
+Follow instructions available in the document :doc:`build_and_test` to launch
 **testpmd** with Atomic Rules ARK devices managed by librte_net_ark.
 
 Example output:
diff --git a/doc/guides/nics/axgbe.rst b/doc/guides/nics/axgbe.rst
index 176d0c9133..49defef3c8 100644
--- a/doc/guides/nics/axgbe.rst
+++ b/doc/guides/nics/axgbe.rst
@@ -34,8 +34,7 @@ See :doc:`/linux_gsg/build_dpdk` for instructions.
 
 By default the AXGBE PMD library will be built into the DPDK library.
 
-For configuring and using UIO frameworks, please also refer :ref:`the
-documentation that comes with DPDK suite <linux_gsg>`.
+For configuring and using UIO frameworks, please also refer :doc:`the documentation that comes with DPDK suite </linux_gsg/index>`.
 
 
 Prerequisites and Pre-conditions
@@ -50,8 +49,7 @@ Now system is ready to run DPDK application.
 Usage Example
 -------------
 
-Refer to the document :ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>`
-for details.
+Refer to the document :doc:`build_and_test` for details.
 
 Example output:
 
diff --git a/doc/guides/nics/bnx2x.rst b/doc/guides/nics/bnx2x.rst
index c39fa7bfb0..b7a8c96319 100644
--- a/doc/guides/nics/bnx2x.rst
+++ b/doc/guides/nics/bnx2x.rst
@@ -102,8 +102,7 @@ enabling debugging options may affect system performance.
 Driver compilation and testing
 ------------------------------
 
-Refer to the document :ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>`
-for details.
+Refer to the document :doc:`build_and_test` for details.
 
 Jumbo: Limitation
 -----------------
@@ -195,9 +194,7 @@ This section provides instructions to configure SR-IOV with Linux OS.
 #. Running testpmd:
    (Supply ``--log-level="pmd.net.bnx2x.driver",7`` to view informational messages):
 
-   Follow instructions available in the document
-   :ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>`
-   to run testpmd.
+   Follow instructions available in the document :doc:`build_and_test` to run testpmd.
 
    Example output:
 
diff --git a/doc/guides/nics/build_and_test.rst b/doc/guides/nics/build_and_test.rst
index 57e9e5c382..988a602f4f 100644
--- a/doc/guides/nics/build_and_test.rst
+++ b/doc/guides/nics/build_and_test.rst
@@ -1,8 +1,6 @@
 ..  SPDX-License-Identifier: BSD-3-Clause
     Copyright(c) 2017 Cavium, Inc
 
-.. _pmd_build_and_test:
-
 Compiling and testing a PMD for a NIC
 =====================================
 
@@ -13,8 +11,8 @@ TestPMD is one of the reference applications distributed with the DPDK. Its main
 purpose is to forward packets between Ethernet ports on a network interface and
 as such is the best way to test a PMD.
 
-Refer to the :ref:`testpmd application user guide <testpmd_ug>` for detailed
-information on how to build and run testpmd.
+Refer to the :doc:`/testpmd_app_ug/index`
+for detailed information on how to build and run testpmd.
 
 Driver Compilation
 ------------------
@@ -143,8 +141,7 @@ This section demonstrates how to setup and run ``testpmd`` in Linux.
 
       testpmd>
 
-   Refer to the :ref:`testpmd runtime functions <testpmd_runtime>` for a list
-   of available commands.
+   Refer to the :doc:`/testpmd_app_ug/testpmd_funcs` for a list of available commands.
 
    .. note::
       When ``testpmd`` is built with shared library, use option ``-d`` to load
diff --git a/doc/guides/nics/cnxk.rst b/doc/guides/nics/cnxk.rst
index 441b3ce5c4..cb7a86e8fc 100644
--- a/doc/guides/nics/cnxk.rst
+++ b/doc/guides/nics/cnxk.rst
@@ -52,14 +52,11 @@ See :doc:`/platform/cnxk` for setup information.
 Driver compilation and testing
 ------------------------------
 
-Refer to the document :ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>`
-for details.
+Refer to the document :doc:`build_and_test` for details.
 
 #. Running testpmd:
 
-   Follow instructions available in the document
-   :ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>`
-   to run testpmd.
+   Follow instructions available in the document :doc:`build_and_test` to run testpmd.
 
    Example output:
 
diff --git a/doc/guides/nics/cxgbe.rst b/doc/guides/nics/cxgbe.rst
index 9cb411b729..aa46f0bd82 100644
--- a/doc/guides/nics/cxgbe.rst
+++ b/doc/guides/nics/cxgbe.rst
@@ -324,7 +324,7 @@ CXGBE PF Only Runtime Options
 Driver compilation and testing
 ------------------------------
 
-Refer to the document :ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>`
+Refer to the document :doc:`build_and_test`
 for details.
 
 Linux
@@ -434,7 +434,7 @@ devices managed by librte_net_cxgbe in Linux operating system.
 #. Running testpmd
 
    Follow instructions available in the document
-   :ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>`
+   :doc:`build_and_test`
    to run testpmd.
 
    .. note::
@@ -547,7 +547,7 @@ virtual functions.
 #. Running testpmd
 
    Follow instructions available in the document
-   :ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>`
+   :doc:`build_and_test`
    to bind virtual functions and run testpmd.
 
    Example output:
diff --git a/doc/guides/nics/dpaa.rst b/doc/guides/nics/dpaa.rst
index 4354c57828..c6aab46828 100644
--- a/doc/guides/nics/dpaa.rst
+++ b/doc/guides/nics/dpaa.rst
@@ -191,7 +191,7 @@ Prerequisites
 See :doc:`/platform/dpaa` for setup information
 
 
-- Follow the DPDK :ref:`Getting Started Guide for Linux <linux_gsg>`
+- Follow the DPDK :doc:`/linux_gsg/index`
   to setup the basic DPDK environment.
 - DPAA driver has dependency on kernel to perform various functionalities.
   So kernel and DPDK version should be compatible for proper working.
@@ -241,14 +241,11 @@ state during application initialization:
 Driver compilation and testing
 ------------------------------
 
-Refer to the document :ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>`
-for details.
+Refer to the document :doc:`build_and_test` for details.
 
 #. Running testpmd:
 
-   Follow instructions available in the document
-   :ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>`
-   to run testpmd.
+   Follow instructions available in the document :doc:`build_and_test` to run testpmd.
 
    Example output:
 
diff --git a/doc/guides/nics/dpaa2.rst b/doc/guides/nics/dpaa2.rst
index 2368173432..4ae63c7cc2 100644
--- a/doc/guides/nics/dpaa2.rst
+++ b/doc/guides/nics/dpaa2.rst
@@ -422,7 +422,7 @@ Prerequisites
 
 See :doc:`/platform/dpaa2` for setup information
 
-- Follow the DPDK :ref:`Getting Started Guide for Linux <linux_gsg>` to setup the basic DPDK environment.
+- Follow the DPDK :doc:`/linux_gsg/index` to setup the basic DPDK environment.
 
 .. note::
 
@@ -433,14 +433,11 @@ See :doc:`/platform/dpaa2` for setup information
 Driver compilation and testing
 ------------------------------
 
-Refer to the document :ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>`
-for details.
+Refer to the document :doc:`build_and_test` for details.
 
 #. Running testpmd:
 
-   Follow instructions available in the document
-   :ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>`
-   to run testpmd.
+   Follow instructions available in the document :doc:`build_and_test` to run testpmd.
 
    Example output:
 
diff --git a/doc/guides/nics/ena.rst b/doc/guides/nics/ena.rst
index 52156a9fdf..d829e8854f 100644
--- a/doc/guides/nics/ena.rst
+++ b/doc/guides/nics/ena.rst
@@ -179,8 +179,8 @@ See :doc:`/linux_gsg/build_dpdk` for instructions.
 
 By default the ENA PMD library will be built into the DPDK library.
 
-For configuring and using UIO and VFIO frameworks, please also refer :ref:`the
-documentation that comes with DPDK suite <linux_gsg>`.
+For configuring and using UIO and VFIO frameworks,
+please also refer the :doc:`/linux_gsg/index`.
 
 Supported Operating Systems
 ---------------------------
@@ -292,8 +292,7 @@ Note that ``uio_pci_generic`` lacks IOMMU support and cannot be used for metal i
 Usage example
 -------------
 
-Follow instructions available in the document
-:ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>` to launch
+Follow instructions available in the document :doc:`build_and_test` to launch
 **testpmd** with Amazon ENA devices managed by librte_net_ena.
 
 Example output:
diff --git a/doc/guides/nics/enetc.rst b/doc/guides/nics/enetc.rst
index e96260f96a..36f97b2d89 100644
--- a/doc/guides/nics/enetc.rst
+++ b/doc/guides/nics/enetc.rst
@@ -107,6 +107,4 @@ separately:
 Driver compilation and testing
 ------------------------------
 
-Follow instructions available in the document
-:ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>`
-to launch **testpmd**
+Follow instructions available in the document :doc:`build_and_test` to launch **testpmd**
diff --git a/doc/guides/nics/enetc4.rst b/doc/guides/nics/enetc4.rst
index 7a13dbbc79..f0dd039f6e 100644
--- a/doc/guides/nics/enetc4.rst
+++ b/doc/guides/nics/enetc4.rst
@@ -87,9 +87,7 @@ The following dependencies are not part of DPDK and must be installed separately
 Driver compilation and testing
 ------------------------------
 
-Follow instructions available in the document
-:ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>`
-to launch **testpmd**.
+Follow instructions available in the document :doc:`build_and_test` to launch **testpmd**.
 
 
 Driver Arguments (devargs)
diff --git a/doc/guides/nics/enic.rst b/doc/guides/nics/enic.rst
index 6c468ea3af..a0a2ee4505 100644
--- a/doc/guides/nics/enic.rst
+++ b/doc/guides/nics/enic.rst
@@ -518,8 +518,7 @@ How to build the suite
 The build instructions for the DPDK suite should be followed. By default
 the ENIC PMD library will be built into the DPDK library.
 
-Refer to the document :ref:`compiling and testing a PMD for a NIC
-<pmd_build_and_test>` for details.
+Refer to the document :doc:`build_and_test` for details.
 
 For configuring and using UIO and VFIO frameworks, please refer to the
 documentation that comes with DPDK suite.
diff --git a/doc/guides/nics/fail_safe.rst b/doc/guides/nics/fail_safe.rst
index c3922b9c39..822d561588 100644
--- a/doc/guides/nics/fail_safe.rst
+++ b/doc/guides/nics/fail_safe.rst
@@ -108,8 +108,7 @@ Usage example
 
 This section shows some example of using **testpmd** with a fail-safe PMD.
 
-#. To build a PMD and configure DPDK, refer to the document
-   :ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>`.
+#. To build a PMD and configure DPDK, refer to the document :doc:`build_and_test`.
 
 #. Start testpmd. The sub-device ``84:00.0`` should be blocked from normal EAL
    operations to avoid probing it twice, as the PCI bus is in blocklist mode.
diff --git a/doc/guides/nics/hinic.rst b/doc/guides/nics/hinic.rst
index c47737c714..2025a4e2d6 100644
--- a/doc/guides/nics/hinic.rst
+++ b/doc/guides/nics/hinic.rst
@@ -44,14 +44,13 @@ Prerequisites
 - Getting the latest product documents and software supports using
   `<https://support.huawei.com/enterprise/en/intelligent-accelerator-components/in500-solution-pid-23507369>`_.
 
-- Follow the DPDK :ref:`Getting Started Guide for Linux <linux_gsg>` to setup the basic DPDK environment.
+- Follow the DPDK :doc:`/linux_gsg/index` to setup the basic DPDK environment.
 
 
 Driver compilation and testing
 ------------------------------
 
-Refer to the document :ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>`
-for details.
+Refer to the document :doc:`build_and_test` for details.
 
 Limitations or Known issues
 ---------------------------
diff --git a/doc/guides/nics/hinic3.rst b/doc/guides/nics/hinic3.rst
index a6117c713f..d07e8605c0 100644
--- a/doc/guides/nics/hinic3.rst
+++ b/doc/guides/nics/hinic3.rst
@@ -39,15 +39,13 @@ Features
 Prerequisites
 -------------
 
-- Follow the DPDK :ref:`Getting Started Guide for Linux <linux_gsg>`
-  to setup the basic DPDK environment.
+- Follow the DPDK :doc:`/linux_gsg/index` to setup the basic DPDK environment.
 
 
 Driver compilation and testing
 ------------------------------
 
-Refer to the document :ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>`
-for details.
+Refer to the document :doc:`build_and_test` for details.
 
 
 Limitations or Known issues
diff --git a/doc/guides/nics/hns3.rst b/doc/guides/nics/hns3.rst
index 0d36f135f5..03cfc74b50 100644
--- a/doc/guides/nics/hns3.rst
+++ b/doc/guides/nics/hns3.rst
@@ -52,8 +52,7 @@ Prerequisites
 - Get the information about Kunpeng920 chip using
   `<https://www.hisilicon.com/en/products/Kunpeng>`_.
 
-- Follow the DPDK :ref:`Getting Started Guide for Linux <linux_gsg>` to
-  setup the basic DPDK environment.
+- Follow the DPDK :doc:`/linux_gsg/index` to setup the basic DPDK environment.
 
 Link status event Pre-conditions
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -206,8 +205,7 @@ Runtime Configuration
 Driver compilation and testing
 ------------------------------
 
-Refer to the document :ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>`
-for details.
+Refer to the document :doc:`build_and_test` for details.
 
 Sample Application Notes
 ------------------------
diff --git a/doc/guides/nics/i40e.rst b/doc/guides/nics/i40e.rst
index 3e43ab3d2a..69b0fae10f 100644
--- a/doc/guides/nics/i40e.rst
+++ b/doc/guides/nics/i40e.rst
@@ -52,7 +52,7 @@ Linux Prerequisites
 - Identifying your adapter using `Intel Support
   <http://www.intel.com/support>`_ and get the latest NVM/FW images.
 
-- Follow the DPDK :ref:`Getting Started Guide for Linux <linux_gsg>` to setup the basic DPDK environment.
+- Follow the DPDK :doc:`/linux_gsg/index` to setup the basic DPDK environment.
 
 - To get better performance on Intel platforms,
   please follow :doc:`/linux_gsg/nic_perf_intel_platform`.
@@ -221,8 +221,7 @@ can use this assumption to do a bit mask using ``ring_size - 1``.
 Driver compilation and testing
 ------------------------------
 
-Refer to the document :ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>`
-for details.
+Refer to the document :doc:`build_and_test` for details.
 
 
 SR-IOV: Prerequisites and sample Application Notes
@@ -277,9 +276,7 @@ SR-IOV: Prerequisites and sample Application Notes
 
 #. Running testpmd:
 
-   Follow instructions available in the document
-   :ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>`
-   to run testpmd.
+   Follow instructions available in the document :doc:`build_and_test` to run testpmd.
 
    Example output:
 
diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
index f5d575d22f..596b5a07a2 100644
--- a/doc/guides/nics/ice.rst
+++ b/doc/guides/nics/ice.rst
@@ -17,7 +17,7 @@ the following controllers,
 Linux Prerequisites
 -------------------
 
-- Follow the DPDK :ref:`Getting Started Guide for Linux <linux_gsg>` to setup the basic DPDK environment.
+- Follow the DPDK :doc:`/linux_gsg/index` to setup the basic DPDK environment.
 
 - To get better performance on Intel platforms,
   please follow :doc:`/linux_gsg/nic_perf_intel_platform`.
@@ -365,8 +365,7 @@ Runtime Configuration
 Driver compilation and testing
 ------------------------------
 
-Refer to the document :ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>`
-for details.
+Refer to the document :doc:`build_and_test` for details.
 
 Features
 --------
diff --git a/doc/guides/nics/igc.rst b/doc/guides/nics/igc.rst
index 3de4d6d2fc..fadbd15f92 100644
--- a/doc/guides/nics/igc.rst
+++ b/doc/guides/nics/igc.rst
@@ -23,8 +23,7 @@ Supported Chipsets and NICs
 Driver compilation and testing
 ------------------------------
 
-Refer to the document :ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>`
-for details.
+Refer to the document :doc:`build_and_test` for details.
 
 
 Sample Application Notes
diff --git a/doc/guides/nics/ipn3ke.rst b/doc/guides/nics/ipn3ke.rst
index c86037a3c2..ae2250df21 100644
--- a/doc/guides/nics/ipn3ke.rst
+++ b/doc/guides/nics/ipn3ke.rst
@@ -22,7 +22,7 @@ Prerequisites
 - Identifying your adapter using `Intel Support
   <http://www.intel.com/support>`_ and get the latest NVM/FW images.
 
-- Follow the DPDK :ref:`Getting Started Guide for Linux <linux_gsg>` to setup the basic DPDK environment.
+- Follow the DPDK :doc:`/linux_gsg/index` to setup the basic DPDK environment.
 
 - To get better performance on Intel platforms,
   please follow :doc:`/linux_gsg/nic_perf_intel_platform`.
@@ -61,8 +61,7 @@ Runtime Configuration
 Driver compilation and testing
 ------------------------------
 
-Refer to the document :ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>`
-for details.
+Refer to the document :doc:`build_and_test` for details.
 
 Sample Application Notes
 ------------------------
diff --git a/doc/guides/nics/mana.rst b/doc/guides/nics/mana.rst
index 69bfbaa4e7..25580c1082 100644
--- a/doc/guides/nics/mana.rst
+++ b/doc/guides/nics/mana.rst
@@ -54,8 +54,7 @@ and must be installed separately:
 Driver compilation and testing
 ------------------------------
 
-Refer to the document
-:ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>` for details.
+Refer to the document :doc:`build_and_test` for details.
 
 Runtime Configuration
 ---------------------
diff --git a/doc/guides/nics/mvneta.rst b/doc/guides/nics/mvneta.rst
index f999525902..6b3890148a 100644
--- a/doc/guides/nics/mvneta.rst
+++ b/doc/guides/nics/mvneta.rst
@@ -72,8 +72,7 @@ Prerequisites
 
 - DPDK environment
 
-  Follow the DPDK :ref:`Getting Started Guide for Linux <linux_gsg>` to setup
-  DPDK environment.
+  Follow the DPDK :doc:`/linux_gsg/index` to setup DPDK environment.
 
 
 Runtime Configuration
diff --git a/doc/guides/nics/mvpp2.rst b/doc/guides/nics/mvpp2.rst
index 304ec25351..31595afd00 100644
--- a/doc/guides/nics/mvpp2.rst
+++ b/doc/guides/nics/mvpp2.rst
@@ -102,8 +102,7 @@ Prerequisites
 
 - DPDK environment
 
-  Follow the DPDK :ref:`Getting Started Guide for Linux <linux_gsg>` to setup
-  DPDK environment.
+  Follow the DPDK :doc:`/linux_gsg/index` to setup DPDK environment.
 
 
 Building MUSDK
diff --git a/doc/guides/nics/nbl.rst b/doc/guides/nics/nbl.rst
index c85214e6e0..81ed1633ac 100644
--- a/doc/guides/nics/nbl.rst
+++ b/doc/guides/nics/nbl.rst
@@ -84,8 +84,7 @@ Only PF supports coexistence between DPDK and kernel driver; VF does not.
 Prerequisites
 -------------
 
-#. Follow the DPDK :ref:`Getting Started Guide for Linux <linux_gsg>`
-   to setup the basic DPDK environment.
+#. Follow the DPDK :doc:`/linux_gsg/index` to setup the basic DPDK environment.
 
 #. NBL PMD requires the ``vfio-pci`` kernel driver.
    The ``igb_uio`` and ``uio_pci_generic`` drivers are not supported.
diff --git a/doc/guides/nics/nfp.rst b/doc/guides/nics/nfp.rst
index d756d7cc07..5712566971 100644
--- a/doc/guides/nics/nfp.rst
+++ b/doc/guides/nics/nfp.rst
@@ -57,8 +57,7 @@ the NFP PMD.
 Driver compilation and testing
 ------------------------------
 
-Refer to the document
-:ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>` for details.
+Refer to the document :doc:`build_and_test` for details.
 
 Using the PF
 ------------
diff --git a/doc/guides/nics/ngbe.rst b/doc/guides/nics/ngbe.rst
index fe9fb1b07d..9bcd98f67e 100644
--- a/doc/guides/nics/ngbe.rst
+++ b/doc/guides/nics/ngbe.rst
@@ -36,7 +36,7 @@ Prerequisites
 - Learning about Wangxun 1 Gigabit Ethernet NICs using
   `<https://www.net-swift.com/a/386.html>`_.
 
-- Follow the DPDK :ref:`Getting Started Guide for Linux <linux_gsg>` to setup the basic DPDK environment.
+- Follow the DPDK :doc:`/linux_gsg/index` to setup the basic DPDK environment.
 
 
 Configuration
@@ -74,8 +74,7 @@ NGBE PMD provides the following log types available for control:
 Driver compilation and testing
 ------------------------------
 
-Refer to the document :ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>`
-for details.
+Refer to the document :doc:`build_and_test` for details.
 
 
 Limitations or Known issues
diff --git a/doc/guides/nics/octeontx.rst b/doc/guides/nics/octeontx.rst
index a13e3659ef..bb9f150dd9 100644
--- a/doc/guides/nics/octeontx.rst
+++ b/doc/guides/nics/octeontx.rst
@@ -55,14 +55,11 @@ Configuration
 Driver compilation and testing
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-Refer to the document :ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>`
-for details.
+Refer to the document :doc:`build_and_test` for details.
 
 #. Running testpmd:
 
-   Follow instructions available in the document
-   :ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>`
-   to run testpmd.
+   Follow instructions available in the document :doc:`build_and_test` to run testpmd.
 
    Example output:
 
diff --git a/doc/guides/nics/pfe.rst b/doc/guides/nics/pfe.rst
index df33a50237..a5944c050c 100644
--- a/doc/guides/nics/pfe.rst
+++ b/doc/guides/nics/pfe.rst
@@ -156,9 +156,7 @@ separately:
 Driver compilation and testing
 ------------------------------
 
-Follow instructions available in the document
-:ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>`
-to launch **testpmd**
+Follow instructions available in the document :doc:`build_and_test` to launch **testpmd**
 
 Additionally, PFE driver needs `--vdev` as an input with value `net_pfe`
 to execute DPDK application. There is an optional parameter `intf` available
diff --git a/doc/guides/nics/qede.rst b/doc/guides/nics/qede.rst
index ddca443f36..917c18f39d 100644
--- a/doc/guides/nics/qede.rst
+++ b/doc/guides/nics/qede.rst
@@ -144,8 +144,7 @@ following error.
 Driver compilation and testing
 ------------------------------
 
-Refer to the document :ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>`
-for details.
+Refer to the document :doc:`build_and_test` for details.
 
 RTE Flow Support
 ----------------
@@ -260,9 +259,7 @@ This section provides instructions to configure SR-IOV with Linux OS.
 #. Running testpmd
    (Supply ``--log-level="pmd.net.qede.driver:info`` to view informational messages):
 
-   Refer to the document
-   :ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>` to run
-   ``testpmd`` application.
+   Refer to the document :doc:`build_and_test` to run ``testpmd`` application.
 
    Example output:
 
diff --git a/doc/guides/nics/thunderx.rst b/doc/guides/nics/thunderx.rst
index 0b8584e00f..dfcce1d260 100644
--- a/doc/guides/nics/thunderx.rst
+++ b/doc/guides/nics/thunderx.rst
@@ -41,14 +41,13 @@ Features of the ThunderX PMD are:
 
 Prerequisites
 -------------
-- Follow the DPDK :ref:`Getting Started Guide for Linux <linux_gsg>` to setup the basic DPDK environment.
+- Follow the DPDK :doc:`/linux_gsg/index` to setup the basic DPDK environment.
 
 
 Driver compilation and testing
 ------------------------------
 
-Refer to the document :ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>`
-for details.
+Refer to the document :doc:`build_and_test` for details.
 
 Use config/arm/arm64-thunderx-linux-gcc as a meson cross-file when cross-compiling.
 
@@ -149,9 +148,7 @@ This section provides instructions to configure SR-IOV with Linux OS.
 
 #. Running testpmd:
 
-   Follow instructions available in the document
-   :ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>`
-   to run testpmd.
+   Follow instructions available in the document :doc:`build_and_test` to run testpmd.
 
    Example output:
 
diff --git a/doc/guides/nics/txgbe.rst b/doc/guides/nics/txgbe.rst
index 35159fee11..90c55141f1 100644
--- a/doc/guides/nics/txgbe.rst
+++ b/doc/guides/nics/txgbe.rst
@@ -45,7 +45,7 @@ Prerequisites
 - Learning about Wangxun 25 Gigabit Ethernet NICs using
   `<https://www.net-swift.com/a/25GbE-tong-yong-lei-FF5025.html>`_.
 
-- Follow the DPDK :ref:`Getting Started Guide for Linux <linux_gsg>` to setup the basic DPDK environment.
+- Follow the DPDK :doc:`/linux_gsg/index` to setup the basic DPDK environment.
 
 Configuration
 -------------
@@ -180,8 +180,7 @@ Please note that following ``devargs`` are only set for Amber-Lite NICs.
 Driver compilation and testing
 ------------------------------
 
-Refer to the document :ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>`
-for details.
+Refer to the document :doc:`build_and_test` for details.
 
 Sample Application Notes
 ------------------------
diff --git a/doc/guides/nics/xsc.rst b/doc/guides/nics/xsc.rst
index 18deb1d265..f8b622a3cb 100644
--- a/doc/guides/nics/xsc.rst
+++ b/doc/guides/nics/xsc.rst
@@ -22,8 +22,7 @@ The following Yunsilicon device models are supported by the same xsc driver:
 Prerequisites
 -------------
 
-- Follow the DPDK :ref:`Getting Started Guide for Linux <linux_gsg>`
-  to setup the basic DPDK environment.
+- Follow the DPDK :doc:`/linux_gsg/index` to setup the basic DPDK environment.
 
 - Learn about `Yunsilicon metaScale Series NICs
   <https://www.yunsilicon.com/#/productInformation>`_.
diff --git a/doc/guides/nics/zxdh.rst b/doc/guides/nics/zxdh.rst
index 60f33e0dc8..acab9c1122 100644
--- a/doc/guides/nics/zxdh.rst
+++ b/doc/guides/nics/zxdh.rst
@@ -55,8 +55,7 @@ Features of the ZXDH PMD are:
 Driver compilation and testing
 ------------------------------
 
-Refer to the document :ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>`
-for details.
+Refer to the document :doc:`build_and_test` for details.
 
 
 Limitations or Known issues
diff --git a/doc/guides/platform/dpaa.rst b/doc/guides/platform/dpaa.rst
index caeeb03254..76e2d1588d 100644
--- a/doc/guides/platform/dpaa.rst
+++ b/doc/guides/platform/dpaa.rst
@@ -110,5 +110,4 @@ Currently supported by DPDK:
 - NXP SDK **2.0+** (preferred: LSDK 18.09).
 - Supported architectures:  **arm64 LE**.
 
-- Follow the DPDK :ref:`Getting Started Guide for Linux <linux_gsg>`
-  to setup the basic DPDK environment.
+- Follow the DPDK :doc:`/linux_gsg/index` to setup the basic DPDK environment.
diff --git a/doc/guides/platform/dpaa2.rst b/doc/guides/platform/dpaa2.rst
index 589c55d0b2..ecd4cdacaa 100644
--- a/doc/guides/platform/dpaa2.rst
+++ b/doc/guides/platform/dpaa2.rst
@@ -107,5 +107,4 @@ Currently supported by DPDK:
 - MC Firmware version **10.37.0** and higher.
 - Supported architectures:  **arm64 LE**.
 
-- Follow the DPDK :ref:`Getting Started Guide for Linux <linux_gsg>`
-  to setup the basic DPDK environment.
+- Follow the DPDK :doc:`/linux_gsg/index` to setup the basic DPDK environment.
diff --git a/doc/guides/prog_guide/asan.rst b/doc/guides/prog_guide/asan.rst
index 9a6c5a7e4b..97272e131d 100644
--- a/doc/guides/prog_guide/asan.rst
+++ b/doc/guides/prog_guide/asan.rst
@@ -14,7 +14,7 @@ printing out detailed debug information whenever an error is detected.
 AddressSanitizer is a part of LLVM (3.1+) and GCC (4.8+).
 
 Enabling ASan is done by passing the -Db_sanitize=address option to the meson build system,
-see :ref:`linux_gsg_compiling_dpdk` for details.
+see :doc:`/linux_gsg/build_dpdk` for details.
 
 The way ASan is integrated with clang requires to allow undefined symbols when linking code.
 To do this, the -Db_lundef=false option must be added.
diff --git a/doc/guides/rawdevs/dpaa2_cmdif.rst b/doc/guides/rawdevs/dpaa2_cmdif.rst
index 0da0be0638..c419d841e4 100644
--- a/doc/guides/rawdevs/dpaa2_cmdif.rst
+++ b/doc/guides/rawdevs/dpaa2_cmdif.rst
@@ -31,7 +31,7 @@ Prerequisites
 
 See :doc:`/platform/dpaa2` for setup information
 
-- Follow the DPDK :ref:`Getting Started Guide for Linux <linux_gsg>` to setup the basic DPDK environment.
+- Follow the DPDK :doc:`/linux_gsg/index` to setup the basic DPDK environment.
 
 .. note::
 
diff --git a/doc/guides/sample_app_ug/compiling.rst b/doc/guides/sample_app_ug/compiling.rst
index adde775d4e..d3e77f49e8 100644
--- a/doc/guides/sample_app_ug/compiling.rst
+++ b/doc/guides/sample_app_ug/compiling.rst
@@ -28,8 +28,8 @@ Build:
       ninja
 
 For additional information on compiling see
-:ref:`Compiling DPDK on Linux <linux_gsg_compiling_dpdk>` or
-:ref:`Compiling DPDK on FreeBSD <building_from_source>`.
+:doc:`Compiling DPDK on Linux </linux_gsg/build_dpdk>` or
+:doc:`Compiling DPDK on FreeBSD </freebsd_gsg/build_dpdk>`.
 Applications are output to: ``dpdk/<build_dir>/examples``.
 
 
diff --git a/doc/guides/sample_app_ug/server_node_efd.rst b/doc/guides/sample_app_ug/server_node_efd.rst
index c90d74ae1c..43edb7016c 100644
--- a/doc/guides/sample_app_ug/server_node_efd.rst
+++ b/doc/guides/sample_app_ug/server_node_efd.rst
@@ -122,8 +122,8 @@ generator side.
 For examples of application command lines and traffic generator flows, please
 refer to the DPDK Test Report. For more details on how to set up and run the
 sample applications provided with DPDK package, please refer to the
-:ref:`DPDK Getting Started Guide for Linux <linux_gsg>` and
-:ref:`DPDK Getting Started Guide for FreeBSD <freebsd_gsg>`.
+:doc:`DPDK Getting Started Guide for Linux </linux_gsg/index>` and
+:doc:`DPDK Getting Started Guide for FreeBSD </freebsd_gsg/index>`.
 
 
 Explanation
diff --git a/doc/guides/testpmd_app_ug/index.rst b/doc/guides/testpmd_app_ug/index.rst
index 1ac0d25d57..79a2b4596a 100644
--- a/doc/guides/testpmd_app_ug/index.rst
+++ b/doc/guides/testpmd_app_ug/index.rst
@@ -1,8 +1,6 @@
 ..  SPDX-License-Identifier: BSD-3-Clause
     Copyright(c) 2010-2014 Intel Corporation.
 
-.. _testpmd_ug:
-
 Testpmd Application User Guide
 ==============================
 
diff --git a/doc/guides/testpmd_app_ug/run_app.rst b/doc/guides/testpmd_app_ug/run_app.rst
index fc9e4f02a9..52699efa78 100644
--- a/doc/guides/testpmd_app_ug/run_app.rst
+++ b/doc/guides/testpmd_app_ug/run_app.rst
@@ -29,7 +29,7 @@ The command line options are:
     Run testpmd in interactive mode.
     In this mode, the testpmd starts with a prompt that can be used to start and stop forwarding,
     configure the application and display stats on the current packet processing session.
-    See :ref:`testpmd_runtime` for more details.
+    See :doc:`testpmd_funcs` for more details.
 
     In non-interactive mode,
     the application starts with the configuration specified on the command-line and
diff --git a/doc/guides/testpmd_app_ug/testpmd_funcs.rst b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
index f06856070b..3501f10a4a 100644
--- a/doc/guides/testpmd_app_ug/testpmd_funcs.rst
+++ b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
@@ -1,8 +1,6 @@
 ..  SPDX-License-Identifier: BSD-3-Clause
     Copyright(c) 2010-2016 Intel Corporation.
 
-.. _testpmd_runtime:
-
 Testpmd Runtime Functions
 =========================
 
diff --git a/doc/guides/tools/testbbdev.rst b/doc/guides/tools/testbbdev.rst
index a7c433aacd..cf5c3d2fd1 100644
--- a/doc/guides/tools/testbbdev.rst
+++ b/doc/guides/tools/testbbdev.rst
@@ -1,8 +1,6 @@
 ..  SPDX-License-Identifier: BSD-3-Clause
     Copyright(c) 2017 Intel Corporation
 
-.. _test_bbdev_application:
-
 dpdk-test-bbdev Application
 ===========================
 
-- 
2.54.0

