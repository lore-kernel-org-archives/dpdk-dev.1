Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD16C88E6F
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 17:02:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 37B2D40A7F;
	Mon, 14 Sep 2026 19:02:50 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id F01F940A75
 for <dev@dpdk.org>; Mon, 14 Sep 2026 19:02:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789405369; x=1820941369;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=mgaN79bq1wKpxk57yTnNtth4bkl06219/Cd6XVReG7c=;
 b=i9LvkBY4NeHYe0C31DjCrN9OyDLymsSVNW37h+oiR0qRuke8h2lUaZvg
 e5MFgU3iTZOCOOXOUMI1YUYWjLL+MMWrOb+EIKGJrVJO6ONgiTGXuHZGZ
 ghjCAco1h/33mdxH2Zx3aTZKctfWbJb8+yEuy8QZ8lLN58q/taY3aWy8p
 bn6VuBzVaoqyIvSydUPEh6uWUfNKR+cS2T+7aVy3gpkMiMBEcURgDBDat
 yGrAZRj1azM+hHF7vbT/7GMCc/9cDxXFMHJQTVbcj1VZUZOH3uLZL0e7I
 DEguf52y15dsVLld0q2iJIrDjhtCLcEGw4z3yZPrllzi+TlwaB/rbgA7w g==;
X-CSE-ConnectionGUID: ULGOxG6hQcKAg+hah9VAGA==
X-CSE-MsgGUID: 1j1o3PlkT/KDi5xcODU8sw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="101110909"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="101110909"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 10:02:48 -0700
X-CSE-ConnectionGUID: EGPO1e7tRZemNFEk/5WH4A==
X-CSE-MsgGUID: PJEKjIpGRueKv4bp8rXr0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="272189197"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 10:02:48 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 10:02:47 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 14 Sep 2026 10:02:47 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.32) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 10:02:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=koaUSe9Zi9cpj/QI7FxMZxEYN2eBXYG8JO4BBl/QyxcK7xgKzc6rta4zR3rhaRzpJGyE4t4LlgCmjV3Qc17BG0DdvA2YmYeaDQ7Ik1YvsMQTMWdEDFxXWGK0VXIYOaZTnpK00uVgGKMnHqow85j5YsOSyX5tUWrk/XexeBIr58wmzohidW9V7+htu+7vno1hXNU+IemH8bPu8S2GRwsnM1EKtWog94J7xHVPXLMb03x3AXYsKJqpsG5LNcJ+W0Nz35bh4w05DCUYks/M0ROivmgxnloWkcrB/wxcr/abBTFcRyH5X5ZgU/qEIjbpvKUMwlWBG3QDtlQdmd92MMZgAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fjlig0ZSph866/1oCVOKiX5CX4FxMEchravk7eD2/5E=;
 b=maPRRJJfxApMM8ClQ8t6xw8MOeRjNGAS2wd41JlLo1cIUhRqtDfPrkobpfRdoFq3z0YHUrKLFomQN8x6xdhhaxsoeOTL4Uhl8nX5Kn2c8j4O+Rdt1sg/FeI5xTeabBEzJJsrPHVt6G4Lcd+7hxDsrCw+Qt0VN5tLmcoVXHoV4KcHup2kuppeJ8z3hzj012AURWr+Q8PBiFS7Ohg90wCHnrAIlB19Qfazz8S2BBKk8hKPzclP09ia87Ps+uuwhUNZyHGN0V0/ICYPne3QRZPjtPd8A/odOoBQXYGYrUd9122nNW/Zx+21LSqlkBdch2ZCopAeJQqPVXk+KRG6owmQMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by MW6PR11MB8440.namprd11.prod.outlook.com (2603:10b6:303:242::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 17:02:37 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 17:02:37 +0000
Date: Mon, 14 Sep 2026 18:02:32 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Loftus, Ciara" <ciara.loftus@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Burakov, Anatoly"
 <anatoly.burakov@intel.com>
Subject: Re: [PATCH 08/13] net/ice: use common descriptor creation functions
Message-ID: <aqgoqHouylf6Y7nJ@bricha3-mobl1.ger.corp.intel.com>
References: <20260903170140.360477-1-bruce.richardson@intel.com>
 <20260903170140.360477-9-bruce.richardson@intel.com>
 <IA4PR11MB927882EEB505228A110F5F298EBB2@IA4PR11MB9278.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <IA4PR11MB927882EEB505228A110F5F298EBB2@IA4PR11MB9278.namprd11.prod.outlook.com>
X-ClientProxiedBy: DB8PR06CA0060.eurprd06.prod.outlook.com
 (2603:10a6:10:120::34) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|MW6PR11MB8440:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d5634f8-cd9c-416a-6cfe-08df1281fa41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|22082099003|18002099003|56012099006|11063799006|4143699003|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: GK/Ov1LP2zBzDoXAgdc3aN84syW12vDwKY5T+J4g6DMmIOZ+f6yqObvSkB78JywZm7/89yxTx5WXmmr7FOCihEcxKvKePON4gy6xVxtL/pyGNIVAaa7aK+U/FY1XasQXgA+q1J8XJoj36VGqhikG+RxJwwmkKW9RZ70eDWGkRXtDw/AysqFzXr0X0U1jETXGvrWyjcEpwkZxLHpyhjwgWGZ4OSp9FESGSadNj4ZBPBIBBEHJ92dfJmQsr3IokVhObqFBSkIE3BDC/Tkry2gsy+1PQRRjRjHLVCJBUA+O6OcQzWF2ZOe7U233bZrKerkw83XHJL9bPqO2hjQQJazQfDNXL40LDrKOPhMxcNUmOEfTQHictahmYSIWX1BX3oAvrxk5itZ+42wpBg2kGD6VITY5CJh0jUKc9E5N+5+tS+G72gfX+ldRXiI6Exl5ePBSTjIhOcf8V2wTYhbs3ckISJ71u355Z6BHDWN+QdHxHC+L5mNraxXvtsDnsTOl99Rpp/WDaN6dry+IZY9Dr+IzA0Y2ss+HpKKz1AbyiYFSu67jWW2JWsJFX2Jr7LhyTlHqdPzAZUGfyse45/mfiQ7CQNx2rGVz8T/gGKWhGHxqXONBs7i4gobtBr5Hcu/YkyoUB+MAVEE6CdxO4+yvNPIt3MjH24DZxFYqMoMOfltk8Qc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(10067099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uHrYdjaFPCFG4KJbp6rOy94q89YegC1ilTvI6oXNNq46c7spSafj633/rJis?=
 =?us-ascii?Q?VqOV8b9RrSBaHw7nMtLQIQChHO6gQyr2yI4wiNS09DrtJiw0x4ijc0AjQEoH?=
 =?us-ascii?Q?tjltRfQB5Z3qkDQylGB66N2YyDY7m/Kf9jFfGZh/8fhWfXKxgbbXRAhIl1Wr?=
 =?us-ascii?Q?90RKM8IfPUC0eG3xvytIr/uVMj7fmbpmNlksgmykKfOiyu8inktkpJ31DOzE?=
 =?us-ascii?Q?iQ7z4ncTSPW/BxhTXMAm4d6qFR8JmjOz312PRyO54LR7yA70gSLQEXDIy+xJ?=
 =?us-ascii?Q?fkj3HEuCrWpftTabvHy6E6NRjNskzbdHpYNITS25UVtyp7/vJJmZQKzLTQvz?=
 =?us-ascii?Q?g3Wqwq9LKchHvL/LAsnqiVe7MmlMtz7eRFWUJoK3P5NtW1lIwv6tIuR39D1T?=
 =?us-ascii?Q?wqGG9MvFgrtyTx4MqMwz75mCrajr0H5kyV5+UDFkH8iE3tJvZknSjxbXh/Wr?=
 =?us-ascii?Q?dhcjFPswcTePtwAaEl4E2MwkbCQyCAli7wz7eJF7phXXaE1/q+bK+OuAPI0J?=
 =?us-ascii?Q?rVr8FSJzw9YRSgdYjGlbMb1H9YklZIUVioMON12/zhP0f4hFS1cXxIcVwXzI?=
 =?us-ascii?Q?j0OErynny9EnmCrr+LjSseXgFsKrBuDJzK3uIDs1JmfrAm3yaiV7uiLjSAtG?=
 =?us-ascii?Q?r40HjngNdUBLqG9fhDA4/NU1XHTAkiBmGDbdj3V/yTYi0sPxLSDrxNlYinN5?=
 =?us-ascii?Q?ZXeC7RNCr3hqzlq5L/v4IoebD17u0TEOiKWwpR9LEYoIcEtKYFdfAN3KRyk4?=
 =?us-ascii?Q?N81uC9S35aJ2MJPjWheu8lfQ7gYej8uCHMmcfh6mtob4bel1AXIHlFyFM1F6?=
 =?us-ascii?Q?ouFgQreIMXe2sBhrh7Jw6yp1Z+FebDT9FUuMvLAW5zu+jpcvmCMwfBU3fIRS?=
 =?us-ascii?Q?P8UXj65M00lOeZ59HR35Mp6NhpG2jcRlBKlXl2n2zoV8t/ccdvX7h6NKJouJ?=
 =?us-ascii?Q?zsODiqcNdSwDx0/4dp9Jo7xljb9h2XVAt3Jd32Yi7La2hRfsUQpMJo9SfFBr?=
 =?us-ascii?Q?jlMcAGIOdOSTdUmesAsXrIqa5W/u1eRyMYtuUwQiUFTTQshhz7qRY5pl6nbW?=
 =?us-ascii?Q?Lr6YGDKZhdgAb/0fe1iy16u60+uwh5d+z6v/cMXOJLuNgdbVBmJhfE3H44F6?=
 =?us-ascii?Q?UMf1iIKnqryugpNHY5S+nOydVUU4Sqm35dosciOF0VGLErgQfLAnBSuxjvDg?=
 =?us-ascii?Q?XZ1vN5Sm1zlC4BsxeWm9OyQJCgOBVI6uFHnqeTel9C9cNG0VDShYRO7PaWYW?=
 =?us-ascii?Q?I95NwgLfbgZhwOxQogBiqWnXJcBchXiS8nZUvMUgfE6wIMn61jGYqETxBhr1?=
 =?us-ascii?Q?MJAhkv5wI692VMQtaW422h0ZWMXCFORmgjfR4zyjQHG4B1RONI09IHGiazfP?=
 =?us-ascii?Q?jXjt+U7pYRehtoRCvrvEU/MJbLwiZXenHzvRfr4gfVDhCXblojg3rQuVVxhP?=
 =?us-ascii?Q?EB91zu4+Gy30SuPwBUThJLF4NXgGCa8tCMrtVZalzKMA+F6bzz6ccifAC/NI?=
 =?us-ascii?Q?kqV+fDG3rprpnsWB/wBPKUBA0pyDJZD/3qhZlDKUQS2QSU1MxXjnk/cTxaQx?=
 =?us-ascii?Q?h7TNUNh7yaXuQGTelEcka5Gg4Xu4fuWV3p7nyW/JA+JoY55XWRMwfkcNBfG5?=
 =?us-ascii?Q?o1EdojpHCDTEDKpn2dWXArijQ7q7/l0kC2NV9fltmIcH1LswuXXSSmUTQ0od?=
 =?us-ascii?Q?NjWX7FT513i0xUwi0mslvT246A/0YPmtB23f+M0oVIOAOkuquuKg6ZciNI4a?=
 =?us-ascii?Q?aTel6MOQ3ONLOAXKYKfhZe/NGhLmlZ4=3D?=
X-Exchange-RoutingPolicyChecked: G/oXQ+jahRaAEz4jU5IlNUFZCfIaYkf8yXG9jQW5+eruHVPWsJgMllWFD0vaxQeqDmI4WjY6nhJYkwCPuCtcRuMxE3B5Ff8dRnnCV9vznHlq1o2flyxU+DxCUqocDF/0BgA7ewd1dzPieM/zOX59OhJQa3kgSPMWVzDHtIjrMjWzHU0HUdB67pCEqM9+y0wcqGeuTcrrvNyhqoCtAgI+B1EDfYgu1PwSFEMqo5R4lLPFYB2DPHci8oEL2wglbX4OKgqxw52oj2kTLAW+kLW0PEG2moUDNVtJyvoLtI1Yn4rHSAOnjwKrs/ZsKe5nhg6nBSkWdgHzulFxxXkFE3sY7Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d5634f8-cd9c-416a-6cfe-08df1281fa41
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 17:02:37.1425 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gLQAs4HKE9UxUIHohJbnrUsvwFvMjVEeWVa/VyccDSVoPTWnYr6cyCqI+Cv0D2B9mCKtx60SL4bucQM/nZGEioFFhk+qGEKOEUpYGdRBnbo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8440
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

On Mon, Sep 14, 2026 at 03:15:04PM +0100, Loftus, Ciara wrote:
> > Subject: [PATCH 08/13] net/ice: use common descriptor creation functions
> > 
> > Update ice driver to use the descriptor creation functions from common
> > rather than having it maintain its own copies of them.
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > ---
> >  drivers/net/intel/ice/ice_rxtx_vec_avx2.c   | 73 ++-------------------
> >  drivers/net/intel/ice/ice_rxtx_vec_avx512.c | 64 ++----------------
> >  drivers/net/intel/ice/ice_rxtx_vec_common.h | 59 -----------------
> >  3 files changed, 12 insertions(+), 184 deletions(-)
> > 
> > diff --git a/drivers/net/intel/ice/ice_rxtx_vec_avx2.c
> > b/drivers/net/intel/ice/ice_rxtx_vec_avx2.c
> > index b72f69a47b..68401560ce 100644
> > --- a/drivers/net/intel/ice/ice_rxtx_vec_avx2.c
> > +++ b/drivers/net/intel/ice/ice_rxtx_vec_avx2.c
> > @@ -5,6 +5,7 @@
> >  #include "ice_rxtx_vec_common.h"
> > 
> >  #include "../common/rx_vec_x86.h"
> > +#include "../common/tx_vec_x86.h"
> > 
> >  #include <rte_vect.h>
> > 
> > @@ -773,70 +774,6 @@ ice_recv_scattered_pkts_vec_avx2_offload(void
> > *rx_queue,
> >  						       true);
> >  }
> > 
> > -static __rte_always_inline void
> > -ice_vtx1(volatile struct ci_tx_desc *txdp,
> > -	 struct rte_mbuf *pkt, uint64_t flags, bool offload)
> > -{
> > -	uint64_t high_qw = (CI_TX_DESC_DTYPE_DATA |
> > -		 ((uint64_t)flags << CI_TXD_QW1_CMD_S) |
> > -		 ((uint64_t)pkt->data_len << CI_TXD_QW1_TX_BUF_SZ_S));
> > -	if (offload)
> > -		ice_txd_enable_offload(pkt, &high_qw);
> > -
> > -	__m128i descriptor = _mm_set_epi64x(high_qw,
> > rte_pktmbuf_iova(pkt));
> 
> AI caught this for me on review, and I was able to reproduce it:
> When you build with -Denable_iova_as_pa=false the ice driver build will fail.
> "require_iova_in_mbuf = false" is set in the ice meson.build file. So either
> that needs to be flipped to true, or ice needs to keep using rte_pktmbuf_iova.
> 
Good catch by the AI. Changing the code to use the proper macro not only
ensure ice isn't broken, but also allows us to enable iavf builds when the
iova-in-mbuf setting is disabled. Will fix in next version.

/Bruce
