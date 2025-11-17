Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A90CEACEF
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Nov 2025 16:58:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 51E454026A;
	Mon, 17 Nov 2025 17:58:41 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 368A140262
 for <dev@dpdk.org>; Mon, 17 Nov 2025 17:58:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763398720; x=1794934720;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=xKlcIQN8OD2/yVNPuXW+Sb+TwKx4BuXVMFV8Vq+Nuco=;
 b=jLbJ0hO1zzfLjwVJ9vx9Mx7z6+Y7l7efjbZ5h44jlc6FRkhMWoTu+zKV
 1ZmEbeDm5MP1IgDzNRGbHoaShDrzUjAA/fvmONrtmhyi3A9k2bZQvDFOg
 fqeid5Q898+tnnjaPBuDTuqADtC6V5YUdehkcoIvRnk5WiTsRUyBb+6a/
 KTZSgVpEqLZVnUc8xw3sZFgGobRQ9Q/oaKM08tlTp8pTK2Vhqg0T7+GnR
 pFsjOEzGqIKQfn7Et8qqOzYxFEUrBUZy8+yZTHYP6c7BNJXX2gG+DZYes
 JG5WsNUMwkAMOSOybCnNYAlDJnQeLvt5felyG7IolW/I7XeXVv0F08icR A==;
X-CSE-ConnectionGUID: 4vlP68/GQeWsXxhpKB0Nig==
X-CSE-MsgGUID: /bKW8XINTOem5grvfIu7gg==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="65112676"
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; d="scan'208";a="65112676"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2025 08:58:39 -0800
X-CSE-ConnectionGUID: iDbg3nfdSjOym5M+zMQuzQ==
X-CSE-MsgGUID: J74p0vc2So+QPigUO1MbRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; d="scan'208";a="191291726"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2025 08:58:35 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 17 Nov 2025 08:58:34 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 17 Nov 2025 08:58:34 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.26) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 17 Nov 2025 08:58:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kme6M7JOqKPPuHlvT5QEl1Tyas7pwj9WpQx3Q8x/aJhkx7XT0nd84t0hZBVvOQjzgsZmR4xw1jfZRPDTLQLHizAUsWqubz6KLVQvf6W8l6zLLZFJoeYnc7vhOyNMPlufwDyNJadwn8u9irt213Qr6s4NRgR8CkYn17Klffd6oTpnYGMwZKK5VIJhUylEO6OaioL82/vT4ZlpOSSygnTz3+EPXyAyabTjsqBRvlCdqhRBUP0g5tpLJdjLhZjBv1Q1K5n99Da1bVj2iTBSZpEF4EYngDNblYmOWSyp60F4qzmS8imPqHkBBUYnucP6gYhRDEk7GC26T8mXnqmLa6I1/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nHh+Zt8fFB63Lk+Pc0GlXVlGE2Wbskx57es4wYt5udg=;
 b=qstldcjGVxlT0jFvg/QTE9p5FvutO4GZmmc1HXuG5GQTatKIE4GKXdwmwfW7snB30LkTCAe9WRyOTYSYDcZni5nPiH207plv/2YWi/+pljhqVF+0RSR9GNknEYP3q8T0OCy3iYqQZK8i11JMgq6c5K+h6tuipSzEXHuHD7928amq/UVJiOFPjN4R8HDTNsiRgrcKJpkCpdk4HT0cKKBO6sk0OdxOOiCk7YZvkPKx/xtM2Klv3g3Ihv8vlUM03Eek3SdkT2uK6fCTvn8ZO2tx6/koocn8rvqvzJ4z9+wF1HClrUKwACEheRWMGybR7apl4qSAlT1uPnC/+vn8IVYaYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16)
 by IA3PR11MB8968.namprd11.prod.outlook.com (2603:10b6:208:57b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 16:58:26 +0000
Received: from IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::509:acc9:5dba:5963]) by IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::509:acc9:5dba:5963%3]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 16:58:21 +0000
Message-ID: <47925913-cbd3-452b-bcac-983ffee432f0@intel.com>
Date: Mon, 17 Nov 2025 16:58:18 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] app/testpmd: support specify TCs when DCB forward
To: Chengwen Feng <fengchengwen@huawei.com>, <thomas@monjalon.net>,
 <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>, <liuyonglong@huawei.com>,
 <yangxingui@huawei.com>, <lihuisong@huawei.com>
References: <20251104040916.25864-1-fengchengwen@huawei.com>
 <20251111091303.39491-1-fengchengwen@huawei.com>
 <20251111091303.39491-2-fengchengwen@huawei.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <20251111091303.39491-2-fengchengwen@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0146.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::9) To IA4PR11MB9204.namprd11.prod.outlook.com
 (2603:10b6:208:56d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9204:EE_|IA3PR11MB8968:EE_
X-MS-Office365-Filtering-Correlation-Id: e59a2caa-7b80-4266-54a9-08de25fa8383
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZUREeEJTUkVQRVlXWmxCcGxVcktuODM4cGxQNHdXQ041L1N2bHgzTnZ0R2c0?=
 =?utf-8?B?UC9vRHFRNDhIWXhYODVsOEpxNDJXSnd1WUxmMitteFI4ZXFxblM4M0QwUkRa?=
 =?utf-8?B?dkg0N3NMeHFGU3QzTHV5V2ZzL3ZtM3UrWitGc2R5UGVyM3h2TEQ3aUp6NWxp?=
 =?utf-8?B?bGFXMEk1UldmaFlDQkdVZEYyRlEzRkZmenN0VEZuYTVVSzFPb3U0cWxSbTNp?=
 =?utf-8?B?Rzl3SElsbzRTeDlTRkxpVTZKc1ZlQ1RzRW5iSTFuWmpxQTF0eGtuMEwrRTNa?=
 =?utf-8?B?UTFtaXhiMWN6ZmFsc1pRWkp1QUtJc2h0T0Z5MGhqTFlRdmNJTW9MSHBKWXdB?=
 =?utf-8?B?dEE5UTZ5TmdqK1UrNnZBdlpiUDZLYXdualg2aVB3RUI5bTgvbUU2S0xrWkJ2?=
 =?utf-8?B?dlN6bFhUbkR2NXkyZWR3WFZXc1pzZVZaTnkrTmM0V3g2SnBrcUk0M2p4RWRk?=
 =?utf-8?B?dUh6OWZsMVVnVmM4MXdnZDNuY0FSR3VOUzR3blVhQ01qNkVlZ285QWwrMldC?=
 =?utf-8?B?VDdhWlpEUlQzNi9uQ0lMSnJMUlp1Q092cWVQN1NGTWlBWE0xWVFNQmlHSndE?=
 =?utf-8?B?NkRjYzFKZ0JEWEpJSnh5ZW1kMDZ4SytZS1d6MWhIMUFXN1dIYTRLK0RyTnhy?=
 =?utf-8?B?RXNDSnVHeUNzUnd4M3g2Z29YUkMza09UMzRxRTJUSGRmSzhkaXZJdW9PbTNr?=
 =?utf-8?B?cXdOdjZKUVlIMkJhRnRTZncyR2JFQkVMQTgwaWE1Z2ltNTJhM1hjNHQ2bC9L?=
 =?utf-8?B?ejQ4enorQ2J0SStaZGdWSnI0RlN0SDh0NTg4TTIyT0xyZlZIeG5lT3pxd05D?=
 =?utf-8?B?aE1IcVNmaEMxbC9aYnBoblNqckdtSmZMb3pXNlZkbVAvblNCMmhkN2JnMEdK?=
 =?utf-8?B?WXBUL0pwS3lPMy9UUjc1MkU5bmhqQWpUamN4Qlg2MjlzSmxOQmhpYmJEOTZm?=
 =?utf-8?B?dlE2Ly9oV0N4MXJkN29ZanpMUmpyRFA3ekJWa04xeXRUQ2xQa2RlWTA2NWEx?=
 =?utf-8?B?eXJhOGtrWmNrT0FIWXBnWGhwVC9qTGxkaUNMS1dpcyt6STVla0c1eEk5M1p2?=
 =?utf-8?B?OFZxaTZkdVRLRnJmVytQVHpPN2kvQk83N2NtT0VsUjFLVkY2YWl5RGpMSTlH?=
 =?utf-8?B?MVhPUUFOenNFOVF3VTBXQkpPOU5XVW9ZdnN1RDgxeXpCV0I4dllCVFVtckUr?=
 =?utf-8?B?SlRNZlkwajNPNk9mSGovRXN0MGM4OWRENUI0RHRhZmY0bm1nQS9vR2lFNzcv?=
 =?utf-8?B?d1JZcDJPTXQydHpHblU5a1FPWWE0Ymh3LzVqRUFDb3ZtVHlGQks4YzZFV2x3?=
 =?utf-8?B?TjZrQldKNVFEU2Q2STcycGZCVEc3ZUJFTk1QajBOVEtUMW9CUk9VamdFVWFy?=
 =?utf-8?B?TmZ5c3RKMEQxMVB0Y01DdVM5eUJNd01RTk1iMWpLKzlMd1NQRWpXbFBIdHdR?=
 =?utf-8?B?bUMvRW9BRFhGQmZsTFFBb3BGUDdLSjZ4U0p1TFR1T0I3UFc0VU9XU2ppV25K?=
 =?utf-8?B?RmxOcTJ1QllScnN5N09hMmtBNGRwVWI3YmNmNkZwZ0NLOWNTbDVJL3ZDa3VK?=
 =?utf-8?B?M29BNDdTcmNxajhRbnNzT3pLUVN3K0N3cU9oRTltbWhsd1VkbTJLMjR6NXFH?=
 =?utf-8?B?cm1RSDZuWjFzRXdBSjlGR1lQYktQY2dydjQrNDFBQUVnQUkxM2dIaDR4UC94?=
 =?utf-8?B?RFhUcWd1ckd1aUlTUGN6bTJUTlBKNzFFWUVhaVprMlQ3enhUUjdUdnQ4bUx4?=
 =?utf-8?B?RTFPZG5XZWNtT2wwanl0akNyUHZKbC90SGloTXJhZ25sRWhJYUx2aWJJaTNU?=
 =?utf-8?B?VldEZlVGSHhWc0ZTMk5WVUpqVzZ4cEhDT05VQVBNRzRhYTVnV1lKaTF6b1Bl?=
 =?utf-8?B?TlJvYUg1R0hwY0YweUkzTUlOSmNxN1ljZ0RwbnVvL29IN082K21ESWRZSGVB?=
 =?utf-8?Q?jarP1PVKAl9lQd+kw8R9ZuQm35K73yx+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9204.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qlc2WlhreEtLTjdHYW1xN3pkS3RycGJhZEVadnUzZlFjMVdxcGNOd0lhOExq?=
 =?utf-8?B?T2ZXNDcyVXJlMjVwZWgvY3IzbFNIOUJneDljYVhmb3FFNEY5WHZFaU94UjRY?=
 =?utf-8?B?RWNHcDZ6NGVyR3gvZElRa0xLVkJRWVhSNkJOSHEyWDRMMXhmck5yYlRNNXUz?=
 =?utf-8?B?VnpQbnVOTUQ0NGJRbXR2SitVUW96Tll4UkJqUTV3ZUM5dkdUT1NzaEdTMXNW?=
 =?utf-8?B?L0kyeERPTERSM0FEUmVGVXdiblFiQTB4aWk5cTRkZHV6KzdkRUNwMUdEVUV4?=
 =?utf-8?B?eEhnUDdVOG9tVEdKV1FieDJQbmc5WEZXOXJzQ2JkOVlmN1R2SXQ4bndOZXV1?=
 =?utf-8?B?MzhOZk5QcEI4MHFHeGJ3Qk1sYkhtUmlGZjl2RmNMeEF6N3FmNUZIc0FkVnhQ?=
 =?utf-8?B?MFg4dUhjcjBhZFNEdWgvWWtqSWxDem56MmFwYjJ0UDV2enRsVFpqWFErNmhQ?=
 =?utf-8?B?Mlk4RE5sQnR6U2NNUWxGUUFjYnNqZmFwbm5UbTVvRWxOVEx0NTNQSlNKS0tM?=
 =?utf-8?B?a1c1Tm1ZWGcxK2dwVlhpU09md1FDOUZEWExEZWpibGtWV1ExZXZIVTZQNEdT?=
 =?utf-8?B?UndBcFM2QWU4SGUwelB0NXdRUWhrZFpnWFM1VndTU0dSTzJNRTZaNXg0NHc3?=
 =?utf-8?B?KzZPMng1UkE5aVF2a3lIMnF5WU5HZDc0ZDlJaW5QTDFSaDlmRDlXVVVXYVR5?=
 =?utf-8?B?c3lHeFl3QTFLS1E5c0lDc29ldVNTZnNQWGwwOW13OExybjJCdUJHbGs3dklU?=
 =?utf-8?B?TUhWRVd3VVFJa0JSMDNvNUlBZVhIQ3pjMkx2b0w0d0NlVW1TQ0lEd25FcERo?=
 =?utf-8?B?M0MwV2ZscEVEQ2thWlN6OTNSQlA0RVB0dGpZZkxiZ09aT09NaTM5Y21SNndx?=
 =?utf-8?B?UWcxbmtySFVuNkRINVVPSkJQVVZNSTdUZ1RoQUNMMGdIM0Q3cE5admZ0cUIr?=
 =?utf-8?B?Nk5RRWFyNWlhUWdYQ28xZ2dqL210VDMxQlJLWlA2MmU5UkJmcnc4L0k2ZXlj?=
 =?utf-8?B?Mi9mQU95aDVhTnRMcENFTzZwK3dqOWZtWDBGYjg1eVIzcGNncC82ZWNhSjNC?=
 =?utf-8?B?b1BXTEowb1JZaVkrT2tpSktyZWhRWjEzb0p0Q1ZFT3ZuRlNIcEltZWp1Y2ps?=
 =?utf-8?B?NDJaYnAwYnFQeGI2Vjk4UHpTZXY1TlVFYjkycGhVdzBvUzJRdk1ic3I3MDJ5?=
 =?utf-8?B?ZDI3UHlQYTEwcEJWZ3lBcHcyWGVTQUcvYWFpRlJpTkt3TjdYUExCV2tKZmRL?=
 =?utf-8?B?TS8vZm5hOG9OcnJnOXpmQzVncW9sNUw0aWU5YVdBWTVWVjIvbmN1R0hYa0I1?=
 =?utf-8?B?SER1OGFzaGg0bkw3VjZ1THFndDRiMk9Fb3hlWlpWT1ZPMldHYW9qelFpRGE3?=
 =?utf-8?B?all4dk9OYzRsK2pZbTNIc0ZlV1MrcjdhNkR1bHJ4WWtJZmYxNTFhZnJwWXl6?=
 =?utf-8?B?aDhCRUM3dWF5YUpwVzBEaWlPdmFjdjFmZUpBOS9uZG9VdjRYN0xyb2VPVWQ3?=
 =?utf-8?B?NHpZaGc4MmlBN1dqU0prNXoyNE1NSzBoWFJQNlpwSTZ0OXc4aTFEU1VYbTh2?=
 =?utf-8?B?SmhVeWtwZkRhOFpMdm16RlZpb05oY3FuTzlPbjQrOW9tamdtUEtiWHhYQndi?=
 =?utf-8?B?ZDIzMkZqaS81MVFhVHZXUTkwMGRhQUlaWERiaVpIL2x1cWFISldGakJ4WVV6?=
 =?utf-8?B?dVllVFRmTnYvRzlXTWNrZW4zaTFhMFZYaUp0Q2xiUW5iNDZWTFZ3ajloRHJh?=
 =?utf-8?B?RUdZcUhwRzkzLzVhaUZVZExHaUVIemFzd1FJb014MDU1YUZyZ09WYUtlaURR?=
 =?utf-8?B?QXF2WlpEYXEzN3VuWEdoTWxLbjVianVjaUlJK0YyVDJjRlRxTFBhSjhBcENF?=
 =?utf-8?B?Mk56Rmt6a21rOXZpNk9WMEdzTTRNcUhzYVY5bGJQRm5KNnFTK0RnckdjSW1J?=
 =?utf-8?B?VHV3Z24rUjdObDMzM05nU28vOFNPN2lCNzlOMjk4eXh0MXF5Sk1sQmwzWFpK?=
 =?utf-8?B?NjBhOENxRFQ5OHVOOTdnelZjdHBlSDdtbzNxODExVWNlK3ptK1JIcXlKTFl5?=
 =?utf-8?B?S0hybVdxVFpRVThYZGNodHhqcytPblBvVENJRCtXRjhXbDJneWJYbGhOUTJN?=
 =?utf-8?B?ZFJWTlcvZ09TV012Szk1ekJldWpPb25BaCtwWURJc1lEb2xTZlJQcE1zUXRF?=
 =?utf-8?B?TWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e59a2caa-7b80-4266-54a9-08de25fa8383
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9204.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 16:58:21.3591 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bWjoodQd3+Pq6OioaV3mTg/ToElJ5OXnENio6Itt7H1nU6M0IGZqbAyZSsdNMiWPj3RYMW11mua91nh74XZMpH2yys7JmLRk0CCzBIo8yJI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8968
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

Reviewed-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>

On 11/11/2025 9:13 AM, Chengwen Feng wrote:
> This commit supports specify TCs when DCB forwarding, the command:
>
>    set dcb fwd_tc (tc_mask)
>
> The background of this command: only some TCs are expected to generate
> traffic when the DCB function is tested based on txonly forwarding, we
> could use this command to specify TCs to be used.
>
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> ---
>   app/test-pmd/cmdline.c                      | 57 +++++++++++++++++++++
>   app/test-pmd/config.c                       | 50 +++++++++++++++++-
>   app/test-pmd/testpmd.c                      |  6 +++
>   app/test-pmd/testpmd.h                      |  3 ++
>   doc/guides/testpmd_app_ug/testpmd_funcs.rst |  8 +++
>   5 files changed, 122 insertions(+), 2 deletions(-)
>
<snip>

-- 
Regards,
Vladimir

