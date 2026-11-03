Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622E6606A324
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 17:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Xol+iqa4
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 15FB940265;
	Tue,  3 Nov 2026 18:25:04 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTPS id EB947400D6
 for <dev@dpdk.org>; Tue,  3 Nov 2026 18:25:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793726703; x=1825262703;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=2RRQ+iZE4UmMQ6luVyVcurFAWpXt6Xyj0+X5c1dzrkQ=;
 b=Xol+iqa4/Sv88hQUGB6nD2gZDbM1LygCZTx0SLeKZ5PO2NLooHjGMDmL
 p5EujdzrRtLc6aYlo59gDUqGl6w7/g6UNms2HKhjG0CXdAYeC8sS36YbX
 3MNOTkgbyKGP+MO8sIkFkI+GkhGNGXbZ53aY8ctWazsANH4rCPBvLXpWH
 0sEuZ/Sh0lGZR0A56jN+sCbngvPcn8MgtJ6LTKWnqGraXktlTLc32vkv0
 VOJFtypwfLi1MjvZicWPWOicq0obrh7TuNxzcz5v1hxZWX1uAkPtcux5i
 /8njTxpla31LBGxCD7iu9eLuVSpQvMk5LwGnbuVoh3Ixe4DnYT9WJiuRL g==;
X-CSE-ConnectionGUID: M7sFS04lQOusi9zElaoS3g==
X-CSE-MsgGUID: VClBlp0kRwKLXMDH85jc5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2491040"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2491040"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 09:25:00 -0800
X-CSE-ConnectionGUID: Guo8rsCkQmeLYLVLnxpn3w==
X-CSE-MsgGUID: JuHIB+L5SkKXRZohKAoNxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6594809"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 09:25:00 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 09:24:59 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 3 Nov 2026 09:24:59 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.31) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 09:24:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g0Z1HjomUIlDrCu1eriAEVKx0oEVDiXUxgjoSUnBGL9YNgjkZ9jt0rBFZ5kpiZb7YzkWSNl6mFTdAMqn81npsTUsZYHMNj1uOCc+L5XArbeNaVkWDQy68jOVgPaThTjX7Ak4eMoBue7uD8l8CjJbEO3deSN2eydr5gAHBSCaRpxWoNfH1PUBi2hcr9LuNR95b/2VsDVYdXM9y+w6fciUrtJi8V0T7Cv4kYc/QfnQa0BVBMnu1o92PtopgGJbdW+DhiL2dxUqnXy97Lv2s5DOGQFjoDn4Ocqh6MwTx+25jXmzoDutCyLIDkeLORsnz2Yg7cH0I3S5jiHBvzKcf0Tw5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2/ieGdOIZlvUPfLHnP18nLjhMw6ajOpNAzrhJ7XLdJg=;
 b=ZrB3dnV2yStu+Ezw14vDIA/TuaA53YXqDnfGC1rnb8AfzUQkg55XvL6F2Ms4TasV6xzlkVatTwMWngT9l+apeBhllkGfg9y918rooJZNmIgG2NusVjkC09rxHf7P61bhspyAZGgD/ZeBzcg35BNH58YRz7xRMVlnfRo/OXqiVQbfi2vVEdsm4KW0iwzSR6Zqdbo2UjERzlUrQdrQY9p5USEBex4jQcwYEw1/ZijYpL4cWa8q9vbt8pPtLO4FhHBPYA6aw/zBh7r4P3bdYOlCqZGdI3ek3lBamhAzV7Jqe+U4cNqOH3FUYjx7cYyio5zI5bgVBZPEWkJr6923l0p+nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9444.namprd11.prod.outlook.com (2603:10b6:208:563::22)
 by CH3PR11MB8187.namprd11.prod.outlook.com (2603:10b6:610:160::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 17:24:57 +0000
Received: from IA4PR11MB9444.namprd11.prod.outlook.com
 ([fe80::8b6d:87bf:4926:f0c1]) by IA4PR11MB9444.namprd11.prod.outlook.com
 ([fe80::8b6d:87bf:4926:f0c1%5]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 17:24:56 +0000
Message-ID: <374fbd82-3167-4e77-8571-3b4b8679b210@intel.com>
Date: Tue, 3 Nov 2026 17:24:53 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dpdk] fib,rib: implement full network order support for
 IPv4
To: Robin Jarry <rjarry@redhat.com>, <dev@dpdk.org>
References: <20260518083935.15173-3-rjarry@redhat.com>
 <1263b2cc-6fc6-4b85-b542-6764c2a66825@intel.com>
 <DM6DVTPQVKBJ.16GPH4JSTG0K2@redhat.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <DM6DVTPQVKBJ.16GPH4JSTG0K2@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0191.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::20) To IA4PR11MB9444.namprd11.prod.outlook.com
 (2603:10b6:208:563::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9444:EE_|CH3PR11MB8187:EE_
X-MS-Office365-Filtering-Correlation-Id: 89eb1538-8b52-43ab-ad1f-08df39cf6172
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|261022115727099003|261021123027099003|261022113327099003|4143699003|11063799006|56012099006|261009223027099003|261022105027099003|261022075727099003|261102123227099003|261021121427099003|261021135927099003|261021130227099003|261026140227099003|261028144727099003|261026121527099003|261026130827099003|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: lQoX6lZ8IqH5lTb68D/jTIlTc05yYVxs0ej+IochmGhO0oZ54O238uNW8NR/m2zLbSUwip+3KikqGN0U0MnCJ9LPtZKaBFliMH/Tokabd85KVUobD5Akj9VBo8xvIaXFrBs4RiCj6KWsxiCAHQlvn3g6m3SK3K237MFwRBf3zL53nJ4TDTAWP2sH8VHgJIZQu200yTQukBPciScapUK4f7DOoiWjAK55p17Y2pmUbQHkJ5lvEh+JXgIiltRr6HnwuilXwLQ/+HlTvLMMDCI5wW1l+vh6vQ40MMpv6+7SiwWEneiBQFkBrh0dQA7z4A5FzIKsQB0jTEuIu91AsFYt1TqsF099OVM4wG9lXmAmPMmvIuSmN4I+Kr49lNZeaRMvYIkFGfJ799D6aKQL9MxXxwsG4L+movw23/lEY5kpX2skUxBKjoRKAxzC/mitf19qgri//Is677QrjgPx+jcqj2g/MZUa716kTf3Z6FxmxH3nmRFYIDsWkB4/lAESEFjXnC04c5QdOHQ7Me+1k4PRtQNu6VeWj6ve6Xb2EYrIv2HVJ07gatxRZx1I7+b0ExSQsWdf6XhM+6Mcqt5dbHnBfH/bTIjWJaBTiy2jMsyRehDnxM/TOTpShFPBMRCZug2WzqigWtQ1xmRagZhX57/pgQrSxNUKaqsrtmwNEFS3fvk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9444.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(261022115727099003)(261021123027099003)(261022113327099003)(4143699003)(11063799006)(56012099006)(261009223027099003)(261022105027099003)(261022075727099003)(261102123227099003)(261021121427099003)(261021135927099003)(261021130227099003)(261026140227099003)(261028144727099003)(261026121527099003)(261026130827099003)(10067099003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3doNDJwZzFsUnNlRnM5U1oyL3dUckpiVHcvdzNzMVRPazN2RmNMSFhwS0hy?=
 =?utf-8?B?M3JCMzhnWHdQdDJ2Z1Q3bXZBbjRVVXlzMm1zYnlUTUtCMWE0UVJieEdkaUlY?=
 =?utf-8?B?TXY4N25OSFgwL01CREtlK1g1dlBjenVwbUdlNUxKMHZtckZuZVhscVNjMGJh?=
 =?utf-8?B?UzZVOWN2QXRjZEMrZkpXeWlOQXBOU1FDakxWb0IvWnJ5Mmpic0RQQW9Qakps?=
 =?utf-8?B?Z3Vhc1M4V2tjamRyWStWODNXS3lwWXI4QjNLTTVHd0ZMRXlsb1J4TW1RUFp1?=
 =?utf-8?B?VTlld3JhU0YxbE0weEd2RVZ4a0tKOHY3cVFKcUt3MHN3NUdMVkxkeWZhaEhX?=
 =?utf-8?B?SVJkbDB4dlYrRnBiWW5xa3cvMmZjVm9uWGJscmVDckxLaGRJNlJ1RU5KTFpz?=
 =?utf-8?B?UC9aZXVRWXowc28ybXYyeVlWSFFMVWYrWFFHSGxKck5HcHNmY1ZiVE40cnA2?=
 =?utf-8?B?Z3pOWHlXdExaMzhsUkVlMUc4blJuNXhiV2Zqdllyb0ptTTRueDNETmpqK0hl?=
 =?utf-8?B?Q1RvbUNIR2JPR1ppM0xrZlplOXk3WE9hQUNKSjlnQ3cwN2tHZUp0UjhTeldp?=
 =?utf-8?B?VGszbnhzMWpoQWtIVlFJSU9VRlZLK2JUbU5WbXpCM3U1SkttUmtyL09abUQ0?=
 =?utf-8?B?RXlLdnY3S0RlQUQwL2psUWZaZ0lJd3hlMEhYSGNGWFI5ZVJYckRSZkNyanpJ?=
 =?utf-8?B?QStyVTdsNkJPNW1qRzdBVEN6aTJ6K0dFdzY5VzlHN05ob1Q4bkdFakhTcTgx?=
 =?utf-8?B?ZUQwcWI4MVYxS1U5N3M5aVhSZGhBOFJQUENDdWFkNEJwdkVkS1pYdzQzUEFn?=
 =?utf-8?B?VGdZZGduM2dwdXU3NnlPVnFFM0VxVk1RNVIvTklmZVV3K1lUUi9vQlhCVlBJ?=
 =?utf-8?B?MFJPYU44cXdlemF3bCtEbys5aWxEMzVzQm9Na0l0eHdHYlRGNFpPWjIvMU5y?=
 =?utf-8?B?ZmZjTXJjWWovdlMrdUJhN2lPdW5YdEhSNU55cFJxOW5ITGhCUEpzbTBWMFpy?=
 =?utf-8?B?WVlIZ1RKYjVVcm5JaUJUOEg0YzlMOHdEK0d6QXl4Y2tpZzZkRm5GNGtVZUcw?=
 =?utf-8?B?YktxaGszakFrSmdiTlBnNWUrNkd2bjZQTWpoVWZHbmFJdGpEM3FPTG9EQVlS?=
 =?utf-8?B?dGxlYm9ZN0hpOC85UTBCUHB2M0tzSml5WWlNU3c5RVhqZWZacmRlYmxwbDMx?=
 =?utf-8?B?bVFPdVZPV3RvdlZIU0NXODh0cTIzZkxFRTkwb2dzNzZZYXlHYk9BTy9JWHRs?=
 =?utf-8?B?dGV5MEdodGNuUURmaVFNSHBGQTNnMzBKLzllUUp5bHhuRWFPWGdtMGtudFh1?=
 =?utf-8?B?SVZsR2d4Z3gzN3MvZnJxM1RKU2N1ZmVHZXJGUXV6WHVTQTRVSjFhSzlQbEFP?=
 =?utf-8?B?di9zWVJtckNRWktmSU82eTgveEZJZzRMc3ZHbzE4Y0ZYZEcvOTFGYVFaZFQ4?=
 =?utf-8?B?YjdnYUxRRXBoR2hDYzQvWXJMdlIreWpkMXF0bFRrdzhPS2JvNUxNQjR5dVBx?=
 =?utf-8?B?dG5mZElkaHgvN1V4NnpOQ1d0T3VOdXlpWnQ4THNRWFArbm9Hamordmk4Y0cv?=
 =?utf-8?B?b0o1TkVXVUdDN1FtNXVmRlNveUU5YWFDRTZHTUpHeDNBSDdMK3ZTWTVHL3Zu?=
 =?utf-8?B?eEIvRXJGandEUE5kamY0azErSTB6c3M1TGh4anUrUDdOYi9adE92WExhUno5?=
 =?utf-8?B?ak92dUpRMGtUamVWUzl6dFZlRHBnZVFIaGJhODdjUnVxK3FFWlY4YmhTY3FP?=
 =?utf-8?B?dlZ1ajRLRGNYVlJiZUZGLzdHRzQ3Y29odGo5c3hzSnY4OXBhdkNhWDk4L2o0?=
 =?utf-8?B?L0pmak5qTU1QYmd0QyswVFZFQURmaHgwL21iZllJWXFsY0xBVjV4QmRpVVJ2?=
 =?utf-8?B?NTNTcW5adnhGemhMTk85d2hwZWUrKzY3dEpNeVhmeVBpdFl2OXNzT3VKcmlH?=
 =?utf-8?B?NTRmaWdQbml4M2VzTE1GK3J5MFEzT1h0enRZSXdFbUZvRW1HdUQ3VDlpN04w?=
 =?utf-8?B?UDl4S0xlaTRXanJhVUg5QWhqUWFxUjF5ejd2WCt5bFBub091ZEM3U2tNSEIr?=
 =?utf-8?B?QUE0SjJ2NGZWUCs1dkNRVmg0WTgzTC81T0tvYkpha3E5bXo3VHJNaGpUWGZE?=
 =?utf-8?B?b1JXeC83SnEzbUsvclRxRElHLzVlZmxmR3Z4Mkh0YVc3RlM0eWR0Z0xIdnRX?=
 =?utf-8?B?UFpSeDM4aEpBNlowcldEb2Q5RStFRUVEVVZtdDNzblZLWlVrM3RGNG5LVCth?=
 =?utf-8?B?cVIrZFN6bW5acVZjc0NBTTNENGloTW1MTnQ3Tk5wc2lBaEZSOUNwUzV2ak5J?=
 =?utf-8?B?dWdXU2M2aFFoVVM5VkUzQjFTZ0NxOU0vUmp5bGxIa29id00ybmZRbE1tUlFD?=
 =?utf-8?Q?dw0F9EBIw6rPCLkQ=3D?=
X-Exchange-RoutingPolicyChecked: XsL/LPJn5tDlcg+WS4/319zPeLseBSL13Tda4QjTLr+LDZU3hWLoYdnbzM+d/BOYDqePSvCXHjBkGT29zO/ZaNsb3yP+Fmg+XrOgPiap39I+MHVHglkL5R6H1NLDCWEcsuwWAhz67D6wOEDoPAJryib9ZDR31C47bbjOzrIzJSlKjQK/GqIg5xoLKWCzIIqY+LnY+4n3x3Ct4iERTqbVpdOhTza8lEcWNoMkHZpmsxjTs0L+jg5FsB/y4qfa/+sDdkbWhw1WLviNoq77Go7/r9zHgStgqRPPP2qRkUQvkVH/aeyj6i7R4u4ctxxHx6towYxVXPtAU24w+UKkQiO8Cw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 89eb1538-8b52-43ab-ad1f-08df39cf6172
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9444.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 17:24:56.7889 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Y5lhhiUAwr877CzhiaLoSCGH/XJbtNodHc2YruuUtK/ike9waVC90R8RL043GWmGmQ5V8cvzFwW/xTGVK/a6cVev+wZl5+qzTWRxy1pQgs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8187
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Robin,

On 10/16/2026 4:56 PM, Robin Jarry wrote:
> Hi Vladimir,
>
> Sorry for the late reply, your email was in spam...
>
> Medvedkin, Vladimir, Sep 30, 2026 at 19:12:
>> Hi Robin,
>>
>> Thanks for the patch.
>>
>> check-git-log.sh reports
>> Wrong headline format:
>>          fib,rib: implement full network order support for IPv4
>> could you please split for 2 patches?
>
> I will try. The changes are intertwined somehow.
>
>> A few comments inline.
>> Also reflect changes in release notes please.
>
> Ack.
>
>>> +    ret = rte_fib_add(fib, ip_be, 24, nh_set);
>>> +    RTE_TEST_ASSERT(ret == 0, "Failed to add route\n");
>> it is probably worth to add an extra more specific route to better 
>> coverage. Or keep RIB in host order and byteswap inside the 
>> rte_fib_add() as I suggested below
>
>>> +int32_t
>>> +test_network_order(void)
>>> +{
>>> +    struct rte_rib *rib = NULL;
>>> +    struct rte_rib_node *node;
>>> +    struct rte_rib_conf config;
>>> +
>>> +    uint32_t ip_he = RTE_IPV4(192, 0, 2, 0);
>> just a nit: ip_he does it stands for "host endian"? ip_ho instead for 
>> "host order"?
>
> Yes, to match with be (Big Endian).
>
>>> +/*
>>> + * modify_fib operates in host byte order. When the RIB carries the
>>> + * network-order flag, rte_rib_get_nxt/rte_rib_get_ip return addresses
>>
>> nit: rte_rib_get_nxt() does not return address directly. It accepts 
>> it as an argument
>
> I will rephrase that comment.
>
>>> +    rib_conf.flags = (conf->flags & RTE_FIB_F_NETWORK_ORDER) ?
>>> +        RTE_RIB_F_NETWORK_ORDER : 0;
>> do we really need to align the RIB and FIB byte order? Since the RIB 
>> structure is internal, why not keep it in host order and byteswap 
>> just once at the API boundary, i.e. in _fib_add/del? In that case, we 
>> wouldn’t need to touch the internal algorithm-specific code 
>> (dir24_8). This would make things an order of magnitude simpler and 
>> cleaner.
>
> Yes, because the control plane will iterate over the RIB and will expect
> addresses to be in a consistent endianness.
>
> Honestly, I would really prefer if that host-order thing was only an
> internal implementation detail of the FIB algorithm and that *all* user
> facing APIs only dealt with *network order* addresses.
>
> But that would be a hard-break of the ABI. Would that be so terrible?
> Who reasonably needs IPv4 host-order addresses for real world
> applications?
>
I think we can't just give up host order, we need to maintain some level 
of backward compatibility with the good old LPM library. People have 
been using it for a long time and have built their code around its API, 
which uses host order in both the control and data planes.
FIB keeps the same semantics, which makes migrating from LPM 
straightforward. The problem with a hard break is not only the ABI, 
function prototypes remains the same (use uint32_t), so existing apps 
would still compile and links without warnings, they just will install 
byte-swapped routes.
The existing RTE_FIB_F_LOOKUP_NETWORK_ORDER flag has been there since 
24.11 and is part of two LTS releases, so I would keep it as is, at 
least for a while.
However you have a fair point about the RIB, it is exposed through 
rte_fib_get_rib(), it is not 100% internal, and user may expect to have 
the same byte order as was used for FIB add/del. I'm fine with 
propagating the flag to the internal RIB, although we can just mark host 
order in documentation.
So I'd suggest:
- keep host order (for both CP and DP ops) as default (to maintain 
alignment with legacy LPM)
- keep RTE_FIB_F_LOOKUP_NETWORK_ORDER unchanged (lookup only)
- add a new flag that makes all IPv4 operations (CP and DP) use network 
order (with this flag order propagated to the RIB if you think it would 
be better)

>>> -/** If set, fib lookup is expecting IPv4 address in network byte 
>>> order */
>>> -#define RTE_FIB_F_LOOKUP_NETWORK_ORDER 1
>>> -#define RTE_FIB_ALLOWED_FLAGS (RTE_FIB_F_LOOKUP_NETWORK_ORDER)
>>> +/** If set, all user-facing IPv4 addresses are in network byte 
>>> order */
>>> +#define RTE_FIB_F_NETWORK_ORDER 1
>>> +#define RTE_FIB_F_LOOKUP_NETWORK_ORDER \
>>> +    (RTE_DEPRECATED(RTE_FIB_F_LOOKUP_NETWORK_ORDER) 
>>> RTE_FIB_F_NETWORK_ORDER)
>> I'd suggest to keep 2 flags at the moment - the old one just for 
>> lookup and a new one for lookup and control plane operations
>
> OK, depending on your decision on my previous question, I'll change
> accordingly.
>
>>> +#define RIB_NODE_NET_ORDER    2
>> RTE_RIB_NET_ORDER_NODE, just to avoid confusion with current naming? 
>> Also since this is a bit flag it would be better to define it via bit 
>> shift instead of a power of 2 digit
>
> OK, same thing as above. If we can decide to change all user-facing APIs
> to big-endian, we don't need this flag ;)
>
>>> +    if (node->flag & RIB_NODE_NET_ORDER)
>>> +        *ip = rte_cpu_to_be_32(*ip);
>> plz reflect this change of behavior in doxygen
>
> Ditto.
>
>>> --- a/lib/rib/rte_rib.h
>>> +++ b/lib/rib/rte_rib.h
>>> @@ -17,6 +17,7 @@
>>>   #include <stdlib.h>
>>>   #include <stdint.h>
>>>   +#include <rte_byteorder.h>
>> why include it here in .h?
>
> I need to revisit this patch. I don't remember.
>
>>> +/** If set, all user-facing IPv4 addresses are in network byte 
>>> order */
>>> +#define RTE_RIB_F_NETWORK_ORDER 1
>>> +
>>>   /** RIB configuration structure */
>>>   struct rte_rib_conf {
>>>       /**
>>> @@ -46,6 +50,7 @@ struct rte_rib_conf {
>>>       size_t    ext_sz;
>>>       /* size of rte_rib_node's pool */
>>>       int    max_nodes;
>>> +    unsigned int flags; /**< Optional feature flags from 
>>> RTE_RIB_F_* */
>> old tests (and all possible places we're using rte_rib_conf struct) 
>> should be updated to account for this new flag
>
> I thought I had updated all sites, but I will make a sweep.
>
> Thanks for the review.
>
-- 
Regards,
Vladimir

