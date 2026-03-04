Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1570EFCE53
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Mar 2026 23:43:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 28F4E4064F;
	Thu,  5 Mar 2026 00:43:23 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 69C724029D;
 Thu,  5 Mar 2026 00:43:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772667801; x=1804203801;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=5q7+oESjLAeJG0NMpdn2vu+oqgqcMZtvAWmJa7+ugy0=;
 b=cKoB0x8DNgcZTiK/GAk6TM7Pjl0XTZU5fIHLf7l3l+lhyZczAFzyr484
 4OqjVubzmwk4e2CdHEzbIahBQ15OsxgdQPrVbXWiYHfvgPYdXN0t1dCYx
 o0z7uGxp2fGf+rKGW8OLFw1YkW8xboeSbfWihMxoN1rZ7IKBFJOq5IRN/
 eMh6rLncB7kExp0o9kQ8qsSCFsnxlj10iy/Rt0qIBNPW/w29wkPsHQCKg
 WDYuxsUzW1o9lewl9oMegw9UInbA87s427jzDC1ug6BK5PAPbs2d6CotQ
 J1+sZqstlsRwcfOmIQrrcFlwn3I44hczq97yhPS62AtDOuqP230xqab0I g==;
X-CSE-ConnectionGUID: vd3O7IITRC+Ni9gUHPREEg==
X-CSE-MsgGUID: OmAXI8ApTxWnZop8x12SRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="73657261"
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; d="scan'208";a="73657261"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2026 15:43:17 -0800
X-CSE-ConnectionGUID: xF50V0mIQYS7G7sdruByiA==
X-CSE-MsgGUID: cKLF59fmQ6ChyvD/UoVb+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; d="scan'208";a="223461422"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2026 15:43:17 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 4 Mar 2026 15:43:15 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 4 Mar 2026 15:43:15 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.45) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 4 Mar 2026 15:43:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dColZ5FvkP3Y3uc/x6JBmveN8JL1VpMsQ+l192NEcHy/fZzG39UQVq43byHawWMu56NRLtDcLlFW3Rm7i0X7PRt7irFRrZklkbRL16xHjIjQm2WAn1gDIr/omRNvu3rMs2/k92ZOJqWSzZK1N2TIYlVsEH255LOvrdnGuRpkkQmaHfNNyRZfIWBr2PpAPYDf+h91i60L8Akf7ps5DoEGeSn8Qjrmw3MLMWKu1UvPsyX2ctuJDVwXoIHl8anod/m5i/gf59wpDEDHT4GR/1jHCQYXX40vIzWCkX3c0SIkPCIn3hXsItF6pExFyFh+nb3Pl9YObpYUiIkPvdShr7o+cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+UYDG9oZrw0oiKTGSHW97BYdQoAuNVhWXPklmvpECCA=;
 b=XMpJ4KN4adDe1+Qgyr377JTHGPzKFYkCOZp6AsEcZCslCdFVpkPSEd3AVrkbyHDDzIDrfSv16S4opWAhtfrh6oBwFBRzqvqAaeuT5Pfjam3K41vnIXCWBtTU3tYV1kY5JqHCZNNB5ckLOT1+VPxWJlMuqjQNT//WeXOWv/HiYR2Al+cUKQDC0WxU+kzKAEwONUXBHX+JAXZzANl4d+yJkOak/7a2yh0oV95vkGmRuBJv+cuaN1+0/Ytx8270LKztrgD37opppMN9YlxtBKWjalNkZ7R8OiQOJA+rqx35+YWY3EljVygh+lAVKXtK8vucVgKfi9r3Q0b2PDK6Zx1okw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6116.namprd11.prod.outlook.com (2603:10b6:930:2b::14)
 by PH7PR11MB7001.namprd11.prod.outlook.com (2603:10b6:510:208::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.23; Wed, 4 Mar
 2026 23:43:12 +0000
Received: from CY5PR11MB6116.namprd11.prod.outlook.com
 ([fe80::7243:ab06:2282:cd8b]) by CY5PR11MB6116.namprd11.prod.outlook.com
 ([fe80::7243:ab06:2282:cd8b%5]) with mapi id 15.20.9678.016; Wed, 4 Mar 2026
 23:43:12 +0000
From: "Mandal, Anurag" <anurag.mandal@intel.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>, "albe19021990@gmail.com"
 <albe19021990@gmail.com>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH] net/iavf: fix old primary MAC deletion
Thread-Topic: [PATCH] net/iavf: fix old primary MAC deletion
Thread-Index: AQHcq8hkmdd33pQouEW4494Ggk1pDLWfCJ8Q
Date: Wed, 4 Mar 2026 23:43:12 +0000
Message-ID: <CY5PR11MB611638120355BFCA2B2E5696E47CA@CY5PR11MB6116.namprd11.prod.outlook.com>
References: <20260304111606.283035-1-anurag.mandal@intel.com>
In-Reply-To: <20260304111606.283035-1-anurag.mandal@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6116:EE_|PH7PR11MB7001:EE_
x-ms-office365-filtering-correlation-id: 822c7fc0-77b4-4efc-e0e9-08de7a47cc59
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: npnja/LQJx0jo4D8nm8J7a608ltbuZwanXvOzvePPXmiSYSVlLvxd27sIbJK0awT7AkQWxgRq0tH9sfsiywd4tdeN4gkAXJWkFT/makXhjBFpq+Cbl/M9dauQR6iTYlcF1qIqiONHqeLR6TpIYqSiy7hLETh4P8z8Bgu405LG/pjIlsz0BUmT2/iIP01Je1RRKldMTPh14k1pMFWHlCYbxeq9jWtSSvIAmE0FLi7O47/1xv3jZ4zNgb8oif1SWAmeAe+UYN6ln01Lx+Rj6N0Rt2X0RRam/WQun0i/pEN85KuDIfWwmJi1KFAJrv81ztHhYupIb1+99Qq1O2T+XrpRb5uIyozUmHM2XOT/XUWafg2WUoAX6yAmsWx4kRYxD+Dwxtv273Q5mOIuUHGC5Pc8hor0J4O+xsU0kXsuzfMQ7R5lOe2cmWFBMZDd9m4L3GZthrkLVSVro8VYJqgalUDNGIbJ7apYQZyl3k5k0aM3t9eEMUEuNLRq7mpIjhVAhuyoQub/LetN4zKpGhR/Akpcus9in+VfZ1tK3MBDO8HtoweHJJOnKDfNhOMzz7r0Ui1N9/Nr8VW/wpu0WwKbIDyR4GyOy/OO5cyKi1ypJ0Nq1D4yFRmKUpRM3yQ9+RZ6URDO8CmXTofi+4QztiEqZ4XASs2/eJMETPj7ZwkPALbFffBLKWhO8lwQL1960BiGnRXX9yQ9s3KeIQWTn4Spcz89o6lU7YOdesgVV1TCZVZw2iFqsTGg6rspitvn1/uSAUtKqcPuqo91c6iUo1ZyC2GUMguDQgYbRwuYmW+srdYyrQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR11MB6116.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9GtvAmJdL9ycxttXP7HqdgpjVsuKPYjj9lVVtaFLXjIIb3xqZGVrzqpY8vZR?=
 =?us-ascii?Q?QHW07AYXsUt50QWcpC6R7YAFW81za69GD27qCTd3L/dyYO3v2UTV3T5tviqt?=
 =?us-ascii?Q?rpIfE1LZVEu86rxshiL7wEu08srB/WMzjzeZjjo9c9eBg1l14C+wjUl3lRGj?=
 =?us-ascii?Q?aQ7rrLXqQMppg/UDSwaJnG3NE2fc4/GCkblWTVVHk+Mw53hb6fg95lzA25UP?=
 =?us-ascii?Q?FGeKyfQgPoNM1XWD7Yt0UwUhSgIL2kE4/ohfE+pCDNJoS2RqeYUi2B4cGJJQ?=
 =?us-ascii?Q?4Z7k1nsalb9xJlPMPVhY5uT9PtwaeHI5M8iRa1GGrabon8oymj33vwTrve+q?=
 =?us-ascii?Q?BIFry7qZ3zy034K9ISZRuqQWIwaRALHvwRpZDgT69W+e7mb82uThw28uzNpm?=
 =?us-ascii?Q?2japI08rnUDX1LIVVByi0aqcK32dA44KuOFp8ljrevkw2fUBTd2y+yaA+OJo?=
 =?us-ascii?Q?U3Gwhwc8ioOb+guNm27WNFy2jqPzoagILRKkz1AyO3H7obUOkgiHYOjq6URT?=
 =?us-ascii?Q?gR1KNMEAQe9mp3acW7LCh4dhNu/Jjr0KCT74+BiKr2M2jZDylENosexlOesF?=
 =?us-ascii?Q?nvtZ4igQICcgjazZv5wdhqEaagAAWioDugrMCynSpjkfzJjkgaBgiVg2twPy?=
 =?us-ascii?Q?7MojeBuhNBJGyZSuERHXv+ciYOMxHGVHSEeUG3RLWYvh07Ldj2LRhQB2Ty+K?=
 =?us-ascii?Q?lE0Zs5RePTgxveVg+hxoMRegdhgtDm8fko6KEitcehSOou5KU8e00KuEz8vT?=
 =?us-ascii?Q?boJU94ir0MneYeZWFOOi4zk6em8Yes+1nyGCMhNvkKo1rqunfIL7dQIKy9Wq?=
 =?us-ascii?Q?3KGoINIySJUgMlWIMJMkeiEPkAcDM/zJwqGQeByqL+F4lnXOR+WsDKXGGqZs?=
 =?us-ascii?Q?NghkaPZKdsj+uCAbxosC8h5wSQ4BOEyGdkg9Ifm7DVvYZVb5KLmKCcLPXrHg?=
 =?us-ascii?Q?XbOiLsA/d5hIPWtEILgiBvm7V8jq76jg9Uk+zlc8QpJqQCcggA2eF6kL702b?=
 =?us-ascii?Q?0LNY+7FhfE9JHVwsMMmFmxI5Aj2dy9ZqdprU3NqzypbBpBexYoGoKsxW6iV1?=
 =?us-ascii?Q?sr0LZEmkMRM3kGlUKDoC/x9neewS582jmeBmSasrAYacEPKdgK5ypr2nsfnr?=
 =?us-ascii?Q?dim4M8dyHowdPwBb4FgcJpcLEJbByBS3NRyND+z8QSQJIfr3wxgaPHLRE80R?=
 =?us-ascii?Q?2whb5lIH2luAdTjGc90pVhJnRNUPSeBpmGTsVPwG3eLo9QwU+dyBxWIN4EyB?=
 =?us-ascii?Q?2zwZQ1lbM3R8qUV0VPqciVN2nK8xJopy+RdQivOQsCvNoEYOIXdJh6uPn960?=
 =?us-ascii?Q?GWXNEVouFkpc68B+1Gvqn8vPFmIC5YT+Sx9ZEzW4QcDpqUU+s3/vUq6lXZ0P?=
 =?us-ascii?Q?zg07ZmEQ7EMpjykzLmfmZ/gATt6x/XIXqv2qoyOknQn73FCzI0tA169VHgCi?=
 =?us-ascii?Q?4wmFsBHfWS8ZSc9HvyGMS6vD1VWHR2//SjMPFMEJG/H7p2QiPcANqp2hUPpd?=
 =?us-ascii?Q?ie4M1CTP8fiPLrivTHOLqFwF3EfJaDtQhn1vY+TQsYtVwDxEx2FVGFfoLN/m?=
 =?us-ascii?Q?W6NppUHqbkDSLsR/DIWvJ95y2S2I4yJyWGYwudogdjxcc3UoGv/0n+wMMzVo?=
 =?us-ascii?Q?EBkqtq2ybxvkHfJqHyZk4UHEsWjigAn2QUvu4hdZztfqQAEDpCD0j04A0d1C?=
 =?us-ascii?Q?f2Pgyg16UD6OKqqwzxo8r0bj2wdvr/GM5e+KgmzFON7EE/I4EhKhl9kejn/Q?=
 =?us-ascii?Q?YtpJhMoKoA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6116.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 822c7fc0-77b4-4efc-e0e9-08de7a47cc59
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2026 23:43:12.2220 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3bGvgpnTj9CC9wxEEf9zg05j0As7Az1vzQQKP1rQkca22Fi528PGCQTBuFnedjXJoZLVXdbQKMWgyISFKxlS1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7001
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

Tested-by: Aliaksei Belovus <albe19021990@gmail.com>

Comments from submitter in Bugzilla-1897

"This fix works at startup. The only thing that bothers me is the iavf_add_=
del_all_mac_addr method, which has no error handling and doesn't take its r=
esult into account when setting the mac_primary_set flag.
But for me this fix is totally good. And my problem was fixed."


> -----Original Message-----
> From: Mandal, Anurag <anurag.mandal@intel.com>
> Sent: 04 March 2026 16:46
> To: dev@dpdk.org
> Cc: Richardson, Bruce <bruce.richardson@intel.com>; Medvedkin, Vladimir
> <vladimir.medvedkin@intel.com>; albe19021990@gmail.com; Mandal,
> Anurag <anurag.mandal@intel.com>; stable@dpdk.org
> Subject: [PATCH] net/iavf: fix old primary MAC deletion
>=20
> Old Primary MAC removal operation fails while trying to set the default M=
AC
> address on a VF via rte_eth_dev_default_mac_addr_set()
> when VF is yet to be started post initialization.
> This happens due to non-assignment of the old MAC as
> VIRTCHNL_ETHER_ADDR_PRIMARY MAC on the VF as it did not invoke
> iavf_dev_start() yet to do the same post initialization.
> Logs indicate old primary MAC removal failure even though
> rte_eth_dev_default_mac_addr_set() returns success causing ambiguity.
>=20
> This patch fixes the issue by introducing the flag "mac_primary_set"
> in the iavf_adapter & is set to 'false' upon VF initialization.
> It is set to 'true' when any MAC address gets assigned as
> VIRTCHNL_ETHER_ADDR_PRIMARY MAC on the VF. This flags gets enabled
> only once for a VF.
>=20
> Bugzilla ID: 1897
> Fixes: b335e7203475 ("net/iavf: fix lack of MAC type when set MAC address=
")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> ---
>  drivers/net/intel/iavf/iavf.h        |  1 +
>  drivers/net/intel/iavf/iavf_ethdev.c | 19 ++++++++++++++-----
>  2 files changed, 15 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.=
h index
> 33ba3115d0..f7f3522d6b 100644
> --- a/drivers/net/intel/iavf/iavf.h
> +++ b/drivers/net/intel/iavf/iavf.h
> @@ -383,6 +383,7 @@ struct iavf_adapter {
>  	enum iavf_tx_func_type tx_func_type;
>  	uint16_t fdir_ref_cnt;
>  	struct iavf_devargs devargs;
> +	bool mac_primary_set;
>  };
>=20
>  /* IAVF_DEV_PRIVATE_TO */
> diff --git a/drivers/net/intel/iavf/iavf_ethdev.c
> b/drivers/net/intel/iavf/iavf_ethdev.c
> index c1160c8967..7da92bd31e 100644
> --- a/drivers/net/intel/iavf/iavf_ethdev.c
> +++ b/drivers/net/intel/iavf/iavf_ethdev.c
> @@ -1042,6 +1042,9 @@ iavf_dev_start(struct rte_eth_dev *dev)
>  	/* Set all mac addrs */
>  	iavf_add_del_all_mac_addr(adapter, true);
>=20
> +	if (!adapter->mac_primary_set)
> +		adapter->mac_primary_set =3D true;
> +
>  	/* Set all multicast addresses */
>  	iavf_add_del_mc_addr_list(adapter, vf->mc_addrs, vf-
> >mc_addrs_num,
>  				  true);
> @@ -1718,11 +1721,13 @@ iavf_dev_set_default_mac_addr(struct
> rte_eth_dev *dev,
>  	if (rte_is_same_ether_addr(old_addr, mac_addr))
>  		return 0;
>=20
> -	ret =3D iavf_add_del_eth_addr(adapter, old_addr, false,
> VIRTCHNL_ETHER_ADDR_PRIMARY);
> -	if (ret)
> -		PMD_DRV_LOG(ERR, "Fail to delete old MAC:"
> -			    RTE_ETHER_ADDR_PRT_FMT,
> -				RTE_ETHER_ADDR_BYTES(old_addr));
> +	if (adapter->mac_primary_set) {  /* delete old PRIMARY MAC only if
> set */
> +		ret =3D iavf_add_del_eth_addr(adapter, old_addr, false,
> VIRTCHNL_ETHER_ADDR_PRIMARY);
> +		if (ret)
> +			PMD_DRV_LOG(ERR, "Fail to delete old MAC:"
> +				    RTE_ETHER_ADDR_PRT_FMT,
> +					RTE_ETHER_ADDR_BYTES(old_addr));
> +	}
>=20
>  	ret =3D iavf_add_del_eth_addr(adapter, mac_addr, true,
> VIRTCHNL_ETHER_ADDR_PRIMARY);
>  	if (ret)
> @@ -1733,6 +1738,9 @@ iavf_dev_set_default_mac_addr(struct rte_eth_dev
> *dev,
>  	if (ret)
>  		return -EIO;
>=20
> +	if (!adapter->mac_primary_set)
> +		adapter->mac_primary_set =3D true;
> +
>  	rte_ether_addr_copy(mac_addr, (struct rte_ether_addr *)hw-
> >mac.addr);
>  	return 0;
>  }
> @@ -2789,6 +2797,7 @@ iavf_dev_init(struct rte_eth_dev *eth_dev)
>  	hw->back =3D IAVF_DEV_PRIVATE_TO_ADAPTER(eth_dev->data-
> >dev_private);
>  	adapter->dev_data =3D eth_dev->data;
>  	adapter->stopped =3D 1;
> +	adapter->mac_primary_set =3D false;
>=20
>  	if (iavf_dev_event_handler_init())
>  		goto init_vf_err;
> --
> 2.34.1

