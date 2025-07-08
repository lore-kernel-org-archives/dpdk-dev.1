Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061A2C83F0A
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Jul 2025 12:25:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C03BD402A0;
	Tue,  8 Jul 2025 14:25:30 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 765A14028C
 for <dev@dpdk.org>; Tue,  8 Jul 2025 14:25:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751977529; x=1783513529;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:mime-version;
 bh=IuKS3u8NcCBnKybFb0od/57IfHO+M5hHkfjryWiUWi0=;
 b=Ahdi69dacMsVi/BHxE8anHmPxFCw9UmlNqnXz9hUfKh8ehKqJ3zZYAr6
 pcm9ym8TxMyOZW2wq1U2FZPD9jONHtL3LxA4neStzXa2hckvmkKATsbVT
 qxiJInSbfPzSZ646SprBXirkkjThxtz+hCZEuPzP38Eirno2JgaqnAwWT
 uwu1QFSilU6JOczN4q59m9UMGtwBQACHvGqVuEVvPa+XF8144nmomDlMf
 PpmkVSo9vCcf6Mizh5ETwihOMYK3rnY01VrlAebvZIAm7S7dSJj7Wj45z
 BwrAsPULmwyKOsMVkytDF9qru2I/SNCMAw7fdgSJOrIMODAY0WBRDwx6R g==;
X-CSE-ConnectionGUID: Ox+6qnCqROWRQTS8CxlRRw==
X-CSE-MsgGUID: 1S0OPTicQe+wNWT2cBTUwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="54308398"
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; d="scan'208,217";a="54308398"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2025 05:25:28 -0700
X-CSE-ConnectionGUID: C4k2HARpRG2Lfjvn+kSA3Q==
X-CSE-MsgGUID: tu1BiTueSwuhe1J9NyU4Aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; 
 d="scan'208,217";a="154891608"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2025 05:25:27 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 05:25:26 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 8 Jul 2025 05:25:26 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (40.107.95.65) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 05:25:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZO2PZbbssLhSXGlMN3fkwmH77sJSaDDM88Q4cZIega3WqvlovWeBc2U5Ue0u2HjzE+8kgPBqPclxFPWIFacW/FziLIshBzbmo6sPpCtQieEPvTCa+mSyHHng445dWDFlyEjB7/4n7RTdS+bowrarWxbfBmd//FIXbjjJvA42dZDht9KItUSqx77Eueb2o48TDnhQJkMQcB69H7/9pSF3WE20HtQ7G+zF8tLoBtsQfs9GKRRZxJG3970VZX+jN9cYb97zNpEUooY1f9c3tj5tNjpB+Em9yGWwLP50M36EotnRa3JfTqV3dIa3QtprgFLxE6T5U/bfvMTYR4AQh3iALA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HPmoRfbMWZ5GxGnhwpp1TTiOfQ7K5dlfVKonE5aRRTk=;
 b=ZxmPJzptsKo9zfiJHeyk6xVyNAauvcbLZVfxzN1oDEAUS8ALa7kutwiqhR2PYCOWwSCH4O9kVKTTqScTnmynjxcOCynKsp9+56rg3Dvh0OwuAPrX4nNWlQrk4GMYUwDDK8XAnhY4P6FwYalRr2wvJwPEDJVRdkbX+UgkzPOQVVQGjA/pPc+K/lz4fo0WLIKqPUfkDnZvCEtOsVEAijBarBmlTLI7wO+LZvvzKj/t3oLb1KyF9ML3WAwRL+ggmfsOpz1FaeJgUHmqVBMQWWQQmfIxPV+v7GOljIyQyc3VT10EDWoaxMcOcFriBF00Whf5dyiQDnsS8rCPLDcMvqi+Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16)
 by CH0PR11MB8088.namprd11.prod.outlook.com (2603:10b6:610:184::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 8 Jul
 2025 12:25:24 +0000
Received: from IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::509:acc9:5dba:5963]) by IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::509:acc9:5dba:5963%4]) with mapi id 15.20.8880.026; Tue, 8 Jul 2025
 12:25:24 +0000
Content-Type: multipart/alternative;
 boundary="------------Z8QyK0CZoTZWbFLMMnH2ytUd"
Message-ID: <23619b40-1b5a-42d5-8166-def9f0980175@intel.com>
Date: Tue, 8 Jul 2025 13:25:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: support VLAN stacking packet type parsing
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, "Vladimir
 Medvedkin" <medvedkinv@gmail.com>
CC: Bruce Richardson <bruce.richardson@intel.com>, Dengdui Huang
 <huangdengdui@huawei.com>, <dev@dpdk.org>, <stephen@networkplumber.org>,
 <jasvinder.singh@intel.com>, <thomas@monjalon.net>,
 <aman.deep.singh@intel.com>, <lihuisong@huawei.com>,
 <fengchengwen@huawei.com>, <liuyonglong@huawei.com>
References: <20250703093027.1259459-1-huangdengdui@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FD8D@smartserver.smartshare.dk>
 <aGe7uxORe1V817a2@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FD98@smartserver.smartshare.dk>
 <CANDrEH=NEpj8X-8e6JXGVAMGXuykp1bgOMKyLFm1TPBEovdx-Q@mail.gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FD99@smartserver.smartshare.dk>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FD99@smartserver.smartshare.dk>
X-ClientProxiedBy: DU6P191CA0004.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::21) To IA4PR11MB9204.namprd11.prod.outlook.com
 (2603:10b6:208:56d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9204:EE_|CH0PR11MB8088:EE_
X-MS-Office365-Filtering-Correlation-Id: dad250ef-00d3-4596-9b20-08ddbe1a834f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aDVvcXFhN2dKQU1Fam0zT1J1V3VMTi9RdVl6bC80V0VUQWxYMzlOdFNacWhD?=
 =?utf-8?B?YmtnY2JrZlZEcGFjQVlkT0t5RFR0RUdvWEQyNldYSlpxUjY5Zm5IMEM3VS9I?=
 =?utf-8?B?ejk2d3daM05YdTRsS2J4Q1Y0Wm5ONTVDZi9CZXhkMWw0NGsyak9aNUxVSmFs?=
 =?utf-8?B?a0xkSFQ2R3Fpb0lLbXV2di9CZGwwVDRpYzJham9UcTZlYnJyL2FJZmFsVVgv?=
 =?utf-8?B?R0p3VUp6cTNvTHQ3WnQ0dk40bXRpVzUvdjZwS1VHR0VtaXJNZTVhWThQdUhz?=
 =?utf-8?B?MFlkNGE3dCtyMHhrME9INEN6L1Z4eUVuNTFDODJUT2NxYjcreXJkQWcvN3Zt?=
 =?utf-8?B?V3pxcWtDS21qTnZFMUVhRU12a2lnbURlWkN4NXpPRkZKU2cyK2lvWEJsbTdj?=
 =?utf-8?B?ckMxZWhuRTJQaU15Nk5TcG5LV2ZvUVR3T1JlWGxPbUJWMFFNMlN6QUhWVkI0?=
 =?utf-8?B?VjJ5aEx2TXFGZzhoQUNoZzRJSkhDckMxMnRML2JYeTlJU3pJMWxOK3Y3dnRn?=
 =?utf-8?B?OEFuZ0J2eVdYd3FtdmFkS2hjTkhDbDFxOVB0Vk9NbEt0bFNNTklXMkVFaVpG?=
 =?utf-8?B?N1REcjAvb2dUQjQ4Z2lVTjBhRGxaWEQxNU1OZUZWNFN3bm95dGxTWHVWVDQ2?=
 =?utf-8?B?OE0vY1NEcGpydHhXUyt2S29BUklSemp5Rk1GQnRuUHVjd2pWUVJSOGcwd1Ja?=
 =?utf-8?B?dmZhSitNK092QUJkaGMrWVVHMmtzODVMNG0vZWpFTmZMOXl4Q2gxV3B4V2FD?=
 =?utf-8?B?Mm5jRnFmdzNTZzdLbzlmS2pmdTdYT0FmSTljdzlxUnFlUmdIVVJBY3YrZHBl?=
 =?utf-8?B?Zk05NlJrdGdiYWZTYWViUUZMODhiZVFNakRwMWFiMUNMSzJCTU5mTk54N3RT?=
 =?utf-8?B?S01Ra1p2RnZFbm5PL2VjV2F4QmNNa1YxWHozakF5WW9iZ3g3K1VkTzJHRzh1?=
 =?utf-8?B?VkZlTzdHd010MFNUZU1LSk96Ymx6UnNNZjVSbTAvWFc5SHhiVk44eXlkWnRj?=
 =?utf-8?B?aGZhOXEydDl2UzhENWQ5ZWdMd3cvMzZuem93cWwwb0E2ZDFJVmE1bjI5TjNS?=
 =?utf-8?B?SUJjL1FvUjBaWkZOWnkyZmNwZkllY0c1cUQ0SEpvcUZsOHdkdWFmcDF5am91?=
 =?utf-8?B?R0Vzb3Z5VVAvLzRIL1I2Si9GTUVRdmlvdFladnBncmRHY1E2SW9VblloK2k4?=
 =?utf-8?B?UC8yUWNwajZjTlFoc0NhU0NqNXNOZGI1OFBuaTdXMTNGNERKVDc2azdlYmhC?=
 =?utf-8?B?dytRblNZalg3M3JUeHhqM3FERHNRcGpBQkswZ3Y1WVNhMEtXRHJZTUhXN1RF?=
 =?utf-8?B?VmU2N0crSW5SMldaUUJGL0tveTRXMmtISzg5eTQvL2tWNFlnSUk4Z1NPZHB2?=
 =?utf-8?B?dlo2KzZmNVZ4VWxtV2pFemw3OG11YjN0UTBiTHhvTkFuRkRJMVg3bG9RQkRq?=
 =?utf-8?B?S3ZLQU9tWEgxNjlUL011TmZ2d25WUG52emtWWlpCMEJvM2dkbVFCeGxZaCtO?=
 =?utf-8?B?RjNFd2hXK1dMTmVJTndqcTRDMjk1UWk3TVNTY0RkTVhhQ3dmT2szN2pwQmtZ?=
 =?utf-8?B?VjJ4QzY1bkRJbS9oNkd0bDVrS2cwbit4aDNmaE1GOHJVRU5DYjFPWGNNM0RF?=
 =?utf-8?B?QlZmdk1IK3dIc3RBYnZDV0NvUjQvZm90NmF6b1NPRXNsK0lzWkczNlIxUi9Y?=
 =?utf-8?B?UFVYODdtc2Y3cE9iSHUwYWp6aDJKTzhWY2hUOGtBRlFkb2U2MDJHOWFKVnpC?=
 =?utf-8?B?OFVxREFHR0pKOVE3TzJEU3Q0NVRjUGV2ODh3SmdEc2lIajNncTQ5UzZlSmM4?=
 =?utf-8?B?S29YT2M1ODU2U3VhWlo3T20zTFBVYTcyUDZySGpSdXNnSlJUZkU4UTU2dUJE?=
 =?utf-8?B?TU1jTWI5aURQODEyUFBIR3dzYnBkYWNIWkRGUG5YMXFnNWN6TjFmZ1dCSHBN?=
 =?utf-8?Q?UfCLir7C5rI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9204.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3lFZXA3SFZSek84bDlDTW05bUdJOGNJZGF2b0JaV0VqaHVxV3k5S1NIWHZV?=
 =?utf-8?B?NUxmMnNmUDV2MVZwV1FjSXNGVVNtanZia1VBY1V2eFZURHVhOTl2eXJYcm1H?=
 =?utf-8?B?cnM4VTdjY05mUVpORHI4U2pSeGUxVGlRdlJSaG44cXFYMjk4amtKRm5adUIz?=
 =?utf-8?B?NTloMjR3aUZXZ2ZKckJJbTVqYWZTSW4wUUl2aUFTdG5yS3VEL0xLaEw0aDI4?=
 =?utf-8?B?QzNrTXoxYnpSYS9EbCthUDlwRUtKTnRaN2l4L05lM0tSblVjTS83Vml6S3Zi?=
 =?utf-8?B?RDU4NGQwL3hHMnVJMVJJdkVNbWN2WXl0MzduWTl0VjYvbHpxSW5VM1VVVjVw?=
 =?utf-8?B?ZkxHL2JZMldRR1pqQm5PcVluNndIUE1lZENsM1VsYWdtRURROGVwNURTWHJI?=
 =?utf-8?B?UVNmQlJzNkJCWDFRcWNaTGM2YWc2UURSV0RwaW5rSEV0T0pMYm4reTVFVzA3?=
 =?utf-8?B?YUwvWW04azZpOFFBQkhCdzhXL005WnZUdkhRajIreDdHbEttTXRSU0F3cXVV?=
 =?utf-8?B?cTlXVW5XTkF2VFlhc0xFaWVYWVVML1JLZVNGRDZqRGNCRmRpM2taclduK2Jv?=
 =?utf-8?B?RHY1QzdZeFgxUURsQ2d3WHQ0dHVXSkpERzM1SlVNZ1RFYXovdGcvY2YwZFhH?=
 =?utf-8?B?ZFFicnJWcEtEU0JCc3FoQmVZTU5kZlBWWlhXbmwxTlMxV3NUeEpDTFRoRHBG?=
 =?utf-8?B?UU1DUFFqTGorT2g5OVpmcDF0UDBLbTA0Z3ErWXlERGF5SDJEVDBlNElrVXk3?=
 =?utf-8?B?UnFqSWlXcks0UlNheXJ0UnV2ZDhvL2lveWx4Zmp6azg4UVRadDlPQ2N2M0tH?=
 =?utf-8?B?Ykp0RWtyVXpIby9CNDIzUDVGb3pOUVVySmhVMGhjb05UWFVHRnJlMlh6aDNq?=
 =?utf-8?B?ZkpIdytiUzNpMEdiR0ljMytxNGljN2taUURzSjYrcFBZSFc1OTZQWEY1TndY?=
 =?utf-8?B?dUpEdU5iVEhnYlMwbFU5Zk9RclVsQWVxam5kazllQ1d6M2I4cHFTREJGVjVP?=
 =?utf-8?B?VmJXSjdnTWdEdG9Uak9TNDY1Z3h0ZHl1bzVUY1BJUnF4TFQrRWpTcUNyVTRy?=
 =?utf-8?B?Vy85b2QvMTBaL3RzbjBKbVJGMWxPQU9aR2U4RDQvVU9kNEdQcmYxYjJ2eVVQ?=
 =?utf-8?B?azRKS0VCdVVuYkpWcFV6bHIvZmJJcHg1ZHN5c0JpbGZvdnRRRHA3amFrdVdL?=
 =?utf-8?B?RlNGeDZRNkJKczFYUFFhUkVDZmhuTWRaQVBJMmhPZ3Zlb1kzdDZoNnEwUzNJ?=
 =?utf-8?B?cm9ONTFpanFNaXdtNXZyVzIzSG9Gd2p6QXg2R0JOU0YyWmp1ekhxUFZVcXJw?=
 =?utf-8?B?OEFRQjk4TlF6SlRZQVlyaVV2SlFGTlkxV3JVcW9OeFI4bTBBZFNucUFhOE5l?=
 =?utf-8?B?QWd1QmVrQW9IVFdnZjE2ZWxxUDI2VU50U29Gd0JKdUo0MXdOUFFCMU16ZFA1?=
 =?utf-8?B?Rm9RaDRSbUNDL0M3dlpHdjNXSCtnbzZLZU9hT01zdjI2ODh1NnplMGtwSkxa?=
 =?utf-8?B?Z05jY1d3STBkbzljVUJjbi9yL2xBbU5paGVpNlJ3NC8xN1RCSHlYSW5teElz?=
 =?utf-8?B?MWZieVRMNGw4VUh4eHlvYW9lVFhjNVhVQk12YXlVY1haKzZqQzMwYVd0RCtI?=
 =?utf-8?B?VVl0UEduWE1JcEo0RUhWUWFES1BCY0FJUytjM0ZnNkxMcTgxQjZ4RTFyMEVu?=
 =?utf-8?B?cDRzL1NyWHQ0YUtNdGNLUlBhd3doa1RZa3kyN0dGNkhBZjVkVTgxbExqc0V5?=
 =?utf-8?B?T3pRNXZ6MU5pb0ZUQ01IWXZLQUlRMDN0c0gxUzJVWFdjY3dwRDJjUXNsQWRR?=
 =?utf-8?B?WXd4NTB6Z2VxYUpjdmJ6VmV4dHYwU3NZZU1iNXlsbEJhY0FFeHJCNG5meXFF?=
 =?utf-8?B?ZjJUcXlzVGhlVEkrNmRuTnN1NTRwYitPSWwydmpvcE9idlFQRlJ2RjBUSXNI?=
 =?utf-8?B?NlNnem1HaVRNNmlDRnRPZ1FBc0FaeUVRUUN5ZnhOMU1ubTdKN3QzY29aZWxU?=
 =?utf-8?B?cTRLWGlCRlZ4cExiQjhpQjZtbDZ6Tk5mRWdpaERWVkVTL091ejQzNGprVFVL?=
 =?utf-8?B?SSs0bFlGTmRmRVdIWHhZelZBV0tOOEFrR0FSV01ZOFhVbDZGd2NYSURSbWJn?=
 =?utf-8?B?eTZobkRQbmJYMDRPek5EWHdDUXV5WW9DTHI1VTUvNjhLMkRRVXBWTE01dUdi?=
 =?utf-8?B?Znc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dad250ef-00d3-4596-9b20-08ddbe1a834f
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9204.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 12:25:23.9857 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l7aEZP3895XzW8T253O8UaKP7VHxYDFGrnzWfgEn4EjqUwJWMZx/HFiwaz19y/pxmpU5+nZycmTWwyYoa8A2WcbeMlrXuJxuMs4KvL6VRdg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8088
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

--------------Z8QyK0CZoTZWbFLMMnH2ytUd
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit

Hi Morten,

On 7/7/2025 11:00 PM, Morten Brørup wrote:
>
> *From:*Vladimir Medvedkin [mailto:medvedkinv@gmail.com]
> *Sent:* Monday, 7 July 2025 22.10
>
<snip>
>
> That's not quite correct.
>
> There are 2 valid usecases, that may bring some ambiguity:
>
>     1. Some vendors may support mixing dual/single tagged packets on a 
> physical port, (for example refer to the JunOS flexible-vlan-tagging)
>
>     2. Service provider(SP) provides L2 connectivity to a customer, 
> and customer is able to send non tagged frames via SP infrastructure.
>
> Thus, upon receive single tagged packet at the SP exit node (the 
> switch customer is connected to) how does it distinguish (w/o reading 
> local configuration, i.e. VLAN A - QinQ outer tag, vlans B and C - 
> regular VLANs) whether the packet is non tagged encapsulated into SP's 
> QinQ, or a regular VLAN packet belonging to the internal SP 
> infrastructure?
>
> In each case, NIC has to place the VLAN tag in different places of the 
> descriptor/mbuf.
>
> I was trying to make the point that QinQ stripping only needs to 
> support 2, 1, or 0 tags, it doesn’t need an option to support only 2 
> or 0 tags (and disallow 1 tag).
>
that's correct
>
> I’m not sure I understand your example.
>
> Are you talking about packets ingressing on a backbone port (i.e. not 
> a customer-facing port) on a DPDK-based SP exit node?
>
yes
>
> And the backbone is using one individual VLAN ID per customer?
>
yes
>
> So customers’ untagged traffic is VLAN tagged packets in the backbone, 
> and customers VLAN tagged traffic is double tagged packets in the 
> backbone?
>
yes
>
> In such a case, the VLAN ID used internally for 
> infrastructure/management purposes by the SP will be reserved, and not 
> assigned to any customer.
>
Indeed, SP usually allocate VLAN tags in blocks and uses them for 
different purposes. For example, vlans 100-200 for internal infra and 
vlans 500-1000 for customers QinQ. This allocation scheme is individual 
for every SP. And this piece of information helps to to distinguish QinQ 
from a regular VLAN.
>
> And you suggest putting the VLAN ID of the single tagged packets in 
> the vlan_tci_outer and set RTE_MBUF_F_RX_QINQ but not 
> RTE_MBUF_F_RX_VLAN, instead of treating them as normal VLAN tagged 
> packets?
>
Oh no. I'm justpointingout thefundamentalproblem,which istheinabilityto 
recognizefrom asingletaggedpacketwhetheritis an untagged customer 
packetinsidethe QinQS-VLANorjusta regularVLAN,dueto thelackof the above 
mentionedinformation inside a NIC parsing pipeline.

So, given that, I'm pretty much aligned with Bruce in his suggestion in 
a following mail. We can also add a note into documentation reflecting 
single tagged stripping behaviour for a QinQ usecase, so developers 
should keep in mind when they rely on vlan/QinQ stripping in their 
QinQ-capable dataplane. Or, as an extra, we can introduce devarg 
controlling where to put that tag.

> OK, then the “superfluous” VLAN stripping flag could be used for 
> indicating which mbuf field vlan_tci/vlan_tci_outer the VLAN ID of 
> single VLAN tagged packets should go into, when QinQ stripping is enabled.
>
> But: If QinQ/VLAN stripping is not enabled, the VLAN ID of such a 
> single VLAN tagged packet will still go into the mbuf->vlan_tci field 
> with RTE_MBUF_F_RX_VLAN (but not RTE_MBUF_F_RX_VLAN_STRIPPED) set.
>
> So I don’t think such flexibility about where to put the VLAN ID of 
> single VLAN tagged packets is a good idea, if such optional behavior 
> is only available when stripping the VLAN/QinQ tags, but not when 
> simply parsing the VLAN/QinQ tagged packets.
>
> If you are talking about a backbone using QinQ with individual {outer, 
> inner} ID pair per customer, VLAN tagged customer traffic will be 
> triple tagged packets in such a backbone.
>
No, I'm not talking about that. I haven't heard if anyone used this in 
practice and I faced with some switches that just start misbehaving 
after receiving triple tagged VLAN packets.
>
>
<snip>
>
>
>
> -- 
>
> Regards,
>
> Vladimir
>
-- 
Regards,
Vladimir

--------------Z8QyK0CZoTZWbFLMMnH2ytUd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dutf-8">
  </head>
  <body>
    <p>Hi Morten,</p>
    <div class=3D"moz-cite-prefix">On 7/7/2025 11:00 PM, Morten Br=C3=B8rup
      wrote:<br>
    </div>
    <blockquote type=3D"cite" cite=3D"mid:98CBD80474FA8B44BF855DF32C47DC35E=
9FD99@smartserver.smartshare.dk">
     =20
      <meta name=3D"Generator" content=3D"Microsoft Word 12 (filtered mediu=
m)">
      <style>@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";}a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
	{mso-style-priority:99;
	mso-style-link:"Balloon Text Char";
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:8.0pt;
	font-family:"Tahoma","sans-serif";}span.gmail-anegp0gi0b9av8jahpyh
	{mso-style-name:gmail-anegp0gi0b9av8jahpyh;}span.gmailsignatureprefix
	{mso-style-name:gmail_signature_prefix;}span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}span.BalloonTextChar
	{mso-style-name:"Balloon Text Char";
	mso-style-priority:99;
	mso-style-link:"Balloon Text";
	font-family:"Tahoma","sans-serif";}.MsoChpDefault
	{mso-style-type:export-only;}div.WordSection1
	{page:WordSection1;}</style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
      <div class=3D"WordSection1">
        <div style=3D"border:none;border-left:solid blue 1.5pt;padding:0cm =
0cm 0cm 4.0pt">
          <div>
            <div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;paddin=
g:3.0pt 0cm 0cm 0cm">
              <p class=3D"MsoNormal"><b><span style=3D"font-size:10.0pt;fon=
t-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;">From:</span></b><span s=
tyle=3D"font-size:10.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-serif&qu=
ot;">
                  Vladimir Medvedkin [<a class=3D"moz-txt-link-freetext" hr=
ef=3D"mailto:medvedkinv@gmail.com">mailto:medvedkinv@gmail.com</a>] <br>
                  <b>Sent:</b> Monday, 7 July 2025 22.10<br>
                  <br>
                  <o:p></o:p></span></p>
            </div>
          </div>
          <p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
        </div>
      </div>
    </blockquote>
    &lt;snip&gt;
    <blockquote type=3D"cite" cite=3D"mid:98CBD80474FA8B44BF855DF32C47DC35E=
9FD99@smartserver.smartshare.dk">
      <div class=3D"WordSection1">
        <div style=3D"border:none;border-left:solid blue 1.5pt;padding:0cm =
0cm 0cm 4.0pt">
          <div>
            <div>
              <div>
                <div>
                  <p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
                </div>
                <div>
                  <p class=3D"MsoNormal">That's not quite correct.<o:p></o:=
p></p>
                </div>
                <div>
                  <p class=3D"MsoNormal">There are 2 valid&nbsp;usecases, t=
hat
                    may bring some ambiguity:<o:p></o:p></p>
                </div>
                <div>
                  <p class=3D"MsoNormal">&nbsp; &nbsp; 1.&nbsp;Some vendors=
 may support
                    mixing dual/single tagged packets on a physical
                    port,&nbsp;(for example refer to the
                    JunOS&nbsp;flexible-vlan-tagging)<o:p></o:p></p>
                </div>
                <div>
                  <p class=3D"MsoNormal">&nbsp; &nbsp; 2. Service provider(=
SP)
                    provides L2 connectivity to a customer, and customer
                    is able to send non tagged frames via SP
                    infrastructure.<o:p></o:p></p>
                </div>
                <div>
                  <p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
                </div>
                <div>
                  <p class=3D"MsoNormal">Thus, upon&nbsp;receive single tag=
ged
                    packet at the SP exit node (the switch customer is
                    connected to) how does it distinguish (w/o reading
                    local configuration, i.e. VLAN A - QinQ outer tag,
                    vlans B and C - regular VLANs)&nbsp;<span class=3D"gmai=
l-anegp0gi0b9av8jahpyh">whether</span>&nbsp;the
                    packet is non tagged encapsulated into SP's QinQ, or
                    a regular VLAN packet belonging to the internal SP
                    infrastructure?<o:p></o:p></p>
                </div>
                <div>
                  <p class=3D"MsoNormal"><span class=3D"gmail-anegp0gi0b9av=
8jahpyh">In</span> <span class=3D"gmail-anegp0gi0b9av8jahpyh">each</span> <=
span class=3D"gmail-anegp0gi0b9av8jahpyh">case</span>,
                    NIC has to <span class=3D"gmail-anegp0gi0b9av8jahpyh">p=
lace</span>
                    the <span class=3D"gmail-anegp0gi0b9av8jahpyh">VLAN</sp=
an>
                    <span class=3D"gmail-anegp0gi0b9av8jahpyh">tag</span>
                    <span class=3D"gmail-anegp0gi0b9av8jahpyh">in</span> <s=
pan class=3D"gmail-anegp0gi0b9av8jahpyh">different</span>
                    <span class=3D"gmail-anegp0gi0b9av8jahpyh">places</span=
>
                    of the <span class=3D"gmail-anegp0gi0b9av8jahpyh">descr=
iptor/mbuf</span>.<o:p></o:p></p>
                </div>
                <div>
                  <p class=3D"MsoNormal"><span style=3D"color:#1F497D"><o:p=
>&nbsp;</o:p></span></p>
                  <p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;fo=
nt-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D">I
                      was trying to make the point that QinQ stripping
                      only needs to support 2, 1, or 0 tags, it doesn=E2=80=
=99t
                      need an option to support only 2 or 0 tags (and
                      disallow 1 tag).<o:p></o:p></span></p>
                  <p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;fo=
nt-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&n=
bsp;</o:p></span></p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    that's correct
    <blockquote type=3D"cite" cite=3D"mid:98CBD80474FA8B44BF855DF32C47DC35E=
9FD99@smartserver.smartshare.dk">
      <div class=3D"WordSection1">
        <div style=3D"border:none;border-left:solid blue 1.5pt;padding:0cm =
0cm 0cm 4.0pt">
          <div>
            <div>
              <div>
                <div>
                  <p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;fo=
nt-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D">I=E2=80=
=99m
                      not sure I understand your example.<o:p></o:p></span>=
</p>
                  <p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;fo=
nt-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D">Are
                      you talking about packets ingressing on a backbone
                      port (i.e. not a customer-facing port) on a
                      DPDK-based SP exit node?</span></p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    yes
    <blockquote type=3D"cite" cite=3D"mid:98CBD80474FA8B44BF855DF32C47DC35E=
9FD99@smartserver.smartshare.dk">
      <div class=3D"WordSection1">
        <div style=3D"border:none;border-left:solid blue 1.5pt;padding:0cm =
0cm 0cm 4.0pt">
          <div>
            <div>
              <div>
                <div>
                  <p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;fo=
nt-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p></=
o:p></span></p>
                  <p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;fo=
nt-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D">And
                      the backbone is using one individual VLAN ID per
                      customer?</span></p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    yes
    <blockquote type=3D"cite" cite=3D"mid:98CBD80474FA8B44BF855DF32C47DC35E=
9FD99@smartserver.smartshare.dk">
      <div class=3D"WordSection1">
        <div style=3D"border:none;border-left:solid blue 1.5pt;padding:0cm =
0cm 0cm 4.0pt">
          <div>
            <div>
              <div>
                <div>
                  <p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;fo=
nt-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p></=
o:p></span></p>
                  <p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;fo=
nt-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D">So
                      customers=E2=80=99 untagged traffic is VLAN tagged pa=
ckets
                      in the backbone, and customers VLAN tagged traffic
                      is double tagged packets in the backbone?</span></p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    yes
    <blockquote type=3D"cite" cite=3D"mid:98CBD80474FA8B44BF855DF32C47DC35E=
9FD99@smartserver.smartshare.dk">
      <div class=3D"WordSection1">
        <div style=3D"border:none;border-left:solid blue 1.5pt;padding:0cm =
0cm 0cm 4.0pt">
          <div>
            <div>
              <div>
                <div>
                  <p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;fo=
nt-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p></=
o:p></span></p>
                  <p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;fo=
nt-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D">In
                      such a case, the VLAN ID used internally for
                      infrastructure/management purposes by the SP will
                      be reserved, and not assigned to any customer.</span>=
</p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    Indeed, SP usually allocate VLAN tags in blocks and uses them for
    different purposes. For example, vlans 100-200 for internal infra
    and vlans 500-1000 for customers QinQ. This allocation scheme is
    individual for every SP. And this piece of information helps to&nbsp;<s=
pan style=3D"white-space: pre-wrap;">to </span><span class=3D"aNeGP0gI0B9AV=
8JaHPyH" data-src-align=3D"26:8" style=3D"white-space: pre-wrap;">distingui=
sh </span>QinQ from a
    regular VLAN.
    <blockquote type=3D"cite" cite=3D"mid:98CBD80474FA8B44BF855DF32C47DC35E=
9FD99@smartserver.smartshare.dk">
      <div class=3D"WordSection1">
        <div style=3D"border:none;border-left:solid blue 1.5pt;padding:0cm =
0cm 0cm 4.0pt">
          <div>
            <div>
              <div>
                <div>
                  <p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;fo=
nt-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p></=
o:p></span></p>
                  <p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;fo=
nt-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D">And
                      you suggest putting the VLAN ID of the single
                      tagged packets in the vlan_tci_outer and set
                      RTE_MBUF_F_RX_QINQ but not RTE_MBUF_F_RX_VLAN,
                      instead of treating them as normal VLAN tagged
                      packets?</span></p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    <p>Oh no.&nbsp;<span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"0=
:1" style=3D"white-space: pre-wrap;">I</span><span style=3D"white-space: pr=
e-wrap;">'m </span><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"2=
:6" style=3D"white-space: pre-wrap;">just</span><span style=3D"white-space:=
 pre-wrap;"> </span><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"=
9:8" style=3D"white-space: pre-wrap;">pointing</span><span style=3D"white-s=
pace: pre-wrap;"> out </span><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-=
align=3D"18:2" style=3D"white-space: pre-wrap;">the</span><span style=3D"wh=
ite-space: pre-wrap;"> </span><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src=
-align=3D"21:15" style=3D"white-space: pre-wrap;">fundamental</span><span s=
tyle=3D"white-space: pre-wrap;"> </span><span class=3D"aNeGP0gI0B9AV8JaHPyH=
" data-src-align=3D"37:8" style=3D"white-space: pre-wrap;">problem</span><s=
pan class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"45:1" style=3D"white-s=
pace: pre-wrap;">,</span><span style=3D"white-space: pre-wrap;"> which </sp=
an><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"47:13" style=3D"w=
hite-space: pre-wrap;">is</span><span style=3D"white-space: pre-wrap;"> </s=
pan><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"61:1" style=3D"w=
hite-space: pre-wrap;">the</span><span style=3D"white-space: pre-wrap;"> </=
span><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"63:13" style=3D=
"white-space: pre-wrap;">inability</span><span style=3D"white-space: pre-wr=
ap;"> to </span><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"77:1=
0" style=3D"white-space: pre-wrap;">recognize</span><span style=3D"white-sp=
ace: pre-wrap;"> from </span><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-=
align=3D"88:2" style=3D"white-space: pre-wrap;">a</span><span style=3D"whit=
e-space: pre-wrap;"> </span><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-a=
lign=3D"91:6" style=3D"white-space: pre-wrap;">single</span><span style=3D"=
white-space: pre-wrap;"> </span><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-s=
rc-align=3D"98:11" style=3D"white-space: pre-wrap;">tagged</span><span styl=
e=3D"white-space: pre-wrap;"> </span><span class=3D"aNeGP0gI0B9AV8JaHPyH" d=
ata-src-align=3D"110:6" style=3D"white-space: pre-wrap;">packet</span><span=
 style=3D"white-space: pre-wrap;"> </span><span class=3D"aNeGP0gI0B9AV8JaHP=
yH" data-src-align=3D"118:11" style=3D"white-space: pre-wrap;">whether</spa=
n><span style=3D"white-space: pre-wrap;"> </span><span class=3D"aNeGP0gI0B9=
AV8JaHPyH" data-src-align=3D"130:2" style=3D"white-space: pre-wrap;">it</sp=
an><span style=3D"white-space: pre-wrap;"> is an untagged customer </span><=
span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"160:7" style=3D"white=
-space: pre-wrap;">packet</span><span style=3D"white-space: pre-wrap;"> </s=
pan><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"168:6" style=3D"=
white-space: pre-wrap;">inside</span><span style=3D"white-space: pre-wrap;"=
> the </span><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"175:4" =
style=3D"white-space: pre-wrap;">QinQ</span><span style=3D"white-space: pre=
-wrap;"> </span><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"180:=
1" style=3D"white-space: pre-wrap;">S</span><span class=3D"aNeGP0gI0B9AV8Ja=
HPyH" data-src-align=3D"181:1" style=3D"white-space: pre-wrap;">-</span><sp=
an class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"182:4" style=3D"white-s=
pace: pre-wrap;">VLAN</span><span style=3D"white-space: pre-wrap;"> </span>=
<span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"187:3" style=3D"whit=
e-space: pre-wrap;">or</span><span style=3D"white-space: pre-wrap;"> </span=
><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"191:6" style=3D"whi=
te-space: pre-wrap;">just</span><span style=3D"white-space: pre-wrap;"> a <=
/span><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"198:7" style=
=3D"white-space: pre-wrap;">regular</span><span style=3D"white-space: pre-w=
rap;"> </span><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"206:4"=
 style=3D"white-space: pre-wrap;">VLAN</span><span class=3D"aNeGP0gI0B9AV8J=
aHPyH" data-src-align=3D"210:1" style=3D"white-space: pre-wrap;">,</span><s=
pan style=3D"white-space: pre-wrap;"> </span><span class=3D"aNeGP0gI0B9AV8J=
aHPyH" data-src-align=3D"212:2" style=3D"white-space: pre-wrap;">due</span>=
<span style=3D"white-space: pre-wrap;"> to </span><span class=3D"aNeGP0gI0B=
9AV8JaHPyH" data-src-align=3D"215:2" style=3D"white-space: pre-wrap;">the</=
span><span style=3D"white-space: pre-wrap;"> </span><span class=3D"aNeGP0gI=
0B9AV8JaHPyH" data-src-align=3D"218:10" style=3D"white-space: pre-wrap;">la=
ck</span><span style=3D"white-space: pre-wrap;"> of the </span><span class=
=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"229:14" style=3D"white-space: p=
re-wrap;">above mentioned</span><span style=3D"white-space: pre-wrap;"> </s=
pan><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"244:10" style=3D=
"white-space: pre-wrap;">information inside a NIC parsing pipeline.</span><=
/p>
    <p><span class=3D"aNeGP0gI0B9AV8JaHPyH" data-src-align=3D"244:10" style=
=3D"white-space: pre-wrap;">So, given that, I'm pretty much aligned with Br=
uce in his suggestion in a following mail. We can also add a note into docu=
mentation reflecting single tagged stripping behaviour for a QinQ usecase, =
so developers should keep in mind when they rely on vlan/QinQ stripping in =
their QinQ-capable dataplane. Or, as an extra, we can introduce devarg cont=
rolling where to put that tag.</span></p>
    <blockquote type=3D"cite" cite=3D"mid:98CBD80474FA8B44BF855DF32C47DC35E=
9FD99@smartserver.smartshare.dk">
      <div class=3D"WordSection1">
        <div style=3D"border:none;border-left:solid blue 1.5pt;padding:0cm =
0cm 0cm 4.0pt">
          <div>
            <div>
              <div>
                <div>
                  <p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;fo=
nt-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p></=
o:p></span></p>
                  <p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;fo=
nt-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D">OK,
                      then the =E2=80=9Csuperfluous=E2=80=9D VLAN stripping=
 flag could
                      be used for indicating which mbuf field
                      vlan_tci/vlan_tci_outer the VLAN ID of single VLAN
                      tagged packets should go into, when QinQ stripping
                      is enabled.<o:p></o:p></span></p>
                  <p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;fo=
nt-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D">But:
                      If QinQ/VLAN stripping is not enabled, the VLAN ID
                      of such a single VLAN tagged packet will still go
                      into the mbuf-&gt;vlan_tci field with
                      RTE_MBUF_F_RX_VLAN (but not
                      RTE_MBUF_F_RX_VLAN_STRIPPED) set.<o:p></o:p></span></=
p>
                  <p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;fo=
nt-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D">So
                      I don=E2=80=99t think such flexibility about where to=
 put
                      the VLAN ID of single VLAN tagged packets is a
                      good idea, if such optional behavior is only
                      available when stripping the VLAN/QinQ tags, but
                      not when simply parsing the VLAN/QinQ tagged
                      packets.<o:p></o:p></span></p>
                  <p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;fo=
nt-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&n=
bsp;</o:p></span></p>
                  <p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;fo=
nt-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D">If
                      you are talking about a backbone using QinQ with
                      individual {outer, inner} ID pair per customer,
                      VLAN tagged customer traffic will be triple tagged
                      packets in such a backbone.</span></p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    No, I'm not talking about that. I haven't heard if anyone used this
    in practice and I faced with some switches that just start
    misbehaving after receiving triple tagged VLAN packets.
    <blockquote type=3D"cite" cite=3D"mid:98CBD80474FA8B44BF855DF32C47DC35E=
9FD99@smartserver.smartshare.dk">
      <div class=3D"WordSection1">
        <div style=3D"border:none;border-left:solid blue 1.5pt;padding:0cm =
0cm 0cm 4.0pt">
          <div>
            <div>
              <div>
                <div>
                  <p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
                </div>
                <blockquote style=3D"border:none;border-left:solid #CCCCCC =
1.0pt;padding:0cm 0cm 0cm 6.0pt;margin-left:4.8pt;margin-right:0cm">
                  <p class=3D"MsoNormal"><br>
                  </p>
                </blockquote>
              </div>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    &lt;snip&gt;
    <blockquote type=3D"cite" cite=3D"mid:98CBD80474FA8B44BF855DF32C47DC35E=
9FD99@smartserver.smartshare.dk">
      <div class=3D"WordSection1">
        <div style=3D"border:none;border-left:solid blue 1.5pt;padding:0cm =
0cm 0cm 4.0pt">
          <div>
            <div>
              <div>
                <p class=3D"MsoNormal"><br clear=3D"all">
                  <o:p></o:p></p>
              </div>
              <p class=3D"MsoNormal"><br>
                <span class=3D"gmailsignatureprefix">-- </span><o:p></o:p><=
/p>
              <div>
                <div>
                  <div>
                    <p class=3D"MsoNormal">Regards,<o:p></o:p></p>
                  </div>
                  <p class=3D"MsoNormal">Vladimir<o:p></o:p></p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    <pre class=3D"moz-signature" cols=3D"72">--=20
Regards,
Vladimir</pre>
  </body>
</html>

--------------Z8QyK0CZoTZWbFLMMnH2ytUd--
