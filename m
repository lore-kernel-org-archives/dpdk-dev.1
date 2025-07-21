Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E28C87FC5
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Jul 2025 09:01:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 823CF4021E;
	Mon, 21 Jul 2025 11:01:02 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 52D4D4014F
 for <dev@dpdk.org>; Mon, 21 Jul 2025 11:01:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753088460; x=1784624460;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=R1Zxsl2Wx5GEkerXozfy0QZTqFzh/8lhLMl5Mjy4fa0=;
 b=SaDej9QRshgDwEIb4sXEGU1OZL2N/aR9aTjHpdyFGUihw0K9ulf2h1S1
 bO1QodPyjGb2FlBtZuB28AdqhjrOZ9weZdcMtU5WAGsYXv+Go10OrgfQC
 zOZHhHnrnBqF1qkuBxLv8ioJKTCK4qn0nazI2OZV+cQtC9Lonf6SVuuWx
 I6i4u5b48wWgfhmsIj8Cp2WODET6iK3x7rRN9apx8VVEnYJCptJ96FbdP
 w/RbiU0JUdLHcUdidjagafv1ZLNtnom4ZT+DaQF7k4PagKFJKwnKeySfh
 DJx2grI8tL99CI86LDxBpD6xjQaykdb+Y2BooR5uKgBSIRXI3H/uBKjHq g==;
X-CSE-ConnectionGUID: YgP2D0iYTyykZOse5lL8Wg==
X-CSE-MsgGUID: 9pPN1HpfTYOSzOnJG7vqhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11498"; a="55446046"
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; d="scan'208";a="55446046"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2025 02:00:59 -0700
X-CSE-ConnectionGUID: WRETvdPDTNS19VjOi+wg7A==
X-CSE-MsgGUID: FudASyjuRZ+YnXC0tIYQ3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; d="scan'208";a="163079696"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2025 02:00:59 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 02:00:58 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 21 Jul 2025 02:00:58 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.78)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 02:00:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=euj+n2VhiYWCAK8ba+2pfeUNVqh54BwVDV0lDKy8Ogf5+o0HSCJml0rLzZFCIe2wbOSB/t3OncIed7Kqs4muIx7gZpLnW8kczP8qtVqfHmlIfLDOdk86wb4lEJfOWLrfbyyZHLmsGRU5qCT48IlaBpj4yo6ymA338x/mspg2NvUYFqRflrZJoOs9TMkrWQHyulCdPj3fH8HpIglnf4xHWz2wePYVgMTUWtulJyZV+Ci6564Gs+0HuLcEvd1uFn+MVmQ53oj/eJBGrNo0JbBcnhlGfNrUQIsTibMeih1PfawYhf6SctOSijcwE6CE5yGUdpzvFR30sfLKkIesMLNTTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PNcSGuuLYofGKPHJlkhfASliRTTIxVhq1SF3q4pMAqA=;
 b=i/6/wivD4O2qb9TXB89+tfTJsErddFb/MJG1l51WeHfSZZmvip+jS0stD7r0RF6ImY414VcvGKcfJ9nySVc84CZByWrvTk9UVRj3kNtv9Cg+xzJ1gekIvfqIHKdB9cV/zGEIUsd/QLRGTaRy6Qa24CVC41VyIcRgguISJJFrDGOyZYVscJMVYRjzdIlT0/n7v+Z7K03w/DjgN+9S2rDPXy12hIDADiprtvhJFTqM8G+fj+cZ1Q+LFWdJeZM8+7tSEu+CtN1YJp6jO/LppbRmdxi98g78ED1+ZIz/KV7iJZwFiYoU50u0wGGI1rCh6mj2gxdu0pdq77A6lqIpRPfKyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH7PR11MB5863.namprd11.prod.outlook.com (2603:10b6:510:135::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 09:00:27 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 09:00:27 +0000
Date: Mon, 21 Jul 2025 10:00:21 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Chengwen Feng <fengchengwen@huawei.com>
Subject: Re: [PATCH v3 3/9] argparse: allow user-override of help printing
Message-ID: <aH4BpRMOmqIEErQd@bricha3-mobl1.ger.corp.intel.com>
References: <20250520164025.2055721-1-bruce.richardson@intel.com>
 <20250718143356.1578988-1-bruce.richardson@intel.com>
 <20250718143356.1578988-4-bruce.richardson@intel.com>
 <CAJFAV8ym3Xe5XdZGdj-ztqedZ94Y=-r9Ur+AgrcE7Lgm8OgM-A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFAV8ym3Xe5XdZGdj-ztqedZ94Y=-r9Ur+AgrcE7Lgm8OgM-A@mail.gmail.com>
X-ClientProxiedBy: DB8PR06CA0055.eurprd06.prod.outlook.com
 (2603:10a6:10:120::29) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH7PR11MB5863:EE_
X-MS-Office365-Filtering-Correlation-Id: 6de0daa9-ef90-4c98-fad6-08ddc8350954
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SDZEbWFnUSs0VW0wU24ybHlBbWorc3VndThuUzBRUHRZRXVERmZhQ3dFdGlr?=
 =?utf-8?B?MzVJaVRnL1Q4U3J4Vnh6cUh0bUtHS2s4ZWlTd2dQQVRBdUlwMDA2dUw5VHdN?=
 =?utf-8?B?MkxSMEFyL1BEcHBGbWNDd204VEJXRjZtdmVQTGNuR1F0QVdYMDF3aFkyTGJx?=
 =?utf-8?B?am5oR2FvTXp0bTdySXllenlLaExkUFJRRXBUQ1B6c0JRdGd4a2FieExEZkk5?=
 =?utf-8?B?Wmhzd0xqZlVMR2dxZEJDUk9Bc1o3TUxUS3QrbnhXUTlqdCs2MDcwTkNqZ05V?=
 =?utf-8?B?bUxtMjlBeTQzT0ZmaUxiTTUvbyttTURVc0JjQUNIR3ZCRE92Nzh3bnV2Qm9M?=
 =?utf-8?B?STFCNkRHTjhWT0szTlEzNFFxcUVrS28xSjZVbzZHSVFzeTRVaHkzeUM5cy9q?=
 =?utf-8?B?azlLa3B6eUk4U0NIYVovKzc4QllUR2FXYVFVNmZabStEaWtXSUIzVFJDWjMv?=
 =?utf-8?B?VFI1TUFJd3h0RVJYSGtZWHplVXc0Tlo3TWRxQU44emN4T29tdmxtM0RUZmdz?=
 =?utf-8?B?d0FGd2hvWldUdjd1SGZ4QkRpdU1UL0RpTXp0eGtiWVdadzZueTFsRU1aN3Rk?=
 =?utf-8?B?SnJETFFxb1dGU1Z6VHoxOXhHcWZXaThHR3RJTDRIQ2wyQkJyZE9GMGxOUEVN?=
 =?utf-8?B?UWd1QkVGTHg1bVh3SXErcUdqTDNIUkx1a0kwOXZVOTc4QUU3N0hsVUd6TC90?=
 =?utf-8?B?TCtBYXVFamxtKzIvRFh5dUlXaHdMek9xc2N0cENZZ3hwQTI0K0JrNUh4a3NN?=
 =?utf-8?B?WGZlQnZXNzhvUVBFTDAvbVBVNG5aVXRuOFc1WTlWc1l2cEN1M2dMSUxDdThv?=
 =?utf-8?B?aVlGdUxBYmlGU0VOeWlXNk51MHVvQWVDZXE3Y2Z2N3FNR2dEZmFGcTlPcHhB?=
 =?utf-8?B?L21zR0JNMi94TUhKZGlHdkVzTEF4dVJCK0h2NUhBdnFobE1jbGc2S0NGOWVo?=
 =?utf-8?B?c0tURE5Mb0lhYTkvYXJjQUt2emF0RG1BSGFrNkJHMkNvVloza0NVWVdOU055?=
 =?utf-8?B?ZDZpblhMelprc3I0b0JOeC9IZ2pQU0ZwQk5QOW55S2RrOStURnJmZU1oMGdk?=
 =?utf-8?B?NDAvb21pVGFvaEdhaExSdjFwTWZUdkZXcGhKeVdrWmRSK24wQ1N4UE52L0h2?=
 =?utf-8?B?ZmpLeC83NlloZ2hnM0ZyNGZ2SXZkekJEU094RklDelZhVEY2SHZockdmWmFa?=
 =?utf-8?B?ZGs5R1dBY05iZjhxTXB6Mjc1NDU4TGxoRHV6a0dzSytrYXlTNWdpV2ExWEpw?=
 =?utf-8?B?M2Rxd3lBamlVeUpJSHR5VnRWVlBHSFV4ZVVUdVkrZ1Q5Y3NCNjU0M1VXeWdO?=
 =?utf-8?B?ZmJEVjlVZ0NoMkFIbGk5NmNQdGpHTjVZK2kzRHBJby81WHJ4Sk9VN0JWMnhZ?=
 =?utf-8?B?OFpxS2ZTMVVoSVo3YkdUd0pwdFJwMWpUSmMxQlh4VlNNeDEyZE04djZ6U0xH?=
 =?utf-8?B?QzNHdHdsakxTZkIrNjFLTSsyMHJ3c2tNQmZaZDBZdHJOZFBBOFBGdFk1ZFE2?=
 =?utf-8?B?QmNQdTNmZkl3YXVwM0o4bW9ZUW9lZEdlT2xGa0dxc3RFRTVtVVl1MVhYNzQz?=
 =?utf-8?B?SWNNUEV3YnNoUDF1YnhRcTY3NFVQamZRRjhYWk05YzA5Zk9KUHhUakZ6UHlZ?=
 =?utf-8?B?ZHk4SldtdTJGMWVnKzhqM01hNnhNZEF0ZlVkSTkyK1BKQmRra1FLTXhFdGhT?=
 =?utf-8?B?cXJiK1RiSlNTSVM0emhOd2EwZVdkYnBlZityVWpua3ZWYU1vdzEwRzhWRHFz?=
 =?utf-8?B?amhvbmNYZStSN2YrZjlyOWh4K1hQdUM0V2c0ekVKL3Ayd0xHR3pwQkFXcjBG?=
 =?utf-8?B?Nit2QTExdThIcjBUZnJnQjZLNW1DSEtBdDU3bktZNnVza1BITFZxMEVLREZs?=
 =?utf-8?B?VEp2d0hqT1VxWnB6S2xmMENFY1JtM0JiaC9pTkdYck9vbWdpQ21KUkZITmFl?=
 =?utf-8?Q?uZ7AjlEQLE8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzFOREhvTlBkaDVSV2wwSktMbERXelJuN1IxS3d4cDlxVHVLUmROQThQK0NP?=
 =?utf-8?B?T2V2dFpzY2U1WXEvQkRUVStFM2JIWGJEd0VzOW1yWERGWmwyWmp6TUJ2VVgv?=
 =?utf-8?B?cWhXb3Rjektsck5BMnRyRStNTGpFRy91UDQ4VERabzhNSjJwRW45WmpWQ1FK?=
 =?utf-8?B?RUhuSEI0ZDRBaGFpRzVFVWxwdm55Q3dCc0RYaHgxSkw4MHF2cVYzUzc2RlVK?=
 =?utf-8?B?cldpUGtUUGlKbnI4WkJIczdKaHk1aXU1UFhTVGtTY3dWSGRDdnQzUjVLRklK?=
 =?utf-8?B?TldsN3hTd3JpU2VGWmdkWko5cHdjdk45TU5seTFPZVFadUhZSEFXcGQzUnlW?=
 =?utf-8?B?WTYySDExaHhpQUtoTVRWQUJkRnN1dUxnYjdBVk5Cd0Vhdm5NNk9vbzRHOHFY?=
 =?utf-8?B?aVBUS2p5WnJYbExDM0hlOGtSTVVMSkJMNy9Ydng4aHFpWWhxK0hZZGVyZ0h0?=
 =?utf-8?B?ck9vTWVLZTk5ZVVSZXovK1NwQTJ6elcrZi9xNm5XcXJhYkhsVTZ2KzZFUEJS?=
 =?utf-8?B?dk9aV3dqSHJTMnc3YnR3WUt1ZDdpMjdaRmV5KzFvTmlab0QrM2YrUWFNSjRh?=
 =?utf-8?B?OEl0ekxoaG9iZVZhK1l1c1NEcXJza0JZbWRBVGNiTjlTK1c4UTB4K1RGN29v?=
 =?utf-8?B?NTZlV0I0WGlIbjJZQUxGeDFmalNEaDE3bS9nK2tCZjMxdk45NkVwQXEvc1B5?=
 =?utf-8?B?Z2F4UWV2QnFsY3B1Qit1ZWVBMGtTVDZVcTBNeThrdFk1aUJwYVZDL3krYXcx?=
 =?utf-8?B?QnAvMlJzY0JpVlgzZURFRW1ra01FaDFTTDBPa205SEpOTk1zWjlHbUhnb0tv?=
 =?utf-8?B?WmFOaWw5dFlEMzJxYVBuL3FCZzRUb3c1M3ozQWZTMXBCUHdiTHAyT2Jqa0Z2?=
 =?utf-8?B?WnVzSUxOYlVIUWp5eC9UUDdvU3FMSmxLWkZNb3ZhYlZ4SWI1LzFKVWZqR21x?=
 =?utf-8?B?ZHJUVXRnRkFDZnJQNy9YdmdDM3hsY0cxTTVqYVNiU2s2cXFhcEhOejlzcVhP?=
 =?utf-8?B?MWpyOEJGdzJDVUh0UlNDZEc4SFZHaFJ0TFE2Z1dMTkdvaTIvQWRUblVnTkFy?=
 =?utf-8?B?Zy96UnpqQjFhdXlsMkZPcGM4MUJXbGYwR3lCYjlpdFZjTXQ0L3VEcFdHN0Rv?=
 =?utf-8?B?QURxdGJsSUJCZUtyaHRWZGFyU1RUSlM3d01VMUthRW0xd1ZXcmtGdGdTakJM?=
 =?utf-8?B?endQV2N5dE9WVjB3bldpM28vR1FhUFVlWFFYdDBIVms4OVNtT21tT3dFcStv?=
 =?utf-8?B?cnBad0RzTE9oK1ZaejM1YjZTVm1Ld1B0NnROOXhiTGlpS25LMDdBRjRMaUQ4?=
 =?utf-8?B?NytPNTNVekFlVC9yd2pnYU11ZGFCMUtJd05QUEg0WXBjWDRMS29yL2NuNUFL?=
 =?utf-8?B?Y1lmR2J3WldtQ2RhZ1lZcTZnZTNEbGp5cVh0UXhsYkFJSkxvM3Y3TUwwYTZT?=
 =?utf-8?B?VHVCK2VTM3JCb1JuYXdmS2N4aEpTbDNXN0ZGUE9ER2V2TU1xSGFHUFFYRitx?=
 =?utf-8?B?YWVLR2FDc3FFRWo1VWhiSTEwUUtpTFE0VG4zeWtFcDd6eWszd1B2SkFnUFA3?=
 =?utf-8?B?d2l3YjM3SFFreHhsMktWOFFVVjhrcHBGcmhZalJVR21GMUF1NFlhd1B0WWcx?=
 =?utf-8?B?VkFIV2JwUEhQaTJhRUM1Y2pxN1JXZFF4MjhweVZCZ1ZJanp2alRnekxmaUw0?=
 =?utf-8?B?ZUFLZlpOeWRDTzBrWkV4ZUo3UDlhQ3hocm1ZcnhTUkpYLzNtRkVkTW9ZeENo?=
 =?utf-8?B?SHU4WEthbjJGeU4yMTNnbUYvdFF4dUhsTTk5M3JET3dHbEcvcDNXSGVnQkdl?=
 =?utf-8?B?MWw4V25IT1lKZ1hDVXJDSkdObHZaQ0dYQW9lTHNYSmZBanZueUJseVFnaFVl?=
 =?utf-8?B?Lzdla0RUZWZkT0J1L1E3V3hWQWVvZWVyQWFUblVTTjNGOCt5Qk5od2ZvMFlQ?=
 =?utf-8?B?NkVVWVlJdXdXM1ZmT3cyWFk2VDdiVjRpMkNpaDZIYzM2MXNOZ2ZQT2JDczEz?=
 =?utf-8?B?cndUL3JUL1hBa2dXendIMTVPOGc4L3BTMThDd1RHL3ZtQjdteGRNZ3IxbjQy?=
 =?utf-8?B?QlF1YXk5Kzd3Y0srd01TdFd6bzdqR284bUkxQU1kVE1CbHNkdHJidWFGMlJM?=
 =?utf-8?B?Qzd5ajR1ZGJIdnRNVmJXQnFQMy9GVXg3YzZmN0NSYm5mZWdyaVZjL2dtYU5H?=
 =?utf-8?B?dUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6de0daa9-ef90-4c98-fad6-08ddc8350954
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 09:00:27.2774 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K4rGS4Jcy5tMR9yoV2dOH5GIuj+6qrd1L8ZMINF5iuz8q+Dmw+D8yRX3lYmHnsmou6QZfakU+DszpW5MXv5xV/7hKYZjj72ZE2famzTTg3s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5863
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

On Mon, Jul 21, 2025 at 10:43:05AM +0200, David Marchand wrote:
> On Fri, Jul 18, 2025 at 4:34 PM Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> > diff --git a/lib/argparse/rte_argparse.c b/lib/argparse/rte_argparse.c
> > index d3b32c6357..e7b9bf573d 100644
> > --- a/lib/argparse/rte_argparse.c
> > +++ b/lib/argparse/rte_argparse.c
> > @@ -821,7 +821,10 @@ rte_argparse_parse(const struct rte_argparse *obj, int argc, char **argv)
> >                 goto error;
> >
> >         if (show_help) {
> > -               rte_argparse_print_help(stdout, obj);
> > +               if (obj->print_help != NULL)
> > +                       obj->print_help(obj);
> 
> Should we pass a stream to the callback?
> 
I briefly thought about it, but I don't see the point. The callback can
print to stdout by default if it wants anyway, or stderr (or any other file
handle) if preferred by the user. Adding a filehandle would make the calls
consistent, but not any actual value.

/Bruce
