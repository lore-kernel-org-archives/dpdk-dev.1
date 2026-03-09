Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228B1F3C255
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Mar 2026 13:26:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C9FB6402BE;
	Mon,  9 Mar 2026 14:26:18 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id B4BB140261;
 Mon,  9 Mar 2026 14:26:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773062777; x=1804598777;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=OleMXvjpP6nYFktSG/xXp/O+J3XDC15tblldtXBkXFc=;
 b=C5Y3o4aRW1lvRUhUbix3jU3OcB5dOr/y4mIrDsO/Bte3FRwadlCE4lDw
 3dBoHdrD2adv/vMCkMr8u6rE+8ZyVyqS5lfogkJXxxMyt1mpT45PsHa+I
 hvEgUJdSLCvH28aj1d4Pwvmmr4O+NXEFdtXykQAf37iAbUsKjV/itexls
 sMXp8Z3kn3tc0VsghMqA+zSwn2N6RCu38Lo8P2dSg0D5nWAlv15C6uHgw
 XofcYSFVsh7KD/LAdjnjUq8hqGmACp5Nj4dwQNniOI2WcE+a2gVkoaoxX
 cy1zULZ1rtOLL3w5Jz32nHgg5hNVYczqjwjGkJZtN6QBBLQk3tdySknJ6 w==;
X-CSE-ConnectionGUID: KQiGoptPT4aGC/mGWhQccA==
X-CSE-MsgGUID: cotFDCyJQpmcU+Eyz+Joqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="74002769"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; d="scan'208";a="74002769"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Mar 2026 06:26:15 -0700
X-CSE-ConnectionGUID: LPMDPuaFQZu8exQhibNAzQ==
X-CSE-MsgGUID: gOpQzuCzQBOsnE0XvePIdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; d="scan'208";a="218900508"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Mar 2026 06:26:16 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 9 Mar 2026 06:26:14 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 9 Mar 2026 06:26:14 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.41) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 9 Mar 2026 06:26:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x1vWqshjxnaM4h5ZPymCww/5IETbb4h9+k8Db+PswctC1xhoiTg/WbM5YoNpbfF6/piI6X9ssE3Ed2++4r1KzhAg6CAzZ0cWFF/BOGJk1JJMUFuzrDA76EOVBUTSm7cbKBetAOduVeqSrWARMMpD26Da2Qonaur4MysiNdp/3HLYXNVPhUXCy/eJActXQXtX449mtAyfZQ0tvPuzftgUhtNWk83A0qN+znL4klCGVh0W/r1Ns2iSGao+zB1KeXenZC0l/3/BrAkklVmG+5oxKpfWBzBqztHNK3Ew2Timv38GpIifR9ELxQJVQ49amAiz5hn0nwh6ad+SRr19jF5EvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yLomsCqeZJw0VhbNx/HOwu62NVfCcj8YDrhXdi4aycU=;
 b=usanCKyhBpRi4LltCQ35y5pBK+7PIFHw2Br0LWv+WelnKcn/PvnA7oF68AYu5+GucyAZqfLCfDHTqzUMOhjjGtftZnq4ahn0S33GpXgLnNxPArt82MsOzvIF6TbcS4ZfxtDOAgqgWw4OhEPh9WneBD5IcTmhbD5OORm+96zUX2JPzXM+B93wWYnTTTRKBtpfKia5oMeF23CskL6RfSm1nHCMeKpPDkhJc4IWW/UyAn4dy0ixlWc/RZUy8RS8VtigIZJCvDEGMbf1Rox3pJ/h4TOBqMcOQDlaS2/TBsrNzBvm6ahkP3T1j0fKzzrKGyYReaECWIAB5/uJIZ4Y9GK/zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16)
 by SN7PR11MB6680.namprd11.prod.outlook.com (2603:10b6:806:268::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 13:26:12 +0000
Received: from IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2]) by IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2%5]) with mapi id 15.20.9700.010; Mon, 9 Mar 2026
 13:26:12 +0000
Message-ID: <50717218-f925-44f4-aea0-310f67935025@intel.com>
Date: Mon, 9 Mar 2026 13:26:08 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/ice: fix rss simple_xor hash function
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>, "Mandal, Anurag"
 <anurag.mandal@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "alex.chapman@arm.com"
 <alex.chapman@arm.com>, "stable@dpdk.org" <stable@dpdk.org>
References: <20260309023255.308526-1-anurag.mandal@intel.com>
 <eb020e6c-8298-4041-9b16-fa12948dcf62@intel.com>
 <CY5PR11MB61167F0FA868B64B355F1670E479A@CY5PR11MB6116.namprd11.prod.outlook.com>
 <c6739905-2f99-46a1-81b5-d97464cb01e8@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <c6739905-2f99-46a1-81b5-d97464cb01e8@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU7PR01CA0024.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::26) To IA4PR11MB9204.namprd11.prod.outlook.com
 (2603:10b6:208:56d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9204:EE_|SN7PR11MB6680:EE_
X-MS-Office365-Filtering-Correlation-Id: 880015d5-5f0e-476a-b9a0-08de7ddf6e83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|7142099003; 
X-Microsoft-Antispam-Message-Info: W28PC2Y1GDGgvC+/9+cMz7KsiIh1uxtOMeOOXkQ2ymvRrDU2rhy1Q2Zr6GPw6ZaPJ89b5E+Y/Zq0LPtPARpTYdRjsv6tBXh9+EWocsTQJufE3CU0exU5u7qYVVgvT6nABbJ0fWhH4mUIk7NqR+h621P7YyJY2dzFtoWwG28SzIHPNUL/tHEWFVfV9jUuYXuy4gbcmj/v6o/kTqIeYftNQru7bAnMOhxdGWXBnusdjNxZ7vIwZTFrNg6IpVcFEDUiCMyNkFi95MKxA+KPYsKuvPlU9kqbpyikFN7GYXC9zaFaZynxFDUEgMjzk2It/eG2H9b6Dt5VC5YWcpke0QrCk/L1HLIwUTtVBU42mOKMrd00xEFIeEfShwNNqu/4jiVOAkN+2maerCRhBQIQDYny4boNBFj4GelpTyQTL9Ze44UVYgwQHoVBk1iEFdIHzsAsPSJtiZkR9vq99oJFfE2WvzmhbjaUxmr8AiWyS1K0oliH8XySiedvGIRfRxGdglrKK1po2Yi/M0c5MPb6BfLCxgwG6zKvg+ytk1KyXy5dhWEd371vcvpRFFXjpGiopPBozegVEjcLRoLfIcxhMeb0KQYwWykiM91xzvCvjtiTWChdyxCe78Oy6WvgUseYp3hssa/3e+bcDkLmHpKoE5OU8UVhvsuU+a7pa64T7DHlX4hZSTCnqoLX8C47pSedL49GTy1208Fi90AMibzwbZTaEDcikwAxWBB9VbW1kSoqiaQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9204.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(7142099003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTNjYmZUcFJzc3hWQzN4Uy9vMDU0Q2xHWUx3RUJjV3RGTHlXbWVWenB3S2dE?=
 =?utf-8?B?S2R6cUFacUhEcDVSLytoMTAvN2dqTWMvMzVRYVRIWEZKM1hFSWhvN3Bhc3lX?=
 =?utf-8?B?VzVDRE9hRHhJdmJ0TUJ4QmVWdU4veWx5QnR2amJHeGkvd210eTcrMjVyNUhk?=
 =?utf-8?B?ZXpSUGNuSG1GM3d2V2prZDhkUm5LN0hMalVTY0pxUmVTek1pV3YvaGl3WWlO?=
 =?utf-8?B?WUJZK2hSTDJoWVRUeXN2SWp1SU1YdDBtaE4wL3l6YXdpcEY4NUFsRW5UdHRS?=
 =?utf-8?B?THRrRVh1OXo1OWxSQTY0cWdhRGVsUnVYU2ZpaXNweDh4Uk1yVWZlY0d1WG1z?=
 =?utf-8?B?NTlTVEFXOHNHRXV0Z3p6czBMMm5seDhwMm5PODBDc3luNzFXSTR5QXVNZnNl?=
 =?utf-8?B?UUtwSHZBUmNFWStDdzdKbWFJTDQyUVhxcm1oU1JiMHB2UXJicEU4UFdwc0RR?=
 =?utf-8?B?b25OYU9OVTVEWXVlcjVhS1pEdE9nZGVTclpLOUtkN0R6MThkTEk4bVZ6NUti?=
 =?utf-8?B?dG9ZSGpZZVJsU2laR0JNWmwrWHZ6S2NSTGNWSjNxeUgydG9uRFJaQ1gvQkxO?=
 =?utf-8?B?bnhrQUN1NjNPclVZbXFPZWg2VmxLb2Vwa2dFdTVvV0J2aW54T0pYTXovbHZ0?=
 =?utf-8?B?TU1FWEs0LzlYMEhYZy9RRDJqbVNiN1FqVGJscUhKU2djaEZFN0pRdUZ6WUNo?=
 =?utf-8?B?Q2NvcE5mcXhkWTA3VVhHWnFzczNXeFQvVTZDUjZ6aHBRME5TRStKZmhKL2JH?=
 =?utf-8?B?QlN4Rzd3blJ0ZkJDTmw1UGQ2bkxQUzBQMlA5alVsTzFNMWpIMU5EWmdhZnFu?=
 =?utf-8?B?VHY2WHZNSk1XM0VGSnhMMkw2WExHcU93SjZUK0xIOGhtRVZ6VDd2T0NQRHho?=
 =?utf-8?B?Q2RWcG5NcVVwYTZSMENWQmM1SzYvZjQxMm9qa2tZRjhNeERpL3dqRElTZkh3?=
 =?utf-8?B?dncwRGMwK1dSdEpGOCtzaXl5enMrYVcwNHZKdHZYMXRJcjc2OGxxM1pnK0hy?=
 =?utf-8?B?Qk51MUtqV1dPb0p0TGNzRERka3V0UWRUYkxaa1ZDT3V2TXVuUFJVSSs1eFVK?=
 =?utf-8?B?SjNjUTZuTk42VEdZM2JpcmRYMnlOZ01jRSs3N0JDVCs5cnVWaFN0c3ZPajk1?=
 =?utf-8?B?SE1yRkpzeHhWcksrTEpVWWRRd0ZBTitYU3dSZVQwVklmR2o2M2JNMXliSlRl?=
 =?utf-8?B?TEFDT2NNNGFrNTQxM045V0pRUG1EeEdOWDJlT2hGd0kreE5OdCtxTkhmTHpx?=
 =?utf-8?B?R01veFVZTms3UkRaVHlObVk5c3pIdGFEL3QxMGJTeUVOMkhVbUZKM2x5bzBT?=
 =?utf-8?B?VkI0aWVTeG50S2Q3R21hOWI2V2x6TkJrNGZvUFB0eVlCeEdmcFhYNDkwRDRJ?=
 =?utf-8?B?VTR5QmxzejB4bTFHTXFGemo2QkxsSlYzaXZRM3l1UXkzMTNwQWtGZk5tNUJh?=
 =?utf-8?B?MzN2YllJb0FDYUlRRnlhTEFzRFZLaGN4TDBjanVmeXRDYjZiTit2dS9jcmJP?=
 =?utf-8?B?bE4wQUhUb2o5VElWeGFqZzk3NGpydDMvb1lTcFQ4Rzl1K2M3bFM2TEJmblZs?=
 =?utf-8?B?YnRXZVRLTVJGY0FDZjJtZkJLK2RuRXJ3azNDdFpDSTFJMkdYaERyTTFZVyt6?=
 =?utf-8?B?bGhTNnB4SEt4RHB5QTNDNkFtWjQ0VXl4dkk3YUNzQkpmenBUcjducDk4bm4v?=
 =?utf-8?B?bzRCenN5ZTdtSy9CLzJtUmRqdjdnNk5LTjdRMERHckJRdGNlcHdWSWluTjBk?=
 =?utf-8?B?ZElaSUVoRTYrZlZKYUt4ZTNvd0NPZEcyVWljbDlLeXJBOGZMWFhGVklRTjlR?=
 =?utf-8?B?YVl0OEdLV0p4eFJLTEVDejVsVkpWcEtrNSt2R3FEWU5rbEJ2OXcwNWV4aFE5?=
 =?utf-8?B?UWNBeDNNS2plRVhBRFBNR1Q4ODhlTFpLUWh6T0dkN0pwRXFiVFo0ZEp1eUtV?=
 =?utf-8?B?T1dQMkh4dE5raHJxdk03dHp5Sy9OMnArNDRSakhuOEQ5VzFYakVxQnhvREVH?=
 =?utf-8?B?UGhMemdFYnV6YU1PRDRGU1UxM29QVVN3UU1rWllBYk9vWjlvTWw5YStlQ1NV?=
 =?utf-8?B?ZTl5QThwU3FPY0crRUU4ZGFXSzMrSlpNdkZuT2QvSitzdFNteGJlc3puRUZF?=
 =?utf-8?B?b2hxUkZ6S0RwYWM5UlRick1ReklIQlF2cWh2UWc5MFlqRVVYaHc5bVpVMmhS?=
 =?utf-8?B?ZzYxY0JyM1ZiaUtKNGFhbVkraS9GOTdmd3dkOE4vMHJDVFZkTjREdThMenJI?=
 =?utf-8?B?OVdBbXBjTzhBZlAxc3RObXhpRzJhVWJFR3FXQXZiZGNSYmkyMlkrVzJZeVNs?=
 =?utf-8?B?L3g1T1BISDdIZ0tVcC9Dd3hkNDVnSGNXcmI5SEl1M2VOUVpMZ0ZGOVFxOXZQ?=
 =?utf-8?Q?MsRBlb9EPSwYFnpI=3D?=
X-Exchange-RoutingPolicyChecked: XqbAbpjUABoBmSXUJ6Op2EA9XxPccuBiTfBwQ5xJ6XBp23Hn7UZmcwVcwC1cEuMhoxQ9nc+DerYDQcu0xa6XezwPJ5mvZKqLgJ20zoVqUHVQbaBPeGFq2g6teCivk3y/S3waUPX1mWUbkwMxoVeiazgTlRakC8fbZtzYsNv09M3o8dDWfHsQt7SsYmpR+6UD85hmHCOW5z+87D3vdqrFWe+WiTjFFV2dwSOyr//xl47axLDsRcsWP2LdhcJNnvr29FUytbw0qHx4Ftlkocg4gYmU8oQreDInMyd0g8KhcM2ZPGGsbcnzgIktpSuKRGyrP1VSlCXJm8UsQNMP/Hh/Iw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 880015d5-5f0e-476a-b9a0-08de7ddf6e83
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9204.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 13:26:12.0572 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gtGnzrpzGRENZNouxgUpkCwcBMoipbnBesjvS6w9Nr7XOWg8ya0dhJEhszz4ctTZEVSQqPVBWp413pGDe1mF87Em7pH5tMFbS60eXPbbOCI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6680
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

Hi,

In the general case, hash function type is not meaningful for non-empty 
patterns, because hash function types are per VSI (meaning, they can 
only be globally set up, not per pattern). So, ideally, we do not want 
the user to specify a hash function when they also specify a non-empty 
pattern.

However, the ICE driver is not very well behaved in this matter, and 
does not enforce neither the "hash functions are only supposed to be 
globally defined" limitations, nor does it check if a user specified a 
different hash function from what they configured globally. Therefore, I 
think the proper fix for this issue should do the following:

-  interpret "default" hash function as "whatever is currently set up"
-  store the "current" hash function globally somewhere (in VSI context)
-  for empty patterns, overwrite the setting
-  for non-empty patterns, disallow hash function that is not "default" 
or does not match currently selected global hash function type


On 3/9/2026 11:48 AM, Burakov, Anatoly wrote:
> On 3/9/2026 12:17 PM, Mandal, Anurag wrote:
>>
>>> -----Original Message-----
>>> From: Burakov, Anatoly <anatoly.burakov@intel.com>
>>> Sent: 09 March 2026 15:49
>>> To: Mandal, Anurag <anurag.mandal@intel.com>; dev@dpdk.org
>>> Cc: Richardson, Bruce <bruce.richardson@intel.com>;
>>> alex.chapman@arm.com; stable@dpdk.org
>>> Subject: Re: [PATCH] net/ice: fix rss simple_xor hash function
>>>
>>> On 3/9/2026 3:32 AM, Anurag Mandal wrote:
>>>> RSS Simple XOR hash function is supported by the NIC as per datasheet
>>>> & also in ICE Linux Ethernet kernel driver but the same is not enabled
>>>> in ICE PMD even though code support is already present.
>>>>
>>>> This patch fixes the issue by removing the simple_xor check & adding
>>>> proper error log for empty argument.
>>>>
>>>> Bugzilla ID: 1518
>>>> Fixes: 0b952714e9c1 ("net/ice: refactor PF hash flow")
>>>> Cc: stable@dpdk.org
>>>>
>>>> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
>>>> ---
>>>
>>> Hi,
>>>
>>>>    drivers/net/intel/ice/ice_hash.c | 9 ++++-----
>>>>    1 file changed, 4 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/net/intel/ice/ice_hash.c
>>>> b/drivers/net/intel/ice/ice_hash.c
>>>> index 77829e607b..d57b5ee0e4 100644
>>>> --- a/drivers/net/intel/ice/ice_hash.c
>>>> +++ b/drivers/net/intel/ice/ice_hash.c
>>>> @@ -1109,12 +1109,11 @@ ice_hash_parse_action(struct
>>> ice_pattern_match_item *pattern_match_item,
>>>>                rss_type = rss->types;
>>>>
>>>>                /* Check hash function and save it to rss_meta. */
>>>> -            if (pattern_match_item->pattern_list !=
>>>> -                pattern_empty && rss->func ==
>>>> -                RTE_ETH_HASH_FUNCTION_SIMPLE_XOR) {
>>>> -                return rte_flow_error_set(error, ENOTSUP,
>>>> +            if (pattern_match_item->pattern_list ==
>>>> +                pattern_empty) {
>>>> +                return rte_flow_error_set(error, EINVAL,
>>>>                        RTE_FLOW_ERROR_TYPE_ACTION,
>>> action,
>>>> -                    "Not supported flow");
>>>> +                    "Invalid empty argument");
>>>
>>> I think this changes existing semantics a little too far.
>>>
>>> The original code disallowed simple XOR only for cases where pattern 
>>> wasn't
>>> empty (if it was, we allowed it - i.e. if it was a global RSS 
>>> configuration). The fix
>>> disallows empty patterns altogether, whereas what it should've done 
>>> instead
>>> is remove this check, and instead modify the second check to look 
>>> for empty
>>> patterns (because otherwise we would go through further checks down the
>>> line for non-empty patterns).
>>>
>>>>                } else if (rss->func ==
>>>>                       RTE_ETH_HASH_FUNCTION_SIMPLE_XOR){
>>>>                    rss_meta->hash_function =
>>>
>>>
>>> -- 
>>> Thanks,
>>> Anatoly
>>
>> Hi Anatoly,
>>
>> Thank you for your comments.
>> I understand the current change disallows all empty patterns 
>> altogether and that should be rectified.
>> My doubt  is should be allow both empty and non empty patterns to 
>> apply for simple_xor like symmetric Toeplitz ?
>
> That's what your patch fixes, is it not? It already allowed empty 
> patterns with simple xor (the second branch of the if condition).
>
>>
>> Thanks,
>> Anurag M
>>
>
>
-- 
Regards,
Vladimir

