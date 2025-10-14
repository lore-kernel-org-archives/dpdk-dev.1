Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07724CCD184
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 12:47:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 53A79402CC;
	Tue, 14 Oct 2025 14:47:21 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 5A2BA402A8
 for <dev@dpdk.org>; Tue, 14 Oct 2025 14:47:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760446040; x=1791982040;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=PDox/YTKa50Gul78NFBW3XlaVyw9t9ihGhWmHqD9skI=;
 b=ergtgs4MLtNkpd7bP+7b8fEQTVEIKW8KxcU56K1RdJ3i4MS0weC5eIoy
 f9mypQvYha5RcL5N4ouzc/X/ZXjvHV9zsx+If40TQ2SMIYI8S5I85+5Tk
 Uo5F+pqEcY1bq/gRxOe06lZlS/GJnBLzpBiKQ6Zbj3cuNjkDE2wiygsYu
 hR0GqVxSfSbGFTIduHXYMWQbPAjMXWb5YgoWQJ+2rcEF3A0MogNVQ0Qb/
 Cxn8eDg7sT7cQJkT9X8u1FpXEtPD2T1xnDvZzwwwQ10LzclEcQv36HpHY
 Ema1X81rQAQtllleWNfuRwN7kw753EX2gnb4oV69VZCrJHAK01tyqbOjt Q==;
X-CSE-ConnectionGUID: cL1SVmaxRR2LnG0xdYoAzw==
X-CSE-MsgGUID: cZogqiTTTi2EdB4myiZsKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="66260288"
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; d="scan'208";a="66260288"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 05:47:19 -0700
X-CSE-ConnectionGUID: dN08Z38NR9iq4QeZeUvNcQ==
X-CSE-MsgGUID: kWqbiechQ2mRi60Ce26jlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; d="scan'208";a="186966935"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 05:47:19 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 05:47:17 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 14 Oct 2025 05:47:17 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.33) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 05:47:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wcoT/21BYm6yKToqZS5mHGvFs5ewULG0ULB423sczFqx5PQyLP+soj6PUFddtVUvjTBXqZddSK1EmSKvqHNK3Opxkcr/GNzSgQHzDjJnozIue2ehSruk5hyAvfJ2OZTd+hWcdR0Fr/QWfhPbgYRffxBi15Ii1FWwMy2gCTpCUeaUYUbejYEIzpperD+9k6ha4WHmu1tTr70QdggEiDn6lMyKKIBVJVTI/kcHqdw5pNtrRrVPEvjutzt37ooyeJe+TSwdGXj+YkCZ5SEmrXRE8R1Um4FB7Gvz21dwknVOxr0s38yJ5KwlqRwpqquL96ub+59STHzj+wkd5/QXJKmmjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bOkvGjUEGFYJB1aNxCzVtnGJnU3GjbmhtTkIPSoXSn8=;
 b=P1MpHPk6Mesj4KYtb2/O6I4do1WQj093rHvOlSFlBTg5sBBRHpF11ym0cnNYJChTF21e/bbR8IZxkI3Hx7m+DURLfJhV010Yqb9E4vhW10Te+vX/l7iQck43n4EqYocALgLUMXD5ZHPTSm2RuA6KhqBaGGdwzJANxh0eq9pF60Q8sHOLXhwwdCts9Ecz2Wa7g/Qu5/Yq89Pvs9eKwMNrAF3dED58zYdUQmJVntFKdBmJyXNx4v3lwVlTfDEC/cHrr0JhLg4WsU2edf2EPhisuMr3JIut3VyrSWsXIKk3+SCpEiD9f/WSzc/12xp5rM50Tje4PTFeMxXi6airI5pLYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CY8PR11MB6820.namprd11.prod.outlook.com (2603:10b6:930:60::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Tue, 14 Oct
 2025 12:47:13 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 12:47:13 +0000
Date: Tue, 14 Oct 2025 13:47:09 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Venkatesh Vemula <venkatesh.vemula@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>, <shaiq.wani@intel.com>,
 <david.marchand@redhat.com>
Subject: Re: [PATCH v7 1/2] net/idpf: add IDPF PCI class ID support
Message-ID: <aO5GTZ-dW72KBIrF@bricha3-mobl1.ger.corp.intel.com>
References: <20250919145125.113028-1-venkatesh.vemula@intel.com>
 <20251014104511.459215-1-venkatesh.vemula@intel.com>
 <20251014104511.459215-2-venkatesh.vemula@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251014104511.459215-2-venkatesh.vemula@intel.com>
X-ClientProxiedBy: DU7P251CA0010.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:551::27) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CY8PR11MB6820:EE_
X-MS-Office365-Filtering-Correlation-Id: f6711ea3-0430-4192-865e-08de0b1fcc6d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?T/e7T9TQr42rLRlJfmvgmuOaUhxlHeWI4UOhS8+4M1u+EhtoVZFPM+NKUQTO?=
 =?us-ascii?Q?Zf9sGobGoxrnz3JFrzmHytbTpmY9th119IL9Wu8S7vePoKZ3Fjjzz7TiZ9ed?=
 =?us-ascii?Q?U5vacadjJFSAIBWCPewt1W5UgZqJrXUtqHrWpeC72509m4PGoKh37oXzQHYn?=
 =?us-ascii?Q?9w8AVg7OILIZUaSWUl1pkVufnRgbfGJA/ss3wgfc6gc1dASCMWHHsRmJU3Hp?=
 =?us-ascii?Q?gfoCHqnW5pCc6fF4X3EJ6RIcG1R4n6iki6wUt5fTADX3BDk8zIERxzWrtu/V?=
 =?us-ascii?Q?AY3tU6lBMoafQwZaiy2/v7B5Pi/5dO0W6zS9LO9V1Ix+S1YYYEsrcFHLllk9?=
 =?us-ascii?Q?M9UAJtNMKdhtXP9sQxurddEo99RHvOd8k3NYEVAo5F0OutRsB288xvE4Kd5b?=
 =?us-ascii?Q?DeuhvhDWGtAe50MYyNO+CHB+DwpSfYWqTQnz+0AA88+I9COA998D1yeuXKjw?=
 =?us-ascii?Q?hLbDV7ZN2uSOnXyHDeUkZmFI4EmB1j0BX+mxKi14QTsNEPIUSb2dRUIp7UjT?=
 =?us-ascii?Q?lBW6I1ITxyFKM/tUXRyOJ91chyTl1WYPJ7lDq1MS35kvCOg1utQ8pImkID3a?=
 =?us-ascii?Q?cDkEmD8zh4FQbqwd4oQocm1GpeabOvqtF/Sjhm9iMqrRRFpRc4MRBzLK6+SL?=
 =?us-ascii?Q?nPsFDjQIfqYXOrZ8t1rzzjTOLoi5o2LjWPNs7lSnaTxHXqizWvCKYkH2bF2j?=
 =?us-ascii?Q?HG/n2okxmTN7kKZ4ecAOlUhxNs+gD4Ksig+CdoJ2srh0WTi8cSR/DSFRyEJl?=
 =?us-ascii?Q?UuclPhSQh7qvPyUZzEEkHU+UlFZoWAHTItUdhSSrhpGFDiY4COVAUlBo+PL9?=
 =?us-ascii?Q?+pm7PZUFMiP1x5+VaZ3emkV46m0WjaQH4edclwMc5BoJWwrwaPsg/UmnsFWl?=
 =?us-ascii?Q?YlMtTq2FByz3e6r3tYgzkp+2mdfo+gzf1ULo4+2648k0cR7CcKIhudaJ7wM/?=
 =?us-ascii?Q?UfyND2SX/u/qalFhuD21dLJLEFJEQU4YXFHoBAXqbce7qL5IeRwmsU9rM44o?=
 =?us-ascii?Q?icF/y0GdWFjmRpYsNAJgqI9h61kWCTYJTTrLUsI80XE7eD6Jf2mxdjkT4Bex?=
 =?us-ascii?Q?rnYeeINYfck3cT4wTMEQ08n4oc0ugsHg8fGIv0GS1EyJN/+PqvtIOR6ceMLT?=
 =?us-ascii?Q?XicdHPUhNE/JvG+KrryaFKxZVBKXDthesDUNMG/oQ7HTsG42nRzVCmcTrGqG?=
 =?us-ascii?Q?sV+2pbzyT7BUehezXmlsCsHRw6mc1VNzfFxIH2c72dPBvo+4IwGrVMr83UGR?=
 =?us-ascii?Q?63HDW7b6evMfPAkDBGTq8tZqNr6YqqBWo9A5KCHWPcv2uue1mMO60ZjkjAkk?=
 =?us-ascii?Q?jzV11X1CDDjXlQAsbFwCt2TVYDgOTgMRhC0wADP4JdfFCmsCC2/3KN9WTaDl?=
 =?us-ascii?Q?+qziOiL5CyJ5ZxSkM3Gw2GJskaZ5AwK7+1hKpYAdVpcUHgfR5KKFX9yRnHGn?=
 =?us-ascii?Q?K0vUkI+nbq3kW/tTU1itnukCO1eI6w10?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ztuqNrR7qFhVzjNoHuCogqas7T1BZTh9jiXHnlaNhMHx0AG3AM3dzR5Aacpb?=
 =?us-ascii?Q?lQKJHBdckEILzc0/yqmd9OcBCOOadsd614BYW0Dd0NgDppUpeZPgV0yHJpj7?=
 =?us-ascii?Q?XLQprB8RJY9Tv/ZwS9XfSPf5m5/rn7khk3aIGMDgIIJNFfXsNEzWMjYJXspg?=
 =?us-ascii?Q?yyRSkIYKbNo15WcTefPuCAVyWPKG3sYREZrMCGUVZyICiJMIUi6T4Fj6LAJB?=
 =?us-ascii?Q?BsYQmGKRd66dfW4OoObR+uXS9iem3B6KtSlPUwL51ZvpDG5+BFGnHyeq+nJB?=
 =?us-ascii?Q?577h/OxeDIERs2Jgr9Uj4tOJ4HIykorQXj0LP9+yA8lAjE4QPpmiZbEgiiV5?=
 =?us-ascii?Q?Sio+qKKJjKGE0Ktglegir4c83T4PUKfPieg5vICXRXkO32ElIQjCX+V5E+W0?=
 =?us-ascii?Q?4MkH4vqqt5KUJFozbKQCh/mHQybRidz9qXxnQlnbWwhyYsue3AatVinPY1W4?=
 =?us-ascii?Q?0GEy3EV98OxhR+AvVVDwKXUCdWMiW1fY7TbjN/KbDJfCwTskXcd7ekdEBDrO?=
 =?us-ascii?Q?6tjrJw+l33NXmCb5YWjs09NA5car2nPPzfdSebmFyRUsgZO9WLX6At+WZpMC?=
 =?us-ascii?Q?Y4ujXR47oqSWzoPgeKD9UJueXv7JP+5BM/NOtaxKTAEN/04KIQAnr8ceEbp0?=
 =?us-ascii?Q?+Rv6Z/yeol0CJ0lWB8b2EU+IRPZAWalF9OriiFIf0y9aybtcC1djzt73XPgv?=
 =?us-ascii?Q?4DYnbY/5z48Wo3YEhAIEdqgLXlXRGg+mTXWNZC2bqEb1mCXj3j6xgaSnonoQ?=
 =?us-ascii?Q?mTVMT3a6p1W7o905gw6RiBKweu7uPSWA+g1QKPI7wcYDhR3o+gin9EOGRNGW?=
 =?us-ascii?Q?0OTGbXibotwLThnF5Y6gcZa9cK+Sbbg4a0O5FnnDAiD+4B3zkMZeCCR2G1EI?=
 =?us-ascii?Q?m4Ad/pxmeuC+017fo42T5FENOujzWaoKZ6P1qmIwRSsOe4pcu9NTAa3mPUwF?=
 =?us-ascii?Q?Nz0KrXn/ZA5Z1LAG7laCzY5jmoRhc2qYiitUM4H7cRWz80dsVBafT9jcyQ9W?=
 =?us-ascii?Q?A2LsnaZw+ZJUDNmYfCGdsCDtPUT0p6u8SFnAkV1Z+Cz63n8mIcv/lf76zA1o?=
 =?us-ascii?Q?6vt5VGLzngz+vsIAuIcqJjuHGpNZJhPPhKDb6hcMVAFl9G5kc7VLteCaTACI?=
 =?us-ascii?Q?Oau8CUKK+SfDqRWyK5zud1Ptm+v0F+Xh6VVvUC+KIPGbMi6kstN6qjQOIyCD?=
 =?us-ascii?Q?fGqcjGgELAwc1ISxq5j9bCV/BfbInt97iKAi8mjOBkPXc1BYwkLqNPOvhSha?=
 =?us-ascii?Q?cvKpjH3byy+z+qZROVWhaqTkwklLmQFCnfuju6Ywd5aoKeszv4QaKnZzHH1d?=
 =?us-ascii?Q?kh2kw7B2ao7IRpZk603AdIKgiYcf2+Mj523WhIqN3JJHOFaGiFoDWQodFd0Y?=
 =?us-ascii?Q?scSBo1dq03QhImbCW+eMUpzhmweoC8x7YhJ0Vvf3uPsaA8J8sijFb6kn10Z6?=
 =?us-ascii?Q?e7SOnW1ba5tniNDv90ccL9G7JwHGv0ZpXGTOHQY1dfjYHS2+zutxLSngndxW?=
 =?us-ascii?Q?ocqXmRQFXDO9rzKUQoEg4DZz7ABlYJBpUaqZPS2TwGa2CN6beT8aEc3kuZOx?=
 =?us-ascii?Q?QnCfWZw4R0OT/vpfNaFzolLjsKCTWWXMw4oxKNSxp3K5lglE/B3PyM4+s5JN?=
 =?us-ascii?Q?jg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f6711ea3-0430-4192-865e-08de0b1fcc6d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 12:47:13.6577 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Dsyp694KDRxPZUuUEYpM9/zP30NcZLVswoOyLrDe9rINLzlhgGSMeceqvbBPJgEX4yS1D7Cn2unizSDEwuhR4eMEswHIOzh0LQr6fIhsfo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6820
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

On Tue, Oct 14, 2025 at 04:15:10PM +0530, Venkatesh Vemula wrote:
> Current IDPF supports only the MEV device IDs. MMG has new set of
> device IDs and same might be the case for the future devices. Instead
> of adding new device IDs every time, make use of the IDPF PCI class
> ID(0x20001) to differentiate between PF and VF.
> 
> Write and read the VF_ARQBAL register to find if the current device is
> a PF or a VF.
> 
> Signed-off-by: Venkatesh Vemula <venkatesh.vemula@intel.com>
> ---
>  drivers/net/intel/idpf/idpf_common_device.c | 20 ++++++++++++++++++--
>  drivers/net/intel/idpf/idpf_common_device.h | 18 ++++++++++++++++++
>  drivers/net/intel/idpf/idpf_ethdev.c        |  1 +
>  3 files changed, 37 insertions(+), 2 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

