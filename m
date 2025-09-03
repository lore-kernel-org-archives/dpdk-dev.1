Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA339CA0FF2
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Sep 2025 14:25:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 35737402BD;
	Wed,  3 Sep 2025 16:25:24 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id B3A4040281
 for <dev@dpdk.org>; Wed,  3 Sep 2025 16:25:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756909523; x=1788445523;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=PacMBR9CVef5RAXzor9Plk8kbemtucGgpEz89hkZHDw=;
 b=jRy3OPxp+0czTUfJBMEOwFfxTmw5889vRauGJKJt1afeZYLkIRHdlqut
 nNGjUbWS40Pjc4hhLB2iDkxNYW74/eS0Wkb3i4qy2N+yq+m4xTXkQCXfB
 gMu0m9UmP6aP3oD1fTNkx83TExrG1gv+HrUQUweZMPP1cQW1rfdDwlzzI
 P26XliYbUVhsqc6Z6VKWyb2Zv5C6ELLETBtnVRQxhlLHewW4YYvCJjta9
 eXjpJbSRczIIFKOHOLnRvwTVqsKqprPbK5xkKU3F8d82+JTBP16Re8uWA
 GLECT1pUEi6Uhjw5l/vB7KIul8oQFHpwAyDaLjuAZYx2sBtaqmib7z6hZ w==;
X-CSE-ConnectionGUID: OJoS14pbR6uepd/2YMiTCg==
X-CSE-MsgGUID: NxGFihuSRwiNmQe8EzgLlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="59370056"
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; d="scan'208";a="59370056"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2025 07:25:22 -0700
X-CSE-ConnectionGUID: qM8LN0xUSKm21nZy+Jvoyg==
X-CSE-MsgGUID: OXAbjhkbRFmzf6bSEjKp+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; d="scan'208";a="171553590"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2025 07:25:22 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 07:25:21 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 3 Sep 2025 07:25:21 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.73) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 07:25:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RgPEn0lsIDWqft2AcxnaZjKaqsttCvaDsSRTzVwbgXVkWEtXTplytsJyrO2bTyllFD9OJbVrAxjOVwP4FC7onHosjwek3npPaYV2k5DsGloEWjDnhdArQzu8j2lbcnmzrkUoo7ObQgogUJM4J/h98QrTKnn4tMOALNgcggwWgiaQNXILgDlJ+LugLeaOUR+HomHgIhFPUdPFT+V2DIBOkPY9i3IJHz5HjBrfc7ryuaI3o8zAS4Teti0U6EKjAJMijWeOuw9MtPy5yRqjDNK1mlbQEX2MK2WtsGA5uF8kVAbut6uXQFqmuuLwq3F105KJKzhvOhgeQVp92LMrtgud3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CFCaquYugve//wJa/U83780OsyTEm4R2WWhqinxlfRM=;
 b=SBuJIEYE4uQ6UuLUzNHJSl2lPzX3pIHHwbCOLznSmjm+ENt45IIncPJcscW8b2UPCv+PJ8HNtXYrF4Y6S+6TKFn142lH/7/LUAucKrFwus/h2ljzDpaVxo1T5X2ZFcWA/QsKDPyQysMCoCNRkXZgWdz/jT2dt48TdzyCsPT1zPwfNjMNYcCKTLUA5H7ZgJvnIdlkpLmKRGXg5t50CvZlSLMatDlqBzK0jswjDTj+pwtSSqX9H2pCyBs514/AyCJcdOqb7czcjSdVvn5hIJYFA46uUC0ZUNDAO0RTiXQxhU0is/iPHmSUa7KJgpAbTC+IvJ9A4fOByaFW7y1ruB5Wmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 PH0PR11MB5126.namprd11.prod.outlook.com (2603:10b6:510:3a::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.17; Wed, 3 Sep 2025 14:25:15 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::21e4:2d98:c498:2d7a%2]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 14:25:15 +0000
Message-ID: <ac5775a3-d5bd-4fec-9b0e-dcf92ca7ed47@intel.com>
Date: Wed, 3 Sep 2025 16:25:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/8] Cleanup VFIO API and import Linux uAPI header
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <maxime.coquelin@redhat.com>
References: <20250903072826.1727004-1-david.marchand@redhat.com>
 <e08e6b4d-737b-4254-b8a6-16613f67eab2@intel.com>
 <CAJFAV8yQ7D-k4ZjiP6jet2RrhNO0Y18iqXpdidB+AXOgTrFdxA@mail.gmail.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <CAJFAV8yQ7D-k4ZjiP6jet2RrhNO0Y18iqXpdidB+AXOgTrFdxA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU6P191CA0008.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::20) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|PH0PR11MB5126:EE_
X-MS-Office365-Filtering-Correlation-Id: 909a943e-dde6-4b4e-b11c-08ddeaf5b357
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SjlHSXYwNEVUTkF0aE9Yc002RUhVRVB5MHJCWWFaaXVSV2V5QTM4Nnpvb3NJ?=
 =?utf-8?B?andIYWhPMTRlTUpXYlZNZEZscUVGa1dpR1ZyRHhVOVpJR3FsaTFPVEVFSmJh?=
 =?utf-8?B?U3M1OEUweTh5NjBLUWcwckkwS3JEN1ZSOFhRdW1SSjNSc0swWTlGV2MxM0tx?=
 =?utf-8?B?SitZeS92N2VNNGg1R01LRW5hWlZ0dUlHUWdVTXkva3NEdnR5cS9oREw3S3JZ?=
 =?utf-8?B?bXhZZGE2QVVHTitkbWc1QUh0eE0rejJqdzlhODkyK3RpdlVVWGNkR0FoQldP?=
 =?utf-8?B?czVHM20rRjhUbEZXYVZlZmdVc0t3K1ViekRFSWtSN3d3dFJadnJ5cWpubStG?=
 =?utf-8?B?TXpVZ1RRdlYzazcxY0FEM011Uy9CZkdhVzNUWUFjbzVJQ2FEZW9pTXFZK3BR?=
 =?utf-8?B?d1dDL1pmdkI4amsvY3NQejdITUJMaG5wdmZ5dzRvMkxJWFl0QUUzcVFYY1A4?=
 =?utf-8?B?R21xbUZuTVVLRm5IeDFwQW9XZkMvbGxhcWZNRURBQXhNcnRBWXk3ZWNwZTVt?=
 =?utf-8?B?VkVhRDJPOWhwWGQyQVpJU2U1OGJYeUJYczg4d1IzR0cvUmZnNTQ5cW05Z0hl?=
 =?utf-8?B?VXdJY0lZUmU1c1hvTlRVL2FUL0tWbC9EQmtZTmdEUkk0bjZiSy9JUEZYeTFS?=
 =?utf-8?B?ZjJ6eFZoZlVKNDBHZkM4UXFsZE1yQ0pta00rRGlRc0tsbjlPaENHaXRGZExv?=
 =?utf-8?B?UlVQYyttcVFCS3hZYmhCZmRjWEtOa1ptWmtkNzRpeXpSSlNrUUZYSVJQczRz?=
 =?utf-8?B?MlZGQ2w5WG9nZWtaLzRrSGQ3ajBQWVZvQjg1RW9RWStLWGRuTmE0WVRQMU5G?=
 =?utf-8?B?MlNrWGIxVVU3WklDT2V1cGZYM3drckRxMnd1NERhS0NyVUxQK3B1cDU5bEU5?=
 =?utf-8?B?RjRxcFBscERIeU5qT1FmaVhpRUhZaktWVUNyRURoeHAxWm1pVTFXSVJmSmNu?=
 =?utf-8?B?U3VLRDdaam8yYVgzemJ5bXVMbFY2bE5OUGdVTXdGbWFaT0pqKzBaN1hEY295?=
 =?utf-8?B?N0dWc0x2U3NFSXlSb0J3MzN6bGp5c1BHTjR4VDBiWm8ybXU4WGQ4NjdxMUor?=
 =?utf-8?B?MlpDR0hLYWNlRFlGQ0c2Rk4xeFcvK0pzdXF5eTYrbVJBOVBEZU9PbHVxeHhV?=
 =?utf-8?B?Y20ySTQzV3phMnJaVklPR2NSZjRqRUZwUGIyZklvazRRM1B6ZUtCOHdORG9h?=
 =?utf-8?B?RU1IVnZvMGE2bk5KbHNKY3FQU1J2VW8vZE1NUkRacVdsOVNuNFZ6TjhrVUxE?=
 =?utf-8?B?VzQvcnVEa2xVb2t6QXoxNmNPWmRrc1k1V0xNc3VBMW5EaTlBcThoc1BqNm0w?=
 =?utf-8?B?b3pxaEY5ZXFmTkczeUM1UElteGpXVCtYeXhOVG9FdmdwTEpvZDhvR0FmZU5y?=
 =?utf-8?B?aWJBTG5xb3hhYlNRYlQ2a0FCclpYT200aUI2U1JlV2I1SWU3ZDRZcnBpYXJn?=
 =?utf-8?B?TWxnRE5qTVNTdjhrN0I4eHJCbVdGdUdLUG0zcWRQbEJYb3VUbWZBenRsRlBF?=
 =?utf-8?B?RmFPK01ja2JwNXFqQWJtRHZyamhuelRjZEFyRjlVZGs0SGhQREFpRmFWMjVY?=
 =?utf-8?B?YWpocFVhQ0xXbmdabldZSnZCdnVGSTBLV2xEYjltSStBaU8xWlEwMlJKRVpX?=
 =?utf-8?B?b3NhakVMK2hLUXc3NFRDRmx1YjM3YzZrampUN2lZek93dHV6cXYzSTlicVJj?=
 =?utf-8?B?ajBKVWU3SG5NS0Q3VHNraFlaTE1icTVOVG5uaXV4TC9qS3NwRHF4YmlXY09h?=
 =?utf-8?B?dGVJU1dWUmxmaHE5VVNuS0IvREVCb0FERE1YQnc5cWhjQm1vSXEzL3NMQlpM?=
 =?utf-8?B?SzFVWVlJZVhIM282ZndlUFVTVGRhTXRVTys0bFg4RDlhc05JT0kzb2xmQVlE?=
 =?utf-8?B?RXpseVRXMlc4NVhhUWthcjVFME1LTytsWURxTXdpM3gyVzdNNC9nWnB1OVdS?=
 =?utf-8?Q?Ks0qj6z35Y0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0s3cWNIeCs4YVd0TkQ0TGZZNUpCQ0V0OW1kUXdjbXlMMWJzTm1yR1QwTlJk?=
 =?utf-8?B?N3pCWDJsdXJQYThLV1dhUjltSVJJeTBsSC9tR1VOMmhyb0oxUldTTkxjbWNS?=
 =?utf-8?B?V2RLajFXNWNUZnZCUngwbmVJMk5lYmtkWnhkU2FXc1NaY2pLVDJRRGVtbXFn?=
 =?utf-8?B?VE5vNldRUEhGai9ZZ3JuUWVyd3ljZXNmeGtQdG9ZbmRUY3grcklTVEs3OW56?=
 =?utf-8?B?NE50MGpQaHpzZjNzWGNQalQxSGlZbzVpdzVVNjFjRUt0Zy91Wm1nYjRlbkJw?=
 =?utf-8?B?ZFdsZGpGV0ZEdjRCUnVkY2UwOHhHK1RBMVdibFVSb2lKL2J2TWl2NWRoVWhM?=
 =?utf-8?B?V3EwRHUrenB4c1lVZWUwTmd4ZitSYmx3cjZQK3FQY3BycnRJME9kaHppZjBI?=
 =?utf-8?B?VzBoZVBCRE9SMi9TemJNdzdkc2daN1FwQVZjVFFhcVBTWkQ1U0RwNlJHUGlw?=
 =?utf-8?B?UHpIVGZkTVBIZHEzTmVjUlFyeHRSNUdCbTNOdnVmeGswRVdEOG44SVhvUUlu?=
 =?utf-8?B?SU9VV2VXYkhVc1M1SzhVa2tnYXpCdzlFRlQxb2dKT2Q4cTlRcWk4UHEyaTY0?=
 =?utf-8?B?ejBKU3hLaUI4MWp2OXVEdkpIWEU1NnQ2OG9TR2kwQkVnM09vSllLMiswbUlk?=
 =?utf-8?B?TW00SFA4OHFhZ2RqbmRrTm9hQ2JYUHZsb0pYZHVudGcvM2RsLytkUVQyRGV0?=
 =?utf-8?B?bjBMOWx4eWo2T3ZPb0ZPek1lVWpzTW9nZ3EzZ2RtaWJuditiUmdGaVROVWIy?=
 =?utf-8?B?UW5xWWwzNHVlZTRSV1o2V2VJK0ZYbEpldjlkeWZ0RTFPUEc0SkVwMVpyakhu?=
 =?utf-8?B?cW83Y1RLbnNyVTJFRFdTbGRuWTd5cTJpUGh6MVp1TVhVQXkyZWFkUllhUk9v?=
 =?utf-8?B?SWJtWGJ1V29qTWhkZTFxTTdqOWR0WG45alNxSkxtdTdGMjdTcWJZQThCdmpj?=
 =?utf-8?B?M2FZMGl1VnFxSXQ0RmlmUzhoUHcvTFo4UFVYRzRqdS9VN1lIbFJ6UnFVNm9x?=
 =?utf-8?B?QnNnYms5T0NWRitTQWRvb2R2bWIwYkFEaEtwd0l3M0xRNElXTGlLRSs3L0t5?=
 =?utf-8?B?Q05ZQnM2WnhGTzkwMDF6QU96dFh4OXZicFQxSGNSTnBtcC9vdjJnR05FWm1k?=
 =?utf-8?B?K0tGVi9uYmlKcWVyTS9Mb0R3blJldGkxV3NTNmJwMlQ5SnJubFltS0kxR2xS?=
 =?utf-8?B?UXpVZE55ZUdSTmJXV0FMZjJqL0NrTTM2TUxOWW9ubnViUmNTOG5jV2ZZWG5a?=
 =?utf-8?B?QnBPUWt6SHJ4eWtSUk1zWXNFcHpPTFBXSXFlYnByeVArTUpUOXIwYndzRU5q?=
 =?utf-8?B?MUJnOFBFclNNZWNJOVd6ck9OS1VKUlhZU0RKYUpFUmJFMmtYZExLTWk5WEE4?=
 =?utf-8?B?YjRoRTBhQ3pVNVBiVXJtRWRKbzUvU1kwWWQ3WTR6Z3dkZGRsd1dYL0lQNDZM?=
 =?utf-8?B?ckE4TVlhZXJHMmtSRzFkN2owK2VEaytKcDE5Q1NjWVEvOUNPZGZPWE9rM2Nl?=
 =?utf-8?B?R253UXB0d1QvUzhSRjF1QkJXZEVxVkJ3dml5ZWpjdnBVWVNrSm1KeFdxWkNk?=
 =?utf-8?B?SEloaUtNblZUWkFSN1VjcVRPUkJBaVJZQ0R2M0V5UGdzdzlSVGhrbzZoMlJ3?=
 =?utf-8?B?UTJvdEZudGdHeG9FZ2kzZHIvU0tnUXY1SDUwdnYrYVNHaUNxUFZ0eXY1US9s?=
 =?utf-8?B?bCtwVlFhK284dVJKT05VOEZ3emFuZjRqcXBHV1VmUk1FVEovNGpwcXlySDhI?=
 =?utf-8?B?ZStDcVEwZXg0VlYwM0JCNmlOWHVsUXpZckJyTzlBeEtmNzk3NlpCeFdGUUN3?=
 =?utf-8?B?d0lndnVjNGhhcm5nVmxuMmRVQnRkRXZPQkl4MnlOZ2lBRTRhZ0JlTC9lYWNk?=
 =?utf-8?B?Qi9xRzNHVzM0VDNaK1dMV0NUUG82Q2puTWJ2dmo1MkttR0grYlEzTU5GRlcv?=
 =?utf-8?B?V09qS1dYMnZldE9VdUhWZ1VBUTFqakxVQStGbSt1dFduZTcybGlNTTBsY2Q5?=
 =?utf-8?B?SjhlOG1LWGs1L1dKTEtsWk1zZ3lMLzBmOFY0WS9lTEdOZkhHNWR2SjdmTCsw?=
 =?utf-8?B?V000emo4VFVYRWI0N2VNYjdvcWxLdUczS0hIMUxpbjJ4eGdTbTB1Rk1DMGlr?=
 =?utf-8?B?ZndicE5VaGlVQ0lzNXg0WThxTGNla0haVGIyT2ZZK1hrWll3Ry9FMHJ4elNv?=
 =?utf-8?B?UkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 909a943e-dde6-4b4e-b11c-08ddeaf5b357
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 14:25:15.5021 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D9WvvY9T/L3azV7vvGqTys6nNf4UNmjWEFDaD7R7J/OugPYq59HGKtyf39z4MAECu6bgY9bZ7c7AecGkR8GniW8BSfJLFrW/7TfFvmylKJo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5126
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

On 9/3/2025 11:52 AM, David Marchand wrote:
> Hello,
> 
> On Wed, 3 Sept 2025 at 11:30, Burakov, Anatoly
> <anatoly.burakov@intel.com> wrote:
>>
>> On 9/3/2025 9:28 AM, David Marchand wrote:
>>> The VFIO headers have a number of issues:
>>> - showing to the world a lot of internal considerations,
>>> - defining macros with the VFIO_ namespace (confusing, and a source of
>>>     conflicts with the VFIO official uAPI),
>>> - wrapping around VFIO uAPI in case the kernel headers do not contain the
>>>     expected API (putting the burden on DPDK developers to find the right
>>>     way to detect the presence of a VFIO feature),
>>> - (somehow related to the previous point) supporting old version of the
>>>     Linux kernel while DPDK now requires a v5.4 Linux kernel at least,
>>>
>>> This series proposes to cleanup those headers by hiding as much as
>>> possible internal macros and structures, then removing the explicit
>>> inclusion of linux/vfio.h from rte_vfio.h (pushing this inclusion to the
>>> application which may want to do some funny stuff with VFIO and should
>>> already include this header on its own) and finally importing the VFIO
>>> uAPI header from Linux v6.15 for internal consumption by DPDK
>>> components.
>>>
>>>
>>
>> I've been working on something like this myself, so it'll be interesting
>> to compare notes! I too found that refactoring VFIO is a nightmare due
>> to how much stuff is exposed to external headers.
> 
> Oh cool.
> 
> A v2 is neeed, as this series breaks FreeBSD compilation.
> I'll wait for comments before sending.
> 
> 

Feel free to submit v2 at your own pace, as it might take a few days 
before I can get to review this properly. I must say including uAPI in 
DPDK is not something I thought of as I would've considered this to be a 
very bold step, but it actually fixes a lot of problems in a really neat 
way, so I like this idea.

-- 
Thanks,
Anatoly
