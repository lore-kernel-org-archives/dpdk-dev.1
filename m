Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69379606A322
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 16:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=em330DLk
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AB1B140264;
	Thu, 22 Oct 2026 18:51:49 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 638924003C
 for <dev@dpdk.org>; Thu, 22 Oct 2026 18:51:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792687908; x=1824223908;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=H/u/Y23dF4JvEumKk1D5eaIqOe+CFFu3yyrw9J/RKW0=;
 b=em330DLkP6IdxJuhF3nyVzc0X/oX2axlMHr105dDnTXLc9PXoI9L02GR
 tkR/57dlBpPx8S9uV1/ZfY0WtC4pd7RByIN8rPOUgJDZkoQhrk0pmsui7
 CxFFXSfl63oWK/R4SYMIdVRJtRVbNfZdWT1wBX2BzX1YCeTp/3MzqEybv
 WUjLKAwxq/50CFAi2MYAew5NTTQXsxfsqznIdj4+Yu5MG6f+N884OdoJc
 VimqY8Tef60Wz9P132lpenH2S5eDn4Gue0ipdFJ0prsM+hIOUC8InFDek
 xgluikwgt5OMGd+LIqY73e6lxsmsSVaao/Aebrh+TZoaTGTRDTVDBHqfe A==;
X-CSE-ConnectionGUID: gBjClMPvT5WA1G6FlQAFrA==
X-CSE-MsgGUID: /8FjK8oPT5akt3TGnxPoqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1445675"
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="1445675"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2026 09:51:47 -0700
X-CSE-ConnectionGUID: UrOVPOroTZ6xbGXdKY1clA==
X-CSE-MsgGUID: 6y78j+ueTVaxU7E4IbIB3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="3500802"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2026 09:51:47 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 09:51:47 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 22 Oct 2026 09:51:47 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.12) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 09:51:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d1CObGFtaSOl2fFUhlq5eax+XZLQYzG0v4BMumztMAIvaXP0ZBuZ4i73RfjFpAuScu8IOWvu/FPEzY/tc5I6+vy8nynC9q5m7kGA0PxW9Iqfknhus6sviJ7JXTRxRwGQJg3oW/IvrWlKqje6npL6MN6VTyR4Ws14ocItd6XFPuSBlOJnOMv32jPewxZvxSk+IYlPKxnhmUrhPVzw5fDBoiZ6GkksM4RIQOcvCxPAa9lOfNAokJskLJ4iBoRNtV/+PoJsB7GQNzcL5hPz6U2Far3Db2FqoweV0FGm0opo2fdvpYVfdIprtZ161t098V6HBPuODfOZTGLaEY6sNFMbhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X9JC5zEo+zx01ML93e1RwxiTJ5ZhfnhPLxtB1fysm+Q=;
 b=ezcw4wQB/mINkz0CJeU6t+D1T+B6OQxFFDgVvKow56sIPUoh40cejd3wtZvVAOmh7yoQna1rRJz8A00lvLfcHUhmCU5a31DNo7bFgp6oddXleScPoiQ/FlJmektZri6y3+oKVxs6JSBwZIB8nHbTonNFliL02q9ZE3sOXJSF/XKy8Sndqr3n7gV+JkVkbCHtcXt+GelGY+a5xTtJqWi5Jm9GD64y0uAS8dZ1rbEySxvghNAAheqfRd0ss3r7/XqUpr2vZfzonwjAnkyiGNCRl1z0xb/DT3ZK86p+G7yS028o169PZgow6VsrR/EJmSfTM3yZtBXEOT/qo2+q7ViS+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by IA1PR11MB7774.namprd11.prod.outlook.com (2603:10b6:208:3f2::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Thu, 22 Oct
 2026 16:51:38 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0522.017; Thu, 22 Oct 2026
 16:51:38 +0000
Date: Thu, 22 Oct 2026 17:51:33 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Pravin Pathak <pravinpathakdev@gmail.com>
CC: <dev@dpdk.org>, <jerinj@marvell.com>, <tirthendu.sarkar@intel.com>,
 <pravin.pathak.dev@gmail.com>
Subject: Re: [PATCH v1] event/dlb2: race condition during dynamic linking
Message-ID: <ato_FWxmvDFdKfzY@bricha3-mobl1.ger.corp.intel.com>
References: <20261021172041.433881-1-pravin.pathak.dev@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261021172041.433881-1-pravin.pathak.dev@gmail.com>
X-ClientProxiedBy: DUZPR01CA0166.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::9) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|IA1PR11MB7774:EE_
X-MS-Office365-Filtering-Correlation-Id: 14bb8826-866a-4d08-de35-08df305cbd49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|56012099006|11063799006|261021121427099003|261021123027099003|261021135927099003|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: poqz8Ba2EN4+N9Dsr0GJt3tarBZAkzUt8HW0oBjYHrEbiQLf6h1NzXCMZcPRLBdyveCb2J38makvB2AOaTLDoL0TSC0yeGFgABfmX8PF93Io9Yq6glYc7QsLwhl1bkcoqEcS1aSyYiTHHEjO/vcfCqoJM0Sq2bIuIJulLdJOKeFGBM2N21gQVighUalnSTLmC1/LRE+4DOI2ZTnaop/2jwYRT+TKSEEq4EPUj8sueFu30malE2W46k2jT+qBlytjzAhUue82EwSlySbuzkI32T13FPnTdVnBAt69bzj5+m2TH3H5zTZ7dHtwV/5ww0fSOOAYuigk6UDi+SwGRKBtTBqYlMm5TX1JCEfV5JcVUKw/bRDMvGx42+XBguxYgOdqNK40Kyn0tsLNSPik+hedpIYI6fPjjYavEBk5mTu/iuJaWOKIQraIpv5lYUPAr1Zr5f8qwVvTI9awmeQlON/JiVciJ0dRz1m5k1AVyJDBd/Qjyq+piWiHGWMdr03jB/7kwH7TyAQ0QuASlan/hJZOwSA0NsiWRn51JtdJseLQZM8s2+L3AV2HRc0bnJExKiTEX0HG9NqrX1HBqmCqlGtDnm+JbxfpbUufpAGNP/Lt6/EMThWEgB92q4K/gD57CR6/QkNJqK1fjD0hAx7kwHdxfLqbTbd73ujywsTmSWcptt0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(56012099006)(11063799006)(261021121427099003)(261021123027099003)(261021135927099003)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/v3Icg4+eynFdw3o5aFPBcXTx6zpBF86sa47d04dkwyGIhxLv5sbPdcOfkbW?=
 =?us-ascii?Q?A/BvuXNyb8dESmW1M6JRRS/fYTPdcTYpbQYeR59n6sErW3woTXP5E+qpWH3c?=
 =?us-ascii?Q?nVpdPAXxkrb81aDTnIEkWnaDcTxAM1Au0qiKRSatkIN6iZPIW0DMFL6s1EtO?=
 =?us-ascii?Q?6m5hAJTaYf2FTTQTIwFG1y1+OQxyulJFQ8B3mfgKRs83o2R9EJe31owiiDDV?=
 =?us-ascii?Q?fFiRQZi1+xiXxFbkUKgPA791OiezJn3n/xw1bhmHgfDhI5MXwG0UpWuHNdXN?=
 =?us-ascii?Q?jXAJZqxxCM/vud75gPMFNzkpuemdVsVMbthKbtvWfr0UeaXEonXHGh95jPwm?=
 =?us-ascii?Q?/NTDGa8hHSxk5ULB78gzoBW5AXXsEzt7rSa/eW6v5kIeRe14IO9xqfgNYwl+?=
 =?us-ascii?Q?Ks91oQ+iCBVr5FYLSTb261wW2QwOY9AdHccNs/rOhiRxhI5EYLb2AMpbX1U1?=
 =?us-ascii?Q?hEWgea42cErVRLE/FHVlqEGgQTBiah2TMq75HhBluT0MS3TN6cibVOhm1vsE?=
 =?us-ascii?Q?mefY9vi4TgAHX9AoqGan+K2gVeqO4doAi1sl4ofKyebZI4aoBTH0JYfLj/aJ?=
 =?us-ascii?Q?WtLTh/Sur+B2/tsXTtdo9pNaKIE/oA04drq+TTbETPcgKGmvMckDPiDwtBVb?=
 =?us-ascii?Q?g1iSEKF2dK8IAfVsaw8dRYS3BhC8mM7GB3jrTBsZyhkPWOlw9mrc+mgWyh9X?=
 =?us-ascii?Q?9bNMTSHlBt7O5gxT7CLc8j+sAlDgdvB6g1gIXFxHpbAVKd9XQYFK5uqWq6Ia?=
 =?us-ascii?Q?mKafkBbsD0sMreBxq3JpgNNvq4qQXfud56d5HTukvjw/IRpfppH88NhJcl2i?=
 =?us-ascii?Q?qOrUmsKYcXeo7PXCKO7tt/96SzEOVEtkYrYr4s5NVxRhgBSd1qKD9QeA/B7C?=
 =?us-ascii?Q?zapchX+hqIIP9wwhn7LPTXKs4vOT3xYTikkKyeUXu3Gob768WDOjOvPsajp/?=
 =?us-ascii?Q?gQ9mgDpuJ0Kv+45bvOOvtuAGHREz0LyTo6A3ET1kch4hjzaw56Fk/flIQEuw?=
 =?us-ascii?Q?OlWwIDgKdysfsAMYkEGkqA2nQSaTtOOv6nLye/oIkLWCyR0koWZ97WKDiy28?=
 =?us-ascii?Q?K/bsbVfJhfCTHTqrX47A05hTVZi+hIm+vF9yFyIgxjduWRyj30KpQXdBExlX?=
 =?us-ascii?Q?6N5drzvtVgeIRJAW6mfTovIbhLeLFg0wijdJcNlJsq/FKLQBjRCYiPK2byIm?=
 =?us-ascii?Q?EcRHXGKrepuoEagJDl4F/QSppbY17+3qPQpZfJ/HJc0FnrqrE3xCYfUlBz1A?=
 =?us-ascii?Q?B21/g67uizSX5+Qt+S5OQFhemrBS+/fkSSe/sqQCbSqsoB3k9nfa1K58wiJ7?=
 =?us-ascii?Q?qmlcpBHnAqhwZevOl8w76lgdA6CGAhy2k+sUfCJ7Q0mKzevmYuU7R2cDIuyn?=
 =?us-ascii?Q?FGeucgoi2bBwmTntdqGlb1xRfh+x+kUkrIB8fiWEDs4zH3W7VOMNLTCQ1iZE?=
 =?us-ascii?Q?jg4EjW+sUcMCkmKAbUHlq1eoybM7vabW9tbNn7asuHDCAUMWY26VDmvRY31o?=
 =?us-ascii?Q?UG5OlHW+zaqyDaU2iej6B5LNIGkGJUpt7mqdw9ZZPkwD8Bh3UNZpa0d3Idxe?=
 =?us-ascii?Q?YctmMPls7dmaxA6CXjiu7Vlje2S9Gr6mzPnb2e8R5U83VVFvg1YBjKvsya+b?=
 =?us-ascii?Q?A646oYyVLExCWa/83rn46BBiRaGLDCWKr+FW2KFJEM07XCnPUalz9ZGA5cqt?=
 =?us-ascii?Q?KdOtdRPRxLtI7ABEq6DZV+RYXTFUB8puJJ28fXv/rA5H5bJKs/pgnS+rGrad?=
 =?us-ascii?Q?AJslgnQCsiaESER4ckn4id2RmuoiEtE=3D?=
X-Exchange-RoutingPolicyChecked: SSUvPG+SMxHDX3O0GQXMJ8tMC1Uo6xc9y1tll1pCqoxIdWwRCdmvZKfNHVjvS+fP6gmNBzt+b0s6DVqPrOpgi/34hYQQWSns332uhJEshUQygx6boud3O4qfxq8zjWquWu7zqWmBwbv7p8W/eP0P4AbSz4ZjmoXxLjENUck5wD/nYrm2G4WBD8L6frVz27sKvxP+Qvfncg8nXOBjGeQpY4kJsw4hKGBn1prnkQsV5F81DWPorWL/4+6lOEyhJXg3fWRz/Jz3ON60Z87BAYqJhGq/X+HEuY8o5JVdwwXvHTURkWxWxS9VuNlZQfXZ06/gTHItwGQlzKSm5Gdbi4rx8Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 14bb8826-866a-4d08-de35-08df305cbd49
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 16:51:38.4147 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ste4yUq1EzaFw/8sA45itcRYri0UqG6m8/lYLrUD/0WAWXqtLn6kAADdKwu97rGDCpdfLfgxPyTZPfP7l67K05I7jOAjItRtKwQLyPsFJDs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7774
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 01:20:41PM -0400, Pravin Pathak wrote:
> dlb2 handles dynamic linking and linking asynchronously if queues
> being linked/unlinked have traffic. It starts a thread if not already
> started to handle the process. This change avoids the race condition
> in thread creation where sometimes the thread starts immediately,
> descheduling the calling thread and finishes the job and exits, and then
> caller sets worker launched true when the thread is not running.
> 
> Signed-off-by: Pravin Pathak <pravin.pathak.dev@gmail.com>
> ---
>  drivers/event/dlb2/pf/base/dlb2_osdep.h | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 

Fix makes sense to me. Note some comment inline below.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>


> diff --git a/drivers/event/dlb2/pf/base/dlb2_osdep.h b/drivers/event/dlb2/pf/base/dlb2_osdep.h
> index 382a49090a..1505563f83 100644
> --- a/drivers/event/dlb2/pf/base/dlb2_osdep.h
> +++ b/drivers/event/dlb2/pf/base/dlb2_osdep.h
> @@ -208,14 +208,16 @@ static inline void os_schedule_work(struct dlb2_hw *hw)
>  
>  	dlb2_dev = container_of(hw, struct dlb2_dev, hw);
>  
> +	dlb2_dev->worker_launched = true;
> +
>  	ret = rte_thread_create_internal_control(&complete_queue_map_unmap_thread,
>  			"dlb-qunmap", dlb2_complete_queue_map_unmap, dlb2_dev);
> -	if (ret)
> +	if (ret) {

DPDK coding style recommends using explicit comparisons for clarity, so
this should really be "if (ret != 0)" or "if (ret < 0)".

>  		DLB2_ERR(dlb2_dev,
>  			 "Could not create queue complete map/unmap thread, err=%d\n",
>  			 ret);
> -	else
> -		dlb2_dev->worker_launched = true;
> +		dlb2_dev->worker_launched = false;
> +	}

I notice that worker_launched is neither volatile nor atomic, so is
technically not suitable for communicating between threads - though in
practice it's presumably working fine here. Maybe look to make it atomic in
a future patch.

>  }
>  
>  /**
> -- 
> 2.53.0
> 
