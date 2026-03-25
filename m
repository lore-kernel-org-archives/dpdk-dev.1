Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56365109C035
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 15:56:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 92FEE402CE;
	Wed, 25 Mar 2026 16:56:19 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 9920B4028E
 for <dev@dpdk.org>; Wed, 25 Mar 2026 16:56:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774454177; x=1805990177;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=7FRgh1sBq+l3NzmVSsjpJtewojpqX50j2CzShRPodP4=;
 b=RDxSRNn/pH6gp+sCsbBgJC29OraBX5ihkv5PbSwjaPdzJlhEk3VZ2JNV
 /N5jr7mrjfKYxbWzQuQrK0E4Uc8ta0l6xCg+2y4PRXo0RjJNLmMZXr5Ev
 fHduc34M72lIh2rRJp1f6cF9zSw4COB5EUvHN0VXvnoN0IXU0oQ72Pd7E
 fR96mwNd7W5QeJ7zieQ/uUbmp1W/Kpoy+Q/fcFKyfLg5ktcgq0gpOFOa7
 qlGjoy5Q/TFKVaD2jDLpLvZLM05UztLWPBUqHdR+Ez4tK8Zlem9nM3GOi
 x/gvkdDckl+vp3aU5MLg0IFRX8y6BomOBcl5T/Epr/inPnB08t47x6Fwh Q==;
X-CSE-ConnectionGUID: eBzDeG2pQDS95i/Clyu4zw==
X-CSE-MsgGUID: jdJye4qORtitPZTao0YATQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="86872186"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; d="scan'208";a="86872186"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2026 08:56:16 -0700
X-CSE-ConnectionGUID: YwZXOjesStOmxzX9M6pMXg==
X-CSE-MsgGUID: m5e9Brm5RNquA9tb3rzGEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; d="scan'208";a="221832038"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2026 08:56:16 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Mar 2026 08:56:16 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 25 Mar 2026 08:56:16 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.63)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Mar 2026 08:56:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a4MJq50C1Bkl0SiFpRWulXGrkki1CavSH4c4gpON33EuvV8NRKrTImtHLQJMzp10KAoowhwJ6vboDe6IirYfhII+RPlGHFU7ZxrTnYy6jRKwu65nNbJKJUloVlgKg6Ty5nQWGgv4Syomy5it+GhMFXfqC7Ccp5qngppColOfIV8cjDfeEPxJ3uzOly1UlkSOIMBcAHg2ZOIbF8Ilj09wDlnYnuI3rjJJH/gVR13MfQsG/nvvQH4tpi4Em90cvsWrZs7+/EHz8f4pzPV6b7rjr1Gu/4CAGJutiuBu7iKVUMy6vT/5TYohXQcc8zgiy/bXwZYotbt8Ft0rN0iSe7HUMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tHirgvmJZQCz9iNDQlr86rjbL1PUZmHABoIVHiVXibs=;
 b=Pa9saOMVJw7jYmiZnCe4kcy09SJWYl4RCupPRz8i9tfGDX5Sbg17mXqySQe7VvLyox0pQM0h025o/8H//v24tUP333pdWamTKJxAU8QyJo3RuFwCd1Fm/49RBUy7OqB1jzl7e2OUZyvxjDqc2Dz22dgUf49e4/ZnYw4hIsup/YE5CVgRuie2vdhWb0FE8CVnQ8bqkNxhtu+WQZ0iZBjuh9MpI1NlFd7YBdlpgpKJtsoReg6Rp+b2a2dXbAHIH7x2QPpafRoil6MR3SPUTnQVjIQxRUoPK28HZzhqo4g9/RPdIqAr3jy/HbdszeFdDsfxgeCPtnZ1ayU5+GMtL3uv9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16)
 by SJ5PPF7371775FE.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::834) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 15:56:13 +0000
Received: from IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2]) by IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2%5]) with mapi id 15.20.9745.007; Wed, 25 Mar 2026
 15:56:12 +0000
Message-ID: <a3a95872-2cc7-4b9d-ae70-179050339bd8@intel.com>
Date: Wed, 25 Mar 2026 15:56:09 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] VRF support in FIB library
To: Maxime Leroy <maxime@leroys.fr>
CC: <dev@dpdk.org>, <rjarry@redhat.com>, <nsaxena16@gmail.com>,
 <mb@smartsharesystems.com>, <adwivedi@marvell.com>, <jerinjacobk@gmail.com>
References: <20260322154215.3686528-1-vladimir.medvedkin@intel.com>
 <CAHHRULVmnHih3BqoCnMv-FEj=aC3LehgCFaVhh=0eQ-SLsovXg@mail.gmail.com>
 <22bebf4a-3801-45e9-8ac5-726cb6c89721@intel.com>
 <CAHHRULVvLpFpwA-Z8KMuCKmdM24OCeZDrzEMEMs88h2-iqapXw@mail.gmail.com>
 <d944f17d-35a7-42d3-9011-2d368f530474@intel.com>
 <CAHHRULXCfeFrgTosCJCvMK0+Qe-eBy2bJs43KDvEwYC6A6GRCg@mail.gmail.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <CAHHRULXCfeFrgTosCJCvMK0+Qe-eBy2bJs43KDvEwYC6A6GRCg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0053.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::11) To IA4PR11MB9204.namprd11.prod.outlook.com
 (2603:10b6:208:56d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9204:EE_|SJ5PPF7371775FE:EE_
X-MS-Office365-Filtering-Correlation-Id: c7cf9dd0-ce1a-4dc0-6335-08de8a870a0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: s3/XhKjZu+3oK+zcip5EdQTN/YB/wXEHa2tKJ6RELDe1SEQHUwJuMSchF9VufH/iwV0/nkMKYJk2zHgKIhevadtzE+Xx8Nn/1nWbu1Fjj6Q+tNqBXuFft22mtZaImIniWdSKsImeBqf17MXyFtSebdbSU7GLpb6VCUQsGY3x3jZzii75pmBrZKjmFE/MUP2p0SgA54ZryequWxfvnUlCQdgArsfIMNrWY1lOV3z9m7iZS7FK+b1ypO+geAVneeB8ZBiVQB+6mblKkUNYcvS5904MQrMwK0tgFhgdWvTD9E+4SRtPRRpj0nEnlwbuY/pfGQhH7kLBT2eHhTHN1GmLWiYu6HN1NlXSg3C+XMuV22Agaa5zpRnPvWlf1ozvQr3y1AHpWjDZT1JooVAFuEimgDyPdnsuSDo6fUEFbwhy9TAiddFonBYPg6p3P8v7tWvFu5mFfHee5uGp+n/YunilM35fJew64IErk5VpdfWkwnv7LMMh/x/qtZi7jFCgxnBE1woiCYOVb0U53tKD+aI+n6ru6N3gpzL1rsnfvUidEo+E9pRiiQAEA77kZTuQ5kmgyzGUIpcwDwWBMJFjzpKCi5iy1tpuD8dFW1iTUD6PXwM0LTpqjUmuoD2MEh/KRZU6fIDu9cKu9+DrUEwsMvh8ByI4HiwJ3ToVINnkudDXAL3EivIfr1JuK9W1gK977o3UAigdCRBiw+vPuB4TIvruJ03lzy+AHc/K0Zxq/nLWV6w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9204.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1d0Y0xPUDhqYnRmR2owWG1lbFZmU0YvYk4rcjQ0SitiNFNtWmltS0dwUjZD?=
 =?utf-8?B?UldDRXZ4SC94bTVLRGsrYW9iWFczNEpsOHhGVjB6b3FlMFBCR3A3a1ZPVG9X?=
 =?utf-8?B?SE9Ebk82WWRJem1paEpGcmRubTRtS2VtMWN1b0wrRDFYVzhNdXRZb2kyaU1p?=
 =?utf-8?B?OVZKSUNuR3pqY01SZ0F4bU5URkU2VFU4WkQ5NUdxNU9rOTNHbXRzUVlXS3o5?=
 =?utf-8?B?S1dKY2xVZWhCUDJvZys0OGdma3ZZeHRkYnFlT0ZrTXV2cjkxeHJKbFdHWEFn?=
 =?utf-8?B?RlZZNGR6RW1xelk0TG5WQjR0YjFwV3VYNjcvZ2cvMFRseGtsYnlzcDlsSlBm?=
 =?utf-8?B?bFd1VXczSVAwVjU2TUh3Tk9WSVBNZDVSVWJvVHZHRUw5NUlCK3h3eUhwN2tv?=
 =?utf-8?B?UldoYkRheDJzR1RWK3NWNk0xQnR4bU82bTZ5SkhCOXdzRDJaWllPVDBFMzNq?=
 =?utf-8?B?bmNQKzBscXBRbWZpM2VvYTVkbzNucWIvRFNpNDlQQXFubEVHTEtaWVI4SzE4?=
 =?utf-8?B?R2pPQmt5ZmlmV3lEellWMStHSzRaRE1JTTdKTjdXdVRhRDF6dFBITWZXeTBO?=
 =?utf-8?B?SWR5WUtEN2ZWMHZDdHNlZW52clpwU2NFd3R4RndIb2lSWFpmSmVqVlNXbnN3?=
 =?utf-8?B?SVgvaGs3NWNmVC9sWFV4dVFyOUptcDErWjBQcmJzVUNnV1RSdEFyZUU1NS9C?=
 =?utf-8?B?b3JFS1RtVHpxKzBFNVc2aWpDNTl2S3NSeDlFcVlTQllDT2IvMmJ4S3pMZEs5?=
 =?utf-8?B?Y2Fuazh1ckxicWhGK3RuUm9TUkZ3M1pidG1TbE1CRGRkYm9RWEtLY0o4VnRw?=
 =?utf-8?B?Q1B5ekl2ZUdPZVZRclNVb1A2OTlaaHdlNVVRdmlXQUZCdm02S2twOFNpQkdr?=
 =?utf-8?B?NDMwNm1TSU9HaVBrRHRHTnY3V0ladlU2MWE1aU81YXk4bkJGSjNVc3ZWSk9z?=
 =?utf-8?B?LzR5M0RjS1BGKzhXT1AxdkxwcllGZHNaQWJYR1hsTUYzVzRNdWs3T1pSVmtR?=
 =?utf-8?B?WDEzcWY1ZTI3MFZnY2FlRmordkNaVERZUDB1aWJWV1RrMnNJRnhWcUoxTWVD?=
 =?utf-8?B?TFBGMlZYbnlNcVZZdnNDR0Y5cldleXpMbkkzM1BaNWx1Lzc3Zyt5TnpQMVlk?=
 =?utf-8?B?MjVHTUJoRlZnbWJZU3JsRkFBV3ZoT2NjK0tBbW9iUHowaHBWM3VoWDZDdVo3?=
 =?utf-8?B?TVJGd0hpV1YranhoT0d5NzQxV2hSSXd6SU43WUlUTTRJM0UrWElHWHVsVmoy?=
 =?utf-8?B?Zk00M3IxMkRuWlp2eTBzZ0pCU01uMElTVmM4aG8xRVprUTdIMjU4Yk5JVHJa?=
 =?utf-8?B?dURNa2IrbUhjTDU2aUZFV0tXM25kRDNnSmRIYUhmTEpvbGNWZmhiTEpjaEdG?=
 =?utf-8?B?VEtNOElqMzdCcUZqaU5RSUN2dWpGeVZqZVNQK3dmMDFoVFJjZjhLU09NZGVz?=
 =?utf-8?B?ZHhZdXZNQkpscFlTeVBxQU0rcTRkcFh4aSs2dm9MSnh3c2o1eU05TVJ1Y0hO?=
 =?utf-8?B?ZTR1WVg4LzRTeldvWmk1ZGZtdUxqOEJpalZnZWpheXh6QkVmU3lhelR1dmhR?=
 =?utf-8?B?dVl3Q3YxK1l0bTJMM3JueUxrNms1ekdaZENkOFA5SUdYcXhpSzlCZk05T2Vy?=
 =?utf-8?B?Yno2THFLVVhNVHJUM2J0TDc4RVAxL0VHUXphemVQWDA0NzFic2xMUXVwMlhp?=
 =?utf-8?B?UVU3VURtemJQeWlEeGFuTFFJTHR0bEljUUdOaDVCVGxMaVYyZDFmaStaUDJY?=
 =?utf-8?B?VzJ3Mlg5ck9ZQ1lDZGNNbXh3M3RtV2V0WHJ5WTJqelpoOTBTazN3K0lrcWQ5?=
 =?utf-8?B?RVg0Y3E4UUc5RHF5cW5xMG91QjFFQ3I0RzR1WEtzVWdsZGpLMVFWSWNRWXd2?=
 =?utf-8?B?ZWVIVVpodmVMMVI3Vm8ydm5ac1A4SDNVdk5oVnRFSWUxc3JNN2p2aGhkK0Jt?=
 =?utf-8?B?Nm4vRHA0STZ0VjJzZHEwdlE1NXZDY3pIUjhPRjE0ZEZoMVR0U1B0TXFyK1dm?=
 =?utf-8?B?Nkc5bVl2bmRLcXJnK2dhcHd0QmF4U0Z3WnM5azU1M0NCQ0xBTzhIZlVOY1Iw?=
 =?utf-8?B?clFrWmNMM0pGbitBbmE5NkxFdExKU21oamREMFlZS2lVSWF2Q2RqRzFSZnlE?=
 =?utf-8?B?b0gxT1VKQThoei81RG5ERGZvRjhPNlRvYVpvdVF5WWF3Y29veXc3YmRsSDhl?=
 =?utf-8?B?V28wM2FhSCs5bXpsL1p3cXpSbHJ6TjdKa2xSTGdTcWpIYjdxWVZheklwVGQy?=
 =?utf-8?B?NDh3aWpTdmF4cTBKSXEzL2ZmTTZRRmtNZTUvRkFER1ZnN1FQK3N4a2drRXpU?=
 =?utf-8?B?Q0dIN0xrVFh3dG1NcWJhd3hqQkNLWXQ2Qmd5aXFGQ3FTVDBPZXJxQmFBTHNl?=
 =?utf-8?Q?Vk+UzUOmWvn/uHwo=3D?=
X-Exchange-RoutingPolicyChecked: kDUeuz6LmUwdlscBvFjcA1uy47SToHb4+GokW2mBNF2afA2wmpacFLgsQhH6LK7LzCP1z4YkucM4L556SjT34xtKMCScCud1CRKRhQBx1/INGTxCI96/bfMAVp0E4opHRioQhjTIm6knKJ0OoiRMGELbP1uX1zxl6d8rzoo0FX8jrY/ibn7jObeaSAa27KZmi5yBz9l9zjyphcipi1QzkeMU/Y1B0AtST9fy0MdLY/HVoIwp/sxuir/GP+pVnj2ljcqg0fEOyvFBWsn4o/RfsInaLmGyF15bkqFf0aanmGutxY0OARRMuYfqqVcf/KWeoUG92twodEbV9WY2IrD/Rw==
X-MS-Exchange-CrossTenant-Network-Message-Id: c7cf9dd0-ce1a-4dc0-6335-08de8a870a0a
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9204.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 15:56:12.8282 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LEma9a03L5k5lgdzfHg3YcnwlQvWZY2AIhc9KPOfQLwW/zFusCIQtIP4EcJ3DNejjjNoZ8y+z68ZOiDq89SmBe26wBkBmH0Y/XUwOJSiyhs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF7371775FE
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


On 3/24/2026 9:19 AM, Maxime Leroy wrote:
> Hi Vladimir,
>
> On Mon, Mar 23, 2026 at 7:46 PM Medvedkin, Vladimir
> <vladimir.medvedkin@intel.com> wrote:
>>
>> On 3/23/2026 2:53 PM, Maxime Leroy wrote:
>>> On Mon, Mar 23, 2026 at 1:49 PM Medvedkin, Vladimir
>>> <vladimir.medvedkin@intel.com> wrote:
>>>> Hi Maxime,
>>>>
>>>> On 3/23/2026 11:27 AM, Maxime Leroy wrote:
>>>>>     Hi Vladimir,
>>>>>
>>>>>
>>>>> On Sun, Mar 22, 2026 at 4:42 PM Vladimir Medvedkin
>>>>> <vladimir.medvedkin@intel.com> wrote:
>>>>>> This series adds multi-VRF support to both IPv4 and IPv6 FIB paths by
>>>>>> allowing a single FIB instance to host multiple isolated routing domains.
>>>>>>
>>>>>> Currently FIB instance represents one routing instance. For workloads that
>>>>>> need multiple VRFs, the only option is to create multiple FIB objects. In a
>>>>>> burst oriented datapath, packets in the same batch can belong to different VRFs, so
>>>>>> the application either does per-packet lookup in different FIB instances or
>>>>>> regroups packets by VRF before lookup. Both approaches are expensive.
>>>>>>
>>>>>> To remove that cost, this series keeps all VRFs inside one FIB instance and
>>>>>> extends lookup input with per-packet VRF IDs.
>>>>>>
>>>>>> The design follows the existing fast-path structure for both families. IPv4 and
>>>>>> IPv6 use multi-ary trees with a 2^24 associativity on a first level (tbl24). The
>>>>>> first-level table scales per configured VRF. This increases memory usage, but
>>>>>> keeps performance and lookup complexity on par with non-VRF implementation.
>>>>>>
>>>>> Thanks for the RFC. Some thoughts below.
>>>>>
>>>>> Memory cost: the flat TBL24 replicates the entire table for every VRF
>>>>> (num_vrfs * 2^24 * nh_size). With 256 VRFs and 8B nexthops that is
>>>>> 32 GB for TBL24 alone. In grout we support up to 256 VRFs allocated
>>>>> on demand -- this approach forces the full cost upfront even if most
>>>>> VRFs are empty.
>>>> Yes, increased memory consumption is the
>>>> trade-off.WemakethischoiceinDPDKquite often,such as pre-allocatedmbufs,
>>>> mempoolsand many other stuff allocated in advance to gain performance.
>>>> For FIB, I chose to replicate TBL24 per VRF for this same reason.
>>>>
>>>> And, as Morten mentioned earlier, if memory is the priority, a table
>>>> instance per VRF allocated on-demand is still supported.
>>>>
>>>> The high memory cost stems from TBL24's design: for IPv4, it was
>>>> justified by the BGP filtering convention (no prefixes more specific
>>>> than /24 in BGPv4 full view), ensuring most lookups hit with just one
>>>> random memory access. For IPv6, we should likely switch to a 16-bit TRIE
>>>> scheme on all layers. For IPv4, alternative algorithms with smaller
>>>> footprints (like DXR or DIR16-8-8, as used in VPP) may be worth
>>>> exploring if BGP full view is not required for those VRFs.
>>>>
>>>>> Per-packet VRF lookup: Rx bursts come from one port, thus one VRF.
>>>>> Mixed-VRF bulk lookups do not occur in practice. The three AVX512
>>>>> code paths add complexity for a scenario that does not exist, at
>>>>> least for a classic router. Am I missing a use-case?
>>>> That's not true, you're missing out on a lot of established core use
>>>> cases that are at least 2 decades old:
>>>>
>>>> - VLAN subinterface abstraction. Each subinterface may belong to a
>>>> separate VRF
>>>>
>>>> - MPLS VPN
>>>>
>>>> - Policy based routing
>>>>
>>> Fair point on VLAN subinterfaces and MPLS VPN. SRv6 L3VPN (End.DT4/
>>> End.DT6) also fits that pattern after decap.
>>>
>>> I agree DPDK often pre-allocates for performance, but I wonder if the
>>> flat TBL24 actually helps here. Each VRF's working set is spread
>>> 128 MB apart in the flat table. Would regrouping packets by VRF and
>>> doing one bulk lookup per VRF with separate contiguous TBL24s be
>>> more cache-friendly than a single mixed-VRF gather? Do you have
>>> benchmarks comparing the two approaches?
>> It depends. Generally, if we assume that we are working with wide
>> internet traffic, then even for a single VRF we most likely will miss
>> the cache for TLB24, thus, regardless of the size of the tbl24, each
>> memory access will be performed directly to DRAM.
> If the lookup is DRAM-bound anyway, then the 10 cycles/addr cost
> is dominated by memory latency, not CPU. The CPU cost of a bucket
> sort on 32-64 packets is negligible next to a DRAM access (~80-100
> ns per cache miss).
memory accesses are independent and executed in parallel in the CPU 
pipeline
>   That actually makes the case for regroup +
> per-VRF lookup: the regrouping is pure CPU work hidden behind
> memory stalls,
regrouping must be performed before memory accesses, so it cannot be 
amortized in between of memory reads
>   and each per-VRF bulk lookup hits a contiguous
> TBL24 instead of scattering across 128 MB-apart VRF regions.

why is a contiguous 128Mb single-VRF TBL24 OK for you, but bigger 
contiguous multi-VRF TBL24 is not OK in the context of lookup (here we 
are talking about lookup, omitting the problem of memory consumption on 
init)?
In both of these cases, memory access behaves the same way within a 
single batch of packets during lookup, i.e. the first hit is likely a 
cache miss, regardless of whether we are dealing with one or more VRFs, 
it will not maintain TBL24 in L3$ in any way in a real dataplane app.

>
>> And if the addresses are localized (i.e. most traffic is internal), then
>> having multiple TBL24 won'tmake the situationmuchworse.
>>
> With localized traffic, regrouping by VRF + per-VRF lookup on
> contiguous TBL24s would benefit from cache locality,

why so? There will be no differences within a single batch with a 
reasonable size (for example 64), because within the lookup session, no 
matter with or without regrouping, temporal cache locality will be the same.

Let't look at it from a different angle. Is it 
worthregroupingipaddressesby/8(i.e. 8 MSBs)withthe 
currentimplementationof a singleVRFFIB?

>   while the
> flat multi-VRF table spreads hot entries 128 MB apart. The flat
> approach may actually be worse in that scenario
>
>> I don't have any benchmarks for regrouping, however I have 2 things to
>> consider:
>>
>> 1. lookup is relatively fast (for IPv4 it is about 10 cycles per
>> address, and I don't really want to slow it down)
>>
>> 2. incoming addresses and their corresponding VRFs are not controlled by
>> "us", so this is a random set. Regrouping effectively is sorting. I'm
>> not really happy to have nlogn complexity on a fast path :)
> Without benchmarks, we do not know whether the flat approach is
> actually faster than regroup + per-VRF lookup.
feel free to share benchmark results. The only thing you need to add is 
the packets regrouping logic, and then use separate single-VRF FIB 
instances.
>>> On the memory trade-off and VRF ID mapping: the API uses vrf_id as
>>> a direct index (0 to max_vrfs-1). With 256 VRFs and 8B nexthops,
>>> TBL24 alone costs 32 GB for IPv4 and 32 GB for IPv6 -- 64 GB total
>>> at startup. In grout, VRF IDs are interface IDs that can be any
>>> uint16_t, so we would also need to maintain a mapping between our
>>> VRF IDs and FIB slot indices.
>> of course, this is an application responsibility. In FIB VRFs are in
>> continuous range.
>>>    We would need to introduce a max_vrfs
>>> limit, which forces a bad trade-off: either set it low (e.g. 16)
>>> and limit deployments, or set it high (e.g. 256) and pay 64 GB at
>>> startup even with a single VRF. With separate FIB instances per VRF,
>>> we only allocate what we use.
>> Yes, I understand this. In the end, if the user wants to use 256 VRFs,
>> the amount of memory footprint will be at least 64Gb anyway.
> The difference is when the memory is committed.
yes, this's the only difference. It all comes down to the static vs 
dynamic memory allocation problem. And each of these approaches is good 
for solving a specific task. For the task of creating a new VRF, what is 
more preferable - to fail on init or runtime?
>   With separate FIB
> instances per VRF, you allocate 128 MB only when a VRF is actually
> created at runtime. With the flat multi-VRF approach, you pay
> max_vrfs * 128 MB at startup, even if only one VRF is active.
>
> On top of that, the API uses vrf_id as a direct index (0 to
> max_vrfs-1). As Stephen noted, there are multiple ways to model
> VRFs. Depending on the networking stack, VRFs are identified by
> ifindex (Linux l3mdev), by name (Cisco, Juniper), or by some
> other scheme. This means the application must maintain a mapping
> between its own VRF representation and the FIB slot indices, and
> choose max_vrfs upfront. What is the benefit of this flat
> multi-VRF FIB if the application still needs to manage a
> translation layer and pre-commit memory for VRFs that may never
> exist?
This is the control plane task.
>
>> As a trade-off for a bad trade-off ;) I can suggest to allocate it in
>> chunks. Let's say you are starting with 16 VRFs, and during runtime, if
>> the user wants to increase the number of VRFs above this limit, you can
>> allocate another 16xVRF FIB. Then, of course, you need to split
>> addresses into 2 bursts each for each FIB handle.
> But then we are back to regrouping packets -- just by chunk of
> VRFs instead of by individual VRF. If we have to sort the burst
> anyway, what does the flat multi-VRF table buy us?
>
>>>>> I am not too familiar with DPDK FIB internals, but would it be
>>>>> possible to keep a separate TBL24 per VRF and only share the TBL8
>>>>> pool?
>>>> it is how it is implemented right now with one note - TBL24 are pre
>>>> allocated.
>>>>> Something like pre-allocating an array of max_vrfs TBL24
>>>>> pointers, allocating each TBL24 on demand at VRF add time,
>>>> and you suggesting to allocate TBL24 on demand by adding an extra
>>>> indirection layer. Thiswill leadtolowerperformance,whichIwouldliketo avoid.
>>>>>     and
>>>>> having them all point into a shared TBL8 pool. The TBL8 index in
>>>>> TBL24 entries seems to already be global, so would that work without
>>>>> encoding changes?
>>>>>
>>>>> Going further: could the same idea extend to IPv6? The dir24_8 and
>>>>> trie seem to use the same TBL8 block format (256 entries, same
>>>>> (nh << 1) | ext_bit encoding, same size). Would unifying the TBL8
>>>>> allocator allow a single pool shared across IPv4, IPv6, and all
>>>>> VRFs? That could be a bigger win for /32-heavy and /128-heavy tables
>>>>> and maybe a good first step before multi-VRF.
>>>> So, you are suggesting merging IPv4 and IPv6 into a single unified FIB?
>>>> I'm not sure how this can be a bigger win, could you please elaborate
>>>> more on this?
>>> On the IPv4/IPv6 TBL8 pool: I was not suggesting merging FIBs, just
>>> sharing the TBL8 block allocator between separate FIB instances.
>>> This is possible since dir24_8 and trie use the same TBL8 block
>>> format (256 entries, same encoding, same size).
>>>
>>> Would it be possible to pass a shared TBL8 pool at rte_fib_create()
>>> time? Each FIB keeps its own TBL24 and RIB, but TBL8 is shared
>>> across all FIBs and potentially across IPv4/IPv6. Users would no
>>> longer have to guess num_tbl8 per FIB.
>> Yes, this is possible. However, this will significantly complicate the
>> work with the library, solving a not so big problem.
> Your series already shares TBL8 across all VRFs within a single
> FIB -- that part is useful, and it does not require the flat
> multi-VRF TBL24.
>
> In grout, routes arrive from FRR (BGP, OSPF, etc.) at runtime.
> We cannot predict TBL8 usage per VRF in advance
and you don't need it (knowing per-VRF consumption) now. If I understood 
your request here properly, do you want to share TBL8 between ipv4 and 
ipv6 FIBs? I don't think this is a good idea at all. At least because 
this is a good idea to split them in case if one AF consumes (because of 
attack/bogus CP) all TBL8, another AF remains intact.
>   -- it depends on
> prefix length distribution which varies per VRF and changes over
> time. No production LPM (Linux kernel, JunOS, IOS) asks the
> operator to size these structures per routing table upfront.

- they are using different lpm algorithms
- you use these facilities, developers properly tuned them. FIB is a low 
level library, it cannot be used without any knowledge, it will not 
solve all the problems with a single red button "make it work, don't do 
any bugs"
P.S. how do you know how JunOS  /IOS implements their LPMs? ;)

> Today we do not even have TBL8 usage stats (Robin's series
> addresses that)
I will tryto findtimetoreviewthispatchinthe nearfuture
> , and there is no way to resize a FIB without
> destroying and recreating it.
>
> Could you share performance numbers comparing the flat multi-VRF
> lookup against regroup + per-VRF lookup?
>
>>>>> Regards,
>>>>>
>>>>> Maxime Leroy
>>>>>
>>>>>> Vladimir Medvedkin (4):
>>>>>>      fib: add multi-VRF support
>>>>>>      fib: add VRF functional and unit tests
>>>>>>      fib6: add multi-VRF support
>>>>>>      fib6: add VRF functional and unit tests
>>>>>>
>>>>>>     app/test-fib/main.c      | 257 ++++++++++++++++++++++--
>>>>>>     app/test/test_fib.c      | 298 +++++++++++++++++++++++++++
>>>>>>     app/test/test_fib6.c     | 319 ++++++++++++++++++++++++++++-
>>>>>>     lib/fib/dir24_8.c        | 241 ++++++++++++++++------
>>>>>>     lib/fib/dir24_8.h        | 255 ++++++++++++++++--------
>>>>>>     lib/fib/dir24_8_avx512.c | 420 +++++++++++++++++++++++++++++++--------
>>>>>>     lib/fib/dir24_8_avx512.h |  80 +++++++-
>>>>>>     lib/fib/rte_fib.c        | 158 ++++++++++++---
>>>>>>     lib/fib/rte_fib.h        |  94 ++++++++-
>>>>>>     lib/fib/rte_fib6.c       | 166 +++++++++++++---
>>>>>>     lib/fib/rte_fib6.h       |  88 +++++++-
>>>>>>     lib/fib/trie.c           | 158 +++++++++++----
>>>>>>     lib/fib/trie.h           |  51 +++--
>>>>>>     lib/fib/trie_avx512.c    | 225 +++++++++++++++++++--
>>>>>>     lib/fib/trie_avx512.h    |  39 +++-
>>>>>>     15 files changed, 2453 insertions(+), 396 deletions(-)
>>>>>>
>>>>>> --
>>>>>> 2.43.0
>>>>>>
>>>> --
>>>> Regards,
>>>> Vladimir
>>>>
>> --
>> Regards,
>> Vladimir
>>
> Regards,
>
> Maxime

-- 
Regards,
Vladimir

