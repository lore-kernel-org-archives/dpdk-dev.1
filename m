Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40508CDE001
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 15:58:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6E4084068A;
	Thu, 25 Jun 2026 17:58:56 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id BAB1440616;
 Thu, 25 Jun 2026 17:58:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782403135; x=1813939135;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=h/xLMxHu6twDCdnhmdn6TVN1PrOkZJMbdF0xep5Mn00=;
 b=lXlIWGls0s9kVnERcbzGA0GKjKwnXrocJ9PEBNPk3K/2AAvOnDAPwF9U
 fBl/PqKULICNs8gKOxIkk2yAtmGx1GI8OHThbmuoLM/9Be1DQUJjtE9YG
 pI8/IemmUkwGXskoLlvW7oVwXCQR/h7t77bXq3H4kJfE09mBeSGt2BAZq
 8bZtpnSzyQTUMp/1WIm7XsCoaTg9M6qyhyjQFGup6cROw4A8ECllK7B1C
 UgKL/ehMSRNBD4nr4pF5lbN0NNmSy3EnkqjtdQRZkUnQx1AG1aYfAh2OS
 WmWCK/k/Res/Q/a4Tf2nNDDafB+BoOhwAEnBhgRu7kNrblJr7+iraCmzX Q==;
X-CSE-ConnectionGUID: JGMiCV2YTWOm8PWG1zrkUw==
X-CSE-MsgGUID: 9NpE4zw1Tpq7Qsjsrs5MdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="100609584"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="100609584"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2026 08:58:53 -0700
X-CSE-ConnectionGUID: kyLqwPhkQES447vsdfJc7g==
X-CSE-MsgGUID: XIiVKn4UR/iKd760wne5hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="246436684"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2026 08:58:53 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 25 Jun 2026 08:58:52 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 25 Jun 2026 08:58:52 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.1) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 25 Jun 2026 08:58:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=csUtx2+o3IRIW+eXrF4Iacix55kzn206GgGjHcfsyHcarF5GWrZY2E6h6QCrl8TMI2+Q3u16VK83VPwg8g4URAAYCmku3f6VHjTIxDf78sVTXUy8Iy/71ki4GBuops6yEu5McrgjjxPONk9AxY8iEuv01F2FIE2Endt2HMQv9iHZgnytuu6eaZW8cABTQ1vHSB3UcfcyzKvIU3tnF4ASvnlCeqMzPsuLD5FkFTPbEFmZ2kIltg4MEbhOFwVxXF4TWLgkqwLBrUKoQBtm/iORmgFqOzxof3OL1muZxtcb+vkrJxZB7CKg/E+lhqQFBMpIcLUajw/udafFrxgtVY++0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ocXl1KerAgw562NG+HRW0YrTpNGLvGHkzA34VZH+jpc=;
 b=yxqiKyk0z4TL5fdZ4DW8mhX6Y4MNQ/1+QtXdaJFugmFFL+tSt+z5Nh6I/IqghLmKRJ6UC6SyULo7wZG293KIsLgX92ACAw23x4VPVDiPWRgxVl/OCT8xDerIKRfhuGDgaL0rh8YwBBE+KRult6bYGqsHBphx4Q3y1pEvyT1MFkfnB38+mvlj+dTM259G8SLlOBWCZswlvpRNPIXcDzXjE2GadXyWUHCyLouf/90fx9jKV0G0bpr2W1aRkkb759x8Dr4+QQx+86b8VsY+sHGOvlz66pEg39xwTMvS29U23MwOqVX6H6aPMnxg72hN/BuKK2JAm+9Iz2jvU9KaHT/kOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ5PPFED9C9AC99.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::85d) by CY8PR11MB7778.namprd11.prod.outlook.com
 (2603:10b6:930:76::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 15:58:43 +0000
Received: from SJ5PPFED9C9AC99.namprd11.prod.outlook.com
 ([fe80::2271:3ab6:e9cf:4ba2]) by SJ5PPFED9C9AC99.namprd11.prod.outlook.com
 ([fe80::2271:3ab6:e9cf:4ba2%8]) with mapi id 15.21.0159.015; Thu, 25 Jun 2026
 15:58:43 +0000
Date: Thu, 25 Jun 2026 16:58:38 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH 3/3] net/iavf: fix Rx packets statistics underflow
Message-ID: <aj1QLsdpA7iOsFYI@bricha3-mobl1.ger.corp.intel.com>
References: <20260625093619.726471-1-ciara.loftus@intel.com>
 <20260625093619.726471-4-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260625093619.726471-4-ciara.loftus@intel.com>
X-ClientProxiedBy: DU7P194CA0023.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:10:553::14) To SJ5PPFED9C9AC99.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::85d)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPFED9C9AC99:EE_|CY8PR11MB7778:EE_
X-MS-Office365-Filtering-Correlation-Id: 75272db4-b94c-4d3c-0438-08ded2d2a209
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|18002099003|22082099003|3023799007|6133799003|56012099006|5023799004|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: SZlOYHRuCvt62u8uuEH43IFI6MUclyVX6ZiOI3BwrRj0xZZXCqECGNwiyjGdp4Y6utJxURERkAG1PJJlywe+41NeYF6JbJzwnsYrJxIglgh37vR24y1ulvwCQcoNli+UogJVhMonbJS/2iJepIGFUil60rB9sK4mC1TUhIfKb6aerBmAhAf1GcblDl7wwsj/CAQUauIV9TfXmrcwJTmb3qKSj7gGjFJyEu343slnmraUmPNIyW/ZmR/VZYVKqseqnNZ0qv9xXeBvCVpIojIwMFLF11lp+VSEG6mCEUALoxl39DTxZxsbuxUPKNQkPI67K1VI1SwE4IJ8+dtGw+tPjNVfArl+Z2CCoLGnPrsvQBDr7RGNyXzK5zOkrAHCWvfH0MM2yZw3sg+tELQzWVwsRwZaOHKTJFmblCTO5nPKb1wNw0BXUYL/dpwETxlQmo7VJ3sgDujwc4Tf07G5DqId2BZ3Ck5T0WoDclSfE8z5T93ZhaO4UTkS0k+tdy5ur1SEeQAtINYupJyHhjY+vPB8YHsxTN8YDc8ZZKGhSjqqEkrgog3Sr0Vq4XiMrtea30nDvKi0uO4LV4HDkeBgkmc4Q5DZKIRgeeuQLUlQj/t7RMnJ9DsGL7XkROKmGdXDbIGLHSnzaEwG61a18Nh+InxQmhIidTgls/Wi7pep6VC7zjw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ5PPFED9C9AC99.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(18002099003)(22082099003)(3023799007)(6133799003)(56012099006)(5023799004)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iaCjPq6FFXoXDKrlQpyVqeyePaJVqKFMwVsHWygZJvdZnQKsXfZhR/zaBEJk?=
 =?us-ascii?Q?sQemb875lVMehGjH0/hWb2Fyo7OMOphzuRJ4CsW5FZRIjBeQE8IgCJMxKAKH?=
 =?us-ascii?Q?XdOxPNQU0WbiyTZi9cMjVdLDIbpf4EHP8B/dsiOS59BLPqBbPD0erYQ5QmTy?=
 =?us-ascii?Q?wYmDY4sKZkuvAml59B+WVa4PMa7ZDcEhwGKc/wEtANPs3Bj7hoH3TiTvXAUB?=
 =?us-ascii?Q?HkKCUd9P+erw1EL3ZFEqjB7CFzXW3SjseYw0rqk+BmIZ6XLHCHWphPNyX/pM?=
 =?us-ascii?Q?Own9IuW6rK6+rgnZGOgvBcEzWGvSFnv9uOOSF4+0vOZDdVHrpuVD/z7rGVra?=
 =?us-ascii?Q?0xkC4I4sNIoDk642xeivaP2AHkwEEHx16KQX8izt4+pdxK9fDwsWwKjmEBp3?=
 =?us-ascii?Q?6MaARBBBJJhq4vL7Bmy2Y/DAVBUmYXgEvHqC8xZisnuWtotk0qZbu0Cvdoiz?=
 =?us-ascii?Q?bK04mEQ9U/Dyk3ZRxelKB4VZq4i3lFP2uBvx2DZknVTMOKJwMZq7fqwJKanD?=
 =?us-ascii?Q?zsW7Vg8pghGdNpj98hI/DSQCoSfRdnG2XhV5yiiFGZMKkjzswCD89I1ZkPrq?=
 =?us-ascii?Q?53xSAE2NZOJOLvjXkNU1D1+wG8l3CCmCluuo3O8HhLqmiEfwbo76uxXzbhR8?=
 =?us-ascii?Q?YUQLh6H1NJ0m/xj6vSen7wXBM/OxCIpf1Z6UkCvK0vidtcrAnulgCZm2cww1?=
 =?us-ascii?Q?ChpsepmRdp9QV84BGpoSkmkSGwfPT2r/vEAtcV4nCBIH+lLx6OPTe8lGcRKk?=
 =?us-ascii?Q?XUB7rYUkIaSPJU6pfds94jyhzNBAAcYIBNRyTVoSj34vPYR2UV8KQYr0kqpO?=
 =?us-ascii?Q?kYi+l+KXj+SNtLAa7Xrf47nvzgQzO6v2hrH0JW7q7OjoWuFRLczOahffCul1?=
 =?us-ascii?Q?QYfY/m8jge4/fyXAqmwb43mmPvn7iLjj/2CbWSeOWDAer38E05GmG1WNm9fl?=
 =?us-ascii?Q?V0caUNTdZVEdr23efclyS8T/xJ9XDrKH20Y7P67UKzATXakEXISgMSHnNIsV?=
 =?us-ascii?Q?+jv6hOjBKq1GO7DLvi4TVoQ4B4wR/X+ibxDvtKF3hzpTmKxs+i3D5/CG/4YB?=
 =?us-ascii?Q?RA3MWbJ8ngeQJpY1BfDUCCRF5IHggmyZLlX4SBp0hnB+5fOIz4QibEyWjmeS?=
 =?us-ascii?Q?CG2bG5pCys1GnER4kxwbW/9FQ70KKW3Jkf/l1qHrY7MGv07Bl+gFXZ+t9feP?=
 =?us-ascii?Q?9tAuH4sOmiw5hRqraktHY0yLGjF4ofc0kbBQkcIIGSDYRm6BhCc+htnAVnM0?=
 =?us-ascii?Q?Cvuo+4X2fOLJHOx88PhpSGDlFmELxNqy47TIu2efCnxrpvim6o+hq6rmFByk?=
 =?us-ascii?Q?078739JtYY/31Le4tdU2wnCgnDw3BCe+ewVcEwbcoT+qo9LL51hAUl/Q9Re0?=
 =?us-ascii?Q?jl9295x3hVC9QcjYHLNGI4DmjqgkxKX/TkduFbolyuURIH05AFkQf5MK8uOo?=
 =?us-ascii?Q?Q16kPOniaTkJprpnBOA6MS8Q6Q7gmDZav+BM9hnS9jpWy7Up21pGmRxQUCaw?=
 =?us-ascii?Q?7x0etY+VSnMRzd5TdRFVzyI3y4pjj8KvOohOm9WZu+/fU+CMlYpcSsDLPUib?=
 =?us-ascii?Q?cXanjAabGV0XmuKfrZqZZ/QjWlP7+AWVD8rTBErOPuv1OdcAs8WlLuKcO5wA?=
 =?us-ascii?Q?PTWL72112PYMeRb6QXI00LSJ+OWRLGGe4pDpcOo0igvxC3mOTp5dlY1gnuUQ?=
 =?us-ascii?Q?ckp0p4e6KAua/nExwxeX0xVlQyYA38b3LVHlZi4iErlAvccGZiVbSo+kvVmV?=
 =?us-ascii?Q?7gzoNp1yw7658qVOZzGuYN+d4nWg/9E=3D?=
X-Exchange-RoutingPolicyChecked: U7G8i/albOoCWaBuocJHq6lwaSLZfuuaThjRNTSWH848aCNymMlViVlvVsX90550apO+XGUdaupIUIKuCappr/bW8RknWgrifO+Re1pjjFsDH2YltcrKzacS+cayvv1rsf4MMtWs/WRn1zhqdEdz9CfC4syZ/9wPs7T6aYUoA1ZGuoOHjgFuzXZQWKxUyELVPyalQ0RnYIsrGLHCDe10ZMjrlBxcVSxiQKTJjaOjj9cfGcS4mga1VIz8aQOxp1gz2KKK8yRuACtmM/ai8yew4z/70NBpfMdx5w0oxTCPpCEficTCLpfeh6UKF7vjcntzKrOjwTgxvOJ80/j2oCZe1Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 75272db4-b94c-4d3c-0438-08ded2d2a209
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPFED9C9AC99.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 15:58:43.8162 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ACIm1qKHfRPoS7exTRxbH1wvrgxnY+n+ITiSDEnJlcermKpmioMi9PobJNHdGZ5s4348YaryaFtrME5oBJbxjYJQln7IfsfTpa0R2iAoxw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7778
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

On Thu, Jun 25, 2026 at 09:36:19AM +0000, Ciara Loftus wrote:
> The number of Rx packets is computed as the sum of the unicast,
> multicast and broadcast packet counters, minus the discarded packet
> count:
> 
>     ipackets = rx_unicast + rx_multicast + rx_broadcast - rx_discards
> 
> The unicast, multicast and broadcast counters already include the
> packets that were subsequently dropped, so subtracting rx_discards
> yields only the packets delivered to the application. These values are
> provided by the PF in a virtchnl_eth_stats message; the PF samples them
> from separate sources and the VF cannot guarantee the order in which
> they are read. Under load, rx_discards can therefore momentarily exceed
> the sum of the unicast, multicast and broadcast counters. As ipackets is
> unsigned, the subtraction then wraps to a huge bogus value, reported to
> the application as an enormous Rx packet count and packet rate.
> 
> The read order cannot be guaranteed from the VF, so use a saturating
> subtraction: when rx_discards exceeds the sum of the unicast, multicast
> and broadcast counters essentially nothing was delivered, so report zero
> instead of underflowing.
> 
> Fixes: e71ffcc1008e ("net/iavf: fix Rx total stats")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
