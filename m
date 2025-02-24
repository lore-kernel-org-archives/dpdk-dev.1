Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316CFC021A4
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 16:52:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 151894278F;
	Mon, 24 Feb 2025 17:52:37 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id E6A4441104
 for <dev@dpdk.org>; Mon, 24 Feb 2025 17:52:35 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51O9ZIbQ016261
 for <dev@dpdk.org>; Mon, 24 Feb 2025 08:52:35 -0800
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2044.outbound.protection.outlook.com [104.47.56.44])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 450p930vkk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 24 Feb 2025 08:52:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lHZHrgaPDYJIycA4c2vt2J5cdDyTg9uodz99cshs6dZ6cCVuCjcyb6NbExAgJ3Mes87l+jq82Hpb+ZQf529wcIHI2wBIbUCz+OOcXNE/N0cRSo4Lm9Qp278PdqfXeVKzHnZLt0rUcCsgzcS+QNkG1I5y3KkmNvRQCsN+VpyN+KeztWgEo/yhUkrBeNOCy0DXQLuE9Oj27M6bRCylpbyLlTNu7u1+beDCGVdz1tmKUBLj5SU7XkUSBnaIX/tlczC8sFW1JJvSR/wGx58nHwRpJCzTBkxar0lqB0K3OFo6PbocHTJk4Ac78KCfTz6QK3i9iE9B9kSgMwRhKzxhLKlJvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7NTh2X8n7zZ/pBvHgfVaxIGs2YcGRbEG57nhSfVyHxY=;
 b=SSMsyaKRPKwwcO4iqcjOJt4jghpk/AbauLWIRf50ESdFHubE+h61zB5l3iBa8eJJgUOpBUXypZHW/ZB7hY+b/6fc5VrAg2vK/QewGefGxTtovtzuAKPT4xr67575drXzkjLP3h1ZflgZ9cuH+uQi4u2jyxG4wVQJhI9jsBaJK0Fv1fAZxx2lgtupwXTERA6L0KVAMdHTnByf8i51hdZdh61bADsywTTx2f6XlW2PTpNpsxnoorBfCZ2sbrVfXK79ob6up0xK6Ogmjw9pbyLJ3shemU1H+NgO8ObMf6VH3CXD2kBDsIl+7cIuiTz3CWoccbK+oWYcDN1s+/euFg9yLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7NTh2X8n7zZ/pBvHgfVaxIGs2YcGRbEG57nhSfVyHxY=;
 b=f/nBS7SezE5iguvVK0ImBJ+HidqRc8NBnlff74uCVZQcK+eYjLeUjnyVtu7dxMVsDfbwzJa47IRvZ11ucGAwg4eVXjwmGXAMMZCTlClT9zBBF9s/YCaY67akFVwb8e5NVq0TyF3WcQd/m6Z4xMd4w6kT5JvgWCGWEMGNrcuCrBo=
Received: from BY3PR18MB4785.namprd18.prod.outlook.com (2603:10b6:a03:3cc::18)
 by IA3PR18MB6163.namprd18.prod.outlook.com (2603:10b6:208:526::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Mon, 24 Feb
 2025 16:52:29 +0000
Received: from BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576]) by BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576%3]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 16:52:29 +0000
From: Jerin Jacob <jerinj@marvell.com>
To: Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>, Nithin Kumar Dabilpuram
 <ndabilpuram@marvell.com>, Kiran Kumar Kokkilagadda
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha
 Koteswara Rao Kottidi <skoteshwar@marvell.com>, Harman Kalra
 <hkalra@marvell.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH v3 01/33] net/cnxk: allow duplicate SPI in outbound IPsec
Thread-Topic: [PATCH v3 01/33] net/cnxk: allow duplicate SPI in outbound IPsec
Thread-Index: AQHbhqHp8DmnFmEqjke2CV+lHemUmrNWq5Kw
Date: Mon, 24 Feb 2025 16:52:28 +0000
Message-ID: <BY3PR18MB47855F70D606C01377E533EEC8C02@BY3PR18MB4785.namprd18.prod.outlook.com>
References: <20250131080530.3224977-1-ndabilpuram@marvell.com>
 <20250224095241.1263700-1-ndabilpuram@marvell.com>
In-Reply-To: <20250224095241.1263700-1-ndabilpuram@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4785:EE_|IA3PR18MB6163:EE_
x-ms-office365-filtering-correlation-id: c79525eb-fddb-4635-12db-08dd54f39f93
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?a4cU0stlCJ4kzoa3YOeR6kDI0Ik6MLs/UzAJ/QWZFQpEAnjBgprbOhc06C5R?=
 =?us-ascii?Q?XZg1gsY+O9K0VGw+kOT3ijdXIWQnM1UCDxtm7ZJH3ON5bbfLMtZ30eWE9n7o?=
 =?us-ascii?Q?coqIzys8EcqMPiD0DqVNXomDbTceFTTo5cB5/83f1CZA2J+LhMTmSHm7qCkM?=
 =?us-ascii?Q?bKeibWaOyUWzY+Q51Ek0lLawE9LduDqc7TPBOpJugD0A3ojVnf57CFkDLHVt?=
 =?us-ascii?Q?QmQ9adDECqFOisYRdNQqUXjtgmF2GrQ4r96a1kl+Q9gc0pYSCtLQEVkjrGiS?=
 =?us-ascii?Q?5tGviYhW+J+ZBBhOPHhNbS1imz68SYZgIb2EoxXvX6IYWLgwuSZz0+RxuhXt?=
 =?us-ascii?Q?e2l+sLOaFJ4Ln9Zx5d0lgm6Ed0Gc/FyhV8kbAjFFWBJOykT6Z9ON7Qv3dN0j?=
 =?us-ascii?Q?hh0S2uGHa5O+92eX6jTlq6SnZSZxQf5UywNzyqZz2vd1Tq5sya7qoUXm5akR?=
 =?us-ascii?Q?Z+JA448kIr2UZkKmqZB9oCiCWZN/T5TFFVrh9kRESABB8esm/MxBBuJLyhuf?=
 =?us-ascii?Q?JeDAb7OWH4WzD2Mj/59tLtejWi09Zv5JxfQuM2KF79QGmQcsWBIhw/4rRc2R?=
 =?us-ascii?Q?HgSpWWPGi4WWHkMqf/4RV52jjl3FKRLSOMoHSBVln82lSQrRy/s8sDsAKHR8?=
 =?us-ascii?Q?MRk+n2qUwbgeJccfOybHUNOK8xELn2BUEPUQOrbe4WSHgqgTkVU0F7YcAmuR?=
 =?us-ascii?Q?zEdLhORl5yvOlw7ge5HCm0T4sOpnjNkiXKqxBnzqIg5mxvhwrfunsaecs2LN?=
 =?us-ascii?Q?SGTrvcDJRJZq4H1VqYtNaq6r3/aGHmlrns6jMuUm9tDsYmlbPP4o+NMiR/KI?=
 =?us-ascii?Q?90FdRjxgxzbXldcp8e/MeklIc0ZHekfdc2/D5Z/q6S5Fz91UAZ2kK70wzSwd?=
 =?us-ascii?Q?e8/hSZhU3wtxrTIezvebkgSoYAP5fx20ExuLo73IEHd64WKLPYneaGTLL0f6?=
 =?us-ascii?Q?Wg4MWTaLrN5bSl2Qm9tyHnKhGzrOu2tDdmnKtx2WdnEeJeEWAXRzSp9WC1Zo?=
 =?us-ascii?Q?gRNBx9h2jV4L3WaK8rZP4X9GrwsQoDnMCr3Ykm3dKNSqIz2neRm43LOEdp8w?=
 =?us-ascii?Q?pPcBomd1I2y0gsVMFGVrZQOHS+yp0dKwIsWlroLWVugdSGjVg2ky7/1La+UW?=
 =?us-ascii?Q?X0FEIuyTJlSEfKVs3CdiMEttfwC1xVLmW55jGpUd5Mhte5xVvvs6Ze4sPz/v?=
 =?us-ascii?Q?t+aNwsblmJIcH0+ExuK5dfHKdSRU8fAGlVV9ekyS09cgfBdJ822T4i7fyvY8?=
 =?us-ascii?Q?EPywcCKGeKzEszq4CyDRWoydp9ct+cwjnJg8kx7OgmFkEeuXHRglFGIpbxwa?=
 =?us-ascii?Q?Fk2QXwRr8YEu4eQjV9zNajNZAZcAUR/R2NtlP8s4chfzj8z27c7DpOY8Xc2c?=
 =?us-ascii?Q?+5KJUeOkIOKBskwH4nXXjIiK8y2LYRqDwK91D8f9v6M3kw43UHUrmb89ZWwl?=
 =?us-ascii?Q?Cu4GjKe1nNqOUw3nIoUj1+XDGjxO0tbs?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY3PR18MB4785.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IkDIn/kMra7OsUq3yNxRvpBZoP90aDhSNmK3Lt2nQKHmS9bMsdxBXbXCFoTZ?=
 =?us-ascii?Q?TqQ5ngegpcTr0CSAthifQjlgO8nJoQ+DDA1m0jwdYT4EBO6GysAv3rS4qLRX?=
 =?us-ascii?Q?ie/yrHXyTa6sY1PESSf2YeZINTXrKQ4w0dxJhFag9cuz/xdZXa4+BxtR7lV7?=
 =?us-ascii?Q?niqsueNGT/Z5WvrzRUek8mDqtND+OK7CZovsrEui5TeuOkqpNPX57cjGFO9B?=
 =?us-ascii?Q?T5KtCyt8+at87uxK1C5lle13g4trUsOXvoG7PzVU3oO7OWe99mCAA9x2EXaE?=
 =?us-ascii?Q?BuksFcANCDhp6eiPc6IAi9ZEmy6mIrYSqHJeT0J5zkwFCLvMo4iMUS08QktW?=
 =?us-ascii?Q?6YoqBeTOSc47fvT38K37Dk6EOSiJSspzoRgvJFVIzZsc/jVtEAAWlqJmY/qO?=
 =?us-ascii?Q?eE2cfguyiXs5kDv2zH7+QYiH7ESKvMuDQ1/GbuigNoZ4pS1VI/0N5upFpx3j?=
 =?us-ascii?Q?f2w8X/8kHb6yAiDFKq+Ygh5V9nLM2seHrKrTJtZ5WH7p52iuS/IhYZipSQmp?=
 =?us-ascii?Q?FpDK1mg70FAMyJmXo+U5Q/LYqj9X8V+N1XXz8yTNHEezAwgjT2hkHXOciM5a?=
 =?us-ascii?Q?2/SoqSguqmp1yrJ5BPhNtp7ie3EzvkmilgFvoKB3q7oxtRINgjnlsAux5Aja?=
 =?us-ascii?Q?t2rkL/F++nwPXrZDtJOk+MWi+45yqXkfYBShHuNi7N03LdPHfnl83tckaNGD?=
 =?us-ascii?Q?efVeHTLr0psLOtrZ6MehgNLLAj99dw/8fAjScrivKA6QJDfs48qRltrSW+hd?=
 =?us-ascii?Q?CSeyomOcbfVniNSBRrLMAB714tVbb50yRa8CtYnYQSiNX50rnH26SiCm3PGY?=
 =?us-ascii?Q?tMJZiDoov86zbBMGnf3HEP+nWkrQxs9nEeoqE1R1EbLXKJ6IfSGs452x55s9?=
 =?us-ascii?Q?/EhyHOnK1URnuk5J3hSTX0KkMtLgXuLsj19Wzy6zUUqykIgGYna2lWLn1IiC?=
 =?us-ascii?Q?RRGIscYnyMYwSm7msfOq+QuWdcSTw60IkHYXihyRcy4b9214Uhn74cr5yA1G?=
 =?us-ascii?Q?agqfIQiuBAalP38ZMI0FkUVglQ90bhinOIA/DSH5+KKrlwCP1QJT7NKVgH86?=
 =?us-ascii?Q?qA8pmmGMMMHwjJmxdMJeMsCT3IGMCCPmXbNoYudGAo+z1yyEh47pioa/C7+J?=
 =?us-ascii?Q?ypQgxk8iEZePn/Ff1XFWxrH6p0MCTrHJI+Csyj3ND8g6T0FA6PlhQO/E4oA7?=
 =?us-ascii?Q?Rtn0+XY/JngsKVqCUFt0W7ZA21aCtoeM8fe2rUx1/tbmXj0B054X0F3qRwxh?=
 =?us-ascii?Q?lWnz6y3b+++kYKs6Xm1Uot8ow5CMqP9Nsejii2Y9fauPsO9bUdIvtKyhb153?=
 =?us-ascii?Q?myNuXfWzOHov8tedZew0QkSxB1VPaiW2TLsj3cZkQ8tGz0mHqzsweg3GxK5G?=
 =?us-ascii?Q?M4IT1pWzRikHCNwqD2lJ+rdyoDgt6R7HpxYydjGqye5be9Q7nhVBZdbDsYXb?=
 =?us-ascii?Q?fKQjc2gujQIRq3x8Uk542yb1x6dWQZdUSUgC2F9upUtRFPZRn13lw9UY0C6W?=
 =?us-ascii?Q?saK1JRW1gDb4c5iI2ZslpCoKX9zXoD7UhEEjApSt0CTAxR0re39sycnx0ppj?=
 =?us-ascii?Q?xTUz+X96Kq4VMaKaL1SivG8oYHnrqz5HCgiJunYY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4785.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c79525eb-fddb-4635-12db-08dd54f39f93
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 16:52:28.7318 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2F+ZUBk+oT5FQ4MZ1E3NQW0UqBIWY9g7kcoTG0IpaQxqpD35oHRWl2RitZui85o3cTd61X8xgYVYxao0xSPUiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR18MB6163
X-Proofpoint-ORIG-GUID: R-HjnQqusOH99NIQRk6gtH-1Y0YzT7P8
X-Proofpoint-GUID: R-HjnQqusOH99NIQRk6gtH-1Y0YzT7P8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_08,2025-02-24_02,2024-11-22_01
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
> From: Nithin Dabilpuram <ndabilpuram@marvell.com>
> Sent: Monday, February 24, 2025 3:22 PM
> To: Jerin Jacob <jerinj@marvell.com>; Nithin Kumar Dabilpuram
> <ndabilpuram@marvell.com>; Kiran Kumar Kokkilagadda
> <kirankumark@marvell.com>; Sunil Kumar Kori <skori@marvell.com>; Satha
> Koteswara Rao Kottidi <skoteshwar@marvell.com>; Harman Kalra
> <hkalra@marvell.com>
> Cc: dev@dpdk.org
> Subject: [PATCH v3 01/33] net/cnxk: allow duplicate SPI in outbound IPsec
>=20
> Since outbound IPsec is not really dependent on SPI, allow duplicate SPI =
in
> outbound inline IPsec sessions.
>=20
> Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
> ---
>=20
> v3:
> - Add cc stable to 29/33 patch
>=20
> v2:
> - Rebased on top of latest code
> - Fixed build issue with 26/33
> - Updated release notes
>=20

Series applied to dpdk-next-net-mrvl/for-main. Thanks
