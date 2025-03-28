Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45797C28B20
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Mar 2025 11:14:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 53745402C1;
	Fri, 28 Mar 2025 12:14:13 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 719164021E
 for <dev@dpdk.org>; Fri, 28 Mar 2025 12:14:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743160452; x=1774696452;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=T7gEYmSw9jVcrlZamnIHTnUqBbMofLmPsX3VAVpGs3s=;
 b=C9I+69dkMK5nnqS8YqgytNucUqTKSMhVhy1EBw1stn7nr8vDcnXWioMy
 NUrtfp3Y3OPnv8mJ3ap3OHWYXBg6hWigY3P+kItaLbOVfO7DoD8/x2V8d
 0Gu7S0Q9zdAg2VScISb6pBgkC+6zFqLWYe7bS46OUUmxWs8FgvyJPwVlr
 oub1dhEUHMTxNxNwaZFTKAf0DoAgTju3DQAzDJP/BeBrQdFHG1coqAFwW
 W/cZvQDF2MuQQsMsnAHPaD5N08PUtqoaDnUKaC+r8v8zZsh5cRGwXlCRt
 tAVi6kaqXmmuswO5DbLJWxR8pEOLAqfqRilsXEAoKQy0cDB4NKyB05JBw Q==;
X-CSE-ConnectionGUID: iLbP3DkAQTy2b2xmbHH5vw==
X-CSE-MsgGUID: QWrwsNEcTfeNj9SJsuurNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="44411249"
X-IronPort-AV: E=Sophos;i="6.14,283,1736841600"; d="scan'208";a="44411249"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Mar 2025 04:14:08 -0700
X-CSE-ConnectionGUID: jX0natw4Qm+jcAAArXO8Og==
X-CSE-MsgGUID: CpHCwYFpSJ+aDhtWAX0Zag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,283,1736841600"; d="scan'208";a="126231236"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Mar 2025 04:14:08 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 28 Mar 2025 04:14:07 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 28 Mar 2025 04:14:07 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 28 Mar 2025 04:14:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eRSF4p6NcH/BowBmRfCvyJG5DAxru1VLYxbbr/LJg7ez9seR3LxlCObA5+EhyMtGc2ps/BqxFefMw0Ybcg4tu/ZDB3jRf9YE+hz24yC60mneamX1D7gQdzfV+xvB7NkulEKeYGXzRZtusfvrFwLTNVshyz/8sQ5T5jAHt4r7J5B5mTKJ400pJB85re+A5Oo724n7F+UHUjltFcfuXduPXqF9NwXZClvXGo2NAG0UgMWRD6o4w9sbNaLIKqxo+APerzxtMdPkop9STBBVZ4bbX0wQXzVC89E+rlWvvebZETIYmgWV3NoMUtAfJQU+yc5eTf3KknFVl4GiTHswOtDmvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=anbS5+6/NAWybz5CTmBQ3St1pcMHjph7+xWOzonmIzU=;
 b=Jn+A9M0PRb542D9yua2e2T+vZZUT30SH+Tc3J00gjqq+8pQLVYZ96yMfV12LZymiB/Za5PuhaH8aSSGoIi3otMuO+IM6XtY8rrk0w8FifdY3KQIvj2HeO4DX2ddILhSrR4n+Xi5VXiZ7iORJEpsbsrTS4ZM9LKNabKIxVHFxobgnhuGmIa9PGv2sjb71cFCgp1vK2UTYMIphITHRJ1oSJLRYostnZunPH/MnX/L4XODAWTlsTmv0SjxsSpmwz+UXxsnPRQzDBNMp04zSHC3fUKO2dKKO/XUdUhKBUKTZ+YpIqjz0/o2ZvJTBlp5wQX8abOSmriLbYvkzUJ/Syv8wtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by BL1PR11MB6001.namprd11.prod.outlook.com (2603:10b6:208:385::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 11:13:30 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 11:13:30 +0000
Date: Fri, 28 Mar 2025 11:13:25 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Anatoly Burakov <anatoly.burakov@intel.com>, "Vladimir
 Medvedkin" <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v3 5/9] net/ixgbe/base: fix lock checker errors
Message-ID: <Z-aEVfpMjF8-Ycwk@bricha3-mobl1.ger.corp.intel.com>
References: <20250326155230.1315056-1-bruce.richardson@intel.com>
 <20250327145202.2220153-1-bruce.richardson@intel.com>
 <20250327145202.2220153-6-bruce.richardson@intel.com>
 <CAJFAV8w8YT=2DVbxrXef=60AquicaU8xehG2fvdHye_9dMi98Q@mail.gmail.com>
 <Z-Z9ZPs8k_lQERpT@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z-Z9ZPs8k_lQERpT@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DB8PR06CA0016.eurprd06.prod.outlook.com
 (2603:10a6:10:100::29) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|BL1PR11MB6001:EE_
X-MS-Office365-Filtering-Correlation-Id: 24c9bc9e-097b-439c-124c-08dd6de991f0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WTltUGdpdXFIdjAyUWx1ZEFsTmtRNnNndXBqQnF2aVRRVDRVblc4NDRsTCtS?=
 =?utf-8?B?WWkyb3J3cWR1N3BpdWxRdlJrQmVsK09wYzMyR0IyeWVqdVVGSE9vN1ZKK1E2?=
 =?utf-8?B?WjBsSTdUbVplTUZjVENHWFY1VzhINlNCRjE3K1JrcmxxUFRnZUFuZjBwTHVB?=
 =?utf-8?B?OGJZSkRaeWtaWnUrMldLL0ZvbHllaDQ4ZjhITHNrUHEwTmVlVENJZ1FMQXBC?=
 =?utf-8?B?RnJxNFlwMzhsL1lZemc1NnQ5VlRZdWNtQjJheFNPR1pYYjhCWG9Ec20zLzRx?=
 =?utf-8?B?N3FLWVhuMyt0dDJSRC9mZXY3SUpKWklUOGFDeXNnUjViUUF6QngxRUJtdVF6?=
 =?utf-8?B?VWpOSlREMDYrMGVzM2tSdVlvVkJvUmhJZk9CZVdQSEoyOVJKNFl3Si9ZejBP?=
 =?utf-8?B?b2ZiM2dYOUMrT2kzemY5S2psZlIybjc4ZWxwbkowbzhBKzZXTWxqMllvR091?=
 =?utf-8?B?SGpJYmVQanhZcjNMK0g2by85dGJGUkQ5NTk2OWRGTlEwVHp3NFlueC9zQzJk?=
 =?utf-8?B?T3BqMHZmRy9qOTl5aDR3UnEwYk54ME1YdXBXaTdMS0lNaThuWkxMazROMlFv?=
 =?utf-8?B?cERScjBVaEVZMkdVSS9HZGpqVzRrbXUzcSsySDdKd283OGp5NTVCUkhmSmJW?=
 =?utf-8?B?ekhIREtjekFaN2l6Z2JQQmFDWjdXb2I3a3FRbENxakkvWnEycVVPOTBmTHNV?=
 =?utf-8?B?RXdpT2g3b01UbFpCZVFQSUF3akFBUy9TRndGMmJzR1NuMEtwUUlqaWpvUHFo?=
 =?utf-8?B?RjI1SlVCMnN3QTYxS3FUaUNnQSt4NDhxZFZIM2Eva2pMMmdaQVdlVDMybUts?=
 =?utf-8?B?VGNlWG9jdzJhczQvcVh5VEtGSVhhRXIxMG42NWN2N2poc1lRajh0TFlqMThm?=
 =?utf-8?B?V1BVWHBueG1zOG5mdE1ONXI1Y3hqM2l4TVU2UVdienpoNmYxQ2MyYmpsc2dl?=
 =?utf-8?B?K1NpSU1rbDdsSjhBWjlCTmg5RFAva3RmenNkQ0h3R25KTzN5dHJOalk1OVo1?=
 =?utf-8?B?QkV2MkY1T2dXT1ZPbHJrRDF1TTRDWUJyNzZGZkdSM0lDZ0xTdVF4enZFci95?=
 =?utf-8?B?R1kvK0RYNmhDS05DL2Nreno0T2Y3UGNSOFNkaHlLaVBSbXgwN25OR0NMRWxK?=
 =?utf-8?B?VTBIZDZVZ2dMcHpDcWFLWkZudUxPOVJVVlJhVDBtaDlucFJDTml0VHdzWWR0?=
 =?utf-8?B?anlNQWNwWUlGNDEyQWpkZldzQW0wVHVERVhzenZNaWNhcDhqc05HeUJYME1w?=
 =?utf-8?B?djJNdHFaTTkySENMc0V0ZCs2QUYzL1VuYVpFaEFZcWhmRXRJOVNMNjlKektF?=
 =?utf-8?B?TVIvODk1aFgvMnNzSmhxZFNMS3h1NTZvWUNmUUdXTmlMZmxvZkN3K1p0M0Fu?=
 =?utf-8?B?bUIvU3M5cDZTZVAyVFA0OWRZOFNTd1RDR0RqM24yWjRMTk9aZFRXeWVTblpu?=
 =?utf-8?B?eDZGNDMrczhHbWgxTGFtYmxWOFlLT0ZwUkxWZ1MxbjFmR2Yrbmx2RVhNTmJK?=
 =?utf-8?B?Y0xzZkRxZDErOXJ1V0MrZTlwSGNQdy92RVltdHNrdllSR3cwbWJiSm9pa0FZ?=
 =?utf-8?B?VGV4cXhoWVJ3VjFGa0lpTXpIUDRDMlkwM2FMWmdkL2Rja3pJVGwvU1IrZ2pu?=
 =?utf-8?B?UVVMTGZvSUtwMEF2R015OWFFWGhielhTNzczS1RsTko4U21JMEhxT0x6cEF2?=
 =?utf-8?B?SlJiVThVK3RtRnd5VnY5d0Q0cjZBS05SS3gyMnVhNks5c0MvMDg5QzVQR3JV?=
 =?utf-8?B?ak9XbzBISGkvR3NZYlgrVStzcFNrbkJhcUw2L3h0Q0ZDeFB2VCtxaHRtNWFJ?=
 =?utf-8?B?SDN3ZXpvMU55VFR1NmtENzl6Ukp3YVNQejNncXFudUFTelZvN3dwZFhzMVB3?=
 =?utf-8?Q?ZHAjIXauuXZ7J?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlpPV1ZQTWVabWF0R0dqb2VvUmYvK3k0aUh0QTBCT25relFuTXdZYmtZWTRZ?=
 =?utf-8?B?aFdBcDNNZ2sycUp4TmRIenRJajdVaUYydjdsdzBTUkh3dmhOa3ZodUUwMDBy?=
 =?utf-8?B?RnpnRThWRWpKWDEvMG05SUM0ODAwMitzbjFSQjdTNXlSckZGVlpmWHM4R0NL?=
 =?utf-8?B?RjdKMDlEOS8wck5IOGhJY3NnZlN3WDZaTDgwNkZWd1JXMEdDR1lGcXJkR1BS?=
 =?utf-8?B?cjZDYTVrelQrWCtSSHhKY2tMbkpRZUdjay9pcFplQ0ZrbTA5ajJabEVNa2NL?=
 =?utf-8?B?TU04N1NsU2EzTXRyZUZwODNQclNZUXNGRDZjUVF0SWhxZ1Rtc1d1QWZjUDBi?=
 =?utf-8?B?TEwybmNadldkTnpjVU9hRGdremlhVmlsazU3eS9qUUo2S3haR3dFMkxxbU5I?=
 =?utf-8?B?d0FPZ3pnbWZncmh3eVQ1YndiSVZCTk9MSmtHajdQNWpTUGpZSXJxSFF4aUJq?=
 =?utf-8?B?czZvU2k3ZXZqc082Yjk5bTFkV3o1eHI2NjJVcklOU05ZR29FVDB3cVZwVk9Z?=
 =?utf-8?B?VmxSdmlOdHBpVkJIZ0gveVNhY1NIdHkzeXEwNERJVUsyRk1kZWFET1hhbnV3?=
 =?utf-8?B?S0NaMUNWUk1lMDRid1lMK3pWWTBXOTBoU21xalU5ZU1kTGJZajdYdkFwTzUy?=
 =?utf-8?B?QWFZNGxqTFI0VTl5R0lwYmp1TGRqd3ZLUUJuNUh6bk95c0F1WXpnUUdxdm1t?=
 =?utf-8?B?MXJLbDlpUlNXTVJBRkIwNWpUWnJPanpqbzJHY1dNTWpTdjlyWnJueEhpSFA5?=
 =?utf-8?B?bjZKeCtoaTR5dVBwUFh6WURkY0RSTVBwRzdLYytaMitnOVduMkx4bERGbnQ4?=
 =?utf-8?B?SVJ2RmJTVXZ5NkN1NndBNW43MlVvVHdONGRNM0NIbXl5eDlkcFplVjdSUERF?=
 =?utf-8?B?WWRDNC9iblBXMUl6TnFNOTdIKytCUSsrc05HY2o3R2tEemZlYzRFeE9BUncr?=
 =?utf-8?B?ZEhzZG5ZeXF1bC94RTZzMlE0Tll3TzI4eE91cDhoRTFtbUJhOTQ2bG1IUVZL?=
 =?utf-8?B?VnJNa2Z4R3c2S3g3VXVHU2svWmc2OUpPTzlUd3Y1b0dtRHFlNnpUbE5Ieksv?=
 =?utf-8?B?Q0N3K0FaWlpSVHR6VjNMNjNXZDcvVVR1T2QvdnpYTWd0QnBGcGpERTBkQ2di?=
 =?utf-8?B?REFtS09DVzNqVngrVXBRZWhqcDEwSUxLMHV2Ry9xTTZicXpTR1h1OGxMT21j?=
 =?utf-8?B?bVFwdHM2L2M1dTdPSkhLTWkxZG1TbGQ2cTFPRmZMSTZmWWtSeU44aEo2OGFY?=
 =?utf-8?B?VnVpR2dJQldjcDZWMjd6WDlmTXVSdjdSOUJNMkxvNitlL3g3WmdRbW1mbUl0?=
 =?utf-8?B?TmRLRW4relpOWUJ3N3hWVjJMcUhVRXRGUGhEdmpqdXBqVXZpNkxGakdKcmFy?=
 =?utf-8?B?VzNzdFlQUHllMWc5c0R0dVVUVDMwQzE0VWtmLzErcFJzMmdxZ0FoVFJPcTBU?=
 =?utf-8?B?R091UmM3czkyeU9pUW5MZ3MvMnQ5OGNlM3RzT2FxOThMNjlkbTRYRFlCNnRz?=
 =?utf-8?B?cTEycGpXenVra3c3cFpUeWFCeVlCdk95aEoyTkh0N05wekhzemlJckp3ckp5?=
 =?utf-8?B?dDhUeGowN3BpblU4TnFUUU1JY1FjeExCaVN4N1JHemVPci9ybDNoQW1xWmc2?=
 =?utf-8?B?QklWczhkTjZhQmhNeDJKZDJ5dHdHbGNoMlloaUFKbm0zQ1lyWmtvc1dYTGxP?=
 =?utf-8?B?ZGxGYjY5S29sMkQrY1ZoSllqV1RaMEJkMnV4cG5kVXg4cVBSK2dPeWhINXlQ?=
 =?utf-8?B?K0dVc3I4bnBPNkJPc0Y0ZGI1SXhGZDlhelROcWtUbFFWTHY0SUx0MU9CUDFo?=
 =?utf-8?B?aWN2TmVvb2I1dThzUGJVV2UzSFpWdzFibm1lRGRsbmZNbUtqQlFRYkNTSnBp?=
 =?utf-8?B?RFZ4cGZDUU9uQWQ2Zm5FRFRhRkt5Qm9YTGwxWGdzYllyaG5vdFZXRmxKakxF?=
 =?utf-8?B?djZRRE5oRlA2N1FFMmZtV3lhSmxrcTA1bkwvYnN4KzZiZ0xiNXlZK2FZRE8w?=
 =?utf-8?B?K1Z1bWFKOUNTMEVoUmlyeE5wU1hQMmxEZUlhVVZQZGxRTWlLU2RQOUg0NkFD?=
 =?utf-8?B?YWZBKzVsem83dU9NWmczVzlJYk5kR0x4dzBaaDVhMXc3bVZDM0dnV0Q4TDht?=
 =?utf-8?B?Y1NBakJ0WEFOUVdxQUx5UnBTeUhxdVV2THFPbmc3OWZuczhiRWpCcFBzYXBO?=
 =?utf-8?B?a0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 24c9bc9e-097b-439c-124c-08dd6de991f0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 11:13:30.2029 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kZ/52rQMGcnaOAkusXgHNvOridXt3otLVRBDaiPhvI3HF1dBMNGoeezmDTbUgtAjwhASLl572mcYhykule/uavH+xPAMDrOjqyT6lplDvLo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6001
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

On Fri, Mar 28, 2025 at 10:43:48AM +0000, Bruce Richardson wrote:
> On Fri, Mar 28, 2025 at 09:20:16AM +0100, David Marchand wrote:
> > On Thu, Mar 27, 2025 at 3:53 PM Bruce Richardson
> > <bruce.richardson@intel.com> wrote:
> > >
> > > When building on FreeBSD, errors are reported in the base code by the
> > > lock checker (-Wthread-safety). For example:
> > >
> > > ../drivers/net/intel/ixgbe/base/ixgbe_osdep.c:42:1: error: mutex 'lock->mutex' is still held at the end of function [-Werror,-Wthread-safety-analysis]
> > >    42 | }
> > >       | ^
> > >
> > > These errors are due to the checker not recognising the lock wrapper
> > > functions. We can avoid these errors by converting these functions into
> > > macros.
> > >
> > > Fixes: 30b19d1b5c43 ("net/ixgbe/base: add definitions for E610")
> > > Cc: stable@dpdk.org
> > >
> > > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > 
> > This is the best solution, given that FreeBSD pthread is instrumented
> > with clang thread safety annotations.
> > 
> > As a sidenote, I don't see much value with the remaining
> > malloc/calloc/free wrappers in this osdep.c file.
> > I suspect this makes some other annotations non working.
> > 
> Yes, I would tend to agree. Question is whether it is better to convert
> them to macros or just move them to the header file as static inlines. I'd
> tend towards the latter, because otherwise we'd need to use "," syntax to
> avoid potentially introducing other warnings for unused "hw" variable.
> 
> Here are two option examples, WDYT of each?
> 
> static inline void *
> ixgbe_malloc(struct ixgbe_hw __rte_unused *hw, size_t s) { return malloc(s); }
> 
> or
> 
> #define ixgbe_malloc(hw, s) ((void)hw, malloc(s))
> 

Doing a new patch revision, actually using the macro syntax, since it keeps
all the changes consistent, with all 7 functions being converted to macros,
and allowing osdep.c to be removed.

/Bruce
