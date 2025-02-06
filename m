Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D792C02196
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 14:21:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 31607402F1;
	Thu,  6 Feb 2025 15:21:21 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 073354029A
 for <dev@dpdk.org>; Thu,  6 Feb 2025 15:21:18 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 516E3SqF014866;
 Thu, 6 Feb 2025 06:21:18 -0800
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2048.outbound.protection.outlook.com [104.47.58.48])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44mxgt0163-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Feb 2025 06:21:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bT1Dm1fmUCobCzpuBWA4nRSCb4e7qlfp4aGVa0toSmSwN5MnGWsYlNvOYjNKILaV0uHirQsu96CiTS/7WT14zNkCgbE9bRwlF45c+DPkAJFlvvhyc0sCf7HsoItAkLeV2LdVk20jzOd4fF5qDeFKQRd2sZIqi8/pUaWxngxz5rVKh71siazMGhT9oA9rSufYSd1SeOrwvHfTI2XVSmiUBBvznPzs6f5yr3Is/3+kLUtbcQzuNlOWKiHW+b4IhzwGAYVnkcpjUue34FnAcTwv15pK1/26SjQW06oB6vo6MKs7y7rd37NLuswmgjUkpolyujPFNLYE5NZ0RprEkgUSXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ULBJ51j0fZjDz2xrKxKDDirKe7RMgf30Tb2pJOr6doM=;
 b=GrMlEhqut2sxW+3JzrbMTEnJTe/oaf838e7e9ASl1xYlTCWuR08oixmUjW9M4nL4+gwegd11UKUBdur/ZTHh9lX/bheyRCEFu+eNuuqfYBTHU1dn7noY6LiSBxOYpDkdXJ6cnAwki/DW8jrZ/qfHyCHxl9rx6kXe6S6/3v2jFZGjKdXTZoHEnXfHHZQBpUTr15cP1SH2bgCIsGC7MwaqJ5bCc6z0+cfcgzxJ823aLjM4GkRYBIN2cYD5ibPLmGH8m06EBAWQgNqWD4x2dnMvxW0nT9bneSrKSlnvL++voPd+rh3Mrt1Z6UHZioai01NUVWNsm6gHnlgbGWTVE6ccsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULBJ51j0fZjDz2xrKxKDDirKe7RMgf30Tb2pJOr6doM=;
 b=CutWh7P+JNsorMs7bfIBCxEcZ+in7F0j/Hzeql+U401EoMj791fQBZ69uGBabT309C5xVdLgoHN4Gw1PcZGkDKzksXXdt7+FGzQQ5gRKr9ouDJxt6se47MdxoL63f6qpST+hyQHWv/HnhsRT/EwKPIHMJc9l0sh9btAwS0hdvc4=
Received: from BY3PR18MB4705.namprd18.prod.outlook.com (2603:10b6:a03:3c8::12)
 by DS1PR18MB6361.namprd18.prod.outlook.com (2603:10b6:8:213::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Thu, 6 Feb
 2025 14:21:14 +0000
Received: from BY3PR18MB4705.namprd18.prod.outlook.com
 ([fe80::1a4d:d74:bbd0:57fe]) by BY3PR18MB4705.namprd18.prod.outlook.com
 ([fe80::1a4d:d74:bbd0:57fe%5]) with mapi id 15.20.8422.010; Thu, 6 Feb 2025
 14:21:13 +0000
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>, "dev@dpdk.org"
 <dev@dpdk.org>, Akhil Goyal <gakhil@marvell.com>, Chenbo Xia
 <chenbox@nvidia.com>, Fan Zhang <fanzhang.oss@gmail.com>, Jay Zhou
 <jianjay.zhou@huawei.com>
CC: Jerin Jacob <jerinj@marvell.com>, Anoob Joseph <anoobj@marvell.com>, David
 Marchand <david.marchand@redhat.com>
Subject: RE: [EXTERNAL] Re: [v2 1/4] common/virtio: move vDPA to common
 directory
Thread-Topic: [EXTERNAL] Re: [v2 1/4] common/virtio: move vDPA to common
 directory
Thread-Index: AQHbYTQwEclQZ9eVpEa1meRbjAwagrM6NAgAgABMsrA=
Date: Thu, 6 Feb 2025 14:21:13 +0000
Message-ID: <BY3PR18MB47051AE835EB593EF33098CCCBF62@BY3PR18MB4705.namprd18.prod.outlook.com>
References: <cover.1736270269.git.gmuthukrishn@marvell.com>
 <0951d143cd811aa8389a0c1eaf2cd70fe315f3f4.1736270269.git.gmuthukrishn@marvell.com>
 <4a529276-2d23-4486-873b-ecba155b78f6@redhat.com>
In-Reply-To: <4a529276-2d23-4486-873b-ecba155b78f6@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4705:EE_|DS1PR18MB6361:EE_
x-ms-office365-filtering-correlation-id: 069099ff-2910-48aa-f226-08dd46b98311
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?KnDv8LjNY0NSXOqgsJMoNKDge9jA6CeQXnPTlX8+NqbJgEOI094AlQ7q9KrJ?=
 =?us-ascii?Q?QLGCsL3DtF1CICFvicmrsHWiKcvjsCqUTe4eVsSA3jyE4+8iUXV3qqOWQ2Nf?=
 =?us-ascii?Q?/gj/euQ8e9wlJFbpiLvQoi7BaWIZvhyeOVwbASUHEenzOdAdvV7CUNBw5Los?=
 =?us-ascii?Q?AMtd0dtQYKuAjRUT7X1l79KJ6IuHX18H6wpkk2D/dNfTNc8SUQxsKYAq5rP4?=
 =?us-ascii?Q?woxmonwqwP1jpDTq0hzdKcjLnUdORZjVVJhuL5SACii244ymukiJxLcVSjgB?=
 =?us-ascii?Q?5BVdcQRHSZV/n8y7/LaHYZHzmHNvLIetNbCP2tCBDozkKNXjYTKWhnPU/biz?=
 =?us-ascii?Q?M9gxjoX/nYYRarFdzna4T+QS8xXOkymX5g7RRWWOhnKLn9RnRT5iyGHeHynE?=
 =?us-ascii?Q?Xfh1TCzWGBy5kskCKRU450CHSVfim2qglJxLR2/yAGnBVyOD+9UpTznyO1ra?=
 =?us-ascii?Q?9ONvC3rboqbzdHcqhhrjND7bqVH4QZaGzNH3FvotQQ5Br2j0If16bwIg6BQ0?=
 =?us-ascii?Q?E+JNelVWjzrUjK7h7SZtASqz90nibY8rl5y6pYVXhcLCVPZtCaEeIEbfFWYk?=
 =?us-ascii?Q?ocDMFL4oV2mVqzxfxIqlqtnXy7flP/qcDPIRspzZI2p0coTcMWwdtDGc6KK5?=
 =?us-ascii?Q?0nFVff/AnaXw4uZe+irpk/eC7DERmUMQMdL2e5Jbwdh6jQgtZBT5121tLMsK?=
 =?us-ascii?Q?8PiDhiLOS7YfITAEcWLcWBP8yj73VfKx5Xd3rTsjsc5ZplaDMKeVGFdQwpFC?=
 =?us-ascii?Q?3ZvoQHv7xAxT3RPaPqXqyZaLGp5ClcFk7qWgMT2JFosRJEB+YR74bYroMkES?=
 =?us-ascii?Q?gq9CF6Hb3en389FJg66gSkzc7qSGesFj9wz906OnVKp3WCIahfyOTZdmdjCh?=
 =?us-ascii?Q?SfQiAnAlkZ59/OQSyrVMj8Zs9DgGHxnWxLzmH9n1i0m1eDQ3bVYcix9JkLjn?=
 =?us-ascii?Q?yOK/Mcby6AUeUpGQ63CUEehAp5iRBX/iucJwVuiy0NUrGzgpiIkjVMEyI+9Q?=
 =?us-ascii?Q?yux8na98UWB+6O9renblioq38jzSNLlX83NrH5xNmKYK15tj8/t5RAAnSjzP?=
 =?us-ascii?Q?xp4v839SnPe0Ekn7SPTQ00PkPvLWyViipRuL5bn/0hj1x/QU61VNQ4fMqOYL?=
 =?us-ascii?Q?yeIRtz2+VrmOurjem66/3D9SxOqK2567rYSnbzeDoCUJC0Arcu9Y/MyhGRRO?=
 =?us-ascii?Q?tAAdJnmq0lbjf9ucJK1ea33SkjHHLB4bxwgQh29+OiY5qFfumlnc88mRW+Va?=
 =?us-ascii?Q?10OFYYbKEOduAI3pZa6azK3f1S1XDO4wi8i5rCfmrZrERJKNRz8ORvVs9Yfn?=
 =?us-ascii?Q?s/DPwZxl+KuozjSf0BboLNfmBaYI04LvidqMOVm92q359v4uSjdMeFSYfdTG?=
 =?us-ascii?Q?9ARenj5ANOcFupAC3UUmFg9LIZEVofDtu3IvtsBtqGTSTyM4vV4nWcMLdGct?=
 =?us-ascii?Q?Bah8JayNwHgb277GN+fJs+ytwMxL9FzN?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY3PR18MB4705.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RNLeLbQvLdFhL54ydQorxiwN7ijYhA5UQhjR8pItVPiKrKAgzgcfBRpNKY6+?=
 =?us-ascii?Q?+4V4gD/8Og1evStSDufy9VHBmp9ZLi1Z45HQXYTfiEAhQ9+OVTX5A8B9Ydgp?=
 =?us-ascii?Q?XgSYiQ0B5NSChzBg0JNcoCWDqauZcEOmnFZ+iC+Qp1/zFy6CPJ+wJ9oIIT3X?=
 =?us-ascii?Q?dbPx07nrNNcWEKXt6aw6XupMBc/XOrPkA0/NyFb5cMAkVpPv7EfrwyY3tb+i?=
 =?us-ascii?Q?SiAZzU2qWxQB0lhCk2sVdJvAXdWJQIPwU7DOhB/cE1UOAf2QfGOTlHxXgH8v?=
 =?us-ascii?Q?p4bbc001AFA3gHnjzEDjJY/lNrmnDAegAp4lezzZy3WX1GpbWa0tQlJYrmJT?=
 =?us-ascii?Q?+5ZsAwhcno3nSQFASHt3+8WKOPAderx5qOQDg4+gw1mD5LXSeNHMB/xHTqMy?=
 =?us-ascii?Q?5HpSQZDhVLmX7RifWR8meDGrx+6i98jGjg+CrCIT+Xx3htD/an8QQCy0kr2b?=
 =?us-ascii?Q?5bk313WFmScD+Q4cXd7kwOOh4C1kpXQ/nJQcfDWWcP7gPcjSeyVKugl/3SMb?=
 =?us-ascii?Q?0ZA4EXC2OLcuEunmQH7XbkgwnBM6I4L0Fak+kdUP9ZUZ3Ms1yPl2QmrPiPVg?=
 =?us-ascii?Q?w6yO6AoZ0lPwMecjBNgUCrLzEE5UXEFqsCy9UAb/8qnjk1c7JvyJsUIXY1R4?=
 =?us-ascii?Q?tGn4aQzONfjTBrjf8Yhaec9/whA+ZD7R7hNeZ0DskipKFplHogsNC7jQ+ZtT?=
 =?us-ascii?Q?IWIBhgfjNMseFwERwq19gCyhuPOO+Y9jRUEqNnEMirxvP6isxKRoLGDxuoKg?=
 =?us-ascii?Q?W0oeGplMXGsph+gicg3yi/btz+ghf58TJhOaaHxWZH2jWppQtGgVNHP2+3mj?=
 =?us-ascii?Q?XJcfUr4611b8YgyK4k93hF2Qv8xSh3WjaZQbugh4Vvm2rgi/aYzeOhllNkLv?=
 =?us-ascii?Q?B2fdK0Sc7xKDUzDymJP13UNVJFVDG3PvAPzvVg8/SBpf8d2wpgsulvWE0/vL?=
 =?us-ascii?Q?+hBiSCd+S2TJ6XC6pzGRzQbvkCrTR5up38tUUbI2FWwcYzHg+zrqZlMsK1LL?=
 =?us-ascii?Q?l6E0jocY5nKJw7vda0Pb35qCPRuJkWz8Bry2tPObujWTeZYY5IoyHBecV3ki?=
 =?us-ascii?Q?4faKRrbnxg7awk5WRJ760wcjSxSRkwopMy5/HWGCBjdrmhkvdYr9gVAHm2ir?=
 =?us-ascii?Q?nSHmmnowFIAZpVDPdh8PTEN5uUqDFvRhkImZZvK4/g+YepKOEVf4Ws49zEfY?=
 =?us-ascii?Q?e63eqhlAYMpetNO0Xzwi4F0s/HE42xLPmw7GQ5G9j7qewcqb9CBgAbypblBF?=
 =?us-ascii?Q?x+IETy8qguSWc+b5ncl1sKOfxioUK1RoJ1p7vj+6QyTfVpklrWVCrPfDkzlA?=
 =?us-ascii?Q?ddXI5PbrityWWAEolSvORNRci+8vqEVDIkAfMHEJGVk4WcbFrKI51WR3y3L7?=
 =?us-ascii?Q?CjeZoLIGrD44KceTGJqjpDv5Myw2drIePuwN+X9ShiYHB+fu5B08YSGveFez?=
 =?us-ascii?Q?LDvNljmKFW8fmMMQnlXsUTK2n2pGs3D33nkRgGsYZcVefldUnLIIcEVsIW2q?=
 =?us-ascii?Q?dkFEwIg94B6+aPonbPrxppxfqFz3n04PWo4HOi3Cb8IKa0ePXde2bK6sV4IG?=
 =?us-ascii?Q?k55lNPYHyWI7sDotznH3JnlHUWQeyQmzrCT4JTeo?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4705.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 069099ff-2910-48aa-f226-08dd46b98311
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2025 14:21:13.7708 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kZ9svbiHQnLakEumSOdFl0DZZAj/YaOHsNMR6CDGjyVgz5OPTsn0mNWsOvkFNmlsm53bqj+W+KyftSAvYmNUhO8UcCqyPJFSeNYp5OagfOc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR18MB6361
X-Proofpoint-GUID: A0zjhJmkjZci_tvSzf1IhVLinX7J1LoZ
X-Proofpoint-ORIG-GUID: A0zjhJmkjZci_tvSzf1IhVLinX7J1LoZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-06_03,2025-02-05_03,2024-11-22_01
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

Hi Maxime,

> On 1/7/25 7:44 PM, Gowrishankar Muthukrishnan wrote:
> > Move vhost-vdpa backend implementation into common folder.
>=20
> If we decided to have a common base for Virtio devices, which I think is =
a good
> idea to avoid needless duplication, we should do a deeper refactoring by
> sharing all transport layers: PCI and Virtio-user.
>=20

Yes, but our initial proposal in this RFC is to start with vDPA first.

> I understand it is not realistic to do this for v25.03 release, so in the=
 mean time
> I prefer you duplicate what you need from Vhost-vDPA implementation than
> having an half-baked solution.
>=20

Ack.

Thanks,
Gowrishankar

> Maintainers, what do you think?
>=20
> Thanks,
> Maxime
>=20
> > Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
> > ---
> > Depends-on: patch-149672 ("vhost: include AKCIPHER algorithms in
> > crypto_config")
> > Depends-on: patch-148913 ("crypto/virtio: remove redundant crypto
> > queue free")
> > Depends-on: series-34293 ("crypto/virtio: add packed ring support")
> > Depends-on: series-34291 ("crypto/virtio: add RSA support")
> >
> >
> >   drivers/common/virtio/meson.build             | 13 +++++++++
> >   drivers/common/virtio/version.map             |  8 ++++++
> >   .../virtio/virtio_user/vhost.h                |  4 ---
> >   .../common/virtio/virtio_user/vhost_logs.h    | 15 ++++++++++
> >   .../virtio/virtio_user/vhost_vdpa.c           | 28 ++++++++++++++++++=
-
> >   drivers/crypto/virtio/meson.build             |  2 +-
> >   drivers/meson.build                           |  1 +
> >   drivers/net/virtio/meson.build                |  3 +-
> >   drivers/net/virtio/virtio_user/vhost_kernel.c |  3 +-
> >   drivers/net/virtio/virtio_user/vhost_user.c   |  3 +-
> >   .../net/virtio/virtio_user/virtio_user_dev.c  |  5 ++--
> >   .../net/virtio/virtio_user/virtio_user_dev.h  | 24 +++++++++-------
> >   12 files changed, 87 insertions(+), 22 deletions(-)
> >   create mode 100644 drivers/common/virtio/meson.build
> >   create mode 100644 drivers/common/virtio/version.map
> >   rename drivers/{net =3D> common}/virtio/virtio_user/vhost.h (97%)
> >   create mode 100644 drivers/common/virtio/virtio_user/vhost_logs.h
> >   rename drivers/{net =3D> common}/virtio/virtio_user/vhost_vdpa.c (97%=
)
> >
> > diff --git a/drivers/common/virtio/meson.build
> > b/drivers/common/virtio/meson.build
> > new file mode 100644
> > index 0000000000..a19db9e088
> > --- /dev/null
> > +++ b/drivers/common/virtio/meson.build
> > @@ -0,0 +1,13 @@
> > +# SPDX-License-Identifier: BSD-3-Clause # Copyright(c) 2025 Marvell
> > +
> > +if is_windows
> > +    build =3D false
> > +    reason =3D 'not supported on Windows'
> > +    subdir_done()
> > +endif
> > +
> > +if is_linux
> > +    sources +=3D files('virtio_user/vhost_vdpa.c')
> > +    deps +=3D ['bus_vdev']
> > +endif
> > diff --git a/drivers/common/virtio/version.map
> > b/drivers/common/virtio/version.map
> > new file mode 100644
> > index 0000000000..fb98a0ab2e
> > --- /dev/null
> > +++ b/drivers/common/virtio/version.map
> > @@ -0,0 +1,8 @@
> > +INTERNAL {
> > +	global:
> > +
> > +	virtio_ops_vdpa;
> > +	vhost_logtype_driver;
> > +
> > +	local: *;
> > +};
> > diff --git a/drivers/net/virtio/virtio_user/vhost.h
> > b/drivers/common/virtio/virtio_user/vhost.h
> > similarity index 97%
> > rename from drivers/net/virtio/virtio_user/vhost.h
> > rename to drivers/common/virtio/virtio_user/vhost.h
> > index eee3a4bc47..adf6551681 100644
> > --- a/drivers/net/virtio/virtio_user/vhost.h
> > +++ b/drivers/common/virtio/virtio_user/vhost.h
> > @@ -11,10 +11,6 @@
> >
> >   #include <rte_errno.h>
> >
> > -#include "../virtio.h"
> > -#include "../virtio_logs.h"
> > -#include "../virtqueue.h"
> > -
> >   struct vhost_vring_state {
> >   	unsigned int index;
> >   	unsigned int num;
> > diff --git a/drivers/common/virtio/virtio_user/vhost_logs.h
> > b/drivers/common/virtio/virtio_user/vhost_logs.h
> > new file mode 100644
> > index 0000000000..653d4d0b5e
> > --- /dev/null
> > +++ b/drivers/common/virtio/virtio_user/vhost_logs.h
> > @@ -0,0 +1,15 @@
> > +/* SPDX-License-Identifier: BSD-3-Clause
> > + * Copyright(C) 2025 Marvell
> > + */
> > +
> > +#ifndef _VHOST_LOGS_H_
> > +#define _VHOST_LOGS_H_
> > +
> > +#include <rte_log.h>
> > +
> > +extern int vhost_logtype_driver;
> > +#define RTE_LOGTYPE_VHOST_DRIVER vhost_logtype_driver #define
> > +PMD_DRV_LOG(level, ...) \
> > +	RTE_LOG_LINE_PREFIX(level, VHOST_DRIVER, "%s(): ", __func__,
> > +__VA_ARGS__)
> > +
> > +#endif /* _VHOST_LOGS_H_ */
> > diff --git a/drivers/net/virtio/virtio_user/vhost_vdpa.c
> > b/drivers/common/virtio/virtio_user/vhost_vdpa.c
> > similarity index 97%
> > rename from drivers/net/virtio/virtio_user/vhost_vdpa.c
> > rename to drivers/common/virtio/virtio_user/vhost_vdpa.c
> > index bc3e2a9af5..af5c4cbf33 100644
> > --- a/drivers/net/virtio/virtio_user/vhost_vdpa.c
> > +++ b/drivers/common/virtio/virtio_user/vhost_vdpa.c
> > @@ -9,11 +9,12 @@
> >   #include <fcntl.h>
> >   #include <stdlib.h>
> >   #include <unistd.h>
> > +#include <inttypes.h>
> >
> >   #include <rte_memory.h>
> >
> >   #include "vhost.h"
> > -#include "virtio_user_dev.h"
> > +#include "vhost_logs.h"
> >
> >   struct vhost_vdpa_data {
> >   	int vhostfd;
> > @@ -100,6 +101,29 @@ vhost_vdpa_ioctl(int fd, uint64_t request, void
> *arg)
> >   	return 0;
> >   }
> >
> > +struct virtio_hw {
> > +	struct virtqueue **vqs;
> > +};
> > +
> > +struct virtio_user_dev {
> > +	union {
> > +		struct virtio_hw hw;
> > +		uint8_t dummy[256];
> > +	};
> > +
> > +	void		*backend_data;
> > +	uint16_t	**notify_area;
> > +	char		path[PATH_MAX];
> > +	bool		hw_cvq;
> > +	uint16_t	max_queue_pairs;
> > +	uint64_t	device_features;
> > +	bool		*qp_enabled;
> > +};
> > +
> > +#define VIRTIO_NET_F_CTRL_VQ   17
> > +#define VIRTIO_F_IOMMU_PLATFORM        33
> > +#define VIRTIO_ID_NETWORK  0x01
> > +
> >   static int
> >   vhost_vdpa_set_owner(struct virtio_user_dev *dev)
> >   {
> > @@ -715,3 +739,5 @@ struct virtio_user_backend_ops virtio_ops_vdpa =3D =
{
> >   	.map_notification_area =3D vhost_vdpa_map_notification_area,
> >   	.unmap_notification_area =3D vhost_vdpa_unmap_notification_area,
> >   };
> > +
> > +RTE_LOG_REGISTER_SUFFIX(vhost_logtype_driver, driver, NOTICE);
> > diff --git a/drivers/crypto/virtio/meson.build
> > b/drivers/crypto/virtio/meson.build
> > index d2c3b3ad07..8181c8296f 100644
> > --- a/drivers/crypto/virtio/meson.build
> > +++ b/drivers/crypto/virtio/meson.build
> > @@ -8,7 +8,7 @@ if is_windows
> >   endif
> >
> >   includes +=3D include_directories('../../../lib/vhost')
> > -deps +=3D 'bus_pci'
> > +deps +=3D ['bus_pci', 'common_virtio']
> >   sources =3D files(
> >           'virtio_cryptodev.c',
> >           'virtio_cvq.c',
> > diff --git a/drivers/meson.build b/drivers/meson.build index
> > 495e21b54a..2f0d312479 100644
> > --- a/drivers/meson.build
> > +++ b/drivers/meson.build
> > @@ -17,6 +17,7 @@ subdirs =3D [
> >           'common/nitrox',  # depends on bus.
> >           'common/qat',     # depends on bus.
> >           'common/sfc_efx', # depends on bus.
> > +        'common/virtio',  # depends on bus.
> >           'mempool',        # depends on common and bus.
> >           'dma',            # depends on common and bus.
> >           'net',            # depends on common, bus, mempool
> > diff --git a/drivers/net/virtio/meson.build
> > b/drivers/net/virtio/meson.build index 02742da5c2..bbd73741f0 100644
> > --- a/drivers/net/virtio/meson.build
> > +++ b/drivers/net/virtio/meson.build
> > @@ -54,7 +54,6 @@ if is_linux
> >           'virtio_user/vhost_kernel.c',
> >           'virtio_user/vhost_kernel_tap.c',
> >           'virtio_user/vhost_user.c',
> > -        'virtio_user/vhost_vdpa.c',
> >           'virtio_user/virtio_user_dev.c')
> > -    deps +=3D ['bus_vdev']
> > +    deps +=3D ['bus_vdev', 'common_virtio']
> >   endif
> > diff --git a/drivers/net/virtio/virtio_user/vhost_kernel.c
> > b/drivers/net/virtio/virtio_user/vhost_kernel.c
> > index e42bb35935..3a95ce34d6 100644
> > --- a/drivers/net/virtio/virtio_user/vhost_kernel.c
> > +++ b/drivers/net/virtio/virtio_user/vhost_kernel.c
> > @@ -11,9 +11,10 @@
> >
> >   #include <rte_memory.h>
> >
> > -#include "vhost.h"
> > +#include "virtio_user/vhost.h"
> >   #include "virtio_user_dev.h"
> >   #include "vhost_kernel_tap.h"
> > +#include "../virtqueue.h"
> >
> >   struct vhost_kernel_data {
> >   	int *vhostfds;
> > diff --git a/drivers/net/virtio/virtio_user/vhost_user.c
> > b/drivers/net/virtio/virtio_user/vhost_user.c
> > index c10252506b..2a158aff7e 100644
> > --- a/drivers/net/virtio/virtio_user/vhost_user.c
> > +++ b/drivers/net/virtio/virtio_user/vhost_user.c
> > @@ -16,7 +16,8 @@
> >   #include <rte_string_fns.h>
> >   #include <rte_fbarray.h>
> >
> > -#include "vhost.h"
> > +#include "virtio_user/vhost_logs.h"
> > +#include "virtio_user/vhost.h"
> >   #include "virtio_user_dev.h"
> >
> >   struct vhost_user_data {
> > diff --git a/drivers/net/virtio/virtio_user/virtio_user_dev.c
> > b/drivers/net/virtio/virtio_user/virtio_user_dev.c
> > index 2997d2bd26..7105c54b43 100644
> > --- a/drivers/net/virtio/virtio_user/virtio_user_dev.c
> > +++ b/drivers/net/virtio/virtio_user/virtio_user_dev.c
> > @@ -20,10 +20,11 @@
> >   #include <rte_malloc.h>
> >   #include <rte_io.h>
> >
> > -#include "vhost.h"
> > -#include "virtio.h"
> > +#include "virtio_user/vhost.h"
> >   #include "virtio_user_dev.h"
> > +#include "../virtqueue.h"
> >   #include "../virtio_ethdev.h"
> > +#include "../virtio_logs.h"
> >
> >   #define VIRTIO_USER_MEM_EVENT_CLB_NAME
> "virtio_user_mem_event_clb"
> >
> > diff --git a/drivers/net/virtio/virtio_user/virtio_user_dev.h
> > b/drivers/net/virtio/virtio_user/virtio_user_dev.h
> > index 66400b3b62..70604d6956 100644
> > --- a/drivers/net/virtio/virtio_user/virtio_user_dev.h
> > +++ b/drivers/net/virtio/virtio_user/virtio_user_dev.h
> > @@ -25,26 +25,36 @@ struct virtio_user_queue {
> >   };
> >
> >   struct virtio_user_dev {
> > -	struct virtio_hw hw;
> > +	union {
> > +		struct virtio_hw hw;
> > +		uint8_t dummy[256];
> > +	};
> > +
> > +	void		*backend_data;
> > +	uint16_t	**notify_area;
> > +	char		path[PATH_MAX];
> > +	bool		hw_cvq;
> > +	uint16_t	max_queue_pairs;
> > +	uint64_t	device_features; /* supported features by device */
> > +	bool		*qp_enabled;
> > +
> >   	enum virtio_user_backend_type backend_type;
> >   	bool		is_server;  /* server or client mode */
> >
> >   	int		*callfds;
> >   	int		*kickfds;
> >   	int		mac_specified;
> > -	uint16_t	max_queue_pairs;
> > +
> >   	uint16_t	queue_pairs;
> >   	uint32_t	queue_size;
> >   	uint64_t	features; /* the negotiated features with driver,
> >   				   * and will be sync with device
> >   				   */
> > -	uint64_t	device_features; /* supported features by device */
> >   	uint64_t	frontend_features; /* enabled frontend features */
> >   	uint64_t	unsupported_features; /* unsupported features mask
> */
> >   	uint8_t		status;
> >   	uint16_t	net_status;
> >   	uint8_t		mac_addr[RTE_ETHER_ADDR_LEN];
> > -	char		path[PATH_MAX];
> >   	char		*ifname;
> >
> >   	union {
> > @@ -54,18 +64,12 @@ struct virtio_user_dev {
> >   	} vrings;
> >
> >   	struct virtio_user_queue *packed_queues;
> > -	bool		*qp_enabled;
> >
> >   	struct virtio_user_backend_ops *ops;
> >   	pthread_mutex_t	mutex;
> >   	bool		started;
> >
> > -	bool			hw_cvq;
> >   	struct virtqueue	*scvq;
> > -
> > -	void *backend_data;
> > -
> > -	uint16_t **notify_area;
> >   };
> >
> >   int virtio_user_dev_set_features(struct virtio_user_dev *dev);

