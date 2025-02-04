Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3606C02193
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 15:55:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D2EAA410E3;
	Tue,  4 Feb 2025 16:55:35 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id CC919400D6
 for <dev@dpdk.org>; Tue,  4 Feb 2025 16:55:34 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514EFJUK009309;
 Tue, 4 Feb 2025 07:55:33 -0800
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam04lp2170.outbound.protection.outlook.com [104.47.73.170])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44kmg4g743-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Feb 2025 07:55:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pk/JBhzv401EbXlpmo3uiO5X61D7SG5sgSxuPUPImP2F6l7hURacbigqmj0FAU7aHvW/Pc40JJCo1SmqP0oVP3OXfN+i9qMd5KrqHtEzmdkOYms2Q+fUIQ6PPAC9ZJ8TjpPc/OBsees2CUFu0Vj47M9CYuXh21AzeRmVsoC8JctLbhvIimIkUW4dwVhrV505XblIMehIscaM7DVtDEqSR5yaVsZxurC60ONlwKLRTnEN9WH2rbQALr0XfFqFG3vpnHBNAjHFowHK834CL0aWwJqo7FwCP8uN+TnjTH27weDb6/1mTPNFdvRu8klboQA3YZa10pQnhh+1wqC44iICuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FmtQ3Tt352ouEB3oGo7DJ1CA5sscGEkxn06upQhS210=;
 b=RnDL3ocWn7WfzntbqMuM3bFTf3XjuyEkyDUVVDAj1nrrHQEh3zUu4KLwmQfku8EBktH8MMCoIEK72WCIxN5cH+MqIBGceV0KOc0K2XyZJBzlIRsurFB1dEcJBgbIYZCaagy3XFwAjnwDqmr/r4omw0m7aDOlnFlLz8/eqGUnwfguiT2q0dh3yhaPXMr/46rgwEUcplBqUMe7duT+WtCx9tNU19sWeenJ3NbHoZOVPMf58nPfwFFsqU+mhSJgpPCe3Q17fb8nVSUiEhnxpTO2HvBjOo7++fvyLdKvcbNzpwgun+KPeHtT3ixHniByndtrT2Hcy620yUIQltayno4ENQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FmtQ3Tt352ouEB3oGo7DJ1CA5sscGEkxn06upQhS210=;
 b=Fga4/qwDdrFBvumvjV/P6IT4YPmbcsMg4hnylpjA0S7Nd98JJZUyEM0V6c6rSawPB4LUt5BhDp/mZaZwA/InFuy5vooaJub1GkLzvnaRX1SCFh7Tp8j1/9+drY8z0/bmtYVFv1GIMSqDkAjWkbMqEV0Ev5eeanC+pXEHCBhMg1M=
Received: from BY3PR18MB4785.namprd18.prod.outlook.com (2603:10b6:a03:3cc::18)
 by CH0PR18MB4291.namprd18.prod.outlook.com (2603:10b6:610:bb::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.26; Tue, 4 Feb
 2025 15:55:27 +0000
Received: from BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576]) by BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576%4]) with mapi id 15.20.8398.018; Tue, 4 Feb 2025
 15:55:27 +0000
From: Jerin Jacob <jerinj@marvell.com>
To: Anoob Joseph <anoobj@marvell.com>, Chengwen Feng <fengchengwen@huawei.com>,
 Kevin Laatz <kevin.laatz@intel.com>, Bruce
 Richardson <bruce.richardson@intel.com>, Thomas Monjalon
 <thomas@monjalon.net>, David Marchand <david.marchand@redhat.com>
CC: Vidya Sagar Velumuri <vvelumuri@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH] doc: update ODM dmadev guide
Thread-Topic: [PATCH] doc: update ODM dmadev guide
Thread-Index: AQHbcVzbMLIslwfNPUa+51saf3dvyrM3V5Zw
Date: Tue, 4 Feb 2025 15:55:27 +0000
Message-ID: <BY3PR18MB47857BBCF37D30196DBD6C50C8F42@BY3PR18MB4785.namprd18.prod.outlook.com>
References: <20250128081550.1005874-1-anoobj@marvell.com>
In-Reply-To: <20250128081550.1005874-1-anoobj@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4785:EE_|CH0PR18MB4291:EE_
x-ms-office365-filtering-correlation-id: 346f9850-994a-42d5-54b5-08dd4534582a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?tVrss/gKhVrJRy7PW1Nb4QI9KuvyZm9Y9S425d+86/+FJubyTI5XaolcV5cW?=
 =?us-ascii?Q?1556i1fwpRvfeyGlBYGxV8+AndPcOAul30NXotZtCrCK901W5EBrVsolQig9?=
 =?us-ascii?Q?uv1VVs6y1PIKPyXQPCio6A0xhjhV6+kVCng90n9b0n7+z2AEGPtZoJXP1hNy?=
 =?us-ascii?Q?mRUrvriCJE5QZyWqRSlWDb/ZDhZWqHpL9oxHkSPvNgB/wqM+n2OOKmimDLkv?=
 =?us-ascii?Q?5bQocFXC7xqBvY1onnf/RjF4ylqQqo1l0gaiF62AAx6HR9ggmJkVmVWsEJew?=
 =?us-ascii?Q?mOUMu15O6sl/I6caBbO+PEQMLYaPpscZw3QCaUMHs+hTwVAYxTXzMVoUcruf?=
 =?us-ascii?Q?8TLMSiD+fN6NZrADKeqQuIPZtHnplqVknKGoT0mMmJqcpMNKWqTRBot3ETwL?=
 =?us-ascii?Q?fbqoHDV4cDRM0fc/2fcuTFBMMGYo0GaLWkF7+RnJUCA3ZMCJkMTgHEilodDv?=
 =?us-ascii?Q?k0ayPPUxohiFrJQqFuokQGix4yyJi/38fONi+5RpPKe2QR7e/hl1xpf8W92W?=
 =?us-ascii?Q?qsNBaroW9dKxPUelBZfLHiXmCcZEU0yBWe2bzrp8p0bOLtq8yQG4D3MRgWxA?=
 =?us-ascii?Q?KvYWBrnYbwsvHJQhwRiruImK2+ByD9+DGKW5dDTWoL1nGUwzFKtxYdlbP9Pi?=
 =?us-ascii?Q?Y9IIkIEQQfc3xAOWkLVlnE00z6xxw+UOd+NynNdSRezD0qz6or1CYMWaEhwj?=
 =?us-ascii?Q?wHcG6DVL3cWJhjwEhuZ0sxkdBc+86bOOf0isAEdlbpi6X9YtrW8GAYE3WwP+?=
 =?us-ascii?Q?yZsW/8FbzYcUoXRSNWkCv7QRjEWtjG9h0bcWLxJhn+OH9k4o/QkvMbXAzxcZ?=
 =?us-ascii?Q?qkCOAdroPXedsJZu+JTaXF8X/OCo8hDiuIWRjxUPlUdKweL0M8JMzdjfDHyo?=
 =?us-ascii?Q?TZWdDHWj4yAlpbYoNeX8Sxx7cKunKnG+iEGxc+s75FBD9EQCO9VFvtPMnpXw?=
 =?us-ascii?Q?EeWH165Fh2AbQgdgmtNolSE1JPE2SKbXdfDhsMBrb/anMKbSk80vxqLdZG/l?=
 =?us-ascii?Q?i41v1F1XaIzMw70cauR7wcC6SUq7QAYzKMyJalmhG+Y89fQUvNyxzRUixNSa?=
 =?us-ascii?Q?9/6W3v88MDiQngr5nSLrzqMsc56fNpurkjT46unDiq7Lm6ZDoQnqoUQcEwDD?=
 =?us-ascii?Q?Rn1znDfpz95Jd84+CquCX9hCnAKA3S5X3nJ2vVY8neKe/MtWyuUG5C4yItuW?=
 =?us-ascii?Q?c6lNVPvW5bmzX9f6sV3U22RmKYu5QLTwvQ4HIHI4DcHDDAFrttrJTl/20xcz?=
 =?us-ascii?Q?15htC7bKAiNTuO0LsbfIfgtKi5j4eJSCHRDmXWk1UUseAh277qZKqF5zaiZG?=
 =?us-ascii?Q?PbRa/cbyM8bW89qCyhWSM0zHK0h5FdtdWOC9Co08EXZysVoDFVGSevhzlgit?=
 =?us-ascii?Q?yhBYdgqEjLwai/+iCdgQ2SeS3rRDOGMAQVtN1WxzB67OpwPnXibRvNrM8QlM?=
 =?us-ascii?Q?Jwvd3Ljp279f29nq0u4zuRsRQqTRposT?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY3PR18MB4785.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OzlkxMX4RfXxiszbSbVaLv8h17QwkC7MVIf15M9fu1cPo0ULffwyHXXyY4+f?=
 =?us-ascii?Q?6ewksNKYyK9EeU9SLj3+IPzkp9jbVGJkqhKWD86fU/ikBACCK1b6R7n1BqXN?=
 =?us-ascii?Q?5c+WhunzBCTizgpcEtXFlulC/RFfI0NyBvJ1LqYK9HMFWPbRNBOTwfBxHijj?=
 =?us-ascii?Q?K/JWGo4ANY/OY6Tb+3KbzzWcdc6YXoc87O4ZZLKYw2E7/Eby0ZvcTpstI+2I?=
 =?us-ascii?Q?A44nAOkRcujLYPUx67j5DjXbO715+CZyAPNXk+DKzEdtlGTL08jvYkReaU8L?=
 =?us-ascii?Q?OSufbxKJrc4/cgYXYV0YmOZPBrpz9M8zfTQhTXjObymmjCgStYhoqeU4zG7T?=
 =?us-ascii?Q?zLLmY/YujvcBmEQBa9IIYEZRnPZkpHwfu0m8hIeNIqbXX138agA27H1khayR?=
 =?us-ascii?Q?4UD0rRsIlO5gZbJbuO/p7CHnDnQ00X7kyugh303YC+ca2ZolabgNtRLx1oq3?=
 =?us-ascii?Q?CvPN8McbpZaM9D4f2Lx2tWf3XzHdqMFfpI9QXTw36IRsWrqPCyPpXv03tkbk?=
 =?us-ascii?Q?MpEPo+U27BP0kQ0eU9bptIsGGOy1iElNvKA0MiQ48uzicUuQR6GdWuExTNiR?=
 =?us-ascii?Q?RfwtVucvcuEVTvuyix+QCt0+o+qtafVQKSiO8mjPgxGqHDlBLGrqNl/LTvGj?=
 =?us-ascii?Q?b57QNBatkrMoLh36CWx3Cota7Iue6N3H0h+k7Sdu0rm/sxAKpUhntgDOXLdD?=
 =?us-ascii?Q?wASmA5m3xyTMhLsLyhKxoELz3+/rzk1ibvXsXa8hnXAV742qPrrRpweo3p2B?=
 =?us-ascii?Q?P7YEE3AgZ5pUImfgho9quawh/7vKIrAWmYaztnwY/0MGBnPa/Gbsz0uPOP51?=
 =?us-ascii?Q?RN+T/ACjVy+hFJYzpLubYgMwPv0atuYoGAF8t/6gejhYauvMRGSWWje5mRFQ?=
 =?us-ascii?Q?UphwVm0CK8amdu6DQK8BkZXkNKB7m2bqtTsLvraZVxNq00LgvuV3FbCIRS5B?=
 =?us-ascii?Q?luid3n6ZupPLDU2lS/XtIwKR8s0awZMgPRh8cwciunfRvI9V8+S/33y3O/rT?=
 =?us-ascii?Q?3qNiVMrYjHpfmIcSwBiIYZzszkIO03GkRJzdEPUCP3N60obHq9RfkMaX3wQr?=
 =?us-ascii?Q?PfRMiUtW7vBd8pJUlYlyDmbyys+zxM0mYxjfU2h4XrQIYNMkIJ7g5aUtCWLr?=
 =?us-ascii?Q?JX5WIMgrBj1abmp5y+cktdMFLEYTz+2bYwH3I3lT7lkHq2fQbkHMBvorlAKI?=
 =?us-ascii?Q?I0uQ7gPLwqcIP4xzE0M0YkFGDEhLfXA87D/Kz3Yze6gpemEjFlwc+EgbNMdS?=
 =?us-ascii?Q?J4mkiHzC+gdqP6Aa6cIyQQd+eafBHdRCoGke2JHwX8LyC0yfuGg033XF4+L9?=
 =?us-ascii?Q?1E+mMYmGL6Aajp9YppKXxREkXUT1IfU+MRjbKjahdcxJPmYWjL0eWN0ofc6q?=
 =?us-ascii?Q?IzNVGTAOktJLj3A5Lt70Udt3wlLjOJaTLIKYTNZtqV+hexJGRWKqVvPutCSp?=
 =?us-ascii?Q?g4Wa7qhb/gOVrmivZbQu0KjwelRyEMAYVmUL6JMF+DVMItMAjU00roZx+Yiu?=
 =?us-ascii?Q?vXcFxIZOm4VIgHaY+X0T9uePJ71FTZ9+hAhh/RmNhsS8qbS0fU6R+XuCNQ2Z?=
 =?us-ascii?Q?e8asWdMbl/Ti8oUzPlM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4785.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 346f9850-994a-42d5-54b5-08dd4534582a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2025 15:55:27.5668 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sljoxPGB6OZvBFtbAUdo3Gk2R6YN1WJ3y0EFaS49hqC5wv8b7lEURHAcb9g2v/mnZ4QZ+IUbC2Gi26y0CawaUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR18MB4291
X-Proofpoint-GUID: t1sZlmNFnB3y1GoKjvJKqO_qFFI2lDS2
X-Proofpoint-ORIG-GUID: t1sZlmNFnB3y1GoKjvJKqO_qFFI2lDS2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_07,2025-02-04_01,2024-11-22_01
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
> Sent: Tuesday, January 28, 2025 1:46 PM
> To: Chengwen Feng <fengchengwen@huawei.com>; Kevin Laatz
> <kevin.laatz@intel.com>; Bruce Richardson <bruce.richardson@intel.com>;
> Thomas Monjalon <thomas@monjalon.net>; David Marchand
> <david.marchand@redhat.com>
> Cc: Jerin Jacob <jerinj@marvell.com>; Vidya Sagar Velumuri
> <vvelumuri@marvell.com>; dev@dpdk.org
> Subject: [PATCH] doc: update ODM dmadev guide
>=20
> Update ODM dmadev guide with details on ODM PF driver application. The
> kernel PF driver module is being removed and so the steps specific to tha=
t is
> also removed.
>=20
> Signed-off-by: Anoob Joseph <anoobj@marvell.com>


Applied to dpdk-next-net-mrvl/for-main. Thanks
