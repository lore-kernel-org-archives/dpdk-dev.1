Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF91ACE7AF9
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Nov 2025 12:13:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F21C402CA;
	Fri, 14 Nov 2025 13:13:14 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 9CE4340151
 for <dev@dpdk.org>; Fri, 14 Nov 2025 13:13:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763122393; x=1794658393;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=kmqjwJNciWJgGXSup861ugA+cy0wGujKitlJw/5kJiw=;
 b=REosCtj2iwfN2Ys9ku1VIGyPGWUUic6PTebDRv9TJvQWCAva52zT6x+W
 OyAB2bg5nKN/Uemr3WTNUvYqYhNol7c6i1AedFUGeFMd31aYUjxyixP72
 ZivA5tI4PpE123PZIinAQ6IQBIlDR1XMonrrHQ133JOX+EFC9WUfwF6WT
 IzKDhvlOlTpv4bAbdbSlmMGctSuLcgYXujOJsMuNDKWAOc4SFVzNHDfUX
 nW5rEoouULPyKwx76lrdKfZR+jQ333HRNSJqdd+AoG1kb2Qqjdm2tj4zv
 9JPvvYWZ29PKJmAF4VQkwoLz/2UwvEr3s2jiqKaJJbuU9RYg5DmD9nmrp Q==;
X-CSE-ConnectionGUID: wDK4cYsZQqqpz9vvqUvXkg==
X-CSE-MsgGUID: SlClP8OBT2iMedMQijKsMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="87861896"
X-IronPort-AV: E=Sophos;i="6.19,304,1754982000"; d="scan'208";a="87861896"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2025 04:13:12 -0800
X-CSE-ConnectionGUID: Jk+zqsxoRJera95lDwkEpw==
X-CSE-MsgGUID: iddrHL2YQJWtxhUQCmFrBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,304,1754982000"; d="scan'208";a="194915982"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa005.jf.intel.com with ESMTP; 14 Nov 2025 04:13:10 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 1/2] doc: add devargs documentation
Date: Fri, 14 Nov 2025 12:13:07 +0000
Message-ID: <f9c79b16f3f90c3521acabdcaa96a9e61dca705b.1763122378.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
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
 doc/guides/prog_guide/dev_args.rst | 243 +++++++++++++++++++++++++++++
 doc/guides/prog_guide/index.rst    |   1 +
 2 files changed, 244 insertions(+)
 create mode 100644 doc/guides/prog_guide/dev_args.rst

diff --git a/doc/guides/prog_guide/dev_args.rst b/doc/guides/prog_guide/dev_args.rst
new file mode 100644
index 0000000000..2997bcdbd3
--- /dev/null
+++ b/doc/guides/prog_guide/dev_args.rst
@@ -0,0 +1,243 @@
+..  SPDX-License-Identifier: BSD-3-Clause
+    Copyright(c) 2025 Intel Corporation.
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
+Devargs are used both at EAL initialization time (via command-line options) and at runtime (via hotplug APIs) to identify devices and pass configuration parameters to them.
+
+A devargs string can specify identifiers and arguments at multiple levels:
+
+* **Bus identifier and arguments**: Which bus handles the device (e.g., ``pci``, ``vdev``) and bus-level parameters
+* **Class identifier and arguments**: Device class (e.g., ``eth``, ``crypto``) and class-level parameters
+* **Driver identifier and arguments**: The specific driver and its driver-specific parameters
+
+DPDK supports two devargs syntaxes:
+
+1. **Simplified syntax** - For common case targeting a specific device.
+2. **Multi-layer syntax** - For device filtering by bus, class, or driver.
+
+
+Devargs Syntax
+--------------
+
+Device-centric syntax
+~~~~~~~~~~~~~~~~~~~~~
+
+In most cases, devargs can be used with simplified format that targets specific devices:
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
+   0000:02:00.0,txq_inline=128           # PCI device with driver arguments
+   pci:0000:02:00.0                      # Explicit bus prefix
+   net_ring0                             # Virtual device
+   vdev:net_pcap0,rx_pcap=input.pcap     # Virtual device with arguments and bus prefix
+
+If the bus prefix is omitted, DPDK tries each registered bus in turn to see if it can recognize the device identifier.
+
+
+Driver-centric Syntax
+~~~~~~~~~~~~~~~~~~~~~
+
+For advanced use cases that need to pass arguments to bus and/or class layers, or when matching multiple devices is required, DPDK supports a multi-layer syntax with three slash-separated segments:
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
+   By default, multi-layer syntax is driver-centric and will apply to all devices using a particular bus, class, and driver combination.
+   To target a specific device, a device-identifying argument should be provided to the bus layer. The specific key depends on the bus:
+   for PCI use ``addr=`` (e.g. ``bus=pci,addr=0000:02:00.0``), for most other buses use ``name=`` (e.g. ``bus=vdev,name=net_ring0``).
+
+**Example**:
+
+.. code-block:: none
+
+   bus=pci/class=eth/driver=ice,representor=[0-3]
+
+The above example will pass "representor=[0-3]" devarg to each device matching the provided criteria (PCI bus, Ethernet class, in use by ``ice`` driver).
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
+   ./myapp -a 0000:02:00.0 -a 0000:03:00.0,txq_inline=128
+
+**Block-list (exclude specific devices)**:
+
+.. code-block:: console
+
+   ./myapp -b 0000:04:00.0
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
+
+   /* Attach a virtual device */
+   ret = rte_dev_probe("net_ring1");
+
+   /* Attach with arguments */
+   ret = rte_dev_probe("0000:05:00.0,txq_inline=256");
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
+Iterator helpers accept a devargs-style filter. Examples:
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
+Summary
+-------
+
+Device arguments provide a flexible and standardized way to specify and configure devices in DPDK:
+
+* **Unified syntax**: Works across different bus types
+* **Runtime and initialization**: Can be used both at EAL init and for hotplug
+* **Driver configuration**: Supports arbitrary driver-specific parameters
+* **Complex specifications**: Multi-layer syntax allows device filtering and configuration at bus, class, and driver levels
+
+For more information, see:
+
+* :doc:`../linux_gsg/linux_eal_parameters` - EAL command-line parameters
+* API documentation: ``rte_devargs_parse()``, ``rte_devargs_layers_parse()`` (in ``rte_devargs.h``)
+* API documentation: ``rte_eth_devargs_parse()`` (in ``ethdev_driver.h``)
diff --git a/doc/guides/prog_guide/index.rst b/doc/guides/prog_guide/index.rst
index c0b5f54c26..866b7c5012 100644
--- a/doc/guides/prog_guide/index.rst
+++ b/doc/guides/prog_guide/index.rst
@@ -73,6 +73,7 @@ Device Libraries
     :maxdepth: 1
     :numbered:
 
+    dev_args
     ethdev/index
     link_bonding_poll_mode_drv_lib
     vhost_lib
-- 
2.47.3

