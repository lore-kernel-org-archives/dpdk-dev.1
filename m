Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75E9606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 12:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CCUUpZih
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 31FCF40299;
	Fri, 23 Oct 2026 14:25:57 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id DC72040268
 for <dev@dpdk.org>; Fri, 23 Oct 2026 14:25:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792758357; x=1824294357;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=H98/QhWJQtybKnnPmmrUMoEI7P41o7lYUJ81CrnvnBg=;
 b=CCUUpZihjtT9WwjHLKVJjdoUKesoYiO9sZPbcRHOhlM2LwX9UYQupkQf
 Gt84cDLabjVm/XR6hQc5djdME5ARH0/rneNbuHWZOzLYKrZvZnkQzeQwY
 Wl5EqU73VDqa9ZaWKJ3L3LNm/JbufMw1lnsCG3tFiNKW46GDJ/eHKW72/
 +UiktkKzELsAMZg/z1yTS48OznmNLdQ4jjWko+KOsI+GnA9aJp04L0gTl
 2Ra8j7Z4UdIUeqVN8GeKgb4PKHYdI8p4LlMLgUHmPm553v3dD57qiFjzT
 q148gfTHs2KgkScHJDvSInbdKlKYGJMNSVMpTBB+X+4XAqWXv5T1JCjw2 Q==;
X-CSE-ConnectionGUID: Z4lKokKWRqC1+tdSzi2kAQ==
X-CSE-MsgGUID: UH713evXSE2U/nCsbPKXDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1522991"
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="1522991"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2026 05:25:56 -0700
X-CSE-ConnectionGUID: nbN/OvCETjq+5HB1kyyLTA==
X-CSE-MsgGUID: dNcPAqrOTpagJIxcNCn+rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="3571476"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2026 05:25:55 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 23 Oct 2026 05:25:54 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 23 Oct 2026 05:25:54 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.24) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 23 Oct 2026 05:25:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E00jHVMh9/crw9vnvoy9Fz/StcsOqtO19mz7Ndv4HuGQcd8imTtSx6qNme8geFCYK9+M6oxr17ZrqjVFNZtlKOlxg40TL2t/93LFhZgOgyzYFR/Z4qM/6o/iTwp+jx3xhSQ/BOW9saWvVdXaVIOXIvAJpEYt/pmmpJeYAC+3z7eAJXgiVF7Mdo7P/Ii4YCiOwFrgZ7vNpIOpDRAkmfUb5/l3u1iVz5nNj9C8w4efq+CtupJ+Y8zN/KdmuW/kyan/jfNuWSWhIAJNfWwquwocMoNprzVc2yVkxCVqBVwJplpYiSR3lw/ZcroCN8Lr146AE5Yd9LlGmWBfODKfnhdmEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jPHdXo8CC87/oz+I7zF6YfLEK81+mCcMIRYjWn6AL1Y=;
 b=sNujOSg6jgnI3AXgOQjpljSyUevlM6Tm9BBiANJBw4Xi9mn9Zf9NDdVvv2RcsT+SIh8yKMSUoiM23SR1/W5DrfYmvtm5a0diRj5RpSr2HpKY9AikHrRC97f/iee+t2WNWeZnkB4z0t94ZKZFbj2XMWzAaKXcY+BFaeg2/CrP9dlfNl10sorUdFmJTucQlvHwytZMJeg8xeaHeWGxZZwQP3n8bgpaelse1GxpinXVelaq95BGst7QPNRxQ/hDwGdfdjMvrGpRX98RdNb4zLfUDX/D29plUzmqU6cB1MqohNrsuRjf9NKNAjZO6937Mvnri2WjwerrTi5M1GO4jS5opQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 PH7PR11MB6978.namprd11.prod.outlook.com (2603:10b6:510:206::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Fri, 23 Oct
 2026 12:25:52 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%4]) with mapi id 15.21.0522.017; Fri, 23 Oct 2026
 12:25:52 +0000
Message-ID: <4ad2597d-dedf-41e2-aa72-9e839550c933@intel.com>
Date: Fri, 23 Oct 2026 14:25:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] eal/linux: fix eventfd leaks when enabling
 interrupts
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Harman Kalra <hkalra@marvell.com>, Cunming Liang
 <cunming.liang@intel.com>
References: <af76b0050fa71836d9663515f5efd66c8c910061.1792748199.git.anatoly.burakov@intel.com>
 <CAJFAV8y8OUGxGKshkO_3GKFc2GbE9a2XEZo6Cdh1QUQFS9fX2Q@mail.gmail.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <CAJFAV8y8OUGxGKshkO_3GKFc2GbE9a2XEZo6Cdh1QUQFS9fX2Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0005.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::9) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|PH7PR11MB6978:EE_
X-MS-Office365-Filtering-Correlation-Id: f69af44c-a983-4576-a412-08df3100c70d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|6133799003|18002099003|22082099003|4143699003|11063799006|261021123027099003|261009223027099003|261021121427099003|10067099003|260925021311599003|261022105027099003|56012099006|260925022911599003|260925021911599003;
X-Microsoft-Antispam-Message-Info: abBpj2bE84O/BIGRSV7UFvu/FBLeNEcrkUWf+3aSmne8YRETolKuaEnICxrW3bOHcCReDF9SaCnKSxPjWcK9I/93rRppBZss4FaXzdmg6zn8RGb5rboEGpXcEk+bu3Am+W1QMex67X3w699D6yOj71XFDOURDbhxuC8a7V5aTEHy7EmxhFHKXQjJbo3kS5/N0M1MZdZi5A4CR0mM/rMnfoE4prpB6450y8b9VGBvJ3TQyVyTuUndv73JZG/J9paXkd9N8CvOiIO+TjSMzzDuLg5R8Bq/K+g+clVdBhxBwlj35KX7SUF533FPDAVQyIvPVgtGAp1CkO+prNTaTBo5M5x3na6ufQVE1z7eR0QJ8hEd/m+u48g3PeitgIz7XrSTvxJ0oIzBiVLqDHepst/QVAiLFqPf7jyevDoTSMZm4rK3ZDChVqkfniKE69UlFPlaC7x49MAaSaY+TWkQnuPmhx/T+eNp/vTnNdGH0SmHjU3tgjYTq2c0qdiIx6mGcPnMtsHXCr15x+XANDw88kSQEZmzftPDdK1pfwshMmWG00FwIqboisoqBiodBwZXoIs1+wjhcg65vkqyI+iF/0y4EH89MY2kiCTU0Qo0JM0o0lTJxCz1XWtu1tZ4QHtV76xp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(18002099003)(22082099003)(4143699003)(11063799006)(261021123027099003)(261009223027099003)(261021121427099003)(10067099003)(260925021311599003)(261022105027099003)(56012099006)(260925022911599003)(260925021911599003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkpQTkRObElYdG91UEFpOUNQTWU5VSthNjlFSmtlbEpnUStWZ2VNVitSbk91?=
 =?utf-8?B?b081LzFOd2VUekNmV1B2RUJjZlRqelZEbHVaVVNsMWVzQ2xJbEV6ZHBRZjBY?=
 =?utf-8?B?ZDNPcHdiZE95YmRXeEFsTWc3TU9WaTZoRTIzVnY0UmNHWDJZRCtFSVB6c3pU?=
 =?utf-8?B?VXVNUERiMWltenRtZlZPVW91SDBjTnNSN3Y5Q2ZrZUhreEdWMVRpRk8zY096?=
 =?utf-8?B?c3dZSXpEakRhM1VLdW42K2VQNk42cG0xR0pnT2ZUMXBBNGJsK0F0OWN2ajl3?=
 =?utf-8?B?SG4vYjdYWVlTR0lWTm5sOUpnanY0ZnhFTy82a0pzSTNDSWZ1TmQzZ1NvTEdC?=
 =?utf-8?B?QVNLQkJyaDdZejVQcGl1SWorMVJZdFBORUpMVlBIQXBXZEQ2dHBuYmtsNFpZ?=
 =?utf-8?B?THNDOVE2L0x1ZWVXMXkranRvMXZRSVViZ2ZWNW4xSWQvMHVjZ3ZGZmt0cXNw?=
 =?utf-8?B?SkNEK0grQUE5MnVDcVRwTGVBSnRuQXlCS2tGMFliU1M4Q0cyZmhZa0hBOXdR?=
 =?utf-8?B?enZDMmNvMEErRlJ6eDQ4Vi9kdW5rQXl4YzFmdk5xdGhCSUdHYTEyOU12STFO?=
 =?utf-8?B?K2xlOVBkRW0vdk56Y3ZwcW9qTnZUUjU2djNGb3ZnKys4SEVvUGlMV2lhNVBK?=
 =?utf-8?B?dUtlRnlZQnU5WHg4SDlWZFEyKzBlNzQycWNWdXRFT0QyMjJzcE55ckg2eEx0?=
 =?utf-8?B?c3hGdjBneWM3T05Zb2I0WWxyL2hZRjBXZ052aUF6Vjdia2hZTEdYcUZGblZB?=
 =?utf-8?B?Y1dwYUh1NVZyUlVvMW1ybVdybjhXME5ubUZCUE1IWWpCOEV6VThkQVJGa1ZS?=
 =?utf-8?B?bkVGT3ZkS0xqZmJTT2s1K1ZlMTB1S3hyQTVMSnNhb0hDUDdpaVluOWh6TFNC?=
 =?utf-8?B?eTcyV0loa3dCSlV4Qno2NU1aYm9xNGNFR0UxRUFVWCtsSTdPNWZtUFp4b2JW?=
 =?utf-8?B?c2h1dkxZY0hyT3JlVDFTdGdpLzFuMnZRR3puODJXRk16ZEt1LzhaUkFaYjdT?=
 =?utf-8?B?ZVdlMFA4STBtM053OUl2K3F3K1ZNdXI5aFg4SDhhczVjRkFMRzh2K0h0aUdT?=
 =?utf-8?B?Yy9TZytucWI2SVRucU83NndBdmhWVlFFbnFMblV5TE0wSG01ZEYycjFxL1Rm?=
 =?utf-8?B?dHFpWmRuNFh0MEgzS3IvZTNYUkh6Z2U4UGZSSkxXVFNuS3RKWWRjU3pzY0ZO?=
 =?utf-8?B?eGdOb05MTWx3UFBYTjFMVHF3ZmhTUlBrbnJGdVpHYTBXSFI4ZStzVHoyZ2hx?=
 =?utf-8?B?ay92aVFNWDRVUlFpNkkwMG55QjU5RkI0WUU2aU1zQW9HdElhTFpFWTJ1Nmt2?=
 =?utf-8?B?M0Q0bGVtOG5Da0VCMjY2Ry9HQ2ZsUy91RmNrMFhJZ2VVc3VqQnpJUEtwc3l0?=
 =?utf-8?B?dFdWWDA0ZFgvajdDdXNPdERJVFN6Y0REUGt4dzc5b2k5U2pwdkNUMUZ6amt2?=
 =?utf-8?B?SHdQak5qV282UHRNQ0M0Z0R4aHBEK2w4eitVZGlabUptZmZmM0ROTHQzRUFO?=
 =?utf-8?B?SkkyOUlNU2VWRnhFbTdhdDRqZVZQOTJYbjFlRVltM0pBc1YweTVPVjRMSnp6?=
 =?utf-8?B?bk9MTWNqZFllZlp4TlBKclIvL1N4Y0JBK2RvcWJPaEY2akV5L0piL0xIenpt?=
 =?utf-8?B?ZzIrUERtM1Z6cTdTWS9Ld0M2RXhTYkxkZHdBRmd4RXVRbkhvNWt3STRDb1Bv?=
 =?utf-8?B?bHk4WVNaVnh0WXFCN2lGNzlMMXZRZy92ZjFyYlE1ekFvRUtnL1Z6SGsydFp2?=
 =?utf-8?B?Y1pxMUVlS3hzd2dXYUVGN1pTOHQramFJQ2ZrOGc1dTgzNXhsQ1JhTjdqTHNq?=
 =?utf-8?B?RkhzS2xZcEdyWitnVm94N2N2SUNmd2h6Z2k1R0YwalNmN0xKQm5ZOFluTjg3?=
 =?utf-8?B?VkRYNHJaQUFOMCtYQXNDUFhZbDJtSGV2Sy9EdVRwSldJWUMrN25UY3JBUXFv?=
 =?utf-8?B?NUNSUVJHbzY5aUhlakhFcVN6Rys0OTU1c01oRWp2STF0bWxQbDJmTVhEL1ly?=
 =?utf-8?B?VHFqTnQ1TUxwcWFuNFNhQjJIWjBmYmJHc3FDeDRlaFlZY2tvZVc1YnpZa0dC?=
 =?utf-8?B?a0pLYlZBOTlFcmZKVjhGZlRLWHdJNWtGV1VDaTJVMnVyTGRDNnQ1UGNtR2tN?=
 =?utf-8?B?blFwVXpYbnVsaTRveENwd002MHl4eEkrbmMyMzhDOGlWaDhudU5sRWYrTDNO?=
 =?utf-8?B?WFlzUUNFclI0QmRVclBCRDBuQTlSSXoyRUNDNUc5bGh6aDhNWG1hRVlRUktz?=
 =?utf-8?B?TkRJajVIUyt1aVhLQnlWNXZHWkhJZWdlc1cxQjlLSDRhblFBTFpkZm5kK1U0?=
 =?utf-8?B?Uk5KZk5NeUFQRU44UWJwWXpZOTFMcmRlSGxnMnRHU3JldHB3dHlBT2JFVFMv?=
 =?utf-8?Q?FM0asTbL9TQE9ZBw=3D?=
X-Exchange-RoutingPolicyChecked: mYX2PUH9sG4P2Oln86v3LKAh17Hvq6fWet3nf0iDx3VUP3GX2KcNMfyy6AJLXMVgOaXjPKIYnyhDIBeIsfy1k4ZXbgEUCi8WMJ8X02qD81UKJkO6K3Cdy2hg3f8shSsKq573q5jQWTPO/AyVY2F4k52+TWJZMsXqrdOyAPWix4ntIBybq1eFLfRbjCAkL6dyTjwSqyysuHSEBbEH0sOEIXHnW+O/QNG25zlMxuUKatpuy8LlnwdbhILjAZvtdxObzx3i3bWtzyGqa7hc57CWWjgPW+QlVTmS9WnI4Xzkd8w2egkbSthj0hiJv6Xjt+SAUQFG2WJ0fdBuvrzgq3G1Cw==
X-MS-Exchange-CrossTenant-Network-Message-Id: f69af44c-a983-4576-a412-08df3100c70d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 12:25:52.0790 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lQC3Te2z5V4TRG0RS/k6+Y5H/hTnOq3Jb4LgwK9f7UMlNkk9dbaroA00haFiH+x76e+FmP4cJA4IYb1hiuKUrKc+y7kTZ4pyEfci5bnGJKY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6978
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
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/23/2026 1:42 PM, David Marchand wrote:
> Hello,
> 
> On Fri, 23 Oct 2026 at 11:37, Anatoly Burakov <anatoly.burakov@intel.com> wrote:
>>
>> When enabling MSI-X eventfds, a failure after creating some descriptors
>> leaves them open. The eventfd count is recorded only after all allocations
>> succeed, so disabling eventfds cannot clean up a partial allocation.
>>
>> Calling enable again without disabling first also leaks descriptors by
>> overwriting the existing eventfd entries.
>>
>> Reject repeated MSI-X enable calls with EBUSY before modifying the handle.
>> On failure, close all eventfds created by the call, clear their entries
>> and reset the eventfd count while preserving the original error.
>>
>> Fixes: b9e0662a931d ("eal/linux: add interrupt API for drivers")
>> Cc: stable@dpdk.org
>>
>> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> 
> Good catch.
> How did you find this issue?

I didn't :D Bruce's AI review [1] caught the (somewhat confusingly 
formulated) bug, and I went on investigating.

[1] 
https://patches.dpdk.org/project/dpdk/patch/595c771fac2dda2d602c01ba171d56f3419db917.1792592724.git.anatoly.burakov@intel.com/#186792

> 
> I did not put warnings on the efd side, but maybe worth extending
> d770ee9caed0 ("interrupts: warn on leaked FDs").

Probably, yes.

> 
> One comment below.


> 
> 
>> ---
>>   lib/eal/linux/eal_interrupts.c | 39 +++++++++++++++++++++++++++-------
>>   1 file changed, 31 insertions(+), 8 deletions(-)
>>
>> diff --git a/lib/eal/linux/eal_interrupts.c b/lib/eal/linux/eal_interrupts.c
>> index 4cfaeba7fe0..ff05d649607 100644
>> --- a/lib/eal/linux/eal_interrupts.c
>> +++ b/lib/eal/linux/eal_interrupts.c
>> @@ -1570,30 +1570,43 @@ int
>>   rte_intr_efd_enable(struct rte_intr_handle *intr_handle, uint32_t nb_efd)
>>   {
>>          uint32_t i;
>> -       int fd;
>> +       int fd, ret;
>>          uint32_t n = RTE_MIN(nb_efd, (uint32_t)RTE_MAX_RXTX_INTR_VEC_ID);
>>
>>          assert(nb_efd != 0);
>>
>>          if (rte_intr_type_get(intr_handle) == RTE_INTR_HANDLE_VFIO_MSIX) {
>> +               if (rte_intr_nb_efd_get(intr_handle) != 0) {
>> +                       EAL_LOG(ERR, "Interrupt eventfds are already enabled");
>> +                       return -EBUSY;
>> +               }
>> +
>>                  for (i = 0; i < n; i++) {
>>                          fd = eventfd(0, EFD_NONBLOCK | EFD_CLOEXEC);
>>                          if (fd < 0) {
>> +                               ret = -errno;
>>                                  EAL_LOG(ERR,
>>                                          "can't setup eventfd, error %i (%s)",
>>                                          errno, strerror(errno));
>> -                               return -errno;
>> +                               goto error;
>>                          }
>>
>> -                       if (rte_intr_efds_index_set(intr_handle, i, fd))
>> -                               return -rte_errno;
>> +                       if (rte_intr_efds_index_set(intr_handle, i, fd)) {
>> +                               ret = -rte_errno;
>> +                               close(fd);
>> +                               goto error;
>> +                       }
>>                  }
>>
>> -               if (rte_intr_nb_efd_set(intr_handle, n))
>> -                       return -rte_errno;
>> +               if (rte_intr_nb_efd_set(intr_handle, n)) {
>> +                       ret = -rte_errno;
>> +                       goto error;
>> +               }
>>
>> -               if (rte_intr_max_intr_set(intr_handle, NB_OTHER_INTR + n))
>> -                       return -rte_errno;
>> +               if (rte_intr_max_intr_set(intr_handle, NB_OTHER_INTR + n)) {
>> +                       ret = -rte_errno;
>> +                       goto error;
>> +               }
>>          } else if (rte_intr_type_get(intr_handle) == RTE_INTR_HANDLE_VDEV) {
>>                  /* only check, initialization would be done in vdev driver.*/
>>                  if ((uint64_t)rte_intr_efd_counter_size_get(intr_handle) >
>> @@ -1611,6 +1624,16 @@ rte_intr_efd_enable(struct rte_intr_handle *intr_handle, uint32_t nb_efd)
>>          }
>>
>>          return 0;
>> +
>> +error:
>> +       while (i > 0) {
> 
> The i variable should have been declared only in the scope of VFIO
> type, in the first place.
> Using i here could blow up later when this error label is used for
> other interrupt types.
> 
> As mentionned in the commitlog, could we accumulate the number of
> valid efds in the vfio setup loop?
> The cleanup code here could then loop on rte_intr_nb_efd_get.

I'll see if this can be improved.

Thanks for the review!

> 
> 
>> +               i--;
>> +               close(rte_intr_efds_index_get(intr_handle, i));
>> +               rte_intr_efds_index_set(intr_handle, i, -1);
>> +       }
>> +       rte_intr_nb_efd_set(intr_handle, 0);
>> +
>> +       return ret;
>>   }
>>
>>   RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_efd_disable)
>> --
>> 2.52.0
>>
> 
> 


-- 
Thanks,
Anatoly
