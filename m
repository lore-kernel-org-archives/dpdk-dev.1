Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E9F8CCF9F0
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 17:11:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3EE974028D;
	Wed, 29 Oct 2025 18:11:46 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 98A1540150;
 Wed, 29 Oct 2025 18:11:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761757905; x=1793293905;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=AQ5+afqqQB2fgMd+aaGn1AUK81ZGOIrxFMmvVOrD6MQ=;
 b=drgnYcUqaXGq1A1FSIjLfHrGNYc1ZqK8lsyUBiHfuW24vCgybdIbcAZU
 7jO62vjCG5roejyVuYxufMtqynpW759cvODMVzxg28tJlwKV3M8DZoq3A
 TNYFp7SXIhbQOBH66xkVy9k1kxvEpZOdlzEl4TSATDWR3D6vfna/mh4oi
 0qXdMf94+r7CVa6CzsZVlIUkyGb8Yv9onle9l3jDD3YA0dvqG5Npx8nQF
 qDpzNerPlThgpf20iiGtQ8sHsy9my09Ns9BEoj6mD7oOTs7C18OTKaBwv
 wJm8AS7hf86r4CRK2BamhXy+oWQJRhbDK0RVpOgwybKJQsKIML0NVoy+F w==;
X-CSE-ConnectionGUID: VvW3hN6YTpmzGm/wxfioXQ==
X-CSE-MsgGUID: LmN2VME0QdyN1xKg60T52A==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="63983625"
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; d="scan'208";a="63983625"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2025 10:11:44 -0700
X-CSE-ConnectionGUID: KvISTRwvTVOKC/jGxl+qiw==
X-CSE-MsgGUID: Pzj/75C1T7+nV5KNZctMJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; d="scan'208";a="209313514"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2025 10:11:43 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 10:11:43 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 29 Oct 2025 10:11:43 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.19) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 10:11:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IL1qupqAypNX2dbe+U0NVzRVe8LMth3nvk/41rXUee7vLDV7dGGKW2W2WSdrmYS6bhDJ7EsHqNOBgYDxKzwTpI0oNnTUPZZo2tzkip5XXDWx70j7/JN3TfcDLjFWjZ+c3bmkEAoVcTfuNZl9A3Wgi5S45gx0Fl65SnWaA/M0ZWOrPOloshbJckenNQWPGUjs9GwCB2hx2B0bPiR3Xppn87ZOeyXlPx7S/6JP9LI4AddUZEjSNP1TU4siAGKcfbDMH+26QsJfMrruy/m7R97uwpxv9g4+Gbv5Hzat71LFG4uBMX9DYLjwmvM6r2SQiUCmVP3EKzgBS6EqBK20LS0p0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQanUD9OsHY8hxH5tltUm1iwgJxiv8adwDENWP9+Tjg=;
 b=E77iI3hTEt4DIAbV6zhOIE2fSoh+z7cG8EBWgIsmpKj0N0rFmBlwSmcmQAf04hh8m7ve0TdDFayC3Anxlw4z9ARQyJqq4gxMRh5F2UcvDzUOLk6y8FZKAZyPcagJ+3X0RFUN0D8wnJClszcWuQ0gYzFWyzh3Ej7/3VsosZ8+Gz2QJOCMVf6yp+6GcuKI1VIjo+G64CE83rlX/1VLC2/3PeqYl/wFWYoie96n0ZiMPGXYJaYcDWG+d7nWqSVtZbnf6K0pF2EgppJeupt2B0z2R1Q3h0sOexLKi4Gw0pXYVFcibyFXozGIN/eu1jgnlMc7hbSKOelIVrUkM4ocQn2gQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by LV4PR11MB9515.namprd11.prod.outlook.com (2603:10b6:408:2e3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 17:11:40 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 17:11:40 +0000
Date: Wed, 29 Oct 2025 17:11:35 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Soumyadeep Hore <soumyadeep.hore@intel.com>
CC: <dev@dpdk.org>, <rajesh3.kumar@intel.com>, <aman.deep.singh@intel.com>,
 <manoj.kumar.subbarao@intel.com>, <stable@dpdk.org>
Subject: Re: [PATCH v1 2/3] net/ice: fix PTP clock corruption with TxPP
Message-ID: <aQJKx_46QJthcUbC@bricha3-mobl1.ger.corp.intel.com>
References: <20251027182801.191295-1-soumyadeep.hore@intel.com>
 <20251027182801.191295-3-soumyadeep.hore@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251027182801.191295-3-soumyadeep.hore@intel.com>
X-ClientProxiedBy: DUZPR01CA0026.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::20) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|LV4PR11MB9515:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bec044e-cff4-4d2c-a666-08de170e39f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4fMttm+Y9LKK5oD7GQSXApuyuSmir+cEW9gJoHRpivpOdRsAc+TBA7r+qu98?=
 =?us-ascii?Q?t4hxjaO5VAdC3TQLzLsNqVybYfzWAbNck+lmCDo+eJ16MwLlGNqTCQ4ei8RR?=
 =?us-ascii?Q?aQoCsDHpKmL2FpzAadhSLqVlLvmKv3T4oOdrp2dc0cD2huYFrZvk16UUrxb1?=
 =?us-ascii?Q?9+NQzZjtm3MgOE25lJFBReiq09gtAfgwTws9RPibRUlCPxkL/jHiqW8uax2E?=
 =?us-ascii?Q?ADP5ZJ28xMScBBRtyHJpkH40SG5LZ81QUJVG+uuKtmBD8rY4bWT2lrF1TFBY?=
 =?us-ascii?Q?YJmLAiQhH++9aeLTmE3nOKorr/vAc0AQq4iZv00h6UntN9TdldQ+98X0eRFl?=
 =?us-ascii?Q?V0iYq/61xuT0Mz9p0dBDFhpmqrZUYyKhtC5GOCe9dOJpozQkGeSFWpOn5eMu?=
 =?us-ascii?Q?FGMWoNxU4v9Et+FuNji8kiusfeZI/HHbpkOt/OA7bj8BXzSk8e2Fmt+gr9WW?=
 =?us-ascii?Q?z+w1HCkXQET0xbDcpAIbhPu35I6sgZF4z23XqzMMI8+VMfsGD0phM2iQEEor?=
 =?us-ascii?Q?twOaEh7Yp9JqaZvPD7rG65rpJOBxy011iMF7fku4TSJ5rifkK59QfW3PkSUq?=
 =?us-ascii?Q?//yS4TyQnHepPnBH9Z5hsGN8Hprk2AQf3SfOZ1etgraDuWKlilOnnIJTLmBe?=
 =?us-ascii?Q?HqE/+BvjuHlUTnXw4A+pXJjA7rqtPvn+bkHG5X7e3ZysOg5YS1zoso83A4hT?=
 =?us-ascii?Q?oBGNhJVNLkTLg1SpQFwQLoZlHG+FRkCG+yRiCAu9Vjz490tExzCtEARbRBlA?=
 =?us-ascii?Q?gqNNY/HxM5FWljy+afIJ8ZudXOVkOlnbin4QVLZ8MVGbnrAWC6jx2LU7/eoF?=
 =?us-ascii?Q?2Ql3/DFEvCL5YGFoMoSfxTDOFhVgaUtwWibFBMiaS5DYeMBA5AD+F75AXDOP?=
 =?us-ascii?Q?Noa2Wk4RAHYknkQctoakXE0I11vf9DrA9o5AWgcyIKb38PHDfZpTvfu205WG?=
 =?us-ascii?Q?CDvbpKrnE2vENT0QD0S9+iler8dcyOX2sEOvIBfgjUNI+6Im+fOwvJnMWLz3?=
 =?us-ascii?Q?bquGMCwXC9ZPGXAPFuyMdwisu+SY+v6zNiV09NYiBAVEcyWH5y5clTmJ76RL?=
 =?us-ascii?Q?Mq0t+kupBEPv4ikQxFRqOkHFGjpwnQ0iCPT8OvkJRpbeRJhyMZlbJwDUbsm/?=
 =?us-ascii?Q?rPICbqLgEjl2lRtKhfhaZYxjAkFZDz39NUSCPy2LRb6ytH2Cr6B859kcIcwX?=
 =?us-ascii?Q?IJWutgYOBHTzKqiz64JbZKuivZ/o6v7twuN474noTKWuQReT6qKHxYw9XZot?=
 =?us-ascii?Q?zguQbB590irDvo1/8hAG8NVCchWKzPhhux4Ra5CIbZly8JUw8KJ5RHizoTb1?=
 =?us-ascii?Q?yDj77CG0EgmjZIm9kJ4JLUEWLqS924hnNU9HfYxgpI98dSgQEMe/NaIzBuk1?=
 =?us-ascii?Q?MnN9oKSC9q1RuYCpnOC7syYrE0Lf3at6mby0DtR1Ob9hhfOHVrlXOtAhTe1E?=
 =?us-ascii?Q?ek5X0cBqRk/GzhlWzI89CRMZv/XJGXjA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xNShmw+uLa2tpJ8KH56zEiSQHuDU76r8WirYswfvJMZYRhKVUN+7IiQ997yQ?=
 =?us-ascii?Q?MASta2SZbSgl5UYP6PG6FYgMaJirSVNNdLKLiiuiOCT+kBUNR1rJCBZN3SJf?=
 =?us-ascii?Q?xYt2Q1YHlZiVmaMM/ZgBxYXDBuscyfFEl55tzEEzQItdCK8oTkQzPo5aX2pA?=
 =?us-ascii?Q?vz+gjNshipx3OXOWQrJ6tbhg+QE6uBnMoHhb8iaCp9daaOQ+GqSxhUBxGrGb?=
 =?us-ascii?Q?OJjdmQB+Y+lA90wxxxUeq20PZncOabkvvp6DKUr+GihHiYHuizk/E7puQfT8?=
 =?us-ascii?Q?zSQdefYLyVbiBH+lB7To5hEMcPVoveCdDCKd5JcVVKg4vaxKoqGoNaNIpRsG?=
 =?us-ascii?Q?Y5PmtmEAT45CKXJOIoFnlk2rZiamcTjN8a7Ek6ilopPhHu+0s4PFKrLxEaZr?=
 =?us-ascii?Q?/14TGD4k5JoBMUImayIFfZkStKRvD60mj85zd6gCcvG2Ork9CJfiPGPUswrw?=
 =?us-ascii?Q?ZpJrnMMN+Me/fTVQ7mDMsf/HHkhWQh6Z+tyKFLMgB/EbJjebTX6CIJ/q9qxQ?=
 =?us-ascii?Q?Vtx6wGlt8c1bKpQgPkp+GoAu+gAcHcI9UrSoZCvA1PTimenb1V6v0OX9kB9N?=
 =?us-ascii?Q?y7/KX2h+W2H6Sp7Ov1EvszEuuudxJ5ti/GtBA/zQhrhpcFmLPYGtQI5yesNf?=
 =?us-ascii?Q?/rvK9x26Asa2Ev7sVaKTEdgcP2WkTzleurPiQ7RVBudcBOM82CRux8qx1+R3?=
 =?us-ascii?Q?QGq2KM4tc9xc9Spf4L67yH8U9uftYtcnkkfhpfQ68ricDr5AjOlLGcIMfMFD?=
 =?us-ascii?Q?D5uerWrcHeDnX1JKe4M+a/Vx9PnTz+ozY/q3pFyLMDAK3CimE3GXikZY6Yw2?=
 =?us-ascii?Q?VuWONm9CztG92iGznAm3pM6VW2Ls1+bWvhJqmhpjRxfu52mtUwRHFzsxS1L4?=
 =?us-ascii?Q?23P5aQT3SdtJoDfK+q4HZTf2Wusw736ldxlEDB04m5sQgee5t7mtkcQ4ImON?=
 =?us-ascii?Q?lBQ+9GW0RMXe2AXD6PMHRCkTNaX2LkdI6d9RsEqSjv6F7gY8IlGvk4LEBXiT?=
 =?us-ascii?Q?j5ccBfoQJV/IihFsfutAVTpzKpmshSb3mjpxkPYXQvs5NFQ8LG1yJChCEWcY?=
 =?us-ascii?Q?WAFaOeDSEKRgVxGijEhnn+qzLzoXmijWLe18k/A9bREDfoUEC3m+DEPOmtI/?=
 =?us-ascii?Q?rE7P1EzKByttPnMnu+A/AiAY8GQUYKztFB+hXfDhaFbS+aNOyBdvS24iChSF?=
 =?us-ascii?Q?LA15MOimORsPFpBh6LLy1PV+RCCWX9ep7vQoQcHaNUF9FBvoethqHOLmWLdJ?=
 =?us-ascii?Q?C0TFt4A+BO2iTMcaWRPpKXfbOpt4hQLCnADeUizwGg0rKbp+ckvxhNyZdhGx?=
 =?us-ascii?Q?Pnv9ir7s9y4U2EJUUNptb7gGJRTYreCi8uVMzu7IcIoIqh2cSsYazSXoVFpH?=
 =?us-ascii?Q?6Lv3bZkmUqF5ATzwj+4YLb89whjZ6qAv2bIi8Lf7ThApsAdYe3i71ilTSRRa?=
 =?us-ascii?Q?iJVgvKmu+wR9u9tdBAzjLZxOA7eA+J7sFurIG00wlmuND1GDNOBldhOsl9J2?=
 =?us-ascii?Q?DmDSXBBd6Y6CbYw9D18oWapjl/vG3oFj0+Edvp/7I3MW8TztHnXl8IxhmyMe?=
 =?us-ascii?Q?b3mwoUhxQdu2HePaSFyptii9OZ6dG1jFrpVkWA7uVCEKMfNohaWCSkw5/bSg?=
 =?us-ascii?Q?tQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bec044e-cff4-4d2c-a666-08de170e39f9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 17:11:40.6295 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PqAS5k/206GF3Z0PrhIK5ksDhjplMSDgZEptX3yL1BrwLlFl9bQ53oIqFCQyXTCGgfI/YbtivWgSnfiZG16Br1eeMZK44mGZAGUaBBamRss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR11MB9515
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

On Mon, Oct 27, 2025 at 02:28:00PM -0400, Soumyadeep Hore wrote:
> On enabling TxPP PTP clock was getting corrupted as timesync was enabled
> on during setup. Currently timesync will be enabled during start of tx
> queue, hence enabling PHC clock to get updated on starting and stopping
> of ports.

Can you clarify in a bit more detail, how did enabling the timesync during
setup corrupt the clock, and how does enabling it only on start fix it?

> 
> Fixes: 0b6ff09a1f19 ("net/intel: support Tx packet pacing for E830")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
> ---
>  drivers/net/intel/ice/ice_rxtx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
> index 33d82cd46d..7473d45260 100644
> --- a/drivers/net/intel/ice/ice_rxtx.c
> +++ b/drivers/net/intel/ice/ice_rxtx.c
> @@ -908,6 +908,7 @@ ice_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id)
>  			rte_free(txq_elem);
>  			return err;
>  		}
> +		dev->dev_ops->timesync_enable(dev);
>  	} else {
>  		txq->qtx_tail = hw->hw_addr + QTX_COMM_DBELL(txq->reg_idx);
>  
> @@ -1671,7 +1672,6 @@ ice_tx_queue_setup(struct rte_eth_dev *dev,
>  			PMD_INIT_LOG(ERR, "Cannot register Tx mbuf field/flag for timestamp");
>  			return -EINVAL;
>  		}
> -		dev->dev_ops->timesync_enable(dev);
>  
>  		txq->tsq->nb_ts_desc = ice_calc_ts_ring_count(ICE_VSI_TO_HW(vsi), txq->nb_tx_desc);
>  		ring_size = sizeof(struct ice_ts_desc) * txq->tsq->nb_ts_desc;
> -- 
> 2.47.1
> 
