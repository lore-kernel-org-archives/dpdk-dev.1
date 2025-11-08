Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419DECCFA18
	for <dpdk-dev@archiver.kernel.org>; Sat,  8 Nov 2025 07:08:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E3C440261;
	Sat,  8 Nov 2025 08:08:50 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 79E01400D5;
 Sat,  8 Nov 2025 08:08:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762585729; x=1794121729;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Gxfq9rCwSNa8+9oJRLkwOVAA6Vb+LUqIzosC0RKFzCo=;
 b=E6qsHmouW7Xmcx2rDOb3ISzHL7KlxXRe/XPzy8on8hkdlwalVJLPtFMn
 sOVYAQVmgxJ6Fz28LZ+78dZxYC1Ya/QRerLVJiLmUNKl7jlExX8JLff/k
 9lRPZjGsna8TV8UQ1mRVhfcfNPDua9iA21FZQSYvuhv6phEUBmC1Q5wQK
 JSjjQ4vSe2Zqwe33eK9mRs1kT4xeRvynwNiGMQeznk3YivabB7qExc/pz
 21kN+4C73lPj8h9uQQTroWkQaqBwigJzFXF644YIl5B9kPHEVU7EeTmgd
 DwJuSnYnuyqH7dY3+i82dt878QKs2gyPYOLdtUDTgvPDRG/RbOzdqjsEi g==;
X-CSE-ConnectionGUID: 9762lsyETmWBM2WtiG02XA==
X-CSE-MsgGUID: RgRnsEgEQ5maZ1lpvuCm2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11606"; a="64762206"
X-IronPort-AV: E=Sophos;i="6.19,289,1754982000"; d="scan'208";a="64762206"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2025 23:08:47 -0800
X-CSE-ConnectionGUID: bTYP7YkMTVinM+Z0tINuKg==
X-CSE-MsgGUID: SVelSImmTBaKzgV3JkugSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,289,1754982000"; d="scan'208";a="188184529"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2025 23:08:48 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 7 Nov 2025 23:08:47 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 7 Nov 2025 23:08:47 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.29) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 7 Nov 2025 23:08:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BMjlnY3Bxk9W1cIOYtO8SYhfVACU14Hptxf12H+ZDO+2hIlKYsROfTv/FB617wjtyzM4QncGMsXeS+vc5ZZkw/AebUy1j5aOz23fofhRc5HiPuI+H73S2K6y0zw+rlFXTvtEpii/OMPTfwlhKnnchIjpuqnjNOMf5dr9bimeg0nnoXltRd9hRjaH5SCs5zn2pAMXioLCO2CmIAktSUoymBt7Uzx3yhJeWC6Q1Q9sx5eHMaEUJYbaf9lEXmcNxFmC/HzN8/hXKX5dHWOtP9kSKEG5nFJQHMaMWZTXq+LXEgsbBUj7nrmn+oCxy5szU4BX5GP6hVU5E9hn7D3tCvX6qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JdsQYkV5+5qiuMKkHpAu8HcV4XRy11LUf9Gyu/CaGmY=;
 b=iucwrWAAK+6MvSEmRl5AFnwfAeuslrSisqXAs0IOOPxKLldSNTW23o3SZ8OsF7nuQLlvpRDskpIyU+erINW8IVO8AF/Jqe/y+trmGi75r/p1Qda5A+T9rAzbyA+hqlT4E1nkNI503IGAmhwLQQuzIr8pLMdWsGeY7fEjabJbyWkyTg2McP5DXH7Yi7TsTEGRbvkSiOtLcbIlrVP9tc5sZ586o9j5zhS2+xXRn/d/SvkI+c5S74DqXczqIKKCHCRxQ8HvDd1VLIEhZQAXQdMB7Xh2fYWtaMwQTdCTe59+JfLcO01vn9NH9ngAx8tPeX8mjcAId4RlU/Q29YU4NpHIPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9254.namprd11.prod.outlook.com (2603:10b6:208:573::10)
 by IA1PR11MB7679.namprd11.prod.outlook.com (2603:10b6:208:3f1::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Sat, 8 Nov
 2025 07:08:44 +0000
Received: from IA3PR11MB9254.namprd11.prod.outlook.com
 ([fe80::8547:f00:c13c:8fc7]) by IA3PR11MB9254.namprd11.prod.outlook.com
 ([fe80::8547:f00:c13c:8fc7%3]) with mapi id 15.20.9298.010; Sat, 8 Nov 2025
 07:08:44 +0000
From: "Song, Yoong Siang" <yoong.siang.song@intel.com>
To: "Hore, Soumyadeep" <soumyadeep.hore@intel.com>, "Richardson, Bruce"
 <bruce.richardson@intel.com>, "Zage, David" <david.zage@intel.com>,
 "dev@dpdk.org" <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH v1 1/1] net/e1000: use device timestamp for igc
 read_clock() operation
Thread-Topic: [PATCH v1 1/1] net/e1000: use device timestamp for igc
 read_clock() operation
Thread-Index: AQHcT5J8IZLXsPNRpU2rC3qlmWL1HLTnc76AgADpkHA=
Date: Sat, 8 Nov 2025 07:08:44 +0000
Message-ID: <IA3PR11MB92542B87553924CDE5562FE0D8C0A@IA3PR11MB9254.namprd11.prod.outlook.com>
References: <20251107031507.3890366-1-yoong.siang.song@intel.com>
 <CY8PR11MB7747E4515099613475FE50CCF9C3A@CY8PR11MB7747.namprd11.prod.outlook.com>
In-Reply-To: <CY8PR11MB7747E4515099613475FE50CCF9C3A@CY8PR11MB7747.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9254:EE_|IA1PR11MB7679:EE_
x-ms-office365-filtering-correlation-id: ad77af2c-df70-4a4b-27fb-08de1e95a776
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?eZ2SDBA8UeLe/7mfSOJ54qLFL6TNYf9NyKLhyPmY2uRfhlgeYrlIhQGxNu85?=
 =?us-ascii?Q?Z53V+5FAh+eZo+fs9ovOWcRIjxaHTmn1deUn74KU1aAIKMKLK0ByVfGPi9gc?=
 =?us-ascii?Q?Qb0cYyAOVKqtu3KARIup5RlsJststVj3RyaI7cqP3j7tEUG1eUVb5jhg/7Pg?=
 =?us-ascii?Q?LJ8Fb2gyE3UqrZJ7SvphdZuCQVvtWM7gkQWbwyJDCbXg7S5xFW9iv7MVxjTs?=
 =?us-ascii?Q?NRxmK2Oe9BPZn6dg38+Rb1npR8oE6c0mDv/n3A9sF1QzTOIuxZ0ekpOrCPr0?=
 =?us-ascii?Q?Py4CH6iOaaMWLFfNhuFdm/rr0pSHIpubaj8CdBdsn4cu6UdCZafdKk5UoNfm?=
 =?us-ascii?Q?yOfIP6D0s3VvJQxQ+UHZPCl6Bs2MHZRTvW9TQPR/bKWxgs4XSXCyhHXj0h9x?=
 =?us-ascii?Q?m/IhTAG2yuEUfDvRj8divNKZCiX9SObrHRCw+GsKwIceo82Bd8hBO2PkbtMY?=
 =?us-ascii?Q?9BJ4tUcFqjEA9SzoGTL3FkUrrAyftvtp9/wNAtzN68Cx2FPNMaL6AAyIz3Dc?=
 =?us-ascii?Q?LD/aMw4sVtfy1tWy6JgUH9dDyrNSyMCiDawqzeA1w+KJvT+qUGCfW54wpoLh?=
 =?us-ascii?Q?E3Bdp8XpynxoPY8SF143nYHNYmkiWcXHZK7nIQjdI+TPv5UQG+DzXM3OOWzZ?=
 =?us-ascii?Q?oQD2cqVaqmiH9q4xhovZabqwHViizzagsXYsfS2q/V4pFSXyMoZxTMNB8duV?=
 =?us-ascii?Q?LtWRo8VbnOKu/T1hPABmxS7hpKfbUAMdqxGJBqGx5H3WF6lxsFFVyFldvlK7?=
 =?us-ascii?Q?PmG1OZPOy4haNXR11l50xt0isEwdmYhLLtJBsa6a6UfaEeW+j3i28ytUgNpK?=
 =?us-ascii?Q?BiwT4AlsgTtRfy1vc5iFnKb8lyRzOLtuQnlf9EiDA2NffiTuyKRMyAcfbwik?=
 =?us-ascii?Q?ItOBFIbnf4PsU46BDR4RFfnY6V7i2C3pG9IjYc3KMiEffqPbSPSV7nZlwlR6?=
 =?us-ascii?Q?w0nD95+7gdiN6sFDY/hxmlUtVhiUBviCX8HXDySw/jMaIqBlRGCi1/nWeg8s?=
 =?us-ascii?Q?ZwMUFd3CnQjxZLft4JlwWb2UqPVISyLAtzIaci+ZIW6wd8bm207PoNG3n3Il?=
 =?us-ascii?Q?LMAPj/vTl79MlxD0/yFlpCqpf5tFsSeNIfBXqtuiX3dW+2+Kz460F1uJSIBi?=
 =?us-ascii?Q?m6XFNcrGEkS/ZgstH6y6Wfe7hdl121BRD8XYgCib5GKoMhWT9tOTLRXhXhx/?=
 =?us-ascii?Q?h5WaombMM5H7NsyVY+ln6DhB0RfVw0kC8ybrL01kbkvZhYUrIbyBPQtA4/xc?=
 =?us-ascii?Q?prUgFJAQAc77XEABuSL329+loi6hFJtRc3Djto1DPt3rIknNMjC8uZMjmosX?=
 =?us-ascii?Q?szVLCOCxkxDBhZaJNTA1hWldBBM/XLTNdVnzFXxjzs2JR7vz448xwTiSu1xj?=
 =?us-ascii?Q?F6xFtY0mriGcvSVS5k3HKwzU7wHwxDP0viIdX9cT5lcCc5ArGSacWv9kWeZv?=
 =?us-ascii?Q?o2UnFvrhpTtICcavUh1yZL0uT+0Dfs8oMSvA0Q5ZlM9vrkUB0P+oVwtTulT0?=
 =?us-ascii?Q?kh/DbL2CYIE6pSjoc6tn3FSsHe7Fy6wflPDu?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9254.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NhhNe57yvc4+57iNEd4y5L9YHeK6aZKNqP+B2CbXxnhTENfgiioET/XL/DKL?=
 =?us-ascii?Q?SvRhXFhg7WMoqfVldA6YaMKIVAe1qlWC5lzyIqK5kTYpTX4/hOn9OYl6XeUR?=
 =?us-ascii?Q?zdAIFtVgGXt+OoCWmx5xnzSMOMyK2TWunN4RFVPsSLp+/hCROcQpGGoVzN6T?=
 =?us-ascii?Q?JXBnet3ZlHoczK4xLAOveygPDY+guDEVUgoy3t18vfHuIr3aBIYtqeDHLJ4u?=
 =?us-ascii?Q?SuRkQE0gDP+ywjRnSMbj3cqhXydy1SK2CbkdBaRwoy8uNdjpW93fT2uTWYa5?=
 =?us-ascii?Q?eymXEgdEoKaM9x+603z2LaFVQqpG6cRvMsBYA+NxHY5yaBGt/NB4GolNOYaF?=
 =?us-ascii?Q?68gYxuvrvCkpNcai2DlOAqgdiqOPg4SqhV63ykf/Bl8T0SJkyjpCMZW8tgsp?=
 =?us-ascii?Q?XbWUUxFKLMeSLNOsWZg0jxQM5w1MK6g68a68u6/VwU8NxYwhsbpB48sTZE5W?=
 =?us-ascii?Q?7SGHVbzOF+oUAuDcLgqPVmAuwUV2rJbpB2dFzbX4eNoSiVSie9cp8TJnHBBC?=
 =?us-ascii?Q?9fz8brI5MKD6E1cvGnKNJMs8ywJA6pmjrWEGNbMp6Fu37Fn+NG+PCFnkEkum?=
 =?us-ascii?Q?9IQxOiSj4MbNNMTUbX+4zdxKgqg7BNUI5zSR9xQZwwod15oRqdJzbCXgmlfk?=
 =?us-ascii?Q?pIqBONTNBw/vbGvCHO9y5lpiSCIK6rKhJ3uTv2nXGuFtJJIUyN4SMH5UlP4k?=
 =?us-ascii?Q?Jac5uibMMOTeYJMsFEl1km01VpEU0oEOGN3V9hS1G2iCQNCbd7nYlpxFQhkP?=
 =?us-ascii?Q?HmkKslVAeQwO0HXlXzNc1T+xr6lxfOTPngUsULoy3XQN7u0wbpeqDpyw2nnN?=
 =?us-ascii?Q?5qrtSS5S+vnQmNaKNfYjNFnFiumszEwIj2+MVBXDuMvVGL7hLFmv9wi5+JH7?=
 =?us-ascii?Q?oOzXZ2NRRT7sak9zkrUoPMB17RXOVXJDKAVNKyx2JmksAc/UMOfgfzYjzaBg?=
 =?us-ascii?Q?LUkxDxuBgBqat3iRhjkl0+c5T9+8McvL7XU2lVEBguV2xbfxTepM1Qv5yPC7?=
 =?us-ascii?Q?pVGJQh7a97HG2eKZI551wfVKZncqkoHIuDtXM2n+0Rl8Ywb+caXw5H41ZOKf?=
 =?us-ascii?Q?4c9ekWD/i4yn9QqwXgcFOTr7o2GbIn6d+7jH3AGwl5SJjkpg9lMljatTI44v?=
 =?us-ascii?Q?jq4E2M0JmUMwRK4A3hw5Ltp6MzafQmNEc8A7uOi44MARSm68BXD/yVRDG5kI?=
 =?us-ascii?Q?pfQoUKY02BLWOAMtmhwoRmTvk24QCVN8cgNK9BqtOJnvaO7wYCjskKr7ZZk0?=
 =?us-ascii?Q?CxL/wYmDYPExztewOI6IQB6c3MXRkmMc9sCfZ6bj2TyKnQlV4EYW7+GizCfx?=
 =?us-ascii?Q?Y9wRAKEOpQkTpQa+63PWOMOfawvI6/6QhATdKndNEkqDCLa16rpSupYDncni?=
 =?us-ascii?Q?4MhqrqzgQRY/PNxp1BKxxSynMmltfKghpd+Y756v/JtlCOj86oH/UiL7DyfX?=
 =?us-ascii?Q?jAzjy+wPRDRulawpdL/SL7QO+58DXD6cCQ5sYz4Rae7HrIwxt6BolqvvCgOM?=
 =?us-ascii?Q?qmTZAaR97pdi9oG6+iegbsZLmlKceONkqLRB+ET0GB2PNprf1sVG+CQQSEHI?=
 =?us-ascii?Q?d+NvOBxJJLgzsz5vkYfaOpE+Y9NEamlCBDy5RyI/SoXn7MrP/sI4DqKNfh3v?=
 =?us-ascii?Q?3Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9254.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad77af2c-df70-4a4b-27fb-08de1e95a776
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2025 07:08:44.1219 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pc7ZILXssiB0NvviIclwcwyNkrfYA/tit4hUzfwkaIW9gJBfl79pXOpP/huvBw59q4wvrHX30D3kSMf+F6KWprdfLy3XMd9D95cHV7kvGrQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7679
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

On Saturday, November 8, 2025 1:11 AM, Hore, Soumyadeep <soumyadeep.hore@in=
tel.com> wrote:
>Hi Song, on closer inspection I see the code implementation is similar to
>eth_igc_timesync_read_time().
>
>Please reuse the existing code as much as possible.
>

Hi Soumyadeep,

Thank for your comment. I will reuse the existing code and resubmit v2.

Thanks & Regards
Siang

>Change eth_igc_read_clock() to read from hardware timestamp registers
>(E1000_SYSTIML/E1000_SYSTIMH) instead of using system clock_gettime().
>
>This ensures that the clock reading is consistent with the hardware's inte=
rnal time
>base used for Qbv cycle and launch time scheduling, providing better accur=
acy for
>Time-Sensitive Networking applications.
>
>Fixes: 9630f7c71ecd ("net/igc: enable launch time offloading")
>Cc: stable@dpdk.org
>
>Signed-off-by: David Zage <david.zage@intel.com>
>Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
>---
> drivers/net/intel/e1000/igc_ethdev.c | 14 +++++++++++---
> 1 file changed, 11 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/net/intel/e1000/igc_ethdev.c
>b/drivers/net/intel/e1000/igc_ethdev.c
>index b9c91d2446..045f7c784d 100644
>--- a/drivers/net/intel/e1000/igc_ethdev.c
>+++ b/drivers/net/intel/e1000/igc_ethdev.c
>@@ -2972,10 +2972,18 @@ eth_igc_timesync_disable(struct rte_eth_dev *dev)
>static int  eth_igc_read_clock(__rte_unused struct rte_eth_dev *dev, uint6=
4_t
>*clock)  {
>-	struct timespec system_time;
>+	struct e1000_hw *hw =3D IGC_DEV_PRIVATE_HW(dev);
>+	uint32_t nsec, sec;
>
>-	clock_gettime(CLOCK_REALTIME, &system_time);
>-	*clock =3D system_time.tv_sec * NSEC_PER_SEC + system_time.tv_nsec;
>+	/*
>+	 * Reading the SYSTIML register latches the upper 32 bits to the SYSTIMH
>+	 * shadow register for coherent access. As long as we read SYSTIML first
>+	 * followed by SYSTIMH, we avoid race conditions where the time rolls
>+	 * over between the two register reads.
>+	 */
>+	nsec =3D E1000_READ_REG(hw, E1000_SYSTIML);
>+	sec =3D E1000_READ_REG(hw, E1000_SYSTIMH);
>+	*clock =3D (uint64_t)sec * NSEC_PER_SEC + (uint64_t)nsec;
>
> 	return 0;
> }
>--
>2.48.1

