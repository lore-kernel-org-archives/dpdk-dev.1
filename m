Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C244BCE8D6B
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Nov 2025 09:11:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1814E427AF;
	Mon, 17 Nov 2025 10:11:04 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013011.outbound.protection.outlook.com
 [40.93.196.11]) by mails.dpdk.org (Postfix) with ESMTP id DA2A24026F;
 Mon, 17 Nov 2025 10:11:02 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hsCKlyd9cFcdROli2EumH9I7FJ/NDw/fQN+pICFggxZLunuRGKHJhw4vpdsRgo6ZYckOnhn9skbnyMn0eeLOwd24Id/Mm3zH50SNc+BovGCUIh0GdO8OwWUKo+OQGkkVnBcKGFI3ySNTlFd2NWFU2o8Q5qO+DgtLE/8BREWnALvy8ynmvKaDn0RWTNLMsD8CID0SqjzgAdNupMK5jHPwN8xA03vq+VI6LXLk0S9AKgW0cq9uaqV347P8xiZQPmjOS+MRC+JtTkp/mPNP0WQn0blSf06Uf6zVftoTo3YCLS7ZTd5c3L6rbRUi53pd/FnIr3bErfeDOooGV8PKwmbcSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vDwKW8YM3AXTdz7GGqGJN1rtCNpVB5IkxcB5Pca8gzo=;
 b=CoEgdlKRsnCvw0W6BXQ6fYtRdyugwKGCjABgmSwvaDioRpGTs8vsj3dPKJiDhYE60lJoytDulDrl+VvXLszTTH8Rt8nYVld4MCNOHohwHh8fhP5I3Ca4tackE9+8sCknA9cnIbfFkLW3QYvTa8huWLmI5msxrofRUiNtbOzoPxbO6niNDM+mxGd9goEtt8jCWFhmt7vxzIpVIZfMO90qDRaS/FaC+fd8E3ZL4Z3Nhrow5B4QZmwt9FUArBHWn05lPP5I+Kto6U70jerF6chdyh9M4rrlMf8wmHUq4qI3H4dEK5h89sFknTbXSRy212YXsCBWdx2zR+RtsT2QX4TEFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDwKW8YM3AXTdz7GGqGJN1rtCNpVB5IkxcB5Pca8gzo=;
 b=IxLK4Ry5XZph1/ygq+nxTlWMFqBcPmeQXATMtxGxkYvooRuWi9Du4yBdA9OW6KKt6CuZZh48lyVAGbQK5GnaNVM7MlG9Xtm+YopoDdaqBRpF/wc7ldyMyQzAAueaWFW6BuM9fgcG2ZSuYwbNfuA4LfQzIai8PCJlHo08FcoVNvKnAkvYGt8h5hcQr/HdRyZZRxZDI9g0UaaNhElFo7RClt4GYkyFsSpvPvKgiVtz4PevkfutqrmVrOdmAXg265DI64gq1Uwt5VTaKtbQiyJj23WKJlLK/OHd13KenGYU3JLCRzZlBAkQGXv24y0h2AkUUYpi5Yv+vEwLEmFgLTfG9A==
Received: from SA1PR12MB8699.namprd12.prod.outlook.com (2603:10b6:806:389::15)
 by IA0PR12MB8350.namprd12.prod.outlook.com (2603:10b6:208:40d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 09:11:00 +0000
Received: from SA1PR12MB8699.namprd12.prod.outlook.com
 ([fe80::670f:5750:aabd:17ba]) by SA1PR12MB8699.namprd12.prod.outlook.com
 ([fe80::670f:5750:aabd:17ba%5]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 09:10:59 +0000
From: Itai Sharoni <isharoni@nvidia.com>
To: "NBU-Contact-Thomas Monjalon (EXTERNAL)" <thomas@monjalon.net>
CC: "dev@dpdk.org" <dev@dpdk.org>, Maayan Kashani <mkashani@nvidia.com>,
 Raslan Darawsheh <rasland@nvidia.com>, "stable@dpdk.org" <stable@dpdk.org>,
 Bing Zhao <bingz@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Slava Ovsiienko <viacheslavo@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Ophir
 Munk <ophirmu@nvidia.com>
Subject: Re: [PATCH] net/mlx5/windows: fix match criteria in flow creation
Thread-Topic: [PATCH] net/mlx5/windows: fix match criteria in flow creation
Thread-Index: AQHcVJjg83j+rU3JukSBEfy5CKIL8LTxMwoAgAVmdik=
Date: Mon, 17 Nov 2025 09:10:59 +0000
Message-ID: <SA1PR12MB8699670ECC88DA40004DF41EA1C9A@SA1PR12MB8699.namprd12.prod.outlook.com>
References: <20251113122642.1193-1-isharoni@nvidia.com>
 <11095513.IZOipudI63@thomas>
In-Reply-To: <11095513.IZOipudI63@thomas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8699:EE_|IA0PR12MB8350:EE_
x-ms-office365-filtering-correlation-id: 6310b105-80cb-4bf6-390e-08de25b9397d
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?l0FBMZSDDOGALT+i2rYuUvgPaCcrFwZWnji0+k9iYMiSv2atdqUXEqiNka?=
 =?iso-8859-1?Q?JzxJp2OB/hE/2cX7X4fSlA1xnwKzkC589X+CphJx5DeVVRkCsCNcnO+My5?=
 =?iso-8859-1?Q?yE0b8L3x6K+loj/W/W9Nna6C7GFd5Oj62GRPng5eKupT4humIl4C3jcK/4?=
 =?iso-8859-1?Q?nTuhQu0f/5Gyu8Cp2AVrcx98l7FzP3h9fjD8XEBsdap0R7xooTwKn0TWRc?=
 =?iso-8859-1?Q?nlUwKsVWPFZO4ppbXHBVv3RrM72CxsZKYGuXk+JMqcIhI5jUQf+VkygD0e?=
 =?iso-8859-1?Q?l5XHE27E424a4k4rZ6Ozskld+dAf46yN8PDDJEsp8TDlmOp0CYjCIjszFp?=
 =?iso-8859-1?Q?+lTv8vWQQXbhsvKYR31cz2ZQPUPzqjoKKG+5YIGvHdzERyDA3A4vtqRzqz?=
 =?iso-8859-1?Q?st0Nevrk3aT72BLdkjIKXbExWDa3P2gvrQ1huPLdDRXAF8lqZ+IIkoWR9I?=
 =?iso-8859-1?Q?/ETC8ZxQY6252rSopjWoJndYGAkAO+/FN2yrgbl6GUZN7WDA1Eo8Wh55vW?=
 =?iso-8859-1?Q?7VVDN3RxEFiudPrkZ85K7ZZzcM6wuPQ4NRnrFUwoRob1439U/GMTASj+Sh?=
 =?iso-8859-1?Q?8ubbogoEEQdSzB/Dv8S2/poT6adTOhlezIt6ttWbPbzFHZjwh2PNKn5Qmb?=
 =?iso-8859-1?Q?Na1j6xC4+QDALOEVpWLF+sTUFFwwMR0xH53DYsNkt385KbEvTcRvRDF5G1?=
 =?iso-8859-1?Q?JdzJFLAL0sEAScMGQhN6bxBJDdT+TPOkyYO1jVwPFiad3A1cQc2YKviAJc?=
 =?iso-8859-1?Q?2Sps6wY+xybkUSZCvssCHLo1/1A0EBTPrbDg21Q6TObOVegkMjkCiA5wea?=
 =?iso-8859-1?Q?ZbZrxROAHSBkuTcuSxLDI0H3sUFluq/YU8SN0e2tH1gtlJ/r+tFRjS32Sf?=
 =?iso-8859-1?Q?zJ3bmR0hAQ8CaQEUwJOkQ0/T4eAMw7yB706vvZjhEeTM4391rsaKysFU8M?=
 =?iso-8859-1?Q?L6XFm1zZdkWHwsBmrrrADcA4MLoOfQJ9Cieq9lL6Clco8WhRyE0ovVCMlw?=
 =?iso-8859-1?Q?NruXYnNjFRGI0NvoUxhYFaaw7Eh+26AkYn+u3u2nD8z0J77haRiLTIEA3y?=
 =?iso-8859-1?Q?eJeC5H2eRBAaeFXpREEao0feWwccJPvEobNxmkCb3ow0zcSnH6L8WbJdpb?=
 =?iso-8859-1?Q?L4Rf9is4iXF2MlXmtD3Xv8HdyL33rwUDg+6wM6U6Posx9dhaFtr+3sB3rb?=
 =?iso-8859-1?Q?WVVpwuWDLjZ/QPHonmH02DA+tEtVW8zWRi2OUgBhgZh+IvCxRSO5xCel3x?=
 =?iso-8859-1?Q?nNrgyaCBS9YA9yUbovrCLzPuhfJoKBJ67G7u1moYQxg6jbNSriRV+INvRF?=
 =?iso-8859-1?Q?rdR5IdTv4bKg9hDthtoWHsvP/aLYLd5MGnYyJjr83+506MHIf3JGeWep2y?=
 =?iso-8859-1?Q?yYmWwqhN/CuJ8WiHWx93pUOSA58qMrinzRCpw1vd+U991On5AdJhhxIgm0?=
 =?iso-8859-1?Q?FpXDqo7SmVyy8hQZu79H3MYrsfptc5CiSG1a7S6KWQmgdC1YbhqonV+/8i?=
 =?iso-8859-1?Q?mdNm328wW4mwCpRVszqKP1Q+KvxXh6DzT8LP9O+ICoiCaAJ8ZEJmTcOgkZ?=
 =?iso-8859-1?Q?x2vtt8McxZ1tSwySVK/88O5Y4oJH?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8699.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?l7LvJAfH+zBcXHFW/F0sGqFdNmjlPt/zKPq2czbk3pabnXYIto5I32HQ2v?=
 =?iso-8859-1?Q?8a89krcO6e/535oPsjZRzEoyJ9JPVIvirctx0pdy9fBYDD+VihSluL8yKp?=
 =?iso-8859-1?Q?zE+rlqyyRFju65mhLvuVs6ikwnC7zDZDwz1m8C7NqYRu9w9EDOxzzRfPYO?=
 =?iso-8859-1?Q?tW9h485n/87ebCZzp12cQcR2iTMRZtNo03VFawv9Uec64YAeW3zjLDeGvK?=
 =?iso-8859-1?Q?zj4fychc5j6Ig6749bw+GMXiXO6X813hNhhX/plUVYfrU2JapRnH7ZrH1b?=
 =?iso-8859-1?Q?i4ia1g0gfyuJoEoHurK5extlQzND4OF4KGHyELsPmE9YpMMynj2ADKOcA6?=
 =?iso-8859-1?Q?J8Cz97/7kbQMUO1EM8Go43h4crGRi0jESQBbNaejEvZrkTiD3ZWmGM9Pze?=
 =?iso-8859-1?Q?LTVA5i4jwG5ueS3AtjBeIpNEQ8UGXux7bMMZ4jQX8xrVBsIckPrFeK2V8V?=
 =?iso-8859-1?Q?MzXYZP7s9WI0WUlWIiX2hcvsL5H2NbrmIK76puyLUedDv90nbbR/oVfE/h?=
 =?iso-8859-1?Q?R86kdJuT9Brmwn824tRUlQkKH5HUiFaiLwUUVOvxS8FrhdwOVPZ5pNpx2r?=
 =?iso-8859-1?Q?4Qe4ywq9C84hik6pHnNGdfVA5TRNOi3YPmP3Ee2xdeA5q9i7tcaBw46SMw?=
 =?iso-8859-1?Q?VctwDZhsJkQpauy5yZLjICwixcQcJyJO88HzQLMJJplTBV9MRroou3Udc7?=
 =?iso-8859-1?Q?tvAH/d5Va9ARuU4QW9v0lxAcOqOCV13GXyByEWeGNrINhPxrTXkEnHKUbq?=
 =?iso-8859-1?Q?jODSuk+yKauVoIEXQQ1dQXrx1QCOvuBpuH4Tu/LeslAD0TJGQtl/U2ZL8s?=
 =?iso-8859-1?Q?1T79s1bzMeqApdVanesYN9AaxPGg7ye1k/8i8C/QvYYEnZDHpmQjzKsYYV?=
 =?iso-8859-1?Q?e8+HDcQG7vXgV3yQoOQJSqhPzpbrubVQYCcDvrTaeg6KVoN/FzDEB97JFJ?=
 =?iso-8859-1?Q?0AZfvbb4GOdko73j56d5GCxSzg23yQB2Y/+nLf0afRuuA0udHGzBjgv4th?=
 =?iso-8859-1?Q?tnUGdENPq7FU2UrMTnk/dJ8RPDakoeqxqBal0tOdG9N6tEqyY4tYhjZ812?=
 =?iso-8859-1?Q?oEXGqnrPMP/iF6CUX5C/fXud4QuhJKi8aWm0kZwtZoQZ4OAj/WYdrYYKyX?=
 =?iso-8859-1?Q?0+JTiGGjR0igUn0RWhC3sE/XMWNUJwsbIrsT3Fwqsik0Ak9qu0GIQgvn5n?=
 =?iso-8859-1?Q?8nyF6VSSxbB5kQbp1VjAhlvfJXgdI5cZ+hX6YVmQjHdlMJDB4DZNGmfFN7?=
 =?iso-8859-1?Q?mEmeYuP7ByU5c3UBmKp3QMLgq34nVSRIoUp23vUqstt5+3AlX6Oy+O1Oqw?=
 =?iso-8859-1?Q?mWpR8LYM8sWsGSFC69A8cGrg8mz4y5nOOP/Rs48NeqNVz56UVUKwKrO6Rp?=
 =?iso-8859-1?Q?RIs8MCv0MPAzDCyhPDkAFCiAAiYfXlJTyk1JecZLEviH8MX381sowmC7ph?=
 =?iso-8859-1?Q?PF/KuuX6eI3dIgQWgwlFiw0mN+Wv1TkmIO58Ay0bqmErQs/VPjL5Lmr2Gt?=
 =?iso-8859-1?Q?zfHgoeagggaj0haOtD5hG/Zi2KtE0lXllZPeCo1E0SQ4yX87beT9J1YONc?=
 =?iso-8859-1?Q?XaEBREdvRibYwWOTXQ1ImGGVNVerH/MLhPzYZwKKgp1YAsLwLimZG2dgJu?=
 =?iso-8859-1?Q?gW6CTSOGIea0M=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8699.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6310b105-80cb-4bf6-390e-08de25b9397d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2025 09:10:59.6274 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z9Xrnm7hKhr1CoFYfy4hsHZNmDtqz3jhGtOK44kLLtTYPqcWn9wAoLdVlB4FtAR+xKmnTrSPmvBKcfJkNeSqrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8350
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

> Why adding only NVGRE?=0A=
=0A=
We added NVGRE support in response to a specific client request. =0A=
Unfortunately, we don't have the capacity to test and validate other =0A=
tunnel types for this upcoming release. We're focusing our resources =0A=
on ensuring NVGRE works reliably.=0A=
=0A=
We definitely see value in expanding tunnel support on Windows in =0A=
future releases. We can consider adding other tunnel types (VXLAN, =0A=
GRE, GENEVE, etc.) as a feature for a future release once we have =0A=
the resources to properly test and validate them.=0A=
=0A=
> Should we mention which tunnels are supported on Windows in the doc?=0A=
=0A=
Good suggestion, I've added documentation in v2 of the patch. The =0A=
documentation now lists NVGRE as supported and notes that it requires =0A=
DevX dynamic insertion mode. This makes it easy to expand the list =0A=
when we add more tunnel types in future releases.=0A=
=0A=
