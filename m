Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F52C28B20
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Mar 2025 13:10:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ECE7C40674;
	Fri, 28 Mar 2025 14:10:01 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 2DDED40269
 for <dev@dpdk.org>; Fri, 28 Mar 2025 14:10:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743167400; x=1774703400;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=GhPzXVQiMmwbv1wkIq6000Wa47ItjO9nEWbWLTZSCLw=;
 b=gW05GnD5QtkAQFFh1lUjZ2h1i4qZW5/BJh9tCWgC/3nqLU7n79Mgc5LS
 qVSs/ZpHtQDyWwezPI8DqA/W4+ZIlwXz3QCjvH75wW0atzOtRkdCCfcJR
 yJWbq8mhb2SSpUmN9kHfbSuehU9hiJE6RnqD0I4AITGFo/nCpgpCZa7Cm
 srl5wq8f4NCHBDRpLVWtYCycfZkfeXjvmO7DBiCVWCNpXtUaxqvvvEN25
 J/MWexTu0TnaY8tp2mMkYDkxA4ZNK15Lqe0TQmiVBt+z60cVJxIu1Vixz
 N0+TKFQgbfXHpewIngxdYcJg7cUhPX8HmreTWNwr/GLl7IjhjAW9xHWm6 g==;
X-CSE-ConnectionGUID: pUN9f01pQYuONc8oOi3bzQ==
X-CSE-MsgGUID: oD0jcfqJSlyMjet2SWc/3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11387"; a="55174494"
X-IronPort-AV: E=Sophos;i="6.14,283,1736841600"; d="scan'208";a="55174494"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Mar 2025 06:10:00 -0700
X-CSE-ConnectionGUID: 2o1X16N7Q5CfteIRbFMXNw==
X-CSE-MsgGUID: V6ylFX53T8uE/R1W+iHIYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,283,1736841600"; d="scan'208";a="130147866"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 28 Mar 2025 06:09:59 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 28 Mar 2025 06:09:59 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 28 Mar 2025 06:09:59 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 28 Mar 2025 06:09:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JmMy2mSggk7J/xgcsJDhJnD9brHBEfm6DCOoxLGJ+g9jH4xZhO5E1djGZHAL3vQRjveex3uCmoLlcGqXaiturPiDLj2BOAcPJ9OKfLvI6NKluuD1jErujFfvH7dmjVLYRliCSJ7/YZNlTHQ9L/zUdXfqs9O8CEVzbhOgmNjYthmbc1eMfozceH+2deGNjdYTmhGGqNB7jd8YnLxP1RiDcdpYV+MNjT4vTuGEn/z893EZrGG/CszpUr/dgzxYakTl/kgtG9KZZaso1FkYKJ1c8DN3DawQBCxMbUKqrgOje4LF5zm2JcGL9sM0D0k6a5Fx0sajBOPjfDBUuRjeBTDvPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9uZuqexfPI3+ETtXrXOgjo/711j0xqoE7h4EiEV7erU=;
 b=arvd4HKP+AADmyzksZQo7fCK19xKBo0Tf6/kfOpik2BN5a0FR8ZoWJUQXm0nUSXpILw+NchGMYtPP/NZwjFeJAmuAt4GNwwLoiNyjaOlEJC+cyszpF4Dd7fPPNVuKa6wC4c209Djh0Ncc1A47AL+UF9bo6scSVa9Tc++PYZt0+yic1wt/5Vm+RansPTc38qcU+1aRXEf2Y3T+C322y+B4inMeHgFh07tc0Y+TlWHMHnhWo4FZXRAhcVBRXCto1326eDutVMRBi8WUlmlRcKtXAyLqgsX6p704T+y6u4CWtyTVedEznMU8Q1wbD6H577iSH2bEYeeKrgTbXFw46osZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 CYYPR11MB8388.namprd11.prod.outlook.com (2603:10b6:930:c2::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.44; Fri, 28 Mar 2025 13:09:55 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 13:09:54 +0000
Message-ID: <2f2ecf08-31bc-4a3e-93ab-c86d97699043@intel.com>
Date: Fri, 28 Mar 2025 14:09:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 9/9] net/intel: simplify base code builds
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: David Marchand <david.marchand@redhat.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>
References: <20250326155230.1315056-1-bruce.richardson@intel.com>
 <20250328111621.2665257-1-bruce.richardson@intel.com>
 <20250328111621.2665257-10-bruce.richardson@intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20250328111621.2665257-10-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0056.eurprd04.prod.outlook.com
 (2603:10a6:10:234::31) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|CYYPR11MB8388:EE_
X-MS-Office365-Filtering-Correlation-Id: 53b67f86-def3-44f5-bc4d-08dd6df9d527
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MzdhMnUybU52WDAraE11cVAxaU4rZWZRSFlaQi9yQ3VaSUIxcmhPYmJKRWk1?=
 =?utf-8?B?Y2FJOG1NMDZWNTRackVuUzhpaVpadGpoR2NrOHZ4V0YxdUJzUklVM1ZWUnhW?=
 =?utf-8?B?Wm5Tblkyb1lxWHV3TlJ2ZG8yc2FsNWF4T2ExU1kwcTA1WTg1SVFaS3FOcVA1?=
 =?utf-8?B?VW9ZRXRTZDAwR2pGUzFrbjFEQTgwbzgySlh4ZUtiZWtxVkZvckJoYXNWcEw5?=
 =?utf-8?B?NU9JS3hIWmg5bUR5dHpEZlVpODZVSjh4ci84U0RhL3FuREFvdXVvSGxQUVo4?=
 =?utf-8?B?MEpvU25LNTdhK3krU2RwZUszZzJqWitqeU43QWpDMFJwTVJlMmJPcnY0YTVn?=
 =?utf-8?B?Ti9yekhsOGZEeDV2Nmdnc1lxeEFUaUlXaTVIc0Y0bjBFbTlGTTExOVF4Tm51?=
 =?utf-8?B?N1A0MEdsbEJwUC9uZ2xDdXd1QklIZGx1VUtOMUlTSnM4WWdmbDd0cVFMeEZp?=
 =?utf-8?B?WjI0VUkxMHJib2U1RVJnWkxUQnB2cEh2L1ZMOHFhNmcrRVI4MzBObDRKWXYy?=
 =?utf-8?B?QSt6M3FHMmFpakZZZTV0UnFnNDZXQkVsRUVIN01zK3VESjhWVHdtOWxmUXVV?=
 =?utf-8?B?Mk5JeDJIOW5NZmdOTzFCZ3oycExHcTlXWXhRT0VIbXdxK2w2UkhJS3d2ejhy?=
 =?utf-8?B?MFhocFZESGlwaWpqY3R1MmlDYk82UlF1K1NESitoUEZKdDZxTGVwQWw1WmRv?=
 =?utf-8?B?WS9xRE5CeHJXNzAxY3UyT0ppWEQzaHZwV3dIK1kzTFFzR3BTY296QndoOHVQ?=
 =?utf-8?B?S3F0c3g0M1RkeHo3SE9ZTHhwdElRRy8yZzloYndlcExoL2FkMTBVVlYzWXpl?=
 =?utf-8?B?dll6T25hOFlOdlNKQzZSVis1bTBUb3FLcElEWHkvSnpzSlMrMVhZZU1iK1k2?=
 =?utf-8?B?WTRyeDBFNHN2SkhYL3o0a3VoWlJWTnZHa1Bsak9UL1hIcHNocFNUSnpHTnRr?=
 =?utf-8?B?WUdKeHpDbUloTmxiTWNBeElUaWNMbit6Mk5rSWNTM1VUS1dqOHEzYTRsMWNk?=
 =?utf-8?B?NSthTjgrcGgvY1dTN0hGR3F4bDJDU0toT3U4WFhTdmNsbE9TQ0ljQi9Tek9M?=
 =?utf-8?B?S2hDekRERVFwYzR0eVlsOFFZMVZoL2lIVlhlbGJkbmlJbzl0U2hhRVMrOGRV?=
 =?utf-8?B?MW9nLzlRZzh2RUtaM1JZRWtkZTFDZjY0cHRpSThjTmVpY3Z2bVRBYWtoM293?=
 =?utf-8?B?WEZZS3hJQUdGcDVRUi9VWmE5S3kvcnludnRZVjM3MjcyNU5MNmlNMy9TVzZr?=
 =?utf-8?B?dWZIUUNhSG91Q2NOYlowbUhKcGU1YkJrYlRqc292UGdpZVRORFFpRUFxcU5B?=
 =?utf-8?B?R2Q0RTNENG15K0VUTGI4T2pyWXNBY1c4UC8rYmVnVkNRWkNucDZ0V2JBRzdo?=
 =?utf-8?B?U2FzeFpXOENObENpanNiK3F5UC9nUG5idmsyaWd2V09WOC84dktFbXlXbk1z?=
 =?utf-8?B?RUp6bVNBQmhUZk9ickVqdGxRZmtZTFhUMk1xc1BxbzFKbXRuM0JRcXBkUjdV?=
 =?utf-8?B?aVlhQkhlRDZ0ajQ5N3RBUm5wVEdwSFdKSnJwcTBqaXpJL1JmSFJiaExFcjhw?=
 =?utf-8?B?QTFGSFpVUnhGNnBURzVsai9RT2c1MzlqNTl5aHZmb0Qxd0h1d0dtUHZ2V2RV?=
 =?utf-8?B?OTNmb1dYV21oZTd4T1c3bHNJb1FRcCtCU2dGandzZUpLVFk2UUd3V0g2TEFj?=
 =?utf-8?B?dVpCbnZCUWJwQ2Y1aER5ckhXellGQnF1b0tVV0JOVTY3R1FnNnJ6V2UraDUw?=
 =?utf-8?B?QnVDcVczV0ZOTDZHV3ZVUVh4T0hjbzZReitSU2tjQ2xZVURheVgzT3pZVjRU?=
 =?utf-8?B?TWxvZGpRQTlLU1pnSXpWcUk4ak4zdFNEeGovZ2hpZzRBbWYzRzNoNlZ3b1RG?=
 =?utf-8?Q?pb4O0ygQtjGvc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWYyVGhFb1NWZkE0M2pGUjhnU3g3eFZPKzhjWml6RkRFdzJhdEFPR090QzZh?=
 =?utf-8?B?RDBzOUM4ZmVtMVlJUDNVb3BwT2lVd3lnZ2ZLVzJabzE2V29sVmxYM1c5MWxL?=
 =?utf-8?B?aFRSQjVzMGxSdjVKWEVHTzNLQ2hycGFsUGR6d3cyZmpqbU9wb3lmeU5GeUhX?=
 =?utf-8?B?WHpZRGhwVEYzQkl2MWFXQVRsSVRSZU8wYkpYS29KK0JsYWJCUkgyajRqOG00?=
 =?utf-8?B?U2ZoWWt1TlkrTUpBSHF4eDdNaGU0RnNMZ2NFQk85S0lNdTM5ekdUODFTeUJQ?=
 =?utf-8?B?OU9MNS9Ya3I5akF0azQ4NHdEQVRjWUJ3Q0hjR21pQWx3OVZnRHpBbXdDTmhE?=
 =?utf-8?B?S3grMFVlRFN5N2hxZnlwYjdVdERFd3p0akFwYUZUYWhDaEtTZmw4SVhaeTJ6?=
 =?utf-8?B?anAwL29vNWxBN040NWYyTVV4bW1abXNJZXB1dEh3eUdwQXhwcFhjM0JBckty?=
 =?utf-8?B?WmJkZDR2K2NjWllnZjY3OWhya0YyK1FBeDhNS3hPbTBNYi8yMklYNzdyQVFH?=
 =?utf-8?B?Tkp4WTVWYUY5TXg2RzlIc3JyM0F0MEc2VWwxNVd6NFpPbVFkNkltTU91eUhx?=
 =?utf-8?B?M1BVOHA4ZmE0eUxBOTVUQjc0aGR5VjJPK3pQS1c4bmNrWmJWdzhBb2dZNDFi?=
 =?utf-8?B?NFNtdEd3TnhTeGRKUGwwUmV1NUhXT05Dc2NmU1dZeFpobEhNUExvbnVOWUow?=
 =?utf-8?B?N0s4ejdZK0R0ZW9sMkVnUlB3TVY2OUFLT3VUKzZQdGVtZlhQMFhDb0tkbGZk?=
 =?utf-8?B?SkloWmJhSjMveHJncDhoT0Zxc3h1bUdQOXZ6M1I2RmdBZStBTkNNakJseGZw?=
 =?utf-8?B?VkY4SkZtQkw5TXNtRVRHRHhoanMwQmh1R0IxcThpNzVHcGxDV0JPUStGR01j?=
 =?utf-8?B?Y1NqODBCUW1ZUGhBTmRNZTcwaXpPcTdJaHpJeVc0anh0bFo0Q01ObThWVVFk?=
 =?utf-8?B?MmJZVVFtamEyZm54WXNEMkVKQTFXSy9saEVlUENBL2dqS1NMc2JTa3g5MUZm?=
 =?utf-8?B?cW5XVTFSc0MySkJmVy9Yc011OXMvU29tcjhESDRqM0Z1MFBhZnRIdUZVSjRk?=
 =?utf-8?B?N09pWVFSemVFa01jczBiSGpmNndmZjZJenpCUFpPL0k0d0ZKY2JnVkh6eDVw?=
 =?utf-8?B?My9KZmN3R0ROai81Zmxya1pGcnh3ajAxN1c1ZWVtWFBVb3V3RVJWTVA3Sjhz?=
 =?utf-8?B?YUIxSVFBZjNGSTFYdThvQU9ZdTE2RlFCYnJuR3dFSHM4dXFaU1ZieXpyZkNF?=
 =?utf-8?B?TWtDeHV5RXNLL1JQWldQT3ZGYm0yUDBYMzQxTFBrT1lQOE5zNkpSbTZ4dzIy?=
 =?utf-8?B?VnVrRmNYbnFCYmtHUlJvNTI0b0Y2cTVHRFdLWGNHcDUvR2FldG1qWDRwa3R1?=
 =?utf-8?B?Sk56YUYzK253ejRBS29sQTdtQi9vY3NrZVBHYktIbHVscnJ3WXlpRkFNamhK?=
 =?utf-8?B?RFgzejJjbFIwaW4vcW5nTk5RSFZWRk9mUnlUUlkvMEFDTVAvSEg5V2hZckh0?=
 =?utf-8?B?RWNiVzQyVmFWTEtNWHduRE5RMHpHZUJhTEtxd0VmelZHQ1pOazVrUDZROTln?=
 =?utf-8?B?OHFyeEV5SXRrYVNNeitXQjJ5Q3lmbHpkTlRxaVlJWm4vaDJKR1FaWVZxZksw?=
 =?utf-8?B?Q0t3WWt3bUpmSkpHNmJVamFDSEdoaDVFdXcwbUtjLzJKeWc0K0VGQkFDR2hE?=
 =?utf-8?B?R2FPN1ZIeGJCWnFWSjJSWWtvcW5qaGZta0lndndqWDVIbFgvTjJFM3RWSUZV?=
 =?utf-8?B?b2tCR1Vqa2tZblowejlUampUYmJROHBVOTJKTnVjTWdGVTdzTEwzYjlBd3NL?=
 =?utf-8?B?TUFXVTBJM0pFTDF0QkVFYkk0bnRXUU5tOFFjcDMzaTg5U3lKdVdyMjdqR1lN?=
 =?utf-8?B?emhDd3VCWno0bkVRQ29nMVBtajhWZ1B2QUp4R3FlbEVqeEowSG1WelV5QnFs?=
 =?utf-8?B?TkVuekJFVytqVlg4ZDQrbTVoR0lRTWxYTGFvbkZvZ3E5OVhBenBPS0VBNC9X?=
 =?utf-8?B?SkhkRmJlcXNzUlBDVVdmWXNlL3p2em5RcS80VXV6M01TbGorbUs4NzZaWEtZ?=
 =?utf-8?B?ZEM5SWJ1eDhzUlFUQzdndU1YaXVxdWRTUEVoWU5lSm9NSEg1RFV5TjZBZDd1?=
 =?utf-8?B?STZWWGRNV2w5TUc4T0FKYWF1b012SFF1dk1USWdETHlIRzY4a3NPM3NNdndG?=
 =?utf-8?B?ZFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 53b67f86-def3-44f5-bc4d-08dd6df9d527
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 13:09:54.8450 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hIaeaFQMdNfdBmzjWcyqzFA2yPnWDZRP0r9zoQzn37jSIgwOuU6pZNSJ1wGJ+yKfggljLBkgbFVH6DtJ8n9VqbpTm0GYNRFDj97Y7bLUWUg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8388
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

On 3/28/2025 12:16 PM, Bruce Richardson wrote:
> Now that base-code warning flags have been removed from a number of
> drivers, we can simplify their build configuration by just including the
> base code files in the regular list of driver files passed back. There
> is no need to use pre-compiled objects.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---

Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
