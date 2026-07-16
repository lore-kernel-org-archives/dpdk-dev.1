Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CECC44501
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Jul 2026 10:38:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E945040698;
	Thu, 16 Jul 2026 12:38:20 +0200 (CEST)
Received: from fout-a8-smtp.messagingengine.com
 (fout-a8-smtp.messagingengine.com [103.168.172.151])
 by mails.dpdk.org (Postfix) with ESMTP id 3E9F0400D5
 for <dev@dpdk.org>; Thu, 16 Jul 2026 12:38:19 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id E9F9EEC011A;
 Thu, 16 Jul 2026 06:38:18 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Thu, 16 Jul 2026 06:38:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1784198298; x=
 1784284698; bh=Wx+woxwoWWpLPh5L3faWZCg8S5AjnJz41zQj4sTG+zA=; b=B
 kotPhiJmrsBzS+AIXYOcwRLvgX9M3ozjIuxihUph32JYbS9uK2ahp6yVcaAhHHC4
 EUmCC3V2yFgVfTROCt90YqX01gAgdM1dzyrADh1pzVJ31li+ZOFBRf/hb6QQiwRu
 qfSSFlPEB9dS5PxFhND0fv+EuKE2Cz81YxqO4CWG1pNF9lyvn2bn5Bp1AeeD+3ki
 ZU+Sif+uOOgPpVFNbawHtgjVnpFi54iulemxi90UITK0DHubtzmfkE2rh8w2P60L
 FJAoir0dm2L+b46YDH6QcUgJ5NR+KUdnVKDIKJWt0D3HoxOiUeluc6b8V/hHs7tz
 3SEjdTP7KO3j+PfMSGxfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1784198298; x=1784284698; bh=W
 x+woxwoWWpLPh5L3faWZCg8S5AjnJz41zQj4sTG+zA=; b=GKnawMoCT6fjEcdKE
 b4oR0ZJuROI6q73Yh/SgjFFP4sg7+PV3RLME5n2Jd3A8PfYENVwsjTrWjLotkKMA
 QcsbhFJSHcabXZkr5QOdlMpGHkkN0hbTB22sVxW8N+K8AAXWzRCQ2nBCq9IjzeyU
 JBWjLM6GNHtQlle4ODIYIOuBwtUCeVjzd3jvoRpWgIagne7jAOnmT6EGWq7/vkIf
 vARvCI0J4z7NVlAFDfPiqQd4wT9bgWhh8Mib4pVXdod4s0aeh/Kjw5F2aSAbI33F
 aEAlWDyxTDFfiRKYFedpLOCBZHewgcmGSseOugbTms5SOVT1njLQYOGZpbVV4me6
 0HZHQ==
X-ME-Sender: <xms:mrRYasR1WxYIYh6gJiIeYGmGl9K-bZSf5H5JCdKyBt_nC665LZhhJQ>
 <xme:mrRYarZDOE-d31xaCFW_kJx0gujqL-NL_DXm-O11t1joDXmxIVU-ff_tnmwW7348F
 Tk-oNDjvMg4NNhyjtZEIVGT4PzPZH4M8uLUQ1Bg149OfgZOJmK7tw>
X-ME-Received: <xmr:mrRYat49VO4ofC4BEgVmn91La6F0iSNKi9DKFA1fkoRzyUmVAYr_OGBOTBxkoyhQol2cHBHuexTjUn4iL4J54zo>
X-ME-Proxy-Cause: dmFkZTEnWUgHegW4lz6QkmRJQ77gb84w1UKZTpeIrV70OjKAH696b+UKXnrlMYWnjj/Xkx
 dQe4PwMKUMYS/CRUjMym6gdq9VEeHVhX2to8E9zhnm7ikIatTx0xMAZeaM5Dz3zJxNjr2u
 9ErwrnbWrmoNRxkTwoPOw4IfWUotWhyzbbWCGsrd9OZGy0rgaN2DTlsnkNr1fWhdg59CMl
 5hLeeCgc9rEL2+L14QsqMOZpp7Uk3dDjzogjzn4V2+tO4ND/qS6xAxCg9acdM8jiVITYru
 toHEcOod7eVO1ntJ9Lfh8JHZlm8Vcdm5ci8s//dUvkaeLsrw/aGRxRCvjCZeFBl9+O/ufm
 kk/2OEgRUnrCFPwTppEnZspTCg85/wykqRpxkwk+2CBMp1z1vg3HdaxgzereitQpN1f3F1
 Xid1MBDkv6IuC7/zkaffThPGw5/+4qmnkQVbVcI8JoTWDxhxzntW4SjlV/uTjfhpjOighJ
 ebZgXLfSG9+2/SbJgJYJFFPAoEFS/CL3DSjrCva4HhNVQx/0b+o78Znspd/c45XzwRdj2f
 Q5FC+/ySlB9D4RJqoEeZffcXi1QRkJR35HIIEdn5WPWo7YI7oyqHPluYqLH/fFq4UY+VnE
 8fQlEdTHyQMrJeZFkWkK/WDnixNJWgGLW4VNZrJSamk4IamWyRrxfejKnj7A
X-ME-Proxy: <xmx:mrRYamdyLXzaqlxJeRJ21v0y9Rbceo40HtpNtlndiHyisYV4fsfKbA>
 <xmx:mrRYakfcEEsfo8CrpHIq1YR4dMGgkk0ajcHhU6_hRJ9ENbfR3Sbt1w>
 <xmx:mrRYarGH2sG9VCiqH9d_gPe16i2-nqUFBFDaVx9LV4vL_U-bCkPuQw>
 <xmx:mrRYajHdTM1HwlJ2imwdO80FUQwSE4fDz4Ctv-txc-zR-um4tkCLuQ>
 <xmx:mrRYahqzdCTseq1im6WvAsaAQG99qF1EpNsr2p72Ylpt4yXhPKF2fuXe>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 06:38:14 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Vamsi Attunuru <vattunuru@marvell.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Kevin Laatz <kevin.laatz@intel.com>,	Conor Walsh <conor.walsh@intel.com>,
 Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>,
 Vidya Sagar Velumuri <vvelumuri@marvell.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>,	Liron Himi <lironh@marvell.com>,
 Abhinandan Gujjar <abhinandan.gujjar@intel.com>,
 Amit Prakash Shukla <amitprakashs@marvell.com>,
 Erik Gabriel Carrillo <erik.g.carrillo@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>,	Ori Kam <orika@nvidia.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Luca Vizzarro <luca.vizzarro@arm.com>,
 Patrick Robb <patrickrobb1997@gmail.com>
Subject: [PATCH v3 6/8] doc: remove redundant link captions
Date: Thu, 16 Jul 2026 12:31:24 +0200
Message-ID: <20260716103632.711164-7-thomas@monjalon.net>
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

Some explicit link captions duplicate the title
of the referenced section or document.

Let Sphinx use the referenced title directly
where the rendered text would stay the same.

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 doc/guides/contributing/abi_versioning.rst              | 6 +++---
 doc/guides/contributing/patches.rst                     | 3 +--
 doc/guides/dmadevs/cnxk.rst                             | 2 +-
 doc/guides/dmadevs/idxd.rst                             | 2 +-
 doc/guides/dmadevs/ioat.rst                             | 2 +-
 doc/guides/dmadevs/odm.rst                              | 3 +--
 doc/guides/howto/lm_bond_virtio_sriov.rst               | 7 +++----
 doc/guides/howto/lm_virtio_vhost_user.rst               | 4 ++--
 doc/guides/howto/packet_capture_framework.rst           | 2 +-
 doc/guides/linux_gsg/enable_func.rst                    | 2 +-
 doc/guides/linux_gsg/sys_reqs.rst                       | 2 +-
 doc/guides/nics/dpaa2.rst                               | 2 +-
 doc/guides/nics/mvpp2.rst                               | 8 ++++----
 doc/guides/prog_guide/eventdev/event_crypto_adapter.rst | 2 +-
 doc/guides/prog_guide/eventdev/event_dma_adapter.rst    | 2 +-
 doc/guides/prog_guide/eventdev/event_timer_adapter.rst  | 2 +-
 doc/guides/prog_guide/fib_lib.rst                       | 2 +-
 doc/guides/prog_guide/graph_lib.rst                     | 8 ++++----
 doc/guides/regexdevs/mlx5.rst                           | 2 +-
 doc/guides/rel_notes/deprecation.rst                    | 3 +--
 doc/guides/sample_app_ug/l3_forward_power_man.rst       | 2 +-
 doc/guides/sample_app_ug/server_node_efd.rst            | 3 +--
 doc/guides/tools/dts.rst                                | 2 +-
 23 files changed, 34 insertions(+), 39 deletions(-)

diff --git a/doc/guides/contributing/abi_versioning.rst b/doc/guides/contributing/abi_versioning.rst
index 933abcba57..6861517c5d 100644
--- a/doc/guides/contributing/abi_versioning.rst
+++ b/doc/guides/contributing/abi_versioning.rst
@@ -226,8 +226,8 @@ but now points to the above newly named function ``rte_acl_create_v21``.
 We have now mapped the original rte_acl_create symbol to the original function
 (but with a new name).
 
-Please see the section :ref:`Enabling versioning macros
-<enabling_versioning_macros>` to enable this macro in the meson/ninja build.
+Please see the section :ref:`enabling_versioning_macros`
+to enable this macro in the Meson/Ninja build.
 
 Next, we need to create the new version of the symbol. We create a new
 function name and implement it appropriately, then wrap it in a call to ``RTE_DEFAULT_SYMBOL``.
@@ -256,7 +256,7 @@ used by newly built applications.
 .. note::
 
    **Before you leave**, please take care reviewing the sections on
-   :ref:`enabling versioning macros <enabling_versioning_macros>`,
+   :ref:`enabling_versioning_macros`,
    and :ref:`ABI deprecation <abi_deprecation>`.
 
 
diff --git a/doc/guides/contributing/patches.rst b/doc/guides/contributing/patches.rst
index 0ffa447af1..ab4d3ec916 100644
--- a/doc/guides/contributing/patches.rst
+++ b/doc/guides/contributing/patches.rst
@@ -161,8 +161,7 @@ Make your planned changes in the cloned ``dpdk`` repo. Here are some guidelines
   * For other PMDs and more info, refer to the ``MAINTAINERS`` file.
 
 * New external functions should be exported.
-  See the :doc:`ABI policy <abi_policy>` and :doc:`abi_versioning`
-  guides.
+  See the :doc:`abi_policy` and :doc:`abi_versioning` guides.
 
 * Any new API function should be used in ``/app`` test directory.
 
diff --git a/doc/guides/dmadevs/cnxk.rst b/doc/guides/dmadevs/cnxk.rst
index e86ae83f01..1a7185deb9 100644
--- a/doc/guides/dmadevs/cnxk.rst
+++ b/doc/guides/dmadevs/cnxk.rst
@@ -53,7 +53,7 @@ by calling the ``rte_dma_start()`` API.
 Performing Data Copies
 ~~~~~~~~~~~~~~~~~~~~~~
 
-Refer to the :ref:`Enqueue / Dequeue APIs <dmadev_enqueue_dequeue>` section
+Refer to the :ref:`dmadev_enqueue_dequeue` section
 of the dmadev library documentation
 for details on operation enqueue and submission API usage.
 
diff --git a/doc/guides/dmadevs/idxd.rst b/doc/guides/dmadevs/idxd.rst
index 1b33e23d30..3aee98c92c 100644
--- a/doc/guides/dmadevs/idxd.rst
+++ b/doc/guides/dmadevs/idxd.rst
@@ -197,7 +197,7 @@ Once configured, the device can then be made ready for use by calling the
 Performing Data Copies
 ~~~~~~~~~~~~~~~~~~~~~~
 
-Refer to the :ref:`Enqueue / Dequeue APIs <dmadev_enqueue_dequeue>` section of the dmadev library
+Refer to the :ref:`dmadev_enqueue_dequeue` section of the dmadev library
 documentation for details on operation enqueue, submission and completion API usage.
 
 It is expected that, for efficiency reasons, a burst of operations will be enqueued to the
diff --git a/doc/guides/dmadevs/ioat.rst b/doc/guides/dmadevs/ioat.rst
index 9ee7852dde..36fdd3feee 100644
--- a/doc/guides/dmadevs/ioat.rst
+++ b/doc/guides/dmadevs/ioat.rst
@@ -89,7 +89,7 @@ Once configured, the device can then be made ready for use by calling the
 Performing Data Copies
 ~~~~~~~~~~~~~~~~~~~~~~
 
-Refer to the :ref:`Enqueue / Dequeue APIs <dmadev_enqueue_dequeue>` section of the dmadev library
+Refer to the :ref:`dmadev_enqueue_dequeue` section of the dmadev library
 documentation for details on operation enqueue, submission and completion API usage.
 
 It is expected that, for efficiency reasons, a burst of operations will be enqueued to the
diff --git a/doc/guides/dmadevs/odm.rst b/doc/guides/dmadevs/odm.rst
index 88fec231d7..4dc5cf5c8b 100644
--- a/doc/guides/dmadevs/odm.rst
+++ b/doc/guides/dmadevs/odm.rst
@@ -48,8 +48,7 @@ by calling the ``rte_dma_start()`` API.
 Performing Data Copies
 ~~~~~~~~~~~~~~~~~~~~~~
 
-Refer to the :ref:`Enqueue / Dequeue API <dmadev_enqueue_dequeue>`
-section of the dmadev library documentation
+Refer to the :ref:`dmadev_enqueue_dequeue` section of the dmadev library documentation
 for details on operation enqueue and submission API usage.
 
 Performance Tuning Parameters
diff --git a/doc/guides/howto/lm_bond_virtio_sriov.rst b/doc/guides/howto/lm_bond_virtio_sriov.rst
index c98cbc9023..68dd1b12e9 100644
--- a/doc/guides/howto/lm_bond_virtio_sriov.rst
+++ b/doc/guides/howto/lm_bond_virtio_sriov.rst
@@ -31,8 +31,7 @@ The NIC's on both servers are connected to a switch
 which is also connected to the traffic generator.
 
 The switch is configured to broadcast traffic on all the NIC ports.
-A :ref:`Sample switch configuration <lm_bond_virtio_sriov_switch_conf>`
-can be found in this section.
+A :ref:`lm_bond_virtio_sriov_switch_conf` can be found in this section.
 
 The host is running the Kernel PF driver (ixgbe or i40e).
 
@@ -46,8 +45,8 @@ Live Migration steps
 --------------------
 
 The sample scripts mentioned in the steps below can be found in the
-:ref:`Sample host scripts <lm_bond_virtio_sriov_host_scripts>` and
-:ref:`Sample VM scripts <lm_bond_virtio_sriov_vm_scripts>` sections.
+:ref:`lm_bond_virtio_sriov_host_scripts` and
+:ref:`lm_bond_virtio_sriov_vm_scripts` sections.
 
 On host_server_1: Terminal 1
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/doc/guides/howto/lm_virtio_vhost_user.rst b/doc/guides/howto/lm_virtio_vhost_user.rst
index cef6aa87f2..b4f21e15c1 100644
--- a/doc/guides/howto/lm_virtio_vhost_user.rst
+++ b/doc/guides/howto/lm_virtio_vhost_user.rst
@@ -38,8 +38,8 @@ Live Migration steps
 --------------------
 
 The sample scripts mentioned in the steps below can be found in the
-:ref:`Sample host scripts <lm_virtio_vhost_user_host_scripts>` and
-:ref:`Sample VM scripts <lm_virtio_vhost_user_vm_scripts>` sections.
+:ref:`lm_virtio_vhost_user_host_scripts` and
+:ref:`lm_virtio_vhost_user_vm_scripts` sections.
 
 On host_server_1: Terminal 1
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/doc/guides/howto/packet_capture_framework.rst b/doc/guides/howto/packet_capture_framework.rst
index 417bd7ba7b..b0db8bde04 100644
--- a/doc/guides/howto/packet_capture_framework.rst
+++ b/doc/guides/howto/packet_capture_framework.rst
@@ -28,7 +28,7 @@ and its usage is recommended for debugging purposes.
 The :doc:`librte_pcapng </prog_guide/pcapng_lib>` library provides the API
 to format packets and write them to a file in Pcapng format.
 
-The :doc:`dpdk-dumpcap </tools/dumpcap>` is a tool that captures packets in
+The :doc:`/tools/dumpcap` is a tool that captures packets in
 like Wireshark dumpcap does for Linux.
 It runs as a DPDK secondary process and captures packets
 from one or more interfaces and writes them to a file in Pcapng format.
diff --git a/doc/guides/linux_gsg/enable_func.rst b/doc/guides/linux_gsg/enable_func.rst
index 49c5afaeb4..c3f5be481a 100644
--- a/doc/guides/linux_gsg/enable_func.rst
+++ b/doc/guides/linux_gsg/enable_func.rst
@@ -83,7 +83,7 @@ need to be adjusted in order to ensure normal DPDK operation:
 The above limits can usually be adjusted by editing
 ``/etc/security/limits.conf`` file, and rebooting.
 
-See :ref:`Hugepage Mapping <hugepage_mapping>` section to learn how these limits affect EAL.
+See :ref:`hugepage_mapping` section to learn how these limits affect EAL.
 
 Device Control
 ~~~~~~~~~~~~~~
diff --git a/doc/guides/linux_gsg/sys_reqs.rst b/doc/guides/linux_gsg/sys_reqs.rst
index 0c9ad64776..a596400178 100644
--- a/doc/guides/linux_gsg/sys_reqs.rst
+++ b/doc/guides/linux_gsg/sys_reqs.rst
@@ -131,7 +131,7 @@ System Software
     *   PROC_PAGE_MONITOR support
 
     *   HPET and HPET_MMAP configuration options should also be enabled if HPET support is required.
-        See the section on :ref:`High Precision Event Timer (HPET) Functionality <High_Precision_Event_Timer>` for more details.
+        See the section on :ref:`High_Precision_Event_Timer` for more details.
 
 .. _linux_gsg_hugepages:
 
diff --git a/doc/guides/nics/dpaa2.rst b/doc/guides/nics/dpaa2.rst
index 4ae63c7cc2..6e2884b897 100644
--- a/doc/guides/nics/dpaa2.rst
+++ b/doc/guides/nics/dpaa2.rst
@@ -407,7 +407,7 @@ Features of the DPAA2 PMD are:
 - Link flow control
 - Scattered and gather for TX and RX
 - Rx queue interrupts
-- :ref:`Traffic Management API <dptmapi>`
+- :ref:`dptmapi`
 
 
 Supported DPAA2 SoCs
diff --git a/doc/guides/nics/mvpp2.rst b/doc/guides/nics/mvpp2.rst
index 31595afd00..f20987b4d7 100644
--- a/doc/guides/nics/mvpp2.rst
+++ b/doc/guides/nics/mvpp2.rst
@@ -35,13 +35,13 @@ Features of the MVPP2 PMD are:
 - L4 checksum offload
 - Packet type parsing
 - Basic stats
-- :ref:`Extended stats <extstats>`
+- :ref:`extstats`
 - RX flow control
 - Scattered TX frames
 - :ref:`QoS <extconf>`
-- :ref:`Flow API <flowapi>`
-- :ref:`Traffic metering and policing <mtrapi>`
-- :ref:`Traffic Management API <tmapi>`
+- :ref:`flowapi`
+- :ref:`mtrapi`
+- :ref:`tmapi`
 
 Limitations
 -----------
diff --git a/doc/guides/prog_guide/eventdev/event_crypto_adapter.rst b/doc/guides/prog_guide/eventdev/event_crypto_adapter.rst
index 9bbba69777..78c69665ef 100644
--- a/doc/guides/prog_guide/eventdev/event_crypto_adapter.rst
+++ b/doc/guides/prog_guide/eventdev/event_crypto_adapter.rst
@@ -4,7 +4,7 @@
 Event Crypto Adapter Library
 ============================
 
-The DPDK :doc:`Eventdev library <eventdev>` provides event driven
+The DPDK :doc:`eventdev` provides event driven
 programming model with features to schedule events.
 The :doc:`../cryptodev_lib` provides an interface to
 the crypto poll mode drivers that support different crypto operations.
diff --git a/doc/guides/prog_guide/eventdev/event_dma_adapter.rst b/doc/guides/prog_guide/eventdev/event_dma_adapter.rst
index 436be45a62..f7c02d5b25 100644
--- a/doc/guides/prog_guide/eventdev/event_dma_adapter.rst
+++ b/doc/guides/prog_guide/eventdev/event_dma_adapter.rst
@@ -4,7 +4,7 @@
 Event DMA Adapter Library
 =========================
 
-DPDK :doc:`eventdev library <eventdev>` provides event driven programming model
+DPDK :doc:`eventdev` provides event driven programming model
 with features to schedule events.
 :doc:`../dmadev` provides an interface to DMA poll mode drivers
 that support DMA operations.
diff --git a/doc/guides/prog_guide/eventdev/event_timer_adapter.rst b/doc/guides/prog_guide/eventdev/event_timer_adapter.rst
index 879105fa35..ea777c13cf 100644
--- a/doc/guides/prog_guide/eventdev/event_timer_adapter.rst
+++ b/doc/guides/prog_guide/eventdev/event_timer_adapter.rst
@@ -4,7 +4,7 @@
 Event Timer Adapter Library
 ===========================
 
-The DPDK :doc:`Event Device library <eventdev>`
+The DPDK :doc:`eventdev`
 introduces an event driven programming model which presents applications with
 an alternative to the polling model traditionally used in DPDK
 applications. Event devices can be coupled with arbitrary components to provide
diff --git a/doc/guides/prog_guide/fib_lib.rst b/doc/guides/prog_guide/fib_lib.rst
index a81da2d491..ea99670b5a 100644
--- a/doc/guides/prog_guide/fib_lib.rst
+++ b/doc/guides/prog_guide/fib_lib.rst
@@ -21,7 +21,7 @@ FIB API Overview
 
 The main configuration struct contains:
 
-* Type of :ref:`dataplane algorithm <fib_dataplane_algorithms>`.
+* Type of :ref:`fib_dataplane_algorithms`.
 
 * Default next hop ID.
 
diff --git a/doc/guides/prog_guide/graph_lib.rst b/doc/guides/prog_guide/graph_lib.rst
index c72065c9f3..f1264fdcb6 100644
--- a/doc/guides/prog_guide/graph_lib.rst
+++ b/doc/guides/prog_guide/graph_lib.rst
@@ -537,8 +537,8 @@ Feature arc
 An ordered list of feature nodes in a given network layer is called as feature arc.
 It consists of three objects:
 
-- :ref:`Start node <Start_Node>`
-- :ref:`End feature node <End_Feature_Node>`
+- :ref:`Start_Node`
+- :ref:`End_Feature_Node`
 - :ref:`Zero or more feature nodes <Feature_Nodes>`
 
 In order to :ref:`create <Feature_Arc_Registration>` a feature arc object,
@@ -774,7 +774,7 @@ using ``rte_graph_feature_enable()`` and ``rte_graph_feature_disable()`` functio
 .. note::
 
    RCU argument is optional argument to enable/disable API.
-   See :ref:`control/data plane synchronization <Control_Data_Plane_Synchronization>`
+   See :ref:`Control_Data_Plane_Synchronization`
    and :ref:`notifier_cb <Feature_Notifier_Cb>` for more details on when RCU is needed.
 
 Fast path traversal rules
@@ -845,7 +845,7 @@ whenever any feature is enabled at runtime.
 *****************
 
 Following code-snippet explains fast path traversal rule for ``Feature-1``
-:ref:`feature node <Feature_Nodes>` shown in :ref:`figure <Figure_Arc_2>`.
+:ref:`Feature_Nodes` shown in :ref:`figure <Figure_Arc_2>`.
 
 .. code-block:: c
 
diff --git a/doc/guides/regexdevs/mlx5.rst b/doc/guides/regexdevs/mlx5.rst
index 4094eb9a79..40c51ea0c3 100644
--- a/doc/guides/regexdevs/mlx5.rst
+++ b/doc/guides/regexdevs/mlx5.rst
@@ -27,7 +27,7 @@ Configuration
 -------------
 
 See :ref:`mlx5 common compilation <mlx5_common_compilation>`,
-:ref:`mlx5 firmware configuration <mlx5_firmware_config>`,
+:ref:`mlx5_firmware_config`,
 and :ref:`mlx5 common driver options <mlx5_common_driver_options>`.
 
 
diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index b74215341f..c1c2a94455 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -4,8 +4,7 @@
 ABI and API Deprecation
 =======================
 
-See the guidelines document for details
-of the :doc:`ABI policy </contributing/abi_policy>`.
+See the guidelines document for details of the :doc:`/contributing/abi_policy`.
 
 With DPDK 23.11, there will be a new major ABI version: 24.
 This means that during the development of 23.11,
diff --git a/doc/guides/sample_app_ug/l3_forward_power_man.rst b/doc/guides/sample_app_ug/l3_forward_power_man.rst
index 4a771bbe9b..f33f3b2f94 100644
--- a/doc/guides/sample_app_ug/l3_forward_power_man.rst
+++ b/doc/guides/sample_app_ug/l3_forward_power_man.rst
@@ -304,7 +304,7 @@ and has three available power management schemes:
   The reaction time of the scale mode is longer
   than the pause and monitor mode.
 
-See :doc:`Power Management </prog_guide/power_man>` chapter
+See :doc:`/prog_guide/power_man` chapter
 in the DPDK Programmer's Guide for more details on PMD power management.
 
 .. code-block:: console
diff --git a/doc/guides/sample_app_ug/server_node_efd.rst b/doc/guides/sample_app_ug/server_node_efd.rst
index 43edb7016c..d25b39e89b 100644
--- a/doc/guides/sample_app_ug/server_node_efd.rst
+++ b/doc/guides/sample_app_ug/server_node_efd.rst
@@ -122,8 +122,7 @@ generator side.
 For examples of application command lines and traffic generator flows, please
 refer to the DPDK Test Report. For more details on how to set up and run the
 sample applications provided with DPDK package, please refer to the
-:doc:`DPDK Getting Started Guide for Linux </linux_gsg/index>` and
-:doc:`DPDK Getting Started Guide for FreeBSD </freebsd_gsg/index>`.
+:doc:`/linux_gsg/index` and :doc:`/freebsd_gsg/index`.
 
 
 Explanation
diff --git a/doc/guides/tools/dts.rst b/doc/guides/tools/dts.rst
index fc47f23007..9a877eef8a 100644
--- a/doc/guides/tools/dts.rst
+++ b/doc/guides/tools/dts.rst
@@ -385,7 +385,7 @@ Framework Coding Guidelines
 
 When contributing code to the DTS framework,
 follow existing conventions to ensure consistency.
-The :ref:`DTS developer tools <dts_dev_tools>` will flag basic issues.
+The :ref:`dts_dev_tools` will flag basic issues.
 Also, be sure to :ref:`build the API documentation <building_api_docs>`
 to catch any problems during the build.
 
-- 
2.54.0

