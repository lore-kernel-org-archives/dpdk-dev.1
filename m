Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5963CE83F05
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 05:34:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D02F4026D;
	Thu,  5 Feb 2026 06:34:30 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010004.outbound.protection.outlook.com [52.101.69.4])
 by mails.dpdk.org (Postfix) with ESMTP id 4069140264
 for <dev@dpdk.org>; Thu,  5 Feb 2026 06:34:29 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C3urnzoyVc7oyyjiMWaGLq67wPgabN22FAtSV2xhvL/MZM3qhUYDHMLnTlSE70DQW73BwMEm8hPTj2SLe7Q0arLtQY3YirDy96F3on+++q/4cWLIrRNKUrGVZLWNK0StmFgDb33qZP3rt1ZFy0/53PgossbosbCmo14KI+ShAhLEdCz6wMI2m+r6cKOh2lfuISmAk3JVLxNDaLNQEZ2H6AHVR+BVkii8e49XXMiLsf3cYxNYCZ9DX9EakNvR/wvKnUFmUZ5F0ksRxONns4jpFMgNCG6BlUlF5L6LQf9s9mYyn4yAv+pQtIBGgdCUL/9i+3pjG1yVCGhTtXQoCBqG0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IF1QpnjnBrBjRdyorggXTjiffuoVz3P8mR9CCg+iM98=;
 b=FwJ1/RQuohBTMVcurNOnimswnNhkZyIL+Vk8F+jX2Mt49vfgpq1wYVGO9a8fJ0OsohXRSlRcJisAG7iu9LwCEtIqENUZ2GhWdr5OhR0n8RJ/87DpdUn+OwOHRclt0qGjyHDEZCffYULCUnjdZhWBZJdCq5FX5i0Mlbasp1ptF7lEVRyvb50tk8kXfnn8dnJ0VnOlQvxjrZbAX8AkS+pmAQ8FdvQiT7fNYLyzmILcr/G73nXiIXzPC7GwHiyFRqeRLI5SutPQqBqgzs3Q5pFrkfub2mZ9VlFfttWGV/XhFpzSRLDw1eYbMBZwQZHdaKJbdHEx8M2Bt6evkE6nU43TUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IF1QpnjnBrBjRdyorggXTjiffuoVz3P8mR9CCg+iM98=;
 b=ZZhaeSbCeqxk3rsCBvZwdIRpNGToESCHB2/pq77pZCNAWczoZ77GQG4yncQqPLB9/kovXwNFw8Ta/hQJWfifQdXgPqrhnFsUlFv3KS9GCs9ibklNBXUv0pKUlTTntghqStxixb9jQ/UL2SNUZtBNfmU6k5J1Tmxny2k7W6DEJeuhrDfI/hHVPDLzucj2QuVhPJTYmtDfPNOl+6+fbDQYUqHrSmbQwZBkH2nVHG1mx0pSAecHLVHahsfJrIe9DOGczEhScM1xZUCz55frfuRSTUgpvBZ6+OPi0WMipWwq99JGt+wYPQYK0hLlWiIpZ8tkBnlxfNaJnznSytXXs34tXQ==
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14) by AS5PR04MB9827.eurprd04.prod.outlook.com
 (2603:10a6:20b:652::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 05:34:27 +0000
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003]) by GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003%5]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 05:34:27 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: Thomas Monjalon <thomas@monjalon.net>, "dev@dpdk.org" <dev@dpdk.org>
CC: Sachin Saxena <sachin.saxena@nxp.com>, Kai Ji <kai.ji@intel.com>,
 Gagandeep Singh <G.Singh@nxp.com>, Igor Russkikh <irusskikh@marvell.com>,
 Steven Webster <steven.webster@windriver.com>, Matt Peters
 <matt.peters@windriver.com>, Kishore Padmanabha
 <kishore.padmanabha@broadcom.com>, Ajit Khaparde
 <ajit.khaparde@broadcom.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: RE: [PATCH v3 1/2] license: standardize SPDX tag
Thread-Topic: [PATCH v3 1/2] license: standardize SPDX tag
Thread-Index: AQHclhfVWNngDs3ACE+OGaAlCB9FBbVzlcRw
Date: Thu, 5 Feb 2026 05:34:27 +0000
Message-ID: <GV1PR04MB1075019E9C4F79775ABEED3A58999A@GV1PR04MB10750.eurprd04.prod.outlook.com>
References: <20251112091335.662991-1-thomas@monjalon.net>
 <20260204204945.3893117-1-thomas@monjalon.net>
 <20260204204945.3893117-2-thomas@monjalon.net>
In-Reply-To: <20260204204945.3893117-2-thomas@monjalon.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR04MB10750:EE_|AS5PR04MB9827:EE_
x-ms-office365-filtering-correlation-id: 457281f3-95c3-495e-2d6b-08de64783aa4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|376014|7416014|366016|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?NLpeKM2ZC4n6zRWxQRsnYYf0fcV5a7x7RcDnmmBmqBDTgsV7SY6odGsQzqov?=
 =?us-ascii?Q?fcKQRYggD3ktzXUPUpYcjXkimyhGl090sChFMl3INrjwM/ljpFvLU1nb5/c/?=
 =?us-ascii?Q?Xvz0mfbk2q8evNj7Wi9WeirFued9w3oNP/K11UhozsP4FsbbGE7zXfoKzHt1?=
 =?us-ascii?Q?VP0u9c0h553zuhDMADZ6WiiyUtZL9srPb2wdrMLYY06PwQXp85+x8l87wIzF?=
 =?us-ascii?Q?RmW6021D6kmn7+b1L+qLmWjr98sFaHxcN2S2YrvQ5COMlNxlFLDsVjaYp1j9?=
 =?us-ascii?Q?eeCQ4PQJJ0zyJmM++V7MdGISENT1Pq0xkRSLP120hYc9Al1KY80Tvpmx3zxk?=
 =?us-ascii?Q?9zVpEiUkgmc+uv49nwFFqfodl8wChIzxz+ljilR8TTykz+lbvUuGasDxJw81?=
 =?us-ascii?Q?ld7B488LT1OrFLymsU6vANGniLA8mAE+HlUMgh2TDpXA66qzzLSprFo2vijC?=
 =?us-ascii?Q?ArYjF5jezPx1urJZzpp+UaFnoPmWe9Bhndc+bx77iIccoW2VgDLDFl+2EWAf?=
 =?us-ascii?Q?6YOze38NpeiEzcmQLjO2dMvKL3Zm6evAP1cApNGZ0HcFDKRPVnJ4USr3KsjA?=
 =?us-ascii?Q?bd4KLmrSAnP5Ydaenr86cwqhmeoaHyUy9a+BHS2rstv51gyKFutruHp/ALaJ?=
 =?us-ascii?Q?X63D8HiViZ6HktzbOIGDqSapNxaFuipDCzK6fnMvqgjGavERiKIzgdD0bbqY?=
 =?us-ascii?Q?EFVH8QtWqdQhNce/C5W3of/aBvtrtdXNDHcbYY20DYxUsSO/JETH96yPqR7W?=
 =?us-ascii?Q?Eottd9VPRxV2g9BjYg96+b+3a1BO8RD7UDq9OndtVC/01wgjkLMb+Is1NMyP?=
 =?us-ascii?Q?iQCNhGeG5A9ZrEdEeAsVfLEXZ1O5LB/NWXUnIjV5E8GMyhLOgEBYKhJ017KD?=
 =?us-ascii?Q?EXEeBv4E0GHhxiuZXjizITwTexkXo36h7pPZq7vADnT7PdKBW1B5coFvOW2z?=
 =?us-ascii?Q?yuOAZnFvNh9/4TZ42w2m0fY2fdo+Wj871rRG2ZViOmIAVkMsiVMswpmUuxQ8?=
 =?us-ascii?Q?TobJ/aK9/rOdxZtxEa/oRgcG6M/iKKijlB5nc2BwfWXCqrdRCzQY+YFGC7lw?=
 =?us-ascii?Q?SYJYggPf/tBNSNYVHFXBuyTBotcb4xgmZ3dwUMBH8NgJLcdD8+GB/dlPz48Y?=
 =?us-ascii?Q?hxWIDBxEHkBKaclanxfhYWLeWx3So0zXG2/zMtT9pJ4yuzEW2aWvUi+Jgh3D?=
 =?us-ascii?Q?t9t9v27NLvJKZfxpw1LHd/IQrnEdM3BU5qG2nkr2ObcFWVHSx7GUqQucqizA?=
 =?us-ascii?Q?9E6riz5gEWUSCtWhga5ZbhD9kr81u6CzmRTQKy5zQDQzuDIlQgGGMwYP4oMa?=
 =?us-ascii?Q?YvLr74woA99/ZkbU9Oqz96A/A3EsOeDEMmCLRWuihNrbm+QmYLOXEXA4+6sP?=
 =?us-ascii?Q?4j6IQ5Jyeu2FihEv22qz42e1Wibl4JlEXUpuDufosW3YlF7Dgb/7dsa9kED5?=
 =?us-ascii?Q?etUswSAkElQM2mQWJUcIh2Voo3hdi3IUiRG4iCPWHqUd+ukS68pgIJYzTlp7?=
 =?us-ascii?Q?vtv7KbjV5VAuy9ZV6wfpSe4A3y+IaTtWMPy0ZD8RpjWJ0CQFvsav/2SjIr62?=
 =?us-ascii?Q?BFX0qozTxIR1Cc7MZWcNCHGH6ahw5F/O86zEHeMnmopVCbULsWCRPvcwgsZZ?=
 =?us-ascii?Q?eWtbtHAGln1w5I2oMpqLuJQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB10750.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(7416014)(366016)(1800799024)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rT08/CM8RV7TPZluT93f4xIH6luANqxz4/kzrvewspeaAzQKGhadshY1i1XU?=
 =?us-ascii?Q?DXDgOV7WxWcwOJmbSx9LAdaONhwZ8tpQilETsgV3vGXMtAkjBfLjkUq0Ifrl?=
 =?us-ascii?Q?Italv45Ij49voTor56R8lIR5MPa9oQCLvgqlrzxj8KDX08JIeedXOzyVImpj?=
 =?us-ascii?Q?gNlaA9KYcVzcuNcUlS7WMzKCHyptLvdZ1XM/mV9HMo2hW+SyptoOIvTjgSUW?=
 =?us-ascii?Q?vBNQfGsVz5jVpsqOZfNtjOuwIU/qN46w0dtmUYaQuIm1yjp6qwnFMpD4Zcy8?=
 =?us-ascii?Q?kzEcrH/h8/1BnNiwo5ipLpvQOsFpCFHngYrEY7A0dxqFAqdQp9Mk2lu75L2V?=
 =?us-ascii?Q?8I3922opBprcx5ZlnSuEv1seDv/hGZA76HcqIDcEtdnkBXQeqGYVYB106G+1?=
 =?us-ascii?Q?JRDGm2+gYRZBfn0XoHWDqnAZsfs0WCycTCgS7E9r6r+hCzu7J6wTETjBaIpp?=
 =?us-ascii?Q?qVx1hwLF8BHO5F5H89ug+P1asyK6XkxKCbPXjhxfyFcM0O/ZUAxLgdYgmaZe?=
 =?us-ascii?Q?endrzvoJzN6Lcz+0nWY3COsRXFpU2z+AYhsSf/+Gd15jFFeb+aTaRfB4jNqV?=
 =?us-ascii?Q?pbtYoqIFIJ2oyEt7DLNc/cZ81FRdReZLdDR94b9g22D5ngTK+asQqGFx/SMe?=
 =?us-ascii?Q?OQ3suIHzb/MRPxxTxki1MHj+iKweSUcae+yB77IFC7qqjM6wbYVBSTeUzn+K?=
 =?us-ascii?Q?E6iCseBIH7ojkVVTghUhgAebNtSLaT29hGT9oHDGrv8vickKczEbyt31WdJC?=
 =?us-ascii?Q?S8HtHA0/zY6J6ChC1o/UvDmsffQK7w0bQogdej+icO0aqHpYNbvAgUVJJX5V?=
 =?us-ascii?Q?ML7IzWXPaZXH+OflCuiBws4NZSrJS4gxrGIyFM7SfbOrynLI1kMTExxjmmYm?=
 =?us-ascii?Q?YJfO8c7xNR6ywiTZpF54Q2eMH3UNgo6C/HvzrXzDQ83vTWxs4SrL7Lc7CLXc?=
 =?us-ascii?Q?GP/cGB/gPhbuLKg4yYsUOaGZq2C6PY+oy1hNiXaUNxdXL1tX5/ABAOq48BNi?=
 =?us-ascii?Q?dkq856SCAw46kareP/paNyrGwbAgAKEGTRFxs6x1KSN6XtrpUJzonHtOT0vh?=
 =?us-ascii?Q?mf2yu3IFMPL1ZKslMCpxVP+CSpK8N5b2tZ46aWRTJ6r7VgAedyx/vZs2of4R?=
 =?us-ascii?Q?6Wx81RYQAxa8zvyI+2S4LFHTLz93rw/nq3cpB2zUJhXgsTo/yPgkLxmlMHG9?=
 =?us-ascii?Q?hxP0P2KEWm4GKFKLIYoe6rXaY9LqbO6VpkBx6VXouZGmiorZdOY0BvTm/BSk?=
 =?us-ascii?Q?OOHXH4aBt297cf5+tlpEmKcaOutxQtPm3KQ2dhHgNAKqEKDDaLElp30vsrcM?=
 =?us-ascii?Q?blA/exc2y9KXbBaKd0PlA1GJBGOeGXLLCPi+LWiyx7O0+MTrNtl+fiqwE481?=
 =?us-ascii?Q?vgfXS5qpjC7mzs5YNBQxKSj1JmfkffCyHw3r1xKXMunSkZ3i8Hpxgz+LX7/p?=
 =?us-ascii?Q?VC7P+DLg2ZoQUqVaDSxFCI+XhEpHT72YqOf1wNAZWbczUYw/14j7sG+gPNQU?=
 =?us-ascii?Q?c3HWHXubVAILXZIe6e/QO5cHdlQw2nxxNijtM83u2+BnQg3pezuJCtnRzJSu?=
 =?us-ascii?Q?l3SiiwhYgmPN5A64DG5JuYxxrSFf3MWIMU3qm1QMnYWED/9tezaZcCK9DN0n?=
 =?us-ascii?Q?VcJx8A/1dcMgVjDVQ40MEsIw8q9fW7ok8KN6p4f/XgEqlQY0h4/gHBnTsoBp?=
 =?us-ascii?Q?B13y97iUn0N/vrFJwfdICoT51EzrX/rBjvri6uJAyLJLGiBHihlwl9LLgSnk?=
 =?us-ascii?Q?xveePP9yhQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB10750.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 457281f3-95c3-495e-2d6b-08de64783aa4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2026 05:34:27.5537 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bRVV7MKWuMgK0iJPQ/FbIXljqYSPR6I9B28qTUrlGC00vbMo8qrCiLGrBLxHOL+bhNRe/ZZYnKMxfhHyIUu63Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9827
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
