Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0D1CCF2E5
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 14:16:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8CAF9402E8;
	Mon, 19 Oct 2026 16:16:13 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 93AE340297
 for <dev@dpdk.org>; Mon, 19 Oct 2026 16:16:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792419372; x=1823955372;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=KYnyJ8Lwf+Hx8jRuIJHd+FGt/Q6b1PV3pB4TdNsvJlQ=;
 b=S6aGSbPKmQlYpsY2F0KJnvh//0oi1gtZyALHTs3XLmTM9ugZ56lSIAQw
 RT/MhKLX2KVWtR/mAZtPYL7kE+IWCbTRp3zS7UTNDn/OHmxEGo74TFlz0
 VswPhJTQ0DxmuBaJLVH4tKniMOHunshPspKAIlcENrg8Nb/Luk3iLuCnq
 kGaEwS3sc9G1eO1qzYv2AyoQRLCtL2SFYViBuDPtMC8Usyl5Lg61Bpbb7
 yWVQ3GHQUEwKyZnr9rnXl5nskuuPUXIc/N+VcLGhjItGAbySuJO/egxcb
 DmPHT1jC2meqezia+kaHn/FTTwaNys15Lo1awvnqrrz/bRqRgvcuHRemq A==;
X-CSE-ConnectionGUID: dknWwyO4QHKW5lC8EJh+jg==
X-CSE-MsgGUID: kRcPvfRUS/SqRo3k1mlU3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1207501"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1207501"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 07:16:11 -0700
X-CSE-ConnectionGUID: ewG52sn0SAuPFAQ5Q97GJg==
X-CSE-MsgGUID: kiph3WPXRGaadhpFE5g92A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2645500"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 07:16:11 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 07:16:10 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 19 Oct 2026 07:16:10 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.41) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 07:16:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R3BoTmFZs89f7YQ+KyicZbhK30BtC+NXrEm2VKOM44cyl18TcS214wW8kPZCj+ytTbFa+foCF3gIFysVHYB5TyEQ2JJaXdxd57NGdF5AjlL38LtwYIesFfqnclJ6QClMo3EmN4MerAiGCksqHNBx5ezNCgEpKbDOt1Z/jHn/moWHDWmYe7iY3EkQILe/iwUSHZ352RJWa3Oko8gKGgPkfRqxY0TlZivLfZOpwsEbuZVD0ErIqpAOeFcENBanSi+S4+Vvs7ToXOAi3H0/90EQjX0OZBg1T9r/R5jV7uOo2h7whlCQbm5zxvG+UdFDvnw69rmsyCsV4wsgd87fs5RX3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5A8gvApSfiKSHeMCpwTIoFgZwGfI7ispp5vyaMEPOp8=;
 b=in8q5eQe34iA8eyusnFND6gqbq7bnHlk4J6MuXDuYc6FpfbMoXpAdxxjUjF2LEOoGzZ/PwT8bAudnV2PCwbRvP5PV4kTWD/fv4qHSbpozssBLAzFojDx8Gq023dYNtp8ntIUv9URaspOVlXTfmcjerwpzlRzk9yjGmHxEYs6q0CybN4+URLEDGHCEm34K3hSYD4XnygU7KAva48iVDK0Nt8W4PFyDI/dwcOajI29jPKxMJAdH1PE6FlCm92hn4zx/OFJE4MLarCSxHzgffLVZHY0G7yZd4qB8zj8lB4mRioi2EveYgOcrcQSx4f3yv7QxX87Jp4b5E8XlgIK+/Er5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM8PR11MB5653.namprd11.prod.outlook.com (2603:10b6:8:25::8) by
 MW4PR11MB6957.namprd11.prod.outlook.com (2603:10b6:303:22a::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.13; Mon, 19 Oct 2026 14:16:07 +0000
Received: from DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa]) by DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa%3]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 14:16:06 +0000
Message-ID: <18b34f38-6961-42e1-a828-ca60035a11eb@intel.com>
Date: Mon, 19 Oct 2026 15:16:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] crypto/ipsec_mb: add support for IPsecMB 3.0
To: Thomas Monjalon <thomas@monjalon.net>
CC: <dev@dpdk.org>, Kai Ji <kai.ji@intel.com>
References: <20261012135947.1895429-1-radu.nicolau@intel.com>
 <Fb4CjKFWRziKn9hdw7IRLA@monjalon.net>
 <9c02cf79-6902-429e-a67d-e53ae203bb49@intel.com>
 <8OA9ksWHSu-USgHcEeFFXg@monjalon.net>
Content-Language: en-US
From: Radu Nicolau <radu.nicolau@intel.com>
In-Reply-To: <8OA9ksWHSu-USgHcEeFFXg@monjalon.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0016.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::9) To DM8PR11MB5653.namprd11.prod.outlook.com
 (2603:10b6:8:25::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR11MB5653:EE_|MW4PR11MB6957:EE_
X-MS-Office365-Filtering-Correlation-Id: d6988734-ce87-4614-c05e-08df2deb83ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|56012099006|11063799006|261009223027099003|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: puVmDqZw9+/LdjYBr7/YdTRlsorOOeTJSzuohmDTS2HhNbZTq1D/moySDHYtY7ubIcKM2qpTWE9yvyla02pbB+xl7yZVIGgx2IEgoOHmg0WLSF+4eklbynQsaqsrEtJhd+zyHkWs9jf3x9s1atGdS3bMMzAZAFfeqN7tGecE6vyrMiBDZkLzd1KlaZ4FSneutF6u5eVYhBq/m8gjwxIfzUAhsKFI2NxZ47gl7Bwfsm+gw/LEOwiwOVjeIxsjE5uIeAChvygr6N0YAIREuHYtOtqaFLB/SFQosG1/ymO6g8s3yGnFNFT8BvuVbgfo2djVgvhcIO9JS3z5/hRp7drXRnh0pA0W6MzyVxQK/l2SRn/1HuFW2HFZ4u+Gq6cFNpjWkVfnuxBWthB9MWlIZ5gVMzTDFm6XfzcOJgG4uY3gYNIb3YKU5crcZsbuj0RGFQKBspNyqdbI0zP8QyjAYv2vkHHIDPpU6c4Z5rXds4Ryr/1+Ub4xxuvJb88HgduTNLBpWfNzTpevlL51muyw9ZwRZNbW2nOg9nrsFKQa1B1W5jO0G0fTBTRr5SJ0cm6XXA5BbRabOibjVWMvqROUUifzUeguSvWvLaDRabgaLaz0UrOzVQq8LuhO8lmYmoRhYZOSsZ7BWUyggDEUMaASr18T0b2L9DcgfrnrGjNMRn+dYJg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5653.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(56012099006)(11063799006)(261009223027099003)(4143699003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlB3Z0ZFVGhPdWRjUGRVeDE5WlJWVDVZVlVuRVlnZXB5WXBrSUFvYXh1VnVk?=
 =?utf-8?B?MFRNaGxTLzAwbzdCRXZuN1o0eVFnejY4M1o4ZXVIMWdoY1NQKzFGY3I3OUNV?=
 =?utf-8?B?cmpXSTlLVjl6QU9Fak1vSmxUVkxUZlZZbTlBaEtSU1hBejQ1cTVpTCt2NnFq?=
 =?utf-8?B?bGl4SjlVdFR5ZjAzMXZ3TFc5NWkwRzNqaGtYQVNMQ0RCN1lRcm96VWttWVJQ?=
 =?utf-8?B?VWhCNFdTdy81K2ZkdFg4bTlkUy9sSHRuN095ajBvOFR0TVZkSHhPN3daOHlS?=
 =?utf-8?B?bDNPZDRlL0Y0cnI0MFhwQTIwcjZlNXVhR2toblY2MCszMlRwUnFJcXJUMGlD?=
 =?utf-8?B?b1ptWjZ3RUs3a3h4SVZPMmQxUmlwc0hxTFg2RXU0cWtSRVlydDRsNnF2blJr?=
 =?utf-8?B?aS8yV0N0dkR2VWdMVTZXNC9iMHg1S2kxUUdYaVoyMUl4UXBWRHU0dkJBZEFv?=
 =?utf-8?B?QnhFeURWb0JjY3JCeVczaXVRSTFhci9wQkVnS1ZraHp6c3pXSTFuQ3VwOFNx?=
 =?utf-8?B?K3Z6d1Z4VVhWbzNJZEQzTkRRSWdobWdPekpScU82TTlKWk1TaDgzTlRiK3Vo?=
 =?utf-8?B?VTRacDRyZjB3QUhDMDUySHkycFZSdVJmRm0rQ3N4YW9zQ0R5dk5ERkpnT3BB?=
 =?utf-8?B?ZkdXWU92ekVuZEczRW1hYWxPTnZpVWpiUnpZRlBkcUZOUllsNUtod01oTW9U?=
 =?utf-8?B?dXlhSGRhdFB6OGEzN0lQK1pVaFdCL3FIeW5IbUxydzdacjRvOEk3b0xkNGw2?=
 =?utf-8?B?cVF1U1duMEQ3OHkzYWxITFhINGsydTBsRFd4SVFwTHBRZGdKZUl3ZnV4RXFC?=
 =?utf-8?B?dUhqZ01DSGlJS215VkM1NzJnUTlPZGpRaExpQTV6RWVQM2FhZU9NNEV6U2RX?=
 =?utf-8?B?WHZHM1c4cEFjRVZJdTJqalk3MFNwMnVKOVhwdkxiKzJnWFRNWlh3NlFZemtG?=
 =?utf-8?B?YzFsSG0vMnE2VndSRC9QVnFQam1WejgvTkV5Z1RBSERSR0pVS09CV0swYm50?=
 =?utf-8?B?eVgrQTVEaDVuQ2Z0MG91WThCQ0dLRUdlQUk0MnZkYnYwdE8rL1ppWm9ZS0sz?=
 =?utf-8?B?dC9pVXBEdThCU2NQdmN5L2FDRXc4eWZ6MmgwR1RCVllaV2pDeFFQUUNtOG5Z?=
 =?utf-8?B?V2lGVG42dmlaUmtoWEpNdExaMVYyL2gvSzJRQnowc3V5Zy94bGdCTko5cUk4?=
 =?utf-8?B?VDRkaDFVdHRWL1BsenVINUJHQXRNay9tTlpmYXM2aW5tUTdLblE1RzBXUWNO?=
 =?utf-8?B?Nm9Tbi84YTVub3JLOHQxSHFaKzQ5YmtnRFlyR1g4b3haUTRDbThhaDBWWFI2?=
 =?utf-8?B?aSt3dFFQcjNxVHowWDI5TGlMd0s2S0YyZUtSSXBTak1udXdpN1hkdjdEZVNz?=
 =?utf-8?B?R3RFY25MV3poaFh6YS9oZTk0VVg3MVk4bVBrYXdyd21KY29uYXBHZlJmMkFn?=
 =?utf-8?B?L2lZbHg5M2o1dHhzU3VUZHBVQTRiY3FSZnlma2lsRXVmVXB3YzhudCt3ekc3?=
 =?utf-8?B?ZURMTi8xaHVDaWt3UVRoYWk0a1BsUXZlZGJubG91anRmL2tuOGI4VDU4TTJC?=
 =?utf-8?B?NWhLNzhhajFUYUhuMDhxTTVVSUd5bG9PMEszR3NTOHFUSkZSM1ZKbitOeFN5?=
 =?utf-8?B?TVJ0S0M0M2tHU3BMcVVQQ3JYb0VGRkRnWkZxL1c4MnNhbkNuS3A2d2czVEND?=
 =?utf-8?B?ckI4U1k2NG5SZmRDRGFQT0FDSWRGcjlzN0g3VCtjQjRtYmpSRVRtYytQTlIr?=
 =?utf-8?B?dDY3WUVVZDZqRXVOZUlYZHVDTU95TmFCMElNRGpBbmZnZTkycUpGc0RwTkFY?=
 =?utf-8?B?SGFOeTJsRUxLUVhEY0IrWlYzS2RtSXFuTG5MTm5LRm50a3p4b1pHcVE4eDJk?=
 =?utf-8?B?WjRjWXFYN3hHVG10eU5BckxLUkZVS0pKUEIxekZWSi83N3pZdGpQbFV3Ri9H?=
 =?utf-8?B?MWVRT3pxbmtpNWhSRGFFcUljdEpUM1BLYXI0VERrNERvWmc1QTZvRjhoZVd0?=
 =?utf-8?B?VU5JN21yT0dmenZodVZoQlRScXpWN1ZMNTNXSFNFV1M3akthY1JSRWxxcWdp?=
 =?utf-8?B?U090V0ZOTjV3SUJMSnRhcTN4YndRS1JhMEVYYjY4VGFJakw1YWhMQXN1aU5X?=
 =?utf-8?B?OUhqSkV4N2dSWHlId3FsVEU4S1FLeU5nMzQ4TG1yZFZmVjZYL2pxOGNSWitN?=
 =?utf-8?B?WXh6S1c0NGk3RG1xNjg0em5pWVJlVzUwRElDcENWazNzZzBPS1dJalhEWEtQ?=
 =?utf-8?B?Tm1CNUxYSDBOMFhsdGtpeHdNanN0Z3hkaGdINktteWtYejBEM0FuZ09UQ0ph?=
 =?utf-8?B?cFFlN0hDbnNuekxVVEU3Q0xCZ0NkNGxSUkRwRXdXY1lmZ3lJV2M3QT09?=
X-Exchange-RoutingPolicyChecked: yzMDmtfePig5kMrf3FYdWaNmgaPxaQA2M1cFiqzDJiQ8tm9LykiDZvtovjw15x+yRW8VHKB84XV6qbAN/m+i0a3SUGQSxZ3P13L0TfvYTk/MZRXa0anAUgdHefmZZEhHhh+jgYaM7LRIo7lCOhBwfkwzCWsVhOhtE+7XjlTfzO+X/lwO9uKHurRTZ8XNbChZFkO6rby8N532p0JPGV7wzcvLb2hwrAHChdOpbBGj2mSs/A/wb7ctdh1YcLEmvraDNnSgESWkIgYheglTOrnJeajbtei6XtLIhKHzS9AKNbsIqju29x07jyqWFLjAlPDuoKnnh+m5tqIvYhG2RC4zHg==
X-MS-Exchange-CrossTenant-Network-Message-Id: d6988734-ce87-4614-c05e-08df2deb83ef
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5653.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 14:16:06.7213 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zyFSq77rLvBR5R9o0q8jRx9yawF5Z5qOwOODo3OzD6APO+n46OLlu6f6t7dlLIt64fddqAXH0srtvhbqckQzWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6957
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


On 19-Oct-26 12:27 PM, Thomas Monjalon wrote:
> 19/10/2026 11:25, Radu Nicolau:
>> On 13-Oct-26 8:41 PM, Thomas Monjalon wrote:
>>> 12/10/2026 15:58, Radu Nicolau:
>>>> Intel(R) Multi-Buffer Crypto for IPsec Library released version 3.0.0
>>>> codenamed Túnel Pablo
>>>> https://github.com/intel/intel-ipsec-mb/releases/tag/v3.0.0
>>>>
>>>> This patchset adds support for the new library version and support
>>>> for the new algorithms included in this release.
>>>>
>>>> Series-acked-by: Kai Ji <kai.ji@intel.com>
>>>>
>>>> Radu Nicolau (4):
>>>>     crypto/ipsec_mb: add support for IPsecMB 3.0
>>>>     crypto/ipsec_mb: add support for 256-NxA4/5/6 algorithms
>>>>     crypto/ipsec_mb: add support for ML-KEM and ML-DSA
>>>>     test/crypto: add asym test suite for AESNI_MB
>>> Sorry I will give a defensive NACK
>>> because you never fixed the problem with the Arm fork.
>>> The crypto branch is already not compiling on Arm
>>> because of your recent change for IPsec MB 2.0.
>> Hi Thomas, with the latest changes and removal of minimum required
>> version these patches are now compiling on Arm, are we ok to withdraw
>> the NACK?
> If they compile, yes.
> What changed?

The main change is that they are now rebased on main, and not 
next-crypto, which included the change for IPsec MB min version 2.0.

They compile (and there should be no further issue with Arm compilation)

