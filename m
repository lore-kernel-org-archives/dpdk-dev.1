Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33D5CAC5A7
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Sep 2025 12:45:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4BBBB40671;
	Thu, 25 Sep 2025 14:45:04 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 26122402AB
 for <dev@dpdk.org>; Thu, 25 Sep 2025 14:45:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758804303; x=1790340303;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=w9L4jJ4peOos+mmDh5JcvmkHaxy0tx7PIfmrVAjbhtI=;
 b=X/ldDCv+h0vTzJHSF6H0Bp7bKuDq+fRLUGIvKCom6w7m3Iz6aRkn6/GW
 KdisfMCe38kVf0x6x51TwA8R9e5A8Oau38LZRkFbx1mP92MdzNHuqsrdL
 PLKlDPmrGRDKar0kmDSaRogpNZDUr7MwNjal1wNWNQ0ZvDlyWIiIvJiZE
 mNTf7Ds/2clJ47lxMyxotwXGCzgVfTYX1s7EU/5ikaISGLr8Y0WxoLDM7
 jEjl2ae6tAYPfjSlMO2jdnBOxfRe5B+GbfnMRJu+I58UJp4JdBrxrBW6u
 T7XN/OQ1+XvxXa529BHpH4+Mrk9KOPWMEKlerCFWKFZ2rrDzA/RgsbUSE w==;
X-CSE-ConnectionGUID: Dc8sRe4jToS96+7wTag8tA==
X-CSE-MsgGUID: 2yOH71qoRWKpUUileZrmew==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64928834"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="64928834"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2025 05:45:02 -0700
X-CSE-ConnectionGUID: Z57OFlSRSYSgFcj922wiDA==
X-CSE-MsgGUID: oeYBQB5dSiqTm7o20ET0Vg==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2025 05:45:00 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 25 Sep 2025 05:44:59 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 25 Sep 2025 05:44:59 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.30)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 25 Sep 2025 05:44:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R7f0EpkWg6ky9aspKgqrtViAJWFy2JD6W6uWoMVm+YQS7bnkTeirbWKr+Rsqek5mu9xrE/zVFF4e5Ne8q6kuBk9uBcgBEmlnp4dQg0D0d5X2sSBpytZpOuFj9ywIA1D/5XkCDNhPsbEzdr1Kfcri57BvledYl1ZGCucbdnZ3u3xDNrrN+uSoqDdyx/wW+ME8mNAnNDuZOxYmxvxiP33WyCH7RAYW0I8Be7mlWdXxI5tF6xNwv9cBK23jkda15Xxfbl32dv3pctZF/7RAy68DHyCTnVaXBq5IWL2kqiTbOvJwlY84e6WzXym0cfZbiqgmKes7BaJeeBObEkk1GL11FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x2Y9Ua63syhFA2qaTHMvw7oC7C5j/u5rSnreZeV4PRU=;
 b=h2YOSpf7gNrTqGrozqw6y04ws0smHIp91lkNH5+tfF3yr+kmfQMpBFDwIPZ+jV14ZTvRpfyhjAtk/EMo4Zn0dnIizLNBPNV+qzqy27colEIIjePYHo0SJYQZvSzfHscrJVAoz6IGYno9M/2sgfkQNPjFL1faf9NL0xouseTzPMFbkUHipBCxP1Jx3MWNci0iAGhA36n5qlplPtUt/Iaxsjlypi6w44EP83SbtBeBLhfq9cYbxhskknKc+Y61d3J1t+Np281vx3ZoK44jid9YusFUeybnb1qnNabWwiBdHXiyJrM/Ms31cgeE/Fy6WAzEMaEkjOjQqHrka9D5ODLudA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7290.namprd11.prod.outlook.com (2603:10b6:930:9a::6)
 by SJ0PR11MB6696.namprd11.prod.outlook.com (2603:10b6:a03:44f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Thu, 25 Sep
 2025 12:44:47 +0000
Received: from CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971]) by CY8PR11MB7290.namprd11.prod.outlook.com
 ([fe80::2fa:a105:f81e:5971%6]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 12:44:47 +0000
Date: Thu, 25 Sep 2025 13:44:39 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Long Li <longli@microsoft.com>, Wei Hu
 <weh@microsoft.com>, Ankur Dwivedi <adwivedi@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, Tejasree Kondoj <ktejasree@marvell.com>, Hemant Agrawal
 <hemant.agrawal@nxp.com>, Sachin Saxena <sachin.saxena@nxp.com>, "Vladimir
 Medvedkin" <vladimir.medvedkin@intel.com>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>, Viacheslav Ovsiienko <viacheslavo@nvidia.com>, "Bing
 Zhao" <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Gagandeep Singh
 <g.singh@nxp.com>, Jingjing Wu <jingjing.wu@intel.com>, Stephen Hemminger
 <stephen@networkplumber.org>, Akhil Goyal <gakhil@marvell.com>, Haiyue Wang
 <haiyue.wang@intel.com>, Jeff Guo <jia.guo@intel.com>, Michael Baum
 <michaelba@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>, Shreyansh Jain
 <shreyansh.jain@nxp.com>, Xiaoyun Li <xiaoyun.li@intel.com>
Subject: Re: [PATCH v4 5/7] drivers: fix some exported headers
Message-ID: <aNU5N3y15SqzCV7l@bricha3-mobl1.ger.corp.intel.com>
References: <20241127112617.1331125-1-david.marchand@redhat.com>
 <20250925123150.3063298-1-david.marchand@redhat.com>
 <20250925123150.3063298-6-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250925123150.3063298-6-david.marchand@redhat.com>
X-ClientProxiedBy: DU2P251CA0012.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:230::8) To CY8PR11MB7290.namprd11.prod.outlook.com
 (2603:10b6:930:9a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7290:EE_|SJ0PR11MB6696:EE_
X-MS-Office365-Filtering-Correlation-Id: 82a43270-cb66-42e8-bead-08ddfc314f84
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gYnoGint24Hh4GGoJzA05h1/XKn8FVaitmhuJ5zZXQuIwc8DQ1caL/jI0Xmd?=
 =?us-ascii?Q?nbz3QBHxY0bIoPjNF9VnnPJMEFKXMrCvdbu8DfUDf1ZOUbXp6PW5tVmzuGQt?=
 =?us-ascii?Q?l32ZT5hyap13Dfin3V9XTtwWsD/VuK+AoC7OWUcVMj8jN9cXVBf1cI2D8c3W?=
 =?us-ascii?Q?oDM6+ixFpeqyqWIzHZC0dMN3+MG2Xc4XgF+eEIyoTHJR2PyzoNzGSWvLTc2B?=
 =?us-ascii?Q?tCXt566ihCRA8uCBzgdvKDGIxk9MQ1iP0szoYSBsa7FbUbK8K4Tk5DNoT55b?=
 =?us-ascii?Q?n+pKskJp83dEOi0zMfbph6O16FeHQTNY5Ag3xLJAX4vK5IdC/oXPUW1cNMrH?=
 =?us-ascii?Q?vVuvBNc+IEslxHd/7Af4miXtTn6h2oRyyheq1hLsxCo8Tl5hc/7MUEtJGRMm?=
 =?us-ascii?Q?apLi5p4D7g81dqzYUTCVDh3jXN1CO2B5xT2dyY2tuzsIglqqPBhTm+e4jrGY?=
 =?us-ascii?Q?CHsjfROKDGU3NDGNwT7y4Sldo6aHAo6O4lNQW2jYiZfjWLwiHgKr0F/gIEQ0?=
 =?us-ascii?Q?e8Iafr3yU8q5pBEhdJcgBwoBveoHGBl+A4JbR7ai3j5c81HKHbL7rCv4BMzj?=
 =?us-ascii?Q?+4VO8sdZ7AtJ4cKHd5zIPwr7nBMrcmHbOV6UdaR5s2xGUHr/pBx0kcZtfL4S?=
 =?us-ascii?Q?aihHyh3QxDazVKIx31Yu8V5ZxDYfpoje523PruYZ2QBWa+5jKe5izQm7SVcm?=
 =?us-ascii?Q?x36oKaPobEHUI8UXkoyDDERvLHomhwKWqxvXRhxCnP2sqGnyRXgg5B8S8iEZ?=
 =?us-ascii?Q?9Q0oh8HMSDY3S99vAguSpMqADNUcnpaFW2eimqXlvfnBip9Tu8ANc8nbq61x?=
 =?us-ascii?Q?veNEnAnyZBLGXLgl4z5/d52QfepHyGpyZ9ZzKlcRu7Uql+qvBrntmCTjWzwT?=
 =?us-ascii?Q?Y+IxJrIFYsuK77RFULYxasjtCKG/4/A5PJeWhUIOFant3mN6fZ/hOvvMazxD?=
 =?us-ascii?Q?reQ9W9Q95jpKqEAvghcVi2rfV4kGAKiY1f7EelWSV4Xsp49U2bEaXESJXlMk?=
 =?us-ascii?Q?LnSbbuaGjYZ9tvGUT/pHXCB9uOtCXYXY8EFvVLb6N3gnxSYLHoSM2uG1GvS0?=
 =?us-ascii?Q?rqDNBWqJFZkV0Hp/JCuEyzZStMo/BT2H0ddZnV3Co5V425dWaKjuOy+ldxLU?=
 =?us-ascii?Q?Ej6CM+WEI4HKa8f2xaaSU8hA3UT/NG8EQCxWrUKOk7dzATnvjQ/M2d3ZSQqj?=
 =?us-ascii?Q?xCDaXEwuGJ+mq0TtuVv1S+rwClfgYNF/JpKy5u/e2MK5w/0qR+O4hiq0qkoe?=
 =?us-ascii?Q?OIbUKRPxxIOmK5aLIj+jpsqG/mudiTQjavWxTTU93SnuD+xtPQcsTK6cbYYd?=
 =?us-ascii?Q?LMGiwwmUreKgN7KFl8FQ1/C6iqjGl8GDWl8TdP+cb9MxDKueYxNqUGV0YpxY?=
 =?us-ascii?Q?khlmQSvsF7i0kk2Sfj9IZgv4EuDeT9hEBh78Cd2NZBSMXeu4MupQLPax+O2a?=
 =?us-ascii?Q?UAkxtMO8pgk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dnxfk600W0UmscAD/AH1y0M3DKQ8UVcYULh6pIylxyORCnmzkowheAMnFd94?=
 =?us-ascii?Q?Wg6n/C2lCOQbRZ5zpzBz2TcEtCOmALq+8Yy6pq5ZT/Wv3VNfmuHdhfDQMo+U?=
 =?us-ascii?Q?euYmddTMVomXQhX95Pa8lAgqggGItXvQaFlWJM6Xq39Nv3BTUY53p8Cddx7R?=
 =?us-ascii?Q?tKbRGm2WzoVHMHU3iMADf34QzGNqj2JMlfEAvaL/RptBeDcxR2z8UJ/+lXLY?=
 =?us-ascii?Q?ncgKJ/5nwoGKKv6YNuawWMMlJkMpYh3SZeb1+HPcpZQjo9BSj/OfNxhTrnFI?=
 =?us-ascii?Q?bDI9KA6PEOQXNOa6ZOM8xYAeK8k8+ijUFl/egxSGB/2eGxHMrkWU/HRBthcr?=
 =?us-ascii?Q?L4VVEipXpkHUuKvG1a3LZj7p6bpASiiWTyIPonso9brrB+WzF4MFSzAMYRPD?=
 =?us-ascii?Q?1kkTeZ7U8pOpPYNp164w8e/J4qWksl958MOcuvey+icJ5r807+YTf16g1dGy?=
 =?us-ascii?Q?QAZS6kuXQLANYnqjIcmsQI00KkW0wcqCzcuVJs0tmFXjnNny3xOu1ocFXTGk?=
 =?us-ascii?Q?BuikWrNIoLMiCSckEcHgzqL9A11tP0h9h2+PAQI5NnDtdqbt9aX6bdCTvC2Y?=
 =?us-ascii?Q?1Co1KrJSPoEG7g+8KM++XSxSMPwU2sN7GBrYxuIUVo1a+EvYIhK14gnUJMpM?=
 =?us-ascii?Q?32HxJLAKJxB+n8ciFHtVeSXDEOKeKeH7/sGz5cXIQnX0HFL7RThyv+tXFPTg?=
 =?us-ascii?Q?2djZ+INV5wtJ8tE+WOULKzreQMKdRBikLuRsM/7oUraa2DzdfccDW/geTchc?=
 =?us-ascii?Q?j5EyiW+H8JTyzZ/Wcq5g0Ka9dM7pqEL/eurRla6uc5TQ2hEMfRwK931oHA7P?=
 =?us-ascii?Q?N6omp+rO2U+MPF6F8kh5ZbAl6GcXiZi5ynKY+OFOZJkO91qHiD/cgtOHS/mD?=
 =?us-ascii?Q?+tEx8lJYeK0ziCOX8L4r3H7wOs2lg4yeS+/aGjeFxk44aH9U5xjzSRyJ/O+A?=
 =?us-ascii?Q?E6h93pk/T8wxqxZn8DFEZOPPtqk+nUj2iaYuTIevdG2IhE3QDnx5tZGkxZU5?=
 =?us-ascii?Q?79g/yQE9xdAj4IQ7taeE7PlY3crjX/3tWRD/QKer0Tno9sP42/L5hKysIEeU?=
 =?us-ascii?Q?vkzIUCNKymOZV5wvtR/TcOSoX0hdBdlEdm/IJCUVhonQ1iyjhpdh7VUgfKiB?=
 =?us-ascii?Q?D98dknI4UXPJtjPgScCQJsvwtPzerNDBKKd3BPY1boKIubKu8vUuB0z1zfOa?=
 =?us-ascii?Q?jE6NBv8vK1m0Wsa6hoQSX+lRYuKseS51I+tQ4sR/8nPAWZ/+/Z5ZEvwRgpoE?=
 =?us-ascii?Q?vH1NOEEplxdNTmRyGhCdgsUmd5WOhvwXwqI3rFIimAbrEhhc2GWXyvFcJOOW?=
 =?us-ascii?Q?dGBtVtInbycFVUd7Kxc4dxjMeF9ArcLcihSZSdoFNPsnLWp+7pezb2ZEWIuj?=
 =?us-ascii?Q?4lgkHMsA/YSjGuKnXLyy52LNFakvdE1WrhinBRfo1oAkhzqFbrPKlALWvzG0?=
 =?us-ascii?Q?8DbfF6WaYJbbrRN8JG/tKNMR8CVtMAcsphnbRYLFQfr1RrYtLyDwXWk11s6o?=
 =?us-ascii?Q?ohv1XSt/XN4EiHDKETRG0LzVFJzgIDo1wYzo+F4rFZfg69/aQa5+rmacRsN0?=
 =?us-ascii?Q?QjNIhyV+FMW+Y/eg/sqzZy+rxwuurci/ANQmxO21M32J6nE0182rGw9RXfcM?=
 =?us-ascii?Q?ZA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 82a43270-cb66-42e8-bead-08ddfc314f84
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 12:44:47.6952 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4TL+Jb5SvOORTAbgP7ipgyHyXELcs43IPgFZBZu+iPUQb74XTcA9czWX0oOA5+0jXpshDrFNYZ3bsHjLs3FvzQQ+h4o27lRFI9QGcFfG3wE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6696
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

On Thu, Sep 25, 2025 at 02:31:47PM +0200, David Marchand wrote:
> Those headers could not be included individually as they were not
> including their dependencies, were subject to some build warnings,
> or were not compiling on Windows.
> 
> Fixes: 831dba47bd36 ("bus/vmbus: add Hyper-V virtual bus support")
> Fixes: 5b2a1a02dcaf ("crypto/cnxk: fix experimental version for PMD API")
> Fixes: e5abbeeeefa5 ("crypto/cnxk: add PMD API for getting CPTR")
> Fixes: 3ca607402c4d ("crypto/cnxk: add PMD API to flush CTX")
> Fixes: 8c3495f5d2dd ("net/dpaa: support loopback API")
> Fixes: 12b435bf8f2f ("net/iavf: support flex desc metadata extraction")
> Fixes: 23f627e0ed28 ("net/mlx5: add flow sync API")
> Fixes: f5177bdc8b76 ("net/mlx5: add GENEVE TLV options parser API")
> Fixes: 53c71586c789 ("raw/dpaa2_cmdif: support enqueue/dequeue operations")
> Fixes: c39d1e082a4b ("raw/ntb: setup queues")
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
