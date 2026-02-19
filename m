Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7966E9A049
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 13:21:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D2C3402C6;
	Thu, 19 Feb 2026 14:21:57 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 1C87C402AA
 for <dev@dpdk.org>; Thu, 19 Feb 2026 14:21:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771507315; x=1803043315;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=BjlOhnSPe4z8cgVswU0DMqYPA6nDJyotNtjR/UA90WY=;
 b=QkF1NOqgkCRq7b4a0QeArl6L76tNoKxFhWQVjjl6ntF4lbt4o6pBCg6O
 1+kU6uDCjdwI+dYCfyw9SWh6YjzhfufJ92AMtuG+zuM8xsFikGadPPXnw
 ch87xXpXVnjgYXgnWOHXhunWX8cWVlwFKdtIGetxu8HOR7lu6jZvB04rp
 jjB9g6xQjqO1KrFOTIIzY9evWtunYr58JizQhcQA19EM0Qd/6L4zMK08X
 H4K3pM4FYd8nipXw9lyFQd1X8L8uPPgjjVNaAlRQUKruViyrzZxoE99d8
 2kjnkggZPsNSELgrSXs+mSVurgv8AzZs96yz2mGfCemAMbEqvw/JOiDBa A==;
X-CSE-ConnectionGUID: 8QRp4R3GRdCuF+ciEYoNjg==
X-CSE-MsgGUID: e8IlKGCQSxejAL19436vGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="60164807"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; d="scan'208";a="60164807"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2026 05:21:54 -0800
X-CSE-ConnectionGUID: AQlQdaODTbmMFhgJBOapwQ==
X-CSE-MsgGUID: /mK0DhMfSPeVicUQqxDUGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; d="scan'208";a="214539058"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2026 05:21:54 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 19 Feb 2026 05:21:53 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 19 Feb 2026 05:21:53 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.27) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 19 Feb 2026 05:21:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iCIXyYrqTkBfbyHB247QZ1LLNJlPwkSJlurvLQLVU0p3wE4YHRKIovqAJaAyAzi3O2F/EVQKiDwh4PBFbuXPiUR0L+4F8kS3EGbRJcW5AhwAjSfQSFTKYnDgD/oU4IFoatHj292KRHLoawhTWuVf9sAM/hu+FF3DLrnOjqTTgLLJbminMssaiQMAUnSbfniYUR1n253pQmy1gBDZjPOev8Y3248Ao5psCXpymmDwZQ5rIZxb4FLfvBdvQfv4VcT/OF9NVntZWQE/u2jSpHOkaYpvl10JIx7XzIzo9PM3R1nEQsGHVZ8/l6IzhM57IrCjBidSa3rH6+jYxJpTeBRsDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qBnym4PGYeBT59GKfeBNV5EZNtQG5QWPzD6azmqriIY=;
 b=PiUUg3lSfomw/D5ov7JwSHzYvjs0+Vi3429QXJR439tDWSq6qE+GEoKxrkZ3QUUS2apTBjoGrv82U0TxdDAnW+e4kCW4+rje5mcRht3wITRbVESMxNSSWDgrHinGBMlRAjJ8J2FKvYXf5qJIX+VT6EJ7wyg5fpFGYVpzK3fthD88RvRRR1AbLTGu4U5p5nQYHbi+Kw4HRbNAcUjwfQFzrLk6O9Ue7UXVk7nV1zw5GKwKGtTzZp4xjgcGo89xUELsxzF0kUUMt6sSPaVnbXKmFY4NBc7cAabl+K9TmzgnCwuaZ/GDNRQSpaKodw00vlauPZfN8AnlzLvzx1Ip29bYbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 SJ0PR11MB6623.namprd11.prod.outlook.com (2603:10b6:a03:479::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Thu, 19 Feb
 2026 13:21:50 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9632.015; Thu, 19 Feb 2026
 13:21:50 +0000
Message-ID: <5acc94cc-7c22-4bc2-ae55-4e3e7bc3dd67@intel.com>
Date: Thu, 19 Feb 2026 14:21:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 20/27] net/iavf: avoid rte malloc in MAC address
 operations
To: Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
References: <cover.1770978324.git.anatoly.burakov@intel.com>
 <cover.1770978324.git.anatoly.burakov@intel.com>
 <ad3c77be6c74565b7a9e4544b6565ea91f94fc70.1770978324.git.anatoly.burakov@intel.com>
 <aZNTkvpt8ahCdoSS@bricha3-mobl1.ger.corp.intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <aZNTkvpt8ahCdoSS@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0054.eurprd04.prod.outlook.com
 (2603:10a6:10:234::29) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|SJ0PR11MB6623:EE_
X-MS-Office365-Filtering-Correlation-Id: dc62b9dd-94d6-4c27-542c-08de6fb9d71a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bGRaMkhUb21RcDRFRHc3Q3VNSmFPS1NNdDFOVU5KSDhYM3BkVERVZ1NaaXJY?=
 =?utf-8?B?bXpkTFNadGU1L2pZc1p1cjVPSFBvRFRZdE10L3hjdnRsNXFwdE5wSkNwK1px?=
 =?utf-8?B?MGtCZFg5WTRBUmFrc3EwT2dtSXdpSnZERFFJZG5LTkp6WEthN0R3eW5kcnpP?=
 =?utf-8?B?Q0kzTS84MXlxNWpaZnZoemhWSmhLL3BNTUtMcXBrUHQ3V0VhVVpQbXNFTHJ1?=
 =?utf-8?B?aUJLWVhzZXlrbmc0aldaT1UzbS92NU8xNXJHdlRsV0FyQkFuRmgzbVRiV2ZM?=
 =?utf-8?B?TWdqSWtaVG92SlF3N09WVW5FcFdKQkJZZ25NM0lQdXNFbUpreGhPNzFqOU81?=
 =?utf-8?B?MU9xdmUxQ1ptajV1MjdFR3o4b2R5cTE2MFBUUXVmMXQ4QUxmam14VU5tN1dk?=
 =?utf-8?B?OW1ibWZ0Y2U3emdiME10bVByYjZFQ2xNSklyVSt4QXBCazI0VjVSY2xldEdM?=
 =?utf-8?B?RzA2MXo5cVA2d0h4dnlXeDBBZkNjUjVOQnhZVlpuN2dSTkR5L2V2OE5yVU1F?=
 =?utf-8?B?Q0lGRGVvOU9WTXJ4MGZlR0FxZVA5ejRQMktFWTkxT3FLQzBhbjJWblY3bElS?=
 =?utf-8?B?bGtFNzd6TEZLVEROK2VFTmxUdEt2MVhveWhXSGtaUHdOUkp1SzI2TGlrdEw5?=
 =?utf-8?B?VnVJaVNkbFpVSDVOMnNXK2VXZmprR2QwWU9FVG8zeHRhTzd0NXVwSlBsTndM?=
 =?utf-8?B?c1Q2bUdlNk9vV2VSVkhjNHdEMll2dytNaHZiaWlFSC9aN2h5dFdXOEN2ZkZZ?=
 =?utf-8?B?OXBlbk8zUy8vYVlnOHZCQklYOEE0Y1NCQmcxWHA1QmJwQ0U5emVIUVF6MTJS?=
 =?utf-8?B?aWg3Zm1ySURlVlUvbkc3bTRuSTFzL3hMN2NEc1FTVjVuUzR1eDFkeTNJcWc2?=
 =?utf-8?B?bnlacmpOV3JVNkdOZ21jZ2E0T21aRTdYSjBiaVNjalg0NzBXWG1MTitiUnZk?=
 =?utf-8?B?eFRDdzJBNSs2NjRxUno2Wm5hc1psSnppV1RtV3RtckFSajR5N0pzRzJwQTRk?=
 =?utf-8?B?eXBZTGdreitMY1N4VnVGQThpUm5GSVZmdHprcUZUbmFUa0FQM1k4WnRTejVq?=
 =?utf-8?B?ZEdVUGJJdy8rWHpFYmtib1AvcngyaHhHaUUwN2lkZHplYkI4S0FXc2ZWbm0y?=
 =?utf-8?B?UUxXa2tGbEFVeXh0OHUveHJIbHhxNEdzOVlXYXJHYjd6NzFSUi9Xd1pMUXhh?=
 =?utf-8?B?TGlEN285Mk9LSEFYRGU5Wk0zQXNmcWV4dlJlRllUMUJ4Q2J5ZDc0ZDhHUDBn?=
 =?utf-8?B?YnZwQy8ydkszbnViTlFXVVo0QnVjVWZaVDdrVzJrSVRSeU5nb3FFVisvQU5E?=
 =?utf-8?B?cTk5K2hwOGxMZ3Y4eXdUc1FweDNJRlhPY2phamRuTkg3d3dVTm1mdEQ1enB5?=
 =?utf-8?B?QkJyNmRvV3cydnhGWlNOcXF5allnV3BkejQzWjhmSFBzdHVSclYzTFMzVFFC?=
 =?utf-8?B?bURQZEx4cnJuUm0rVEFhdmRLd2VFY1NodFg4M0kvZHpDd0M3ZmZOeDZYU0c0?=
 =?utf-8?B?V2U3MUU4cXRTNk5LRG8rZjR0UFRGUG9NRVI2SUk2RVE5MGNXdlRORElqbCtO?=
 =?utf-8?B?VlVzbGFvT2k5cFFNQVRwU0kzeVRtZ041SldrcWZQRXFYM2lmZ0RqL0w2VHRR?=
 =?utf-8?B?S05pNTZIb0lNcTdDRk5GN25yQUFVaS9WTDJGM2Q2VC8ra3U2RWVrZHNKVkdZ?=
 =?utf-8?B?KzNtNm5hREgzcVdJeE1IaFNsK3lFRVhYSzB6d3oxWlJTdEk5OUR4ZlpXZytG?=
 =?utf-8?B?eE45bWZTMDBCbHlLNXZCQjBwbFdxUXVpNDlET3prUzFMNTdaaDM1UkswY0U5?=
 =?utf-8?B?SzVVNFJVeHBvV1U0RFBVNFBNaC9tNnJUdzVtcVd4bkNoUThpZGtaYk1JMVlZ?=
 =?utf-8?B?QnJqV1RORkFxaUJ6MnZmcklkc3NDNVVyV2IwemQyRzR2SGJ3V09nOWk2Z1R4?=
 =?utf-8?B?SXczejVkaTZ6NllGQ29uUjRmSEZBSHNhbEx0ejVRemZuWnFUUytDZUtJZTUv?=
 =?utf-8?B?RjJqWDhudkRjUXRQVElJb21UR2t2bFk2QnVva2RsdmhmVnJJQTg2eERialk0?=
 =?utf-8?B?Z3h6Q2IrNEdyYmM0bld4NlBFK1BrUzFvSEpRZW1yME03NCtUWXgrL2VaVmNi?=
 =?utf-8?Q?pFss=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXV5WG9wVGhUUEQ0cFkvMmYzZ2g4VDMydXE2aXhQNWZSYklmQUw3VFVESnBp?=
 =?utf-8?B?TjBpZWZmMWtsOGp4R0orNWU1UDVGQ3FIeEFBZTJxOG9hcnNEQnZwRjdMc2Ra?=
 =?utf-8?B?MFc2K0V3Q0lVOE5zYU5zMml0Y3NTcVIwbThURHc5cHgwbFRtd1BYY0lJOFNQ?=
 =?utf-8?B?TS9GU1drbERBT3owQit0Z3JWMjBjdHcyNkQ3d1A2SlV6dE1RMklSQ1NEb1ds?=
 =?utf-8?B?M1ZrejhrcGROT0pIcVh0LzlSM1Jtd3BFOWlUSWJyZVNsZFJOUmhaY3BJS2t4?=
 =?utf-8?B?TkZENmhaaHBDV2kzeXU5c2MwS3ZyZEMxejF4dkYwdHgyS0lKQzF6cStiNGdE?=
 =?utf-8?B?ZE9iNS9FdmkrRUw0dFUrcTJJQzZaeUtIY2pPWGdWM3VUNjJ0c0xBVjFUWGFi?=
 =?utf-8?B?SVU4b3Z3L3h2L0hUVEF5MjM2Nms2cjUwUzdHOENGNEo5dGdhMFpsSmovRnZm?=
 =?utf-8?B?a29TT1RmZXdFcHh4eWxpVnMvQ1gvNFlWZEoyV1NTbHVRbFN0WnV1R0ZYcThl?=
 =?utf-8?B?dWU1MlRWN1htK3REOFA5NEIxTHBDeWFVZm1URENlR3lpZHlYY1d1T0F4blJo?=
 =?utf-8?B?M3N3VGZKak9CSWdTamhkMW1UZzQvVU8vKzVuVTlJSkZUZC9HU1RXcmFTUmxH?=
 =?utf-8?B?Zk5GVDNka2NlVXVQOXkrUU90cEd1S1pLcVJQWEN6akJ3ajAveWV5K2dEQ3JG?=
 =?utf-8?B?WUxVa1lselJIQURtdWx2NnFXY3NoRkk0anNkYk92K2I3UVQ1K0IveTRrMnJr?=
 =?utf-8?B?TEdpWmpjZUFGWUtTQ2g2UU9DNlFGLzluZ3Y5S2dnSjA1TE5pWis2dGlIRGZ6?=
 =?utf-8?B?WUR2WHhPNWhBcm9oZDdVdUZ5NFpLTzRPQjJ1dElwVXFxYmd4Qm9GZGZsNzI4?=
 =?utf-8?B?bDl2bm9Bd2JEZk5tZkRMOGlqdkJPVmZrSzcwcmNFd0JPc0lPZWVhMmV4UXRr?=
 =?utf-8?B?emQvakZIdXJURUdRMVJKeWdhOWpKTnI4VEM5Sk1sQ2hiT1orU3grRWZRWkZL?=
 =?utf-8?B?WDVYZ0N4L1RvdkU3NVo5MzIwd29rNmc5Z24zN3dQS3FkeFhPM2tQNXdDMUZh?=
 =?utf-8?B?dlIyS3QrakxMYUtlSFlqNUF0a0UvbGhTVVdqV1NBL3BXMDZqblR6aTFOeVJM?=
 =?utf-8?B?NXY5OVpSRHNCNVRtZkpQSzltbDBhZlpnR05KbFo3bWlxQ1JHQjZvZ3B6dHZV?=
 =?utf-8?B?a3pQeUd6dk9oRzFkM0JqdUhnV2Z4UHJqeUdYdDMwcjc0RU83aURDTjU3Mk5u?=
 =?utf-8?B?UW9Bb205UFV3QytJMnVqWnFVcm5YL08wb2R2cGJsTElDekx4cmxTbE1aY2cy?=
 =?utf-8?B?cnIxc2NXV0JPRXdBNjlwdWVaUW9saXBkcXlIRTExMzdkTGQwU0NGazZCbk9s?=
 =?utf-8?B?YWRxMnI3elc2bDFuT0NXL2NCdGIrenZwRHh3WWVodDRsRTFxSHZmcDVvMW8w?=
 =?utf-8?B?dy9RWWNoZUFBV3JzTVJBU0xDOHEvbzBvdjhlN0xaRmlkMktEZ2FpN0lZeGQ4?=
 =?utf-8?B?czVEcG1CWXhvelU5V1Z1SldCUmloVHJNYzZwVEh5QVo0b1FjUjF5a1M4MkJr?=
 =?utf-8?B?SjkzWXE4V3BwVmlmSXF1RTRzQ3JqblJwU2FhSm9lMEI4NjQ0WmQ3OFFzbTFp?=
 =?utf-8?B?KzZiNUF0bnlvamh3cmlWY1BLTzZyMHF4aXc3TGNHUFduOWlFRHAvM0dHOVRH?=
 =?utf-8?B?T21IZUdUMUxyNHdmTmpNbHNRakZ3aDRhemVXc2JwdElKMTNuSTFCMkNjSVR3?=
 =?utf-8?B?SHc0dlZlMWZUSlEzMFNFRWVTRTh0ZmVpazBlR1RxZUpZb3ZjTE83bElKL2N6?=
 =?utf-8?B?NXhkL2twRC9ZamZXeEJKbFFQRy9MSzVBMkIzK0JwMGhSakdLVzF1cXNReWVC?=
 =?utf-8?B?b1JJeEF6NGx5SlNUc3B1U285aWdjMm9IRHBSYUk2YjA4MmJ1cVhtMEVqMWZH?=
 =?utf-8?B?NWU4cE1GSnFlY2h6bWFKd09nU2hLZ1NVNVBCakNpU2t2MkJlVUhlQmFHdXV2?=
 =?utf-8?B?NXBrdlFjNlIzaUx2M29XU0NiUzk0ZG1ab0NHNitZVmFmWXpUS3AvNStVU1VZ?=
 =?utf-8?B?M3RoVlpJOHdnOStjaFdDSytXdy9IQmM0U1RwQmJsK2R2UGVncG5zZ1ZVck1F?=
 =?utf-8?B?VUVlRzZpQ2RrWVdrMXd4MnlpS0w2blVlb2VibFAxSUJPQnBkMy9YSTZhUnJ4?=
 =?utf-8?B?VERoR3ZZQjI2WldQeWlyTGp0QXRJNGwwaXVpWmVueEhHSmN3WjdqU1BMcGJI?=
 =?utf-8?B?OHFpS3dZQTVocWFSd0ZCWUdnRGF3Zm84NDdMZkpEK3BMZStEZm0yRkFlVnhG?=
 =?utf-8?B?eUNINXZQLy9aL01XbWliL3ZZVUN4OXNVWFdqVGU3Zk54SDZjbngzZWpNckRL?=
 =?utf-8?Q?JJGXywCq3KeJYmUg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dc62b9dd-94d6-4c27-542c-08de6fb9d71a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 13:21:50.3710 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EeP3PQ/dgmhTn/1ObVmLo0JQUdgyqSZAgizX8z7a3QwL47hSkI/0EPdVp0/+O+IFUbsA13N64cMURu/H6ZPg41PdGkunET1P0EJbKHhboQQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6623
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

On 2/16/2026 6:27 PM, Bruce Richardson wrote:
> On Fri, Feb 13, 2026 at 10:26:31AM +0000, Anatoly Burakov wrote:
>> Currently, when adding or deleting MAC addresses, we are using
>> rte_zmalloc followed by an immediate rte_free. This is not needed as this
>> memory is not being stored anywhere, so replace it with regular
>> malloc/free.
>>
>> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
>> ---
>>   drivers/net/intel/iavf/iavf_vchnl.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
>> index 55986ef909..19dce17612 100644
>> --- a/drivers/net/intel/iavf/iavf_vchnl.c
>> +++ b/drivers/net/intel/iavf/iavf_vchnl.c
>> @@ -1402,7 +1402,7 @@ iavf_add_del_all_mac_addr(struct iavf_adapter *adapter, bool add)
>>   			}
>>   		}
>>   
>> -		list = rte_zmalloc("iavf_del_mac_buffer", len, 0);
>> +		list = calloc(1, len);
> 
> Given the loop above has a threshold set for IAVF_AQ_BUF_SZ, maybe a static
> buffer of that fixed size might be better?
> 
> Also, that check itself seems a little off, since it allows buffers greater
> than the size, rather than ignoring the length of the address that pushes
> it over the limit.

Fun fact: this entire thing is pointless, because sizeof() of MAC 
address structure is 8 bytes, there's max 64 addresses, and the buffer 
is 4K so it will *never* overflow and need to be split up. I'll remove 
that code.

> 
>>   		if (!list) {
>>   			PMD_DRV_LOG(ERR, "fail to allocate memory");
>>   			return;
>> @@ -1434,7 +1434,7 @@ iavf_add_del_all_mac_addr(struct iavf_adapter *adapter, bool add)
>>   			PMD_DRV_LOG(ERR, "fail to execute command %s",
>>   				    add ? "OP_ADD_ETHER_ADDRESS" :
>>   				    "OP_DEL_ETHER_ADDRESS");
>> -		rte_free(list);
>> +		free(list);
>>   		begin = next_begin;
>>   	} while (begin < IAVF_NUM_MACADDR_MAX);
>>   }
>> -- 
>> 2.47.3
>>


-- 
Thanks,
Anatoly
