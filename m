Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96765C982DE
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 08:56:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC2C140289;
	Mon, 21 Sep 2026 10:56:29 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 99B1640265
 for <dev@dpdk.org>; Mon, 21 Sep 2026 10:56:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789980988; x=1821516988;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=QzTc3ZHguk3764Y1+uW07QP3eITR6rzwWnjGwCpoVaY=;
 b=S04Q93HMkyoC8hcxWKm+KKu9/VoKKRTn4H1BPOecOJhfO3qduIXlshWP
 NgoB028Q/WyMhIGpvISZDDYKKD8ZZ7d9Co/M4AManlkfoiFGpUOTu95ZM
 9IkEpNQwuJjhI/YfgNqGJFaCU2ZqrV4XFXBXfRU2hE48dqZM50n+8+0sq
 /7XRFBH7CfIvfohwtQzfvUqYuOkL8+twLEKKt2P3Q5LRqiMpnaCG5kCg1
 A3q7Vvyaj4pDh2fcK7kiQpbWuHMWcAIWHPnQ+IEkxA+Avy7+Av4kz1UC8
 DMt7Xpfd/sFXtSuJ7Fa2uE5HQOkg8EVNdbskBPswI9oU9v1aTOVssd6jV w==;
X-CSE-ConnectionGUID: REI31DCjR/yT9IqzQ6i5zQ==
X-CSE-MsgGUID: yYFv9EbOSVaOBtjE2cVsEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11911"; a="101829671"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; d="scan'208";a="101829671"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2026 01:56:27 -0700
X-CSE-ConnectionGUID: 8pxlQ+PxS/GkXvwWNWcj4A==
X-CSE-MsgGUID: ZQR4w5rFRYKjCqPGgcBwnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; d="scan'208";a="271720985"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2026 01:56:26 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 21 Sep 2026 01:56:26 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 21 Sep 2026 01:56:26 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.32) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 21 Sep 2026 01:56:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GjXs9bB0TLcfftizl0wCJryt0axBQ0dWqbiGKfH7sj8ntK74NAXIhL3vnf8pzPkdxEU0hZItwNJNCargqqk4WxQyN1OcpFoKZAmCYOBlQs2gSV1m8+F+GBGVPShH0BdiELqX0lYAwt3iA2nSZ9XfOEb7ylxDqIa9p5gG/3UqpMyVfs5g8NouDgcpq4VANW1FRFd8O1NMo/3kZWrG7TVbTZfOasiOb1pIYR//Q7ZBXVHgiKNqVKDUye1UptobZrpn5f2MYbMeP/nIvK5r+79ICiZ8saEZ0Su2Q+8bpX+eRV1HBLyoXTD9HqQbqsico5CR9KAVZC93BNrGGV869/2jaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4o5gcgRQV0oUiZDxOsll4uY1nJFBSRHelihO3iaOHaI=;
 b=wl9nylfcijquTB+jgnZ2I0LicWhMyiD1JZCIiWPejAbSpJGXgCjtB3pF1IQGrIfaQRSzsQeIlPvVqmxkvX0LCFSMNBjh5ynHiD33YrOOBqj+meYR/Dzmdwhb9KHxvOqt1CXMwa5nByQC4U9o/ezLwTo2vkwWDrei53v4zTmuNBjayapWVxhZB5tLxW6Y9afisqfJW6gtS0b2fuBYj+GxWqP5bhgJPDVSENQ32thflfYfsg0y6DNIXTfpX5vN0eorA5+27Xal5U2xr7/9M6F9KQdyDpxWMzq5fFyRggp40qGwt083jGqXcG1T9gEGKIJCrVQyJ1Hds+ls7eZ9G9VSNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by SN7PR11MB8283.namprd11.prod.outlook.com (2603:10b6:806:26c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 08:56:22 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0428.011; Mon, 21 Sep 2026
 08:56:22 +0000
Date: Mon, 21 Sep 2026 09:56:17 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: Md Rayhanul Islam <r97yhan@gmail.com>, <dev@dpdk.org>, Chuanyu Xue
 <chuanyu.xue@uconn.edu>, Song Han <song.han@uconn.edu>, Md Rayhanul Islam
 <md_rayhanul.islam@uconn.edu>
Subject: Re: [PATCH 0/2] make PCIe DMA work on Broadcom BCM2711
Message-ID: <arDxMec8YX7KDdAX@bricha3-mobl1.ger.corp.intel.com>
References: <20260918225045.177125-1-r97yhan@gmail.com>
 <20260919140549.1f5f3c0b@phoenix.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260919140549.1f5f3c0b@phoenix.local>
X-ClientProxiedBy: DUZPR01CA0060.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::18) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|SN7PR11MB8283:EE_
X-MS-Office365-Filtering-Correlation-Id: 40a7703d-01cb-4faa-4c3f-08df17be357c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|6133799003|10067099003|11063799006|4143699003|5023799004|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: dr2NNoBidFAe9DpYzo/N5tukpGn8LpqxTVnZ2R1ZStnJGY0u2LNFnqhGerkMg44MiWgueg/s0aYuUi8zBbLJT8ifB+VHBc1dx/lR+3EQchOB1iUqgo0JuAkMSfuGaRofrNdwPQZ+PCqifbOVU4yoBkhGsPG5pz/qjXwCNjeJ2gT7llQM6Lr1gUXMpmmEIh/OUags4zIhNGDbakN41nOrpKklNatNRnF2W1lkRFeztwJoS4VJi0TGzjVVWIzmfoBNLZo+yq5mR3gil5WhU0hDAz8nbBmdqs2DDaA80qYTO+ly5mJlUjjWhKBu9mfVvuDwZEuTHWymengnbgHR3/GjL9jnljkFLU13bo+1WxU6HV51D3ilAYObxG+UUzrHcfSWBi9merqMuTMymACnibjWNsSip080Q4R8BrspbdBW0TUr2K5hr6JE2bfWHM0nNJkL2Osq6NNoT6rOrW06qkkm+Y6Ys2AXXwE6U8n6KnKtFOhXswGKqXUi8NCR3KiGbrKdo/mZX+0KKFvBTBQpZ9I2NDgsnjLc9J8Tb7Act2XmgrLb13sJmxssEYitICuDrSIjAFPK+TPC60U6zZTCCW88Ks/mKia7VEQw/bMEJC+NV7s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(6133799003)(10067099003)(11063799006)(4143699003)(5023799004)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VSDUtj+FrchChG/sVR8bGSOZe0lgoyFBQXKmNX2Fz5Zi+RkEzuT6G+6YF1OI?=
 =?us-ascii?Q?5OR2PqWGWejczKpACZyyKwQWW1VviyFhzF9c88rIZ8oPFEYCigWVv9fvHv2E?=
 =?us-ascii?Q?P3+0x6wSXA3HHtqHpLZa43piWJ909Ad8e1AAgX66oLE8d6EhOmVBpq2qG88p?=
 =?us-ascii?Q?LEMJhaOoQykr30szn/nU70r4+eLYEgnVo/yXRrPt19RkDaEfpDuskPTLbRcF?=
 =?us-ascii?Q?3ILmAUe0oJ42uf74exW1KPrCz79ssIVE43xKovgK2TgyopU2SizDF6G3YICo?=
 =?us-ascii?Q?26WDZiacI/aMfli9s4YlSoIK1yayHP9bpVCoooiTHXD+Ubxoqnit1OtK9i9t?=
 =?us-ascii?Q?FhXdA4PC9nnxhoNMGukGOqTKb2gUz67pq8kin/L+aZ0lFFdQL0j3kavnGdZR?=
 =?us-ascii?Q?mV8lDtDZOtyTmtYRLdEYEYfPiqeZfxVV+Oo7/Mq+g1JX4+IMYEeOZqutlaeE?=
 =?us-ascii?Q?S7oZFUtIuHTHQldLa/F+Z8Nk6p2poedPTXCRhiEE1PXi5DVkD8Iw7e8U++EY?=
 =?us-ascii?Q?7rkdGwFvvlJzcuJQ6U1N+ghBWVJgv6Rw6FCgYmCkGKoJiyF5cfoyhYSg2loz?=
 =?us-ascii?Q?/77siNDYPqXY2qR3+U3Z0dtwmCVpuwofHEXInfa/7AeLNaM0XsdGkwAwKp51?=
 =?us-ascii?Q?KDYFt5C3vKRtUwSpROvKoCdHka8JD3SAiH70tnCSdQZrcY2/6fuUpNaUYgqk?=
 =?us-ascii?Q?8VZ1K312efzhPvFsiIWWG1GXroTG+CQe0uW1VcqbPu+6Na1yD89qYfmnsNQM?=
 =?us-ascii?Q?Jp4VwQbQtVlcOB7eUJCxyoLlkFL8tnEPY7SJ9OosA6KoNJtoKGyfba+XvtcE?=
 =?us-ascii?Q?/xk5z04qcsHBIfLJDphLq6JtjuJKYoT/OmvttVk0kikTuEP+NcitHC3AZ1/Z?=
 =?us-ascii?Q?ITENAUgrN+1oR+cKukVbvh7xfA1d3aTvseNSzARFdxEm9Nv2epoPOok4pZbl?=
 =?us-ascii?Q?b/usV3zUKtmkV+8RhrHT8RdwlHzBypxqir846ppz5efMLpJrR/nM3j4KYU6S?=
 =?us-ascii?Q?ptuaB2hQKNpg6uvgx9pyT3qOXpgM7KJvmA0kn0Ui5As1oUKv6IzIRYSAzROQ?=
 =?us-ascii?Q?dcYhNnCuNUcyCQ1KettepMsWh8/kKeOjcHuhYmypnmb16QHuaNmJaU9+X6cw?=
 =?us-ascii?Q?MTO2PwDgSogUO4jyQSp6lMEM43qIhFmX3jVhhON+uAwS5RdnNVVtPR5e7pkJ?=
 =?us-ascii?Q?GuLf9OZRyY82Uz/l6LYVgkOZOHAju+HjJum3kAc7rKZLb/tAqlNeRjVUIhRx?=
 =?us-ascii?Q?nqEMQKhiHgFTru/WwAc8d0uHiA9u4B4cZ9Yl4rCfJSawUoJV3WgvmZ0tLjnO?=
 =?us-ascii?Q?en+i9sBZmBWXLysawJX55HZtcDJihhcEz36dwUK6i11EvlAkDSwVyXbCoZxA?=
 =?us-ascii?Q?gN6A2NfUEA28BDHn/+EQ5GRQL45gjKaCZh6vALhcW7HpFyblYgnv9l/gQRZw?=
 =?us-ascii?Q?m8BYW8/6LsP/gcLy9lY7Rm2Fic8ZJ/edYnDd1sXhkVNIcAlt2KCzhNuJOlgd?=
 =?us-ascii?Q?za9x+uVNgwYzxDQiCVHJ9jnZVdLENSBaFXkhLQGl7YAlJwqe5BdnTi2UV7qt?=
 =?us-ascii?Q?aAiSf0TBNfYOu91kInQJoomj34dbsQmswmrE/xe19aQ9mFKTHITGHdcYl5tk?=
 =?us-ascii?Q?rGUttaFFt8zt/mKk3lXTAMB5X+LNiunYEHIkE7Qkfo/8MvADM9+GLvS26+8b?=
 =?us-ascii?Q?khYmhQDb5xFJsBrGor9PWHaaF+Ut+CwE54JszII/ySPHmBvRbcVaILav3J1O?=
 =?us-ascii?Q?HjdfTCY8Tjvsk/FwxgOYDWr20x/U60o=3D?=
X-Exchange-RoutingPolicyChecked: WI9u3UtVVprMMz7dmIiR6BDD0ozgXUDkAo6nOXUT6vVIRYVCfPHKJQIlv8y0ycvFP/9EL98SHo/ZmDkC8HL0uYsERJTUjK2b3UdldO4637wIwnaZkbZeOIvzQRZO76g5LAFQbGMUfEmPJ9HZTnNBeLUZ2bdBZ4nfuLq4wFu6eOr5tcQuvTHGpunYbxIgLYvSWCQWsBBaHlaaRBy8L5bd3+exMprviqBzoz/cT2CBlaEiJe4cLpRgS7pHLhSpnLSQkLQirTc/B/aRRXqzcJDqpNOgZ1Fw1iCBxR/ztONcAql3AnYRHUMB9v+9X5t66h+6Cl/T8Y5+9CnXoFHOKtDrWw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 40a7703d-01cb-4faa-4c3f-08df17be357c
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 08:56:22.1708 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0OhaPgRQB098uaJdgv7AMffgBKP+8QfgXxzs53yyx2NAXWE/W1/hzOt/IX+JZssWy9ve8ECi73XMfOnA2G27FGcrPkGurEV1LiydmNaUW9A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8283
X-OriginatorOrg: intel.com
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

On Sat, Sep 19, 2026 at 02:05:49PM -0700, Stephen Hemminger wrote:
> On Fri, 18 Sep 2026 18:50:42 -0400
> Md Rayhanul Islam <r97yhan@gmail.com> wrote:
> 
> > DPDK cannot transmit a single packet on a Raspberry Pi Compute Module 4
> > with an Intel I210.  Nothing reports an error: rte_eth_tx_burst() returns
> > the full count, the link is up at 1 Gbps, and testpmd in txonly mode
> > still shows TX-packets: 0.  Received data is DMA'd somewhere other than
> > the mbuf.  The same card works on x86, and the same board works through
> > the kernel's igb driver.
> > 
> > This has been reported twice and never explained: on Stack Overflow in
> > October 2023 with DPDK 23.07 [1], where TX-dropped equalled TX-total at
> > 55 million with both vfio-noiommu and uio_pci_generic, and on dpdk-users
> > in January 2026 with DPDK 25.03 [2].  Two years apart, so this is the
> > platform, not a regression.
> > 
> > There are two independent causes, hence two patches.
> > 
> > First, the PCIe host bridge does not present memory to devices at CPU
> > physical addresses.  Its device tree says so, and DPDK does not look:
> > 
> >   $ hexdump -C /proc/device-tree/scb/pcie@7d500000/dma-ranges
> >   02000000 00000004 00000000  00000000 00000000  00000001 00000000
> > 
> >   PCI memory space | bus 0x4_0000_0000 | CPU 0x0 | size 4 GiB
> > 
> > A device reaching CPU physical address P must therefore be programmed
> > with P + 0x4_0000_0000.  In IOVA_PA mode every ring and mbuf address
> > DPDK hands the NIC falls outside the inbound window and is discarded
> > silently.  Patch 1 reads the translation from the host bridge and
> > applies it to IOVAs; that alone made the NIC transmit.
> > 
> > Second, the bus is not cache coherent -- no "dma-coherent" on the bridge
> > or any ancestor -- so the NIC read stale rings: zeroed descriptors with
> > DD set and null buffer addresses.  Patch 2 does the cache maintenance
> > the kernel DMA API would do.  Two details took the longest to find:
> > 
> >   - Cleaning to the point of unification (DC CVAU) was not enough.  Only
> >     a clean to the point of coherency made the device see CPU stores.
> > 
> >   - A clean writes back a whole 64-byte line, which holds four
> >     descriptors, so cleaning one erased DD bits the NIC had just set on
> >     its neighbours.  TX completion therefore comes from the hardware
> >     head register, and RX descriptors are refilled a whole line at a
> >     time, once every descriptor in that line has come back.
> > 
> > The cache maintenance sits in the driver.  Every driver on such a bus
> > needs the same thing, so an arch or EAL helper may be the better home; I
> > kept it local to e1000 for a first submission and am happy to move it.
> > 
> > Each patch documents its own half, since the failure gives nothing to
> > search for.
> > 
> > The device is bound to uio_pci_generic throughout: this SoC has no
> > IOMMU, so VFIO cannot be used to sidestep the address question.
> > 
> > Tested on a Compute Module 4 (BCM2711, 4 GB, Cortex-A72, 64-byte cache
> > lines) with an I210 (8086:1533 rev 03) on uio_pci_generic, Ubuntu 22.04
> > arm64, kernel 5.15, pcie_aspm=off.  With this series applied to current
> > main, testpmd txonly reaches 1.42 Mpps at 64-byte frames, which is 1 GbE
> > line rate, with 0 TX errors; without it, TX-packets stays 0.  The same
> > code based on v25.03 also passed a 300k-frame MAC loopback with no loss
> > and byte-exact payloads, and 390-run round-trip campaigns against a
> > second board with ICMP and UDP probes, 100 to 1500 byte packets, 1k
> > pkt/s to line rate, with no unexplained loss.
> > 
> > Not tested: any other board, SoC or NIC.  The offset is read from the
> > device tree rather than hardcoded, but I have only seen this platform.
> > Only e1000 was changed, so other drivers on a non-coherent bus still
> > read stale descriptors.
> > 
> > [1] https://stackoverflow.com/questions/77225289/
> > [2] https://mails.dpdk.org/archives/users/2026-January/008433.html
> > 
> > Md Rayhanul Islam (2):
> >   eal/linux: apply PCIe inbound DMA translation
> >   net/e1000: maintain caches on non-coherent DMA
> 
> Short observations:
>   1. Too much AI generated slop, extra docs, comments on everything.
>      New code should look like the surrounding code.
>      This looks like AI wasn't quite sure and left lots of docs for future self.

I really don't view this as a bad thing. A little too much detail in the
comments is better for the future than too little. Given these patches
touch areas outside the usual behaviour we expect from DPDK platforms,
having extra comments is definitely useful.


/Bruce
