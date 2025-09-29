Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B82ACAC5B0
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Sep 2025 12:32:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 38CFE40669;
	Mon, 29 Sep 2025 14:32:27 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 155F140668
 for <dev@dpdk.org>; Mon, 29 Sep 2025 14:32:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759149145; x=1790685145;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=OSm+oYRldNJwAAzIrOXlMwNY4O7h6QR2koevo3r+gUc=;
 b=UOx/Q6iXDtJ/GgqjgOn68uquFZVMQ1IOjwlvJQLFf258bMtkI/8t+5hg
 B8Fe7Jcn6p7JEka0kwzCsgD8L9Z5RoHHtEHyqLs2PImnD6PV4f9TC13+u
 kBdwzLXosNLXHUAN2iFgOle8zrl6HjZCWi5QypDyd3l7DhXNA0IKbhprW
 GJdVtmXcjqE2bgylrzZ7/qIvjw0ofZQwAtrgoHb63hXcLb2kxgLECQFO2
 w2OMnlK8lOkw01qh9NDKWn/K3CqX4iBtTneR43ZiFfXy/02PNWNn+BOa4
 t86axZSBxiK/YwWlDsspxx1IiazepT9xhCT5jJvOKbI2cNIfjBKJiHmZt w==;
X-CSE-ConnectionGUID: uUhrEtRDQFiyHPJ6h83A1w==
X-CSE-MsgGUID: odkeMV4aR7mKn5mX6Sd3wA==
X-IronPort-AV: E=McAfee;i="6800,10657,11567"; a="61304213"
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; d="scan'208";a="61304213"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2025 05:32:24 -0700
X-CSE-ConnectionGUID: myrH5TqjQVSgNazx7ECyuA==
X-CSE-MsgGUID: auxSwx2VTk2o9+VYSleByw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; d="scan'208";a="178164340"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2025 05:32:24 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 05:32:23 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 29 Sep 2025 05:32:23 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.12) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 05:32:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MOuBKBSETHtNnNBBvWmHWXV0PlzekJpuqpETrkRubjoBpdrG9ZjWqGLHoWhPLPqnjysof9hC1TIuclZ2FaGAvNL7guoa10tmBi0ahGpvLQBrKOgUTKKUwIovX1VKQXKhUYMGlP3Z0SGpgR/sjHIgu4+d2NrW6ga3qN1Fv9qnrDSaT9ssO8b8HpR8VEX8VNLSklL7Rt6RPfPliMEfs0uNKMkm6xacOmc8Lr2vP0JIs5zmzMK2DmX2kJxetChsC0fwEMngSOGgqm86UfrVb6NFuUyy7SvkUhVFU2IwMW+yNiNwKt4YaJVzp+ocwgakQlS7DfHaTYmoL1Wt1gk/DWUe7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A8RJTllzYCiVoAQWT6S8b3U56XR4LAzMvdJ5QGseVAg=;
 b=NQgDIelYwG9O7LYFy4KBLgB3G/lq9U8h0NsHXaVRQlvMwCynrdaimeFcTDM3w5z7bT+dV0IxsFYDWE5VmOeHsujxd17g3mQYWhVeXxFBzLJH4xh8et6mQHdgVJ4sfEW54ofYSUDO3y37wyMIv1YlVsbE2QbmuC/ZFqE+Dx3WOMoL4KugOY+wumll0+4yRrFTC6wA4CJOGZhbqWhpmTvfs9KpY4kAo5eGi4GW6Xjb6FmLtJOCOTVx3E4ks4OoZNUnWTg6SDB9oQaqzPiFvHqXf6rpJCReQeUWJgYfT6Grf9oZcnhmlSd0WOyfPCADyst2qg0y1IrTrb3Sj8QfGeBxhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH7PR11MB8009.namprd11.prod.outlook.com (2603:10b6:510:248::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 12:32:19 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9160.015; Mon, 29 Sep 2025
 12:32:19 +0000
Date: Mon, 29 Sep 2025 13:32:15 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: "Shetty, Praveen" <praveen.shetty@intel.com>
CC: <aman.deep.singh@intel.com>, <dev@dpdk.org>, Dhananjay Shukla
 <dhananjay.shukla@intel.com>, atulpatel261194 <Atul.Patel@intel.com>
Subject: Re: [PATCH v3 2/4] net/idpf: add splitq jumbo packet handling
Message-ID: <aNp8T1rYYJHLFoQw@bricha3-mobl1.ger.corp.intel.com>
References: <20250922141058.1390212-2-praveen.shetty@intel.com>
 <20250923125455.1484992-1-praveen.shetty@intel.com>
 <20250923125455.1484992-3-praveen.shetty@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250923125455.1484992-3-praveen.shetty@intel.com>
X-ClientProxiedBy: DB7PR05CA0021.eurprd05.prod.outlook.com
 (2603:10a6:10:36::34) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH7PR11MB8009:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f3b3d41-a20b-43e2-95e9-08ddff543b4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qFcl9LaMJ1WuDQPeSxbwHltsQnSH7UhO2ne1Q5FkdLsRrGu2ZZqT3BoQiQ4b?=
 =?us-ascii?Q?DiUHdIDPIZse21CE5M29XOJP5uS55WauYvSbX+IlkiuoAUJOBLGcYvb+xgCu?=
 =?us-ascii?Q?SaRyYhrapZGAYDZ7FxYivRh639N0PvSYSUeAPNQfS40Jga9tIQajDQjDlITH?=
 =?us-ascii?Q?HyzGTsdi0ZW2c3w0F7cOesSQDjSiL/QemG7UZMuHy4vHfivzS2NUgAXFeL5C?=
 =?us-ascii?Q?Ij/UO2weadEGKt8Uq6GZSjtsnWnje7h7NPb0x9j9wcJ+8g3pOHlo92ygGzjA?=
 =?us-ascii?Q?jcOK6gBCYg/O5gE25XrOgfwIFeIVgIxdR1yCRy9GD1VviOyZooEhzzTeQuBX?=
 =?us-ascii?Q?6HhqsHPEA0bSgjAZ1UgJ1rp03zW4Hg7i9xwkQI0F8H18jyCDyOVLE/f+03+j?=
 =?us-ascii?Q?A86Q5+BfpngnISP509DA22kAPrUI2W18cYQ/z8ndwsr7ofTNBWCbaNXEXeao?=
 =?us-ascii?Q?HjfMXjSGZhbjrKd750A8rS+c7KWO0SDT5oAlp4A2/nRL4sp+T0/FvtSVs3hb?=
 =?us-ascii?Q?wKWqXU0r/rKeDfprDJ6nlvs1Y7ER3EPNZy3PWxe3bEhKZ0NpcpgyAHE+h51k?=
 =?us-ascii?Q?N6ZeMsarFGYnr/qDsJDfY02n0YG6DpNSPLQUelGMmPmTHheo/WbtHJ+qvcg5?=
 =?us-ascii?Q?G7cfcnKwOVFN1hY+pcgaukSJpcWVXFWrTkZVZMp1f02BiQWmnGB/gm25YuYx?=
 =?us-ascii?Q?HBjU9tRYFEGZ/Xznsy0CiB3eEF2q5ujVTUYM6wO0Ush7xi6ouqjmE5U+8Fxz?=
 =?us-ascii?Q?nI2dMsgQHEx28rIgxfiWmkMaKBn3keJp7ytTCdDqaNCjuXfa3f6xqOzAOYWq?=
 =?us-ascii?Q?E7OPIRKDUFarloRUZ5qxaZKJaUWO6FGPQEs/Npi7WdxNMNVYhqgu2p8gbdth?=
 =?us-ascii?Q?MA3fz5JIVEdbHRpWeFLWEUuuVJjHZ3YRSRKGL157Kzis3rF+IJfckFqm8VlY?=
 =?us-ascii?Q?NeP4n98Xr/OUk8d4KlL/pc72AIf25JblEJc2JQb3+szUvrWGw4vWc/+fJstK?=
 =?us-ascii?Q?zWQx00B4Lm/KFt5N8EYhAOhonQL+74VWRxjbpI5bQ+j6fAnXHP5QKp7+n4nW?=
 =?us-ascii?Q?29pLLbwgSbW9g5Dy2AkeQzSc7232zyYRLgii82g9XkTVpgE1hAjuTRShthGh?=
 =?us-ascii?Q?qvQr5RNlqxMSF6khNmih18T4emImLyE/fhgsiiKMBEPvYRFv0RwbDssGJdkj?=
 =?us-ascii?Q?4kZHeCzp2iMRYnklF4DrdsTI+iTBoTJWH4dwbAKaG/I5rVkupaAbgj2gTDIW?=
 =?us-ascii?Q?F3U3U7Y37Vam/lx8aDOvVrIk8Pax86Smi5uXv6GZVo0SNEpSEGEPWnoGgJ+8?=
 =?us-ascii?Q?5M5iHGz7pCBctUkoUNmDRnhgbRSgC9bTtQ70NRkUKW8eyUUzV+3gELYbvyFB?=
 =?us-ascii?Q?v9KrGoCNU9fobR8q0VpVYRGExBi4GBqG+zy1rc/XdcR6y1WjrKmTLQ+KPz3U?=
 =?us-ascii?Q?zOw56t9MvFn3S9o3bcwpjl2xJm3ygSII?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qtUsTUKnc+dEjn2Sc6Kclp54cXdUjoco6u3BaAQN3BmeNU2Ygm+IdfYOZ0/+?=
 =?us-ascii?Q?Ud3NojaSovf//QHRT7CWam10MZUuHOd0tuc7l7lY53rtf4hW3K4diwLgqZ9Y?=
 =?us-ascii?Q?X0g8cyeZW4TlmMN5fyOtyReL2CThX5fnMrXu7zil4diaglfIX2WHqoY+I10q?=
 =?us-ascii?Q?Kv8y7Abup74Pjhx4vESWoxUTg0y8bzgYk9i7V3SCAtSbTGUpRQRWTzLh/PLw?=
 =?us-ascii?Q?oyHilPnTRz+dUyBKIgWyuRHWL6Lrf484BoDLRi0s1zq76bcQ2I/VzfF2J3Hw?=
 =?us-ascii?Q?xoD6OCMaEbZGnzphMPmkmHyxdXy4zHTESqHv75EsVbDODX66THcSco2FBc8j?=
 =?us-ascii?Q?UBGarqdol7jxirc514KxxuW10Au1kU+D6gt5vaW7exIFbkhkj9fFzHWHN2Hn?=
 =?us-ascii?Q?uFHYdV3QYqo7Gjb6iaW4ufUNqgDHy+Nq7yytXnHBOmZ8OlFj1ri8mcYDZQpp?=
 =?us-ascii?Q?lsq8HgsuE2xKCzFHmskxMRFcN9E6LkjdFoDNgxjb4JRciMlqNoz+QJlEOYB4?=
 =?us-ascii?Q?XeDEbCskfzOg6+lgL6uS6+CMCd78MQ7LMe7B81XmWLxY6QiWSJ3X+A2TrwHl?=
 =?us-ascii?Q?eP/t3+KWLeRiOH7U4t2GCZImGKSbwFEmvRnNOL35Qw+gM4OW8vw9RYMpqUyo?=
 =?us-ascii?Q?u8BNa5JqrnNCyw13GOsZVLwxlbyvMdxFecKFancsKdfsHBZn+fZAzL+mhd7Q?=
 =?us-ascii?Q?2Ii9HEBy7f91Sd6b2krO28FiNpcpY4ovBVc4rWJB3+czdS7wua+DSSXu/AXp?=
 =?us-ascii?Q?RJxXsdTjDnr+qBQtCAPEWHyR+/1dvcdFDIIAX8RklBAy6Vu9jYWgbuDnFUD4?=
 =?us-ascii?Q?HzdovJuRcUKzE5/pPdeVQov2PnsFgxuzgtSiYXky9UDG2lpGn8GUXFw4b7vA?=
 =?us-ascii?Q?3LMZzavRgUtDFdNNzTfkaQOqYJUPppEk6Q39/VpHO/SqDgWbdqmkQtpW0zap?=
 =?us-ascii?Q?nHW5hTZeIYSaonicXsGXNClKDypkZswCO/Zc655N992OfhpDpGps1ZpcKbwG?=
 =?us-ascii?Q?ZVFGXrOv9xt6tYc8yBXDXd7vP42VdWFvhzkVmY+BJuXM5TiqccFQrDo94xaJ?=
 =?us-ascii?Q?DLfVoeDB5t05MBXgfviOPXzmaqgmXcIdocyrZSLQ4irOgpkDQICatRoNteW5?=
 =?us-ascii?Q?4q43DbEwaRbRN2prVmecH/+vMNPCBxCGaJ3DiDCjbhwRiR+YQB21kBBf2kEY?=
 =?us-ascii?Q?njN0BFui16h3U1/lmjGaK+DeH3rFyNIf+eWOGIoFTAYUAUKo/6R+QtMGGW62?=
 =?us-ascii?Q?LbvO/76uHtppdJjEXoBwwN6gP3ui1E2zruqppDowGEz4ggCEmRQshYW/bI0B?=
 =?us-ascii?Q?fJlTQ0rhhRUgkybTBWEQSr/Cabe49VLLmc9GNQZ182IBRV2uc4rfVjixcBOd?=
 =?us-ascii?Q?N+I/IhA3owEkuoSyfgxMpX48it4yL56XqvHTIrY0LRHGgT0vdW6S/OYEFwjv?=
 =?us-ascii?Q?ncB9s8FXDq0NSRnUPxQgT+DbGQPkn3DpyDpYT4TNBOw3S4Ke9XH+SzVmmEww?=
 =?us-ascii?Q?lPUW3DSkERCGlpeotNyjbLoV27HQ5XOo81vWO8x9YtdfJVd+bT6lAEEHjO0r?=
 =?us-ascii?Q?/Zo4bzXEZwbyoc7oIeEXEdg23jXzrBwakMZfNGayqi3T8Td5fGRAqZ7PY1hu?=
 =?us-ascii?Q?TQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f3b3d41-a20b-43e2-95e9-08ddff543b4c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 12:32:19.6325 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: judpE6AwQ6VVijKfHt3PKq6ttkhrGPRw0tQ62kybrC/ToA/PA/I4uvevZQHAqmrZfz7+kMW1jwm7hY23O3mqm7W5ziEBAPtz5kLdEU68+cs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8009
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

On Tue, Sep 23, 2025 at 02:54:53PM +0200, Shetty, Praveen wrote:
> From: Praveen Shetty <praveen.shetty@intel.com>
> 
> This patch will add the jumbo packets handling in the
> idpf_dp_splitq_recv_pkts function.
> 
> Signed-off-by: Praveen Shetty <praveen.shetty@intel.com>
> Signed-off-by: Dhananjay Shukla <dhananjay.shukla@intel.com>
> Signed-off-by: atulpatel261194 <Atul.Patel@intel.com>
> ---

One small comment inline below.

/Bruce

>  drivers/net/intel/idpf/idpf_common_rxtx.c | 50 ++++++++++++++++++-----
>  1 file changed, 40 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.c b/drivers/net/intel/idpf/idpf_common_rxtx.c
> index eb25b091d8..412aff8f5f 100644
> --- a/drivers/net/intel/idpf/idpf_common_rxtx.c
> +++ b/drivers/net/intel/idpf/idpf_common_rxtx.c
> @@ -623,10 +623,12 @@ idpf_dp_splitq_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
>  	volatile struct virtchnl2_rx_flex_desc_adv_nic_3 *rx_desc_ring;
>  	volatile struct virtchnl2_rx_flex_desc_adv_nic_3 *rx_desc;
>  	uint16_t pktlen_gen_bufq_id;
> -	struct idpf_rx_queue *rxq;
> +	struct idpf_rx_queue *rxq = rx_queue;
>  	const uint32_t *ptype_tbl;
>  	uint8_t status_err0_qw1;
>  	struct idpf_adapter *ad;
> +	struct rte_mbuf *first_seg = rxq->pkt_first_seg;
> +	struct rte_mbuf *last_seg = rxq->pkt_last_seg;
>  	struct rte_mbuf *rxm;
>  	uint16_t rx_id_bufq1;
>  	uint16_t rx_id_bufq2;
> @@ -659,6 +661,7 @@ idpf_dp_splitq_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
>  
>  		pktlen_gen_bufq_id =
>  			rte_le_to_cpu_16(rx_desc->pktlen_gen_bufq_id);
> +		status_err0_qw1 = rte_le_to_cpu_16(rx_desc->status_err0_qw1);
>  		gen_id = (pktlen_gen_bufq_id &
>  			  VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_M) >>
>  			VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_S;
> @@ -697,16 +700,39 @@ idpf_dp_splitq_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
>  		rxm->pkt_len = pkt_len;
>  		rxm->data_len = pkt_len;
>  		rxm->data_off = RTE_PKTMBUF_HEADROOM;
> +
> +		/*
> +		 * If this is the first buffer of the received packet, set the
> +		 * pointer to the first mbuf of the packet and initialize its
> +		 * context. Otherwise, update the total length and the number
> +		 * of segments of the current scattered packet, and update the
> +		 * pointer to the last mbuf of the current packet.
> +		 */
> +		if (!first_seg) {
> +			first_seg = rxm;
> +			first_seg->nb_segs = 1;
> +			first_seg->pkt_len = pkt_len;
> +		} else {
> +			first_seg->pkt_len =
> +					(uint16_t)(first_seg->pkt_len +
> +							pkt_len);

Since we allow 100 characters per line, does this line really need to be
split into 3? [I realise this is a copy-paste from other drivers, but we
can clean it up as new code here]

> +			first_seg->nb_segs++;
> +			last_seg->next = rxm;
> +		}
> +
> +		if (!(status_err0_qw1 & (1 << VIRTCHNL2_RX_FLEX_DESC_ADV_STATUS0_EOF_S))) {
> +			last_seg = rxm;
> +			continue;
> +		}
> +
>  		rxm->next = NULL;
> -		rxm->nb_segs = 1;
> -		rxm->port = rxq->port_id;
> -		rxm->ol_flags = 0;
> -		rxm->packet_type =
> +		first_seg->port = rxq->port_id;
> +		first_seg->ol_flags = 0;
> +		first_seg->packet_type =
>  			ptype_tbl[(rte_le_to_cpu_16(rx_desc->ptype_err_fflags0) &
>  				   VIRTCHNL2_RX_FLEX_DESC_ADV_PTYPE_M) >>
>  				  VIRTCHNL2_RX_FLEX_DESC_ADV_PTYPE_S];
> -
> -		status_err0_qw1 = rx_desc->status_err0_qw1;
> +		status_err0_qw1 = rte_le_to_cpu_16(rx_desc->status_err0_qw1);
>  		pkt_flags = idpf_splitq_rx_csum_offload(status_err0_qw1);
>  		pkt_flags |= idpf_splitq_rx_rss_offload(rxm, rx_desc);
>  		if (idpf_timestamp_dynflag > 0 &&
> @@ -719,16 +745,20 @@ idpf_dp_splitq_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
>  			*RTE_MBUF_DYNFIELD(rxm,
>  					   idpf_timestamp_dynfield_offset,
>  					   rte_mbuf_timestamp_t *) = ts_ns;
> -			rxm->ol_flags |= idpf_timestamp_dynflag;
> +			first_seg->ol_flags |= idpf_timestamp_dynflag;
>  		}
>  
> -		rxm->ol_flags |= pkt_flags;
> +		first_seg->ol_flags |= pkt_flags;
>  
> -		rx_pkts[nb_rx++] = rxm;
> +		rx_pkts[nb_rx++] = first_seg;
> +
> +		first_seg = NULL;
>  	}
>  
>  	if (nb_rx > 0) {
>  		rxq->rx_tail = rx_id;
> +		rxq->pkt_first_seg = first_seg;
> +		rxq->pkt_last_seg = last_seg;
>  		if (rx_id_bufq1 != rxq->bufq1->rx_next_avail)
>  			rxq->bufq1->rx_next_avail = rx_id_bufq1;
>  		if (rx_id_bufq2 != rxq->bufq2->rx_next_avail)
> -- 
> 2.37.3
> 
