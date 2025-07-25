Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D115DC87FCA
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Jul 2025 13:42:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 182E4402F0;
	Fri, 25 Jul 2025 15:42:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id AEDC040144
 for <dev@dpdk.org>; Fri, 25 Jul 2025 15:42:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753450957; x=1784986957;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=+f9K1aDmvhil7lYjoLSjcD4fF5U9Jg+XRPFpTxcOses=;
 b=VxyrLQpKO9nsDLYHmIHP/DCR6ZIF4dcmkVJ1BDqsDFFCYv6dzRH+7eHe
 sYRGO23st+RhmD4PYXATJK4HEc1m4xe2lNtEgzFRdMZHeB88qQWWI+aCO
 eGxAbiiSzZlDfI0kk7m1zm3EN1xa/jdl3bffZiK28sNYjyytgZojXUPN/
 V+aliP2Qi11KoCLpvJqy9s7doOc0UcNlyMSpl8YnYY4JOyIil0/5KkZDO
 97lO7uQEVldW3DUOeEpth6vJOT0snPNIOMJPrWHtrz0gEDpi7nHB0ms0L
 PlyIabyrwWsCm18uEOK/3iwZjL6Y7HgNV+NZa+45b4DEokQ3VZmBRTZo1 A==;
X-CSE-ConnectionGUID: DR4d4fipTr2BcuOANIBJfQ==
X-CSE-MsgGUID: hmiVMgOTQkW4lRkWkY0OvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11503"; a="59439526"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; d="scan'208";a="59439526"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jul 2025 06:42:33 -0700
X-CSE-ConnectionGUID: VEdoPRmOTvKMI+HuZW5ucw==
X-CSE-MsgGUID: qkymKY24RAWprn7ym90fwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; d="scan'208";a="160257504"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jul 2025 06:42:32 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 25 Jul 2025 06:42:31 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 25 Jul 2025 06:42:31 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.88)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 25 Jul 2025 06:42:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kNknzG6EsNCiiR+cZtAAtklnV98UGm0qxI2HJ7l9EiUXaFhuHbiLCmbgb3eNf0Cgkw3O4JmDrPw37TqYsOwdS7qMOPu5vNGCgX+ozbjTCI5wKdac2v20ths7H7JglKXjSAvriWisQIxB5dbAYW1hsIX3xIr72DUdoU0KKcVGfiMCJRXj125aJCRgtPViOII83+aYzrCHp3O7CCSDNSXEBXXdlQ7WFBrcjM/ArVi8//OrkmfaWRVMsyjj0LOidKcp64i70WY7CfSlVlKre+PVFgoZNnIDQ3TjfZhQ1Y2KKdrIl1nBMZT4nuNTcFvWq1QkeEt9rXPPjxXMsjmIqXw83A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=20ywr+U8oi7dQgaz1Pz7VU5b2BIEaNO99+R4VVj/TCI=;
 b=VuLAOBSEGIoSksARtdizwJ265hXU5FJiVbLwv4otgJqVEN+F2uUa/75PoQgcyZMx9QnaTU0WmkyK8zQfCu25Rl4jFCbupvUZiwCKgACpqNkje09sKFXAjDVy1fDwrhojKWVpkdMEfe8aoqfZdwpIGeTuYg0Hh4xs+IGYl5knyuHGq8IULdmtycNY3fvf5ChFGeoqlgbF6r3yeDydjhoZYLOegta3JOBv5XN7ZdwJJXRnNmdJ6/alxgnuuFcaiwKTAMq71lDjHPkGBJ7DB57MEjAtsKr75rqsiHwLf+a3Ybi+gkV0X+xkwu6PqaeVJMtzPRacnMjQlpX2un7TIHOcoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by PH8PR11MB7070.namprd11.prod.outlook.com (2603:10b6:510:216::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Fri, 25 Jul
 2025 13:41:47 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971%5]) with mapi id 15.20.8964.021; Fri, 25 Jul 2025
 13:41:47 +0000
Date: Fri, 25 Jul 2025 14:41:43 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>
Subject: Re: [RFC PATCH 03/14] net/iavf: use the same Rx path across process
 types
Message-ID: <aIOJly9-fLFafKsV@bricha3-mobl1.ger.corp.intel.com>
References: <20250725124919.3564890-1-ciara.loftus@intel.com>
 <20250725124919.3564890-4-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250725124919.3564890-4-ciara.loftus@intel.com>
X-ClientProxiedBy: DB8PR06CA0061.eurprd06.prod.outlook.com
 (2603:10a6:10:120::35) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|PH8PR11MB7070:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f0d83a7-8857-4e65-888e-08ddcb810096
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?99wo+0aFEe0fcID6l1Qo/dGmEgXTtjzslIzXUMY1BIccLAkIT0aELulTJDU0?=
 =?us-ascii?Q?JlGQxGRvktvH0My7ZxhRK+X8PZTouc4x77tjlsaW8C/dJ8ubJXVV3yukKkCA?=
 =?us-ascii?Q?Wb96NJyWpA2jQr5ZlxXICS1wk85YJiZRtQYomUNAJDu0PYFp2sG12q+lhzk0?=
 =?us-ascii?Q?zbkxpUWd0TSX4imn/h8GMHaSmb/aFAOcw0tTvkXKsTbv0w/Sxp3FfI5S6ufy?=
 =?us-ascii?Q?lutqDNoq6PhurHco++2fXv2jzUMjD/p3kzj2nrvtUs+ogYt+ygsK+tjJ6yXL?=
 =?us-ascii?Q?rKt7w0w5NPSV+zLZrxmYMfeMRJ8to96P3eKN7Esu4fSANEMSZ0B5m/ZjOx99?=
 =?us-ascii?Q?SGC0m72TZJfJislhwt7lfZtzmRTCRSZ+suKDlpURu8726pi7BkS2MPfnRGOG?=
 =?us-ascii?Q?onir2rEXLHYQPNqQy1HifKQVfVhHxg5QITxDJPbxTRWOxEYNGS4Hj06wYC03?=
 =?us-ascii?Q?VwGSVbGPy0lmExMrMHqnTM/ykFO6oZ7kicnhgE07bmGiLNLyKsvTjYqC7uI9?=
 =?us-ascii?Q?fvlM/I5YQq9m5+J/ExnDs2KYKuX0U137DLflnAZ6CdKCbzwJeeGW8OaQPp5L?=
 =?us-ascii?Q?0cSEGGhme/pn9KHijFLBrGC16WRa4mhmMDrHOoqCd1BewIWHE5lx9WO/WiIm?=
 =?us-ascii?Q?LTxHFjvuN595r742xTNJMZUg4YUO5zaiM+Xcy4vcsj60LzEug+Z/oGxFR3By?=
 =?us-ascii?Q?bAxGw8N/RwG7b/MzPpcnts9DQfeIDCrVO7x3Ney61VRIPg8gebemyhoWGpQ+?=
 =?us-ascii?Q?c2qv5yVC41NKw1mnpLt7ceAee7K7ja83/WT1zwt13rOgarsX2nFrBFQhiU9b?=
 =?us-ascii?Q?+QZA3Nvl7b5vC66w+4nyxyBoISRrOlk5plj/MZdhO1aBeNOEnZ+wKsmYnbh9?=
 =?us-ascii?Q?b4wNWvS/46vbRyyV+8wbgxcia3hJVrjlyPOqxN8azEgoYK2eiEYKSIGsCtmK?=
 =?us-ascii?Q?i+WpeS32joTKGyBOFm/bAA7u9jyy4za03agRRdsbJCvVhG45WhuSa9K06ncw?=
 =?us-ascii?Q?DVcQ/Z898qsd2yg0fQF6ujDzvHlAMWFkuwb3WItFBv4uzRM8MWx8DXtd9UCo?=
 =?us-ascii?Q?B+q5B28XE5QdJxdbZPD+0X0OZMgaDl+jq4uOOEAnGqSoACDd815kiweddJ57?=
 =?us-ascii?Q?n5RB5xz0Pg1BRAgpOYDc2aFUgTikuw7bcpUpWnJdopUJRX1FVBoFXb4yDNzp?=
 =?us-ascii?Q?4rxQj3UEQbiabPPN3RNyCg2hl/ogyLAGgcADF4op9lKjFBQ39TA1zfoAzLFB?=
 =?us-ascii?Q?QeV6pWaHJTxfHBIBV4bhZQZrL0nc41YsQVGO6Z87bX8TyAZvtzijxdUFEsBb?=
 =?us-ascii?Q?mvXjRs+lXWs9EGTS6Xrdg03n1n9NK1NJERkxyLB/aH2rdDMp3BBgLLauNKIw?=
 =?us-ascii?Q?rmGP6HxNWoMl/aauqMLrgDWhZeXIYgEhWKsAoj9E36KfiltNLA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M4rhkAbh8I8LoL+3DBtm4NhkqEG8XMPEh1VRV9uVZqb3RljYHLCXLL0tMlo/?=
 =?us-ascii?Q?fU3ZJ9A2cC3XhonCBTFvmoEGRRdNOHBRkHd5hXoorcGMVosz1kEPcIC52lW3?=
 =?us-ascii?Q?VBUtIiUvF2CLLt9E/HwvHE8mWG6iANyT6+rIOr+Yy1NezSwhnofKefWKRFbt?=
 =?us-ascii?Q?IsA1QH+4YImF9lmwJwZbqMk50wPIDOlubvK/9RJC5Qv34elNB1QKqMUJkTAW?=
 =?us-ascii?Q?Ua9fV64DZcm04tI4RZ68oQ8RFKwW3ftiy8h5NZF5e1Sz605tdLud1kJr0LDU?=
 =?us-ascii?Q?OkfiVEf9O0jyfFf8hdzvt+Os32VjQWPC8RfYQ23d4iGgttQL8eK9EyVkM4D/?=
 =?us-ascii?Q?fu+5C36TIQ9PqSP1n5DrkqQDJo9uhx9Zqei5+u8uv5iW3d7q3SsAXtudVhQk?=
 =?us-ascii?Q?unjFaQWu21znKcYi4vkgZmbg0i7S5Bq0HWriptjMOp5UcviEXU5rGP7kgt7V?=
 =?us-ascii?Q?nl0M0DWhEAG9QJ9XIwmGFp8MP5nJJJSJygUHkE/e9GwyOxxqwVOJYBSZmZ5N?=
 =?us-ascii?Q?xduiZ2PEQhvSL9PmCItEcrZ0DvYILvbWEiFj/Bv6sP89llJmoO03gQcLE067?=
 =?us-ascii?Q?Yd4RJjIG9HXZ5ggFRFhrcTE5Y0MqyFTVsqctNsgbLkMzfvB1GPrZ95eiQWTS?=
 =?us-ascii?Q?Whl886mTiyLgTG2AypkIgrabVx+8GKygCXX85jUOrVU5Aui5C8YEl9dLNUEj?=
 =?us-ascii?Q?l1ZRpDj+UyTERVgJg0QldHT/QMN6LDsuF444bEv8yn9neICbdjJmc3gWHuEF?=
 =?us-ascii?Q?POE++5yWoQ1qoIoKx6iURV/8Baa+EdXv2HewVQzpLq8wx3JCZswr4jzPey/1?=
 =?us-ascii?Q?Ba6VGJwr2YCOikZ2l1Cb4ulB0o/WDWB/7OtTIdQTiTCU6IGgFLxGAsnSMwu3?=
 =?us-ascii?Q?uGI/D62boe6Uiv0L28PwuQxLq+G9ssBrH0DFdW6FNBy/Ke0iDidiPpQ6eeja?=
 =?us-ascii?Q?4YOgRc2i1wKKGQ6kf/QWXqPo2zdZWKlJ0+skM82dRjcCMYCnOkOpytaJhwCM?=
 =?us-ascii?Q?Ibl0DktiiuHoO0eli6bS7R2AbuMNf8hCBJcoSzTffKK4yaS9fjjZtDgV/Pbo?=
 =?us-ascii?Q?GLbWjQy5OX3zC5vxwJ9ePUheL4MBv3YDHsFpbsQuHtakE34eJwoPGGBwE/bm?=
 =?us-ascii?Q?bte5+bAqvwVajapGKtmf9XrO9biLqOEp4rgsHfFjyHb8YQy+dqou3cJdvfvP?=
 =?us-ascii?Q?DFaxwaRec6o6mYQu6bdUH+1K0FGoHBpOMg400K21lm81tD1CLqp8pUV5obe7?=
 =?us-ascii?Q?FCCfvK5aGVuX8NUwO3agVBud5atmkahuZYP+EjbPySJdSGrueauwi8h9y6w6?=
 =?us-ascii?Q?K51PMrDOnxhh73DgHBs6vpsjwXHCEJKRdOq5PDHVTHJYxd4JZxrG7vQ7SQdk?=
 =?us-ascii?Q?huJQjtEkpj2LCxlXxKpSJpKgnGU7RN5zVwRzBbCHNYVHxIgAy6c2yvne29a7?=
 =?us-ascii?Q?8O0TgAWHv274t3YTHq6j4CCtgKjldjsr6pAo3/LFQA8N/ppHh/vjHWpRKxP8?=
 =?us-ascii?Q?mg5nWdLvM8kY313ZPS5+kckryjpm50o5B9GynKlBo/iw/eyvAjMqkM98e1Ll?=
 =?us-ascii?Q?80Do7FNMPg7HpiofDxsthZ82WGJrZtWWtjcXyMcwrb3ooxhNNB6nCQW+JUEu?=
 =?us-ascii?Q?cQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f0d83a7-8857-4e65-888e-08ddcb810096
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 13:41:47.8420 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Ry9myjI1H1dhyFPlutncLiMvT3L0BdUORigl2FQT1tX8KiaqU14K6GGdB02y0C/xGv8S2hHyIM0dFE6ny5WUbRJPpxb0wo/Vf0LSr30AWU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7070
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

On Fri, Jul 25, 2025 at 12:49:08PM +0000, Ciara Loftus wrote:
> In the interest of simplicity, let the primary process select the Rx
> path to be used by all processes using the given device.
> 
> The many logs which report individual Rx path selections have been
> consolidated into one single log
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

