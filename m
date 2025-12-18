Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE87D6E2A8
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Dec 2025 15:38:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C7248402D0;
	Thu, 18 Dec 2025 16:38:49 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id B74A74026A
 for <dev@dpdk.org>; Thu, 18 Dec 2025 16:38:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1766072328; x=1797608328;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=suNyi1JZ7rvlQLXoy7gQb9qOUNJHrezmyBM7TXqbT0A=;
 b=ilE775/NcFqOKQzPltzeorUPKVt+JwhAgy3uG6hxO6dZGZSFOfwpMZPT
 bd+M/sNFY1oF7eljWZx/EN3vttfI+oH/jL2fP73qmtl2xl2VbLIlKd8no
 ZVrH+ziEb5kKyN13OFQECB/WbTTPIP7rAbUqeMsadnrlSt8+6jUtsE3DZ
 GHs4C0FI38e+PCvhIL4feWkJfmzRF18PtMuTMlJk3d9Jj7u8KNif9eCjZ
 cAdUTh9vfHFlnLlitCVB/1Q9Y5hXYjxCEFDaJULSTUOv9MhuGZpbxje0O
 hU+JC8XknZKw5oXcpCb/3P6sPDeXl/Tyqu1XCGUtoLTv2QYproGComVno Q==;
X-CSE-ConnectionGUID: BCOCa/PBSq++A8xMFNEuIw==
X-CSE-MsgGUID: P2vhqkEYQFW1ZiVF5y0iAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11646"; a="68068855"
X-IronPort-AV: E=Sophos;i="6.21,158,1763452800"; d="scan'208";a="68068855"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Dec 2025 07:38:46 -0800
X-CSE-ConnectionGUID: jqaZY5K2TGSoUVH+/I0chQ==
X-CSE-MsgGUID: JahYvsSqRyOtp/sqFSwoRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,158,1763452800"; d="scan'208";a="203512727"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Dec 2025 07:38:47 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 18 Dec 2025 07:38:46 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 18 Dec 2025 07:38:46 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.16) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 18 Dec 2025 07:38:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s7Eil2o1AW+4NmapZ+LSjavifjs5AmIPodbqXvELWV5r00VT3NRG/StfljnJkZQyexNwfR0a7YtNK0pDN50vtAQHM+aEv+GDfwxPbBNpQOIitWJWR7DC6wfT4VMkWa5SvplzCj14mjr/kPz6IPSNhIns/RmSXY5HE37FPaXMt8EcopQbENigOqTzB5+2URLiSYkCYm+6DeXjbXmIeL7pnToHDpu2U4aJ4w2FmXl4RGvLHAWhMU1U8DgpSR/dTw78lU0xOlp1l6eXl5B114f15DXs427mdCgco75LnKwT5OwDOJRmUnxYsY1wOvgrubO7rtphU/aekoUluv55RWqJfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5YqPLKL5Reuu3kVp8B1YxT8lw76vDMvkAfXODd7FVYg=;
 b=BcJkF7aOTeYP9/Or4ek8sHBTqaG5VHKnJg+QdQDkpz11meobNRcGsyeV1nUVg6Eb+PScjkM9jjPTuTFPFWX8mWWRleb+NAOl0SGf9UNjzcZu5gUygSD1OoaunxvMiePY8oVNP5L15nuyUvAwx0A3zllo3dtCFbCsT45NbLsbz7QVKeuYWnWdhXWNuEA95kBSa81QdLZ0SCmtJh8h3URS4oQNY8Cbl5FOLkGGjDq2s8rPBz+Ja5C8kOwytW+HBIDEVvw6qzL/vMuwGBqZ6vwBx08LAkoLPrmo4Sea1RdnL4nTsRxIcJs7WfLsqGjsytO69ppMF13LstnA65uqspqHsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ5PPF6E320AF71.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::833) by DS7PR11MB7886.namprd11.prod.outlook.com
 (2603:10b6:8:d8::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Thu, 18 Dec
 2025 15:38:43 +0000
Received: from SJ5PPF6E320AF71.namprd11.prod.outlook.com
 ([fe80::3fc5:ddc5:5858:5507]) by SJ5PPF6E320AF71.namprd11.prod.outlook.com
 ([fe80::3fc5:ddc5:5858:5507%5]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 15:38:43 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH 1/1] net/i40e: unset vector flag when scalar path is chosen
Thread-Topic: [PATCH 1/1] net/i40e: unset vector flag when scalar path is
 chosen
Thread-Index: AQHcb2aGKQzr1nEYn0qvq2GNIKOIxrUl70GAgAACmuCAAARBgIABk4rA
Date: Thu, 18 Dec 2025 15:38:43 +0000
Message-ID: <SJ5PPF6E320AF71A861448AF6624A93EC5C8EA8A@SJ5PPF6E320AF71.namprd11.prod.outlook.com>
References: <20251217145436.3217068-1-ciara.loftus@intel.com>
 <20251217145436.3217068-2-ciara.loftus@intel.com>
 <aULHeab_ajR0ikgu@bricha3-mobl1.ger.corp.intel.com>
 <DM3PPF7D18F34A12F8DA79F7B83D9E2C3E18EABA@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
 <aULNOcN6-wCBIFNY@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aULNOcN6-wCBIFNY@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ5PPF6E320AF71:EE_|DS7PR11MB7886:EE_
x-ms-office365-filtering-correlation-id: 73610002-9655-4461-739c-08de3e4b869c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?yKm9MR2nBLp0zf5V/DwIh/UvqnQ7cN64AP1MyfMg6wK/I+0cQPqa+mHr1HVc?=
 =?us-ascii?Q?6Bp3gziBN+CapD4780OViistYQ5ox9tCO9gOFqheSIGCt69Kouf/ut0qIOV1?=
 =?us-ascii?Q?yJf77n80GGDQ9P1N9kN9NExOk7GkRqU28ePrly22fnykeBWj+Dm2thLw0Rfm?=
 =?us-ascii?Q?dvHwB1N8+raDelBPwi1zSQy/YJR18MIChCIB4qZWQDccx3HQUZuVZxuJ0kAa?=
 =?us-ascii?Q?ehhgfAiVt/L3Wy8c1st+TwzUI1yzWn+jD4VnkyBC5HAN4pln0eGiQitUdqcN?=
 =?us-ascii?Q?9GFydh5lwYXDfgqHFnXv6nSgqNpn3/5Ilu2CdB/FC1na3y4IhEAThdos7EcH?=
 =?us-ascii?Q?qhlfVKpoZLPta+JHpcNDkNb057IlYGBtf/Ibhfy6idwAE99N35VTrs7SdapY?=
 =?us-ascii?Q?cIzc5CEJYyoyTFOhPPNAQ4PLMLdWqFKE390CR/drzXZ8M9bqLHM8lCCkieJ7?=
 =?us-ascii?Q?MhA4kfYLlJGGTI4tQRlZZDmQPzxhl5DLsBEgfEw98OcsViM+rwsxRhziRS5h?=
 =?us-ascii?Q?7os0oyne1VW8CmgnoutD+MVoVN8rmSdQoUYk0yVfP8o6BtctUc3Dyq5m2DY5?=
 =?us-ascii?Q?C9QMvAhTVIIfXle+Uen94fc2O9Ct3+NGWzC2aVBPtQeabZy10n+ysyutpXgg?=
 =?us-ascii?Q?KTiYrcxzYpefKyOOKH84s0jm+hIz/rISPCZBjkkiktmOM19Wc8C36FN5R4+L?=
 =?us-ascii?Q?y5QpUFXDOcvBs2bMbPRf5YFCdCf1HVBtd5pV7QaEerpG7bGi34FeDBKxa4T7?=
 =?us-ascii?Q?7yonHqGdFt1z3RTpEA7av+Oo8dzPb6r3LN53No6f9AXDg3sDR9zGn9ZIJFiS?=
 =?us-ascii?Q?Y7A5xtJx564HxEND69EAo0qTrSdBGgYv6OPcGKQ21JCg3gADPBi+0TiEBYOV?=
 =?us-ascii?Q?pvYMh4quAX5/SQyAoGMALMmkxv5bvbMxpEdU51QXQVgGHvVCesWShXunQKOZ?=
 =?us-ascii?Q?X+KyhgIV27DSWE3gcXDBTF5FMe4NLl4qVxDYQSVvadEiQGuLXe2vffXYW486?=
 =?us-ascii?Q?OuCBijtNKhmOeLnlSyWLcjqwmRnlKgehzG+571T2ADt2158W4uqrXmtE0owT?=
 =?us-ascii?Q?yJ84zNMpztj96J8BqEaAfkHRaU9D5EtNwmXP+6m8ZE//lpcztrTL8UWkmnnY?=
 =?us-ascii?Q?mx8WeAiwu2EI9YYFiktgTG6V+sECkpFY2Ydw6BhAS8JJ/tUnpvl02GT81F56?=
 =?us-ascii?Q?jGq/pdnpNe/1OsGE5IXfmhkxN0KC4Ms2aJa7Q04doLIrTMurgJIEVBk7fnHM?=
 =?us-ascii?Q?cypM29nrDF3a0mfHWiflO7j6hiR7IrTN1wAtdvIaNHWd3lzTGI9g822pHDMI?=
 =?us-ascii?Q?8OcTD4QXbZeyxS4jZFwnks1lw6tm7zKEw7EerxJAk/pjXOmTiRfkEYgEkQiz?=
 =?us-ascii?Q?SKiKbVy0AL6S76xmiCumcRrsxqenIEtn2XhgVvxaCfvNmxomMbvJqELewiXm?=
 =?us-ascii?Q?9/dtTRnJasLLiRbo72q8j8+Fh8D/cEZ4yeICz0MFd6sHoqN2Z+wUppnMFJbb?=
 =?us-ascii?Q?9C0njpr9dLe5Pi2uHKRAA9FuGq6hGCQIp22P?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ5PPF6E320AF71.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oNdrlubCj0Hz55RVZps0rR/NM+tvtUkNCPmAIJqHblpgZiwyLQnXS2ObzRtc?=
 =?us-ascii?Q?WhXuSc1Ciwga6jPH4Ffy0e9FUOVl3XvxXAhEs//m3jgcUuS8KgCsEy0twNjs?=
 =?us-ascii?Q?0jjd8rrGHVzYx76ikoAIYHzjIyGa0odY4Sleo+zQVy0AxFm2OtvlOwDHY0At?=
 =?us-ascii?Q?DYuTNhXYLrdFWQWraIdQWZdI459s7TEJa2wR6J83nGtpy4YKjT8xgwcjlBH9?=
 =?us-ascii?Q?rANJYi/djg87EYshwg/48lsW2BA/xMcjP0y0XcDvm3AUwyM+4ZkKExI4sif/?=
 =?us-ascii?Q?Pl4nvOyteCNbrmqOWQHLBykX0StJSiry/+auFYgeX+FmEWiBPsuiXVa+P8yW?=
 =?us-ascii?Q?6jhc2zYG9zPzi6G/gnKBrKDVYIRZ0VVHCeUDFmOEUaTJ1exh7eFfu4y3XbBr?=
 =?us-ascii?Q?awPe9GxmcCVHnhEXVn5fVTEKOaG/PO1PrM4DoZNGcvYaUGa+rtd54Vp/j4wr?=
 =?us-ascii?Q?UneKFvsOTDmDFTMvlDhPpQzZPOZhe2SKh7ge71SMFWG9NGWEkTFheVX+hh6h?=
 =?us-ascii?Q?rsftY1VTKAjoUd+V5Y0KFH3KE1RbcIZBMCpGYfmHoRvwHweN1ur05+m6+QMx?=
 =?us-ascii?Q?8PTA54pr4ReT2hK2xg2t3bqlOHIw+M8pmfSZRu7cp4X6sdXw/Qepk+PyywjU?=
 =?us-ascii?Q?/gu7dH8hbsfMa7dCtHO2aufzxLYfNgf3e4Iivr6uK23/BI5A8wOgimbm1kOh?=
 =?us-ascii?Q?30Mpg71jLYv2Ebz4RHlR+LVsed3Hngua8yOa4hrJUiKDvapET+eAx6jHWd+O?=
 =?us-ascii?Q?kPirryF12hBLrpNQpB6nqhclgsAcAmzXT27j5A8LzR9pSVHhd2bQPdtVGZTg?=
 =?us-ascii?Q?fIvzjda6Yshkr236dPygYu59xGcqnpAYb8E3Ue2Ssibo/wxTrlH2g1JL1hT0?=
 =?us-ascii?Q?SVkfgZ7tcFN72MSSrUH+34iMUUm68Iv2FnE2m8dk0TUktdkgzJlY2kuw5HdJ?=
 =?us-ascii?Q?FXZmaQdHp8UBbbNWbSsUkkuGO9yqYCzwxyDLE81VPRp032ecX6mys2LYl4hF?=
 =?us-ascii?Q?Fz4xWUOUnK5wgh2flBskWxXvTq5Uad4pywRDLw6km+0C9zHjCxszSM/9Pmw0?=
 =?us-ascii?Q?ZzGUxtdl6+a3hDyfwamJpEm4CzYsfLO3sZFynEWQC+eoBi5NH27d3IpJXEwz?=
 =?us-ascii?Q?lBMA6NJc/TNuOr9+gWZrfsm/cNIFwCZkD1Mqcs8gCyFFAgpHun06O4Y/oslW?=
 =?us-ascii?Q?E2ydgBXWIdbrNhmWv0B+dmlVYG2FJi+eM2MRgVFNzyVptmqgDRtVezWIOAzt?=
 =?us-ascii?Q?XwO8iEvc6fv8bbdKN+wfMdedS6pCkJitTYsvr29xEjiaZ2kWi6V17fqM+vP4?=
 =?us-ascii?Q?Vfp2GeeLhDoX7mh3RxOwUFDLPYj2QKLwkeaCXSbwgyPHCCGIkHHkKk0YHM6s?=
 =?us-ascii?Q?AGuZ6lb46fel5vBgGbWeTNOCQcRJVU3rer6dvL7CNnyRufzkkaWc9sDZPPP9?=
 =?us-ascii?Q?x0DYKulfPR/vKGiWRyYwYqqLFb7ulACcJdedV/EIa97xUGJgNOGqprlS1NQK?=
 =?us-ascii?Q?8LTmYE6pbDhRfB14ADy/3geJbcAkZfzULMMcQcBeC9xCTsGSsp4+FfciTyPR?=
 =?us-ascii?Q?dqn3v/MsvnOjDnKa07SpT/mGBSQ0/vVRiR8cPIr8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPF6E320AF71.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73610002-9655-4461-739c-08de3e4b869c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2025 15:38:43.4947 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TCCpUErBBnBXpBDQ6yHgs45l7UrNHQZmOt0YMd/EhLkTgRcw7tQV3tCbyymT066AlelLQamNeQ/KjKTY4nA6Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7886
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

>=20
> On Wed, Dec 17, 2025 at 03:18:42PM +0000, Loftus, Ciara wrote:
> > > Subject: Re: [PATCH 1/1] net/i40e: unset vector flag when scalar path=
 is
> > > chosen
> > >
> > > On Wed, Dec 17, 2025 at 02:54:36PM +0000, Ciara Loftus wrote:
> > > > The tx_vec_allowed flag should be set to false if a scalar Tx path =
is
> > > > chosen.
> > > >
> > > > Fixes: 1ff08bb7ad90 ("net/i40e: use common Tx path selection
> > > infrastructure")
> > > >
> > > > Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> > > > ---
> > > >  drivers/net/intel/i40e/i40e_rxtx.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/drivers/net/intel/i40e/i40e_rxtx.c
> > > b/drivers/net/intel/i40e/i40e_rxtx.c
> > > > index 2db58c6b24..dd859bda4e 100644
> > > > --- a/drivers/net/intel/i40e/i40e_rxtx.c
> > > > +++ b/drivers/net/intel/i40e/i40e_rxtx.c
> > > > @@ -3631,6 +3631,9 @@ i40e_set_tx_function(struct rte_eth_dev
> *dev)
> > > >  			ad->tx_func_type =3D=3D I40E_TX_ALTIVEC ||
> > > >  			ad->tx_func_type =3D=3D I40E_TX_AVX2)
> > > >  		dev->recycle_tx_mbufs_reuse =3D
> > > i40e_recycle_tx_mbufs_reuse_vec;
> > > > +
> > > > +	if (i40e_tx_path_infos[ad->tx_func_type].features.simd_width <
> > > RTE_VECT_SIMD_128)
> > > > +		ad->tx_vec_allowed =3D false;
> > > >  }
> > > >
> > > Under what circumstances would this be a problem, or under what
> > > circumstances would we have this situaion?
> >
> > The circumstances we would have this situation is when the driver
> > determines that tx vectorisation is allowed but we end up selecting
> > a scalar path. The result would be "vector_tx" being set for the txq
> > during tx_queue_start and later during tx_queue_stop, the wrong
> > path being taken in ci_txq_release_all_mbufs
> >
> Would this be better fixed by some refactoring to chose the release
> function based on ad->tx_func_type, rather than having a separate vector
> flag?
>=20
> If not, may I suggest that you remove the if condition, and just do:
> 	ad->tx_vec_allowed =3D
> 		(i40e_tx_path_infos[ad->tx_func_type].features.simd_width <
> RTE_VECT_SIMD_128);


The release function is in the common code so it must use the
txq->vector_tx flag.
I think we need to also keep the adapter->tx_vec_allowed flag as it's
used elsewhere in the driver beyond setting the appropriate value to
txq->vector_tx. eg. in the i40e_dev_tx_queue_setup_runtime function.

I think there might scope for some further refactoring here but it would
end up touching a number of places in the code. In the interest of time
and simplicity I propose implementing the fix you suggested above
for now and maybe revisiting further refactoring later.
