Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23F3CA5FCE
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 12:16:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 658904028D;
	Mon,  5 Oct 2026 14:16:29 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 90DE64028C
 for <dev@dpdk.org>; Mon,  5 Oct 2026 14:16:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791202588; x=1822738588;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=RRKJk7Ew407q0IOmh/tN9wLKqZ5vGs8snYPxFPQUZrw=;
 b=ainvBI+10hQhzDq7KGVJw+Nw60T8gxOWplNJtpOTVCK5/PRyyZ08StCT
 O5YI6c4LlEaE7Jy6I2UrMuR4KcKJpZT+V9a80MjK6WO2lYJIuzfSbJmbI
 KnqByIJsk7PXUQr+/+uN1MjFk8KTkvokINDVNIb/4cV6bwgZUa07NmS5K
 MwcHEGhprRtytlTDj0l1p5N5sNeNpsFCoTa6ZcmcR88MsxEGNaRsBdkgz
 YYCPkiARign0dBc2bs3yWVRLFINfkr1HCstRNVYPrveLZoHh+dZmE0wfu
 5azqtRsFGZ8q/bS76uL6mXp7RPxaUzD5l8IS2dD6dk/cn2FFTJBYJl0mw g==;
X-CSE-ConnectionGUID: jYxvlkHyRQmVZ36GQ3ItvA==
X-CSE-MsgGUID: OEQnPIv/RQqbYmrzsWUJNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11925"; a="109360395"
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; d="scan'208";a="109360395"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 05:16:26 -0700
X-CSE-ConnectionGUID: mKLX4PwaTMG/PUJyoohkqg==
X-CSE-MsgGUID: 3+klvsT9TFGJOXR37LQ69w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; d="scan'208";a="304761888"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 05:16:26 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 05:16:25 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 5 Oct 2026 05:16:25 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.25) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 05:16:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EpGM+7hb3682vMIWrwFGmFed9a2ND3fPa72K2UReoirW33G25S9/VJxEq98CmtLmdURw0XLLMU/8h+l6CM3OVWuWzujvJsa3UG4Kr8Vr8vo+7T9DjRlcemBbhm/aWp1q9IovH9C9Ad+H5ZriGr1RFwP1QIJWW4fyE3W8B2/d4AwOK2yqFZMJkZTXBsAwsgHzWV3wFdbbbWWFv6W+b0tPPdolBP3cnoeb4N4BAZrhZcUZIEi6qQdskOUBZBxIZ0zJgKA+cLsHFN4azWE4Xgfs7zgwz4wIQ1wYBQ41dbriWdc12MYnXE6QqsZsM/8QJIlABfTTXJ9T58Fe9JoObGUlpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XXcdwq7RflZNI3k6vtUklzLJUZGPPlt8QirH60AgZRY=;
 b=c2D7TYPcxZ9M3fVbHAKhdeu3CyhG+Cs+P+ocCHCmZpPyvPZwSQIk/QFGSEDUGAQGnQaSwj3Q19O0kYzKlf6VGiBbx2MxhQMs/FRCUxfw6ZOQcLLTwdKIe8rnazyMSAqzWXYuJL8jTV6Z1UHgeyMZBXOZapz46PG/b2eKCKtzDTzSlIT/HUVAUaUj5q0Sq3iuuOdsNAj454+ijHTtG1hYl9jLwzrWkUFvPm6N4nRrGSQj9qpMJjQOF60rVQsBKHEkQZ5u5PNL9aZaVPZZiy0H8hqiojgbk6QC2kJawUqNUFHwh9E1RnY2dDI8cZyl8bkEy4v1IfMbd+0im9msyndhgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SA1PR11MB6991.namprd11.prod.outlook.com (2603:10b6:806:2b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 12:16:17 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 12:16:17 +0000
Message-ID: <97fccef5-1116-49d4-81f7-df750e9000e2@intel.com>
Date: Mon, 5 Oct 2026 14:16:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/19] net/ixgbe: reimplement security parser
To: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>, <dev@dpdk.org>
References: <f73af272ecd80e5f059a6db26d85cac6d55b750e.1789560945.git.anatoly.burakov@intel.com>
 <5d9e35d2-f281-46a0-ab37-3b059d438ce9@intel.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <5d9e35d2-f281-46a0-ab37-3b059d438ce9@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0262.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::24) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SA1PR11MB6991:EE_
X-MS-Office365-Filtering-Correlation-Id: 975131b4-d34b-4ab5-d0c3-08df22da74e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|11063799006|4143699003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: X5CdBoUtIfkXdXwF1WnBSt0DktnkDkqC0eU5Kw6hTsdknb08jeJZ6qOnz+4Vv9L/j5Vb+guD/v8QnhQr0F3b0apjkAvUiwUCmHABfszzydKNURLSwYu8KnpZ+yU3Js2hjBI/UZCy9E0KbKqZAez2565r5XoHqCnNYRC8XckXrlGOBgfJlUUP5Z/dbPz7RMvTTQVREieyn76TV4yegk185TjrbRRvb2EiMw3zpqVqVApDAbg1ojJMI4Ez/C6OI6gK3LcBEcJ8TIKSuzc/LFNpiSpOkI+N674dvFvYd9+1GNCkixhHdI2XAKxG+VcGoq1toLx0vKnc3k8DyYXUj5A9EYHuv8hYD0V97YIRm1jiIEMQK8+g3bIF7aDrCLfpTM5ps4kPWtfXzh3cFd41YMKB2J0MrMEkjT5oBF8fA77/bpDtV1TdpskQc9IT2VOjh5B2VHOKJVbJhaTlvvDtEi8qIgErXDAIhcfgxtxUxttSQ/gTKBUZLzKeMBVKZtD519KzvBeTMuRW5K9HwBV7EyJ3uCRPJM+V4ozdFqhA8faEJ96R3odeGU551Ia6H9YhMA0X2P6VwcLXCoj8MViqsfqObUu2Zki4y6lUmDCqGWO9HevCuylhSQ2qR3EZeQgFpNvnHNskD4pJbHQvDA/4stjiS1uaM0TfZKsDc3lxnp80BEo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(11063799006)(4143699003)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEZMU3ZmZXY5R2RydllqZUtoMTJ6ZFl4YmpjTHJoSkx5cGlCUGZCV0FXbXFQ?=
 =?utf-8?B?dk8yT21Ra24venZEZmZreVEzdk5JbjlNL3QySWlobnU5a3dXUis5TWNlN013?=
 =?utf-8?B?Q2wxU1BYZXUwM1pEY1J5dWhpYy9Ob3BscTk4QWZHMXcwQjZsbzlpb0lGaXdO?=
 =?utf-8?B?SWN2bjVPcjZRTHVjL1IwZGkzVm1abmpLRFkzT1RBYms4WGZBSHlWQ00yQnlH?=
 =?utf-8?B?VnBETDVjYjEwektIMWppaE53UVJJZk9aS2ZaNjBWc0FWQk04RDFuTmQ1M0J4?=
 =?utf-8?B?alZXbHcvMk1JclBpMnk5RkFGQVI0ZTVFV3VZSEdPU25CSzkrRWFRNzEzSGRw?=
 =?utf-8?B?dmJXS2ZzWGlwTVVueGhsMUswWUZhTGlVeU1sYWNNbkJVQnpab3FXZDJqVTZU?=
 =?utf-8?B?T04vejI3d1FKZDhFc0V0YUQ3eklYK2g4T1B0SS83QzE1VnhaRElTaDZCb2I2?=
 =?utf-8?B?bTZoZ1Q5MDJnTit3Qlo1S3dscHpzU1k4TnhXNnBaZFBaSjJvOERibytQci95?=
 =?utf-8?B?eXpaSnNTZkU2SXBhMzhWVjZQelpMdkNMTTRtV3RveGlOaEpGYXVHRVZWVTJj?=
 =?utf-8?B?OWZ6SFVEdHlGcFBMQm1yRDc5LzROd2pHblc2TXd1ZFZpcXJHUnJiYU84blVP?=
 =?utf-8?B?d3F2NXZwSUEvZDBtSk9jYzFwR215Wld6eURIMWx6NEJPdG5zR3B4dmpKSDBp?=
 =?utf-8?B?RWxjR0svVHVIWVhIeFNKYUZKQlBxWGh2clI1T29oeXJPejN6QkJkZUZrY1Bp?=
 =?utf-8?B?VWh0Tk8raWdzb0VYelFxZkZWc3d3REg4MEU4Y3cveG5GanVGU3VxRGtlM0JU?=
 =?utf-8?B?V2xYUDl2N3Z1ZTJMK3ptNmcwc0YzcG1vS1FJZ1VrTFE3K3JGYmppQUJqb0Jw?=
 =?utf-8?B?RjhNdG1USDBjZkpLQ1ZzZjhDUUZ3bmowczdpU1BrWWlLU1VvbUx3eTFra0c0?=
 =?utf-8?B?VW9Lc0pZNzFaM1pvSDF5U2o4Z21WY2g3THVEamdWSjdPYU41eU16emdqaGVD?=
 =?utf-8?B?RGwwRkNpWnlQYndmL002SitROEVUUHIxOHJXZHZLaHV2aHVKUWhZWkJmeExQ?=
 =?utf-8?B?WjlUb3U1eStCQkpxYkdMMmFSbDZBbHB5a2Z2eHl6U29JZzNDUzI3VFluOERJ?=
 =?utf-8?B?NHdPWWx4bnVXNDl1NzR4ejFuYUNrSW9OWXlsRUhzM3lkWTNQdVhabTcyVUFt?=
 =?utf-8?B?aXNuTHZwU2JReWgxNFJsdml3SlBqWnpLNXRZMFF1dWoxbEhMM081ekVoaWtz?=
 =?utf-8?B?ZkI2T2FSUUFTaDZsbmxFN28vRXVzditpSW9EYXI2dGx4ekxkak9Hc253c3FO?=
 =?utf-8?B?Vnk3UHFOcENhWjg5T1BGN2kvNll0d1YxSDUvNkdLTFJYSUtiV2pPa3pLTnFq?=
 =?utf-8?B?NmU2UDJBcTBEQVlnRjRRbC9vTUdGMTl6T21ZSzNkcE8rS3lBd2xYN2lLRUFn?=
 =?utf-8?B?MWtLeUVoWkcraWZadkE5emwxT2pwR2hYZDZXQVlnYUdkSkdKbEI1ai94Und4?=
 =?utf-8?B?VmkwOUN0VEV0d1VVYUNUL0tFNmZleDFmTGV0Y2srVVJCb0g5WUxSdmcySGFE?=
 =?utf-8?B?Um9sVmZDbWk2WEMydlNjL2pYRE1ocHNGSjFKS1BabnpUd2tXdU5OOXN6UU9U?=
 =?utf-8?B?N3l1U1owNW1WLzFTZnlpa1dVbWl3NVRpUk9ES3JuaS9hcVR5WnQ0Q25kVTFn?=
 =?utf-8?B?Z2Y4bVI4Qlc5cFpIQ0h0Z3BvaG01S3JjcjdoK3pNUG1NSlZhb28vcWFCT1Vo?=
 =?utf-8?B?WGk3L05PZGFDclVKQ3pXUE42TnloRG52ejlqb21FUFZkY3Nxai9mRkFtV1Vy?=
 =?utf-8?B?NkxCYURwMFBrMzV1NjdYaG9JN1RYSFFCbVJROEJqSDVWT09xWStCWlkzYUx3?=
 =?utf-8?B?RlFrVDB5UDZoTFdoeDFrOTdjQXNqcXJVUVNjR1JXVzJBS1JiK3BvT29zbUxE?=
 =?utf-8?B?dnRaNzR0Z1ZNcjRzWlZHTEhZeEFhZUtDQjB1NWlxSWlOUEh4QXYrQll2Nlph?=
 =?utf-8?B?NE1LUmEvM1ZHWDFJK2xjaW4rbFpYanhTS09kdnZqc1dTVnBoUG5DZHFPRElp?=
 =?utf-8?B?eWxBSFJzZGpyRVp6R3hRMXducDJ1T2ZSMWZvWlFVRGhjZ0xKNDlVc1RveHpQ?=
 =?utf-8?B?VjU3TVA5SEFpWmkvVi94dktFbmswaWdMU2tQaW1UNmVERUZGUmZ2KzhpZ2tM?=
 =?utf-8?B?aStvc2pucCtjR1dYYjJXZFI3TGdkQy9BTVovWE1OZTJ6VGt0VFZUWG1jclEw?=
 =?utf-8?B?OFd1NTNRUFZUakZ6Rm9FMVNxTlAzSEVRWnc1M1ozYnVucUIvQU14cnFjWTVN?=
 =?utf-8?B?d1lKOEZDYjdXSHE5MDRmZHJYa3NiSE8xQm5UdGp5Nk1HUlFUZ0VpNk5XZkph?=
 =?utf-8?Q?NsVRiBuQs/8PRK6c=3D?=
X-Exchange-RoutingPolicyChecked: Zg3HoiuMV8WopCTejf3292Cf63Xt9VXtJp2ox1Kax0qJAjTc4yFnjzYlxnnvYIGYCOHaWie7wZ/aMPELHXYPElXySWPLPSTtA4TXTD98zU1LFLityR2RY5kQGRR7nASKgcAGHB03WSw0Zkg0bTBe5haPx0VShEOBnar0mABl+LoZfyBCaFdIm9pGPwDDdVLxRmBTExLOPiQucjsxe7wYcrZSPXtyK2RKQph861CRgc/rTzU7HHQR9UDACUBiWx+XsCaWcDWivX5SonNS8UZxOEOPta0aCx5OWwaZuHjryGfX5vbMxCJLxOIeO5/Cpew5InuyNw+VgguNuiKJ4iqKLQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 975131b4-d34b-4ab5-d0c3-08df22da74e6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 12:16:17.1407 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fwr5u5LYD8C7f4YQJYJKwWJJuJZpqksWE3g3jkV9K35tIt/EWlzsXaeIyRnWv8kyMHh6WCWp1uzb+NVavplLkQOULim6+7yMgOUNVcxeGYk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6991
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

On 9/19/2026 6:11 PM, Medvedkin, Vladimir wrote:
> 
> On 9/16/2026 1:18 PM, Anatoly Burakov wrote:
>> Use the new flow graph API and common flow engine infrastructure to
>> implement flow parser for security filter. As a result, flow item checks
>> have become more stringent:
>>
>> - Mask is now explicitly validated to not have unsupported items in it,
>>    when previously they were ignored
>> - Mask is also validated to mask src/dst addresses, as otherwise it is
>>    inconsistent with rte_flow API
>>
>> Previously, security parser was a special case, now it is a first class
>> citizen. All decryption SA tracking has been moved into the engine, as 
>> the
>> engine is now the authoritative source of new Rx flows and the state of
>> the Rx SA table (the Tx SA table is still up to IPsec code to manage).
>>
>> Because IPsec code does not manage the Rx SA table now, a synchronization
>> mechanism is needed to prevent IPsec code from deallocating a security
>> session when it is still referenced by security flows, so the security
>> session is now atomically refcounted. For Tx, the refcount is effectively
>> a noop, whereas for Rx it is now managed by rte_flow security engine.
>>
>> Signed-off-by: Anatoly Burakov<anatoly.burakov@intel.com>
>> ---
> <snip>
>> +/**
>> + * Ntuple security filter graph implementation
>> + * Pattern: START -> IPV4 | IPV6 -> END
> Previously, pattern support was not as restrictive. At least, we could 
> have an Ethernet header in the pattern. With the current implementation, 
> ipsec-secgw could fail, since it can create an ETH/IPV4/ESP/END pattern 
> (please refer to flow_init_single() in ipsec-secgw).

Previous code was not "not as restrictive", it just ignored everything 
before and after IPv4/IPv6 items. So, I'll add ETH in the beginning, and 
ESP/UDP after.

>> + */
>> +
> <snip>
> 


-- 
Thanks,
Anatoly
