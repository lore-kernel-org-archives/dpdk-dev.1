Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AECF0E73173
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 13:47:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7B170409FA;
	Mon,  2 Feb 2026 14:47:46 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010042.outbound.protection.outlook.com [52.101.69.42])
 by mails.dpdk.org (Postfix) with ESMTP id 8474A402D8;
 Mon,  2 Feb 2026 14:47:45 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xb7+IDI20nKoE9ggcF6ORaasG2GIhRC5LNYCTjbbjgrcmCdYtgvc4nfbRgEEc7e64ZXSQZWMdOfdIMbai/msXgaj5leCo9D1oFQhQT4+7KndwbUtWQoVZWmY+mIFvUqsKW65UoRXswtXUhR4XlzmEZmZstJ94OijgC0XJS6hJWfxhknoos+Wrc6Fob1DlMunO6iMMXpv2jIp2sY/e8O6MJNYsyOQbs5y9XRydWvGC7V2w6m/7N3bHXeoq5tEKm223EvfMlyqaOtwhF9RIYtKH3A8XmnN+0l6S/OpzLKeoXcUffABjnu6xTxFumUecxuYSdYZftMhZIBV58FRVRRSyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/qIZCLWJxtBVJspTt8CYHPghndEWXPtGFqUAfFW4sgo=;
 b=TMLIP+5J7TaBWwtjSknYh3IIhwOXbbOa1AUFis53+BMqzqRIED5P3GDdL3sIWQKnOkXc5ppEpjpZdT8oaomdGOG7g5yawQItxzsNR76KmR6ppNG5FcdnDvXkCTEYkqqQTMOBRIJhIFDSOGCosEEHGJ4NS5ZsQbka9KopkBj/5Ol1yy/pgwG+Po5ZCR1RO54gcTj/AJkKVRZ+oacHEIp3pikwmr3jSePYzk6lYDExTV583u1I7BiMg7R6uvNX8mHrrblWCribtcWebPzMhIoFXcl51nJ2WR9b2tWYaUJFxkIqhquZJ7PEUGCt9cahBTbajJIsS7zgKkD8Nyv3+a/T8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/qIZCLWJxtBVJspTt8CYHPghndEWXPtGFqUAfFW4sgo=;
 b=IS1biQ4XeJjbR/WnoFZhGg1vYPJ8LKRsrspF/9g4cDSVxWSOCil81YmW/AAWbnqXieXDmTFBurcpGh1XXG4HZ9myD82T3omHdWUkptNe7Gdofcqms+iNFsMZKnAQdZaLgde91lWWySZrj7PAQ4J5Yy0V09XAH+Fj9lcy46EXmnXf+O1G6oz2AVplABGgzI5/B22pXU7R8ic1pFI97egl/D5d8YHLvD+XlgrzhpcEw60g0LUS1UcPgWX94XZSscbXFbluP1FA5wrCnlrezt6IW3wkcO8GtgH6V/sy/HxNtra1C5WPtL7/uzcLOe4VcGaO59Rpjw1Cjmy4UjD0o23Wmw==
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14) by VE1PR04MB7357.eurprd04.prod.outlook.com
 (2603:10a6:800:1ae::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Mon, 2 Feb
 2026 13:47:43 +0000
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003]) by GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003%5]) with mapi id 15.20.9564.007; Mon, 2 Feb 2026
 13:47:43 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: DPDK Techboard <techboard@dpdk.org>, dev <dev@dpdk.org>
Subject: Technical board meeting minutes - 2025/10/29
Thread-Topic: Technical board meeting minutes - 2025/10/29
Thread-Index: AQHclEqBQWpnVuQIjEqkoHZGEzW0eg==
Date: Mon, 2 Feb 2026 13:47:43 +0000
Message-ID: <GV1PR04MB1075001222AFB5527129E3D43899AA@GV1PR04MB10750.eurprd04.prod.outlook.com>
References: <PAXPR04MB932898DBCAC35E1DC54F24988989A@PAXPR04MB9328.eurprd04.prod.outlook.com>
 <PAXPR04MB93289C923616369675BA4E648997A@PAXPR04MB9328.eurprd04.prod.outlook.com>
In-Reply-To: <PAXPR04MB93289C923616369675BA4E648997A@PAXPR04MB9328.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR04MB10750:EE_|VE1PR04MB7357:EE_
x-ms-office365-filtering-correlation-id: 5765199a-46de-4d33-e5da-08de6261a3e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|19092799006|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?S/z3K4iFK2Y77wtrrS3JssXsrHD/HSU9ZJ5qDYzEC0xT/Br8cxC8J3lcqq?=
 =?iso-8859-1?Q?uzBvQEu+1qnZEHiNaIkV+lBwa4kaRWk/4CQyPn69T7TDvAJQeGIi1aqJQz?=
 =?iso-8859-1?Q?WS/n+koxdaxEK8i7fZacH7kw0qtfGb6aRwxgwzTUUALCn5BhOPH87fWcen?=
 =?iso-8859-1?Q?9aWw3Pmf3SJj1wXoGpnDoN2ZZalbr8/4r/GIOBjPUCO8HW0gCIzpZvz68B?=
 =?iso-8859-1?Q?7r3ozWVnXWgbKuqCxrVzQvGvltOCfcXA//1vhRePQr0x5zEX8NLXtfU0wL?=
 =?iso-8859-1?Q?NdgnjHAV02ChXj9VftSbHZPZ+n46If8sMQe2LJ5uO4BA8x3LYnG2K0CXdG?=
 =?iso-8859-1?Q?MUTwNDcSubZZYtIzl7nt5JiU5ZH8ndwx/wc8JmF0O0ZIvEyq1FbaXBpFqG?=
 =?iso-8859-1?Q?4SOCzOAH0ifOkmLHAWtmtjKocUmXWGfNMiShCesk5uW2qMji7lLSSF5+Go?=
 =?iso-8859-1?Q?oS6EeQqncQXU1kpUGtbYw4GR9d5ihysj+Fx64jqyg2vjGHz0BYGww+7s74?=
 =?iso-8859-1?Q?O5+QKSMSd9kp+Qcj6g7AuXo+Owe+Byo/ASMbFuY++cvYnrinTlMjS4DH+Z?=
 =?iso-8859-1?Q?3AijMvR34llwujJlrhNsTN9VpKZgmd/rhipDlXYgEbfZWjzoVEK4rxkvZV?=
 =?iso-8859-1?Q?zIYBSiXqAHBbd8ggtuk3ISCn+15Z5EKcsPOFmKPUFtKgeS71zF+RYbL7jY?=
 =?iso-8859-1?Q?2Xn5PSbsvf1fVsgCcgRggOAHay2502oCF00BauTpP2/CBH/Uq5rbhU9RVt?=
 =?iso-8859-1?Q?ROcJWK36NuCrvTRfbQZqVEFD/DpqSmm/ofbVHkNoudAK4kcdt3lUw6tq3M?=
 =?iso-8859-1?Q?ZKSXhjpUnBUw+ZXHumbNQoBoxNN8XN83ygK+6eTHOLwnl1UQB4Hm68qDQQ?=
 =?iso-8859-1?Q?q6+YKmdNM4UUKbKcXA7pi6CQNeo+kK5anV+ZpPzsG8Yde3x9EQnP6p8J0P?=
 =?iso-8859-1?Q?Xtb8DGJV7O4Klv0E5dlFGvJPIwn/QN6wISFK/8WuR2popj8a51qlnkr1tZ?=
 =?iso-8859-1?Q?rqM2+YJhRGq8V82aAN5GPtIrjfhtFx/cJOXc1USM1DVsR0UyxZ1h8Dcaws?=
 =?iso-8859-1?Q?V9t91k9UXzfz221KokQfaMceaFPS6rz51va+9po5qPSqHb+wifB+ApP3IW?=
 =?iso-8859-1?Q?B73DjcwRQi2q5XnlODEwT3gIdmu0Rp1qX9HRbHJ73pA4BkSu+Th7zxno1p?=
 =?iso-8859-1?Q?Ar8UHg4w+tN3mg8HJHJ8JXWU2oKPhaOJV9WzqIYdLVVSz+W0jH1MkGxF2U?=
 =?iso-8859-1?Q?1wCbP7EhdBNsqZxH4yU6DXebg4qq6oLacrZI3JStDAxwJIgqhSFkqaYRW5?=
 =?iso-8859-1?Q?KO9IlfvXcWI5V5hXxo9zvNvDpjVo6CqaQ69zvyKX86Lv6t6u97Iz8Jjpn/?=
 =?iso-8859-1?Q?B6Oa4KUkHtCF4oQjqHkgXBBj0gL6XnawBjBX1QPdF5az9X5a1vrdtdLqOI?=
 =?iso-8859-1?Q?ULI1H6tkgWPkdkXJRR0ohrzyF/FWYhVLLZsKEqw80LnT+bVUDX2xLUajjH?=
 =?iso-8859-1?Q?faVGUJeC6Heo0H9ozNMLOk3E4TdiZnNvLgBI/tkiuoCNawwgee0BJPOEAL?=
 =?iso-8859-1?Q?5kcEU4VVepqlwVcEQ7xc3kFY9YjM/bu6CFRfU2aFvAoTD6WejmyyMosRZb?=
 =?iso-8859-1?Q?mUb49PiXJrkIaXQdAxrLNHIZ6anyEpqDCNhj5dKLd8z+ct2aDZCARHlkrh?=
 =?iso-8859-1?Q?ORSL9VR5GuY18bdjXhg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB10750.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(19092799006)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?beifA6LQ+lz26VIGRCI/tA7ysRcmEpbc7l5mIaroDQW75sdH9fHLKHYeEl?=
 =?iso-8859-1?Q?tj44+cebDWiNQhOJb9e0XqTl0hbwmYElx4okk6rFpT0EAuHP9vWHNGH1GE?=
 =?iso-8859-1?Q?0EtQq+wv3aniDL6/IS6+MDKr/InJXanK/LCgdGSUxzDWvHKCVswa6Lnr5c?=
 =?iso-8859-1?Q?nURl4GHT7QDKVByMuZVa2/HHXjzq4DmjoBivVn2y7vanHhvSKHg5c+FqhR?=
 =?iso-8859-1?Q?w4kWdBEAjwGNgOT3iLWSSHharow6Y71GYQnXzPIgrfdtudBvy2bo+OWBp4?=
 =?iso-8859-1?Q?3r3vVuj2+2pm9wVPhajzXHTtzaWeUB0OqsrEdQnVh3iVDrYTKHALXbxPtW?=
 =?iso-8859-1?Q?v4/kKLJdm9HYBSxqFOnYJoQk2E9hSiDJ2slIdicPJoBkZjZuR6e8uawhcb?=
 =?iso-8859-1?Q?v3YSPh9ysj2l02Zin+OnhlbH7ps4GUWujyhinc7NWCMnURXVoS3DdJR4UB?=
 =?iso-8859-1?Q?+BS5G6yEdH7mF0F6wmC3SY/wHHDsIu2lBuu31eLihxQqoYows/Q95IIAOv?=
 =?iso-8859-1?Q?BGk6jFGFTCCK/TlWqYy/eLaBBGfkKSpG20M66/dawkqy1FHS8DS0nanuPU?=
 =?iso-8859-1?Q?oVhst7gi5puPKggC7ZCVKQVvnC1yQd1ubpixWw4Es9Y43NGT6M3bnvaX3y?=
 =?iso-8859-1?Q?Q57IlypoCwLIQDKg4J4cTOTfpi055lTM9V1qPS6KTHyokPxTWg9opz8oYr?=
 =?iso-8859-1?Q?XlgV34iEhmfm+DrCKPINVOfoP647quRwcsdIBheFtLTB89nfPhLUAjRDm4?=
 =?iso-8859-1?Q?BiCao0NBhKfmgqMn4ZLUdrRmmLCj4oq+ESKmRXW7ytrbSceJu8942iWbyG?=
 =?iso-8859-1?Q?Y3LGK2omZX2e0dpUQORTbh1J46EK2xIxIjs+9jLG26xmzc/1YP4MvDkgm9?=
 =?iso-8859-1?Q?gmlbnRGWm13+VDSXD9vr0Wq+RtGZSTO7/dNmPQ87G+pPzuQhuKjhNjgBiG?=
 =?iso-8859-1?Q?rlyaFFJIUBQV7WXcvvLjaZfvDGJ9dfABoL9DV7jq+LR3EuBA3fwW2MSaVb?=
 =?iso-8859-1?Q?9hlUoeis3I8KuGBuqz2sUc0iwLVi58R08VUylafQeKuf0H4Wy+mslDP/V9?=
 =?iso-8859-1?Q?tOUzOf5zNG6cYS4UnGIXbY993YDW0PX8F9DLKbyrNcUqfOgfIO4L+P6oeJ?=
 =?iso-8859-1?Q?FJ1p6Bsb0RQW7u6ltb+RUlKoTgVgaskdBfpuhu2FrsE2szKQNRQ+snzle2?=
 =?iso-8859-1?Q?ArDDhSTkGzdruD5/8h4FF19PF2OwvRK/LW+ZC2Ot+Pn/5odsYNXgAcx7bl?=
 =?iso-8859-1?Q?KlACsgQkQ6E2bF4VqVvLhm1JKTgFOVdo9R+0u9uQWvUBXtDdeDP3v8oTdF?=
 =?iso-8859-1?Q?kFZMj0ysXOh6MYuLazG2JDwnGAgrKocXmr6sxWXHDCYOa3LGqAQpwFYA6f?=
 =?iso-8859-1?Q?Ls3qzXHLVk2MomQpBMyawMSMP0zdvGPj05TrXqqQpxiwaeUjkeCiHG1OMi?=
 =?iso-8859-1?Q?iZlGrKmqBUUhdss2pMUtKQ6SxRdd5b0RYZY6idNG2ykgcV7/BJUoHS8qc/?=
 =?iso-8859-1?Q?Q/bVaJoTYVFN5CifHTW64SXb+/zk2cyjsDFPo14nW1HxGFZT38AhCM9JO8?=
 =?iso-8859-1?Q?RejjYNqOqUf+R5EwF0GtXXWaFoawnaon406sKF8PJQ0y8hVU1+pRcMQvcE?=
 =?iso-8859-1?Q?B1eAKET3sQ9NSFoyhA4V3T3nRtFoX4+64ZAxHA+Use2qI3Xtkub3mWgGc9?=
 =?iso-8859-1?Q?5Pa/QEdur86dQS3q0htoVqWpFgM81Fy2cxAB/3kTQr68oJEKyTaa/XwHL5?=
 =?iso-8859-1?Q?t/ckBxrx9FnkMGzK/WrsAY+tmSzoHxwu6JeoI7EsosEGfZvngBTw3OTUcZ?=
 =?iso-8859-1?Q?p9ZcDZj71A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB10750.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5765199a-46de-4d33-e5da-08de6261a3e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2026 13:47:43.3871 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /pfkwLqma5mDrXQQ3AEZffwg/xFPipWsCuzN2Wipcv0KphhM5o0U7AJHRxMhTGwCD8ojMWOX/LNkrxm1dG5wPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7357
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

Technical board meeting minutes - 2025/10/29

Attendees:
=3D=3D=3D=3D=3D=3D=3D=3D
Hemant Agrawal (Chair)
Maxime Coquelin
Thomas Monjalon
Stephen Hemminger
Bruce Richardson
Aaron Conole
Konstantin Ananyev
Morten Br=F8rup
Jerin Jacob
Kevin Traynor

Topics:
=3D=3D=3D=3D=3D=3D
*The meeting focused on planning the upcoming Tech Board Governing Board jo=
int meeting, including discussions about the Future Roadmap, AI updates, an=
d DPDK 2026 summit logistics in Stockholm.

*QStats Removal Discussion and Timeline: Bruce discussed the challenges of =
removing QStats from XStats, explaining that while the public API has been =
updated, the internal API still requires QStats due to over 30 drivers rely=
ing on the automatic conversion feature. The team debated whether to remove=
 the flag immediately, potentially breaking drivers, or give more time for =
updates, with Thomas advocating for an earlier removal to allow more time f=
or fixes. They agreed to send a deprecation notice to driver maintainers.=20

*Test Suite Voting and Improvements: The team discussed voting on agenda it=
ems and Patrick emphasized the need to complete voting by November 12th to =
allow time for preparing a statement of work for the Governing Board by Nov=
ember 21st. Thomas suggested adding a new test target inspired by Gregory E=
delson's proof of concept from NVIDIA, which aims to simplify test suite co=
de. Patrick agreed to include this suggestion and noted that while the curr=
ent test suite writing experience is streamlined, there's room for further =
improvements to make it easier for users.=20

*DTS Testing for New Features: The team discussed making DTS test writing m=
andatory for new features, with Thomas proposing to start discussions by su=
bmitting a patch updating the contribution guidelines. Patrick explained th=
at while CI automation is already set up for DTS testing in the community l=
ab, they need to address how to run tests for new features and improve docu=
mentation. The team agreed to focus initially on functional tests rather th=
an performance tests, with Morten raising a security concern about potentia=
l abuse of CI resources which Patrick will discuss with his boss.=20

*Thomas mentioned that RC2 needs to be closed by the end of next week to me=
et the goal of having a release by mid-November.=20

*Kevin noted he would send an email regarding LTS volunteers.=20




