Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD737C43458
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Jul 2026 12:36:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 12CDB4067C;
	Thu,  9 Jul 2026 14:36:29 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 7B51B4067C;
 Thu,  9 Jul 2026 14:36:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783600588; x=1815136588;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=6gwH/Wns9nDG1KQCW9HLxmp31aZCVIyO/KtD12oMPXE=;
 b=H0XXbbuWsEYuz0ap7nR8vf0aqTltRbUg7+5VH76Uh6Y0c+t7Aq/JlbP/
 QB1B85FwgIfa1pATdsl689IKMwZLVPpwQc+29X3S80Ue0GOHdzp5lFr1V
 fzDXNKHJs3d8gLLadwOpCnbq2t/ES8YzGVhgfjuI9byD/PNZjCl/bP7xt
 LsrgZyniOhEmG64uvYVt282+NpysMkYfNJUSgjxBY/NbvtgbQ43BQnfN/
 i+eBsXpm2cmvtiLY8l0O/25FunWY5SySVZBiswsE/1844N8lDxBVCN1X1
 P9Y/lNkrc16LTKJNvHsDrxxE3/eOFIgjlcuGufXBwadKhzbPH4aEHdJ69 A==;
X-CSE-ConnectionGUID: F6J5sdRmSCGw1ILMDXHwLw==
X-CSE-MsgGUID: TAPafPcOSvWMRRdoAbinTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="86821791"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="86821791"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2026 05:36:26 -0700
X-CSE-ConnectionGUID: 2ZmPgikqS9GyScEBsEuHBQ==
X-CSE-MsgGUID: oTGQj8mTR0e5PRiSHp9O8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="251921717"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2026 05:36:26 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 9 Jul 2026 05:36:25 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 9 Jul 2026 05:36:25 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.32) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 9 Jul 2026 05:36:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h4MT+OMkKMVxvYP7uMFxQHF6pgoYpC8/E/jW5xRQ3GcOW6illrUJsnBUB0e3R5h+ywol+1sggVLywmI9xWzsP1aXwdJrqjPaRYFuNwKwmqifResFpuAEde+2DEMGA1sjuVhihbtiVwiZ8lB8GqdpMlIoBA6S9hglwo22Amy1om/VnHACYadCyy/2JjMk3wOAMkG5t1TBmZqgsAGpmCeHaklyy9KGR3b2riQivuuY8HJK4PJFj3EfGbkeavYix/EBdiDhPNw5/DMpVCr05yUxmMWmTaaOi8xDPwg8sctIAZcEmzJN7Pq7gwKL4wFpql5Eqt5GDeMx2A7+s2SOwAetIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7qXEAkmXN8WUdAh2vZhB7UN1vqKcaiA0kpeCkOMRHHo=;
 b=uthqhN8f3+w1TOhZyw02PKIchlvsWs0V1//3ty/YAtFaiIljsB0qyj8VMd/JkHqDR3QBTmkVqZQ+gWCazJJE6Yllkwcb/Xslo9Qtq+lgooO1WLTRigoc29k7fxwd+qp7yHBVZneoVUxvxIoKUsigLEIovd53P0F8qc61+Ap4dZ8qtWrH/rcbPvqUElw2N1aU3ehQfJwgeBYicR2PEm6yyCp16VZhBARi93MOVQzBunc9jkrwFnPJ1fYqsVWrHWdgymsJfhfsF4CjH80mJPuDMLDtzYbVd1RtYNQxtbftdJ8sum5iRvFuPrSY0NVc0tpIo19qqfQIJgL0n95sRxU9AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF6915D992B.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::29) by CY8PR11MB7268.namprd11.prod.outlook.com
 (2603:10b6:930:9b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 12:36:17 +0000
Received: from DS4PPF6915D992B.namprd11.prod.outlook.com
 ([fe80::805b:a539:5daf:e3d9]) by DS4PPF6915D992B.namprd11.prod.outlook.com
 ([fe80::805b:a539:5daf:e3d9%8]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 12:36:17 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "stable@dpdk.org"
 <stable@dpdk.org>, "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>,
 Haiyue Wang <haiyue.wang@intel.com>, Jeff Guo <jia.guo@intel.com>
Subject: RE: [PATCH v2 5/6] net/iavf: fix leak of flex metadata extraction
 field
Thread-Topic: [PATCH v2 5/6] net/iavf: fix leak of flex metadata extraction
 field
Thread-Index: AQHdCu7BfrFLS4yWG0OHBHYt/I4htLZlKAWg
Date: Thu, 9 Jul 2026 12:36:17 +0000
Message-ID: <DS4PPF6915D992BA7D46C48A5580B4EACD48EFE2@DS4PPF6915D992B.namprd11.prod.outlook.com>
References: <20260703083335.4058936-1-bruce.richardson@intel.com>
 <20260703131921.4102325-1-bruce.richardson@intel.com>
 <20260703131921.4102325-6-bruce.richardson@intel.com>
In-Reply-To: <20260703131921.4102325-6-bruce.richardson@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF6915D992B:EE_|CY8PR11MB7268:EE_
x-ms-office365-filtering-correlation-id: d4a6b7f5-367c-4923-ac53-08deddb6ac38
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|38070700021|22082099003|18002099003|11063799006|56012099006|4143699003;
x-microsoft-antispam-message-info: GXuTk/iBm8sNrD44trhrB5zqPc+heJDFzdA6quGvOB4XXtj3tA5yW5/o4Ba7V5vvTKkysn8xR/G2qW9NjPWAMdLxA4MmoGnyx97npLoSlKjp289ZnNSoa/GPbIOk68fp1owZtz5P+h0sBiO+89VYW7ue7LTikNrfOnfc/vsU/kMJREYyZDith+UIvqXTdspdr5Lb4saKG7zfzGoTc+usEhC0l9WF37x+uzxQL0StSx1OAN5LXWw4TltWxlFraN5tReKDActxjmcFGxeGuwfAjqiJj0rwHunbCyJt1wY8d1jorACYlrGlF4EI/Ix3wPuaDatVrtCruq7oiC2O8oymgdey7Wwvjt7QcskMYprK3Ho4IDb2ad0A0+GvEYJY7Itya1xjz1h5OTNyu6J3ZRFZiflf2LvZKdq0duo+gPkD2Q7VByeJEuVpFezkwmZN0DtWqHNGEHp8z+Jx2znGxgANzHcg7aqxQ3QdEAT5poTd8RIwhu91kBIgPfyThcjYvMPHSqt/1AxIeuAubefg6yHkRtSeKVS5XsW3P4wtCP8aIdhdMznw17fF6DQg/DdI4IvlBZF2LYZbcE8a3lxakXUeWrQBDrm7B0IZTQD4kVG49NPP2cLGeTNk6oCAWhXDGTXpgEs/zeYZMM008IA1TKot8sDAXg9+A4nRPnYvoxA3ws0eb+LlEdq6MdLqtEu1lHris0F0SpbK7OKOjzKUQeUP4K18Pbm/sIktA4slKj/eGgc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPF6915D992B.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(38070700021)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7Agfqew/ibySCJitW7ftrnk7MNRQsURV9kQlDGC7G+4quiAQaY/KcERXgtF/?=
 =?us-ascii?Q?8K1pWGl/k8xRKcbyUsXlAxkTgmXUPsZ2NooGnP+t8qHzN46WHdEraspatLXx?=
 =?us-ascii?Q?Xj5YWCQ3RAS8GWwYxqZKyI4DtE0sdaDMwJ2MzMgOqvZs6qdgvnUm/76B257G?=
 =?us-ascii?Q?wSh1h5hrgI4fw9ZbsE3pv7j1uhk84/QaP6D5mCGgYsomGn4myb5tIHC6NhW7?=
 =?us-ascii?Q?Gkydz/qZ7CFhcmPgJy+PDXgA2nbC4raJS0IQU/Sru1BAq29Vgse9gRgASwYf?=
 =?us-ascii?Q?KDBYPRU9mYVi5WOP+aE8tn+F20zI2cZTw4GW/E7dMYSIGKU0PIqBCMVV2ysW?=
 =?us-ascii?Q?DW5JePbzuVhQE2iKdQ6RawtsV3vjF2yEKCBmxjIDrR0ntXLXxrwnPmiWh5m3?=
 =?us-ascii?Q?wFgYXQvRYTczVbYo+K1NrN+EMKHfUdC+WpgfAbK3WlsBwIfPGu3AvQOnXn7a?=
 =?us-ascii?Q?m76uClJUBkoVGRgoCE8L/IT+CFE/+SWe7xeSHXonfjWLSLAdE8rX/KbZlTYX?=
 =?us-ascii?Q?RLtiMpLn3l5LOga8alPxS8d70rbfoXhGDaJSQD4xgvHbxI+3wYAeRgLDf4rb?=
 =?us-ascii?Q?GH42a+AurlhVAduYfCCatIleEOMipVd1DiAH/042S+nNDSFURCtgklacH3Gm?=
 =?us-ascii?Q?xOS5H8VWUXTPKXw85DWpTnC3YKu4TlKQqK6ljVma2FRCgTTktN4+dsGtPfYD?=
 =?us-ascii?Q?TKy0EYjIIDBy5nIl+gmDCt8YkBz2tJ6e45R2iPLQMA1UJHTVKAobScoydygR?=
 =?us-ascii?Q?WOua/hz6iY3+WNuNS5FAZLodrGK585I9whjYUvOwa7W08Di56uzltbgDy1L4?=
 =?us-ascii?Q?XUUXOWK8J5Ps4nQihDfmf7DxRFwd66FlHONSmHKpCgdIMKfOSyMny+Oc38h+?=
 =?us-ascii?Q?opQraHLAerzLKrT5kZCxNux+PRRwNByyUvE95eHvLTYYwWsCQ+3s1BeJB3pb?=
 =?us-ascii?Q?3YUbAJu6K7CsUnSza1SzGaV1CFQ+feHZfpz1cEDUuAjIF5FNt4h5IBFajmhQ?=
 =?us-ascii?Q?BtXFB49/EfQKfhgbALOSlOI8QzmgNYYMWQpVjjGibJafTAFwCVOtCJpT53JG?=
 =?us-ascii?Q?aEYifJ+nf9H4QWoqEEBXk9HzS+iwqS1ju1kjpLqkcxL2CbwGZqiwSURTQ4pP?=
 =?us-ascii?Q?s3YIY3YnnqnHqMyGD4WvD0LU5Hs+TDw81QBahlJhQbNANrRES34kG5bS0rl3?=
 =?us-ascii?Q?1ZrkxZcmhJ5nLY8DQZqSvI/lsx4cLo7o7FMCf/fBZM8OIbM7wR/TYU+TqEL7?=
 =?us-ascii?Q?hNBDNOnktgsz6Dtf0Uug+pMPCAN5uAiDJuuPzspnudS0sEpb6juUPSFbFBwO?=
 =?us-ascii?Q?/VzwplCQ9KuJ3FyRNDDBK6LOUjiFGzu/9Y6ksBipf66zM6IEASO4/t9ETuMO?=
 =?us-ascii?Q?L8ZQ4OxdoGHVNfa1JYUJJ9DZYqua0CKL4xk5pfoi6yLeTSxydLK8PXJk9H9z?=
 =?us-ascii?Q?8YUjr/JSdV6IGk8mjBBcwOJVwk5V5/UZox4VCoRlBGuSKWf929NJZEynmF9W?=
 =?us-ascii?Q?Vh1u82UtKAu3K6KvckocEmUH6+oNrg61A53NOTAMM7fowezIsYdJo/EqJVMv?=
 =?us-ascii?Q?Rxl2DocdwR2qyeuhtxRD3/W/XEOI96lFb2MeP0D0agd5gq6eEervMDrvIg5t?=
 =?us-ascii?Q?nSSbQSaF6ZnGiTPwONyuPynGmuXkNFqLdyChHRz6UNeUORefxOnfzXSrRgSH?=
 =?us-ascii?Q?8no8Q1swqpGkdoiI91v3E6y6gslpuQvOBqHQ+ZUEWVjRQXj3K/VJk2JNL49k?=
 =?us-ascii?Q?qpfHGk09vg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kwLU1wVNJ99bt6TGrE8G7lw8fflN8S/Y6soU4WQniF67N1YQkYV6wHLgFlwSq8OIYiAbRTYrfoek/vypcrpxW9riF4yUZhXR1x58FvcMgNSsFabyB8MbEuhtFa4QqUYdBAd+H3AG7rL5d77HtbS6/uySXXLsj+IGCecfsQ5u+RRoDHBVwHGRjzkwlYeVND2znqhL6AiJ45iVeWDDkU71nwDi7Q61DAYaU+6X0t6oINm5mapAMj/jyeSuidSHsKJuUFMJBIryddn5fLWxf3RTUAlc2tkBMVbijAWLb0wMspl+CW1jojzIxfxxzEID29NmP7lsunp8WJrklQmyNezbVg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF6915D992B.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4a6b7f5-367c-4923-ac53-08deddb6ac38
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2026 12:36:17.6341 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8hIo78+czFU7NO92g55H+GdraIjHVV/F5VslG1O0x8YCMdTACi3wCGefBBclCRX3/GSY5KMLPlsyTlNVpYAh5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7268
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

> Subject: [PATCH v2 5/6] net/iavf: fix leak of flex metadata extraction fi=
eld
>=20
> Function iavf_init_proto_xtr() allocates vf->proto_xtr as part of the
> device init sequence, but no shutdown function frees this memory again.
> Add an appropriate free call to fix this memory leak.
>=20
> Fixes: 12b435bf8f2f ("net/iavf: support flex desc metadata extraction")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  drivers/net/intel/iavf/iavf_ethdev.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/net/intel/iavf/iavf_ethdev.c
> b/drivers/net/intel/iavf/iavf_ethdev.c
> index 1cd8c88384..7f5b103326 100644
> --- a/drivers/net/intel/iavf/iavf_ethdev.c
> +++ b/drivers/net/intel/iavf/iavf_ethdev.c
> @@ -2757,6 +2757,8 @@ iavf_uninit_vf(struct rte_eth_dev *dev)
>  	vf->qos_cap =3D NULL;
>  	free(vf->qtc_map);
>  	vf->qtc_map =3D NULL;
> +	rte_free(vf->proto_xtr);
> +	vf->proto_xtr =3D NULL;

This function iavf_uninit_vf is only called when an error is encountered in
iavf_dev_init and we goto the init_vf_err label. We need to free the memory
in the successful case as well.

>=20
>  	rte_free(vf->rss_lut);
>  	vf->rss_lut =3D NULL;
> --
> 2.53.0

