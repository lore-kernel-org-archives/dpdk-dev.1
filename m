Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2176BD358EE
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Jan 2026 09:42:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C54B4026F;
	Thu, 29 Jan 2026 10:42:14 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id D585F4026A
 for <dev@dpdk.org>; Thu, 29 Jan 2026 10:42:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769679732; x=1801215732;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=T0EO/q333nnHX4yTrGC5zA6WJVxWasLAyaCngNNNVMc=;
 b=Ed0PW2iCOrcXzIPuzvm95rIP3crffA9WtPIXd8VIKdi1vvi8vLVITIlq
 DIBL/Obum2aeOQj8Os8cmq9NHh6bMSa+nYoNbvUkr06j+oTsDs/M7/15a
 14HYTACTZxUu2sbMi9LYjwfAoDitqGsdkLVw6hmV4rwW9G3E7EOKHUn7D
 RkN8VBU7zJ931/8z2BCl3X9sAr8fvim8vLRmJZs7ZPMtvBu5duHhwc7vk
 C4Uu3cmhgcJYDv+dy7gIjwvwAz68IhCM39eECh531WTP1DPNnA5zc5KJ8
 xT1lJERKbT2Y5/brBkXMO/u7r3HeMCKPX5P4gBBbKpZqnUsNB9vzETLj/ g==;
X-CSE-ConnectionGUID: 3jojMl4ZS4CMBMWNSXCHMA==
X-CSE-MsgGUID: aRCi+JyPRMut/+MuEWOv2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="70625954"
X-IronPort-AV: E=Sophos;i="6.21,260,1763452800"; d="scan'208";a="70625954"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jan 2026 01:42:11 -0800
X-CSE-ConnectionGUID: YpRTUfQvTYeqAfSgbGzV/w==
X-CSE-MsgGUID: nQBwz2XfTlSdNmy2KK7CTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,260,1763452800"; d="scan'208";a="208882307"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jan 2026 01:42:10 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 29 Jan 2026 01:42:09 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 29 Jan 2026 01:42:09 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.40) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 29 Jan 2026 01:42:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G5aM7md84PrutNnGjGCshZMSG5WgFuqU9mpAPXolAjQq20imlFuMGHGxkEpOevwsw6yRBsvbhuRqVv5SC3z089rwEZCbrOg6prlE+zniUtnyF625c7u2WHBi8bzBv60qyCBOpxMq8N2qZXApsPq4Ga+pAabaXQ5LR8e1XNESiBNMUal2B/dUu9yfxXX05q5mICaiAP+QzHEAlADajRfj6zTSEzqe4gveohMeWsq4+Yi5HQLXZjfmjkv+YvinKCtauZ7tQaInTqhQpC3ROZktF/TLy9wVZWXCuP5kRdNAULeA3qbXxwB5Q228VVSApbBPvqCqZgc6nYekCHnHOvn2jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lHIl5PE5yojApoZ4tf9I2vKSVyeUbzDBWpLWwrez5pk=;
 b=SOHLupU450S73QbhjjOY5lMtt6vWItipVZjslXM2Dd8yEb39djddRGuj9wi6IWhReAjxC+l3SH3V5/1V96cEe0oNU+8wQjvhWyjg5otKEKLCfznbTXK94vbNE8X5+AXgXWysdBNAufbSdDOcVA2lOLDFemSMx2p4d3lUPVBi4hZ9gzagoD825GptvTjv5eP4r45fIQaj+hoPOD5fC2BKhRBmcSJQQS3gXvIaM46ePGuA3Nkhbeu5UQ+3cg0WqPDhi+dFASNa0gC8/IBvUmJ8kV71otV1H8dmpKqG/+IRxafBRYLmtII8mSh5BBqGF4aM5jvuG8VNxhr4+wpjkcwKbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f32) by CH3PR11MB8364.namprd11.prod.outlook.com
 (2603:10b6:610:174::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 09:42:06 +0000
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::5f81:9e50:1761:ca54]) by DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::5f81:9e50:1761:ca54%7]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 09:42:06 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [PATCH] net/ice: ensure correct vector flag after reconfiguration
Thread-Topic: [PATCH] net/ice: ensure correct vector flag after reconfiguration
Thread-Index: AQHckEsMuxjq44hZ/kKGcQe+Pi56o7Vo5joQ
Date: Thu, 29 Jan 2026 09:42:06 +0000
Message-ID: <DM3PPF7D18F34A1FD838A82E5269AE6F52E8E9EA@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
References: <20260128114110.39253-1-bruce.richardson@intel.com>
In-Reply-To: <20260128114110.39253-1-bruce.richardson@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF7D18F34A1:EE_|CH3PR11MB8364:EE_
x-ms-office365-filtering-correlation-id: 31401321-0e26-4f6a-6d85-08de5f1aaa25
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?qVsa958Fr88MuXOLuWxPWkdB9DTYl55Y5JfZ9E8BHZqwLT5wky50l8E9VRbY?=
 =?us-ascii?Q?s96gvjflSzEVvSAAIBE04Bsza3KvcgkivkebDq0xyySzI8J/KGNj0EpAu0TF?=
 =?us-ascii?Q?1xV6NCitkDn3c42HyahKweKZVj9VBkQ333gvOJBQ7NpXi2N9fwmICGqjeoxe?=
 =?us-ascii?Q?Q6kD3WZJpTfPET8XAdVEL1m2IqApJ0u++e69AosnO1QjOyYLsWvwmxMv/75J?=
 =?us-ascii?Q?xidAf6P+It4iz48Jfkrwbo8ssqJxXCjF/+sco7QIY6HJNpZvLzaRxQRnSQz5?=
 =?us-ascii?Q?pUYdd9g5Gokpi/GH7gajSiduuO4kbxxCRmg5tI+ZefCCljMnAnljoqFX4m9w?=
 =?us-ascii?Q?3JXKxXiv09TMVrPPtYmBEnyf8SY7E2xBE2PFI7x+CoASLAYNDmCl+kPDZq3m?=
 =?us-ascii?Q?BjmD/2hfh/Ybg1jV7fQVH5glJM3sGvWmlM1yhlwOb5TSxKbrmu7msvNUo1jn?=
 =?us-ascii?Q?p6sitTX/D+4nv83h8ecnQ/o7IFqnqW5Q4jzDD9R8tlqZuEFwVaK0kdMdp+zi?=
 =?us-ascii?Q?5c8PD06dmew58/5hPJ70Gvhdr44XJouBQl0h4axp+S9h3upaHCdIdxASXKWn?=
 =?us-ascii?Q?tKhh9FV5PJuPEv8VJpcdPJNv8jPFl4jJTScdov8wSWr6jA63gv8gnQNSmjN4?=
 =?us-ascii?Q?Q+d2nvQkPbHq4Zb1dr51KbuJVqvfC8pHXZmw/nEN3ufilmjq6WnW6SglaXXf?=
 =?us-ascii?Q?k/xPH1lwixK3UNHDxzH8YVn5jzpaLVy2uS6WrpHTtz2D3cA0PvrwRWU7ZQsT?=
 =?us-ascii?Q?3Xe5rChGKDzdGTpQ0KfxECTZu8UMUXnJTqVwQRa5a0CpdhBn1EtzSB283KhM?=
 =?us-ascii?Q?mrY04vEwo2LrYVYNUwVseYMWfHslDQY4kTceEXSbzjJj661rXNs+wNLEorau?=
 =?us-ascii?Q?WlwxjqZBgK9YkIgF7FxxkAbbVGWql13JcZk6iKMJWVr+DzORE3QyGXBaIMQG?=
 =?us-ascii?Q?jaWOs/BjPXglsOCrSthJ11tgORH3bUCnHE4hMbhW7gfQfzTHBOsU8qFNIkPn?=
 =?us-ascii?Q?hEBQFbFsG83djPGiSEe2QxJJYHWZYuLkh9Sk9uYlO25qqhVaCIKn/T/G7EIB?=
 =?us-ascii?Q?odFyzU5kC8AQJckCPcdSU3IPb2BZ3zZdJYN/ntThKjhPbHh5KuVmNZ83rRd1?=
 =?us-ascii?Q?ThftO/rre5+G7sYKQAD4CM7+UafF4iKk+8tuLLaH0UgDojX5uhSCY31ZKSik?=
 =?us-ascii?Q?b2Z8nXBTS82j0mCCQ5LZpQZLIZcvOCAbOoyUzlB3NBVbthnOhsubJU6jbJFt?=
 =?us-ascii?Q?O3oYYMlYEXsHrElfD9uvi6w5uhCZ+EXBkyNnsEm8EUBsggxixNmyw0mjlgkk?=
 =?us-ascii?Q?xT8kdhKVEztJhQGCiFmnybtoifEdkaFptFcuxJfG8ZOzMq+mvmwGQxNVyiOT?=
 =?us-ascii?Q?EZWnW0VubekIgygQuVpNqrRFskI1GtBvkI6RnUaSmsCZbj58RcuNP0246lLe?=
 =?us-ascii?Q?kwCG54ILIbm0SbRnp+djrd3h3vf9ITvgdDUkjIqbUgm5r7M22xWzms4xB96c?=
 =?us-ascii?Q?mdUR8mdh0X5z7vrZPR/nwaTeVnWgr8aqvPoczOIQDx5ViV0do5KRLpch/Rm1?=
 =?us-ascii?Q?WLbYOoacLZO3JHdbeB1lFy5bwI/pGidE88h/DIR4l5EzsPddx0hogHy/ejql?=
 =?us-ascii?Q?Iouq8QyHF8i1lr/eN5ZDxFQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF7D18F34A1.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jk6wmj21ZQ7jP3PkpepjDLufRmBWwp6YXje4mKWSVJCoqs0Re7seFGkb1WFx?=
 =?us-ascii?Q?Vu0OTnPZPtD1XyKw1CGEp91k+4ilqlomVnGLvD+tUHortPgDssWkObikhaZK?=
 =?us-ascii?Q?OqmMPfudkJ7M9Bk1UbNRGfa0/fNJrJdazLotZ1hVAxr3x4YR6aqSnSrDMhGs?=
 =?us-ascii?Q?H7o64kegqmIQ6AiyMTVtH+UD0XLS4RNLlNAm6FarbE+PclSwPML4W1rKIXLH?=
 =?us-ascii?Q?+/0Btzcv6kibO26GFZISjTd09UnEB0JGp47/ojCuqqDt+IkBGo1oWlaPoBFM?=
 =?us-ascii?Q?juqxMlWD93PH1olDg/+h433DbyY4O/+bkDjR4by1R51h215vT68S3M8DiS0X?=
 =?us-ascii?Q?zwpa5Mj3U9HbZ9yWo5hUdXJTWTCIUNZ46pry0BFV5fvch2Rkmbpe/NWR9Ob6?=
 =?us-ascii?Q?1DJK7AEeA9gStPPmjQuMsm0eGhIbVrpcLJg6VFc0B32Qg7aZlX9YoL1cHEHv?=
 =?us-ascii?Q?rYp/zUgrlQCE0gYB+kxkNFTfltDuiL5HQgFD/zTkVNL24D3o9CnSCmE8NNG+?=
 =?us-ascii?Q?m7j5GoFtB1B+tMlcv8Qw/jMK0Q/PkDj2q93OKYJnyvHyJQVQOF+vPzXHqU0C?=
 =?us-ascii?Q?0kOEoJ+f8PoM/23qrR897zx+qIGiKVNvFuyJGw5fNa7yCy3/Bybqw5K649gT?=
 =?us-ascii?Q?oY/V66EdW6oxRCGFFdZVeGcGBBS1/aqWsBDNMidv73FUA1cAOkcMWMc8LNKE?=
 =?us-ascii?Q?437staP9ETDMq4mfgrwm2+q1ygMCPD53bCk0rWItS+Eswtwh2aVj1yU4yIl9?=
 =?us-ascii?Q?K2zXAxJqsQ7Xeoy3LYys+nKdFdJO00+PG95MApoJgi99yCh22Kh1vCOPmCiV?=
 =?us-ascii?Q?Pb8v3l1sZ+N1vryF24j+B8nfd1i984iwI6f/fUgbmybyajDn9VkTtJL1zddP?=
 =?us-ascii?Q?duANj17tH46nZjlcHUIQjHYoE+zQgyQ+dNRYjZzxW0P2/dWvsyUPjJi8ZeAP?=
 =?us-ascii?Q?DN25v1V0qShMil6dPLH+OxNBuiH5K1ESgTNZ3VIuWYcPfqrUi9j8ZdFXbxMY?=
 =?us-ascii?Q?SxaEV8n4EEQNSwHn4N4XImG+89+oFDNo2KgcfkmHch1GuMkwJzwhs+hnKLOe?=
 =?us-ascii?Q?K+gbHmDPQk9FyOZ1fFh/GPCevoYYNElH1x0XuiRAE6wG1nhNjTrXSNHQK+Ch?=
 =?us-ascii?Q?HEO9GLgvSilEMAazZq/3WbWvn5zUI6ZkRyBMIZnYsj+PFN+Q4ka98Vjy3VXi?=
 =?us-ascii?Q?UAcX1bHno+ELqAx56xkzzWJbuJ/wkb4DNUuHYF3LZTfw4vAoYi68PPnAa04d?=
 =?us-ascii?Q?biQ9QOjIDLxSSxj9lTyHziXyTlcDswzaYk/uQd9TE0C/H0PCXcZaJG3AQriK?=
 =?us-ascii?Q?v/OwQ0wSVmYGIFghhkH7NfoeOEDuy8ixanzgfe+00qWAsuLXau/e5/rBSACw?=
 =?us-ascii?Q?bcFizgRzx+mSwECwthb7p3QNnEVpAK6IIBr9V6MeAYp949MPZ5XuScvEcAaL?=
 =?us-ascii?Q?ksD46a4d4jFe7pVUhqbvHGLchbUAgxzEm57sN8Ik500KntMyiBlM6M3u5C8v?=
 =?us-ascii?Q?Fv80+9TTMiQvNBXTBzHk+M0pvIVQQFKdcIANi7youpdRO5w6SIcJOL1mMu/j?=
 =?us-ascii?Q?pqy4OUteRp0n/tvMEcbVu1Min6fp2oVLU+K5Cc9xgIT/P0ZpoFemt2dQokMV?=
 =?us-ascii?Q?Mbvq2krgYNCvoQQlyrcPPCSQ3bG5QvHwxz3SiuLiJ34AGoe+K6RktrwCUttK?=
 =?us-ascii?Q?eM/METIiQ41Bq6lXc/srnszMwqWl1Cuib6KYWZr7Lf/ZU4ASTSv2sjW1T9aA?=
 =?us-ascii?Q?LlW2M1/KBA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF7D18F34A1.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31401321-0e26-4f6a-6d85-08de5f1aaa25
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2026 09:42:06.0987 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8bVa4lwvifEu/tjSuXJgj7EqortcoTHxj7NaI03LddfvuE17HT0Hh2sPseZhPerq4CSiAMCwtDnewKfETx+DVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8364
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

> Subject: [PATCH] net/ice: ensure correct vector flag after reconfiguratio=
n
>=20
> After configuring the Tx path to be used, the ice driver sets the
> tx_vec_allowed flag if a vector path is chosen. However, on
> reconfiguration, the flag is not cleared if a scalar path is chosen,
> leading to crashes on driver shutdown as the wrong cleanup function
> would be used in that case. Fix issue, by always setting the flag to
> true or false explicitly.
>=20
> Fixes: d3206e40c435 ("net/ice: use common Tx path selection infrastructur=
e")
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Thanks for catching this Bruce.

Acked-by: Ciara Loftus <ciara.loftus@intel.com>

> ---
>  drivers/net/intel/ice/ice_rxtx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice=
_rxtx.c
> index 59ff4c31c8..816733819f 100644
> --- a/drivers/net/intel/ice/ice_rxtx.c
> +++ b/drivers/net/intel/ice/ice_rxtx.c
> @@ -3721,8 +3721,8 @@ ice_set_tx_function(struct rte_eth_dev *dev)
>  						ICE_TX_DEFAULT);
>=20
>  out:
> -	if (ice_tx_path_infos[ad->tx_func_type].features.simd_width >=3D
> RTE_VECT_SIMD_256)
> -		ad->tx_vec_allowed =3D true;
> +	ad->tx_vec_allowed =3D
> +		(ice_tx_path_infos[ad->tx_func_type].features.simd_width >=3D
> RTE_VECT_SIMD_256);
>=20
>  	dev->tx_pkt_burst =3D mbuf_check ? ice_xmit_pkts_check :
>  					 ice_tx_path_infos[ad-
> >tx_func_type].pkt_burst;
> --
> 2.51.0

