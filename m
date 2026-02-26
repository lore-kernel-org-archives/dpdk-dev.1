Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE67FCE07D
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 13:30:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BFC0D4026F;
	Thu, 26 Feb 2026 14:30:13 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id E91994021F
 for <dev@dpdk.org>; Thu, 26 Feb 2026 14:30:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772112612; x=1803648612;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=NFb2sVuqJ8O1niXQ+RGUojIUv6BQj7ZkrFlcvc15s5Q=;
 b=XemYlEgRQVyGTslS2+2V8mUt8wIO6SB/yBOrhV5qG2equ4qrcQR5R22X
 us6i1Fhkr9nHrXhkKYSDwZpXXeCfH29gwX/gA5ktnZmCMgaBZ5aLP3Go3
 EZ/CNgAiLy51XiWnqBZP06Kv+iofL2XigI07mawbluR1/YL2beon1GWEE
 mI0xg385/dJbsujRK+2/Mt7cCnMydKqdr5ZPqF55OUr8Va4OlLw9UfmMt
 B83QrseBYWj9dyOQdiv4Qbbfp0ONTVFQbOdDZ1w39/Mlt7juNjZb2+0Rf
 jESC5GojdIYXpUx+i1hVCBMSr2pLSDAQsPPg3MRTfws6mQWyb0OgkeqA4 w==;
X-CSE-ConnectionGUID: +p4me7SwRcGTlarSShW69Q==
X-CSE-MsgGUID: sERTvG0HS9iHKXWy/E8j5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="73146383"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="73146383"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 05:30:11 -0800
X-CSE-ConnectionGUID: odB4hOKuSU2hsGgxXmHivA==
X-CSE-MsgGUID: cqAU/L7ORh+mxW1mfNEbaA==
X-ExtLoop1: 1
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa003.fm.intel.com with ESMTP; 26 Feb 2026 05:30:10 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v4 1/2] doc: add devargs documentation
Date: Thu, 26 Feb 2026 13:30:07 +0000
Message-ID: <17532da36934963d943f54de17c2d0d24dbfe8a2.1772112599.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <f9c79b16f3f90c3521acabdcaa96a9e61dca705b.1763122378.git.anatoly.burakov@intel.com>
References: <f9c79b16f3f90c3521acabdcaa96a9e61dca705b.1763122378.git.anatoly.burakov@intel.com>
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

Currently, the devargs syntax documentation is missing from the
programmer's guide, and is only documented implicitly through the devargs
API headers. Add a detailed description of the two supported devargs
syntaxes.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---

Notes:
    v2:
    - Made generic syntax the primary syntax
    - Removed summary
    - Moved index link to after ethdev/index

 doc/guides/prog_guide/dev_args.rst | 250 +++++++++++++++++++++++++++++
 doc/guides/prog_guide/index.rst    |   1 +
 2 files changed, 251 insertions(+)
 create mode 100644 doc/guides/prog_guide/dev_args.rst

diff --git a/doc/guides/prog_guide/dev_args.rst b/doc/guides/prog_guide/dev_args.rst
new file mode 100644
index 0000000000..4585095354
--- /dev/null
+++ b/doc/guides/prog_guide/dev_args.rst
@@ -0,0 +1,250 @@
+..  SPDX-License-Identifier: BSD-3-Clause
+    Copyright(c) 2026 Intel Corporation.
+
+.. _device_arguments:
+
+Device Arguments
+================
+
+Introduction
+------------
+
+Device arguments (devargs) provide a standardized way to specify and configure devices in DPDK applications.
+Devargs are used both during EAL initialization (via ``rte_eal_init()`` command-line options) and at runtime (via hotplug APIs) to identify devices and pass configuration parameters to them.
+
+A devargs string can specify identifiers and arguments at multiple levels:
+
+* **Bus identifier and arguments**: Which bus handles the device (e.g., ``pci``, ``vdev``) and bus-level parameters
+* **Class identifier and arguments**: Device class (e.g., ``eth``, ``crypto``) and class-level parameters
+* **Driver identifier and arguments**: The specific driver and its driver-specific parameters
+
+DPDK supports two devargs syntaxes:
+
+1. **Multi-layer syntax** - Generic syntax for device filtering by bus, class, or driver.
+2. **Simplified syntax** - Legacy simplified syntax.
+
+
+Devargs Syntax
+--------------
+
+Generic Syntax
+~~~~~~~~~~~~~~
+
+Generic devargs syntax is meant to cover all use cases supported by devargs infrastructure, such as passing arguments to various layers or matching multiple devices.
+The basic syntax format is as follows:
+
+.. code-block:: none
+
+   bus=<busname>,<bus_args>/class=<classname>,<class_args>/driver=<drvname>,<driver_args>
+
+This allows the user to specify:
+
+* ``bus`` layer: bus identifier, as well as bus-level arguments
+* ``class`` layer: class identifier, as well as class-level arguments
+* ``driver`` layer: driver identifier, as well as driver-specific parameters
+
+.. note::
+   By default, multi-layer syntax is driver-centric and will match all devices using a particular bus, class, and driver combination.
+   To target a specific device, provide a device-identifying argument to the bus layer. The specific key depends on the bus:
+   for PCI use ``addr=`` (e.g. ``bus=pci,addr=02:00.0``), for most other buses use ``name=`` (e.g. ``bus=vdev,name=net_ring0``).
+   As far as PCI BDFs go, the domain part (``0000:``) can be omitted if it is zero, so ``0000:02:00.0`` and ``02:00.0`` are equivalent.
+
+**Example**:
+
+.. code-block:: none
+
+   bus=pci/class=eth/driver=ice,representor=[0-3]
+
+The above example will pass "representor=[0-3]" devarg to each device matching the provided criteria (PCI bus, Ethernet class, in use by ``ice`` driver).
+
+.. code-block:: none
+
+   bus=pci,addr=02:00.0/driver=ice,representor=[0-3]
+
+The above example will pass "representor=[0-3]" devarg only to device corresponding to PCI address ``0000:02:00.0``, and only if it is managed by ``ice`` driver.
+
+Simplified syntax
+~~~~~~~~~~~~~~~~~
+
+In cases where the full syntax is not required, devargs can be used with simplified format that targets specific devices only:
+
+.. code-block:: none
+
+   [bus:]device_identifier[,arg1=val1,arg2=val2,...]
+
+Where:
+
+* ``bus:`` is an optional prefix specifying the bus name (pci, vdev, auxiliary, etc.)
+* ``device_identifier`` uniquely identifies the device on its bus
+* ``arg1=val1,arg2=val2,...`` are optional driver-specific configuration parameters
+
+The arguments are provided to the driver, but the driver name itself is inferred from the device and does not need to be specified.
+
+**Examples**:
+
+.. code-block:: none
+
+   0000:02:00.0                          # PCI device, no arguments
+   02:00.0,txq_inline=128                # PCI device with driver arguments
+   pci:0000:02:00.0                      # Explicit bus prefix
+   net_ring0                             # Virtual device
+   vdev:net_pcap0,rx_pcap=input.pcap     # Virtual device with arguments and bus prefix
+
+If the bus prefix is omitted, DPDK tries each registered bus in turn to see if it can recognize the device identifier.
+
+
+Virtual Device Arguments
+------------------------
+Virtual devices (vdevs) are software-based devices that don't correspond to physical hardware.
+Unlike PCI or other hardware buses where devices are discovered by scanning, virtual devices must be explicitly created by specifying their driver name.
+
+Understanding Virtual Device Naming
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+A virtual device name consists of:
+
+1. **Driver name**: The vdev driver to use (e.g., ``net_ring``, ``net_pcap``, ``crypto_null``)
+2. **Instance identifier**: A numeric suffix to create multiple instances of the same driver
+
+**Format**:
+
+.. code-block:: none
+
+   [vdev:]<driver_name><instance_number>[,arg=val,...]
+
+**Examples**:
+
+Create a ring-based virtual port:
+
+.. code-block:: none
+
+   net_ring0
+
+Create a PCAP virtual device with input file:
+
+.. code-block:: none
+
+   net_pcap0,rx_pcap=input.pcap
+
+
+Using Devargs in Applications
+------------------------------
+
+At EAL Initialization
+~~~~~~~~~~~~~~~~~~~~~
+
+Devargs can be specified on the command line when starting a DPDK application:
+
+**Allow-list (permit specific devices)**:
+
+.. code-block:: console
+
+   ./myapp -a 0000:02:00.0 -a 03:00.0,txq_inline=128
+
+**Block-list (exclude specific devices)**:
+
+.. code-block:: console
+
+   ./myapp -b 04:00.0
+
+**Virtual devices**:
+
+.. code-block:: console
+
+   ./myapp --vdev net_ring0 --vdev 'net_pcap0,rx_pcap=input.pcap'
+
+See :doc:`../linux_gsg/linux_eal_parameters` for complete EAL parameter documentation.
+
+At Runtime (Hotplug)
+~~~~~~~~~~~~~~~~~~~~
+
+Devargs are used with hotplug APIs to attach devices dynamically:
+
+.. code-block:: c
+
+   #include <rte_dev.h>
+
+   /* Attach a PCI device */
+   ret = rte_dev_probe("0000:05:00.0");
+   if (ret < 0) {
+       /* Handle error */
+   }
+
+   /* Attach a virtual device */
+   ret = rte_dev_probe("net_ring1");
+   if (ret < 0) {
+       /* Handle error */
+   }
+
+   /* Attach with arguments */
+   ret = rte_dev_probe("05:00.0,txq_inline=256");
+   if (ret < 0) {
+       /* Handle error */
+   }
+
+Parsing Devargs in Drivers
+---------------------------
+
+PMD drivers can parse devargs using the kvargs library:
+
+.. code-block:: c
+
+   #include <rte_kvargs.h>
+
+   static int
+   my_driver_parse_devargs(struct rte_devargs *devargs)
+   {
+       struct rte_kvargs *kvlist;
+       const char *valid_args[] = {"arg1", "arg2", NULL};
+
+       if (devargs == NULL || devargs->args == NULL)
+           return 0;
+
+       kvlist = rte_kvargs_parse(devargs->args, valid_args);
+       if (kvlist == NULL) {
+           RTE_LOG(ERR, PMD, "Failed to parse devargs\n");
+           return -EINVAL;
+       }
+
+       /* Process each argument */
+       rte_kvargs_process(kvlist, "arg1", my_arg1_handler, NULL);
+       rte_kvargs_process(kvlist, "arg2", my_arg2_handler, NULL);
+
+       rte_kvargs_free(kvlist);
+       return 0;
+   }
+
+For Ethernet devices, use ``rte_eth_devargs_parse()`` to parse standard Ethernet arguments like representors:
+
+.. code-block:: c
+
+   struct rte_eth_devargs eth_da[RTE_MAX_ETHPORTS];
+   int n_devargs;
+
+   n_devargs = rte_eth_devargs_parse(devargs_str, eth_da, RTE_MAX_ETHPORTS);
+   if (n_devargs < 0) {
+       /* Handle error */
+   }
+
+Finding Devices by Devargs
+--------------------------
+
+DPDK provides iterator helpers that accept devargs-style filters for device enumeration. Examples:
+
+.. code-block:: c
+
+   RTE_DEV_FOREACH(dev, "bus=pci", &it) {
+      /* Handle each PCI device */
+   }
+
+   /* Ethernet devices can also be filtered by class */
+   RTE_ETH_FOREACH_MATCHING_DEV(port_id, "class=eth,mac=00:11:22:33:44:55", &it) {
+      /* Handle each Ethernet device */
+   }
+
+
+For more information, see:
+
+* :doc:`../linux_gsg/linux_eal_parameters` - EAL command-line parameters
+* API documentation: ``rte_devargs_parse()``, ``rte_devargs_layers_parse()`` (in ``rte_devargs.h``)
+* API documentation: ``rte_eth_devargs_parse()`` (in ``ethdev_driver.h``)
diff --git a/doc/guides/prog_guide/index.rst b/doc/guides/prog_guide/index.rst
index c0b5f54c26..aacb67c125 100644
--- a/doc/guides/prog_guide/index.rst
+++ b/doc/guides/prog_guide/index.rst
@@ -74,6 +74,7 @@ Device Libraries
     :numbered:
 
     ethdev/index
+    dev_args
     link_bonding_poll_mode_drv_lib
     vhost_lib
     cryptodev_lib
-- 
2.47.3

