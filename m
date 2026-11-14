Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2651606A881
	for <dpdk-dev@archiver.kernel.org>; Sat, 14 Nov 2026 01:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZsvJ7vN6
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3C2AC427DF;
	Sat, 14 Nov 2026 02:44:21 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTPS id 5028A427D9;
 Sat, 14 Nov 2026 02:44:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794620660; x=1826156660;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pGzL8iYQDkS0BgbeuVSvegCZWvF5i/R87yFhJzX55Jg=;
 b=ZsvJ7vN6JW1XfdumI6U/8p9XHEZetUqEkZP+y24pmkvlClEIbGaQlI5x
 kCIa0STtKTuyRZ+k+84MMqWswXp3pF7xH6A2yPl4m3NLG7GaqjQKe/JM3
 h+437OF7g7AXq/cgvGAk7Qb9hZ8U7z1Fsq+KUpDVoD+EWqVrkt51nSVmb
 8j5dhdAIGxaQwc3nGwPRgHx5o26qBzJphMvDEjNXHLMWbRAPkpQ/zemOB
 EepaHyRJhNaW2znM57Tet/9Yon1MFZVoA3RZT63h69Ij/nUkL2E0+/bYM
 BOyU8cU93cAxk1ywxxQft5CwwNawVbBQqGsOA3TrnGp2hkedDfv0pTc4e w==;
X-CSE-ConnectionGUID: jq0hXL51TySdt1xedSlI6A==
X-CSE-MsgGUID: P1uOVehhScWSEYqJes+fBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3325939"
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="3325939"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 17:44:19 -0800
X-CSE-ConnectionGUID: QDQu5e1XT7i9DDhUzAljkA==
X-CSE-MsgGUID: vZcBmVJmTGSTvcd8G5QX4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; d="scan'208";a="10969992"
Received: from pae-31.iind.intel.com ([10.49.105.68])
 by fmviesa013.fm.intel.com with ESMTP; 13 Nov 2026 17:44:17 -0800
From: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 vladimir.medvedkin@intel.com, brian.johnson@intel.com,
 Sandeep Penigalapati <sandeep.penigalapati@intel.com>, stable@dpdk.org
Subject: [PATCH v3 4/4] doc: fix intel VF guide
Date: Sat, 14 Nov 2026 08:46:19 +0000
Message-Id: <20261114084619.190251-5-sandeep.penigalapati@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261114084619.190251-1-sandeep.penigalapati@intel.com>
References: <20261114075732.183996-1-sandeep.penigalapati@intel.com>
 <20261114084619.190251-1-sandeep.penigalapati@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	DATE_IN_FUTURE_06_12,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Correct several errors in the Intel VF guide:

- correct the kernel module file names in the insmod examples
  (fm10k.ko, ixgbe.ko, igb.ko).
- correct the qemu-system-x86_64 command name.
- correct the "8 TX and 8 RX queues" description.
- correct the rss_lut_vf_attr sysfs attribute name.
- minor spacing and hyphenation fixes (SR-IOV).

Fixes: fc1f2750a3ec ("doc: programmers guide")
Fixes: 48624fd96e7c ("doc: remove Intel references from prog guide")
Fixes: a49ae04e853f ("doc: update fm10k prog guide")
Fixes: 627edcef93dd ("doc: explain how to create large VFs for iavf")
Cc: stable@dpdk.org

Signed-off-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
---
 doc/guides/nics/intel_vf.rst | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/doc/guides/nics/intel_vf.rst b/doc/guides/nics/intel_vf.rst
index 0d715cc048..51e1f49607 100644
--- a/doc/guides/nics/intel_vf.rst
+++ b/doc/guides/nics/intel_vf.rst
@@ -10,7 +10,7 @@ Supported Intel® Ethernet Controllers (see the *DPDK Release Notes* for details
 support the following modes of operation in a virtualized environment:
 
 *   **SR-IOV mode**: Involves direct assignment of part of the port resources to different guest operating systems
-    using the PCI-SIG Single Root I/O Virtualization (SR IOV) standard,
+    using the PCI-SIG Single Root I/O Virtualization (SR-IOV) standard,
     also known as "native mode" or "pass-through" mode.
     In this chapter, this mode is referred to as IOV mode.
 
@@ -157,7 +157,7 @@ Intel\ |reg| E800 Series Ethernet devices:
 
 * When using the Intel out-of-tree "ice" PF/kernel driver v1.13.7 or later,
   to create VFs with >16 queues (aka. "large VFs"),
-  it is necessary to change the rss_lut_vf_addr setting in sysfs from the default of 64 to 512.
+  it is necessary to change the ``rss_lut_vf_attr`` setting in sysfs from the default of 64 to 512.
   This can be done using the following command for the first VF on an interface:
   ``echo 512 > /sys/class/net/<PF interface>/device/virtfn0/rss_lut_vf_attr``
 
@@ -177,7 +177,7 @@ For example,
     .. code-block:: console
 
         rmmod fm10k (To remove the fm10k module)
-        insmod fm0k.ko max_vfs=2,2 (To enable two Virtual Functions per port)
+        insmod fm10k.ko max_vfs=2,2 (To enable two Virtual Functions per port)
 
 Virtual Function enumeration is performed in the following sequence by the Linux* pci driver for a dual-port NIC.
 When you enable the four Virtual Functions with the above command, the four enabled functions have a Function#
@@ -250,7 +250,7 @@ For example,
     .. code-block:: console
 
         rmmod ixgbe (To remove the ixgbe module)
-        insmod ixgbe max_vfs=2,2 (To enable two Virtual Functions per port)
+        insmod ixgbe.ko max_vfs=2,2 (To enable two Virtual Functions per port)
 
 *   Using the DPDK PMD PF ixgbe driver, bind the PF device to ``vfio_pci`` or ``igb_uio`` and
     create VF devices. See :ref:`linux_gsg_binding_kernel`.
@@ -318,7 +318,7 @@ A pool is a group of queue pairs for assignment to the same VF, used for transmi
 The controller has eight pools, with each pool containing two queue pairs, that is, two TX and two RX queues assigned to each VF.
 
 In a virtualized environment, an Intel® Ethernet Controller I350 family device serves up to eight virtual machines (VMs) per port.
-The eight queues can be accessed by eight different VMs if configured correctly (the i350 has 4x1GbE ports each with 8T X and 8 RX queues),
+The eight queues can be accessed by eight different VMs if configured correctly (the i350 has 4x1GbE ports each with 8 TX and 8 RX queues),
 that means, one Transmit and one Receive queue assigned to each VF.
 
 For example,
@@ -328,7 +328,7 @@ For example,
     .. code-block:: console
 
         rmmod igb (To remove the igb module)
-        insmod igb max_vfs=2,2 (To enable two Virtual Functions per port)
+        insmod igb.ko max_vfs=2,2 (To enable two Virtual Functions per port)
 
 *   Using the DPDK PMD PF igb driver, bind the PF device to ``vfio_pci`` or ``igb_uio`` and
     create VF devices. See :ref:`linux_gsg_binding_kernel`.
@@ -361,11 +361,11 @@ Validated Hypervisors
 
 The validated hypervisor is:
 
-*   KVM (Kernel Virtual Machine) with  Qemu, version 0.14.0
+*   KVM (Kernel Virtual Machine) with Qemu, version 0.14.0
 
 However, the hypervisor is bypassed to configure the Virtual Function devices using the Mailbox interface,
 the solution is hypervisor-agnostic.
-Xen* and VMware* (when SR- IOV is supported) will also be able to support the DPDK with Virtual Function driver support.
+Xen* and VMware* (when SR-IOV is supported) will also be able to support the DPDK with Virtual Function driver support.
 
 Expected Guest Operating System in Virtual Machine
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -571,7 +571,7 @@ The setup procedure is as follows:
 .. note::
 
     If you are unable to compile the DPDK and you are getting "error: CPU you selected does not support x86-64 instruction set",
-    power off the Guest OS and start the virtual machine with the correct -cpu option in the qemu- system-x86_64 command as shown in step 9.
+    power off the Guest OS and start the virtual machine with the correct -cpu option in the qemu-system-x86_64 command as shown in step 9.
     You must select the best x86_64 cpu_model to emulate or you can select host option if available.
 
 .. note::
-- 
2.34.1

