Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3D3C5AD49
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 May 2025 16:02:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E5D81406BC;
	Wed, 28 May 2025 18:02:27 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010017.outbound.protection.outlook.com [52.101.84.17])
 by mails.dpdk.org (Postfix) with ESMTP id 0E95B40156
 for <dev@dpdk.org>; Wed, 28 May 2025 18:02:26 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZZqWBtyTG/lRnZ0nDO0nDrRNkN4Y8JwvMEImP66sHFBJHymYB7B5yAk2nmVxhJuyYv4doVFT6deLxtX06RGZUFoNrQsYLl0D0vkn7AS32W4/MS1H5rrv9WaRTRXcO0wWNG0ibuX8+34QOL5Wt5+ggEfVgaTci6w4o2tQLrftFXQci0P7liS83lhtlbSPD72UAOs15gbdJVIqG9a54ACt570KGI3rBrMXRtQJDK7amX5qfpYLWn6joj3dBz/J09NzGBlDz9BhZ+HcKwOyWZLylSC5xWangdxrL7t5pkeFX5MbMkRPjfA50bGCFrhgh0mbrm2kTfbZgUNRTrS3qt/h3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jSik5CVEi+um16FlI/ADdaX7/ovcrUMHX5ogZelyaUg=;
 b=fHU+04kskG18ArwBEetZr7yWANPPWT0Y5MapiYuVF2VIcEHh+fpH6Im535O5+I170s6xGys1lUDWZlrpPu7MIfQaQ+Bhto/O5WHdQPqDWjBExaGxrMXK8wjgO4a5DVpkO7eSxdRPo2z5Y1/2GMaJOKq2AG0+o1pHoKsuETrhRINwg22DtsWFcvwBTbynQpDqVel2PxHB6aBTb1XFPzlPKzAhtasSp2LYvOn3rG7QLFJzOIBVI2QCTxS7WJLB4+ZuIiaw5GhusjUYdw+AQnx6UBqKPQVSYYM01OU+6fO6xIr1MjMiffR3Yqa35ojvJQw+39vla31/QNK60/GbnNfz+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jSik5CVEi+um16FlI/ADdaX7/ovcrUMHX5ogZelyaUg=;
 b=f9dXKttrPozkxoVhFbtVbslPJ6J2XtBdGT7AjDX2PE08Lbi0tVeS3x3o9QpkcZCxxBcx9krQyS9xlSNHl8zYwT6Ls+07HjJsIIJGHEBo2gX21A89l2N+joDyqNSZfc0BS9qK4mQd2riM492F4AfQyGKVcKl+0J8WnpbvqXkH4ec70/9lyg5P5CuHYK1UqUep+UMwcQ6W/8uEScZruYRSunMp4nbQcZBJ6V8REV1RtpaqciUZb7r5u/bmyolVrRrJiHtpGV5eb/ThSi3pYo6nbh+S3SHGcfn3xMNKxQunfXGTVxcsK287Wo8gicq1U+ilQ0ZPZfQsBqFeNqRQl1chIw==
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by PA1PR04MB10770.eurprd04.prod.outlook.com (2603:10a6:102:492::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Wed, 28 May
 2025 16:02:24 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::367:d59:375:fb87]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::367:d59:375:fb87%5]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 16:02:24 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: Nandini Persad <nandinipersad361@gmail.com>, Bruce Richardson
 <bruce.richardson@intel.com>, Wathsala Vithanage
 <wathsala.vithanage@arm.com>, Ciara Loftus <ciara.loftus@intel.com>, Maryam
 Tahhan <mtahhan@redhat.com>, Julien Aube <julien_dpdk@jaube.fr>, Nithin
 Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>, Potnuri Bharat
 Teja <bharat@chelsio.com>, Sachin Saxena <sachin.saxena@nxp.com>, John Daley
 <johndale@cisco.com>, Hyong Youb Kim <hyonkim@cisco.com>, Ian Stokes
 <ian.stokes@intel.com>, Anatoly Burakov <anatoly.burakov@intel.com>, Vladimir
 Medvedkin <vladimir.medvedkin@intel.com>, Matan Azrad <matan@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Liron Himi
 <lironh@marvell.com>, Long Li <longli@microsoft.com>, Wei Hu
 <weh@microsoft.com>, Devendra Singh Rawat <dsinghrawat@marvell.com>, Alok
 Prasad <palok@marvell.com>, Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>, Jochen Behrens
 <jochen.behrens@broadcom.com>, Paul Szczepanek <paul.szczepanek@arm.com>,
 Patrick Robb <probb@iol.unh.edu>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH] doc: fix anchors namespace in guides
Thread-Topic: [PATCH] doc: fix anchors namespace in guides
Thread-Index: AQHbzxBUGeoNrnc0sUOdapZjAsrInLPoNWTQ
Date: Wed, 28 May 2025 16:02:24 +0000
Message-ID: <PAXPR04MB932862081D4B0DCB1D8864288967A@PAXPR04MB9328.eurprd04.prod.outlook.com>
References: <20250527140435.21361-1-nandinipersad361@gmail.com>
In-Reply-To: <20250527140435.21361-1-nandinipersad361@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9328:EE_|PA1PR04MB10770:EE_
x-ms-office365-filtering-correlation-id: 227b0037-92e4-45e0-2b95-08dd9e01097e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|921020|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?HAZNmEryeiEFtUg6zM4fqo75TaZjTX8Cl7bq7d0RRPTC1xcQC6CRUndMUc+9?=
 =?us-ascii?Q?75BVAipWA5Aot6/Qoglln7tZPU+4KlJkJUo4t46SRf4B3uOVj5mAT20RDILZ?=
 =?us-ascii?Q?C3pKuE2Tv0NrxbuWfYC0frEjL26bZO2dKyQftxJ0l3FUQawjoQxLyGmmKH9K?=
 =?us-ascii?Q?1CA5f+qwzIg7Www7i3XxjgaJyRcz4lmHmNNRDamlWLxVLK58xANsajQjxYnx?=
 =?us-ascii?Q?yOh3jLFNJh7tMVV7UQoytyWGGWRnYEbFLuHhhDRxaPhssR/3XwaKQEjnw2ZW?=
 =?us-ascii?Q?7mqDdRU5Fu+qVoPPN9zw6Al9i002ukyYm8RigvVV2W7BUeMQzBEh+DF+uPMr?=
 =?us-ascii?Q?YYdoEgnk8TFPjt6ym7XYMiuwKCVb5c1WFm08b5oOMcQUllxCIsJREX8f1Tgi?=
 =?us-ascii?Q?dYnP9QLRpssMbOKhkZzDrMHAlpbTz/XGmoPjZ59cDcTWLx1E6ZidosTun9ZQ?=
 =?us-ascii?Q?fv5lnOE+CskL1fqKAczGGnxozq+u8lbRG7Kxz1Q3Y7u0rqw20MlVaH3ZE2iP?=
 =?us-ascii?Q?3gPjNGM+krDM6TTd5PRLlK3SZgdATX0vq7s/EQgPyit3tP7zCXO8fgEgPp1I?=
 =?us-ascii?Q?1HsMKLOw8URP/CNb3gY0LTownh8cYIht1+emnEB5YRHu+eVXLqIo4XlQvOkJ?=
 =?us-ascii?Q?hL0IY3gAJzOsmIw4AEkiSQGi0RlzJsC783X0yM/Kj5RMUqhciru0ZaPp/SJL?=
 =?us-ascii?Q?zYGlu1qMJ45XwBarmRoN3vWf1rSqu3vvqaMX7+eXGztKnwISKLDVbSwJKYFu?=
 =?us-ascii?Q?dGEnZC6/JseAz1e7pCcQviP6WIGvr4yqMAjz6nQ3bslcNBp+EwgzOy2SOJRV?=
 =?us-ascii?Q?gsPFCWoK9uqZ455SbnmMcBtZvB3iwqGjiXSnASxcOV3BmDF8kyu4Jz94R24Q?=
 =?us-ascii?Q?JbBvFEq/DRRusquDvAVVXjbVisLDYiYL7ktHA89C5go/CgZFR8xe5FstUNV6?=
 =?us-ascii?Q?jszg6i+09DpPbipNKX7RbpyL0xRWfNO5TNurfNwsJJ7Vx19zwwjDKdpTtFAt?=
 =?us-ascii?Q?6rd8A/pIAxr/V2MHZhP20M5VRl0m1B++OuXwxAY88J/aQDwbEARec++r57Ju?=
 =?us-ascii?Q?TEXBp1+ByQftOWVwU5Ld3i86q76jJVxTVqGS9XMAJW3ZhHf2pbwX7lsH9ZAV?=
 =?us-ascii?Q?rCTLU5D6CU7eamzmwLgtQrWDWOingIgAGKWdaHVyvixkSgra3MBosWLSlnC4?=
 =?us-ascii?Q?zEYG0IlS8jwPPRIIXTRgND2x6oq2ca00H/xN55adcgZRNItphR4Vio1z4ImL?=
 =?us-ascii?Q?/9e44Q3+YrRFaKdeEmx9QeqpJAjCVhDlnlZ30rqswIvRn/+Kf91wwfZtyP0s?=
 =?us-ascii?Q?DdeFLyoMyjNSv/0UlB7uaiUOQ+Zmg27HimWcSoWWdLpCqFL7rdMwOQCRrcHq?=
 =?us-ascii?Q?u8fCHMLj9+TpAmdMwROIFLsgDLnDAML8e6KuGYQlCXqboEM42WUCwDwq2nGW?=
 =?us-ascii?Q?GRsndrM650l5NDQ37tXDz4pzEhn0jAb+KTO+p2NAi6OnwUkl8fXK1t+IepvU?=
 =?us-ascii?Q?hLuHr83KtNjmmGs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TE4xbuDWzz0yYJtLqzfIQseMt5cfrfY3IXQmyWcDi6VeuvQ/0e3PLOKekWCg?=
 =?us-ascii?Q?e52BbGVm2aSDnC/LO1Zpnvxb2A5FkOM297pdTVHRpQTJiu9FmYZQw+UKH56L?=
 =?us-ascii?Q?cgVg2rRfQREaAWjrfOACoj/TFmKVdabk/nhQndsxS4Zty46JJ/5p3MghkNbo?=
 =?us-ascii?Q?rEU1NZ9/1t5/84n+k8U1qmy0iNFq7/WPQGGCr08FO8ypykkZm5N+nw6nz5QF?=
 =?us-ascii?Q?X5dP/16NuM6wx2Ef7R6aUMzrqyOr8iQpKvnbvhACrxmo4YOuGdG/DugdhsWI?=
 =?us-ascii?Q?z42DxrqbOCkIOc+vpWkxtRxekNe2maEiZNMRGehE60V6hCowzWBsQ2L76hFZ?=
 =?us-ascii?Q?bIf0zka3YrFND403zkNTFk78jWR40h+JMz869qsk8OmjHHGa0b+PO+hkMpK7?=
 =?us-ascii?Q?GYedJb4sP/V3X3+Kz/loyyjxqv1nSk3mjMzMSsH/aPGZY6Ewuc+PrQXwnlS7?=
 =?us-ascii?Q?vgfNwhMjW+Hp0AQ1moSxlBgFY8ZC29TPYe1kX0WCh/l4QGcNQsP5BYyA2FRO?=
 =?us-ascii?Q?c4qmw5Pfn1ou0OcOxFBKbpNXaa2LDjLaVusNc74aD0agsiW+VHWoldNFhd6w?=
 =?us-ascii?Q?jBZLaFC5XcjxWLVYmWrA3hwrxluHnviNAsy+p5UhPE3qbgTRuLllbyTnc9F2?=
 =?us-ascii?Q?nlLuJxfURUz8X3wDr/jv28deXs4W1+e3qDaj6YiEI8tRWdItFwrEHkzXB/+h?=
 =?us-ascii?Q?gqoHtmi5IahjKCzMZCUbz1QooQno18OvIZ2XTT/6+hrkeRj9an6FuRg+GP5Q?=
 =?us-ascii?Q?Fj8sSqUER5lr1pTSYov1uB65wLi2qTvaybfqVFTTidI+LJzx7/Y6v9O8vlLb?=
 =?us-ascii?Q?pK5EHS8l9Z6GT2CCJmsT2ijBBZ3pDCVBRwfnRFmIPyYzuxulRcZgZInYtUBN?=
 =?us-ascii?Q?9n5TsqvT6bAJ9xHNfshEj8k2a4h7j4riu0BW++M4n9jDyLikNl1elvsOa7SX?=
 =?us-ascii?Q?AQiaDpCuF9smfIBdcxqKQjboMT7iTTjXssDVvRV5FMkLGeSfnS0BXUt9+BVJ?=
 =?us-ascii?Q?gSYBHKM/ZXiJieasxMPEGfiiBUBDjusVJcfvKBB8m8zPrsCvNt0RjGFGZg3q?=
 =?us-ascii?Q?2AZjPtIjEusp/sA4Pdd5sxmRFPtzdwcuD5wT6tJX6YNNPXI/qSU32p0JLTOO?=
 =?us-ascii?Q?2dIZF/KkrKkXHmT7+zHLvFRzC7Il70zwUNxFO8SalnIu7HHfAzie9kXxKk1B?=
 =?us-ascii?Q?Sa39PiOMkN7o2BPyPtEk+z0kcUvuK1nlTPFqMVVC9uQHXJm86katay1JUuQk?=
 =?us-ascii?Q?rKvKxdHDuPRpvr2GkIGY+slGbXZseNX7nsOfTYS58+w6r6SOCVyYG836JxeH?=
 =?us-ascii?Q?1sMPnPSqvePTQAFxXdbtsdvk0TPd3qlZx2f+0s2BLQmXGEqUh536oA4DYiWM?=
 =?us-ascii?Q?KXFnD/vgRz4PMvaI9eWIqSydhD1ncL6zDBvGFZyzQWCcnemtm9ulrWmkZJa8?=
 =?us-ascii?Q?DejbDb3lc/Ic9BLwP0dPXXTVp8uA4Dyipffhg99qltM0m+RE9luflSz8tf6p?=
 =?us-ascii?Q?QoSOPZghof29kTr4uyou7OJra31SSdnCJMzsb48X9ovYwwgEJ/tehhI+jsZh?=
 =?us-ascii?Q?OLAqTkWp5EaYQKTemrZotWAQ26Ss5x7QQjr6Rc8l?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 227b0037-92e4-45e0-2b95-08dd9e01097e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2025 16:02:24.7816 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uQc7ECMIGTwKGab7E8cvoMhXrTrVEAkiL1E16uxAcm9QZq5CmYaNuDh+7SnNSPczzOovLMY1fksb1XT+gde7LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10770
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
> From: Nandini Persad <nandinipersad361@gmail.com>
> Subject: [PATCH] doc: fix anchors namespace in guides
> Importance: High
>=20
> I modified the anchors names within the guides to have a a clear prefix s=
o that
> they don't collide, based on advice from Thomas.
>=20
> Signed-off-by: Nandini Persad <nandinipersad361@gmail.com>

Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
