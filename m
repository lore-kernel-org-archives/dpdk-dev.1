Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4338C5B549
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Jun 2025 22:38:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 98E794028F;
	Tue,  3 Jun 2025 00:38:15 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id EB5B040281
 for <dev@dpdk.org>; Tue,  3 Jun 2025 00:38:13 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 898BE1424;
 Mon,  2 Jun 2025 15:37:56 -0700 (PDT)
Received: from ampere-altra-2-1.usa.arm.com (ampere-altra-2-1.usa.arm.com
 [10.118.91.158])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E25303F5A1;
 Mon,  2 Jun 2025 15:38:12 -0700 (PDT)
From: Wathsala Vithanage <wathsala.vithanage@arm.com>
To: 
Cc: dev@dpdk.org, nd@arm.com, Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: [PATCH v5 0/4] An API for Cache Stashing with TPH
Date: Mon,  2 Jun 2025 22:38:00 +0000
Message-ID: <20250602223805.816816-1-wathsala.vithanage@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241021015246.304431-1-wathsala.vithanage@arm.com>
References: <20241021015246.304431-1-wathsala.vithanage@arm.com>
MIME-Version: 1.0
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

Today, DPDK applications benefit from Direct Cache Access (DCA) features
like Intel DDIO and Arm's write-allocate-to-SLC. However, those features
do not allow fine-grained control of direct cache access, such as
stashing packets into upper-level caches (L2 caches) of a processor or
the shared cache of a chiplet. PCIe TLP Processing Hints (TPH) addresses
this need in a vendor-agnostic manner. TPH capability has existed since
PCI Express Base Specification revision 3.0; today, numerous Network
Interface Cards and interconnects from different vendors support TPH
capability. TPH comprises a steering tag (ST) and a processing hint
(PH). ST specifies the cache level of a CPU at which the data should be
written to (or DCAed into), while PH is a hint provided by the PCIe
requester to the completer on an upcoming traffic pattern. Some NIC
vendors bundle TPH capability with fine-grained control over the type of
objects that can be stashed into CPU caches, such as

- Rx/Tx queue descriptors
- Packet-headers
- Packet-payloads
- Data from a given offset from the start of a packet

Note that stashable object types are outside the scope of the PCIe
standard; therefore, vendors could support any combination of the above
items as they see fit.

To enable TPH and fine-grained packet stashing, this API extends the
ethdev library and the PCI bus driver. In this design, the application
provides hints to the PMD via the ethdev stashing API to indicate the
underlying hardware at which CPU and cache level it prefers a packet to
end up. Once the PMD receives a CPU and a cache-level combination (or a
list of such combinations), it must extract the matching ST from the PCI
bus driver for such combinations. The PCI bus driver implements the TPH
functions in an OS specific way; for Linux, it depends on the TPH
capabilities of the VFIO kernel driver.

An application uses the cache stashing ethdev API by first calling the
rte_eth_dev_stashing_capabilities_get() function to find out what object
types can be stashed into a CPU cache by the NIC out of the object types
in the bulleted list above. This function takes a port_id and a pointer
to a uint16_t to report back the object type flags. PMD implements the
stashing_capabilities_get function pointer in eth_dev_ops. If the
underlying platform or the NIC does not support TPH, this function
returns -ENOTSUP, and the application should consider any values stored
in the object invalid.

Once the application knows the supported object types that can be
stashed, the next step is to set the steering tags for the packets
associated with Rx and Tx queues via
rte_eth_dev_stashing_{rx,tx}_config_set() ethdev library functions. Both
functions have an identical signature, a port_id, a queue_id, and a
config object. The port_id and the queue_id are used to locate the
device and the queue. The config object is of type struct
rte_eth_stashing_config, which specifies the lcore_id and the
cache_level, indicating where objects from this queue should be stashed.
The 'objects' field in the config sets the types of objects the
application wishes to stash based on the capabilities found earlier.
Note that if the 'objects' field includes the flag
RTE_ETH_DEV_STASH_OBJECT_OFFSET, the 'offset' field must be used to set
the desired offset. These functions invoke PMD implementations of the
stashing functionality via the stashing_{rx,tx}_hints_set function
callbacks in the eth_dev_ops, respectively.

The PMD's implementation of the stashing_rx_hints_set() and
stashing_tx_hints_set() functions is ultimately responsible for
extracting the ST via the API provided by the PCI bus driver. Before
extracting STs, the PMD should enable the TPH capability in the endpoint
device by calling the rte_pci_tph_enable() function.  The application
begins the ST extraction process by calling the rte_pci_tph_st_get()
function in drivers/bus/pci/rte_bus_pci.h, which returns STs via the
same rte_tph_info objects array passed into it as an argument.  Once PMD
acquires ST, the stashing_{rx,tx}_hints_set callbacks implemented in the
PMD are ready to set the ST as per the rte_eth_stashing_config object
passed to them by the higher-level ethdev functions
ret_eth_dev_stashing_{rx,tx}_hints(). As per the PCIe specification, STs
can be placed on the MSI-X tables or in a device-specific location. For
PMDs, setting the STs on queue contexts is the only viable way of using
TPH. Therefore, the PMDs should only enable TPH in device-specific mode.

V4->V5:
 * Enable stashing-hints (TPH) in Intel i40e driver.
 * Update exported symbol version from 25.03 to 25.07.
 * Add TPH mode macros.

V3->V4:
 * Add VFIO IOCTL based ST extraction mechanism to Linux PCI bus driver
 * Remove ST extraction via direct access to ACPI _DSM
 * Replace rte_pci_extract_tph_st() with rte_pci_tph_st_get() in PCI
   bus driver.

Wathsala Vithanage (4):
  pci: add non-merged Linux uAPI changes
  bus/pci: introduce the PCIe TLP Processing Hints API
  ethdev: introduce the cache stashing hints API
  net/i40e: enable TPH in i40e

 drivers/bus/pci/bsd/pci.c            |  43 +++++++
 drivers/bus/pci/bus_pci_driver.h     |  52 ++++++++
 drivers/bus/pci/linux/pci.c          | 100 ++++++++++++++++
 drivers/bus/pci/linux/pci_init.h     |  14 +++
 drivers/bus/pci/linux/pci_vfio.c     | 170 +++++++++++++++++++++++++++
 drivers/bus/pci/private.h            |   8 ++
 drivers/bus/pci/rte_bus_pci.h        |  67 +++++++++++
 drivers/bus/pci/windows/pci.c        |  43 +++++++
 drivers/net/intel/i40e/i40e_ethdev.c | 127 ++++++++++++++++++++
 kernel/linux/uapi/linux/vfio_tph.h   | 102 ++++++++++++++++
 lib/ethdev/ethdev_driver.h           |  66 +++++++++++
 lib/ethdev/rte_ethdev.c              | 149 +++++++++++++++++++++++
 lib/ethdev/rte_ethdev.h              | 158 +++++++++++++++++++++++++
 lib/pci/rte_pci.h                    |  15 +++
 14 files changed, 1114 insertions(+)
 create mode 100644 kernel/linux/uapi/linux/vfio_tph.h

-- 
2.43.0

