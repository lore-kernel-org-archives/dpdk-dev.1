Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD6EE81A5A
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 17:15:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7A0CE40608;
	Mon, 16 Feb 2026 18:15:21 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 7673A40289
 for <dev@dpdk.org>; Mon, 16 Feb 2026 18:15:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771262120; x=1802798120;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=wpuZ74vY+9AYizd3cKgkzLa9GWjQq3UjPgSV+tPex5Y=;
 b=RgpTKIYpPKgpXdX2/gBv4LRB3S3Vpg3QZT3AFO8KCNkV5isx2hKgJ9xi
 WNx7DsK4lITrN4KsdYNMUeW3MdUZtY0mEkQEr6ruHG7olyYZSvqKthRTn
 11Uwrvy4nFNYMoITVUo/GgJJm77BGEMXpI9BmJ+qzyMorOtF7lg+wKoaB
 urZYuVxVd34ZIk+gjItJ0TX9NKe4tAQuJ5RGe7vIeKYeCjWvYkcKSZbxG
 rGAwKKi+K94oN65nAbscigj2gjSxXxrPoqh3zHKkyZ5j2ZQ0QGFGE7Bgc
 UKQ4bgTNV1bvUMsCems5rcGhRT7DAOlP+jy7Zr9Qioi5NsROzmlScwPZ6 A==;
X-CSE-ConnectionGUID: aBjIF9EfSeOWtnYShI0dlQ==
X-CSE-MsgGUID: JBzEN210QCS7giVWAG+eVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="94975726"
X-IronPort-AV: E=Sophos;i="6.21,294,1763452800"; d="scan'208";a="94975726"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2026 09:15:19 -0800
X-CSE-ConnectionGUID: zAOAHBkoTaK7FszwX8dDJw==
X-CSE-MsgGUID: Z7u4uZSnQbin1Ka8aDeJzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,294,1763452800"; d="scan'208";a="212966185"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2026 09:15:18 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 16 Feb 2026 09:15:17 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 16 Feb 2026 09:15:17 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.46) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 16 Feb 2026 09:15:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mBN7fug6+qRbuNHi/FxweLNVh1a6XNaHINYDkPW+JpiF1o3orfu1qbc4sXpn6tSzgIyKx7k3IkSplUiVD2cmkm1mzM7uhCmtuWQ7YN6tNxwJlzBhqeTcBbV5tfCS/WE9WpeQS8wJow1UTc7pbGLk68rG1dyadi9NteNrJ4dbTyf+qdi2PCuaWgxDr0QnkC8wRcsXZQn6ac5hFx4ULGbsQ9wW/temktBTQRJWlkkGnMcIve7uOvQQk3Coxk4C8pf9rpc6sE7zocstr63AY60FtX/YKkRWEt0jL8SF9hiHOGcH9kfQ2dpYFg4iOktj25Fduy5cuiFQpuRe7dhkFSk00Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3mL8fptVflde81fysGFrr7S6/voK6UvPX5U9eq7VAs=;
 b=nIBYb3k60C66gaBECqMfpmqaqm7+fUaTV6I0FrB6t/zZz1H74sWgv0zpj2WUwz8dcBKVvdp+6/d5MgHTMqof0AWIE7DYoFqkaz0qoIHBC8UvY1GD9dyuDPJCWk2ar6Bbc3lEtfmnKSDCR+pYHyMXUGj55GnN4CHkw3ztUiZTkYHxLcMKz0oHbaFYYnM5CQHvB7kdpbKbSQlXQpexxK5U6sK/6nQy7sicvFLH0mC376d7soNlY5cAtuckadHaI6XqpWKPly2TrryjDmHE3nM1nsrsw02Jr7ONOFpBIBV4dZIXUAPrXMm9xOgEDiGBxjZBnLXbSK1iHEPYuZUm1Q5+ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by BL3PR11MB6361.namprd11.prod.outlook.com (2603:10b6:208:3b4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.15; Mon, 16 Feb
 2026 17:15:15 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 17:15:15 +0000
Date: Mon, 16 Feb 2026 17:15:11 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v4 13/27] net/i40e: avoid rte malloc in adminq operations
Message-ID: <aZNQn2mf5sKV1mLX@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1770978324.git.anatoly.burakov@intel.com>
 <cover.1770978324.git.anatoly.burakov@intel.com>
 <59713d4fa172d12fe42eb7c4cdd924aa613dae03.1770978324.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <59713d4fa172d12fe42eb7c4cdd924aa613dae03.1770978324.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DUZPR01CA0015.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::18) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|BL3PR11MB6361:EE_
X-MS-Office365-Filtering-Correlation-Id: 10de4034-bdaf-4956-3ae7-08de6d7ef3b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eEL5wLhVziT6dfdtVxEDJQ5OWco/lNwaSuYTevslM/Ihn5YlibfCdgQ245GA?=
 =?us-ascii?Q?lkHTgUuXNkM6hreiTpo3yV/BqnKLwort2Mcfo34kYCs6yWyze2GSkxc0AvPC?=
 =?us-ascii?Q?g7yTTLYVxw5rvsTib4tOWxIY2cDJQ1IG3cvP1JDT2FCjFgK4MBknwSaEXqVq?=
 =?us-ascii?Q?YDfwy3idNcjDH3w8OiclnMTj60q2ylNElJsfFTtDu6VbgcZxCtr6sJEPYfTi?=
 =?us-ascii?Q?U9BNg1uVbkAkDuWGpwlM/vuypmNK5821BF1jd5iC/sNfwLpCkXbM0Cj0X01z?=
 =?us-ascii?Q?ABFG5dZXnMzNbMJcoyws9rB0Tp6SUEVy5cPUix8KBJhAMPMotN4DTyNTweeB?=
 =?us-ascii?Q?znbW4z68DoH/g4SKkHj5WF48pR5CJkv3aH/zhfWIOLHbJOx4ogDnhKEUIZ6k?=
 =?us-ascii?Q?glsAMnkNFDHIvTrxwM9p5jJmdweYcd+0svMAl0lg/xJgjLCAhKLL7yjYnUat?=
 =?us-ascii?Q?gHLtFGAHPz94IB4i74VDKeIpmaEMVVl7uWa5ykIK/qPXGFfAzF1pGBh1khbq?=
 =?us-ascii?Q?flJ0YaAblZ5lEZffF3no7wkgceV66ZPQ0Vmg9pUdcPY9hJfNNs5mz4+B/8xZ?=
 =?us-ascii?Q?sbLaPvuL9SOmgT5vyFdMP9jqmy9MTyoJTtNkJPRtML/7vckThap+Qglb30oJ?=
 =?us-ascii?Q?FGixPWDGt6Shnl6z4e6+TbCbPOsAVriSIz1TDSTCoe5r8osoGh9Nrrr+vEUy?=
 =?us-ascii?Q?pO9P04aPlnuVRzQOkOXs0wJn5AlgTXot74rGnyQyQR9hXQ4A6FEIedo6nPQP?=
 =?us-ascii?Q?XLLOHjayM9C1sAduNpkpiVH29rVClwNLBajY4I9RrDLs/3tdxRj82CZeY+AX?=
 =?us-ascii?Q?8ZfylgVAuOcmSBFFlh9bxrh5DUUJ9xXqUny8ST0gBkiufPlpx6Q/k2igX8G8?=
 =?us-ascii?Q?rnqPIxljKFx5YURcONLIidz75idOgIJ7Hs+NavIO/1uWG8S/c+VOFxFAyfY0?=
 =?us-ascii?Q?RzK2zxckd20SPJuDis4Yt9JLwj5VZmG+Yp0l7Aa+bYugqwz53xpmOTAcqEdH?=
 =?us-ascii?Q?ayzXoQMPV+r0vR4/OtMvid+yEU0TDXNksH1SRgDJ78LDFTdGV9vDMH+7YHNo?=
 =?us-ascii?Q?s/F7lhcwA2SEHHAqT6jjzYbqmMQv6lUqNdJYCpH86IY85cZkfagNkaewjbqO?=
 =?us-ascii?Q?X0WFUs/F7PVhXJlh798oQkN8HXqmugOIDusEZHdvw4JfPv+Jo1ew+ARycKmO?=
 =?us-ascii?Q?M+Q1nV1wSbYkTF4ho93UnjlE6eOelm/yvZuWrHpOui5MDnog4BC1YZUrT+z3?=
 =?us-ascii?Q?WWmrNr4Ss7BII0eg51cb790iiAcIBT35xUNKntXXGnUAuv0VwQvggtLmeMo7?=
 =?us-ascii?Q?TiEHzAf7Jqds2ioCrnHThV1IezSdrFsijgshdLN7aXHph+DLc8TDzk7l3+iz?=
 =?us-ascii?Q?BsPBG0jDqHf2IzUioNvU8zzzXnfyg2m12p+Wz0rnOr/zoKLlOvqKIvuP/D2P?=
 =?us-ascii?Q?BsCSAUCmf4e3auRu42+H0JOmh1tHDmb8tH3Wal8K1VC1WknA8SnP0J5o5skv?=
 =?us-ascii?Q?YAMvRwhHg8wyUE9tNCRxAkgxz3wpZJ/2JOYXzC0XCExZi+aLuGM8qBJjy/qs?=
 =?us-ascii?Q?BoIf8u4haLpj8eQq+kg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vVtKMDtCf8c1T67ia5ZI2xTv9kRg2aAWcus8dRBvr+Zw85tW1lWrha95jVPF?=
 =?us-ascii?Q?Y3pOYw3BQFPO4YpnL89OjpwWaKpbrJcDbBUpCPwP4Syti6ttuNmSmPjWCyLg?=
 =?us-ascii?Q?8kNOLuoD1NPEP/P4w+jc6ZluHs3X//71+T1F020mcLT2LrfZsV8SOjrm1Iwm?=
 =?us-ascii?Q?8is1dZov3lq6OrTX3zzLHtT1uD5IePdIY3QHLiz/9nXVvU2BgpRFFScHsP0E?=
 =?us-ascii?Q?84I8RoJENeg/La60Gg8/4Vtp3fRk5DgxQKCrhW92s0+ZGpJv20+qHajDcB7c?=
 =?us-ascii?Q?1XoUySpIla7Z8lG8AtFwbWzooHzgiitcAQmX7USFZoHYROIG1IUos8bJ6yIc?=
 =?us-ascii?Q?b4n58LgdHN+4PcI+ubp5iwxxZrYwmMQ8qFRYhYVR4ac3HiQIeiJJoN6nU2Xd?=
 =?us-ascii?Q?tYPeAKitWhq0MloZHO5w/EZfc8qfLKF0QlRePGptgg2heT+rI8HcLDNt2c4v?=
 =?us-ascii?Q?5Zatofgy/c6Y+2zKNCMbcmQY1gFLywOURIKPVA3G0ood8e1FIiKGHcQ63ipM?=
 =?us-ascii?Q?KYcPziSeRQlcjhidhtcgO2oC95HxwWXV1Exa3XkPFDlBrWCv3Msd8NtY0UiF?=
 =?us-ascii?Q?o8uy35yGln+3v+Gv0h9RSr/DSY/4enp6iEpjFeqcOHuYMJVV92GvrE/hcVuF?=
 =?us-ascii?Q?NVQuQouYr7+5ejG/6N4atPVhCP1viCIZc/UtON+rgvuYqqCMcJKAU7VUDl+u?=
 =?us-ascii?Q?rLFzn31AiPf589n2LnZ4yAqMHlnSrFbUOMEUWboURRT0Kndc9DgvkRJsvhWe?=
 =?us-ascii?Q?+xOybRFDAORs9sRfQyPMt7LV4jMdv0zFmOMhl81R5uC+C6Q9eAI14RparmKI?=
 =?us-ascii?Q?25JjIz+rnmMZCFPmQ+fUL7AjfNCOSjOGFgglxmZ48lYkpse+PTDcdcuiuXmO?=
 =?us-ascii?Q?RdxPsbYtbCF70VPMnk2aiLUQA4ioJ6SiYGzjyC7Ntwmzzy5CbFlDRuICgqri?=
 =?us-ascii?Q?G83/JetQ/0DQEMoBeJ+rxAO8LhRqZg0pqXG76pUPvHfiPCPpEQXHUbiwsBp1?=
 =?us-ascii?Q?+JDnsowyyxx0sdMyRvRa6RSE67GBxQMZFmtz63ZUqp6bPcLPbT/64QYlvaDL?=
 =?us-ascii?Q?eW3xj1DtjXEDe6IirGEup4qpQ4Al9BkhnsyHuBqIN0W3Gki90TLGKqJBnGq7?=
 =?us-ascii?Q?qyE4FiO2GHwHglrR6N1Bxkw3gZhRDWCdjUv/UnqsyUIefNDJakIkm5pIULKc?=
 =?us-ascii?Q?Zm9NoGQQFRxep6szgXrjs1Tf3DPTji2uaOQPMp3kDEFOWT12BW4Lhln1ffJ6?=
 =?us-ascii?Q?bDz/46yT31v03sn1MpF46zFco8iJGmBXNblRxa5uugfDv4EMGAVr+ptDkNNa?=
 =?us-ascii?Q?yES2l6FvgaeZsMYbDeB7W09ibKNlLEJusYC7V9zJ6M+OlYnWP/pXlBPJ1wwM?=
 =?us-ascii?Q?QvEnrkwF/6DnJknE5TdSQuON0QLDS9z4BNXtIVNdGJCBPSd7PjgeHXKVMOPD?=
 =?us-ascii?Q?UTM4NXnyLx3YCQ77mqXNNjPOftDIeNKTcNe9SBN5JHASJCTiCtNIH25GCoq/?=
 =?us-ascii?Q?avezCoFqrtxPYhue/qkh+K9j4XNHTqjSatQvyvPbTEQKeiXHIlVmA1HTsHth?=
 =?us-ascii?Q?JEhm9hXuBf5UQ+j5Sq0/wymBy29NeQquMObxrBP1MtYldXFPfs6APlFsIoyZ?=
 =?us-ascii?Q?BD/1+NiB1LywaKDonhEoTOUDVYuyPxLVjgq2ULV6zBMj6cZ/KMTuz0ZXDjQL?=
 =?us-ascii?Q?6W8DXsLHC383wFOCJcPy7ChZKwwoPm75DGObh8PKriSmkPiNYlgx2OZb71Sl?=
 =?us-ascii?Q?hYR1ui9jrueFDYEO4PbamKEEAvRsxRs=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 10de4034-bdaf-4956-3ae7-08de6d7ef3b3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 17:15:15.5948 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OCYF6comg1P7ZRzpatw4i6wt2T42zelEPvbVjkCj46+xPi1UsHkUW0pGGldi83xPMt3R2qrln52Eai/YkZJONDdQITlkDOrrXCzV2pY8ENQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6361
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

On Fri, Feb 13, 2026 at 10:26:24AM +0000, Anatoly Burakov wrote:
> Currently, when processing admin queue messages, we are using rte_zmalloc
> followed by an immediate rte_free. This is not needed as the message
> buffer is only used temporarily within the function scope, so replace it
> with regular malloc/free.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
As done on v3:
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
