Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FDCC5B543
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 14:28:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC5A342EAD;
	Tue, 10 Jun 2025 16:28:57 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id A00FD40672
 for <dev@dpdk.org>; Tue, 10 Jun 2025 16:28:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749565736; x=1781101736;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=1i6bJsc5EeUTeiQnR42ymjQQ1Lac40IQ+y6RaZKEEFk=;
 b=Fp/XVhl9iY0wkzCYa+QF2xEuhX0hR4RPGhuYerAn0h1I+ZXnFm00zwKG
 sJ71eawQ7MC9LXrvwNNlbCTwofxDW94xYFDh+eGGDzMBqcbGYg5DvigjO
 h8Epyq2PeRv3Hpvi8rCp/ieXGAcJWMrolNbTFAhfpoJOtgTuep/G+Xzwc
 FBW1kGfPHljREHDFhO8rIuKCrVr6pD5epInOlW4c8NEx4SRJli6sVSgdR
 J3TimjGoniMvguFUDLWADFWldUdH5ciefNzt7eWSWhZvMTV8BL/xrJBRU
 q2R0UNq0O9Z7/kvPRk/DidUIvbvhJ/9CNHdSlaxw0ju4F7820iPPsCwcF A==;
X-CSE-ConnectionGUID: +UCZBHAeQ9m70eZ/PLAF2g==
X-CSE-MsgGUID: qpXFQ55sRzKi1y6UnQwoag==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="51771731"
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; d="scan'208";a="51771731"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2025 07:28:55 -0700
X-CSE-ConnectionGUID: ng12cHVPTv6UHifBRXIsNg==
X-CSE-MsgGUID: gMYYBMgoRSmZ+fIPCeX0GQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; d="scan'208";a="146768942"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2025 07:28:55 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 10 Jun 2025 07:28:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 10 Jun 2025 07:28:53 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.69)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 10 Jun 2025 07:28:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V9yLvDPEw4kp3vSJCMiQ2wjgh0at6NJrPk6h04pteio/U7nVouT/2eYoeywT14RHt98oNsMU5X3MxPah4ubWzQF1qoub6199i5SCOgHzxh8cVxZe4tMiBY2E8SnpmRwf83DOWDAL0Sb1dDBsmsobTptWL3E+ayl0EigEUxJvaDN5Xeky8bCVx3XgtQwY1MfOlr7/PLmusbvsRrzPql6z4uBq5PR3wtjR9atp1jaOMKmoCBmLgabGxokKQB2p6QsBhTxkzDXYqcFCpemErn20qZr5NMm9qeXJSEWG7rU8IVKEwd+xbcjvic+2R0xdHGKBTjoe/fggKb91qg+ZaxpVlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IRKt+xBu5yPWz95SOp879VJhEmfLBxy8uGpIiHCIyBs=;
 b=TO5/lz8wBDa09RcabI2lbzLhh76tR/YU7Ijx7niNli/u9d6azjnWQ3JFals4eu27JGgsaHGbWQbJKbOAZLwy+tlD99QNUZ5/E6joA7x4ghqIng78ADmu7cPUI0xMsaQBdxD3D3dfYOcH2asiCFuQ0X4GUIHCFm3ZH/6+/YeiFWMAhOgsondGxAVQdoZBxkOfo9p/QqSRYMRMp8bfa+0wwwqYPvIT3jXFTnJQvCtf/VE+Gu9aLR0Q2E2IZHMOKuAgBRqtL+sR1o7bOUE6tBCCoXYX1o1d+h8nH68wsukrJDnax3A2JcxTuXbVMGTt0hH5pjunidvPII+u0saBC2Xx7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM4PR11MB6165.namprd11.prod.outlook.com (2603:10b6:8:ae::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8813.30; Tue, 10 Jun 2025 14:27:47 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8813.021; Tue, 10 Jun 2025
 14:27:47 +0000
Date: Tue, 10 Jun 2025 15:27:41 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Varghese, Vipin" <Vipin.Varghese@amd.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Song, Keesang" <Keesang.Song@amd.com>
Subject: Re: [PATCH v4] build: reduce use of AVX compiler flags
Message-ID: <aEhA3YgjW9SsMfYE@bricha3-mobl1.ger.corp.intel.com>
References: <20250325172215.3360590-1-bruce.richardson@intel.com>
 <20250529154249.1310449-1-bruce.richardson@intel.com>
 <PH7PR12MB85967617A71099E2F0E5C835826BA@PH7PR12MB8596.namprd12.prod.outlook.com>
 <aEaUA7rDVyPJEvP7@bricha3-mobl1.ger.corp.intel.com>
 <PH7PR12MB85969B5D596151F83DA09600826BA@PH7PR12MB8596.namprd12.prod.outlook.com>
 <aEbSNr7iv7oNJ7_U@bricha3-mobl1.ger.corp.intel.com>
 <aEbUQNFZHhKFKGeB@bricha3-mobl1.ger.corp.intel.com>
 <PH7PR12MB8596ADB9B5BC7947CF6AC43C826AA@PH7PR12MB8596.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <PH7PR12MB8596ADB9B5BC7947CF6AC43C826AA@PH7PR12MB8596.namprd12.prod.outlook.com>
X-ClientProxiedBy: DUZPR01CA0272.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::12) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM4PR11MB6165:EE_
X-MS-Office365-Filtering-Correlation-Id: 32fe0279-83f1-4f6c-415f-08dda82af884
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1AHNcPXmdSTs+Y8QnMOBkCJ0hEdpCCjk6AXtpO07sDq9wygz9K9GuCmelWXb?=
 =?us-ascii?Q?54VP6K4fp/bsHQkh3sd63ML4+3TTIWBGY9blnE9l+AMutzKESG90xICtXiCf?=
 =?us-ascii?Q?vRQ4uOvSPQds9GdRECMaiKyKULFqaSc+u2METxfMI3GgzqOfSNqFNrs3pRNz?=
 =?us-ascii?Q?j/331tHAgj8qpPXAaEe4eGeRa1AY9Gbcxa6muUpZ7JsC3vNjSKqKi90vCM26?=
 =?us-ascii?Q?xmKwWDs23r3JVPToHRePbi0KBOUUe/kzjd1zYFzPNOqPTn3jEozItYt2ohib?=
 =?us-ascii?Q?x6TIFK7hRfbVEbS5VGZ4J9LDq+5o4BYynTMfEHyR1wwVjneCnvLqLN8HXhqv?=
 =?us-ascii?Q?y/BzfaDW+Xx9G/dYrW3cKjLN2Bjmj0CpUhLIr2jcoAtPnEnxt0ivFtSIA2zp?=
 =?us-ascii?Q?W4ab6vVb1L6TyY1xqos9odYzXmcMU5bt5XUbiyjLAXljWia+QkwWmEn5msAD?=
 =?us-ascii?Q?xyYIw3K/0XbOUpgIMrekH41cY7BhXx9OEeCXNKg2SIEWxokInMWglSo21fn+?=
 =?us-ascii?Q?rhfNkc6nFe2NzX2HNAFK3bY7cTgJ7CF2hrfA8IbMwuJ8ZMTC6b+AhnBhuPER?=
 =?us-ascii?Q?J1U/Tc8Id+hEd7RRj0dm/SNMcISfg1OxbhLLBbrMYBUGfqH54P8gdC8+mlPF?=
 =?us-ascii?Q?1vdadC8AfXgfai2CEjSnnn+u4HqZKT4w12tg1S5j2nhRNfx8KaSmRpmtTGJS?=
 =?us-ascii?Q?M7OG6bvdUgxMr7CXXWDKfNkEIQ6jgMK1ThN5kpkgaG7mc5M6Qr0P7+wpbnnK?=
 =?us-ascii?Q?JaTyIlwIbiGTwMUrAkFho6NWxhAK/Jz5gIDWW/aCK4y44sQSWy/NeJSPVc9y?=
 =?us-ascii?Q?nTN9oX+Qm6WaxIIBmtq/O+m18BYAX0mJrmpy249aHB5vW9GzGpxFOQ76gknm?=
 =?us-ascii?Q?FZnsYZ+SrOF4Lc8KG7RCpTqM8n+6HuXUfVehHkJCiElla4NqlWdGwdiVbfdR?=
 =?us-ascii?Q?HGyzOBdC/49BjqOksO/uqqLZUqK00yZhtv+zapy++9rT5Gugw7Rky+YyVxXR?=
 =?us-ascii?Q?lQ8ZZI7G5qaKLrSQbmsQEniMQc4vNeXMb0Nc/g/WVPZHe6JaUuzYk7vz03ik?=
 =?us-ascii?Q?QvlRvFxIR+UjfpD/l5HRrERowLtdSzez31cJkp+cesHiVNF6JHQRyvAjiEjJ?=
 =?us-ascii?Q?oFQs9o93WlcYu/UrNH3cZOTXLbR4BscAPS7q/FJEDjIRcyd2K5HIeC4Ez4bD?=
 =?us-ascii?Q?opR8ZwDsiZa6mujKSTKsdZhaN5PTlPbNfb9+oue7q++1gJSX7YbNRvQv89fy?=
 =?us-ascii?Q?KrfYOyd+573VDwfnkrW5EyztaJ01vhH+LaGGo8BpvYsRSIj+Ihi33jEbIct+?=
 =?us-ascii?Q?HwGHxbqRp6jBQp+d22xvWRmmTJwb/J586VqO6Rx9i/LlWe2jejank47vUep/?=
 =?us-ascii?Q?EQRM9pM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jnqB5hUiXJVT2Kmi7ylBloe0sKZY+krLMvq0LJ84CKPGuHLZPq48Bnr2CKht?=
 =?us-ascii?Q?GB7zvaL5zLlnmV0Khk2iD4Dr2xaT9UCSoEjbWZlitHseZgIo5avUj3zyX8fw?=
 =?us-ascii?Q?xrSDCjDpeVgf29r66vt+z5CUhurr8o/n0nwwcOYfGKcw7o9ojcS+NmV3SNo/?=
 =?us-ascii?Q?oB6wKOt5aVNOqxNV7L5iwGZNTxlXW6SBp0WVq8y/bR+/CFamasHEgVqwnXE5?=
 =?us-ascii?Q?goXzn/U1eSj+21UB0xFDaan2fJeV4hl5zDW4COemtuu/K6LdwSsHEPNUyEfr?=
 =?us-ascii?Q?9Qusz+dU0tkicMW5Q1cRG8rzHrTPUv9Il4GrpqyrJyVn8A0fSk4NwmHGl+pD?=
 =?us-ascii?Q?bHcbfOYKoy3QRNd/qXs7Smi4WmH6HJ+1jfOJBB0LwEF1P+1K+tZxdD8+KSz7?=
 =?us-ascii?Q?g/0fMKynjj/WBup5ZZUkcREDRsjSF4A7lJvIL2M8AQi3ucChS8ySxBS7p7fV?=
 =?us-ascii?Q?uTzQdYFqCbmA7Lo2FrOEG9DXlFe+QqdlIPOtuB2pMfqrRJN343rVjy2fHP46?=
 =?us-ascii?Q?L+Hj3REQjHyY7AWJ8jGtmQjFmQQKgMHjzsek7vm188pe0tn66m7bZMHuFD4Z?=
 =?us-ascii?Q?l/0wJV3SPNcYkVefZDtHOJjj25VXHWnSG55YhDachOxivCC+75WLqzuOaZAG?=
 =?us-ascii?Q?lDAlsghSc3tMVvz464Z6IXOwFYiPL6ZYboOevxgKd//3sLVBVs0qvhH42L19?=
 =?us-ascii?Q?ygsW5jhjK+A61+HktoIN+gJ14naBdj65sIuKBX5GEYZm0u1qVokArhL/w8Dx?=
 =?us-ascii?Q?wG21RLBEeP1fKip69GSAY5R9tiuMGgZwOTLxcd6cl6chkCTt9zy3L1LUeUZQ?=
 =?us-ascii?Q?2WExxvCaoSKbjjx4o1GNvqZrxQjvbv96uLyC6YKEhClvnYTP7iK4rM6ocbJD?=
 =?us-ascii?Q?zEsE5h7Q5I14yO8j9FWSlWhk1+N0ZUe16igMwK8vkGyF51TzOmgZnGjxeQRg?=
 =?us-ascii?Q?w0KMEpIyVBD6Gn+orDy50Ybqp1M6Zf/pPZ/2Bm8uIzmfHC9GQqZF6JZU1Jc4?=
 =?us-ascii?Q?g6CFD6+2doZrX6Jdw0efAAJX9EREvdE+PNaDFAlkMnexijWat8tBkpsVyNEB?=
 =?us-ascii?Q?yejWvY1yxjsMbpmk8Lj1cl2/aN31zSLEsfnnDVrV1x49gSWPdKi7U+0WZiDE?=
 =?us-ascii?Q?v0KzAqvZ2LuhPAEkVlKIP/7uOQrXesw/UJdD3U6TEl/u9Em3OlQq00D5mGpE?=
 =?us-ascii?Q?8VbNLGyDrAWD309agCNgiX1+SVL6eaFkIXZWQL34Psu8hACgMss+AqWl3Qwy?=
 =?us-ascii?Q?zt3VW6xRWlLUeuaDtMz+Bfspxw42Sue8pbENWeLjLT+6gG3p1US1pyS11utz?=
 =?us-ascii?Q?7UEXEvtGMno2TNLriZQAqo+UPF8gWMGFZQcZK7/cQ48hwKX3HrNesxk2bloy?=
 =?us-ascii?Q?y3V3VdLL5RAvuDxhc0UHiUOyChg1F/ptJE6kKcsDiIfYjCHHo/VQ/zQe7Ukf?=
 =?us-ascii?Q?uRiieCJCbRFNuJjpGJzin8XymROW/J5dmnXkOapsJ/4pbLXmjEvLwCzgmNj/?=
 =?us-ascii?Q?BLm7mMIca44rtMuR/qpkfgUMwNwXl7fRhCRHNZNG+Y+VkF46zVPTM99dFv/W?=
 =?us-ascii?Q?fsuCdCixcoIAfp7HTc3uyApR3SoMOGd/OGRMfxqiVtl5TKUc1Q63O8RfNDZ9?=
 =?us-ascii?Q?yQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 32fe0279-83f1-4f6c-415f-08dda82af884
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 14:27:47.0767 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VmQyFDFrwFCk5bDcv+n1uZavkSCZnnCaQmDSUVscXAwHQGDvVkUe+sr1gQyhOfg+qymNz0EYVXyq3EOMrV+/dqE6+L6ucbyMrZUUpspakS4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6165
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

On Tue, Jun 10, 2025 at 01:02:12PM +0000, Varghese, Vipin wrote:
> [Public]
> 
> Hi Bruce,
> 
> Snipped
> 
> > > > > >
> > > > > > Hi Bruce, we have reviewed this internally and tested the same.
> > > > > > We would like
> > > > > your thought for the following.
> > > > > >
> > > > > > - Before patch: we were directly setting AVX512 falgs for F, BW,
> > > > > > DQ, VL
> > > > > > - new patch: we are setting the flags for `skylake-server` as bare minimal.
> > > > > > - AMD supports AVX512 from `znver4 and higher`.
> > > > > >
> > > > > > As per GCC
> > > > > > `https://gcc.gnu.org/onlinedocs/gcc/x86-Options.html`, the extra
> > > > > > ISA
> > > > > supported between skylake-server (super set) and znver4 and znver5
> > > > > are `SAHF, FXSR, XSAVE, RDRND, LZCNT, HLE, PREFETCHW, SGX`.
> > > > > > Currently for DPDK microbenchmarks and examples runs safe as it
> > > > > > is not using
> > > > > the `SAHF, FXSR, XSAVE, RDRND, LZCNT, HLE, PREFETCHW, SGX`
> > > > > instructions.
> > > > > >
> > > > > > Question: should we check if target is `AMD EPYC` then apply
> > > > > > bare minimum as
> > > > > `-march=znver4`, thus avoid possible unsupported instruction
> > > > > generation when non `c_args for march` is passed?
> > > > > >
> > > > >
> > > > > Can you clarify why you mean by the "target" here? Is there a
> > > > > specific value you are thinking of for the "cpu_instruction_set" option?
> > > >
> > > > `Target` is target CPU, when generated without any arguments we get code for
> > `native build`.
> > > >
> > > > On AMD target cpu zen4 or zen5; Before patch as per the code ` AVX512 flags
> > for F, BW, DQ` are used in ` cc_avx512_flags`.
> > > >
> > > > With the patch, the cc_avx512_flags is set to `-march=skylake-avx512` (where
> > compiler optimizations `can add HLE, PREFETCHW, SGX`).
> > > >
> > >
> > > With this patch for zen4 or zen5 the AVX512 code paths should be
> > > compiled with no additional flags, since the -march=zen* flag should
> > > include everything necessary. Can you confirm that you see the extra
> > > -march flag in those cases?
> > >
> >
> > Ran a quick test myself, this is what I see, doing a zen4 build:
> >
> >    $ meson setup -Dcpu_instruction_set=znver4 build-zen4
> >    The Meson build system
> >    Version: 1.7.0
> >    Source dir: /home/bruce/dpdk-github
> >    Build dir: /home/bruce/dpdk-github/build-zen4
> >    ...
> >    Fetching value of define "__AVX512F__" : 1
> >    Message: Extra C flags needed for AVX2 output: []
> >    Message: Extra C flags needed for AVX512 output: []
> >    ...
> >
> > Checking the build.ninja file in the build-zen4 directory, there is no use of
> > march=skylake. Here is the compilation recipe for i40e AVX-512 code, for
> > example:
> >
> > build
> > drivers/librte_net_i40e_avx512_lib.a.p/net_intel_i40e_i40e_rxtx_vec_avx512.c.o:
> > c_COMPILER ../drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c
> >  DEPFILE =
> > drivers/librte_net_i40e_avx512_lib.a.p/net_intel_i40e_i40e_rxtx_vec_avx512.c.o.d
> >  DEPFILE_UNQUOTED =
> > drivers/librte_net_i40e_avx512_lib.a.p/net_intel_i40e_i40e_rxtx_vec_avx512.c.o.d
> >  ARGS = -Idrivers/librte_net_i40e_avx512_lib.a.p -Idrivers -I../drivers -
> > Idrivers/net/intel/i40e -I../drivers/net/intel/i40e -Idrivers/net/intel/i40e/base -
> > I../drivers/net/intel/i40e/base -Ilib/ethdev -I../lib/ethdev -Ilib/eal/common -
> > I../lib/eal/common -I. -I.. -Iconfig -I../config -Ilib/eal/include -I../lib/eal/include -
> > Ilib/eal/linux/include -I../lib/eal/linux/include -Ilib/eal/x86/include -I../lib/eal/x86/include
> > -I../kernel/linux -Ilib/eal -I../lib/eal -Ilib/kvargs -I../lib/kvargs -Ilib/log -I../lib/log -
> > Ilib/metrics -I../lib/metrics -Ilib/telemetry -I../lib/telemetry -Ilib/net -I../lib/net -Ilib/mbuf -
> > I../lib/mbuf -Ilib/mempool -I../lib/mempool -Ilib/ring -I../lib/ring -Ilib/meter -I../lib/meter -
> > Idrivers/bus/pci -I../drivers/bus/pci -I../drivers/bus/pci/linux -Ilib/pci -I../lib/pci -
> > Idrivers/bus/vdev -I../drivers/bus/vdev -Ilib/hash -I../lib/hash -Ilib/rcu -I../lib/rcu -
> > I/usr/include/x86_64-linux-gnu -fdiagnostics-color=always -
> > D_FILE_OFFSET_BITS=64 -Wall -Winvalid-pch -Wextra -std=c11 -O3 -include
> > rte_config.h -Wvla -Wcast-qual -Wdeprecated -Wformat -Wformat-nonliteral -
> > Wformat-security -Wmissing-declarations -Wmissing-prototypes -Wnested-externs
> > -Wold-style-definition -Wpointer-arith -Wsign-compare -Wstrict-prototypes -Wundef
> > -Wwrite-strings -Wno-packed-not-aligned -Wno-missing-field-initializers -
> > D_GNU_SOURCE -fPIC -march=znver4 -mrtm -DALLOW_EXPERIMENTAL_API
> > -DALLOW_INTERNAL_API -Wno-format-truncation -Wno-address-of-packed-
> > member -DRTE_LOG_DEFAULT_LOGTYPE=pmd.net.i40e -
> > DCC_AVX512_SUPPORT
> 
> I have retried the patch and tested the same on 2 scenarios
> 
> 1. Scenario-1: znver4 (avx512) with gcc 13.2
> 2. Scenario-2: znver3 (no avx512) with gcc 13.2
> 
> For scenario-2 where CPU is not supporting avx512 but compiler supports avx512 I get the logs as
> 
> ```
> Fetching value of define "__AVX512F__" :
> Message: found AVX512
> Message: ['-march=skylake-avx512']
> Compiler for C supports arguments -Wno-overriding-option: NO
> Message: Extra C flags needed for AVX2 output: []
> Message: Extra C flags needed for AVX512 output: ['-march=skylake-avx512']
> 
> 
> Message: AVX 512 flag in drivers
> Message: ['-march=skylake-avx512']
> Message: ['-march=native', '-mrtm', '-DALLOW_EXPERIMENTAL_API', '-DALLOW_INTERNAL_API', '-Wno-format-truncation', '-Wno-address-of-packed-member', '-DDLB2_BYPASS_FENCE_ON_PP=0', '-DDLB_HW_CREDITS_CHECKS=1', '-DDLB_SW_CREDITS_CHECKS=1', '-DDLB_TYPE_CHECK=1', '-DRTE_LOG_DEFAULT_LOGTYPE=pmd.event.dlb2', '-DCC_AVX512_SUPPORT']
> ```
> 
> The above is correct as per my understanding as the test is to compile for avx512 ISA.
> But When using `ninja -C build -v` and building for native build, I get
> 
> ```
> [1741/3539] cc -Idrivers/librte_net_i40e_avx512_lib.a.p -Idrivers -I../drivers -Idrivers/net/intel/i40e -I../drivers/net/intel/i40e -Idrivers/net/intel/i40e/base
> -I../drivers/net/intel/i40e/base -Ilib/ethdev -I../lib/ethdev -Ilib/eal/common -I../lib/eal/common -I. -I.. -Iconfig -I../config -Ilib/eal/include
> -I../lib/eal/include -Ilib/eal/linux/include -I../lib/eal/linux/include -Ilib/eal/x86/include -I../lib/eal/x86/include -I../kernel/linux -Ilib/eal
> -I../lib/eal -Ilib/kvargs -I../lib/kvargs -Ilib/log -I../lib/log -Ilib/metrics -I../lib/metrics -Ilib/telemetry -I../lib/telemetry -Ilib/net
> -I../lib/net -Ilib/mbuf -I../lib/mbuf -Ilib/mempool -I../lib/mempool -Ilib/ring -I../lib/ring -Ilib/meter -I../lib/meter -Idrivers/bus/pci -I../drivers/bus/pci
> -I../drivers/bus/pci/linux -Ilib/pci -I../lib/pci -Idrivers/bus/vdev -I../drivers/bus/vdev -Ilib/hash -I../lib/hash -Ilib/rcu -I../lib/rcu -fdiagnostics-color=always
> -D_FILE_OFFSET_BITS=64 -Wall -Winvalid-pch -Wextra -std=c11 -O3 -include rte_config.h -Wvla -Wcast-qual -Wdeprecated -Wformat -Wformat-nonliteral -Wformat-security
> -Wmissing-declarations -Wmissing-prototypes -Wnested-externs -Wold-style-definition -Wpointer-arith -Wsign-compare -Wstrict-prototypes -Wundef -Wwrite-strings
> -Wno-packed-not-aligned -Wno-missing-field-initializers -D_GNU_SOURCE -fPIC -march=native -mrtm -DALLOW_EXPERIMENTAL_API -DALLOW_INTERNAL_API -Wno-format-truncation
> -Wno-address-of-packed-member -DRTE_LOG_DEFAULT_LOGTYPE=pmd.net.i40e -DCC_AVX512_SUPPORT -march=skylake-avx512 -MD
> -MQ drivers/librte_net_i40e_avx512_lib.a.p/net_intel_i40e_i40e_rxtx_vec_avx512.c.o -MF drivers/librte_net_i40e_avx512_lib.a.p/net_intel_i40e_i40e_rxtx_vec_avx512.c.o.d
> -o drivers/librte_net_i40e_avx512_lib.a.p/net_intel_i40e_i40e_rxtx_vec_avx512.c.o -c ../drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c
> ```
> 
> In above log I get `2 instances of march`; logs `-march=native -mrtm -DALLOW_EXPERIMENTAL_API -DALLOW_INTERNAL_API -Wno-format-truncation
> -Wno-address-of-packed-member -DRTE_LOG_DEFAULT_LOGTYPE=pmd.net.i40e -DCC_AVX512_SUPPORT -march=skylake-avx512`.
> 
> Question-1: I think this is not expected right? The `-march=native` is populated from `cflags` and `-march= skylake-avx512` is populated from ` cc_avx512_flags`.

The above command is correct. So long as the compiler supports AVX-512 we
will always compile the AVX-512 code paths for runtime selection. In
practice, all supported compilers have AVX-512 support, so in reality we
have the two scenarios you tested:

* The target architecture e.g. znver3 in your case, doesn't support avx512,
  so the meson.build file adds on the necessary flags to add this support,
  i.e. that file is compiled with -march=skylake=avx512, which is the
  minimum ISA that gives you the necessary support.
* The target architecture, e.g. znver4, does support AVX-512, then no
  additional flags are added and the files are compiled "as normal"

In both these cases, whether the target architecture is specified as
"native" or explicitly makes no difference.

> Question-2: if the target is meet minimal ISA why not we use `-march=x86-64-v4`?
> 

Good point, that would indeed be better. I'm just not sure whether it is
supported widely enough on our compilers. Do you know what gcc and clang
versions support that target?

> Note: I am yet to check for cross build. Will update on cross build how this comes out.
> 
> 
> 
> >
> > Regards,
> > /Bruce
