Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17826071B0F
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Nov 2026 11:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=d6jEzwsa;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=AXiJ1Iac
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F04814026F;
	Mon, 16 Nov 2026 12:21:26 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTPS id 40F36400EF;
 Mon, 16 Nov 2026 12:21:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794828086; x=1826364086;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=eHjCEhuEE5OszOE/Jq/MpEUpBz8tgfL0qxmRax27mIQ=;
 b=d6jEzwsaKU6g7EVwoTFyukIDbu9dsC+pQBdIYcYzbHSMMAefS14pGYEq
 1mJWqR7+Fr5LKDjWK8VpGd+FhC6etz4LQ1Q+DPQAmxz7EmaDZVi3S3Zlr
 0MWntTk8tMZycdmHRXJlhp8SBzO+qhVX0oc7oRcSD1/51W2tV6B+OeOq/
 YCubi5r82BEG2ifB7DWayoIi9/FuCfftcRJKj6z8jGhjh0d9S2e2aKulj
 1Idvd/gOEQa5QZHwLT+B0gsqbVpUDmAoSYH89JxKPjxuG2+3SX1KNphS9
 l6nwGle5mwTjg+YkEoNyLq4e/kifXzUrwKeT7LG/ZXdNKyxiZkjIiAi1E A==;
X-CSE-ConnectionGUID: B6azIsolQRO7GUrtlEZObw==
X-CSE-MsgGUID: 6t7LndEoQX25Ko6AFGeaRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11967"; a="3635390"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3635390"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2026 03:21:24 -0800
X-CSE-ConnectionGUID: l1mo2ioiRUCjH4WpmBPtZg==
X-CSE-MsgGUID: nvzQDWiCR1OcHGEllTbTCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="9657654"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2026 03:21:23 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 16 Nov 2026 03:21:23 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 16 Nov 2026 03:21:23 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.66) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 16 Nov 2026 03:21:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QdRi+XFFA1bu//wk8pUiPk6H4dXjExU2gdipizvCLDLira7wbt38TC7lgW7P5XU6t3nE+ORzoXHph7rArsz+5o8vMu8UFO3l4EougH5U7UK6DRh4ZyKPWKrMfyVTScqZbvzC4V59Y242SzV32NHpBDoOZDKyG87Uc6/sXfpWCeOAn2K1b9FFQ0pF3v1d3nAKFVzVJwku0rU1kDEEBoBmqkuDwlwteKI09DScHbK6SpnlXoF35ChtirAUYkc+M1GCKhUQBJ57jFjPqp6U3VdvjjTiTtIZsu1nTi9B7VORNJeNZ/JVP52Tl9o+xa79JzQTC4CX0tIbBhOe2wOafCttPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BRwRoffo4Iw0to5Ri90RkqitmW27/7Ki0Bke3715x+Y=;
 b=YtJYVs52SFcwSIqc2vQ5xVDpWtMMCfsgqfoaEOn6Q2P6VCjI+q2ngbkiWwGbjBQSg3SaRGDmB46ARsEKLJWDsYSgtIlwAc3ZQ+R5xfb1ERTjcevw+pDx/rNMv5q1AV/E9FJxgO8Hbsp0FA+5xmiCrBbabkqpvUqEXdu8D3KxyKAa4Olg/f96vyclREsMXMuhBxo/decStvz+mWb1XtVv4HXw7z8m4SvtnSEx0C97GjEf5r+r917Ah3NA/KEYs0cQ1kfj2+0x8cPBnEz8gwkHRb1/N/Ik1gPp63B41vlr+jOZ8g2GeAfoZMA1+/S/uU6G2mLL2BBfo+iE9Zikjyqqsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BRwRoffo4Iw0to5Ri90RkqitmW27/7Ki0Bke3715x+Y=;
 b=AXiJ1IacSxyMI9wBtVmRoI3+6e5P1dLzdfqtHN5fp3wTjnuPooJP7YQ4F6czeZzRHnHfFiAyBWnNglxQMBb/p1MDiKBAMJsI2SUF4jTZHpaPQnUHQKiaiVxHTiaS3Rr7QuU6qtLHuCyP+L4EZA8FMv4zDQ/UX77zFrADZ+R5wsg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18)
 by MN6PR11MB8171.namprd11.prod.outlook.com (2603:10b6:208:471::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 11:21:20 +0000
Received: from SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9]) by SN7PR11MB8066.namprd11.prod.outlook.com
 ([fe80::983e:d43f:94ff:21f9%6]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 11:21:20 +0000
Date: Mon, 16 Nov 2026 11:21:15 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
CC: <dev@dpdk.org>, <anatoly.burakov@intel.com>,
 <vladimir.medvedkin@intel.com>, <brian.johnson@intel.com>, <stable@dpdk.org>
Subject: Re: [PATCH v3 3/4] doc: fix ixgbe guide
Message-ID: <avrnK9c5wT8nxwMm@bricha3-mobl1.ger.corp.intel.com>
References: <20261114075732.183996-1-sandeep.penigalapati@intel.com>
 <20261114084619.190251-1-sandeep.penigalapati@intel.com>
 <20261114084619.190251-4-sandeep.penigalapati@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261114084619.190251-4-sandeep.penigalapati@intel.com>
X-ClientProxiedBy: DU2PR04CA0250.eurprd04.prod.outlook.com
 (2603:10a6:10:28e::15) To SN7PR11MB8066.namprd11.prod.outlook.com
 (2603:10b6:806:2df::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8066:EE_|MN6PR11MB8171:EE_
X-MS-Office365-Filtering-Correlation-Id: eee023e2-95b2-4d5b-c315-08df43d3bcfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|22082099003|18002099003|261009223027099003|3023799007|11063799006|4143699003|56012099006|261102123227099003|261026121527099003|261021135927099003|261021121427099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info: oEhLcWeFOwBueiKk2CgsqmI6bCm83HVvRMz5ShwyQeBdG/W3xDLsszPSVZIm27ymrY9v7P5UC7Al859yR1AiqmZ46l3fdY5KSWM74EJQbqHG0tyXHyurhgsAxCm10NXFMqdPufyHkFjGAwP9Dpml4cixDTlf7lA4DpMbLeYHe/ZQczQc9xxgkl3gahT1xQctGCFdAnNDsuyO/xlBldwzY2zYk98Bhz0uFSC8Z1EoJ3gyWDVWjiViClt+K6kk/2Hmxakj4wel+XDmcyrt/WXhLiNJp8DApV6X59+cI6xCUYfRLjh9rrn1r1PaZcfCdbH9WWGJasfKqmpWNVoL+SlcCgOnSYrOc8OQxl8+FmZJuvDcvKJktKbauks8hMrJpgBb8XPdOs7bZlhtyTa17jcNxMx/Vz4AmMvc/BNnKKo2IiHOMrCynldEW7djWyww2mjpnGxFP0S1CPfOH61gUPuzR7LBJ+5pPgj1oNzFwq/ts+0opq5z/S+F28DeDjRo+AIjc5+LjcJxtVAqtTecuLMys31ipI7NeYNy1IkdLHC3Bven7fsWOgFfZV4sBDjCLjZ3yVL2bZ+NUYtvA7CKw57NCa7qJOvmMa9+HD+zMukPD7ELh2mH7qP7107bQkiJqTLOvLu6c34/Cg34eIfMkrtGJyq0i/DY4DdG4Q0N+joj0ss=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB8066.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(22082099003)(18002099003)(261009223027099003)(3023799007)(11063799006)(4143699003)(56012099006)(261102123227099003)(261026121527099003)(261021135927099003)(261021121427099003)(261021123027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RBKRYXsCzj1ZG+ROmGTBctrUHBcajSdQUGHF7ZiT7uiVv37H0e6aVAmvtZ5c?=
 =?us-ascii?Q?ZNEnalGd2sDdqT/90ZwDL2DH26kpE8Lq+DE4kxKzX7yo4lQK6nqsLOxLOGBy?=
 =?us-ascii?Q?0y1Iz8yRlNW79XuWlrG2G1Eq7+TqKQJVghwTyUNHUArqv5qcadv3GwnmBkcF?=
 =?us-ascii?Q?OcFCuEUNm2+ZD2THiBVeJWZUakNq8cImPEN02nc+87gHEtdyFqKFbytw70Mt?=
 =?us-ascii?Q?WgDElB9wB8Di6FT6AQHZg8ISUpQlbEYqf6vcbCrI6IMx5UpIbu5pgqyJ2+rK?=
 =?us-ascii?Q?QVwosQn8UtPxdZwbcorXiKJDCTiV7PJ7W0Udc/W0hKVXIPWJXZFmo+FhSxeJ?=
 =?us-ascii?Q?YuBArOxqq2NozjgmqIIrzElvdz+pCBo86qzfC100/7VTYwJeghz8gHEGIojl?=
 =?us-ascii?Q?Hz5XwqX4PRlCqoQPHA75d8danXP92xjgjVpsHUpDOCOCBGi7itpEtPJQ9tyz?=
 =?us-ascii?Q?MKbJObaVzTL22YekAMKvY0oUW2/2nXQkvEJMn/iteb3hEx9f9k+TVG4xWCJK?=
 =?us-ascii?Q?9bccnzMTYhYAcyl4yeLKs9+4VJhxGNPyLwggRLpWtxJck87oIxqFaA18Z5jt?=
 =?us-ascii?Q?7U8HUq1XuymQj54/880fA6bdB8408yYaVWfgnuVlWkiLwXHztz2T5CUnYYMO?=
 =?us-ascii?Q?KvWC36MJMht0OF5Oqdmpy9GuJLNEkjxGrilrOrGBE/jrd25vpcHHOd30ER6L?=
 =?us-ascii?Q?qnYTDo0Apl2DxB0sOTL67Sko87mDmdf+kydfplUeOOnG84fIs20csv4j2PMk?=
 =?us-ascii?Q?CB8aZ8MJhyrKbE/+GS3DQXI92z2vCMpTv9fGliLsnTNSwrl4azZQghpLvFaV?=
 =?us-ascii?Q?RVGVL2vR46dLEhwHSOpAv3z3VX5UI7mKuaRzISGz8b6TUNDtsF9F+qPbnFV2?=
 =?us-ascii?Q?cfa4Pcdo8lIlhb9G9hRE4+iDGCWIP3AQjAaOtJQH/IsdM1og8Xs7nuM7a6qn?=
 =?us-ascii?Q?4nJRCQBWtfLVrW58y5XVxGiQC2Man2tJiz9zmOwZ8tUeNBwF3vTPW9lqRYZd?=
 =?us-ascii?Q?2uTqUrgQJWLtC52wvO6WDv2leXYP0CYAYYD27sSsy2ABX1O9mDOV9j7/NjZp?=
 =?us-ascii?Q?8dLDA/EUWonxWaHT3IZi1NRqXFeYmmmH0bzfP6v/9DAWoSqPBCnhKd2BRu1k?=
 =?us-ascii?Q?y5lqAJmJFh1usITzppDxYmqIVFWovbCB7jJS6pbnpq0J/ugdh+IZZL2ZK5Lp?=
 =?us-ascii?Q?mbqbzrVsElgUCGt19LEuFTrN+LM9AbSVf0gOzQla5DRkVMTA4aNlOyzS9oyg?=
 =?us-ascii?Q?gt0lfUZexpei3O2IHFL9+KSXA90UUhzq7atVzBjgQ+ReNn32C9mrZgenwsrH?=
 =?us-ascii?Q?Q6N1BLoA7h+9T0CIB92gUxQJK132rtDUqbiUolsbz1F410t4qEKwDko6GktX?=
 =?us-ascii?Q?+QebrIeJUOqofIH+3kSu9WqJESHp1Bj3m0XunlRQerUClIuR3RAXjwy+ezOY?=
 =?us-ascii?Q?liJa85rD/GKttZNgstf717OV14SE3hzV10UwIdh/CR6INMJ9wOPORLg6WBcu?=
 =?us-ascii?Q?J5Zu246454LS6PVzGWOGYRlPMrdQMAv8cWnx7HmGpje5KhGwqJPVqI58Q0Ve?=
 =?us-ascii?Q?DKRQSDFu0gssLfKgFb2lzmpXPGHR9mAnJoge/tGVEJ3hjyrkMDP/6kPT+2XO?=
 =?us-ascii?Q?rhcl7pvGiQWiklyH84cXKmI8lu+LOxfEdKMDSWZBccnxiodIU/x/Zb1JSf88?=
 =?us-ascii?Q?9CDdsYISQrKiFU03dyJWZBH8FGhy4TrNsckno9uvIkDYOCTzcG1xD62QpMiI?=
 =?us-ascii?Q?qnvWjBEpidmGr7qeU/j9z0961JKMuWw=3D?=
X-Exchange-RoutingPolicyChecked: ZK0/2ZRGlrjAntBEQJ8wAYCcZsIodCqGThSBF0j6PWAwVMkOQykiW/0aC+HyYZ05JJ7gmSACPgINIg6dZUEZgG8h67wqnNO08fdZ4r54qsK07WYTxIp3jrT8sCBISwqH0acHFNxe04Ro0kB11x7tVtPYUDfCX7ipgDutcOdGRpPdRKXZjw2bEChi0TK5CIaw3l3sM1SYhVpSwNf6T6JEcs+MfSFWW5DYb0xx5F4F2HaFX6cJpMvMM6Cms5qfWGIw5HKI2v8ziFtG9nbQfCBya7hCnxskaRm68aRYLM0oFpV/Rsj68+xNXN57fPPL806tRMQTnfv7tG5X9EprPnVGEQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: eee023e2-95b2-4d5b-c315-08df43d3bcfc
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8066.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 11:21:20.0046 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1qBLvblWd6wSF4iCsWnoWAMe/kogVBKQ08mYgCDsCtal/QiCycaNIPxTSNVVkZWTw35T954SLgSCdWGLx4ZimQMk0i6+9fkmykSCNd60kQc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8171
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

On Sat, Nov 14, 2026 at 08:46:18AM +0000, Sandeep Penigalapati wrote:
> Correct several errors in the ixgbe guide:
> 
> - use the current IXGBE_RX_MAX_BURST, IXGBE_TX_MAX_BURST and
>   IXGBE_TX_MAX_FREE_BUF_SZ macro names.
> - add the missing device BDF to the fiber_sdp3_no_tx_disable example.
> - clarify the bypass command examples (add the missing "testpmd>"
>   prompt and the "bypass enabled NIC" wording).
> - minor grammar and spacing fixes.
> 
> Fixes: 972e365bfe7a ("doc: nics guide")
> Fixes: 125f6edbe8f3 ("doc: add statistics read frequency to ixgbe guide")
> Fixes: e435197a5fc2 ("net/ixgbe: remove unnecessary macro")
> Fixes: 0f9fb100f6c6 ("net/ixgbe: add option for link up check on pin SDP3")
> Fixes: 0100a038fa49 ("net/ixgbe: move testpmd commands")
> Fixes: 3ab51564e9a5 ("net/ixgbe: move bypass init in a testpmd command")
> Fixes: 9fd2193e56a5 ("net/ixgbe: increase max Rx/Tx descriptors")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
> ---
>  doc/guides/nics/ixgbe.rst | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

> diff --git a/doc/guides/nics/ixgbe.rst b/doc/guides/nics/ixgbe.rst
> index 1d14e292e2..d13ccac520 100644
> --- a/doc/guides/nics/ixgbe.rst
> +++ b/doc/guides/nics/ixgbe.rst

<snip>
> @@ -229,14 +229,14 @@ Prerequisite
>  ^^^^^^^^^^^^
>  
>  The only prerequisite is related to tx_rs_thresh.
> -The tx_rs_thresh value must be greater than or equal to RTE_PMD_IXGBE_TX_MAX_BURST,
> -but less or equal to RTE_IXGBE_TX_MAX_FREE_BUF_SZ.
> +The tx_rs_thresh value must be greater than or equal to IXGBE_TX_MAX_BURST,
> +but less or equal to IXGBE_TX_MAX_FREE_BUF_SZ.

s/less/less than/

>  Consequently, by default the tx_rs_thresh value is in the range 32 to 64.
>  
