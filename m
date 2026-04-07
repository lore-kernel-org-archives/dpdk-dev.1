Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254F0FF5110
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 16:12:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3353C40293;
	Tue,  7 Apr 2026 18:12:56 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 4DB8C40269
 for <dev@dpdk.org>; Tue,  7 Apr 2026 18:12:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775578374; x=1807114374;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=/7Zpu2yy8zx9241pXV8CDQYx7jJZqgamL6lE6tKPN0U=;
 b=ixwEp6dyTDz+veWFyr6QXT2WxAatsrLerRXt0NYi/xFMvGpWDIgQnEnO
 ASc+vOeTBqs0pN3+J+qpvb0kN9h1COdDCU28h/6xLxXwGWa62KVfgWLxO
 BHyGlYBa2rWlQUXDZlcjR55ihkpQj9ZxgVcVpti6goqKgDV37OjB4mLpZ
 PRolaCpRfvPLVfwK5nWJpQ1yEBaUBJQk7gPWiIIrgXIEciW/SSFJZqVTd
 LObYRhQ40Ogw95HH+u936Cvf34C5nTVa0ppbfepnCR+HRcmyRNsOK8fOt
 8pbKj6e6/DVALRCXTwYSfn4JfW+EtzjFPjxvAxYIFwxoLDG61igqFUYAk w==;
X-CSE-ConnectionGUID: K4yk+3J5QaqdLfTQGCZQRw==
X-CSE-MsgGUID: H0FNZ+RjRhqis5uTbVPTCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="87250597"
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; d="scan'208";a="87250597"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2026 09:12:53 -0700
X-CSE-ConnectionGUID: thn0UPCLRZS5RZhkSWKwHw==
X-CSE-MsgGUID: 1bfwNbw9SDGXYjEIJ5rjAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; d="scan'208";a="225453499"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2026 09:12:53 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 7 Apr 2026 09:12:53 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 7 Apr 2026 09:12:53 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.24) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 7 Apr 2026 09:12:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L4mnqeRPuuKY+EIxA/iE1RGDht9tV5W7ZEKmoouPhwq4Dk2+8t+jx2ajAQOp9z10SQmfGJ9WBg7l1L1haWbCqw77UgdaOmG+q5+aJxDGzCGR2NiJjS66vaontu3ANjhEb6fRIwt8gPC1bNYYBxAzaByR9h3ZnbXlefk7ksNzJgYAhnNnzl+271kk6l9wN93FeQyisuibxtY1YoGrqvCM2NUaTlGY2M5F2AHYVSllD2llQsL9NCbNzMIYs/gVc0N4PQKjVP7koHaYVl/cLHGcPBbis9Jb60aSqh+4bqa+51KuXMMAMolTGFBJmLp7XUm4pYd3PgI5vnJR9YW8bPeDiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1OGoNEspAGBL8EnAgdg7jsX+65s73jd8PepM4ZwUUu4=;
 b=Kxw/ldU/QnNYsPsN7fJtYcYCQiv9TOKk1qQxqway1WXeot160itrj3Uq1JTIt4SYQvfbDCzCatXJetM0rzQL+g1psZk2hze4iVDlvsr1woA2LlAWMzwJ2+h4QbWkNXrWSYTyJmYNjx0csUnulChVQJXUK0T30wBQcUQG1THSMVKjcGT1hVf8W7yC395+1AmWoDPKi8OVP2RoiPxmVZuXyVvSVm2zeMOoTBbYHm/TJoVBfnFK3fy6TbWROzfZ7HcszzpmY4F5FYsnMuar5rqfx3oimS6nLiy8um9iZdtVy/8oUoT4lR+s2eJWdneH3CviWS4sT8UlDM5GHefuue2+Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH7PR11MB6745.namprd11.prod.outlook.com (2603:10b6:510:1af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 16:12:49 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9769.018; Tue, 7 Apr 2026
 16:12:49 +0000
Date: Tue, 7 Apr 2026 17:12:44 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Jay Wang <Jay.Wang2@arm.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, nd <nd@arm.com>, Paul Szczepanek
 <Paul.Szczepanek@arm.com>, Dhruv Tripathi <Dhruv.Tripathi@arm.com>
Subject: Re: [PATCH v3] net/ice: add NEON-optimised Rx/Tx vector paths
Message-ID: <adUs_MMCPqx5HpVD@bricha3-mobl1.ger.corp.intel.com>
References: <20260324162525.4083381-3-jay.wang2@arm.com>
 <20260407151225.1416270-1-jay.wang2@arm.com>
 <20260407151225.1416270-4-jay.wang2@arm.com>
 <PAWPR08MB94460AB72013149B1E1CFB66BA5AA@PAWPR08MB9446.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <PAWPR08MB94460AB72013149B1E1CFB66BA5AA@PAWPR08MB9446.eurprd08.prod.outlook.com>
X-ClientProxiedBy: DUZPR01CA0019.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::10) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH7PR11MB6745:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ab989ff-2e3f-4009-d0fc-08de94c0834a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: 5e1qrvB6vAtjWsOnBkAchJR3au84SKpSVIs+C90mlpesKjNGmbYU0Q+JpTQ449k0j76KyFYM18m4IADKr/zDooJ3SBt/6um6rzlB1uxRD+8EFJkKylBnQsrGm7jbOMj9wmERjzbO9/3PFH/wQCpLL4I3QGjejT+Rj3oyac1cVZ9mfyAR/WM+crK6XRwiUjbN5s0nlMbQNBJxWCPwhk0k3czw36y0iHcRGeCdIKd7iSTATlnL4gwmFqE81GrR8zPFsqrcE3kjl5EQE0LojQGk9KPd9p0M8RGGxqkL0emKX10c3nNSYSu2DQq7HgLanXZBtgK29mTWZSLevdQRB0tfcd6fwGFPhUQt9DzhTymAa3Nx2Fg4MFJqn15t2LMwPgVhgm/xipLXOU437JnNCkTamZnCTkPAcGS6MA+FW8dBlkvU74dBmmwncg24FGKWQcgPLaTmBIWOuwRdmEIkPo/16IfGbDrVSEzPsOjnVSg3RGSFrPbU6Egk/ZUwQFsi/gxa0VlW+yAmg5H06tLAbd4/V8Kfc9OgZwfYC/ZveXooyhB/WWGH4YsJUQup13sr0Qw2eNt3kDi4KlJjIfkOv6Srt2+qZ8J1RzjEPnLMcI+ihPJ7jHi7BCt6URd8XZIyNiwecgaKXbpOFcZbw4DZOO3UDhEbDrUdRR5deeaViN3kheczCAamPmJFym4ACi0isQX2wAzZRTf2hRcEn1/VFjfdkJJftl6rtA05EGRksBqbKJk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z+CR6e1nE4LhGVNMcv241kwjD+RZ1k/xGTqMUAer6LLFjk/a+Hk2BKH2+yrL?=
 =?us-ascii?Q?u9OVZTUPRPt3eMrXQ5HODYQyLkd6I2AF+yvZh5LdgzwLN3ejfX8ad6vPepk2?=
 =?us-ascii?Q?JVYFuNL4eyU1jRrM3R0is5GTh3JCv3+ovcNi11flsTt9Wucg2VEEVXWkTFnW?=
 =?us-ascii?Q?kL/rsBXgdqH55XMylgZrDChQ+VU1zHLWk5q6lbPURemz6sdRVXa+VoBgIQ2K?=
 =?us-ascii?Q?N3xhcge7iIWrElRSp8NXxkpMg/2yVWbXE0B9gMc45V0VA0/jOwJwqw5cuS1y?=
 =?us-ascii?Q?/sRBYjSn5WrwF7GgCcVIIzqZd5zApBvWilBArKYIIeGQpr9W5W0MyyucKu3P?=
 =?us-ascii?Q?ytG2C+eYXYOZKoYVaUUM3KTnxqHC+7tfsDAD167WD6jhMboAN8iTjPYc4kyt?=
 =?us-ascii?Q?nMWzbnvqwoSxNAOmo6SqpRG7eqBhzREddg7PPCVmdAjJJj7V/bgxLcW4foMR?=
 =?us-ascii?Q?wzGpFxP79dENuRRT9ZNGUsRsgCYkNV/ldC5K8vdHirWFZSBJen6z8j4oaPLf?=
 =?us-ascii?Q?+3Tx3hAj/Vehh/lNCLReqJK+NGOIy6aCxNquTQ24UR1aQGbIRd9bWyvnAFCJ?=
 =?us-ascii?Q?Vxp25Ekl+wYRRe6o6Ota11l56FDpXpQjtxCRhJUqIC8oyCnsU5bO6NmYLgqd?=
 =?us-ascii?Q?n1X2v9Mjia4jZGDdmLIGQwZSr+XlxzRztli7jN13+HqIKsRANekOptjLRAL9?=
 =?us-ascii?Q?Pk30kYqRtf3NRNv1ssfrY6KMuCL5VZ/QT9X0dfc4vnHeFddlIMmjUKy1yhyM?=
 =?us-ascii?Q?hFBX6kmYK7oQNVX5VROzGcCTTtPtGHQIgDlGY50G4KLwpAhuZBFoP/GUU1s3?=
 =?us-ascii?Q?IFMR6A0+F89nfEAkqmE2vyS0RQyXT5yZd9NJ0PuvjUySAimV4qKd04qMr9XK?=
 =?us-ascii?Q?MxKlRQqIOANWbnE1Dlv6GWvwmwdlt6GLgDXpcXUbXDqwW1okur6W4qpOeiC+?=
 =?us-ascii?Q?9KagbV/VVGo77S7XEjtpjo3ubFQbdcKdKDb7chFBYUV7F4lHnBQx4ZUxU30G?=
 =?us-ascii?Q?e/OweZKJvimXZLSLgIreTKxX3ECgwFdbOFwG6VM3EIYMKN7FfjmSM4WCpF24?=
 =?us-ascii?Q?Wg5lInxh9dCK0sFrBYN+UeeBCpAZm4M6SNXYapNlXvCEVqh4XmitfonLdMJD?=
 =?us-ascii?Q?9Qyv0wJGn/JjF62ryoYueOla78oAGrjSN2tU5jGS4MTkw0Ye+1FTb+D33Jn3?=
 =?us-ascii?Q?tcLZ+USBXaiZWXcsSPYaY4ClPWn4SdRdGMdKMTlh/9foxGy9w0L0nSmW1qaJ?=
 =?us-ascii?Q?6RM2buaxAQFFEGarEbld9Z3xvB9umz5p5K67a5UF5CbxRyEg4Zr85IFoSnT4?=
 =?us-ascii?Q?VfPrDFyyWHL2I0jsXf0o2G15fCCkKFoFdrAkwr1JdvXGHAs2Mcp4L0Rf3TKw?=
 =?us-ascii?Q?5BaMZVdyZmGYbWTQn4UE4LLnf68RZD9WfI22t6AGDDr2A2ZkAfhZGisyo8KO?=
 =?us-ascii?Q?JaWlVDkqqF/14T3Pe/qPWDmzlbQrzHkwHajGmDF15mVdV3YPR/CIda1C8Ts4?=
 =?us-ascii?Q?1/gEu+RfNKqVDeaqkJd4E3YIwu4ORcfcunavsOUEXwt9GSzcmpi8ERkwh2/h?=
 =?us-ascii?Q?T0+hGacus48nTKiUjX4D4u+e0/5K/ctOEZ+NjODXD4zAcAs3Rm8hjqqyGuvS?=
 =?us-ascii?Q?nyCFW/pIHgVi5QE90YuJcqNv7OI3AVfn9yFY1MzLx8e0OC934M3OLGysFNbO?=
 =?us-ascii?Q?JlUD/bzbBePzWpNGpYNksWWtr8y/mD0Bg4v50xg4EFBeov4sXbYWtmEGSZZ3?=
 =?us-ascii?Q?8Hpvv4S20Al+KEaA27ZV8enBj1+EVBk=3D?=
X-Exchange-RoutingPolicyChecked: L2Jqqe4OByfc75CvVygUEODErVIM5WMtzRYMMx57H2WfSTBm/BHrb2srqCDBT1+CTZAJLPGdBcS9A+/I31SbJi4YFi9Y836UBNy3Ur7+yE+jWAiza5P0dIZRgfp9bPbZ+4r0lbwyuBn++rh92VI8BB2Ru0w5rdNrRcZM0B+5VCRLP3YFgZscIU001ocDWlkT7FjccoKJtBYQ1mqmD6yb3VIJQi6W/s2EkcQWxrxbVloz78JZlLUs/5PcfaWym8pe03BAx72fQX/MiPqT5T4l2jYk09mxufkUg8A05rEAz3D7qoVWAl+I2sAbmTna4SS/GHPG9A/lrKuKtnXTXIEgIQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ab989ff-2e3f-4009-d0fc-08de94c0834a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 16:12:49.2397 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p1Pf+4y5i8iv6VBQpDeLmksaFfsZYKSl8y5uoCS/Kw+49ufr4W7sOWyLbnkROZ/BRFBXb+etut376zPRe/qFjbBd3ZVowNU4IeEmWIK+hPw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6745
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

On Tue, Apr 07, 2026 at 03:42:29PM +0000, Jay Wang wrote:
> Hi Bruce,
> 
> I think it would be better to restrict compilation of the vectorised paths to AArch64 only. 
> So, rather than modifying the intrinsics as I proposed earlier, I added an extra check in the meson build configuration file, as shown in the following code snippet.
> Could you please help verify the patch again? I also did a sanity check by cross building DPDK for AArch32 on my local AArch64 machine, and the file was not compiled, so no build errors were reported.
> 

The CI should run this patch through the various builds and report the
output in patchwork. Once that goes clean I can consider merging the patch,
and if not, you can submit a v4.

> Sorry for duplicating the previous patches on the website. I've marked them as superseded.
> 

No problem.

> Thanks,
> Jay Wang
> 
> > diff --git a/drivers/net/intel/ice/meson.build b/drivers/net/intel/ice/meson.build
> > index 293577676f..a205304c89 100644
> > --- a/drivers/net/intel/ice/meson.build
> > +++ b/drivers/net/intel/ice/meson.build
> > @@ -33,6 +33,8 @@  endif
> >  if arch_subdir == 'x86'
> >   sources_avx2 += files('ice_rxtx_vec_avx2.c')
> >   sources_avx512 += files('ice_rxtx_vec_avx512.c')
> > +elif arch_subdir == 'arm' and dpdk_conf.get('RTE_ARCH_64')
> > +    sources += files('ice_rxtx_vec_neon.c')
> >  endif
