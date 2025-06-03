Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4446FC5AD49
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 15:57:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 739B640E3B;
	Tue,  3 Jun 2025 17:57:09 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 4972B40E39
 for <dev@dpdk.org>; Tue,  3 Jun 2025 17:57:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748966229; x=1780502229;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=G8Kulq6gxzfxw5vYrOMCwwgMrkjX6ZbgkEgmppUKpos=;
 b=dqomazQtwahOTagTS8cpEmUJPo0LEJt31yxopH5d3w6Ajvp71/HmRnwv
 IT5litvgigWGs3zXNobTWKKreMM2eJxL0KfhDBIOwkuZ8MzABZlomGxjd
 fRJ7WoyzxqPrhd4L4EX3KhiWHEDqufZnEjH6YHq9kAHB1xpt7WPst8vgz
 ttvJ7eWds9IqBo6h4RMkacR3X7QS3awnXCEL+P/g0NanDOdmmEJtdPEM1
 MtY/SaXloLy2n4B/gx6iKh36zGmF2sTwm5bctfqY7tzFTr7so+/UcG8o0
 HhGG5KcCbPstOkMPW8mue9CSCZrkUehsx7ogg7LAIEHigKc8HgihyqSxU A==;
X-CSE-ConnectionGUID: ouxGTNANSgWj1QCLVeFVKg==
X-CSE-MsgGUID: NsPKP0IpSIS39Gm40ERqFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="68448673"
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; d="scan'208";a="68448673"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 08:56:30 -0700
X-CSE-ConnectionGUID: he0p2SIJRraGxfisXvbreg==
X-CSE-MsgGUID: lMDe3ol7TYqYIywl3eTR2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; d="scan'208";a="148747487"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 08:56:28 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Jun 2025 08:56:28 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 3 Jun 2025 08:56:28 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.50)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Jun 2025 08:56:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GFU1RP/IGP3L2HFmhFDCal0yaBianmRE/BWBDkZo+ftUtVGES8gToRz9rEp7pSbpGnkxFzikzG9MMTGpldJ7U148qjznjaz8P1WLPDHTYbBotyuhbRiLu98qRcX/pb3MGOq+PAWGOO3jOofUDZY0K9y4c0n3M+0RNzX1ukFhzAiTWXXyFlBhNwjmnK4HD052Q2QItvqwoFdOKczDA87I4PdaEsfyp37FW3aoMeJCykg/zOwBrPKVL98WHsNc0JLGikTE4S6AIAwLSFYU0yxxKnXuBe34sle0KzxLFx4FjVl8tpqr46Gwt41Uc3gaAyxGTz6CLuY6TULDgA9JneLACg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=azUO6tMPraTtaMaBNZeH++xRenfl0d+gGCFoIKMGCrc=;
 b=FEZ348nHCtHoPbnpr8mVKv/RCPxfABf8/D1mon6btlgaYrGTkRE8XaEX5l95Z9FWLJ4SgiDDURfWOy4YI2PN2yWzAoOpQ0DhvMJAp7Krl5qY8dqWgEpUiddT5qCwjLxQT7Lbe1/L4n7J+q7GQhWfQr2JgXlyKbajV/Uka41yp4QtbS28cgt7+GNeeaiFAuzS47kLP57aMfoKvDLoKdPZrpGV879mxPpMNqcJLcLqtmW3TmKlPQQEkgFkhs0hIMseHyjGo7vB2yFeZ2CwQNLoJXXhwhez8G9GucMJ6GA582SL1hnQXyCWvfBus7SiZtJcR1ko2SbqyCb5iwEsnIBrFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM4PR11MB6430.namprd11.prod.outlook.com (2603:10b6:8:b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Tue, 3 Jun
 2025 15:56:25 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8792.033; Tue, 3 Jun 2025
 15:56:25 +0000
Date: Tue, 3 Jun 2025 16:56:20 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Ian Stokes <ian.stokes@intel.com>
Subject: Re: [PATCH v4 04/25] net/i40e: match variable name to other drivers
Message-ID: <aD8bJCBnpSzjdCMY@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1748612803.git.anatoly.burakov@intel.com>
 <cover.1748612803.git.anatoly.burakov@intel.com>
 <5265721cd3bba6ce768a980c4c171d95ed7ab71f.1748612803.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5265721cd3bba6ce768a980c4c171d95ed7ab71f.1748612803.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU7P251CA0021.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:551::23) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM4PR11MB6430:EE_
X-MS-Office365-Filtering-Correlation-Id: 26b55fbd-f0e3-4ce6-8012-08dda2b731b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hooqCbkZEInMdmBifsAulOt8hYaW6uoNQ4y6sJk34ly+qL8uATJiJ5Y2+VJt?=
 =?us-ascii?Q?iiTCRlzegdkY+xUK9ZinXWocepyknoaG0PaUmJj9U1iXRHa9XC/oitkjT1gf?=
 =?us-ascii?Q?glRrG4WsWCuV+7iFtFnp1S4s+43+VSdA5ffW2paZR46yCEulkBGHQ+iKOohJ?=
 =?us-ascii?Q?+2SHk4V7lD6rNbISM2i6CvHAg4oYM4Fm6XEb9SJP0Hh86stq1VMZS7i6VSmm?=
 =?us-ascii?Q?h3T99GFn4NffFRG/35cmOYswjzsLbcR3ShKXsTwiutTVIqCSCfhBWXqq5r9R?=
 =?us-ascii?Q?P8qRJlUlw6DytOk7TVnPpLzyKw8PQZ+ZTvROFA4w3lDrUL6lX/0GenvC9DSO?=
 =?us-ascii?Q?6iY3SIABAS2bS9xIpLTzwNfxcZL7b95XTYYr06GwhbD1ZfsRJ/KnVfBexsvW?=
 =?us-ascii?Q?bK6JmrF2FXpdGRhVYTZHBrdi048rg5odO8Cb61/SqC00aeiun8FZSJa0xPoX?=
 =?us-ascii?Q?5Zvl5zhsqCvO1FhDAFeDqldGxWGfzSf+GLY6eEvkfkcK183fziIe2bwr/2hw?=
 =?us-ascii?Q?L65YBZatQ1OECWTGL97ijs+91KrWWs8XLnLkAROOxton9dxHYk6pRRXWatt+?=
 =?us-ascii?Q?ao8TwEEReOnVWbZ/yIDculIEE/gZwQjQOpK/d51U1bxlJLaN/NI7ZeM1H658?=
 =?us-ascii?Q?HR380rpbhMhpmdXV8aS+DyGruNa1hZ+bObMRWIItRC0Y3q/Wh3/i94OI99XG?=
 =?us-ascii?Q?Kb/0uziH5A08HrJeAPMmy3M8sVnv9rJ2d3n1OE7LRTbboKFCprRWNqdb+x0z?=
 =?us-ascii?Q?jxk7QXpVMfY/PBMusnyRx98l7wokG/NOUijtvlj6uA83N6ITIE7EqhHPbGQM?=
 =?us-ascii?Q?ueEF+g5BBANEE3htlLRtWmmfOzqgZJMQzizGq3I1ccmqKAu+w6txtVrwXZSk?=
 =?us-ascii?Q?fiQFYrRQHmq2LBht3SvEUvv9EY4ETiL07b8zF7POVMoQ38M3AGKd7mLC/E9s?=
 =?us-ascii?Q?1FOuYFoPZzCQLlOVM61aPzgcW5isBdsqdkRcdgck4xIb7RlmfDWctiLTIFzU?=
 =?us-ascii?Q?PiiSnjYMnuAhC1F4xGw4/ux/QXZDFOq/EAsgdmbfw9RIEy7cuQybErlQIyEl?=
 =?us-ascii?Q?U4bjKC+Lx7AtHTlGLrOgks5R5zSMncyOGMlUh29uZVv3ekk8n3TfQtG6GkN4?=
 =?us-ascii?Q?o2Fign+NPp1GOXtGGqXF6To4HSn+YeueLijDE5fI5IawUZI4wotYFafVnefI?=
 =?us-ascii?Q?x96u3EgN3eVIQ59c+iAkBw03OtEd/muD4GPEVzIpz2fibymuq71j9cMiKZLD?=
 =?us-ascii?Q?kuPRqXgmcqML8v4Fbd76tbDJQpnMRdEcDTsx3F+2KZQEYCkeBjq1mDZaNIhT?=
 =?us-ascii?Q?PucfIpIHAh66RLY374oL6rVFgCQtfiNqwfu5LSaVyGy5tWXMmXELWdsPICXl?=
 =?us-ascii?Q?gyXVG8YIO931etit98yH+BxEy1F7JdvrxN2CwXxTuwYDhNw94g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W5eB8nnb+ybzfHORCi66o66wTOV9Co8TbIP25bC4xDq5yX61Ty5y/0IT1Zcp?=
 =?us-ascii?Q?JgAEaT5IyRCMKks+ahL13qpueAqoBxvCoh9LL1McNmMAM6B4TBD2m9Uvx3NL?=
 =?us-ascii?Q?ur3hHUl6Rdf6HdcIbVO9bcY+zUqznODvp6ELDtd1cUh+AhVu1c/aBfeS52Cr?=
 =?us-ascii?Q?VCQX8zrYpoOKzGglUCCIYi0l9twbAsrq2MlnjKkCJsdsjaGQ5pcuJ+QGFt/a?=
 =?us-ascii?Q?FzboJbvHEEwesYVeUj6c5ewCydd4GMs80TLoostwfNAF5Fy0U4ZIBz12BLhS?=
 =?us-ascii?Q?Gt4BZ6HBSMyVfsd2FJ67ENoLCcKY7LhhqvbM5iOgM/4gOMJUrLmL+QD81g8m?=
 =?us-ascii?Q?dakkmjTvsyLHYVuByamspMYvWZPqb/G0mu66x/SQAxM5YTkQXX8lV1lAjRuW?=
 =?us-ascii?Q?vJ25VGiNF+iz8AtjUZeQz2I5xRph9BvkPPqoh4L5QjSYsOV9FV6Hac92hSRH?=
 =?us-ascii?Q?8rneir0sqmx2x6ODdbGVGdGewt5NvjU/wnm9usgbX08MLCInPOhAw1HLX65W?=
 =?us-ascii?Q?HnS38XR6vDR41ZZxGb3sGiuJOnCcC56ODw0C9YR66yJXSJO2m3VxwOj6L0zE?=
 =?us-ascii?Q?u24tzq96Jkog7f8xwVNQBRNTk35QySaFQrnXyXAYGFw/qhMUY+JuDVMlH65l?=
 =?us-ascii?Q?BwNtCjZE8p8E5UD2SXXjucULPxu4+hgqQLfitShxuEfN92nNfM/k24s7kNuu?=
 =?us-ascii?Q?wjFgSYcFLeE+Eg+cFh7hFRoav2L5+1M2TlA2wgZ0eLQArUM7+vhl9Y9XVO5/?=
 =?us-ascii?Q?B1fKuU/KtWANa4TO01cy78DCfv9DfQcP14r6oaBk5eB7dxzGCF/cTm/y5cHA?=
 =?us-ascii?Q?bfBM0iIVNIIKqW5gvE9xyLMQSBxM1D1mmA8jbcZTce7cngCkrPR4/UGHsHp6?=
 =?us-ascii?Q?ueP3AORuxf0SNy7V6ibUM379gog01GQ18Nk1jUx9xml+uVQFQoZRDzCoAVPp?=
 =?us-ascii?Q?rqo3S4IPmnS6tg+8+g2XJF0iCNo5ypnYpLl7G7ZVBCWZTs6Ej2qCy8e52hNt?=
 =?us-ascii?Q?mvS6EqpHIX5ZGcSDaNbMOmEZ47ysO+x6JoTC9xp50WyZtnewvrR7I36s2G7p?=
 =?us-ascii?Q?4GjNJ5w0C+njQ9YMfpNSVQCcHdj3zfpeS38vJh2hLZM8I+cLdvzaIhyXJ3hf?=
 =?us-ascii?Q?6tON0JFrQ7BWuUBfswA4xpvfseiYQX0e5Zv7zXondEq2HzUxsgc0MXvNc9w8?=
 =?us-ascii?Q?TEyWqcT1KEN6yKUDXW24tsmxUa+a4fiCvdMps3aWMiv4q4b57ArKUZ1Ll9fk?=
 =?us-ascii?Q?H40eV8p+Va47ecvYRCtqp4z5XlWvCQVinc03HxufAQnLn5pQGaxDwOlhPD7Z?=
 =?us-ascii?Q?XJZR10IT27Zh0ug1Wt7gZhSyGHxuHqJxg3txw84MQKFefUD3Io6+VzotuTen?=
 =?us-ascii?Q?iEnB5b+xvkH+QaDPV1SMQRomjKlhEvAN7+kDoEPFrlXRkC92IbKq6tBrz+O8?=
 =?us-ascii?Q?0cidkKmioZpRT5dvG9TyCXW8+G8Wj5M3GizllBLU92rbg7GBCY7JA1IoJ1Ie?=
 =?us-ascii?Q?PxvA+vH2kxgcrH4ZnJHmVSmatngTS8K0YAhI9wmulCHOytmAA4QzIYSZvjJL?=
 =?us-ascii?Q?HDP+PxeHnRqFMOTULOtfk50FZrUg/4EeS83ha8yXicOnfRP2Xc4LjZP1t2gS?=
 =?us-ascii?Q?cg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 26b55fbd-f0e3-4ce6-8012-08dda2b731b8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 15:56:25.4790 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lKswjmvfzDqVSQAdvbxqCwpqsJ1Va4GEfrWZJYDce0ROTPRb6bskZX0Atf98ECkDPQDcYmW1Y0wGk6q3Q3Qm7aRuyUw0fG3EQgucUUnO4l4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6430
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

On Fri, May 30, 2025 at 02:57:00PM +0100, Anatoly Burakov wrote:
> Currently, the i40e driver has a variable that has the same semantics as
> in other drivers, but has a different name. Rename `rx_using_sse` to
> `vector_rx` to match it to other drivers.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
