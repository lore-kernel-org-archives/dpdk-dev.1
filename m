Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9C0CCA490
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Oct 2026 12:54:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 525E340298;
	Sun, 18 Oct 2026 14:54:00 +0200 (CEST)
Received: from iad-out-011.esa.us-east-1.outbound.mail-perimeter.amazon.com
 (iad-out-011.esa.us-east-1.outbound.mail-perimeter.amazon.com
 [54.211.126.101])
 by mails.dpdk.org (Postfix) with ESMTP id 54A7A40276
 for <dev@dpdk.org>; Sun, 18 Oct 2026 14:53:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1792328038; x=1823864038;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=QtiT/vXP2XLj/oQpWcAe3dYIcLe2n9k6ivY6pZoSvss=;
 b=Pa5T9hdytxDw8uJcLzXwqycKw8eAr5qXvVANiv21kbmUM7S7LGUCu6h6
 3nPPgQZn2Rbp1Gn4MsfwueVVi3pGEdmyq4u22xqRj99VmpRp/phHvTfUe
 uZIbBziyH/ESviijiMui6qt0JfvRK5CnHt65lr1Ox+TVDJB6Ce/ukET6v
 BOhWH7Qe5y25C8hSmH6aYPFhlfMSre1uhLY4wNlm6wyMBeqffFeN+OqmK
 MHgKyBB+FOVZ2tdgAr0OZ1FEKpL1D26nosgl1qpw6RlyjItn4UpSPW9Db
 iEGVSxwZFYRnjaaxIdwW6qiJ88QyiBFomX2IAB9zcDbvvKHjYsAXuw77t A==;
X-CSE-ConnectionGUID: WWmes0eDRMCjAPJRhSvh6g==
X-CSE-MsgGUID: wnmp5dA/Tdq6Q0T3r5WBMg==
X-IronPort-AV: E=Sophos;i="6.27,165,1787011200"; d="scan'208";a="29763940"
Received: from ip-10-4-3-150.ec2.internal (HELO
 smtpout.naws.us-east-1.prod.farcaster.email.amazon.dev) ([10.4.3.150])
 by internal-iad-out-011.esa.us-east-1.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2026 12:53:54 +0000
Received: from EX19MTAUEA002.ant.amazon.com [72.21.196.65:6255]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.91.53:2525]
 with esmtp (Farcaster)
 id e509a482-72cb-4a12-9bbb-6448cdd288d8; Sun, 18 Oct 2026 12:53:54 +0000 (UTC)
X-Farcaster-Flow-ID: e509a482-72cb-4a12-9bbb-6448cdd288d8
Received: from EX19EXOUEA002.ant.amazon.com (10.252.134.207) by
 EX19MTAUEA002.ant.amazon.com (10.252.134.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53;
 Sun, 18 Oct 2026 12:53:53 +0000
Received: from EX19EXOUEC001.ant.amazon.com (10.252.135.173) by
 EX19EXOUEA002.ant.amazon.com (10.252.134.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53;
 Sun, 18 Oct 2026 12:53:53 +0000
Received: from BL0PR07CU001.outbound.protection.outlook.com (10.252.135.199)
 by EX19EXOUEC001.ant.amazon.com (10.252.135.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53
 via Frontend Transport; Sun, 18 Oct 2026 12:53:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YH4ySylt4Nr9a/o684WRdikz+7fAWFhgFIXB2jpL3EP2hdm96RZkXKy9Mz/Jm9EgT0PaFNoiEljjtVBLoWZ2b6bCS8o28kGOalVxqFCVc9znyGHK0YJkC0VH7SSx579Gp/tq5mNm+CdXGLSa2UOWyZBHq+Se8QfPHOHD1e6LvocgOEnfYpcQqHm6pNhtviQnjIYyq2xh5OBqz4IDRfRCrZymAA2vBV+y34aIO0TWlEEqUAFio816Nd33eERfcSHHKpKFDnkPzNevihm0MNE3oP2AniNWCmOP4D5UkzNx9OxIkguS+dhRLzit/ImImJRODrPgK/uJEWxv3hZzzmyBfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QtiT/vXP2XLj/oQpWcAe3dYIcLe2n9k6ivY6pZoSvss=;
 b=txs64r3CKHsMpcdkptoO5t0GbVpOKiXhvIyGaiTUP0a3EC4INFggksiGZYJ73Ke60YCfszeesOwYdNZrGWMkBsYZ4eNxhRoItmQB6L2PDcxdAWmVykEgeAzwEZva2IMjYdx63RshWNg/5DdzG3bdrmLJ6nLathb9sxV5fJWmIXbr0gsCvkN6dlp07Ozpnd5ySONnR8hNVnEO3PK6XEKYRg6iuhUIEgtHbpgNI4El0/VMc0TX1fkpXicTm9v4alw+0KraGajZxyDvg4ynv4QgzU7bAdMsVfcm76TVeWtmjojFfDrd2nQc5I1GX/lWOk5omm8JwI+voBbw2A/eekkwiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.com; dmarc=pass action=none header.from=amazon.com;
 dkim=pass header.d=amazon.com; arc=none
Received: from DS2PR18MB927544.namprd18.prod.outlook.com (2603:10b6:8:32d::21)
 by SN7PR18MB4095.namprd18.prod.outlook.com (2603:10b6:806:f7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Sun, 18 Oct
 2026 12:53:52 +0000
Received: from DS2PR18MB927544.namprd18.prod.outlook.com
 ([fe80::80c9:539e:549a:e0a5]) by DS2PR18MB927544.namprd18.prod.outlook.com
 ([fe80::80c9:539e:549a:e0a5%6]) with mapi id 15.21.0522.017; Sun, 18 Oct 2026
 12:53:52 +0000
From: "Brandes, Shai" <shaibran@amazon.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: "stephen@networkplumber.org" <stephen@networkplumber.org>
Subject: RE: [PATCH v3 13/13] net/ena: upgrade driver version to 2.15.0
Thread-Topic: [PATCH v3 13/13] net/ena: upgrade driver version to 2.15.0
Thread-Index: AQHdXua9qmk7bru0j0SJXcgc2BVeQLcDQM2w
Date: Sun, 18 Oct 2026 12:53:51 +0000
Message-ID: <DS2PR18MB927544592F796B527B14313183AF992@DS2PR18MB927544.namprd18.prod.outlook.com>
References: <20261018063606.973-1-shaibran@amazon.com>
 <cover.1792312029.git.shaibran@amazon.com>
 <803920d29c055d33f26282aaf64c367d49e2b51f.1792312031.git.shaibran@amazon.com>
In-Reply-To: <803920d29c055d33f26282aaf64c367d49e2b51f.1792312031.git.shaibran@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amazon.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS2PR18MB927544:EE_|SN7PR18MB4095:EE_
x-ms-office365-filtering-correlation-id: 10c4d360-caba-4d2b-df57-08df2d16dc67
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|261009223027099003|10067099003|56012099006|18002099003|22082099003|11063799006|4143699003|38070700021;
x-microsoft-antispam-message-info: eUmwVoRhEGwRBsKChANvy99IkZAWbUnvGYMITS4Gn9DpzPYY9safWcE9PRfVy243mfM9q4QtezDDn6JeipckkaDvKiijocOQfKL647hojFiyJ5COMN+sxrFfNvAmQIIdb43bDc7H5DLAEWRsh/0XLpewJxooPOXY5J4L5Fsz2fwnlhwMrIqqFExXWsGDjayR3XXvOpLmh85uY8ifvz5MnNx6Wxu3n+qoaRLeKC0QYYfV3xZM7cq3+zoM4clNNnqddw6ElkJxDoIcVFiHe+/wdYwiinz8gJxZzX39zzmDlr0k3o4lodGEIqtVdTAms8VI9bzTHqXy5Q2z9F8uSxN+rtizv4fC8CGzZ2++hloQliDGBPdtvfLsyRFm0M10QVdlFANtT7oaN0hFFJ6679R1TLHw2qw1Tk0jO03q5VnWvB32oLg1xd9e1ngyecCHzqePjkIcwieZu3NTUiILiMVAQbWSO2Z7ZRTAPbQEOKHQs23PTStK8gVp3jg3OATKI28DM04mlfliprPKyhTtjbVCacBhFqrSzgxjFAk3tRIqFibuvU2dRD/unZmVOgc3gvsiM68049vq9SPH6L8OplQ8GfE3jz3MOYPpJ6sWRsJqJuEYs4qHsxck0GnR1XNka11FEFLy+1CMU7EWOOOyEhvBk+1PVmuef1Ap/uUup2wk4qvFxDL948gkGhD5fNeRHpLEbLsEf5ips74Qwgj7MBERiQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR18MB927544.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(261009223027099003)(10067099003)(56012099006)(18002099003)(22082099003)(11063799006)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IA3p5QUS1oavzA7TFD53Nd1bjWXb9PJ2MZgg2zmviYVan3nfazDxvZAuftkh?=
 =?us-ascii?Q?1JPwRJ8yS6jGlNl5OCgErCvNSJoh7Lh3LK3uWa5L5QydoXrKuPYhESMLvvmH?=
 =?us-ascii?Q?Wgi8qoegysNN9Cg33rcJPT+ydOtumJ+brQFpBIPtJcKOWBtLm8QwajiIVnKa?=
 =?us-ascii?Q?csHM3+Q4yDTcKko6vQ3k9zMgKTu9bv+w+t9ueanAgnNc+U5ioWeHJdAMjwlk?=
 =?us-ascii?Q?TL+Ew53L53GW7V2n5H2qeUxq6ET7M0PNy+uula2Esl4Vxt2xi0nbXryII0FF?=
 =?us-ascii?Q?Ukcub8ggPKeOg6PBfCw+oxH+gKZvmE+z+gI6au17ZOHnsjEZ95KSjlmQ+qhE?=
 =?us-ascii?Q?RrPqfG1t2UlCh53za+sE4hG1b0Q4oFLMEc6QCAhQB7p4U53ggMiP6aht+5gM?=
 =?us-ascii?Q?V6FnmQUQE5ifOvBGV0E0nX4rkPOMZIksVupQG9jH0PNC/Whp3oiEESWoDc4y?=
 =?us-ascii?Q?rIME8DtV5Q0Wg9c9q7+ajM6L7K6kSv+o0h9+C/mvvyVotVNFRylzbCwcP4q/?=
 =?us-ascii?Q?uKBek4leS1XhUBLleLlgkm+FwqyKz6CRnfABpXzZAvRgWzi1FoD7gQwE2DLn?=
 =?us-ascii?Q?JF7gO1N6hyAtSlGQECc4l+k/UcTo8eJpZxHULpdotR+cZQMILWMfnVd7Ja1J?=
 =?us-ascii?Q?9VBRy3b/aMrPOORh2yWpZy0sXHxr9Mp697ppM19+HorNcXJxnn/yQanIi+co?=
 =?us-ascii?Q?xkfoO+ODk6dZGNF7H6bDYmuIHPj+KZWVNLGpHPaWwrL8k0qXinfDs/yMxwCN?=
 =?us-ascii?Q?Ifudtk8VF/u2/9ZUXXhr0Rb7fhK48AxOF7DX5+sGqWKOF+RLXbKe6BlFvi70?=
 =?us-ascii?Q?k1XGbYHGBIIEreIIG64nkNPiJrVQMWXJF3T4lG4glztlgcHfQY5sbf2XV5af?=
 =?us-ascii?Q?YBQH/gIzgwI/sWRR92uRqliBpao+i4R7tEfcL88oC5pcNnSGMsUAm6v/rI9P?=
 =?us-ascii?Q?9FW7IJIJfFbFu2fBnEFulHH9sgShtNDR3PMApOdcxHU1QxSg/xQX8fcUmQJt?=
 =?us-ascii?Q?CiaXoULdwaeIfwkpnfO+mVMAErb0vzmwXEyQ/cvpJvn4rRhC1nh/qlWFUD2F?=
 =?us-ascii?Q?owR7UgT7estiYLxnBbirZ5+1jub97TMe3u51ijfxcxlFi2q8bJzm7C3ABi/b?=
 =?us-ascii?Q?ubGesacSk0V90vr7s2MuvUdJO+TPLV6FR79oiKJnNYgVI5mFso/wh4o0Gmpy?=
 =?us-ascii?Q?JMM7zU/ThasyHj9EUsQQqMNxF0Pr30AiIWuot9ZuJWZrEQtydqEQ1bvsLnmT?=
 =?us-ascii?Q?Kfj37BO5Bk4xcifLsFFqYJRk6XWvvvTubA8/hlvh5jqF6Mat0oaReuBUoSu4?=
 =?us-ascii?Q?YnElS6DxZLoJVgrE/R7kMiq5ydcd1DEGo9qdVUhfA5j2c+u/BdY6Ci8bLcRH?=
 =?us-ascii?Q?46vOIe3E6QHb1uOBT4qRygryuUnUlY/0It2rKDPisgI/lrKnKdNwUv/Z3+m4?=
 =?us-ascii?Q?NQfZ8HyxePmh+VCkFwx0yEWtO1la31JVz1gRo3SE5nqh7uB7/0oNJaKPMScQ?=
 =?us-ascii?Q?m7N7i7//ojIMUqcTiYBnIoCy0G5rcLgv2B4Y/oqmY/suHDo7SYvvU+e/G8+E?=
 =?us-ascii?Q?QMJVwjAOz7Z7mP4XRaiwvQBjZQblOKsbU8LJbmAvrKXrrZC0w/Ns5xN8rxo2?=
 =?us-ascii?Q?vAwxHo7ucRvbzpOytDdZC3UV8/x1nBU04QMoeq6AvsKdfcb79cPsEvkURw3h?=
 =?us-ascii?Q?zxDQ4NEsroToqovLt9AeQOienQClEE1DCtl/P7cEOUlVDE6Y?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: R4uCWWmpVl6/d7zQHElJU+LtdGPb7ZJpNX25Kd/iTa0fUgz5o2w7U+4gqDBvw9qaTFEI8nWz515bj5jLO9p4LOShnPgFBRc50VuxvxOyC+MyYk1+0TfFiNhYOj3s7YbsTja+dz5CxshIjyBXQnevPK7frAJ+CnkY1LlPKs9VGTCbkJCFw6ayi5SACb/T5iQIHySqSeX0VLg4rz+aEeRU0WsYhcoOlsxOjjbn23n5Np4V3Xrk4NX6X7I5VnV3H73EQsmiXz2Q//hGJ7rHVbrSaFtSx0Zq1pdDib7GkljMrV6hBLH9F6QzvOiEXUGUAoy67Vq1EHLLVOt42Zpc+6ivbw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS2PR18MB927544.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10c4d360-caba-4d2b-df57-08df2d16dc67
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2026 12:53:52.0034 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Ws/KeFaFSJxxEhGZDvsmz9asP79pYaI4+yC5mBiMpjBVHtXBUy/fvXrZiF85mItalKYiVyp9riNiZ8iTtXbFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR18MB4095
X-OriginatorOrg: amazon.com
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

Recheck-request: iol-unit-arm64-testing

It seems that the failure is environmental. Rechecking may fail again as I =
see other patches also fail on that test suite today.

> -----Original Message-----
> From: Brandes, Shai <shaibran@amazon.com>
> Sent: Sunday, October 18, 2026 12:54 PM
> To: stephen@networkplumber.org
> Cc: dev@dpdk.org; Brandes, Shai <shaibran@amazon.com>
> Subject: [PATCH v3 13/13] net/ena: upgrade driver version to 2.15.0
>=20
> Upgrade driver version to 2.15.0
>=20
> Signed-off-by: Shai Brandes <shaibran@amazon.com>
> ---
>  drivers/net/ena/ena_ethdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ena/ena_ethdev.c b/drivers/net/ena/ena_ethdev.c
> index 3eee5e2545..435c2af477 100644
> --- a/drivers/net/ena/ena_ethdev.c
> +++ b/drivers/net/ena/ena_ethdev.c
> @@ -23,7 +23,7 @@
>  #include <ena_eth_io_defs.h>
>=20
>  #define DRV_MODULE_VER_MAJOR	2
> -#define DRV_MODULE_VER_MINOR	14
> +#define DRV_MODULE_VER_MINOR	15
>  #define DRV_MODULE_VER_SUBMINOR	0
>=20
>  #define __MERGE_64B_H_L(h, l) (((uint64_t)h << 32) | l)
> --
> 2.17.1

