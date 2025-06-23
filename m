Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99780C7115B
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Jun 2025 10:41:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7743240267;
	Mon, 23 Jun 2025 12:41:25 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 815434021F;
 Mon, 23 Jun 2025 12:41:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750675282; x=1782211282;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=Rd5e2mxAwnf9ObYocnfBIth1l4QqQXu7/qDcCJOxZkY=;
 b=AaBu27Mhm0AQe1FC7T7K0M2M3UX2TLJQ5nqugVBkhCM4OVPnQOsDSU24
 Czlf0o9z4QXEdS7kylZwrIQYU+4KzAabmFzOhI6UDuqsZ+DfLE1i+zFAv
 M+R+ACAulBw4fc4qihlycNQqbiQH/JsFhA83UzYiRktnQV9h5AwcQaALH
 T0OLl2PrgWp7N7pbZndG1r/anY4b/yGZpaJ7SxR82X5RDF2Mv7iT6Q9Q7
 a4aGEzvXa8RtPzfXiIbFY6cj0Q7WfAmbhL/6d7+HXWDU/wUcVMA3NMMrU
 SnNU+ZQpBSwxDZcJ+u9E2MTzBYLag2WJzR+HcvCDAL5bMpjKqBXiQx2Nk w==;
X-CSE-ConnectionGUID: jTw2eJgdQhKnIwO2hx7s5A==
X-CSE-MsgGUID: 9LMVJkIKQpWO52+lpN0kZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="63567281"
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; d="scan'208";a="63567281"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2025 03:41:20 -0700
X-CSE-ConnectionGUID: sXSm0cx9QEWUeWy6M0XxmQ==
X-CSE-MsgGUID: grJEKx1dRQaHymKHfLDlBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; d="scan'208";a="151713399"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2025 03:41:19 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 23 Jun 2025 03:41:12 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 23 Jun 2025 03:41:12 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.65)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 23 Jun 2025 03:41:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D91miMF1JrhcmKZ3OUeSMh4QMZuBfOdnbzeKY1rrTArYRTwmZW7DOJZNpJlBgiDgrDz3q63ZIy3bBXR+4NC7xOtLORyHSD4xCCn8+tdr3TKAe+P1h2LYVDglTyEnkOmcFP7alJDQNRLAftNG0aYe0NkHfBvHjAiikiryBg8hD4e21HGMFoW4W/Qrjk87/dMhS7jKXVFj4/3ZJjWzgb1LVKY8743LC0fwUpwdaYUkGy9hXevgaYJDPrNnXXHmQ0vQhjWWmhO56tJo9/Vk/7gpaqQNqxJEzM8SaJtLZKx9RQfhm0iaYBJ5TETHc2yC2M2lOnTm76idHyRiMlSBrsM1RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O7qQ8nWN5qCMGZXX4JyfKDa32kzZ8Rj/jtcfcTBTdxQ=;
 b=X2TbolLINNQtnEL48J+AHYXFYPEUuSj5xlrob8sCBrHNx5BCj/fiiaM+wWVncSqCMZJNDNh320D59zoGwwtciajEAaeDklevOp7i1KKhSRNaTMIO8r11AZDAADf0NFiymerKDlhfC8NrB/ZZIqElD6JbmuPEz3npO+861gwKvbpQrCUtpsb6EkHSpLPYlBWsZwei1BPThzqe4UojVP6brWrKKdQlvlTBNAurnwzukhzDJp33HAeTxkQw4JDcVNpdoBZHguA+9keBFDSSNUoPHlXO0kEPlDeJhWDkHU5FLj0RdsZOPbGPP/q0O2kA/IZHxH8n8dUBC5627Km2cRn9TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH3PR11MB8139.namprd11.prod.outlook.com (2603:10b6:610:157::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.22; Mon, 23 Jun
 2025 10:41:06 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 10:41:06 +0000
Date: Mon, 23 Jun 2025 11:41:00 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH 05/10] cmdline: fix port list parsing
Message-ID: <aFkvPJaO7iXJu6aM@bricha3-mobl1.ger.corp.intel.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250619071037.37325-6-david.marchand@redhat.com>
 <aFUw1gDuJNuJBnIs@bricha3-mobl1.ger.corp.intel.com>
 <CAJFAV8wsxm6RdNwNLa0AefEbhgKFLVhhRjDmnTZc4p9-mf489g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFAV8wsxm6RdNwNLa0AefEbhgKFLVhhRjDmnTZc4p9-mf489g@mail.gmail.com>
X-ClientProxiedBy: DUZPR01CA0036.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::14) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH3PR11MB8139:EE_
X-MS-Office365-Filtering-Correlation-Id: b6b5c24e-25c1-4ccf-80f4-08ddb2427541
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bUx4Rk9ZWk4vYy8zWVFYZWtNdW1wY2xSZ1BGRnNiL1pNUDhuZ1FCSTBwY1NW?=
 =?utf-8?B?Q2gwa1NjZDN5Y1BJY2xVcGRwcU9QYTJUTzkyNFcwTjJ5YjMxQXpkUy83WUtQ?=
 =?utf-8?B?OGhEQ2lMeXFaNFVmUmI4azJ1aC9paWlFYklCejltbFBuRWF5OTl6djFaNjRm?=
 =?utf-8?B?VGtTRXBkVlo0dHVQcndDYmM4M0MySUloekZZUGdOdWhxSklEOXljanNiak1k?=
 =?utf-8?B?RmhKdUhwbStYajdWK2tPT1FGU1IxR2QzZ3RKVndsM0dlZ3RyMUlINHEwb2pV?=
 =?utf-8?B?Qy9IZW5yOGVzT2pVYjdOQ2t1YlY1ckN2bUtENkJ0ZExxOE0vQm9raXNQbFox?=
 =?utf-8?B?TmFFazVCeEtzN2UwUk5DY2VVTWlCZ0cxTlBvam1lY2dwcmRYTzdrc1oyOE50?=
 =?utf-8?B?djhiTFpPeS9FZkJEOXc4a3grMWk4bTMxcTdjYzg2UmFJdzF0UGMxUDljd0xY?=
 =?utf-8?B?bXN0ZmZacnVoaDZ4SmNIVm5CeS9FZnVYWDBueE5EQTNUMUQ1VFFRZVZpWTF2?=
 =?utf-8?B?RGpVdWVtdEZWMExQR1lXUUY0V3VBRFNPazlIMlJvRUdQR2pOOW9aYTI0ZEJJ?=
 =?utf-8?B?VDR6SUk4MG9ycEtkaU5CTWFDei9xZ0JPdWRqUlFaaXZLQU9ETHh5QmJPck9a?=
 =?utf-8?B?SXZyWlJSZUFFT01OY2x5YWJQU1hiTldOZ0JzbThsZEdsTVVMWGhJeUs0QThR?=
 =?utf-8?B?Wms0a1ZPRkplbzVScG96L3lERmkxbmxhcFM3RjNwVW11L1ZjbXZWUWpEVk9P?=
 =?utf-8?B?MXRGdXFxOFdvSGJUZlkraExxMGdkTDRZSTNzVkRnL2s4bFpBNHZtbVdGdlpy?=
 =?utf-8?B?TDd5dzBnSENuL1MwTU9kTlFQUjJYR1JVeFFnUEdMeml2SzN0aFViTmk1YWNx?=
 =?utf-8?B?T1lGWU1SMnhlaUZyZWt0alRSMGtHZzdDcnRqejFTYzgxaXUwdmNHN2ZaWWkx?=
 =?utf-8?B?d0hxTVoyeUd2ZXFkcnFHZjdUVy9wa0VCaTRBaDVWTUU2RGl0YzFBMW9SSGtO?=
 =?utf-8?B?YWpVTGlUQ3VuZ3I0bEVKZE0wSWFnMmtlQzFqeTFvRTdwRHA1aHNSbWNPS3ow?=
 =?utf-8?B?bWhvalBESldvSkhuSTdEbnF3YnFERzdYb3BHaFFPdDgzc0syMnY2Vi9iYzlv?=
 =?utf-8?B?RjRuRm1rYXV3TFpHT2EwSExWOVRqT0hyWHdYZjZCeWcrano2RksrQk1XZ0dV?=
 =?utf-8?B?MDNVY1BEa1pRTC9mcnZaUjlmR2x1VUp0T3Z0amlxSWxva3ZQVmRyUXpaa1hE?=
 =?utf-8?B?K1dxWVU3Qm8zN1c0VmlIWUFPZno0ZlZvWXBWWVFtM3RvRnMxS1hpMlZXZmZ0?=
 =?utf-8?B?b1hJVHpwd1g4V2pKSUdNVytEOHROMkpXU09QM1VTbWhsbCtVeTlyckVXMHJl?=
 =?utf-8?B?ZXNvSUVnenMxVERHQVZyMXVhUnFIMi9SWXBlSytwOFU1Zy9QNTlLZ2NtU251?=
 =?utf-8?B?emMwSVVkVWZtNndSeSsrS1c3UWVoendRUWdsVmc1MkQybUd5VGd5WTI5eUdU?=
 =?utf-8?B?WUF6VmRmOHNDWjJqVGQ5RHdaZ3MyVnBLUktheU01ME1NaTBXM3h3ZVpsYjV2?=
 =?utf-8?B?VHFwb0FsemxJdDlMbXpucjdQSUEvVjdxOHdUTHo3SjBYTVRLcFBPUmVSZDFP?=
 =?utf-8?B?VGxxdVhUMm0xcGhnVXpKcVBjVmRiWGRzUzBjS2Jya25lQ0NXZ2RyWUt5S2tF?=
 =?utf-8?B?UVlTZ0ptVG1hT3duQjUvWGdyVnRUREVqajlSdnVpdlNhUUZhZGpXVjJBTFRY?=
 =?utf-8?B?ZFMzVDE0MXcyOHBZbEJPeHVnZ2lVbHB4M01LWkxveitJa0tRUlR0VmVBRFpn?=
 =?utf-8?B?MndXZkhBYjhOVzdSMVZsQUluK3M5TlZ3R3B2Y2JuNmxmLzZVdngyL1gzaTJy?=
 =?utf-8?B?V1lKK0dOTHdtalhTYzZxU3JNRjIyWVZjVnluOVdKeE54T3hocVVvanV3TVli?=
 =?utf-8?Q?DnJwpMeIOnw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWRJOU85czNSRC9sUEVEcTNmcERpWEpWUGNsSkd2U2hnYVBwSEhzOXNWTFBM?=
 =?utf-8?B?blk5UjFGNkJFeVgvOW5DODRjVUtrU2FOclJoOStHQUU2ODl0ZHZ2T2hjam5K?=
 =?utf-8?B?R2VocGZsNWRQYlhFMjViTkt5STY3RkI0V1lOS3M0NnFnTFRDMnd5dVlyM3F1?=
 =?utf-8?B?VDkwQlNjbWM2enJqSEpIS2pHQVlId2NLVU1UTllaTnVRUGdBWnFXRUFUNUVo?=
 =?utf-8?B?TmdsbUdoa3BDdXVEeXhVYTAzNVpPc3Jnbi8yRnV0bTltNVh5K3lwSWthZmU4?=
 =?utf-8?B?cHJsZkRHQ3BnWERQeXZ3akpqcktnbkpxR2NZVHA3YllNdHQ2cU5Bc3V5aVlx?=
 =?utf-8?B?ZC9ZK1JaUTVsbDQ5VEtxd1RNamR1RlRwbjVIN25Zd0dwNG0yMjViRGdyWlBH?=
 =?utf-8?B?eStCeXJXZ1VKczRMQUxEendJVG1BUnh1VkswSzlSbWRVSGxCOVQ0YVNtSlpr?=
 =?utf-8?B?N0QwdUV3cXp5aEtaVzNHeDhScXZZV1hIRGYwcFVjUFo5SzlBb3ZLa2hXdVc4?=
 =?utf-8?B?eTlxVzBBNHN1UlBXTkJobjVXVHptY2twVnZETlczQ0lNS0xPV1hsbnhMZlFj?=
 =?utf-8?B?NmhOTjQyK21hV28rNE1lWFZKalRCZENaeDE5b0Z4NEJidVJrYTBFamxROGZp?=
 =?utf-8?B?TFRvM0dDV05jSnp5VzU0UVNFSDdPSjhqcVVkd0tYeTAweWl6ay9tN2QzVVdu?=
 =?utf-8?B?V0RZMGUxQ2pYYm5aZHlsQUJ2czFWTCtONjVZdzhNVjF3TnlwZ3dHRUlHWGlw?=
 =?utf-8?B?ZzJmZ2lmRXZVVy9sYk4xVHBSUVZQMVl2Tkk0MTNJM1lmS1FMaVlMZUQrMVds?=
 =?utf-8?B?elpiOHQrb3hPSkNvUjNwanFmaDkxYmZHSEZmREdSWS96T2ZwZ3B4K1V2NHRJ?=
 =?utf-8?B?ekNCRStvVGZHL3JHNlZTa0dvaTJsSmJnUHZINzJlM29FczM0MS9Mb3QrSXBp?=
 =?utf-8?B?RmNXR2tleElyY2pSYlNrb3pVbkpNeTNBYnYvM0dmUWlUT2pITm9qSjZkL3lX?=
 =?utf-8?B?c3JGRXpCOWFJOVZqemR3dFpuL1RSc0dGcFI1VVB1RnJBMzI2ektYWlhsdk5J?=
 =?utf-8?B?dWUzWDQvdmdaaURHbXcxc3hEWTk4UDh5M0FnaUk2ZDVMeFhhanZsdkdEb0lt?=
 =?utf-8?B?bEFJNHI4V1NkWnVvV1dyM0pjYmgxVzZnVzRoaForODB0OUY5enpPNEgwVGEx?=
 =?utf-8?B?ZGI5cy9zNnJ4STUzVWRtK3N0V2gwNU5wZ3lRWFdZYnNDcjRxVkJuTnMzbS9x?=
 =?utf-8?B?UUFSajFUZEVITzBzd1pPZzAwc0M1WlhIMWFKYWN5MDBpRWpkMHl3K3UyYlhr?=
 =?utf-8?B?YTdVOXU0dWtxR2ZpZ3JJTjd4WkljVTVMcHZidFh3N3B2ZVFpeU9tUUlXTDFi?=
 =?utf-8?B?RmVKNGRkRi91KzJlOEtYN05uWFU3c1BRdGhqTXcyVFU0Q0srL1VJWlRQUy8z?=
 =?utf-8?B?UklHKzk4a2lqUFhlMldNREU3bnVBbnlid3ZMV0JnVmxLcGU4TTlyaFl6RnJR?=
 =?utf-8?B?M2YrSEJCTkVEcW8yMkVSUjBCM2NpZTdQcldSeUVJS0Vac3FuMUl1MGp0ZDN0?=
 =?utf-8?B?d1hEYy9TL1pkNGpWNWdpQSs1L3Fsc3RIdHRDMDZGMjNuajQyNjVYOXJFQ1Jt?=
 =?utf-8?B?ZWtiUHY5dW0rVTBrRUxpWmF6bVRsa0J2MFZhMmduQ2R3YkQ5QnJUclZVckFk?=
 =?utf-8?B?dnZZL1NvNXJ2dVRaeXl0Z2V5SXRUWEN6MktObldTcTlTaG5JZHBxNHdKSVl0?=
 =?utf-8?B?N0c2cm1RL1F4V2lqRllVYXlmN2xDc0t4L0F0RlhPQUZDdHNCazZSdDc2SXgv?=
 =?utf-8?B?SWQyUUVjZ0NMWG5QWHNsVFJuQ1VZWDJpc2gvbGdhMS9kcXJCVmgyTFRvV1lr?=
 =?utf-8?B?NXJFMzNZdEMrbUQ0VWJXMm13TTlZME5LUitzWlQ3aFFxUzcyV1RWZXpGOWF5?=
 =?utf-8?B?WUlHTi9aeGh1NEhtS1lFMEcvYmtIaVFPQ2JFTUM0QXB2aGMvaXgzVGlVOEts?=
 =?utf-8?B?b1VRREpEaU1iRlpDUUNJa3JJNnJzb3Btc3hiYWRjR0oyQ0xUUG1jUHBUMDRv?=
 =?utf-8?B?OVltYm50OCtsZFBDVFZuV0pvNGxkd1VnMGVncVRWSTUrVzJtWUV3aW42RnNU?=
 =?utf-8?B?WnA5ZEtIdUR5ZU5PcVdGMHpteC9oU28zdmVrY3h6aWVtMFdXSW82QzJuYjZj?=
 =?utf-8?B?eGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b5c24e-25c1-4ccf-80f4-08ddb2427541
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 10:41:06.4237 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dGaNB8lJjuzFc907NJoYvGXUFZODel2QtJ4R0dZKZeMRluPATsIdYaiylWAV7b5Bq0paTv0LTWJH//RgIJrXwc7NiltB9Qwcr5uyc79XhMo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8139
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

On Mon, Jun 23, 2025 at 11:40:15AM +0200, David Marchand wrote:
> On Fri, Jun 20, 2025 at 11:59 AM Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > On Thu, Jun 19, 2025 at 09:10:31AM +0200, David Marchand wrote:
> > > Doing arithmetics with the NULL pointer is undefined.
> > >
> > > Caught by UBSan:
> > >
> > > ../lib/cmdline/cmdline_parse_portlist.c:40:19: runtime error:
> > >       applying non-zero offset 1 to null pointer
> > > SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
> > >       ../lib/cmdline/cmdline_parse_portlist.c:40:19 in
> > >
> > > Fixes: af75078fece3 ("first public release")
> > > Cc: stable@dpdk.org
> > >
> > > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > > ---
> > >  lib/cmdline/cmdline_parse_portlist.c | 13 +++++++++----
> > >  1 file changed, 9 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/lib/cmdline/cmdline_parse_portlist.c b/lib/cmdline/cmdline_parse_portlist.c
> > > index ef6ce223b5..0c07cc02b5 100644
> > > --- a/lib/cmdline/cmdline_parse_portlist.c
> > > +++ b/lib/cmdline/cmdline_parse_portlist.c
> > > @@ -4,6 +4,7 @@
> > >   * All rights reserved.
> > >   */
> > >
> > > +#include <stdbool.h>
> > >  #include <stdio.h>
> > >  #include <stdlib.h>
> > >  #include <string.h>
> > > @@ -37,10 +38,11 @@ parse_ports(cmdline_portlist_t *pl, const char *str)
> > >       const char *first, *last;
> > >       char *end;
> > >
> > > -     for (first = str, last = first;
> > > -         first != NULL && last != NULL;
> > > -         first = last + 1) {
> >
> > Maybe I'm a little slow this morning, but I can't see how this is actually
> > a problem. By my understanding, the check for "first != NULL && last !=
> > NULL" happens before any increment of "first = last + 1", meaning we are
> > guaranteed that the last is never null when we increment it.
> 
> Well, not sure I follow, but the problem is not at the first
> iteration, if this is what you mean.
> 
> On the last iteration of the parsing, there is no , left in the string
> that is parsed so last = strchr(first, ',') makes last == NULL.
> Then the first variable is set to last + 1 *before* evaluating the end
> condition.
> 
> I removed this patch of the series, rerun the test and I see:
> 
> 9/75 DPDK:fast-tests / cmdline_autotest               OK              0.22s
> 09:20:08 DPDK_TEST=cmdline_autotest MALLOC_PERTURB_=169
> /home/runner/work/dpdk/dpdk/build/app/dpdk-test --no-huge -m 2048 -d
> /home/runner/work/dpdk/dpdk/build/drivers
> ----------------------------------- output -----------------------------------
> stdout:
> RTE>>cmdline_autotest
> Testind parsing ethernet addresses...
> Testind parsing port lists...
> Testind parsing numbers...
> Testing parsing IP addresses...
> Testing parsing strings...
> Testing circular buffer...
> Testing library functions...
> Test OK
> RTE>>
> stderr:
> EAL: Detected CPU lcores: 4
> EAL: Detected NUMA nodes: 1
> EAL: Detected shared linkage of DPDK
> EAL: Multi-process socket /var/run/dpdk/rte/mp_socket
> EAL: Selected IOVA mode 'VA'
> APP: HPET is not enabled, using TSC as default timer
> ../lib/cmdline/cmdline_parse_portlist.c:44:19: runtime error: applying
> non-zero offset 1 to null pointer
> SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
> ../lib/cmdline/cmdline_parse_portlist.c:44:19 in
> ------------------------------------------------------------------------------
> 
> 
Thanks for the explanation. I was indeed thinking the issue was on the
first iteration only.

With the change to fix this, we can actually make last a local var within
the loop itself. Also, by using a while rather than do-while we can remove
the initial check for str = NULL. Here's an alternate fix that is very
slightly shorter, and limits the scope of "last":

diff --git a/lib/cmdline/cmdline_parse_portlist.c b/lib/cmdline/cmdline_parse_portlist.c
index ebe2a961bb..c65f3b704e 100644
--- a/lib/cmdline/cmdline_parse_portlist.c
+++ b/lib/cmdline/cmdline_parse_portlist.c
@@ -34,14 +34,11 @@ static int
 parse_ports(cmdline_portlist_t *pl, const char *str)
 {
        size_t ps, pe;
-       const char *first, *last;
+       const char *first = str;
        char *end;
 
-       for (first = str, last = first;
-           first != NULL && last != NULL;
-           first = last + 1) {
-
-               last = strchr(first, ',');
+       while (first != NULL) {
+               const char *last = strchr(first, ',');
 
                errno = 0;
                ps = strtoul(first, &end, 10);
@@ -65,6 +62,8 @@ parse_ports(cmdline_portlist_t *pl, const char *str)
                        return -1;
 
                parse_set_list(pl, ps, pe);
+
+               first = (last == NULL ? NULL : last + 1);
        }
 
        return 0;

