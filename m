Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB85CD6E4A
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Jun 2026 09:03:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 456CE4064C;
	Tue,  2 Jun 2026 11:03:51 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 9DF0B402A9;
 Tue,  2 Jun 2026 11:03:49 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 651Nd4Ui2859100; Tue, 2 Jun 2026 02:03:48 -0700
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11022080.outbound.protection.outlook.com [52.101.48.80])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4ehbxrb23s-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 02 Jun 2026 02:03:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r2mGMDJZpMvNVUiMU0Usqup7n1Lxot3E3UB+aLxEXfEjIStpylzOdtfJBQJ9sY4Of27XamsVuw2DuwbRIjI8rzt6lVxTcYcWGdhB9dGz7PHuxuXFp7uXjUvmj0hkkto10lCpF/OQwoKx4KnUkV3Q5TcE52XmZOQAYfVqjIR+dhaabasf7JjKekHdkfQmoCgkniNrwxHm3N6fCjCe1FNQW2qIHNG64SgWazK56FpFi6m/kUaYXfeHNFY53klu6ckLHHWa0r1EwRAQmz9nbQmo6t0kpsWfYVydeIt8/n21n6lMoDwUXWN4hQze7ca/9XSqT8W0S9NIZbwRbn1q7k/odA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZxHQ3JcfHBpp1vLXUqNu+c0pi7zKxBIKpr45mOjblo=;
 b=M1Lj7FShm01X/thh05YKHoVafWW2QevqJ12DVuWhcaA0NrNI5fqPqmvLkgX3cYziW3JAwOpmPLCWRkrnTMKXm2G5UL3/2FgNcCtoP3Fi/lBjgCQiI7NnRateBywMX2m02XZ3NHIbN2tajns79oehFp9/CaVbtCaUefUdoFKhID469LnNXiW6bj5daVBtZ99P5iyq2330Ug2XCKVZu7UZwcs2luGw/nhQaC+WZHZlC6Fxvr8KkbNiEqPwZpWiDe2qQno5KF+To6CGWdxehcNRqGETNXcbjmAZ+V1zrAM82SjOip6OoMw4SwQqwTUoy7Oi75fT1HKuJyp+H0ZIkyLE0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZxHQ3JcfHBpp1vLXUqNu+c0pi7zKxBIKpr45mOjblo=;
 b=RBWaacfkQhA16iGKTAmal2+qV/NLQsWgPJOwffW4swSPb9Pxk90mff9PCtMlB+HEZHjwxlSbJfG0SB2MSxDcx8Ga7R06FJR3b7ieirwHbAxlIfRxN292xQGWnxXgiCHb0RfivL6UkBjyJ1E5T7AzdIfbIxZHm/Tf2vkUMQTxY/U=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 SA3PR18MB5299.namprd18.prod.outlook.com (2603:10b6:806:2f7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Tue, 2 Jun 2026
 09:03:46 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%5]) with mapi id 15.21.0092.006; Tue, 2 Jun 2026
 09:03:46 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Pratik Senapati <psenapati@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Anoob Joseph <anoobj@marvell.com>, Gowrishankar Muthukrishnan
 <gmuthukrishn@marvell.com>, "kai.ji@intel.com" <kai.ji@intel.com>,
 "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH] crypto/openssl: fix use-after-free bug and cleanup
Thread-Topic: [PATCH] crypto/openssl: fix use-after-free bug and cleanup
Thread-Index: AQHc7nfFNBVajPsM3kKZ9mhwOnjb4LYrAGjg
Date: Tue, 2 Jun 2026 09:03:45 +0000
Message-ID: <CO6PR18MB44843234233438EDF777CAEED8122@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20260528075822.2206494-1-psenapati@marvell.com>
In-Reply-To: <20260528075822.2206494-1-psenapati@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|SA3PR18MB5299:EE_
x-ms-office365-filtering-correlation-id: ade4b558-0f2e-4ca6-5424-08dec085da5f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|18002099003|38070700021|22082099003|11063799006|56012099006;
x-microsoft-antispam-message-info: HwVrCmmUuT+SMkv9SwmNqLcDwEeyn8Ycj03henSEY+XgRBObQnd1q6cl78jSVsaAqh9ugv143mHysdhcmJ34zWp9nuL0RsoU5Fb9evSbu45xm23QlwVHo6jMcdBXtV9pKI3RxSpXBPgIgdS6XyXqJcn0L2boaZ8g/mSiW6CIjOm6twMZcYy1je6hf6tmD0Kb72LC5ekXxlzTxDyPL+XvdxIpt7jY7ib8ypOn+D5NCP3kPMbPHgSdsjZaucsuYdWcteyJ7y31lNn/pG2ZmRBc/tmvWEVzGP3iR6do5Nq0qCwfopEzeWfmJa1VDu/Iq0vREEdakaQJZ9wDhHH3jrk7PHAj7fEGUl1NkaHj5zJmy6+3EAHGdwjakELuoZTPCcN4vnafDOWttEMIZ0aa2ajNjAmuUiAKLNAkDLT8CUgdjl1/grI9PhyDk2jYaflfckAymDky6uz2+YVRK2oghy/y2MfimZa0TG5FDMXoV687x+0FObFHmyqTZiL+LPp3wJzvE2wxGhQ8Tx+gSRuM06RiwAPnOHRWJdA1146P8YmYevql1G4RHrCFa0e/cN6HAiUDhPmU9QRVLup29G92kf7Ok0WGoSBe1JQMtNnQho+95+ZrmEnJ3svMrIrXQvwALyMT9t4dQDmJ3ON6UjATY4rlmmcRD0SwEQivjFHllv7ozUn/psIw+YYvkjIXn5xMVJBgYByqnzLMOW/LnqnyBCREJTmuNRLLmE0FdP/Y5YXr3PX0LtRgUx8MyNcJA5lwUj3L
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(38070700021)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3srwoh6b98YrGnDtsKHGmK1Q1Bl9hLvb+UaFwp6IJ0YlfGa1Hxg2j4Kwq7sj?=
 =?us-ascii?Q?GvUqsQS9Sbx1tGnWZydtaBTzASzuQB840EAzWEOEW/hcO/m3kN+R6Ewuu3wC?=
 =?us-ascii?Q?iFTcfXqNnq03Y7berqJLfr2xTKpdgU/dNSZW7SGVEfe+Jvud9nB26BYUGLkj?=
 =?us-ascii?Q?PphCfETzFubh2aeTB4o1uYmEkrg9whg6iZZmxwZSJrQ4tUgV3VXXMtDpRnhV?=
 =?us-ascii?Q?dcZaeXpOuIXfyvHmtuwHPwgg/KDjA3GmqkO1waOBgkvVRCuMA5Up9a9mQGwb?=
 =?us-ascii?Q?1+7XQ6oFG/vNQUnfdUrcTzOIIF0ZKJoE722o/UysFvwquU7+L1Kzb0ys3CCr?=
 =?us-ascii?Q?x4rSo6b/yLPNDnl/DsdWrLBCU3bjPMT9Z3LjeeDL0rrrqTNBshdigysyjmDf?=
 =?us-ascii?Q?gcsRafLlI8UOhkIFSxk0HVuGgoF+sMYvusw4Rf/iRgh64+AvoJNE6vhzAQm/?=
 =?us-ascii?Q?8Bl0f7zYK/St4ExZnSd5i5BNj3jbN3PjRhjhIXqaFzOiSsyHSy0ROY/2WSra?=
 =?us-ascii?Q?o/TnFxI0vbQHMkGA5cqCPkQ5evxzfRbLAA7ThTBvYV2T9AMGF4whJ5swekFH?=
 =?us-ascii?Q?bYhUnJlBnyOs2gWmDuilBh5HNNP6fVkHHkuBYmslRVPuv1e/zOcRdYENtAfF?=
 =?us-ascii?Q?wMMfKEs3wFqysP4xO9Flbpzm47xjk1GSAaFqb083cmULZTiNzbCDb+VQ8GCm?=
 =?us-ascii?Q?x51y/v+D9x4xcFJhJcHnp1ZMAsRZbEsvhv6lR8DUTRbtcCPWYgIfs3Xd1qHJ?=
 =?us-ascii?Q?1JIAuxlpMKDelDxY+Bdo60EC+8FVbR9iSIZn1lNfYW7JZ6OntNRz8076VFXb?=
 =?us-ascii?Q?Oy7g+ucXnIZKrmmWESZ5f0PGwQMtq2+mLTCcgO3bXiA/5PPnNUu8sVomN1Cn?=
 =?us-ascii?Q?pp7OWPMsDFKvoVIUDOAkJ3eAZbNYKWd4CaraqUkdZhon7mzjJxCTaZGJUbdC?=
 =?us-ascii?Q?2veJ4OtPVdxxJixPnlnbhGqYnsMSYEac8jWv/qPH0tBssNCbPm/V6CjNqXBg?=
 =?us-ascii?Q?WyEcvyideeWMwjj9JWFmgYqvua9AUwSEqkxnhZP1ZzaaKAO0zhBEyPSP98p+?=
 =?us-ascii?Q?sBq9xR1eSO6UbKRVZDz+GD8MKgI5rzZFlqmO6nUP0J69oDerP4vTxYf3yL1n?=
 =?us-ascii?Q?kV3VjO6QSNghsKBDIW3FpZ9iH4xQ+zUmbthHmM1ESl69QyHAEERmEDQ9dn6L?=
 =?us-ascii?Q?b++B2imFT8SPKgpvRBEwx7LOEbmEcpFhnk8FXAvPvCiSQVenf/zEcImQKs+l?=
 =?us-ascii?Q?o4d21Y8DIR5Nt1VP3GyC+xNiw9N237/+oAFfgQo25tMQLnDRjJZuHOsM9Z08?=
 =?us-ascii?Q?s7Xsv1d3gYyKXDhUHYtlft8xMvnfCiDjuY9YCPqhwzAqZ1smWavpcvYjDdcn?=
 =?us-ascii?Q?Lh/mGzWz1QoW2OKieFILFqfupRio9/dlKU18IQI7TGdZ9Sk2l9wkIKnEH/o6?=
 =?us-ascii?Q?LC14PNNMqYsIUq1ac7zrmOTAsur0ZZfsTE0ks8KQZ/A+KAculqLl4zZ43Hr2?=
 =?us-ascii?Q?Y87YkfxNiEk7d9ADxjGxQbgHqUikvSmq66A1PEk1jsHRxI+Pfn62FdeQL/4P?=
 =?us-ascii?Q?cdfFLNJPlmjh3RmnciFwGp4ZeSiK7zQr6MG8ZG/+qN5otU9+RAJO3FDCKVKe?=
 =?us-ascii?Q?e+zWiNwdH95ilVVuGgLgndUVqBTsUcyw/kFKEKOUMBYmZIRl+r5VCTDxD7z0?=
 =?us-ascii?Q?WqXFupVbAu7yYwpoKaQstB4aXNarJljZTHLuqdv/ABvUqfoW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: pmWS/ouhS/ar+SOMJMyJBIVBJoueiDqjBwoM9BU5ts2JkQq28sa4zWeev2V99vPt8vnb9iaFPLoea0mrbXF0j81iOi3fZXpIlbmRYajfTUKXJknTH0+/sn4c8i+Z/RgS4z9vNgzspC/XGPXgF3G2c5/jwOeIdcv9bJ6dVGeqywikm4+AGqXrCL8SJfcsdHmhiL6IEIhxcoeU4dWW7dEfF1/vwJgyY/t/vVleYUte7j5gqF4RXgEVMHovS9LP7OIiqnkidaZQYEaVQ3Y/jSS6bkFsbMSbh4IHc7IYZxENAwIv/wcgDKUmUHRAV1CzBSs9sCmDLeADkEoNvZ1OfnE0Lw==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ade4b558-0f2e-4ca6-5424-08dec085da5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2026 09:03:45.9771 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TpBFvSfmo2MhCyqNDrIUS2EBSRtTO/U3ApgsLndEFxvVgZPXHm7lFXY8+lJV7xha1ZMp+yWXoW0P95NaTWsLVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR18MB5299
X-Authority-Analysis: v=2.4 cv=RMaD2Yi+ c=1 sm=1 tr=0 ts=6a1e9c74 cx=c_pps
 a=l7AlRFJyJD7ZaDWTaO3eeA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8
 a=8rWy6zfcAAAA:8 a=QyXUC8HyAAAA:8 a=8VANofEzbKn8koMLWIEA:9 a=CjuIK1q_8ugA:10
 a=zZCYzV9kfG8A:10 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDA4NCBTYWx0ZWRfXy3cqn4NXIAtB
 ie5h5WnIrdvIeD8q6Q7yreknAlVhmQCUcR0JJEQLAupukG/geMVHoGxoH3K8xLA0OAvq4EtDSA6
 XfcyKInjfb4UqvRzreZS/nSJREWSaIq/CDrBabfbc+Avq0sx4BolAppJlnq+pDig1hU2p2sz9Ve
 wA979X8ASzsfSktcBY1cvVZPFcKh6iFUtgPW5kgOqRwkGgv62eGUIwoLo5hUuxU+in9oV3FKjDp
 uxZAKlcdgNFlnJfvmj5YmtGEQRvcJoIipjWK0sQ4fNi2PO5MbLm8i0IgGNZ7zgZDidCTR5tqocW
 mVNVNFg3FioOOq3lNaqZoFYXoj9YNs+UNxt9LNeWnL2TmC31/uBqk1A3kf/8YKG+/MktR4JbKl5
 Ir0+9h7/o+U2o5BWj9s+AZ2cziKLfXe9DCt2Ti5fxIooNwBJiOM7wlpBiqVuBht4Wv+c9C0wDsn
 pBjArhVFxUsepihmTtQ==
X-Proofpoint-ORIG-GUID: mwova0mX4KjyclH2azIWAY0TyINkHQ-K
X-Proofpoint-GUID: mwova0mX4KjyclH2azIWAY0TyINkHQ-K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_07,2026-05-28_03,2025-10-01_01
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
> From: Pratik Senapati <psenapati@marvell.com>
> Sent: Thursday, May 28, 2026 1:28 PM
> To: dev@dpdk.org
> Cc: Akhil Goyal <gakhil@marvell.com>; Anoob Joseph <anoobj@marvell.com>;
> Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>; kai.ji@intel.com;
> stable@dpdk.org
> Subject: [PATCH] crypto/openssl: fix use-after-free bug and cleanup
>=20
> params is freed before it is used by
> EVP_PKEY_decapsulate_init() causing a
> use-after-free issue. Pass NULL to
> EVP_PKEY_decapsulate_init() instead of params
> to avoid it.
>=20
> Add resource cleanup for all error paths in the ML-KEM
> decapsulate handler and consolidate cleanup into
> two goto labels err_pkey and err_decap.
>=20
> Fixes: 5f761d7b60 ("crypto/openssl: support ML-KEM and ML-DSA")
> Cc: stable@dpdk.org
> Signed-off-by: Pratik Senapati <psenapati@marvell.com>
> ---
Fix compilation.
