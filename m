Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC4C109C047
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 17:09:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 884E2402CE;
	Wed, 25 Mar 2026 18:09:13 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 74A864028E
 for <dev@dpdk.org>; Wed, 25 Mar 2026 18:09:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774458552; x=1805994552;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=Jdh+WryTajRxj8lTnHmRsOKgYE9GbNzD692/c5so/x4=;
 b=mFcKtP5mMtmnbiPSCttbQP9FtmLHRfBkRarrfItFz2pS/lP46KZ7htV4
 e9bfhQ2u9WpC5XtLAj+SKJ3ggxwCo3mYzdrsMFKLTZTWQXC9hGpBUw3Dn
 BQO2GIoOyN9ZDVO34OoC9tJWtZAZa997U9dUJIHMIq/4AXhyKT99eHIKP
 zAS1zkZ5Dh4tZVJwb9A4ykAPJ+5yyK8mM4lqocxxAIbFSt+AM+GvlBCgA
 NUh7S2tLYGd89K3Yk1ohL+/pZxD/tAEipUn2oj+b4Ups7WHu0PljU8VDi
 kPNpeOYpThtufbziiAhiZl2c2Bdy0rThMdRdyKmPIyTNZnPQUGZGIkqZH Q==;
X-CSE-ConnectionGUID: z8BV26i0Skm0OAYF6592EQ==
X-CSE-MsgGUID: rRqZaO4GSjKwmns9azL1Xw==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="75524045"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; d="scan'208";a="75524045"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2026 10:09:11 -0700
X-CSE-ConnectionGUID: dmiowKo3Q52FjkCpsyyLxQ==
X-CSE-MsgGUID: MgfYzp4VSy+wqf5CsY8KSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; d="scan'208";a="220339242"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2026 10:09:10 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Mar 2026 10:09:09 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 25 Mar 2026 10:09:09 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.31) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Mar 2026 10:09:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FBPBPgi0mmcnvizbUvCcbUld8qafc9vQzpywqormAT9MJ8A0y6cu3wjsBup7JghvPJ7xnuXA1FAmZ1A1+twUl2yymQ63THQHXbqdtPyb7lKo2laWCw0QpaJKd6Db8x1htfzxXpnk6WSBt3yHOpqq1JTbMh2o7x7wO/mG0FRbGtNaHPpRDcA9O57Bu4CRn8SU6SG1pdT45EGjz9v2vBp3hOCLZsJKdgGHqMj+MS0PvosAH/DdfxuEdhQr1DXJLQUnvrzUPL0Insmjh01yQlHthE/reP5cVVPzfE/tZF/9OoIOp4XIi9GiOR+GoGLpoNaA4ebAyasoYtwVsFX3d1FFaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sktnJ7hKR7lkdvAZvyYmYTRlkbhzhzMomulm8ObJwm8=;
 b=fEpi/5psIOaGUhFykSKV2lkDgcTs15OJb0BLpmKjzHeNfpCsEeUlbY1i6F/Zj9GMnXY5LnFcFztvomgZL3G4HboSGP64pRJYrs41XtvqJhJDvH0bv4hnMcERYfHZWRWlz9fFp9Ln9/xw0UqE8kFhW5qZSMoZb/D4HiA3hkUppm5pRmANj2ksf7Xwqb7lXzpwhAQdSfWLvdC0YQYcZoCdsnN9HlCNf3PB7PmrNLtUwPz+J/3WMaGZCXLJllgZULW9rkGWlf5ksRPQN/mbi0WrH6heV9peqFmMuEJJ56cYLe9FzrQD9HKucOFS8YnaginiFsqlIgTzBmp+22NR5t+VmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS0PR11MB7736.namprd11.prod.outlook.com (2603:10b6:8:f1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 17:09:06 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 17:09:05 +0000
Date: Wed, 25 Mar 2026 17:09:01 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>,
 <dev@dpdk.org>, Reshma Pattan <reshma.pattan@intel.com>
Subject: Re: [PATCH v20 25/25] app/pdump: preserve VLAN tags in captured
 packets
Message-ID: <acQWrYLymtruPoRr@bricha3-mobl1.ger.corp.intel.com>
References: <20260310161356.194553-26-stephen@networkplumber.org>
 <abgi0O1fWFqYIDP5@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6579A@smartserver.smartshare.dk>
 <20260324101209.04ffae54@phoenix.local>
 <98CBD80474FA8B44BF855DF32C47DC35F657C2@smartserver.smartshare.dk>
 <acOnBrH5VGJNz5CC@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F657C3@smartserver.smartshare.dk>
 <20260325091921.687599ec@phoenix.local>
 <acQL1eLeTbsnHuPp@bricha3-mobl1.ger.corp.intel.com>
 <20260325095237.612a3d96@phoenix.local>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260325095237.612a3d96@phoenix.local>
X-ClientProxiedBy: DUZPR01CA0005.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::9) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS0PR11MB7736:EE_
X-MS-Office365-Filtering-Correlation-Id: c11df67f-6963-4425-e1eb-08de8a91387c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: GDoxO4r5MJKRo9cE3G4j6G+QzSm5irYexzmphFDMJjsudGOBmlCUZ6Yttm3vOG8rJTnWI5JXvVVuoagdkEJyUisZbbVMDs5r+IWOFwzfVyWWqf5dl9OcSPdGIvfO1wUGfwD8L5+jI8yaSUTfYldIzi8U8T2iJ7kj0CShVkZwr9o1h7zHZL//t7yE+t+yW7wrgk0LfupUVb6+HjIxQxG4lUX8yLzPLsUuixunNae0ZJpJPul2tdV3pEDjsZThphvRcLe9JqYrvRH+D5qTr7QF+M4C8Biyd3CxRYsXWbHYBXhdb1t1+6lqOwxCcfOdNLGLWoYJgowoPW3XbQTuyTxK6GUsQtNZQDJ+jwCe2mpguh0JIV/PgU/dqQXLbwNzF971I3DFLecruzlIXtYr1hzmGIyPFVPtZzPNmZd/k1glVhqB49J9cG8XcUcXFGDraKxsoU5tZZcWsnOASLC1k6/7zpsp6AZNhlnnVJFI85pal04qfZcNVYQBSUctcPMbogok58xUC+1x54tNQtVQNrnv0MK8OCRYzbaEzAIaGZbRj6MF9YAYKInlZNcXfzismTaT+wD3P7xqjJjflbOFHehY+ZZntnt/ohZtbrHfeoXu+a/wrZbnzr6dbj6seb50aC1Go7LDYMCKeFvU03Wfgfnwm0c+5+F4UOge+Vc74aglaN4IANXr+NdpmW8R3uVm2nucZsln948XlHvWonvcHvEKNvtk6l6U7Z67Q/4ZgO+WVUA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?5kIAlpdw6a3BKLVOz+iPGCelt08bxmzWq6YiQuXGhzvp8pWdyW7U5FU1ml?=
 =?iso-8859-1?Q?OJYpA1sL9WnOigL5e9PNIGyiDAgVzDgpDiFCzgUMYJE2sChMW+gkEW1HqB?=
 =?iso-8859-1?Q?6zJicHnZiiuVbHM8mnHHm0uOACmUFtACBham/KUWzAdsxUeui8nmQUjYV3?=
 =?iso-8859-1?Q?7V498gL/ys07sTv0G+m/EOD3XY0kBGWZbFMBGOS+Pz9Em7A4hFhyzYBp6t?=
 =?iso-8859-1?Q?/CdJEWJ7iDHws0DzKuoj9ZeUW22Akjni+Tble8zu5hPwCqw9aQWyV79fyJ?=
 =?iso-8859-1?Q?306NzpmlX8eMZASk/P5I3Y3FVh6cyZEFovIqcKCmJh6ybBHvTIr5Mu5R1T?=
 =?iso-8859-1?Q?5KFPG1BbWeWnk0HnAa+r0TwYjYGes2+NdU3Nfk39pV1x4ccUwaAltnVjIz?=
 =?iso-8859-1?Q?0Ge4Q+gCkz/8D0Fbup/gZcY4JaSqIHgom7PIkRhneUGIjQAvLVT1ryNsTO?=
 =?iso-8859-1?Q?NvG9A+Y5b++GkoYp+/AId889a0TFzCaIleFI+GyNE4f50bad30hqhk+CYu?=
 =?iso-8859-1?Q?1E7gOKg+rohwr1pl+v1qEL1XxLlA4dsEZc1oHGLOpMhhMDwZfVisoR1mf3?=
 =?iso-8859-1?Q?pGeP3+52Qiz0cRwZicJxAzuFKJLyazD5wUjIvy5CQYhub8Muj7m+0gmogr?=
 =?iso-8859-1?Q?c6glSGr2EwpAqCvRnZsc3fT9mXZAUMX4mqD+wNOiZ97fhFqmBs2nQkF3Ne?=
 =?iso-8859-1?Q?vbrOgDfl2qsJ79vRzasmfSNFFFSe0GC+nMShi6huPpPBH0kJLdwue4R+o1?=
 =?iso-8859-1?Q?uo/TGxUjfTEnspiE7JO2GEgktSx3zjAAs+n3cRLmfNVsX/9yytk9EzhMaC?=
 =?iso-8859-1?Q?S+a4BZiUMDktlh7Hq2KsOVHVDcyIUFH889IqprpfWaHDatIZeew5ooeE3m?=
 =?iso-8859-1?Q?DpwGBYR8uiwtk7IOiHqBTRNEqJRSG5LYNLaZUZCjXHv5cNp70ihnXZSoVO?=
 =?iso-8859-1?Q?WGIEtt2nn/Ws0CCbXJPQZBt749B3Jljvixj00I+aa4KynfxzvXtfmWbvuD?=
 =?iso-8859-1?Q?IaC4rRymvGF+jNH7VYspubNot6A+svKIVDZQ7POGFx17QbnWrVrR2IG1N1?=
 =?iso-8859-1?Q?+sbV6gC04Pmis8UacmW1b+pv3Lbm1qpy1LWW6KgsroZKXQsVoRiEKblszF?=
 =?iso-8859-1?Q?XDVeOWSD2ZlOsCgbgU8P/OsHP2jXZ0LAQhhHdKMrXIe5yspGdTUlyBn2oR?=
 =?iso-8859-1?Q?gTv3hl8AyzBL9Vf+o82FuSIwfDS4OJrVIcIidPaDlpYKJjiyj02egXdR0o?=
 =?iso-8859-1?Q?FV7SwwIWL+Vsw6LQKgIQpDIxdhSY96dmDIchodsmlpFT/WW2+Vh1XBXLgS?=
 =?iso-8859-1?Q?xGOZSmKBBIe5j2cLqX0qc7vkF/IkKtdlfJlD8uYEmA9epWNaaUWlw1ATJR?=
 =?iso-8859-1?Q?Z5i79+OxjOZ6TbwK+OY+3iMt8AeiXsXxHIR5/SZvjLRKzhThy/P7KsUUSz?=
 =?iso-8859-1?Q?ektF6jJAyuj3yegrjZvyPeptJK1S+j+Xf+B7+vOJbLy0EecX/w4Ith9kuu?=
 =?iso-8859-1?Q?VAYOD6ClVxsbdd8XKeKdBy1IXzYnprXvjEqfGR9EKGq0jpBYhtq+WJSVUC?=
 =?iso-8859-1?Q?hdHfmvCCY2npTZ9EbS05z60lg/+GqqI9574hBrrOovBjoPmtKljhv8M+cn?=
 =?iso-8859-1?Q?4sIbDCNXTwEvBRW18mPHrO+pOk/YcZ2pkttOFj3UsoHhyIDzEH5gOxdCAZ?=
 =?iso-8859-1?Q?G5zl+y/hMI1Rcjy4JEf10+Uy0/NC9KU1ITwa0+gl4cMkuECwKlGwhy9BMX?=
 =?iso-8859-1?Q?tYMmQe/deVWz7lIQ2ycgMX2sKw+BH5Ly9YZ7/XyK70AfMu9scTKCMO1XWN?=
 =?iso-8859-1?Q?DgxiVnvFtQ80VI/xUPYLI7jxfzsAyoE=3D?=
X-Exchange-RoutingPolicyChecked: YoUKLrqwyTdX+b2930a6tmcjJEQ2Ujge+/wNyxV9ywzOhmOGtmyDZFI9GhfqeIAO8T7kVEonajhSqnvNFJ4LaldFlX3dCXCXXBMroGYAiZuBYL7obO8+PBo4+wQ9eid0c/iznbMSQdrL6jHpjVlQni7WISUoGNzH89PNuxHDwjYyhJgkiz7EEnmf/PNVVH0sSnePvxwLcpgV+Y8eBDRhYz7s4Jp7sEHXGe2/RANt12IQuHnbnRUa/Qw7srd340tbJ635xCm75gtrrrRbitvaqYU9cPr0wgjGGNfQy3LsJoIO3kE09v2g4YT7nPkyXj8pVQCDrfR59fuJQ3Qy1hjIXA==
X-MS-Exchange-CrossTenant-Network-Message-Id: c11df67f-6963-4425-e1eb-08de8a91387c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 17:09:05.8351 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PR79Quzc2aOmklJ7JvBLOCOZNmB0YUwZ8tlu5GBaOED9brqgh04Fh8lZA8l6lkBxrt90Qks3H7cNealULoElt3Hw1xF+e4HYK+ncpANUa+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7736
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

On Wed, Mar 25, 2026 at 09:52:37AM -0700, Stephen Hemminger wrote:
> On Wed, 25 Mar 2026 16:22:45 +0000
> Bruce Richardson <bruce.richardson@intel.com> wrote:
> 
> > On Wed, Mar 25, 2026 at 09:19:21AM -0700, Stephen Hemminger wrote:
> > > On Wed, 25 Mar 2026 10:36:56 +0100
> > > Morten Brørup <mb@smartsharesystems.com> wrote:
> > >   
> > > > If an application clones packets instead of copying them, it is probably for performance reasons.
> > > > If the drivers start copying those clones, it may defeat the performance purpose.
> > > > 
> > > > <brainstorming>
> > > > Maybe segmentation can be used instead of copying the full packet:
> > > > Make the "copy" packet of two (or more) segments, where the header is copied into a new mbuf (where the VLAN tag is added), and the remaining part of the packet uses an indirect mbuf referring to the "original" packet at the offset after the header.
> > > > </brainstorming>
> > > > 
> > > > Furthermore...
> > > > If drivers start copying packets in the Tx function, the Tx queue should have its own mbuf pool to allocate these mbufs from.
> > > > Drivers should not steal mbufs from the pools used by the packets being transmitted.
> > > > E.g. if a segmented packet has a small mbuf for the first few bytes, followed by a large mbuf (from another pool) for the remaining bytes.
> > > > Or if the "original" mbuf comes from a mempool allocated on different CPU socket, the "copy" would too.  
> > > 
> > > 
> > > The problem with the Tx function is how backpressure gets handled.
> > > Not sure that it is documented well enough that if a packet is not sent
> > > due to backpressure, the mbuf in the array may still have been replaced.  
> > 
> > Most drivers should be able to check for space in a Tx ring, or whatever
> > other backpressure mechanism is being used, before modifying a buffer.
> > 
> > /Bruce
> 
> Not in case of drivers that need syscall to push packets.

Modifications will have to be rolled back in that case. Alternatively, the
driver just doesn't offer the offload, which is IMHO a perfectly reasonable
approach to take.

/Bruce
