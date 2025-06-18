Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAEC2C7115B
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Jun 2025 07:20:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D940B427BC;
	Wed, 18 Jun 2025 09:20:30 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 38B69427AE;
 Wed, 18 Jun 2025 09:20:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750231228; x=1781767228;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=RJGfsrw6A2a13YFo3MAMNUSzOyemTpdps4VzJNPpNLE=;
 b=SWngQrQCKb311y+h2/zfNzb4xQlMi4jzoEt7bCa/p1Y3VfzOflds7neJ
 KImm8jgAyhKHZ3I9B4/ayGRPtizTAdsXSD8dGuRsHlQRmJHWGBt3hNECE
 aKiwAptSpdO5ddvC2YNDlXwIlib83WO/VBNbW62c7PeSh7tRX75a/sYGZ
 whbWGLzn3zzQGBqnKgtPde7WszZ5NfGyNKCFKS4oH8HRQADwn63zp1aND
 R3swYhCXiCEkDLv8V0lb9ZsvaOLl7M8i9JQJEA3MW6d6mt+tVBpVJPfu7
 p++IjRf/LOQiLpr26ypZI15FkK4gKYQ17l1ZaXRxgt+dD3srqi+Y2TUSy w==;
X-CSE-ConnectionGUID: FbVlAgypQa6y2eQ4fPekRQ==
X-CSE-MsgGUID: +tyAZTfySdKzHK6fUJjgzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="63041897"
X-IronPort-AV: E=Sophos;i="6.16,245,1744095600"; d="scan'208";a="63041897"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2025 00:20:27 -0700
X-CSE-ConnectionGUID: or11BaVVT7iTPnQ0WsbQvA==
X-CSE-MsgGUID: /w5w9Z68RU2KJYVk2iOaiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,245,1744095600"; d="scan'208";a="149916479"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2025 00:20:27 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 00:20:26 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 18 Jun 2025 00:20:26 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.77)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 00:20:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aeVZgTlj+E1q28hProLkzB66tf0RApeLy0MSUzMihqLhLtq2s2AheXKaTdEZR+YxIf+jvGiYec6ZPITKHjIovcXG4Jpg8edzgI1qHBIOuMMY+V/lfh0hOfX6wKTaTeXGzC/I/JQHjKlYCWX4d51bVkoDXDcGRVF2MO7TnTRm+qXDgk83AbMZNMzqUSVu0/NfAagE8xl58vBqdGdX4laVWZITIj/XvS02BDd0ZNptDD2R1XD8v03xsbf8Ofuk8upWf20fuuibw/43ppAGLt+0iqJJiagjiYYl27JRuHhC6lBsBfkDf3CydVzWVcOWTU9pMNsl3UZw3t0hJRN28jCPZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F5C3iJvhHs1MxF/CIxLp/LQelEdhMIN0X/IHsLLhPKg=;
 b=rE+uD1qQYhqNeJfr/Q2XHsOXx4LxBF+fgNjU+eyD+XP3t6lEDUKVZlEY+K5NdBtRsrz8q+Oo7r28hlAmQMcwg7p8aTamvhwuhkbVzNIWfR8wJScE1/lODSXfs3/HaBH1lwfF1qT8etZxTpvIoJ2Tm07XSJsdjSTjaIMJahuQDiipkuPsquRAxIC6YAXFxn1vsK7E1O4edLQp9rudgRUdX3VKNTAYTxCbFPtNGqXY3cN2WkAdJtkzZAMf+PnEDpqlXiYmss6BXnjE+3ezMWs0CvRSkvUVWoVZuG7hqaUKKyYVY6FkgaZ093+cKWfaJ7X5OmMs6Fg3tI8wPYNa3HhAsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8601.namprd11.prod.outlook.com (2603:10b6:408:1b8::8)
 by CY8PR11MB6940.namprd11.prod.outlook.com (2603:10b6:930:58::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 18 Jun
 2025 07:19:46 +0000
Received: from LV3PR11MB8601.namprd11.prod.outlook.com
 ([fe80::7878:b054:82bf:b5b]) by LV3PR11MB8601.namprd11.prod.outlook.com
 ([fe80::7878:b054:82bf:b5b%6]) with mapi id 15.20.8792.033; Wed, 18 Jun 2025
 07:19:46 +0000
From: "Ye, MingjinX" <mingjinx.ye@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>,
 "Burakov, Anatoly" <anatoly.burakov@intel.com>
Subject: RE: [PATCH] net/ice: fix DCF RSS hash update
Thread-Topic: [PATCH] net/ice: fix DCF RSS hash update
Thread-Index: AQHb2rtN4IK6bALDoEGSQUd25lezkLQHQeYAgAEPe7A=
Date: Wed, 18 Jun 2025 07:19:46 +0000
Message-ID: <LV3PR11MB860182F8B5A3A90A476A12C1E572A@LV3PR11MB8601.namprd11.prod.outlook.com>
References: <20250611095058.114465-1-mingjinx.ye@intel.com>
 <aFFSmKEoal481ZzA@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aFFSmKEoal481ZzA@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR11MB8601:EE_|CY8PR11MB6940:EE_
x-ms-office365-filtering-correlation-id: 96c1ff28-4443-47c8-de0a-08ddae388107
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?p7Hu64/a8TJxq3WO9AMOabsnu4J2IAwQnIZ7ab7FgxYEDyuc1L7AP6w1M4bP?=
 =?us-ascii?Q?ZhKvT/RBVZ53oIwygvZjOOTb2jNHZ5NvwQqQgg+ysgO08Yj9W/nDiSFxBBc3?=
 =?us-ascii?Q?pRy2QiFjuhZy5vLVU7Y9EFt6873uzMYwMfN0rhTk5sZSX85QUvWGZHuRxN1v?=
 =?us-ascii?Q?3KoyBmUFxjbi8cWYuTWOVcQNgH4a+6UVLfcQr6ooem02ye8tkHwPJIDHsmsz?=
 =?us-ascii?Q?9RW9Q9wv1sBMVdtH9LOeMPTVYEXJVQ5fsynX61BijVuTg1F4ksZIGwD43I09?=
 =?us-ascii?Q?YV78GEddd2aDpU8o6QQi+5jWY/Iq46X6ViK2TWdabytoF9gzJdBo08m+oZzf?=
 =?us-ascii?Q?QIZO4NgSyA25LqptO76oGEx/we/Q3/y1q8nXN54mLgVyOg/5HLsBjiYUA+Hs?=
 =?us-ascii?Q?YpSaMKUH7/Hq8GLJX6JHuZTmQ/Pqc1SFSre/5t+OIK1dlGYst0PNIFGMwLfg?=
 =?us-ascii?Q?NepmaSD45R369tVg2eJJhyh3sAW76cHM0ZCeQEdbz8lqqvkWxp7XXQ0vmbAH?=
 =?us-ascii?Q?Q7BEutVgOrnJShfrnxjlI/cJJl+OWPLJT+D3UmaSNRl76D7i9/G7PJm6v/0A?=
 =?us-ascii?Q?7yAJC7EXF2Y4QY9kK43w76ARndiY65ZNV311Jvqt+eMz597kiOnXNcgnfGkX?=
 =?us-ascii?Q?ueButH4tnO0P76193P1zyewqJusdGbl/4NLxEF0FY8tn47Sj9wNSB7CdT0FM?=
 =?us-ascii?Q?lES2tB+0dbLdX261CparXVmpc4Gpwhm9iSEuokw88UYIB9+IjfhVKfI7SXHz?=
 =?us-ascii?Q?FTg7NdoJGqfHikg1a1EAB+UIwt8spxQ2H9G/asYW46HEBwX4hvGXdk0TF9qc?=
 =?us-ascii?Q?FWzobYk2qQ7NRDsAwsM0OAw+ZQDSdvD6cN53SjafpOUN7J2GHywteDV/u7cK?=
 =?us-ascii?Q?igcqlRDov3FQg2C9TmeQapYTRFzCA10Laa2tMroDnM1WlYLtWvqPQ73OsWWF?=
 =?us-ascii?Q?FWhYo4zAIXPAxJ7YhRdau/bzZKJ6MMQ/uqyJQrcqo2+citJ4ruLrykFBAwK1?=
 =?us-ascii?Q?fWlm4ZLtDZe/KfjD+g0JMgiOqZAwTmWP0LP/etMnesInrjSyd3pPx+HW9lki?=
 =?us-ascii?Q?YFJogDJwxlnWOBTiamvNB9HHvFktrYte69a/M7UuXdEKTl5jTyx4C9+D4F1s?=
 =?us-ascii?Q?VTnC2DrTHN/rfXcX7ey9ryD1WxUZKqyIr6sBVBrP1AFKtjYJuNaZXvIMLlET?=
 =?us-ascii?Q?oBTQgq5SK9JCcBbPsEAwvcTH50I/vayVui9qPHyIYEGKh5Y5560aoktU15hy?=
 =?us-ascii?Q?vyZ3/DpQl/pJdIMSP/AXx72Oh7dIiThykrgQjdMNqAG8S82i5yDfpghXcR8G?=
 =?us-ascii?Q?hXFc+nD7aZ1Fv64JtdEjgTcTDCgBHWTU/f+Lil+XfY0JKfXoqGmP2/2O8Zby?=
 =?us-ascii?Q?0F6nbVQNqBrX7U9BBGR7ZqCWcU8eqHh5/UFwCBGRsoifA0OOpu/k0xTXJvLs?=
 =?us-ascii?Q?YVwzUQxhWmx7efupdB8t87Xy7kaaLGl5LzEXbv7kIvzttBhR8NKITw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR11MB8601.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ma6oVofZY1ItHdS/hIH4yYEdxxSfNAWg0qaJjG0RYh8EalhYex1KOxwsrNt2?=
 =?us-ascii?Q?E20NftQqqsWCgbqgurh47E3Ri9To5cKR0abOhhk1rB86pQJM7EntCJbRI/4W?=
 =?us-ascii?Q?g6wbbRYKOeLsB08JXH1FRQDlTlKACnTtKLoDK4ROK5hKEByYWwG0PZ06Fgad?=
 =?us-ascii?Q?NFHTBbji2kq0BFu7zGBPxmfX8cMs633z1YKFJw/c1Z2SpAMxAC4p3Aq849o2?=
 =?us-ascii?Q?bVKG7bhJhql0qciPALa55TEs8t+Cm8oxcRLT6pZJgs1KWOJwtDiY3tJSxTIb?=
 =?us-ascii?Q?6JUaDQrucKmDXL7EQWNn48X5velshgFgx8ba6omzXzggSL94q8oifLdo5HjY?=
 =?us-ascii?Q?yb5G2YAoCDaD5BIfofi8goRLtBF7UAU0heTbdoBtlL41FtagRZ+ifRy3hXgi?=
 =?us-ascii?Q?a8h/HYNs4dVtZ20CLyBIoulmFHz9lB/O/KV8cjsA3azV6ltvpPypbrTQOtZX?=
 =?us-ascii?Q?symUf/xHs+RnJPWsNfaZk3Npkv4iGW9HPvblplBPhg0KooofbCXcCju/FPep?=
 =?us-ascii?Q?XEdISmzUk2lOh36rubIqT087alsSqxLdxdBL0Nt4q0UefSJKeVfnjloYI5To?=
 =?us-ascii?Q?B8T4efXTHRxwXyEwdN8S+sHA071+duUH5/EhbRjWxnFVFdxmL14Zz1QwSuXD?=
 =?us-ascii?Q?nKAddBiQ8YiC1SwIyslEvcmpMTmqdj/8cjNN+JzIiPGhU8Zen356vr4SALIV?=
 =?us-ascii?Q?0d7RE9OY4xj9M5SYnVZeuehGN344bKiP12P9bzayHvfg7VDWKXzQVE8La7Nn?=
 =?us-ascii?Q?9v4dCnLdkJyYiTSuGGklXYa1MTYkWHPNxLTBHJ+mD2DPI5C+gtvacaKTTNNY?=
 =?us-ascii?Q?fZdza1G5zFhVvvwUxHcBR18KGh+ieaJNvCNrEDrP7WEdlwHzwH1xaiXOW6AI?=
 =?us-ascii?Q?8OJUOf/HAr8+1ipKdLVJqGVfq+5wBCqOaXyi6+hZj9eGyJAfVoDswZz6EbWi?=
 =?us-ascii?Q?zL5+3sn5hSaNHNCFNUXnmeYko22l2BLY/zCI62oYsk8CWTMc7GHa0NtL0wo+?=
 =?us-ascii?Q?az6usLQkgICR5pRl7+LTfK/vJqHrP1Bfzt97EEPBCdU/U4gpAlFAzPn2Kwqd?=
 =?us-ascii?Q?2qH6AxQDmMkTW9rfc0Ex7D8HU4JllNWJCzuaVdERD8RF7N+hHRLSz/rb1BVt?=
 =?us-ascii?Q?Zv1TenVqlQqfUbcA/s/WeDG6xTsa4C+g0wlIKcty1DSikoR2xnX3taF2o4nI?=
 =?us-ascii?Q?WgdECujkFEWseuHOagO1oQ7f7OfaowXYncmmt4PTlwN9basALgzJJzNNIhcs?=
 =?us-ascii?Q?S4mEssTcqCLQ11ENYqmkdGwgZol4XbqVI3QiTqMl6DByLU9Qz/6/hy2TbgmH?=
 =?us-ascii?Q?NO3B2FWCH4KOyuWOwEaWQwc+uiV0TJKQiNcUxtHd83TEdCGUePtcZ7tHGitt?=
 =?us-ascii?Q?dr+ZVsrf8p1QpbgzB2RMlpt8IPj0w68W57dryRR7m9TtOan+q0vdyXi14SxT?=
 =?us-ascii?Q?inZ0LVw4FRuAMz4EHyaWKAFgpQqBBreQkRxdeMUR+ije7qvJeNfY+roagZxa?=
 =?us-ascii?Q?mRHN0kvxqvik8InjzMaLzRKjtZiqdrfh7HHxM8aZgbKx+U4wBr1mTw2DiAFH?=
 =?us-ascii?Q?DqhxeKcreY7CzrXOzLohi+Mm0reBEBoL6VFKgABE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8601.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96c1ff28-4443-47c8-de0a-08ddae388107
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 07:19:46.2220 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qQhv8ecT1klGTm+kA4nT+AKZRwYhpHgJdWcbGn/+BhZvq3n51Kz2iKeMim/vxZ1xgj+sZuQX0o40T/+q4LVkaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6940
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
> From: Richardson, Bruce <bruce.richardson@intel.com>
> Sent: Tuesday, June 17, 2025 7:34 PM
> To: Ye, MingjinX <mingjinx.ye@intel.com>
> Cc: dev@dpdk.org; stable@dpdk.org; Burakov, Anatoly
> <anatoly.burakov@intel.com>
> Subject: Re: [PATCH] net/ice: fix DCF RSS hash update
>=20
> On Wed, Jun 11, 2025 at 09:50:57AM +0000, Mingjin Ye wrote:
> > Get rss hash configuration, rss_hf is always the default value.
> > The driver does nothing if the rss key is invalid during the rss hash
> > update.
> >
> > This patch is get the current configuration of rss_hf. Extract the
> > update rss key code from ice_dcf_dev_rss_hash_update to
> > ice_dcf_set_rss_key and make it consistent with the pf behaviour.
> >
> > Fixes: c223cadc9e5f ("net/ice: support RSS hash configuration in DCF
> > mode")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Mingjin Ye <mingjinx.ye@intel.com>
>=20
> Hi,
>=20
> some comments inline below.
>=20
> /Bruce
>=20
> > ---
> >  drivers/net/intel/ice/ice_dcf_ethdev.c | 38
> > +++++++++++++++-----------
> >  1 file changed, 22 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/net/intel/ice/ice_dcf_ethdev.c
> > b/drivers/net/intel/ice/ice_dcf_ethdev.c
> > index efff76afa8..accabd0ab9 100644
> > --- a/drivers/net/intel/ice/ice_dcf_ethdev.c
> > +++ b/drivers/net/intel/ice/ice_dcf_ethdev.c
> > @@ -1394,31 +1394,38 @@ ice_dcf_dev_rss_reta_query(struct
> rte_eth_dev
> > *dev,  }
> >
> >  static int
> > -ice_dcf_dev_rss_hash_update(struct rte_eth_dev *dev,
> > -			struct rte_eth_rss_conf *rss_conf)
> > +ice_dcf_set_rss_key(struct ice_dcf_hw *hw, uint8_t *key, uint8_t
> > +key_len)
> >  {
> > -	struct ice_dcf_adapter *adapter =3D dev->data->dev_private;
> > -	struct ice_dcf_hw *hw =3D &adapter->real_hw;
> > -	int ret;
> > -
> > -	if (!(hw->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_RSS_PF))
> > -		return -ENOTSUP;
> > -
> >  	/* HENA setting, it is enabled by default, no change */
> > -	if (!rss_conf->rss_key || rss_conf->rss_key_len =3D=3D 0) {
> > +	if (!key || key_len =3D=3D 0) {
> >  		PMD_DRV_LOG(DEBUG, "No key to be configured");
> >  		return 0;
> > -	} else if (rss_conf->rss_key_len !=3D hw->vf_res->rss_key_size) {
> > +	} else if (key_len !=3D hw->vf_res->rss_key_size) {
> >  		PMD_DRV_LOG(ERR, "The size of hash key configured "
> >  			"(%d) doesn't match the size of hardware can "
> > -			"support (%d)", rss_conf->rss_key_len,
> > +			"support (%d)", key_len,
> >  			hw->vf_res->rss_key_size);
> >  		return -EINVAL;
> >  	}
> >
> > -	rte_memcpy(hw->rss_key, rss_conf->rss_key, rss_conf-
> >rss_key_len);
> > +	rte_memcpy(hw->rss_key, key, key_len);
> > +
> > +	return ice_dcf_configure_rss_key(hw); }
> > +
> > +static int
> > +ice_dcf_dev_rss_hash_update(struct rte_eth_dev *dev,
> > +			struct rte_eth_rss_conf *rss_conf) {
> > +	struct ice_dcf_adapter *adapter =3D dev->data->dev_private;
> > +	struct ice_dcf_hw *hw =3D &adapter->real_hw;
> > +	int ret;
> > +
> > +	if (!(hw->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_RSS_PF))
> > +		return -ENOTSUP;
> >
> > -	ret =3D ice_dcf_configure_rss_key(hw);
> > +	/* set hash key */
> > +	ret =3D ice_dcf_set_rss_key(hw, rss_conf->rss_key,
> > +rss_conf->rss_key_len);
> >  	if (ret)
> >  		return ret;
> >
>=20
> This part of the diff (from start of the patch to here) is just extractin=
g the
> existing code into a new function, right? There is no change to behaviour
> here?
No logic was changed. There is a difference in behavior. Previously, when t=
he rss_key is null, noting will happen. But now it continues to perform the=
 next steps. This patch makes the behavior of PF and VF consistent.

>=20
> > @@ -1452,8 +1459,7 @@ ice_dcf_dev_rss_hash_conf_get(struct
> rte_eth_dev *dev,
> >  	if (!(hw->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_RSS_PF))
> >  		return -ENOTSUP;
> >
> > -	/* Just set it to default value now. */
> > -	rss_conf->rss_hf =3D ICE_RSS_OFFLOAD_ALL;
> > +	rss_conf->rss_hf =3D dev->data-
> >dev_conf.rx_adv_conf.rss_conf.rss_hf;
> >
>=20
> This line seems to be the main fix in this patch. Is it worth splitting t=
he patch
> in two - having this fix and the code refactor above in separate patches?
It is okay to split the patch as these two are for separate purpose. =20
>=20
> >  	if (!rss_conf->rss_key)
> >  		return 0;
> > --
> > 2.25.1
> >
