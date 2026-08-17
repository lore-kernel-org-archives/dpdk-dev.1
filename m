Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508F1C5B572
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Aug 2026 06:55:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3258940294;
	Mon, 17 Aug 2026 08:55:46 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id D56A340275
 for <dev@dpdk.org>; Mon, 17 Aug 2026 08:55:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786949744; x=1818485744;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=iBMcj4p4WNV7P3BUmFa7sHH/uR4TjHv7XlHjrMVwJ5c=;
 b=mkMdsLHJU6AlPUE+QCt6fIxmdMyejpkQICIl+uxHINVpNKdtdIxWQGSC
 eFF0UxAGrg9+HclIVNsl2fPaoUwoQpMbZKlpufSKsvvDDYdU2B6DldKu/
 OOLZ10515kU0UGssghk8rnjFoHlj82EdSYAnw6wvhm/k7prxaF3cEcvwa
 I76KxLcdh4UaNUUWP3mrDV9+4T+uyN7wvQCeNsCcBd3QkbmhvS65e1G+t
 NxmsCF79YG64XpLTF1GViViQ7+XKKzXYg3i7g5mwQIhBREvhaqNqsUYwk
 uBHjqupUfsPMIKr/DgNyU9vaHBJL2kgAVZeogxZ5eR8g2ToTm95qqEx02 g==;
X-CSE-ConnectionGUID: OkFD3/EoR/2aTNJ/LLZ13A==
X-CSE-MsgGUID: GzJ0eDb4RdKy2Z4TfgTdwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="87178012"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; d="scan'208";a="87178012"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Aug 2026 23:55:43 -0700
X-CSE-ConnectionGUID: dOyaobH4RWWgwl1r9O03uA==
X-CSE-MsgGUID: a00uDcL9R+e5yQN2foML2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; d="scan'208";a="289652358"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Aug 2026 23:55:43 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sun, 16 Aug 2026 23:55:42 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Sun, 16 Aug 2026 23:55:42 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.7) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sun, 16 Aug 2026 23:55:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zt3v+fD3N3lM09gqp1ZAwINeVwty3eHOrcdwipJsYEW+CM8hEFg2zansJaIY7k645od7CPkFQgJ5ZnK5Pp//lI7y/mhwQouZDNg8gwGARh6xMGeeMogdBdcj7qvajep+gZBl8xX5by5YvwAj9erqZmWOUdcE3F0I6y60ilzLIK/mFflnD7KrO2/ZS+FeRcfh05AS6riu8v1jNHU4SrvlfVAtvvBNcldAtvfuaUjIDbDE2J58I+83T/6V0MsATgjxC3oEq9Qc9YMmxgZEApvh76jNkQWNZ0cg0rmUkt0lITE1brAucfNSd+bMp992iSaLQVlfQVwPu5wfmUWNJSD8UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+wTWwufic3sf7sCkeKwZgJpHto2Zi6rNmTvd6/PfdH0=;
 b=yyO67rkm7gyBvul7MuAP4ZTdD+AG9aAax3itKrxU0H+l8INgqqVpJLmEoYYiVzvdqe2vcSjCCn2cbFQ9Ll6m+MkyF0YCQkvRwqeZiZ93uAwDM2V50uXf4H7dHeZ8jXxOcIzhELgF6Z4DSm4SMqxdvXGVIy9Hp0C/cxY0NlHE3xymLWNBDpBkrdJE+t8oPiDwOWsQKhm27dBJdrhxKpCSdFCKBcFUHMydpGvBv5zRHeXyKzaH8ptace5jj2Z0J8klVpGhsEEp1LBve4oXkbGAUcUUHuzbwx8U3sxfyC+RzdLWMzFbitUlLkeRvsVDi4oeD9VV+F8gRcQheO38s2Oa0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6782.namprd11.prod.outlook.com (2603:10b6:806:25e::11)
 by IA1PR11MB6170.namprd11.prod.outlook.com (2603:10b6:208:3ea::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 06:55:35 +0000
Received: from SA1PR11MB6782.namprd11.prod.outlook.com
 ([fe80::cd29:ea71:32e6:ff0b]) by SA1PR11MB6782.namprd11.prod.outlook.com
 ([fe80::cd29:ea71:32e6:ff0b%5]) with mapi id 15.21.0315.011; Mon, 17 Aug 2026
 06:55:35 +0000
From: "Mandal, Anurag" <anurag.mandal@intel.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>, "Loftus, Ciara" <ciara.loftus@intel.com>
Subject: RE: [PATCH v3 1/7] net/iavf: discard empty AdminQ descriptors on reset
Thread-Topic: [PATCH v3 1/7] net/iavf: discard empty AdminQ descriptors on
 reset
Thread-Index: AQHdLhSeffvd9ecx7UmUq2GMAJS8XLahzmUQ
Date: Mon, 17 Aug 2026 06:55:35 +0000
Message-ID: <SA1PR11MB678280ED0782CE3B8C966281E4A72@SA1PR11MB6782.namprd11.prod.outlook.com>
References: <cover.1786948817.git.anurag.mandal@intel.com>
 <8c83baa243e010dcf171c12baf1b91f57fa7b148.1786948817.git.anurag.mandal@intel.com>
In-Reply-To: <8c83baa243e010dcf171c12baf1b91f57fa7b148.1786948817.git.anurag.mandal@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6782:EE_|IA1PR11MB6170:EE_
x-ms-office365-filtering-correlation-id: 46e0dbb4-f336-41a5-d2b8-08defc2c89ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|56012099006|38070700021|11063799006|4143699003|10067099003;
x-microsoft-antispam-message-info: d2yY0uHMQq3JFjWVYbFZJYkrsGIwHYwgNQCDs2KrmuqLGEZ9J6QzXlxl9XNhAuJaWES8bJ1Y8tGOClFr8bpzZwsTik2gkugNVGUeBCPLND0KRDv1qJETN70GPXJ6TYJ+nVXbSN5fuXfctCE6IHHbNJUTsmJcaB86KvEMAW8+/L56IWK6ek/as3vy1TPLEkzG5MDwGSU610b5b3q9si/LDIBUpCFF8yVrsYaKiFjwWmjaKx7InX5yYH5pTTWMATjdJJd34G8cLL+gcDDjOzcqWkusgtGCa49jP8A+8+TcYs6/fjCc0/KX4O0ct2qQmfSDBjg344046oaJr0GpcLTItVxlqYIyagFZ8xnIE2bIvCWDIPhMS8fEkpXg48vljRfBkyXS1jrrBAm3WEGh6M22tjXUzgZiaAyCBsJQhc2KoM5SubTZdCXVT24IBMRYF8IY5z5BWoN6KEUsK66dmByemnngDt25GR2w5qgrLx98CDURJGtvJExzwd0FYR0Mb/uBP6KbD6Lx6l2gGg/ebkyEtEV0t0esDTniDRMF9Ekw4hXQUoaa4H3bKhbHJNV6gl9UUg3CER81bgaHYy8dmNjEDc3Fz70X3xq8GnSV5zxHdifBwABzVosrv/1QDT7bX9TR3kkoNAekxQdnfgjL/H69c0Wg4cMk+xd4nPW8TuwFfXo5D86//Nh/juc7bVMCMX0/eBeRUbhQQZehmHMoMFPVoCijVnl30P5fQMOt5dErbbs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR11MB6782.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(38070700021)(11063799006)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ObLUTTPVC0q9z2ehpEBmc1iuCP2WKCtLgAysqrMiapCEACf9liCiokIN2yZv?=
 =?us-ascii?Q?/M3pmY01iQRLEsjroQ0GngkrY1JOTexA2AvreOmk9c9WkClZguIHSmIfYBfs?=
 =?us-ascii?Q?3SciFbyz5tPgih0XBKxScDR8xTTKRmn2JfESanB+SncMo6B6d3bTb2bExUlv?=
 =?us-ascii?Q?EvAsFMFQLOf1DQxBWJXU1nCnpqrnlowekbf1MpWf+6otCpXJwwhFy+opedqp?=
 =?us-ascii?Q?I7DxsjF/4B9QODYac9B691JQgb82Yoj8qBtktWsm/0vCSSYv6jaRmZmG+XNa?=
 =?us-ascii?Q?59BhN2aravtkzgqfYD9I9jky229t/zDh8z1Fgtt/YZgRI/WpJwu+DPt141nW?=
 =?us-ascii?Q?vsGKCt8kUIgrucMsaHQzHZBMa5/3m/egGUj/cEekK5NVoznN2H07RK0APKD4?=
 =?us-ascii?Q?PO5ppviEjmx6hA59RO1zSwF3gLzBjhXIK6t8WxLxiwLLE3O4E8mtd+soUXkM?=
 =?us-ascii?Q?8P3rITUmcq5idudNEksjs8yUpw5y/gzYDempXKajlVpepXeFvfmxV5KHs34r?=
 =?us-ascii?Q?aEY45qBz28DmKVMUzzqa+y0FpgdpBrH1eL3qvKXfCTl98s9BNl/Xxf+jgOM7?=
 =?us-ascii?Q?aD8blm5kEyYKHYusBzBagipU+0STtNEqmd/VBunDU/kBLV8bsjctwjoyDFGJ?=
 =?us-ascii?Q?VcmSfhB45+e5NcDd3rABGAhW4nnNhQpdXxbHcYNyJ50j1tXuE6fpDqQJNDxc?=
 =?us-ascii?Q?GA1qplXpfUyaH+HHvXq8FXI4Sl7Rtpljw/V/B/BfqFOhSzn+YCGpKw0qbOU0?=
 =?us-ascii?Q?bE+wRoYOrWLy6rTwsm6M/N5eGf59v7V2hXz6sMvam0NFPFB0Wo6KlSrL0e9P?=
 =?us-ascii?Q?8xujyA4OA2CHKssKx1IBSxvtlORAchN8WVwzxAXcd4DdTHn1O51AqJS03lm9?=
 =?us-ascii?Q?9fdFFL6cuBtkBEQMpS5FhER3IsusVsTLSw6NC4RZLNFvtwa6zoGUynoRf62U?=
 =?us-ascii?Q?FqT3SufK6YfY52CJcWmeHnE7NLbWIWQpBBpBS8cfGcMxGtRh7q9SVetcrdwz?=
 =?us-ascii?Q?EwB+SPmftJy/rUivfl003vtd073ZQcUFLKmkGy2cOyiNXSCDRNXVb1YtWm+w?=
 =?us-ascii?Q?fMantKZK5q4FxhWQsA7YVplmbOWrTazsSyu621k2UsofeA8GK3VDryiyhkGy?=
 =?us-ascii?Q?O60otz+ipca5yzPs5IVPFLD+utrTqTBMZXuxiNmj76t23LCHf/rBiWgw+vRO?=
 =?us-ascii?Q?hgIKPtfYag6z+HO5bUIuVYHBQQE+ReJIHyGq7fxEGLsuh8w9sgPRmuwIw+ek?=
 =?us-ascii?Q?OKsVNwX2EpTP7PzsPPQtrdXvlHKf9sLyDz91mdDYVFOdUlr6Cbrn/x6jS/Sf?=
 =?us-ascii?Q?T1unHow9thUUKIib0/sU+9hcJoahH0JmAm78yg7eGcDMaXy8WseK5Sa0PosL?=
 =?us-ascii?Q?UqnDaWdLy1WMDu4pFADVitJfs6QjOvDOB66ISjeH78esGkEFUsN5JRyMEANg?=
 =?us-ascii?Q?pWbTtyTsZPFkF6B4y2VnU1ktgFXkNY2DWtTBZV/ujoUoiHcEbT+lPx5jHq7F?=
 =?us-ascii?Q?ZVMTvTNeaPp+GQvOsk6//ljMvkjvxhtm0GzfVc4gy1RH5Ag22tWJWgdRmleY?=
 =?us-ascii?Q?wzXTy5FdQuUS58+4jIY4Le2s9pG5mba9vcKzPvEgq81cwmjv6EFTfVeO+2s6?=
 =?us-ascii?Q?BZniq81OWcu3Rqr7DXjiVwufPt/1rE8Wib0/pEZ3SazgXHBLyO11z4OfuTx5?=
 =?us-ascii?Q?HznxixJHDKHxZrnsLPcup2PTNUKVjmbGjVqAwYOUu/EbffsgG6fAPsMt53bE?=
 =?us-ascii?Q?HUcoLUwSFA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: tDMvuYOLzpOiXIMBakIz1BQkXp76myee1X3ITzkGxjMru8LJq5TNFm64ePvQ0bSyPSHCxisJ/exn6olNPBDkNIjPPDvS0oD9vSm37otXCYbdaMAkWgoy8DbpgwuPwvLfCo7epnuiCGhtNSM8nIGIAIi3/ycSrWmGmypmVPlMcusG/LeXK6lw0s8uz7tn/Eb9MIBllkPVQiDZVE0v9pP4eSol5+Sc2bIffuoGeNqnHZy4pYNjrYkG+1nahesvrNLu1A/5EV2jv+xg8oBLQLoYNR2WzlR7oKfEyihUAULweT10zf8JeICv9bBD262cxFfjLb9MTggCObLmp9PGW7YVtA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6782.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46e0dbb4-f336-41a5-d2b8-08defc2c89ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2026 06:55:35.1609 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M1KvnFaDwmxZt14JCT2zKCYqOz2dmKlYburYvIiBzMVUkIMy+erAH4/v/gnHcy1s3YJ03gZfRVZyqAocCNz0Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6170
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
> Sent: 17 August 2026 12:19
> To: dev@dpdk.org
> Cc: Richardson, Bruce <bruce.richardson@intel.com>; Medvedkin, Vladimir
> <vladimir.medvedkin@intel.com>; Loftus, Ciara <ciara.loftus@intel.com>;
> Mandal, Anurag <anurag.mandal@intel.com>
> Subject: [PATCH v3 1/7] net/iavf: discard empty AdminQ descriptors on res=
et
>=20
> During PF-initiated resets iavf_clean_arq_element() has been observed to
> return success with a fully zeroed descriptor (opcode 0).
> These fell through to the default arm of the dispatch switch and produced=
 a
> "Request 0 is not supported yet" log flood in the field.
>=20
> Skip descriptors with opcode 0 so they are silently discarded and do not =
flood
> log.
>=20
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>

Acked-by: Ciara Loftus <ciara.loftus@intel.com>

> ---
>  drivers/net/intel/iavf/iavf_vchnl.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/net/intel/iavf/iavf_vchnl.c
> b/drivers/net/intel/iavf/iavf_vchnl.c
> index f346837bf1..23e4107743 100644
> --- a/drivers/net/intel/iavf/iavf_vchnl.c
> +++ b/drivers/net/intel/iavf/iavf_vchnl.c
> @@ -614,6 +614,11 @@ iavf_handle_virtchnl_msg(struct rte_eth_dev *dev)
>  			break;
>  		}
>  		aq_opc =3D rte_le_to_cpu_16(info.desc.opcode);
> +
> +		/* opcode 0 means the descriptor is empty/zeroed, skip it */
> +		if (aq_opc =3D=3D 0)
> +			continue;
> +
>  		/* For the message sent from pf to vf, opcode is stored in
>  		 * cookie_high of struct iavf_aq_desc, while return error
> code
>  		 * are stored in cookie_low, Which is done by PF driver.
> --
> 2.34.1

