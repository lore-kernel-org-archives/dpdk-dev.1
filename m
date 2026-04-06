Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1575EE9D834
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Apr 2026 05:05:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DCDEB40652;
	Mon,  6 Apr 2026 07:05:09 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011034.outbound.protection.outlook.com
 [40.107.130.34])
 by mails.dpdk.org (Postfix) with ESMTP id 2AF1240265;
 Mon,  6 Apr 2026 07:05:08 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wfj8dSQRPNRhAfVXkxxj249TsWX7e5oJwnOz+x1zd+8MuvctVtTT3zOdW4nwji1ug7J+DHhDf3AC8fkIvWhFurihrOWInLYdNFlnSdHxNkWEhqSyXDXYSS+wPoS1dX1KVLOAbtCILhPfOcDtWPEfCAM0+uStIvMdma675iFGWMM3YkDOG+X0aGPvMoNADVDqfK5CgERgRkL9efLRiOY5m8serZsPgvj/iNq746CkCKYrVKExBXmz6mlXBrSPZAX1Dj9/OrzlXwNDQHQKi/D7cj2oomvQ3fig9sy1D52DomE7xWy41OAahiFKhQuiA8m8dTEs9jDdRwYgbbo2elukUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IF1QpnjnBrBjRdyorggXTjiffuoVz3P8mR9CCg+iM98=;
 b=WgS5c1w1dxXj/z9JZmPo84SGKWPhQlDMZrEMvHhoNM3Pp1g8U+5Zg5MasPoIqCZjhqKE6n6ZdlkpCrhLZi0236WmOLL0MFL+iBk6MeDIXCzzWO6eI549JZzfvkX9mMIhqc2ZPd0OAl5ZKm3DKSzypw2mq8kB40eybZKy0SPbJLG6ebaBxM2wTN7pqbZF0JYTgs8BPSvjrTQnH8mWAF9sDmdOxbxUH+B0W78WKkfr2QHrGFqfHGJ5dlB1wamLTLPELVAMV67FnT1gwUvoc5Ilc4lY76nUZWheraN/vECRQXj9iv3KwJiI226Q3C0DPGHBTtD3JjRBszeGg+Y/CAVKGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IF1QpnjnBrBjRdyorggXTjiffuoVz3P8mR9CCg+iM98=;
 b=DFxSg95mCWB8vchWxR7BxEke9zzQAmTocd6mZ/XjSuIVH+CBlDWyH/raWebK8IQiG/mwbw/fk0QmGe3JZqqAc072uqJ9Mjyb+Eb8UtXe3XMgTdw8wrD2QSIzk/M5XugJR4Ci/tKGjAXuYeTUQdNLO78eJP6t6Z8AbGvmlomIssbnUtB2pk2ybtL3494/RZdG68NWLY5W8ygQJ49eXjtraI0vkbA39gxGnggFEG4okxYUSSUiOBZShZY70rCcvScCIuqROlfU6zqqfIAdYBjcapOeeoraA2+5tciMRK78IM7nlpIUQ9Ti+QBUKOHB/cRlZa5igyvq0LyVJbfV1zPBdg==
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14) by MRWPR04MB11493.eurprd04.prod.outlook.com
 (2603:10a6:501:76::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Mon, 6 Apr
 2026 05:05:05 +0000
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003]) by GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003%6]) with mapi id 15.20.9769.018; Mon, 6 Apr 2026
 05:05:04 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: Weijun Pan <wpan3636@gmail.com>, Sachin Saxena <sachin.saxena@nxp.com>,
 Jun Yang <jun.yang@nxp.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, Weijun Pan <wpan36@wisc.edu>,
 "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH] bus/fslmc: fix shadowed variables in queue storage macros
Thread-Topic: [PATCH] bus/fslmc: fix shadowed variables in queue storage macros
Thread-Index: AQHcxFc6a5Gz5wc9/UWVSx/K+hU4C7XRfRVA
Date: Mon, 6 Apr 2026 05:05:04 +0000
Message-ID: <GV1PR04MB10750547B3F53F11D96EBE818895DA@GV1PR04MB10750.eurprd04.prod.outlook.com>
References: <20260404171912.48947-1-wpan36@wisc.edu>
In-Reply-To: <20260404171912.48947-1-wpan36@wisc.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR04MB10750:EE_|MRWPR04MB11493:EE_
x-ms-office365-filtering-correlation-id: 9edb30f1-e1c0-4ae7-4fd1-08de939a10c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|19092799006|1800799024|18002099003|38070700021|56012099003|22082099003;
x-microsoft-antispam-message-info: B+y3YlJByCTHuBrbvecuvVK3fUAUDkhOTEV1XBo1RTHXqyvk6attMMJ7r180nImIKXypgrbkB/FW8Z/9PIxsul+Pjb/jX2FZ/6Zi1NaNSpRrVOHGjhmOsixL0WPLdFE9zh7ewvDToL+t4tsvd0lubR/Sh9iwwVFTNhDWpbU4YgCUdy2+AqdL7ZX2vE1CgDVy5k7vqUNvEx0PrpSusUk6MAnMor/tXmztFQp9Ehszry6yHdmEdZYOlTY/tce/71w4191s26k7ONo0YRs1fKbT5LJc2ptj/9jItOF1Wmm4BbyvT9WsHZfodmZibnNh4/nRAamuk15CTVFwHGZIOGAIc1CPWNl/Y4eN0XHLWIjU3uxnn34h1iZgNpYnXUaKKJIak7JBqeOGy/y48EvVhFV4/7t7cbVkwzCHEWrVtzWz/Ec7hfcRoVxCmi5G4QIAlZUd4OA0wLkA2xrWPvbjksiAqk2IaqmVlqk3NqEQzM8f8wewlkiYiBVg3hWeyeNh2/p/6DFGRPq6GB0e26L7skh8m2mXm7xHa3EQERvOV2F0NxJ1doc8ZG4K22sKhycYvfVlbR95Vi+V6fSoNqtpqFlY7mdgL3BIIiRuEWurjgHs4PpngEjhje+zo9VoyyBekWrongGFGVbSoxI5qPvu9dfgdWewVY5h5g1SpVsTHdQvE6MwqsE1t0HW8AqnPUy7MOQwc1EsdYzn1/x4CtzuzXb5o229uilLDKEs/vM14wzQP1ztj9gdvDqRaBBF8QI3CtkniinLHSRY/mcraA2O2o13Q1+ZfHAQZXCCMHjMxwefxxs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB10750.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(19092799006)(1800799024)(18002099003)(38070700021)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IXexoQZX5ej5NPP6gxgP0Ubawmu+mnWt3CPdB7GGGqUmwZHUgJJ7ukx6/wlp?=
 =?us-ascii?Q?mzlCYdFLCBLRETZL0XHgqXhlf/VwiSGy38g/fxVJlRJcNPBlSliWii/Lm106?=
 =?us-ascii?Q?cpnvVeQyWji9dGgNpoGeTwtFAhqn5FcL1ayOtc2v0+/khNZKGB1eecJLPOEW?=
 =?us-ascii?Q?4AXWHDYyk+x99pdclkjxfF/MBjh+SLQnAh7rfHsokg/Smrd0HIrOYv8Inccn?=
 =?us-ascii?Q?bsxE5xq0X7Qf9aRvmfNMGzCx4S19/dTyMxq7Opuwc0vaL57qsOvBNEqMTWWn?=
 =?us-ascii?Q?mG8LgEHt1fp7ksnqEC7fBgSM5rk2XYOUvnQLZ0nN8PiSQizZQQECX0BFrzYZ?=
 =?us-ascii?Q?Td76d/TRuFQNv6K0IBMKkq8MR3/gMD+re7uUQg/L2WQtjD9jCbPdDiv+LnCc?=
 =?us-ascii?Q?k//tZpWiXlRHtRS8juIEIWUnXnR8R8gjL7mfisH7hZsDdApgBMQheDv9sRse?=
 =?us-ascii?Q?NjUzRBObQoFEzF8YrRfphQdtK9O5sduov86egRfpZEy9FojW1/LH4VdRhRBg?=
 =?us-ascii?Q?VhWCDy3TfaKY93UG+v6aJKmt7Af9BdvNmbSV6auAFOfniudVmMBrCuOFKj1W?=
 =?us-ascii?Q?CnEfF8XtM98oxfJ5b1ZkyE0F6KcvCfv2RXeJEraAOHZJOzeljTjFtPLzkOSv?=
 =?us-ascii?Q?JMrx3ckVJ/7SA5HKdALDFfBcddmwSwL6j24Kx5iJYPNff1LmKNVTg6aYCKRI?=
 =?us-ascii?Q?tw/+S4cUIFWoy6mw2x1BLZDSZkkWClmza1D/uHXuv4N+tILIMMTTuVMxQH39?=
 =?us-ascii?Q?bp5U8Mx5DBZjaExguiHQnwmJ4HEPVHzE03vEerVyV2dosS8MZlyW0y95EuWE?=
 =?us-ascii?Q?U7O2OybrxOd2n1tAwpx2cehGj54ltEu+QEUHjtvuVrWQoosnJHKkxivePC52?=
 =?us-ascii?Q?GzBdzGGtyysWeYkfOC3YL9BcDNXm722eZiJ7rkSFjkZha57VAR0JPVUkqROP?=
 =?us-ascii?Q?6pEvpilQHb5q9Wu6Y0uUX46QYO8ng41qPt4q9JJgI/9hwFNv/3rgbb/G9Q8d?=
 =?us-ascii?Q?vNdYfjx9s1tMJIXXxkJN0qLMEjZyxkSmYLDe3Uuh9CjImPQ7O4H6pLaReCPS?=
 =?us-ascii?Q?ymvY57BTLbcSsoy/YffsEIRODa5yPNJj3imPIxX92gupSeV9pJsOgYgQf+k3?=
 =?us-ascii?Q?WDlGCC4IZxpVxyBkHksj2ITi9Lt1owP43/hZChnMx6og/g2aGkd3z/mj2Au7?=
 =?us-ascii?Q?Krtx7kVa9uoHjYZgPBTmr47nMN5Plk9Z4xQgdpnC7CJ+PWW4A5HaNeq4LJ/f?=
 =?us-ascii?Q?MzEr+S2WncVLJrlW7Es1is1YtXy/EwjRJJ+cGjaDGvgc/nTLAq4C81Kns8Jh?=
 =?us-ascii?Q?Hyu2uTLSghR33OR4k5bHwdrDRJLWJfAyCSP+4qf+GpvAnVbi34AUh1JfnmSJ?=
 =?us-ascii?Q?gDDtRZaPcUA3+vmzjhsUyJfABhpIGOSizUXRoTznXtaOX+0RE2bI/dz5FW0N?=
 =?us-ascii?Q?/XoTOwea1sQ3HGGAvU5GfPxRT6zXICUkxctf4u1ltkZNkxTZBPTTCJ1cdsV1?=
 =?us-ascii?Q?C3lMSh1ykoiSOXFZWr5gNzOdLf1QLiRglorjcC39HAK9cUZkpgUB0qScYOKK?=
 =?us-ascii?Q?Sn2omawuRQo8tKpsZeYjwvhlv4rWvYuk4Ynuw8aa0bczYUEJ2LsOlRCdUm2T?=
 =?us-ascii?Q?OTyDPGTh3M5sfockXaP6Jkwrki8UKietVsqBSCDzLcIabWXIzo1ncUdmB7ZV?=
 =?us-ascii?Q?hFrdpWpRH1mt8lNcd5JBhRcoXAAem1P543Xs5Eb+0ROHxo5FP3osNtDgxSNl?=
 =?us-ascii?Q?FVHtKq4Ykg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB10750.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9edb30f1-e1c0-4ae7-4fd1-08de939a10c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2026 05:05:04.8178 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rCn7Q06ksHJiP1RCedp8zWyjuf0NjQDkChEb/U7u22VNx5Ib6DLeZKdhPB7GQiqr37z6qdJA6muAdhkl6epi1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB11493
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

