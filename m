Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28537CAC5B8
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Oct 2025 11:32:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 177DD4069F;
	Thu,  2 Oct 2025 13:32:39 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 35A764013F
 for <dev@dpdk.org>; Thu,  2 Oct 2025 13:32:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759404757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3/s/fPfc3Z14G8bmSFmwWGhJyaa56/XA+L0r/4wX4W4=;
 b=Eh3TNfaFA4zjZ/+TzM642o2RCwQEH9NFQLPK7PI9BHMJcF23uxXcauHWwMus4ZWTphPChG
 TEjCjq99pl7E8/GBke9RHVfoqmH84xQvyXrlhkpqrOP8aaBQ+QbJXYuSS1OtffrMYb/Yq9
 UNRMGMasgRqkHVhiVP/FSCDrjzBBK2w=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-3-fyIjDZ7sN5ylKndPl35Org-1; Thu,
 02 Oct 2025 07:32:34 -0400
X-MC-Unique: fyIjDZ7sN5ylKndPl35Org-1
X-Mimecast-MFC-AGG-ID: fyIjDZ7sN5ylKndPl35Org_1759404750
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 29382180047F; Thu,  2 Oct 2025 11:32:29 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.224.213])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C16AB1955F19; Thu,  2 Oct 2025 11:32:16 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Kai Ji <kai.ji@intel.com>, Julien Aube <julien_dpdk@jaube.fr>,
 John Daley <johndale@cisco.com>, Hyong Youb Kim <hyonkim@cisco.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Wenbo Cao <caowenbo@mucse.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>,
 Jochen Behrens <jochen.behrens@broadcom.com>,
 Chengwen Feng <fengchengwen@huawei.com>,
 Kevin Laatz <kevin.laatz@intel.com>, Byron Marohn <byron.marohn@intel.com>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Abhinandan Gujjar <abhinandan.gujjar@intel.com>,
 Amit Prakash Shukla <amitprakashs@marvell.com>,
 Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Srikanth Yalavarthi <syalavarthi@marvell.com>,
 Anoob Joseph <anoobj@marvell.com>, Volodymyr Fialko <vfialko@marvell.com>,
 Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 David Hunt <david.hunt@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>,
 Luca Vizzarro <luca.vizzarro@arm.com>, Patrick Robb <probb@iol.unh.edu>,
 Sunil Kumar Kori <skori@marvell.com>,
 Rakesh Kudurumalla <rkudurumalla@marvell.com>
Subject: [PATCH v2 1/2] doc: remove unused anchors
Date: Thu,  2 Oct 2025 13:32:02 +0200
Message-ID: <20251002113208.3415704-1-david.marchand@redhat.com>
In-Reply-To: <20250527140435.21361-1-nandinipersad361@gmail.com>
References: <20250527140435.21361-1-nandinipersad361@gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xS0zDer_OEqJ0RhDY3R880JLjKzNNeijL-s50Mn1w40_1759404750
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

The documentation has unused anchors that were either left behind after
a documentation refactoring, or just unused since day 1.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 doc/guides/contributing/abi_policy.rst            |  2 --
 doc/guides/contributing/cheatsheet.rst            |  1 -
 doc/guides/contributing/patches.rst               |  1 -
 doc/guides/cryptodevs/qat.rst                     |  1 -
 doc/guides/howto/flow_bifurcation.rst             |  1 -
 doc/guides/howto/lm_bond_virtio_sriov.rst         |  1 -
 doc/guides/howto/lm_virtio_vhost_user.rst         |  1 -
 doc/guides/howto/pvp_reference_benchmark.rst      |  1 -
 doc/guides/linux_gsg/build_dpdk.rst               |  1 -
 doc/guides/nics/bnx2x.rst                         |  1 -
 doc/guides/nics/enic.rst                          |  4 ----
 doc/guides/nics/ice.rst                           |  1 -
 doc/guides/nics/rnp.rst                           |  1 -
 doc/guides/nics/virtio.rst                        |  1 -
 doc/guides/nics/vmxnet3.rst                       |  3 ---
 doc/guides/prog_guide/dmadev.rst                  |  1 -
 doc/guides/prog_guide/efd_lib.rst                 |  4 ----
 doc/guides/prog_guide/env_abstraction_layer.rst   |  2 --
 doc/guides/prog_guide/ethdev/qos_framework.rst    |  4 ----
 .../prog_guide/eventdev/event_crypto_adapter.rst  |  2 --
 .../prog_guide/eventdev/event_dma_adapter.rst     |  2 --
 doc/guides/prog_guide/eventdev/eventdev.rst       |  1 -
 doc/guides/prog_guide/graph_lib.rst               |  4 ----
 doc/guides/prog_guide/member_lib.rst              |  7 -------
 doc/guides/prog_guide/mldev.rst                   |  1 -
 doc/guides/prog_guide/multi_proc_support.rst      |  1 -
 doc/guides/prog_guide/overview.rst                |  1 -
 doc/guides/prog_guide/packet_framework.rst        |  1 -
 doc/guides/prog_guide/pdcp_lib.rst                |  1 -
 doc/guides/prog_guide/ring_lib.rst                | 15 ---------------
 doc/guides/rel_notes/release_20_02.rst            |  1 -
 doc/guides/sample_app_ug/dist_app.rst             |  1 -
 doc/guides/sample_app_ug/l2_forward_crypto.rst    |  1 -
 doc/guides/sample_app_ug/l3_forward.rst           |  1 -
 doc/guides/sample_app_ug/multi_process.rst        |  2 --
 doc/guides/sample_app_ug/ptpclient.rst            |  1 -
 doc/guides/sample_app_ug/qos_scheduler.rst        |  1 -
 doc/guides/sample_app_ug/test_pipeline.rst        |  1 -
 doc/guides/sample_app_ug/vm_power_management.rst  |  2 --
 doc/guides/tools/dts.rst                          |  1 -
 doc/guides/tools/graph.rst                        |  2 --
 doc/guides/tools/testeventdev.rst                 | 10 ----------
 doc/guides/tools/testmldev.rst                    |  6 ------
 43 files changed, 98 deletions(-)

diff --git a/doc/guides/contributing/abi_policy.rst b/doc/guides/contributing/abi_policy.rst
index f03a7467ac..8288235921 100644
--- a/doc/guides/contributing/abi_policy.rst
+++ b/doc/guides/contributing/abi_policy.rst
@@ -53,7 +53,6 @@ Therefore, in the case of dynamic linking, it is critical that an ABI is
 preserved, or (when modified), done in such a way that the application is unable
 to behave improperly or in an unexpected fashion.
 
-.. _figure_what_is_an_abi:
 
 .. figure:: img/what_is_an_abi.*
 
@@ -104,7 +103,6 @@ An ABI version is supported in all new releases until the next major ABI version
 is declared. When changing the major ABI version, the release notes will detail
 all ABI changes.
 
-.. _figure_abi_stability_policy:
 
 .. figure:: img/abi_stability_policy.*
 
diff --git a/doc/guides/contributing/cheatsheet.rst b/doc/guides/contributing/cheatsheet.rst
index 0debd118d7..4b353d2d01 100644
--- a/doc/guides/contributing/cheatsheet.rst
+++ b/doc/guides/contributing/cheatsheet.rst
@@ -4,7 +4,6 @@
 Patch Cheatsheet
 ================
 
-.. _figure_patch_cheatsheet:
 
 .. figure:: img/patch_cheatsheet.*
 
diff --git a/doc/guides/contributing/patches.rst b/doc/guides/contributing/patches.rst
index 069a18e4ec..663881a59b 100644
--- a/doc/guides/contributing/patches.rst
+++ b/doc/guides/contributing/patches.rst
@@ -452,7 +452,6 @@ For example::
      since 802.1AS can be supported through the same interfaces.
 
 
-.. _contrib_checkpatch:
 
 Checking the Patches
 --------------------
diff --git a/doc/guides/cryptodevs/qat.rst b/doc/guides/cryptodevs/qat.rst
index 68d792e4cc..d1c71ce89f 100644
--- a/doc/guides/cryptodevs/qat.rst
+++ b/doc/guides/cryptodevs/qat.rst
@@ -227,7 +227,6 @@ Configuring and Building the DPDK QAT PMDs
 Further information on configuring, building and installing DPDK is described
 :doc:`here <../linux_gsg/build_dpdk>`.
 
-.. _building_qat_config:
 
 Build Configuration
 ~~~~~~~~~~~~~~~~~~~
diff --git a/doc/guides/howto/flow_bifurcation.rst b/doc/guides/howto/flow_bifurcation.rst
index 5d2127bc31..3a3a779ad0 100644
--- a/doc/guides/howto/flow_bifurcation.rst
+++ b/doc/guides/howto/flow_bifurcation.rst
@@ -36,7 +36,6 @@ the kernel driver while a DPDK application can receive specific traffic
 bypassing the Linux kernel by using drivers like VFIO or the DPDK ``igb_uio``
 module.
 
-.. _figure_flow_bifurcation_overview:
 
 .. figure:: img/flow_bifurcation_overview.*
 
diff --git a/doc/guides/howto/lm_bond_virtio_sriov.rst b/doc/guides/howto/lm_bond_virtio_sriov.rst
index 1d46ebb27f..7fd54e8d91 100644
--- a/doc/guides/howto/lm_bond_virtio_sriov.rst
+++ b/doc/guides/howto/lm_bond_virtio_sriov.rst
@@ -40,7 +40,6 @@ The ip address of host_server_1 is 10.237.212.46
 
 The ip address of host_server_2 is 10.237.212.131
 
-.. _figure_lm_bond_virtio_sriov:
 
 .. figure:: img/lm_bond_virtio_sriov.*
 
diff --git a/doc/guides/howto/lm_virtio_vhost_user.rst b/doc/guides/howto/lm_virtio_vhost_user.rst
index 94ab71d653..63cfb84bf0 100644
--- a/doc/guides/howto/lm_virtio_vhost_user.rst
+++ b/doc/guides/howto/lm_virtio_vhost_user.rst
@@ -32,7 +32,6 @@ The ip address of host_server_1 is 10.237.212.46
 
 The ip address of host_server_2 is 10.237.212.131
 
-.. _figure_lm_vhost_user:
 
 .. figure:: img/lm_vhost_user.*
 
diff --git a/doc/guides/howto/pvp_reference_benchmark.rst b/doc/guides/howto/pvp_reference_benchmark.rst
index bec97b8675..6d2616e404 100644
--- a/doc/guides/howto/pvp_reference_benchmark.rst
+++ b/doc/guides/howto/pvp_reference_benchmark.rst
@@ -20,7 +20,6 @@ v16.11 using RHEL7 for both host and guest.
 Setup overview
 --------------
 
-.. _figure_pvp_2nics:
 
 .. figure:: img/pvp_2nics.*
 
diff --git a/doc/guides/linux_gsg/build_dpdk.rst b/doc/guides/linux_gsg/build_dpdk.rst
index 2a983412dd..8d2b1708b8 100644
--- a/doc/guides/linux_gsg/build_dpdk.rst
+++ b/doc/guides/linux_gsg/build_dpdk.rst
@@ -82,7 +82,6 @@ and the last step causing the dynamic loader `ld.so` to update its cache to take
    distributions, `/usr/local/lib` and `/usr/local/lib64` should be added
    to a file in `/etc/ld.so.conf.d/` before running `ldconfig`.
 
-.. _adjusting_build_options:
 
 Adjusting Build Options
 ~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/doc/guides/nics/bnx2x.rst b/doc/guides/nics/bnx2x.rst
index c24d32b9ab..fad62d2d52 100644
--- a/doc/guides/nics/bnx2x.rst
+++ b/doc/guides/nics/bnx2x.rst
@@ -99,7 +99,6 @@ enabling debugging options may affect system performance.
 
   Toggle display of register reads and writes.
 
-.. _bnx2x_driver-compilation:
 
 Driver compilation and testing
 ------------------------------
diff --git a/doc/guides/nics/enic.rst b/doc/guides/nics/enic.rst
index a400bbc4f7..77578b4913 100644
--- a/doc/guides/nics/enic.rst
+++ b/doc/guides/nics/enic.rst
@@ -219,7 +219,6 @@ There are two known limitations of the current SR-IOV implementation.
    and assign them to VMs as passthrough devices.
 
 
-.. _enic-generic-flow-api:
 
 Generic Flow API support
 ------------------------
@@ -279,8 +278,6 @@ the (stripped) VLAN header whether stripping is enabled or disabled.
 More features may be added in future firmware and new versions of the VIC.
 Please refer to the release notes.
 
-.. _overlay_offload:
-
 Overlay Offload
 ---------------
 
@@ -429,7 +426,6 @@ To verify the selected entry size, enable debug logging
     PMD: rte_enic_pmd: Supported CQ entry sizes: 16 32
     PMD: rte_enic_pmd: Using 16B CQ entry size
 
-.. _enic_limitations:
 
 Limitations
 -----------
diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
index 7e9ba23102..7056d9709f 100644
--- a/doc/guides/nics/ice.rst
+++ b/doc/guides/nics/ice.rst
@@ -557,7 +557,6 @@ Additional Options
 
     -a 18:01.0,cap=dcf,acl=off
 
-.. _figure_ice_dcf:
 
 .. figure:: img/ice_dcf.*
 
diff --git a/doc/guides/nics/rnp.rst b/doc/guides/nics/rnp.rst
index 706cd04fa7..c4504e26f2 100644
--- a/doc/guides/nics/rnp.rst
+++ b/doc/guides/nics/rnp.rst
@@ -32,7 +32,6 @@ Chip Basic Overview
 N10 has two functions, each function support multiple ports (1 to 8),
 which is different of normal PCIe network card (one PF for each port).
 
-.. _figure_mucse_nic:
 
 .. figure:: img/mucse_nic_port.*
 
diff --git a/doc/guides/nics/virtio.rst b/doc/guides/nics/virtio.rst
index a7642d96ce..588ac41464 100644
--- a/doc/guides/nics/virtio.rst
+++ b/doc/guides/nics/virtio.rst
@@ -93,7 +93,6 @@ The following prerequisites apply:
 Virtio with qemu virtio Back End
 --------------------------------
 
-.. _figure_host_vm_comms_qemu:
 
 .. figure:: img/host_vm_comms_qemu.*
 
diff --git a/doc/guides/nics/vmxnet3.rst b/doc/guides/nics/vmxnet3.rst
index 3f498b905d..b3de27c36c 100644
--- a/doc/guides/nics/vmxnet3.rst
+++ b/doc/guides/nics/vmxnet3.rst
@@ -110,7 +110,6 @@ The following prerequisites apply:
 *   Before starting a VM, a VMXNET3 interface to a VM through VMware vSphere Client must be assigned.
     This is shown in the figure below.
 
-.. _figure_vmxnet3_int:
 
 .. figure:: img/vmxnet3_int.*
 
@@ -135,7 +134,6 @@ VMXNET3 with a Native NIC Connected to a vSwitch
 
 This section describes an example setup for Phy-vSwitch-VM-Phy communication.
 
-.. _figure_vswitch_vm:
 
 .. figure:: img/vswitch_vm.*
 
@@ -162,7 +160,6 @@ VMXNET3 Chaining VMs Connected to a vSwitch
 
 The following figure shows an example VM-to-VM communication over a Phy-VM-vSwitch-VM-Phy communication channel.
 
-.. _figure_vm_vm_comms:
 
 .. figure:: img/vm_vm_comms.*
 
diff --git a/doc/guides/prog_guide/dmadev.rst b/doc/guides/prog_guide/dmadev.rst
index 67a62ff420..6860515292 100644
--- a/doc/guides/prog_guide/dmadev.rst
+++ b/doc/guides/prog_guide/dmadev.rst
@@ -17,7 +17,6 @@ physical (hardware) and virtual (software) DMA devices, as well as a generic DMA
 API which allows DMA devices to be managed and configured, and supports DMA
 operations to be provisioned on DMA poll mode driver.
 
-.. _figure_dmadev:
 
 .. figure:: img/dmadev.*
 
diff --git a/doc/guides/prog_guide/efd_lib.rst b/doc/guides/prog_guide/efd_lib.rst
index 68404d5f33..f91fd1c80a 100644
--- a/doc/guides/prog_guide/efd_lib.rst
+++ b/doc/guides/prog_guide/efd_lib.rst
@@ -155,7 +155,6 @@ In summary, EFD is a set separation data structure that supports millions of
 keys. It is used to distribute a given key to an intended target. By itself
 EFD is not a FIB data structure with an exact match the input flow key.
 
-.. _Efd_example:
 
 Example of EFD Library Usage
 ----------------------------
@@ -199,7 +198,6 @@ the flows served at each node is used and is
 exact matched with the input key to rule out new never seen before
 flows.
 
-.. _Efd_api:
 
 Library API Overview
 --------------------
@@ -281,7 +279,6 @@ in the prev_value argument.
    This function is not multi-thread safe and should only be called
    from one thread.
 
-.. _Efd_internals:
 
 Library Internals
 -----------------
@@ -414,7 +411,6 @@ balanced key distribution across these four is selected the mapping result
 is stored in these two bits.
 
 
-.. _Efd_references:
 
 References
 -----------
diff --git a/doc/guides/prog_guide/env_abstraction_layer.rst b/doc/guides/prog_guide/env_abstraction_layer.rst
index d716895c1d..ce97d8551f 100644
--- a/doc/guides/prog_guide/env_abstraction_layer.rst
+++ b/doc/guides/prog_guide/env_abstraction_layer.rst
@@ -52,7 +52,6 @@ A check is also performed at initialization time to ensure that the micro archit
 Then, the main() function is called. The core initialization and launch is done in rte_eal_init() (see the API documentation).
 It consist of calls to the pthread library (more specifically, pthread_self(), pthread_create(), and pthread_setaffinity_np()).
 
-.. _figure_linux_launch:
 
 .. figure:: img/linuxapp_launch.*
 
@@ -1039,7 +1038,6 @@ The key fields of the heap structure and their function are described below
 
 *   last - this points to the last element in the heap.
 
-.. _figure_malloc_heap:
 
 .. figure:: img/malloc_heap.*
 
diff --git a/doc/guides/prog_guide/ethdev/qos_framework.rst b/doc/guides/prog_guide/ethdev/qos_framework.rst
index 1144037dfa..9d26e0478a 100644
--- a/doc/guides/prog_guide/ethdev/qos_framework.rst
+++ b/doc/guides/prog_guide/ethdev/qos_framework.rst
@@ -11,7 +11,6 @@ Packet Pipeline with QoS Support
 
 An example of a complex packet processing pipeline with QoS support is shown in the following figure.
 
-.. _figure_pkt_proc_pipeline_qos:
 
 .. figure:: ../img/pkt_proc_pipeline_qos.*
 
@@ -112,7 +111,6 @@ It typically acts like a buffer that is able to temporarily store a large number
 as the NIC TX is requesting more packets for transmission,
 these packets are later on removed and handed over to the NIC TX with the packet selection logic observing the predefined SLAs (dequeue operation).
 
-.. _figure_hier_sched_blk:
 
 .. figure:: ../img/hier_sched_blk.*
 
@@ -269,7 +267,6 @@ Internal Data Structures per Port
 
 A schematic of the internal data structures in shown in with details in.
 
-.. _figure_data_struct_per_port:
 
 .. figure:: ../img/data_struct_per_port.*
 
@@ -452,7 +449,6 @@ The dequeue pipe state machine exploits the data presence into the processor cac
 therefore it tries to send as many packets from the same pipe TC and pipe as possible (up to the available packets and credits) before
 moving to the next active TC from the same pipe (if any) or to another active pipe.
 
-.. _figure_pipe_prefetch_sm:
 
 .. figure:: ../img/pipe_prefetch_sm.*
 
diff --git a/doc/guides/prog_guide/eventdev/event_crypto_adapter.rst b/doc/guides/prog_guide/eventdev/event_crypto_adapter.rst
index e2481904b1..568280c0ee 100644
--- a/doc/guides/prog_guide/eventdev/event_crypto_adapter.rst
+++ b/doc/guides/prog_guide/eventdev/event_crypto_adapter.rst
@@ -45,7 +45,6 @@ In this mode, events dequeued from the adapter will be treated as new events.
 The application needs to specify event information (response information)
 which is needed to enqueue an event after the crypto operation is completed.
 
-.. _figure_event_crypto_adapter_op_new:
 
 .. figure:: ../img/event_crypto_adapter_op_new.*
 
@@ -72,7 +71,6 @@ to enqueue a crypto operation in addition to the event information (response
 information) needed to enqueue an event after the crypto operation has
 completed.
 
-.. _figure_event_crypto_adapter_op_forward:
 
 .. figure:: ../img/event_crypto_adapter_op_forward.*
 
diff --git a/doc/guides/prog_guide/eventdev/event_dma_adapter.rst b/doc/guides/prog_guide/eventdev/event_dma_adapter.rst
index e040d89e8b..2deda67c80 100644
--- a/doc/guides/prog_guide/eventdev/event_dma_adapter.rst
+++ b/doc/guides/prog_guide/eventdev/event_dma_adapter.rst
@@ -45,7 +45,6 @@ In this mode, events dequeued from the adapter are treated as new events.
 The application has to specify event information (response information)
 which is needed to enqueue an event after the DMA operation is completed.
 
-.. _figure_event_dma_adapter_op_new:
 
 .. figure:: ../img/event_dma_adapter_op_new.*
 
@@ -75,7 +74,6 @@ In this mode, events dequeued from the adapter will be treated as forwarded even
 Application has to specify event information (response information)
 needed to enqueue the event after the DMA operation has completed.
 
-.. _figure_event_dma_adapter_op_forward:
 
 .. figure:: ../img/event_dma_adapter_op_forward.*
 
diff --git a/doc/guides/prog_guide/eventdev/eventdev.rst b/doc/guides/prog_guide/eventdev/eventdev.rst
index 5e49db8983..82d0124480 100644
--- a/doc/guides/prog_guide/eventdev/eventdev.rst
+++ b/doc/guides/prog_guide/eventdev/eventdev.rst
@@ -167,7 +167,6 @@ illustration, refer to Eventdev Adapter documentation for further details.
 The diagram below shows the final state of the application after this
 walk-through:
 
-.. _figure_eventdev-usage1:
 
 .. figure:: ../img/eventdev_usage.*
 
diff --git a/doc/guides/prog_guide/graph_lib.rst b/doc/guides/prog_guide/graph_lib.rst
index 8409e7666e..1d9c747e06 100644
--- a/doc/guides/prog_guide/graph_lib.rst
+++ b/doc/guides/prog_guide/graph_lib.rst
@@ -58,7 +58,6 @@ Programming model
 Anatomy of Node:
 ~~~~~~~~~~~~~~~~
 
-.. _figure_anatomy_of_a_node:
 
 .. figure:: img/anatomy_of_a_node.*
 
@@ -146,7 +145,6 @@ Node creation and registration
 
 Link the Nodes to create the graph topology
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-.. _figure_link_the_nodes:
 
 .. figure:: img/link_the_nodes.*
 
@@ -387,7 +385,6 @@ Example of intermediate node implementation with home run:
 
 Graph object memory layout
 --------------------------
-.. _figure_graph_mem_layout:
 
 .. figure:: img/graph_mem_layout.*
 
@@ -931,7 +928,6 @@ Inbuilt Nodes
 DPDK provides a set of nodes for data processing.
 The following diagram depicts inbuilt nodes data flow.
 
-.. _figure_graph_inbuit_node_flow:
 
 .. figure:: img/graph_inbuilt_node_flow.*
 
diff --git a/doc/guides/prog_guide/member_lib.rst b/doc/guides/prog_guide/member_lib.rst
index d2f76de35c..d21cf8563c 100644
--- a/doc/guides/prog_guide/member_lib.rst
+++ b/doc/guides/prog_guide/member_lib.rst
@@ -39,7 +39,6 @@ reduce space requirement and significantly improve the performance of set
 membership queries at the cost of introducing a very small membership test error
 probability.
 
-.. _figure_membership1:
 .. figure:: img/member_i1.*
 
   Example Usages of Membership Library
@@ -109,7 +108,6 @@ Y is a member of the set with certain false positive probability. As shown in
 the next equation, the false positive probability can be made arbitrarily small
 by changing the number of hash functions (``k``) and the vector length (``m``).
 
-.. _figure_membership2:
 .. figure:: img/member_i2.*
 
   Bloom Filter False Positive Probability
@@ -121,7 +119,6 @@ small bit-vector, which can be easily optimized. Hence the lookup throughput
 (set membership test) can be significantly faster than a normal hash table
 lookup with element comparison.
 
-.. _figure_membership3:
 .. figure:: img/member_i3.*
 
   Detecting Routing Loops Using BF
@@ -135,7 +132,6 @@ if the BF indicates that the current node is definitely not in the set then a
 loop-free route is guaranteed.
 
 
-.. _figure_membership4:
 .. figure:: img/member_i4.*
 
   Vector Bloom Filter (vBF) Overview
@@ -149,7 +145,6 @@ them. The basic idea of vBF is shown in the above figure where an element is
 used to address multiple bloom filters concurrently and the bloom filter
 index(es) with a hit is returned.
 
-.. _figure_membership5:
 .. figure:: img/member_i5.*
 
   vBF for Flow Scheduling to Worker Thread
@@ -184,7 +179,6 @@ requires testing a series of Bloom Filters each corresponding to one set.
 As a result, generally speaking vBF is more adequate for the case of a small limited number of sets
 while HTSS should be used with a larger number of sets.
 
-.. _figure_membership6:
 .. figure:: img/member_i6.*
 
   Using HTSS for Attack Signature Matching
@@ -237,7 +231,6 @@ set-summary. It is worth noting that the set-summary still has false positive
 probability, which means the application either can tolerate certain false positive
 or it has fall-back path when false positive happens.
 
-.. _figure_membership7:
 .. figure:: img/member_i7.*
 
   Using HTSS with False Negatives for Wild Card Classification
diff --git a/doc/guides/prog_guide/mldev.rst b/doc/guides/prog_guide/mldev.rst
index 61661b998b..4887fd0caf 100644
--- a/doc/guides/prog_guide/mldev.rst
+++ b/doc/guides/prog_guide/mldev.rst
@@ -12,7 +12,6 @@ The ML model creation and training is outside of the scope of this library.
 
 The ML framework is built on the following model:
 
-.. _figure_mldev_work_flow:
 
 .. figure:: img/mldev_flow.*
 
diff --git a/doc/guides/prog_guide/multi_proc_support.rst b/doc/guides/prog_guide/multi_proc_support.rst
index a73918a5da..2108832342 100644
--- a/doc/guides/prog_guide/multi_proc_support.rst
+++ b/doc/guides/prog_guide/multi_proc_support.rst
@@ -65,7 +65,6 @@ and point to the same objects, in both processes.
     ``--single-file-segments`` switch, secondary processes must be run with the
     same switch specified. Otherwise, memory corruption may occur.
 
-.. _figure_multi_process_memory:
 
 .. figure:: img/multi_process_memory.*
 
diff --git a/doc/guides/prog_guide/overview.rst b/doc/guides/prog_guide/overview.rst
index c70023e8a1..942576707f 100644
--- a/doc/guides/prog_guide/overview.rst
+++ b/doc/guides/prog_guide/overview.rst
@@ -86,7 +86,6 @@ Core Components
 The *core components* are a set of libraries that provide all the elements needed
 for high-performance packet processing applications.
 
-.. _figure_architecture-overview:
 
 .. figure:: img/architecture-overview.*
 
diff --git a/doc/guides/prog_guide/packet_framework.rst b/doc/guides/prog_guide/packet_framework.rst
index 17010b07dc..9de922444b 100644
--- a/doc/guides/prog_guide/packet_framework.rst
+++ b/doc/guides/prog_guide/packet_framework.rst
@@ -885,7 +885,6 @@ and detail the bucket search pipeline used to implement 8-byte and 16-byte key h
 either with pre-computed signature or "do-sig").
 For each pipeline stage, the described operations are applied to each of the two packets handled by that stage.
 
-.. _figure_figure39:
 
 .. figure:: img/figure39.*
 
diff --git a/doc/guides/prog_guide/pdcp_lib.rst b/doc/guides/prog_guide/pdcp_lib.rst
index 266abb8574..235e84aebc 100644
--- a/doc/guides/prog_guide/pdcp_lib.rst
+++ b/doc/guides/prog_guide/pdcp_lib.rst
@@ -21,7 +21,6 @@ PDCP would involve the following operations:
 #. Uplink data compression
 #. Ciphering and integrity protection
 
-.. _figure_pdcp_functional_overview:
 
 .. figure:: img/pdcp_functional_overview.*
 
diff --git a/doc/guides/prog_guide/ring_lib.rst b/doc/guides/prog_guide/ring_lib.rst
index 98ef003aac..a95ff4ab95 100644
--- a/doc/guides/prog_guide/ring_lib.rst
+++ b/doc/guides/prog_guide/ring_lib.rst
@@ -45,7 +45,6 @@ The disadvantages:
 
 A simplified representation of a Ring is shown in with consumer and producer head and tail pointers to objects stored in the data structure.
 
-.. _figure_ring1:
 
 .. figure:: img/ring1.*
 
@@ -113,7 +112,6 @@ The prod_next local variable points to the next element of the table, or several
 If there is not enough room in the ring (this is detected by checking cons_tail), it returns an error.
 
 
-.. _figure_ring-enqueue1:
 
 .. figure:: img/ring-enqueue1.*
 
@@ -128,7 +126,6 @@ The second step is to modify *ring->prod_head* in ring structure to point to the
 The added object is copied in the ring (obj4).
 
 
-.. _figure_ring-enqueue2:
 
 .. figure:: img/ring-enqueue2.*
 
@@ -142,7 +139,6 @@ Once the object is added in the ring, ring->prod_tail in the ring structure is m
 The enqueue operation is finished.
 
 
-.. _figure_ring-enqueue3:
 
 .. figure:: img/ring-enqueue3.*
 
@@ -166,7 +162,6 @@ The cons_next local variable points to the next element of the table, or several
 If there are not enough objects in the ring (this is detected by checking prod_tail), it returns an error.
 
 
-.. _figure_ring-dequeue1:
 
 .. figure:: img/ring-dequeue1.*
 
@@ -181,7 +176,6 @@ The second step is to modify ring->cons_head in the ring structure to point to t
 The dequeued object (obj1) is copied in the pointer given by the user.
 
 
-.. _figure_ring-dequeue2:
 
 .. figure:: img/ring-dequeue2.*
 
@@ -195,7 +189,6 @@ Finally, ring->cons_tail in the ring structure is modified to point to the same
 The dequeue operation is finished.
 
 
-.. _figure_ring-dequeue3:
 
 .. figure:: img/ring-dequeue3.*
 
@@ -220,7 +213,6 @@ or several elements after in the case of bulk enqueue.
 If there is not enough room in the ring (this is detected by checking cons_tail), it returns an error.
 
 
-.. _figure_ring-mp-enqueue1:
 
 .. figure:: img/ring-mp-enqueue1.*
 
@@ -242,7 +234,6 @@ This operation is done using a Compare And Swap (CAS) instruction, which does th
 In the figure, the operation succeeded on core 1, and step one restarted on core 2.
 
 
-.. _figure_ring-mp-enqueue2:
 
 .. figure:: img/ring-mp-enqueue2.*
 
@@ -257,7 +248,6 @@ The CAS operation is retried on core 2 with success.
 The core 1 updates one element of the ring(obj4), and the core 2 updates another one (obj5).
 
 
-.. _figure_ring-mp-enqueue3:
 
 .. figure:: img/ring-mp-enqueue3.*
 
@@ -272,7 +262,6 @@ A core can only update it if ring->prod_tail is equal to the prod_head local var
 This is only true on core 1. The operation is finished on core 1.
 
 
-.. _figure_ring-mp-enqueue4:
 
 .. figure:: img/ring-mp-enqueue4.*
 
@@ -286,7 +275,6 @@ Once ring->prod_tail is updated by core 1, core 2 is allowed to update it too.
 The operation is also finished on core 2.
 
 
-.. _figure_ring-mp-enqueue5:
 
 .. figure:: img/ring-mp-enqueue5.*
 
@@ -311,7 +299,6 @@ The following are two examples that help to explain how indexes are used in a ri
     as opposed to unsigned 32-bit integers in the more realistic case.
 
 
-.. _figure_ring-modulo1:
 
 .. figure:: img/ring-modulo1.*
 
@@ -321,7 +308,6 @@ The following are two examples that help to explain how indexes are used in a ri
 This ring contains 11000 entries.
 
 
-.. _figure_ring-modulo2:
 
 .. figure:: img/ring-modulo2.*
 
@@ -536,7 +522,6 @@ On that picture ``obj5`` and ``obj4`` elements are acquired by stage 0,
 ``obj2`` and ``obj3`` are acquired by stage 1,
 while ``obj1`` was already released by stage 1 and is ready to be consumed.
 
-.. _figure_soring1:
 
 .. figure:: img/soring-pic1.*
 
diff --git a/doc/guides/rel_notes/release_20_02.rst b/doc/guides/rel_notes/release_20_02.rst
index 925985b4f8..c207381f3d 100644
--- a/doc/guides/rel_notes/release_20_02.rst
+++ b/doc/guides/rel_notes/release_20_02.rst
@@ -230,7 +230,6 @@ API Changes
 * No change in this release.
 
 
-.. _20_02_abi_changes:
 
 ABI Changes
 -----------
diff --git a/doc/guides/sample_app_ug/dist_app.rst b/doc/guides/sample_app_ug/dist_app.rst
index 30b4184d40..8fc260e5b8 100644
--- a/doc/guides/sample_app_ug/dist_app.rst
+++ b/doc/guides/sample_app_ug/dist_app.rst
@@ -22,7 +22,6 @@ into each other.
 This application can be used to benchmark performance using the traffic
 generator as shown in the figure below.
 
-.. _figure_dist_perf:
 
 .. figure:: img/dist_perf.*
 
diff --git a/doc/guides/sample_app_ug/l2_forward_crypto.rst b/doc/guides/sample_app_ug/l2_forward_crypto.rst
index ba38d9f22e..e4c3022763 100644
--- a/doc/guides/sample_app_ug/l2_forward_crypto.rst
+++ b/doc/guides/sample_app_ug/l2_forward_crypto.rst
@@ -193,7 +193,6 @@ on a packet received on an RX PORT before forwarding it to a TX PORT.
 The following figure illustrates a sample flow of a packet in the application,
 from reception until transmission.
 
-.. _figure_l2_fwd_encrypt_flow:
 
 .. figure:: img/l2_fwd_encrypt_flow.*
 
diff --git a/doc/guides/sample_app_ug/l3_forward.rst b/doc/guides/sample_app_ug/l3_forward.rst
index 9b0d0350aa..71d5342f77 100644
--- a/doc/guides/sample_app_ug/l3_forward.rst
+++ b/doc/guides/sample_app_ug/l3_forward.rst
@@ -282,7 +282,6 @@ R<destination_ip><source_ip><destination_port><source_port><protocol><output_por
 
 *   A typical IPv4 ACL rule line should have a format as shown below:
 
-.. _figure_ipv4_acl_rule:
 
 .. figure:: img/ipv4_acl_rule.*
 
diff --git a/doc/guides/sample_app_ug/multi_process.rst b/doc/guides/sample_app_ug/multi_process.rst
index 1bd858bfb5..444a86eb67 100644
--- a/doc/guides/sample_app_ug/multi_process.rst
+++ b/doc/guides/sample_app_ug/multi_process.rst
@@ -127,7 +127,6 @@ The symmetric multi process example demonstrates how a set of processes can run
 with each process performing the same set of packet- processing operations.
 The following diagram shows the data-flow through the application, using two processes.
 
-.. _figure_sym_multi_proc_app:
 
 .. figure:: img/sym_multi_proc_app.*
 
@@ -208,7 +207,6 @@ by sending each packet out on a different network port.
 
 The following diagram shows the data-flow through the application, using two client processes.
 
-.. _figure_client_svr_sym_multi_proc_app:
 
 .. figure:: img/client_svr_sym_multi_proc_app.*
 
diff --git a/doc/guides/sample_app_ug/ptpclient.rst b/doc/guides/sample_app_ug/ptpclient.rst
index 0df465bcb4..87e82b8695 100644
--- a/doc/guides/sample_app_ug/ptpclient.rst
+++ b/doc/guides/sample_app_ug/ptpclient.rst
@@ -30,7 +30,6 @@ In order to keep the application simple the following assumptions are made:
 How the Application Works
 -------------------------
 
-.. _figure_ptpclient_highlevel:
 
 .. figure:: img/ptpclient.*
 
diff --git a/doc/guides/sample_app_ug/qos_scheduler.rst b/doc/guides/sample_app_ug/qos_scheduler.rst
index cd33beecb0..be7e78cc71 100644
--- a/doc/guides/sample_app_ug/qos_scheduler.rst
+++ b/doc/guides/sample_app_ug/qos_scheduler.rst
@@ -11,7 +11,6 @@ Overview
 
 The architecture of the QoS scheduler application is shown in the following figure.
 
-.. _figure_qos_sched_app_arch:
 
 .. figure:: img/qos_sched_app_arch.*
 
diff --git a/doc/guides/sample_app_ug/test_pipeline.rst b/doc/guides/sample_app_ug/test_pipeline.rst
index 818be93cd6..24f1f870e9 100644
--- a/doc/guides/sample_app_ug/test_pipeline.rst
+++ b/doc/guides/sample_app_ug/test_pipeline.rst
@@ -22,7 +22,6 @@ The application uses three CPU cores:
 
 *   Core C ("TX core") receives traffic from core B through software queues and sends it to the NIC ports for transmission.
 
-.. _figure_test_pipeline_app:
 
 .. figure:: img/test_pipeline_app.*
 
diff --git a/doc/guides/sample_app_ug/vm_power_management.rst b/doc/guides/sample_app_ug/vm_power_management.rst
index 1955140bb3..62d70c053a 100644
--- a/doc/guides/sample_app_ug/vm_power_management.rst
+++ b/doc/guides/sample_app_ug/vm_power_management.rst
@@ -54,7 +54,6 @@ directs frequency changes and policies to the host monitor rather than
 the APCI ``cpufreq`` ``sysfs`` interface used on the host in non-virtualised
 environments.
 
-.. _figure_vm_power_mgr_highlevel:
 
 .. figure:: img/vm_power_mgr_highlevel.*
 
@@ -109,7 +108,6 @@ receiving a request, the host translates the vCPU to a pCPU using the
 libvirt API before forwarding it to the host ``librte_power``.
 
 
-.. _figure_vm_power_mgr_vm_request_seq:
 
 .. figure:: img/vm_power_mgr_vm_request_seq.*
 
diff --git a/doc/guides/tools/dts.rst b/doc/guides/tools/dts.rst
index 016dc5e374..0bb8da3e46 100644
--- a/doc/guides/tools/dts.rst
+++ b/doc/guides/tools/dts.rst
@@ -526,7 +526,6 @@ The output is generated in ``build/doc/api/dts/html``.
 
    Make sure to fix any Sphinx warnings when adding or updating docstrings.
 
-.. _configuration_example:
 
 Configuration Example
 ---------------------
diff --git a/doc/guides/tools/graph.rst b/doc/guides/tools/graph.rst
index 0ffd29e41f..062062f68d 100644
--- a/doc/guides/tools/graph.rst
+++ b/doc/guides/tools/graph.rst
@@ -365,13 +365,11 @@ This section mentions the created graph for each use case.
 l3fwd
 ~~~~~
 
-.. _figure_l3fwd_graph:
 
 .. figure:: img/graph-usecase-l3fwd.*
 
 l2fwd
 ~~~~~
 
-.. _figure_l2fwd_graph:
 
 .. figure:: img/graph-usecase-l2fwd.*
diff --git a/doc/guides/tools/testeventdev.rst b/doc/guides/tools/testeventdev.rst
index cd367eb2a2..526a7b12c7 100644
--- a/doc/guides/tools/testeventdev.rst
+++ b/doc/guides/tools/testeventdev.rst
@@ -282,7 +282,6 @@ This is a functional test case that aims at testing the following:
    |   |              |                | port n                 |
    +---+--------------+----------------+------------------------+
 
-.. _figure_eventdev_order_queue_test:
 
 .. figure:: img/eventdev_order_queue_test.*
 
@@ -365,7 +364,6 @@ but differs in two critical ways:
    |   |              |                | port n.                   |
    +---+--------------+----------------+---------------------------+
 
-.. _figure_eventdev_atomic_queue_test:
 
 .. figure:: img/eventdev_atomic_queue_test.*
 
@@ -455,7 +453,6 @@ instead of two different queues for ordered and atomic.
    |   |              |                | port n.                |
    +---+--------------+----------------+------------------------+
 
-.. _figure_eventdev_order_atq_test:
 
 .. figure:: img/eventdev_order_atq_test.*
 
@@ -519,7 +516,6 @@ instead of two different atomic queues.
    |   |              |                | port n.                 |
    +---+--------------+----------------+-------------------------+
 
-.. _figure_eventdev_atomic_atq_test:
 
 .. figure:: img/eventdev_atomic_atq_test.*
 
@@ -582,7 +578,6 @@ This is a performance test case that aims at testing the following:
    |   |              | nb_producers   | Producers use port n to port p          |
    +---+--------------+----------------+-----------------------------------------+
 
-.. _figure_eventdev_perf_queue_test:
 
 .. figure:: img/eventdev_perf_queue_test.*
 
@@ -720,7 +715,6 @@ This is a performance test case that aims at testing the following with
    |   |              | nb_producers   | Producers use port n to port p          |
    +---+--------------+----------------+-----------------------------------------+
 
-.. _figure_eventdev_perf_atq_test:
 
 .. figure:: img/eventdev_perf_atq_test.*
 
@@ -833,11 +827,9 @@ This is a pipeline test case that aims at testing the following:
    |   |              |                | depending on the Tx adapter capability. |
    +---+--------------+----------------+-----------------------------------------+
 
-.. _figure_eventdev_pipeline_queue_test_generic:
 
 .. figure:: img/eventdev_pipeline_queue_test_generic.*
 
-.. _figure_eventdev_pipeline_queue_test_internal_port:
 
 .. figure:: img/eventdev_pipeline_queue_test_internal_port.*
 
@@ -962,11 +954,9 @@ This is a pipeline test case that aims at testing the following with
    |   |              |                | depending on the Tx adapter capability. |
    +---+--------------+----------------+-----------------------------------------+
 
-.. _figure_eventdev_pipeline_atq_test_generic:
 
 .. figure:: img/eventdev_pipeline_atq_test_generic.*
 
-.. _figure_eventdev_pipeline_atq_test_internal_port:
 
 .. figure:: img/eventdev_pipeline_atq_test_internal_port.*
 
diff --git a/doc/guides/tools/testmldev.rst b/doc/guides/tools/testmldev.rst
index e3182c960f..578a1f02e5 100644
--- a/doc/guides/tools/testmldev.rst
+++ b/doc/guides/tools/testmldev.rst
@@ -209,7 +209,6 @@ when handling with `N` number of models.
 executes the sequence of load / start / stop / unload for a model in order,
 followed by next model.
 
-.. _figure_mldev_model_ops_subtest_a:
 
 .. figure:: img/mldev_model_ops_subtest_a.*
 
@@ -219,7 +218,6 @@ followed by next model.
 executes load for all models, followed by a start for all models.
 Upon successful start of all models, stop is invoked for all models followed by unload.
 
-.. _figure_mldev_model_ops_subtest_b:
 
 .. figure:: img/mldev_model_ops_subtest_b.*
 
@@ -229,7 +227,6 @@ Upon successful start of all models, stop is invoked for all models followed by
 loads all models, followed by a start and stop of all models in order.
 Upon completion of stop, unload is invoked for all models.
 
-.. _figure_mldev_model_ops_subtest_c:
 
 .. figure:: img/mldev_model_ops_subtest_c.*
 
@@ -239,7 +236,6 @@ Upon completion of stop, unload is invoked for all models.
 executes load and start for all models available.
 Upon successful start of all models, stop is executed for the models.
 
-.. _figure_mldev_model_ops_subtest_d:
 
 .. figure:: img/mldev_model_ops_subtest_d.*
 
@@ -334,7 +330,6 @@ The model is unloaded upon completion of all inferences for the model.
 The test would continue loading and executing inference requests for all models
 specified through ``filelist`` option in an ordered manner.
 
-.. _figure_mldev_inference_ordered:
 
 .. figure:: img/mldev_inference_ordered.*
 
@@ -390,7 +385,6 @@ Total number of inferences enqueued for a model are equal to the repetitions spe
 An additional pool of threads would dequeue the inferences from the device.
 Models would be unloaded upon completion of inferences for all models loaded.
 
-.. _figure_mldev_inference_interleave:
 
 .. figure:: img/mldev_inference_interleave.*
 
-- 
2.51.0

