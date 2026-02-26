Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2051AFC5915
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 12:01:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 79D5A402BC;
	Thu, 26 Feb 2026 13:01:02 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 846EB4026F
 for <dev@dpdk.org>; Thu, 26 Feb 2026 13:00:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772107259; x=1803643259;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=61mxpPpPW7hgwapiz2LsdR7zcvsZ/qSEYOxhJqjpyOA=;
 b=Sm1YNJVl0l0tf5F3TQGt1gVTUDMKWPaM/SAG92U61yOLMVSOMGA7bd5A
 LDGRmn2tyDEomC9l/NTTf+kC1zFsrxllapSpXMAGv/jbJ7lN36Nmu+9z4
 3BrsFPMNfR8YY81MWxdhmGVdEh7S1xpT2zoA8CGWWtBI1OkvV1aqSYRza
 qXdgX91MSALUEbo9l/ddZTz2Cp0GLxbmDCAY2XgtSHstmMktaTp+GN+II
 S/UA+FPLc/Cu7wzlWtxOIRiIQJR5YqEYd9g3UEjKmy1IUKIvncRdHTugi
 gMxN6t97t4XjcBG1hABZQ5cifVNIHbfsp4Yui3Wcb/cK1nV+ogzFyS3EM w==;
X-CSE-ConnectionGUID: Wwipvg06S1eBmewbskVE/g==
X-CSE-MsgGUID: ULYiVwhrSEi4y8zJ/OrJhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="77001558"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="77001558"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 04:00:57 -0800
X-CSE-ConnectionGUID: EK1CC92cQKyZmGJcGwyegA==
X-CSE-MsgGUID: 7nj2jnEUT3yOP0rUGji/2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="214534728"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 04:00:58 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Feb 2026 04:00:57 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 26 Feb 2026 04:00:57 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.7) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Feb 2026 04:00:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RKQhSZRGJAZsKO7qysfoiTGm26KS9BtvSQvcIKW4Y0wNjdEhc8SCuVBQqE7PcQJavuwOE1tDNwmyRv6NLAliqZ2SVn5zqfJiFRCaNeRmVaQxScnxii4FGYjmMEDf6DIbuzBih4eJvVAw30i8zlpWzLHaeTUuzhh0nF7yAZ9cjsyKTcaAficEpU4+1KNXJdsnp+6rHQknp3Fw13Fht+M7Zp239ECp3huFiG4kCKQVy9lpghjV32u4gaT9GBEQwkuhl/Y/9eGowWv5enKp8PNaFTAfftNS1UJn5ZZyzzbwoX0Zgu258oDLSL1HTz2hgaHtW52idFsR1NB3nNEgbv2Smg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0KG57SwWlgqaEEZ9Jw8YZjGBroQYkTUMwMZXLrq5d+Y=;
 b=ryRp8JBl2fEHZFHnejUsfzW5gEoofca59RC9RZqql2mdzEQLvN0seWSAhyz+4XW0s+ETsF4XgtYIvmacDl3WGpx+1fuQINpDJzGub39wFlAlTpj8uod0alhUboqg9DeSmBPeGX5yGdFUfOl/DgTWx+qdZwRc4+VhtLfudkw4MK+jY5ry3fijEq9FhJq5s8YD6wqfMl0zq1+tnEMCKTyuUAK821KNX1/ZH6P88J5CJgFECxIdXK5pxas2xVh8U00v4fayyI3gSxgB335LLv3uJoXwTrehG9zcjlz8R0NDrBIURf8GMPUmIVxZyfsdL7CoXUuwIxoZH68FEqussPtpaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7563.namprd11.prod.outlook.com (2603:10b6:510:286::11)
 by IA1PR11MB9493.namprd11.prod.outlook.com (2603:10b6:208:5af::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Thu, 26 Feb
 2026 12:00:54 +0000
Received: from PH0PR11MB7563.namprd11.prod.outlook.com
 ([fe80::b1d9:cd5f:9d12:e954]) by PH0PR11MB7563.namprd11.prod.outlook.com
 ([fe80::b1d9:cd5f:9d12:e954%4]) with mapi id 15.20.9654.007; Thu, 26 Feb 2026
 12:00:54 +0000
From: "Kumar, Rajesh3" <rajesh3.kumar@intel.com>
To: "Hore, Soumyadeep" <soumyadeep.hore@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>, "Richardson, Bruce" <bruce.richardson@intel.com>, "Singh,
 Aman Deep" <aman.deep.singh@intel.com>, "Subbarao, Manoj Kumar"
 <manoj.kumar.subbarao@intel.com>
Subject: RE: [PATCH v7 2/4] net/idpf: add PTP virtchnl2 support
Thread-Topic: [PATCH v7 2/4] net/idpf: add PTP virtchnl2 support
Thread-Index: AQHcpxczFwrQusZcvU6TEjSBnCpJNbWU4MOg
Date: Thu, 26 Feb 2026 12:00:54 +0000
Message-ID: <PH0PR11MB756331CD5A4C11201B54A70BB572A@PH0PR11MB7563.namprd11.prod.outlook.com>
References: <20260214194920.139066-5-soumyadeep.hore@intel.com>
 <20260227003314.439267-1-soumyadeep.hore@intel.com>
 <20260227003314.439267-3-soumyadeep.hore@intel.com>
In-Reply-To: <20260227003314.439267-3-soumyadeep.hore@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7563:EE_|IA1PR11MB9493:EE_
x-ms-office365-filtering-correlation-id: cbb28626-bf0e-4fcf-e610-08de752eb1ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: P87qWQn+0jCnFzmLhGT1ZF/VforXysMJOhAuoWmnjirVkmJ1xUZHm+/+XCUrgWeqaXFEThe1O0o4MIKEKNhUp27BIlVv7l/nYT7hdwfHYLPYuP3q820SfuU5ImLhxuPUSG0T1ua1b+qSUe+nbfMyGAS05cdlQMq7WEL8KZjMC6CjXLueX+vuVFlU6rz8KX0N36xnylSW56xh1ROSPRg8yD1mv+k5lLf8lfnAHHXobdl8nJhn6Y5x42NcIm6B8kye5GMBePMAGvclXDaau/xpW/Xac+Og7exoZbuIqddYdqPNTzRQCzx/HuImaeaLgJeiUsrOndfiZSqIED9hu/SbJsWZc5qQnUtQpx2r3lOD7ENlNR4n+nMgADwKAuubZOFOsyaz98PVSVm1Ozdp92mSSjYRbzabFj8fisKRnySoBTayes3cmE+upll5pYXLgfn2GXaQZebsrXQ47YqdL1Mq+XzC5iyrED6/y0tRtuTbG1mlsp3TxchFUuc/BRgiqQ9wciXILPqKicDOsL1mUQm7+cAYubQOonX7xc8iqc7yijkLX3fySCsxnLqN/4DSmlPOtPsY3dn5hkQp8zNTLp52c+Vu0nUmiiOi3XvbWdLl2jeazS5vb/HrSlsWq+emtUgjC9IIPeWgcYG+pcU4ws926YhHsRR3dkSnTkiV69KrtbiKfO4DGQlMBT9oq/iyLrXK61BySBJ3OdLIir/hCwxxllRT82aNFs2voPgPxEY1xMfRDTBbGOGRdHdfJJnI2J8kIcfmLK0hHVVn97TxTb8LDkJtWOHr+/X2hPG3iY1SQ+w=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7563.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?za3A7Ok0+TlaXCOeAipFlRZ++NMcV9iv1y8qq0ibyvfGM6wlWtnM30uKkWEY?=
 =?us-ascii?Q?dv1w5kVV/LtR1AS/Mhs/Mn30h4qSwmUf92w1aJcte9/BJ6ywzqe/3qqQvk9r?=
 =?us-ascii?Q?Dv8GFudF0jNL+GGjaUK4LOWAb8X9zXoixx8OWzdh7OcHLsDENqKl0XMpIE0A?=
 =?us-ascii?Q?FGC1lqIisdY8+V6smtdRGLWvyAIn9y8MB+v0/vrPrSxvWZva4M/iHG5N6KZG?=
 =?us-ascii?Q?CCszjIk59wxQOWmcnMnIWqPpgOvvNdAM3ym/5HJkVYuz2TpE9tgSCPFVBrBt?=
 =?us-ascii?Q?qIiX6kt3sfTsNTG8EiObcGYkSD/Qpm/8Ld5oEFtKYtvEpgRqMTke+9JM89r+?=
 =?us-ascii?Q?6rfTMgt/SUcaZ4M2POYQIKXkyOn5YfcghTXYwA/Wi0JpG1Xyn5XX6X9u1nVE?=
 =?us-ascii?Q?f17SZdVE+ILtDApLwyFMDU6bxDD7mfzdBmbXmKiG5BBWP5aDSA0nWGwjH5oi?=
 =?us-ascii?Q?VaBLZUVaH7bapZ11LCTrc9FsnSS3HZaBfJnaa4d//nz1G8hPTQVmlIM8UCK5?=
 =?us-ascii?Q?/2sMiE0BDHaf8wNpHMRgF3raOiNrP+wT24YlS7bBa5w+pPi0sKqwGOJA3nUL?=
 =?us-ascii?Q?mtSP/TcWykwRrDeNOsPNj1UBgecPcnUWK4VmicafgU0gfRMzOvPT7U6jRCXq?=
 =?us-ascii?Q?p8o/HjIJIb4ZuKq5yMvxdUouUyB1qevTwU4A2KrZb+CzexcS9o8K8RJHX8B9?=
 =?us-ascii?Q?eSnJlqdJq/PcXXEjH9izcU6v/RJJEqZc/Ci14lYnMmKJzAR7yp9A+Tye+MrN?=
 =?us-ascii?Q?s2vpurJdgvwgV69bqSqIOPwLp0ElkjRfr70YDIIaAcJAy1KHDeY1PsZJZv7W?=
 =?us-ascii?Q?XiJUt3pu9LOgYaSGgBrqt7aIihH+TknIO7hXJu8wybDxpY7m+/VZVP/or1o0?=
 =?us-ascii?Q?lsCVr3c9TWFPfjPzl5yesC90oVOjrmNVstgRFRrMrukT6Ww8v+rB6tJKSefm?=
 =?us-ascii?Q?ceiriupeWqCjsG6Q0lNoB4g3w8spwmtdPkhAEQUd+xs3FNk6RmafDoSdd8jy?=
 =?us-ascii?Q?rn/lZP1z21+ZmZp6B7i6D0ApEvlrsIGpQBDQZh4Mtg6NN3SaYxkM1ukcHEKL?=
 =?us-ascii?Q?fT+TIOxall2ifmJzR/CNGn1GyCZHk6N3wQDJ2eSlYeHWhQ/+WBqAJdQ9amkw?=
 =?us-ascii?Q?Z5W8uPkbGuIZN5wqAMi6S43LN+2U64n0tjj8hVC+ZbEK0ZgcZa4DpfRD2coT?=
 =?us-ascii?Q?f4lNkfH4vOWVKbK84sPESmbenS8CZaEViYr8oNq6e1EOt1pwcSHOUEJnjwOi?=
 =?us-ascii?Q?KcwlBE63pp0jMgdeWfcvXVqiGZdYwNFaZHXFEVVs7b76OaNauZcqPxfpkqH1?=
 =?us-ascii?Q?71gXLnQmP0pA8sNdBIihfoU9FzKg0uDc/uURmpav/+KVyoaMgcYJ34pPd3L+?=
 =?us-ascii?Q?rfkato5EcWPmLEIwaol/muqgN6z49qFp98Tb7IpjJb4NfHT8U7QYhQJcU62e?=
 =?us-ascii?Q?fAoZIofsQ9u7GKFUWD44rAa8HyZV2Y+rtZ4SZy3HzulIe91NP1TS0nyRv9bW?=
 =?us-ascii?Q?G622EXXLLObVQX4AQuLjTT4L2GEVxjMsBzDNl3PGx6McHa4y4QaQK4DLunis?=
 =?us-ascii?Q?N5QZGOAd5GArp1celfzAFLE/XOIMqCadpdR0uvgWHIKFNK/HIApt4wy6nTWK?=
 =?us-ascii?Q?SQvNLkKDa3zgneVn/OsUFLuRojBEHy+GamzGkW+O80W5f80HFSZuoHO3Sn+X?=
 =?us-ascii?Q?J3WoYIPzA+6v2OCNZjsr73edHv4utky1dDa0by3RM7ZkT6ucNY5Q8G7XFW9i?=
 =?us-ascii?Q?0cR9lpTtdQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7563.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbb28626-bf0e-4fcf-e610-08de752eb1ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2026 12:00:54.3067 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ts0HIVd4Mp5IEnZ7jFwTVQ08yDLcVw1pWwkOmA3vvNqyZXTlYAV8zQBTRFgvedfHT+nnwVR4zPoY1qnt1Tx4zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB9493
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
Sent: 27 February 2026 06:03 AM
To: dev@dpdk.org; Richardson, Bruce <bruce.richardson@intel.com>; Kumar, Ra=
jesh3 <rajesh3.kumar@intel.com>; Singh, Aman Deep <aman.deep.singh@intel.co=
m>; Subbarao, Manoj Kumar <manoj.kumar.subbarao@intel.com>
Subject: [PATCH v7 2/4] net/idpf: add PTP virtchnl2 support

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
index 0000000000..5c3fcb90e4
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
+	uint16_t num_latches, id;
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
+	for (id =3D 0; id < tstamp_caps->num_entries; id++) {
+		__le32 offset_l, offset_h;
+
+		tx_tstamp_latch_caps =3D rcv_tx_tstamp_caps->tstamp_latches[id];
+
+		if (tstamp_access =3D=3D IDPF_PTP_DIRECT) {
+			offset_l =3D tx_tstamp_latch_caps.tx_latch_reg_offset_l;
+			offset_h =3D tx_tstamp_latch_caps.tx_latch_reg_offset_h;
+			tstamp_caps->tx_tstamp[id].tx_latch_reg_offset_l =3D
+				LE32_TO_CPU(offset_l);
+			tstamp_caps->tx_tstamp[id].tx_latch_reg_offset_h =3D
+				LE32_TO_CPU(offset_h);
+		}
+		tstamp_caps->tx_tstamp[id].idx =3D tx_tstamp_latch_caps.index;
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

