Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5FDC5B549
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 16:51:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 74E3542E46;
	Wed,  4 Jun 2025 18:51:20 +0200 (CEST)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com
 [209.85.219.54]) by mails.dpdk.org (Postfix) with ESMTP id 91E884025D
 for <dev@dpdk.org>; Wed,  4 Jun 2025 18:51:19 +0200 (CEST)
Received: by mail-qv1-f54.google.com with SMTP id
 6a1803df08f44-6f8a87f0c0fso1602446d6.0
 for <dev@dpdk.org>; Wed, 04 Jun 2025 09:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1749055879;
 x=1749660679; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3vK7HpJgy2aDXfev5pOU5lhtYGavLb3M+riIFi5ZBww=;
 b=M5w452NxdnzidNzYSPo4f/jsFeRR5Ws9wHqq3FBdUNv7TkO2WTF8BtuLa5ULJkv6Qy
 P8vcKrx+JEzUrAs2SiPcUGkmc5MiIkvMgUJqH0c1d1OcIWnds/o+k3CIsAblt7pspfgi
 6KpoPWrlNE9V0ket/gM2g459ywGKwJrIHIN2KwmisvQPOqd2h7nJIK9y/BLJeUpGsnk8
 CvmUIHvUNrTjJgqCIn2TwYxu/0u5ifc2zWW2hXFa1YZq5bkS3OEWVe7lBk6KUGIv1jNl
 zcVphzBQOOAkmMFKliMQcvqeHBEaoIXP/tB8EBpVy/YsBKIZOgAppQj5I6H3xRdZz005
 5wBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749055879; x=1749660679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3vK7HpJgy2aDXfev5pOU5lhtYGavLb3M+riIFi5ZBww=;
 b=YavE1wBEEH7ScshKau7Kfuue8f3EuDNaReOKSNf11dy1kdHpxnaC/2K0d1w0/me0k7
 QEQ/Oja8HM+tydZYy469B0ibG1rQWor63Z9qLG10Pyr0x8JD6Hi2Isrqh1kUcYnoCoQz
 36VfSjC2NyqbIkJGvqlfJloGHAEKPPTD+Uwf80b8C+3vFG2p4zIbVelgzZK7GGJyQc9t
 m32It3YJSK8/HUVML4JVzmIByHfn2WuKUDoa8L2KOdcMiTcl+/WECjJegrMIiixR769X
 mWL/uRz/kUkBRn3ms7nftFnKOqXpoPa4WdYwkLm8zDoo/gSvJRB0x0B2B0w7DLR+9DTa
 dI8w==
X-Gm-Message-State: AOJu0YzyYSpfF1AOllg7QpqQ5FtlzURR+b5vnEk9iyb4M43X2ovA14jg
 AoHIksS7jc9iGjT6v/7zhowBu7a4WRZx6y924D7hVyn6s5CWgtLUw5jK08lXo8g0uYM=
X-Gm-Gg: ASbGncs9WLlQeWAO+Pfcnse2VURwNo4k68wnUlSe4XAqw/YekmfxTTrpgiaIyYHD8h3
 DHwc2OOAOrwYUJ9zR3UXSOIgDk5HVppjGg1io1am4kqTBrKdJnTg4o6aeRGipHcUDccTOkTZT9b
 ZgAHq9c7HgegnfTZahcajW1s4A60fKIPCslweJ9tx+M5bjlalk+xlKslEbcbwNb04OPZDC1HmmO
 HzBlSj90KmYFwVG8FCPCwXg0rTxoj1JOro07PzOjb9mb/umnxh0ux0198pueQM0tvAeMfLdYtlp
 b41GZVwRPMbO1u2acJ2wGnu/yRd4xWZwMjuXp8pPIYcD5Gq73mLiDBTnu8p968/4tiAxJVb5mqw
 pvBNd86naYgpNswQDqgdtrPR+hy/yeZNWatXmbxM=
X-Google-Smtp-Source: AGHT+IG6EYH8BCjzAoaxZDUPOfK7SgqYeYeHLdadTc9CTUqkegiUVU5zyy4HoKFdBz6AgpKMePx4DQ==
X-Received: by 2002:ad4:5ced:0:b0:6e8:ebc6:fd5f with SMTP id
 6a1803df08f44-6faf6fa70bdmr50370946d6.20.1749055878768; 
 Wed, 04 Jun 2025 09:51:18 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fac6d4c7d8sm102321166d6.36.2025.06.04.09.51.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jun 2025 09:51:18 -0700 (PDT)
Date: Wed, 4 Jun 2025 09:51:14 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Wathsala Vithanage <wathsala.vithanage@arm.com>
Cc: dev@dpdk.org, nd@arm.com
Subject: Re: [PATCH v5 0/4] An API for Cache Stashing with TPH
Message-ID: <20250604095114.2e540905@hermes.local>
In-Reply-To: <20250602223805.816816-1-wathsala.vithanage@arm.com>
References: <20241021015246.304431-1-wathsala.vithanage@arm.com>
 <20250602223805.816816-1-wathsala.vithanage@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Mon,  2 Jun 2025 22:38:00 +0000
Wathsala Vithanage <wathsala.vithanage@arm.com> wrote:

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
>=20
> - Rx/Tx queue descriptors
> - Packet-headers
> - Packet-payloads
> - Data from a given offset from the start of a packet
>=20
> Note that stashable object types are outside the scope of the PCIe
> standard; therefore, vendors could support any combination of the above
> items as they see fit.
>=20
> To enable TPH and fine-grained packet stashing, this API extends the
> ethdev library and the PCI bus driver. In this design, the application
> provides hints to the PMD via the ethdev stashing API to indicate the
> underlying hardware at which CPU and cache level it prefers a packet to
> end up. Once the PMD receives a CPU and a cache-level combination (or a
> list of such combinations), it must extract the matching ST from the PCI
> bus driver for such combinations. The PCI bus driver implements the TPH
> functions in an OS specific way; for Linux, it depends on the TPH
> capabilities of the VFIO kernel driver.
>=20
> An application uses the cache stashing ethdev API by first calling the
> rte_eth_dev_stashing_capabilities_get() function to find out what object
> types can be stashed into a CPU cache by the NIC out of the object types
> in the bulleted list above. This function takes a port_id and a pointer
> to a uint16_t to report back the object type flags. PMD implements the
> stashing_capabilities_get function pointer in eth_dev_ops. If the
> underlying platform or the NIC does not support TPH, this function
> returns -ENOTSUP, and the application should consider any values stored
> in the object invalid.
>=20
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
>=20
> The PMD's implementation of the stashing_rx_hints_set() and
> stashing_tx_hints_set() functions is ultimately responsible for
> extracting the ST via the API provided by the PCI bus driver. Before
> extracting STs, the PMD should enable the TPH capability in the endpoint
> device by calling the rte_pci_tph_enable() function.=C2=A0 The application
> begins the ST extraction process by calling the rte_pci_tph_st_get()
> function in drivers/bus/pci/rte_bus_pci.h, which returns STs via the
> same rte_tph_info objects array passed into it as an argument.=C2=A0 Once=
 PMD
> acquires ST, the stashing_{rx,tx}_hints_set callbacks implemented in the
> PMD are ready to set the ST as per the rte_eth_stashing_config object
> passed to them by the higher-level ethdev functions
> ret_eth_dev_stashing_{rx,tx}_hints(). As per the PCIe specification, STs
> can be placed on the MSI-X tables or in a device-specific location. For
> PMDs, setting the STs on queue contexts is the only viable way of using
> TPH. Therefore, the PMDs should only enable TPH in device-specific mode.
>=20
> V4->V5:
>  * Enable stashing-hints (TPH) in Intel i40e driver.
>  * Update exported symbol version from 25.03 to 25.07.
>  * Add TPH mode macros.
>=20
> V3->V4:
>  * Add VFIO IOCTL based ST extraction mechanism to Linux PCI bus driver
>  * Remove ST extraction via direct access to ACPI _DSM
>  * Replace rte_pci_extract_tph_st() with rte_pci_tph_st_get() in PCI
>    bus driver.
>=20
> Wathsala Vithanage (4):
>   pci: add non-merged Linux uAPI changes
>   bus/pci: introduce the PCIe TLP Processing Hints API
>   ethdev: introduce the cache stashing hints API
>   net/i40e: enable TPH in i40e
>=20
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
>=20

How will this impact existing applications that never use the API?
It is crucial that existing 3rd party applications, just work without
modifications. We don't want to hear from Network Virtual Appliance
vendors that there is a performance regression in DPDK. They are already
reluctant to keep up with DPDK versions.

I.e if the application does nothing caching must be enabled.
