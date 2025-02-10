Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F634C02198
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 16:50:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4693A427A0;
	Mon, 10 Feb 2025 17:50:01 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 35B024279E
 for <dev@dpdk.org>; Mon, 10 Feb 2025 17:50:00 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51A9tper012320;
 Mon, 10 Feb 2025 08:49:50 -0800
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44qf8sgpup-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Feb 2025 08:49:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AWGq19Ii+lhmFB0VzeK0JS8dHkBrqotP9yL+PHezIXuJqYdd0O/5fBWTjXctzBbhOwlyU45P+MhcBE64r03W7FfVRGdOmskih5WgB6F8OKnf+Q5c9Vp8QaSLO5Y4BRz+HadXFFKZwbbLy70CcZGosHx0yd/S7pkhFg9D9D9wz6BGJHkoChSNVbDxERjM+2/y31/iUxInnfjLOsQakQlfKllhKQ7aygL7IQ4p8S4+JZ9/9PdZ3Y1cXENmMQEKhda0nC7OIwQaoiSbB0UpxbYKZy1R0AYkd9LLuiyL7kdwFvQ3rhUkrmoyb10HZ3YbCmXGzaBH8fMs/9tf3l5imdMbGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N3Q02qW5CEqhFXeojPjeULuGHNFR8lBa97Z6BA7T62A=;
 b=qH2Tk7NALIzyqSKfsQjB1CWUeyTDNsXdiVkfVrCj/o0B4vp7cOswpuFWI+DECFj85tWsajatpcOdg3b77JjeJEjjN741oo8YhqfKH/hwpfp7j+WZ3p+ENiqTYa40M6yUPAxGyv5GcFsoikvZK1JuP77T3ySLCAqt3/erRP94VuXcfmB7eiwQDOkNoJiLDmXEY2ruFQlN3k4YN8vg6I1khqLx/yjXBancxMI2piiwxL/qze+WBChX1gJ+rVIYL36ESBXD/s/Egaa6B7JuAvF4QmTgQcRESKvWUqHhrAfPx4+/3whFzIpVIBBPmfRtFhwo9kNcaMGMiwT97l3ftv67+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3Q02qW5CEqhFXeojPjeULuGHNFR8lBa97Z6BA7T62A=;
 b=eGooxHq/VLC659ZDNjN7AKmAudIcTIT4AeKj+MslCdMbAMNQ8XkK4lncBm4Cj8NNANe/nCyXQ4x8Z7zvSJHobTJqG/8WUwZ5rEsqpQSYHUqu6bQymtRU8c+nUQsCDDbx8GMLZ045pz0yvYov8G3Oas0CtPSfilnNkt9RIQn1+dk=
Received: from BY3PR18MB4785.namprd18.prod.outlook.com (2603:10b6:a03:3cc::18)
 by BN9PR18MB4220.namprd18.prod.outlook.com (2603:10b6:408:119::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 16:49:42 +0000
Received: from BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576]) by BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576%4]) with mapi id 15.20.8422.010; Mon, 10 Feb 2025
 16:49:41 +0000
From: Jerin Jacob <jerinj@marvell.com>
To: Kiran Kumar Kokkilagadda <kirankumark@marvell.com>, Kiran Kumar
 Kokkilagadda <kirankumark@marvell.com>, Nithin Kumar Dabilpuram
 <ndabilpuram@marvell.com>, Zhirun Yan <yanzhirun_163@163.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "rjarry@redhat.com" <rjarry@redhat.com>,
 "chcchc88@163.com" <chcchc88@163.com>
Subject: RE: [PATCH v5 2/3] graph: add support for node free API
Thread-Topic: [PATCH v5 2/3] graph: add support for node free API
Thread-Index: AQHbP73aFH1OAQvi20mhTbYcqHxNorNBN/rA
Date: Mon, 10 Feb 2025 16:49:41 +0000
Message-ID: <BY3PR18MB47857F6A33DF7AEDD22FD729C8F22@BY3PR18MB4785.namprd18.prod.outlook.com>
References: <20241114070432.3152188-1-kirankumark@marvell.com>
 <20241126044402.1209998-1-kirankumark@marvell.com>
 <20241126044402.1209998-2-kirankumark@marvell.com>
In-Reply-To: <20241126044402.1209998-2-kirankumark@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4785:EE_|BN9PR18MB4220:EE_
x-ms-office365-filtering-correlation-id: 8e4cf503-dcd4-4db1-8ce6-08dd49f2ea22
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?R8R2V8wG81yk/T5ILOU/gONTdleOwqWfBidbBMEEJJd2TSqbA58dyM1pCIUK?=
 =?us-ascii?Q?1H1pezQVKU5iULsu8C0SaCKRWbEJa3ecCCYV+4j1LmkYbP/7jitjh8nXi+OT?=
 =?us-ascii?Q?Ig7jUut1PKR6YEKhaFsRwgAIG0URAUBxd/VOsnYWKiQbwjw1ZDM/gUP1tBkv?=
 =?us-ascii?Q?YZAMxe9VDrslwwXXLAjiB2IdzDNmZlnKERkm7bPul02vULk4n3vZCt1rs3fk?=
 =?us-ascii?Q?RO8vVAcEujr0nG2UsaSM+0RlJDIUHvpqxwGNlWK0iqmTrVEd1T0qg8c0vkka?=
 =?us-ascii?Q?k8nm4Vlf88sPK5eJpR4fvOWXbfEzljOh+1BgoceMsGBDj5Iu997Uua7MnbCX?=
 =?us-ascii?Q?B+My2RIHGsDyTZ8AnMOAw/ux2rykZXLDpYeZtAfR06BqrW33cocFVPIOwspr?=
 =?us-ascii?Q?3/wuy9JAzZllG7g4Aoop8BNYi6WBwoMab2ZZNppQvls1v90kSDwy97eFuVzp?=
 =?us-ascii?Q?HZd+zDOIITKeX69YL2B/c+iEwMg3yrP8+XnL3tGWtj3osHmZOxLljni6wH4U?=
 =?us-ascii?Q?iinYgtIrDJE+Q+Ga8TkYBYA5qyCgJM/IwEShpRAAQRhloYhfisJzDtF9nYC4?=
 =?us-ascii?Q?xucMGK2OVCkeSlQOULdWL8TqPEt8i6Bzc4mPwkmicDs/2TGIyFSleEX8P7dv?=
 =?us-ascii?Q?4k8cSgUcmYVkLD61jDQc+k+j4zm6FRCo+OYVFghTdvj3SdZvfT4oi8GZNXOi?=
 =?us-ascii?Q?cATmwj0/0sBeDrYjWqz9ntqawc3LziKPnapAmWHaUBMYE3GytviKK3MpEvaQ?=
 =?us-ascii?Q?us/0ZQaIwbt+5jdT5NSozpsTBbvn1lhDZpq2iF2ZPQhDUxxEuqzWBeEOTgzV?=
 =?us-ascii?Q?gBKLb3JIyVmK/WdHdGoEqjgFDOc2ROCRB016FFmmRORGUsGYjDWzQixQKFo6?=
 =?us-ascii?Q?xzQgnMkO1/MzABSYbdLXv62pfbVZEUqDsjbaUgAUYq9gKdOs+JHeAguebAKL?=
 =?us-ascii?Q?Mct6T1Uk/sNIwRp2/uVBuJHq0l18885NqAS1L9N7btBDWpcBqiJVhkoLxUIT?=
 =?us-ascii?Q?xOUWr9hh/8mBefGgMfTERerIawp2zOvNF3X4BBwsf28meJtLtLNCeQ2vff3z?=
 =?us-ascii?Q?xMVmHmtenhN3LH/rU8TOgyUmTsRPv8o8meCaomWdmhQICh0OyVvHAFrLyV1W?=
 =?us-ascii?Q?AuNKe62TRRf19dP11Kan9reCe3bx1UYRDrpnl4v0WaaDqWgj+hZJcmBNI+DX?=
 =?us-ascii?Q?oN/d+08rKF1Rvch9psQI2ieRp1riXuA+F++Me+p9yBCx7j3vkx5FrjrZZqnZ?=
 =?us-ascii?Q?eCfipkwfL6CKQbyQ2QVTNEo7ERbXeOUzL+r1Iw3DXTG/0L5MLJJQr0CaEb1L?=
 =?us-ascii?Q?PDmlTuXYyM8heeBUYwrbQ/iCjpytLhR5vcZTlmk2Pus3jq2Gi4taPwmM9F+W?=
 =?us-ascii?Q?YJ/m2lPtSDmF5NObfpSP7WPrHcMXUHd2/day7eDMy99sWOhnZ5wHN2jvFzIo?=
 =?us-ascii?Q?MtpuCN9lqeV/AY0bBzF0rr4TT5IJGX3M?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY3PR18MB4785.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ViqeL7k3qNGXANHlAxaiaG6Juaa0CHozmrTC9INsraBQvxKgK6bfp9cybFDR?=
 =?us-ascii?Q?bzOPSQAB/pkSGzFl7OWGk0Fz+dBS8/1EcoxZtbgIMTlQJfdMU9Mx+lI4y8M2?=
 =?us-ascii?Q?v3KlcNnPBd8xTlwv2TK5l7Ck9GlSP95Rxno4lAUGS6E29soBnHLejQIZXMOA?=
 =?us-ascii?Q?qmBr86HkXC7RPbW+XowOgjSmHco8EZ0Kdoa+2CtvyQ3krrkPHKX3lpPutspz?=
 =?us-ascii?Q?KVlyPnEK8eUa0WAhr44rQpCXq3PXbJTHN6DW40tc8rkBS22sOuh+jVU3r1Kp?=
 =?us-ascii?Q?h7zQ8ug4z1j01xxxXHD7Uo2LoImkJsg45qMFWoZGCsE+jggtrJWB3tsJZmbN?=
 =?us-ascii?Q?HG4vMmkLWY9oRUpN1rnitFiQsbLtX/IgtvZfODXiwCiop3m/MP3WvcWkvLsQ?=
 =?us-ascii?Q?nDp2pSKb11nxPaQqvfG9n58Am7VMDFE13b6qxXqrr+sLGwK9aOxM3wm3y8WN?=
 =?us-ascii?Q?8ZlVoR062+VeqyZucRWKe6c/GsJGMOU4jV/vM1s7fz7rQBTnnUxwdnc90mjS?=
 =?us-ascii?Q?PE6y+MPH143gZI5qrLE2Hy5GCpnj+IIaoqZRkrs6e6OkcyAcZ1tyYWoJxopX?=
 =?us-ascii?Q?y/RuX9c47wBSE63sMp1tbHUN2HC5QLwYk3faKVBDpTCaRQQrxtmk4otViMaa?=
 =?us-ascii?Q?cc3+lTbv2V2dWH8HcCbnuixNDXkBD7mKz/jGSHr/wM1cZdsHrNpioJV8Ewpi?=
 =?us-ascii?Q?exHIIVDK8LLIc3wwLMrV9aNfJv4ucNoQBcfidf9M1i2TuuS1YrLdDkMaH81b?=
 =?us-ascii?Q?WOA3tOH3LUUxQ/iW/5iFmU+iAybOAg8LvlBSEFiu3JsqYpEkEniXlnXzOD8K?=
 =?us-ascii?Q?wQVZmb4A/WfNCWERB9coYu1jZxBhwTedAFN4UlDlb+ibJ3/09+15UH71+HUN?=
 =?us-ascii?Q?3JUA+4dV5wLLasisbNN37a8LXBmFyR2MA7mqW9i3OtKct9mWG1iIUIvT8cA8?=
 =?us-ascii?Q?Mk5WX3yBnAqHRJ1JPUV5jwFM2+ceIJ+cA/pLehHMVFZc3OjoZN7r5kekKu0e?=
 =?us-ascii?Q?GvK3F5/KDonwNlVhLwdNldLjW7/QLFWSB1+5cUMFtBsrbv1rFqk2Mucd7yzw?=
 =?us-ascii?Q?FzG/o3cA60XHUuAx9o9PUmNGbjVDiQd/Kq0xjw6m777sPwSgxE/+3aKRpfKw?=
 =?us-ascii?Q?rY22tUq+p17Drep8r0TA47H/DWoOtjQb5eDHR4iw3r/XmXTxDJk9ZY3MY2Ga?=
 =?us-ascii?Q?FcLMi6c52iK/Z4LYwAlTCXF3NNyPEFgTp12B8MU3b2JN6gagk8iNjgxfTw1p?=
 =?us-ascii?Q?NxiPQ02oXbyJIT1ZF+y9Sd5FpQI4wxUdwE0Fe6s0OwSKUmTYDXd5WLaFcjI9?=
 =?us-ascii?Q?yN4Yv4hyUhBDqOEg8q5SMJiV9edfbibYtByOYlogHI44X7DhcjLZ9B3GP/zc?=
 =?us-ascii?Q?F6AKwgkniRg6vCSX5XrecgCnPkV54tK83zf7zTV9Gc8mkJjUBrGPHC0+1TiK?=
 =?us-ascii?Q?X/H1Vmo/1kKa5WWCMgmdQfBnBfaKQSoIzunmUhhif4SEQMYLaF0PuHGtdLRh?=
 =?us-ascii?Q?xpgACM99ISEPUeybrvMqfJ7Vihd7A6Pg67A29ukVa4FomsWELP3gYQIPS1Lz?=
 =?us-ascii?Q?MuDBtD+MfwRnly4Hcaz6BuV5a8S/uLNAOgoeWVu7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4785.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e4cf503-dcd4-4db1-8ce6-08dd49f2ea22
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2025 16:49:41.5216 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bBfc3AMm3+EzXHD07kfcdlOq2GO300r5uOKvROju/hqyvVwqdPfX0bb7Qx6ycYJ6jqbSNdJYRKKNM5ExVMfE/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR18MB4220
X-Proofpoint-ORIG-GUID: Td3jnJzlJ6E-osmqAKhZFRcykCP_jW0X
X-Proofpoint-GUID: Td3jnJzlJ6E-osmqAKhZFRcykCP_jW0X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_09,2025-02-10_01,2024-11-22_01
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
> From: kirankumark@marvell.com <kirankumark@marvell.com>
> Sent: Tuesday, November 26, 2024 10:14 AM
> To: Jerin Jacob <jerinj@marvell.com>; Kiran Kumar Kokkilagadda
> <kirankumark@marvell.com>; Nithin Kumar Dabilpuram
> <ndabilpuram@marvell.com>; Zhirun Yan <yanzhirun_163@163.com>
> Cc: dev@dpdk.org; rjarry@redhat.com; chcchc88@163.com
> Subject: [PATCH v5 2/3] graph: add support for node free API
>=20
> From: Kiran Kumar K <kirankumark@marvell.com>
>=20
> Add support for rte_node_free API to free the node and its memory, if nod=
e is
> not part of any of the created graphs.
>=20
> Signed-off-by: Kiran Kumar K <kirankumark@marvell.com>

Acked-by: Jerin Jacob <jerinj@marvell.com>

> ---
> v5:
> - Fix review comments.
>=20
>  lib/graph/graph.c         | 16 ++++++++++++++++
>  lib/graph/graph_private.h | 13 +++++++++++++
>  lib/graph/node.c          | 25 +++++++++++++++++++++++++
>  lib/graph/rte_graph.h     | 15 +++++++++++++++
>  lib/graph/version.map     |  3 +++
>  5 files changed, 72 insertions(+)
>=20
> diff --git a/lib/graph/graph.c b/lib/graph/graph.c index dff8e690a8..bad0=
0c8fc0
> 100644
> --- a/lib/graph/graph.c
> +++ b/lib/graph/graph.c
> @@ -20,6 +20,22 @@
>  static struct graph_head graph_list =3D STAILQ_HEAD_INITIALIZER(graph_li=
st);
>  static rte_spinlock_t graph_lock =3D RTE_SPINLOCK_INITIALIZER;
>=20
> +bool
> +graph_is_node_active_in_graph(struct node *node) {
> +	struct graph *graph;
> +
> +	STAILQ_FOREACH(graph, &graph_list, next) {
> +		struct graph_node *graph_node;
> +
> +		STAILQ_FOREACH(graph_node, &graph->node_list, next)
> +			if (graph_node->node =3D=3D node)
> +				return 1;
> +	}
> +
> +	return 0;
> +}
> +
>  /* Private functions */
>  static struct graph *
>  graph_from_id(rte_graph_t id)
> diff --git a/lib/graph/graph_private.h b/lib/graph/graph_private.h index
> fdaf5649b8..6eecba4f78 100644
> --- a/lib/graph/graph_private.h
> +++ b/lib/graph/graph_private.h
> @@ -440,4 +440,17 @@ int graph_sched_wq_create(struct graph *_graph,
> struct graph *_parent_graph,
>   */
>  void graph_sched_wq_destroy(struct graph *_graph);
>=20
> +/**
> + * @internal
> + *
> + * Check if given node present in any of the created graphs.
> + *
> + * @param node
> + *   The node object
> + *
> + * @return
> + *   0 if not present in any graph, else return 1.
> + */
> +bool graph_is_node_active_in_graph(struct node *_node);
> +
>  #endif /* _RTE_GRAPH_PRIVATE_H_ */
> diff --git a/lib/graph/node.c b/lib/graph/node.c index 5ff8dfcd55..5aaf78=
7d5e
> 100644
> --- a/lib/graph/node.c
> +++ b/lib/graph/node.c
> @@ -481,3 +481,28 @@ rte_node_max_count(void)
>  	}
>  	return node_id;
>  }
> +
> +int
> +rte_node_free(rte_node_t id)
> +{
> +	struct node *node;
> +	int rc =3D -1;
> +
> +	if (node_from_id(id) =3D=3D NULL)
> +		goto fail;
> +
> +	graph_spinlock_lock();
> +	STAILQ_FOREACH(node, &node_list, next) {
> +		if (id =3D=3D node->id) {
> +			if (!graph_is_node_active_in_graph(node)) {
> +				STAILQ_REMOVE(&node_list, node, node,
> next);
> +				free(node);
> +				rc =3D 0;
> +			}
> +			break;
> +		}
> +	}
> +	graph_spinlock_unlock();
> +fail:
> +	return rc;
> +}
> diff --git a/lib/graph/rte_graph.h b/lib/graph/rte_graph.h index
> f5e575dbed..097d0dc9d5 100644
> --- a/lib/graph/rte_graph.h
> +++ b/lib/graph/rte_graph.h
> @@ -22,6 +22,7 @@
>  #include <stdio.h>
>=20
>  #include <rte_common.h>
> +#include <rte_compat.h>
>=20
>  #ifdef __cplusplus
>  extern "C" {
> @@ -661,6 +662,20 @@ rte_node_is_invalid(rte_node_t id)
>  	return (id =3D=3D RTE_NODE_ID_INVALID);
>  }
>=20
> +/**
> + * Release the memory allocated for a node created using
> +RTE_NODE_REGISTER or rte_node_clone,
> + * if it is not linked to any graphs.
> + *
> + * @param id
> + *   Node id to check.
> + *
> + * @return
> + *   - 0: Success.
> + *   -<0: Failure.
> + */
> +__rte_experimental
> +int rte_node_free(rte_node_t id);
> +
>  /**
>   * Test the validity of edge id.
>   *
> diff --git a/lib/graph/version.map b/lib/graph/version.map index
> 44fadc00fd..a793ea1d8e 100644
> --- a/lib/graph/version.map
> +++ b/lib/graph/version.map
> @@ -58,4 +58,7 @@ EXPERIMENTAL {
>=20
>  	# added in 24.11
>  	rte_node_xstat_increment;
> +
> +	# added in 25.03
> +	rte_node_free;
>  };
> --
> 2.43.0

