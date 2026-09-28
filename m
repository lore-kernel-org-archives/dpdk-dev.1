Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B826EC9833E
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Sep 2026 09:11:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA0354028C;
	Mon, 28 Sep 2026 11:11:29 +0200 (CEST)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011031.outbound.protection.outlook.com [52.101.52.31])
 by mails.dpdk.org (Postfix) with ESMTP id B766340041
 for <dev@dpdk.org>; Mon, 28 Sep 2026 11:11:28 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kKtBzFMGqyvyX05QGObtcepno545lMUqD50JfA4AA+QaGhYdS9te7p5RAH6K/xz5CKhi6jarr+q31roNcMgvJ9KfKT4tonrO7qq3An6SMqyLM1gbHIR12dK2lYcvc5JlQ/xFphX8qynciI6eStbZnOLSYjnTYxUC5r9yKEGKOABZ0OZusoBMN45+KcSKfM9LxTHuxTWv9tp1zRIyolJG9nLjejhPPnENYQHggtAWh94I0kwpUOghRMmGBDNN5N22EkR52Wz68us0TTtEfq/rRHPDRuBUgvl9WWbUx0y3cKW8EoEpDK6Oh6witqgNeTYwk85XUbJ54QxSLrFQByswTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LIkwbaHdT6KLznNHVIMFCb8/s5cYVAw7+NWEjxldmxE=;
 b=Gw8nAa4vJ9EAekO85J5AX0KktQ8yHBSwTQUd7m9xXJs7BJ1as3lq/6lUc+uVyF7G787td/V1YxoY2Aqsk2ofdosR7Mhcci2lWOoFLzlmmEGSCeqfrIPPjI/H64E90CRN4YK8YwEDT+pWkCMbkzBd/YAVXN6+KItWhbTIUajJYqYChgSVhzLF8cGlvsaoK8gF0I/fKjeAdtXu+5c537Q76q2FFZGhv2VfHjdZi1p5XKLm8AYZInvONZ7bdW4zn8GJjXeN2I5dN7fOh5jziyHWGtMyl+jW/d7F1H0HElDCwqmGDRxN+Gzd2NzayvtMfu8JiG9ePLkrA7ByhUc6jq1+Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LIkwbaHdT6KLznNHVIMFCb8/s5cYVAw7+NWEjxldmxE=;
 b=bs68+wxWvy5NqMhb6d0gk58hCWUCvTLYb4/rBTM0eiYHQtQ405RYHiXGgTfNCqMJan8uYNHPAqiSFKocKLgy3EUV2qJK74YoOUkKBxRtjeo9e90EAOUTLVlzOkuXiN0zuGWvADRq7ZkKSJEJHP4JnbzEKAPwTIBi/m+yIWFrneA1fiyiYRmkapTmId6UY2K2nhpX6xmdNKHw6T1vGQXPQYp//guu+zKbU5kR2FYlYF8wujJaDpjhLCcI3LTJ5eDzQLZKXoS/zyijIs1Yi6rPLUVrtrlQvaASN0OpszirNRooXgLDS2OPZA4oExmgsBjTzRLjK5lGXIX2TbKqjL4rcg==
Received: from PH0PR12MB7077.namprd12.prod.outlook.com (2603:10b6:510:21d::7)
 by BL4PR12MB9723.namprd12.prod.outlook.com (2603:10b6:208:4ed::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Mon, 28 Sep
 2026 09:11:25 +0000
Received: from PH0PR12MB7077.namprd12.prod.outlook.com
 ([fe80::af33:9226:1e78:5033]) by PH0PR12MB7077.namprd12.prod.outlook.com
 ([fe80::af33:9226:1e78:5033%4]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 09:11:25 +0000
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Slava Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: RE: [PATCH v3 4/5] net/mlx5: drop unnecessary STRICT_ALIGN
Thread-Topic: [PATCH v3 4/5] net/mlx5: drop unnecessary STRICT_ALIGN
Thread-Index: AQHdPvdeiXvf+WKzSUK7Nja9gsNZw7bjyrkg
Date: Mon, 28 Sep 2026 09:11:25 +0000
Message-ID: <PH0PR12MB7077AC268F607692311149BCA48D2@PH0PR12MB7077.namprd12.prod.outlook.com>
References: <20260904220953.3105930-1-stephen@networkplumber.org>
 <20260907183239.629053-1-stephen@networkplumber.org>
 <20260907183239.629053-5-stephen@networkplumber.org>
In-Reply-To: <20260907183239.629053-5-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB7077:EE_|BL4PR12MB9723:EE_
x-ms-office365-filtering-correlation-id: cf96d283-d9a1-4348-54b5-08df1d4078d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|11063799006|5023799004|56012099006|10067099003|4143699003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: xeDSRAA+wJgeD7Mc0noiAR2JRoU0QOzjuUp965GRU107J/NVBVtHemZ0/ZuVJSnxjNCIC6AxVEjnjhpV19ScP+iEj3kPV7AmMnaw1gizpugWYZtb8Xv2OL6LRlDmTRSYbJVjnfBrEOpp2RWu7elAZmUxMNZS+nA/1oFqZD/GEjD7OndWSEV0uwNWQ7dmFsyFRlEr4E+BlMfV8ABwZ4Qko5Nr1hxLlPK1MfTidsqRyT68NC10Ub8llx/K2syqmfaql6HWHZ597tHJobBJuUPAtosm0bO/BrxkopCa0EyZ38aOpgZhzbJPNwKQ/4ZN5isV7ro7z93K8A1JDxDSNu7IyhZKWqEoSnpBs0LPTPFyZUE4LNgb4ycfRM7qiAQih4wtBbOV+K43NnQaI7HtK0tCU2VC2n+NieqS9HHkaW/NlUpbBls7756G5FkzWXqTpXw23SqABV5T5h6j1PLjpS468kbFWUghTUc+xqYHH+uc87dlClYaodJOtxqeVbAvjB00d36sHr6OflU5AzndUQ+jHXIewyd7v18ZfaxLCnpLKKsNDaEAIyJgdQCva5JajZUJ6a7J/Qr8ftN/3EWPyHHeGPik8l5KEDPoWcBtAY4Or+ktJI1MfxdVF8K4w2mWseUCObSzRkwOqu1josOpWo8alciCtYEnPdlmGEF8OyILRnWrta6wkKPquMgtzYmqlP2VxhY/8rUrk8AJO/DNC1ZcRcL6iKe16Ss4g0WbXuL6DVM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB7077.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(11063799006)(5023799004)(56012099006)(10067099003)(4143699003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?55+JUHHblAgl433IKrb4HopASHtdym0WHAhdqXtJpkTnhNdsfQ8iSyNMaVlF?=
 =?us-ascii?Q?w7TFFFVvEgD+gQPBUR1+Nc1L4ERIhrQMAgtHCWWVMwh2ZECTKuAVmPcWNp15?=
 =?us-ascii?Q?6F3UO8RTnjLI+aB6ARhOEXG+r7J4yT0phd9O9Ks9dxRrwVK+ses7gCTSPVOj?=
 =?us-ascii?Q?36gqkC9mLidRLbcsIyYH8ZRX+xDzAjF/uBjjBrfrKYCWNTG55HS+GjWhIR5z?=
 =?us-ascii?Q?Xyy3+hboYpluYQuIryC679SjM52VGChLedlrw7/3xt4x/JRPFQR4m/KcdW+Z?=
 =?us-ascii?Q?oy+0zfFXOOKfdFzM0HCtZ1kFBmSdmlxeBPxRe0raNfy8cjRvAC2u8EMfKdVV?=
 =?us-ascii?Q?27oZ0gK1Jdts9jiFH94tEDgjAn4ToxdV5OIfpGyCDrNyNXmvWFcBpLqY2Tke?=
 =?us-ascii?Q?6+dJSmlTsTpZdU5XmaYZp5uG+aECDvuPHLLmpyP+2b1KVkhWqYzMjd8pmRo4?=
 =?us-ascii?Q?cQy3EaxBAzj8kT+06vSPaqlhMT1FqXqbtJW6smffVtV0OGNXRitjLFOgx1xq?=
 =?us-ascii?Q?ze6D6XQrkxVvLm+Kv7H9Z1f48npu6gvSQb+LltUZkBrOctB4yAR6mVw2Jjgx?=
 =?us-ascii?Q?BbZlNWasFWXNu40CPhKyqG5RQQhD8dkWPTle9OSmfAOVjZwOd+eUIGiGt/ym?=
 =?us-ascii?Q?21Ow5iW0VqaCVNm7eOGxu361aJMgnQLnW7hrhBptoutvtT7xfE7+EqD5NF+6?=
 =?us-ascii?Q?it1cQcTqtEmrTnn+WNBOcuIb81GoE5AyaMwiiSC5d/7pTPaR8+qyIMrsMdRk?=
 =?us-ascii?Q?5eXTN/zBES7e/kREk4CqHqr41bO0DlsBXxpmNVSnqsh12h2FXwsrQHyqsQqd?=
 =?us-ascii?Q?avdm2rftOWm1PxuMV5Z14kewWPAcUa/Km+0uKDQq88OYl1QF5+X8DjdIxaxC?=
 =?us-ascii?Q?fxvGJGlqELeaq0wSA7nk0bBElEso13pn+ctplcRqQGQDmLw4k87vW+SAMDo8?=
 =?us-ascii?Q?fP7dIe35/a8NZj/nlgGXxSqb7novdwDdul/6QXcm7dY2kFZRftOoucv88Stw?=
 =?us-ascii?Q?hSzne0RP3gQkNS/RzBXP4ifyEIeuTnB7+MrgnottMKCDcINaX6zjbBZ2ZRYn?=
 =?us-ascii?Q?T24vjQkRS3SEu2IEt88s5a4fHS4kpSR9Lu6qUjwD9blOi/lvIV6oJT25L2V8?=
 =?us-ascii?Q?vpMymhjC6gNlXjShCoQ5PbGyVsnZcC5TBD19RleF5eGP0YjVJHveXe6JrsXu?=
 =?us-ascii?Q?esKwmGc478LjsqnsTf4ZRDK/C/DWaxtCNbg3QgjP9DmiqLOJ+rN9gl5A2GbH?=
 =?us-ascii?Q?4stMtZTwZa/Pt7hGZHMpFBP5TFPFtlKR35la0M9GYd/djGwR8b5YdiDcFTTi?=
 =?us-ascii?Q?IViEpYNZ1y7NzCW9daF6n2WeaTqLj18HByiXeGOTTeIE+NIcrW3cATRrH032?=
 =?us-ascii?Q?BusJAeE0Z7FCuEIlUdqOUGmnBwTOcwU5AX61dKwAA/g9CzeAUExMYbJMZBFl?=
 =?us-ascii?Q?I5MmSUg2eQGf9IwcyGH/lncyG3iLWVFx3qMJp4x72DFgmoO/MVS3aHxlSnq+?=
 =?us-ascii?Q?c+6wuESK5CS9I6dr1g5goI9wuwtCUVY3ebKmDEYaZV8cf1UP0dRrs7x79Bb+?=
 =?us-ascii?Q?qMjDH12MpMz02wYmK0+38obgu31ht9VOviGsY6nhF4Al89XQ9dTPwolm5DdQ?=
 =?us-ascii?Q?ghIxkZIS3yFbQqihE7Gu6rTdCtoskIZpnjh2/PWjLq4oFf/FgMyC0tLLv0C4?=
 =?us-ascii?Q?C4B2iaPzcPsmnJspZy4IICyr0/gVxVyriYiXH5EIEFktN0pRLVspFLsUwImU?=
 =?us-ascii?Q?RW50p4Gz1Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7077.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf96d283-d9a1-4348-54b5-08df1d4078d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 09:11:25.2007 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HUvKC6BNhMzGR0fsDuXBHPZ6jnRWZ31pY52Bo9CCrP38NPy7Id8tx/JQn6GMnVBhs675rIHNnzpdLF9hAi2s6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9723
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
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Monday, September 7, 2026 8:31 PM
> To: dev@dpdk.org
> Cc: Stephen Hemminger <stephen@networkplumber.org>; Dariusz Sosnowski
> <dsosnowski@nvidia.com>; Slava Ovsiienko <viacheslavo@nvidia.com>; Bing
> Zhao <bingz@nvidia.com>; Ori Kam <orika@nvidia.com>; Suanming Mou
> <suanmingm@nvidia.com>; Matan Azrad <matan@nvidia.com>
> Subject: [PATCH v3 4/5] net/mlx5: drop unnecessary STRICT_ALIGN
>=20
> The transmit inline copy splits the 8 byte case into two 32 bit moves whe=
n
> RTE_ARCH_STRICT_ALIGN is set. Only armv8 aarch32 ever set that flag, and
> ARMv8 does unaligned access in hardware, so the split gains nothing. Use =
a
> single 64 bit move.
>=20
> The destination is inline_data, at offset 4 of a 16 byte aligned dseg, so=
 the 8
> byte store is always misaligned. Write it through the unaligned type; a p=
lain
> uint64_t store there is undefined behaviour and is reported by UBSAN.
>=20
> The debug assertion on the inline data offset goes away with the strict
> alignment path since the wider move has no such requirement.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
