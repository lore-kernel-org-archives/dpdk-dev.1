Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5CA9C282EC
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Mar 2025 12:35:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 117FE40395;
	Tue, 18 Mar 2025 13:35:54 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 63FF2402C4;
 Tue, 18 Mar 2025 13:35:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742301352; x=1773837352;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=feN/ySORsxmhk3YmM84xi6fWmq3gVBLKbzFLe7Pfoys=;
 b=GGqU27zwsBl1oNTV7VK6MJXFofSwzdrsq9y+pE/LHBwmeIObR6bWguy7
 ISuJMJZjZl93oqOD600/shM6adSfvNHVajsIY8ca51TPtXg9LPD0IUGsI
 1+NctFkIOmDP+b4rOTOqit4jML33rm2McQKE48bbh0YAGtTcCrdugZ8/k
 GpfY2MRflnAECpM+UdZKFBx5rVJgxs2mi338HQCSRjs0Z1Rvs7UwMmkEJ
 099OsMRaENxs4QRMPYypnc0hW4QYRzVCK7MZRUz13sTJEw/ajI7foRqj8
 w2IDdDsKqJOoftyFlfyvXXcThRNRJWIAognP4rj/l/wTVOTFgpELuSXkx A==;
X-CSE-ConnectionGUID: VbNSvaGtROiVKuDCRXGHZw==
X-CSE-MsgGUID: FjzDbudOQ/mY2imtNnZWLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="60830629"
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; d="scan'208";a="60830629"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2025 05:35:50 -0700
X-CSE-ConnectionGUID: VHxZLLKiTQ+aDWuMDMHI9w==
X-CSE-MsgGUID: pDXj8vIrTzOfufmmt1kWuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; d="scan'208";a="153237299"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2025 05:35:49 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 18 Mar 2025 05:35:49 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Mar 2025 05:35:49 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Mar 2025 05:35:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XC9MSozZXvl7NnKmn+1famtOZu2S9M3nDVUO+5xxZaaV+ZklRIAt23YQY5VoWcJmSuYkO95Iz8QLnvMgcp8VdlwNGnoK/UatV54SbEaiT+3yeZVqxajFUCZhLcHweEY9mZPdNKYOPhtHiZQCV2UqKJUMZChLyHSs1FY8FYs4FprMLqE+oGiadwS1Hyirm6FBG++gqg2/qZmV1vIIEdZuasilQlW4S2i/svDlYiwT2NOUwY6RfiDv1JU/Qzd9XwfyH3h5dMBXrYSX1L8wnqMkkk2/ViPrJkvRgRWxHJvDKzvr5wVfw+kmhyQAfYWvHj5iWILrjA3mVPZUlSG9xkQ2Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QqRWcrXBtd07zd2oh9JceRGvItDaaYOIPvRYQoWXkAw=;
 b=rNnELz62MUNLF2lQm1pKzq1AbevLLvhecGA24wxguWerTs5wlZg0tUT1YSazN/Ugcy3wv2C2+/VgC0bHorBZwVO/N9CTq8iq3ZCQLewaTsmglvl/2/IX0NVw54IMGzK6FRAGdQzDwb6pMzkpx2VN0iTgZ9Sog991eITNcl9jYotsviPhMIwAIE8PrKDyMxy7MHInwO+EHYMpkjwPYWWwHe0fyAOC8uYldDsJPjgWEZjngXUoj2Nch5mULpzoFM151/euo/at029qAmFK5Rw0uCWHTacMtxgby4x8JEKxQBeZ919FEA2EebTnJBWwN6qB0XevYrfQ599Xp9oUAtnrnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5772.namprd11.prod.outlook.com (2603:10b6:a03:422::8)
 by DS0PR11MB7577.namprd11.prod.outlook.com (2603:10b6:8:142::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Tue, 18 Mar
 2025 12:35:05 +0000
Received: from SJ0PR11MB5772.namprd11.prod.outlook.com
 ([fe80::5851:319:3da6:850b]) by SJ0PR11MB5772.namprd11.prod.outlook.com
 ([fe80::5851:319:3da6:850b%5]) with mapi id 15.20.8511.031; Tue, 18 Mar 2025
 12:35:05 +0000
Message-ID: <3c869fa2-e34f-49c7-a8ac-5aa5bfa05caa@intel.com>
Date: Tue, 18 Mar 2025 12:35:01 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] net/iavf: fix missing check for interrupt errors
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: <stable@dpdk.org>
References: <20250310131116.557117-1-bruce.richardson@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <20250310131116.557117-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0226.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::13) To SJ0PR11MB5772.namprd11.prod.outlook.com
 (2603:10b6:a03:422::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5772:EE_|DS0PR11MB7577:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e34e043-203a-4aab-45f1-08dd66194f54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eTFDSEJvOGd6RnVaeXBRdlhuam0ydmFFazg3UFBCQUFrSzU1N3dXTVJ2Wkwz?=
 =?utf-8?B?TjBVYnhQdHlHQzY0cklpa0llWWhwMDdDaHlWV3N2aTRsNll6K2QzUi9hRTF3?=
 =?utf-8?B?QjR4Ny9MOE1YWXNncmp1eDRjWEZ0aFVjMktOS09zVmxMZU82MWdKSGlnc3VK?=
 =?utf-8?B?eks0UzVnME1YMWZROWxIb0hpbDVSOXRPK0FheW5pQ3RZeEtrMWFNU0dhS2xM?=
 =?utf-8?B?UGxrOHB5YXk3RUlDUnM3dy9UbW05ZFBDZ29ubVZKQk43WXdlK1JNRUNVL2RQ?=
 =?utf-8?B?NE9uSGhRUHRoNFJTUnJmRDdaa0dvclNLaHUwQzc5dWlCMGhhVWJxdWZWVm16?=
 =?utf-8?B?cm93WUlpRVFLREI5SHNHdVVLaWNTa0w0L0s3UUdFcWFEZk15bm9Ga1IzMzVZ?=
 =?utf-8?B?TVlRYXlaYitsNVRHc0lsZFlBeWRWL3dFNFl3aUJodlVVbklodGdFSHVtZ05X?=
 =?utf-8?B?NFk5VVJhRVdLTlJBS2pPdkNaVDl4WlFqYk92VHFkVTNrdi9yUGdLMVJaT1pn?=
 =?utf-8?B?K1NUWTV3TzVOZTcxSWJhNVVzM1YwTTJVb3gzUlE3MDhCekJnQjNCaHBMaitO?=
 =?utf-8?B?dW03RU5tdEozaU9GdWJKWWk5Q2p1MmFiZlp4ZWhOUVhrTmtDZUloU0ZnL1J6?=
 =?utf-8?B?SlUzNUx5MlJuYzEyVGlZOVlGbnBONmwrVGxGQUhVZlVlbnZBRVptMFJ3bmZK?=
 =?utf-8?B?OTUvUGkxQm9vTmZCNjFnQkk4M0JZMFBBZk9ycEcxNzZwY3hKRDJIWUJOM1V5?=
 =?utf-8?B?QjF5WG9VQkJHVmJmcFpFM3FNNEF1SDFGZmJ0aXJWZkpaLzRIdmxJSVRoRmhM?=
 =?utf-8?B?UjEyeXB2ZXl1Umx3cDRSVHZ5TzBtWGxUM1Q1RFhFeXBhSDZDR2RZQWNXcUFZ?=
 =?utf-8?B?ajNwVnFINWdCYVZ5VjVDYmdoRlhXTE9ESWkyeDN6bzd6REhGaGJxeWlvZWsr?=
 =?utf-8?B?Z1E4Yyt1WnUvSDMwQlVTalp4OUZydVdranRMbjhIdUF2WUx6eTF6Z25zQ09S?=
 =?utf-8?B?Uk1CbnFBYVpoNmVnWXZZUDh4amU5dElhZmZ5b1p6WGJDWnBOTDR4aUttRXFR?=
 =?utf-8?B?ZUo3NmJxSXdScFBxbDNqSDRsaXhBU2ppMDU5alVrZVpsSXhiV1Z1TGJ6NENT?=
 =?utf-8?B?K3dZd052WnpFT3ZlWlhvTTJoNEN3ZTY2UDVRMmxpR1l6eVc1dW9LTUJ2aWJw?=
 =?utf-8?B?b1FIL2czZkRLUWMreXlhVHJTWkxmaUgxTmw2VVZzT2VsZGFsT2RacEZNU2dM?=
 =?utf-8?B?NHd1SjNxRWJuK0JLQmI5S1JqR1Q5OTg4LzRtcEFlZ0NDd29wTHBESFZmUGh2?=
 =?utf-8?B?QTVGajBacDJreVlNSHc5Z3RsRXE2SjRSTk9YNWYzS0xodkZpRmQ2QlAyck9x?=
 =?utf-8?B?cm12S3M4VkE4NHN4UHA4VXRxZFNmdmo5K2EzaVlxUGNaSGl5ZEtCYjlPMjN2?=
 =?utf-8?B?SjhTRmpzLzI2Q21tNDR4OUNIZ2t3NlNJaHg3NEo1aTVLZ0djQnpLd1kzRWNV?=
 =?utf-8?B?ZFhHS2NxaGdpNFZ2aEU4bWMrajBnZktEUlM1R3AwU2M2Uk43MG1yakd5YVJw?=
 =?utf-8?B?ZWMweFpTK2FKdERnNUg5enZIV1RKUHg5ZTlpSGUyNlVvcnJNMVpGNERjQlYw?=
 =?utf-8?B?N0RWWDlIcVJpVnhaUU02UW8waGNiUG54TTcxcC9ZdVhnZ3pjbUtyaDlPRnBp?=
 =?utf-8?B?cVNjYmJKZUdxZlFCVEZtSGpHUy9VZlI4L1hkMlR5SCtoYWNQQVdodUh3ZGdQ?=
 =?utf-8?B?S0hGQ3B4eW5PY0dzUCtxa1FSckRhUEV3WE43SERZNjRqWjBac3pJOW1XajY4?=
 =?utf-8?B?SEx3Mks1bHFZSXNGSVRtNXFBbTZKZ1dNMW9tNkttRUJZU3dtUitOVjM1Z2Nh?=
 =?utf-8?Q?bNLikrQudbwRu?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB5772.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTJNMHJPQ0JRY04rWWI2ei9HalF3V0grUnl3RWZMZ0xXVTE1Nm5OdnNjNXZG?=
 =?utf-8?B?VURaQUZ0V2FHNHhBdkNSbi9qSTBhZ204MElRSjFJY1NqK01McEhMWEV6RThu?=
 =?utf-8?B?c2ZiS0dHNFpRR1dWZ3UvV1E0WWd0dlZsdWttSVBlMFFyTkN3aC9ocXdqditu?=
 =?utf-8?B?eWtMdHZJaVhGVmdDRTJOQlRRb1FCNTNKSVc0YXZJdzFxdjMvVjFWMTl0TjFZ?=
 =?utf-8?B?ODdtVkg4MjFIRlhmV1U0czFLZEVpdHJLWkJpMElDWm1hMjBja3RnYVZYcXli?=
 =?utf-8?B?K3oxSURsVXpmTUpCdlRPT2JCcEdMUDB3cEdPNHFqTkpiUFdLUFZMZmgwNTJF?=
 =?utf-8?B?QnFsdWIyVVR6MStENjdLdzd0QldWaExBam9RRzU2ZzJvTWlRT2k4WEtwUUVI?=
 =?utf-8?B?UHRyVmxSaTVDbkswVUsvcUJKZWdWemoySTJoOWh3Z3E3MzF6VnFQaW03a0dW?=
 =?utf-8?B?eno4b1FBQ01CS3ZHU09LSjlDZk83MnQ1aS9ncE90RmthRm84OENUT1JGdngx?=
 =?utf-8?B?cHVWdDNyQjBXdWltN2k0S0RRTHZSNzVNZ0syY3FPWU8yZ1hydDQ1YUwzditF?=
 =?utf-8?B?bEx5KzhPVm0wR2xXRGRzNEZKc1JBUXBHalRsWXllaHQySkZoWStTdnUrMTlQ?=
 =?utf-8?B?VEozQ1RRRjNOUnFSY3p4TFJkVlVGVTYzZDI5T3RMZVcrZ2ZRbXNUL2NGOWIy?=
 =?utf-8?B?NmhsL3F0b01yTG5mY21JY1ZadVl6b0NhNUNWS3NRQXNZTVZoaEJVemRBRGhG?=
 =?utf-8?B?NGhFNjhyS2tudkpMYTh2RXJtZXV2ZkVPQ2JBbUorYWtpOTc2SUt6NkVFTW0r?=
 =?utf-8?B?TWZOOVFhNWtiNHNKRENoV003Y2lkSTRRU29XS0VnSzJ1ODBaSjRucnYzeVhk?=
 =?utf-8?B?M0d0QkowKzNZdVE0bko5QUd2YytzK2NUdkdLVU5Yc3hQQkJvQTVLZlcyT3BQ?=
 =?utf-8?B?YWFDQTFiMWxzQzRSaFMzbTRtblZLekxLcmhEanI1Mm56d0JoTXdDbDRmR09K?=
 =?utf-8?B?aURpOXlGQU9xNGV3a05IOHhJTVZEMi84U3FDRW0zekd5dXZia3VkTjRTZzZ2?=
 =?utf-8?B?UTFsUTNyY3hpdFlKOW1XWExzSFB3S0tiRUk2KzZkZ3ZPOXl0YmZ2c0NMMXhl?=
 =?utf-8?B?VDh6YTZUM2JDR2orbUJXajhMZmg0Uy9NbUlrb3VoSVUwY1dlam5QcytwVjZi?=
 =?utf-8?B?YTFPQTlEZzZERTFxc2FiVkIzRWpCQm83MUFJcUdwNC9BUlpPVVByQmh5QVox?=
 =?utf-8?B?UXJ1ZmE4Q0FpSWlWNnRqNWlvb1hTejRwSzVYQnZmeUY4U1U0NkVqSFlXNmlN?=
 =?utf-8?B?SkxBc3ROdlo5aXNOYlhCUGxBaXV5aWhGS3NYRElIeHR1UGI0S052ejB3MlZ5?=
 =?utf-8?B?SGhmLzBzNXhGMHhVRGxBRExkWTZiRmJKR3NDQUlEeWl1cnBVVVRmckxqOVdn?=
 =?utf-8?B?emw5MlB2em5iYVVLOHdIYWIzb1ZsbHpiTzhnU2dwbkt0NEZsQnNBdWpNbDcx?=
 =?utf-8?B?RlhCdmZGWTRqcEVxZXJZWm42U2c0VlpqUVNJakk0RWpCN0pxVTBBUTBzcHF3?=
 =?utf-8?B?YnB1QW5zVnJmL0J5emVjUGZmeVZTRG1HSlVYS0JyeFc3bTVudEZ6SHB3NlJZ?=
 =?utf-8?B?TjlGeHIwbmNWSENGVjRpL3NPV24xaDN6NERYTGIwWHhlRlg1SUFGNDIxN0s4?=
 =?utf-8?B?QmdsTnR3Y25ZNFZXR0c0QlYwMGpmR0loZWV3VVNFelYzdUpCWnV4YndsT3g4?=
 =?utf-8?B?Qk8xSXEraVF2L3Jva2t2YUIxZ3hPS2xuVkZHZGNnaFphUEhkK3NrUVUwb3hs?=
 =?utf-8?B?Ymp2azBFZEZkcnpnenQ1d1B0SjdxQjRNdHN2VzhZOUlCeHpjYk5CNGdQeDBm?=
 =?utf-8?B?ZWYxT1hwWjJncEk1cndaa2o5elJscnFoR2NkWjdtZ0R5VHhFM09aN3ZoRGVX?=
 =?utf-8?B?cVBVSzR0djlwYkNnR2V4eWdJeDV5S3kzRGZySm5IS205QVA0ZTArZ3JFdFJw?=
 =?utf-8?B?a2YwWWtJaTQ3V0V1dTdFRkNVeHAzMzB1MGJiV2dNOXRBQXBvL2ZEV0V0NkJ1?=
 =?utf-8?B?Tzh2YUJkWDBiVzh1RmFlR2FtU0ZldEc0QllaT0dHUmswK3piM0RGdzFIL2M3?=
 =?utf-8?B?cEpWWFRVNW43QVhhenhKcEp4emFneVAvYm12YWtHZ3RhZHBmbzRWOG9tZDdQ?=
 =?utf-8?B?MWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e34e043-203a-4aab-45f1-08dd66194f54
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5772.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 12:35:05.0576 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vs6VcIPbRvaWi5vfdS6JnIHofg9w8jcJKEHIFsNSGpXbIEPL05cRAMCVwG4Cu9yrtkcHzjO3GcTbxiOEyOwBks5l6oOMTJtpUpIp4/UA6tM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7577
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

Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>

On 10/03/2025 13:11, Bruce Richardson wrote:
> When registering interrupts, there was no check if the registration of
> the interrupt succeeded. Add in such a check, and go to fallback path
> if the check fails. This prevents errors on FreeBSD due to missed
> admin queue messages.
>
> Fixes: cd3b124955d4 ("net/iavf: enable interrupt polling")
> Cc: stable@dpdk.org
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>   drivers/net/intel/iavf/iavf_ethdev.c | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
> index 9cd2b0c867..1ab84b0bfc 100644
> --- a/drivers/net/intel/iavf/iavf_ethdev.c
> +++ b/drivers/net/intel/iavf/iavf_ethdev.c
> @@ -2825,18 +2825,16 @@ iavf_dev_init(struct rte_eth_dev *eth_dev)
>   			&eth_dev->data->mac_addrs[0]);
>   
>   
> -	if (vf->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_WB_ON_ITR) {
> -		/* register callback func to eal lib */
> -		rte_intr_callback_register(pci_dev->intr_handle,
> -					   iavf_dev_interrupt_handler,
> -					   (void *)eth_dev);
> +	if (vf->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_WB_ON_ITR &&
> +			/* register callback func to eal lib */
> +			rte_intr_callback_register(pci_dev->intr_handle,
> +				   iavf_dev_interrupt_handler, (void *)eth_dev) == 0)
>   
>   		/* enable uio intr after callback register */
>   		rte_intr_enable(pci_dev->intr_handle);
> -	} else {
> +	else
>   		rte_eal_alarm_set(IAVF_ALARM_INTERVAL,
>   				  iavf_dev_alarm_handler, eth_dev);
> -	}
>   
>   	/* configure and enable device interrupt */
>   	iavf_enable_irq0(hw);

-- 
Regards,
Vladimir

