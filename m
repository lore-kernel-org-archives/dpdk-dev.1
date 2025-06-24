Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D50C77B7C
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Jun 2025 09:19:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B8224042C;
	Tue, 24 Jun 2025 11:19:44 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id F360E40264;
 Tue, 24 Jun 2025 11:19:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750756782; x=1782292782;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=/FqGjw7M5L5gtv0iXJQrfCCYIlJPIlDSf/4g0wkdJgs=;
 b=YAxiyCyl38q26Vkew//fPjyhktJdxcst83MYaNdqQfgGQno08/FFBcK/
 /7hu5tGrwABLml1Gcnwzwsio8iSL7pDh3VIvh6/EW7O22ofRf04PqGI5M
 GfqEqbb3gN76nlQcC0i4FhLSBNDppZU1HHH9Edsaj3BPyjU3wdCflo3Rw
 jGhQ+oIE04tsxri35sthNizRft3MsoAEZUgpwS7Rlz8amLtHtUvQH/u7e
 rwiT+mDhjnx9kLMAYpNLdSlMfI0CX1rjb+fXapIORq9ksQDiwHz9A1eJJ
 x5V8508TnfSSBO+oeXUPaL9UlpzY8vNhG+aJofIEUYBDmLVbHyZM0Kmqu A==;
X-CSE-ConnectionGUID: NR7nP3J/R7CEgpvpjQVQdQ==
X-CSE-MsgGUID: hMOqcB8fRLmQCKK5NhKheA==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="52217169"
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; d="scan'208";a="52217169"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2025 02:19:41 -0700
X-CSE-ConnectionGUID: h0EhEHZXRAGlUtDkd552nw==
X-CSE-MsgGUID: cPSQXzk5S+GZdEzhz6U8AA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; d="scan'208";a="189058131"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2025 02:19:41 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Jun 2025 02:19:40 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 24 Jun 2025 02:19:40 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.73) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Jun 2025 02:19:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Khyd9XAGkqYQX2qQzh21htXxEkU0ss0TvKRqE85NYKXKf/Qz59GZiNGsi3Jkrl+X4E7p9kdoNhZvN1UPY6jXJT+jQyx/08SAAW0+a+BCbBhSLZAuvQz3uij28IjRKtpuyqo6yO7fkTgDYj7qY+ojFVqYe++Ja81HrtSuz/hPAFaDKj/3pgWBe69LDKXiUTDUwe6VeK1DywHD8jmiM0yN748rIf0cC9yHjyX5sOvDX0MnJEGe5SQA5jrz6Cf5XRwQLaw2lpI15Otd/A9QWiwv3o983y88jAwmbGItTLvoN60+kahPJB2i9wu7PNdnfmrd2/1Gn2/x4v9yzV6/cAqFNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BE09lVGkqYcs8vcacj9BYwuVsxXGIoTLqaYBUoAX5tY=;
 b=k8rnsKbMDpgxR2iTYewWe2qUaYSZR3FI92zo0Na62n2wOcyfxVsKzr1sFNM3idhiFuTuRPlytJj0APkV81F2sDgCK3Td3VCoD04AVVBAbBvWoXj3LuFuIJs3JBPfW2MwGx+ulB8C2CSQfrHp9CryeNl4e4n4AQJckUMxioE12hKFkr4DZuBxEo+2Y4EBANBdUBJByYskYnA8c6Zml0lD6Iue7zE7/+LGdTleWFSwbWD4qwZ7OyO64Do58KmlyXLao135wLp2A17UoS3Kq60zDEdFbyrc6VJu2SCRFAsgetaebrfLWaWZvg2/1x8L2AUMR66v+N6Poo1K7ZL16FhAEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f32) by SJ0PR11MB4798.namprd11.prod.outlook.com
 (2603:10b6:a03:2d5::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Tue, 24 Jun
 2025 09:19:09 +0000
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::19b1:dfa1:9d1f:38e9]) by DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::19b1:dfa1:9d1f:38e9%8]) with mapi id 15.20.8769.025; Tue, 24 Jun 2025
 09:19:09 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH v2] net/iavf: fix VLAN offload strip flag
Thread-Topic: [PATCH v2] net/iavf: fix VLAN offload strip flag
Thread-Index: AQHb5Gpb7TXAi/b41EmOaR4zKI/ft7QSB/tA
Date: Tue, 24 Jun 2025 09:19:09 +0000
Message-ID: <DM3PPF7D18F34A164D75E69725459E97CA98E78A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
References: <20250621015624.35284-1-amiyaranjan.mohakud@gmail.com>
 <20250623181136.48239-1-amiyaranjan.mohakud@gmail.com>
In-Reply-To: <20250623181136.48239-1-amiyaranjan.mohakud@gmail.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF7D18F34A1:EE_|SJ0PR11MB4798:EE_
x-ms-office365-filtering-correlation-id: 549ccdd4-00d6-474c-e1a3-08ddb3002d2f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Jafbna+0NHbn26FhDJhdxyvT8Ban8mj9t/Ji1pRpSonmC6dQUFbhZJ7vHFSq?=
 =?us-ascii?Q?1xTMhiMN/To/dewBxRYs+WZgRudIRkClndcSkpSKKxDMNa3xbXcJOgWTPfW6?=
 =?us-ascii?Q?/KrQDn344hnnS7V+MTFX7Z/X3ILUWZ9jXvgi9o9U/LsUKwDshj88if1xiX7B?=
 =?us-ascii?Q?ttZO3US6G8imKEvKP3k5j2oY05fmBdgIYSgoKzQ4BPqYhXT5Xg1e7BaEEH/9?=
 =?us-ascii?Q?iaaQAfIhHrYMyouWWX8mER7FWwxHsb577vpCC7F6QKXsADD/ThiQf2wV7YGV?=
 =?us-ascii?Q?h3e9iNggkF/K+hLwRrtXW/ctSVBJ+hRTNi/TqEji377MhePqwqHtyhML0o2k?=
 =?us-ascii?Q?yDq7BV8XFu0lVXJ9cdE4EjlG+pxajvIsd5pqCCoFcu09tWZ537zBFXOdClus?=
 =?us-ascii?Q?bdjb6PlC73+4GWkvdHzYIBd8GDwreJ6fo1Fir2vbV/fgl7EpxWMBCgrnWkIs?=
 =?us-ascii?Q?Ld8igBldmJ/JfS4shi41wmQofYYA1sBdOc0nmgqd8Mg62ialQbZlNnZXxRNF?=
 =?us-ascii?Q?4P/28p6zGEu0fI6AIGz3Bb2LF7BKWSFYb4cUNJpWUMYmT2ZbUoY9khfyk1TA?=
 =?us-ascii?Q?tUz0bAbPg1e46pcdmKOau5E+tMaVB/Ik3ncML38hqD9zcIwd7SCV2gUpwB0o?=
 =?us-ascii?Q?Ynv7wR7wjSdA51UTlL+zgrok8rKo14LgkmbfZhPadBtkWrq3PepMX6jDecDn?=
 =?us-ascii?Q?9rO+uLlRr6xzYhrUD/RL+f8fTO3YlOIqHGw4Jv4f13GJOueurLxN+pC/JejT?=
 =?us-ascii?Q?nf77so2s/ye0QQNZs0XbGqTEUSvNnhKbXBB/OI5ryfIq4+SS6ZpIzguxRyxv?=
 =?us-ascii?Q?unmL3+LN0tIQKOc3aa8oMUIUJE4FyAdITmWlqjIgc3+23kWVOQZ8C9W9SWRH?=
 =?us-ascii?Q?or90g7FE1fyW+g+Q/qdzsTn6jYzH4ewi2Xzexq/OAnlseo+xJxDkRE3oaTlB?=
 =?us-ascii?Q?euoUNeDfePVlQob+LZoRaPDwnLEP7urcf5v1UOrBkmGD/Z+dA5GlokwSONGs?=
 =?us-ascii?Q?13m85HNkCFOY6+ODOSpkukSHlYlu0/ow9RwFv3HHPgsAdYQwcwmTjuZLbYJQ?=
 =?us-ascii?Q?bEj4MXR9m6QSuPzljw19/cr4eSmTXW3WMfFRloENwu7vkNw66E/xpzOD6GdM?=
 =?us-ascii?Q?uXE3z2L/cxYrcq1foSRqUKOFWlYX2bRS2SzpFu8GK8M3EFOJBErzE/SFT0q9?=
 =?us-ascii?Q?tF0ocWllg8LXEZ7UzqAmzus7PAeMk6GIE/y2C8CYNqyDDYfl2VsRRFamkaWt?=
 =?us-ascii?Q?FL72Jh0/Zx8t3wIdUj+d8D99h0R2AMLUHr8UAeltn9FPtaPg5+cO2hgYm5EQ?=
 =?us-ascii?Q?TN3eBl+eskCIKyGkOVQ1rbMfvUNNN/uDgLIwJP4d3FMl8vaxBhrOHoNVM+BW?=
 =?us-ascii?Q?GxWmSTWojJOUzaH4DAYABrNGolMPz33S654FjFVVepYjT9GkpJhdop5G9y42?=
 =?us-ascii?Q?KLjHS8xFE7Q0LOSRpeDcnIR/WNI2jHjynTLArempe82eziLEhAGEmbxBOR6z?=
 =?us-ascii?Q?eh8JfZd8PjPViIw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF7D18F34A1.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dkzyVM69DNtmxNaeIvgRCG607RI/kNVsmFDRMpsSHpSm/qyaABsisQ4SNO4l?=
 =?us-ascii?Q?kfFeGtT8zO8hxLFiTOG5/DMcRuFrwr2ncbGgvGNQzD1n4D4Jdl7ErmMPjFfL?=
 =?us-ascii?Q?EzPxzwxFhFprcvUZxzKtpn3qeC9C16e3q5IoAawPQS5LYXlKh9VX8Zc/IHnA?=
 =?us-ascii?Q?Xtx1YgM6SMG/g0MLOsqdyqwPzrhhGoDmcG1/UbeKOgi5KF06NLgO4ccDnBGg?=
 =?us-ascii?Q?uzjaTUtQJ79oN/7fEKMldWbn5AMASsLrL0eMfHxes4LKegX44b5Tfs1fnTKg?=
 =?us-ascii?Q?gzRVLEm8nnUPlW7i00OiqYnJTBeN/OHeB14VeJoJPeg8CHBGbFidyDucNxVF?=
 =?us-ascii?Q?SCySgKC945xs9AnE/o0Qio9tmaig1AK8b8Nw+LD1rpmObvANNXgX0PjLHRDy?=
 =?us-ascii?Q?PDJ/CGdEqGO1G45Wb5j1WylMOfYmilUavHo86m2ZSMQjtUkg1J7aDhj7y6l8?=
 =?us-ascii?Q?2i5kwBpFiuF+kiGk8get0tKCfyCT4Q6tlHSJpUV6rjNNFZke8OLCxVYdOxib?=
 =?us-ascii?Q?+NjLm9ccUqjXdCjvixdvO4IL2ciuCmh16/1ePbpsRnU6BhOo4hayPnLAHuBv?=
 =?us-ascii?Q?hOVzkUHkZXWFdK6sYVaVkXz3baUp3Q2reS00Vgo5qDnNqmv9K74Ehz25K6kB?=
 =?us-ascii?Q?H5bCjxjD78DDAjVoyRm/OPXuV8+/7D10v7D2z+dnMBPd9YlPtROmT6NqEr0B?=
 =?us-ascii?Q?IPB1kFpLhfgxJ/H/VMoSRxDht1U8c9Z8zh2xEp7ftrLAcqcFJvMyjr1013zt?=
 =?us-ascii?Q?V5Tuwfze6SjsLUr2y1jRQ8cvJyVILfp1gF9D1IjOfLIFkWKXzqA5LcVSqozr?=
 =?us-ascii?Q?wyF6dhUpoy325nXHoJQo7jJB0I433iMe1D3F/NoLIeYCD1frWBoSUpayl+rq?=
 =?us-ascii?Q?2zVNgiJxfQcy7lUpCOoEaSDg3bYEssO1sXkwyQMNvH8yeer1NKFG+oKHdbBq?=
 =?us-ascii?Q?VDxIz3lbGnIotnDzd9yht0PNSQ/M+ryVjb/THh2imsYjyxMnefPyGCOxs4fU?=
 =?us-ascii?Q?DG0H0cMqE/LchX4kV+d0PlR0KCCb6IXBw2Xwt7TDJ190gQdhnde0/swFw7s9?=
 =?us-ascii?Q?t3Jpll3M8Qg5zwLP0Nc7EDOQNXIZdvVQCLHKabtW4jlpWZElkJy1tn+hzrMY?=
 =?us-ascii?Q?oSCkd0txcCTu7u7Hl4H3lHpFg4+f3t6EuoYV/UCABXkq3GUUOvuN/aQKRjhe?=
 =?us-ascii?Q?W6XttBlW70PJhL9bSQZjZMgNLEZqZuCsDsHfvj5WVxcj0LYD7d47DbKh4SqG?=
 =?us-ascii?Q?DVEU3P6ARpvDBHBlFUEYRO9GwzUw+D64hRsJ2QGMeH8EYeGcCs/pcKJwXlHA?=
 =?us-ascii?Q?rCV08EEprjZv6amcvxZ0c36WEKwQMvpVTqV79zi3Lc6AnjR/1++OfWpGmIHT?=
 =?us-ascii?Q?qbbXbh0WRm0oTT0PtyZBlCI4j4P8U5Ct+HQpCbqfueeMsRc+wb75vQoYEqMf?=
 =?us-ascii?Q?fbxQ4s2Y+Hmzjmqih2/28ivZcbCs4DxcG4a3ajPlWjIRPXZXPrc4e7YfAGJt?=
 =?us-ascii?Q?adO5Vu/q5+Ov5dH2pYU5DvZ1s6BUXQmT3q0n03NiKHBChYys2VW6r+Hw2N5G?=
 =?us-ascii?Q?QEzbVm4wEl0zSj3hd+X728KC365yhn9jHM4KJmBs?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF7D18F34A1.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 549ccdd4-00d6-474c-e1a3-08ddb3002d2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2025 09:19:09.5833 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nDOeewfyaUhqNOFmN7nNG+AE7CwPiVowUxH/3adIeAGKCSf1G+RA6VUHOsSzd1tAmJ/Z2zBbEyvhlQjXJyEzNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4798
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

> Subject: [PATCH v2] net/iavf: fix VLAN offload strip flag
>=20
> For i40e kernel drivers which support either vlan(v1) or vlan(v2)
> VIRTCHNL OP,it will set strip on when setting filter on. But dpdk
> side will not change strip flag. To be consistent with dpdk side,
> explicitly disable strip again.
>=20
> Bugzilla ID:1725
> Cc: stable@dpdk.org
>=20
> v2:
> - Fixed indentation in commit message
>=20
> Signed-off-by: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>

Thanks for the v2.

Reviewed-by: Ciara Loftus <ciara.loftus@intel.com>

> ---
>  drivers/net/intel/iavf/iavf_ethdev.c | 48 +++++++++++++++++-----------
>  1 file changed, 29 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/net/intel/iavf/iavf_ethdev.c
> b/drivers/net/intel/iavf/iavf_ethdev.c
> index b3dacbef84..f93e7bf9ae 100644
> --- a/drivers/net/intel/iavf/iavf_ethdev.c
> +++ b/drivers/net/intel/iavf/iavf_ethdev.c
> @@ -1378,13 +1378,38 @@ iavf_dev_del_mac_addr(struct rte_eth_dev
> *dev, uint32_t index)
>  	vf->mac_num--;
>  }
>=20
> +static int
> +iavf_disable_vlan_strip_ex(struct rte_eth_dev *dev, int on)
> +{
> +	/* For i40e kernel drivers which supports both vlan(v1 & v2)
> VIRTCHNL OP,
> +	 * it will set strip on when setting filter on but dpdk side will not
> +	 * change strip flag. To be consistent with dpdk side, explicitly disab=
le
> +	 * strip again.
> +	 *
> +	 */
> +	struct iavf_adapter *adapter =3D
> +		IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
> +	struct rte_eth_conf *dev_conf =3D &dev->data->dev_conf;
> +	int err;
> +
> +	if (adapter->hw.mac.type =3D=3D IAVF_MAC_XL710 ||
> +	    adapter->hw.mac.type =3D=3D IAVF_MAC_VF ||
> +	    adapter->hw.mac.type =3D=3D IAVF_MAC_X722_VF) {
> +		if (on && !(dev_conf->rxmode.offloads &
> RTE_ETH_RX_OFFLOAD_VLAN_STRIP)) {
> +			err =3D iavf_disable_vlan_strip(adapter);
> +			if (err)
> +				return -EIO;
> +		}
> +	}
> +	return 0;
> +}
> +
>  static int
>  iavf_dev_vlan_filter_set(struct rte_eth_dev *dev, uint16_t vlan_id, int =
on)
>  {
>  	struct iavf_adapter *adapter =3D
>  		IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
>  	struct iavf_info *vf =3D IAVF_DEV_PRIVATE_TO_VF(adapter);
> -	struct rte_eth_conf *dev_conf =3D &dev->data->dev_conf;
>  	int err;
>=20
>  	if (adapter->closed)
> @@ -1394,7 +1419,8 @@ iavf_dev_vlan_filter_set(struct rte_eth_dev *dev,
> uint16_t vlan_id, int on)
>  		err =3D iavf_add_del_vlan_v2(adapter, vlan_id, on);
>  		if (err)
>  			return -EIO;
> -		return 0;
> +
> +		return iavf_disable_vlan_strip_ex(dev, on);
>  	}
>=20
>  	if (!(vf->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_VLAN))
> @@ -1404,23 +1430,7 @@ iavf_dev_vlan_filter_set(struct rte_eth_dev *dev,
> uint16_t vlan_id, int on)
>  	if (err)
>  		return -EIO;
>=20
> -	/* For i40e kernel driver which only supports vlan(v1) VIRTCHNL OP,
> -	 * it will set strip on when setting filter on but dpdk side will not
> -	 * change strip flag. To be consistent with dpdk side, disable strip
> -	 * again.
> -	 *
> -	 * For i40e kernel driver which supports vlan v2, dpdk will invoke vlan
> v2
> -	 * related function, so it won't go through here.
> -	 */
> -	if (adapter->hw.mac.type =3D=3D IAVF_MAC_XL710 ||
> -	    adapter->hw.mac.type =3D=3D IAVF_MAC_X722_VF) {
> -		if (on && !(dev_conf->rxmode.offloads &
> RTE_ETH_RX_OFFLOAD_VLAN_STRIP)) {
> -			err =3D iavf_disable_vlan_strip(adapter);
> -			if (err)
> -				return -EIO;
> -		}
> -	}
> -	return 0;
> +	return iavf_disable_vlan_strip_ex(dev, on);
>  }
>=20
>  static void
> --
> 2.39.5 (Apple Git-154)

