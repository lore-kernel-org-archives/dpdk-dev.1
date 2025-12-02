Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D6AD12663
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Dec 2025 18:16:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B832A4021F;
	Tue,  2 Dec 2025 19:16:40 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 062AA400D5
 for <dev@dpdk.org>; Tue,  2 Dec 2025 19:16:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764699398; x=1796235398;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=WuyG7/A26ZRVS+7iGVjavyYraFytjPh7YwfBmEN4yI0=;
 b=aTqaeKyemqdqfogJK7pEPMj9E6b93ufb8S1DDo0tVVdazOU3P+dRPjoX
 pTozC0ZAI7aPXNKKu/TNBRD6evpiJhyEizg8JKAIbVf8JMeKhjaiCtZo3
 2w3pLtioGqK2z8ONj3r00o4vEvd4IUiYFfbADzOxSCn/dUJ9Azj0amwQg
 V5yle6YJPUa3r/LYf2PlOyh7rLFV30IsIZYQJ5h4yjH4uTp7eihGvqOb5
 EHVEdH2RhQXYE9HRsHu83NtSjFVFg7fE+jQUvuKDAnH1OHGqvBaKNTnYF
 S2W4p9twrAGsPLDGUTozchFWI2fhKFFuxkw+hCxLtev94QdoGRa//9wG4 Q==;
X-CSE-ConnectionGUID: tVSRCmhOS8CbW03x8p7rGQ==
X-CSE-MsgGUID: v28CVg6FTqC6qDEbvCB3cw==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="66713777"
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; d="scan'208";a="66713777"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Dec 2025 10:16:37 -0800
X-CSE-ConnectionGUID: i1ota+vnSrGrevpu/ZtFow==
X-CSE-MsgGUID: qqKkoHV8SYSQCHFjDILTlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; d="scan'208";a="225404470"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Dec 2025 10:16:36 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 2 Dec 2025 10:16:35 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 2 Dec 2025 10:16:35 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.8) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 2 Dec 2025 10:16:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=erWTnpAy2kkLOPKnWS6P+GXADLVIwaYMaNCxF6CK714TlptSGutw/4eSpal+xTOKHHaSDY4HiAR/efi8llRxd9DZ+Zesnn/Wdc2TyZ38CGitd8/YuOH+dHFMoFLPie6oYpKA27GTkaf5xrUkxG+fhuQ3kKid6XdFWTTnhXju+V3/jF8ria5p2enGGmC30f+ZQjbXZh59GLfvn6NEJ/ORomQIeZVdH6vurLN5Gir2nhMdIwoOfzsGi4Tlmq4kdyUhutDjzwtu0JsgTc0uLZeueUIeYnXwGbA5CxJ9Kz2QwTXWIHhq54VzHJM2SzZaW+6PS5+7f8ZpmQqmWUxzDz7muQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/t64NYIDwB9M9U8ViU4d3cyQo1HYCq1RGlOMvBT5O2Y=;
 b=pXU9M9MBvxT1C4tafgw3sU78q34rM0xVLFV+Ra2rnJbNGS4KF/XCF7Uht4elPA9JxKE6ZmyR0VjLU4az7ZAYMV5u7CcBpWCM6EnPn/YkrknUU/G49Ph0lzebRd9R3DpIgtQvxcupnlR2fWOehm8IxzxvISFMftNW/bdG44RXfFMo7dPYunwCAbkbVOWq3wtLL+hWp3WZE/JDgL0JjsDQbIWGoyGheVhgQfS11OiM9DhMgmI/AE7Y1AJ92y7WwhFMuHY0RqW7qalZSJqu5BIwyn0f7dObCQevavbBe/j0WeNCl7bYaG6TwiqK2H4tVDHnpX5+z1vSPW2ANehzZFnRug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by BY1PR11MB8127.namprd11.prod.outlook.com (2603:10b6:a03:531::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 18:16:33 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 18:16:33 +0000
Date: Tue, 2 Dec 2025 18:16:27 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Marat Khalili <marat.khalili@huawei.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH 2/2] app/test: make parameters clearer when adding fast
 tests
Message-ID: <aS8s-y8Tobd2Qgtt@bricha3-mobl1.ger.corp.intel.com>
References: <20251202154948.1757169-1-bruce.richardson@intel.com>
 <20251202154948.1757169-3-bruce.richardson@intel.com>
 <58ce8da5c4094fb4b292fd58d068fc5f@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <58ce8da5c4094fb4b292fd58d068fc5f@huawei.com>
X-ClientProxiedBy: DU7P251CA0013.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:551::34) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|BY1PR11MB8127:EE_
X-MS-Office365-Filtering-Correlation-Id: e3577d5a-6edc-46a9-d507-08de31ceec5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?odm4TCbA5rLNSMbXcjBmoh1k57YnFblhhesbcJ1WUva+OL1xEWoDtHUf2nVc?=
 =?us-ascii?Q?oNQGUlgZQUQ2/VPJFod91z4zitKmSQc5p8kLYDGeRMGdHqQmZUTAmO8AKpjg?=
 =?us-ascii?Q?NKAtxRXVwSquVFq0ZieQPGXyS0qlc1qMnHv1TV0n4QPL4HB2GzmBirYcJ0IM?=
 =?us-ascii?Q?OGdMHHUtHStvUEB6PtzxrXd/v21IvdJ5O3F4e8T8R+u9c+9y3kJST7Sd0NMB?=
 =?us-ascii?Q?jF7x/VBqsPlMZNXnv2ndWOu6eyfxgAeZDd7GjbXDY6dL4sG+dGiFHWcZ/ZYR?=
 =?us-ascii?Q?rWWTYGRn2d8NIK1P6a2KOmrqTxogD6HVfl5JWqHp8qS4gzxco99nDZrlB2Vb?=
 =?us-ascii?Q?6yK7NZSWpA/nc6CC/zW7tFyJpqzFg+4NSZFYAJUnYubq1j/tRjpj0fcAH1V0?=
 =?us-ascii?Q?pMCqfB+lJHTBkqQXhPWoYIMdbErIugczM3URngp9brJA7qv4238ZX3tray8t?=
 =?us-ascii?Q?c492HLeJKmw3+7PLLWYxtI3SegFRGoWf3Di4BBrVV6SWiT9oj54TvF+1J9+W?=
 =?us-ascii?Q?inJVDz3q7rBJFd/QFuCklqFsW3hPRYJ1n8wwrB0nN+1Nbq75WwiD4rva+0hy?=
 =?us-ascii?Q?9OhCPSZ1sIoxSqHRFt7JIKaTGppmV+b1fcRi0N5FAsvfCPPlWVJZsueLZ1cz?=
 =?us-ascii?Q?IzY0VXr4JV8PNIbkuWbXzsx/8mqiATcmbNE4aoFu3+GtDQYKvKCnbPxh0gid?=
 =?us-ascii?Q?s77hT4W1aa22Hkd0JTDPcMlTaF55/kJ/zovKk/YAEGz7Wy0IwcyrIYdii6sy?=
 =?us-ascii?Q?yu4mP3oMBvEf5XwXpWQ9M5SiC/80FImNP2+etwugsqKCsN/ZwPvZDuiIjgmu?=
 =?us-ascii?Q?47TxFp935ACYuCGjBy2yVgAI9U2CFNl24d1g7zZRCrc9AUdgKc/vSczRHshn?=
 =?us-ascii?Q?FwYAH3wlY2nJ8T/ki/8mIjJ5BBYqQ1q7qG8PgA1R2hkIQqMkAhziYCqyIuqZ?=
 =?us-ascii?Q?fpcpub2qOUvNzHTXFPliHLdV8MSmmXBwvwGNfGKmkrDLNf9XJ0nntx46G2/T?=
 =?us-ascii?Q?kI3Qm8MlIbkbCuVy754Ws4JuthVurifqRH54b2/VOQCCki5NKvEUAXP/jNMR?=
 =?us-ascii?Q?/uROqcSE2WQQTdCF2uWnDyADpAU3nBE96Z/9WmCVFdhm0d2n2On8+ha4gqwF?=
 =?us-ascii?Q?BtoerwX86mcTxMYhwJoBP2py9IMhAENEJ4os7XRiU54y2tnquEgLkKuSGZ8L?=
 =?us-ascii?Q?zBaTTmzZ2D222qcJ3hDhTE+zuB63uncFd4Fc0vbf56wrBaUtieNUp+mORe0V?=
 =?us-ascii?Q?FFQmG5nQwY4kb3CKk24JwsLXj6BsHgOaqS65Df/b7lxUULG/w/N4a/iPyX5u?=
 =?us-ascii?Q?3u75+PJGEyTGFkxGjdpGC6S4Y2t25obM0faK9vfKEBM7WWWP4IV8x1JCAWni?=
 =?us-ascii?Q?THL6sW1GoiZ6nyojicZlMzXgCo+VLDYwOmRn1tG7lRCsCfU+4RJq94yGz964?=
 =?us-ascii?Q?9NgZfv5mH/ccPJOKAi8oa/VR5iiQh9Zg?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tMb0OTWLavVBcTjD2kFrj8XJG8JwofUSPHM9huiqSv1uHA4FQLTDEQQQyCE4?=
 =?us-ascii?Q?VW3XoLtijF063mAKSXw+7pw+wxi75nIdX9wctc0X7Jb+MIPO+38nuPPia2vl?=
 =?us-ascii?Q?2ke+3WMBpZQxFPuoJHzmPDTqGp+IdqpVVnBG/80300wxDDLoiVw+f/0Lj7kl?=
 =?us-ascii?Q?0HSQYvF/JXc144GKmUMdmPrTgH7pSd+5ADsJV9WifO6xCQjiCJnil4Zqbp78?=
 =?us-ascii?Q?tuwQIHPr18nrq6JlMZp3X6IZQFfu9YuGbCr+F05o4ChRg+L70bQP0gyfos6X?=
 =?us-ascii?Q?ZsoUuS+QSVH9a6YUz8GClZPU6ERuPBfMMPxOYFsVCaF/H5yTJrxSQaDyyX7k?=
 =?us-ascii?Q?+1eBMS81muEzV47H8YHU3ZMbqGOXBtimFiDQTBj+T22Lff9ZkoFpRdfk1nL1?=
 =?us-ascii?Q?r4o0GwxSj3pzoAqgUmzsvTxY/lcKBUiFo53tJ7EfXWOTNjtRrws3/bmC/GSZ?=
 =?us-ascii?Q?xOCXy90eQMi+ITBd8PT2f0+fPlxIxMteFhDOV+M2+BGvrFGDLFmczesO0yEZ?=
 =?us-ascii?Q?1EBQuofDgEz/+XGk1YiTWgffSdnkiUN2gMfWkk1OMP0MOyYoJhtVBn5Q1VNj?=
 =?us-ascii?Q?fW6JkefeMNZo50Mt7m7eCHHAHez++dVE1NUPW7w9atffZmDiG7J6w80r9nrn?=
 =?us-ascii?Q?5gYyIVMJXMEu06KMgmGXs9r0HgtRdvNfa/6SJLsMRgnrA/3lMF/VlnPOf0bA?=
 =?us-ascii?Q?ej32h7EXCybF57TjxUF0WD+DNZ9PH72510j8QD39E6MET/qxHPAhqVt6x9Dz?=
 =?us-ascii?Q?CXcbtbdGmYdQcPCrODCu86xmzZMlba3OB7JRB0oQIr6jWSxxaI2qD9gSjbTJ?=
 =?us-ascii?Q?fXPrjSErQ/7M+vjEkueUv2z2rbhYpiTGDCxyWsEm29/GPF9ZfkHK2LT6HnHO?=
 =?us-ascii?Q?QK7jS9Y0Va/lutNFPcaB466mwy+qRoxQbuMTRfRID3KQjcqikHX5sho/0S2x?=
 =?us-ascii?Q?+2FYb2S6U1s0Q2MhJNntwkDc4fbgFVupsRDrhgl66VlOBxrqzESu7z49Lhk4?=
 =?us-ascii?Q?0JDVaCZ34hTDy4GZpX0MImTblQbqNlsGcSewpL/cl8gP9OQ4qMQdwbvidqeH?=
 =?us-ascii?Q?R9AlxC3+1Sh+HhFsYjhS4gV+srAmlKqlCsGp+XIrD9A35Cs/cGQc/aQ8h57w?=
 =?us-ascii?Q?k6kpzaKJ/lk9GrJ8Tmsm9SQQWJ3biue3qHlqE/01fZS5zQ68gd4UyPbZuRKN?=
 =?us-ascii?Q?6MoXyHAALDPiVzPZPUjIy9B3xvGfhxCGmt0ett7tOsx1bwc/eecIc4fJPTMY?=
 =?us-ascii?Q?HNwVP1klK13zodGzi1lk7iC0hmdv6GlZ4QKEY/SxnOz5FxgRi0T7po2MOxru?=
 =?us-ascii?Q?pfZPBykVF0S2orZ6i9NEgT7DlsMF/hqWmBP0EqadFN8QNdv3z59T8/rrVMxS?=
 =?us-ascii?Q?yGNnHhVroBx53a5F79vJCQrMIek2hoRn6oRT+RoLS8V4gV6LNAINDRyTH11I?=
 =?us-ascii?Q?Ps3kFyKbGnnlHyOT6aS0hA/SdxwTyTj5Bl3pQZx2PlkS3fzaoQP9vc1KZeE2?=
 =?us-ascii?Q?dAOkO3QBPutkym7kPmxI1lnSlW94+QRwLNTQw2leIh+RA2cVy6y+ydH/PCMU?=
 =?us-ascii?Q?Xjn0PhSNXlJrmcqylFTcgDUn5aEWX/ed0ICEyaHLHQxhM5kCRkewYtWS7lz1?=
 =?us-ascii?Q?Sw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e3577d5a-6edc-46a9-d507-08de31ceec5d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 18:16:33.3990 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EwE5hU6ZNpbZP+LXI+rquMIl09YV04wjLAjIkMa7jmaUhncJCyu3HOLwaotyIaeJSf3pPxUXCUNwoiHLDUbPRSe3n8wzsnQ0wAbFydcask4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8127
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

On Tue, Dec 02, 2025 at 04:53:02PM +0000, Marat Khalili wrote:
> > -----Original Message-----
> > From: Bruce Richardson <bruce.richardson@intel.com>
> > Sent: Tuesday 2 December 2025 15:50
> > To: dev@dpdk.org
> > Cc: Bruce Richardson <bruce.richardson@intel.com>
> > Subject: [PATCH 2/2] app/test: make parameters clearer when adding fast tests
> > 
> > For the fast tests, we have two extra parameters specifying when the
> > test can be run without hugepages or using ASan. The true/false nature
> > of these parameters is not very clear, so change things so that they are
> > explicitly specified as NOHUGE/HUGEPAGES and NOASAN/ASAN instead.
> > Explicitly validate the options in the meson.build files, rather than
> > just checking for one of the pair of options - which can hide errors.
> 
> I like the idea. However, I think that NOASAN/ASAN is still not fully self-documenting, and may be misleading. Without reading some docs I'd think NOASAN means test will be run without sanitizer and ASAN means it will be run with. As a minimal fix, what about NOHUGE_OK/NOHUGE_SKIP and ASAN_OK/ASAN_SKIP?
> 

Ok for those names. Nice and consistent.

> More intrusive option, to simplify most normal uses and highlight exceptions:
> * 0 (or DEFAULT, or RUN_ALWAYS)
> * SKIP_IF_ASAN
> * SKIP_IF_NOHUGE
> * SKIP_IF_ASAN | SKIP_IF_NOHUGE

Yes, that's more intrusive. Not sure it's worth it - I think with the above
names things will be a lot clearer. This is also not an API for public
consumption, it's just internal flags for meson when configuring the unit
tests.

Will do a v2 later with the flags renamed as you suggest, unless there is
other feedback in the meantime.

/Bruce
