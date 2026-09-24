Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27358C98310
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Sep 2026 07:33:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3579342F02;
	Thu, 24 Sep 2026 09:33:25 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id A2A4C42EE5
 for <dev@dpdk.org>; Thu, 24 Sep 2026 09:33:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790235203; x=1821771203;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=bmUQkn38ezJ7yvAze6ZzCxFuLanhPi6LhrZuvxXNblY=;
 b=gwejkSwG40nJ9/qPU/DCHkrDdnvAY0btSQ4bgMp92ULrg1Ga29oMpZKz
 EXlCGZqlFp/i63Hz5PP6Alu18nznk9eB6zyyt6lby5uDvnH5ZpxG/zi8s
 uIf9VZsry8Lsxgdc9+OQ6S1H8qhrDqnkwq8US8Ah+IlkFk1rgF8lWtdzx
 XN2oe20dg31Oj/JPLCJMEeyokVGLMFdzxCrAjOjfbZSYBaxsXbuz4lSRY
 U3FjA8yWd7Ttb39RQHH64d/9KGVfqggf6kDftinnphGVL66OVxEDIzArp
 zCkTwDav+cNN5/+a/h5SN7/ZROrQ2jTx90vgk8X7rM+N7BQOahnTFvGCm Q==;
X-CSE-ConnectionGUID: gZ5O0Y3eSkWAbDLk4sF8rw==
X-CSE-MsgGUID: FTv4IEJmTPeyqqoTwwEqnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="112784380"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="112784380"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 00:33:22 -0700
X-CSE-ConnectionGUID: pV9SXo8tRJaGPLnetOG/SA==
X-CSE-MsgGUID: LJvaPF1OT467mrFkEbNTNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="311850704"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 00:33:22 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 24 Sep 2026 00:33:22 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 24 Sep 2026 00:33:22 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.69) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 24 Sep 2026 00:33:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RK5sO1TAS8GwRjOG4D0aoM7ibAjYl5k+AUecKYsNsHNxYSy6BbJK1h/KdolxalcPGUjCW2hDOu3qpqoOcM3fToxHq9rQ3EKbpHGSFkHV28c5n3HBJojgvLliJBvJR5ysye3CrjnC/H1eKSY/ragaI79TUDYsDhHdu/0Ipv5krMJVIBX9AFRmQoEoYGs7OTDzFNS8PbXs24K8J3C6Y3njEu5/DlM6pNZcZGhhmsCiyioCH4dSPI0zO3Ihj3XztoGADgPF7vbX/6A+cjwV5cNmHT/lU/JfwMjJEvr8WOCPkWDVOT+UpxnFq6P7svUcnZ+GNpFJVn/a/d7NZzzr1bAhYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FrlzdsVyctnO4B+HgiK5S9ydpnsy9Zsxt2Vk6ZIOkbY=;
 b=bLmPewDpx147eWyYnb6XKm+t3gPg0tqxVMtVkraLpPiWrrD1jSCOPqMKe61AeJrSfhsDduFrkTqB6dM9g2zSxK5L2+lXleoQ/C0AIlaRHukd+T1mbaUlyeXv0IT+VwgJt2ivud8hvZSAtp6giikgB4N8WkYNkAtUD5H50Wf6kQUhpOz8HKxWfpyHEHVrvlincgSX3jrvf9l3zfqFqY2xzdPmWFZGGRGqFy5nehr0a6YaHJ284F6MWGZKno+0PHjR8IVyYsKfBjs1PoZIQ2aYcGHMxXpINBenZSTNu7oU2CtIip5WgUTQc+5GTuBsbqTS9acuThhGajm1l19nBVMTfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY1PR11MB8080.namprd11.prod.outlook.com (2603:10b6:a03:528::22)
 by IA1PR11MB7854.namprd11.prod.outlook.com (2603:10b6:208:3f6::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 07:33:20 +0000
Received: from BY1PR11MB8080.namprd11.prod.outlook.com
 ([fe80::2753:b476:2b06:9c3b]) by BY1PR11MB8080.namprd11.prod.outlook.com
 ([fe80::2753:b476:2b06:9c3b%5]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 07:33:20 +0000
Date: Thu, 24 Sep 2026 08:33:14 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: Thomas Monjalon <thomas@monjalon.net>, <dev@dpdk.org>, Aaron Conole
 <aconole@redhat.com>, Anatoly Burakov <anatoly.burakov@intel.com>
Subject: Re: [RFC] devtools: rewrite doc vs code check in Python
Message-ID: <arTSOhHVEOKr7U06@bricha3-mobl1.ger.corp.intel.com>
References: <20260923184207.626576-1-stephen@networkplumber.org>
 <1ZOSY-tgQCqc-X4cyeVRVQ@monjalon.net>
 <20260923135430.7e16c673@phoenix.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260923135430.7e16c673@phoenix.local>
X-ClientProxiedBy: DU2PR04CA0078.eurprd04.prod.outlook.com
 (2603:10a6:10:232::23) To BY1PR11MB8080.namprd11.prod.outlook.com
 (2603:10b6:a03:528::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PR11MB8080:EE_|IA1PR11MB7854:EE_
X-MS-Office365-Filtering-Correlation-Id: b23160b7-bea0-4015-427e-08df1a0e1b43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|6133799003|10067099003|56012099006|4143699003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: n5bWUphVdQAS0z83qv6CUOzv9aJXbm8mxIUxpeK8k6GyMuzf5fMEIyNti0MPSrQ8iKpXepvIR/8GSHSsFgAswyCKYpvRBxDaQJ4poIt8rsTYXz/PAMkSdFB/N6qNJsrIzGn6s7nuMJpfgiJGpykE/kC7qYb4cOoYGTcNK8G+VHVjNT4jJBIbiXhfuJnAlw70x31bhrH5SSuJAktfKxCQIaq9AI/wXYxE5xL/RA1CuHhBqkwluRAqB/ywXyAZMRJruJGnI7N74ckpk1PR+PoFmwStw0dGXxY4gm25VAzuo69ztG9J1oujH5FxGy/FoJ+cCW89GLIjmNeobF7izAOMVEvb0ueo0sCLmsnsb1Zyg3mCRRotuWZk1J1kMjM8Z3d6SC0t5h9vimIcXEt/3EtoOgYMtXFl4TUWowM1AP+gsRmOm1Ic2eYfy9xKDC9sYRVI3CIl7pwbr7iw96W/5iOpl6CrgRy/eHbHZzypMVge+BEHdCJtJFFkWWWIamUgkn6eeolvy57+z7NPvcw12Gz/AQ3eDkHbZeQMOyK2oxjeQ7aaWYxJhQC7ln2B97O4Q1zO1K3J5gX+lm1PhLTHlKl/sT2z7B0UfeNuWpMUIRdBS9LrrVS2Dga1/isNaV3wctFD/X/ZP0GiWjkhP0D7UxDchsPJbfKeWJRyv/b7kbWzhqE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR11MB8080.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(6133799003)(10067099003)(56012099006)(4143699003)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KXzt51TNx9c6aR4zDc3Aog2puwyLpK1xBSHX55xjXTMJkn+n+sapHAA/iybs?=
 =?us-ascii?Q?ISa8x7t/F5yKKLSKIOtbJ2Gk+p2Ys02GTtnDktee7mJEVoBYyAXXNWP9ocpR?=
 =?us-ascii?Q?2A9vyg2aBZMHb7UUWnSit+La/AiTtXVjGtW5r2wiOhqO4oo37MrH02lwPLlm?=
 =?us-ascii?Q?64jG6oo2Zrm/rjhp8aOChbzai1u55NRAHttsgB4PC0A5my3y5VmuKKwBxOt7?=
 =?us-ascii?Q?zTSXSwtousmkx+PxqOfTI6S8wM3M8KzylQOiDMbweopqEN4gMs8yyw4/pKjv?=
 =?us-ascii?Q?RQXDNqmJOdL++ikeTx55iwkx0Cdyb6fSC+verho5vO2HEg7Tk+/4fyjgLGqT?=
 =?us-ascii?Q?wFkQHqfs1JcSACOvU0D7vOAQjn3L7VkPvbOOxleXF3dIBvQ+FL0ItOenA/2s?=
 =?us-ascii?Q?0ay6Q7LMyPzQrwGFZI6Kpfh+Z6hw90/7fXZcFdAtL+vJNcYNZIS5+xwPG5Ul?=
 =?us-ascii?Q?VE5zEnDKdqsXaqykECQyKe9nzSwz377idsgBItAusb0MC1s/F+ccgpiOVHMV?=
 =?us-ascii?Q?6g3AsK90fIR7f2z92DDnDaeqrWQThdGFZjVFD8l5J9tsNc3JfK3XmLsA/IZK?=
 =?us-ascii?Q?oYmLkLGVHm9UEb2tc443Wol2k+LBieU9EcG2zcFioyz04vLMrrbSNL0/7DCi?=
 =?us-ascii?Q?bz3LGyZGEnHcJF0cPJ9cHdzISNxybiODdC4Mya6dO4cOpdUiZw5sy2vuYj1p?=
 =?us-ascii?Q?wlnAyosA7tBRYRY9tf4QJaA9s+H+px1KrBd2FvTAwEZ6iksPIsCX6Sf179J8?=
 =?us-ascii?Q?kV0oR/vHB+MyqCTEYL8ObB9cc+1S7KiXd/1szEDTQl0vKEBwnrdPY0iRTqDK?=
 =?us-ascii?Q?9HC/wlHV+Rz/sIRy9bGHB+xFNWaC3/icIrjUvJR3sqHXstJ0EPLXnbRHa0Bt?=
 =?us-ascii?Q?5ZJ55/o1rHMh/taDCAx2Vg5+HMo++GEGLieZa7EhQEQC/yVsg/FQ2oDLqU7Q?=
 =?us-ascii?Q?eAhbevfU3IOt+PWg5qh5LKRswdmXmyHWlfOxHXBduspBkeJk/kRG71zNq4xU?=
 =?us-ascii?Q?36wlUrZrkK5S0ARlWeRiYaFCY+F9PX1GubsnpKWinOvJEkgYjVx1Sp6+y6iL?=
 =?us-ascii?Q?YEnj2keNyN4s8ODiUd+q1zBgntirdkhuQ/MA3FMhMwzuOTcdO++jArzwX2xD?=
 =?us-ascii?Q?28tLZTgrCcpW3oDDKSMgzPfCrxOijjD4FNwAf65Tl0WiKtgog2LhjOWr95sH?=
 =?us-ascii?Q?ob1/v0W2uXoeUeLMUsH6k7UxYRCi3BULBdwUhIEAnZq72k0CPp9aBZZKaPK9?=
 =?us-ascii?Q?RTL/Idoik8e6yg/+q3Dtmf1j4s33UfpIPGRaWkVQJsSrosByMQeBiACICaJj?=
 =?us-ascii?Q?GzzRRJnUDVJpDSwugWIOSDkp14/f+AyXAcGq6S3cmbwoauxmCNNt2wE0D9zL?=
 =?us-ascii?Q?HRrERm3m2Q0XyxIzSrMSdN4dSrhJdOEYBSKD82Cj6Q/IxewUju5JpVeTpx13?=
 =?us-ascii?Q?YvpdIaHU6sQjhda5dU8rooP6NQ8//jsQLXxm//l5/zXWCWYiZnxo23RXNfxW?=
 =?us-ascii?Q?zyTbb7V9t2O08Jw9EFH5f0+fGgqJC9HaD2LAN+Lvrn9F2LPHWzftBaODDNMc?=
 =?us-ascii?Q?9MxE4wv9ScXtR/+H6wh9kJXuNGTWfAXfOEc2WBXPn/czYWFcuT7mWvEvflzn?=
 =?us-ascii?Q?h3pARS9aBL9ImgXdcEeF1tEdmHyI1etrQo2TeeI/S/1JjgzlUPH1/HZIlXCo?=
 =?us-ascii?Q?6r2Eej/JS59u7nCgZv50cZU7bUgyW7IgpO5Gk5S1+fq9LPhWrHUqdmMWrAht?=
 =?us-ascii?Q?NiLKyTeD5kET1JmnaOn20yGn0/VzJTU=3D?=
X-Exchange-RoutingPolicyChecked: CbO+eiRVU336HTVoMg4hPVRKmLtZUP7oZgabEfevTr1faf+ZAvlNykn+ujH6XpnRTP89PZdFfPsvWt3FA8XIITPhh4nI2HuMhF3ydYoNXRrlglaEUjnkqwzuV8hOj9sk0xYgJZwpmpWjrzvwHlFCrzZyFQyEUJ5AWOMBuahJCtA0h698R+yso0ZzwNqWW+iBcp9a6WHBXKDqq5FGg0W3Gf4YOMawsOaqGGb/N6HDMvsDtF9Zeht8ipIlkh6tbj9XLsTPI/1D9Wl4r2WyC+q02bR4esyh2N0IRl7ldfsIAnGXjkJST+n7f4zLIu+hpIPoVm1/qVcUvrvb6piOV/vGrg==
X-MS-Exchange-CrossTenant-Network-Message-Id: b23160b7-bea0-4015-427e-08df1a0e1b43
X-MS-Exchange-CrossTenant-AuthSource: BY1PR11MB8080.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 07:33:20.2322 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eAjgk2l7vUfZGrPYFr32b+FVO04CFUY7Dmv9pgeTQaHny7abheVKs3I0OIlRk+6DgcRvbNNsvSyWZjdKdlcv+Fp9Q3B/SdoN3j6KkWTrOTc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7854
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

On Wed, Sep 23, 2026 at 01:54:30PM -0700, Stephen Hemminger wrote:
> On Wed, 23 Sep 2026 21:19:45 +0200
> Thomas Monjalon <thomas@monjalon.net> wrote:
> 
> > 23/09/2026 20:42, Stephen Hemminger:
> > > The existing check-doc-vs-code.sh only compares rte_flow items and
> > > actions, and only for drivers whose directory matches the ini name,
> > > so none of the drivers under net/intel are checked.
> > > 
> > > Replace it and parse-flow-support.sh with a Python script covering
> > > the whole NIC feature matrix:  
> > [...]
> > >  devtools/check-doc-vs-code.py          | 1132 ++++++++++++++++++++++++
> > >  devtools/check-doc-vs-code.sh          |   84 --
> > >  devtools/parse-flow-support.sh         |   92 --
> > >  doc/guides/contributing/new_driver.rst |    4 +-
> > >  doc/guides/contributing/patches.rst    |   27 +
> > >  doc/guides/nics/features.rst           |    5 +
> > >  8 files changed, 1169 insertions(+), 180 deletions(-)
> > >  create mode 100755 devtools/check-doc-vs-code.py
> > >  delete mode 100755 devtools/check-doc-vs-code.sh
> > >  delete mode 100755 devtools/parse-flow-support.sh  
> > 
> > Thanks for working on it.
> > 
> > My concern is how easy it is to maintain for all contributors
> > having to insert their rules and exceptions?
> > 
> > It is replacing less 200 lines with more than 1000 lines
> > so it looks a lot more complex.
> > It is probably fully generated by AI?
> > Can we make it simpler?
> > 
> > 
> 
> The other suggestion would be to git rid of the .ini file method
> of generating this feature matrix in doc and just have python script
> generate it.  Prefer a single source of truth, less work

+1, I was just going to suggest that when I saw the discussion on this
script.
In case of autogeneration, for cases like "partial" support, we can have a
well-defined comment tag or similar in the code to mark it.

/Bruce
