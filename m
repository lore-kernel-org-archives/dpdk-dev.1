Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74B4CD13DE
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Nov 2025 16:05:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 110BB40A6C;
	Wed, 12 Nov 2025 17:05:29 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id C7554402AF
 for <dev@dpdk.org>; Wed, 12 Nov 2025 17:05:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762963528; x=1794499528;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=LXlWVQXZ/7j2oVZnru2wK/nYi8G5FIzByzsySwj1diA=;
 b=md9+PssVC9+DBdNjkw2azXTbMAwIIg21ps29VEpjrtrPk8oo/6EuinaK
 WZYAyL7SY+niXwy0QxDvQCp9bg1UM+8nJnbsABuLk54cL9ikXCspG24L3
 F3gk2lmutT6Tveyhi2/4rF3/LvPGLoVWDs7NUitnbKcjieLcAQ9PABDjG
 /Tt4M1NzHifntZY/A8ZhM6FYQ+Iy6iatep/iYUd/cuaGF2LW6fQVhca90
 kk9oDSS6AsQQmeCp31Ld+j6c7K3xlzme6VNMTyBmRPZws0eES8MfynkQt
 4viRClpIq2HC99r8sRxF3QLXqw+DRjXLjmkEWMqn5VNX41RA4rxRxk8gR w==;
X-CSE-ConnectionGUID: L7Iq9WxZS/CVcy6nxHbEBw==
X-CSE-MsgGUID: Uu5LDUG7RhKCFPLrAYGueA==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="75710884"
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; d="scan'208";a="75710884"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2025 08:05:26 -0800
X-CSE-ConnectionGUID: kkGR5SO1RLexMCzB2D+Rmw==
X-CSE-MsgGUID: XPxP+k4MSmuDvwspQT2JHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; d="scan'208";a="189241968"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2025 08:05:26 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 12 Nov 2025 08:05:26 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 12 Nov 2025 08:05:26 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.60) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 12 Nov 2025 08:05:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fXdS3RnNPhcuiZrpw2WO6yLPVSoLQmr3X4AjZPG7PP8Si+DrNNzV30urR2b81UEyK+aJYftHjM+T3P7yWBR0TlT04/+lxwrawfAZa/F5yr5FpMC5Yn/QvNfXwjZrnkAVFv7scuXxPOXl7jdfq3bFCyCCxJm51cDOOE5FD6sBl/CkZhISwC4ebBtq2XzW8JT4rWSrgPOhQ1Xe7CbZy8EXjTs5TiEiYr7Y0YLh2VmKf2V8eFum31H5RJWAXRzgeZknWe6vChwJphUjdiPucL7eFZH4aPrv+St4OSIn7+KbQCSEsUB1i/EdhNRPEKtsnjUbuePrmoSgdFoEThmf2uitxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fBJsO7bfTNR5IxSLJC+ky4RHyjc4rKMEuxu/wPgIJz4=;
 b=CX5nHcgFIv8NJkClo9rtDnObZYBfoBkIjbzgBFkhJH42pmh4c8/jqawOihMY9vYI1UgctHQzAjgDuKYMZZ74HjPD3F2UxNgimzyn1Rc6nsp0wJtwedF/28moWTNqr6E3V8+ynLVgTCld1EB0UmhN1ejqJh4vOQ6EmssHDRCDFF7YXSzgTmS0/QvRj+CI0hAVANltboePBXd+kAPJsXx6sK2eRD3jwjCwSwH4gD86VD8ozjSDLRWEUl6+QklIFmqVvxBRYNJVxkb87kIdBCN3Hxp4MjUaioirNEqiysq9xYmxd1uIsMbJUoaq0CpNp7x8rjC+N5tweOjtVMlZ42XQ6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH0PR11MB4999.namprd11.prod.outlook.com (2603:10b6:510:37::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 16:05:18 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 16:05:18 +0000
Date: Wed, 12 Nov 2025 16:05:14 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Loftus, Ciara" <ciara.loftus@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH] net/intel: ensure correct Rx path is selected
Message-ID: <aRSwOrzXJ8hf_fpz@bricha3-mobl1.ger.corp.intel.com>
References: <20251112151123.3757688-1-ciara.loftus@intel.com>
 <aRSsBFlNObpHuJJG@bricha3-mobl1.ger.corp.intel.com>
 <DM3PPF7D18F34A1AB3C04F36867D89420428ECCA@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DM3PPF7D18F34A1AB3C04F36867D89420428ECCA@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
X-ClientProxiedBy: DUZP191CA0026.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f8::7) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH0PR11MB4999:EE_
X-MS-Office365-Filtering-Correlation-Id: d9f72a81-ddb9-4b28-25d5-08de2205465a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RMnkTHVzw8FdUBAVSZNjce31t6uKS/AKmXent9QMyIhrVP0vshmiDU5XIKUA?=
 =?us-ascii?Q?xWSiFxCTCblDgQ/KqDJcThXw7geeQdG0tYHEHdOJRbbnKE7rgsEMWDDZXgXc?=
 =?us-ascii?Q?0dVJwlnp+NhPWoJubtbokLaJQZhG0BtvQ41vNNORx3sb4WLO7Rx+ZA3Ze/EH?=
 =?us-ascii?Q?coNDqewHY3/+AJjaKPd25wot3QORBTcc86rhppveyoGOodfk7meBGN+fKPYz?=
 =?us-ascii?Q?rSIAo+yL9aHCAWKRndXRZvqxEVKT+KewFEQEHwNAl1tojmCiB8MNB9OYC0D2?=
 =?us-ascii?Q?7/XDztnzIT+RXKLHOjAW3FrAYtiaIiNfPjhvsLjLL7uzcCm3rs+wvnnpYgMU?=
 =?us-ascii?Q?4aJlTf6BYdmmZiapiL59KcJToSX7c/d97oVIoEkggcGH+YOSm0gBZJaAbrLs?=
 =?us-ascii?Q?cvrnwhAdYcUNlVvVAESf8KA8zbUsLZ7lhpO7TqW3PRe9PsyUDP+yU0N6252Y?=
 =?us-ascii?Q?knrtoNo8iCP8db6iJWEF2jk057/W7Zqqz5AJQYnN3A1Xhs5bZk/YU51hUOHS?=
 =?us-ascii?Q?ngHk704yMj5BIYhAXiMDbMWrpmg9WuXKa+Q9NxADvgmufMSmKuWXlRkw08sr?=
 =?us-ascii?Q?3fwv3TEu/7BxTgE6p2P7NUF9doEG9b8JS6MZLdfXEMvlr0/czdIvA18pM5Ow?=
 =?us-ascii?Q?N3p7RHJQOenrJtKOAcOWAioOz3eC/pDqF0V+Ix0hN7he/9luly0lTQI3tXw+?=
 =?us-ascii?Q?KN7548AKUbYqAARAkIZyQRizgDLRjJIGQij5enktwApMw5LiWnNtCArbqEOU?=
 =?us-ascii?Q?oXOWDyVFcb4ADRpuGWwNdbVsCzm9qxoubGAnHT3h3kwnPNtvPgwqfo2CWBpD?=
 =?us-ascii?Q?6P3mCZSPGxOub2YvTh1y4dM+NbNaZjFgANvcq4Kb0ltF6lRprA2LdYPqHcqz?=
 =?us-ascii?Q?DPUapeJqRfFv+3IprpFb2JL6UeIgnt6BsS3p7Zw2hFKcukW7XKRvDw9xoQGY?=
 =?us-ascii?Q?98dY7ZttTI/fI4xGdFO8wIyjoHtvKU2fi3pqPOCzFVYgOP2rU7DoOFDvzipi?=
 =?us-ascii?Q?64s/eyFYTRzsyTnWEV7OI9GxjmvgNU65vLdvP3gYKsvsGSBX8FTX0pBKh0bh?=
 =?us-ascii?Q?ly9GEhkavvTut0Q/4x+SXFufUNwTOAFHGwBmFd1zl4HGOXeSFFseXpuA2BvR?=
 =?us-ascii?Q?aVQo6oJRyUbGwGPJZZsPCRmt2qsdypSaLY+YwTp3JWCv4O2JmYnF1aulZqps?=
 =?us-ascii?Q?WRqt5K9Bv5m+AVMXmbQ3IuFYLDNxY9GypKh2dXB5Hsj+eG1kk9/HJmmNPSlo?=
 =?us-ascii?Q?0nqkm9oU1Tb0pVZsttvNZV/HSObl9Zpcecxbut72rOoLrsszwxJLgTL2kLOd?=
 =?us-ascii?Q?tVL+AhaMRwNphOY6anVVc5YtON7bgLDQigM6nVg7vWWE7zY5oT9kYlvPpc5J?=
 =?us-ascii?Q?vgpGe2wzZQH61sU/us3ypyziQNVZwLJfxXyv55+n8odCBdMsPHM7t5jE40Kd?=
 =?us-ascii?Q?2KLlWkMcqPKieIuOeiGhcRybNEJRrbZe?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Lnwj19se4jecKIC5x0D51ic/6sq1gDJDWzkfczLb8C1CfBzZwsS/OIXfJLDz?=
 =?us-ascii?Q?5Ohr7DgmIa6RwZ29/BD0BDt63Rvt6fVK6RjT/uPtAuH2PhC75EtY/Ge3eLc/?=
 =?us-ascii?Q?FoAGXAWZj2Pou/uPjGWSiSrY10aT+LgpTqFJmP/crFQMLhXv4ZFNeMUjmHdN?=
 =?us-ascii?Q?4mzdaouolxqHMcs44w0T7iD+eLvdmhdFQsbCkjF9I8CKKUVfaCXHpichHgjt?=
 =?us-ascii?Q?56VVb/8OavHTM1oA/AtjtwKJgyjz7pkZbG/0+a2kvVlK8kukTOjzIdMsjhor?=
 =?us-ascii?Q?1Z9Xrg8JOMZDvZdAtTUjvq6N8clQfNsEdit2DLC9YwuYwIT8aZ/vyze2Vtbv?=
 =?us-ascii?Q?FOniO793IFa+shbrsJU6IvNt+ud8/d8qeggMohEf6S29w84WLUqqBtDMVa8N?=
 =?us-ascii?Q?D4jDyn46ok9/RH8+H7ctEqsAutJLGhV0DognMxEaTdthZmzearJG62nkilXg?=
 =?us-ascii?Q?1X1cpERLv999qgmORwcRZbPL6iGXBbBvpFmbS0KPDzVDoxeMLVv/pqRI7x4x?=
 =?us-ascii?Q?G+mommkC16NcGo7bTvCRcKLV/a5PqwB/dX3pGCS05+2vsYa4iA1HZwt2x5a4?=
 =?us-ascii?Q?3E4GP4Xhj/vkzNslLlxOaklys8uCxpC1rrvnK5dMMuKLKu8G9tPcwVQuIAKP?=
 =?us-ascii?Q?G5OWS94TBouGgkDh4344VKzVIv2ighFBLiVLN00Y8e7FENVPhtih8bhSLAGT?=
 =?us-ascii?Q?6uAgsnlFaMPiZkzexkcsQQFcqN5Rw9pJgfgRygQOF95vp11eo2KfDIEFBIvI?=
 =?us-ascii?Q?Yr8vP0lOhTB+eV6iKVTXQmu6QlOt54Vu0QKn8+kaY/CyHB60xHlKLeD8KAer?=
 =?us-ascii?Q?XIdUHxRmtQz9XgDzhhkORFG6jM5vlVJgrng/16v2uDMfioMuSj586fUwdrdP?=
 =?us-ascii?Q?RUUhrnEF3tTrA3aEWsdINEF6geZOPf8Sxcr9HyNR9+7LaCpMuvycvrHmrueo?=
 =?us-ascii?Q?eDRshCT8F6vXGjbasv2cXsPSbv7Ehch69ny2weVbldWG0/gjaQN1/GJlz+ga?=
 =?us-ascii?Q?Ewg6mzyLSIXXkEgoR8O2ES8EczkRh4tLEHIlzkwL9ypEUhHWKNrVX3CsZuHa?=
 =?us-ascii?Q?9b1BJRLPuCP9ttGiYErtyXeqoEdYQuQgvKavpa/Exs+KghAiUE82sL8wOitn?=
 =?us-ascii?Q?G7yzWXy9xzvVG/YooQ5cI8OcoSSjDLjeY8xZ/lZNhT9lKfndVm7ZqGr22iku?=
 =?us-ascii?Q?mEm2MhUspQxQDfRFdnJbIAe+l0fWufnMMyeXWxgISBopG9QIppZEV7oz/ohM?=
 =?us-ascii?Q?hOmE1HpLtErpXWYUhknRSpbyuhdjBwWIRBlvDlUILfbd3dFvnSMvb9ox1F5Q?=
 =?us-ascii?Q?3Cn0yUclTzu4F+yw6PMY41KX9V9dmVFqUDvMcArtIsK/D+WPYWHkdhMyWmi4?=
 =?us-ascii?Q?T7nNV+vTBv9mAhTYL8GRR1hx0d0hGAnGG9r62bTp6reekJlUrtwdJgdXx4CG?=
 =?us-ascii?Q?Nau9+FinvS7rKwiqHWm2H4w+htSmV7ppbSJ3KbKvwj1UHQw9y/5ZYHzsVi/G?=
 =?us-ascii?Q?mMzF7W1ahT05/s4txnABovwSN/CYdx1f5+S3+bEYbUw25bN5O413FCXLyYF7?=
 =?us-ascii?Q?ikej/75V5rOfXkb0FJSCNo08X2HwtdAM5DSInxyS/K4lbfg08HLH5wiT8dO8?=
 =?us-ascii?Q?gg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d9f72a81-ddb9-4b28-25d5-08de2205465a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 16:05:18.5956 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RQyaKQHZA8ZhAHQVAiCncJwRVXEErdgTVtuMKW/7UX696n1nzwpNsmum4blcaMRmo1xsEFM95LeCaY3RSsMJz9Av0aY6HAbel+K+Cadj5W4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4999
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

On Wed, Nov 12, 2025 at 03:52:59PM +0000, Loftus, Ciara wrote:
> > 
> > On Wed, Nov 12, 2025 at 03:11:23PM +0000, Ciara Loftus wrote:
> > > The common rx path selection logic iterates through an array of
> > > candidate paths and selects the best fit for the requested features.
> > > Currently, in the event that two potential candidates are identified,
> > > the one with the fewer offloads (and thus less complex path) is
> > > selected. However this is not correct, because if the path with more
> > > offloads has a greater SIMD width, that should be chosen. This commit
> > > reworks the logic so that the number of offloads is only taken into
> > > consideration when choosing between two paths with the same SIMD
> > width.
> > >
> > > Since the paths arrays are ordered from lowest SIMD width to highest,
> > > and vector paths tend to have fewer offloads enabled than scalar paths,
> > > "new" candidate paths with greater SIMDs widths tended to have fewer or
> > > equal offloads than the "current" candidate paths and thus were
> > > correctly accepted as the best candidate. For this reason the incorrect
> > > logic did not cause any incorrect path selections in practise.
> > >
> > > Fixes: 9d99641d80a0 ("net/intel: introduce infrastructure for Rx path
> > selection")
> > >
> > > Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> > > ---
> > 
> > Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> > 
> > But see one comment inline below.
> > 
> > >  drivers/net/intel/common/rx.h | 7 +++++--
> > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/net/intel/common/rx.h b/drivers/net/intel/common/rx.h
> > > index 5012e4fced..9fa3cdc64d 100644
> > > --- a/drivers/net/intel/common/rx.h
> > > +++ b/drivers/net/intel/common/rx.h
> > > @@ -300,8 +300,11 @@ ci_rx_path_select(struct ci_rx_path_features
> > req_features,
> > >  			/* Do not select paths with lower SIMD width than the
> > current path. */
> > >  			if (path_features->simd_width < current_features-
> > >simd_width)
> > >  				continue;
> > > -			/* Do not select paths with more offloads enabled
> > than the current path. */
> > > -			if (rte_popcount32(path_features->rx_offloads) >
> > > +			/* Do not select paths with more offloads enabled
> > than the current path if
> > > +			 * the SIMD widths are the same.
> > > +			 */
> > > +			if (path_features->simd_width == current_features-
> > >simd_width &&
> > > +					rte_popcount32(path_features-
> > >rx_offloads) >
> > >  					rte_popcount32(current_features-
> > >rx_offloads))
> > >  				continue;
> > 
> > The logic is correct, but reviewing this in isolation is a little confusing
> > because of the naming. Normally "current" implies the item we are currently
> > checking, so I assumed that path was the currently selected path, but it's
> > not. The roles are actually reversed, and "path" is the one being checked,
> > and current is the chosen one.
> > 
> > A simple fix that I think would help readability is to rename "current" to
> > "chosen_path". We could also rename "path" to "curr_path" in that case, but
> > I think it's unnecessary, as "chosen_path" and "path" should be relatively
> > clear.
> > 
> > What do you think?
> 
> +1 definitely agree the naming could be improved. I'll submit a follow-on patch.
> 
I'll take this as-is so, and you can base the follow-on on top of this.
