Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A30C021AA
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Feb 2025 16:29:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8761B402CF;
	Tue, 18 Feb 2025 17:29:03 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id ADFCC40261
 for <dev@dpdk.org>; Tue, 18 Feb 2025 17:29:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739896141; x=1771432141;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=trPLx3DSEiFJcx5DgPJjeinhPZKDPWnTPzsq8vhRSNY=;
 b=ckICsGb6TTLoPh5laZnSLCTnWZ2duzJOaniF+TaBfIo0AiuwchwFGSBZ
 SgeIs7pyYWEsa6lAchMAZk/O6vlgOuksauDc/BT63zEqsjuRxg2NbwiBD
 DA/ue5NECHmUo/gt+8/K9CScNYbXJ8/eLrNsJNqwzqYoKONuQSts3cAaU
 zgmsC/GymChPHvyAem+qlrtahno+eFNiye654VKcoKB79khBUECPqlI51
 ovKIh7bTck9fnChCK8OjhgYvFLKrLZUbX6+zueNxkpoOB4akDUu7q5dUS
 QADYSFHVdEo7asMI2jyKGvXmdSczvFwnRJRRybezsQnoDZhKkv3ahRtPA Q==;
X-CSE-ConnectionGUID: Zn2hreodTfG9BBeJCzUeRA==
X-CSE-MsgGUID: KlV1CznXSN6rAjUM39IRHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="40310737"
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; d="scan'208";a="40310737"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 08:29:00 -0800
X-CSE-ConnectionGUID: GI7ZOFkjSBO4M6RzlVg65A==
X-CSE-MsgGUID: ELdK/U4HRou3iRAqwXa6ZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="114304889"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 08:29:02 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 18 Feb 2025 08:29:00 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Feb 2025 08:29:00 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Feb 2025 08:28:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EJAxCLFyQ/8uP+IrgngiPWB+4CDJ2jM0dCl2tlK4qxSRG1hIpw2/d9Pc6WY9FPR7rlFqfEBHhxV9g3LoPbEvM/FcpU242j9MH9fWZDxpK7I87KY/uhMJyPSiLyRksJxKlTe2MOB+ZydlVAeZo6spkYUWn942u6pGwC0slOtx9WWc6DUub8PwxoY4kpp819Myc4qJP5IzyPBcyXxJ8w7Y7Xot/1YghfmInZaDXqS+1SKfs/8mIwcxVJ8qxVVcnAaEkdLxuHLWqro0xcmJk3nQEPi4jGFIa0IqLAcyoYys47zuevBGjjX89NmYwHR3NBtU0cTpPPFgTw2Sr0Oxqw16jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mmFbOkWxYtBvqZmKBjV/q4qFjoD+texlWLsdLB5Q3YM=;
 b=KNucRV+H3ggy/KjtNc+6tvJpswmEEkMvIg4OQSxabXKjVnDvyq2V6JRydr27Gmg+SXALyowMoAcThXHv4CmkRxKy1LeGdczF0T3uYDHh9/5/AR14kM8+drJqX7kfy4NSMYdFbymJE54L8uz5Hh6Kwiq0JPV5iTRv9+9zpxyS09SDb3lnQ2TkFEnXyH9xqQAPhz//Z+KIoidOnNns49jI5WKUOjFrTvQXPzR5++o0vKpLPa3VE82sADoXfU2f6t287RSeUy/UYxvGb/X/EI89VUHQJB4uLaWSJitbloSdGHYJHHE1abIuVKrY03lNQMQOtE9NP5onZbeSwmmcylJwLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SJ2PR11MB8322.namprd11.prod.outlook.com (2603:10b6:a03:549::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 16:28:54 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%7]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 16:28:54 +0000
Date: Tue, 18 Feb 2025 16:28:48 +0000
From: Bruce Richardson <bruce.richardson@intel.com>
To: Soumyadeep Hore <soumyadeep.hore@intel.com>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>
Subject: Re: [PATCH v2 2/2] net/intel: add Tx time queue
Message-ID: <Z7S1QPL0qGCdwuF5@bricha3-mobl1.ger.corp.intel.com>
References: <20250207124300.1022523-2-soumyadeep.hore@intel.com>
 <20250212214711.1046777-1-soumyadeep.hore@intel.com>
 <20250212214711.1046777-3-soumyadeep.hore@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250212214711.1046777-3-soumyadeep.hore@intel.com>
X-ClientProxiedBy: DUZPR01CA0083.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::19) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SJ2PR11MB8322:EE_
X-MS-Office365-Filtering-Correlation-Id: 47a87af9-74d1-4728-ffa5-08dd503955c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?L/+f8zL/xgkQ4Pm7JqFQT79hvKX71CLHWVxN6Ner/JKp8HRW/eB9DlngoH+u?=
 =?us-ascii?Q?B770qARSOakNig8eYmTbgUBLW8FiCbLwB6OnMjH/Ye/ND/p3KRBUaepE+6z7?=
 =?us-ascii?Q?WWeuKipxkF+z1smQVknujTfw3TKkZVwKzBks/7FkERQpRI8L/q9QCImUy88/?=
 =?us-ascii?Q?noPCWUbmFDMKYx3AUcUruOTalocoqVSt69DIaqWXUhD6BmbS7bRnIZ78qUh8?=
 =?us-ascii?Q?AmKOLgWW7iqXKQvS2IkM1zL9/UP89kBqrlYzIBslKL1C8dM9/d0sP3mucBON?=
 =?us-ascii?Q?GXI6fFpdp+1qW0hJo4lr7EvfR/ChS126d7nfNNu721oYA7A8+vetuulLdHqZ?=
 =?us-ascii?Q?DnG7Z8rqHhI/MOeHp6xgulzaABxXwelKMRhVxYe3NEAef1cI8L5zA2xxOOg5?=
 =?us-ascii?Q?AdQWulL+kSGBoKEPwsXkoZSJl5e7HXXxfGEQWgqRyGjVfK5gggJKYrbWh1Gl?=
 =?us-ascii?Q?jbLP/zMTvrm60NRMuhvHyyhCFiV+bi7ONJXOU5xP7BDSy1JevARPnKW3ZC1x?=
 =?us-ascii?Q?jWJAHBsk99OTKChYUK2ISlWqCyhvin2rtpwNRYXiFLqDcK7yuEhqcfuH4ypd?=
 =?us-ascii?Q?2HMfGisycX916uyq9hV3ABrnbY05fvEvFZkRWwfgZa3pv7c0XaYlAtm9srg2?=
 =?us-ascii?Q?tZwFcC7haRNo80+tpADBDNKVwsjfIYfqP5nKlgiufgUWU4dYOJxf3K9jZzYY?=
 =?us-ascii?Q?FjpWbt0iv8Vr9EPQJ4uvva7WgxbY0iL2bbUPvfkgBZ+Hir1XFJVYbgOZId7O?=
 =?us-ascii?Q?0P734heZCu7GlH4cNsiEPqoIBdYNS/REJOQES1jhIpHrHQ4bM/a18pGzs9i7?=
 =?us-ascii?Q?ldOKfLuNyeUhr/E/JQslFPfnCDBidpj5HDkT5sxTKF4XAeEcDDOY2KcSNrB3?=
 =?us-ascii?Q?qmrUVq7cop4ad+wQJAfOdl5Wp2WDiAx08W9JoJKY2olirn9qM2asSRJRCbJd?=
 =?us-ascii?Q?GGIVDmi/uTIfpO//0eTrTWwxb/flqJkf/Kr3PfwazOIQt8G0+E08kH5jA+aj?=
 =?us-ascii?Q?4oJHvijdtVWkGqfQGLYdH5EXf0rcE9VMlp7U86w2QDldDmukwFs0Be+eb/Pr?=
 =?us-ascii?Q?EodkUwQ+C5m8shiPCxU3qZ5RAFhXBthaFtRHU8DKf+bg8OYWYSo7FRW6RIbe?=
 =?us-ascii?Q?Kx6GjR9JLUTxj8h8L1dvnEzHB0u8dupYDs9LeGGZcOrNO6weudZvX7k7tRX1?=
 =?us-ascii?Q?THREYMFO4mKFickDWRIru9AZNID3z+Mv76N18F2v7T2uB0LnPAoXn5J0PM6V?=
 =?us-ascii?Q?DwHW1C1GqYEiIVrsToAL3YKmtaGN/JJ6xi5cGkx+tNXVDM3sYn+0m2kqT5Je?=
 =?us-ascii?Q?iEAXdb5d9PtkfLhZSpevjc68N9juBeel0Vo/BAF+kgjqGZYP0Au8+TFA0HuB?=
 =?us-ascii?Q?F7PXX+ZebYMG8ujOH2ZHFb7qYqKT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A/2eSDUl/NEJCAIJ1w2R4iK3Z0g0JEpi7JeyS8zwpcYXahubjAw/T3KfZl37?=
 =?us-ascii?Q?e9Vj0XibgJtm6IzjqdshD+OPDEIbLAk6KV+/AClni5CA2zlnm8bXiCXV5AG4?=
 =?us-ascii?Q?ITbxXoXvIo6WT1NtjnwEgG2ViZfOuL08Z9aQctCrK9yjlx9UuzD3tVFDmYjQ?=
 =?us-ascii?Q?8wZ5DiYyhLtZ7WKHdAiuaaVGVnWFx7RsJysVry1vnE955z0vrU6gUzDhwBtA?=
 =?us-ascii?Q?vCit6D1euVSvK+blzahhlchGuOUqTpP1oDy88x+ktIJ6J7nZRh3vKpVk4EDK?=
 =?us-ascii?Q?/6ic41vSd1hWghle80Jv8W5PNf+p7MUiqUv644M2i5q+3k590JPNH7w02sn1?=
 =?us-ascii?Q?mfJfxcjtpZGHOt49xT5xdYjWwHKqrUM1EoIzZ+rOj/3JquI3ftYWSNZsrftw?=
 =?us-ascii?Q?8FzvgJKj5kRwPG3TRl0vAnnbkL2z1l8FVzEzG/FDp16XK27kOTYdnqXJdVmP?=
 =?us-ascii?Q?IfKFd+lLi8kddbG5lqDWc0lvNtpXwRbdJjT5HQI9vDBgPKXMF3LssN2t1Hcf?=
 =?us-ascii?Q?r7jfRaUgda2G6v3oEAoF/RPkTtHoBDx+wmQIkfVZmfnmPcPLU1Ei5RrH3lRM?=
 =?us-ascii?Q?5Y2bo1qNTHXl0xd33bqPnZGJ8wYSElktq4e1da3irH/m78ARxi1uv+EaabIq?=
 =?us-ascii?Q?4E2HDBN8LPZ91GGk2E5gkGQiQHyGSAWaZKeB7uafPus3GaoOzfBk8Ef4JQh6?=
 =?us-ascii?Q?dpgIPGzzcGrVra+zqiI+wjsZoybslR4sy9MzGf9Gc9dej4XI6kYmzUIRrSH1?=
 =?us-ascii?Q?lB97xLt0bXCbbB7zyahHPX1kA6hXdu9Bxe6jphYEWynXpInY2YhS+Lg1gv89?=
 =?us-ascii?Q?yvD1Sb/E06cu2QyT55P6YiQJVuDN5CGZ1kJpTQ7CvhkM8xfwAoLWJ+B/zEq7?=
 =?us-ascii?Q?/1EI4Qw59IqbyuSjatQN2TtoScrT5USUQmG4/oy2xyOqZtgwqDEiMq7xH35h?=
 =?us-ascii?Q?8n709Sd3HQNNmTHjl3jRZYprDhyfJwPtCbgP3bCVfSFuyrvQyts928zTC2Tq?=
 =?us-ascii?Q?mweetiocCucaerEedNAmY9UuNpU9BiRyrf0RR/p05AXWDNHsuFSCah3DSB3l?=
 =?us-ascii?Q?hoZ+CEkKdhGtDOkX/Nj9Rbok/tQ15627yP/q25Sg+Hey7FKjgdS6td+YTrTv?=
 =?us-ascii?Q?YOaT5mXYPaRjvoqwInPVKhFwfq7tDakCZiBJZYrhHiLm0iFMmpKvLjWccNTO?=
 =?us-ascii?Q?uB8FKoeLjRk5gF49OTX1FJJrVZ+EEZYFtqH0OtU4C7n/mDqplcnyM17f5Lah?=
 =?us-ascii?Q?4sb9QV/p3ZVJhSX42Ggmfc8xAC6kQ0aTjPN1AF49z57ZVuQ8a022JjRvNbUV?=
 =?us-ascii?Q?e3NPZF1DxHEWMT8Cqz2s/pE9PH+880g66XfzEhn25UL7lNNFRQcRPp0OacTl?=
 =?us-ascii?Q?0aNG/LYSXQ2Egn3pTuRStFwH3fx8zLAHD63LRdb7Hte6gSRDe9BSjGp+ftv+?=
 =?us-ascii?Q?PAjgt4WXT/rbE1XGJ8cdeuKAo2Dq05vVwAUUsxC9kadYDonJBJ8V3rSEUfFt?=
 =?us-ascii?Q?kwIU+OB07wqR3Bt7AwKJ3e6uz+xQmYm1yGaf0Ko1QkZPzFH70Z5ZKvveRcL3?=
 =?us-ascii?Q?t8GMYXRxy2Kh2yfHItHzqk57pe84nsplc0SQm8fRijgdur2F/4Efdtk2e+1M?=
 =?us-ascii?Q?rw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 47a87af9-74d1-4728-ffa5-08dd503955c3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 16:28:54.2316 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kWT91QVgOX61ljB6KgP0c/SIMKSWARVfr1betPLsrTrF8gaHcuFGm5QTPQXZ6+Do4Ii4ei5yOzJy6jStYbjV+irDFFu6rV6hkEVUF0u3QiI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8322
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

On Wed, Feb 12, 2025 at 09:47:11PM +0000, Soumyadeep Hore wrote:
> Enabling Tx timestamp queue for supporting Tx time based
> scheduling of packets.
> 

Can you provide more details of this feature and how it can be used, how it
is enabled/disabled etc.

See also comments inline below.

/Bruce

> Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
> ---
>  drivers/net/intel/common/tx.h              |   5 +
>  drivers/net/intel/ice/base/ice_lan_tx_rx.h |   1 +
>  drivers/net/intel/ice/ice_ethdev.h         |   1 +
>  drivers/net/intel/ice/ice_rxtx.c           | 174 +++++++++++++++++++++
>  drivers/net/intel/ice/ice_rxtx.h           |   5 +
>  5 files changed, 186 insertions(+)
> 
> diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
> index d9cf4474fc..f3777fa9e7 100644
> --- a/drivers/net/intel/common/tx.h
> +++ b/drivers/net/intel/common/tx.h
> @@ -35,6 +35,7 @@ struct ci_tx_queue {
>  		volatile struct i40e_tx_desc *i40e_tx_ring;
>  		volatile struct iavf_tx_desc *iavf_tx_ring;
>  		volatile struct ice_tx_desc *ice_tx_ring;
> +		volatile struct ice_ts_desc *ice_tstamp_ring;

This code looks a bit strange to me, can you please check my understanding
of it is correct.
This is a union, so the time stamp ring here is replacing the whole
descriptor ring for the queue? Therefore, we will have some queues which
have regular descriptors and others which have only timestamp descriptors.
Is that correct?

Another minor point is that this union has the elements in alphabetical
order, so ice_ts_desc needs to come before ice_tx_desc.

>  		volatile union ixgbe_adv_tx_desc *ixgbe_tx_ring;
>  	};
>  	volatile uint8_t *qtx_tail;               /* register address of tail */
> @@ -76,6 +77,10 @@ struct ci_tx_queue {
>  	union {
>  		struct { /* ICE driver specific values */
>  			uint32_t q_teid; /* TX schedule node id. */
> +			uint16_t nb_tstamp_desc;	/* number of Timestamp descriptors */
> +			volatile uint8_t *tstamp_tail;	/* value of timestamp tail register */
> +			rte_iova_t tstamp_ring_dma;	/* Timestamp ring DMA address */
> +			uint16_t next_tstamp_id;

You are adding lots of holes into the structure here, please reorder the
fields to reduce the space used by the structure.
Also, do you need the field tstamp_tail? Since ice_tstamp_ring is replacing
ice_tx_ring in the union above, you should be able to just reuse the
existing tail register for this, no?
Similarly for tstamp_ring_dma, can the existing dma address field not be
used.

OVerall, I think rather than expanding out our common tx queue structure,
it may be better to have the queue structure hold a pointer to another
separate tx timestamp structure, allocated separately.

>  		};
>  		struct { /* I40E driver specific values */
>  			uint8_t dcb_tc;
> diff --git a/drivers/net/intel/ice/base/ice_lan_tx_rx.h b/drivers/net/intel/ice/base/ice_lan_tx_rx.h
> index 940c6843d9..edd1137114 100644
> --- a/drivers/net/intel/ice/base/ice_lan_tx_rx.h
> +++ b/drivers/net/intel/ice/base/ice_lan_tx_rx.h
> @@ -1279,6 +1279,7 @@ struct ice_ts_desc {
>  #define ICE_SET_TXTIME_MAX_Q_AMOUNT	127
>  #define ICE_OP_TXTIME_MAX_Q_AMOUNT	2047
>  #define ICE_TXTIME_FETCH_TS_DESC_DFLT	8
> +#define ICE_TXTIME_FETCH_PROFILE_CNT	16
>  
>  /* Tx Time queue context data
>   *

This base code update, adding a define, should be in the previous patch
where all the other base code defines are added.

> diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
> index afe8dae497..9649456771 100644
> --- a/drivers/net/intel/ice/ice_ethdev.h
> +++ b/drivers/net/intel/ice/ice_ethdev.h
> @@ -299,6 +299,7 @@ struct ice_vsi {
>  	uint8_t enabled_tc; /* The traffic class enabled */
>  	uint8_t vlan_anti_spoof_on; /* The VLAN anti-spoofing enabled */
>  	uint8_t vlan_filter_on; /* The VLAN filter enabled */
> +	uint8_t enabled_txpp;	/* TXPP support enabled */

While I realise that "enabled_txpp" matches the "enabled_tc" variable
above, it would read better as "txpp_enabled". You could also have it align
to the previous two members, perhaps: would it work calling it "txpp_on".

>  	/* information about rss configuration */
>  	u32 rss_key_size;
>  	u32 rss_lut_size;
> diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
> index 8dd8644b16..f043ae3aa6 100644
> --- a/drivers/net/intel/ice/ice_rxtx.c
> +++ b/drivers/net/intel/ice/ice_rxtx.c
> @@ -5,6 +5,7 @@
>  #include <ethdev_driver.h>
>  #include <rte_net.h>
>  #include <rte_vect.h>
> +#include <rte_os_shim.h>
>  
>  #include "ice_rxtx.h"
>  #include "ice_rxtx_vec_common.h"
> @@ -741,6 +742,87 @@ ice_rx_queue_stop(struct rte_eth_dev *dev, uint16_t rx_queue_id)
>  	return 0;
>  }
>  
> +/**
> + * ice_setup_txtime_ctx - setup a struct ice_txtime_ctx instance
> + * @ring: The tstamp ring to configure
> + * @txtime_ctx: Pointer to the Tx time queue context structure to be initialized
> + * @txtime_ena: Tx time enable flag, set to true if Tx time should be enabled
> + */
> +static int
> +ice_setup_txtime_ctx(struct ci_tx_queue *txq,
> +		     struct ice_txtime_ctx *txtime_ctx, bool txtime_ena)
> +{
> +	struct ice_vsi *vsi = txq->ice_vsi;
> +	struct ice_hw *hw;
> +
> +	hw = ICE_VSI_TO_HW(vsi);
> +	txtime_ctx->base = txq->tstamp_ring_dma >> ICE_TX_CMPLTNQ_CTX_BASE_S;
> +
> +	/* Tx time Queue Length */
> +	txtime_ctx->qlen = txq->nb_tstamp_desc;
> +
> +	if (txtime_ena)
> +		txtime_ctx->txtime_ena_q = 1;
> +
> +	/* PF number */
> +	txtime_ctx->pf_num = hw->pf_id;
> +
> +	switch (vsi->type) {
> +	case ICE_VSI_LB:
> +	case ICE_VSI_CTRL:
> +	case ICE_VSI_ADI:
> +	case ICE_VSI_PF:
> +		txtime_ctx->vmvf_type = ICE_TLAN_CTX_VMVF_TYPE_PF;
> +		break;
> +	default:
> +		PMD_DRV_LOG(ERR, "Unable to set VMVF type for VSI type %d",
> +			vsi->type);
> +		return -EINVAL;
> +	}
> +
> +	/* make sure the context is associated with the right VSI */
> +	txtime_ctx->src_vsi = ice_get_hw_vsi_num(hw, vsi->idx);
> +
> +
> +	txtime_ctx->ts_res = ICE_TXTIME_CTX_RESOLUTION_128NS;
> +	txtime_ctx->drbell_mode_32 = ICE_TXTIME_CTX_DRBELL_MODE_32;
> +	txtime_ctx->ts_fetch_prof_id = ICE_TXTIME_CTX_FETCH_PROF_ID_0;
> +
> +	return 0;
> +}
> +
> +/**
> + * ice_calc_ts_ring_count - Calculate the number of timestamp descriptors
> + * @hw: pointer to the hardware structure
> + * @tx_desc_count: number of Tx descriptors in the ring
> + *
> + * Return: the number of timestamp descriptors
> + */
> +uint16_t ice_calc_ts_ring_count(struct ice_hw *hw, u16 tx_desc_count)
> +{
> +	uint16_t prof = ICE_TXTIME_CTX_FETCH_PROF_ID_0;
> +	uint16_t max_fetch_desc = 0;
> +	uint16_t fetch;
> +	uint32_t reg;
> +	uint16_t i;
> +
> +	for (i = 0; i < ICE_TXTIME_FETCH_PROFILE_CNT; i++) {
> +		reg = rd32(hw, E830_GLTXTIME_FETCH_PROFILE(prof, 0));
> +		fetch = ((uint32_t)((reg &
> +				E830_GLTXTIME_FETCH_PROFILE_FETCH_TS_DESC_M)
> +				>> rte_bsf64
> +				(E830_GLTXTIME_FETCH_PROFILE_FETCH_TS_DESC_M)));
> +		max_fetch_desc = max(fetch, max_fetch_desc);
> +	}
> +
> +	if (!max_fetch_desc)
> +		max_fetch_desc = ICE_TXTIME_FETCH_TS_DESC_DFLT;
> +
> +	max_fetch_desc = RTE_ALIGN(max_fetch_desc, ICE_REQ_DESC_MULTIPLE);
> +
> +	return tx_desc_count + max_fetch_desc;
> +}
> +
>  int
>  ice_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id)
>  {
> @@ -829,6 +911,29 @@ ice_tx_queue_start(struct rte_eth_dev *dev, uint16_t tx_queue_id)
>  
>  	dev->data->tx_queue_state[tx_queue_id] = RTE_ETH_QUEUE_STATE_STARTED;
>  
> +	if (txq->ice_tstamp_ring) {

Is this meant to be a check for timestamping enabled? Suggest changing to
check the enabled_txpp variable instead, because this condition will be
true for a regular TX ring as well, since the descriptor ring pointer will
be non-null. Same comment applied below also.

> +		struct ice_aqc_set_txtime_qgrp *txtime_qg_buf;
> +		u8 txtime_buf_len = ice_struct_size(txtime_qg_buf, txtimeqs, 1);
> +		struct ice_txtime_ctx txtime_ctx = { 0 };
> +
> +		txtime_qg_buf = ice_malloc(hw, txtime_buf_len);
> +		ice_setup_txtime_ctx(txq, &txtime_ctx,
> +				vsi->enabled_txpp);
> +		ice_set_ctx(hw, (u8 *)&txtime_ctx,
> +			    txtime_qg_buf->txtimeqs[0].txtime_ctx,
> +			    ice_txtime_ctx_info);
> +
> +		txq->tstamp_tail = hw->hw_addr +
> +					E830_GLQTX_TXTIME_DBELL_LSB(tx_queue_id);
> +
> +		err = ice_aq_set_txtimeq(hw, tx_queue_id, 1, txtime_qg_buf,
> +					    txtime_buf_len, NULL);
> +		if (err) {
> +			PMD_DRV_LOG(ERR, "Failed to set Tx Time queue context, error: %d", err);
> +			return err;
> +		}
> +	}
> +
>  	rte_free(txq_elem);
>  	return 0;
>  }
> @@ -1039,6 +1144,22 @@ ice_reset_tx_queue(struct ci_tx_queue *txq)
>  		prev = i;
>  	}
>  
> +	if (txq->ice_tstamp_ring) {
> +		size = sizeof(struct ice_ts_desc) * txq->nb_tstamp_desc;
> +		for (i = 0; i < size; i++)
> +			((volatile char *)txq->ice_tstamp_ring)[i] = 0;
> +
> +		prev = (uint16_t)(txq->nb_tstamp_desc - 1);
> +		for (i = 0; i < txq->nb_tstamp_desc; i++) {
> +			volatile struct ice_ts_desc *tsd = &txq->ice_tstamp_ring[i];
> +			tsd->tx_desc_idx_tstamp = 0;
> +			prev = i;
> +		}
> +
> +		txq->next_tstamp_id = 0;
> +		txq->tstamp_tail = NULL;
> +	}
> +
>  	txq->tx_next_dd = (uint16_t)(txq->tx_rs_thresh - 1);
>  	txq->tx_next_rs = (uint16_t)(txq->tx_rs_thresh - 1);
>  
> @@ -1501,6 +1622,24 @@ ice_tx_queue_setup(struct rte_eth_dev *dev,
>  		return -ENOMEM;
>  	}
>  
> +	if (vsi->type == ICE_VSI_PF && vsi->enabled_txpp) {
> +		const struct rte_memzone *tstamp_z =
> +					rte_eth_dma_zone_reserve(dev, "ice_tstamp_ring",
> +					queue_idx, ring_size, ICE_RING_BASE_ALIGN,
> +				    socket_id);
> +		if (!tstamp_z) {
> +			ice_tx_queue_release(txq);
> +			PMD_INIT_LOG(ERR, "Failed to reserve DMA memory for TX");
> +			return -ENOMEM;
> +		}
> +
> +		txq->nb_tstamp_desc =
> +				    ice_calc_ts_ring_count(ICE_VSI_TO_HW(vsi),
> +							    txq->nb_tx_desc);
> +	} else {
> +		txq->ice_tstamp_ring = NULL;
> +	}
> +
>  	ice_reset_tx_queue(txq);
>  	txq->q_set = true;
>  	dev->data->tx_queues[queue_idx] = txq;
> @@ -3161,6 +3300,41 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
>  		txd->cmd_type_offset_bsz |=
>  			rte_cpu_to_le_64(((uint64_t)td_cmd) <<
>  					 ICE_TXD_QW1_CMD_S);
> +
> +		if (txq->ice_tstamp_ring) {
> +			volatile struct ice_ts_desc *ts_desc;
> +			volatile struct ice_ts_desc *ice_tstamp_ring;
> +			struct timespec sys_time;
> +			uint16_t next_ts_id = txq->next_tstamp_id;
> +			uint64_t ns;
> +			uint32_t tstamp;
> +
> +			clock_gettime(CLOCK_REALTIME, &sys_time);
> +			ns = rte_timespec_to_ns(&sys_time);
> +			tstamp = ns >> ICE_TXTIME_CTX_RESOLUTION_128NS;
> +
> +			ice_tstamp_ring = txq->ice_tstamp_ring;
> +			ts_desc = &ice_tstamp_ring[next_ts_id];
> +			ts_desc->tx_desc_idx_tstamp =
> +						rte_cpu_to_le_32(((uint32_t)tx_id &
> +						ICE_TXTIME_TX_DESC_IDX_M) |
> +						((uint32_t)tstamp << ICE_TXTIME_STAMP_M));
> +
> +			next_ts_id++;
> +			if (next_ts_id == txq->nb_tstamp_desc) {
> +				int fetch = txq->nb_tstamp_desc - txq->nb_tx_desc;
> +
> +				for (next_ts_id = 0; next_ts_id < fetch; next_ts_id++) {
> +					ts_desc = &ice_tstamp_ring[next_ts_id];
> +					ts_desc->tx_desc_idx_tstamp =
> +							rte_cpu_to_le_32(((uint32_t)tx_id &
> +							ICE_TXTIME_TX_DESC_IDX_M) |
> +							((uint32_t)tstamp << ICE_TXTIME_STAMP_M));
> +				}
> +			}
> +			txq->next_tstamp_id = next_ts_id;
> +			ICE_PCI_REG_WRITE(txq->tstamp_tail, next_ts_id);
> +		}
>  	}
>  end_of_tx:
>  	/* update Tail register */
> diff --git a/drivers/net/intel/ice/ice_rxtx.h b/drivers/net/intel/ice/ice_rxtx.h
> index f9293ac6f9..651e146e6d 100644
> --- a/drivers/net/intel/ice/ice_rxtx.h
> +++ b/drivers/net/intel/ice/ice_rxtx.h
> @@ -29,6 +29,10 @@
>  #define ice_rx_flex_desc ice_32b_rx_flex_desc
>  #endif
>  
> +#define ICE_TXTIME_TX_DESC_IDX_M	0x00001fff
> +#define ICE_TXTIME_STAMP_M		12
> +#define ICE_REQ_DESC_MULTIPLE	32
> +
>  #define ICE_SUPPORT_CHAIN_NUM 5
>  
>  #define ICE_TD_CMD                      ICE_TX_DESC_CMD_EOP
> @@ -293,6 +297,7 @@ uint16_t ice_xmit_pkts_vec_avx512_offload(void *tx_queue,
>  int ice_fdir_programming(struct ice_pf *pf, struct ice_fltr_desc *fdir_desc);
>  int ice_tx_done_cleanup(void *txq, uint32_t free_cnt);
>  int ice_get_monitor_addr(void *rx_queue, struct rte_power_monitor_cond *pmc);
> +u16 ice_calc_ts_ring_count(struct ice_hw *hw, u16 tx_desc_count);
>  
>  #define FDIR_PARSING_ENABLE_PER_QUEUE(ad, on) do { \
>  	int i; \
> -- 
> 2.43.0
> 
