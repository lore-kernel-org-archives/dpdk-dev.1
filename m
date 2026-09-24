Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBCBC9830E
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Sep 2026 13:31:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A172F40144;
	Thu, 24 Sep 2026 15:31:25 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id B2AC0400D7
 for <dev@dpdk.org>; Thu, 24 Sep 2026 15:31:23 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OC6Pf2508657; Thu, 24 Sep 2026 06:31:23 -0700
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11022090.outbound.protection.outlook.com
 [40.107.200.90])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gvksnv111-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 06:31:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mol5JM9qtsAolqW69Dw+o038hwlhNMQwMd5KDbg8eCnDTDWFBWM/OJpjm862FWmiC8h3QV+FbgEwCgBJdJJ+CW5UbJ8jEh8djPHBtf+ShKalSntKJfgJuSJaUfek1HtUAQfsKF1mxflzdjGl5gK/Sat5rCMgpNxG3Kqd48c60R7jBwPmTnvTrtnvRqgJuWz//l0l4QIXugOPBy6xodb0urJVXSCDPGWDFfnHwA2PoXMjtvdscApBw357nM9AShJnYJkpfkLQEgtf7y5EWFBTY/dlnnpJrfZtx9Gu/9Ftu3U3uiiNiTbIirWgESPbJuqFMoVdkJGipxIfYB12aIYXuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CI4Nu5Br2zyHaRBP/QdSw74MvzadeiOG1yTK4UhymPA=;
 b=Xu7ntTQzbZbocjlrsKdml2zWFAXc7sBVY9XNvOtjVu+3DeyWqlz1pL5/Sz395OSRjOlmSWAK35ZIIW7hmwhSWhuUpLN2+ZGxU2T87yrfyC3+MFXi1cgquGG8x42+UP45s16LOlfRAsezG1jLGz+euQnBXOv16rsMKI4BISzSHZreuK9CZmrm4NsSKhJr4SmLlGF96GPIUpRjaiAvT2mmyQMeQUT1DnGj7hIEz02PaujLdKOJBfdMZP0F+VQYlaO5uKVIN9pjryi3UU65pYzqSkzkmDHOL4lgQNEt2ml8rnHUIa47wrRLqcjWXJ6TmECyyXHDrpiCe8ttwxhsmJejfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CI4Nu5Br2zyHaRBP/QdSw74MvzadeiOG1yTK4UhymPA=;
 b=pa3UIxOm9ISYnqBykKx4buAt/fCMry2G0AAOVtJZ2+F0rg4bq2gwcA1w36gC62WQrEc3+i9qq81zGiO6J7MtFtwpAqF8BlkLG9ry+Y6sN9eMYUsy6ZDoq3te5KCcj0OFsdeFPrZ/cygEewKeaxdtduYWHREaPVMHIWH1YZrp954=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 PH3PPF636580572.namprd18.prod.outlook.com (2603:10b6:518:1::c9c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 13:31:13 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%5]) with mapi id 15.21.0428.015; Thu, 24 Sep 2026
 13:31:13 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Sucharitha Sarananaga <ssarananaga@marvell.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "fanzhang.oss@gmail.com" <fanzhang.oss@gmail.com>, Ankur Dwivedi
 <adwivedi@marvell.com>, Anoob Joseph <anoobj@marvell.com>, Tejasree Kondoj
 <ktejasree@marvell.com>, "kai.ji@intel.com" <kai.ji@intel.com>,
 "jianjay.zhou@huawei.com" <jianjay.zhou@huawei.com>,
 "radu.nicolau@intel.com" <radu.nicolau@intel.com>,
 Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>,
 Sucharitha Sarananaga <ssarananaga@marvell.com>
Subject: RE: [PATCH v2 8/8] app/test: add RSA-PSS sign and verify test cases
Thread-Topic: [PATCH v2 8/8] app/test: add RSA-PSS sign and verify test cases
Thread-Index: AQHdO34bcR0klnUUh0+j57x4/2eyGbbd17Mw
Date: Thu, 24 Sep 2026 13:31:13 +0000
Message-ID: <CO6PR18MB44841A2C6BDC0154E64C76FED8812@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20260831102328.2813604-1-ssarananaga@marvell.com>
 <20260903082648.3610676-1-ssarananaga@marvell.com>
 <20260903082648.3610676-9-ssarananaga@marvell.com>
In-Reply-To: <20260903082648.3610676-9-ssarananaga@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=marvell.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|PH3PPF636580572:EE_
x-ms-office365-filtering-correlation-id: b4676d1f-b99b-4cfe-2521-08df1a401a47
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|38070700021|11063799006|3023799007|6133799003|10067099003|56012099006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: 8WuTjZ4OdQKVu/se4r3i1NbOMstPHhr22R3+7gIDIUhg6uXQLCVKBKGx7HuCZqg6Ki+vori/92xRIKuaUV5zl3lH4vElo70Uz5AYEPMelmx1d8zuD4EGib6CnKXqooGWnRvCXbAfBgLlZoB41PZ6v8IkV6SLi0IebEftpjgdNOXXaqlqHWR0X7gUH2E3oPVExI5zjC2x80hqXyeDn4drHell3Knvc+1C867L/gkzLkH+VkgcibTAUhn1DsSwwGBJYkPjBJ32SDDzOTbyJv98zuRV1KnAlDxv24qQGzWcL/hFcTXRV2Gf4nK9lASkFbjM+R2YqbCFDIwhhFIXiGTx1TS1OReVfAjZV9otYcSLCxnwQzIExHwxzmXchwjxSLdNz6ZQ/CaZaqp/iCuiJEJ/6aAUfIN4Ee/vTLS+4TW6OgaI/BBMzyxWCqlLoj0EQ+PuLTVbMKcWP7q3/7tdQFEyBp57gPuRNh9SpFLlVcrjYqCcWU8U5cVNlaM8JWPqEuA8IBdCbo6V2Ii2fAzpR7pk40ZHt4MYIp7REMNFoc/tnq/8QOr41mX9CqgUyuRSxCPnvSy1AfNy+AfsIzGZGzY25gbqyxDjgj4TFJoNOTdJxOaxUU/UoYhPX4J1ziRTfGHhDYJq1zYAcs8vKQYwQ7YfA37FEZ2M5HOZYEDhbOVo+bUoL6hoK7oKzs1mwvfX3OiG6zqPhqu0mC6VyxkSGubpu9k6CE5ZZziHNTySL7PhTbY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(38070700021)(11063799006)(3023799007)(6133799003)(10067099003)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hoWs1U/HPjvzqYdYNW4WnP0ds5FACgZe7JE6h2dsOb+9ghuHl22MW/A39kjA?=
 =?us-ascii?Q?+Br0HJUCURau7iz7kJY2neFIwJjOd9WhbXjxYnUf3+tV9Noc2rvBTEBu5+TQ?=
 =?us-ascii?Q?L60jjQkMa4advA2tJpqHvnIwKY1AxQZuwtWIOmQGRuatLaP4oDijDUb53IAn?=
 =?us-ascii?Q?Bd49CB4wo5uyfhS8A90I6u/kUoJzTVkcXr00Bn7jixdOv1ZMkO9o9JTOpCdi?=
 =?us-ascii?Q?g73ABVD8RQbU1jpf3Xs9AOKdhwcXmFmRbC9EU/plBBgrI+DdxWRPlLEqmGEg?=
 =?us-ascii?Q?MxcTSLl/OwhdCqsZti86v7/EPGNIU6Lg0MJhA1WnBI6QVJkaQFU56hPijzNp?=
 =?us-ascii?Q?0fajb96gsU4qV7FgZ605Ws0bJ8iM6zGJeyOIpJ0nQ9qcIXFpLyEmM0KMb7Tj?=
 =?us-ascii?Q?DFFgixm7mIYgzqo9beZ0mf+RlQce2BeFp90nwB41xmoXOVHpz2742RfJv1nL?=
 =?us-ascii?Q?zEUTn7F67TyVl4cJBpm41lDhmtOWOyG0vSX54RIvCg4jq0yiaqOObPtGmVnV?=
 =?us-ascii?Q?Abkb5U8dLlfTSAIMziTkB464C2YDHB/PpV3smk1MF1N0QjRBnvhWoGA0Zkzg?=
 =?us-ascii?Q?6L8jpZXOmvZWahsn7/OZAWIRF8tjvNFJmS5sq9g3UdfGN9tpJ4V2Xj3RgrGx?=
 =?us-ascii?Q?nKfM4gAcvuDFAAwmhiz501UvtMo4qs1L+PDdLdgR5oW1GQsGMbQ2+vdCGdEL?=
 =?us-ascii?Q?ZOhyyTWra4ug5gV43vK0J80+ONkSnsGA4wqR2PemCgRCPQux98abZ/ld1Uyd?=
 =?us-ascii?Q?jGhbt7f8k8u7AC50l8IviX2r2C5TbffSWdtLB7zL5mKIN1RmlqqIz7NGzjus?=
 =?us-ascii?Q?UpR83ocH0l33aMy5iWVz3k4WTAOB+etpksaw481MwjOWe+ez1jVRe/L4rNvi?=
 =?us-ascii?Q?8FQDaZzsuzizs92cpoJ15yml/VYTA9RFaZUZgTU/CMSMvBt85g5IYV4EgK8O?=
 =?us-ascii?Q?kVg/XfXn0TvaxE4R8PhDRNAJg6T/gcKriiUaG74/jxRyyUgcXjbCxUQBF3fk?=
 =?us-ascii?Q?VTJ9Cyx5WCybHwcYowvOM2WkFzkzRtegf1LDanS7c+lHbzD+xysvrSUZfY3C?=
 =?us-ascii?Q?M8qk2c2OyYIUU8RhddRRmRxWR3bvd+ycdjeGz1FfD2+KAWW4iwLHCioktgli?=
 =?us-ascii?Q?NbM4flzq35qncPwcrwQdUVDI75hrQH2y1s7M3B+l4t5DKa0hjnDCsqHZmZQH?=
 =?us-ascii?Q?29Qm2GKRfXD+Llj8geg3EPPFq6pW1p0GNPXYz1gIGBd5n2IG40h9wqPaZ9cL?=
 =?us-ascii?Q?PPVSDkoJEHHteNqgsOtGZ9GaOjyqAbxQ3rZabuTu8g6mkPXKLHCK5MBtnyLD?=
 =?us-ascii?Q?Ny+sajzi4PZ76hLqjcPeuzcs3pfkjRVpMvC3ROv4jpQhhNH6PYibOBtBLa0W?=
 =?us-ascii?Q?kblHysNHAl33FCLnvbWKWiqnV2VLA1SQBtMYJjre3uAW8nY9ECLYhbekuOvF?=
 =?us-ascii?Q?nQ7XTzC6LPbdqvnzYXRTGaeT7dxIY14dYFzhjIVrg27hFnu2hL3NYqQwN719?=
 =?us-ascii?Q?bC+/cOjSTZKxg9BkZBSTWdrD2xri0nG42yOzlf17+QwFStXTY2SolRjNW3Im?=
 =?us-ascii?Q?K9Vn6QRRI5hG93iApTT5Ymq8d1pPNQk7PckQylzDOoRvDwYrz2dKfL+AUktH?=
 =?us-ascii?Q?mFDn/p3Y5gIUqFQqJ8vwPmLZeZ5MpmQHLPpEy0bxpRJxM+YKdqJPjmBJWOG9?=
 =?us-ascii?Q?WZMYmzulhN3OG/RMd25jVTNudJe4cMuDxySapLojNPgPW3dy?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: L1c8wjVhXgn0FB38iyKnePpp8CW0fd23oY0502FKV2BwXHt1BnzTWBn+n97wW+VgKzayCMbQkIgTmpeLXsUV/a1w1mlNr5cSvG+xuZ+Dw2V+xrZRuHnUU/MZ1oBWK/HQ1F8xehzQJkvsMz1E7uk1hfq/PWz6kJtb/ihfboYYPPiJtwgBZNgs7HAH1FZGsG90go5Dwbg3HUSA1K9vKRT/F13rC/mBb/ZGiBoeiknwaJaTGHgvVlJ630O24iGTMqXrF6eeF+bdcPCyCGfAuteQc7BWxcAbNMejTYw8PEEsBWK1jHwglhgcOZifkKBREuanb28Wq6ijBNnOPBx3aULivA==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4676d1f-b99b-4cfe-2521-08df1a401a47
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2026 13:31:13.0963 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kTF7IkA8Ivhsqf3F3HeOt1rxNokejjqE7Fzk9JLpD5Kufp2fD8xZ2IhdQn0FKS/OpH0yznr6+21xXZOZQzQR7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF636580572
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA1NSBTYWx0ZWRfX8bkm7HJsZEiC
 sMIJ28cFSSzbCrKxbE0rh6mpaSdP5TmpEheZE5fojfSnTC9mN3CrrMSgOaGag+9uruL3PGbCsw3
 tg3a5VdCUHwq6Vm3R+7admTd6u23mIo=
X-Authority-Analysis: v=2.4 cv=fcI4WEQF c=1 sm=1 tr=0 ts=6ab5262a cx=c_pps
 a=EQiSdmqO/0h9UsHobtR7BQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8
 a=jneaijUwYWtlX6FD7BQA:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA1NSBTYWx0ZWRfX+uPDsXJH8nLn
 2wsJriTXs2QHgECDU3WBVY5Jv2QpSQSzEeeSv6MXvvNuFzsxx/3rt8n0uU+1AftY+JM94rJa5RO
 uMud0EbVQkY1yEVMB26L021XevrWlMHb3jEqMWh0PUYYpOYnUvgzxL7kOLgy8pWSUHpxokyPxeC
 Ia2c0ltqwS7OsbYO9xLGhB9yqsw4ZsnwDD4iF/OQAbjY4Cdvfu18paMV+bK4yXv4ZkdSM17LE9t
 9GsqCE4Nwde6Q8md1S3Z7jyaPGpXvZt2gP+BxSy8gQjgzxhVlsv1tmFp0y6QLVTc/G8n0qTYnVA
 VVPKYM47kTSx3JAVkucSg3ErFu81xGTT0fd9wXzV///xW9gY3BatjwdrQd9/8GGf7M7p6ARPfmy
 29dlsyH6anjmch1/dZ8b+tp0+foJv2/YWjLBmwXUANwZOd8Mv0DDij/czMuIARiFFEv+csfTrMT
 MEYlntIxoABnDC3cfhQ==
X-Proofpoint-GUID: rX17_tNyUvAL3kx_P4doe9aBXjYOZjXd
X-Proofpoint-ORIG-GUID: rX17_tNyUvAL3kx_P4doe9aBXjYOZjXd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_03,2026-09-21_02,2025-10-01_01
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

> Subject: [PATCH v2 8/8] app/test: add RSA-PSS sign and verify test cases

Rename test/crypto: add RSA-PSS sign and verify cases

>=20
> Add OpenSSL asymmetric tests for RSA-PSS sign and verify
> operations using SHA-256 with different salt length settings.
>=20
> Introduce test vectors covering digest-length salt, maximum
> supported salt length, and zero-length salt. Update the
> OpenSSL asym test suite to validate RSA-PSS functionality
> when supported by the device capabilities.
>=20
> Signed-off-by: Sucharitha Sarananaga <ssarananaga@marvell.com>
> ---
>  app/test/test_cryptodev_asym.c             | 307 +++++++++++++++++++++
>  app/test/test_cryptodev_rsa_test_vectors.h | 163 +++++++++++
>  2 files changed, 470 insertions(+)
>=20
> diff --git a/app/test/test_cryptodev_asym.c b/app/test/test_cryptodev_asy=
m.c
> index ceae029a4a..718b06aefa 100644
> --- a/app/test/test_cryptodev_asym.c
> +++ b/app/test/test_cryptodev_asym.c
> @@ -606,6 +606,307 @@
> test_rsa_oaep_labeled_default_mgf1_enc_dec_crt(void)
>  	return status;
>  }
>=20
> +/*
> + * Check that the device supports RSA-PSS padding, the hash used for
> + * the signature digest, and, if explicitly set, the MGF1 hash (this
> + * PMD defaults MGF1 to the same hash as the digest when unset).
> + */
> +static int
> +rsa_pss_supported(uint8_t dev_id, const struct rte_crypto_rsa_padding
> *padding)

Make return type as bool and rename as is_rsa_pss_supported()

> +{
> +	struct rte_cryptodev_asym_capability_idx idx =3D {
> +		.type =3D RTE_CRYPTO_ASYM_XFORM_RSA,
> +	};
> +	const struct rte_cryptodev_asymmetric_xform_capability *capa;
> +
> +	capa =3D rte_cryptodev_asym_capability_get(dev_id, &idx);
> +	if (capa =3D=3D NULL) {
> +		RTE_LOG(INFO, USER1, "RSA capability not reported by
> device\n");
> +		return 0;
> +	}
> +
> +	if (capa->rsa_capa.pad_types !=3D 0 &&
> +			(capa->rsa_capa.pad_types & (1 <<
> RTE_CRYPTO_RSA_PADDING_PSS)) =3D=3D 0) {
> +		RTE_LOG(INFO, USER1,
> +			"RSA PSS padding not supported by device. Supported
> pad_types=3D%#x\n",
> +			capa->rsa_capa.pad_types);
> +		return 0;
> +	}
> +
> +	if (!rte_cryptodev_asym_xform_capability_check_hash(capa, padding-
> >hash)) {
> +		RTE_LOG(INFO, USER1,
> +			"RSA PSS hash %u not supported by device capabilities "
> +			"(supported hash_algos=3D%#"PRIx64")\n",
> +			padding->hash, capa->hash_algos);
> +		return 0;
> +	}
> +
> +	if (padding->mgf1hash !=3D 0 &&
> +			(capa->rsa_capa.mgf1_hash_algos &
> RTE_BIT64(padding->mgf1hash)) =3D=3D 0) {
> +		RTE_LOG(INFO, USER1,
> +			"RSA PSS MGF1 hash %u not supported by device
> capabilities "
> +			"(supported mgf1_hash_algos=3D%#"PRIx64")\n",
> +			padding->mgf1hash, capa->rsa_capa.mgf1_hash_algos);
> +		return 0;
> +	}
> +
> +	return 1;
> +}
> +
> +/*
> + * Sign then verify the freshly-generated signature. Unlike
> + * queue_ops_rsa_sign_verify(), this does not include a
> + * corrupted-signature negative test: RSA-PSS verification does not
> + * support verify-recover, and mismatches are reported via op->status.
> + */
> +static int
> +queue_ops_rsa_pss_sign_verify(void *sess)
> +{
> +	struct crypto_testsuite_params_asym *ts_params =3D &testsuite_params;
> +	struct rte_mempool *op_mpool =3D ts_params->op_mpool;
> +	uint8_t dev_id =3D ts_params->valid_devs[0];
> +	struct rte_crypto_op *op, *result_op;
> +	struct rte_crypto_asym_op *asym_op;
> +	uint8_t output_buf[TEST_DATA_SIZE];
> +	int status;
> +
> +	/* Set up crypto op data structure */
> +	op =3D rte_crypto_op_alloc(op_mpool,
> RTE_CRYPTO_OP_TYPE_ASYMMETRIC);
> +	if (!op) {
> +		RTE_LOG(ERR, USER1, "Failed to allocate asymmetric crypto "
> +			"operation struct\n");
> +		return TEST_FAILED;
> +	}
> +
> +	asym_op =3D op->asym;
> +
> +	/* Compute sign on the test vector */
> +	asym_op->rsa.op_type =3D RTE_CRYPTO_ASYM_OP_SIGN;
> +
> +	/*
> +	 * RTE_CRYPTO_RSA_PADDING_PSS expects message to already be a
> +	 * digest hashed with the algorithm configured in the session's
> +	 * padding.hash (SHA-256 here), not the raw plaintext.
> +	 */
> +	asym_op->rsa.message.data =3D rsa_pss_digest_sha256.data;
> +	asym_op->rsa.message.length =3D rsa_pss_digest_sha256.len;
> +	asym_op->rsa.sign.length =3D RTE_DIM(rsa_n);
> +	asym_op->rsa.sign.data =3D output_buf;
> +
> +	debug_hexdump(stdout, "digest", asym_op->rsa.message.data,
> +		      asym_op->rsa.message.length);
> +
> +	/* Attach asymmetric crypto session to crypto operations */
> +	rte_crypto_op_attach_asym_session(op, sess);
> +
> +	RTE_LOG(DEBUG, USER1, "Process ASYM operation\n");
> +
> +	/* Process crypto operation */
> +	if (rte_cryptodev_enqueue_burst(dev_id, 0, &op, 1) !=3D 1) {
> +		RTE_LOG(ERR, USER1, "Error sending packet for sign\n");
> +		status =3D TEST_FAILED;
> +		goto error_exit;
> +	}
> +
> +	while (rte_cryptodev_dequeue_burst(dev_id, 0, &result_op, 1) =3D=3D 0)
> +		rte_pause();
> +
> +	if (result_op =3D=3D NULL) {
> +		RTE_LOG(ERR, USER1, "Failed to process sign op\n");
> +		status =3D TEST_FAILED;
> +		goto error_exit;
> +	}
> +
> +	if (result_op->status !=3D RTE_CRYPTO_OP_STATUS_SUCCESS) {
> +		RTE_LOG(ERR, USER1, "Failed to process PSS sign op\n");
> +		status =3D TEST_FAILED;
> +		goto error_exit;
> +	}
> +
> +	debug_hexdump(stdout, "signed message", asym_op->rsa.sign.data,
> +		      asym_op->rsa.sign.length);
> +	asym_op =3D result_op->asym;
> +
> +	/* Verify sign */
> +	asym_op->rsa.op_type =3D RTE_CRYPTO_ASYM_OP_VERIFY;
> +
> +	/* Process crypto operation */
> +	if (rte_cryptodev_enqueue_burst(dev_id, 0, &op, 1) !=3D 1) {
> +		RTE_LOG(ERR, USER1, "Error sending packet for verify\n");
> +		status =3D TEST_FAILED;
> +		goto error_exit;
> +	}
> +
> +	while (rte_cryptodev_dequeue_burst(dev_id, 0, &result_op, 1) =3D=3D 0)
> +		rte_pause();
> +
> +	if (result_op =3D=3D NULL) {
> +		RTE_LOG(ERR, USER1, "Failed to process verify op\n");
> +		status =3D TEST_FAILED;
> +		goto error_exit;
> +	}
> +
> +	if (result_op->status !=3D RTE_CRYPTO_OP_STATUS_SUCCESS) {
> +		RTE_LOG(ERR, USER1, "Failed to process PSS sign-verify op\n");
> +		status =3D TEST_FAILED;
> +		goto error_exit;
> +	}
> +
> +	status =3D TEST_SUCCESS;
> +error_exit:
> +
> +	rte_crypto_op_free(op);
> +
> +	return status;
> +}
> +
> +static int
> +test_rsa_pss_sign_verify_digest_saltlen(void)
> +{
> +	struct crypto_testsuite_params_asym *ts_params =3D &testsuite_params;
> +	struct rte_mempool *sess_mpool =3D ts_params->session_mpool;
> +	struct rte_cryptodev_asym_capability_idx idx;
> +	uint8_t dev_id =3D ts_params->valid_devs[0];
> +	struct rte_crypto_asym_xform xform;
> +	void *sess =3D NULL;
> +	struct rte_cryptodev_info dev_info;
> +	int ret, status =3D TEST_SUCCESS;
> +
> +	idx.type =3D RTE_CRYPTO_ASYM_XFORM_RSA;
> +	if (rte_cryptodev_asym_capability_get(dev_id, &idx) =3D=3D NULL)
> +		return -ENOTSUP;
> +
> +	if (!rsa_pss_supported(dev_id, &rsa_pss_xform.rsa.padding)) {
> +		RTE_LOG(INFO, USER1, "RSA PSS not supported. Test
> skipped\n");
> +		return TEST_SKIPPED;
> +	}
> +
> +	rte_cryptodev_info_get(dev_id, &dev_info);
> +	if (!(dev_info.feature_flags &
> +				RTE_CRYPTODEV_FF_RSA_PRIV_OP_KEY_EXP))
> {
> +		RTE_LOG(INFO, USER1, "Device doesn't support sign op with "
> +			"exponent key type. Test skipped\n");
> +		return TEST_SKIPPED;
> +	}
> +
> +	memcpy(&xform, &rsa_pss_xform, sizeof(rsa_pss_xform));
> +	xform.rsa.key_type =3D RTE_RSA_KEY_TYPE_EXP;
> +
> +	ret =3D rte_cryptodev_asym_session_create(dev_id, &xform, sess_mpool,
> &sess);
> +	if (ret < 0) {
> +		RTE_LOG(ERR, USER1, "Session creation failed for "
> +			"PSS sign_verify (saltlen =3D digest length)\n");
> +		status =3D (ret =3D=3D -ENOTSUP) ? TEST_SKIPPED : TEST_FAILED;
> +		goto error_exit;
> +	}
> +
> +	status =3D queue_ops_rsa_pss_sign_verify(sess);
> +
> +error_exit:
> +	rte_cryptodev_asym_session_free(dev_id, sess);
> +	TEST_ASSERT_EQUAL(status, 0, "Test failed");
> +
> +	return status;
> +}
> +
> +static int
> +test_rsa_pss_sign_verify_max_saltlen(void)
> +{
> +	struct crypto_testsuite_params_asym *ts_params =3D &testsuite_params;
> +	struct rte_mempool *sess_mpool =3D ts_params->session_mpool;
> +	struct rte_cryptodev_asym_capability_idx idx;
> +	uint8_t dev_id =3D ts_params->valid_devs[0];
> +	struct rte_crypto_asym_xform xform;
> +	void *sess =3D NULL;
> +	struct rte_cryptodev_info dev_info;
> +	int ret, status =3D TEST_SUCCESS;
> +
> +	idx.type =3D RTE_CRYPTO_ASYM_XFORM_RSA;
> +	if (rte_cryptodev_asym_capability_get(dev_id, &idx) =3D=3D NULL)
> +		return -ENOTSUP;
> +
> +	if (!rsa_pss_supported(dev_id, &rsa_pss_max_salt_xform.rsa.padding)) {
> +		RTE_LOG(INFO, USER1, "RSA PSS not supported. Test
> skipped\n");
> +		return TEST_SKIPPED;
> +	}
> +
> +	rte_cryptodev_info_get(dev_id, &dev_info);
> +	if (!(dev_info.feature_flags &
> +				RTE_CRYPTODEV_FF_RSA_PRIV_OP_KEY_EXP))
> {
> +		RTE_LOG(INFO, USER1, "Device doesn't support sign op with "
> +			"exponent key type. Test skipped\n");
> +		return TEST_SKIPPED;
> +	}
> +
> +	memcpy(&xform, &rsa_pss_max_salt_xform,
> sizeof(rsa_pss_max_salt_xform));
> +	xform.rsa.key_type =3D RTE_RSA_KEY_TYPE_EXP;
> +
> +	ret =3D rte_cryptodev_asym_session_create(dev_id, &xform, sess_mpool,
> &sess);
> +	if (ret < 0) {
> +		RTE_LOG(ERR, USER1, "Session creation failed for "
> +			"PSS sign_verify (max saltlen)\n");
> +		status =3D (ret =3D=3D -ENOTSUP) ? TEST_SKIPPED : TEST_FAILED;
> +		goto error_exit;
> +	}
> +
> +	status =3D queue_ops_rsa_pss_sign_verify(sess);
> +
> +error_exit:
> +	rte_cryptodev_asym_session_free(dev_id, sess);
> +	TEST_ASSERT_EQUAL(status, 0, "Test failed");
> +
> +	return status;
> +}
> +
> +static int
> +test_rsa_pss_sign_verify_zero_saltlen(void)
> +{
> +	struct crypto_testsuite_params_asym *ts_params =3D &testsuite_params;
> +	struct rte_mempool *sess_mpool =3D ts_params->session_mpool;
> +	struct rte_cryptodev_asym_capability_idx idx;
> +	uint8_t dev_id =3D ts_params->valid_devs[0];
> +	struct rte_crypto_asym_xform xform;
> +	void *sess =3D NULL;
> +	struct rte_cryptodev_info dev_info;
> +	int ret, status =3D TEST_SUCCESS;
> +
> +	idx.type =3D RTE_CRYPTO_ASYM_XFORM_RSA;
> +	if (rte_cryptodev_asym_capability_get(dev_id, &idx) =3D=3D NULL)
> +		return -ENOTSUP;
> +
> +	if (!rsa_pss_supported(dev_id, &rsa_pss_zero_salt_xform.rsa.padding)) {
> +		RTE_LOG(INFO, USER1, "RSA PSS not supported. Test
> skipped\n");
> +		return TEST_SKIPPED;
> +	}
> +
> +	rte_cryptodev_info_get(dev_id, &dev_info);
> +	if (!(dev_info.feature_flags &
> +				RTE_CRYPTODEV_FF_RSA_PRIV_OP_KEY_EXP))
> {
> +		RTE_LOG(INFO, USER1, "Device doesn't support sign op with "
> +			"exponent key type. Test skipped\n");
> +		return TEST_SKIPPED;
> +	}
> +
> +	memcpy(&xform, &rsa_pss_zero_salt_xform,
> sizeof(rsa_pss_zero_salt_xform));
> +	xform.rsa.key_type =3D RTE_RSA_KEY_TYPE_EXP;
> +
> +	ret =3D rte_cryptodev_asym_session_create(dev_id, &xform, sess_mpool,
> &sess);
> +	if (ret < 0) {
> +		RTE_LOG(ERR, USER1, "Session creation failed for "
> +			"PSS sign_verify (zero saltlen)\n");
> +		status =3D (ret =3D=3D -ENOTSUP) ? TEST_SKIPPED : TEST_FAILED;
> +		goto error_exit;
> +	}
> +
> +	status =3D queue_ops_rsa_pss_sign_verify(sess);
> +
> +error_exit:
> +	rte_cryptodev_asym_session_free(dev_id, sess);
> +	TEST_ASSERT_EQUAL(status, 0, "Test failed");
> +
> +	return status;
> +}
> +
>  static int
>  test_rsa_sign_verify(void)
>  {
> @@ -5705,6 +6006,12 @@ static struct unit_test_suite
> cryptodev_asym_rsa_testsuite =3D {
>=20
> 	test_rsa_oaep_labeled_default_mgf1_enc_dec),
>  		TEST_CASE_ST(ut_setup_asym, ut_teardown_asym,
>=20
> 	test_rsa_oaep_labeled_default_mgf1_enc_dec_crt),
> +		TEST_CASE_ST(ut_setup_asym, ut_teardown_asym,
> +				test_rsa_pss_sign_verify_digest_saltlen),
> +		TEST_CASE_ST(ut_setup_asym, ut_teardown_asym,
> +				test_rsa_pss_sign_verify_max_saltlen),
> +		TEST_CASE_ST(ut_setup_asym, ut_teardown_asym,
> +				test_rsa_pss_sign_verify_zero_saltlen),
>  		/* RSA EXP */
>  		TEST_CASE_NAMED_WITH_DATA(
>  			"RSA Encryption (n=3D128, pt=3D20, e=3D3) EXP, Padding:
> NONE",
> diff --git a/app/test/test_cryptodev_rsa_test_vectors.h
> b/app/test/test_cryptodev_rsa_test_vectors.h
> index 6835453b6d..f35a83c016 100644
> --- a/app/test/test_cryptodev_rsa_test_vectors.h
> +++ b/app/test/test_cryptodev_rsa_test_vectors.h
> @@ -251,6 +251,23 @@ struct rsa_test_data rsaplaintext =3D {
>  	.len =3D 20
>  };
>=20
> +/*
> + * SHA-256 digest of rsaplaintext.data. RTE_CRYPTO_RSA_PADDING_PSS
> + * expects rte_crypto_rsa_op_param::message to already be a digest
> + * hashed with the algorithm configured in rte_crypto_rsa_padding::hash
> + * (SHA-256 for the PSS xforms below), not the raw message, so PSS
> + * sign/verify tests use this instead of rsaplaintext directly.
> + */
> +struct rsa_test_data rsa_pss_digest_sha256 =3D {
> +	.data =3D {
> +		0x45, 0x24, 0x54, 0x32, 0x9d, 0x91, 0xda, 0x1b,
> +		0xb8, 0x76, 0x0d, 0x9b, 0xdd, 0xea, 0xe5, 0x21,
> +		0x30, 0x91, 0x72, 0xb0, 0x9c, 0x23, 0x12, 0x3f,
> +		0xb3, 0x43, 0x09, 0x5d, 0xa3, 0x10, 0x78, 0x7c
> +	},
> +	.len =3D 32
> +};

Mark as const=20


> +
>  uint8_t rsa_n[] =3D {
>  	0xb3, 0xa1, 0xaf, 0xb7, 0x13, 0x08, 0x00,
>  	0x0a, 0x35, 0xdc, 0x2b, 0x20, 0x8d, 0xa1, 0xb5,
> @@ -538,4 +555,150 @@ struct rte_crypto_asym_xform
> rsa_oaep_labeled_default_mgf1_xform =3D {
>  	}
>  };
>=20
> +/*
> + * RSA-PSS xforms below all use the same 1024-bit test key (rsa_n, 128
> + * bytes) and SHA-256 (hLen =3D 32 bytes). For this key/hash combination=
:
> + *   emBits =3D modBits - 1 =3D 1023, emLen =3D ceil(emBits / 8) =3D 128
> + *   maxSaltLen =3D emLen - hLen - 2 =3D 128 - 32 - 2 =3D 94
> + * (see RFC 8017 EMSA-PSS-ENCODE, section 9.1.1)
> + */
> +
> +/** rsa PSS xform (SHA-256, salt length =3D digest length, QT private ke=
y type by
> default) */
> +struct rte_crypto_asym_xform rsa_pss_xform =3D {
> +	.next =3D NULL,
> +	.xform_type =3D RTE_CRYPTO_ASYM_XFORM_RSA,
> +	.rsa =3D {
> +		.padding.type =3D RTE_CRYPTO_RSA_PADDING_PSS,
> +		.padding.hash =3D RTE_CRYPTO_AUTH_SHA256,
> +		.padding.pss_saltlen =3D 32,
> +		.n =3D {
> +			.data =3D rsa_n,
> +			.length =3D sizeof(rsa_n)
> +		},
> +		.e =3D {
> +			.data =3D rsa_e,
> +			.length =3D sizeof(rsa_e)
> +		},
> +		.qt =3D {
> +			.p =3D {
> +				.data =3D rsa_p,
> +				.length =3D sizeof(rsa_p)
> +			},
> +			.q =3D {
> +				.data =3D rsa_q,
> +				.length =3D sizeof(rsa_q)
> +			},
> +			.dP =3D {
> +				.data =3D rsa_dP,
> +				.length =3D sizeof(rsa_dP)
> +			},
> +			.dQ =3D {
> +				.data =3D rsa_dQ,
> +				.length =3D sizeof(rsa_dQ)
> +			},
> +			.qInv =3D {
> +				.data =3D rsa_qInv,
> +				.length =3D sizeof(rsa_qInv)
> +			},
> +		},
> +		.d =3D {
> +			.data =3D rsa_d,
> +			.length =3D sizeof(rsa_d)
> +		},
> +		.key_type =3D RTE_RSA_KEY_TYPE_QT
> +	}
> +};
> +
> +/** rsa PSS xform with the maximum permissible salt length (94 bytes) */
> +struct rte_crypto_asym_xform rsa_pss_max_salt_xform =3D {
> +	.next =3D NULL,
> +	.xform_type =3D RTE_CRYPTO_ASYM_XFORM_RSA,
> +	.rsa =3D {
> +		.padding.type =3D RTE_CRYPTO_RSA_PADDING_PSS,
> +		.padding.hash =3D RTE_CRYPTO_AUTH_SHA256,
> +		.padding.pss_saltlen =3D 94,
> +		.n =3D {
> +			.data =3D rsa_n,
> +			.length =3D sizeof(rsa_n)
> +		},
> +		.e =3D {
> +			.data =3D rsa_e,
> +			.length =3D sizeof(rsa_e)
> +		},
> +		.qt =3D {
> +			.p =3D {
> +				.data =3D rsa_p,
> +				.length =3D sizeof(rsa_p)
> +			},
> +			.q =3D {
> +				.data =3D rsa_q,
> +				.length =3D sizeof(rsa_q)
> +			},
> +			.dP =3D {
> +				.data =3D rsa_dP,
> +				.length =3D sizeof(rsa_dP)
> +			},
> +			.dQ =3D {
> +				.data =3D rsa_dQ,
> +				.length =3D sizeof(rsa_dQ)
> +			},
> +			.qInv =3D {
> +				.data =3D rsa_qInv,
> +				.length =3D sizeof(rsa_qInv)
> +			},
> +		},
> +		.d =3D {
> +			.data =3D rsa_d,
> +			.length =3D sizeof(rsa_d)
> +		},
> +		.key_type =3D RTE_RSA_KEY_TYPE_QT
> +	}
> +};
> +
> +/** rsa PSS xform with zero-length salt (deterministic PSS, no randomiza=
tion) */
> +struct rte_crypto_asym_xform rsa_pss_zero_salt_xform =3D {
> +	.next =3D NULL,
> +	.xform_type =3D RTE_CRYPTO_ASYM_XFORM_RSA,
> +	.rsa =3D {
> +		.padding.type =3D RTE_CRYPTO_RSA_PADDING_PSS,
> +		.padding.hash =3D RTE_CRYPTO_AUTH_SHA256,
> +		.padding.pss_saltlen =3D 0, /* no salt bytes */
> +		.n =3D {
> +			.data =3D rsa_n,
> +			.length =3D sizeof(rsa_n)
> +		},
> +		.e =3D {
> +			.data =3D rsa_e,
> +			.length =3D sizeof(rsa_e)
> +		},
> +		.qt =3D {
> +			.p =3D {
> +				.data =3D rsa_p,
> +				.length =3D sizeof(rsa_p)
> +			},
> +			.q =3D {
> +				.data =3D rsa_q,
> +				.length =3D sizeof(rsa_q)
> +			},
> +			.dP =3D {
> +				.data =3D rsa_dP,
> +				.length =3D sizeof(rsa_dP)
> +			},
> +			.dQ =3D {
> +				.data =3D rsa_dQ,
> +				.length =3D sizeof(rsa_dQ)
> +			},
> +			.qInv =3D {
> +				.data =3D rsa_qInv,
> +				.length =3D sizeof(rsa_qInv)
> +			},
> +		},
> +		.d =3D {
> +			.data =3D rsa_d,
> +			.length =3D sizeof(rsa_d)
> +		},
> +		.key_type =3D RTE_RSA_KEY_TYPE_QT
> +	}
> +};
> +
>  #endif /* TEST_CRYPTODEV_RSA_TEST_VECTORS_H__ */
> --
> 2.54.0

