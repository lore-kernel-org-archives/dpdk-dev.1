Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70DD1C9830E
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Sep 2026 10:22:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9FC6E4327A;
	Fri, 25 Sep 2026 12:22:30 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 5FC8040DD3
 for <dev@dpdk.org>; Fri, 25 Sep 2026 12:22:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790331749; x=1821867749;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=TV1lHeRPBXYvM8oZBOStgaPCVitg5AcFusxzF6YWTgg=;
 b=YaiFvi8+r+9L9Ukks8F7bIepnAuXgHrwxaJDyQhnaDXLdBAfsDdm8suW
 Usm9q0jp5nfPc0cMoord/xkForL/ZCAH1DuOhrosmDnC0N16i6nKLDS4q
 RRjeufpeeJzHZRmwu5/cIno3SbANJWWnqvkFNw318qYAbNmsCs4LcL2gZ
 j2c6u4CNnb1PRjQlsQxM21z5M5OPpssPAUSdM+++G7g7/Sahe1TFpvokS
 cJ8WvtF4aKondofo5yW7Rmlz1c1pYjGCe+omf9WhJIE1KLP2FQ9vPizdx
 XZwWxEeGXAaDukDbZcv5vk9jT+ae3KsES+SdEG4t4egdjNc6bm+d0cGHF w==;
X-CSE-ConnectionGUID: ajLWs4ZPQ+e45lXl0bwoIQ==
X-CSE-MsgGUID: cAq8u8mYSOifRlVXCKLNDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="90154303"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="90154303"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 03:22:28 -0700
X-CSE-ConnectionGUID: 64iPPEw6TLSt4o48Mt1eGw==
X-CSE-MsgGUID: Od6J/G4MQf2zEb8eS/c5eA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="273856325"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 03:22:28 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 03:22:26 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 25 Sep 2026 03:22:26 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.4) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 03:22:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EeoeanoWob96qxsK3wusRhrGYJpqSsyZQWRDp12dx18BGOjd/rDeEg96VxE+hzep5yHfFdunKlQx/SFBFcGPYQKiY6WsIlaInlS4JoXgLE6NBhrDKM9xle9dS6Y7u0RgMvpA05pkm0Dd7hlNvcnAkKU2TnsyYRjHxU5HSr3pkMClip2fK3SaaxQeTNigiDDfKNwvj/PtIU01Sbg2YGVpoWSkKeTwyauekGusXKa8yhlU5E2AFTa5qUt9BuYRXoo8Jc2kzZR/sRevCjVlPG6bGAuz6vwXBaYj+DT7ipew181eNEnOvxfKnjP+wenBiWBl7zBnitseORng0zAmXsUUww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NlBYic6TcLgGRa2+Cl6FxEcW7gMDZn6/Gdf5lrVGlHk=;
 b=j1MGPUGFhkMplWddKGyGlEbF9FqRcSXthILsMxQZ/nZw1TljACTn96TVFYzllud7gATwHat2fcP9M0NSD4AEtzFoAE13vHZrOWwF8pYT+jcdeSjyhndAUfDLsaBErk1WF9EFDLv8A2wcr6VlJQsyUKMAO+Dn+6PMQRClvujIPzO7CD7zjtMORUk/vdexohrkjFQSXUVbVsSULyk54usT6FY9UVQVMjuSHcaob8iNTI9nDsZjkW7Nqm8dyN6Wyc+PEfaVKvBXj9YFvqJ7B1/0hDCAtIRer4gFZ0p5zDH8fSs6zQFSOvv1FIA+CB5Dz5pCkaWtz9zCgVRdZaJEYjT6zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by DM6PR11MB4689.namprd11.prod.outlook.com (2603:10b6:5:2a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 10:22:24 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0428.018; Fri, 25 Sep 2026
 10:22:24 +0000
Date: Fri, 25 Sep 2026 11:22:17 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
CC: <dev@dpdk.org>, <jingjing.wu@intel.com>, <rjarry@redhat.com>,
 <thomas@monjalon.net>, <selwin.sebastian@amd.com>, <bhagyada.modali@amd.com>
Subject: Re: [PATCH v1 2/3] raw/ntb: add AMD NTB support
Message-ID: <arZLWdmiKaF_BYwY@bricha3-mobl1.ger.corp.intel.com>
References: <20260823140639.153997-1-raghavendra.ningoji@amd.com>
 <20260823140639.153997-3-raghavendra.ningoji@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260823140639.153997-3-raghavendra.ningoji@amd.com>
X-ClientProxiedBy: DU2P251CA0019.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:230::26) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|DM6PR11MB4689:EE_
X-MS-Office365-Filtering-Correlation-Id: 805ad9c6-524b-4ee6-2a87-08df1aeee3ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|10067099003|56012099006|11063799006|4143699003|6133799003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 1R9VI1qnxpgvUwSiNUHX7S438ZoS8xsXBBDsEmYHwn9F/AKghO0YffWaFxwKGjzYTCvfm3VldcJmRHOhitkWPjgyZWELtGP7q6AbgL90DbgtPRD75Wp3tl3LZ5B0cKJ56FG/n8xqwzvFGtFG15NdD559y5MGEvILQoVzA1766yaavUvtdldbDuYAuZaXCtn2zKTPw/PckPMPT0CbGU65w7ZtnjQXWVWdy61HMKwwnfi9BEgxaXB58onTttf/SKCwBsxSUaS4KC+BfSNGo26ekDS2zD/qJpkGffkKchogOEvukOYP8LxZyOiv16nlhxX5rcITAsD9mBs95nNmaZBWZ0Os0P7FK8zv9jFmzh/Gxqgmk+urGYxA8X7rNMZbdW7GZYG1ZX2CnNrRyftVzUFyz2hps9cU8U5t6h9oDIxbLcMYcHmIVL+CmKMJ70Rn4zmxUtaGFuhLk4CsQLN5oes6dlzg3qtWF1tSarV7iiyvaRHcWUWbMaWixs/+sKsoAOK8j+v1ok+o4JIbX1PfAq/UlUavf2b+3led8+1epa9tRv/ExZczhU7fl8kGZP2rlCOCTPlZPkJFc+ogb/huUTFK+1O5YJsHFtptHYsNMNy+FFjh+h62SC53Z44ocuUD7sPsq2dCU2OxEVUB37byx1gYJ8QwYbuBp6CQqE31znPEmn4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(11063799006)(4143699003)(6133799003)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R42PzzD+hMSaGIC8o2ZhmoptmPbtE5yQScc9S86fjQIvjKl1YBhmSmMvnHez?=
 =?us-ascii?Q?/LtzSlesgQmR91pLi31zjz5VPlKci4SIbr1+ROrNoo4eAe9+aWUT2z2Q2/nz?=
 =?us-ascii?Q?2PpjJTmmvUDNw6swlJ2nat68s5KNmGKKsCPj3L6o3fDQhb5iErmqZD54J+FZ?=
 =?us-ascii?Q?zGn6dyDf6s6Sce9nR0+gWFZaqRt9M56d0p5yltrJKTlEW0qRk7ESwHYsvWvC?=
 =?us-ascii?Q?5eMdOqXD7G/ioPlmkWr5AeljUHBqyBbPiko0A9ZFI6Vo/36hwBkUXqfi/uZl?=
 =?us-ascii?Q?E8X3Sdt6Xt13gMhZdYOt/zc5InzImT5VrzUuMm5SoO5QqYqR4Ypt411g7jDz?=
 =?us-ascii?Q?RMXIIyu7weOA/l0jlIfUsZzGmzlDxVjouCuzfrsjYaKdTrB7Toq2Apuf5ZEZ?=
 =?us-ascii?Q?xYrQR7Xbo4uDwx59XvhQGql1OlfbjG5fiOVZnBOmkBBgl0tYnr1nMaAP6l6A?=
 =?us-ascii?Q?0IUbfF8AS6PGi3FNwPi5tgF5CSx3KNaNkqmRNV8bWSR3TdKPcgDzBtNHIdNp?=
 =?us-ascii?Q?ULAxN7daQPgczYE3bIgnYQSztmFuMxPncABAXOOc//Y00AeRiY9oiAfNOWg4?=
 =?us-ascii?Q?kbLFzUFTRwt/QhUoN0gyuv9a1DFYcSBKG0dfW5g/0F/0fKmEJXUKoeDMOHJh?=
 =?us-ascii?Q?k64NlrCPjwIi5knW/DjbDFRY0gz0NxdH8maoiXds5+Uev4J+hYt15tydXbwS?=
 =?us-ascii?Q?Ed0KFIn4u7mIsSB2A9q450myoPjhHlxYI8IFYfKSHU4pFdHf2vz4usQMgR4V?=
 =?us-ascii?Q?R73q8inzDEGiZf7gPFLogVSSjlPBBYlyMS8e1PTOAc9E2UkwzcdqDCQAQKCU?=
 =?us-ascii?Q?VPE/kJ8oWOcJ6G6QPtm0vsQqsUqozYgtHwWYwX5no8HPhs4at5gJn8HDppds?=
 =?us-ascii?Q?YnIEeho0Zd46j0VoQjZYJQHBfanNVr/3QYnLTDfGDkuPLRCDYmmQZ4GUQ+3a?=
 =?us-ascii?Q?4Vm7IbBlx1a7gQkpYg71PQx82gwJRh/ZS8ZXuBlxzT44QhgcCDZmelcjK3eu?=
 =?us-ascii?Q?sc3Jxz59kri9G/SgkfieDaqBSN9bXaFxOqwYUReUqfBPAgy1Q1Qt2FMFBNhX?=
 =?us-ascii?Q?GepZc30YyxFLDKiazANY+PUfAxXGGjmvdVr/IPMFL9qJgN6XBJ1gVdJA9V0r?=
 =?us-ascii?Q?5z29dXiHFlAFD+Pbs4WGD5+Ef0Jaz7NLcfhuYjyFZoM36YDS7JQGBFw9+84w?=
 =?us-ascii?Q?5a1kSMpaDYVT6h4JQC8m/aOU68qOkqSG5uDn5u5GntAFn2dRAmVYuCtZkH0L?=
 =?us-ascii?Q?uKThYAclSCGd0kMPbmPdLZ2meqp2QD8NRU67LQcLsJCrvbnGzwcDBmXYl5gM?=
 =?us-ascii?Q?39DPsg7Yd0MXfN6ZvvGyEuY824odmKc80d5NGU17p4IVIdWtR6Oo4x0qD8T7?=
 =?us-ascii?Q?TiY0YDrX2IVXrBUI/1m/VFfb0Qj6ZzLJHKTDNHB21gvc7HLxVawUJjdHB2pB?=
 =?us-ascii?Q?Z4uaO0p+WhJ/BQxY48sLYuptX0/Eg3HLl11MQ83W1Z7JHZsFlhhehysVmgO/?=
 =?us-ascii?Q?fluDiDoGwewnjaGdO8u/Kr3F5Mca03brLpZDv8XbH4EdTYxbTiUBteG2YSro?=
 =?us-ascii?Q?TLjuZp592AlGNLjaxYSQZBUlTsjCChqrESy9VTqMLBta+oMeoINVpuhABozh?=
 =?us-ascii?Q?C1W8+3iCFZ0EN4/WAKUtKqG4//I+i/docoE0BTWXUaaC/XvklJPX5TxArxDq?=
 =?us-ascii?Q?l9AFQLU/IhNoJop8NdBrMlKV5LQpRMg+/GYdNnidH3tjkAy2GXyEx7bBsTGP?=
 =?us-ascii?Q?+tHq13BDoDKtpZx6ufc5g3TtOG0+XRU=3D?=
X-Exchange-RoutingPolicyChecked: ZjWn+/kqcrW+cJAggbUUkETDoHZ28gDxjRNMJ5cxqcMMsmISGEP5zotTtfOUCx3S7WhE7cSpz0aD6eXKueljJ7iheodGYIGGxvhltogGfjaio+Bi7IyvAM9bo7IWQeCnHTIXDFaijSCzPmI77ebav51jnztdNucWWJuD86h4kDodmq0XC8k/ZgsR1pfP8LwVmazr2WVxJnWOwHLC7Bgw2qqRvyofnlf2sTJTlPCWPO1BQbJH2khnB2DtuoF0rxHuJnhNFE4+mWYXHQlgfTz/JyOWHuCza2nhoHncjiv7idn8vAvCessKo5aprFj96XxgctCGqcrl58SX1fU5VHVVBQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 805ad9c6-524b-4ee6-2a87-08df1aeee3ee
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 10:22:24.2870 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ake+eNi5cpxTFYpQMNLW6vAyIVnx9tc4mCDTq7YOgfkQgmnDNxxxzAkh+GdAfS/y0O99pcaU5JCvQw+n/XNTomS1MMlVkjKl+OQ2hQdcJy8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4689
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

On Sun, Aug 23, 2026 at 07:36:38PM +0530, Raghavendra Ningoji wrote:
> Add support for the NTB endpoints integrated in AMD EPYC Embedded
> "Turin", "Genoa" and "Siena" processors to the raw/ntb driver.
> 
> The AMD NTB uses a primary/secondary topology: one endpoint enumerates
> as the primary (device ID 0x14c0) and the other as the secondary
> (device ID 0x14c3). The hardware exposes two memory windows (BAR23 and
> BAR45), 16 doorbells and a single shared 16-register scratchpad bank.
> The scratchpad bank is split into two disjoint 8-register sets, one per
> side, so the driver uses a packed handshake layout that fits in 8
> registers, plugged in through the framework's dev_handshake and
> read_peer_config hooks. A vendor-specific MSI-X interrupt handler is
> provided through the interrupt_handler hook.
> 
> AMD NTB uses an outbound translation window: a write to a BARxx memory
> window offset is forwarded to (xlat_base | offset) in the peer's memory
> rather than (xlat_base + offset). For that to be correct the
> translation base must be aligned to a power of two >= the window length
> so that no offset bit collides with a set bit in the base; the XLAT
> register also requires at least 4K alignment. Report this requirement
> to applications through a new mw_addr_align field in struct
> ntb_dev_info, reject a misaligned base in amd_ntb_mw_set_trans, and
> honour the field when reserving the memzone in the ntb example.
> 
> On the secondary side the device's own PCIe link status does not
> reflect the true inter-host link, so the link speed and width are read
> from the upstream switch port via sysfs.
> 
> Signed-off-by: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
> ---
>  drivers/raw/ntb/meson.build   |   3 +-
>  drivers/raw/ntb/ntb.c         |  21 +
>  drivers/raw/ntb/ntb_hw_amd.c  | 709 ++++++++++++++++++++++++++++++++++
>  drivers/raw/ntb/ntb_hw_amd.h  | 114 ++++++
>  drivers/raw/ntb/rte_pmd_ntb.h |  10 +
>  examples/ntb/ntb_fwd.c        |  22 +-
>  usertools/dpdk-devbind.py     |   4 +-
>  7 files changed, 879 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/raw/ntb/ntb_hw_amd.c
>  create mode 100644 drivers/raw/ntb/ntb_hw_amd.h
> 

Reviewing changes to common code only, please see inline below. I think
there is quite a bit of complexity introduced by the alignment constraints
which could do with being simplified.

Thanks,
/Bruce

> diff --git a/drivers/raw/ntb/meson.build b/drivers/raw/ntb/meson.build
> index 9096f2b25a..d7a8f2d1ed 100644
> --- a/drivers/raw/ntb/meson.build
> +++ b/drivers/raw/ntb/meson.build
> @@ -3,5 +3,6 @@
>  
>  deps += ['rawdev', 'mbuf', 'mempool', 'pci', 'bus_pci']
>  sources = files('ntb.c',
> -                'ntb_hw_intel.c')
> +                'ntb_hw_intel.c',
> +                'ntb_hw_amd.c')

Very minor nit, but consider putting the ")" on the next line and putting a
comma after the 'ntb_hw_amd.c' entry (since meson allows a trailing comma).
This means that new entries can be added without having to modify any
existing lines.

>  headers = files('rte_pmd_ntb.h')
> diff --git a/drivers/raw/ntb/ntb.c b/drivers/raw/ntb/ntb.c
> index 3a6a299081..b87141e4f4 100644
> --- a/drivers/raw/ntb/ntb.c
> +++ b/drivers/raw/ntb/ntb.c
> @@ -20,12 +20,15 @@
>  #include <rte_rawdev_pmd.h>
>  
>  #include "ntb_hw_intel.h"
> +#include "ntb_hw_amd.h"
>  #include "rte_pmd_ntb.h"
>  #include "ntb.h"
>  
>  static const struct rte_pci_id pci_id_ntb_map[] = {
>  	{ RTE_PCI_DEVICE(NTB_INTEL_VENDOR_ID, NTB_INTEL_DEV_ID_B2B_SKX) },
>  	{ RTE_PCI_DEVICE(NTB_INTEL_VENDOR_ID, NTB_INTEL_DEV_ID_B2B_ICX) },
> +	{ RTE_PCI_DEVICE(NTB_AMD_VENDOR_ID, NTB_AMD_DEV_ID_PRI) },
> +	{ RTE_PCI_DEVICE(NTB_AMD_VENDOR_ID, NTB_AMD_DEV_ID_SEC) },
>  	{ .vendor_id = 0, /* sentinel */ },
>  };
>  
> @@ -846,6 +849,20 @@ ntb_dev_info_get(struct rte_rawdev *dev, rte_rawdev_obj_t dev_info,
>  	info->mw_size_align = (uint8_t)(hw->pci_dev->id.vendor_id ==
>  					NTB_INTEL_VENDOR_ID);
>  
> +	/**
> +	 * AMD NTB uses an outbound translation window: writes to a BARxx
> +	 * memory window are forwarded to the peer via the XLAT registers,
> +	 * whose base must be 4K aligned. If the mw memzone base is not
> +	 * aligned, the low bits are dropped and all window writes land at
> +	 * the wrong offset. Report the required alignment so the memzone is
> +	 * reserved correctly. Intel uses mw_size_align (a superset), so this
> +	 * only matters for non-Intel vendors.
> +	 */

Consider shortening the coment here. Also see other feedback below
regarding this field.

> +	if (hw->pci_dev->id.vendor_id == NTB_AMD_VENDOR_ID)
> +		info->mw_addr_align = RTE_PGSIZE_4K;
> +	else
> +		info->mw_addr_align = 0;
> +
>  	if (!hw->queue_size || !hw->queue_pairs) {
>  		NTB_LOG(ERR, "No queue size and queue num assigned.");
>  		return -EAGAIN;
> @@ -1406,6 +1423,10 @@ ntb_init_hw(struct rte_rawdev *dev, struct rte_pci_device *pci_dev)
>  	case NTB_INTEL_DEV_ID_B2B_ICX:
>  		hw->ntb_ops = &intel_ntb_ops;
>  		break;
> +	case NTB_AMD_DEV_ID_PRI:
> +	case NTB_AMD_DEV_ID_SEC:
> +		hw->ntb_ops = &amd_ntb_ops;
> +		break;
>  	default:
>  		NTB_LOG(ERR, "Not supported device.");
>  		return -EINVAL;
> diff --git a/drivers/raw/ntb/ntb_hw_amd.c b/drivers/raw/ntb/ntb_hw_amd.c
> new file mode 100644
> index 0000000000..9861dcee57
> --- /dev/null
> +++ b/drivers/raw/ntb/ntb_hw_amd.c

<snip>

> diff --git a/drivers/raw/ntb/rte_pmd_ntb.h b/drivers/raw/ntb/rte_pmd_ntb.h
> index 76da3be026..59a2ad6849 100644
> --- a/drivers/raw/ntb/rte_pmd_ntb.h
> +++ b/drivers/raw/ntb/rte_pmd_ntb.h
> @@ -27,6 +27,16 @@ struct ntb_dev_info {
>  	uint8_t mw_size_align;
>  	uint8_t mw_cnt;
>  	uint64_t *mw_size;
> +	/**< Minimum alignment (bytes) required for the mw translation base
> +	 * address, and a flag that the base must additionally be aligned to a
> +	 * power of two >= the mw length. 0 means no extra alignment beyond
> +	 * cache line. AMD NTB uses an outbound translation window that forms
> +	 * the target as (xlat_base | offset) instead of (xlat_base + offset),
> +	 * so the base must be size-aligned to avoid offset bits colliding with
> +	 * base bits; it also requires at least 4K alignment for the XLAT
> +	 * register.
> +	 */
> +	uint64_t mw_addr_align;

Again, shorten the comment here to just a line or two.
Also, in terms of how it is used, remove the special case for 0 == cache
aligned, and instead change code assignment above to be cache aligned by
default. This means that all uses of this value in apps don't need to have a
special-case for it - they just align the memory allocation to what is
provided, be it 64-bytes or 4k.

>  };
>  
>  struct ntb_dev_config {
> diff --git a/examples/ntb/ntb_fwd.c b/examples/ntb/ntb_fwd.c
> index 33f3c1ef17..7cc4e22147 100644
> --- a/examples/ntb/ntb_fwd.c
> +++ b/examples/ntb/ntb_fwd.c
> @@ -1146,8 +1146,10 @@ ntb_mbuf_pool_create(uint16_t mbuf_seg_size, uint32_t nb_mbuf,
>  		if (!left_sz)
>  			break;
>  		snprintf(mz_name, sizeof(mz_name), "ntb_mw_%d", mz_id);
> -		align = ntb_info.mw_size_align ? ntb_info.mw_size[mz_id] :
> -			RTE_CACHE_LINE_SIZE;
> +		if (ntb_info.mw_size_align)
> +			align = ntb_info.mw_size[mz_id];
> +		else
> +			align = RTE_CACHE_LINE_SIZE;

Again, see above comment. If we remove zero as a possible value here, you
can just use ntb_info.mw_size_align directly without branching in app code.

>  		/* Reserve ntb header space on memzone 0. */
>  		max_mz_len = mz_id ? ntb_info.mw_size[mz_id] :
>  			     ntb_info.mw_size[mz_id] - ntb_info.ntb_hdr_size;
> @@ -1155,6 +1157,22 @@ ntb_mbuf_pool_create(uint16_t mbuf_seg_size, uint32_t nb_mbuf,
>  			(max_mz_len / total_elt_sz * total_elt_sz);
>  		if (!mz_len)
>  			continue;
> +		/*
> +		 * Some NTB hardware (e.g. AMD) uses an outbound translation
> +		 * window that forms the target as (xlat_base | offset) rather
> +		 * than (xlat_base + offset). For that to be correct the memzone
> +		 * base must be aligned to a power of two >= its length, so that
> +		 * no offset bit collides with a set bit in the base address.
> +		 * Honour that requirement when the driver reports mw_addr_align.
> +		 */
> +		if (ntb_info.mw_addr_align) {
> +			uint64_t pow2_align = rte_align64pow2(mz_len);
> +
> +			if (pow2_align > align)
> +				align = pow2_align;
> +			if (ntb_info.mw_addr_align > align)
> +				align = ntb_info.mw_addr_align;
> +		}

This is really complex to have in the app, and is hard for the user to
understand and work with too. I would suggest that, rather than trying to
expose this via a single addr_align value - which it turns out isn't
actually the alignment needed - you add a separate API called
"get_mem_align" or something similar, and then hide the complexity of this
calculation in the driver. Then you can drop the mw_addr_align in the info
struct.

>  		mz = rte_memzone_reserve_aligned(mz_name, mz_len, socket_id,
>  					RTE_MEMZONE_IOVA_CONTIG, align);
>  		if (mz == NULL) {
> diff --git a/usertools/dpdk-devbind.py b/usertools/dpdk-devbind.py
> index e72f238aba..cf5747b003 100755
> --- a/usertools/dpdk-devbind.py
> +++ b/usertools/dpdk-devbind.py
> @@ -78,6 +78,8 @@
>                   'SVendor': None, 'SDevice': None}
>  intel_ntb_icx = {'Class': '06', 'Vendor': '8086', 'Device': '347e',
>                   'SVendor': None, 'SDevice': None}
> +amd_ntb = {'Class': '06', 'Vendor': '1022', 'Device': '14c0,14c3',
> +           'SVendor': None, 'SDevice': None}
>  
>  cnxk_sso = {'Class': '08', 'Vendor': '177d', 'Device': 'a0f9,a0fa',
>              'SVendor': None, 'SDevice': None}
> @@ -105,7 +107,7 @@
>  regex_devices = [cn9k_ree]
>  ml_devices = [cnxk_ml]
>  misc_devices = [cnxk_bphy, cnxk_bphy_cgx, cnxk_inl_dev,
> -                intel_ntb_skx, intel_ntb_icx,
> +                intel_ntb_skx, intel_ntb_icx, amd_ntb,
>                  virtio_blk]
>  
>  # global dict ethernet devices present. Dictionary indexed by PCI address.
> -- 
> 2.34.1
> 
