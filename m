Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29FFC021AA
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Feb 2025 17:28:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B33BB400EF;
	Mon, 17 Feb 2025 18:28:57 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id D7730400D6
 for <dev@dpdk.org>; Mon, 17 Feb 2025 18:28:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739813336; x=1771349336;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=vPu3Exoz1fxTB5QWF7stHffemUItpUGoflwFAEff+HI=;
 b=aC9hewq/T5BpWiIv3VAvAua4L3oH3aMOUNdjiGTazTwuNanNsWwxge9d
 ToXhwqO0XxGy1BIielDdR+RF+mzsusYyiC5GRIbdwv/3zjQkRsfvTbKy4
 47DNMd9D2eIu1vcQ3G5XhB3gqDWeHt11p720VBVvWTAamT7N6JSRFUoNB
 bRrZgs0pIIhBs9jSOzQu+Xf0/EBJjOaJVwIOs6wqX/0D2vFsLv4eP9sWK
 EzHEBowe79GMNqNISUMk87SEW1w0YvkwI3FgYkvXstuGtpAIoVPtdY0fd
 4tLwli3T4wnXqvLQ6AIZauErcCL95wU4A0NbMlnzzWUWJ5DIEmidfrPzQ A==;
X-CSE-ConnectionGUID: HHv2QOS/R86Shz2pOXmZyg==
X-CSE-MsgGUID: yPq3aGOsSo6MGCkLUdVuiw==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="40527881"
X-IronPort-AV: E=Sophos;i="6.13,293,1732608000"; d="scan'208";a="40527881"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2025 09:28:55 -0800
X-CSE-ConnectionGUID: THzY/eB3SC2qDFHh8Fd+mQ==
X-CSE-MsgGUID: aLefX41USoei+ugCt5496g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,293,1732608000"; d="scan'208";a="114156498"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2025 09:28:54 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 17 Feb 2025 09:28:53 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 17 Feb 2025 09:28:53 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Feb 2025 09:28:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u1l7I/60EZbJ4Iw6OzrOvNiC0ullUm+lc8qB92YePcotpoYHCCHmKnlunP/rRqVEq7mjQ68iiqeuVsN2kzlRyu9iSAxmhL5Z5Vk68otOySZKj84pCV0JmxlCHX+cPC/UcrmvpxYvlhbtxFPVy8uaQTF0aoTXFsrZekuMq/fTv2w2ZJfO7BpR06vy+tzHwZgdpjMxDzhGiAeze8vZcK/lap6uGq1x/vK4sw9WpdvPrH1M9wu8/biIfQ5i4r+Fn7laART7/TMJbRz0lZhsAWa6fz1Kux8NJG7KeO5WpCy4kyVosRKQB/NKlfUCjlOejj0lGTzKXQ7x9wgmEkr5LvO5kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qfp2I+TeT/uaP4z8z0w56rwV0sznxmLy1cokNlhqVVQ=;
 b=k1PJqMPBp2d7QDfTrJiBGrqSDFs870FG+W8NQBeqgteSIS41cYKMeyqX2nIUWjEI4/0D8MCTjQjCvMMvssRJ+DTkLL3r5TaTaolGJ1tNNVKIL+8fFQy+VZw0BCbqOczxDgrFBD+lyBppo2Bb55Bx/zCsuu/VtNvMbpw47BMKPbMVbZkXaWrmGXQB9vSiLE0F8MDBIrlQL1Pq2E59yyQRT3wYkd60P+HAOcuYBk8UhYs11MjqvJlAyjbI/qkM7I/tySLrP46qSweFmFVn9SQi/+iRICH/VWNQtnniMgoLQShjjhG8/3zrKZl8fu9ruO9aF4UV653EStyyP62Hc1ilog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5772.namprd11.prod.outlook.com (2603:10b6:a03:422::8)
 by PH0PR11MB7470.namprd11.prod.outlook.com (2603:10b6:510:288::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Mon, 17 Feb
 2025 17:28:04 +0000
Received: from SJ0PR11MB5772.namprd11.prod.outlook.com
 ([fe80::5851:319:3da6:850b]) by SJ0PR11MB5772.namprd11.prod.outlook.com
 ([fe80::5851:319:3da6:850b%5]) with mapi id 15.20.8445.013; Mon, 17 Feb 2025
 17:28:04 +0000
Message-ID: <5465b94b-e415-453f-a826-a4ef5b445252@intel.com>
Date: Mon, 17 Feb 2025 17:28:01 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] net/ixgbe: prevent crashes in secondary processes
To: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>
References: <3c323577ce36cf4425d2c2def85d0d6644b87dc8.1734020337.git.anatoly.burakov@intel.com>
 <11dadf1bf66aa2129a08b588b68ec0a8c992cfaa.1739800426.git.anatoly.burakov@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <11dadf1bf66aa2129a08b588b68ec0a8c992cfaa.1739800426.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU6P191CA0015.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::16) To SJ0PR11MB5772.namprd11.prod.outlook.com
 (2603:10b6:a03:422::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5772:EE_|PH0PR11MB7470:EE_
X-MS-Office365-Filtering-Correlation-Id: 70e9cc82-490e-48b8-4717-08dd4f786f9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U0lJSFFqaHFNSTNFeU9wM3lSK2R0SFptOWFYYUFhb0p5SW5mUGpLOVlMWmQw?=
 =?utf-8?B?M1R6a0JkSUR0dlpJOVJkd0NyVGtDblJTREF3cUptQVFiOG9WWG1NaHZzcy90?=
 =?utf-8?B?Uk5remh0bXpxU1I3c3dyNjQwS0FkbDB6V0Q2RnpZOWtTQ01IN0o5L3lQWTJS?=
 =?utf-8?B?d1VVVklIMUd5TVFUc3BEa0dSRmlwVDF3OGNwVFhuZFhtVTJWa2tKb09LbW81?=
 =?utf-8?B?MVRzZXdIK1c1NWY1U1EvMk5iUVkvVktGS3hCSjZQVDB4WFJMZkVVWk8zYTVC?=
 =?utf-8?B?Uzl3Ynd1Q0V3ZmROR3BrZmZMS1NOU0x3ZlVUbzhYK3dZckhRNFlySDMyb3hi?=
 =?utf-8?B?MW5TMjU0aTltS3ZCOVBRNEk4Y2Ura2tpKy9GQTVndmE5ZmNYL1llSE1MdFhs?=
 =?utf-8?B?YmFxVmxTcWdHR3RXSFN2UTluc0NVUkpLdjkwUzY5M2JIZ08ycTA5clJ0VDNI?=
 =?utf-8?B?d0thRVVZTDVUejRxWC9FZVhoa203TUpWUS9RM2t6ME1ueEJTWkFkbXUwdEI4?=
 =?utf-8?B?NEFnSEdxdUdiM0NGcVRQb0s3cVFDeHZHUFNYdjJVSzVGakw2YnJHZUM5bmdx?=
 =?utf-8?B?c2ZaK1lEL0lFNjB4TDZiK0xLU3RIK2N3Y1haZTFmdHBKdzBVYklZVEk2L2VF?=
 =?utf-8?B?bzNwTDl2U0VTSFZWS3ZyMVB1eHRHblVyZHNSQmpEbEhhbDh6eUVRbUFDSGd0?=
 =?utf-8?B?U0N3TWVvZXNZdlpuVGo4YTVQZk1PNDBKVHdjOG9KYlgzR3U3UEExU1dzY2dY?=
 =?utf-8?B?blhLWGgxOTZRY0hrSFBJMWFhZDdZdmtKcVdXK0dVVEt2L0g5bnNEcUpmdUFo?=
 =?utf-8?B?dXNFN1ZHMy9ORGFZWUVpQnNqM3RTU3JKZm8rSlNRSGd5QmhqU0tOdXN5SmlF?=
 =?utf-8?B?SU40bG1vVDJ4ais2Y1RGS1FUWVpnTUZ1b3VYdmd5NjQ2M0daYzBTbXhaWDI2?=
 =?utf-8?B?M01ZeGFsYmxSRmtKUXp6VjlmZjE4RTR2enNnTVpVakpsMlhDODFmNXVVcDhX?=
 =?utf-8?B?UUZNQ3AzdDNZWElsK2UrNXE2M1g0S3B2bk5zeEcxZTV1eWZITEZqMTZCRHJ2?=
 =?utf-8?B?M0U0b3VDNnVYSDZMaUtrMWNWUmtXdVBWVjJHWG1hZUVZNisweEt6aFhGZnpm?=
 =?utf-8?B?YnJ4LytqNGd4MHhMRk5VdTM5eFpsN1hhYWdPbXlrem5RK1c2WjlHVmFnNEhh?=
 =?utf-8?B?TEF2ZVJJZXBodWxTVUdiRnlGOUpTTHJFM3VpOGo0M2hteVlhTzU0UHk4Zmto?=
 =?utf-8?B?M0JvekhpSWNBTThqYU9zVGtpRlo5Y1BGb1VsT3NJaThINW1TckJraFkweENl?=
 =?utf-8?B?WDBXQW1CRTFaMlBpYnJ6WVJtb3FjSFJpb1V2ZUxaWVJFSnAzVjVoRHJsVnVp?=
 =?utf-8?B?UWRpRHYzSkw5TmM4UnB5ckdJRUEyRlg2d3EwV1VPTW9WQmJkbTVkRnBNZDBl?=
 =?utf-8?B?anhXN3BvRVdQWnpQT2hrc0I4emY0Sm9TOWd4WDRYeUJWdHJ6N2EycG9ZVldr?=
 =?utf-8?B?MmgzeXhzcEc3Z0dnYSsxSEhXUk1SZVRUbk5TNXVpb0hCNDFHUzdEMjB3Slhn?=
 =?utf-8?B?Rzg3WUxoa2svR2xyclE0RTEralZ0ZXNWcHVscTRYajhNQ2VQWlJ2SWZlcnE3?=
 =?utf-8?B?UjJhQ1JvOEUwdnppVWFhU1MvMGxCNEEzSWNGRDREeW5UU1N2bmxKMEE0bVJ2?=
 =?utf-8?B?WmNCK3N6WmtpMThiOGdpL0xrVTk2cXZGWWg4bkpWZlh6VDBpZGJIckxaTlIw?=
 =?utf-8?B?T1RWWVN4NDBrcEpmMnEySEVjb0VSdjdCdEE2S2NxK3hIZGVIY3pKZGNuT0o2?=
 =?utf-8?B?NkJGaUhjVUZzVVV5Rmt2K283em0yblNPRVdxQVU5TEtLblJaN2lwNW9oQS9P?=
 =?utf-8?Q?odY6zCSiFQptE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB5772.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGdjcTFxelh1Und5TjRPUExLYm51QTZPbXFscG5sTG1EYWovZzJobnVka09v?=
 =?utf-8?B?ckRGcjNqcGFycDdVNUErK2E4VitnellCdlI4NlhmQ1RzbW45bEJYVm0rV2VI?=
 =?utf-8?B?dERHV2F1b1A0UGUzQ055QTZORjZFNWN2akR1Tyt6RFZYbHhzUmxQTUVQbmJU?=
 =?utf-8?B?NHhwUVIwQlAyYUt6TFNoWFl2b0ZjUjdvbi9sUWkxd3lVOEs2MHBrL1RISnZh?=
 =?utf-8?B?S21SQ0U1T1M5RUZJRER2eTZpZGt0bkhISTRQT25HYTBKd2hoa1U2UDExc3Vo?=
 =?utf-8?B?aHhYWlBYbUlqQS81bDF0aThOak1iTTVleWhyeWxobFZYUEJYSGNHeHdIU2tx?=
 =?utf-8?B?WGtwZGVYd3NIQzlJNG1sckk5RkNDSm5oSmx3ZTdPeHBPN2NMZktkS3pqSUVy?=
 =?utf-8?B?ZFVPT3FYRzA4T0hmdEpiZjVtNEppQ0VDL09RbzRlSGdyVUxLK1Y0RlZSOEQ1?=
 =?utf-8?B?amZhamNKRkVCMjBZNThXSjRXc2R2VFBBcW40VGVqQmkrTUg3OTBOVm9lK0hD?=
 =?utf-8?B?dlFKQk5hY0JKem40Uk5pai9GQk1KUWlsSW4rVGtqcVZWMElxYXRWTVAvbWhs?=
 =?utf-8?B?WnU3QnJlQUNEUktRSVRSTUpFQTNWc1JOQk5GRWc1aHlVYndVQkZPNjJYL3Fk?=
 =?utf-8?B?SDNwc253bUo2bDRKQW9KR2xZOW1mbHhvczhibWs2TVR2UGJhbDJMMHVpZXNt?=
 =?utf-8?B?ZXQyelJRbmdubVNiS0trZVFDTDM1SXZ0K1BGTi8zcEdRemVPWS84MDd3L1BP?=
 =?utf-8?B?dGNjc0NTMU5zTDAxSVZ5Z3BYTVVSSW9ydzNDNUtzR2hRZzNJUVRoL1ZILzly?=
 =?utf-8?B?UCtEQXpNcEltUjRFYzkyZTVqK1JKeHhCRU5zanJ2TDcyRk9KLzc1V05Ha1pp?=
 =?utf-8?B?cW9QSmRBVXNRQkpoQmYwa0NDNytTV1BkUVlud3p4SVlxQzIyRGRtUW5oTDlV?=
 =?utf-8?B?THF4eDRKdkhablluUUNqU1FTWE43cnlzL1pwcDNaUFE2aVlsbWU5bGtFbnJp?=
 =?utf-8?B?ZHZCN1E1RENXbFdQbXVEQ0dGWGRydUVZTkhKc0FqRTdPS2pQbmFaNklHYk9Q?=
 =?utf-8?B?N1hSdGVNbGNBendRdG5jMG5qRWRDcnFWdzh4YVdwNExJNmhBRmdmZUxBTUlM?=
 =?utf-8?B?ZXZ0NXg3UFA0bjRwY1hGL0NtbnRNd09pa3pPVm43TTFaUlZLRnZsYW8xK1g0?=
 =?utf-8?B?bVRaTGMzdm90SmovbmFyYmdCV2oxdkZmVllQMEQxbGNSY0g2cUFjdTJ2bkl5?=
 =?utf-8?B?VGY5MlVYOE5DdW1MWVhheTY0ekQ5NU90cGU5bFBaOXdxS2szSnU4TkJNN2hG?=
 =?utf-8?B?Sit5eFhxWDlYc3pIb0d2TEE2bU1Ta2lZSDlWWEFHMWt3QysrUmxvMnJFR2U1?=
 =?utf-8?B?dmRySVFIM0RZbmQwK2Nsc2NYaWV6aVJ2bEZLK3A0VllOVHNFelJUcVoxMVdr?=
 =?utf-8?B?a0o1eWJKWG1FdWJTNGFZcEhGY2hhLzlucE1mR2hFRGl5RXhIMVF4UXRHdXdq?=
 =?utf-8?B?NWJYWXdsMy9XMDE0M05GcGNmYXBOM1hHbFdiM3N0aXVzNWVOaHJTcTE1cWI0?=
 =?utf-8?B?T3RmREpkSVJUNkRENENNZkhPZkJsQy96TCtKTllvUVg2c2hkRCtjcUh4bDF5?=
 =?utf-8?B?SERJS2xEZmIza2k4OXhPcGN2UVdESkFtcUFKelF4MHFubW5EMnpYTUVIRm00?=
 =?utf-8?B?RldoSFNHZndPcUY4NnhHQUl1c2VkdFV4LzVZZ29iZHpkWU5nMjVkM0xVa3ZX?=
 =?utf-8?B?UGc2VVQyWFN0dDVmS1YwWSt5QUQyT2hSWFpjRk5BNmFTVmpKSzFCa0Nnd2x5?=
 =?utf-8?B?WFdkclprWjBPQjNjZk1uV0F5ZG01QndWQTRod1ZpRm40ZStadkllVGVIeGkr?=
 =?utf-8?B?WG1pV2dRUkdqSUVTQ2RFK1JkODBNTGhrV3MvbWoveHhzcStOc21lbHZiemVJ?=
 =?utf-8?B?Y1NKYWdQUEJTNERsVm9qUHFuanJCQnltTU9yTjZ0WktsSXBNYzV5V3dGVjFE?=
 =?utf-8?B?MmgzalZiTk5CTEVxeTVNaW9DMDUyU0RzZUZsTHVUQjFaNlRZdkRoQVVxV3Y0?=
 =?utf-8?B?Q1BvSjF3RW9waTBiYWdJSlhaMHdqR3FVOWJwNGVobUpIRWtlc1ZQOEJtekhv?=
 =?utf-8?B?L09KbnR3OTRRVS9LWUJ2d3ZWc2tiTnp0NU5MOFpZVW1aOFprTm1PVit0LzU0?=
 =?utf-8?B?b1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 70e9cc82-490e-48b8-4717-08dd4f786f9f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5772.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 17:28:04.6251 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Mqamk5eN48J7Q+7jPRrqSR1l724yRjAOtjdstj+lmGSzjtkgWOonoLj303BLLcFGtarNRse2eAjJOdndZU6BlnaY+FjmMuSgdBfIdRpYyM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7470
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

On 17/02/2025 13:54, Anatoly Burakov wrote:
> Currently, the architecture of IXGBE base driver is such that it uses
> function pointers internally. These are not guaranteed to be valid in
> secondary processes, which can lead to crashes. This patch prevents IXGBE
> ethdev driver from calling into these functions.
>
> Bugzilla ID: 1575
>
> Fixes: af75078fece3 ("first public release")
> Cc: stable@dpdk.org
>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>   doc/guides/nics/ixgbe.rst              |  14 ++
>   drivers/net/intel/ixgbe/ixgbe_ethdev.c | 242 +++++++++++++++++++++++++
>   2 files changed, 256 insertions(+)
>
<snip>

-- 
Regards,
Vladimir

