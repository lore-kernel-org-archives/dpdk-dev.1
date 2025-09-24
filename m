Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CB8CAC5AE
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 13:57:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C11BA40667;
	Wed, 24 Sep 2025 15:57:20 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id ABE4040611;
 Wed, 24 Sep 2025 15:57:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758722239; x=1790258239;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=xhl7houijMLSk5WleeH+jdIqaVyw/LPl20kIEdt+cpU=;
 b=VouVanrDa0UwoBMpgyvh0RUDi+KgwTuqFRdtP22YtcmBUru7LSmm1sq3
 C/7BDqUS8NVRXa/m5luTpFS6K7t8iXXgdf+z96F+5hC4dyxRBsmRUzQbw
 boeF1bu/kgyNxoa5pmg67e8SxR/sY52CYIrTUnPWYdo+33IHFVpcTmgNU
 ekDSM/hsj13xSEsr2Z8iKcJ5bXJatACvkpRlYsWHj0OXuMzbis4VY0Ht4
 ddRIfcXJJjZuDwEnr2aqGDH4+uev5MW9m/qTgQ6v47JRWlgrFm+sGUAp3
 UkWR3u6kQT6HCv5tIvY44ZhubsWVO+D0G15OFGCeuoR0h0AHsPeeWKvi8 w==;
X-CSE-ConnectionGUID: anVwBqr7TBWe8L4oBChAtg==
X-CSE-MsgGUID: uVzpTG1USjq6DCym7Zi7BA==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="48585133"
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; d="scan'208";a="48585133"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2025 06:57:18 -0700
X-CSE-ConnectionGUID: Dc8eINFwSe+f1azxWT6qcA==
X-CSE-MsgGUID: GTnwk/ojTlysbEALPISZ+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; d="scan'208";a="177436589"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2025 06:57:18 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 24 Sep 2025 06:57:17 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 24 Sep 2025 06:57:17 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.59) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 24 Sep 2025 06:57:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PaViR0Fq6ZSCTslFPAG0DarxgzKmdb7tWiujTfiYPxXB2L+sE7Y5zx2odBr14UpSEZ4ihtMQjqfqiBzys4LJJdZ8VUDFQo2abR64YDwlLDOOCNAXT7AKowrpZUwsj209NxAp5zNbkSl2XDszoGirm4I6ZyzsDIkvJzx+1ALPxyz7smzEt8+YBiUV+LRwpcFIwb62MK0MyyLagWCIT1j1VS84be7l3yRrXZMIsdOMtruc9GhrcF1TUAJcTLcwXKXtoZ1f9TAIc+ydD+F2MFfOVRNMI06rD+pLDs9mtPXrvq/bcCl74Ege5s9sujte+eeveH1Rb9sGNLOs0iLQzG0UuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G+UhIEeuewcrRa5iVOFTHmzneGgNWt5CQAa8CC6LpAg=;
 b=KqZIvyf+eIzGHgV7fyWSZpi4TKlH8x6sfwkeOX8ubPdZAHxZMG5jMJdcq4WsX1vgiqF0V3gBhV/m65IuRzVwF7Q4zNlzRzhslU8T7rMm0ajKPo0PWwY9zzz/5WP4m0IxZpqHpwNNd2+jTXT7pk/Xpb+bxbmIrPKNykWjOVXMOEQGkGFGZ6X9f6/kMWAPictB3dOj5RGYaCcQU/w+SYdIX0/RDYXgGCle2BTZ00HUjTyVuM3ttaH0IE5o2a+0YBzLSFaVkaP7/FQXD1Ixjs4L9TWsBVuuJam0n4KNnd4fH48wui2W/z/tJqV8qyz+MJzgsHyMECOvPTXd7uj6MHhguw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CY8PR11MB7244.namprd11.prod.outlook.com (2603:10b6:930:97::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Wed, 24 Sep
 2025 13:57:08 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 13:57:08 +0000
Date: Wed, 24 Sep 2025 14:57:04 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Ciara Loftus <ciara.loftus@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH 6/8] net/iavf: document support for burst mode info
Message-ID: <aNP4sM81HWs0P6j2@bricha3-mobl1.ger.corp.intel.com>
References: <20250916142113.3485738-1-ciara.loftus@intel.com>
 <20250916142113.3485738-7-ciara.loftus@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250916142113.3485738-7-ciara.loftus@intel.com>
X-ClientProxiedBy: DU7P190CA0018.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:10:550::21) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CY8PR11MB7244:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a0effd1-6ac5-4e8a-4d91-08ddfb72406a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?saE+EopFkVvDhyarms9WXD7b9Rv+lDTv93JLCuSLvf/qGqivYoQLdXSkw0yM?=
 =?us-ascii?Q?o/ip2wdKlSlujl4U42iOnktltzAI3zR6DwpOAE8AfXD+/6lHpj0IoC6ADOwD?=
 =?us-ascii?Q?2FJ/KpvKNeGI4+g/CSOqVl73coIELlgsFCxw+HStwCWpc0Klcm6Iolb7p/X7?=
 =?us-ascii?Q?syDVriUiI+lckEzz+qRiK1BmD3sl6G522dyTiUsDLda3BSytumXWpN2SDq0a?=
 =?us-ascii?Q?R84aOOzG4+BkToC6gKzc26FBYwRI4z7td9a5c95D2oAHnrw6Hd4VApWQSjWH?=
 =?us-ascii?Q?0/PhCQpKENvwsdw5tq0gT1HrqPtNpMESsoKezECAHf42ipGBjwC2iCeYosW1?=
 =?us-ascii?Q?ldFW7OqKYHNth7+DitfAJryfJzh8oGXTTN8RE9xclkQnNqggnfa5Xe9JnNUx?=
 =?us-ascii?Q?eTyW/CT1DA1SHULIJYHe6Et58oSRm5WgGX3OEpXFR6kjhLBFhtmS68qyPes8?=
 =?us-ascii?Q?Je3bFwY8e+FQi009RauIh0mS3ctl6tnKMtR2CVZD1mdEaiCRig3xu/YVG7Xf?=
 =?us-ascii?Q?h4BpqR2USGTQD6IOK+NnSkGGYPNJsaY+ABCPhh9sW/6dr8nfREvp+pAWrROv?=
 =?us-ascii?Q?tdbrSNRdUdt4wtVVshXnwaPRETmVMsxkVDNTpiLv1KudUPyQ6TchMAdxrbE3?=
 =?us-ascii?Q?9rH3gZN4OS8gMBYI3AEmP6tdNKOEcScg993O4LQSyNmnk1kp8cI44aEepeUl?=
 =?us-ascii?Q?1Ag0WKo/dyhSL5qzQ1LDNDCnRbGMgF65+TerINXgAHP41NAYo4DIBmCTqj4V?=
 =?us-ascii?Q?7aRdfW81Fy5eU/Eqo4F/DnaQMaJIDAQS07CSxcp2dwn9n2csUN0XuLrGUHA2?=
 =?us-ascii?Q?2YVjd37XrJSIJzhoI2T+5nMyID6aqN/9py+6IqSIGQVpgzSv/wFyWsD20e05?=
 =?us-ascii?Q?7TcMDdkXjjIAL3sZ7t08A3ufoHyzbAJzSvXshzXm4FUd6WgJRsp/ImHPQCpl?=
 =?us-ascii?Q?bUBQR3J0IdxhliHCn5QGTiWb1aiqv1h4q2gOfe8QlWi/lhLsNsVtX8PyKoiz?=
 =?us-ascii?Q?MBIbKuUydKanPcmpuADm2WietANJLWUiMc2/+gcBWhraXA5trOKiTcNTra2a?=
 =?us-ascii?Q?yssTyKwuAjGxVBV7ouKxIhOPlmzmOasfYlkBNpOQJVRBx1U9N8cwY+HzWvzW?=
 =?us-ascii?Q?9IPsbzoDG+kRxDUpb7f4xaAxFNNGqq/7GV/COyqhe2x8SkrYoIdlfeDSBTTt?=
 =?us-ascii?Q?Ew8HaLNJ9n6XZCM3VBGy0oCkqkL1HiOSJ98MPtiLRV4niKfmaumUcXD4/dfQ?=
 =?us-ascii?Q?+JMWitzQCtGXUq+bPW6yIMcpYkQgYFoIJ8IqNURs+3rlhfH4in+0AKp95NDU?=
 =?us-ascii?Q?rxW6NCVbqOUR8Gs6+em5jSqojxRLsBsthLUUkda1DsJrwkj+fFO0Bj/H5NB4?=
 =?us-ascii?Q?yfAiRzMCBwScIpv9EdWUCs88Wn1D3/RWHNNqVNTHWwZj9KVLlMZJlS4R5SE9?=
 =?us-ascii?Q?3vbIPxml2Os=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2fjDB+auIlaaZDSGMMiqgzhGX6zKwa7v0pFjbuGRlDmMJAC2luSDpm9azI6k?=
 =?us-ascii?Q?gWlgTG3nx7+4qDmwdT98g+IsrlWsaQJBWi5jaFHv+DXMxZXH1+FacK+ZGJHH?=
 =?us-ascii?Q?9zytS9DhfHRzqpU0cXYQRYS2+YttU+hLwQ9i4xbYgd4RHSQ9J1VY5aqL1y3u?=
 =?us-ascii?Q?U8YeLPMOYgzgE+91fb7zF9fC5Lz3n4koPDDwQvtKbCtZrEeTwZPNPow6p91G?=
 =?us-ascii?Q?NYexloSl4B8P7qqnyV5PVKjoWcb0SPR3CF1/SeQPSClKqLYnL1r+aSHEYxdq?=
 =?us-ascii?Q?U3GPT0yn5L/6RO3l/QOvcDlGF4V6PnXuU2K790jG5t0ESmz7V4PtsRVBecnA?=
 =?us-ascii?Q?fwKYLU+f2toh8JQqTLLfpn8L1YoyQ+V1NXsTTa1Trajni33WdQtVuw1Z/brp?=
 =?us-ascii?Q?QfGwEJAo2RxwJbwH4gx51LkaUz74rD2bzd8ratfaYfwTZDdEB39u3SJ52Vmn?=
 =?us-ascii?Q?/AdqQhJEw0icPzePuju8OJv8PykK7wdBtqkoy6m1CZSG6XhmkHuARboNMhvz?=
 =?us-ascii?Q?RUFey+ZMbj19hxB1pHJFGRYQSctqgu/YqIONpBJgi/LF++z27h1rIDYsOvPv?=
 =?us-ascii?Q?NU2LJjcctGAta6Nu4gSe+WRR6MTiryy3xgikjS4tJI10t1xFiXnUyTonRmYo?=
 =?us-ascii?Q?9dZ7RYl6gl6qM2Lz3fd1qOjpbGKmxYvaEw6ZTdg8TzgSrWlkRCeCalyGoFh6?=
 =?us-ascii?Q?oXWzTxcPGuaLeShJ5L/cU/+fgaJ8MJfdib1aUpxQ/SIckf6OW+Yg6w7DAd3/?=
 =?us-ascii?Q?EMAklPwLT4nR202UwdaimN/t2lve6weJcPoJw774GXhXOxlbPLawexDNVHhU?=
 =?us-ascii?Q?QqAfTCyvdxbqap0rhaWJO1zM+YXWWz7A201Cn41kegeRuxB6CtCnIr/Byx+e?=
 =?us-ascii?Q?xajsLbX4WmlWb9BeQDIGsCDhKbvfWEWvJcdAUKTb5oQ/g9lu76ghLmcrbm2P?=
 =?us-ascii?Q?qbLAAlwWe/0tJpDB2cjb4wQdPl+p5B1aGrkXPiYstaBYwWOgeVgevFloc4H9?=
 =?us-ascii?Q?q3Jl6xXkU+Q/vjaU4ngpEaMgH36Mg959oEyM6EIIBNaW+PTRKaEIAYR+8sNm?=
 =?us-ascii?Q?/CKldfyjFUOFdqh/WBf74kJN/phFBsm+jJ9WUDIMD/j0G3Mga/8wqihaG6Q6?=
 =?us-ascii?Q?MCuDjS5XRcbf+hQn3oxdIowvJZR4+6aNGSbbWg9zVdYs03+HztNlDziTB9jn?=
 =?us-ascii?Q?QPB0yksxy6AxkKQ1NqsWprUBgxBeBx2hlGqa2FYiayWpYkCvl+hqJBvyfvHJ?=
 =?us-ascii?Q?b1yHW3eI9xkSlQrIBsPOatMb+2agpJI7Ek1FQ0sMqK0J3eOhcY1+vtiNMibL?=
 =?us-ascii?Q?M346GUarfQuYHjXB5I3Z8xTqvSwS8ybwVQgqO1EPnrttwh+4k+VLpCuqxDAZ?=
 =?us-ascii?Q?g8zCOclcjYcUXAN8RrKXg+OiC1w664HrC+JWVKUVYe6LPJMA4+YEVlAZ3EdL?=
 =?us-ascii?Q?z6XuNwcjfb+R2yer5L+WcFI9txnXT1BIHiLHPI9rVh5eu9NFboIneA7YUcUW?=
 =?us-ascii?Q?jrRaHyJCTzh8N4kdXikxbmJXcaqxYcT56phLrppkeLRxhs2D4TAdXxQ8dmEU?=
 =?us-ascii?Q?O+g3kfh69qlQyOGe/x2eM2iLYuCWYQFxj3EwgrHI3oY6mlnQihnNksHDfyNW?=
 =?us-ascii?Q?pw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a0effd1-6ac5-4e8a-4d91-08ddfb72406a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 13:57:08.3502 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f1M8CTOi8bSU2+JAq4oWHSeG+m5iN7dn9AWnJkNBGbvLi2dZ4r2wKw0dbWZRK7lyxSZOKigF0orhJAx9PWmdydkr2aS9XWLcZ3BvJJXi3do=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7244
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

On Tue, Sep 16, 2025 at 02:21:11PM +0000, Ciara Loftus wrote:
> The burst mode info feature has been supported since commit 0d5a856f5be9
> ("net/iavf: support Rx/Tx burst mode info"). Update the list of
> supported features to reflect this.
> 
> Fixes: 0d5a856f5be9 ("net/iavf: support Rx/Tx burst mode info")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>  doc/guides/nics/features/iavf.ini | 1 +
>  1 file changed, 1 insertion(+)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
