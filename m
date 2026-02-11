Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB6F5EA3F27
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 15:38:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D667B40654;
	Wed, 11 Feb 2026 16:38:15 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id DCCE2402AB
 for <dev@dpdk.org>; Wed, 11 Feb 2026 16:38:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770824294; x=1802360294;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=vX2TwSXBtqomZ5NdlJ4kxyg6I/iE8ca6+mV6JFE77BY=;
 b=eAbq3wcAUJPlAvBa64hLfNtckYyLfqnBuhD7Kn6uDwfetFfHMwhO5hY1
 q7mv5/O29ljcH6t00xLOxnpwA5Z1VuqeL9ua+rcgKECi2inEEXC32z5MV
 3TiF3B3mZnDgGfeE2J320QZwYSi6E09je/dO5w0LisTNaWeR8FmSRkOg0
 zuNlTpWAvowkLFS23Del5Hrlp4dxFiHUt/zo6PVIjzYILhoS1ndlnBmSt
 gkKGfFdCHHqlgYec8PCJ5IdEqd37iDRWGSl+xbrI7gj2DnfXsjlgBX2VQ
 51gk7gwUSDQnRCk49T6oDv1Ikl8ODi3If99StL/R7CEekUQVeRB1YwI0p A==;
X-CSE-ConnectionGUID: 35t80009Q3Ky10ghwNuI7w==
X-CSE-MsgGUID: 89sJi5v5SoWoR5kZ3cyEIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="59542049"
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; d="scan'208";a="59542049"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 07:38:13 -0800
X-CSE-ConnectionGUID: Dl/llFsIQeKcY1P3S3D8TQ==
X-CSE-MsgGUID: UgGMbzr1R0G1HqxmDd67rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; d="scan'208";a="211203607"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 07:38:12 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 07:38:12 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 11 Feb 2026 07:38:12 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.14) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 07:38:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g2+4OLEy8EgOwY+5MLRQlXKIQlkO9Baxr70iK5wgx29ZYcfW36JiIkS3xx2tOvskG3muvu8qi9WapeBIySqPp+k3kutq7BG/9qtO5saxbVK9Hktj8jmnaP7XB8WQnoa3JItT8wWonS/8XLAE9WfayiBSusyJYWbSrENHhBkzZuktUtU5EwmahxCBpoH3/6nf+zqlbZVmb28OYzfwqIlWseVVeN9duziJtX4SsWaEplmaOEGdwcOyVmDHllKbDtfIbgG7hsmTxPHmnJFtOA/jzDf94tCcf+HO9/5L+7ObI7m8iDeUlRVczueQP3rwfmxj5in3dcRkH2RRKKjYmrJLKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hmQioCUeI63liyHdy/Jaf7FVa3trwL3Elir87V8+Ors=;
 b=aLc50OwTQB6FtyHFJBipsEwGmdMXXCR9toa6DT++aIII6PmBB0NSrBlD7zMEWi2GlhMnx7rNZcT9ZFvR3fnR5wBZjZjQbNGrJjHcygKTKgN0Xq7PWFmHBFGVSWdyHchuSH9Q8ajohztK9w68gFPT83BSJXFHejJOw6xdTW+9jjoiKn8wmXDFiEuPTnn2jZJS6X/xaRgfMNMpn6TX/bHPFinrPi/WzpjFnPeNNPYEmy9WXrFa1kGawNiS8t5G1lLYBRsSzlJJvnoees6hbhz8xlL5godKY+lYKOuPGdnGCXxuTP2jOZSLee2mOv5KXOJt7wsWAL1/M4/M9iQfslJBHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16)
 by DS7PR11MB7689.namprd11.prod.outlook.com (2603:10b6:8:e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Wed, 11 Feb
 2026 15:38:09 +0000
Received: from IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2]) by IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2%5]) with mapi id 15.20.9564.010; Wed, 11 Feb 2026
 15:38:09 +0000
Message-ID: <1aa636da-643e-4ed4-ba28-b88b2e387f98@intel.com>
Date: Wed, 11 Feb 2026 15:38:05 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/9] net/i40e: move FDIR config to flow create
To: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>, "Bruce
 Richardson" <bruce.richardson@intel.com>, Xiaoyun Li <xiaoyun.li@intel.com>,
 Beilei Xing <beilei.xing@intel.com>
References: <e7405e765d04a5e5e9b86778b088596fed4bb9c7.1770817694.git.anatoly.burakov@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <e7405e765d04a5e5e9b86778b088596fed4bb9c7.1770817694.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0044.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::7) To IA4PR11MB9204.namprd11.prod.outlook.com
 (2603:10b6:208:56d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9204:EE_|DS7PR11MB7689:EE_
X-MS-Office365-Filtering-Correlation-Id: eadb6316-f0fb-4f57-73b8-08de69838ea4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VHYwSUtPWVhWSTZVMmhRZ2N3QkVHRUNkdjlHMGwyNHRNWW1WVnhHWXFpVnJj?=
 =?utf-8?B?T2ZxLzNyc1ZkWllxZ3h6NkUxZ3VlWVVJUi9Hczdxem1yV045M01zYkM0dzFU?=
 =?utf-8?B?cXlOUytUR3RYb2RKMWZQNzdONHZHUGdobDZ1QStoWnBWOVBROVE4cStBaGdX?=
 =?utf-8?B?Wk5SUGt6TS9ncmtWRWM4Y2xKdUhuQzZlNGNEa1Ftb3hxSWpmSFFuL045dVFu?=
 =?utf-8?B?YnJVMGxMT1V5bW81b2lBakhjNDIyZDVXMVkwbjZsK1NHRGxlRDA5MTdPejdt?=
 =?utf-8?B?WUVoT01iR3NnZzhQSzhTSnB4bXRHN3FDZ2ZXY3djelNQK2cwT2JMK21RSWhN?=
 =?utf-8?B?YTV4QVhGSURHOGtubDUyMHVod0VZcEdjc0N6TXI3bnNhSFNpdkYyVFFSRnk0?=
 =?utf-8?B?bUpzV2pwQ0NUT1M2aFhkMW1yWmRlWHU1Sm8vY0Q5Zy9SL0VsMTdVQkpBeC9P?=
 =?utf-8?B?aUF1MFJ5VndGeGQxQkRJQ282Zy93K2VhcHUzRlZVVVFBUUJPMDNia2lRMnZF?=
 =?utf-8?B?RzYweGlwd2FqMnBMazk3aGVZcnZkY1VFY2VMNjNYSDhscnFJaXoyLzZMU0dp?=
 =?utf-8?B?S3I1cUw0eEVNY0laVGFCemc4Mm9kVTRBY2tGcWlraVBxNi81Q1hrUTNlbEJQ?=
 =?utf-8?B?Tm5MYVhkVk94QjJDcndqOHZuM0ZYdzhSNThnUE5ZUXRtK3NGZjRsaGRzeWQv?=
 =?utf-8?B?RWVqY0RqOWIyZDkxeTRJd3hza0h4QWcyQ083ZEpFcXJZdmtPSG9LWGFEZXpZ?=
 =?utf-8?B?Q2ZHU1NhQkxjRHlKM3NkUTgxREg5Y3MvcGxEd0NSaXl2b3JqaUVjOHJhUktv?=
 =?utf-8?B?Mm1zZFZyaFZOWU1oNk1aUjlmcDNRRjFFSGRkaE9iMjRPaWVxSis3RDNWbEZl?=
 =?utf-8?B?US9zMHZlSXVJaWVKNS9qOWp2Z3B2akIxb29UZXFrT09TTHRNRFJtOVB4eE5m?=
 =?utf-8?B?RktHem9ScnVRdFo1ZTd5UnVNM3hYVWxoS3hYaFFPZFFhZHF4UWZkSTBDSW10?=
 =?utf-8?B?enVLT3g1eDVjVTZLWlhiaEIybEZOcEttOVFCQmVabVc0c1d0S2Y5MHRyRFdV?=
 =?utf-8?B?cldxYW9SVklXWTdTcWdvM0Q5djJNWTdma1A0Z3FjTis4QlBONTFIM1VNVm1C?=
 =?utf-8?B?Y0FOeW92eEdEUHhXaHlKL1hvclhmZXFmM253VTNMbEJWQU8zWTcvQ2EvZ0xD?=
 =?utf-8?B?Q211RS92L0FGcGwxejJ6eExKd0xHTnBDYmpreW1hZklGZjZ6NWhqUUpoVU1m?=
 =?utf-8?B?Z0ZackN2SXh6cXJrL2hDcEEyUmZiMDJkeUlzYkVVQUhRNXE0N2lyUzlaMDVq?=
 =?utf-8?B?RG4rUU05dGhHWUkrYmlHZjNONTFTRExjNTJzS3pRWDJvUFpoTUFweHoydjFh?=
 =?utf-8?B?Ym1IRzVzK3lKUTZpbkNCeFA1dkpEUC9SVlhtczNuVXE0OHJJbGtHS1YvbnVu?=
 =?utf-8?B?Q2o3ZjdGdTd4TG9ON0hORmtjYzRzVVAwN096d3BORFFCZnR5TUZnSWx6Skxz?=
 =?utf-8?B?Z2xlQnd1U1RvUHpwSnZRRDd2NFVNdmlJTU1hL0xpRWFuTDY3K3FucnJldkVm?=
 =?utf-8?B?NFFWNmRZWDl2WDduRlZ1Z1Bna1hvalJlNG1mRHdPbDdYMTVwaWV5eGhPSXl6?=
 =?utf-8?B?ek90MDBYZ3MreG9Ba3lqNW42Y2hMRDRZNzJEditETnlXTDhKT3lNMHRxZ2ox?=
 =?utf-8?B?cm9CUHRGNFlBVitXV1pEL05WSkt5VjlnOS9TM0RLd3M1SUo2QXVJbWJYN05p?=
 =?utf-8?B?bWZxdUFCcGx3M0h0NUcreUNKOG9LRy9zeUZVbFpwdlZvalVNOC8xRFRrYk15?=
 =?utf-8?B?SFlmOGN2Sk5pSnZPcTRCMzYyR0llYzRVMmVEVEEwTk9RK1ZFemkvY2FKV0Jn?=
 =?utf-8?B?eEFoSmg1ZXEvVE5xZG8xRXp3VklsWVd6MTZ5VnZ4RS8rQjFzVFNSTjErRkx1?=
 =?utf-8?B?Vk5NWjBnTEhXcXV1THE1ejhLZThtZmxubHNKME5RbldrcVMrZGM3dkcwYWVJ?=
 =?utf-8?B?bTNpR3hqSjRlWFllMEZPS2JCK1hRd1ZuVmdmZHpaRnlHak9Pd3p2anhvc1Mr?=
 =?utf-8?B?d2I0UlpIOU0waFAzamlxMjZuVnVXeVlZMFVLT3ZNNjdEOUhMSGZrR1BPT3l0?=
 =?utf-8?Q?X+A8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9204.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NStzZnJQdyt0MjNGZkhSTksrSlNHUlA1WjFyZFpaWC9NdGl5RUJ2dGtrWjN0?=
 =?utf-8?B?VDl0Vm1SSkRjVGhySHE1ekpEZWxMb3lNSzVjZ3pFSyt5bWxxQWtva0VXWkIr?=
 =?utf-8?B?Vm9OdFpaQWhBQWYwaE0xVGxqWkVBa2hPeGRuTTgwZWlrRHYrNnZJRC9JR0Yy?=
 =?utf-8?B?U0FGREVzRVo4UndNWlBEaHJ1bHFYYnowNHlJWmJrLzJ0cllFOWlNUENtWEZW?=
 =?utf-8?B?NFpiTldvaGt0d3RUTDVZdExWcVRBdWRxOWd6N2htWkFtSW5ySTdMeHJ6U1ZJ?=
 =?utf-8?B?WHNIUWZBSjRVYUNXUkJSQll4TnZtMUcwdTZNNThsWXFXN09UWFNOb3EzZndr?=
 =?utf-8?B?MnQ3M0RSc0xHOFAwT0pudDJKUE15emw2S0FJMGRaUmtJdkk4K1VuNWtOMFZr?=
 =?utf-8?B?RkYrVnVxNFkyWDVPckFIZUJ5c3NNRFdaNzNTZFVLM3VEVDNseDFYVFlncm9L?=
 =?utf-8?B?VDZZQlQ3d1FjUGZNdlJrcGY4UmxsZVFQWmozZzFzL1F0bzlmMXdYNXIxcHRG?=
 =?utf-8?B?WG1BRGViZlRHdk1IVTdKb1l3aWs4MCszNDlrVVJoU0lrckl1Qmk0YVdoY1h4?=
 =?utf-8?B?RjBVdEpqdW0wUWJhdEw4Q1VBSHprdWZ4QmNkOUZRR3RRajhkM2IyL1hqSzly?=
 =?utf-8?B?c2YzWk1Sdk43UkxpS0JvK3REclJ6djI3Ykh6bzBSNzVmcTVMKzMyd2Rzb1h5?=
 =?utf-8?B?UGpxUEViWlJZcmNtS29TU0txVStjQ2o0dk13WDdiNXVwWDh1ZjIrcVBMZ1Ri?=
 =?utf-8?B?U2cxbURISm9GU2pDSmh4RkllanhGRktsdzM0SllpZHV3UU1DNkdoWmpoN2Jw?=
 =?utf-8?B?aEZzM2c4eks5Vm4rZXNsS1B0RGFtb3BtcGdMOFdZTVByQnFkNHhqaTM4R3BJ?=
 =?utf-8?B?ZGpoWlRMcXRMN0hnNFkyRVRWZUlCaFUvWnk5bEhKNXBNcVdxTks0WWMxQnB5?=
 =?utf-8?B?ak5vK1BuSHdUdHhPWFVXRjVNNHdFM1dwTFNySU1UbXJGcmo3bFJBOGtFWGtL?=
 =?utf-8?B?dnUzb2IxcXdoVlJwWW5QcHhrb0NaT29xeWRpNFFSblkxS211K25DdzhSOXdq?=
 =?utf-8?B?Q0tlQ1g4LzVhM2Eyand3ZkJteGtydXNmTCtmN3UvT3NlT2NBWXpJUkV3Z09m?=
 =?utf-8?B?ZVVIWE1LdnNzYjJWdkkzb3hjSS82a3BYYmJlZTVWdEZlRUhSTUZlMXFiNkE4?=
 =?utf-8?B?b1V6b0VmQ3dFUmNBNXdCWnNBMnBDdkpnS21TNUJiT3EySXY3WE11Wkorb00v?=
 =?utf-8?B?c240NzB5ZXAwOXRnRk13ZkV3eTQwcFBQVzI1QTdjYXVSZlRGN1d5eFEzM2Qw?=
 =?utf-8?B?THQ2MFE5NTZ1dUVTZUNZVDBGbHBFdlFlMit5S2VjaXVmdWhTcXg1YVVoN01s?=
 =?utf-8?B?c0ppTmVYRjZ3Z1RBNElGVHdaYURZdCtqRDFMczJSZEIrb3M5QzV0UVp5eERa?=
 =?utf-8?B?TkpIMVdQdFk0YVYyeXVJRzhpMzhSRXV0OXhEUnVOcDNLNWFtRUQ3WS90S3VJ?=
 =?utf-8?B?OEx3aDJUZWJSV3E5Q1ZvVTJ2VzNlbWNIVFZ5MXBFNndKaUVMczcrSkQwb2Jh?=
 =?utf-8?B?K1RjV01YUXpxUEVvZFRYMllTV3ViRDNRYit3U1hCNEtnbWcvcFpER3VWazlO?=
 =?utf-8?B?Rk5UZUlPZjYwSE43ZWtZV21aQkFzcEV0bENxSU0zTk1jRE5TWWZ5b1hDRFo3?=
 =?utf-8?B?emROY2wyUzlmNGExUnNWL2lUZThyeEFBa1pSZXVKSjZuRjlLdm9vTHFhem0z?=
 =?utf-8?B?L2ZvVUNCckJOQUIzLzBubEZxMnJTdXc5MFllN1FZQnNZVEdaZTYrbWpiZjVX?=
 =?utf-8?B?bUZDbmVuYjRiaDUwL0NoenliL09yQi9HbktOWVpmZzg3Q3YzYzlFZ25wcmRB?=
 =?utf-8?B?dDVUc3hjazhUZi9WYnkyMmFadzkrZlc4RlJ2V1NldURkTGZQWXlIeHZDd1Er?=
 =?utf-8?B?eFNTUEZnb2lSUWpwQzJqK24rUUN3NmJ3bTFIVno0OHRKaW1wd2VCSit2cllY?=
 =?utf-8?B?UWFSdTVZZ3o3WkVPdjcxVURHWS9UTVVxMGEwRmQzbGdUMVZjSHB3QXpjZXlO?=
 =?utf-8?B?Z0ZEem5hdjQ5UzZCaGtuMTFwNXJnTy9sV2dKK1p3SDNvYmp2bzVtVmdrOUJ5?=
 =?utf-8?B?SDVzNi9JRnFVeG5UZS9BUHJzTTJSblRRSEkrdllQWWpWUnMreVp3YzA2eUtZ?=
 =?utf-8?B?UkFsWlNPL3RuMkdLeko1ZkdOOWlSRk9Fbi9oMVVuNDZsNnJsQUVxSTc0dHNL?=
 =?utf-8?B?RldGSHNzcUk0aFhmbTR0dHV0MHFlVTlLRzRJSUk4S3VwUGN6MnpZUksxLzJX?=
 =?utf-8?B?OGx0aHRGRmY5blVZYlNqWmxsSWoycWhRWUVrR055NkE4ZG9NSHduaUZURHBW?=
 =?utf-8?Q?912uP9z96YUDb1Jg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eadb6316-f0fb-4f57-73b8-08de69838ea4
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9204.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 15:38:09.1057 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5YQNQpIfZZIC+1SIMaIde1D/1o4oydzZwOIa61ZVUfHX4jxp7m74i4/zaONtPvK17Vzp5bxXc/Gsjg+XmlGAlNNZi/cvOPrlsiiB9dsx8GA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7689
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

Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>

On 2/11/2026 1:49 PM, Anatoly Burakov wrote:
> Currently, FDIR filter parsing function will modify FDIR state after a
> successful match. However, this function is called from both flow create
> and flow validate, which results in the driver modifying FDIR state after
> a flow validate call. Move the FDIR config to flow create.
>
> Fixes: 2e67a7fbf3ff ("net/i40e: config flow director automatically")
> Cc: stable@dpdk.org
>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>   drivers/net/intel/i40e/i40e_flow.c | 51 ++++++++++++++----------------
>   1 file changed, 23 insertions(+), 28 deletions(-)
>
<snip>

-- 
Regards,
Vladimir

