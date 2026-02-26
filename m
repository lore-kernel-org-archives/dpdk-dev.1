Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE3DFC5910
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 10:15:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8E3104021F;
	Thu, 26 Feb 2026 11:15:22 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 0D78C400D6
 for <dev@dpdk.org>; Thu, 26 Feb 2026 11:15:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772100921; x=1803636921;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=a8CN8BvHNY/EJX2XGJ+vLXXU1Cuz8eSlr8wfrrnuAf8=;
 b=oG72Hsn5cwHLdTlxrH7uHSjO4FcqDDVMu/NZMI1hlFQeiHz1UTe8vCx8
 u4FLnKGec6FU2rkxGpLVNOW7ftri1o4pMhnZI90yrXVDyukuYWau7RJr6
 xQco9MZwEOLvRzNsVXLFMwFmcmAbm/fdy/62QSNMahjBF3FzZTJWZHIue
 H+riUi/v4cCwQ2GM3n63v0TBoONeCpWBG2V7L4XBLfGIRAtuOlpxOrlMc
 91ht7phoWuMfinPTuE/SXfAMtol7JGLi5aLiV2LDlOLTInOhbmccSzyAy
 ClKlZfTjlylE1D/VQ4dZ57zuaT0L8imaoGEv/S4WKj2FlbXhqWzN4//IK g==;
X-CSE-ConnectionGUID: PHlDqNRpR8y+r3BqZvEAvw==
X-CSE-MsgGUID: 9h9THl7tRL+Pi9xS028fSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="90739371"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="90739371"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 02:15:18 -0800
X-CSE-ConnectionGUID: 6s/LjoIlRH6oRTu8UOy/Gw==
X-CSE-MsgGUID: i1tfmRL+SD+sOpBQlWFTgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="247059435"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 02:15:19 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Feb 2026 02:15:18 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 26 Feb 2026 02:15:18 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.52) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Feb 2026 02:15:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IHQg9XAn9kqdz/JRa+W6eKB3oDNyZmPulnM4COu+UVux/ecMFnyZMrxZ7p6MF/dgflXborzRXYQ5GYIVGa/yxvzZ6Nq7ELgF/fKp7MZUF9ZdysY2YQ4FaDNQDuzxnQDRVHs33eTR3IpI81/5XsAhNdP/Om5kwkSBIWeEq7I5Bnp3ZZYbv/uu22EZw9D86blRM7GW2lUcWyCeOVyAgyeZgmq4s38VJlbr4vmu2/ynaBGq38nO0pvOkswKmPB0QXzUoUe8l5VscJTgB5o3B7DBiyUNnwRuwVsbFwh44tzPLn6TcmOQJmr0Vqy2H77QcGvklM649oHQBBcet5fA9wzwjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Qr26dj/AqZv2OZ9sVh32sg0c4STBe+DMbTfr8bUsrs=;
 b=xXkl/y3I1Zq51myBLL95HgBwivDPmch+QX2ql48a1Bd2gWoRNaW7Ko2HHKIHQvxSX9U/LZCf6Fy8Kkxyd90O6z5/h3HF/dggs2L1kTKWhtgVSJgcUXBjXb5kmSCN4SfzAqmyPmDY6B4lC28SZq9J6ab3O6/OqiV4Sb8BXDMZc6cdgtpmajGWBzfVFa/92qceHuEXY53+cosSmMMTSQt974EmBy7005W9R5PDX+0glyPxOZnxoiFEJO9l5adDmkpf5n8rQDqt+/czneDp1GBBEKYBDgyPabu/uSQw3yAmcRyTElYc7ZsfY1OG2ydwBhmJPuk0wQhctsf8eVzhugh+DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7563.namprd11.prod.outlook.com (2603:10b6:510:286::11)
 by SJ2PR11MB7518.namprd11.prod.outlook.com (2603:10b6:a03:4c5::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Thu, 26 Feb
 2026 10:15:12 +0000
Received: from PH0PR11MB7563.namprd11.prod.outlook.com
 ([fe80::b1d9:cd5f:9d12:e954]) by PH0PR11MB7563.namprd11.prod.outlook.com
 ([fe80::b1d9:cd5f:9d12:e954%4]) with mapi id 15.20.9654.007; Thu, 26 Feb 2026
 10:15:12 +0000
From: "Kumar, Rajesh3" <rajesh3.kumar@intel.com>
To: "Hore, Soumyadeep" <soumyadeep.hore@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>, "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "Singh, Aman Deep" <aman.deep.singh@intel.com>, "Subbarao, Manoj Kumar"
 <manoj.kumar.subbarao@intel.com>
Subject: RE: [PATCH v6 2/4] net/idpf: add PTP virtchnl2 support
Thread-Topic: [PATCH v6 2/4] net/idpf: add PTP virtchnl2 support
Thread-Index: AQHcnYFDTqXgyO4hQUGHTHsb6zFGxbWU1WVw
Date: Thu, 26 Feb 2026 10:15:12 +0000
Message-ID: <PH0PR11MB7563461A9769266E3D5E22DBB572A@PH0PR11MB7563.namprd11.prod.outlook.com>
References: <20260123000449.188008-3-soumyadeep.hore@intel.com>
 <20260214194920.139066-1-soumyadeep.hore@intel.com>
 <20260214194920.139066-3-soumyadeep.hore@intel.com>
In-Reply-To: <20260214194920.139066-3-soumyadeep.hore@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7563:EE_|SJ2PR11MB7518:EE_
x-ms-office365-filtering-correlation-id: b1e6c00a-77d5-4513-b639-08de751fedbe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700021; 
x-microsoft-antispam-message-info: Bnk7Nsjvo21dBfMDI3UtPPaEEQvtRikHhPBZF5wUNALAyloSnw2qAHe/rGBljPhipukabIkNkhuFETUsMrs6Xrigr1OLDF7+Gtmjzo56VSs+OIHKSvA5hF16UfIzFUIbywfM2viRb8yzyV1pW/LDs+QBCtlUhEMed6ZWPcM1hY8ZZh17hXVJNh/SBG8GCsZDrFo1j0t4Jh5mf7ogiFrPaFT6UlDlZ8tAXHaQ6qC3FewgTau6hQARoLoyFXAtsjR6PrV8OkZysXw0gmcBIiq9P+h+UGXikSr/k0iFok5lmV3PQsLTBADeMgHyDdHkNXTuwNj3O2Q2EdEKqrSbnorJFHvov9u2azrfAFIK2EeyWNqoRIO0VTneAzl//SSumb0P0VQwk5K3+/vDo3IZ/KZml31Y39uZawBDlkm9EtPo/CVAuyJuwX6O8L0p3ZZVGsT3+RN4nNqDQbnLDhHq/7UqTr8N/bYHPqa8l9ZSx8V3AMoANEcIC3F7YWni0pCTxFoWFeTdY5vIK7UMlRy9MXPhS0EhaL82LP3t1Ycex0BbO0/m+pgc6wqIPhAoVJalSVAffTHwKlJZ8pOhOJINjvuAJdmeUJxOkQXaIbKHrlSdIH3H9Gjp2hFaivegzHFfBat4FWks4sGiu98auIpf8ygK/PJaTZDkjLndzMYmm7V9M7NGgCFKO+BM4Qut/GfzXI+Xqbye80vaNfzmpTzV7LJejbWOQV5J7cXBQOkKgmPVMzhFIKV73t1n6UO2pWtLSMjClXyJrQQfoZdmN31antB3XdiEPU5ZtVa5nlOfMOTurCs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7563.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OagrklTs/l/zeUyvqBllWdtr9k7lb3Q9DWDCt9ePJClCgkpoUE2U+rfACqWa?=
 =?us-ascii?Q?+6BOL2261CiYF6LdN4Xgn5ELsZwxm0WFXDfp+OgFtmJcscrJqDjqbPCoZoCX?=
 =?us-ascii?Q?KBvxp0s3NgKDbqzVtkRbTnYreSDbAZdzRT7Hwhltx3OEFdpZ702KnmLwoJmD?=
 =?us-ascii?Q?FYvt+4wiOKPJ6RofEnfHgSl1jqhp2+W482umdbC9uZ3Cef/s85+V5O2OhGZa?=
 =?us-ascii?Q?HPRihcyH66A4QnQKnX3ztUuJtJTi7XZqRUBnnhFh+h6FZLEtAD+7VARFu/TZ?=
 =?us-ascii?Q?tgEcvfM6RMtiIxKdGMMp93oQVtkO9IiTCkV1A8kiXruVDqodk21FkHHts2/R?=
 =?us-ascii?Q?7MRvG+cB/WglOMMSg738VYhmyGLgdmIaJ7PgHSiXGZgr0C5L/lrRnGp+6g0c?=
 =?us-ascii?Q?B0ULnbp7l1QK7t8oVDpzBjPaEznlwYMrZMUi9sgcXl3rwW0r12HvXGf2Jdoa?=
 =?us-ascii?Q?l4U9YWrQZs8XF0LLZKu3Zl9PPWuX3r0wABINwwaQOBF4WNGmz5qK8mf9L2rY?=
 =?us-ascii?Q?8QKpnitbxhE+hAAcrdl1Ni8LtdkkJ4mIfV/xEf+96JwI4tlXeF2ZbreFuklF?=
 =?us-ascii?Q?PcohWQHfy3PYevISZPyHraiG0s+HropxMnE+6mRjz6TwKBEFVptBmQa+J+Vz?=
 =?us-ascii?Q?XAfa2lyriAJZnipj15yqLTaZhEmrIMANfbgwHtyeMhdaYTjfde0mw9Y1FwX0?=
 =?us-ascii?Q?IS+9j5SkSH+g/g7PCDO/x44azlO1jzWBRW6mA9JYBzEgRyZYog5dfvE6Wder?=
 =?us-ascii?Q?vsQ86Ha1FlDdJU2a+oZ3miU8GvhcPG+0DCFpWl/mTXbbmOT2ivaAhXihY4fl?=
 =?us-ascii?Q?KMrqJ+C4UuEcHPpIcqqwzLXl3Tu+No1ixrEvr6lohZyAAzcuqx4nyslcgPDz?=
 =?us-ascii?Q?gpYj4zpvEjqfAhI9iFtUTxRevCU8SQD17z5gqJXbJfW91qbUbmfILSMhYqNO?=
 =?us-ascii?Q?9/CR9GaOLAsPG+XzHbQjYcFVI7ixog6dgeg6ePOnfH++9zXlKuPG/xEtIKT4?=
 =?us-ascii?Q?pnjQgB/eSRuqTmXYcdblpHoXOe0gw5t+m2ymf4hlEiWh2heNiAVmpURDu9EJ?=
 =?us-ascii?Q?1pO1j8c3vsRLV+FWK/q/QF9J+OiitKfannRRMvXjLE5pPJFdK4O/33mhKvQx?=
 =?us-ascii?Q?rMy8vbFiMVD4FBF8qN+oEOkYnZ8PfRwfg41lpo0GDJY1EGPJ7PYDmQhVHkTo?=
 =?us-ascii?Q?WUG8xcOxmZObeTYaKocGfCao2/PddM6dxXwO7Ch+2xmtSQ0GO3Wd1XDqcaT+?=
 =?us-ascii?Q?FhglGHvJgGeqZef0WydlLdo7EkvqYskWHVddPEbjzm8zMx2HE8KNB+J5FG/O?=
 =?us-ascii?Q?7Ev3KsM428L5Y8EQRLKk1vCE0aGF2j/l4IpI8fdMxX9YSFtElt+Nb6CkBHSk?=
 =?us-ascii?Q?Jw/amozPPR2PMo3WVufBX6q7GlrlqibHUSQQOeJX2mPXfxHDdNp/Zhd6DuSw?=
 =?us-ascii?Q?+zCwbtBNAcdryH5U/r5vzeUi8twqf7+tt0S3aL3c8CHCy0YPfmcxu4vVp6JQ?=
 =?us-ascii?Q?TxnWFTRtrDQicfux4QOhg2foE1RHzfHGCqGlrvrnrx9Q3KHJQKOyV+9jkYmd?=
 =?us-ascii?Q?Zywbg2dLuhDUpMaqvvw7jPhEaRwCZ8/5swlCDPcBBCF4OkWEhqBrkMv5OTRW?=
 =?us-ascii?Q?9UAHX3zoqEtcZviztz6GiBQyxNr7fkJq3shJ7L0GBjZACU9QH61xpeDLAQmP?=
 =?us-ascii?Q?MEZBanh8lS32zMFRMtqun3n4YiJCA2JWLtvq8WHgXIBLqeKNaF/18QrklIIz?=
 =?us-ascii?Q?zHB6LJHiyA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7563.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1e6c00a-77d5-4513-b639-08de751fedbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2026 10:15:12.5779 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UgRvyW/uOHRn4GqisSNlKHdjJ5VJ5BhMKBauvZu4UVmT+/n9FIfWWFyV78uBgoilEROhMEI5lD9cqFqqj84BkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7518
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



-----Original Message-----
From: Hore, Soumyadeep <soumyadeep.hore@intel.com>=20
Sent: 15 February 2026 01:19 AM
To: dev@dpdk.org; Richardson, Bruce <bruce.richardson@intel.com>
Cc: Kumar, Rajesh3 <rajesh3.kumar@intel.com>; Singh, Aman Deep <aman.deep.s=
ingh@intel.com>; Subbarao, Manoj Kumar <manoj.kumar.subbarao@intel.com>
Subject: [PATCH v6 2/4] net/idpf: add PTP virtchnl2 support

Add a new file - idpf_ptp - to handle PTP virtchnl messages.
Keep the registers addresses in the PTP struct.

Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
---
 drivers/net/intel/idpf/idpf_common_device.h   |   4 +
 drivers/net/intel/idpf/idpf_common_virtchnl.c |  31 +-
 drivers/net/intel/idpf/idpf_ptp.c             | 504 ++++++++++++++++++
 drivers/net/intel/idpf/idpf_ptp.h             | 130 +++++
 drivers/net/intel/idpf/meson.build            |   1 +
 5 files changed, 668 insertions(+), 2 deletions(-)  create mode 100644 dri=
vers/net/intel/idpf/idpf_ptp.c  create mode 100644 drivers/net/intel/idpf/i=
dpf_ptp.h

diff --git a/drivers/net/intel/idpf/idpf_common_device.h b/drivers/net/inte=
l/idpf/idpf_common_device.h
index 31915a03d4..e45795c18b 100644
--- a/drivers/net/intel/idpf/idpf_common_device.h
+++ b/drivers/net/intel/idpf/idpf_common_device.h
@@ -103,6 +103,7 @@ struct idpf_adapter {
=20
 	/* For timestamp */
 	uint64_t time_hw;
+	struct idpf_ptp *ptp;
=20
 	enum idpf_rx_func_type rx_func_type;
 	enum idpf_tx_func_type tx_func_type;
@@ -173,6 +174,9 @@ struct idpf_vport {
 	/* Event from ipf */
 	bool link_up;
 	uint32_t link_speed;
+
+	/* For PTP */
+	struct idpf_ptp_vport_tx_tstamp_caps *tx_tstamp_caps;
 };
=20
 /* Message type read in virtual channel from PF */ diff --git a/drivers/ne=
t/intel/idpf/idpf_common_virtchnl.c b/drivers/net/intel/idpf/idpf_common_vi=
rtchnl.c
index e927d7415a..f8c487c537 100644
--- a/drivers/net/intel/idpf/idpf_common_virtchnl.c
+++ b/drivers/net/intel/idpf/idpf_common_virtchnl.c
@@ -4,6 +4,7 @@
=20
 #include "idpf_common_virtchnl.h"
 #include "idpf_common_logs.h"
+#include "idpf_ptp.h"
=20
 #include <eal_export.h>
=20
@@ -38,6 +39,24 @@ idpf_vc_clean(struct idpf_adapter *adapter)
 	return 0;
 }
=20
+	/* Helper to detect PTP-related mailbox messages */ static inline bool=20
+idpf_mb_msg_is_ptp(uint32_t op) {
+	switch (op) {
+	case VIRTCHNL2_OP_PTP_GET_VPORT_TX_TSTAMP:
+	case VIRTCHNL2_OP_PTP_GET_DEV_CLK_TIME:
+	case VIRTCHNL2_OP_PTP_GET_CROSS_TIME:
+	case VIRTCHNL2_OP_PTP_SET_DEV_CLK_TIME:
+	case VIRTCHNL2_OP_PTP_ADJ_DEV_CLK_FINE:
+	case VIRTCHNL2_OP_PTP_ADJ_DEV_CLK_TIME:
+	case VIRTCHNL2_OP_PTP_GET_VPORT_TX_TSTAMP_CAPS:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static int
 idpf_send_vc_msg(struct idpf_adapter *adapter, uint32_t op,
 		 uint16_t msg_size, uint8_t *msg)
@@ -71,8 +90,16 @@ idpf_send_vc_msg(struct idpf_adapter *adapter, uint32_t =
op,
=20
 	memcpy(dma_mem->va, msg, msg_size);
=20
-	ctlq_msg->opcode =3D idpf_mbq_opc_send_msg_to_pf;
-	ctlq_msg->func_id =3D 0;
+	if (adapter->ptp !=3D NULL &&
+	    idpf_mb_msg_is_ptp(op) &&
+	    adapter->ptp->secondary_mbx.valid) {
+		ctlq_msg->opcode =3D idpf_mbq_opc_send_msg_to_peer_drv;
+		ctlq_msg->func_id =3D adapter->ptp->secondary_mbx.peer_mbx_q_id;
+		ctlq_msg->host_id =3D adapter->ptp->secondary_mbx.peer_id;
+	} else {
+		ctlq_msg->opcode =3D idpf_mbq_opc_send_msg_to_pf;
+		ctlq_msg->func_id =3D 0;
+	}
 	ctlq_msg->data_len =3D msg_size;
 	ctlq_msg->cookie.mbx.chnl_opcode =3D op;
 	ctlq_msg->cookie.mbx.chnl_retval =3D VIRTCHNL_STATUS_SUCCESS; diff --git =
a/drivers/net/intel/idpf/idpf_ptp.c b/drivers/net/intel/idpf/idpf_ptp.c
new file mode 100644
index 0000000000..aefd1309f7
--- /dev/null
+++ b/drivers/net/intel/idpf/idpf_ptp.c
@@ -0,0 +1,504 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Intel Corporation
+ */
+
+#include "idpf_ptp.h"
+#include "idpf_common_virtchnl.h"
+#include "base/virtchnl2.h"
+
+static enum idpf_ptp_access
+idpf_ptp_get_access(const struct idpf_adapter *adapter, uint32_t direct,
+		    uint32_t mailbox)
+{
+	if (adapter->ptp->caps & direct)
+		return IDPF_PTP_DIRECT;
+	else if (adapter->ptp->caps & mailbox)
+		return IDPF_PTP_MAILBOX;
+	else
+		return IDPF_PTP_NONE;
+}
+
+#define IDPF_PTP_ACCESS(adapter, cap) \
+	((uint8_t)idpf_ptp_get_access((adapter), (cap), (cap##_MB)))
+
+static void
+idpf_ptp_get_features_access(const struct idpf_adapter *adapter) {
+	struct idpf_ptp *ptp =3D adapter->ptp;
+
+	ptp->get_dev_clk_time_access =3D
+		IDPF_PTP_ACCESS(adapter, VIRTCHNL2_CAP_PTP_GET_DEVICE_CLK_TIME);
+	ptp->get_cross_tstamp_access =3D
+		IDPF_PTP_ACCESS(adapter, VIRTCHNL2_CAP_PTP_GET_CROSS_TIME);
+	ptp->set_dev_clk_time_access =3D
+		IDPF_PTP_ACCESS(adapter, VIRTCHNL2_CAP_PTP_SET_DEVICE_CLK_TIME);
+	ptp->adj_dev_clk_time_access =3D
+		IDPF_PTP_ACCESS(adapter, VIRTCHNL2_CAP_PTP_ADJ_DEVICE_CLK);
+	ptp->tx_tstamp_access =3D
+		IDPF_PTP_ACCESS(adapter, VIRTCHNL2_CAP_PTP_TX_TSTAMPS); }
+
+int
+idpf_ptp_get_caps(struct idpf_adapter *adapter) {
+	struct virtchnl2_ptp_cross_time_reg_offsets cross_tstamp_offsets;
+	struct virtchnl2_ptp_clk_adj_reg_offsets clk_adj_offsets;
+	struct virtchnl2_ptp_get_caps send_ptp_caps_msg =3D {0};
+	struct virtchnl2_ptp_clk_reg_offsets clock_offsets;
+	struct virtchnl2_ptp_get_caps *recv_ptp_caps_msg;
+	struct idpf_cmd_info args =3D {0};
+	struct idpf_ptp_secondary_mbx *scnd_mbx;
+	struct idpf_ptp *ptp =3D adapter->ptp;
+	struct idpf_hw *hw =3D &adapter->hw;
+	enum idpf_ptp_access access_type;
+	int err;
+	uint32_t temp_offset;
+
+	send_ptp_caps_msg.caps =3D CPU_TO_LE32(VIRTCHNL2_CAP_PTP_GET_DEVICE_CLK_T=
IME |
+		VIRTCHNL2_CAP_PTP_GET_DEVICE_CLK_TIME_MB |
+		VIRTCHNL2_CAP_PTP_GET_CROSS_TIME |
+		VIRTCHNL2_CAP_PTP_GET_CROSS_TIME_MB |
+		VIRTCHNL2_CAP_PTP_SET_DEVICE_CLK_TIME |
+		VIRTCHNL2_CAP_PTP_SET_DEVICE_CLK_TIME_MB |
+		VIRTCHNL2_CAP_PTP_ADJ_DEVICE_CLK |
+		VIRTCHNL2_CAP_PTP_ADJ_DEVICE_CLK_MB |
+		VIRTCHNL2_CAP_PTP_TX_TSTAMPS |
+		VIRTCHNL2_CAP_PTP_TX_TSTAMPS_MB);
+
+	args.ops =3D VIRTCHNL2_OP_PTP_GET_CAPS;
+	args.in_args =3D (uint8_t *)&send_ptp_caps_msg;
+	args.in_args_size =3D sizeof(send_ptp_caps_msg);
+	args.out_buffer =3D adapter->mbx_resp;
+	args.out_size =3D sizeof(*recv_ptp_caps_msg);
+
+	err =3D idpf_vc_cmd_execute(adapter, &args);
+	if (err < 0)
+		return err;
+
+	recv_ptp_caps_msg =3D (struct virtchnl2_ptp_get_caps *)args.out_buffer;
+	ptp->caps =3D LE32_TO_CPU(recv_ptp_caps_msg->caps);
+	ptp->base_incval =3D LE64_TO_CPU(recv_ptp_caps_msg->base_incval);
+	ptp->max_adj =3D LE32_TO_CPU(recv_ptp_caps_msg->max_adj);
+
+	scnd_mbx =3D &ptp->secondary_mbx;
+	scnd_mbx->peer_mbx_q_id =3D LE16_TO_CPU(recv_ptp_caps_msg->peer_mbx_q_id)=
;
+	scnd_mbx->valid =3D scnd_mbx->peer_mbx_q_id !=3D 0xffff;
+	if (scnd_mbx->valid)
+		scnd_mbx->peer_id =3D recv_ptp_caps_msg->peer_id;
+
+	idpf_ptp_get_features_access(adapter);
+
+	access_type =3D (enum idpf_ptp_access)ptp->get_dev_clk_time_access;
+	if (access_type =3D=3D IDPF_PTP_DIRECT) {
+		clock_offsets =3D recv_ptp_caps_msg->clk_offsets;
+
+		temp_offset =3D LE32_TO_CPU(clock_offsets.dev_clk_ns_l);
+		ptp->dev_clk_regs.dev_clk_ns_l =3D IDPF_PCI_REG_ADDR(hw, temp_offset);
+		temp_offset =3D LE32_TO_CPU(clock_offsets.dev_clk_ns_h);
+		ptp->dev_clk_regs.dev_clk_ns_h =3D IDPF_PCI_REG_ADDR(hw, temp_offset);
+		temp_offset =3D LE32_TO_CPU(clock_offsets.phy_clk_ns_l);
+		ptp->dev_clk_regs.phy_clk_ns_l =3D IDPF_PCI_REG_ADDR(hw, temp_offset);
+		temp_offset =3D LE32_TO_CPU(clock_offsets.phy_clk_ns_h);
+		ptp->dev_clk_regs.phy_clk_ns_h =3D IDPF_PCI_REG_ADDR(hw, temp_offset);
+		temp_offset =3D LE32_TO_CPU(clock_offsets.cmd_sync_trigger);
+		ptp->dev_clk_regs.cmd_sync =3D IDPF_PCI_REG_ADDR(hw, temp_offset);
+	}
+
+	access_type =3D (enum idpf_ptp_access)ptp->get_cross_tstamp_access;
+	if (access_type =3D=3D IDPF_PTP_DIRECT) {
+		cross_tstamp_offsets =3D recv_ptp_caps_msg->cross_time_offsets;
+
+		temp_offset =3D LE32_TO_CPU(cross_tstamp_offsets.sys_time_ns_l);
+		ptp->dev_clk_regs.sys_time_ns_l =3D IDPF_PCI_REG_ADDR(hw, temp_offset);
+		temp_offset =3D LE32_TO_CPU(cross_tstamp_offsets.sys_time_ns_h);
+		ptp->dev_clk_regs.sys_time_ns_h =3D IDPF_PCI_REG_ADDR(hw, temp_offset);
+		temp_offset =3D LE32_TO_CPU(cross_tstamp_offsets.cmd_sync_trigger);
+		ptp->dev_clk_regs.cmd_sync =3D IDPF_PCI_REG_ADDR(hw, temp_offset);
+	}
+
+	access_type =3D (enum idpf_ptp_access)ptp->adj_dev_clk_time_access;
+	if (access_type =3D=3D IDPF_PTP_DIRECT) {
+		clk_adj_offsets =3D recv_ptp_caps_msg->clk_adj_offsets;
+
+		temp_offset =3D LE32_TO_CPU(clk_adj_offsets.dev_clk_cmd_type);
+		ptp->dev_clk_regs.cmd =3D IDPF_PCI_REG_ADDR(hw, temp_offset);
+		temp_offset =3D LE32_TO_CPU(clk_adj_offsets.dev_clk_incval_l);
+		ptp->dev_clk_regs.incval_l =3D IDPF_PCI_REG_ADDR(hw, temp_offset);
+		temp_offset =3D LE32_TO_CPU(clk_adj_offsets.dev_clk_incval_h);
+		ptp->dev_clk_regs.incval_h =3D IDPF_PCI_REG_ADDR(hw, temp_offset);
+		temp_offset =3D LE32_TO_CPU(clk_adj_offsets.dev_clk_shadj_l);
+		ptp->dev_clk_regs.shadj_l =3D IDPF_PCI_REG_ADDR(hw, temp_offset);
+		temp_offset =3D LE32_TO_CPU(clk_adj_offsets.dev_clk_shadj_h);
+		ptp->dev_clk_regs.shadj_h =3D IDPF_PCI_REG_ADDR(hw, temp_offset);
+
+		temp_offset =3D LE32_TO_CPU(clk_adj_offsets.phy_clk_cmd_type);
+		ptp->dev_clk_regs.phy_cmd =3D IDPF_PCI_REG_ADDR(hw, temp_offset);
+		temp_offset =3D LE32_TO_CPU(clk_adj_offsets.phy_clk_incval_l);
+		ptp->dev_clk_regs.phy_incval_l =3D IDPF_PCI_REG_ADDR(hw, temp_offset);
+		temp_offset =3D LE32_TO_CPU(clk_adj_offsets.phy_clk_incval_h);
+		ptp->dev_clk_regs.phy_incval_h =3D IDPF_PCI_REG_ADDR(hw, temp_offset);
+		temp_offset =3D LE32_TO_CPU(clk_adj_offsets.phy_clk_shadj_l);
+		ptp->dev_clk_regs.phy_shadj_l =3D IDPF_PCI_REG_ADDR(hw, temp_offset);
+		temp_offset =3D LE32_TO_CPU(clk_adj_offsets.phy_clk_shadj_h);
+		ptp->dev_clk_regs.phy_shadj_h =3D IDPF_PCI_REG_ADDR(hw, temp_offset);
+	}
+
+	return err;
+}
+
+static void
+idpf_ptp_enable_shtime(struct idpf_adapter *adapter) {
+	uint32_t shtime_enable, exec_cmd;
+
+	shtime_enable =3D adapter->ptp->cmd.shtime_enable_mask;
+	exec_cmd =3D adapter->ptp->cmd.exec_cmd_mask;
+
+	IDPF_PCI_REG_WRITE(adapter->ptp->dev_clk_regs.cmd_sync, shtime_enable);
+	IDPF_PCI_REG_WRITE(adapter->ptp->dev_clk_regs.cmd_sync,
+			  exec_cmd | shtime_enable);
+}
+
+int
+idpf_ptp_get_dev_clk_time(struct idpf_adapter *adapter,
+			  struct idpf_ptp_dev_timers *dev_clk_time) {
+	struct virtchnl2_ptp_get_dev_clk_time get_dev_clk_time_msg =3D {0};
+	struct idpf_cmd_info args =3D {0};
+	int err;
+	uint64_t dev_time;
+
+	args.ops =3D VIRTCHNL2_OP_PTP_GET_DEV_CLK_TIME;
+	args.in_args =3D (uint8_t *)&get_dev_clk_time_msg;
+	args.in_args_size =3D sizeof(get_dev_clk_time_msg);
+	args.out_buffer =3D adapter->mbx_resp;
+	args.out_size =3D sizeof(get_dev_clk_time_msg);
+
+	err =3D idpf_vc_cmd_execute(adapter, &args);
+	if (err < 0)
+		return err;
+
+	get_dev_clk_time_msg =3D
+		*(struct virtchnl2_ptp_get_dev_clk_time *)args.out_buffer;
+	dev_time =3D LE64_TO_CPU(get_dev_clk_time_msg.dev_time_ns);
+	dev_clk_time->dev_clk_time_ns =3D dev_time;
+
+	return err;
+}
+
+int
+idpf_ptp_get_cross_time(struct idpf_adapter *adapter,
+			 struct idpf_ptp_dev_timers *cross_time) {
+	struct virtchnl2_ptp_get_cross_time cross_time_msg =3D {0};
+	struct idpf_cmd_info args =3D {0};
+	int err;
+
+	args.ops =3D VIRTCHNL2_OP_PTP_GET_CROSS_TIME;
+	args.in_args =3D (uint8_t *)&cross_time_msg;
+	args.in_args_size =3D sizeof(cross_time_msg);
+	args.out_buffer =3D adapter->mbx_resp;
+	args.out_size =3D sizeof(cross_time_msg);
+
+	err =3D idpf_vc_cmd_execute(adapter, &args);
+	if (err < 0)
+		return err;
+
+	cross_time_msg =3D
+		*(struct virtchnl2_ptp_get_cross_time *)args.out_buffer;
+	cross_time->dev_clk_time_ns =3D LE64_TO_CPU(cross_time_msg.dev_time_ns);
+	cross_time->sys_time_ns =3D LE64_TO_CPU(cross_time_msg.sys_time_ns);
+
+	return err;
+}
+
+int
+idpf_ptp_set_dev_clk_time(struct idpf_adapter *adapter, uint64_t time)=20
+{
+	struct virtchnl2_ptp_set_dev_clk_time set_dev_clk_time_msg =3D {0};
+	struct idpf_cmd_info args =3D {0};
+	int err;
+
+	set_dev_clk_time_msg.dev_time_ns =3D CPU_TO_LE64(time);
+
+	args.ops =3D VIRTCHNL2_OP_PTP_SET_DEV_CLK_TIME;
+	args.in_args =3D (uint8_t *)&set_dev_clk_time_msg;
+	args.in_args_size =3D sizeof(set_dev_clk_time_msg);
+	args.out_buffer =3D adapter->mbx_resp;
+	args.out_size =3D sizeof(set_dev_clk_time_msg);
+
+	err =3D idpf_vc_cmd_execute(adapter, &args);
+	if (err < 0)
+		return err;
+
+	return err;
+}
+
+int
+idpf_ptp_adj_dev_clk_time(struct idpf_adapter *adapter, int64_t delta)=20
+{
+	struct virtchnl2_ptp_adj_dev_clk_time adj_dev_clk_time_msg =3D {0};
+	struct idpf_cmd_info args =3D {0};
+	int err;
+
+	adj_dev_clk_time_msg.delta =3D CPU_TO_LE64(delta);
+
+	args.ops =3D VIRTCHNL2_OP_PTP_ADJ_DEV_CLK_TIME;
+	args.in_args =3D (uint8_t *)&adj_dev_clk_time_msg;
+	args.in_args_size =3D sizeof(adj_dev_clk_time_msg);
+	args.out_buffer =3D adapter->mbx_resp;
+	args.out_size =3D sizeof(adj_dev_clk_time_msg);
+
+	err =3D idpf_vc_cmd_execute(adapter, &args);
+	if (err < 0)
+		return err;
+
+	return err;
+}
+
+int
+idpf_ptp_adj_dev_clk_fine(struct idpf_adapter *adapter, uint64_t=20
+incval) {
+	struct virtchnl2_ptp_adj_dev_clk_fine adj_dev_clk_fine_msg =3D {0};
+	struct idpf_cmd_info args =3D {0};
+	int err;
+
+	adj_dev_clk_fine_msg.incval =3D CPU_TO_LE64(incval);
+
+	args.ops =3D VIRTCHNL2_OP_PTP_ADJ_DEV_CLK_FINE;
+	args.in_args =3D (uint8_t *)&adj_dev_clk_fine_msg;
+	args.in_args_size =3D sizeof(adj_dev_clk_fine_msg);
+	args.out_buffer =3D adapter->mbx_resp;
+	args.out_size =3D sizeof(adj_dev_clk_fine_msg);
+
+	err =3D idpf_vc_cmd_execute(adapter, &args);
+	if (err < 0)
+		return err;
+
+	return err;
+}
+
+int
+idpf_ptp_get_vport_tstamps_caps(struct idpf_vport *vport) {
+	struct virtchnl2_ptp_get_vport_tx_tstamp_caps send_tx_tstamp_caps =3D {0}=
;
+	struct virtchnl2_ptp_get_vport_tx_tstamp_caps *rcv_tx_tstamp_caps;
+	struct virtchnl2_ptp_tx_tstamp_latch_caps tx_tstamp_latch_caps;
+	enum idpf_ptp_access tstamp_access, get_dev_clk_access;
+	struct idpf_ptp_vport_tx_tstamp_caps *tstamp_caps;
+	struct idpf_ptp *ptp =3D vport->adapter->ptp;
+	struct idpf_cmd_info args =3D {0};
+	int err;
+	uint16_t num_latches, i;
Instead of using i, Can we use something like latch_itr ?
+	uint32_t size;
+
+	if (ptp =3D=3D NULL)
+		return -EOPNOTSUPP;
+
+	tstamp_access =3D (enum idpf_ptp_access)ptp->tx_tstamp_access;
+	get_dev_clk_access =3D (enum idpf_ptp_access)ptp->get_dev_clk_time_access=
;
+	if (tstamp_access =3D=3D IDPF_PTP_NONE ||
+	    get_dev_clk_access =3D=3D IDPF_PTP_NONE)
+		return -EOPNOTSUPP;
+
+	send_tx_tstamp_caps.vport_id =3D CPU_TO_LE32(vport->vport_id);
+
+	args.ops =3D VIRTCHNL2_OP_PTP_GET_VPORT_TX_TSTAMP_CAPS;
+	args.in_args =3D (uint8_t *)&send_tx_tstamp_caps;
+	args.in_args_size =3D sizeof(send_tx_tstamp_caps);
+	args.out_size =3D IDPF_CTLQ_MAX_BUF_LEN;
+	args.out_buffer =3D vport->adapter->mbx_resp;
+
+	err =3D idpf_vc_cmd_execute(vport->adapter, &args);
+	if (err < 0)
+		return err;
+
+	rcv_tx_tstamp_caps =3D
+		(struct virtchnl2_ptp_get_vport_tx_tstamp_caps *)args.out_buffer;
+	num_latches =3D LE16_TO_CPU(rcv_tx_tstamp_caps->num_latches);
+	size =3D sizeof(struct idpf_ptp_vport_tx_tstamp_caps) +
+		sizeof(struct idpf_ptp_tx_tstamp) * num_latches;
+	tstamp_caps =3D rte_zmalloc(NULL, size, 0);
+	if (tstamp_caps =3D=3D NULL)
+		return -ENOMEM;
+
+	tstamp_caps->access =3D true;
+	tstamp_caps->num_entries =3D num_latches;
+	tstamp_caps->tstamp_ns_lo_bit =3D rcv_tx_tstamp_caps->tstamp_ns_lo_bit;
+
+	for (i =3D 0; i < tstamp_caps->num_entries; i++) {
+		__le32 offset_l, offset_h;
+
+		tx_tstamp_latch_caps =3D rcv_tx_tstamp_caps->tstamp_latches[i];
+
+		if (tstamp_access =3D=3D IDPF_PTP_DIRECT) {
+			offset_l =3D tx_tstamp_latch_caps.tx_latch_reg_offset_l;
+			offset_h =3D tx_tstamp_latch_caps.tx_latch_reg_offset_h;
+			tstamp_caps->tx_tstamp[i].tx_latch_reg_offset_l =3D
+				LE32_TO_CPU(offset_l);
+			tstamp_caps->tx_tstamp[i].tx_latch_reg_offset_h =3D
+				LE32_TO_CPU(offset_h);
+		}
+		tstamp_caps->tx_tstamp[i].idx =3D tx_tstamp_latch_caps.index;
+	}
+
+	tstamp_caps->latched_idx =3D -1;
+	vport->tx_tstamp_caps =3D tstamp_caps;
+
+	return err;
+}
+
+static int
+idpf_ptp_get_tstamp_value(struct idpf_vport *vport,
+			 struct virtchnl2_ptp_tx_tstamp_latch *tstamp_latch,
+			 struct idpf_ptp_tx_tstamp *tx_tstamp) {
+	struct idpf_ptp_vport_tx_tstamp_caps *tx_tstamp_caps;
+	uint8_t tstamp_ns_lo_bit;
+
+	tx_tstamp_caps =3D vport->tx_tstamp_caps;
+	tstamp_ns_lo_bit =3D tx_tstamp_caps->tstamp_ns_lo_bit;
+
+	tx_tstamp->tstamp =3D LE64_TO_CPU(tstamp_latch->tstamp);
+	tx_tstamp->tstamp >>=3D tstamp_ns_lo_bit;
+
+	return 0;
+}
+
+int
+idpf_ptp_get_tx_tstamp(struct idpf_vport *vport) {
+	struct virtchnl2_ptp_get_vport_tx_tstamp_latches *send_tx_tstamp_msg;
+	struct virtchnl2_ptp_get_vport_tx_tstamp_latches *recv_tx_tstamp_msg;
+	struct idpf_ptp_vport_tx_tstamp_caps *tx_tstamp_caps;
+	struct virtchnl2_ptp_tx_tstamp_latch tstamp_latch;
+	struct idpf_ptp_tx_tstamp *ptp_tx_tstamp;
+	struct idpf_cmd_info args =3D {0};
+	int size, msg_size;
+	uint32_t vport_id;
+	uint16_t num_latches, id;
Instead of using id, Can we use something like latch_itr ?
+	int err;
+
+	tx_tstamp_caps =3D vport->tx_tstamp_caps;
+	ptp_tx_tstamp =3D tx_tstamp_caps->tx_tstamp;
+
+	size =3D sizeof(struct virtchnl2_ptp_get_vport_tx_tstamp_latches) +
+		sizeof(struct virtchnl2_ptp_tx_tstamp_latch) *
+		tx_tstamp_caps->num_entries;
+	send_tx_tstamp_msg =3D rte_zmalloc(NULL, size, 0);
+	if (send_tx_tstamp_msg =3D=3D NULL)
+		return -ENOMEM;
+
+	for (id =3D 0; id < tx_tstamp_caps->num_entries; id++, ptp_tx_tstamp++)
+		send_tx_tstamp_msg->tstamp_latches[id].index =3D ptp_tx_tstamp->idx;
+	send_tx_tstamp_msg->get_devtime_with_txtstmp =3D 1;
+
+	msg_size =3D sizeof(struct virtchnl2_ptp_get_vport_tx_tstamp_latches) +
+		sizeof(struct virtchnl2_ptp_tx_tstamp_latch) * id;
+	send_tx_tstamp_msg->vport_id =3D CPU_TO_LE32(vport->vport_id);
+	send_tx_tstamp_msg->num_latches =3D CPU_TO_LE16(id);
+
+	args.ops =3D VIRTCHNL2_OP_PTP_GET_VPORT_TX_TSTAMP;
+	args.in_args =3D (uint8_t *)send_tx_tstamp_msg;
+	args.in_args_size =3D msg_size;
+	args.out_size =3D msg_size;
+	args.out_buffer =3D vport->adapter->mbx_resp;
+
+	err =3D idpf_vc_cmd_execute(vport->adapter, &args);
+	rte_free(send_tx_tstamp_msg);
+	if (err < 0)
+		return err;
+
+	recv_tx_tstamp_msg =3D
+		(struct virtchnl2_ptp_get_vport_tx_tstamp_latches *)args.out_buffer;
+	vport_id =3D LE32_TO_CPU(recv_tx_tstamp_msg->vport_id);
+	if (vport->vport_id !=3D vport_id)
+		return -EINVAL;
+
+	num_latches =3D LE16_TO_CPU(recv_tx_tstamp_msg->num_latches);
+
+	ptp_tx_tstamp =3D tx_tstamp_caps->tx_tstamp;
+	for (id =3D 0; id < num_latches; id++, ptp_tx_tstamp++) {
+		tstamp_latch =3D recv_tx_tstamp_msg->tstamp_latches[id];
+
+		if (!tstamp_latch.valid)
+			continue;
+
+		err =3D idpf_ptp_get_tstamp_value(vport, &tstamp_latch,
+						ptp_tx_tstamp);
+		if (err =3D=3D 0) {
+			tx_tstamp_caps->latched_idx =3D id;
+			vport->adapter->time_hw =3D recv_tx_tstamp_msg->device_time;
+		}
+		break;
+	}
+
+	return err;
+}
+
+/**
+ * idpf_ptp_read_src_clk_reg_direct - Read directly the main timer=20
+value
+ * @adapter: Driver specific private structure
+ * @src_clk: Returned main timer value in nanoseconds unit
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int
+idpf_ptp_read_src_clk_reg_direct(struct idpf_adapter *adapter, uint64_t=20
+*src_clk) {
+	struct idpf_ptp *ptp =3D adapter->ptp;
+	uint32_t hi, lo;
+
+	idpf_ptp_enable_shtime(adapter);
+
+	lo =3D IDPF_PCI_REG(ptp->dev_clk_regs.dev_clk_ns_l);
+	hi =3D IDPF_PCI_REG(ptp->dev_clk_regs.dev_clk_ns_h);
+
+	*src_clk =3D ((uint64_t)hi << 32) | lo;
+	return 0;
+}
+
+/**
+ * idpf_ptp_read_src_clk_reg_mailbox - Read the main timer value=20
+through mailbox
+ * @adapter: Driver specific private structure
+ * @src_clk: Returned main timer value in nanoseconds unit
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int
+idpf_ptp_read_src_clk_reg_mailbox(struct idpf_adapter *adapter,
+					    uint64_t *src_clk)
+{
+	struct idpf_ptp_dev_timers clk_time;
+	int err;
+
+	err =3D idpf_ptp_get_dev_clk_time(adapter, &clk_time);
+	if (err)
+		return err;
+
+	*src_clk =3D clk_time.dev_clk_time_ns;
+	return 0;
+}
+
+/**
+ * idpf_ptp_read_src_clk_reg - Read the main timer value
+ * @adapter: Driver specific private structure
+ * @src_clk: Returned main timer value in nanoseconds unit
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+int
+idpf_ptp_read_src_clk_reg(struct idpf_adapter *adapter, uint64_t=20
+*src_clk) {
+	if (adapter->ptp =3D=3D NULL)
+		return -EINVAL;
+
+	switch ((enum idpf_ptp_access)adapter->ptp->get_dev_clk_time_access) {
+	case IDPF_PTP_MAILBOX:
+		return idpf_ptp_read_src_clk_reg_mailbox(adapter, src_clk);
+	case IDPF_PTP_DIRECT:
+		return idpf_ptp_read_src_clk_reg_direct(adapter, src_clk);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
diff --git a/drivers/net/intel/idpf/idpf_ptp.h b/drivers/net/intel/idpf/idp=
f_ptp.h
new file mode 100644
index 0000000000..0c901440fb
--- /dev/null
+++ b/drivers/net/intel/idpf/idpf_ptp.h
@@ -0,0 +1,130 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Intel Corporation
+ */
+
+#ifndef _IDPF_PTP_H_
+#define _IDPF_PTP_H_
+
+#include "base/idpf_osdep.h"
+#include <rte_time.h>
+#include "idpf_common_device.h"
+
+struct idpf_ptp_cmd {
+	uint32_t exec_cmd_mask;
+	uint32_t shtime_enable_mask;
+};
+
+struct idpf_ptp_dev_clk_regs {
+	volatile uint32_t *dev_clk_ns_l;
+	volatile uint32_t *dev_clk_ns_h;
+	volatile uint32_t *phy_clk_ns_l;
+	volatile uint32_t *phy_clk_ns_h;
+	volatile uint32_t *sys_time_ns_l;
+	volatile uint32_t *sys_time_ns_h;
+	volatile uint32_t *incval_l;
+	volatile uint32_t *incval_h;
+	volatile uint32_t *shadj_l;
+	volatile uint32_t *shadj_h;
+	volatile uint32_t *phy_incval_l;
+	volatile uint32_t *phy_incval_h;
+	volatile uint32_t *phy_shadj_l;
+	volatile uint32_t *phy_shadj_h;
+	volatile uint32_t *cmd;
+	volatile uint32_t *phy_cmd;
+	volatile uint32_t *cmd_sync;
+};
+
+enum idpf_ptp_access {
+	IDPF_PTP_NONE =3D 0,
+	IDPF_PTP_DIRECT,
+	IDPF_PTP_MAILBOX,
+};
+
+struct idpf_ptp_secondary_mbx {
+	uint16_t peer_mbx_q_id;
+	uint16_t peer_id;
+	bool valid:1;
+};
+
+enum idpf_ptp_tx_tstamp_state {
+	IDPF_PTP_FREE,
+	IDPF_PTP_REQUEST,
+	IDPF_PTP_READ_VALUE,
+};
+
+struct idpf_ptp_tx_tstamp {
+	uint64_t tstamp;
+	uint32_t tx_latch_reg_offset_l;
+	uint32_t tx_latch_reg_offset_h;
+	uint32_t idx;
+};
+
+struct idpf_ptp_vport_tx_tstamp_caps {
+	uint32_t vport_id;
+	uint16_t num_entries;
+	uint16_t tstamp_ns_lo_bit;
+	uint16_t latched_idx;
+	bool access:1;
+	struct idpf_ptp_tx_tstamp tx_tstamp[]; };
+
+struct idpf_ptp {
+	uint64_t base_incval;
+	uint64_t max_adj;
+	struct idpf_ptp_cmd cmd;
+	struct idpf_ptp_dev_clk_regs dev_clk_regs;
+	uint32_t caps;
+	uint8_t get_dev_clk_time_access:2;
+	uint8_t get_cross_tstamp_access:2;
+	uint8_t set_dev_clk_time_access:2;
+	uint8_t adj_dev_clk_time_access:2;
+	uint8_t tx_tstamp_access:2;
+	uint8_t rsv:6;
+	struct idpf_ptp_secondary_mbx secondary_mbx; };
+
+struct idpf_ptp_dev_timers {
+	uint64_t sys_time_ns;
+	uint64_t dev_clk_time_ns;
+};
+
+int idpf_ptp_get_caps(struct idpf_adapter *adapter); int=20
+idpf_ptp_read_src_clk_reg(struct idpf_adapter *adapter, uint64_t=20
+*src_clk); int idpf_ptp_get_dev_clk_time(struct idpf_adapter *adapter,
+			     struct idpf_ptp_dev_timers *dev_clk_time); int=20
+idpf_ptp_get_cross_time(struct idpf_adapter *adapter,
+			    struct idpf_ptp_dev_timers *cross_time); int=20
+idpf_ptp_set_dev_clk_time(struct idpf_adapter *adapter, uint64_t time);=20
+int idpf_ptp_adj_dev_clk_fine(struct idpf_adapter *adapter, uint64_t=20
+incval); int idpf_ptp_adj_dev_clk_time(struct idpf_adapter *adapter,=20
+int64_t delta); int idpf_ptp_get_vport_tstamps_caps(struct idpf_vport=20
+*vport); int idpf_ptp_get_tx_tstamp(struct idpf_vport *vport);
+
+static inline uint64_t
+idpf_tstamp_convert_32b_64b(struct idpf_adapter *ad, uint32_t flag,
+			    bool is_rx, uint32_t in_timestamp) {
+	const uint64_t mask =3D 0xFFFFFFFFULL;
+	uint32_t phc_time_lo, delta;
+	uint64_t ns;
+
+	if (flag !=3D 0)
+		idpf_ptp_read_src_clk_reg(ad, &ad->time_hw);
+
+	phc_time_lo =3D (uint32_t)(ad->time_hw);
+	delta =3D in_timestamp - phc_time_lo;
+
+	if (delta > mask / 2) {
+		delta =3D phc_time_lo - in_timestamp;
+		ns =3D ad->time_hw - delta;
+	} else {
+		if (is_rx)
+			ns =3D ad->time_hw - delta;
+		else
+			ns =3D ad->time_hw + delta;
+	}
+
+	return ns;
+}
+
+#endif /* _IDPF_PTP_H_ */
diff --git a/drivers/net/intel/idpf/meson.build b/drivers/net/intel/idpf/me=
son.build
index a805d02ea2..740c1a5985 100644
--- a/drivers/net/intel/idpf/meson.build
+++ b/drivers/net/intel/idpf/meson.build
@@ -17,6 +17,7 @@ sources +=3D files(
         'idpf_common_virtchnl.c',
=20
         'idpf_ethdev.c',
+        'idpf_ptp.c',
         'idpf_rxtx.c',
 )
=20
--
2.47.1

