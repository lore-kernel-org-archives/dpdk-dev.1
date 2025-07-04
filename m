Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2966FC8303D
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Jul 2025 11:32:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5E7184028B;
	Fri,  4 Jul 2025 13:32:24 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 96E1B40267
 for <dev@dpdk.org>; Fri,  4 Jul 2025 13:32:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751628742; x=1783164742;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=waUGrSJTfoBYEykkrx/cHpYpoM7P5Qtpc956pu2JP4k=;
 b=YyUnb1e9QBNaNKw2Z5rZW1vqtzDgl8+GsbJlPdymD8x4Q+ihipNQAQgn
 dtsgQ7EghGC3HZ7A2/1EZz5RwRkjm2QbWIidZzILJ71Trl8fntu0oKo54
 iWh+zmlZHoI6lWgxeT1wQ8/65ygH2GLDYGUZu31FHcl3HEH7mzDAecegB
 ckxUSKsYmRyWXcUKqp9s7TbavZ2bp8A5nRJfdERIAWhhzxu7I5sKKqtd3
 UZNQURtv1K0CWuu/E1VGiPjcN0hQQVyVoULIxQwYVxs3BQViewMdzL5ck
 DXgGfLMEXklUOHO8Bmz9M7PdGzAi85uLaZqZGe54SpTGFFE19Zw0yJSFu A==;
X-CSE-ConnectionGUID: x3GEaEpOSYmdsctguVQEfQ==
X-CSE-MsgGUID: n9lgRVnwQ/2PYbs0OhvkAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="79403434"
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; d="scan'208";a="79403434"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2025 04:32:21 -0700
X-CSE-ConnectionGUID: 3grrQAptQ+GSAFRoxZ8asA==
X-CSE-MsgGUID: hFWQTkWXQpKjV9aq4UBSwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; d="scan'208";a="154708006"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2025 04:32:22 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 4 Jul 2025 04:32:21 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 4 Jul 2025 04:32:21 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.57)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 4 Jul 2025 04:32:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O8AqXDUp/qrBQZbjPWSf94d38Oqse4Y9Buh37j0xWZ5u7GR38Ygd0cfUDJJW6SwMZQSNFvseFtXA8H/9G9y8OYZ4fbGBC5M+r+ZI/6Fi5QgjfvuQAAHw7ZJOFM1lx29mzRdq3DmEjNhW/ZUGFP0m6Ia8bpZc424MDi4tSil1hWkjYS5uFYnCQh37JE9x0Ff6a9/Bp3e96Z42yuuDAbjr1hC/oxCYvdVw59n0P71Ope07be00/HoMRp9D8ZOAJo6sOPWx9lSVTRPZD1V5bi+QlvU0o1+UhfVKEyaX4enUFOyVlhKXmGnXCBeWsHLtET4c1dQOfe/r8+c//27XhIvmnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y8VLDcRpLxkDuRkqgmQ91dpsThac5p+rGFyabEVWFZ0=;
 b=ctcpAIZFK8ZW+FJC2UZwXVfW4MNbyNQUdVRi2YmPPZH7mSpECXU25TeWYj4RwW5zVSQgPHwdUb9jkRoVapF3Ua7iM8UaWTz7Wb6uCW7RAE+Zxsa0+n1bixXSe8amaEGSe/I9YYB6IUdVw8yd99OSSmnTQ5gY3N1IChK+B3RrrDzQUSZdtElY4PjlwhNlXxu9qolAh6yqIqoZULbl9c9mNGtxorZXKl6GuccruM/w4mSAz9hE8lZpAkoofLU32DGki5aAqvN7cnjdPaY9dM+Oc3pgHqB0ectsSUZkiRfoVFbYb/5pBSwMGo+ukpWFTJv0LhldLal0kovEu4nLZ0KhoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ0PR11MB6792.namprd11.prod.outlook.com (2603:10b6:a03:485::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Fri, 4 Jul
 2025 11:32:18 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.8901.018; Fri, 4 Jul 2025
 11:32:18 +0000
Date: Fri, 4 Jul 2025 12:32:11 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: Dengdui Huang <huangdengdui@huawei.com>, <dev@dpdk.org>,
 <stephen@networkplumber.org>, <jasvinder.singh@intel.com>,
 <thomas@monjalon.net>, <aman.deep.singh@intel.com>, <lihuisong@huawei.com>,
 <fengchengwen@huawei.com>, <liuyonglong@huawei.com>
Subject: Re: [PATCH] net: support VLAN stacking packet type parsing
Message-ID: <aGe7uxORe1V817a2@bricha3-mobl1.ger.corp.intel.com>
References: <20250703093027.1259459-1-huangdengdui@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FD8D@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FD8D@smartserver.smartshare.dk>
X-ClientProxiedBy: DU2P250CA0020.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:231::25) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ0PR11MB6792:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b61364e-6d65-4525-c44f-08ddbaee6ec6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?kwif91scWKhixgalzG3jDRyQssecUXI4sRixMugEFXddhLc8zGXAQzUvHw?=
 =?iso-8859-1?Q?7hTon32mudJehIMX+CmqJF6EQuXC3PUpwqBbMykmPKg/f4GkVzCzkvwbEw?=
 =?iso-8859-1?Q?BKiG1p3jDjdfXg1z/RAnAeBTnu28E8UdBHNveCseMNdxjWS+a2NUNr+z2c?=
 =?iso-8859-1?Q?+dBJ+7FnMIao6QUhc6HW+IWsN300nq72kAkTtMVv3Gsd7xzuyaFs8QjJO4?=
 =?iso-8859-1?Q?ZWEizkSOcvBcF0q4y3E6n9+OFAJ4bpNBm5IXf4196ALGeQAcuMrBSf3wB8?=
 =?iso-8859-1?Q?8JuII8O8nW0wpsEuE6bYlLMgi3hJL5QbaRIdapEVuMcZFEFPHKhQD6uPsn?=
 =?iso-8859-1?Q?VrCIvduGvhVUa33dIrJNaCRuSm14n1vrRNEixHCsKGh0BYXbX5MarOlohY?=
 =?iso-8859-1?Q?3ZQfQwrE7b6hY02VfsXXZqNoGW4bMNGqhzdhaqWHt50vXkqFZiMrngxRIi?=
 =?iso-8859-1?Q?AXLVRJR6BF5BJv7HekL9kZ++zRbz3AHWg88FLUDI3EOqMUhOhasylkb2Jm?=
 =?iso-8859-1?Q?hLytgdEBKub8xXBKb/wJTfOm01w8CnwcC0Mu8KnNxJjaA0Ci/pQCWttEYP?=
 =?iso-8859-1?Q?IE//msVSRkYECe2fcWTrsbjxAsre12eCMX9yH1AGDDlYoaG8MgwSXORH7C?=
 =?iso-8859-1?Q?4/ZbADpiWcjOdEV84wa7xD7stZkNC0T1IdHuJObHQ1FFHmN9FyY+TK7YNh?=
 =?iso-8859-1?Q?p4vXMO42pqZUtxJ3BNIHWqkBG1eyOfOLwYH/Xx8T0IQuOIoDL55R07T90I?=
 =?iso-8859-1?Q?jl5OkFlCr8HqJfNv+sfeSx6+necG+QhG4xhC434V4whY0gxO9UvxAIEdMJ?=
 =?iso-8859-1?Q?+rqnWgVNZ+DolYaxxgW5BPhPwv0Uz8gzxC+9zSaOpLUWIRYEgmdmhS/IR9?=
 =?iso-8859-1?Q?LZUn13XZE1Igp3VyaRrfxnx7ok4lcguLbje9OUBLysV+9gg64IGD6Cayxp?=
 =?iso-8859-1?Q?vlThjrXnOLuXYc+gpHkzme89TnV2nJAb4eHRYxe6j5V+4VZLEiPjfjDKBu?=
 =?iso-8859-1?Q?dKOCKeqDUo7GyjhMIavUqmZp0H9rN8f8s9oOKvrVi2c+CO29iG3D12i3s5?=
 =?iso-8859-1?Q?lym3N+NQpQdnXnC9SkqarlgWFG+JrZcXEqQhu1d8YvAHadOI5HWFZ7ZTX3?=
 =?iso-8859-1?Q?1KZcIikAZL+udis+t19s0dGhi9oWAWp0gZb6zQyVpmiEU+UeBFw5X5ZcpQ?=
 =?iso-8859-1?Q?zZMaWHgqh5NAg112zbAuQdFJoRH47Kmve2w0K6cvTn3gl8ke8lQgs7NvgD?=
 =?iso-8859-1?Q?rGl2MugO0YpkfXCBfE7IOja2U1fsJHe3CxxbdIXzgjnVOCF6a9Wi049Zog?=
 =?iso-8859-1?Q?MVP6tTrrVG4TyiolXDp2AmneGTEKsxHxdtET+PJBe10F0sj1BmIK3jBz+T?=
 =?iso-8859-1?Q?LiF1y7wsLJo5Ym3+jq9fV6YNicO72lFxBTiOHxWMah05/NE/UTgO2Q5iOC?=
 =?iso-8859-1?Q?sl2EkEM1LkdVxAj5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?issRbm+y0+7sjWCN/H5HLYratm/u17oFyXNhjyDM1MhGTySsBP6uQQvH7u?=
 =?iso-8859-1?Q?MKIPA6fSh6kYCMM/EhJAkKnTSCV/sVXVKscCNL2VXpVf1oUq7thlzIumoS?=
 =?iso-8859-1?Q?dd/cddbY1A29LTHKop5niQcLrnJ93Yuaurg0IMODcpXv3w6R3sJtqq/A8F?=
 =?iso-8859-1?Q?lY3r0UNlvegZwmnd1smXmqIM/9hktLIud60NYnNCPSVLAzBVhIUymehUIS?=
 =?iso-8859-1?Q?UJIkU8t0S0H0008ssD47CcdpVWFUtNXcrcxM4ZJMKbxYjpbAh02PyDzugB?=
 =?iso-8859-1?Q?uvVe+QVXO17ySHL16c34bfdNMAk5uv4FfQxKNJ+5Ufvcu4snWoUAISTVEd?=
 =?iso-8859-1?Q?y8Xrf9nJRkEq6n9mMVe0jNRBqHeX0oDmcm/sGCGUejCaNtXdxgQVWNKP9Y?=
 =?iso-8859-1?Q?OQMeGRgOGRZ6B8GLAHhkieSk/PFdJFmTXlGiXRUNdfJD6vb8OetY/dF98E?=
 =?iso-8859-1?Q?68i+48hE2HT2yiVY14NKddtUslK/kvw+qXJWQUs6fATx8r7Ji3oPAnRiqQ?=
 =?iso-8859-1?Q?woxSnTdw/mvjESFvPRUcFcrhrefWmWE4nvHrRDW2WXGlXoeW6X6e7DOr5V?=
 =?iso-8859-1?Q?Mpg43arrj5eIYMTVz7NKiE9MyGcevYJLhq0pp+9ue2WnJn0QOtMpADsUYx?=
 =?iso-8859-1?Q?qEP/r/imN8R9qck7XiP2vMMeGST5h1+H2LHf36Cw4Q2zJ/u26lCff+nyJ8?=
 =?iso-8859-1?Q?gK/tTfzAt6Y36gN6NWWoTgx6r1GhJeLV+SeQwuCS/+cCo6CWgHGxqrUfiG?=
 =?iso-8859-1?Q?HKLvmOgfsxm97xZEWnI7afL/tjczSnN4Zf72hNBtMTZq/T+IbMNmxoqZlV?=
 =?iso-8859-1?Q?5u8mUzXDvMvsFkGyq2oNcerC0uWf4Pz5loY9nwBIAwUHu2qihMTEmhIcX+?=
 =?iso-8859-1?Q?GI5unVKHbdliN4RVGOMUxlfN/QNKwfehKJ1wv3unkP2OOpE+l7st3Dj5ab?=
 =?iso-8859-1?Q?IXzfCj71xiDxiuq07Lpots4NvgKabOrIqXRVLhSkz1espkBKBdnimrLqUd?=
 =?iso-8859-1?Q?VO14qHewhMfpp/Zq0wEAdHywBTyzIe18V4uzLB68wmHi/iMRTKZxi5yzBc?=
 =?iso-8859-1?Q?VgI4qTg928IU/TYHT31Jzycx4lj2jJBIhPdk/0JWwdNY2gYf+o0SkAcFe8?=
 =?iso-8859-1?Q?nr+x07VKw+bcxWjnW2AFVDeaEkZgi7B7PVCykCX4cbgwny5kAb6s0xlsCk?=
 =?iso-8859-1?Q?no2kvSP2ofO3Un1z5PrNheGqd8ejg6G0VJLJZ4J/1ZJibWRaK7xRTdxY+/?=
 =?iso-8859-1?Q?OCHVeiQR41hmacNfSA94M7BjIbXkEFIj5ryX8yda6QCmE2SBgbYBeHn0eN?=
 =?iso-8859-1?Q?qPhXGU9S6Mhm1VjdfGfPCoZF0MjfDaBxavvVzawCHICK4AeqacIM0HBUHJ?=
 =?iso-8859-1?Q?8h6IngQ/sJd2HAe0l79+rqo1agaIhPMOFmbzPOHPyZUqJnbszmpCCCHbZM?=
 =?iso-8859-1?Q?4tZhKYlWsKr8plApJ6EUfY8tEUfLubEc/dwNqRWdgjw4uGtnmVRqPRknXG?=
 =?iso-8859-1?Q?fdvVNcc75dO6LEWJL71r6m5trppXuyemAjtkBUCbaotzuEnhL4QJLaGtJH?=
 =?iso-8859-1?Q?oP4S9vohUv3M6UV6btZtC7/xa7lFeuwgYoC99CucVmR4F9VPXdIu/P25jx?=
 =?iso-8859-1?Q?8CdLCBSmuKJHhDWV3pxlTWcFRShx1+V6yQ/tPxR6dd4n0LQvsec7wWXw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b61364e-6d65-4525-c44f-08ddbaee6ec6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 11:32:18.2441 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A8hhRowYIPm16dwL/t23/agd39sqtHn+J3VRxhUtp0Ry8s9RV2p82c/06219i+vEggvuMKWqDRS3m15eWKunUaLHJSAu52GxE5AozalP+rM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6792
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

On Fri, Jul 04, 2025 at 12:18:45PM +0200, Morten Brørup wrote:
> > From: Dengdui Huang [mailto:huangdengdui@huawei.com]
> > Sent: Thursday, 3 July 2025 11.30
> > 
> > The current rte_net_get_ptype() only supports parsing packets with
> > one 0x8100 VLAN tag or two 0x88a8 VLAN tags. This patch extends it
> > to support parsing packets with two 0x8100 VLAN tags.
> > 
> > Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
> > ---
> >  lib/net/rte_net.c | 34 ++++++++++++++++++++++------------
> >  lib/net/rte_net.h |  2 ++
> >  2 files changed, 24 insertions(+), 12 deletions(-)
> > 
> > diff --git a/lib/net/rte_net.c b/lib/net/rte_net.c
> > index 44fb6c0f51..fa8d023ca7 100644
> > --- a/lib/net/rte_net.c
> > +++ b/lib/net/rte_net.c
> > @@ -352,14 +352,19 @@ uint32_t rte_net_get_ptype(const struct rte_mbuf
> > *m,
> >  	if (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN)) {
> >  		const struct rte_vlan_hdr *vh;
> >  		struct rte_vlan_hdr vh_copy;
> > +		uint8_t vlan_num = 1;
> > 
> >  		pkt_type = RTE_PTYPE_L2_ETHER_VLAN;
> > -		vh = rte_pktmbuf_read(m, off, sizeof(*vh), &vh_copy);
> > -		if (unlikely(vh == NULL))
> > -			return pkt_type;
> > -		off += sizeof(*vh);
> > -		hdr_lens->l2_len += sizeof(*vh);
> > -		proto = vh->eth_proto;
> > +		while (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN) &&
> > +		       vlan_num <= MAX_VLAN_STACKING_TAGS) {
> > +			vh = rte_pktmbuf_read(m, off, sizeof(*vh), &vh_copy);
> > +			if (unlikely(vh == NULL))
> > +				return pkt_type;
> > +			off += sizeof(*vh);
> > +			hdr_lens->l2_len += sizeof(*vh);
> > +			proto = vh->eth_proto;
> > +			vlan_num++;
> > +		}
> 
> It's not that simple.
> 
> VLAN tags are not like MPLS labels.
> With the MPLS packet type, we expect a stack of labels.
> But with VLAN tagged packets, we expect exactly one VLAN tag at each outer/inner layer of headers. (Or no VLAN tag at the inner layer.)
> 
> This function already supports packets with 2 VLAN tags:
> A stack of 2 VLAN tags is currently detected as 1 outer VLAN tag, adjusting hdr_lens->l2_len accordingly, and 1 inner VLAN tag, adjusting hdr_lens->inner_l2_len accordingly.
> This behavior should not be changed.
> 
> I don't have a firm idea about how to better represent packets with a stack of 3+ VLAN tags than what we do today, so suggestions are welcome.
> 
> Which use case is this patch addressing?
> Maybe information about the use case could guide us in some direction.
> 

Hi all,

this email discussion comes at a bit of a fortunate time for me, as I'm
currently looking at our vlan tag/qinq stripping behaviour in our Intel NIC
drivers, and there is some discussion internally as to what our driver
behaviour should be compared to what it has historically been. :-)

The documentation - both in the NIC guide [1] and the testpmd guide [2] -
is rather short on detail as to what exactly the behaviour should be when
vlan strip or qinq strip is implemented. Therefore, I'd hope that those
more familiar with networking than me would be able to help clarify things
so we can document the correct behaviour precisely - and hopefully test our
drivers against it in future!

The simple cases are obvious (looking only at stripping behaviour here):
* no vlan stripping - nothing done to packet
* no vlan tag in pkg - nothing to do, irrespective of offload
* Vlan strip enabled and single vlan tag present - HW should strip the tag and
  place it in descriptor for placing in mbuf.

Now the questions I have:
* To handle questions with 2 vlan tags, the QinQ case - do we need to
  enable both vlan-strip and QinQ strip, or does QinQ strip imply stripping
  both?
  - one suggested interpretation here, was that QinQ implies stripping the
    tag with id EtherType 0x88a8, and vlan stripping implies taking off the
    tag with 0x8100
  - another interpretation is vlan strip means just to take off one tag (if
    present), and qinq strip means to take off both tags (if present).

The question above leads to other consequences:
* if we enable qinq strip, but get a single-vlan tagged frame, what is the
  behaviour?
* if we get a qinq packet, but regular vlan strip is enabled, which tag, if
  any, is stripped?
* should it be an error to enable both qinq strip and vlan strip at the
  same time? Should it be an error to enable qinq strip without vlan strip?
* in the mbuf, we have a "vlan_tci" field, and an "vlan_tci_outer" field.
  For single vlan strip, presumably only the vlan_tci field should be used,
  and for qinq traffic stripped, it's obvious which field goes where.
  However, what if we have QinQ strip and we only receive a single vlan
  tag, where should that be put? Should it go in inner or outer?

Feedback welcome, and suggested doc updates welcome too.

Thanks,
/Bruce


[1] https://doc.dpdk.org/guides/nics/features.html#vlan-offload
[2] https://doc.dpdk.org/guides/testpmd_app_ug/run_app.html
