Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE6A0C28B2E
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Mar 2025 07:42:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3150340613;
	Tue, 11 Mar 2025 08:42:59 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
 by mails.dpdk.org (Postfix) with ESMTP id ACA2E40261;
 Tue, 11 Mar 2025 08:42:57 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ebSjYh6/V4gK6JH9YoCSk/VZ/KfNIhRuZBTYjK7MFtF13EZxfAFbM9CGe9HEKv90LS4j2+kEoPBBPt0IDjPh3fny9AqvIvWjLxsMAJejTQJgpEeU9Dp4LoLxO2e0sX2yau0CKKIFogsJ1bxd3kYNosSSYIbrSyduJLjjyXZweu6X2dDnwWN96D8pZhFZqZfwwMOpfTI6sO6iTN5bsof8vb3xfgl6DPvebv6xjIvgZnLRnMeUG+9AsLdTBt0QK9ypaL/NuDMpUsUFDsnJU6Rs7t1jJkIQJoklJYhKIxPKQfARJ4N9ykzndXwwfXw70DAnBYJ5iDM9xqOsfsttTuNlLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c2EZNt960eachBaoJeJY5ueKuq/gpas7JHkrKzK8qYA=;
 b=lPvruKmQdDCVhH1n7QE4HLPv5Ht7xEGIQBf1lUedK3D6w839xz57HfZRd3zUKxKY8j5rWxdXpWEhCJO2NHQ9eta1QlhYgbyntnO15WVU3w9G8LBhc1RxQqSaLgKlOxR9OenTuOgBBg2uoyXLuHH/Qw+L1UqzwhxDnsoN3K4k5VymHsJ02HhwwvarnZxXUuFel39fgYIdAp/PY6pkTalaEsqzCQAFNH4hxspmX7K7+Tg1qwWEuzTg4Obu7mYq/cVr2Aef1UGA7LSihjwOZukp8CMiV1n/vyZ9bahJwhnaWSDY6s4+o9kEai82HK1oB/NntTti8U9S2lU1+jzAXShvaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c2EZNt960eachBaoJeJY5ueKuq/gpas7JHkrKzK8qYA=;
 b=aPVXlo3ymm67ZqPvSrJpEuWcHzwtrK5r4xm2EVnhd+qquXiQsTW5ktZe9+2fYAMy2IrCnH+D54Ok5hURmyp/qUMWwfbBC2BJSxDNtSHyWNIxWh80FAS+wDwUflkEhHUzF4wKShg2iur6CE9yKB3SMzAAi1adAUjTOLcavg0YznXEtDKJ91kV+XO5XIq90yJCaCLlKBPwML7PFw1ayZ08SMbuJdedOVQU4HUGjQMENMlILqw3ZRODUCoIhDC7Yq/aBUMYlpyCisU2yuAI4+bKu+wKRTOrQnkg3phhW6H+uStC8tpROs78+e5zagn8vATJzhlmNEoupYq0h1cELxCubQ==
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by PH7PR12MB7456.namprd12.prod.outlook.com (2603:10b6:510:20f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 07:42:55 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%7]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 07:42:55 +0000
From: Raslan Darawsheh <rasland@nvidia.com>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>, Slava Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Erez Shitrit <erezsh@nvidia.com>, Alex Vesker
 <valex@nvidia.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
Subject: Re: [PATCH] net/mlx5/hws: fix incorrect DV FT type convert
Thread-Topic: [PATCH] net/mlx5/hws: fix incorrect DV FT type convert
Thread-Index: AQHbjdH1QXNTCKoYp0yG4AE68RvApbNtlp7w
Date: Tue, 11 Mar 2025 07:42:55 +0000
Message-ID: <CH3PR12MB8460B8B9F7D57B23B64B5DF6CFD12@CH3PR12MB8460.namprd12.prod.outlook.com>
References: <20250305132353.46724-1-dsosnowski@nvidia.com>
In-Reply-To: <20250305132353.46724-1-dsosnowski@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8460:EE_|PH7PR12MB7456:EE_
x-ms-office365-filtering-correlation-id: 1e02ff8f-9160-41fe-499f-08dd60705600
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?6fRKpezryahcB22ANqOESjlgsC2h/9YG3p5omJ5qNbRs3VkGD4Yu0x2O1c?=
 =?iso-8859-1?Q?3a8zI/oboeZLnu9VY9jF9BNOaODFo+af+iAkuteSxGHnI+FkSTAc9UP+zA?=
 =?iso-8859-1?Q?1wXcNHpkDX85F+ZgyzS/wcGOVt91fVKJvHR8r3qPkst6KU2Rzpa9Q90RYO?=
 =?iso-8859-1?Q?sz1C5rYGuoCINhGBtdjzdL42dIqgacVwZ6Q4CXqebBqwhM0BjfJogjgOKq?=
 =?iso-8859-1?Q?hCv496LaG5SQNTSmmJ8SB3vIQppXuJ3EGTUZq/VOXzVk9fNzN97WwbDr1g?=
 =?iso-8859-1?Q?2Sck9zcgZm9qa7P2/gi2x9G8Hx5YOR7CE+nbRMCmYS2Z2RGRuUCyO4Mtcq?=
 =?iso-8859-1?Q?P1qglJwMwc/6KldIP2+Atafh6fmODa4JLNgpkiRwhXp4ky+HQkW7LWr8jo?=
 =?iso-8859-1?Q?AtJQ0fzLFV4tOFZGAGEaQyKuzZQKFAXd7XOFGnY8sgOM3us+ctXXWDtSaD?=
 =?iso-8859-1?Q?3fii1zQ/i2tOTWc3oDRqWy+3p1RQhzOqu4HX7hW1STjKlab6ZQ4xSIF4G8?=
 =?iso-8859-1?Q?4hcAM7lDuqGK/felbvqM3rAleryq1aWEgdwXhAkt1Sn4+o+FwzeZd8OLJy?=
 =?iso-8859-1?Q?z+3P+Ul9HiqVv/Q36jMr00N1ojZ1yAKEHZPKIfvU3koU6K9uJQjUsIgpIh?=
 =?iso-8859-1?Q?88ok9AL1dka10yZc4U0Q0ShNt46LBaP7e+HcXVWv52DwhYWrFu3lcrSVL0?=
 =?iso-8859-1?Q?K5O85pAPt1sNvdOVYOhuK7TiEKuf6Szwk90KjCcY/EDrTR6VRLZ7TFdvVu?=
 =?iso-8859-1?Q?VzllnK6pp5CgU3AVuB/jOEeNSfsvzsO3eax1uydyhRpN0A5mMoHRDO3oJd?=
 =?iso-8859-1?Q?qUPL1KSSgsA9L/PJGutsJsbU0uBJ9WHdIsM3zgui6OqXCPeR0deCC6NinB?=
 =?iso-8859-1?Q?Z4ryxdbHWWhkZU57alIkendJ0+hG44wskDv91OEBwnLpvSix3fiocw2ATC?=
 =?iso-8859-1?Q?cDLeKuwDCaInVRP6m4+7iAqqzcj/Go3BUuMwVRHsXmynwo0XAvLHKqBJ/V?=
 =?iso-8859-1?Q?B8Hr/v0LOcBNN3QyDHYgX4FCZeSKiwjy9BVUmKv0MFmhsTz/pE6bfYjEnx?=
 =?iso-8859-1?Q?LfM/21aBea82Bax1dhhgbk80u+lV1+JUM2Brd67+atg1TEqp6zWiqs+gag?=
 =?iso-8859-1?Q?5Lp+KzhMo2Es6VTJwiKlsnDatcUFwk4SoH/wnFp5sq+Ma8HkkCj63VuT77?=
 =?iso-8859-1?Q?jQ4O/f8CA1i+SY2sUv+l4GtEs8+qI+HHKezLDLn7ng/UjDUE29Yn/Wdfo0?=
 =?iso-8859-1?Q?fa1oiV6VmQEW98MOITEMhb+3oLsSnKiRdfiCD26OtkBVp7wXVeCYTcWoEM?=
 =?iso-8859-1?Q?KHU4aq5O5oLrJtO8LgtPb5RkJ/pafWtYIGovsRI2bgs9qrmTkqPa7ehqf/?=
 =?iso-8859-1?Q?UTJo/4deVBiZN+djKICmBsow8wHmtpxoWewuXMTVYC7VHpwQq/RiPyj1wc?=
 =?iso-8859-1?Q?XpXep5gui9JIDObdd5bBGcwuxdjf40aShFwpxOUxJ1t+pzrJY81Wln++Vw?=
 =?iso-8859-1?Q?MGnGdUdNIx8gxYxBzZurxh?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Xp6CZZj1MouUItTSy2fgZB1v7A9Y2PXi4qTILrBys7hjBpxqj7SP5lXktN?=
 =?iso-8859-1?Q?HLPm4A5zcZOmhPnTD7bqGm/drTDF4MJzkuv0AGWo8ITx70BcpSivg6i5Bn?=
 =?iso-8859-1?Q?RMBTagnbhTSV5VTQ0rzkIumvte5s/chvxD1sefuntGZ0utcWU3QjwpQbx3?=
 =?iso-8859-1?Q?q5CRa2skscNjX6PvOyaBjbjxLFX3QZtxmGZ9fm46prXIf0FMnSkFFAcu9r?=
 =?iso-8859-1?Q?fKsgGpuH1LDWmUj8o+JQtK/8oCC7LllnIgNNE1AXlzuxUbbAh4aYBfue4W?=
 =?iso-8859-1?Q?iz9+/Z4uFSRmGrmcB5J2XZFoUkZqlVwhTrX3kA+fn32ULNdX5gQ1e+I42c?=
 =?iso-8859-1?Q?pf5wg2ZGbjz0WMHJfBm6G2H1TqEyzjbY2/w6x9d7UL/gEf/6MFAZ/3BsC8?=
 =?iso-8859-1?Q?NQntVl8DdoXxIpVohA4UR1mHfFmqXGhKs5De0/Oh/duM/YFpOFxAY4yyaL?=
 =?iso-8859-1?Q?zuABOX+eztfZbuiPn3XoEjjAHhtYz0yW9f/UHvAM6Q/RYH0FTWXSNibqGT?=
 =?iso-8859-1?Q?yPgJLISaEL4G7HjadMFJIdagZvgbyrKLhUStyhZOAHJuG9heY44ZGy5RtH?=
 =?iso-8859-1?Q?J8N17nFs6fJxpoPkYtcCCNvYx4n7+ndDQCblxQB7Jo5RoZQvwwF7fsC/vX?=
 =?iso-8859-1?Q?gpi87yglesZAsucMfECgLXhMO+u9vRIE6B0BbbBbPkCJ7vh7rF0dH0Nz7B?=
 =?iso-8859-1?Q?Rw/3UtqMkxpYw2h5E0Jxwj/jpJWga0R/9FgXqEzjAg5hwPp/i2RBYyEBNn?=
 =?iso-8859-1?Q?0nQlh1d3CIiOHI6iO90yvGbTKulCTMcxmI0UXNLfxw76HsKAFXTX6qGKch?=
 =?iso-8859-1?Q?hnSjZqaKdBlQoRBor48ZnNbJEjR7bszUTFgdsaO+jFAC64Q2iFdZ0ar34b?=
 =?iso-8859-1?Q?cfmyag/qtp6nmPnnDy1Oy9fFn90f/4o9N/L4QLu4wqUawhvXiczAHY848w?=
 =?iso-8859-1?Q?voHM1NL7tdZao6H2PbYyLx87j2qSCTbboU1iKaiH8pwVlI4c6iRhulYojd?=
 =?iso-8859-1?Q?jhiWLUNKbRPgZiRjsCAvu178qMy4Gmq3lCzUrqqYcC1tAk7JXe5zMYDhVy?=
 =?iso-8859-1?Q?T03wHpaAkQn72XJfvUe+g+kEMkbGt3IIdgo2cPKZ0yhQmS50NAQsBpds4D?=
 =?iso-8859-1?Q?BWV0NrKVICunamMw5ToTvqi1dRhK2Df54Ca4H1IAvEz09+oKxvKmW8HQQW?=
 =?iso-8859-1?Q?+ovaF1IgVWV+qhcTowyjZaibEEJbJgVGcWObXQd+juSfN4wqv/SDDazMFx?=
 =?iso-8859-1?Q?17pDANOHmuOpd4HPQvhBy5K3cWrHvPDQQTQ0UYPwAr52doCV1wbUyT2o7q?=
 =?iso-8859-1?Q?+lo8mJ3OsRZkCoAG5D/Bc1+0l8pHOBrhgrC5x0ZwVaThHeNrstIIFfnq2C?=
 =?iso-8859-1?Q?NX/m1eHYyikq4UHpwp3h8wsXOqaP3z3x6fnykmnZKJYXTGwhI6LBVjdn/5?=
 =?iso-8859-1?Q?zH58nQ3pTHcDRye6NEykz3ysZ+WgnA27w23ULSpHjOmiG4he1i7mGJjg3S?=
 =?iso-8859-1?Q?6IIN07nBM74Ri+6MyTdHvkdVtLNEhyq0uKDxOpdc/z0Neza21aTX5d7cWA?=
 =?iso-8859-1?Q?2D51ai5irrYrjp1kcFZWg8Y3Lj/e+WJHFTFqgsYb/eHRNUvtNYWn1JsutO?=
 =?iso-8859-1?Q?6zNvgFuUwZx3OI12ZVctOBoU3rkic5/zHJ?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e02ff8f-9160-41fe-499f-08dd60705600
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2025 07:42:55.1786 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cxXvVlXVMbi5dflZ8beFbw39i+hu4QTr+X0olIYI1TggkS1Y/TDr5VciR3ltfOM3fEfU1sZSfN/ihMWF/WAP6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7456
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

Hi,=0A=
=0A=
From: Dariusz Sosnowski <dsosnowski@nvidia.com>=0A=
Sent: Wednesday, March 5, 2025 3:23 PM=0A=
To: Slava Ovsiienko; Bing Zhao; Ori Kam; Suanming Mou; Matan Azrad; Erez Sh=
itrit; Alex Vesker=0A=
Cc: dev@dpdk.org; stable@dpdk.org=0A=
Subject: [PATCH] net/mlx5/hws: fix incorrect DV FT type convert=0A=
=0A=
From: Alex Vesker <valex@nvidia.com>=0A=
=0A=
When creating a root modify/reformat action it is created=0A=
for a single specific table type, current code ignored this and=0A=
used the first ft_type found in if, else.=0A=
Also added missing translation for non-root FDB action root dest.=0A=
=0A=
Fixes: f8c8a6d8440d ("net/mlx5/hws: add action object")=0A=
Cc: stable@dpdk.org=0A=
=0A=
Signed-off-by: Alex Vesker <valex@nvidia.com>=0A=
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>=0A=
=0A=
Patch applied to next-net-mlx,=0A=
=0A=
Kindest regards,=0A=
Raslan Darawsheh=0A=
