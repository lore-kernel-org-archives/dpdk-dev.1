Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9261AFF8868
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Apr 2026 16:50:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 93630402B5;
	Tue, 28 Apr 2026 18:50:56 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 0542C4026E
 for <dev@dpdk.org>; Tue, 28 Apr 2026 18:50:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777395055; x=1808931055;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=f3Cv5R7Lw+ml9H9+IOCLyMUuBTd2lxmwXbNed+Q6Kjc=;
 b=m4nqZhxS98+zhQ13uTpiIdaYKujVyDdCLQpA/ND5LVtHMICsmMmZBtL9
 pFgNKyTJU2IOzW1ujwsooZSPC7ISHfG3FLHVgG8eSttTnPaDJ06lf39zD
 /w0trAWtZp4OwBXM7ZWRSHr3+CUZpNvCrICapjHMMe7dRJbYzOyGRuhB8
 aRhxWlGR6pPsx5PrppFkqncCCjZAMiuZym7omzRmMwrnqicJSeX23V727
 svyEpbUr4hUpHW1zLQ4K4j3AMGi2frWlH34e4rGTXU/T7BUfOEGCHxX3L
 jmEGPuXO/nyTPDOmrjY3vMU9WZZQb83CMqifSy57ARoHWUz54j/5PosF8 w==;
X-CSE-ConnectionGUID: zLwCHZMNQIeILafJP0SwzQ==
X-CSE-MsgGUID: spwqv1e5QFSiviDy5OctPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="80887498"
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; d="scan'208";a="80887498"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2026 09:50:53 -0700
X-CSE-ConnectionGUID: v3xuy2YfQ7anDxzHElueCA==
X-CSE-MsgGUID: 2fd4vrxmReOxOOkVvIxLjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; d="scan'208";a="233148972"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2026 09:50:46 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 09:50:46 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 28 Apr 2026 09:50:46 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.37) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 09:50:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KLwywgJw8HVdT3YQydt+kfpfm7z8c9JzI+oYzzwbw+cxmY/jhNs6elD246hohsp7v/GaGwuwQFcyc0SewiZe1nJkoyfB7XqUbq1CZ0XHYmdp76pJhnyQzKPVt3+sImUBJyI47AYfZcrzNjUQgJkn1VG2YmOgj0fnJxFQ1MOVRgrZss1gviNmqb1wZLiGHx4gWh/x0I8fp3LAhWNax2tPQNIZFpbuLF3y5youB8jmZzwqbX1l3zPpLxM2NED9zxR2PWB/ck0fqbjb0OUXOTDdJjAPKhlyGXhB0oI7WrcWGIhbUGLLa5JhkwBwCHISAankf8rRpejFQYpf3k9fgkWZkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0kHDIGp/WpSEWoZrx9/ereFGECu+A6EVa+fMPK2lg4I=;
 b=OQPJe7uC3poXsJgeFHFAkt05EozoY/Ar00ng6L4ZBoc5djVBXk/9dCbSjkF7/g+39R0h9d40S4E8YB/HEMG+xQ18cK8hagql2MNaZad/RC94g3Q2F36dnfenh/zb1BKixZn+J7TaPyQTadN+grWqdj0eJ5HQKgIqMDRUoimR92ogApGxU2gVH3uiVC5DaKTfowJco7otGR/RQeJQ8bEP6F/DRJ88/1jdXNr0r5EHYqVgCqERCRvojQRVdK2zsZ0DwUKIiN0T7QDm9vV/taF/WMSpRcSmjAqfSCGnpvZCk/94auutKUr6HipONUtZbAGG0Tki0bJ/uLB15Pksu7p4KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7563.namprd11.prod.outlook.com (2603:10b6:510:286::11)
 by DS4PPFCECA32305.namprd11.prod.outlook.com (2603:10b6:f:fc02::51)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.17; Tue, 28 Apr
 2026 16:50:43 +0000
Received: from PH0PR11MB7563.namprd11.prod.outlook.com
 ([fe80::b1d9:cd5f:9d12:e954]) by PH0PR11MB7563.namprd11.prod.outlook.com
 ([fe80::b1d9:cd5f:9d12:e954%6]) with mapi id 15.20.9870.016; Tue, 28 Apr 2026
 16:50:43 +0000
Message-ID: <ed37ba41-8df5-40ae-a805-d473688a2454@intel.com>
Date: Tue, 28 Apr 2026 22:20:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 1/4] ptp: introduce PTP protocol library
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <bruce.richardson@intel.com>, <aman.deep.singh@intel.com>
References: <20260428010117.692626-1-rajesh3.kumar@intel.com>
 <20260428010117.692626-2-rajesh3.kumar@intel.com>
 <20260427160115.42ff3f60@phoenix.local>
Content-Language: en-US
From: "Kumar, Rajesh" <rajesh3.kumar@intel.com>
In-Reply-To: <20260427160115.42ff3f60@phoenix.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0031.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:17a::8) To PH0PR11MB7563.namprd11.prod.outlook.com
 (2603:10b6:510:286::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7563:EE_|DS4PPFCECA32305:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dd56c3d-e2e8-44b1-bdff-08dea5464941
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: JZRqQ1la6JimYI6nhDxkpbzfRu4cg1W1yJRhgC4SQASGKUCRNE6JwYlTNvwuYk+xZHRfKPUZFUYckjZXYab/DLRkvKhMnkqfpSf2agr5PnhFdoLmj5RdX4UxJfxZ5H8at2FwW4wUq95kz5ioze8zxD57aOL2Y1KR8aLnLLyBt9EKLGvg6ppV0pISz5rSTl1tZlwxdklaIPdtkd8uuZ1WEetLLakYtg4trefsz94J4ACoLTWt5q7c3b0KCRVtOcinXDi+iXqyWYt3idNV4dCFuEwndRD3wzH09f0tc+MOHhNv5ov9BVN6RHOvSnmR/IxLUuE9GX0Z2zY4ZgEtGGNmaow6ds5fJpOtHTrsx+yo9IpRG+ahoVKIJexUxOj0fs4paJHYjIcMOoTOLy02Bjx+LBc0KQTZDLvDhssrFetGXDA6vTgsGJi0c3TfWmElzdZ5p2Ehpko7nMVPfX0PGdcFpjsoFPX77nZecXGbjdXJN1tmgmKIeg9sHU50/aSWZ1D5xTTIr51s5wqHp8lY/f/5kYv+SdGjXNxh7Ef5g6Lseo/aCphRCPoxNzi1xVVev+WYiFQZL6u7u9QihmYzCRcfQzwaPVWj5+S8XpZLIxFssInmktKAM6CQr7CJVDX9rMEohaboj0MLQz6Zp2c3KUG6KNuNwvpm42mcm5TOxlKzt1JWN+oBJ2YErMn1aOZuvEZLSriwfLWV78lsaz/5MlTKa8ionVJOjsuERsMQnQ1OExw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7563.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHlEclpXTGJiS0ZtMlVIOWJVVmphRHU1TmdpdXByR0ZBUWRDbG1JeHVSMEN4?=
 =?utf-8?B?T2tRdlB0K2Nqd3pjbHB4TGN5d1A2V3VqSXRjQ0RCK2M5ZWFIM05DYktadEJJ?=
 =?utf-8?B?SjFSZVhjZXd5VE93RjIwYWtsV09ld24yV28vRUNKaUNleU5ldmMxK0ZHWmto?=
 =?utf-8?B?NUxTUE9hUllPbUtsekRHdWJkNU1uOGRGK01vOWNIVzlzWVZPTVQydk1haTZS?=
 =?utf-8?B?bWxnY2NwSHVnbnZkVmcvTGorWU9GamJySDdhOWZwMVIzZjdXaXVWdnhkWHU1?=
 =?utf-8?B?TnRoYU0zNVZsUHZ5VWFlTHh4MmllL1pNVGc2Tnlhenp6WUJSbjZKc3N6REVt?=
 =?utf-8?B?WjJEMm5LQktrbkdEL2VVSzB6Z21zcjk4bVJ5TWFFUGltY2tRd3BlUWVjT3gz?=
 =?utf-8?B?aHl1ZlpWZVMzN2pjYmhGRGYycEF1NStMWk82OWttWGo4ZEp2RS9JdFBzK3VF?=
 =?utf-8?B?OVVCSnhxTUNxMytwczgzOU5CVi8vNXYvWmFJY2lIaWpvTXhmMXJ5MUNiWXk2?=
 =?utf-8?B?STcyRWxiQm1lUXVqdXlaM3Z6VDBmclVNTDVLTHR2RGhUM2VPNTBQVHprUlBx?=
 =?utf-8?B?eCtScXp4cEdzNTliRVB3d2JUNWUyejE1d0ZkYXNodWRRWi9xMFA0Q0dmbTZz?=
 =?utf-8?B?ditOZkFWQmhVMVZLditObm5nQ25OQitTblorZ2t3S0pDTzg1Tm12OERBLzNu?=
 =?utf-8?B?RUJSeGdpemxDN3JpK3JBOURvZk5UaGZzR2cxMWZWWHBSNWVwUVprcmJMOUZU?=
 =?utf-8?B?VW1nd01ZQVZibzV6MlYzL3NZMDlYdDNBSnhwUkJTQlo3T1hmUTY5Qk1PaUhH?=
 =?utf-8?B?RkgvNk1UTHhuTVQrUWlUNmc3eERtQjRMSkthYTUyakdGaSs5dW1naERBZlZH?=
 =?utf-8?B?eVUrTzU4V0dtY1pzRkI1OXBDNjBjK0RQZEtGWDBpZVVTQXNCZWhzOXdEQnd0?=
 =?utf-8?B?MVZzTWNEbzkxYmk4eFNYcnlweXU1eXRua3JYdUEyUDdqRXJVdnIwNkVXSFhF?=
 =?utf-8?B?cm9VWm43a1VndHE4MkV0cG41WEdIbnd6b2lFRGlrZTBxeWVFSnNqTUlCTkpE?=
 =?utf-8?B?dXNsWE45ZkpBSlRXVlVOTGtsL1V1Y200R05zaFpWa1dPTzNYRVdmalJFMVFi?=
 =?utf-8?B?UFJsdjJCUmVYOWdCMnJxTkNFY1pjckxic1hVR3NWRHlQcm9Genc4V2Q2RGcx?=
 =?utf-8?B?eCtrdXFWK2d3b2Nmd0JjbWRsMzhBblpqVXNxdDhZSlppR0IrNGFLcHZYWUhU?=
 =?utf-8?B?bHE4VGJvOHpycU9GSmVIdHhmRkUzcVFsNEhyclNTazdQKzZwQmFvSUdiWHY0?=
 =?utf-8?B?bkJiVVc5MkdLb2N6MlNSVE5GemdESDgrZGlKcCt2UG9HeTVoUVJQWDF1OHND?=
 =?utf-8?B?OFV6V1VNRmFWMnViV3JqNXJabkF5d041YnJnclBWVUhnWHRtSnY0aGhsSjJN?=
 =?utf-8?B?SUtneENkbER3U3FIYlBnUUJnR3plR3A0bGV3Z3JaUHIrcHg2UjBQc3J3NUh5?=
 =?utf-8?B?Mit6OVVPWlJFcTdoZWlWZGRyMEtONjJvaTZsMG1xdEJML05tSFhPNEFZRzY1?=
 =?utf-8?B?enVkL2U0YTZLSy9PTnBDOWJrTVFnR3ZTeVJPTVNIVEl1eEFwOGYyamcxKzVv?=
 =?utf-8?B?NDNSL0ZYWjgvYmovb3VMNGlYRW9nRXlBdWs1NFlvTDMwd1JxUWxIZEQ5N1Nx?=
 =?utf-8?B?aHlxa05CUklpZ1JGWGM3NnJqanFwL0dDQWlpYmN6SVFOMG10R2RNMithOENp?=
 =?utf-8?B?SENEaW0rQkJVK1F6YkNGdFZSTkp2UlVRZ0N6ZitMT0ViTFhHZ3k1cWo2bFVX?=
 =?utf-8?B?YnpWdlY2QUFTY2g4b1VDZ1VrRmNZV0VDbDV3VmVwL01ScStra0lYcTUzalVJ?=
 =?utf-8?B?S1FEc0dVUm8waW9ENTk0RW9HSnM5YXg3dFZTYUp3bStrZ1NFMm8yLytMRHNP?=
 =?utf-8?B?NldweG9XWGs5THh3TXRIR24xQXlVVVl0cko1b1ZXa28yV1pmZ21ZWmNmb1dG?=
 =?utf-8?B?NXBkem44aG9Pa1E3bFpRLzlGQitxU3dvQmlnQ3ZOeHhKbVYwN0hwb0hIdHM0?=
 =?utf-8?B?aiswQU5kQ1MrNWsxdFVzblc1YXZ6V3FXV0pZQ2ZOKzlYRllTWHVUL0RRSHpt?=
 =?utf-8?B?VFZwY2lCd0NWLzUxenJ1RlNuUjZ3L0JkVE9Kak85ZXlRbGdRN0c0ZGJsamFN?=
 =?utf-8?B?VWpWOE4xb3N2WnRUY1g3MVhoNHZyQ0JabE0wcFIvcC9PcC9Vd01lbjVYaEhR?=
 =?utf-8?B?SW9OOXZzUFNWdmx2UFdCMCtqUG14VU91T05BallWYjNuendkaFMyYkgzOXZw?=
 =?utf-8?B?ci9MUkx5YTN0OXp6N24yVDFseHFDczhDOE00UWNhT1JoNWFxUXhCQT09?=
X-Exchange-RoutingPolicyChecked: CoZ9IClmquKUDkwB14dMUGPSlIXZ0bi12CPngL7Nc0zh9ILYcLkxn7ECjBKl4T5kz4zZwQsRzgIkDvSlEOcIenvgYRkN1+f/Vm322LjZGzJN1j9Qby78QittKREa+FkTB9mJDy1YlFgMYoE9U+DNteEfLjcvc2eEjMdBjgbt+9T/k+NTXri51uwDA+9NBfUXmAnF/pWEMcyFRQqoqZagM7bY7wTwOpXTtOYZ1sf4bpwHqGqqKyorGOJAkbAJptWCTOKZOJFtXAioBYPEtE75w1RP074CT6aASVHMEUSmRGwQhDM8Qc7F2wQaJPBF/zfu0jqh/G+4fHXWz5Tfhbls2g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dd56c3d-e2e8-44b1-bdff-08dea5464941
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7563.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 16:50:43.6142 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: InbyPAIwgcmeUcbTrk/NvaeFYZqSM1XYbgeFubARYufNQfUHqxsOhkyr0KLZb2WKRUTjsXbuGcwjnj1dYoyPmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFCECA32305
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


On 28-04-2026 04:31 am, Stephen Hemminger wrote:
> On Tue, 28 Apr 2026 06:31:03 +0530
> Rajesh Kumar <rajesh3.kumar@intel.com> wrote:
>
>> +		const struct rte_udp_hdr *udp =
>> +			(const struct rte_udp_hdr *)
>> +			((const uint8_t *)eth + offset);
> Use rte_pktmbuf_mtod_offset() avoid pointer math as error prone.
Fixed.
