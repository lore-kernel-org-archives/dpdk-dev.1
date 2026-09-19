Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D70C982D8
	for <dpdk-dev@archiver.kernel.org>; Sat, 19 Sep 2026 16:13:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 52CE340DD2;
	Sat, 19 Sep 2026 18:13:37 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
 by mails.dpdk.org (Postfix) with ESMTP id 9837040272
 for <dev@dpdk.org>; Sat, 19 Sep 2026 18:13:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789834415; x=1821370415;
 h=message-id:date:from:subject:to:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=+HFB3vfGjMfaoeT8Vyyndodn7QiHT58HWg8UkviLWcY=;
 b=GmZnVjD62FAhQEUoPywN43YOr4aJVo9IILPQqcst/cxalVTVxLKXDTFe
 z+sqcau6y+m8AgCiZBTJMY55pvbnTHVpa7x4aGqgBFnwwpAdTrMRdd/MY
 gFQACXoTzxrTIEi12gBgmyNZH+zAbloKs9VXJfu9Pk4Jz7rfV3INJu2sB
 8VdXsOaR5b/QzvZtoT59Wa4pu4eR6smYccr3JhRbYY0Veuv4QnaBVlq78
 MVQta+V1SpFmoxCqA7vJ2vhXvlbq52+1YmMlO+h87tLu7ez+ypvYp1PyY
 G2cVh/GM6nEoMxpzDMlDBrobMy+lH11oJ1FSrsPSIsZpfNE7LDb6BQyRi A==;
X-CSE-ConnectionGUID: UPg6U4vnQWCjiC/aiLeMqw==
X-CSE-MsgGUID: DscHrpiTSWa0QZIlJ1rIqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11910"; a="870011"
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; 
   d="scan'208";a="870011"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2026 09:13:34 -0700
X-CSE-ConnectionGUID: DKWeFcMLRDGEKolYzpCqdg==
X-CSE-MsgGUID: m1TKyOMQQCmzswEhO1XtwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; d="scan'208";a="270557359"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2026 09:13:35 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 19 Sep 2026 09:13:34 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Sat, 19 Sep 2026 09:13:34 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.1) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 19 Sep 2026 09:13:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=urZ3JRM6fi5ltMxUSZntYy6X12jwJ5kDRcuiJ7D10SnXKvvHTJOsEGab+8VFBIrG+/0kPhIU+jFryX3IhJbkue4H/LIhcqBYgLdQ3swWBNMuZyTczM6ueqisi6abWc9oJpUyUB8Tv1cl7W1QofXw2/JsRC2/TDrtgaL7akWS6yAclEr+cybv4ygM8QhlZwzZk8LAZFxUh5Nx2BuCEcb6i1HYrjbycE9RHLBnOhAyKayWxBrxEh8miqJm8CMfFKW86XCTBArtyBsoug7RtQLLqMRJG4r4Bi5YV2A2nY/Fz/pcDyNkhqLnNHerqtQjjGdo1xLVH5jWcTRF+wOef3HKiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JUvZNTgmzgjqvUT6d6drKjglE8lJESev7trXFAgUBdE=;
 b=hmkx71u9Q8j5VvgvIWBxbuLJ+Sg4F1wjS6LNF5j6/tUuzFlbEuwwNVcREUHaAnX2ltJQuQzaoVmScX7EOe7h50VdALW0Mj30rKSr8V2pliklmXnbuBM+PiNYTJerEsvbKL4NzJzjZ/Mh0b9mo1xx19Uj8VoLoECex2y8/++FZfK4L5Lc4gSMC9JH7orPKKiA2MTkpgNWCJIjQuG97uvrR8B/jdwoucx9NMOKHqF7+F2xleldjcORU65GYnJ/hvHoVkMusiJs1zKlkKjhhY26mJN3LGhK5PSCD4EN3aAxZKuoKJXLhA7g3Z8Yqjv54dq9Kq0dR5qLoi8rIjT0sY3npg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2993.namprd11.prod.outlook.com (2603:10b6:208:75::28)
 by SA0PR11MB4526.namprd11.prod.outlook.com (2603:10b6:806:96::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.15; Sat, 19 Sep
 2026 16:13:32 +0000
Received: from BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046]) by BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046%6]) with mapi id 15.21.0428.014; Sat, 19 Sep 2026
 16:13:32 +0000
Message-ID: <46e66110-5473-400e-abec-fc60e4f5f033@intel.com>
Date: Sat, 19 Sep 2026 17:13:29 +0100
User-Agent: Mozilla Thunderbird
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v3 15/19] net/i40e: refactor FDIR engine infrastructure
To: <dev@dpdk.org>, Bruce Richardson <bruce.richardson@intel.com>
References: <fb21ee962d3321518e396810887c759e7fba27bc.1789560946.git.anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <fb21ee962d3321518e396810887c759e7fba27bc.1789560946.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P251CA0020.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:551::22) To BL0PR11MB2993.namprd11.prod.outlook.com
 (2603:10b6:208:75::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2993:EE_|SA0PR11MB4526:EE_
X-MS-Office365-Filtering-Correlation-Id: 804b0278-6d78-49fa-d932-08df1668f33a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|10067099003|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 6+NsLyuFbD4vGFLVlQzS3PlnvptjWmfWAQluqmZRXiaMAJv8rkHppfFJs7EJAzfywLiHCbf+dh+M6ffJWMwiPvQAKjdXT0eJJHD+nRzLRiOSaLBgOmta2M06TsKJGvFsG6FJ99q8OguA1Hbv18xW+7QESIdBtjsRRfi/fc/c7Go/OC/gPi9DSg/G6Sm/6vTA9zUN6CsU5gLgMnLZflhMc5GDnfhgWYNYI6v/IaJJBccBffJsTZzhHMfzQKFJrUiZdL7+VyHn14IIRWJv3jcU4rJGnLVvdclciAEuHtPfZC2w7sPt/vUU2VHDAhlAqdEHjvmUgAA/5WofAfpzuXAadLpoUOjSEAyVeEOBhPfeh47qWPrYU/4brhW9yg4eGjJO5cSNZQiEi3PIf9KU0VX/3xz1/MCAuHx+SQmIcpmW5S62c5Tv7wCMQs6osPoGgo2rh4r2mzG/zs6vkZnjVDVtPXAjRnoX4bPlGZcGD+CspcMLplun/JMfl9L15U+LPtTlGYOJsIPJFFsUTYbqoRtlE1M08kWR9WEvQgMZBQCUYLZyXNIj/V2CP/zyXW8b5/Qx0oVWOuMfT//Sb0NaaDlKclR27/ohbkXRVgjGZ7sKKmbQxcp360gwLNXzXPmxk7HF9/15kB09kaUEucBHSZpXEPT6C3hHWnTjqD97evC+UTg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR11MB2993.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10067099003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0FMdGlDYW1FSTRmZmNFZVNzcDBkYnNWRXVCanI4dEMxL0JnL1puOG5wR1dI?=
 =?utf-8?B?UUF0ZUp5Sm92R0RMZGZodCs0QlVMem5PZzhoSjNQU2RTQ0xnem9wM2twM3ZD?=
 =?utf-8?B?YXZ3K1V6YSs5Rm1JSFpUVnVhaFNzMytxQmlKRXhka3lmZkVTMVVhb2lzQ2NM?=
 =?utf-8?B?ODdKNTZwZXB0RklEZkxJVyt0M3U1cmk5OUtQUjIyMUx2WHZlMkg5TVk0c1F1?=
 =?utf-8?B?MUVEeGZKM0FvUXVwSnQ0cHJCS3lTMGplYm5PMTdlR1lOQm5WYWNQNlpzcWZK?=
 =?utf-8?B?SXQ2RWk4SDE3VFJ3T2VIcHNjeDJHMER3bWFWMXIrbER5d09zSFpCdlo0d0FG?=
 =?utf-8?B?NnNWcUluRmpEaGorOXJXV3JweUxhSytJVGlPRjQzVDZsc3I1NW8yaTVsYVRw?=
 =?utf-8?B?ajRrL1lnMzNTVE5vbDdZMlZSc2k5Ykl1MzV6OFo1VnI0MThWMTk5N1BLSU1J?=
 =?utf-8?B?MkVwWFc2NzJvL1JLeStveWJNT3NYbXk5aTNDR1JjR0kyK2VwQjJlZ29CNzFo?=
 =?utf-8?B?UmRXc1VGWjgway8xQXJoaXRLWFZhM3pIK0pHV3I2eTFDeXNjNHROR0xHdW9Y?=
 =?utf-8?B?aFFDNnJSSTU5NENsTW9yK2RKSzkrdDgzeStZNWY4WEhrMWtseTdhV3NTa29L?=
 =?utf-8?B?aDVrSFFhM1lOUWVobnRHQkdqNzluaEtJRUoya1RaS2JhRUF0K1J6cjljSTZE?=
 =?utf-8?B?c2xLWmNMNHpVZXJicUZLWHRTS0pRWFg3V2Z5eHRKUGR0aXNtUnVucnFKWGF2?=
 =?utf-8?B?cG5RRFU2SUdpc045MmxvL052aXNaT0xKSzNKZWZzTkIxSVpGeWZiRnIrcHpo?=
 =?utf-8?B?S1VaeGxNT3ZhMXZidWJCaTA2cnpmcmRJMjhpRDRzUW1FLzIrdXhxL1pxNnBt?=
 =?utf-8?B?ZjhiazltYXBJSXBReko4dStYWFN1M1BBemNxaXphK04rdVd2R0Z3QVlQTENI?=
 =?utf-8?B?eHpqbHRpWmZ0V0svaFJMc0VDTW5wMm8wQlZOZ1dydDMxbUxmR1Z5aTMrRGE0?=
 =?utf-8?B?c3hHa2dYN3JqSnMycEdiOC93RGhGQkFYcnNUYVRhYkh1L0V6ZXcyYlVpMkhH?=
 =?utf-8?B?SUxlS1ppWFVQWVdVbTAwOE9rOGZ0Qk9MNWs2dkJkVFJSc0ZHVlQvL0xxdVlk?=
 =?utf-8?B?VmpDRVJFVlJOZVhNU3YreC9mdW8wdEYxQkNsTXc2T3BLT0liL1N4bTdzVTJx?=
 =?utf-8?B?ZjVYREZrYktNYkU5enZOUjF1WEFQdnFPM0RqdlduallFQXNTZmpRam5JeE4r?=
 =?utf-8?B?UnNIRnovSnZFWGFVZyt4SFpCTjRrcUR5UWtqTXJYTmFYMkdxM1dlRjAzTHNm?=
 =?utf-8?B?djduUmEvc2MzcC9DK1FzQS9oTENmY2FUd01ONnlacDYrY2U2L0w1TzFiYUw3?=
 =?utf-8?B?dDFDVzd2N0hFRVpUSWJnOTUyaUl5ZC9UN28xSXQyR2loZW9SekxVM3E5ZHE1?=
 =?utf-8?B?SkNLQUd4bXFpQnE3UDAvQ1JwY0piSFhZUHRublpiWFVYcFdMZUFuMkRBc0Y2?=
 =?utf-8?B?N08yMTZwLzZmZmNaWWMvOFlRMEwyeFo5ZXR0VU5BWmV1Z1lPb3JqbTJaUnp0?=
 =?utf-8?B?R1ZiL09OQXRvSDNNSjVQV0JrY3VUUmswekpnRVZtRTcrcU13QmMvSzZUUlBV?=
 =?utf-8?B?UmZDM3JLZnNGb0NiY0pLanRnb0lJcnErNTh3UERCTXRPVXF6RXY3dmc0WHc5?=
 =?utf-8?B?S1FLUkJGWTdtbjBTQStIcTdvdkhocFE3bW52aDBOZS9CMkY3c1NDVmplMVJC?=
 =?utf-8?B?UUp0bWRwU1FlZXNaWFVOTzVDY2kyZkJUbzd6VDh4Q084d0NjaEZkRWVQUWo3?=
 =?utf-8?B?SE85Yis4Tm5MZWZCMmtyUkVFNHpoY29idGh0MzJ6T3B4d2lnUlowYWRYajN0?=
 =?utf-8?B?WVNJamFDRjVWbmVpd2FZTHZVT21aYmNuQlVZcyttQm02M3RSSGo0TC9jQkRH?=
 =?utf-8?B?OGFpOHV3cFNRdFNXNUwyKzJlU2pac1NoMk5URHNvdnJaNnhqSFJZNEszUHVU?=
 =?utf-8?B?Z292SjVXbER6YjJoMWVoOE9xY2dyV1h5QmZyYjVWb1ZNVWZWenV0NWtCVlor?=
 =?utf-8?B?aG9mOHloWHZEOWs1Z3RJUklXZ2NSOTdGU1BOUENkMG9KSFZ1VWdHbFI1ajQ4?=
 =?utf-8?B?aDEwRnVkTFp2K3BxbkhxbnMxM01sNldWZFBZaFphV05vZXBMOGtQZkZWVjNL?=
 =?utf-8?B?bUhVOXNiNnNuRVNnR3luSmhwS1pyMDRRckFqYWdzbDdqaUZjTFo4R1NlMCtZ?=
 =?utf-8?B?cng2Smljc2xVbnl6R0o5ZE5HTzNRQUhScDZ3aWpMRXY4RHZmd0NDeUl2bkhF?=
 =?utf-8?B?QWpJS1VvSW8zYW9mQjZEb0hlVTg1NnpBR0RtYWZLUjkzektVaFJ5TmJPaE5p?=
 =?utf-8?Q?LMYAlQjQKdvsMWyY=3D?=
X-Exchange-RoutingPolicyChecked: h4gHlWAJ/in6tDbE3tVB0c8U87oNUlS5LjDvcCMTUuPbLBIWs3UsuqmOifPkaFFrrBQKhUcnO3krw8/nEn7wTmsp2pRlHABIF9JcLco4hUq3tiOMutfKeNdMrKjVGBAM/tQNYz9GOMiToIR1oSVRsqJeEu62sQ7YDE+5DgBckiz5Wp0T0l124N1UAfynjf79aUALLCweQT+ZJbVKvhL1kJw5iBzf52Hz3eXHZyTW5VTuppdhrsWkB0bL1HpQiBcn1l6ZUh+01FqZH1bdMgX7cpgfSYkCJRan4sT/QkclD0WKe67FqVCF4oy3qMGb/J05GvNqwr5/JpmeukHpJjkarA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 804b0278-6d78-49fa-d932-08df1668f33a
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2993.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2026 16:13:32.3711 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hndTS/ZgorwPkAL40Ak1tH0m2kVMLYNvrzOsPcskS2PSsQE9ee2WnQxrKeoKv7Qb3NQXXaze1V8+R6biyxuhiN+VCmW+n4lzlCnzAQtPEIk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4526
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


On 9/16/2026 1:18 PM, Anatoly Burakov wrote:
> Currently, there are multiple problems with how i40e flow directory feature
> is implemented, both in terms of how it works with rte_flow, and how it
> integrates with the PMD-specific packet template API.
>
> For one, these two subsystems, while using shared infrastructure, do not
> really interact or cooperate, and are built on top of special cases in FDIR
> path. More specifically, the packet template code does not store its
> packet in the hash map, and has a different hashing scheme, yet it still
> registers itself in FDIR flow list, hash table, and hash map. This list
> is then used by `dev_start` to restore FDIR filters that user has
> inserted into the list. These filters, as written, cannot be reprogrammed
> that way because the information a filter restore function would need is
> lost on insert (the packet pointer is not added to the hash map).
>
> Another issue is that while rte_flow FDIR code does lazy FDIR init on first
> added flow, the packet template API does not, even though it too relies on
> the same hardware feature, nor does it ever do teardown on last FDIR flow.
>
> Yet another issue is how the "filter restore" code itself is implemented,
> namely that currently it simply does not work. When doing filter restore,
> the driver will walk every FDIR filter stored in the TAILQ, and attempt to
> program it. However, inside the program function, there is a deduplication
> check (to see if flow being installed is already present in the flow hash
> table), which fails because the flows we are programming come from the same
> list that is being checked for deduplication, which makes the entire filter
> restore a no-op.
>
> The FDIR filter programming code itself also has a number of readability
> problems as well as being otherwise hard to use - SW bookkeeping,
> validation, and flow programming is interspersed within the code, and it
> is difficult to reason about what happens when the code is called from
> this or that context.
>
> So, this refactor does the following:
>
> - Reorganize FDIR internals to track packet templates and rte_flow FDIR
>    flows separately
> - Refactor FDIR init/teardown to always happen on first/last rule, so that
>    whichever API happens to call FDIR first, the state is consistent
nit: it seems you've moved it to the next patch
> - Rework the FDIR code to disentangle FDIR flow rule programming, Flex PIT
>    checks, SW bookkeeping, etc. from each other
> - Remove both the rte_flow FDIR TAILQ and the hash map (filter array)
>    structure, because they are redundant (information about the flow is
>    already stored in the rte_flow flow list, and hash_map structure only
>    stored pointers to data we also have in that same list)
> - Fix FDIR filter restore to replay all configuration correctly, as well as
>    re-init the FDIR queue enablement tracking
> - Rework the internal FDIR global state data structure to make a little
>    more sense by grouping things that belong together into structures
>
> Additionally, there was a delay mechanism at flow director rule program
> time, as when programming a rule we might not know if it's actually
> possible to install the rule, because space for the rules may come either
> from our own pool, or it may come from a pool that is shared with other
> VSI's. However, it only makes sense to wait on rule create (i.e. when it is
> programmed into the hardware for the first time), but not when we are
> replaying or removing these rules. So, adjust the waiting mechanism to only
> wait on FDIR rule creation.
>
> Signed-off-by: Anatoly Burakov<anatoly.burakov@intel.com>
> ---
<snip>
> @@ -3860,16 +3851,15 @@ i40e_flow_destroy(struct rte_eth_dev *dev,
>   		ret = i40e_flow_destroy_tunnel_filter(pf,
>   			      (struct i40e_tunnel_filter *)flow->rule);
>   		break;
> -	case RTE_ETH_FILTER_FDIR:
> -		ret = i40e_flow_add_del_fdir_filter(dev,
> -				&((struct i40e_fdir_filter *)flow->rule)->fdir,
> -				0);
> +	case RTE_ETH_FILTER_FDIR: {
> +		struct i40e_fdir_filter *node = flow->rule;
>   
> -		/* If the last flow is destroyed, disable fdir. */
> -		if (!ret && TAILQ_EMPTY(&pf->fdir.fdir_list)) {
> -			i40e_fdir_rx_proc_enable(dev, 0);
> -		}
> +		ret = i40e_fdir_filter_program(dev, node, 0, false);
previous implementation set wait_status depending on 
fdir_info->fdir_invalprio. Do we really need to wait here?
> +		if (ret)
> +			break;
> +		ret = i40e_fdir_filter_unregister(dev, node);
>   		break;
> +	}
>   	case RTE_ETH_FILTER_HASH:
>   		ret = i40e_hash_filter_destroy(pf, flow->rule);
<snip>

-- 
Regards,
Vladimir

