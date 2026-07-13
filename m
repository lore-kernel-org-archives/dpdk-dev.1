Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868C2C43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Jul 2026 13:13:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A40DF40276;
	Mon, 13 Jul 2026 15:12:59 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 9CEBE40041;
 Mon, 13 Jul 2026 15:12:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783948378; x=1815484378;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=2e4MVGo2LTLnHtCal+ZAsaUU8Zp4pGxYvRMZ8zJoUlI=;
 b=WiuGBmXbTcGxeSUYDwhieQN1zBNeIq0DS7ntnxDSrfl0EL9qujimsizH
 TLUdh3EzHXOhMqiK9H6dob/7tN+/IoVTWOqAcimymaCh/RDnZ99Vn5thS
 bmU6yGEEK8BHOtdDSjJAi3xzOHqKmLk4fP3MTHpfN/YcFBpqNOKYSh6Pf
 TzkkkGYjnOg7HJ/Y9uGZXxfHThUMn2iFtdbEx3tCnHTxBT60rCTt1b/BC
 Pj1UQ0mjcTZPBaU+a8MzsFXTWr0CLa+/Z1ByxZ44moEKHc4IobNnPNrX8
 PjVr/6vYnwrv1EzEbYYWiVCM1AAKQ2vHyX/FLa6pjMaFWv9cz0M5ViCtL A==;
X-CSE-ConnectionGUID: 0IgKZYizS+2s0z19npV68A==
X-CSE-MsgGUID: 0ZBd7dSvRSOPjYPDQnia1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="102105179"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="102105179"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jul 2026 06:12:56 -0700
X-CSE-ConnectionGUID: AFuOM5U/R02KlXU+Hvsl7w==
X-CSE-MsgGUID: RaSTBvbZRSO5XFoHoX/sfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="252916514"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jul 2026 06:12:56 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 13 Jul 2026 06:12:55 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 13 Jul 2026 06:12:55 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.1) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 13 Jul 2026 06:12:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ijRzCVL/QpeeYAIYVtUNdYjmM4mXRaH97rkUifbcqQbgCD0wtJWFhyeVdmwu312jDQY/u/zaMFsvLToeLwIZSNqYW83ncEVoNIiqRDl2HFWUhw/L12um8nyMEB5aAzFBfcnMZ9HrvcKCIm6+8THvxXBvz6zPtxUIp18VDc2iVt1FlkqbouynRoH/FHX79vkCI7saaGNjPIenIh+wmjqbS0fTt9kPLMDOsvWN3BxtQ90EqRwf8V07a8OVtThLGkF6zI+MSJhbPokYmYd9y8Llm3DuH7LrPpzesGPzwp+BOhQev4WgRCoe9E6WrAOoXtcWNG6aZXvUUDyUKii7LQfiBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PuggH2+6QSbVpz/6wGJY8KE2c1DEP5fe4g8W7/Yzvz8=;
 b=fQUc6XyNo2MuSRNeOC/tAuvBPJ+L3yMhz6w1J2Mvirlh5Rq9b4qvwYUxeY+L5rK9dnOlNuKunz4b/EpHcDnjug63nOK4AUYccVoQqY5MrA7XGeEPNCQ599DA5+9dbRfqBwQehJtz3NYEsxecxz/Z27SYuaI781g8HeON2ESHNxauzAlfMJFQ6cXz1DSW7+w5ZCFBs6BOOsC8lrqknnza5UEQ73tIQ2Iu9l57wQm68IbNe9/lBC23oSHZFdJgT3KgaYHPrgzf5kht+ik9mFwlwxIY2GToE7YISQaV7OOAA0tmxDu83MAe++eG6Al+1xFodHYMDoOxC4Iz0IfSNPKs7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA4PR11MB9278.namprd11.prod.outlook.com (2603:10b6:208:563::12)
 by CH3PR11MB7202.namprd11.prod.outlook.com (2603:10b6:610:142::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.22; Mon, 13 Jul
 2026 13:12:45 +0000
Received: from IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057]) by IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057%6]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 13:12:44 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: David Marchand <david.marchand@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "rjarry@redhat.com" <rjarry@redhat.com>, "cfontain@redhat.com"
 <cfontain@redhat.com>, "stable@dpdk.org" <stable@dpdk.org>, "Medvedkin,
 Vladimir" <vladimir.medvedkin@intel.com>, "Richardson, Bruce"
 <bruce.richardson@intel.com>
Subject: RE: [PATCH v4 05/10] net/iavf: fix duplicate MAC addresses install
Thread-Topic: [PATCH v4 05/10] net/iavf: fix duplicate MAC addresses install
Thread-Index: AQHdD7yRMPZEvmkPIkeO0heIdQg0xrZrbArQ
Date: Mon, 13 Jul 2026 13:12:44 +0000
Message-ID: <IA4PR11MB92781CFE503B95525EC366AF8EFA2@IA4PR11MB9278.namprd11.prod.outlook.com>
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260709160247.1798575-1-david.marchand@redhat.com>
 <20260709160247.1798575-6-david.marchand@redhat.com>
In-Reply-To: <20260709160247.1798575-6-david.marchand@redhat.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9278:EE_|CH3PR11MB7202:EE_
x-ms-office365-filtering-correlation-id: 1285c253-d958-4f0b-2a93-08dee0e06d9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|38070700021|4143699003|56012099006|11063799006|6133799003|22082099003|18002099003;
x-microsoft-antispam-message-info: f0O+pyYisM9VSIgV58g00v4ILxCsgnWlxenP9vPjauHENlSJnK469lTCctRsPcIMAAo1iJtRr0+zbWUrWqw4tyxQ+oEhv6MACu1OdcMESyUOpF4u+I6RSOH5FU1/o/SOigOeetWuzDJ1EeDfFmmIXTAWSpVE++tTYR/U5aEw57vYY1lG2QBTKqmt0+Iwz4md3XVyXjvrhEcuYG3sgmKVfoTbd3USze6QZh4Y03LTAo1CL9s3on8QDDuu0Kym6DEVIiyRPkyRsLQrQpukHKCj96CQPCmfYdomPRdcraUq8cjNJ0NPCL3J9s9OortILESkAGlp1o0y9q5v0cg8P48peoJ3Bqbj461aH5JxHwY0xNChnXQQIpNJYZs3SgC5H/QcW1WiCN6ng2TZUbhQ+aPqdzyP+npPVMQJByl9FLPkiadN7prD/LbgHZ2pqzV5TUqy4Js8A/37iQfxhG8JyovCj7MPpJ7sSCIgLtH9ZDDEbobcb51d2qsX4cSTHeGCQ8gI+PRK/xZuAZo4Ak2mHyWXN2svhLpSdfXZzoxKBjuDGHCRw8fMEj3GWG3NfC+fC3clhSKbpmDEYmZ7rPEbWGkUxOnnjjle9vM6bPPkMjIW0ukaKInZE3KFtzxvmSEQ3Xm43ssyP+kMuLGmqrAOjHMkKWkjwrRfvyVYlLF3I4zyUQ4vUVfZwrlrvyjqripuvMmmwdNwVFjIuDUbWkeYB7Xl9CkYTS8rFgtxVgk5CiHSLc4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9278.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(38070700021)(4143699003)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iKWUplV76PV0qohz6zMAP8KG9kGoc/lFMbm88S2VSMgiTYSBPIWrdvl98m40?=
 =?us-ascii?Q?R2UM3KTaoO4S4mIK60gni0WZFG440jr5PXnV0vlY+r9nLsxiYGNIeyqREG3X?=
 =?us-ascii?Q?z1WWvk4XuTlM8IEppVPTv9aG8pnFp9VZeHzh6kb09XVUIhglfMEa1zD+8ZGK?=
 =?us-ascii?Q?ka45dDwIuIQyG6jMNMzYt+t+DUQDb0u55kUEsshK7XLB58iE4HSr6DQAzWyV?=
 =?us-ascii?Q?bkqwD7NnOK20RuDoNYfBe9XAkXHmz2nDCa/rO2/ijcUtPsOUU8MQ5c45JHqp?=
 =?us-ascii?Q?O2n6zdFkiwIr5EVjHaZwbuNQ655YH+iR5PwX7Yhy7yKnA83VjqPE+k9aodbe?=
 =?us-ascii?Q?GB0mAWQ6mR7nx6PEj+Z7po0RrKRc0FJ8qj/XXZDP56teBeTyhpDn29TSlZd9?=
 =?us-ascii?Q?6ygJ0PH45J9BSjli0nbM4rHtM+P9YJWaoR6YckXk10Vo+zeIIVYkdAoQhYnR?=
 =?us-ascii?Q?nARdqWkQAoAJFCV62T5eiqRrcGGJ3To7Iroevc89HSVp8wmnzfJqMdD5znEW?=
 =?us-ascii?Q?PKQdHmNOqdIp3mRPM5to+IlQJwUDbd+00R8kyn9Ds1DJfAzn83jFwx3WlE71?=
 =?us-ascii?Q?p4KsNOxU9AOYX1+RFFhYzWZ4cfbY5gwOglxA8lZWsPEZAZYlYAi1XQ/NY8Y6?=
 =?us-ascii?Q?0kQfQzPsstZnybCQSZNdKocTTMzDByA30PPCTrwuGcRhA8pFl49/sPv0Bj4T?=
 =?us-ascii?Q?F0I7L5cdJKjApQHBJu8j3jbYvWzdWYTPu25H84xSxlQA3fXK7R3MpPLWHUFb?=
 =?us-ascii?Q?3zYfKZ4cQw9T9PLLJ3pdkkLfy1URbkZZiHN4SKoB9JkF+emg02vReZKvuePb?=
 =?us-ascii?Q?V3Kss/2eS8DfIEIqMo2llK7+Gl3MH3LvxMjxVjdvNmjlsoKyaHUTyW9sm9Ix?=
 =?us-ascii?Q?G0zRTF25q/OunYDLMBSlIF2xrlGgWgRbqRGUitQCwuhTEvBlP58UbgoE2KCP?=
 =?us-ascii?Q?F/c+JKRASVCpDK7ZaedXkc5VBbF2A+Ull9fm/iw8+4qJPu+0bzQ7ptEKlmZG?=
 =?us-ascii?Q?hV26cyP94+/lvNdcvvsiIEtyCwdL9sz/Mz99/rhNC8zSRZ/efg5DeOHoZxk3?=
 =?us-ascii?Q?RS6QOarsXSg5FBT9siynul+KPImsNVICQtBdMyed6s1kGq8yeRDyCkoxWWsZ?=
 =?us-ascii?Q?kHnq/GOltopa+6OmuVutgF/hnzGPD9c81Um8laddzBwQrfksVsIxlCQsbk1R?=
 =?us-ascii?Q?LQYqiIRgHapTmmjXXEBcZl2tJ0TkGzYA0HfAQ1fDVD2tBhFoEhfPGe0chRiZ?=
 =?us-ascii?Q?f7RbgdrLkZZtuLhMSnbOklKo2Eq7joNOBAw6f2jov5heXXlBkDt074sn2hBs?=
 =?us-ascii?Q?F5bkRL0MYp+14tayHH9szGEoDLvRPp3L5RaZdFs6j4ipWwY2epHzqO/mRfz0?=
 =?us-ascii?Q?NesOqx1GyklJgUO85KWKa1n1lPV1uXrMcAVOOINI+/04ILLlcWa0iufoCvlx?=
 =?us-ascii?Q?WUzROVv85WDolt5OvwgzP2/B8cXliDg9HWPE5dAYdhavNos+Qr31a5w1wIOK?=
 =?us-ascii?Q?w/3Sl7g/ycfmErOXegYRtDmvNJAvN9fPm8V1QZTBb972z26QSGA4+UbrsY1F?=
 =?us-ascii?Q?NCmFLqkbebvOIPkQJtIVkqiCX84NCc/SsOmTGBq0glS6dl69CdLVj4BVJP5n?=
 =?us-ascii?Q?WA9V1fZdrSP5kYSMdnBIP3rc92KhbmogoU/GPPmCDc2BwqPNyTiA4pEYhw99?=
 =?us-ascii?Q?dNoMhkWthev1bKFdYU4SYoVPLpIof+fWD2KFahd7qG6LxabIYRB3zPR8sO5A?=
 =?us-ascii?Q?KGW0ntmo+Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: r5Hsz59vDnsLM5eMqxRYN0TUk7cfN/7uiBFDR4NlUKb+YDJ/jjVYFNppX97ZWUd5kHyZK9GWX6fAsdCNe9ZxYH4NxHINdr2K5zb+216v3Rt+5WjeBcOJNFO/z/b+OgdxNLu1P/pDqDhmAeLf7HngSiH+EwI3l6KkTEahel8BbBXgIwR1IXywk6cmW/p/Z/2fNhWRPBWQkh+sC06FrkVALExrrvkBe4Ymm+lNh9gqNquWM+v1lTCWOIfF1WKskqVS2pxCdL/l2Wb+bQmw3ZWDnqjLOiSKfPnTukJVOh34mjYR7yPiuPmkrfHslwDTyLB+xYoewmkGOx91MLJ16Y09IA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1285c253-d958-4f0b-2a93-08dee0e06d9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2026 13:12:44.8391 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9foF6Le9m996s6olAWgw8oUduDqcGe4meGvc3NgzKqUV+LaOcMxnP9xt6+J2tqP4i68B7nT4UBIIc/F+jQpCzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7202
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

> Subject: [PATCH v4 05/10] net/iavf: fix duplicate MAC addresses install
>=20
> On port restart, all MAC addresses get pushed *twice* to the hardware,
> once by the driver and once by the eth_dev_mac_restore() in ethdev.
>=20
> On the other hand, MAC address filters are reset in the hardware
> by the PF only when a VF reset is triggered.
>=20
> Strictly speaking, the mac restore on port (re)start is unneeded,
> if no VF reset happened, so we can announce to ethdev that no mac
> restoration is needed via a get_restore_flags callback.
>=20
> Then, move the mac restoration to the VF reset handler.
>=20
> Fixes: 3d42086def30 ("net/iavf: preserve MAC address with i40e PF Linux
> driver")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
>  drivers/net/intel/iavf/iavf_ethdev.c | 31 ++++++++++++++++++++--------
>  1 file changed, 22 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/net/intel/iavf/iavf_ethdev.c
> b/drivers/net/intel/iavf/iavf_ethdev.c
> index 179d90ec55..fe54df4b9f 100644
> --- a/drivers/net/intel/iavf/iavf_ethdev.c
> +++ b/drivers/net/intel/iavf/iavf_ethdev.c
> @@ -134,6 +134,8 @@ static int iavf_dev_vlan_filter_set(struct rte_eth_de=
v
> *dev,
>  static int iavf_vlan_tpid_set(struct rte_eth_dev *dev,
>  			     enum rte_vlan_type vlan_type, uint16_t tpid);
>  static int iavf_dev_vlan_offload_set(struct rte_eth_dev *dev, int mask);
> +static uint64_t iavf_get_restore_flags(struct rte_eth_dev *dev,
> +				       enum rte_eth_dev_operation op);
>  static int iavf_dev_rss_reta_update(struct rte_eth_dev *dev,
>  				   struct rte_eth_rss_reta_entry64 *reta_conf,
>  				   uint16_t reta_size);
> @@ -264,6 +266,7 @@ static const struct eth_dev_ops iavf_eth_dev_ops =3D =
{
>  	.tx_done_cleanup	    =3D iavf_dev_tx_done_cleanup,
>  	.get_monitor_addr           =3D iavf_get_monitor_addr,
>  	.tm_ops_get                 =3D iavf_tm_ops_get,
> +	.get_restore_flags          =3D iavf_get_restore_flags,
>  };
>=20
>  static int
> @@ -284,6 +287,13 @@ iavf_tm_ops_get(struct rte_eth_dev *dev,
>  	return 0;
>  }
>=20
> +static uint64_t
> +iavf_get_restore_flags(__rte_unused struct rte_eth_dev *dev,
> +		       __rte_unused enum rte_eth_dev_operation op)
> +{
> +	return RTE_ETH_RESTORE_ALL & ~RTE_ETH_RESTORE_MAC_ADDR;
> +}
> +
>  __rte_unused
>  static int
>  iavf_vfr_inprogress(struct iavf_hw *hw)
> @@ -1074,15 +1084,14 @@ iavf_dev_start(struct rte_eth_dev *dev)
>  		rte_intr_enable(intr_handle);
>  	}
>=20
> -	/* Set all mac addrs */
> -	iavf_add_del_all_mac_addr(adapter, true);
> -
> -	if (!adapter->mac_primary_set)
> -		adapter->mac_primary_set =3D true;
> -
> -	/* Set all multicast addresses */
> -	iavf_add_del_mc_addr_list(adapter, vf->mc_addrs, vf-
> >mc_addrs_num,
> -				  true);
> +	if (!adapter->mac_primary_set) {
> +		if (iavf_add_del_eth_addr(adapter, &dev->data-
> >mac_addrs[0], true,
> +				VIRTCHNL_ETHER_ADDR_PRIMARY) !=3D 0)
> +			PMD_DRV_LOG(ERR, "failed to add primary MAC:"
> RTE_ETHER_ADDR_PRT_FMT,
> +				RTE_ETHER_ADDR_BYTES(&dev->data-
> >mac_addrs[0]));
> +		else
> +			adapter->mac_primary_set =3D true;
> +	}
>=20
>  	rte_spinlock_init(&vf->phc_time_aq_lock);
>=20
> @@ -3424,6 +3433,10 @@ iavf_handle_hw_reset(struct rte_eth_dev *dev,
> bool vf_initiated_reset)
>  		if (ret)
>  			goto error;
>=20
> +		/* after a VF reset, all mac addresses got flushed, restore them
> */
> +		iavf_add_del_all_mac_addr(adapter, true);
> +		iavf_add_del_mc_addr_list(adapter, vf->mc_addrs, vf-
> >mc_addrs_num, true);
> +

This restore block only runs if the device was started when the handler was
entered. It might make more sense to move it into iavf_post_reset_reconfig
which will run for VF-initiated resets regardless of started state, and for
PF-initiated will run if the device was started on entry.
For PF-initiated if the device was not started we return from
iavf_handle_hw_reset() immediately, so there's no opportunity to restore
the MAC addresses at all. It needs to be considered how to restore the macs
in that case.
Need to consider as well how the restore_flags and auto_reconfig features
work with one another. If the auto_reconfig devarg is set to zero it means
the user doesn't want any restoration of settings upon reset.

>  		dev->data->dev_started =3D 1;
>  	}
>=20
> --
> 2.54.0

