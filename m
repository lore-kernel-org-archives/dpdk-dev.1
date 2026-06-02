Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD8FCD6E4A
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Jun 2026 12:09:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EF74B402A9;
	Tue,  2 Jun 2026 14:09:51 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011003.outbound.protection.outlook.com [52.101.70.3])
 by mails.dpdk.org (Postfix) with ESMTP id F00B640150
 for <dev@dpdk.org>; Tue,  2 Jun 2026 14:09:50 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U6r6Lzm7rslxpLC9SWv4+gzzwooOy5ImPjnU2tWPuXoGTaNbw6JgJEVAsvTqSfFajyJsSAZcyjh4EiMM7pKDke4a17e0cu7ummWw1H+yYMcO5gnzilXneMu5VT/q6cx99mDuEa0YGgKkKfBuUaQCLeIKjDWyIGFJF1UFKWNvuGZTDNZfee/Lg/1mIe/iIKSRx2++9tLUXKnfq8wKK5EVuA79ffRISHT77sJnQxKL9un6usNy4U7VHL9pskrCNXtsWUqDlZ1P2AdKIPypvIBfKX5uZNRjEM7+wer2xHIG0Z8nVuHskI+2bzK4mIChj5XW7j4ePdTjsGSxJRyC/ZAjWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3K0o2VS8WETvOOCrdDysShC4X7HuiqA9kA3Edgq2xTg=;
 b=QeaEyrwKHO/8+cuvA3wEwNiXjnlILKERM6fIjRQ82Lwx63iF8/9uYIY3t2KiGz6LB0mTdB31ijaCkIJO4UXRIKc1IyMcYwRUNzccEVw67eFQYZa5klbf/kzJVpHJXqJeuz3ahL4A4LrqACG+HCDl1aeEGOZ58EGwE+pwMoc6TXFqrsCAZ5/JS9xUerKrkNO4v3t/HuoLXskLltLcPMbwjrBQcf65FANDU4ygNZlw0xFHVguULO3zaZ0JiTibnAceVxGzhkkHovfqd4eYr6k2FNDFvSpOTumIi/84geounlA/NJ2cTRomWrxI9h+fIEEFtFQelprrhuQBFR7UUkCVsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3K0o2VS8WETvOOCrdDysShC4X7HuiqA9kA3Edgq2xTg=;
 b=iL5DE2PQ1mrCJqbnJPPT45Qi8BX5v4Hrjk97SnWHagDNle2P0+/XBiz9ABJSeHHfEWgcEIVTzIXW5O054mNHATdNrbAd9OhgAEtsj4Syu7rAy+uc8cr6IsWwEJvaRiQPifDLbPu/QJ6nr+ADicalPkBXVLvDuaGNl15i8e2wemWTappEEky3qmev3Y4zJmqqveZBe0MrnfbJsZCdncY3jsIQmP17YzHTXW0VxpUUdWqEpZK4fuVxxzJZE0irftqNyzSDW12ejchW25UhsUoiC25lLpuTP6cvRPsbS2SYBCCXgLWG48zHYhXdUP3vqhywpNAwRQS4NfXVXr2AkuN5IQ==
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 (2603:10a6:150:212::14) by DU2PR04MB8949.eurprd04.prod.outlook.com
 (2603:10a6:10:2e0::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Tue, 2 Jun
 2026 12:09:48 +0000
Received: from GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003]) by GV1PR04MB10750.eurprd04.prod.outlook.com
 ([fe80::9985:c5d3:961:2003%6]) with mapi id 15.21.0071.015; Tue, 2 Jun 2026
 12:09:48 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: Wathsala Vithanage <wathsala.vithanage@arm.com>, Kai Ji
 <kai.ji@intel.com>, Pablo de Lara <pablo.de.lara.guarch@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "nd@arm.com" <nd@arm.com>,
 "Paul.Elliott@arm.com" <Paul.Elliott@arm.com>, "Dhruv.Tripathi@arm.com"
 <Dhruv.Tripathi@arm.com>, "Shebu.VargheseKuriakose@arm.com"
 <Shebu.VargheseKuriakose@arm.com>
Subject: RE: [PATCH 1/2] crypto/ipsec_mb: allow aesni_mb and aesni_gcm vdevs
 on Arm
Thread-Topic: [PATCH 1/2] crypto/ipsec_mb: allow aesni_mb and aesni_gcm vdevs
 on Arm
Thread-Index: AQHc761+N5YXIoRiW0G48a/8XWxQzLYrMdog
Date: Tue, 2 Jun 2026 12:09:47 +0000
Message-ID: <GV1PR04MB10750F42B67E6112BE4F0466789122@GV1PR04MB10750.eurprd04.prod.outlook.com>
References: <20260529205512.1985844-1-wathsala.vithanage@arm.com>
In-Reply-To: <20260529205512.1985844-1-wathsala.vithanage@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR04MB10750:EE_|DU2PR04MB8949:EE_
x-ms-office365-filtering-correlation-id: 229b4268-d75b-44e1-c4ac-08dec09fd773
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|19092799006|10070799003|38070700021|11063799006|22082099003|18002099003|56012099006;
x-microsoft-antispam-message-info: s9O8tyc8Uu9qP4sVApkINjd5FLWurNL9EJKWjYtwSujq+koFo4yKvcSlHDeMhElKRtfRUT6pm2NNAzUp3Ve5Ei3KehQB71+tbqN/J9f5rGg41LW7KczGNCG6JYDN0NjHtwtPbzES+dcXcShgIO7JG82nr96RMcbWrHCEUjb/4jChAOpTzNpNyGSiCPyObS9aUyJGjTD0ZfdgEGOMx4m/NIBAWH2CAsRriBfsGEOvupY8CKToObXKmbvSWBUK+2Z0h6U9l3Iyfgv2WWmkjS5WNx/y4v1Pers+6vzTI2yE1R033cbQupG3qw8EQNiYJDzfDibrp7zIjfQdr7r2v9rMD0G8BbnBWikst3xcCMk/kMz2zalZBeSGJM9GRpG7DB3l+FFYTD6t7zV5LT7dCtwZhNu5RtatH2flDXUEADGDwqQhUO/2YGyYIq6VmC+s9dxmbA8Z3//prWit4eHYcQ5NM/7VqNzLTsY+T+jHMwuvm50+SqVEXlrmPxFf+QlBSWi4sdYB9OgDuJYzYyKFTqORFrj5nCVES9qLRNLOM6C3o1CkTFEf/PzPJktN1syfRUvnty1jCc9vW1cHI+egg71A2NSmYtHeiLCanVM4Gfnaj0kXmCBMlwsej2/CsmHG7FrLPjCtIzmO290vpx0h7FpP1kUbGiZAW58hdz5NiCraTlQru6YXaa3njscmuJCPS09L4JeTDhuVVK6rnKw/6aEC1hbU9MQ2ithlQJMF958Dr7bwSy8IdGqdovrlDvsh1YcG
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB10750.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(10070799003)(38070700021)(11063799006)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/9CnN7SChOOIXm0hokUcgnTznuyHcitGaEJ6xGzg2QlY96wYb18yycdX2Yv3?=
 =?us-ascii?Q?DF4MldcRLQj/rmYMnteerssMIB1NyexyYxhyb82th2gcWrnaSrtZcHcATjC3?=
 =?us-ascii?Q?mVxbHR6f6If7WblxPlxidBw0cXX8GBxvrkOmr8Jmvpb1GckTX8eNSH5LBEzk?=
 =?us-ascii?Q?quYBW2rGhfE2tmBh4bkTC4fnlAJmx/a8NkKMTGPa3HspiyMxXLfBJCchUEkq?=
 =?us-ascii?Q?JAVMDqMRhE5YT8d979AxSBT5WB403aODKOOqHh6sSnEtGNX45D6lo/Dcr6Mh?=
 =?us-ascii?Q?lt9hkobz9+va1i8oq9+Acf3xXat4lYF1zlzCzL+BrEc+U7kTbvKasgo1Pjgi?=
 =?us-ascii?Q?vPr0t2hQAXQZ7laGMkvqu10soC/waiwZaiYQSEQzEVbNBGTq5swam4qp03aH?=
 =?us-ascii?Q?CH6grwgcx2rs69j7Fom2hcJTiC0y9/5dWEMw/WoqMA1MfIIQWRlTtidyTUtJ?=
 =?us-ascii?Q?GCQO/EE5TSBFmEQMPVZWnxB4Q2CA8L3vcsf6cBcMUuzOr4vRAM8QAlyuOM/A?=
 =?us-ascii?Q?iobGxwjqQdGtMHtoCY6P1+D/Du6MUfjsZDl7/65omyxbiwUFp99Z3lb/G3sp?=
 =?us-ascii?Q?9kN/mSX/ZnMnLjJ9V3L6Tmatw/mYhVYRtLOo3dA6QdvjXmMa8KrvfPvuftJ+?=
 =?us-ascii?Q?isqki2VeFlf6K2sKbIhVgaXne34BddcmNTA1XvfitGd/vK7okaqJMX9KI/qN?=
 =?us-ascii?Q?kqIvGvevJdfLAFBx8skM1Xt5fDel0Ouo2X8lVgDcCAavb2WQGAi73ToQp/xN?=
 =?us-ascii?Q?9wIAzL808XhqAi+jFq43dlnajk4H8uGe+SicUdpLgnY9rBt/CTjKkazmHL/T?=
 =?us-ascii?Q?2Wc3q0k761J6kt5glXfyjH2FHWHFDH9rWsatI9FIVoXe5N8GghbcLXd2lHVg?=
 =?us-ascii?Q?IvjGwryxp9sp9kPdidtYe3cS2i/20Y11KIeFXdWKu86xf2hujnWIPq075AM3?=
 =?us-ascii?Q?db3mHOseVgDQ7JUnI9BOGyHVYUL82oT6U5eTru50BK2PSmgLFgBNud3FOnhu?=
 =?us-ascii?Q?l6JmBm+oPv6CK8awFD7habRj2/IvAA6sTBX+5C/AJ3edn8gCuyecHHdsN0dk?=
 =?us-ascii?Q?TshyKKHl9kZyJg/+p7e9FJelkphsKYLAsYXyiashtw+ZWTVUjz3nIePNTLVe?=
 =?us-ascii?Q?tP5fxL6OIBpgQiYB+hbuLsoUyfGO7KppfRcL/rGRJQmztFGiWAHgR7EDTFDA?=
 =?us-ascii?Q?+Tz7M4ApgT7Uen+sDcyfhh1lQHhqEeDI9XENNz3jGJr6Lbn0jmHP6OpmDo0J?=
 =?us-ascii?Q?wVA8hU82pa8vxysZSPTu5jmcalbknxISF23n54K9qYAYJRx1GzQ8z0CtGyqp?=
 =?us-ascii?Q?3QTRPB0Ub/Iqe2znVzKRMxWUX3FTOtcob04tTCr9SVKe4IqOltaG2D5aWqGC?=
 =?us-ascii?Q?1/Waqff0OIpqA2jkwsEbb0NueXT62BnzNIKkwr8dYOt4khR9HQFYre0N5oqY?=
 =?us-ascii?Q?vuePoPcIJdTBD9D2xqLKikmlRpXnyvGJtO3Ts5cfs2Sq8wOAq+VCsdeDVJ+F?=
 =?us-ascii?Q?LIu/jSgzz6ec/IXZt4Cm9u3zHZlqJ0HIncd20mIsDJZw3vuyBZQSoDEJrMBm?=
 =?us-ascii?Q?9FhWdStgUpVS3bVvF92qVHyE29ZNJHMiSNdOc8n4x003OPO5JSUIVGXTzudZ?=
 =?us-ascii?Q?RknMKzW3kh2nnJGKM8sKyP3eajtv6/3CfsOB2YHJEgfU8s8MjYTUVP6sK1E0?=
 =?us-ascii?Q?shREpEsrGEvaXvNVA7hIW5I3uUuaq3REIIRt/iU4nOTrACsA66MYrezA1tcE?=
 =?us-ascii?Q?dC7ZRXNNMtIM+DJ9pcFKzXIni+WtU/3ERprWpm0njS+GLAFPlExN9c77foFO?=
x-ms-exchange-antispam-messagedata-1: wLiSSvqm80lvWQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB10750.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 229b4268-d75b-44e1-c4ac-08dec09fd773
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2026 12:09:47.8763 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bXGZNZayQ11y5z21BVQlTnNpt/2D9YOJ27TVnLq9DkQewK9+9yaMK/JnHzxmLDjYhp/sHe1Uxrlx2BAbOOHw1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8949
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
> From: Wathsala Vithanage <wathsala.vithanage@arm.com>
> Sent: 30 May 2026 02:25
> To: Kai Ji <kai.ji@intel.com>; Pablo de Lara <pablo.de.lara.guarch@intel.=
com>
> Cc: dev@dpdk.org; nd@arm.com; Paul.Elliott@arm.com;
> Dhruv.Tripathi@arm.com; Shebu.VargheseKuriakose@arm.com; Wathsala
> Vithanage <wathsala.vithanage@arm.com>
> Subject: [PATCH 1/2] crypto/ipsec_mb: allow aesni_mb and aesni_gcm vdevs
> on Arm
>=20
> Extend Arm PMD gating in ipsec_mb_create() to permit
> IPSEC_MB_PMD_TYPE_AESNI_MB and IPSEC_MB_PMD_TYPE_AESNI_GCM in
> addition to existing SNOW3G and ZUC.
>=20
> This removes -ENOTSUP rejection for crypto_aesni_mb and crypto_aesni_gcm
> on Arm, enabling these vdevs to probe and run when backed by a compatible
> ipsec-mb library.
>=20
> Signed-off-by: Wathsala Vithanage <wathsala.vithanage@arm.com>
> ---
 Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
