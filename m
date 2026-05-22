Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858FCCD4F3D
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 May 2026 07:51:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B076C402A2;
	Fri, 22 May 2026 09:51:24 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 9D72D4029F
 for <dev@dpdk.org>; Fri, 22 May 2026 09:51:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779436284; x=1810972284;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=62rBdixDFGaGfHW8XTsZAq2bPgIEZnoJoUf6pvPI870=;
 b=JXmYRfagaqhZyfrRfJnd3YlAVYBYl836ZIYUAgsYsr/Z+m61WVvAe81b
 RzuFwpRXeAZR0xElKjq+HuUyaJ2a8BAHI1RywTPctL6EC7ljvXrIA8NGD
 Nbg6aV2xHYYt/HzjcRuHRESACT5d+N6ZZYSEJewUjG3PrIPSHwS6vYp/e
 PbbMlAG9iq672xXjKsvbYtcyydHw3tFhNCf1ojHmi/TidgB3jlCTslBp+
 1XlUgogO4FE+ug+QM22A+0mKdsSzZWMkTXDd//mAx+Qjy0FynHXouFIc8
 p+BtvQaoEKqYrH3pZ+xAUPUh5YhKwF+1OsAzb+ZgEZL1e2rWhsqpT55Tf w==;
X-CSE-ConnectionGUID: tA4vWq+dRsSH/HjdyKLQnA==
X-CSE-MsgGUID: 5Jf9iu3AT3CrWI113KSPOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="80484564"
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; d="scan'208";a="80484564"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 00:51:23 -0700
X-CSE-ConnectionGUID: MAYSDXlfRMKy5yG4kkOc9A==
X-CSE-MsgGUID: R6rH2c4eTzyVCDyibDdPEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; d="scan'208";a="237807360"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 00:51:23 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 22 May 2026 00:51:22 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 22 May 2026 00:51:22 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.69) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 22 May 2026 00:51:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=maeI0dzu9tqRm/5NF+n9n0vAKDpzVY+jbYJWDW0R/4klBBN5dVxhHTZQpy10QsrHP1LYA+6IO+aI9aa3onuXg5cOhbQZgFgWg5ojKdx649EVqxrszw3LEf0otujFjrgDT9OKQukApK5jPqVgzOyTUziSTcLXkX4QDviAPGJ2XhpMvB8AzscjcHMTf4F7JjdE6Xk13BbvPQ9eFGq88nYZUlOvxK0owUxNk8h1NPFE4PwP5jIPYt0mR+xDXJ9/oZ91AzxeE61x5d4T5ol57QiksyYoN3FDR71bfBDOT9JVwmriR7pZXvZsCCYuPZc3+3l1BUJa6qP5vDYqEqXPZ0lG8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BbcMgXE4xR6HPmrrz8BeHvDNaX4Bt1z8wPD8HXu/bA0=;
 b=aTXsS75PUVu6+CPihah3tmPBGv4GRHAZnBPmwaksrSBSYMzQS95eAWeuvf9a4ZEPZqlFBEIwH5F4jJQDVTdMnFWHUpk74VNRdc7FwFN6c267g1F1ClhnGJnTnLREJ6RfYuVGPGz+Edtck/1Rp6wLKqysoc1UUoSR4acubzhD2qFOhE/rNsBcSnx3hJw1L/wFETzbzdkQXCy7r0Mc+zwP8yOpj97YObd6HV6EU4TcQGWKOFeNYPQ5TuEPVHALFCQFg5tCQigYv+9IOjDUJLrFvXFHv6IGwxpLaxz0CCQNvmCzl4TA/bdkGrDQYAyR18dGeGaQAoYRPlg30OwFDqjcvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH8PR11MB6753.namprd11.prod.outlook.com (2603:10b6:510:1c8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 07:51:14 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 07:51:14 +0000
Date: Fri, 22 May 2026 08:51:09 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: fengchengwen <fengchengwen@huawei.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH 0/2] extend interactive telemetry script
Message-ID: <ahAK7QicbgzWlq-R@bricha3-mobl1.ger.corp.intel.com>
References: <20260521153913.82634-1-bruce.richardson@intel.com>
 <628f817f-7f6a-41c5-b21f-e7b28224fb51@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <628f817f-7f6a-41c5-b21f-e7b28224fb51@huawei.com>
X-ClientProxiedBy: DUZPR01CA0065.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::8) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH8PR11MB6753:EE_
X-MS-Office365-Filtering-Correlation-Id: 195a2e61-780d-4d7c-148a-08deb7d6e5df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|56012099003|18002099003|3023799007|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: +SaqoGMUt3/WOvIswx8L812v7a/duEdNSmoLJ5DGEPUakZEzA7oFnSsmhMhuz5yhLR4hCF/heNh8oCVc4FQR7Iy6SJnTRClH5E8UyoYFcDoOTsZ5oJ8bl+vlEJlIabHvi8wtOnP+oR6iqP8fDVoqdhrwl+vbibWquCqjEyTta0r5MIZv4ox9vSwVwfE6dCmiNZqI9W1IVMYDEbF5C2CTy8bqLQASBOjswzetuF+vmcAHeiPJpBFQ5ObRrdWAM7LnL5hEb5ucme6ZuE+FSF6u8sw9wTpLMxEd2hqwNMxOxJD2jOrxEMrLD2Z6WiBEgff6qPQXiEV1nbaAsjmvBrIsSHvbJEX6gyPd90iGSqKDJjYR0gORPex7AV52tdTY7xNo7Zam9iE4zBeeVNW3s8BFmPOKI9/uuOo/JWmgNR/PUXOWgw233Gyw9KaTeSLJQK673hxPkgVMONP312LWeMe9zhbp74zqAhX9zqnaY87tXv1IVeQzsXyJNHnFTsssfQPPV0OM1jvJ8N87F7xb5nj1zrs8/vLZlLyD+tyFlXmyX8gKYTPlWeAk6Qy8kig3+1wXb+q43fszW+iD01yAKPGYeoW/DGcGGasyS89p5uAhezLUAPC6jvLls2sGxhjf1mgtEfjmLEnXJyZdTCdTwUQIQVCAxdZhUwSwPirzyyd2z3dVTj9FEWAbw1JDVoDM7Zh/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(56012099003)(18002099003)(3023799007)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k0oBlE3+iKmrZpPleckAh9VELeB9iFgFSMw0Aq4ChC4/q/LVQI1OW7QLLpYh?=
 =?us-ascii?Q?ZI83DOb8bSTkhWpSUVWyNrQ0hAknjk4tCbi4ug44jmGkEChBSULaSo8sU4cM?=
 =?us-ascii?Q?ik1YqK+uaIPd/ouerUNMKBy5FK6Z478ZsKHl8qGAbcQ3oLNY/h2iIK5Ht95U?=
 =?us-ascii?Q?2FYHeiJuiI98mVN+KrkCO4GcUtkBT8NbFD3IYJn9u4ygPQGPOXNNEVCKPrag?=
 =?us-ascii?Q?9lqORx1hbvFIyvoA/7ffsyP3C0l9yicNQTgITUeMaikaJTFBsdz/s9srOopw?=
 =?us-ascii?Q?KxOML9O4EuJdcuCuSZnaSXf74ViCckhrlSTJ4A63+WJhqUnD3u4VjJQQjKfD?=
 =?us-ascii?Q?/HY+N+L6+JuOxoutx3NuxgRystsdrqU5MBj42nqAGLc6dG0eRcw+zfazLrtZ?=
 =?us-ascii?Q?q8oZ3kAn5KHEZgZIE18GOyS8wGsQ85gvK0T0ZDbDsLxMoFig31MNxml7s23S?=
 =?us-ascii?Q?cASTmx771lKgn/R2m5lkTHzEUl/5zV2tVI06AeSObubufqDf69gUixvbFnvG?=
 =?us-ascii?Q?DZ9NFgwRT25PNC2xkb8+QwZzvqJe1MdCM3eDfVIKteuBM38Xt4m14fP7t4yg?=
 =?us-ascii?Q?cRazwJrL+4w26R6goVdVx7Te4fz3Zpw2tI1kBHf8N8KQjZquwEwUIpTni7EC?=
 =?us-ascii?Q?xlDCK8JiVgSvjpg45fPtzxxjWcuyvIs55eRkvJ8jAbIByTcYJafBIfIg0hOV?=
 =?us-ascii?Q?7uoLHs0V6i2K5eHqVug9wZrW51mSOxiGkuRgXSRESGJ2wggbQh1usOqmQFg8?=
 =?us-ascii?Q?hESp9SgwJk79e8gFOUgivUizs3CikO8UFE44GOih0PcyIcvi3MB5vWZpwPoS?=
 =?us-ascii?Q?j1jbKuR9neZ8/u2z5lrjeOx80musgYdK7Tvkwmz9/pYSGiuuQDDv1C0aZtQO?=
 =?us-ascii?Q?CbP6V1icGYhKdTURJqaPqKhlCB1IupzryGRBY7M4lNVsfC1Vn9/dPA4TopnM?=
 =?us-ascii?Q?zlclzkik5PJgOQpiIazuCgbUdvUzH/TFXpxeMYTipGvF1r6aVRMwb+2cwj85?=
 =?us-ascii?Q?E/aykuPLA7f1hPwWuJqNmLYQhDbPD9wy0DHljxpc8xm1csK1nBjNSpWl+RV4?=
 =?us-ascii?Q?WrPYN3JyLk9hsiY9XA2kDnPuASFMN74/25f+jaC+5/u6CdPG/PzRm1biOx0Y?=
 =?us-ascii?Q?BrlXqrzbWW5/SDmysueS4RsEQRFvwKTOSed1eQtR602X7bFa/Su8XFp99tcc?=
 =?us-ascii?Q?N7b/S5nobHxwuTWmBiDx/DVhZT+lODgF2k7VFNKIdf79pVBuzYRBNfBe/4BW?=
 =?us-ascii?Q?6KIYRcxXUuw2zCXPiWfPbyoy3DPBxlJAEBKPoNtlsJ1t+6aF8jzptn/2eIsS?=
 =?us-ascii?Q?t4FYMoN0Du0ToD8YLnodc+ZdN/9OR7eBeTsbOEZI1CvO1c7SbfVwHjUBnV19?=
 =?us-ascii?Q?E8hrHl//sRDAcysTmF69jQthLdZfG6slL/DAVNvSH0mBxZE6oDPOAlSuTQ5o?=
 =?us-ascii?Q?oij1YToLZZWfjQfmxq+wfazBqPV1hnt2SAUOtGEfkFq6fXlJPVpcjFvP7qe/?=
 =?us-ascii?Q?ZpdPpUM41zLj2iBwnOLUd30YaCiim7SG27yjwEqKrtjcSUNXM+nH1YJPEHw5?=
 =?us-ascii?Q?3eyOYaC9VRnlgx4X7SBl7/DIR9KEg7+MeU+UbrXbqpQF/Yjr3bzYCoV8rbDj?=
 =?us-ascii?Q?uRjgWGrdvPx8KZ3adEBVv878huF9b7boTwa8xBsfxb9gOtEs0/0gTKS53ShL?=
 =?us-ascii?Q?O+vQzv11Tq19SF7RZ7BpYaMC8eB8QN6CT8CO1LtaJ7Pbp6ZTMDNXRODxikaH?=
 =?us-ascii?Q?1j/IQA3Bl0ooOd/dsv4SRmnt0p1pSoI=3D?=
X-Exchange-RoutingPolicyChecked: cC7BPoLUWUKsbuKxcVrvRg/oxLQTOpUyvxfDS2RkSw2Lm/gsZJzf/sUbiwxvq3fU5Lb3w/fekI+FBtJgVMZPVMjBXuZI27iKEn0bKwwGL84CbrK1b/KsyUkduz52747C9Kd9dl7/kVNpHtuVeWESTq5rGaiz2PninGS22oFx9fk/Qj18tYOWiLvVfBLxikopyRVPd3FD1lXjnRQK39P51JocRp5Mg+PvdfY97WmLWsc2/Q2FmgOZ2G8VddWK54TnKg6CaeLBEbLmR2UxvklJS36B50ms+JuyH9cHolFz2fdpNlEpceUnp3Jnl7U+q2DAz3ZjJ4kNdOWLfGctU3jsQQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 195a2e61-780d-4d7c-148a-08deb7d6e5df
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 07:51:14.2054 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0e56XZaahkyap6YKqvy2JxF6FIp2YXFD585jjm23Y1qL2xByLAR3fqQVNuXW/sKhUbbEoO6zvRu7pWV1nJo/2C0qs6FQumhl8sqE573sl04=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6753
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

On Fri, May 22, 2026 at 08:44:55AM +0800, fengchengwen wrote:
> On 5/21/2026 11:39 PM, Bruce Richardson wrote:
> > To simplify interactive telemetry script for general use, i.e. not from
> > other scripts, we can add two new features to it:
> > 
> > 1. Support for FOREACH to allow gathering a set of output values across
> >    a list of ports or devices, e.g. ethdevs or rawdevs.
> > 2. Support having predefined aliases in a file in the user's home
> >    directory to simplify the use of more complicated FOREACH commands.
> 
> +1
> How about add help command to introducing above FOREACH and aliases?
> 

Sure, not a bad idea if we are extending the script to make it more
powerful. Will add in a V2.

/Bruce

