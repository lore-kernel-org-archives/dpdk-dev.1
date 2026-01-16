Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28114C98306
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 23:11:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 62F2E40653;
	Sat, 17 Jan 2026 00:11:00 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11020085.outbound.protection.outlook.com
 [40.93.198.85]) by mails.dpdk.org (Postfix) with ESMTP id A59C9402CC;
 Sat, 17 Jan 2026 00:10:58 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ev37ng1UChd/t62/ikh1uWrIqtGPWOdofBjEjxofafHA6ripC3o1cx/RbW12yhXSL8D1R7bjLbXDtobCkv8XAYivDYBh2I+GqSb3FOmgY+YIYAHDrafdH2u7FxFXpYz0NJQ32gT0mVf3gadMg9h+dXDV/qNC5raHUzMKCxwaczRPGf14ETI5gNjsnfuf8h10DI8+VRZY2e1YS92bZHiMU+XtUVgNorDBRscXYd9rmQMI0jj2XGlvfeSAnzkRRLImP95u3Bg8HXuMVJNpHxsY+I1hGLJXstHaj4jnBxzCL9aLYSHdRSi7X1FbsJqXfamkig9ntpciXMGPZXgKsS0uhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kN7T3ft9yICCbp+hZAZK00R/EubvKYdjyZuB2mYR97M=;
 b=a2c1+yGXkXWqEo8NdzouPaEEA8nLSdCI1BecGY/0Th79YbXXuptcnYcfyCY6vqn+ugL8Xh8P+NrYOyR40JtMDnBLLJqGegfqHYPn8YDnDg0afXoK/IWRjSjFU2hwC+6xS+hOa32I07mHeIL0IWu8E9KakOqCp2z4GmqTCyj+zwrGtAlYAwg75kwEnsYGzLoN2d/dMmOzRH4MOnq4PJCClnyVeONQuPzybniswurKlFNCtuIBF30eI4my6d4t0gN01Ae/+rJYNG1NUhDIM8egvD6dt0V3cNcrXC3Xv5KmiDXzdvXk11q9i1rNWiMijQmbwxI2x6GyGdc9YYeIzpIgIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kN7T3ft9yICCbp+hZAZK00R/EubvKYdjyZuB2mYR97M=;
 b=dXxBLelWqyiQGPf9XGXml7akRvzrBAElcl2WFIgdZMEh2q8UMe7lCHJvqWLr0UY8xuJ5+vNwd84JwPHgJGaQYy2EOAelwwvuaDs/U7/tbXfaRgBkF9e1XVQWh/k8joVdBz2pZ9d7Wx92Tq75S8bQBAkQg/D6VoHoq1GFE0/H62o=
Received: from DS3PR21MB5735.namprd21.prod.outlook.com (2603:10b6:8:2e0::20)
 by DS2PR21MB5015.namprd21.prod.outlook.com (2603:10b6:8:2bd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.5; Fri, 16 Jan
 2026 23:10:55 +0000
Received: from DS3PR21MB5735.namprd21.prod.outlook.com
 ([fe80::a3f4:6107:de7c:5925]) by DS3PR21MB5735.namprd21.prod.outlook.com
 ([fe80::a3f4:6107:de7c:5925%3]) with mapi id 15.20.9542.001; Fri, 16 Jan 2026
 23:10:55 +0000
From: Long Li <longli@microsoft.com>
To: "madhukar.mythri@gmail.com" <madhukar.mythri@gmail.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stephen@networkplumber.org"
 <stephen@networkplumber.org>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [EXTERNAL] [PATCH v2] net/netvsc: fix race condition in RNDIS
 command execution
Thread-Topic: [EXTERNAL] [PATCH v2] net/netvsc: fix race condition in RNDIS
 command execution
Thread-Index: AQHchHX4tOmTJu/oEUmq5rtSBSQ+nrVVacLA
Date: Fri, 16 Jan 2026 23:10:55 +0000
Message-ID: <DS3PR21MB57353793968EBA2499F8C5A6CE8DA@DS3PR21MB5735.namprd21.prod.outlook.com>
References: <20260113101820.60611-1-madhukar.mythri@gmail.com>
In-Reply-To: <20260113101820.60611-1-madhukar.mythri@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=69698017-399e-43a4-8bd9-5f648a788b8e;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-01-16T22:42:05Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS3PR21MB5735:EE_|DS2PR21MB5015:EE_
x-ms-office365-filtering-correlation-id: 5d356867-2083-4a69-a087-08de5554809a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?n81mny83bzLaaivhTwywkP1to2OoO9zZVZOrZ7uL0rGYjy3tCeRksnfgfaJO?=
 =?us-ascii?Q?6nTJWSUbdQO84ClOVG+5JjugWlIH9W4POe3HpH1rT75kr7Pc3L/E5lKbYS5Z?=
 =?us-ascii?Q?NzBClN/fdRk8IouBYVzTl/MTGx5SKLoAyBq4SfSx+IhMwZGnSoIrQ8j3lBJq?=
 =?us-ascii?Q?VBdUoJR/YsLhYZ88FWdLWnFaTY+LFvreFgEp1uwfYEyY6QYkEFWSOpGBwOss?=
 =?us-ascii?Q?mA2ekanc5YPBiK33RdwSw67QCR9VyqrduY3GwqrcwrDnSGJCGOpmYBXm5VVn?=
 =?us-ascii?Q?s2qtJ9uOC2IhnQHgLk+OvI7OIMw3rsYlfH8ufU5c6oHf4PYrJHlOt7LRLJmD?=
 =?us-ascii?Q?dEuDrljURZqIm7r1vkkFX48csxgblxM/6Dp+AfWPzVCoqGbt61vduaqd5OC0?=
 =?us-ascii?Q?isfw5TDwfnqFQ17qLIwQknVMvzmqY3Oi86OqhsJOOGsv92oYCY5k4PL0ZOfv?=
 =?us-ascii?Q?QTqibxZH2SVSbtybqPHfSNBw8J8THc34zepONlRlbL8jCtXZY6gOaPaKABJ2?=
 =?us-ascii?Q?GuLVEacemY5siSKakigHZ2Jocrl4PZEKujEAV+/BzPEqiLzMKvf5yqn3vceL?=
 =?us-ascii?Q?dWwIupAsN2yQM/yW7dF0ao+cHbHIdYIUCwscTGVzjEvA0nxTuH9I31Sj4GGt?=
 =?us-ascii?Q?O2GMovuBDvFmuVmHJHdOsxZznt2W70tQvIK0URSVEY1IcmerN3dMcA4T+F6/?=
 =?us-ascii?Q?/WqPcO3/ezGMQ9ttZ8xK2SXZAp6zh2JGbXBcpoHguKZ9Eh94DHXNlS2Ckq1W?=
 =?us-ascii?Q?7/zhUykNmo+eL7nnDMZ0NtqpCps1re2glreE0BBbSwlKVl8/bFjgRwfji70h?=
 =?us-ascii?Q?FnOH1ugl4QtxmPa/pZp1OC/Yq9V1ugO04TLUxRDfVeylEYFOY1xZR0fWzsgv?=
 =?us-ascii?Q?59a1Cde7nLsFe5q54xgiXdFWhi+2N7x8VlS+L758RxZy1MnuChGjfWvbLOm2?=
 =?us-ascii?Q?KpkAy0eqyPc81XRErgOw176oIVnHj4x/X9DFXIDcjDt5Ol0vGcNm1fFM4Y4q?=
 =?us-ascii?Q?Ark7UQblMwqdZOI6zH60v/JYwNKawUZHwuLJmdTUep98X4uXVeaR2wFNXjRl?=
 =?us-ascii?Q?Y7x7Pd6bKggbgLMNKBnFeXUn3zrDq6Pb1EJFXuwMUzuEOaMqyRUZgoHBx1qp?=
 =?us-ascii?Q?3YQPlPPX7WMbCCoKdQhMlTS9TseT8RzqPH5y+39jEzi0OsCmYGN+IzqG9vjg?=
 =?us-ascii?Q?B022T9FS5GZ+aAghgv051nmIMuFKr6GGvICg3BpAO+lgiHGk+tlqC19G3PCJ?=
 =?us-ascii?Q?WXVOoAoDNYUWdT1FE+rxhXGpxD6XZK4u0VnbJ5uXmRz64DCJTkA5cY+DLDkf?=
 =?us-ascii?Q?NLTAvaWO1ejIvFPy1ZSTkRFR175Yku7A9uBfWQZnw/umiD1mKHukvn5KZ/f/?=
 =?us-ascii?Q?5kUyCH5CZkfffkpTv4BsG46mrrsB9oenY5SbemRnwV7bivTJmFJzn3FctKbP?=
 =?us-ascii?Q?iYz8z0IzvP0XbNrDaPI3K7lY8rqDyjiGGYYjLhSQi13N6GaV5j36RWOyVlrB?=
 =?us-ascii?Q?JpZZ8j6W0fTLObp823Vu0WF3rfyOMgAe7SIUZjvzWyQQbxNX54SiQsY6vzbe?=
 =?us-ascii?Q?RTQnnBuvj2ubGc3yyDeIIGvdLU/r1d9k/+bY1OEBG6/t+sVz081+2dq3pzmK?=
 =?us-ascii?Q?/QTR37W87sp4iu7a2YQOnec=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS3PR21MB5735.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?536HHVwP8WSiBYjY8zPraZDalFzRFPI8fgasfg1BJ//+FxaJAOEE6se1Frrf?=
 =?us-ascii?Q?nkbR5OFg+kh/a2/DwENFe9gHpL4N7PNzg+nhcnm8EkCGlvJoy4gjr6NCNvlW?=
 =?us-ascii?Q?ZyW8HRPpa+LXzSzlYU2Pqsm/PQvldmM9jEHXWmjKqzZ8iiA3+MV8bygbAWkI?=
 =?us-ascii?Q?7t8MSH2i1rTNeL1A0lzAHHqukMdt64wW7mZs2Sy6cvAb2pq6dILWESgMjgmI?=
 =?us-ascii?Q?881OBJnwHIB/HGZMeNQWvZRnvuSts1t6KaVEpCKwP4qhAMIJ+kju/dFSTzp7?=
 =?us-ascii?Q?jaANCjfMTRc3TcUfy812MsoL+nxvmh5NlLZK9k7yEdGadDLjGStIaw7KwFvR?=
 =?us-ascii?Q?yZMaFYuIk3Yqmbslp+AClSazo9wOqqfPo27KedZCv15id0wRFIEBk8ZkecI+?=
 =?us-ascii?Q?GKn5JKGJUZBT+0jDUQ+CztVUqe2Nk6hARRbsxTAh1UzO6MlI4/hvut8dEGs0?=
 =?us-ascii?Q?Smz1jACl19/poDo6N0Hq0VgzwSjqBJsSGi49Nx/ZH+CWIbhyUpi3DkwTu52+?=
 =?us-ascii?Q?wr16HHxqC5325VMCXJS7d2fnDt0KVmJsbrUCU1zhuwGQjqEztS/dS/ZIQpxn?=
 =?us-ascii?Q?J6fLRQP2tlbIMN+cb2QsHfulEHuhQ9mQw9bUhWpxfeFJb2jk44VRr+n6rgxw?=
 =?us-ascii?Q?d0yRSoKKA3lvmbm9drNzny9apWDgp7g/j8gcRAiHj2EAFOWyPJc62d1C1UgP?=
 =?us-ascii?Q?GPq/mOxb2WRqpWCDWPn2bdXG30VQnaKefds3bFp9wpADqzRAljLikxgXAkLY?=
 =?us-ascii?Q?HMDC6F7oXIirLG5oEc8OrCaMcSKBkK0jdoe0G88nCtXSPWXNj0sT0MDjUDz6?=
 =?us-ascii?Q?pWDT9Eq7qTDlfROChk1/ZQTtvljkt6rdwaz4P7Ox0KmR3DX1MQpvZwBUSiX/?=
 =?us-ascii?Q?pNZP79h3Bgoj43ctd2fIOD7a+zOaFmaiRQd2JPeSc8mM3doe966k7PpmnOvS?=
 =?us-ascii?Q?SLTaTcSrGuWv0qzAmnTVX2vlNlTh48gir2JC+ZTGnYdlpT88Vv8vhUZ/Zrem?=
 =?us-ascii?Q?Ws78vVxBHo6LhFAlu1SJ6/fp8hne8NUWVkPr5UFVGPjswCJK4b0CAISNty7o?=
 =?us-ascii?Q?WeEBDe83VFqfz7FB1GjqWZ9TVGdQijw8qudapQkdgHs8+m5tc6q8rnbFyXvo?=
 =?us-ascii?Q?cxoMemcHllFhKdCxTuW3h7KTHpB64muvWigQF+ohOJqpIc+p1z+nM0/OhHkv?=
 =?us-ascii?Q?fGNuc/alrbnQreDMyz1RrViQ7LEn3rP3EoxuE4F6AgUbhf+95t5DWeJkaSOI?=
 =?us-ascii?Q?RfuQgMk6r8m3BT/yZZWEhcey1tAD4qQ171TghaljW7y5GP+gdZHfhf6xV/iH?=
 =?us-ascii?Q?S5iHElndkyxd0SVshZteTSlNDq2CI289dy4+0fkZqyp/fp53hje+EsFsjswt?=
 =?us-ascii?Q?Kj7w5B1OuKDfieEoRb1G5VQIgVuCmQAn4fnLRg2LdfTHquKCYjDhJeYjVbiL?=
 =?us-ascii?Q?KaHN3aEAzYQCWtFMD495jzeqAlNbn6MKJrvdtdygFUqqAnH2+fzNHrHSuByR?=
 =?us-ascii?Q?czj3l+zz+sWMVUozQStSFFYN/bnPzcVldBB5JNuCGN0UvR/KqqR9kbj8PJqo?=
 =?us-ascii?Q?uOW0wMQKZIXJjCuCZF4WTWfT1gKA1YstxdyPpuLC4D9PLLlylySJisyHkucf?=
 =?us-ascii?Q?nsVFIqo8ypXsUrgj5UH0csZGZ2m1eko5ObVeP8ejOAxliW8pSo3cDa4XawYX?=
 =?us-ascii?Q?aHMKEIHcUvUalL2O/8LnAHQPE9k8TlC1xspAwrN+gU6Yy8+U?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS3PR21MB5735.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d356867-2083-4a69-a087-08de5554809a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2026 23:10:55.5818 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fVm/29ZmWR4AYf0OYUH3apVHkzRKb+2vg7/aWmC4i+0Rs+/EXSbSsXH/+2d+B5VAX+K1cU17zB932mfTnaOelA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR21MB5015
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


> From: Madhuker Mythri <madhukar.mythri@gmail.com>
>=20
> When multiple threads issue RNDIS command requests (such as device info
> queries and link status checks) simultaneously, command failures can occu=
r
> due to concurrent access to shared resources in the RNDIS execution path.
>=20
> Add a spinlock to serialize RNDIS command execution and prevent data
> corruption.

This is not the correct approach as you are only protecting RNDIS_QUERY_CMP=
LT over RNDIS transactions. The call to hn_rndis_execute() can still fail d=
ue to other possible pending transactions over RNDIS.

Thanks,
Long

>=20
> Fixes: 4e9c73e96e83 ("net/netvsc: add Hyper-V network device")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Madhuker Mythri <madhukar.mythri@gmail.com>
> ---
>  drivers/net/netvsc/hn_ethdev.c | 1 +
>  drivers/net/netvsc/hn_rndis.c  | 2 ++
>  drivers/net/netvsc/hn_var.h    | 1 +
>  3 files changed, 4 insertions(+)
>=20
> diff --git a/drivers/net/netvsc/hn_ethdev.c b/drivers/net/netvsc/hn_ethde=
v.c
> index 6584819f4f..b525e287fa 100644
> --- a/drivers/net/netvsc/hn_ethdev.c
> +++ b/drivers/net/netvsc/hn_ethdev.c
> @@ -1310,6 +1310,7 @@ eth_hn_dev_init(struct rte_eth_dev *eth_dev)
>  	PMD_INIT_FUNC_TRACE();
>=20
>  	rte_spinlock_init(&hv->hotadd_lock);
> +	rte_spinlock_init(&hv->cmd_lock);
>  	LIST_INIT(&hv->hotadd_list);
>=20
>  	vmbus =3D container_of(device, struct rte_vmbus_device, device); diff -=
-
> git a/drivers/net/netvsc/hn_rndis.c b/drivers/net/netvsc/hn_rndis.c index
> 7c54eebcef..8a0716df89 100644
> --- a/drivers/net/netvsc/hn_rndis.c
> +++ b/drivers/net/netvsc/hn_rndis.c
> @@ -500,8 +500,10 @@ hn_rndis_query(struct hn_data *hv, uint32_t oid,
>  	/* Input data immediately follows RNDIS query. */
>  	memcpy(req + 1, idata, idlen);
>=20
> +	rte_spinlock_lock(&hv->cmd_lock);
>  	error =3D hn_rndis_execute(hv, rid, req, reqlen,
>  				 comp, comp_len, RNDIS_QUERY_CMPLT);
> +	rte_spinlock_unlock(&hv->cmd_lock);
>=20
>  	if (error)
>  		goto done;
> diff --git a/drivers/net/netvsc/hn_var.h b/drivers/net/netvsc/hn_var.h in=
dex
> 17c1d5d07b..66ed186c0a 100644
> --- a/drivers/net/netvsc/hn_var.h
> +++ b/drivers/net/netvsc/hn_var.h
> @@ -179,6 +179,7 @@ struct hn_data {
>  	struct vmbus_channel *channels[HN_MAX_CHANNELS];
>=20
>  	rte_spinlock_t	hotadd_lock;
> +	rte_spinlock_t	cmd_lock;
>  	LIST_HEAD(hotadd_list, hv_hotadd_context) hotadd_list;  };
>=20
> --
> 2.50.1 (Apple Git-155)

