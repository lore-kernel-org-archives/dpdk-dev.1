Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD1EDD116F3
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Nov 2025 09:25:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F57840DCD;
	Thu, 27 Nov 2025 10:25:28 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id A938E4013F
 for <dev@dpdk.org>; Thu, 27 Nov 2025 10:25:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764235527; x=1795771527;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=D86GXcR8QB/osuKi0ORZMNFxvFHkCQnSPj/u3thpt98=;
 b=Su41GCdG/HqT5Xw4ZmprlGDZNgkM7dpQ57pO6T4yHpfzPgIyAtVmzyTf
 FrD6CZxJsq0IMksrCcz482K/OAz/QoPxp9AUVvsayKAsK6N7ABV2lfJpF
 O/mqg8yOHJqxz3B+utqBpoW9b9+0MzuUg8fLq25zAMj0CEZ+8ymIB4aH3
 EXA0kFO/r67Um8xXKMM97iNlm9yRn30BGDBj8f6zRqgwvGflKmqW+hpMJ
 G4JN6qugULCqjLvzEu1RABol+9Hm4rnt/QPOiHdd1krJ//ub6RLHyJUQQ
 fuPhxdkAK+PYtGLhMEKFkOjiWAi3jwg8XY6C8+p2rkoA9GMtr+vwlKjbL A==;
X-CSE-ConnectionGUID: vCHSPqmYR8OoWAdN320CVA==
X-CSE-MsgGUID: jpOht0OySlqLJ6nh++5/bQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="66441389"
X-IronPort-AV: E=Sophos;i="6.20,230,1758610800"; d="scan'208";a="66441389"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2025 01:25:26 -0800
X-CSE-ConnectionGUID: 05fPmo8CQWS527I/GyD47w==
X-CSE-MsgGUID: mcMRX9f8RcGe2r+hkt6ZCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,230,1758610800"; d="scan'208";a="216539751"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2025 01:25:25 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 27 Nov 2025 01:25:24 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 27 Nov 2025 01:25:24 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.12)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 27 Nov 2025 01:25:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S7aCOj/QNn+rOzLSSJW9Oj8e6ttKMSgOX2HPqGjXJep0AfbmdOA2jhk6C4TbBFaseWBp771udOAENxb/IzYoKOx7cir7vY84iJZmo+Iy0vNJ3JWD+lcPjz3gpvJQI4Jjza+8Fh4OX/NUuAPwe9qePI9KRRKAgn+FptJER60UDVnJdZATmWxF1DeP82AHmu0kRPrA2ihnJYRL2wDFv1heQDy4RwFztDSu3E9m5ChXSxa6E/v2gmwrJi9g/aT3hGdbZTOf5fIn9jdioyKwCBN5xiRq7Cg++48yYTkndI/k/uYdVZ33/fYFxGpYe3MaZ5g2qTbJtl9zEyQBMiU3heHNtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pV4T/0rYEH2DvNr76mMaaIeTQoLw2KHRx5eZBKkq1BY=;
 b=kmSueLqw0/lJ5U4lR615ywzMlRx6WZBRzTAtwoDZMgwoENxJvaZoWRLMlPAQw0QJJzAsFihQL60iC4+SdTcGQIcEup6Hnw1QZ6rOjVPg3npFj88F0YaviljDNCXY97dmWtAgp93XhTyWJJjW/M+gUSfEvYUJqPVqVPBEn1EK6KR5f4yxQepz5ahFPN/qR0NS8HTXDG8le5xsgnluY1ZdDrvP+6iqjwuc0eyneGKCp/1xMYZcWz614dOXTVpuDRCGfRj4Laq3LisZyZhTSHmgtamvvBODPcMSstC0Y0bDNmlSfV8JlP/iOjb6gZF4K9+KRqM7+olqgoq3rGqlxR6iFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7747.namprd11.prod.outlook.com (2603:10b6:930:91::17)
 by DS0PR11MB7960.namprd11.prod.outlook.com (2603:10b6:8:fe::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Thu, 27 Nov
 2025 09:25:22 +0000
Received: from CY8PR11MB7747.namprd11.prod.outlook.com
 ([fe80::1457:eb10:8766:7a67]) by CY8PR11MB7747.namprd11.prod.outlook.com
 ([fe80::1457:eb10:8766:7a67%3]) with mapi id 15.20.9343.016; Thu, 27 Nov 2025
 09:25:21 +0000
From: "Hore, Soumyadeep" <soumyadeep.hore@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: RE: [PATCH] Revert "net/iavf: fix check for PF Rx timestamp support"
Thread-Topic: [PATCH] Revert "net/iavf: fix check for PF Rx timestamp support"
Thread-Index: AQHcXvYaEaYWbhkJ8EmwXgRAkl3a2bUGP6wA
Date: Thu, 27 Nov 2025 09:25:21 +0000
Message-ID: <CY8PR11MB7747612256CC34D33443EEABF9DFA@CY8PR11MB7747.namprd11.prod.outlook.com>
References: <20251126165943.1536164-1-bruce.richardson@intel.com>
In-Reply-To: <20251126165943.1536164-1-bruce.richardson@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7747:EE_|DS0PR11MB7960:EE_
x-ms-office365-filtering-correlation-id: 62d5ec0f-ddff-4c51-eed2-08de2d96e382
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?NchR3b6Wm1qBzcQhIu1X9vuQOulHauvq9C+W1NvgtniL27/7DzkUKbzDVsD9?=
 =?us-ascii?Q?Zs5l2AdBYwC3WMeo3rRhIp1NlJuF1fv8JaHWFVDD85RaBu/EIxzvX5uk2Zi6?=
 =?us-ascii?Q?CgfUtcxFZzB+kvyXnJYZdDGae8odhxYgyubHgrgU6zx1OTZGwMqE9mlcqKz/?=
 =?us-ascii?Q?R5zCJKjabWweDp+9Xav7GBVW4io13cfKuIfLi5/RQIIK1ADDuvSaVAZ12IWj?=
 =?us-ascii?Q?60CQMYuuSCVeiVyVUPuOT88Iy/W7VuUN7QWQWh5udDj5D/0IOZrGHm+ufSPb?=
 =?us-ascii?Q?NyyxRqDVpM0eLfTiFHAZHYN+AJZJUXne5VYaBBP6oJwXH0i1dKzvEyscR8/h?=
 =?us-ascii?Q?pLQIIF3SAmuB5t+dqdkMi02fgyT4rqsrVSJGVO6P7t3u+hJkCP2d3XWiTQDB?=
 =?us-ascii?Q?X2lr9hNy0AO4Z2+G6P+IGfVzVvlwslitpHmY8g/fAsEbA5xsxLZUoJJ5qUF8?=
 =?us-ascii?Q?XMOonvNgDdoqee7zZYltkgQEFw5gm8ZEdNchP5KILglpG3XEXP3f440jTz/d?=
 =?us-ascii?Q?Bp/12MqzQIs2SIW6O2c9dwJxQNNU9fei78UOGGmfXdp7y+azhj6J4QUoDwPF?=
 =?us-ascii?Q?g4t8T9Zu/MZHSaPfAKxto1e4NdJBShmJ6v46sKusf4FTmTIOx1TG/BuebhMu?=
 =?us-ascii?Q?cIB5jS4IzjJ70CGKtL+prjOJk65K4DlD4D/ONMUO+p4cMNzH6VP05wXhkvPF?=
 =?us-ascii?Q?fg1HTYqbw3L3wTeDXLTEfOMIPH1BEmThageUZAdL0dz9RuVqphU7exLbY3WO?=
 =?us-ascii?Q?Xzp4psJxkIUoWmz+Zvcc31UCOSTkWt5LCfU4ipQ4Z0GDQjttXOlOSofee/AM?=
 =?us-ascii?Q?PT1iBoqajRAPaUqIr9QQWLYdouNnOFLrJItxiuzAlLLoC1dWcXqKoJUuNyIn?=
 =?us-ascii?Q?69vvykOa5Kd/gRZkaxMBNVIqAGL3lNXWGmT+gix3PZwvyE2T69CmW0kPsfTM?=
 =?us-ascii?Q?lQE2GE+s867zFOl2x9aCWlDCvdhjnJwphyuvrHA4fAz6eqlRLwM9oaRFhpn5?=
 =?us-ascii?Q?Smoiuim6n0oS1cVIKD4yX6oidRisJPDFbXAmkOUp/hpsAOOOk58FbeD7fQe/?=
 =?us-ascii?Q?Xhbm6wOgcIJqYSXgjZdNJBWnzYiEmxCmhyP3vrzmpEPrOUs3NRl9Q1hQETRz?=
 =?us-ascii?Q?IUeS+ONaBGyUuKNPHxi96Ou08a32aj64erZFM/yD3enoKKV8s4JmfaqDLJC2?=
 =?us-ascii?Q?Z4O2tiP1uszu8MoBq2HSMMaviQ0lldcWXMTduFqdxz1Zv/ATU+o9sAY2iqAl?=
 =?us-ascii?Q?FD88irfMnUC8TCf2327Ew7SirKefL2Uzgk0uOVbZNIJKsmSWBTEapA+Ha3Tv?=
 =?us-ascii?Q?phI1RnwP7ElwBRKsfKVR2xSyq9O2nQcoDjdHrpAOcFDim6wvORsVC1Q/biE7?=
 =?us-ascii?Q?PXglEJ6/QkoT64N8jCYJ/7+S51sP3xUJtD8B5+DsbNBVZELD+gIWl5w3ic68?=
 =?us-ascii?Q?ljJ3bJRb+HmShOjP5uD0xDr7PwOReZ6TXfe6/eUX7DQ90ws6MDeU2SqAD+BZ?=
 =?us-ascii?Q?azbnUSFnNgqBGoL+KFlJ2MVmdl91ut0XVlry?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7747.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?A3jy+kT73RVTD0eCp6Vjo5w8PuhxNjFfzRdxM//wCP1JeFFHzzcFMqZM8eG1?=
 =?us-ascii?Q?B9Nv6c+zs4ReQZ0h6njEjycf72Uq09TSoarG7JkAfXsMGOKZRnhD96nu50ZQ?=
 =?us-ascii?Q?KB5NEVOm5zygmn6eA0XbEOmcBrjswAUW7Jb39FgbySpCqgX6BrUzPYDkKSGI?=
 =?us-ascii?Q?JEsLyBuF5qpfyrsyL4jPYUKATJ0unE+SAZmxUa2lAQLpMYVXtD6QMyftuped?=
 =?us-ascii?Q?j8iV6wOTQNQwAYqS3WZwTBrupp27UrGx5qvsg+S82kRsyLHCA24mmpE0jzHC?=
 =?us-ascii?Q?z7/ykq5/Wkjn1TzV1POKss3D8pPcfUV/8Byc8HJ0lJdydwnsnIB9Qk9627fI?=
 =?us-ascii?Q?PRRpvf5+Xr+ySFwH8VAoLCK2mSZh1MzlC/GmmhSRLkru9Kj7iwWL8GEd8Qfq?=
 =?us-ascii?Q?cSCLpwdwP8j9ToScdksL/63B3zIkQVUem3tQDwi59/lTLTEao1Jn+XKsTil5?=
 =?us-ascii?Q?KCjwVaqk4yijm65fPTcAAXnudjUQYdaPEuNw9doPx/qHmBhtVn+nXviaY4AR?=
 =?us-ascii?Q?DB4INz3GtQGvZmnkqjhAte37OmOgulqbYsxazjGuv1az/b792mYeMBANCZzi?=
 =?us-ascii?Q?oIck6m4+agdG5mW9pLp9jTeW6hnxPRxw07CnpTJUREzZTvNELDC/JZJ7G/6b?=
 =?us-ascii?Q?rtmjggJh8xSQzOr7uq11SSg2Lta5B1yNkIbz2J88RZPep0ekSb/WMF5rCIjb?=
 =?us-ascii?Q?ZAjwEkK/YIrdm8usoU0Af67DTs/1eEUDpbUOw+wYiZCAgagdsBTF9I2iBp56?=
 =?us-ascii?Q?G+bmLmUkd3Ovp5Kleo4E3g1E/De5aJfu7iG0J/l1dPbR8PM08MNRjb1A6xy0?=
 =?us-ascii?Q?KR0paTTdGAidhm0rtKPMwpZk6ohArM2sr/Adn1A58P699Cm3WVbjF9xHu0tF?=
 =?us-ascii?Q?MmRZAVhTcKMVWxOSR2Fj64zy0YwYUbcFIZzWVUXOqy0UA3nZWdX8vuk2O5i5?=
 =?us-ascii?Q?b4x1kAALKlWO0yi7J6J3wXOrWLCXCN0bSoROm46+SrmaTxCsdsbsCckqRR/c?=
 =?us-ascii?Q?nSxYGqMF79Ax0DdFD/7Nzuxs4STeYd7OB6FJZCtY/PBszjAjQ883jOb4sxiA?=
 =?us-ascii?Q?H8C/oUgYyEZYb376Iyi54wVKOvXskL19K2Pl3t7qQrGYGYmhskfzq+ujB3dm?=
 =?us-ascii?Q?n4z6pCprOWMKncu+piJPGFa1IWncFzp4KuORxAATIwUROppB3dPzohont+tB?=
 =?us-ascii?Q?C8xOOCcNFZjWw4ZEjLWvDXUl09VapOpJ8Y+0ariUPE0N9IKMojVtJOcA4o7N?=
 =?us-ascii?Q?XsJl1vXNjn0ASY3UyW7lQwqdUo6iWk+7HIYpSsP+LO/v6spMJXEyv0zAUQ3h?=
 =?us-ascii?Q?STD193EQfjSnLA+wEnOkIsgBxx/ovzvwf6MKql4J58qblO1CilzxO2Ckz3bq?=
 =?us-ascii?Q?BsMWp3aFxmBZYOzeSpUFimTOUkyrwYL9qrsu3hKH4Yzl+QFn1avuSqlV8FhQ?=
 =?us-ascii?Q?xpVU9xRWqJRRFm7NsunQJACPABbseq6x2Kn5HD3wAEcXNW7BWk0E6i0TH8id?=
 =?us-ascii?Q?QgfMOjuyOpRh8M8Zwf3euFkN2IX3yUz0OllLZJqt0FzK7FT+KzE56L0mZRyx?=
 =?us-ascii?Q?mhrfOQ72KLAIJ0qL2ZI1hwAbjYj50E8NUwh5n0ET?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7747.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62d5ec0f-ddff-4c51-eed2-08de2d96e382
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2025 09:25:21.7565 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C0zUrgWKThDVoi/lxBNuW/XSPGCWnxLdKzognUXqx3r0+Xt8+iDVHYcmP/zhVxRceQy95UnK7mbgWdjOisz70mQ1D+qJOQjJg2rhUEpDuTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7960
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

This reverts commit d21c2fe6e5a1ef1e7cc9490f54f359db1cfd5283.
While fixing an issue with enabling Rx timestamping on PFs which don't repo=
rt Rx timestamping, the offending commit broke PFs which do support Rx time=
stamping.

Fixes: d21c2fe6e5a1 ("net/iavf: fix check for PF Rx timestamp support")

Suggested-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/iavf/iavf_ethdev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/=
iavf_ethdev.c
index 3ef766de47..15e49fe248 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -1177,8 +1177,7 @@ iavf_dev_info_get(struct rte_eth_dev *dev, struct rte=
_eth_dev_info *dev_info)
 	if (vf->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_CRC)
 		dev_info->rx_offload_capa |=3D RTE_ETH_RX_OFFLOAD_KEEP_CRC;
=20
-	if (vf->vf_res->vf_cap_flags & VIRTCHNL_VF_CAP_PTP &&
-	    vf->ptp_caps & VIRTCHNL_1588_PTP_CAP_RX_TSTAMP)
+	if (vf->vf_res->vf_cap_flags & VIRTCHNL_VF_CAP_PTP)
 		dev_info->rx_offload_capa |=3D RTE_ETH_RX_OFFLOAD_TIMESTAMP;
=20
 	if (vf->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_VLAN_V2 &&
--
2.48.1

Acked-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
