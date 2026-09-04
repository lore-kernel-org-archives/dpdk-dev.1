Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50EBCC624DE
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Sep 2026 08:11:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B689442DF1;
	Fri,  4 Sep 2026 10:11:31 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 4E2D640A77;
 Fri,  4 Sep 2026 10:11:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788509491; x=1820045491;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=KDG1eIsnyE/70Jes27DDH3QFSJhCNgYMRC6o6GJpnMA=;
 b=YnA+N7vglcjkHo69ED9imxfIjfXtQjvmt/y7+eInnhFA1loAX0wLWe5b
 fwvUD0YMvEHJ+gSkvXkH3+hX4VKuFs0iRFVFJFgHEto6U9FkVfnp20j5R
 M/UdytOC/4MHpsz1+zGCmn6SVLwYOLmYqi5YrTkXj6t1rX+QpUEMu3UBX
 UtzOvXNbSepv9ErxFLJzbDenNHfpU4aXomIMqNBN5m7fZX2NIkecFcCqQ
 6S3oVW9aNY1uL4GDhWRhlP5ERgGkmt1Zp1DQBOPj8atFfXu1w/H3DaxHP
 BnswivZkb23iacjxyVMVhOGYooFMz0+47BceFHdRHV7cb1HdUm2AKYzME Q==;
X-CSE-ConnectionGUID: 2q4ZOusZQRK1xH0lq/z/8w==
X-CSE-MsgGUID: YuTj/A9yRQK84uLqfqjakA==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="87945508"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="87945508"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2026 01:11:29 -0700
X-CSE-ConnectionGUID: cxIcVbiISVSML8zlMgOteg==
X-CSE-MsgGUID: Kh7lWHNSSUyCcHorG03FRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="273756923"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2026 01:11:29 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 01:11:28 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 4 Sep 2026 01:11:28 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.23) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 01:11:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BvCxaoWuB9pOMfzQWL7ZTqyRq7ozJ0UQXFD03PAVaajuyhPRKhlqz0p0AMI5faR5SAe2MNse1Tahult0h/NzTtdPWZLgp/PYGlIMTjE9pmUif1zVgsNHLWPel1oGSCHaYaurp82aBglZZ56cVP8naBLC6QwkdN08mUaKwDiw3M2Z9lNP4cCM9h9RYxzbutX2abBPlGaZR96ayefDh56BhWNsLeMbC9vf9/ZaDDINONJ8/dusYGciEi6bNkdwOqLIItRA8OMcbj9yqnZOAbV5FhbnUiE6arnzbVPmCQIeleid5OqV15gcuiOEdTM1i7V4wYWt2mDMFgOgvFdssuFXpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X+h9AgmZtGXfE0Oeo56uEXJDG3EqbZZy0P6XuIu8+EM=;
 b=IzELILmkk4I7uRw+Uq9pdBjXW9aflMs3A8wByhD8mzaRBJmiK6qJtbu7tj7ZdR+yY1OXVt+RUUzZH0I+Y+U2eEGPs/SzrMQ9JY7GykMRuhaQgQV6zQms7jZ/yMQeHlsYxKeNgzJGpJM3HLwxHUSpbm7+GPX1A61fLeKLP4+zRKsttHCLk+N5tySSqAeEiGMlmeumRQgf44rASRtxfIVVbYd/3uPDBV+qEA6xnkDQlYGCewefFaR3xXbDfgFTj+a8FIggYdgfChccxapmRvxZTXID2v6f/SmI4Htmt3wfSoMLTxnaWqFArLPKNMRy1W876Ec/cKRKIuFmpSwf2N+b0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA4PR11MB9278.namprd11.prod.outlook.com (2603:10b6:208:563::12)
 by SN7PR11MB6946.namprd11.prod.outlook.com (2603:10b6:806:2a9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 08:11:25 +0000
Received: from IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057]) by IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057%6]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 08:11:25 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>,
 "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>, "Mandal, Anurag"
 <anurag.mandal@intel.com>
Subject: RE: [PATCH 3/7] net/iavf: fix VLAN outer TPID setting on Tx
Thread-Topic: [PATCH 3/7] net/iavf: fix VLAN outer TPID setting on Tx
Thread-Index: AQHdOTNG6tSjxyewpU2vOm2CURJJU7a81PAAgAAZXoCAASiL4A==
Date: Fri, 4 Sep 2026 08:11:25 +0000
Message-ID: <IA4PR11MB927836874928ED40733F1ACF8EB52@IA4PR11MB9278.namprd11.prod.outlook.com>
References: <20260831102621.495759-1-bruce.richardson@intel.com>
 <20260831102621.495759-4-bruce.richardson@intel.com>
 <IA4PR11MB9278A14D684FBDBF1A138F158EB62@IA4PR11MB9278.namprd11.prod.outlook.com>
 <apmD001iKe_Tut6n@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <apmD001iKe_Tut6n@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9278:EE_|SN7PR11MB6946:EE_
x-ms-office365-filtering-correlation-id: 8d72cb4f-03bd-4cc7-7de1-08df0a5c1d82
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|38070700021|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: 1xXjYvFEReIH6CzNTb/euNkiM/jnhK9RmmsOFNHVudz5IhQWMbGKxakOdl3TtI2GYkDuUPlsEF5pMW193p87CsrmoTgVSV8cQJ6oaPjDH32T52CuofnEmHwPvW2xXOuVxU4PI1xHhGop1pKUmupT5XGZsbvPX6gQbIf49vtKeYVNQGoT6FW//zg1UJXoFGhaGxR3mp+uGJYLKt/xv4eo7b77LUa0TcKMa18ZDmutgKePkk3X94ncQzTFPS3oUUAizoHflXAimm/8nO5bNllQIOHEhslmJRT+siCOotGjH/2WVfsUozUSYbN3BynrQb9Wb+Lzczv83r4rdxrKwBQWveGh7ZaXBztRQWSDnJgnY2F9x5Ic+iYNW/m2BIbnWiM1X0YLcHjNTiRdJIDGCQlfaMcbcPK6A+FNqMXVq4PRyFz63lMR9W6n2DHhoq1GaDDNBEfuqfX8Rb8yirbveBIkkfb+wI5h/QsTIpz9GAv0kFFgRhbUaaqpm5sJsocLuZ2jY/uW87lHh5gqKN9eCNX2q3Mif3O6KXAYhKnpHk9R2WY23+FvOYjmCwB0fbMXQNGq6+9G84ncVsomvXkrJHF70A3rgGL9MVTFH++Ecd1a+NkeXw2l5BnzxlDBoQtjSXWG1H0e0CLMNpRidg+MRKHGc2u34Ke7yuuc7B6SFKZ7AaGVSG71ANh+nx2qoWT20We7k1TQ54HpXnVslFUcPGGiMX0biK/gArG5c1LuEeoTgy8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9278.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JQCYOHSM26Vv9K8oIYMZHn22zzAcSAZIPoCTfphu98aqSh5R3QZRQy9/6zCW?=
 =?us-ascii?Q?njmxPFryp1IHOIIDBdeBH/TYzLcgPmFSXiFsRrQwZlKvyRMqKw38nfulxHua?=
 =?us-ascii?Q?u44zeZMutBayFDR+zWoNaMf1D+td8TtjZeNY9npqo8LTNUR7HqhH6gnqmZqz?=
 =?us-ascii?Q?p+lquOHsYa3b3lVVai1ajtFX3ovFQlJ2+8QLYTc6bO8mqinhUuRHXNPrWofi?=
 =?us-ascii?Q?1r3gV4hRIKImZP5yrGdQ6KprETXl9wKeC4Rzpr5kiGHAak+v3h4kD/CfX5xT?=
 =?us-ascii?Q?CgFBELdT8YGeg9TmbWmGwH2wSwV923rlzfAHNb+AeitZgvfClTCZQHyCgIHS?=
 =?us-ascii?Q?EsnDP681Jqlf+lgjxuR6p4RMtOoJ/9MWxMsT1eC8j5u+tU2GknsBTgfueWFc?=
 =?us-ascii?Q?J3oqVOYkbzXucepYsU9Q0gv25tHaa3ilmB8Wu+ozMNJ2jSmTiT5bZAC3yVM7?=
 =?us-ascii?Q?kKcX1KdHEpDHe3WDkEcgfe4YSXDBFHNRmRMqsAt34TJsN23Fcq86AqjRjv3j?=
 =?us-ascii?Q?0dQql4Rst5/9Lr24zgFNIowCpyi9egJXvXzV7KqcF9U0INf6cnVDve9KcL3X?=
 =?us-ascii?Q?+oPDQvI2pQczKQ1j4VocJy0MEU3FR6hUP9bn/b8usFoVz1C363TpTKhKE90O?=
 =?us-ascii?Q?1pAREXkFYbrRJ5P98xTe9BmZyCbYcRGtmOhc2Vj2l9zh2gqE32C7aQXNwN/s?=
 =?us-ascii?Q?mH8w4R0GxdWOhIVQyQtvEnlolSZ991Zzl6SE6oJjErptIRHQ1LAujocENmQy?=
 =?us-ascii?Q?1YMM+QJczI7/ydjLjgiT88Sb5ZllI8vqvkln8QpeJHZa7hXLe9lAFTpRtiIC?=
 =?us-ascii?Q?I+nueNdD2ACaGu4ZmRgr4BQbLqLPNSDqVg6zsjzWIPNgXJVS6xkXXF2j6dKj?=
 =?us-ascii?Q?JvuvrTlP1H7XnFoEbO4/B/8Mf9zzB+tCZnyaEEi9zB67tY22+tUNx5Xh+Wfs?=
 =?us-ascii?Q?/WUYgquJjQ0PIJgWo7WsictkXqx2dBBakgDqMSCO/UF6MVjkCqJecbZIcrYa?=
 =?us-ascii?Q?eOrCUAd7X0nlIpKCTBms8Z8Nv5P2E7DV8sahqRTO5qJG224augYScw7nptHD?=
 =?us-ascii?Q?t/2y3ey0z7rE4Mkr1H5mP6HYtgGlnrE1yqmM/qXgHWRn6WSGuoVLAcEFVoAq?=
 =?us-ascii?Q?GJd3Q+oxzaefSdVrREHkXh17F1/5rTPImY21gfo/R9CwSc+eQoDH/s6oSFLv?=
 =?us-ascii?Q?6+un/xaeH6ZZeH3GjTDiX6Gn3Cz3kc7kw0mbpbwUD2nHs2CMGz4PbBxDPQIP?=
 =?us-ascii?Q?fjVmvrH4DlHn2lC7Ss0SdX8RXwbrDBOjzQZBoTkeqOoIfubomTgxcSQmYyhA?=
 =?us-ascii?Q?eUwGwORMZsZ1BAX0gDin0qQF+fODODPtwFB+JRF7DceJGEif9iYyR1YY2vK3?=
 =?us-ascii?Q?FUccXm9gTitdtLc1igfdnI5HKYgB1hAPi9W28lWeVbUaPKozdwTw9S67cmMM?=
 =?us-ascii?Q?5zAxXAcF6ultFWr6O8SHY8uTQZSGipEuJoYZgxZGzm044Y9PGsB8ijCGx/yt?=
 =?us-ascii?Q?yvMSANcOOOQ9WwQPPsfJ+LWHiX7uO2g1cGdKUkYMvSVC1Eh9wpHP82evzh9S?=
 =?us-ascii?Q?/lk6y5gI1TDgXYyBUGGfAqiyRxVyBBleyWDDDbbmAwTdUelrGxkIRIDO2W+X?=
 =?us-ascii?Q?hWTHoxJrlRcI3cGWBijUTb4Rf3IclIjunx5Z6z8o6naMS27c41LG//SJ9vGZ?=
 =?us-ascii?Q?L0VO2JCpQGmNSWX8WP9BhjyE2+NJDE+l3SDQh7xRXNhEPMZS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: GXgY4v/PWxDnQ5jTSaOjmsp3XuX/KITvln9Pff/A4L0lemEtUVQnx6iiQMEJwbyzqINrEEGlSRLvPF7aEFwlz+J/S/1DkIXr1JivJTaoxYevI/tt+ghb+UqejDYRHONBLPXvV6x9kBN4AtmwrbCriUygv0axSgUhOqkpNsSeOsWGJmzfQaR1v/iiHAWAV6csXUEKvALdwR6bfVwej1XX1X2dELL3ABi99oSUbp2DlTtqKmIVcYoQeKfnP6t32bInF4dU8VTx1H/aYZcZdXnr6rhChhitujNCaxdhAkHNUX0k2jgjsDmE+uto8bXHhItgudJHoJQqk7HxdWGzGW9xKA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d72cb4f-03bd-4cc7-7de1-08df0a5c1d82
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2026 08:11:25.8179 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SbvT5J4d0TnuFfIpmmw6Mm95OBZ9QQtoNc6PbHCTffJHttcr6xqPwZFbM9S12QaSPPhjnwBsr7YYCTSRYPvztA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6946
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

> Subject: Re: [PATCH 3/7] net/iavf: fix VLAN outer TPID setting on Tx
>=20
> On Thu, Sep 03, 2026 at 01:58:29PM +0100, Loftus, Ciara wrote:
> > > Subject: [PATCH 3/7] net/iavf: fix VLAN outer TPID setting on Tx
> > >
> > > The outer VLAN TPID setting for Tx was cached in the driver but was n=
ot
> > > properly pushed to hardware (via PF) when changed. Add the necessary
> > > push call to the update function.
> > >
> > > Fixes: 8599d7604e0a ("net/iavf: support QinQ strip")
> > > Fixes: 7ce1363b424f ("net/iavf: support QinQ insertion")
> > > Cc: stable@dpdk.org
> > >
> > > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > > ---
> > >  drivers/net/intel/iavf/iavf_ethdev.c | 12 ++++++++----
> > >  1 file changed, 8 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/net/intel/iavf/iavf_ethdev.c
> > > b/drivers/net/intel/iavf/iavf_ethdev.c
> > > index c4a6763f28..126be4c9a5 100644
> > > --- a/drivers/net/intel/iavf/iavf_ethdev.c
> > > +++ b/drivers/net/intel/iavf/iavf_ethdev.c
> > > @@ -1461,13 +1461,17 @@ iavf_vlan_tpid_set(struct rte_eth_dev *dev,
> > > enum rte_vlan_type vlan_type, uint16
> > >  		return -ENOTSUP;
> > >  	}
> > >
> > > -	/* This API only fills internal iavf_adapter structure
> > > -	 * and does not send any signal to hardware.
> > > -	 * Inner VLAN always 0x8100, so not set explicitly.
> > > -	 */
> > > +	/* Inner VLAN always 0x8100, so not set explicitly. */
> > >  	if (qinq && vlan_type =3D=3D RTE_ETH_VLAN_TYPE_OUTER)
> > >  		adapter->tpid =3D tpid; /* Outer VLAN can be 0x88a8 or 0x8100
> > > */
> > >
> > > +	/* Re-push insertion, and stripping if already enabled, so the new
> > > +	 * outer TPID reaches the PF instead of only being cached here.
> > > +	 */
> > > +	iavf_dev_vlan_insert_set(dev);
> > > +	if (dev_conf->rxmode.offloads &
> > > RTE_ETH_RX_OFFLOAD_QINQ_STRIP)
> > > +		iavf_dev_vlan_offload_set(dev,
> > > RTE_ETH_QINQ_STRIP_MASK);
> >
> > Should we check the return value of this call and fail if an error is r=
eported?
> >
> Probably yes, will do in next revision.

For some reason this patch in the v2 series didn't land in my inbox.
I reviewed it on patchwork and it looks good to me.
Consider this my Ack for that patch:

Acked-by: Ciara Loftus <ciara.loftus@intel.com>

>=20
> /Bruce
