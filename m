Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B41CAE6816B
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 11:38:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E1AAA40269;
	Tue, 17 Feb 2026 12:38:42 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id B59F2400EF;
 Tue, 17 Feb 2026 12:38:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771328321; x=1802864321;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=5S5TMJTKpDlvE9xxRZlWE/NUkdmfsLB/BZ98G//Qnl4=;
 b=HueRIy/woXgopw1r+u0gpgByvZY7bcx1x5Yji221NSKXy7XL+ZyVd44/
 7LzwCeAioOw8eJqGDMGluNVYvTS+f3bj97s3g2sudB8MeuJmazVZ2Phcs
 Po6skZeSzXwNd0Kg2+R1gfC9xLDRIvoi39apr+5lYTSgFTuWqnNs+BWW+
 yGkE1D634BnnqlvxdQUBhCECA0sKzByFReStuWw435F5XPTJPh/9rc5S+
 NR2fX/lYSgfDldVYrEvAeCljQwU9W4vYonsjGjOmxStMPr6TjH+e8f++H
 6Nldig0Gn+pComlAP56jlozVYL/GAJTpQOBpPJoMwJEbtC+HS78Hj0ymD g==;
X-CSE-ConnectionGUID: 1DolNQskTRav+HVrsYJWEg==
X-CSE-MsgGUID: k1/mhHKZS/WLl6hBtJg8YA==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="72294672"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; d="scan'208";a="72294672"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2026 03:38:39 -0800
X-CSE-ConnectionGUID: +m8x3DSISJWi6rpNns8DvA==
X-CSE-MsgGUID: Ga8k0SAQTzi3uGkI1SzZdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; d="scan'208";a="213121443"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2026 03:38:39 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 17 Feb 2026 03:38:38 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 17 Feb 2026 03:38:38 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.33)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 17 Feb 2026 03:38:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jt3IuodgfN1AGdF3Sex5WFs45x14c1Hkp2T4GnnLaQyX0+hzrLSdr0clzfYVDTjJc5spuq1O5YYAuWh8AhfbjpNNOFp2GThYSZwV2ufi0JdgC20BBi4yyIiK/VFupx8sTy36p3HqKyMzxsIFBSaQYICfnOcX8RC01UVLl8bIbEI3yU8nn2kukATcqnfxLlJW7NSH2nzzzhHmq5b1hD/JwoZ6qHjA84db7166Uxg+SCwyZuTWSJoDRrSLBC6JJdv1NzSFuTbonXHah79dTl/Q6DpK4dCuFcQz8Q9whkCYg3yX4fZeU4sKzskHmxe8n5Obm61yrYXN9+xJZJYTH4/m0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8gWS8uExfnUwyM6G1ztnogV8bvjCUu/FzuTTfRIPqbA=;
 b=ThJM6u2A7n2EvATRW+6jD0Dm+NvPvDN+gxIbdNlSiiztJFFZWOpruemncgBTVaSNU6w0AfxieN3h8BQQp1WwUK/toSzb+9RXpc25Z/qxhNGU7IbdYe/gVDxzagHr4bYhYpWPJtmUrcnNneW6Q/Iy9nC9mm40hqXRNBppX79r/YMD3SdGR3wstaOyB6wnaUHs6jSJqSGKRDyQPC1zszjJzwJGoVYQ5i8hjJQ8FRogXCrwSsx0ejTDIX1DC6YadXJvJnLCa6iaFg1kdcfY+Rs8b3230geCAmI8RkIWvKbQubaSzVVtRZfhiF272yp1pMwc9FwH3EzeifUbWBGADRWrYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ5PPF6E320AF71.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::833) by BL3PR11MB6316.namprd11.prod.outlook.com
 (2603:10b6:208:3b3::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Tue, 17 Feb
 2026 11:38:35 +0000
Received: from SJ5PPF6E320AF71.namprd11.prod.outlook.com
 ([fe80::7273:f1db:f194:d2b]) by SJ5PPF6E320AF71.namprd11.prod.outlook.com
 ([fe80::7273:f1db:f194:d2b%3]) with mapi id 15.20.9611.013; Tue, 17 Feb 2026
 11:38:35 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH v2 01/10] net/i40e: permit secondary process Rx path
 selection
Thread-Topic: [PATCH v2 01/10] net/i40e: permit secondary process Rx path
 selection
Thread-Index: AQHclp18ojjnD/WggUmnMRGwBwKgeLWAqE6AgAYtDQA=
Date: Tue, 17 Feb 2026 11:38:35 +0000
Message-ID: <SJ5PPF6E320AF71C5C2FD8DE2CAFCD237DE8E6DA@SJ5PPF6E320AF71.namprd11.prod.outlook.com>
References: <20260205103008.190493-1-ciara.loftus@intel.com>
 <20260205124627.371733-1-ciara.loftus@intel.com>
 <20260205124627.371733-2-ciara.loftus@intel.com>
 <aY8j2R_06CbaRE-q@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aY8j2R_06CbaRE-q@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ5PPF6E320AF71:EE_|BL3PR11MB6316:EE_
x-ms-office365-filtering-correlation-id: 49c39a05-b9e2-44ba-70e7-08de6e19162a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|10070799003|366016|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?EyNsHUAMjmSoftZBoz3oo3RbAZl+mgusXATSgqcv7fUB0lOIE2okeYm+XNFZ?=
 =?us-ascii?Q?9Wux2mzo9niWTnpkFwC0xQV7t7DjkS4fyfdwuLrYWJxSNSTZ468HDrj/K4ZT?=
 =?us-ascii?Q?zQ5d7j0QYFwDyokJgLKm7exM5vttJY6TMFcrEsaat1heOKEabt5cHIjG556T?=
 =?us-ascii?Q?BzZRJW7ooUDh4HZX0RdVPrgk7bYtviQGWDOpg5kP7grU5vATPPcR2GZ2pBdG?=
 =?us-ascii?Q?Xwv7Dlb9sc0l/PWacn9G2+z0I8svQdF3GRo+RE+ST6UERoeeDdPtR9ggacRS?=
 =?us-ascii?Q?le6h71E2WNbPDVJ67Zp/pK1wkWKyWB19ZYpn2ynOc1xb33LJTRegJPvbRf+g?=
 =?us-ascii?Q?B7KfDgg/pYyMvsGUCj0Pz87ncbxprvdFGPdtf9QItGhKrV+nUPzTnF4TIRbd?=
 =?us-ascii?Q?nAYEFImQ4CLeJkkveXpCR8zemPCyo1lLs1ymCJ1hYgt15J5Tczz1YdB/r/Ui?=
 =?us-ascii?Q?ghYt8ZGUN4DUvNWnqFp8azpK6orbDPxCCfVv+zd3Xg0Uqbw85Fp6HKADfa58?=
 =?us-ascii?Q?LfzSjdEm/PU9vqleC0BwM/dgHt8CqDmy2GzhK+QJTPNVifPtNyuHTWm4HVOn?=
 =?us-ascii?Q?Milv6K+0AODVHS2JkDMGGOu5uyzqe9Bz7W8/swd+2wh8gU8ejW3MXOgO3jpO?=
 =?us-ascii?Q?yLbEhvN6nFEtm2b6DhcuwGnQTfn5QuNXBBGSGfVTuRQ/fgnzr2zvwtdBdWpi?=
 =?us-ascii?Q?UHbAS9IDvpGNO5hTvHF2WFR/WXG5xB00yl7m4kiAQYWK9pX2v2ae8sJjuBDO?=
 =?us-ascii?Q?tgqR1nNw+FyY0v/FjsIuT9hUoatgDVicx4VZdhL5CaJX4ALZgiAsMsuT7TZf?=
 =?us-ascii?Q?+bclj33yT8SorbfZJhB8UcepUS2qhxaip5BRAfIgeHVeno+KnqySDmhWKRp3?=
 =?us-ascii?Q?EKsJz2jr5ihJMoIiYnxOFya4SbSmRMv3WHjcz+7u8PzTkoZ3AUfquwmQ86hw?=
 =?us-ascii?Q?Xe25R9WVXaAMl7SOY+DViosdc3zp4Rh8K+5U4zMbx+DoU3ephnVmvdwu6KnR?=
 =?us-ascii?Q?QvTuMAMh/r17n4+GbzVZTNRYSeFY46HAMK2gVZ9/0Nztu1D83T9bgi2frgie?=
 =?us-ascii?Q?oNxmkGIU2bbGc8CePKhTZLabF94dHinZNPnroopmNOr7lhIN0Lel2vzOowqX?=
 =?us-ascii?Q?bA8Cuq2H6IXZ/CEchFkCsIJag9SdcoDmn9PDz9AOXz4C8SbMrNUK+nl21RQW?=
 =?us-ascii?Q?uBVTQICCYfsWCSGzUACevqHXTd2InmLv46Y/qRkaCUbwUEzuCDAHOwiuL0Bw?=
 =?us-ascii?Q?n8bdO8H7Fj11dWTBfrx36k4LTTwmykM1iw4Woxt0dYs8FWiYoOUZeA9X4EZ4?=
 =?us-ascii?Q?l85IxptIw4qrKBlUIv3AdCNJni8BFkJAaKtAx2IG3ojWaIIUWSyEBjHw2L12?=
 =?us-ascii?Q?VoeSkNLCwf8xipoChVnaOAdqgrbcLZ4UptOo+IDXJW9CwO7DINzdYM1qvsQN?=
 =?us-ascii?Q?GwoO5HMBnBiHdbCNq9U4zPqaodFbjea0sn79JbJDDo70I4MGm3HkGi4gwWeg?=
 =?us-ascii?Q?1MYojX9Xp4tKsc5rnG6gQPfR8EmjxsUc9QXp/itS73TNNox3toBCDbwKEQ4w?=
 =?us-ascii?Q?ktdPUWr5p03x0JGN0r25cfRtuvtKgQVJ+u13WD0xMC7iVNSZRYd4NOsdOcjW?=
 =?us-ascii?Q?3Iax8Lv/lRuEoE3Fe+FhFT8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ5PPF6E320AF71.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?S8qJKVXGygcDCNZ1EYANXXH1Qy7SqJNGIOT8UdVuciOwz90Pu93YU6/ve3wY?=
 =?us-ascii?Q?YYy8mdGatypGHmmOdPccKyAeVSjvJx6F8Wki9y7givHOYM6NJ+CO661cop0D?=
 =?us-ascii?Q?K5U7Sr/Cb+9cxlZnE1rAGRaq+4o8Fm3CoNajFIMe2RkbcDeSCZEYg3UTvlHG?=
 =?us-ascii?Q?jnIRjLxHz3kV5RFlYHO40HYioY2bRvYMHnNaZvWp3L0Nc/nc1kvB4gNdDptG?=
 =?us-ascii?Q?y239zJYwm3yoCnsTsa6dYmWeh6JzTwPx7zcSDZCjcaXfTNckBASipBMpPWMo?=
 =?us-ascii?Q?4Mb4ASbf696Yt4yR2hHrJE30ED2uVxM8nmEXmzHFs7Mor8peCTblixXRUegj?=
 =?us-ascii?Q?kpZFdoxi0QJXAd78y0dLrYn9kBqKjjPrL3HqiNTOsvytbgQQ4ZVXb47gGeaU?=
 =?us-ascii?Q?XrLCOJabiOaXpYb6twlAaahq8oNMSD7RYjy/JVMx0T/u/8iPcaZXQnmcjbId?=
 =?us-ascii?Q?6P6HyB6y9whwnQzoGzv/Qg0ATAOm3FRDNeWj6ekeByPj1ivIOm8WYKMPHG1i?=
 =?us-ascii?Q?J0uwcxCTPKabZcQNN0TA4e/VCVcAqUMrFYfajcG5lK88haYVDfobIUPv1GDN?=
 =?us-ascii?Q?LLi+xCA14Qh5E/TQouFQ8jmqGJbgTPX1Jiza9Txr4SxRTHl98ikR9tyh5gt7?=
 =?us-ascii?Q?F6uNMxuROHW2diqVeOuIbD7vTXNiJ4DAEhuPMprmkmx7vjMhJYc/yh371Hvp?=
 =?us-ascii?Q?v+sYLGXrNdRqqGsTn6hWwd7ztIw9w5Ixqb3LiqbsfaWPzT//puds7+Q9IoYG?=
 =?us-ascii?Q?PrANSuY/ztl5FJ9q9VQHj7IzFpj1V+JVK2Q9D2K/JdNA3/7B4ORkXUIzt+/l?=
 =?us-ascii?Q?okW87X/gEnKKJzwSbrdLDTtZU2odndmKFJjezSLhPwcX0siUzMtj43+7pS1T?=
 =?us-ascii?Q?FIV3kyMqBZC5spfGnV0rM9iUdmQRwboJLhnrG/HX2nWd2DnNd+8Sr0anATAc?=
 =?us-ascii?Q?coVBYURjnEvL/K+u2xOkD06w0D+3IetTCw5iP+iRx8zbiO5HED2uEjRzG6D0?=
 =?us-ascii?Q?K46IBQ46bNly9EL1qzOqNOCOR33J5iB1p4/Z3lfiXdyghgepgS0J1fAO2Pmr?=
 =?us-ascii?Q?L3wLzVy5ckM0VEBo0ZUkMbUpD7q5TVIddx84wll55UYCvOUVru0PVx2Y1J/B?=
 =?us-ascii?Q?4dTeKfAHBZCw2Ysx4PbsieDSdGhTsGaGfFsaImG7kNdoui8IOjpZbXq9/TGd?=
 =?us-ascii?Q?teHGKfMewxQZ0I6L387KuH1FN7nvlfbP3Yy9uJV/PvU/TdGwv7kg9dK8ef8S?=
 =?us-ascii?Q?q6oIqcFPnJcg5xtgAH4hUOj/HVXj/6aw3WH+t8Yww3eOqcamG0UhT2C39kYt?=
 =?us-ascii?Q?YCMRI8nNhhVqkktxjnVB5/ecj31ePMxkmc34KpbgR4B/37YnEMsWoUSrDjih?=
 =?us-ascii?Q?PuKxaeCR4Fd1QhMS74YxMWbRIZPwiGy3vNuHwEthj2Fy3wY/gUeJxxdDZJrt?=
 =?us-ascii?Q?d2vIrfKYdvGJGS8VT4EY1FYkGvJFINT8sR3+BRYmEwJVctPQmWTQPptzWXuA?=
 =?us-ascii?Q?K/5UqiOewaU2kg2hoYl4tzJpiokXfZ0tY/ddGWUzuzTcj6DEVjohClV4lieI?=
 =?us-ascii?Q?qGgFYNQmLrTxHpsLxaX0EOeib6k+P31JnmD2avaoCZJgs0Dpq0uFRHAEyNbN?=
 =?us-ascii?Q?ELdW3DIfxh2i3RgZyHzLX+OV07ZzZ196nGs7+cXpNh3tubno71le+o1CcmjD?=
 =?us-ascii?Q?oy5diVISQpU5/5sssDN1iVnj3kGXL+nH7mFzDMfZegw50J49cJC+MbR4Umfg?=
 =?us-ascii?Q?/MAoXLZdg5HEi+H6ZmT9dltg+u+1FeYUbbLoHtlHC0acoDvdqUBaevNYArlV?=
x-ms-exchange-antispam-messagedata-1: nate0TEdB4PVKw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPF6E320AF71.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49c39a05-b9e2-44ba-70e7-08de6e19162a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2026 11:38:35.8072 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0gjKCo5Flq+vuhQgUbQtPQfHEcxx8Xgpyseb9RFQmWXCt4Qeh3dCp8NXwzXqS7V55fiUUxbFk97Tw+RJwgWkXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6316
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

> On Thu, Feb 05, 2026 at 12:46:18PM +0000, Ciara Loftus wrote:
> > Commit 258f346f5d5e ("net/i40e: use same Rx path across processes")
> > changed the way that secondary processes selected their Rx burst
> > function. Instead of letting secondary processes select their own
> > function, they now used the function selected by the primary process.
> > However, the primary process only selects the function at device start,
> > so if the primary process hadn't started the device by the time the
> > secondary process was selecting its Rx burst function, the secondary
> > process would not select the correct function.
> >
> > This commit addresses this issue by allowing the secondary process to
> > select the path if the device has not been started yet.
> >
> > Fixes: 258f346f5d5e ("net/i40e: use same Rx path across processes")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> > ---
> >  drivers/net/intel/i40e/i40e_rxtx.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/intel/i40e/i40e_rxtx.c
> b/drivers/net/intel/i40e/i40e_rxtx.c
> > index 1c3586778c..3deeff165d 100644
> > --- a/drivers/net/intel/i40e/i40e_rxtx.c
> > +++ b/drivers/net/intel/i40e/i40e_rxtx.c
> > @@ -3494,8 +3494,8 @@ i40e_set_rx_function(struct rte_eth_dev *dev)
> >  	uint16_t i;
> >  	enum rte_vect_max_simd rx_simd_width =3D
> i40e_get_max_simd_bitwidth();
> >
> > -	/* The primary process selects the rx path for all processes. */
> > -	if (rte_eal_process_type() !=3D RTE_PROC_PRIMARY)
> > +	/* If the device has started the function has already been selected. =
*/
> > +	if (dev->data->dev_started)
> >  		goto out;
> >
> There is no atomic ops or mutual exclusion here, so what happens if two
> processes both call this function at the same time? Do both just get the
> same result or do we end up with some conflicts?

If two processes were to call the path selection at the same time, in
most cases they should both land on the same result. Both would be using
the same information from dev->data to build up the req_features
structure which is used as input to the path selection function. The
effect would be both writing the same values to shared variables eg.
rx_func_type in dev->data->dev_private

However I've identified two exceptions:
1. If the primary and secondary processes have different max SIMD
bitwidths configured, two different paths could be selected. However,
this is an invalid use case IMO.

2. When LLDP is enabled in iavf, the global variable
"rte_pmd_iavf_tx_lldp_dynfield_offset" is set for the process from which
it was enabled. The Tx path selection will set req_features.ctx_desc if
that variable is positive. However that variable will be different
between processes so different processes may in this case select a
different path (eg. one with a ctx desc and one without). I think adding
a bool lldp_enabled to the iavf_adapter struct can work around this.
I'll submit a v3 with this change.
