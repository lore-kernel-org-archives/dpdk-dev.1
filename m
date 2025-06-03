Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38059C5AE59
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 16:06:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5E85440E64;
	Tue,  3 Jun 2025 18:06:44 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id A9D5540E3B
 for <dev@dpdk.org>; Tue,  3 Jun 2025 18:06:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748966802; x=1780502802;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=74Q7qn7GyLFv+szvHTxw92/PbqK0ovqXaZZTA1ZhqmM=;
 b=mSI+YEVsvgDiL7ImCjplksg/Qd3FBiAa0O0+fhJiqnEHzldppRa6M1/5
 rBGUlj5X0wJNLDzNMHce2GgHJ0e17Xpd3RrosNj2vTI1ugfRpreSw4AcO
 7W+LO3H53xPyO4AEFoKP9YK4IKnxy4K0ElsLFe7mO92Xg6geGakl7fP/5
 3voKyjvjg6JpkhbFk8koKQ5hEvU38xOWG4kPxw97WUrRS8k5acO0VD8/k
 /HxwxMm+kEqICFszvYxnOp87QR/bVc0jg9WGbng+Z8y67JrjOopKTKPlu
 AGvgLnxmtLzicBzgJtaPAO53hWbhkMdk+OE7IKgNz3yd7IyE24LE9iAHl Q==;
X-CSE-ConnectionGUID: ZT79UpxeR++5YmSUXAaLlg==
X-CSE-MsgGUID: BNyZ6zqaS3OPLO2iVeneiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="68450303"
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; d="scan'208";a="68450303"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 09:06:41 -0700
X-CSE-ConnectionGUID: f3X47tR7TSat1gHhQ1wzpw==
X-CSE-MsgGUID: tGFcwRgFTYq8raKpYxusbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; d="scan'208";a="149790934"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 09:06:41 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Jun 2025 09:06:40 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 3 Jun 2025 09:06:40 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.56) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 3 Jun 2025 09:06:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BHEyTJeC2BGzkgYEyMTlb9/s/B1ugBxEInBjFWM0Sa4+fAuPMkXKGP1KuaTLKl3JoWycXVW0WvZ2tNxLV1td/sBh9wh7WkBX0upGc+PllvZ/vI77NtmXYg5YB/823v8C10LfeN1jn2bdXlhlc2p3NyaERzHd7K3C8G3ZSC1v6ksNcaMkcOAfzldHoGVJBH0TqOHOntPigRVf7gfU4KCkHzigKX8SqAdtTHQBJzYdnx13GjWgjfRQdCmNgQN9MtQ5mHtNoPGn5Ij3+YdQuggsIlVUOJ4CKb7GFvhYyUtvMjbV2KqI2NRwmCS3WIq/w/dZXjkI0Gz21btWkvBFWuDXdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gfiWw14UM7PBXQoYrAYIbp0eMslxu/BLkcVNiT/Qly4=;
 b=aw86qtIok5+AOzxXXHz+zs6VIFflP7S/aUgPSkiJZURR05HfBqHAVbXapK/XSCOuGKcoXIDuZ62JlHX7/4iUsOxn9YEU9Xp7+vswxrS3U3hkoblNujuF01jBKJwYc1zN2YDfct0R88TG59WDcmcDUm4MYsBe0djZkwhuG3HVDzwdVA11XqlOZEigBERumjIYHxNViDifK+PbhcIOnD0UV23WWYE8GNSsU1V08i8AMEYOolQg/E/NU7D4Qs/WilBLVKNDVyvvAOS/rgpt7HY1xMDJ1J9zNDfREoQrrqzC+QLdSSLZLwwPoa9aJ0GdHBFhE9Yd+qUNhT5XtchsBGqy7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ2PR11MB7619.namprd11.prod.outlook.com (2603:10b6:a03:4d1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.33; Tue, 3 Jun
 2025 16:06:11 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8792.033; Tue, 3 Jun 2025
 16:06:10 +0000
Date: Tue, 3 Jun 2025 17:06:05 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v4 08/25] net/iavf: rename 16-byte descriptor define
Message-ID: <aD8dbfjIrCcUzQBU@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1748612803.git.anatoly.burakov@intel.com>
 <cover.1748612803.git.anatoly.burakov@intel.com>
 <0165cc6e2a54ececf6c8b29aa6ac62ad7ff5fe26.1748612803.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0165cc6e2a54ececf6c8b29aa6ac62ad7ff5fe26.1748612803.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU2PR04CA0309.eurprd04.prod.outlook.com
 (2603:10a6:10:2b5::14) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ2PR11MB7619:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a84a6c1-1a14-4d4d-9dfc-08dda2b88e74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rmjzi5Jy/g89XEJ3Ak4R5z6JpJRiVSZ0CbT3lhnWzv+4rVT5wiWCOKaOjoeI?=
 =?us-ascii?Q?tonQ/RHzkmpmEvncvmaLNsFaJq0GY68/pDMBGLaBdaNjeOXFp4KwpDXU1A5+?=
 =?us-ascii?Q?+V/rAlYkWewQS+B4q7vG5KWWsGZuGgbqObHEyvqgF2Q4e1CmXHsNaFV0z/Aa?=
 =?us-ascii?Q?EwsccHA9HAsUpnge9koLJAh1hikwJ+lCjbj1eMCL1TndfFTbfD0G8iy+mf9U?=
 =?us-ascii?Q?Ztmqt7cgpk9uj4oaN1EUMymtik0lKTNhMBUeKyZPI0oDj2IFgP9gM8BB9bjk?=
 =?us-ascii?Q?r8UW7/N6E73b3Sq8ZHq2kY3cvUawCB1YmU8pGJVqe2i2N9Pod0x/4oyAN9WW?=
 =?us-ascii?Q?mrd2NpS4YIop74URa1y6C+CUpVjJpe3Fk15x5QUyyZVF6B0fplB3QOeMSSJb?=
 =?us-ascii?Q?u3LX2waC3o+yJAQeCEo96x/fuASwa7NPziX0b3nwV9Gb2J3NAn3M4NtIzkIJ?=
 =?us-ascii?Q?m5O5qYyLurw4FsO4h4/4gDrO3o8Fp30CXQ1q5ISemPiFhy+Wezt1lhlpM29s?=
 =?us-ascii?Q?Z56V24xACyc2c4+vWOA8T52cTUx1kt4mFFNhm/92GEXijGU/IQJrX+IPn+2z?=
 =?us-ascii?Q?3yr94gHkIJoEEfNwohjoR5vMIPq2yN1Z/Qlu2FxWnCDFQ1AYF9g3jDzv6G4m?=
 =?us-ascii?Q?8BvcAYL7Ee4q7ejcyHEDR42yyqUtqsoRmthPJ/uKRoPpY/Bwn8jH0R7hZFii?=
 =?us-ascii?Q?HLsNBvoU9g7hb5BZpaif+jhv6OsRkhKeGFSOZkstGWa8fHGbpYEXJe6tm3HH?=
 =?us-ascii?Q?MzQkXbpNK6/lfGIiodVQWf4BCcjPhoSMY4olYZTHSN1I/ciESF39Ac81daZF?=
 =?us-ascii?Q?RA3ULtxWtXRcNswR+jreouaH3jO66ZiPfuoX47AB55EqGQPT3DD9FuMuK8g8?=
 =?us-ascii?Q?IBGOcsDKxpJrNtrtgpN0EFXOBwUcb/sZwCC9gd2qVfitdrOYcDeH60Lf4Bdk?=
 =?us-ascii?Q?HqVkb0RDHNbPUVJd+QsNMOZ2VnWYTdW1LI8oLAZqfDLvgXXWb4oBZJRNqZjm?=
 =?us-ascii?Q?h/qSbCaLjesJR/Y9RgeMqBRfs1xIUKncCCVrnptmBxxazeCR7aY93X8kCG5J?=
 =?us-ascii?Q?qykU1bU9sdVBjV6m78SliiEjVjbsHJitWUDHFr/8qqDvTS/aTPYsMxKRECia?=
 =?us-ascii?Q?gqvR2jXkJK2LEAfNwLOXT4FXtENkQnQEjXrB3Q7t5GdAspSJeLH62N7vv6X8?=
 =?us-ascii?Q?LvalvNu7U0rIZE6ko9Qd/t6yX7nVsMU/TMMQVE89R+yj5x1aEWjf/uAgxxW8?=
 =?us-ascii?Q?gWOOGgzwhm+xf85AxzHFWEWi7BDD6BdXwLR6KGVQZ9GpfUJrKT2h150hc9DC?=
 =?us-ascii?Q?Ad028YoTEFKOCRar5Z3obiHAVEY6LQOlK/HsiNrlXQ/VDWtDG2bQFHjnRNqy?=
 =?us-ascii?Q?Sdp30X4Id8xQH4qVS0GnxlAgRz7YWKGujw58VVdkc33udshWTftB3z5Cls0G?=
 =?us-ascii?Q?TuEyIhGjY5E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?feD4ua85cMBRAx49mlkmhNsB6tqBwWLR2YxgKb8iXugnd538snVL2yEupZeI?=
 =?us-ascii?Q?I8cfY4B1nX3hBmIJ3JJ/P/2j8bbMx0DoEqxZH0R13hi7/S7CvkDF7XpCkLXa?=
 =?us-ascii?Q?XvJznezs3jliyeiLmpfB38TJi9tlAUzF8yb9BfswRqiIAJPGAIGHX7LNYkYZ?=
 =?us-ascii?Q?e6lEle/lG4L6Hj/G9IAZfOFX8XWWKKPNVrc/qHh1HqPmxGIqapvlQU6jOtQv?=
 =?us-ascii?Q?MJ9qqc/nG/RF/htfBQ/O2oQKkAhvcQVMYjNe/Y7Lqvc8vxfwS+8C2+3427DU?=
 =?us-ascii?Q?OzDEFjRZBg/6PCR7c2SF96RGolO5ccGcaaXy4ZCu9sT0r8OGHjs3TY+RUJNG?=
 =?us-ascii?Q?cPmZPwh7JOH7t1F8M2xCMHNDJvs5y8kWJhAzZvzRv6XtqPjQVuwuSqzlhOFB?=
 =?us-ascii?Q?ejIF6jbEoymcGVZsSsu+cR9HaZPRTvk9KvttBGSrxN5eKsDrD3tugjVW0aig?=
 =?us-ascii?Q?f9540iQHZtqAqstRYq/Vmwb7lTYj1NbQl3gqRa1wgcZFidM/d0pxxYHvCD9D?=
 =?us-ascii?Q?MiO7hzHbeHFKA7Li3Sr1++mgJC3F12Eakbn7d3Vh5vDCV5C/k57EpoPQjUju?=
 =?us-ascii?Q?cM5C2PT+C2oogvqFqq4t+XRcBVNbm5UcMpKFOuYC3le/CdTY+mDAMxMl7Td/?=
 =?us-ascii?Q?ALrqpmNJfcEjwU70rPlavdz/psup7KO4aLbzAuqH14ebmVau8zXUvCpejOmw?=
 =?us-ascii?Q?D/ZfHnWXIuAPKlweTxnE03IH37rk+quaPy7c9ie2Bkm11nQDa2RgRBSWITMU?=
 =?us-ascii?Q?doQJE/YqfZ+9IsRWbxj03FOCSCA3k1SX9eaxgnm4ca/fT/SEuwdDL524E8vD?=
 =?us-ascii?Q?XVhZDWuuCkKqBU+gtkSrtetyxE6KsH0i3380IoWugxgYAs0JZuWP4NW24J1F?=
 =?us-ascii?Q?ZmEZdWgE7Du+VTcFZcChZ120jzqk7vdWXMHefiYvD8s7UEsURNYGBhlIiDca?=
 =?us-ascii?Q?E1cZNx7gbvpofrIOmcrvQuP3rC0YnWg1KAFL1fM26/rAtL+dtUJyBGSPv3+J?=
 =?us-ascii?Q?wi+citlmSd7ksvbkNmTiTKbVogOdhrIlSSsRUneEG35mt5UkDjlBr3tCRsDU?=
 =?us-ascii?Q?4HUY9ysqGJZy0I/hXya2k+5ml39vsuV1dW/+x5ZjllC2slSoBlutuf0cgMZg?=
 =?us-ascii?Q?qtN3xjFL76F/tf5v/WwXbqHlS2pWqIQffnMi5jAi8i8HDd8Ncp+aLI3vDpIz?=
 =?us-ascii?Q?+kqadcST1KWL2MEuguX+4/nSezo8HiiH+1xvIBIkGDkJLhimF6zKCR3xyVbA?=
 =?us-ascii?Q?8iplxZ2comPc3OBMmryWVsS65vmzniB8vx/fBUiqo9GKcGj7I2iahQPMl9on?=
 =?us-ascii?Q?cWYIJ6FGAelVcFEAyhTJHBhE54aN5fl/QQdRhCyT6aynNKG25NaVw5Ongs8i?=
 =?us-ascii?Q?7kLsgLIt+rLFQ4rh/Ek6aBX4QZ/Wn8GoXXRQhe1GbMA6ogVo/CZHWx5o6x/P?=
 =?us-ascii?Q?XyOAXgjrOURN5c4AuTT88SxL8MuVv/ZjW3xCRnwi0bHkTIARhrv2L4M91Opf?=
 =?us-ascii?Q?qghlrBqPOh9pnh/42QOSaoe7aR6iKAgfSoWH2xUuPuLDcC4Or2uwa/EVvJdB?=
 =?us-ascii?Q?KnY3BmQa5DJnMSF9OB6A8hRQmJyU0qAUKUkKqZe2qEyvZWAgfURqaVG9/Q9x?=
 =?us-ascii?Q?xg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a84a6c1-1a14-4d4d-9dfc-08dda2b88e74
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 16:06:10.7061 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Y6laeYm+rq47tj5X5pcrqHKdSSE/YgwoOawiXZrF2EW8fQX9Wd8B4qH2AThG5Aqvni6Ssfkzy/kmwPMoBjxLKrE/jq2W2nN6oHE6ExtzUE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7619
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

On Fri, May 30, 2025 at 02:57:04PM +0100, Anatoly Burakov wrote:
> In preparation for having a common definition for 16-byte and 32-byte Rx
> descriptors, rename RTE_LIBRTE_IAVF_16BYTE_RX_DESC to
> RTE_NET_INTEL_USE_16BYTE_DESC.
> 
> Suggested-by: Bruce Richardson <bruce.richardson@intel.com>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
> 
While I did suggest using a single define, I'm not sure it's worth
converting this driver. As far as I know, no PF driver actually supports
having VFs using 16-byte descriptors, so this setting should never be
enabled in the build config. Therefore, I think we should just drop the
16-byte support for iavf.

/Bruce
