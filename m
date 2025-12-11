Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA6FD41D5B
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Dec 2025 15:33:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B0608406FF;
	Thu, 11 Dec 2025 16:33:45 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 9673540151;
 Thu, 11 Dec 2025 16:33:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765467224; x=1797003224;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=eeR1BPWwZwuY4IW0/13/QlQ9NW9H2pcu+ElxcG779Pw=;
 b=K9jLn1hbiESLZMDTuQ+ZUzPs5CkyEpqSEJxWIVmTKtON9g4644Cj85WV
 U1b/0OQvXYEs7whY+xc67XxxEJF7PZ+8jXPEPN/A0nQg/k6DL4OYVDkAd
 xreMtXKshzp8GE2JyRwd7tzgexA6DlLtKZ8Ao8PzYk/ZBUq+nwiR6n5Ij
 qMc7ybM3LtB8+NdgRUHUG+A6Pak0LFCs1pLsL00hoBXNOBFQuvMzGRCix
 MIgyOBnFZRVd62Io20EEgUTJtqJa5EAhrXFWPEp4WIvxwg7iyyyXglnhR
 4D8dxMOwVuWyzIny1n1uOX1tljzmdilooatLTlvnlrAGjPvCH10gzptdH w==;
X-CSE-ConnectionGUID: oCWWlDgxSk+Irg1QGe8qyg==
X-CSE-MsgGUID: YA3x1SprSR+w1VAgswusLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11639"; a="78563580"
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; d="scan'208";a="78563580"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2025 07:33:43 -0800
X-CSE-ConnectionGUID: ONthoeW6T+ePt6Hw6TOgUg==
X-CSE-MsgGUID: q1uO5ttDTEGBE5wnRE8Dnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; d="scan'208";a="196102420"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2025 07:33:42 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 07:33:42 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 11 Dec 2025 07:33:42 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.71) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 07:33:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UUhuylzzRiP5GsXCBlMfIPoahv8dpd9YoeALllY/Fs0hUMHW3SLLGqo4P4DhJCq1PtwJwwsRobtguEaCatho7+1K9d/DPzL+g++Dj92g1oykmjxgF21DaxCA/tgovUZsL/MndHJueOfczGWzgxZkWVZgSBSjei5F71GJalxNDWwwVwg/20ujfJnBoxYEmLlbfypsOwSMFLXwBHqsAEdZwSnJuCBNGhx/XBJHD/g3G3mwbt/OLB1vdZZI9jggf6bdyNLmU4ezJ2zl+A2UWCO/tc5mlYdvT1GkaG+E6ex/tXtBWzDiCGfgQUTzrUGHMwDpDMG/zT8NcBhf1ddfABFt5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rz0OTs1W+VI65qm0ydNz8bxnY5McOUxy/MdI0TfqIYs=;
 b=XkxALE39YbJ9ZczajdXt3VfkAC17m2T1iuW2BQab0pmggabOHZmnweWaFbzBeBDvdhhDD1qn0XFElfidnpaDo3kELWFNVSzrZ51Mc2dJMmYe/QaV5R0PAx04Em8yKXcGCjxCRIGWMXHOhhHbiIUJJGw3/7ih4CVrYzRwOQYaZd7jt8VcJx+eFLEc47xKxGGBDkFbG4uGo4St+s66quYMy0f3f54ozuTrVti0V3l+pxIjoUiqVypNric/oHUP6rf3NKWTFmFo/2QvIwy2oIMXEX5z2NB9NgsDCT2FPr2RTkL9w4PDy4BhMafdRgMxe323yHWxGLbgSrbRddI4yYayEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA4PR11MB9177.namprd11.prod.outlook.com (2603:10b6:208:569::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.8; Thu, 11 Dec
 2025 15:33:40 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 15:33:40 +0000
Date: Thu, 11 Dec 2025 15:33:35 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Song Yoong Siang <yoong.siang.song@intel.com>
CC: David Zage <david.zage@intel.com>, Soumyadeep Hore
 <soumyadeep.hore@intel.com>, <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH v1 1/1] net/e1000: force allocation of context descriptor
 for igc launch time
Message-ID: <aTrkT4iMHmVI-4Hq@bricha3-mobl1.ger.corp.intel.com>
References: <20251204013009.857273-1-yoong.siang.song@intel.com>
 <aTrkAucUzSwGnbcx@bricha3-mobl1.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aTrkAucUzSwGnbcx@bricha3-mobl1.ger.corp.intel.com>
X-ClientProxiedBy: DUZPR01CA0112.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::11) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA4PR11MB9177:EE_
X-MS-Office365-Filtering-Correlation-Id: 9eb2e9ef-03b8-4b26-fd1e-08de38caa8eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?n9VFqmHVQZ+L5GaD/yX7ZB0YckX0U4EWpZk3owT1QgG7DmTstY81Ra31I0yr?=
 =?us-ascii?Q?s+fBIJsRD+KGLKqbo1pScaXtyhQi9t31B7DINFSvbb0sO0XiyefNkJc/s8ci?=
 =?us-ascii?Q?YGmUOH9PPJ0p8J/F4g1GXSIyy5gh7TUhDO+THCvAw2RNkeZRQ0dQuw8PP2tk?=
 =?us-ascii?Q?awt+9I13pqQCaSv9TsyZ8Spa2H0cFI1gbk+lpCqFOM4FQhIPBr9dKWoKorB+?=
 =?us-ascii?Q?S/1myYRpeOMs/NNo5leEmJxKBncJWgP+HJteVumfpK0X0V3U+nLSGk00Yv1a?=
 =?us-ascii?Q?AVR3JpRyhy2eM+6VpWiFJeUkTHI/xOWCGv6qhAbMwXHoqmBnSIiaoWenw9Km?=
 =?us-ascii?Q?h0y2a6fkXyNvq11crNCpeIB941k9/i+pCSRaoV2uHI/IzGOfF+NDBwMsvQCe?=
 =?us-ascii?Q?jjO9WgGj2FiAPxuxOwXYrXJF1zHbkyxVd2sCDgSjf0a7BTkk+4k01EFn+AUv?=
 =?us-ascii?Q?Yh8LvnxzUP3lZXWsyueRTaL0BoLDRp+VBg8cntIjr8K0+tI7KEo4RT8T1PzU?=
 =?us-ascii?Q?H3EuiEf2uRmho0kOS3xkEOkhq6UV8r7KuBaQS0LgK+TAqa8yERv+44V6hEDE?=
 =?us-ascii?Q?WTlutKPp7cVd9oKB0Hbvxd9jYOVdJwK+ZldXPRsIYh/ZKfAQ/I75dU+U5q7v?=
 =?us-ascii?Q?YjWhrVwUyJwN9xR2dgMIwbhWeG4zls4PAyJS2OD68B1rTj2q4tLo1k3toZid?=
 =?us-ascii?Q?SxqFUILmj/3uiXs6KptcYoQOT0TFUyTPWZ09H8a20g32kNFaMcxR/02xXsT+?=
 =?us-ascii?Q?+k6Ggy47xFv2ux1MMv+PrSIZvdLyk6G/nkiOZxqxZ4Vt3z7sAKdqv0E6yubG?=
 =?us-ascii?Q?6aea32KXxnJcifZ0Ivh42LRhFRgubXPk85OiMjMMztutSu9TYQi6V7kQi5To?=
 =?us-ascii?Q?DECKYiHkHyTbgTh4dNQUu2w+Ha65j3t6A8M44qsrvho9kSrK5D400r+bI8Zm?=
 =?us-ascii?Q?SsxRteWF8bx3grgcxcTVJw9X5U/bNkCOikAjcS98d1k30lA4N5I+7H6yBtYR?=
 =?us-ascii?Q?OHlXRIWRqoA/EsvJt9UFrk+9YQTOhNMSq/ec1fcWzz8lsCEHX8pyXFCwtMgF?=
 =?us-ascii?Q?UHiI75Y8x3jhxX5QegQk3mRzBFgJsfkXfDRFC7sihtMtBel8ta5QR9pgHDFZ?=
 =?us-ascii?Q?oCjWrR6YH09TwGQQbPy0wyUt2wYGovR4Ynz7w3dD6TCBVfRhzXCm7qSCiq00?=
 =?us-ascii?Q?TonG4Q2TmvkVCV0dweqZ+9gMe28FkeN5jFOuKGkj+Nnba+hXN/Fxl3f9p7kR?=
 =?us-ascii?Q?Zvv3GYO2JthcZJnqrnctc93bdKb6JO5gRVx6rO2Ppv07JXWs8N70N08Ol9Do?=
 =?us-ascii?Q?A5cxZ7nxtihqRKEJiUjr8P9lwOFhXUwbTc8Jw434VycVdo/jivV0h+4dJ9l8?=
 =?us-ascii?Q?b1wCg62bC3HBBU2aOhJVr3xbtnEGFTVebG24DAKnIe0LPtnludwdvn6Jy8wV?=
 =?us-ascii?Q?LmMcoAFf4zBv1BwpBkTV2+fsQ4SuQEC6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VmIF6aYfzAczkgmu2l8PfnLixyHVFjBBZLx2eSUCD2thBZMTloOfYX3nlCG0?=
 =?us-ascii?Q?pYB3zssudMWWKtddgdHFwCFitwenht5pGuqtk3otNkZmx9bFrvHe6hd2IWKG?=
 =?us-ascii?Q?pbTKdpKZ+xaWpzV9iut4aN/xY+yGVPR7vJTGGsvz3p1knDhhJ4/w8/nBOfmY?=
 =?us-ascii?Q?8krniGPiZD8UaTQr0TnMKnpnTMhsp0kIePR1XZV5o9cDgj5CIsdWCer594y4?=
 =?us-ascii?Q?43DWf97lRWorVknprsHOectlNNEeWx0xEF2sdS/RO0ECrkoUePO6b/CN1Hrj?=
 =?us-ascii?Q?Ds5QgKQt4QHNcvi080nmBgYuXWUmomFqOk48NZxvMJV0frsvxkFMByj0dfdX?=
 =?us-ascii?Q?GJ9Vw+yMpnJj32ImmU//A/T9DtfDmP/jc8CH81YyyMK2BuH8pc27GWSy9aA3?=
 =?us-ascii?Q?eXwodMnrEWDt0sfZdQoQRkseTWLN4z0iR8BmvLxMXKqqXNwBz+bT47yWpDIv?=
 =?us-ascii?Q?lttMfakEApkTmw0L0GmaMRyOZZCm52HRgKjx3oOV119cDe1/yfw7LGWcybkj?=
 =?us-ascii?Q?RBo7xhw2tsd0QUHLFK4EMWB2LLayRoXSTt8mxxz238khKY+gAlvfVk0yn+Kb?=
 =?us-ascii?Q?fTAkjdgQpMzfsdPH6f7cG5OQKaLrLTUl8x+2WvfIXMQ8vPD53hrJdtGiU57B?=
 =?us-ascii?Q?DV5mfN8fsSBVAslQ12/GCTVhHv42IOTJL494x3Xj5e9H3MJ/xR7BnNkDpbev?=
 =?us-ascii?Q?9SCKPHKOdNspBS702n8BadgNYnVYDyvZqr6Ww7WPK00bhPGMY/xuxQt0R9sE?=
 =?us-ascii?Q?GyWRbUerzEoVuAU+7GaA/AYLjduDr6WxCoJYjSyKXZSE0C8xZWolml1HwHa4?=
 =?us-ascii?Q?FeTJOaIVb1+JO2QXYaKZj9E9YIsxFXSgM4+MZpKZDDk+tTkBz/8MtuoJ6uAp?=
 =?us-ascii?Q?7yLfH8YsJ/r1/r5D9kjzte9GyFZi8tBk0dTkOkOWbF8UjHqr20DjGI75PttM?=
 =?us-ascii?Q?z2vOBx7ZyktNpFX31+RvYDWHzL1YuqUFCz728LGMe0y0cEaTbkewS6xHDI0n?=
 =?us-ascii?Q?jzoLrnraJ/S3U8aYwN68HaO2q+xspDNCpkOrwgAl9kcBgO4mwoaHehA0Mxo1?=
 =?us-ascii?Q?0BrqbtpA4Oh6o0OUXa/3fTRYcZ+QvmvoQVfw5erFXp6BvK7i/Z6zap+QEcpd?=
 =?us-ascii?Q?lSuC3Mq/QKoQPWtSS261iXuhy7eTWZ5pyz/r3sOEddO0IvjcV99KtiN61g5a?=
 =?us-ascii?Q?L0CqrSKBwCIJZSVKYjSkO1K1g4kyAvk261ZzThUg2pbtADRANR/OhnhxIfMm?=
 =?us-ascii?Q?brxYaOZwitkn/X9pJCRntOxXXFE07xzHlPCqep7BHz5V+s/vtEcDYmiY3ZID?=
 =?us-ascii?Q?d06fl3JsPR1bR+ndYqkxalMN7NYWcAY1HVQms6HpNYW7GQy1HHvGtGg5Hwc7?=
 =?us-ascii?Q?hX+i4Ac0ei3LtiTxzPxx+H1EPQqDZrIsKP382+r1c/3asfH4h9nVO027Unke?=
 =?us-ascii?Q?BYBKzAOmJHWt+fRSABCuTZxD1lNehu85/wuRKH/CheKBqTTtGXNLlgbnGZdU?=
 =?us-ascii?Q?t6Ry3rU5UDwjUj/kOSW4dpnG9N0bJnJTPkxggVmFxx17jJd6VppQPZvMGHRi?=
 =?us-ascii?Q?cTyJ6az+Gra3w19MUDC0FchrBE+lNC2hCdNw68E+RGaJfiBSG6MiIpt69mk5?=
 =?us-ascii?Q?8A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eb2e9ef-03b8-4b26-fd1e-08de38caa8eb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 15:33:40.4031 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VeeKTxXfo+0CLEvfjppBzmAL24CxIr3Xg7sEBg/LJWUH+6BFSvG0BZnSvewopnrdUu7f1DuQ1ytvP4aGKQMt9SpjFinrF8VMwuZ0ViBbVxQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9177
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

On Thu, Dec 11, 2025 at 03:32:18PM +0000, Bruce Richardson wrote:
> On Thu, Dec 04, 2025 at 09:30:08AM +0800, Song Yoong Siang wrote:
> > When the timestamp dynamic flag is set in the mbuf offload flags, force
> > allocation of a new context descriptor. The launch time feature requires a
> > dedicated context descriptor to specify the desired launch time for packet.
> > 
> > Testing was performed on two Intel ADL-S platforms with i226 NICs
> > connected back-to-back. A DPDK sample application is created to send two
> > bursts of packets with 100,000 nanosecond burst interval. Each burst is
> > having 5 UDP packets and only the first packet in the burst using launch
> > time feature. Meanwhile, the tcpdump command below is used on the link
> > partner to capture the delta of Rx hardware timestamp of the 10 packets:
> > 
> > tcpdump -ttt -ni enp1s0 --time-stamp-precision=nano -j adapter_unsynced
> > 
> > Without this patch, packets of second burst are transmitted immediately as
> > the driver din't create context descriptor for the launch time, as shown
> > in tcpdump log below:
> > 
> >   00:00:00.000000000 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
> >   00:00:00.000008384 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
> >   00:00:00.000008381 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
> >   00:00:00.000008384 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
> >   00:00:00.000008384 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
> >   00:00:00.000008384 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
> >   00:00:00.000008387 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
> >   00:00:00.000008384 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
> >   00:00:00.000008381 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
> >   00:00:00.000008387 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
> > 
> > With this patch, packets of second burst are properly held until the
> > intended 100,000 nanosecond intervals, demonstrating correct launch time
> > behavior. As shown in tcpdump log below, the delta of first packet
> > between first and second bursts is 8387 + 8384 + 8384 + 8384 + 66461 =
> > 100,000 nanosecond.
> > 
> >   00:00:00.000000000 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
> >   00:00:00.000008387 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
> >   00:00:00.000008384 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
> >   00:00:00.000008384 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
> >   00:00:00.000008384 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
> >   00:00:00.000066461 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
> >   00:00:00.000008387 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
> >   00:00:00.000008384 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
> >   00:00:00.000008384 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
> >   00:00:00.000008384 IP 192.168.1.100.2 > 224.1.1.1.5: UDP, length 982
> > 
> > Fixes: 9630f7c71ecd ("net/igc: enable launch time offloading")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: David Zage <david.zage@intel.com>
> > Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
> > ---
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
>
Applied to dpdk-next-net-intel

/Bruce 
