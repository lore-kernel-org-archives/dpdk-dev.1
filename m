Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC9AD2F7CC
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Dec 2025 12:28:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EDB944027D;
	Fri,  5 Dec 2025 13:28:27 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 0357E4027D
 for <dev@dpdk.org>; Fri,  5 Dec 2025 13:28:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764937706; x=1796473706;
 h=date:from:to:subject:message-id:references:in-reply-to:
 mime-version; bh=ExX0yj03HEAOBdD9IpDzGTxFbfcEyslL7rSFpYpDvlY=;
 b=J97YphcL3TV1lEYteqyie8rbL4AWZsVfZ93Fy0X0Hsbd94+jqj0uw+lK
 VWEjelS7ciDnemNCwOHnSlSFDEBIwAtsRGN89YlGS3Q6DK/NJNVpoGGd6
 KXJE+uXHX9gjHd1kfdVb4hcMgMG0OekD7oROKOgVl5X4thwkcOYu6vygB
 3hpVsQSsO3mS7IZYY4/KkPSDjjOmS7+FnFeXRFbMSc3xIpsLEVcmH7u4x
 QTS7XrDJWrV2kKoFhcu2d2uqsQKkBhzQgyEapqlOHzvbJptPAFTBQNw+b
 zykXc6gSWPowFlrv451e6jBzHZqnGCeA1Ve2FuEAJW2i2sui2HYOjfPZ9 g==;
X-CSE-ConnectionGUID: 35pnkyDxT2WZCnqexP99/A==
X-CSE-MsgGUID: MSdzX+ZLTgGKEbfZhbxalw==
X-IronPort-AV: E=McAfee;i="6800,10657,11632"; a="89621275"
X-IronPort-AV: E=Sophos;i="6.20,252,1758610800"; d="scan'208";a="89621275"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2025 04:28:25 -0800
X-CSE-ConnectionGUID: ZKv9JhyBQXWx3J6FcP8nHw==
X-CSE-MsgGUID: Cc7fgxX2R0ueKxEukkLNzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,252,1758610800"; d="scan'208";a="195313083"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2025 04:28:26 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 5 Dec 2025 04:28:24 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 5 Dec 2025 04:28:24 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.55) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 5 Dec 2025 04:28:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UibHiKuz3kSkAt7cLGT5sr3lAUNmaSzFkafs/oE7CMHq0Cqhy0PZqhzWO+fEfZF55vheGCT75M5GFrBbT2YLBy2TKnoU7ZDqs99aGu26px/uSMNYM8y9j5KUoYTvYyCAX1Pz82dwBojD8TbH52KhEKL+8BZkLjdrASTABOvHxeO+XYLJD+XHacW0lymhxX0jdtk10V9hWXEJaG9Vjvu1+Mq4G2Gs8qza4ZjC0lJ6Frpe/RyYYR+N6KbubcKrIyB6xhU+DnsYkf+2Sjx/xlB/KWbRHaez2mtVvxnAzYdaZ+Qda9bxsRPbqVch/3jEPorIsI5aT92j0z0lqYNS3ZJ7Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mOv06RJPZZOUP7xUDOLinak2wB27RbeY86/J0eKZIxs=;
 b=Md2xFf6n2mRLACjGSWE+pU89znyVVUnO6AF6vxy72UYBrXnkBXqvEbLDk4+2cQHTBIvRx+AI4BPto0UVjAyDWldaKDby00fmqDLuG9opvOK1e7VtkeRwPMVv8sHzflfUGxIeYnrGH1Hzs+iTPIWeqc7uR+k1BizDfooyBnTd02qegiDB/YTPRV2433/jUV2zrRKBr5vxLMskIBWuypnJsAc9HdioVaoH2NnH6CPyMGpkgnMBdZFNtkqXQ2NY3sV4OILK1YIyekJnPKxqJaT02QffOPQtNr4xe8Mai2eHcLslnLvPurPSqFfaAsF3fO9mDh8FZnZOhONOPS/J9ecnTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS0PR11MB7926.namprd11.prod.outlook.com (2603:10b6:8:f9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 12:28:22 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9388.003; Fri, 5 Dec 2025
 12:28:22 +0000
Date: Fri, 5 Dec 2025 12:28:17 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: <dev@dpdk.org>
Subject: Re: [PATCH] build: bump meson version to remove warnings
Message-ID: <aTLP4TBHLtqm0kpR@bricha3-mobl1.ger.corp.intel.com>
References: <20251205121301.3443561-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251205121301.3443561-1-bruce.richardson@intel.com>
X-ClientProxiedBy: DBBPR09CA0037.eurprd09.prod.outlook.com
 (2603:10a6:10:d4::25) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS0PR11MB7926:EE_
X-MS-Office365-Filtering-Correlation-Id: fdb035a9-8c22-4d1a-ef43-08de33f9c767
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Oj3JXMpMToQQiqsvOzx1OChCPB6cMCRQ0HlPu58AMXwWiI2Zk7i5qbfUaCke?=
 =?us-ascii?Q?glu2DZa5WMc2DQ8CoF1lGWb2L4jlQUGn/+w8qkZFv8/OfEXsaPn7ghKfy9zu?=
 =?us-ascii?Q?SZnqembedpGFZUEizLJQEQ0zGtIuA9goNSzv7oIDwoy+b6nfU3kEfBurM5vm?=
 =?us-ascii?Q?5aijhhMNr5t40FaOM4M2SkJ8Gn+64baXBm/SpfsqFOqCfMacX9RtDN3ohBH/?=
 =?us-ascii?Q?09Nfit53xoKsuFPt69zny/zZuueTWJGYgMwiBYjHgk/tIpZZ0Q3mKU7VJfYZ?=
 =?us-ascii?Q?LhXGkU3Q+wfYJusVtTu5wSm1AsW5bzsPuBegQwqes3R2KcYYspGgi7ZsuRfK?=
 =?us-ascii?Q?zj8C8U0gsLMa2dxgWvRliy9x2TxqtqzJUx2nopIJqpRY0mm/3vVz3cpSKbXD?=
 =?us-ascii?Q?PdXVG/5j2F5sDv0g1KGknjgQ59Gcjk8rQ5fYkSlpUjULgNJaTwBkna9J9MnF?=
 =?us-ascii?Q?7/xgUXLVUbQrUUqsebBFV+WVGreAuyE1BxBWyvj3RfMtraTqaNPz33ArES7/?=
 =?us-ascii?Q?/DetMoNchRVnpG/k+/T/Ir7BSTbjqumZ+qqxXUvbtlch08oS3EPERKetICR7?=
 =?us-ascii?Q?BDdv+jrV+OTe+wLFwN6Ej9RG23SL4sjyRkiWKiUhUhGSDGhA/PNwhdXvELj2?=
 =?us-ascii?Q?ZNkM1XL3N4cH6J7JSXijyYE8uhNWuNTITVTGPHwRkH/oATSoZZ2DwXBrcYq6?=
 =?us-ascii?Q?fVU8SFEDeWTW/jHoPa7y40nqIPiuoSWuIj5rbM4Kk2126X2lvky1TlBHiaTL?=
 =?us-ascii?Q?tj4+vkh9/pzbaeH3d9fQN/sd10qM4yYk1cafpdO4WZG1SA2kPo8jxp+6orl9?=
 =?us-ascii?Q?8l2F5UbLL/AA5cUB39q8Vn7pieqKU9L5/7Tc5emvC3upz8JA3akRsCIB4/ux?=
 =?us-ascii?Q?nV2KocPZRZ7aSFwgQVmJD4ER6+MpmdtTk+TJQdgpVccsvWLhTNvNQb+8UycN?=
 =?us-ascii?Q?vwrEVHXRtSWmBepqSTXd4nGsVCibm5Xft57AZ6ECUSPjv/dh7YoOQhbvlbh1?=
 =?us-ascii?Q?W+EIMdw5A4jlyh0S3lBLhJm5Q3PYXb50uz2hQuUV53mLKKcP/i6AcjRDRObb?=
 =?us-ascii?Q?JSz9FzB2PuLtjNcF53B9n2h4R53acLyHP03rTAMqrs+OYLdccPsSE2UsHNxL?=
 =?us-ascii?Q?Ohp4Efl1MTCANptL/vyrVxlrdCSag9dkLrjSRoR3DSEThqJ68D3F6dDF60iK?=
 =?us-ascii?Q?Y+hA15qqueqla86bAl7kDAlECg7eegsb9PA0npp63+ArZPJMG030LwpNLYSW?=
 =?us-ascii?Q?TXsXcSbIFxOJPeiyZjbzKpUjLBhyQ+6m7tluBVeDb/NpX8GeNdBAB9BwDr7X?=
 =?us-ascii?Q?iiSTr3vofF7y5B6NLKV/pJqGVRkhmMRpk/DuU1T444z1PcvCPxfKu2jJ6np7?=
 =?us-ascii?Q?q9NOqWuThHR1ZVO2PaMTrb4fLUCSv+JoQYlGVKcOJQsMV/crFvuuEZQeKEiV?=
 =?us-ascii?Q?tF56SmU2uPucSRFdYC808tcrrBlBN6sg?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4KSsUqqbyHs9jKo/vnSLM4PyOfnQDZcfc5xYQkOFKkVJHBcMADTYZtUfKfs9?=
 =?us-ascii?Q?sDPDfFtF0flbWte2stcgNKD0HlsvR8oqOyhYiYtqyGCWVA2KQYMp7d+dagZB?=
 =?us-ascii?Q?s6nS9N9ph+/HU1yJ6NUr6okpa+18lDS3funF27aGdsNTu430RSgsE+DNWv+S?=
 =?us-ascii?Q?zXPAs2HV8OQukz7aFXQwgC1bClkO1H8I6L89I2cbhs0p/vsXWQx9TrS/eTFT?=
 =?us-ascii?Q?owjAzvK5trNwWVWVFyMJMCBEsYsE8zmHUJBmFEJ+1/YzigdH3JHrTPxU1iLW?=
 =?us-ascii?Q?a1ZKI8KhbzRUtfPPJ1swko6BUwwLck5+oMCQNBFTbgaJ12x4xxMz7bTHPJbb?=
 =?us-ascii?Q?hPcoaZ+M+5QZ67POqmHk3Bq33gh03sKVls89L+br4HduPEWp6TRG9PlAPF18?=
 =?us-ascii?Q?ifYy6qzXVCK3S++Osym4eN9U+zG1GWgZNLAUz2SEt36ZvDKNU1M+5He/kKp4?=
 =?us-ascii?Q?G2UNqME0r5/YMUieB/3BaRNKXbXB7/V9XWX+5E+xQaVGbRws/wSNIfdwjK1r?=
 =?us-ascii?Q?uC9nr8r+PTgUBLPrGMEcVyM/dCsWc3xyrLkB26j2BmnIvU1w6uI1+NlrDxFu?=
 =?us-ascii?Q?6sQ7DrCoegU6d4dJl1RZDOVm5NGOgo0870636KDJ3VQlbsOcGVuwFKOQH+Sl?=
 =?us-ascii?Q?4muovHGETDxrQvIVlV8A5SfW3RkymsktHhYksJSQ4waGFfL2UddHMLGPeCVu?=
 =?us-ascii?Q?ZvhlOf7tMDB/cZKmd7V2LZm5XYPbb7EBkb8yjR3N4JybfNktmIT2w8/CP43L?=
 =?us-ascii?Q?woSVONa2BiAonkBztvra/oveATijkr6sZ/YdmvtglgIZw1ySYD58TAnPGYn0?=
 =?us-ascii?Q?hfEHFAQN3VwYe44i2lviSzbBfBkgp2+z7x7M9JeFoxT3yApE2T4/MwHm7hiX?=
 =?us-ascii?Q?xiO6pXwJXRniu+FzzGDHdXVWC8iV9z0UUo/IM48WgbAV4LLU/6AIKELC15k/?=
 =?us-ascii?Q?eAWUhHZj+mqGo38PCgFtqzzpE88CYEDK4VY4uuwxYbFjxT7w+S7DG/DROaX3?=
 =?us-ascii?Q?zQIapG3b0Qc7z27iz6icvqS1J/NOmzXOANhPK3CI9FAUO0Ni7g2HYBfHjveK?=
 =?us-ascii?Q?dNjSRqc5ndgfz45M7c9hP/32UQCfopVqxFAkFl4Ix3lLLdK4ltVlUu15Lhys?=
 =?us-ascii?Q?upe9FZyxsi+mlbIkNf/IbxlO2aO9U+NlmYKeqGJEZkjo3yfgvSF/foq0cqXU?=
 =?us-ascii?Q?WQgRMCqcU6HOsa3wmeo4+Hvb1Dt7gy+4OBFQavp72H6HK2UgmZwRrjswY02j?=
 =?us-ascii?Q?HVbo8li0+WoAQ27gfWLfotoJV7J6vIuy+9XFFKK8v3tCRDUSeq0MfZpQ+nVu?=
 =?us-ascii?Q?rmqlTA5mfxlyLkPmBNpVxm1CfoThxa7X/xde0Cy3IXOHJyI5+Zy8N3qcOoGb?=
 =?us-ascii?Q?JILQVjelnwX6W8XA5ZkqXcqNQEDZxwCO3q19voLUk5n80+4XW5qEhOMLMYVm?=
 =?us-ascii?Q?juWahrUmuJZAj5buc18Nka5t6HVM6kXfN5l2IcZmwMz10pVA9Rs6ikyKJO1r?=
 =?us-ascii?Q?UwSEn09PGCwTQNpXAUg7PAhVXqikaBk/mf70wqndmkOvyjA6FXUDAGkTJmw7?=
 =?us-ascii?Q?WLHjFLTa5qcGut8Shn9x2dj0l6xgJbNKYOlGIwtF3xmy4EmFxYq7oiPPs+vY?=
 =?us-ascii?Q?GA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fdb035a9-8c22-4d1a-ef43-08de33f9c767
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 12:28:21.9505 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IJhZqeiJXLa9ey/NwcLT8XQM0xnQXA5DcRZ99VQ3pS8LrpYXiOaew7qjSoF5vUgT3uOKbtKgsE8RyPjtNVp4yWflhfE+F/J1MXMavD0cYeQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7926
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

On Fri, Dec 05, 2025 at 12:13:01PM +0000, Bruce Richardson wrote:
> The build of DPDK now uses features from version 0.6 of meson, which is
> greater than the current minimum of 0.57.2. Although these features are
> non-critical, they do cause warnings to be emitted on build. Increase
> minimum meson version to 0.61 (== version in Ubuntu 22.04 LTS) to remove
> these warnings.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
With this patch, and the previously submitted patchset for assigning test
cases to the various categories/suites, all warnings in the meson
configuration stage should now be gone.

In terms of the specific version, as noted above I chose the version of
meson present in Ubuntu 22.04 as a reasonable baseline. Both debian stable,
and debian old-stable have newer versions than that in them. For the RHEL
line, I'm not sure what the baseline is, but I believe that RHEL 8 shipped
originally with a meson version even older than 0.57, so moving to a later
one I hope doesn't matter. [I wasn't easily able to find out from Google
what the current meson version in RHEL 8/9/10 is]

Regards,
/Bruce
