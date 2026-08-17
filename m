Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6F3C5DF66
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Aug 2026 09:18:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9CE7A40275;
	Mon, 17 Aug 2026 11:18:29 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 8AA234021F
 for <dev@dpdk.org>; Mon, 17 Aug 2026 11:18:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786958308; x=1818494308;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=MGKUi92i/haJJ0FdckWk6G/ygm7KFrFdccHX6BCgDRc=;
 b=BpWAgKCFSHx54GixwhL0pnUwnjw4ZzrHEK5GHStLmddLAzQb0aPaevKK
 CSkeL8QObUNdpoLC9GwQyUmr+91DllumEClC68+SIstMJdRoiVCHkUYos
 MyQG/yMt8+/UUw2kv82OIM2eYzYSKy4SDmS/UBMKRNoXwhzh2DMM5DZsE
 tFEmzFxrS9i2GHlF0pK68jIyMDNK4EiNAHbLa2mznUz52hxONZjkekKQG
 jlKsB3sfld8tQV4Blcm07yZSrXgTg6Yb6Co6aB3djIaiZh0A3ErpiwOgB
 i9LK8xuXfgux2Wu4+zlTftvQQhIXGDdUf//h9G1oFP2WpED5Now9nIe41 g==;
X-CSE-ConnectionGUID: BVaXZaOhQi+wwzqNaIYthg==
X-CSE-MsgGUID: b4hl2cV8QKiPSJaK1ig5ug==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="86387355"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; d="scan'208";a="86387355"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2026 02:18:27 -0700
X-CSE-ConnectionGUID: Jd0kwgznSVu3OiqvRo0q3Q==
X-CSE-MsgGUID: 3yKa8QlyQ8CZPiY+cIt+1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; d="scan'208";a="263098749"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2026 02:18:26 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 17 Aug 2026 02:18:26 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 17 Aug 2026 02:18:26 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.58) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 17 Aug 2026 02:18:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IpCZiGUfOM8ExYQ4YpQrNs16iV878oMO5PVWzx1wYL1gSoh2y1EwFom6YcVhEQtHXLvAB/Sqrhjsay2GXrdf2qMNqvjxEwS4fjeoHNCwbjScpnIX2PrWCCjVn8e8Fp/fxxStwU/Q6PWis/WPFo54L0rgCdaNOR2ow/SC8qqMWAuAGgTe9hmFNIwL1uMZz+55jV7FVTIjQ5vCL9fMT2iQ2I5iMTrLw633FTolWHaKffbmS3ezTHZ57lLLpCjMSfazvwFSytY7ZjJwb7o63A33CQRd0ilAD4cUMT/0EKw06Da1pmcYlXLF08KyfimPxuEhkL8kxzJlmahnvKn9E4duvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FmKXoYwUs9FV0I7tHwoqyRglYoTOnlvyq+TOkxhgMts=;
 b=TPAdcAScMyrZaeLU0bBjOcz4ZKSIplQ8ZKieFS1F2kF0eXCCyI3NH/e07J+aY3c27eZFxnQxwFadS4fx3k7A5jBZElwQG8N+6Yn3uqODHRcjJi0mF2hqHH1+zBoYbpSn0cgJPhfJ+jSGhgvKLOIK18tqFPhiBpwL8AVtuw+x42lkdXCOYwHKRYc2dgC5JVQOCEBTPO8+FZXu/ZHmWpEGYlCg75w2kWuJM0+W01zZ0qnCWpWyNyYAhIA9TPYRDVxaFR67gBaR/TmLP6k9ThwE7d+qS50u9I/kyKawXdbemTPP2+O4n2vZ5JiItZ2t+Vt71p373/lxhyKXAKTD5IrfGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6782.namprd11.prod.outlook.com (2603:10b6:806:25e::11)
 by SA1PR11MB8280.namprd11.prod.outlook.com (2603:10b6:806:25d::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Mon, 17 Aug
 2026 09:18:16 +0000
Received: from SA1PR11MB6782.namprd11.prod.outlook.com
 ([fe80::cd29:ea71:32e6:ff0b]) by SA1PR11MB6782.namprd11.prod.outlook.com
 ([fe80::cd29:ea71:32e6:ff0b%5]) with mapi id 15.21.0315.011; Mon, 17 Aug 2026
 09:18:16 +0000
From: "Mandal, Anurag" <anurag.mandal@intel.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "Shetty, Praveen"
 <praveen.shetty@intel.com>
Subject: RE: [PATCH v2] net/cpfl: add timesync support
Thread-Topic: [PATCH v2] net/cpfl: add timesync support
Thread-Index: AQHdIyrY2eXR2a7tkEeP+9q8YSFZzLaiDEig
Date: Mon, 17 Aug 2026 09:18:16 +0000
Message-ID: <SA1PR11MB67825EC0A3DAC9E8282B44FEE4A72@SA1PR11MB6782.namprd11.prod.outlook.com>
References: <20260728102008.860157-1-anurag.mandal@intel.com>
 <20260803093027.870965-1-anurag.mandal@intel.com>
In-Reply-To: <20260803093027.870965-1-anurag.mandal@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6782:EE_|SA1PR11MB8280:EE_
x-ms-office365-filtering-correlation-id: 828048c6-6261-417a-5aeb-08defc407898
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|11063799006|56012099006|10067099003|22082099003|18002099003|4143699003|6133799003|38070700021;
x-microsoft-antispam-message-info: NqhIkYwP3IoFMm4Zf5p1xV71lSpt1tBhtcoMZbdTsjqrSSeDyZIMxunEInAqV9XhaL2PYR0gn0b6PYd7LZZxBreYMJK5Jztf00x+COm+TysAc+SW+RLTSW50d9trsdm3xT2Ip/YqaRLikqQ4pnmAX6cCLUz/y4XA7HEDoHwrL+tLkNZMhpgfurDMvkAI/L328ykpyDfQrmJk/6UDqlsT/TOwlG3MK1g/7pTbMMzRzxinHiBTUEZMiDeaNkR88clOyLu78z976pjgHpqK6qADJ6KRMiuWWzdVXj0wVIsSoctkxBOcXkVGotqx9IVMzfXJwRonnmf+sj4YMnhvx4yq2WBRRercOm+q2/0+06sy7GZ2tDp6i1yBGgIDpVnf53FQUwhdlMIyMVzlgqdLsgzHTxLY3y4WI9u1+fXDklitUgL1JwBx9SGFSepnMXuhu8IisHcFpl8LXgzMlzbUKo9Sbkq8betz4/LcmCCVeR/4yei+flcUgBXHGycmkpVt6pkz7fUw9kjiHPNK9WoUW+vyCbhsmQHERAXy/3Qxh/LJiy+hM3BzeNNyq0ZZcur1fHVQjweGgjyItzRaqFFgP0GGqylsiMqEiPOlxeXE6xVYbJboq0Iezk8knTA0nIujgr7l1GLcFY52Pqc4kScks5IlMZDwAuTwUTcUSJt6KV7THAc2V6s7rrBniD0O1N+5nuCOxV7FmqnYQbLRiOx1JKztpA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR11MB6782.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(4143699003)(6133799003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PGmAzgJ0WX74Wuqi80GGoFAV6Vr1P9IqE1cqppCAD4L1QIQ0aH3x4VoxxkgM?=
 =?us-ascii?Q?n6mlBlVSaIrBrKByxsy0IfvKZsE4yd5K/nmuokfQ7OdB8K9BA6vdhm6A3RiO?=
 =?us-ascii?Q?ijM2NhgkrDGBMsWs5wzU0v+VETNDUtVR7aHoZHDvbfCR5XZXhENZ6UYZreHe?=
 =?us-ascii?Q?XE6kyhiiOfeI2kyTuudRZ/Ee3LvoG9OZxRZNkKvaKlg8rvofBAzNkgi8Bqym?=
 =?us-ascii?Q?M75Jqn43YbsE4rqIAYMB7kre9CekILMqQr59YMMZTMR4pZgr4uHkuFKePb9w?=
 =?us-ascii?Q?h/hEpR5s90XeN9U9Aolfm4fJKRNF8+ZmQXQqW0FwTDPqGHvWp4bNDOM3ytkQ?=
 =?us-ascii?Q?M+zBFbpTbXuLwTrIHQWdQUqI3geNNsktgbAI4qur2qYqfm2XdlDJoWjHGLQL?=
 =?us-ascii?Q?wo+NdkffdWJMBHnpee9w8p884qqu34bgV7EcqsVPKf42aHI6J7uHqSJplCqW?=
 =?us-ascii?Q?J86Sp5xlTVAUQNRnkBtttPNLukBigpJCYzH4dozNXranAWKuhoBN7ibQZZWI?=
 =?us-ascii?Q?AB/FJ+HUOPq+2bgUwAYrwf26ZcEM2yQaSmKobgyhPQWGW2x9mmIwbeC248bD?=
 =?us-ascii?Q?JYN7eP44K/BwLbQmYR27E4qAq/wuFTpVjjhQin6WQ5j2BUsROAGfT7+QnfI6?=
 =?us-ascii?Q?JDo7ShnGxWJKzQy1UjV/4zAaNyagZUcXMVQJTPNiH9Lgk7GhcJfZ94aMReG+?=
 =?us-ascii?Q?fvXZhdGfrMlyKvrE6KsSuYWcJ5KquVNdQ2watt0BKyzUNgcTH5J+a8AuiHmD?=
 =?us-ascii?Q?MnIqQc6XVvywHGR0S5VaKEZwaee2g5DAEjqFuOOH1Escrw40Ql36IO7e4jym?=
 =?us-ascii?Q?Ede6bpP1M7rh3iwCgJmaRVJ6+Y/rKDDH8HctxbQh++3tj58hgCKtmdG9hJfL?=
 =?us-ascii?Q?uc0JPw+pLBxiCD7u5OSTprwohLYy9X8TQdbzHSNhCDn3Puf5nM+x3QwiGou9?=
 =?us-ascii?Q?YRLjQQ51bD91brduhepTSBBrmzM6gqgSK2krEQR0c9mXGyNXWBLU13fdkC+m?=
 =?us-ascii?Q?nawVSxo+3j9qLos+KQNTbGC2jfQU6YH2uS1zh+imesOoRu9LoU7zRgVDjYmR?=
 =?us-ascii?Q?9L429cAs4J0TLL+aMPPlCZpevhULaYNRHFLh4x8lytYMTyBhuBfwxN1SeGDP?=
 =?us-ascii?Q?Id6sAGPbPFYJ/dVc5d38M8uY/A3QW2czxdeOz0/9N8LZwvVZwSWHjkjEvv4m?=
 =?us-ascii?Q?k9PYPF8t9jWuHxIJsszLzRe4HaEPHnFlnTPv/rKMzIKi3xUan1G4xGtpGRHg?=
 =?us-ascii?Q?DkoMyaQnMUggweix0iVjRZeTb8YG4VK6xmXriYGrZMhy7+wji+sKcCunyu92?=
 =?us-ascii?Q?YRYY8OdfpMTUyvCbG6V5na1JwRC8/bAh0N3o0B7ECodTnkigDaq4dJE6C7iS?=
 =?us-ascii?Q?xQctv3MLOC60v6nsmrNukrUBM2U00btbjEpcvhG3g+FFNXTRgfqOmskRFNNm?=
 =?us-ascii?Q?aFyOsLw1Fujo5G5qR0BFhniRakAoq5QtH288VnvqtdAJt1WEv74GuC03iaf2?=
 =?us-ascii?Q?nOZCaXOaLdP1aJNSgFAoHBQ69Drt3J18Ne3k9qqr4y70LVZwZgFAsBObVZd3?=
 =?us-ascii?Q?+c4ZrYHChYyPXxF3htpTDFvNAUKQAv9bsQCrrJzNbZVpPTtyRkev4UfQADrB?=
 =?us-ascii?Q?+yHl2q4vifrs8PCABVxTzDEqIbFwJPq1F5TsmYWbWgDyxk4eXs4DGJfTm79t?=
 =?us-ascii?Q?GGHlq5T+eKw2K8DMb2kJVTd12i9IfCirRG9jJO0Fj7az3UqfCj0yzI/sVFTm?=
 =?us-ascii?Q?IN46BmWe7A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: b6ez24Pas5fJCUKJPyjq7Lu3p3sSfrJNPX5nBWN9wuICt3TZcPqhgbZc9GECkPTKLZX+T7kB/f41LQECiNQfASIzv76ErASN3UtfjBaFjZ6WJsmoTVjiITh9jIda4ZodguPMYdLeETIuYRJot/6w/P5/KMlDzF5WKrWaMnzc+7P8dZSC+0F871nrGKTLj5y0LOnvxN14rGhAufWtf8A5i+MxN+tW2+2rJOlSvA0kgnqnXgIvjLkmR19ZrMxSzi0XO1/Nx64E0utYhQmA0wVn/C91rfV79Ca7OPlYu6tqfcU2wcoQb8tdMEe9lBacpAg8HyUhpAgSw9qAIHBF8yoWlg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6782.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 828048c6-6261-417a-5aeb-08defc407898
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2026 09:18:16.3951 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lRwucC5bIYqDc2Q9l1ofLFo5P7H9nHlAXNl5dEduJghZ0dm2HMK5Q3du8KGjIFiXxS2+Z4/sW+5GnwtFMbsuhw==
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
> Sent: 03 August 2026 15:00
> To: dev@dpdk.org
> Cc: Richardson, Bruce <bruce.richardson@intel.com>; Shetty, Praveen
> <praveen.shetty@intel.com>; Mandal, Anurag <anurag.mandal@intel.com>
> Subject: [PATCH v2] net/cpfl: add timesync support
>=20
> The cpfl PMD advertises RTE_ETH_RX_OFFLOAD_TIMESTAMP, so received
> packets carry a 32-bit hardware timestamp that the common idpf Rx path
> extends to 64-bit nanoseconds using the device PTP clock (PHC).
> However, it never initialised the PHC, so the timestamp conversion had no
> reference time.
> Applications had no way to enable timestamping or to read the current dev=
ice
> clock to correlate the mbuf timestamps.
>=20
> This patch adds PTP support by reusing the idpf common PTP helpers:
>=20
> - timesync_enable: allocate and initialise the adapter PTP state,
>   query the PTP capabilities, program the base increment value
>   and set the device clock to the current system time.
>   The PTP state is shared by all vports of an adapter, so it
>   is initialised only once.
>=20
> - timesync_read_time: return the current device clock as a timespec.
>=20
> - timesync_disable: release the PTP state.
>=20
> Once timesync is enabled, the common Rx path resolves the cached PHC time=
,
> so the mbuf Rx timestamp dynfield reports valid nanosecond values and
> applications can read the device clock with rte_eth_timesync_read_time().
>=20
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> ---
> V2: Removed read_clock support
>=20
>  drivers/net/intel/cpfl/cpfl_ethdev.c | 107 +++++++++++++++++++++++++++
>  drivers/net/intel/cpfl/cpfl_ethdev.h |   1 +
>  drivers/net/intel/idpf/idpf_ptp.c    |   5 ++
>  drivers/net/intel/idpf/idpf_ptp.h    |   4 +
>  4 files changed, 117 insertions(+)
>=20
> diff --git a/drivers/net/intel/cpfl/cpfl_ethdev.c
> b/drivers/net/intel/cpfl/cpfl_ethdev.c
> index 4315adb68c..e4dabd8043 100644
> --- a/drivers/net/intel/cpfl/cpfl_ethdev.c
> +++ b/drivers/net/intel/cpfl/cpfl_ethdev.c
> @@ -1335,6 +1335,110 @@ cpfl_hairpin_unbind(struct rte_eth_dev *dev,
> uint16_t rx_port)
>  	return 0;
>  }
>=20
> +static int
> +cpfl_timesync_enable(struct rte_eth_dev *dev) {
> +	struct cpfl_vport *cpfl_vport =3D dev->data->dev_private;
> +	struct idpf_vport *vport =3D &cpfl_vport->base;
> +	struct idpf_adapter *adapter =3D vport->adapter;
> +	struct timespec sys_ts;
> +	uint64_t ns;
> +	int ret;
> +
> +	if (dev->data->dev_started && !(dev->data-
> >dev_conf.rxmode.offloads &
> +	    RTE_ETH_RX_OFFLOAD_TIMESTAMP)) {
> +		PMD_DRV_LOG(ERR, "Rx timestamp offload not configured");
> +		return -1;
> +	}
> +
> +	/* PTP state is shared by all vports of the adapter. */
> +	if (adapter->ptp !=3D NULL)
> +		return 0;
> +
> +	adapter->ptp =3D rte_zmalloc(NULL, sizeof(struct idpf_ptp), 0);
> +	if (adapter->ptp =3D=3D NULL) {
> +		PMD_DRV_LOG(ERR, "Failed to allocate memory for PTP");
> +		return -ENOMEM;
> +	}
> +
> +	ret =3D idpf_ptp_get_caps(adapter);
> +	if (ret) {
> +		PMD_DRV_LOG(ERR, "Failed to get PTP capabilities, err=3D%d",
> ret);
> +		goto fail_ptp;
> +	}
> +
> +	/*
> +	 * Write the default increment time value if the clock adjustments
> +	 * are enabled.
> +	 */
> +	if (adapter->ptp->adj_dev_clk_time_access !=3D IDPF_PTP_NONE) {
> +		ret =3D idpf_ptp_adj_dev_clk_fine(adapter, adapter->ptp-
> >base_incval);
> +		if (ret) {
> +			PMD_DRV_LOG(ERR, "PTP set incval failed, err=3D%d",
> ret);
> +			goto fail_ptp;
> +		}
> +	}
> +
> +	/* Do not initialize the PTP if the device clock time cannot be read. *=
/
> +	if (adapter->ptp->get_dev_clk_time_access =3D=3D IDPF_PTP_NONE) {
> +		PMD_DRV_LOG(ERR, "Getting device clock time is not
> supported");
> +		ret =3D -EIO;
> +		goto fail_ptp;
> +	}
> +
> +	/* Set the device clock time to system time. */
> +	if (adapter->ptp->set_dev_clk_time_access !=3D IDPF_PTP_NONE) {
> +		clock_gettime(CLOCK_REALTIME, &sys_ts);
> +		ns =3D rte_timespec_to_ns(&sys_ts);
> +		ret =3D idpf_ptp_set_dev_clk_time(adapter, ns);
> +		if (ret) {
> +			PMD_DRV_LOG(ERR, "PTP set clock time failed,
> err=3D%d", ret);
> +			goto fail_ptp;
> +		}
> +	}
> +
> +	adapter->ptp->cmd.shtime_enable_mask =3D
> PF_GLTSYN_CMD_SYNC_SHTIME_EN_M;
> +	adapter->ptp->cmd.exec_cmd_mask =3D
> PF_GLTSYN_CMD_SYNC_EXEC_CMD_M;
> +
> +	return 0;
> +
> +fail_ptp:
> +	rte_free(adapter->ptp);
> +	adapter->ptp =3D NULL;
> +	return ret;
> +}
> +
> +static int
> +cpfl_timesync_read_time(struct rte_eth_dev *dev, struct timespec *ts) {
> +	struct cpfl_vport *cpfl_vport =3D dev->data->dev_private;
> +	struct idpf_adapter *adapter =3D cpfl_vport->base.adapter;
> +	uint64_t time;
> +	int ret;
> +
> +	ret =3D idpf_ptp_read_src_clk_reg(adapter, &time);
> +	if (ret)
> +		PMD_DRV_LOG(ERR, "PTP read time failed, err %d", ret);
> +	else
> +		*ts =3D rte_ns_to_timespec(time);
> +
> +	return ret;
> +}
> +
> +static int
> +cpfl_timesync_disable(struct rte_eth_dev *dev) {
> +	struct cpfl_vport *cpfl_vport =3D dev->data->dev_private;
> +	struct idpf_adapter *adapter =3D cpfl_vport->base.adapter;
> +
> +	if (adapter->ptp !=3D NULL) {
> +		rte_free(adapter->ptp);
> +		adapter->ptp =3D NULL;
> +	}
> +
> +	return 0;
> +}
> +
>  static const struct eth_dev_ops cpfl_eth_dev_ops =3D {
>  	.dev_configure			=3D cpfl_dev_configure,
>  	.dev_close			=3D cpfl_dev_close,
> @@ -1368,6 +1472,9 @@ static const struct eth_dev_ops cpfl_eth_dev_ops =
=3D
> {
>  	.hairpin_get_peer_ports         =3D cpfl_hairpin_get_peer_ports,
>  	.hairpin_bind                   =3D cpfl_hairpin_bind,
>  	.hairpin_unbind                 =3D cpfl_hairpin_unbind,
> +	.timesync_enable                =3D cpfl_timesync_enable,
> +	.timesync_read_time             =3D cpfl_timesync_read_time,
> +	.timesync_disable               =3D cpfl_timesync_disable,
>  };
>=20
>  static int
> diff --git a/drivers/net/intel/cpfl/cpfl_ethdev.h
> b/drivers/net/intel/cpfl/cpfl_ethdev.h
> index d41aa93191..a9e532a46c 100644
> --- a/drivers/net/intel/cpfl/cpfl_ethdev.h
> +++ b/drivers/net/intel/cpfl/cpfl_ethdev.h
> @@ -16,6 +16,7 @@
>=20
>  #include <idpf_common_device.h>
>  #include <idpf_common_virtchnl.h>
> +#include <idpf_ptp.h>
>  #include <base/idpf_prototype.h>
>  #include <base/virtchnl2.h>
>=20
> diff --git a/drivers/net/intel/idpf/idpf_ptp.c
> b/drivers/net/intel/idpf/idpf_ptp.c
> index 5c3fcb90e4..47830de239 100644
> --- a/drivers/net/intel/idpf/idpf_ptp.c
> +++ b/drivers/net/intel/idpf/idpf_ptp.c
> @@ -2,6 +2,7 @@
>   * Copyright(c) 2025 Intel Corporation
>   */
>=20
> +#include <eal_export.h>
>  #include "idpf_ptp.h"
>  #include "idpf_common_virtchnl.h"
>  #include "base/virtchnl2.h"
> @@ -38,6 +39,7 @@ idpf_ptp_get_features_access(const struct idpf_adapter
> *adapter)
>  		IDPF_PTP_ACCESS(adapter,
> VIRTCHNL2_CAP_PTP_TX_TSTAMPS);  }
>=20
> +RTE_EXPORT_INTERNAL_SYMBOL(idpf_ptp_get_caps)
>  int
>  idpf_ptp_get_caps(struct idpf_adapter *adapter)  { @@ -212,6 +214,7 @@
> idpf_ptp_get_cross_time(struct idpf_adapter *adapter,
>  	return err;
>  }
>=20
> +RTE_EXPORT_INTERNAL_SYMBOL(idpf_ptp_set_dev_clk_time)
>  int
>  idpf_ptp_set_dev_clk_time(struct idpf_adapter *adapter, uint64_t time)  =
{
> @@ -256,6 +259,7 @@ idpf_ptp_adj_dev_clk_time(struct idpf_adapter
> *adapter, int64_t delta)
>  	return err;
>  }
>=20
> +RTE_EXPORT_INTERNAL_SYMBOL(idpf_ptp_adj_dev_clk_fine)
>  int
>  idpf_ptp_adj_dev_clk_fine(struct idpf_adapter *adapter, uint64_t incval)=
  {
> @@ -487,6 +491,7 @@ idpf_ptp_read_src_clk_reg_mailbox(struct
> idpf_adapter *adapter,
>   *
>   * Return: 0 on success, -errno otherwise.
>   */
> +RTE_EXPORT_INTERNAL_SYMBOL(idpf_ptp_read_src_clk_reg)
>  int
>  idpf_ptp_read_src_clk_reg(struct idpf_adapter *adapter, uint64_t *src_cl=
k)  {
> diff --git a/drivers/net/intel/idpf/idpf_ptp.h
> b/drivers/net/intel/idpf/idpf_ptp.h
> index 0c901440fb..851cdad027 100644
> --- a/drivers/net/intel/idpf/idpf_ptp.h
> +++ b/drivers/net/intel/idpf/idpf_ptp.h
> @@ -88,13 +88,17 @@ struct idpf_ptp_dev_timers {
>  	uint64_t dev_clk_time_ns;
>  };
>=20
> +__rte_internal
>  int idpf_ptp_get_caps(struct idpf_adapter *adapter);
> +__rte_internal
>  int idpf_ptp_read_src_clk_reg(struct idpf_adapter *adapter, uint64_t
> *src_clk);  int idpf_ptp_get_dev_clk_time(struct idpf_adapter *adapter,
>  			     struct idpf_ptp_dev_timers *dev_clk_time);  int
> idpf_ptp_get_cross_time(struct idpf_adapter *adapter,
>  			    struct idpf_ptp_dev_timers *cross_time);
> +__rte_internal
>  int idpf_ptp_set_dev_clk_time(struct idpf_adapter *adapter, uint64_t tim=
e);
> +__rte_internal
>  int idpf_ptp_adj_dev_clk_fine(struct idpf_adapter *adapter, uint64_t inc=
val);
> int idpf_ptp_adj_dev_clk_time(struct idpf_adapter *adapter, int64_t delta=
);
> int idpf_ptp_get_vport_tstamps_caps(struct idpf_vport *vport);
> --
> 2.34.1

