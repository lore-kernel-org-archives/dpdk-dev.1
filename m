Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1B4EA811F
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 14:17:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 77F2D400D7;
	Tue, 10 Feb 2026 15:17:44 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 4A0FA400D6
 for <dev@dpdk.org>; Tue, 10 Feb 2026 15:17:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770733063; x=1802269063;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=PCEW5RLuoOFMiAMugGAB38IW+ulYcyx/ZnSTFZ17NzY=;
 b=dQH178VeefBqliEO7Qoux/B5dSiDJ+eti99pQA20RnL4u1c+9481mH3M
 R/Uoh0cMw+XgUvA0stlSgXmIQJhrPXJLlZpdq+6k3WwLEhNdp79E+k3PI
 zDdNI1lOus1gBfwV768acGvhdDAY5V9yFdh6NZUzOg1xT45ZkdtjYq7g5
 IxkZfDcnKl1mDMvwehdbCg7p9ExgG34I+i1c2Nz1r/SXO4J2lxOAHiYTm
 jgFIVbxJhdyfqcL4oc6KjnIsTe/9lZAok0p4AGmFs42Az+Ybi5gau962T
 ypylZl0FxEwuqFFDzzWuyPj1G7mWztp2r72R1Ew03Kg163Bg0DP10X5b0 g==;
X-CSE-ConnectionGUID: uF1HtURyT7aU2pnTXSgZtg==
X-CSE-MsgGUID: 9AX7E/fHTT6mBr1xee6qrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="71073001"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="71073001"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 06:17:41 -0800
X-CSE-ConnectionGUID: TuvZwaRPS2u0T0+NltRWhQ==
X-CSE-MsgGUID: CsfzRlcjR7mlSagAR1R6bA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="249574647"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 06:17:41 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 06:17:40 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 10 Feb 2026 06:17:40 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.19) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 06:17:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nJi8QSXD9RG6muAELKX9UT+OQpW9QbBh7Izt79cgj2MHytSHEyBN/P3dJIcZ474NBh3kelM0A09OOvN2U4PDfeDzshHfO2Vxl0eJn0rfyXFsBL94WmQtVR9zxoV0/Du0Oj3Gh43zBR9YH0ink/38boTwCFPVbxPuPNeLUywLZMA56pBTqOMDunrAx/HliSBU/ruWmvFJYAXaJTjcev/+Bq0TCZKGcyS1C+Wg0cfZEEOXjnKuweMI+go7+//7f4XDn80Mc+/7RLsxMTN9pUAPqXxK3ZEpDlj9bDrnZzKyRudgMhUIsQjJgKnW2r1fIB7Y+vL/lRhhRvWgsHR9eOr8Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UzVwDU19s33dbX7ra50vpwM6egQ7rMoxor4ZLYkDmNI=;
 b=Ao6zKwmqWLXn/FoI90Vx08dE3isWN88s8uOH/VVfvLwtN3sZcfn/Ak/n+/gFdkOTkmyydBXUeUz9PCKIoEjU9o9sBNKxvWBWxYKknvl7Q9mAyaANp+yqWlSEjD/1DNYeUlOzjuP/kXRTSpdnZeVubAipiWcM5rHM7OTiuDDlXSjp8ZWn2DMgXdphFle4WCotBbbLH8LGURJvBQQI9+Xz4KwndDwZHOXCLgUgS8J29CygXLwCCRb83qNjBQXFb4cZ/f9TZh59cFe8jf7qGIgYBiphQPshU2iqps1jloR/4FUf/QF1o3aNEdhhX+XGMIqi0TAU5MV4MKhhPTH/ygvpfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 DS7PR11MB8783.namprd11.prod.outlook.com (2603:10b6:8:254::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.19; Tue, 10 Feb 2026 14:17:37 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9611.006; Tue, 10 Feb 2026
 14:17:37 +0000
Message-ID: <1518516a-5c1a-4bd0-9c8d-f071ae33a8c6@intel.com>
Date: Tue, 10 Feb 2026 15:17:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/35] net/intel: add common fn to calculate needed
 descriptors
To: Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>, Praveen Shetty
 <praveen.shetty@intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260209164538.1428499-1-bruce.richardson@intel.com>
 <20260209164538.1428499-6-bruce.richardson@intel.com>
 <cab7ff8b-b260-4339-b0d7-8a139b617ba7@intel.com>
 <aYs73tmg3YBlSXLB@bricha3-mobl1.ger.corp.intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <aYs73tmg3YBlSXLB@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0040.eurprd04.prod.outlook.com
 (2603:10a6:10:234::15) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|DS7PR11MB8783:EE_
X-MS-Office365-Filtering-Correlation-Id: cf1ddf4a-1624-43d8-446b-08de68af2470
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SmNZSjczcHo4QnJtbFhCM3RleWpXeUt2aUNmUUlGc0ljYVZkQzJqU2lCYXJB?=
 =?utf-8?B?aXdEdlFPZ0ZkVklVTnpDaUdhckcyVEV2dndDZCtJNG4xL0tYeXhTT3BBZFN1?=
 =?utf-8?B?dnBkakt6Sk9Ba1VtR3o0T2RkTld1bE1ldlhDUU1ySitsTEdzelhjclpvbjhS?=
 =?utf-8?B?RlBGbzg2VmphZ2VhTkZnb2ZoZzRVZ1FNZ3NIbWRSQnZvZEUvcVFIT1lwekxK?=
 =?utf-8?B?WUdkcEpwcTZwMEFzUEoxTTM1c2RYM1RYWmxXM0d6b2xja2MrcmpTUXJxUElw?=
 =?utf-8?B?VDVWb2VVS1NjVFFzRlVEcGRxeGo0TFp4OEQzRU5QUW5JQ1NXdWN4ZXZHR3V3?=
 =?utf-8?B?bW9zaWF0RUhLSUludEgxb2w2aDFSVHEycW16ZWtpMWxldkZyT3dNRXA5d3VN?=
 =?utf-8?B?clVEZ29JWm9Gdllub0xoQ0dTSkZNenhuTnNuUkpTcjBzRnAxR1FtNXpzWjUx?=
 =?utf-8?B?ZDh2Z0VZby9iMFl6Q3BaZ0FFSkFHbFBSN2M4eE93eHFjUTVwY29waFRNOFh4?=
 =?utf-8?B?MUoyZzdNM1ArTHlrT2JLLzdqQjZkNWRTaWw4ajVLbTR0TmJiT0pnSW0zcVFw?=
 =?utf-8?B?SFJmdDNrQ0lES1hMcDcvVGdScTdxbnIxVjdiL21QbHdTVURjZG45bGRwcy9J?=
 =?utf-8?B?RmZDOXdEWXg1ZmY1MEpKTnNpaG5MS3F2Z2wySXI4UHhEWlQ5MC9GWVFsY2VQ?=
 =?utf-8?B?cVUrL2dPS0lPSzV0dEtGWHVST01xbytDUVlLRG1Oa3dYN1o4R2lGVUE5SHdT?=
 =?utf-8?B?OXplZldvMWVGN1h5VDZQc1d1MHl2Yk1LTGcyQUYveEQ2SzQ1Qi9raE1ld0kr?=
 =?utf-8?B?N1JwN1k4NTJYZmVUYnhYSkNIVGdUL3BIblZpaVdtck9IUnBJaGhKOE03T25X?=
 =?utf-8?B?WnR1SVRzRzZoQWk5d1FoWEpCWW9yMTRteHVjMlgvNStmZENod3lqcFp4T2h6?=
 =?utf-8?B?YzFNYTJ2aFFQL29TWlBwZHA3UHVFL1luVEpqWEd6QkNJc212NEhFRGNCTDRs?=
 =?utf-8?B?eTNQV3dENjFhTHZ2N1pGS0hsUmdzejd2QmVxZ1FUU3lYc214WHpuUis1eld2?=
 =?utf-8?B?MmxSNUVPZHVMcEdBWHR1dDUvMDY1NEY1WE0yUzdEeERwN2ljSlFrbkkrUU9G?=
 =?utf-8?B?YndqZTIxTEl4Q3RiWlhXWnNMTVVqVDVvZmQ4Y0dTWGE5ME1GeTBkN0NERVRT?=
 =?utf-8?B?UThlVWp0TXpqeHpPSlUzeG1NMEd3K0EyeGNPVkVmbkE1TDUzcUNtZnJrb2or?=
 =?utf-8?B?Z2wrNGorY2Z6a2RwNkRTQjdQTXV0VUE2d1NZV0x0S3RjaWdLaDBxYmwzeG02?=
 =?utf-8?B?aDRwRU01SkU1dmc5RTBxRE1Ud2tnZGkzZ25yWTlUYjZOdVJsbTRSdDhaMHZQ?=
 =?utf-8?B?UHp2Z3NMRS9PUzZ4eUkvb0VqWW1wbGxTZ2dmMjUrbno3M2JJSXVycXZ2TVox?=
 =?utf-8?B?QWg5dEZNMGIxcDJuOGFvdGFxK0RIaWdsVm9UbndRZjZSODdaSXMwZDJ3SkNO?=
 =?utf-8?B?K2dpRURVaW45eWRtZnlBNzltZDdCNnNpZUtxS0pjRnRzcjQ5bjg1dksyRWNO?=
 =?utf-8?B?UTk5WkdsZS94aWhBa0VwOEhvNkp2YVV1SEZDYTdDREM2NnJXRHI0MXZhRDNC?=
 =?utf-8?B?MmpGamR3aFlmeS9YMTNiVU1jdHRTOWNWMzI0dUxtMXpYN2x4Tk10aXF6Q1NF?=
 =?utf-8?B?aWUvbllWQ0Irc05OcVV3alk0Ykg4alNwWnM3V1U5VjZFVDdMMUlFRFRVajY5?=
 =?utf-8?B?c2ZpR2FINER6MHhlQjIzSmYwTE94eGsyQ1dJSEFrVXBBRGJ2ZnlpcG1TMnkz?=
 =?utf-8?B?YUNDcndNTTU0MndmMkFjUEdWV1Q5czBsQ2tBWHV1S1BLb1ZaRTN5SDF1bnhy?=
 =?utf-8?B?dDEyWmszcVhQU0hieGpaZWJkTXo5bzlXcHFFUUNzWnl2VlFCM3g1L3kvWEpm?=
 =?utf-8?B?VFhxai9nVHdaRTBvVmF0b0JQYzFIQitaTkJSS2MwZDVUdFZtWWgrUkV0d0Va?=
 =?utf-8?B?Ri9IU0ZTR2NoT3pSdGFaaHlSczZBSnp2QW14ZVpnZ2lmMEJGRDBpVzRFWmc3?=
 =?utf-8?B?ejRWTHBCNnZGc0ZWTVpHZUVlbWY4MHlvRm9rNDdlYjZNWW9IdW1oZmFvZ1dX?=
 =?utf-8?Q?EWU8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzFNdUd1eGtBY25VQkZWcytSSHo1MmQvT3dsZlI2TmxiS3ZvTWVzc0RFblVF?=
 =?utf-8?B?b3ZhRDNiUVpMTWhnTi9IWmZ1ZE5sbStnMm04OUFyS0ZIT1dOdS9QblNNY0xX?=
 =?utf-8?B?TUVtZE9VYWpDbnluMitWWHNPanN6VTBnSmNwUlIrVmNwTVliT2RCZUhoZ0JG?=
 =?utf-8?B?MFAycldQUm9sTDFkYzVRWlE0SFUyRG9iZnFnQmhzcG1uc3paSDFUNlVsVHBQ?=
 =?utf-8?B?bUZqejdsckJheUtQSzFCbUUwbjY3YTZZRHhMOWRUbng0Mjc0bGJ1bjJ4V0Er?=
 =?utf-8?B?UkdrekZkNFM1emNpSkMrcDVUNlZUYnM2QjkrYm9tWGduOGRBMEphNnpHbENY?=
 =?utf-8?B?cUs3YWwyQ1lYZWltRUUzM1VCZkg3S1VnMTBjNUJEbXh4eU1LVy9abE90K3p3?=
 =?utf-8?B?WUhkUWFNanNadUw4c1Z1eHJkL2t5OXMwWFB3N1pDUm9xMGV3QVk4VHNQRjEx?=
 =?utf-8?B?Sk1WRXNpdEppRjhVQ29UYy93K2xDVXgvTEtaZ01RcFNRT2xUS3NyNXJmL2p0?=
 =?utf-8?B?RVlSbWtmb1gvTGt4MjhpRU9ZRmFmSGxrNW1oeDV0c0VxNURJSEh3d1VYSUdk?=
 =?utf-8?B?cHpjMFlLalQ3Q3JMbG9tVzM2d2g1WHlrUHJMa2xrT2d0cHlLSFdqczRoWTFq?=
 =?utf-8?B?SHNXMDVNMGhzUmtnRml6QjYxSTh2bVhrUm9ZazZPbEZ1NnBDeHUxWXcwbURE?=
 =?utf-8?B?czdGYjVzRVNrTnlKN0d0NmQxTDFVMTQ3RVg5NXBOQVVCUWk5cmJUSjhIb2FU?=
 =?utf-8?B?M0dySDhTajJXdkt5bFBwYjl1SUVieHFFVy9VV1owRzMzbFFXUGU5cTVBKzBF?=
 =?utf-8?B?Sjl4YU1pRkdxeE10MEFxeFNzN2xNRU5naFdXZWhyZlpLTkpaeTNheGhJNWUx?=
 =?utf-8?B?MGRMdzMxMnQvY0FqNDZqNFBsTzJGTjNNOVYxV2ZaTS96VWpCMjZNR0xWTVpk?=
 =?utf-8?B?R0hRbjArWEltelJiWGtaOE1pcUkxeGZlcWtsOXFjK29RY0lOMWJrbmZkcHhL?=
 =?utf-8?B?bGEwZ0pCN3E3dldYRUJaU09sYUxXTHB1aWVzcVk1eXpldmhUMElpQTNSTWpV?=
 =?utf-8?B?MTM1Y3p0RFRYQTNTZEdyTUdwV3FVakZRa0ZYcEgwOTVISVdHSXdiN25uNXpz?=
 =?utf-8?B?UXhnWWpYV0MzOW1WdnFmZUtpeWgzYzRMN1FHWTUxTnB5dXZBTm5RT216dWgw?=
 =?utf-8?B?OXE2VEtaY0tYbWwrbkdEck1ONUhEamNDZkxIZHk2Q09HYkZ2S2t0L01NZHJ4?=
 =?utf-8?B?Ym1TeTdWclJ4bEhmUUR4L2xTQndrWXZSbFIrU1FnWFY5UEVTeHljUGtCV0kx?=
 =?utf-8?B?dk9zaktYaGw5OHlXS2pXY2pwZjB4T0tjbllhbnFTSTFXWStpa2JjT1NjYlBX?=
 =?utf-8?B?TzE4ZmV1ZTR0MGxBNnhueVpZZFZWUTBrWW1WYnZOd0pwVFdDRWNMZHRxSXNy?=
 =?utf-8?B?RGc2Y2pucnBUSlFKckQrZ3Y4NDRNakxiWFdvd3dNYk9PT0hKTWpaVlhQbWFx?=
 =?utf-8?B?M2Iyd1BXZEFRc1haa1FLNGtkVWN5T29kalRsOEt1SkQ5Z213dDRwYWlIZ3Ux?=
 =?utf-8?B?VS84bk16K3pBT09aQ0dKY3V6SmQ0NXVzL21JUkJKMGUwSll2aEFVaTNPeERO?=
 =?utf-8?B?RjJoUlI0dC85ZGlOT1Q1Y010NjhpYlphQ3JWOXFYdnBERCtZSzVwWkJnRU5F?=
 =?utf-8?B?RW1Cbk1zVnFPR0pMM0JRUTZZQ05Kenh2ZVhqRi81L21jMklwWVN6WFJ0bWhY?=
 =?utf-8?B?NkQrcklDMDdNVm1tS29mdFFGOEdHVFFpczVYSzQ0elZCdlppNjBLK1dGNDNU?=
 =?utf-8?B?eGEzZ3JQR1FSSVZza0F0ck9STnQ4aXVkTWMzSjdaTjJqUGNhMXQ2VEh3cTdv?=
 =?utf-8?B?RW01ZGt2NEZGTzFsVEUyc1dzcmJ4RmVrVXIrdlR6SDJoNDRtWVp3eE0zd1lW?=
 =?utf-8?B?ZUx5VDJNeTFOTlZuRWlGRGxWSkFYZ0huNmpKSTkrUGdNREtLZmhZVWF3VG5t?=
 =?utf-8?B?bDEyZ1BIQmwxZ3Zrem9DVkxGeUhFTzF2d1dDS0FBRDhBOVE2b0pwbVdnYlRG?=
 =?utf-8?B?TmZEQzJWUjBOcXdIdnY5WkJKMW9Ldi82OUkrU002T0pUZTVVbldTRVdIbWk4?=
 =?utf-8?B?a0FrU0hhUjNLNDJvMko1OUtCM2dWZzArNmZrOXRpUEdWMjdWWlNNSmZ5a1Jo?=
 =?utf-8?B?T3lwdTkzbjVMc3lpOTVaUEJQY3pNRmE5OEE1UGM3VEs2UGVnZlcvY2FKaWoy?=
 =?utf-8?B?SzR4VVd3NWVERUNRTVFEUVludktqdUNJeFZPM2F2Z2tpRUREUzEvSVFHTUZC?=
 =?utf-8?B?SlVibHo0ZDRTcm02QVlUbDJMWk83K29iWmluaVByY0pBWVFlYUlacjJGd211?=
 =?utf-8?Q?RbpxDEt8Yb8AKMZU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cf1ddf4a-1624-43d8-446b-08de68af2470
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 14:17:37.5254 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PZDap73DGqXpzRvwgrpHMYql4y8AjqG/PjTBgw4pTnJr+OaWCKAWnwPjY1GYlQRdk2p/uKYJF/fVoitbHzo50wSFagUNn3qiBYwhAhlmqrs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB8783
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

On 2/10/2026 3:08 PM, Bruce Richardson wrote:
> On Tue, Feb 10, 2026 at 01:29:48PM +0100, Burakov, Anatoly wrote:
>> On 2/9/2026 5:45 PM, Bruce Richardson wrote:
>>> Multiple drivers used the same logic to calculate how many Tx data
>>> descriptors were needed. Move that calculation to common code. In the
>>> process of updating drivers, fix idpf driver calculation for the TSO
>>> case.
>>>
>>
>> "Fix TSO for idpf" sounds like a bugfix? Can it be backported to stable?
>>
> Yes, it is a bug fix for a particular edge case. However, as done here, the
> fix is implied by the code changes in the consolidation, and depends upon
> them. Any fix for backport would need to be a different, standalone patch,
> based on this.
> 
> /Bruce

So the original code didn't have TSO at all? I.e. this can't be fixed as 
a prerequisite patch to this patchset?

-- 
Thanks,
Anatoly
