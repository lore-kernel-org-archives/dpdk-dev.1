Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0FA5C5B572
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 13:54:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8DA25402AC;
	Thu, 13 Aug 2026 15:54:19 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 153E240298
 for <dev@dpdk.org>; Thu, 13 Aug 2026 15:54:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786629258; x=1818165258;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Q8S3uzf49p1BC3FI6PL/2J9aNiPg7AONGbN95t3RPAs=;
 b=WGyuglgcDd0hVT6nlqDW35FAHTIt5xCtppp5zJes3mMtLyxzVRsiOxja
 gRM83dfnRAsUE8xqu+ldduiiGQf0Puw9Iw80bNblC1XUMUYtYSs7BaPvV
 iMnPllYzyJUQj3stOkZBuJIConvNwCR3h8gWytJo926TfHD7/z2LYQnpW
 8XF70o8gpP5fMQklT+LuoOkU2YhdWj36RZVncd+UpkIR/IdZIH1A+FS/T
 4Z/thNiS97xmdGjbncKqo6eKHy4Fskr2Chp5GYeg0hBOaBg8rxxHqH1eD
 rWcoHQNzGnQNE3/riDpGwS92+NThwtxi14qn6zoDfnGcsxUMRlwQwZEav A==;
X-CSE-ConnectionGUID: /eWN9bd+RQqfItu1LICCkQ==
X-CSE-MsgGUID: NGi2JfuPQyaQO6HLUWHg5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="86965134"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="86965134"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 06:54:17 -0700
X-CSE-ConnectionGUID: 3LTcv+9zQIu/Bdu+ljP1WA==
X-CSE-MsgGUID: fO9uGXwMTJG+KfhKE0Lb8w==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 06:54:17 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 06:54:16 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 13 Aug 2026 06:54:16 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.25) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 06:54:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Int7N6dL76x0/S6oxAaaPLVCIQKYBovFIJHUSi4fYFrX8ZbDnrSjyE6Sn+8vUzt6qhQt9LgQ0YDMH+ti+zDR4zgH/7QZwZkChibRex1ya6loqETtDM/I2Ft7IsDMfNPOCTIui5Y+orELb11EnjMj91DcbpPbONCXlUDPYJatjVMoJujKm2JDfnTWCvZ6MeMRdZQG4WjSJsmK2nItTzS2uVGNJS3JAym+yTUWEIln6d23+v5XztAzSyeI3X9o+p5sbumHwH/49UnR/0qDu3KFmaJYv+EEOXmiOcwUWkGeGnjL0eBT3i/LzgD0rLurE3WUFlb6BOnShY8oeqmsQdc5wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2qgzkXm7O7i7+8KKCBcK5ljDyYwOnVlTA3hwX+f3QvA=;
 b=EcXksFBjTOEIWSNOfpVlZ3FVlYKKRoUT8a3eiPOAlEasBx3r3wqlO+VSG0eNajBEFqS+KyxdvVb4PFqUCkLHsIYXl/VRMGNYkKUEAv+Y7N9ngmLIwJzU+WXsa9Ju2xglvyqBBqCrStBDIgjGnp/g/1GoSl9Fax108HgeRbAKpW+rcb/idoINECG7632azraF8MXe3t0WxasMv+B15FymxUfWGnr4nEEJwaJkMsvWZvbdJicFjfA9I97QdacFoMSZIAnxyj9PQCT7bxyscv01m8LK2izbB9xzyJlWRB/V4b3JGWIitsO0dc0JGi8L1BUqcJJdzS96oUGixfawC6ymeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA4PR11MB9278.namprd11.prod.outlook.com (2603:10b6:208:563::12)
 by DSWPR11MB9761.namprd11.prod.outlook.com (2603:10b6:8:356::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Thu, 13 Aug
 2026 13:54:14 +0000
Received: from IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057]) by IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057%6]) with mapi id 15.21.0270.016; Thu, 13 Aug 2026
 13:54:14 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Mandal, Anurag" <anurag.mandal@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>
Subject: RE: [PATCH v2 6/7] net/iavf: keep watchdog armed for the whole reset
 window
Thread-Topic: [PATCH v2 6/7] net/iavf: keep watchdog armed for the whole reset
 window
Thread-Index: AQHdKxETIa9oDTdka0+5D7+XLaJ6JLab/3Ag
Date: Thu, 13 Aug 2026 13:54:14 +0000
Message-ID: <IA4PR11MB9278E831F6045C7AC27A98E68EDB2@IA4PR11MB9278.namprd11.prod.outlook.com>
References: <cover.1786617159.git.anurag.mandal@intel.com>
 <47bddd4ac155b60709dc4ebe78d255215f02637a.1786617159.git.anurag.mandal@intel.com>
In-Reply-To: <47bddd4ac155b60709dc4ebe78d255215f02637a.1786617159.git.anurag.mandal@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9278:EE_|DSWPR11MB9761:EE_
x-ms-office365-filtering-correlation-id: d1075742-1b08-4dba-e7d4-08def9425c65
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: h8N9yHGv+QC43PunzT5PojJSDI69YPtsswzG4qKH38SGnjEHdi2EyHAfM185fSDnZvtadgZ1vye/wY/5wYm01YUiRUTQL/C+J1gyaoxxPCep+Wbaeqyf0f8FayfSHsEVMRV1y9MbkUko2159toJ6Z+xdyyYXcS7ppCAINoKxE1ZC+r49iG98fcoD98jrKaYUZ8GlK+6QYYw4NMoQP+XuIOKS4N/clbSDxjmv5HOZXBadkaR+Wkf6/RNmyDL+PY1XXrXP6UZpPR0KPyTgt+sYdLznciCdVJaF7hxVzdUOZXTAU82qT3bU0hkQ1HQvhR4gL2LaUHlyfb5WKo6Jhn8NYKeRBlF1iMgqsUTjYrKwHWkhcZTCqK3XMATPrdXenU0Ao/j4931DhkAXRK5vCx39M8vh/Fj46r8ZjICb8tUAnAqxy3BOMUDtmGTuk8p1KojMxkS2ZcHuvbnY68aQ1oxYPbN+5BWzkHm+w0d3sZr0zJIvHAVfvwktmZXWD9oxCEGYZdqiW+cx6ibsjP0GIU1S1PqxpnUcHm5suIb3GG9OdWilxW5SSeN0lQO2k0llzl5JK++yid31ikiKflR48wwRoa1Z5AZg/GPSAmh4aQx+HT2SZxbW/8jKLz+0hpRo4GjzZsv3GLANOKmGl5CxhNYTeib7W9v62DAmTj/jH+/Ll5T25VFxo0Q9j0Pjl3gxIalQZB8HVQm8UpJi8hGYS9R/88dBJxGNrufxKu2PfhoIWAM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9278.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XY1JQd5onsbGw23wB9v4+eFubaQPWJpiPt6DeiCrDYbJ6RzmH38xZzk7xVvG?=
 =?us-ascii?Q?UJebnuUUO/YSBXzEA1PY5Ox+U3sjNNVZghJQTU0JzNPCjyvvVlDd2cAuLqGl?=
 =?us-ascii?Q?jCBplIYBsES8TXjWSm7JhoRuYWByt2vh6AwHczye5m1sT8CPjEQaNMhKBKZy?=
 =?us-ascii?Q?YxayhmSM/q7m1Ri7B14GP4qX39jdBHDZTEYhOnGwUvc6OL27cXZL8M/eeP6v?=
 =?us-ascii?Q?IlvdjBZ4U6LL5mzsKoGzMHX1tcXpX8SANyJxAr0qomySl+doNdRO5t+JbY4z?=
 =?us-ascii?Q?PK8E/wWnYJiKRzFTEudoqBH+oe1wBZ2sJGFyPZDNZdMr3lD20yOuOn6hk8hG?=
 =?us-ascii?Q?iRMdk3ycl3pAptSixYYLawChjtMNIpeIokIZMyT75BTFSeo2ZVdliuhhxWiU?=
 =?us-ascii?Q?gIlUz9o8ArJDisa2sDK4gYrDQwIJmlK5j5sFVmaTsiJ5e4Mw9VfsrhbLGpmH?=
 =?us-ascii?Q?lRu1DyJxBxpPKUdeXA6113WLhspgVgt4bIlB3ve0hxM8I0yj01EbhC8dVRKf?=
 =?us-ascii?Q?N7bRYeM/JI2HrtopHMTzmgAcs9wIzG9B1r25pQLffIcMf8rxq5LcNUa8rooA?=
 =?us-ascii?Q?cUBGhbL6Rh1fEjAnJKe5hSSZ2Jc3advZsUn3sKyzWTGLY51yWOcsDTBmHVjX?=
 =?us-ascii?Q?4usE3wC2QLMXzFoIZokXBeHyoIZz90h7UXjVrT47SnOMJurtLjjp5J2YFq3J?=
 =?us-ascii?Q?zB71MVjHRRDBID2Uc8pXMEHz49FwbBbgWT0e8lJ6bn7ql/41dUIyuGSDdY5R?=
 =?us-ascii?Q?8sk8f4KOFiwKOgwGVWYa4LTsQ39lP2mTJBTxvKoFjFe0KIrrRJvdhLjn/GFb?=
 =?us-ascii?Q?ccU17mbC5EOPJYqNWaPmHBdn8CprCBRnHCozQwdNbQOxrADkgSXPKtYM/DYI?=
 =?us-ascii?Q?zj95uYckSxFUtcLb0Xj8znSv6kexl9TuLTSYihRNpKpaPEEgAxEUIhqcukmp?=
 =?us-ascii?Q?//ApAqJmadli6/fXuqFl7iQSOQXmUDiQ8IRUwIzGIrUjq8/x7Xo7qlY9hpFt?=
 =?us-ascii?Q?vgyr78jDyFa/O3E4uTAl4Iq8bzVHjVLqY3WJFmQpYiMN9FnM4g7ZMOcN5fka?=
 =?us-ascii?Q?BO/chwpRQIWqnwPZcQ2jLgR8TUgs+P6Zk3RSVdD/FsIq/qObzd2cRGuj7iam?=
 =?us-ascii?Q?Z1Ir8c0wBV/pXm38W884WgaW7qKDCKDHSadKtXAEYoY92KPf/VcIUfHQgC4G?=
 =?us-ascii?Q?1UajbA6ggxX0Jto5tmxVM89SIvp5lEkWCrpePztXxLz2obQ05sqQOQy5KBNs?=
 =?us-ascii?Q?e1AC6z7Z2UQTL+yo8fht5hIXaEk5IHabY8q2hSjl7BUSRUdCWPsNx2oRwuxd?=
 =?us-ascii?Q?15a5040YV8YACkNi27R/HNex7QWkY+Q6e+cdCIINOulvGaaTaj69He5ix3ub?=
 =?us-ascii?Q?d7r5Fo0ez5XeGIESmGB0cpW/cVqthbsWDGYqT+kUcOscnW3ESXnIXR2MMkaL?=
 =?us-ascii?Q?xDd7aKeRKTPTSj1lIpfH/nJDLz0zCloBS7gMX9Rdnkai+SNec2LQ6OfVZ/Vs?=
 =?us-ascii?Q?bE6SlBN/9licbEa8LEfMP6ijpOo/9kKi3O0Fr0TCSmBTZjyjbum+UK5Nu0jw?=
 =?us-ascii?Q?RQj9IVW4DWttWCViXw/MQEF5gfm6cXxZWxfDVq5UMMB660U9vB9RVpDKUzYp?=
 =?us-ascii?Q?cN9tDsYihFEN8qbN/EOsK/EzJ1CiNlOePD/6tyIw5RcPRMPzHzOA9htEm+nz?=
 =?us-ascii?Q?ydnp06uzt2itEXqtTvaOFAtNiKgH1Wl0/518zzygYwLlX6H5sl9+hr/O/HAb?=
 =?us-ascii?Q?nIBG0Jm7RQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: e6u8mM5vN0Ync0hVVek+HmA7opzjIsYxaGBMT4vtcz195dr0Zd8eM0XxtsePwHEmWePy6YgnE7PNpvsybgK0PX0OZuiElzevX347drN8OR45LWcXH2iPinJqTCEkhM6IiKBPByA1wyRmNeG/AA6cFfa4hfeqjxaMEfYUqGGtorDS70y211KXBFMqIBvH/vD8cy6w18BgWlU+b3xeFSZ8R02G3BbFREiv4JPBgcZs97K30/zhaUh5XkYFJus6ctrzIPS8j5YhoBSQ/8nV1VMek7vyd7zyKEq3q5+kjZ3UAlPp6tWZAqBSwzojwCNx9U3W0Dk4M0NohXENPsotijUaAA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1075742-1b08-4dba-e7d4-08def9425c65
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2026 13:54:14.6085 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j2/IdGfyApO/mYClWVo+UszqC+jWDk6xFRlRoEsCKPjf9k3dyn+bukFmw4bJSXKbMZ1K3sgfe64Erc1iH9FNkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9761
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

> Subject: [PATCH v2 6/7] net/iavf: keep watchdog armed for the whole reset
> window
>=20
> The device watchdog polls VFGEN_RSTAT to detect a VF reset and drives
> the auto-reset recovery path.
> It is disabled when a link-up event arrives, on the assumption that a
> working link means no reset is in flight.
> That assumption does not hold during recovery.
>=20
> Keep the watchdog armed while vf->in_reset_recovery is set, and enable
> it on VIRTCHNL_EVENT_RESET_IMPENDING, so it stays armed from the PF
> reset notification until recovery completes.

Is there an appropriate fixes tag that could be added to this commit?

>=20
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> ---
>  drivers/net/intel/iavf/iavf_vchnl.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/intel/iavf/iavf_vchnl.c
> b/drivers/net/intel/iavf/iavf_vchnl.c
> index e04afe1d6a..3ceebce454 100644
> --- a/drivers/net/intel/iavf/iavf_vchnl.c
> +++ b/drivers/net/intel/iavf/iavf_vchnl.c
> @@ -260,7 +260,7 @@ iavf_handle_link_change_event(struct rte_eth_dev
> *dev,
>  	 * (link is down or a VF reset is in progress); the watchdog drives
>  	 * auto-reset recovery, so it must remain armed in those cases.
>  	 */
> -	if (vf->link_up && !vf->vf_reset)
> +	if (vf->link_up && !vf->vf_reset && !vf->in_reset_recovery)
>  		iavf_dev_watchdog_disable(adapter);
>  	else
>  		iavf_dev_watchdog_enable(adapter);
> @@ -574,6 +574,7 @@ iavf_handle_pf_event_msg(struct rte_eth_dev *dev,
> uint8_t *msg,
>  		if (!vf->vf_reset) {
>  			vf->vf_reset =3D true;
>  			iavf_set_no_poll(adapter, false);
> +			iavf_dev_watchdog_enable(adapter);

Should the watchdog be enabled in iavf_read_msg_from_pf where the
RESET_IMPENDING message is handled also?

>  			if (adapter->devargs.no_poll_on_link_down)
>  				iavf_dev_tx_drain(dev);
>  			iavf_dev_event_post(dev,
> RTE_ETH_EVENT_INTR_RESET,
> --
> 2.34.1

