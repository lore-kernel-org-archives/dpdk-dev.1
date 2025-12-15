Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 973DED5B862
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Dec 2025 18:20:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A8C2D4029A;
	Mon, 15 Dec 2025 19:20:53 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 9434D40151
 for <dev@dpdk.org>; Mon, 15 Dec 2025 19:20:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765822852; x=1797358852;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=0veum2gokOpXuJOe0iwxph32qZVluaTfga46xrAK5+c=;
 b=mITn7n/Hrkj94KbMLjp6xvn7tb34Sy2Mzs3OFSv4UKL+vkvzOpVWj38a
 SJakUq48NXXsVZboAvhJACHKOijKYeva/i5vqUb50IswX2myrw6zcjeR7
 WjVw7WwcGuAKoo1LylRnvo48vZNd/M+zDNzknxYzXjfE7BD8vvO2G+4gY
 +Iq6xFu1tl4J1rSUzzQ7QVKMQLsid3QOw9l6cEoSEt4mNDt+ypTZ3REvw
 7zEMT0/FvZiQJdpfnn/DZG77KocelRnDZHl/M6YFRNb6ZWskGuwSJyNlL
 cAN90mDIN5b8cHppnxjW5Xku+Vz+QfH5/+fVR+vb9B6XgTijGpyzQ+Si6 w==;
X-CSE-ConnectionGUID: I3Jp51g1Rf+YArUb8t0K3Q==
X-CSE-MsgGUID: +KpPEzp2SfGMDSUmhh6iQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="71588100"
X-IronPort-AV: E=Sophos;i="6.21,151,1763452800"; d="scan'208";a="71588100"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Dec 2025 10:20:51 -0800
X-CSE-ConnectionGUID: LTJw8HghRJqFUzNJ5juWUA==
X-CSE-MsgGUID: C4fSeG5YRXCJ0HKiTchzlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,151,1763452800"; d="scan'208";a="202708408"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Dec 2025 10:20:50 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 15 Dec 2025 10:20:49 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 15 Dec 2025 10:20:49 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.30) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 15 Dec 2025 10:20:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TwnAjEapchNE0sAQP7jZkV7jiZruuS9MN/rENtL9n/lf7ItunJuvGdnUXWxB+4oVamC8tIQB8o6JvrZ9y1kBYSj0U+EtUz4hWYpbOA2Vv1oFc4qqOwlajTifXLidcTxn5rh1RkLKv8emY6mOtqvUajoo8Xd2rkDuE4ZKpa18E/qw99UzgKc/mfBUAag3eTVxR1q/h1g4IgRHjA4k1wqQ9Lm3WwqULMAYAoKomZTcu1q3PpVeAnIpAlm/vvCDLWgwaflNa4z3gFh5zEy39YxAEfN2OO8q6lQhh+ThUe1zXjtnFoXqI3pZ9geeQ9PVQYi5oML1Hgd2iY/0Odggk3KN0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBzToLc3V3LhK1b2f2XULzZ9CUKIu+K7uRJGnCydp3M=;
 b=vDHAtbIRIKwSObbRGiFyNVfH9SiE7AcVc9mGBZHXXID+DOBEVdHUSSHIVoqEMhOF8b7Nf+POoOBt+HZ/Xac6WOXxrtZ5JKSPvr9NI5IcZ85qjegAaKEHbIdji63KBgBhPx0S/uN8vR/Pm3s0ILBMZ/jw7+Wv2KuOpAPxSVWcSGg3FpmCeeRGYkUeyBwSUauOTxSZlXQu5O+chwSOKTSRtpp2tK7GSDp/J2so62egHnOIW0LhoubFmTU5iXs8oIowYFyMRyDut8OEb+l2dTag0UkFTeDLY0GI/fEK9DZoPqk1FE9UAVnVUkDrEV9FV20ih8Em3R6T16D8iuyvtiuhYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM6PR11MB4705.namprd11.prod.outlook.com (2603:10b6:5:2a9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 18:20:47 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 18:20:47 +0000
Date: Mon, 15 Dec 2025 18:20:42 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>, Praveen Shetty <praveen.shetty@intel.com>, "Vladimir
 Medvedkin" <vladimir.medvedkin@intel.com>, Anatoly Burakov
 <anatoly.burakov@intel.com>, Jingjing Wu <jingjing.wu@intel.com>
Subject: Re: [PATCH] net/intel: improve Rx descriptor ring size checks
Message-ID: <aUBReiTLkIp-M46a@bricha3-mobl1.ger.corp.intel.com>
References: <20251215173543.1707960-1-bruce.richardson@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F655E6@smartserver.smartshare.dk>
 <aUBMSa4u2Qjyy4t3@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aUBMSa4u2Qjyy4t3@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DU7PR01CA0039.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::12) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM6PR11MB4705:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d98f7bd-4058-458c-3c47-08de3c06ab6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?zQyy7VTq3VhocNMp3dZZnF4/Fqo8FYwQmst9HQTXR4JM2M5vnM9LujTf2x?=
 =?iso-8859-1?Q?xV90H/3Nax42x3/w7UJD/lpuktpMKM2jhPBmiUYkvh38qixRNyET6rVa5R?=
 =?iso-8859-1?Q?P4clhHZP4p5ufiIW6AiJo4YVgu1jcq+ub82krvFSWfUtSRfXXYzG/gJImk?=
 =?iso-8859-1?Q?cb1EqhBxEO1IrzCsTwHUM52IUOEwcBJOWlDoGKn7XorcOnKImCvQ9IK+SK?=
 =?iso-8859-1?Q?eTfLb0GY/NeCD046WF9QGFtyZ4a7+7dbYcGXvlaghuBEY6vxOAxdMpOFUF?=
 =?iso-8859-1?Q?E7ifPh0gy9xIA0bHKQcKSzLpHepCtDvrmX8nT9k+zu4wrq/HoFChBYvSmB?=
 =?iso-8859-1?Q?qpbSAm72eLhykq5V1g136wwH9g0DliLKk8JtiCVg0ks93PzL88bLqbz5IL?=
 =?iso-8859-1?Q?UdnrOmc2XNhOJGOiIyQlfLyA9z/xrGjUFnP8H7ul4m1puSYx8ghi0Mqxtb?=
 =?iso-8859-1?Q?LV81OYP6v14E/MJeoDFyNt2aLrWGB898nynonxlfz280IzLzVfawCRohFm?=
 =?iso-8859-1?Q?unxdm1RoUEGQKSGZjfdop0NwPN8/zadmm7ZUfULw3c4KlIUPdwChNtojg0?=
 =?iso-8859-1?Q?Hv8k0c7bToyZ/7WgSJ9aRuPf9djauWxKtNy56AjkKBSGthsu5ObFHA/tuy?=
 =?iso-8859-1?Q?Pcrtp7vaba0QDknCPS8ez6MeaLpJZE+mJWz54qAaxK6ONxCpA8DdEdPwxz?=
 =?iso-8859-1?Q?j8WjkXLmd2AOb8VPmEBclctY99rWSu5HIbk+EP3owm7QRnyn6r/bQjTt2+?=
 =?iso-8859-1?Q?Pbqg2r8QyYlZRB5sBcA67ZkLy4XevMmzIKU7F/sKhxPhbkdIRswxzPZBa4?=
 =?iso-8859-1?Q?J8i5yI+Vi5ogNzY0k3aJaKcRU9l/wS8uaQEg12YZpE8gfSY+0XeubjF4un?=
 =?iso-8859-1?Q?fdHLwSUa6zj4V5PJ/Ypd7BDIHPvrOemGxjkK+NIUdeRnDuHqwX2b87OWH/?=
 =?iso-8859-1?Q?QHha0K5ZKxX7lfDi9XpPtWXSPb4RslzJKZaEtlmHx3naZnC+rpam0Edc9X?=
 =?iso-8859-1?Q?xP6+POerMHxZhUEhdWyBvSeDl7f6Dzg4lmed7Za3frzNnMf5UPhE2sRp4t?=
 =?iso-8859-1?Q?1yOIYkk0rfVThxdYCTG3v4+AJj70UPWXwoyDA01lglcGB3D58s55Js2E4R?=
 =?iso-8859-1?Q?CPOeGo4OSpOk+mXJRAY3AQrjxatnPQaa/LCOSrLP8Ef6wyJ9jOKKX3S9z7?=
 =?iso-8859-1?Q?PpU7+Uw5XNBPUx5nPvY4XT7fx6sWoc0LS1hW9PRhhqWLQ4g6E6KyB9UghW?=
 =?iso-8859-1?Q?Sey7cvc5QG088t5ZWVNm/X+WCKSlL+0RoYIH5G89At3J4g6A/SFzrF+gBb?=
 =?iso-8859-1?Q?yasSnDBOlvAXtEwbcqH2lPkeAvKgTDkPDFmrIhHmjoJtjzggBOXUe3tF0Q?=
 =?iso-8859-1?Q?shtJOqpuNOCUatOV1m7OPWwgMfr1OGy30E7IPP5KwVMtvd/1cptskMV+oU?=
 =?iso-8859-1?Q?P6TCusmTAiJs9sRoSxooX1EFwFu7Kez7u3yVgcoz92WOX7mky13zgU+3La?=
 =?iso-8859-1?Q?3fKKqj8DWvb9il7+tQRiym?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?3FWzLLRjDkZqqdvuBsq1tSwJW5JDZCfvkTcrrg9q3EmU/9O33YnhDgLtvS?=
 =?iso-8859-1?Q?Cmbzd9sFI9OK9LhQD1ms5+KMFTvgZR38Ibez6UD7qTj98/zobp3DQfhC/1?=
 =?iso-8859-1?Q?zPufbqZ1fc9/qquti6y3Agp6766dQkpeKWmFKS7PQVsnNduInQaDv1Dyf1?=
 =?iso-8859-1?Q?oXwaeLO2ejamkaTbEfVvB31orudw5tcwev+oFKO7Ok9h+/yPjwVdZ8nefA?=
 =?iso-8859-1?Q?lgqPsr1oWoUQ619Ay7wXZsM81ltlPBYO2z5Mvv+/HB9jH7Zofj2aivQvcJ?=
 =?iso-8859-1?Q?x7q7k2BHb+S7WIJsukPY6iB2SnhCdLam5jjKrIgjuCSR6T3dmRSbgWxkZW?=
 =?iso-8859-1?Q?mZSe63Roj8fsgLE2PksJfiMURNKvs9wP4hXJi0I3WnKj3ReuBxu0kL0k+7?=
 =?iso-8859-1?Q?zHYbCsU8tDeO5FR7mqJ9uqz4oV02DoigfkpU4VSoOSinl69EsVO3NA8Xef?=
 =?iso-8859-1?Q?v9kRofjd37z58Jm7UCXMZurfKlnDSbekw3aijnwOLh4kdKUIlTVXQ/QERl?=
 =?iso-8859-1?Q?yyB/c94kv3FfsYwsi/QfQkMZ5itjCEQBZqLw4B9Tc9TyekL6raQk2UXCW6?=
 =?iso-8859-1?Q?iszGcepu39YnTFs3wISQ2HCgLHUl2hT0rDdFK5StT+ewg+7Pbi4c07Yk/s?=
 =?iso-8859-1?Q?eFBZSe4Ytj4JRo/3RWBHS7fZ3+T+tRm1dwQXHnyUyexnYuvil+0bCwpW8g?=
 =?iso-8859-1?Q?XwSCgvWrry0cD03ybqIe1bXLE4AIvr53GKTT7Q0wWB+j5s3HhP4KTDJDRU?=
 =?iso-8859-1?Q?FQz7Ur+75Za9fXH/47r92kQpvXDEhog/t2S+H9WZXMQRBlolTnch+fWOOs?=
 =?iso-8859-1?Q?BENxWm7LU54C0wBKZFEVntdDpyTpIcBhnZfq09DzrYXXdUJte+jrSv9rdw?=
 =?iso-8859-1?Q?IM5orok/ah4Nf3Nd5ZcYMCbBphiCVastqbuawMew23Wnm5vb3fcGQ0ZoLU?=
 =?iso-8859-1?Q?Fy/8dycuIdKRsyJOoQVtPoevIJuAA3pveSwaE1s45yg/CsftAbPuXnSYJn?=
 =?iso-8859-1?Q?OXDfBEh8uE4TH4d2oC9nfK2LKR0o6vzJCj+jFkuJm+m1jDrTi0PVkUVI6N?=
 =?iso-8859-1?Q?fUF33OzY2kNK+HD1nVohHX7cMwqnJ8fBtt20MOa4/ETGNzTnW+RHNmc8t7?=
 =?iso-8859-1?Q?xX6OOXMLFofGWgHYD3uI84LuUORNM1+3J9DUl+FbscoOYosLk0AalNH1Uc?=
 =?iso-8859-1?Q?fyFUBFRcgijl2o0p5H45YWUlcEWW8ztJrbmyNO3mygGfhdsY9jJweEG7Sq?=
 =?iso-8859-1?Q?wo/NuDQjfNLV6UKfVXOHL0CD/Jkkq83v2p+m8j5ljCwir+5oQZ0eGz3z1K?=
 =?iso-8859-1?Q?pTZl0BfJgN/hkmc48XPrhlJeXzl87qVJaplxRk3GveJSRCAuzQsYmeS5hS?=
 =?iso-8859-1?Q?dOPHRcnhRs95qnG3MaTxM+NlU/Tc9oKi7O26Tx6GHXpi8s1e9KAsQYxzcc?=
 =?iso-8859-1?Q?rlfRjCWta5aGBoYlbNYkZABKQtiDS86ciQ2BwyL6ytG/Pq2eHCLf8peRNm?=
 =?iso-8859-1?Q?Ejq62ujUtGrXmafRdQkry7syFe0Bi0QS0bzRnZi8dQIar7Sq1mz4+l5YYf?=
 =?iso-8859-1?Q?uXxX+A2QM5AE1VDhwMmTD7g2buWUM+hMTX+YPU4ILN8n6hUxM04nyG6PBy?=
 =?iso-8859-1?Q?/5p2Lnehr6ELcsPU0nkZOWsFu138hqscycAehXutMmsbZR4b/2IfJ5tQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d98f7bd-4058-458c-3c47-08de3c06ab6a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 18:20:47.8728 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q1ev3+h4EObG0ZGaapsoCop7DH4BjbPjGflEfsWanagsQQr83DPUBwPWeo8UkNgzLTsNzETKZnACti1AeI1jPM7Z2xNXK+G/Fq6y8jyilek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4705
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

On Mon, Dec 15, 2025 at 05:58:33PM +0000, Bruce Richardson wrote:
> On Mon, Dec 15, 2025 at 06:54:50PM +0100, Morten Brørup wrote:
> > > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > > Sent: Monday, 15 December 2025 18.36
> > > 
> > > The default Rx ring size checks did not account for the fact that the
> > > port would not work correctly if the Rx ring size was only twice the
> > > free threshold size or less, so add in a new check for this. This would
> > > generally only apply in cases where very small rings sizes are being
> > > used, for example, with default Rx free thresh of 32, only ring size of
> > > 64 would cause issues.
> > > 
> > > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > > ---
> > 
> > Does dev_info.rx_desc_lim.nb_min returned by rte_eth_dev_info_get() need correction too?
> > 
> The minimum number of descriptors stays the same, however, if choosing the
> minimum number of descriptors you may need to reduce the rx_free_thresh
> value.
> 
However, I think you raise a good point. I'll see about adding a specific
error message in case the user is using the default threshold and setting
the min ring size.

/Bruce
