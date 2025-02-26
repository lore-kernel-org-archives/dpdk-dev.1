Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1552C021B8
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 08:36:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CF5B34029F;
	Wed, 26 Feb 2025 09:36:34 +0100 (CET)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2086.outbound.protection.outlook.com [40.107.100.86])
 by mails.dpdk.org (Postfix) with ESMTP id 20C054027C
 for <dev@dpdk.org>; Wed, 26 Feb 2025 09:36:34 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uo19Ru7QajwukS3LOOH6xGBZIFAP9eGyqLIYBVw4k52D12XFb9RkTQsJpBsWzWKwGik/bhfHYLeh+QLw7M+9MnqfecDHRJ8S3ipUhzETK60Fz95ArD25B9Jb75ZOOk/qGHg2gS2bUwBIeqSSbfhiyMNJC9X+Tdt0qXOPWFEegFJyvYLYqhaW6m3GbA45zMlrvwNPtdWDcn+6pgfbuac9GL6DCYKD0ndkSnDhLQDnHP59ri5QxbZREBihxLhpbrEz7sRqU+xbjbcc3JuV/OXvLCpf0MEPaUP+X904ofLe/nlVmD6nBEZNRGpThlFwRnLI4BCKHCKZIgzz6T6/AUJhOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CffhUMlD1ZxfP7pqVvVsVeGCea1VYrzEZyAKepk8+nk=;
 b=A3R21CuhtiZOWOfgaT4UAEEVqI9r16L6VcqyQE/adycU5o1Lt7jfIcSGn/IXcd/Rj8gqlix/VGHRsihC9SPmFWDR9EcYagp/p6lSQhybDWqL7Vr7fcpa8IQYMFXurzHCxm9Pskcs83FDzC9Olmooj1SZC3XspFPbFi/8eAXCdpHmoeGEADx6xbNrqJXrEytfLlAiRw5Af5Uzmt41OUdHvQ84jXUbnApC1VJzVSSUQUr9lUD3GxUFYas8N3JQbJ0qhhoLn+oTVO+mJqHXbnAUaXoouTxA0D9jwR2JuOoIlUujqvw8DQBB+Y/9IVrug6Yfp3mpDKiD4yjlGdXRJGoHmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CffhUMlD1ZxfP7pqVvVsVeGCea1VYrzEZyAKepk8+nk=;
 b=WMaeijVj7nHTysYp1oU45TtspGGBNYkaAt4HURlC7mnxVkbsiPo43D1IsOdKbqQZI9gGRbwgtYZ0fr07K5HkkSiaVmpErrhcMPr7iTtfbDID/lREkwkthaFR9wDGJj/mSPRRgt1AYdZaAFzLJRBYQXIPyqBdGS127i1Vt1ozwl0N6E8pg7ekPGdHnvryb7H1gUcN7/JIx/mysgwXsBIpD8UjEZCWVWoguiKIemNSE60LDlTEdvAWCtEqbaZzb6F3p4xmrlyREYcTcQVr/OWiOnx9TYqUDLbrGq5VoPx+Ae8YofMsFbH0XzpO9eBFwpXPT9NHwnuqKANWVD6GU7WrdQ==
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by IA1PR12MB7565.namprd12.prod.outlook.com (2603:10b6:208:42f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Wed, 26 Feb
 2025 08:36:28 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%7]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 08:36:28 +0000
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Gregory Etelson <getelson@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Gregory Etelson <getelson@nvidia.com>, Maayan Kashani
 <mkashani@nvidia.com>, Raslan Darawsheh <rasland@nvidia.com>
Subject: RE: [PATCH] net/mlx5: support ESP in non-template RSS expansion
Thread-Topic: [PATCH] net/mlx5: support ESP in non-template RSS expansion
Thread-Index: AQHbgQuD1ScJGHCpUEeYXf6eGD30P7NZUNKQ
Date: Wed, 26 Feb 2025 08:36:28 +0000
Message-ID: <CH3PR12MB84604EA2635EF43359DE5769A4C22@CH3PR12MB8460.namprd12.prod.outlook.com>
References: <20250217071316.37195-1-getelson@nvidia.com>
In-Reply-To: <20250217071316.37195-1-getelson@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8460:EE_|IA1PR12MB7565:EE_
x-ms-office365-filtering-correlation-id: 9fb09d58-6bf4-4748-dcce-08dd5640aa20
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?NJw0AeHw2yFBjwRnqP+KfUl+T0BvGVYG4IE9K8XipHuGwYaPBpEEfzqtLeRV?=
 =?us-ascii?Q?XDrP6jIVCiX4D3YOSCf+n0HKg5kTMvB4IDkpcIKuTAnU/7LoGBA5TDSMsuIj?=
 =?us-ascii?Q?vZzGA1HVKAT5KHn+dyCRSWNb+6P1sRpD6+0vfSKn0i2je2ZOpEBXdn4/x1Jx?=
 =?us-ascii?Q?KixadC1qrnOqzrKyybsSJS1SWe1TAh3SD6ttZDq66iAqhl+EjEFaTWOt/H0Y?=
 =?us-ascii?Q?eZsExvkJnkBf0OUM6R99LyZ1/qHd+dMTTE12yd5XQjQGEkbpWBIQnNhnEGjQ?=
 =?us-ascii?Q?19q92ENZypIyZeCKRmt8cxqfL5ao52i0YhhHzl1eu7gbLKCFjxHTBhY30jqO?=
 =?us-ascii?Q?Aa4JRgkmF59ouB8q2Hq/1ccU/2B6BfFvv/SxmbWnCS6LsHIsddabidDIT1jC?=
 =?us-ascii?Q?gfNZF6d1Pzf8vOG4jaC9QXjWpCmLUCeP3Y6CrRqYQJT48CKFvU5PdfwCO6XH?=
 =?us-ascii?Q?Ukz/KfDqivyiMDerYzrX6UsQ3OVdgDmDI0InxFeDeOrVoXGk3A+iAQ/FuKY3?=
 =?us-ascii?Q?RWkLl5YHJK533HxNCfY7tAP5E7GBLj90gDgfvJU1wC9J+cHqixps1ZjTQoUl?=
 =?us-ascii?Q?crKGuVU527CTRrlNugu65aGNhQjk3ViocEEZPm/T4rhbcoWy0xx9csGeA3fY?=
 =?us-ascii?Q?WQLOq9jpmHsgqZukA1o23FL3x8wHCgErziD4LPRF71d65xm90i44U0TF/6gv?=
 =?us-ascii?Q?v2+wx62lOM84UGMLHp4JGyNi0RRLqA1M3YEzAraDPi+3Ku0TGBRz1aUM0D9u?=
 =?us-ascii?Q?HjcywickkEDQdoWYNezjlLtBwsFPGIhA9eTPMKchpSR3XQXLtPIop5mmSuVQ?=
 =?us-ascii?Q?JZ2BXJh3W9zsLQiEGFagwq53Z5f1MRSDvjXHvOLDMBRLWThEZp8U0WTsVi0y?=
 =?us-ascii?Q?ppdfsvzE07DRtIa5ehglhil0RzrS5mQtO/aQf6QLQXX6dnCewlaX1DTQj6jX?=
 =?us-ascii?Q?TlSStjKXXe9No5xaLyf75yLbsYVPtMwKCHvLoJkBuJwJqGySjzYnFRooC7kV?=
 =?us-ascii?Q?d9LWLXW1Qrw+xSxiNTqIxtcTtQ/Tpp0UJaHfIfbRieNhvLkD7uz1eH0tXt/Q?=
 =?us-ascii?Q?M32nee2WXISHfCNAZcMKltZ/8FYlY23MafMubLbqx6Wg/fE1Rb17xKWjyaLD?=
 =?us-ascii?Q?YX+Zp6YYNEhVkQ+pQZVK/s519Zqp8FN9ThpiBT8nv2K4yYS1h0tV6bvdGfLn?=
 =?us-ascii?Q?R+U6Y71N3Kbres6IM8V3Egf9KWS0/Eyf0PLwbTuEiJ/h2ygGkbberc3QSLNZ?=
 =?us-ascii?Q?fpOhpC6AF+4+9UpnR+z+H2es24jEfy7h5lHc0meIWg6kq5QdWlUFWokcHA2M?=
 =?us-ascii?Q?6bTcVxGuru0BmzsbfGVEojgDfy0aFXiYjeVcr9wAorWkWLw8OYr5av9xB97I?=
 =?us-ascii?Q?N0zP5IWmZBBN5nTNwRCfJo3bZLH8+kBkp72MI4Bi/B7m3hzBJ7eXC4RVQTcj?=
 =?us-ascii?Q?MbWLHpjD6ySbq9EdzVYqMEJP+dnhnUTr?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TcHZbBuoh+/zFCZ9arEqIS2xWWsobBETPHntPxTQe/HxAPYYSN9wMQZ+xcJU?=
 =?us-ascii?Q?mD0Gch9Zcitp8842PtA1iHzMjC/Uo2MLhhZUrZKswUI1EO5a26Jv3RR5oLKg?=
 =?us-ascii?Q?EWM1YfJZofLaKzZkb5sIvcoeLC/94CHnMiaZWNtOGfBQeMYY25T9CjFX/mOt?=
 =?us-ascii?Q?SMSCAqzZv3G4NiXrfWIJN0JQywiYXn3PuG9PGIaSaKauL9FnFEpL+Gfl7IE8?=
 =?us-ascii?Q?NkS8fS2RSElQ8F7yTDmYjxzeUyyofloMXey6ynXi6fIEHKq16rXk8i8EFpiC?=
 =?us-ascii?Q?q2blPEGuHqsu8J6rqEQ5yibplehTX0NPCImDZp3FCA67U29I8oN5u+RXsYzC?=
 =?us-ascii?Q?qBaq/8UY2t9UY+GZoqO+yr8I3DWq6YM6WP1ivJvpsjH98Kpd7/fOwgKbz+UF?=
 =?us-ascii?Q?4bMmEoowPD9BRvb8df3HjFD4sWCc+WTFyNAm4XUgBkiCxJVTUr0ZoITB+7UD?=
 =?us-ascii?Q?DnjWRwfrNuKTBL+3qkgGaGTJx5Cw/ttkSAYwSQxY5Rm/dWEVoIeD4/eG/K6l?=
 =?us-ascii?Q?mqZLaxeNel7GQdE6XtMldB9F0UHVXufCH501OUAtbLc28QicUdzbdBCWJuS2?=
 =?us-ascii?Q?0oc7T5Vj4UpSYD5P+MVjJYG+Z2hx17DUPM4RM1lxGvvk80gaI4+91hnJlkXD?=
 =?us-ascii?Q?YPourrlXqXoCZwBu2JJFPa8LLpb1M3G9aq6+fcVWkXuJH+5KEkaD5ZYIT5au?=
 =?us-ascii?Q?qBBx7PeTcj5bhumcZEmb67IpseXmbK2qMJxI9YHirCCD56nLs//YI3HDxzQ7?=
 =?us-ascii?Q?AmIwm1tfDqkC32LH8H+1hVGZ7qZ4d6xHCGIQZxHRU6DZlk+6xZVt99A5tJLS?=
 =?us-ascii?Q?7o37G1M4npSQQeCW2tNGdeK/BXM77RxHcVLZ/gXBKOgZvk/MqPnrSiH6hMAV?=
 =?us-ascii?Q?dPskmmpbg7sMT+G/B9dZFixx76HoTqT6DLswp1xuhiykFghhx6eovnb9aAuZ?=
 =?us-ascii?Q?X1uoKBIAgix4DQ957MKisT3vRsPpNFbom8EhmrljzR6EChkOOo85PsBQ+Mcb?=
 =?us-ascii?Q?7xiuGph0CopVmkOvz1Xndw0jnPHCIBoHvf5zyjdOWbiSJ/iC7xJJE/yE+ITk?=
 =?us-ascii?Q?QUEovrhP26WuhWxOY/A5ICF++01JsA8aG3bj5kYYaaLJgconplgMNDNqX/FS?=
 =?us-ascii?Q?0zsVT8EnPTocPxtrN3ZpVZftpemOefcu10zA/WsO3PyZ6sRqzDTwj38MJ+MJ?=
 =?us-ascii?Q?xmiEGa71cN77YaRu+kLqicnr1GOecZ5UNP028ImA0Y5Ht0KaQqW8P4u8Cgh9?=
 =?us-ascii?Q?Osd8TFQvd+QZGbgGAIAIlVYL9flnLMLHbr8ppOFCtmxUg4Rud7z67tasBXyB?=
 =?us-ascii?Q?y9zqRLJyo9nNme2S6CVOBD2+9N+qdVUia/9WLSEm9lI/xTd2tccEmxB2fE7i?=
 =?us-ascii?Q?XaIXKLJN80WiJIlEoEaR5D2NO88UtoC8hx04x+e3hDaqdchsleUFEhrm7+s5?=
 =?us-ascii?Q?HumLjzeU2si5ea02wf4EESiaMYk3DG10dPVdwbDC1eSRH4TwOdq+unleVSTq?=
 =?us-ascii?Q?1FV5JxU+n8oee+9tBwHgb0mXMawXXZoKmXSJwzBiruv1PfYgfOcymEyBkyK2?=
 =?us-ascii?Q?0Jn2MsZpYsNbJnklMwXtbHCB8Yo/tj5RwkAH85RF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fb09d58-6bf4-4748-dcce-08dd5640aa20
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 08:36:28.8546 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xnhiaC2TWQr9D6P2w64CuxS9Fa10H3yBY1Nv0WZVCuNtH5LAaITqOc8nqjhXmJX+AAZDxpbSV7PiurP8oruJCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7565
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
> From: Gregory Etelson <getelson@nvidia.com>
> Sent: Monday, February 17, 2025 8:13 AM
> To: dev@dpdk.org
> Cc: Gregory Etelson <getelson@nvidia.com>; Maayan Kashani
> <mkashani@nvidia.com>; Raslan Darawsheh <rasland@nvidia.com>
> Subject: [PATCH] net/mlx5: support ESP in non-template RSS expansion
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> Add support for the ESP protocol in non-template RSS expansion.
>=20
> Signed-off-by: Gregory Etelson <getelson@nvidia.com>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Best regards,
Dariusz Sosnowski
