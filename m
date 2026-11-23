Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAFE60A2619
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Nov 2026 11:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=YxwJYLcJ
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BFE45402CC;
	Mon, 23 Nov 2026 12:37:40 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012035.outbound.protection.outlook.com [40.107.209.35])
 by mails.dpdk.org (Postfix) with ESMTPS id 3CBDD40262;
 Mon, 23 Nov 2026 12:37:39 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Smejg3PknFTeQDt4IkKnswPRBrI/f6aTm6lQqTP6jcpvsZzrQGV2JuHnkyQljsZyUQ7ihgb3plBQkYOVE+xybVL9L+l2A/swHwLR9YrUIDpoxNNN3ESu+FjSPw7YAltFJyzzJUbPFm2RiqyXSykUTchX7aC5EuwgYLlpizXSVb9sMXDlQXtm+LSwYtydiBbeiOekFGuAmMreyMiCl4KocqAL7P6bHRhggy30LwPnj558ScfqfnIvXf0GuW+lZe4NuFfw08YhzjzzmW/1BqlW331Ws3sN/dRl/GO3tIv5jwDsCP5Km/chWUaQporBBe+zzXJdIG2B/V7QT0f3msQ/rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kT6zRHVTZgP/DsF7GjGglkhODz64395SfxkyqaoSPM4=;
 b=b5eciBV4Wkr6OTLdmzWNiEqeIJmqtst4qAarsUt8hXm8NkVNom177xHKJjFMc7/UpN6vAhSbOQqg47Ee2/x9+Bd4eDW8dKONG/L5h6YLwPgQ6wXsIwYc8yRhlOIlvYGmIOCHKyL3HjD6U+WsBWMB+0pizIt4bRDYw2wOKjzJvfxI2++bUmikW8z7G2u3dO7vRIrM89JDoKWki9fH6QZmlVaQEiSbgjmlL7XaTQqL8PG0na5HXR9c6UYpmcPayrZHIFMnSNBxNyjRBvrEkMnZSz78RroRRG0dtTabRHCVyjnriMCKBNbIg6Bl4quLh+NqFWLCr9nzalvehgK/Mm5A/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kT6zRHVTZgP/DsF7GjGglkhODz64395SfxkyqaoSPM4=;
 b=YxwJYLcJoHpbNk44KLB/+5U72NJfvO2h9VMkXO7vJWEI/ATlTz5MAuVr6OGvXukeWMoeyKwvOaKf86BXHjyNLDwzrhOHnWPzmkMz0J4K7ysUR9ArCTQkYsqq71AogzuYnu9Pj3t7aDI1YmTyQlbe1PtA+pgZw5yHeGvlnrc5TagSMMT4Ly6qF0rtZ+K6bU3xHmS30QfyWpyF147GEvRc+rIxRsQmZ/vtC/ggC9Woz2Ik3J/5fEHfWTBC5I13/4aug2RRFilZZQ/Ihi8UhM5CkDRPFW6C0rQJ2eKKqBpgRbX9HiWZObhllS1iNbnM9LGA4I2rDH2FP3hwVKjedRdZkQ==
Received: from BN9PR12MB5338.namprd12.prod.outlook.com (2603:10b6:408:103::23)
 by LV3PR12MB9187.namprd12.prod.outlook.com (2603:10b6:408:194::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 11:37:34 +0000
Received: from BN9PR12MB5338.namprd12.prod.outlook.com
 ([fe80::7b66:315e:f851:8ddb]) by BN9PR12MB5338.namprd12.prod.outlook.com
 ([fe80::7b66:315e:f851:8ddb%6]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 11:37:34 +0000
From: Bing Zhao <bingz@nvidia.com>
To: dpdk stable <stable@dpdk.org>, "bluca@gmail.com" <bluca@gmail.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Dariusz Sosnowski <dsosnowski@nvidia.com>, 
 Kevin Bowling <kevin.bowling@kev009.com>, Matan Azrad <matan@nvidia.com>,
 Ori
 Kam <orika@nvidia.com>, Soumyadeep Hore <soumyadeep.hore@intel.com>, Suanming
 Mou <suanmingm@nvidia.com>, "NBU-Contact-Thomas Monjalon (EXTERNAL)"
 <thomas@monjalon.net>, Slava Ovsiienko <viacheslavo@nvidia.com>, Maayan
 Kashani <mkashani@nvidia.com>
Subject: RE: please help backporting some patches to stable release 24.11.9
Thread-Topic: please help backporting some patches to stable release 24.11.9
Thread-Index: AQHddh5NICtSq0gfaEG3j5MUMseCOrc7kU/w
Date: Mon, 23 Nov 2026 11:37:34 +0000
Message-ID: <BN9PR12MB5338C42FC5070BCF6B3894CAD0452@BN9PR12MB5338.namprd12.prod.outlook.com>
References: <20261116230026.947406-1-luca.boccassi@gmail.com>
In-Reply-To: <20261116230026.947406-1-luca.boccassi@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5338:EE_|LV3PR12MB9187:EE_
x-ms-office365-filtering-correlation-id: 92d918b9-a59f-4045-7f6a-08df49562ab3
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|10070799003|38070700021|10067099003|11063799006|56012099006|261021121427099003|261022113327099003|261009223027099003|261022105027099003|261102123227099003|261026140227099003|261028144727099003|261026121527099003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info: G6hlLdAsBgQwbFivuBXo6nl6Xbwetdxjg8XlD23Jrkw9yVGFEgNZqWvNvo10iqhPk8fZ5KqgRNKMjf2kxnsAbpV0ED4H3hz3h+TnfjHyfCFWXoxKQXzR0Cf7G6Osenb1VAZZe69IJMvOnvE4QAu9I1lFKs1DW585fK8j2FUyBE7XhqpAZ23LkmD0nFMiCzPkb26A7Hbi/r+QfoKpWjNSVMXOGXZtWQEaRSkar+tjwbEfWoB9Pffdy1Z2KknojMtInIugD5fafzfpfhIXE3gvgdxbbgAsUagh6Xv+3rhELunPP3zY4C3m3wj+290mMiaR/l507TflgPSwqZWJG4sBBDac7EP1rbjfQFh0vmbkg35qC3Ea8Ly7n6xoNjwl5/PvNv3VpVFr4C77gjKUsOvlT/3DD2xLDSgD60lOEv4BIXNgUJYLj/bZmKDdhXuMsGeeRnVvEPFgkZBNa/kGNu0SkzjULsUCAFdBLQHaLliDV0PFQpEh+n3PYHnQOIGF5Dmf/5o/jfwPe0BQ9aPddZvfglALM6lFmUe/pag9CH0Rsk1I85dzVZtVCKfrekv1nzNj2etsBj2zmwWhx7k53xjJ12q3U3uhL5PIXYV51gzcN2ngLvMMN9h8s7z9+5U6nZc9FURCc6sq0kbPWoTdGXS+OaJKaEJg4dITXzuIAwx3+8JazQPDuohYAn3V6I2kWC7mFe443I8Gwezv3w7da4fWIs00ZB/sNV8tIAENe9iYJ8g=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5338.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10070799003)(38070700021)(10067099003)(11063799006)(56012099006)(261021121427099003)(261022113327099003)(261009223027099003)(261022105027099003)(261102123227099003)(261026140227099003)(261028144727099003)(261026121527099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UKP0i74u3+XQeXqP7p62DazXFEI/9rdCpEumY1cv+aowSwNXYKbeE3E8/rF2?=
 =?us-ascii?Q?LX/rJmxswdkn7IZoZDwxsyYURvkPUKk0LuTtqhB66lTgRVUsH8LWhbiPitkV?=
 =?us-ascii?Q?cmHKcEd/zRuX7IHqIam3TW4rhwHw2pmFE+KU6Mc+HtbiTmkqkKSyoM9MiOxS?=
 =?us-ascii?Q?U04Q/zcqyztaPj+sOABohJYyFgk7De7kgnT2Pfqm7AzvFofz2QIBuirAps0S?=
 =?us-ascii?Q?Mx4WWNduTnwEPWEa+L8/dxp0x5fgxYKmkV5fgaLkwQ6BZvwfUeqohcjaZ3LS?=
 =?us-ascii?Q?M1qc1NUDzd11ZqyYLkYQ/hPtdtmBr0GXJbLJ9dVNkNkpbSAGJHuHm8qttgOJ?=
 =?us-ascii?Q?trzMoi6tUbjsOEWn108OmB6m/1UZPYaBuf+xelw8QM+1+r5QZrE+x4lhM20J?=
 =?us-ascii?Q?e8bEPxHZwJ0DJSaCiF8pyzO9nvZjAvzu0pSMCK6z4rs/HyTkU/Gvh2lfwj6a?=
 =?us-ascii?Q?zXdoIA8CCQ6Ps10bY9Wh4Wy/vHwtWwft4n6rGg0FcCzimHWFEGBUwEYco+90?=
 =?us-ascii?Q?sp9xo6CkOsPQdrxBVFvpSTmR2OvmdlUmFrdmvOAUDE+fTl7sNCqgeLzhsLJu?=
 =?us-ascii?Q?5/tUIz/4wE1JWeq3HiPJ2yNmR1FiGcTDgGycsb5RdDJQQZRd+PiaEyozMaAv?=
 =?us-ascii?Q?jUc8t5ndnPINuxm7zTltd3lkWRDz58kmNnmqL+HGm2crq4UnL8460Eg/q/wK?=
 =?us-ascii?Q?XmYyKqR1Kb2dET8fcnQG1EdsCLjjflpl2IP18U5QPJFGyh6OyxoULIMcQvBp?=
 =?us-ascii?Q?UfoyedAc92gGk4NEfCnEhelzlYjWn1RPVP6Fb8DZE3+pojeM0gXPAbrl+dwA?=
 =?us-ascii?Q?t2DEW7tx49oBPk/mozrYXQKW5IwYuf79wlJ7CejNrH1wRcHcgHINmkSk9Tfb?=
 =?us-ascii?Q?rno4G71WncoPjL2mJw/GfDgElhvVatGT1UbwRALo91+xUwIKMf+h/5NAYzVp?=
 =?us-ascii?Q?wPRmS4f/5Y2f1MfkIlL1L014nlP8zzSSpx5XC39znpecY76frjfAtnfqB1B6?=
 =?us-ascii?Q?kk+kg0ztbHGdx/PS06DvKp2wJAiFIya3iC3IHyGjOu2QNnkrvIMGVFBNWrI/?=
 =?us-ascii?Q?w0Ke9dL6Ow7rRhmULNC6Iq/naK9a/yTVq1MMmnrZm6XfyRuAO1BzfVPFvtFF?=
 =?us-ascii?Q?cLD0mdV4cLXImbPfmVMqQ1QpHdD5ADAqg0KkDtMCJpODNQpBuc/Y/1K7DA9M?=
 =?us-ascii?Q?548XD0mRknIMvCTcYX90T/n/A0TYq4Rieo0WqMvKDPJtVcbM9zwajvjAFJ7b?=
 =?us-ascii?Q?rmtSIfO7hBaMlc4Sx4743R8ifSHFDiqGQF85ry54B0ToB6QnqOXb3CQiGAxy?=
 =?us-ascii?Q?4VwTZtk0+5hO7oMU2opJJBbm+gekFMilo86kbDITA2adq0XiVgWjbf992T7w?=
 =?us-ascii?Q?VScfcVnQgSMla3aCYOpxGxPblzI5Lthho1SaYRO4h8vh9FgXmQ6hS3t8oiN9?=
 =?us-ascii?Q?p1eJZu17TE0IzCJ/aCv+K8WlvhzPTM2M8sbPyBxPQZQRV0oLwRh2lbYSP77F?=
 =?us-ascii?Q?r5cdzs5HnP02oOjzBbbFKByW2zYs9GrKuhHh/bK9tXTgc6CZ+t3MP8etC5IL?=
 =?us-ascii?Q?rpVrOpdPIkqlSnRTq27jsQqvaNTcQo2YXDK+2LaA16vjQB3ZwHiZfTN6zW5g?=
 =?us-ascii?Q?FTJVcr02g4m1IBgl9rU3NjEQwPPYsH8oS82tt7foTnvGHlmqboisn7IR0Ejx?=
 =?us-ascii?Q?oJ2cOC2mBDDhaT8dNfMt0jyIN0b+JDHPQCTzS4UaN/wXLbQ/NiIjrgPZXwPC?=
 =?us-ascii?Q?M9qvUMLhWVYUlSniRZCzSg0OZBoaZgeFcnStPm5B73OikFOmaPZt?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5338.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92d918b9-a59f-4045-7f6a-08df49562ab3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 11:37:34.1763 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0wTanzDsf3+2v8C3DboFDwnotzAfW95ZyAKd8Sy/o9IFOOBzVMyUg7wZStNL5FkQslY8msE3jCLD+/rd4O41Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9187
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Luca,

net/mlx5/hws: fix eCPRI flow matching in strict mode (7810fe8de3)
does not need to be backported to 24.11.

The patch fixes a regression from f2f75ffe14 ("net/mlx5/hws: fix ESP
header match in strict mode"), which added the implicit ESP match to the
shared mlx5dr_definer_get_flex_parser_fc() helper. That commit is not in
24.11. The 24.11 ESP fix (e1edbeaf90, upstream 4237d1efa6) puts the same
logic in mlx5dr_definer_conv_item_esp(), so the helper has no ESP code
and other items such as eCPRI and IPv6 routing ext (SRv6) are not
affected.

The patch also cannot apply: HWS eCPRI support (93c7d4c226, "net/mlx5:
support eCPRI with HWS") is not in 24.11, so mlx5dr_definer_conv_item_ecpri=
()
does not exist there. I checked against your 24.11 branch (af0208c2fd);
the cherry-pick conflicts, and resolving it leaves an empty commit.

> -----Original Message-----
> From: luca.boccassi@gmail.com <luca.boccassi@gmail.com>
> Sent: Tuesday, November 17, 2026 7:00 AM
> To: dpdk stable <stable@dpdk.org>
> Cc: dev@dpdk.org; Anatoly Burakov <anatoly.burakov@intel.com>; Anurag
> Mandal <anurag.mandal@intel.com>; Bing Zhao <bingz@nvidia.com>; Bruce
> Richardson <bruce.richardson@intel.com>; Ciara Loftus
> <ciara.loftus@intel.com>; Dariusz Sosnowski <dsosnowski@nvidia.com>; Kevi=
n
> Bowling <kevin.bowling@kev009.com>; Matan Azrad <matan@nvidia.com>; Ori
> Kam <orika@nvidia.com>; Soumyadeep Hore <soumyadeep.hore@intel.com>;
> Suanming Mou <suanmingm@nvidia.com>; NBU-Contact-Thomas Monjalon
> (EXTERNAL) <thomas@monjalon.net>; Slava Ovsiienko <viacheslavo@nvidia.com=
>
> Subject: please help backporting some patches to stable release 24.11.9
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> Hi commit authors (and maintainers),
>=20
> Despite being selected by the DPDK maintenance tool ./devtools/git-log-
> fixes.sh I didn't apply following commits from DPDK main to 24.11 stable
> branch, as conflicts or build errors occur.
>=20
> Can authors check your patches in the following list and either:
>     - Backport your patches to the 24.11 branch, or
>     - Indicate that the patch should not be backported
>=20
> Please do either of the above by 2026/11/23.
>=20
> You can find the a temporary work-in-progress branch of the coming 24.11.=
9
> release at:
>     https://github.com/bluca/dpdk-stable
> It is recommended to backport on top of that to minimize further conflict=
s
> or misunderstandings.
>=20
> Some notes on stable backports:
>=20
> A backport should contain a reference to the DPDK main branch commit in
> it's commit message in the following fashion:
>     [ upstream commit <commit's dpdk main branch SHA-1 checksum> ]
>=20
> For example:
>     https://git.dpdk.org/dpdk-
> stable/commit/?h=3D18.11&id=3Dd90e6ae6f936ecdc2fd3811ff9f26aec7f3c06eb
>=20
> When sending the backported patch, please indicate the target branch in
> the subject line, as we have multiple branches, for example:
>     [PATCH 24.11] foo/bar: fix baz
>=20
> With git format-patch, this can be achieved by appending the parameter:
>     --subject-prefix=3D'PATCH 24.11'
>=20
> Send the backported patch to "stable@dpdk.org" but not "dev@dpdk.org".
>=20
> FYI, branch 24.11 is located at tree:
>    https://git.dpdk.org/dpdk-stable
>=20
> Thanks.
>=20
> Luca Boccassi
>=20
> ---
> 5e45dcdf1e  Anatoly Burakov  net/iavf: allow flow validation without
> engine callback
> 7810fe8de3  Bing Zhao        net/mlx5/hws: fix eCPRI flow matching in
> strict mode
> 485360e1e8  Ciara Loftus     net/iavf: fix crash in Tx drain on PF reset
> 36f9648dde  Kevin Bowling    net/iavf: fix AdminQ polling after interrupt
> setup failure
