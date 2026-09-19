Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028FCC982D8
	for <dpdk-dev@archiver.kernel.org>; Sat, 19 Sep 2026 16:11:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5B26040B97;
	Sat, 19 Sep 2026 18:11:43 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 2A3D140A8A
 for <dev@dpdk.org>; Sat, 19 Sep 2026 18:11:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789834302; x=1821370302;
 h=message-id:date:from:subject:to:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=BZVUiP9qCtGPj3Uf84Iuey6fjufg4nAzSndvMOTqj1E=;
 b=XXegprFGRuw1jtatKCxD5iGWh1JD9T1i8KSD77MeuZ83M1jOpSeMHc+9
 fLe/vMErf3bySVpXAeKpcZSbJWdQoqXpkXIiMa4P1MdTWwRMX2g6ErYXA
 UufcpTa+jXy3w2TlwU9731synMLqFjSuMuKbiY57rpiJQZwyEmAWjgACq
 cTCwZakRGwPsnwAaIoBEPMyb5peEJ+kr83iBUyjk4isyp/bOBqxldZ8si
 Oc0J9oPYPGMnp7l7AXTil/74jveO0NvqCm24k9z/vW9fuDwOsBIGbM6K1
 JTZvtc6ohGaP0XUlHIkqSZBia8Y/bZz+RbQVifKq/kpcH5kyI2i35dMV7 w==;
X-CSE-ConnectionGUID: vb6pR52USx+6tol0elsGdQ==
X-CSE-MsgGUID: 3kH9cwkuQmSK9eFtZn9lKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11910"; a="89287858"
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; d="scan'208";a="89287858"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2026 09:11:41 -0700
X-CSE-ConnectionGUID: klpiyVWWQwGYXdTH2sdUvw==
X-CSE-MsgGUID: aDLaA47ER4upYTuWJQ2fHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; 
   d="scan'208";a="3326438"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2026 09:11:42 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 19 Sep 2026 09:11:40 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Sat, 19 Sep 2026 09:11:40 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.35) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 19 Sep 2026 09:11:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xu6zpZESDDUfauYK941yXITOdzkwX6pxhTd5uH7QI24Wn36He3ujcRTT+VPIq8K9AuyXGwQGLfzwYUmA4ZTaxQr8yev/Mz2hE8Tgf3vLzqagCq6UiQJkESPu0Xx14HgwaONpoBdVbsvrHo9W3JsZT6dXzjdKU71YERsoDBE741lNHNI6CEWHrnIyNnkXQ+tgW2ftz3LpMvEFE2W6CcDwqY+zPokE/upJQiSDZ2Fic6Q32oHQMBB2PbnHOuVnQxkw6dztkY+Zl0Ob2Zy6yL7obFctEop91ZBWyoL7l1LqvU/sFE9kZDUK02blmvYXII1CV4sqYWKOBTbMKu04HpthNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kk8YHD1dGEZ1zX+8NYO7nUKYRO38997/NfStlHB0BQ4=;
 b=LfS4lkkDp/SNXlX/Khqox5l6JpnlywTjYm3pN2nI5DH1fQwr3d+HrzYaQl+k2bowCdmUIcejyZWHKL+Kt7oPFOe0iRzo0uOf0Y6IsPeHAdptbpEUrB226Kp8sbSXE6r5XD0rKav4F73LObVGVoH1zd4eCtr02e3Nfy+3tz7B0q9KRgJyw0O7ba3m2kefJcs8AHWWQ0Om2K1ws++V3draJzg7mR+oJxmmiYSnQUCH9Hj59MgqcZq/MGLqRDDGMzLNd5p5KNDcZeqCwrjoq5+KKSTkNBJNpMKHtaqNwsSZGzwxaX+kJIdLe48vies6gKFWsCAp3HFpS94AqTiVgisWGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2993.namprd11.prod.outlook.com (2603:10b6:208:75::28)
 by CH3PR11MB8444.namprd11.prod.outlook.com (2603:10b6:610:1ba::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.15; Sat, 19 Sep
 2026 16:11:14 +0000
Received: from BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046]) by BL0PR11MB2993.namprd11.prod.outlook.com
 ([fe80::5877:2021:3cf1:1046%6]) with mapi id 15.21.0428.014; Sat, 19 Sep 2026
 16:11:13 +0000
Message-ID: <5d9e35d2-f281-46a0-ab37-3b059d438ce9@intel.com>
Date: Sat, 19 Sep 2026 17:11:11 +0100
User-Agent: Mozilla Thunderbird
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v3 09/19] net/ixgbe: reimplement security parser
To: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>
References: <f73af272ecd80e5f059a6db26d85cac6d55b750e.1789560945.git.anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <f73af272ecd80e5f059a6db26d85cac6d55b750e.1789560945.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0291.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::9) To BL0PR11MB2993.namprd11.prod.outlook.com
 (2603:10b6:208:75::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2993:EE_|CH3PR11MB8444:EE_
X-MS-Office365-Filtering-Correlation-Id: cea3a583-77e1-408b-5e76-08df1668a04c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: Ho7zLPlLtm/CjVqlO0OzazENtU2zX59ET8cEGqnkwkgV/MQPSoDgRP08/ndjbZdPfewbPM7d+wNlAP+J4s2DfjkwM4Nz5SPFZgYmo7Xo/JcF8PqqKsJUzn8OJlr2SedGa3mZEbCY+Ei8GNup/X/U91HIHCx0DIWt74eU8jXAWgnkXz1Mzy37m77MxhzuDj712kA5GgI43iULC7ti/881MUV5kl0hd7/DBgCkI6ete7DLF40kMQhCqUZs8oSM9/unxEg9TMmEPbcS51iOIK3nWztF6UZX+b0odasWb4kc3Y6kUWyPBAuk52Q4HBHlT3UzIRILJDU9spxpPH9f5jUPNHzDiMeHidM/xpemypJOCpa6ugjbBCbGat4ib0Ztxvaqsl+H9T+lOwx58zaV3sS1LPhQ0AtNq93GS6fykHUM2M1S/AosCK4jKrS6OqI4PB4Es1H9uwLQt4B7n0DDFgv3Jtf9pg56wq21Tr8o9lYVTLNJdt0SgDKFclc9tWQoKys27GRiY4uqRbZXZY7lkFBp3D60kdOKa2mi8sO+KDQrEH27vvLIw3ee82vXDalxGXByxXMc7mF2I7dUwRN0+SsKpK86BM5S/g5yyNOnxJ8i6ieATEl3BFbhDolgoRL08wr28yayKA3yca2XYExhAp5Thzm9kAQOQcvBOEi9nhDFhM8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR11MB2993.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ukh3NmZMSUo0eEVjZk5UYlhRMUw1Uy9CRHFGVkhRbFVoc2NVb2NTRTNZbE5L?=
 =?utf-8?B?SmdaZ2RYYllVMTB3dmRqVmIvMjlOM1plSjFiQS9tU2lBL2E3UzJmcDloNU13?=
 =?utf-8?B?cFIvNUx1Zk43NzJvclpmbDQxQndMYUdURnFoYnhPQmVHN1N5S0Q1NXVrQkdj?=
 =?utf-8?B?NkJLdjQ2eDFNZWZiUFVGcGFHMzFSK1JVem83ZE45TDBNK3BkaGsyQ3dyR2Y2?=
 =?utf-8?B?RlRqay84TEZuTFpjQVg5S1BiMHVYdzdFbVdTc0cxRkcwMUVqT2tMM1pXd1gz?=
 =?utf-8?B?ZGdva0FLa2NZM0FRN2Qrcm0zaXhJZnpHNGo5bUovV3VVTXVENHQ2Y1UwR1V2?=
 =?utf-8?B?b1E4Q1A5MngvN1QzYUtQV0l6VTY2QjBUZWo2WWxLSGVCOXVnYmhweGc5aDBo?=
 =?utf-8?B?NGNFUCtMNldSMDJSVlVqbExNUnErUWVOK1pmc29VT2ZyMHo1WWlGVDlGODVY?=
 =?utf-8?B?aDRlOU9HdjZ5YmEzYS9heUhMUitZZW5uK1JLOWFoZ2RhVm9CRkJhK2hFd2lh?=
 =?utf-8?B?czJ6OHZpOXFqK1lwdFBJYVQvMHFPT1ZGL0R4RHp3cjVIbGhDRm04VDd2d1Ni?=
 =?utf-8?B?WlZteGpZdTdubmcycjNQZGZFcDB4UWN3MFk0dWtSVXFJTi9CMW1jdy9SY09s?=
 =?utf-8?B?NTZ3bHFVZXdGYUZJUnpDTEZrcWpzTVRvYnNoU29wWXhRU0RZUlFEbFJTSGxB?=
 =?utf-8?B?NkcrSTk0OTdiS0RuY1VSNkdMcEV4dy9lVlREaHp3VkRsZ3Z0K21pcXdXbmw3?=
 =?utf-8?B?aXdrN3hERWdTMTR5T1lwY05MUWt5V3dmc2JpTGkxZ00wSEFGSTFuK1QwcDBH?=
 =?utf-8?B?WDFFMHpKNFBOd3lXWXV4a1U3dWJPNCtZSGdPdy9SeHhpbU4xa1JIdGxyaENF?=
 =?utf-8?B?RzNzTnhjSEt5ak41WjRKRi9HVEc2NW9sWGlmL2RoMXhxOTk2bWhHUGFkc0c4?=
 =?utf-8?B?UHZ5OVdYa0RhNkQrUnZ1V3ZCMmZqTWltS3lDS0RQSGxNZ1NBQ1ZVaGVkSWVV?=
 =?utf-8?B?WUhPZjFRQWJ3ZVM4T2RwUHcwNnl5NzRDRkVncDVqNnFRUlBsUHlYRU1qY0Vq?=
 =?utf-8?B?VFk0eithRTh4Nyt3K2k3RlZLc3BZOFhkR0VmbE5ZVllCTTVVOExYUzNPaHhI?=
 =?utf-8?B?b2hlWExyNkFLcURjMkFPTW84QmdKbitsdk5vZUNpekErc2UvOUpob0R2Qkw0?=
 =?utf-8?B?WlpMUGZCMVRra0tRV2N3MktXbUl6aGQ3K2lDSVQ2L1ltZE9RMzQzMWlIekk1?=
 =?utf-8?B?V05OMm5hZk85d0g0ejNqVjVYcEtRZXY5YWVSZEZsalIrUkFXWmVmSmRjMjd2?=
 =?utf-8?B?NEs5N3hGVmZJK2xtYTBGcHYzVlBqaHAyUmJJWHVMMmZ4MTEzM2lhWTJ6N1Fm?=
 =?utf-8?B?R1Ava0x3bUpVb0NyWDdzNTdjemxXTDc4MEpNVUYzT251UUxHOWtTMWhiUEx0?=
 =?utf-8?B?Qk85TWhmNEFPUVBVTEFkZEFlK2h4OVVDRXU3ZHZVRUZlKzZ2dmRNZzBTVEg3?=
 =?utf-8?B?ZTFRV1diL0xiVjFHeXRWWGd6N1ViczhSUEQwbFpXM3dSWW5POHRGenhRWUsx?=
 =?utf-8?B?cFBGY1drQVhRMmRzMkhmS3hZekhDbFZqYUdnQ0djLytJcEc4TkxPZTE5dDU1?=
 =?utf-8?B?QW1qUmNoZTRlR0dpb0EzUVFjYUlacEdkN3pyTC9yOE94MWZ3ZEVtSUc2ZUZi?=
 =?utf-8?B?SUd4TUJvREZkWmRKUWg3aXczbUpwZDhrUHlQUytxUVowVUJlMFY5Qld3Ynlr?=
 =?utf-8?B?ZUYwdlJyMUFybGk1Mm1TVnlQWnN1aityQTk1NUl2Q1BGZGxTcFJsRmxjNFRm?=
 =?utf-8?B?ZUU2ZkkzVHZ3bGVWVThzY3RQN2k0T2s4VTBYaUhPOWVJSFJPbDByT1dpaW41?=
 =?utf-8?B?YmhIemoyaGptaWtGcm5lZjAzb3RzNU5xaGl1aXhuSDhPVUhaL1R2VEJmNkU2?=
 =?utf-8?B?RUFOOHJPK25Ud0lFbkFPM1hvWTNvcWhoT2RWVUpNMGFXZENFT04venNsZ2hD?=
 =?utf-8?B?R2NqSXBDejF0c3Qyc0cyTjU4UGZiajBwMnppb0RGRzg1NnVrYSttVms3ZEN1?=
 =?utf-8?B?Y0lYMWZjN3ZnRUNIejU3TG4xR0s0Z2YzaFNZMGsvZWxmWXI0bmZWbmFWMDZ3?=
 =?utf-8?B?SmZjb2Q4cGkvMFJrUkhoUVJXZFgxV3dHL3Izc3N0MjRiNjRGZDZXNFlxbkl4?=
 =?utf-8?B?bHpmYTJkaHVhb1BMNmQrSzBROHRPblpxNGc5UGxDK29saUNIRzhJNUYvZWU5?=
 =?utf-8?B?eUNZOXEwZEozL3E0Rm9xajZnMmxCUG93RmNlNUVLM0dtamR1OVg5THRKQlhu?=
 =?utf-8?B?YVRrem14L3FZbEZoejhhZWNFRmhUN05kSmY0M1YvaXd0MUJlNmpUWEpJVGxL?=
 =?utf-8?Q?vSmDje1MTvjy62R0=3D?=
X-Exchange-RoutingPolicyChecked: ZqzXzD4oo+tSCUdQ9iM+66k9pV8TmnTqUb+X2/ZqJw9oOOTS9RXDZ8bDew1hpvrXW1mHXUBWoFcIExOIP2i98OEduMkDP0ET+u46oqiCXjGxrfX6/8U7p0YjoyBHYNw0MaX2cHPkXesBrsxQ1D4JVoGicSBM+PNiZdlU+VJCNIqv5U+Hf1dROlKhGPt9UVC8PRqfuD7Uby+Q/lHEwuLbHaYYi6fogUyBveI1tdSFmL60GpXdrp8comvz4gbnyBOg1XtP/TdDVXqoSVKCEPGbFpUbOWrc8DxAxWXgeE4/hodz3EBLsRm8zwVwSk5qG7FooZQRhGkFl7IHLnw1RAtoxQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: cea3a583-77e1-408b-5e76-08df1668a04c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2993.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2026 16:11:13.3803 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8aBq6kwKlW7gKylXoPfZMDS/Qk0yaROc8zgsHCRZgEqaXBBa5ysMTtDxlGlF3r4YN3pPClQ0hrBehFL6JgInQQ1MsaLnSX8kpjEMFU0kcbQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8444
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
> Use the new flow graph API and common flow engine infrastructure to
> implement flow parser for security filter. As a result, flow item checks
> have become more stringent:
>
> - Mask is now explicitly validated to not have unsupported items in it,
>    when previously they were ignored
> - Mask is also validated to mask src/dst addresses, as otherwise it is
>    inconsistent with rte_flow API
>
> Previously, security parser was a special case, now it is a first class
> citizen. All decryption SA tracking has been moved into the engine, as the
> engine is now the authoritative source of new Rx flows and the state of
> the Rx SA table (the Tx SA table is still up to IPsec code to manage).
>
> Because IPsec code does not manage the Rx SA table now, a synchronization
> mechanism is needed to prevent IPsec code from deallocating a security
> session when it is still referenced by security flows, so the security
> session is now atomically refcounted. For Tx, the refcount is effectively
> a noop, whereas for Rx it is now managed by rte_flow security engine.
>
> Signed-off-by: Anatoly Burakov<anatoly.burakov@intel.com>
> ---
<snip>
> +/**
> + * Ntuple security filter graph implementation
> + * Pattern: START -> IPV4 | IPV6 -> END
Previously, pattern support was not as restrictive. At least, we could 
have an Ethernet header in the pattern. With the current implementation, 
ipsec-secgw could fail, since it can create an ETH/IPV4/ESP/END pattern 
(please refer to flow_init_single() in ipsec-secgw).
> + */
> +
<snip>

-- 
Regards,
Vladimir

