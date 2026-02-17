Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6991AE909AC
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 14:23:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2994E40261;
	Tue, 17 Feb 2026 15:23:19 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 1BC8B400EF
 for <dev@dpdk.org>; Tue, 17 Feb 2026 15:23:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771338197; x=1802874197;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Ax1rcHdTZsYqi13nvixlpwHmBrVBrY4I6GdNQu5GZLw=;
 b=iZWKqi5oo4BXSFA3KFNqqisQOqJiYddXspPo53dJ27eM9/138LArWChc
 oLVJSuLp8992s//PUMBPdxA/TJdBy1rKp10W2+OfDul9gg8720NvIpTk/
 PpELOZR47UdL0Rg/ILkw8IjBfFtuIg8wCiCjDT+CiIl9+iN36F/jOSOAU
 HtqD2lz/7MwO0epyZ8UKZ+TvQS1yLfMtL/zJYtr67LWuDeSctLc5e43Xa
 9BdTYUS5qKWQSMIo8MjRvSKJlqVu2PjwaSbLa0Ls4BobX1HO+UNKuDo+g
 W6K9JeHX1h4izjOobdeieikhj6DjzVOLf3sCE451c131HCva0ByXFBP2b A==;
X-CSE-ConnectionGUID: 3UPsn9JKTNSOXNUbMdwbrQ==
X-CSE-MsgGUID: f2MyEJwCSK6GpLqtG/jvVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="89990996"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; d="scan'208";a="89990996"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2026 06:23:16 -0800
X-CSE-ConnectionGUID: 6v+dd9pWRT2g/1J9EwdaRw==
X-CSE-MsgGUID: BP6gtO8zREeql0h7Snv8dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; d="scan'208";a="212786446"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2026 06:23:13 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 17 Feb 2026 06:23:13 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 17 Feb 2026 06:23:13 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.30) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 17 Feb 2026 06:23:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uMEEYOqXsS84P7v8Y0I4S5ESFbsxgvmYBpN+XbHaB75QDkRnXut6mjLEBUtbq9vp7ceDv+Sp+ca53wPnJ/A8udYPza2hRlAVLsZkuBcttDe8eREdbmX/mV0q99lJOtFXZbV2Fca4juBCUX8Pe/PgGQoO9FqCfQOT4N0CtcmW1fpCwB1oaoEt60lRVIz8Nrg1SKLTIKu9kdR6DtuZPoCJcK6a0PrkoFKmDdhFN2xarqNyR9d87wECr1ny7udRa+yjBHR1dcBvVmFRPSW+DWMdS9E1mYJ09ty+CkJMUws9UX7Holt/Sw8fSI7leIskLJv+hxlX02I/KiWm2Kavoai7iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Vy9NeVenCpUhLuHVIBGS29sugb9mvd9TJlGv+erIdk=;
 b=FWceRQVtBHiOoCeLHh6KkH6Qq6Wr5qhsScV6V3wvdX3uybei5N3WP66Q7Ey4LB98mOv9YvSZZCaQb9fWe5QIrlo2Ql6/NRsA37a7bmc3J+pO/5vbUN4MtDoFDCgue+FudpuKZ49sFqVYZr/yvzKkGc0WCqAMAtm7q+8arv/8KFNBkwEwhz7iZhh6U1TtACTwnsYJyiIJ2Mx6r91eoF+WCWdYqLupSNO8BBJEoyj/rx0vWKfGrG/Umg8YguF6wQF2iEK/YmmF8wTS4l9H/AqgN/0Ov/EkOp080B5gp0NBFbxEWJvopiO9pWYLduouRw8Ue0tCkX99oO6r5nYwDXF6pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 PH0PR11MB5077.namprd11.prod.outlook.com (2603:10b6:510:3b::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.13; Tue, 17 Feb 2026 14:23:06 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9611.013; Tue, 17 Feb 2026
 14:23:06 +0000
Message-ID: <0398b195-9597-4dfa-88ff-8c6eddc73b49@intel.com>
Date: Tue, 17 Feb 2026 15:23:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/27] net/ixgbe: remove MAC type check macros
To: Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
References: <cover.1770978324.git.anatoly.burakov@intel.com>
 <cover.1770978324.git.anatoly.burakov@intel.com>
 <f0047b363fea648bf7b6815889c0b26b883f56c5.1770978324.git.anatoly.burakov@intel.com>
 <aZNMy_1oOKYn-AZ2@bricha3-mobl1.ger.corp.intel.com>
 <d4d45144-01ec-4c6f-86d1-1ce65930e06d@intel.com>
 <aZRmDeO1AUlXE63L@bricha3-mobl1.ger.corp.intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <aZRmDeO1AUlXE63L@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0053.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::11) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|PH0PR11MB5077:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e77eaa7-7cf2-41cd-1137-08de6e301171
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Wit0c1lWdVo3QnlEM0xTQ2xRNklzVE1HOUhjRVFzMWFpZ3V0WUtTaTFoQ3U1?=
 =?utf-8?B?cHczb05qYzIxdGJqSU55MDRXTmRUa2tMRU9xRlpyZlhJN2lzN2U5OGh5L0dn?=
 =?utf-8?B?ajgyajFkNW4vYkcybERaeGpDczZTVDAzUmhDRVp6aW13dFFWRTBmbGhmckd5?=
 =?utf-8?B?VGllQ1RDMFdPTVdhQUZMRVNMd1ZCNmZ1YUl6ZnlLckhMblFWM2hMVE41NlA4?=
 =?utf-8?B?T3k2UitYbk1OUFJGZUpOUjllQjNJbkJ2T3IwWDByQUlHSkxUTzFoYU81bC9v?=
 =?utf-8?B?YkF2S294dlNPb3NTYjIzVlVJT2RPaDQyMnFQMG1JM1d5RVlUK0JUNUxjZTJ3?=
 =?utf-8?B?QmkvZkJnUE04NGpkUndpMVlCMXgrV2R4dXNFSGxmdDRXdkRJS0Q5clNOOXlE?=
 =?utf-8?B?UVV3ZUdZSjVkenRrUTBVN1NsWUpsZGE5a1BneUhIOGwwNGJEL0lmSXBmbG9T?=
 =?utf-8?B?bUpXYUJqL2pLTUxILzdRZHJnWjRUMjhQakV0eUo5MXBMRTRmTEVsMW9lbFgx?=
 =?utf-8?B?YVBWNWVzOGRGR1hBbVBDMHV0ZHA2QlZmLzdaelB0R0dwWmNvRHVZMVc3UWk4?=
 =?utf-8?B?enpYa2ZWdHA0Y2FuVjhWWDM2QllzRnN6ck9VdVU1SmFqaDlESzRhdDdSOGVt?=
 =?utf-8?B?VjByU2FEeHhyN21FbzdoN0ZzSkVyOVE0NHJIazVoV2tpRUxIaDQ2T1loS1hj?=
 =?utf-8?B?YmlMMkhvSW95bzFqWmhIWHFCVWxNbHVtTWlFTklmWXFGSy9UWTVjUnJuN1VL?=
 =?utf-8?B?ZG5PRDZtclVzSWRhWHVtMGlQZzUzdVR2NStuZTZzZUIrMXVicnJvTktRbHpj?=
 =?utf-8?B?SFVhR1VjOUZ2K1VCcWNtdTM5eG5iSC80Y29Qb0lvTkpvcm4zYTdpUWlzVU9n?=
 =?utf-8?B?Vi9makpqanVzdGQvMzlKSUluR2VrcElyYXFMZTZtaDNJTmkvTU5hdUt4NEZZ?=
 =?utf-8?B?WHJHbG9neVdtdGx6Z1UzVStZV3BSdzEzSjVqODIvc0E4dkxEblh0VStTWjZS?=
 =?utf-8?B?STV0aXh6NTN6NG1kL2N1MGxCdDdzUXJMTUpnY09wUmJwV1BudncraVJET0Zt?=
 =?utf-8?B?ckRlZUxYdGtFU3V2THpja0hDTzRlbE9aK0l2TW1ieFBsVXBxY0E4T01rNTQ0?=
 =?utf-8?B?cFlvaVF4alNhcDJJZGllTHpkVEpyaFVIbzRCcHhHWlRHMW9GU2tQV0V0d3cw?=
 =?utf-8?B?TnVRN1ROWEJ0d1BFeHBBZnJTYTFYK1NPanlIeXBVL284SC9mU3k5ZjYwNFJt?=
 =?utf-8?B?SFlpOThyUkhzTms1SVhQZXk1YmFuTEJkc1hDdytlYmpSN0QydzN6TkxxZjlJ?=
 =?utf-8?B?QW1waGNWelZsOWhYNVZoQVhjWjBJZFNXaGF5SGoyemx1cW5vU0tISFdERXNv?=
 =?utf-8?B?U05tZjNxTEdYbmxwYnloVTI2UFhWVjA2eXpWTldSL0duOENlN1hWMmJoNHVn?=
 =?utf-8?B?MkxSYUxNdFFoMjBRcHZtQUt0REczRTZZcWNRMVRwMVJvQU1JbE1Rd3o0d2RI?=
 =?utf-8?B?U3p4RUFtVWhIK00vQ2k2bW1zeFl5UFhpaWtLbHhQOWY4OGNoZVBpSDRIUXFM?=
 =?utf-8?B?YVAzcXJncVNiQ1BZQWdxN0hMaXRSUWRlUUdXaWxQSkpDSnU3cDJRVUdkS0xB?=
 =?utf-8?B?aHB1dDU1eTB1b2R4azNpUWpkZjd1ZGJGNG9sejcyR3gvSGQyTHZCaWxiVmh0?=
 =?utf-8?B?ZEM3TGcvaVdLT3NKUjZKUExIT2l2LzU3WFpySFJ1OXc1c2pWUVVqSVc5ODhw?=
 =?utf-8?B?bHJHR0pDQ0k5VmgzNTYxTWNRbDVSZm5BN1o4YU4wTlB4MVh3b0lNQjJBc3c1?=
 =?utf-8?B?MThsSHNLSTdvUSsvRTF1bVdUU2hCYUlyNkR0M1JrcCtYMHRKd3c1cVlvT25B?=
 =?utf-8?B?U0ZlYnBFTHhPNXBPaWxtOC94cElKb2lnMDVJODl2d0NCdDNvTmxUWXFXWkND?=
 =?utf-8?B?dEpIb05IejFkUWZWQklraEhMWHVibU0zMThHdFkzbU93ODIzeTczcEJEWlNx?=
 =?utf-8?B?anl6OGhDR0xqOEVtMTI5QUZRVkpvS3N0cURCSFJ4blVmNE9LVTY2N2JTQWFq?=
 =?utf-8?B?eVN2TXZSZ0I0eVdpcStPdm0zeDZkVC9yeVA0WXVmVW1NK3ovMUY3U3VRQm9R?=
 =?utf-8?Q?/2lk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGQ2QXkra2xvTm43eDJMNXIydVRpOFhsbGRNS3hENTE2MlltL0JobVBtZDNo?=
 =?utf-8?B?Mm0rMzRJTll5Wnp5RERpRFpxbWxZRm82VHJGMTVBbFE0K2NlRmxGbGtXclJF?=
 =?utf-8?B?djBKVWlOdjM0eFNXT1RaM242MVZMaEhUM0pWK25XQmxKNmRscnlIN1g3dTNj?=
 =?utf-8?B?TW9XNGNCc1RQVzlHS3FVUnJlbytUMnVCbHo0dHptTGxCZnRTcS94TFlmeUJz?=
 =?utf-8?B?cDMyZEU0alRyd1dGU0QyY3NoWXIwZ1RGbjRmUVdXblJCVldGY1BxaG9uQjZB?=
 =?utf-8?B?Z3liTWxpc3ZWcVdNT1Z1MloyOHhya0dmUmVuYzg1N3BDR1d0dldqTnMyN1lV?=
 =?utf-8?B?QnV0cE0zaEtZOC9WUEYvbE91TFVXK2Q3WWRMVmljQmlGYnhlQnJKNmdEc0pB?=
 =?utf-8?B?cjg0L2JObTRyUjYzQnozSnRQMGJIY2FXNVpMTnJ1TmZVTVJ4VTV1OHVyKzdN?=
 =?utf-8?B?UGU3bURKak5nVnZSeDQ3QUkwSzdZRGtOS0picXBBUXNHNTIybTMxZHEyTlJm?=
 =?utf-8?B?Vm5HWVVlaFRiZURRa0NHSmNSY0NGZGRKQ1VyaUt2UTc0Qyt5Vkw2UjhqZG1O?=
 =?utf-8?B?MXNGcXJ6RkpuL1hCdTVFZ3JWSmFqL05NdUVHTlBPOVk0dXZhSWE2bkRGc1Bu?=
 =?utf-8?B?cFhKTmp0N3hacllkM2I5emkreDR6R3dKUlN2T3Bva214ZXFSNDd4aDdUNTBp?=
 =?utf-8?B?TkNxV1NES0JWR0xsRHFMdHBrNXpGWUorTHM2Uld1UjNvUGtnWEYrRnFsY2dp?=
 =?utf-8?B?QnlsZE9SdVFYM25FTFcwaGNFdUozTXREMTZRT1dKdXlnbHlJWDBoeVk3aXUv?=
 =?utf-8?B?SVZ0azgxYnNZQjhFdlVZWGR5OWVPVFA1dnNFNm1tY3haQmpSRWdNek9DbU1U?=
 =?utf-8?B?MTVOSnRhb1RuVi8wTnIwU3hYR1d1UjVwalpVdDUwNW01TkRxakVjRmFseG0v?=
 =?utf-8?B?SHpWazhwbXNOS1poY01SZ0VzUjVZNmNFZGVxdTFSMEhtTWd1a1dPN0Q0Tjk3?=
 =?utf-8?B?TzBuNzdzR0ZoWHpUUmNhT2RmZUpCWXVpUGhhRXZ4dUNETm9kUEx3QTN4bTJS?=
 =?utf-8?B?Q3F5ay9VTXJQOGpsTnVqQXVIa0xhUFk3aFk1VHN3K1JWU1Q0QUlYZWFLbllD?=
 =?utf-8?B?K0JSeWN5L25wVHlMazVldEsxQ2pPY2dYNmxxaHpDalJWYjc5Z2lOWS9wMzBj?=
 =?utf-8?B?bC9PRjIydi9yZ01VbU1SRjJBaHRxZG9LaWVUZmJ0aDRIa0RmVk1CTmZRSThM?=
 =?utf-8?B?aXJoOU1wcGM5bFRzUHBBZjdPOUFtdzJSWE1yUk9kNFJQNHRkemxrZTJIbmVp?=
 =?utf-8?B?a3R4ZUszVmhxTmlkamlZVHc5dXB2TlA3RmR3YzRSL0ZYU2plSERQUGNuRXZX?=
 =?utf-8?B?ZFNwbGlwaEdHTngrWmJGaXBQamV2bmNqbnFwbVJUanpyVElOWTBpNVRDcmx4?=
 =?utf-8?B?cklrZkFLWkhvOGZ2RFpNZHBIaWNSL2pYMHhyc0F4Mnk4SHpxdzFjbmp0OWdi?=
 =?utf-8?B?d0FiS1h1T0FCZ05FQXJNSVlBSEkvcWNGYmdUeDFETWd2OTNNQkRtalFxMjAz?=
 =?utf-8?B?SnFoaG5hMUFLMHFRT2JTUkgrRWc3eUNqQmRCdzdYaGdCTUp3dnRzY1NWUTkr?=
 =?utf-8?B?aUg3OXNxUEVzV25xNE5McUdJazZGbmdMZFpSRG5yeXY5UUg0ZWs5NWdEWGdm?=
 =?utf-8?B?UzIvRHBKaUJvZS9QcDh5R0twR005NmIzODJYeXRXNHBrMnFGajN6elRvMDRo?=
 =?utf-8?B?Uk40cXFZeWZNaWdKZmpSSThhZ0JjalExTkVoV1VnUEtnK25HSGtHS2J6eEYv?=
 =?utf-8?B?T1RZejZabkVTUGhMSklPRjd0SFdTdmZHekp2RDd4akZoMWlxYytHN0p3cGpL?=
 =?utf-8?B?V0hCYktSdUFtWWxvS05ZRWpXTlJIN1I1cnNNMk5xWWdNL2JRTUNobmVvQUR0?=
 =?utf-8?B?ZW8rZ1ZqeWtaWXlhbDc3L3FOZTlFaTJhTm5Tdm5rOWUyeVI5SlJnaW1VS1pu?=
 =?utf-8?B?bHVkOS9VZVlhamkrdFdZT0grOUdLblI3RzdqOUg4c05IREl2ampjT2dCL3JI?=
 =?utf-8?B?dmxFOEhkQjhWSFpPcnRGd3Via3hSanlVUHNnRmVRaTV6THhHNEYxRVhNeTVa?=
 =?utf-8?B?S3VlbGthU1NiQnhPZVZCN1IvL0djMndoUW1MelphK0tRRmZxYUlXN1ZGc1ht?=
 =?utf-8?B?VzZSMHIwMDBZQjR4b2FSNnd2YXNMSGRXRmRVZFNSb3hLT2g0WG1IU1NUVVRl?=
 =?utf-8?B?ZlBwNmd3c01mSmNGdjZtLzUyMkVPckxya01OTGhzR3YzWmpQVEZYR1VWRTA2?=
 =?utf-8?B?N08wS29ReEhQelFXSlEwZVppY0k2blhmR0dmWlg1UlZrUmoyTUlkbHpjRmEv?=
 =?utf-8?Q?EN6aLwClViyLccYU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e77eaa7-7cf2-41cd-1137-08de6e301171
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 14:23:06.5016 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M1K/yQnafZp84sP25zQ/8VUWu5BEwFGmFvlmDUpjybyMYELUEuQDq0U4VK9A4yVQeFfixdJwJ26d02bpGGJsXXBYZBfr3s+xmU2Dsy3NHlw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5077
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

On 2/17/2026 1:58 PM, Bruce Richardson wrote:
> On Tue, Feb 17, 2026 at 01:50:36PM +0100, Burakov, Anatoly wrote:
>> On 2/16/2026 5:58 PM, Bruce Richardson wrote:
>>> On Fri, Feb 13, 2026 at 10:26:12AM +0000, Anatoly Burakov wrote:
>>>> The macros used were not informative and did not add any value beyond code
>>>> golf, so remove them and make MAC type checks explicit.
>>>>
>>>> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
>>>> ---
>>>>    drivers/net/intel/ixgbe/ixgbe_ethdev.h | 12 ------------
>>>>    drivers/net/intel/ixgbe/ixgbe_flow.c   | 20 +++++++++++++++++---
>>>>    2 files changed, 17 insertions(+), 15 deletions(-)
>>>>
>>>> diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.h b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
>>>> index 5dbd659941..7dc02a472b 100644
>>>> --- a/drivers/net/intel/ixgbe/ixgbe_ethdev.h
>>>> +++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
>>>> @@ -137,18 +137,6 @@
>>>>    #define IXGBE_MAX_FDIR_FILTER_NUM       (1024 * 32)
>>>>    #define IXGBE_MAX_L2_TN_FILTER_NUM      128
>>>> -#define MAC_TYPE_FILTER_SUP_EXT(type)    do {\
>>>> -	if ((type) != ixgbe_mac_82599EB && (type) != ixgbe_mac_X540)\
>>>> -		return -ENOTSUP;\
>>>> -} while (0)
>>>> -
>>>> -#define MAC_TYPE_FILTER_SUP(type)    do {\
>>>> -	if ((type) != ixgbe_mac_82599EB && (type) != ixgbe_mac_X540 &&\
>>>> -		(type) != ixgbe_mac_X550 && (type) != ixgbe_mac_X550EM_x &&\
>>>> -		(type) != ixgbe_mac_X550EM_a && (type) != ixgbe_mac_E610)\
>>>> -		return -ENOTSUP;\
>>>> -} while (0)
>>>> -
>>>
>>> Ack for removing the former. For the latter, since the list is longer and
>>> the code is used twice, I'd be tempted to convert to an inline function
>>> taking in struct hw and returning type bool. WDYT?
>>>
>>
>> I don't want to use a macro/inline function just to save on code, it has to
>> have some semantic meaning. Do you have any suggestions on what it is that
>> we'd be checking in these cases?
>>
>  From the title of the macro I assumed it was whether mac filters are
> supported or not? However, if that's not really the case and this is an
> arbitrary set of MAC types for some particular use case, then yes, agree
> that it's best to remove the macro completely and inline.
> 

My reading of the name of the macros are that they are "filtering 
supported features by mac type" (MAC_TYPE_FILTER), and there are two 
varieties - "supported" and "supported extended" (SUP and SUP_EXT), but 
with no actual semantic meaning.

-- 
Thanks,
Anatoly
