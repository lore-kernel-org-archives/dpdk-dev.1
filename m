Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9CAEC2D0CD
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 May 2025 06:03:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9379F40613;
	Mon, 19 May 2025 08:03:06 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2046.outbound.protection.outlook.com [40.107.22.46])
 by mails.dpdk.org (Postfix) with ESMTP id D56ED4060C
 for <dev@dpdk.org>; Mon, 19 May 2025 08:03:05 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JJoFw4SA4e1bfINf0Yj1MxZO3RO7MgkoH3+cM8uMfId0OXu4hMK7I9ika0OZ4l/pjcOSb2Lq0VOyfewWEwPaXwAR+VcPLYREUyYexiq0iqRbVsj0fvpX5V3GPjjit6/FqynP9AdBg6yHnFIRV+oHoMB2jme+k9GjjJA69GDeoD8rGZyZR5ppXuirn4sntfKr7olWrUfS2NxTofKa2unPe3CubMjJruvMZqfga+EJE5GzbVmMCvZHC1fbGzQhRy8ZrPCjU+UKGkX7zvbIqR8HPdSJUH+SuVU1UTE6S/cI4xAxCqG7bYxuholPGGBA9ghBO8ZlzLZn/YZvHw++4KfctQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQujpU328GOmPOtqFVYIuEFkVKs+EaYqmxaFAHOdqjg=;
 b=s3hhkzk4kmdzZ0289HlDQ6gzBuOZBb6XSkM2XX1PSi79oA7VyF7+mUtBfiLWkJ87fdYZonL3XIfdqYWM5UvNyMIAgPwi/vXBITdDOjw4QlSyM7Cr607Ku09aGHyV5cpCVu1SqRLRFVP+v43VZbuITXCTchEP6d1O7R2jso/wp1Dej5pJ0k2SAGscmarblntQ2PCXxJCn9l+wXRFTIX9FVsHJbPFR8h5Bctm8UzbOPiN7gRG9WVLzRG9ZEWqScC6ABjWdjLFhfayE1dTQ9fD958kS9Z0n/klLS2GTRGBIcqZ9IAmfGMTIgyhDwzoJ5aGuwOkqELQDpSBTeD1XXZJEQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQujpU328GOmPOtqFVYIuEFkVKs+EaYqmxaFAHOdqjg=;
 b=iTMm8uY8HfpJW/jawp3C4IEM6ntXoE7v+ldaAPiM/8LWa2i/Pa3+i9kEPdsm8t+ezfALtbjMn/w3KpbfzGIgWzssbwv3Hfkf+uQtRKG0MXwXDPEiqfDFxpIttzAFp/B0FpJYxWOC9ITYZS9tq8GDKc2SIeZjQTIpkA2X5+Vsk0ktQQmni9tYW26IOu+XOMO9M+dn+7OECJPQUZHQeDsVDZ0hxcSAl8Ov51xW6f2xbYw/QuQByjhZVhMEcibaMP9LnTvO0ejIWpGGbZOh2HbOEIzQDWEUBiD7kBbB2QtxGd8WOQc8uhTWmoaL6n1chv93DKmpcSMGwz5Q0JHb5Obc5g==
Received: from DB9PR04MB9332.eurprd04.prod.outlook.com (2603:10a6:10:36c::6)
 by PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Mon, 19 May
 2025 06:03:04 +0000
Received: from DB9PR04MB9332.eurprd04.prod.outlook.com
 ([fe80::fa13:836f:3caf:c7b8]) by DB9PR04MB9332.eurprd04.prod.outlook.com
 ([fe80::fa13:836f:3caf:c7b8%4]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 06:03:04 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: Anoob Joseph <anoobj@marvell.com>, Akhil Goyal <gakhil@marvell.com>,
 "dev@dpdk.org" <dev@dpdk.org>
CC: "suanmingm@nvidia.com" <suanmingm@nvidia.com>, "kai.ji@intel.com"
 <kai.ji@intel.com>, "brian.dooley@intel.com" <brian.dooley@intel.com>, Akhil
 Goyal <gakhil@marvell.com>
Subject: RE: [PATCH] doc: add limitation in using segment-sz in crypto-perf
Thread-Topic: [PATCH] doc: add limitation in using segment-sz in crypto-perf
Thread-Index: AQHbxluVj2ssZdAUakWh4Kil8kC83bPVVF0AgAQl92A=
Date: Mon, 19 May 2025 06:03:04 +0000
Message-ID: <DB9PR04MB933212489C153DFA34CED89F899CA@DB9PR04MB9332.eurprd04.prod.outlook.com>
References: <20250516121043.145572-1-gakhil@marvell.com>
 <PH0PR18MB46722C2377C833F92C728E30DF93A@PH0PR18MB4672.namprd18.prod.outlook.com>
In-Reply-To: <PH0PR18MB46722C2377C833F92C728E30DF93A@PH0PR18MB4672.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB9332:EE_|PAXPR04MB8459:EE_
x-ms-office365-filtering-correlation-id: 4abd7149-446d-4276-1517-08dd969ad197
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?VpZlsXbAhOzp5r93YUT25M0027d0FLDt/KAZsHXVwT9ocAz0BBWprkrxypDD?=
 =?us-ascii?Q?a7oHh72IIEte9NPfZurl0gV5FI5C4b667c4EVdKN3/9Vsg/sVDGkFcGKqLVd?=
 =?us-ascii?Q?n5t9foaVU+mpIS4peL+TDbqBN1Cx9Lvlm/uHZZIHA0k9lByJzolIr0smYgsO?=
 =?us-ascii?Q?yYLY6Tblqh+QCZgV775i7XsjPWMzYlwA0e4+sXHxakMiKQeM/CQr+1P9QTWy?=
 =?us-ascii?Q?VT+JCLSXDlK2A/WLkWu+IMUXbiVL3qM7mxY1IyrflnnIp/EZkko/AwPJkWpx?=
 =?us-ascii?Q?vVK3A4yFjPm2JW46eLRB8se3cgCElNpHBXo+1yz1sCt1+wEuSqohZDD/tklz?=
 =?us-ascii?Q?66nwNLoupDZ8ygXMe/EKTj2+jL1K97aT3yaY+eaAX7EHCxFmlTB80/4qc4ZP?=
 =?us-ascii?Q?ze9VnQ2G+lbZPXoMPBmCf7OQvOJHf37/+fSrMMTKMyoG1zhLKqd5T06O7IlM?=
 =?us-ascii?Q?5m0PgWoyCASP6Aoti1bUnGrOuQBKliezPwBMRb64hCJLuSqOOBFMca9W3lxF?=
 =?us-ascii?Q?FA6hw5MgS/2fuBOxqM4IEw7ffLzy46Qz39wXUnrOcOoD8e0tL1duhxuHx6uh?=
 =?us-ascii?Q?aTD+4gFK0XBuGTLPlotHC/wWYQX5AUHNoWuvQtjCG+uPijgyC1rdkjQfw4LS?=
 =?us-ascii?Q?bCmUNZmLMjbgdcuBA3dhNdI40bxsOMuh6+tn/vJ21VKICNJSK0OSxq0HB0pi?=
 =?us-ascii?Q?rufll30SlL76mHt6FfcpdBMP0jEHbHgZkJNLZ5fCr4yJEZx8fKLTvJ1jehWo?=
 =?us-ascii?Q?6XlZjFoXbhfEu5pO4djJSsVfA8nqNhSE976U+N+1LcgdE5WTXp4Oh+teiwuR?=
 =?us-ascii?Q?sPfvyJ/n8R4cFdXdeE/u8p7gY7fjwh3N67lIzwzDnT5siIwHw3yDXfdOJH1D?=
 =?us-ascii?Q?4prBq5sIY4g09k4F+a25DjR3Ny4RVh2TPiJE8NlCkjJ76s3MWQbduwZKKZEc?=
 =?us-ascii?Q?nKtB+0IZSzwBFgNz7kVmN+5OgLhdvwnhKet6oF09mvBMofPnjFWIA20ULcSf?=
 =?us-ascii?Q?GxVsh1afqkl8BZot4YhAvifjHLvSg4YZTTMEojrtG3YVt8h83F9UZkasXLvp?=
 =?us-ascii?Q?VuKdfv/wgDNZHN0P1x6KdyEM3F5msmgykL/b00hKDbXuuCybXRZIYrCz8Hox?=
 =?us-ascii?Q?6mMNVE9zm9r6+1g1LJyqjVsQUW6S+2c8P6YB7F70pcdpPpwRj7K7F95v5ysY?=
 =?us-ascii?Q?kMSHUbhzn6V0k4Rx0zn+dzuWjRVWtlnSTOIxMeYnb8rI6vpEVJT/Xs+bVRj4?=
 =?us-ascii?Q?tzqm63TdOpaBqOmngDcqb7NiZGo7skfgJ64wmKFL89xl0aaZ2BqYwsa85HEN?=
 =?us-ascii?Q?FB1dqR3EpnzGSUxOmgTHCR6fEdL8UtN9b0zJCpwT1uTCDOkcwSX8XmwHM7s8?=
 =?us-ascii?Q?4mhSXAO0M7NZ6xzFEbJ3TbgMSYYw4ev+vzRhSRFbtHMMuSzkv622A5G8qjcj?=
 =?us-ascii?Q?jWWsEX3tcElMKsN/5iMgYcfYIdd12+Fo9bJEp7TIORB+Iw4TEXo1SQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB9332.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KiBTJ6/tOGfVvj2xlwwSVVJyEyjqYBD4BC8Zd6fa/rkVdlGOp1owF2y5HOdo?=
 =?us-ascii?Q?Yde0Rg6tVLWMNlr4ZOw0vYXhSJpyP4Gj5IfySydQui9G1WCymdNOhATwCbeP?=
 =?us-ascii?Q?Y5STqxBcYmJLPwkUHrnoqnplkVOQk8d2uxvxXHcIxejTd+XwAB0bnNB7IYLp?=
 =?us-ascii?Q?mpNjD7Z1vrujnpp7z1Nlmx4BITLoi2UoyAPQixuqF0GAjxQqc/LAdGT+81VB?=
 =?us-ascii?Q?IikzE2LxJXm07seVCb9lHFn/VuGtBSkpf20pxXYOU8RSL+MVsvRr4uueL8FC?=
 =?us-ascii?Q?7P0L4UH+Iz+VdmDKzbeUU2XWQJlncbirlp2ioEEEBcRv/hofAJpCVbkn41HM?=
 =?us-ascii?Q?6OEBIj9OxS9qzekoZ7zCVML53SJKTwvMj0sfGeKorqb0411iM9+cSUS/y2I4?=
 =?us-ascii?Q?jfnot9FsTnE73awCjKaVUikV1LS2Jntd1/ffcI2vvy/sWDEaJLyChxz/06a3?=
 =?us-ascii?Q?SxK6bJ63ZbZLw8NklsLwr0GAg4+qA27p3PB5GfWZgThag+NBgc/ux0XKS+kU?=
 =?us-ascii?Q?5TJwm0tmBLopy5/EKQ4oUwU+y5qOkrlyBquTagKRK0qt9Ld+aOXOM6k2Yu92?=
 =?us-ascii?Q?s9rYBdbV1ajpbnlrW/ipHVqlW9ZnHcgKWFF+8EZeVpXBysXfqVYGPsC5STZZ?=
 =?us-ascii?Q?vIliQO1LjNBMu9UxCe0H8oiuecC9rS1ZWceWU8lqqbW6et2bDU845HX2F2gy?=
 =?us-ascii?Q?m0vu5Kik4M5rKHF/8e9+hROKBWdKIyJFEvzi44ZwEM11NwWHnAzSmU3+4sKw?=
 =?us-ascii?Q?erwLlDZ6cNkkKQYwM9qDFH481qpVz4g+164Tx0/5RWV7ayJPj5dLSODdkNLw?=
 =?us-ascii?Q?ec05gQVxrXa2Ckg4l84hlLErnyAoJrtPrQ4jpmLaP6pAKVN3zaQHOrzTdDGJ?=
 =?us-ascii?Q?q6uxCbIIHj3qONlbXFbF061Aax13rOxpbbOmjsqagBhb2w9YiuuNgsaaoQvw?=
 =?us-ascii?Q?Z2MIRucjxdeoollz3VppxCweeInmHCNtE2kOjL5rlkM/uI11Tqwr8ipzFvOm?=
 =?us-ascii?Q?lvqPI4LiW6o4v7Htdg9MPwKPvJ5QKtMeCPjNniN/Q5LHbaGqMCGSxhhaUdEM?=
 =?us-ascii?Q?HL44tSuzzVh3BzU+XusTzQTCwSbD7ed//aE9hJC2RbE290SEffUM8aQAoVXs?=
 =?us-ascii?Q?k6EeB0nO1jB1rKUjq8BtvsS+53P6YHbCfwIlZkdYdaLF0iMcndkYa7AW/wdE?=
 =?us-ascii?Q?J/E4qYo4yF+/Tx7SelGW38oZFoM0l7LA/Q7gLauUKbgY5aZGSuaKHtmLas5s?=
 =?us-ascii?Q?gJ6UjlKDLMUt6Mm41vC+BW/bq+ojqKD11QpmzNYss/eIrqoMchWX5YkUekr9?=
 =?us-ascii?Q?7kDaRpzmA4UkuGZBzKhDfRwbjPWGjdmIQMgMjyPyH18QVnTrA5lKUlLd7wRt?=
 =?us-ascii?Q?dk8hbzdyw+antsc+6HHPEFlFTM07I+vxO4933uaHb51jinjC9u4AFCV0LD22?=
 =?us-ascii?Q?DcNQ+c/hRPiNVMk5ydF3LnGBw+//vQCmFsA6nixm3UWe8iiBnC8bbBSLNzdd?=
 =?us-ascii?Q?Ewq3Xmlj11aYr7h7lrOQnl2QL2uuls3QCTLKucRFTVzxVv61kwVD5Bw3qiqY?=
 =?us-ascii?Q?WkOL1pq2/MsvF01ELNX3nl+VkYsxNuvs7hN/NRPu?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9332.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4abd7149-446d-4276-1517-08dd969ad197
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2025 06:03:04.1613 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SoyF/uO96KC22BP/su15moevShdkrAXT/FjPn6PfDaEu8Lra0u6iT/2A2rcqnOGgCnZDJGjA34tPIB7CLoSzBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8459
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
> From: Anoob Joseph <anoobj@marvell.com>
> Sent: 16 May 2025 20:11
> To: Akhil Goyal <gakhil@marvell.com>; dev@dpdk.org
> Cc: suanmingm@nvidia.com; kai.ji@intel.com; Hemant Agrawal
> <hemant.agrawal@nxp.com>; brian.dooley@intel.com; Akhil Goyal
> <gakhil@marvell.com>
> Subject: RE: [PATCH] doc: add limitation in using segment-sz in crypto-pe=
rf
> Importance: High
>=20
> > Subject: [PATCH] doc: add limitation in using segment-sz in
> > crypto-perf
> >
> > When segment-sz is given as parameter, use buffer-sz in descending
> > order.
> > The reason is, same scatter gather buffer list is being used for all
> > packet sizes which is initialized once in the beginning.
> > Now if a small packet case is run first, mbuf SG list will be trimmed
> > to a smaller number of SG and rest of the SGs are lost resulting in seg=
fault.
> > Buffers cannot be re-initialized as that will come in datapath and will=
 be
> costly.
> > So to workaround this, if segment-sz is passed as argument, use values
> > in buffer-sz in descending order.
> >
> > Signed-off-by: Akhil Goyal <gakhil@marvell.com>
>=20
> Acked-by: Anoob Joseph <anoobj@marvell.com>
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
