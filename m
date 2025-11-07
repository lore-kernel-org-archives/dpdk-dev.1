Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D9ECCFA05
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 17:10:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 965D140264;
	Fri,  7 Nov 2025 18:10:47 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 9B2DE4021F;
 Fri,  7 Nov 2025 18:10:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762535446; x=1794071446;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=bAoqSDeonvugr6mDhruptZN+yG9rVOeBFl7Mc1s60mQ=;
 b=daPq4CKHs17QhgVPEkNFyVZlh4jm83ZUgr7SHC6EK7F4XHz/aZ8Xugs+
 ZEULdbCQq0nGtYHFnnYWqzOT6i59u6q5VhRvRJgtuD2DgU4ih9lCnrnUY
 9RknbL7VqX0vy+QWeZ1Z9w7hieiFzNi07FAVmm8fYs1MKObErcTE66sBL
 KtlPu8VwaH4mF7SEvFzUyrojRLLUdGOwZWMPl+brEYFT31fQ8B5dfmzSG
 nUOkf0MUDvRorRiMuujtYAZHrVaHPerMTZodMNPyVDR6rhZ5Nv1a7unMy
 wjIqNZjRzOcYBaNVitM0s02NyNOTcmSezsOQcO80k8GEZwcJpQcSe+0vR Q==;
X-CSE-ConnectionGUID: LhZaDiM6TfO8Nr0d1W2dUQ==
X-CSE-MsgGUID: 5vFAkQDdSNeM6SRisvRUkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11606"; a="75800640"
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; d="scan'208";a="75800640"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2025 09:10:45 -0800
X-CSE-ConnectionGUID: LhGubb+ERx2Vj0Hxmp5uIw==
X-CSE-MsgGUID: prY2H4lLRIqNLVB0JLeALw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; d="scan'208";a="187386213"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2025 09:10:44 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 7 Nov 2025 09:10:44 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 7 Nov 2025 09:10:44 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.51) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 7 Nov 2025 09:10:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kpCM5owlEwM7VPneVjNytvb4BPDwiHky8CMbiJ1AzosSWfssfznj82F9D8VokfxytVZfVeHuD9rOyCKgN4Ifn7vwLSaw9RlmLazsX6vKd+zYoM4UNROD89yVI+wSsfC9KtuaHesPWZpV8rdNfpuVUIPWyI575r+5SuCEBk5iat2hP4IvI35pCAo1p14zS12LCCm5gAvYH7NcPFX09ArtRYBcQ2I3W/cjk4HiI/YKnqgVsperD8oJTXLLYcjCVA5CE7UbBnCLGRcx+WYJpIcxzVC7eNdifHj6fPybhxbJcLK+3fwhJuPfn8EL+Sj3Z9YqAhzjp95Ka2sbfc4jES8z7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/F4XSEb5SaBtZETvwCSI/8updZq0U87ylZ5/DzMNKM=;
 b=mf0LI6BigR0m0Iqwir62uuBMrEwpRUbFFrs7LxrGbFXTtlE7cGbXuSCmosdx3wWKlqfxSZsh8vNEdQ+SpSN9sRf7CQwXHjphHBOljEdshZcHJ9YGct9hNNuMS0K12Z40HyrkOadVDcG88Jg0mfKCFDPIgCBO7drVP3qvW5taKFpQPv+w+gaSILMA8D9OFdtj5ncLYDPy1cDLh/1VCiLsgVemmQADpDkWQ5XMPn9Bein0qkPGUo6toyp7zvlH7qzAMuXdf6c70VHgBLOBnffYeBFMGkCoPexwJEPXtZypBi6unUPzH6lTU6fiDBe+4CpxVfM0k9DkdxM2DnoasEYOCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7747.namprd11.prod.outlook.com (2603:10b6:930:91::17)
 by DS7PR11MB8853.namprd11.prod.outlook.com (2603:10b6:8:255::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 17:10:42 +0000
Received: from CY8PR11MB7747.namprd11.prod.outlook.com
 ([fe80::dd94:c5ad:7fd:fd4f]) by CY8PR11MB7747.namprd11.prod.outlook.com
 ([fe80::dd94:c5ad:7fd:fd4f%5]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 17:10:41 +0000
From: "Hore, Soumyadeep" <soumyadeep.hore@intel.com>
To: "Song, Yoong Siang" <yoong.siang.song@intel.com>, "Richardson, Bruce"
 <bruce.richardson@intel.com>, "Zage, David" <david.zage@intel.com>,
 "dev@dpdk.org" <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH v1 1/1] net/e1000: use device timestamp for igc
 read_clock() operation
Thread-Topic: [PATCH v1 1/1] net/e1000: use device timestamp for igc
 read_clock() operation
Thread-Index: AQHcT5KBbxZIn+8kzUa/43ZAsX0/zLTnbayw
Date: Fri, 7 Nov 2025 17:10:41 +0000
Message-ID: <CY8PR11MB7747E4515099613475FE50CCF9C3A@CY8PR11MB7747.namprd11.prod.outlook.com>
References: <20251107031507.3890366-1-yoong.siang.song@intel.com>
In-Reply-To: <20251107031507.3890366-1-yoong.siang.song@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7747:EE_|DS7PR11MB8853:EE_
x-ms-office365-filtering-correlation-id: 371951bd-479b-432f-2f48-08de1e2094e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?EBPlYBDGrMrHH2YKV/VL42uS2e+S/CWnMi4W7JnCHFOw3zHPz4wVAtv3sLxt?=
 =?us-ascii?Q?RsnetgFJRwbhndQdywBFoqI6btCD7Bi3pmhEtT4/Pvx44D/kU7FsJC4XdVTK?=
 =?us-ascii?Q?IL0/5rrmyF7zVZ1AThWlDlsBDWWCUOIyLvWi01dt1Jmq1b0B7/Kll7z6oacw?=
 =?us-ascii?Q?n0R+nclmo+SeCgZ+PNGKVxZ+1h/fmwIiFOjXCAyhGtdv+rwkd3zzI+FinmGM?=
 =?us-ascii?Q?C8H8tyjcFDcxdekkJYyfW6m3bPaY0dqu02RSZM+/OCeLODLktSetz3dwF7Lo?=
 =?us-ascii?Q?nLX4tWzLAS2W9q7KpsX+X74cetzJC+Za7d47GuTcrMYwOh1oTi9Ca0h7yQyd?=
 =?us-ascii?Q?35ee2sNRDjq79P44+yX0IMD4+SGHYMIxCuxcJsDdHbu4KGHnSp3/3I8lVcEW?=
 =?us-ascii?Q?9Aha7Z8yJ+60Xwlvm9O5lOdnLswJQw7xQ3yMaJyp+WcD4y3jtTgYoEeJoObZ?=
 =?us-ascii?Q?KFKmPucLeggVC1sWjm3chbdn7yEnM2Ib9MmqU6OuEjeJj8+hQygtP+m40/6Y?=
 =?us-ascii?Q?nJSv8rxsREMaU+moCb34xOpl5YgA3+hG2M+Cs0JXVALkAn295Kca1Lx+suDD?=
 =?us-ascii?Q?sl4Bx+kBg17Xok83ih5gSHj7/cHQeljvlGYp/0Rr8NqELwnNMofkr7VmUZUn?=
 =?us-ascii?Q?X2jIzszLzIs27cLzeNBsqXuArvAxNyd+g/MAIpLg6ScQ9tGx7WtXnytsNWRm?=
 =?us-ascii?Q?2xJFMnV9uWj/LfLDau1k/J4dGZePHjtUPs+LsMcfWMABPLlCwVUx5jtU1UcH?=
 =?us-ascii?Q?zpTcCUV0drtyePQoLPNOxKNNtWN311qAri2mitaScNFq6iHZbl/w9xAGdaw4?=
 =?us-ascii?Q?yA20K9gSbS4ObDbf7EO/29ASFM8fAsCHXpK89o3Pbv4DxbzaY7WsaTxRHoBx?=
 =?us-ascii?Q?vOjErjy8NMyeiSJJnZPxvi6QPfOPlrje8KVEStRldyuIwLx9jB/dApXjOneX?=
 =?us-ascii?Q?UmVZD6m6QNOobZtbXK58NQMxE48Y48WI5n1telbsoXC1ytEYeYTxW3Stl5sw?=
 =?us-ascii?Q?C4ErPd5Z8RMn8pDwxsTiG6aOHR17iHtLZ9QRp1FVFnneBnZYrWcdy8ApE6X1?=
 =?us-ascii?Q?KrBICEICoynlTnoh+Hqm+bAUC8M3mbgqZ/1XDNMQ7VZi5S2MvcjA7VH8pfjT?=
 =?us-ascii?Q?0ybfqngzz60rmGXzs8Nwc4Ck00oedNf8HNeunl1Oyt6RF3Ax5V4tIF5PeMGg?=
 =?us-ascii?Q?h6If7n5ljjCy5EezhxSAB1ripTaJ5xZDdyjqWrUytAVZHnANH6v3cztaur4h?=
 =?us-ascii?Q?6ia2vIgmecw6p2SlvWUdEX3zG48HWmMlqDwVoyd7uP0f0e/L4RTQjDJFVvgB?=
 =?us-ascii?Q?I8koVn3YmvMa+fbJ5yWczYvs4EHvMTrJXcWNPd7E2s2q7ZaMCKnSgPNBcX3B?=
 =?us-ascii?Q?fyhAqeaODhHgaqBLdka4cWf5FGDrZOEuCB3f4KkPBCoWD5D/tVCs9c9EBqgH?=
 =?us-ascii?Q?8v/bpG1rLzRf05XeK0B8PZ/dYXQE5T6tINiHc41qP7G75nsMF2zoVgFFlhST?=
 =?us-ascii?Q?WzaUuQm+2h5sVloRAiy2Q6H85tV69j0swkpx?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7747.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?n/Qq6Kzlarc/iCo+tSCb/wq8Q8VFv1TzIxu5upramJIWJiZQEjFZ5T+c+IUG?=
 =?us-ascii?Q?Kq/PX9RvnauU7tnxP+FTBODxSUM8ycWLEll1hmd9kZlO2HxVm6y5v7HLSm2c?=
 =?us-ascii?Q?g1L7CNXp+gJgEiPCuZ/TaI9wTS1ddJ2runs4yi9hPKWFFJCxBqfVKu0jHNFz?=
 =?us-ascii?Q?2ki+lOkifGR0QhVFhQ/ubheM/4kSexkjpdgrYxRSO6648GIXL1JALHFxWIUR?=
 =?us-ascii?Q?gM1ADBVf10Zivfyg5xgYxu2KPdlmRw5teGcaMT7yeHWF1vyYs0jBVFPZLatc?=
 =?us-ascii?Q?FpMca37XGsEYYenrazYQJGXpMdVxn+7ynxkXVVVdeJYDd+mj5K8PTRKnnX0v?=
 =?us-ascii?Q?+xIwqqSgkU6ewksmPcfxjjNC0vEHat2Fs5n2IkjYiJ6pGfPOVuqeJ0s76RHw?=
 =?us-ascii?Q?4BRx4gU+JleAxZHgxqfYPYaCMoYm//bujD5+050M2Tr1SreQ2GtUlB71aDAW?=
 =?us-ascii?Q?763wwXzTQeJg1FHgpoElRTTS9FaAagPN6rtTd9Ym0N3cfQPeS2sw0lXWMGRd?=
 =?us-ascii?Q?8r2o7rZYXPYQRw8Hm7/DowB5IOhPABBIiitBxK90A8ICa85P6ZsozI5nvcEL?=
 =?us-ascii?Q?9D5SUfKDWuPwdlJONaGUqVP+EFLE9OXsiXidTMro1l2RORQxa8cUDCMg6lUq?=
 =?us-ascii?Q?Op85VwMJvKkwsJnu7dwChN9poLwUZG4sZ6RZTleoxUi/zkbK/bYMP16WDdG/?=
 =?us-ascii?Q?ykoCZW0cH+MQg3xNR5nnJKcxorr9I45Ip1JHSB+1Y1etljCoz6LRtI1kDwUw?=
 =?us-ascii?Q?i73gvi4YwSqVlyIi9FXqyOPRvkaiuCmo9yubLJrLr0MFoo12lwfvCSZ7blpn?=
 =?us-ascii?Q?tdw9OyFdcZr+HZi5GQNRgALTGRE5oY8hnD8qgSs7WscYnfhOYZnA9ov4a7nG?=
 =?us-ascii?Q?QNhtoRhAIRub59ScWV/LLqsB3g7YQWV3i23DyPal7RWzo9UPGEqn0OS65hXm?=
 =?us-ascii?Q?1sofwHpK+Mtn3QL3lLDFN/TAvN56GgI1fpWtYlfF3UOLJHC7SJphok7XkzyG?=
 =?us-ascii?Q?kGDiJ7x/2+dR6VR7cwNyJl1yy49zjeOX56kGFzejnBDKTKxtBFEkU99w3RXK?=
 =?us-ascii?Q?bpJmBLKwiO0uAIbfYqfdkF9EdGQFtkS27Ie5nRoGPjWHEIG81pdeUAolndUO?=
 =?us-ascii?Q?sRyiXDs9CZnxI297sGxFTJ7yXJRTuAEhdX95dkXifSN9W9Ib8EO6cBovNkWG?=
 =?us-ascii?Q?7sEEzlTWXAhl0mJ48N2/u2VCC8ixLbnvT0U3vYyzHnpd4WDnoRt/J+wT3FOs?=
 =?us-ascii?Q?Xu8W6+QFE2zp99cg1YUbhgCwGQ63D5YbmoTSWxJQQFCraQSRyZI+tmBMS1+4?=
 =?us-ascii?Q?tvjYZp415V3Hpo0Ck3h1ewJL5QD8Zt/CWG6WBHlpH7MC5rGZdcsBbVED0F5I?=
 =?us-ascii?Q?pTq8DfWRw3bcrPYwzr+X+kCfOkUQXl3oxfanSbn4jaGH3SLRNbLNL2UEYqAx?=
 =?us-ascii?Q?Sy9dfxLhAbNG9ke41Kgvk/v6w6028lUsc4X/95vaRuLMTsP3H4rdrmUrFEOs?=
 =?us-ascii?Q?BY2EjwAfqKo4DYhyPmkJBslt19ajP/1Pf9r952X7sYEj96gHC1+C9pnBhG14?=
 =?us-ascii?Q?nBkT/zoIkhPLY6f06PtxZtH9LllK6LUGAAm4T8zf?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7747.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 371951bd-479b-432f-2f48-08de1e2094e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2025 17:10:41.8296 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y1swwgkoziUaJLws8uHd3FadpOS0Zs+iWf/8E2qN9XxdKUCvpgdXllEW5ZqsgywF9tf1e2Fn/Ah3QdkpGJ+ic8Tm/OHVjfzV/ZCNDFD4qPY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB8853
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

Hi Song, on closer inspection I see the code implementation is similar to e=
th_igc_timesync_read_time().

Please reuse the existing code as much as possible.

Change eth_igc_read_clock() to read from hardware timestamp registers
(E1000_SYSTIML/E1000_SYSTIMH) instead of using system clock_gettime().

This ensures that the clock reading is consistent with the hardware's inter=
nal time base used for Qbv cycle and launch time scheduling, providing bett=
er accuracy for Time-Sensitive Networking applications.

Fixes: 9630f7c71ecd ("net/igc: enable launch time offloading")
Cc: stable@dpdk.org

Signed-off-by: David Zage <david.zage@intel.com>
Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
---
 drivers/net/intel/e1000/igc_ethdev.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/intel/e1000/igc_ethdev.c b/drivers/net/intel/e1000=
/igc_ethdev.c
index b9c91d2446..045f7c784d 100644
--- a/drivers/net/intel/e1000/igc_ethdev.c
+++ b/drivers/net/intel/e1000/igc_ethdev.c
@@ -2972,10 +2972,18 @@ eth_igc_timesync_disable(struct rte_eth_dev *dev)  =
static int  eth_igc_read_clock(__rte_unused struct rte_eth_dev *dev, uint64=
_t *clock)  {
-	struct timespec system_time;
+	struct e1000_hw *hw =3D IGC_DEV_PRIVATE_HW(dev);
+	uint32_t nsec, sec;
=20
-	clock_gettime(CLOCK_REALTIME, &system_time);
-	*clock =3D system_time.tv_sec * NSEC_PER_SEC + system_time.tv_nsec;
+	/*
+	 * Reading the SYSTIML register latches the upper 32 bits to the SYSTIMH
+	 * shadow register for coherent access. As long as we read SYSTIML first
+	 * followed by SYSTIMH, we avoid race conditions where the time rolls
+	 * over between the two register reads.
+	 */
+	nsec =3D E1000_READ_REG(hw, E1000_SYSTIML);
+	sec =3D E1000_READ_REG(hw, E1000_SYSTIMH);
+	*clock =3D (uint64_t)sec * NSEC_PER_SEC + (uint64_t)nsec;
=20
 	return 0;
 }
--
2.48.1

