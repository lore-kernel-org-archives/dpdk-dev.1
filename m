Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B614DC4451B
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Jul 2026 17:23:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E2B0740653;
	Fri, 17 Jul 2026 19:22:59 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 21D1940297;
 Fri, 17 Jul 2026 19:22:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784308979; x=1815844979;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=1dc3dbgq7mMRb7Oazm3j9v0nmtebEvbJk01PpL2HSjs=;
 b=bmP8Kf129r8l/XxjCZ4GicrefnB5tjn6b6yFLp3lQ51QLiOIoSBRlf4j
 +AEFC9RLEC1ct/bS60J9nJjUuHc39x0d/D5TSZiM5JokWM72cvn3SGaq3
 xt7qZTC/OfMw7S8XZ4JGzUUa4TO43mCMOG9Kwvt+Z9VmUt3uIA+aRlihI
 oZnRAz6ZqbecaobBKVm/nKEI3EkzIM0KgRZDSSMrYYi0DJIVhljNAxOBN
 SPjsUZs7diPTnVbU4N9V/6e2+5J42luPOKbGq8/jM/JiJ4361ILD9mZdr
 QRJR4rH1IPvxSGAALHS/N1Jzi4nHf1//Jz530gc9DcEW3mHhJThwUMzYO A==;
X-CSE-ConnectionGUID: xKf2DNEaRhOVzvehtA6fjg==
X-CSE-MsgGUID: FdVteq+iS2a6Ztmv8J/xTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11849"; a="110536090"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; d="scan'208";a="110536090"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2026 10:22:57 -0700
X-CSE-ConnectionGUID: 72+aloYmTuygyZJr9J+yMQ==
X-CSE-MsgGUID: LVOxqsFUTOaSfjeTm9Anjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; d="scan'208";a="253430965"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2026 10:22:56 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 17 Jul 2026 10:22:55 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 17 Jul 2026 10:22:55 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.25) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 17 Jul 2026 10:22:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JYpvovDVgYV8W213vYvHD6wTUPHKW/mVZjUnrZdVopMncnRQZvc7O2XxaSiQSgsSYZ9VqLPu4JJD/M6bOj26qPaVliN1GEKy5pkbq/DVNuZBvoPZQZWDtuj71xS6zaLs/r3O2wIxiUhVAL8sg0Zx9y3WJZz77Zb21DWiFjeMDsf1hbrbWgf2Xl34u253RDV7xlElWGWyB3RkqTA/wB+v64iowwchy0pM6ZCwUD/WrNVdPudZm/vhXPxantqT27iH3WQh2/IeNQ/dSF3Qyu21sf1XkXcwtH2fGck4XJD6m6bEzTFhMCCugXa1v6juTJYrn0NEb2pRjK3/KM0gtVLW5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q2nZW0UueVKiC9hCh2sV8yOImASL4iChJok12noFZqA=;
 b=vGUnZlwzBpGrhBQ0dlIOY4ffu+IzRiqpck+3Yuq6Kf4pRWZMwjQvUpDmaOW149ccpepaz+GeXspQMTRjD4bnLDGdupizl/9G2CJCmsjPMsD3MuY1NW1Td+L3rsc9tSWcsu69tR81xs0Mz+LjYD/cXcnos08m6+Rt27hTj/9URTu/cYs+keOtixQOGhvnCWu6EeHGeuMuXXU6Iv85MY19xomuhaa1Ddbqp9jJ7sHDmvkuzUVgWkZt/GCWMRLjvJIkVTv13mrcSwursjAaK0iINvUsmLq29oErq4v9eLWuyM0TsxRHGVephN1DvdFwU9SDOrktzLdngXas5uX6mJUNtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB8280.namprd11.prod.outlook.com (2603:10b6:806:25d::21)
 by DM4PR11MB5309.namprd11.prod.outlook.com (2603:10b6:5:390::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 17:22:51 +0000
Received: from SA1PR11MB8280.namprd11.prod.outlook.com
 ([fe80::cdde:8d34:980c:776e]) by SA1PR11MB8280.namprd11.prod.outlook.com
 ([fe80::cdde:8d34:980c:776e%4]) with mapi id 15.21.0223.012; Fri, 17 Jul 2026
 17:22:51 +0000
From: "Chautru, Nicolas" <nicolas.chautru@intel.com>
To: David Marchand <david.marchand@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, Maxime Coquelin
 <maxime.coquelin@redhat.com>, Akhil Goyal <gakhil@marvell.com>
Subject: RE: [PATCH 01/10] bbdev: fix stats aggregation from queues
Thread-Topic: [PATCH 01/10] bbdev: fix stats aggregation from queues
Thread-Index: AQHdFc7xqgBFXgz0qESwKqyEMs2unbZx6Omg
Date: Fri, 17 Jul 2026 17:22:50 +0000
Message-ID: <SA1PR11MB82808D1A33417DAF40BD6761F8C62@SA1PR11MB8280.namprd11.prod.outlook.com>
References: <20260717093006.229370-1-david.marchand@redhat.com>
 <20260717093006.229370-2-david.marchand@redhat.com>
In-Reply-To: <20260717093006.229370-2-david.marchand@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8280:EE_|DM4PR11MB5309:EE_
x-ms-office365-filtering-correlation-id: e5b803e9-d6dc-414c-68ad-08dee4280794
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|38070700021|6133799003|11063799006|4143699003|10067099003|56012099006;
x-microsoft-antispam-message-info: vpRfc3CR/p8AjJIh4Dc3fhIZQpz/KfXOFcm6ZfmdpXYwBo7HMgHYNmq/R8CZtIgzYH3xuO3efTtQMV2b76yksyM+SlNOCKvHHIruuG5xIoj2CvbLIVoHg/Tg1TPICD+3NpCbBKc7BWF3QF/yelDTyUP87Od8Wo9+etr65U2VSen3xDIV6+IqgrOjDzqjAlri60qIZepVik78d96vrkrlQNcIvl/YoW9fHs7OMGvaRqb2V3vqLa5QGE0DnSAL3q9mcf1906ASt+QW78Pmc4HZpjkKSkVN8WDtjRm7bcCvOwNx4rbbBQX0oADvwP1sVirOLa81onXQx+fDQTMRiOyBrx3ZH+7gPPvs8A99p7ew6DfQghczMtMCOeeBCBAjeSUIps/mPF5HrLbBC4f0n0p4tSWg5bwanQb1vRnQaloaHYD3X6jVIJHHqUf7JUznM3uFpKS8Ol3zcUmX53ADu7yA8lxm7ky9po0qgBpjdJgk72ZQAusciUVga8MJg5Jtj1xQUA1aFBH/GCldNQvW3F3epJNiPEusTNJ55HGyXKsn351SjAL31u4OS5zPq4y/kPBWS5GD+ygOMdG4a/SFzEyABaJo0ddH/ajrDe5RYpINnuPVDJas03ftHijS3es+T+7U/QhHDsDpBN3rJmZqaOejb+CzUGXp+/uTP4h6hvdli+jqLCgliapwWafAjav1vc5tWND+WdHbXXKqMYUeZ8q8+w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR11MB8280.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(38070700021)(6133799003)(11063799006)(4143699003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?muoFlBh5i9bo7l+8mynHLStxkkW8sUrWB4zBZSynL/Z2X75wVMzxOadnVKTA?=
 =?us-ascii?Q?jki9z8tYFv1hwou1lu17JiNXYbBbkx8BfvM3T4AxIvbyEKjDW3YVh+J2k3V8?=
 =?us-ascii?Q?u40Oa1H0xzvW3QFXvpMZ4jU1Gexta1py++d4ZGROzYG0mnKWk4axHySd0X8n?=
 =?us-ascii?Q?sRif2pRkX4LDWI1t0gXMc1bJHgFBj83+DjuxBymypKpDwM0AjHH255xT4lA0?=
 =?us-ascii?Q?RCtsiD4vkWbFox6Qy+APdJQ34Qgfq7h+Piywtuv3Vjr5cnuL6TpDbdGbYUWE?=
 =?us-ascii?Q?YyMRVBeilmbgfe5Ie0cWEvTMScQhaC9hbVbo42LHDwDsqQhnY+LQnTTUvHKo?=
 =?us-ascii?Q?NQwdwrHhowcU8qTz/87U40WqVyaFKlw1kdt89wM5jM9rcpLciw4tQqPiP4aZ?=
 =?us-ascii?Q?dP0OPyOplXD+E45kPNunaFC6DkuWAZB3TxtvteszqmdR/Ni4Llc+99caneE+?=
 =?us-ascii?Q?Ru2B8/8g7H3XNzAezeV/YdhKgV+qyGvfjR8BdRh2gqiZG1tTXJ91IvAVXAlE?=
 =?us-ascii?Q?f68b1WxlmJaDvAAHOAui+oUK8HSRNruLSp9tBUv4tcxLjYM3i/NnPaVu+Dme?=
 =?us-ascii?Q?tqQ4CK0Rv9XYZ+MLtSE/5houj+rmHAnfu5UvSKjMdGUS7PcEqxzzXQlmVL4F?=
 =?us-ascii?Q?PlPD+BIKvDlqNKK0P4UmdxaDDcJkdeqxpQai7nzNStN186H7vQo1eW98UDP3?=
 =?us-ascii?Q?7UuP2wr7r5hvUX00rw6BtbCfDNG8c1Epz/xdXVqPpkWftmIinprVYR8G7QA/?=
 =?us-ascii?Q?59C8FgAJ0qmAOxcP9tvUyRiCpHnHvx48Drdf/mumgaPhDcFfnruoBfUjXmh/?=
 =?us-ascii?Q?xSX9ElW0jOOvWmobDe9hT8WlYHA96TeVC22mg+wywrbnEmMrf3kB6XPOI+hb?=
 =?us-ascii?Q?VS3x8QZjQ1Dp1g+Zu1dlazBJPMm7xIQM0gZu6RmyrX5HQWctOpxhp1XIg3Hf?=
 =?us-ascii?Q?IFUjcItqay7RF2V0Ec6vEpcdyMzWETN1/PS8oAIOiwly8n7GMu4pG5lv1bVQ?=
 =?us-ascii?Q?3rlWhJyFxNSMfjGYgpFrtsRuu6XqdDo+A+WrWdKp619Rst4j+XHSQV/Eq/x4?=
 =?us-ascii?Q?kBMj+kVW5UJV0RWKbtnFVFxRcePB4NZBtfTbX+ays+Db1TRzMPeTqmD9u5i8?=
 =?us-ascii?Q?nQHfTA2CEo/6xBIh28A/hxkBBeo1nXx7zlrfZjHqotJqGy9SR8rLc7a0zjUq?=
 =?us-ascii?Q?aaqjzGlsZKxxy4RhqLxTrfHXGju/D8h9uqTdlwC6RT4NWENyPFMw6Yw+cfY0?=
 =?us-ascii?Q?6M3MGG2Lb9RswyMh0oVoWjidZAdMm2E8HoRtiW7GFLU8a9/i7gh3wJXrHwaM?=
 =?us-ascii?Q?gjobym00n6Mr4ClSbrxZuIfdX/Me4KPctiK3SgjHXLBIOBNCXjlOk6qq3WDl?=
 =?us-ascii?Q?XLaEyy77YCv0tuEADgcPTBFbYiUS9N2a7GRx2DsigZSfAw8OxGBNCE2QIYXR?=
 =?us-ascii?Q?o7Ju0FetDf14iEpupKeALNIx2pVRr0wLl1DdmTbayc2HHxbJRoFyf9AWKZ6M?=
 =?us-ascii?Q?gJXMJ3iAs2BAikdcBwyAu+xjposyjoF7b5UyU3rpa8s5Z91swL7pOC1pG0j3?=
 =?us-ascii?Q?R3q0E9FqiO80N6Xave4JgBAncyG1EiF0Kuf4O1l41FTLNYulZnky/xNGsl7j?=
 =?us-ascii?Q?hnIoG42N1YsCTF+/lF4rrXtuaLxsY5UVqfGJLRDNEzJrhJZjAN7M+TDGpP4g?=
 =?us-ascii?Q?Wfu/XAtZnToORsjoD3svGjIXDW0Zp5fQkJ74V7a5Dt/xCmepxVtq3amFgjCs?=
 =?us-ascii?Q?jQV2s6X51Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: NPsRduDSKmYedegsJXtgPPAR1Q5xKJ8jErpN8SGvKQ7FyGmgg7EzI+zz3gEMT4ihFcDZx/oMoUtEFLSgZyqiIUtiRYGV3Ds7Q50GfdKGUjCLfjdMNMaQ89RjqIvm17GaYCDdHw2QReHvHylDCQ+J1HCpy1Eb7qoCIloxkWvsYYffbOGGbRrCeEePGvQ749/w/T3ocNcEKGIOsI1ohdz057CPzvVrmnxXa2URic774d3IUBbvsWLL0Jz1nCdAEGdsJfTvnBrIVe5G4CoexJuyfns9JaBsA2mEvdThWNjDUoIzgVuoNftmL32QsPp6hhk79k5HyxbwTZkm7LuVGkcKZw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8280.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5b803e9-d6dc-414c-68ad-08dee4280794
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2026 17:22:50.9670 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /Q+P8qfmqOHRw2xtVBFOVCYZ+CM4+P+/UooY5gdo4kz6R1yU5TpIl+0CA7XrNUWCHA3MTRvo5dRAs0CwWKtCSx9FVAJ3stBXXYArUVSOUr4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5309
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

Hi David,=20
We use the same structure for device and queue level stats for simplicity.
But really bringing these 2 at device level as an aggregate level do not re=
ally make much sense at system evel (ie sum of of queue depth is irrelevant=
). The other ones are relevant.=20
I don't think we should change this, it would just create confusion with us=
ers. That's a nack to me, let me know if unclear.=20
Thanks
Nic


> -----Original Message-----
> From: David Marchand <david.marchand@redhat.com>
> Sent: Friday, July 17, 2026 2:30 AM
> To: dev@dpdk.org
> Cc: stable@dpdk.org; Chautru, Nicolas <nicolas.chautru@intel.com>; Maxime
> Coquelin <maxime.coquelin@redhat.com>; Akhil Goyal <gakhil@marvell.com>
> Subject: [PATCH 01/10] bbdev: fix stats aggregation from queues
>=20
> The device stats retrieval was missing aggregation of enqueue_status_coun=
t,
> acc_offload_cycles, and enqueue_depth_avail from per-queue statistics.
>=20
> Fixes: 4f08028c5e24 ("bbdev: expose queue related warning and status")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
>  lib/bbdev/rte_bbdev.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/lib/bbdev/rte_bbdev.c b/lib/bbdev/rte_bbdev.c index
> ea644c1f9b..90095578cb 100644
> --- a/lib/bbdev/rte_bbdev.c
> +++ b/lib/bbdev/rte_bbdev.c
> @@ -745,7 +745,7 @@ rte_bbdev_queue_stop(uint16_t dev_id, uint16_t
> queue_id)  static void  get_stats_from_queues(struct rte_bbdev *dev, stru=
ct
> rte_bbdev_stats *stats)  {
> -	unsigned int q_id;
> +	unsigned int i, q_id;
>  	for (q_id =3D 0; q_id < dev->data->num_queues; q_id++) {
>  		struct rte_bbdev_stats *q_stats =3D
>  				&dev->data->queues[q_id].queue_stats;
> @@ -756,6 +756,10 @@ get_stats_from_queues(struct rte_bbdev *dev, struct
> rte_bbdev_stats *stats)
>  		stats->dequeue_err_count +=3D q_stats->dequeue_err_count;
>  		stats->enqueue_warn_count +=3D q_stats->enqueue_warn_count;
>  		stats->dequeue_warn_count +=3D q_stats->dequeue_warn_count;
> +		for (i =3D 0; i < RTE_BBDEV_ENQ_STATUS_SIZE_MAX; i++)
> +			stats->enqueue_status_count[i] +=3D q_stats-
> >enqueue_status_count[i];
> +		stats->acc_offload_cycles +=3D q_stats->acc_offload_cycles;
> +		stats->enqueue_depth_avail +=3D q_stats->enqueue_depth_avail;
>  	}
>  	rte_bbdev_log_debug("Got stats on %u", dev->data->dev_id);  }
> --
> 2.54.0

