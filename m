Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0697AC5DF66
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Aug 2026 09:18:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0FFBA40275;
	Mon, 17 Aug 2026 11:18:49 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 992F34021F
 for <dev@dpdk.org>; Mon, 17 Aug 2026 11:18:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786958327; x=1818494327;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=UuZIweZ7aKMoBEyQaXaen0E3kHJA8nrqlprWw6prNhA=;
 b=XXE7/7UoGdQ+dB+U3/kVZo36a+CDt2waXWfHfSRw5bCBAReqrrXqh4h7
 Kyqbqdr7IMObmeicrSz5MylnWoIgZU6Rj1iy23bfDM+7p9cvCIn5oPFCN
 XtHjBIZMfWGc7N2MeF7NEhKmfGs6ajECfjqqM1wSLXkKdfa5gu0EfZkb4
 oClewgXt+co/aromUxzS48SnsTBilyI5O2l7Bu0kUmIAg4n42l5ODKVCX
 6+NSkJVB8NWP7CW0mVSbvSVMa1MPTiMMTkzp0kUfUfLCewjjDwxO51bmh
 +veco8cW4fP/CLixsndn7Jrx/P8sQuyRrfFtvk347PzpQ00P2k+jv3Oto Q==;
X-CSE-ConnectionGUID: nnYxlx0dRFmdhNeY1o/nWA==
X-CSE-MsgGUID: JLKVciLRQi2OtR3VkeeAGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="86387373"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; d="scan'208";a="86387373"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2026 02:18:46 -0700
X-CSE-ConnectionGUID: OIozYnFNR6eo1snHoAW5qA==
X-CSE-MsgGUID: 8P+rRVHXTaaBEeaQ4/W7hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; d="scan'208";a="263098793"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2026 02:18:45 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 17 Aug 2026 02:18:45 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 17 Aug 2026 02:18:45 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.4) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 17 Aug 2026 02:18:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gq+dJyjqgMHOuIoY1AHOcbm0mvTMTwm08WeIVCCzcQSmo+v9kEWtIerXjoedHLR3iCiVPfVzMfYmkRZGBXPt8PrJsoMOANxccY0w8aSOpK/S8i4e2TcEW8KAqgxOhQ2AohheEWkiaePGq+uDEiOvTCcUGgiaXPMRA/FH83AHKL72n3y5/6kYXAtgypOzUygsntHDuWoOVJaJgxTbati5Dh4K7kkQ9RHRgiRtsMig0iYPuJ+lXx67EdG1htahSKUW/ko/xuYNzirMEKLl0vhDwzdHSk2xvRqW0JicKRbpNSeglbHpFta5t+CBeVcwzxBmqOm3V8I4sqkyBwo65KPqiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xPVGZBu5p0/l0m+rvuGYcRNgrouSFklqktgy4CU9f68=;
 b=TqPwgCPVtn31EobdoCTewWcF8lgrWdYb3BUov5NIh5Q/5kNqnwQAANKV8gWnKK8tSZ3LmeHjc9psC6HapIsgycWzBGjsFpOwiWUyeSKLeHiqUREBJJpo9W/C5Uva10uN3gMILr0R/Z9sfJXv+NmYMwbclUwI7syEgOMte1CPNTO2kw6zHUqRjVwOxxEZ2SHbTrC+JJ4HbtfdXw2shMPi6gIe3xtQBbePAr4ltnF3VCsEE5vmFKnqNimjN2obFUy3eZwfS+vu0YqKDrTI6CG7bUqVjxbOEc5UUEEb8t9VWIwo/IpadBw5yV3E0XEoEmfS/qQJWYkPbuNqH9aCy6TXiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6782.namprd11.prod.outlook.com (2603:10b6:806:25e::11)
 by SA1PR11MB8280.namprd11.prod.outlook.com (2603:10b6:806:25d::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Mon, 17 Aug
 2026 09:18:42 +0000
Received: from SA1PR11MB6782.namprd11.prod.outlook.com
 ([fe80::cd29:ea71:32e6:ff0b]) by SA1PR11MB6782.namprd11.prod.outlook.com
 ([fe80::cd29:ea71:32e6:ff0b%5]) with mapi id 15.21.0315.011; Mon, 17 Aug 2026
 09:18:42 +0000
From: "Mandal, Anurag" <anurag.mandal@intel.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>
Subject: RE: [PATCH v2] net/iavf: add clock read support
Thread-Topic: [PATCH v2] net/iavf: add clock read support
Thread-Index: AQHdHcmIdIJmlGACvkW8Ok59M+Be1raiFyNg
Date: Mon, 17 Aug 2026 09:18:41 +0000
Message-ID: <SA1PR11MB67820B908B21E2F7A30F189FE4A72@SA1PR11MB6782.namprd11.prod.outlook.com>
References: <20260727102444.789833-1-anurag.mandal@intel.com>
 <20260727131016.790792-1-anurag.mandal@intel.com>
In-Reply-To: <20260727131016.790792-1-anurag.mandal@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6782:EE_|SA1PR11MB8280:EE_
x-ms-office365-filtering-correlation-id: c1568c8a-77b5-4079-bbfc-08defc4087d0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|11063799006|56012099006|10067099003|22082099003|18002099003|4143699003|6133799003|38070700021;
x-microsoft-antispam-message-info: HOd5sSrpjZr7q/EwyBOlroOQLkryscnUPaIP0AdJmJ5IDJRJXadgpEXYS/XMxajdtvqgMjQc8mu883JadvzHVDiqMcEtwCEGvlk/WI75bEuI2gYbL0Xyx0mwj9dFxIyJA8KHE5uaXNB8XPRCvqP/+gDzPviUO9ewKsoqFPZRdIxgaG3tebfjk/qwqQ/ZPDxMXBcHvuZo04cDJzKN/AC2c4irxJ+L9txzack7v+iHaLvXNrtDW7NIlcdwx7OxA7fT+oLnbEWDHqWpnSzlxX9KhZHoGa8BwT10lwIjCGVC1YHesgHKDaViLI0Xy50hG/4rljegxhyF5OngdpK5MvnYUDqEVFcodgS7KXYUjJjFytQVKo7spX5KRh3WVEwJYGhfdsa2noXyw6AXyDc87BVEdl9lrbvuqiu0mxH1JgUcx3D+Sg8l/5C+nDzSDPYNptzCFIVam36sVyDMJf6oFr2kqZvILXGgXVlZ4sFnL4Y7ljFFlkM+GvEAHld1nVzK2YVkHoyz/c8Gp3ljT4REm5TB2Qzxkd2G/oRSBFsQ+JfikL+be79qR+6/H7QQT0SIs71FxIBc5Qgnidj941q51ExV5l6FH4lbGcE3ny4LV/zv3ah2LkoFoCtFjcnlpEOo2njREoTarG2FEio6HXRyz7DC4amk6Yc8j4p1aCxqSuFYoUTQbO5Ul06zTc6PqdUpkhvGEM5fsXgzzhIkAS+z623l/DTzvCWgaaBPKCZoyjwEsWE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR11MB6782.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(4143699003)(6133799003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JRRnDqy73SZ8OtGSfL4ja++CTVsRtDG1niIJLfDgeDNBXxjxKCUw2GcbA6PZ?=
 =?us-ascii?Q?UiLXEscs/MbW/LBxsRJ9XTC0Lb/MNrqgy5CG906hghW4R3eN+dumn7fajKHD?=
 =?us-ascii?Q?h+SThHmxPrecrFKBHaAFAvaAZRl3kk+xkr4SXMZtGPYANH/b4jlZSjGenWaT?=
 =?us-ascii?Q?oA8Z+ItwaxFchxIRKJr00X7bcVF8ZLfUZzEXsM5RJ1l0Qnmd11nvIQzS9GYF?=
 =?us-ascii?Q?lzRZKVP8cimENpxl2k0v/qlz1BZAyzCFK5qJwNxoXIFyQQ3ElxoLuLDZBzT1?=
 =?us-ascii?Q?zXIbU299yvN1cicc1EaZCPYmwmUyGYU35/GcMnSlMrm6ZdG/znHg5H9tD68j?=
 =?us-ascii?Q?yE0VjHfQmgf4vgvmCzSK031E1Ps/rLVhDaGsRV3XJ1JEU2s/4xm+io58IWgB?=
 =?us-ascii?Q?GvH5pgEiOf+qc05qq+Aq+DwuJuxuNKm1sGm2fXSk4k0TZOunHEFjm2p40HQt?=
 =?us-ascii?Q?HjM9DlBhDOCxc6MtIQr2Au+ji9tJv1fZEM3pcz7Wgf0Wo91yMZeRJ7L+sPzf?=
 =?us-ascii?Q?fqz8iVELlGeq84uSEdor8QMlFi9Begf04Jr5wPvAetLsBYG8Xw+8RtBihlxD?=
 =?us-ascii?Q?i3WzoJp83vfC+7jyV46K4dglbDyWbXSx21MqaKLaHWv6DUBlw7Km2j+kwnsf?=
 =?us-ascii?Q?4LSNaTXqHRjBC7+jsgdtU5QgdW/QdyckKX6RaET7bCfvjVLRkB1QDOACsGlP?=
 =?us-ascii?Q?NhHQGKcenURwW5shQFVbsYhJ9yHG0m6nVZQE2yYUb8kLnrp9BisdYaqAKXon?=
 =?us-ascii?Q?Ri4Jk209Jp8qi2kSZl7A/u3LVimPo8a1Fk/lt0dhRUzSfTBq2bCHSPIefSun?=
 =?us-ascii?Q?DAyl0AP+1SQ0b66H7pWHtlm65+AkKY1weSyOHOsl7iMzXG1lJLaLn2AoYDc6?=
 =?us-ascii?Q?ybqBMM81Tgx5rMgPCdt/Zk+6nXYWjoMxZWdrSLAjvpYDV9VWRgle2bhjDbko?=
 =?us-ascii?Q?t8nTSQgRLdIrIdIFCxC7wVGlHF++ckSrqutpKkH99Wxof1kvDyOwLMpCxu9b?=
 =?us-ascii?Q?+BAGVRi+DLJI2aJvShawTjnnpIjGnO4boBfCaiTBgeVtZw2up0OoqyxIQDKj?=
 =?us-ascii?Q?1jd/sRO9pPizU4zL7BOrckg7ODlvKrfg9U2i5T4WRyyw1ZkI5c0ptPiWQrov?=
 =?us-ascii?Q?RYbWpgydxPpJ9GxP1v4pS7PtKwkHBxwMZfm1vVbTxMBiK+ZDrmRApnEh10vi?=
 =?us-ascii?Q?38wNM2KufI783fkgMZ95cpwvOlN+Ql9Dcera3iY+nf46Zb+f16RHyUvFAQq5?=
 =?us-ascii?Q?ZpzMWJZN6O4NmFwoUAobmSaqmt2i/jn3vOn1lvoNS1oV7szkIJ3gcyg9svlp?=
 =?us-ascii?Q?B9piby77oQy/3P0hW5pVMLy1iCP7YLr11zQ0NIV0+ZMnHizG/R8Xr4l7YtF3?=
 =?us-ascii?Q?NFntO1urqgmlTzGqr/jzE1Xz8sobWTa2q50eGDZ7pzydpwXQxWePHGPUFUSW?=
 =?us-ascii?Q?KzxzmxxsCXuJh59mBONO/XNiSIFwu8JlJLqMRJKjPTflb3yZuiy/2e9zsXqp?=
 =?us-ascii?Q?tlLuTvDl8Tnt4cN395fQaU9XWo6qxPEIiIqZQjGOCLhBvmj59xP6Dj+nheuY?=
 =?us-ascii?Q?pk/TroEUqFPR4FCYmWDHC1rTzKNv6Rr/GplFR3NRCW9FXRBUBMtj+HUhejNQ?=
 =?us-ascii?Q?QaH7GppH29HIfhiMtQfD6Kfhd7W5N3q1VXhyuNxkjm7JnL6A2dKyAJXLlCfg?=
 =?us-ascii?Q?n2TKvzafD5UljXAkrguerzfYyKo60R2QV67/ZFn8xqIYutlHkRJfFkysOtbQ?=
 =?us-ascii?Q?oQ/fUD+Zmw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: T3R6N2gBH7cX1oh+vBe3BvhzbyvL5jLbxhRvIONKKSUQrlX64xW+Dr3p2fEhbIbM5sY2+C6x/ISLEY9ym8HzME6lyCGDn3hq8GbcP+Dlrq0mTjbNHS87OV1IFbaef0GQOly9K1Avu32WXgz7J1qw568ExrnJVzGJBTr1XGrcsmNl7w/875UsQy5sgWaqo2SvKUrCIY27O4VDpoaAoQhHeXsPq8OWAxLAbnOkxBKz18rblMVWFyAMhMYQv3/WZGCfBskwUMzCXKS0B4iHT7vu19NsxC7Ddqro8W1XeP8M+A1dJY2VzZfM9Squ6ESIcYlp9tS/Om7gyc2zPUZVRbkTOg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6782.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1568c8a-77b5-4079-bbfc-08defc4087d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2026 09:18:41.9522 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XUJJXQ8BD8ZIZJxTzEMg0QpF7AfbJcCgka5WnbaZYgRokGeeay6nTudm20IBMPg0TDqGJnSurC5vjDaplkyPWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8280
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

Hi All,

Gentle reminder for review & ack.

Thank you.

Regards,
Anurag M

> -----Original Message-----
> From: Mandal, Anurag <anurag.mandal@intel.com>
> Sent: 27 July 2026 18:40
> To: dev@dpdk.org
> Cc: Richardson, Bruce <bruce.richardson@intel.com>; Medvedkin, Vladimir
> <vladimir.medvedkin@intel.com>; Mandal, Anurag
> <anurag.mandal@intel.com>
> Subject: [PATCH v2] net/iavf: add clock read support
>=20
> Implemented read_clock ethdev operation by adding
> iavf_dev_read_clock() feature to get current time in nanoseconds for
> scheduling packets based on transmit time.
>=20
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> ---
> V2: Addressed minor typo
>=20
>  drivers/net/intel/iavf/iavf.h        |  1 +
>  drivers/net/intel/iavf/iavf_ethdev.c | 24 ++++++++++++++++++++++++
> drivers/net/intel/iavf/iavf_vchnl.c  | 13 ++++++++++---
>  3 files changed, 35 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.=
h index
> 293adaf6c9..416625d9fb 100644
> --- a/drivers/net/intel/iavf/iavf.h
> +++ b/drivers/net/intel/iavf/iavf.h
> @@ -533,4 +533,5 @@ void iavf_handle_hw_reset(struct rte_eth_dev *dev,
> bool vf_initiated_reset);  void iavf_set_no_poll(struct iavf_adapter *ada=
pter,
> bool link_change);  bool is_iavf_supported(struct rte_eth_dev *dev);  voi=
d
> iavf_hash_uninit(struct iavf_adapter *ad);
> +int iavf_phc_get_time(struct iavf_adapter *adapter, uint64_t *time);
>  #endif /* _IAVF_ETHDEV_H_ */
> diff --git a/drivers/net/intel/iavf/iavf_ethdev.c
> b/drivers/net/intel/iavf/iavf_ethdev.c
> index e475b64971..1a36885107 100644
> --- a/drivers/net/intel/iavf/iavf_ethdev.c
> +++ b/drivers/net/intel/iavf/iavf_ethdev.c
> @@ -165,6 +165,7 @@ static int iavf_set_mc_addr_list(struct rte_eth_dev
> *dev,
>  			struct rte_ether_addr *mc_addrs,
>  			uint32_t mc_addrs_num);
>  static int iavf_tm_ops_get(struct rte_eth_dev *dev __rte_unused, void
> *arg);
> +static int iavf_dev_read_clock(struct rte_eth_dev *dev, uint64_t
> +*clock);
>=20
>  static const struct rte_pci_id pci_id_iavf_map[] =3D {
>  	{ RTE_PCI_DEVICE(IAVF_INTEL_VENDOR_ID,
> IAVF_DEV_ID_ADAPTIVE_VF) }, @@ -264,6 +265,7 @@ static const struct
> eth_dev_ops iavf_eth_dev_ops =3D {
>  	.tx_done_cleanup	    =3D iavf_dev_tx_done_cleanup,
>  	.get_monitor_addr           =3D iavf_get_monitor_addr,
>  	.tm_ops_get                 =3D iavf_tm_ops_get,
> +	.read_clock                 =3D iavf_dev_read_clock,
>  };
>=20
>  static int
> @@ -3662,6 +3664,28 @@ bool is_iavf_supported(struct rte_eth_dev *dev)
>  	return !strcmp(dev->device->driver->name,
> rte_iavf_pmd.driver.name);  }
>=20
> +static int
> +iavf_dev_read_clock(struct rte_eth_dev *dev, uint64_t *clock) {
> +	struct iavf_adapter *adapter =3D
> +		IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
> +	struct iavf_info *vf =3D IAVF_DEV_PRIVATE_TO_VF(adapter);
> +	int ret;
> +
> +	if (adapter->closed)
> +		return -EIO;
> +
> +	if (!(vf->vf_res->vf_cap_flags & VIRTCHNL_VF_CAP_PTP) ||
> +	    !(vf->ptp_caps & VIRTCHNL_1588_PTP_CAP_READ_PHC))
> +		return -ENOTSUP;
> +
> +	ret =3D iavf_phc_get_time(adapter, clock);
> +	if (ret !=3D 0)
> +		return -EIO;
> +
> +	return 0;
> +}
> +
>  RTE_PMD_REGISTER_PCI(net_iavf, rte_iavf_pmd);
> RTE_PMD_REGISTER_PCI_TABLE(net_iavf, pci_id_iavf_map);
> RTE_PMD_REGISTER_KMOD_DEP(net_iavf, "* igb_uio | vfio-pci"); diff --git
> a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl=
.c
> index f346837bf1..a63639549c 100644
> --- a/drivers/net/intel/iavf/iavf_vchnl.c
> +++ b/drivers/net/intel/iavf/iavf_vchnl.c
> @@ -2521,9 +2521,8 @@ iavf_get_ptp_cap(struct iavf_adapter *adapter)  }
>=20
>  int
> -iavf_get_phc_time(struct ci_rx_queue *rxq)
> +iavf_phc_get_time(struct iavf_adapter *adapter, uint64_t *time)
>  {
> -	struct iavf_adapter *adapter =3D rxq->iavf_vsi->adapter;
>  	struct iavf_info *vf =3D IAVF_DEV_PRIVATE_TO_VF(adapter);
>  	uint8_t msg_buf[IAVF_AQ_BUF_SZ] =3D {0};
>  	struct virtchnl_phc_time phc_time;
> @@ -2543,9 +2542,17 @@ iavf_get_phc_time(struct ci_rx_queue *rxq)
>  			    "Failed to execute command of
> VIRTCHNL_OP_1588_PTP_GET_TIME");
>  		goto out;
>  	}
> -	rxq->phc_time =3D ((struct virtchnl_phc_time *)args.out_buffer)->time;
> +	*time =3D ((struct virtchnl_phc_time *)args.out_buffer)->time;
>=20
>  out:
>  	rte_spinlock_unlock(&vf->phc_time_aq_lock);
>  	return err;
>  }
> +
> +int
> +iavf_get_phc_time(struct ci_rx_queue *rxq) {
> +	struct iavf_adapter *adapter =3D rxq->iavf_vsi->adapter;
> +
> +	return iavf_phc_get_time(adapter, &rxq->phc_time); }
> --
> 2.34.1

