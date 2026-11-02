Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C219F606B907
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Nov 2026 17:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VL+28YOL
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4AE7C402E3;
	Mon,  2 Nov 2026 18:24:03 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTPS id 626434028D
 for <dev@dpdk.org>; Mon,  2 Nov 2026 18:24:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793640242; x=1825176242;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=1i9BnRYCP5XN5gC7NUjW2WpMKWIraSgJ6ePT+NlxxQE=;
 b=VL+28YOLGRwAiB2HEz1ABI45Bl+G37i6tN/lRoFmIB5uZcn/5dhj3xt5
 qLM/cIZubm0Vap+F7/djqkhlPwRaON5LMUOkb6Gtq7d2zFyylYgYYTIcn
 jmP/sTa4aYJkTkJbi4NnmEN67Wqlz9iw5cocBl5et+tnsLZTm8Bmj79FS
 B8UUeadYqy0F+dNkqzm28z1nrRFzdCUGIe+MMjI9Imm59FRbWXLLJoY+/
 KkPcutXyruHJnpm8BluUnloJ6tUWuJD1Wdge4wOsHKKSS0AU2EOwxbOdc
 i/zYWOjY/U6RsVbex5D6hn4IaNxM3qmd9Lr+yz/V+znMG/qsX8I8iby5+ w==;
X-CSE-ConnectionGUID: R1kE9uk+QoW+TLPZDvU8TA==
X-CSE-MsgGUID: HN0b8joUSG2KZuBEaf87Ug==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2221344"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2221344"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 09:24:00 -0800
X-CSE-ConnectionGUID: SDGTnNHySmGDlG9/TeBNrQ==
X-CSE-MsgGUID: Fr2YgUIbS0W3FQBDFgKlYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6305565"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 09:23:59 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 09:23:59 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 2 Nov 2026 09:23:59 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.51) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 09:23:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cfs1MumnnEK6/P2OygiUBoqyNuijqWXo2wUTE+heyCbMJ0jlNMc3eCd86GiwqFfr7yVjjwFJgm55HaaVlb43JHxjxdef5NFCZoSZo++UPE1C+xtB4/75bnpBmH7P0/yhqXBQZgfyegMDMiIv8sAJqvvAHw52vej90/ESQUqacqPvFcydLnYQS2yLtvCA/3jB23eHYbD/IJDplM9xbT/jCuerDeqKHBjQnfD2hyKw8rPJsg+dHaEMngdoMPEqCjUWrDD4TX2SNlQsHe9ImC2bzP+u/vhdnpQTYu3Z4Mcnx6S+hQkfNJ3ujzZQhCwknGzruVqWSS8t6I2Lv6fIKz0zng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i/r1wS4yvGTTE7lJ7tuFG1BMYHBbHD8O2DQUjiOfv30=;
 b=HhHe3bcDBZScio9qsHFqt9rfFsD807pn8NMfIDCRtdoHMudZTvax4QIRyWZqIe2Ma/TnkWcD8UDGOwUH1jqg5fdDFBmpN9WzOO1EGnogv98S+XTgJ4rGq9OAeq37NqwwGW8CTt1In4LKPv3+rDEy7akq03Sp9arAakev7tNX9BuLOPTldQG1NtFxK+OSu/crRLi9xY0OM2e36sfNHlHg6ehqpu4EAHsdfy+u+HijbgQwZ2v/WilWUPI352U5U71WOCiKlIFyYgaj7IIziFNk8aPx8rV1VM1+f/TiRGWGyf0hhLt5OqJpud+4HeweEccRNkc33fr45JnMZDlr0hEbJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA4PR11MB9444.namprd11.prod.outlook.com (2603:10b6:208:563::22)
 by SA3PR11MB347531.namprd11.prod.outlook.com (2603:10b6:806:52d::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 17:23:57 +0000
Received: from IA4PR11MB9444.namprd11.prod.outlook.com
 ([fe80::8b6d:87bf:4926:f0c1]) by IA4PR11MB9444.namprd11.prod.outlook.com
 ([fe80::8b6d:87bf:4926:f0c1%5]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 17:23:57 +0000
Message-ID: <19f447a8-3ed6-46c9-80c0-39d746db6722@intel.com>
Date: Mon, 2 Nov 2026 17:23:53 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] fib: fix full table overwrite on address wraparound
To: Robert Sanford <rsanford2@gmail.com>, <dev@dpdk.org>
CC: Robert Sanford <rsanford@akamai.com>
References: <20261027001423.3028072-1-rsanford2@gmail.com>
 <20261027145405.3454251-1-rsanford2@gmail.com>
Content-Language: en-US
From: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
In-Reply-To: <20261027145405.3454251-1-rsanford2@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DB8P191CA0026.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::36) To IA4PR11MB9444.namprd11.prod.outlook.com
 (2603:10b6:208:563::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR11MB9444:EE_|SA3PR11MB347531:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a0af8ca-817c-43f9-bf03-08df3906132c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|261021121427099003|261021123027099003|261022105027099003|261022075727099003|261009223027099003|261102123227099003|261026121527099003|261028144727099003|261026140227099003|4143699003|11063799006|56012099006|10067099003|22082099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: GXN2DAM8Eiv3tc8NFv/TJ0SeJonDBGlBIeK1M7poSckc81yGaakLVzZnbEEUemiuIh1UDRCmY5T8Hj+cZ6G3pGmNoaAhEuj0rW1fZMBXbyRklq5G4dO3lCo3b8gsB6mtdxEAx+Q0LUMMsYuA0H35fD9wsqdUCPu5K48lVKtxcdLKJiENQxo9umYYmZ1ozGDPM8gYhn1OHZfgMqKUA0IcFpog+6WeZzdtxs03FiCu4F2JN9K8z2wdDM8rr0DaNC938jLoW+Fev3GV/AczgXlD483Xryaw84QTdyjMuYw42Vc/UbuuLCsA8jj1A4NxSikg0ebzpKwCGbyvq8ueRXrtrSDIxg7BJOtW1fugqIzEVryqEmbAsgqCuJTdfM4PssplwgavlsfgDSz+xS3oMSGY94OEfZsiwOtf8Qo1PIqVyN9mct2qxGdVxmg7/67TSLYIINIoOtS6jGNpOP9Pazq+IDEI7Qun5q07V2r9cU1ZxNHudJkiFRMkhizEOX/gi17LL4/TgwTpp87lM1wXRVLBpUrGHH85AC4/kCe1bqapM71Cer5xisJzsxkFjtsUdVTfkPoj0py/+z18kUYzdjoR4WN351aFzPjBJifEPNG37zyMz0xuAyPXGnOY07XDQj5gmMTYuJFlH3ECR9qtU70zWFeRg89mq+ZmN9zCCX174W4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9444.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003)(261009223027099003)(261102123227099003)(261026121527099003)(261028144727099003)(261026140227099003)(4143699003)(11063799006)(56012099006)(10067099003)(22082099003)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWc1RU5oTXhDWWIyRmVhc3kzSFBWZS9sYVNvRktqYWlVd3FhNWxSL0gyd0RI?=
 =?utf-8?B?YVpBVWsyYXd2K0ppbE5QWHRuSE5zNnluWlg2dGZrUFQ2OCtjOURNeUtubS9D?=
 =?utf-8?B?bFRsYWExamVWTGoxaFdieDJnYzZCeDFkN295NENpWFpiM2NSalYzTjh6eTV3?=
 =?utf-8?B?alMvam0xOVpxS3Yvd0tXZk90dWpXRFc1R293eCtWdm5ReXlXbDIrNTVNamV5?=
 =?utf-8?B?dXpqNm9WQU52QU8wVG5nc1R6d21laUVzN2E4bnJlTENnS0tDM1R6M092TE5U?=
 =?utf-8?B?UlczWWpDUGM2Y09BRU9vREo4V3JDa2dRbkEybmxKbDBVTGh0cXZ0OVlWWTZV?=
 =?utf-8?B?UEk5UmdGZGplUXpUNUtzWllyZ3VabFJkeThueUZyNjU5YWM5TTJsV01YRnNG?=
 =?utf-8?B?VmwzZzFmTngwOEdXRkQreHQ3U1BjWGh0Ymx3djFHZThSSC8rRUkyRW8yY1BJ?=
 =?utf-8?B?SWhreEVZaHFWMlNBa094a2xyZ1VwOURwV3M1OGxjUnc0Skk3NnlnNVFSalUr?=
 =?utf-8?B?UVdEbjdoZG00UVJoOFdtd200MXhPRlh3V0xJZlZGM0xoUlp1bWIzMkgrbFBJ?=
 =?utf-8?B?cWxGdlpFc2kzc05oVWk3eXExZkVqVDBWb3FIelZUZWorU3NVSUJoWkFPRXdB?=
 =?utf-8?B?S2I1RXEvR0V2MVhybHYydnBhd3d6VkVONmtOUWVLTUNweE9MUWQ2QjQzZS9Q?=
 =?utf-8?B?K2lrd01ON01neEZpVnBWTVRmeGdTTWx4aXovMzU3OGVrTi9OQitsZmtIN1da?=
 =?utf-8?B?TEs4b2RUL29kdEM2alFOaWw4YUpUNnJwRXhUYmp0ei9rSHNlNlNvWkY0K1RB?=
 =?utf-8?B?T3V1UEx5ZG5oM3pCb2N3WkxFRTFEK3F6R3d6YXFuSXBTTW1hRE1jZDIrYUNa?=
 =?utf-8?B?WnV0cmZib1hTajd0dVgxaXhkckVDdDlpWkRTVEREVThnSmtxTWpjSFRWSWFs?=
 =?utf-8?B?NFpjRmlqaTVENlFlaDJEWnprclcremRlSDBORVZOR3ZDaTYwRncrZ1BTcGZP?=
 =?utf-8?B?YXZ2ZjFmdFBicnZGeC9rVEJ6dXdaZzZQS1BJMTJuaDZqS0h1YUNnb0Znbk1u?=
 =?utf-8?B?TlRsNTJVdlhRL0hRQUFLWDFoR093L3BxblI1Qnl3Q1lBT1pUU0U5aEJ6bzA4?=
 =?utf-8?B?cGxFN3lRaHBMTDNxdVYrOHNvWEh1dWRvaXBoRU5hWHFlWWI3Wk11UlVuR0Z6?=
 =?utf-8?B?SXRDbmNHNWZPekVLMFFIVG9yeDVSRG4rZFgwSXRJYkk4NzQvdXhiL0pwYkd5?=
 =?utf-8?B?MTJrd2xWd1h6cWlsQysrdm5ScXFaSDZidzJldzU5dXNWZTZoYWJ2cjhEeTF2?=
 =?utf-8?B?SUpmb2k1MUMwWFF1cEt3TkpGWXZGSXRWUjF5L2F3SWFwd1FRMUM2Q0t2ZFJj?=
 =?utf-8?B?K2Q1cHh2R3ZJcTI3WjI4a3NjbGJEbXNBOWk3dy9RODd5a09vd1Y5Z1dFZlRs?=
 =?utf-8?B?eFVxY2hWYWI5SHZNTUJKRXc3Mm5Ha3Z5QnVaNDRNQ20rY0dva1lUcklaTS91?=
 =?utf-8?B?dm90Zm44SlRjWFlxTFI5eWtMUUJUenIvYlZ0QjA1YkhhMDJrU216UE5US2lk?=
 =?utf-8?B?SXRpS3Q5dVlQdUFuSEhuVUNKMGFjdnZkeDN5dERFb1JodWlwOHVZbUJmZ0dY?=
 =?utf-8?B?ZlhPamhycW8wWmNReldybm9PN0F6aE5FdTdUeFl4QXZ0bzBBUWl5a2ZZN2Mv?=
 =?utf-8?B?bnZNdzRwaXpVLzMwSjg1anlHOW9UNE90ZEk5V2RXbUVPY2x2T1R0TUZsU0pk?=
 =?utf-8?B?eHBYenV3TGcwR0thMENOeFcwblhVSHBMbS95cGYzUis4WXZFUDJqTzlKL2V5?=
 =?utf-8?B?TlZWVjA5RjM2L0xGUkwwVVk2eFpMbXd5TkVpUVRTbDNLaDhGVTBwZyt0eFo3?=
 =?utf-8?B?eTJCb0E1dHBKWW9DSEVKRThDTDkrWXc5RE1YL3NlQVhtdE9RUVVZSGtyODBr?=
 =?utf-8?B?R1cwVk1JQW9Qc1BzNGV5aWkzSkVlZzRoYnk0b0hrRkFGaDBIWFdpdVBWdklo?=
 =?utf-8?B?K0ZWUHppM2FUQ3pPTzBXOVdQZ2VzbXdkK0owSnBtZ1BONGVlYlAvUlM5d0FV?=
 =?utf-8?B?SEdxb1pRTTNxOHJTd3MzZkhFcEdiOVB3S2V2eHBGTlJOZXhsd2JxWkhnbGlY?=
 =?utf-8?B?dVpYN2FHVi9ObHhQZ213MG05ejU1TzFRQ1d2dGpNcGlLN2c5VVJrOFVWYXNz?=
 =?utf-8?B?cnQ4YUNXdGE2ZGNhclVmS2Y5OGZjd1ZBd0FkK3ZMbkJYSi9DV0dCZmJUZTNw?=
 =?utf-8?B?cVR2eTIxbS8wOGlVOGdaVWFoOWZYeGRGaDRwRXk5enVXNm1YZFJNRk05OHFZ?=
 =?utf-8?B?Y25oSXJqNXJlZmVacUJ3MEYzVXdONnhWT3hmci9kNklHMERTTHErTDNQT3do?=
 =?utf-8?Q?SGXzM32NSPz5zW6c=3D?=
X-Exchange-RoutingPolicyChecked: tU2vwBjrX7ne7L2GZoknrqfqvx+b0asVSglS5oaLFhdufKZftZdhISwLaWlHyveCxH9rRBmW1cQeBa2lVP4XTELLV+z1c8+R2m9Xq8d3V4wOnm972bQT3aIPOTOs8OhCZDOdVa7qgpUFGQZaglQi7i0oSDCYp73do/1uZyCcQYmwo8f8MhQl+QHZSq7yq1W4l2veALiYcO6pOHUsvd9ydG3yUtglHPil4bcQtWcqGT9fgj+/EqA5p0HWuYqIolC/ccPT6S09wkE5PIbrcfEzYBBnS01qaD+EkLI+eLK0vKxmUsfXt62U87zBdh/U5Ny/SklIdXRKS4kit5JH5ZVBMw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a0af8ca-817c-43f9-bf03-08df3906132c
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9444.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 17:23:56.6839 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2wqEcrU4hXUNbTmaJylho9jjGF/iBpifW21PlSDHMQowHXDv14rlJrIqt9VkZ+vZ5WjSm9w0wjtFEK5nPuAVpnj3Egq84IVmVb2L4VpwWHs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB347531
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Series-acked-by:  Vladimir Medvedkin <vladimir.medvedkin@intel.com>

On 10/27/2026 2:54 PM, Robert Sanford wrote:
> From: Robert Sanford <rsanford@akamai.com>
>
> Both FIB dataplanes can overwrite their entire lookup table when a
> prefix whose range ends at the top of the address space is added,
> deleted, or has its next hop changed, while more-specific routes cover
> its range up to that point. The call returns 0, so the corruption is
> silent.
>
> One real-world trigger is a default route coexisting with explicit /1
> routes: with 0.0.0.0/0, 0.0.0.0/1 and 128.0.0.0/1 installed, deleting
> 0.0.0.0/0 makes every lookup miss. IPv6 behaves the same with ::/0,
> ::/1 and 8000::/1.
>
> In modify_fib() (dir24_8.c) and modify_dp() (trie.c), the branch that
> skips a route starting exactly at the current left edge has no
> wraparound check, while the branch that installs a gap does. Patches 2
> and 3 add the missing check. Patches 4 and 5 add unit tests that fail
> without the fixes and pass with them.
>
> Patch 1 fixes undefined behavior in rte_rib.c that the new IPv4 test
> reaches: its bit test computes 1 << 31 on a signed int for nodes at
> depth 0. No existing test adds a depth-0 route.
>
> v2:
> - Add patch 1. The CI UBSan build reported the undefined behavior in
>    rte_rib.c when running the v1 test/fib wraparound test.
> - Patches 2-5 are unchanged from v1.
>
> Robert Sanford (5):
>    rib: fix undefined behavior in bit test
>    fib: fix full table overwrite on address wraparound
>    fib6: fix full table overwrite on address wraparound
>    test/fib: reproduce table overwrite on address wraparound
>    test/fib6: reproduce table overwrite on address wraparound
>
>   app/test/test_fib.c  |  94 +++++++++++++++++++++++++++++++++++++++
>   app/test/test_fib6.c | 103 +++++++++++++++++++++++++++++++++++++++++++
>   lib/fib/dir24_8.c    |   6 +++
>   lib/fib/trie.c       |   6 +++
>   lib/rib/rte_rib.c    |   8 ++--
>   5 files changed, 213 insertions(+), 4 deletions(-)
>
-- 
Regards,
Vladimir

