Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0714B606A31A
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 18:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=selector1 header.b=KXD6Ezkt
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2BAA540151;
	Mon, 26 Oct 2026 19:21:58 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTPS id EA8EF40041
 for <dev@dpdk.org>; Mon, 26 Oct 2026 19:21:56 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QGiCNA082093; Mon, 26 Oct 2026 11:21:55 -0700
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11022118.outbound.protection.outlook.com [52.101.53.118])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4hgt1n0fu1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 26 Oct 2026 11:21:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cN1JyOsHpaDfAelSpKU/PsMiP1NNcMWFS4+ph5yhu6Zv/5vKJQfnN1hiCzKVZUQ14Vuy9jnyY8Pg/L/t1Kjz/MbbQo+4EjYHcStl96X1GiXFX5gvtNmw4WjZ/nIatiSJQMOadc9dQRvwGNGt9W44Uc0eVDqAqRaZX9Hu+abb/MPzvjc637jFy/yaphai0YY9vIp6T5uE0He+GeJTAN6E5r5ItG2XHRPIFFe7DR6qVea2ffcxZ+QvFyQD9RRVq1bKmp2tf+0FaYhNuvesPGkz0rpRvoEu3CXsZIAlr4sx63bO4H/OPL54YxowDB/LsJFBlmgkt5qoHQP2Y3+3K9vQDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uzX0nv2OiMql0/8APMBQiOHbSC6V5M0NxZtgeI6NHYs=;
 b=Ayd/vRzVvuRkoXUNtOyUKYnqiGpbP7dGsAev9kenHo6e6DHM5c6+B0GUyzwT3lhh7f5SujTf3U/cqJKr7VlcKAiwR5o4MfCzXLCvmln7Axh7bAtTeoU/mz9nVxe+qfd0D6o4G4e0MrZ6fO8T0jLv8TY6blBcCZZvfiUgpfLJnhGX+ZXHttr80O0Kl7FsuX6MjXT82MMOUgnW6g2bdeZPtL9flai/XA+LyofnNhUii+017WqGXMkBom24+r75CdyIllLYV/SbrP4kY6b/pKoz0RxXjVrfp5si9kKpKmBb93GQh5OVJBETrrlOkd4xDXzHZ3JOaMOJzdl8S8JMjoRXkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uzX0nv2OiMql0/8APMBQiOHbSC6V5M0NxZtgeI6NHYs=;
 b=KXD6EzktIfMxUXqgjivkl96iDrq6rZJWqyzHLChQDSUHlQNpiuVhBpUtpORXrmomXbsutaSvkTvBOoqBdCi0yIUvvAlnstKkW2z481GfF2ca3OX9vn93188iguVjlNaO6uWDdYcRL8Vh/5pwomrGgGqXo80t8rEHvnLo52XN+7Y=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 LV1PR18MB6427.namprd18.prod.outlook.com (2603:10b6:408:2b1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 18:21:50 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%6]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 18:21:49 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Kai Ji <kai.ji@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Thomas Monjalon <thomas@monjalon.net>, Gowrishankar Muthukrishnan
 <gmuthukrishn@marvell.com>
Subject: RE: [EXTERNAL] [PATCH v9] examples: add Wycheproof validation app
Thread-Topic: [EXTERNAL] [PATCH v9] examples: add Wycheproof validation app
Thread-Index: AQHdWym4WqXwH4HdDE6NjdOvbAbueLcQNaaQ
Date: Mon, 26 Oct 2026 18:21:49 +0000
Message-ID: <CO6PR18MB448470D91AEF1146E3EE6E5CD8612@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20261013152059.3255355-1-kai.ji@intel.com>
 <20261013154400.3273585-1-kai.ji@intel.com>
In-Reply-To: <20261013154400.3273585-1-kai.ji@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=marvell.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|LV1PR18MB6427:EE_
x-ms-office365-filtering-correlation-id: db2c1be2-c05b-43ed-7a43-08df338e00a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|261009223027099003|56012099006|261022105027099003|261022113327099003|261021123027099003|261022075727099003|261021121427099003|10067099003|261026121527099003|22082099003|18002099003|5023799004|11063799006|4143699003|38070700021|261026140227099003;
x-microsoft-antispam-message-info: jjLBplMROrTmClT9fV3+C252weerXeq2oERLywcuY7PBQ1eFbgIi+MeYqAxoTX8XOms7jJwzO0bf0eUQ5fT3lUAa5Pfc9mnEoXhFpuMx090y1+Dc9BuF9IjNrIib/Nd9mDIwDin2z+zjTxyggvO8IrbXkyGXjvjSnqb2bzNFhkDJmoPdSiIpuQ+EKgd3LDovbqeojWlWKTGA3VcA7biuYwBidqY7j6jhZu8JEcslc4v54X7NHX5uXoLv/DeS2axH2TJXQPfa+TZZR5reBXmpwfPk/4ube0/xMKlA1NlV7YZTa4xHPqSeIqMg3L1ZgJE0UDIonV6eKBkioKSgDibwv5GNn5uZoJivN9sJwu0LFaIXcvTSy6cr7RAyy0OeCeWfxWgK3xEOo2Zjd1kVMNp52rv6OD5FR6Tx/r8TO/idY8m6nsIXMQCaTvtyu26He6sFhZTMTfV1RRrLfQ1cSOK59Kvt3+DS7N5SGSKFpSrgXrw+klLtgErcqaG+iU7JkTfvt5LvlM+8w6KL3XR3vcpN3awLeot25GTN9RWmVw/6qIMRCm1BzWtEto0M+BS1DX2ejv+SCFWvsjfhhEbLH8XT4qtsfEX89QuWn6O4vqAEqMU247H+8Np59/zooteR1uwmMiZGuVjFQ5BeSHuWlbppmpm1HzvGamCRbAD+Oz4+/iNSi4G86eXrC3UWRIESOkATpBQtdfPlwel7B2mciwfE8mdyatI4ujJmKUOR9+xGzPQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(261009223027099003)(56012099006)(261022105027099003)(261022113327099003)(261021123027099003)(261022075727099003)(261021121427099003)(10067099003)(261026121527099003)(22082099003)(18002099003)(5023799004)(11063799006)(4143699003)(38070700021)(261026140227099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?I/jfBeUtBJmhudm5/VgieEB+4W8IqAYREU7ysqEY31Ix5dzurmpNMC4PIekU?=
 =?us-ascii?Q?YtWvqC65ib+OdspIrcvyzrU5RSPap1C8QIRmG5lhXrbMHJzXJ4M7lj9vubir?=
 =?us-ascii?Q?Y88+tCU0c9pQm2PIV49K5xjfCnfpCQhgo8Rqm4h63nqgwb1iVV08i7hmQLy2?=
 =?us-ascii?Q?53bIBkiZqklAX2+Xx7BSpLIUlwEmcStmrn2RtMwUJSNJjTMH+q1GGSKT7FBK?=
 =?us-ascii?Q?2rBcNSqzYsOqw2PTTzS2FU5zJfWBiO3IyUzzebk893JBzB6LfhfHr6ZDX9E0?=
 =?us-ascii?Q?IKmT4jP2PwwflJ47x3h7bvEsxXijwQLbc7NIiFh6t5i7kkrY5Gi5Bz9Fvqw/?=
 =?us-ascii?Q?0QEqXXr44Bnve9XUjFvX/spARkD1wHG2OwpCj/fP3ncdLf+x+rf+57z/voNx?=
 =?us-ascii?Q?YqJDbyVAh2bjEJmSfZjt6H/vz9ScYduFURctGQ49ar4v4rMfvC8znsM4joFq?=
 =?us-ascii?Q?RzqVids3nxrafPiUxY+ZiTyfMYaZLsoxD0tPST5rMwqPaAhNFfNSr1u7B8Xs?=
 =?us-ascii?Q?WE8Gh5RlUDxzRc/yO2PNDMxsXpfZKPmlmM9Ve3KkxhTdCeAE4wTDbhhZPRPZ?=
 =?us-ascii?Q?w2Z7N0GbRfPUw4Bjxlb2c5lnPMf1bZtd/Bz8ME4Wm++XpJTbV3MtxDhf+ppR?=
 =?us-ascii?Q?h62MKqpO+yc2u1zFwej9Cu2l6efl8VB9o8lZk5b1IFl06hHYWMLUuT+C1BZB?=
 =?us-ascii?Q?YMEkr+iiJhFodNQ6cGyaDAcw3QLjVpQ5v/8MXZFcRm1MsGcGEAhPrcET26MF?=
 =?us-ascii?Q?63HAV4cBxJFVcM29sM9RJT3oSJgPLR9GN/2eTXpahoHpgFovUBAPfJqvdpPB?=
 =?us-ascii?Q?0RTM7wGppRaTjyjJCIIsP7JcqEqUN6xSB7i/SIJzUyTbPDKpmlh7j90OQdYp?=
 =?us-ascii?Q?a4NbrVYLF8lWfDjPj7QrSh1VbRLFgpp/EUNSIuDdFMJYVU2Hq/f5T7B9Jeuh?=
 =?us-ascii?Q?iZ2hjKhl07mg8r2iK5yq+5bePN3uETACkKWATtpp5bubN8JVQNwaTovb+55N?=
 =?us-ascii?Q?pbNkJ29pPEb5meAooCg94gCt3SCJTyfMIfo8LNVI6j1I3aVRSTuv5+othh7R?=
 =?us-ascii?Q?olNaOZLuoEThj+4nzKLd0/d28ChoM2b9roqg/enyGLLMvSWyEqDSSawNah3P?=
 =?us-ascii?Q?mMh1C1n2lxUuDxpn3vm5KMkSYL/FPZjM02V9Ea43XFGsy1T1ozHZ/dpJx9af?=
 =?us-ascii?Q?TLwj+oWKjPWhzE/Wtlch8mhi6QPTI+gOsCQ4eYvMZgfAyiGUPgY+AlNnQs94?=
 =?us-ascii?Q?mT+nb08rSd7ST3AQeYFmeQCUTGl/qplBT5mSTyL2Vv4PajTHJYsmZzfFWQ0e?=
 =?us-ascii?Q?idsIe2BJjSc2IvOpW6+t9lZ1MKWCy9eQ7m5fZvs7FzADMQrwH2a4CS68VDEo?=
 =?us-ascii?Q?4Wu+ug0ajfd20DP5QyyRZDZ2wClRVh3MDQ5iHyu8QRwqoHO/FdnBErep8QAq?=
 =?us-ascii?Q?Beef6/twFLGmSydMUq0/gh1UZEzjllLx9YvdK/dNaqcTD+Yg+7GtWebqFmfp?=
 =?us-ascii?Q?Hz8hE6Z0V/3Q7l43sKUTPstgslHGdd3Wg4jQ+gzhZex+AaQyiH1tBTgKqUWg?=
 =?us-ascii?Q?8X1rQKDYJlMwKj1nejUKz0GVpmX6HYd1zlSvL3layoCAIgIifL0w2Hc/09fU?=
 =?us-ascii?Q?0euBrlnhvoBXfta9jMjtKTnOmlXOFpFwtq/7RV/za5AJxgSyRRzgxbnEnPeY?=
 =?us-ascii?Q?UMykq7EnbH81kP14ZXrBCbbUplOeR199PAcXAFQDclurqE5j?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: YePYO7PLkM6XsKfIvt7ssMdaPto3Gjh4UjC1KAqMhWISvll9m27xDTXSxd9SbUFycpUFXAyntrdICTww1ytcYT0BpdH0SMuXsg2fybsJv5ojXQ7LpYL+15OFLsmmWpZnbZioO6WM92Cd6oDttSYaky3zX5F2A7Yr1E114iXKfz1wisFjPAzNJv1nCXol6mcr8x91+U6IoRv2xrq4MSThFjb+K62V/okPJFlUJIhlX8pQPUpg7R/Zk0iuO4YWrWzjVtmDSL98I1aeTRuX+YaloSta7XAZlPIxHT+XrsC0acGdeygMXVFP2s/AB9Hm65jB9WVmY1siRsRkIUgP5NtfFA==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db2c1be2-c05b-43ed-7a43-08df338e00a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2026 18:21:49.8548 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +7ZRXH8hmVzeJ3XmOdTkrfrPawXw7DMTt3TUL5T2y0h1o6JPy0AfAiUH1qOUjPSDYqyborJflr3o7/bmu1/atg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR18MB6427
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA3MiBTYWx0ZWRfX2q/YTja3ei8I
 qyghcaLcySQMmc8/b9KaQDLpKQT3YW+DhpWNrXj0om4MrdlpFgXEarVGjRlfG9jKSg/hDxwFKIw
 IIy7JRZLJTnwWIJh9oskU+IAi3MRk9eRdvYtt1jCyRVGsHiHs+Lg3T6bN8subMSPzKvSW+7XaQ9
 tInYrRNF7TpLG3PDjra2QjZI4mLzR1UbvvQngEscYD3sOZHPcOud7mg0KrYKETCQwKz8XtnkwL/
 U3Kv13ymN/SDfkDXBTcwU53GU88NkR9T2MhEdxiUdfWJmjd2Hm37r4/i1ULb+hCDTzYR/ervvZa
 ft+417Dqdg6vQLz2E2I4aAkN5RclNIu5uUEo8Yuoy40vYy0si8DyDbRGT+l7+CXy0FI+UEmAevh
 nV8pZfAg/d5jpdlw8W7YZNIoOVIFcXQgwy8xSJJDpLOlZWDhhpkAEKw/i/0SIcbBB4tKcpES17/
 CTqK//KJNrhqx0cW/fg==
X-Proofpoint-ORIG-GUID: O-rSH34npaRIEPW0Vjk7UzDY9u_qw6Zs
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA3MiBTYWx0ZWRfX5aGR/EQoz9GG
 0XC93IJUtmDNBh6qNfn6v7reOPHt7AXvGkcArbm4OaBMaiLKC8A5vX6kA4Y1WD4hUuQ79dhZfs2
 bVC+zU8P8B3UVhHA4MIYhbLqhvGBsCY=
X-Authority-Analysis: v=2.4 cv=OsnaWC/t c=1 sm=1 tr=0 ts=6adf9a42 cx=c_pps
 a=dEWqTTejV84EJJvpR54jlw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=QyXUC8HyAAAA:8
 a=CyLhm1FVFMeJKlYMzXgA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: O-rSH34npaRIEPW0Vjk7UzDY9u_qw6Zs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_03,2026-10-21_02,2025-10-01_01
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Add a Wycheproof JSON vector validation example for cryptodev PMDs.
>=20
> Create examples/crypto_validation for the validation applications.
> Move the existing examples/fips_validation application into that
> directory alongside Wycheproof.
>=20
> Support these algorithms when advertised by the selected PMD:
> - AEAD: AES-GCM, AES-CCM, SM4-GCM, ChaCha20-Poly1305
> - MAC: AES-CMAC, AES-GMAC, HMAC SHA-1/SHA-2/SHA-3/SM3
> - Asymmetric: DSA (P1363 verify), ECDSA (P1363 verify),
>   ECDH (ecpoint shared-secret compute)
>=20
> Validate valid vectors against generated ciphertexts, tags, plaintexts,
> digests, shared secrets, or signature verification, and require the
> expected rejection for invalid vectors. Digest inputs for DSA and ECDSA
> use the symmetric auth path, selecting a separate symmetric-capable
> device when the target device is asymmetric-only.
>=20
> Skip parameter combinations outside PMD capability ranges and identify
> recognized vector families without a compatible DPDK transform. A
> --debug option lists every failed or skipped vector.
>=20
> Add Meson and standalone build integration, with usage documentation.
>=20
> Signed-off-by: Kai Ji <kai.ji@intel.com>
> ---
>  MAINTAINERS                                   |    7 +-
>  doc/guides/rel_notes/release_26_11.rst        |    6 +
>  doc/guides/sample_app_ug/index.rst            |    1 +
>  .../sample_app_ug/wycheproof_validation.rst   |   51 +
>  .../fips_validation/Makefile                  |    0
>  .../fips_validation/fips_dev_self_test.c      |    0
>  .../fips_validation/fips_dev_self_test.h      |    0
>  .../fips_validation/fips_validation.c         |    0
>  .../fips_validation/fips_validation.h         |    0
>  .../fips_validation/fips_validation_aes.c     |    0
>  .../fips_validation/fips_validation_ccm.c     |    0
>  .../fips_validation/fips_validation_cmac.c    |    0
>  .../fips_validation/fips_validation_ecdsa.c   |    0
>  .../fips_validation/fips_validation_eddsa.c   |    0
>  .../fips_validation/fips_validation_gcm.c     |    0
>  .../fips_validation/fips_validation_hmac.c    |    0
>  .../fips_validation/fips_validation_rsa.c     |    0
>  .../fips_validation/fips_validation_sha.c     |    0
>  .../fips_validation/fips_validation_tdes.c    |    0
>  .../fips_validation/fips_validation_xts.c     |    0
>  .../fips_validation/main.c                    |    0
>  .../fips_validation/meson.build               |    0
>  .../wycheproof_validation/Makefile            |   40 +
>  .../wycheproof_validation/main.c              | 2097 +++++++++++++++++
>  .../wycheproof_validation/meson.build         |   18 +
>  examples/meson.build                          |    3 +-
>  26 files changed, 2221 insertions(+), 2 deletions(-)
>  create mode 100644 doc/guides/sample_app_ug/wycheproof_validation.rst
>  rename examples/{ =3D> crypto_validation}/fips_validation/Makefile (100%=
)
>  rename examples/{ =3D> crypto_validation}/fips_validation/fips_dev_self_=
test.c
> (100%)
>  rename examples/{ =3D> crypto_validation}/fips_validation/fips_dev_self_=
test.h
> (100%)
>  rename examples/{ =3D> crypto_validation}/fips_validation/fips_validatio=
n.c
> (100%)
>  rename examples/{ =3D> crypto_validation}/fips_validation/fips_validatio=
n.h
> (100%)
>  rename examples/{ =3D> crypto_validation}/fips_validation/fips_validatio=
n_aes.c
> (100%)
>  rename examples/{ =3D> crypto_validation}/fips_validation/fips_validatio=
n_ccm.c
> (100%)
>  rename examples/{ =3D> crypto_validation}/fips_validation/fips_validatio=
n_cmac.c
> (100%)
>  rename examples/{ =3D>
> crypto_validation}/fips_validation/fips_validation_ecdsa.c (100%)
>  rename examples/{ =3D>
> crypto_validation}/fips_validation/fips_validation_eddsa.c (100%)
>  rename examples/{ =3D> crypto_validation}/fips_validation/fips_validatio=
n_gcm.c
> (100%)
>  rename examples/{ =3D> crypto_validation}/fips_validation/fips_validatio=
n_hmac.c
> (100%)
>  rename examples/{ =3D> crypto_validation}/fips_validation/fips_validatio=
n_rsa.c
> (100%)
>  rename examples/{ =3D> crypto_validation}/fips_validation/fips_validatio=
n_sha.c
> (100%)
>  rename examples/{ =3D> crypto_validation}/fips_validation/fips_validatio=
n_tdes.c
> (100%)
>  rename examples/{ =3D> crypto_validation}/fips_validation/fips_validatio=
n_xts.c
> (100%)
>  rename examples/{ =3D> crypto_validation}/fips_validation/main.c (100%)
>  rename examples/{ =3D> crypto_validation}/fips_validation/meson.build (1=
00%)
>  create mode 100644
> examples/crypto_validation/wycheproof_validation/Makefile
>  create mode 100644 examples/crypto_validation/wycheproof_validation/main=
.c
>  create mode 100644
> examples/crypto_validation/wycheproof_validation/meson.build

Can we split this patch into 2 patches or more patches.
- one to move fips. Rename fips_validation.rst to crypto_validation.rst and=
 update it to have fips as one section
- others to add new app(logical split if possible). Add another section in =
crypto_validation.rst for Wycheproof.

Check multi_process.rst for reference.


