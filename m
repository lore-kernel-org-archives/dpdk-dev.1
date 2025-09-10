Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B219CA101F
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Sep 2025 12:14:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 42EF740270;
	Wed, 10 Sep 2025 14:14:04 +0200 (CEST)
Received: from egress-ip11b.ess.de.barracuda.com
 (egress-ip11b.ess.de.barracuda.com [18.185.115.215])
 by mails.dpdk.org (Postfix) with ESMTP id AE934400D5
 for <dev@dpdk.org>; Wed, 10 Sep 2025 14:14:02 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11020115.outbound.protection.outlook.com
 [52.101.84.115]) by mx-outbound17-45.eu-central-1b.ess.aws.cudaops.com
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 10 Sep 2025 12:14:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yVJJbmXNiBPNgDRTXEmQL/We1AV4/QIIsv/X3UIA1IItzTo9c/VYKp09MBZoqpGO0sjx5hixZ8OSNXFfYJ6znTVNxuu3Cx9FyaFB5vb7o+7pXkOfqV2j9hemU9iwv3lyg38h+vy7gKlQr4wmjH3ieRMN22Dv1Re/oCNWPd/kNPV32wRQl8onisDliNOY4eU8bx0KUzcHOxKTk2EEI0DDS9SCuy+ZCfEMd2IhVINvF/bBSlhconvQH+jQNg53oH2hB4Sg4DaLH2SuE6loYO6L5zcm4GzBBjOYC+JmQZm9Lq2iv4fsytHqNR99rSdaoItOd866UNYoHX/t3me7SWcjUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WdKl3VqjUMfqcPUgl/hIbnejxBvkEuCPlIAWttmnuaM=;
 b=uyjixAeIAcA+T66dBqaZ/by0o4OtU0g1+uCe59NS5t/yJxjUwYj3KU+CrHU2wbR8XMxSkVSD/9IUv/Y2CF9Tg85msRvaqOlnYTrZqFfS/fAqUwiKeIsI8sFpgnko1SG36VG+Bc9obda+tUmyMrSuaAzdA5io8m9d+oolgB5fY3dxnfMWRC9A8L0uev0owQFu3/Smdo1b9vXQA7Bh2hrG4E6u1rW8Cta5t8xJQyM59kyArrA2ruITVoWsiPHEzHFHZBaDB508xo+7B/quYzW8RI+XC3JvYuDzghPsLwD5d1zSv8gmtC9j0X/oRthMl5iLUywLxtDKyOiy8/RoaEo57w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=napatech.com; dmarc=pass action=none header.from=napatech.com;
 dkim=pass header.d=napatech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WdKl3VqjUMfqcPUgl/hIbnejxBvkEuCPlIAWttmnuaM=;
 b=ioAglTwt/2kko0vcKBZDruGPmDVSFGjiUfYL3/7ynFgM/ZexIhu9P7E4gKfmFs1FLF7aRhhUjxSlXTKLwcN+Yb2zdHQJBCZsUMS94IHz9XId8O8s+kykAY1de9Pzx80rzxmL88crf6cMCofAJ8Y5ZSyck/vV6JsLFLHBBdKeE7o=
Received: from VE1P190MB0830.EURP190.PROD.OUTLOOK.COM (2603:10a6:800:1a9::5)
 by PRAP190MB1786.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:29a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 12:13:59 +0000
Received: from VE1P190MB0830.EURP190.PROD.OUTLOOK.COM
 ([fe80::fb19:d808:3eac:2ea3]) by VE1P190MB0830.EURP190.PROD.OUTLOOK.COM
 ([fe80::fb19:d808:3eac:2ea3%5]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 12:13:58 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "dev@dpdk.org" <dev@dpdk.org>, Mykola Kostenok <mko-plv@napatech.com>,
 Christian Koue Muf <ckm@napatech.com>
Subject: Re: [PATCH v1 0/7] migrate threads to DPDK service framework
Thread-Topic: [PATCH v1 0/7] migrate threads to DPDK service framework
Thread-Index: AQHcILBxVAT6D64AdUmBYJieJ8JPsbSJtzaAgAKeP84=
Date: Wed, 10 Sep 2025 12:13:58 +0000
Message-ID: <VE1P190MB0830BD7C560B3369EE83CE14800EA@VE1P190MB0830.EURP190.PROD.OUTLOOK.COM>
References: <20250908110446.1071964-1-sil-plv@napatech.com>
 <20250908130809.2266b0d3@hermes.local>
In-Reply-To: <20250908130809.2266b0d3@hermes.local>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=napatech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VE1P190MB0830:EE_|PRAP190MB1786:EE_
x-ms-office365-filtering-correlation-id: 0cbd8154-1af1-408f-1670-08ddf0638525
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|8096899003|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?n3Dt/udZnY/zZpO1/SS/iBerxU3yKjFuXll40qQKRDJa2MhyY3Kj4K+maZ?=
 =?iso-8859-1?Q?wrcbfDvQwdaFpmgYIPQIcrNHzw5uLaEhCLIPVhJ1UdtF+vh/zBz3FKx9hk?=
 =?iso-8859-1?Q?sGmNnBCtcSYOeyCkPcgSVXLlqp16t7mirojxSsRfVSQhPbycQ472oqisV9?=
 =?iso-8859-1?Q?zhqV2JuJFVAbsx+1I26ZxBtR9tFgeNpxxktcQIe0ap9Qn+UYX4TOVB2JSu?=
 =?iso-8859-1?Q?7KJK7xvm+HMuH6o3pALYHBRhGAznSI62JeGXKuY1q95iNCH+m43Fr9hd39?=
 =?iso-8859-1?Q?Ok8Ol0UsRCSMf7c8oRNqpU4BRzfmqHgTkq/Z+Y2+aqg5C/bnIT9yj6rXRH?=
 =?iso-8859-1?Q?O0M++GflB3udr5KC2Z8wOmGhhUWchAOB0eDeksjZEFTKcSyc8iJz99LJ2M?=
 =?iso-8859-1?Q?5iGPHo6Gg654GvkzR0GSI32DuWoFbKgp/A/dlwz+5R38Ma7kNMDdY41Z24?=
 =?iso-8859-1?Q?kmyXqOuJvHgEFGP1V8tszbqO/G6qQ3Iw8jjTF5TOqjwaBdVU9ja5AKGJ+A?=
 =?iso-8859-1?Q?UDTAtooJQxvjgifC2xXkRHyWt8/R8KBrxYVYPbdAvX1zEazIrpUuAz8b9U?=
 =?iso-8859-1?Q?o1Fv8BzO+bPVd6znvwZjDg4sbQFTBtWQBAD2EBGD8B7QehKvplbBWzsJOu?=
 =?iso-8859-1?Q?1IK1hql1tJ7T2VlNGQFKsMze+P0OQirhDZlwQrLNgT5YDUnm20JqMNGWgN?=
 =?iso-8859-1?Q?YlgM9BOkAiBNPCaAbSC5B6A7HJFaS9xwaZ+QCEbmlopRC1ZzT3LVvDzcYb?=
 =?iso-8859-1?Q?VU5jIiUdKfPHwfLDRKAsO9lKRrfaQsqxgmEYVzLhDltVZiJvAWa5NKaL0f?=
 =?iso-8859-1?Q?ySpWJ71xnHQql+2fVZoY4AvN+Cpccx2DmBNJ5HncSoe7WLGcgAdnt5dmaZ?=
 =?iso-8859-1?Q?x2ggOCwPqdIDioTawbJv8DrYP/V0B9XwWy4AeCCowd7dZ/LdwRnes5nKn8?=
 =?iso-8859-1?Q?3r/lfhBkyOWdTJ7WMw1UeYV8FuWldmYuxy1T8GMgL3a8ZQqTui6jgwHnAQ?=
 =?iso-8859-1?Q?OXgYEko6tXY9IN107cgAmt9+0CnrBmc2HCLCn1lXSVUzm3WTJecgG82RPS?=
 =?iso-8859-1?Q?kVoIPMlUyQXheS74cUvwSMh86Ow2jZqCDaQci8BLPR2RwdiUpVVrz5DdRE?=
 =?iso-8859-1?Q?bNA0WR6ChgCd16z6d2x35fvHBSOJlrjGrn2uh5wGlIO5IvzzE476tb2hX+?=
 =?iso-8859-1?Q?exDt80B4Q5TPlxEoCaRkz5/DYUnR0ATEpVdmk+a1LFK83MPDLQBQkj5UBv?=
 =?iso-8859-1?Q?nfhnbnM2VyFXQEsL6SdeoNbAUfhwPDvytFhv7v6ItTvYn9ZZ7wk7JcdIC/?=
 =?iso-8859-1?Q?0YRYLmcUWzF5bIt+4suufF9Yuha6Q1i+dC5379dP6Ybbpn43WeH/i47NzE?=
 =?iso-8859-1?Q?XyRX36/XlKOxKUePunUfSZ2owqr4+64XYFvZmfBt1EnFELv9ecSE6gP7c+?=
 =?iso-8859-1?Q?P57hksPwhdMLYFMajjIz4gb6lwu3jbxKhH2uM3J9iEw9CNUWep4ze2J1Z7?=
 =?iso-8859-1?Q?g4QjdOk6LOxVp8/gPbQ7FJDOQbCdaw09ujQy8SwWVb/VFvWp654OwzhMOg?=
 =?iso-8859-1?Q?Cvibq2k=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1P190MB0830.EURP190.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003)(38070700021)(7053199007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Qo173bhQSqlYFz/lrBgI+lKYA84UuRwpG3sbu9/93ueJUQB4O7pdQq96VK?=
 =?iso-8859-1?Q?Xug2JSRrDCGR+qRnu0N65ZINMqXxaIGJ40c4juke+LUaNay/gUuU4N0PtS?=
 =?iso-8859-1?Q?Hib0pW2UAnASs2hgFZL6VNsHhmoGfLom3btpJEVr3n4tKSG5Ohjtwexlgm?=
 =?iso-8859-1?Q?NAkGVu4J0uJl2pCGYfedCL2GAtTxlFoYeFNgAvVPFjUZaGGKNZTvHSv7yY?=
 =?iso-8859-1?Q?TuL6pPLF3isRw/RoXN29wsjRWb2XIS41iKOVleE2Pe0Ny5uwrRQlnLXgAM?=
 =?iso-8859-1?Q?vtZHiJL4c5dVnM7bBmztBTG3HTq+c6ediojiFfbxCWf6xrqU6ewGHmT14W?=
 =?iso-8859-1?Q?LlF/fEXqlw8J50p3ilaHezbhNCIok3zIIQYYuV1QnyIFyQyDQCKa++ri/B?=
 =?iso-8859-1?Q?DBbtQtcBegDN/GX8e3ck2Gpce576ukJe/CIAS6ufrSiHxXWrJzHmHT0Qq4?=
 =?iso-8859-1?Q?m6EW7XkKLp3aJb87W9YLfpQA5hKBNxascXBgj2iobpRJzz7Y6uwVRMv5DQ?=
 =?iso-8859-1?Q?GDH8MlmhMO6lRQZgJyVXIMlZFznbU4GBvoK/D4/VYjVAtjkA7O1jRsUc8B?=
 =?iso-8859-1?Q?yzYrbdh8l9wayeDHK7l50Tko1D9miZgmpd/qyPhuQ6LPtyoTS7W5P9FFfG?=
 =?iso-8859-1?Q?MOvFoJxmGVJb8MQhmO87Swkp/+rwMhqvkh+9oh3FeCE6oi1iyiNPdawul1?=
 =?iso-8859-1?Q?uGWitH4tjv27BFcwZjn6yCBmoZ3OrkA86MQCSpBrFQD7pbYhh+2oN9H2sX?=
 =?iso-8859-1?Q?SjPhSTzME7n0q3EUsmd0lpHwqypoG1on46tPQrzljemNTEbYHZZHQ85HvI?=
 =?iso-8859-1?Q?9hS9XaK9kiM9jcgYkWTBd/0MbqFTIoTlXhjO154ErDDnJHBighrcfIS770?=
 =?iso-8859-1?Q?VvLsmJw7EgWasTNsIN5ILSt1W101l4BFe/lDdR9lpysbxB4ldrMf4RyaGn?=
 =?iso-8859-1?Q?v40C6etiIpU8/ZmriUQXe/ItxNUJETffFGpHDowHGQ7+xbicbJIsk9uRMI?=
 =?iso-8859-1?Q?qQdQghV8h7VQLJ++kHT2aIuJJzU1uTg/W5I5aXnixz5E+oxa92HsLKKca7?=
 =?iso-8859-1?Q?88Akro7SIfK/Cge9vdngjin/xaBrU1RzXhGfPJ/FeW5iO4pbraZv6YAiTL?=
 =?iso-8859-1?Q?tWUkalvH5ZWbJ6B46Vh4yMALAn2Y+E53JJBA7iH6rdDu2ZFgPgP03AV6H3?=
 =?iso-8859-1?Q?GC2MSdgAYiZQNPuWJPmtS/5tvOCzZbS8fQr0L1vtTQxW8AynHfgvIljRgh?=
 =?iso-8859-1?Q?re9tvSAVCE3uNsXz+bhxcnQsvV+46OwaiFRvBsmiqQ62bnAT7EXvsI75yO?=
 =?iso-8859-1?Q?D2ooZMrn5e/Y37F6Inp2g68WFz/7/pLS3mrTpD7Ve0CYk9uJ5VA4dKg34v?=
 =?iso-8859-1?Q?ud73Cg8T0NhUN1D46jY1X0l99rZmApSCxNMdYQdLiBhiOJrnvgjJd9aiXW?=
 =?iso-8859-1?Q?DMjBR/eUbRvAhC21TQq4qUyorE2loV/KuJMbUbwOwHEKIK+0xuUXFr6V3C?=
 =?iso-8859-1?Q?IzRRlniWFP049FEb+fm4IFyRc+6ludOtTzJphtTKoZQEQ7xOc3Z4XvU5yq?=
 =?iso-8859-1?Q?1yR7gP5MJgxa/fSTWxMxmKwUQuawpNAKmqy2dkP6YfYlqrVLITyXFh+vXj?=
 =?iso-8859-1?Q?SzVwLno/cx+ano0Nv94IhRruS44mpeIcoC?=
Content-Type: multipart/alternative;
 boundary="_000_VE1P190MB0830BD7C560B3369EE83CE14800EAVE1P190MB0830EURP_"
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: DejbeMw5cZ9+5w/9ZboFG11FbSy+WmLu3sGOc/BjZsBgkaPUnLnUQJ5ChGYnyQS/hrL/2277mJq5/nHFsKIoOWwsIsVYtJwbwxw7jWIaBRBU1VPiuuTQ9JLZ28dOFA4SX4PexZRiGHfxa+G2yDvq44ZAufnb0dEpUvB1iasCd+Q5EkvDbCRWK02RC5SmgfmcOJXAnGgkkpVQsiyiwan6AVYNJhSmH7b22u+jnFJB96ewhVgdqe5lnyIQ1b64hOI8ODCjWTgUljjPD2o8dKuEJr7MaJd9WsqAoUJAmFTeXRsN0LxWotnoJFyNo17JzizFi9EeTQBC4bduWllZ/Nz8ByuFzee1X233Puh8Kvn0ORosb0Y3NUbHY8X0U8BFMfradkcyeiNlHgYXdd0+m5mCC/854x4RrS7UnsdIVQr0ApID0vyuowIOTdlXMlybZqxE8LH6EP4zm0nTg9c+axZc87M8e3kpXcyxqNxVQM6xUVWQR8vuG6od2/BVPrBWO6ygjK5r/yuHW+GowpyuhfBBYiQ+jJl9zJltml4p9IO0+XZ6LkxceAMamIBh/CKLCk0sFZokQWQ+j9a+4nNkaD1DOQIH06Pehrki1O1lvIfCZnQdgYACn3TtdK7b5zXgnwZZHrrsmHd0cpct7s/pavBwLRtrKhMRrjs8AwBEA5rUhog=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1P190MB0830.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cbd8154-1af1-408f-1670-08ddf0638525
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2025 12:13:58.2224 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6635FQJtx9uC6SGUj6P3mYb0DQGgyC4OTaG+sqIDRBW+JENyo3oCsAcAxYK7nq7XZO2xkL5Rfh2J1B0iTRLJJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAP190MB1786
X-BESS-ID: 1757506440-304397-7716-10-1
X-BESS-VER: 2019.1_20250904.2304
X-BESS-Apparent-Source-IP: 52.101.84.115
X-BESS-Parts: H4sIAAAAAAACAzXLOw6DQAxF0b24ppixx5+wlSgFxLZoIgqmiBSx90wBzdPVk8
 7zB/HtMEMfO8F+wExsNGobJyqXJQgpyZvrQqguIVmUUx5rwDndfuufy6tgvfyKxUmaiA
 dXYwurHpkatTV7a4Hz9QeWgtEbgQAAAA==
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.267381 [from 
 cloudscan19-119.eu-central-1b.ess.aws.cudaops.com]
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------
 0.00 HTML_MESSAGE           BODY: HTML included in message 
 0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS113687 scores of
 KILL_LEVEL=7.0 tests=HTML_MESSAGE, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
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

--_000_VE1P190MB0830BD7C560B3369EE83CE14800EAVE1P190MB0830EURP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

From: Stephen Hemminger <stephen@networkplumber.org>
Sent: 08 September 2025 23:08
To: Serhii Iliushyk <sil-plv@napatech.com>
Cc: dev@dpdk.org <dev@dpdk.org>; Mykola Kostenok <mko-plv@napatech.com>; Ch=
ristian Koue Muf <ckm@napatech.com>
Subject: Re: [PATCH v1 0/7] migrate threads to DPDK service framework

On Mon,  8 Sep 2025 13:04:38 +0200
Serhii Iliushyk <sil-plv@napatech.com> wrote:

> This modification provides better resource (CPU) management for NTNIC PMD=
.
>
> The following threads are migrated:
>         * FLM update thread
>         * Statistic thread
>         * Port event thread
>         * Adapter monitoring thread
> Additionally, a warning is added to inform users about the importance of
> dedicating lcores to the DPDK service framework when using the NTNIC PMD.
> The code is also cleaned up to use pthreads and rte_thread APIs.
>
> After this patch series, an each application using NTNIC PMD should
> dedicate at least five(5) cores for DPDK service framework to ensure
> proper operation of the NTNIC PMD.

I was concerned with excessive control thread usage before, and this
seems to be worse not better.

There are conflicting use cases here:
  1. The original DPDK goal was to make effective use of multiple cores
     with no locking. Intel customers often had idle lcore's and some CPU's
     had lots of inactive lcores that could be used to get more work done.
     Dedicating some to service tasks etc was a natural outcome.

  2. DPDK applications (OVS, Grout, VPP) usually want to know about lcores
     at least in the documentation and examples. They don't cover the case
     of service lcores.

  3. Dedicated low core count smart NIC's using DPDK. In this case it
     makes sense to be frugal with lcores since the point of the smart NIC
     is to be able to run other control services. For example, the MS
     NIC had hard limit on the DPDK part (via cgroups) of only 4 + main
     lcores.

Granted NTNIC is likely only being used for a specific application on
a specific set of hardware.

The ideal would be to have better control event management in EAL.
Something like "libevent" style API. This would reduce control core
needs, and avoid any potential resource conflict overlap between control
threads.


Hi Stephen!

Thanks for the detailed feedback.

The migration of the rte_service actually improves the performance of the n=
tnic. That is an obvious result, since we dedicate the entire core to a sin=
gle service when the default (1-to-1) mapping is used.
A similar performance and stability can be achieved by using threads and mu=
texes (The rte_spinlocks introduce instability when used with threads)

The ntnic service API provided with this patch series enables users to map =
NTNIC services to lcores as necessary.

All NTNIC services can be mapped to separate lcores or to a single lcore; h=
owever, this approach has a significant impact on performance.

The mapping of all services to a single lcore is similar to a "libevent" st=
yle API. However, there are no events; instead, there are continuous callin=
g services in a predefined order.

The one core cannot process all the services due to a negative performance =
impact. Following this approach, we have to spawn a thread (or start the se=
rvice by looking for a free lcore) every time an event occurs. If you have =
any other vision about it, please share your opinion.

In the scope of complex DPDK-based applications  (OVS, Grout, VPP), we stil=
l have options to use (1-to-1) mapping by passing raw EAL options -(s SERVI=
CE COREMASK or -S SERVICE CORELIST).

Thanks,
Serhii






--_000_VE1P190MB0830BD7C560B3369EE83CE14800EAVE1P190MB0830EURP_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div id=3D"divRplyFwdMsg">
<div style=3D"direction: ltr; font-family: Calibri, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<b>From:</b>&nbsp;Stephen Hemminger &lt;stephen@networkplumber.org&gt;</div=
>
<div style=3D"direction: ltr; font-family: Calibri, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
<b>Sent:</b>&nbsp;08 September 2025 23:08<br>
<b>To:</b>&nbsp;Serhii Iliushyk &lt;sil-plv@napatech.com&gt;<br>
<b>Cc:</b>&nbsp;dev@dpdk.org &lt;dev@dpdk.org&gt;; Mykola Kostenok &lt;mko-=
plv@napatech.com&gt;; Christian Koue Muf &lt;ckm@napatech.com&gt;<br>
<b>Subject:</b>&nbsp;Re: [PATCH v1 0/7] migrate threads to DPDK service fra=
mework</div>
<div style=3D"direction: ltr;">&nbsp;</div>
</div>
<div style=3D"font-size: 11pt;" class=3D"elementToProof">On Mon,&nbsp; 8 Se=
p 2025 13:04:38 +0200<br>
Serhii Iliushyk &lt;sil-plv@napatech.com&gt; wrote:<br>
<br>
&gt; This modification provides better resource (CPU) management for NTNIC =
PMD.<br>
&gt;<br>
&gt; The following threads are migrated:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * FLM update thread<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Statistic thread<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Port event thread<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Adapter monitoring t=
hread<br>
&gt; Additionally, a warning is added to inform users about the importance =
of<br>
&gt; dedicating lcores to the DPDK service framework when using the NTNIC P=
MD.<br>
&gt; The code is also cleaned up to use pthreads and rte_thread APIs.<br>
&gt;<br>
&gt; After this patch series, an each application using NTNIC PMD should<br=
>
&gt; dedicate at least five(5) cores for DPDK service framework to ensure<b=
r>
&gt; proper operation of the NTNIC PMD.<br>
<br>
I was concerned with excessive control thread usage before, and this<br>
seems to be worse not better.<br>
<br>
There are conflicting use cases here:<br>
&nbsp; 1. The original DPDK goal was to make effective use of multiple core=
s<br>
&nbsp;&nbsp;&nbsp;&nbsp; with no locking. Intel customers often had idle lc=
ore's and some CPU's<br>
&nbsp;&nbsp;&nbsp;&nbsp; had lots of inactive lcores that could be used to =
get more work done.<br>
&nbsp;&nbsp;&nbsp;&nbsp; Dedicating some to service tasks etc was a natural=
 outcome.<br>
<br>
&nbsp; 2. DPDK applications (OVS, Grout, VPP) usually want to know about lc=
ores<br>
&nbsp;&nbsp;&nbsp;&nbsp; at least in the documentation and examples. They d=
on't cover the case<br>
&nbsp;&nbsp;&nbsp;&nbsp; of service lcores.<br>
<br>
&nbsp; 3. Dedicated low core count smart NIC's using DPDK. In this case it<=
br>
&nbsp;&nbsp;&nbsp;&nbsp; makes sense to be frugal with lcores since the poi=
nt of the smart NIC<br>
&nbsp;&nbsp;&nbsp;&nbsp; is to be able to run other control services. For e=
xample, the MS<br>
&nbsp;&nbsp;&nbsp;&nbsp; NIC had hard limit on the DPDK part (via cgroups) =
of only 4 + main<br>
&nbsp;&nbsp;&nbsp;&nbsp; lcores.<br>
<br>
Granted NTNIC is likely only being used for a specific application on<br>
a specific set of hardware.<br>
<br>
The ideal would be to have better control event management in EAL.<br>
Something like &quot;libevent&quot; style API. This would reduce control co=
re<br>
needs, and avoid any potential resource conflict overlap between control<br=
>
threads.&nbsp;</div>
<div style=3D"font-size: 11pt;" class=3D"elementToProof"><br>
</div>
<p style=3D"text-align: left; text-indent: 0px; background-color: rgb(255, =
255, 255); margin: 0cm 0cm 12pt;" class=3D"elementToProof">
<span style=3D"font-family: Aptos, sans-serif; font-size: 11pt; color: blac=
k;">Hi Stephen!</span></p>
<div style=3D"background-color: rgb(255, 255, 255); margin: 12pt 0px;" clas=
s=3D"elementToProof">
<p style=3D"text-align: left; text-indent: 0px; margin: 0cm; font-family: A=
ptos, sans-serif; font-size: 12pt;" class=3D"elementToProof">
<span style=3D"font-size: 11pt; color: black;">Thanks for the detailed feed=
back.</span></p>
</div>
<div style=3D"background-color: rgb(255, 255, 255); margin: 12pt 0px;" clas=
s=3D"elementToProof">
<p style=3D"text-align: left; text-indent: 0px; margin: 0cm; font-family: A=
ptos, sans-serif; font-size: 12pt;" class=3D"elementToProof">
<span style=3D"font-size: 11pt; color: black;">The migration of the rte_ser=
vice actually improves the performance of the ntnic. That is an obvious res=
ult, since we dedicate the entire core to a single service when the default=
 (1-to-1) mapping is used.&nbsp;<br>
A similar performance and stability can be achieved by using threads and mu=
texes (The rte_spinlocks introduce instability when used with threads)</spa=
n></p>
</div>
<div style=3D"background-color: rgb(255, 255, 255); margin: 12pt 0px;" clas=
s=3D"elementToProof">
<p style=3D"text-align: left; text-indent: 0px; margin: 0cm; font-family: A=
ptos, sans-serif; font-size: 12pt;" class=3D"elementToProof">
<span style=3D"font-size: 11pt; color: black;">The ntnic service API provid=
ed with this patch series enables users to map NTNIC services to lcores as =
necessary.</span></p>
<p style=3D"text-align: left; text-indent: 0px; margin: 0cm; font-family: A=
ptos, sans-serif; font-size: 12pt;" class=3D"elementToProof">
<span style=3D"font-size: 11pt; color: black;">All NTNIC services can be ma=
pped to separate lcores or to a single lcore; however, this approach has a =
significant impact on performance.&nbsp;</span></p>
<p style=3D"text-align: left; text-indent: 0px; margin: 0cm; font-family: A=
ptos, sans-serif; font-size: 12pt;" class=3D"elementToProof">
<span style=3D"font-size: 11pt; color: black;">The mapping of all services =
to a single lcore is similar to a &quot;libevent&quot; style API. However, =
there are no events; instead, there are continuous calling services in a pr=
edefined order.&nbsp;</span></p>
<p style=3D"text-align: left; text-indent: 0px; margin: 0cm; font-family: A=
ptos, sans-serif; font-size: 12pt;" class=3D"elementToProof">
<span style=3D"font-size: 11pt; color: black;">The one core cannot process =
all the services due to a negative performance impact. Following this appro=
ach, we have to spawn a thread (or start the service by looking for a free =
lcore) every time an event occurs.
 If you have any other vision about it, please share your opinion.</span></=
p>
</div>
<div style=3D"background-color: rgb(255, 255, 255); margin: 12pt 0px;" clas=
s=3D"elementToProof">
<p style=3D"text-align: left; text-indent: 0px; margin: 0cm; font-family: A=
ptos, sans-serif; font-size: 12pt;" class=3D"elementToProof">
<span style=3D"font-size: 11pt; color: black;">In the scope of complex DPDK=
-based applications&nbsp; (OVS, Grout, VPP), we still have options to use (=
1-to-1) mapping by passing raw EAL options -(s SERVICE COREMASK or -S SERVI=
CE CORELIST).</span></p>
</div>
<div style=3D"background-color: rgb(255, 255, 255); margin: 12pt 0px;" clas=
s=3D"elementToProof">
</div>
<div style=3D"background-color: rgb(255, 255, 255); margin: 12pt 0px;" clas=
s=3D"elementToProof">
<p style=3D"text-align: left; text-indent: 0px; margin: 0cm; font-family: A=
ptos, sans-serif; font-size: 12pt;" class=3D"elementToProof">
<span style=3D"font-size: 11pt; color: black;">Thanks,&nbsp;<br>
Serhii</span></p>
</div>
<div style=3D"font-size: 11pt;" class=3D"elementToProof"><br>
</div>
<div style=3D"font-size: 11pt;" class=3D"elementToProof"><br>
</div>
<div style=3D"font-size: 11pt;" class=3D"elementToProof"><br>
</div>
<div style=3D"font-size: 11pt;" class=3D"elementToProof"><br>
</div>
<div style=3D"font-size: 11pt;" class=3D"elementToProof"><br>
</div>
</body>
</html>

--_000_VE1P190MB0830BD7C560B3369EE83CE14800EAVE1P190MB0830EURP_--
