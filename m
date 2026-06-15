Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9651CD98C5
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Jun 2026 09:17:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EAFC2436E3;
	Mon, 15 Jun 2026 11:17:52 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id D71F7436DF;
 Mon, 15 Jun 2026 11:17:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781515071; x=1813051071;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=1RoU5MQqWg4dc+QqNzU8Tlsv0XfPgy6gA1b0iXZgf+g=;
 b=bkBpZBiyORx1rXcjQLyL1M0kfqmku6+MJF4GpJZPUkuw9ifbDgIGCDNK
 g/TCznXaTuFZu8ZCpRE6tt8IE3tzVzFikhnbNGSYzSfQ+n9tbdmOjjfN2
 /AZGsqRsD+1MpSKPITe0wftr3BSC35DcvEecLUhzT3tMYJlPASX4RN74G
 jIZ/G/GzJS6TvDvGUW0ASr/9rwEgmRu8r/Hx0fakqnpXKDQEvRtf28olT
 0C3mvL1zM/pTpsUItpaqTF7q838i3IXxdO+KjYnLx5mJAr7UYsWUSMUNU
 I1kyZnWArk4o0LBRJIrFRDA9wI6p4U8ZH+cUz2YHdOX/Jg+GirdpvJP5D g==;
X-CSE-ConnectionGUID: rLwHpT/FTTKf3Qh/VFXEhw==
X-CSE-MsgGUID: F4unk+vqTnaicWltTTshUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11817"; a="86148972"
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; d="scan'208";a="86148972"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2026 02:17:50 -0700
X-CSE-ConnectionGUID: iwC26efSTTKqigxIaHBb3A==
X-CSE-MsgGUID: CyodFvObRm2I8NSAbZEFbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; d="scan'208";a="245022146"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2026 02:17:49 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 15 Jun 2026 02:17:49 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 15 Jun 2026 02:17:49 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.40) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 15 Jun 2026 02:17:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FRvJ4xkkY2WPSfIksZmdxbv0juCmJUUBNJ/KhsnmxBJfgdfimKi5PQ6Aqxh7tsly3WRIpCSCumbwW0GjfMQZT++wQoxvEznh+2f8OPvyxqEp/sS8gJ2zZZDjisXUCMKk1UyXiPnrqBn0P/96va2E13qW6MD0+szV5C9SCJNMebVajQvhyw9+3jWxWRBNwQ/O0wIKK2/x53WOwEPiDr1/jyF4gX2UmCPrtoyvACRtkqwhd5syXJYTyWhiX385QGoSENd5d7M0R6Cap1u113pyN28m2Y26Lw+SLPHUryzZ7UiJFU0gxZuPSxB47wxrICI3LYFJcjqYph1Km2QuY+l+XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UFoC3Tz0eAUz+IlaGacjbPD6PzChbTlEPhmBQGLoWcY=;
 b=bQ+m6XpFLkLmSV5WCIfNLa6kN2wTtT1H8+jgaN3HqSer36qFrDDZgl1azElX4vi/YTcwtTHS9O0IRsfx5nUuPM6/6pXJNHS7xA4wYQy/QLeY0qaCwmF5UhrzjpXS8J2Y6XAOZQQfqSVoDm3PJu+MxP5dWh4WxjCWobnLhjf1SXz8QfIzfwX4CDPuD3x8o3xOI8gZBBJCHVPa5ey772OfU3MTT6bm18McxJXZiLqJ371Mk4bFjCQ71guDgbHiD7so+AItBPAWnpghPDkRraWU7dtD0/WzlywCpYqY5FOl2s1E79c8aPaHyGl6oZfAIIyY5LpDlPpmcxxM7eJCVFB7CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA4PR11MB9278.namprd11.prod.outlook.com (2603:10b6:208:563::12)
 by PH8PR11MB8062.namprd11.prod.outlook.com (2603:10b6:510:251::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Mon, 15 Jun
 2026 09:17:41 +0000
Received: from IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057]) by IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057%6]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 09:17:41 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>,
 "Doherty, Declan" <declan.doherty@intel.com>
Subject: RE: [PATCH] net/iavf: fix scalar Rx path zero-length segment
Thread-Topic: [PATCH] net/iavf: fix scalar Rx path zero-length segment
Thread-Index: AQHc+njjq8rHU1oXz0yz51BTSAwgfrY7D1OAgARK0pA=
Date: Mon, 15 Jun 2026 09:17:41 +0000
Message-ID: <IA4PR11MB92788A2FA65444A5BDC62C0E8EE62@IA4PR11MB9278.namprd11.prod.outlook.com>
References: <20260612143531.2265914-1-ciara.loftus@intel.com>
 <aiwo_4aTWi8kBIkG@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aiwo_4aTWi8kBIkG@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9278:EE_|PH8PR11MB8062:EE_
x-ms-office365-filtering-correlation-id: a57e3802-8e71-4dbf-a2de-08decabef39e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|1800799024|376014|366016|6133799003|22082099003|4143699003|11063799006|56012099006|18002099003|38070700021;
x-microsoft-antispam-message-info: uglM6SgAvDA2N2ga7iA7jOl9p6J855pA/RvAu3yJt+G23oFF52De/eesTzi6kmx0w1RPBAKrWF78UZtl8lQr2twmNaeHhQcf3b2rhPLDcFpoMxHxcwHf5VGoVLs5KKTKxjMcNBWxQtAKLbHYR2SWChEQ+qE8mhuwehvtC4+MrC+8fbuxXZhjoJFXmxk4bc13heGubRJQbqCKo6TMAJO0zmii1fhqRiTCRwz8ljyYMY6uA7bY3fZFbl+uDFsQbCrxQRXzSSwR4+2Ixj1yX5Ox2uMND7O6UfsKlLlrLoXaXZ4Ks3mTV32I55HW/WaLDT7Tp/Lv3P4vN1Pj/cHhqdev9AN+N45MDxtJIFFSwEB/Ac6hbk8GjwIp4eYjMmPmJKF4lw2lFnQlkPP/+ynZutwwDEJReRm8Sh1+rkiLHcm0daixMo26SOewzR4peF8pct0Kn9dYdAe4tIj3ZSl67P239bTqSgH+/25c+pxmhdJuvuT1wApsEGSsjnK47CmeYqwSVNTOPPS88oihmVYDpKNf0NNY7iuIDOJIHr4Ur1j27yTdnPgi5GzCM5Rgw53RN5I3CmPnWYlhomdErMZiSmegC/GR788+NhEGghPyIz5Tjoh6hOIr7rQMiGo9H8GptWDj1OlbszYUM4YBtPe0ns0auJOlqnhr5qfMXCsuM327tKljOs75C/4Iyfs6ZOHd+jJCQN3U5jYOYPHD//yfly10kIWBkkUeo6TJtV0dCZ7qHizIy0NB75kdavJRzSfOgU4a
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9278.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(1800799024)(376014)(366016)(6133799003)(22082099003)(4143699003)(11063799006)(56012099006)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QExf+qfPyQafEuwZ7MuSHGTCwVlkKf6JDtrycelDdfnWsGHjNB+0hhhW/9D5?=
 =?us-ascii?Q?5iMILPHULvkzwNfazX40D7EkWOdKjYpUxgmtu+PPD2cPnKSgzCjHfASKC1p6?=
 =?us-ascii?Q?VcQFCWxsQbeGU2WmUPF73pQTnr/Qh8e74quqcm7jTiHc2TvfTtpCQEMXW0zn?=
 =?us-ascii?Q?iP0h1DeDZ1xt4mici/clxBV7HOBJcFArRy2TyBj0f/DUTlPRsjCqPO8VksdO?=
 =?us-ascii?Q?6l+YpsgaUIXcrntFX6Pb5Bz+g0+8vboRAAQ6qYMBz5SGX9bT+qOG8hNgp6FD?=
 =?us-ascii?Q?OtVOM0mj0e8h612sNxNYl9PxQ9HSSo25Dw105n+9DmYbeBbYJIxDwG2XEaUo?=
 =?us-ascii?Q?3GWbHpK6bR+78HKCHeXIqNen4H78sf9H9R1aqrYMWRU25nLNy6hduexWD7ek?=
 =?us-ascii?Q?PMsm547VcYxee6joOO6bajKVECoD8YroD6TAd+9PKKd4hugMbdNqDtWGAR8O?=
 =?us-ascii?Q?GCueKDeyFCZ5llsMqTr18DJkPHclwFj0NcKRVFGafmLUyXSBcVNLhbRqwu8w?=
 =?us-ascii?Q?Od4BEKvrdGtBu8L7A/WltFU4XjtWmLcliosuLpl3Ybv3IkFZqYMPalMu/CF3?=
 =?us-ascii?Q?25Uuhu96tovEODnmhmOJ9GJhZpup04EnEcQyRbs4G3HIZ4oTxmJQbhjBX4DX?=
 =?us-ascii?Q?ORXZXL4wsyXt9X1PLvEFgFff/UslBnf9V+9TnO/qCkQ0NyX9p7UE/ne0mBT8?=
 =?us-ascii?Q?t4hsyew2Nv6kP3/ynAk7lUf0uYot/cmBQ5d/9lVuwN4qSv5+bQEUnuzykDyT?=
 =?us-ascii?Q?5W2hHs7eq2XSusqAr4QUhpn/Os3QZqfbAxBOPiWK5M6V5D95cO/lzCmtJQmY?=
 =?us-ascii?Q?cBARDKSQr2rWFdVmWNvrxJg0VOkZoJqP3BJ+rtsMczsoGXyiYctXOjXMo99G?=
 =?us-ascii?Q?8RqEWVyBHUnlNmK9cmnqBcfp0ZqUcvqOtokS81f1FW5x+IXMGW2wqZLzdSS9?=
 =?us-ascii?Q?P5pz6zgAfiHGptLx/9f7sm2Dw4jpWsQv3KmwWs0zvsBxMn9UBDXhAXXSu2Va?=
 =?us-ascii?Q?urTnsCzO85wXirfMtXkWrNAZDH0E55GD3Ee0BTcUAUtWukGK5wp0tO/PyC9S?=
 =?us-ascii?Q?ycAySNDdYK6Fq8uYdNbFh9EfohgD4okW1I/TG+JS0sk8LbbKBx55A39U01jZ?=
 =?us-ascii?Q?ZY6HilPSznEDTzaauiL06Sx9V9q9Kd59iwZ/qv8tCT0EYenb0Xiww/Ic2fU9?=
 =?us-ascii?Q?Ggoccb6KyEoI/VSgLdVUv4i8UOT4WVaNuEOhNPB7GGNz+0PUVM4qlNvZnxxH?=
 =?us-ascii?Q?3/5wT54BWpAMTd6/RYgic+KISOOq6ibHx9cVa1TNAFyGfitRal6mJ/h9SIxH?=
 =?us-ascii?Q?LQocDfmjpQH/WXH3nCl2ofDe9MUMwdKxYbnh+jDpX4AxIZgka4OAPN+1eagQ?=
 =?us-ascii?Q?wI/IAhv9p6xCt8pyDdvpHQbruSlR6BAlDx04IzFkR9RlHwiaOHyX2qvI8iws?=
 =?us-ascii?Q?bVDlJ+JAzwkRvoRbbFSDs96gp5PcgiT108/W8HHP7mpfohYalElQmOafIuL2?=
 =?us-ascii?Q?U/EiLGaA7lQHgGyQ/djtAI50o03SgthwgJwWWRGya1KQtCIFPDvcMP+8gFEN?=
 =?us-ascii?Q?qYawY2YHOmLgPXgodZ1mcdgZ3rFF0dnNIk5xgTuveM8n4g4ZEmD8m/aP55a7?=
 =?us-ascii?Q?94KGxfbQcTRJq/yRjIl26rrFvpadiT29tXoTbeGjpuDbPMzKnrOT7fqznrr+?=
 =?us-ascii?Q?bLg2eytju+oVFRFUCbOgou30mkA/DiNUcC0+kjvMLvGbwZFxVrgQVZRjNutk?=
 =?us-ascii?Q?SS8jvFrDhg+rl6zOlcwRCXKxi34D6K8853KeZ3w1DekKM/eJcSUTwjGdDl2u?=
x-ms-exchange-antispam-messagedata-1: V8Jx3EggIyyvhA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: O28qaMtsrJjUycOl+JyIDU4+oyNJ2IIX0BN0YzzrR6LgQyxgEtV86Ybu2pPyoTGaKG0tIeRLnkQmjFfrgnv6WOkNZ2IzhcTUlUGSPb2ss0C0aaLFR+JyZTsXEkmyt3KIAdpsV5TMPOCcv97ITBi+1xw52H44GeJIs+7uAanHTwfFvgVIMXOGE4HMVsX0xJKbRko7YPdl9jQLYzGmRGlO1z9/vxKBWJ85DuRCj79v4qvlNl0mhdGXiznem0bkulU181KnLqfzS9hqnYOAraVpY66sugXyB6k0UFvJKwtRQzlpCcMjO7A2IcvnLXfbV1a/R/SZeujGbM51IASw3VoinQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a57e3802-8e71-4dbf-a2de-08decabef39e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2026 09:17:41.2774 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vAeBC1Q0HNfuSj4NXMIQDuHWJFnU04ykKXjLj2m+m4+EdAHhMBy4X8NKNcT8shEHMfsSVuSR/ecHLYrenFosmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8062
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

> Subject: Re: [PATCH] net/iavf: fix scalar Rx path zero-length segment
>=20
> On Fri, Jun 12, 2026 at 02:35:31PM +0000, Ciara Loftus wrote:
> > When hardware CRC stripping is active, a frame whose on-wire size is an
> > exact multiple of the Rx buffer size can cause the NIC to fill the fina=
l
> > data descriptor and place the four CRC bytes into a separate trailing
> > descriptor. After hardware stripping, that descriptor carries zero byte=
s
> > of payload.
> >
> > The existing CRC cleanup code only handles a zero-length trailing segme=
nt
> > when software CRC stripping is enabled. When hardware stripping is
> > active, the zero-length mbuf is silently chained to the reassembled
> > packet. Forwarding such a packet causes a zero-length Tx descriptor,
> > triggering a Malicious Driver Detection event on the PF and resetting
> > the VF.
> >
> > Fix by adding logic to detect a zero-length final segment when hardware
> > CRC stripping is active, and freeing it.
> >
> > Fixes: a2b29a7733ef ("net/avf: enable basic Rx Tx")
> > Fixes: b8b4c54ef9b0 ("net/iavf: support flexible Rx descriptor in norma=
l
> path")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Declan Doherty <declan.doherty@intel.com>
> > Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> > ---
> >  drivers/net/intel/iavf/iavf_rxtx.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/drivers/net/intel/iavf/iavf_rxtx.c
> b/drivers/net/intel/iavf/iavf_rxtx.c
> > index a57af7faed..86ebb2618d 100644
> > --- a/drivers/net/intel/iavf/iavf_rxtx.c
> > +++ b/drivers/net/intel/iavf/iavf_rxtx.c
> > @@ -1716,6 +1716,14 @@ iavf_recv_scattered_pkts_flex_rxd(void
> *rx_queue, struct rte_mbuf **rx_pkts,
> >  				rxm->data_len =3D (uint16_t)(rx_packet_len -
> >
> 	RTE_ETHER_CRC_LEN);
> >  			}
> > +		} else if (unlikely(rx_packet_len =3D=3D 0)) {
> > +			/*
> > +			 * NIC split CRC bytes into a trailing segment which is
> > +			 * now empty after hardware CRC stripping. Free it.
> > +			 */
> > +			rte_pktmbuf_free_seg(rxm);
> > +			first_seg->nb_segs--;
> > +			last_seg->next =3D NULL;
> >  		}
> >
>=20
> The vector paths also handle scattered packets (via reassembly). Do they
> need a fix for this? What about the other drivers that work on the PF, su=
ch
> as ice/i40e?

The vector paths use the common ci_rx_reassemble_packets which already
handles the zero-length trailing segment case correctly. When
crc_len =3D=3D 0 and the last segment has data_len =3D=3D 0, the empty segm=
ent
is freed.

The ice scalar path had the same issue but it was patched in 2022:
https://git.dpdk.org/dpdk/commit/?id=3D90ba4442058a14763e57ca96d03ab1e6044e=
3e5c
I cannot reproduce the behaviour on i40e hardware (either PF or VF) so I
don't think it needs to be patched as the HW seems to behave
differently.

>=20
> /Bruce
>=20
> >  		first_seg->port =3D rxq->port_id;
> > @@ -1884,6 +1892,14 @@ iavf_recv_scattered_pkts(void *rx_queue, struct
> rte_mbuf **rx_pkts,
> >  			} else
> >  				rxm->data_len =3D (uint16_t)(rx_packet_len -
> >
> 	RTE_ETHER_CRC_LEN);
> > +		} else if (unlikely(rx_packet_len =3D=3D 0)) {
> > +			/*
> > +			 * NIC split CRC bytes into a trailing segment which is
> > +			 * now empty after hardware CRC stripping. Free it.
> > +			 */
> > +			rte_pktmbuf_free_seg(rxm);
> > +			first_seg->nb_segs--;
> > +			last_seg->next =3D NULL;
> >  		}
> >
> >  		first_seg->port =3D rxq->port_id;
> > --
> > 2.43.0
> >
