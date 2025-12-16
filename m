Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317ADD5CCA0
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Dec 2025 09:52:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E4BF4026D;
	Tue, 16 Dec 2025 10:52:37 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id B39594026C
 for <dev@dpdk.org>; Tue, 16 Dec 2025 10:52:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765878756; x=1797414756;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=2aRHMjipg46/Qnh1xPLjk9MozqjCictZRDjWUYwLvL0=;
 b=eIVXVXce3nRDUoxjZaMAL4hrh0i2tnoDpTqAKd5hin8gU7lJloooqIPO
 yOtaduGPy/iUGJC0VuFV97Dt2Jac4PK4q+78gdVrt4BjIHsHvB+3d2xRo
 ksOTh6TK6Apd3j4v9X48oEenvqjdX1fRLNMy7raVjUlebZ251FOrcuGj0
 rENr5Rbl0MYuZHmr7CuN/zykGJB5JEZrOpOuVEryL+obBBRZb13GD1wQK
 a1IIn4zgU0jcZNYdzxUEEU3krtfQ6/THnJjD7xeCbsAhEJC37LhRjCMgK
 yw5/ydyHskD1G+LqHjesVu+VEWLl27I/vx4Rt7iXe5dU+4Vwx56OSf1gd A==;
X-CSE-ConnectionGUID: 1zfw2I8/SqeUM3WbLAzKWA==
X-CSE-MsgGUID: ApAaTPc1Qju5a6B8Vpx2tQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="67828323"
X-IronPort-AV: E=Sophos;i="6.21,152,1763452800"; d="scan'208";a="67828323"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Dec 2025 01:52:35 -0800
X-CSE-ConnectionGUID: QT29jVuwQXWuWHr9AyM4BQ==
X-CSE-MsgGUID: tKEuyXoiQWOsbznFrCkmYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,152,1763452800"; d="scan'208";a="228654117"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Dec 2025 01:52:34 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 16 Dec 2025 01:52:34 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 16 Dec 2025 01:52:34 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.69) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 16 Dec 2025 01:52:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gGtUvneaLdrW5hCKGG/Hrhic7LEXjyzQwdvZ4uoqRVcrmtk2JUyAy0xefrQEuHnZINtmN4oFq1DvI4tcC3r6P+bB65KgWxzxnrL+szEIChPYKzoGr/SO5iGMnCcZd0h5fYniiVpwFM+gAQOJ6a+9QYEKfl9GsYcB8X0Az2UCEpq6In0lEnUUiEZ9WmxZqpQOnZQr8A8QcSfzXOGiQCF0PEMn/xj0ZoBk+ifZJGokdEJW9diJV8zG0AxYpmslargedL9mBzyxJ945kk+Cc35Lv7kG7mRzbhdCw5hMfTT9f3JoWDH0r0tD12GUv/nXccSstypfmwYS0BJxs7I30UlgbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mq4leC7Znl8TRoil7fk/dbuv7X/7xNER8wXEt0jB7l8=;
 b=yW/wj0xx/r2TL6rkqJG2VgdyzXa7oCdCBB5nLNzcHzXJJa3XdN2PJxmL1EhGzwIPDcPmoeEQqczjiZjQtc7XtDNZBHDmSQSNFJ93a5MxMPPPWN57WHzVmQaygoDLESxZvCh8BvqC2Mu00oB47ypiI1XPQSJfrulIkuJ4nrW1nNoQiKMdQeVhZsmicREWJwRizUpaRvqEyJppvFaPcpIp392mthvUCk2MPgQp8CXnApGhMOisk6Tec4TP+0qXcxTAJhLVokeKe84oE0C3j/yhdubILfSgo9gj4wJPd59SkGFIQXblj2tIXhLT7MlK7KiKbGXBJ26RUwwbpWeP+lMOQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by IA3PR11MB9448.namprd11.prod.outlook.com (2603:10b6:208:572::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 09:52:31 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 09:52:31 +0000
Date: Tue, 16 Dec 2025 09:52:26 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: <thomas@monjalon.net>, <andrew.rybchenko@oktetlabs.ru>, <dev@dpdk.org>,
 Praveen Shetty <praveen.shetty@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>, Anatoly Burakov <anatoly.burakov@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>
Subject: Re: [PATCH] net/intel: improve Rx descriptor ring size checks
Message-ID: <aUEr2u81g44Osaim@bricha3-mobl1.ger.corp.intel.com>
References: <20251215173543.1707960-1-bruce.richardson@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F655E6@smartserver.smartshare.dk>
 <aUBMSa4u2Qjyy4t3@bricha3-mobl1.ger.corp.intel.com>
 <aUBReiTLkIp-M46a@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F655E7@smartserver.smartshare.dk>
 <aUEc2jGvHlg13gOm@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F655E9@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F655E9@smartserver.smartshare.dk>
X-ClientProxiedBy: DU6P191CA0004.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::21) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|IA3PR11MB9448:EE_
X-MS-Office365-Filtering-Correlation-Id: 229752a4-d026-497e-c7c7-08de3c88d4bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?qyg4M2+PFc6QdLOAT5U8B8ADCmpcxY8rdRxPMwv1EWgejnOl5sdnNLJ+IX?=
 =?iso-8859-1?Q?0ZhddkjqE6AXB54UkMo6+jnf5bGa9bfaNr1t4v+S6bQ1M7nrVpEYyyBgrB?=
 =?iso-8859-1?Q?e7xIzkbut9TnyRH0M/0vWzaN/0ZMWpU6xrr1AJ5i9Ob1XsF0y18l4eZh1f?=
 =?iso-8859-1?Q?fN5XRL4u6RlWld0FZlbOO3nJLioKHaJekSRGDXk9nWYIWdGofBZ3CKWvlx?=
 =?iso-8859-1?Q?cN+KBtX4xuL7Skss9nVQGRHYH0uynHdBmq+U96LHOtJjtqodY+zxI/q0FF?=
 =?iso-8859-1?Q?bh5P0pX0gEno3u27eU/TYEsG2F72kcccsmT1gfJnVi31tQaGrRiM12DBiO?=
 =?iso-8859-1?Q?PBO36vTI/zQl1AybSZAhBRldf1+4+38JfWJiFXrem0RfBaO4BHxFUbhgEp?=
 =?iso-8859-1?Q?88xKAKbLpMH9Bqw5uVm+t5EyFpttyIMFL7rino9y5AX/A5jITZ1X2WpxDe?=
 =?iso-8859-1?Q?kC1hln02z1SgmLbCulmkRsmENkoHVDsSyJyLEDJHbM1G08nJttOUZRmtrz?=
 =?iso-8859-1?Q?kdCmwM0jr9eL+F8SehfUe9MuTc33sZedOGo3HJ258c7sYm7MYgBNcn8hV9?=
 =?iso-8859-1?Q?FMopILULuLyhJt4/BkJehSZwqXsVuk55OmX6uKVH9EAWXE3As0tvuI/ppf?=
 =?iso-8859-1?Q?chdHolpGn0/Hu2GkDtSkTJuVAdslRWvvs9owMrEejXFeb+lPHtb5mMGBwg?=
 =?iso-8859-1?Q?Gg0kyM15Ma1W8GhEqeGvO7r0zUhBOwNYI0iEtQRcO5UU2ImRvmp8MlMEe9?=
 =?iso-8859-1?Q?UuT9GRbIywjjYeVtuSiDvBsHZE0Da1g1nJWqeC6zYtGpS+y4tOAcJzgDcD?=
 =?iso-8859-1?Q?R2PjaAU+hSq9HLZkdqUPb526Fk4DxwlFgl3QrzIlQQ67PgYaffoezA5WGE?=
 =?iso-8859-1?Q?QQWNi1Ojtx26dYwyjqLzPF08YmtEtNCdu+U7nYYVoid1yYzSiON+dVcnXr?=
 =?iso-8859-1?Q?XsTUlC6BIJABVCZvF9smqigDwvsMkCr7sUIjQaN8cj9aQ+7hxMxbnxDnLv?=
 =?iso-8859-1?Q?lMuuS9WBcIAgZbAGrWzeM7LQKB+bXa+h6sTMxNplRKQ/jydIHD2ZJKpAAS?=
 =?iso-8859-1?Q?cqqALVnjzSxM5N6o9QHdOO7ME4fJiFKnHIwKcG7U6TD609mf9UPxWJsU33?=
 =?iso-8859-1?Q?pNy9XNmb9bO/6w/j3zPRUoYBzMQuwZxBzjOdlq5jYoy8D/E35+uOb2ekrq?=
 =?iso-8859-1?Q?pfCLcND0cnD6+r+4vzWCruTN9Oxvfqdfd5dPVh7Vwc9SMtxDz1ZfzUrjct?=
 =?iso-8859-1?Q?MHD0UDJNLF6d5VRpaeOq68XoOvj+WD6US/L2QPS8jZvkjPPVbyc7mSYd7c?=
 =?iso-8859-1?Q?CysdXoEKT3kAHaXHdIq3EeXz6ExWEIxsP2AL42LkbPQ9mpC1uQiL3qqwcA?=
 =?iso-8859-1?Q?9L6hPfx/hHCF11EgkpFKr646x/fbgnPpJywcqGofktosL9kwJXm3I/Hitl?=
 =?iso-8859-1?Q?0ZnF88zwa5a90Y0dwDcsGlF39pi89WIQjJEnm6x7ejWP0uQczPCcoUuVJa?=
 =?iso-8859-1?Q?6jP3BzRjUk7MWxaZO/mSBs?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?UBcqykIpuTlIDXkn4t68I3eMHKN28HbTToOA/2iulKo128Qf5DzNrEoInX?=
 =?iso-8859-1?Q?WeXLxlcbzH0LCV8bs24O6wllHcr2VnlICjazpLZzFd/wglK6AEIMv91vB5?=
 =?iso-8859-1?Q?AdTdmURprHiJpwI1z5gEzepQb1Bu/U9Gr1CBovFzzxax/1o3JJYdJ/TYZy?=
 =?iso-8859-1?Q?Un29WLYwTJi3Zh2bJv38h+WB94QwA8ONTWJJktxiIxsj5eA3sMwZA9xi4u?=
 =?iso-8859-1?Q?ka/XpDHY8P4WmFNoSfsig/2uNoaBnj0UHL+WIIJbx0++/Cp2UJ5GqE+Gaw?=
 =?iso-8859-1?Q?aBoBpu8xXF9l3d0hM2Vs5vRP8dKFix2u3MzuF6YmuTW8MlsOgfSphh9EcS?=
 =?iso-8859-1?Q?3ruGSR4FUqy6aim5AtLh1MvUTNh962G0cYxAKqQaUr/upojhWt7oJke1II?=
 =?iso-8859-1?Q?JVTQyyyPaBBGPPxFSCaNYiUxk/EFbLYb8vpnYfu4Nub/SU5gVlwgUoIbIU?=
 =?iso-8859-1?Q?BvnmKzBdNw/hK4t4I+AGwLMO2ylN4fz8Nb8+H8SEA69B+//MO1PCGyO4uh?=
 =?iso-8859-1?Q?TGEy6lEioJuSd+TMr5a19cj7kGtYXttvHl/yZzLtn9QF056WPkJem7wdG7?=
 =?iso-8859-1?Q?MY+KjlHBAaamfTUPegJs+t003zB/hrDwKWD/2+80cJBFlCidhcPkc2ioC5?=
 =?iso-8859-1?Q?1kJVpQjdCwbcUGYMqLzkQXGQgIe55XkD+/6H6U4ps9FbIcmHmCUhgkk+Cd?=
 =?iso-8859-1?Q?0/BIfgT868RdFGnbzSn8UU4zwwyRXjFaMzc91gP8hd4RTn43o941sEPEgM?=
 =?iso-8859-1?Q?2Zg5IcsB7y1zIfIOehg7+jlHGfBWur08MnD9zJf1BPvhzTZxgaKVIs3qd/?=
 =?iso-8859-1?Q?y7Lbjt0YcvLVLnXEtpOZn5z55oQW2pcnj0wE6p6ZEo3l+NTX51vryeQd+e?=
 =?iso-8859-1?Q?RvJqMB9seNaQVyA+BkwJyN84djnY4914lj04xZ1fAhNpktSuzAY9RlFCjl?=
 =?iso-8859-1?Q?5Pz0EmLzMfs8dwdwHDiv5oiMCjgpb/L+UDyZikA1cbbBojIx06Bcx0kVCP?=
 =?iso-8859-1?Q?YSKFPTWtqZtyTLMf61TRGw/aYMN9wWGDRaj52KzErylopnHZiut3ZB3Chu?=
 =?iso-8859-1?Q?qYCwEqQozJCczHVk3B6+u/pjBTfvyH+YpyYdLhWnIKTqhXqT59JnHAcqdr?=
 =?iso-8859-1?Q?mcGPXzpEw5RRnxSWTjHBurkFZA4Mq8RlP5urmdjskAVzg5m0BRagb4gbxV?=
 =?iso-8859-1?Q?4HgyZtXtD+MvqurAo3pBzLvx5d1VxEgT/3YCwYBvCRCS4cCtsg7qVhTI8r?=
 =?iso-8859-1?Q?1a7zuqxNP33YKGcE8mUzE/epaXGN6QQDd+WI4aBaFVBPCgS50dY/AU0bm8?=
 =?iso-8859-1?Q?SyHI2Y8rzcJ31NEp61kBGoU7HUEGIU0Sm34V9US0irNJL08Gk3luqc2RWz?=
 =?iso-8859-1?Q?m3Cu6KEcNMMx45pQx9vuqmReHZiwjgUNy7xM4SqT4aEcI1H2JCIfOdOq7k?=
 =?iso-8859-1?Q?JAQolaD9Q1xLQoPlte3pAwzZNOefbiU8TPYdWzzlowpJyyGuGu0Nns0qlA?=
 =?iso-8859-1?Q?jTKn4vVT1lw95VoITEZiTltkt1D5jLQOjzC0Z43benshEewhGUOwlkerMo?=
 =?iso-8859-1?Q?is5tzAeM3QyOxqu/jiSYzJ4rUCC6+OHxuZlttXGjKR3AL66us1xDcwwooT?=
 =?iso-8859-1?Q?cmz/tVLnRQ/3k9BDUV5UPcXD+9LMLIQO6VTglOJEUfMzEDBq6DMJX9QA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 229752a4-d026-497e-c7c7-08de3c88d4bd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 09:52:31.7660 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i7tP7LO0dTCHQRKHXbsDle+qtUVygEH7o/yZ8Xizel1fgUd9abnbffkb22t103kqs+Sm7p5OOTt9XWC2BKRZ7+qZ13U8rIPmq7SfDmKg/jg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9448
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

On Tue, Dec 16, 2025 at 10:25:41AM +0100, Morten Brørup wrote:
> +TO: Ethdev maintainers
> 
> > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > Sent: Tuesday, 16 December 2025 09.48
> > 
> > On Mon, Dec 15, 2025 at 07:53:27PM +0100, Morten Brørup wrote:
> > > > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > > > Sent: Monday, 15 December 2025 19.21
> > > >
> > > > On Mon, Dec 15, 2025 at 05:58:33PM +0000, Bruce Richardson wrote:
> > > > > On Mon, Dec 15, 2025 at 06:54:50PM +0100, Morten Brørup wrote:
> > > > > > > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > > > > > > Sent: Monday, 15 December 2025 18.36
> > > > > > >
> > > > > > > The default Rx ring size checks did not account for the fact
> > that
> > > > the
> > > > > > > port would not work correctly if the Rx ring size was only
> > twice
> > > > the
> > > > > > > free threshold size or less, so add in a new check for this.
> > This
> > > > would
> > > > > > > generally only apply in cases where very small rings sizes
> > are
> > > > being
> > > > > > > used, for example, with default Rx free thresh of 32, only
> > ring
> > > > size of
> > > > > > > 64 would cause issues.
> > > > > > >
> > > > > > > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > > > > > > ---
> > > > > >
> > > > > > Does dev_info.rx_desc_lim.nb_min returned by
> > rte_eth_dev_info_get()
> > > > need correction too?
> > > > > >
> > > > > The minimum number of descriptors stays the same, however, if
> > > > choosing the
> > > > > minimum number of descriptors you may need to reduce the
> > > > rx_free_thresh
> > > > > value.
> > > > >
> > > > However, I think you raise a good point. I'll see about adding a
> > > > specific
> > > > error message in case the user is using the default threshold and
> > > > setting
> > > > the min ring size.
> > >
> > > The applications need some generic code sequence that always works,
> > on all NICs.
> > >
> > > E.g. if an application uses rte_eth_dev_adjust_nb_rx_tx_desc() to
> > move a requested crazy number of descriptors within bounds, and uses
> > the default values for all other parameters, it should work.
> > >
> > 
> > This is surprisingly difficult to make working with the way things are
> > set
> > up right now. For example, if the user wants defaults for config
> > settings
> > and passes in NULL to the ethdev API, the ethdev library queries the
> > defaults from the driver and fills those in before calling the relevant
> > ring setup functions. Therefore, the driver level has no knowledge of
> > whether the user explicitly requested a value which happens to match
> > the
> > default, or if the user just wants a working default value.
> > 
> > Another option would be to set the default low enough that it would
> > work
> > with any ring size possible, but that would then cause a perf impact
> > for
> > apps which don't need such low values (as an extreme example, think on
> > a
> > theoretical driver which allows ring sizes of as small as 16 or 8, a
> > free
> > threshold to work there is likely suboptimal for more normal ring sizes
> > of
> > e.g. 1k or 2k).
> 
> Small descriptor rings are not theoretical.
> Our application configures very small descriptor rings on unused ports, to be able to process background traffic (e.g. slow protocols) on those ports, but still conserve memory.
> 
> E.g. the igb driver reports dev_info.rx_desc_lim.nb_min = 32, but multiple times this value is required with default thresholds.
> The i40e driver reports dev_info.rx_desc_lim.nb_min = 64, and IIRC more is required with default thresholds.
> 
> I agree that defaults should remain optimized for performance (maximum packets per second).
> 
> The problem is rte_eth_dev_adjust_nb_rx_tx_desc() not having sufficient information about all the thresholds to correctly calculate its output values. I'll file a bug report.
> 
> Updating the drivers to report dev_info.rx/tx_desc_lim.nb_min and dev_info.rx/tx_desc_lim.nb_align that work with default thresholds could be a workaround.
> 

I'm not sure I like that option. How would one then query the limits with
non-default thresholds? Also, it doesn't inform user as to which thresholds
are causing what limits, vs limits that are hard ones from the HW.

Other options may be greater use of e.g. 0 as a sentinal value for allowing
the driver to pick, or changing things internally so that the source of the
rx_conf is passed to the drivers. However, I actually feel that the best
option if we want a "most usable" solution here, is to document that the
free_thresh is a hint, and that it may be adjusted by the driver if
necessary to accomodate a requested ring size. [We could log a warning on
adjustment]

/Bruce
