Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C59E6BF03
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 11:26:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B947540274;
	Fri, 30 Jan 2026 12:26:58 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id B291B40150
 for <dev@dpdk.org>; Fri, 30 Jan 2026 12:26:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769772417; x=1801308417;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=TZBi5mkBRuAx09oRrDHJgboI+YPDmmcGVaiz2iKUbEI=;
 b=OeaAg8/l+eAuBbVf7kwFTc5Kb+jRInzepTXER359IOpK0uknQ8CBFryW
 jVYvBUwlO3lHHe+o1VEDw5kk/KXm4E8mVc9BCN94I/1tBCdQZJDthnlLV
 6UI3kEYdEi5GLtNi5Vih6GXQy8SnIZEvnOqSi1UShZD+aLrv8SMeTzXFr
 Mzsx0gTNuDhxSlOE2DiLLhlKWgI/172RaPf5/Q561H4aPLJJQ6beHgRUm
 QyFgFo3u3AygfQ8Eo70AH8diaUy/eyuxF/B9EhpKXuDiDd6KndZwuE7AA
 lZvifbZSLBXShN8lP4TxLIp5hKWgoNikCnpcWMYHKxizOcqUUi5bNaLKA A==;
X-CSE-ConnectionGUID: 9iVXeNBZT0qhSEOkZrM23w==
X-CSE-MsgGUID: pJBLIGidRfuAB8NdsAsPlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="74646986"
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; d="scan'208";a="74646986"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jan 2026 03:26:56 -0800
X-CSE-ConnectionGUID: TqyEf94uRl+JDsMJajzTtQ==
X-CSE-MsgGUID: uAJ0+Zq6RmOkyTuHnEgaTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; d="scan'208";a="240097141"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jan 2026 03:26:55 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 30 Jan 2026 03:26:54 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 30 Jan 2026 03:26:54 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.34) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 30 Jan 2026 03:26:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uPuK9caNm2G4LL6fz3DiNdNdcs+KxbTme6wKwk4pEqBa62vlSbIydJfGHBP9DrXXLESQ3/ZfQlvLg9aDg+rKHLUZxD6dcSEnz0gBgau+nYGZ1JxyFRNEh0u86bihRW2xnm0WDhDvWwcUdxW/KmAU2gnJaGnwK0jderaXvDKs+WXwju6KYDg83dEOzRhsuLZ3J3UGqhjTk6GprYcbjq5EYNFrr/dqsvcSyZAPFLbR0pu+N9bNqcRZ5ZWi8QJ81m7d5ocPmocPuA8yNXalUs3BBS69aypXuzrt9oOwtmYtk5vkLKON+jyT0QQEDE/NOJX6sAngkLCbQR59fpa9TZ6T4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q1zwJSdyudgONkX+GjqZjePUT01yDc6U4STr4bxoFGw=;
 b=g+cyDf4GSsNBUXAFuM02XWkN+uahSLcsF9Ns/OK1Qv+d9UKABxtZKfZ3SLPQ0VJLvQKd4J+YdYzRHV71JTTZBB1F1WeGzKS7nMsEJrU0tefb60v2z0sX+c+xiwRkzuq68s4Q1do3lt5pr0dO+7q+mXHMiPrPdF0XvxECQMpHbtsV+Twea8u0RcJxw6HXhvizCRX8AJ+3lAvBfVGYUcphjGX35An+rqxVn8CIdKTVStJ7Ns8JjGK5X9IcWsXeMEbuN413zwBaWzxfTyVky6IdH4jgW3uaVEvzvpuYYbtVon6G3o0rh48a07OAhAjOteAPzQ5ItEnU5GrEjubUyv0L8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SA2PR11MB5131.namprd11.prod.outlook.com (2603:10b6:806:116::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.12; Fri, 30 Jan
 2026 11:26:52 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9564.008; Fri, 30 Jan 2026
 11:26:52 +0000
Date: Fri, 30 Jan 2026 11:26:47 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH 1/2] net: ethernet address comparison optimizations
Message-ID: <aXyVd7BpQKR_4uRj@bricha3-mobl1.ger.corp.intel.com>
References: <20260130104617.535413-1-mb@smartsharesystems.com>
 <aXyNh8Yja-Mg6qID@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F656D4@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F656D4@smartserver.smartshare.dk>
X-ClientProxiedBy: DB3PR08CA0031.eurprd08.prod.outlook.com (2603:10a6:8::44)
 To DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SA2PR11MB5131:EE_
X-MS-Office365-Filtering-Correlation-Id: 13fbaaa0-76d0-400c-450d-08de5ff27723
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?AXSIpgDI2L1wFCGUwqMsqtjTQQLXQxP5lvHHyf876zLjgYqP5z8qdt2Wad?=
 =?iso-8859-1?Q?QsesKeTiAqZHe3pl8qgC7Uu7cH+dbNjo4vwYul6/scoNg1h35YUF90d0fy?=
 =?iso-8859-1?Q?INlyhYJjXNrIfQWXudmCIBNLNI0NroT4jtvnTmj5/aqUNNyGo0ICnE+REq?=
 =?iso-8859-1?Q?ZH87MmtDBWaCx5mDw7jd7f2Mmn9C+hkbJRmfsAgJcZkOWqKCGpEZtwCDmD?=
 =?iso-8859-1?Q?2FrNJkn6LzCwzsFetjaip1I4IWQlyYZe1rIfSYbZjFjlLbcYVRz1PfKlPX?=
 =?iso-8859-1?Q?qjuPQko5BzDXH1Jm4Qnc1QjfJt5q+dYAhEwOhP6nLte/yRg9uaQZLTAu1g?=
 =?iso-8859-1?Q?aM8Yb4fptXNexocpJdI8Y3pTsDTHOxl1pE4g7DmP8r2TeOSH/coPIsQM+E?=
 =?iso-8859-1?Q?V3117sPTf0+HqplJ+OMGG2oL9ukyGFRGjO0JXGW3MjZ+J4zKHnD6iNEkva?=
 =?iso-8859-1?Q?oRQSZCK8Xu8B+cRu4UWGiC9Hig9gik/fWNXVY/YUwU8PvGAThPNR7hEkaU?=
 =?iso-8859-1?Q?+1oIBFO7j5sUwnI9jJ2AnHzBo/002UmIP/gwJ81+spOFcKQCjsX+ToRzu8?=
 =?iso-8859-1?Q?k+rKgrAciKNhans9Fi3Z7rLxc38ZV4QvXc9NgaZoXzhSYJuVxo0WWvOf90?=
 =?iso-8859-1?Q?nGKaUWv3S70Yy9trxGiDIAFPDkDp439ykGgqY1dgu355jy6evsCNspT+4O?=
 =?iso-8859-1?Q?3BzPmNMZEsENtv2FRMOlSMvVlDf5lFV6ilPmx2fnPpLJgsmK5WumtsctGt?=
 =?iso-8859-1?Q?UBIjBa4DW3YJ7+xN2miWgQIm1znnK9rByZXCfkm9ICh72jMOVEtrRmkpl8?=
 =?iso-8859-1?Q?Y26aAGxffFQQuggIedLBbsxIHaHZ8KXoXljNRtAX97LhsTU8ORzmWy9pFr?=
 =?iso-8859-1?Q?1KYBPAGP+4v8NJ+s9yHn7DrVFk/HMW7drnYcBfwHw+T9tm3NhHJjF4eXY+?=
 =?iso-8859-1?Q?cBFGq4JFkJj+NQn/9975jNYcBtRYniq7hstdx2fUEORenBh7VA9S+hwIuH?=
 =?iso-8859-1?Q?UGUNrg3LsBMOr3aGl/U0oNxskdHDqseQAfivRrUYAVFzre+Clfxd48aQvI?=
 =?iso-8859-1?Q?AdnCYylOAvkewH9iZptI7svcmBl0dRbVqPKH1Id2XpBM4niz17nuIZRZju?=
 =?iso-8859-1?Q?GJU1Jw59/NLO2t6ql8M5dD9JvNE/27CJO+Yc35ftn2Uyf0gOjnMApD7Egn?=
 =?iso-8859-1?Q?zudFBNDKRa0C1nKO6FzURyAb/BzgXdRADohtP4gHxeQ9XV5KFby9NHzLln?=
 =?iso-8859-1?Q?vVZ4kR1jKzYi4qUzoHmeEa7T6/g8jPMFfxgDD35RhsGzn2lJ+bMX2Y0Hrg?=
 =?iso-8859-1?Q?t/mn0Pim2KyRsmbhXoYiugE5TLkUhFKdMK9GQAtd9PvP9qPXG+kj8F6V54?=
 =?iso-8859-1?Q?GOnml2MxSFuvIE/TxxM6bespmTbbsqv7uhUv3KC2LXxoDaDQ75rjOqIZaS?=
 =?iso-8859-1?Q?/Pr036cAv14QSSv/XztmshfqfjC6oT5O0GcEjoLn7LTrM4LLjyThgVmzHC?=
 =?iso-8859-1?Q?RVSnwhMsX1cct6jU222QJEPEeYmP1eBCg1Dvb207cM6t8BjkX0VNKqu16U?=
 =?iso-8859-1?Q?DjgMJT0EkI79txpw3rhAvGAtXjtUz9VHVwagssBy1aE6fc3NYFzUHT0zC7?=
 =?iso-8859-1?Q?4gLDQyfNp1za8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?NRVN3rgnJionOF1oEtYDQFqY6/rYOqoxs7MbLfp/RsDQwbvu38YXaq2ny6?=
 =?iso-8859-1?Q?2+nkhx3npRrnwGMzQOlQ+sHmRexNx0iUM9CMWaXw6ZiwKr0r5r6Il1oxw/?=
 =?iso-8859-1?Q?0H5zJxJKpvtD/1AUWlWYYzUlCCnNpzJ2AZ2Spmdpghm9wEavojtaqtKtOC?=
 =?iso-8859-1?Q?/EikacPojQZLQh1NbBQzq5hHy3WuhNe237w3EoMkxjFgkKYvJ9c23Y0ue2?=
 =?iso-8859-1?Q?DueVVGRnIt1ANpcNH+wDxgijqqp3cg3NwIj+mtTo5ObwhO4nh864N5tpx2?=
 =?iso-8859-1?Q?/3TYvJQqzXrgzK5IZp6t+v9j+FNRMqNtkLGHWAO4hcBJ7ajwd1SVmp4fog?=
 =?iso-8859-1?Q?BEo4OpCMUkjN6Fv73EWAB1ESwLrrLjfWEwcgt2eLfbdzGcOWxhuL7TMoaB?=
 =?iso-8859-1?Q?H1jvA2iijOCifXSO+TcS8zsXyQ7uWBTZ7JC7N7ySzFF6LTPT+EMqGEZNfD?=
 =?iso-8859-1?Q?QgKzUHl29Tk3PTo2FqQj58LQETRI9/ovTRa7UE7njVoSDMItNTOHYQupXd?=
 =?iso-8859-1?Q?oC+AN3ctEY2GzkIBDrLLxGOME7odEDIcCU7Pm77GJjlV0dnk7ccCkuKisF?=
 =?iso-8859-1?Q?9R4SBFwqpk6QrPs8KUN3s8tCLgpRnox45txb98AurcLyr2A3cfHilMls2h?=
 =?iso-8859-1?Q?1maEUTo4mBaxyvlNB3rUUJMUr84+H1pkrxk2U+nPzWItAzNxYWz4iInjYM?=
 =?iso-8859-1?Q?vOimTTD0psm99cogt88BqVoQsZmijq6C7V3Dxr4s8nVnHReglUpK8LcMUp?=
 =?iso-8859-1?Q?t2Ex2jZ0iFPun9y21PuHQJT2/XeNY59N7w3rrcdcR3mC7arPEKbtXMlMxb?=
 =?iso-8859-1?Q?Xa2pXC6dyaQeciOiB+xtLVSluhfpMdaigRgaQd4r1NRUBbtYQcB/iCCJaJ?=
 =?iso-8859-1?Q?OdrjIXaoLA8iSKIMh0342xhMayYs5Ewl8Gfkrrd2CvNrWIEJ56jkWS76l6?=
 =?iso-8859-1?Q?S2Tzfm0pF42EOoBzp+028Qojo7pHaGjebGkoPY7qOcRk9zFIt2U0pQ2KDH?=
 =?iso-8859-1?Q?WZ+uHjFqfRTBE5F0Qt97mHH9qaWcZP2d5rywVuXWpJZrxOiUO731L+hn/m?=
 =?iso-8859-1?Q?iutUtSB+HjpqT76AiWICObgqK6lxVu+XeoepU8v9V1IGowrvv9SWuwM9Fn?=
 =?iso-8859-1?Q?oVfrMAPm1k2LsmSpQDOw55aVnpmDjdOZYtDHr8YO4+VuLoxh4YFnKN44wr?=
 =?iso-8859-1?Q?zD7obINheu/RA1Apa3FWDX+9DktidFpt6TJpuDyqMYzDQCon1zahtwYaAi?=
 =?iso-8859-1?Q?Dh3DFIy7OUdKTiZ6aa5LDCHP/YOhViOVcWZzoOt2Biv+h3uM+kB8neq+5S?=
 =?iso-8859-1?Q?wYZzGEvWnllTTIctm0eZ3T6XKwxfJiI+Qhwyq+zolgeaKHQspdrfpMuwGw?=
 =?iso-8859-1?Q?bei9zcs1WIuO5VT+pKIjnMcStIUhxz5+gGiPwfh8rCDl5ercIZViLy07tl?=
 =?iso-8859-1?Q?V83CrDB3katuTLmG6sKl2FehS2s8YwqDh7LLtufSkkbrvaouMUYxZc3+aK?=
 =?iso-8859-1?Q?Fsw3BTIpPCkFWlmF6gAP74a02wGHm2jXDppsOC5AQx2raiKvW714dASheM?=
 =?iso-8859-1?Q?5Z+nsd7yVpenI3zUehm5STTp4z22bBgi8UrHG/cUkEsgo5PMVV9h/M4KIG?=
 =?iso-8859-1?Q?9bYZlc3cWY8Y1qyWLM7zKnTaoUurT2owNLovi7PbGtgt0aFCmPBLjzcu08?=
 =?iso-8859-1?Q?he3ATGBs9qD0lbvbd4ze+qDhe5jL3mv/NLl4QXvkbHAATQ+kJhpYpBoIy3?=
 =?iso-8859-1?Q?M+gNQ//nCMdMvmb7TxrF5wv063OGwmG3xFRTW5pPCm/qoTPaaLdEzFNxGa?=
 =?iso-8859-1?Q?3bA/KJqBuVzFQTt1BICVSC6YQGjSwEY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 13fbaaa0-76d0-400c-450d-08de5ff27723
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 11:26:52.1118 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hFxlvFZCmjQmc3ZxPxqfIIyqpBpHQjfAcj4JNGZ03knl5YLI5+UFTARoPKB4qT098o2ySVykiMlQC6/vruRbEeNIJ3/ne3UvRWjnVeM2q0I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5131
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

On Fri, Jan 30, 2026 at 12:16:43PM +0100, Morten Brørup wrote:
> > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > Sent: Friday, 30 January 2026 11.53
> > 
> > On Fri, Jan 30, 2026 at 10:46:16AM +0000, Morten Brørup wrote:
> > > For CPU architectures without strict alignment requirements,
> > operations on
> > > 6-byte Ethernet addresses using three 2-byte operations were replaced
> > by a
> > > 4-byte and a 2-byte operation, i.e. two operations instead of three.
> > >
> > > Comparison functions are pure, so added __rte_pure.
> > >
> > > Removed superfluous parentheses. (No functional change.)
> > >
> > > Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
> > > ---
> > >  lib/net/rte_ether.h | 19 ++++++++++++++++++-
> > >  1 file changed, 18 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/lib/net/rte_ether.h b/lib/net/rte_ether.h
> > > index c9a0b536c3..5552d3c1f6 100644
> > > --- a/lib/net/rte_ether.h
> > > +++ b/lib/net/rte_ether.h
> > > @@ -99,13 +99,19 @@ static_assert(alignof(struct rte_ether_addr) ==
> > 2,
> > >   *  True  (1) if the given two ethernet address are the same;
> > >   *  False (0) otherwise.
> > >   */
> > > +__rte_pure
> > >  static inline int rte_is_same_ether_addr(const struct rte_ether_addr
> > *ea1,
> > >  				     const struct rte_ether_addr *ea2)
> > >  {
> > > +#if !defined(RTE_ARCH_STRICT_ALIGN)
> > > +	return ((((const unaligned_uint32_t *)ea1)[0] ^ ((const
> > unaligned_uint32_t *)ea2)[0]) |
> > > +			(((const uint16_t *)ea1)[2] ^ ((const uint16_t
> > *)ea2)[2])) == 0;
> > > +#else
> > >  	const uint16_t *w1 = (const uint16_t *)ea1;
> > >  	const uint16_t *w2 = (const uint16_t *)ea2;
> > >
> > >  	return ((w1[0] ^ w2[0]) | (w1[1] ^ w2[1]) | (w1[2] ^ w2[2])) ==
> > 0;
> > > +#endif
> > >  }
> > 
> > Is this actually faster?
> 
> It's a simple micro-optimization, so I haven't benchmarked it.
> On x86, the compiled function is simplified and reduced in size from 34 to 24 bytes:
> 
> 00000000004ed650 <review_rte_is_same_ether_addr>:
>   4ed650:	0f b7 07             	movzwl (%rdi),%eax
>   4ed653:	0f b7 57 02          	movzwl 0x2(%rdi),%edx
>   4ed657:	66 33 06             	xor    (%rsi),%ax
>   4ed65a:	66 33 56 02          	xor    0x2(%rsi),%dx
>   4ed65e:	09 d0                	or     %edx,%eax
>   4ed660:	0f b7 57 04          	movzwl 0x4(%rdi),%edx
>   4ed664:	66 33 56 04          	xor    0x4(%rsi),%dx
>   4ed668:	66 09 d0             	or     %dx,%ax
>   4ed66b:	0f 94 c0             	sete   %al
>   4ed66e:	0f b6 c0             	movzbl %al,%eax
>   4ed671:	c3                   	ret
>   4ed672:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
>   4ed679:	00 00 00 00 
>   4ed67d:	0f 1f 00             	nopl   (%rax)
> 
> 00000000004ed680 <rte_is_same_ether_addr_improved>:
>   4ed680:	0f b7 47 04          	movzwl 0x4(%rdi),%eax
>   4ed684:	66 33 46 04          	xor    0x4(%rsi),%ax
>   4ed688:	8b 17                	mov    (%rdi),%edx
>   4ed68a:	33 16                	xor    (%rsi),%edx
>   4ed68c:	0f b7 c0             	movzwl %ax,%eax
>   4ed68f:	09 c2                	or     %eax,%edx
>   4ed691:	0f 94 c0             	sete   %al
>   4ed694:	0f b6 c0             	movzbl %al,%eax
>   4ed697:	c3                   	ret
>   4ed698:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
>   4ed69f:	00
> 
> For reference, memcpy() of 6 bytes (compile time constant) also compiles to a 4-byte and a 2-byte operation, not three 2-byte operations.
> 
What about memcmp? Does it compile similarly? Before we start adding ifdefs
like this to the code, I'd like to see some measured performance benefits
from it. While the code may be 10 bytes shorter, does that actually
translate into a measurable difference in some app?

/Bruce
