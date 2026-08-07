Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF3CC5AC7A
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Aug 2026 10:46:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB9704027E;
	Fri,  7 Aug 2026 12:46:42 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 19EA940264
 for <dev@dpdk.org>; Fri,  7 Aug 2026 12:46:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786099602; x=1817635602;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=8OTOG5xE2z/eI9tDpLk/wpFL0V1qhOuSuNqWsBhCwKg=;
 b=UhNefjRHqkPEOEEvw8lGD0DaU7ivQkeBmts3U4GUGNWWZCT5MGzP/ibO
 VMUn3HSV+HUfchjOq0wMbCGeUoQzw8bBF2GR4vFsZQ37rafaVOkzYetn0
 NRU56aPKO1+hWIq+AoT0CdeQ/AozN4CVybodq9CFUz6Ankhdgh33ookiA
 PD0NUmkrTZ6KBhIR0EhMrFUuTJ5VF0lJHz4ZAZfxzITMn8Ca+NUx4pfli
 ZjoYLPQIBFye4rbHH76qBNS7/ZVjx+i0tZgz0KudZ3H/B5mCQ6w63e71j
 TfIbeG23r+qyrkbX/sjIWHMo11UJ3KAB6x3lY9+AcELGXXKjL0EomCKCV g==;
X-CSE-ConnectionGUID: BX2Fl25oT3qoI9OzAOTsrw==
X-CSE-MsgGUID: MoIj8BQWRwef3ADtofJNAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86783991"
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; d="scan'208";a="86783991"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2026 03:46:34 -0700
X-CSE-ConnectionGUID: PmOID4GrT2WJstiBqau99A==
X-CSE-MsgGUID: y72LfwJDTBaDSQnf4usyYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; d="scan'208";a="262414973"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2026 03:46:32 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 03:46:31 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 7 Aug 2026 03:46:31 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.69) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 03:46:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m+EBvlVIwDonA5qsmL6bNqX+MmF+2irzYdpgBm0cjPJsGUiMniTWHUxOVIiYUj5Gecxi4E1BRRCQmYHzrjcVtffwjTrnSV4E82qhXnJePpzCucMKletDQhGtoU+G8Z/pT/QGN9SK4z28tcognIJh2Urseo3YG2KPkwd/9g8kz0WhcNE1QrpNx6SkMj40lwt1jnQq7fcB1VzF2aEOaVA+DwtQ08X89pf0RRWXFxls1l3f4XuAI41GVsbZw58EoFuHt+KrS6GcZwrEoO61oP2UbuvQ7KDPGgul9QPGX7XO+YLoQG9QeaWLFfa0AUxZIOeVTt4epzeyo5o71Wtwx9K/uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G/aEkK3S6CgtnW4AAqOuzjxqU2kuUWtALajacTIZgLI=;
 b=YZ7yfGi0BOkLpTAZtZc+QPl4iG7qXsNQ4aJ2oFiQNYIlu2x5vBM7ykjVlP9CG0rKXLjDsmX1hAzUchD4i1aMwQV3y5fIvhLvE4n0gg3hEuY4v/zBpf75ecYoNLkPYrYNUfvNwS7SQzIT8bJ87Tm3nQcnMHmtdddFaQ98jh3gBzmd2dfO+IvQm3670eqWo4W69OOpy24a2f1/IKHVYyFtOUR/tthdurK69FdaUs1eKx4yZaLuvsglk3T1qW7Xvd2kyGUKQ1WZRl0W93sClN0dmaDC6V/Y4yLkUznKa8ZddgreJYTYRBTrJZd6G75L70B06QQS3Mnx66fEiSJcbtyeHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA4PR11MB9278.namprd11.prod.outlook.com (2603:10b6:208:563::12)
 by DS6PR11MB9895.namprd11.prod.outlook.com (2603:10b6:8:460::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Fri, 7 Aug
 2026 10:46:28 +0000
Received: from IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057]) by IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057%6]) with mapi id 15.21.0270.016; Fri, 7 Aug 2026
 10:46:27 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Mandal, Anurag" <anurag.mandal@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>
Subject: RE: [PATCH 2/5] net/iavf: defer device start when PF VSI not ready
Thread-Topic: [PATCH 2/5] net/iavf: defer device start when PF VSI not ready
Thread-Index: AQHdJX17FOdMGHC3AEWD9Og2G8CcZraSZKhw
Date: Fri, 7 Aug 2026 10:46:27 +0000
Message-ID: <IA4PR11MB927865ADBA29A49F57FECA118ED12@IA4PR11MB9278.namprd11.prod.outlook.com>
References: <cover.1786004043.git.anurag.mandal@intel.com>
 <39df153b08742a36bfe74bac5026d14a2dc95f1d.1786004043.git.anurag.mandal@intel.com>
In-Reply-To: <39df153b08742a36bfe74bac5026d14a2dc95f1d.1786004043.git.anurag.mandal@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9278:EE_|DS6PR11MB9895:EE_
x-ms-office365-filtering-correlation-id: c6d82d9f-2c8b-4e3c-65b7-08def471224a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|38070700021|6133799003|56012099006|22082099003|11063799006|5023799004|10067099003|4143699003|18002099003;
x-microsoft-antispam-message-info: STeVD8gNTvGrZ0RXMX/CRydrSbTiJerA6F/0NBWrsGhQCQBD2mtKZaMo+R+jgbhAPOplMT+C2UtWeC7bDmTM+zVBtiUhwJwmEMhNgHtcUQaYrHwtAM0IZC/xWQCFVNUjMIID6e8odTD9jeg2L5tB/fs1BQ6QIDwxBWC2cZrOqyR4YHIz8WwxbNsbj31tK9epOG0MnrE8rvri0fpL1rL5DiHoo088d9UkLt1z+YIq8w6u4jzmWWCyI7u/BvZ5+NGY+Dw7FKOBxAoo2yZ6kyQxZMzxV0JnMgJC/gxa+8JUfESA2KS9U2hgoSgZqZABf1pjMmJY+5SkXrnSAfbNfLr1uR34OfxZVxDC/9UzG4N8FQ4HIaDLE8gpfUkMRq8CjlPLygNmNHIEGUlihUvogglnJ8Q66vKsJshkkSQ9BJm7+UCb1GeZjI834yiUhG0+okqpO/4AAbp7IPmCkUZVFYKFIthq5uT9cyKRkPABpsCns3kjQxOl7cRcpBuI5+kUhUWA+EIP3ax/j9iqfKpHg0SwY9U6i0r5RUUO6dCdV15+XfiqFogvOXrPUiUoVBRTdJk7a20D3xpbuggHUXmcCOL3DkrMV/Fpmpe+PaKmnCthsag1Hz+hbtIpZ1puYzliqCEs7Go7ANdzbDxwdfvv+mtX89cAaOnp0vvl+lTpPyouD42v9iuE5f1rie9Fh1++3j5hJvALidHM8GE7aNiEs1iumBUZnM5MMipAfJ6Mdg6+9zI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9278.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(6133799003)(56012099006)(22082099003)(11063799006)(5023799004)(10067099003)(4143699003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gNhTo+hVIpj9ABbSMCTFsS4vmbOtS6x4RImeDBYgrhLaWiRDQPc9dNIa9qNQ?=
 =?us-ascii?Q?DiYb9MlwpDFuAzNtOMiZwx4uH5BR9QmUkivPJBlHfnFMMbRYmLM9lvVixG4L?=
 =?us-ascii?Q?Z2mX9UeixfGOunilVlHoRIVTH4q3dXnx/YHrpZM5D5DKxCMkG0Nza5aN6aUF?=
 =?us-ascii?Q?Rc1JLBWbrqlV9b0JEftc2hvPZX7A6e2+yMzL/9o8SW2MPRncCa3Z0po8CDCH?=
 =?us-ascii?Q?XSra6py5CDYuhmJNDFUyTEdza5B1yp1z3GU6Ml1UhhEBItL/UzWtttm5Lj4Y?=
 =?us-ascii?Q?OyBeeTIdzrRIunoacM2UtOtrJ0SsgwhNHRayNsDZm1siZLWMfdoriIq8BSHW?=
 =?us-ascii?Q?J8SY+5s1GBItAnO1RH/tUFV6rczDFf3ZkwpvXApwb2Nl49NuhCk9CgKScotr?=
 =?us-ascii?Q?tOgFCVG3iKlAq9xwvbZZ0L3xr73rOjHQ7DjG36p/Y5xKBbfvXxO5kTZNuxr9?=
 =?us-ascii?Q?kX4JSCjnZklzAkytALr3J2vR0XJTqy1PibM+6HxRnopAtEWNNybgcmr5kOmW?=
 =?us-ascii?Q?D0dRusQILxSCFprDSVahQ0jiGo5/S1vtW80BxxLrdREqay/OlMtmlwuyKg+Z?=
 =?us-ascii?Q?6irmOrrtO8V6m9mOO0cUey51XJL/u0EQ0mRhclnTCy1mZcWzhBRkVOaGamzI?=
 =?us-ascii?Q?6Cxldgw5p+xulbxhXpLpvLIR/MvSgZNP8jENKbito42oNSle7Ex7dh5gyyTb?=
 =?us-ascii?Q?XnBHbYJIkfhUPcqY9nZU8cll+Wlxpe35jC1Pt8r/dlI6i3tvVhAeK8j9h/J/?=
 =?us-ascii?Q?nUiApZNZ+Pfc+k1TUaRhOXAnhPpkmePgUs5GtyFmqbykY64rP3CMzZHfY3zM?=
 =?us-ascii?Q?LkJbctvf+EG98g3GqZOf+paW8Aoh0sfKoasZ6hV14jF5mkDqpan+sY5zPDfd?=
 =?us-ascii?Q?VksIj2sR3l5sRBkiwyBRyQbmV/yq4rLrUfjN/o2sojh79NCFU622NRtGO+I9?=
 =?us-ascii?Q?yc4pP7Ffyk62BsPFt2fO1IWOfXuJA7KYK0E+SBsi5mIBM1JxlDeka7gXE1cQ?=
 =?us-ascii?Q?eManDQp+2RyOs9j286fyPVldc89zrRgtBe6G1HfzJFYpTtMRS2eKVYBrcd8K?=
 =?us-ascii?Q?fy8aMvj08VSiZFjl37zkMmAsk98kaaP60XJbyvXXE9xwD6gbHKM0hnplXJWF?=
 =?us-ascii?Q?1FH1ipcc2LZ4CsafGhF8qSfJnRJgjZWNM9mDDwbD+/LRW/v9sPdCRe9Fs3y4?=
 =?us-ascii?Q?TJMhv+UMkHI4wI+cGPBoUri6pYON/DqAoZGW9znR4hZuvpWUaIUJq3qoGTkB?=
 =?us-ascii?Q?D6/cT47Ev/xV7Hw8wWV9qOkS5xf4xqKc3nGTzt3GcBY5luN/frJjEsSk6YZU?=
 =?us-ascii?Q?BEMiLJm9FFNGA6h2vnDJMpQLc7pJs6uXmIxnCSIDhc3YQh3J2BsdCcOwYvQK?=
 =?us-ascii?Q?jMu4NqLbZaAP9JzJ8+3TMNz216m9DgfVt7tymoiOz2hK19CCLaKZ7dJJXPNi?=
 =?us-ascii?Q?VWWnVSkWjSJ11EeYH2+fjS42sprGQ+7h9O6wX5bt1KN53fA//Kz8M58/GTsj?=
 =?us-ascii?Q?kh6hj0nvzNmnF7r8qvT15g1dcTeE+15GQXzX0dm+8cgE8UPWixaOO4bOTBlZ?=
 =?us-ascii?Q?nCacozvv2K/WccjOxZby/DDe+YNqeqG+cZwbxvoM0ftg7q58fiYf499wgdhZ?=
 =?us-ascii?Q?1I08Axeq3wbG9aT802NlQMbV18NF4l9t22JzWCveK70eiBybUOoXgB4CwX0X?=
 =?us-ascii?Q?EZH4DHlDJjS4mIK4iz2zCGEJPu6in5bSndQrwSOH/Y+TX7Es?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ZKX7P0s4X/vkS7OsMEY9yy+qrL2PXOloX1mpsUD7IEEsWdakC9MVjS11UOZtiGBBATYQf+yIA8amlNwyG3Sr8E1v9Bl+ojASsGnKC1kJiIuYLrJBO9Gc9+BoOOyaQHbnlQaAOpoAagWMh4m//JAmX6NsewwnuUC+A7ORFdNkMuUXzr4IFx8tfL94lAred6FqZyBsqzGJ3IT9Dn1qYOU0xHLDcXC8SvYFq3PcXR4C1teH1m4Qs+bToFGVCKnzDu3HgGfOzv2uMqVcTIHrDiJCRRV+t2Z4cNhle7o8UN1nJFjuAaluya247CisZ8th9KCJJbCEmenY6QvCWG9ZaI11iA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6d82d9f-2c8b-4e3c-65b7-08def471224a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2026 10:46:27.6332 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6yJ5rZl9pW6rPy/NQMrTn6mEDrVqmAhJJ7UMlnfjOGCaUILi2R24lsbc5JpfEM0AiMGnARJE3vX00Ak/OkIaXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR11MB9895
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

> Subject: [PATCH 2/5] net/iavf: defer device start when PF VSI not ready
>=20
> During reset recovery iavf_dev_start() might fail (typically -EIO
> from VIRTCHNL_OP_CONFIG_VSI_QUEUES) because the PF VSI is not yet
> active, leaving the VF down and requiring manual intervention
> to recover.
>=20
> Added a start_pending flag: when device start fails during recovery,
> defer it instead of erroring out and resume it from newly added
> iavf_resume_pending_start() on the next link-up event, so the
> VF comes back automatically.

It sounds like a fix, can you add a Fixes tag?

>=20
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> ---
>  drivers/net/intel/iavf/iavf.h        |  2 +
>  drivers/net/intel/iavf/iavf_ethdev.c | 56 ++++++++++++++++++++++++++--
>  drivers/net/intel/iavf/iavf_vchnl.c  | 16 +++++++-
>  3 files changed, 69 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.=
h
> index 293adaf6c9..e76c3bb410 100644
> --- a/drivers/net/intel/iavf/iavf.h
> +++ b/drivers/net/intel/iavf/iavf.h
> @@ -293,6 +293,7 @@ struct iavf_info {
>  	bool in_reset_recovery;
>  	bool reset_pending;
>  	bool pf_reset_in_progress;
> +	bool start_pending;
>=20
>  	uint32_t ptp_caps;
>  	rte_spinlock_t phc_time_aq_lock;
> @@ -533,4 +534,5 @@ void iavf_handle_hw_reset(struct rte_eth_dev *dev,
> bool vf_initiated_reset);
>  void iavf_set_no_poll(struct iavf_adapter *adapter, bool link_change);
>  bool is_iavf_supported(struct rte_eth_dev *dev);
>  void iavf_hash_uninit(struct iavf_adapter *ad);
> +void iavf_resume_pending_start(struct rte_eth_dev *dev);
>  #endif /* _IAVF_ETHDEV_H_ */
> diff --git a/drivers/net/intel/iavf/iavf_ethdev.c
> b/drivers/net/intel/iavf/iavf_ethdev.c
> index e475b64971..87b826c873 100644
> --- a/drivers/net/intel/iavf/iavf_ethdev.c
> +++ b/drivers/net/intel/iavf/iavf_ethdev.c
> @@ -1093,6 +1093,9 @@ iavf_dev_start(struct rte_eth_dev *dev)
>=20
>  	iavf_phc_sync_alarm_start(dev);
>=20
> +	/* An explicit start supersedes any pending deferred start */
> +	vf->start_pending =3D false;
> +
>  	return 0;
>=20
>  error:
> @@ -1131,6 +1134,9 @@ iavf_dev_stop(struct rte_eth_dev *dev)
>  	adapter->stopped =3D 1;
>  	dev->data->dev_started =3D 0;
>=20
> +	/* An explicit stop cancels any pending deferred start */
> +	vf->start_pending =3D false;
> +
>  	return 0;
>  }
>=20
> @@ -3425,6 +3431,7 @@ iavf_handle_hw_reset(struct rte_eth_dev *dev,
> bool vf_initiated_reset)
>=20
>  	vf->in_reset_recovery =3D true;
>  	vf->pf_reset_in_progress =3D !vf_initiated_reset;
> +	vf->start_pending =3D false;
>  	iavf_set_no_poll(adapter, false);
>=20
>  	/* Call the pre reset callback */
> @@ -3445,10 +3452,17 @@ iavf_handle_hw_reset(struct rte_eth_dev *dev,
> bool vf_initiated_reset)
>  	if (!vf_initiated_reset || restart_device) {
>  		/* start the device */
>  		ret =3D iavf_dev_start(dev);
> -		if (ret)
> -			goto error;
> -
> -		dev->data->dev_started =3D 1;
> +		if (ret =3D=3D 0) {
> +			dev->data->dev_started =3D 1;
> +		} else {
> +			PMD_DRV_LOG(WARNING,
> +				    "dev_start failed during reset recovery
> (rc=3D%d);"
> +				    "deferring to next link-up event",
> +				    ret);
> +			vf->start_pending =3D true;
> +			dev->data->dev_started =3D 0;
> +			ret =3D 0;
> +		}
>  	}
>=20
>  	/* Restore settings after the reset */
> @@ -3662,6 +3676,40 @@ bool is_iavf_supported(struct rte_eth_dev *dev)
>  	return !strcmp(dev->device->driver->name,
> rte_iavf_pmd.driver.name);
>  }
>=20
> +void
> +iavf_resume_pending_start(struct rte_eth_dev *dev)
> +{
> +	struct iavf_info *vf =3D IAVF_DEV_PRIVATE_TO_VF(dev->data-
> >dev_private);
> +	int ret;
> +
> +	if (!vf->start_pending)
> +		return;
> +	/*
> +	 * If the application has already (re)started the port itself, the
> +	 * deferred start is stale, the application's action is honoured
> +	 * and resume pending is dropped to avoid starting an
> +	 * already-running port a second time.
> +	 */
> +	if (dev->data->dev_started) {
> +		vf->start_pending =3D false;
> +		return;
> +	}
> +
> +	if (!vf->link_up)
> +		return;
> +
> +	PMD_DRV_LOG(DEBUG, "PF link back up; resuming deferred
> dev_start");
> +	ret =3D iavf_dev_start(dev);

This call to iavf_dev_start could result in another nested call to
iavf_resume_pending_start which would be problematic.
iavf_dev_start polls the ARQ eg.

iavf_dev_start -> iavf_configure_queues -> iavf_execute_vf_cmd_safe ->
iavf_wait_for_msg -> iavf_read_msg_from_pf -> iavf_clean_arq_element

If another LSC happens during this time, you could enter
iavf_handle_link_change_event again and end up calling
iavf_resume_pending_start again. It can maybe be prevented by clearing the
pending flag at the beginning of iavf_resume_pending_start and setting it
again if the start fails.

> +	if (ret =3D=3D 0) {
> +		dev->data->dev_started =3D 1;
> +		vf->start_pending =3D false;
> +	} else {
> +		PMD_DRV_LOG(ERR,
> +			    "deferred dev_start failed (ret=3D%d); will retry on
> next link-up",
> +			    ret);
> +	}
> +}
> +
>  RTE_PMD_REGISTER_PCI(net_iavf, rte_iavf_pmd);
>  RTE_PMD_REGISTER_PCI_TABLE(net_iavf, pci_id_iavf_map);
>  RTE_PMD_REGISTER_KMOD_DEP(net_iavf, "* igb_uio | vfio-pci");
> diff --git a/drivers/net/intel/iavf/iavf_vchnl.c
> b/drivers/net/intel/iavf/iavf_vchnl.c
> index 56918ebcc1..8e102b02aa 100644
> --- a/drivers/net/intel/iavf/iavf_vchnl.c
> +++ b/drivers/net/intel/iavf/iavf_vchnl.c
> @@ -260,7 +260,7 @@ iavf_handle_link_change_event(struct rte_eth_dev
> *dev,
>  	 * (link is down or a VF reset is in progress); the watchdog drives
>  	 * auto-reset recovery, so it must remain armed in those cases.
>  	 */
> -	if (vf->link_up && !vf->vf_reset)
> +	if (vf->link_up && !vf->vf_reset && !vf->in_reset_recovery)

Is this change relevant to the rest of this patch?

>  		iavf_dev_watchdog_disable(adapter);
>  	else
>  		iavf_dev_watchdog_enable(adapter);
> @@ -271,6 +271,20 @@ iavf_handle_link_change_event(struct rte_eth_dev
> *dev,
>  			    adapter->no_poll ? "on" : "off");
>  	}
>=20
> +	/*
> +	 * Resume a deferred dev_start.
> +	 * iavf_handle_hw_reset() sets vf->start_pending when
> +	 * reset recovery completed dev_init() but iavf_dev_start()
> +	 * itself failed (typically -EIO from
> VIRTCHNL_OP_CONFIG_VSI_QUEUES
> +	 * when the PF VSI was inactive).
> +	 * A link-up event implies the PF VSI is active again, so retry now.
> +	 * Run before the LSC event post so the port is ready to accept Tx
> +	 * by the time the app's link-up callback fires; no_poll has already
> +	 * been cleared above so bursts go through as soon as
> +	 * dev_start sets dev_started=3D1.
> +	 */

I think this comment is verbose, consider shortening it.

> +	iavf_resume_pending_start(dev);
> +
>  	iavf_dev_event_post(dev, RTE_ETH_EVENT_INTR_LSC, NULL, 0);
>=20
>  	PMD_DRV_LOG(INFO, "Link status update:%s",
> --
> 2.34.1

