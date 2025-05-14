Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57312C3ABD9
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 May 2025 10:05:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 69C32402E5;
	Wed, 14 May 2025 12:05:01 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 5D406402C8
 for <dev@dpdk.org>; Wed, 14 May 2025 12:04:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747217100; x=1778753100;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=BJ8qHsqgwYqL7pHwFRBa5m7MbVags1j27OCsaWCHo7Y=;
 b=ceP8UvP8yp9Pxlo1Duo6Cvdru4jHYtcDVJ2ztBwpSqip4rX9Y8/tZoP9
 owuqB97or7m7cGL2XIwRJSmxV8A3kAd4PGWa5npgkdISg9VwygSPeFD6U
 +C8SiYKcdkiB34mwdJvwZxTN1vUfa7O/8OBqLx4hqrIk4ynvv4zEuT+IC
 S10RnmjO+BYEdjNM4xK33zQsdZQ2ZV9QgJUISdiJfhCEzEWs2IFfekwhG
 DSvoe8rvWNYTwmvRqDfeQMwrZTzVY1Dp3HbQAE/n2UOCyvD6OuKipPca0
 bZKjKw5djAu+QoGgvCg3PRKr/gCeaNkboGt+RXS7VN8LAPfCp8Moz8ZUF w==;
X-CSE-ConnectionGUID: nhIRth/aQ6qrCkHpdCMurA==
X-CSE-MsgGUID: eNUGuS7zTmS57aPFhfyZyw==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="52913809"
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; d="scan'208";a="52913809"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2025 03:04:56 -0700
X-CSE-ConnectionGUID: ZMydwUAuT6GxRDpA+2S3KQ==
X-CSE-MsgGUID: Vln1iCRcTKeHYdQNH3dOqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; d="scan'208";a="138980065"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2025 03:04:55 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 14 May 2025 03:04:55 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 14 May 2025 03:04:55 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 14 May 2025 03:04:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KxPCkE/4CrmYHWToHZQodT/jdRbYT3u8gapeFfebiZloRZqi5wTn7YmfxeplMrkFjUS/7OhOq5FzNDuhvmgoNNlzyYqkCCw4smMgv7zgQGtp1+gK7pbnWuF4+FSXglrcoMpSx2LTd1R8YZWrmXh5n09rJk32EsWNkN+Gc/XHf7HGiSp5szJbnJvVhdaPe/554xfLddRBuSxQOQ+PY/V2olO94d0vmoRS9LhhgCeZSWzE07pomWfO7SGKqPvzINdLvqVFuteMriiYFvXJFh4MvA7q2Q+KBQwHZk4dZC/6L+vmEAI6pbEsX7cCxIFbjej6COIjiiobg+09s4klEcGCmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+9s5LtiiTnLN8tI116vDGOaXr6ASN19wvXdMvOxGvc=;
 b=hMT0jdSG45NvMvfvF653SygtaSLig1yfT+sNwDTpfKbZq0UtqgbjDcGhoTz+wDLoW2sf/cDxF8Ol/OLxXRg4hf4yRrsP8Z7qkE+2eoOU+8zvydPSQf9WZndWskNFmCTTouWTC9L4g9jNw3pjuI99xTcLIls8acsG11wz1dG7Ipa22pgLZyWnFxeu6Uuvf/dxc4ebz8hnEhutMoD4eQ+4majtzkCs/DuyMloc46GyBPR/Xs4fKjJWwD4qJx45VUT/k807oxcWtFd2zm6OvofG79wR48ROMV8qaGC32Abq43pdaLx29CfpwMKb22XTqGWilJTT8qZzi0YBGqHZwpQg4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH0PR11MB5192.namprd11.prod.outlook.com (2603:10b6:510:3b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 14 May
 2025 10:04:52 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 10:04:52 +0000
Date: Wed, 14 May 2025 11:04:47 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH] doc/linux_gsg: remove note referring to old pkg-config
Message-ID: <aCRqvwHqkj6RyBI8@bricha3-mobl1.ger.corp.intel.com>
References: <20250408171902.2833850-1-bruce.richardson@intel.com>
 <CAJFAV8w2g9=-=Y5soQD14+-=xZ-eE-2pG-RekE8a+r5p=17cjQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFAV8w2g9=-=Y5soQD14+-=xZ-eE-2pG-RekE8a+r5p=17cjQ@mail.gmail.com>
X-ClientProxiedBy: DB7PR03CA0098.eurprd03.prod.outlook.com
 (2603:10a6:10:72::39) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH0PR11MB5192:EE_
X-MS-Office365-Filtering-Correlation-Id: 81603c54-c9ce-457a-1d83-08dd92cec4f2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ekMrUjJhMG9YMVVYTlpPNGp6TlY4Vk0zZDBNYitXaU56NWN4WEgwRXhyOEwr?=
 =?utf-8?B?a2tWUWpWNHl6T2trcmZySWRzT0dkRU9kdHRCUkJMZGFXT3FnMU1DNVhOUnVj?=
 =?utf-8?B?UVliaENMWDhqRUVjOUhPOU9BMnBiL1JWVnFuVk55clZkNWFXMnRhc21xSFB6?=
 =?utf-8?B?Sk1rbjV3c0hQR09FMU91UUVmK2ozOEl5bDRTVTlsYjB0MFA1R09QU0h6UVRa?=
 =?utf-8?B?RjFjczQ3YzdNUk85emdMaktQRk8vaDIyNjdkaG4wVTRjWGFzdGZxQ3h1aklX?=
 =?utf-8?B?UEFSakoyR1BFNG5uY1R1SUxxRWI4UzA5cFhWWjVzWFBPNXJTUVF2cnNJdzdu?=
 =?utf-8?B?YjB6RzdHbWNhNXpFVnE5emRaOGdXZE1ybStjMUhBODFNeDdHTDd3U2tDSkUz?=
 =?utf-8?B?ZFlpbktOSUdIQlJVZlAxREdIOE5XcXdNMEllKzVna0oxZWFsRXdOR0JScFZo?=
 =?utf-8?B?YnllQ25rdzdlWnVLYWhGalZNanNsclRWRWx2bkEzWjVzSlFrMGZaZ01WbTUw?=
 =?utf-8?B?SDFDM1BsTmdaTjNJaUUrRUVFZUJDelY0eXJyeGFLVCtjdzNNLzcxQm9DRDBi?=
 =?utf-8?B?UW9JNjJhS3ZtanpOeE5TVVhPY2RILzgzU3QyZDVOajdqRkc5eWI3ZCsraHdG?=
 =?utf-8?B?TFZkcFpadmF2ZjhzOXRIN1FwbWZKYlE2WUhWdStPbnYydWRua293clhkOWRY?=
 =?utf-8?B?TW5jRmdDQjRjWC9TaStvdlZlNVBUTTdxK0dJZUJEdmRWMVRkenJaOXV6Vkdq?=
 =?utf-8?B?MDZLSzVSYSs3c25YNjkvQnJqVHpPMFE3L1dmM292SzdxZUpKYVppRGt4bTRF?=
 =?utf-8?B?UXBlQmZRSFlnOW9FYkg0RDZaMzhhdGlMc0lsb25MQTd6QkNaTkxpQmw2WDRO?=
 =?utf-8?B?ampoTyt2VG83OFBMd0UzK1JqcHU3QmV6RjJtUUlNSjJwQ2NVbFFKL2s2dGxj?=
 =?utf-8?B?dlhTbEdaWC9tZTFiN01ZdmZFSWVYWU1wbi8wRlRMck16cnVmSXpla1ora1JK?=
 =?utf-8?B?RkxWQU1FSDZ5QUs4S2tWVXVRQ0d0MWIvN0pZd1lLdFd6NlMweGRrSDQ2Umxu?=
 =?utf-8?B?aXpCNW00RU1NQ1JIUlZWRGYzZ1VHNFU3L1ZpaHc0RU5GZ2NOTmJBS0ZnalZx?=
 =?utf-8?B?QmV3TFBLL1loQ2M4b1Vsb0E5THdEWVg4WlZEZ1BxVUQ2TFZMb1pxeUhPNS81?=
 =?utf-8?B?eGhTa0J3NC8rNC9jeGRDMzBHUGxvQ1pDZnJCMFJJVmphaW91ZzlYSlVSeSti?=
 =?utf-8?B?S0lCNWQxVi9aNUhSZHR1UU0yR2dCV1RtZGg0SmdWalJUc1V0bWFyVTM0cXFp?=
 =?utf-8?B?RHVZS1RhUUFWU2QyWWllNXhBR1BDVlpFV0l2K0xQZi84TElYOVovTDU4NFNl?=
 =?utf-8?B?VTg5eE9aMFQ1VDhtcmhQa1N6bkkxQmgxaEtoOFNQbEV2MGJQL0RHRUQwbEdU?=
 =?utf-8?B?ZUlsdWJwZHVFNERZUTBHU3Y1ekZadXkveUloZ0hxN2VncngwV1JBQndBRlFZ?=
 =?utf-8?B?Yi8yK0pYQkk2eDUzZ1dieHZFOGVVUjRkOFdhM3RhZFdTUklyZHdpbW8yRWtv?=
 =?utf-8?B?MUlHb05lM1d0RCsxeklmWjJkOWI1K3gxdUI5N1JmOVYwWHd4ditpekRxdkVX?=
 =?utf-8?B?VGRGaThuQ09DMC9nMzF4T2RMS2VVQ3BMa0Q4RmRpZmlhb1RJek5sL2Y2aDYz?=
 =?utf-8?B?Zi9xd1loNHU4RHZYVWwwWVlFSDJKTG5hK3ZNcXVCL051dmZ3VCtFbzQ4dzVr?=
 =?utf-8?B?ZkU5THdOYzVDZWwwZTV6WWxNVk9MUUJpT2tPQUIxZ2tzU2ZRdVJ1MVBUU3g4?=
 =?utf-8?B?UktjTGxjbDVjZHBVNmtSMnBmamhXWlBGcU5EQ2ZDa3A4ZDhTQjh0MTVGdm5X?=
 =?utf-8?B?d3lJYmsrbFN1Sm5YRVM1SGlSdXd1RUZQbW5oQkQxZko3anR0Rzg1ZzdnMkQr?=
 =?utf-8?Q?4Fy9EyyMLAY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWYzWTBnbDEzdEEzMXBTNCtUR3B3aGQvYTNIeTYwVzczVC9HRUFkRzBqOEIv?=
 =?utf-8?B?aUlRTFRrRFJpRXQwM1ZLNGRTdnF4UUNtcTNQcXp4VVpjVGN0VEhCd01ZWTdj?=
 =?utf-8?B?KzRBcDNYZ09od0dOakxyWHZLRlNuUDZUUTBZQTdCM3RRM1JGaTZmT0RiRWpG?=
 =?utf-8?B?NWliTlBZWHVWUTVid01PTGEwVEQvTERBL3RCRzcvS3BSb0xST2hrTXpBVUF3?=
 =?utf-8?B?TFYxdU9uclc2aTNsM1N4bU5hMEN3Zmhqd1BITCttTklBcnh1TUhFT2RGZ29n?=
 =?utf-8?B?ZkVmZkVJUUF1SGh6QVNHaDVJT215dFVwVFIrNXhpSFNVS0JYWUNFL0dTWW9k?=
 =?utf-8?B?THBEa3BBajF2WUtDMDc4Sk4yZUorNVVrUGczNkZIdzVMeC9uV0NJc1QvY1pt?=
 =?utf-8?B?TmdJaDlWak5aNDlCaU1EaVp5eGVseDJCOGpEYkx5d21tekNLYXBVMmVKb2hi?=
 =?utf-8?B?YjRDbjBaU3hza3VGT1VwbFhYRHEwaS9yZE53TFJCdGZiUFgrVEZ6VUNEeDQ2?=
 =?utf-8?B?c0N4YVRXcFhiQ2tzU01ZWWorK3VzdHJEdlRQU09aVFQwSEUzcm9Yc1BmaDZU?=
 =?utf-8?B?S09hZUkyaHJQbEl4aEZ3L1hNWkQ3aDBFcXYweUg2d0ZyanJvZ0JIR3YyNEZW?=
 =?utf-8?B?UnMySmhEam9sTjBLYXY4SStYYUhkSmpLdmgyNG5BRW8zRXh1N3d4TVlOY2hZ?=
 =?utf-8?B?alA4ME0vWWNYM0h3d2tKM1lSQUF4RmwwYktESFRzdUVzL202VVd5cmdrZHBX?=
 =?utf-8?B?dW1ZZlVaOFpaYXpnRmJBd0V0eTR2YUNTQm4wWGRiQ0VqeWRwRWpGdmRoZmoy?=
 =?utf-8?B?YjN6dDFsaElKQjBkc2FOUzFYSTU3OGFtMzBvckFnMkdnbko4TVVvVm01UW1R?=
 =?utf-8?B?YTVnalFROEJaQjFlR3NVZjlJRWd2dk1mTkRCNkJubmQwNWhkaXZkOFI0SWhx?=
 =?utf-8?B?bXh3UjFEN0JWRjFWNmFYdUIxWnJyQmgrUE9VZTNrRU5QYTJtS3ZLK05PeTBH?=
 =?utf-8?B?TkNCSEF3UDdLVFlmc2JJSXdFN094N2NxS2tRTmdUeDJuWEtxb2pTOW8zQjU2?=
 =?utf-8?B?cFdPcTZ1YlJ4bWVPQWU1dm1LZyszdUQ2MVVZdHc5aFkvSHpVSHZWNU5lbzFK?=
 =?utf-8?B?NytFd0wvaDg2QjdpcFR2Wmw0MEZiaitDWVU0NzVtc24xUHAxNDY2OGd4Z2xy?=
 =?utf-8?B?YmtnZnBBeEZ5MW1QOE1RYWZqKzBnWmx6d1BUN2wzaEhTaTRxVmZJYjYxaW9Z?=
 =?utf-8?B?R1VJYmFWVHV4Q2xodzYwZ1R2bFhLZEcxam9oTXVrYXlpTVBGellueUY1bC9U?=
 =?utf-8?B?UExoaG9MdzNmR3hXVjBDd3VqbjQ2Y0ZkUW9BakFFMEkwWWFURjZFQ1A3U1k5?=
 =?utf-8?B?VUZIbDNsNStZMWF3MGZZZnV4dnlnVFNaOTI0Vm5YangvTWNLb2RUcjBSenZW?=
 =?utf-8?B?U2hEeUo4T0Z1ZVJuQ1ZteTZoL0czY09YRGdqSjRaUml2T3RQdGljclJ0MDlZ?=
 =?utf-8?B?VGpsZWFOUVVLUEF3aEk2MksyNjhRTDFzSjhuV2Fqb0l6cFlRZEVYblJOZVJK?=
 =?utf-8?B?NFM0Wkg0OVBnN1gxcUVpQUxRMyt0cndsa1UwMG5tSEw5L2N4ZnRPY0N1MGs0?=
 =?utf-8?B?MmhNSWxCN0FmazBkQzk4MWIwVjlRZThRR0ZMRVRLa0VwYndSa0RVakJRUHRH?=
 =?utf-8?B?M0JLLzhFZmhqdHkvYmFMbGZBaE5aQTF4WlBsL1dSNUxZNzRNb2ppY244R2lo?=
 =?utf-8?B?OGJvUDZjOXNGcjdtbjVRK2wwS09OTVUwM1RzUUdxRFg3cUdpTnBaRkNXelZr?=
 =?utf-8?B?NGpCYkVhVFgyZ2NFT0E3b2J2T2d4VUJhcjBJOWZpeVhXQTU1UzNsbGRiVEFI?=
 =?utf-8?B?Q2Y3U0hYc2g3a3oyT3NhK2JMWG9DeEE0ajBmS0VySys2TTJBYzR0dDZKUG5E?=
 =?utf-8?B?R0ZsNndPbHNGRFV4U3U0bjlkOEQ3aTRPbnE0S1RMcThNQjF2cGRLeUlHdmNt?=
 =?utf-8?B?dlovMDNaWDZnVG5MNmNIYU5rbmJiTVYybHJMN2JxYWRWWVovOG5SOWJHRWVu?=
 =?utf-8?B?QmV4NnJqSEwweVBuZkNFbklybW5HMnIvOXI2WllOWmlGOXF1TWE2bTdOS3FW?=
 =?utf-8?B?L0J2cGZPcGNFdXlZQ2lTM1k2alZZZEZrVFREeVc1d25SbW1vNzZoemFJdyts?=
 =?utf-8?B?bEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 81603c54-c9ce-457a-1d83-08dd92cec4f2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 10:04:52.3791 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mRM2EioksG7t9P714GqyzFyDESU7uwkxacBaLvhh7OpEVpn6dgv5fg4D8K52+MUTTw39K4sI1kJtJKPkHBS8o1y3GJc7kLBNCibXXPOAZvM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5192
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

On Wed, May 14, 2025 at 11:12:27AM +0200, David Marchand wrote:
> On Tue, Apr 8, 2025 at 7:19 PM Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > Latest DPDK releases no longer officially support RHEL 7 as a target
> > platform, so remove the note about pkg-config not working on those
> > systems.
> >
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> Reviewed-by: David Marchand <david.marchand@redhat.com>
> 
> I see examples still refer to this issue, could you send a patch
> cleaning this too?
> $ git grep -l check.for.broken.pkg | wc -l
> 52
> 
Done: https://patches.dpdk.org/project/dpdk/patch/20250514100306.11717-1-bruce.richardson@intel.com/
