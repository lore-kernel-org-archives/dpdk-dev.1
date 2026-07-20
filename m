Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97672C4451B
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Jul 2026 05:42:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 90CF440294;
	Mon, 20 Jul 2026 07:42:48 +0200 (CEST)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011006.outbound.protection.outlook.com [40.107.208.6])
 by mails.dpdk.org (Postfix) with ESMTP id 6C0404028C;
 Mon, 20 Jul 2026 07:42:46 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=foQtXHqFleibRSRsydaIL9tlHLfxDmhCmHOq4x2bAy5ZEoC/7ZUgwkKPh4ENcuzxhO/GhuMm3ShDuR65rIw2r57rrp/LXskdwCzsIpE37OKTGS3p/83k0uevrqjWFjh/4TeoVzsFK2OsG1fVCJqXpFuMSaOUVIyhh98l7qvSzkaLcckmC6uRa1yC81mjcon/RBc/9ZUERSqidiGSUvY4ida0U0SABCFcDk5Bz6/UjM4u0WGsI+EFdFRNTDCnWZLVKHMqMAxRIZ+WGusCywe2UTen93SU1vmmKNedu4Hj8fgckuaOWw1ynVmEV8XkyCCB0P2494wv++oZDJX/O+dtew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6dxAeEmk6+A5kYPpP2p9bAFKR8u9B2QPClStXKiaB5s=;
 b=lI07hbslZ88VdfX/sP3ezXUf++4LpIB/iOdPutTV2lZbD0JhojyqxOsHuuZ8YPvTd+1SB2GNKjYD86R9jq3P+t0tevQVnWJ/sQaq/G3nFD3US1tkvXE0kFYTyca/4YUzZdfU8iapwKClneoBpXViJrejDMc18vyi3udedmvDHq+sIwHpUjSdQkvkqUB0lDfl8CuJhyh2D4gLYqApym7EDE4RqwDtMkOshmMTpr7ASr7nfkw90Ud7o6Rqok9G9G58XBpKctspzs33oW6CsuFD9rpHZ4PJnv7+mWALOQjE+zUHTYZVjqP6o7XSFDc1LVPYr85exxCCMShKHHSwRacXMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6dxAeEmk6+A5kYPpP2p9bAFKR8u9B2QPClStXKiaB5s=;
 b=cFUZGXoGoDWt/mKndr20aIl0f8muNxyy9UHM3BuYhDGdjBwrdiLF8fRajgRUNDS1VDtPm+jTt7z++Mpsd1EScJq/pQnrdsq020BkjRdrW2b/4sxn4cHIvKbhsod6bJOUloyCketUpXK6KDTSR61eFbw03IW2/qyOlKD38+Gb504ZiKhsd8PSi61CQaGjok1FzSJnvn2RiSpePbUCY2Nqk9B6VhYngGER14/LiLARfd2FFUIN7gtZluoepyWK8Dwvivr75c4parJliTPFKR2HxEKXZu0YxPoOhvMtk9C/w9fbipbJ45+5Po4fBuZ88ZH1T+cmPX2Eaf/+71ZXPW+MDg==
Received: from PH8PR12MB7350.namprd12.prod.outlook.com (2603:10b6:510:216::12)
 by SA0PR12MB4462.namprd12.prod.outlook.com (2603:10b6:806:95::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Mon, 20 Jul
 2026 05:42:42 +0000
Received: from PH8PR12MB7350.namprd12.prod.outlook.com
 ([fe80::b652:ea8b:24c0:e5cb]) by PH8PR12MB7350.namprd12.prod.outlook.com
 ([fe80::b652:ea8b:24c0:e5cb%3]) with mapi id 15.21.0223.015; Mon, 20 Jul 2026
 05:42:42 +0000
From: Suanming Mou <suanmingm@nvidia.com>
To: Gavin Hu <gahu@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Wei Yan <yanwei.wy@bytedance.com>, "stable@dpdk.org" <stable@dpdk.org>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>, Slava Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Matan Azrad <matan@nvidia.com>, Ophir Munk
 <ophirmu@nvidia.com>, Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
Subject: RE: [PATCH v2] net/mlx5: avoid wildcard drop flow in priority
 discovery
Thread-Topic: [PATCH v2] net/mlx5: avoid wildcard drop flow in priority
 discovery
Thread-Index: AQHdE1c3vCV8S4LQgEG3KFI3D/3CAbZ17joQ
Date: Mon, 20 Jul 2026 05:42:42 +0000
Message-ID: <PH8PR12MB7350DA754F6F0620A4106A03C1C32@PH8PR12MB7350.namprd12.prod.outlook.com>
References: <20260713041856.67144-1-gahu@nvidia.com>
 <20260714060751.44814-1-gahu@nvidia.com>
In-Reply-To: <20260714060751.44814-1-gahu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR12MB7350:EE_|SA0PR12MB4462:EE_
x-ms-office365-filtering-correlation-id: bb95978b-60c1-42ce-e2cc-08dee621b800
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|38070700021|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 5cKr3V/vPMFiWME5282jaY6doXNElwgnV20rJJlPF9KibSONpCAGiexcn3udBtzcpFg7diLQYcy4XXnwqhEp8jlGAXIjvuTNuJG8SA4t+W1y14GqcNXAV8LzRjQXk6TjZk6MC3nKwHSyKB1gRqX/L8ArB1T3vK7gziwRuTRhtyEDoAPdLHFXofcMB7WwmQPC2GYxXpatEOFulooaHaYt/84xuTBkzpwljMCvldpTXuWngBVFR3KLo4YLhWhrWvcGn3YqtDuuXXAuAD6KO7j/Y3f47s/KKZveQUhnU+5sF2pZbPZQQuljm4BnZAkKY6GJ9OqISDk1sIH4MlmDLl3YYDwl0QgdqpDx/zSSUsMNQn1RYt95rMs47ib2JLQtNzWlkcdKIxjr/5MRWgv/OCZb31FOMiZ0YW/gOoMYD3UER3ZieDr6zdT6oz6lHtKRJ1N22NlpXgMf1S7pdnI4frEJkqwVhY3eu4DhMJhn2i36UVfPmmy0d5FwIp1950l9s6WKIjcAVAhK9NR1ITrp/ModgqoXsmEqFI/wj/f9IJ8x8or69fKtUx4M3Wbg8VSCwGydSQhLBd5PqQ6FhjhJ5HWkRe9MOq8dfAImKix+LYMQfbnFu6/e9NlWmeSrNiVzmT7wtYNSbe4V+KZmYJJeO3Ac5vl5TMqJh+O2G//QlQjMJtwY5cEfKxWZe2wgX0AieF9oJedOswKsm919aVYJP+OIyAqMUeiC4ZF558SNpm0tstI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB7350.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(38070700021)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MhoJg1Um/61G/gpFc8fhb/oHJtnp/TsSGVG4JNYmK45wB272giWks31inmfp?=
 =?us-ascii?Q?yDod9zGcJT4xSCXlLjTkK2U/ZmxI6TRFHhioVeyyJX8YC8KtAAZtFgS/Hb/5?=
 =?us-ascii?Q?wUcliSF2o8FtHRTRNBESiHUDOSNGFqKMlDgRqm2kGGdEJgSjFmGsfOrAgzxX?=
 =?us-ascii?Q?5FZrh/fgSfwYY1z2qqe+FN8mfm2uY0rWTUdgRDjuD0Vnss2mUpeB7MGcO6MK?=
 =?us-ascii?Q?a0XEvu15uqlDlXwxqac6zJ5iF7HqKugoW1FzQ2+euaJEBSggkBZi8QcRCY1S?=
 =?us-ascii?Q?z4xz5z+WV7Lxb8kx5bR0DPfbl8BiBWepfkcJf2VvOMgCtHHqWdkK/4DiJOyS?=
 =?us-ascii?Q?HEhKI7Po5uXqBFfBMbI9wQO/N9WShQ1gfwE5HpkaiTnf2Jon0JJpBQdLF9kc?=
 =?us-ascii?Q?yldKvrUcqRd5MPnncm6198h/4WBsY/pDQdg5IXQM+zRAak+zP7U4PP4AqkmA?=
 =?us-ascii?Q?b5AgFwX6pOK9cjJohyaaSAnjP6dQ0fcNw6hjIUW950qOF9X5nrAIMCAerUO3?=
 =?us-ascii?Q?qxvCUx7IPrmToBo81nmHQoO2pT4SFOm3rzkkfY2tBDy0AEWN5Ajfso8qEMbe?=
 =?us-ascii?Q?MQcpM/LOAHIjLGMHXIvI5pjtiV5sEhXh8DQrc81oTJ+M2rdftB0KhrqgKAvU?=
 =?us-ascii?Q?kpOdJ4k05QVV4BMvAwG1U67vsoXxWs8LHKDkxktFAEQc8gKcE0N2/lllAmsX?=
 =?us-ascii?Q?98YSWY86S8bgmWd0ZLAXxYTHOS3J5HrJdZ+RBjvssNkHxAQ8fXJWegJWVoAa?=
 =?us-ascii?Q?mxwMSO0eRjhiPYM2r+ZGatUS6ebZVCPI2OXjRAUWiZhPiYc7TnYhWu/3blpi?=
 =?us-ascii?Q?ad610NQoHsI26OtdrbohXBwQ4a2YcifEdu46CfiugHHKn4d7o64MydUkvDUT?=
 =?us-ascii?Q?7QnyihxKEGZOOTFP0Cv3K+TfsR8cArPb6340r7sLHGElwPFZD2Kcn3P4sQaz?=
 =?us-ascii?Q?XkDqkj54X20+07EI6hUbRA1o/2VVMcV33PpUSGhFPjowPqVXqz53VaMDvDju?=
 =?us-ascii?Q?nCViYJbGucH70kh+c7fOxhGU6LQOxeTOVKeZn7iVnhv7okYuKhcHVZJc4uSq?=
 =?us-ascii?Q?ejOvx2w9hZqXBsUG2pha7SrzU7v2qcJjS1reZ8MP/VD4uMQQOYruSoBBIzq3?=
 =?us-ascii?Q?RY77D7ZO4QFlJWthWlv2Yggt5IflOgxfcr+cQByqScY3ihjSgtghIQN72mZF?=
 =?us-ascii?Q?KERmJWof1XGJ+q32JMAM/OgsvYZsHtogYa/XgmzYFct3cj+WEc85OZH0vtJy?=
 =?us-ascii?Q?grcecMrHfRgYPFyNeLFP0+jF0V0+VTN7FA9bo8Ap0gmysj7EBph4f66LoJwa?=
 =?us-ascii?Q?qKwMQC9bGXxixsLhgQBgw5TCemjR/6SbTt4Y2MunSrncNWLSv6zruqJ9gSyz?=
 =?us-ascii?Q?QZfJqhpcrno7eAGTcAfieQIDExGwIbb0CvzoRk5gqk2JDNa9M1JBvWVrffTu?=
 =?us-ascii?Q?KQzbKmkUsUIVEm+0e+a6Jw13mOUEvNNHPciTv934fvctjhS3Swb/DxgY8oyk?=
 =?us-ascii?Q?sAr+L/qcnPNPlP77FEO7R4TDV8lJ69AY4uUGcBcDu+jhpwTY22LEMgY4nMWP?=
 =?us-ascii?Q?WoXtb2pRBmMVCiUWOv0IVY4aloAdp6o1hKkekGiYWHo4a3/d4OAsK+EeV6vT?=
 =?us-ascii?Q?xPaLvbCvszgnD9wUgkefEd2gZO30gfs71bxHXhH+hJ69FjLJJ53a0fYBIqp/?=
 =?us-ascii?Q?B9M5M546SR0wfg1x0KJ3LFqAeoT76dGvsFWv9XK1nnXLEbPzz/JmX/ZCFXzw?=
 =?us-ascii?Q?3lEwP9tY2w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7350.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb95978b-60c1-42ce-e2cc-08dee621b800
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2026 05:42:42.7950 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ipXvOgQFvDUFBb1ZCtyNlxR1gxzSWa5YVqdK02yQMKV2H2Kin0aOq5gfJbF6xpIYsOARDDp3ypZG85eSlPQ14g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4462
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
> From: Gavin Hu <gahu@nvidia.com>
> Sent: Tuesday, July 14, 2026 2:08 PM
> To: dev@dpdk.org
> Cc: Wei Yan <yanwei.wy@bytedance.com>; stable@dpdk.org; Dariusz
> Sosnowski <dsosnowski@nvidia.com>; Slava Ovsiienko
> <viacheslavo@nvidia.com>; Bing Zhao <bingz@nvidia.com>; Ori Kam
> <orika@nvidia.com>; Suanming Mou <suanmingm@nvidia.com>; Matan
> Azrad <matan@nvidia.com>; Ophir Munk <ophirmu@nvidia.com>; Dmitry
> Kozlyuk <dmitry.kozliuk@gmail.com>
> Subject: [PATCH v2] net/mlx5: avoid wildcard drop flow in priority discov=
ery
>=20
> From: Wei Yan <yanwei.wy@bytedance.com>
>=20
> Priority discovery installs temporary drop flows to probe supported flow
> priorities. These flows match a wildcard Ethernet pattern, so they can al=
so
> match real traffic while discovery is running. On shared devices this may
> temporarily drop kernel traffic and cause TCP connection timeouts.
>=20
> Constrain the probe flows to match both source and destination MAC
> addresses as ff:ff:ff:ff:ff:ff. This keeps the rule valid for discovery w=
hile
> avoiding matches on normal Ethernet traffic.
>=20
> Fixes: 3eca5f8a610e ("net/mlx5: move flow priority discovery to Verbs fil=
e")
> Fixes: c5042f93a425 ("net/mlx5: discover max flow priority using DevX")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Wei Yan <yanwei.wy@bytedance.com>
> Signed-off-by: Gavin Hu <gahu@nvidia.com>
Acked-by: Suanming Mou <suanmingm@nvidia.com>

Thanks
