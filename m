Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6151BFC5928
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 10:32:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A5FE5402BB;
	Thu, 26 Feb 2026 11:32:34 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 7A2304021F
 for <dev@dpdk.org>; Thu, 26 Feb 2026 11:32:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772101953; x=1803637953;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=YKS6by41dCZeo0HsG58br1DhIbxaNPVU4TYq9D74vp8=;
 b=NXL/OlOBpKUfZF8fPRCQCLf7YawmIsZm9DppFlETLMvoJq/5SEmPZnZK
 t8Xc7ioL/KZ8x7ZoW3vyGpjGqllM/U+1iRP3Jepglx0uMnpGvQcW4EM3S
 7yi5W0U1SSFPx2L1HeS7n5pl8+mkMWB22o4xwgEIjBBfLGbAf164yyrAn
 cN81yCLrZab6EVa+irYABlrOJGnJe6uY/702EuWWmWh1o4EYEc+gQAHUn
 q4j6IZS2kKC8IL4k/iw6UdolvgNplBFqlKnL+M68uw6Iq6ihfKCqTFNRU
 zG83abedzSfXGSehFuoCmsbBZieRcysNNioHs+cYtL/nlihD1mF37Mr/1 w==;
X-CSE-ConnectionGUID: qoSjcmIGQsW5jK9aheG6oA==
X-CSE-MsgGUID: TiN0eBIHRnuothCnsSHXmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="84253120"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="84253120"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 02:32:32 -0800
X-CSE-ConnectionGUID: t5GxkZTLQTaGPkcZMf6opg==
X-CSE-MsgGUID: u4u8PQB7RmWyjELbz/r/3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="215637110"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 02:32:32 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Feb 2026 02:32:30 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 26 Feb 2026 02:32:30 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.20) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Feb 2026 02:32:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i7x3Uedi2OiVLD9ndd0f+FjpP9Bh1engl0oYdhDSoayggsBsEU9RUVXekVaxBZr/qdPCnh3N9ibGZwuczwNN9k9HL8OOgJPJlToUw6HpCqjNQto0ZR7mF0ifKc8ygYGvDzkqIQhWthwForVNYjxB5MvqxQkFeB2VGC1PXiRtWZnluG4oo2Un9kVCntA7lsawMrXXqhWxK2CIa3QFF8Kyq/th9xmEsGbuHSTsZmNYoTRggzMAhxNd7S0TJGbQ8syMxG/TSk0NtyIvoZl6i4MOP6REAnQHi/sAtZmixzDd7KaaMS/+gEb72GIUl6AycC71xGg8hkokdo4CTLZAAjejyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wj3IapipWvOgkpJ0qyTN9+YhB0xMvEvzBpJ+/JM8sEM=;
 b=q+CEzdAhs/TGfRiIgIQhyWElceU/gXXEyx/YtLo89YehbECxv8pYAVI4KTkH8ddLDVxnSVKXuexVIQVc7qCkrwB52c+PolX8+B88mP/DgOF+w/zVLGA2QJHBZgEFbypNFVRlTtoqn1wiiEYxsOkYy12LdkZ93ukmfyYPTXkOcFH9qFT4i/tW7qZH5lKDMOH5JFYq+wPMEFE5nnJ6lSOZAKNDP/KXr3KW5tLRxz9JDFds9ygFeDVTUPJOm4HcCrzWs2cthUg3ckMzODkFtLuZhVs4OylUi621mbEZJ86dgup/VYTs3LlWbYlrHPMjoYsL3vxw5KMB/Z4oYBQRYk/jvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7563.namprd11.prod.outlook.com (2603:10b6:510:286::11)
 by PH7PR11MB6956.namprd11.prod.outlook.com (2603:10b6:510:207::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Thu, 26 Feb
 2026 10:32:22 +0000
Received: from PH0PR11MB7563.namprd11.prod.outlook.com
 ([fe80::b1d9:cd5f:9d12:e954]) by PH0PR11MB7563.namprd11.prod.outlook.com
 ([fe80::b1d9:cd5f:9d12:e954%4]) with mapi id 15.20.9654.007; Thu, 26 Feb 2026
 10:32:21 +0000
From: "Kumar, Rajesh3" <rajesh3.kumar@intel.com>
To: "Hore, Soumyadeep" <soumyadeep.hore@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>, "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "Singh, Aman Deep" <aman.deep.singh@intel.com>, "Subbarao, Manoj Kumar"
 <manoj.kumar.subbarao@intel.com>
Subject: RE: [PATCH v6 3/4] net/idpf: add timesync support
Thread-Topic: [PATCH v6 3/4] net/idpf: add timesync support
Thread-Index: AQHcnYFEbaG+kuYvG0WLaB8xTvahvbWU2zYA
Date: Thu, 26 Feb 2026 10:32:21 +0000
Message-ID: <PH0PR11MB7563915A16F780E943CDA447B572A@PH0PR11MB7563.namprd11.prod.outlook.com>
References: <20260123000449.188008-3-soumyadeep.hore@intel.com>
 <20260214194920.139066-1-soumyadeep.hore@intel.com>
 <20260214194920.139066-4-soumyadeep.hore@intel.com>
In-Reply-To: <20260214194920.139066-4-soumyadeep.hore@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7563:EE_|PH7PR11MB6956:EE_
x-ms-office365-filtering-correlation-id: 82cce5f2-c907-4c94-2b31-08de75225335
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: +pcUOkIyxd1QEjk7uue6kc80MYt/EDYfzAQpdXRM46bQRqS//c0cYNNuAZj8eIlt/vm5qEDROKEHZRhxwf3RfUXudJKn83DrV9tU5B4gd9O4QBlCDyhKzhLjO7dAcasC9h3YRviPXOHumWfblm1Km7M916evanGxcKNZAogcI6ADSB5a7de0bDU4Fd98/JRHtNkz94k3HQb+n4bhyGnpgITaMPDUdp5AE2hdC+J2zBZGSyI2Ab8GAZ7kDKoCmTfNBQukahD5voCG+yYHt/e9nilVBsOb5pTxoGeJxngUq8lKlxuAejlM3CfE/UTetFhmkFhyHXBTJREyfakFAF+DEXEc/IuIXnHpkFFzhpAo+1I5HsdG/glIf1VH4f99rh2cpCHzchxuz+zzd5p85nttzNbbGHLKPhwgsN+eK9PLkuvecwa3wWSk1ZxTgoRlUdhjHR+MSD+EHX6NqlRpKxNsoeJDuzAP6RuYrNToms3WXqF7wwZB8oybIPAn4NUV184BXNgTl/pzmnJcEOwubH/iUHxpN6BLdwvgUuF0nps0yUY1TbYLrDtvWudqnTyYe0MLoaQENTegWPmUYr7WUQiTc1bm6Q9hPsTg7LaKW6dcLhg8NLgi6apwlCTTKgxiLwDI343gUonpDxEZVAMXuRg7drFQ468a8xc/qktjzCju5A/Rf8TJXU8Epu1pFgYWiTtrCM0zlZckZOpGwntfiYVKOUkibegR8yimWWlr8ECi4tRkFmRuI/PDRi+bc+JPRGm89E5Oevj7uZvIxBJL0Iv8cWvTWZLDFIwPF/5TAWYDrvw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7563.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?U0FesGReg22kst/c7NRvCqT0g2A9UYiSgga4fP4i5wModoK50uGxEpEbbUtF?=
 =?us-ascii?Q?tgnJFG2d3wAXTY3Tdr5kRtZX90JzcqMOMuDE2iZXYPPnMhpMSNOxw2GhOgHd?=
 =?us-ascii?Q?A6+LtLsS/73jTkhJztdPONX6i9Mw44v0LU+eEN0VZEfiAtDLjtbvXU4hS6DB?=
 =?us-ascii?Q?TipWF9ojqE9g0apDncL1J5tn91ITjm5IyYl22ROZjm2QfYcBGX0FBZEI/2do?=
 =?us-ascii?Q?41XFRzJTv0OjQAKaHKUPlOBt81pNaXueYRLYX5lUpD05jdT3xwxzv5GDxcXb?=
 =?us-ascii?Q?Cuhl0Jq9Un+VeX9ziS3AYPznavkTI6JGb0yLYwiqegmR1BJi/acBernC3DNQ?=
 =?us-ascii?Q?n79cRhLIU4Z+KKQ/tYsFF+W5O+2EwDf1FojcOMOT7KNjOuzrqR5OsmRWFjfM?=
 =?us-ascii?Q?NJyRZj386/ZROAlbINrb0TMONa+OocPPwEh+kcTc8pAY29Fk2MQKgyDnHg+t?=
 =?us-ascii?Q?yGpoA6CAR4J9qTBuCRuj0v2YZB61TNbWEgaQy+/P1ug5PMCnkpyo0b3KbyNb?=
 =?us-ascii?Q?+X+Tay4WSwxBbvQsjNntz9Cawsas0XL0X0JQyi1T1dsvX52nOnlzobwtg1rU?=
 =?us-ascii?Q?56kuED+qXaP2HY30WFTkI2+udLAHTDyIvEyyE1QHHHxGpKn6KiThunZvM0BE?=
 =?us-ascii?Q?dEu+++MxTKAiVR+qJxXEPplhJH1jVB2WbXQDuAKwzNBxoWPiLfaD1fbb4bwN?=
 =?us-ascii?Q?kuRz5rUTDhXuFm/sX/ATk0viuUKt1Ausu42QGanG2nmtCaFIdWaAIU0OsAGV?=
 =?us-ascii?Q?nH4ezs2VYVCKXHTpacVZLWcXGSirBvWUkSn8eVZw3iAitHB7IbfBqd/+pujA?=
 =?us-ascii?Q?DeWeenFRVs5z3TNihI1p1sRIZ8VUo7RPLSwLMtZ+fFW9Ub35DaXxy2GOTtNf?=
 =?us-ascii?Q?r5nge8Sl0hdVj9najjGGi4L9Vk0GVQZoITdCn6C2Yy3covi4fergQ21GPUkk?=
 =?us-ascii?Q?C9ZTDPYoSosjVXGHuwCdLhCo+bZcjWD1AJFKr2dFj3wwDwaKdU6zYuzDTfxv?=
 =?us-ascii?Q?LvK+gRUjV4xYt4SsryDwuCItb/gsIj5BJgml71lX9OEIW9D3DpR3YnxZQSyp?=
 =?us-ascii?Q?D02ungY1HV75s6nkoqv0PSIJy1l/ntjLC4t/V0B/QNol9fmfjqID8s6Fe43Y?=
 =?us-ascii?Q?uXdSx57j2RpWMAie2hqkcsCu5EvieWmLAJc0eOZFo4lKtDN1VGjo8/ZHNSqo?=
 =?us-ascii?Q?yBcMFXXxPuxJGxVpejY0+GYImtghFnoatXzAUDdICz3oi10QkH4S688voR7/?=
 =?us-ascii?Q?c5MOmohiLdfoNitpQmRCMZ0i65HRA7QPqnsN+LQzMqgHO03n3pDDn2tzSbTb?=
 =?us-ascii?Q?u0LGda9fWC6xXjQ+Yg1f+vUFtT/I95dwB6msUcc0WRwTM7Cbr2s97+0aLGGS?=
 =?us-ascii?Q?tIUTnXNXvVQ2KjHnu9NZSj/QXbntQ8rnhADjT3ZLFH4bO77yWjdALGGM3wn3?=
 =?us-ascii?Q?7X5UYSvi0jFDojmku7U5Z2KCYm1dswVXQOptlAZvRnO81tcFlnUVEV1t0Moz?=
 =?us-ascii?Q?L7WPj2bsFkWSZrx0V3Z87LUttaKXxPRDWd3LJthA0i2s1cCT5CSobsVrFMLq?=
 =?us-ascii?Q?wuoXCJZN1IQHJeYJ15oKj7mPhzJZpS76lzLhbRMpKUp2IXHBdvPtJwkam6Co?=
 =?us-ascii?Q?0r5fusPjhL60tzIehRxPzOpBteGjgTWYcWXjwfKsGF0OlMlo/oXSpMkORQUu?=
 =?us-ascii?Q?q/hdFqiy0EaBKXtCfAFlbzXRIvgwsygPL/29ds3U7o47UL9U0wUgBmQJyfx5?=
 =?us-ascii?Q?h0i68ZL7yg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7563.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82cce5f2-c907-4c94-2b31-08de75225335
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2026 10:32:21.8247 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EW4AvtiZsRisW8iR5lQWsNsDTpxS03u0Ak8PzR2oP3U8y01r6W3A1HaAy7wj/rqB296hEunYqUpAx9qFOSMAwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6956
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

Acked-by: Rajesh Kumar <rajesh3.kumar@intel.com>

-----Original Message-----
From: Hore, Soumyadeep <soumyadeep.hore@intel.com>=20
Sent: 15 February 2026 01:19 AM
To: dev@dpdk.org; Richardson, Bruce <bruce.richardson@intel.com>
Cc: Kumar, Rajesh3 <rajesh3.kumar@intel.com>; Singh, Aman Deep <aman.deep.s=
ingh@intel.com>; Subbarao, Manoj Kumar <manoj.kumar.subbarao@intel.com>
Subject: [PATCH v6 3/4] net/idpf: add timesync support

Add timesync support including:
- Capability negotiation with the Control Plane to determine supported PTP =
features.
- Get/set/adjust operations on the main device clock.
- Tx timestamping support using a PTP-dedicated secondary mailbox.

Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
---
 drivers/net/intel/common/tx.h             |   1 +
 drivers/net/intel/idpf/idpf_common_rxtx.c | 121 +++++-----
 drivers/net/intel/idpf/idpf_common_rxtx.h |   7 +
 drivers/net/intel/idpf/idpf_ethdev.c      | 270 ++++++++++++++++++++++
 4 files changed, 338 insertions(+), 61 deletions(-)

diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h =
index e295d83e3a..dc964f3dd1 100644
--- a/drivers/net/intel/common/tx.h
+++ b/drivers/net/intel/common/tx.h
@@ -115,6 +115,7 @@ struct ci_tx_queue {
 				struct ci_tx_queue *complq;
 				void **txqs;   /*only valid for split queue mode*/
 				uint32_t tx_start_qid;
+				uint32_t latch_idx; /* Tx timestamp latch index */
 				uint16_t sw_nb_desc;
 				uint16_t sw_tail;
 				uint16_t rs_compl_count;
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.c b/drivers/net/intel/=
idpf/idpf_common_rxtx.c
index 797ee515dd..11c9dfc4fc 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.c
@@ -9,6 +9,7 @@
 #include "idpf_common_rxtx.h"
 #include "idpf_common_device.h"
 #include "../common/rx.h"
+#include "idpf_ptp.h"
=20
 int idpf_timestamp_dynfield_offset =3D -1;  uint64_t idpf_timestamp_dynfla=
g; @@ -435,58 +436,6 @@ idpf_qc_split_rxq_mbufs_alloc(struct idpf_rx_queue =
*rxq)
 	return 0;
 }
=20
-#define IDPF_TIMESYNC_REG_WRAP_GUARD_BAND  10000
-/* Helper function to convert a 32b nanoseconds timestamp to 64b. */ -stat=
ic inline uint64_t -idpf_tstamp_convert_32b_64b(struct idpf_adapter *ad, ui=
nt32_t flag,
-			    uint32_t in_timestamp)
-{
-#ifdef RTE_ARCH_X86_64
-	struct idpf_hw *hw =3D &ad->hw;
-	const uint64_t mask =3D 0xFFFFFFFF;
-	uint32_t hi, lo, lo2, delta;
-	uint64_t ns;
-
-	if (flag !=3D 0) {
-		IDPF_WRITE_REG(hw, GLTSYN_CMD_SYNC_0_0, PF_GLTSYN_CMD_SYNC_SHTIME_EN_M);
-		IDPF_WRITE_REG(hw, GLTSYN_CMD_SYNC_0_0, PF_GLTSYN_CMD_SYNC_EXEC_CMD_M |
-			       PF_GLTSYN_CMD_SYNC_SHTIME_EN_M);
-		lo =3D IDPF_READ_REG(hw, PF_GLTSYN_SHTIME_L_0);
-		hi =3D IDPF_READ_REG(hw, PF_GLTSYN_SHTIME_H_0);
-		/*
-		 * On typical system, the delta between lo and lo2 is ~1000ns,
-		 * so 10000 seems a large-enough but not overly-big guard band.
-		 */
-		if (lo > (UINT32_MAX - IDPF_TIMESYNC_REG_WRAP_GUARD_BAND))
-			lo2 =3D IDPF_READ_REG(hw, PF_GLTSYN_SHTIME_L_0);
-		else
-			lo2 =3D lo;
-
-		if (lo2 < lo) {
-			lo =3D IDPF_READ_REG(hw, PF_GLTSYN_SHTIME_L_0);
-			hi =3D IDPF_READ_REG(hw, PF_GLTSYN_SHTIME_H_0);
-		}
-
-		ad->time_hw =3D ((uint64_t)hi << 32) | lo;
-	}
-
-	delta =3D (in_timestamp - (uint32_t)(ad->time_hw & mask));
-	if (delta > (mask / 2)) {
-		delta =3D ((uint32_t)(ad->time_hw & mask) - in_timestamp);
-		ns =3D ad->time_hw - delta;
-	} else {
-		ns =3D ad->time_hw + delta;
-	}
-
-	return ns;
-#else /* !RTE_ARCH_X86_64 */
-	RTE_SET_USED(ad);
-	RTE_SET_USED(flag);
-	RTE_SET_USED(in_timestamp);
-	return 0;
-#endif /* RTE_ARCH_X86_64 */
-}
-
 #define IDPF_RX_FLEX_DESC_ADV_STATUS0_XSUM_S				\
 	(RTE_BIT32(VIRTCHNL2_RX_FLEX_DESC_ADV_STATUS0_XSUM_IPE_S) |     \
 	 RTE_BIT32(VIRTCHNL2_RX_FLEX_DESC_ADV_STATUS0_XSUM_L4E_S) |     \
@@ -732,20 +681,27 @@ idpf_dp_splitq_recv_pkts(void *rx_queue, struct rte_m=
buf **rx_pkts,
 			ptype_tbl[(rte_le_to_cpu_16(rx_desc->ptype_err_fflags0) &
 				   VIRTCHNL2_RX_FLEX_DESC_ADV_PTYPE_M) >>
 				  VIRTCHNL2_RX_FLEX_DESC_ADV_PTYPE_S];
+
+		if ((rxm->packet_type & RTE_PTYPE_L2_MASK) =3D=3D RTE_PTYPE_L2_ETHER_TIM=
ESYNC)
+			rxm->ol_flags |=3D RTE_MBUF_F_RX_IEEE1588_PTP;
+
 		status_err0_qw1 =3D rte_le_to_cpu_16(rx_desc->status_err0_qw1);
 		pkt_flags =3D idpf_splitq_rx_csum_offload(status_err0_qw1);
 		pkt_flags |=3D idpf_splitq_rx_rss_offload(rxm, rx_desc);
 		if (idpf_timestamp_dynflag > 0 &&
 		    (rxq->offloads & IDPF_RX_OFFLOAD_TIMESTAMP)) {
 			/* timestamp */
+			rxq->time_high =3D rte_le_to_cpu_32(rx_desc->ts_high);
 			ts_ns =3D idpf_tstamp_convert_32b_64b(ad,
-							    rxq->hw_register_set,
-							    rte_le_to_cpu_32(rx_desc->ts_high));
+							    rxq->hw_register_set, true,
+							    rxq->time_high);
 			rxq->hw_register_set =3D 0;
 			*RTE_MBUF_DYNFIELD(rxm,
 					   idpf_timestamp_dynfield_offset,
 					   rte_mbuf_timestamp_t *) =3D ts_ns;
 			first_seg->ol_flags |=3D idpf_timestamp_dynflag;
+			if (rx_desc->ts_low & VIRTCHNL2_RX_FLEX_TSTAMP_VALID)
+				rxm->ol_flags |=3D RTE_MBUF_F_RX_IEEE1588_TMST;
 		}
=20
 		first_seg->ol_flags |=3D pkt_flags;
@@ -839,10 +795,34 @@ idpf_split_tx_free(struct ci_tx_queue *cq)  static in=
line uint16_t  idpf_calc_context_desc(uint64_t flags)  {
-	if ((flags & RTE_MBUF_F_TX_TCP_SEG) !=3D 0)
-		return 1;
+	static uint64_t mask =3D RTE_MBUF_F_TX_TCP_SEG |
+		RTE_MBUF_F_TX_IEEE1588_TMST;
=20
-	return 0;
+	return (flags & mask) ? 1 : 0;
+}
+
+/**
+ * idpf_tx_set_tstamp_desc - Set the Tx descriptor fields needed to genera=
te
+ *			     PHY Tx timestamp
+ * @ctx_desc: Context descriptor
+ * @idx: Index of the Tx timestamp latch  */ static inline void=20
+idpf_tx_set_tstamp_desc(volatile union idpf_flex_tx_ctx_desc *ctx_desc,
+				uint32_t idx)
+{
+	ctx_desc->tsyn.qw1.cmd_dtype =3D
+		rte_cpu_to_le_16(FIELD_PREP(IDPF_TXD_QW1_CMD_M,
+				       IDPF_TX_CTX_DESC_TSYN));
+	ctx_desc->tsyn.qw1.cmd_dtype |=3D
+		rte_cpu_to_le_16(FIELD_PREP(IDPF_TXD_QW1_DTYPE_M,
+				       IDPF_TX_DESC_DTYPE_CTX));
+	ctx_desc->tsyn.qw1.tsyn_reg_l =3D
+		rte_cpu_to_le_16(FIELD_PREP(IDPF_TX_DESC_CTX_TSYN_L_M,
+				       idx));
+	ctx_desc->tsyn.qw1.tsyn_reg_h =3D
+		rte_cpu_to_le_16(FIELD_PREP(IDPF_TX_DESC_CTX_TSYN_H_M,
+				       idx >> 2));
 }
=20
 /* set TSO context descriptor
@@ -948,6 +928,9 @@ idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbu=
f **tx_pkts,
 				idpf_set_splitq_tso_ctx(tx_pkt, tx_offload,
 							ctx_desc);
=20
+			if ((ol_flags & RTE_MBUF_F_TX_IEEE1588_TMST) !=3D 0)
+				idpf_tx_set_tstamp_desc(ctx_desc, txq->latch_idx);
+
 			tx_id++;
 			if (tx_id =3D=3D txq->nb_tx_desc)
 				tx_id =3D 0;
@@ -1167,17 +1150,22 @@ idpf_dp_singleq_recv_pkts(void *rx_queue, struct rt=
e_mbuf **rx_pkts,
=20
 		rxm->ol_flags |=3D pkt_flags;
=20
+		if ((rxm->packet_type & RTE_PTYPE_L2_MASK) =3D=3D RTE_PTYPE_L2_ETHER_TIM=
ESYNC)
+			rxm->ol_flags |=3D RTE_MBUF_F_RX_IEEE1588_PTP;
+
 		if (idpf_timestamp_dynflag > 0 &&
 		    (rxq->offloads & IDPF_RX_OFFLOAD_TIMESTAMP) !=3D 0) {
 			/* timestamp */
+			rxq->time_high =3D rte_le_to_cpu_32(rxd.flex_nic_wb.flex_ts.ts_high);
 			ts_ns =3D idpf_tstamp_convert_32b_64b(ad,
-					    rxq->hw_register_set,
-					    rte_le_to_cpu_32(rxd.flex_nic_wb.flex_ts.ts_high));
+					    rxq->hw_register_set, true,
+					    rxq->time_high);
 			rxq->hw_register_set =3D 0;
 			*RTE_MBUF_DYNFIELD(rxm,
 					   idpf_timestamp_dynfield_offset,
 					   rte_mbuf_timestamp_t *) =3D ts_ns;
 			rxm->ol_flags |=3D idpf_timestamp_dynflag;
+			rxm->ol_flags |=3D RTE_MBUF_F_RX_IEEE1588_TMST;
 		}
=20
 		rx_pkts[nb_rx++] =3D rxm;
@@ -1218,6 +1206,9 @@ idpf_dp_singleq_recv_scatter_pkts(void *rx_queue, str=
uct rte_mbuf **rx_pkts,
 	if (unlikely(!rxq) || unlikely(!rxq->q_started))
 		return nb_rx;
=20
+	if ((rxq->offloads & IDPF_RX_OFFLOAD_TIMESTAMP) !=3D 0)
+		rxq->hw_register_set =3D 1;
+
 	while (nb_rx < nb_pkts) {
 		rxdp =3D &rx_ring[rx_id];
 		rx_status0 =3D rte_le_to_cpu_16(rxdp->flex_nic_wb.status_error0);
@@ -1298,17 +1289,22 @@ idpf_dp_singleq_recv_scatter_pkts(void *rx_queue, s=
truct rte_mbuf **rx_pkts,
 			ptype_tbl[(uint8_t)(rte_cpu_to_le_16(rxd.flex_nic_wb.ptype_flex_flags0)=
 &
 				VIRTCHNL2_RX_FLEX_DESC_PTYPE_M)];
=20
+		if ((first_seg->packet_type & RTE_PTYPE_L2_MASK) =3D=3D RTE_PTYPE_L2_ETH=
ER_TIMESYNC)
+			first_seg->ol_flags |=3D RTE_MBUF_F_RX_IEEE1588_PTP;
+
 		if (idpf_timestamp_dynflag > 0 &&
 		    (rxq->offloads & IDPF_RX_OFFLOAD_TIMESTAMP) !=3D 0) {
 			/* timestamp */
+			rxq->time_high =3D rte_le_to_cpu_32(rxd.flex_nic_wb.flex_ts.ts_high);
 			ts_ns =3D idpf_tstamp_convert_32b_64b(ad,
-				rxq->hw_register_set,
-				rte_le_to_cpu_32(rxd.flex_nic_wb.flex_ts.ts_high));
+				rxq->hw_register_set, true,
+				rxq->time_high);
 			rxq->hw_register_set =3D 0;
 			*RTE_MBUF_DYNFIELD(rxm,
 					   idpf_timestamp_dynfield_offset,
 					   rte_mbuf_timestamp_t *) =3D ts_ns;
 			first_seg->ol_flags |=3D idpf_timestamp_dynflag;
+			first_seg->ol_flags |=3D RTE_MBUF_F_RX_IEEE1588_TMST;
 		}
=20
 		first_seg->ol_flags |=3D pkt_flags;
@@ -1474,6 +1470,9 @@ idpf_dp_singleq_xmit_pkts(void *tx_queue, struct rte_=
mbuf **tx_pkts,
 				idpf_set_splitq_tso_ctx(tx_pkt, tx_offload,
 							ctx_txd);
=20
+			if ((ol_flags & RTE_MBUF_F_TX_IEEE1588_TMST) !=3D 0)
+				idpf_tx_set_tstamp_desc(ctx_txd, txq->latch_idx);
+
 			txe->last_id =3D tx_last;
 			tx_id =3D txe->next_id;
 			txe =3D txn;
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.h b/drivers/net/intel/=
idpf/idpf_common_rxtx.h
index 7c6ff5d047..e1b8904181 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.h
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.h
@@ -13,6 +13,12 @@
 #include "../common/tx.h"
 #include "../common/rx.h"
=20
+#define FIELD_PREP(_mask, _val) \
+	(__extension__ ({ \
+		typeof(_mask) _x =3D (_mask); \
+		((typeof(_x))(_val) << rte_bsf32(_x)) & (_x); \
+	}))
+
 #define IDPF_RX_MAX_BURST		32
=20
 #define IDPF_RX_OFFLOAD_IPV4_CKSUM		RTE_BIT64(1)
@@ -167,6 +173,7 @@ struct idpf_rx_queue {
=20
 	uint64_t offloads;
 	uint32_t hw_register_set;
+	uint32_t time_high; /* high 32 bits of hardware timestamp register */
 };
=20
 /* Offload features */
diff --git a/drivers/net/intel/idpf/idpf_ethdev.c b/drivers/net/intel/idpf/=
idpf_ethdev.c
index 5d786fbba6..5e57a45775 100644
--- a/drivers/net/intel/idpf/idpf_ethdev.c
+++ b/drivers/net/intel/idpf/idpf_ethdev.c
@@ -14,6 +14,7 @@
 #include "idpf_ethdev.h"
 #include "idpf_rxtx.h"
 #include "../common/tx.h"
+#include "idpf_ptp.h"
=20
 #define IDPF_TX_SINGLE_Q	"tx_single"
 #define IDPF_RX_SINGLE_Q	"rx_single"
@@ -841,6 +842,267 @@ idpf_dev_close(struct rte_eth_dev *dev)
 	return 0;
 }
=20
+static int
+idpf_timesync_enable(struct rte_eth_dev *dev) {
+	struct idpf_vport *vport =3D dev->data->dev_private;
+	struct idpf_adapter *adapter =3D vport->adapter;
+	struct timespec sys_ts;
+	uint64_t ns;
+	int ret, q_id;
+	if (dev->data->dev_started && !(dev->data->dev_conf.rxmode.offloads &
+		RTE_ETH_RX_OFFLOAD_TIMESTAMP)) {
+		PMD_DRV_LOG(ERR, "Rx timestamp offload not configured");
+		return -1;
+	}
+
+	adapter->ptp =3D rte_zmalloc(NULL, sizeof(struct idpf_ptp), 0);
+	if (adapter->ptp =3D=3D NULL) {
+		PMD_DRV_LOG(ERR, "Failed to allocate memory for PTP");
+		return -ENOMEM;
+	}
+
+	ret =3D idpf_ptp_get_caps(adapter);
+	if (ret) {
+		PMD_DRV_LOG(ERR, "Failed to get PTP capabilities, err=3D%d", ret);
+		goto fail_ptp;
+	}
+
+	/* Write the default increment time value if the clock adjustments are en=
abled. */
+	if (adapter->ptp->adj_dev_clk_time_access !=3D IDPF_PTP_NONE) {
+		ret =3D idpf_ptp_adj_dev_clk_fine(adapter, adapter->ptp->base_incval);
+		if (ret) {
+			PMD_DRV_LOG(ERR, "PTP set incval failed, err=3D%d", ret);
+			goto fail_ptp;
+		}
+	}
+
+	/* Do not initialize the PTP if the device clock time cannot be read. */
+	if (adapter->ptp->get_dev_clk_time_access =3D=3D IDPF_PTP_NONE) {
+		PMD_DRV_LOG(ERR, "Getting device clock time is not supported");
+		ret =3D -EIO;
+		goto fail_ptp;
+	}
+
+	/* Set the device clock time to system time. */
+	if (adapter->ptp->set_dev_clk_time_access !=3D IDPF_PTP_NONE) {
+		clock_gettime(CLOCK_REALTIME, &sys_ts);
+		ns =3D rte_timespec_to_ns(&sys_ts);
+		ret =3D idpf_ptp_set_dev_clk_time(adapter, ns);
+		if (ret) {
+			PMD_DRV_LOG(ERR, "PTP set clock time failed, err=3D%d", ret);
+			goto fail_ptp;
+		}
+	}
+
+	ret =3D idpf_ptp_get_vport_tstamps_caps(vport);
+	if (ret) {
+		PMD_DRV_LOG(ERR, "Failed to get vport timestamp capabilities, err=3D%d",=
 ret);
+		goto fail_ptp;
+	}
+
+	for (q_id =3D 0; q_id < dev->data->nb_tx_queues; q_id++) {
+		struct ci_tx_queue *txq =3D dev->data->tx_queues[q_id];
+		txq->latch_idx =3D vport->tx_tstamp_caps->tx_tstamp[q_id].idx;
+	}
+
+	adapter->ptp->cmd.shtime_enable_mask =3D PF_GLTSYN_CMD_SYNC_SHTIME_EN_M;
+	adapter->ptp->cmd.exec_cmd_mask =3D PF_GLTSYN_CMD_SYNC_EXEC_CMD_M;
+
+	return 0;
+
+fail_ptp:
+	rte_free(adapter->ptp);
+	adapter->ptp =3D NULL;
+	return ret;
+}
+
+static int
+idpf_timesync_read_rx_timestamp(struct rte_eth_dev *dev,
+						struct timespec *timestamp,
+						uint32_t flags)
+{
+	struct idpf_rx_queue *rxq;
+	struct idpf_vport *vport =3D dev->data->dev_private;
+	struct idpf_adapter *adapter =3D vport->adapter;
+	uint64_t ts_ns;
+
+	rxq =3D dev->data->rx_queues[flags];
+
+	ts_ns =3D idpf_tstamp_convert_32b_64b(adapter, 1, true, rxq->time_high);
+	*timestamp =3D rte_ns_to_timespec(ts_ns);
+
+	return 0;
+}
+
+static int
+idpf_timesync_read_tx_timestamp(struct rte_eth_dev *dev,
+						struct timespec *timestamp)
+{
+	struct idpf_vport *vport =3D dev->data->dev_private;
+	uint16_t latch_idx;
+	uint64_t ts_ns, tstamp;
+	int ret;
+
+	ret =3D idpf_ptp_get_tx_tstamp(vport);
+	if (ret) {
+		PMD_DRV_LOG(ERR, "Failed to get TX timestamp");
+		return ret;
+	}
+
+	latch_idx =3D vport->tx_tstamp_caps->latched_idx;
+	tstamp =3D vport->tx_tstamp_caps->tx_tstamp[latch_idx].tstamp;
+	ts_ns =3D idpf_tstamp_convert_32b_64b(vport->adapter, 0, false, tstamp);
+
+	/* Convert to timespec */
+	*timestamp =3D rte_ns_to_timespec(ts_ns);
+
+	vport->tx_tstamp_caps->latched_idx =3D -1;
+
+	return 0;
+}
+
+static int
+idpf_timesync_adjust_time(struct rte_eth_dev *dev, int64_t delta) {
+	struct idpf_vport *vport =3D dev->data->dev_private;
+	struct idpf_adapter *adapter =3D vport->adapter;
+	struct idpf_ptp *ptp =3D adapter->ptp;
+	uint64_t time, ns;
+	int ret;
+
+	if (ptp->adj_dev_clk_time_access !=3D IDPF_PTP_MAILBOX) {
+		PMD_DRV_LOG(ERR, "Adjusting device clock time is not supported");
+		return -ENOTSUP;
+	}
+
+	if (delta > INT32_MAX || delta < INT32_MIN) {
+		ret =3D idpf_ptp_read_src_clk_reg(adapter, &time);
+		if (ret) {
+			PMD_DRV_LOG(ERR, "PTP read clock time failed, err %d", ret);
+			return ret;
+		}
+
+		ns =3D time + delta;
+
+		ret =3D idpf_ptp_set_dev_clk_time(adapter, ns);
+		if (ret)
+			PMD_DRV_LOG(ERR, "PTP set clock time failed, err %d", ret);
+
+		return ret;
+	}
+
+	ret =3D idpf_ptp_adj_dev_clk_time(adapter, delta);
+	if (ret)
+		PMD_DRV_LOG(ERR, "PTP adjusting clock failed, err %d", ret);
+
+	return ret;
+}
+
+static int
+idpf_timesync_adjust_freq(struct rte_eth_dev *dev, int64_t ppm) {
+	struct idpf_vport *vport =3D dev->data->dev_private;
+	struct idpf_adapter *adapter =3D vport->adapter;
+	struct idpf_ptp *ptp =3D adapter->ptp;
+	int64_t incval, diff =3D 0;
+	bool negative =3D false;
+	uint64_t div, rem;
+	uint64_t divisor =3D 1000000ULL << 16;
+	int shift;
+	int ret;
+
+	incval =3D ptp->base_incval;
+
+	if (ppm < 0) {
+		negative =3D true;
+		ppm =3D -ppm;
+	}
+
+	/* can incval * ppm overflow ? */
+	if (rte_log2_u64(incval) + rte_log2_u64(ppm) > 62) {
+		rem =3D ppm % divisor;
+		div =3D ppm / divisor;
+		diff =3D div * incval;
+		ppm =3D rem;
+
+		shift =3D rte_log2_u64(incval) + rte_log2_u64(ppm) - 62;
+		if (shift > 0) {
+			/* drop precision */
+			ppm >>=3D shift;
+			divisor >>=3D shift;
+		}
+	}
+
+	if (divisor)
+		diff =3D diff + incval * ppm / divisor;
+
+	if (negative)
+		incval -=3D diff;
+	else
+		incval +=3D diff;
+
+	ret =3D idpf_ptp_adj_dev_clk_fine(adapter, incval);
+	if (ret) {
+		PMD_DRV_LOG(ERR, "PTP failed to set incval, err %d", ret);
+		return ret;
+	}
+	return ret;
+}
+
+static int
+idpf_timesync_write_time(struct rte_eth_dev *dev, const struct timespec=20
+*ts) {
+	struct idpf_vport *vport =3D dev->data->dev_private;
+	struct idpf_adapter *adapter =3D vport->adapter;
+	uint64_t ns;
+	int ret;
+
+	ns =3D rte_timespec_to_ns(ts);
+	ret =3D idpf_ptp_set_dev_clk_time(adapter, ns);
+	if (ret)
+		PMD_DRV_LOG(ERR, "PTP write time failed, err %d", ret);
+
+	return ret;
+}
+
+static int
+idpf_timesync_read_time(struct rte_eth_dev *dev, struct timespec *ts) {
+	struct idpf_vport *vport =3D dev->data->dev_private;
+	struct idpf_adapter *adapter =3D vport->adapter;
+	uint64_t time;
+	int ret;
+
+	ret =3D idpf_ptp_read_src_clk_reg(adapter, &time);
+	if (ret)
+		PMD_DRV_LOG(ERR, "PTP read time failed, err %d", ret);
+	else
+		*ts =3D rte_ns_to_timespec(time);
+
+	return ret;
+}
+
+static int
+idpf_timesync_disable(struct rte_eth_dev *dev) {
+	struct idpf_vport *vport =3D dev->data->dev_private;
+	struct idpf_adapter *adapter =3D vport->adapter;
+
+	if (vport->tx_tstamp_caps) {
+		rte_free(vport->tx_tstamp_caps);
+		vport->tx_tstamp_caps =3D NULL;
+	}
+
+	if (adapter->ptp) {
+		rte_free(adapter->ptp);
+		adapter->ptp =3D NULL;
+	}
+
+	return 0;
+}
+
+
 static const struct eth_dev_ops idpf_eth_dev_ops =3D {
 	.dev_configure			=3D idpf_dev_configure,
 	.dev_close			=3D idpf_dev_close,
@@ -867,6 +1129,14 @@ static const struct eth_dev_ops idpf_eth_dev_ops =3D =
{
 	.xstats_get			=3D idpf_dev_xstats_get,
 	.xstats_get_names		=3D idpf_dev_xstats_get_names,
 	.xstats_reset			=3D idpf_dev_xstats_reset,
+	.timesync_enable              =3D idpf_timesync_enable,
+	.timesync_read_rx_timestamp   =3D idpf_timesync_read_rx_timestamp,
+	.timesync_read_tx_timestamp   =3D idpf_timesync_read_tx_timestamp,
+	.timesync_adjust_time         =3D idpf_timesync_adjust_time,
+	.timesync_adjust_freq         =3D idpf_timesync_adjust_freq,
+	.timesync_read_time           =3D idpf_timesync_read_time,
+	.timesync_write_time          =3D idpf_timesync_write_time,
+	.timesync_disable             =3D idpf_timesync_disable,
 };
=20
 static int
--
2.47.1

