Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBCCCFD37F
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Nov 2025 10:30:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 78AF340A7A;
	Tue, 25 Nov 2025 11:30:48 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id B5AB4402E1
 for <dev@dpdk.org>; Tue, 25 Nov 2025 11:30:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764066647; x=1795602647;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=cwU4DrNEjY+NYBOTEZQzXoG9MT7GdNC2XKOWusXAnBY=;
 b=kbpXNdZApLI84qs/q0k95uMjtJ+RT2UOEUYvNWktG3IU63uuW7PwBUns
 KqfBKhh56NXsWwXnr19z+PvGNQfLbBcVM3FUXNenVx1WrvxPq9pfrh4Pd
 ynE2+RShQ3XDWrRz9xNWXAyw+cJDb/GXU/tRuo8wfjxkbiC8YC7A5uVNJ
 rsDZI+IqavEg096qzt2WyN0pUtFYFK+EoRazUT/7VksqHu8JAQGmvUWr3
 C7c9aG3KXWC7qsPG4U37Vrafbx3WuBoEr78phZyrFCXu8ofI3paxmbUMv
 IpF4B8wxFzawa1qkucxHdoFHTP1ISXOxLtOeRZ0XgHxg7Wal7kq9hPibk Q==;
X-CSE-ConnectionGUID: ROTn1BJiQj6ZJuqZuwkwLw==
X-CSE-MsgGUID: zeCCgFmJTXa0+v22QA+U3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11623"; a="66115886"
X-IronPort-AV: E=Sophos;i="6.20,225,1758610800"; d="scan'208";a="66115886"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2025 02:30:46 -0800
X-CSE-ConnectionGUID: DxdknAAiQXSi0rpZV29NqQ==
X-CSE-MsgGUID: QjdvJjx4TAahiLSPEjustQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,225,1758610800"; d="scan'208";a="215954968"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2025 02:30:46 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 25 Nov 2025 02:30:45 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 25 Nov 2025 02:30:45 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.62) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 25 Nov 2025 02:30:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=os1N0sqQMXN7LLzD4K0Wk6hbiAbEpUaa7dYLmFxF+s2OecQ6twW9ayWjT7MuJNg04HkVKgT2sHc2EBpTVVvkCIA6fdFUZaj4pwIiwh8F2piKB97oSbCT1vl5kcS1yvbsrNI0ZwNuV+XwsEOC1Xhl7crBx/HEGPxF/y4oG33DX8xJDsM3NEqqryD9MkwnsQ9yRZX0vzN2pR88h1F8W7WkfcjsIanM+YY6nLFgejwXkm1uiMHX0Sv0nO2/2xjUJymRlxrecWMypjJ01KxGu+7k0XRgBa1Dp7VaolrGftnpvYZ8g0s+lvYcurnDnXh5cTRkT92cKvrddjU0HnMZrN/UeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cwU4DrNEjY+NYBOTEZQzXoG9MT7GdNC2XKOWusXAnBY=;
 b=nGHcnxwjE4GkPAFz5IM023NcBUzkng1f376hIkD8DT8xhdiSwVfVvg+dA+4PwXxdvVAM49pJFAKLtbKtRM0y7iOsEyd3STixFdrop8IKHFIMB5XTBfjIVyDrOqUEhLm7Hyj2VdH6A7NAkNrtPPOsHnZLied9yEzsY1Sgfl2wBHcVm6M0MfKVO+pqxkYgk8MqG/ryX3VvCnE8LJUxkltI0tJ+Hh6LyDAlWIMf7eItFVwcq0S2Y0OGAt2KvGoALHNXUlozKZSC3cqjJ/WwdmTOT4yw6U+s9LU56C7nLgeXAP4WDnfuklKhC5d11Z9BnM0N54FEUDv90u5RAlzrGMQUcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7747.namprd11.prod.outlook.com (2603:10b6:930:91::17)
 by CY8PR11MB7108.namprd11.prod.outlook.com (2603:10b6:930:50::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 10:30:37 +0000
Received: from CY8PR11MB7747.namprd11.prod.outlook.com
 ([fe80::1457:eb10:8766:7a67]) by CY8PR11MB7747.namprd11.prod.outlook.com
 ([fe80::1457:eb10:8766:7a67%3]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 10:30:37 +0000
From: "Hore, Soumyadeep" <soumyadeep.hore@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "Greenwalt, Paul" <paul.greenwalt@intel.com>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>, "Jiale, SongX" <songx.jiale@intel.com>,
 "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: RE: [PATCH] net/iavf: check PTP capabilities during init
Thread-Topic: [PATCH] net/iavf: check PTP capabilities during init
Thread-Index: AQHcW0BFU4Z4SS3gBU28/0RfiETjwbUDMLLw
Date: Tue, 25 Nov 2025 10:30:37 +0000
Message-ID: <CY8PR11MB774717DEAC152077562DB837F9D1A@CY8PR11MB7747.namprd11.prod.outlook.com>
References: <20251121-jk-dpdk-iavf-rx-timestamping-fix-v1-1-21c9a337a6f2@intel.com>
In-Reply-To: <20251121-jk-dpdk-iavf-rx-timestamping-fix-v1-1-21c9a337a6f2@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7747:EE_|CY8PR11MB7108:EE_
x-ms-office365-filtering-correlation-id: 14b83f83-131c-4db3-bfbd-08de2c0dacc9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|10070799003|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?QUNzdm1TSDIyN2pTRVo4U2lwN282bTgrMUszN3B2eUdySFpIeGxxUEkxbE5o?=
 =?utf-8?B?cFNCUnBndDRpODNvcko5MWNaenc2UlFGWlFJRjNtTEp5bFY5STFsYklRc2tT?=
 =?utf-8?B?cXU5cUdYQnFYWlBwUitxKzNCVnhnMDFvZ0d1aTMweE8vT0N5OW4rYm0xMTJv?=
 =?utf-8?B?eTQ1TWFTeWcrNWNhd0xYc3VCcFo2UzJyOUJXbjlCMUI1MjkvdzVPOGxSYjZt?=
 =?utf-8?B?cVBnZ0F5M2E0TnlUMEtURk1WMTFoK2ZLaEV5a1l6WU9BOE5WUUdCc2NPWjFs?=
 =?utf-8?B?a1phQkp3T3p0dHkxQlJrcGJqTVp6REpISmN6c2NYeHU5SDRjbmRldkNlQnZZ?=
 =?utf-8?B?cGJSNm8zKzNVNFk5OWFkS2tHNndMT0NYeVIwZ2c3a1RZeFFWOUZCZWZGQzVI?=
 =?utf-8?B?Vi9pR29VTEJoNkw1QjRKUGh2RitFSXZZWnQrOHlpVk5sb2U3TWt1OWgyV2Vo?=
 =?utf-8?B?ZXNuZVZ0WnBUYUx1TXBGUVcvVTlIREQ0a3JobFY2SUc2Y21HOEUvYWZCZ2ls?=
 =?utf-8?B?ZEFRc2FSSitCOThKTTFHZlMydko4NEVaWXlMMVEvUzVoVTVEYkc3ZHNLOFNY?=
 =?utf-8?B?dWxlcWM5MlZuOHJwRFJTejNpZC9Xa2NoRHlxUnQxSmlqeVEya09xeG8xcXZT?=
 =?utf-8?B?ekVuWVpzZTdFQ0tPSVlGWFprVkNGM2QwNlozQWttckNKUXN1SGREUEZFU1pv?=
 =?utf-8?B?WlJLdEhpQ0NsUHZxY3dYblBwbHlvUStuK1ZkS0dNUlE2U1VIRW9mbkV6NGpB?=
 =?utf-8?B?M0pDdlpQN0NBZ2s0cVdrRGQ0dmR1M0pYd1pWTGRNcEVlUS83VXJuWVBBYW44?=
 =?utf-8?B?YkxXVWk3L3l0cGxnQm0zRmxTZTBxQWJFUWZWK0ZXa0RTM1FPRER3aElpbDZ2?=
 =?utf-8?B?ZDdWamV3ZXlGcVhEUXdFNDU2RnJJQWNKNEZSRXBiQ3NvYVp4aXEzS2RlWWNG?=
 =?utf-8?B?SlRTaU1vZzVGSWZLeWkvUCtxb1hYUzBnRFYwVnVJTzR2TjlUbXZLR3c3dHdx?=
 =?utf-8?B?aUZvZVBZS3I1aHFxYzAzb1VveVdSbG5LUkF4Qm0wbGNyeDBka09zUVZBU2ND?=
 =?utf-8?B?Sy95YlZRYStCUXlKUEJuaDhtR3RlNFdLM2dWbFVLWlNZVHphVGg4TzlwbkdM?=
 =?utf-8?B?TFljZnR5d2Nka01rNWt2bHBkTWMzdEtDRUJGTEtSdERvZlh4MXNhRjRxLzlj?=
 =?utf-8?B?VjVGbHRnQ3BCREJuMnRFQUxHaHVJTi9ob2EvRFFOMUNwL2JMZmRHSC9jOHNK?=
 =?utf-8?B?ZUZMWUdwL1p0dzF0V0xyR2ZtaFA1TzgxTyt2ZFlWZ0o3cTNLSldZL2JKRHZk?=
 =?utf-8?B?azdOMzdtcTBGTmZDMzRVVWkxQjRVL1VMem5pVlhZYXJ5YlBVaUcxOXkxVVNm?=
 =?utf-8?B?ZjFqK05BLzdXMzZscVhpNXhBajZNZ20wSWNFLzJvK2VBdVRWQVM2TndvejlN?=
 =?utf-8?B?blNvcGNFb3JST3FOSmQ4RUxZUm9QNnd0d3o3K1lZNlVRZFBIYU4xeDcreXRz?=
 =?utf-8?B?RytLc2VlUC9nTE9zZnAwRUYzWUZ1a0d4U1l3NkQ5a0dMRHRPcDIwbmpKV0Vm?=
 =?utf-8?B?ZU43c0FlUEVxdlljdDJNRVFuRWhYWHJxOUNIYnpFSGprQ2ZIalE2SldRN0Vy?=
 =?utf-8?B?VTRBTHBJYkpZS2hYc1I0M2hZRTBnL3NXNFMyb1ErNks1WGdablNXdjZlOG42?=
 =?utf-8?B?eFVuYVF1emVhNDBRZnladnBJMjByWWtRMWpod2M2amNUMFNsK0ZnVnZYYXl5?=
 =?utf-8?B?ekJ6TG02cmNUS21PYWhWL3RWMDQrQnZJdFVrcEhuNjM4UFhjV3BjQ3cwZlZG?=
 =?utf-8?B?S0hPTjJnTVpnaDBST3g0TFA1M3BnMmRBdzlEWWtidGN3QlFaRmtnVm9ablQz?=
 =?utf-8?B?NDFPUk9NeGhUSGdETW1sb1ZhRmpmb09pYU9OL01yeGJjSFJ6Y0liWXpCSTRI?=
 =?utf-8?B?QjNpeG1RWnF6T0dvaEJmeHQzQUFPdHg5SWNpRjNBdXNRN010YUhUZEJyUWta?=
 =?utf-8?B?Yi9sdXdlZ0dmcU0vUG16NDB6YVhSODlIMnhRWDd0bS9rNWU5TzJHWWEzK2ZO?=
 =?utf-8?Q?071mDs?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7747.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmZOb0tLZkM3TEwxcHkzWUFST0JUdTVraUNoK2RSSWdaZ3lkSms1cWplbnEv?=
 =?utf-8?B?WjJVY3FYeEdIdTgyMTRSNXZSVXJFWEtJcUIwZUFRNnFiZnNVYUZDSEZ2QmdY?=
 =?utf-8?B?Z0xhRXJhc3YzemszNm1BQWVuQzBTeXc4Y1NEVjFTSG81QnpNQ1BQK3crZkg0?=
 =?utf-8?B?VFFralJlM1lQM0hqV1A3WitJdXU1czhPRkxiZktsQ1RIb1FOTE83U1F2M2pt?=
 =?utf-8?B?dkdDS01tcXZaMWtLNndocUMxZVlhZUR6T212V0FiQkx1WHpVcmRwQ1J3RW9R?=
 =?utf-8?B?V0ZlNTlxUmJxdlMvNzV3RU8wVlJyV3R5YlV1VCszVE1kaDZWY2pOa1luZWow?=
 =?utf-8?B?dGpEMW1vbmFnekNkZTltUWo1c2NnNFg3aWk1Z2VQdWlVTUhSenRlRC9SdjlQ?=
 =?utf-8?B?clRUSkZpWnRQck1KMlozN0ZDR1VIT2RpbzlsNGRPblIyRjY1ZFRGUkJSL0hu?=
 =?utf-8?B?VlFuRnB2SVNDUCtXMWhPREJyWHc4V1hHMXpla29tdTFjb3RlRG9hNUVlZm1l?=
 =?utf-8?B?SW1zWWc4aE13WUJUWHFkQmp6V2NQeW8zaEs5MEZraEhWeUtyMDNzUmxhUXhv?=
 =?utf-8?B?N0FSQ3c3UGxycVJqdG9hRXNTNmRLTFRjZ2pKS1NWRWlxbkM3bWFSRVplTzVP?=
 =?utf-8?B?QmdaSFIyWDBLM2JQU1B0UFBPbVVDdXZxNkNnTW1yemY0R1p5dnR2cnFqTDVT?=
 =?utf-8?B?dEtwV2ozN1V3QlFtaXdxa0RqTFMvVE1qcUtuUldHMGd3bGYzejR3U1lIdjd0?=
 =?utf-8?B?dW5CQ1ZDQkxtdWRPcW1adTg0QTRBOE1wS0RSOXhWTlplSFArQ09jeS96YnFL?=
 =?utf-8?B?VWV0ZjBnWi9OTTVEQzVPY2Z5S2kvbksvTnI5ZEk1cy83Q1lsM1lDTFE5Zk5F?=
 =?utf-8?B?TFZ4U2d6UlBobWJVOTJIQU1MNm1NTzI3S052V3NtWUFPUnl2SzBDa3hXc0dG?=
 =?utf-8?B?RU5IOEp2bVlISmdDUzJtaGtPNFhhZml3RGFoV1VYVWFxWURMVDdTV2V2RmNJ?=
 =?utf-8?B?RUZQWDl2dlJuQTA2MkQ5Yzh6dnlCTStoRlNwVHhnVUUybnh6TVBYNFBwT2ZD?=
 =?utf-8?B?MXh5S01lbFhFalFKb0hIdlZKRFNQbGNEb2YxRTZXUW1DUysyU24rUDNTSHRN?=
 =?utf-8?B?RVc0KzlsQmx0bXdSSHBSeEprcktqNFFvNjZEWENUM3ROM1JYZDdmLzVwUUhR?=
 =?utf-8?B?M1Y4dUZxNzA2STZMUzN3Um5MMVFQZktOKzk3LzdVT0IxUFFoSUJ5SDZMajNV?=
 =?utf-8?B?cXFoNmFxWlJPTE5YR241c1FpbEFzZVhVSHBZNnVMdEdwQzJqQlE3QlFwcHBo?=
 =?utf-8?B?c2dOZzhQL0h4cFVrUjhRbkxvY0RFTm91dy9oZGNFNXVOaC85QUNTZ2xzSDhV?=
 =?utf-8?B?dkJXZHdwbmxaejhQTTdzbyswMlpwL1JpZUZaY0hVdzZURDV2NTN6QklGWkNq?=
 =?utf-8?B?T0RBNmVzM2M0dU1rd2ZMcjg0dzlVNGxjUUUzRG1LYXNBcHliem02VEZEUmpR?=
 =?utf-8?B?a1VZSXB5SlhmaWFCMTBDRFR5Y2NiK0FuRmhZcUtQSzdyQ2JudnlYaUhSMXZk?=
 =?utf-8?B?K2Vna3VZdDZVZ1lndmFGUTRTcExaYmFzK1d3NjhMV04vZkZma0IzWlI4a3E5?=
 =?utf-8?B?dm9YRFhwR2x4SkZSbCtJZ0xnYmVWckxPWDJlUWpCOFRhODRzUUVGbHlwQVVO?=
 =?utf-8?B?aFh3N3NvRlJ1MUxoZkt6Z1FKTGt1Z1greEhVWEFVMVZxbU9wV0Vvd1AyckNM?=
 =?utf-8?B?NUExUWM3MUU3Ty9OVTE0M05oR0dWMWpOWFg0OTNzQ2lZaFRlbWZ1UUNTZTV3?=
 =?utf-8?B?bkw5TGpWeDIxUlIzc1JmMkJmN2JxNXVmb1hWQkZGeHdnSkNEdHRMUWF0R3FL?=
 =?utf-8?B?S0RXMml4TnZSbnluam12ODdYakxzcjV6M01YNU0weVlIbHd6NEtVWHpjSDV4?=
 =?utf-8?B?RHM4SE5tM1BENVdrNTlDcFQwaUZmNExJOGY0OFNBQndISFhiVitNWkhJbkM0?=
 =?utf-8?B?RUIxQUJEOEdZaXdVN3ZVWjhENU8xYlo1NDdTRjZRWm5SRVhSNHJRb0dtSU9G?=
 =?utf-8?B?NUROK0J2V2lPeXhRVERCZ2lvKzUxU05lekVPNHVaeWs4T0l5NTlPMGIzSlBN?=
 =?utf-8?B?S2MrbG1WbUhTV0VtVSt4ZGJjblQzR25MeW4rS1pBbnhGRlkybjR0OTBSemVl?=
 =?utf-8?Q?arKiSa799sWTvCF/7lzK+tQYtddxaDUSIg8IUrwPHlWB?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7747.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14b83f83-131c-4db3-bfbd-08de2c0dacc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2025 10:30:37.8209 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EffejKdcOTKOF8hWsYwkBCZDVhDXay0uyoWBSQuQuKpb1ziyVxedc05rLeZt04GYrVTeBTwWlLNRgbz3ELCfcZYrbSmqCDjlWx2dXjt5lZI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7108
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

Q29tbWl0IGQyMWMyZmU2ZTVhMSAoIm5ldC9pYXZmOiBmaXggY2hlY2sgZm9yIFBGIFJ4IHRpbWVz
dGFtcCBzdXBwb3J0IikgYWRkZWQgYSBjaGVjayBhZ2FpbnN0IHdoZXRoZXIgdGhlIFBGIGhhcyBh
Y3R1YWxseSBlbmFibGVkIFJ4IHRpbWVzdGFtcGluZyBpbiBpYXZmX2Rldl9pbmZvX2dldCgpLiBV
bmZvcnR1bmF0ZWx5LCB0aGlzIGZ1bmN0aW9uIG1heSBiZSBjYWxsZWQgcHJpb3IgdG8gdGhlIFBU
UCBjYXBhYmlsaXRpZXMgYmVpbmcgZXhjaGFuZ2VkLCB3aGljaCByZXN1bHRzIGluIFJ4IHRpbWVz
dGFtcGluZyBub3QgYmVpbmcgc3VwcG9ydGVkLg0KDQpGaXggdGhpcyBieSBjaGVja2luZyB0aGUg
UEYgUFRQIGNhcGFiaWxpdGllcyBuZWFyIHRoZSBlbmQgb2YgaWF2Zl9kZXZfaW5pdCgpLiBUaGlz
IGVuc3VyZXMgdGhlIFZGIGtub3dzIHRoZSBjYXBhYmlsaXRpZXMgYXQgdGhlIHBvaW50IHdoZXJl
IHRoZSBpYXZmX2Rldl9pbmZvX2dldCgpIGZ1bmN0aW9uIGNhbiBiZSBjYWxsZWQuIERvaW5nIHRo
ZSBjaGVjayBhdCBpbml0IGlzIGJldHRlciB0aGFuIGluc2lkZSB0aGUgaW5mbyBjYWxsYmFjaywg
YXMgdGhlIGluZm8gY2FsbGJhY2sgaXMgY2FsbGVkIG1hbnkgdGltZXMuDQoNClRoZSBjYXBhYmls
aXR5IGV4Y2hhbmdlIGluIGlhdmZfZGV2X3N0YXJ0KCkgaXMga2VwdCB0byBlbnN1cmUgdGhhdCBj
YXBhYmlsaXRpZXMgYXJlIHVwZGF0ZWQgYWZ0ZXIgcmVzZXRzLg0KDQpGaXhlczogZDIxYzJmZTZl
NWExICgibmV0L2lhdmY6IGZpeCBjaGVjayBmb3IgUEYgUnggdGltZXN0YW1wIHN1cHBvcnQiKQ0K
U2lnbmVkLW9mZi1ieTogSmFjb2IgS2VsbGVyIDxqYWNvYi5lLmtlbGxlckBpbnRlbC5jb20+DQot
LS0NCk15IHJlY2VudCBmaXggdG8gcHJldmVudCBlbmFibGluZyBSeCB0aW1lc3RhbXBpbmcgb24g
UEZzIHdoaWNoIGRvIHN1cHBvcnQgUFRQIGNhcGFiaWxpdHkgYnV0IGRvIG5vdCByZXBvcnQgUngg
dGltZXN0YW1waW5nIGFjY2lkZW50YWxseSBicm9rZSBQRnMgd2hpY2ggKmRvKiBzdXBwb3J0IFJ4
IHRpbWVzdGFtcGluZy4gVGhpcyBpcyBiZWNhdXNlIHRoZSBkcml2ZXIgZGlkIG5vdCBleGNoYW5n
ZSBjYXBhYmlsaXR5IGJlZm9yZSByZXBvcnRpbmcgaXRzIGRldmljZSBpbmZvLiBGaXggdGhpcyBi
eSBjaGVja2luZyBQRiBjYXBhYmlsaXRpZXMgZHVyaW5nIGlhdmZfZGV2X2luaXQoKS4NCi0tLQ0K
IGRyaXZlcnMvbmV0L2ludGVsL2lhdmYvaWF2Zl9ldGhkZXYuYyB8IDggKysrKysrKysNCiAxIGZp
bGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9p
bnRlbC9pYXZmL2lhdmZfZXRoZGV2LmMgYi9kcml2ZXJzL25ldC9pbnRlbC9pYXZmL2lhdmZfZXRo
ZGV2LmMNCmluZGV4IDNlZjc2NmRlNDcwNC4uOWIwN2IxMWE2YjUxIDEwMDY0NA0KLS0tIGEvZHJp
dmVycy9uZXQvaW50ZWwvaWF2Zi9pYXZmX2V0aGRldi5jDQorKysgYi9kcml2ZXJzL25ldC9pbnRl
bC9pYXZmL2lhdmZfZXRoZGV2LmMNCkBAIC0yODg3LDYgKzI4ODcsMTQgQEAgaWF2Zl9kZXZfaW5p
dChzdHJ1Y3QgcnRlX2V0aF9kZXYgKmV0aF9kZXYpDQogCQl9DQogCX0NCiANCisJLyogR2V0IFBU
UCBjYXBzIGVhcmx5IHRvIHZlcmlmeSBkZXZpY2UgY2FwYWJpbGl0aWVzICovDQorCWlmICh2Zi0+
dmZfcmVzLT52Zl9jYXBfZmxhZ3MgJiBWSVJUQ0hOTF9WRl9DQVBfUFRQKSB7DQorCQlpZiAoaWF2
Zl9nZXRfcHRwX2NhcChhZGFwdGVyKSkgew0KKwkJCVBNRF9JTklUX0xPRyhFUlIsICJGYWlsZWQg
dG8gZ2V0IHB0cCBjYXBhYmlsaXR5Iik7DQorCQkJZ290byBzZWN1cml0eV9pbml0X2VycjsNCisJ
CX0NCisJfQ0KKw0KIAlpYXZmX2RlZmF1bHRfcnNzX2Rpc2FibGUoYWRhcHRlcik7DQogDQogCWlh
dmZfZGV2X3N0YXRzX3Jlc2V0KGV0aF9kZXYpOw0KDQotLS0NCmJhc2UtY29tbWl0OiBlZjk4Yjg4
NDU1YmY0YTdjOGI3YWEzMTA2YTc2MWM5ZTkyNzBkNmEzDQpjaGFuZ2UtaWQ6IDIwMjUxMTIxLWpr
LWRwZGstaWF2Zi1yeC10aW1lc3RhbXBpbmctZml4LWFiZGNiNDJmMDE5Nw0KDQpCZXN0IHJlZ2Fy
ZHMsDQotLQ0KSmFjb2IgS2VsbGVyIDxqYWNvYi5lLmtlbGxlckBpbnRlbC5jb20+DQoNCkhpIEph
Y29iLA0KDQpDdXJyZW50bHkgUFRQIGZlYXR1cmVzIGFyZSBub3QgZW5hYmxlZCBpbiBEUERLLiBX
ZSBvbmx5IGhhdmUgdGhlIFJ4IHRpbWVzdGFtcCBBUEkgaW4gcGxhY2UuIFR5cGljYWxseSB0aGUg
Y2hhbmdlIHRoYXQgeW91IHdhbnQgbmVlZHMgdG8gYmUgaW1wbGVtZW50ZWQgaW4gZXRoZGV2X29w
cy50aW1lc3luY19lbmFibGUoKSwgd2hpY2ggaXMgbm90IGltcGxlbWVudGVkLg0KDQo=
