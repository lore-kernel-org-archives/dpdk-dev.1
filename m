Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3D3C021B8
	for <dpdk-dev@archiver.kernel.org>; Sat,  1 Mar 2025 09:29:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4AB3E402DB;
	Sat,  1 Mar 2025 10:29:25 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 0EB80402C2
 for <dev@dpdk.org>; Sat,  1 Mar 2025 10:29:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740821362; x=1772357362;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=h2IwSl30QVdHpKxu3/a9BUrjT2UqVhDQFMtQY4mlN8Q=;
 b=NOR2oC0F68g4c5xugFw6K9RVVrPNH+MXzsLx/yGD/M1xh1chvIRpsGWz
 1d/Z382PNbiaQNwL5t3jtYNJlrLWXN/FnLIxjdIbqHQNhm20JS95EsvlX
 XjRNQFpXOLYs+mTGegn/Pk3u4ChbgsOfEJL6X8moOxwTsK8LjKILhr8eM
 0vBB6d58MKe8tdzA74+jW/5qjEarwyCiWaXV5daS1/LVUsMBz2g05HJHP
 ukXR+U/n41wc130b6InesrtvktEdV9WBDwMigKltZXmbS4J8XXUnah0P4
 sdYUvF9QGwUKuwgv7g/7UVo4V8u3Mibx/rI+GQIkubzB6ZMSS575JxVEw g==;
X-CSE-ConnectionGUID: v7j1u/3mTPOrRpqFv9pU5g==
X-CSE-MsgGUID: qBaVGnUJRDWZkJAi4KgV/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="52384514"
X-IronPort-AV: E=Sophos;i="6.13,325,1732608000"; d="scan'208";a="52384514"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Mar 2025 01:29:21 -0800
X-CSE-ConnectionGUID: O1E+fpDfTwau3S1/KGcrvg==
X-CSE-MsgGUID: rb9V1ABqQ8KYVCDBctSa4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,325,1732608000"; d="scan'208";a="122692480"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Mar 2025 01:29:21 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sat, 1 Mar 2025 01:29:20 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sat, 1 Mar 2025 01:29:20 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sat, 1 Mar 2025 01:29:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LWb6aHKjKpAGUoXYFGYtGNCq5ryRpe3F3YpdTTtria8eCFx0HZHOYiX5fJw8E3lIiD9r22s9g9veocaOOfA+Wn4uI+ykgCzF9eBD5iGQB1UTSCaD6/D7gHMPghTLJSWOu4urpvNr6nqdsnvmtPB84OTY/K828BfwcDCDlH+z621LtmRgcoz0xSPikKcVi0TyjOvygoBK4w75GsFZOtIS0ShK0ID949eDIuB5Q8bq9omCiWl8bW5N6ThFM2X2C2JWbSg7hyMlXe75LYvV4lEcpEpGlZcANeU/17qGalslZPrD6A5k3fu40gQZWvKnPHzvs3wWtufOmppLsg9xQiKhyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yitO8njfK+oDi8UJKmIKhst8SR+FAyC2zzQSXFJO39c=;
 b=S5mpUzHMKpJBY4k/OHsFpbpN8ADogiyaQ0dCDq7RMfFM3hb0T60jIcaW+4ayCBo4atFoMdud8F8lIcOphGMQmLyZ2Zp8ErPb0H8knJ3ZbdIJOodJXb3QY/szxiPti2OeVK77IoXQsjycb/ex4ot1TfwOqRqR0lshEryqV4r6GhKmtnfWiauDCUfxk6BCEmC73xYTFfVdQUCPv+75zTVEQXhN9v//W8unS5FmG4yJT4+NDdiXqAT2w6Dztd2KXqQCjJt6lTKUyntJE/ccWzPObINHsK0oTR5sYP7z8tLGO5+YHyVsOUHlyQOv90NDKEmnupztAEPuxidIqTeiVMkRmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB7044.namprd11.prod.outlook.com (2603:10b6:806:29b::5)
 by BL1PR11MB6028.namprd11.prod.outlook.com (2603:10b6:208:393::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Sat, 1 Mar
 2025 09:29:18 +0000
Received: from SN7PR11MB7044.namprd11.prod.outlook.com
 ([fe80::79ff:96e:c439:d42e]) by SN7PR11MB7044.namprd11.prod.outlook.com
 ([fe80::79ff:96e:c439:d42e%3]) with mapi id 15.20.8489.021; Sat, 1 Mar 2025
 09:29:18 +0000
From: "Naga Harish K, S V" <s.v.naga.harish.k@intel.com>
To: Shijith Thotton <sthotton@marvell.com>, "jerinj@marvell.com"
 <jerinj@marvell.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "pbhagavatula@marvell.com"
 <pbhagavatula@marvell.com>
Subject: RE: [PATCH v3 3/3] test/event: unit test to burst add Rx queues to
 adapter
Thread-Topic: [PATCH v3 3/3] test/event: unit test to burst add Rx queues to
 adapter
Thread-Index: AQHbhpgjXhKiKpztrk2RVt4pReMNuLNeC4sw
Date: Sat, 1 Mar 2025 09:29:18 +0000
Message-ID: <SN7PR11MB7044552A0E652B0E6A5133F2A1CF2@SN7PR11MB7044.namprd11.prod.outlook.com>
References: <20250218091543.282270-1-sthotton@marvell.com>
 <cover.1740383918.git.sthotton@marvell.com>
 <c4e02d3a45f8583ad4f91a5b5d98609612d34b60.1740383918.git.sthotton@marvell.com>
In-Reply-To: <c4e02d3a45f8583ad4f91a5b5d98609612d34b60.1740383918.git.sthotton@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7044:EE_|BL1PR11MB6028:EE_
x-ms-office365-filtering-correlation-id: 3f56bd05-448a-4d39-2430-08dd58a38a9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?crJ2ztHCQDEEtCu6YlbdcMkXjrj14/A42wndc+PNloR2xVmY0w9BB+WF7Ory?=
 =?us-ascii?Q?xedUoPs0Yqtx2sm+NoKm5VvhWKrqR+wv216C5p7UIMGfUXuR5Xk8Vs3u9Bu1?=
 =?us-ascii?Q?6Y4wfQLs/fxRCSqVU2sW4VfODAV+RfYmXthGwb5xti9cw6NygMKQTm7Asfes?=
 =?us-ascii?Q?av7tLf6hPpdoQEiWLpg4a3i4GIjqMoy+p+/NwRaEogbQHjCky8VkInNw3qVp?=
 =?us-ascii?Q?aTnKObgDCgSqBvB6UQn+GQdzI/bhVWXE3y/PGBX0haok7A05ZkvUPxOPO/jd?=
 =?us-ascii?Q?SBR2UpV+0q5oXyTgDGJODZBmhmwB7BXgPuPDhFVRkcjtDohsFNwil81SdbF4?=
 =?us-ascii?Q?k/rEgdXfj2lV796fIxvELfpiLgGb/G6RaXcAlPVBMk5EV8EVfuc8XvuwA/60?=
 =?us-ascii?Q?ObQEeDLA796bXQL8RM2k7JqRk5frZMhaFPi7tzPjP7crnyPdskOieLQ2xt4Z?=
 =?us-ascii?Q?xeFBdhZ1iOC9iTYSqv7mBdxqtmOou9NIJCm+S5pFhQShoqqlMbgjG1Th1rUi?=
 =?us-ascii?Q?TqZseJWxeu2eIMTRbdWVTQ6rataT0ga3bU8WBQXtrMJqliuL0dqNG+sQVTwi?=
 =?us-ascii?Q?sluLF1Lc1L4ATPtFNI8ENZKR9Zo2/n1Jan4HcB+DMERCk72Q8LB+Mi2rdzRn?=
 =?us-ascii?Q?c0iXwSG6phTJnxf6luf6GYNC3Tm1lfiAA7SEJXWL6yTkALUxOLKhiNmba3KI?=
 =?us-ascii?Q?CLDDlne9JFbwu/XLLqnKVxMR5guWanXRNnq9SGxchqiLD8cImm01qUA/jYAy?=
 =?us-ascii?Q?/gwqx4JqBP6AtmK6nC8NSZU8QulA/TuBuQSRNOTdKij8r+JMNrV9mRKC5oU9?=
 =?us-ascii?Q?Wots/DNpgRGQE/7nHTaOU08/qKGhCuldkFzbiTPw6/YLlN9cCC7SKk1UQXUi?=
 =?us-ascii?Q?yGZUTsOwWdk8nnsCEnFAo2hvwVNwSHIp1RuNej6E1A3ZDDKVDnBsrGrOnNgu?=
 =?us-ascii?Q?/qXR4UV8aplDFVQTQooknWHDRXR36fKt/BomEkSrDyXff6fLg/zj+u6+n3zb?=
 =?us-ascii?Q?2cGlMRIQfkEs285Y1D1rd7me+SoAGisPkRf/F+GXoBZshlYR1HprJFOPnggG?=
 =?us-ascii?Q?l8jTFg7HtcXl+Y/mox1pyfz23uvBAvXsG40Xc/MLvETLv2ZzOXrsLqfZ84To?=
 =?us-ascii?Q?V+7otFK3ORVbQvTyYnNo/FMHSLhX6bULDMNWhqiwXlwMxdOWWKyaOc8lAxNV?=
 =?us-ascii?Q?e6L9UeGmnqrAMeANHHbgCcy5Ys/jEqjV2rIJ2baOVdFMxTtVCRJH7M0wFKeN?=
 =?us-ascii?Q?5xn8dzAupkSyQY3q/UoQgNkBoANnwzvEWrMq/yVwKN+Dc/yUxCZYb7UJO2OZ?=
 =?us-ascii?Q?VG83gfzz+2IMtDmc6RKh9Dqq2Djt4nkLjutx9N6X458fzKdKAhYXnNMDTPCh?=
 =?us-ascii?Q?oCNZBAREAT+MMkbHt26x6ev0/+WzEwNg6o28BxbCgvYUeUl0aowHU0DPdNhB?=
 =?us-ascii?Q?Me9Bf8N+H7abQy3msqvW1h71Kq8A7KPn?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB7044.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9f6PI2VMqciYEDH8JsNkIl9eqWNPWVNzWdC+QNoxkecklyHnKMX6JNh942of?=
 =?us-ascii?Q?gU6pLPqtxNyBJQpz78ZgxaSvIJIoGLZVd05eCnDsyj4xgOpw4ka9baf55mfu?=
 =?us-ascii?Q?yP6GfInf2lYi21d7fcVPVABMmLXhrL85Ll/LpREzoMS+zWOys5tWAYxq6nT3?=
 =?us-ascii?Q?CwYOV/uQGoY0ISvfjAgpLULLZpJno/QOlAHuFwqeeiu4rBn2DNqUXJzmALWJ?=
 =?us-ascii?Q?mv1P36zcz8yb8lrsjFTCy2zrFjU2n25WtYF2R/CeYITlbCQIIzER1u8DgIh5?=
 =?us-ascii?Q?f/C5cXGGUadpUIZJVQ9cutNOgagVAbwKJt2KZVkYmsTcmji2m2AKcF5MPpOQ?=
 =?us-ascii?Q?QwHvRwjIOCAftSskguyj8OcBIvNuWeHz07AeyVMtDVHXX5yp9ib+ew8/RUx5?=
 =?us-ascii?Q?fl6SSa2CAQMTEx5qm1qULlqTEGlVGT+ZnnyGiAm7ehql0KRSEJmtWSYiwwNn?=
 =?us-ascii?Q?rX0FeiYUi9ICE2Ok5J4rIjMQCMyDeBGabG3NC75Ln4fjP/nkkXFbPnkmvn3J?=
 =?us-ascii?Q?aajSWM/jNG+VYDxrLeHhT88KXj5kAXTc5R4jBXYNusGs2D2G5lG/+4zc5mEN?=
 =?us-ascii?Q?Fzx6IUgi8qx80yON/RmtVyxXHsylc8Mdx0IECPcWd5Al3sUj3niGucWWAvQ2?=
 =?us-ascii?Q?u41nc/9F79kJqclUJ31+7VLkxAY7mBUYwxNtgnY2qAKMTabD8k0YdByWD1l2?=
 =?us-ascii?Q?ZQQIOwbGx5trPmzSmA5fnUouqZL9LumSsBmnNXXeCOxfOStSIoUHdCdHp1pM?=
 =?us-ascii?Q?KfkdqWGLSCFL8olWlJbdCbgy9JMuAHj7WpxgBNRPMbvRka6CbhgO/q2RwYc/?=
 =?us-ascii?Q?e/LPtrYwYWmhKnPlwVXVJc84VsJGuu3QFAnphuYohywY8f55YzOxi4BPt4kj?=
 =?us-ascii?Q?bBqjLV7uUcpWIpicLoJA6r08UBXJzlkrL/FAw9WmKrcs1yUvicD5/WgzVruM?=
 =?us-ascii?Q?MR641cY9w7bO1e10eHFphtWQKGaX1b1JXmLvzVVVv3GArXv6R148wO1Avt62?=
 =?us-ascii?Q?QHrmEF8eOf5KK0eHCBd8QhGTb15eCKCvEUTX6q1By4z0+iDq16YQlqyI3JMt?=
 =?us-ascii?Q?Lp0fG2B8cG5LMNStbN8Gmm4SzCwOO4JmULVndDyMWgjXTwWGc7zTUBgn+d5o?=
 =?us-ascii?Q?35wPFaAV4mmNkV3GeyXb4aLhvCSelvCI6bBt+PuiYzBDXACVtnh+WuUVYEVT?=
 =?us-ascii?Q?DhcUtvUI83uJHzXOWCQP2I5Plgqm5dsEmVmE89pssIq76Z3Tm6Xi239aRlqg?=
 =?us-ascii?Q?rgl9golnHp/XIf9A0nHGJ3om6w4g05/SxrxQOslv5/G4r+ctkQcwmQtuoTD8?=
 =?us-ascii?Q?rxtc4oNKv8JUkkr3aPFpC2OWKxe3t+zUc+TJx93uUspaILWJun690KAs3YPD?=
 =?us-ascii?Q?VM/QooJJyXxHLOSOrcLCNLXwV+btW1LH9H/HkQkLKPeOedO0s/o5oTtMs5Az?=
 =?us-ascii?Q?x+yHRv9uYnHqiZ6o/Ujl7CRpmqc0iTqJHBdoG2HAV+wyB+omvQpTYc49DxJB?=
 =?us-ascii?Q?DTGe3oaRoljEeaBQ+tdnQcFNI8m9g58cM9eNEV72jn7OF7k02cdfN1PEEwPJ?=
 =?us-ascii?Q?GkpGF0QO41ocA2kFn2umjAciXCehNeAz7+FYvuYi?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7044.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f56bd05-448a-4d39-2430-08dd58a38a9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2025 09:29:18.4407 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gPZ9iYLIkcYq8/0Eub/Rsr5FmQOhQg1sm0y98LHpsIXwmXZA2vehBP1K9z8TsAx8FCVN77BHlss3AOrBU0BYwAcwqlu4JxkTWtNUj+5W7AY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6028
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



> -----Original Message-----
> From: Shijith Thotton <sthotton@marvell.com>
> Sent: Monday, February 24, 2025 2:12 PM
> To: Naga Harish K, S V <s.v.naga.harish.k@intel.com>; jerinj@marvell.com
> Cc: Shijith Thotton <sthotton@marvell.com>; dev@dpdk.org;
> pbhagavatula@marvell.com
> Subject: [PATCH v3 3/3] test/event: unit test to burst add Rx queues to
> adapter
>=20
> Added unit test for adding queues to Rx adapter in bursts using
> rte_event_eth_rx_adapter_queues_add().
>=20
> Signed-off-by: Shijith Thotton <sthotton@marvell.com>
Acked-by: Naga Harish K S V <s.v.naga.harish.k@intel.com>
> ---
>  app/test/test_event_eth_rx_adapter.c | 86
> ++++++++++++++++++++++++++++
>  1 file changed, 86 insertions(+)
>=20
> diff --git a/app/test/test_event_eth_rx_adapter.c
> b/app/test/test_event_eth_rx_adapter.c
> index 0233c87779..92b7ff6d99 100644
> --- a/app/test/test_event_eth_rx_adapter.c
> +++ b/app/test/test_event_eth_rx_adapter.c
> @@ -9,6 +9,7 @@
>  #include <rte_mempool.h>
>  #include <rte_mbuf.h>
>  #include <rte_ethdev.h>
> +#include <rte_malloc.h>
>=20
>  #ifdef RTE_EXEC_ENV_WINDOWS
>  static int
> @@ -819,6 +820,89 @@ adapter_queue_add_del(void)
>  	return TEST_SUCCESS;
>  }
>=20
> +static int
> +adapter_queues_add_del(void)
> +{
> +	struct rte_event_eth_rx_adapter_queue_conf *queue_conf;
> +	struct rte_event_dev_info event_dev_info;
> +	struct rte_eth_dev_info dev_info;
> +	uint16_t i, max_rx_queues;
> +	int32_t *rx_queue_ids;
> +	struct rte_event ev;
> +	uint32_t cap;
> +	int err;
> +
> +	err =3D rte_event_eth_rx_adapter_caps_get(TEST_DEV_ID,
> TEST_ETHDEV_ID, &cap);
> +	TEST_ASSERT(err =3D=3D 0, "Expected 0 got %d", err);
> +
> +	err =3D rte_eth_dev_info_get(TEST_ETHDEV_ID, &dev_info);
> +	TEST_ASSERT(err =3D=3D 0, "Expected 0 got %d", err);
> +
> +	max_rx_queues =3D RTE_MIN(dev_info.max_rx_queues,
> MAX_NUM_RX_QUEUE);
> +
> +	err =3D rte_event_dev_info_get(TEST_DEV_ID, &event_dev_info);
> +	TEST_ASSERT(err =3D=3D 0, "Expected 0 got %d", err);
> +
> +	queue_conf =3D rte_zmalloc(NULL, sizeof(*queue_conf) *
> max_rx_queues, 0);
> +	TEST_ASSERT(queue_conf !=3D NULL, "Failed to allocate memory");
> +
> +	rx_queue_ids =3D rte_zmalloc(NULL, sizeof(*rx_queue_ids) *
> max_rx_queues, 0);
> +	TEST_ASSERT(rx_queue_ids !=3D NULL, "Failed to allocate memory");
> +
> +	ev.sched_type =3D RTE_SCHED_TYPE_ATOMIC;
> +	for (i =3D 0; i < max_rx_queues; i++) {
> +		rx_queue_ids[i] =3D i;
> +		ev.queue_id =3D i % event_dev_info.max_event_queues;
> +		if (cap &
> RTE_EVENT_ETH_RX_ADAPTER_CAP_OVERRIDE_FLOW_ID) {
> +			ev.flow_id =3D 1;
> +			queue_conf[i].rx_queue_flags =3D
> +
> 	RTE_EVENT_ETH_RX_ADAPTER_QUEUE_FLOW_ID_VALID;
> +		}
> +		queue_conf[i].ev =3D ev;
> +		queue_conf[i].servicing_weight =3D 1;
> +	}
> +
> +	err =3D rte_event_eth_rx_adapter_queues_add(TEST_INST_ID,
> +						  rte_eth_dev_count_total(),
> +						  rx_queue_ids, queue_conf,
> 0);
> +	TEST_ASSERT(err =3D=3D -EINVAL, "Expected -EINVAL got %d", err);
> +
> +	err =3D rte_event_eth_rx_adapter_queues_add(TEST_INST_ID + 1,
> TEST_ETHDEV_ID,
> +						  NULL, queue_conf, 0);
> +	TEST_ASSERT(err =3D=3D -EINVAL, "Expected -EINVAL got %d", err);
> +
> +	err =3D rte_event_eth_rx_adapter_queues_add(TEST_INST_ID,
> TEST_ETHDEV_ID,
> +						  rx_queue_ids, queue_conf,
> 1);
> +	TEST_ASSERT(err =3D=3D 0, "Expected 0 got %d", err);
> +
> +	err =3D rte_event_eth_rx_adapter_queue_del(TEST_INST_ID,
> TEST_ETHDEV_ID, 0);
> +	TEST_ASSERT(err =3D=3D 0, "Expected 0 got %d", err);
> +
> +	if (cap & RTE_EVENT_ETH_RX_ADAPTER_CAP_MULTI_EVENTQ) {
> +		err =3D rte_event_eth_rx_adapter_queues_add(
> +			TEST_INST_ID, TEST_ETHDEV_ID, rx_queue_ids,
> queue_conf,
> +			max_rx_queues);
> +		TEST_ASSERT(err =3D=3D 0, "Expected 0 got %d", err);
> +
> +		err =3D rte_event_eth_rx_adapter_queue_del(TEST_INST_ID,
> +							 TEST_ETHDEV_ID, -
> 1);
> +		TEST_ASSERT(err =3D=3D 0, "Expected 0 got %d", err);
> +	} else {
> +		err =3D rte_event_eth_rx_adapter_queues_add(
> +			TEST_INST_ID, TEST_ETHDEV_ID, NULL, queue_conf,
> 0);
> +		TEST_ASSERT(err =3D=3D 0, "Expected 0 got %d", err);
> +
> +		err =3D rte_event_eth_rx_adapter_queue_del(TEST_INST_ID,
> +							 TEST_ETHDEV_ID, -
> 1);
> +		TEST_ASSERT(err =3D=3D 0, "Expected 0 got %d", err);
> +	}
> +
> +	rte_free(rx_queue_ids);
> +	rte_free(queue_conf);
> +
> +	return TEST_SUCCESS;
> +}
> +
>  static int
>  adapter_multi_eth_add_del(void)
>  {
> @@ -1423,6 +1507,8 @@ static struct unit_test_suite event_eth_rx_tests =
=3D {
>  		TEST_CASE_ST(NULL, NULL,
> adapter_create_free_with_params),
>  		TEST_CASE_ST(adapter_create, adapter_free,
>  					adapter_queue_add_del),
> +		TEST_CASE_ST(adapter_create, adapter_free,
> +					adapter_queues_add_del),
>  		TEST_CASE_ST(adapter_create, adapter_free,
>  					adapter_multi_eth_add_del),
>  		TEST_CASE_ST(adapter_create, adapter_free,
> adapter_start_stop),
> --
> 2.25.1

