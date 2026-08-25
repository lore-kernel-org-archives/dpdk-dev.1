Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0946AC61DB9
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Aug 2026 13:39:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2E8B84013F;
	Tue, 25 Aug 2026 15:39:15 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id A7C44400D7
 for <dev@dpdk.org>; Tue, 25 Aug 2026 15:39:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787665153; x=1819201153;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=BxZzgmXFL4ZDgA+PRuKxVJKjJ/wa25SF1QLpE8CfALQ=;
 b=XNcwwYzDbFOLF9mVamWPNp4vBd8Vg1TkG33aNC/ZIAP2ahiG7gwllNqm
 CMu0GyldKS778u7/kuCvT6OaMn3QzhC9tsizH0lzA5uguCPzgY/qFbU6J
 3DzwDgpC1fuNLqh35vvBdVkunhuHshtwz+mYa7RRGDBjGzGazcDYeZBR2
 1qq44CpOSQpJZzzgEnhMfeoEpSzRQajsiE/xfYtXHgY9mnJoos65INKjv
 1gvZyrBy8iQQp4QM94bR/4GQq6TiQBqbgKzxTqV/dE4HuH3/TV7g8/Uos
 apy+qs08THAyDPQ6ISfWjXN03Sqma+kBoDQR9O97r4tXF8bCPu92MFNzW Q==;
X-CSE-ConnectionGUID: DTkb27XkSaiRBKJKLwlM6g==
X-CSE-MsgGUID: P6fsT0+8QN2Co9CBz30Lxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="99477929"
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; d="scan'208";a="99477929"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2026 06:39:09 -0700
X-CSE-ConnectionGUID: 4ysRn2yFTaWvgNIDrTG9kQ==
X-CSE-MsgGUID: DnHUJnnxRomoly+RLMFBKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; d="scan'208";a="290821443"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2026 06:39:07 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 25 Aug 2026 06:39:06 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 25 Aug 2026 06:39:06 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.36) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 25 Aug 2026 06:39:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EMFRJT5c+uMGRqx5XqDq7RJXQJhjt/wXzzgWrv8nNOqXVZBlGrUt1m8JX0yzLBH6sShqxkY4eAxJyPbgFx5Xwm+8igaajqDnbR6p452SrpNd4k/6sNj7UV7c1BzJjIXhysKXadSclx6/PPDamFFkmS88aYQdqZ3Do2Zyv7GKLTGSiRC/yMjAVzHotJLPKc5YDkSpsOewHny242W91ymFejbBEG9MPwuqm3q3l3cQmtNKXt7k4qJJ3rE2rGyvcJCeEtp93eOnIIylJIw0z3RokanRrEHJPsUr5Uj088kVLjqLccooIQyVyqRnNJmnPuJXRzxgsVlwMIQmln9U/UZ3Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a28BBLrWAam9bUwMYUT8gGvuGMn8lP6Tp6K3hz94os8=;
 b=WTkCg3oKw+sA8GJrmLaQQ20M1GVeTAG5HFlCK9l/jjIMLoi28VoTCoQrXmmjlQbI3J/6lVu61sJkOA3ADW0aOAFNRr1hnw9vXhFqL1LY3odl8aVC+voztbastz3AUm8YWAdZEJPrN5nrerrKE8EGsHdHVFJ/GDxEMtFXENfles3D/2PZCn7JfZICfYr73wqbxCY/nfDZaWf4vsSpd26NathlG+lJblS5d/M5gbjtqQyu+T2z1+V+0Ql86G4BZTjwNRrJi+mcBu29RDTmQM40b6cc8SfIxhHdIH2Tqfmz50yZBYq61RtCgfoEqLgoQ4wH1xRz+3RVWFdkdqIV9PyeVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6502.namprd11.prod.outlook.com (2603:10b6:8:89::7) by
 PH0PR11MB4853.namprd11.prod.outlook.com (2603:10b6:510:40::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.7; Tue, 25 Aug 2026 13:39:03 +0000
Received: from DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4]) by DM4PR11MB6502.namprd11.prod.outlook.com
 ([fe80::d2df:4650:72ad:47d4%3]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 13:39:02 +0000
Message-ID: <50f40e74-0c64-4136-b5cb-cd72ce466323@intel.com>
Date: Tue, 25 Aug 2026 15:38:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] remove non-base files from base folders
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
References: <20260814153755.940302-1-bruce.richardson@intel.com>
From: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Content-Language: en-US
In-Reply-To: <20260814153755.940302-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PAZP264CA0130.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1f8::20) To DM4PR11MB6502.namprd11.prod.outlook.com
 (2603:10b6:8:89::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6502:EE_|PH0PR11MB4853:EE_
X-MS-Office365-Filtering-Correlation-Id: f285edf6-f6e7-40ee-5733-08df02ae39b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: q1zdAjZnvbdMf852ljhXYu0VTQWeKjJF4O3vSZ8sLmw+QSjZzSD23JSeslgJeL7iq9kmVP/GNROegm3CGANyA3Uo0v4dsiiSSA0qdjMN88mp/dQ+Csymj9wZihXIfxi+0H1ea2y+NJTCFS6yT/RXFTnJU8wA21McsZOFmWuXD8/K7LHz/1j3tMZZJS28auniviQesgmpEprJ7pINfmypYxmkSYsWHe1e2ugZ/odLMiaXid6WOh38Kj992UAnygP1EOzqOXUgX6UZU4M+aC3byH10Ny0ZYJcnPcJYAHHgl/8MZpa9KHDFzDckOLa+6t69u63pqdxI/KEGmh7BfE4Qct8tyR3z8yaXDYK+afxpAgp8bzna+S20iqREtfm83oa6NKRDR1jQSXB3cJ15SAKjyrq+AlilXgfagINH0AZF6kwxXglxBECrLvh2Zr7f0RM/3CveSFAHqd3slL2pDuqC80EEIrRxSC5rPHBvHmGAZdKfk0wz1hnsp7C8i5gqk3evMmfyZIW+meIgOhGlMnpDdE6zxKci3zO/u8dUacSQQlAczQWXLh9SyfqkzLytOIW4dOtdrnCIQoecGOO0JYFhNLFA5DD9glG2uOSckontZewZBmPWElw5e8hdjavjF5XM41Kg2VyiZ0gpTUJJyGA2a0MjKhmwX78az/KXeFJ2Og0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6502.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejlZYmptZGl2UW55NzdrZUNPZXc0bnphMkY3TEQyRVdIUVBINnFYekUyR1N2?=
 =?utf-8?B?elBnU0I1cmFwRGkvRkFVQUZGdEF4S3J0QTZHajJTd2RsSWd0NGQrcjN6MlQz?=
 =?utf-8?B?NENEczNrU3ZYMWZsd1oySGtIeVVWS2M4SG0rNnk5aFNpaTZ5T3h3d3Ntb3R5?=
 =?utf-8?B?dytLL2RtZ0toNVdiQmx3d3UvSFdBRWtTZVE5Tmo3ZDVJR2Nzc1RzWmw5a2dE?=
 =?utf-8?B?ZFBydkwxMFpkb2o2R1dsU040M0VKMGtvVUhkS0kzVkRza1dtcHBsaDg1emxK?=
 =?utf-8?B?V3hMcXBIbTE3QTVzYmZWd1FmZXBuaTZZNk83TmtCUUpsazRvVkxHdmQ3SGNG?=
 =?utf-8?B?OWhHR1A1Wm9tUDhpTmdJQXgrL3RXNUV1UCt3TCtGY1EwV3h0bkhmTVRuWmJK?=
 =?utf-8?B?T1VyaTVMUXlzVWloS3NDeU1lZHY0UTd5aXRidzVNNUJJcVRoKzd1MHZ1WXRP?=
 =?utf-8?B?NmlDWVBrT0w5eVA3ZlgxRWJ0QlpwY2pUNXRvYXFwZk5GV1c4a1JJbWxlbGl0?=
 =?utf-8?B?dEI0ak03SkUwdkpqaUVRZkI4cG15WHl1R0xreUZjUU5vT0dFVjFtR2IxcTBs?=
 =?utf-8?B?R2syRDBFY1hKbXpmRVM5Rks2WExkbXZCOGxqcllwMnRCVkxrR3IxaVpHRFJD?=
 =?utf-8?B?SGxnTkkzQ0I5N0dnR09BNE5pSUw1ZjB1VU56Z2k0akpoZ1pOdmtEekU2b0Nx?=
 =?utf-8?B?cnE1WWVPVGZheXRUQ2lYQ0lvYW1HR2hqTW5RWmcyMUNCN1ZsNENIeWxFSWtZ?=
 =?utf-8?B?K3NTbXNMVDE3ZnF3SFR6OWpWR3A0cW9WVEt2RW42Zk1TdTFobnpWcXFnMU83?=
 =?utf-8?B?K2oyVURCaVR1aEtra25DM3hadzV0d2ZDWnpSTm9sV2dBOGFuUmhzc3U2MWs0?=
 =?utf-8?B?dERBNnlmcUxTL2c1bG9XRVBvMy9Qc010S2ZUalA5YVYwdzY0NG1udnpCa0Ev?=
 =?utf-8?B?TWNCLzJRME0rUHdBV0lKM0xqYnkrZkljdVZJanpIcDJqTC9OTStJQ2tRVG85?=
 =?utf-8?B?N2FmR2RqR2lUL1pJVmRVV2pDbEtUYnFMUkJVa3JSQlZmZ0NsVTFLUlpCd3Rj?=
 =?utf-8?B?R1F6dS9rNHJaZzE2MDNFWFBxUTVMWDFFOTBSMjNIK2ROUlZ1RGJNSGhXemlS?=
 =?utf-8?B?eTlqVi9yckJHekhCN00vSEtmL0o4TStIait5RGY3MVRBUVlnNWZ5MkY1OVlO?=
 =?utf-8?B?YXV3VEY4VjZyWVNwbjFPTHVKTDNJQmhXcFV1UlNiWDNiYysrUXpJRFFsOWU2?=
 =?utf-8?B?Uk9rZjhGcUNQZlZZak5CeUI1bGJXMGZMcHA2MWZXT3JIZ0JXcVVqNU9abG9w?=
 =?utf-8?B?ZzYvSGRyZFBoNjY1LzFjRCtyYWZCZEFWQVNPMEt3RHF0OGhUclo0bDlsNTBs?=
 =?utf-8?B?N05jQ3pINHlUOG5tbnBuYVZzRjd1WlgwbjZUcUdFMjlYYnNYMkZmNThmNDVH?=
 =?utf-8?B?dkhYcGsyYjlCMkdMcFVXa1VqblBGN25pbzJXNzBLSXNVempwakxBU3B0eDBl?=
 =?utf-8?B?VWtydk9yR1FkWkx0QXBjUENWNzdsdE5aSGgzUlFVMUdlaGY3dkgxWTNWblJ1?=
 =?utf-8?B?VTE2UWp2Ry8rYkJjM0Noa0UrcHRldnMvbG5OR2wrU0NvcmF4eWR2dGx1SVJL?=
 =?utf-8?B?QkR5Sm5Fc1JhYUlPeDBJeXZteXZiZS9ObHQwS0d5SFhXQ1JsNEllM2pKMnc2?=
 =?utf-8?B?ZWdrVjMyL3JobmgvY3kvY09BSFArcThxdkVlM0FkUmk4bEt3aVpJWk5RN2N5?=
 =?utf-8?B?U2F0aEdSNUIrSGI4YVZ1T3IySnhpVmtwNVRaWE12Y3Q5dCs5SEhzcXBCeE1N?=
 =?utf-8?B?T2ZRN2RyUmNZNjFTM0piMlp3L1JUcGVMRVllWHpTQmI3VmlVYk5ncUc4MS8w?=
 =?utf-8?B?bHBvbzJwODB5NUhQYTRaQzJpNVVIKzk5UndtRmp3dm93dFZLZjJHZXFuSXNJ?=
 =?utf-8?B?NHhEUmdQVHVOc09VODMya29QTmxnak1aSzF0Rkk4VzJVTXZpSDl6UnB3c2Nw?=
 =?utf-8?B?VEtTd3BQQ2R1ZW9TNUpENHlsdHJsM3lZQXFEWUI1L2VldEdRaDFLQW4yaGZG?=
 =?utf-8?B?N2dFWkdTcG1NUWZMdFdKN2xqZlFaTmZvMDN2clA1bHQ2MGkzcEljR3BDUThL?=
 =?utf-8?B?SGd1TGNTdjd0Wm9hTUNwR2lsMTRKS0dHemZBd1BkZExtallwT004clJWaGlN?=
 =?utf-8?B?aHMyemZwQjh0ejBtWFIxMzBDZHZQOG0xUDl3T09JYlJqdk96cHl3c3lhQXN4?=
 =?utf-8?B?SHJ2RXVidjRlWktNbHF6QUFMT05iQnlwcjI3cW5XVS9CZUUyMEYxSS93ZmlB?=
 =?utf-8?B?RzVTQVAzcldvNW43cndqZDVJNzh3dWlOMXlZM2NjbzRmb1Z2bzRWWHJpVXNz?=
 =?utf-8?Q?H80sy/ybZOtA/dho=3D?=
X-Exchange-RoutingPolicyChecked: Vs+ox8mRrBkBkjxTDchud4XFEhQnKlRq0Rz0crC2bFdYcB0ZDPBL62GnRFblM+cixLzS6OQoWHOoOgOwXYUuGEmPsjBEVGBycda9nuGjJXkCl7ow+GGLoEYKSPwutHMXZ1CiJ5znlB09GQ5OZTaluEx82Lyv6gTlWb/FYpv31Ul99dVM8sl34h5SAB5S6inAv6mrXASJgfcaAFGR6eVbIGsAxCY7OmpMDR+OpTScz7FsxugNtwUmmnmNg1c23oCkE4mFRPCtw6lUfdt4T97IZy5kYgBGe0kLFCLQNkUNx+D1gyTP2Pz+YJpPx5RQ6/z4E5eWw2z0QYmoAC4wZCe41A==
X-MS-Exchange-CrossTenant-Network-Message-Id: f285edf6-f6e7-40ee-5733-08df02ae39b2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6502.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 13:39:02.8923 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yMKn3jRbbQl/hkTa9fmBbFVHYIgdiKPWpqpxj2QwxEZZw15VhWcPlQ30/OQtAQLm16B8q+A+3WLHMwSkQKQ+qN0KFomk9Ef6UGOzNSvI7JQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4853
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

On 8/14/2026 5:37 PM, Bruce Richardson wrote:
> The base code folders for intel drivers contained the compatibility
> *_osdep.h files as well as meson.build files, both of which are
> editable via regular DPDK patches. Although the DPDK documentation
> allows this arrangement, I (for one) have always found it a little
> awkward and confusing to have editable and non-editable files mixed.
> 
> For Intel drivers only, this patchset moves osdep file out of base,
> and merges the (in most cases trivial) meson.build files from base
> into the main driver meson.build file.
> 
> After this patch we have a clean separation - any files in base,
> with no exceptions, should be updated only via snapshot update
> patchsets from Intel. All files outside base are normal DPDK files
> that can be modified by any patch.
> 

Series-acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

-- 
Thanks,
Anatoly
