Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F53DCAC5B8
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Oct 2025 16:28:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7CDF0402E0;
	Thu,  2 Oct 2025 18:28:57 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 0B8B040268
 for <dev@dpdk.org>; Thu,  2 Oct 2025 18:28:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759422536; x=1790958536;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=y5Mu5aWm4l1bYbu8zGneKXz5645eVOt06sITWmm2AgU=;
 b=S/msf8Cc3CKcsQCv2HF05r4EGVFdKf+NU/j9+2lFx5UR2m/sj8znhMs0
 ICeBxeoEU8oDg3b3kT0QXT45h9+70C60Sufk2xdR6B436jgIDD09byfQB
 YkuJA/nbrtZKi5zMm/eh427I763ASciqnWvfUuQnQWPOkF3lHVcR07Yp9
 7VGKEAVV43+dXEWiVy3XBgQgDsuMV4doDc/k2l4S4dCRJUbvpekEy8T9c
 ASCzdUV5/sv9SA6YdtTmTnl0Xzx0O3YEbPUVmoBvbfcRxbbT8ckqrSOVW
 WpudfGMBWern1nxijqzj9rNLAAIaL6n8BJKzaogNx4OrrIvouOzwB7ctY w==;
X-CSE-ConnectionGUID: Jva4+skBQJOLK3m2bMAaVQ==
X-CSE-MsgGUID: HAQFVi2xR9qKfZ0pezOKFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11570"; a="61597562"
X-IronPort-AV: E=Sophos;i="6.18,310,1751266800"; d="scan'208";a="61597562"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2025 09:28:55 -0700
X-CSE-ConnectionGUID: SzqYeQUKQIiCp+46YGieIw==
X-CSE-MsgGUID: 9DQJW9RtTHSCnPaTrGXIbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,310,1751266800"; d="scan'208";a="209771502"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2025 09:28:55 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 2 Oct 2025 09:28:53 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 2 Oct 2025 09:28:53 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.19) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 2 Oct 2025 09:28:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s950fSeyTH5h2mXn+2jXwv9sVJnQOUsYZVAiK1AT3pNsphKtyUnBpN2cOuXgYrZKv2uKyyz3v5y7vxQ6cBpHXjLLFGV9bAg04GM67JSroxL6TzX0VqDrpl72rRhq9eRjKWVhbw74GXNAYKJWhJllyPbaGHWyOOtlz9kgwcct/n4fQIs3f+wgBX4rXrMTekQjJ1i2khjp2ZpGXseDiFGM0dG0gSafdTNPWn3ZN7uXw3kHSJF0WucC527LVTpGBxSYUM5sZCQJ1gMYAacRzGv6fTf2pcno1f7irtqycdraAy/3ZAyRECX+TM+orezDXR23j5w6nFSD+6RHQ1o0H2RNOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QpsnXufqjm5gkEKsY0/B7T5VTfD5RN2hq/i+/A7I/LQ=;
 b=he1r04USmLvwgYZMWg/mcn7acuAGk0/ryR/5beQ5uA1PHpRCyjI0fVT/IFSqETvwp77NJlRHX4GtkkqUmEJ7mIaFDLaqsqSOkTTXuj1Onveu7xI8HLpXy31mOjRSTJOJRxe0uZyNDajncfEFjLQkSloW/zuxSWrNFQ/F+oAXUhqFr9U6R9rg2Xlj2f9xNOURCjkCNKD0niTU6Sa+GZ8NPAzLSmkcpy7MlzQd5SuD2wMJNv2gBczPeF++eLjmSyo7qIWWHSFO/brxvmZ9RkS10SSQx2BDBITuQLtrM9rmZjG3tXUd6DuItnv3bxrjuiMX02QmJe+zVzeru63d+QPnww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS7PR11MB6246.namprd11.prod.outlook.com (2603:10b6:8:99::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Thu, 2 Oct
 2025 16:28:44 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9160.017; Thu, 2 Oct 2025
 16:28:44 +0000
Date: Thu, 2 Oct 2025 17:28:39 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ali Alnubani <alialnu@nvidia.com>
CC: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>,
 <thomas@monjalon.net>
Subject: Re: [PATCH v2] build: validate libraries returned from meson find
 function
Message-ID: <aN6oN155Gqcdnz8y@bricha3-mobl1.ger.corp.intel.com>
References: <20250923165830.527416-1-bruce.richardson@intel.com>
 <20250924111318.567771-1-bruce.richardson@intel.com>
 <CAJFAV8zv3GzBQk7u8qHjuq=Y6yu2WNuGCZMc0B=w_-PUsG1NOQ@mail.gmail.com>
 <CAJFAV8z9e9B7BfwXRr_H76sm_5kTGyjnv8MaT5NriBTykbyQgg@mail.gmail.com>
 <54ffb23d-0720-4dcc-a6ee-9bb1f9007670@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <54ffb23d-0720-4dcc-a6ee-9bb1f9007670@nvidia.com>
X-ClientProxiedBy: DU2P251CA0014.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:230::15) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS7PR11MB6246:EE_
X-MS-Office365-Filtering-Correlation-Id: 509d0070-7dea-4e16-5a9f-08de01d0c120
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ev4D59HarsfkHnaucxLUkc+ylskGziBPhE/uz+sGfdircpvnqMEvHC0lHufk?=
 =?us-ascii?Q?kVotaa1PYJh2kGtlPfo43PfyujvUiVlNBbiTvDGLpWcp6Ztuf6+wMmSo15hz?=
 =?us-ascii?Q?85PwdPSIrNBjib1+Csi7K4ZWv7fB3A7lrn2d92FbxXFzmYhuqnmGdyffhGi6?=
 =?us-ascii?Q?daDcd8yhlLds1Y6JR0lLdu/L99EeGDlMJ5CJ0oNnf6xEvd3PkDInW6ym4mJs?=
 =?us-ascii?Q?7swvLfK8DmqcnHp8lXhGrf+7FUaqq51R2gIpc0baWXaTnIgp66WB9/wF2JjA?=
 =?us-ascii?Q?5UAYWh2OPNcdXVQgTFOvYJl1mP3TmHk0BWc6umLJbvyBtFgbelRgvGz5KMjM?=
 =?us-ascii?Q?jcNGyAs3O96gO+xufadJoNrxGtLlHf3gdrhoDSrucvyAefqpl8NaISWPMPeR?=
 =?us-ascii?Q?DE0Y0reALMETDGKSwoDlqSRdcwQwSUnTO6tC3ZEvgZX463IC1SRt6q13kZ7J?=
 =?us-ascii?Q?w+Mxpr2a7pg7D7ufeZY1THhhDRRQhpWM/VlrXxTBritU3t5s1QNQfnKh02c7?=
 =?us-ascii?Q?GptpPVQPvFLNwAKNa2C/D9xQ6bLXSWVrEmTemseiQK8Wba9J/sPJRqkVhGw2?=
 =?us-ascii?Q?xS/V5g5qaq8sb5AxkvNE6vM1JWTZefvbwUeXzjXFhlElH7dp1IOe1qPR8fwV?=
 =?us-ascii?Q?2GGgcXV+KVqGQVxQCuorqWPSHQ6D+dYhqdym2x9uoqvQtIjuyK29dCxAkiRj?=
 =?us-ascii?Q?xAAxyfCX+IuQIEIedR9xY11q28LD2KyWaFXcykAcONZgtVYaTUJSOSzeNSND?=
 =?us-ascii?Q?4VP2Ops+IRi231gkzS8hkULOFgaEyFPtI68AkEVtbowoE9mSyoVCqZfmCHPz?=
 =?us-ascii?Q?XF3iBYwIKdNMQGC43D3enM/VrYgnVBTm6r0UuZGEEG/r0Qb9lSAU4kr+baZV?=
 =?us-ascii?Q?qsAajJu5f6El0xVeEeMoMw5hEzcNRiwewyjTfNEi91SpuIfmgQ2NvpZm8l7U?=
 =?us-ascii?Q?rbR11HPR3WJS1TS57EAQS3OwMoVvV7QvrKLsgfwwb9ojNDnvm61bTaYUzGGQ?=
 =?us-ascii?Q?K4x8UWoRYGsw2ujolZ3DKnxX4SvNMdS1kMiUhJiXAUJVXUFiu1e/f+fwntB8?=
 =?us-ascii?Q?Dnu7z+yfkFVwP8+oVulXUR3LCIhN9yGNk5/Ro6aNK17Qa66B2HqU2s7BdmPS?=
 =?us-ascii?Q?Il/+52l+T2jDQ2cH8wGh9sJV4ce/ka8OqIdDHOMROviqA4D+Eo7Dzxwhz7zx?=
 =?us-ascii?Q?5GCrWQVRAHQFMFcl5DZdKdQxjU8twh4mbEkzLOPlw42GipOtn/NT2ci5uTfF?=
 =?us-ascii?Q?pz4Mcg3JYyQDOx96ynnyX9i3gvE/q+tZskIx3u0Va2ziFO94ZA9//b84WZSZ?=
 =?us-ascii?Q?ljFjeoBwO4ovowYrP1so9Heo9uu7aGfKwMvMJ2G8TCgl/vhLfEKnBIjk2vJ7?=
 =?us-ascii?Q?5G7JCEaCihPksOu8fWssM+GLVvsgTuH86skSJA4Hh6jIVr1Zyp1SH5V2scW0?=
 =?us-ascii?Q?h60zn9Xm6deibyB04gPlsmr9lM/OXcbs?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BoIiapLTwGxKQHamM98nS/SU+Jmcqf9tV1oFx1iMBkh1Oiki/aWNLd/VoVkM?=
 =?us-ascii?Q?5IWva8cQX7wZE2HEtSlGo9PAK20f+0CDn15VvMbEVbG5trSClnnzc1imXFPS?=
 =?us-ascii?Q?U2ReWs1MrkLu8rBJ/oxRm957atX3roFP2wSXMiBJTNxkjtsvfrogj2mKbcXS?=
 =?us-ascii?Q?6jBPDzFyUDQHAinMIzwJ74aNxNje9L6wcBdIiK23ppJYgG1FEs/JdZYKWSe+?=
 =?us-ascii?Q?FltzDAgkQ7D9zY1wRQ5wWe60jcMJBFzIMV237xUrYu8aBIc9tebmpGJ6jQNR?=
 =?us-ascii?Q?Ji1ipLJtEs/0BpwR2xXDHNkXZvy1sKjQAXJM/Bj43DCHZgj4nkL8Agd+q1xj?=
 =?us-ascii?Q?idXSuV7eGxnz4LlNiX/+i7apGL0ILOtX1tsM7mCUax45Me2kwL5qFD0EaQPX?=
 =?us-ascii?Q?J/mH20nJLiHbNiFGk+Z6M+W4MSSOOx0FUfKs2kxiX/du2g7W8IlpSuk+tqlM?=
 =?us-ascii?Q?kvS0SfnzS6l6HYhSKLUosUDwKeNlrFgEAN3hwQg7t6Q22nP8nEMscJyBvK4l?=
 =?us-ascii?Q?WJFN4ae0Alo4o0fwy5booKKsA3ofysuVZdkYXO3NWazVhzTaSO0X0+I4MxOD?=
 =?us-ascii?Q?SpPjh5rNsPPuqDRU/UbuEtA15rPbXrD3UdhbzP5457X3P3RJJ2wiHT3wsjSw?=
 =?us-ascii?Q?qub4Ka5/8SPNebKyfzD8LweD7vT1zi8hU9qTY44C9Ok25fXixu9UjMvYZo9W?=
 =?us-ascii?Q?R3oZJQYuC+9qd96ksTm4kEqGfl0I5LecPiISuWzblbj9/3GttNfVtTC9Rb4c?=
 =?us-ascii?Q?97CD8FCOaSsNXVnQtGcDsKwPMmXSZIjK28iebwNuK83gkHLN2BKldSZHJShy?=
 =?us-ascii?Q?Y1U0eoB5nqbvM+DaFjdrWO95ZOQ1H3DViLlmMw/0YfxnFIdl2n541rBKg9Jj?=
 =?us-ascii?Q?AdLyWsN97+x7QeKKnv8yxRiLCthgeIIb9KuQBrSPYIO5ZKXeAp2j2fQfKQ9u?=
 =?us-ascii?Q?fnPvF6/nboU9uandRcD9+yMOqDnX1vses5NxSoUNMEWACtfq0coaR+sONM6c?=
 =?us-ascii?Q?pR8tq5HzNEMDPLWoIx+Hn3xawIZ9EGlThxT/meK7Z1bAQuX9fUoqcSXJv7mt?=
 =?us-ascii?Q?ZX6nyeq5RTR+C7XV0r8VC4eKiEdN7GPrmX+EAiQCiohyiqzudWi1RnTvkCcS?=
 =?us-ascii?Q?vTLFQMxyEKv0UmXNRKZ9MyHO9HGs7m1tLW2RUWwrSYThHGPQB0PXC80qC2+6?=
 =?us-ascii?Q?t0RUWciXbekc9CYfEdSmrjcvhl15x5R2GT3OIDkIpLPeo7IP6/GgtCeZDGRQ?=
 =?us-ascii?Q?USdhl+SeKgEQQ+q9DaCTXpXH4cDEgMFeA8ZMxxoXaBkmgwd/g5a7viwbSZ4h?=
 =?us-ascii?Q?d57mX/YeXHQoJaPCWkxUfKSsrU+SFXiFAKJ6UaSpXdxdHOJG9u6UlEhfFmH/?=
 =?us-ascii?Q?s97GddGGGsldmaTXRjvWw1ivPuOLZ9IkOWVq4PmsUoIaeimN7OUJPkq6KiHP?=
 =?us-ascii?Q?ZDGYPMwBODI5EuPyaDdc1areI14LtKWZ+GCwMP+ATs1XZHmtN78zz2mKq6zJ?=
 =?us-ascii?Q?fiU90Cy7NDFwRLL0InAOxWdmVGpHQFGJ/ZS9PTE5/gMGIvnEXtSdhVLophM0?=
 =?us-ascii?Q?G9k3M8R79E/H+7Ogzaujv4/i5MCU74VINf+MdGJy6X6YL00veQZhLoM9UHfv?=
 =?us-ascii?Q?CA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 509d0070-7dea-4e16-5a9f-08de01d0c120
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 16:28:44.0749 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3NJEb06d2mdaGiprIzCvh1ovFy5yckrI/pGX4XOeWJSIvXD+3ga7LeiPTHKqKsWd3sSZe301N79RCBL7BY9uptmXHygednfsn4E3a5ynxn0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6246
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

On Thu, Oct 02, 2025 at 06:42:15PM +0300, Ali Alnubani wrote:
> On 10/2/25 3:45 PM, David Marchand wrote:
> 
> > On Thu, 2 Oct 2025 at 13:54, David Marchand <david.marchand@redhat.com> wrote:
> > > On Wed, 24 Sept 2025 at 13:13, Bruce Richardson
> > > <bruce.richardson@intel.com> wrote:
> > > > The meson find_library() API call sometimes finds a library that is
> > > > actually incompatible with the current build, for example, returning a
> > > > 64-bit library when doing a 32-bit build. To avoid problems with this,
> > > > check each library returned from a find_library() call and treat the
> > > > library as unfound if its incompatible.
> > > > 
> > > > This checking is not necessary (or should not be necessary) for
> > > > dependencies got using pkg-config, since the .pc files for each build
> > > > type are stored in a different directory on the system.
> > > > 
> > > > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > > Acked-by: David Marchand <david.marchand@redhat.com>
> > Applied, thanks.
> 
> Hello,
> 
> I have warnings like this for mlx5 drivers on Ubuntu 22.04 with clang:
> 
> Message: Disabling mlx5 [drivers/net/mlx5]: missing internal dependency
> "common_mlx5"
> 
> Build command:
> CC=clang PKG_CONFIG_PATH=/opt/rdma-core/build/lib/pkgconfig meson --werror
> --buildtype=debugoptimized build
> 
> gcc does not reproduce.
> 

[Trimming CC list a bit]

Hi,

There must be an earlier error where the check for a library used by
common_mlx5 fails. Can you perhaps send on a more complete build log, or
perhaps log a bugzilla and attach the meson configuration output, and the
meson build logfile there?

/Bruce
