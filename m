Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E60C021B2
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Feb 2025 17:21:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B8B81402DA;
	Tue, 25 Feb 2025 18:21:33 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 83F97402B1
 for <dev@dpdk.org>; Tue, 25 Feb 2025 18:21:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740504092; x=1772040092;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=sxL/A3MD+KRGd7nSl2dUADxXZhKl0fO/jrkdAq4nBlY=;
 b=ifHJ1peKsRgC6xpNfVqy8CX2BR5psNFAPU2EojfiapCtwnc2yNewRDP/
 cEp4KWhfH2eRSZW0DB5vsvG8xXlC6IDSCx6UMBz2CP4WQDKK8PI5IgefQ
 p+x6TH3w0CWgzC3i71cFaH5va96Vd+DBXA/3ps2//icV8dAnAvRaW/k9T
 2VQRFHS1YaQo3mu7NzFWjCbXEupQ38vVR9GJgrwT5BhOQI4v2irl20BPU
 PcArzzjJB791vLQHUrZ31HeHrlPJGBWLqTp0pOfrg61vTsp5Ys9JxGB9Q
 DWMTZWXSyKEkSdTRAr9n5zm+ppRfbp9WAeEst1X79oykXYgeoipuArbqZ A==;
X-CSE-ConnectionGUID: lX9h0fhETv69qvi7jFzGEw==
X-CSE-MsgGUID: Tx01wGeERQuXpzDPzUeFSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="41449979"
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; d="scan'208";a="41449979"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2025 09:21:26 -0800
X-CSE-ConnectionGUID: etsLDIdFTy+U3i4UJn1wag==
X-CSE-MsgGUID: gLnHHmiTQWG+HZAaF1CLcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="147349282"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2025 09:21:26 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 25 Feb 2025 09:21:25 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 25 Feb 2025 09:21:25 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 25 Feb 2025 09:21:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YVYBvhpJNSzQ+JsyM6JpQnWUuLmwbCaPRZxIYKyA9Warg7r+wqYvDx/pm7CU9lNkvu/oUrA2UcTf+swFNlqWtac8qoAyU3OnP/GaFCM+LtzxIdnrs6INDLlzMLhSkdPbTQHkyrW6DQi+typMF/hcPzueKCq1/PH51f/B4dis8ypjV+pdezgeLyUrQPxkzwkn3xcma23O6Do+7vReY9/5flS+L+J6jytZjvEDBHtz/EhaTrELT3JSx9zGWmfYRNVfCVzCM793CAFRFGo1sjBNNhqExszSqfid6A0gNEeY7A2jvzPGQ++Uht9clPaFDGA6ocsUfwKVBbXMC87+4r8BMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cXPNfHymOXoCimjLlsG4cTaEGEFOQYHCnYD21cEuNBo=;
 b=Z9BMuXavVzkvVn4umzxao0mmd5wntDptnhrMEy7HWUjCstKuv6RJuUdPhUilXWSQOrGsJu4r0b3jsERYO2i1zBJHKIT8rGmYApjfXbbQWDbzZcRKLuHXJIuk78fv9LzZ3ULfbcs3mPQSVcPQGyvjL7ezUPAQZ2c8vRn/lLPHfsVsuJE2AC7xikYofdSe+7PK3TA1nTEUEZnlzs2q4DRj2UxU+7bchZVgeagx9Wxc2i/7NLHGYHtzlId14QKXc0O1DAuyw8h11rsrk0o7sMyAuhX12ZMss9w5YQhIg4hnpt6mWXVFzPhQ6u+haS4Jtcro/1d6dK035LMKG+5jeFNOTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SN7PR11MB8111.namprd11.prod.outlook.com (2603:10b6:806:2e9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 17:21:16 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 17:21:16 +0000
Date: Tue, 25 Feb 2025 17:21:10 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>, <dev@dpdk.org>
Subject: Re: [PATCH 5/6] acl: make compatible with instruction set updates
 for MSVC
Message-ID: <Z738BrMaG8ADWAG5@bricha3-mobl1.ger.corp.intel.com>
References: <1740430879-17874-1-git-send-email-andremue@linux.microsoft.com>
 <1740430879-17874-6-git-send-email-andremue@linux.microsoft.com>
 <Z72HaaPEhxfIk2QV@bricha3-mobl1.ger.corp.intel.com>
 <20250225163727.GA16121@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250225163727.GA16121@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
X-ClientProxiedBy: DU2PR04CA0053.eurprd04.prod.outlook.com
 (2603:10a6:10:234::28) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SN7PR11MB8111:EE_
X-MS-Office365-Filtering-Correlation-Id: 48bda63b-620b-48f9-3d3e-08dd55c0cf92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7HiQTh/4W+Kze9m/dPb41ZYX4Fz4K+ep8CrxghiVWG0vaeFD3NzGNgd9WoMm?=
 =?us-ascii?Q?ct5rW+SZtFFHsFMCgbPBSiB4SZRS5oUtoEGUGaXHuhAXBPNoIlYXTiUItRle?=
 =?us-ascii?Q?9bHh3vj2edb7//hhO5htU5qFCMuILkg5wbgzkVc8orRUU28WmQekWnogsgHI?=
 =?us-ascii?Q?GdYenvWk59GIDQl7hezmE/31SJv8sQJ52BDn0LBZO1V2N6mSmUumZ1EMNvaX?=
 =?us-ascii?Q?g1CLI4/CrAIVfSgl/R3+fyh/HDl3KeZ70xzuG1qSi42+D02+MplWikhIaQdc?=
 =?us-ascii?Q?R5sAzDz6EH+1mifCrfcFocWZToiUmNImWvvipabGUTa1yjIdQFj+G7S8XbSz?=
 =?us-ascii?Q?75pmAqmWLXCLDOUhh1AsG4zg/fkpH4ZZW8lRyfmrHKiWNGMsK9uCMkAtNSpi?=
 =?us-ascii?Q?KMo/3t7THP0wjCA9j60/lhKmv3FTWdWxpxMYMwQUUjuG2Mwv80/vylGYAPxh?=
 =?us-ascii?Q?ASCnO01N2El3odXfVa6w9sfoyfRu9EbSBBKLg+nDiSzJqTEYNwS/P2/4E8KC?=
 =?us-ascii?Q?mYTDq4d668/5THimDXl+bbH+8DCsMh/0Y9DVBYE1RExT0XDexULoH0NyMrQX?=
 =?us-ascii?Q?SXLMphv0iaXtsMUhxnmlbs8JB3++CNV6njUcCll9UL7fOuEY39+prXvczajy?=
 =?us-ascii?Q?jZwNONN3zlZde6um2jn5qu2vAx3x+LZTPpS9VKKZWD+diUYnfJTcKjaw7t77?=
 =?us-ascii?Q?6B/9l9bouQW7QK0c0y4jjAvzm3n+J05lpIU3SXe/HAnmXo0gzz5ke9Sp/x/n?=
 =?us-ascii?Q?/vnSN2R8fddbKWZTHEyTsPYJcrIBlQZKe++tRRBNu3OEry3IAxDSforiTZdN?=
 =?us-ascii?Q?Xlnyyokf2i61zjI108YXud3Mss1Q/gofvlFf3pJ1QGoCyDKdiYRSdP+MsX5L?=
 =?us-ascii?Q?VpyA14TBakQUMk4trd352+8bDqI/BKwLBacY1P8H45nmpxSfdC6mHlUUIUc+?=
 =?us-ascii?Q?80NPMsdKT18/Cilk12j2AvxmwQBOriyN7kcpBBg2F1kDyyg+fBjJBcJEvTom?=
 =?us-ascii?Q?eW+3yYhOuZoLsDvQlRsHgv0UnhnO43apaP+dEKD8jMJG7F+HoCJJFbNflU5Z?=
 =?us-ascii?Q?77dUlRhdWojo946rkHkNG/D5du2SWZTEyMxX/0wJq8W4509vINgzeLYCTFZJ?=
 =?us-ascii?Q?ZJBqsXGrqUG6I4SJjzPd+BjrpJbIQ3llY5x7loIsJBfiH7aluEEIbdx2r/wl?=
 =?us-ascii?Q?AJskSTV3gkbV90o7xtG2vyrACNV7n5KRA6yq4YsvKeLtPDFii6+JbhhuHDyR?=
 =?us-ascii?Q?NVLV/AfEDWruTk0vJQVY8U3baU4HdcAu1kIH1KCPWwl/5ce12rf+I/LVSe7u?=
 =?us-ascii?Q?H1IsBi9jxKgT8Y3ZkwylxbWCO7PpTh/RoakjImN5ftpoY/Rd7DXYKbipklI/?=
 =?us-ascii?Q?bv/xIN7L1+tshnGaI443vNjEHxGf?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xd3QYn5dGaWDCOJ/BBdOH/KmGsNiG1ui/okjv0NCbnaLEzohcuN4jdPv+l7I?=
 =?us-ascii?Q?ndc67l0tl4msbuEGtwmb0hH7ts4kNkrsYoPVqQgllNUhTilZY+ONIts7owLW?=
 =?us-ascii?Q?x4nQ46diWXLPdFXnArOqhNxGbKkMReJYQJ8ilz7FSDFOvAYOQ3oLmqJ3Rd0E?=
 =?us-ascii?Q?V0utpdOiqOe/mNUunP4GcGijeJY6bASUpcmuxxCd5pIy5AqMnD0+OhKCOpEU?=
 =?us-ascii?Q?qG8wptTpaCYaeBbEKaKUTWJlBvHvoFXNiljyr4FL63Bcn2Re8wEGWylb4NGo?=
 =?us-ascii?Q?njXnK9Em6SN0PwXGyiNs687LcZYeTQcP9RF7KvqAlDpFfSILZwh9RIho/h9v?=
 =?us-ascii?Q?KXZPE9KZv3ui3k4UeYJlYtMRHzQvwg50wEC4Nb9fX8/d6SbchETopZWyBj/u?=
 =?us-ascii?Q?3rgHlA8pK7DUgnN3kgmfL+nEUUgVFqac++2UJyBemtl41CYmbO+svsWVolK/?=
 =?us-ascii?Q?Ga4HTclWk/8ELIKuyi7YDlkitWUS5E0xIwnoJNQQQJAcw6mbTnK2XiK8br2J?=
 =?us-ascii?Q?64kJcU4Jky+GmN48oS5zVgt9mV1eJUIyVhHWWal5ssr3IxT9j311sr8EZJ9u?=
 =?us-ascii?Q?Xkyxeo38rM02C7cN3Owxlkdw1m9ItuQelJjwlDv0jXgR78QYescgzWzIR7sl?=
 =?us-ascii?Q?cYuoA8WJoac6m3tOz/NtVBW4zaPRreVqe5tUy08uEQq6sPlz9HoiRHjvcqq0?=
 =?us-ascii?Q?txHx6j6MoEBEvV7fA4m3h9t3KI4RWgxWalOuOXsmQHm7P253QkRku0Ydjr/8?=
 =?us-ascii?Q?iIUrAZDfHPHzRIfoaKh58UU6838zYkZ66K3ebEAWRbKVTY3bo4gtCMVDBvOQ?=
 =?us-ascii?Q?vf4QgRXtS5oiE1/CQNfdmuP14iOJw1IcyrhDmpo/VU+wPl282sGZPzYtU9pg?=
 =?us-ascii?Q?Ru1RQNa0YwwCDfaY/u9bFaFFkRnIox2FIMuBtYdPyIBdfZUZMRvdGG0yHhaR?=
 =?us-ascii?Q?6dUd/hC+tSWqDeJigvBeQgHqqx3ELDpO+EfxYJjrpq8UqzuAi2n/3YIYSo/3?=
 =?us-ascii?Q?IclsRsFRlMHs35NQmmoAsIlkq7Lqr9l6AeFBAG2JF4AZD2sHks36EPrzd/Mp?=
 =?us-ascii?Q?OM/vGVsgDUaw7sRUkUsWfd3ikKM3VPzvVEjTIXHZhp1q7gvzeuOCeBrtoYfJ?=
 =?us-ascii?Q?omrRdFl/UQFWAmSs+qPQ/zjCYv8654B6yuM0fvGGzz08LRc6OS75TQVzPRDm?=
 =?us-ascii?Q?NfPe7utf51WXyABfpgfspZ+cz158DDtPR0rIVRoRJL6wzUVXtPghSe4dGkWn?=
 =?us-ascii?Q?bazCdJtUjgb05O6eiyiRa4bWtFaM3kho13+69RdXHyhh2k9HnfbYexiwiZmb?=
 =?us-ascii?Q?d7IFbQyNQIQYNyBFLrHFGpYyiFo1QPTbN9qhCDGSBdS3WnI1+68W2FYKQ/x+?=
 =?us-ascii?Q?LFl9tbzV3wxODVsiFgnbTJrmqg2uB/ynmeb019d81IOwKC05a6UqXQt9ZQv+?=
 =?us-ascii?Q?qM0Aw7uvbGy9G27SnRwjisDIMl16L2mJ9qJe5fmtawrZEGy3Hu52TpFq7skx?=
 =?us-ascii?Q?Yd+zDWBIDsEksfbKCjcvX3UhuIt7sP8G+5BWbXTpq4xLYui5GL82ROr8RfMq?=
 =?us-ascii?Q?n3XU2jEJRPImGIPdPaTgCe6etBU53iVPuNlK6lY/hUUKht7Nbb0Dt41hCXWd?=
 =?us-ascii?Q?/g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 48bda63b-620b-48f9-3d3e-08dd55c0cf92
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 17:21:16.3131 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w4ldgp1H+1PxcitNjQQegTVs+YNVkHcpk1QutPm4Bl+hCob5HID24nMLzu/Uifdmf3Zgy94vYYwM+A8njC8oU98I4Bq5rvGrgd56BlLwr74=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8111
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

On Tue, Feb 25, 2025 at 08:37:27AM -0800, Andre Muezerie wrote:
> On Tue, Feb 25, 2025 at 09:03:37AM +0000, Bruce Richardson wrote:
> > On Mon, Feb 24, 2025 at 01:01:18PM -0800, Andre Muezerie wrote:
> > > Top level 'cc_avx2_flags' was created and holds the correct flags
> > > depending on the compiler used.
> > > 
> > > File meson.build was updated to handle the correct AVX512 flags
> > > depending on compiler used.
> > > 
> > > Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> > > ---
> > >  lib/acl/meson.build | 16 +++++++++-------
> > >  1 file changed, 9 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/lib/acl/meson.build b/lib/acl/meson.build
> > > index fefe131a48..24e47b6cc1 100644
> > > --- a/lib/acl/meson.build
> > > +++ b/lib/acl/meson.build
> > > @@ -19,7 +19,7 @@ if dpdk_conf.has('RTE_ARCH_X86')
> > >      avx2_tmplib = static_library('avx2_tmp',
> > >              'acl_run_avx2.c',
> > >              dependencies: static_rte_eal,
> > > -            c_args: cflags + ['-mavx2'])
> > > +            c_args: [cflags, cc_avx2_flags])
> > >      objs += avx2_tmplib.extract_objects('acl_run_avx2.c')
> > >  
> > >      # compile AVX512 version if:
> > > @@ -38,6 +38,12 @@ if dpdk_conf.has('RTE_ARCH_X86')
> > >          # compiler flags, and then have the .o file from static lib
> > >          # linked into main lib.
> > >  
> > > +        if is_ms_compiler
> > > +            acl_avx512_args = cc_avx512_flags
> > > +        else
> > > +            acl_avx512_args = ['-mavx512f', '-mavx512vl', '-mavx512cd', '-mavx512bw']
> > > +        endif
> > > +
> > 
> > in the non-msvc case are these flags not the same as cc_avx512_flags too?
> > If so, let's just get rid of the acl_avx512_args variable generally.
> > 
> > /Bruce
> 
> It's not an exact match. I did not look further to see if this was intentional or result
> of a typo. TBH I'm not even sure if it would be possible to deduct this from the code.
> Also, all the CPUs I have looked at bring all these 5 instruction sets together, but we
> know this might not hold true in the future as each one of them has an independent CPUID flag.
> 

Yes, they are independent flags. However, given that AVX-512 has been
around a long time without any CPUs being released with only partial
support of the initial 5 sets introduced with the first AVX-512 CPUs, I'd
take the view that we are probably ok just mandating all 5 for AVX-512
support. That way, if it does happen that a CPU with partial support is
released, we just end up without AVX-512 support on it, rather than a
broken build.  We can then fix that later if such a situation occurs. Until
such time, we get nice simplicity in our code of having a standard AVX-512
flag-set.

>     cc_avx512_flags = ['-mavx512f', '-mavx512vl', '-mavx512dq', '-mavx512bw']
> 
> My choice was to keep the flags that were used initially, but I can change that if the
> maintainers tell me this was a mistake.

I'd add in "avx512cd" into the basic avx512 flags and then reuse the
variable. I suspect I just missed it when creating the list of flags.

/Bruce
