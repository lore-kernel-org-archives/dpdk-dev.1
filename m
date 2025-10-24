Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A349CCF9E9
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 13:30:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EC49740151;
	Fri, 24 Oct 2025 15:30:24 +0200 (CEST)
Received: from egress-ip11b.ess.de.barracuda.com
 (egress-ip11b.ess.de.barracuda.com [18.185.115.215])
 by mails.dpdk.org (Postfix) with ESMTP id C1DEA40150
 for <dev@dpdk.org>; Fri, 24 Oct 2025 15:30:20 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11021111.outbound.protection.outlook.com
 [52.101.65.111]) by mx-outbound16-13.eu-central-1b.ess.aws.cudaops.com
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 24 Oct 2025 13:30:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tetocOTHXTdZSXrNDehJ5GW4+DWwJfNiyv+nMOp2hDWUO6blSL0XgXf6Ie8fY7p78KBQk8GEHyAG6YB2CZpju1PBJHUHuVOwZEBTb27qOu3KIEaORjFSrzYUibizv/FhaLecvftelkQIiBpaUHPDSJSXaUUHKom0p+dQuPEb5jHJdpLeNEACOpAXqJgOlyCUQlZ1IjaN4q0GVftqnFqq0/1mD0PBSjeAcL18YXmrQJ7T/BKu/xEIVpQdHSatRYTAP5qQmBOlyJTsUvCt7VJz7stNOiLCtxFDUCLSEi3ecN46L21snDhqvdzbSrf/DBR/u8Qy2/ocutjcf6Xb1emB0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wtBropOtvKh/tZBRhgxaJ3KKY7aTb4A4aPGIOSqfQYA=;
 b=Zhm8FPMv3GzwEyW0jWBzGaARXCRa1EzhJptM9M8fFL+1kTfeZtrzy2lIpwDN3TqYRqcpaVFuxbAGYNZ5WUI38iUQyYAnngMOo2/3hTl4S8RwGrtKgpx5pkolFBLyMFNR+Rj/rkqfhZOd0S+Iwh4IIJAzGTmmbFuN5JaRSWusqviNaywKp26Idm+AMw7fTwNrd+9Mg7rgdt0a/aHaYvpKjUqjUKK1OrSc+k1IlCDnx3I423oBwzcc1McOxoDk2Y4Vz4VSJGnCqdiIEZ+0lyzYbGmoYio0EjmoQb8fxTQURiiCoNfUOYNyanUSedPfj6YgcKslSaZgP6clXJyAsuiWaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=napatech.com; dmarc=pass action=none header.from=napatech.com;
 dkim=pass header.d=napatech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wtBropOtvKh/tZBRhgxaJ3KKY7aTb4A4aPGIOSqfQYA=;
 b=ouphhK8Rg8NDC8+10YhcwhdqV0QiOkKmA2Npmq7otvFKtLO5JifH3nAKex8PMDH1PWyCtGrQgk0ZvD17/1Xc+PiTGnK9s59WqO0dt/IQRyCfIL1AmdOvqYtFSo/pm4k0pR2pX3MDVG892b4uPVVAmJastruOfHBE3s0OfgqNVn4=
Received: from VE1P190MB0830.EURP190.PROD.OUTLOOK.COM (2603:10a6:800:1a9::5)
 by AM8P190MB0897.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:1dd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 13:30:17 +0000
Received: from VE1P190MB0830.EURP190.PROD.OUTLOOK.COM
 ([fe80::fb19:d808:3eac:2ea3]) by VE1P190MB0830.EURP190.PROD.OUTLOOK.COM
 ([fe80::fb19:d808:3eac:2ea3%5]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 13:30:17 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: "dev@dpdk.org" <dev@dpdk.org>, Mykola Kostenok <mko-plv@napatech.com>,
 Christian Koue Muf <ckm@napatech.com>, "stephen@networkplumber.org"
 <stephen@networkplumber.org>
Subject: Re: [PATCH v2] doc: refactoring the guide for NTNIC PMD
Thread-Topic: [PATCH v2] doc: refactoring the guide for NTNIC PMD
Thread-Index: AQHcRCo8Yafs3aBPJ0+/plVlAUBParTP0DuAgAAEGLE=
Date: Fri, 24 Oct 2025 13:30:17 +0000
Message-ID: <VE1P190MB0830558DE6BA8A793E1D6D5380F0A@VE1P190MB0830.EURP190.PROD.OUTLOOK.COM>
References: <3590447.BaHzMo0RvP@thomas>
 <20251023143506.587329-1-sil-plv@napatech.com> <6896421.YiXZdWvhHV@thomas>
In-Reply-To: <6896421.YiXZdWvhHV@thomas>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=napatech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VE1P190MB0830:EE_|AM8P190MB0897:EE_
x-ms-office365-filtering-correlation-id: 61250a89-9185-4cfd-25c8-08de130178b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?gJkRXtGjVGqAt9oSH7cbFF5t2OYqJoQFxkusKzv1gQquuv28xGc+gl83FU?=
 =?iso-8859-1?Q?1ay0oIu3dxlJl/luKQXcxu+XpnB/nEgrZ608oY0nYD1S4X1chob+1xtH77?=
 =?iso-8859-1?Q?WQVeDN0N7iUji/RTo8u2Tiv5XBoQc+mzuf9lbW7uezD9DuoTIzddL8JYP5?=
 =?iso-8859-1?Q?pkpNH/79VxW+mP8kDYMLNbfpespJ9+K1+cNEYIRNNg82dmkZvCQ3eHCsLy?=
 =?iso-8859-1?Q?NHvjWElwLIUp54Sv18V6F6/hzhI2QBL4cmWJzSPDCBhWAgragYGr9/q1Zf?=
 =?iso-8859-1?Q?yMny3NQclwx2ppGP4Jf6ixV7Aaiw1CCRhbhj0cA6uFnQp/NSeT4JeDzczM?=
 =?iso-8859-1?Q?hjxQJM+ukLr2k9wouwnlgQ0qz6LyzIaPqviU1LaPaXDeiCKDO/if8CehWy?=
 =?iso-8859-1?Q?rrROt2Eni+1FIM4Sp9FHHZqP1rHWKSG8yGPeB752SBuZNBGxIorsz8pqZq?=
 =?iso-8859-1?Q?wtTXYfmnPoV4sOwbzLvMho/4/VsO+JyOcF3aao9MJZ7F37R1KYwhO0niyl?=
 =?iso-8859-1?Q?QvIjU/iKiH8KpKzrS8wBssPX0YjMNvhWo5c0SZEwD/aU8LzBxXiI/QZIPp?=
 =?iso-8859-1?Q?MPx9WY0vhtaFZOKHPt/1kNT3Cu94esbSonXbB4Cr0IbttQBfAsC7g0sF+F?=
 =?iso-8859-1?Q?0Aa+nba2o2lrT3JhRDpZALOn94IjOLVhERGmshqt6oRgWhhBtYT/R1GdQq?=
 =?iso-8859-1?Q?ciizIV4WQ4pOFvNqsHQdDC7R+/8XQqYbS8SRYQzlSy/6Saug+tRUMr51xv?=
 =?iso-8859-1?Q?mQ9erZ2czJa2ae59xX0wpAWrrkzpNty5N79vAROpMxxvtWNeJm2V7STLW2?=
 =?iso-8859-1?Q?CBDqan+u3awVPZfafTmicJBrVrYpOest5XI8t2oy7GWpZ90FfAwfo6cA3L?=
 =?iso-8859-1?Q?ntkkZE7fVeS6ZAXennxci6s74IujgiPq5fWs9sm1ww1POO3qLKiAXmu7/d?=
 =?iso-8859-1?Q?gHGkgEKzdrhmWlbBplfv8pMesAjzBFYiJ3CyLEugjj/1iHQR3j1vNU/bsk?=
 =?iso-8859-1?Q?wBlTWICtshQvZrzKpBLXl+xR8vW95yDQV1D2xnzGB9SSs3zUHlaE3kOjFW?=
 =?iso-8859-1?Q?Yx78/hJ2C8uny+VFTvPL4WbR0Y/fpfirL2SQOZqgJXvDueHPLMHn+bjhcj?=
 =?iso-8859-1?Q?kYKWyo4MbwB1D+3wWtvH8LGxfamiVjLWtnPpKlAXkT+IVd3i3pXTbkSbxA?=
 =?iso-8859-1?Q?xNju/w+KKTzXvdq8WRRXJiigVlafBpbskmEnAG1xailJuK4iKg0E9Axp5s?=
 =?iso-8859-1?Q?gVZpjGjroCUhT+9hhpGo2YUFJ1tIvosY7B6n1rSk0D3UBY+tGgU0hIgKOe?=
 =?iso-8859-1?Q?StKcE2C6UsGO0I3LPj2kTYk/mWuu12a1YWuQvZSoOvuZi+S5daZiMzwPyW?=
 =?iso-8859-1?Q?2s0zsYYu5W1vaqIzA8PIxuoPIwf8wpqWfrhjnXdLMmYllo8qUuNjgjxr0C?=
 =?iso-8859-1?Q?012xVXsISd7jjM1CC0gUE/qphAWAe7EPGpP6DFyJVKg2SmuPfVYE6W/6A+?=
 =?iso-8859-1?Q?RpmDtIdNebwveKywcDvZSIv5oIiqAt5aTTwofX4izM1jnv8avKOGMHiUUF?=
 =?iso-8859-1?Q?YO591s8/PsaQyuJ5l4p+iURdnwDO?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1P190MB0830.EURP190.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?uBpT4K2Pg41Hm5O/v08y3dcsHeKXKNsCr1ckDbHyJh10LXN6//Ld0tGhWM?=
 =?iso-8859-1?Q?UEqbfoki1FDcO8PEkxyE8UapzkeG8D2TnqE6Cur+sKfT2wk4MF99O+GeJz?=
 =?iso-8859-1?Q?13apDh1oE3vnX6wPU0slF4lNTcL/e0UACm2LieW0NvZDDhm+zrDopLkeaq?=
 =?iso-8859-1?Q?qhoL0GgXJkfb2VjWgRhRdJEsXELOvi9Zh25OaLETRONQdt/kQTVhW3pJG4?=
 =?iso-8859-1?Q?CZAokc+6cEhe6P0aQqiLiLbY/G5Dt3b4gGKaXWezwYW7PvpiwWWVsRVFQ+?=
 =?iso-8859-1?Q?qBLVJbrXSbx7GGUtkSpwnW7OcTRvFID4zvlERnQeQwBMZMa8bHujNW+Ikd?=
 =?iso-8859-1?Q?eusN7dBa3q7JYPhiv31pti/L2N4kBvRJc62F2zWXxv7KhRkt+y4ctZoU7X?=
 =?iso-8859-1?Q?ZSofhFyAQwKivLR9cYB8hd6BkB+xp0yI6HAVQx9yCcCAtkQwaDF1Mf2ngP?=
 =?iso-8859-1?Q?qhDGS/EnfEW4dbU3y+YxW+GBHtgd5dQ3P2P3oTtdaSI5oOwjp++1wfT2HO?=
 =?iso-8859-1?Q?C4dQNvsKDEtQDOR4AD4AGHt3+x+FpEOrClBf7EQp1PvfETHVeXY4R9G226?=
 =?iso-8859-1?Q?6dYb5gL2mD6PlDNhT9CD1KioHCJEKRw6J+J/vUiCSLmv2xzObVH9Rbg8UW?=
 =?iso-8859-1?Q?so2ze8GR2J7ggPYqtosOWWyQxNQjhiZ/poyXNKaas12pbx43tZYAf/WZAY?=
 =?iso-8859-1?Q?5J9Lv+8BQt1P/MW/9sVtW31L0kkDP6vKTxqk3eCeQhXFY2wnXqGuNf28eS?=
 =?iso-8859-1?Q?5uVEREu6kXUoZL1n7rg4e21PrFV21sjrZMFdkB7smJmrI7AzIMakiEVpKm?=
 =?iso-8859-1?Q?MStNviKKXvKdUgfeZeeBgSvZbbm86r5W1P2C672MaNWoEfWhs/brBnSmu4?=
 =?iso-8859-1?Q?4XIOlpLVxmC7i/khyYlYN9v8r4f3Vq2c/IPOqg0s3ADxihn7fTnrNSjmfK?=
 =?iso-8859-1?Q?Y4Rs4iDxAQy1K/GVpIBkOdOwLWMAPKbyBTtwDPqtZdK5v4AuDgvNmKvmCD?=
 =?iso-8859-1?Q?9IqlZMZwgBKpblgkWxuFDmLcHD3w1s2OM83Cv6AZDIheZ+cf5qSaogH/1g?=
 =?iso-8859-1?Q?vew5KR6gdPJlsEQH7MaYjFOQm12Fa5x3TmYa3O6Y6CMB9WEjFeirMKWRsr?=
 =?iso-8859-1?Q?06KrwKJ0xBnJF4kAHx2e31D/1E8dtU8UMDqTKZE2CcfpqOxhuLrUgISUio?=
 =?iso-8859-1?Q?3ElqDeV9zVGrhuDun6kQmcWkoiL8uiSZohEVoYv6+/BbqVzP4Zrq2xWR0O?=
 =?iso-8859-1?Q?5e7Mj97mMj8auwgKapLygEbAiHtRl612cy01WWWdZOoESUdBeGXS/Uv00f?=
 =?iso-8859-1?Q?uvG928vPgETxFyf8T+nCeOnTvQH89z1fHmELpGPXGqQGj5SyiLg3Y0Q0zs?=
 =?iso-8859-1?Q?8OsAKmRhFdZyh+NqiFBEdMYbfw3urMBUH4KkUi2k/ED0UsKoJWuQ9qGe9m?=
 =?iso-8859-1?Q?3trE8vJdu6KZ7kyu5ejpFWviw2fpMrTrvrJc4Qwm15wWxVctKRv64kk1zU?=
 =?iso-8859-1?Q?SRUZeHOEi0b549OIxsNDtpSZWfo5aGz7JXwGaBtZJeYvaXArAtWD48XNJf?=
 =?iso-8859-1?Q?eAlBU89YGYQ3K+hedwopfJEs2Vqt5JHhEClkujRYGFeHlAaFkZA2ujbguK?=
 =?iso-8859-1?Q?hIz9dx8c0m4Lb1VvNXz+KWuZM4VEvshVOY?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: a/iHgxVdiCyOgyVqd5VncAXIzBPGEeAS5T+2hKVvILzljHSYL2j2Gr59miLmXTIRLQVbtRjJqEfZO9aHNfaAn5/z+nEWCouPn1giIXFV0JnWuHrHD0lstL3HgVh4ouyan+Qcjw98+aFh78BQwOfTyCx0zNmfDzgvP2NUz+xwtu5y/iGVGWuxio30jlFstp/ZSt9UVGv7uEtoP3EHqekO7P2Ypcv3F5V3IXQe+OeMmIOiHqQiF4zowtXmzELFf2O9RVFPBhtEdfai89VgXaSFybpM16w2Wf9FJaLdlz991QC3mPpcw4vmSNAruA3fi+iPIYdfv/GCW1e49122fcMX1s1j2vHZftrPIHJaS5Q2h9mHoMN1v5uX+10E8dI8c+HMQQQ2vyTM1dbpnHIIv57lzDErwhbvdadbWXAVMbo6r0cDurSFKYTaAQL7F1mNH2xO2UeyHX6NIisfIS+OeH46sFo490ZNa/7n6ui5NghXsphLJJ3CG404zQ4dqQM8VCqOB/ZcSpGZMlK0Pet0Q0l8cFZ2E027Q832ydMdhf7SXq+RusHfYG63norKJKTrptRtZ3D/m/Eq1Fw5smoQpAum7a5aw1t1CWblgNPLgoLAUEhhLvohHiUSgt7L+U4Di3/DltJh3Nc7a8joPxmsdBdn/f8kdq45KkITZZKhMAH08Ik=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1P190MB0830.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 61250a89-9185-4cfd-25c8-08de130178b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2025 13:30:17.3833 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XZQjzLJndQNxtSDmZmLHMEhIq7K5WULgvHjTsZ7JOmODFkqxxGggHmm7VY6GmF91P4LtmyYzMCIAz8zOtoMjfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P190MB0897
X-BESS-ID: 1761312619-304109-6646-48557-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 52.101.65.111
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKViYmZpZAVgZQ0MggzTI52cjM0C
 IlxcjIyMLYxMTYINXI1NgkNTXJNNlCqTYWAE297FdBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.268440 [from 
 cloudscan11-195.eu-central-1a.ess.aws.cudaops.com]
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------
 0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS113687 scores of
 KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
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

From:=A0Thomas Monjalon <thomas@monjalon.net>=0A=
Sent:=A023 October 2025 17:49=0A=
To:=A0Serhii Iliushyk <sil-plv@napatech.com>=0A=
Cc:=A0dev@dpdk.org <dev@dpdk.org>; Mykola Kostenok <mko-plv@napatech.com>; =
Serhii Iliushyk <sil-plv@napatech.com>; Christian Koue Muf <ckm@napatech.co=
m>; stephen@networkplumber.org <stephen@networkplumber.org>=0A=
Subject:=A0Re: [PATCH v2] doc: refactoring the guide for NTNIC PMD=0A=
=A0=0A=
>23/10/2025 16:35, Serhii Iliushyk:=0A=
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=
=3D=0A=
>> +Supported Features=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 Linux=0A=
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=
=3D=0A=
>> +FW version=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 X=0A=
>> +Speed capabilities=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 X=0A=
>> +Link status (Link update only)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 X=0A=
>> +Unicast MAC filter=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 X=0A=
>> +Multicast MAC filter=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 X=0A=
>> +Promiscuous mode (Enable only. The device always run promiscuous mode)=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 X=
=0A=
>> +Flow API support.=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 X=0A=
>> +Support for multiple rte_flow groups.=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 X=0A=
>> +Multiple TX and RX queues.=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 X=0A=
>> +Scattered and gather for TX and RX.=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 X=0A=
>> +Jumbo frame support.=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 X=0A=
>> +Traffic mirroring.=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 X=0A=
>> +VLAN filtering.=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 X=0A=
>> +Packet modification: NAT, TTL decrement, DSCP tagging=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 X=0A=
>> +Tunnel types: GTP.=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 X=0A=
>> +Encapsulation and decapsulation of GTP data.=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 X=0A=
>> +RX VLAN stripping via raw decap.=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 X=
=0A=
>> +TX VLAN insertion via raw encap.=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 X=
=0A=
>> +CAM and TCAM based matching.=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 X=0A=
>> +Exact match of 140 million flows and policies.=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 X=0A=
>> +Tunnel HW offload: Packet type, inner/outer RSS, IP and UDP checksum ve=
rification.=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 X=0A=
>> +RSS hash=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 X=0A=
>> +RSS key update=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 X=0A=
>> +RSS based on VLAN or 5*tuple.=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 X=0A=
>> +RSS using combinations of fields: L3 only, L4 only or both, and src onl=
y, dst only or both.=A0=A0=A0 X=0A=
>=A0=0A=
>When you make a table, you should not write sentences.=0A=
>Columns must not be wide.=0A=
=A0=0A=
I will fix it. Is there any value for column length?=0A=
=A0=0A=
>=A0=0A=
>[...]=0A=
>> +<object>.<attribute>=3D[<object-ids>:]<value>=0A=
>=A0=0A=
>Should it have a fixed witdth font?=0A=
>=A0=0A=
It may have a fixed-width=A0font. I can fix it if it's required.=0A=
>=A0=0A=
>[...]=0A=
>> -``exception_path`` parameter [int]=0A=
>> +- ``exception_path`` parameter [int]=0A=
>=A0=0A=
>Why do you replace the definition list with a simple list?=0A=
>Did you check the HTML output?=0A=
>=A0=0A=
I did it to make it clearer when viewing the doc in RST preview or in plain=
 text. =0A=
>=A0=0A=
>[...]=0A=
>>=A0 Logging and Debugging=0A=
>> ----------------------=0A=
>> +~~~~~~~~~~~~~~~~~~~~~=0A=
>=A0=0A=
>Why? So there is only 1 main title like "Features"?=A0=0A=
>=A0=0A=
=A0=0A=
The titles have further structure after refactoring:=0A=
=A0=0A=
NTNIC Poll Mode Driver=0A=
    - Design=0A=
    - Supported NICs=0A=
    - Features=0A=
        - Limitations=0A=
    - Configuration=0A=
        - Command line arguments=0A=
        - Logging and Debugging=0A=
        - Flow Scanner=0A=
        - Service API=0A=
        - Service API for user applications=0A=
=A0=0A=
>=A0=0A=
>[...]=0A=
>> -.. note::=0A=
>> +=A0=A0 .. note::=0A=
>=A0=0A=
>No reason to do that.=0A=
=A0=0A=
If there is no tabulation, the section "None" grabs all the text below in t=
he HTML.=0A=
=A0=
