Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8739FECD6E0
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 19:25:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 64F0D40395;
	Wed, 11 Feb 2026 20:25:14 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 3CB36402AB
 for <dev@dpdk.org>; Wed, 11 Feb 2026 20:25:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770837912; x=1802373912;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=ekcRSs1c6hXwzTNk0HDdsnMJHxnA0O42jtupgheCe+Y=;
 b=OKLAOk+jOJuFB3NsL/P6txuC2MGvHeqUThhX2nuRg+ptzEX38Y0ry0g6
 TPRhnCI51+fIMuMHph1WGb88pd65j0AawbwToPMsWiezTXMvWZ5srqs8B
 5sUpzLY/iSLQ+G+v4xmYWUE+yTaAQQXdWpDIeeF5L3X9xjD/u94n09JRO
 6KwMj/GTNLyNZ37+4rvI7zkMhxOaOl34ENvmRuB3H+2EVrHcxmgemxYmQ
 8+NesCYrFbmdCpq39Q6m4OMMApX1oIR19gCLeniHiCECsmvsEWBpZG0FF
 2CJKQPMOLkrpUOeV/h99GE7fFmXNHyLv4yi/kCMR9PXUZ1y6PZiOcdQhn Q==;
X-CSE-ConnectionGUID: fhhPACe9QrKlhcU+YsAk2g==
X-CSE-MsgGUID: dF6Uf7H8SeS5EqgyZ4ivIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="75620090"
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; d="scan'208";a="75620090"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 11:25:11 -0800
X-CSE-ConnectionGUID: SL044raGRe2Xtrh3vci5mg==
X-CSE-MsgGUID: uB1GBcalSGaVyVfFQnHKIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; d="scan'208";a="216602787"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 11:25:11 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 11:25:10 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 11 Feb 2026 11:25:10 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.41) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 11:25:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pp7qeAfrmuyjKFgO+TeLie/sBQZmdIuQ1e/8ySWv34wlvF/GPbsQv1Fipe485C3pMbCzgkMKLUiv2JyIAGCJWqaR0+81gY8LOQUzjfo3SE7pgL1D1E4+wdVXftbFl/ne9ATzZDOpO1bJjlCS3v+AQxTVVewgMZ/xfASJbbxb4fpl/Xzc6iGbweXX6xuco5SFYVidanGB9muaq7X5oJwECxAsH8bembVT0wN/v0lCe0m82rV2okSePDutbR5bB3RkAgHjrDwbj6v8zFjqSOsxykqMar0EekixQmmCGljWkQQlnmUlK1ByK1972xLncyQV0XKnc+jzKwylcLbFbfD3+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NI3BGgdVvenyMrKcy2MczOAUz0F1cOFwMeHIN5T0yFI=;
 b=uvyzWKzydPvgVeRpMc+n2P8Kcpc3UhXxRGbGlvjqE7AAO3eXgHKTLAIWI8plvcFOW0xCUXg2Luu4NgodkzW55QuFec1G/4RD6mFeIyG1o90pQgU8CaQqpEWdBw46rM9sH4/bQfiHY5doevZE7iJemqqObw3U8HGYSTdKtAK+qMhqEkidV/QA8xF44aaLN8ruvICjJshhw6CbPKBIujN+M5hBSv2zx23CSO/s5V8SbpyBe9b0lYby7vbMnFcK4+IXLZpc0xtdPIoaERRKntR/zfidd7u3q+aEGnuxxE1FbkiD7iLMtSnTYTyd29+KtiHwBYxb9q94Slk2bSGETXxJfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16)
 by DS0PR11MB6544.namprd11.prod.outlook.com (2603:10b6:8:d0::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.10; Wed, 11 Feb 2026 19:25:07 +0000
Received: from IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2]) by IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2%5]) with mapi id 15.20.9564.010; Wed, 11 Feb 2026
 19:25:07 +0000
Message-ID: <a98fea87-6860-412f-a7d1-e49a10f484df@intel.com>
Date: Wed, 11 Feb 2026 19:25:04 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/27] net/ixgbe: split security and ntuple filters
To: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>
References: <1d6d12f5387fb70df51a4a9bc38abced0e915548.1770817884.git.anatoly.burakov@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <1d6d12f5387fb70df51a4a9bc38abced0e915548.1770817884.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU2PR04CA0349.eurprd04.prod.outlook.com
 (2603:10a6:10:2b4::6) To IA4PR11MB9204.namprd11.prod.outlook.com
 (2603:10b6:208:56d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9204:EE_|DS0PR11MB6544:EE_
X-MS-Office365-Filtering-Correlation-Id: 018b87b5-2802-4961-4083-08de69a343fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z01Ua25vdTVZdUdIRlE4OWRmS21KZFNrT2liL2N2Yk5sODExbXd3NFNQazJT?=
 =?utf-8?B?NVBadnpUNVAySHkvdC96MUdFazJ6bWdwOTYxakw1SlN2MHZsZ1A0ZjdDKzF6?=
 =?utf-8?B?T0UxZXpOSk5nNXFMc3Z4UGRIdlhoaXg2QS9zOG9xRitGeVl2bGcxNVJWSVBn?=
 =?utf-8?B?cDMvTlJ0SzZOSER2V0hGVTNOdGFXcnQ3SnBVZ1NtSm9hRHVhL1pTV2hEUi9P?=
 =?utf-8?B?dHlwMllGYjM1cnlHcTFpNGovWHdUU3JtcExEYzFveGxPV0cyaklQNHpwQThD?=
 =?utf-8?B?NEZwaldSQzdWU0tmTVFKS0ptR2IzYzQzR1JFNU5GRGtZZVp6aEh0cldVZDF2?=
 =?utf-8?B?YmRrTTZhNjBwYmxKdWc4QzBHcnN3YlRCUGRDVUZUZ2R2QXBsQXJQaUxqekIv?=
 =?utf-8?B?K3R5RmxlRVdMalBKQmlPWHViN2JhV053MUsxeTA4eSs5SnMvWFJtYytnVmZ0?=
 =?utf-8?B?a3JjODIvaWZmMmFvdkFGbG9DZWM0NjZPSVI1WGhVN205N3luclBHbERwNFlN?=
 =?utf-8?B?RkVOSzlQWmZLZUZOMWRCWDlhOHN4VUhuaTJEUGYyOFNDcDVMbTc2RmFmb01N?=
 =?utf-8?B?RmdXekd6aGl3YVlrNC9vZjg4Rk02eVd1Sk10TUZCSXlabEY5WWV3TG9YT3Zt?=
 =?utf-8?B?ZjBiRGlTR2ovaVh0NHhwa29SSmxQTXZvZDdib2g3YUE2d2hRTXFsK3ZwN0lL?=
 =?utf-8?B?cHB4THJFNGtLMk81SW1QdVRaQjc3YU0wb1JvUGZlSDJuUlMwS0xVSGVaaVFC?=
 =?utf-8?B?TEMvNDc1VmlsdlZLSmlhWktWR3NISzFDTDBzR0M3YVRVQ2FuVjU2cmhGM3lM?=
 =?utf-8?B?azF0ZDRUajRhdlZmSzdvOHNWbDRmUWFiNEVFSGpCZmhGNUlzWUZIYlN3b2xu?=
 =?utf-8?B?NzI0MHJzWmRwQVg4Q1E1UVJ4SHV6aHZ5LzB3RjRscmxBeWhRKzlMdzd5WXZl?=
 =?utf-8?B?ZC85cUpQdTF6SzVwcXhQL3N2aU1GMnQreEw3YmhYb0dUTy9veGVWNGsvK1BI?=
 =?utf-8?B?U3ZkWDVVanh0azV0MW0wM3BkZlViNzJaUTBjQkswd3dKZGVWT1F6NFR0VWgv?=
 =?utf-8?B?TkNSaWdOZlRWUkplV3FpWjhCaE5zTGpsM1hJVmNzRUttSHdQK2M0d2lNcjB1?=
 =?utf-8?B?VFhzbGF2Z2hvMlNibnZnbkpQWHA5bEtIUzJBWENaTTYvVHN5WDQzLzFFcXFh?=
 =?utf-8?B?c3BJa2NsTy9DTDR1NjlwY3BmN3Qza2ljSjlSMWlHMm9iNWdwMXcrRXF4cGJ3?=
 =?utf-8?B?Vys0cUVMdGFsekdlZzk2U0U1Mnp5N1kycVlTVnYzQ2pibE1QQ2lDR05zQlcr?=
 =?utf-8?B?dXhzMFVrWnhVUXRJSzAxUlYxWGtDWms0aEc5WDF4OGx0SEFYRUpGYnBOYlcy?=
 =?utf-8?B?TkVmVTkwOHJDQ0hsV2lDZ2lMRUVwTmRJekFvZHFnZXFOUFFHekpYTnF5YUUw?=
 =?utf-8?B?OFRQMldiZE9WcTk3Y09vTGpQaTJocEh3dERwQVhGc3N2bWlqdTRWUzFWREdT?=
 =?utf-8?B?eXlVQmZJSXYwYjB4VldHb0tBMk9Tc0ZpV1JTK2RGcWloa09jdnF3THRMVEFF?=
 =?utf-8?B?YU5hWngwWk9rMGt4aFRnc3orRlJnZmpEaHlFU0gwWXBidXVxRjgveEg1T0Yy?=
 =?utf-8?B?bkszWm9JQS9HMkxIelJZR1ZXYS8xREk3a1BoVi9JTGVDRW95MkN2NFRTZ2Zq?=
 =?utf-8?B?cERyWnhxdlZqb0dENGxjT0g3OVpoV3BUbUh4QkF4TitiVGp2S0NDcjQvYnRx?=
 =?utf-8?B?UGdGUzhvcG1neHI3ajhVMU81SEdZQkZ2eXhlR1NyOVVaNXNucU1IWFVOT1lW?=
 =?utf-8?B?R3dqVE1GaEh4ZTJPZzhEcVhXQXlzMWdrMlpVb1hvTnNmSk9tcEhzL2JtSjZW?=
 =?utf-8?B?TTlqNUxCSXE3ekE4dUg0bHVtb0FGM3hQelZvaTc5Rlptb1RsT1dvTXJrSGJR?=
 =?utf-8?B?dUNKbldKb0dYU1BpQlE4YzZ6Sk9yY3RJQU5Ua1h1RVIwSEdlc3V2N3E5SVhk?=
 =?utf-8?B?cDhrOWEzNjlrbFowV2hVTlpTbGFHM1FRZVRVd3Z4N2Jxdm12Rkt6Nk9xa2ov?=
 =?utf-8?B?eHdFbmhHTVNWZGJSNnlUcFhVNlZJMm1PQU8wVitqWitPOStVZU1QVzYyVmZV?=
 =?utf-8?Q?NYPg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9204.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlZDbmM3UVlIanhHNnQxbTJZYkFjSnNhc0hhNGJ3YkxydG0yL09ldGI4RnU4?=
 =?utf-8?B?VnJJRXR4MEdEWEtiSm9QeUpmY0NCc2JGZ05aSUNsbnJRZTJpVlR4SlJOVGtu?=
 =?utf-8?B?SVY3dWZJS0o4Z2IvZzRRaTZOVzFQVWFwUEV1Z3VXeWs5WVR5RmFkNTFvdkpw?=
 =?utf-8?B?bGphQzEzRGovTUdIZkVzZGVxNkVkNnVoeWR2WWNXRVJ6K0gyeWx5b1U2ODA4?=
 =?utf-8?B?bWZHV1l2azZoM1Fmd3BRQ0NnakpOZTRqV3VGbjNWVjJrZmxFb1k5SG5mbVJv?=
 =?utf-8?B?YXg4M0J4Y0FsZjhwMkRXTnZFV0ZpM3o5WTVVQ085WU9MdUxib3dTdEFhRWdz?=
 =?utf-8?B?anUrYnE1dk4zVklwQy9seGFkZ080cnhPMURvd2t2LytkSlVtdGVLekZUZDJ2?=
 =?utf-8?B?QzVsTnJiUitLbHVUZEFzN2dmaHRmVXBMTUU4L0drVEFsMWJDOTBnamlHb1Rx?=
 =?utf-8?B?QWg1V3JoZnFFd0JCUFBTK3U2a28yRXh4cWZULzJBeUZMYys1ZmwrSHI0VjZj?=
 =?utf-8?B?OEg5ODVQcW12SFBZWTJacjNUYUJKK1lBd0dBaThoc1N1U2FEZ3ZlY1ZLV3hk?=
 =?utf-8?B?OVZISXZlQ3VZWUtndkliNzcrMkJsNlFqL2RkT2tiWGRtL3dveUtEWGNJOXJ5?=
 =?utf-8?B?bG1EQ2NpVUQ1NjdWWEJnUDAxL2xmQWtFbk91ZHZVQXpjUkpnMXl6Rk9rU01j?=
 =?utf-8?B?eEdQNU9DblVHT0tNd0RMUloxYmFpWVg2Tjc1b3NoODIzV0t6NCsyU3hscTFy?=
 =?utf-8?B?bkV1WkxqL3YzdkJPekZPVXhoY1RFYkF3MFd6bmtPUldITnhrU0Z5eHROblVM?=
 =?utf-8?B?TThBdTZ1djJwRW1ReWNYYmpsS1FSYm1janhNT2k4YTBXZHF4ZzhDVGhGcng1?=
 =?utf-8?B?MEFjQnBtUW9icnNmV0hxUG1kZituWk5uc1RRT2Q4ckh0V0VGYlVNT005eHBB?=
 =?utf-8?B?YTlkcVJOZHAxZ1RlTTVEM1E3QkVOV2J6THVwb1FQOXhKQzZsRkpZb3IvTkNt?=
 =?utf-8?B?b01WdmF3bVJLQTFmSVYzRE1qQzY3akpjZXB1NkRPODdNZVM3ODJjWWE5NUZP?=
 =?utf-8?B?WUpLYndJT2xBYm1SQWdBZnFtck5UMEZZTThtNStPMXV5Q29sMVRpVXJUSjF6?=
 =?utf-8?B?VnNiYUtYc1NLMnJISDFIeXNObVJlMGJiVHJSRlVqNlM0MkI1aDFVNXpCNmJO?=
 =?utf-8?B?NVNIUlNoUnJPK0IyRkZEUWRqYmFHejhOUndUZ0kwT01CL1ZtVUU0VmlOdGV6?=
 =?utf-8?B?bU5WVEhzN1BVTG4wcUZtOHJxZ3g4TzFMYkRJd2xSOE5Ocld4REZ6bnJkWFBq?=
 =?utf-8?B?S2NkOEdxMWlaTXhLMlVuMVdWZHFyU0Z5eXNacC85c1JhSXhBKzFRMW1xMlBp?=
 =?utf-8?B?OXpScSsxNXVmMy9xdExJMjJFQUhRTzdGaTMyVk9JK3BYdHBqVldYWmJ2a2ZI?=
 =?utf-8?B?emN6bTFQUThMY3JrZTZma045Ni96dlZ1K1pkU1dta2FkelFETHNaWU4rcDJP?=
 =?utf-8?B?QWVaMFArdS9JRDh4cXBncERtTHM3U21RTjRIUUpGQUViTXR1Q3NiQkZ4ZUNa?=
 =?utf-8?B?VGNSRm54WW1sazJIeHNKV0t1b0NzVmZaR21NNTZEL3N1TGJKeGdZMXoxSVU5?=
 =?utf-8?B?MUtwU3FDTXFpQ2VXNHA2OW5UV2lWb0Y5U1Q3R1czcVNSUlRNS0lCb21JbVBq?=
 =?utf-8?B?R0tCem85S1NzV2VtcHRQb2VaR0wvMm9tdkFpZWpyb1c0eWk5S09PUkhMbUY3?=
 =?utf-8?B?dU1od2lla2lMaDUxZXAxT093Y3h6dzZHemhMeWpqOGlvUmhKWDZpaVFEUm5h?=
 =?utf-8?B?eDB3V0puWGVRdUFaanlxakpxN3M3cm1jVlBnM0VTQ1AwanJjbDhHOXdsNlFi?=
 =?utf-8?B?ZnA1WTVDMVJZa3NSUFFDQ2pxdVR4WmhFSXFkaU9jWXFxdHY4S20zdytoTjF5?=
 =?utf-8?B?cHRXMjYreWZrUVltQ244U2tKZ2d5OHd5aFVxODRIelNpd3B4NW5kTXpLK1Nn?=
 =?utf-8?B?WVJYbHJPdUpxdjZHK0d4TkpyT3NqQ3JHZmJ5N2lIdUdDKzNZMjE3aXM2enFr?=
 =?utf-8?B?dHZEMFJMdTJLVFlPQkdIU1UrTW03dmFNVGEyMCtGQnZjaEFCVnFVWUJzZTZP?=
 =?utf-8?B?ODQ0K1l2b0RPMnFjOHRvTGZ6eHZDQ2FncGVhaXBjRFRBM21GOUFNWDlyR09R?=
 =?utf-8?B?a09mM2RZNlRYV3pyc0JrUUJvOUY3RDFiYndXN2hQcUUrcjM0d0dPV3ZVaFZz?=
 =?utf-8?B?U3RId3cxWHpZcWFmOTNXSjhRUWhKSnovMUVUSzFiRVVHYUU1Wk9scjF2ZXpx?=
 =?utf-8?B?NGFxVDlRRHZwV2doRXlaQUxBTWh0VU1CNElXdTVubHplNWZlREtrNkgxbW8r?=
 =?utf-8?Q?cfqD0ZE5OyAGkrx8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 018b87b5-2802-4961-4083-08de69a343fe
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9204.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 19:25:07.6859 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: okQZ6925V4p7FZWHpcC0BADhnpJt02t9KoAQ+rxIK+h0i0hlxJtfnTkkMqzHOtI/oLaOim1OdxGOse5rpU3OXLPtVKYvh94B1Y8JJhiN9VQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6544
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


On 2/11/2026 1:52 PM, Anatoly Burakov wrote:
> These filters are mashed together even though they almost do not share any
> code at all between each other. Separate security filter from ntuple filter
> and parse it separately.
>
> While we're at it, we're making checks more stringent (such as checking for
> NULL conf), and more type safe.
>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>   drivers/net/intel/ixgbe/ixgbe_flow.c | 136 ++++++++++++++++++---------
>   1 file changed, 91 insertions(+), 45 deletions(-)
>
> diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
> index c17c6c4bf6..cd8d46019f 100644
> --- a/drivers/net/intel/ixgbe/ixgbe_flow.c
> +++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
> @@ -214,41 +214,6 @@ cons_parse_ntuple_filter(const struct rte_flow_attr *attr,
>   	memset(&eth_null, 0, sizeof(struct rte_flow_item_eth));
>   	memset(&vlan_null, 0, sizeof(struct rte_flow_item_vlan));
>   
> -	/**
> -	 *  Special case for flow action type RTE_FLOW_ACTION_TYPE_SECURITY
> -	 */
> -	act = next_no_void_action(actions, NULL);
> -	if (act->type == RTE_FLOW_ACTION_TYPE_SECURITY) {
> -		const void *conf = act->conf;
> -		/* check if the next not void item is END */
> -		act = next_no_void_action(actions, act);
> -		if (act->type != RTE_FLOW_ACTION_TYPE_END) {
> -			memset(filter, 0, sizeof(struct rte_eth_ntuple_filter));
> -			rte_flow_error_set(error, EINVAL,
> -				RTE_FLOW_ERROR_TYPE_ACTION,
> -				act, "Not supported action.");
> -			return -rte_errno;
> -		}
> -
> -		/* get the IP pattern*/
> -		item = next_no_void_pattern(pattern, NULL);
> -		while (item->type != RTE_FLOW_ITEM_TYPE_IPV4 &&
> -				item->type != RTE_FLOW_ITEM_TYPE_IPV6) {
> -			if (item->last ||
> -					item->type == RTE_FLOW_ITEM_TYPE_END) {
> -				rte_flow_error_set(error, EINVAL,
> -					RTE_FLOW_ERROR_TYPE_ITEM,
> -					item, "IP pattern missing.");
> -				return -rte_errno;
> -			}
> -			item = next_no_void_pattern(pattern, item);
> -		}
> -
> -		filter->proto = IPPROTO_ESP;
> -		return ixgbe_crypto_add_ingress_sa_from_flow(conf, item->spec,
> -					item->type == RTE_FLOW_ITEM_TYPE_IPV6);
> -	}
> -
>   	/* the first not void item can be MAC or IPv4 */
>   	item = next_no_void_pattern(pattern, NULL);
>   
> @@ -607,6 +572,81 @@ cons_parse_ntuple_filter(const struct rte_flow_attr *attr,
>   	return 0;
>   }
>   
> +static int
> +ixgbe_parse_security_filter(struct rte_eth_dev *dev, const struct rte_flow_attr *attr,
> +		const struct rte_flow_item pattern[], const struct rte_flow_action actions[],
> +		struct rte_flow_error *error)
> +{
> +	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
> +	const struct rte_flow_action_security *security;
> +	const struct rte_flow_item *item;
> +	const struct rte_flow_action *act;
> +
> +	if (hw->mac.type != ixgbe_mac_82599EB &&
> +			hw->mac.type != ixgbe_mac_X540 &&
> +			hw->mac.type != ixgbe_mac_X550 &&
> +			hw->mac.type != ixgbe_mac_X550EM_x &&
> +			hw->mac.type != ixgbe_mac_X550EM_a &&
> +			hw->mac.type != ixgbe_mac_E610)
> +		return -ENOTSUP;
> +
> +	if (pattern == NULL) {
> +		rte_flow_error_set(error,
> +			EINVAL, RTE_FLOW_ERROR_TYPE_ITEM_NUM,
> +			NULL, "NULL pattern.");
> +		return -rte_errno;
> +	}
> +	if (actions == NULL) {
> +		rte_flow_error_set(error, EINVAL,
> +				   RTE_FLOW_ERROR_TYPE_ACTION_NUM,
> +				   NULL, "NULL action.");
> +		return -rte_errno;
> +	}
> +	if (attr == NULL) {
> +		rte_flow_error_set(error, EINVAL,
> +				   RTE_FLOW_ERROR_TYPE_ATTR,
> +				   NULL, "NULL attribute.");
> +		return -rte_errno;
> +	}
> +
> +	/* check if next non-void action is security */
> +	act = next_no_void_action(actions, NULL);
> +	if (act->type != RTE_FLOW_ACTION_TYPE_SECURITY) {
> +		return rte_flow_error_set(error, EINVAL,
> +				RTE_FLOW_ERROR_TYPE_ACTION,
> +				act, "Not supported action.");
> +	}
> +	security = act->conf;
> +	if (security == NULL) {
this looks like a bug fix. In a previous implementation it didn't check 
if act->conf is NULL and  consequent calling for 
ixgbe_crypto_add_ingress_sa_from_flow() immediately dereference it. 
Probably it would be great to backport this as a fix.
> +		return rte_flow_error_set(error, EINVAL,
> +				RTE_FLOW_ERROR_TYPE_ACTION, act,
> +				"NULL security action config.");
> +	}
> +	/* check if the next not void item is END */
> +	act = next_no_void_action(actions, act);
> +	if (act->type != RTE_FLOW_ACTION_TYPE_END) {
> +		return rte_flow_error_set(error, EINVAL,
> +				RTE_FLOW_ERROR_TYPE_ACTION,
> +				act, "Not supported action.");
> +	}
> +
> +	/* get the IP pattern*/
> +	item = next_no_void_pattern(pattern, NULL);
> +	while (item->type != RTE_FLOW_ITEM_TYPE_IPV4 &&
> +			item->type != RTE_FLOW_ITEM_TYPE_IPV6) {
> +		if (item->last || item->type == RTE_FLOW_ITEM_TYPE_END) {
> +			rte_flow_error_set(error, EINVAL,
> +				RTE_FLOW_ERROR_TYPE_ITEM,
> +				item, "IP pattern missing.");
> +			return -rte_errno;
> +		}
> +		item = next_no_void_pattern(pattern, item);
> +	}
> +
> +	return ixgbe_crypto_add_ingress_sa_from_flow(security->security_session,
did you mean &security->security_session here?
> +			item->spec, item->type == RTE_FLOW_ITEM_TYPE_IPV6);
probably need to add check if item->spec is NULL
> +}
> +
>   /* a specific function for ixgbe because the flags is specific */
>   static int
>   ixgbe_parse_ntuple_filter(struct rte_eth_dev *dev,
<snip>

-- 
Regards,
Vladimir

