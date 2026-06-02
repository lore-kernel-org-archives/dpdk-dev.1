Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D90CD6E5D
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Jun 2026 19:36:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 61C0C402AB;
	Tue,  2 Jun 2026 21:36:39 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 0E459402A9
 for <dev@dpdk.org>; Tue,  2 Jun 2026 21:36:37 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 652J6j8r929862; Tue, 2 Jun 2026 12:36:37 -0700
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021074.outbound.protection.outlook.com
 [40.93.194.74])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4ehbxgdbqj-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 02 Jun 2026 12:36:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UI+eEWZ75/J29jnVSJsRK5DixFea5l3PQrYXsSv0PJf5gKwL746DSDb5qYl5n17aMWPia9eK849XEsjO0bSx9mdBrV6bcf6Fv/KOkztRl6lpPIkVTtwQz9d4KJFmBTPKMLEedXMwSTfEiBOkEwKb9cMp5/XN5SaoE0FwQQhDnyKjJcntaVfpcUYz5u5V/K5Ye1ScUvDi21AHj+Rwz2Cvkuykp0KfYD/cI8B3dGMiWTOTQ8k9KDbhYN1Fp/o2rR58eRe/gKS4fRyYEq7S78kmkFRM8XFM2JUTn2uxp0t9EXOvEcjYLn6QKU+Jhtc3n5nhnV2LULdmtZNBmeoASCHK5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r2eS3osElnSMAKHRPf7U3Su5axgKksYG897hgiIhrq8=;
 b=gIyab16EXFctUeElvG5GFiu7jm6SSbgiHrOgYWS4PEV4q2uSsiebuHDzwcpwDebbY6mTc+Hx2Twa0dVD4do1Mp/zdfeBzW6eXAdzJrR2RPqeJo9zopbB+VxmBqHE2bbZIOw1X0wT9Y1UkWMwTZcn1bxbcdhRK0qLP/2JUn+WNMN0dqOuplBHqLuOqZ0eTlxTedSs9tet2N3fi4bizlm1YmnCHAtf1+d27/+QM9/A7FobUrL3NK9arE3vqKzg5OQtwJU9WAZqdReprXte3i+42hmIADWORCToU4+vE8vNc1obUeLj8oM0K+IwuyHy+3t4mEcTthm1JK08WPGpVjzIlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2eS3osElnSMAKHRPf7U3Su5axgKksYG897hgiIhrq8=;
 b=WOuN5+AdoqXBvtQRuGqoj+APCgzDdk/rFMuLbzRaJHHEeR0fdWSW46ACwedmMQa6YTFqD4KhCY3IE4eTNW6YvQn2oK4UN/QOO4Z/Ft2baWfeXb/0puPreXYlKb/RuGpWjb4rzhuD5Qbv/tt+eUekz4h5xRDmq3/T2b40Wu9lU9s=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 MW3PR18MB3692.namprd18.prod.outlook.com (2603:10b6:303:5c::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.7; Tue, 2 Jun 2026 19:36:34 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%5]) with mapi id 15.21.0092.006; Tue, 2 Jun 2026
 19:36:34 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Konstantin Ananyev <konstantin.ananyev@huawei.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>
Subject: RE: [EXTERNAL] [PATCH] app/test: use memcpy in ipsec test
Thread-Topic: [EXTERNAL] [PATCH] app/test: use memcpy in ipsec test
Thread-Index: AQHc74Jm+hMbOh1YmEWR7LHqzPUgybYrrxMA
Date: Tue, 2 Jun 2026 19:36:34 +0000
Message-ID: <CO6PR18MB44841D6F9F4D1F57C719C1B1D8122@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20260529154651.128372-1-stephen@networkplumber.org>
In-Reply-To: <20260529154651.128372-1-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|MW3PR18MB3692:EE_
x-ms-office365-filtering-correlation-id: 1349b0de-d22e-43cd-055d-08dec0de4124
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|56012099006|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info: JWrNpqBMTcXbL2jygjMFrfsrgJmPikmdwUAk+CUmoM0LQyjNm6bRKhREBghUuIiXZhHyR0wQ1lfgbmzdg+ajKnqkSU0bQbMnGK2kn6NMf8iOVVCidHtzShlInsviMAdhGb5ZHv0xwneQmVnT4C73bU2ZRcQqVCR6H4dV3yrJ6968lByIiKVUJepWefgb/qHUg8+jqkqYZSY10ZRCLGsLRhMh/VxlWT2B1MGQc5d/Ktjoyk/oID4m+pAwBoqOkNm7lwVEDEA9LWsgwqn556a3BPjIlj1OnJZxcQeWz5ahJY53vSkbUWj2d88JEhCDE7efpJIo6vbGmWEgypjyAvCCgfi6OBSEBjGljHP+zjMSZl16LhrT84vOQt6IGnIEQFfCm605Zlozs2G1KMeUmuJo4Z+fzsKn5TaaO5VBdjdEkzuOYizOvEF/eDHEZTjP+QVmg0LxSt28RWfF5gAKHegbxPDyzw3sLOGv/09f4CLh4mJPRgkpOi2O/6rloe88ziMlZiw4Pwr8gbT2zXu/ASUB65YottN/aAw7x04Z2SEx+dbWv7sWSCCafOS7o35dsf4wospx8csQG9A0B4hg6DFMP7+hJM+3MkUu2qbue9StXvotKfXlyKBLOP+ULNTCFrdizgML5WrURqkyK3tBaKLaw14cGcgzIHvh3tSetmCAQ4LbsmM9uMEXYYAdJtc5KUh1sxE4XeJOWm4gxGF3tDNGRNlmo6KI6g6awO/qKe+m8I7TPVj9hnhy7rnnGezgJfwV
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BdV8iDcbp0F8yu7mUJbUD1PuZEoEZ83Yd9BoqiEcAccc+thlizxN//Oq2QC7?=
 =?us-ascii?Q?/dY34uKm39GqeQqetretmwcgb/+Vp+U3OujgUdet5W1bSpFA1g72hcwng04H?=
 =?us-ascii?Q?uDjWUPPFJ5sAh4oPumBMaBxc+5b0ibNETHkLfAaamHosOsror8Lo/J2G6LdO?=
 =?us-ascii?Q?psMWWaYpAgDkXYfi2GLwyIP5xfvD1bBE+vW+vgryviec5XNGZOhfl6tAxAAU?=
 =?us-ascii?Q?bIPMcHdRuibuzGAmsbFktPytBMORGqvG0z0s3Nll+D8O5kJjOa2i9vQvI8nT?=
 =?us-ascii?Q?y3B2SMahRKG3jQI3s5b+L9gJ6JnXgfyl2rEqir7pWy6oTR0nMMvcDXhOQU+H?=
 =?us-ascii?Q?w6GQuSX9jfyumbyaV7XaUquM250wNxQk2W2u8/U+CTuMchhYougg4FX9rWE4?=
 =?us-ascii?Q?tT1Vmb8UmOFYeJqaSNX94f3AugRl3TTYOZskMTsMH17waJYFWXHTbJTvzb4O?=
 =?us-ascii?Q?AH5UCC3s2XACP8g1J1qVzVkzxkHj84dP1YgEwqCXc76VZaV/HFlhXepBdxhY?=
 =?us-ascii?Q?+3B2/t7+0/WkFY8EbWGCIp0DnNVQPR9OXeXuzatvnESyeMXghAR6zh90cTFO?=
 =?us-ascii?Q?1WGi44BfT94r13ZNnJ2jRPArxwzwPed99JCdzWvIEXos4fNaglIASEuKqIU0?=
 =?us-ascii?Q?lyLcx/Mn4JRTxMedbalvMVHntfVT+YiTlSw+ih3L6JSvjnxNiFOz/RHC4MTc?=
 =?us-ascii?Q?dM8uUS15rJAtACfus+soJZ/Gurdtoc0DtywGknaWeohFKP7y/I+xw08cXlNb?=
 =?us-ascii?Q?FRsorHrRPEzSoR36L0c1lwvpTiOlNDdBwX+fW4XMkJc5JMHC/gk5U6KLJ1gz?=
 =?us-ascii?Q?QrvEsp6x68UGHCTf/G7vv9sbo8h5QSUkd4SbRsh60AGbU0V1jGFWci0vA8uR?=
 =?us-ascii?Q?+Tk70levKVeZYwLmPuVWJiICg0xIRqEjzmMa2t822hKeMdUWdKu5AO6fBTtB?=
 =?us-ascii?Q?4b5kSd9seNyIPMXkW0paCPiE/bcymHDKtXYtbaTs5FxcDIxE98Cg8fOBx1KO?=
 =?us-ascii?Q?hh/1DmTwe0M9GptS+S674TxXLLzQaiuBSbpFooicba+9bkHvTlNfEv4V4pY4?=
 =?us-ascii?Q?KvSWGrjQrmjcKt7h3vZJ55UIDtrGv42nmBZwi0NnAog4NhFLskFFVk6G8eRE?=
 =?us-ascii?Q?a2UMLMEL4WIVyw+vZMF5lMTxlpaRYwdEXhMly0epLYoTZJ5Myer8l4TLdYf9?=
 =?us-ascii?Q?NUHUP7m3NuMCapHoICMhRnbrFKI/H/LVmSInaqF7s4hXVes6fF1wFuXiHoCl?=
 =?us-ascii?Q?BnFGHNS085Bise1nw0zix7JfQHLLxc20nejVKvE6KnkYIwMkTg+BVdZz0ueS?=
 =?us-ascii?Q?KeTDKKXhmD1mPc3h01am+TC3yQXSqxgXvmmNvZR+oTeNAUdu8LJ20XgYFqRu?=
 =?us-ascii?Q?G+d6xclkPu+tf3q98LBTEtDqrVajQREdhZt2R7OE/KfLrsYsq/OJujwiEvqd?=
 =?us-ascii?Q?reKgtKSkW5vr8+eamqnKBU69G4OIZ06C2vJdUBBQ7RsIPCopzCzPUdSEgIwS?=
 =?us-ascii?Q?bTn2VQp6S9ddBCAbJz1dj5GO4gAAXy+ECOjoMBYkmHtjKeX9YBju0IcA1HXT?=
 =?us-ascii?Q?jLHrV7E1AH/olNMgA1E/uxX7Cc/I0kijZDJrcm6ROruGNblYYttvskOtHbrL?=
 =?us-ascii?Q?qXcSwjCrH44/gv9xVTiGwIUnzMh1AGNUzvN7hvXMtu1sz1bJiT+22MaMQahF?=
 =?us-ascii?Q?t5TFP2Q+3Ezm3Buh+ZeM3xxzHLTT9m5c7xw7yEAbljXocE/7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: CW4yaiVaxFr7D73wB5+fDutTXK7vP7uKDEKtKBmRq15oEOxfO96Ez4MGtwjskboWW3FRCUHy4G9+Whfg4xZC0CHoCucgDqApiivEgiqDFXC5iiFjFO3ibWPrID97G1cqsbzcebsVxPaJqhmtDAx6PHjOtQ0zb6luxghJD04jlfvZW7EIxj4TzVjsSsxstO9LxMV3Gg972xqsDQV75ZsyIZ1Gx/s7+YqhV3KqLSGofQMHKEq0GaVR6PpHaYZ069Evr02kwJgCPI+Gd88D+A16tT21ZEu5pKkUw1jrxdxDVjd3mfg+FuP8dAOiYcUGb3ox88OtJ2uV5SJ82fiHFjaDNg==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1349b0de-d22e-43cd-055d-08dec0de4124
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2026 19:36:34.0808 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A9MiXNegzVWHYa8P2WTIZsIypJASqW3G65FnIL2/rIFEhqOcUWUtCsQPsSYFTByfMpcZqLqVQNOBKVlMtU4H4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR18MB3692
X-Authority-Analysis: v=2.4 cv=V75NF+ni c=1 sm=1 tr=0 ts=6a1f30c5 cx=c_pps
 a=pHX0GuESvmlUVbyXmFftrw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=jZVsG21pAAAA:8
 a=aBJbLMG7IDEfizTN4bUA:9 a=CjuIK1q_8ugA:10 a=zgiPjhLxNE0A:10
 a=3Sh2lD0sZASs_lUdrUhf:22
X-Proofpoint-ORIG-GUID: PFTSURASkYUDTHjpUJeZfeqB_9dYhfmT
X-Proofpoint-GUID: PFTSURASkYUDTHjpUJeZfeqB_9dYhfmT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDE5MCBTYWx0ZWRfX4r5za+aIJ4Yf
 frEg4OoJttNFZOoAY78P1fOrQNv8cgTE8e2UYaNo411e9U5bIRmvKKICaB9vnGFGXaHpToqAxzM
 a3rKh91T2JtipBOEY745VWvMokxhcDjyhJE7s9FszvAfLELZZ4tnvy/oTnrP4gNRRj761QuG07K
 a24PLdGZRxP0D/HHeB32q5jzUc55xeT1H5w0xIkePOc3JXanVJ80qosIehng0FqVpGVJgXvtWW2
 C9Ev4AW1KKWQdGGnnNjXHUw61JOW7SSb6OrlRRkgu3XBeWI/alSvagKtkZUoVCQF9Hd51ObBEX0
 /O2KNIJM5/4wzKigjyDb46gfCM7QO6E5FszKvXDfyCGoBX35d14ca8BRwf7IjKMn3WQ2CAybZel
 mLKCLDkwwMMIMvq0dZ1TFw9Z+1ddbhvR8x22pfPD4Nem66y205hzpUdJy+ZuHHRnocj99aaLwlU
 o85LtrXebm4kBtytk4Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_03,2026-05-28_03,2025-10-01_01
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

> This test has tables of data that get copied with rte_memcpy.
> But when compiled without always inline the compiler gets confused
> by the inlining of rte_memcpy and thinks that it is possible for AVX
> code to reference past the input data.
>=20
> Workaround is to use memcpy() which is better for this test anyway
> since regular memcpy has more static checking from compiler and
> analyzers.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Applied to dpdk-next-crypto
Thanks.
