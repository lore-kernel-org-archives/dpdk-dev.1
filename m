Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA147F46453
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 11:21:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 16B814025E;
	Mon, 16 Mar 2026 12:21:33 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id B2E6A400D5
 for <dev@dpdk.org>; Mon, 16 Mar 2026 12:21:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773660092; x=1805196092;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=BI7o5ydkVo46+T60hZKe2xLHmpgj9WZVk4rU5uhi380=;
 b=EPrD6ZsG0KajciR2YBWaJ1v7PaNKeyeXAiOj+apuk2vbtfdEIdA4/XFl
 o0rRebxuz2gVDy55BWtT4aQ5Gx3LF2BvMW7Mld7O2wXcF4w34K2Wxwr0P
 iV49t/wjhDh2JBWfbqARypzPgsAIx74gWvAxwB94rwx63ToBKdVOJb4sy
 LK529LY96d0xjrlL5RO4/oNjXP7lFUacta0B0KAiJLutRVl0LTSuR5RHz
 woKTQRwfwLhjSvzAsaYdjhAzTy4RuTnlA5m4LIg1cRbe2nZnRtR0Geod/
 Dp4mdf+b8bJ/m5Np16fVCRQVAGk0wnzwNGGgRzCuDJk0yNMYGGbv9hcin w==;
X-CSE-ConnectionGUID: Gp7x1QD3Qjmt55xaCmclHw==
X-CSE-MsgGUID: WooVk9UQTiaM3W+YVfa55g==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="77280953"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="77280953"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 04:21:31 -0700
X-CSE-ConnectionGUID: L9ffNOkAQNu3y2hD2iFNVA==
X-CSE-MsgGUID: lUd3zDCfTGmCuNVC1lT+cQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="224107589"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 04:21:31 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 04:21:30 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 16 Mar 2026 04:21:30 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.12) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 04:21:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Soj5P+U1AXLvBJbMWlK6DXzxGQipupLaS78x/8gyM+MGk8D6kWhZr3p75XTxf2WggEde6h23xIQYmWKQoj+62tUyIs28shlZkp16Z55XObdEYvwGNS4TYjljyQO9aTZC5jcnldK+LWCvWttQSgu6bLLmEFE9u03hr2ddAaTUGDqQuz4Qeeqd2zXBCBlhi8rMMI3B3ULgVvDY2V31tpLsiP7ecdA9gGY7Bq9umZrdndpPgtTMRGeblJF8ze6cDGc1qHMSpXFH41EDY7GNwug2DvGewWyFd6c597hD56gSOfsxnndmDqYW+OIePRIexZeHM9CJ5AZ/lIFt1EG4K5JvKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hcvenisLqBcc8duwfpoFQmre6zMdOvpZvkZuZlLCTpU=;
 b=Lk0Tu6IY+0564h3D+SY+tUkrSXMKNSxaNmGHf32o1oXIgtVfCMW57Ig1Luw7xeeq9w4lJdwdZ18csro7w+umdgvUaIQE9hSx/SKpcqTGwFGPxyFUEsY8R+yVL3BTmNsjP+bON7Yj8LisR36RHEdUAlJUX92wtAab8lNnb9Keh4IIDbGdTI1Inx0wG3KtJvw08Y0h3wmYxmGbeQSsDVnqIuWowg4EvPz+IQqPrEaK565pkFgSsGOvj+FULTPnEkdEBb4B+05lgfPzo55a3X2GoGhjldzc5RG8TsscNewiTMlq8nnnPlDIMVhByMqg8IL4pUnwzTafbWtGjUF96sns6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH2PR11MB8779.namprd11.prod.outlook.com (2603:10b6:610:285::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 11:21:27 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9723.013; Mon, 16 Mar 2026
 11:21:27 +0000
Date: Mon, 16 Mar 2026 11:21:23 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v20 04/25] net/pcap: include used headers
Message-ID: <abfns2zEe5kOkNka@bricha3-mobl1.ger.corp.intel.com>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260310161356.194553-1-stephen@networkplumber.org>
 <20260310161356.194553-5-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260310161356.194553-5-stephen@networkplumber.org>
X-ClientProxiedBy: DU7PR01CA0003.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::17) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH2PR11MB8779:EE_
X-MS-Office365-Filtering-Correlation-Id: 95892b13-0fe1-4e17-a954-08de834e2a74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|56012099003|18002099003|7053199007;
X-Microsoft-Antispam-Message-Info: MjI13wjilIY+JRB+MK46RtKKZyXUtRxTELL13gd0zRRu50xp/e3tXcnbLuuCiTMvkqNeCiTAfondvMQz/bXSSYQmlNdPjmC08SGae6/0/5DLh8aQ505kfzwdmbqz23R11sSiajHuZByCXrPja+LbdaqlgBnWbBGF656gbTrhTvvE8iVOqrqMTRZWkYgT6bePzJW1f52OGM4A9aZJ8qbP+2d1OO06n4lKHI2gCK1U8WXNVzhztxs9kczCbXtM4Up3H4wBrGlAv1I+YWfnUO/7pwxoZRiQJFFARlQQ7rbyEmbDI/Je7rChKv68FFU2uvAs+JDpgRiJAl6ubC+u4/2XvmyIjztvBjvdYzfcAwaW+M3wmmGox77InQ1E8zTFncmZB3roRUqIA+pAEebhr0Y0NuQhpYF43X//k5awldwOiJtijrD9owYHAKh59aJbWqjWJopmpoz6KoxWnqMfh+CT0U8iP4YlW2iD1jR9zbFC4ggfxzwRiVHy1LBRBeAcYzGdJ9UOvz3Wpy1ciHnmpm0PAtdZ1gQKHB4EhzYNKc4pdDuEc3NJfDrAdvUO9ZhaaFjagI9b1Qaz7Nq1mD6Zg3iopRuBp2Xu1uMWlQSOdO8TOkHRhEEGTPD7yEEQBKPcMSpHSCEDBYS9bvStVgVf3/k6lZ+rhzbaRQFbd2er7wpSCn9lsL7voYOEFIrabXzshObf42nXpS2p63PZF0A1lzxn85JDdJB960T6mwPogE4UP/Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(56012099003)(18002099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dAUy2/8YrVnFXLPN5Q5eaGfVWqeMoG1/WilTRsqB2KpQmveYPy9A1NyCgJPI?=
 =?us-ascii?Q?i7lM+9rVZaQ8BPuYZostE4mDU+YB5RbwMoSMwmNN3t1taCsUWcd1K8KQ/LL7?=
 =?us-ascii?Q?4UitRhGLBcRv1weyimXEouzvwauhbspvbsjlt35OD4dyVAaG88keeJg2j98k?=
 =?us-ascii?Q?TFcABeC/4N3pKRAeXpvHa1+K0wbvwG7WSYw3z87ynybDx82CASzrf2r/Oqdc?=
 =?us-ascii?Q?AT2MiSudKpNKTgKZZPJLeGGZSZMhkIkh7BNqHRmwByUJXTM1VJTx6QMd57cD?=
 =?us-ascii?Q?X0K8uiRrum5AyTLCAnm5yH1zKSaQ7s49SNbGL/b9+DffHWb8eLFKVEmNC8Af?=
 =?us-ascii?Q?3uznmAim5QIBtEIPqXgfoG3b6ZQeT4ix2NEI4ocgV7ZGITShM0L7QxPPJzLR?=
 =?us-ascii?Q?kGWW7NgVz8u2ENA4c1VlPf2Ge76isz83AeU68YWzNmIPi11dpg7Lfeiityma?=
 =?us-ascii?Q?x3LSPEFB1G1pnexki0zgKpVypymdGxzPSX3+I8HfJUEgQsZ2/272Sjjg/OFZ?=
 =?us-ascii?Q?PfkjlDmsX0phwx6/SL9Eje5bQKrwX48owazxo8zcgfV257Om+0euNyWbVSsQ?=
 =?us-ascii?Q?0zeGMd2KuA6cB0/EYIr6kQTPwD1iOjH19zZeXW/9l7vaLW8dhW5QtMcNkF/D?=
 =?us-ascii?Q?/3xpFVsLK7/pMozrkrDv85mMvSnrBJEreAB8XZbGyd4Ls+0fz8nvwT1knnJg?=
 =?us-ascii?Q?/zvldg7Sl5Nyh/qOmkGclECDsG0c7AklojZu6Um8a/mu0sv3cFCNL26rxVg2?=
 =?us-ascii?Q?vvN7a3t44K3S2D40XcogaleWOxaee8lSC7Wkd4OIYO+bU+tAwBqzx/tUgcjP?=
 =?us-ascii?Q?5XNfS04t4ilFD0WF8L9JTFKa+7aq8PknKEhJBj2fR+S2gA7u5g4uQ/FirS4o?=
 =?us-ascii?Q?03etMmR0rh0/GuRMh7bm/YPmKm9spGzeI7Ldx3KkcvjiYCFJ6pEEFvzrZL9n?=
 =?us-ascii?Q?2AfYy/+tsqziDzra6XLi6kcVOxDbts9QyD5aoog0vdLmja770ddMiOD+c6Xi?=
 =?us-ascii?Q?akgLf8McDFnRb2LZUSEzLx1TLk9p6u5oJjJZPfX/liPvXvsCyc4d9AbP0P9V?=
 =?us-ascii?Q?iQ6uQo11rD5jJ3bfOAYgXX8GFV1gLR1mcCZIKF7PJD1JwoTsCJShnambqLju?=
 =?us-ascii?Q?fMzs5P2j0nlvyJ3s/RxpxA6hZbSvSz91HgD02QicwtTnnATvJoEeTd7JkOo4?=
 =?us-ascii?Q?jnVDbxqdfiHlcCj4H+WcoAZv9Y74tYoYXOg39c5KcZNtFH9kD0lQWzeBRZm1?=
 =?us-ascii?Q?LajALu8YmmJVlBXUFEiBzriIqoAkJcVdCbU5fLtV5x2zgPL1W+MFj4NpOyl6?=
 =?us-ascii?Q?2E5rv5G0qGB4Hb335Dz0tSeAGfopdiRLER8Pwia5ZwgT4R71m6UjkBcSt0AP?=
 =?us-ascii?Q?ltuxgYgp2K6WY5CrsEp75qI7H2RenHnG6KhsbQ/jTm8pWcFiwKBUEY8MH3je?=
 =?us-ascii?Q?ZhuIEVis/MIVK0Ft21Y+vr5HoX+nxdyty9iR9UvvdlesZ65XJo07rcLP4lFY?=
 =?us-ascii?Q?xVSUEQDy6PFVLs6VWX/0prgYtiTpk1tD+QWr5be3prV02KGI+azv+jspXtRW?=
 =?us-ascii?Q?hw+JU/snq+GdslhiuF4BflAuLkjtnAqWjfzDg/uOOx4tpd1yWu/LHnSYXy0x?=
 =?us-ascii?Q?Sd/bm+j2uiZZtCIsY5A3tqgRONcERtdbGsVG7uGfqUccrybYBQFv4h8jpJzN?=
 =?us-ascii?Q?T5Vylw52aFeml29re0RSkyqWWHSwy00HzW2HCRwKQBic2ol8F6juZfqprclM?=
 =?us-ascii?Q?0eqFqxtktKPZBWTknzKTMMovcM6siSM=3D?=
X-Exchange-RoutingPolicyChecked: aFdxSw6OW41m/pYg5XlIikVGpRxUzMbkq85wZgsDUP4XlGWNz1+S+Nst3UnEi9OBcWQsXOleDUxxVXoufzvmV0VEh+N79N61SIgbMjiJlAcu33T6PdH9AfeTanXr1TwFGwmuLe4lzNRGuy+zbUWoUScwHz+sQzrt9rWIv7vvXV/PjvT6mGd4OP9Xjg4iY2LM5eASMQkzpi2O2XMQXIyVGGE8inBOOCr4VwEYpXiwWmb+XxoB3M7zNdoWxQDrdyTMr5L7JUeZE/kWqgDYFbDCm5I+lheldLFDpUOe3KZnPt38yw2xUXQT+AvtkIYBVgUUwILFakxlZUS53ccKJkFFPQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 95892b13-0fe1-4e17-a954-08de834e2a74
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 11:21:27.7363 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ybNzf6lZNUjK1btaLVDxP6T8al3XGR6sb4GSHLl4qfAgPGGBexdQcuPXimsyEWzJR6yMdCy80BsfPuIsQDchx2F5oByBqnSKayfzrx14Z4c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB8779
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

On Tue, Mar 10, 2026 at 09:09:42AM -0700, Stephen Hemminger wrote:
> Include the used headers instead of relying on getting
> the headers indirectly through other headers.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
