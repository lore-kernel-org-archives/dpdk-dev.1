Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90289FCE07B
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 13:50:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CDE0A4026F;
	Thu, 26 Feb 2026 14:50:46 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 9C4E64021F
 for <dev@dpdk.org>; Thu, 26 Feb 2026 14:50:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772113846; x=1803649846;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=4jWl3iR3pkOqlalBcu7UylXpZWUGy+HzE8q/irIzVmI=;
 b=IiiWvLi4sOTddaivPDguQHo62t6tUZF4+OxGUuh9N/Yso9nGxdPaamO0
 7k1lwM02dsHP1YMwq9EYCuFlCy31u7f3ZrKSCTM8SjmR3rEn4a+h0AGxH
 rZpRD//+gGJdiE3ONSspyhzC0Cc7teVY5Y4ocD/obgkMK43VivoAIrmoE
 nzEcibDcpG2JMCnqAzHkyFjtaU9Z5Kb24LRRq1dPwF147WqP+uPTzo7JD
 2KPGACx/9DUqTUjyKMtJkQVtwA8wyUA67ou6L7Zn6wJYDnK574haEJN0V
 qmZ0ahLxlP24nW8WWQB1D5AACyGN2Y31cVekFCKqeQ1tx3ctSjtJNAyCG A==;
X-CSE-ConnectionGUID: u2K3lDpJQBuiP5tUqzd4EA==
X-CSE-MsgGUID: NJK8uvK+Sn+8l0g4QRm4Vw==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="84529773"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="84529773"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 05:50:44 -0800
X-CSE-ConnectionGUID: 3Ml8/7+gQCWGGy89HLZhfA==
X-CSE-MsgGUID: mbP46R1sTRO1fhrvH6BQCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="216476687"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 05:50:44 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Feb 2026 05:50:43 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 26 Feb 2026 05:50:43 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.27) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Feb 2026 05:50:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o2DRyVPadI7TXwll4Kkq5OwnCwTG9io7zSfiKBfCJIr/PNZOAUZ0zFLKZjazkk5zm2yoMI5Pt3mBUihBcmvWBGeGb+5c1ME2zh7cEPImESS34KpsOvTnyK4r8QfHw+fcoGgWgpYXxbXy+ELDzNY36JRVyg9Tq1MG+7yj6ke+u7Bm8PSd8VWf22D5yeRxPCaDy9wnxDj5s3RkTbyW7GG2ypA9iPDVvvnpxP9WVEyZ9Z8wrqY53v6Rxt3v4lScLNH1osURwdFClvpBb/RcIQA2J+vgyrx38xoQB6+0pYZRX1quMk6MjgEJ3cPJBM4KZ4OO1oHnHhv8I5PJ1VOt1Y65jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vbDyH8R7InyeVDLdmb/68BjX5QuYv8CR3rDfGBQyveg=;
 b=MsUZovK1PCPQjXLBTjif7q5rzPN2JbtAwHfX5iQuwnJLd/Yedr02D58rmcMimtNPSHYAN3r0CFcl1/l9ZW5dR2K5aRM5j2NjHsHHvRBqVgPl/8Gpl3kiwQOCXSYwIDXYtE36AcB4wZXDtkWWOBkd6hlnUEbrucfGxhMou6a3gX7fp+Y2yg5yc56ejPjiUuOD7ER3qqhOPS1klFAN75MO4JWZOGiJ7iPd8vwIkqM8hoHM+XXzNafzpBNPfJhgAniCPSHdihj/l1S70eXxwJ6oY3k2LtDcUj6OMlojgJVGJWmwmOsTKkk7nwt9UjNFN6BeTbCK0ti6wZVqxLPGqFGHHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 DM3PPF529E923C8.namprd11.prod.outlook.com (2603:10b6:f:fc00::f22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Thu, 26 Feb
 2026 13:50:42 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.20.9654.014; Thu, 26 Feb 2026
 13:50:41 +0000
Message-ID: <a731f236-c9ad-44d8-a2f0-2cbd53fdb783@intel.com>
Date: Thu, 26 Feb 2026 14:50:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/18] Support VFIO cdev API in DPDK
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
References: <cover.1761669438.git.anatoly.burakov@intel.com>
 <cover.1763719706.git.anatoly.burakov@intel.com>
 <20260113151630.5381bef2@phoenix.local>
Content-Language: en-US
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
In-Reply-To: <20260113151630.5381bef2@phoenix.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZP191CA0015.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f9::14) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|DM3PPF529E923C8:EE_
X-MS-Office365-Filtering-Correlation-Id: 583228ae-d671-40d3-b04b-08de753e0804
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: tlks7g81I9tg4QqJoRSLzhsK/2VyVvZAvOQLajJWsDrJlqRZvP/QKo3H9HlAsfx2hrVahFS8TFAFPdPvzeDE/qNh2b/41DB0TfPU45ZKdoAxWg5vqhcbrcsw+LSDXqH2KIfENjSqCjEaDjvMv3B2XUflY+VvZkhDp+s1Qkw3rnfOe26pUsEmz4wqeHCLVrp+LFydCv59lqXKIkxol4vmYSEuLZ69XHEaXF1zS5RE2WU4GfOWvvOSEU/cu5L7mE1zP/I57lsXPbhZJpzLdyN1wU7BLU5a9zp1I9xaHAG8d6W27Tvy+p67S4JVkocOsqMIYtXDinQnF8xImxBKcTVxdAH40ppLfScXnXGFPHKqhpXXJPO4vutsKgnnRcc9idZtv9N+wNRZE+OcuRTIJV0O/TghYliAkw/zFITQ/gl9SbPGyoTr928Hm1hDFWNVM1VqHCRGMcsfb02ge7McwYsSh56mgf/CAPnur/YP1BC225HAA0FvFO14nNPaE/H0CjzuUhxDG4efkazM2xaK68Zks70fbJTJZBb670+Fd691uCZyrFDT2IZabQIIuOUQhNkHkd17TWmasf/Y1/M57zGe8XVYJJIhGrZRK6WL7LarnMnmgIcpSg/4r6pXSctqnNDgL+BXy9niXlMeheGKnTx4AuO8GYTW+xszrw5jlK7LZnFRMn+kLlZbdKjktArFKpvH17VC03cqALbD4+I6yohvZLdF4D7j8+yqjG7vukG5ubQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVRoR1RMWG9pMlFXOUIzcU5PcnRXQ2I4NGdHSk5TdTc3Q1liaXhSdTl5ZE9o?=
 =?utf-8?B?czdjYWVqYUVVdjJqMTkwZUNaVHVoaDE5V28xVlBvNWZRY21aTythNm1pK3N2?=
 =?utf-8?B?ZHliSmFRZEsva09KMDFsT0xTNVFWQ1hoOTFsRGRvSFlBNnh3cFE4cDI1a0dF?=
 =?utf-8?B?MktZVWc1dXh2NnNsa21tbWRMQlV1Sjc1WWpDYlYwNUt1T25oUDh3Wk4vNHls?=
 =?utf-8?B?VlN4bStNRXpLdGZCc2lJOThyazc3cnA1YWd1SnBQYjNpZ2NyemM2bEFjcmc5?=
 =?utf-8?B?dFVGbjdpOFd5YmlJVFBweEZnaGlmTEhkSEphNnJiUEtBM2xocEJubnMwY28x?=
 =?utf-8?B?azNTRmllVlI2RlY1YjJKdjR6Z1d5WkFZQkt5R2lORitsUmxLN2FIcXlGZ214?=
 =?utf-8?B?b1RnTkdkZkFUL25HVnNDNm9ReUhVdzFQWEtWdDhvazNaVkdHeENzTHFyeU9t?=
 =?utf-8?B?aGZXMk9WODlhdkVMQklXZ3RZeTAwMjRZWS9OR3pWSVpKMGZ0bVQwcUlpL0FO?=
 =?utf-8?B?MVpOekVKa1Vtam1ZSWRTU0FNc3BQUnJhN1huMklBa04wSmNWMFRnQjhJR0VW?=
 =?utf-8?B?ajdGRUNaQ2hzdmVBMk1VUWwxNnhtdTZVb2dtK0kxamhvWmxMK3FzQ0Z3cy9s?=
 =?utf-8?B?MVVlLy9EaGJGZ0lya1d2RTVMVm53WGVVViswRmNTMTJ4bWFqYU9XTWRwSTBP?=
 =?utf-8?B?OC9RSkJoY3BlWHZVdkY4WDljeFo4SFRsaWlmN2g1LzZDcnpPKzZreWRzdHlO?=
 =?utf-8?B?V3IyQm9jUmdnS0hWQ0hDWFZhTkFmWHBrdFliVStQcDRXaWZIMFd3WjhrR3l2?=
 =?utf-8?B?R01QdjRoaU5hUStFMmFrRHh3d2t4Y2xpOC9yNVlZZTVOTjN2SnNLYkhXSlFq?=
 =?utf-8?B?aXk5cm9vVFo5djA4ckp1ajVzbld0V0ZjSG5VM3dhZjlwQVlDQ1d1bmQxQ3Nv?=
 =?utf-8?B?MTl5ZitvTEVtRU14Mmk3dC9xRi8vNU9MUGRtQUUwdEJKSjhDOXBQMzJscDY1?=
 =?utf-8?B?dWl2NVBiM3d1MzE3M2tydFVjUWh0MzEwZ3FwK3Y0QS9KcVV2ajlpMjJFNnQw?=
 =?utf-8?B?R0E0RXRwa0lUVDhqaHlkNEZtVk9QdzJESFl6aGtCTmtwYWxYc09hNmczcERF?=
 =?utf-8?B?YUU3YURxWHRCdS9mYVNzTWZMOS96VzNBTTFoQnlEc0xYTjVtaUhIVDEvZmNz?=
 =?utf-8?B?UmlScGx2S2ZvaFNaNkRUR2xweU5RQUNGaHM0Skc4dHFBNnh2Vzc5L0x4aXhm?=
 =?utf-8?B?eXEzeFpkMHhPNVBuS0pCSFpsUzcyNXF2MDJPazNJZ1Y2d0FPWXpxVWJWME14?=
 =?utf-8?B?KzBnb2ZDVmdnenN6NDN2NG1aM3BnM09RSTF6amx6QmplakdvQ2JXMk4zZnox?=
 =?utf-8?B?UHZKb3BOSkE2b3hnSG90b0RyUFJ1TjRZWmtlcUluckFhbFllT2FjTE1HbnpU?=
 =?utf-8?B?dTJXWWtjQ0RPRXlYbUlQMThtdGx0alQ3dDUvZlUzTTZiME50NkRCYW1LdDgy?=
 =?utf-8?B?Q2tGRENoaUtUNU1yUmhjY0tjRzJBOE1POEVWWGRrNWVuVXVkYThDcE9DZU5R?=
 =?utf-8?B?ZmR5cndOTHp0R1lhNkxQSWZtN0pxanc2QTJzN1RnQkJOdDhMMk9abGM5S295?=
 =?utf-8?B?eTNrY1dHWWhkUjRIOTc0dVZaOE8venpySEVHdWhlMXpROUw2djd4ZDdyUDhW?=
 =?utf-8?B?WmFmSi9QbXJkTDl0bW5rWjN5VFU4eDlnTm15QmQ5Q3pJbHFHQkViWTlYUC9a?=
 =?utf-8?B?WmxHV3ZIbEV3b0I3WHNJM2VzY241NWE3TCs3OG9maTRxNjNnTU5xaVkyMXRR?=
 =?utf-8?B?RjhHZlNJVERIN2dNdGNpZCtZSWhoMXExSXErb1RuZisyaW1Cb1ZJeTdiN2pV?=
 =?utf-8?B?SUNmYmRWUm1hMVpWV3JDK1AwcWhNMWpuMHdDVVhSK3FQN1hZTlBiMVBvMlNl?=
 =?utf-8?B?NXRBVXlXUlgvQ21UVGJ5ZlVBb0xCVG1wVnZEM1N4Q3B5c3VKYzFXMVdya0Zl?=
 =?utf-8?B?OHg4bmRRNVdxWTBjUStSeldWTGNoRGYxNXpEOUp3RjJoSTFacFZJOUpwK1dY?=
 =?utf-8?B?MHhhNkdhbkdTREJCNVRUMFFEUGljcU53ZjUycDVpYUxyMDNpOXhJV2hXM2kx?=
 =?utf-8?B?TXN2TE8rM2VsWXhZVVZ4ZS9NMWhpUklCeXZ4TXA0OE5QeUdqYjZ3MHJzRm1V?=
 =?utf-8?B?Q3ZSNEMxWnltZ3VJZ2lRY2x3TldPY21PRDA5SjBybFFOQUxFa2luZnNleUhU?=
 =?utf-8?B?VDJIV2oxb3hwUHFtNmFWNjUxbkxFYVJ1aDRlR1N1T3VpZEhmdUFBUW41T2JS?=
 =?utf-8?B?bVJ0VldHUWFqVS80MGtoUjcyQUdia08xVG9SSUtFSVhNQ056UEo4Z1B5dTYz?=
 =?utf-8?Q?f1q+3DlflS0RFt7U=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 583228ae-d671-40d3-b04b-08de753e0804
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 13:50:41.8668 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: myoPAGAwYr2zWyr6SMHY5pYmXbzdWhATxrl5uGbYaEn98g3dAkBVXWvWiTzDW73CLozB2qS2sTBIy70ZFJIPvl60lT/J6mDRHUwqxuVbXlA=
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

On 1/14/2026 12:16 AM, Stephen Hemminger wrote:
> On Fri, 21 Nov 2025 10:08:45 +0000
> Anatoly Burakov <anatoly.burakov@intel.com> wrote:
> 

> 
> Since this is a big patch and hard to see everything, ran the patch
> series through AI with the current AGENTS.md guideline.
> Agree that a release note is needed.

This is breaking ABI so it can't be integrated before 26.11, and we 
don't have a release notes for that yet.

-- 
Thanks,
Anatoly
