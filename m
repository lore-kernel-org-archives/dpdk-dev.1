Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D242DD0D153
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Jan 2026 00:30:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B742D4028C;
	Thu,  8 Jan 2026 01:30:47 +0100 (CET)
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com
 [113.46.200.227])
 by mails.dpdk.org (Postfix) with ESMTP id 1A26E40261
 for <dev@dpdk.org>; Thu,  8 Jan 2026 01:30:45 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=mHw3BhxpiD7yXiwRlHn1X1wTdCEkoPFQk9fmXGzT84I=;
 b=yivbwE4i2LcSJw4J9HUthbP0CzsEssoKmEAoiuG+IuTpJ8HJT2al4uGdaUp3ADPumqIp+d2Du
 EpBSSN8297XiRFWPJUI7R5P6+sqWIgLW97r314Ns1VdLjtZMd+P+2OXDQ7CyChFI0JFuBW4N5zy
 xkLxX5kVHqYs0Y4Lu4Sf+ZI=
Received: from mail.maildlp.com (unknown [172.19.163.200])
 by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dmm2M47ltznTX0;
 Thu,  8 Jan 2026 08:27:39 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 76BD440566;
 Thu,  8 Jan 2026 08:30:43 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 8 Jan 2026 08:30:43 +0800
Message-ID: <3b0f9515-7088-4251-91dc-2b6c858e582b@huawei.com>
Date: Thu, 8 Jan 2026 08:30:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] An API for Cache Stashing with TPH
To: Wathsala Vithanage <wathsala.vithanage@arm.com>
CC: <dev@dpdk.org>, <nd@arm.com>
References: <20241021015246.304431-1-wathsala.vithanage@arm.com>
 <20250602223805.816816-1-wathsala.vithanage@arm.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20250602223805.816816-1-wathsala.vithanage@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemk500009.china.huawei.com (7.202.194.94)
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

Hi Wathsala,

Sorry to ask if this patchset is under development or stopped?

PCIe Steer-tag provides a mechanism for precise data stash, which
delivers a positive performance gain and is therefore a valuable
feature I think.

This patchset concludes with the statement: "the PMDs should only
enable TPH in device-specific mode", I don't think such restraints
should be made, the framework should be compatible with various
device capabilities:
1. The PCIe protocol defines two modes: one is the interrupt-vector
   mode, and the other is the device-specific mode. A device may
   choose to support either one or both.
2. If device support device-specific mode, it has a large degree of
   freedom to implement, such as locate ST table in self-defined
   place (just like '[PATCH v5 4/4] net/i40e: enable TPH in i40e'),
   and also support only stash part of data (e.g. only desc or header
   or even an offset data).
3. If device only support interrupt-vector mode (which each TLP will
   use ST from an ST table entry), we could also support it, in this
   framework, it could only report basic stash capability.

Thanks

On 6/3/2025 6:38 AM, Wathsala Vithanage wrote:
> Today, DPDK applications benefit from Direct Cache Access (DCA) features
> like Intel DDIO and Arm's write-allocate-to-SLC. However, those features
> do not allow fine-grained control of direct cache access, such as
> stashing packets into upper-level caches (L2 caches) of a processor or
> the shared cache of a chiplet. PCIe TLP Processing Hints (TPH) addresses
> this need in a vendor-agnostic manner. TPH capability has existed since
> PCI Express Base Specification revision 3.0; today, numerous Network
> Interface Cards and interconnects from different vendors support TPH
> capability. TPH comprises a steering tag (ST) and a processing hint
> (PH). ST specifies the cache level of a CPU at which the data should be
> written to (or DCAed into), while PH is a hint provided by the PCIe
> requester to the completer on an upcoming traffic pattern. Some NIC
> vendors bundle TPH capability with fine-grained control over the type of
> objects that can be stashed into CPU caches, such as
> 
> - Rx/Tx queue descriptors
> - Packet-headers
> - Packet-payloads
> - Data from a given offset from the start of a packet
> 
> Note that stashable object types are outside the scope of the PCIe
> standard; therefore, vendors could support any combination of the above
> items as they see fit.
> 
> To enable TPH and fine-grained packet stashing, this API extends the
> ethdev library and the PCI bus driver. In this design, the application
> provides hints to the PMD via the ethdev stashing API to indicate the
> underlying hardware at which CPU and cache level it prefers a packet to
> end up. Once the PMD receives a CPU and a cache-level combination (or a
> list of such combinations), it must extract the matching ST from the PCI
> bus driver for such combinations. The PCI bus driver implements the TPH
> functions in an OS specific way; for Linux, it depends on the TPH
> capabilities of the VFIO kernel driver.
> 
> An application uses the cache stashing ethdev API by first calling the
> rte_eth_dev_stashing_capabilities_get() function to find out what object
> types can be stashed into a CPU cache by the NIC out of the object types
> in the bulleted list above. This function takes a port_id and a pointer
> to a uint16_t to report back the object type flags. PMD implements the
> stashing_capabilities_get function pointer in eth_dev_ops. If the
> underlying platform or the NIC does not support TPH, this function
> returns -ENOTSUP, and the application should consider any values stored
> in the object invalid.
> 
> Once the application knows the supported object types that can be
> stashed, the next step is to set the steering tags for the packets
> associated with Rx and Tx queues via
> rte_eth_dev_stashing_{rx,tx}_config_set() ethdev library functions. Both
> functions have an identical signature, a port_id, a queue_id, and a
> config object. The port_id and the queue_id are used to locate the
> device and the queue. The config object is of type struct
> rte_eth_stashing_config, which specifies the lcore_id and the
> cache_level, indicating where objects from this queue should be stashed.
> The 'objects' field in the config sets the types of objects the
> application wishes to stash based on the capabilities found earlier.
> Note that if the 'objects' field includes the flag
> RTE_ETH_DEV_STASH_OBJECT_OFFSET, the 'offset' field must be used to set
> the desired offset. These functions invoke PMD implementations of the
> stashing functionality via the stashing_{rx,tx}_hints_set function
> callbacks in the eth_dev_ops, respectively.
> 
> The PMD's implementation of the stashing_rx_hints_set() and
> stashing_tx_hints_set() functions is ultimately responsible for
> extracting the ST via the API provided by the PCI bus driver. Before
> extracting STs, the PMD should enable the TPH capability in the endpoint
> device by calling the rte_pci_tph_enable() function.  The application
> begins the ST extraction process by calling the rte_pci_tph_st_get()
> function in drivers/bus/pci/rte_bus_pci.h, which returns STs via the
> same rte_tph_info objects array passed into it as an argument.  Once PMD
> acquires ST, the stashing_{rx,tx}_hints_set callbacks implemented in the
> PMD are ready to set the ST as per the rte_eth_stashing_config object
> passed to them by the higher-level ethdev functions
> ret_eth_dev_stashing_{rx,tx}_hints(). As per the PCIe specification, STs
> can be placed on the MSI-X tables or in a device-specific location. For
> PMDs, setting the STs on queue contexts is the only viable way of using
> TPH. Therefore, the PMDs should only enable TPH in device-specific mode.
> 
> V4->V5:
>  * Enable stashing-hints (TPH) in Intel i40e driver.
>  * Update exported symbol version from 25.03 to 25.07.
>  * Add TPH mode macros.
> 
> V3->V4:
>  * Add VFIO IOCTL based ST extraction mechanism to Linux PCI bus driver
>  * Remove ST extraction via direct access to ACPI _DSM
>  * Replace rte_pci_extract_tph_st() with rte_pci_tph_st_get() in PCI
>    bus driver.
> 
> Wathsala Vithanage (4):
>   pci: add non-merged Linux uAPI changes
>   bus/pci: introduce the PCIe TLP Processing Hints API
>   ethdev: introduce the cache stashing hints API
>   net/i40e: enable TPH in i40e
> 
>  drivers/bus/pci/bsd/pci.c            |  43 +++++++
>  drivers/bus/pci/bus_pci_driver.h     |  52 ++++++++
>  drivers/bus/pci/linux/pci.c          | 100 ++++++++++++++++
>  drivers/bus/pci/linux/pci_init.h     |  14 +++
>  drivers/bus/pci/linux/pci_vfio.c     | 170 +++++++++++++++++++++++++++
>  drivers/bus/pci/private.h            |   8 ++
>  drivers/bus/pci/rte_bus_pci.h        |  67 +++++++++++
>  drivers/bus/pci/windows/pci.c        |  43 +++++++
>  drivers/net/intel/i40e/i40e_ethdev.c | 127 ++++++++++++++++++++
>  kernel/linux/uapi/linux/vfio_tph.h   | 102 ++++++++++++++++
>  lib/ethdev/ethdev_driver.h           |  66 +++++++++++
>  lib/ethdev/rte_ethdev.c              | 149 +++++++++++++++++++++++
>  lib/ethdev/rte_ethdev.h              | 158 +++++++++++++++++++++++++
>  lib/pci/rte_pci.h                    |  15 +++
>  14 files changed, 1114 insertions(+)
>  create mode 100644 kernel/linux/uapi/linux/vfio_tph.h
> 

