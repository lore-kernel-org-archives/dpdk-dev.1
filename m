Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE8AC8302F
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Jul 2025 11:38:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8E7E740668;
	Tue,  1 Jul 2025 13:38:15 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010038.outbound.protection.outlook.com [52.101.69.38])
 by mails.dpdk.org (Postfix) with ESMTP id BA83F40615
 for <dev@dpdk.org>; Tue,  1 Jul 2025 13:38:14 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U3+ypOLg/VRHa7nW6QxwHxZw+0joQeQcM3qJpwoOZnYfH2DhnyOp034ye9nIKxT91cAxNhxo5+2/53F5ICnqz8UPp10AsOkQo8ERXp69ejNiBV6z0rnrTwnpVoozWBR9APmQPyP6uVfEFvCKYBtilU1BFnZ70lbNpgp6GkhKanZIXzSLJ1mvVGR9fYhe5IUSzPy1BZd00OrCBXAJcLADPaUk7xc0pqnJyd9mnHgdqO2A0REqIWSGqjttXJXvxLA86oG4Q5+d6+K/QKJeIOCxquFH77TY3FTioptuMOrtFa9BSUYPZ8g/iDc409sI33nHGNan+o1522m2CWhoarMxkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iE+B99C/Nkj8YIuE4hgFcX+gaggC2gncbFZW4a+56LU=;
 b=KjwvfPvvd4ZloWg9d8b42UBsYeZUw22KOtSvzl2WvaVH5vE7OsAhyknogN6V6cIAs6lWBc2SogcEw1SpxIg8dDyaOt6GVPC/opeSIYTkDJsWF5F9Vm/PgFtUfHJPSaE7Wey/9p9selFI15UOItvXvPdyapin9e8XulhMgD4/T2exTvQGIHKPscuP1eWo2JuF4hVKV7xLs2DsoMNQKLs6DFf184mgFzqvuJARq8j7nzVNKRCSxqhS/zMIMw0xhl04lS/VNgamxhtwWkNttBlTzLKSlTFSJFTCkv4JBdERB1QqqpEsIobsaHczqKRjWjodps1VHUVkbqCh3/S8uRgpdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iE+B99C/Nkj8YIuE4hgFcX+gaggC2gncbFZW4a+56LU=;
 b=j0mlUhBApY8RFj5KbKpgDIPtWF642uW/VTNzrrHZfOqbzh428e2mgojvZ8Yj4b7R/pLoswR4UoSVMdSZ3PTqjjYAp4meWpaBWECUBihb5YpeCojon82SqChK8XTzvnBaqOtjOAA9jEiyo5Qckzsm6/Z4E6B2qZpcA9ZaXamEJt/uzOW5bkYubDwNmpjKkDecxFDIdwJf/Wfm9S7T1Ch/iHgh8DCDpBKvMirrgSSNa/e+5SGne8ysEf1EjDwBr73j0Yz6OXZBPrBTOQ1FGikxchWPhday0mdKfqEnOLicDSCZVsKMgreKi/OWc0nTz/NP0wo3O/HHtfmXFtrm8EBvkw==
Received: from AS8PR04MB8979.eurprd04.prod.outlook.com (2603:10a6:20b:42e::7)
 by GVXPR04MB10756.eurprd04.prod.outlook.com (2603:10a6:150:226::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.31; Tue, 1 Jul
 2025 11:38:11 +0000
Received: from AS8PR04MB8979.eurprd04.prod.outlook.com
 ([fe80::d766:4f5d:d928:866a]) by AS8PR04MB8979.eurprd04.prod.outlook.com
 ([fe80::d766:4f5d:d928:866a%7]) with mapi id 15.20.8880.029; Tue, 1 Jul 2025
 11:38:11 +0000
From: Vanshika Shukla <vanshika.shukla@nxp.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Jun Yang <jun.yang@nxp.com>
Subject: RE: [EXT] Re: [v4 01/10] bus/dpaa: avoid using same structure and
 variable name
Thread-Topic: [EXT] Re: [v4 01/10] bus/dpaa: avoid using same structure and
 variable name
Thread-Index: AQHb6RUsvFGTkkUVcEOWTICPu3CXdrQdJuwQ
Date: Tue, 1 Jul 2025 11:38:10 +0000
Message-ID: <AS8PR04MB8979C4E6DDE232DABBCB9693F441A@AS8PR04MB8979.eurprd04.prod.outlook.com>
References: <20250610091411.2500413-1-vanshika.shukla@nxp.com>
 <20250611071039.2939950-1-vanshika.shukla@nxp.com>
 <20250611071039.2939950-2-vanshika.shukla@nxp.com>
 <20250629093037.1cd5f92e@hermes.local>
In-Reply-To: <20250629093037.1cd5f92e@hermes.local>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8979:EE_|GVXPR04MB10756:EE_
x-ms-office365-filtering-correlation-id: ffbb7524-080c-4c89-c31c-08ddb893c1ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|376014|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?yfCcbgrECXy4N5bj4RL2kh/H7Lo3D87+U3SioC5GBqmNqRu52/r8KO1AXuXp?=
 =?us-ascii?Q?IJ9CP7fw3EkoRINW8BT11M4deXy7ikKRRXAczGQyT7HepiDsJM8L2elTqHQM?=
 =?us-ascii?Q?o3YElyb3Q1UWEMkVNsQxKPs/mnG7a5GeWAmkzgZznPp8Tpl7LG7WMhe2kewH?=
 =?us-ascii?Q?XzKd/oa6ARKD8/Ijn6AXXATrkczCGVautcTOFgpUzS5lE/WJq3pFdz+mJwK8?=
 =?us-ascii?Q?FSPNexPXNMLts0qbTc/TBCwm2hDQW3KmrjF7+ZfTTRTgF1w7K0lluIigcH0k?=
 =?us-ascii?Q?XQaIMzG0S4OWY/gefPZ6R6ICCnSGEW5qJOK//+peD8ikx7b3KLbA/BmmYalL?=
 =?us-ascii?Q?3feLOHoXD0jpjZDFlNgDq88JfKQQrELnZ0ddH+LMcx+K9J8Tu4osl+l69/pS?=
 =?us-ascii?Q?fnYkRC/b5xLS366/aYMdI9PV8E0Y1HJpN77c9ADc4Iv7cLqJFkAS9Xmnk8BP?=
 =?us-ascii?Q?HrcnFLY99Jo9QP8Jefr2/Keav9g1BuX5+wnX1WLQO8Ej3PY7tDYxIaM3OhiZ?=
 =?us-ascii?Q?yXeR003cLxiVxRiz+RQDxswKgAaAPwjnBcue3vye8b6wQGCFKgWdGuaTYnuQ?=
 =?us-ascii?Q?/WGLbGJbQBhabVBVA9RXqcj5VR65DSFifBo79USAfB0QqAbtRbDG5Ytfrxye?=
 =?us-ascii?Q?JwT0DPKInz4mVb7rWc3jxLMNbbaPMy+HgieDEJAz44J2Weko02hZUsaqKrv7?=
 =?us-ascii?Q?72ok4mUdQd9fMgsQoT1P9azzWjfG2yYnTxGk9I4sgeU7w/8VYTR5SNc2nOWO?=
 =?us-ascii?Q?ZkKABnqsw4kO1+HJk5s3rHnayv0NQGo5uX7QnWrHtNU7a4RPzjDPPnSY/5X/?=
 =?us-ascii?Q?7RYR5M4XsGTf1jsBVt6i3TwKJCGnlEimxPxVB3+2oekLxfiGRg4LezhJpG2Q?=
 =?us-ascii?Q?uLniSb8MypcHwXalwAmCMNrvQWjQkhysjENDy7dcmwLAXj+fOamX/zUW+d10?=
 =?us-ascii?Q?yJreyaPPags1BJDRW5L57G8W6PK57bOLIFQntW5rX395P7aSONUk+0eNk8X8?=
 =?us-ascii?Q?bNW2e9fjQzNOmdxGupHIKGOF81Go1uCFgXGsLwoOYWYcXFXBuILUxXjp2bso?=
 =?us-ascii?Q?N235bKqBpB2+BQqc3rVqCRTcfSI96jgKSyM4MGDMBaDG+mMsGD5OPx5YgnKI?=
 =?us-ascii?Q?gap6qKkeflX3uJWx0HxiGNrD8UhnYLFzyww6N8YPhBon0jd6hwtIeeC4oDUL?=
 =?us-ascii?Q?UZfGnyH8Wl/oBtvYOQmamHC2tlXoJXUhNIe0Bo+MyetW2C99DdaMcY4KEdCF?=
 =?us-ascii?Q?DznaBU4UrLKdzyqOm/TXF04eAn5knDNS838D2X2gnmGpuM3ITMOWQd8J8ySC?=
 =?us-ascii?Q?Mjmd8pPoKN1fV/tXETrpx0BtRw+S3Sb5YyQE5lPncKdiKTYQnHoYpDSvw7tD?=
 =?us-ascii?Q?uAqEE6/hjWxQ0FPNCvPXhWyknDyIRTGw6euKBiiQfkq3n1wmbF6Ti3t7Abru?=
 =?us-ascii?Q?1zKsMreEsVwj9Yb0HyospDHNA/0OZxT+alUdXMsdqxVfBD8mb5i3nrsIHKHv?=
 =?us-ascii?Q?gJAYVKiu2p+cBLc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8979.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?L7xvL14MdkDjjHLjtX5SwaXypkmDHid73a8HLPKY6XW/UFh/KrYvnA5Djyp/?=
 =?us-ascii?Q?hjODH9IJCkwO0NRQ0eldaQIxtS2O8rsarPOqD+FizT0eR7TjdFYzIUo2uBMH?=
 =?us-ascii?Q?If6FWUZn8wuAWIzsLqAGh3Mb3WyEYDrbC3siSbZh79vlfjY5h4Hqzp/rAyLv?=
 =?us-ascii?Q?SDBnPQQwrVJhhp/c++URwwMK9cwd8lGItSUrkx+X8mSpO4gr3d5NzC0zsWK5?=
 =?us-ascii?Q?WbDkBL9UppLvE65VvEej1vwvXTfTZoqjy8TndyX3x84rmfHp+9tex4Gj6tF+?=
 =?us-ascii?Q?i1KJGUqzXVjlL5Ta14imF3DzkPovXuwglTMLoysct1YDRt8Yx/pK5xeJtAJn?=
 =?us-ascii?Q?nS0OW0Otun0lxUPHRmdaI/llFE1RBAx9sn3gvLJ5MC+Mo0JJmk9O94kvvcI5?=
 =?us-ascii?Q?mnZgj5kzT7E0isaZGyxKKs6m6c5Dn1ZH029U8CioeWQN8tDX1gQEucDrnIv1?=
 =?us-ascii?Q?HEYtZOCvoB6IaO37bk5HalamlH2eBJ5vIHm9XuN9nZlTXBUx4Sb/itKXrvK5?=
 =?us-ascii?Q?lxWBl9IDYOCeMEPxbW5dGqZH5K8EFDdb3DWEL4rwJSELJ1qIL+KJauU2uF3f?=
 =?us-ascii?Q?Z93+KwxXKc2ZgOCUvVvFRXrxYN1/tIoy7FT2ur0fjfzpJcYaCb3PS4YEDRiT?=
 =?us-ascii?Q?LdocR9c8KXS083d9yDCu9QEr3a/VptPkIx3LdsEynwhwtCDdvZ3DnrJB/Lsj?=
 =?us-ascii?Q?1a3aPDwiql6c/cekz7ynIQarmUPAocexSp+SidPQ4VlNuOfWcD73Qrs5Rqun?=
 =?us-ascii?Q?/yW1FsdMpYs3hl1GAXW8Bv2hne0qt1s/WUZSaqI2WwKpnaw2FNayPwbrjkyh?=
 =?us-ascii?Q?j+CQNK6042WWcYbXoixo9WBfL2o+Tbjz1ePKMKZdSH4AMankp2dQK/ggtlBE?=
 =?us-ascii?Q?/FbuAXEOVm60qj6SIHnDlY610Hr8d113BDWRyYhv6oE7WBSNZpGx0srkgzHF?=
 =?us-ascii?Q?vEuYj4sNa0VwvzQQE9HP9Y2Xg3OjPky/9JR+oDjTDaZII1uzGUoe7nYN6bE3?=
 =?us-ascii?Q?p4qfYQwUGyZAUDct7EnkAsZWhhcGfFryN9Eb8LTnY8OEGFYF74DkxZFGfbgl?=
 =?us-ascii?Q?ii2+3eXcIJNHraVgmZt7UpICDFFJGABqVH1Mw4Uj8yES8KG3Inx0Kv75AwCW?=
 =?us-ascii?Q?CbK2X2nSvRhh4F0TwKtgmwfRAW4swqYuuHqaU41cdNKohrybe9Rx8fMZ0DhT?=
 =?us-ascii?Q?JJKCUqo5m1r70eaxvke8J1sAYoRklfaXUmipxymy1iJesE1STbIFbAOrJXyz?=
 =?us-ascii?Q?fPg1UfuKJcv5G00L8Akda9a9bZMr1ewlUGNbCBdckUhNcGfGl2o//Ayq2xh8?=
 =?us-ascii?Q?wuJ8HhF8RkGRvjIIXL7eLDn8uxmGxAvsge8SDKNklBd7e92DLHUK4sNf8ced?=
 =?us-ascii?Q?CChLPbB9sc+Z9IsUv+zDJ4pJcVBetD5pDCwo8DO2A6KtbXMiAWuP1ywTTnb2?=
 =?us-ascii?Q?pMMev9eq/hWgPPL6a7HbbXj0sIGJPOW0gvApZW7gXNUl7BhwfFQj97A336qK?=
 =?us-ascii?Q?Q2KdqdjnVio5Xiu/b7X9NXUcvcFF84T9zrQlr+I3Abz1UXtp8R0QHJE8tw6y?=
 =?us-ascii?Q?JX/5CFwt35pm2QPsMnRs/M2ZG8XKcPnrq1s/N0Gq?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8979.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffbb7524-080c-4c89-c31c-08ddb893c1ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2025 11:38:10.9218 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CsbJSa20bQUDsjpUureFe1pwWQf9HLXKzq/NPpyycBEJChKPFisPLS0ei4js1ImHNPknRNPkN+5x4G57683ZaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10756
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

Hi Stephen,

I have removed this patch from the patchlist.

Regards,
Vanshika

> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: 29 June 2025 22:01
> To: Vanshika Shukla <vanshika.shukla@nxp.com>
> Cc: dev@dpdk.org; Hemant Agrawal <hemant.agrawal@nxp.com>; Sachin
> Saxena <sachin.saxena@nxp.com>; Jun Yang <jun.yang@nxp.com>
> Subject: [EXT] Re: [v4 01/10] bus/dpaa: avoid using same structure and
> variable name
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> On Wed, 11 Jun 2025 12:40:30 +0530
> vanshika.shukla@nxp.com wrote:
>=20
> > From: Hemant Agrawal <hemant.agrawal@nxp.com>
> >
> > rte_dpaa_bus was being used as structure and variable name both.
> >
> > Signed-off-by: Jun Yang <jun.yang@nxp.com>
> > Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
> > ---
>=20
> NAK
> It is allowed to use same name for structure and variable name.
> That was PCI does, why does dpaa bus have to be different than pci?

