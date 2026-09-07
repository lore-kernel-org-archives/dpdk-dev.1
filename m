Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B006EC79F99
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Sep 2026 11:14:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D8154027F;
	Mon,  7 Sep 2026 13:14:45 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 90A7740041;
 Mon,  7 Sep 2026 13:14:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788779684; x=1820315684;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=H+Ia4si9OVhYc1nSocsFQr3XPzFbRDhugwU+4mD7o9s=;
 b=C3oCxOoURPrs/aKMchu32ZiHs78rRmPmVf0H2TxAm3VO67PDftq4avQR
 8qS3W6RNpZs/JDpGPwJNZuVh3tnrSsoIWTCAYgmZvGgRbmQJJxk6XBshQ
 s42JK4wW0kzQAuCeq0USjWyKnpK++7CyGmHv1H2mpYSfzEyzQi6iW8cMq
 W7tkDkJy10KWKQE0DpU5UXggb4z1qlnVjMKRVXB1F/QFZorf5yHqSYhOu
 6arKJ8bnXyNynzCQoOUv5jr+jHyqXGTI1C1ppa/3kJ3i/r2J+Aam5lU/N
 IpzL+w1ppNKq2JmtOwW/HQqVSM9qVFXlwVpi3PNVzQfPNdCs6BxWGk6fp w==;
X-CSE-ConnectionGUID: OL4oHlabQKuVtYFq3JIZkw==
X-CSE-MsgGUID: XuJoHVCuT/CsTJyi/jXeVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11898"; a="89232093"
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; d="scan'208";a="89232093"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 04:14:42 -0700
X-CSE-ConnectionGUID: /XcmONjsT6i+bToTyF8H2A==
X-CSE-MsgGUID: Y4p2dPXWRjSD/TFFmiornw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; d="scan'208";a="275964983"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 04:14:42 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 04:14:41 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 7 Sep 2026 04:14:41 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.33) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 04:14:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ItUww3Tp/i2C4hRJfXlSXMO4uWfe84ODs1WGztOKS1P4tENIOtxwI3Qg1kG41Gf8LP6EeAJihsiV0KiaPivKstmHB5VXjJzigHzuuCM+dfuhT8FHTC8udnhLzNvLqktHNZjg03UAYsoLcXRVPZ6QO+M87fIFJ4AzwQy8vNYsnS5k5EDfSH4RQS+wZxBx445tihRZW59jz4oYWK9jYRAt6Y8llgYPqvu1KA94JQ0RiSZiXBrT6+M3mx3eA++xX06Qaa5OfDVU2E3SisXoze901ED1x7AT6yYuOqknZxaqBdg1arBY+Q7jDIH6orFL+z76yQsmzdHpEd+WO4GXoxyI6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C0c70fcpSbfe/L13qb8CdLDha+LwCbLpq/if28Z1XZM=;
 b=JCUvTUbQOVuvYz1spBPVRy/JWLM/pS6gnxD1LS5gU1z+eEv70XHELrdMwC5sbxBDfD7psZTL931AHSS8+eNsZ3qeSWzEN7dmnte3LNIOuPzb0cHSw7vOI3Y6svO9rIhm4AYPuRaibN2vJKWtzMDaNrUnSDG7MgS/Om54FhupnKe7fRSAITGVt25aLAdoO2TrxSF/PMdjeiyV5eWcNNpmJxq5wkKMYCM+aqH+uHIDHy25vA4qHF4ZAdSKuXymi7j7TyDeFOSeCvL5yUtepOlOP7Npw70vEksJ04IBMzDjjPN+Q2DBhVLd9b2dNxEjhciqinM0SDGhH1I1AqTy9qMQgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA4PR11MB9278.namprd11.prod.outlook.com (2603:10b6:208:563::12)
 by CO1PR11MB4916.namprd11.prod.outlook.com (2603:10b6:303:9c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 11:14:32 +0000
Received: from IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057]) by IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057%6]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 11:14:31 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH 2/3] net/ice: skip TC validation if hierarchy committed
Thread-Topic: [PATCH 2/3] net/ice: skip TC validation if hierarchy committed
Thread-Index: AQHdPFuAA6GENHrjGUmCIfQjcSdFnba+ZSKAgASTc9A=
Date: Mon, 7 Sep 2026 11:14:31 +0000
Message-ID: <IA4PR11MB9278FC2033CADCDC0E162E928EB22@IA4PR11MB9278.namprd11.prod.outlook.com>
References: <20260904105139.3117640-1-ciara.loftus@intel.com>
 <20260904105139.3117640-3-ciara.loftus@intel.com>
 <aprDjRmCFnUNCHNK@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aprDjRmCFnUNCHNK@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9278:EE_|CO1PR11MB4916:EE_
x-ms-office365-filtering-correlation-id: bec055ab-403a-4118-45e5-08df0cd13080
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|38070700021|6133799003|10067099003|11063799006|4143699003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: 8Es8N16x0MTbdPnBHoC2a3lr9eHY8HyFw9tQe+DiDSDeQjJbUf+Qq8b94uIuyU9TUdPYCVf8C2Arn6w9YPnW9mZ0zJIe6MjHOkwAK6fSqDtie1LzAXahDoBswdTvStM53H6EH+nlJeR8GMXhAl2XkcVcCXl2VpB7rG+vToNB8eNmwEKsXS7E1CyxryhvgmUpRj4t4HIvsceCH5NLPlFh7TOQ/M/z71G0MeNZc4srxI5SK1F9vQU/Oo/CPBZ5UhtVXqhVgnH+LKIUz3URucrpIaqr3Yj6XRm1gl4sKZrLhfRbpwdrHTl73rFwM/zGWDq5Zsex3z1uWTK016j08Qxl/uPJV0C87h+flJGXn1h1ryWDou+QARgTL4nPoLuFQyxpBkJK2u4oaAJEOqHuxMX43/L1YEjOI1AhcgRiJQmXkA1cHC7kUQ/8kIf5hak1SheP9mLKSAcdRQaiK2y8c4Odv3M9/bfcRNUeJx6jHxpVYG4E856wsDVog6WS0nlsqdfuZt6NvkUehxegrKVjacvyavp4ne8GL5yXrFKmDu1n5pi0VF8GmrfhDOrZuIugvJP1JRI5ONKY3RbQ7EnA5Oh8GGIYRCaQCpLWMGFVcGCqptwFKdrYWa23rZmjwLyjeOr4JEv6wx+B5Hglkl0jqur5tHwsCEj1e9/b6TUg1I/MPeCAjubshHiQ7GLo9RYqvAx2SUgiCuwS0q3ddK83p8hgNswMZ924xrdwNZVWSqd+o8k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9278.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(38070700021)(6133799003)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZO9P3NhrlcEyF2lYKIm+Aeqt92IWCfTKFPzI2B2WzK/uwk93yVrT1Ad+c3DL?=
 =?us-ascii?Q?zj9NlCMY99MggVRaL/6BDaZfXI5+Zzk4I4fSNlbmw3uOI3Ey63/KgGl9VVhY?=
 =?us-ascii?Q?B3LXhwCDcu1UoRBbHV3Nmk1VUizLOKIdP+hySEjzeaLD0ELwhG5yDOM+aLO3?=
 =?us-ascii?Q?q0PKuyOWXmaUcP9iEe5xSyspIK493x2f3eBbLtWmhaoFKss0GgXKUQrbvmn6?=
 =?us-ascii?Q?OcauikdPxtnx2s6Oww45dpNakeB2YunV51dZR1GO4bmfEBlv9wR28sXcQAiI?=
 =?us-ascii?Q?KnFbR9lc/4hTEqiDX8GvTwFAKtJtEo8pAK9Vgix8dL9Q66fokTNlL7LAh2JO?=
 =?us-ascii?Q?TNbTFD8R6P/Ry21l8v2cl8gnbRxz8VLFvErqwRyvO6xvQzy0jlMq3qEiCNTS?=
 =?us-ascii?Q?wKMk8rlulKCLneAeVGXAEpiTX4u6XjLFZ5oRp2VHx6GfwX+rfucsEcrvB7dX?=
 =?us-ascii?Q?ujAhyjpQFNrpREA3unGj3RpfB7lQyror5xoni8Xl2fp4sOHrdJhKumKuWYmB?=
 =?us-ascii?Q?i2zJO8eBQcMrgLuhFb60dHTkgR22J6EJWx7B8xUgjK2g9LbyxcnAYgQF9J8R?=
 =?us-ascii?Q?sy2K42O5yIXqQVrXWzMpjZgVzwOqqSW/9/1qBPiNN3Opk/nEo14l70TaObUB?=
 =?us-ascii?Q?36GCmL57n99yJpBvaR0i886lfib+iVkLfo/focSEDLmTVjYsDmfvlbybFKov?=
 =?us-ascii?Q?kiYaJCxK16bbmb1+JNWlTdmIv6MQHrbxBtbUEldw7q63C1MYWD3JIi/dxuMe?=
 =?us-ascii?Q?/iFVTLF1EpiemH13LUAYMw0jMbRHvPX+aulKauZijFf0FfEDZ6ZUSBD861Lk?=
 =?us-ascii?Q?/AgsoDHdxWNWxegJmZa7k36qf2mT4dA14Cl7ZWp6Y5ATFfRfwlBBIMcxFzRM?=
 =?us-ascii?Q?VDYi3tUV3cn2yeF7aU1N+DDSq3oaAt92sUs8Hc+8exGIWv7YPiJtB4CUUmP2?=
 =?us-ascii?Q?niIb9jtphu+alHm8te7v9d4rBwp00+9JxYbIW/h4DPsZA5zfewcYXhNDSJ3m?=
 =?us-ascii?Q?jA3hUr2HQXErjSJ2SdEyWIWHCkSNdx7XKaPJROgIzawW+vKUnjEFZ9SI/VUH?=
 =?us-ascii?Q?UBQb859hUy0vlCHbmyevvTgFqJK0jLmW/eSgDXTb4A3EtOydLrKV3PRpDzWm?=
 =?us-ascii?Q?jb/wz1R0fIUo2Ej61yWyI/FKQXmKMlpvSxEBuenjgSSiMVEKZZ8gxtQaieLL?=
 =?us-ascii?Q?hbjK/waheNqR6vX/F33rCESPvTHb9BD06UTQJ2F8oeTEUkVr5K7fXXGPm0co?=
 =?us-ascii?Q?oyFuh8ZZpQ8yZsrILiKkkbqrrciS0kaaF0iIm2rUdho3qSyEfbwkNjqRlPai?=
 =?us-ascii?Q?ZQj6PES8tixlj4bxkwWPpUKl1WsrFmLLEYbG8K6hIuqhNsFIziJTOas44vmT?=
 =?us-ascii?Q?3M4NNH7zRTSMHLFrkWaKxcKYtSt7IUVQoq0k/g3IL+FRyEX81ICGLCO+8gYn?=
 =?us-ascii?Q?fp44aROl4LJEFZDT4rYpiZNyN+dtIG8/JUxt9DwbfpPotaw8ExZeyMA3gGYM?=
 =?us-ascii?Q?Mn+EQHPpJgPxs5rYVNZ1qjBseY5JhSNSaowNzpZev8UmkJsdAZUuHAaDHU9o?=
 =?us-ascii?Q?FO96o4kqZHm6RfPiHsNJSGTRjlxzpvIVM9LfarfXcwdTeV9Mi84NWWbo4s4y?=
 =?us-ascii?Q?P5Q5iwFMnq9cydLZFXrabVCcKkTdA6/4OTadpB+54vZDww9PMUy3W+djHfIs?=
 =?us-ascii?Q?2/Rkov3jzRNW3y4MnNAlHSwdm9jQ7cgUYXEBCdA3JfZQtijwHBz2w/rarl0Q?=
 =?us-ascii?Q?sbvZoS5Z7A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: w1G3tplDRCbm5mC+zqiankm9LNbiJOZ9gxvCl2/HgoSEitQnx8mZEVQcUJkpLP43ZrKiq5IKDb4qXo3qYGYKN/37DvPKAbAcHl/i69HfHd6kJ0DUPoMIb9uCONWIt63UnAg0XPpE50+Rpsq54Zb/LRtymYP0PTnXhlfOUT3TdN6P+yNatV85fEudhTl7nF0ahT8io3XQcEbdxSr60cNZ3mYY2XjyUzXZvag5xrDIP9YMJwFFSBwo2GWyByJM1Ly04rtChMMKvG5jyCBZoq15LCQNelaJUM4mDK6Ffke5Hfd/whbOtKbvI9K/H06FgQV0rXw2ZpNWJGOGj8eUZawdMg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bec055ab-403a-4118-45e5-08df0cd13080
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2026 11:14:31.0906 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pkGGeoHRa9C9DXQ/dxgyRBipKzzWYmzAdtZI5mYyNrL8sZUXiMSZAXKWTLLhthun0O8oqfBCjQV+7AlGyDEZSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4916
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

> On Fri, Sep 04, 2026 at 10:51:38AM +0000, Ciara Loftus wrote:
> > Currently, ice_tx_queue_start() determines a queue's congestion domain =
by
> > scanning vsi->info.tc_mapping[] for a matching traffic class range,
> > rejecting the queue if no match is found.
> >
> > The Tx scheduler hierarchies only ever operate on a single traffic clas=
s,
> > TC0, so every queue managed by a committed TM hierarchy always belongs
> > to domain 0. The tc_mapping[] lookup doesn't account for this, and queu=
es
> > added after a TM hierarchy is committed can be incorrectly rejected.
> >
> > Fix this by skipping the lookup if a hierarchy has been committed as th=
e
> > domain is already known to be 0 in that case. Since TM does not support
> > DCB's multi-TC queue layout, also reject queue start explicitly if DCB
> > has configured more than one TC while a TM hierarchy is committed.
> >
> > Fixes: 02b71e570294 ("net/ice: support DCB")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> > ---
> >  drivers/net/intel/ice/ice_ethdev.c |  4 ++++
> >  drivers/net/intel/ice/ice_ethdev.h |  2 ++
> >  drivers/net/intel/ice/ice_rxtx.c   | 33 ++++++++++++++++++------------
> >  3 files changed, 26 insertions(+), 13 deletions(-)
> >
>=20
> Did you hit this in testing, or was it just via code review or AI review?
> Fix looks good anyway.

Yes I hit this in testing. If you create a Tx scheduler hierarchy that
increases the number of usable Tx queues beyond what was available at dev
probe, and then try to start one of the queues beyond the original limit,
the error path is hit in ice_tx_queue_start(), since only the original
queues are covered by tc_mapping[]. That array is sized once at VSI
creation and never grows to reflect the queues TM makes available
afterward.

>=20
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
>=20
>=20
> > diff --git a/drivers/net/intel/ice/ice_ethdev.c
> b/drivers/net/intel/ice/ice_ethdev.c
> > index 76b8ff0a72e..fd148848d3c 100644
> > --- a/drivers/net/intel/ice/ice_ethdev.c
> > +++ b/drivers/net/intel/ice/ice_ethdev.c
> > @@ -3963,6 +3963,8 @@ ice_dev_configure(struct rte_eth_dev *dev)
> >  	ad->rx_func_type =3D ICE_RX_DEFAULT;
> >  	ad->tx_func_type =3D ICE_TX_DEFAULT;
> >
> > +	pf->dcb_num_tcs =3D 1;
> > +
> >  	if (dev->data->dev_conf.rxmode.mq_mode &
> RTE_ETH_MQ_RX_RSS_FLAG)
> >  		dev->data->dev_conf.rxmode.offloads |=3D
> RTE_ETH_RX_OFFLOAD_RSS_HASH;
> >
> > @@ -3992,6 +3994,8 @@ ice_dev_configure(struct rte_eth_dev *dev)
> >  		if (nb_tc_used < 0)
> >  			return -EINVAL;
> >
> > +		pf->dcb_num_tcs =3D nb_tc_used;
> > +
> >  		ctxt.info =3D vsi->info;
> >  		if (rte_le_to_cpu_16(ctxt.info.mapping_flags) =3D=3D
> ICE_AQ_VSI_Q_MAP_NONCONTIG) {
> >  			PMD_DRV_LOG(ERR, "VSI configured with non
> contiguous queues, DCB is not supported");
> > diff --git a/drivers/net/intel/ice/ice_ethdev.h
> b/drivers/net/intel/ice/ice_ethdev.h
> > index 7ee3ea8a709..5914454c7c2 100644
> > --- a/drivers/net/intel/ice/ice_ethdev.h
> > +++ b/drivers/net/intel/ice/ice_ethdev.h
> > @@ -609,6 +609,8 @@ struct ice_pf {
> >  	uint64_t rss_hf;
> >  	struct ice_tm_conf tm_conf;
> >  	uint16_t outer_ethertype;
> > +	/* Number of TCs requested, 1 if DCB not configured */
> > +	uint8_t dcb_num_tcs;
> >  	/* lock prevent race condition between lsc interrupt handler
> >  	 * and link status update during dev_start.
> >  	 */
> > diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/i=
ce_rxtx.c
> > index c4b5454c530..71f9155e588 100644
> > --- a/drivers/net/intel/ice/ice_rxtx.c
> > +++ b/drivers/net/intel/ice/ice_rxtx.c
> > @@ -839,20 +839,27 @@ ice_tx_queue_start(struct rte_eth_dev *dev,
> uint16_t tx_queue_id)
> >  	tx_ctx.legacy_int =3D 1; /* Legacy or Advanced Host Interface */
> >  	tx_ctx.tsyn_ena =3D 1;
> >
> > -	/* Mirror RXQ<->CGD association to TXQ<->CGD */
> > -	for (int i =3D 0; i < ICE_MAX_TRAFFIC_CLASS; i++) {
> > -		q_base =3D rte_le_to_cpu_16(vsi->info.tc_mapping[i]) &
> ICE_AQ_VSI_TC_Q_OFFSET_M;
> > -		q_range =3D 1 << ((rte_le_to_cpu_16(vsi->info.tc_mapping[i]) &
> > -			ICE_AQ_VSI_TC_Q_NUM_M) >>
> ICE_AQ_VSI_TC_Q_NUM_S);
> > -
> > -		if (q_base <=3D tx_queue_id && tx_queue_id < q_base +
> q_range)
> > -			break;
> > -
> > -		cgd_idx++;
> > -	}
> > +	if (!pf->tm_conf.committed) {
> > +		/* Mirror RXQ<->CGD association to TXQ<->CGD */
> > +		for (int i =3D 0; i < ICE_MAX_TRAFFIC_CLASS; i++) {
> > +			q_base =3D rte_le_to_cpu_16(vsi->info.tc_mapping[i]) &
> > +
> 	ICE_AQ_VSI_TC_Q_OFFSET_M;
> > +			q_range =3D 1 << ((rte_le_to_cpu_16(vsi-
> >info.tc_mapping[i]) &
> > +				ICE_AQ_VSI_TC_Q_NUM_M) >>
> ICE_AQ_VSI_TC_Q_NUM_S);
> > +
> > +			if (q_base <=3D tx_queue_id && tx_queue_id < q_base +
> q_range)
> > +				break;
> >
> > -	if (cgd_idx >=3D ICE_MAX_TRAFFIC_CLASS) {
> > -		PMD_DRV_LOG(ERR, "Bad queue mapping configuration");
> > +			cgd_idx++;
> > +		}
> > +		if (cgd_idx >=3D ICE_MAX_TRAFFIC_CLASS) {
> > +			PMD_DRV_LOG(ERR, "Bad queue mapping
> configuration");
> > +			rte_free(txq_elem);
> > +			return -EINVAL;
> > +		}
> > +	} else if (pf->dcb_num_tcs > 1) {
> > +		/* TM only manages the TC0 scheduler subtree. */
> > +		PMD_DRV_LOG(ERR, "TM hierarchy is not supported together
> with multi-TC DCB");
> >  		rte_free(txq_elem);
> >  		return -EINVAL;
> >  	}
> > --
> > 2.43.0
> >
