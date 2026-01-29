Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28EF6D6100C
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Jan 2026 11:43:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9431640613;
	Thu, 29 Jan 2026 12:42:35 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 92E204066B
 for <dev@dpdk.org>; Thu, 29 Jan 2026 12:42:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769686954; x=1801222954;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=IKRPCluh4FK51VcoZqpPPlp5htsvVuNIwmeGmNBUQG0=;
 b=TNEFi9/Pc9RzFEekWCymA+d3F5VZ23Dwqri6L3lUo1vlQCjfj5ziEk6B
 3qtBMtaQSWWh/RkJ5ZmoI09v9tYO4Nh4Hwpt0tYWEAC6vvli0ATTRvsie
 IWpKbb1Vl1LQgqGWcekKgzNW/mndVtzWHCiczsoTB7dglJw1qtn/Y1aND
 4hSioOGLk5/JNOOTQgQ5Bko6hDV28JHH8EsUrdWYJoRMEtSr+bzcZ4v5F
 e5sR1VJoyJNGk+FbqKXwWadaGerlgXHrHRP0x6uUZO3WKM4dB3w8D3tnd
 5maKpQCUh3JdLcStMJ2BBvDhZG1lIEIuRzXIeV/FNjTIx1/Q5/5JfM2P/ g==;
X-CSE-ConnectionGUID: 5sAa7oL0QMK1wPeLHlUVGQ==
X-CSE-MsgGUID: W28VEZzpQraC0wkopPwzhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="70976036"
X-IronPort-AV: E=Sophos;i="6.21,260,1763452800"; d="scan'208";a="70976036"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jan 2026 03:42:33 -0800
X-CSE-ConnectionGUID: CtK/jmNXR/u0jGOIujgBOQ==
X-CSE-MsgGUID: NU5gAPkjS1CweBYl0K1mHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,260,1763452800"; d="scan'208";a="239811212"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jan 2026 03:42:32 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 29 Jan 2026 03:42:32 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 29 Jan 2026 03:42:32 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.71) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 29 Jan 2026 03:42:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F75/LlJ1Uijof7pjgv0iUVYfrU4Qmj8cSCWFad4s15EWFYVsxcLj7tN39r1VyWIMDLnl5s7qqGTan1j8Ii+qRfIoNRLN17gxYqHwUqfwr7gof6NYvEwVVEM7/3p1d4Y+c58J07rPKIlIkAjH5TNyuKBtDrSrv8flnPq41O/7UBINVPAt2IpSiC0UN2bk6+dzXIWFbcF92OSvoef9898t27iy2XRrd3jDXto6wUtt3FeG5Di90J+M/7l09wIE8tfS+YodB/I5JEnVOv5dAiGiFLFxpBY6/b1ktJf1TOu+j2dbXp6UqCNfq8VMLxMwCyMaFfCjhRsuBAehdQnNJv+s+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wU/j+Xz7fgfeGMzHYJ+qSdjNFr5Tba1ryfxcYqdui4k=;
 b=lDCCBxr3SonoIvVs7msqIOAxeBAQx+jQVxi0+D+Ohr4+E+dw8eCKKq0za1SZAiHkJxUsAhYD5jA/ce9ZRTQc8WV4eNe3L5fEonAJpy7JzC868Y1KvdjSneBqQZLthaSW6CedQvMcgR1lNQI6rsGQ8EPyRDMusBGwRp6KZ4+eHpknTKv/rGobl01dTRpekbg9hciHKhdWh+tC1ujhr0h0vFhIJd1jRrk3NBP2ii8/0+6ZMqFp6zX79kFTQB8BwBdmD201xzfscWBoKAG8eTaYf7UWBb+Kzd0VnWgk8EGgXnK2cjy8QKHmEr+uYWsgyoqjG2vGv1cHpkcbDIIaM9IyxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH0PR11MB7446.namprd11.prod.outlook.com (2603:10b6:510:26d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Thu, 29 Jan
 2026 11:42:29 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9564.008; Thu, 29 Jan 2026
 11:42:28 +0000
Date: Thu, 29 Jan 2026 11:42:24 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v2] net/intel: improve Rx descriptor ring size checks
Message-ID: <aXtHoIRVwkkvfZbv@bricha3-mobl1.ger.corp.intel.com>
References: <20251215173543.1707960-1-bruce.richardson@intel.com>
 <20251215184342.1722960-1-bruce.richardson@intel.com>
 <eaeaeb1b-16b1-42ed-9bba-69357833c9a4@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <eaeaeb1b-16b1-42ed-9bba-69357833c9a4@intel.com>
X-ClientProxiedBy: DUZPR01CA0048.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::17) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH0PR11MB7446:EE_
X-MS-Office365-Filtering-Correlation-Id: c0e1659b-a9ba-473f-70e1-08de5f2b7b0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?M/mc8/o9GrA70R5TNH5Doo+LU5EYgV09Xt9/UyilYT21DXVApMv0YGIwsAc2?=
 =?us-ascii?Q?atpXSN7VMBrpGRc301MFroRZ8K20xkhv/0S+7DfW8FApzkHpECp3AFJmSK7D?=
 =?us-ascii?Q?5z7fUUJewReGfvJLtf/eC0QOmj32o3YPZNYL4o7uvayFtIPcYqK3dQdjJrhE?=
 =?us-ascii?Q?Aa9VjGSQ4r1Ndm2UH7XCy1YkJLPKfLdMAzhefdaZT4wEGgGltJNehmwhGU1y?=
 =?us-ascii?Q?dOR0+Vf1ktLGlXRzAygCQNfYJ5z3eV0/O4OLTuNDlm9u763p4krwUt+iEHd8?=
 =?us-ascii?Q?+yZr3DBAQWO+iiZxg10x5wZa9628AeTFIDLJvwqwMJL/MQFOcSPjEYPWiczA?=
 =?us-ascii?Q?sN02EZme4ob5WhFmB5Hkc1BzzsvyEA6BJ2EW4TVOOghS2eXFz60Eh2Jg+Fek?=
 =?us-ascii?Q?UXq6Nm4v+/MrnwpUxWZBVYSHRYDj245qSBiSLasVW9kDe/t1B981kuAH7avO?=
 =?us-ascii?Q?wuZsWryaH9qqSR+isvxd/OjS5VsXTZGWGRtmh/qaezsm96s5i5cg4gqJwDMX?=
 =?us-ascii?Q?eDRZLBOFTKi3GBNNT22AuCbRpMI1M6nBojQO1S7bIIvQxWFdDDlYTI32OuWe?=
 =?us-ascii?Q?yzEfHG/bpCjDD+Nm3LYjELKt23HaKxOHgaOnZrwGP7T1ZqeEBCsiMxBjZVs3?=
 =?us-ascii?Q?J5mCYdtDPgeb+PGj8fr1dJqp3frB9fsi/QOR8CjhzTR/v2dEQC51iu3hIe0B?=
 =?us-ascii?Q?KLmQBl1cWCCYWGJGnt7iap3w4DrhZRkzrQ12oSVyBtiNdL/Ezw4WBEeUwjvO?=
 =?us-ascii?Q?cr7yXHdHL3A7o5Ub5zWeP2/4BVlBQNywfMJgsBuDbUCJ+bEspqMYOVsdGlZZ?=
 =?us-ascii?Q?LEmwJJRHD65vNFqPVnpwNA1K8Bjzb2gveekPKzJPpCPIaZIaxLLUj5Q7Zbpv?=
 =?us-ascii?Q?dQVXolsEva/3XLOaVV1ECygSHOJiaOAT5LSjrxePBzpmm3+VhhkTV+YtvbBc?=
 =?us-ascii?Q?EsB03Qds57ml9UhHhvyB2iOHRJGna5CVvWCB0mndylwm1nFT1iUouRYE1aN0?=
 =?us-ascii?Q?8GzNqbRpLPqFQzfRtKwOOMIt+2W1vH8tjEnr+bD1IUb2tGzzvFhAGP+NXz3J?=
 =?us-ascii?Q?UFW/kVICp3t9Ags6LWzbkc1JUrXB2bbMdmAfrJgYCAEgYzXpAPzCzggv1m8i?=
 =?us-ascii?Q?IGjLcaOoovj07lRfnDCbD67YVmsmGpPSR2O54rk7n6OPByK+P4RBGtmc4GXJ?=
 =?us-ascii?Q?pG/bqP3SKrzyYrln6Gne/vD43MB0g7ersc/CssNzJqBRVIxMSuA3wVrQTF1T?=
 =?us-ascii?Q?WvQfNdxlVc2wYHnaPi9j+juyyE5AES4gvpOL82NCGQmNDW4Bvt91bs67fpT2?=
 =?us-ascii?Q?QgPu7NnhYlGHQ8vJQIRhtzSFvdtBHnMdyaGxpjJ5g0AbO3dMP0uqoIJNG5iP?=
 =?us-ascii?Q?yx6FMCXZiOkV8g6sfSuExjsMPEbPurlfSnv4LU2a2HxtymG9FAwgu3+vCHCK?=
 =?us-ascii?Q?TXgECzA37qe8OzRwjNIIp7HHmxk3i6c6hUTkKjOFeEpqkoiWn6rpqmkkzgWD?=
 =?us-ascii?Q?Y6nOfTeC2YZ0IJJzPGlcFayB0VGr1x0tjH+uCQZndegcX0+Vxr2PJAocSNg9?=
 =?us-ascii?Q?4rsxK5ODM4Norqzrgjc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AajRnyuVzHSEjRpV5qzmMu8I/cOoPUYVYFB4FwvhCZyhiZ7fvpBzQugdOR6b?=
 =?us-ascii?Q?6ASxt200/U9pPTwE5mrUbnkm7c+2YV2CVKfnoOexI+/adR75tsGN2J+TOHoj?=
 =?us-ascii?Q?TyD1I3Ta6k4VY6BYj2piNo+n4tRbqSYRnKnAJZ0hU+pYOrX9sZmjvN+MpK56?=
 =?us-ascii?Q?CYsWieRoZtCSXsENJP2JJh8BZRgT2TNmwvsLNR98Nyf2H/NfQTjFd41CENso?=
 =?us-ascii?Q?7XGw9DAw/4Dri78TPf9phuYoJeHPVLYp9nVQBMJtECn4SPJylig6wzm4mRun?=
 =?us-ascii?Q?lhF42Stz3UoiiJNThzSBtoBv0vXQIyUKLJ1ZMhpR4z4VOUeBl4yB76eY60T2?=
 =?us-ascii?Q?7Aibpf4N9dAd53HAHUYQep+1XAZKssozXkqseGQ9U7zFAH+feIUfpX6Zy+No?=
 =?us-ascii?Q?J1iRX7HXrFlYyRVuFEbUOgvM9XTv4X17vZPPh1Q3Vkaq3DIkusbqqR1OunIj?=
 =?us-ascii?Q?JuImtNDxGh9guD5gyoX7px7jnQo/XM4K+N94jllFFrK9PwvSLF+fcR4VuTUU?=
 =?us-ascii?Q?FQGOL8Y0H0k/AOlOxH1z1A8EiTHFLFly36pb5desErFfARq6ianuN+ZKz01R?=
 =?us-ascii?Q?MzcEUJd8l6RuqFqgc/tvtcX8rVjp+CxGh9JRxKiIInDMxXhsS+LsObslFzJB?=
 =?us-ascii?Q?H4iuEUaona58abh6OStq4aww+FqGJsqF+qB3NzUVrhLdBYHo1oiOMkry78hz?=
 =?us-ascii?Q?5dVOHYwmW5DUBO9XitEOG4UkwyirMrnes6MfeCMQnE6fELF1tOT6QDLVQ3+P?=
 =?us-ascii?Q?3gcwyzW0sMrokR43FhFHjI41IPCt4NoEy73zWMzUaf1us8mUfgTGOikIEn9y?=
 =?us-ascii?Q?8FaR0RAMjhsAtrSHo7OEQVqn55NJpunuSd4t8ERSWcAejkjsiYTBF+AugmNf?=
 =?us-ascii?Q?k+mN4yi9N4d0yBpglD41cD/xFpxTFpDin7JdiJC4hIVkqmWEex8Ayz3h7hzS?=
 =?us-ascii?Q?yc4GJM5OBgEFkRBEQPk3UN0NS45pVOgPM9jGzSrrkJC2vaG5FEDDvaWbBgvn?=
 =?us-ascii?Q?3RFOEbBrSqhOFe4Cd/OaAyGAre5/7hELZuz4NZGkVuzophNq451uCMtFl3F9?=
 =?us-ascii?Q?PkM7EGPby3GVfllEzs2p0fpiPd84cNMbV2MazFNXBaTuT6Dzm2AVAiQZgFyR?=
 =?us-ascii?Q?hkKjIXXpe02Xq5lViYZ/CMyqbjh/L9CFjPkw1VEqQozEtvsaXiV2kNmRjrkY?=
 =?us-ascii?Q?EZG5bCStGZNJNmKzMSFXJ1MtmAIDm7poShQSD/ahvTRPy9bPWheZciSp8Oil?=
 =?us-ascii?Q?ZWkp+V1d0baVmwTL1ncpri2yYAoeuZPvijYiR0S6qI5vOPzR2H8ACDNVtK5g?=
 =?us-ascii?Q?rely93qxHStqaxvn+X/OR+h3X4buoyZoLc6GlHkS/GJXmaeVoqDPAEbljShc?=
 =?us-ascii?Q?ZFk88UmRyL3n0U/ULFsyE0c2NdHHhE+otXnLdmd52NjmKlaMW8XoZsZ4Bt50?=
 =?us-ascii?Q?VllgTQGALop+JK9V7e4UZwhBmaoq0xQI02ehm2XIqPh0dmK/1fjhJ+TmLX7H?=
 =?us-ascii?Q?UQnRnSHLZxWmr4zBkfHDUAlaUV7djBx+WIRMhbGn7b5BXilePZACvErPduhA?=
 =?us-ascii?Q?TLiVOKxLWXMy0f0XNl9J1bqLuW9R4T3ZvMKJfW73CmXZ56bxW7LtHjMFuXV0?=
 =?us-ascii?Q?cwQdq52PB5PGps7Ayc5ZCyD9Ye+zK9c7VCZKo7fwWniKftsJhEgU8ATxjhcL?=
 =?us-ascii?Q?+pF4Bh/qmGUWNERswz6vuU+5mSuSBBTtRqNMyzfjzy8uKDp6rmwKX2Eo5LrC?=
 =?us-ascii?Q?XSRkjfSyVxeXkWzERkz+hezeuHloRvg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c0e1659b-a9ba-473f-70e1-08de5f2b7b0c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 11:42:28.6888 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KZVTHwfiHlambh42wuBpHMXj3G9D9Y1bPWdqEylJOY2ZTn9xZICJD2qnJTOGgka4p34S5DE5I9opg/7LmFf8ZQzmMjKnKZl/ie1nwsdy/tQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7446
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

On Tue, Jan 27, 2026 at 08:58:39PM +0000, Medvedkin, Vladimir wrote:
> Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
> 
> On 12/15/2025 6:43 PM, Bruce Richardson wrote:
> > The default Rx ring size checks did not account for the fact that the
> > port would not work correctly if the Rx ring size was only twice the
> > free threshold size or less, so add in a new check for this. This would
> > generally only apply in cases where very small rings sizes are being
> > used, for example, with default Rx free thresh of 32, only ring size of
> > 64 would cause issues.
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > ---
> > v2: add in extra error message for the small queue size case, to help
> >      make users aware of what setting they need to use to fix things.
> > ---
> >   drivers/net/intel/cpfl/cpfl_rxtx.c   | 10 ++++++++++
> >   drivers/net/intel/i40e/i40e_rxtx.c   | 10 ++++++++++
> >   drivers/net/intel/iavf/iavf_rxtx.c   | 23 ++++++++---------------
> >   drivers/net/intel/ice/ice_rxtx.c     | 10 ++++++++++
> >   drivers/net/intel/idpf/idpf_rxtx.c   | 10 ++++++++++
> >   drivers/net/intel/ixgbe/ixgbe_rxtx.c | 10 ++++++++++
> >   6 files changed, 58 insertions(+), 15 deletions(-)
> > 

Applied to dpdk-next-net-intel
