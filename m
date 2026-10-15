Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D067FCC6B3A
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 14:21:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B2444064C;
	Thu, 15 Oct 2026 16:21:58 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 582494027C;
 Thu, 15 Oct 2026 16:21:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792074117; x=1823610117;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=6qKcNIoc5CZBJBaGqhO3pg3k9wkLT41Veb9gf0hCaxU=;
 b=bhfMt4KqeS8LHm7w788ExLmaUjwDDVG3/9Fn0Q58r8gWHp+124fy4KmF
 94bftGbqoKZvjnooLM3sPiy7TzfyM5ZzpYcj4n6vEJTGYwNCIRgd+fxKy
 oSUaM1K+hA1xdaVS55ZeyFXsiGOAnq7QPUf7mHyWONuKm6RVjinQx+K5B
 ziCPw11o+oYtJPlRZPZPBOLL37XdSlgohBLO2diUgAb4cN9tQmCM8hF4K
 1jU4tczQ4uMvDnqReip+Nop4fKSapPFO0sz40Ib/wUzN13TeygMMzYrdX
 3v3rJXWhymM/XhZ4gqtYeBt2Hi9YT8tjvWckR7PmvWV05cX5R03kBKtT+ Q==;
X-CSE-ConnectionGUID: U/tu45Y5T5SsOLuT+bXnYg==
X-CSE-MsgGUID: nXBPjvbvRLWR/cTX6RCbSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="726194"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="726194"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 07:21:39 -0700
X-CSE-ConnectionGUID: hm2yF5hkQNyVQOmWqVMsHQ==
X-CSE-MsgGUID: Jfrxy5OATfOBi3SMDzC0mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="1586065"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 07:21:39 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 07:21:38 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 07:21:38 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.6) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 07:21:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rBn3/oW//sEwLyXSVX9JfAPJ8vnwKMHJVx4U8JBF723kUXF9A+VeccpxkOgbzoNa25bEtYZb8NzQ2QO3W9PwLvLB3yWElU5hRBHwQx48HYo+S/ZJ+yRcBBrfAFX1vrOgP1jI5Dn8Cu7QLgPx0pOys8FvSJQjSlXZyoik8fzhwYAfVDs89WvlVQVqstXBllI87nrZIOCHxz9Mbuds2KYbYdknZdLQ3FtqWKYzQJJFT8grrVNd9F5/KWSBqmGdebYgRV/I3rdGOgpL0sgod0BVEOfo1uo3PPsFbHxJSy4uInAsaloZNIjPVK8LENVZWqPKwtDLg6+ZtjMu11mPGQmNqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DvRMpgEiDSM6tguVZx/1bhjoGJsqVbE02vF1awP0rHQ=;
 b=WRw7YQslVvXWmht0zytC5YiCmxhVOEziBfbqzxQelbQloBMr1dPDCiGL+X09255oQ6FoGS7mqPFCt0h8Sv6vThMBwVBPjISrwrX/MulmX+UXxSnW2OMolD1UmhOdJfU4EFk3+jMPMHpN1kUNNEjrrhQBLtyNJAGYkHQKJcTF7O+CXA88GJ/aPnZG4agFwszrY/ff0XdN/WyUsjyL6fUC3n4PFaV9oPEuLvyN2pH07AuErfsnNS+UD6zwa5JybWSOeq0F/L2k3DKZP27bSFdbX36YzcCF588JWLd2Q9M0u5SvMYGljfLTMFW5Vgmw2hhFoQLeqG4bg9Y6vwgvTs2wrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2993.namprd11.prod.outlook.com (2603:10b6:208:75::28)
 by DM4PR11MB6168.namprd11.prod.outlook.com (2603:10b6:8:ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Thu, 15 Oct
 2026 14:21:35 +0000
Received: from BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046]) by BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046%6]) with mapi id 15.21.0522.013; Thu, 15 Oct 2026
 14:21:35 +0000
Message-ID: <7706c795-6915-4db0-ad45-9031471e72c5@intel.com>
Date: Thu, 15 Oct 2026 15:21:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 3/7] app/test-fib: fix size of the tables for large
 counts
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <rjarry@redhat.com>, <mb@smartsharesystems.com>,
 <maxime@leroys.fr>, <konstantin.ananyev@huawei.com>, <stable@dpdk.org>
References: <20260322154215.3686528-1-vladimir.medvedkin@intel.com>
 <20261014183921.495158-1-vladimir.medvedkin@intel.com>
 <20261014183921.495158-4-vladimir.medvedkin@intel.com>
 <20261014155227.0ed1cf10@phoenix.local>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <20261014155227.0ed1cf10@phoenix.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0100.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::8) To BL0PR11MB2993.namprd11.prod.outlook.com
 (2603:10b6:208:75::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2993:EE_|DM4PR11MB6168:EE_
X-MS-Office365-Filtering-Correlation-Id: e9113c36-4568-4e81-9323-08df2ac79e4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|4143699003|11063799006|18002099003|56012099006|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: HcJnafEOPRzBkMS0aZw/dKzvAu4NkvRW65fcXNVyJSlbsEoxmQ+i69v93uUjMGjjse4VEgJ3G8Gn0dclV005WTA9sMoNQeM/gpwv82pOeDgoD8U1p8K9FyK/4lMy2wMMQhb2qOQ8pJBZz2qydkG2oy+suxQqYACqHSs/bHaHg9Kf9p4iDYfJJBd8doYHWKjqW2cXLW13vEfDeYfb+SDVRqPwvtszNunVvXslJD8wTJuqeCkjLuxdYJL2fBA0tvVPKexmXpRHibccMHQJsDJQf74+E6JLtN3MB0a0E00Lf2mjYnHkjcOsGd17uJ2aq7kkk0kbJ0Vnp2GDVJRao1qP7sjh0K4zUpolVIQZt7dfaEP0yHs7LMMx8gI6Ge4vW0WV6ajWESEjKwRZDtwNQbYAUXw3FJfhqVjzva6woY4gEf6EYI5Uw0GgEDjFCqSAZKYLEZhqmlyt6IJObpEL86C1awLjF3vfEvK6J8XAjB3J7wMe31BP/4F6CDM51FR8+wSB92+1bE3M3pNmIBTKAJD/Og0spSjyMkR2ioO+g5kkUMKg9jgfxL1F2kQdTNo2wjeUrw9HhotpB+DsmchLqpKz3Evk7QLv9cb5VTa+bygp7B1hyH4AqUnyjvrlO8wKNJrpbvxmdiJDgiDuDY67g2OOuBbmUxfpD0BtLrUTIdw5xnQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR11MB2993.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(4143699003)(11063799006)(18002099003)(56012099006)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjdsN1A2R01ncmRMT0t1emtMUllmbWF0SlU4Qm5KK0tRbEpMb0lRY0NTTkxq?=
 =?utf-8?B?TXZYUzNub2lLOWV5d1VFdWdNdDk5TlVrbkNPQUtIdElzMjJERkJXNjl4bS9R?=
 =?utf-8?B?YnFHTjZ6L0VIRE9HTjgxRDJIalJWWEdGMFIrMkxFSUh1NkJnd1d6SEQ3T2NS?=
 =?utf-8?B?em41SkhrQlJtakZVTDMyMUNxWG9FdWRCSXdYSjVGandKM2JROUhqcGpiT3hS?=
 =?utf-8?B?TGg1NEVPY0xkRzdxdlhZRkFwRno1OFJyc2E0c2h3TEJhMlM2eWpOWkloREVW?=
 =?utf-8?B?bUk2NnEwL05OKzVNNXpTcEZhVFlhOG5RQ01Zd3RmTzFnUmVSOTJBZTQ4MGFW?=
 =?utf-8?B?dGtYRHllZFMveUtKRUNTT0swQ25laVlpZlV2OWRvUDBkMFA5Q3kyUnhoWW5r?=
 =?utf-8?B?YWNJeWZjRjcvT0NUSE95QUdpdnE3eC9tZG1BY1d3TGUwc29JUkZKWWlHQlZH?=
 =?utf-8?B?ZjVSdlMzaHpkMHpRcTFFR3ZXMWcxK0JWZlhiUkp5c0FZaDZ2cjg1ekxsU1hq?=
 =?utf-8?B?b05RNzBYRVhuL2VKVy9Qc1BkQ3haZXJlbzBSSGYxdXBXNlpuRTlHNUt0VHl3?=
 =?utf-8?B?UHA2ekk5YnU4MjN6SFZoeFBYQjB4OWZZRC9QOWZnYnQ5N1o4V1dKVk5TVDZM?=
 =?utf-8?B?clo3YnovYjQ3OW9BdzdHUVc3U3M1b1RPR0pyVmQ1WUZSMjRsQWhHM2c0VTNC?=
 =?utf-8?B?cyttQWhLYTFtY0ZRaGFUSDBhSms0V0lmTXRpdTZ0bURuZnZlR1Fjcm85Ulp6?=
 =?utf-8?B?RUhKaWN1YXlkOSs2c3BvMitEd3FEb3QzWHdTNHlLNTFCUThYN1YzcDZONU1P?=
 =?utf-8?B?RzBBRHRLSWJXN1o4blhScnJhN0VxOFcrQ29JbVBjMGQwazUzalpzTWsreWxq?=
 =?utf-8?B?T1ltQXQ0cDhya0NjZ1VXWVN0Tms1K1RhS0REM1BnMWxoYkV1bzlaVmFHQXpJ?=
 =?utf-8?B?cjdmdS9kTm1UOURlNkRQeVdKSjU5VFg4ZGR5aFgxWjE5SzhWUnNZSHVuaTJr?=
 =?utf-8?B?OWtQM0FaZEpjOGlaaFgxdlRlaGdDK3ZHSzdwMHhVWHpwMkhscGFHS3Qzb1l5?=
 =?utf-8?B?UjRpVnpYcXRYVWQ2VjJ4MjZVOXIzWjZpdlhreENSR3hxeEVFSUs2SVRkRGJL?=
 =?utf-8?B?M1Vac0hWQWZRWlFLSUo0ZTdPMzRDNS9NVnVXaEpyREp5dDBjVU9TVVlUK3FR?=
 =?utf-8?B?d201c0xkUWlWK3BsNHUzTGxDK1dSVkRuOTFDVVpNZDBlczY2OUhYNldYOUdF?=
 =?utf-8?B?azljeEk1SzFTYkxvbzg1VE9RQzNwdXhLVWxHVmYyVXJVUDN6c0FpR3I5VDBV?=
 =?utf-8?B?V1UrYlRJUUZoVHZpLzZKd3RaZWhLZWsyZktaQ1BDelNMeDFXS1ZwZlNIRFZU?=
 =?utf-8?B?YjdYUTB2TnErdjk1M2t6Sm9xQm5zYTkwVTBLWGtpQ2pXeDRObjhDNWpWTEFY?=
 =?utf-8?B?MXhWditFSHN2MG5ydUhKdzZlZUZIaEMvL3hRdVVtbW9FcXRyY3EyQjUrc0Ra?=
 =?utf-8?B?elM4bS9DM21EdVNmYjM4QzRUQ21vcHdYNHFLT09qeXM4Snp3cU9zNTh4WEEr?=
 =?utf-8?B?VThWZEpUL1VYdXVibzZ0UE5XeVpESzNMampxZklXTHBEUDNBRjJ6aU4zbXEw?=
 =?utf-8?B?SkdVRlUxWXlibTlhMktHMmlZSDJqRHR0bEo0MGJLUkM3d2RqbmNZWlh3S2M1?=
 =?utf-8?B?dzIrNEtXcnpaRFhmdU1TaGRid293Yy91enBmdTNkRTNuTWthaG5HOGhKQWRq?=
 =?utf-8?B?N1hHNTVabGtQQm9YRlpPSEZGeFFuUE9Db3RiRFVZSEVrOVhMZWdSMmFtdml3?=
 =?utf-8?B?WHhFSXhWWDg3Q05KZ3F6QWRZUU96aGx3Y3F1QTNWQnFlMEFWM0tQMW1Jb2Jj?=
 =?utf-8?B?Uy9PSUtWcVc5T2laQVBiVFBIditnUG00b3Zsam5SdC93YkFtZVNQVFB6UVJ2?=
 =?utf-8?B?MnZaamxBdG5tM1pGc2FiWHhzdjhEd2cyUDUyVDNwczJYc1lmSG14QzlBM0VW?=
 =?utf-8?B?NkpjUUZpR0hSMGh6Tmp0WE5ySE0xOUo1QXAyVldWbFY2L1VlUEUrNHlTQjNE?=
 =?utf-8?B?b2V3MXM0NU96Q0hwdVZiUjAzR3hGOTNzY2d2djB1QzVaTWdsVkZoMTNGNXpa?=
 =?utf-8?B?OFJoMzFlU3dYZytCNlJNNE84eWw1Tm1aeHE5dXhoQndwNk5yNS9Nd1k1RDlS?=
 =?utf-8?B?enFjaVE3SW5wOXJVaGVKNXhLSm1vVUpxYVo3OVpyNTBYNFh0MkRZa0dBOWt1?=
 =?utf-8?B?amRMdkJPaHRlcGNGblZ4QTFua2lGRjdBRSt6Q2RqWVFkeUFoTk9JUXNUWFRK?=
 =?utf-8?B?dmtqYkE2V25pc2UzcWFFTDZ2aTBDSyt1UysvVUpsVlRCZkh2MExLMVJkV3lJ?=
 =?utf-8?Q?rKDlNsC9xxRTNheQ=3D?=
X-Exchange-RoutingPolicyChecked: e2SJzBwki6y//Hi1JuduaUyOnhxA3tbyMgheifM/5gTmzqzO2u67LLD/gABCZULqSBVk1W766ryr2d08E/1rYnvcjLZrXQnFKU1hwCc6MmMmighg1xN2AnBBHVlvT8C5yLU5F3y2GBbPeZCPciyX/pMkLI6gklR48M/wbGEXEEfLWz0KcdBYlXo/PdDMckcLE6mquRlm36paiZV9o89Y05ooA6SWE79dQSmU4g42gW69CtJHC0r8Z5bMrsmFL7O4O86X2WfTI5xAe+u22cnhSfSmdAG1mzNg2XrWeYVUY/INp8DX1qmLbqbceb0+dEiUkEMImyEjT5ggBgxs8yhjSA==
X-MS-Exchange-CrossTenant-Network-Message-Id: e9113c36-4568-4e81-9323-08df2ac79e4c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2993.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 14:21:35.3463 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hl1/R1f2OnAoslOFAyWFKq4MWAFoDatp+mKfKVGpVEmW8iB+101Tu8+BrV4qQp7yVnocbzLPq87ZvpgmCwGSDTwXA37KRDVxfSdJRjIW/gI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6168
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

Hi Stephen,

On 10/14/2026 11:52 PM, Stephen Hemminger wrote:
> On Wed, 14 Oct 2026 18:39:17 +0000
> Vladimir Medvedkin <vladimir.medvedkin@intel.com> wrote:
>
>> diff --git a/app/test-fib/main.c b/app/test-fib/main.c
>> index d85d94fdd1..0bc8dd2aa4 100644
>> --- a/app/test-fib/main.c
>> +++ b/app/test-fib/main.c
>> @@ -1260,12 +1260,12 @@ main(int argc, char **argv)
>>   			BURST_SZ);
>>   
>>   	/* Alloc routes table*/
>> -	config.rt  = rte_malloc(NULL, rt_ent_sz * config.nb_routes, 0);
>> +	config.rt  = rte_malloc(NULL, (size_t)rt_ent_sz * config.nb_routes, 0);
>>   	if (config.rt == NULL)
>>   		rte_exit(-ENOMEM, "Can not alloc rt\n");
>>   
>>   	/* Alloc table with ip's for lookup*/
>> -	config.lookup_tbl  = rte_malloc(NULL, lookup_ent_sz *
>> +	config.lookup_tbl  = rte_malloc(NULL, (size_t)lookup_ent_sz *
>>   		config.nb_lookup_ips, 0);
> if you are going to change these, then fix a couple related things.
>    - comments have bad spacing in there
>    - use rte_calloc() for arrays
will change
>    - not sure why rte_malloc is used at all, this is test code. Doesn't need to be hugepages.
disagree. This array contains hundred millions of IP addresses and 
occupies hundreds Mb. Also this array is used in performance benchmark. 
I don't want to hit DTLB misses in performance tests.

-- 
Regards,
Vladimir

