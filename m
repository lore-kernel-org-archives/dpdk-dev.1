Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD54FC592F
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 11:12:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6BE0C402B2;
	Thu, 26 Feb 2026 12:12:17 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 61EC04021F
 for <dev@dpdk.org>; Thu, 26 Feb 2026 12:12:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772104336; x=1803640336;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=ADinzFLhPzImSkx6cTJ2xVKkijQzTGXR/Icm62NRIi0=;
 b=EpjIaGv12CvxNhqin2kj0OVX4rDaIx8YJacSECtlq9NQB7zjbwkxsxpb
 XsqqcKDDIzPiaYr18aXxKYKaPkmJc495/zuMAtEM0Q59AuRZHil9MmE09
 PtZDqOaVTX5VAAKWff3DD7VIEr1AYZHTVnZ2R4v0LqVmHJs5yunS3c+aj
 hs0evEqdctWvKaXnJ0DjA+WMuNinK+caqaLOv9e0IXtQE/tT+wy44AHf+
 CoMI4ZsSk13F59WWjGFQ04pyJDxVAhsI9d3Y84fKhJY1JzBJYYQZaBxL6
 KjESQdtV4QHf7CVEh/Q1Vt9NQ1FFXFahUfyuSWW+xhj1kq1DaRwE3STVu Q==;
X-CSE-ConnectionGUID: umJizbI+SQuFYPNmsK8yOQ==
X-CSE-MsgGUID: u2EZTfzeTyywU0NBWqS8dQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="84517202"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208,217";a="84517202"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 03:12:14 -0800
X-CSE-ConnectionGUID: QaB/k9i2QuarVu4wHAI1+Q==
X-CSE-MsgGUID: 64/p9UkkRrGo0RBWVvVosQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; 
 d="scan'208,217";a="214527745"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 03:12:14 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Feb 2026 03:12:13 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 26 Feb 2026 03:12:13 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.7) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Feb 2026 03:12:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QmqKyvnv4WfYA70fskTbXYVgxupP8I5YqQ+T7SEvgTYgexb/yoCgP/RinEFvwztehxDGXnrnqbKrpmaFgl+4rb0NL7Uo2N0qxKVXcczve7KDvz5uXq4EG9TFz67qKXhsWz2V3cHY+4xNeIWVoBdupWiMU0jG4PUkJ5foQpv7GGPmSDXnGh1rGbqGZnXhjUvVbT4q/oDFJddCBBofPUxAh++0CDBxKLC4apNqRpFanoWJQ591GYB3rgewKVcW1/lxdtrXM9QAJ3pviGG/m4ddE0nxUMlF735pfyWzGgpUDK8BFIxgSf5syijebLevMDHUaUkntsDGsWG3hU9W0/owZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5T4c9mnZ0QkMCAjc5rfrVOJIsUZi+zaM4V4Y/uwmwCE=;
 b=IJ5kRQA9VA5US2fqQySQYVPBbEKE+NZtGFknJ1gwCXK5gTbbf+o/SmcX4aZWMGq2NRCyjX4Sw9N+s0eewzk0X2MbnKdzyKF0NmfJtre24ookIrEx6C0wNKUG6NmMJ3AEaoK8uYpaWq11HxxASIUY7oPhhzkHcA1jLANnCqHnpM3UGXIzHzgf7ak00acCQD1jvBQkjmWNneTElJ8t/tqBzuISgGxgeJzzLYAV16c9Xyse4a1dTuZO22rwfkEtXI1/gm2SgWS/1tiOulMd2azGaWmsPDXqeEtGirwjBKf4BhjyHM70OTz+G1/TIplPlTsLd/dU8TxV9dzUckOdzYFAeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7747.namprd11.prod.outlook.com (2603:10b6:930:91::17)
 by PH7PR11MB6555.namprd11.prod.outlook.com (2603:10b6:510:1a9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 11:12:10 +0000
Received: from CY8PR11MB7747.namprd11.prod.outlook.com
 ([fe80::1457:eb10:8766:7a67]) by CY8PR11MB7747.namprd11.prod.outlook.com
 ([fe80::1457:eb10:8766:7a67%3]) with mapi id 15.20.9654.014; Thu, 26 Feb 2026
 11:12:10 +0000
From: "Hore, Soumyadeep" <soumyadeep.hore@intel.com>
To: "Kumar, Rajesh3" <rajesh3.kumar@intel.com>, "dev@dpdk.org" <dev@dpdk.org>, 
 "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "Singh, Aman Deep" <aman.deep.singh@intel.com>, "Subbarao, Manoj Kumar"
 <manoj.kumar.subbarao@intel.com>
Subject: Re: [PATCH v6 2/4] net/idpf: add PTP virtchnl2 support
Thread-Topic: [PATCH v6 2/4] net/idpf: add PTP virtchnl2 support
Thread-Index: AQHcnYFRvQNGdvG7ZUWxLjrzsAvJsbWU1pMAgAAPlr8=
Date: Thu, 26 Feb 2026 11:12:10 +0000
Message-ID: <CY8PR11MB774715CCEE33646561110B75F972A@CY8PR11MB7747.namprd11.prod.outlook.com>
References: <20260123000449.188008-3-soumyadeep.hore@intel.com>
 <20260214194920.139066-1-soumyadeep.hore@intel.com>
 <20260214194920.139066-3-soumyadeep.hore@intel.com>
 <PH0PR11MB7563461A9769266E3D5E22DBB572A@PH0PR11MB7563.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB7563461A9769266E3D5E22DBB572A@PH0PR11MB7563.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7747:EE_|PH7PR11MB6555:EE_
x-ms-office365-filtering-correlation-id: e46af145-f71c-4965-8659-08de7527e319
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700021|8096899003; 
x-microsoft-antispam-message-info: k3z7fGDf8T9jYmjEP1e8OBuZpiL3SelpFRNecwCkFOv54gL+44sK8tM2IjByBSp1jd3CHRttdMDumaROXwqxilOO9KI/3U/vNqthtkOKXjo2gHgHj/ZOeLSFFBiv+LRiok2XAKj+w+eoM7G2QqV8Jc9DFHvfVHSCl9J8EuFo2RhKL7WVi5+Rq0hkrqsYi/NHNygyAKS66QCIAoAybJQamkRmbSVii4VgATt9wJzMMIpnXrqvI2nvpZ9+CtwZTjM2FBfeFfBsNiQ/ST33VI324CPc835wT/40mhj/d2rtkzVh921TBRINAsKn0KAja0IX1I1/O5irox2MrBUrVJtCOhGwnlnDqM10a8w3Lg3g34XvGe6i0cycl3ywnbQ0v+UGjZXVTww21X+Ls1f+SOntt7DVNzbrOQM/+rUd4JJ5YX62cAN1gw7T8yjKN8OtzchkUFonS+pDBzk1aMSP1VTyjZpgK9xt2Gb+b5Gs6ufpn3fboaXrXeZ31lJuMgEGe3sNjTHDbhAGvbtmHnALGV4tSRk7fh0eT13C3obwV/xY0SGLKtayrN3H7fUinRuaeOyZ3hDWfUfeag7CiUCyOYk8/nveMuOpv6xlms5sGjmU0rI9THWksowm2y0+Lo0GHSQtq6T1OP4jNIuM9SM2Akxw5lafYo2yWfLOp1Vy9wxevMmVAUnVMQGFuOkOmmLG8sRdle0FCN6DMMzRU9+IlsRG/7BjTvoIYjnEfQnGo/9vSJzOjTuR26aBHpIf0sG2ngHD+T6D5z5wiA52WI+Qn/uMuwUJ4Bfm5o8bYFiGsupwE8Y=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7747.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700021)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?FuGnKvy8Ivl5fBT75LBYDlsNkbf6c9hzuSxBuI75C35iBYTmMBmOTQlHbj?=
 =?iso-8859-1?Q?UIDF2w7/qbiFuRajUa0nlQyrgDtE9jifBLQGT+9LoLhZ6hZkhQZH6gueLh?=
 =?iso-8859-1?Q?4YxpW3ktDYvb/4mRgEIB+toVj0oq9iE4MQ/dpeHCqMT6m8d/D0CrtLUC5E?=
 =?iso-8859-1?Q?l60Xwz2RdYvCKrqAiM3IGyRmdyvw0dyXgn+3pemWOt9KC4LVGK7SHjG5em?=
 =?iso-8859-1?Q?zCOYd3D+OM1IAMQYrN/1mUw8nXuHe10wUaNCGLhWNisnp53ALlG6AQhLqt?=
 =?iso-8859-1?Q?wBUrtM1GNZzt+39UWEDJoH2xugASePwWn0HkaGtlbIuZl/a3wUkNRTtKji?=
 =?iso-8859-1?Q?JMv3KBDDVGYk0RtQyQqsRX4FX8XSYxeVrMVGi9idb7dsiv+xwMBDBDCOeH?=
 =?iso-8859-1?Q?y9026lBD4rMmsYUdNcSofz4NMAejJVwxOm/azWbYvxz2sKNZc/kXC2FT9g?=
 =?iso-8859-1?Q?JuEcHwevBPYZe0Kt1lkvVTmefEO0ybPvE9Ks+I5ojRW7LqtmEA94bprzT1?=
 =?iso-8859-1?Q?8bOUijS6NYXyTIT1Zbg+o3pFFKlDGJHTou2AydcdtUmVNfYAzTy+kpLPGe?=
 =?iso-8859-1?Q?UBulb/4+Ii5qTidXyTWRRHF1+rOGos1zsTBuv2kpaKA8dNjVHDpgxk/uDl?=
 =?iso-8859-1?Q?li2llKCe2TdOlryCz8rzamjvAyTfLzS4SAgKS9E9TfJBPo62j1YPmLbiCW?=
 =?iso-8859-1?Q?jsD+mw44BHfmOWEU8Wl7x+3+eJwCBjDuIZfNJAZDu1VwImnmVd6xWeGyix?=
 =?iso-8859-1?Q?+IkBqbNr1PBOlW7ukmLCmXLd/9IfrDjdkzFDWevZvVCtN/8Iu2cyUI3rhV?=
 =?iso-8859-1?Q?++zIzTuE7og/wPzuUL1KpFudlJjJwQ4HUqqIzztKQGOlfaCJN9KpjOV624?=
 =?iso-8859-1?Q?x3fX/hufBSCaaAZOQRklKLn4HJ6robPgi05gJTbGaJs3ln7/se0xf88RQU?=
 =?iso-8859-1?Q?AG1p2JoXacyRySCpxfp0p7dp+mWwwL15maUHfDZlZ/zzF7cfU/MHk1Yrem?=
 =?iso-8859-1?Q?5HL1Y7k7DofROsgIzR98MmU8pLumuvUSVvw8w3nJbsBS2HhIWoPeFIhkCG?=
 =?iso-8859-1?Q?FPVrdq+Q22bmwT4HGS9bo6qjO9vgRjfAKz9EyuumJ8lQ9FBLyDRMsJ+TFy?=
 =?iso-8859-1?Q?39XLNUOipLNzxGZt/0M8tPA6BeYY2RzqeA/rKElrd2zA83x70lGR1NMrg/?=
 =?iso-8859-1?Q?vk+iNwyfiX2yEzg3gpDj4mVhDmHjPxuR1dAG3kdfDwkHg58lhKbs2Zp69g?=
 =?iso-8859-1?Q?GfJDnup1TT7d5xm0QAaaAxhiaO5KthO9r1NWOX11vCMn7jN20iyNj3bkE5?=
 =?iso-8859-1?Q?/8V25ahlPJgNj58hSyCkptWfL6ckcnftlIoRjDScANlmfEoD/yieFUvBhA?=
 =?iso-8859-1?Q?TcvmVcZjBp7XeDla3i60Lm6Irbqp5WUcypZm4gIA96BN8bC2buLg2a2bpQ?=
 =?iso-8859-1?Q?0xyjq4CS0qjR3kLUa00qTgldTT9vrbxc4lCTryoHfHM8sKLqey2eM6Jt52?=
 =?iso-8859-1?Q?uOvSeGLVSMDy8W6Ie6dNVIdFSSkle1ar9zb/bXqgQqrY3TfsuO8IyJlNoY?=
 =?iso-8859-1?Q?JOmW0QqE0VGKOW2vUZZNWXm0oskhhdqEoEQiXxpLV/cRrUAIBFILpafp4b?=
 =?iso-8859-1?Q?ncXxoWh5yZl0M6t4C2xuMOOJYaoLySV5ijcSEAEOTHJbZX84P1Q1N+/wyW?=
 =?iso-8859-1?Q?nUXUbQAD7N4sp7RnRNPYiP8xEMRRWEJ5Q8Y/7AFjQmA8EJniaoTuQO/B+Y?=
 =?iso-8859-1?Q?IcvVvJ5rnkmP0cG4vcBoo6R6QZSTI6f4Wg/jPY6Fnf1EdRD7jod+UInuG7?=
 =?iso-8859-1?Q?tN/jv6V9+A=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CY8PR11MB774715CCEE33646561110B75F972ACY8PR11MB7747namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7747.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e46af145-f71c-4965-8659-08de7527e319
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2026 11:12:10.7394 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e4KQIfiNNAazbkiZqTh4Xdr6W87PXMEAj9AwXBa4h+0shUQGwYpgzoCd61yciu7CARre5KUyAfBP1tCZ6nL0Xmy6CTW4Vk8UUZscKuKGzm4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6555
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

--_000_CY8PR11MB774715CCEE33646561110B75F972ACY8PR11MB7747namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

----Original Message-----
From: Hore, Soumyadeep <soumyadeep.hore@intel.com>
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

         /* For timestamp */
         uint64_t time_hw;
+       struct idpf_ptp *ptp;

         enum idpf_rx_func_type rx_func_type;
         enum idpf_tx_func_type tx_func_type;
@@ -173,6 +174,9 @@ struct idpf_vport {
         /* Event from ipf */
         bool link_up;
         uint32_t link_speed;
+
+       /* For PTP */
+       struct idpf_ptp_vport_tx_tstamp_caps *tx_tstamp_caps;
 };

 /* Message type read in virtual channel from PF */ diff --git a/drivers/ne=
t/intel/idpf/idpf_common_virtchnl.c b/drivers/net/intel/idpf/idpf_common_vi=
rtchnl.c
index e927d7415a..f8c487c537 100644
--- a/drivers/net/intel/idpf/idpf_common_virtchnl.c
+++ b/drivers/net/intel/idpf/idpf_common_virtchnl.c
@@ -4,6 +4,7 @@

 #include "idpf_common_virtchnl.h"
 #include "idpf_common_logs.h"
+#include "idpf_ptp.h"

 #include <eal_export.h>

@@ -38,6 +39,24 @@ idpf_vc_clean(struct idpf_adapter *adapter)
         return 0;
 }

+       /* Helper to detect PTP-related mailbox messages */ static inline b=
ool
+idpf_mb_msg_is_ptp(uint32_t op) {
+       switch (op) {
+       case VIRTCHNL2_OP_PTP_GET_VPORT_TX_TSTAMP:
+       case VIRTCHNL2_OP_PTP_GET_DEV_CLK_TIME:
+       case VIRTCHNL2_OP_PTP_GET_CROSS_TIME:
+       case VIRTCHNL2_OP_PTP_SET_DEV_CLK_TIME:
+       case VIRTCHNL2_OP_PTP_ADJ_DEV_CLK_FINE:
+       case VIRTCHNL2_OP_PTP_ADJ_DEV_CLK_TIME:
+       case VIRTCHNL2_OP_PTP_GET_VPORT_TX_TSTAMP_CAPS:
+               return true;
+       default:
+               return false;
+       }
+}
+
 static int
 idpf_send_vc_msg(struct idpf_adapter *adapter, uint32_t op,
                  uint16_t msg_size, uint8_t *msg)
@@ -71,8 +90,16 @@ idpf_send_vc_msg(struct idpf_adapter *adapter, uint32_t =
op,

         memcpy(dma_mem->va, msg, msg_size);

-       ctlq_msg->opcode =3D idpf_mbq_opc_send_msg_to_pf;
-       ctlq_msg->func_id =3D 0;
+       if (adapter->ptp !=3D NULL &&
+           idpf_mb_msg_is_ptp(op) &&
+           adapter->ptp->secondary_mbx.valid) {
+               ctlq_msg->opcode =3D idpf_mbq_opc_send_msg_to_peer_drv;
+               ctlq_msg->func_id =3D adapter->ptp->secondary_mbx.peer_mbx_=
q_id;
+               ctlq_msg->host_id =3D adapter->ptp->secondary_mbx.peer_id;
+       } else {
+               ctlq_msg->opcode =3D idpf_mbq_opc_send_msg_to_pf;
+               ctlq_msg->func_id =3D 0;
+       }
         ctlq_msg->data_len =3D msg_size;
         ctlq_msg->cookie.mbx.chnl_opcode =3D op;
         ctlq_msg->cookie.mbx.chnl_retval =3D VIRTCHNL_STATUS_SUCCESS; diff=
 --git a/drivers/net/intel/idpf/idpf_ptp.c b/drivers/net/intel/idpf/idpf_pt=
p.c
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
+                   uint32_t mailbox)
+{
+       if (adapter->ptp->caps & direct)
+               return IDPF_PTP_DIRECT;
+       else if (adapter->ptp->caps & mailbox)
+               return IDPF_PTP_MAILBOX;
+       else
+               return IDPF_PTP_NONE;
+}
+
+#define IDPF_PTP_ACCESS(adapter, cap) \
+       ((uint8_t)idpf_ptp_get_access((adapter), (cap), (cap##_MB)))
+
+static void
+idpf_ptp_get_features_access(const struct idpf_adapter *adapter) {
+       struct idpf_ptp *ptp =3D adapter->ptp;
+
+       ptp->get_dev_clk_time_access =3D
+               IDPF_PTP_ACCESS(adapter, VIRTCHNL2_CAP_PTP_GET_DEVICE_CLK_T=
IME);
+       ptp->get_cross_tstamp_access =3D
+               IDPF_PTP_ACCESS(adapter, VIRTCHNL2_CAP_PTP_GET_CROSS_TIME);
+       ptp->set_dev_clk_time_access =3D
+               IDPF_PTP_ACCESS(adapter, VIRTCHNL2_CAP_PTP_SET_DEVICE_CLK_T=
IME);
+       ptp->adj_dev_clk_time_access =3D
+               IDPF_PTP_ACCESS(adapter, VIRTCHNL2_CAP_PTP_ADJ_DEVICE_CLK);
+       ptp->tx_tstamp_access =3D
+               IDPF_PTP_ACCESS(adapter, VIRTCHNL2_CAP_PTP_TX_TSTAMPS); }
+
+int
+idpf_ptp_get_caps(struct idpf_adapter *adapter) {
+       struct virtchnl2_ptp_cross_time_reg_offsets cross_tstamp_offsets;
+       struct virtchnl2_ptp_clk_adj_reg_offsets clk_adj_offsets;
+       struct virtchnl2_ptp_get_caps send_ptp_caps_msg =3D {0};
+       struct virtchnl2_ptp_clk_reg_offsets clock_offsets;
+       struct virtchnl2_ptp_get_caps *recv_ptp_caps_msg;
+       struct idpf_cmd_info args =3D {0};
+       struct idpf_ptp_secondary_mbx *scnd_mbx;
+       struct idpf_ptp *ptp =3D adapter->ptp;
+       struct idpf_hw *hw =3D &adapter->hw;
+       enum idpf_ptp_access access_type;
+       int err;
+       uint32_t temp_offset;
+
+       send_ptp_caps_msg.caps =3D CPU_TO_LE32(VIRTCHNL2_CAP_PTP_GET_DEVICE=
_CLK_TIME |
+               VIRTCHNL2_CAP_PTP_GET_DEVICE_CLK_TIME_MB |
+               VIRTCHNL2_CAP_PTP_GET_CROSS_TIME |
+               VIRTCHNL2_CAP_PTP_GET_CROSS_TIME_MB |
+               VIRTCHNL2_CAP_PTP_SET_DEVICE_CLK_TIME |
+               VIRTCHNL2_CAP_PTP_SET_DEVICE_CLK_TIME_MB |
+               VIRTCHNL2_CAP_PTP_ADJ_DEVICE_CLK |
+               VIRTCHNL2_CAP_PTP_ADJ_DEVICE_CLK_MB |
+               VIRTCHNL2_CAP_PTP_TX_TSTAMPS |
+               VIRTCHNL2_CAP_PTP_TX_TSTAMPS_MB);
+
+       args.ops =3D VIRTCHNL2_OP_PTP_GET_CAPS;
+       args.in_args =3D (uint8_t *)&send_ptp_caps_msg;
+       args.in_args_size =3D sizeof(send_ptp_caps_msg);
+       args.out_buffer =3D adapter->mbx_resp;
+       args.out_size =3D sizeof(*recv_ptp_caps_msg);
+
+       err =3D idpf_vc_cmd_execute(adapter, &args);
+       if (err < 0)
+               return err;
+
+       recv_ptp_caps_msg =3D (struct virtchnl2_ptp_get_caps *)args.out_buf=
fer;
+       ptp->caps =3D LE32_TO_CPU(recv_ptp_caps_msg->caps);
+       ptp->base_incval =3D LE64_TO_CPU(recv_ptp_caps_msg->base_incval);
+       ptp->max_adj =3D LE32_TO_CPU(recv_ptp_caps_msg->max_adj);
+
+       scnd_mbx =3D &ptp->secondary_mbx;
+       scnd_mbx->peer_mbx_q_id =3D LE16_TO_CPU(recv_ptp_caps_msg->peer_mbx=
_q_id);
+       scnd_mbx->valid =3D scnd_mbx->peer_mbx_q_id !=3D 0xffff;
+       if (scnd_mbx->valid)
+               scnd_mbx->peer_id =3D recv_ptp_caps_msg->peer_id;
+
+       idpf_ptp_get_features_access(adapter);
+
+       access_type =3D (enum idpf_ptp_access)ptp->get_dev_clk_time_access;
+       if (access_type =3D=3D IDPF_PTP_DIRECT) {
+               clock_offsets =3D recv_ptp_caps_msg->clk_offsets;
+
+               temp_offset =3D LE32_TO_CPU(clock_offsets.dev_clk_ns_l);
+               ptp->dev_clk_regs.dev_clk_ns_l =3D IDPF_PCI_REG_ADDR(hw, te=
mp_offset);
+               temp_offset =3D LE32_TO_CPU(clock_offsets.dev_clk_ns_h);
+               ptp->dev_clk_regs.dev_clk_ns_h =3D IDPF_PCI_REG_ADDR(hw, te=
mp_offset);
+               temp_offset =3D LE32_TO_CPU(clock_offsets.phy_clk_ns_l);
+               ptp->dev_clk_regs.phy_clk_ns_l =3D IDPF_PCI_REG_ADDR(hw, te=
mp_offset);
+               temp_offset =3D LE32_TO_CPU(clock_offsets.phy_clk_ns_h);
+               ptp->dev_clk_regs.phy_clk_ns_h =3D IDPF_PCI_REG_ADDR(hw, te=
mp_offset);
+               temp_offset =3D LE32_TO_CPU(clock_offsets.cmd_sync_trigger)=
;
+               ptp->dev_clk_regs.cmd_sync =3D IDPF_PCI_REG_ADDR(hw, temp_o=
ffset);
+       }
+
+       access_type =3D (enum idpf_ptp_access)ptp->get_cross_tstamp_access;
+       if (access_type =3D=3D IDPF_PTP_DIRECT) {
+               cross_tstamp_offsets =3D recv_ptp_caps_msg->cross_time_offs=
ets;
+
+               temp_offset =3D LE32_TO_CPU(cross_tstamp_offsets.sys_time_n=
s_l);
+               ptp->dev_clk_regs.sys_time_ns_l =3D IDPF_PCI_REG_ADDR(hw, t=
emp_offset);
+               temp_offset =3D LE32_TO_CPU(cross_tstamp_offsets.sys_time_n=
s_h);
+               ptp->dev_clk_regs.sys_time_ns_h =3D IDPF_PCI_REG_ADDR(hw, t=
emp_offset);
+               temp_offset =3D LE32_TO_CPU(cross_tstamp_offsets.cmd_sync_t=
rigger);
+               ptp->dev_clk_regs.cmd_sync =3D IDPF_PCI_REG_ADDR(hw, temp_o=
ffset);
+       }
+
+       access_type =3D (enum idpf_ptp_access)ptp->adj_dev_clk_time_access;
+       if (access_type =3D=3D IDPF_PTP_DIRECT) {
+               clk_adj_offsets =3D recv_ptp_caps_msg->clk_adj_offsets;
+
+               temp_offset =3D LE32_TO_CPU(clk_adj_offsets.dev_clk_cmd_typ=
e);
+               ptp->dev_clk_regs.cmd =3D IDPF_PCI_REG_ADDR(hw, temp_offset=
);
+               temp_offset =3D LE32_TO_CPU(clk_adj_offsets.dev_clk_incval_=
l);
+               ptp->dev_clk_regs.incval_l =3D IDPF_PCI_REG_ADDR(hw, temp_o=
ffset);
+               temp_offset =3D LE32_TO_CPU(clk_adj_offsets.dev_clk_incval_=
h);
+               ptp->dev_clk_regs.incval_h =3D IDPF_PCI_REG_ADDR(hw, temp_o=
ffset);
+               temp_offset =3D LE32_TO_CPU(clk_adj_offsets.dev_clk_shadj_l=
);
+               ptp->dev_clk_regs.shadj_l =3D IDPF_PCI_REG_ADDR(hw, temp_of=
fset);
+               temp_offset =3D LE32_TO_CPU(clk_adj_offsets.dev_clk_shadj_h=
);
+               ptp->dev_clk_regs.shadj_h =3D IDPF_PCI_REG_ADDR(hw, temp_of=
fset);
+
+               temp_offset =3D LE32_TO_CPU(clk_adj_offsets.phy_clk_cmd_typ=
e);
+               ptp->dev_clk_regs.phy_cmd =3D IDPF_PCI_REG_ADDR(hw, temp_of=
fset);
+               temp_offset =3D LE32_TO_CPU(clk_adj_offsets.phy_clk_incval_=
l);
+               ptp->dev_clk_regs.phy_incval_l =3D IDPF_PCI_REG_ADDR(hw, te=
mp_offset);
+               temp_offset =3D LE32_TO_CPU(clk_adj_offsets.phy_clk_incval_=
h);
+               ptp->dev_clk_regs.phy_incval_h =3D IDPF_PCI_REG_ADDR(hw, te=
mp_offset);
+               temp_offset =3D LE32_TO_CPU(clk_adj_offsets.phy_clk_shadj_l=
);
+               ptp->dev_clk_regs.phy_shadj_l =3D IDPF_PCI_REG_ADDR(hw, tem=
p_offset);
+               temp_offset =3D LE32_TO_CPU(clk_adj_offsets.phy_clk_shadj_h=
);
+               ptp->dev_clk_regs.phy_shadj_h =3D IDPF_PCI_REG_ADDR(hw, tem=
p_offset);
+       }
+
+       return err;
+}
+
+static void
+idpf_ptp_enable_shtime(struct idpf_adapter *adapter) {
+       uint32_t shtime_enable, exec_cmd;
+
+       shtime_enable =3D adapter->ptp->cmd.shtime_enable_mask;
+       exec_cmd =3D adapter->ptp->cmd.exec_cmd_mask;
+
+       IDPF_PCI_REG_WRITE(adapter->ptp->dev_clk_regs.cmd_sync, shtime_enab=
le);
+       IDPF_PCI_REG_WRITE(adapter->ptp->dev_clk_regs.cmd_sync,
+                         exec_cmd | shtime_enable);
+}
+
+int
+idpf_ptp_get_dev_clk_time(struct idpf_adapter *adapter,
+                         struct idpf_ptp_dev_timers *dev_clk_time) {
+       struct virtchnl2_ptp_get_dev_clk_time get_dev_clk_time_msg =3D {0};
+       struct idpf_cmd_info args =3D {0};
+       int err;
+       uint64_t dev_time;
+
+       args.ops =3D VIRTCHNL2_OP_PTP_GET_DEV_CLK_TIME;
+       args.in_args =3D (uint8_t *)&get_dev_clk_time_msg;
+       args.in_args_size =3D sizeof(get_dev_clk_time_msg);
+       args.out_buffer =3D adapter->mbx_resp;
+       args.out_size =3D sizeof(get_dev_clk_time_msg);
+
+       err =3D idpf_vc_cmd_execute(adapter, &args);
+       if (err < 0)
+               return err;
+
+       get_dev_clk_time_msg =3D
+               *(struct virtchnl2_ptp_get_dev_clk_time *)args.out_buffer;
+       dev_time =3D LE64_TO_CPU(get_dev_clk_time_msg.dev_time_ns);
+       dev_clk_time->dev_clk_time_ns =3D dev_time;
+
+       return err;
+}
+
+int
+idpf_ptp_get_cross_time(struct idpf_adapter *adapter,
+                        struct idpf_ptp_dev_timers *cross_time) {
+       struct virtchnl2_ptp_get_cross_time cross_time_msg =3D {0};
+       struct idpf_cmd_info args =3D {0};
+       int err;
+
+       args.ops =3D VIRTCHNL2_OP_PTP_GET_CROSS_TIME;
+       args.in_args =3D (uint8_t *)&cross_time_msg;
+       args.in_args_size =3D sizeof(cross_time_msg);
+       args.out_buffer =3D adapter->mbx_resp;
+       args.out_size =3D sizeof(cross_time_msg);
+
+       err =3D idpf_vc_cmd_execute(adapter, &args);
+       if (err < 0)
+               return err;
+
+       cross_time_msg =3D
+               *(struct virtchnl2_ptp_get_cross_time *)args.out_buffer;
+       cross_time->dev_clk_time_ns =3D LE64_TO_CPU(cross_time_msg.dev_time=
_ns);
+       cross_time->sys_time_ns =3D LE64_TO_CPU(cross_time_msg.sys_time_ns)=
;
+
+       return err;
+}
+
+int
+idpf_ptp_set_dev_clk_time(struct idpf_adapter *adapter, uint64_t time)
+{
+       struct virtchnl2_ptp_set_dev_clk_time set_dev_clk_time_msg =3D {0};
+       struct idpf_cmd_info args =3D {0};
+       int err;
+
+       set_dev_clk_time_msg.dev_time_ns =3D CPU_TO_LE64(time);
+
+       args.ops =3D VIRTCHNL2_OP_PTP_SET_DEV_CLK_TIME;
+       args.in_args =3D (uint8_t *)&set_dev_clk_time_msg;
+       args.in_args_size =3D sizeof(set_dev_clk_time_msg);
+       args.out_buffer =3D adapter->mbx_resp;
+       args.out_size =3D sizeof(set_dev_clk_time_msg);
+
+       err =3D idpf_vc_cmd_execute(adapter, &args);
+       if (err < 0)
+               return err;
+
+       return err;
+}
+
+int
+idpf_ptp_adj_dev_clk_time(struct idpf_adapter *adapter, int64_t delta)
+{
+       struct virtchnl2_ptp_adj_dev_clk_time adj_dev_clk_time_msg =3D {0};
+       struct idpf_cmd_info args =3D {0};
+       int err;
+
+       adj_dev_clk_time_msg.delta =3D CPU_TO_LE64(delta);
+
+       args.ops =3D VIRTCHNL2_OP_PTP_ADJ_DEV_CLK_TIME;
+       args.in_args =3D (uint8_t *)&adj_dev_clk_time_msg;
+       args.in_args_size =3D sizeof(adj_dev_clk_time_msg);
+       args.out_buffer =3D adapter->mbx_resp;
+       args.out_size =3D sizeof(adj_dev_clk_time_msg);
+
+       err =3D idpf_vc_cmd_execute(adapter, &args);
+       if (err < 0)
+               return err;
+
+       return err;
+}
+
+int
+idpf_ptp_adj_dev_clk_fine(struct idpf_adapter *adapter, uint64_t
+incval) {
+       struct virtchnl2_ptp_adj_dev_clk_fine adj_dev_clk_fine_msg =3D {0};
+       struct idpf_cmd_info args =3D {0};
+       int err;
+
+       adj_dev_clk_fine_msg.incval =3D CPU_TO_LE64(incval);
+
+       args.ops =3D VIRTCHNL2_OP_PTP_ADJ_DEV_CLK_FINE;
+       args.in_args =3D (uint8_t *)&adj_dev_clk_fine_msg;
+       args.in_args_size =3D sizeof(adj_dev_clk_fine_msg);
+       args.out_buffer =3D adapter->mbx_resp;
+       args.out_size =3D sizeof(adj_dev_clk_fine_msg);
+
+       err =3D idpf_vc_cmd_execute(adapter, &args);
+       if (err < 0)
+               return err;
+
+       return err;
+}
+
+int
+idpf_ptp_get_vport_tstamps_caps(struct idpf_vport *vport) {
+       struct virtchnl2_ptp_get_vport_tx_tstamp_caps send_tx_tstamp_caps =
=3D {0};
+       struct virtchnl2_ptp_get_vport_tx_tstamp_caps *rcv_tx_tstamp_caps;
+       struct virtchnl2_ptp_tx_tstamp_latch_caps tx_tstamp_latch_caps;
+       enum idpf_ptp_access tstamp_access, get_dev_clk_access;
+       struct idpf_ptp_vport_tx_tstamp_caps *tstamp_caps;
+       struct idpf_ptp *ptp =3D vport->adapter->ptp;
+       struct idpf_cmd_info args =3D {0};
+       int err;
+       uint16_t num_latches, i;
Instead of using i, Can we use something like latch_itr ?
+       uint32_t size;
+
+       if (ptp =3D=3D NULL)
+               return -EOPNOTSUPP;
+
+       tstamp_access =3D (enum idpf_ptp_access)ptp->tx_tstamp_access;
+       get_dev_clk_access =3D (enum idpf_ptp_access)ptp->get_dev_clk_time_=
access;
+       if (tstamp_access =3D=3D IDPF_PTP_NONE ||
+           get_dev_clk_access =3D=3D IDPF_PTP_NONE)
+               return -EOPNOTSUPP;
+
+       send_tx_tstamp_caps.vport_id =3D CPU_TO_LE32(vport->vport_id);
+
+       args.ops =3D VIRTCHNL2_OP_PTP_GET_VPORT_TX_TSTAMP_CAPS;
+       args.in_args =3D (uint8_t *)&send_tx_tstamp_caps;
+       args.in_args_size =3D sizeof(send_tx_tstamp_caps);
+       args.out_size =3D IDPF_CTLQ_MAX_BUF_LEN;
+       args.out_buffer =3D vport->adapter->mbx_resp;
+
+       err =3D idpf_vc_cmd_execute(vport->adapter, &args);
+       if (err < 0)
+               return err;
+
+       rcv_tx_tstamp_caps =3D
+               (struct virtchnl2_ptp_get_vport_tx_tstamp_caps *)args.out_b=
uffer;
+       num_latches =3D LE16_TO_CPU(rcv_tx_tstamp_caps->num_latches);
+       size =3D sizeof(struct idpf_ptp_vport_tx_tstamp_caps) +
+               sizeof(struct idpf_ptp_tx_tstamp) * num_latches;
+       tstamp_caps =3D rte_zmalloc(NULL, size, 0);
+       if (tstamp_caps =3D=3D NULL)
+               return -ENOMEM;
+
+       tstamp_caps->access =3D true;
+       tstamp_caps->num_entries =3D num_latches;
+       tstamp_caps->tstamp_ns_lo_bit =3D rcv_tx_tstamp_caps->tstamp_ns_lo_=
bit;
+
+       for (i =3D 0; i < tstamp_caps->num_entries; i++) {
+               __le32 offset_l, offset_h;
+
+               tx_tstamp_latch_caps =3D rcv_tx_tstamp_caps->tstamp_latches=
[i];
+
+               if (tstamp_access =3D=3D IDPF_PTP_DIRECT) {
+                       offset_l =3D tx_tstamp_latch_caps.tx_latch_reg_offs=
et_l;
+                       offset_h =3D tx_tstamp_latch_caps.tx_latch_reg_offs=
et_h;
+                       tstamp_caps->tx_tstamp[i].tx_latch_reg_offset_l =3D
+                               LE32_TO_CPU(offset_l);
+                       tstamp_caps->tx_tstamp[i].tx_latch_reg_offset_h =3D
+                               LE32_TO_CPU(offset_h);
+               }
+               tstamp_caps->tx_tstamp[i].idx =3D tx_tstamp_latch_caps.inde=
x;
+       }
+
+       tstamp_caps->latched_idx =3D -1;
+       vport->tx_tstamp_caps =3D tstamp_caps;
+
+       return err;
+}
+
+static int
+idpf_ptp_get_tstamp_value(struct idpf_vport *vport,
+                        struct virtchnl2_ptp_tx_tstamp_latch *tstamp_latch=
,
+                        struct idpf_ptp_tx_tstamp *tx_tstamp) {
+       struct idpf_ptp_vport_tx_tstamp_caps *tx_tstamp_caps;
+       uint8_t tstamp_ns_lo_bit;
+
+       tx_tstamp_caps =3D vport->tx_tstamp_caps;
+       tstamp_ns_lo_bit =3D tx_tstamp_caps->tstamp_ns_lo_bit;
+
+       tx_tstamp->tstamp =3D LE64_TO_CPU(tstamp_latch->tstamp);
+       tx_tstamp->tstamp >>=3D tstamp_ns_lo_bit;
+
+       return 0;
+}
+
+int
+idpf_ptp_get_tx_tstamp(struct idpf_vport *vport) {
+       struct virtchnl2_ptp_get_vport_tx_tstamp_latches *send_tx_tstamp_ms=
g;
+       struct virtchnl2_ptp_get_vport_tx_tstamp_latches *recv_tx_tstamp_ms=
g;
+       struct idpf_ptp_vport_tx_tstamp_caps *tx_tstamp_caps;
+       struct virtchnl2_ptp_tx_tstamp_latch tstamp_latch;
+       struct idpf_ptp_tx_tstamp *ptp_tx_tstamp;
+       struct idpf_cmd_info args =3D {0};
+       int size, msg_size;
+       uint32_t vport_id;
+       uint16_t num_latches, id;
Instead of using id, Can we use something like latch_itr ?

I am keeping it uniform and cheanging it to idx across the code as followed=
 in previous developments

+       int err;
+
+       tx_tstamp_caps =3D vport->tx_tstamp_caps;
+       ptp_tx_tstamp =3D tx_tstamp_caps->tx_tstamp;
+
+       size =3D sizeof(struct virtchnl2_ptp_get_vport_tx_tstamp_latches) +
+               sizeof(struct virtchnl2_ptp_tx_tstamp_latch) *
+               tx_tstamp_caps->num_entries;
+       send_tx_tstamp_msg =3D rte_zmalloc(NULL, size, 0);
+       if (send_tx_tstamp_msg =3D=3D NULL)
+               return -ENOMEM;
+
+       for (id =3D 0; id < tx_tstamp_caps->num_entries; id++, ptp_tx_tstam=
p++)
+               send_tx_tstamp_msg->tstamp_latches[id].index =3D ptp_tx_tst=
amp->idx;
+       send_tx_tstamp_msg->get_devtime_with_txtstmp =3D 1;
+
+       msg_size =3D sizeof(struct virtchnl2_ptp_get_vport_tx_tstamp_latche=
s) +
+               sizeof(struct virtchnl2_ptp_tx_tstamp_latch) * id;
+       send_tx_tstamp_msg->vport_id =3D CPU_TO_LE32(vport->vport_id);
+       send_tx_tstamp_msg->num_latches =3D CPU_TO_LE16(id);
+
+       args.ops =3D VIRTCHNL2_OP_PTP_GET_VPORT_TX_TSTAMP;
+       args.in_args =3D (uint8_t *)send_tx_tstamp_msg;
+       args.in_args_size =3D msg_size;
+       args.out_size =3D msg_size;
+       args.out_buffer =3D vport->adapter->mbx_resp;
+
+       err =3D idpf_vc_cmd_execute(vport->adapter, &args);
+       rte_free(send_tx_tstamp_msg);
+       if (err < 0)
+               return err;
+
+       recv_tx_tstamp_msg =3D
+               (struct virtchnl2_ptp_get_vport_tx_tstamp_latches *)args.ou=
t_buffer;
+       vport_id =3D LE32_TO_CPU(recv_tx_tstamp_msg->vport_id);
+       if (vport->vport_id !=3D vport_id)
+               return -EINVAL;
+
+       num_latches =3D LE16_TO_CPU(recv_tx_tstamp_msg->num_latches);
+
+       ptp_tx_tstamp =3D tx_tstamp_caps->tx_tstamp;
+       for (id =3D 0; id < num_latches; id++, ptp_tx_tstamp++) {
+               tstamp_latch =3D recv_tx_tstamp_msg->tstamp_latches[id];
+
+               if (!tstamp_latch.valid)
+                       continue;
+
+               err =3D idpf_ptp_get_tstamp_value(vport, &tstamp_latch,
+                                               ptp_tx_tstamp);
+               if (err =3D=3D 0) {
+                       tx_tstamp_caps->latched_idx =3D id;
+                       vport->adapter->time_hw =3D recv_tx_tstamp_msg->dev=
ice_time;
+               }
+               break;
+       }
+
+       return err;
+}
+
+/**
+ * idpf_ptp_read_src_clk_reg_direct - Read directly the main timer
+value
+ * @adapter: Driver specific private structure
+ * @src_clk: Returned main timer value in nanoseconds unit
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int
+idpf_ptp_read_src_clk_reg_direct(struct idpf_adapter *adapter, uint64_t
+*src_clk) {
+       struct idpf_ptp *ptp =3D adapter->ptp;
+       uint32_t hi, lo;
+
+       idpf_ptp_enable_shtime(adapter);
+
+       lo =3D IDPF_PCI_REG(ptp->dev_clk_regs.dev_clk_ns_l);
+       hi =3D IDPF_PCI_REG(ptp->dev_clk_regs.dev_clk_ns_h);
+
+       *src_clk =3D ((uint64_t)hi << 32) | lo;
+       return 0;
+}
+
+/**
+ * idpf_ptp_read_src_clk_reg_mailbox - Read the main timer value
+through mailbox
+ * @adapter: Driver specific private structure
+ * @src_clk: Returned main timer value in nanoseconds unit
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int
+idpf_ptp_read_src_clk_reg_mailbox(struct idpf_adapter *adapter,
+                                           uint64_t *src_clk)
+{
+       struct idpf_ptp_dev_timers clk_time;
+       int err;
+
+       err =3D idpf_ptp_get_dev_clk_time(adapter, &clk_time);
+       if (err)
+               return err;
+
+       *src_clk =3D clk_time.dev_clk_time_ns;
+       return 0;
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
+idpf_ptp_read_src_clk_reg(struct idpf_adapter *adapter, uint64_t
+*src_clk) {
+       if (adapter->ptp =3D=3D NULL)
+               return -EINVAL;
+
+       switch ((enum idpf_ptp_access)adapter->ptp->get_dev_clk_time_access=
) {
+       case IDPF_PTP_MAILBOX:
+               return idpf_ptp_read_src_clk_reg_mailbox(adapter, src_clk);
+       case IDPF_PTP_DIRECT:
+               return idpf_ptp_read_src_clk_reg_direct(adapter, src_clk);
+       default:
+               return -EOPNOTSUPP;
+       }
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
+       uint32_t exec_cmd_mask;
+       uint32_t shtime_enable_mask;
+};
+
+struct idpf_ptp_dev_clk_regs {
+       volatile uint32_t *dev_clk_ns_l;
+       volatile uint32_t *dev_clk_ns_h;
+       volatile uint32_t *phy_clk_ns_l;
+       volatile uint32_t *phy_clk_ns_h;
+       volatile uint32_t *sys_time_ns_l;
+       volatile uint32_t *sys_time_ns_h;
+       volatile uint32_t *incval_l;
+       volatile uint32_t *incval_h;
+       volatile uint32_t *shadj_l;
+       volatile uint32_t *shadj_h;
+       volatile uint32_t *phy_incval_l;
+       volatile uint32_t *phy_incval_h;
+       volatile uint32_t *phy_shadj_l;
+       volatile uint32_t *phy_shadj_h;
+       volatile uint32_t *cmd;
+       volatile uint32_t *phy_cmd;
+       volatile uint32_t *cmd_sync;
+};
+
+enum idpf_ptp_access {
+       IDPF_PTP_NONE =3D 0,
+       IDPF_PTP_DIRECT,
+       IDPF_PTP_MAILBOX,
+};
+
+struct idpf_ptp_secondary_mbx {
+       uint16_t peer_mbx_q_id;
+       uint16_t peer_id;
+       bool valid:1;
+};
+
+enum idpf_ptp_tx_tstamp_state {
+       IDPF_PTP_FREE,
+       IDPF_PTP_REQUEST,
+       IDPF_PTP_READ_VALUE,
+};
+
+struct idpf_ptp_tx_tstamp {
+       uint64_t tstamp;
+       uint32_t tx_latch_reg_offset_l;
+       uint32_t tx_latch_reg_offset_h;
+       uint32_t idx;
+};
+
+struct idpf_ptp_vport_tx_tstamp_caps {
+       uint32_t vport_id;
+       uint16_t num_entries;
+       uint16_t tstamp_ns_lo_bit;
+       uint16_t latched_idx;
+       bool access:1;
+       struct idpf_ptp_tx_tstamp tx_tstamp[]; };
+
+struct idpf_ptp {
+       uint64_t base_incval;
+       uint64_t max_adj;
+       struct idpf_ptp_cmd cmd;
+       struct idpf_ptp_dev_clk_regs dev_clk_regs;
+       uint32_t caps;
+       uint8_t get_dev_clk_time_access:2;
+       uint8_t get_cross_tstamp_access:2;
+       uint8_t set_dev_clk_time_access:2;
+       uint8_t adj_dev_clk_time_access:2;
+       uint8_t tx_tstamp_access:2;
+       uint8_t rsv:6;
+       struct idpf_ptp_secondary_mbx secondary_mbx; };
+
+struct idpf_ptp_dev_timers {
+       uint64_t sys_time_ns;
+       uint64_t dev_clk_time_ns;
+};
+
+int idpf_ptp_get_caps(struct idpf_adapter *adapter); int
+idpf_ptp_read_src_clk_reg(struct idpf_adapter *adapter, uint64_t
+*src_clk); int idpf_ptp_get_dev_clk_time(struct idpf_adapter *adapter,
+                            struct idpf_ptp_dev_timers *dev_clk_time); int
+idpf_ptp_get_cross_time(struct idpf_adapter *adapter,
+                           struct idpf_ptp_dev_timers *cross_time); int
+idpf_ptp_set_dev_clk_time(struct idpf_adapter *adapter, uint64_t time);
+int idpf_ptp_adj_dev_clk_fine(struct idpf_adapter *adapter, uint64_t
+incval); int idpf_ptp_adj_dev_clk_time(struct idpf_adapter *adapter,
+int64_t delta); int idpf_ptp_get_vport_tstamps_caps(struct idpf_vport
+*vport); int idpf_ptp_get_tx_tstamp(struct idpf_vport *vport);
+
+static inline uint64_t
+idpf_tstamp_convert_32b_64b(struct idpf_adapter *ad, uint32_t flag,
+                           bool is_rx, uint32_t in_timestamp) {
+       const uint64_t mask =3D 0xFFFFFFFFULL;
+       uint32_t phc_time_lo, delta;
+       uint64_t ns;
+
+       if (flag !=3D 0)
+               idpf_ptp_read_src_clk_reg(ad, &ad->time_hw);
+
+       phc_time_lo =3D (uint32_t)(ad->time_hw);
+       delta =3D in_timestamp - phc_time_lo;
+
+       if (delta > mask / 2) {
+               delta =3D phc_time_lo - in_timestamp;
+               ns =3D ad->time_hw - delta;
+       } else {
+               if (is_rx)
+                       ns =3D ad->time_hw - delta;
+               else
+                       ns =3D ad->time_hw + delta;
+       }
+
+       return ns;
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

         'idpf_ethdev.c',
+        'idpf_ptp.c',
         'idpf_rxtx.c',
 )

--
2.47.1


--_000_CY8PR11MB774715CCEE33646561110B75F972ACY8PR11MB7747namp_
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
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"font-family: Calibri, sans-serif; font-size: 11pt; color: rg=
b(0, 0, 0);">----Original Message-----</span><span style=3D"font-size: 11pt=
;"><br>
From: Hore, Soumyadeep &lt;soumyadeep.hore@intel.com&gt;<br>
Sent: 15 February 2026 01:19 AM<br>
To: dev@dpdk.org; Richardson, Bruce &lt;bruce.richardson@intel.com&gt;<br>
Cc: Kumar, Rajesh3 &lt;rajesh3.kumar@intel.com&gt;; Singh, Aman Deep &lt;am=
an.deep.singh@intel.com&gt;; Subbarao, Manoj Kumar &lt;manoj.kumar.subbarao=
@intel.com&gt;<br>
Subject: [PATCH v6 2/4] net/idpf: add PTP virtchnl2 support<br>
<br>
Add a new file - idpf_ptp - to handle PTP virtchnl messages.<br>
Keep the registers addresses in the PTP struct.<br>
<br>
Signed-off-by: Soumyadeep Hore &lt;soumyadeep.hore@intel.com&gt;<br>
---<br>
&nbsp;drivers/net/intel/idpf/idpf_common_device.h&nbsp;&nbsp; |&nbsp;&nbsp;=
 4 +<br>
&nbsp;drivers/net/intel/idpf/idpf_common_virtchnl.c |&nbsp; 31 +-<br>
&nbsp;drivers/net/intel/idpf/idpf_ptp.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 504 ++++++++++++++++++<br>
&nbsp;drivers/net/intel/idpf/idpf_ptp.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 130 +++++<br>
&nbsp;drivers/net/intel/idpf/meson.build&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 1 +<br>
&nbsp;5 files changed, 668 insertions(+), 2 deletions(-)&nbsp; create mode =
100644 drivers/net/intel/idpf/idpf_ptp.c&nbsp; create mode 100644 drivers/n=
et/intel/idpf/idpf_ptp.h<br>
<br>
diff --git a/drivers/net/intel/idpf/idpf_common_device.h b/drivers/net/inte=
l/idpf/idpf_common_device.h<br>
index 31915a03d4..e45795c18b 100644<br>
--- a/drivers/net/intel/idpf/idpf_common_device.h<br>
+++ b/drivers/net/intel/idpf/idpf_common_device.h<br>
@@ -103,6 +103,7 @@ struct idpf_adapter {<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* For timestamp */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t time_hw;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct idpf_ptp *ptp;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum idpf_rx_func_type rx_=
func_type;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum idpf_tx_func_type tx_=
func_type;<br>
@@ -173,6 +174,9 @@ struct idpf_vport {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Event from ipf */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool link_up;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t link_speed;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* For PTP */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct idpf_ptp_vport_tx_tstamp_caps =
*tx_tstamp_caps;<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;/* Message type read in virtual channel from PF */ diff --git a/drive=
rs/net/intel/idpf/idpf_common_virtchnl.c b/drivers/net/intel/idpf/idpf_comm=
on_virtchnl.c<br>
index e927d7415a..f8c487c537 100644<br>
--- a/drivers/net/intel/idpf/idpf_common_virtchnl.c<br>
+++ b/drivers/net/intel/idpf/idpf_common_virtchnl.c<br>
@@ -4,6 +4,7 @@<br>
&nbsp;<br>
&nbsp;#include &quot;idpf_common_virtchnl.h&quot;<br>
&nbsp;#include &quot;idpf_common_logs.h&quot;<br>
+#include &quot;idpf_ptp.h&quot;<br>
&nbsp;<br>
&nbsp;#include &lt;eal_export.h&gt;<br>
&nbsp;<br>
@@ -38,6 +39,24 @@ idpf_vc_clean(struct idpf_adapter *adapter)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Helper to detect PTP-related mailb=
ox messages */ static inline bool<br>
+idpf_mb_msg_is_ptp(uint32_t op) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (op) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case VIRTCHNL2_OP_PTP_GET_VPORT_TX_TS=
TAMP:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case VIRTCHNL2_OP_PTP_GET_DEV_CLK_TIM=
E:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case VIRTCHNL2_OP_PTP_GET_CROSS_TIME:=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case VIRTCHNL2_OP_PTP_SET_DEV_CLK_TIM=
E:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case VIRTCHNL2_OP_PTP_ADJ_DEV_CLK_FIN=
E:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case VIRTCHNL2_OP_PTP_ADJ_DEV_CLK_TIM=
E:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case VIRTCHNL2_OP_PTP_GET_VPORT_TX_TS=
TAMP_CAPS:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return true;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return false;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+}<br>
+<br>
&nbsp;static int<br>
&nbsp;idpf_send_vc_msg(struct idpf_adapter *adapter, uint32_t op,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t msg_size, uint8_t *msg)<br>
@@ -71,8 +90,16 @@ idpf_send_vc_msg(struct idpf_adapter *adapter, uint32_t =
op,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(dma_mem-&gt;va, msg=
, msg_size);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctlq_msg-&gt;opcode =3D idpf_mbq_opc_=
send_msg_to_pf;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctlq_msg-&gt;func_id =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adapter-&gt;ptp !=3D NULL &amp;&a=
mp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; idpf_mb_msg_i=
s_ptp(op) &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adapter-&gt;p=
tp-&gt;secondary_mbx.valid) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ctlq_msg-&gt;opcode =3D idpf_mbq_opc_send_msg_to_peer_drv;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ctlq_msg-&gt;func_id =3D adapter-&gt;ptp-&gt;secondary_mbx.peer_=
mbx_q_id;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ctlq_msg-&gt;host_id =3D adapter-&gt;ptp-&gt;secondary_mbx.peer_=
id;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ctlq_msg-&gt;opcode =3D idpf_mbq_opc_send_msg_to_pf;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ctlq_msg-&gt;func_id =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctlq_msg-&gt;data_len =3D =
msg_size;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctlq_msg-&gt;cookie.mbx.ch=
nl_opcode =3D op;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctlq_msg-&gt;cookie.mbx.ch=
nl_retval =3D VIRTCHNL_STATUS_SUCCESS; diff --git a/drivers/net/intel/idpf/=
idpf_ptp.c b/drivers/net/intel/idpf/idpf_ptp.c<br>
new file mode 100644<br>
index 0000000000..aefd1309f7<br>
--- /dev/null<br>
+++ b/drivers/net/intel/idpf/idpf_ptp.c<br>
@@ -0,0 +1,504 @@<br>
+/* SPDX-License-Identifier: BSD-3-Clause<br>
+ * Copyright(c) 2025 Intel Corporation<br>
+ */<br>
+<br>
+#include &quot;idpf_ptp.h&quot;<br>
+#include &quot;idpf_common_virtchnl.h&quot;<br>
+#include &quot;base/virtchnl2.h&quot;<br>
+<br>
+static enum idpf_ptp_access<br>
+idpf_ptp_get_access(const struct idpf_adapter *adapter, uint32_t direct,<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mailbox)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adapter-&gt;ptp-&gt;caps &amp; di=
rect)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return IDPF_PTP_DIRECT;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (adapter-&gt;ptp-&gt;caps &am=
p; mailbox)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return IDPF_PTP_MAILBOX;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return IDPF_PTP_NONE;<br>
+}<br>
+<br>
+#define IDPF_PTP_ACCESS(adapter, cap) \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((uint8_t)idpf_ptp_get_access((adapte=
r), (cap), (cap##_MB)))<br>
+<br>
+static void<br>
+idpf_ptp_get_features_access(const struct idpf_adapter *adapter) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct idpf_ptp *ptp =3D adapter-&gt;=
ptp;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ptp-&gt;get_dev_clk_time_access =3D<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; IDPF_PTP_ACCESS(adapter, VIRTCHNL2_CAP_PTP_GET_DEVICE_CLK_TIME);=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ptp-&gt;get_cross_tstamp_access =3D<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; IDPF_PTP_ACCESS(adapter, VIRTCHNL2_CAP_PTP_GET_CROSS_TIME);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ptp-&gt;set_dev_clk_time_access =3D<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; IDPF_PTP_ACCESS(adapter, VIRTCHNL2_CAP_PTP_SET_DEVICE_CLK_TIME);=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ptp-&gt;adj_dev_clk_time_access =3D<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; IDPF_PTP_ACCESS(adapter, VIRTCHNL2_CAP_PTP_ADJ_DEVICE_CLK);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ptp-&gt;tx_tstamp_access =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; IDPF_PTP_ACCESS(adapter, VIRTCHNL2_CAP_PTP_TX_TSTAMPS); }<br>
+<br>
+int<br>
+idpf_ptp_get_caps(struct idpf_adapter *adapter) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct virtchnl2_ptp_cross_time_reg_o=
ffsets cross_tstamp_offsets;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct virtchnl2_ptp_clk_adj_reg_offs=
ets clk_adj_offsets;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct virtchnl2_ptp_get_caps send_pt=
p_caps_msg =3D {0};<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct virtchnl2_ptp_clk_reg_offsets =
clock_offsets;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct virtchnl2_ptp_get_caps *recv_p=
tp_caps_msg;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct idpf_cmd_info args =3D {0};<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct idpf_ptp_secondary_mbx *scnd_m=
bx;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct idpf_ptp *ptp =3D adapter-&gt;=
ptp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct idpf_hw *hw =3D &amp;adapter-&=
gt;hw;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum idpf_ptp_access access_type;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int err;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t temp_offset;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; send_ptp_caps_msg.caps =3D CPU_TO_LE3=
2(VIRTCHNL2_CAP_PTP_GET_DEVICE_CLK_TIME |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; VIRTCHNL2_CAP_PTP_GET_DEVICE_CLK_TIME_MB |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; VIRTCHNL2_CAP_PTP_GET_CROSS_TIME |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; VIRTCHNL2_CAP_PTP_GET_CROSS_TIME_MB |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; VIRTCHNL2_CAP_PTP_SET_DEVICE_CLK_TIME |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; VIRTCHNL2_CAP_PTP_SET_DEVICE_CLK_TIME_MB |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; VIRTCHNL2_CAP_PTP_ADJ_DEVICE_CLK |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; VIRTCHNL2_CAP_PTP_ADJ_DEVICE_CLK_MB |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; VIRTCHNL2_CAP_PTP_TX_TSTAMPS |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; VIRTCHNL2_CAP_PTP_TX_TSTAMPS_MB);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args.ops =3D VIRTCHNL2_OP_PTP_GET_CAP=
S;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args.in_args =3D (uint8_t *)&amp;send=
_ptp_caps_msg;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args.in_args_size =3D sizeof(send_ptp=
_caps_msg);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args.out_buffer =3D adapter-&gt;mbx_r=
esp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args.out_size =3D sizeof(*recv_ptp_ca=
ps_msg);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D idpf_vc_cmd_execute(adapter, =
&amp;args);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (err &lt; 0)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return err;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; recv_ptp_caps_msg =3D (struct virtchn=
l2_ptp_get_caps *)args.out_buffer;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ptp-&gt;caps =3D LE32_TO_CPU(recv_ptp=
_caps_msg-&gt;caps);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ptp-&gt;base_incval =3D LE64_TO_CPU(r=
ecv_ptp_caps_msg-&gt;base_incval);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ptp-&gt;max_adj =3D LE32_TO_CPU(recv_=
ptp_caps_msg-&gt;max_adj);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; scnd_mbx =3D &amp;ptp-&gt;secondary_m=
bx;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; scnd_mbx-&gt;peer_mbx_q_id =3D LE16_T=
O_CPU(recv_ptp_caps_msg-&gt;peer_mbx_q_id);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; scnd_mbx-&gt;valid =3D scnd_mbx-&gt;p=
eer_mbx_q_id !=3D 0xffff;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (scnd_mbx-&gt;valid)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; scnd_mbx-&gt;peer_id =3D recv_ptp_caps_msg-&gt;peer_id;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; idpf_ptp_get_features_access(adapter)=
;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; access_type =3D (enum idpf_ptp_access=
)ptp-&gt;get_dev_clk_time_access;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (access_type =3D=3D IDPF_PTP_DIREC=
T) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; clock_offsets =3D recv_ptp_caps_msg-&gt;clk_offsets;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; temp_offset =3D LE32_TO_CPU(clock_offsets.dev_clk_ns_l);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ptp-&gt;dev_clk_regs.dev_clk_ns_l =3D IDPF_PCI_REG_ADDR(hw, temp=
_offset);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; temp_offset =3D LE32_TO_CPU(clock_offsets.dev_clk_ns_h);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ptp-&gt;dev_clk_regs.dev_clk_ns_h =3D IDPF_PCI_REG_ADDR(hw, temp=
_offset);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; temp_offset =3D LE32_TO_CPU(clock_offsets.phy_clk_ns_l);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ptp-&gt;dev_clk_regs.phy_clk_ns_l =3D IDPF_PCI_REG_ADDR(hw, temp=
_offset);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; temp_offset =3D LE32_TO_CPU(clock_offsets.phy_clk_ns_h);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ptp-&gt;dev_clk_regs.phy_clk_ns_h =3D IDPF_PCI_REG_ADDR(hw, temp=
_offset);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; temp_offset =3D LE32_TO_CPU(clock_offsets.cmd_sync_trigger);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ptp-&gt;dev_clk_regs.cmd_sync =3D IDPF_PCI_REG_ADDR(hw, temp_off=
set);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; access_type =3D (enum idpf_ptp_access=
)ptp-&gt;get_cross_tstamp_access;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (access_type =3D=3D IDPF_PTP_DIREC=
T) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; cross_tstamp_offsets =3D recv_ptp_caps_msg-&gt;cross_time_offset=
s;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; temp_offset =3D LE32_TO_CPU(cross_tstamp_offsets.sys_time_ns_l);=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ptp-&gt;dev_clk_regs.sys_time_ns_l =3D IDPF_PCI_REG_ADDR(hw, tem=
p_offset);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; temp_offset =3D LE32_TO_CPU(cross_tstamp_offsets.sys_time_ns_h);=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ptp-&gt;dev_clk_regs.sys_time_ns_h =3D IDPF_PCI_REG_ADDR(hw, tem=
p_offset);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; temp_offset =3D LE32_TO_CPU(cross_tstamp_offsets.cmd_sync_trigge=
r);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ptp-&gt;dev_clk_regs.cmd_sync =3D IDPF_PCI_REG_ADDR(hw, temp_off=
set);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; access_type =3D (enum idpf_ptp_access=
)ptp-&gt;adj_dev_clk_time_access;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (access_type =3D=3D IDPF_PTP_DIREC=
T) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; clk_adj_offsets =3D recv_ptp_caps_msg-&gt;clk_adj_offsets;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; temp_offset =3D LE32_TO_CPU(clk_adj_offsets.dev_clk_cmd_type);<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ptp-&gt;dev_clk_regs.cmd =3D IDPF_PCI_REG_ADDR(hw, temp_offset);=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; temp_offset =3D LE32_TO_CPU(clk_adj_offsets.dev_clk_incval_l);<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ptp-&gt;dev_clk_regs.incval_l =3D IDPF_PCI_REG_ADDR(hw, temp_off=
set);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; temp_offset =3D LE32_TO_CPU(clk_adj_offsets.dev_clk_incval_h);<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ptp-&gt;dev_clk_regs.incval_h =3D IDPF_PCI_REG_ADDR(hw, temp_off=
set);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; temp_offset =3D LE32_TO_CPU(clk_adj_offsets.dev_clk_shadj_l);<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ptp-&gt;dev_clk_regs.shadj_l =3D IDPF_PCI_REG_ADDR(hw, temp_offs=
et);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; temp_offset =3D LE32_TO_CPU(clk_adj_offsets.dev_clk_shadj_h);<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ptp-&gt;dev_clk_regs.shadj_h =3D IDPF_PCI_REG_ADDR(hw, temp_offs=
et);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; temp_offset =3D LE32_TO_CPU(clk_adj_offsets.phy_clk_cmd_type);<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ptp-&gt;dev_clk_regs.phy_cmd =3D IDPF_PCI_REG_ADDR(hw, temp_offs=
et);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; temp_offset =3D LE32_TO_CPU(clk_adj_offsets.phy_clk_incval_l);<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ptp-&gt;dev_clk_regs.phy_incval_l =3D IDPF_PCI_REG_ADDR(hw, temp=
_offset);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; temp_offset =3D LE32_TO_CPU(clk_adj_offsets.phy_clk_incval_h);<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ptp-&gt;dev_clk_regs.phy_incval_h =3D IDPF_PCI_REG_ADDR(hw, temp=
_offset);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; temp_offset =3D LE32_TO_CPU(clk_adj_offsets.phy_clk_shadj_l);<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ptp-&gt;dev_clk_regs.phy_shadj_l =3D IDPF_PCI_REG_ADDR(hw, temp_=
offset);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; temp_offset =3D LE32_TO_CPU(clk_adj_offsets.phy_clk_shadj_h);<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ptp-&gt;dev_clk_regs.phy_shadj_h =3D IDPF_PCI_REG_ADDR(hw, temp_=
offset);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return err;<br>
+}<br>
+<br>
+static void<br>
+idpf_ptp_enable_shtime(struct idpf_adapter *adapter) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t shtime_enable, exec_cmd;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; shtime_enable =3D adapter-&gt;ptp-&gt=
;cmd.shtime_enable_mask;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; exec_cmd =3D adapter-&gt;ptp-&gt;cmd.=
exec_cmd_mask;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IDPF_PCI_REG_WRITE(adapter-&gt;ptp-&g=
t;dev_clk_regs.cmd_sync, shtime_enable);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IDPF_PCI_REG_WRITE(adapter-&gt;ptp-&g=
t;dev_clk_regs.cmd_sync,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; exec=
_cmd | shtime_enable);<br>
+}<br>
+<br>
+int<br>
+idpf_ptp_get_dev_clk_time(struct idpf_adapter *adapter,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stru=
ct idpf_ptp_dev_timers *dev_clk_time) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct virtchnl2_ptp_get_dev_clk_time=
 get_dev_clk_time_msg =3D {0};<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct idpf_cmd_info args =3D {0};<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int err;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t dev_time;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args.ops =3D VIRTCHNL2_OP_PTP_GET_DEV=
_CLK_TIME;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args.in_args =3D (uint8_t *)&amp;get_=
dev_clk_time_msg;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args.in_args_size =3D sizeof(get_dev_=
clk_time_msg);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args.out_buffer =3D adapter-&gt;mbx_r=
esp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args.out_size =3D sizeof(get_dev_clk_=
time_msg);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D idpf_vc_cmd_execute(adapter, =
&amp;args);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (err &lt; 0)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return err;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; get_dev_clk_time_msg =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *(struct virtchnl2_ptp_get_dev_clk_time *)args.out_buffer;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_time =3D LE64_TO_CPU(get_dev_clk_=
time_msg.dev_time_ns);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_clk_time-&gt;dev_clk_time_ns =3D =
dev_time;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return err;<br>
+}<br>
+<br>
+int<br>
+idpf_ptp_get_cross_time(struct idpf_adapter *adapter,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct idp=
f_ptp_dev_timers *cross_time) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct virtchnl2_ptp_get_cross_time c=
ross_time_msg =3D {0};<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct idpf_cmd_info args =3D {0};<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int err;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args.ops =3D VIRTCHNL2_OP_PTP_GET_CRO=
SS_TIME;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args.in_args =3D (uint8_t *)&amp;cros=
s_time_msg;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args.in_args_size =3D sizeof(cross_ti=
me_msg);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args.out_buffer =3D adapter-&gt;mbx_r=
esp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args.out_size =3D sizeof(cross_time_m=
sg);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D idpf_vc_cmd_execute(adapter, =
&amp;args);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (err &lt; 0)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return err;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cross_time_msg =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *(struct virtchnl2_ptp_get_cross_time *)args.out_buffer;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cross_time-&gt;dev_clk_time_ns =3D LE=
64_TO_CPU(cross_time_msg.dev_time_ns);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cross_time-&gt;sys_time_ns =3D LE64_T=
O_CPU(cross_time_msg.sys_time_ns);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return err;<br>
+}<br>
+<br>
+int<br>
+idpf_ptp_set_dev_clk_time(struct idpf_adapter *adapter, uint64_t time)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct virtchnl2_ptp_set_dev_clk_time=
 set_dev_clk_time_msg =3D {0};<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct idpf_cmd_info args =3D {0};<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int err;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set_dev_clk_time_msg.dev_time_ns =3D =
CPU_TO_LE64(time);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args.ops =3D VIRTCHNL2_OP_PTP_SET_DEV=
_CLK_TIME;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args.in_args =3D (uint8_t *)&amp;set_=
dev_clk_time_msg;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args.in_args_size =3D sizeof(set_dev_=
clk_time_msg);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args.out_buffer =3D adapter-&gt;mbx_r=
esp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args.out_size =3D sizeof(set_dev_clk_=
time_msg);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D idpf_vc_cmd_execute(adapter, =
&amp;args);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (err &lt; 0)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return err;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return err;<br>
+}<br>
+<br>
+int<br>
+idpf_ptp_adj_dev_clk_time(struct idpf_adapter *adapter, int64_t delta)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct virtchnl2_ptp_adj_dev_clk_time=
 adj_dev_clk_time_msg =3D {0};<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct idpf_cmd_info args =3D {0};<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int err;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adj_dev_clk_time_msg.delta =3D CPU_TO=
_LE64(delta);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args.ops =3D VIRTCHNL2_OP_PTP_ADJ_DEV=
_CLK_TIME;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args.in_args =3D (uint8_t *)&amp;adj_=
dev_clk_time_msg;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args.in_args_size =3D sizeof(adj_dev_=
clk_time_msg);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args.out_buffer =3D adapter-&gt;mbx_r=
esp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args.out_size =3D sizeof(adj_dev_clk_=
time_msg);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D idpf_vc_cmd_execute(adapter, =
&amp;args);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (err &lt; 0)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return err;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return err;<br>
+}<br>
+<br>
+int<br>
+idpf_ptp_adj_dev_clk_fine(struct idpf_adapter *adapter, uint64_t<br>
+incval) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct virtchnl2_ptp_adj_dev_clk_fine=
 adj_dev_clk_fine_msg =3D {0};<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct idpf_cmd_info args =3D {0};<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int err;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adj_dev_clk_fine_msg.incval =3D CPU_T=
O_LE64(incval);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args.ops =3D VIRTCHNL2_OP_PTP_ADJ_DEV=
_CLK_FINE;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args.in_args =3D (uint8_t *)&amp;adj_=
dev_clk_fine_msg;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args.in_args_size =3D sizeof(adj_dev_=
clk_fine_msg);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args.out_buffer =3D adapter-&gt;mbx_r=
esp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args.out_size =3D sizeof(adj_dev_clk_=
fine_msg);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D idpf_vc_cmd_execute(adapter, =
&amp;args);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (err &lt; 0)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return err;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return err;<br>
+}<br>
+<br>
+int<br>
+idpf_ptp_get_vport_tstamps_caps(struct idpf_vport *vport) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct virtchnl2_ptp_get_vport_tx_tst=
amp_caps send_tx_tstamp_caps =3D {0};<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct virtchnl2_ptp_get_vport_tx_tst=
amp_caps *rcv_tx_tstamp_caps;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct virtchnl2_ptp_tx_tstamp_latch_=
caps tx_tstamp_latch_caps;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum idpf_ptp_access tstamp_access, g=
et_dev_clk_access;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct idpf_ptp_vport_tx_tstamp_caps =
*tstamp_caps;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct idpf_ptp *ptp =3D vport-&gt;ad=
apter-&gt;ptp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct idpf_cmd_info args =3D {0};<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int err;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t num_latches, i;<br>
Instead of using i, Can we use something like latch_itr ?<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t size;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ptp =3D=3D NULL)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EOPNOTSUPP;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tstamp_access =3D (enum idpf_ptp_acce=
ss)ptp-&gt;tx_tstamp_access;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; get_dev_clk_access =3D (enum idpf_ptp=
_access)ptp-&gt;get_dev_clk_time_access;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (tstamp_access =3D=3D IDPF_PTP_NON=
E ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; get_dev_clk_a=
ccess =3D=3D IDPF_PTP_NONE)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EOPNOTSUPP;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; send_tx_tstamp_caps.vport_id =3D CPU_=
TO_LE32(vport-&gt;vport_id);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args.ops =3D VIRTCHNL2_OP_PTP_GET_VPO=
RT_TX_TSTAMP_CAPS;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args.in_args =3D (uint8_t *)&amp;send=
_tx_tstamp_caps;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args.in_args_size =3D sizeof(send_tx_=
tstamp_caps);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args.out_size =3D IDPF_CTLQ_MAX_BUF_L=
EN;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args.out_buffer =3D vport-&gt;adapter=
-&gt;mbx_resp;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D idpf_vc_cmd_execute(vport-&gt=
;adapter, &amp;args);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (err &lt; 0)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return err;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rcv_tx_tstamp_caps =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (struct virtchnl2_ptp_get_vport_tx_tstamp_caps *)args.out_buffer=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_latches =3D LE16_TO_CPU(rcv_tx_ts=
tamp_caps-&gt;num_latches);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size =3D sizeof(struct idpf_ptp_vport=
_tx_tstamp_caps) +<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; sizeof(struct idpf_ptp_tx_tstamp) * num_latches;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tstamp_caps =3D rte_zmalloc(NULL, siz=
e, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (tstamp_caps =3D=3D NULL)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -ENOMEM;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tstamp_caps-&gt;access =3D true;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tstamp_caps-&gt;num_entries =3D num_l=
atches;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tstamp_caps-&gt;tstamp_ns_lo_bit =3D =
rcv_tx_tstamp_caps-&gt;tstamp_ns_lo_bit;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; tstamp_caps-&gt;=
num_entries; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; __le32 offset_l, offset_h;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; tx_tstamp_latch_caps =3D rcv_tx_tstamp_caps-&gt;tstamp_latches[i=
];<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (tstamp_access =3D=3D IDPF_PTP_DIRECT) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; offset_l =3D tx_=
tstamp_latch_caps.tx_latch_reg_offset_l;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; offset_h =3D tx_=
tstamp_latch_caps.tx_latch_reg_offset_h;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tstamp_caps-&gt;=
tx_tstamp[i].tx_latch_reg_offset_l =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LE32_TO_CPU(offset_l);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tstamp_caps-&gt;=
tx_tstamp[i].tx_latch_reg_offset_h =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LE32_TO_CPU(offset_h);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; tstamp_caps-&gt;tx_tstamp[i].idx =3D tx_tstamp_latch_caps.index;=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tstamp_caps-&gt;latched_idx =3D -1;<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vport-&gt;tx_tstamp_caps =3D tstamp_c=
aps;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return err;<br>
+}<br>
+<br>
+static int<br>
+idpf_ptp_get_tstamp_value(struct idpf_vport *vport,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vir=
tchnl2_ptp_tx_tstamp_latch *tstamp_latch,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct idp=
f_ptp_tx_tstamp *tx_tstamp) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct idpf_ptp_vport_tx_tstamp_caps =
*tx_tstamp_caps;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t tstamp_ns_lo_bit;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tx_tstamp_caps =3D vport-&gt;tx_tstam=
p_caps;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tstamp_ns_lo_bit =3D tx_tstamp_caps-&=
gt;tstamp_ns_lo_bit;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tx_tstamp-&gt;tstamp =3D LE64_TO_CPU(=
tstamp_latch-&gt;tstamp);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tx_tstamp-&gt;tstamp &gt;&gt;=3D tsta=
mp_ns_lo_bit;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+}<br>
+<br>
+int<br>
+idpf_ptp_get_tx_tstamp(struct idpf_vport *vport) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct virtchnl2_ptp_get_vport_tx_tst=
amp_latches *send_tx_tstamp_msg;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct virtchnl2_ptp_get_vport_tx_tst=
amp_latches *recv_tx_tstamp_msg;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct idpf_ptp_vport_tx_tstamp_caps =
*tx_tstamp_caps;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct virtchnl2_ptp_tx_tstamp_latch =
tstamp_latch;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct idpf_ptp_tx_tstamp *ptp_tx_tst=
amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct idpf_cmd_info args =3D {0};<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int size, msg_size;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t vport_id;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t num_latches, id;<br>
Instead of using id, Can we use something like latch_itr ?</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
I am keeping it uniform and cheanging it to idx across the code as followed=
 in previous developments</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int err;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tx_tstamp_caps =3D vport-&gt;tx_tstam=
p_caps;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ptp_tx_tstamp =3D tx_tstamp_caps-&gt;=
tx_tstamp;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size =3D sizeof(struct virtchnl2_ptp_=
get_vport_tx_tstamp_latches) +<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; sizeof(struct virtchnl2_ptp_tx_tstamp_latch) *<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; tx_tstamp_caps-&gt;num_entries;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; send_tx_tstamp_msg =3D rte_zmalloc(NU=
LL, size, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (send_tx_tstamp_msg =3D=3D NULL)<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -ENOMEM;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (id =3D 0; id &lt; tx_tstamp_caps=
-&gt;num_entries; id++, ptp_tx_tstamp++)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; send_tx_tstamp_msg-&gt;tstamp_latches[id].index =3D ptp_tx_tstam=
p-&gt;idx;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; send_tx_tstamp_msg-&gt;get_devtime_wi=
th_txtstmp =3D 1;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msg_size =3D sizeof(struct virtchnl2_=
ptp_get_vport_tx_tstamp_latches) +<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; sizeof(struct virtchnl2_ptp_tx_tstamp_latch) * id;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; send_tx_tstamp_msg-&gt;vport_id =3D C=
PU_TO_LE32(vport-&gt;vport_id);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; send_tx_tstamp_msg-&gt;num_latches =
=3D CPU_TO_LE16(id);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args.ops =3D VIRTCHNL2_OP_PTP_GET_VPO=
RT_TX_TSTAMP;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args.in_args =3D (uint8_t *)send_tx_t=
stamp_msg;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args.in_args_size =3D msg_size;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args.out_size =3D msg_size;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args.out_buffer =3D vport-&gt;adapter=
-&gt;mbx_resp;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D idpf_vc_cmd_execute(vport-&gt=
;adapter, &amp;args);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rte_free(send_tx_tstamp_msg);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (err &lt; 0)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return err;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; recv_tx_tstamp_msg =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (struct virtchnl2_ptp_get_vport_tx_tstamp_latches *)args.out_buf=
fer;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vport_id =3D LE32_TO_CPU(recv_tx_tsta=
mp_msg-&gt;vport_id);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vport-&gt;vport_id !=3D vport_id)=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_latches =3D LE16_TO_CPU(recv_tx_t=
stamp_msg-&gt;num_latches);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ptp_tx_tstamp =3D tx_tstamp_caps-&gt;=
tx_tstamp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (id =3D 0; id &lt; num_latches; i=
d++, ptp_tx_tstamp++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; tstamp_latch =3D recv_tx_tstamp_msg-&gt;tstamp_latches[id];<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!tstamp_latch.valid)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; err =3D idpf_ptp_get_tstamp_value(vport, &amp;tstamp_latch,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ptp_tx_tstamp);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (err =3D=3D 0) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tx_tstamp_caps-&=
gt;latched_idx =3D id;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vport-&gt;adapte=
r-&gt;time_hw =3D recv_tx_tstamp_msg-&gt;device_time;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return err;<br>
+}<br>
+<br>
+/**<br>
+ * idpf_ptp_read_src_clk_reg_direct - Read directly the main timer<br>
+value<br>
+ * @adapter: Driver specific private structure<br>
+ * @src_clk: Returned main timer value in nanoseconds unit<br>
+ *<br>
+ * Return: 0 on success, -errno otherwise.<br>
+ */<br>
+static int<br>
+idpf_ptp_read_src_clk_reg_direct(struct idpf_adapter *adapter, uint64_t<br=
>
+*src_clk) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct idpf_ptp *ptp =3D adapter-&gt;=
ptp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t hi, lo;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; idpf_ptp_enable_shtime(adapter);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lo =3D IDPF_PCI_REG(ptp-&gt;dev_clk_r=
egs.dev_clk_ns_l);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hi =3D IDPF_PCI_REG(ptp-&gt;dev_clk_r=
egs.dev_clk_ns_h);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *src_clk =3D ((uint64_t)hi &lt;&lt; 3=
2) | lo;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+}<br>
+<br>
+/**<br>
+ * idpf_ptp_read_src_clk_reg_mailbox - Read the main timer value<br>
+through mailbox<br>
+ * @adapter: Driver specific private structure<br>
+ * @src_clk: Returned main timer value in nanoseconds unit<br>
+ *<br>
+ * Return: 0 on success, -errno otherwise.<br>
+ */<br>
+static int<br>
+idpf_ptp_read_src_clk_reg_mailbox(struct idpf_adapter *adapter,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t *src_clk)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct idpf_ptp_dev_timers clk_time;<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int err;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D idpf_ptp_get_dev_clk_time(ada=
pter, &amp;clk_time);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (err)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return err;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *src_clk =3D clk_time.dev_clk_time_ns=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+}<br>
+<br>
+/**<br>
+ * idpf_ptp_read_src_clk_reg - Read the main timer value<br>
+ * @adapter: Driver specific private structure<br>
+ * @src_clk: Returned main timer value in nanoseconds unit<br>
+ *<br>
+ * Return: 0 on success, -errno otherwise.<br>
+ */<br>
+int<br>
+idpf_ptp_read_src_clk_reg(struct idpf_adapter *adapter, uint64_t<br>
+*src_clk) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adapter-&gt;ptp =3D=3D NULL)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch ((enum idpf_ptp_access)adapter=
-&gt;ptp-&gt;get_dev_clk_time_access) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IDPF_PTP_MAILBOX:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return idpf_ptp_read_src_clk_reg_mailbox(adapter, src_clk);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IDPF_PTP_DIRECT:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return idpf_ptp_read_src_clk_reg_direct(adapter, src_clk);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EOPNOTSUPP;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+}<br>
diff --git a/drivers/net/intel/idpf/idpf_ptp.h b/drivers/net/intel/idpf/idp=
f_ptp.h<br>
new file mode 100644<br>
index 0000000000..0c901440fb<br>
--- /dev/null<br>
+++ b/drivers/net/intel/idpf/idpf_ptp.h<br>
@@ -0,0 +1,130 @@<br>
+/* SPDX-License-Identifier: BSD-3-Clause<br>
+ * Copyright(c) 2025 Intel Corporation<br>
+ */<br>
+<br>
+#ifndef _IDPF_PTP_H_<br>
+#define _IDPF_PTP_H_<br>
+<br>
+#include &quot;base/idpf_osdep.h&quot;<br>
+#include &lt;rte_time.h&gt;<br>
+#include &quot;idpf_common_device.h&quot;<br>
+<br>
+struct idpf_ptp_cmd {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t exec_cmd_mask;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t shtime_enable_mask;<br>
+};<br>
+<br>
+struct idpf_ptp_dev_clk_regs {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t *dev_clk_ns_l;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t *dev_clk_ns_h;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t *phy_clk_ns_l;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t *phy_clk_ns_h;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t *sys_time_ns_l;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t *sys_time_ns_h;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t *incval_l;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t *incval_h;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t *shadj_l;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t *shadj_h;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t *phy_incval_l;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t *phy_incval_h;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t *phy_shadj_l;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t *phy_shadj_h;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t *cmd;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t *phy_cmd;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; volatile uint32_t *cmd_sync;<br>
+};<br>
+<br>
+enum idpf_ptp_access {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IDPF_PTP_NONE =3D 0,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IDPF_PTP_DIRECT,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IDPF_PTP_MAILBOX,<br>
+};<br>
+<br>
+struct idpf_ptp_secondary_mbx {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t peer_mbx_q_id;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t peer_id;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool valid:1;<br>
+};<br>
+<br>
+enum idpf_ptp_tx_tstamp_state {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IDPF_PTP_FREE,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IDPF_PTP_REQUEST,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IDPF_PTP_READ_VALUE,<br>
+};<br>
+<br>
+struct idpf_ptp_tx_tstamp {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t tstamp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t tx_latch_reg_offset_l;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t tx_latch_reg_offset_h;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t idx;<br>
+};<br>
+<br>
+struct idpf_ptp_vport_tx_tstamp_caps {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t vport_id;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t num_entries;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t tstamp_ns_lo_bit;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t latched_idx;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool access:1;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct idpf_ptp_tx_tstamp tx_tstamp[]=
; };<br>
+<br>
+struct idpf_ptp {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t base_incval;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t max_adj;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct idpf_ptp_cmd cmd;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct idpf_ptp_dev_clk_regs dev_clk_=
regs;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t caps;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t get_dev_clk_time_access:2;<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t get_cross_tstamp_access:2;<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t set_dev_clk_time_access:2;<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t adj_dev_clk_time_access:2;<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t tx_tstamp_access:2;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t rsv:6;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct idpf_ptp_secondary_mbx seconda=
ry_mbx; };<br>
+<br>
+struct idpf_ptp_dev_timers {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t sys_time_ns;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t dev_clk_time_ns;<br>
+};<br>
+<br>
+int idpf_ptp_get_caps(struct idpf_adapter *adapter); int<br>
+idpf_ptp_read_src_clk_reg(struct idpf_adapter *adapter, uint64_t<br>
+*src_clk); int idpf_ptp_get_dev_clk_time(struct idpf_adapter *adapter,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; struct idpf_ptp_dev_timers *dev_clk_time); int<br>
+idpf_ptp_get_cross_time(struct idpf_adapter *adapter,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; struct idpf_ptp_dev_timers *cross_time); int<br>
+idpf_ptp_set_dev_clk_time(struct idpf_adapter *adapter, uint64_t time);<br=
>
+int idpf_ptp_adj_dev_clk_fine(struct idpf_adapter *adapter, uint64_t<br>
+incval); int idpf_ptp_adj_dev_clk_time(struct idpf_adapter *adapter,<br>
+int64_t delta); int idpf_ptp_get_vport_tstamps_caps(struct idpf_vport<br>
+*vport); int idpf_ptp_get_tx_tstamp(struct idpf_vport *vport);<br>
+<br>
+static inline uint64_t<br>
+idpf_tstamp_convert_32b_64b(struct idpf_adapter *ad, uint32_t flag,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; bool is_rx, uint32_t in_timestamp) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const uint64_t mask =3D 0xFFFFFFFFULL=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t phc_time_lo, delta;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t ns;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (flag !=3D 0)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; idpf_ptp_read_src_clk_reg(ad, &amp;ad-&gt;time_hw);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; phc_time_lo =3D (uint32_t)(ad-&gt;tim=
e_hw);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; delta =3D in_timestamp - phc_time_lo;=
<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (delta &gt; mask / 2) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; delta =3D phc_time_lo - in_timestamp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ns =3D ad-&gt;time_hw - delta;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (is_rx)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ns =3D ad-&gt;ti=
me_hw - delta;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ns =3D ad-&gt;ti=
me_hw + delta;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ns;<br>
+}<br>
+<br>
+#endif /* _IDPF_PTP_H_ */<br>
diff --git a/drivers/net/intel/idpf/meson.build b/drivers/net/intel/idpf/me=
son.build<br>
index a805d02ea2..740c1a5985 100644<br>
--- a/drivers/net/intel/idpf/meson.build<br>
+++ b/drivers/net/intel/idpf/meson.build<br>
@@ -17,6 +17,7 @@ sources +=3D files(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'idpf_common_virtchnl.c',<=
br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'idpf_ethdev.c',<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'idpf_ptp.c',<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'idpf_rxtx.c',<br>
&nbsp;)<br>
&nbsp;<br>
--<br>
2.47.1<br>
<br>
</div>
</body>
</html>

--_000_CY8PR11MB774715CCEE33646561110B75F972ACY8PR11MB7747namp_--
