Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A12A4C35FFF
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Mar 2025 10:34:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A963940276;
	Fri, 21 Mar 2025 11:34:57 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id AEC6D40269;
 Fri, 21 Mar 2025 11:34:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742553296; x=1774089296;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Qoh5rVGuj22IdJ/G0+DLgY0Vkt6v2thy5C68LRrvNlc=;
 b=hXan4CVGd4zWB5lPqlpVN6P2ZPuIY3Zd14pprwCJide5mnHvwrkLa1nc
 tA4OdErIWLpi2XpA5DYHYEHZP4hmrWGK+V0Tfb258B3sm6Gx2FPZMawi4
 N/K2fJPJMYRev+Y6z+Kn7nivx0ppZlNR0tQFrpqwoDdmagi0IEToy9SBV
 u8tg+A6xF3oRW20wrYcM7p5JguRFHds51nNQlJsa/ulmGF45nDjOQa+3i
 UAEKXPiINL0RDzj5wnu4s6WaJpyo+849qowlDYQ/+MyqkabdggVehlL/z
 GRocSkI2vFfpa6Wvn88ua9XetaphvYHGr5vCa7vWw9KePoGbMuT7YYjhV Q==;
X-CSE-ConnectionGUID: 7Oazl7uORCSCguWuhIFPIg==
X-CSE-MsgGUID: UOL4K3VCTUaWfQz8DKoKZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="31405640"
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; d="scan'208";a="31405640"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Mar 2025 03:34:53 -0700
X-CSE-ConnectionGUID: rT1ug2FASOyUrXrMthL0jQ==
X-CSE-MsgGUID: MOEqo984Qi2NYu4cFVYvHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; d="scan'208";a="123347834"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Mar 2025 03:34:48 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 21 Mar 2025 03:34:46 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 21 Mar 2025 03:34:46 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 21 Mar 2025 03:34:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=egCdj10n6WnGga5KrhTAMShpaj4jqF+Sl59XBzFscqi3Gvzwy1PPbzs2UcdVQt1hUgZJfJ0Kp1ae76f4DdQn8GSmawKliCdm1N4Z+tV9oud3NOVQInr4O1nSDs1aFA8HQVfqKrJPZL3CTdbUDBE5u9Vi2rKNCQLcF5SleycteiylkpIfHMYXISxqq3I3CdOM9Y02qjg9x+/mm5ZwlZvI2QjbwoBhOxHrkrheZmyC3U4dZ1np0g3IqkKrTCnHNWqJ/oarplOY5Ycmzdwxf8cjjh1Z7aB57KVtxHbiB3MKjH671vv6jrAKXG8RihwqnbnBcIxZTwdfgAXAEh6QZ5Hcgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C3IyIe1i5ehbR1IeU1vU8Tuo+NLzO6NHyVYSYxTLl7s=;
 b=ufpanbYdevq7qZD+ic5uhlU3wFtMBB6Uup1QY1Y2xIuj9KSv5N3H04J05HL/AmDELLYeZ5JURDbfFELipiL1+/whazT8DrXa2JtDWpdZIxjzQ66uWvHMVxjpf0vLbRT9RU/0HJ3u69mLbLVbJyzPiEPKGEPlFVc451+iu5NmDk4AIyk284UsQHi5b0KNcWUsipC/0CfWJYw+1+a9mqJW3tiN9j5uKwgnCJSwuDZbQ6SfkfYQ0hdH0yuZWSBOcuzCsRX+4fmCUkFjIDG/de0PS510VcQ7bG1gu9iW0z6P4qCmSD2UDBoic1m4fS07UG8l+HGnTsqTQCKCeo8cyslMBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5056.namprd11.prod.outlook.com (2603:10b6:a03:2d5::6)
 by SA0PR11MB4623.namprd11.prod.outlook.com (2603:10b6:806:95::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 10:34:44 +0000
Received: from SJ0PR11MB5056.namprd11.prod.outlook.com
 ([fe80::4f35:279e:a725:ad08]) by SJ0PR11MB5056.namprd11.prod.outlook.com
 ([fe80::4f35:279e:a725:ad08%7]) with mapi id 15.20.8534.036; Fri, 21 Mar 2025
 10:34:43 +0000
From: "Dooley, Brian" <brian.dooley@intel.com>
To: "Kusztal, ArkadiuszX" <arkadiuszx.kusztal@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "gakhil@marvell.com" <gakhil@marvell.com>, "Ji, Kai" <kai.ji@intel.com>,
 "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH] crypto/qat: fix out-of-place header bytes in aead raw api
Thread-Topic: [PATCH] crypto/qat: fix out-of-place header bytes in aead raw api
Thread-Index: AQHbmbkj/suZMv4upUekQKW2v6fL3rN9ZWOQ
Date: Fri, 21 Mar 2025 10:34:43 +0000
Message-ID: <SJ0PR11MB50568CBA098F7CB0222CA6FC83DB2@SJ0PR11MB5056.namprd11.prod.outlook.com>
References: <20250320165702.1439228-1-arkadiuszx.kusztal@intel.com>
In-Reply-To: <20250320165702.1439228-1-arkadiuszx.kusztal@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5056:EE_|SA0PR11MB4623:EE_
x-ms-office365-filtering-correlation-id: e8db604e-222c-4e88-6fa4-08dd6863fe71
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?gfVc4gW6KWWwRmFo54MbTgvcPUfxgPUfEKqp1wAIJV/cXstsKTbV4v/oJf4q?=
 =?us-ascii?Q?kOQ9tZ/+nJZaYDdsehiSNGW1Tt/xR4le5xfie7wYymE1S7Y4TbEwkCp57TP+?=
 =?us-ascii?Q?3dG1Lx2mj1AAcWjmp5MigNhf20SrdQ+jEale2UMr4CUaDGNafgtEXfIZ37iJ?=
 =?us-ascii?Q?MEn8UNkYjsXgdOO+mBd6c4/FLGn80vqsnwBe7Rrh9eL3R2ypxkjyELV9TI94?=
 =?us-ascii?Q?WKvVAIg0JqqmU2dz0LfDZk2q+5YDjKod2xdN3UgezatGGxKzgvN5V10X7msd?=
 =?us-ascii?Q?tx3riqDd9uWsab/xW4uT7cqvpsQ9EpkZfECYaKPpppCHVwGkKs1eOcLrviyD?=
 =?us-ascii?Q?9VV0Hu8UPT5m1rtkC5D4BJDECxiVCnHl/EGfxG3TrJWDJifpXXpslmtYos/P?=
 =?us-ascii?Q?+9ADeMtBW4p8+5EXDMJ/6SJPYWnbVfh67/Cr5faB3GOBxlKZ/RBkJjBiuwo/?=
 =?us-ascii?Q?UXVUxHDHiN4PfR/kNHo2mI//7EAHBv0oPus06Sz00GInO6ijxAl9afxDtAve?=
 =?us-ascii?Q?sENmt+2uAJrOUl+7aIAx3wiYEHDpMamESam1rGHKCz7zUZ4KuIEWIntTxjfd?=
 =?us-ascii?Q?4u7DFh0eVnWwJz3YU+sjH2qWvwqM6OuXrNKy/KDsr9Q5FKZnj+YJtIkTwCMy?=
 =?us-ascii?Q?+3HSj269HH4GH3gADgdxIVisWF4RHvQvFQQVAmhwXJxKQ/rIno02H6y3sJmI?=
 =?us-ascii?Q?O2YNl8YKeWNYlsJrol7D4f5I1YcL/LgPbHY6Fjnb4gkQdr/q3kjOZGuNiQOk?=
 =?us-ascii?Q?3MUHQweVhMcHtF9Lp6AJUFR00EK6slYXSEK7kxt2xcr+BvtYy36rO6yunm49?=
 =?us-ascii?Q?NlAgprKA2YKCXNZEYp9/AWnzHG4b4zLRnBxiNH7auWt2ejn8c05AbaKQEGzC?=
 =?us-ascii?Q?7Uz0qH1CXN6P4dw901fYAfW4ZOwR3Tuq+gdw6pHhuQRBR4eI/WqlPhMp/pqJ?=
 =?us-ascii?Q?BjJT5xhH00FopuRstRynx5OGYwHRMqIjV9ksSbWv8brikuu6pb8VII5gaPel?=
 =?us-ascii?Q?4W++HyIKQB/hNN6EpRXVEyNnH/98RLLh127BPIhcVIHh3STdDD1LIX2otr13?=
 =?us-ascii?Q?xm/bApFvh3Sf734kkL1DvaVv5KHMSnVoHKRqTD8WqnWUtPnfOySuUvN3sgQ/?=
 =?us-ascii?Q?rXlU85NDpkslTaTXCczCb8xRqHxAl5zGlNLYoIucjXAUNre95UzB0W90/RZ0?=
 =?us-ascii?Q?KgraJY8R+S+OAPTQejMbJ5rQDGoM5Tw+qFWHmElabm7A+xGcnQnj3cSAmb+U?=
 =?us-ascii?Q?P+XxB1NapinPQGTVUsECgCh0EYupCV+nKGqfyRlE35TuwqvLxtJClg4OJV2c?=
 =?us-ascii?Q?XwpIPg4e1dC7JaBRDfG3Iy2r1jFdB4KzJ046PGbKzumOmuT13FSM16IYaKto?=
 =?us-ascii?Q?GszMj5B+BqZMBUxjEMHLKQNwVNnL1Sl40gcIJEWyGc4n0j2+sKnVY7NAslG4?=
 =?us-ascii?Q?3lm2SB1oYjCHMfCAEQE7GlFLHbx4Qwq/?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB5056.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/TqmjVlErwzwF9WHcDIxvUU/DFXTg18XcIrg9oH3wnMHMV/K/QH6qvIfeSBL?=
 =?us-ascii?Q?moCk4NZyBDFZOajsVaX6bEoC/obR0o4OWQVODMaMkNrko0mT1pks243BoaKN?=
 =?us-ascii?Q?1TatiVq2DJS9pI6VnqVhdN1O5rZlLwuIdIRcFAc5Q+uCFaaWthN9OAmBpY+U?=
 =?us-ascii?Q?FWLZv3eilqpUOdWGUs+ZBT60D/Erx/07vh7Imd0pXqLmRNtVAM78jCC2gzY5?=
 =?us-ascii?Q?wgTuC3h6eFm/yEbjdc9KTFhCj0PK1HnFM+DUCJ0WcmvOZGcXde/zMzZQd/OL?=
 =?us-ascii?Q?WU4m4lI+zlH9nxPzXKU9JeeLTU9ntxHTTNGkkcp5gZjxyrjv+zS/o2vFyVMI?=
 =?us-ascii?Q?4YKU1HbQVlr3Qb9clR33cWk3xXf/zTh4ptnOepcjUfsosaX5cP2Ran8M7AXn?=
 =?us-ascii?Q?SI1hFpvdXco/q+FSPCvekN0tsPlmZ0KhrbQDImsZyFg8jtkkXc1+2G3wi8qT?=
 =?us-ascii?Q?CLBToOAAjaBWY1rvK4j3pZ6+CwAkh3UDg1yg6AXHTZ/1clLJPhtHzLaO+hBU?=
 =?us-ascii?Q?8J0exz/nUmzPds1K1kkGwjcQQejud7hkQlejZj6mFDKT2KS3aSufFGWQFa6/?=
 =?us-ascii?Q?MZAxPn//gcEikXw2Nn6Gh+ioOoz9VpH2mSBZXqDB6pugZ3rLh2hWMdDiZz8H?=
 =?us-ascii?Q?9gIiGE/Fwkw67NOIaplEm1pohjSCj9TNjJ69UZAT/gFdsb5mTIDwsPMMNl2P?=
 =?us-ascii?Q?lCJMV49tY3onNKbQ5HhPV9HoSrqQyXDn/n63VsxMoCod6dZ56C3oceJX16kM?=
 =?us-ascii?Q?et6B6MMZkeNbcrNuPkLFrGJf8K8GHywdUrbmn/U80HLedSFEqaInvjbUOIBJ?=
 =?us-ascii?Q?yttfDotjL2AccRSt+Cm+F07ivF2NQj7iRJ153qhTZrkKl0pSmQuaS/FT9kda?=
 =?us-ascii?Q?+QBs8uMZXEYyw1TpRYzFyuH7sJKiUQHGi9sFo0C2JQnto+HXumyKqubFULKf?=
 =?us-ascii?Q?LSxAZ4A6aXvHZWFSLRhgUoxM/gLWrBRoalFC4BvgXgcyMEZJPH65aSJRB1WM?=
 =?us-ascii?Q?k8rH15tj5kudVx27r7AfEG1ALJTbWIi+eJIFKOPX9Woxu15exejxIBr18WGy?=
 =?us-ascii?Q?sG852NeG8eyiP8eITHdnCf9+roWUtkzbnCpf66TGvjRhqLVaMD52WqAHs270?=
 =?us-ascii?Q?7PIKT9fEU37DqgQssR4o/JP2QZYamimRgj3phOkO41TyW5lonzZH+a4SUMvO?=
 =?us-ascii?Q?tMSwyjmZxD+BE+0ypX2CTUcPjF/obUH8fRMvYy1ywg8m8hLLy9rT/w5yuW3T?=
 =?us-ascii?Q?WkVpYDhukAyHWGJIpWrjafR8Ib690F+OK6vWjYOKl4ibdnKl40hHEkjeC72I?=
 =?us-ascii?Q?WmET+KY4BfHAZJ49gse2qRQ7JuafOjj6jwt5VaiFH9bH+9NaExbWnVb1Eqdz?=
 =?us-ascii?Q?JcfYfYYYGcgypSOCnd8r4F2hXlf6lc2+S53L26y9VFdegeYo0Aq8Emu6cPXs?=
 =?us-ascii?Q?I4I0gnmkxL+n0YLK+gHf34KWemjuy8hsUOLCYpbZL0kI4E691z/UQra8aPVt?=
 =?us-ascii?Q?GR+L4xILfvdbkJ7m7i0nSDuF/O3shy5BgZ1hToo+5cj7JWL2dFDFvmHzMTiL?=
 =?us-ascii?Q?Z4HvHs9W9aS+74P72+MLHjc+mBkXAxHB7xYEY+v+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5056.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8db604e-222c-4e88-6fa4-08dd6863fe71
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2025 10:34:43.5783 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HKL4m4G/DqwT4tVZyVgs6ZDClOQSBVAQ0gLhKvhXOO8tabAIMrEqwmOP+I+pJ1lYzHnok5MBHL7VtUKhAb69JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4623
X-OriginatorOrg: intel.com
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

Hey Arek

> -----Original Message-----
> From: Kusztal, ArkadiuszX <arkadiuszx.kusztal@intel.com>
> Sent: Thursday 20 March 2025 16:57
> To: dev@dpdk.org
> Cc: gakhil@marvell.com; Ji, Kai <kai.ji@intel.com>; Dooley, Brian
> <brian.dooley@intel.com>; Kusztal, ArkadiuszX
> <arkadiuszx.kusztal@intel.com>; stable@dpdk.org
> Subject: [PATCH] crypto/qat: fix out-of-place header bytes in aead raw ap=
i
>=20
> This commit fixes a problem with overwriting data in the OOP header in RA=
W
> API crypto processing when using AEAD algorithms.
>=20
> Fixes: 85fec6fd9674 ("crypto/qat: unify raw data path functions")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Arkadiusz Kusztal <arkadiuszx.kusztal@intel.com>
> ---
>  drivers/crypto/qat/dev/qat_crypto_pmd_gens.h | 134
> +++++++++++++++++++
>  drivers/crypto/qat/dev/qat_sym_pmd_gen1.c    |  13 +-
>  2 files changed, 142 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/crypto/qat/dev/qat_crypto_pmd_gens.h
> b/drivers/crypto/qat/dev/qat_crypto_pmd_gens.h
> index 35c1888082..c447f2cb45 100644
> --- a/drivers/crypto/qat/dev/qat_crypto_pmd_gens.h
> +++ b/drivers/crypto/qat/dev/qat_crypto_pmd_gens.h
> @@ -6,9 +6,12 @@
>  #define _QAT_CRYPTO_PMD_GENS_H_
>=20
>  #include <rte_cryptodev.h>
> +#include <rte_common.h>
> +#include <rte_branch_prediction.h>
>  #include "qat_crypto.h"
>  #include "qat_sym_session.h"
>  #include "qat_sym.h"
> +#include "icp_qat_fw_la.h"
>=20
>  #define AES_OR_3DES_MISALIGNED (ctx->qat_mode =3D=3D
> ICP_QAT_HW_CIPHER_CBC_MODE && \
>  			((((ctx->qat_cipher_alg =3D=3D
> ICP_QAT_HW_CIPHER_ALGO_AES128) || \ @@ -146,6 +149,137 @@
> qat_cipher_is_len_in_bits(struct qat_sym_session *ctx,
>  	return 0;
>  }
>=20
> +static inline
> +uint32_t qat_reqs_mid_set(int *error, struct icp_qat_fw_la_bulk_req *con=
st
> req,
> +	struct qat_sym_op_cookie *const cookie, const void *const opaque,
> +	const struct rte_crypto_sgl *sgl_src, const struct rte_crypto_sgl
> *sgl_dst,
> +	const union rte_crypto_sym_ofs ofs)
> +{
> +	uint32_t src_tot_length =3D 0; /* Returned value */
> +	uint32_t dst_tot_length =3D 0; /* Used only for input validity checks *=
/
> +	uint32_t src_length =3D 0;
> +	uint32_t dst_length =3D 0;
> +	uint64_t src_data_addr =3D 0;
> +	uint64_t dst_data_addr =3D 0;
> +	const struct rte_crypto_vec * const vec_src =3D sgl_src->vec;
> +	const struct rte_crypto_vec * const vec_dst =3D sgl_dst->vec;
> +	const uint32_t n_src =3D sgl_src->num;
> +	const uint32_t n_dst =3D sgl_dst->num;
> +	const uint16_t offset =3D RTE_MAX(ofs.ofs.cipher.head,
> ofs.ofs.auth.head);
> +	const uint8_t is_flat =3D !(n_src > 1 || n_dst > 1); /* Flat buffer or =
the
> SGL */
> +	const uint8_t is_in_place =3D !n_dst; /* In-place or out-of-place */
> +
> +	*error =3D 0;
> +	if (unlikely((n_src < 1 || n_src > QAT_SYM_SGL_MAX_NUMBER) ||
> +			n_dst > QAT_SYM_SGL_MAX_NUMBER)) {
> +		QAT_LOG(DEBUG,
> +			"Invalid number of sgls, source no: %u, dst no: %u,
> opaque: %p",
> +			n_src, n_dst, opaque);
> +		*error =3D -1;
> +		return 0;
> +	}
> +
> +	/* --- Flat buffer --- */
> +	if (is_flat) {
> +		src_data_addr =3D vec_src->iova;
> +		dst_data_addr =3D vec_src->iova;
> +		src_length =3D vec_src->len;
> +		dst_length =3D vec_src->len;
> +
> +		if (is_in_place)
> +			goto done;
> +		/* Out-of-place
> +		 * If OOP, we need to keep in mind that offset needs to
> +		 * start where the aead starts
> +		 */
> +		dst_length =3D vec_dst->len;
> +		/* Integer promotion here, but it does not bother this time */
> +		if (unlikely(offset > src_length || offset > dst_length)) {
> +			QAT_LOG(DEBUG,
> +				"Invalid size of the vector parameters, source
> length: %u, dst length: %u, opaque: %p",
> +				src_length, dst_length, opaque);
> +			*error =3D -1;
> +			return 0;
> +		}
> +		src_data_addr +=3D offset;
> +		dst_data_addr =3D vec_dst->iova + offset;
> +		src_length -=3D offset;
> +		dst_length -=3D offset;
> +		src_tot_length =3D src_length;
> +		dst_tot_length =3D dst_length;
> +		goto check;
> +	}
> +
> +	/* --- Scatter-gather list --- */
> +	struct qat_sgl * const qat_sgl_src =3D (struct qat_sgl *)&cookie-
> >qat_sgl_src;
> +	uint16_t i;
> +
> +	ICP_QAT_FW_COMN_PTR_TYPE_SET(req-
> >comn_hdr.comn_req_flags,
> +		QAT_COMN_PTR_TYPE_SGL);
> +	qat_sgl_src->num_bufs =3D n_src;
> +	src_data_addr =3D cookie->qat_sgl_src_phys_addr;
> +	/* Fill all the source buffers but the first one */
> +	for (i =3D 1; i < n_src; i++) {
> +		qat_sgl_src->buffers[i].len =3D (vec_src + i)->len;
> +		qat_sgl_src->buffers[i].addr =3D (vec_src + i)->iova;
> +		src_tot_length +=3D qat_sgl_src->buffers[i].len;
> +	}
> +
> +	if (is_in_place) {
> +		/* SGL source first entry, no OOP */
> +		qat_sgl_src->buffers[0].len =3D vec_src->len;
> +		qat_sgl_src->buffers[0].addr =3D vec_src->iova;
> +		dst_data_addr =3D src_data_addr;
> +		goto done;
> +	}
> +	/* Out-of-place */
> +	struct qat_sgl * const qat_sgl_dst =3D
> +			(struct qat_sgl *)&cookie->qat_sgl_dst;
> +	/*
> +	 * Offset reaching outside of the first buffer is not supported (RAW
> api).
> +	 * Integer promotion here, but it does not bother this time
> +	 */
> +	if (unlikely(offset > vec_src->len || offset > vec_dst->len)) {
> +		QAT_LOG(DEBUG,
> +			"Invalid size of the vector parameters, source length:
> %u, dst length: %u, opaque: %p",
> +			vec_src->len, vec_dst->len, opaque);
> +		*error =3D -1;
> +		return 0;
> +	}
> +	/* SGL source first entry, adjusted to OOP offsets */
> +	qat_sgl_src->buffers[0].addr =3D vec_src->iova + offset;
> +	qat_sgl_src->buffers[0].len =3D vec_src->len - offset;
> +	/* SGL destination first entry, adjusted to OOP offsets */
> +	qat_sgl_dst->buffers[0].addr =3D vec_dst->iova + offset;
> +	qat_sgl_dst->buffers[0].len =3D vec_dst->len - offset;
> +	/* Fill the remaining destination buffers */
> +	for (i =3D 1; i < n_dst; i++) {
> +		qat_sgl_dst->buffers[i].len =3D (vec_dst + i)->len;
> +		qat_sgl_dst->buffers[i].addr =3D (vec_dst + i)->iova;
> +		dst_tot_length +=3D qat_sgl_dst->buffers[i].len;
> +	}
> +	dst_tot_length +=3D qat_sgl_dst->buffers[0].len;
> +	qat_sgl_dst->num_bufs =3D n_dst;
> +	dst_data_addr =3D cookie->qat_sgl_dst_phys_addr;
> +
> +check:	/* If error, return directly. If success, jump to one of these la=
bels */
> +	if (src_tot_length !=3D dst_tot_length) {
> +		QAT_LOG(DEBUG,
> +			"Source length is not equal to the destination length
> %u, dst no: %u, opaque: %p",
> +			src_tot_length, dst_tot_length, opaque);
> +		*error =3D -1;
> +		return 0;
> +	}
> +done:
> +	req->comn_mid.opaque_data =3D (uintptr_t)opaque;
> +	req->comn_mid.src_data_addr =3D src_data_addr;
> +	req->comn_mid.dest_data_addr =3D dst_data_addr;
> +	req->comn_mid.src_length =3D src_length;
> +	req->comn_mid.dst_length =3D dst_length;
> +
> +	return src_tot_length;
> +}
> +
>  static __rte_always_inline int32_t
>  qat_sym_build_req_set_data(struct icp_qat_fw_la_bulk_req *req,
>  		void *opaque, struct qat_sym_op_cookie *cookie, diff --git
> a/drivers/crypto/qat/dev/qat_sym_pmd_gen1.c
> b/drivers/crypto/qat/dev/qat_sym_pmd_gen1.c
> index 24e51a9318..3976d03179 100644
> --- a/drivers/crypto/qat/dev/qat_sym_pmd_gen1.c
> +++ b/drivers/crypto/qat/dev/qat_sym_pmd_gen1.c
> @@ -942,16 +942,19 @@ qat_sym_dp_enqueue_aead_jobs_gen1(void
> *qp_data, uint8_t *drv_ctx,
>  	for (i =3D 0; i < n; i++) {
>  		struct qat_sym_op_cookie *cookie =3D
>  			qp->op_cookies[tail >> tx_queue->trailz];
> +		int error =3D 0;
>=20
>  		req  =3D (struct icp_qat_fw_la_bulk_req *)(
>  			(uint8_t *)tx_queue->base_addr + tail);
>  		rte_mov128((uint8_t *)req, (const uint8_t *)&(ctx->fw_req));
>=20
>  		if (vec->dest_sgl) {
> -			data_len =3D qat_sym_build_req_set_data(req,
> -				user_data[i], cookie,
> -				vec->src_sgl[i].vec, vec->src_sgl[i].num,
> -				vec->dest_sgl[i].vec, vec->dest_sgl[i].num);
> +			data_len =3D qat_reqs_mid_set(&error, req, cookie,
> user_data[i],
> +					&vec->src_sgl[i], &vec->dest_sgl[i],
> ofs);
> +			/* In oop there is no offset, src/dst addresses are
> moved
> +			 * to avoid overwriting the dst header
> +			 */
> +			ofs.ofs.cipher.head =3D 0;
>  		} else {
>  			data_len =3D qat_sym_build_req_set_data(req,
>  				user_data[i], cookie,
> @@ -959,7 +962,7 @@ qat_sym_dp_enqueue_aead_jobs_gen1(void
> *qp_data, uint8_t *drv_ctx,
>  				vec->src_sgl[i].num, NULL, 0);
>  		}
>=20
> -		if (unlikely(data_len < 0))
> +		if (unlikely(data_len < 0) || error)
>  			break;
>=20
>  		enqueue_one_aead_job_gen1(ctx, req, &vec->iv[i],
> --
> 2.43.0

Acked-by: Brian Dooley <brian.dooley@intel.com>

