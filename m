Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B11C83013
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Jul 2025 09:44:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BED81402D4;
	Wed,  2 Jul 2025 11:44:54 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011047.outbound.protection.outlook.com [52.101.70.47])
 by mails.dpdk.org (Postfix) with ESMTP id 516F54003C
 for <dev@dpdk.org>; Wed,  2 Jul 2025 11:44:53 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PFDaixcZAosM9jIGsGji5Jh95//+x1GNZIl7n4UHBPH8vLiChR5u5ZjuucJNbrUpEZs6jnC3pJZWbTEuYgzjpK0+FQki1izLwPJ7qzA4CcLOTfHv5Sa0If/Krb55IETL1el2BXxqF+DQ0fVDlbTLS047PYP/aaa0egXfbmJVCK5Hd1bmBrF5Fyzat3pOYULv/qga1te6e8owN1ZS+T0Jz/7c9HlFoAdjz/BbDaTxpdUW0XNwc62O0gdn+FspkPZP5SuXDRCWR8jXrFm7u5eeN5i0z5bXBrwKhQ+/nEfUFaJs/1R/sRLyHvJ1hYqYtAsCav1yIRxOifPMAItHibcfvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rrdoYpitG3Fe3JpG3SRV5PD6lxYCsYJ8O8UDqZj5vTE=;
 b=WsYuxk/FLpNB/Gm2gHyFGJ2VLY9AWXOcQSn4TqTCKcOI+vZEmm1vZ/R0cdjCaL/MVDhNA7Ix2lj++qa17NtByF0p7EPRV2iiSQcm6dRU9Py4hR+/jJjyfU1b5zvnXXUFSLzaAgpJldbdRL2hV4vTC5XqTPpLZ074L5guRNcF1lR+X0zJMdlEf9g50awhB0jG7qWAvw9ZDmFczKAtALboDOFngxVTQwtTAUQrY2SLfkD2RMt2cYQ+5wZpqZn0t1VaaWFBGhLZQrZqTSTNoxNYGejSl6Oz/45Kjshi0sdpJRzOdRc42LpS4sKehHU/6dtj7SLdMTnUHQj/mOeCwU1XxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rrdoYpitG3Fe3JpG3SRV5PD6lxYCsYJ8O8UDqZj5vTE=;
 b=gm9HinsZYr8LiOGNmeXZwNKyj9YE2gSuqLCtfsN3p4LqNnRHYNEhKZmg7sDfQRB9YHUjPA8VFmEiYzPTXecDJ4pWqacpdnrzrxebHxmnU8EY/AEG99eNOsHwpSQnXTbWC2wtFIqpXs4sh79twa5URRDHRsukVClmeASZdNflD9m8ixn+nRMBjh8P3lKYXhWpqOcE037khzzns9evP+bNLxeKAOX3/ty07TlTUkqN5PZsTivMDsoGvDtGr3UebduVwWhENKRMBycflimLaawzHsZ+UTB8fP49Jn/sYAlkE72cbVUZOIkv6xi8IxTYTUFB9J/Fm3u9hT0IhuvO1Mu08g==
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by GVXPR04MB10111.eurprd04.prod.outlook.com (2603:10a6:150:1b1::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 09:44:49 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%4]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 09:44:49 +0000
From: Gagandeep Singh <G.Singh@nxp.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Vanshika Shukla
 <vanshika.shukla@nxp.com>
Subject: RE: [PATCH v7 3/6] bus/fslmc: add DPBP APIs for setting depletion
 thresholds
Thread-Topic: [PATCH v7 3/6] bus/fslmc: add DPBP APIs for setting depletion
 thresholds
Thread-Index: AQHb6kDAhWHVd2XN+EmhjsYZ+uym27QdTdmAgAFI+pA=
Date: Wed, 2 Jul 2025 09:44:48 +0000
Message-ID: <AS8PR04MB8198FC3CEE605417DEB37DA3E140A@AS8PR04MB8198.eurprd04.prod.outlook.com>
References: <20250630095800.2943863-1-g.singh@nxp.com>
 <20250701042917.3000355-1-g.singh@nxp.com>
 <20250701042917.3000355-4-g.singh@nxp.com>
 <20250701070519.48e74f09@hermes.local>
In-Reply-To: <20250701070519.48e74f09@hermes.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8198:EE_|GVXPR04MB10111:EE_
x-ms-office365-filtering-correlation-id: 861381e0-e908-4e4c-0ac3-08ddb94d161e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|19092799006|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?s7FqMfYEayZqWUla6/31nSxlAv1QnIZChRVz9rTyigak1Mjw2aJtdgO0eCDJ?=
 =?us-ascii?Q?Bmm7ratJcw/lBgisncWELtPSQzA1ivwpUU10YUV9qX9VumrFWi1JC9s2xPNC?=
 =?us-ascii?Q?cHzDXG/+xTIKtGMvkpH3heXde0FC1lSkcOxpzq0ncs1uOUL7ve40rwMQqxox?=
 =?us-ascii?Q?ZC1u5SqRQgFcE6VS8uxgxOyEktMXHiM21ixSzYeAurgWbqQAZnyq5Jif7rDw?=
 =?us-ascii?Q?Y/C0cAQ19x50Kb6QRPvsObbSWmAk9pxE4reYhgJObC+w+hfDAXAqtuFsttQ7?=
 =?us-ascii?Q?3rVuDS37szUj/a2avc85RANr5tMSsV6YI32JHFS5TzsbGlwARy1YDGrmATx0?=
 =?us-ascii?Q?CPO+7H3ABL+VXdkabAYB9wA3+9ZqZe4zbp4ZoB5ka+WJDTjnYF9yJ9kGH+lC?=
 =?us-ascii?Q?Fuz8EKFcfyyeTVsuSpMXo+Tc5RT6CcJiRD3ILRviKM04QKHYwIMjfL3KzvtV?=
 =?us-ascii?Q?fG/v5ngbjETgFxN2ZJoOGxH/9i4oQxviTaxdGDPLuB/oHFUMF/OJCI4oIWTR?=
 =?us-ascii?Q?AoNVOtn7AUZxnElOLsE3LjzXP9mWJXzUJrkLr7LzUGaCkfSUuaP6BmVAh4aR?=
 =?us-ascii?Q?ki8HZUFn33vsc2QpEXzk8aaZEogxP9zx2cLz/P4iaJYj4ZWpGnJlUtKsFVVg?=
 =?us-ascii?Q?n/o6EGPui/BJJlA1CKDPZZbkI8l6VL6JVlpkjpIHIulu7kqL8HtoSLm2UHgw?=
 =?us-ascii?Q?ReQES+Gg3Af7Uh4xWEyL7XIba3Cedh/aiZGgre+0mYTVUrcsv6g03S6nr9SZ?=
 =?us-ascii?Q?grb07kk0uu9KNh9vOqr6gZ6sjGU5jzH4hoGEI7NJiFEbxho2L7pyc3woo7Er?=
 =?us-ascii?Q?eVoYFrqowmGYsd5tFvGXPdelA3vC/BFs71ynw1Sk7ZEOC4YhiEjZu2KlUrSk?=
 =?us-ascii?Q?P0kqGV2aMeKSanZhpOhP/fSnvqVPOvprwXzll8QapFuZ6Z7eU9ytH0ueLmtt?=
 =?us-ascii?Q?aRWn36m7wgsP0EL11uWBQrSMjoKnreYyVv3dgomNWmxbOqZZkEGb6jDvHrYR?=
 =?us-ascii?Q?5tvSXIvs0NxcDZNDHPI4YxJXAbe5fKyidSqiL8mcC0MmhxKRytmhmS3hAhUG?=
 =?us-ascii?Q?ccdO3emysrmcjbc+VCUbJQDxHMu4JpmNnSlCB892oXAIEo1o/Se84odEZg2c?=
 =?us-ascii?Q?yKhrVq2t+jOCcUxdBP35viCBpHXJeRSLKFkHenunu8owe+mvpPK9CPt90pkL?=
 =?us-ascii?Q?1ZhbDAbNNTtbIbi6ihmMxzfjkqyIOXXm1NbyEjqLfrXsk1LLGt2e3D1dcgvn?=
 =?us-ascii?Q?xeumYvuQ8DHvnvNy4w4z+VfnQuSjWhn47n93aX8SClEfBaG/S4H3jj1v9ppz?=
 =?us-ascii?Q?GMKU9xXReQryfm4iVSsLelVHRQMUHrruSLQYTXmAg7c/oGQFSHr0UjQHF0GZ?=
 =?us-ascii?Q?qYPjXekuabM92YI68mqRim+MJRMJ5z69RECdW81gE0c2PvIm4YxN/oxGlEMr?=
 =?us-ascii?Q?XChCZdAt0POcoevjwY08yFohEVEjR0e3zg03wuK+v7P8gXE9J/9GM3EJ8I3J?=
 =?us-ascii?Q?dbZo1p7uFvetwmY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(19092799006)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nPKO9e9z4h+aWFjOSP2/yUt0OkraeKy1GS6RuIXB3EUmui5W9Cu+lpivXSZ9?=
 =?us-ascii?Q?AwpV6tGii0VT8HcTEap1q2N0AWvEtenaoxBHaRcV9b03rNJpXfAPVYtf4bC2?=
 =?us-ascii?Q?CLt+QrvyJFoAMsC7k+vOs4fC8dym9MCZ0gpqGtVb7OxEqOAjdswUDVw9YKNY?=
 =?us-ascii?Q?4TmHqbcvseUm+J/ywA0ZyfDNIQvgA6L23XiIF2Yqh2Pk7R6oWwmZ8C1R9o+P?=
 =?us-ascii?Q?BoY4A1baUpCr6Fok4aDRkf3paoeW8LydHqRALbbYxFgCz2TW2xfBmHUAjZfE?=
 =?us-ascii?Q?FDdC7NxIawnSIfUG8QuengUeqPuc6Aq9DfPYMNV7Xu17+kKBC8v+1aUrffZi?=
 =?us-ascii?Q?ypGsuoZ7A05LBGKk2DgYWOqcmx0B2EGVZJ2MhkWDVOT0QrdRuiJZgiij8TmM?=
 =?us-ascii?Q?aubmKsVuQpMFUvFJ/QK4KLFDfiQcjzKndmKj7bjsCtH4ZAVAwArMpLst3dJe?=
 =?us-ascii?Q?pI9HcnF5KZNUIrIIe3ApO59VJnqrVHLKjjlGXb0M1SFeIMqFIZUu5d7kb+FC?=
 =?us-ascii?Q?JZ4gYcuhMnmnYkUW0nMVAaJINc3h8eb/V4SDrLHpjbik530wah/Hvnb1MN+a?=
 =?us-ascii?Q?dudbQyjHHT6rJ9IhebMnNzDL3XsqoM5xn3cXjrc1QDdP6TW9dBstY1IJCZa5?=
 =?us-ascii?Q?JKLvrl6QNBx1CVeq6Ncz5OAjv3Jz1+BkPGd9zw5yuNGuR6NXtrEWaAR/IT1x?=
 =?us-ascii?Q?+5ls/FxJ4ITFctjh4/IRVdLjJeaGU+fvHewOmzwRYlbxFjkxWdJoeAjZtmSD?=
 =?us-ascii?Q?nJ9+KAkCsvVQLKX38zsAX3tiy1gMUfCoQ/TON1Wik3Zo7R9JsLM0zSPONM8I?=
 =?us-ascii?Q?NaQLlwMuy6RRWQu4sqzh1RCHRBjsrWUGRVIQrEywqJL60uSh6HOzFPIbjQ+P?=
 =?us-ascii?Q?drZ+qFqHdnFmJUUgzfcvL+b1V5gXOvFXcyKF5NCqmZk+VpuKiHoq/uBwJsLU?=
 =?us-ascii?Q?F06NAKm2yqRCZjUuVcRQDUCLb3jijP1sfw9N5yrF8zI0bMkdzp6KBdhi8OhX?=
 =?us-ascii?Q?dPQ+uXuOvlo/7zTQJp5Luu0UtQTe4OLBtEjADV+tty8662wET3n55y6sWKoK?=
 =?us-ascii?Q?R1gvGWcmtFwa2JQp5TkqcdIuyuIsI3D81j4VJhFgt9qxqPhPAn18XTw6xFhC?=
 =?us-ascii?Q?xvfdwWsUJ3pPDx2gn6TWr7anu9f9M3W3m9d3xX2GxfkS5YzcOKRciIzQofQv?=
 =?us-ascii?Q?F81qVD91iJKSD1xpnA7AJHHcha4igyHUuz+BCQML8y8CTspkTUld8Tmme6JH?=
 =?us-ascii?Q?wH50RCZ42UBIFQx/UQUXiWTJUu2eusZ1VvXdqQTLPM+M7y3clB1xd65BJqwc?=
 =?us-ascii?Q?zXhNpeqUY3/P3fdyxsBJzHBEEWGxToVE+87pPf26B9lU3KKr6dtGjYxY3dI3?=
 =?us-ascii?Q?Dk8kTfGKblavIJj13Ks4FQfcaEwDkpvy98XAqA9Ghb4p3l1eBXkzObrdHbZg?=
 =?us-ascii?Q?VnqBlD4Jr/XTsnu/xX1dOVoPaW1p8zr/2vEC+rB4Hcyi9IX9bIFllm0uxTKb?=
 =?us-ascii?Q?8u/yV8kXs2oVOsDocsmCoZpSyOQj8Zqi8U54FqyHtteSp/JYq3DLVoMKx/WS?=
 =?us-ascii?Q?ju00a4VO8UJTmay1niw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 861381e0-e908-4e4c-0ac3-08ddb94d161e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2025 09:44:49.1035 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zlyt5JjzS3AMcvqTkVYh8HKKjdbPZc3E7w404M4yK/fs/aVulvyzJIEkTt02Wmtf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10111
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

Hi,

> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Tuesday, July 1, 2025 7:35 PM
> To: Gagandeep Singh <G.Singh@nxp.com>
> Cc: dev@dpdk.org; Hemant Agrawal <hemant.agrawal@nxp.com>; Sachin
> Saxena <sachin.saxena@nxp.com>; Vanshika Shukla
> <vanshika.shukla@nxp.com>
> Subject: Re: [PATCH v7 3/6] bus/fslmc: add DPBP APIs for setting depletio=
n
> thresholds
>=20
> On Tue,  1 Jul 2025 09:59:14 +0530
> Gagandeep Singh <g.singh@nxp.com> wrote:
>=20
> > @@ -62,6 +72,8 @@ rte_dpaa2_mbuf_from_buf_addr(struct
> rte_mempool *mp,
> > void *buf_addr);  __rte_internal  int rte_dpaa2_bpid_info_init(struct
> > rte_mempool *mp);
> >
> > +int rte_dpaa2_dpbp_set_notifications(struct rte_mempool *mp, struct
> > +dpaa2_dpbp_cfg *dpbp_cfg);
> > +
>=20
> This patch series still needs work:
>   - new API is not exported
>   - new API is not marked external
>   - new API needs a test
>=20
> Ideally, you would figure out how to get same functionality without addin=
g
> any new exported API.

Ok, we can drop this patch for now. we will submit it for next release.

