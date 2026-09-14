Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18C4C88E64
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 10:19:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5F49B4068A;
	Mon, 14 Sep 2026 12:19:32 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id C6B6740144;
 Mon, 14 Sep 2026 12:19:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789381170; x=1820917170;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=LkI0ArKh1/NNTu/cCPGb6NL6Quwode4hN6bfYCci4mo=;
 b=V/4JbiONmbWjzWl8qaR/LX0uJmaLuPq7/x/8Njk/ES7eOU46cRCLZ/Ek
 vZwM8/1/rUTZujpdC91A/zH7pBrusuMXp2q4OqtaC4ThQaw9fzuhvSPmD
 NMwED0/yFrw5dDdsL5OrJwetzdfPS+FwobcITHQyj7gYTOOAamgtRYgIF
 srUlB2O/Bt5dqqLvpv9hbA2HZ2CjoD7agFB6oZyOFy7JfQcxMNkclUxIa
 qfLrb2OOaPeB5pFO+BZDoLk0A5khg4THLyMcH5ZLWRcphETfAYQ/b+a9w
 FWxy8zFc5x8YBF5FSB8PyT+uvu7xtzi9t8CIqSI8iK+rQp276IWRhLxmW Q==;
X-CSE-ConnectionGUID: SkL29bbVQg2mLUYYuGdYDA==
X-CSE-MsgGUID: zaaCsWN9QLaT6PRK2hp0lg==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="93555720"
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; d="scan'208";a="93555720"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 03:19:28 -0700
X-CSE-ConnectionGUID: o4v8kLRKRhSgZiUZDgMVCw==
X-CSE-MsgGUID: l2xqk/95TVikaxtOGXz/Aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; 
   d="scan'208";a="1003985"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 03:19:29 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 03:19:28 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 14 Sep 2026 03:19:28 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.57) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 03:19:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JeTdkfZKOQoKBE1RpEp8XB8+qLA8RKIEmP48ioNBFQ4H4F6m6Tg2Y0c77XHHeJQdbML765vUo5LkLIUGfbdlkm7e2OHInLZvgf1JIPO7MC5Rb4FWV/JImjz/ZFZ5kjBPLn29UFxzelR0WGB7ziCwQOVEAhyCCAhBzaAmkS22SAhdME3BRDmbnutrNBMQSyRj5K2eQrN6jhJYg3Tw5fehFdxXd5Xh6qVUarsH7kzrl+LfpBM51nFnkR7BG4Ph38+RIY5H2Q9kk5cDFv0F3h4iwm1C+jHyNnN6v3e2RZ1Jf4dxniKqyAFR8WjawfHEetvekBexT4GNczp+lNmNHoQE2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dXNpKmN/UPwJkV5AG7Y/zcz43U/V0O5fqpQr8tb6PTM=;
 b=JEkoFxlaUwEei6QWDt9y+gt55NP96MFSPwi1Vfh76VK+EtbkFJ9Ka7BjPZO4mprYGZVg34+lWmzUYC0Hfwe+cnuw/kTT/WI2ozF1sT+NdedTGXtLeBAc+T1fKLsAvkjW2rxmGbSYzatQAgVP7wDME3n8YGl9LMeuO2u0JihKSdzBiBBkeAVPpZwUFIebEhd75BDmKAnZ4H1FH4+a1b9W6Qd3Ou65AVV2emckEWNWZc73vggiNQVqMLpDOy1Cw4GxpHryU/yFargVf59KY1tRgg2vD+Tx38QteWJvsoKQY06e6chSUE1vUjGuul476czSOzAiIpk0UgDW+NU6ns/dmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA4PR11MB9278.namprd11.prod.outlook.com (2603:10b6:208:563::12)
 by PH0PR11MB7448.namprd11.prod.outlook.com (2603:10b6:510:26c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Mon, 14 Sep
 2026 10:19:25 +0000
Received: from IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057]) by IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057%6]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 10:19:24 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: David Marchand <david.marchand@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "Burakov, Anatoly" <anatoly.burakov@intel.com>, "rjarry@redhat.com"
 <rjarry@redhat.com>, "cfontain@redhat.com" <cfontain@redhat.com>,
 "stable@dpdk.org" <stable@dpdk.org>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>, "Richardson, Bruce"
 <bruce.richardson@intel.com>
Subject: RE: [PATCH v7 2/4] net/iavf: fix duplicate MAC addresses install
Thread-Topic: [PATCH v7 2/4] net/iavf: fix duplicate MAC addresses install
Thread-Index: AQHdRCGMA1TUUF+I106fQfiQdxGHhLbN2/aQ
Date: Mon, 14 Sep 2026 10:19:24 +0000
Message-ID: <IA4PR11MB9278E70DC4CD62AEF396DC388EBB2@IA4PR11MB9278.namprd11.prod.outlook.com>
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260914081725.1097704-1-david.marchand@redhat.com>
 <20260914081725.1097704-2-david.marchand@redhat.com>
In-Reply-To: <20260914081725.1097704-2-david.marchand@redhat.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9278:EE_|PH0PR11MB7448:EE_
x-ms-office365-filtering-correlation-id: 16a33654-c11b-4b51-b9da-08df1249a6aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|6133799003|18002099003|22082099003|38070700021|4143699003|10067099003|56012099006|11063799006;
x-microsoft-antispam-message-info: A5Ib/n+HBqNdVlbr7Nw9FSexSHYTaKwc2Npx5WEXfzQs+BrqtlXggQMlnJlwAn7JaUUMQSDQykB+iTjKgAWoVSSGyyLWhSEfVeJMeBrlf9xu46INnASVuQBgMhI4Xv8l1EbGABN+PdneUFClru3U7NLjllYfZu5uoiIHVRPZqWKPjGaJKjuC41Y09xiH5h+3rXJeOqDDTwdkLxG8J3ON7d/qexH5dD2MMz7X/3Ni6n3VFol24aW3ndlBKrIiFDCKkhlYpyeOIv9++960nhNhtRKs1QMLazyH0usypDrLzJFTbmme4YRHdyf9n7umxo+NAiyTdx65UIsm9f3nEbGpVQjfZ0uEQV+mCc7NeWdQNQe2X3JLmubwISPzmnoHXBkhbuGFD4GNSuUVKS5zQb0LoA7+9z8QPvHbWVvu6yrRpfIOJh3X3z7OLA6FkexeBnBXcz5FeBxv5hJS3rbEhi161bL/+g7NefE5kSI9ELZovHEAeydz4hBs2YFMpnucY0MVlsTQyLRV9a+ApC6XCNQ0+rX3nVO8k1SL41Y4/WET2V4nqiRe4TpdlG5rRUExRl2SZESU9O/9kl7XOlLADYqa1wXzSbtX/BDRm/pGzu5fjy8cYA7P6Xfg++OyqK8Moejzj1RhBYp3L38U8XGNtEEFx/OjMnaAvvYGVDVlOOQ0au0Ws3KLeIazc1f8oTmHOT5ceHMSA03gz9IP9NauTR5b0TKAda7iQPsoUxta8j1svsA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9278.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(6133799003)(18002099003)(22082099003)(38070700021)(4143699003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FdHsNALAKCV0QIO2PFXlbaRN5Fpd4BFT5v8wxhA5sQN6qaRLlkCMmmjpxu4N?=
 =?us-ascii?Q?sDb+9ZZDm3mIpbDOK1JMYmE1p+9AIC5uAq0Gy8pOMcQQgCMdMV4OmoOsRejn?=
 =?us-ascii?Q?qoGUyB5iv3cDqVraJNe65qhMGsS6awKUPArC9n6vQE7eSyou7LSQ6cDHdauj?=
 =?us-ascii?Q?84sogPdAo6hUoKn6dC1dD2/a54GcFx5ZrjSXpiwrUAUihHAjpPP+RkcqptRK?=
 =?us-ascii?Q?12QA0HLE9xr+Hz1Ea/+Rb7ceqjp4jzVfiVQsrnK3H2K/maW7Lt1oFRbjtrBa?=
 =?us-ascii?Q?9J5z2IqbJNjnQkZoLmrkqtJA0YPZGE7/DChVl4mrjMA0XUgDK3MWq/dL7Zad?=
 =?us-ascii?Q?KGr1K5Ex9VHnDhr1OI9powQy/73Ympd2WvTvjAIMRUyAoaqB/iajZSosG+xd?=
 =?us-ascii?Q?0btu8Y8j+2G96QEmS6MovoNPTiLPCebO1O9e8hk5yzZfosR2ebtnRDpEpWMV?=
 =?us-ascii?Q?IOXotzHPxqhEpWdigSFC2ZdKEV/mpJsg+TawexrtwqBBvCH+4tQ73U20rfJm?=
 =?us-ascii?Q?gq8vFfKYJOT8UAWdQrX4RNJeVFMMu193MRsVK5eDOFKs4xH/2sR5Gw7Cuvqb?=
 =?us-ascii?Q?O2feXZ+NApqVQVTogt8DZNRhjV6rzoZ9K4XI68trznbbk0N1kj6/tcqUWbCC?=
 =?us-ascii?Q?crBbQ9+hcnuEvFxyHuhamLEodrwuiC0xBVHkfDSzsCrNdqHMcxdfSs/KP59H?=
 =?us-ascii?Q?UiNhtiR5yCycJF85jIuLLWBh29djYuVplKzdViZrhUMDMOQMLAWWR1vMwniO?=
 =?us-ascii?Q?zJ3y/ztvxePl9SqnwYOih6X2AuVjhsSlgKPCIAYGYuJ/OuazN23T0X2nPaf5?=
 =?us-ascii?Q?RqV+a3dNgCZUHOgjb4xndyKEtMrFo8gdxpb9UupmLiF2rzIz/6wpn0Y7bs4X?=
 =?us-ascii?Q?3F47WgNX6Hx858Iv5RtgMHeLiNsYPIVo6k4iK3wf+7yKskyShtgluudwy8lz?=
 =?us-ascii?Q?i2vdYHeLVWF7k0TEwzwUCZcq2RPNaLlBFsiAjjMw38FGSQjS/99RHCfUk0En?=
 =?us-ascii?Q?aEoFEMC1+xAXF7Wxb92uq+ZLk4R0PyVKvcBaMVn61t4dQJch6tt89qCBsehR?=
 =?us-ascii?Q?H++NP6xQsl+XQkuBYL5KE9R7jV73MXWtQdL5FEMgM0NsS+TszLquyRlNkwr2?=
 =?us-ascii?Q?D05PMbB2yMgo9EC8HNU6LK95kl6nyAMLtSOfbb/+75J8gUcAr5H3kn387gvT?=
 =?us-ascii?Q?LAtVTHHIYdJxrRcqqiBj3Az78ut1ji6i51sQm9BgNXx99veTK6tOeV0Uz9ZB?=
 =?us-ascii?Q?i6vJqjQrWBqLXFAx1M/VZ+KiX9ZabceNyT03wZ3+JAAPxgK/7gI6FCq2A1BV?=
 =?us-ascii?Q?DieCLWdcoYy3RYQOt72mkcOVkQQWR31Ot6LRYEWac5B8G/2V3PCWsLj31oGr?=
 =?us-ascii?Q?bmSX20BUax26T6FE4x+EqDqrt9GIJRttkgFWzwfCftfZo+2o0szljpFgTkSU?=
 =?us-ascii?Q?/uS/zjuQwEX0GH6OR8N2B7CVzOT2x4ZyK27tji1n2Rsl/VZTNv0kf9lQdCuR?=
 =?us-ascii?Q?IRZ3+FwlM1sbU2xl24TgeL47l406gvETpzRNiBBVnDHDpu5mfemoIbCK3ypp?=
 =?us-ascii?Q?iEBpJPsEM/SmQaS7YjB+L5dgpu4R+pC2/eRDAO4unDYywPF6Xy4gMaitOd/U?=
 =?us-ascii?Q?LMKEltaTvMGxktSoB/JJX+3+Bjs0NOvJHQBfTpaPcnxqfVzjl1+UoogF13hm?=
 =?us-ascii?Q?Zx6189XgYGZSGMgE/75XkH3JYEzywUfnAY4A57e2WDm3bSqh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: mcgLL0hT7fjHY9qZMhbhYRRtO1H8ocqGqJz5+LMkSGWCGVlP3yPNErBo4kmBCEVkMCOcJlsehwjxF3Y/ZCSvAOaZQcmMuXd3slhMbVbFyMsw7EE2y63oAzmW0IoGK/JOVdLcjTSZMeXMAJUuMPfnIsLknGvhjEpQK9uay5HHMlej6X5u2Cej+b3MWG2bk5K9oB2ymGaAsiyqe/Ge0zEs/a5pdbQpQKoyIKO4ixJK2aUOcjEJFxIpER6olBLcybf4daTCXklb9Aze2L/q9KNMCw/HzjwB+hmcD2YK1O0xv7sfPKkNkZas38/yhTUqknPGLl0OngpFLT5Aou3NAnR+Ww==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16a33654-c11b-4b51-b9da-08df1249a6aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2026 10:19:24.7452 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1LwhbVhB8WTtN3YCjzl3t/HKmVLSDDoqCrKOFyb5D5/V/eQxcJoOpm1qIOHjY+vzWlTcC95nNm+MJuXAeyodEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7448
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

> Subject: [PATCH v7 2/4] net/iavf: fix duplicate MAC addresses install
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
> Changes since v6:
> - renamed iavf_add_del_all_mac_addr and removed primary mac address
>   handling out of this helper (avoids double primary mac installation),
>=20
> Changes since v4:
> - rebased on next-net-intel,
>=20
> Changes since v4:
> - moved mac restoration in iavf_post_reset_reconfig,
>=20
> ---
>  drivers/net/intel/iavf/iavf.h        |  2 +-
>  drivers/net/intel/iavf/iavf_ethdev.c | 30 ++++++++++++++++++----------
>  drivers/net/intel/iavf/iavf_vchnl.c  | 11 +++++-----
>  3 files changed, 26 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.=
h
> index 1d52b3d113..34b9b4ad94 100644
> --- a/drivers/net/intel/iavf/iavf.h
> +++ b/drivers/net/intel/iavf/iavf.h
> @@ -482,7 +482,7 @@ int iavf_add_del_vlan_v2(struct iavf_adapter
> *adapter, uint16_t vlanid,
>  int iavf_get_vlan_offload_caps_v2(struct iavf_adapter *adapter);
>  int iavf_config_irq_map(struct iavf_adapter *adapter);
>  int iavf_config_irq_map_lv(struct iavf_adapter *adapter, uint16_t num);
> -void iavf_add_del_all_mac_addr(struct iavf_adapter *adapter, bool add);
> +void iavf_add_del_secondary_mac_addr(struct iavf_adapter *adapter, bool
> add);
>  int iavf_dev_link_update(struct rte_eth_dev *dev,
>  			__rte_unused int wait_to_complete);
>  void iavf_dev_alarm_handler(void *param);
> diff --git a/drivers/net/intel/iavf/iavf_ethdev.c
> b/drivers/net/intel/iavf/iavf_ethdev.c
> index b498258d58..f7aeac8c83 100644
> --- a/drivers/net/intel/iavf/iavf_ethdev.c
> +++ b/drivers/net/intel/iavf/iavf_ethdev.c
> @@ -292,11 +292,12 @@ iavf_get_restore_flags(__rte_unused struct
> rte_eth_dev *dev,
>  		       __rte_unused enum rte_eth_dev_operation op)
>  {
>  	/*
> -	 * The unicast and multicast promiscuous settings persist across a
> +	 * The mac addresses, unicast and multicast promiscuous settings
> persist across a
>  	 * stop/start; they are only cleared by a VF reset, which the driver
>  	 * restores itself. So ethdev does not need to restore them on start.
>  	 */
> -	return RTE_ETH_RESTORE_ALL & ~(RTE_ETH_RESTORE_PROMISC |
> +	return RTE_ETH_RESTORE_ALL & ~(RTE_ETH_RESTORE_MAC_ADDR |
> +				       RTE_ETH_RESTORE_PROMISC |
>  				       RTE_ETH_RESTORE_ALLMULTI);
>  }
>=20
> @@ -1095,15 +1096,14 @@ iavf_dev_start(struct rte_eth_dev *dev)
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
> @@ -3428,6 +3428,14 @@ iavf_post_reset_reconfig(struct rte_eth_dev
> *dev)
>  	int ret =3D 0;
>  	bool allmulti =3D false, allunicast =3D false;
>  	struct iavf_adapter *adapter =3D IAVF_DEV_PRIVATE_TO_ADAPTER(dev-
> >data->dev_private);
> +	struct iavf_info *vf =3D IAVF_DEV_PRIVATE_TO_VF(dev->data-
> >dev_private);
> +
> +	/*
> +	 * After a VF reset, all MAC addresses got flushed.
> +	 * The primary MAC should have been set in iavf_dev_start, restore

iavf_dev_start is not guaranteed to have been executed before this handler.
So I would change this comment to something like:
"The primary MAC has been or will be restored by iavf_dev_start".

Other than that:

Acked-by: Ciara Loftus <ciara.loftus@intel.com>

> the rest.
> +	 */
> +	iavf_add_del_secondary_mac_addr(adapter, true);
> +	(void)iavf_add_del_mc_addr_list(adapter, vf->mc_addrs, vf-
> >mc_addrs_num, true);
>=20
>  	/* Restore pre-reset unicast promiscuous and multicast promiscuous
> states */
>  	if (dev->data->promiscuous)
> diff --git a/drivers/net/intel/iavf/iavf_vchnl.c
> b/drivers/net/intel/iavf/iavf_vchnl.c
> index df97ff2052..a918db5443 100644
> --- a/drivers/net/intel/iavf/iavf_vchnl.c
> +++ b/drivers/net/intel/iavf/iavf_vchnl.c
> @@ -1672,7 +1672,7 @@ iavf_config_irq_map_lv(struct iavf_adapter
> *adapter, uint16_t num)
>  }
>=20
>  void
> -iavf_add_del_all_mac_addr(struct iavf_adapter *adapter, bool add)
> +iavf_add_del_secondary_mac_addr(struct iavf_adapter *adapter, bool add)
>  {
>  	struct iavf_info *vf =3D IAVF_DEV_PRIVATE_TO_VF(adapter);
>  	struct {
> @@ -1685,7 +1685,7 @@ iavf_add_del_all_mac_addr(struct iavf_adapter
> *adapter, bool add)
>  	int err;
>  	size_t buf_len;
>=20
> -	for (unsigned int i =3D 0; i < RTE_DIM(vf->mac_addrs); i++) {
> +	for (unsigned int i =3D 1; i < RTE_DIM(vf->mac_addrs); i++) {
>  		struct rte_ether_addr *addr =3D &vf->mac_addrs[i];
>  		struct virtchnl_ether_addr *vc_addr =3D &list->list[list-
> >num_elements];
>=20
> @@ -1695,11 +1695,12 @@ iavf_add_del_all_mac_addr(struct iavf_adapter
> *adapter, bool add)
>  		list->num_elements++;
>=20
>  		memcpy(vc_addr->addr, addr->addr_bytes, sizeof(addr-
> >addr_bytes));
> -		vc_addr->type =3D (list->num_elements =3D=3D 1) ?
> -				VIRTCHNL_ETHER_ADDR_PRIMARY :
> -				VIRTCHNL_ETHER_ADDR_EXTRA;
> +		vc_addr->type =3D VIRTCHNL_ETHER_ADDR_EXTRA;
>  	}
>=20
> +	if (list->num_elements =3D=3D 0)
> +		return;
> +
>  	/* for some reason PF side checks for buffer being too big, so adjust i=
t
> down */
>  	buf_len =3D sizeof(struct virtchnl_ether_addr_list) +
>  		  sizeof(struct virtchnl_ether_addr) * list->num_elements;
> --
> 2.54.0

