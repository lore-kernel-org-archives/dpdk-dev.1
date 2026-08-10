Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB709C5AC82
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Aug 2026 07:08:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DEBA940DD8;
	Mon, 10 Aug 2026 09:08:25 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010031.outbound.protection.outlook.com [52.101.201.31])
 by mails.dpdk.org (Postfix) with ESMTP id 2215240DD6
 for <dev@dpdk.org>; Mon, 10 Aug 2026 09:08:24 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zGV/uxtX6louK/ruSzWRixr1y0WtKJkFY4FohQYfBDHfuv5c+dMaxUU8c3pgmXz77EUmMcP+zDiXlSKBItO6Vdc42tquq+i5fY/nBD0rhe1BHKTdjNvG4tGuFGCv/ElgTX5hxW0Y+K40ALN9patTBD9UYOMbANGAN1B3jcoWfo8IevjuDsSPrV48xQ0YUnjSOJsFqq/u3LfUUrrYuK+OHngcKaAUqyKzO8LC8w63YzFqASeF4nFS6ZTPjqgraEvltIB/aXHsDAUiT1+e2KsJ24gk8YLRDxDQZCKEj+Njf7fOSq3p20huJWC/9YhQYNmASpba9XoRohvpJItgSBXAdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S0wHf/oigpu8EXacpm8o9TQpk86svSA6MtLZYK80NNM=;
 b=lceeaNYv239iI0OimY7eUOkwOD17Fxwfn7XtfXSrd5n9YuCTOUYKACT1JvqMlFBuz1Ar5071oUAR0MxJFFnfXwKjyWD3lmmV8UKavbEz/91uhJJaokWSsM6h8slPzoVb9tmKNyx+2B9L/QE7eDsVo2ETynEhq/XdULiCf6aPQat2CEQh2nP8sMZHSjzSpw4+8zEphZj4HoNScM9h3ejSDJAgi7cs53VytfDAIBUf00xyuOh1NSBYl7vJi3FwpK37JxwVuwP1/TnTzucKaFmN0J/FsszcOQT5oIY85xQsQ6vLvBvwJK1TQf8DT1UPr5mOZAd3bz8Oo9WOZVjabgrCXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0wHf/oigpu8EXacpm8o9TQpk86svSA6MtLZYK80NNM=;
 b=KGJ0N/2Rix2gubSQiWX5Bb27ZEFRsYIfaidBw3fecutcZj07WEOR5SSl/YAnenJD1uXrbjrIenwmXdryEcfeP/q74cqq/upQn8vXr33Wav6rKjev1hYgsobaThmXBsKeUqimGwc/mELHj/hUk0qwN9cNQgFrvtHbCqxDeUfvDvfQxdJ6MVcRd5eZXhIj5IWzW5ASfMcLqtpK0XD6q7BarjtpiN7T6RQyVZFYOUK2M26ggeyJ3BJKs4B9AE+LR3Fnx+g9fRHomxfdSJlvQefBL1ZOPlhh5lV5jxI0RcexnIoHEbSXVqs2zNgm/8CKJIiTc2NseM20PMZyIrarQWdENA==
Received: from BN9PR12MB5338.namprd12.prod.outlook.com (2603:10b6:408:103::23)
 by PH8PR12MB8607.namprd12.prod.outlook.com (2603:10b6:510:1cf::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Mon, 10 Aug
 2026 07:08:20 +0000
Received: from BN9PR12MB5338.namprd12.prod.outlook.com
 ([fe80::7b66:315e:f851:8ddb]) by BN9PR12MB5338.namprd12.prod.outlook.com
 ([fe80::7b66:315e:f851:8ddb%5]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 07:08:20 +0000
From: Bing Zhao <bingz@nvidia.com>
To: Maayan Kashani <mkashani@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Raslan Darawsheh <rasland@nvidia.com>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>, Slava Ovsiienko <viacheslavo@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: RE: [PATCH] doc/mlx5: document modify field limitation on group 0
Thread-Topic: [PATCH] doc/mlx5: document modify field limitation on group 0
Thread-Index: AQHdIDppcFhcdFu3RkCjJyW47TZxvbaW7WCA
Date: Mon, 10 Aug 2026 07:08:20 +0000
Message-ID: <BN9PR12MB5338894DA6220F4DB56CA71AD0DE2@BN9PR12MB5338.namprd12.prod.outlook.com>
References: <20260730154440.216881-1-mkashani@nvidia.com>
In-Reply-To: <20260730154440.216881-1-mkashani@nvidia.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5338:EE_|PH8PR12MB8607:EE_
x-ms-office365-filtering-correlation-id: 5e5fdfc9-d2c7-406d-b6b4-08def6ae290c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|38070700021|11063799006|10067099003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: aaTRqkNqnPvFvzsGhG0lIaLSS2PjYMRf4SQ3Yl+dwNl1Bv1a85WVxztz9Zs/I7cyieBknhcQZqhGxFCCY93Cchwr+VAGl/KHvrkILUXAkLl7KPtrZRhhLcIBUa79nnm8NSHU7xMdYc7prQhkD0obNL89LQ6QERLsOd9lIMuRwSKB+jUOgkmg0lL+xuo7BnxowCg7+EpCqEieCmF2qbN6Hl7D24oi9DlQFheQKvmLhPh+t4KVEzq9pXOlQiJCy8tZn43og3YkfBFcqSYO68IEo8BOub4TWWGCydsBGTxUQG7j+JifF4eo1nZWRrzKg7zrafVX75RhcX+6B0Ujosvo2ED8sKhxhJ7uQL+K0sUNqezTh2Bcs6EMj1rmVyMgAY1OY787g+KLRR2Ykz250AJBNSxSzfDWSnYepc8hSVcQf5ke88VFRYlgraan5XoVL/176LDJ2EE4EHAYtVOSnpyp/RiU82BiEtKmYwwj993qdtLQ0W6+uxmqwR/QuvYt02iQJ/DwD9H72PX7nhmpvIwulAiqFtx8ZuDQd9CjXeraVX9f68D/NOUu/hqTlyfSGBIZyJPi9gWLAjiuRLffBJGUsb8nqrjcIQDX3j5DzplGLgHa8aBhpTgpMJM5z863NDL7opzTdIvF+zjVRSoADkUiv90UhseSNJcyM4rLfQQZHEIl55IS2kCG7mHAy/Ym7gQ5LUbZ9k32267CCUtoPtyewJYSizuF33PQN0SgBygrdig=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5338.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(38070700021)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WD4Q9uWt+M1h+lyjzoM+1OzK2IyjHe9pglM80dtsVQ9HbhX13wbo4FKgiBK7?=
 =?us-ascii?Q?zz+P/Y64jeaQGgsVJCHK7izK4MC16DnJ5v0sBo/qQMxdVFeBLrd7V/ixY9/b?=
 =?us-ascii?Q?wuWrUM2jGEkj0R7Y3QmALY8lAHtxhoTVhsnun7JVj5BJfZK+TVcOg6NfxL/t?=
 =?us-ascii?Q?0CpC10SWUAuDfQi9b5k2iG16u5We+/kTRo7gR+uzSAREZePZzOGAhE+QEcNL?=
 =?us-ascii?Q?olAmQeeBxsjA2k954+xhasqHFOFN15s5WW9nmHKFXB+ZjDX4/yIHqqwLDi9G?=
 =?us-ascii?Q?wCG94+TcIPMXKSLNy3F5V3MSrrdXC/fjsXGOLBgfqmAW8zMFxxJ/zTnZBURZ?=
 =?us-ascii?Q?javQVjt8CkaGjQ/cDs4DMi9N2BfVb6abQnIHVAJNEGKl4XYKX+x/ax3V+A7s?=
 =?us-ascii?Q?wDeZ2NSvKkpLZ8fAUWtoM5yTCJ0G86mytO1KlfjxRyT3hZ7tWR9YbSBaYYtE?=
 =?us-ascii?Q?kCigNMxmj18DoUCCwKwRtgS4Lr/d/VXZs7XYhv1zcKPOgZogeayq9v+lQMRP?=
 =?us-ascii?Q?4Kh+sS18ZNz85hjs+xw3FB9+f0+hwlm4YoHDL7N7XKXJaRcQNOnM6qs2D2Cu?=
 =?us-ascii?Q?C3Kk3LpEc5SXCzOtdEZ21264uJzSGINiF3VW8EntA0eh5O1erhrdFqvfLUjc?=
 =?us-ascii?Q?0I9h4IvJG+ZJVR+LRs2s4RVS/POJrFD/zTfUtX0XvYhff8eZ/m+AMvHam4be?=
 =?us-ascii?Q?KVpNsnk7OxZHtJgy/jy5vbuz+rl2XK5rYVBy9CY4yc2CBUUZokj63Dw/sqLp?=
 =?us-ascii?Q?0H1+lmHzTs3rIy83+A7UEMGVrAhC+Bi9ecrpnK566PIsYHJ2juKeVfVIzXuj?=
 =?us-ascii?Q?+iCVBvN5ClDFl1tw9otO87hDap8tq4z8K7zE+LKotOPxjSiNuxiPzczKcVMp?=
 =?us-ascii?Q?WEGL0VScqrJPV3SrBJqP2HDF59pBW724HsyN+XFO3HnOnzQFxZjgKNVZnwyO?=
 =?us-ascii?Q?jy97oMD0btbcQloH7cPCZ8K0LOI+GbzT3x6ST3F/OWGrHmUhrlAAt6RrUGLe?=
 =?us-ascii?Q?6hfuq31jSqCIXdmC/GE5gynOJczMmWyL0+6vEY8vI31IFQYMk4w3pa6y4ySS?=
 =?us-ascii?Q?u7sRNohYZ9sG4tUZVsJyqqiwA01sk/UUGkIE2IH2yRORXvPIOB9WUP048/FI?=
 =?us-ascii?Q?LJsqVojqQjDvSpXIe397MbradEInqCm1Soq5/RH8Uc3KEeV4cukL7t3/GuxJ?=
 =?us-ascii?Q?Ew3z27olxJHvSlCvjIxXrdLj1MG1WluM6T6eg/RQNaEhBZPJcpb+BIrl3EAR?=
 =?us-ascii?Q?tOT5aGgwdLqbZRaElBpmWWVi2cJQvE/z+YNOs8Rcllmx+NQ8SQNHL5mZD0BT?=
 =?us-ascii?Q?JMa827zVIlNu+PI6aV7Yfb5ncyXBS3pBqczSgBuSh/EMWXnM/vH1TaL0AORm?=
 =?us-ascii?Q?DgwTxR2CPWvcEZAhapw0xtTZezKqf3kggYqIbhUiBJ/cqEOvsc82uWn1mWy4?=
 =?us-ascii?Q?UjSiYo1/717wvVeNQeixieTrPYuFXH/c6J6N1Es+nQMKXCKSpEpm1i3w5yhm?=
 =?us-ascii?Q?nf7pgDAyKo8RZtcZZ56hvfaQWiOP7yecp6W7igK7CbshhQNngBIE70Di84lo?=
 =?us-ascii?Q?7+FGEvjolkp3rbiHbkpvY+mRa6mbUVQA4wKRZAbGfh6iO2XXvJMLPtAt/hsB?=
 =?us-ascii?Q?O8h2NkyjNk3On7es/M1cZ7p2gYCQGcQoyKn0FN7Gl+BjnMcBlc8Wii8rngvp?=
 =?us-ascii?Q?Qx5T2c93fBBRoEpaBbOA72BiO+lkfCOUleBfGJSjdzblWBVD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5338.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e5fdfc9-d2c7-406d-b6b4-08def6ae290c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2026 07:08:20.6025 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pK61+YcXSYvV3ap1kXWG9O8YNYO9iqV+WvwYglAwcfyYLTaskH0RUBgLqNDk0CcGwwDE5X2FROSnoa9qsdqlLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8607
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
> From: Maayan Kashani <mkashani@nvidia.com>
> Sent: Thursday, July 30, 2026 11:45 PM
> To: dev@dpdk.org
> Cc: Maayan Kashani <mkashani@nvidia.com>; Raslan Darawsheh
> <rasland@nvidia.com>; Dariusz Sosnowski <dsosnowski@nvidia.com>; Slava
> Ovsiienko <viacheslavo@nvidia.com>; Bing Zhao <bingz@nvidia.com>; Ori Kam
> <orika@nvidia.com>; Suanming Mou <suanmingm@nvidia.com>; Matan Azrad
> <matan@nvidia.com>
> Subject: [PATCH] doc/mlx5: document modify field limitation on group 0
>=20
> Document that on the root table, two sequential MODIFY_FIELD actions wher=
e
> the second uses a field modified by the first as src are not
> supported: the second action is handled before the first change is
> applied. Only immediate src types (VALUE/POINTER) are allowed on group 0
> for sync HWS non-template and DV flows.
>=20
> Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
> ---
>  doc/guides/nics/mlx5.rst | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/doc/guides/nics/mlx5.rst b/doc/guides/nics/mlx5.rst index
> 9b035b878e0..aa751669444 100644
> --- a/doc/guides/nics/mlx5.rst
> +++ b/doc/guides/nics/mlx5.rst
> @@ -3425,6 +3425,12 @@ Limitations
>=20
>  #. In template tables of group 0, the modify action must be fully masked=
.
>=20
> +#. On group 0 (root table), when using sync API, two sequential
> +   ``RTE_FLOW_ACTION_TYPE_MODIFY_FIELD`` actions where the first modifie=
s
> a
> +   packet or metadata field and the second uses that field as ``src`` ar=
e
> not
> +   supported. On the root table the second action is handled before the
> first
> +   change is applied, so the source still reads the original field value=
.
> +
>  #. Modification of an arbitrary place in a packet via
>     the special ``RTE_FLOW_FIELD_START`` field ID is not supported.
>=20
> --
> 2.21.0

Acked-by: Bing Zhao <bingz@nvidia.com>

