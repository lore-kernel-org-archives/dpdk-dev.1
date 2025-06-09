Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CECCC5B552
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 10:45:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9297C40E20;
	Mon,  9 Jun 2025 12:45:33 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 3636740E17
 for <dev@dpdk.org>; Mon,  9 Jun 2025 12:45:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749465932; x=1781001932;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Ia+2Xx653Q/SRXwRF/uf7Pxcy1s2OaTxbIvemot7pCk=;
 b=cpKj9dyZT14hAJK0Jwwzz1tJwxkVJaHkPY2xg+714Dy1RXKswpLQmHiU
 zLW9quC2qEl4Gyimk+ZmRGjf2U85ck8io428oSwYjV3d/zrYmcSNWOYkX
 NUP7bACtCm+Rm/fiZ2lRhFGosPGjN93IopknOZ54Z7vggE+Y5rD3p2pTF
 J9aFccDjuGUGXJDf26CLi/+OmJFsLglBumwDvSMhdDr4C6NvkN9t7LaRS
 P2d8+J53kUXZotOmZuGv0nXNtU28EtNJtJuvKtvWdLjvpdIge9bxdCXt4
 /elQhZVVWyxW3GlvsHPC9k91TwMIbFfGsJ/KT+TMmqxWN6RJX+3GWYkfD Q==;
X-CSE-ConnectionGUID: z+ghj0VZSx6MD98ABDeIdg==
X-CSE-MsgGUID: YBXL3PioRgStxQbhYjZmyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11458"; a="62940059"
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="62940059"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 03:45:31 -0700
X-CSE-ConnectionGUID: k01pUJ2ETV6uiTqnoCbviw==
X-CSE-MsgGUID: exZTg5dcQreJwDRy+qNeHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="146828722"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 03:45:29 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 9 Jun 2025 03:45:16 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 9 Jun 2025 03:45:16 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.85)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Mon, 9 Jun 2025 03:45:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rX8uy++IBB6HJ9Khi++ZHm+dQE32rzjDCXdcx04b1W2B79Dg2lOStMoQ0KKfULHu90wuIWkRc2t2+5bGBibUfcMjxTFkrYBXzD8BGrB4Zs337BUT26vKbo3jy6lEnfG7wrAMpNYaeMD0REpbd336Kltb0ls99t00/8Sp+T4K9fd1GaLc/G50k+ZXxyGMpCkSqPz+12Uy0SK8r2Sngno/vvi5g/qOGfiusYwbsi3w4kbAwEIv5R3gNw+KmFaT3mGCLUX9vGAb4WDNrHlp7dC/JgKz8BrcKHoKeMDaNwzGtOKu6Gs6rnzVvssIDTlhh6v3PDotNtg//MGT3FDZNCePyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QcnCIz72C47g+psmaWaVpiGdgAQAlaqzZWo4t2Q+aho=;
 b=L0LuvFW2hE4uRXoGux8kWMmsT3VSW7TRAdvldxFtblsm/raTp0n0ut3x99HLPztn0u5HQStS1o9RWIZC09W+54zltLK19ZPzVjIXt87x+cXzDu/XD3GOdiMUOE8kcFqrFaikss8taFhSeljQxs8dtn2jfKkMbLQtLStfiuZK8fJNI8E5GTSDsGJ5lu3fR5Y9Tj9S5HEN2ncQaGtOTAEvAHW2iCgSHfVIJ1LQ8MP+qKUPnLPBtM5TbkPu+zhll5dZf1RodOnaTqRD7mIPtTmDTsjYOMC5DwkPyH2CgUs6qfwPKY6u0ZhstblPI/v+KElVTNNWybSRI83EeLiNZ5+XkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA0PR11MB4736.namprd11.prod.outlook.com (2603:10b6:806:9f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.29; Mon, 9 Jun
 2025 10:44:33 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8813.021; Mon, 9 Jun 2025
 10:44:33 +0000
Date: Mon, 9 Jun 2025 11:44:28 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v5 14/34] net/ixgbe: rename vector txq free mbufs
Message-ID: <aEa7DByRdj9MHZqH@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1749229650.git.anatoly.burakov@intel.com>
 <cover.1749229650.git.anatoly.burakov@intel.com>
 <783f1afd4f23d38f21b2ce5e0c97f2efa1f8bbab.1749229650.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <783f1afd4f23d38f21b2ce5e0c97f2efa1f8bbab.1749229650.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU2PR04CA0255.eurprd04.prod.outlook.com
 (2603:10a6:10:28e::20) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA0PR11MB4736:EE_
X-MS-Office365-Filtering-Correlation-Id: 047186b9-8071-4ca4-ce07-08dda7429eef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uZoaSNceFwuLqhhTOB1ZRwNL99xHvJqFJQxDgb8PkzWMT4xX9s7Z49wjvnx3?=
 =?us-ascii?Q?s2RuqySD2Tn+qQtwWkTQ5OlSAdsXkN9KIahyimSt3OVIshdVw59IAH06F6mb?=
 =?us-ascii?Q?YKok00095As6Y+yMX8biRk2kOtKowtLw/+wXsnhrbMZX+DWPRoERK59KD1xa?=
 =?us-ascii?Q?cAOdIipsepm/vKk6C6iEmUyRuiXHbTAEFJAMoGDmUr0myew1UE3GjSiAGKKN?=
 =?us-ascii?Q?RFxMRjuhshOxRUJ+G+pnRSXL6AoWdGPPdek5klOorkQnIiz6BQ02IbE4x+0q?=
 =?us-ascii?Q?QcUAbjLABt1yrQ54Jl1HaJZUvQaA0nF6zOGmeNeil3BKFMnjxO4Gwwh/YlH1?=
 =?us-ascii?Q?REnRlG24ibY0zIVT4fdlRKtgH26TqLBmVuzHhKCsUcskDyw/Oe2eBuMgH7xh?=
 =?us-ascii?Q?JN+il9ib1ACn8Mipz77tnXjzOupve+QTvDQr0497nylDI4AWUEvcnyL3Oaa5?=
 =?us-ascii?Q?CxGXYuk7VTYdjCTrG+zmg02TdRZzQ0zikSnMl4GziFUpVBzXP7wtn6sUoQ43?=
 =?us-ascii?Q?YKmRcoUR51H1Chbvo+hPycZwHuSDvqOoEvz687ojQD2lIv1h0xohsya1U9NS?=
 =?us-ascii?Q?F4uAdrPhKkPnqNm0+b33LeSRsWNE7na/FIPfMUO7Is2a4/6j0NcITLL5fzTG?=
 =?us-ascii?Q?kSmp+e8F4L5siQAw0ZAhNUyegY13gQBoRLGa3YxTlNnuWRATvz67aJa6w4nw?=
 =?us-ascii?Q?+p85HzuE/sWUXPNWmT6FNngao5IBvZjXPhtq9OFp/hwhWiTY43YFJhmU+hLM?=
 =?us-ascii?Q?fbp6tQJlHQ7ZEkJFnAUoHp50HqdUP7uqeILzjlI824FkUJf646ILlfzM0WWi?=
 =?us-ascii?Q?KfSzf3aep5xtMSbYQAPYyRQDdTnLCR8tYIWvwKTy4oxUKp9dJc7cmzONVE1B?=
 =?us-ascii?Q?zLE56OvN+eo/2QoHHGgYZROqOFe+9E37pw+ahYQs1ETn2w5Wd8CyzsrOGuaH?=
 =?us-ascii?Q?MBgG8UtxhYO4duLdGeKFDnw1HWF70jMRsGLo1d30qT11e3HlX4mKqo6+1/DW?=
 =?us-ascii?Q?nmHbCxls/Wojr7F2zCnH1PyXARRRD3Qv7l726qhS2D9WKpbTaZnZDPot81aC?=
 =?us-ascii?Q?wWvJPj7UmQYvJ7RFuZ9ny9HKAJcjli0JziNuLiLvDZobf3ppT0Aca3r3YjXc?=
 =?us-ascii?Q?J7ljExAhwBO/B7C3w5fdtdY5aULE45Md5GDFSrOyK3C+aHNu0gy0RIZVOG1I?=
 =?us-ascii?Q?LDUGyEQIodkwXiaOaTdy956pGHn8q1JB5G7gHGB/NZxqDroFQw0CfTz5DWcv?=
 =?us-ascii?Q?SZVv37oh0poD6ZQU/Id4dq5Hwy4nFsg+mKru2POsvglRBSCK+Q6UTw0x8yxU?=
 =?us-ascii?Q?GlKYewUuh3VbU23bLIoTuz8kjXF91eKu86JbonbH+AmRj+A+ZYDNf4K3NbR/?=
 =?us-ascii?Q?XhkxhtlobbYHzKwXbBWhs5My2wOUjy7p4RY+khDw0nkvsy4irA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lYxuVYQREO57P4ad5SZ+H4fwsuqhj9yJbXTdeZ4E32XOYZS68jxq8slDOgoy?=
 =?us-ascii?Q?VAlpqeaPr6QxP3Ch4yDdp0dGN5B1+z6UHClgKTVxY+Z6OsogIc7YQs3sEg0e?=
 =?us-ascii?Q?cCzVz3V2vbLzaIfT+NW0Upf1UeAqstb9ZN8R+uLPjslP8YOyKISD56TqUGD7?=
 =?us-ascii?Q?eyZm20dNZ3QhEstNASyfKfNWh53O/TKlv2uHLCK4kzuWe7kz59ZH7Pr+8137?=
 =?us-ascii?Q?+CmqBXUKLnYHjqhN/rVF7B1WlJXh11NnlIEBgTKNHGzOjOcTcPP6ZdCly/VN?=
 =?us-ascii?Q?JiB9Tjz74E440Czw0K5nJ4XntrS4lwdWRRzr2QattQ16AkwUIBoVti5ZKm4m?=
 =?us-ascii?Q?IjXSYfj+L73f53V0PBmWhmitobZ/IUIT8T/1B0gOKiO7Y0hxtvmZTTy7Mhx2?=
 =?us-ascii?Q?Jqu9QZp2wk5Az3B3n6vQ+tQJ2wpKdiE2tC9pEWATcj28ScXY9tt/y2KQWho3?=
 =?us-ascii?Q?xIBjmq+KaY8oOTJnXzYcoUzikW2Ej1eSM9dbLSLh72GoDkc2n1FpnGVqJos/?=
 =?us-ascii?Q?0EdOmV6JHsJUMld8IrCo0+oMr6dcpFkem8BZjwUTOoyQvhzmmbi/luJdqhAp?=
 =?us-ascii?Q?oU9R3iNmM3U7btd9fz+ANMye7fMvZbwJ9pW6LCbOcs3fJ3mmvap3R5nCM/VD?=
 =?us-ascii?Q?WVuON4tGpKyDrv3b15qpcPbROVwQKdOGNjdrWHFYjBEYSwd31Isl+iBy8o07?=
 =?us-ascii?Q?fdk9I1GIh6NubhY5yGpRquDtgYDLbryh5mbVWA2x0PDSlRaWJ/rN6zTXztee?=
 =?us-ascii?Q?AirTcdSEeM/mCzJ7zbO/74JeYNrLEINn8IEA3zUKe2sSP8hIyp5hBAiNvBb6?=
 =?us-ascii?Q?etxMZpSULwG2shcOwtPcvi6+KXVHyj7Ltuv1mkIcriauGrQj+0FYQB/gnqot?=
 =?us-ascii?Q?XQnTYbJwd5k7WUYkpPNT1RgxhxsUccQhKIV3JvUx5gWLzo6X6phAtgp16Ukb?=
 =?us-ascii?Q?ZDFJmPl5+AOWm1H5Cr/ztfwJbOwqtiABGSiqGqhZXLurZ4fNTo9sA1jUk1lP?=
 =?us-ascii?Q?/tpDb93DRJrKv1kuj/c37i3pWUU5bTeUnqhb+GKc66TqHi/blMjbj1mFmPWG?=
 =?us-ascii?Q?BaDL5jZhdH3oUtTewjWT3u/JAbuHgIELfcDKpSh9IbDMKYsqvwXdD1HfMXBL?=
 =?us-ascii?Q?G6vZ8Pn4y0eXtMdCHnnka1KMfmFd0fdI8sbgkjR5cCEUga5tCNiE11fBW+B4?=
 =?us-ascii?Q?hLzIINE2ktVWreyqsp/WpV8JMl6ucYXQbQm7yMc53NUss0TZJUHjoktA8ONW?=
 =?us-ascii?Q?keEDpzgv+/mOOlLFBMmwbSlZByTGnhW1fZycMTkmNwL836AqbMZcDqjpU/gC?=
 =?us-ascii?Q?POSLcxNgFCbTyCUe83c3epd2sdTfuksjLhULInDigbypBwCQcjgAIqk1yUI9?=
 =?us-ascii?Q?L7R2rAg95qoZ56zE5MyALBOtxWGhj7S8gw14JAZF4MOo8tmNCeaoTxuAEQwS?=
 =?us-ascii?Q?SRXN87yJG5pte4BMm8w6xURhDqgGU4tnfsWCLi5Cd6tZsFvBj7IT709cv3EL?=
 =?us-ascii?Q?IaFgbA6GatrVEsKCfS38Hrl8NdD06/zukwsBbH4gNVbeLDKXjl+h/8NRt8ZQ?=
 =?us-ascii?Q?JV3p+gpdZEM3VKc/A+kgDrgFnD98DmIM5Oin0n+Hyq8Bn6+ZA3/wsHfCl0Xc?=
 =?us-ascii?Q?Cg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 047186b9-8071-4ca4-ce07-08dda7429eef
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 10:44:33.4266 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BbIuafKDEzM/VHGbr6FWLNyUvZokDTTh0V2a0/3BQq0X5tk83NYwKaiyWd5iZFO/6XzhXHW1KaKrYlV+NAuGh085gLjJqct9uyU6AB8lFLA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4736
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

On Fri, Jun 06, 2025 at 06:08:53PM +0100, Anatoly Burakov wrote:
> There is no reason why scalar and vector implementations of tx free mbufs
> function have to share the same name. Fix it.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

