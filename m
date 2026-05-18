Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152EFCD4F48
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 May 2026 07:19:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DF5C6402D9;
	Mon, 18 May 2026 09:19:52 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013030.outbound.protection.outlook.com
 [40.107.162.30])
 by mails.dpdk.org (Postfix) with ESMTP id 42D27402A7;
 Mon, 18 May 2026 09:19:51 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OscMZtNKyGymkbmLn92hBcgKO2hHUi3hoC0LT+cnBKpfSe1EO0MXSv9BvkvcJP4MxEJSOCVWBFcs9cE9/B1HrpKpMLORfrO3JF7ZNRTsoD9zSa4h7Ro36wV08tNeHZAbwfjUIKCfOP4Kss7P43quSKaqoFrwVwG4FNRi2gQz7G/4LyFCg5o6C7J7AgmyX5nJoqYheWRY8sumZuntVYYe4kDej3sUdMFikQoA5RrcxbhjUKK6HVRTPpCSovsloNNSaWW934yIRJDF1THLCn5Lpmb//0YjRSpUVA4WVpUhOhyUqns8aMlVFmmxjfthNuPurJzjs5qgXJ+nCpKN0CxsXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2cBlK0qIqibF+HkyzK6SZ0TXPxJnhbzwlNS7poovZE=;
 b=yqw280OEtgdVhyecUsivxhmEyA3sUb7yzFJsgxEYg8piW6HRon1do9DwQ1BmVahzNOjQNUGL3NDXu6/ZqGEb8k/vx0EDgOesmb8BLVwXXiEACf1G370MmuVBoHnpf+SIyfuKVFGqBKwYTlIVJLlY69Y44mwFi6pdNqwZuUUxFTWyUKEtuNOnVr6UA1Fuc3j9Kx+WwSYrEJqM/NrmikdrOfOPQSgsj4sN4mg2lF/IU4QFqORxV6wTTbCPT1Pusn/f9LcV+UjOcwOP394FQj3b9gJVi/k4phGYMssySmMKXyiJNT1Bcdc1ltPicrHQKDPQZSz2ADo8ciCtLBrj/xcfmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2cBlK0qIqibF+HkyzK6SZ0TXPxJnhbzwlNS7poovZE=;
 b=Fpyn96RgMqGpxQthuxStasijSq+h++LjbRaYqMhEw3kTZU+AW4uczY6h7nWlQkC4FzEPPzSBhd3Y5/7/WFfqkTx5j2TaYQ80gNK+k56+d/XQRNeYaoUPmzZ6XIVOtAqZ71fXrk1HZgG6coTpqHZBjWp9JgzEZ5r11kq2wY8BTb3L2245ogNqAPrKOA0jqU+16oLFdB+6k6daQlfWDy3N1jt+NdUrOS8uDat6NwoXwOhb3ALVj+Yz5xcchRwezyl8iPQWd3dtxwOJOEH+0DGr/6ZvjEhn4nuknCpWrySzev70yo/h+AXRvTJCozLv1e4WY+4e/Sk0r+Cz961cn/SgDA==
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14) by PA1PR04MB10120.eurprd04.prod.outlook.com
 (2603:10a6:102:461::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 07:19:49 +0000
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003]) by GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003%6]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 07:19:49 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: Md Shofiqul Islam <shofiqtest@gmail.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH v2 2/2] dma/dpaa2: fix dpaa2_qdma_remove always returning
 success
Thread-Topic: [PATCH v2 2/2] dma/dpaa2: fix dpaa2_qdma_remove always returning
 success
Thread-Index: AQHc5SRYP6mH1Ke4LkqYANVtXDlNcLYTYwvA
Date: Mon, 18 May 2026 07:19:49 +0000
Message-ID: <GV1PR04MB10750F15A26618AC70087E72A89032@GV1PR04MB10750.eurprd04.prod.outlook.com>
References: <20260516110828.35701-1-shofiqtest@gmail.com>
 <20260516110828.35701-3-shofiqtest@gmail.com>
In-Reply-To: <20260516110828.35701-3-shofiqtest@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR04MB10750:EE_|PA1PR04MB10120:EE_
x-ms-office365-filtering-correlation-id: 72252961-1b7e-4a56-8362-08deb4add8ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|19092799006|4143699003|11063799003|18002099003|38070700021|22082099003|56012099003;
x-microsoft-antispam-message-info: FfzLqEvksQMGIct7htY3KoA3QaDSCIJ7fFVle692bDQmQLDJ67MdqdEZQ4fkgnqsfl0QksfPd+XwndWUsnSwL4X0Vm+3ENBFAQ0S73kFFLBJDmTUiDF2KG+Lu2mj0MJmnVV5VwM0Nlmi5rctevCZ/brPSI43u8mK9VoNFAl1jvcWi9M4S1a7g3n+G3qLhCcT+Y5U6QHp69awIpvcSeoTdQcsoW2r5YeESd2GhE2zL7gZEZKr8Rt7gw/zVgrwt/HIWWyyvDgSKTLqcq1+P/GCA6Jc/iXzghOVN9ijQXEEge7D5SqU39MKkMxWw8pekpBq+tG4D7LZjyJJiH9D8D/hax4LTLS+ul6lCFHz5n/8zkLrnt6Et1wxUYnkkN7xOjBb7bbVv+q5SlifedxXeQ0pwpx1V8jmskVrRGKmsDSjrSRL77MBBW/s1Z4F4oS5mVhXewoRsGrCsj4fNpH8jHP1HdDpQ8+82GrRtxoNfw29r42Zaui0zZEJGZv3O3mo3CF2xBjgUaXdGGhfFF/NbFKMFh5uM6X1O0pDuuQ3p7LvgtXZS8/Mcm8SNeVFVycVIZqlXhUtNtQxNvmKUR8gXek6DH2DrcockkBn2QpdO86Jj5yUUbjB3XgltQm0xDwosf6p3MZ206zsSoGK9d5J0rZJd/r5u5QXqdjj9pBXqnjn+A3e8DNpSGTo4Cg2203dp3cy/3RxvQZqrc3kCsLwHKROgXGrF5GoFOoiK+AeOqRRtQjWEO5+ubLzUO2O4uxneKfK
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB10750.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(19092799006)(4143699003)(11063799003)(18002099003)(38070700021)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?J+ae9eS66CsAbGb+HdA2ET4VC2NT2EckTX3+dc971ZNSfv8f7xz3SYgRT1rM?=
 =?us-ascii?Q?KwFIQmyBIKgH2tmpVJQWe7lgGTtk53Vj9pJPcZYfRqJ96P74F2DaM2W8rW/q?=
 =?us-ascii?Q?ilKqAC1HHaoQsETmN18jU51vDwaC2/xH7WudKt91UypCp50Ntnu9VuR6tf4v?=
 =?us-ascii?Q?8zBjp+NsGu52prjvF59gpUngZBks5PG5PB+p7xrTnz4Hui4XZZ/wKTQwhkNN?=
 =?us-ascii?Q?WXEgN0wp3fx7zErohOK22Gq4Kzpi03A8CBDJXnRkVdMyCinXMKepeIrODVfw?=
 =?us-ascii?Q?urmXT+oZJtfA3DS7jpA5wUGX8sjAIEOFZ3/BL2aT3iwqwwETAcLbeHaz+l2a?=
 =?us-ascii?Q?VwYeI7P2hfMRQsxDLedGh9R6tdeEu2Ap/yFtisZhc1YFjZSZ8SKYgfjNrIQZ?=
 =?us-ascii?Q?NoGqxdd9r4QC+VctdTUQaqHJegU5fRn3/tMMus5zP2gI9DydeMgerYyMiOs6?=
 =?us-ascii?Q?6WNT6497/P5XSCzq3+lOg8RrhSQ0scbSgLGuLeLQlaXSMOF2OSP0HUinyqw6?=
 =?us-ascii?Q?jfjxEEF9tFnBfm6qApxeg7m6blEIbiSGs6Tkw5P2awRAgJAd33IcedQA1S3v?=
 =?us-ascii?Q?Y8q4l1mZ7c+gTooa4ppBbxsOn9ZVaFQhYtpg1sOA+U4mw0X2rXeRJPC00zFS?=
 =?us-ascii?Q?/ay4yibItZOUTka2zltkZ/vBvcjyLmgSMWjkJyTg0F7UToJVG8RpKbpMs/uw?=
 =?us-ascii?Q?Nxg4rcmMkEaz1ocDrULsIMRp0DdDfe5T16UsDBP4R/hmu5GF8kWQRtbJ+Hyj?=
 =?us-ascii?Q?i3umkTCUyaOtEB1c+hSOpclU5tmUECIoQF895tDVGUkY1UArlEYv2QJ6en4k?=
 =?us-ascii?Q?kUzS7wQhnerYt57tvfk5xyly37mxC89Y8i4isRcWxk+9xgw49DQQu12olQbZ?=
 =?us-ascii?Q?qZVM/JqL6Yb/RD25JA38bs72akYzq/EBU9jBBESzbtB863lttb93bsoOCEy8?=
 =?us-ascii?Q?7Uw+9hupNy4aWETVar3kFW3hkouTZ2/bqboRyteOo6F9DypKp3rpHGVs1o/0?=
 =?us-ascii?Q?DelP9aQcCgq1lQHlPHirs1e/jDLb8QJhuqKg4xaK1YiD4uc3mAVpalmfzeIQ?=
 =?us-ascii?Q?ZXRltk5rnvpPLX03tT3Ksv/6IRt7Gne7vX7w9DpflXL7be/RZlzgrX2A36Jr?=
 =?us-ascii?Q?q6H6faS5ac7FLb2PkYSjhERH4JCJJvSVok8fLlszlNxnZ2d+jawmTKhnAoEJ?=
 =?us-ascii?Q?eVJNW0YhlOBzf/73aMm7R1SQpxwLWXIHvqr6Da0MpZZJAtpEM8TT0SfiNbtm?=
 =?us-ascii?Q?JQatrIMN1DBr2TSkJfnHc29EF2npzo55+iDYvp8UOMCY1LR9gIoytfqkGQsc?=
 =?us-ascii?Q?OteKV1Xon73fXg2E5pQlQjJgxg8p+DDHXHx8MRv9u1r7XNi99JN+4HAFC/X0?=
 =?us-ascii?Q?1rHu7bH6QDFLFdSni08ReBWi0vjlA87R8MBqNAbOMyyfyijdF4Yqb9udLm8A?=
 =?us-ascii?Q?53IkpocabjJ1MpxA4j4KwLGtaywUC49TOwkaTYwO9Y/JrHD2zzXImaqi3bsO?=
 =?us-ascii?Q?aGML/G1qGamEBnfSpnHxwFHYrNeHnOqIZtofseoZCi0gt642I5H/EylIi6m+?=
 =?us-ascii?Q?DhCKD3J7+THlJXIm4n+6D8/cJ4G9C5aQo1OdGT8dZjzyH4KdcEKrjgkCgCxr?=
 =?us-ascii?Q?AQyKqXvPwaInn5KU2YDZoids8Cks3kpHb5jZUZt1u8zR5OzkBAA6N6riov1P?=
 =?us-ascii?Q?lJgFnYbUrQusiobVi84xsyhuelDwxL/Nzu62yrXlG0R+y8avM+3ZP7/vbxp3?=
 =?us-ascii?Q?QmSGLiTasg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB10750.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72252961-1b7e-4a56-8362-08deb4add8ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2026 07:19:49.5526 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gZLXl4lOPS2U8U/sZJkCp0dZ53R2uPNs6whprHT/YXZyhEBc3X4puWLoRgxqh/0Jhc4Lr2LffJ7h6D1RNv4Fzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10120
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

Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
