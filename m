Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105D7C624A4
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Sep 2026 12:58:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB8C8402D8;
	Thu,  3 Sep 2026 14:58:34 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 3920A4028D;
 Thu,  3 Sep 2026 14:58:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788440313; x=1819976313;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=iuJdMHIbkZYI1liNUQREq51nafKY3eEE7DUxFEhLIVk=;
 b=YZ6LLtzS71McWRo2BxyJtYRVq2zzvwDmQeLlYPIrndc1c4mJ0yeJeCFn
 0wkWFNz031al2B/OmDFjE7u6UF8Wfh4GjJ4GgeHHzKBfTDErxao6zBS4J
 Jx4iUivGl6IizFlW+djLbHQZq8FmeWhDL2yaMi+W7NmwM9h5KKEpOhLKs
 +/V4H86qwC6RMyxwOiswOkiiJ1fhF2fasqA11Zw68x1C2X50UsGzjI5ku
 wwHxDCBWDk82vfhvD75FsYBNeMCS9r+mIs7qXtBt3xSeRQMX+3g5MgW6R
 V8tQyIToxZ5mSzVNH4/DgzbgwxniLE9/FfLy/FuBFZEGOBi7ZtFh6XFJO A==;
X-CSE-ConnectionGUID: nYACCIJwSjmQasGlVhHxVQ==
X-CSE-MsgGUID: EG1toBkER2iAFtfvvZyevA==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="87860195"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="87860195"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 05:58:32 -0700
X-CSE-ConnectionGUID: qmD6Hnr8R5KsNVQ2aMSzzA==
X-CSE-MsgGUID: B4ayG4THTui7aJ+nYKgKvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="268398445"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 05:58:31 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 05:58:31 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 3 Sep 2026 05:58:31 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.67) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 05:58:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P/8GvYlz+4ye6F6VipzBemYZx+dZrYmd9ANsC2AW/hbNwxKK+jMGm3tMI2li/KI9FEXq1mZWCM3igVl3ieuc3Z+bY4Q4bqUuO9zQew4KH01FhRUSvkuHKki/Y+1af8mZCif3EOX4bohVtTJoXl5wWgAYhT6kUKx7N3SzEPD0c7eCKsZ034Rpi8isSI8sh07hmXZjhAAk67SLqKmcLN1O1fdazQ3VZkjI5IV4GS+3LxHGuOXGcz4nADgoRBd5A+HRbjAOy4naR7AxMDg+7hxd6CtzR6J+m/P6huWkcsd7iB+56ekRJuSq2FW79sw4lDi2/ZpmGt3abntJbjveybNFTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s5dNBRDGqlqfg8y2dH7698auM9jxonB/5zed4xVORfk=;
 b=uKz63Py2WFK5O1HmqrC9RIc4Q5wZ7KOA0S2J1ZgMYyUnYU9gK0rF5BI4I4ktIVQgHF1w1ELG9DNwBhDdChA8dT+s9tOBEGjzRUt6ioHrwcqm7KJUPBhRSQrS5fVMswL+nmVW9mA5rUwGlpICj6Cs5GITyxhOyXyEioW7iW9lrjc8HyoAj1uY9uHUfP2UHxTvjarBWsb/u4iMtzaY6K78wpMjyw9tSmDuV2cM9rIKA+2uuaFdk2dsaUQ0IsiJgnao4YPaAQmMAE4Qa0V4mQK7sY7mltZAKecXq3n2NsmLZ8jPwDYRbTwCZQVEd94PjvEQH1PmKEbahB+ZLf58PwsIpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA4PR11MB9278.namprd11.prod.outlook.com (2603:10b6:208:563::12)
 by SA3PR11MB065283.namprd11.prod.outlook.com (2603:10b6:806:52d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 12:58:30 +0000
Received: from IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057]) by IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057%6]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 12:58:29 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "stable@dpdk.org"
 <stable@dpdk.org>, "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>,
 "Mandal, Anurag" <anurag.mandal@intel.com>
Subject: RE: [PATCH 3/7] net/iavf: fix VLAN outer TPID setting on Tx
Thread-Topic: [PATCH 3/7] net/iavf: fix VLAN outer TPID setting on Tx
Thread-Index: AQHdOTNG6tSjxyewpU2vOm2CURJJU7a81PAA
Date: Thu, 3 Sep 2026 12:58:29 +0000
Message-ID: <IA4PR11MB9278A14D684FBDBF1A138F158EB62@IA4PR11MB9278.namprd11.prod.outlook.com>
References: <20260831102621.495759-1-bruce.richardson@intel.com>
 <20260831102621.495759-4-bruce.richardson@intel.com>
In-Reply-To: <20260831102621.495759-4-bruce.richardson@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9278:EE_|SA3PR11MB065283:EE_
x-ms-office365-filtering-correlation-id: 372353d7-2d90-41c0-5d6a-08df09bb0d73
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|56012099006|38070700021|11063799006|4143699003|10067099003;
x-microsoft-antispam-message-info: hFuVXiL5xeR8DYcwaa1ud1n7sS0msJHx/mEyuQb8ZNjelH4E2CernhvmGti9YhdoUmeEMiJ+YEUNrx84bRcoYeuuNt6UmUqFKxPHcjhyMm4ReKU2ZF4lEji2JLprrMnvc4Ir2aoeuiGPq0oxxqlMVNPP2BrrgDO21m2P4byUbLx/LnSkXGF+9JPMD7KlY1MkNNgfL7Y2BJJzIJc9DPtPm/Jx+5aVDKftu+3Dc34xOwTwz2nSIJVBbhnQ5/I5d4nAyjYkIvNjZ/KSnVLt5gGZM6afFwSSLUtJgudxfmJVPvfWabMhEQGAHyiR8+hc12OZny8Cg+bzyXOfXR2VRkqS5Uy9uYLq9PN/dy1UioTUrNqjzjKON0QjKM6TebB401PTRy+MqzMBdsbvdCQfhb52C3ncO6et8L3ntrKJ/itHuNN7ygmAcX+jLafZhYlR58dC0y5CqlvmYqZah8BRYNxcM2Jagj5qU1zPvVckA9j/KlimCFdn+a3adCkBEkUAL0iLBiff/sjFNJW3sB62BEf3Epo3ipUjmOspWXbGmmSCEDoqXN8NHT1K+r9VheX9Xhh33fkzEsmG0CO3fPU8H/9Qd3zyAulTj8I2TcJId1A5VxMWaDg/7UXL7164MGutITt3a/ll0pMas+okSURddOcPfrf8yqEXfKTEVECP0+0DcbIOuBJwaMQ44T4ow3+r7oO2JxoWH5I4h5LvaaVX99OIPXpWKMc7sVaNedsXx6/+r68=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9278.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(38070700021)(11063799006)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6XXq/lTh84ZiANF2Zv9riXzp66A4Urwm885J4LtfK3NvQAh1MS1mOu+CPb1e?=
 =?us-ascii?Q?VRXFCHKdVMXeGh8daST+UoP5HgTZAWLi5Z8/9IlQxLMTWe/n+O/sIL7ww+5K?=
 =?us-ascii?Q?FR4/Mkr+gQ1SYim0nzHwWH8JVMqOHlhIyncyNgy0OdX4ERz1OKx9Ejk3/mQ9?=
 =?us-ascii?Q?ZchFENiD/z8eD+QH0mMbJ7qfv79VWxWGcIMuwtPAV4aia8W7Hq1chGJg1kt/?=
 =?us-ascii?Q?yTsNuRg8ltBs4BNPE1wQO7oPdJwg6XlhPTf0ciQ99NCs+Xko/WE4Z8Q4m1VK?=
 =?us-ascii?Q?/F270H0toCTtK0iS/HxS7RMt+mTPkV0H//gcEATPov6gdaWwLMeGvxuR/js5?=
 =?us-ascii?Q?rchyCQE6Df+z0YHDYATgadwQoSBucfbkGxLLUo19z1i/zR4BXV5uCsF9rrvM?=
 =?us-ascii?Q?fzOv5oqLTADgp75RIN0Fh0qIiX4JFoH52/Dtvoa5yGyGaZYGnNUaH8PoReef?=
 =?us-ascii?Q?4jAFhY8y6KYVJPPnCP8GkCi31HEWiiBaKsEFh5hb3VRtup7HsdyrZcp6QO2B?=
 =?us-ascii?Q?ThoojjQPNmBnDPyRd12OuQN9mcHFBjO9zg4jKd82oMhqaZ1Leu7k6SnROeRG?=
 =?us-ascii?Q?M45Gd3Qt5xrd38NuzQY6EaOL7GNbG+f1Ys9eeojgLnU6uc4C/9CWFS69cigm?=
 =?us-ascii?Q?wC7AdAjHm8cJkCMq4wm1GkImcONyHqSVQmcEhCrungK4rSA+gABZnimhESNW?=
 =?us-ascii?Q?yCEdu69HWemTe8/2iEGbqhkPM2pKFmSFpAvVwg3OnMKmE5sa9zXY9Xac+/sv?=
 =?us-ascii?Q?CiAZoHbz0kpYcFmN+ATwr34eBkR5i8hAW4T5t/cT2es1CAvs8G6ybINmkYRz?=
 =?us-ascii?Q?k3uOqVHzua18vCZrvY0gP8LhZXP9fHGxBtdst/SWHoCXj1MVkl8anpFpKrgr?=
 =?us-ascii?Q?rhjXmSGVoJOhTMWpUvk1p+U9C+D8JRVkfubFaDRV+o8uZ+o/xwVWKCLtW/H0?=
 =?us-ascii?Q?DHjCmgR7mHUV7wxGYOEJjLfD6y1LKajXRnTq5jmtoDYaB2VKu8aTnWUm1Tjd?=
 =?us-ascii?Q?nkBEx2ig78l4vnLvwmUmkCYuFhiePjKo1/oi0N0szeMbGTbhXGGcthHhTB7T?=
 =?us-ascii?Q?ONnnT1Oa8iNcsfwk9ApBkq3Q8YF+lYcTYO3KNYEUZo1Bb+MQ1zAD+YTAP+L5?=
 =?us-ascii?Q?52AkNb22Aav7rXRaOb3tinVonr5qr1WmAr8lo+6pv4VgAxmsGEdRZVFoopSo?=
 =?us-ascii?Q?rlWDAyxD4K1kMtEYTFKc0ins/XPaCdVzQUoCOggunElOKnS3Ey4qdfAwNWqJ?=
 =?us-ascii?Q?2UJbgvvnuFLBeUULCLjAyQDE+zYkKNtoUhnLljg5fwSOTL6WDc5Xnqd9QXAP?=
 =?us-ascii?Q?WSvlFjFOnk7pK3xYQkCUflOjtJ6vLEJj3kZDm1UsluALyQRd5Nf0l+DC3E2A?=
 =?us-ascii?Q?b2dsfoa2qW7Vs3yk/3hzc+lsi/bG29IJPXLfb7voyzOAbpJlNnMFA1Oin5GV?=
 =?us-ascii?Q?OOx3DonqBbVrUbXxPurLW31uEmAiZ32c6jcKnOgOnRaWjvhpiqVO4/Y+3B+f?=
 =?us-ascii?Q?mQVNsx9NoxV84kI9FNcJ88mNm4S+tNIfdtdDmPoiHh4in2jygT7+6gtxcNk2?=
 =?us-ascii?Q?Y5AHV3t5m8tW6D74YLm4g1jaKbu0AxgFe8Qk7Ziqp7gugLPkRRuFRaFdI7xD?=
 =?us-ascii?Q?VsR5c5YxPnn9WwYMbvCfnQlS5wLPUAAhebSoG406B/xXP+AmPIxbI2toSWch?=
 =?us-ascii?Q?A782oghgbxRBNAvORk5IECAjMQkRWOC0yUVFH9o0cSSZKRKr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dIV/TYgzJfNU76CxxLKvlIdurD86oAWclgKNH/KFipMphyoLruVLkWUVRHwLEZy0aZH8ih6BhBM+ldFwHiYTTEKmG2ggDoQqL3SzjOXpce9LtuLNWAyXIpB3XeMwpg1hpBXs7C9U4o0Z81NeX//6RyDI3alRor3zNd0Bp2jsa5K81td1VZb5bGjuZlYBwfRfs9wDgpNkBLpTOSKSxuu5xpHXmo4o25Y1QDgi8JI7S+CCk1HUpAoMJgkiKialB3A2Jf8iGdpJELxUGpfJehAEKdZpZtG37g9Kkq4lG2QNRHkbv4pFnnA/mC7JUuDc/WCjiX9tIomA6gMMncISTZB7YQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 372353d7-2d90-41c0-5d6a-08df09bb0d73
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 12:58:29.8698 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tb9AHGiWBkMmaiwSonJ5K0HFKdfVxjDJxwlv7s0ctYCve6+lbJv4dI/RR8HePO7xygYNjQlHrYKfKib83EabNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB065283
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

> Subject: [PATCH 3/7] net/iavf: fix VLAN outer TPID setting on Tx
>=20
> The outer VLAN TPID setting for Tx was cached in the driver but was not
> properly pushed to hardware (via PF) when changed. Add the necessary
> push call to the update function.
>=20
> Fixes: 8599d7604e0a ("net/iavf: support QinQ strip")
> Fixes: 7ce1363b424f ("net/iavf: support QinQ insertion")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  drivers/net/intel/iavf/iavf_ethdev.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/intel/iavf/iavf_ethdev.c
> b/drivers/net/intel/iavf/iavf_ethdev.c
> index c4a6763f28..126be4c9a5 100644
> --- a/drivers/net/intel/iavf/iavf_ethdev.c
> +++ b/drivers/net/intel/iavf/iavf_ethdev.c
> @@ -1461,13 +1461,17 @@ iavf_vlan_tpid_set(struct rte_eth_dev *dev,
> enum rte_vlan_type vlan_type, uint16
>  		return -ENOTSUP;
>  	}
>=20
> -	/* This API only fills internal iavf_adapter structure
> -	 * and does not send any signal to hardware.
> -	 * Inner VLAN always 0x8100, so not set explicitly.
> -	 */
> +	/* Inner VLAN always 0x8100, so not set explicitly. */
>  	if (qinq && vlan_type =3D=3D RTE_ETH_VLAN_TYPE_OUTER)
>  		adapter->tpid =3D tpid; /* Outer VLAN can be 0x88a8 or 0x8100
> */
>=20
> +	/* Re-push insertion, and stripping if already enabled, so the new
> +	 * outer TPID reaches the PF instead of only being cached here.
> +	 */
> +	iavf_dev_vlan_insert_set(dev);
> +	if (dev_conf->rxmode.offloads &
> RTE_ETH_RX_OFFLOAD_QINQ_STRIP)
> +		iavf_dev_vlan_offload_set(dev,
> RTE_ETH_QINQ_STRIP_MASK);

Should we check the return value of this call and fail if an error is repor=
ted?

> +
>  	return 0;
>  }
>=20
> --
> 2.53.0

