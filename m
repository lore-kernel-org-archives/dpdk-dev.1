Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1963EE36AC
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Feb 2026 17:21:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 346094025F;
	Thu, 12 Feb 2026 18:21:48 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 43F8B40041
 for <dev@dpdk.org>; Thu, 12 Feb 2026 18:21:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770916906; x=1802452906;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=xuXt8sU+3kmm9uAxumBmxb1G6vTiK6c8FmST1g9a7CY=;
 b=DUgp2fdNfbh5XisYzgLo5yvHQJ72SzOkSz3CoZSoHdVbTGZuV65koNTB
 LCYT6Y3tgD3LIWfaysVueufzr+ifz+NXYkWrrdqZEI2kP3wPJl2h6GcU2
 /8bjFCvD9GBIWrit6ip8QeLHvfQsAlFTZOPu7XGk0BnBJt6OBNI5z54kY
 LaPdLrVifB4nr0aNp1qZNv1M6OzL6pacRcnb/pHpHGYzYz1voEn6jHoS3
 wKbYpYRn3bhRh6t20cFmh9cS0UgkQMfbHh+TDovTKdPHJyZCYcEydKPOF
 rLP05v5aTgK/QokIPSbeMm6fn1SIlsUD+tqW+ucMoD1rjZyheZgYoHbrA Q==;
X-CSE-ConnectionGUID: 1rWS42RcSAyPJ2gtr0OdfQ==
X-CSE-MsgGUID: Dj+RngoaQV2nanmBmxYjGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="75943027"
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; d="scan'208";a="75943027"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 09:21:44 -0800
X-CSE-ConnectionGUID: v1S62UfYQx6EYQ5xMa2RJw==
X-CSE-MsgGUID: s76FdbLsQ0CIt5PjFziIFg==
X-Ironport-Invalid-End-Of-Message: True
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; d="scan'208";a="216828344"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 09:21:44 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 09:21:43 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 12 Feb 2026 09:21:43 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.62) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 09:21:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iTO2G4iVpyz8LdxKsH8kXo6ZjfTsOFwu6ABtkE/YFt3m9WRrrwUYLWHYaZjOBJeZ7yRrq4B/CF2K0lNKOJYPYHjf6aqKOjUDz3B4dFaYy3oBC16EN0m4K1jgLu82/MqkOLK85/RN5PWCOLeTUPhOp+pZFhkGk5mzRQMMDvEjbD5k+BrV335PFbyh2AIa4sqJfERSDNbTXkPls1+hv9Cpu+vjAfjpjImt8BjWsmR//ROCTusaPLT/3ttTVeu9D0wsaKM19kQz0g0HJ76zNJdCp5ugbiG02k+aMuiFAnzWElZbr8ggvV8Gn7YUxyKuCr6zpcBLJoRBlr/rzJvv0uhgIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5CRrzN+oo8Zb4K3VHLPeYjHVHxAaRJB9gQANfeOBiEc=;
 b=ef/NO5iWzU1kWEZENS+iXnbqCFm5J5bIe1uXf757yfh+y7HMEMNUvK86qquv9ybsUdX7xYUudiCZmLGylNbL1SdElracp2o4MzaG5iA0YHJM0azutRpGaVjH0vJpPmHnS7dBw7mWBhwHnREz3rZFDud8xT1lKELMps/pKEpAbk3tB5xXwuIAXhGZashrySW0ggvi4VyqWUmK/89ZjRr6R4j25icPdrrC5T1WX99TT0nZee3h99QdYFcppI+RGHFZJefkABNHcSFtrvmdUWsEpvxQPQtRQXKhieq/IVBWJSa6QzWtlfhTdQU5hJii2Yg8Vx0exsb+mDjEZ68Wyj1mVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM8PR11MB5653.namprd11.prod.outlook.com (2603:10b6:8:25::8) by
 SN7PR11MB6704.namprd11.prod.outlook.com (2603:10b6:806:267::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.10; Thu, 12 Feb 2026 17:21:40 +0000
Received: from DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa]) by DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::74e3:c0eb:29ee:fffa%5]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 17:21:40 +0000
Message-ID: <3f295bb8-017c-4b8b-b8b6-18787d3a31df@intel.com>
Date: Thu, 12 Feb 2026 17:21:37 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/12] net/ixgbe: fix wrong pointer handling in IPsec
To: Bruce Richardson <bruce.richardson@intel.com>, "Burakov, Anatoly"
 <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>, "Declan
 Doherty" <declan.doherty@intel.com>
References: <134252a49d330111781e4cb1baba470474091853.1770900758.git.anatoly.burakov@intel.com>
 <987bda2e-d92e-44f2-ae04-2a9dd6143b49@intel.com>
 <aY4LGKrTeEkzACIT@bricha3-mobl1.ger.corp.intel.com>
Content-Language: en-US
From: Radu Nicolau <radu.nicolau@intel.com>
In-Reply-To: <aY4LGKrTeEkzACIT@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0008.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::17) To DM8PR11MB5653.namprd11.prod.outlook.com
 (2603:10b6:8:25::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR11MB5653:EE_|SN7PR11MB6704:EE_
X-MS-Office365-Filtering-Correlation-Id: a6e7b3a1-9c5f-40c5-71f9-08de6a5b2f7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eDlVQ01kaE5jOVdodERLUE1FV1dKWTFsbWRlaHdGaG1tWE03cld5dFpBM3l5?=
 =?utf-8?B?Qm1mQ0FGdTR2c0ZGd25jWnRiN0YxY2NXdTlQZ0JVL21NVlQ1VmhENkdVS3Fw?=
 =?utf-8?B?ZnlDejN2TnVVUklRSm51RUY5ZjVoYXlheEJFTEFvbWtZbFl1UGF1emFrb0tM?=
 =?utf-8?B?WXdUa0ZxMUF4UVpZb1ZqcmxpZXVOQWNaYmVTZ2pOV2ZUc2Q3dzdOWjNDaDEr?=
 =?utf-8?B?MEFBekJoUytoNXF4KzVLb21KYkFDMDhTSkI3WVNjUFArdUtBUVlCSU93aWta?=
 =?utf-8?B?ZlYrN1R4TFA5QlVlYTJOa2hBRmc1MWoyS0dTOE1VVG55WFBPRUE0eStqQURJ?=
 =?utf-8?B?Q1VBT2pCWnFTcUNuNkpQV0ljQ082V1BVekQ0eEhDK0NsMkF3RXB1cVdYbXQ5?=
 =?utf-8?B?TzV0NFZENFh1UE9ObEt4aUFYdTZ2ZHJSOU5pSkJJZlJVVjIvdE9WdGVtMWNh?=
 =?utf-8?B?RDduNGVTVWp4cWg0WWNFaElsSFpZcUF1OFZYaS9QS3NTUklZSHAwUVplQ0lZ?=
 =?utf-8?B?RmQwdUd0aXBCWTRpNGJnVytZdE1XRTI2QWt5S1BVOEtwWWw2c3dmaDl6d1lj?=
 =?utf-8?B?OUVwMkc2NndCZmtxNzBtcUxUNHV2R25LKzVoRU9vT0o1TThyMUZvdjIvMlJw?=
 =?utf-8?B?Y1RucCtEQXp2RmMrOEZ2KzBtTENpbXJGSk5HZzhrT1lwbmVlQTE4NUhpMzNm?=
 =?utf-8?B?dWZkMXZDUG5mSmxLQldHbmhtMjU3SURoblZjdTBYem9hN3kvOW1lYjVuWnZZ?=
 =?utf-8?B?amt3RGJpbk1uOExqdEQ1VlpKUyszc0V5V1ZydEtsQ2x0bnk2ZkNNdG11cjkw?=
 =?utf-8?B?QldvYU5EeDU4MllnYUtPSFYwbENrcG1QcStpVThlTXpTd0JjZHJqTWc1MmYy?=
 =?utf-8?B?VXBBQUoyMnQreVBJMERwTFZtZ0xvcnpOVVNsZkdXUGhZaDNKNC9DelE0cXJJ?=
 =?utf-8?B?QXFsTXp1UTNrcWFkZFhjaEVuamQyb1VhWDZDaGhTRkdtSUczOHVOSXV2ZjBq?=
 =?utf-8?B?a0Rpdy9iNmFKRmJaa1dJUSs5WDBPZ29HakRkU29RaEl6Q1dtbFFqck1hUUo5?=
 =?utf-8?B?ajRnWkpoNG1Ebm5UZlh3bVVaNUJTdkNjeXFzKzZqL25nVG1DbW1OM3kxeW95?=
 =?utf-8?B?YnhHaS9vL1RkakkzNC82NVkzTDZINkFnZW9GK0ZESDNkcnhmb0Fmb2dmai94?=
 =?utf-8?B?MnBiVDhtTnQ4elBCQTRuZnVWQStJYkZvUEladUhONWhNNUdvYnM3TjFLMlps?=
 =?utf-8?B?WnVITGhyalJQZEhLa044cGJMa3JFOGlaUXQzOC9RU2tMK2xVUG03R0NabTdn?=
 =?utf-8?B?ZTVJT2d4aDBadFUrL1FtWXJJaFVwL05sOEVmVUZSMnZBTGJ0eE1GVExCVEFl?=
 =?utf-8?B?NGQ4bHhZNVFsM0kxcTg5TUVXTDBlOHRDbWV3WUFJa2lTRmZ1ai9uZmg3UDBj?=
 =?utf-8?B?QmxFMmdMT0R3L3BJUThZRDhmanBYUE1SSmhBa3lwaXc2ZTIrYUdQc0dWNm1w?=
 =?utf-8?B?ZWN2amRUbXFFUndWMWhqUkhzODdDbUJwVitNWklsVy9nVGZ2d1RqdTJnTVMx?=
 =?utf-8?B?ckZLa0d2ZXl3WDhHL2ZDeGxaK1VDUm9ZMG9oc1BuOHAzR3UzMmN4bVNJdzlj?=
 =?utf-8?B?blh6Z1NUalFMTGtBbTJNbjFqNm1mcysrRmRjeUFYYWlZQjFvV09WWWF5ZlU0?=
 =?utf-8?B?R0JmR0J3V3FBQ3NranhTS2dPb0FRR3R6Z0dCTUthRWwxSUdBUWpHd3ZCcERB?=
 =?utf-8?B?VmU4R2NXNG5LdGxFc1JMV3cwY04xQkhGTkRlTmg3SzRuaG1YT2VVd0Q4Vy9O?=
 =?utf-8?B?TmxNTDJiYzQ3VFBkOFdiTU9EVGxjd09ncFNYMXU2aktKMEcyeEJaZVFlUUJ5?=
 =?utf-8?B?M3hsYmNlbmlMOXNzODFuaDJsQWd6R1RBaHRWWmo5TFU5Ym9XYVJ5ekR5NXRI?=
 =?utf-8?B?dVhMVTduVHVxT0VlZStna2VDeExxZ1pKYWhXeDhJYWRPeHpWdkk3SHVLYmUx?=
 =?utf-8?B?QmNwdVE2WnFhbjhITmFPZlAzOVpLWVQ3c1RNQ29NMFVreWJDQ0lWRGRlMDhk?=
 =?utf-8?B?YzE1WHpFMDluOTNoUFRDK2xNMUl2YmlwelZJK1FFczhkaWtmREFxaks4Y2RL?=
 =?utf-8?Q?t23Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5653.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXlXTk9SSUNzdTVmQ21GSis1Y1VHdHU1b2pmZGM5d3g1OU9sZTF5OW5GWURP?=
 =?utf-8?B?Ky9ldjJETVBnenpXMTVzMVVNRW9mUXVaN3lKWFloSGNnOEFTWGlLaU5lQ1k5?=
 =?utf-8?B?L3FPSzBEeFo0Q2s3TTFzYmNVdVJJRWxZZndSeFRLdmJndmVHVCtUL0FJYm1j?=
 =?utf-8?B?RndFZVU5dVl6Y08vYU1SM0lQbk03U3VrTXlsUVdsMzFPVUpXQllIVEpWc0gz?=
 =?utf-8?B?S3ZsTVB5TnNraUthbWtwUlY0ZmR6UTRCY3ViMkZ1bEZwZ25OeENiUGJZYWxD?=
 =?utf-8?B?TE85Q0dLRExESFNFNC85ZVJUR2dWTlhpNnNZTWt6Z0p5UTJWUG9UUDhOcm9V?=
 =?utf-8?B?eXZSemJ6SEVnaEJvR3JTWUI5SXNoYVV5OWcwWThnVlI4R01UaUtha0RUakZW?=
 =?utf-8?B?YlVHb0t6M2RJc0dSeHJiQXNHdWVxR2Y5OENjZm0wWldXZWVpR0VQaE0xZU05?=
 =?utf-8?B?Um0wQ29DR3hiTU90aXJmNzRXdkFBNXRsWm9XY1QwOUxGc2NjQ3BPdytTSHY5?=
 =?utf-8?B?Zy9TRDVXQStLT1pheVZIYXBtcGFQRTlQVVJmZXhRTHRjOGRmcFZxVDdyM0ZC?=
 =?utf-8?B?WkVTTzVzTm9mWHdxbkZOd3E1OHozdE1icUt6TlM5N1kydmk0OFVQL2liRWNW?=
 =?utf-8?B?QnF5MlJPOVdZRXlORHNvQmoxQkNoZmU4Y3dLcUtaR29zVTAxUnZEanAyQ0xh?=
 =?utf-8?B?TndHNG9nNTlJb24vSmtBSjEzRGlDcW5lMkR5aVhJSWpPai9aN0dXMFV1UVlH?=
 =?utf-8?B?TWJmMVYwUS9iN2s5WmZEc2JBRnFZZjJpM3hWb0c2QnlMQklSQUZzUFR4ekYx?=
 =?utf-8?B?UEN1OUFTTEhxQWVlUy9Ndm1XMEFObTdyYksxWlpPMkRIUXoyM0pnblNBOTZE?=
 =?utf-8?B?QzhaZEl5UEVYZ1Y3KzJJa2RkREdxN1RzRDIzMTUyWVZGRHkrNHNBQXlxNnd3?=
 =?utf-8?B?bE10OEM1MWdnK3F0ME5LU243VGJMbTA4Wm9oblB3R3lVREdFRTlYNUJqaWFX?=
 =?utf-8?B?OUhtV1pKOStjNWhMMnJ2bnUzdVZWUVY4dGE0UDBFS2pYY3RoajVFTWRybHpL?=
 =?utf-8?B?ZkpaOUFlWVRnbHlFSXdkcnNuRXJ1dzRPQU5oODEyM2FoY3B0UzAxNWMyTzY4?=
 =?utf-8?B?VkUxYzkwY3IzSnVkTm84VmxRTDdQMkNGYUdVb0YwSGh3cWE2aXBuUFhVYWdZ?=
 =?utf-8?B?ZzFhYWQ3b1YxQ3FHVkg0OStnNUxNMytObmdTVWdTS1htenMyMUJCazJOQjgw?=
 =?utf-8?B?REp1b2lyUmtPeEZWS1ZVYkpzZ2VYQlBXckoyWEZyMktPa3RPTmdndUIzTnpC?=
 =?utf-8?B?RVpOT2kybmlLUGpYZklkVlJ5eW9wUFZ0TVEwTUdNeEhKZGdtVGtKUjdWODhO?=
 =?utf-8?B?UTFCZmM1N1l3SmNhQzdpNzdJQXlrYnpMZEF1V1l5WXhiZXQ4dEtTQjVzMmVm?=
 =?utf-8?B?a2JWT0JPYnkwb0E2dWdTWUVnb3VSS1crNkZ2aHFBMkIzbFExUkxGZVdXWEdB?=
 =?utf-8?B?RDFnS3dDQ1pIMFdvWjBEZ1V5aG5SdW53VTZKV3hMdmpacUlKMzZHcUIwWGJa?=
 =?utf-8?B?Wjg5Wnd4RUFWRCtzZVd3S2orYnZ0cnk3OXRhckVlSDNmZUhBem0rbmNJYmpO?=
 =?utf-8?B?ZzEveXF4TU1lclNTa1JBNzhNZHdZQUdUeTRsbHpGVGhpRDZWWWdaRldRUE8v?=
 =?utf-8?B?S0dlUWNKaE9ITllxbm9NdVRqTVRKSWNoUThUa0hNRVB3SmhwVUs5YU5telND?=
 =?utf-8?B?L0taTkxUWERPM1RhWDZhOXJ3aFVMU1c5MUN3SnV0aXlWNkx1SU5XRlFJK1R0?=
 =?utf-8?B?QkhvaWYzb0x1dlRJZjBJYk5pT0NzNVpGeC9BVG1TU29mUW15MTlOWmQzWmNX?=
 =?utf-8?B?dC9TWmpvM1NKVW54RldKMGhsbjVKYmxKREQ1d0o1U1k0OG1kVXBhYWZ0MTJW?=
 =?utf-8?B?SGFYN3J4bkpFVURuM2ZsS3d2OVk1Mm5aWThiZVlndFBXRHVmdjl4emVsZ0p2?=
 =?utf-8?B?VUU0Nlh6cG1ZYU03TW93QnN2TG1tbGxHblJTeTkyYlI5bXM5ZDBla3N5elVP?=
 =?utf-8?B?dzR0UjNUKzJKaDd0R3VnUEkwcXJyZW5QOUxRSzN0cjVaS2djdDlBU1hnVXZn?=
 =?utf-8?B?enB2NUU5UVdpZlhxT1o0V0ZLRndHd0NtdjUySnpSSWxBRkZPSm8rS1ZmWUFr?=
 =?utf-8?B?WDlNcm0xbmNBNU53ZWlJaGhUa2d2UWUreHBpajR1ZXpxbm13UTRtN0dOR2hl?=
 =?utf-8?B?VHlscUhZRDIxZEhkVi9tUmJESmNhODZUek5zREE1Snk1NDVNbThMcXNQZ1Vs?=
 =?utf-8?B?YkJGRG8yUE9xTVZMNWFBcmFVcTV1TjR3Y3dmR3BjRVVKWEloZk9TUT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a6e7b3a1-9c5f-40c5-71f9-08de6a5b2f7c
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5653.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 17:21:40.6538 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lkqNtfGbIyl+ZBqBvIBCNG/vzHtVX28di+Vk9Wiai86Cmqy1ZgdJomEE8vWnJoh/k29mwB2l2CdrJPRDNbyWAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6704
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


On 12-Feb-26 5:17 PM, Bruce Richardson wrote:
> On Thu, Feb 12, 2026 at 03:50:26PM +0100, Burakov, Anatoly wrote:
>> On 2/12/2026 1:53 PM, Anatoly Burakov wrote:
>>> The original IPsec "add SA from flow" function expected a void* pointer to
>>> security session as its first argument. However, the actual code was not
>>> passing that, instead it passed `rte_flow_action_security` which was a
>>> *container* for security session pointer.
>>>
>>> Fix it by passing correct pointer type, as well as make typing more
>>> explicit to let compiler catch such bugs in the future.
>>>
>>> Fixes: 9a0752f498d2 ("net/ixgbe: enable inline IPsec")
>>> Cc: radu.nicolau@intel.com
>>> Cc: stable@dpdk.org
>>>
>>> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
>>> ---
>> <snip>
>>
>>> +		const struct ip_spec *spec)
>>>    {
>>> -	/**
>>> -	 * FIXME Updating the session priv data when the session is const.
>>> -	 * Typecasting done here is wrong and the implementation need to be corrected.
>>> -	 */
>>> -	struct ixgbe_crypto_session *ic_session = (void *)(uintptr_t)
>>> -			((const struct rte_security_session *)sess)->driver_priv_data;
>>> +	struct ixgbe_crypto_session *ic_session =
>>> +			RTE_CAST_PTR(struct ixgbe_crypto_session *, sess->driver_priv_data);
>> Despite being removed, the comment is still true. This is an artifact of how
>> we get the crypto session (it comes from security rte_flow action, which is
>> const).
>>
> Why not keep the comment then?
Probably it's best to explain why we cast away the const, but not 
include the FIXME or TODO tag anymore.
