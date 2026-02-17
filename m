Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C09F1E909DF
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 17:10:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2E6F940653;
	Tue, 17 Feb 2026 18:10:25 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id ECA2A40261
 for <dev@dpdk.org>; Tue, 17 Feb 2026 18:10:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771348223; x=1802884223;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=TvFOBWLzZhReT6zdM1VemufsphbSW6HPGca1f2VBinI=;
 b=ZJccqQXtiWGQTKHhk31E1lgRMWaBQC+HITW99fu1s54ivkStiCQcK4/3
 9WNO09ti5X03E3z2Ceq34R/oUW/tB0utDqAv7fEfkmgHqTF9S9ns6v1df
 m0b6+2RwkGAefEQ6oqeAwAIYDUXjquJeBcw4RC9XGR+9Y12FlVfAtFbRy
 /E458OYAT6/1wH7k8MtYZ0mrpXgB78i2U8fms0BbORri7bwFhICgVSeP8
 d2XybLlctf14bfduivUF8cAq3PECALhoStakRP7Puugr9HC+672mZzQ/j
 +HzAbbTqtZdHMnc15rot+thUITQOV3i7UnSZ9jtwzW6oPBu4vpcQtUT4a Q==;
X-CSE-ConnectionGUID: YMdKaZJVSdKQIYPEh5RJJw==
X-CSE-MsgGUID: M+YoodASRW2jegVYsTsPtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11704"; a="83787249"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; d="scan'208";a="83787249"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2026 09:10:22 -0800
X-CSE-ConnectionGUID: ZPxRWOa1Q2mE4Kf6Y4+mRg==
X-CSE-MsgGUID: uwIpyCJ+QYynX3TA9i5K3A==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2026 09:10:22 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 17 Feb 2026 09:10:21 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 17 Feb 2026 09:10:21 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.2) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 17 Feb 2026 09:10:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=llMGJ6ciItX+c2gCOa/N0lk/dSC+0WMzM6X4NphIr5HM9G7I0Ni2DKdoI1RWyPLzgRMPGPh/lQS02TbJb/nIk4PJCFTFnE+VyIhNBLeAx/lxaM1y93783229jwpTVTBpP/bojExchsNK2fhSUgE4Ihosr8lDFPnLCEX+oA3tA4Wm73Ptgz73GTkIN6+yWyqs3z1JJha9B1irf2UCI2eHttusXogSsAf5VOzMQRmNv37F2ntrPONCSgcVp1enhyVIqvNFiowzxHLRNzB12h6gPHpw8N8WsfmgAlp0wIpIV2H1pIttiegZ1QcoplC2aajueHL6p0YWlZHBl1lPfGkpJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OdyN0YI/XmSECLj6uygb30jwQmwuL+p/K1Q3mcOXeqo=;
 b=dabGVpHYep9AvakTStE/VKcqGISl+e66/esLN/hueSEc0jTvKFA1whdWR7x1bBc5vzNu0EiE7XXxYgWcqQTlezbyhPIPO+bHi/Cu0uUEXUl2K57yTV3JhlfJx86QOgUeiv60/JxhZRBo81wsq4xxuJNwQwwPOC7YJ+kQ1cl6gBjhucxk+BwDbaFY0R95/mjkxETaq1YEdsBsVcAxxcJkbchzFAuXAF0YTYvt4vH/4tfhCPvlvM+IduQ1T5zRuSUeYh6cbMZtGJwwsmJ9jwuBX87lZr7xN4IB/Bltx046YGQAzMgnJnGWAc4hq3+IEy0iOqFGJcsjBa8UGCDRmfV83g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16)
 by PH7PR11MB6607.namprd11.prod.outlook.com (2603:10b6:510:1b2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Tue, 17 Feb
 2026 17:10:09 +0000
Received: from IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2]) by IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2%5]) with mapi id 15.20.9564.010; Tue, 17 Feb 2026
 17:10:09 +0000
Message-ID: <dce193fa-e4eb-42dd-ad2c-60a2c752bcb9@intel.com>
Date: Tue, 17 Feb 2026 17:10:06 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/27] net/i40e: use proper flex len define
To: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>, "Bruce
 Richardson" <bruce.richardson@intel.com>
References: <e27d196ae4d375482ee0b7d7b8f8a32d940c4eaf.1771330391.git.anatoly.burakov@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <e27d196ae4d375482ee0b7d7b8f8a32d940c4eaf.1771330391.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0095.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::18) To IA4PR11MB9204.namprd11.prod.outlook.com
 (2603:10b6:208:56d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9204:EE_|PH7PR11MB6607:EE_
X-MS-Office365-Filtering-Correlation-Id: bfa3e855-0f7c-4ff8-af16-08de6e4767ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K1FxTXgzc3dQUXZHSWN6MjllRXZnRGozSlZNM1R1TE1LRTBLV2RVOVZkTGg2?=
 =?utf-8?B?aktBSHF0RnFFclJkS1ppejJiTW44eDJZVytCdldTYmR1ZjI2Mi9HYzhXTnNz?=
 =?utf-8?B?dVI3S1pzRVRWZDhRYlhQZUt3NjIwQTZUcUR0NExodjNTR0JQVThVT0ZBcVFK?=
 =?utf-8?B?TGl4aHVwOVlHQjlkRGZQMVVaMDBYL1dLem9LZm1VbWhTTFlpelY0d3lWSjJY?=
 =?utf-8?B?MEpHbHZkNWhpb3p4MWhjdDlTWDIzZWRncWNUamdmenFQbEI4ZzZmNTE0YkNZ?=
 =?utf-8?B?UEZlaHpwOEVqNnNneGdGUm5tNytWMG1JM1ZsOHA2UitWb2E4dCtOdkJEbE5F?=
 =?utf-8?B?eDdZdGloeFhZZWZYcFdhYTRCTk54N0NCRTZhNHNUQ3BBSlFkMVpkM0JXZ1V4?=
 =?utf-8?B?bWszOG5HSFFZZU9GaGJiR0VpUkZ5SUQ0aU05V3FvaXJqMHZCOThBSDU3OUNF?=
 =?utf-8?B?TjhUVEZjTlN6RVAzWlh0ZkJaRG1NU3hYemZKSk1tbUxwQWdybkk5L2xEK3NE?=
 =?utf-8?B?dWswNW8vTDZhMGM5aTQxd0V5bURPYlJpTnR3elNHTVM4SHI0ZDdubitoOXY1?=
 =?utf-8?B?QWF2cmdIT0lSS3V5dVpUWDRHODVhZ1BuZUhtYjR5Z09jckFVQ1lwRE1xeEo0?=
 =?utf-8?B?ZG1oMFg5ZE9xaDdoS2k1bmlydVhId0pQYnJrSjlvV0pMTC95OHE1dExHSThV?=
 =?utf-8?B?T1RtZXkvZHU5Z1VRcURSMStVR2loTWlLUVRSQjVCZzlqM200YzRZYjNNRFJE?=
 =?utf-8?B?MW0rSUsvWHRWdHUyemF2MFB1R1ZYL3FncjMzbjk4STNNV2dnQ1FTRHJFS0hC?=
 =?utf-8?B?TzRrYklpZmVWTUR1eXh0eWFlTFpzdWI5N01QWW1scS9PdGF1amlpNlpreWRK?=
 =?utf-8?B?UnV6TXM2WHpSR3FUNGpNMkt5T2RaYk1CY1FhTll3a29FcFByVk9PbVhxajVV?=
 =?utf-8?B?TUhhK21RZVdNcUo5Y1RnYjd1TjlUVmtPSEs4K2s4WWxOeXU1VC9NRlFjeDlU?=
 =?utf-8?B?UGlJUnFyMndQcFB4a1pYdXU0MlE2MFVqYmFCYkFNQzR0eGlDSm1pRjQydmI4?=
 =?utf-8?B?cjUxTnhvWVF0RnZUYUJRMnlvZ25lYmZsOTFWKzQzRG82UFZ1eUROL1hTdW5y?=
 =?utf-8?B?MGtNRUd4RXJKOXhwdzNsT0RkbFVwL2swb0V5ekFGc3YvM1RrVE41cW1sZzkv?=
 =?utf-8?B?MXhKbnFWNjVjaFQ3aUhDeDJycDY3MDZaUWgyR2d0dWhPMEt4d1hZb3pyb3g1?=
 =?utf-8?B?cjhXc3BmN1FFY2k3cmFJVWhzcnR0UHhjNFNwTlFyRkNPejZHOFd3bkcxcUlR?=
 =?utf-8?B?MGhldkRsTEpLR3JTYnpkRkpHTUNjV214VWRldGdEWS9uSGltamVCd050OVhu?=
 =?utf-8?B?eDg2NFpjTWdTNG8yOWEyeHowK00rZ3FLd1NZR2xYcVZvRVdnS0VCUEZDRWVE?=
 =?utf-8?B?RXJNM0NrNjE1Q2lkSnJrUmZXYUYyWVhSR0xMek9Tbmh5ekZhVDExTk9WeHhx?=
 =?utf-8?B?NDEvYlIrSGx2WDVpWUNQdmY1Q0JnZ3puTXFuMjRLOS9TTHpVQlBLWU1RTGF6?=
 =?utf-8?B?VGtCNlM0cG9jNWNtV01QUVNIY01BT09oOGkwK1NDVGlOV3JHTVRuVVQrQ3dx?=
 =?utf-8?B?UGZqdTFhMVZCYUVKYUx4aVpXVCtQMkh2N0IrRll6WWpCVmZnL3MzYW0xOGRv?=
 =?utf-8?B?b0dOL2tPVGRQbitPUXNWTm1VZ2U0aEZoM0x0RUd0U0ZyMXJXaHpjZCtCUkQv?=
 =?utf-8?B?TWRPNWVUR291OWpzcURheGZDaXUxVTJnZlZYajJ2dm9UbDhkUEJiamYxQXpY?=
 =?utf-8?B?MFF0TGJIK2ZTNllhaXh5UnVQZzFlUW9FeVA5NXJ1NG1ZTHlodWpoL1BJUzhl?=
 =?utf-8?B?ME1xbllxait1Z3pzdnZLMHNQVnRkUWl1dUJNL0JlMXNjZVkvNTFBUzJ1NFhq?=
 =?utf-8?B?VTdab1p5MmkrajN4cXRlSC82ZU9rUG1jUlUrdHZVcFdQQ0F5eGhUS3VLbklX?=
 =?utf-8?B?WDFZN1RkZzYwZUcwdGhKemJpd1QrY1A3bGtNSy9PMUpWejhEOWp0dklENjU3?=
 =?utf-8?B?ZEl6bWU5UUh3WXpWbGtGTFgrdjd0aGhESExpZmxrRFZEazA4aVdmYW9LM3lS?=
 =?utf-8?Q?yl9g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9204.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHk3cE1xUDRXYzR3eG03N0Y0d0x3bmZDMkJJUXFVdzJ6UHNCeGVDZlRIclgz?=
 =?utf-8?B?b3M2K2h5SmVRcHJUYzRwbWFBM204Ukt2U0o3RkExVWRxQ3VYNG1HRkd4U2x1?=
 =?utf-8?B?QU9qUG55MUlvcTdqMGI4T2FkMlNPWFphenpId2ljMHZON2w4b2NEVFlxZy9W?=
 =?utf-8?B?WHFRNzZSeWVldzkvNnFiQ2ZYV3NvYUVLbFRLQU5pU3BYOE5kKzRxRUd3LzJh?=
 =?utf-8?B?eVkvbXQ3WFlzTzNwNW40OTZoZlc3LzJSUGc3ci9FTmNCa0ZzS3BYd0FLMXhT?=
 =?utf-8?B?RUFJYkwrMmppUFJla1ZJRmpvcHdwei9xRGx0Rkx1Q0RtdDAwcGVZSVAvM3ZW?=
 =?utf-8?B?S2MyWlJJWGRnRVlTckRsTGlVbjNPa25NVUtPeGRqN3BCMVBSQk43NVRKQmpk?=
 =?utf-8?B?WUhYUG0yVGUwRUdOUGF1SWlIOHAwMi9NZ0xZeG12eHZ2RGw3R3MxSE1FRzBP?=
 =?utf-8?B?OWN1OFlEMXdLK1ZrSC9LSm55blpGVzRJN1NObjQ5eEhCeXIwODdMWDZKWWlB?=
 =?utf-8?B?SDIvN0VadStXcS96T2FGSUlDTHNUUlArUzZnOEJHSk1PTEVmZThvUFA0SkF5?=
 =?utf-8?B?TjVIc1JNeTZVMk1kZGozSDNodHNTWTFpMzlNSnk1Mk1KK0Z4a3l2NDJZREhB?=
 =?utf-8?B?RUZkUFd2NnBPNTNGN2w4MktsMEhsSkg0OG9HdktLS1FheEtwZ2ZQQjdEZnFE?=
 =?utf-8?B?SGFlb3hOQVhpVEZQWFhwMTJVRlpmSk5Vc3ZoS0Y4QmZrVk1vN0M1Rnoxd1Va?=
 =?utf-8?B?ZnNIWDhWUEdNSUo5MTU4UlN5WTQ5blZibUNtU1RlVTk4eGVwYWNpajBvOU1V?=
 =?utf-8?B?ZjVqM0doWHByQ1BuUmV0K2I2ZlhzNzBHcnI0Q1FCd3lHcFppTHQ3OXpKcnFx?=
 =?utf-8?B?Nm1NUGdkM0FLS25FTGZFb25HS29WVU9kR3FGQVJ0RkJFcEtZRjlGZ0NWRUZs?=
 =?utf-8?B?VVlXM2Z4R3BuMytYNExOWnZrK1lIRTV0YkdrK3NINFM2c0tzcjBEZDVEZmFT?=
 =?utf-8?B?dkdUTllMSFMrOHc4c0oxSlYya01YNllva2l2RE5HaFpwNmFKcjRMdEtSZzdp?=
 =?utf-8?B?TUV6ZWVlSzdLbTJUOTBIa09WK3BtYkZnbzVLUkZrTTBvOUtOenlKaS9XbENN?=
 =?utf-8?B?QVF3QVR3OGRGU21EUTJaMnhmemZJQjRDN2pTdFJXa3p3ZFpuSVRLVVd4ZnRD?=
 =?utf-8?B?Vnc5djRyWDVSdldSR0xmckZZblFMMVBQMTAyVUdWSXBlYThaNU9FaWdpNWNX?=
 =?utf-8?B?Njl4Y3hlR2thTHp5blUrK0JOMlhyTk1xWVVsYWYrd21EWk02ZklNcW9UVXdJ?=
 =?utf-8?B?ajhKeHBLTEplQTR6NVVEemZBb3BmbjlEZmF0c29tcVFrQ2lQTkRwS0FlaHdL?=
 =?utf-8?B?WTFseWorMnJrSlJiVDdxSE1UQkQvaWVQbVEvKy9pTWFrdXlKRkU0ekV3VUMx?=
 =?utf-8?B?b0hGbWlLNmtoUzdJbmlrK2lURXordHBjVHMzRTdoSkZxaEYvaHl0Um5uc1Vv?=
 =?utf-8?B?enVGWUl1bHJlU09hdHFSb0k3SXJLMTVjZkJBSWI1ejlDZmpja3RoVUFqQkVN?=
 =?utf-8?B?cW90enhReE54a2lEQWJOalFEKzFxYXhTZ3BYQmZnQTlFSCszSHJLRkdxYWxp?=
 =?utf-8?B?eGZMYlh5Y2RjbDFVNGNCTmxmRFVBc2pBWHlJTnRNMTFxKzByalZCTkhLa2hR?=
 =?utf-8?B?RmRSL2YxTGFqZUExUTI5Um93Vmh4RHlnM2tpdk1kTFdUc29NV01SN0hwNGh6?=
 =?utf-8?B?L2JkNlRHRWdyLytHb1VTVjBxODcyenc1WWxlVWFFc1kxU0pSVG1BSkFkaE1Z?=
 =?utf-8?B?QjcxcXlHQ3hmR2JHSnI1S041VjZLU0hJczRoSTlCcUIyZmlRNlVXODZkZVNN?=
 =?utf-8?B?V2RxTTR2RnMyREFpMU1aTnB6SjlicTdici9PbzN3eFh5UkJpTGZOZmZJemR2?=
 =?utf-8?B?REo2bFdVdENkMGdJOVZXWU53R2x2S2E4L2xHcS9iMk4vZ2p4UVdPRi9USmpE?=
 =?utf-8?B?SnpwY0xFZlJpa01pb2s2SVhWc3JIYXBobTFlQ1JkL2lPRWxseWxlNFVBZEpD?=
 =?utf-8?B?V241VDZOKzE5b2hqOC91TndDQ21GU0hKMjlPNXZ3VFVMTWpvc2Q2ZzRRa0Ry?=
 =?utf-8?B?enBoRGVFRmJlZkJHVmVORTAvVVh5RDEySDJhemMyNVRjU3cwdlEwczgrMk04?=
 =?utf-8?B?cTNQSTcrR0JjSmdMby9lT3VqRjdaNUw2a0xWdnhwZUJabXd4VWR4WGwvYU1p?=
 =?utf-8?B?d3FUQXNoR0Mwd3lncFFNcENsTTRXSlJtNVlsUlNTVjlOQ0ZNalBXSVdRaUZ2?=
 =?utf-8?B?VmM5bnlWZGEyWnNGTDhET1pXL0hOOXVRajEya1IyWG1oN1ZoMEdqRHV6aGZt?=
 =?utf-8?Q?KlvvPIx/s/dOEFAM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bfa3e855-0f7c-4ff8-af16-08de6e4767ad
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9204.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 17:10:09.6416 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q9Tawmt8vexjwa//N/DLhSsXLSdUbEmml/fu8+F+9zJfBRI9BGhyLnMNdukwy12n2/mOjnRj9zTXWFLiA/r/eL97TZlWqeAzPMhrZ9cJm4g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6607
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

On 2/17/2026 12:13 PM, Anatoly Burakov wrote:
> For FDIR, we have byte arrays that are supposed to be limited to whatever
> the HW supports in terms of flex descriptor matching. However, in the
> structure definition, spec and mask bytes are using different array length
> defines, and the only reason why this works is because they evaluate to the
> same value.
>
> Use the i40e-specific definition instead.
>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>   drivers/net/intel/i40e/i40e_ethdev.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/intel/i40e/i40e_ethdev.h b/drivers/net/intel/i40e/i40e_ethdev.h
> index ca6638b32c..d57c53f661 100644
> --- a/drivers/net/intel/i40e/i40e_ethdev.h
> +++ b/drivers/net/intel/i40e/i40e_ethdev.h
> @@ -631,7 +631,7 @@ struct i40e_fdir_flex_pit {
>   /* A structure used to contain extend input of flow */
>   struct i40e_fdir_flow_ext {
>   	uint16_t vlan_tci;
> -	uint8_t flexbytes[RTE_ETH_FDIR_MAX_FLEXLEN];
> +	uint8_t flexbytes[I40E_FDIR_MAX_FLEX_LEN];
>   	/* It is filled by the flexible payload to match. */
>   	uint8_t flex_mask[I40E_FDIR_MAX_FLEX_LEN];
>   	uint8_t raw_id;

-- 
Regards,
Vladimir

