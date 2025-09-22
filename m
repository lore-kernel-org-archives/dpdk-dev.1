Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EACDCA100F
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Sep 2025 16:35:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 913C140430;
	Mon, 22 Sep 2025 18:35:44 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 1FDFE40285
 for <dev@dpdk.org>; Mon, 22 Sep 2025 18:35:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758558943; x=1790094943;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:mime-version;
 bh=ybaewQtrPLLIKJuGwZ8z6sPuuIkVuCbRrZgRp8771xI=;
 b=EitdoloWaCFGl++oPv89FoiTl8S+L5oItqIH8Jeorj0DrwvxgDXbrc/Y
 g1dORPp00A3yHAoT3XDMZzG2YBcUJ+Z4xWk5bSQHna2m/8cxecoWgqNZa
 yrO2tzbThIyXGONPNEfXNfj9K27HBPGE/z0AAMlawt0CGkjb9IAHmhxZs
 1K1e/1VxfXmhqEbPl438U6fAlO6r3ovGE9R77Dh3NvvKOah5QjtCdE/rc
 Ao46jIZgKTtZS1sANOU2fPl1+vn1u8KzpeY5Yes8ILDHz7wqXvRRpfIkm
 3qNsjuAQV25K49/RsWWSLDEQurrlUHwabUeNBRzQdzhZ+xYjhkmlp9ehg w==;
X-CSE-ConnectionGUID: yvr2fuZ/STm53SycFRde9w==
X-CSE-MsgGUID: fZDN6uqTRZWJY8eL9amwuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="78267866"
X-IronPort-AV: E=Sophos;i="6.18,285,1751266800"; d="scan'208,217";a="78267866"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2025 09:35:37 -0700
X-CSE-ConnectionGUID: sBHU72UUQvGQL339uk1IZw==
X-CSE-MsgGUID: t69ispW4Qai+qKnHOFIg/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,285,1751266800"; 
 d="scan'208,217";a="176341782"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2025 09:35:36 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Sep 2025 09:35:36 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 22 Sep 2025 09:35:36 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.34)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Sep 2025 09:35:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RRZO9ygOuphbYupkqCYX33Zjb+2xNm+RZi6Wtfb+BcMGR6uhCmFvHFd4J4n3lBOAdkjto8E/EEcxC6SWPABBi9K1G2W4nvp5ST6wsLq2da+Rt1WyLW5IzonWvNuqXuTIPw1/x4RYCLA7Sf9rtOl1pBwGij2k7dcQTr19NKe2QY1XgR9isu9sg/gIeRWkc17FCWL6zoz7LgBQ+V5js/XhgQRnhsKgMfx166GW5rSQNw0A+FKWg7TDkWerUu9sMq5+ZZHfWLeNaQR5fDnI1jfyCtMkwyTuQy7kGdscz2dSHcPerKliSUMH3dfxhzmoL0VjtCU+kjJFp1oVHgAEwyy4Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W3AzWPUwzgKjobT5mkB8SVKuCHWDU0K9lUNmZmpPvbI=;
 b=VVloINctYY4d/b0kt+mgva/UPRYYT7aDFRv0acRO62MZHbJYRxm8QeTO0dqL2KJIarCbLASONM24Z2eiXIsjaq8meHYc3JMymxSy0cQ8jJARHdRx0BYZulvPCuaqy/7122S/QRC0YC4NOzZ6sWFsfWR0JM5akzkfLnh9S2yiWfyw4Duv4A9K+zLkh+cm5qtt70O3MyPvOn6UFtNX0usuiSldkk1H23xJR2XDPYsuNwpVLnRRazZB7S/uIw9kggOE88CutdeNC3fU/FtlU4XgbY4pmpeCbQ99/i1DlC5H2Fas7I/atfOWi/tNeOtwA6OGLpWZyIbQrDjNEA6qS9zjiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6074.namprd11.prod.outlook.com (2603:10b6:208:3d6::14)
 by SJ2PR11MB7600.namprd11.prod.outlook.com (2603:10b6:a03:4cd::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 16:35:27 +0000
Received: from IA1PR11MB6074.namprd11.prod.outlook.com
 ([fe80::49e1:819:e42b:33b]) by IA1PR11MB6074.namprd11.prod.outlook.com
 ([fe80::49e1:819:e42b:33b%4]) with mapi id 15.20.9137.018; Mon, 22 Sep 2025
 16:35:27 +0000
Content-Type: multipart/alternative;
 boundary="------------ST2d1ZaK1ROyP7vWF3fLEIiX"
Message-ID: <a1edf69a-33ee-41de-b7d3-24f0894734c6@intel.com>
Date: Mon, 22 Sep 2025 22:05:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] net/idpf: add IDPF PCI class ID support
To: David Marchand <david.marchand@redhat.com>, Vemula Venkatesh
 <venkatesh.vemula@intel.com>
CC: <dev@dpdk.org>, Bruce Richardson <bruce.richardson@intel.com>, Shaiq Wani
 <shaiq.wani@intel.com>
References: <20250919145125.113028-1-venkatesh.vemula@intel.com>
 <CAJFAV8wK8G_Y+-PTLm1J4Z9g9+5WKSGMGr=1jBrd10kqt0CLVw@mail.gmail.com>
Content-Language: en-US
From: "Singh, Aman Deep" <aman.deep.singh@intel.com>
In-Reply-To: <CAJFAV8wK8G_Y+-PTLm1J4Z9g9+5WKSGMGr=1jBrd10kqt0CLVw@mail.gmail.com>
X-ClientProxiedBy: MAXP287CA0020.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::36) To IA1PR11MB6074.namprd11.prod.outlook.com
 (2603:10b6:208:3d6::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6074:EE_|SJ2PR11MB7600:EE_
X-MS-Office365-Filtering-Correlation-Id: 85883b69-72da-4985-bdbf-08ddf9f608fb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|13003099007|8096899003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c3gyYWxCaldhcFVhaC8yUU5PZk9CeWRYRGlNUlBUNlhhTTNrRFZHb0o1OWQv?=
 =?utf-8?B?T3hrRW1hSGdHUEwxczJFRHdyeFpFN2ZNd3gwL3hRemtEMUd5WFA5aTBtUmdK?=
 =?utf-8?B?eGtXdVFEZDl6YTNTNWQ0ZlpIc2JUUEpOaXAxWlJxRmc1UTNCVy8rWnBldXJU?=
 =?utf-8?B?MUUzc1pyWmtvZ3VCZGFxSFFseVhXUnRqUlNTS1p2NUNBNU14SVJHSWF0Z2JM?=
 =?utf-8?B?aHFvOGJNYW1lU2RQOCtzdW15N3BrRnZiRWJRcG9CaVJFRjF1R2FoWkkwd3g4?=
 =?utf-8?B?NitVOHd4bnFaNzZJQTJxK2JmRThLZ2RTcW1XSUUxdVpoZXNNdWtmMk9EbzVC?=
 =?utf-8?B?YzhYZnlvQTloNGN2YnVxcmZhSXk3SGJ5T0paK0ZrNUZ6a1dVcXdud0t6ZTM5?=
 =?utf-8?B?VTlOWFd6S1AwV1BGU1h3Z2NPemRxN1RDcVl3eENvamIrV24zbWV6S0dsaG5l?=
 =?utf-8?B?ZGdycm5lalNrSXFTYlNtWnRlNWtoRlFxejFlRHNMVEx3dVc5T2wzQXVSSEJz?=
 =?utf-8?B?YWpmcjE2aEJDbVBkMUNXZ3UybUkraSthOStpd0xmNHphOWpXR0pjbC9pdnlO?=
 =?utf-8?B?ekFhaUdlSGVpQkgrdG9OZE42dVhjay9rM0xrUTFBQTBORWZNN1p0ZFN4RDMw?=
 =?utf-8?B?ZytYdFFOejNQVTJ1Y3ZYSHNtZ0twa280L2U4NGt2K0tqSXNLZndHOFByaERR?=
 =?utf-8?B?UGh5SlZ1YzRGNDRrTTBUaUxVazhwMGMyTTIrQnFyeXpCR28zVnlscjQwcEM0?=
 =?utf-8?B?NEx0cUx4RHZ2eTFtTHhUMHhNTUZKTUlqbjBKd2ZaYlNuL085S1hSNHlRSTBm?=
 =?utf-8?B?L2ZvY0gvdFJPSTVrQzc3WWlLdmpBS0JSSmcrcjZnVU1nMDk2UXJIMEJHMlg0?=
 =?utf-8?B?NEZwcGZRVDMyTnpab2c4R0V0aWR3KzNPaVY5NTV5M0I5ZklOcno2Q1hoYVpz?=
 =?utf-8?B?aDc5ckdJdEtHNW5QODZyMEh5M3ZSdEtlK2Q2VVZmdWVNNm0wK2ZQOFZNNHUx?=
 =?utf-8?B?ZUdwYm1GaS90YVRUc2pUU1g5NWg2YmE0S0MyNXorYmt2ZjRQQ3F2aXQzVmNi?=
 =?utf-8?B?cnFMN2haUUJVL0lCUlhwWGRKTDlPYktZTytQUTBEbGZqUlNhUkN5SDZVcDZa?=
 =?utf-8?B?U3BoYlNMQllnMnpuNkd4R2NVWFRDUWV4QlI5OTZndHNhV1V4VXhsbmhaWTV0?=
 =?utf-8?B?Sjdnb1NudTEyUHdvNGpWbFpybWxSNlA4OXFmbndNV1dpYmtqaEliMGlrblNQ?=
 =?utf-8?B?bExoVVJFZWVqVldBK3pFaFJ4cCtZRWMvTFJWMFhXMVRYYUtTYVdTUnFqbXhq?=
 =?utf-8?B?SWc3QU4vd2pIZlF5L3NFODdRN2txbEVsQlNPRVRvZ3FMR3JHVG1tSmV0MVh4?=
 =?utf-8?B?M1c1VUQ2dENJUzB5V1FXMjBDZWxkQ3VYazhlaGNBTXNObzgwdXdtYWRQa0dh?=
 =?utf-8?B?Z3lod2ZrVkFtUjdpVyt3UFFEUW5oSFJoUnd3RDU2Y2pDSVhDOVUyZ3JKMXpJ?=
 =?utf-8?B?VGVwN3FyZGtHamxKeWNEVlh4YkVJNFJjS2U3Z2dYWUwvME5LZTJZN29kUXJO?=
 =?utf-8?B?K0ovUUEzTm16MGU1SVhtWklmWTRSZ2Fwb3FFaHV4cTJ4SytPWVhlSGpFbXdV?=
 =?utf-8?B?eEVmWTZTZmRWTTFldGM1UDVGa09jTk1Ja3pZelkwOGYrRXdrYU9RSmdSbnAv?=
 =?utf-8?B?SGNOUkNxMGl0M0lSUGZQb1V6amxEYThUNGZqOWI0MUlLNWFBNWVNT0daVzli?=
 =?utf-8?B?Y3JDZmNoR3hmZ3lEU1pnZ2NZY0wzWE43azhYTnI3S3dwY21DTlhBQ0lVa2Mr?=
 =?utf-8?B?REt6cjZzNU1QTndNRzI5eVY5SWpndzV5NncyZ0tyNWt1L1duZFZKSFB1cWZ1?=
 =?utf-8?Q?uzDEgt5LBrey6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR11MB6074.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(13003099007)(8096899003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1FHcVRUWno2VnZUSEZGUXkwakgvRFVzeUd4NW1nemZsUFdHeTNSRTRIakow?=
 =?utf-8?B?Y3IwTVJsN0xCMTZJTmdMZWV4QjJmVzhOT05sRDBCdnhrWUlqSmRneXRUcW1x?=
 =?utf-8?B?MndjaTNvNEtsV2JtdEFYSkR2cFh0NTB0RGhEaFg3SnJ4cFBUTVpKNmljeFdZ?=
 =?utf-8?B?OEltVFp0UHRRWDBVekY0YWpXNmpFVHQrZWZ1Q0tDL2NoTVJCdisrZHJ0dVph?=
 =?utf-8?B?Rlp5dUkvUkdDR0VUcHJYY0FWWXoycnYvR2JPSW5FeGFmTlNjYytheVpnSHlp?=
 =?utf-8?B?NUJkOXBYSmtSYVppUW5WdDFIMFMraklaRE5nMERmOEtXVXUzL3Rqa2RjL1oz?=
 =?utf-8?B?OTNPWE1KbkNGWVIyRGJkSDZ2RUNUNXB6d0JBRzJrSVFXTWY5Y3JwdXZhSDRu?=
 =?utf-8?B?V2NpS3pEMTVLZHJ0d2dJWUwrT1dEUlZnTzJKeWt5QVF5ZnFEMXl5clNGMjZK?=
 =?utf-8?B?TGJQR3NjdjFiNUlxRUlBMlBxUkJEbk4vQVlSald4QTJQdVo4a1QvTzFOQWRr?=
 =?utf-8?B?MVowcklKUjdtWTNSL0tyOENJQ2FxbUdFSnZJZTFHRU1CYkxDUzJnWkRlRTZF?=
 =?utf-8?B?N08wMTNOVXowSDQ1Ky80RXowalVVSCtKZVpFbjZHOWdzK2ZWbjJEZGhkVVhl?=
 =?utf-8?B?Z01NRFQvbjN3TDQzUkJ4STVHTktKc1IvVFFyc3Fwc3NVaFd2c1dsa3NYdWJJ?=
 =?utf-8?B?aUx4d1R3RWcvZEFLWnlyVGtGWndZcUZKQ2lNTXhTbGtlMjZUbTIrdUhpTlVK?=
 =?utf-8?B?RkQreDcxY01HSW1VRDZ6TnNySWVlaFNIMk83NXlzSnAxS3FOeUtpZld5bjBo?=
 =?utf-8?B?T1NHMkt3NWxzWVV0TllqVE42dS9aM2hnNjl0dFRvQ3lEeXB1VGRPSWRucjlp?=
 =?utf-8?B?UzExaXlpZEY0Ty9uMUtSdHh2aW03YXhIaWQrSHQ1Sk5hZVY3QW0yREdSLzMv?=
 =?utf-8?B?V09mWm51bHVuWUpkdS91UWlzMUlZczA1a3Q1cU5yS1BSdFBhVDZHSXZ6QnVv?=
 =?utf-8?B?VWtDc2ZBM0pSK08zdFhTdXEweTZyM0puSi9kRm5jdXAxWWFITTA0LzNlRUw4?=
 =?utf-8?B?L3h4M3U4SE53NFBzZTFrWUVCaUUyd1Nwa1kyYU5oK2ErUHJIdG5pMUdmQy9y?=
 =?utf-8?B?NndTNmxRY0J4L3lxRUxwbEJvRTlPbHNDdmI0TGxoeGY2K3prM0l1MDR0U0J0?=
 =?utf-8?B?eVpWWUJlcCtMV29DMUNjdWdsa3BoVUNWTkVnQmNJdUkxR0tKcmtFVWplWHBS?=
 =?utf-8?B?bFNJMlJrRUxlVVljSitsK1lJc2Vwam5vZHFSa0REcjAxS1o5ZjUrbVQwRnds?=
 =?utf-8?B?aWJwR21uZ0xCdXVWMHJZNk9QUzdNcVVhcldiK0FMWHBqcDV0WmZZRW8rZm1U?=
 =?utf-8?B?cnFpeSs3NzVRTFJWNy9WL09YTmQ4TFBvdG5obDJSa0lKdEFadmxENG1UTllC?=
 =?utf-8?B?VnZpNFY1RmtxdVRzZVdDWmQxNm9RWldWUDhZTlhZK3NPRlJjbk9CM2xNZTBh?=
 =?utf-8?B?N0l4b1Z6YXpvSjM0TUx3VUphcExCVWNFa2JxS2hWR2dCeW01Zm5scjkvL1Iw?=
 =?utf-8?B?U0RlSWc0TE1DQ0k3NnB1WjFZUU5IZVA3b2ZHRkhkWG9zdFpGdTcxMCtLU0dy?=
 =?utf-8?B?L1NudGlHUGxyL3M4RTZiTng4YnM5Wjl0K0dYN2JXeVdscXZPOG9KZWNSVTZK?=
 =?utf-8?B?OXpwQVl5ZUduOGtlVTRlOG1rTTdDUkxzOWRCaHdmSjYvVVBxNlppSi9CWnlx?=
 =?utf-8?B?eDJWaVRMb3NSTEc0WUtGamh4Y0oybkJRUkRTWVh0YkwyWjY4cys2ZVJta2Q0?=
 =?utf-8?B?Sm8wOGhJa2E3SG9jVlpZaldFRXRRbG53eHd0OWxSSkZTZStRM0V2R2hEKzJa?=
 =?utf-8?B?MGowNGxDZUhRc2xrL2QzOTNDbSthM1ZpS2JTem5QUk5LdXBwYlkrS3lCeVR4?=
 =?utf-8?B?V0gvWHVQNzlxcUQ1dGJZalJiTExYUmRCWHFRbk9Eb3RvRFRNYWRiZVNtc3A2?=
 =?utf-8?B?WkJmL2ZkZUNKNm4yTy9Pc3V2WWRBY3FBOEFRaGI5M214VEdHZHJLbUFSRVk1?=
 =?utf-8?B?cUdyc21UUlUyUjJETS9adHN0c0ZGOEQ4V2JmSmp4T2hBejhzTWpubHVTQVQz?=
 =?utf-8?B?NFM3M3V4aitVaXJqVy9wS3hmZ2Q1bklCUzE1SVBybllZT3JYNFFNSlB5OGZ1?=
 =?utf-8?B?TFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 85883b69-72da-4985-bdbf-08ddf9f608fb
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6074.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 16:35:26.9457 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z+sI5nUyp30lcaK4LJ9RoEPkN1oEJYgn6/a1DF59oSipuAQzSrU0MjMnYDXdnu9OfKLJt14lNiZpMQXpTGSEuyOlqy6IaqRgCtW5hq4CKFw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7600
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

--------------ST2d1ZaK1ROyP7vWF3fLEIiX
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit


On 22-09-2025 17:39, David Marchand wrote:
> Hello,
>
> On Mon, 22 Sept 2025 at 08:35, Vemula Venkatesh
> <venkatesh.vemula@intel.com> wrote:
>> diff --git a/drivers/net/intel/idpf/idpf_common_device.h b/drivers/net/intel/idpf/idpf_common_device.h
>> index 5f3e4a4fcf..9d1d7dc47c 100644
>> --- a/drivers/net/intel/idpf/idpf_common_device.h
>> +++ b/drivers/net/intel/idpf/idpf_common_device.h
>> @@ -44,6 +44,23 @@
>>          (sizeof(struct virtchnl2_ptype) +                               \
>>           (((p)->proto_id_count ? ((p)->proto_id_count - 1) : 0) * sizeof((p)->proto_id[0])))
>>
>> +/** Macro used to help building up tables of device IDs with PCI class */
>> +#define RTE_PCI_CLASS(cls)          \
>> +       .class_id = (cls),      \
>> +       .vendor_id = RTE_PCI_ANY_ID,  \
>> +       .device_id = RTE_PCI_ANY_ID,  \
>> +       .subsystem_vendor_id = RTE_PCI_ANY_ID, \
>> +       .subsystem_device_id = RTE_PCI_ANY_ID
> Don't define a macro with the RTE_PCI_ namespace in a driver.
>
> Either this is really specific to IDPF, and this should be renamed
> with a prefix reflecting this.
> This macro is a huge wildcard on a pci class, which seems very specific.
>
> Or this makes sense for other drivers and then this macro should be
> moved to the pci bus driver header.

Yes David, it only applies to IDPF. As per PCI document-

  https://members.pcisig.com/document/20113 Table: 1.3

Is it OK to rename it: IDPF_PCI_CLASS ?

--------------ST2d1ZaK1ROyP7vWF3fLEIiX
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 22-09-2025 17:39, David Marchand
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CAJFAV8wK8G_Y+-PTLm1J4Z9g9+5WKSGMGr=1jBrd10kqt0CLVw@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">Hello,

On Mon, 22 Sept 2025 at 08:35, Vemula Venkatesh
<a class="moz-txt-link-rfc2396E" href="mailto:venkatesh.vemula@intel.com">&lt;venkatesh.vemula@intel.com&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">diff --git a/drivers/net/intel/idpf/idpf_common_device.h b/drivers/net/intel/idpf/idpf_common_device.h
index 5f3e4a4fcf..9d1d7dc47c 100644
--- a/drivers/net/intel/idpf/idpf_common_device.h
+++ b/drivers/net/intel/idpf/idpf_common_device.h
@@ -44,6 +44,23 @@
        (sizeof(struct virtchnl2_ptype) +                               \
         (((p)-&gt;proto_id_count ? ((p)-&gt;proto_id_count - 1) : 0) * sizeof((p)-&gt;proto_id[0])))

+/** Macro used to help building up tables of device IDs with PCI class */
+#define RTE_PCI_CLASS(cls)          \
+       .class_id = (cls),      \
+       .vendor_id = RTE_PCI_ANY_ID,  \
+       .device_id = RTE_PCI_ANY_ID,  \
+       .subsystem_vendor_id = RTE_PCI_ANY_ID, \
+       .subsystem_device_id = RTE_PCI_ANY_ID
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Don't define a macro with the RTE_PCI_ namespace in a driver.

Either this is really specific to IDPF, and this should be renamed
with a prefix reflecting this.
This macro is a huge wildcard on a pci class, which seems very specific.

Or this makes sense for other drivers and then this macro should be
moved to the pci bus driver header.</pre>
    </blockquote>
    <pre>Yes David, it only applies to IDPF. As per PCI document-</pre>
    <pre>&nbsp;<a class="moz-txt-link-freetext" href="https://members.pcisig.com/document/20113">https://members.pcisig.com/document/20113</a> Table: 1.3</pre>
    <pre>Is it OK to rename it: IDPF_PCI_CLASS ?</pre>
    <blockquote type="cite" cite="mid:CAJFAV8wK8G_Y+-PTLm1J4Z9g9+5WKSGMGr=1jBrd10kqt0CLVw@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------ST2d1ZaK1ROyP7vWF3fLEIiX--
