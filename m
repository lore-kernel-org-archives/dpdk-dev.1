Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70DBDC369CF
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Apr 2025 03:04:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B131A402E2;
	Fri, 18 Apr 2025 05:04:46 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 80A24400D5;
 Fri, 18 Apr 2025 05:04:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744945485; x=1776481485;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=kSisG4vWWOQaPuimGvDFXf1jCJaXNrS0rWSUzZ9HD2E=;
 b=Num5EeYus+YfGg2YxmRpiC7KP+tR4DSeN9GRo0C9Um4nM9QRPfGWnI8l
 QgTtOxvTZbe7t4Mjn5l9+B47ADI+t5V4y37z2ZPLJfsimXlYd60cEyr0X
 q9SQWP158L8yBnRJhIHR7uri2ObtBgsdImoXY05j92aGEtooVAnWhkq7r
 irKpskXNpkyAqZpDhFk92+njQCHKxLAStkMgfzdYgbvpEAknPlaJv9Igg
 a5rWbURQk7CWSTThsvWAyGmNrIckiN6tT/+DPeXOmkctn8n+eWrtJM2tU
 tD2I0pspChORER5Hhzt1c0ShBafA/kFAWMcsjguZy54Uma8qfYlJVjaoG g==;
X-CSE-ConnectionGUID: G3j/Ru4rTkuTAe+PCKWjfA==
X-CSE-MsgGUID: tQd++oG0S5q+fdkls32xHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11406"; a="46277635"
X-IronPort-AV: E=Sophos;i="6.15,220,1739865600"; d="scan'208,217";a="46277635"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2025 20:04:43 -0700
X-CSE-ConnectionGUID: P1f40jyyRMGunHOzS/1fhA==
X-CSE-MsgGUID: rSGXGUXcSSKa2/zrfu/EVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,220,1739865600"; 
 d="scan'208,217";a="135857387"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2025 20:04:43 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 17 Apr 2025 20:04:42 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 17 Apr 2025 20:04:42 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 17 Apr 2025 20:04:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SnxDgwBcPaI4c/8zai5qogUdwIp29u9Rf9RtaeaAgG2A9uFrqWw9hmVdGKnmgwpHHpYwTLm8yq3tEpqX9RHGQQ1EVQo7DdTKXZX5b3k49BffX/ICE4oAp+UI+sk/Eal8VjfE/CkoENk4jnGj4ySJrJulPINptagFT+fSheWLsjumYOgEbJ8Jftkw10tSce0Q9wDwjS88Pdh/NRn4oUvf6HBB+PzN1KVZCJyLLWy538QGaxsuE+zqJWsh0KDICpg4QF99VhwItJ045yg52hxGguqyax0gzK8bFEjtUsPyt7Fk47z+9MzQ6ytoOkjjkWZRJi9mNi05rdakHEEbxNXZZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kSisG4vWWOQaPuimGvDFXf1jCJaXNrS0rWSUzZ9HD2E=;
 b=IGz+70xBv6T+H9dthQRpT9OCi4PnyMfZA6S18d5u9i7+82F7KNiX4TUcsfc0Pqus6ZHsAy5RLWrexCBkJJruxEKOe5Sej/LxOJ9vofafJc6MCpYhBL8ycmNelbadt70PNBo74BEa+pz2UA9yRKrhCvFUtkaqkorH+XC2D2bmlUsshsnQXoUxbUGTtgCK4PbKvnGUMgU8q5yvV3qIw9JICmmAWYM/7uqyaSj+TueCzm8Nh4FiWV13ThXwrHrN+t8oUJJ9SD8+yOC94QLdm248OlsN8ia4Da6fxI1hcSw0Iadq+Zj9ZtKfvHqZ0n+ckQkT+R5rTNdprsXqD5UhxUluJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6859.namprd11.prod.outlook.com (2603:10b6:510:1ef::11)
 by LV8PR11MB8557.namprd11.prod.outlook.com (2603:10b6:408:1e8::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Fri, 18 Apr
 2025 03:04:26 +0000
Received: from PH7PR11MB6859.namprd11.prod.outlook.com
 ([fe80::933d:c1ee:c4ec:84be]) by PH7PR11MB6859.namprd11.prod.outlook.com
 ([fe80::933d:c1ee:c4ec:84be%3]) with mapi id 15.20.8606.033; Fri, 18 Apr 2025
 03:04:26 +0000
From: "Liao, TingtingX" <tingtingx.liao@intel.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, "Burakov, Anatoly"
 <anatoly.burakov@intel.com>, "Richardson, Bruce" <bruce.richardson@intel.com>
Subject: Re: [PATCH] net/ice: fix Rx of large packets
Thread-Topic: [PATCH] net/ice: fix Rx of large packets
Thread-Index: AQHbqJ8HjcjPnXJJik+02D7hLI3nS7OoxzlV
Date: Fri, 18 Apr 2025 03:04:26 +0000
Message-ID: <PH7PR11MB685914C66497FD23FB074C9892BF2@PH7PR11MB6859.namprd11.prod.outlook.com>
References: <20250408155736.2739406-1-bruce.richardson@intel.com>
In-Reply-To: <20250408155736.2739406-1-bruce.richardson@intel.com>
Accept-Language: en-GB, zh-CN, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6859:EE_|LV8PR11MB8557:EE_
x-ms-office365-filtering-correlation-id: 0f02873c-0bb5-408c-ab23-08dd7e25baab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|7053199007|8096899003; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?cD6J73Z/MEG26MvKVrvIYBmrv3gC6fiUi+CUBTxbdF3wxhDrFOEduzOj1S?=
 =?iso-8859-1?Q?nLnThtoO3UodPNZpzqWjCpGwNwh4OFhbWgcs1rcilmpypRqb+am2Ethyhy?=
 =?iso-8859-1?Q?zc8+Vm5v+jX2lFDAIsEe9ksfktr6RWffRxq2+By2PkeSoudMtiIfymh+R+?=
 =?iso-8859-1?Q?coGPpFDFFfLJSgE81/cGuo40GfYba02pgNaWai7uoKz+yUP10s4TQPFHKq?=
 =?iso-8859-1?Q?MFEEJzXciDQeZuhK7OLgPAkOUlY7sv1LBc9GQVZ1SpIuAGIrE2hVblr5eG?=
 =?iso-8859-1?Q?rHb0TSjenb5+VPkRm/cAxlGJ/bGzeh3Lba/ghAxgBZ4KcupAVui2y5bcOU?=
 =?iso-8859-1?Q?JKbmearGhR75gEp3s0fqjGHnsv2xNzsduNUoNQiVghduct6jrzLVoLEyO3?=
 =?iso-8859-1?Q?p0BzJ+Ui7WUV1vXroqfA/QHKfAxnNFlCNvS/7Xi8kaR6P0frguttxUsVuN?=
 =?iso-8859-1?Q?fiusfoDooY501goYS35otsEO+3pyH9lIsUO2Uf86cNoOqqJpHHXhU0pNZY?=
 =?iso-8859-1?Q?E0f/VbZD0AkddVpLoerGiQbqQD3NnIfpv8o5FJqBq5Zly4GDdxecPUU0vI?=
 =?iso-8859-1?Q?VDkV/FZ/tSO+BSIH+zNDshxBIcgOo7FJLWT8trdFnEAI1WMSckCBh/svGU?=
 =?iso-8859-1?Q?1tomQqFKOYZ9c4BqgnGIYUJ52bEWhsBax+bzQxQDxFm1V4h1LSg5CmWctH?=
 =?iso-8859-1?Q?Xyc5HGxt1TPje+YoCoBuESi+kO3Rqc7JXlZ85MPFBrbkGpqlZ0HPnbqd0/?=
 =?iso-8859-1?Q?2TWQaRAZ3jEdCrbVYXK9kJoJ4tc59bGUSc3ZWtFV2HnYQnRx9dUEbd66xU?=
 =?iso-8859-1?Q?5GERViJws3CmGtQCBuVKUFiQA9a06fbX9V7unCAGDjjgdu6ImR5Jat0Iu5?=
 =?iso-8859-1?Q?kwC+1Ma2rcapeKO1YrpZVnPwVgTdLCZRoNvSvt1rDfkoYtHUkzCgtUczgZ?=
 =?iso-8859-1?Q?8rN6QnyK9ySgSRUyGyiSmep45J9M9EAfdTcAv4GGh2SxROEk/gHpu6Fn07?=
 =?iso-8859-1?Q?ZCYNpNWVBO4jZypt8yvCXmGy8tkws6M9fj7JHnvRexi54XJz2sH0sMi8yw?=
 =?iso-8859-1?Q?QaUXAN8iHF1eDE9taipeFhCVTZdaz8vUJQO1BJdQ58YPuy31LDbpMLfZmS?=
 =?iso-8859-1?Q?TvGvemLt+kPmmhvokimWUkd3LFlHzOzZHVQMGB1UOXnMJXB39QZWskOTRF?=
 =?iso-8859-1?Q?lTDfCfJS7244aUdxSAtjyr+snemlCIZswYLPVM7k3WndSjpqCFKzHIFzSW?=
 =?iso-8859-1?Q?xPGUJsAd+d5OjhdT1pvKnhGG1A45yphI370BQ3csUJLdCAm3ZamI5Lqy9I?=
 =?iso-8859-1?Q?eUdj6SaZw4dhAmmwAHlTNjB8jvl+5mpJGZQFMwMb/xBtQHraLv1rUBt/4Z?=
 =?iso-8859-1?Q?tcZbqPq3cmOOpdoHSR44HnP8suurJBas5SmSswrh9GGQF8ejcBPxYi+cgO?=
 =?iso-8859-1?Q?1keJSQrXwVu1IFzbJmBXVhBon+G/1OuKprLRU1mPo2MFKBqqfoXdOOjkuL?=
 =?iso-8859-1?Q?L9G0jpQ+ObkmuL61x7LWJw5Kr7sLe9too92ij9DMmGxw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6859.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(7053199007)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Jm9TFuvw5HnW1gLuMGfctbXVu8lYb8denB+JuLXaOvb7SyZKxjsfv12ngb?=
 =?iso-8859-1?Q?RreRUsGlj/RgCRmUPsxnVs/nGr58W6tOQYMN18/Ts64IFtrXC4kd0z8TZX?=
 =?iso-8859-1?Q?YYvOi0AdRZYDODYUaz3Z/L44cp9PI14AGFAaTGswb/VtSEwJLGEt5UqFgM?=
 =?iso-8859-1?Q?pbemRARWreSDwPtmZIvgZUKmAe4DBL3ZWxKPgTB19jHAmfVi1IHSQVwsTd?=
 =?iso-8859-1?Q?4vkJ0TXbhJwjVyBWRQiQCCsQS3MHwBwd6T42GXR0NN8ZIghqk0x912J1yV?=
 =?iso-8859-1?Q?u+wQYB21a85u9PSQxS/X75isi5FyY/OvyBvZ49V8Fk0QWqHdv3zN6rV5jw?=
 =?iso-8859-1?Q?5734PJOS9lOzb+uaAt5MKbYrc5B7EYaAChnOmKZrlo7z2PCqXHRq2RiaeJ?=
 =?iso-8859-1?Q?PTa4Ui2l3g+ImOWCJhCnHq7UxWroKaqmLAmRBX/uNOd+KP4Y986HcYGB41?=
 =?iso-8859-1?Q?oEGhk+8IP3DYEKSBFhiXkZPDldflAt3hn14shU3iR5BQL9ZIpHNw4NU9i6?=
 =?iso-8859-1?Q?hi1QIW59WceVW5S26h+u7REFiQaXMXRRi35Gk9bmtTGy7FCSwPQuxJZRLl?=
 =?iso-8859-1?Q?XHjhEd9bBI/sPErh/20yGCvZLRqvN+Fst9h0qxYPGYcoksdGb9HFlR3hKA?=
 =?iso-8859-1?Q?MOLH7wNL0UVQvzUyLtvh6kwKJyENOGgQDTNdRVfROhaOIDABAqfwIWVOL/?=
 =?iso-8859-1?Q?bf1+utX19QcIFKKpsEKeK9zw1//CDF98V4DSNkymlU7VteriwXitgatrjR?=
 =?iso-8859-1?Q?NYblH/7yG8n1OMTtNMcs2NfvEehK8YzPRVn92K/4+CM/azK8Y7f9YssfJd?=
 =?iso-8859-1?Q?EJkKuL31/qivOylV8B6NcNE4VoipfoqTjKC9CvoqDK/qLZg6I60XoriRiA?=
 =?iso-8859-1?Q?9fNX3vumbtk0gQV7tqei/ex1fwdMxKp08Rks/h/ljz/FbvfRw+nRVQl8vF?=
 =?iso-8859-1?Q?iBPSEgE0FGyblDfFV4sjJtn5l5PhRRyE9bogzfA8dmBSTe/8QiMw02vSNg?=
 =?iso-8859-1?Q?DZT5tmtaVdToqBW1OoRxxIp1HNRYQBqJ+V23IwGSTvOLnfRwK8wyLxlY3l?=
 =?iso-8859-1?Q?Dp6uPtCyVgtTTWJhAQBn/cXOWqtsO7Lslvg4s8NnAktkIOhjx5jOtNLkqr?=
 =?iso-8859-1?Q?7B1wjVl/UsudtkszY+spXveFF3WXoTeLA49hvChuFqzJ35jCd2Otclk52B?=
 =?iso-8859-1?Q?2TgRUQ6By5KWMC3E1JJREzddBl+kx61dBxe0Ao5tl/yFKpp9Esi8UvFULv?=
 =?iso-8859-1?Q?qIUOcy0jW40ovT/d5lvnPKQhzdmWxTFEm42VeZvzTSDRWrUiZsc4aHPLXQ?=
 =?iso-8859-1?Q?IoShjiedd27Ufmc7ronv9BSTIHv7C9yym2qF5DPrXRqxmlDMGAOSIwwQ7V?=
 =?iso-8859-1?Q?QWbtNt0s/gWM5ddJuqWMnqxQoO1ag6ItC8GwEQHBD1g31udhtDBtZASdZr?=
 =?iso-8859-1?Q?LDvQgO4vNADMiwPcwTJhYhCKHTkf5jrn0e6FNcsOLCmapunca2B59cz/gH?=
 =?iso-8859-1?Q?+VE/SZ+tGS2sVduU4RVHRF0QqfOuMUCV/9QPtTAKdnlxiEZxoqgjC7T3an?=
 =?iso-8859-1?Q?yVnC1sG1ShguBrGVhR+12SFfFVtakR7CtQFHYWA64rcALZbNly1NlobGza?=
 =?iso-8859-1?Q?kUkZpqb5NiegvdtoedzqwlY9ujfbMpxBEK?=
Content-Type: multipart/alternative;
 boundary="_000_PH7PR11MB685914C66497FD23FB074C9892BF2PH7PR11MB6859namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6859.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f02873c-0bb5-408c-ab23-08dd7e25baab
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2025 03:04:26.6896 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GfnDYyKT/xJzNxzgfsP3lxMDcKqH36kflQm8X9EgKbU013ziiBfD9mNKGe6Ht6nt6lz1b8KDcaiFT6N1QB1G5vfDxcCbS8wFkcgFr7STQKk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8557
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

--_000_PH7PR11MB685914C66497FD23FB074C9892BF2PH7PR11MB6859namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: Bruce Richardson
> Sent: Tuesday, April 08, 2025 23:57
> To: dev@dpdk.org
> Cc: Richardson, Bruce; stable@dpdk.org; Burakov, Anatoly
> Subject: [PATCH] net/ice: fix Rx of large packets
>
> The determination of whether or not the buffer size is less than the
> packet MTU is made in the Rx queue start function in the ice driver.
> This means that we cannot choose the Rx function before we have started
> the queues. Move the Rx function section down in the code to fix this.
>
> Fixes: 3c79a3d91d9d ("net/ice: fix mbuf cleanup function")
> Cc: stable@dpdk.org
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
Tested-by: Liao, Tingting <tingtingx.liao@intel.com>


--_000_PH7PR11MB685914C66497FD23FB074C9892BF2PH7PR11MB6859namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"direction: ltr; font-family: Aptos, =
Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; fo=
nt-size: 11pt; color: rgb(0, 0, 0);">
&gt; -----Original Message-----</div>
<div style=3D"direction: ltr; text-align: left; text-indent: 0px; margin: 0=
px; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, H=
elvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
&gt;&nbsp;From:&nbsp;Bruce Richardson</div>
<div style=3D"direction: ltr; text-align: left; text-indent: 0px; margin: 0=
px; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, H=
elvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
&gt;&nbsp;Sent:&nbsp;Tuesday, April 08, 2025 23:57</div>
<div style=3D"direction: ltr; text-align: left; text-indent: 0px; margin: 0=
px; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, H=
elvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
&gt; To:&nbsp;dev@dpdk.org</div>
<div class=3D"elementToProof" style=3D"direction: ltr; text-align: left; te=
xt-indent: 0px; margin: 0px; font-family: Aptos, Aptos_EmbeddedFont, Aptos_=
MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(=
0, 0, 0);">
&gt;&nbsp;Cc:&nbsp;Richardson, Bruce; stable@dpdk.org; Burakov, Anatoly<br>
&gt; Subject:&nbsp;[PATCH] net/ice: fix Rx of large packets</div>
<div style=3D"direction: ltr; text-align: left; text-indent: 0px; margin: 0=
px; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, H=
elvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
&gt;&nbsp;</div>
<div class=3D"elementToProof" style=3D"direction: ltr; text-align: left; te=
xt-indent: 0px; margin: 0px; font-family: Aptos, Aptos_EmbeddedFont, Aptos_=
MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(=
0, 0, 0);">
&gt;&nbsp;The determination of whether or not the buffer size is less than =
the<br>
&gt;&nbsp;packet MTU is made in the Rx queue start function in the ice driv=
er.<br>
&gt;&nbsp;This means that we cannot choose the Rx function before we have s=
tarted<br>
&gt;&nbsp;the queues. Move the Rx function section down in the code to fix =
this.<br>
&gt;&nbsp;<br>
&gt;&nbsp;Fixes: 3c79a3d91d9d (&quot;net/ice: fix mbuf cleanup function&quo=
t;)<br>
&gt;&nbsp;Cc: stable@dpdk.org<br>
&gt;&nbsp;<br>
&gt;&nbsp;Signed-off-by: Bruce Richardson &lt;bruce.richardson@intel.com&gt=
;</div>
<div style=3D"direction: ltr; text-align: left; text-indent: 0px; margin: 0=
px; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, H=
elvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
&gt;&nbsp;---</div>
<div class=3D"elementToProof" style=3D"direction: ltr; text-align: left; te=
xt-indent: 0px; margin: 0px; font-family: Aptos, Aptos_EmbeddedFont, Aptos_=
MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(=
0, 0, 0);">
Tested-by: Liao, Tingting &lt;tingtingx.liao@intel.com&gt;</div>
<div class=3D"elementToProof" style=3D"direction: ltr; text-align: left; te=
xt-indent: 0px; margin: 0px; font-family: &quot;Segoe UI Web (West European=
)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &=
quot;Helvetica Neue&quot;, sans-serif; font-size: 11pt; color: rgb(0, 0, 0)=
;">
<br>
</div>
</body>
</html>

--_000_PH7PR11MB685914C66497FD23FB074C9892BF2PH7PR11MB6859namp_--
