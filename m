Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3085EC36013
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Mar 2025 13:10:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 851C04065D;
	Fri, 28 Mar 2025 14:10:00 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 9E62740269
 for <dev@dpdk.org>; Fri, 28 Mar 2025 14:09:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743167399; x=1774703399;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=NS7y5nPPbvUVY1PJf0RfVmuhQ082sxbm78D4+HN0SAw=;
 b=j8+EhhqFFHniyngRj0OPbKf5+QroXD9HUIPNmg2sNi+RSNWqX8Q3QAZ8
 PPXhNMJ882sxDEsf0NEB+LrIZvGAhEAkDWE1ncGEM99IHXZumbMgoZtip
 ChcbfTbwEtFTw0E83au06evDcVgfMavZuOujQifalgFHEN5TQHej11cvk
 sE6MYASvLG833xYAiHD2FjoRO/5KEWHOUFL1lV5ojAet2FQKfA5mME+td
 UA2fezfrxv/90dgS5PEBiJbOV1ryrgHCiyvLu4F8Z7OoY/BdkZiLjsK6+
 Jmb4c/7ecQmxT+D/6paiIN4Pqjr5jjyFPJmLWMv50hAvEKxODK16WqHVM g==;
X-CSE-ConnectionGUID: eZoHtzi8TRavai7EiPxkKg==
X-CSE-MsgGUID: VQNm3JuwRd+JqDhIJrXQhQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11387"; a="55174491"
X-IronPort-AV: E=Sophos;i="6.14,283,1736841600"; d="scan'208";a="55174491"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Mar 2025 06:09:58 -0700
X-CSE-ConnectionGUID: s3wmcoPQRGSltTkznhr9HA==
X-CSE-MsgGUID: C/qxklr7SFyGHrr6uGoGfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,283,1736841600"; d="scan'208";a="130147850"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 28 Mar 2025 06:09:57 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 28 Mar 2025 06:09:57 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 28 Mar 2025 06:09:57 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 28 Mar 2025 06:09:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bb+G1XlboWfCOe/2y/2msVx+tZUr1NmCGN+j/+75oFAbLPmR8Spgw9UtwPJ12dBb2aF/4BFl0u8x2dikKe6blO0R3bgn6vQ333yDaQllyZRsDSHOtGy7WyXop5zKeOgvQjKtNxrz3UTfKhktsNOSAdiLKgr+d9FMLeWq1mOZVV0z3bw/0Mr40y6jasVyQ7xbyJ6hXh7pQZV3NhI1Zn9SSMICY6nGXgYEtAm5UR80GlnacSdlbfAXXPAkCD4/hh7ex8sQoWy4tmhgVBzXF5bdvlVsmi0pWp23wBSq5dDrq/guKL3EjqnwqxpXonOOV+pvaw/AbHfG2Xk7OAT/1pMMHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sybydQOTia4wxHVaPRxJjglvPmU4nnHyXt8nHV2P1pE=;
 b=FEacD8RFqFK6M0HBj+ZcLUUH14/vcvAr6JSfbWpl44ZKJpx/HOeKtKV5PQ9EIobbRbpa7WExpFgEjGk3cyzuhlT/KNzSO5nN/Nb6UNID7WPphdLKGNJXICpbxBz9SD5tEsSNiCXEvL0O+jEU3DIbwbsP6x18I2ieB8cDGg5rNltz3GlAdlxmfT/dXT4BrxdrbQ3u1bqH7pOG78GX+8O/wR46reScBIlFcqz80461VNsPMuiGCMG2zX6bwrnRqkFvCRrp2LvDKWC36jYX+h5tX2emitXmb6Zf6wKhYIV+lLNIxlqxvWZri5qPqsc11B5YVyiqXfCmzBANnfJD5qSrVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 CYYPR11MB8388.namprd11.prod.outlook.com (2603:10b6:930:c2::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.44; Fri, 28 Mar 2025 13:09:24 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 13:09:24 +0000
Message-ID: <23c3e0aa-005d-414e-91b0-048403a804a0@intel.com>
Date: Fri, 28 Mar 2025 14:09:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/9] net/ice/base: reduce warnings for unused variables
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: David Marchand <david.marchand@redhat.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>
References: <20250326155230.1315056-1-bruce.richardson@intel.com>
 <20250328111621.2665257-1-bruce.richardson@intel.com>
 <20250328111621.2665257-9-bruce.richardson@intel.com>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20250328111621.2665257-9-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P250CA0029.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:54f::18) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|CYYPR11MB8388:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fb8a24c-5bac-4c11-be27-08dd6df9c2e2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QytUeHBFdXNPNm9jdkxtcVdscFI1T0NsTFZzNDZHajhJckQwOFh2alNqTXNu?=
 =?utf-8?B?OXlEUjZRd0huVEM0NjZFdUxadjV4QURPbWFxVUJFaXFOejFkQ0FkTGxSTlZy?=
 =?utf-8?B?eGFMTW1mVlFEUUhOMWNSaUR5dGplL3gxWXJYVXovcmVDSXoxR3hsY1oxZ1pB?=
 =?utf-8?B?UG9GS1lQZHZzeFMra3ZVRXRocmVmQ3BsSjlKcEZWS3RvQTNKWHR4cE5nenpa?=
 =?utf-8?B?YlpRRDFodTZNNXl6SnhvZHp2SW1DNE8xTDQ5cnhQdXQxemN3VjVkay9mQy9Q?=
 =?utf-8?B?N001MVcvbnBEYXdydWlkK3NYOENYZVFGbHFvNW1pbnBHNkFhT080NWVvRk5M?=
 =?utf-8?B?aDZoSWdkNWVHQmJNZkJ0L2hFSlZzT2JnUVkzSjZ2TE8valptU1JKR3FXV29h?=
 =?utf-8?B?VHJOUitCRE9oSW1OZytJMUhDMU11OGRjbW9pbGxvRXpGQVVJdTg3em8vNDBJ?=
 =?utf-8?B?SlArVUtuc3Q5cEZOVFpyVllTQ2JhQ09CMnZFMWtOM05HS1ZweXhIRzU4bjM2?=
 =?utf-8?B?Lzh5R0M4T0RndjZQZUphd00xeHY4MlZ6aUUzTGNPdDQ0ajRZTWZVOEhFVXhp?=
 =?utf-8?B?MjMreE9iREFKTCs5KzczekNOZFk5SUZNbmM4L3JaUG1tcndjMTNEK0dtSEVj?=
 =?utf-8?B?Qlo5Mzd0dHE1NzZkYUdRTStXQ3ppa2xpcU5LNGozMVIvTlVYaWhOaFJjaXRh?=
 =?utf-8?B?MHMwcHFKMitMQXJYblFkZytVbnVWaml4NC9YMnZPd0ltdytXK2Z6WFlWMUFT?=
 =?utf-8?B?eHhyTisyYlpKYlY2VU9uOE1SUnVBT1NRSVUrejdBU2s0VDc5ak5VejhONjI2?=
 =?utf-8?B?WEp6cVNaU25ZRytiNzFLSFhMVnlIaXViZm9LTUpKbnN3bFl0VWlMYll5Szdq?=
 =?utf-8?B?SkN0ZURNU3BqUVJXUEtYVlZ3VWNJb1l3WnM5K2xVQVJxSFNZNjZzOWgwdUZX?=
 =?utf-8?B?YWJUTnM2WkppQlQ0b1pBTDdvSkVHUzB5VHAxNjJrNHNBSHQ2TmxadFYwQk54?=
 =?utf-8?B?Mkt1cVB1OTlmQ2dHcm15SlhRdEQyREs1bUR2NTJORUp5MGMvdlc0NzNCVFIy?=
 =?utf-8?B?SGNla2txaXU0NGphSk1vNCtBWjcvck1teGt1ckpsZkN0WHZxaFNkNDVCb3dM?=
 =?utf-8?B?QkNlQTFXNGYxMlZuODNhd1MzOWpYdDJKWEJMMXJVNURnTmV3Wk40bjIxZ05P?=
 =?utf-8?B?QjgxbElVcU5vR1pXZytCb2l4SDJYc0tDR3l3OHJNV1RpMDltOEpwWkd0RFdn?=
 =?utf-8?B?NEwrNFZJc0NTeGhTV00xeWcwTTg5ZE1oZ3czTU5xbnRZemxJZjlUWHRKc1Y4?=
 =?utf-8?B?Vm5yMmpGZnJ5ZnB4Um8xYldLdkhjTnUwNk5IdjhzMVlzWTFneXJLRXZseVdV?=
 =?utf-8?B?SWs5WkNaZ2V3YjBOcGpZRkhjc1kvTEZ5L2M4UC9pd3JGZlJpTzNhZUFTM2pI?=
 =?utf-8?B?QUZlcmJ1Nk9nM0RxOEk3cmJ1cEYxaTlCT01yd1RoLzZ5MW5yZDRKTE5RV2JV?=
 =?utf-8?B?YTM3eWs2UFJ3U0xrV0J6R2hGREQwUmpXelhEU3VoSVB0RnM5eEQzSXNKcmJZ?=
 =?utf-8?B?S0o2NGhRUVR5RFJ0ZW90cSt2eUFZOWZ5bjZ1TWtUZDFwaFlyc0RPM2VDS0Rj?=
 =?utf-8?B?b2JlZkRLVHdqMStYaExzRlQ1cCttUjE0c2VFOUZ6cVBJZm4vQUM1RmhpT3du?=
 =?utf-8?B?Z1dJTnNyajRaMm4wMXRjRXIxZVN4elQvZzJVc0hpNGQrcHFkVmQrSEhvQmxU?=
 =?utf-8?B?ckVPeXFwWTV2QXNwQzY4dFdRSkQ0WloyajBuYnJDTkI5bGRzbG9YS0hNRlln?=
 =?utf-8?B?aDllbFg0K0RwSURhc0VKRG11VTFrZEcrUG9rWGR5anpyd25GZ2hwRGRoUmlw?=
 =?utf-8?Q?04oOisyHagrB+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3BVR0dNYUxpbTluL2lZMXlxKyt6cDdNc1BPRDN3ZmZSTW9MR0tyZmwvcy9Z?=
 =?utf-8?B?UnpVQkJNdVNUdi9RVlB5WS9TaFIyNENSV0JFaXA2aUFmTmE1TXVsTldXSXBU?=
 =?utf-8?B?TnJCRk9qOGRGeitlMFJ2TWVRY1paL1JrU1lmQjFRd3FsZWExSC9CaTJMaG9q?=
 =?utf-8?B?c3AxSklmeGJyaGRjb0ZWNGI2YjZvM2s4Z1BTcmFQZ0FqVUN4dHB3bkVIZ2Rs?=
 =?utf-8?B?OFc2dSsvOXdJV1VYSE9uYlBneGRjQ2FUTGJmVDNCWHVwOFF6aHhoTk5vSytW?=
 =?utf-8?B?ZG1VRUFwa2VRaVNiaG9RcDUrUS9MTC9SV2JhOEhlRlA5cE55clFQQnM5b2NW?=
 =?utf-8?B?SUMzQWpKRXlXZGdyUE1RTDN0N0Z2TFA0M2tPdVlPVllsdGVPTWN1eWZVVWxq?=
 =?utf-8?B?SXdQbHE2S0xBWFFWdllIU1dHUXhCSGVPSnMvNGh5ZnRPQ0R6UEwwTy9hTklY?=
 =?utf-8?B?czY5TU9aa2tNei90MlBSekJvZVBSQS8xTVdRMGowK2VrUGZSRkQyUXpOa2ZS?=
 =?utf-8?B?VW51ZXZHOUVTVVJiS0dMSmpaeG5Cdy9hbEErZDQwVFRORFptcUU3VWVEQnN5?=
 =?utf-8?B?WDhYMGw2U2o2aWRCQXNHV1NubXBCbGVBd0MwK0didWVYa0JsZlRMbUlZNHo3?=
 =?utf-8?B?Q3BCNGV0REN0M0ltcWJYcXZ4aVlnek80QnVaQ2ZIY2xIUzV0NGU3Ty84YWdk?=
 =?utf-8?B?blNoUzNKVFB6TmFJcDRVOTNHZ1hGK3ZFQmtYSVRXbXArMXpzUEJET1RXczI1?=
 =?utf-8?B?c3o0QUxYWnhXaDBZVFI4RmQ2RmsvblRuTUhQKytXMnMwaC9XTVZ6aVROb0Fq?=
 =?utf-8?B?cHRZaWxZR3dWeUFNTitPeVFHT2VjemNCUHR5bkpOaUNuN2RSWk9DSjcyM2lL?=
 =?utf-8?B?RUFPYU1ZaHZXQkUxSEtmWm1vcU1kdDcxNHhzVkJEa0k5NTZvUTZHMC9PWGRh?=
 =?utf-8?B?RUl0a1ZuSHNiNE9hMThhWXVGUjBZZWJDcUQ5dTRURk9tYWpKTjZPd1c0Zlhx?=
 =?utf-8?B?d0tNU2FQSG5UV1EzWHNJbFl4blErVkduWHp6a3A1S29zaWNmTkxDbEFmZXJM?=
 =?utf-8?B?Wk5DeW1oanFHSU5mZyt0b04wTTlQNUZxeXV2eXhZOVY2empKSERzVVZITEts?=
 =?utf-8?B?TWVjMUtVZW02MWgrK0lIclJ2R05jZy9USE1yUkZVVENlbDVUcUtBME5XTi91?=
 =?utf-8?B?TmowNDE1aTVSSEJqRCs2b3JJdXVGb2ErOXhTNWtleEgwUVh0NTREVEl3R24y?=
 =?utf-8?B?b1ZRcXRBek54LzlnQ28veGNML3E5YUkrWXEzNG9MbWVVNmphRHdCcUhmd2ls?=
 =?utf-8?B?Rzg5M2x3eEdwT2cybS85WmRkRUFIcTlMZWU2SnYyN0ZnMEJ1bWEwTkxTZEEx?=
 =?utf-8?B?TTNrQmE0cVBjWU5wTitUR3VQNFQyMUhMWitFZWEwU0NJMzFsK0NWSXNmZGo0?=
 =?utf-8?B?TVJWamQ3MGJwem02WHZjcy84dTNweXpsN3ZFZjZ1NldHM09LSytuS3hpUlhD?=
 =?utf-8?B?NGE3SUZFT3lzUVpiT3VWcWllZ3NyMWMxUUEyYWFhaWdpR0dHcVJqSVJueEww?=
 =?utf-8?B?c2k5NFRhWUJkN3Ftdzh1ZmRhTmtrdEwvdG5zN1BaLytkdzJaNFN4SFRSTGcx?=
 =?utf-8?B?NVRJZHkxQ1FLTzVQdksvVmM5WVNTeDZ4ZkxUbFhPMTAzQnV3VHpMdXlvNnp3?=
 =?utf-8?B?WW1hZk1TRGR3N2EweFhDMUt6VjZRYlhOVUhvMGhzS0Q5ajNSVy9pb1F1eGl1?=
 =?utf-8?B?TklheHUxQ3hFam82TDZSWStSVTcyWDhGUjljMnNjNDNzbHhQTmUyWlRlclpB?=
 =?utf-8?B?ckVjTVNjMmhsRkhKQS8vUTNMb2ZDc2lXOUhIdytGRDU4eGJ2SGpiaWJxekoz?=
 =?utf-8?B?TklaOG13TUprN1ptL1NGWTVmTUNhckVrdjlCUkpQclowdkZEYW9LYmtIN0Jw?=
 =?utf-8?B?ekxENWVUMk9URTV6bmFpQ1AxalAxaVF3c01pK2k3MCtTaEZsRTRaT2kwdGpO?=
 =?utf-8?B?ZXJWTGpGQTFyVzIvSGFCS1dEYVRHSnhFVXRQR0FUMUJDcHZKUEpBOWNhMmVj?=
 =?utf-8?B?eGlsMlFRWDduNlVqTUJnZHltaytyeVVvbXU0OVluY05JeThoUGk1WGgzY1F5?=
 =?utf-8?B?eXczdTZ2Vkk2RGtpWFIyVzlsVEhMdEhMdWZKanpKRWUwQVJGSkJNOGxld3ZB?=
 =?utf-8?B?UWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fb8a24c-5bac-4c11-be27-08dd6df9c2e2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 13:09:24.1721 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1VCtezbGfWS2UZFtQhMc1DwDKukrglnkonkiQRCZTe01lSq2vCrv1JtJfxRpEJKy30khylX8kcwA8bAyi1zhssG3j0JiFBMg0wqM0Fj26pY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8388
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

On 3/28/2025 12:16 PM, Bruce Richardson wrote:
> Improve base code macros to reduce the number of issues with unused
> variables in the code. Issues still remain with unused-but-set
> variables, but completely unused variable warnings are eliminated.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
