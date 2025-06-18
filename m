Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D45EC7115A
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Jun 2025 10:28:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 364064025D;
	Wed, 18 Jun 2025 12:28:16 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id DA2F540151
 for <dev@dpdk.org>; Wed, 18 Jun 2025 12:28:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750242495; x=1781778495;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=xbGSZdPnj61aPVmEQ0/5NSHquygKJmqMzoYvPTi2s54=;
 b=GyXuZ6L59TSWk++oTq7UZozwdKmzDyuMVx1yVNAU0gVYPwFa8c4I24NJ
 zSVlr2ICmsJBFP8ExNsum73rhD3eXHj700H2cCkVOGRM5NKwmMx1+/mA8
 +wUzMnE+5wrWqzEo58TiZJcGbRIdPIkBqUKbloBngqg/bH48eL6L8VTzj
 oS3n+akCgWGv44nktp5s7eIP26NzWx5MUol78s5oVeUaC56N8uXQAkkjT
 VkRHUa7R7PJdIGzXw9mNcduukN190ayzakOb0pQLOHvnwJkTAp5RjKM16
 tZxnjKxPVLjj453tJTJzxmSLpNYA9LuxK30LWbWTwdKiruNzy3FBS+6LN Q==;
X-CSE-ConnectionGUID: sdIT7Ic+TBeq9E7NVWgD9g==
X-CSE-MsgGUID: FCsPi5kZRVK/QylWLwc80w==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="52429443"
X-IronPort-AV: E=Sophos;i="6.16,245,1744095600"; d="scan'208";a="52429443"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2025 03:28:14 -0700
X-CSE-ConnectionGUID: zilVHWibSpiVyaJc0gDzsg==
X-CSE-MsgGUID: 83cd6KLrSvGZT6q6eMLdvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,245,1744095600"; d="scan'208";a="180452167"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2025 03:28:13 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 03:28:13 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 18 Jun 2025 03:28:13 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.78)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 03:28:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P+33VxjCrc49axSSWtUParj/V3hBG+6STHwskrDg/8IzDLsS2pNTZmCGFy19VvLyh2ja+Kpk0mlErOX8OglwxL5zTZZgkBfKbUb/mOd5r0RKPwhoS/ilgIew/UPYn1Hic7W3A+ch3qLNiSLrd3NI7lBs0GwN7zNI9k+nivCgAfMMFFjXPqD3Zs5MIEQ7OwZrHMp7mm3F/JAh5DoPUD4bJKnzG41sgTbvLK/nm1ljrzpD2GxiFJYwYyjyPyT45ZtOAuNjueeWynbYQUiWQTaUs9ReDUBMqV+0ydJUfbFIJEMb2nIC/uJbA25DtcNFiCfg4srnDCGc7SHWH6bGKcouAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v8XG+xjpc7yL+FIqQB4ssXE2rqlDsGPS2ZkYb7S8Vqw=;
 b=YTW1EYSSHTsRU+Rw4oePxrAmI247WSws/QJwbNFF5ojabuCe6ZHO4AM6+qHpt6Gc99t3g05/rry3bepXtAYvOqgWvOnVxpVs0On5NehpiNf78/EGHN1VPwPgpIAPIBjZFKZ9VNzQNmsWLZdAPwIEB3byzcvGT7y9/7e3rF7gtgqGN3s5lxvnhKQBHNNua0NAZXBR2fjx2tWz1Hpvfn+MjDekbLxJcgVFA2rEPKnsAJPhQRmjgsy4K+C/b7zhg/W33+1U22j6rCP7F1EURv+nX4FFWOiXzYqIycJI5fFxWRuQqljsCWH8VunfvyTkwRfDlxV9EJQeLAO8GFr2Fy3Sew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by PH7PR11MB7987.namprd11.prod.outlook.com (2603:10b6:510:242::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Wed, 18 Jun
 2025 10:28:10 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971%3]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 10:28:10 +0000
Date: Wed, 18 Jun 2025 11:28:05 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: Tomasz Duszynski <tduszynski@marvell.com>, Morten
 =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>, <jerinj@marvell.com>,
 <dev@dpdk.org>
Subject: Re: [PATCH v2 6/6] trace: add PMU
Message-ID: <aFKUtWpSaOBpfkMP@bricha3-mobl1.ger.corp.intel.com>
References: <20250616065341.3233106-1-tduszynski@marvell.com>
 <20250618065618.4045910-7-tduszynski@marvell.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FD08@smartserver.smartshare.dk>
 <3793563.K4a6FZZPjd@thomas>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3793563.K4a6FZZPjd@thomas>
X-ClientProxiedBy: DB3PR06CA0002.eurprd06.prod.outlook.com (2603:10a6:8:1::15)
 To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|PH7PR11MB7987:EE_
X-MS-Office365-Filtering-Correlation-Id: c186f8cc-5775-4556-9a87-08ddae52d2de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?teV5lUARbjaUgdNOMxF2fFYFREZ5/a/5dALGx/4xGfiEzb47kPHGwFA2SK?=
 =?iso-8859-1?Q?mT/cyfYSI9jLxNcFav7Z2Vzjx6C604yMz17Ly41r0jDZ10XcUW8VULlcPK?=
 =?iso-8859-1?Q?8vNDwLZx7BzIDZkMmYlT8EHILYsrrb7FN7k708imjfA/HZH8JVIqEnSZxH?=
 =?iso-8859-1?Q?/SC/2Vrq460vrP77oRPeOqt7WTDEk/xrKbk48MdKZ8a7kaUzOe+VA3LzsY?=
 =?iso-8859-1?Q?9OQwGHCTMqN35fBoorhZ70Q55HEVLhKD7bDrkYmg3a6Uf5AdnsWNbn8out?=
 =?iso-8859-1?Q?iRrshh4HXM6ZxFTV4M7jMMrYm0d3wJ46kUFCnB0OT3CNkPikTQOIUNp40l?=
 =?iso-8859-1?Q?+8MYF9yrcCqOYIKlpwYjSQgrWMYoI05Fid10NZs8InjNW1pvwo6VrC0VgJ?=
 =?iso-8859-1?Q?HFo1ZOxv37EHu1IF8N62FQLFew0eP+knM5ezzlhdkpr9dY2bPNkId5F3T6?=
 =?iso-8859-1?Q?uxW9xZL5q+PoP6zoye4DWDxCZb1Z8xltjUmUInsFa3u0s9o52nYL4eYtZk?=
 =?iso-8859-1?Q?karMmdOYdpmTKvsdoCk7Yv7T+ORY7WKrckgYBYq72hVf/cK42UIbIoiVnP?=
 =?iso-8859-1?Q?gJ3OhX6jtcbWZ4HMf0hcsrnX2j/vrCXTrcS0gvS6gdDbkal1Hq20yEOZV7?=
 =?iso-8859-1?Q?O1jEjxqz2SaFeR3D1YdZuLsNIHjKevajpFMui/rDcKIboBr+dzEaVUjxNr?=
 =?iso-8859-1?Q?09pcViTMUj4jxH/x0YL02+7MIuDCUuc9FPxsWL1UsnIi3gxX54uuc2J/fx?=
 =?iso-8859-1?Q?6ZnFm2/bcea3vaa2qsG78sKM6l8h7d4p9pNtJDatxjwqcgkX4jVyNcfw1N?=
 =?iso-8859-1?Q?rTJXcQQjz9gkcVIHDbmUtKeLOt4pRQ1oSHDBV16kocRs1fdhdjPixQN8ja?=
 =?iso-8859-1?Q?EG1fbY41VdNZsW5QFBd8aoj4hws//AcQnVP+r9LVg9/qt1r410glJjYDgT?=
 =?iso-8859-1?Q?9cFmyY/ERuN0RieeuRF2QdPfehXC6KWu9fNbTM1BAhE0+ZLkc/ATgEXsEJ?=
 =?iso-8859-1?Q?jkgazybHXwimrfUW5Iv5Qu4VjAp1vGceMIwu852KhHXwthA2JjpuJMSkg7?=
 =?iso-8859-1?Q?060nGh3up/AhAFExWVhbqY3wC1K57eggvMOk56lfWBb7ICYBJVn2HSmKvl?=
 =?iso-8859-1?Q?g7I3hpQCGllUmS86G0FeUxSCp3BJmB1yr8rv9O926gexnhwt62BL44FXnD?=
 =?iso-8859-1?Q?gY0493rV6LEo0yBlppNbpClASvUBv7Dqgil41lwRK0g+V4nUEG8EwaoWl4?=
 =?iso-8859-1?Q?4DUF51K3Wh4e0YSdINqTDXP/8tesBUOcOpcUz7hLR/4a3bLQs25Y0RTXxM?=
 =?iso-8859-1?Q?gJkiWseIzVTjAaO8T+gMparoVdfrYDTq7VCRNw3InnrUMIcsAqqZhJTeT3?=
 =?iso-8859-1?Q?PNYfbSGRZv3SO1xc5eGrGKzyGkj9O3o24AQD25kSbYYIpLakhNlC/WvlDO?=
 =?iso-8859-1?Q?Z3M9abORZ9SIveR2gGhs2BIbV9kUsTpl38PbCR+9z9EeBcBcm4IYnwCuGQ?=
 =?iso-8859-1?Q?E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?tLofhOgI2jcc0ej4dZf5SvvqFW+5xWOZ/QTI8/3bwWz4bZOTMSpSLQgApU?=
 =?iso-8859-1?Q?KxLwpd4airNsUaBvU4qP3iETXawZVCsKrCweBileW2BqSrE2LUFHxY9l5s?=
 =?iso-8859-1?Q?RV9TrybbOcr/QfSU9YCDbgSVVLBHPI5Gx27LjdlhfjSs2WRc8DItJgzkkB?=
 =?iso-8859-1?Q?BvaMchFqZOFD3WcSv0rLV4n/sr/LZYyVnazXwyMs7laDTau8ToHP7n0zMq?=
 =?iso-8859-1?Q?lHYbaCfVsxunqfiOCB2/JlbyZ95qH3ik4LkMxQud5us/H28PYKVCwpiFLx?=
 =?iso-8859-1?Q?Ei701A5v2pc3vDrUDXoKH+VaRB1ci25aIqP7U29/Fhd49S7TxlXqEbRvAI?=
 =?iso-8859-1?Q?J4EIxfjHPMy9oyORgnMhUljgD/GIinQL0cVLmETctTIWxLzGmRwyr+scjo?=
 =?iso-8859-1?Q?BCboiIT9TdXO/vQugjBOPGC5sgbnKhMTcTHSjbS/UC+JABTyRA94qVfLQK?=
 =?iso-8859-1?Q?h+xQPtXJ+9AZToNq1FGsHxvQIaKPay5NUewF+EDAkSw4e7KyRS++puuirY?=
 =?iso-8859-1?Q?TTvcyGs9sgBc8CIur2ScrEnN1hZgzBliCNWKQPd+pbC9DDAOJAfbC6OKWn?=
 =?iso-8859-1?Q?NLWiwkUwlyzgof5S93rmbPiOYHAfpC7Jn3QAJF1tl6qeCcI7BdbwWL6oDR?=
 =?iso-8859-1?Q?mgaR2rimRCluaRf9ZhKZYar/3BPXVZttdFP47XvNK+WfmKcmU/lvcnZ62f?=
 =?iso-8859-1?Q?ainuVrd2FWkUsc9hul9yeVCZPh9hn1kJWml8E/h7BhnLI/GiWSMZYaxlS7?=
 =?iso-8859-1?Q?FLijpNL06gfMxGRwO0LtQcSl0NyBlmJhE3AszEsAlcQMhg9zSNX9uQojsf?=
 =?iso-8859-1?Q?24EGEJ2AhkrOUYTF/YZMlgnskPqWkmdLTm0FNDRVEFF+qncWFkrNEOGXw8?=
 =?iso-8859-1?Q?taKZvd+0uF2sMKj8nrow4PL3P5zphUiqdE+XaY+kF9dj1ISJUklgNiBLb4?=
 =?iso-8859-1?Q?62LxYb56zhS5Ye8r0Qtv7JBwby6r8TlmKFb3m5llcVYnxydhlLYz1Wg56s?=
 =?iso-8859-1?Q?2upBAL7pK+RBEQP2bumPIVy5DZBeUQCGjAnDguAbq949UwkVTbtUYPkYn1?=
 =?iso-8859-1?Q?LxWBc9Sj4YIOdsEfRShkgcbatFf6aAy45LcxJyrWRH6iNO98WdIu+Z9C9f?=
 =?iso-8859-1?Q?lKaCCSUzzcF81PLEllYQBtIFHkter5KnvnlLM5y8ZUIxQDP2fbja7xmQpq?=
 =?iso-8859-1?Q?S5IEl204s0wv2yU8ttZbrjBhu1CCAaSMAOqwatLi5xuTgGVLcimzuy41pZ?=
 =?iso-8859-1?Q?FaFMm6wEmHJbqibkqR6907dGuu5k5JtsYpU9TC8/tXxv1LVISd9rU5YLn5?=
 =?iso-8859-1?Q?kxNHkjP5kHXEcniiZ8/WBxJiOtn7RYU+0uEwiqIF83VIDus60Wd6CS/oSZ?=
 =?iso-8859-1?Q?leB+m7t6FHonzAMoENdaO97omtW015AO+HLM8B8X7GwaIbBX+TlZ9Ps8bF?=
 =?iso-8859-1?Q?OSpecNwDTCbOUAgGaXvcabSvkjCk1NgHnqTTWXR3CbS76YlR2O1vjXIim+?=
 =?iso-8859-1?Q?LGRHQIHtT7wjKzM34TS/NRb5qHU7vtdw/CVJi5WYQKxskD3WXYxfYHdoSt?=
 =?iso-8859-1?Q?LFe/es/DSSTZ5KByUsXud+feEYBdor+Ci25M8mt0dU/GuHJXYrwIRqFyhp?=
 =?iso-8859-1?Q?Nhq6fLU7NAG4ASmQVDlHjkYgTKcs3bwmKCLvULeyPUg4HQnxbsrsaEng?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c186f8cc-5775-4556-9a87-08ddae52d2de
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 10:28:10.8129 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q3xV9sU9av31YZiyo1qgE9zv99suuF8GUBdIe3JFjBwHsygn7oA7DJVlScgV4fDwv1GIKPTAhe92pNJwcsVdsYHYw72y56N7wxD5y2MdZ+M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7987
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

On Wed, Jun 18, 2025 at 11:47:13AM +0200, Thomas Monjalon wrote:
> 18/06/2025 09:16, Morten Brørup:
> > > diff --git a/lib/meson.build b/lib/meson.build
> > > index 1934cb4a29..87b567f01b 100644
> > > --- a/lib/meson.build
> > > +++ b/lib/meson.build
> > > @@ -13,7 +13,7 @@ libraries = [
> > >          'kvargs', # eal depends on kvargs
> > >          'argparse',
> > >          'telemetry', # basic info querying
> > > -        'pmu',
> > > +        'pmu', # trace depends on pmu
> > >          'eal', # everything depends on eal
> > >          'ptr_compress',
> > >          'ring',
> > 
> > @Tomasz,
> > 
> > Please re-read my v1 review feedback [1]:
> > The PMU library should depend on the EAL, not the other way around!
> 
> It should depend on the low-level EAL, yes.
> But as of now, EAL is not split so it is better to avoid EAL dependency if possible.
> 
> > How else is the PMU library supposed to use EAL functions like rte_mem_page_size()?
> > 
> > @Jerin or @Bruce, do any of you have some suggestions for how to achieve the proper dependency chain here?
> 
> I propose we don't use rte_mem_page_size() in PMU lib for now,
> so we keep not depending on EAL, to avoid mixing all in future.
> Later we could fix it if we manage to have high level EAL as a separate library.
> 
For cases where we only need a single small function or snippet, there is
no problem with circular dependencies if it can be made an inline function
in a header file. We just need to add the appropriate include path to the
build of the PMU library to pick up any EAL headers with inlines.

/Bruce
