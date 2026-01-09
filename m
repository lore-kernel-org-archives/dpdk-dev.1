Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB0CD167E2
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Jan 2026 09:46:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 28712402A7;
	Fri,  9 Jan 2026 10:46:13 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 1E1DB400D5
 for <dev@dpdk.org>; Fri,  9 Jan 2026 10:46:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1767951971; x=1799487971;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=MptW1Q/FXfdsZ/0227irgDogN3E8qvIVZYVBx+NWN/c=;
 b=RRZ2F8yu9BOWXa2Qioc+3hoG7wcKD+Z0nB8NjxnEMmWIJP++YdCaYrpb
 R7VtmAPXEYQc92SkhhLZf+yRKeRQyB8YncehQrgNpEjqJ6RQEvAiCBC35
 h77bCrmSofxBaP5SOigv2+ckI65j2882hVfIRnbNe71KFUE2hI9eQLxFJ
 nDiYN+69p/q/mrBIF/Sn9Ll+vBrTMJi7bq8mGa7zdsXQfFazv1jnZkfBj
 7LEG0v8nlVl1eWGgjXPyrljt/GaekZSM1y6yz3g9GUKfbx5YbL/lCbVjS
 gNpwnBYcZn3fsB6mvSb3Tt9XSuWT/VUXtUMOioXtn+aoAjzP4+zwQ1AF3 g==;
X-CSE-ConnectionGUID: mvfJ0yx/TjyuFZzKYgaraw==
X-CSE-MsgGUID: /uOy3q+VRAa8h3N+eB3DRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11665"; a="69245170"
X-IronPort-AV: E=Sophos;i="6.21,212,1763452800"; d="scan'208";a="69245170"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jan 2026 01:46:10 -0800
X-CSE-ConnectionGUID: m09Q4HzTRCaL8uhmZUg2oQ==
X-CSE-MsgGUID: epVxUc22QJWSy0Ynt3OSdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,212,1763452800"; d="scan'208";a="207911188"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jan 2026 01:46:10 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 9 Jan 2026 01:46:09 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 9 Jan 2026 01:46:09 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.56) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 9 Jan 2026 01:46:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TjDMUvvTCnzIOWZFFdRpYFUbgszDkZybrUsfEgz1BfMvG42dir0ZY9w8n4PGmS6VMlVLwa87bqCxa175Ui95mtdSE9XAV5ZzYa9hEdhJYBWQbZzR/Gk5CtqFDoYzcDa1A+e2r7j3pJ35jwpsh5VHu6l4wSilYFxqLQAqYAyMi2lduVfWJ/jd5RzDR+veJWWyEkWOgj0QDv0T0n/Ntc4aAAaSFYbngLDV0Uf2ZD36q1f3DKu/aQkKISSe02wboDwMTg0vxZF5k7fCoYaVkNBqPtL2w0d5puevt3Icq12fxcymkwBzK2HZ/N/jp0LCrH0U4PV8vmbUzlbAhsE/MSn4Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0TB0C3ZmCgdWqSK2Mah0Kw6fricqW1hHV563hvRSPoI=;
 b=mHlxBiNp0jAB/3LtcBZ8JbItuxKdUrWQ8i/z5a+UBixpFhVN8zjPX5naC/SIx/AIFXj+bURCL/FvITY2REBcW0diRumcL13RDQFTV1CgKFzQ1YLmMrVNdxIDEWRxkJ4evSZVtLxOPaukPTvgykWoCUA5+rDqhjBlxMR1L3uo/qL19WjXQGvXS8WygDT4OC4YY7feR7+c+h8kRKMN7kyNlzKLztKibQmyJhD+PZPwzoMUMcouIh5SXrhuKe4ehrSnKaUIOzaggFEexoLArP0O+bbu3n7YCE4AuT16m3YOre4NjY3QZP+SxARpSqiO+CxPXzZuAi9ZkduGhadZMAXCGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM3PPF529E923C8.namprd11.prod.outlook.com (2603:10b6:f:fc00::f22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.5; Fri, 9 Jan
 2026 09:46:06 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 09:46:06 +0000
Date: Fri, 9 Jan 2026 09:46:00 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [RFC] doc: add AGENTS.md for AI-powered code review tools
Message-ID: <aWDOWEI4NuzrfP2D@bricha3-mobl1.ger.corp.intel.com>
References: <20260109014106.398156-1-stephen@networkplumber.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260109014106.398156-1-stephen@networkplumber.org>
X-ClientProxiedBy: VI1PR02CA0062.eurprd02.prod.outlook.com
 (2603:10a6:802:14::33) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM3PPF529E923C8:EE_
X-MS-Office365-Filtering-Correlation-Id: 7319d9db-a406-462e-36a2-08de4f63e903
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7142099003|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QzlyMURuVEgyeHJCK1lYQkpQcW9BNm4rU2JoRzMwUm5wZEFpWVJRbUtKeHln?=
 =?utf-8?B?bkQ4SFRrbktLSVQ0ZHFLQ3VkWHFlMnhFdXkzNXkrZzdML1RZT0F2akhMMlhF?=
 =?utf-8?B?SElpb2NSUEhCMG1oTk8wRVlnNDRoU21MNkU3OC92Z1RENFBaUVhGcUw2OWZh?=
 =?utf-8?B?Y2dIU2h5cXN3S0RiWUl3SXVCL0lxUGdMZjBMVGVUOG9mbTdTTVc5U3o5VGI3?=
 =?utf-8?B?QjI1UjBuUHNJNDhpYU5lZmp0M29za3VBLzJpTzFicTIvSmU3MXVjWU1aQ1RR?=
 =?utf-8?B?UXNWWDl4RFVHZXMxdmtoT3NJNll3Wi85cUk1K1QxZFBKRkZkRUtTM2hMRnlp?=
 =?utf-8?B?aCsrdTFmVDRUZUtWSmFuZlpJckptRnZwM3ljV1JFWWs3ZERkd2owZzVCM01i?=
 =?utf-8?B?bEZSSFh5VDFGb0R4Qi9ZcFRhbFBMMkFIR3dRY212TzFzMWJNc2JEbzQvMnhW?=
 =?utf-8?B?N052S1hWVnFhczF0LzRJOUFlWXIyaHQvZEhPZmEyZVlibGVxSzh1cHM5RnBw?=
 =?utf-8?B?NkxhcVdqbWNjdHcwcGc4L20xd3hsTzcram5XeHdYL1E3aVptZStadlQ2d1JI?=
 =?utf-8?B?cXRpUC9rR1JXSW10SDNNUjJldnlUNUFXUEF4WTI5b2UwZkxJdVprTXhtR2Ns?=
 =?utf-8?B?Y2ZFOWt6NmNPNUFZQVRtMzBFai9nY2tzTkFKY1g4TkJhV3M2Q2pEQTZ1bDF1?=
 =?utf-8?B?RkJXdlFFYXVDbytXM0UzWVQ0RFRMTjUyS1dZS3hXMmIwcXE0bllabXhVZVNY?=
 =?utf-8?B?Z3RwMjRKcmRRaHhGRkpXcGdsR0FwQlR4a1NUVXVHRmJVNktkS0RJdE1RanZj?=
 =?utf-8?B?OEt5Rjh4MXNhdFVka0Z2UGdpbHNuOHYyVzkyTDViYlRNYml0NVJCRDA3UGVh?=
 =?utf-8?B?VWVZdEQ1MmZab1pUL0tRS0xpdDU3WFd1NEhTejVzWmI1STdqc0JBZU04RFRy?=
 =?utf-8?B?bkc0andjTmlXM1ZQUk0wcmNXaFJyTHFNeUpzMlQvU21xUVJMMWVaM0l2VDVX?=
 =?utf-8?B?cmx3MFYrM0FkdWoxVTRNUXlVMC8yYThzSkErWEQyUzViZE9WaGVqYWY4RTIx?=
 =?utf-8?B?SkladGdWazU1dWo1YnFSYU1VQnFHSktHWkI2RTU2K2VZMk1VV3ZqY0tWU09x?=
 =?utf-8?B?T01TcHoza3lQZHhEY3FKTFNjUHI3OTBZMkNsanBRNlBOSHRtRFdMYVYzRG5v?=
 =?utf-8?B?bkZ4WkZzSXIvOStRbkk4ejlTNnQwdUxZeTg2N2JCQis2dldoVHZtbm0vL2dR?=
 =?utf-8?B?c0NGM0R2eGgvYktZaE9nb3diemJadGREUGxzeW01R1crcHZaTzM3NzV4YmZM?=
 =?utf-8?B?UlJKdWN4YTZGek83dWRHOFp6T0pheWh4em9DVmtDYzdIRHlka0tmbk5uSWlk?=
 =?utf-8?B?a2tCeDAzblJQbThJY3ovaDNMMnNBZUIxeDRLQzFKaDFUY3p1N1lFZ1Y4M3Ni?=
 =?utf-8?B?NEJSVWpicTZTZkFJN3l0RkhqTFpUR0hibW5EeTZkNmhIRWhmUEhkSXljWGRU?=
 =?utf-8?B?K0kwZWRGa1NxU1pudFlYYkJVOUJrOTUxOXB2NzRuVFVtTXFRNW92Z2poOHps?=
 =?utf-8?B?SkNkeVVoSFZuNkRtei83Ty9udGlWdDgzaXpMczJKNzVjY2ZlamRBUURMM1pH?=
 =?utf-8?B?NkUrd01YYXpmVGNDS2hSNER6N09adHFiK1Fudi9CYWZDWlZkTjRpZVRZUnp3?=
 =?utf-8?B?NGRkZjNuTEc5UlVEVnRpdUsxU3kyMGxtb0c1YkZPUmN0aVRVZFl5OGpSUXM1?=
 =?utf-8?B?OTRXS1R4RWszbDBBQ1RYSWhScjhQcHI4NjdEY1pDUTNwSmp1bjJvYnlDQjJ6?=
 =?utf-8?B?MVdTeGNqUjM4Y2dHaC9TZU8yTHZTN3pHNkpTVGVtOHE3WXJnM2NwdHBqRWV5?=
 =?utf-8?B?M21UVkFnYTBPN01yWjdaTjY1MVhiVytORXdLdzVyUE4rek84SFNnY3FJNmNo?=
 =?utf-8?B?NEFvQjJRS2pFbkhEZCtnSDlQTEt6MEgyVDI2V1pOeGZlbVFiV2FiR2V3dzB1?=
 =?utf-8?B?Lzk0Yk1ldDF3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7142099003)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3hOaVdUNEQ1d2F2YjBIUjE5TVFVMDlDOGh6M1FReEJIbGoxZHlPVUMyeWJT?=
 =?utf-8?B?bXNpUU9OZGtQMmlhaVdSYW0rNUw5YTNnS0FRVUZrSTR0OHBOQVpBZW5reG5Q?=
 =?utf-8?B?RjQwZUFRT3BjVFlGLzFDdWVpQVB2RHBLWjArdkVlQW1TK3RuNXRlU2NpeENa?=
 =?utf-8?B?QUNjMGlodHBKUHgzRGdhaUdXOXpLdEhWSHlFUjBQdVJxZXJhcGd3dXZWWTJr?=
 =?utf-8?B?RDBwaVJpZTNEdFZGUjJSU3VKSXFYRUk2WDlIeiswczA2UEJLeWllaHlPaDlz?=
 =?utf-8?B?VUxTcmJMdnZIbUNCZm5WQ2ZvNnFHUzJSN2Z3dXNNR0tNcE1uVUJObXNHNTJL?=
 =?utf-8?B?eFdjTFFaSFZIV2RHbFJJRDhoSlpvL0lneUQ5UE0rTFF0b3BiTkh2M0VrYkQz?=
 =?utf-8?B?TEpiTkNOQmtZbElZV3FuVmdKemZsZ3d4dGNGNXdOUVVDTjFDcjJLNGFneGZP?=
 =?utf-8?B?OUgzdFppZXJuSFAwdkV2UjhhVHFmTk81amVvZXhsUG05MUVsOTB2MDVkRDJh?=
 =?utf-8?B?Mk03cm9pTUVOUW5DSGZDZ2lNay9Bbk5tdTNmUE5kQWJsQ0d4d1YzUzgwNkta?=
 =?utf-8?B?NUZNTkpCeGczRHZWc0FocVFoMDltVk5DRmFMdktDRFB3Z0JuLzJFUU51LzZ4?=
 =?utf-8?B?ek5HeDZjUlpOTmd5SjRJRG0yS1QyVDkvQmZoNUNPZjY5SWxPV3pzOWk2SlI1?=
 =?utf-8?B?QXE4T3drNjh0MFlwVGRWbW8rUXRncEFoa3lBR0Y5L0w5bXhxZThRbTVGN0p6?=
 =?utf-8?B?N1ZkZWNocERuU2hXNlB1Wk9TN1YzeitGbkVRTVZRQ2tocmNxcHI3eXNabytP?=
 =?utf-8?B?MXJEMFJYNGRQR0txTFJ1QjZwL2VQMzZZVmN1WDBMdFVHUG9yTHVZUHkwd20v?=
 =?utf-8?B?eWtFaDBtVTVFNDFlZ0ZDam0yZTBqSDJneFFXaEtYVGF4RUM3N0xiMWZZbkVl?=
 =?utf-8?B?bFlROTJWSS9CWW1ndGh5NFljRlZxRTdCRVdRN05tb1Y5ejgxQ1hIR3ZKTDFC?=
 =?utf-8?B?QzJnMkczUlpNNWNDN0JITEZHekZQVmVzdjl3ZlFPbS9NckFWUkthMkRYOFRi?=
 =?utf-8?B?L0hPREtXU05meHZVRDBNQm04dmNvSFlNeGVzYmVMWEdHWkhrZnZGNUFiSk83?=
 =?utf-8?B?ZEtzaGVXd1VaRkV2OEU0RXBCNWZwV2lUVElmU0Y3L3lTczN3UStNYkxoQmhT?=
 =?utf-8?B?M0F5bWNTdVRxVzBZOWp1MHQ2WTh4bFhZMGQ1UGxKZjA2eDJ2Vzlmby84UTRH?=
 =?utf-8?B?V1dLcnZlTUp1VUxCQ3c2T0tvT0xaVzFFN3FyN1hQa0U2L2UyUzcwL2RGZld0?=
 =?utf-8?B?djlDUnJJNDZHMUppMldVbFVGSU9WbENWK0k3N0dEK2o0ekJSTEVWZEpQam16?=
 =?utf-8?B?T3FZbWtldzRUb0xJcTc0Sys3Z1JQVmdUVnp2cW9EWmhzemgvNkNSdmxXZGhQ?=
 =?utf-8?B?TDUrRVB3L05WdDFTQ2Q4M0JENnlkQk1ISHp6bHJKNmFDb1NuZUpZS01tdVZi?=
 =?utf-8?B?dG1sdjdTRlNLU0Z0dmhPeGFrdlVDcTF0TkNORi95OThIaTlpT3JneDNGTm12?=
 =?utf-8?B?eXdDWVhMOTM4WmJCWXZKdWRGeExGZzMyZ0l6cDhIaUlMbm0yOUEwOVRKUWpo?=
 =?utf-8?B?dDVOY081UlV0Q0l2S1dmWWx2MFpwMGc4VlR6ZFZRZ2tjVlQwT1hJM1VHK3Ur?=
 =?utf-8?B?TXUrdW93WHRzbzlUTzdQeE1Xank4QWtXekNHQkxnV3FhQy9mRmh2K29jZlJq?=
 =?utf-8?B?ZkFXd2k5RVg4Zlo3UEVxMmFXY2pmcjN4UHlMUkdYZGdFWHc0TmZCcWdZWlkv?=
 =?utf-8?B?MzlNSVFZdFpEc0VGbjNsa1dEeTYvUlFReFp3aUZxQXNRaEtybk0yRTV4ZFlC?=
 =?utf-8?B?cVdDWlY5ZzJjeW5JMGE0REk3dUsreVhMWkE2eVdCU084bHJiZ005VjlUZmR1?=
 =?utf-8?B?RHU2WUFWMUI3Y0FzSU1kdXpCRU5kYldzeWtyMkw0WEJMc2xIdVJVWHFKUHpp?=
 =?utf-8?B?Y252VHpsNDNDUDhPMk1IZFFKamtOVGMrVExOUnBXS2cxaWtCRXBldStUWlJj?=
 =?utf-8?B?emRTNEFGSFl5SWlja1NYam5lazZQdXZNSFFWVWc1YWxhNkQ0Zk52b1BiSk9F?=
 =?utf-8?B?bzJ1cm5IMHlEYWhXQU0ya3MzRnlBTGd6UEpOWFRRT1VLTm81OWpDK1lWMFRx?=
 =?utf-8?B?SUtzSUg5d0ZxSGY1ZXY0T3o0ZDZxZ29odFhCNFBTRmlUNmZFUHBLbTJEM0lv?=
 =?utf-8?B?aXZDRVpIQjdkaTBUbDFTZ3F2TmZEV3hZVkV1L0gyQmd0d0hlbnNZc3pLSDd6?=
 =?utf-8?B?ZE1ybEF2c3d5RVJqUSt2TStOTTVpNGpDRHE0ZXBzaXJZU2h2SjljYWVpRHpL?=
 =?utf-8?Q?XL/1hAT7kfylUdEQ=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7319d9db-a406-462e-36a2-08de4f63e903
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 09:46:06.5331 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CQIik9f68p/nItFtmLy8zvzA9iZbvwNqUOtb4Q9Ec7kcmDWu9VZODcM+xgW2eZyob5UK7ERD2VSU1N7jJewst77LY5J7pOUPRZAtlY38Jgg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF529E923C8
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

On Thu, Jan 08, 2026 at 05:41:04PM -0800, Stephen Hemminger wrote:
> Add a structured reference document that enables AI code review tools
> to validate DPDK contributions against project standards. This document
> consolidates requirements from multiple sources into a machine-readable
> format optimized for automated validation workflows.
> 
> The AGENTS.md file synthesizes guidelines from:
> - DPDK Contributing Code documentation (patches.rst)
> - DPDK Coding Style guidelines (coding_style.rst)
> - Linux kernel patch submission process (submitting-patches.rst)
> - SPDX License Identifier specification (spdx.org)
> 
> Key sections include:
> - SPDX license identifier requirements
> - Commit message format and tag ordering
> - C coding style rules and naming conventions
> - Patch validation checklists with severity levels
> - Meson build file style requirements
> 
> The document provides actionable checklists and concrete examples to
> support integration with CI/CD pipelines and automated review systems.
> Severity levels (error/warning/info) help tools prioritize feedback
> appropriately.
> 
> This supports the broader goal of maintaining code quality and
> consistency as the project scales, while reducing manual review burden
> for maintainers on mechanical style issues.
> 
> References:
> - https://doc.dpdk.org/guides/contributing/patches.html
> - https://doc.dpdk.org/guides/contributing/coding_style.html
> - https://www.kernel.org/doc/html/latest/process/submitting-patches.html
> - https://spdx.org/licenses/
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

Good to see this being added.

Feedback inline below.

Thanks,
/Bruce

>  AGENTS.md | 410 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 410 insertions(+)
>  create mode 100644 AGENTS.md
> 
> diff --git a/AGENTS.md b/AGENTS.md
> new file mode 100644
> index 0000000000..cfaaa81af3
> --- /dev/null
> +++ b/AGENTS.md
> @@ -0,0 +1,410 @@
> +# AGENTS.md - DPDK Code Review Guidelines for AI Tools
> +
> +This document provides guidelines for AI-powered code review tools when reviewing contributions to the Data Plane Development Kit (DPDK). It is derived from the official DPDK contributor guidelines.
> +
> +## Overview
> +
> +DPDK follows a development process modeled on the Linux Kernel. All patches are reviewed publicly on the mailing list before being merged. AI review tools should verify compliance with the standards outlined below.
> +
> +---
> +
> +## Source License Requirements
> +
> +### SPDX License Identifiers
> +
> +- **Every file must begin with an SPDX license identifier** on the first line (or second line for `#!` scripts)
> +- Core libraries and drivers use `BSD-3-Clause`
> +- Kernel components use `GPL-2.0`
> +- Dual-licensed code uses: `(BSD-3-Clause OR GPL-2.0)`
> +
> +```c
> +/* Correct */
> +/* SPDX-License-Identifier: BSD-3-Clause */
> +
> +/* Incorrect - no boilerplate license text should follow */
> +```
> +
> +- A blank line must follow the license header before any other content
> +

Not strictly true, the blank line follows the copyright line immediately
after the SPDX header. The copyright line should be included in
descriptions and examples above.

> +---
> +
> +## Commit Message Requirements
> +
> +### Subject Line (First Line)
> +
> +- **Must capture the area and impact** of the change
> +- **~50 characters** recommended length

In practice I think we allow up to 60 chars. So 50 chars recommended, 60
char max.

> +- **Lowercase** except for acronyms
> +- **Prefixed with component name** (check `git log` for existing components)
> +- Use **imperative mood** (instructions to the codebase)
> +- **No trailing period** (causes double periods in patch filenames)
> +
> +```
> +# Good examples
> +ixgbe: fix offload config option name

Should be "net/ixgbe".
Since you have a driver example below, I'd suggest picking an example for a
library e.g. hash, to include as well.

> +config: increase max queues per port
> +net/mlx5: add support for flow counters
> +
> +# Bad examples
> +Fixed the offload config option.    # past tense, has period
> +IXGBE: Fix Offload Config           # uppercase
> +```
> +
> +### Commit Body
> +
> +- Describe the issue being fixed or feature being added
> +- Provide enough context for reviewers to understand the purpose
> +- Wrap text at **72 characters**
> +- **Must end with** `Signed-off-by:` line (real name, not alias)
> +- When fixing regressions, include:
> +  ```
> +  Fixes: abcdefgh1234 ("original commit subject")
> +  Cc: original_author@example.com
> +  ```

I know we *should* CC original authors, but in practice I don't think we
do. So many original authors have moved on, I suspect that this guidance
just causes too many email bounces to be useful. I would update this to
Fixes and CC stable for all fixes. Let's not burden the contributor with
determining if a patch needs backport or not - I assume the stable tree
maintainers have tooling to pull out only relevant fixes for their trees.

> +
> +### Required Tags
> +
> +```
> +# For Coverity issues:
> +Coverity issue: 12345
> +
> +# For Bugzilla issues:
> +Bugzilla ID: 12345
> +
> +# For stable release backport candidates:
> +Cc: stable@dpdk.org

I'd make this an always-add for bugfixes, unless it causes us other issues.

> +
> +# For patch dependencies:
> +Depends-on: series-NNNNN ("Title of the series")
> +```
> +
> +### Tag Order
> +
> +```
> +Coverity issue:
> +Bugzilla ID:
> +Fixes:
> +Cc:
> +
> +Reported-by:
> +Suggested-by:
> +Signed-off-by:
> +Acked-by:
> +Reviewed-by:
> +Tested-by:
> +```
> +
> +Note: Empty line between the first group and `Reported-by:`
> +
> +---
> +
> +## C Coding Style
> +
> +### General Formatting
> +
> +- **Line length**: Recommended ≤80 characters, acceptable up to 100

I'd drop the 80 reference. If we can use 100 chars, let's do so, rather
than having lines split.

> +- **Tab width**: 8 characters (hard tabs for indentation, spaces for alignment)
> +- **No trailing whitespace** on lines or at end of files
> +- Code style must be consistent within each file
> +
> +### Comments
> +
> +```c
> +/* Most single-line comments look like this. */
> +
> +/*
> + * VERY important single-line comments look like this.
> + */
> +
> +/*
> + * Multi-line comments look like this. Make them real sentences. Fill
> + * them so they look like real paragraphs.
> + */
> +```
> +
> +### Header File Organization
> +
> +Include order (each group separated by blank line):
> +1. System/libc includes
> +2. DPDK EAL includes
> +3. DPDK misc library includes
> +4. Application-specific includes
> +
> +```c
> +#include <stdio.h>
> +#include <stdlib.h>
> +
> +#include <rte_eal.h>
> +
> +#include <rte_ring.h>
> +#include <rte_mempool.h>
> +
> +#include "application.h"
> +```
> +
> +### Header Guards
> +
> +```c
> +#ifndef _FILE_H_
> +#define _FILE_H_
> +
> +/* Code */
> +
> +#endif /* _FILE_H_ */
> +```
> +
> +### Naming Conventions
> +
> +- **All external symbols** must have `RTE_` or `rte_` prefix
> +- **Macros**: ALL_UPPERCASE
> +- **Functions**: lowercase with underscores only (no CamelCase)
> +- **Variables**: lowercase with underscores only
> +- **Enum values**: ALL_UPPERCASE with `RTE_<ENUM>_` prefix
> +- **Struct types**: prefer `struct name` over typedefs
> +

We can strengthen and clarify this, I think: for new definitions, typedefs
only for function pointer types.

> +#### Prohibited Terminology
> +
> +Do not use:
> +- `master/slave` → Use: primary/secondary, controller/worker, leader/follower
> +- `blacklist/whitelist` → Use: denylist/allowlist, blocklist/passlist
> +
> +### Indentation and Braces
> +
> +```c
> +/* Control statements - no braces for single statements */
> +if (val != NULL)
> +        val = realloc(val, newsize);
> +
> +/* Braces on same line as else */
> +if (test)
> +        stmt;
> +else if (bar) {
> +        stmt;
> +        stmt;
> +} else
> +        stmt;
> +
> +/* Switch statements - don't indent case */
> +switch (ch) {
> +case 'a':
> +        aflag = 1;
> +        /* FALLTHROUGH */
> +case 'b':
> +        bflag = 1;
> +        break;
> +default:
> +        usage();
> +}
> +
> +/* Long conditions - double indent continuation */
> +if (really_long_variable_name_1 == really_long_variable_name_2 &&
> +                var3 == var4) {
> +        x = y + z;
> +}
> +```
> +
> +### Function Definitions
> +
> +```c
> +/* Return type on its own line, opening brace on its own line */
> +static char *
> +function(int a1, int a2, float fl, int a4)
> +{
> +        /* body */
> +}
> +```
> +
> +### Variable Declarations
> +
> +```c
> +int *x;         /* no space after asterisk */
> +int * const x;  /* space before type qualifier */
> +
> +/* Multiple initializers - one per line */
> +char a = 0;
> +char b = 0;
> +
> +/* Or only last variable initialized */
> +float x, y = 0.0;
> +```
> +
> +### Pointer and NULL Comparisons
> +
> +```c
> +/* Good */
> +if (p == NULL)
> +if (*p == '\0')
> +
> +/* Bad */
> +if (!p)           /* don't use ! on pointers */
> +```
> +
> +### Return Values
> +
> +- Object creation/allocation: return pointer, NULL on error, set `rte_errno`
> +- Packet burst functions: return number of packets handled
> +- Other int-returning functions: 0 on success, -1 on error (or `-errno`)
> +- No-error functions: use `void` return type
> +- Don't cast `void *` return values
> +- Don't parenthesize return values
> +
> +### Macros
> +
> +```c
> +/* Wrap compound statements in do-while(0) */
> +#define MACRO(x, y) do {                                        \
> +        variable = (x) + (y);                                   \
> +        (y) += 2;                                               \
> +} while (0)
> +```
> +
> +Prefer enums and inline functions over macros when possible.
> +
> +### Structure Layout
> +
> +- Order members by: use, then size (largest to smallest), then alphabetically
> +- New additions to existing structures go at the end (ABI compatibility)
> +- Align member names with spaces


Nice to have, ignored in practice AFAIK. Maybe not worth including.

> +- Avoid `bool` in structures (unclear size, wastes space)

Disagree on this one. Unless it's a datapath struct that must be small,
using bool is a lot clearer and easier to manage than bit fields.

> +
> +```c
> +struct foo {
> +        struct foo      *next;          /* List of active foo. */
> +        struct mumble   amumble;        /* Comment for mumble. */
> +        int             bar;            /* Try to align the comments. */
> +};
> +```
> +
> +---
> +
> +## Code Quality Requirements
> +
> +### Compilation
> +
> +- Each commit must compile independently (for `git bisect`)
> +- No forward dependencies within a patchset
> +- Test with multiple targets, compilers, and options
> +- Use `devtools/test-meson-builds.sh`
> +
> +### Testing
> +
> +- Add tests to `app/test` unit test framework
> +- New API functions must be used in `/app` test directory
> +- New device APIs require at least one driver implementation
> +
> +### Documentation
> +
> +- Add Doxygen comments for public APIs
> +- Update release notes in `doc/guides/rel_notes/` for important changes
> +- Code and documentation must be updated atomically in same patch
> +
> +### ABI Compatibility
> +
> +- New external functions must be exported properly
> +- Follow ABI policy and versioning guidelines
> +- Enable ABI checks with `DPDK_ABI_REF_VERSION` environment variable
> +
> +---
> +
> +## Patch Validation Checklist
> +
> +AI review tools should verify:
> +
> +### Commit Message
> +- [ ] Subject line ~50 chars, lowercase (except acronyms)

60 chars

> +- [ ] Component prefix present and valid
> +- [ ] Imperative mood used
> +- [ ] No trailing period on subject
> +- [ ] Body wrapped at 72 characters
> +- [ ] `Signed-off-by:` present with real name
> +- [ ] `Fixes:` tag present for bug fixes with 12-char SHA
> +- [ ] Tags in correct order
> +
> +### License
> +- [ ] SPDX identifier on first line (or second for scripts)
> +- [ ] Appropriate license for file type
> +- [ ] Blank line after license header
> +
> +### Code Style
> +- [ ] Lines ≤100 characters (prefer ≤80)
> +- [ ] Hard tabs for indentation
> +- [ ] No trailing whitespace
> +- [ ] Proper include order
> +- [ ] Header guards present
> +- [ ] `rte_`/`RTE_` prefix on external symbols
> +- [ ] No prohibited terminology
> +- [ ] Proper brace style
> +- [ ] Function return type on own line
> +- [ ] NULL comparisons use `== NULL`
 - [ ] Integer comparisons use `== 0`

> +
> +### Structure
> +- [ ] Each commit compiles independently
> +- [ ] Code and docs updated together
> +- [ ] Tests added/updated as needed
> +- [ ] Release notes updated for significant changes
> +
> +---
> +
> +## Meson Build Files
> +
> +### Style Requirements
> +
> +- 4-space indentation (no tabs)
> +- Line continuations double-indented
> +- Lists alphabetically ordered
> +- Short lists (≤3 items): single line, no trailing comma
> +- Long lists: one item per line, trailing comma on last item
> +
> +```python
> +# Short list
> +sources = files('file1.c', 'file2.c')
> +
> +# Long list
> +headers = files(
> +        'header1.h',
> +        'header2.h',
> +        'header3.h',
> +)
> +```
> +
> +---
> +
> +## Python Code
> +
> +- Must comply with PEP8
> +- Line length acceptable up to 100 characters
> +- Use `pep8` tool for validation
> +

I think we are switching to using "black" as the python formatting tool of
choice.

> +---
> +
> +## Review Process Notes
> +
> +### For AI Review Tools
> +
> +When providing feedback:
> +- Reference specific line numbers
> +- Cite the relevant guideline section
> +- Suggest concrete fixes
> +- Prioritize: errors > warnings > style suggestions
> +- Flag potential ABI breaks
> +- Check for missing documentation updates
> +- Verify test coverage for new functionality
> +
> +### Severity Levels
> +
> +**Error** (must fix):
> +- Missing SPDX license
> +- Missing Signed-off-by
> +- Compilation failures
> +- ABI breaks without proper versioning
> +
> +**Warning** (should fix):
> +- Style violations
> +- Missing Fixes tag for bug fixes
> +- Documentation gaps
> +- Missing tests
> +
> +**Info** (consider):
> +- Minor style preferences
> +- Optimization suggestions
> +- Alternative approaches
> -- 
> 2.51.0
> 
