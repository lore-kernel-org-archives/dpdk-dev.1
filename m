Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F8BC9831A
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Sep 2026 12:14:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 19D8E400EF;
	Thu, 24 Sep 2026 14:14:16 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 4BF9F400D7
 for <dev@dpdk.org>; Thu, 24 Sep 2026 14:14:14 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OC74q6514422; Thu, 24 Sep 2026 05:14:13 -0700
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11020132.outbound.protection.outlook.com
 [52.101.193.132])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gvm3kky5p-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 05:14:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PZVJOZVOHDgyWQz1JmFoRn95Y3FvI4THpocUdDWo0MiACSifhDokHPk3WKaQEaxGuJ++BD6R2IdOC1Ccr0AD4FqPZTmSrQRgeGRcNblGHbfQf7c0LX46IuWmk7cNtouXgGNhBR3ubzOSP/x85YN8jaj3Y14FS8/sBLe3cYeuLFZXDi0jf804axvcKr6/scm5zUgYfiKAvty3kbxKfT6tfvV1xuInvZzZBSFRpRVFRwys4GM9ax9YKHA9BwX+Hf09/1DyMEmNwR38PzcnZIOmZfJJ8xa6vvyargEG1+3hTIzDcAlgRSYIx0+zCmVj5XZPDh3gb0G1J/ujNEd8tBeInQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yl0E6YFgIO5hY+5Wc5JIjiJrhm8vxWa+ns/wy2ZH3/g=;
 b=q3rtnszHvZZpxOxRExjoWs43bCIyxi/FqTtNVXJSj41rL20pWcpacGb+E225sEAOJ0TiRGx+AspfNB8IBqk1JIRpeO5NGZZKUw9d8LTYi3xyOg9lPiDoCR0mXLh8WRxG+r0e9r4OfPtz5E34iDziyO97rYoo3vJffvFxERnm8kKFKflDIH2HfgiR/DP/Rgsnt3Jx142R+ZjrqPEbd/V+DmlGrDBvneAsgiOGWv098UIjhq2OAvRZVGXu3zLluqgN0wAdrN3Gi9h1sqnBUgwW85hghUdTXBTdPG8Pa8YKq3fap8GCxWR+nUVdwD1hOHNpEfPJnaNfQ75pZq5/GRQmEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yl0E6YFgIO5hY+5Wc5JIjiJrhm8vxWa+ns/wy2ZH3/g=;
 b=AM/Cw9PZMuW60KBD/TMXburKP2vnXEC8CVzb5jgJ2pnB6rBy8me/+GbgbuEfTj9xkmjMPCc/+ASt/YJ23uaUuNUvrOvbK+QlCbHyONNr2vN4uV4eWTzgQIwMVmogkmrSjdLOxp0kSTMLVY7bWBtWxTorrqxlprq0cPFvs+J4Y84=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 IA3PR18MB6234.namprd18.prod.outlook.com (2603:10b6:208:51f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 12:14:01 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%5]) with mapi id 15.21.0428.015; Thu, 24 Sep 2026
 12:14:01 +0000
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
Subject: RE: [PATCH v2 5/8] crypto/openssl: add RSA-OAEP support for OpenSSL
 PMD
Thread-Topic: [PATCH v2 5/8] crypto/openssl: add RSA-OAEP support for OpenSSL
 PMD
Thread-Index: AQHdO34QKQEuNTOI4kqaiLFo7JM0BbbdwZwg
Date: Thu, 24 Sep 2026 12:14:01 +0000
Message-ID: <CO6PR18MB44843B5EA9AC06F7A1201AF8D8812@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20260831102328.2813604-1-ssarananaga@marvell.com>
 <20260903082648.3610676-1-ssarananaga@marvell.com>
 <20260903082648.3610676-6-ssarananaga@marvell.com>
In-Reply-To: <20260903082648.3610676-6-ssarananaga@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=marvell.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|IA3PR18MB6234:EE_
x-ms-office365-filtering-correlation-id: 4d145834-e9b6-4902-5624-08df1a355169
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|38070700021|3023799007|6133799003|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: bcTOL09f1sQVb7irs85j2jHqwwaW+5UDLWWEt7OrThIcgtSexBoyrlMGYq39RgZzbx0h1fgxz+Pw/e4n52uNfgogydFCUjShXMfkpAQJAa9IP6uhWiCeUWffNWLsAYVBnFwNGobkuGbm4EuVKr/Ho3jFLUt0aaIbzfVDhc4ze3oHW0AzYAFGWcRiw84yKE6P0IbyWW5gti88GvrfjGFyFaWhNiwB+83zpQOt80knQkmUZFus0xj2B6xOSkl290X5JzT5aLr8H8It8w86E9wOKExm8KPobMs5xje1N+UeSV0kcQIhS14R6NwdpcLXI+cLgDk72NTXbG+T7NWO0lqxvlBFILTUmIA8VB9cdtiILQLb2URWW+FjwB7mQgB6fI2CStpt/44VUJ6HNwBI7f256r9X5QqNQO+FrPgHtDC9JUC9Mz/W/JQjrMSWh5JBZlsQeuN/gODcw4MY+LxrXAkT+qwIkOFIRd5QaRMP/7GkB1sw5WGAKtNJMx9wz5xhywrNMG4zSwE8zf1f5vm8MpnIVkIX4+e///9s03DhztvZR6lwQ0l8RvukkHG8HJlsCV12sJyOWgOsBDTmTppvqfivBJCg6KtGjjjUb4Wo2MLhOn6Io4gBmdUtqfw0CKyNR4iD8BC1Fq10fNznN1AL5LiA2tERjgJc7TJZSTXCGtCGmO5eylFkDnP6MUCHWdtf0d4OemYwUvD1IGg+Gko4uEWr8v0gN+a9SCvacrEQkZOoAl4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(3023799007)(6133799003)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pC0Q/aMjHsFOjZK7E6/DQu8SUJwAWvlhA344rhOE8Jg+5e5zSmSgz8oFbUq8?=
 =?us-ascii?Q?OlSsOC49rrfN2ehv0xDDGG1b/FMgwdZPNe/vBgwbYDbHuGlxmVSKCTK6yoDK?=
 =?us-ascii?Q?nIGnRpE2E9Cp0i5aJIIzHYs4y9Hav0NRXI3CHzju7lZx6SMj9rvSYc1RlqQu?=
 =?us-ascii?Q?cSuLepdeVRnJcWLl6H5iEzfdaL/BBfNqGLgPVRymNuL66tn4mOVwkI/O/1pI?=
 =?us-ascii?Q?Mk5O9dMG8YYy0EQENs6cpHr2Aq2sSswx3WKTpScqO8zNFSQGJGnnVldN91ZG?=
 =?us-ascii?Q?WAwjtgBgXEsQLgZ/zb7+A6VTmxwPq0IUAec7sfxwdkbSyHO/EPA4RNLs/lnh?=
 =?us-ascii?Q?gXNeZygfbRautTjAP27w/P+7XA/ATFq1wN77nBKgXJM/KfN9pBZ6pCTR4jRT?=
 =?us-ascii?Q?uwsNZqhpocn3a/LqabY75ma+0vjGz0m1ajmGLsaobK8D6dJ4E/Af5KaVKUDN?=
 =?us-ascii?Q?Cxs4o52OB5rl8k6Xc95+Cd30ec158NY+9AmawkhN3S0lQmf8LEQUPI4p+0tU?=
 =?us-ascii?Q?vlpyRQOUF9vNV/k5itR7t3fWQNdtowv18Q4z6jqHibAAMSCofB1kzVYaIRxG?=
 =?us-ascii?Q?xtkudp23nLi9sHqNhH0VqgViIYpW9JT7Rp57eJgiM6FhEVAvzACOBgqskQH8?=
 =?us-ascii?Q?61UgCEk9fVTak052LtJFZ2YE8jRRf2kVmn6RZ4j4wpu//ulWRTDIYPyx7Nl6?=
 =?us-ascii?Q?G2qLBsxYecjmtk0WjreBmKIuc12YR5mBk0StX/VbF0YbMS/pNJM9W1cfvdsV?=
 =?us-ascii?Q?XB+NZlq2eosNJHvvFGoYsfYFqK1vlRmnri1+1FUIqvP8uTFxk1n1nnctZviK?=
 =?us-ascii?Q?2SdIOtkcuP/lPuNy8QWxqnJlnnj1TPP0R10Xe1taq+++dtsoG8qb9Ts6AAdk?=
 =?us-ascii?Q?i4W2ReaUK0leuECyTTMoYALiO1PzJn5UeQVbVlmy5NmesCRB+RP2LHQhToxQ?=
 =?us-ascii?Q?sNhWeRFv+CcJ6DTWHgsAI3mFDDAXNLxYXdTGhuakaaGLWJPtoWKs7wxENXeD?=
 =?us-ascii?Q?kQgDadwoXkXSCPtaw/KOYI3+21C1akyKGojnNvo6nbcKoNKMyFnEfoAopvXi?=
 =?us-ascii?Q?a6okup1jlgi9xn+s5nEQX+6n31HWPPxM634hXkPeJq4GQPVn3I6zHzCUVHDO?=
 =?us-ascii?Q?snzPyxW99NgARy3HFXRtR7+ebUXvXTsUSk9u6K59VLQsom07pl1KNvXKfz6c?=
 =?us-ascii?Q?ZC1t1T7W2PSAfmmysv3wNBLPgpuIrs4fNM6xVzYZ6vtnTVGgk6QiKaXH9hkm?=
 =?us-ascii?Q?q3Q+jTACarrJ3FlTBR+ydWVLmwa2W6NTqQKhhlVf54th7pMC78Iiemlc6yum?=
 =?us-ascii?Q?bNTlNaCVi1pCDU1HCI4Ny5FgQJ/RQU4xpjZB1vjk9exDE7ckb3QZRQcRXwWn?=
 =?us-ascii?Q?JKD4qbiz43Eaw1h4eEv7TN5g9mYKa6atEOR6myMMuuySTl5djXik2lxJ4Tpk?=
 =?us-ascii?Q?uBMdiDhuRiVcdJKfAt3oOzJmQEFC1mm2oHxd/fekaRWJfDDak4bs6XZOsWH6?=
 =?us-ascii?Q?5y3kUtCufx5bpGHM8DeZW5GQlUALYfR27jQpoNjwLmQC4VaEmT/kKuKSw+5w?=
 =?us-ascii?Q?Cg2QIXCz2YcdXbBbE/VXKKSZb4tPsWjlzuEf5eblq/1CHlPv+74+zqpKGKn3?=
 =?us-ascii?Q?ai2ev39x5e79AvZeRx8vKkRUDimDb/Kd/B0HJt19oLaGtmYNYv97noVxXKLR?=
 =?us-ascii?Q?Cigk6JUvWJzSriX9jU1huIrMik8kz9SSliJGIw4I4aVYV6KN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: jWq1nYzjY1Nrh3Nl4WLaAR8uY30neESeLAncj03/4xPR4vCOtPuq+unNDbPz7+FdCyN65o6NOJMX2UyRfciQK9JkCgTZYdMn8zpNOYO7J8ibpZcI2yFGi4HSt2/CHIZymP1LaQYmMJcN74+As1k/iizFgY/EwOREeJctLaF0Iwm1pSxlNWDA+sznlYKIyIEZ/qIuOF+bF7iV8IidE6tUDJp27w5Dwqms5cVYB8GtdgPWIHcDy0XBRLX1rAu5B9W7KuuCYn7m3L6b6EnVCGtWWw3O3g7x0+L7VrNR80Jxdca8H7HJ3F7t9s0Qvigdp+9jtovZkCPuTuE4YxWcMXvgbA==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d145834-e9b6-4902-5624-08df1a355169
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2026 12:14:01.1305 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ElFWtLAMPkoh+/oJZ7MNKyK1tsFON7aLc4R5RbYJ3l3GNMnkmFATa5YF8hlgXjWV22jBB3n7a4/NLi/YxfdVYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR18MB6234
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA1MCBTYWx0ZWRfX4qfTUhNptwzV
 fwsRtpEgysLkQMM2ZtoCk+QMEZqhNSA1LKOxrBzP6V/wlne7UuU8okZr0bgtN0dzRwEZe+uUNjm
 L/ZcPEpi++/7uFUwITE5pTngEjrCKGfnBkYDv3+eRk4tzCfl4kgrv61lfNp1hhjPGwQgASLnamJ
 X+MuzRvXOm+N8/TOYtMvULyjLpFc7VyZTnvI4AkI+/waAtG1lFW0V+RWvrYs9AnAwgP2PDehF0Q
 29oczmCwshQIlQu3DYpBMaHIEHHAIJ9v3FNMCCUiu8nD+ZiIAL1HWHer+MYzMPJF4OE0k9l2M/A
 /cAfxDQFqKF1ICtHZAjGqIbRwh0myxMbyzBNR4VN3P95u0no7VSFY+lzfIZUU6h/4gklwdP+wbo
 3TF3K0pxZFV0MciyxOT0IgBodQh2m0pScJ48PeDQOE9coCxp+Ee86Fkmz0G9z30Zqs2f8KOu+7b
 HtN9c6o3I6HwK/SI9xQ==
X-Proofpoint-ORIG-GUID: VVih1d9PN9SyV2yaG5TKQc5XSfwcyrso
X-Proofpoint-GUID: VVih1d9PN9SyV2yaG5TKQc5XSfwcyrso
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA1MCBTYWx0ZWRfX7UAnDaQaczy+
 oVW53beeoe5HLeHDk85GKLato1brP1E27HFp7Zdla43XXr/tj5t45zLOxHNfRh5tvXZ0MPOEGLW
 Aw0EZ48Z5qWrvFHfGcrhCCbWaXhPfDU=
X-Authority-Analysis: v=2.4 cv=LtQHWXdc c=1 sm=1 tr=0 ts=6ab51414 cx=c_pps
 a=wDYKio+nLET07hVCmQyIug==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8
 a=MOuD_mYM1BxtR4LIWnMA:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
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

> Subject: [PATCH v2 5/8] crypto/openssl: add RSA-OAEP support for OpenSSL =
PMD
Rename to crypto/openssl: support RSA-OAEP

>=20
> Add support for RSA OAEP padding in the OpenSSL PMD OpenSSL 3.x
> implementation.
>=20
> Store OAEP configuration parameters in the RSA asymmetric session,
> including the OAEP hash, MGF1 hash, and optional label. Configure
> these parameters on the EVP_PKEY context during RSA encrypt and
> decrypt operations, and default the MGF1 hash to the OAEP hash when
> not specified by the application.
>=20
> Validate OAEP-specific usage, restrict it to encrypt/decrypt
> operations, and add proper cleanup of allocated label resources on
> error and session teardown paths.
>=20
> Signed-off-by: Sucharitha Sarananaga <ssarananaga@marvell.com>
> ---
>  drivers/crypto/openssl/openssl_pmd_private.h |  5 ++
>  drivers/crypto/openssl/rte_openssl_pmd.c     | 53 ++++++++++++
>  drivers/crypto/openssl/rte_openssl_pmd_ops.c | 90 ++++++++++++++++++++
>  3 files changed, 148 insertions(+)
>=20
> diff --git a/drivers/crypto/openssl/openssl_pmd_private.h
> b/drivers/crypto/openssl/openssl_pmd_private.h
> index ab40012d61..8704e1915a 100644
> --- a/drivers/crypto/openssl/openssl_pmd_private.h
> +++ b/drivers/crypto/openssl/openssl_pmd_private.h
> @@ -181,6 +181,11 @@ struct __rte_cache_aligned openssl_asym_session {
>  			RSA *rsa;
>  			uint32_t pad;
>  			EVP_PKEY_CTX * ctx;
> +			const EVP_MD *oaep_md;
> +			const EVP_MD *mgf1_md;
> +

Remove extra line

> +			uint8_t *label;
> +			uint32_t label_len;
>  		} r;
>  		struct exp {
>  			BIGNUM *exp;
> diff --git a/drivers/crypto/openssl/rte_openssl_pmd.c
> b/drivers/crypto/openssl/rte_openssl_pmd.c
> index 2319c7cfa9..4fbbb73bfa 100644
> --- a/drivers/crypto/openssl/rte_openssl_pmd.c
> +++ b/drivers/crypto/openssl/rte_openssl_pmd.c
> @@ -2292,6 +2292,41 @@ process_openssl_modexp_op(struct rte_crypto_op
> *cop,
>  	return 0;
>  }
>=20
> +/**
> + * Configure RSA-OAEP parameters on an initialized EVP_PKEY_CTX.
> + * Must be called after EVP_PKEY_encrypt_init() or EVP_PKEY_decrypt_init=
().
> + *
> + * @return 0 on success, -1 on failure.
> + */
> +static int
> +openssl_rsa_set_oaep_params(EVP_PKEY_CTX *ctx,
> +		const struct openssl_asym_session *sess)
> +{
> +	if (sess->u.r.pad !=3D RTE_CRYPTO_RSA_PADDING_OAEP)
> +		return 0;
> +
> +	if (EVP_PKEY_CTX_set_rsa_oaep_md(ctx, sess->u.r.oaep_md) <=3D 0)
> +		return -1;
> +
> +	if (EVP_PKEY_CTX_set_rsa_mgf1_md(ctx, sess->u.r.mgf1_md) <=3D 0)
> +		return -1;
> +
> +	if (sess->u.r.label_len > 0) {
> +		void *label =3D OPENSSL_memdup(sess->u.r.label, sess-
> >u.r.label_len);
> +
> +		if (label =3D=3D NULL)
> +			return -1;
> +
> +		if (EVP_PKEY_CTX_set0_rsa_oaep_label(ctx, label, sess-
> >u.r.label_len) <=3D 0) {
> +			OPENSSL_free(label);
> +			return -1;
> +		}
> +	}
> +	/* Empty label is default; set0_rsa_oaep_label(NULL,0) fails on OpenSSL
> 3. */
> +
> +	return 0;
> +}
> +
>  /* process rsa operations */
>  static int
>  process_openssl_rsa_op_evp(struct rte_crypto_op *cop,
> @@ -2308,6 +2343,15 @@ process_openssl_rsa_op_evp(struct rte_crypto_op
> *cop,
>  	if (!rsa_ctx)
>  		return ret;
>=20
> +	/* OAEP is only valid for encrypt/decrypt */
> +	if (sess->u.r.pad =3D=3D RTE_CRYPTO_RSA_PADDING_OAEP &&
> +			op->rsa.op_type !=3D RTE_CRYPTO_ASYM_OP_ENCRYPT
> &&
> +			op->rsa.op_type !=3D RTE_CRYPTO_ASYM_OP_DECRYPT)
> {
> +		OPENSSL_LOG(ERR, "OAEP supports encrypt/decrypt only");
> +		cop->status =3D RTE_CRYPTO_OP_STATUS_INVALID_ARGS;
> +		return ret;
> +	}
> +
>  	switch (pad) {
>  	case RTE_CRYPTO_RSA_PADDING_PKCS1_5:
>  		pad =3D RSA_PKCS1_PADDING;
> @@ -2315,6 +2359,9 @@ process_openssl_rsa_op_evp(struct rte_crypto_op
> *cop,
>  	case RTE_CRYPTO_RSA_PADDING_NONE:
>  		pad =3D RSA_NO_PADDING;
>  		break;
> +	case RTE_CRYPTO_RSA_PADDING_OAEP:
> +		pad =3D RSA_PKCS1_OAEP_PADDING;
> +		break;
>  	default:
>  		cop->status =3D RTE_CRYPTO_OP_STATUS_INVALID_ARGS;
>  		OPENSSL_LOG(ERR,
> @@ -2330,6 +2377,9 @@ process_openssl_rsa_op_evp(struct rte_crypto_op
> *cop,
>  		if (EVP_PKEY_CTX_set_rsa_padding(rsa_ctx, pad) <=3D 0)
>  			goto err_rsa;
>=20
> +		if (openssl_rsa_set_oaep_params(rsa_ctx, sess) < 0)
> +			goto err_rsa;
> +
>  		if (EVP_PKEY_encrypt(rsa_ctx, NULL, &outlen,
>  				op->rsa.message.data,
>  				op->rsa.message.length) <=3D 0)
> @@ -2355,6 +2405,9 @@ process_openssl_rsa_op_evp(struct rte_crypto_op
> *cop,
>  		if (EVP_PKEY_CTX_set_rsa_padding(rsa_ctx, pad) <=3D 0)
>  			goto err_rsa;
>=20
> +		if (openssl_rsa_set_oaep_params(rsa_ctx, sess) < 0)
> +			goto err_rsa;
> +
>  		if (EVP_PKEY_decrypt(rsa_ctx, NULL, &outlen,
>  				op->rsa.cipher.data,
>  				op->rsa.cipher.length) <=3D 0)
> diff --git a/drivers/crypto/openssl/rte_openssl_pmd_ops.c
> b/drivers/crypto/openssl/rte_openssl_pmd_ops.c
> index 60d33f3474..902b46918d 100644
> --- a/drivers/crypto/openssl/rte_openssl_pmd_ops.c
> +++ b/drivers/crypto/openssl/rte_openssl_pmd_ops.c
> @@ -2,6 +2,7 @@
>   * Copyright(c) 2016-2017 Intel Corporation
>   */
>=20
> +#include <limits.h>
>  #include <string.h>
>=20
>  #include <rte_common.h>
> @@ -1208,6 +1209,33 @@ openssl_pmd_sym_session_configure(struct
> rte_cryptodev *dev,
>  	return 0;
>  }
>=20
> +static const EVP_MD *
> +openssl_get_md(enum rte_crypto_auth_algorithm alg)
> +{
> +	switch (alg) {
> +	case RTE_CRYPTO_AUTH_SHA1:
> +		return EVP_sha1();
> +	case RTE_CRYPTO_AUTH_SHA224:
> +		return EVP_sha224();
> +	case RTE_CRYPTO_AUTH_SHA256:
> +		return EVP_sha256();
> +	case RTE_CRYPTO_AUTH_SHA384:
> +		return EVP_sha384();
> +	case RTE_CRYPTO_AUTH_SHA512:
> +		return EVP_sha512();
> +	case RTE_CRYPTO_AUTH_SHA3_224:
> +		return EVP_sha3_224();
> +	case RTE_CRYPTO_AUTH_SHA3_256:
> +		return EVP_sha3_256();
> +	case RTE_CRYPTO_AUTH_SHA3_384:
> +		return EVP_sha3_384();
> +	case RTE_CRYPTO_AUTH_SHA3_512:
> +		return EVP_sha3_512();
> +	default:
> +		return NULL;
> +	}
> +}
> +
>  static int openssl_set_asym_session_parameters(
>  		struct openssl_asym_session *asym_session,
>  		struct rte_crypto_asym_xform *xform)
> @@ -1229,6 +1257,7 @@ static int openssl_set_asym_session_parameters(
>  		BIGNUM *d =3D NULL;
>  		BIGNUM *p =3D NULL, *q =3D NULL, *dmp1 =3D NULL;
>  		BIGNUM *iqmp =3D NULL, *dmq1 =3D NULL;
> +		uint32_t label_len =3D 0;
>=20
>  		/* copy xfrm data into rsa struct */
>  		n =3D BN_bin2bn((const unsigned char *)xform->rsa.n.data,
> @@ -1240,6 +1269,57 @@ static int openssl_set_asym_session_parameters(
>  			goto err_rsa;
>=20
>  		asym_session->u.r.pad =3D xform->rsa.padding.type;
> +		if (xform->rsa.padding.type =3D=3D
> RTE_CRYPTO_RSA_PADDING_OAEP) {
> +			asym_session->u.r.oaep_md =3D openssl_get_md(xform-
> >rsa.padding.hash);
> +
> +			if (asym_session->u.r.oaep_md =3D=3D NULL) {
> +				OPENSSL_LOG(ERR,
> +					"Unsupported OAEP hash algorithm
> %u",
> +					xform->rsa.padding.hash);
> +				goto err_rsa;
> +			}
> +
> +			enum rte_crypto_auth_algorithm mgf1 =3D xform-
> >rsa.padding.mgf1hash;

Move the definitions at start of functions. I see there are 3-4 such instan=
ces in this and subsequent patches.

> +
> +			if (mgf1 =3D=3D 0)
> +				mgf1 =3D xform->rsa.padding.hash;
> +
> +			asym_session->u.r.mgf1_md =3D openssl_get_md(mgf1);
> +			if (asym_session->u.r.mgf1_md =3D=3D NULL) {
> +				OPENSSL_LOG(ERR,
> +					"Unsupported OAEP MGF1 hash
> algorithm %u", mgf1);
> +				goto err_rsa;
> +			}
> +
> +			if (xform->rsa.padding.oaep_label.length >
> (size_t)INT_MAX) {
> +				OPENSSL_LOG(ERR,
> +					"OAEP label length %zu is too large",
> +					xform->rsa.padding.oaep_label.length);
> +				goto err_rsa;
> +			}
> +
> +			label_len =3D (uint32_t)xform-
> >rsa.padding.oaep_label.length;
> +			if (label_len > 0) {
> +				if (xform->rsa.padding.oaep_label.data =3D=3D
> NULL) {
> +					OPENSSL_LOG(ERR,
> +						"OAEP label length is non-zero
> but data is NULL");
> +					goto err_rsa;
> +				}
> +
> +				asym_session->u.r.label =3D
> OPENSSL_zalloc(label_len);
> +				if (asym_session->u.r.label =3D=3D NULL)
> +					goto err_rsa;
> +
> +				rte_memcpy(asym_session->u.r.label,
> +					xform->rsa.padding.oaep_label.data,
> +					label_len);

I think you can use memcpy instead of rte_memcpy.

> +				asym_session->u.r.label_len =3D label_len;
> +			} else {
> +				asym_session->u.r.label_len =3D 0;
> +				asym_session->u.r.label =3D NULL;
> +			}
> +		}
> +
>  		OSSL_PARAM_BLD * param_bld =3D OSSL_PARAM_BLD_new();
>  		if (!param_bld) {
>  			OPENSSL_LOG(ERR, "failed to allocate resources");
> @@ -1342,6 +1422,11 @@ static int openssl_set_asym_session_parameters(
>  		ret =3D 0;
>=20
>  err_rsa:
> +		if (ret !=3D 0 && asym_session->u.r.label) {
> +			OPENSSL_free(asym_session->u.r.label);
> +			asym_session->u.r.label =3D NULL;
> +			asym_session->u.r.label_len =3D 0;
> +		}
>  		BN_clear_free(n);
>  		BN_clear_free(e);
>  		BN_clear_free(d);
> @@ -1817,6 +1902,11 @@ static void openssl_reset_asym_session(struct
> openssl_asym_session *sess)
>  	switch (sess->xfrm_type) {
>  	case RTE_CRYPTO_ASYM_XFORM_RSA:
>  		EVP_PKEY_CTX_free(sess->u.r.ctx);
> +		if (sess->u.r.label_len > 0) {
> +			OPENSSL_free(sess->u.r.label);
> +			sess->u.r.label =3D NULL;
> +			sess->u.r.label_len =3D 0;
> +		}
>  		break;
>  	case RTE_CRYPTO_ASYM_XFORM_MODEX:
>  		if (sess->u.e.ctx) {
> --
> 2.54.0

