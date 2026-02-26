Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B591FCE07D
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 13:30:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B616040647;
	Thu, 26 Feb 2026 14:30:14 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id A26EA4021F
 for <dev@dpdk.org>; Thu, 26 Feb 2026 14:30:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772112613; x=1803648613;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=uTujVNBkKZ3uqtDYK7kzG3uS3BYCdDU9yrDwitxHfSM=;
 b=NlsZpzE4GMfBfHWyS9L4+YLkaVhWc/7dt7vk5WW8h4UIpViXLtpHgEdW
 pTcZvt3AtfS/Z1PRgjpv5Deeoh30mI/Y2PxH7zQWabBhZZcAz3s09UkRc
 UCvIvXoWWoSddRYjiR8EgW3EDsgrOJvZyBxw4mG5Q1WfrY2nL19zyTSVt
 P1H4C+cfgHXm2L1TZ50FOmjV1MnDBQoV4w+TdM05AH9ysAtWaGVh9a8dv
 6b+Zmr40oq37wuE9HJ/InfhmQgRmW36S872uBjaeHxSwWf53nvy8ZIDaJ
 LgO0diVUr8RXL4SULLHpNVff1k4mKvqXGEdnSJ7u3TXXuCELm3oU3tTbG Q==;
X-CSE-ConnectionGUID: zwYtqMM/QieRnQAF2RM1sQ==
X-CSE-MsgGUID: 8lyknrK5TG+E37Ftx0ez5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="73146385"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="73146385"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 05:30:12 -0800
X-CSE-ConnectionGUID: nZ6XQhheQfyXXS8oB5cvAQ==
X-CSE-MsgGUID: xAhbmu9tTwuPdEkd5iTRUg==
X-ExtLoop1: 1
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa003.fm.intel.com with ESMTP; 26 Feb 2026 05:30:11 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v4 2/2] doc: add device hotplug documentation
Date: Thu, 26 Feb 2026 13:30:08 +0000
Message-ID: <aded6fabee0c70416df4d9eeca571a544e97fc96.1772112599.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <17532da36934963d943f54de17c2d0d24dbfe8a2.1772112599.git.anatoly.burakov@intel.com>
References: 
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

Currently, device hotplug is not documented except in API headers. Add
documentation for device hotplug, both for user facing side of it, and a
high level overview of its internal workings.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---

Notes:
    v2:
    - Removed "summary" section

 doc/guides/prog_guide/dev_args.rst       |   3 +
 doc/guides/prog_guide/device_hotplug.rst | 316 +++++++++++++++++++++++
 doc/guides/prog_guide/index.rst          |   1 +
 3 files changed, 320 insertions(+)
 create mode 100644 doc/guides/prog_guide/device_hotplug.rst

diff --git a/doc/guides/prog_guide/dev_args.rst b/doc/guides/prog_guide/dev_args.rst
index 4585095354..e06c364afe 100644
--- a/doc/guides/prog_guide/dev_args.rst
+++ b/doc/guides/prog_guide/dev_args.rst
@@ -182,6 +182,8 @@ Devargs are used with hotplug APIs to attach devices dynamically:
        /* Handle error */
    }
 
+See :doc:`device_hotplug` for detailed information on runtime device management.
+
 Parsing Devargs in Drivers
 ---------------------------
 
@@ -246,5 +248,6 @@ DPDK provides iterator helpers that accept devargs-style filters for device enum
 For more information, see:
 
 * :doc:`../linux_gsg/linux_eal_parameters` - EAL command-line parameters
+* :doc:`device_hotplug` - Runtime device management
 * API documentation: ``rte_devargs_parse()``, ``rte_devargs_layers_parse()`` (in ``rte_devargs.h``)
 * API documentation: ``rte_eth_devargs_parse()`` (in ``ethdev_driver.h``)
diff --git a/doc/guides/prog_guide/device_hotplug.rst b/doc/guides/prog_guide/device_hotplug.rst
new file mode 100644
index 0000000000..34b66cf740
--- /dev/null
+++ b/doc/guides/prog_guide/device_hotplug.rst
@@ -0,0 +1,316 @@
+..  SPDX-License-Identifier: BSD-3-Clause
+    Copyright(c) 2026 Intel Corporation.
+
+.. _device_hotplug:
+
+Device Hotplug
+==============
+
+Introduction
+------------
+
+Device hotplug refers to the ability to attach and detach devices at runtime, after the initial EAL initialization has completed (i.e., ``rte_eal_init()`` has returned successfully).
+This feature allows applications to dynamically add or remove physical or virtual devices while the DPDK application is running.
+
+.. note::
+   On platforms other than Linux, neither multiprocess operations nor hotplug notifications are supported.
+
+
+Basic Usage
+-----------
+
+The primary interface for device hotplug is through two complementary functions: ``rte_dev_probe()`` to attach a device using a devargs string, and ``rte_dev_remove()`` to detach a device.
+For detailed information about device argument format and syntax, see :doc:`dev_args`.
+
+A typical workflow for attaching a device is:
+
+.. code-block:: c
+
+   /* Probe a PCI device with specific parameters */
+   ret = rte_dev_probe("0000:02:00.0,arg1=value1");
+   if (ret < 0) {
+       /* Handle error */
+   }
+
+   /* Later, find the device and remove it */
+   struct rte_device *dev = /* find device */;
+   ret = rte_dev_remove(dev);
+
+For convenience, DPDK also provides ``rte_eal_hotplug_add()`` and ``rte_eal_hotplug_remove()`` functions, which accept separate bus name, device name, and arguments instead of a combined devargs string:
+
+.. code-block:: c
+
+   /* Attach a virtual device */
+   rte_eal_hotplug_add("vdev", "net_ring0", "");
+
+   /* Remove by bus and device name */
+   rte_eal_hotplug_remove("vdev", "net_ring0");
+
+
+Device Lifecycle Example
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+The ``testpmd`` application provides a reference implementation of device hotplug through the ``port attach`` and ``port detach`` commands, demonstrating proper device lifecycle management.
+
+The following example demonstrates attaching a virtual ring PMD Ethernet device, configuring it, and then detaching it:
+
+.. code-block:: c
+
+   char *devargs = "net_ring0";
+   struct rte_eth_dev_info info;
+   struct rte_dev_iterator iterator;
+   uint16_t port_id;
+   int ret;
+
+   /* Probe the device */
+   ret = rte_dev_probe(devargs);
+   if (ret < 0) {
+      /* Handle error */
+      return ret;
+   }
+
+   /* Enumerate newly attached ports */
+   RTE_ETH_FOREACH_MATCHING_DEV(port_id, devargs, &iterator) {
+      /* Get device handle */
+      rte_eth_dev_info_get(port_id, &info);
+
+      /* Set up the device and use it */
+   }
+
+   /* Stop the port */
+   rte_eth_dev_stop(port_id);
+
+   /* Remove the device */
+   ret = rte_dev_remove(info.device);
+
+The key steps in this lifecycle are:
+
+1. **Attach**: Call ``rte_dev_probe()`` with the device identifier
+2. **Find the device**: Use device iterators (such as ``RTE_ETH_FOREACH_MATCHING_DEV()``) to find the newly attached port
+3. **Configure and use**: Configure the port using normal device configuration/start flow
+4. **Detach**: Stop the device before calling ``rte_dev_remove()``
+
+
+Device Events
+-------------
+
+In addition to the hotplug APIs described above, EAL also offers a device event infrastructure.
+
+.. warning::
+   Because all events are always delivered within the context of an interrupt thread, attempting any memory allocations/deallocations within that context may cause deadlocks.
+   Therefore, it is recommended to set up a deferred application resource allocation/cleanup with ``rte_eal_alarm_set()`` API or otherwise trigger allocation/cleanup of application resources in another context.
+
+Ethernet Device Events
+~~~~~~~~~~~~~~~~~~~~~~
+
+When new Ethernet devices are added (hot plugged using device probe API) to EAL or removed (hot unplugged using device remove API) from EAL, the following events are delivered:
+
+* ``RTE_ETH_EVENT_NEW`` - delivered after device probe
+* ``RTE_ETH_EVENT_DESTROY`` - delivered after device removal
+
+The user may subscribe to these events using ``rte_eth_dev_callback_register()`` function.
+
+
+Kernel Device Events
+~~~~~~~~~~~~~~~~~~~~
+
+EAL may also subscribe to generic device events delivered from kernel uevent infrastructure. The following events are delivered:
+
+* ``RTE_DEV_EVENT_ADD`` - delivered whenever a new device becomes available for probing
+* ``RTE_DEV_EVENT_REMOVE`` - delivered whenever a device becomes unavailable (device failure, hot unplug, etc.)
+
+.. note::
+   Kernel device event monitoring is only supported on Linux.
+
+The kernel event monitoring is not enabled by default, so before using this feature the user must do the following:
+
+* Call ``rte_dev_hotplug_handle_enable()`` to enable ``SIGBUS`` handling in EAL for devices that were hot-unplugged
+* Call ``rte_dev_event_monitor_start()`` to enable kernel device event monitoring
+
+The user may then subscribe to kernel device events using ``rte_dev_event_callback_register()`` function.
+
+.. note::
+   Currently, for ``RTE_DEV_EVENT_ADD``, only PCI devices are monitored
+
+.. note::
+   The ``RTE_DEV_EVENT_ADD`` by itself does not probe the device, it is only a notification that the application may use ``rte_dev_probe()`` on the device in question.
+   When ``RTE_DEV_EVENT_REMOVE`` event is delivered, it indicates that the kernel has removed the device; the application should call ``rte_dev_remove()`` to clean up EAL resources.
+
+
+Event Notification Usage
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+Example generic device event callback with deferred probe:
+
+.. code-block:: c
+
+   void
+   deferred_attach(void *arg)
+   {
+       const char *devname = (const char *)arg;
+       rte_dev_probe(devname);
+       /* match strdup with free */
+       free(devname);
+   }
+
+   void
+   device_event_callback(const char *device_name,
+                         enum rte_dev_event_type event,
+                         void *cb_arg)
+   {
+       if (event == RTE_DEV_EVENT_ADD) {
+           /* Schedule deferred attach - don't call rte_dev_probe() here! */
+           char *devname = strdup(device_name);
+           if (rte_eal_alarm_set(1, deferred_attach, devname) < 0) {
+               /* error */
+           }
+       } else if (event == RTE_DEV_EVENT_REMOVE) {
+           /* Handle device removal - schedule cleanup if needed */
+       }
+   }
+
+   rte_dev_event_callback_register(NULL, device_event_callback, user_arg);  /* NULL = all devices */
+
+
+Implementation Details
+======================
+
+.. note::
+   The sections below describe the internal architecture and implementation of device hotplug.
+   This information is primarily intended for contributors and developers working on DPDK internals and/or drivers.
+
+Attach and Detach
+-----------------
+
+When ``rte_dev_probe()`` is called, the following sequence occurs:
+
+1. **Devargs Parsing**:
+   The devargs string is parsed to extract the bus name, device name, and driver arguments, which are stored in an ``rte_devargs`` structure and inserted into the global devargs list.
+
+2. **Bus Scan**:
+   The appropriate bus driver's ``scan()`` method is invoked, causing the bus to search for the device.
+   For PCI devices, this may involve scanning the sysfs filesystem, while for virtual devices, this may create the device structure directly.
+
+3. **Device Discovery**:
+   After scanning, the bus's ``find_device()`` method locates the device by name, and the attach operation fails if the device is not found.
+
+4. **Device Probe**:
+   The bus's ``plug()`` method is called, which triggers the device driver's probe function.
+   The probe function typically allocates device-specific resources, maps device memory regions, initializes device hardware, and registers the device with the appropriate subsystem (e.g., ethdev for network devices).
+
+5. **Multi-process Synchronization**:
+   If successful in the primary process, an IPC message is sent to all secondary processes to attach the same device.
+   See `Multi-process Synchronization`_ for details.
+
+
+When ``rte_dev_remove()`` is called, the following sequence occurs:
+
+1. **Device Validation**:
+   The function verifies that the device is currently probed using ``rte_dev_is_probed()``.
+
+2. **Multi-process Coordination**:
+   In multi-process scenarios, the primary process first coordinates with all secondary processes to detach the device, and only if all secondaries successfully detach does the primary proceed.
+   See `Multi-process Synchronization`_ for details.
+
+3. **Device Unplug**:
+   The bus's ``unplug()`` method is called (``dev->bus->unplug()``), which triggers the driver's remove function.
+   This typically stops device operations, releases device resources, unmaps memory regions, and unregisters from subsystems.
+
+4. **Devargs Cleanup**:
+   The devargs associated with the device are removed from the global list.
+
+
+Multi-process Synchronization
+-----------------------------
+
+DPDK's hotplug implementation ensures that devices are attached or detached consistently across all processes in a multi-process deployment.
+Both primary and secondary processes can initiate hotplug operations (by calling ``rte_dev_probe()`` or ``rte_dev_remove()``), which will be synchronized across all processes.
+
+.. note::
+   Multiprocess operations are only supported on Linux
+
+**When Application Initiates from Primary**:
+
+1. Primary performs the local operation
+2. Primary broadcasts the request to all secondaries using IPC
+3. Primary waits for replies from all secondaries with a timeout
+4. If all secondaries succeed, the operation is complete
+5. If any secondary fails, primary initiates rollback
+
+**When Application Initiates from Secondary**:
+
+1. Secondary sends attach/detach request to primary via IPC
+2. Primary receives the request and performs the local operation
+3. Primary broadcasts the request to all other secondaries
+4. Primary waits for replies from all secondaries
+5. If all succeed, primary sends success reply to the requesting secondary
+6. If any fail, primary initiates rollback and sends failure reply to the requesting secondary
+
+**Secondary Process Flow** (when receiving request from primary):
+
+1. Secondary receives IPC request from primary
+2. Secondary performs the local attach/detach operation
+3. Secondary sends reply with success or failure status
+
+Rollback on Failure
+~~~~~~~~~~~~~~~~~~~
+
+If any step in the attach or detach process fails in a multi-process scenario, DPDK attempts to rollback the operation.
+For attach failures, the primary process sends rollback requests to detach the device from all secondary processes where it succeeded.
+For detach failures, the primary process sends rollback requests to all secondary processes to re-attach the device, restoring the previous state.
+
+Virtual Devices and Multi-process
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Virtual devices have special handling in multi-process scenarios.
+
+During initial startup, when a secondary process starts, it sends a scan request to the primary process via IPC, and the primary responds by sending the list of all virtual devices it has created.
+This synchronization happens during the bus scan phase.
+Unlike physical devices where both processes can independently discover hardware, virtual devices only exist in memory, so secondaries must obtain the device list from the primary.
+
+At runtime, virtual devices can be hotplugged from either primary or secondary processes using the standard hotplug flow described above, and will be synchronized across all processes.
+Note that secondary processes can specify virtual devices via ``--vdev`` on the command line during initialization, which creates process-local devices, but runtime hotplug operations using ``rte_dev_probe()`` always synchronize devices across all processes.
+
+
+Kernel Uevent Handling (Linux only)
+-----------------------------------
+
+DPDK's device event monitoring works by listening to Linux kernel uevents via a netlink socket. The application must explicitly start monitoring by calling ``rte_dev_event_monitor_start()``.
+When ``rte_dev_event_monitor_start()`` is called, DPDK creates a ``NETLINK_KOBJECT_UEVENT`` socket that receives notifications from the kernel about device state changes.
+
+Uevent Flow
+~~~~~~~~~~~
+
+The flow from hardware event to application notification follows this path:
+
+1. **Hardware Event**: When a device is physically added or removed, the kernel detects the change (e.g., PCI hotplug event).
+
+2. **Kernel Uevent Generation**: The Linux kernel generates a uevent and broadcasts it via netlink to all listening processes.
+   User-space tools like ``udev`` or ``systemd-udevd`` typically listen to these events to perform system-level actions such as creating device nodes in ``/dev``, loading kernel modules, or changing permissions.
+
+3. **DPDK Netlink Reception**: DPDK's netlink socket receives the same uevent notifications in parallel with udev/systemd.
+   This allows DPDK to react to device changes independently of system-level device management.
+
+4. **Application Callback**: DPDK parses the uevent and invokes registered application callbacks, allowing the application to handle the device change.
+
+The mechanism works as follows:
+
+1. **Netlink Socket Creation**: DPDK creates a netlink socket bound to receive all kernel kobject uevents.
+2. **Uevent Reception**: When a device is added or removed, the Linux kernel broadcasts a uevent message containing:
+   - ``ACTION=add`` or ``ACTION=remove``
+   - ``SUBSYSTEM=pci``, ``uio``, or ``vfio``
+   - ``PCI_SLOT_NAME=<device>`` (e.g., ``0000:02:00.0``)
+3. **Event Parsing**: DPDK parses these messages to extract the device name, action type, and subsystem, then invokes registered application callbacks.
+4. **Interrupt-driven**: The socket is registered with DPDK's interrupt framework, so uevent handling is asynchronous and doesn't require polling.
+
+This infrastructure only monitors physical devices managed by the kernel. Virtual devices created by DPDK do not generate kernel uevents.
+
+.. note::
+   Some device types use alternative notification mechanisms.
+   For example, Mellanox NICs using the ``mlx4`` or ``mlx5`` PMDs may receive hotplug notifications through InfiniBand verbs events rather than kernel uevents, as these devices are managed by the IB subsystem in addition to the network stack.
+
+SIGBUS Handling
+---------------
+
+If the application attempts to access memory-mapped device registers after the device is removed, a ``SIGBUS`` signal may be generated.
+The ``rte_dev_hotplug_handle_enable()`` function registers a signal handler that identifies which device caused the fault using the faulting address, invokes the bus's signal handler to handle the error, and allows the application to continue rather than crashing.
diff --git a/doc/guides/prog_guide/index.rst b/doc/guides/prog_guide/index.rst
index aacb67c125..8fabb41c1b 100644
--- a/doc/guides/prog_guide/index.rst
+++ b/doc/guides/prog_guide/index.rst
@@ -75,6 +75,7 @@ Device Libraries
 
     ethdev/index
     dev_args
+    device_hotplug
     link_bonding_poll_mode_drv_lib
     vhost_lib
     cryptodev_lib
-- 
2.47.3

