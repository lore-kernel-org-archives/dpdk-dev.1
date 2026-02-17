Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B17E909DD
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 16:59:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B83D40261;
	Tue, 17 Feb 2026 17:59:29 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id A43FA400EF
 for <dev@dpdk.org>; Tue, 17 Feb 2026 17:59:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771347567; x=1802883567;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=B+zL89rLxxzDmiwn24E2kN631UFCWiZIyc5Hm1jfLjQ=;
 b=lKB6YCnx6Q3Syh21aXTb+V+81FcthJWuoZaWdEbEqXGwqYyV5WQ+H/c9
 i7BDgC4Y/voAu0TV3Wc/pItTTsKF9+yU8y3Rq6P+sm6eYxAfhoQneE70a
 iB+K2CcTa62vY2GUT+HqS7zODRhji/Ebq8F/F9TVMQZ/mAfy92ma/yqFV
 O7ZM/YV0aBwVAlXPav+xCKXm2eT62ETyAa5DHWy7v2DCxnbNeydKNOC4J
 Jbd1qcCyX73KhXxg7UnmmpZOgDFotm6guSJiAnZiCaeknY1pATZ7NkM5g
 dzpMrD1o2/qAMeB+VURZ0zRnq27FIspOZ3NvLridGqdCKnU08f2dulOek w==;
X-CSE-ConnectionGUID: mLNLi8LrQmORLfBv1DMjvg==
X-CSE-MsgGUID: JYN91sFbTX66AnPBBaQy8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11704"; a="72488767"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; d="scan'208";a="72488767"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2026 08:59:26 -0800
X-CSE-ConnectionGUID: KyKM/qKcQ1eWEr/MqaFvkA==
X-CSE-MsgGUID: a8azIpHkSUCNfUDiufRn4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; d="scan'208";a="244526029"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2026 08:59:25 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 17 Feb 2026 08:59:25 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 17 Feb 2026 08:59:25 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.71) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 17 Feb 2026 08:59:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A6ecykFP0tvjgsVQhvzdni/whwI86jEMU9BPWaBASL0Z0DiRyMJEUv3VCxLpKjLjVZ+eEUWqxloC2UskxX+PMYG+uBWo3V1Mh2YwcFoLV3zViDytH/RjewT/A1G5F04K18GEfCu1w9l8t/spffiVRmylnzN6SMbSF5N3GatsueNOrT4nA4/Mr7gWH1+4MENFUbY2qmbr8WYwE4wpKTzLHo6YVv4o8ZuIiLLVcpBhq1n4ZxdKDDi4tHPZ+iLEQ+HG37Fz1Q8NilGpdQN2uV+EL/Q+mYvfelx9CK7UoPj1foF0FgQatkGRAtEC4h2TgMtICuyeinSOdBXFoZvThns26g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=svRPu96iE0a9R7uORacRCCFQFwXn1XaFZC/Klz2rkXI=;
 b=XPegQx3taFBq6nuo3k5Q/pH1r0TAArQfjeIIjmb6QgG7FhGbgyCYdWrg+sdY45U+DTUBZSYNnShPZsV95t4a/YYJvPnMakMAYkFUOUwaGBtoaeveGC89Ajco/DWoBeXITVNVJFWxR7sFfa3xvMVG79yzsb7pgKQ2REkosqTbt35yJNM3B3m4E35udFfDQcm6afdh/UOPwhheI2J0hEariB3llJgNPnTPBp3e1soIlKPBElZvfB0LdbPOjWG/MmkhvZQsgGncFYTKO1O1e+hH8U7oHIAqjo29GHDzUVkR2YUlDlxs38rym6jlyYpY/InmDv5jQ8Qmhy7NYzWzIaphXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16)
 by SJ5PPF867D7FF5E.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::83d) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Tue, 17 Feb
 2026 16:59:18 +0000
Received: from IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2]) by IA4PR11MB9204.namprd11.prod.outlook.com
 ([fe80::8560:b65c:231a:64a2%5]) with mapi id 15.20.9564.010; Tue, 17 Feb 2026
 16:59:18 +0000
Message-ID: <74e92a21-ecf9-4aeb-a0ca-e96cc1398796@intel.com>
Date: Tue, 17 Feb 2026 16:59:15 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/27] net/ixgbe: split security and ntuple filters
To: Anatoly Burakov <anatoly.burakov@intel.com>, <dev@dpdk.org>
References: <5aa1fb8b8ed501b2a1c21acb8ea6b504952fc390.1771330391.git.anatoly.burakov@intel.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <5aa1fb8b8ed501b2a1c21acb8ea6b504952fc390.1771330391.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0239.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::28) To IA4PR11MB9204.namprd11.prod.outlook.com
 (2603:10b6:208:56d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9204:EE_|SJ5PPF867D7FF5E:EE_
X-MS-Office365-Filtering-Correlation-Id: 41a91103-19c4-4bd9-7333-08de6e45e39a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UXV0RVJ5YlpDdmtNSDJaUXF1MytkTGhFT3FOb3Nta2hRM0pFZXdWK251aWdw?=
 =?utf-8?B?ZkNTanNIMzk4L2J5Z1dEcjlxNDdVdm5LWXZ4OGJCaVhHZDNKU2xIb2d0N0hQ?=
 =?utf-8?B?VTYxYitVUTJSdXNVa2pIZWpleEkvaHA5bTNJdFJISlhOUUtPWkVyVWNJWUdu?=
 =?utf-8?B?Kzg3bDdVMHgzYWZ3M0x2VDNJL05xckdwTEd0Ri8zM1puaHlWa0V4Ny9jcTlQ?=
 =?utf-8?B?REdnK0N3RXowV2NDZVZDQ1FZeXFVZ1dnOGhWL210QmJ5NUdwVnpBaERsbmEx?=
 =?utf-8?B?bnNsQXBxRFhxNFZQTDdQVHR4UnFQaG5CWGNXMVNSb09wRGdkZ29EdFNTOGov?=
 =?utf-8?B?WGMxVCsrUzJ0blBBaXpPcm9xNHVPaC9ycU1CdEVzbVp1QmQ0bjBsWHJmNTJH?=
 =?utf-8?B?ZmdibldUMHNvZFJuZkJWSzRoa3Z1bzBNSGVORnFNcnJna2JEZGg5L3JzaFJy?=
 =?utf-8?B?RnJmYU04TXdQaGdaSTFTd1hJUWEydVNRblZoM2kxb3lLV1ZxaHN0eWQwTUZZ?=
 =?utf-8?B?SzUyYXVUMGhaVzQyK0JkK1ZmY0ZhbkdmQzlBQ29pcE1qM0NuMDFDQVVmcmxu?=
 =?utf-8?B?ZFZRaGlwL0UxZFpyNUYrU0lpb1kwelBqenlwTVZLZ2JrSmNYZkFibDlCRzJr?=
 =?utf-8?B?bWh3RVZZbmhCbWZ6TmQ3SHBrU1FDRm44R1JWbVdtY2ZTQ1AyKzZNWHV5TFRv?=
 =?utf-8?B?cERPQnd4M1ZVcUlWWXJxYjhzSWtGU0dIZDhpUlMxK3ZDb0I1RGpsUFdZU290?=
 =?utf-8?B?cTNqNEQ2UnR5US92aURqbVVNY1lYZHRoM3NXSVFWb2c5ZVhtbzdxMEdTVTJs?=
 =?utf-8?B?UUhIeDFpc1Y5VisrS21Td0kxYmtQV3QvOURKcFdXSThjSUo1YWJnSHRzWDd0?=
 =?utf-8?B?cGFrbkJubUpJa2pVT2RoU2ViaTR6dFd2WmIvMmx3a0NVQk53NXdqMlovNzJo?=
 =?utf-8?B?MkhHZXlKK3c3NFNHc3haY0E1NGhZY2NmOVBkVVNybU4rNC9JLzBWc3RkcGxN?=
 =?utf-8?B?U1U2djRiVHlYYTlMM0RtUFBmM3g2NDVnY05zdjdYNjQ0end3eDlBWk15ZHgv?=
 =?utf-8?B?aktNcWZrUUZqakdIQ1dub1dNbVUyaU1KYjhZeHFSWVRpbFl1SEVmcHgwU1hO?=
 =?utf-8?B?K0ZaZDZvVmxWR0M5S0dKY3UxanZvOGpYQWVBOFRoUHdHZHJVNERieUl4dS8w?=
 =?utf-8?B?UU1yUTJCQ1BSbTJCaHRUUlN3RHNBL0h1T0lMVTNsSjlFTityc0dHS3M1SjFE?=
 =?utf-8?B?ZDVkbTU2Z2VnQzBUTXNzZzhnc2RtRzVLOHBuanpReWIrdjFvVWpScVphTzgr?=
 =?utf-8?B?d3VpNzhCWGRKSU0yWGo3NXkzcmdXajhpMnB5RHNvM1Q1c0ZZNkdTRmwra0Jw?=
 =?utf-8?B?bGRHTnM0VklQbFZxcmI5NCtUbk5VQytvNENjdlZMTlk5dUpJYTVOdkZuY0hm?=
 =?utf-8?B?a0VWSWhObkJ2WmZoNk9hUzZwYllUZWdYd3Z1cHZwKzRTZ3dSSnFOZkJDdFJG?=
 =?utf-8?B?WWVIRjl5My9XZExic2xsSEx4LzVqSWpZSjhvcHg0aU5uaEZBMTIvaHJUeXJE?=
 =?utf-8?B?ZWNOUDRGSGpYL09wc1JvRUZubGJkcC91QVBFUlR5MHIvYmFXT0NQdEpHYUIx?=
 =?utf-8?B?SW5raS9pUHExQ1RFck1ldnpjRXc4dGdoTGpkUmtpTGx5MWlEUU5CRmF6b0xy?=
 =?utf-8?B?ZVRpckR4TUlSSFROWFc3cjlWb0UxWlhrbFVyWTZlVHpHSGdCaE9QTjlITzY5?=
 =?utf-8?B?Zm13VkYycnhnMzI3ZlM2Sk9kM0NRd2ZtaTU2RWsxU3p2UjNndy9ic1p5NjdF?=
 =?utf-8?B?VzRHbjQ1OEt0aTBmQkRBbUk3TzJkTWJwdjkyVjBZT2lYYWhDN3VGNGtJdGk3?=
 =?utf-8?B?SmUxNHYzdmUveDlTMFVCcktMcTRMKzFJMkRoK3VLaHNFSmFFL1NXVDE4L1Fz?=
 =?utf-8?Q?RK2PTDN7zFk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9204.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUlsalh2VTVsWEhXQXBaYllGbC82Y1RiL2tBNUVHZXNxUlRJa05vTzdGYmtG?=
 =?utf-8?B?ZXpYeFA3V1ZlNzJ4RmZJWjdQNVRTRDBGUTE0WFZFYW50YytodWRVYnRHK0pl?=
 =?utf-8?B?OFl6RW5obUFnTFdYblp0UExFVXFJd29YbUVZTGQyeTZwa0tCWUlPUWpSOWRW?=
 =?utf-8?B?VnJwYlJ6VmpPY2pSeVJUVERoTnJ0UkQyb3kwL3orUFlMeUppUkZXWWJpUUpI?=
 =?utf-8?B?OVRHMGhqVSt6Z2hXQzVOcHA2OGJqemtGUmpLV2VxYlcrN0IzWUZ6bGRyM2ZH?=
 =?utf-8?B?QlFaV3hUalRQa3BMT3IzQXl3eGtpbjI1UGFwQWorNkVIZ1ZvZElrZ2xaY21w?=
 =?utf-8?B?dGVrYno1WWZCMXd1MUVZUlpPVWZ4bzdRSlBKR0J6SEUyYlBkQ1o1WHFubllS?=
 =?utf-8?B?ZS9IQXFsVDNSS2xDVTNwOFlRT2Z3eXRteVc2VnozcUZ1UVlnSDdhUTdYMTUr?=
 =?utf-8?B?bm0vZFV3OXByNFprSkdZTlltWnpnV3FjdUVNODNxU1RkUDVMWjA4QzhUTmtj?=
 =?utf-8?B?RWZrbWZHcTczcjhxYW1YMWNHWmxyeGxZMXlWM2tEaFBCRzZIRkV0bWRHN1da?=
 =?utf-8?B?eXdpdG41MG85MGFvQUdqelFUUGNrYWdiekVKMjlESUJLOWEvdzYzU0FMbC9j?=
 =?utf-8?B?cTl6aHd3cmZkdGpWeVlLVWdPZEF6bHg4MXhUdWZvdVBIRXJnYSt2STZ5QSs4?=
 =?utf-8?B?dVhJSDI4UmhTTlljTHZXM3NFWm9aZEtxRUNuM0NYRjErN0ZVOEE3a3o3ZVZ0?=
 =?utf-8?B?VEUvN0huanpDcmxPYU1sTzBkcncybTlRdkxlNFU4QkVIeU1ucDhHTUVQQ1NQ?=
 =?utf-8?B?cWRlcStNZXpCYmQ2OU5GRTBxWGJRZk5ZaTZja010OEh2Vlh2cW1HSGxoSHl4?=
 =?utf-8?B?YUMybUN5WEpvNytTUVRyNTNkb1owcDJZTTdMK2RxV0haeFVkaUZPcGhYOHpj?=
 =?utf-8?B?TkZpemkyeVVlRFgzK0JWcFdrckV1WmRMRkloWmdEOU5NYXE5VU1RM1pSY21a?=
 =?utf-8?B?M2IwOUdvajR1bTN6UW1oeE0ySVNyQXRNZ0VCbDN4OEx3YXN4Y1JGK3pJeGx1?=
 =?utf-8?B?TjRSS082NFZRTGhZcmZSUVo2dktEQ3ZuVnZzRGRZU2pxL0x4ZFRvdmpDVGU5?=
 =?utf-8?B?dlkxZmZBakJZSkU4RWxpRTFWUy9URGxxYVR6M2k1dXBtU1NvQWx4d0hyVW4w?=
 =?utf-8?B?Y0ZJWG53NzBwWVVHL1JLaFJxMXlhakw2ZmcrSEw4eXVIK3NqMVE5c3FJWTU1?=
 =?utf-8?B?Zys5aDdYSnlESHJRL0Ivd0U1UWxya0FVZHpSbXQ0bld2T0N3NkY5YUx6WU1v?=
 =?utf-8?B?UmplMVIySXI5WUtmR2pnQmlPWlMwMldZbDBIMEpOV2FCQlBZM3phM3gvTW9p?=
 =?utf-8?B?bWFGSDZYSjZJN1d6Y1Vta3lwM01sUjlQK3hScFFpdFpNbjhzeTZ0T25HV2ly?=
 =?utf-8?B?cy9wY0xnbTUvK0JKeFErbklEdVRTRjBsSTRwOVhJeW5xMEVXWmEzWUNaclZQ?=
 =?utf-8?B?Z2p2M0FFNnlqT2JiUTJtNkdqQnlXSnVXdUFHWi9yMHlqTVVlY3U5d3BNSS9L?=
 =?utf-8?B?Wm1VRGZSWkNQczZoWFMvbTBHMEtQNlAzZWZHbnR6aWxLYUYwQld5RmV2Tk5u?=
 =?utf-8?B?OGp5QlR0bmIva3ErZ1BObTZ5MjhuSitHV0RZNHNQVnJ2Y3gxK2JoODZCTk5q?=
 =?utf-8?B?VU1uV29Ybi9DaGZiVnFrS0VDMzd3NjI1dDJ6T3JieTBsWjlSWU9FTFNsV05I?=
 =?utf-8?B?VzMxM3pvaFMrcGxtQzNLdWk2WUR2SWtsQ1JsV1doK1JiUFpoNys1OVJJMENq?=
 =?utf-8?B?WXRiVVlyL0RtSU5memphdGVRSXoxOExCQjQ4WjBKRVgxcXJSU1lqZmdXNFN4?=
 =?utf-8?B?NXdEd2hYNXNQZ2NWTjhFeklzZ3BYcVRsazdCYW0zcjRpaDhKUlJiREN5WXpq?=
 =?utf-8?B?V2pRMGIzaG5JYmdRNFJ5bUdSc054L3FFTURSblpFSEhzUUMzM1pIb3MrZDN1?=
 =?utf-8?B?SGMxZm5IbFVjZ1RnQm45c2hsZ3ppMUFJNWNuMUE2bVhPcEV4elpSbWdENmp2?=
 =?utf-8?B?cGhIYzhJdVlWY3lmZHVKT2l6Y0pkK215OXBuQXZmTWtBZG1Wa290MG5QU0t4?=
 =?utf-8?B?aGJYc0xIUmZ1NnFkaWRrRkh0YjBCRHhHL1prRmxvZUJVRWowM3U2SW1sWUw0?=
 =?utf-8?B?YVZCbFJRdU94b0JUU2Z3Tm8zaVl4V2pPR0djalkrcVdad1dSRjA5dmhNTXpa?=
 =?utf-8?B?Rlpra3pOeStPTk9kTHBHVXFsUVYwa3JobUJJNkwxbklydjQ2WTFhbThpZmFl?=
 =?utf-8?B?VEhNcXVzZmROVXF2UklOa3dDZFVWSWQ2OENwUndsT1ROVTBGdEwzYkF1aUxs?=
 =?utf-8?Q?1Wn9EuPEAAc44xSI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 41a91103-19c4-4bd9-7333-08de6e45e39a
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9204.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 16:59:18.5529 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f310yfoEwSBKjScUvInlyAmdkqYTXS57Y9akUdCqgPiVfbE1fUIS4AopaBDu4TGYoNkcvjp4+kGt1U4IooJAzmWGaMMhJGjGuDCamFjT484=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF867D7FF5E
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


On 2/17/2026 12:13 PM, Anatoly Burakov wrote:
> These filters are mashed together even though they almost do not share any
> code at all between each other. Separate security filter from ntuple filter
> and parse it separately.
>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>   drivers/net/intel/ixgbe/ixgbe_flow.c | 194 ++++++++++++++++-----------
>   1 file changed, 114 insertions(+), 80 deletions(-)
>
<snip>
> +
> +	/*
> +	 * we get pointer to security session from security action,
> +	 * which is const. however, we do need to act on the session, so
> +	 * either we do some kind of pointer based lookup to get session
> +	 * pointer internally (which quickly gets unwieldy for lots of
> +	 * flows case), or we simply cast away constness.
> +	 */
> +	session = RTE_CAST_PTR(struct rte_security_session *, security->security_session);
> +	return ixgbe_crypto_add_ingress_sa_from_flow(session, &spec);
nit: I'd recommend to handle error here in the same way it is handled in 
this function, i.e. if (ret) {rte_flow_error_set() ... }
apart from this
Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
> +}
> +
>   /* a specific function for ixgbe because the flags is specific */
>   static int
>   ixgbe_parse_ntuple_filter(struct rte_eth_dev *dev,
<snip>

-- 
Regards,
Vladimir

