Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143F9CE8D4F
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Nov 2025 16:05:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C3DA240EE3;
	Fri, 14 Nov 2025 17:05:40 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 19C7840EE1
 for <dev@dpdk.org>; Fri, 14 Nov 2025 17:05:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763136339; x=1794672339;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=PBPIo+1kBB0ekCGDszJbMHuWqaUlx6Dn23gR8dlcgHA=;
 b=C2A5plPQdoXcOjnjNz66xRChyg3bqy8ELBdT2gL7gySZbwDWd0AA3GbW
 zGw9fOQMcF621gCm/r9he2VMCFYVAp/eQnSmL2pIozpY66tgkpt8uJ4fb
 PiJA5WSMSbMnaGl/X7xHGyKqcp8lJmvPGaKskDS5t5WevlVTHnl+6WpzV
 FrYJDoRVVk3mBjrrNZV4AZxcJOAnBrAEsRVYju/tBbrPdZbWfDuBaSeDm
 a4xbba+KdD2j6Duno+Yu00eoN2472A8DBgCEkmp9tCeM0+PK++/xIJzju
 SodXldUpo0aDqzKYCbI9fuloo9Jensv/sEqrm86QGf+stlCECkjtQV6Q0 g==;
X-CSE-ConnectionGUID: P1vr4hVaQYmJs7QfHfuf8Q==
X-CSE-MsgGUID: Js+VwQNaQDqvp8b7dXqgSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11613"; a="64236909"
X-IronPort-AV: E=Sophos;i="6.19,305,1754982000"; d="scan'208";a="64236909"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2025 08:05:38 -0800
X-CSE-ConnectionGUID: U1VOiisKSwy/8yJTBKavLw==
X-CSE-MsgGUID: c1oEGE+dRbW2VRHPIszdjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,305,1754982000"; d="scan'208";a="194970262"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2025 08:05:39 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 14 Nov 2025 08:05:37 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 14 Nov 2025 08:05:37 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.5) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 14 Nov 2025 08:05:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cckl5jUCsL6uIVaB/oXOleNpdifzZSJ1UNoWFsGzMZ+hoZL4PrwipBk7Jow1xJaGLBqPZ8vmOl4AGybPOC6XysyKJoBidoxqAmeY7or19c66smAi4dKpecGsvgAE8wE+HJId2salCrLXE7S7ReWx4HUETTCJ2jWThoNJ2xWm/Y/7fhDA3h5WipWJe7r5KCDHR44SN9fpAh+zpEFB7NpMurMQCGaM3YXAYrgKsNREPYif/sDdhhxvBrl/++ZEg4qm+sIxiqUDX3eUMMCMdp/5gecbfGdAv8sKZdLxwl12rYZ4Ba/hBEjF/oN3ATMlk9Liz7Ebs5nV9+Yl9mdNa4dHZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xB3z+s79+Wojcztx57FeitWY9eCPXB4X4GQv3YurrXo=;
 b=KznVdjc+CTb3Mr/6qLXpsDNldj8FpNBanL+WwAH++6CiEyR1ZllkL5DEi1MJzz2cxfacyKSdJi7iRzJc8MnO+43OQHNwDSj0/fVbXfcW1NWN+O2oNH4zSfz7JI95v6cHH9MarM2I7NQgmQrQQtuIXUhq57YQoQ+oq5PAiY1JuNOOY2zcJMXoMkhQ9qWFnesT6tmsVnLzj6MTD2b7WBSTfjKpDctHD/gzkujMe89Rr7zd9ePJ9Kls9gfh+Bmeg4vJOcINXZBuWf9u180Nh2SqJBUPGQ67zTJaMOa9rdeK3vUS/rIQJYZ4tUbxfMqA4aOz8qfA1yr5KjUPgtpcfFc1EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ2PR11MB8499.namprd11.prod.outlook.com (2603:10b6:a03:578::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 16:05:33 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 16:05:33 +0000
Date: Fri, 14 Nov 2025 16:05:28 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: Re: [PATCH v2 3/7] examples/ip_reassembly: add check before
 formatting name
Message-ID: <aRdTSKrTVDqbFmOC@bricha3-mobl1.ger.corp.intel.com>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251111221857.443752-1-stephen@networkplumber.org>
 <20251111221857.443752-4-stephen@networkplumber.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251111221857.443752-4-stephen@networkplumber.org>
X-ClientProxiedBy: DB9PR02CA0008.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::13) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ2PR11MB8499:EE_
X-MS-Office365-Filtering-Correlation-Id: bb0a60e7-77f0-4e73-2c56-08de2397a41c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hhYqAW1jHf3SRksKVn9cHgIvxBfirr1QYsigjS+1g53zKK5LCB2tiY/IHCy5?=
 =?us-ascii?Q?vmTDwPGIaZXMrKdWStya8AZ3bvGSVtzH4G4Wk73jJP8CZwKXJ3bWvr2W3wvV?=
 =?us-ascii?Q?cszMlT4JjPw7kmOdFPwanFTNF/6zR+Krxy/gTH/0/wRO2hq9lkzSaC9Fdix1?=
 =?us-ascii?Q?sgJJaFOuqRYznt3ncRyCx3RrFy/1NH7VmqUwotyVE0QDqFRwOXE9BB9vvDug?=
 =?us-ascii?Q?XqlwJu5auxrv6Vk5NXZtTfDlO/EVKGLtsebUauoyme81wxex+nlsMDco7b2U?=
 =?us-ascii?Q?MBMoUsduclEStFI/NSdBGhf8f4Ui6lSLi8xpdaeZLK0xnSOq+2I/hHCmp9Ve?=
 =?us-ascii?Q?uhLNWeKAlOd3LhYDXWSZmOq9k4n+NOXJUJWPxFZAkb9uUDayIYE4S2M7PtBC?=
 =?us-ascii?Q?wl6KyZnJiLGLg1HspCXMIwSNjDJEICB4Z3+sZX1CQQheesmsNDXufN2YQlg4?=
 =?us-ascii?Q?/2QZ55Caj93r8E2o0yVGcgQdoD9p87d7/bPlDVZ10gmRoqH1dzE63vbem80E?=
 =?us-ascii?Q?xjqOfh0s8za2696z/2BE1keyVoxZiSnOtQ+TEDW+NGamn4dQTZURqTtLgVyq?=
 =?us-ascii?Q?BR+SwSXFJ6o63i4qU/FfhRL6+4lu/ZuVp6chDDK9wjdu471Zz92K/CiNaV7X?=
 =?us-ascii?Q?z1jU6jRN/imXgB1qWL4efN+0hxZuL9EuVnnW5rTE+wdsotXOUAcY5AvsEpN/?=
 =?us-ascii?Q?U498Kw7mL29q1SDR9sFyzfIE4X0SyJa+eQMjJrmF/y20aq7XlN0VMpSxmuA+?=
 =?us-ascii?Q?/ETpPSbtLCltyIyhZqT89jCzmtOijbeiwBdimLzmwN6iR4kA0W8/FcMTmnkL?=
 =?us-ascii?Q?zAB+gK2ObBTEV0qE5rafw4clqkJ+JFXsQt5cTkte3D693kYYfbZy3EN/e8oT?=
 =?us-ascii?Q?WUrQaqsxtCJvt81nDV9aO9Cj/AiWW6IK/+F38MlXYDan+txGiNqrJPNJR7Ce?=
 =?us-ascii?Q?NWMT2I+EmGvi9y8knRpNvqsWdDvxqj4o7SgzFPAA1TTBLOkIrNdrmK7/JkAn?=
 =?us-ascii?Q?eP3R+cjkJ0TZDCggOHDmM7wqEzx1kOfH/OU6NiskxozcvQZAuRbgFpf6tj2Q?=
 =?us-ascii?Q?ALoCdB/9502PmddVwhhgF78I6Yhwkc2XLcX83jJAgd7lCg/EVdHSrkJnwVQO?=
 =?us-ascii?Q?qqKCAgrjh7AFod0uO6rHnkRAe2c0xOKWeWiuEzpODwO1F67osB5qq7TSyntp?=
 =?us-ascii?Q?gbO2TMEtnrJLSZVVnC7C0gI5oTcy4cmTDuy2zpYPNW2xY67r0KNY5p3ZSVHL?=
 =?us-ascii?Q?qGVDjJK1wA5OqdORMABR3ML2ubkbafXw8EZe5ilBrF7f8qU7C6gwi9qzthNz?=
 =?us-ascii?Q?Kohr+OLRFigObk/4B5ozHEKuu3AkCOnCasc9Uz/hiZ3K2aE0tvqomybKUiM3?=
 =?us-ascii?Q?1pSVclAMHbrSXDdm7/WKw3841UMV8nS0+/bDs/8GRKyOcWmNtoLjz2ZwM5MD?=
 =?us-ascii?Q?S1b5iG+4k6ndj30fylUOkW9/VjcRpQiE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mnLwBEcMh4z9vx5sKGbQZdaig/NrjewUWQnxMEc+byEoKcrQicMOb4OytH5p?=
 =?us-ascii?Q?IiqkoUv1vdfBgLZxZTrhRLo7ujZcGw4d+JzTfG6x1ARkmEJIjNRp+JLSl910?=
 =?us-ascii?Q?1+ng1oI4dXG7DHmSnRG8GIa5VHSASr7eYZEMNO7jtjBCfED+kQa7xHCRiEmp?=
 =?us-ascii?Q?ymnxy7bmMQgscvqEgtYok0VDA3ZFd0CVbAm7GFJgmsajDQ2KsTsPHlXLF5o0?=
 =?us-ascii?Q?CEgRXHljgX/uRwOT7k5vxgarHX5PwgsGmWZNPStweI8XH/pdfOExBvLSdudd?=
 =?us-ascii?Q?cnV5FQLyctov5IsCFJWy+UUsigv/BkfnG5cmKN/69R9dW+hMBTxbkYLmu/NY?=
 =?us-ascii?Q?zChVk56rqPKU21gs8PDheYeB8wmRW4JN1i+rBx9SpEFVJlHea1IPyQfIIrRB?=
 =?us-ascii?Q?2N2/VxBaVGsw/GW7DES8r/3AJVt2JFFdYV9Qh9gEUjy2Ti8mkOoE5OC18vOH?=
 =?us-ascii?Q?XeOHe92XVAca0DwMYJkjHCINd3dFMtZ0Oc2wIXnf6ZJumIsvxXD26sI0Oc7C?=
 =?us-ascii?Q?I81EYV7KfJ+1AxnsiAmHabu/nYeSNsYkp6lVkE/GXlndcNNbYRvlj+fQ1VRo?=
 =?us-ascii?Q?Z7a3L5fw8I1Qax0Nm93zkCDBTn1nQDE2djN0sRIDsnqqr5Hd1G/TpeqOz5bR?=
 =?us-ascii?Q?PuPWairSc+WFnDIwSKW8Vb/mmnKw1/nWNdtAQEPDStt5EN9ZbGgWyQUBK5vd?=
 =?us-ascii?Q?rSkpB4H9RqAYM7fI+S0HxbmLKoXyfz1QVFOY1SkqNPkUZ6f/3cJeMiC7wXUN?=
 =?us-ascii?Q?Gr+FrylrZTQ4lrrPqg+QwTRQrhfkXL7znBmgIA93E4PhcLjdfYZP9fRv37s/?=
 =?us-ascii?Q?gTYJWSqpB7emz3e/B07vRKB4yTCVGQQsJjA8Lw09f6ZdiA5Fn1eNN6gF6Wru?=
 =?us-ascii?Q?5rFRrO28aQn/f9vQV82hawdlTlxaV3Lk+ccPn35I8q9om7lMzrZNqdRE2voq?=
 =?us-ascii?Q?BTdXf59LcyXi1OzVh5QlfmmuY4u/6C/EKkG2fJAYnDNe9ss52MA8d1NKg3AC?=
 =?us-ascii?Q?huqvlnbZCaOj6tHiZ+X5dZ3kdaA2PGR+rhhLpvU9ozbrAMyDAt4sZwAta+WF?=
 =?us-ascii?Q?imq6PLz5cIBvXkDRs9Lf1lPyDzVEilR0/FCJ3iHTORPP7SeAQfSKYZZSgH4C?=
 =?us-ascii?Q?ByMjDrpe8IBG1pZfj/MbhAPuCajt+5X4J3g0cvyjd0ORjPI8Ojuennnzm9AZ?=
 =?us-ascii?Q?Bl86bF2l+NSui9rxbDraunvvo7h8Y1PVRlwesFOgvOTogwjfaqy1liVOFP/f?=
 =?us-ascii?Q?4zPz6XQbXeMedunbth40YshoeBLjOnIsHhZ+PbOQ3rmR+L7uZvjHQ+hlAEgB?=
 =?us-ascii?Q?FBjTodv2anuXUItsh/NS22W2YLnXuwriT04x/XWwDN/qxDhjhXO1DpUYBWyg?=
 =?us-ascii?Q?0CHFe3usZAQdTEm3Qa5dMP1AF+Tj42z71ub+YEWqtONKyqPJM7ID7Lay4h11?=
 =?us-ascii?Q?22TdmZTT6gp0IStqXaBn9z+prWg5YP6r2xkigRqWA2xoFACiGQLO5l9qFOyX?=
 =?us-ascii?Q?hqCULYlTuHREeGCpGDmDKAnpmRahsgJDW8MEsfDFRdfYVeX7JGN7GgQbZJW+?=
 =?us-ascii?Q?MzFbpbWzx5Vu/BBgqNdScKG6dm+110pyEWKm22eMVC+s2LQWBn8rZjcqLCAA?=
 =?us-ascii?Q?Sw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bb0a60e7-77f0-4e73-2c56-08de2397a41c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 16:05:33.6027 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4h3gIMGC8ElEeQAWZ/e3+U0JwSe2kbolm/JuSAMVdTBTmlaUjGtRugeq71HrHtKZDey/Fn+B1GKgnFz/XkAAZ2EDIg40htfcKGtaZoqMQys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8499
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

On Tue, Nov 11, 2025 at 02:17:20PM -0800, Stephen Hemminger wrote:
> In theory, lcore and queue could be so large that mbuf pool name
> could overflow. But that can never happen since lcore and queue
> will be in range. Add a check so that static tools know that.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

Again, maybe include the warning omitted by the compiler

Acked-by: Bruce Richardson <bruce.richardson@intel.com>


>  examples/ip_reassembly/main.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/examples/ip_reassembly/main.c b/examples/ip_reassembly/main.c
> index 17ae76d4ba..25b904dbd4 100644
> --- a/examples/ip_reassembly/main.c
> +++ b/examples/ip_reassembly/main.c
> @@ -884,6 +884,13 @@ setup_queue_tbl(struct rx_queue *rxq, uint32_t lcore, uint32_t queue)
>  
>  	nb_mbuf = RTE_MAX(nb_mbuf, (uint32_t)NB_MBUF);
>  
> +	/* Should never happen but check so that pool name won't be too long. */
> +	if (lcore > RTE_MAX_LCORE || queue > RTE_MAX_QUEUES_PER_PORT) {
> +		RTE_LOG(ERR, IP_RSMBL, "invalid lcore %u or queue %u",
> +			lcore, queue);
> +		return -1;
> +	}
> +
>  	snprintf(buf, sizeof(buf), "mbuf_pool_%u_%u", lcore, queue);
>  
>  	rxq->pool = rte_pktmbuf_pool_create(buf, nb_mbuf, MEMPOOL_CACHE_SIZE, 0,
> -- 
> 2.51.0
> 
