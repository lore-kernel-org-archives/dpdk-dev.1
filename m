Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9198C3ABCC
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 May 2025 12:14:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC252402E5;
	Wed, 14 May 2025 14:14:51 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 67483402C8
 for <dev@dpdk.org>; Wed, 14 May 2025 14:14:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747224890; x=1778760890;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=sQhHyhkSckrC67klMek55LJn5yJRTbZ4GciC14XL51E=;
 b=iUWxc72tzKWeDOFjQNni6fH/RkTS+NDTHchvGa8Lt+wqIWg8CNgtXwnB
 uJ5FlqATFG233E/WjHrCRIXUts6lM1uFGUdM6khp/ZN1uVvB1P6OgGWPe
 gLD0NDxngQXR8s0jMfkwauS0Sw1BP9LzZeX7txsIwq2fAKjL/b3CP3pYO
 dVnagwEyR01sSYQs4n66eZH10SyR5iHX7Q64kVXI2n4+APX5+9U8ZxIaH
 8KD6pEuXPTerjMxnyMvLklVCbR42uuhaHDT6+x06qcTkSCB8OdlDcrHJG
 ZfEshWKLuEbNPvkDf9XRDaXF+8ao0UkVqUGWDJpTrc1JWNsaRZKhuvxSF g==;
X-CSE-ConnectionGUID: BRSURsVvQwu95VfXlSOArQ==
X-CSE-MsgGUID: EXbrZAbXTgqMmLd0oP1Qxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="52789682"
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; d="scan'208";a="52789682"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2025 05:14:49 -0700
X-CSE-ConnectionGUID: p7Ssa7+YSOeIPZF3733B8A==
X-CSE-MsgGUID: Ep0p4rRWTYuc3PwW56pBYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; d="scan'208";a="143225316"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2025 05:14:49 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 14 May 2025 05:14:48 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 14 May 2025 05:14:48 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 14 May 2025 05:14:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Su/RbTxGlDxE+3fxOHfZ7+2NiVn7ATI1l4xHLI463zSjkBMLSZdJU93aReMhm5q6pY5H2C04oxrqtkTgCgtBiMxzw479jwwM+zaayVeFMo0el3JN9KtTSZbixr0VHQX5mLPWEx90dgAx/DwxQk8ZtHDaW4mWUWS1OHh3MujMKH/J68Gt/2fCjDuE5J95ZbjqXLn1gm9vGdNXwuLrRbP+4dch7kNDJ7QDUrSUs6Yje1725uSdDIuzNMK8p+KW8tuZ0oz8opMVukbl1L5xeh72NBnoI0Uc/gK09Ja3ceMRiolX2WBo2xA+dSUeQ+ChxgWMkIORCjffvnxKoOgt9NOvfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N9PDIzAIhv8fYfbHCXSgsT6JmxSeRpZSl3tMAg32oI4=;
 b=hQ+qZmCM/UpM5dHGVuCHhfs6qK1RABsOs3LhnsQ3XbU23NbbjF7MVf7Tnuo6sQcWHeT8VeVw8F3AS+f1ha3PlSUJXobenGrY9IcerMdyX1TdeCGsGPaqQjsCVIvSHDAOsw9ZPcqpWTYTfF0re60DVq6KhUvFRdgvGY/nLpfeU8wJ0hRqRrzbRQEw7saNdxKK+R0AnGOpn570X0lOMnn/FqHrWG4REViGIfuvLUVsklQxAkdo42eHNjAloEe6BwtbVDuAHGWfS1CRS05pRvfmmeNbwbRnG8wgujUfZLz4FtjE0pDLps8O3beN2uDHqy7clm8fI9ObnsauUi4jcIS+0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by MN2PR11MB4728.namprd11.prod.outlook.com (2603:10b6:208:261::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Wed, 14 May
 2025 12:14:16 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971%5]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 12:14:16 +0000
Date: Wed, 14 May 2025 13:14:10 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>, <david.marchand@redhat.com>
Subject: Re: [PATCH v4 3/3] doc: provide examples of using lcores EAL parameter
Message-ID: <aCSJElU1SXiz6q8H@bricha3-mobl1.ger.corp.intel.com>
References: <20250313113829.1480907-1-bruce.richardson@intel.com>
 <20250513161710.410000-1-bruce.richardson@intel.com>
 <20250513161710.410000-4-bruce.richardson@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FC50@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FC50@smartserver.smartshare.dk>
X-ClientProxiedBy: DU7P251CA0020.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:551::22) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|MN2PR11MB4728:EE_
X-MS-Office365-Filtering-Correlation-Id: d4ccfcf5-a1c2-4c45-024a-08dd92e0d821
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?LNt/s0AaLi28OfBc4PirA2ireR9ZMYtk9vEhQEanAkmP/EXviWcMx7Dtf8?=
 =?iso-8859-1?Q?ouKragwiIQC8hTKA+gqkv7E9XrV7SuwM3PDCjDZb6XfX6w7tIIGZEOK8D3?=
 =?iso-8859-1?Q?RagPWLrOJDzCkTYUi6vsLEHzut0QXU+WSDAdb0XRKTASozehCkNUliUZFK?=
 =?iso-8859-1?Q?JaNQo0DZXyMrFhxhZhGtOOL8n6PYae6staiBkfQam59qi9oXNP3hy1EiXd?=
 =?iso-8859-1?Q?Us4rBBqVkPHnI1/Fe5F3xyT5FNzOEwhLEcBtd2lWaLoIta69T/XRCLbDZA?=
 =?iso-8859-1?Q?ffiLxZZ6pzwuAzt4zbRBsFH+72OrnPFBWi1ukLPKQZZy5xPcrzaLC3ut6+?=
 =?iso-8859-1?Q?WxKizPJubNdRSfqKi0HsGMBMNtMFh4d/+N35F5XtRxLUGiEEvYPEpD1mBo?=
 =?iso-8859-1?Q?2Ec1WjEl/1Jd53B1BNglcsqpIyypcVBhCsLEs5uikqUZ9BudWJYQk7OeQj?=
 =?iso-8859-1?Q?Bvuz07WAMSRNvTI3P9ABvYthOplllbLe8fN38AUvlbRuOD8B6gcjMPi4OO?=
 =?iso-8859-1?Q?8WaGMok0ljK6FwxsV6wGESYmsVw2xhAzlh66TAwFTm5wGDbDojWcBHUtRL?=
 =?iso-8859-1?Q?4VmNnEfyB3f9MHjh7OETooJZOe5JBMSqncyMpXak3UdYaSDaVHZGcHQ1Dv?=
 =?iso-8859-1?Q?DJrcSdaOCD+hHhLWKC82QTHxLI4K4UMGoTRn+eFvxS7RR5fvTM7W1Oek9Z?=
 =?iso-8859-1?Q?EFb6jjkqgU1iSrw+tMaEa6fp4rxgOV3fGYlko20ctbrNMiyvFHT6Ey/0ti?=
 =?iso-8859-1?Q?ePJBdSNIovi13iDYnTKoosxQibLndJg3D+lVZwrdYF+7gDM6zx7JQcN4Pu?=
 =?iso-8859-1?Q?/YM4odKU//dlayfYxTd4ElAxq8gZPHTBtdDqBd1uESP/ub6v5ajdpXXHTm?=
 =?iso-8859-1?Q?EAmRuMYeLtnntLdTJLnGsjTRl7SW7S+4gpWpoMJhSjF+GInZ01Gy2mkKG8?=
 =?iso-8859-1?Q?9xQbDaD4DWGwPU0QC1jOXWpr1OneioDXJaAP/oSDBCgYmIhKqXP6/oB8+A?=
 =?iso-8859-1?Q?953gKbZgEbCBYmJ42tk2adOe/DetPpsucwTT6Om39rV9kdkDfeiu4bCXio?=
 =?iso-8859-1?Q?By6J6QUfKf6EwT3TqSyIpi/agFJZR8FbfaFSdzd/jjrvxKyV6J9v2AKRpl?=
 =?iso-8859-1?Q?UwqPZOnkiPimQXsaHU5Lm3rb/xYqh5vsUfyanTfCpQguZeprByvEXDJ0/M?=
 =?iso-8859-1?Q?gm504oaXVjxxa416PoNka/dbBKUqFJh1K89EfFMcIsSukTWCuKrp/MqJIm?=
 =?iso-8859-1?Q?6Y2VBfKgqpgey+ab6Z3p9ZR1QXr9xdyg+qXACwygZipsRZBGnw/KEQ8Cs8?=
 =?iso-8859-1?Q?Wijl6Le2ivZVR7wcZhqTMypaDyiZxRpQrmu6lJGy6/F9piay99eHotpDxR?=
 =?iso-8859-1?Q?1kdH5RsGfUxAV7TbV4/2Wgq3mA6pVmeQ54lFGyea4PLmmTnpoPqYzjGGL8?=
 =?iso-8859-1?Q?v/OsZ5JzT6IzFYqSFVt8FhaAnUylJwPD3nYlIPRS93IIxwdjbMr9javxff?=
 =?iso-8859-1?Q?k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?cQQX1AkZcXYWbDrfyXi0NRYCpFLD4r2vHOvuCdtCMLGTT4YZvf8JxJQn+W?=
 =?iso-8859-1?Q?falivHu7eXaGQc3Rhw3d0F3ko7idmoDy5clMlr8TyprwJUoTb5nhodesjB?=
 =?iso-8859-1?Q?7362M9Xu25Hm22aN33uiUPwToGZVsvtDSNTsanAARVxtAszqp8pN1oCCZd?=
 =?iso-8859-1?Q?JveF2aI1dBbQEpKbcCwVZ/EJriEKtzyg84vc2M6gF7otCEDVwwea5QYW/z?=
 =?iso-8859-1?Q?NfLbIZwnjC6KgnCL51aFpoFQiSS3kn8bzMeUxFM59RdU3qTMjtq/VV9iRz?=
 =?iso-8859-1?Q?0+lQwQqQUvaHQXdNSjMmctiTMAS6+03Ogv9+9zuYHJsLefiAhX7CI2wqRw?=
 =?iso-8859-1?Q?Gwda3T1pA2/RzvBdq2DS7ar7VXcnCeSHBOIOd3lVgGs5z/2MVSVGBQBdK5?=
 =?iso-8859-1?Q?TPYn+jwn+wvG803LGcdcIAnyo84s6U8nQcOYH1RpBhU+SJeMKlh0GwYJSE?=
 =?iso-8859-1?Q?qy6fb30iYScIOEhPilqyKIpiOsAAR6xaoF6cVqJ8/c/9e3whkq7ticwv4V?=
 =?iso-8859-1?Q?kgGb3RUe7cDqxvAjrZs3A5yUqZ4ydtYS1nk7NZfikCpLG5evZl7+8JalMk?=
 =?iso-8859-1?Q?3SgAWlrIza6B4RnhZkBV+2qdW0Ff82ni7W3Uf//NMeCJUPnr+nu1JFZQS9?=
 =?iso-8859-1?Q?XhBo8ErEmahBNGKNPTrdZ45/ifpAtJX0dUNCM/PVFJ25GoX6fbBtVqXMaq?=
 =?iso-8859-1?Q?jdgWAjjL8RMOVh0PZoeefmC27zaZJE8Rp6VuLBMKWWjtLGbwvAU9Owdd+n?=
 =?iso-8859-1?Q?3ZssujRl13YY/oMR7YrOABQf+S4VarQ6zyDZFwVX/ygz7JvBcoc3UAnbBa?=
 =?iso-8859-1?Q?31eUdAcTDoy3aiARla6XTCWG6nWZqZN5JFuX4aAnryq+wQns8IX70SjqI8?=
 =?iso-8859-1?Q?3O2YQ5mh4i9QFO/pwSVcg9g9NLf2T25rGxRGFwCVElAW9q3ckkVZCeWux9?=
 =?iso-8859-1?Q?wtLb61E62wsdxiZ1oMlhLo5VF3HQZilP96X7ZwAC+iF7FeD2XXOwICihU9?=
 =?iso-8859-1?Q?yaz6QsiTlls1j9HQQDSSnO3sE3pSwBlJ4IkAJVpxT1u3OKfr9xQ8xvVx8n?=
 =?iso-8859-1?Q?D1WDN4xPnvm90ZDkxJ/t7C+TdEVfuLKKL8Suber/UwRC5E5sxYgmANo9Dj?=
 =?iso-8859-1?Q?8guttnCdXvkWc8vzQiP6L874++FRLfa/j3T7C5GiDLcIGG5nkfmoSkWOOg?=
 =?iso-8859-1?Q?/QmdUFYjryMclW3JKboKulOmn/g56uWvg6xoWY6VZUYWHMNXjCfwKDjGAT?=
 =?iso-8859-1?Q?U4fcLp9SJZm/LYeMy1NwXCtmcHixK77Z/aQFwx86YHeNuVJr+n8SWp3e6E?=
 =?iso-8859-1?Q?XJW0bUfyOLfl51m4JJN+0yvtr7ZZOWZcvntyas5xgL+ggGWR3lHZXF46nO?=
 =?iso-8859-1?Q?ZsUG72yPjXqRu1OSTWxvRfSjwROTadiJtDutq5i5myukTkcSKSdPMkk+r8?=
 =?iso-8859-1?Q?ETdUFHKRfyXRPlYHvN7MCxTixSXQJ+lCZrsvRV5u9e5YMrH9vSkBJ5CaM2?=
 =?iso-8859-1?Q?M6nDdMm1N5v0YHqE8ncqLxPoLMFjocmxLL7d8sDzGVgNx/iKyvvh0TXKVv?=
 =?iso-8859-1?Q?Ttt/XWgNrLSIDgLxcLRK2NHJ4/Vc2YCniWT9XrEySxDBRhnpogCb41P3Jw?=
 =?iso-8859-1?Q?e1gjYPcGrf2ExVznNdceJQ6Ewn/UAAuez5R64IAczQiEtnpFYFosB0cw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d4ccfcf5-a1c2-4c45-024a-08dd92e0d821
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 12:14:16.4394 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KKQWbWnG2pY1QOzhITl6CdjpPrtSf2pi6C0EvMX4F/xQxPhihG1NK3DqKr94cqXxoYkdThHOXWI2HDZxmPbhbej2VGz8LwWx2d3eJsd7wGk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4728
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

On Wed, May 14, 2025 at 01:38:59PM +0200, Morten Brørup wrote:
> > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > Sent: Tuesday, 13 May 2025 18.17
> > 
> > The "--lcores" EAL parameter has a very powerful syntax that can be
> > used
> > to provide precise control over lcore mappings. The docs however, only
> > provided a minimal description of what it can do. Augment the docs by
> > providing some examples of use of the option, and what the resulting
> > core mappings would be.
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > Acked-by: Morten Brørup <mb@smartsharesystems.com>
> > ---
> >  doc/guides/linux_gsg/eal_args.include.rst | 27 +++++++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> > 
> > diff --git a/doc/guides/linux_gsg/eal_args.include.rst
> > b/doc/guides/linux_gsg/eal_args.include.rst
> > index 01fe6a3006..d530215784 100644
> > --- a/doc/guides/linux_gsg/eal_args.include.rst
> > +++ b/doc/guides/linux_gsg/eal_args.include.rst
> > @@ -23,6 +23,33 @@ Lcore-related options
> >      The grouping ``()`` can be omitted for single element group.
> >      The ``@`` can be omitted if cpus and lcores have the same value.
> > 
> > +    Examples:
> > +
> > +    ``--lcores=1-3``: Run threads on physical CPUs 1, 2 and 3,
> > +    with each thread having the same lcore id as the physical CPU id.
> > +
> > +    ``--lcores=1@(1,2)``: Run a single thread with lcore id 1,
> > +    but with that thread bound to both physical CPUs 1 and 2,
> > +    so it can run on either, as determined by the operating system.
> > +
> > +    ``--lcores='1@31,2@32,3@33'``: Run threads having internal lcore
> > ids of 1, 2 and 3,
> > +    but with the threads being bound to physical CPUs 31, 32 and 33
> > respectively.
> > +
> > +    ``--lcores='(1-3)@(31-33)'``: Run three threads with lcore ids 1,
> > 2 and 3.
> > +    Unlike the previous example above,
> > +    each of these threads is not bound to one specific physical CPU,
> > +    but rather, all three threads are instead bound to the three
> > physical CPUs 31, 32 and 33.
> > +    This means that each of the three threads can move between the
> > physical CPUs 31-33,
> > +    as decided by the OS as the application runs.
> > +
> > +    ``--lcores=(1-3)@20``: Run three threads, with lcore ids 1, 2 and
> > 3,
> > +    where all three threads are bound to (can only run on) physical
> > CPU 20.
> 
> Just noticed...
> 
> Some examples use: --lcores=XYZ
> And some use: --lcores='XYZ'
> 
> Are the apostrophes required in some cases?
> If not, please remove them.
> 
Yes, they are required in some cases to stop the shell trying to interpret
special characters itself. For simplicity, all of these should be quoted I
think. Perhaps that could be just fixed on apply, otherwise I'm happy to do
a quick respin.

/Bruce
