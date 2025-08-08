Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A848FC87FD3
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 Aug 2025 09:18:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E984940652;
	Fri,  8 Aug 2025 11:18:00 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id D8D92402AB;
 Fri,  8 Aug 2025 11:17:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754644679; x=1786180679;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=nHAu3L+m43amXdgHUjBx+84doXBGRw6bOUhckwRWjfI=;
 b=IBOPmWwPHofMMslN14MseVEY7sI91zgo0grwD8v/2sDzaOh2uL9fFkls
 OUjAouktfREj1bSzc4Hf23e0HAUgrPBAuHdzzGv3Z/k0OzPU0cdU5Gqxc
 8GEbTG5WQO+dTNT0klOiR//GFGYR5RfvLSEwAaq5L+Qj+68brG9HEn9ab
 fSX7qf8D8IcnGktKAqbjcgBbVU8V/QqHhhC6dfyyw0CG3nPCerbbZKgm0
 10eO4TsPMh5fu/ipQNXX5Mw4INH55YU7JR/jJy8dXF0DrBd8Autjy4DHi
 GtZRhOz8XX8v6/if4TlHAWm/uGgyQx4H/90mY6YCHJkzzvwERDh7ZQ8kx A==;
X-CSE-ConnectionGUID: ilrOzF7HSDu/lLIiefHMRg==
X-CSE-MsgGUID: y3KbHLhPTTWG7kXJXEw6jA==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="56868801"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; d="scan'208";a="56868801"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Aug 2025 02:17:58 -0700
X-CSE-ConnectionGUID: 8YNsEhPsSmGg9UH3/5qdLw==
X-CSE-MsgGUID: lVq9jZEXTjazb+gH8UiVzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; d="scan'208";a="169747735"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Aug 2025 02:17:58 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 8 Aug 2025 02:17:57 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 8 Aug 2025 02:17:57 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.65)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 8 Aug 2025 02:17:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fro620UAJLPbkBeCHXA1B9PpAwKipoupMnQOP/+WLdN74exPTanf+EKcLcM6DAlwDQ3SInkWkKYJO8wg5SBbRfV+MOXemTm8YLvbacmJjX7swyNF0k+AEVm8Xmbhk6Tfhd0o21w6JkpKY3tHcoi/v4bU7D6U7fF+w9Nd/P+UBKFGnG88remLjjiMiDZ1/P+LZW3S5vomflzrAr+zEyUJ3o4cb96GtzhD5oPTIzsiShGxuWmfQ+4FNBHbSkikkIyRpQh0Y+mM9bz9hUdWR/N1sT+N1h8OUGXwIXRetoHwgkA7/fC97JxYtcZKDnXouMuHNTsjH8o1qTdIbkaI/2EJvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3fgsz5clHF7DZGzLIEAkjp9u8yjRTtAR3ZbuE42Er9M=;
 b=t9wDGvZm95q96vXj4tnjXVJglmQ0isHUdQTAt9yzCHxDF+pri4FqnhyAJwSuPO9You3WpgVZ6L6klfPMl4Dvws0ZuNFwLlOabmRFIHgOOXymAKQj5CS7Say7FNQ5d7wh6VkHZV5kqMkzKuBOHn1Tmd9b2/7Edb8Rh6lX5hTwN5zIf7mPWYjgx+icpmaj3lLsSzJrEC2vLY72TdP49vXPeotg6F7EW0OxkoIjZYrlWPALZA0QnlKo5nnKH4jRoa7yzG4q9d+biGwgzmfzGoGVJln2biqGkRvLgMpe3q+pdXB+lu4KgCrG7TcmUZSnqgGH023oomW4W3uN1lCWf4+mDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM4PR11MB7351.namprd11.prod.outlook.com (2603:10b6:8:104::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 09:17:55 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 09:17:55 +0000
Date: Fri, 8 Aug 2025 10:17:50 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: <dev@dpdk.org>
CC: <stable@dpdk.org>, Ciara Loftus <ciara.loftus@intel.com>
Subject: Re: [PATCH v2] net/ice: fix VLAN tag reporting on Rx
Message-ID: <aJXAvj3uc1WgD5VM@bricha3-mobl1.ger.corp.intel.com>
References: <20250714161050.289375-1-bruce.richardson@intel.com>
 <20250807190826.327466-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250807190826.327466-1-bruce.richardson@intel.com>
X-ClientProxiedBy: DU2P250CA0008.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:231::13) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM4PR11MB7351:EE_
X-MS-Office365-Filtering-Correlation-Id: f9a4ec15-ba7b-4e45-4d70-08ddd65c7552
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AkhbAGYyjV/2awZZ2FKd45qnpHwx9HQq0r/E9f+u4wUhWvXtGSX5gxqT+QEu?=
 =?us-ascii?Q?8Ltp4kWJPocJe1+8Xl13El5Kj9s4SdR88O7grj68r/k0wKdI1nhh1bw6zz48?=
 =?us-ascii?Q?t7JE+L+jRQJ05oVsToEg2Fj73cIqGSOTZv1/njDJhNWEgoA/q1KHe4kmLfjD?=
 =?us-ascii?Q?NLQhG3N2u71jDZ1+6NaujJ6Hk0rU3c15QYUdmDw/NEJfWSAhr3e/ZgydUQAC?=
 =?us-ascii?Q?pCC+k1lp2Mu5zqRLP2ppV3IYQeZl0yu0d+5SpSRSsutyQMH+T6x0anzLSPJ3?=
 =?us-ascii?Q?Pcdhsc8bheDC2fLzaHbjOzPx48m12cuxbVPq3mdVOIEIa4xm6wwZlvYXWxp6?=
 =?us-ascii?Q?dzH8pR+o797H+g4p7S6oknyCNiYQGHB0OzOV+g9nSEJLtTkDQMAOpaAcwXX3?=
 =?us-ascii?Q?BE7J5xmf5XfqiGob1MOAEQtrjgVbFnaHMCSLsbKNWML31yaj4QkW3ZtFjaOw?=
 =?us-ascii?Q?qMK8eM+mtZcNM97nhvLPre1QD+JyCFf4xh4BB5UiZaFSyft/AlkR0TVI0DHH?=
 =?us-ascii?Q?4mGgB+arPBhPiiEsuUaRikA8zmuwBjZDE3lR1rJC1XbfUoKifBuoEfMcwemL?=
 =?us-ascii?Q?HDtY6utcDsFvfpl6FsTYomOD5vWEiFed11zml13Xfn1NduXA4+yuG3k/ViGn?=
 =?us-ascii?Q?GkJ7O5T3ctsVJ7+Br3p1a1/ALKb37b9KXBK/E+T2lSJSn4zvJ74RXVCyfmhs?=
 =?us-ascii?Q?qY/unu+qbPLUL88GDn1rldlCeVJGXPdlTe6Jq3Z44Gl8UbZY/QpjwKRoo14O?=
 =?us-ascii?Q?c4n/GqzW33qipYFE0+B9YaR7gFPjZIx9azt/gYx03oglu0T3/w88xCwwWN25?=
 =?us-ascii?Q?stp1NZbrq0n4NoPT/lg9TBJFauHg8lKAyWK/RJX+UZ1bY3nKLLUIYOCc4jrJ?=
 =?us-ascii?Q?BkIcfwfeKs0DGRf8wcBvEMvvl6n+juz2Luxn+bGiuBYW75KMe8v/sRKtibFi?=
 =?us-ascii?Q?95L3ZVJRPuSSCk/o1JmUKM+dLK4WBnVrSFgdxXwK7EifkVea71AEqtfmOKMl?=
 =?us-ascii?Q?RgZsbfHp7mNo/IxJItdPHpRT98LvIhvY4uRvb1dmc/BCIAUeRc9yN8TocxtJ?=
 =?us-ascii?Q?VWiV0wTGXa7wd7S8zDOPCg8vzvuHv+NM41HCofzS3nIegprb4GVYws4w6hQf?=
 =?us-ascii?Q?SLnBcyHvjN/KBs/4dnkvzbWLt6hmShR5OO5sxW05NMAt08dcYW/8no67Son/?=
 =?us-ascii?Q?ug7c0UyIu8296L91wbz7EDceP8dE4jTwyhUNp0H/56PzIydavGdpuBlhBzfD?=
 =?us-ascii?Q?sH5Gb8PpXdwkVWbIVo4uWgu4PWW7al5o4iRA6dzJ+Z2eKRQroeRJqaigktjX?=
 =?us-ascii?Q?MuTgwVd0me0V7Nw5ZpixEbAZD+ge+Tuib6YAmt/wzXD6K1EakG2a21xZzv/P?=
 =?us-ascii?Q?una8mVNv5T6CMruv4xh7/jzjcOmP4GrH4znyI/9yJ5TwyV2T4Zsg1sH2WGbv?=
 =?us-ascii?Q?efwnCJZMWmM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9VXKMB/Wej5A7exhW0qWC8Pb3gZ0m4r7P9onbUkqMatl1jcY1A506g4YVqxp?=
 =?us-ascii?Q?pcAVHZUZeeOJ7VFCs+wDRGteke9f+h8a2an9kt7+Od12pJzP6S4AMydRmDlW?=
 =?us-ascii?Q?NnfaVfM8Lw97gdWmZZMAo/3sKXy23dOhj77UwxIxUogAB6muyEigL19nVNY9?=
 =?us-ascii?Q?LHY3DlUFrmHvQZMp0B9dFKtdNEbw5XpCAon+xRFO3wNKX8jlK2PzhPKEVIqb?=
 =?us-ascii?Q?5eULUON572Xf4AXH+FsWY8rsDS0yc+qrnPgJWcwfh2AgtmwOnu4uLu8/wYpn?=
 =?us-ascii?Q?wROtMbW/U5sYmxb1PuXAYdzCYaME9m4vly5F+Vhqqy/f8iL8Hw0UfYOQxkmY?=
 =?us-ascii?Q?zAD2tCwa57BEFCzT87Dywur3WW0SUs+VOZoyAlggM+LGRqYr/trCH3HmcOQ4?=
 =?us-ascii?Q?M0KuzO37GhN4/XmtmqsJu+rRdayHZbIhRY8vPsuZOAJRn70Ivy8jZZT77rzS?=
 =?us-ascii?Q?fhSR1dGk8j9LkxSwz4h31qPHM73dtDJ5xm2jgWLQDWn27NrgG8YXdfs9Fatl?=
 =?us-ascii?Q?R6KP5WXQ67fO04n/BWJAJZl0Ey5iOqA4bsboneMsKU40mmBzdD4cCeUFlrN6?=
 =?us-ascii?Q?Lf1LADKZuOzqLqTy/QukokTOksjUouYTrh0zP8c1HIWBzIi0ulAe6y4I3/92?=
 =?us-ascii?Q?rTveEugKYHzJiKiToefF2Vq6vNfuX3ATkbCojx8homU42dEny+bxSh2jkeY2?=
 =?us-ascii?Q?QtTziA1zlD3Keuv4EkQqmVuS8MzTToSon3qvvwzfAxoGsZPFn7b0mUYQX35a?=
 =?us-ascii?Q?+TYkV3+N53WrBxarWo8VcJpBVlu2y680F3OL47WN6vLJTlig3k/yAHudCYVh?=
 =?us-ascii?Q?jbMwQw2bJ6nBxD8TJZZplEKLulIvBF/QBVjIQxFNmDQlQ1AR6zxnC4vpyFg5?=
 =?us-ascii?Q?NXgLCWGPHL8yxL1/QxB9NrPvjZF5tatdeQFb/PSGO2RsA1iuWYUg4lQ2P8eV?=
 =?us-ascii?Q?qFw5uNIJFKBYKLuDwEQDB6BiAaVP5fpfTyZ9uUYXICWQDo9zpSG8s0TIteK/?=
 =?us-ascii?Q?O7gGt/qrCLlFF5vUZA7nsuD4i3fSg0ddT8BBXTtJlanIPP+oHo74XtJxZE0d?=
 =?us-ascii?Q?FJAenZ660ZQpbEc1uc8LT7z6vqncqjBfiJEFwMNKpQMk2vaY6d+l4/x6chbF?=
 =?us-ascii?Q?bCtR809OxC1PLa99HFilMAtn6Io/FO9r6sU7KLtpfh7dUK8bVIZ6s2SWLJGO?=
 =?us-ascii?Q?DQvOymZ53iNM3YvBUG8dhV/RH1gdg1I6XJYIJBv8w4NrghxeidRSNsy4I2AK?=
 =?us-ascii?Q?amuptCeMHXpPAEF5iR5d5NWS9Cbg02m/ZQNHlfXu7LaRB83sgbdVrqumfiNq?=
 =?us-ascii?Q?h06tzSbpoPO6XTYgBeXLiZd03RZ8HDuuK+Npb2KkSxE6pSiikzp9gypmPpXB?=
 =?us-ascii?Q?QdEFWDdV4DJVd15tTUL0xtx4UodsAZUeZ6ND2EqfyZefRwi2NfhDbQH2IrTB?=
 =?us-ascii?Q?QkP1oE5xLm+xTdYMKyez8XKEc5VebbaUzvlUKro/SuIpa+OPgUV/aJ+KS0eJ?=
 =?us-ascii?Q?SWCeGBTfDPJIHXnXySYUkf8qkI3c7KRE3ys6A5Gi30DPkHtcKXL5o9HbbBtz?=
 =?us-ascii?Q?mdDPxA4xMXIW3LBCsPoG9/gjY0aZuujA6cmqmwLBNPQY4HdHklwaqmN2w2tE?=
 =?us-ascii?Q?FQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f9a4ec15-ba7b-4e45-4d70-08ddd65c7552
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 09:17:55.1885 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wmAztwij1DyDLejvhxOmdKS3zVOVpLnOqL3IRgdhUeIF9P/zqCtQLIZLaOYUqo32DBo2HqMTcJ9zcG8M9H9OaKesECquw90cKpII5IYc2p4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7351
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

On Thu, Aug 07, 2025 at 08:08:26PM +0100, Bruce Richardson wrote:
> The ice driver expects the first, or outer, VLAN tag in a packet to be
> written to the L2TAG1 field of the descriptor, as configured by the
> l2tsel field when configuring the queue context initially for the
> device. However, when configuring the actual VLAN or QinQ strip
> behaviour, that l2tsel field was changed, sending the single/outer vlan
> tag to the L2TAG2 field in the descriptor. This meant that it was not
> getting picked up correctly by the Rx paths.
> 
> This issue has been around for a long time, but was previously
> partially hidden by the issue fixed in [1], since due to that bug,
> the l2tsel field was not getting overridden in the single-queue case
> (since the single queue was the final queue).
> 
> Fix the issue by just removing the code updating the l2tsel field, and
> leave it as set by default in the initial queue configuration.
> 
> [1] https://github.com/DPDK/dpdk/commit/4cd8c72f6
> 
> Fixes: de5da9d16430 ("net/ice: support double VLAN")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> Acked-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
Applied to dpdk-next-net-intel.

/Bruce
