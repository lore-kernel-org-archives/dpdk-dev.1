Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89136CCA470
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Oct 2025 11:02:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7698640B92;
	Wed,  1 Oct 2025 13:02:10 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 717B3406B6
 for <dev@dpdk.org>; Wed,  1 Oct 2025 13:02:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759316529; x=1790852529;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=O5jXMRG+XCzm63W1pp0G3p20zyii045aXeD566Snq9o=;
 b=KIBrnVpKNzkJ+CPdhcGrVtV4oTsF3UaORo5TIA1bbooToZP0DIC41yH7
 JALehDZgsbZ5sfMPK0vmkcKTJwCqqSWb1EpANtAXG83U3hggLbBV/aRoo
 JGVI1psO7nQ/3xe4E9C38ywTWIIC/awv9Mtk7xZ5/QPhDaMp5/n2EY4br
 YiKgn87ATtFXCM3xjrl+wzOOqHDNoUdTJGpG04UxXv8YuMIoe27QAue8l
 v8R5sPAKYQKwftzpGGlllZUwU5NkXoXIAXdU0R6zZKSsEyalI4y0ovLAE
 t+0H+0uEqoZr1nYRLLWcbrjlHC8xxoUbzG17IR31xw8InCQIfuLmh9/kf w==;
X-CSE-ConnectionGUID: Za/1l/HqTZimkSE13Gjsbw==
X-CSE-MsgGUID: FSrYHz+gT1mZZT966V632A==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="61295893"
X-IronPort-AV: E=Sophos;i="6.18,306,1751266800"; d="scan'208,217";a="61295893"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2025 04:02:02 -0700
X-CSE-ConnectionGUID: W5vcTAZZQt6wcobhF45OOg==
X-CSE-MsgGUID: FJKg8veMSYqXlCVkCPvhjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,306,1751266800"; 
 d="scan'208,217";a="179173180"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2025 04:02:01 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 1 Oct 2025 04:02:00 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 1 Oct 2025 04:02:00 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.14) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 1 Oct 2025 04:01:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U6QN34ZfSbD3N387fX6y34X4kKdpoGXFPn8UzHVnVfYlRN7lY+wZOfeem2wNj+iJugCSkWJCuryVZx6HrHTogqEEjY3ONe1Bl0i2G0Iqt0OJaBxxcZZW0xTjqPtjCj8sq5uhGtlw0IiJQGqFLZGfTGqyds/4lUWFi/QX56MQDn+HBQTVPDf5oNDu1fETGVWkcqKq0tFTjLHkTyMj/UXIulMi0lBxa9zH7v8lrXQkKYJlmt+HCCd8et/OzxmPD/a58NIGmQtkO/gyRJZM6tJFy7ni+s+YdDV8CsfGymopV2apltOSN2H0TKZi9QefZ5yR8ME6s7z7qK4kQToitS/6uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wQLxQGX08V8Ukg5h4S7qrlwR0ZvGgJj6shR93aqXvQs=;
 b=m1AH78nd6+cweiqmVKUrkVAz3b4QYZpkVZvu7KvTlgJU867fNRvfilindneGEXlmCw3d/iqQ9Z5B9PN4WzwfEdqbkya9D/WeOiC2K7G/UVXtiJgIl/vr7w6whT+A1wE45E2WMrKxKGHsJlr63xuof40eadOIARXr1zsZcRbk8z6C1AviozquitE1WWmxYL5gVj2Zkq+A60Cq+GdFc6k2eiVcjbWUD+9Jjds/+eNgcTTmIWq5D03HJKG4y8VMpeZKNECyYVGpyfXsx0n49xgoscHq7+fYSZ28irJxLVR7ObxDC1DWVkVVUbV8NmZRPMjuyLnLTDH0zAAzYVAuB1e7iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7458.namprd11.prod.outlook.com (2603:10b6:8:145::13)
 by PH7PR11MB6499.namprd11.prod.outlook.com (2603:10b6:510:1f0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Wed, 1 Oct
 2025 11:01:54 +0000
Received: from DS0PR11MB7458.namprd11.prod.outlook.com
 ([fe80::6d78:37d8:c835:540]) by DS0PR11MB7458.namprd11.prod.outlook.com
 ([fe80::6d78:37d8:c835:540%5]) with mapi id 15.20.9160.015; Wed, 1 Oct 2025
 11:01:54 +0000
From: "Ji, Kai" <kai.ji@intel.com>
To: "Nicolau, Radu" <radu.nicolau@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "De Lara Guarch, Pablo" <pablo.de.lara.guarch@intel.com>
Subject: Re: [PATCH v2 1/3] crypto/ipsec_mb: improve CPU code path
Thread-Topic: [PATCH v2 1/3] crypto/ipsec_mb: improve CPU code path
Thread-Index: AQHcIx4Wb2dFIiwq4E2pzfL2UC1x0bStPzuJ
Date: Wed, 1 Oct 2025 11:01:53 +0000
Message-ID: <DS0PR11MB74589FB5F44DE9D4A0349BBC81E6A@DS0PR11MB7458.namprd11.prod.outlook.com>
References: <20250911131447.1247417-1-radu.nicolau@intel.com>
In-Reply-To: <20250911131447.1247417-1-radu.nicolau@intel.com>
Accept-Language: en-GB, en-US, en-IE
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7458:EE_|PH7PR11MB6499:EE_
x-ms-office365-filtering-correlation-id: 9957b8ca-45d4-4756-cf3c-08de00d9ee61
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|42112799006|38070700021|7053199007|8096899003;
x-microsoft-antispam-message-info: =?us-ascii?Q?ZiuO9KyPuGyI7llR2SnOtRXWivKkAPtCRhwDlcnbvgQkxY8DRJkWJcW1wiD1?=
 =?us-ascii?Q?S5vmaElE1KKr6mCqyRKkr+ubHKZ7Q0qOnVjH2+oPnsRipSU0mfB4MlT3517d?=
 =?us-ascii?Q?WSRtsNukBBGoLDrRPHdk0sbr2i0By9hWm6Trx7YGufXtefVT6GiFEot+Xzoj?=
 =?us-ascii?Q?UEkVkyrN1lkrRQEuOruLnR+21/Fs4pTwHhJGmdjrEjI4N6cRL/qOWxonIEbm?=
 =?us-ascii?Q?ty8bKdmUAub6lYeh0Tq/GazoSS+88P60FQwn4aiR8USM0zHBb5VflZiT+1tS?=
 =?us-ascii?Q?4ONgihG7DtfE/kTFZIojXtvuPsMpnhnxPhkRSSl2C6vysKJku5EENx713IgC?=
 =?us-ascii?Q?AAVb5QSvGVmm7IATCL/1n/v9ZP7BpKy1pRC1v9HT3aRsdUxJAsuet71t97pT?=
 =?us-ascii?Q?AzjFSA50O+DAQ5IlhmNsGbgop6UbO7SwWcSDDG8mJu1nv5VTeKuJzABeD5IP?=
 =?us-ascii?Q?ZD//OzSQRi6Mp7h0PMDbvPAgFAbi6tWCZ5uUebyiSBgS47Nd1cZcRfTfKq9P?=
 =?us-ascii?Q?bYuGaXwuU9eb2KsWzNf9Vwh9uF0S2FjJTAsY+U3nH/j2IGrIa8BQrRCdWSy+?=
 =?us-ascii?Q?M8xJDZUFbRRBzcnQPLgJmzU89k9yMFuWynAkmBn13yeFogqoQFTOpcP74vxm?=
 =?us-ascii?Q?OrNjn74GHpFHPbF8usALxin0GSzMREGsqQ3U/LVndRorRQGqhaLd5fwePsCU?=
 =?us-ascii?Q?cKd2jbOPWPg9drPG5U00iQ+hnEFmoAR33ZUOcPv7beS2+D2sCrURWJgIS3P3?=
 =?us-ascii?Q?cE+bTIc7X3anr+B67XnFcFR6ByP9LnyQbYgOqB7hovTQL1l/86oG2nyIy3OM?=
 =?us-ascii?Q?I6a8L/7AaRm/dxMnfgHoCiTj7HFfvLZkqhlR3h0nvneCeJndJQWqodzJK8Ri?=
 =?us-ascii?Q?T7/W9XucBGFXbMzNetjBb5nUuwjhMsBAYruys/8iRoVze8yKR6xzCqD78X/5?=
 =?us-ascii?Q?+7kjw3V2YdVVZIijFaaO4LQaEdozfa3RreX0qnEHIfqSkR57DzKmFyIX02UO?=
 =?us-ascii?Q?pikz587uXeRfzNBajLa0JaZXxvUXhKdwL+3hcuzxO150zPUhoTq+EqQ/Xlf7?=
 =?us-ascii?Q?J2rcSANktBuV5pOnNVZDS3waeJHTtG4vYGYEoUAv11gq6aT4vHe1ibct+qMr?=
 =?us-ascii?Q?vaV2pz9M9WEjo+sLr2w6fGuZifhUwsZYl5fiaxFFML00zVZyivxYXU1zhvqi?=
 =?us-ascii?Q?R/V0IWk+AuAs7js6lgYx2ND/ChaFhS7ukcrZ214Durb4+t6+BsXqLN2R723S?=
 =?us-ascii?Q?Oo9gmTBQFm+fs/rcdP8vb6f4o3kmX+7sLcxdyARfOHJoM4m8CNkb5F9qZuSw?=
 =?us-ascii?Q?qywDkDWb2aQ+DcAMUwS/VQvIW+AIFxinl+sRZt0uCpF/MA02S6FnZO2U03ND?=
 =?us-ascii?Q?ev/0kl7pSVMKanZgRWGxH1juShWnf8tTZkfbhkJyextO/wiHevVzUfMPv7bw?=
 =?us-ascii?Q?FHB/OnbYUU+Kw7fD7T/hedRxjSiuGhUCU9+YNydyiGl6paXNV1Vo+/p8B2CX?=
 =?us-ascii?Q?Q0KPlz69fuz3aFuUbhGkshwpnCQooaj4fMyB?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7458.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(42112799006)(38070700021)(7053199007)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bkiUtDE0pWER/adr00xeNrrKaA1Y/GdkfdHl3Cqe+DUE4xFt32w1fkp1+2w4?=
 =?us-ascii?Q?BIYKX15NNOw0/0AE+yVlzdpfIWIMK6CTZkqFAGwB66/SMAe+GVYEM6NX+nBS?=
 =?us-ascii?Q?E1FP64A2t8dv2Vy/1/2HOmhvtdDmplKkNrXezCrMuFHFkU8WTv8edqMRhaQR?=
 =?us-ascii?Q?3wYN5PjBUjua35ekvmerEk4/c9VRqjufr3fvk/MWQDuJdjH09y9gHrMoexPl?=
 =?us-ascii?Q?d2al/WGkW7MgahoAI4Oq7WbImfcsWruaF5vbzO3vTgxg4Q8T2Y6IX3KmmXbt?=
 =?us-ascii?Q?pmyCuftOtinQlFmjHpFxDWVtgq6R1bFXGwx3RtMeqESc8kq4oNbJqlp+afqQ?=
 =?us-ascii?Q?1g8cSNIg01cBjn/zjtdXaV22N5NWLTSum0VBl3qmMBDKK+oLDUct6QB5gssz?=
 =?us-ascii?Q?PqIZDE5Cb+IPJR8ZPR70UsyUCH2hEM92JfM6rhPr20bgkdVdeTIIFhuh6Of7?=
 =?us-ascii?Q?QO3UVaxJbfEHfy0mbTMPN7nnq9VABSz+ACBWKtoiOy8tHvYYOmu6Ex4mqXyk?=
 =?us-ascii?Q?TjegARWoGOlwYo681dmSAJTfRFp1ue6LvpF3LDiiIOG4ziQylXrWIMZ7cae0?=
 =?us-ascii?Q?sUhFd9pC2hPVP/DwU8WQTAGOIfEuZZRoAxuZktJSvVCFp40jRGjsdOzsbwEt?=
 =?us-ascii?Q?2c2ZuTm8UXNF0AP9uI3B5oAY4n5hELSPitlf4a+JTaH4n1mxdhUJjl7NyaPu?=
 =?us-ascii?Q?9Ll83nz1pyjRGp9RjwVynzYt5ac9AJimDKu/hzAyF0S2lP/RecZH4cBVbL5y?=
 =?us-ascii?Q?8ZtDq4M0Yue6HhnFtRnaWIEireZotvXrrwl2Ypy/Afq0Zatln5n9Eu7NW8dE?=
 =?us-ascii?Q?suDgnONEmfvfur4xVQqqe1zNj9AdHNv/d3/dj6Ap8HfMlL5wPnYsior90rNb?=
 =?us-ascii?Q?FQgJ1KLOFGQkJa5FWCBSglbUWbqSHezDJCBHBsoocPYbP5ybMGDSoPoO7KL8?=
 =?us-ascii?Q?Qr0yELCPTzO/SBQ624diVbEFCkKsKlY/FLxdza9ssfZw7wUhBcaPWbWJcv74?=
 =?us-ascii?Q?yg93zjQlkp82TLTXTM+fbWSV2L4WVpvcvx844oqTyo40mHMoLjHYvL7q0p3M?=
 =?us-ascii?Q?C8O9GXdF/2023bIbhLEHqGuBDu9Lf8SfPddyubAqJW9+pKK5uHk346wBVBpy?=
 =?us-ascii?Q?XiuxkT308POiEr7NSuJF2uoeFsN2VWyE35cn82MUuzj0o0a6kj0xiIZnIFrn?=
 =?us-ascii?Q?RPAgGdPM2Kuu4r4NTXLhBBi6mZG3sNhIpch+JjDT1CtGS6e60hpukYFEMzed?=
 =?us-ascii?Q?Iu2fRFCW8R7Yti+iF7jQC9cZ9WdjlXMOgRa7k+JdEmXvO45IDaUYQ0FK7D/5?=
 =?us-ascii?Q?ODyFhxNtuXeu4q0L/Cjp/cmf8UGmTXW0CnP12/UC1VL0zwpluRIfsYr0081f?=
 =?us-ascii?Q?owvCcKWUglA3tdVFxL8AKRsBh6WBtHJzgvO21SEXAXl8yTCWzM1gZBBvHSUW?=
 =?us-ascii?Q?rIHEcBLnRFqZiWEhcx0S9FqlduIY+taJGiko27mmMdbqj+pFUNRgvutiI72T?=
 =?us-ascii?Q?gd9UCWrjGf+rnRpYeI3NNGLsJyiuAk69pIt7yFWXFzWyRscxfWxfCOusHlUX?=
 =?us-ascii?Q?kO2bk/IspXloz1YbLM0=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DS0PR11MB74589FB5F44DE9D4A0349BBC81E6ADS0PR11MB7458namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7458.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9957b8ca-45d4-4756-cf3c-08de00d9ee61
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2025 11:01:53.9686 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hbJ7rjE8yFMe99LvBrMl11sT/mx/DmhiapxmBPqgAMYHbMhBmfJazbBgH8Bq69BDhXk/jDXIblwk/fLQUXWXNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6499
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

--_000_DS0PR11MB74589FB5F44DE9D4A0349BBC81E6ADS0PR11MB7458namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Series-acked-by: Kai Ji <kai.ji@intel.com>

________________________________
From: Nicolau, Radu <radu.nicolau@intel.com>
Sent: 11 September 2025 14:14
To: dev@dpdk.org <dev@dpdk.org>
Cc: Nicolau, Radu <radu.nicolau@intel.com>; Ji, Kai <kai.ji@intel.com>; De =
Lara Guarch, Pablo <pablo.de.lara.guarch@intel.com>
Subject: [PATCH v2 1/3] crypto/ipsec_mb: improve CPU code path

Improve CPU code path with support for OOP and various small fixes.

Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
---
 drivers/crypto/ipsec_mb/pmd_aesni_mb.c | 124 +++++++++++++++++--------
 1 file changed, 86 insertions(+), 38 deletions(-)

diff --git a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c b/drivers/crypto/ipsec_=
mb/pmd_aesni_mb.c
index a6c3f09b6f..356e6cd4a0 100644
--- a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
+++ b/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
@@ -975,14 +975,24 @@ aesni_mb_set_docsis_sec_session_parameters(
         return ret;
 }

+static inline uint8_t *get_src_buf(struct rte_crypto_op *op)
+{
+       return op->sym->m_src ?
+       rte_pktmbuf_mtod(op->sym->m_src, uint8_t *) : NULL;
+}
+static inline uint8_t *get_dst_buf(struct rte_crypto_op *op)
+{
+       return op->sym->m_dst ?
+       rte_pktmbuf_mtod(op->sym->m_dst, uint8_t *) : NULL;
+}
+
 static inline uint64_t
-auth_start_offset(struct rte_crypto_op *op, struct aesni_mb_session *sessi=
on,
+auth_start_offset(uint8_t *p_src, uint8_t *p_dst,
+               struct aesni_mb_session *session,
                 uint32_t oop, const uint32_t auth_offset,
                 const uint32_t cipher_offset, const uint32_t auth_length,
                 const uint32_t cipher_length, uint8_t lb_sgl)
 {
-       struct rte_mbuf *m_src, *m_dst;
-       uint8_t *p_src, *p_dst;
         uintptr_t u_src, u_dst;
         uint32_t cipher_end, auth_end;

@@ -990,11 +1000,6 @@ auth_start_offset(struct rte_crypto_op *op, struct ae=
sni_mb_session *session,
         if (!oop || session->template_job.chain_order !=3D IMB_ORDER_CIPHE=
R_HASH || lb_sgl)
                 return auth_offset;

-       m_src =3D op->sym->m_src;
-       m_dst =3D op->sym->m_dst;
-
-       p_src =3D rte_pktmbuf_mtod(m_src, uint8_t *);
-       p_dst =3D rte_pktmbuf_mtod(m_dst, uint8_t *);
         u_src =3D (uintptr_t)p_src;
         u_dst =3D (uintptr_t)p_dst + auth_offset;

@@ -1029,9 +1034,11 @@ auth_start_offset(struct rte_crypto_op *op, struct a=
esni_mb_session *session,

 static inline void
 set_cpu_mb_job_params(IMB_JOB *job, struct aesni_mb_session *session,
-               union rte_crypto_sym_ofs sofs, void *buf, uint32_t len,
-               struct rte_crypto_va_iova_ptr *iv,
-               struct rte_crypto_va_iova_ptr *aad, void *digest, void *uda=
ta)
+               union rte_crypto_sym_ofs sofs, void *src_buf, void *dst_buf=
,
+               uint32_t len, struct rte_crypto_va_iova_ptr *iv,
+               struct rte_crypto_va_iova_ptr *aad,
+               void **digest, struct rte_crypto_va_iova_ptr *vec_digest,
+               void *udata)
 {
         memcpy(job, &session->template_job, sizeof(IMB_JOB));

@@ -1065,10 +1072,7 @@ set_cpu_mb_job_params(IMB_JOB *job, struct aesni_mb_=
session *session,
 #endif

         default:
-               job->u.HMAC._hashed_auth_key_xor_ipad =3D
-                               session->auth.pads.inner;
-               job->u.HMAC._hashed_auth_key_xor_opad =3D
-                               session->auth.pads.outer;
+               break;
         }

         /*
@@ -1076,20 +1080,48 @@ set_cpu_mb_job_params(IMB_JOB *job, struct aesni_mb=
_session *session,
          * digest length as specified in the relevant IPsec RFCs
          */

-       /* Set digest location and length */
-       job->auth_tag_output =3D digest;
-
         /* Data Parameters */
-       job->src =3D buf;
-       job->dst =3D (uint8_t *)buf + sofs.ofs.cipher.head;
+       job->src =3D src_buf;
+       if (dst_buf)
+               job->dst =3D (uint8_t *)dst_buf + sofs.ofs.cipher.head;
+       else
+               job->dst =3D (uint8_t *)src_buf + sofs.ofs.cipher.head;
         job->cipher_start_src_offset_in_bytes =3D sofs.ofs.cipher.head;
-       job->hash_start_src_offset_in_bytes =3D sofs.ofs.auth.head;
         job->msg_len_to_hash_in_bytes =3D len - sofs.ofs.auth.head -
                 sofs.ofs.auth.tail;
         job->msg_len_to_cipher_in_bytes =3D len - sofs.ofs.cipher.head -
                 sofs.ofs.cipher.tail;
+       job->hash_start_src_offset_in_bytes =3D auth_start_offset(
+                               src_buf, dst_buf,
+                               session, dst_buf !=3D NULL,
+                               sofs.ofs.auth.head,
+                               sofs.ofs.cipher.head,
+                               job->msg_len_to_hash_in_bytes,
+                               job->msg_len_to_cipher_in_bytes, 0);

         job->user_data =3D udata;
+
+       /** Check if conditions are met for digest-appended operations */
+       if (job->cipher_mode !=3D IMB_CIPHER_NULL && job->chain_order =3D=
=3D IMB_ORDER_HASH_CIPHER) {
+               uintptr_t end_cipher, start_cipher;
+               if (dst_buf =3D=3D NULL) {
+                       end_cipher =3D (uintptr_t)src_buf + job->msg_len_to=
_cipher_in_bytes;
+                       start_cipher =3D (uintptr_t)src_buf;
+               } else {
+                       end_cipher =3D (uintptr_t)dst_buf + job->msg_len_to=
_cipher_in_bytes;
+                       start_cipher =3D (uintptr_t)dst_buf;
+               }
+               if (start_cipher < (uintptr_t)vec_digest->va &&
+                       (uintptr_t)vec_digest->va < end_cipher)
+                       *digest =3D (void *)((uintptr_t)src_buf + job->msg_=
len_to_hash_in_bytes);
+       }
+       job->auth_tag_output =3D *digest;
+
+       if (job->cipher_mode =3D=3D IMB_CIPHER_NULL && dst_buf) {
+               memcpy(job->dst + job->cipher_start_src_offset_in_bytes,
+                       job->src + job->cipher_start_src_offset_in_bytes,
+                       job->msg_len_to_cipher_in_bytes);
+       }
 }

 static int
@@ -1693,7 +1725,8 @@ set_mb_job_params(IMB_JOB *job, struct ipsec_mb_qp *q=
p,
                 auth_len_in_bytes =3D op->sym->auth.data.length >> 3;
                 ciph_len_in_bytes =3D op->sym->cipher.data.length >> 3;

-               job->hash_start_src_offset_in_bytes =3D auth_start_offset(o=
p,
+               job->hash_start_src_offset_in_bytes =3D auth_start_offset(
+                               get_src_buf(op), get_dst_buf(op),
                                 session, oop, auth_off_in_bytes,
                                 ciph_off_in_bytes, auth_len_in_bytes,
                                 ciph_len_in_bytes, lb_sgl);
@@ -1710,7 +1743,8 @@ set_mb_job_params(IMB_JOB *job, struct ipsec_mb_qp *q=
p,
                 auth_len_in_bytes =3D op->sym->auth.data.length >> 3;
                 ciph_len_in_bytes =3D op->sym->cipher.data.length >> 3;

-               job->hash_start_src_offset_in_bytes =3D auth_start_offset(o=
p,
+               job->hash_start_src_offset_in_bytes =3D auth_start_offset(
+                               get_src_buf(op), get_dst_buf(op),
                                 session, oop, auth_off_in_bytes,
                                 ciph_off_in_bytes, auth_len_in_bytes,
                                 ciph_len_in_bytes, lb_sgl);
@@ -1735,7 +1769,8 @@ set_mb_job_params(IMB_JOB *job, struct ipsec_mb_qp *q=
p,
 #endif

         default:
-               job->hash_start_src_offset_in_bytes =3D auth_start_offset(o=
p,
+               job->hash_start_src_offset_in_bytes =3D auth_start_offset(
+                               get_src_buf(op), get_dst_buf(op),
                                 session, oop, op->sym->auth.data.offset,
                                 op->sym->cipher.data.offset,
                                 op->sym->auth.data.length,
@@ -2261,12 +2296,16 @@ aesni_mb_dequeue_burst(void *queue_pair, struct rte=
_crypto_op **ops,
 }

 static inline int
-check_crypto_sgl(union rte_crypto_sym_ofs so, const struct rte_crypto_sgl =
*sgl)
+check_crypto_sgl(union rte_crypto_sym_ofs so,
+       const struct rte_crypto_sym_vec *vec, uint32_t idx)
 {
+       const struct rte_crypto_sgl *sgl_src =3D vec->src_sgl + idx;
+       const struct rte_crypto_sgl *sgl_dst =3D vec->dest_sgl ?
+               vec->dest_sgl + idx : NULL;
         /* no multi-seg support with current AESNI-MB PMD */
-       if (sgl->num !=3D 1)
+       if (sgl_src->num !=3D 1 || (sgl_dst && sgl_dst->num !=3D 1))
                 return -ENOTSUP;
-       else if (so.ofs.cipher.head + so.ofs.cipher.tail > sgl->vec[0].len)
+       else if (so.ofs.cipher.head + so.ofs.cipher.tail > sgl_src->vec[0].=
len)
                 return -EINVAL;
         return 0;
 }
@@ -2275,7 +2314,11 @@ static inline IMB_JOB *
 submit_sync_job(IMB_MGR *mb_mgr)
 {
 #ifdef RTE_LIBRTE_PMD_AESNI_MB_DEBUG
-       return IMB_SUBMIT_JOB(mb_mgr);
+       IMB_JOB *job =3D IMB_SUBMIT_JOB(mb_mgr);
+       int err =3D imb_get_errno(mb_mgr);
+       if (err)
+               IPSEC_MB_LOG(ERR, "%s", imb_get_strerror(err));
+       return job;
 #else
         return IMB_SUBMIT_JOB_NOCHECK(mb_mgr);
 #endif
@@ -2283,7 +2326,7 @@ submit_sync_job(IMB_MGR *mb_mgr)

 static inline uint32_t
 generate_sync_dgst(struct rte_crypto_sym_vec *vec,
-       const uint8_t dgst[][DIGEST_LENGTH_MAX], uint32_t len)
+       uint8_t *dgst[], uint32_t len)
 {
         uint32_t i, k;

@@ -2299,7 +2342,7 @@ generate_sync_dgst(struct rte_crypto_sym_vec *vec,

 static inline uint32_t
 verify_sync_dgst(struct rte_crypto_sym_vec *vec,
-       const uint8_t dgst[][DIGEST_LENGTH_MAX], uint32_t len)
+       uint8_t *dgst[], uint32_t len)
 {
         uint32_t i, k;

@@ -2322,11 +2365,12 @@ aesni_mb_process_bulk(struct rte_cryptodev *dev __r=
te_unused,
 {
         int32_t ret;
         uint32_t i, j, k, len;
-       void *buf;
+       void *src_buf, *dst_buf =3D NULL;
         IMB_JOB *job;
         IMB_MGR *mb_mgr;
         struct aesni_mb_session *s =3D CRYPTODEV_GET_SYM_SESS_PRIV(sess);
         uint8_t tmp_dgst[vec->num][DIGEST_LENGTH_MAX];
+       uint8_t *tmp_dgst_ptr[vec->num];

         /* get per-thread MB MGR, create one if needed */
         mb_mgr =3D get_per_thread_mb_mgr();
@@ -2334,13 +2378,15 @@ aesni_mb_process_bulk(struct rte_cryptodev *dev __r=
te_unused,
                 return 0;

         for (i =3D 0, j =3D 0, k =3D 0; i !=3D vec->num; i++) {
-               ret =3D check_crypto_sgl(sofs, vec->src_sgl + i);
+               ret =3D check_crypto_sgl(sofs, vec, i);
                 if (ret !=3D 0) {
                         vec->status[i] =3D ret;
                         continue;
                 }

-               buf =3D vec->src_sgl[i].vec[0].base;
+               src_buf =3D vec->src_sgl[i].vec[0].base;
+               if (vec->dest_sgl !=3D NULL && vec->dest_sgl[i].vec[0].base=
 !=3D NULL)
+                       dst_buf =3D vec->dest_sgl[i].vec[0].base;
                 len =3D vec->src_sgl[i].vec[0].len;

                 job =3D IMB_GET_NEXT_JOB(mb_mgr);
@@ -2351,8 +2397,10 @@ aesni_mb_process_bulk(struct rte_cryptodev *dev __rt=
e_unused,
                 }

                 /* Submit job for processing */
-               set_cpu_mb_job_params(job, s, sofs, buf, len, &vec->iv[i],
-                       &vec->aad[i], tmp_dgst[i], &vec->status[i]);
+               tmp_dgst_ptr[i] =3D tmp_dgst[i];
+               set_cpu_mb_job_params(job, s, sofs, src_buf, dst_buf, len, =
&vec->iv[i],
+                       &vec->aad[i], (void **)&tmp_dgst_ptr[i], &vec->dige=
st[i],
+                       &vec->status[i]);
                 job =3D submit_sync_job(mb_mgr);
                 j++;

@@ -2365,14 +2413,14 @@ aesni_mb_process_bulk(struct rte_cryptodev *dev __r=
te_unused,
                 k +=3D flush_mb_sync_mgr(mb_mgr);

         /* finish processing for successful jobs: check/update digest */
-       if (k !=3D 0) {
+       if (k !=3D 0 && s->template_job.hash_alg !=3D IMB_AUTH_NULL) {
                 if (s->auth.operation =3D=3D RTE_CRYPTO_AUTH_OP_VERIFY)
                         k =3D verify_sync_dgst(vec,
-                               (const uint8_t (*)[DIGEST_LENGTH_MAX])tmp_d=
gst,
+                               tmp_dgst_ptr,
                                 s->auth.req_digest_len);
                 else
                         k =3D generate_sync_dgst(vec,
-                               (const uint8_t (*)[DIGEST_LENGTH_MAX])tmp_d=
gst,
+                               tmp_dgst_ptr,
                                 s->auth.req_digest_len);
         }

--
2.50.1


--_000_DS0PR11MB74589FB5F44DE9D4A0349BBC81E6ADS0PR11MB7458namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
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
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Nicolau, Radu &lt;rad=
u.nicolau@intel.com&gt;<br>
<b>Sent:</b> 11 September 2025 14:14<br>
<b>To:</b> dev@dpdk.org &lt;dev@dpdk.org&gt;<br>
<b>Cc:</b> Nicolau, Radu &lt;radu.nicolau@intel.com&gt;; Ji, Kai &lt;kai.ji=
@intel.com&gt;; De Lara Guarch, Pablo &lt;pablo.de.lara.guarch@intel.com&gt=
;<br>
<b>Subject:</b> [PATCH v2 1/3] crypto/ipsec_mb: improve CPU code path</font=
>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Improve CPU code path with support for OOP and var=
ious small fixes.<br>
<br>
Signed-off-by: Radu Nicolau &lt;radu.nicolau@intel.com&gt;<br>
---<br>
&nbsp;drivers/crypto/ipsec_mb/pmd_aesni_mb.c | 124 +++++++++++++++++-------=
-<br>
&nbsp;1 file changed, 86 insertions(+), 38 deletions(-)<br>
<br>
diff --git a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c b/drivers/crypto/ipsec_=
mb/pmd_aesni_mb.c<br>
index a6c3f09b6f..356e6cd4a0 100644<br>
--- a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c<br>
+++ b/drivers/crypto/ipsec_mb/pmd_aesni_mb.c<br>
@@ -975,14 +975,24 @@ aesni_mb_set_docsis_sec_session_parameters(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
+static inline uint8_t *get_src_buf(struct rte_crypto_op *op)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return op-&gt;sym-&gt;m_src ?<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rte_pktmbuf_mtod(op-&gt;sym-&gt;m_src=
, uint8_t *) : NULL;<br>
+}<br>
+static inline uint8_t *get_dst_buf(struct rte_crypto_op *op)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return op-&gt;sym-&gt;m_dst ?<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rte_pktmbuf_mtod(op-&gt;sym-&gt;m_dst=
, uint8_t *) : NULL;<br>
+}<br>
+<br>
&nbsp;static inline uint64_t<br>
-auth_start_offset(struct rte_crypto_op *op, struct aesni_mb_session *sessi=
on,<br>
+auth_start_offset(uint8_t *p_src, uint8_t *p_dst,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct aesni_mb_session *session,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; uint32_t oop, const uint32_t auth_offset,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; const uint32_t cipher_offset, const uint32_t auth_len=
gth,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; const uint32_t cipher_length, uint8_t lb_sgl)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_mbuf *m_src, *m_dst;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t *p_src, *p_dst;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uintptr_t u_src, u_dst;<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t cipher_end, auth_=
end;<br>
&nbsp;<br>
@@ -990,11 +1000,6 @@ auth_start_offset(struct rte_crypto_op *op, struct ae=
sni_mb_session *session,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!oop || session-&gt;te=
mplate_job.chain_order !=3D IMB_ORDER_CIPHER_HASH || lb_sgl)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return auth_offset;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m_src =3D op-&gt;sym-&gt;m_src;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m_dst =3D op-&gt;sym-&gt;m_dst;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p_src =3D rte_pktmbuf_mtod(m_src, uin=
t8_t *);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p_dst =3D rte_pktmbuf_mtod(m_dst, uin=
t8_t *);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u_src =3D (uintptr_t)p_src=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u_dst =3D (uintptr_t)p_dst=
 + auth_offset;<br>
&nbsp;<br>
@@ -1029,9 +1034,11 @@ auth_start_offset(struct rte_crypto_op *op, struct a=
esni_mb_session *session,<br>
&nbsp;<br>
&nbsp;static inline void<br>
&nbsp;set_cpu_mb_job_params(IMB_JOB *job, struct aesni_mb_session *session,=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; union rte_crypto_sym_ofs sofs, void *buf, uint32_t len,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct rte_crypto_va_iova_ptr *iv,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct rte_crypto_va_iova_ptr *aad, void *digest, void *udata)<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; union rte_crypto_sym_ofs sofs, void *src_buf, void *dst_buf,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint32_t len, struct rte_crypto_va_iova_ptr *iv,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct rte_crypto_va_iova_ptr *aad,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; void **digest, struct rte_crypto_va_iova_ptr *vec_digest,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; void *udata)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(job, &amp;session-&=
gt;template_job, sizeof(IMB_JOB));<br>
&nbsp;<br>
@@ -1065,10 +1072,7 @@ set_cpu_mb_job_params(IMB_JOB *job, struct aesni_mb_=
session *session,<br>
&nbsp;#endif<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; job-&gt;u.HMAC._hashed_auth_key_xor_ipad =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; session-&gt;auth.pads.inner;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; job-&gt;u.HMAC._hashed_auth_key_xor_opad =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; session-&gt;auth.pads.outer;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
@@ -1076,20 +1080,48 @@ set_cpu_mb_job_params(IMB_JOB *job, struct aesni_mb=
_session *session,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * digest length as s=
pecified in the relevant IPsec RFCs<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Set digest location and length */<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job-&gt;auth_tag_output =3D digest;<b=
r>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Data Parameters */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job-&gt;src =3D buf;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job-&gt;dst =3D (uint8_t *)buf + sofs=
.ofs.cipher.head;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job-&gt;src =3D src_buf;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dst_buf)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; job-&gt;dst =3D (uint8_t *)dst_buf + sofs.ofs.cipher.head;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; job-&gt;dst =3D (uint8_t *)src_buf + sofs.ofs.cipher.head;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job-&gt;cipher_start_src_o=
ffset_in_bytes =3D sofs.ofs.cipher.head;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job-&gt;hash_start_src_offset_in_byte=
s =3D sofs.ofs.auth.head;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job-&gt;msg_len_to_hash_in=
_bytes =3D len - sofs.ofs.auth.head -<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; sofs.ofs.auth.tail;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job-&gt;msg_len_to_cipher_=
in_bytes =3D len - sofs.ofs.cipher.head -<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; sofs.ofs.cipher.tail;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job-&gt;hash_start_src_offset_in_byte=
s =3D auth_start_offset(<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; src_buf, dst_buf,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; session, dst_buf !=3D NULL,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sofs.ofs.auth.head,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sofs.ofs.cipher.head,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job-&gt;msg_len_to_hash_in_bytes,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job-&gt;msg_len_to_cipher_in_bytes, 0);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job-&gt;user_data =3D udat=
a;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /** Check if conditions are met for d=
igest-appended operations */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (job-&gt;cipher_mode !=3D IMB_CIPH=
ER_NULL &amp;&amp; job-&gt;chain_order =3D=3D IMB_ORDER_HASH_CIPHER) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uintptr_t end_cipher, start_cipher;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (dst_buf =3D=3D NULL) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; end_cipher =3D (=
uintptr_t)src_buf + job-&gt;msg_len_to_cipher_in_bytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; start_cipher =3D=
 (uintptr_t)src_buf;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; end_cipher =3D (=
uintptr_t)dst_buf + job-&gt;msg_len_to_cipher_in_bytes;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; start_cipher =3D=
 (uintptr_t)dst_buf;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (start_cipher &lt; (uintptr_t)vec_digest-&gt;va &amp;&amp;<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (uintptr_t)vec_d=
igest-&gt;va &lt; end_cipher)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *digest =3D (voi=
d *)((uintptr_t)src_buf + job-&gt;msg_len_to_hash_in_bytes);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job-&gt;auth_tag_output =3D *digest;<=
br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (job-&gt;cipher_mode =3D=3D IMB_CI=
PHER_NULL &amp;&amp; dst_buf) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; memcpy(job-&gt;dst + job-&gt;cipher_start_src_offset_in_bytes,<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job-&gt;src + jo=
b-&gt;cipher_start_src_offset_in_bytes,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job-&gt;msg_len_=
to_cipher_in_bytes);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int<br>
@@ -1693,7 +1725,8 @@ set_mb_job_params(IMB_JOB *job, struct ipsec_mb_qp *q=
p,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; auth_len_in_bytes =3D op-&gt;sym-&gt;auth.data.length=
 &gt;&gt; 3;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ciph_len_in_bytes =3D op-&gt;sym-&gt;cipher.data.leng=
th &gt;&gt; 3;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; job-&gt;hash_start_src_offset_in_bytes =3D auth_start_offset(op,=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; job-&gt;hash_start_src_offset_in_bytes =3D auth_start_offset(<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; get_src_buf(op), get_dst_buf(op),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; session, oop, auth_off_in_bytes,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ciph_off_in_bytes, auth_len_in_b=
ytes,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ciph_len_in_bytes, lb_sgl);<br>
@@ -1710,7 +1743,8 @@ set_mb_job_params(IMB_JOB *job, struct ipsec_mb_qp *q=
p,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; auth_len_in_bytes =3D op-&gt;sym-&gt;auth.data.length=
 &gt;&gt; 3;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ciph_len_in_bytes =3D op-&gt;sym-&gt;cipher.data.leng=
th &gt;&gt; 3;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; job-&gt;hash_start_src_offset_in_bytes =3D auth_start_offset(op,=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; job-&gt;hash_start_src_offset_in_bytes =3D auth_start_offset(<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; get_src_buf(op), get_dst_buf(op),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; session, oop, auth_off_in_bytes,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ciph_off_in_bytes, auth_len_in_b=
ytes,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ciph_len_in_bytes, lb_sgl);<br>
@@ -1735,7 +1769,8 @@ set_mb_job_params(IMB_JOB *job, struct ipsec_mb_qp *q=
p,<br>
&nbsp;#endif<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; job-&gt;hash_start_src_offset_in_bytes =3D auth_start_offset(op,=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; job-&gt;hash_start_src_offset_in_bytes =3D auth_start_offset(<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; get_src_buf(op), get_dst_buf(op),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; session, oop, op-&gt;sym-&gt;aut=
h.data.offset,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; op-&gt;sym-&gt;cipher.data.offse=
t,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; op-&gt;sym-&gt;auth.data.length,=
<br>
@@ -2261,12 +2296,16 @@ aesni_mb_dequeue_burst(void *queue_pair, struct rte=
_crypto_op **ops,<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static inline int<br>
-check_crypto_sgl(union rte_crypto_sym_ofs so, const struct rte_crypto_sgl =
*sgl)<br>
+check_crypto_sgl(union rte_crypto_sym_ofs so,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct rte_crypto_sym_vec *vec,=
 uint32_t idx)<br>
&nbsp;{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct rte_crypto_sgl *sgl_src =
=3D vec-&gt;src_sgl + idx;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct rte_crypto_sgl *sgl_dst =
=3D vec-&gt;dest_sgl ?<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vec-&gt;dest_sgl + idx : NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* no multi-seg support wi=
th current AESNI-MB PMD */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (sgl-&gt;num !=3D 1)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (sgl_src-&gt;num !=3D 1 || (sgl_ds=
t &amp;&amp; sgl_dst-&gt;num !=3D 1))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -ENOTSUP;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (so.ofs.cipher.head + so.ofs.=
cipher.tail &gt; sgl-&gt;vec[0].len)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (so.ofs.cipher.head + so.ofs.=
cipher.tail &gt; sgl_src-&gt;vec[0].len)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
@@ -2275,7 +2314,11 @@ static inline IMB_JOB *<br>
&nbsp;submit_sync_job(IMB_MGR *mb_mgr)<br>
&nbsp;{<br>
&nbsp;#ifdef RTE_LIBRTE_PMD_AESNI_MB_DEBUG<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return IMB_SUBMIT_JOB(mb_mgr);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IMB_JOB *job =3D IMB_SUBMIT_JOB(mb_mg=
r);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int err =3D imb_get_errno(mb_mgr);<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (err)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; IPSEC_MB_LOG(ERR, &quot;%s&quot;, imb_get_strerror(err));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return job;<br>
&nbsp;#else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return IMB_SUBMIT_JOB_NOCH=
ECK(mb_mgr);<br>
&nbsp;#endif<br>
@@ -2283,7 +2326,7 @@ submit_sync_job(IMB_MGR *mb_mgr)<br>
&nbsp;<br>
&nbsp;static inline uint32_t<br>
&nbsp;generate_sync_dgst(struct rte_crypto_sym_vec *vec,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const uint8_t dgst[][DIGEST_LENGTH_MA=
X], uint32_t len)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t *dgst[], uint32_t len)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i, k;<br>
&nbsp;<br>
@@ -2299,7 +2342,7 @@ generate_sync_dgst(struct rte_crypto_sym_vec *vec,<br=
>
&nbsp;<br>
&nbsp;static inline uint32_t<br>
&nbsp;verify_sync_dgst(struct rte_crypto_sym_vec *vec,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const uint8_t dgst[][DIGEST_LENGTH_MA=
X], uint32_t len)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t *dgst[], uint32_t len)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i, k;<br>
&nbsp;<br>
@@ -2322,11 +2365,12 @@ aesni_mb_process_bulk(struct rte_cryptodev *dev __r=
te_unused,<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int32_t ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i, j, k, len;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *buf;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *src_buf, *dst_buf =3D NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IMB_JOB *job;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IMB_MGR *mb_mgr;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aesni_mb_session *s=
 =3D CRYPTODEV_GET_SYM_SESS_PRIV(sess);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t tmp_dgst[vec-&gt;n=
um][DIGEST_LENGTH_MAX];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t *tmp_dgst_ptr[vec-&gt;num];<b=
r>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* get per-thread MB MGR, =
create one if needed */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mb_mgr =3D get_per_thread_=
mb_mgr();<br>
@@ -2334,13 +2378,15 @@ aesni_mb_process_bulk(struct rte_cryptodev *dev __r=
te_unused,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0, j =3D 0, k =
=3D 0; i !=3D vec-&gt;num; i++) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D check_crypto_sgl(sofs, vec-&gt;src_sgl + i);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D check_crypto_sgl(sofs, vec, i);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ret !=3D 0) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vec-&=
gt;status[i] =3D ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conti=
nue;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; buf =3D vec-&gt;src_sgl[i].vec[0].base;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; src_buf =3D vec-&gt;src_sgl[i].vec[0].base;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (vec-&gt;dest_sgl !=3D NULL &amp;&amp; vec-&gt;dest_sgl[i].ve=
c[0].base !=3D NULL)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst_buf =3D vec-=
&gt;dest_sgl[i].vec[0].base;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; len =3D vec-&gt;src_sgl[i].vec[0].len;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; job =3D IMB_GET_NEXT_JOB(mb_mgr);<br>
@@ -2351,8 +2397,10 @@ aesni_mb_process_bulk(struct rte_cryptodev *dev __rt=
e_unused,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* Submit job for processing */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; set_cpu_mb_job_params(job, s, sofs, buf, len, &amp;vec-&gt;iv[i]=
,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;vec-&gt;aad=
[i], tmp_dgst[i], &amp;vec-&gt;status[i]);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; tmp_dgst_ptr[i] =3D tmp_dgst[i];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; set_cpu_mb_job_params(job, s, sofs, src_buf, dst_buf, len, &amp;=
vec-&gt;iv[i],<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;vec-&gt;aad=
[i], (void **)&amp;tmp_dgst_ptr[i], &amp;vec-&gt;digest[i],<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;vec-&gt;sta=
tus[i]);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; job =3D submit_sync_job(mb_mgr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; j++;<br>
&nbsp;<br>
@@ -2365,14 +2413,14 @@ aesni_mb_process_bulk(struct rte_cryptodev *dev __r=
te_unused,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; k +=3D flush_mb_sync_mgr(mb_mgr);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* finish processing for s=
uccessful jobs: check/update digest */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (k !=3D 0) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (k !=3D 0 &amp;&amp; s-&gt;templat=
e_job.hash_alg !=3D IMB_AUTH_NULL) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (s-&gt;auth.operation =3D=3D RTE_CRYPTO_AUTH_OP_VE=
RIFY)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; k =3D=
 verify_sync_dgst(vec,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (const uint8_t (*)[DIGEST_LENGTH_MAX])tmp_d=
gst,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp_dgst_ptr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;auth.req_digest_len);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; k =3D=
 generate_sync_dgst(vec,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (const uint8_t (*)[DIGEST_LENGTH_MAX])tmp_d=
gst,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp_dgst_ptr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;auth.req_digest_len);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-- <br>
2.50.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_DS0PR11MB74589FB5F44DE9D4A0349BBC81E6ADS0PR11MB7458namp_--
