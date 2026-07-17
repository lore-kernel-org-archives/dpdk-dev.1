Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9ECC44507
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Jul 2026 03:33:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2566A4028B;
	Fri, 17 Jul 2026 05:33:51 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id ECAE74028A;
 Fri, 17 Jul 2026 05:33:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784259229; x=1815795229;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=xIZnN3YANMhdcDNdBifn+ME13wmeDbnPQpDlGbrLWxU=;
 b=GMX3BXIjJSkK+oSlyzctXHTprdGbbcSiNe+EMYxxtzwAtDiuIP3wurIO
 HKXz3oJYRQn26OSDyIPYKwCDIHbYlB3F/xiRyeB4PGfvq15vrmuYeG0aC
 OPdNbepTI8loByEQ/EDXU+VeiZU49xyA+dxDyIi9TM7KB1o5S9ahxNsft
 oeRPW27/Da5vvhF6cJ8tw9/E0ttOQiY0lrfKRQExsobL5z19fTqGWfQBN
 zDLJMPb0kAfshQ7Bfoo2qcyVSOW6kCgu51kHHnN69cBlXnvvuxQ58klII
 O8cGX3Glj1MkcnDqbfUN3wcnoqBJRc7uIQNtNc94I31kvFI1Oe7SntTVl A==;
X-CSE-ConnectionGUID: oxCxPEFTSoCOpnGGMV13CA==
X-CSE-MsgGUID: xplkAXQkQACOXtAuU63Xsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="95529996"
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; d="scan'208";a="95529996"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2026 20:33:46 -0700
X-CSE-ConnectionGUID: Zx6FD0h8Q9iQolaFA3T47g==
X-CSE-MsgGUID: rACJixdKQHi5eBjtvnMJ3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; d="scan'208";a="260494919"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2026 20:33:47 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 16 Jul 2026 20:33:45 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 16 Jul 2026 20:33:45 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.32) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 16 Jul 2026 20:33:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rmnn7C0GvsxWkew069vu+cvDN1EapQl7fKdaj92V81yN9vMbI5u8+mkNheJGPFmqhLHeogDQazlW76h7++IZea+GHguqa3FAwT+czI7Ec6txasJUOP7oIXTmo0C/Ke9SqGp7Jbrb+NYqs38t0W8StD/ofdYWCeEQDZz69v3AnQXsDuglyURAbUFSuj9oELMrex4SFOhxrbTvV2+HhB/Rp1HdZN4ZD+UeVFay3UWfhibTuXTsrHajC/I7rMxZiD5Ax3TpBzU0iqzMufW4z8ZBtchreX/zn/poYJJsrZL2olcRYSok/WVwVzokRFPV3guXgu4ZxGtUdF1BucEE7KBbhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HAQNM/jPiWFrDrsGbVFx9Cw2S3KcKQkkHrkWTJpn1hM=;
 b=MiOTjK9pwilHVijLsuOfYvOYpS0/aiqTrVBy5bnlt3L1KWuUYm6rxDltnrkS2fcID9ATx6F/repYW7c/5VYYSDPrUb1ZhZMeUs3zLIA6Ju39J8wvt8RmsukHFNro4Mo5QAj4a2S2VsmUCKNwYNy5QGyyicm6DSX4TM2kfFBHcE2rzXCIk1gDaCT3toLj2sUzaWNcMQfb+yViB9I/xAwad4UgEgAbGa72hv/i3ROzeDePgaQksqMiFP98mXwKAXCj5Xh/UN8La7qlaFUMmsNlYKrwli4I0FTD3EoYJXkMpDzl4bpMdxQMX8IbCrLgI4ds1fZ21RCCOdwKFpbxMP+e+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6782.namprd11.prod.outlook.com (2603:10b6:806:25e::11)
 by LV2PR11MB5998.namprd11.prod.outlook.com (2603:10b6:408:17e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 03:33:37 +0000
Received: from SA1PR11MB6782.namprd11.prod.outlook.com
 ([fe80::cd29:ea71:32e6:ff0b]) by SA1PR11MB6782.namprd11.prod.outlook.com
 ([fe80::cd29:ea71:32e6:ff0b%5]) with mapi id 15.21.0223.008; Fri, 17 Jul 2026
 03:33:37 +0000
From: "Mandal, Anurag" <anurag.mandal@intel.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH] net/iavf: fix VLAN offload when inner VLAN is not
 supported
Thread-Topic: [PATCH] net/iavf: fix VLAN offload when inner VLAN is not
 supported
Thread-Index: AQHdFLNn1eTHyJs5vEOB/n5BMENR8bZxEB3A
Date: Fri, 17 Jul 2026 03:33:37 +0000
Message-ID: <SA1PR11MB6782C22FF22157251A5A9FDAE4C62@SA1PR11MB6782.namprd11.prod.outlook.com>
References: <20260715225234.482186-1-anurag.mandal@intel.com>
In-Reply-To: <20260715225234.482186-1-anurag.mandal@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6782:EE_|LV2PR11MB5998:EE_
x-ms-office365-filtering-correlation-id: e618c440-b6d1-435e-623b-08dee3b43036
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|10067099003|38070700021|56012099006|11063799006|6133799003;
x-microsoft-antispam-message-info: WHYXo6ApvBKjVJCqOAjD5Fn1xoYh9U89ArETljOLzRePHK9Op6Le3tzfisc2EF7o2LujbROBHs1/KItW7+N0I19j83NxAYtPnS8QthXCxvdN4LKkwtkBI1jOuXG5s9Xomajnq3DHLYz6gWD7kESUKmE52HZqbImllY7+h3KLbZAXC97QkgiHjWQj8yb3pquNo/BpIjQ6FrWHR+n7mJlFgAkFN+hrY/4A7HHX/NGaCl6hyN261/CnLN4n4S5v4nKtrz1XE7BHTpOOjbmZAThXQW5TshQS7Pakx6h4E8IycCnDzxtcSzXNWoRRqOxCfNZyjz8YRmdWTZl1H+b4oiL0Ixye5FbRM2EDoO0ahWLwK0cw/E0AVF5FRoEVxpxYlqmFQHPuK6z8znTU6T/TzaKLSYfbj/btyx7UbQ8C/q220kKGbD/l970rA4eFYVsjwp0wyfHWXwY37C7J16tOIIGxM+skrgVf7XHJNc2tg+qBMPLZfR6Eco9fUEgfzduFV6C6DUu8YpyUlf5kr/2TN1iXR13gmjhYMBmxkVVE3YH2ZP5ziBBV36kJ8t8F5xBxJr5f8484n9WLqruxeU4Kfh/eI7rtZ3rUCqZ6V+2T2f1gtwSyHmhrUIJXTxHwx41tou93Lq32bp2o8Zl0MQ7n6VkYQL/HFOJ3Q4MKVCscXKA72b2Tg4JRjdEa2NpZY+cE3cq3Iu3EUN+1MYMB9PGoBktW6618jFYSf1zBcM+wfclmEJI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR11MB6782.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(10067099003)(38070700021)(56012099006)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Fu6nt4AXd6A/i1Vz8ar0+7aojiFtRxvkR8zvwbDJDdsEYj2gUig5r7ZYzvfw?=
 =?us-ascii?Q?MI0/zSqtE0mnJHok8P6Sifqr4lhdkG5+P0B/lCR5nhhKGmfab7bp8ZPWvfwU?=
 =?us-ascii?Q?hKJdGLa45XFRkOZjDx2SnuFjnTcuk4pwYkMM6tihl5bMQyNonYf1o8DazTvx?=
 =?us-ascii?Q?pS0UXYjmE1npxsQIzvdYhxqYG2Ho17ZvnXcB28Fl0TH1hzNKSWU4hSBc42Cl?=
 =?us-ascii?Q?qGF+MdK+ucVQRQnJzN8fVk0kcN1DsP7nnqN6bmpAESV1lF8H5OFxk1C8Pvsq?=
 =?us-ascii?Q?easNGMT9AwRxouE4tuwQowCBYkw2mwXs5ung3wvaQTGrLK2W9tBNX/U5Iw3P?=
 =?us-ascii?Q?ClcjfTej1Q7TmXy4YBj+8WiukobruT6iKfxUC1Rgfzwx+5JIOKSg40sszvoz?=
 =?us-ascii?Q?MJkGy6NNGNjT9/IQyiKzHOCu3vdYxrT10SVtgL3l8uPSEUGomxPhHJQRBfFN?=
 =?us-ascii?Q?hqfd/88daEKjW6a88hzcxScRBAfy/p6xZD/MOy77uzhEyZmIqkjiE4m+jruv?=
 =?us-ascii?Q?f7Jl/arxRs2/+BUX0xZ9Ihe4/hX5qh9quYff0/eapI9qrrnxDP/0m99zTmq2?=
 =?us-ascii?Q?h9Wep3xc8hsyGj/m2rQZajqWxBA1xLL/n+0SXHKUFB0+mpkYgsiR2my77Tv9?=
 =?us-ascii?Q?RUFl1wMd7GcyuZ+FCQdEV/fGroQJG19/kPY4LXQxb5F3sRGoGnbyiHaj1WAU?=
 =?us-ascii?Q?El2s2w9pNOCsZfq7WYtR7bpxuEfHy2Jpx3U6/XpuFd6pP6KHB+lFjbtUDUDi?=
 =?us-ascii?Q?TaUq8F0jAjpnKp7BwRN6N2mQNSYLa4WNa2NOK9pLuwrFuUOKi4006QSa7l8x?=
 =?us-ascii?Q?MyyGA5IgJMWbpY603sCf3PwXbYvcooo4G+3nplq4LM5/AM39MtKtq5Mv+cdr?=
 =?us-ascii?Q?VY/GOX/lAdpG4WbbQOEw5TYFWlLoRXXbeKFgBT/aXLDyKO9EI8LFceQnOlhP?=
 =?us-ascii?Q?hIgGXbgwuf+yIalT0OlWKTqqFAtWBFX6l9v15UNjUQrV8Kix640f4a6Gzdlc?=
 =?us-ascii?Q?SqYLpmF8P6HGNGmPKJvnaA815mt3j4I/H4BIu6WQj6dZp5/s3Fz4SfMcXQo2?=
 =?us-ascii?Q?AM9qSvkvrr1y0xFj9g6Q9v7m1QU0YciKSySFAH5yv/uTAHyqGasItZSHJlPo?=
 =?us-ascii?Q?Lx+AFMaA/lmD989sKF8whEWSpyergsG+6AU2PGcjNwZbYHEe0ddWmSsNXcoR?=
 =?us-ascii?Q?9pkHsX0VKp05QsV/kkVHSgTtfvgPsF0/nkBp2Cb4tj5yYtdiZrIMIPUHaaNE?=
 =?us-ascii?Q?vpNllUL1rIzsL9pIu1WzRCdSKPI/CSkUIDyr1JvQYSlTJYiwhpEcgEXk1kd0?=
 =?us-ascii?Q?nXHrDekQpaIl7DANXnMCQ2/JE8h6HB3hqoLlNFPAW4jhnOvHduxao+SVyNOw?=
 =?us-ascii?Q?ZcALAhk7lRuf6jw5t34a2lRMX5u0IgvW6sNFaVXlgt+ZjckIdVmoLpOxzth3?=
 =?us-ascii?Q?/RisQ9iIHhrQE2Xy44/cGESayYau9uJbXhgf7QiXN8RVE/EMae2STLIRTqj/?=
 =?us-ascii?Q?F+XnOFWICWVcoGc2o6WAQhuH0o27kz3dqLVJJLLaKxH1LrSUrYATxwtot60e?=
 =?us-ascii?Q?GHjBXfEpnaugHPVCTUqFj4PwgvjYuiNrRWbbNTMN/lDTRMF7uGO9VWwsIPLB?=
 =?us-ascii?Q?6LyQBlnxOLkogp+FvyeSiFgZ/7Bty9qbP2VAfYLaAP4DKpp6OOgeakHXOL+h?=
 =?us-ascii?Q?mOo/cEv65ru7UH3UbRliYrhGOKdDIDyxqATZo/rNODs8CYwhUB78rvWC7VSx?=
 =?us-ascii?Q?QnkUCsI2Zg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: lK6C4MWgrp33g77p+yHnJsbiJeEl220gWcdZdG85JJ7hj3IBnfu0nr3+I17+/woc5kcXAwiyxgNOIywJ8nX50rwnWqLyd8QLThH+kGjJ6M67+tRHuUB2MLJf3WUEOeKWOg+AOXKlDKKvcksEpVUPsNAgWiwbZQcOGXBrGn1nfhoISaH5EfS+/CyHdbBTgerlYF9/MOoJrOUIicaCmheMRzb8VnAkIehtaVz+s20QfS8iu2fgg7yMC2gH6CFtIgOjQBh004M+PLBRZSrYVuEVanKVjIPs6uX8dk492JZqa+e2/iirRkt9Rdj8uLNuwrMJI7dUGyGVrs00CZ//BhEBmQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6782.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e618c440-b6d1-435e-623b-08dee3b43036
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2026 03:33:37.5294 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yz5ERaUzp9REYiD9+CcDBwoIgsWPsjKonXBNUo3CpMnQwF9xxWf6UXi7P/LPuEC3RoWx+39qWVmUuxrgZC+1CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB5998
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

> -----Original Message-----
> From: Mandal, Anurag <anurag.mandal@intel.com>
> Sent: 16 July 2026 04:23
> To: dev@dpdk.org
> Cc: Richardson, Bruce <bruce.richardson@intel.com>; Medvedkin, Vladimir
> <vladimir.medvedkin@intel.com>; Mandal, Anurag
> <anurag.mandal@intel.com>; stable@dpdk.org
> Subject: [PATCH] net/iavf: fix VLAN offload when inner VLAN is not suppor=
ted
>=20
> In Double VLAN mode (DVM) i.e. when RTE_ETH_RX_OFFLOAD_VLAN_EXTEND
> is enabled, the single VLAN offloads are programmed on the inner VLAN
> (0x8100) engine by iavf_config_vlan_strip_v2() & iavf_config_vlan_insert_=
v2().
> When the PF/hardware does not advertise inner VLAN offloading capabilitie=
s,
> these functions return -ENOTSUP.
>=20
> On the enable path,these -ENOTSUP are trsnalated into -EIO, which makes
> device configuration fail.
> However, in DVM, with the default outer TPID set as 0x8100, a single 0x81=
00
> tagged VLAN frame is handled by the outer VLAN engine, so the missing inn=
er
> capability is harmless and should not fail the configuration.
>=20
> This patch fixes the same by returning success when DVM is enabled and th=
e
> outer TPID is 0x8100, so the outer VLAN engine services the single VLAN.
> Changed "qinq" flag from 'int' to 'bool' to address memory wastage.
>=20
> Fixes: 8599d7604e0a ("net/iavf: support QinQ strip")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
Tested-by: Daxue Gao <daxuex.gao@intel.com>

> ---
>  drivers/net/intel/iavf/iavf_vchnl.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/intel/iavf/iavf_vchnl.c
> b/drivers/net/intel/iavf/iavf_vchnl.c
> index f8fffa7802..f346837bf1 100644
> --- a/drivers/net/intel/iavf/iavf_vchnl.c
> +++ b/drivers/net/intel/iavf/iavf_vchnl.c
> @@ -920,7 +920,7 @@ iavf_config_vlan_strip_v2(struct iavf_adapter *adapte=
r,
> bool enable)
>  	uint8_t msg_buf[IAVF_AQ_BUF_SZ] =3D {0};
>  	struct iavf_cmd_info args;
>  	uint32_t *ethertype;
> -	int qinq =3D adapter->dev_data->dev_conf.rxmode.offloads &
> +	bool qinq =3D adapter->dev_data->dev_conf.rxmode.offloads &
>  		   RTE_ETH_RX_OFFLOAD_VLAN_EXTEND;
>  	bool strip_qinq =3D adapter->dev_data->dev_conf.rxmode.offloads &
>  			  RTE_ETH_RX_OFFLOAD_QINQ_STRIP;
> @@ -943,7 +943,8 @@ iavf_config_vlan_strip_v2(struct iavf_adapter *adapte=
r,
> bool enable)
>  		 (stripping_caps->inner & VIRTCHNL_VLAN_TOGGLE))
>  		ethertype =3D &vlan_strip.inner_ethertype_setting;
>  	else
> -		return -ENOTSUP;
> +		/* Return success for non-inner VLAN supported hardware */
> +		return (qinq && adapter->tpid =3D=3D RTE_ETHER_TYPE_VLAN) ? 0
> : -ENOTSUP;
>=20
>  	memset(&vlan_strip, 0, sizeof(vlan_strip));
>  	vlan_strip.vport_id =3D vf->vsi_res->vsi_id; @@ -1036,7 +1037,8 @@
> iavf_config_vlan_insert_v2(struct iavf_adapter *adapter, bool enable)
>  		 (insertion_caps->inner & VIRTCHNL_VLAN_TOGGLE))
>  		ethertype =3D &vlan_insert.inner_ethertype_setting;
>  	else
> -		return -ENOTSUP;
> +		/* Return success for non-inner VLAN supported hardware */
> +		return (qinq && adapter->tpid =3D=3D RTE_ETHER_TYPE_VLAN) ? 0
> : -ENOTSUP;
>=20
>  	memset(&vlan_insert, 0, sizeof(vlan_insert));
>  	vlan_insert.vport_id =3D vf->vsi_res->vsi_id; @@ -1067,7 +1069,7 @@
> iavf_add_del_vlan_v2(struct iavf_adapter *adapter, uint16_t vlanid, bool =
add)
>  	struct virtchnl_vlan *vlan_setting;
>  	struct iavf_cmd_info args;
>  	uint32_t filtering_caps;
> -	int qinq =3D adapter->dev_data->dev_conf.rxmode.offloads &
> +	bool qinq =3D adapter->dev_data->dev_conf.rxmode.offloads &
>  		   RTE_ETH_RX_OFFLOAD_VLAN_EXTEND;
>  	int err;
>=20
> --
> 2.43.0

