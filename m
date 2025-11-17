Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D91CEACEF
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Nov 2025 16:25:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 90DB440262;
	Mon, 17 Nov 2025 17:25:21 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id CDC9D4025A
 for <dev@dpdk.org>; Mon, 17 Nov 2025 17:25:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763396720; x=1794932720;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=ZL2Ek0PeIFoZiBQt7yBHzHOPq2fLa7AmlvxoYO+N1gw=;
 b=djZ7EwPV2LJKIW2RimXKszMWyiSAr9cgbZEwboRr7VprNmjNGOVCGJvf
 xUYqa4M7seigFQZ2UUj5cYiJuDllH1Bm5Nei2JpN5crPLKLJ5T4wkKwe5
 mHebvqoCCCkbImrTk91AXZN74QNVgxEvlv9JMFXqo31e0L1L+b2HP0wuT
 rCxJDVfIuPoaZziMy88hxiTJwjI/T4u4sppgm+miR9PV0R9obQjlFc/yn
 T/yU/2N38lHKUuFmAGFdVgwNPsTjLC1xREzJYOsMxdalTyQ8jMpTiDRHS
 4Bv6PsdgC+34WguD980pZCv1aROicvl7W2toVa+ii+IZrRkRsxCWMrzeg Q==;
X-CSE-ConnectionGUID: /ZLv+4OmQgiiw59wz4ZZwQ==
X-CSE-MsgGUID: 6Kp/qimkSEmV4E0f/Ik7gA==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="68007190"
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; d="scan'208";a="68007190"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2025 08:25:18 -0800
X-CSE-ConnectionGUID: oxD1QqSLRS6ZhbjWhHWCUg==
X-CSE-MsgGUID: oBA1rDOASyWVLguLAtP0tA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; d="scan'208";a="190730301"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2025 08:25:19 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 17 Nov 2025 08:25:18 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 17 Nov 2025 08:25:18 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.10) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 17 Nov 2025 08:25:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i+iKjD+8Uv/k2x/qVbgbIChdNHDIH695ZtrTr0qGNZ5bhFA+Od+leSa9f36+Nv2nri+m/6icBK/Inz/7dqloYKNRohJ1ZGYl5UR7Q7oNV9Ebv3JtwqIsBTHQxtQyVq4883SwN1t89Y+Udri5q9wfynFz0hQSkfjMZdTVjyNkgidx6q8mkhSbvugUXlJQAUVXiK06brkfbKdRgVn6znGk3r7sTZ+/eTMn84eSfK6CylaMfzyLFKnK0MqysdStsE3iBVbqeWqDbpiE7JqxZI2J/45arlhGvQ3PeNuZv1MQtsbUVbol6nWXkd445D4LWMRZ/wb2Oo6uWAtU7cWhmxx32Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FmO9dz3BQIH8pVN+q5OY/JcpeHw3AEMQv+aw35djdcY=;
 b=r1dBsRZRu/1RGcJ65gktrX4NYlQmBnZI7W/Cv4NvKKIpBQ9o0oUttTvwjRpTwgvtejL0EqivjqOesMcc6CP6sRNoo10FTJQ3gAWFaL14XN6qEOoCwuYL6dXgwYw2Jfb4yDMzFqOvv0B/U1q/bXK0ZvXWejr7UonVdz6IaX3fPvVkRLnsngFGQ7bkbw13vM94aPwziWvUfG2KEJsn5wpMi3ZSmINF8zGhEZhrVqqUgsfWLCPzKymCrTssdf2dcD5x7slA5/uVea1egYT4e+QczN2UT+RzzSg2UnO0BLyK7wrSQA5N4Ad9aX5aSinmzEnVsy3nE3zSmhTysskMGHZGHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM6PR11MB4756.namprd11.prod.outlook.com (2603:10b6:5:2a7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 16:25:11 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 16:25:11 +0000
Date: Mon, 17 Nov 2025 16:25:06 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
CC: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>
Subject: Re: [PATCH] net/e1000: add check for filter mask range
Message-ID: <aRtMYmDnEGXhI_7H@bricha3-mobl1.ger.corp.intel.com>
References: <20251114182131.1296580-1-stephen@networkplumber.org>
 <192cd9cd-ac37-40fd-a5e6-2b51d5399b2f@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <192cd9cd-ac37-40fd-a5e6-2b51d5399b2f@intel.com>
X-ClientProxiedBy: DB9PR05CA0010.eurprd05.prod.outlook.com
 (2603:10a6:10:1da::15) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM6PR11MB4756:EE_
X-MS-Office365-Filtering-Correlation-Id: 62472cf4-03a3-4f6a-8a1e-08de25f5e168
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NUpTVzV6ZjZsUXk4LzB5Yk03QTNOTUl2bTMvYy9ha3pONUNMY01TekYwaDkr?=
 =?utf-8?B?MDJDc0YweGRRZndJS2ZUU1daOENJMTlnSWdhTlNhNS9rWmZaU3ZEV0cxMXA1?=
 =?utf-8?B?Vit4d3QvNTZSd084Zjc0SVJmdDN1bkdOQ2swdW4xVzVNUk16R1RYaEhNVlRD?=
 =?utf-8?B?NEtuN0xyczVqZ0xUakpTZkhRWHh0dm93a1EvQXBLVXBoUTkvYUR0RkJoZkVa?=
 =?utf-8?B?YjRvdmZ4dFkzRThzb2cyYzA5anFFZldPcUJRS2Z0cnBSeW92ZFNpakFSSE1o?=
 =?utf-8?B?WUNBaUl6S0I4Q0htOWdPR2psRUZjR0pneFZDYjArV2VFK3M0aDN0b3JBVVhJ?=
 =?utf-8?B?dFJVOGZCRlRhWWVkR0VHOWtRNHhxL094TnFKNnhxd21MbEd5S09YdG5Ncllp?=
 =?utf-8?B?eXBYeWsycFdzdW1ualUxWldLMDJhRDE4L3Zqc1BWVFBNUjdtYnJLS3hpcXdS?=
 =?utf-8?B?eXdwM3V2cUFib09GYit1cUh5ZEJybG1iUDFXM3h3dGZHQTdQakRRRnUxOVRX?=
 =?utf-8?B?YmIwdGRrZ0R1UzJiTis4d0wvb3RLaHQzWllOSGhvbU9JVVphTCthNklEbkQ2?=
 =?utf-8?B?eW9LWEJ5SERrNXBhblpVK3BEcGl1QitIVjJiNmVnN3ovVU5pMDZXZFlGSlY5?=
 =?utf-8?B?NFUzdGlRYjAvL3ROMThqbE52dDFLbmo4aDRnbm9NTFBXcVBveDhobXpOL3ZC?=
 =?utf-8?B?ZU16WVloWTBNblJkUVRMb3Z5OXNqYUFHN1ljNVRLamlCTDd0Vlp2TU84cE9D?=
 =?utf-8?B?dG1DNDNBVlhzNnE4ZktNK0Z6OVgxVGRsWFpLaTdJcExCWUgzMHZFbDFjOTc3?=
 =?utf-8?B?QjN3OUZuOWNyQnNFM3NsdU5ERGVOM0oyWkM1TERqZ2pkOVo2RGh4YzVrZjJq?=
 =?utf-8?B?SnZFSU9xM0hhV2RxYWFSK2dNWTJkZ3gxanU4eUxxeE1UbnVxeGZkUWFLcnZJ?=
 =?utf-8?B?WEJOTWxMbE9RejFsWWgvSENSSWV4VkxVZFFpcllvTm9SUVZvSitjMzZLN1JZ?=
 =?utf-8?B?NWJuVzl4ck9GYWJFTjdEQWdSM1NBamVlTjMzSkNwWHg5TzY0ZkdyeVp3T0E0?=
 =?utf-8?B?b1E1ZXYyVU1WakVjaEZIYlRLT2NTNHR1YThtNUxadDM4c3lIelF3VGYwWFIr?=
 =?utf-8?B?SlE2TlpObHFlUzg4eWMrcEpQWU9VQmI4RTdyYVpub0NCd1AyQ2VOWk9Bbysw?=
 =?utf-8?B?MXVmSkFSZVBRajdHdVlJRTNBb1NPS1crbzlQL1VaSC8yR1lnQ3I2UHNTbjJW?=
 =?utf-8?B?dTZoQmdTNThlNkY0c2lPWW43RFRrZi9QMW9kRG5kU0tyMjdhd0xnM2FGcERL?=
 =?utf-8?B?cGxuTGh6cFFUY0xVc1plYWJSOFMxMU9UWkxuQnczWHJJdzhwNkE4WjdMRWta?=
 =?utf-8?B?S1hTdHZxMkdmKzhNTkdOaWVlZUxOTVl4MVlnOVdTMFlFNU9zaC9ReEN4RjVm?=
 =?utf-8?B?TTlDVmJpcXlZM1kzNWxvUzdFbGFObEVCOHVvSmZNNW85Znp0bGFvZ0U4TWNu?=
 =?utf-8?B?Zy80akVFRkRtNG9GWTN0R1BRdzVlaFBkVHVyb09GTjZpU0ZZSVh5L0JncFVG?=
 =?utf-8?B?TkQ1MFRiaG8wRlYyOW1LVjI5Z3dLanh0c1Q1TDBNVXhIcWtmZkhQajQ2YlNw?=
 =?utf-8?B?MUYzaDNyVjB0Z1dlZk9qOEhBMnlYbGVDQ1BETkFmcHhJYVRsZFFHaEpucDRq?=
 =?utf-8?B?dU92NGlSdU04cThJQnZVRnZVL1hLN0c0NzhVR0R0bUpNRTRxRENaa3pqejBa?=
 =?utf-8?B?TE5qaVBMVDBIekgwSGZlMStibWVRZEgyMXRPdmpBMXdQOU5ZZUtuL1RGejMw?=
 =?utf-8?B?enRmWFE0N1d2NWVUU2JnZkJoVHVNcHBZL1JhY2RHeGIxb0xvRDlIbS8vTXhw?=
 =?utf-8?B?aEdhVU5LaVpnb1ZuVGdIL2NxeFl2RnVLWVQ1YmxBTm44MFZ2MGNJa3ltb3Rp?=
 =?utf-8?Q?mRn1CY2oKvjU8DR+q03mxNtOEuM7YL6B?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXkyMVowc3E3OHVUSmR3Sk44bzdDM3R1YlgwRjFoMnArTlFUZDlLOW5aTk9t?=
 =?utf-8?B?bWNFdkZSektTT1pURzNaODVzTlNReVBsSDdhNStCU0dvblkrRFVNNFBCajh4?=
 =?utf-8?B?ejcrcnM2K090WjZ4bW1mSnQyNU1pNklucmY4WHJYSUpIU3U0a1F2MWMyQ1RV?=
 =?utf-8?B?RkxJTUZkWXBaSTI0UXphRmRhSVI5dGFHbnp5WkJpZk4vM3NQOHVLZ1QvVm96?=
 =?utf-8?B?VXJKOFhnaUYrM29oaWVzd2I5UU95a3VNMHEraDRWalFVMDdmSHpCVzVSMEJv?=
 =?utf-8?B?Y3VGOHowcjBDZmkxcXZvenYxWTZPUjRobnN3YSt6OGFHMW9QRWxHYWp3TGNt?=
 =?utf-8?B?UGlZNCtQYjVmQ2xwSmROOGtPYUE1SG9YZFc5aEtBWXhJTjVNbHYzTWNwSDNk?=
 =?utf-8?B?MUJ6SkYzZnV3b25iZVBocG1FNnBmd3N0dUIrMmRpbituSXFFdUhxSGRlQ2NM?=
 =?utf-8?B?U09IMXJYU2RLbktYTEhZZW9UQUtZMHYwdXZFTzFHRTdZeHoxUSsyQVJMUDVK?=
 =?utf-8?B?NXRHVWJEUFVmaGswTFV3dWxhdldLVjZQR3NvQjZ6czRuQ1VublNjNXlVd2Ft?=
 =?utf-8?B?OWNoV1g2MGdDNE1ZdFh4WW02VUlYWkxOZFN3aHRUNmorTWFRcFdPYlhNUzRs?=
 =?utf-8?B?ZVpuQy9XelRkUWI5djdDb1pFcWZMQVV6ajVwUkJ3bFpLR093RmZsdnF4N2tK?=
 =?utf-8?B?akJzQTBRYkY1ZzBld1FKWE93TEdGdXB4c3AwWitKWlc5T2JmQTJUMU1IcGtl?=
 =?utf-8?B?eHphdFFCdW9UL2IwNEhPdkI2dzF2SnpBZGxmUkIzYzY1SWFsajBWd0I3OXUr?=
 =?utf-8?B?QUppWHdDT2VNRERkaWZmbU9OZnVSTXpVNjUwQUpvZFRsV3NwZEFPUkdQcjh6?=
 =?utf-8?B?UlNFL0dQYlp1NVZPNEM1VjNVUCtVRCtNdG5LUGRFbTJWaUZldkdNMzNuMitL?=
 =?utf-8?B?bzY4V1hHZXhrbnhoU0FnU3prUDljNVBqSHRnM1p2OXgwakd5ajNWMy9iMElU?=
 =?utf-8?B?MnlRNzFWWUtoSjJQTSs3WERvRFpHK2dyVkZvMUNVb1NIN2h2bUZueEthSlR3?=
 =?utf-8?B?SEdZSUdTblJBQlQ0RmZpYXdXME9iU09yWkRDUHlYMkpnb0J4a20vMnB0MG90?=
 =?utf-8?B?dHZwT0piN0FCREFYVFc0b1MwR3doQ3ErWnd6WGMyaUtGd2hhYXltcWZBdU9V?=
 =?utf-8?B?d1E3NGpjK1BaajJvY0NOVEYycmRRdE1JVmROOFNHYnRFWEVvR25JUGdkR1ls?=
 =?utf-8?B?VFRqUVR5QytTV3g2TmQ3QWU1UEtTcUNBYTZUTStIVlZhMFhNOHpEdk1YUTBa?=
 =?utf-8?B?Vldiek5YREhodHZMQW1TQzdEYVRFTS9zWHBpcXZ1RXpGTlBpS2tlNFZsRDVG?=
 =?utf-8?B?WmNQWlpnUEJ6ZDZQV0tSQldqTjNnN1R4VVoyYno2Y050eVJMZk1FYWE1ak9O?=
 =?utf-8?B?MDRnUFFMSW1UbTUrOFVIMW1WTEhieVVOcXIzSjlaMWtMU2ZubEpuaUMrTWM0?=
 =?utf-8?B?VUxZczNpam5OR3lJWmxuODRoVURJVlNpbWtjSmQybkdxcGIvcUVYR3IrUU9C?=
 =?utf-8?B?MUdOTEZwSll5RzRtM0NacWF2NlMzWXNYb1FPUnZVKzUzejl3MUlBU0xPMTJI?=
 =?utf-8?B?cUI4bEVuTGlUVW1IN2RlWUt4WVN2NmMxUDJkcS9QTzM3cDZiQ0dHakFxdEc0?=
 =?utf-8?B?cktoajMwVEZ5Tml1Wk9ldE0rYldQcXRJdENzZzViR21Ld1JsVlNkbXExZXFR?=
 =?utf-8?B?U1J1elFRS0MxRXI0Z2hHemNPMCtSbzRIOEQwS2xxOVErU1NJZDFlcmhOTW9S?=
 =?utf-8?B?eE50WlpFdjRlVlBvQ0NQNTBGaUFjUnlKaGNwY3haRm01b2xhbWxxY0h5NUh0?=
 =?utf-8?B?MStBdDdnL0d3c1JCbk5XUklmcXJLYVNXcXdSN2JLK2lFSWVHbzU3QUw3bk8y?=
 =?utf-8?B?V0RrTGMraHAyVC9YSVVxejRHdVFVOU9mY0QyMWlUT2hNbnJVa1NGREZaYldj?=
 =?utf-8?B?OVFYbStuQTB1RnB0YVNiK2tUNnNxNjVCeHBKTXg1bXk5dWlxc3hFR1NmdERN?=
 =?utf-8?B?Uml4bmdyZkVGajZQdWFTUXJObGVBVlRzOG4vd0xzM1JRVmhrVW5hZ3R1K1Rw?=
 =?utf-8?B?Q2pnTEU1Q0JVMDNPMTh6cVBha3pWb0doM3ZsTjZyb0RoNXFzbWtVNWkzalI2?=
 =?utf-8?B?TUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 62472cf4-03a3-4f6a-8a1e-08de25f5e168
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 16:25:11.3845 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Ar3zgNLGJx9yeQj3rTR1jLomgTJCV8fR7xHjhDZQ7hNWh/9fm4qnK6RQUwVA4iX8URs1vifYggVKK5IONtogUWKVuXS3Hq1AJzw3+LqE5I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4756
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

On Mon, Nov 17, 2025 at 05:06:45PM +0100, Burakov, Anatoly wrote:
> On 11/14/2025 7:21 PM, Stephen Hemminger wrote:
> > Gcc-16 complains about possible reference outside of array
> > when managing flex filter. This is a false positive because the
> > filter length can never be that long, but compiler can't detect
> > that. Add guard rail check to only loop over possible array.
> > 
> > ../drivers/net/intel/e1000/igb_ethdev.c:4265:23: note: at offset 152 into destination object of size 176 allocated by ‘rte_zmalloc’
> >   4265 |         flex_filter = rte_zmalloc("e1000_flex_filter",
> >        |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >   4266 |                         sizeof(struct e1000_flex_filter), 0);
> >        |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > ../drivers/net/intel/e1000/igb_ethdev.c:4280:50: warning: writing 64 bytes into a region of size 0 [-Wstringop-overflow=]
> >   4280 |                 flex_filter->filter_info.mask[i] = mask;
> >        |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
> > 
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> > ---
> 
> Reviewed-by: Anatoly Burakov <anatoly.burakov@intel.com>
> 
Applied to dpdk-next-net-intel. [With the "&&" moved to previous line to keep
checkpatch happy]

/Bruce
