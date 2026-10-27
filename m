Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7910606A324
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 15:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Rrkq6RMK
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ADB5A400D7;
	Tue, 27 Oct 2026 16:27:15 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTPS id CCF8E400D5
 for <dev@dpdk.org>; Tue, 27 Oct 2026 16:27:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793114835; x=1824650835;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=jalBK5eJHcYClaNG41c1Bbds0VeAGP13jF+6Doqka5E=;
 b=Rrkq6RMK0XmvAQ4PukyLIw3hQ8Iu7xWeuv+00TYEq5AedFG2H2Sk6ABW
 4PbUB8tvVFMR+/KUMIyffzqUkZvnvmcEpBUYWqYoeXkPLhNQx0/j2KhNb
 Cx9yQM3kToadM+Tn2TFHmoPLqrWuuS6JAs0zOKglEjs7lMn4BLVsYU49y
 /qe3xa8nQcqWOlTBoG1ZC5GnYBH9vLMv0txTQsj4f9SOZDrIHTxrOXtMd
 BXiDsnSlC5vHS/W+taXlRwfH8M2+mAaiCkJzQXvURTytgt0zCx22afZAd
 ++zIzn16mc9HvkUyss0iDc+OJPne25N65rVBioSg/xcinGnEFECPTFrs2 g==;
X-CSE-ConnectionGUID: C7Vo3X5wREG9WDT5m9nsdQ==
X-CSE-MsgGUID: aWJXIvM6SA282ILMR+WJtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1704683"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1704683"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 08:27:12 -0700
X-CSE-ConnectionGUID: 8XkM1UX7QcqB5QzigcbB1g==
X-CSE-MsgGUID: 6t6kGBU3RpGzavYde9FQCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4644776"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 08:27:12 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 08:27:11 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 27 Oct 2026 08:27:11 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.54) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 08:27:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pmcN5iU1+x33dMOXWcWB1l+E0hfShKqidw8eaO/XP/UW//8E0R4qIOo72hUi9y+wGrHt56Uh+zfezWj1NcWuo/T09vGpQ6daJL45FTYYzpaSsYD+sFCGaALLDQhB1UZUcjeX/nupl5i0pQK5MnxovYxpJVYqZ3vUxWF6518DgQpKMeTWwUEygKgP35O5eBmUGqdzvRmr1ed2qnyqs+f3fcRp+3Gxib+ZK90NFarWyH6mdlRDD0a+ZM5W23LhJ4Sri2dmNpJXA0WxUiFj59ZC78DyX/h/qp1Y1cfsFinDGtzFvjKqBdDJRjdMeoI8y1MVnihLg56p1IDPm+4TxvDx+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CzGu3vZLa6Ckqcbum4yVpxpC1EpNJLaM87vKuZ8c3UE=;
 b=aUw2mDoyzMWdGj7NyUTDuXtZUQrFGyf7WL71nb0t/Nq9JCzLhP04kLkyE85TTwnlWuwlfM4wBdyQMOoNlHso69z8urAHSKPkG5ONOfJMaT+Czl3VIuj4/pcVwnoGAonEpFMv5P14lDlbKDQtblDWw1J6UefeNnEFATAIiGIxQ5Wt+CZbeHlhpSWGcIW/43GDz8JiMmrYeVSvzsq/oxvU0TpRJtz4ZvW3LJGFOYtrdA+qdwI/g6EfQNSMn3lbosqwPSl440ygJW/QqcOQhSWQblO34oV+dAH4ehQnYVpmIW7tpEqfQRGRr6gkVqsNjB9okBvjeUCaZxCsmpTHVKGPXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by SN7PR11MB7996.namprd11.prod.outlook.com (2603:10b6:806:2e3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 15:27:07 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0546.016; Tue, 27 Oct 2026
 15:27:04 +0000
Date: Tue, 27 Oct 2026 15:27:00 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anurag Mandal <anurag.mandal@intel.com>
CC: <dev@dpdk.org>, <anatoly.burakov@intel.com>
Subject: Re: [PATCH 7/7] net/ice: fix ACL profile segment leak
Message-ID: <auDCxGqLxAp1hJz5@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1793097896.git.anurag.mandal@intel.com>
 <5254238a89b9e0f9ed6a4c9740dc34fb02a69b19.1793097896.git.anurag.mandal@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5254238a89b9e0f9ed6a4c9740dc34fb02a69b19.1793097896.git.anurag.mandal@intel.com>
X-ClientProxiedBy: DUZPR01CA0158.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::17) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|SN7PR11MB7996:EE_
X-MS-Office365-Filtering-Correlation-Id: 18f8da67-3481-45a5-3a91-08df343ec165
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|261009223027099003|261022113327099003|261021121427099003|10067099003|56012099006|261026121527099003|22082099003|18002099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: b6ZaVBkOlOcEyYdMjR6ad+AvcPW5li62WqTLNXDh9SpDyq0tcZyM4l4Gbgls0cjSxElJBfcTCQlNUsYI16JvurnzjgqAyr3xur5qLSujJg88w4H+zs+wyYLHh5Dj2tLZGo6eez/HpG2/hrFtqGNkLiRYkOYT+lUiGK1vl7P87zBd1Y8x3+2Kf5Hf/jfHQOk4kqMRa+au7JaNWv38XeFlNZVv7g+ErbKnvaVJuLU9sIUhIdH7kDrhyuY91uXEoO2JCodPXlOnv9d5+3Ud+ch3Dc8lkEeadbPNcjtCNbil0V6Aj6Mt4IfhMg8SblG0WczzmcTaj1Gd8kzIysrY3lArIPpTM5KqOAapbN+0G7AI3jDCt+2AJq7sWLa0l1tLiF3qRdZEv4hFC3kHAZMhbLVEjfgX1IhPe0LnotXP3OQjy1E8pZ2tnhKV+ybszVhSXP9UlC6cc4UjY+D/6px/m6fA9B7pDQvVW2dAPjHZz2aDdBXcA2ZPC9hvMETUTX985u2zmeNegolRzKgDmnEzwqIkgIAGeqJBGrLkF8S/Ot4pjSmNg4sDcBdbRFeYJtuAmI/9WcczFAr/tG3yXWmxc9/Eb2WduuHFWOCCeym8Ib/0aAWsrGrLS55XCVsA0lxdNYseGUhbLB86TskhrAvYGsH6AyanmMj9kdiWf3HWy6W/Y4s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(261009223027099003)(261022113327099003)(261021121427099003)(10067099003)(56012099006)(261026121527099003)(22082099003)(18002099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pc4nbjkcnokpY8Hbz9ZyBx61tylz/xZq8fUio+fTRYhRnxt4bOK7yGoSDzlR?=
 =?us-ascii?Q?2HSIcVaK9AuKaZj9zF+RV5Tt0YMsrfEsqjXgqsiq9zvFxX4AUFOYnAYEGW9G?=
 =?us-ascii?Q?H9jgNai+sLApcQ/AH/4E4HhKp0UuOoBF7E7QPd7EuvpGZGxRDE2iegRpd5DK?=
 =?us-ascii?Q?lIXMLA/scwKqH3pVpgKG0P/6pa02aUG/7fc/gxzw0QjyUPmgZkPOIaRzsJs7?=
 =?us-ascii?Q?u696IEEtGbzxXPkcS3lnaRsdAbKJI29wWZQVO+yFRoJ8HtaXXSP+79jEOPCE?=
 =?us-ascii?Q?WAcXoQp3AVmQNCe66sQHFOY7ciVPxc2u+LStGvwOoEqu3VNC6EID0+thtFtx?=
 =?us-ascii?Q?v1Fr7iDf7/YbKFjl3lDD1C+7Ah4yO+Ex7ZXEYymcV/rCTJ21EGU2eRMOgxFI?=
 =?us-ascii?Q?8T08bpek+MfEj2vHg+GT5ePTqxnrgNesTF4l23vfXqSNDmyvS4du8nxhEBKv?=
 =?us-ascii?Q?8I6NMF2EaanQJc3uHLPqiT3j8Cay6wRIeJFWUVku4pQBiOu5VDhuq1IpHh7y?=
 =?us-ascii?Q?3REpuNjB/OkpesRAnulvgHx36BdDlu0QtsNzG0nfIM1lxqfEdKM9eYO22dGh?=
 =?us-ascii?Q?WZo84COYWYIp7xY8+5OuKUhEQYezUf55WUZ028mFMpIPXCHZKZVKcPxthe0K?=
 =?us-ascii?Q?u/hvkUy95HsHIdi7MS4IGSH71bI6XnwGdvdEscBzFv2mzCiempNgUADeT803?=
 =?us-ascii?Q?HsTGGIQXAWN30j9j0tGE9KCyjp16EUWzdhG0F8XY+7yepKWq7ejeZ2F3F55A?=
 =?us-ascii?Q?1+Fsn8qDzVCa/KLmY9m5+7qbYmBjdhNbGQgdq2DFa0m2+kuVHcp09/O074El?=
 =?us-ascii?Q?6PB3tbhkfUmW8fngjtYQ8ibkhnRviAH5itH4yKh3E2eTdvusf+rfL9tbe/ln?=
 =?us-ascii?Q?2yICgRz30fuR9FoGNSvvD1L7LisKfN8qABVWhCyqAdZ6KrMS2nd7nVmfsGgu?=
 =?us-ascii?Q?nmaU+aG748+HHma1Tsmn7TQv4W3XHdQExNz6e3x4z/pKyX1QT3W67HKBcFsh?=
 =?us-ascii?Q?w7fdbI7otRgk2WoC5KQmxMpdsc/H/9Fcad9I2btQM4bQf4tpYdErIvOdiKRm?=
 =?us-ascii?Q?EnLVJSfAoPieTi+o1BKtUO5bGZlHjdMsS7poADmUqYDdv3p6JnGqz3ppJtxD?=
 =?us-ascii?Q?3pUcgfLoCd7khBmAfoihiL9ArpIPcKUsvmEPKp/I+O63D6x+ZNqXqEijoenA?=
 =?us-ascii?Q?JpJsIDRaKocNAGT4BuSaRCK791aUdhA2uCat3SUC+rQKGjvXJ71VEt1cq8JD?=
 =?us-ascii?Q?Uioik/bcdaWqpyEcOl8mbGDk8PXQPdO24sR2ZPtnOStkN1QPWTE1XfWwN6fo?=
 =?us-ascii?Q?swxHD6livj5kkC+ney18f0dOGgB5TdnrZpWFgA9GoSoPJjXVPpolCEwGqgQe?=
 =?us-ascii?Q?K73LrlqA86y5VxuSL/maot3sMrSGsNRCyUMVm1zt9Wyk0qoH4EfjDrpHw+2s?=
 =?us-ascii?Q?jmkozmTjbKEVfcKfa6dxHfMywbVjEnSPHsGTOqRCO2gW8wKzPwhWOV2XKJl0?=
 =?us-ascii?Q?RYWwTyz+y3M8VJUXitc9L8meGn/3xhx/nsnqMZlhuUN9py48/ES55hZ1eY5x?=
 =?us-ascii?Q?59M43STyXecC/K2NnjzoXHo9YZa1wRXfq2IIDqEYILGM+G/6zAd1+HwD2I0Q?=
 =?us-ascii?Q?wGCNFVAl5+/Mwa2Nj3cEWCD6koqbwy3xtkiXfuutgc4+wrHwlmFkDIZ51Jv/?=
 =?us-ascii?Q?yFV/IxQMoEweQbG6UNVZNNziiW2ehVM4pvXxXCOVTNRfVen/nzMaiD2ben6H?=
 =?us-ascii?Q?EOt4PqhqcUW27gP7TDssFne2Gww3+Rg=3D?=
X-Exchange-RoutingPolicyChecked: 1fsAI6g4BDOABzHSIMPZqrt4cd6P/xBUiqnT4oUCC/XSKP9NC+wYqNN6kGF+N7SfapkdKjF2cPo0qn21XnEscBMb34Nsl/VMpU3ZhsLdHWLL77KSmcduCJhGztGod9FmCKr2HkDXDx4Xy1osnKEjb+GR86QaVbC9oYBbzlka9grdFwSLt5VrmQhbopg4Tva1M+3tcjRQD8MbDk/EAEvfrgF1dmGwGWg0n5uslF5ub6jkdmqoQHOoNZ1cf2iHWFnD0KhRn0Ji6TW4QfpiznhwY/ryyrlEk8+zZRkrXyeO9xT8Xu/g9GkMyTqSdIScJoX/y3MgMo2xwOrAHyWlpndD4Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 18f8da67-3481-45a5-3a91-08df343ec165
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 15:27:04.8294 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CSm1cI2mm2G1g/ayyLptGYh5jv3Km3O5YHqnWy/f4QwtxGy6PD/nyvpLZdNQEYH8X+JB0tKZua0tH8WSy1v1WU0yus+YhUKk9esoRrx2+fY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7996
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27, 2026 at 10:51:37AM +0000, Anurag Mandal wrote:
> ice_acl_prof_init() allocates a flow segment to add the ACL profiles,
> but only frees it on the error path. ice_flow_add_prof() copies the
> segments, so the buffer is no longer needed once the profiles are
> added, and it leaks on every ACL engine init.
> 
> Free it on success as well.
> 
> Fixes: 40d466fa9f76 ("net/ice: support ACL filter in DCF")
> 
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> ---
>  drivers/net/intel/ice/ice_acl_filter.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/intel/ice/ice_acl_filter.c b/drivers/net/intel/ice/ice_acl_filter.c
> index 21b48e1009..d49e514d69 100644
> --- a/drivers/net/intel/ice/ice_acl_filter.c
> +++ b/drivers/net/intel/ice/ice_acl_filter.c
> @@ -308,6 +308,7 @@ ice_acl_prof_init(struct ice_pf *pf)
>  				goto err_assoc_prof;
>  		}
>  	}
> +	ice_free(hw, seg);
>  	return 0;
>
While this change fixes the bug, I see no reason why we can't avoid the bug
completely by changing seg to be allocated on the stack rather than
dynamically allocated. Define and zero-init as:

	struct ice_flow_seg_info seg = {0};

And then the memory management issues disappear as its just a local
temporary buffer.

What do you think?
