Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D48D2CAC5A5
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 16:16:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0292140613;
	Wed, 24 Sep 2025 18:16:19 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 572AE402EE
 for <dev@dpdk.org>; Wed, 24 Sep 2025 18:16:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758730576; x=1790266576;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=w5BiDFs59/qvBWBosomJTM3v6SNgOtNy2jOeWwI5bDM=;
 b=Y38F0KZf81rsVWL+4L+xksxl4uzZDkdi0WFnY3F+jaNIe7MIt/ar996s
 r1pwa2YsYNS305ZoKC0TT2EBpAgJYgfHHxIk4xs+R3a18B67sg2y0YU3H
 OAn5sE9XAbNdGyt7edWVU38D9K0tLrLUWK/Z44OfkymHLmWyoRytIfcx/
 wC51nALzI9k2frQhizZsGIiN0mPUnJvMMs3Wh3edjIipzsg9ikcCaSBrO
 6uqvp6cab/GwJ/i+jk4pnk7rhzqELPh3G/bmuoeY/B9rXSiAs8Jn29wqj
 ZXck2V0MA1ZYAz2YbtoBhy1fN6a/NI+Th+uX87v3+U7JY9+EgcNcARMCI g==;
X-CSE-ConnectionGUID: XLkWPFG2RSeRlRyFDJgvNA==
X-CSE-MsgGUID: 0oio3AqUSFGWT6B7RYByog==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="83636812"
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; d="scan'208";a="83636812"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2025 09:16:15 -0700
X-CSE-ConnectionGUID: VcBZzxu+SCqx9jQLHlSYcQ==
X-CSE-MsgGUID: F/8bRSguQeehExFYEifKRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; d="scan'208";a="177844775"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2025 09:16:15 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 24 Sep 2025 09:16:14 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 24 Sep 2025 09:16:14 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.20)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 24 Sep 2025 09:16:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P3hBJVW8j3rkbpPZfWkP6n+/AL9uKMg/dbpeVbezl5ZO/0aXF4yUKy04ZthD46KuiCHS/6KKZltJ0W7dVy0jc/kj33nwCwI4R8Ge75Fjqy5f5OtY61ZmeCk8+2efJDJuHZDbaYMqYQlzgnmCcsZiW3IA5tJpDIvHdo8itLyPVIRSfGSW9XW99jfz2FCWzanu6aFWTFYLdfDZvpbGppCywQPkzzfjWGCwrzs73JB+lvJtqbvldCqjOy867SfmRtF5XPCuWCTRaOJ9ZDNotJ0UUDpbY7bOMYlOMoSSOls4U8p6ttwvTnQXKH1m5GRozvccl5UdORKHpIensYkhj3jUOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GSMsV3UxDZH4Mat0h/0FBF8FeKSGqcDsmzJDA1mtYXM=;
 b=OiVW2VJBu6t0fto+lmuNYQ2F0IOtqCfTNZvMvBXGIVV5uI8k+DmSAB/9LNA/7gKB4iFquo5cepTFrQVFCRlQpJKsgM2raOpL0dtYFWhMGI23ZSTu0AsKX0RFJGL//BfUyI+ki2pf0tD5NUoaPkeIXmLlzTlclS/G2mnUOMMHuQbwwWJowiNXH9F0RLWCqWnRl7obgtNvDojatI/gdv1tUWq8FoR8zE0oR/UkvRZ9BPZnDqAvBiF3VaPUmNcpMt5MnOGzIq2sTE5hwLm6tWxV58ac0i0+djV11ZwmwxDuAF0kzo4pQCk2HIMCc+2VwuM28LY2dZ+FkVvC0O9tm8BhSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA3PR11MB9158.namprd11.prod.outlook.com (2603:10b6:208:57d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Wed, 24 Sep
 2025 16:16:11 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 16:16:11 +0000
Date: Wed, 24 Sep 2025 17:16:07 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] hash: fix build error due to missing include
Message-ID: <aNQZR_9n1wCbrxnK@bricha3-mobl1.ger.corp.intel.com>
References: <20250924154821.927083-1-bruce.richardson@intel.com>
 <6284832.6fTUFtlzNn@thomas>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6284832.6fTUFtlzNn@thomas>
X-ClientProxiedBy: DUZPR01CA0299.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::10) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA3PR11MB9158:EE_
X-MS-Office365-Filtering-Correlation-Id: 30c3367f-c3e5-40d3-e6e5-08ddfb85acfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S00wT0Z6b2VOajBvRjlKR1F3akc2SG1aWGh2NTZsMHc0cVQxbG5ObnJRSHI2?=
 =?utf-8?B?Y2tWTnk3N1lNcFU5VUM1VjQ3TXRoMlpQb1FIOWlEUDFFWlB1aGUrSHVJL0R1?=
 =?utf-8?B?ZGVHQWc5TXQ1KzJtU0djK3AyQ1VneWhRUkFEREdRa0FkWDdLdjRLQUx3UEtp?=
 =?utf-8?B?WUgyRzNmYmlMWEhGTHU4SFBoLzNkUTRvOStLOTcxNkNydXhFdFJJdzJGNW84?=
 =?utf-8?B?QkliZ3RIN0lhRm1QVFRMQUNiNGwxNWtqRlNHbWV5OS9jSGlDNVdiVDBJalNw?=
 =?utf-8?B?Zk5ubTd2b2NQUXV0eTk2R2VUek0wZUVIUHVHLzBDWVdVZ3p4T0xtR2xITm5p?=
 =?utf-8?B?eEtwVCt3aEYySVNIU3lWdzkxRm1rRnJtUFdZb0h2bzhZV09KTVRIV2FlUjFD?=
 =?utf-8?B?VTZsRUU4YlRHbXdVc3VHVlNuaUNyZW1wWVdPaFA1T01DSjhWY1pPdFNXTEdm?=
 =?utf-8?B?cDQ0U1pqN2tTYTZhMDQ0WTJHczlYU2N2Rk56QVNyYnVVaUdoV25VcE9pL01m?=
 =?utf-8?B?YTUzZ0N6U2l0U3I4M3M1SzhXTUQrNVU3TmNXcHBWcFd5cVdubWdydVNDempy?=
 =?utf-8?B?YktSL0h0eE1EUjliTWZaK3pRTjlQbUxWTkRpd1pqNWl2a0dyd1AvY3dGQjFn?=
 =?utf-8?B?VC9lUjFqTHMwekwvYWxGVGNRakpmZ0VxSzB0Z1B0TXNZL2YrdkxOVTNrd0dh?=
 =?utf-8?B?MnlFcVJPazFWZ1p5WVNpbXY1TG9hdG05M0ZabWV1M2tTQ0h0VWRYc1hjbHRV?=
 =?utf-8?B?WkVsUDJNK2JtSytNTGdOdng1bkVMZ3pkSk1CZFFIdC9EQjBub2NPbG1xa1o3?=
 =?utf-8?B?WVZ0dTJYZjdkYzJIeE5mQnhaN0hQZkVLbjQ0azdsYUdOSlQzNENRS3VmUDJR?=
 =?utf-8?B?YjFIak1xdE1YRGZmTmRLcVNCRExmZTZJeE5XdElEV0RFd1A0SHI0b1Y4WkMz?=
 =?utf-8?B?ZllGRXlQZ3BGTVBpMXIxSG9oV0Q4bHJLakNhNjVDdTZ6Ym55OFU4Sml5YW9m?=
 =?utf-8?B?YmhkS0MxUGVURDJpRXNJdm1McnZsUHNKS1RnL0dvb1B6N3FOSTFNOTRnUFdq?=
 =?utf-8?B?NExsUFhYSXdBWUt1SFhaM0xabUVBWlBTK0h2RS9FeW1jSG9DZXV0Y3htcmhQ?=
 =?utf-8?B?RGltZzQ3dzIyNlFGZXJhVnd0TU1xRUtZbUZUb0grZDBuQlFiYmpiUUxVRnVD?=
 =?utf-8?B?REY1OU91Q3ZDK21oMHZKUXM4cFNsRjk3Qm0wWXhTZmIwWUl2cVFrN2dVUnJ4?=
 =?utf-8?B?VFh6YmNIMUpuR2VvbkUwRDZBZUloRVUwbzNUZWFFTmYyUGNVenRNaE5XcTRR?=
 =?utf-8?B?UmJqa2MzTWlkVnpUVHh4Q0F1bUY3cy9jVGpOYnIydXQvc0FGZnFqN05FMnh4?=
 =?utf-8?B?VndVbDhqaTFrUnVkZzQ3V05iOUFaN01JRjV0eXZwTGVhd2RKaUVLc2ozbUdy?=
 =?utf-8?B?TVdQeXFEM1liZkYzUmgwdzcvaDYxa3I3UWlZWE1PUkRQUmxvR0NYUDlGdUd4?=
 =?utf-8?B?L3Vma1pZWDhlMkw1OWpoaGwwcmh5WCsxTEZqSXYzc3I0dUxaSnVPQmhaek5r?=
 =?utf-8?B?eThZTE9pSGR3UzdTbG1sRmZTZWIyWmcvWXhsa1Q2TnhwZTRGR0dkTFNXOVNB?=
 =?utf-8?B?WldWY0Q0RDJudysrYU14YXNIeCtocGUrdmRseldPQ0RhOXNwQ2YvWndaMlRP?=
 =?utf-8?B?dm9TTGV2WUNRTXBWYk5mRXlCakREbmNIZjhvRWMxUkZzdTdDSzFianlUcENL?=
 =?utf-8?B?TmdaZ0E0R2tFeGoxckpxL3g2aUMxbXlDdVVubU5ZaThkSnFHWlRDeSt4Z0xh?=
 =?utf-8?B?N2cxclg0elplbXZla1haTUVXYVlFSXQxcDB6bEttalhnU09GYzFHL3ZOZkgx?=
 =?utf-8?B?cEM1VE9GMWtiVUdYa3UwK0ZzL1Btc0NyNzlnVWlVOWVYTlBseE5jUTlLZU0v?=
 =?utf-8?Q?no3MjbCYtME=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2tDMklxMER6c1pKS3Q2NU1iQnlCT1pxNHRQb05DYWlCMUROanNiYTkrR2NH?=
 =?utf-8?B?NTNjMDdhL0pIaURCOE5jMW1tUFc5amJZWmY0bTVQNStZdUZHazQ2b2Y0UklK?=
 =?utf-8?B?QWtHWTcwd0lmS29EYWNPN0NrYkFZQUxySVdWdFVGWTFtZVlUVW4yWWNzdFc1?=
 =?utf-8?B?QXMrOUdXc0xUMWlxdys5a3IwaHdRbFRxZjFpS3dSSVVJNGlydmpXaVpJMGtz?=
 =?utf-8?B?RDBsWFBuY3JsVWh6SmdSSXloL0FSVkFTRERQeUFiTkdyc3phZnNPUTFXRHpz?=
 =?utf-8?B?SkxnMWRuOWFnZjNUbDIwSDBnNUxHSzBzWDd1aHlycERBN2JselAzaFF4N2tV?=
 =?utf-8?B?QzcwUEhrNTRGb3E2Um9rR2FhRXk3bnN4cWFsMlR4aS9HSm94YTlEWlAzOW52?=
 =?utf-8?B?WUxoaUtLQW5aNzdRdStXanZza1kwa09TWC9wM2lBSm9MNDR4TUNESGIzdThS?=
 =?utf-8?B?c2cyWkd6aXBTY2FZSGVPVjMwcEVkVFlydHljYkJsMUR3WTZUbnlENGNNTGtH?=
 =?utf-8?B?WXpzMCtrR0c0Y3BOR1IwdFZjT0RKaFZmcTNVVzdMUklreWJRaVNmWTJaaUl2?=
 =?utf-8?B?ZlpzSGkydUMzNS9DWmhKR1lFRGw4Um1zZFdYZXdpN091UGRLODVrWW9XeHBr?=
 =?utf-8?B?UkdySnFKTG9LRUs2OXlpWjNDMnNTSGJyQTBrckRCRk9ld0hsMzc2NjFMeVNk?=
 =?utf-8?B?QXQ3YWZtOHhIeUdRczNQcUtRQ1VYdjJkY3dXVmhGc3M5U1ZJUWZuODNYOUxM?=
 =?utf-8?B?cHdsQmY2TXIwdEFlL3VpTi9WN210MDVoWUpTVm9jMHVud3pIZ0o4UmZuZEZ6?=
 =?utf-8?B?WVp2UWJDZnBIL1ExTXpQUFNXM1ZBNU5Zcnc3SnY2VVJUeXFNeU0yTUUvKzVZ?=
 =?utf-8?B?bHJ0bjRuNXExdHUxTC9rZEF2U1ltR3JXV2xhZlpZaXhwMDhvRGZvMjRLd1I5?=
 =?utf-8?B?bjZSbHFOY3Y4S2t4b2ZrQXc0anZ6bmtiTXhnNGVXOGZNeEVheXF6YkFpcjNq?=
 =?utf-8?B?RDhubEk3WVVxQlBpUnN0VHM0Zmd0VFNHK01CRWVDZ25neG5PRkFqZFFieWhm?=
 =?utf-8?B?OEFzWVNQUnhZRjlEL0p0WVc3UVZvOTVkNzhMQVRyaDhwZkptTWxJNmVFQVhH?=
 =?utf-8?B?cjBBcHh1ZEZUY2liRkZSQk1vUEVLV3V4KythYy9OTERyUW10QStJbnQvcFZs?=
 =?utf-8?B?cWc5bzk4UmQvSS9CdXZkbng0WllJUlFtWlI1VzRBRU9DRlhQc3FHRjA3dW10?=
 =?utf-8?B?RnczRC9BaS9CbHVNV21TVTBqVFQvR0tQOFdJZjBGSVR5VjZKb3B2MGVRSnlF?=
 =?utf-8?B?ajU3b3FTM1Y4TkVBV1dWcEErVmsrRjdERDVzbmdxOHhHa1pOVlQ1bEZNNWx3?=
 =?utf-8?B?NUlJazF1ZnRTRkdodkVoOUpZSS9lQmtWdWI4SFJtbVIvNWFMaVArT2E0MC9m?=
 =?utf-8?B?eEw4VUF0N1pLcVRRSVpZUjc3WWwxNTFuWHFrUDZPMDFpcjNYbzFjSVdHdUpJ?=
 =?utf-8?B?QkIwcEZsazBpUTNIWUFUQzY1bmVxbGMzNStFZVFtVE1WVzBmaWFXeDBLR1hZ?=
 =?utf-8?B?c3lYK09uKzJvdEhBLzkwNUZJWWJZNWpZenhROGJQditia08vZ0VhZk5mcHYy?=
 =?utf-8?B?Yzd4OUNmZVNnQVFkQXNVV2g5enVzdVIzbGI4YXU0NDZHQ216bVhHU00wOTNH?=
 =?utf-8?B?NEpyK2QyT1lvcXp6T1M0Z2l3ckFwcEN6R0pJT05OdEdTV3BOMXIvb2tXYkln?=
 =?utf-8?B?Mi9hTldOTjVUcndwbUsyK0M0SDdCUU5PYk91UTFzUlFpdFhsMHpPMUoybFk0?=
 =?utf-8?B?YjNTbktRYytSYWQ1V3Irdzh3YXFVbW5PUlZGVTVqZUR4ZDR4S1lobkJQRjg5?=
 =?utf-8?B?aVhNRUE0d0hFQnhIaE9WTDlaOUd6aHJiRGlyc1FHaEgyNnVWNGlHZytDOEhj?=
 =?utf-8?B?QkFVMU1zZytBTGtISHNvWVVBaWVvL2ExazI1dENmd2JXYXhQZzlQdzRycUVZ?=
 =?utf-8?B?NkZPWThFdU82ekEvOXQxTUp5QVlpQ1JYOGFybG1zWkgwcEd3VS9ZZXBaOG54?=
 =?utf-8?B?dHNOQ1NVOGVheDBid0J4L3ErNFNuOXg3N2dOazFYRFl1dVN0MUNFUytHN1Jh?=
 =?utf-8?B?anhwVG10cyszMVNDcGZ4RmcxdmdVRTJGYzJ3S0ZQREt2RDhyV0tBL0lFNmVV?=
 =?utf-8?B?QXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 30c3367f-c3e5-40d3-e6e5-08ddfb85acfb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 16:16:10.9649 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k72+LjnYOb6A6/xzyfwZ3lzEmD7NfqwMpUEhD5AWYP281t+urGDCVOx+acLYx0mMrOPhal0j4zXYKEb1oheNg6xpZf+j8OTLNdMnhAioEqc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9158
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

On Wed, Sep 24, 2025 at 06:05:00PM +0200, Thomas Monjalon wrote:
> 24/09/2025 17:48, Bruce Richardson:
> > The file "rte_thash.c" uses the rte_cpu_get_flag_enabled() API but does
> > not include "rte_cpuflags.h". Add the include to fix build issues this
> > causes:
> > 
> > ../lib/hash/rte_thash.c: In function ‘rte_thash_gfni_supported’:
> > ../lib/hash/rte_thash.c:79:13: error: implicit declaration of function
> > ‘rte_cpu_get_flag_enabled’ [-Wimplicit-function-declaration]
> >    79 |         if (rte_cpu_get_flag_enabled(RTE_CPUFLAG_GFNI) &&
> >          |             ^~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > Fixes: d8f0f514428e ("eal/x86: remove useless include from spinlock header")
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> How is that possible that I don't see this error in my compilations?
> 
Seems this code is only included when building with GFNI instructions
enabled. :-(

/Bruce
