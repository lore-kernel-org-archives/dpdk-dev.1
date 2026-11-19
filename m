Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEAA606A325
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Nov 2026 11:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aj764DUr;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=V9sr3Z8M
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C32D402D6;
	Thu, 19 Nov 2026 12:28:03 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTPS id ED047400D7;
 Thu, 19 Nov 2026 12:28:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795087682; x=1826623682;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=d7vffLBfVX68nFhGENFSyIiXO96bAn4MYKr0QHV0DCk=;
 b=aj764DUrO9R4kXyqso34BulxJv3bCPqgad1JpruVliBC2J+bWsKlP9eH
 43vuFzJqyiVj0s8M+M7uXsjP8VygKUrAwLcU6N9z2qQe9gEw+Bv00zFl+
 U3lbN9uY/XmEEu83kAiw28QMh63T3JO+pQUXIRWqu6QPNCEKyF35VpotX
 sdT/fe3OlJZwFC6iDGhnpxROV6pvamPcSosevNqD+8jruzhcJUPcQGv/3
 gn7uxASaOiJaOgPdDgm+pBi8JRN/1tDuZdxYdV3LcYTfHBlulG3BiTE8s
 2WnyHh+iA+6q/HRNmsOp8uqzioCA4DNlt0yp3TklimpFXxDYrCHYPC1VG g==;
X-CSE-ConnectionGUID: jvYVJHwVQBycV7QLmSHm8w==
X-CSE-MsgGUID: FfHYTlWGQ9KQjqDFAxLXIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3922602"
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="3922602"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 03:27:59 -0800
X-CSE-ConnectionGUID: gUDfqKhbSSer0EHznGiwlQ==
X-CSE-MsgGUID: xbwbWHUgRr+kupjcm36rCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; d="scan'208";a="10445099"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 03:27:59 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 03:27:57 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 19 Nov 2026 03:27:57 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.52) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 03:27:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JLds5rAKuztRuRxy+Njm/csbdJG4WioVyJeqx+q3NgImR+6NnuymyM26HBHYcOM8TcLaB4mLCt2EnrpzHfJRuN33UGxQwg0z77dGdIW7Co2CUTWZKHw3AIkdsNc8SJnfPOdZ8HTR3mMAGkCS9ukzOId/e1XLbahPoY83BHzaNqQ15Nsj5krL4JZF8ahHYck0/Pk27eyXCv0epxgMDUa4GB6xolZcdQieRQRwCS+NwhXv/gZjTHT9YZzLgBy+SsRJf8CF10mQmbWEy9qeyzX0n5CyY5ZmRtsdKz4mFOUakrIq4PO34Rcoq/0lyrZilMeWDCxEmzg959hSVW+nVEqukw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UrDcPY7YzmGhOr14uWzw3XgnwSDqOtysrPjjKyqxfFw=;
 b=n2UlAJR5tqm+A0hua1WKWxOndrIFNt6KrIvemJAkp3XRBOjikngelWEEVa6YbDnJ5HpfRTF2HABex5oewXnzoxb34Kv+NKazwA+r+FuE5nqm4xCUGDUtR4ih37ZclIHIXvaDvIKM8srYS+sxLkmsIk/LPqo4U74pwDqmiScNWU6g3Xkk6Bvey2TFA83JVHmYAAq7B/gLj5b0DC/PWFBAP87BS1jbuMhUxzTBwsJi9cdnnyiZXkEFNsaBXAI0WSUruz5oam+7YKYzrSZhyrZ72Kp/tkQs+6a5tSmDeGuZK1NHFV5k7Dz/p9EWx/v8ABTbpOJFCQQW4v5MYRKejnz6OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UrDcPY7YzmGhOr14uWzw3XgnwSDqOtysrPjjKyqxfFw=;
 b=V9sr3Z8MgJfy3nn0VGfgeHZDBExHh0enHMiRTPct5yJAGqEj4fi4aajcObWC60tqhARw3xn9iDakoYovOQ3drnLytgdM+oz2CzTdsD8pSdihSca9Md3NWUsOSYmCn5WSh2HfEeuGVpZgpOC9V+o7tdI0fcGRcr0ujmFRWmY4uSU=
Received: from IA4PR11MB9278.namprd11.prod.outlook.com (2603:10b6:208:563::12)
 by EA8PPFC9EB5D15D.namprd11.prod.outlook.com
 (2603:10b6:30f:fff5::799) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Thu, 19 Nov
 2026 11:26:49 +0000
Received: from IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057]) by IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057%6]) with mapi id 15.21.0615.009; Thu, 19 Nov 2026
 11:26:49 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "stable@dpdk.org"
 <stable@dpdk.org>
Subject: RE: [PATCH] Revert "net/e1000: fix queue number initialization"
Thread-Topic: [PATCH] Revert "net/e1000: fix queue number initialization"
Thread-Index: AQHdd0fufC6+CSWezkyt72WnjLQOQ7c1QvLg
Date: Thu, 19 Nov 2026 11:26:49 +0000
Message-ID: <IA4PR11MB9278F10AFB677692B12034738E792@IA4PR11MB9278.namprd11.prod.outlook.com>
References: <20261118102927.2679783-1-bruce.richardson@intel.com>
In-Reply-To: <20261118102927.2679783-1-bruce.richardson@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9278:EE_|EA8PPFC9EB5D15D:EE_
x-ms-office365-filtering-correlation-id: 11d03067-73eb-4344-8568-08df463000e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|261009223027099003|261022105027099003|10067099003|261021123027099003|56012099006|261028144727099003|261026140227099003|261021121427099003|261102123227099003|11063799006|6133799003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: 57KAlXEYcdFkG62fB4vq6/Xr92oSMGmyYRrxLk+kt30jBQlzPzr3aNapFF90qRZRjJ4PE4agh8nqdND9OReeYpm2+V3Qi1ErYx74SNrBCX//Vq89VHwk4HBQmfdRHrcsZjo+szuRXIy/HoqVCSxCBIEaQ4YeSqnyTKe6y2OW5jgEy3TkCjCsK/0NAyRvEGS2oNuoBjJj65gkYMozqBca9culWAhNectuiG4mcUgKwOgC8lqA1y2tZm5rz8xNmvntUuytX5bmQ0m4E7u5SNxLHaD7BDWMYIKTUAXlTHuKz8pi1FhK6ECUwooP0vG/kxFHaqS9Ma/98bOu8G0zY+5KqzSmqs9rnNmW41I82NHDZR0jlJjhVpsIjF5RuXsNNAhwykaLoKGFljlkf0gCr4484duTOGEF0aECSZe9A3mSMLtkWw/u5VmV84USK6irThXF8oYgBkk6LtaKnJDp2jWhzJ7nqAuWAjS71K4n8btWG/9jbDSLz0Kmi4rcQVkxRJtfgqqKCOgRCmObn9bKtREUz8JeGDowthy/9U0HGBaC5VgLUfUu6UXQNzMbqyx+DQhB8CK/cdu3RPdQf89XocRCOo8c9egfWZQSdKmUxtD6uRD88+csvpe4uyMJh3Dj/Glc+fpbtOZWSal4LSgvEQuMIJ8ykzEXpJ629Oqzi4x+ogvZgB8FZflsBegfZeVl5VbcChkR7TeO7O9sl611IhxuUA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9278.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(261009223027099003)(261022105027099003)(10067099003)(261021123027099003)(56012099006)(261028144727099003)(261026140227099003)(261021121427099003)(261102123227099003)(11063799006)(6133799003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rIrlGnMQRY+JZqrrR9UHwzvOrFeliaXnqKBGAJeSkIE2VKakvNPiFVApYOUD?=
 =?us-ascii?Q?dQ6+KdTo9+sMLYC+q0Zv9kFCAihOw1OiQ2ZkbCr28JCw+QkXGqoaZusFzlJI?=
 =?us-ascii?Q?zW+rs8bXMSYPbYrLEVBUhtpPdpqlK0nhCiTZ5Sd30KeP2oi/KaLFsdIWeJy2?=
 =?us-ascii?Q?StrSIM+yDLnF6cuhGh5HjWJzqyCJYBN22EntAb48fz1WxGAejcmO0NOX52nt?=
 =?us-ascii?Q?zCBIzx/VgBJckZzgBkJ2da5SIXym4ak9afQDKfxk5vmAbk58n/Xx6SqlemcG?=
 =?us-ascii?Q?BmNnbKuELJ/0dH6i1z7k+SrtBJq2BFZzc3Jn6HNCCzAGRcujSmdjEhPvJSJQ?=
 =?us-ascii?Q?QXs9YkGe4vVZUB0H79VJldxCsNmtKdevrWNHDQJHrHFgULPiklQ1kzbiZ1Gl?=
 =?us-ascii?Q?TfKyYg/CtFZF7r8qUb/3H8kwd1hXWqUBprYDZJWjXxk+iYkMOTOMm5qVjszh?=
 =?us-ascii?Q?5fwO4cmRtmDhU6ifEVjUW3iU127Y3UAlf2t/c0Wx+CHHX9aaL0EuaIaYiByx?=
 =?us-ascii?Q?f2POy9WnoUAPllQCoiY02q5BUdI5yXcWs8fx1g4vI5JTB3I8qPyUmh2RFN9Z?=
 =?us-ascii?Q?oB+vPAI0PpUt04/lc/KaURRE/OhTFRCxnnJsXHLj64xTyN27xdEoXuUa8/Hm?=
 =?us-ascii?Q?grahO59H8lncXpSP8eKY2kHtEHFQohB1f2IULLl0pdVxvmd4rvVRteL73/sk?=
 =?us-ascii?Q?3j0K8cWdXEhZJNSgj+xQHh+9oWvOIuiol4bVifgDj06BKtXxO93fZe9tkNz1?=
 =?us-ascii?Q?vmgXkif6zkP7a0aK6dhrpBy/TC1GsfYp0kDsG7Wav+ubI2wfjkzcBHullUWw?=
 =?us-ascii?Q?YaYFzdOSunS0jrJKO3M3DNFaZz0DdBgDmVUemEViVSci/LFA+rE/spLCzM05?=
 =?us-ascii?Q?QgoXq4l11kUGJhzjkJBVe4lopBo8l6uZzMVfuYjCFwLV7I/9AjJMgt9EcHBp?=
 =?us-ascii?Q?bg8mnPm++9sFZdugjWFmyFuFCacXfOzhuGhY4GA5y1jk6mxxN/Bg9sxyHAjm?=
 =?us-ascii?Q?uwc7lGDCJJYUm6lBwDHwJw883OTcK6A4qp22UJyx64vRy8EVPyTsVE5URTbN?=
 =?us-ascii?Q?0bXZsUYl8kiKGw02qaBSXCRGyYdlh4wPC2Y5mGgCSot1VPIrRk/q6HzFGCRv?=
 =?us-ascii?Q?ldGvBrNVwKl0Rp5DfjlwfvzdUPtqIH0yNtMQRL3NNJqiKk+KenLSaBMj8HeB?=
 =?us-ascii?Q?yHmjMHQBY9qUNxOMIZWsieROjwd5nGaN5t6H4BALqd1KefkuppGTZ5BzSab6?=
 =?us-ascii?Q?ieqlsAHppxB5qLD5dYd4LafzJyzh/6o/9XDpbe1yRAqlJxMAy8PRIEw+Galf?=
 =?us-ascii?Q?2nCnawyLvn5uZQEPmzflCABD/GQARPdgwPRoravwCiMXBpzcoQ3Cu08fh3tQ?=
 =?us-ascii?Q?dgxGVdBxUg6X9TNN6JvcKGZeBwPECOsDTiF7ucUh0ghV+Uh/BYCVrGevNnrh?=
 =?us-ascii?Q?zvqOWv1Ng5dKNeHCcPKvfjxiyVqkecYQ0ZNSY2/xie3qIQK0h0qf8KKd5E/5?=
 =?us-ascii?Q?193xP8luew2fjU5WRkiYdTCFJHDeUeTQfke9t++dt+rgDj435RRJ/IkaWDj6?=
 =?us-ascii?Q?N9e+LAA3rqyslIaD8g2/XcOZNEyBaLLAIPq19tj4KIHW4XX5GhLwfFLbjP7y?=
 =?us-ascii?Q?LkhFYJfMijFvOPVm1aErzKFoazQwjQ88rnwLTCaVzlcS6X8cBP7gjkvA8FDf?=
 =?us-ascii?Q?v+P+tCCrRCpKVQCnxq5k1NBpAeVkoHcOkv7pG82h42yY8VVFZJyQ1gm8heiG?=
 =?us-ascii?Q?6Qfy2YLEMg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: NVUdJXiy5hfi6cr4kk4I8DBou9U7TpUkAZBB8wWvz3xt1k7P32fQZW1JX2Q7rPpN2oV3NoPbDA3sxBl1qEvLHDpOpYDy3bO/m6HGU9fDFekWQCQhsiespnED319S9WGV4ZeMY1HvPe1FhE+ZSQ7RwRRtCZlEMm/ZOX5uX4H85mjM1K56T8XPIppPmaGmrb5FbDTr++WIGSiHxoNDN/Us22bv2Fvpzx8m8FqeaM1LdHiPuqrTaMy80YGqmzE0DO63ilKGmXEpDR1C4uIH9Q3h0Kfevfki3jI5CtT2SZL2AuKO9MisQllmd43oqAx98095lNpQfpL3HJuUxgULiSHHlQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11d03067-73eb-4344-8568-08df463000e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2026 11:26:49.6812 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 68vxdzI0RpJqi6Nj5JrJI0r8cnT1dZuKRHvwXwnzzafjT9OrlWB6wewetGuWQUPuvVnqR9LkR9e+Qnkq5wFdKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA8PPFC9EB5D15D
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Subject: [PATCH] Revert "net/e1000: fix queue number initialization"
>=20
> This reverts commit c1a42d646472fd3477429bf016f682e0865b77f0.
>=20
> Although the hardware supported by the driver supports 2 queues, as
> explained by the comment in the code, in practice only one queue per
> port is usable. Therefore, revert the change upping the queue count, and
> aligning the code with the comments in it.
>=20
> Bugzilla ID: 2147
> Fixes: c1a42d646472 ("net/e1000: fix queue number initialization")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Acked-by: Ciara Loftus <ciara.loftus@intel.com>

> ---
>  drivers/net/intel/e1000/em_ethdev.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/intel/e1000/em_ethdev.c
> b/drivers/net/intel/e1000/em_ethdev.c
> index be830881db..80029aa87b 100644
> --- a/drivers/net/intel/e1000/em_ethdev.c
> +++ b/drivers/net/intel/e1000/em_ethdev.c
> @@ -1220,8 +1220,8 @@ eth_em_infos_get(struct rte_eth_dev *dev, struct
> rte_eth_dev_info *dev_info)
>  	 * To avoid it we support just one RX queue for now (no RSS).
>  	 */
>=20
> -	dev_info->max_rx_queues =3D 2;
> -	dev_info->max_tx_queues =3D 2;
> +	dev_info->max_rx_queues =3D 1;
> +	dev_info->max_tx_queues =3D 1;
>=20
>  	dev_info->rx_queue_offload_capa =3D
> em_get_rx_queue_offloads_capa();
>  	dev_info->rx_offload_capa =3D em_get_rx_port_offloads_capa() |
> --
> 2.55.0

