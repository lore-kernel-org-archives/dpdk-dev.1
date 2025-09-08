Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B094CAC581
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Sep 2025 15:11:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 130D94060C;
	Mon,  8 Sep 2025 17:11:01 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 9CAE1402EB
 for <dev@dpdk.org>; Mon,  8 Sep 2025 17:10:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757344259; x=1788880259;
 h=from:to:subject:date:message-id:references:in-reply-to:
 mime-version; bh=Y2lI3GhpuC6SWjfM7AiRlr4qfLHed2zLRQJl1+yBt68=;
 b=HXz/XzngGpVl8gOQQ7qTJiEhx73Ql4gj+mICv32Sh/qwVV6Tq//TmrF8
 QBIZ3kZZldMQuQZyxIVmraNIk7PLj21/rvJus+83k1v1QBRCV/P8iJs2Z
 9NgECI17Ng4/dqo5UxrVWgiK9csFtwC6n2eWgPrz6ksTirU1rLsNrnUa0
 l4gI4lcdwpt19bAjV+7BGTnKbNkhfJVpgrpEvJwuvMjEUd9KBOkYr7DKW
 BW1NjKqMwGB0OEomixibfEMgOfJvo1hER6aUAKz16gtNSh22fVUdNk32U
 fbeMVpebbLcEY8im4jPpSceHBY9Oq0nXOj2xMsTP8L4OH2DpDLs619AgW w==;
X-CSE-ConnectionGUID: JmQKQBXdTGGiCvdi1rruig==
X-CSE-MsgGUID: wO+eEPK6QaKNwjBGItepPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="70224987"
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; d="scan'208,217";a="70224987"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2025 08:10:58 -0700
X-CSE-ConnectionGUID: t6ljcdKCTlqJpPpl+9p44w==
X-CSE-MsgGUID: do9SekzQR9C5fvcTC7/m1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
 d="scan'208,217";a="178031792"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2025 08:10:58 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 8 Sep 2025 08:10:56 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 8 Sep 2025 08:10:56 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.44)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 8 Sep 2025 08:10:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D1qZXCJ49HwwxfTzQj/NMmtriUY6c2YFnPs3s2WLk/wPze9phcIEHYziNquVQFvrRcDNFWvHpNNq/2hg/GzVTso0Avq1MoVraa13X4/cp5PN3bMYs6BU8eXxK8NiNwD41L5WIMCpwRHafVE+pjgbArikc0G7Hb6qsJ3hcfx/zEH+he9GsTTBGH2Jup8DjPEzrkpXd9JQO6j+McWwFY+pEd5eG/e0I42WQqzCphTUIMFJrA9Ti6WWF/6CRTXoBQewjLlZC3ju+VXyquIm9lAU5ZF/k0zLUH0WeT2njnmG3woMS382/HluwliJi4HFj+b/67T+BQ8/j6LC7wnc7Ubv3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bQcX3lXrc3ICnUHmhsTxG2G34W3lOLlM1VdFJ+mUjQ0=;
 b=O8d153fPxHTlDETTOR2QyoPZFgi38b/uExNAFNA3hKpe++XPmMiTtb74rQyl74h6UqiJEE6Yz9mv6fVyiyIJDOZ/P/02cg6Kb3xaSwWSsGvzysIZ/QLOPVc4xoWZZrPafLVby/a8l/+KV2443Usx8NWXNb+BFQT09KjYgrr44GhddCQqShx0bvbn3uLYsqMzqGRB94SqinkCeKP9B88h00Fx+bM2YJCM7QJUsyVACY1y6xLrvoh9w+qoMmlko6d5/FcrxrhI8OC026AecG9g1d5LohPuIrFUjFsXUdC2Vj0WU0O+EY8XNBnJvTVYFEPiR1YIw3TRZjhH/SwA3+u9Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7458.namprd11.prod.outlook.com (2603:10b6:8:145::13)
 by SJ0PR11MB5022.namprd11.prod.outlook.com (2603:10b6:a03:2d7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 15:10:52 +0000
Received: from DS0PR11MB7458.namprd11.prod.outlook.com
 ([fe80::6d78:37d8:c835:540]) by DS0PR11MB7458.namprd11.prod.outlook.com
 ([fe80::6d78:37d8:c835:540%5]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 15:10:52 +0000
From: "Ji, Kai" <kai.ji@intel.com>
To: "Nicolau, Radu" <radu.nicolau@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH 1/3] crypto/qat: Add ECDH, ECDSA and ECPM capabilities
Thread-Topic: [PATCH 1/3] crypto/qat: Add ECDH, ECDSA and ECPM capabilities
Thread-Index: AQHcFzRcwJu0Qa2h2UKYzS+UZPMkQLSJdvlt
Date: Mon, 8 Sep 2025 15:10:52 +0000
Message-ID: <DS0PR11MB74587E99182F8B15032133AD810CA@DS0PR11MB7458.namprd11.prod.outlook.com>
References: <20250827092358.765222-1-radu.nicolau@intel.com>
In-Reply-To: <20250827092358.765222-1-radu.nicolau@intel.com>
Accept-Language: en-GB, en-US, en-IE
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7458:EE_|SJ0PR11MB5022:EE_
x-ms-office365-filtering-correlation-id: 54d43bfe-ee49-4b9c-55da-08ddeee9e6ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|42112799006|38070700018|8096899003|7053199007;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?7TanMbj0itPDhJEMEOk6GnBubcCxE9sNWnDxbo1UZ8HNHXqC4EwnYy0W05?=
 =?iso-8859-1?Q?qlYHYC7WgnNoNvR+YP4m89g+c8fgQAN51worcMsYJ9iys8EfGHiYCARErU?=
 =?iso-8859-1?Q?FWYa9YKFqUx7iFfLvmMu9mhVhV/HZkvD4ICA8jFfaKentl18K17aE0HCRl?=
 =?iso-8859-1?Q?DtVtzSGKPlmEzYbhSyshjNlfTb9m03vBAc7WA3gftELQPtS8BNxw+WV5+3?=
 =?iso-8859-1?Q?BCV0GcPX7SSQxcKC5Xx3yi4DxVaemLXTYpDj1bsEswIPJLrePPofeKEijz?=
 =?iso-8859-1?Q?uwZq6zWKCLRNwYAvs2sl671menjVoKEaLpPzJhhJF/60HDKCBEF9vqSEED?=
 =?iso-8859-1?Q?1IJ7QuvBBwA9lEc3JJ0bbBPVSC8aTA8y5COCB28FZgqxDyDBMUC7Ieds91?=
 =?iso-8859-1?Q?7CdOo+6E11OBQF3HnVXOrD0XWjIHoHr1LFf363y+YZB1L6jfBEUMnLwqBO?=
 =?iso-8859-1?Q?E9YG1vLy4NRpckmCv4X4eDPl+fb6hu/ugoT6T8C9/3Up/dE6Ug1nHE923s?=
 =?iso-8859-1?Q?kh2/bGC7jKSA0Ua0znSgJKk/ge4ppgkEupsYkpUSD1U+p2dxtirvGrNZFo?=
 =?iso-8859-1?Q?ToHwZNxe75avUZtsxf959M+65DI+rL9FxKam0544HDqqRyD07Z+kSQgZXn?=
 =?iso-8859-1?Q?1T6kXdhDVrrEH7cAcMF5xeoDWHGDnWolTCK8WH2ST0M8yp0v1YcHs1Ku8S?=
 =?iso-8859-1?Q?lxsXjUZRwPTpSwoxVdT0xyLHuDOl0NMq6avHj5oFmvZf/8iE8aF4nYDXQF?=
 =?iso-8859-1?Q?sRRvErfmx5US8yi3n+SJ4QJaiY+n0FniRzCIqSgUIC6W4JTdwYFP7iY1l2?=
 =?iso-8859-1?Q?d3n9BJ4EmBm0swVaY1wnYFwgAARWZ0/CaEZm2IktoX9acGSX4nq9tTYrSr?=
 =?iso-8859-1?Q?kPf4nQj1kwcvvtVxU6Y4WFgcs/GFumInyUw+IMSjpG3nV07NQOu2UFnvIX?=
 =?iso-8859-1?Q?eKbpNJ4FI5TSCD4Sf1b16pVKyxzmPlEjlp2GFrwCpPyrvgNXRbYZzOzDaO?=
 =?iso-8859-1?Q?TSPdSwYYb33cfGuY3ODoszQbTZh6A/3JzvMffPAcg57T4AY15dPcVGQ/p5?=
 =?iso-8859-1?Q?HHEANp60SHZN6UIvAlvXFJVpHJOReHvuUAjvRypk9FZq5EKxud9N0UqUtH?=
 =?iso-8859-1?Q?dlh1cT71C/QR486vf5dMY0QkqKs2S62VfFwshTRCatof0ZfSrL0zXQP+4B?=
 =?iso-8859-1?Q?ezgt9plLX8j/zZsqR8eFBwcUJN2EoMHuqvy7dLTfrZEuKN3ylXDOU4oVBl?=
 =?iso-8859-1?Q?yrToM8CvxAfGy3OkS8nrnvvoRUhSnjMPiphw6V7W0w1QBl28OogVa79ndo?=
 =?iso-8859-1?Q?WxDL5TVtHbj03QydyLBvnjlOz0pvGr16Emrr00Q3oSdTnEtX6R0hKbhdoo?=
 =?iso-8859-1?Q?AhrbPiagLb1Euh9dTOn3XYQ8XMumqQnYdFHc+v1E3IP/mwBcoZXmG/aCHU?=
 =?iso-8859-1?Q?CDCQYsPDPKj9dt0qj6uzpFj2dq3R3w6o3v3xTgkqNpdoYzPfxQssPJtV6q?=
 =?iso-8859-1?Q?jrhquBkRkOcA3XKJA3ulOLdFbyli64xnjr6gH/T4+VFA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7458.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(42112799006)(38070700018)(8096899003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?z3Ztfc+NdL1C5i9Xr6ngQz7C7hsIxycWFRKPykbD19hFQOJsX9Gv9+hNu4?=
 =?iso-8859-1?Q?urQshGBF8VtVPNoEl8NIHOT59IqxchbOuSsek0hkoKRDEJnluGZzPw/9TS?=
 =?iso-8859-1?Q?wK7TpKaO8RoVRTPpYtOuw0BE+A5YK2ygXOAJchs7KCTb0wVh2eafQB8cOP?=
 =?iso-8859-1?Q?UfFaWRQWQLxAAFadqt+OuA54mkeu93UcDEQ7UC6uoMoGZbh83NWeWr8/lC?=
 =?iso-8859-1?Q?7pc4s8aPxITdIwloAlnPQOeqqqrfKY2161pepvmInXT2PJrBXKuy+XoyWL?=
 =?iso-8859-1?Q?Fb+p1Io4+zxY65Beb/mHcomoWaU/IRPfCBUbjwAMeLeK8PxaU2xBGrGjSG?=
 =?iso-8859-1?Q?kqK4X/rtBaps52lpcYy2kk0ilqwbDqYy3XT2PZpq6mc5hYRWqH2yaCmMNZ?=
 =?iso-8859-1?Q?ICvahDrGDzEek8svpUVVvLSpCP9xdVvzb4b624qfa74z2plZsl9cBAHssH?=
 =?iso-8859-1?Q?9vpbPyyOkewT9pOwNNoVidRHDveZ22QljxqyyDeGbFF8epZLCDK+k2t5RB?=
 =?iso-8859-1?Q?j2anSWg2EkiMB1ag/9BOuPLzpbsLP4KfeKexxmIVoxUGrcpg32yhDJQINY?=
 =?iso-8859-1?Q?v++2f1v/jpSVl8AVArI6yZAFKz55O9LvFI5k07DxXW8rgWmGEWd7wFPntH?=
 =?iso-8859-1?Q?TluDXwDoqFbwtOkoEQ/iATQFmjE7R8Fh21mTBD/5lcyvBkY4e9mxdZzpqd?=
 =?iso-8859-1?Q?Ro9T6IdvIefcPovab1dVkKjjwGdgbSMXIXYVCwGhp8FniZFCrBJl0PDcQo?=
 =?iso-8859-1?Q?6Lsp5Rj800NhqaQpMeHmTAUu/F5MBYLpIvbrPN+oO2lSDomvmsRiA3ehEE?=
 =?iso-8859-1?Q?LX7n9XJc6M/LLLWEv/4tKFV6u58DGsqyUo3vwan14dnFTI6SCS88Yl6Vvz?=
 =?iso-8859-1?Q?Z5mAW3YZRefVA/CNtuVnMBG23mHPEbxAQxciDM0bDIecUNFBvEVeZjVL7Y?=
 =?iso-8859-1?Q?G7l3dBjaiGQFZ8aRVNuDeoavTVX0b3GG9C5HH3lmjDrWz8hfeeNe3GOJWm?=
 =?iso-8859-1?Q?Z2vJjQKIW7PZTpB+6RNDBvd38nuKCqHhSypvYwwOiSpEmJTi9Lu0fVhmzs?=
 =?iso-8859-1?Q?saNzDdoiNwFGPiH7nXMQwKQCq1Mi/DscYkK9dlFX5v3Mfj487wDYfgcqT0?=
 =?iso-8859-1?Q?pKj4Gh7So9819Zjw72OGE0VKCAGSuLfo/s75whj5zspfKj/49SRA5MyQ6Q?=
 =?iso-8859-1?Q?e/WODygglo94ljJIm4fSvdVicNUNwuQeEQ+q4U258Ytyx1ORh1WqpX1XLz?=
 =?iso-8859-1?Q?hBY20pCrbScK13y6yojl+ndrZyitvr342NH4hYl5fkHSNGpECoiwDsZE6c?=
 =?iso-8859-1?Q?2b9eXDfRJqaHHVtCE/XWBMKde7lEVQ71flJBblleizZkh8UxnFJa3YMoV2?=
 =?iso-8859-1?Q?rN8YIn/tZc6hguMTiJi4uWfaS2rt47xzUoRLAEPTKhI1/2G5l7hsqHQR2y?=
 =?iso-8859-1?Q?keu1NVrPrUdGEhBpSBVbxKDHLeQjOCLTdo9Hu5jJ6ySGfoJB1XJClITyKI?=
 =?iso-8859-1?Q?AoSVFYCiA8Lwv6uJIht9WdYHrqvHuYAY3ExSPRD/cVVgLzD/DXLU8hiEaj?=
 =?iso-8859-1?Q?qjEqDrUcKqMB6bdReAiFHq6w5YeU6C3AhjA2i7DOaHSADmBsVG9CHwehb7?=
 =?iso-8859-1?Q?cat3uufYxKPLY=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DS0PR11MB74587E99182F8B15032133AD810CADS0PR11MB7458namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7458.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54d43bfe-ee49-4b9c-55da-08ddeee9e6ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2025 15:10:52.5453 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mMDgOoxISe2HNMRv37mYSBf9YoZZFs6O1Mp2fSDZGpB0o6diET3nGZhBHJmOgA06nhNxS/Q9vnio3Pf0E+k9og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5022
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

--_000_DS0PR11MB74587E99182F8B15032133AD810CADS0PR11MB7458namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Series-acked-by: Kai Ji <kai.ji@intel.com>



________________________________
From: Nicolau, Radu <radu.nicolau@intel.com>
Sent: Wednesday, August 27, 2025 10:23
To: dev@dpdk.org <dev@dpdk.org>
Cc: Nicolau, Radu <radu.nicolau@intel.com>; Ji, Kai <kai.ji@intel.com>
Subject: [PATCH 1/3] crypto/qat: Add ECDH, ECDSA and ECPM capabilities

Add missing eliptic curves capabilities.
Small fixes on ECDH implementation.

Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
---
 drivers/crypto/qat/dev/qat_asym_pmd_gen1.c | 13 +++++++++++++
 drivers/crypto/qat/qat_asym.c              |  9 +++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/qat/dev/qat_asym_pmd_gen1.c b/drivers/crypto/qa=
t/dev/qat_asym_pmd_gen1.c
index 67b1892c32..20001bd1cc 100644
--- a/drivers/crypto/qat/dev/qat_asym_pmd_gen1.c
+++ b/drivers/crypto/qat/dev/qat_asym_pmd_gen1.c
@@ -38,6 +38,19 @@ static struct rte_cryptodev_capabilities qat_asym_crypto=
_caps_gen1[] =3D {
                         (1 << RTE_CRYPTO_ASYM_OP_ENCRYPT) |
                         (1 << RTE_CRYPTO_ASYM_OP_DECRYPT)),
                         64, 512, 64),
+       QAT_ASYM_CAP(ECDH,
+                       ((1 << RTE_CRYPTO_ASYM_KE_PUB_KEY_GENERATE) |
+                       (1 << RTE_CRYPTO_ASYM_KE_SHARED_SECRET_COMPUTE) |
+                       (1 << RTE_CRYPTO_ASYM_KE_PUB_KEY_VERIFY)),
+                       64, 512, 64),
+       QAT_ASYM_CAP(ECDSA,
+                       ((1 << RTE_CRYPTO_ASYM_OP_SIGN) |
+                       (1 << RTE_CRYPTO_ASYM_OP_VERIFY)),
+                       64, 512, 64),
+       QAT_ASYM_CAP(ECPM,
+                       ((1 << RTE_CRYPTO_ASYM_OP_SIGN) |
+                       (1 << RTE_CRYPTO_ASYM_OP_VERIFY)),
+                       64, 512, 64),
         RTE_CRYPTODEV_END_OF_CAPABILITIES_LIST()
 };

diff --git a/drivers/crypto/qat/qat_asym.c b/drivers/crypto/qat/qat_asym.c
index d8a1406819..bd22fc0a6f 100644
--- a/drivers/crypto/qat/qat_asym.c
+++ b/drivers/crypto/qat/qat_asym.c
@@ -801,11 +801,14 @@ ecdh_set_input(struct icp_qat_fw_pke_request *qat_req=
,
                 SET_PKE_LN(asym_op->ecdh.priv_key, qat_func_alignsize, 0);
                 SET_PKE_LN_EC(curve[curve_id], x, 1);
                 SET_PKE_LN_EC(curve[curve_id], y, 2);
-       } else {
+       } else if (asym_op->ecdh.ke_type =3D=3D RTE_CRYPTO_ASYM_KE_SHARED_S=
ECRET_COMPUTE) {
                 SET_PKE_LN(asym_op->ecdh.priv_key, qat_func_alignsize, 0);
                 SET_PKE_LN(asym_op->ecdh.pub_key.x, qat_func_alignsize, 1)=
;
                 SET_PKE_LN(asym_op->ecdh.pub_key.y, qat_func_alignsize, 2)=
;
+       } else {
+               return -EINVAL;
         }
+
         SET_PKE_LN_EC(curve[curve_id], a, 3);
         SET_PKE_LN_EC(curve[curve_id], b, 4);
         SET_PKE_LN_EC(curve[curve_id], p, 5);
@@ -894,11 +897,13 @@ ecdh_collect(struct rte_crypto_asym_op *asym_op,
                 asym_op->ecdh.pub_key.y.length =3D alg_bytesize;
                 x =3D asym_op->ecdh.pub_key.x.data;
                 y =3D asym_op->ecdh.pub_key.y.data;
-       } else {
+       } else if (asym_op->ecdh.ke_type =3D=3D RTE_CRYPTO_ASYM_KE_SHARED_S=
ECRET_COMPUTE) {
                 asym_op->ecdh.shared_secret.x.length =3D alg_bytesize;
                 asym_op->ecdh.shared_secret.y.length =3D alg_bytesize;
                 x =3D asym_op->ecdh.shared_secret.x.data;
                 y =3D asym_op->ecdh.shared_secret.y.data;
+       } else {
+               return -EINVAL;
         }

         rte_memcpy(x, &cookie->output_array[0][ltrim], alg_bytesize);
--
2.50.1


--_000_DS0PR11MB74587E99182F8B15032133AD810CADS0PR11MB7458namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: &quot;IntelOne Text&quot;; font-size: 10pt; colo=
r: rgb(0, 0, 0);" class=3D"elementToProof">
Series-acked-by: Kai Ji &lt;kai.ji@intel.com&gt;</div>
<div style=3D"font-family: &quot;IntelOne Text&quot;; font-size: 10pt; colo=
r: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div id=3D"appendonsend"></div>
<div><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;Nicolau, Radu &lt;radu.nicolau@intel.com&gt;<br>
<b>Sent:</b>&nbsp;Wednesday, August 27, 2025 10:23<br>
<b>To:</b>&nbsp;dev@dpdk.org &lt;dev@dpdk.org&gt;<br>
<b>Cc:</b>&nbsp;Nicolau, Radu &lt;radu.nicolau@intel.com&gt;; Ji, Kai &lt;k=
ai.ji@intel.com&gt;<br>
<b>Subject:</b>&nbsp;[PATCH 1/3] crypto/qat: Add ECDH, ECDSA and ECPM capab=
ilities </div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-size: 11pt;">Add missing eliptic curves capabilities.<br=
>
Small fixes on ECDH implementation.<br>
<br>
Signed-off-by: Radu Nicolau &lt;radu.nicolau@intel.com&gt;<br>
---<br>
&nbsp;drivers/crypto/qat/dev/qat_asym_pmd_gen1.c | 13 +++++++++++++<br>
&nbsp;drivers/crypto/qat/qat_asym.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 9 +++++++--<br>
&nbsp;2 files changed, 20 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/crypto/qat/dev/qat_asym_pmd_gen1.c b/drivers/crypto/qa=
t/dev/qat_asym_pmd_gen1.c<br>
index 67b1892c32..20001bd1cc 100644<br>
--- a/drivers/crypto/qat/dev/qat_asym_pmd_gen1.c<br>
+++ b/drivers/crypto/qat/dev/qat_asym_pmd_gen1.c<br>
@@ -38,6 +38,19 @@ static struct rte_cryptodev_capabilities qat_asym_crypto=
_caps_gen1[] =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1 &l=
t;&lt; RTE_CRYPTO_ASYM_OP_ENCRYPT) |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1 &l=
t;&lt; RTE_CRYPTO_ASYM_OP_DECRYPT)),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 64, 5=
12, 64),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; QAT_ASYM_CAP(ECDH,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((1 &lt;&lt; RTE=
_CRYPTO_ASYM_KE_PUB_KEY_GENERATE) |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1 &lt;&lt; RTE_=
CRYPTO_ASYM_KE_SHARED_SECRET_COMPUTE) |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1 &lt;&lt; RTE_=
CRYPTO_ASYM_KE_PUB_KEY_VERIFY)),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 64, 512, 64),<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; QAT_ASYM_CAP(ECDSA,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((1 &lt;&lt; RTE=
_CRYPTO_ASYM_OP_SIGN) |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1 &lt;&lt; RTE_=
CRYPTO_ASYM_OP_VERIFY)),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 64, 512, 64),<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; QAT_ASYM_CAP(ECPM,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((1 &lt;&lt; RTE=
_CRYPTO_ASYM_OP_SIGN) |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1 &lt;&lt; RTE_=
CRYPTO_ASYM_OP_VERIFY)),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 64, 512, 64),<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_CRYPTODEV_END_OF_CAPAB=
ILITIES_LIST()<br>
&nbsp;};<br>
&nbsp;<br>
diff --git a/drivers/crypto/qat/qat_asym.c b/drivers/crypto/qat/qat_asym.c<=
br>
index d8a1406819..bd22fc0a6f 100644<br>
--- a/drivers/crypto/qat/qat_asym.c<br>
+++ b/drivers/crypto/qat/qat_asym.c<br>
@@ -801,11 +801,14 @@ ecdh_set_input(struct icp_qat_fw_pke_request *qat_req=
,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; SET_PKE_LN(asym_op-&gt;ecdh.priv_key, qat_func_aligns=
ize, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; SET_PKE_LN_EC(curve[curve_id], x, 1);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; SET_PKE_LN_EC(curve[curve_id], y, 2);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (asym_op-&gt;ecdh.ke_type =
=3D=3D RTE_CRYPTO_ASYM_KE_SHARED_SECRET_COMPUTE) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; SET_PKE_LN(asym_op-&gt;ecdh.priv_key, qat_func_aligns=
ize, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; SET_PKE_LN(asym_op-&gt;ecdh.pub_key.x, qat_func_align=
size, 1);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; SET_PKE_LN(asym_op-&gt;ecdh.pub_key.y, qat_func_align=
size, 2);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SET_PKE_LN_EC(curve[curve_=
id], a, 3);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SET_PKE_LN_EC(curve[curve_=
id], b, 4);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SET_PKE_LN_EC(curve[curve_=
id], p, 5);<br>
@@ -894,11 +897,13 @@ ecdh_collect(struct rte_crypto_asym_op *asym_op,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; asym_op-&gt;ecdh.pub_key.y.length =3D alg_bytesize;<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; x =3D asym_op-&gt;ecdh.pub_key.x.data;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; y =3D asym_op-&gt;ecdh.pub_key.y.data;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (asym_op-&gt;ecdh.ke_type =
=3D=3D RTE_CRYPTO_ASYM_KE_SHARED_SECRET_COMPUTE) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; asym_op-&gt;ecdh.shared_secret.x.length =3D alg_bytes=
ize;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; asym_op-&gt;ecdh.shared_secret.y.length =3D alg_bytes=
ize;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; x =3D asym_op-&gt;ecdh.shared_secret.x.data;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; y =3D asym_op-&gt;ecdh.shared_secret.y.data;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rte_memcpy(x, &amp;cookie-=
&gt;output_array[0][ltrim], alg_bytesize);<br>
--<br>
2.50.1<br>
<br>
</div>
</body>
</html>

--_000_DS0PR11MB74587E99182F8B15032133AD810CADS0PR11MB7458namp_--
