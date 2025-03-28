Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D99C28B20
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Mar 2025 15:26:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5CE254028B;
	Fri, 28 Mar 2025 16:26:54 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id AB84D4026C;
 Fri, 28 Mar 2025 16:26:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743175612; x=1774711612;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=58TGufO/X6KwWVfphEAbgYKlBkixU08ym92SXU4kNFo=;
 b=imJrxbONYS/h4RqhX9J9wPaimBeZxZ1LLlo2Ai04EzVrTbkRFf7ucfNd
 jEKldhCTVmjyf9jnN4BmtWwPT3smti78mv2A0g0essqdWoI3cQXgyDAGX
 yJldRF7lGilqWefmm10EB2ykXxYZq1q5J4DNa95YEHFNNq39NIwB0VYlS
 19lbRSFDk1DL1LrwtAHfvyPtofIWUa/gXy5uZhkuHCEuoqxMqgd8YYltf
 CuAESUcp87NiU78ub0ld8vKpmOGvKKkUWUY6VkT3nS+GPCOA9MNbH2cE+
 tOj78DrR8eSeUJWD9P7phdn3btC/q4dKbXce0KjCJxqnNSRBO/Nyf5t6s Q==;
X-CSE-ConnectionGUID: 86IT5VryTpuzHyECEwdnRQ==
X-CSE-MsgGUID: NRr/RN+xSUWobaMAaE564w==
X-IronPort-AV: E=McAfee;i="6700,10204,11387"; a="48197998"
X-IronPort-AV: E=Sophos;i="6.14,283,1736841600"; d="scan'208";a="48197998"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Mar 2025 08:26:49 -0700
X-CSE-ConnectionGUID: RdgVtyGYSHq4g4p4T61SQQ==
X-CSE-MsgGUID: 5HxtfdxxRDK2S0mjkYBq1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,283,1736841600"; d="scan'208";a="156406671"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Mar 2025 08:26:47 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 28 Mar 2025 08:26:46 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 28 Mar 2025 08:26:46 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 28 Mar 2025 08:26:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YoxrFRlVNu/erzGVdY+YV/ieXR7L6OjKjOzXVXwyIaoKVR2xDHX2tqkVLVoJov72aiSDi2mNGlBbRTsQdallQq6tLryqumoo0sKuYLn6bJ63vDOSVHnB7S1Urg7AdYtn9KEf+CLYPEZOc36Q7DzPHaJrCA/WuHOikO/tDdzrl/CbV7l5yiY8fzqgJuWnuzA430U15ovOBTT3mjAYu1SWZRzDaiI4EmcyZAAKaDtkXxQq6VbAKdzZhcFJULurCH/9ozYuN9ghvz/SwQZpb+vqvmBSUGUnxGTdE7XIQDSI85CouBWFsw6b2NCzyYgj29gHnfb3dSYJ17swmajewL9EKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/UpXGTEnO9KfY3UEMWlFkzAcR+06oM3fAXgAm+XkAHo=;
 b=fWL2Uu80QGlwEmhuOHwzBgqJAH8jPYnPliQoGVu4az69ue6umTkEZYkskNHz4XVFBfVNRoe/sZtGH3EKuUtO8ZPUdGP/oxQ0O06BtQZrHa4V0xPZuv9szJHmNg1OQyBujsiumDqNDt2PDx2XSo3NBHIAYtDN1dn33DW+hcJ5vUKNstGwWJ2UCU2a515TgXFnec5kgc1SRmpxqDmutlHlUQqNxGLnE5c0n2Am5uzfyK0FWVWniuss8HBI/HSzG7gfVNtdIYfsonTxSukbh3Y0wmZxO0a/vVMnD8g7LaD76UVcqh4PZ1t1jEOGYEOIsmLx5dOdve08/AzmRFQ1L1WsVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DM4PR11MB5994.namprd11.prod.outlook.com (2603:10b6:8:5d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.47; Fri, 28 Mar
 2025 15:26:43 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 15:26:43 +0000
Date: Fri, 28 Mar 2025 15:26:38 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: "Burakov, Anatoly" <anatoly.burakov@intel.com>, <dev@dpdk.org>, "David
 Marchand" <david.marchand@redhat.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>, <stable@dpdk.org>
Subject: Re: [PATCH v4 6/9] net/i40e/base: fix unused value warnings
Message-ID: <Z-a_rvKvuzg5JxJY@bricha3-mobl1.ger.corp.intel.com>
References: <20250326155230.1315056-1-bruce.richardson@intel.com>
 <20250328111621.2665257-1-bruce.richardson@intel.com>
 <20250328111621.2665257-7-bruce.richardson@intel.com>
 <8b72d751-84cc-4ee2-9a81-5c4ba6408b02@intel.com>
 <20250328152144.GA4330@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250328152144.GA4330@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
X-ClientProxiedBy: DU7P190CA0020.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:10:550::34) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DM4PR11MB5994:EE_
X-MS-Office365-Filtering-Correlation-Id: 41d74200-3f00-4402-8ccf-08dd6e0cf180
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?glU97T9TPoLxxFtImjxcg1IzznVy8cQyKiilamIZ9BfZh4DibIvJW7dRAw/W?=
 =?us-ascii?Q?TgOKpuNGCAcOWMYMqo3e3YnYnxIbRD0H9XD+fIKC11ff1fDtOWcTpxHxlQdv?=
 =?us-ascii?Q?+zmXaN1GWmPLyMablIpV33+iPftQfczbHNHiphH5Z55Z1EUll4fzKuVDACmd?=
 =?us-ascii?Q?hjSw9s7Dwevh79MvZ12Tfj1DL+I1PuXoeTr7l54JVPwHej4VLwUfpUOCdWqN?=
 =?us-ascii?Q?DSvdAHIlcNE2FgDhlRoxPG/OND5gr39I8NQ0pe4cGWzLLY6NVSGGHoVt5pG7?=
 =?us-ascii?Q?+CDBMS2dyQRfIWlF5KzlCF7twu7a4sE89GWIuLbDrWVyIM4gBg+aHE1uXhAh?=
 =?us-ascii?Q?jgqLuTqG73hwiNpltL38EpGXjGRjGnEZrUrBSQRVtlkLVZ9obqXDlo5ldRVg?=
 =?us-ascii?Q?vmyHYyoXZ2LDJSZrkjGLOJYKfA9ZH0fWlAUJJqCFFQd3QpxUOl0yNF7T1/mh?=
 =?us-ascii?Q?njPC4roPCBgwGy+cOOimXIi3iMl6SrNuO52H8iUfvYWgVhj1lPFumyBq1nXh?=
 =?us-ascii?Q?uU5FuK4DPEKI/8hinGzUVQnNMkCHI5MRd68FbY5Z6I1/7eVQ5q72aB0rMwnB?=
 =?us-ascii?Q?2GGDZR0Aw43IjofA82da058srST03UBxSXXFWesFUD5QEE9/ikpCuUPSvyCj?=
 =?us-ascii?Q?U9OxLWhl72RWCkXotoYiQRUtofPJdONqtNskAAw8TtESRt9/1VQFpMi/eQ4p?=
 =?us-ascii?Q?Gb0dPzjcCfmnYwRj8t8bnJh1n10EXUSy0aAf92KrPc7typqevAs4lBi3T9FC?=
 =?us-ascii?Q?hRTVM+cRSGvnkKrs/4comAvf29W9NzGc/IzjM6OcXr1iR/6tql+bnse8DR1m?=
 =?us-ascii?Q?pUDimsSXbrocGh/D4v61uCSip+kdsJIguID5YePpzIja5EQIPeFTVsIdwGu/?=
 =?us-ascii?Q?q0LbD/ugT2Ow7/TbjBJ3QNeudzcHCJGS2yBlVUlztY/Or3ZuzwNamH4lr7zj?=
 =?us-ascii?Q?+ryOZicAK35cJfnpoqnbullT40+w9B2pkrLiC/UcUglH3X+xiCly5LJO62/O?=
 =?us-ascii?Q?373InHS3MPOFLvfh+1+ypmJFMaRpHV6fAzmuGZFkDA+6v/5IoPmwMWbxVLbp?=
 =?us-ascii?Q?o/sulRNUMEsQ8MEneCSUqMassBQ9U1CWQ09vKDc5VNVOTMam6jMYl4T0/2f/?=
 =?us-ascii?Q?j+tmOpXNcy29Gl692YWoLrtDyRr8kDQGhKQBfmuIbZ2z/zfEjpm6m2CRPhYE?=
 =?us-ascii?Q?0f5Tf1GgrRxNbfbduAAGcGJGR26uHOLYwdmxqiOMDDNoaeWzgX+me4HbTB1D?=
 =?us-ascii?Q?SbJoYTkvgc9xt6Vsu55YhslzaDUqH4FXnf0Er/yXWCuNEa0Gjng1Q4rzjh8k?=
 =?us-ascii?Q?cfjJd8NpAwo6g3OHC2nGjtldW9HyAjAY7yESBgB12Lxqk/qy0vh/PygzxOTI?=
 =?us-ascii?Q?E2MrUmhCLA6+62rEb6ZQaOojprMP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gZHhvUl7Dh4uxmivQQdj6vP/8fDSdMSXA94yain65V6EFtWN/7pJi/kXGU6p?=
 =?us-ascii?Q?8/HUn0rHu/ENQdotc5+cRtBJp/R2WcMPLdFtwr77RqxZEg3XjRkP9V4pHsgn?=
 =?us-ascii?Q?12G0kC6uJ/PNt6LF6AdyD/ncjqyCt/icwgrvmNhaiBWsx7EwXNMVE4shbxh4?=
 =?us-ascii?Q?3WB21i5YUMrBdvnQYCI+zevGjygh9k4bqH1DaTteedHdqgVPz6sgTVnOgMHb?=
 =?us-ascii?Q?/yVeHuS5vXyNrAd+1/zgF2TsqG5enx2QZnARTswMrxeF1xigaCbZp4nN1u55?=
 =?us-ascii?Q?xNo2ohfWr5Syp+TH3aj450GcS46cQzC+kRuX8P4E2A7r19YGIPnmLu9YU8Ha?=
 =?us-ascii?Q?/Fm5lXxwD440l4PJzaSrkbMUa/HODCIfNnlF7M/u9uT/3XBes23gt0QJI0WW?=
 =?us-ascii?Q?Ztcr4aTFkELXxBnvuQg+tAnqj8F1CMcZCsePeMZ+mpgx8MbB6KHGPoDmkgV6?=
 =?us-ascii?Q?/8ypw6kAQD+V4oISDfaXXC29H0L/39k65Kv6CpP9OQYxK2ajGHfhPHK0gyEF?=
 =?us-ascii?Q?LYnc0mkdy1nNxPvYsWuQP5M/NHrwiq9lYA7UjHNm7Z02ZG8OoPL19FNFdTHn?=
 =?us-ascii?Q?j6QeOcLrN028rWeO17asskIgufveEJ9fjTBAgiFEGnxuBlI8WB3hvK+hmF5D?=
 =?us-ascii?Q?WjvCGyx3xpQhbvQ1uiXMGfUavlptUtvEW0ejUeEI07ktFBViilQ8z1GuHryr?=
 =?us-ascii?Q?7tUyd3Aa/wsAJK7VYGJOAnBjVIQeSGK2y9SujawlZcws8bcjGwYZiBHjQsQL?=
 =?us-ascii?Q?sdY21/9ricH0qQgI6xCTbczk+vzvJt3JjFt+s2ACnx+4Mo+unL843WWgw0d8?=
 =?us-ascii?Q?FeeMpFVPD1fleZnQbu6hGyrJHTU52SDUNFweQBS2b47bXtFq5anYCq8BuXSL?=
 =?us-ascii?Q?QgvKPTuEkSf0TDz0gUcQgWDY2Lz79rRVItnehPLVr58aV1wsH9cSJ5x5t/NH?=
 =?us-ascii?Q?kKnxGSM+IjXfAR8X+A/62vlzO0cb+WW/00QqGV6112LOzlaQHG/kPvPQGlAp?=
 =?us-ascii?Q?41bVMeH4fA+0Zj39rAtaFB5IvmwcnBTudGLlbFakz3ipDyt81RFFGlT4Kly+?=
 =?us-ascii?Q?jAF8n1uMI/xxDmcoQOlJA3nSRlpPavL7NtpWN1yG4/9HG065X5eV1+0WpAvW?=
 =?us-ascii?Q?s4F/pcGGhDmibWFHU51iZQjQun63EpVKlEIm1ijmeOaX+oG0thwp5lD7eB8+?=
 =?us-ascii?Q?l/gX1zPyjTjad1B1yiqJh5+OXAZTSfljU8iaEMf2YR2ATmWH2ARwUw9JbJ7m?=
 =?us-ascii?Q?OGu3h/LH4heGe+3G9LeokQpWKZKk5id4JC5vnznq/NawmiUCBB9bNfy8DU/o?=
 =?us-ascii?Q?4rv8L1ewPGis7yGxHgjIGOBsOW3MBuT1wAp8pWQ2yPxMhvFkpb1DABRBS/RA?=
 =?us-ascii?Q?x1dXm3jcTdD4LERcLcOJQpcujsJq1Jd0VWLCOdKNzwcFqpNJhHvke8W8ORys?=
 =?us-ascii?Q?5S//61BUh66UzOGUbJwB6W58207aCuph+3f9aZfDcV/aIkLMgzwDWFJBzO3g?=
 =?us-ascii?Q?TEtCbRXGFVUJgJc2t67mv/ckpX6CGYf7iZ6JI2hwpJMfN6nNdyPn0C+adOPf?=
 =?us-ascii?Q?Y8VgDSMxST+YsI6PnrmMUudZN8CLnDyguMxAaxQRLMOVFtaF3WYmrwELX1iV?=
 =?us-ascii?Q?kQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 41d74200-3f00-4402-8ccf-08dd6e0cf180
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 15:26:42.9359 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RTgZE8IRTd2ap25oVUrcjwsuj0qGpF++I2kpdxTAPnJbElS07vv8TahFwaouy7brh0AeZTXUYPp5OoTwIq2VgHGQZ+5aZi+a2gY7b9Hl4Do=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5994
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

On Fri, Mar 28, 2025 at 08:21:44AM -0700, Andre Muezerie wrote:
> On Fri, Mar 28, 2025 at 02:07:23PM +0100, Burakov, Anatoly wrote:
> > On 3/28/2025 12:16 PM, Bruce Richardson wrote:
> > >Fix warnings about unused values - parameters, variables, etc., and
> > >remove the warning disable flags for them. Although modifying the
> > >base-code files is not ideal, the changes required are minor, and only
> > >affect two files from the imported base code.
> > >
> > >Fixes: 8db9e2a1b232 ("i40e: base driver")
> > >Cc: stable@dpdk.org
> > >
> > >Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > >---
> > >  drivers/net/intel/i40e/base/i40e_nvm.c   |  2 +-
> > >  drivers/net/intel/i40e/base/i40e_osdep.h |  4 ++--
> > >  drivers/net/intel/i40e/base/i40e_type.h  | 14 +++++++++-----
> > >  drivers/net/intel/i40e/base/meson.build  |  3 ---
> > >  drivers/net/intel/i40e/i40e_ethdev.c     |  1 +
> > >  5 files changed, 13 insertions(+), 11 deletions(-)
> > >
> > >diff --git a/drivers/net/intel/i40e/base/i40e_nvm.c b/drivers/net/intel/i40e/base/i40e_nvm.c
> > >index 3e16a0d997..56dc4d9279 100644
> > >--- a/drivers/net/intel/i40e/base/i40e_nvm.c
> > >+++ b/drivers/net/intel/i40e/base/i40e_nvm.c
> > >@@ -1743,7 +1743,7 @@ STATIC enum i40e_status_code i40e_nvmupd_get_aq_result(struct i40e_hw *hw,
> > >   **/
> > >  STATIC enum i40e_status_code i40e_nvmupd_get_aq_event(struct i40e_hw *hw,
> > >  						    struct i40e_nvm_access *cmd,
> > >-						    u8 *bytes, int *perrno)
> > >+						    u8 *bytes, __rte_unused int *perrno)
> > 
> > I don't think we should be adding __rte_unused to base code, there's
> > probably a macro for it in osdep? If not, maybe add
> > UNREFERENCED_1PARAMETER in code?
> 
> +1 to this. MSVC does not have a direct equivalent to __attribute__((__unused__))
> so it makes sense to not expand usage of __rte_unused.
> 

Ok. Will change on apply, rather that doing a respin for that one small
change.

/Bruce

