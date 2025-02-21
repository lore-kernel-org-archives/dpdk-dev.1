Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C29C021B5
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Feb 2025 13:03:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7F4BE402CC;
	Fri, 21 Feb 2025 14:03:05 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 81300402BB
 for <dev@dpdk.org>; Fri, 21 Feb 2025 14:03:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740142984; x=1771678984;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=+IlJ8SzfR/tDz3l+S0tKa+u4ugixGur8N44f6jfScK4=;
 b=nbByeOma+iNL3aohzzpSApsaUqh0IEnZhbC2Ago/W+EcloOHswavyIxH
 q0w8RASGDJYi5AnxeBojd5VPfLVv44Nb5cm5REK4H+tmD24xokBs2HYVB
 ge00md4zaShNvwijT0qcBgDsrFuD+heaYlAc3O8xTPj9CdJezBOK0wa0u
 Cvz/WWIw3nK3GIbjxssEL/WdJ9Bi4XMM1hQLn8t5H3xRi6coq0R7fgb3/
 u3FQCKBFajjI5i+IrwQ32HsKKXMAaOD/G3HWSLfU2grwoqYDje7vSDPTe
 847l4zCBD2LrcozacuW9ZOs6gqNyTX4WTM9WtehK6RtRlmjXxMYUaY6lS g==;
X-CSE-ConnectionGUID: l11H3cCZQ9i7/uvajrBZmw==
X-CSE-MsgGUID: 5rcFc3bNSryjmzDQcSrjbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="41099963"
X-IronPort-AV: E=Sophos;i="6.13,304,1732608000"; d="scan'208";a="41099963"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Feb 2025 05:03:03 -0800
X-CSE-ConnectionGUID: zESzZ1RvQ4GVLn3Ov33VGg==
X-CSE-MsgGUID: euKHVrUNR8ywv/Lhn6Z/Ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="119492494"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Feb 2025 05:03:02 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Fri, 21 Feb 2025 05:03:01 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 21 Feb 2025 05:03:01 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 21 Feb 2025 05:02:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fVBlUGIxKXe+9CX2XcKadqXHFfLOJeXUS1bcHTODlXavTO1gLWAjbwH+VWsESJAqG+57cMDop26cregTQtcB7y/+DciHBHQW6KG9BnWDD774TUsR+XgdHB9bo+u1H2uZfXOIkfHWtiAF+1GDm6xCyvLCg70yI0s+zbvYgh67zbN8h56oaJyUeus9sh61Yf/8Qi9Z0A2XjrGcedOIFk1GjB8lwmGYBJwTFwFRVTRr43fEF1mYKgoTy2AjFDvrHRAsZ8UPTot+PCS+vs1FASruxNR51FkIStl78G+YP529tms2dYElSCqALU/Hu1mflf3QP2PP3H8iayHNSxJTGkOMng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/k+8dLGAEZSbAm8kjnAc+oTpWlgc9Q1FwX9+F21P+U=;
 b=kOHrX4kqCa66K4kbg3u7JdcCVzeXobNO7QoGtY4LnoebjHWj/M02JnX1xiscIwPrvBlTLeyX2a0uhLzDw0y4xsiMt+hp2rxNQW+cWxXJii8MD/eA7CyiPN1GfFvp/SSi11/2JUR4tDuHpsFzf36J5Hl2Xp9TuqzCr8dtZWCKTtguAvx3wEeyWCYW6SOZnFuPyh6beMArbSBXM5351zSNpEXKbGPzSQoxhAJLSN2sitE8Ebn4eV2C2BNXWXLNpvUUV4DfimYrIlOFuyO3v0I4G7XeIF9rrRzTb7PyzJciU2lnQWH4u6WCa51p5tc2Z3t8Kv0JWi72tdfqll0ZmI4ejQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6290.namprd11.prod.outlook.com (2603:10b6:208:3e6::13)
 by DS7PR11MB5992.namprd11.prod.outlook.com (2603:10b6:8:73::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 13:02:14 +0000
Received: from IA1PR11MB6290.namprd11.prod.outlook.com
 ([fe80::d282:a9e1:f4ac:b02b]) by IA1PR11MB6290.namprd11.prod.outlook.com
 ([fe80::d282:a9e1:f4ac:b02b%6]) with mapi id 15.20.8445.017; Fri, 21 Feb 2025
 13:02:14 +0000
From: "Singh, Jasvinder" <jasvinder.singh@intel.com>
To: "Ajmera, Megha" <megha.ajmera@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "Dumitrescu, Cristian" <cristian.dumitrescu@intel.com>
Subject: RE: [PATCH] sched: fix wrr parameter data type
Thread-Topic: [PATCH] sched: fix wrr parameter data type
Thread-Index: AQHbhF6wOUmrYiHS+0CepcrM0Uf+rbNRuLag
Date: Fri, 21 Feb 2025 13:02:14 +0000
Message-ID: <IA1PR11MB6290E14BFE9B90F3A21B848DE0C72@IA1PR11MB6290.namprd11.prod.outlook.com>
References: <20250221124755.427459-1-megha.ajmera@intel.com>
In-Reply-To: <20250221124755.427459-1-megha.ajmera@intel.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6290:EE_|DS7PR11MB5992:EE_
x-ms-office365-filtering-correlation-id: a7cd1073-70df-4ee0-6aad-08dd5277f633
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?sjClTIs7HIvS70klm5z+L6TIif0jB4gv8Eg6biVY+OtP2Jd/u/0oaR5kzhFH?=
 =?us-ascii?Q?PpeLgOuWy85nRocaHjekbyXInfnhs7i6IE9X+XOPx+wDEDyvJX1+rIloiAeK?=
 =?us-ascii?Q?SoVDmkmbqyRjzltLIZ7uiXuaVr+XGhChLiaigQPshTGnIhOjOKQSvwN8pnDO?=
 =?us-ascii?Q?s9cqYOFmXAgAbRkikkNKema5VvyXqNKoGA+OfjnXoPPovBHqXl7AwgQpFuIy?=
 =?us-ascii?Q?jCWFuCgO+t3aLQNZ+5iG7rsWeDVfXBqE3zDQahcQz5fnpsObWVxL2uRkhtd3?=
 =?us-ascii?Q?EEDgCspHIDWOVjHfMwv+SxaT4BonHsJ2B6cOuX53hx8KwdScJOiycxo9Pyqz?=
 =?us-ascii?Q?g1mpaBUyDN3NKER0IMZIFRtanq7tgIrZwvDVwKsqhH+Rl7gwCdVuWFkk3bJj?=
 =?us-ascii?Q?qecOcAzAOjWNX2BMwcOvPiTBChy9zjiboTD8zrnFveYLQA+v0+YeE6tPnE3f?=
 =?us-ascii?Q?CmrHKh12DZGwNXAkdsqVzC+6xtQfTAyMU/iIB3olwGwsV+U/d6rPFYyh8Sns?=
 =?us-ascii?Q?WJTPkDl/3nhHzRIe3DkEnbQ5vzrKnDDg+/RMc16ApNwVEoV21pKpMXw8JRhw?=
 =?us-ascii?Q?/BSygUcYbn5Z8OdmoXD6AglRp9i3E5heNXZ6qRHF/1K3kkFUOEIjEwbUif5T?=
 =?us-ascii?Q?6vni3fmhGZUsU6CRsGN7bE21UOZdZQsLotAi9zVtFtIzJ25lh2PL2TWbDrHc?=
 =?us-ascii?Q?KKy8V2BLY6hOT9skKEowbS4ZygESfBA3ZyCGVcikVOoFEWCK7N6Iiu78iXxV?=
 =?us-ascii?Q?00VlukrkZQKGNWERGpsATDr61Y8z0bHYnHiLmQaduu1DTod9qbMvtqUqlbKC?=
 =?us-ascii?Q?K/FEZoHqiXanGszFCm6DK5k2C+h2IBKPUvkFZ7t59QyAASX4ry6McRIBw9eh?=
 =?us-ascii?Q?IWcqfQ4CR7PJiYmSqfcLMnsQkzSUkonbrMP5rXRrx3EfsrEiCERKmLMrS250?=
 =?us-ascii?Q?fD7h9gArq+8o9278p/AHHGnI61fYvwa76Zrs1dFJpWsKoyYvhu+roOz0/Abd?=
 =?us-ascii?Q?+B/F3MlV3I4w2rLOrqtt0lXfPhqfDWA5PEP5uWdC28n/Y42TidPpWXjq0ZMg?=
 =?us-ascii?Q?Y7zWtBVTMSsQHrn4j/8IdBM1OBP9ffudUq/quVzbNq8m4W2YRA36JK+Au9Qp?=
 =?us-ascii?Q?fMwndKs0GH6hEGd7Q3cIBgTi6mDcj/o+pnZD02bHgmeGoAo5Hyx33uPisGJc?=
 =?us-ascii?Q?CWu0OUKoa3TePdQGhn6CU9qBMVcDNukkaqVEnMze0c9DtHkCTAI20++fMCFk?=
 =?us-ascii?Q?i2p5nhxweM4+occJApjnEed8gY9NHVojmkobdi/2TNdvbUmzV93AIdRhCgMx?=
 =?us-ascii?Q?/EBBuiW1t6Cb89xiUqRDDavsopmDXwX0Ylspmrfq+bMCouvrWe59wK2vTJ4n?=
 =?us-ascii?Q?FJhf7zMrqybqhf5990NEhyH7wduAdKeci6OwvrJXHDyQ+XPtEphNZDZj1NrU?=
 =?us-ascii?Q?bzssePlW7knehiYBYj8AjC2nDXUidNmL?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR11MB6290.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?B03pxD54feqhxXn+/ytWicublxZTJP7HtiHU4VLpQHkDEsmBz6HN+uBs2n0L?=
 =?us-ascii?Q?bYQMuDA6kVlURXCWaFUhoxnJeEGg1JPulQTJFiNs6Oe/BtdrZ3v89xDm6Ym0?=
 =?us-ascii?Q?/tisJcJecDR+KrFIoHfuZchrbygN0xehbouMgMMYrysAEHfISN1nuybfdbW4?=
 =?us-ascii?Q?ZJQuYSsiyo+DuXkZ9Ozq5XhfkOG4Ju1Wfd4L+IVBo0NYYUvZM4DEG0xwYMXR?=
 =?us-ascii?Q?W3er50ZW0uR2lf8Myqr4bEU7cOoh1VXAo59z7OVXTVnWlSEhtTmv0a+ayybS?=
 =?us-ascii?Q?BTyEnHE6w3ckaOBVpTUjdvdH9TidwgcYUejmqo5FJutavekLGVhWn7k+G5wv?=
 =?us-ascii?Q?mqCpgAZ1h0ln4nHF3iwY0NUX8T5hf945DVkgiieKwVykoPJEpieklMSEWeAQ?=
 =?us-ascii?Q?SC7VjDutkLJ8cq0w+sQKvsvbfwflZUGGc0LQKrgvhD3ohZeiI1W557R9bVjy?=
 =?us-ascii?Q?SsaYB2x2G7sF5aD/eEJCoyjUpvd4UzJuQe0hrgPG+PpUMCDePgZ0/Q2BYovK?=
 =?us-ascii?Q?PXVB0/rd5oCv2dpgQxwW0QCKgiryNs+MpCRp9dI5fpSCkJ3W/452mBwVXVYg?=
 =?us-ascii?Q?zGj7orVGJAz9+Bvc+MmojHJCo97SAH/Pqo40vWOFHklYlqL4g7/zZ2LTnL1x?=
 =?us-ascii?Q?IRjMP+keetiEUNT/maHm3KIypW809QzDPAwYpSwftN3LSCMHL+Ctzj1xpCPK?=
 =?us-ascii?Q?3CzoKzOj5OjwFPPoqcRJiKQT9QXb3FJPJ6czjkCWptiH9QXpBeQNz40VJEMQ?=
 =?us-ascii?Q?aYFREb7Ai3Wq4lr3o9J8blVWFjj1upmNBEG4iNP5m7oiLeD7OZsMaKcn3PXz?=
 =?us-ascii?Q?HyZLANmoBTCswYNwMHsIv0CjeP9sT3g08z1oEhsC4hNYP8nLNcFkC3wP8stD?=
 =?us-ascii?Q?x5IN/cGsWpUIcMmqe9h9nqGUmY/kZiBzeR0SvkzR4gapuTEkPMlRIVJlKK83?=
 =?us-ascii?Q?1Y77tbWD/wpIU3saIItRwzkCJ1vqs2OuDhQ+3fOj9+Meh+Bj11yB1kJPLrTH?=
 =?us-ascii?Q?KzgzdOikqNIDlQ3GuiWs8RscYoKox8WCaagHsydeR5OTHSg+zwUmoMLgisf5?=
 =?us-ascii?Q?aRs5p2nDR4aVX3rW1FKnb3QADsslgqzYVRqHGqwYZrpPqOm6veUSfBumKNT5?=
 =?us-ascii?Q?tCjAZHAzKADG2AKG7P1F4eIj5QO84bksecJrMnUZ6KnwskDK3FavwjV3kJio?=
 =?us-ascii?Q?q842rXY9ALZ44ZsZjepyjj/2lJzSEEC9PFd8iY25SQuqFX4VU+1yVWjqXeIE?=
 =?us-ascii?Q?oNyo9cm0JGm94p8JgjHVyxZU3khUnaDzhH8Hhx/LMnUV29zE4vcyQxH6FuKI?=
 =?us-ascii?Q?GGYp6mTrwkxnMU7v/IG3b8X+/dPPPQEBZoWlvkBabEqHfMaMM3hUd71iy5sf?=
 =?us-ascii?Q?cnzEc1+UqcIKwjJ8Phmy2CFIE1NdWYWor6mOF3MbJzFkDhmF/fcMXx0MWVBy?=
 =?us-ascii?Q?+vr+k+qmpVKbn5Djjp4o757Oz9xH7JYtYrbJbufEU+KQChDZyTI96Zhd5EaE?=
 =?us-ascii?Q?uUDBvlcpkYogRnJHL4/HMKopEzC7grpaP0EZqU+44PEKTvMDa9VTDR3AsSzY?=
 =?us-ascii?Q?7IPnYGPPFtjO2dQgBYc0A3oI7utJwqXyi2PDrHl8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6290.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7cd1073-70df-4ee0-6aad-08dd5277f633
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 13:02:14.1566 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iG76m+h32EtpFrjqxe6cZXd1gkmrM5bklX496fpRbJqw5EWSXDamwRTR+HnT/MQ3dMC1GO2dxTwRGB33OESRx08qmAEsgFwsiHhloPj0Pns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5992
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
> From: Ajmera, Megha <megha.ajmera@intel.com>
> Sent: Friday, February 21, 2025 12:48 PM
> To: dev@dpdk.org
> Cc: Singh, Jasvinder <jasvinder.singh@intel.com>; Dumitrescu, Cristian
> <cristian.dumitrescu@intel.com>
> Subject: [PATCH] sched: fix wrr parameter data type
>=20
> wrr tokens getting truncated to uint8_t in wrr_store function() due to ty=
pe
> mismatch. This patch chnages the data type to uint16_t.
>=20
> Fixes: e16b06da0908 ("sched: remove WRR from strict priority TC queues")
>=20
> Signed-off-by: Megha Ajmera <megha.ajmera@intel.com>
> ---
>  lib/sched/rte_sched.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/lib/sched/rte_sched.c b/lib/sched/rte_sched.c index
> d8ee4e7e91..dcef44b91b 100644
> --- a/lib/sched/rte_sched.c
> +++ b/lib/sched/rte_sched.c
> @@ -66,7 +66,7 @@ struct __rte_cache_aligned rte_sched_pipe {
>  	uint64_t tc_credits[RTE_SCHED_TRAFFIC_CLASSES_PER_PIPE];
>=20
>  	/* Weighted Round Robin (WRR) */
> -	uint8_t wrr_tokens[RTE_SCHED_BE_QUEUES_PER_PIPE];
> +	uint16_t wrr_tokens[RTE_SCHED_BE_QUEUES_PER_PIPE];
>=20
>  	/* TC oversubscription */
>  	uint64_t tc_ov_credits;
> --
> 2.34.1

Acked-by: Jasvinder Singh <Jasvinder.singh@intel.com>

