Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57522E94622
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 23:19:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D97440611;
	Tue, 10 Feb 2026 00:19:35 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 109304064F
 for <dev@dpdk.org>; Tue, 10 Feb 2026 00:19:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770679174; x=1802215174;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=+ZsPaSNkQZc3XgyXwDE+FYU9JlLd5DbxTUGMAo53nqA=;
 b=Zx9zHSIswQlH/zSwMbA2yUUvGox6KPF8qswb1l6WB+5T3Zl9nGOjT5s9
 jnKdBLN4+XIlx4NZWhAQtn3OYG+lAgA7l/jQqTXds2KQIQCSTx2XH9pZp
 E5luTZTwDyhCcJ/Ja5DpuRU788RseEeuc4UdbbD5DHWtFxk67YY2+OyOu
 VZ6IEkj1FW9N4UlVyep03TUybTAU69WAaolCaEaJ1rqqKTnRpPhAMkvgo
 SSi8LnrErYQhubPTwMvQH8gHJWq1xmkJCHtDRkdPGdJuKNKRAekPBfYud
 Db+XyyUAsM4D0nSASykifn1UvXwI6uMC5LbGkDn65hjjFXNdt7nngIgsW Q==;
X-CSE-ConnectionGUID: No0bL9x2R9KveEjvokNevw==
X-CSE-MsgGUID: 4nvfwKa2RzalwItqGgPKrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="89382875"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="89382875"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 15:19:33 -0800
X-CSE-ConnectionGUID: abv1I2OqStqE7A9sqoE2YA==
X-CSE-MsgGUID: IUbPmXUVTL27z5R6zT71qQ==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 15:19:33 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Feb 2026 15:19:32 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 9 Feb 2026 15:19:32 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.1) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Feb 2026 15:19:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i3Pf8a//z5itxYoYHNJYnA11r/Mcc/h6cjkxC0vmfkc3mlBVgbbBc04fqgSUqii7FsAKec4D3FszYjpkk4PIndHHCYlQVXUI62WFKliOfKPlL5QFxCfwSuVUYNG1H3bLrQ875UnxXUj7EKb9qPPYCkDoJyC2eeu3RSHw7KsnHolPDtl2cKwBQzPHh7FNTFZOK9ZCdFbwHpeJuza8RhW/PLMez+KTBEl8HH/0yq1MkgmDdNfz/73i00cZjr/NkKL0IM6R40mjaYCjL6vrkKT8Wyl9zUcgo65DRMMWzifO0Uscj43r3nMfMiG3zSrLdG5mGmnPg0kGL7hB+TLLdg2qqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uj3L69ru+XuiFF+njjT2ATCK/aHo+R2eUIDKhR2WvYs=;
 b=NV/PVjWO/SBv1L5TFdkdsm0AoACG07k7++EP/GPO/AUF75xPsyEGkY06eULst3+V+hswkY1JOdyDkSKFnUIo36CWcqKsdF9dk4BtSwP2bK1lj0IyUq2t9toWGIkFK44MfvHuzAOchICwjTlvMredg7scMlhW1XemJYKzb14VscdWsBSMWlB+g7INrnQ2CVCsZvWBvFdZ6010ed+YcvFxePcGFikAuoBYf1WZcNuahgV0ocuscbe4unP2YNkJSaC9ukZL9Wy8pY8iYqb+1d9ooiGWyMpB9mgfPkStCWFperrqlc19qDL0Iy3ee5F7loVzvzV+lDgFmkqnpFa5yMerVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16)
 by CO1PR11MB4898.namprd11.prod.outlook.com (2603:10b6:303:92::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Mon, 9 Feb
 2026 23:19:24 +0000
Received: from IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2]) by IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2%5]) with mapi id 15.20.9564.010; Mon, 9 Feb 2026
 23:19:24 +0000
Message-ID: <99051d4c-4a3e-472c-b510-6342333d729f@intel.com>
Date: Mon, 9 Feb 2026 23:19:23 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 31/35] net/intel: use non-volatile stores in simple Tx
 function
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260209164538.1428499-1-bruce.richardson@intel.com>
 <20260209164538.1428499-32-bruce.richardson@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <20260209164538.1428499-32-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0442.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::15) To IA4PR11MB9204.namprd11.prod.outlook.com
 (2603:10b6:208:56d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9204:EE_|CO1PR11MB4898:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e65aae7-c8b5-4b52-545c-08de6831a9c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bDBUL0hjLzRJeVRNK1UxTjZaRUtDZlRVTVFjbWlGamFqOHhiOWxtK1hoY05z?=
 =?utf-8?B?eWtLOERIUEZhWWRVU2p3NEZvNGorRTBocGdseDFzNkFSTzV4Z2IzZUszcTFN?=
 =?utf-8?B?Wlg4NnRZdVZVVU5Ba244M3Njd1UrZGt2UlR1clJSSGJ4UlkyT2QyNURpT0xS?=
 =?utf-8?B?bFZtUk05V2J0SlNieE80UnpldE1BVzZ2dVhHZ1Z3eUVlUXRXbzQ4T2VKVVMr?=
 =?utf-8?B?bXllc2dYelp1OExZVDdRSmVtTUJ0TW55T2RYdUI1d3JERUI4WStBV0Q4dDNZ?=
 =?utf-8?B?SURMdkNmVERQbkZlRzRzSzhkUllxakpMRThJTHlsZEJLaDNHMUdqeFB2UXBk?=
 =?utf-8?B?cGZzNGVaektMSk11aWhrSm4wWGN0UG5QYlR1Y2xqWWcyTVJWOE1YL0hwS2tF?=
 =?utf-8?B?RTc0OE1NSG83azZLRDZqckp6WEs1Wm81T01HRmhjdHgxN0FJRnl6M1cxcmZM?=
 =?utf-8?B?SXdJanU3MDBJMjRzZ2hKaE5vS3NSb2xVRGNOUmc5T1FramtTSDhVWEdoSVB4?=
 =?utf-8?B?b1Mrd2lraE9yRHRselE0ZXl2SU83VDJBM2QyYmtmZUJSczl4SzB4NEo2bE1Z?=
 =?utf-8?B?bDlxQkVKdjBPN0ZuUmhGSXFUeTBQamJyS0tJT21yaVN3dTFOcUhhVXBXWVJx?=
 =?utf-8?B?Y2EvV1Z4UHMzdFhJbDBJV2JSMUdEdjB1R2VwTk1ZZnl5bC92aGhabHYvUnhN?=
 =?utf-8?B?L2V2NGJQUEVSN1BOdmIvdkx5SXlINXZ6SmNSem5SamVFWC9pSWhHakswV2Jk?=
 =?utf-8?B?WDdNYTF5WWUyUmxCckpabHVvcDQ3NlRYT2NLL1gxREJlZXR3cVlsOVlIeGlk?=
 =?utf-8?B?WlB6akppMG12SmcvMzI3N2VPT0hIaldUbzdCOFh6Q0RHSEQxcUc3SXV4L1Fm?=
 =?utf-8?B?Q2xMaFc4ME1iRk9kU3VrMG5GSXVmS01oSEpqc1F4cDV6UG41KzhNanR3bC9G?=
 =?utf-8?B?RDJkeTZIcmRLMllya0hscm93V0hSeEx5VW1SdURVUmh1RmJ2Z0dGVHNzWENv?=
 =?utf-8?B?c3JxY3BkRk1IYzg2STJlYXRPTDA0MUplVkN5YkpzZEhYNzRZV1QxdmR5Vnly?=
 =?utf-8?B?UVl6TXVpV0VIaTFiQ0w2ck9QTnBZSzRmMmpJYWtCcnlMQnZ1dGViMHBtaUhw?=
 =?utf-8?B?M2w0WDJiK2pLS0ZkUzNpTHpwT0tLcGVQaEJyaG94b2Q4azUyU2IzRHl2THVN?=
 =?utf-8?B?VDI2Zjc1ZkFCSndoR1Z0ejRHcTNzMnJmci9mUmN6TmNvcGhnak8yRUREZk9H?=
 =?utf-8?B?WGI4WU16NDN4dFpiVEpBalZpaWNSbERJZTZKeTlMS0VDVUdURk5EMUJRdEVE?=
 =?utf-8?B?clo0c2tVSmdjTDI5UEVESi96cEdIeHRqVlg0WVBZN29sL0FWd0Jya2s5bWI1?=
 =?utf-8?B?dmJzR0hkUzluZyt3UzV4R0lUWmhzRXEwOWFGVmdya3FEZGFYSDZLMVVBdjVL?=
 =?utf-8?B?VHZOZG1Gc2RCZ0c3akhBN25Nb2l2eWtkTjl4Rk1EVDlmMFVDRkFvbFVrNlVh?=
 =?utf-8?B?NUxCdGRQWG0vMXl2RjhPWGFTVTZGSnRETTFIYVJXdFVoWG1DQUZQQU8xRkRu?=
 =?utf-8?B?a2V4K3N2bzNpcDhRTGpSakg3QWJ6dEhZQTMwNEhBT3E1endia1dhOVh6YnVM?=
 =?utf-8?B?LzJkOHFhMjAxQzk0elNSTXkySHYwWXVIaGwvMmJxMHpyaDFOUmpteTRqWHV2?=
 =?utf-8?B?TUozOHF6bXJkbFJWKzRSVHcyUTlKOUE5S1dNeEpJTmpFTm8vUXh5OU90V2hS?=
 =?utf-8?B?eFlQRDB4OE5UMmxYcldZNE1RR0hTWmJHcmNRR2dOQThOT0xKbWtDVGFEZThK?=
 =?utf-8?B?SkFDUlRHWGNkd2FFMEUxazFWZmNZZDVJZVhoNTRVYjk2VEdPQkhob2lUZmVJ?=
 =?utf-8?B?akxGYkRzdENRRmd6WnRUS2M4RFFISTc5NTdLTHJmaGN2by9HS04zYTZsWUYx?=
 =?utf-8?B?ZTE4ZllaK0FYWitxVmU2SjhhQWxBYm1TVTBPOWxveGlhbWlOTUdTU1UrSk14?=
 =?utf-8?B?T1NKL2dkakNZeFR6THNLSjVoNGcydzlreFdvbWFxR2JLeTkzT05OcktmK3FT?=
 =?utf-8?B?ekFBcXZLb2RjOXZYdk1qS0RkWXpnd1R0c0wxQkpEdHVVb3IzRE9zMDdSYmxl?=
 =?utf-8?Q?E0FM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9204.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUhaNG5ncGhNYUR3dXRjVkE5MFBDMEZuYklmOFFJazBXaEI5RHA3UGhSSisw?=
 =?utf-8?B?L0xNUDdTOWFpQ0h0ODFlVTdlYWxDZGhDR0lBTjlUWWpseTNWVE9WODJyazJO?=
 =?utf-8?B?cGJTREdwTlBOeXBQdnBBMldYUEZkLzRuRzFOTDBTa1hpMnRqZEdvWTM4WVB3?=
 =?utf-8?B?ZDFLanNDbkRhSWs5VW12ZmYvR2hSQTlvbVdqQ2xLWGdiMW9QdnFNQm5ZK2tL?=
 =?utf-8?B?UzBSbTRKTUwzWm5hMXphV25yMVVkZVczMnprWEkwa2hNVzBXdWdxSHRORkti?=
 =?utf-8?B?M0NLWjBVYjdua0t2RWUvV3hQRU5ZZUJwVTdXdGxGaEdlcHpNNGJFdHZGemEz?=
 =?utf-8?B?aVVqRHZSMlI5ck9lV2t6ZEo2V05hQlY3MHlXSjVRRjcyT0dPQUdZZGZIUzJt?=
 =?utf-8?B?UGptb2RmdXl1dWc1TjMrcjczUm52R25CVC9PdkpBTExVM2tRSHVPQ2RGTkxp?=
 =?utf-8?B?QXU4SlRvbm1aNVJtYUZZV2RaTVBXOXVzWkhTNHlZT2dJUmpvdlN3Um5FeWpF?=
 =?utf-8?B?aGNrcURuajhxNjJXbFViNzgrOGljNHZpRVhzNXpSSW80SUZma05qY3l4c21Q?=
 =?utf-8?B?UWtUV01NMHdPaTZrem9MSXRmWjUwUGVZLytxVUs3RnhlZnc3emYxcUsyaWcv?=
 =?utf-8?B?RHFwSjBsaEc4WHd5YXBZdnY0ZFFhY0I4YUNuQkZaL0VGRW5sRk1GMkxVcGRx?=
 =?utf-8?B?VjYyaGNFRGdWS1hLVjVsU0JvRmRJK3FMQ2R4ODZ1ZXVMaFR1cCtCLzBCV2ph?=
 =?utf-8?B?NXpxRVVGY3ZzcDgwUFR2RFhBK1phZGwwc1laZkcvdm5NSjNETkVjeDBhU2tR?=
 =?utf-8?B?TFB2YTNkdzVIcTRPbGRIQmpFYnBCMXZ2djk3aEN2Ty9nTW1jSkkrNlkwNjNO?=
 =?utf-8?B?RDB1UmJGd2lwQW04d2xHeUJjeHVaSURWL25RakNOci9ISDBiaDZ0TjhPYlcz?=
 =?utf-8?B?ZzhWSUZtWG56dVJtVDA1RVR5dm9EZjNFQkxJeEh2RVE2ZnVteFg0bk9MVElE?=
 =?utf-8?B?OUlOQXlEVGdIRzJVMkpVT1YwV0liZ0xrZDNmdWpidXlCN1ZSUWsrNUFyd1B5?=
 =?utf-8?B?TlhIVS9kTDI4a2pvcmpEKzZTaC9YbDI3QmtJZkhFaWJPd1hDaGVUM3NwYTRN?=
 =?utf-8?B?STlKMHNKTlYvTW1wRkJETDRkdVhLNFFPSEhSemxlMGlhQ2tJcmQ2TGM2VFFy?=
 =?utf-8?B?dUxiTkh3S1ZZUzZLMlA4MWZrM0t3SFZqdzRtd04rRW5KN3h1WktITGl6d1J5?=
 =?utf-8?B?THZWRFNRdWVwOWxKQnNsQ01CcE04WEVJdW1QblZqTUtEM3gvWm9pcEc0blFz?=
 =?utf-8?B?UFM0RlBiMUhCYVIzSDZ2aTd0TFE5Vmc0bytQbFBBdlRoRkRad2dKa0dMMGc0?=
 =?utf-8?B?QlpBTks4TGxkQ3RML2lnamNSd0VuVmc5MUVhR3lSdEJ0VlhiZWQwWnhRcUQ0?=
 =?utf-8?B?QXh6bnJ5WjEzQ0lzcVZiYXlWNm5LM0VCTEwwZCs3WGlyTjZublo1RVE3akdR?=
 =?utf-8?B?L281MnB3NUZkb0lOWjcvYXZ1RnROMU4yWFZtN3oxMmV5N2tnYmx2bUFITmtX?=
 =?utf-8?B?TUdHcFk1TTFWcHk2aENmajUxQU5DcEJ3Tk4wRVJGLzl5QkZoTDduUTIreXda?=
 =?utf-8?B?eDdWT3EvVVIrTENCeHRLQVVveXl6ZEg1MkNFNTlqeEFPalZnMlRjYzhnVkps?=
 =?utf-8?B?Qld5Wk0zY3Nvc2RvS09VQzBMTTRJWTA1ZmZ2dGN3SUR5Ykp3d3ZTS1RLblZY?=
 =?utf-8?B?Mnc4TlM5ZmFGOFY2SlQvN2tGWGpaR0hNbUVmNVJLcXpNOFYvbTBaZDhOKzd2?=
 =?utf-8?B?NlVDQWhUYlZqVmc0OFdDdmFxOU9XNktWalBRVFZtMDRqZytTN25IbWY1SSs4?=
 =?utf-8?B?di9WWERsbkhKMHpXazJQd2RQdGFSc3VUTHRUWUtjc3kwbFBtUzRBT1Q3bmRV?=
 =?utf-8?B?WENEMDBFWXh3Qkdlc2l2TUNUN2dJejd5S1NlSnFJLzVHbFVRVDBPSnVGYW00?=
 =?utf-8?B?RVAxdk5PQ056K29oUzdlSGQ3SlZlNS8rZTRNYXVnOWlZZ2VLcFRiQXphdXZ0?=
 =?utf-8?B?cW94NW95Vy9ES0RvY2Q0dFAwQ1JqSVlsZ3RyUzE2SHBaeHBuSkVxKzJQQkVT?=
 =?utf-8?B?ZTFzaEp1TG9LRzdvVmtBbmxWZXcrY1FyRDlQZE84N25XYWMrTVlLM1czQWMx?=
 =?utf-8?B?aDgxMzhWZEs5VzE1cm1uWHZ0djVuRUFBdlcwUTQ2TUFyZ3k1RXJVeURrcXVm?=
 =?utf-8?B?bkJNZ09nT2NkZzFtRUx5OThLcWNKc0NldGVQcGc5dHV1YlBGYWFRNXhHblhI?=
 =?utf-8?B?Ty9STnlwUFRsYnBxcVZ4cGJ5U3FCbGF3STNLTlhsS0hIN2hPRG9ORDc2NEtl?=
 =?utf-8?Q?o2QQAXDARIwA34zQ=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e65aae7-c8b5-4b52-545c-08de6831a9c2
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9204.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 23:19:24.6344 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yS/IIK02K0c1Nkhol42sdYYdmrPbaHilq06YoP8BcibfE/btwpdZxSBBes22e4n4p6BMIDfocSAfgYnJgTcDmuLNYTcsotnyK3iDkhnfnEc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4898
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

On 2/9/2026 4:45 PM, Bruce Richardson wrote:
> The simple Tx code path can be reworked to use non-volatile stores - as
> is the case with the full-featured Tx path - by reusing the existing
> write_txd function (which just needs to be moved up in the header file).
> This gives a small performance boost.
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>   drivers/net/intel/common/tx_scalar.h | 55 ++++++++--------------------
>   1 file changed, 16 insertions(+), 39 deletions(-)
>
<snip>

-- 
Regards,
Vladimir

