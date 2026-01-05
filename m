Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D57C79F89
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Jan 2026 13:01:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8C5BC4026F;
	Mon,  5 Jan 2026 14:01:07 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 6E13B40267
 for <dev@dpdk.org>; Mon,  5 Jan 2026 14:01:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1767618066; x=1799154066;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=87FR++OOk/N1Zx6NA80KhU12xdJJ18Z3itSCy7qPPQk=;
 b=BNWUj5GR47c+2cpfR5OAxuMerh8ul0/VcdZm8HDjWlkIlliDeJuPsQZz
 Rer93zmAKtY3xCGsSzvBtgVAHWfIZg3ODm8bVnTL/biUMxYxU0U5T6A1F
 6LJUulTAjHIsV4XsCtRVfh2mF+cCsXX3DSfeEioRPrVo40kDHn8GXs293
 B7ySyFhvjG/ykLa0nes59YrzkH1faTKLzMrj22Qr57uuV5kaZnDu2+rka
 dhkm6Keoq996P2+TRB7XfnoMXT5pRpCbHfJeCatuhn3lhVsTWILXkXSMB
 OMTUY4p21pXyxwHj172phO1gdcwPleFpwltJti6WRRbg/s/7d426n+IbN g==;
X-CSE-ConnectionGUID: CJytfSAaRn28b/pTktnSjA==
X-CSE-MsgGUID: wNGU1O5ATwWGVkQUfk1VKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11662"; a="68961857"
X-IronPort-AV: E=Sophos;i="6.21,203,1763452800"; d="scan'208";a="68961857"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jan 2026 05:01:05 -0800
X-CSE-ConnectionGUID: eYtArH0TTjWvfAL70O/9sw==
X-CSE-MsgGUID: 73vEn/ZETc22ysLuFM/uKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,203,1763452800"; d="scan'208";a="206944647"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jan 2026 05:01:05 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 5 Jan 2026 05:01:03 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 5 Jan 2026 05:01:03 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.5) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 5 Jan 2026 05:01:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pNw6jAR5IJOU8oZuACdO9k4GURi2sP+DXpIJpTeWHxzGRROKtFC/8DQLQmqocoZXoCsO9+wv3RN7sfVxDbNOA7W8bn5F7uGRSgUxHDXlzKFlw8MQPkP1I78PBtjCCJiOK5W9kB0wq9wCMyq21pKhI4uIRY979CuUhVHPC28344EynlwqL1/h8hUG3cIQ834E6AYFNfqunK8CjA/Bma8L4N0cQgg0oaT3q8jNGmQLV/auAMBcJUUNJ/b3lkBXCvmlbBkPPgzcqaiNSME+Jg6gFJMWXRRXM7t6L8ZxgR8nHqwxJKwUDRLr9vpnZ/REJ9i3727Z7wYgOkIis+hNsIFmRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1DZN3ePmWz4QGC8+4GgK6uDknAdREiF6AeQJfh2PiDc=;
 b=H9Dy81IgG4C8LEA/B/x/kmGBp/v0tiWG7zZXjg8iin8alGMJXfyd568OFy8RRQ9g0dO0RPkKKIFgYLC4lBFRo16zfjq/zEGcW2JcrUSbXwUiYG6kN1Ww2HOy91LMXMWD/z7nz68OY7b3Kf0KxxWIuwd9lR5NK3hE2NriEekysc6rKT45a093SSB329hhsSFAsovT09AqXd1slIfJcU5t+Ndj9Fo3cLU86AgQvXErRXuRBEzbBGN+GP4Vl2w0lh6fNOtbAnxc9yolOvY9JpGZJQyX4JwgJS7T103k+YwOdSPuypx8lsqeNLOZ7beWkFw4wpN36fjbgBzpuSub4Ydq7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ2PR11MB7427.namprd11.prod.outlook.com (2603:10b6:a03:4c1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 13:01:00 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 13:01:00 +0000
Date: Mon, 5 Jan 2026 13:00:54 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: "Mandal, Anurag" <anurag.mandal@intel.com>, "Burakov, Anatoly"
 <anatoly.burakov@intel.com>, <dev@dpdk.org>
Subject: Re: [PATCH v5] net/ice: add MAC anti-spoof option
Message-ID: <aVu2BltXSe6IlDaL@bricha3-mobl1.ger.corp.intel.com>
References: <20251113105914.34949-1-anurag.mandal@intel.com>
 <20251230114828.6156-1-anurag.mandal@intel.com>
 <CY5PR11MB61160E26A3AFEA280405C580E486A@CY5PR11MB6116.namprd11.prod.outlook.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65625@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65625@smartserver.smartshare.dk>
X-ClientProxiedBy: DU7P189CA0016.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:552::28) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ2PR11MB7427:EE_
X-MS-Office365-Filtering-Correlation-Id: 19b5a8b6-345b-496f-208b-08de4c5a7929
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?Dfmoj4yUx01H+wQjB2+WeBqCK5ytES4zUvAKL9wuJYoM235h7L27MVJ2lR?=
 =?iso-8859-1?Q?8iih+pH9wcO5ylpT1Ajm24ukDUS2u0oD+l4MwfztcGI4k9c4IOTD6Do/R7?=
 =?iso-8859-1?Q?q8QeMoZy91LQmalwrNmK329pMyFoAaMbRMybqYDe4R8oKhEpRrYExTI90p?=
 =?iso-8859-1?Q?S3n4XGyH8mLJ/aPem8Xxk1v6drSIRJla35FGQwBM99nrCMqxzj5tel8dFs?=
 =?iso-8859-1?Q?QT1BE1ZxWwtL2GsAfIsU1nwZ5Sk15JhAH+qf0jele7gwQ+nqD2Vija0WiS?=
 =?iso-8859-1?Q?yB6PKbnQ0ZZaaEPi8CFHLpQpziHKeamBniI9iTqFIt+SgYj3TeIcAichh2?=
 =?iso-8859-1?Q?QONDZlsNDFm1B5MgYPj/0Dve8A5ZWq7mKU4VOFRKjBjZT2nKH9a8/WdEaX?=
 =?iso-8859-1?Q?5qL5FcGUA/50F/8aOJ8D8+//QfwIDS7gjFvBI+sNloROkIYPohvBUqIyvM?=
 =?iso-8859-1?Q?ISHsF8DMYt6/4AZr93btBFe574CVvp3ilowCyJj7fqn04TlW1i6dUrdANX?=
 =?iso-8859-1?Q?0wHFkLkyje4a3IZ7cX+YTEqWo30/LhKUuK+8c/WE33J1XUjKAinov9+GEF?=
 =?iso-8859-1?Q?hb6vcdgYYh7aJvlK8m3BTnc343/Ev3T2I+mw8xDq+mLQIn9wbhRgGCMtnP?=
 =?iso-8859-1?Q?8Pid2Gpb2SkiPNUwhwO8tWBFX9Kc+cTj8xiOQTFpxk5OSDrxPz7SmI4ZG3?=
 =?iso-8859-1?Q?YFqG3Z0439ZMQCxvv2f5anu1fZpgILGqap6JoUdmUK8mxkoiX7wbG0harL?=
 =?iso-8859-1?Q?hW/MYiwxXcAoTwPqs/ebe04jHgAyE5qFIZUC3DOJYgFsOucCSibXgSjI/0?=
 =?iso-8859-1?Q?o9ggo14P1pypwib/e8mGhmpsg5lmodkj+LarsTr42LZ0mqNviNe1JOJ+Aq?=
 =?iso-8859-1?Q?SIXmZyFAehs/AszqlDL1NkOeOSJB9W1ChaXHUkfuhKvDacMX70rzXJZQDI?=
 =?iso-8859-1?Q?5Kn7ZNpqg+X5E08GpJqhBTo5g0LwYOvPDS159jWKIrHbhOU5aE2i/uomfp?=
 =?iso-8859-1?Q?LX9Q0Rvd6MUle3G2744MjGZKyJB66rZg16igiGT+0YGUe5kbfWCb+cw92W?=
 =?iso-8859-1?Q?X/1LynRHvVmbLG0ved7/jNMKhgxahPtIdWojg3n2A9gzcStcmdB57+d+HT?=
 =?iso-8859-1?Q?yWE1lLV2S4/K4+nKfGTitOAOS49Cm+i25Hc/KaKXvq3b6x9x0C0gSp4ZE8?=
 =?iso-8859-1?Q?m9YGkKkKFOrd1r0qB5z6pcqERroBR3rNmyMb4MlNH/QGdG4V1iJtVJPa/D?=
 =?iso-8859-1?Q?ivfMdy0Udy0p5bLwqoICJTm1/uMdBuaoJHoYIXq5dPAE+7HvxT5ziALnsm?=
 =?iso-8859-1?Q?yj2PDeLDqiayQP8+PfaZbGBgnL7wfa7zf3gSba0lQ1kI3scqMafuROTU9j?=
 =?iso-8859-1?Q?huchivJ5X2oyy9BDBFx307vT9gI9vHqIEgOBx6X6VJhyzvqtssc5qjzsgv?=
 =?iso-8859-1?Q?bamJYpYnxU8ZSdI6hRs0AbLEWjYBZO0YXEOtrgAZwpHsHn/4sv2NZcizqb?=
 =?iso-8859-1?Q?PI3Fn7QJTmbxqlHX7H7g2o?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?r+4ZN0fktYBhrC8IADBb+WKpOwYshBZlwdcXz9eILb3J4DLz8b7sNtAWv/?=
 =?iso-8859-1?Q?DKq1sUFLK/ecu5OhtIPZys3JpmcYhID2W6CiwhGJAefPXP4np/VMOQZMIA?=
 =?iso-8859-1?Q?v9wXt5Zjuy8pNeGKDdfCilAQBezs8b98oz2y7e0fNYRQvxYUdcYdr9lYwF?=
 =?iso-8859-1?Q?9zrwMOACFHk/NUu7FGtkBY+N9pBwHNW7v+91KbtQ98eOdj0bTvLdisrJiN?=
 =?iso-8859-1?Q?1vIfza75X0F4KpRoEH1HOgfJkRFMveniISFjp7Yl7jktKXdT8BhhBPDE9F?=
 =?iso-8859-1?Q?32eUrXjwqlrxKllWLWfg/u5xvY+lwFNR9prgtjBwxpYVlrhbUGiPXdL8kC?=
 =?iso-8859-1?Q?8htd0RWFzX5UiIXvY733WUlprExHOvY3v8FXUNfe5IIadaPpNpmldD3NcW?=
 =?iso-8859-1?Q?658oAWDS9mk7z71CMqd+S0xrpp01tvaV8tkKVfX262qJKIM+SEj9hjNpNb?=
 =?iso-8859-1?Q?e3iImtuKGARvnG6fKd017/t6BR8O0dFa6BnN2+aKCJZT5syJBgVrroltza?=
 =?iso-8859-1?Q?V+UfH9GjZuAZgG6HwprstpSR4YSZm38gG6IVMwQgBqAB4Emf2m0D7FWot/?=
 =?iso-8859-1?Q?4yXJCy4Z44r7ebpKv2U9XeV6sK1v+TYG29946n5UQnzajatUoL/jtRFLB0?=
 =?iso-8859-1?Q?AvLdGI0532uricgLtI2FYPP6F+CHMxLgnlVd0mABpJn9eTXVrUqInA5qzM?=
 =?iso-8859-1?Q?VAsbDc6PUJq4omEcpA0BSY80WYhSw3+3WjRV5WXz/BCiYec4XarOYS3pL/?=
 =?iso-8859-1?Q?o4CxSh1mAdaVXM9IOXSgDhXtkWaDAyhWtIvxEYey3yrchM+rKWEvgClrcq?=
 =?iso-8859-1?Q?z7k7+nVEpxwxYVamijg9OkPSCREuGrcw12bxSedEGAo6oRbQzspR1eTYHp?=
 =?iso-8859-1?Q?Eo4RfR/lxlVUWti/QoPMsANQO9aLdWqfvrC7vUtb0lKoqhMTNGOD1/mZCC?=
 =?iso-8859-1?Q?TlyaVRkK3FMgTWRmLgAIvT6RQuVLOvf3EFxqelOedXpTO0pUzaJgJLUMQX?=
 =?iso-8859-1?Q?uCF0KAf/QyItjg66mxYtX4avF0EM2rt3azUtJg1fadOkli8P4aIblXbZaL?=
 =?iso-8859-1?Q?25GEfkGVsWLtPlLfJ2Ef0qWWLGe+D4oJ/qZiO9VkU+YFCgL7CT19a7Q7Im?=
 =?iso-8859-1?Q?E74rg3vniUOUpmzLYO9+DEhF2YaSKE/73q81Dxuj31w3a9VlUmKA7uacJl?=
 =?iso-8859-1?Q?NxW9Tb1/L54Mt06PUgXMiTaqUetDNr4c4GOrvhOgQ1TLKjhJfM6cePYtEz?=
 =?iso-8859-1?Q?qXlLAexSOA+wn/Cxg6hJlZKddNOZpfej8Q0+69fHQ//xdqBXwUIgpbcxol?=
 =?iso-8859-1?Q?li2FSTvrYBJ+et2hhFLCgV/YOhiBMr6Uij87ZOo8W12bdu2dT8qCBgrS9N?=
 =?iso-8859-1?Q?unfXt8qyXQU2f/g72Fw/PG9yDFBBL9R512sDS6vdqM6aEF23uOgl5OKuoX?=
 =?iso-8859-1?Q?AESfWujvhDtxSt6HxVosNObrIGqFdxYJtlRqKVbxXesZqvV9BP59VEtj2Q?=
 =?iso-8859-1?Q?WaGvKGFzutRW2BF1j5jjXMRDQTOoyy6S01w/j1ORyyRf3zbcyp1Wx0jfG6?=
 =?iso-8859-1?Q?doOftcr34RVKuGx9fvhlTTcVaNvVHU392P9WaiRGhmzkNOR+aM7k0024ku?=
 =?iso-8859-1?Q?OczGD5R5MudKaH4i3Fc6buqSTAE1dgdjjrQWwA+iO/FQ3/5k7YP45EgIl3?=
 =?iso-8859-1?Q?371r4TqEp+yq3NPSNaaWgQ+Hf8eRjG0pDqK3cnYfDTa2cxT3Uh9+eyk00g?=
 =?iso-8859-1?Q?Uthtjohn2F+2iLPvMHHIQsFkkWfjGaM0yLFphKES3FMfHP5xjFHcP9ZSql?=
 =?iso-8859-1?Q?BG8qWgPj6oCKzFkHWcYW3t8y/10XQcs=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 19b5a8b6-345b-496f-208b-08de4c5a7929
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 13:01:00.0210 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dwk9dg6JU19dXTIcCkz59J8qhQOBO7Lc1fx75Nx1ipKLdnAnw7F6euZfZJBfK6gBlz4Ct3JbqzXpgYvsxrq2dUOxQkiaAnsyzqOlyaU5MP4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7427
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

On Mon, Jan 05, 2026 at 01:48:22PM +0100, Morten Brørup wrote:
> > From: Mandal, Anurag [mailto:anurag.mandal@intel.com]
> > Sent: Monday, 5 January 2026 12.31
> > 
> > > VRRP advertisement packets are dropped as TX-errors upon transmission
> > > from a vsi of ice PF due to MAC anti-spoof check, which is enabled by
> > default.
> > > There is no way to disable this security check in the Tx direction to
> > avoid these
> > > packets being dropped.
> > >
> > > This patch introduces devargs "mac-anti-spoof" to allow user to
> > disable MAC
> > > anti-spoof check. Disable MAC Anti-spoof check in the Tx direction to
> > send
> > > outgoing packets even when their destination MAC address matches one
> > of
> > > the MAC addresses assigned to that same NIC port and avoid getting
> > dropped
> > > as TX-errors.
> > >
> > > Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> > > ---
> > > V5: Addressed CI failures
> > >  - Removed ICE_AQ_VSI_SEC_FLAG_ENA_MAC_ANTI_SPOOF
> > >    flag as that is causing CI failures and observed
> > >    MAC Anti-spoof check is enabled by default
> > >    irrespective of that flag.
> > > V4: Addressed ASan CI failures & Morten BrÃ¸rup's feedback
> > >  - set the default value of the devargs to 1
> > >  - enabled MAC anti-spoof check by default
> > >  - provided devargs option to disbale the same
> > >
> > > V3: Addressed Morten BrÃ¸rup's feedback
> > >  - set the default value of the devargs to 0
> > >  - disabled MAC anti-spoof check by default
> > >  - provided devargs option to enable the same
> > >  - synchronized with source prune
> > >
> > > V2: Addressed Bruce Richardson's feedback
> > >  - changed devargs name to "mac-anti-spoof"
> > >  - changed devargs member name to "mac_anti_spoof"
> > >  - changed macro name to "ICE_MAC_ANTI_SPOOF_ARG"
> > >  - set the default value of the devargs to 1
> > >  - added NOTICE log msg when MAC Anti-spoof is disabled
> > >  - added more code comments to provide clarity
> > >  - fixed typo error with ICE_AQ_VSI_SEC_FLAG_ENA_MAC_ANTI_SPOOF
> > >
> > >  doc/guides/nics/ice.rst            | 12 ++++++++
> > >  drivers/net/intel/ice/ice_ethdev.c | 44
> > +++++++++++++++++++++++++++++-
> > > drivers/net/intel/ice/ice_ethdev.h |  1 +
> > >  3 files changed, 56 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst index
> > > 6cc27cefa7..c3e9cfaee3 100644
> > > --- a/doc/guides/nics/ice.rst
> > > +++ b/doc/guides/nics/ice.rst
> > > @@ -194,6 +194,18 @@ Runtime Configuration
> > >
> > >      -a 80:00.0,source-prune=1
> > >
> > > +- ``MAC Anti-spoof Disable`` (default ``1``)
> 
> Suggest removing "Disable" from this headline, to clarify that the default 1 value enables MAC Anti-spoof (does not activate "MAC Anti-spoof Disable").
> 
> > > +
> > > +  Disable MAC Anti-spoof check in the Tx direction to send outgoing
> > > + packets when their destination MAC address matches one of the  MAC
> > > + addresses assigned to that same NIC port.By default, these
> > outgoing
> > > + packets are dropped due to MAC Anti-spoof check.
> 
> The default 1 (instead of 0) is a temporary workaround due to CI issues.
> This (incorrect default value) should be registered as a bug in Bugzilla.
> 

I don't think it's just a CI issue. The CI is flagging a genuine issue
here. When I tested previous versions of this patch, the hardware was doing internal
looping of packets when running testpmd, such that sending in one packet
let to forwarding of millions of PPS.

> And a warning should be added to the description here (/doc/guides/nics/ice.rst) that the default 1 is a known bug, and is expected to be changed to 0 at a later time. This warning can refer to the bug in Bugzilla.
> 

That may or may not be the case, depending on if its possible to get a
working, sane, default configuration with a default of 0, which still
allows e.g. macfwd or macswap configs of testpmd to work ok.

> > > +
> > > +  MAC Anti-spoof can be disabled by resetting the devargs parameter
> > > + ``mac-anti-spoof``,  for example::
> > > +
> > > +    -a 80:00.0,mac-anti-spoof=0
> > > +
> > >  - ``Protocol extraction for per queue``
> > >
> > >    Configure the RX queues to do protocol extraction into mbuf for
> > protocol
> > > diff --git a/drivers/net/intel/ice/ice_ethdev.c
> > > b/drivers/net/intel/ice/ice_ethdev.c
> > > index c1d92435d1..7251b111e0 100644
> > > --- a/drivers/net/intel/ice/ice_ethdev.c
> > > +++ b/drivers/net/intel/ice/ice_ethdev.c
> > > @@ -42,6 +42,7 @@
> > >  #define ICE_DDP_LOAD_SCHED_ARG    "ddp_load_sched_topo"
> > >  #define ICE_TM_LEVELS_ARG         "tm_sched_levels"
> > >  #define ICE_SOURCE_PRUNE_ARG      "source-prune"
> > > +#define ICE_MAC_ANTI_SPOOF_ARG    "mac-anti-spoof"
> > >  #define ICE_LINK_STATE_ON_CLOSE   "link_state_on_close"
> > >
> > >  #define ICE_CYCLECOUNTER_MASK  0xffffffffffffffffULL @@ -60,6 +61,7
> > @@
> > > static const char * const ice_valid_args[] = {
> > >  	ICE_DDP_LOAD_SCHED_ARG,
> > >  	ICE_TM_LEVELS_ARG,
> > >  	ICE_SOURCE_PRUNE_ARG,
> > > +	ICE_MAC_ANTI_SPOOF_ARG,
> > >  	ICE_LINK_STATE_ON_CLOSE,
> > >  	NULL
> > >  };
> > > @@ -1761,13 +1763,46 @@ ice_setup_vsi(struct ice_pf *pf, enum
> > > ice_vsi_type type)
> > >  		/* Source Prune */
> > >  		if (ad->devargs.source_prune != 1) {
> > >  			/* Disable source prune to support VRRP
> > > -			 * when source-prune devarg is not set
> > > +			 * when source-prune devargs is not set
> > >  			 */
> > >  			vsi_ctx.info.sw_flags =
> > >  				ICE_AQ_VSI_SW_FLAG_LOCAL_LB;
> > >  			vsi_ctx.info.sw_flags |=
> > >  				ICE_AQ_VSI_SW_FLAG_SRC_PRUNE;
> > >  		}
> > > +		/* MAC Anti-spoof */
> > > +		/* By default, Source Prune in Rx is disabled
> > > +		 * and MAC Anti-spoof check in Tx is enabled.
> > > +		 *
> > > +		 * Source Prune is disabled by setting local
> > > +		 * loopback with ICE_AQ_VSI_SW_FLAG_LOCAL_LB
> > > +		 * flag in the Rx direction.
> > > +		 * ICE_AQ_VSI_SW_FLAG_SRC_PRUNE is added to
> > > +		 * prevent transmitted packets from being
> > > +		 * looped back in some circumstances.
> > > +		 *
> > > +		 * MAC Anti-spoof check can be disabled by
> > > +		 * clearing ICE_AQ_VSI_SW_FLAG_SRC_PRUNE
> > > +		 * flag and setting Tx loopback with
> > > +		 * ICE_AQ_VSI_SW_FLAG_ALLOW_LB flag in the
> > > +		 * Tx direction.
> > > +		 */
> > > +		if (ad->devargs.mac_anti_spoof == 0) {
> > > +			/* Disable mac anti-spoof check in the
> > > +			 * Tx direction to avoid outgoing
> > > +			 * packets getting dropped as
> > > +			 * TX-errors for VRRP support when
> > > +			 * mac-anti-spoof devargs is not set
> > > +			 */
> > > +			vsi_ctx.info.sw_flags &=
> > > +				~ICE_AQ_VSI_SW_FLAG_SRC_PRUNE;
> > > +			PMD_INIT_LOG(NOTICE,
> > > +				     "Disabling MAC Anti-spoof check "
> > > +				     "in the Tx direction does not "
> > > +				     "affect Source Prune in the Rx
> > direction");
> 
> Try shortening the log message to fit on one line, so it is easier to "grep" for.

Even without shortening, you can still put a whole string on a single line
without having to worry about the 100-character limit. Checkpatch ignores
strings extending beyond the limit. Better to have a long line than broken
strings.

> 
> > > +			vsi_ctx.info.sw_flags |=
> > > +				ICE_AQ_VSI_SW_FLAG_ALLOW_LB;
> > > +		}
> 
> If implicitly enabled, please PMD_INIT_LOG(WARNING, "MAC Anti-spoof check is enabled"), as this kind of filtering is not the behavior expected by normal applications.
> We can probably not distinguish between implicitly and explicitly enabled, so simply log it if enabled.
> 
> > >  		cfg = ICE_AQ_VSI_PROP_SW_VALID;
> > >  		vsi_ctx.info.valid_sections |= rte_cpu_to_le_16(cfg);
> > >  		vsi_ctx.info.sw_flags2 = ICE_AQ_VSI_SW_FLAG_LAN_ENA;
> > > @@ -2398,6 +2433,7 @@ static int ice_parse_devargs(struct rte_eth_dev
> > > *dev)
> > >  		return -EINVAL;
> > >  	}
> > >
> > > +	ad->devargs.mac_anti_spoof = 1; /* enabled by default */
> > >  	ad->devargs.proto_xtr_dflt = PROTO_XTR_NONE;
> > >  	memset(ad->devargs.proto_xtr, PROTO_XTR_NONE,
> > >  	       sizeof(ad->devargs.proto_xtr)); @@ -2467,6 +2503,11 @@
> > static
> > > int ice_parse_devargs(struct rte_eth_dev *dev)
> > >  	if (ret)
> > >  		goto bail;
> > >
> > > +	ret = rte_kvargs_process(kvlist, ICE_MAC_ANTI_SPOOF_ARG,
> > > +				 &parse_bool, &ad-
> > > >devargs.mac_anti_spoof);
> > > +	if (ret)
> > > +		goto bail;
> > > +
> > >  	ret = rte_kvargs_process(kvlist, ICE_LINK_STATE_ON_CLOSE,
> > >  				 &parse_link_state_on_close, &ad-
> > > >devargs.link_state_on_close);
> > >
> > > @@ -7732,6 +7773,7 @@ RTE_PMD_REGISTER_PARAM_STRING(net_ice,
> > >  			      ICE_DDP_LOAD_SCHED_ARG "=<0|1>"
> > >  			      ICE_TM_LEVELS_ARG "=<N>"
> > >  			      ICE_SOURCE_PRUNE_ARG "=<0|1>"
> > > +			      ICE_MAC_ANTI_SPOOF_ARG "=<0|1>"
> > >  			      ICE_RX_LOW_LATENCY_ARG "=<0|1>"
> > >  			      ICE_LINK_STATE_ON_CLOSE
> > > "=<down|up|initial>");
> > >
> > > diff --git a/drivers/net/intel/ice/ice_ethdev.h
> > > b/drivers/net/intel/ice/ice_ethdev.h
> > > index 72ed65f13b..5fe4688d57 100644
> > > --- a/drivers/net/intel/ice/ice_ethdev.h
> > > +++ b/drivers/net/intel/ice/ice_ethdev.h
> > > @@ -617,6 +617,7 @@ struct ice_devargs {
> > >  	uint8_t ddp_load_sched;
> > >  	uint8_t tm_exposed_levels;
> > >  	uint8_t source_prune;
> > > +	uint8_t mac_anti_spoof;
> > >  	int link_state_on_close;
> > >  	int xtr_field_offs;
> > >  	uint8_t xtr_flag_offs[PROTO_XTR_MAX];
> > > --
> > > 2.34.1
> > 
> > Hi Morten Brørup/Bruce,
> > 
> > Kindly review this patch. No CI errors reported.
> > 
> > Thank you.
> > 
> > Regards,
> > Anurag M
> 
