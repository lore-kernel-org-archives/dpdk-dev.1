Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87AADCFD2F6
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Dec 2025 09:14:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 60A2B40268;
	Tue,  2 Dec 2025 10:14:42 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 13EBC400D5
 for <dev@dpdk.org>; Tue,  2 Dec 2025 10:14:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764666880; x=1796202880;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=IXN6dR6PjOgaaBlLBudKnkqfinW9GfueJliBAXZPg+s=;
 b=AsfQwJ6idPWZjFKsiU4zHKhZuhrsAoUNNW5BjgbGYmJ0YR6Jg1mlaYct
 hYkksZAN3Ysaidvu0tW9sCSMfO3BRCjsFxw5uyiAVq5UjDphIeqa9+BW0
 zojlzMzxQEGfNa33e+fQ727RNZOplxaMpMX5eHG9gCk0NxpNepBo8IDWC
 Sw12zXRJi7uY30J5Yg2Ow8TplsK3VRxIGoVXneeYuBLoAOnksM9+dGbpW
 5vlgaykjine62FK59XFvYihKDKPyhVPWVml//5quFMEnmolEUqxOd07dN
 wCskspCNVnjgE045nHU5KC2bzgxvj3HoCQTp7H2v7S+Sx7dW3GzuyUSGU Q==;
X-CSE-ConnectionGUID: /9zHo5c4R2uqImce3jA/9A==
X-CSE-MsgGUID: 84J84o6kS1GUDbFRRNBr9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="66793588"
X-IronPort-AV: E=Sophos;i="6.20,242,1758610800"; d="scan'208";a="66793588"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Dec 2025 01:14:39 -0800
X-CSE-ConnectionGUID: iBmZ/D0URv+vyMUVP664jg==
X-CSE-MsgGUID: Fon+3siuTlWmJFDLrTvahQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,242,1758610800"; d="scan'208";a="194542566"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Dec 2025 01:14:39 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 2 Dec 2025 01:14:38 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 2 Dec 2025 01:14:38 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.24) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 2 Dec 2025 01:14:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gkTTIqawDO4d43yspNgiKzxJs87D2i5FHbHifA9fQCI1ZYHSuF/S+LWWyU+P4dHzDVRYRJPqOPkNVxKA6KIVmajkiO0qSuJA4CnSyynpBns53ittgUjXXYn5QdpclK+ejfP8+e/8KcaBTXufIRWaFDTvXhu0VW0rOWjxZwaqU3qyQeefFLjiQWQyHSDw3FwXSwuBZfm71/LAXcJhh6wZYRcjJ8lEap8W7aPK8lRzXkK01CXMz+mBo8biMyQQ6q+SFhRZTFEsCmjIvfEYgFgImYJXLDrqb6zyFicQ8n49fAa5Yaz7/QkVyPtBRUKVWYWE0CL8FTjRmRl2MWh6cE4VcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AyD5ZfFGKPneLuG7sC9iaYgY9wruGBWqeevTHh3W3no=;
 b=jgGGQriGb6ivBocVftdXhBwmaa2SUUBX3HvvmGfXftsFodazykWAl0rmu9IRWrc4C0k3kq4I9DEnSz7gSYHd1McP2SxNpToOeOr+s4YQoWz8scoPFq/RhmSvEQS1q7LWgCx71WnscJWZJQsEqdcFl+yPzoK+ah0Zq/D3d0Zp8waNUh7/g9a4eqP/Pz/fI72vYdFrikUxYQFtp7rrTFGv/+xfgbo11fQLqtW7Cluu93Zc2XdH+yEp5eUrxEdRbuJIFDYMoP06HOhibCO6UgYufHy2a9WTxFvZoenUfMm3GqXczhVYqLCCehCTOQRwtSjMbVK/l8cQyIpeD75O6kizLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6116.namprd11.prod.outlook.com (2603:10b6:930:2b::14)
 by CH0PR11MB5251.namprd11.prod.outlook.com (2603:10b6:610:e2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 09:14:17 +0000
Received: from CY5PR11MB6116.namprd11.prod.outlook.com
 ([fe80::2b59:d9a6:8854:e9b9]) by CY5PR11MB6116.namprd11.prod.outlook.com
 ([fe80::2b59:d9a6:8854:e9b9%4]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 09:14:17 +0000
From: "Mandal, Anurag" <anurag.mandal@intel.com>
To: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>,
 "dev@dpdk.org" <dev@dpdk.org>, "Richardson, Bruce"
 <bruce.richardson@intel.com>, "Burakov, Anatoly" <anatoly.burakov@intel.com>, 
 "thomas@monjalon.net" <thomas@monjalon.net>, "andrew.rybchenko@oktetlabs.ru"
 <andrew.rybchenko@oktetlabs.ru>, Stephen Hemminger
 <stephen@networkplumber.org>
Subject: RE: [PATCH v2] net/ice: add MAC anti-spoof option
Thread-Topic: [PATCH v2] net/ice: add MAC anti-spoof option
Thread-Index: AQHcVq02Q5MdAwVwH0eQQbAZdQUWgLT07CkAgAFoL7CAAD5rkIAXXmCwgAAuc6CAAAqacA==
Date: Tue, 2 Dec 2025 09:14:17 +0000
Message-ID: <CY5PR11MB611648411BC37F6312513596E4D8A@CY5PR11MB6116.namprd11.prod.outlook.com>
References: <20251113105914.34949-1-anurag.mandal@intel.com>
 <20251116035749.45922-1-anurag.mandal@intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65562@smartserver.smartshare.dk>
 <CY5PR11MB61167F082015E76C562C3635E4C9A@CY5PR11MB6116.namprd11.prod.outlook.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65566@smartserver.smartshare.dk>
 <CY5PR11MB6116A4601EB74D4943216EA2E4D8A@CY5PR11MB6116.namprd11.prod.outlook.com>
 <98CBD80474FA8B44BF855DF32C47DC35F655AD@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F655AD@smartserver.smartshare.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6116:EE_|CH0PR11MB5251:EE_
x-ms-office365-filtering-correlation-id: e2abeb72-5791-475b-c4af-08de31832b73
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?xcTuyJA6M47jCBsGycrjD8DSeIC8WH5x96Y0t53eT779IlPh+tl8qgpdXj?=
 =?iso-8859-1?Q?/fRspbjSFJTKH9kWGQrDp//m1Npm/WTV49MkIsyuAtR31mKyj6pBE9ipxO?=
 =?iso-8859-1?Q?sBMPAeWD/zx3b203fqTP3SfTn+IZT9NtVzigtrdICq6x4RCxC9AtBC6kqe?=
 =?iso-8859-1?Q?FiDkh4lBW8TSPiIkZ20yVFUEm+L/auyu0Eytrmdqj7hNsGe3xPbA1xcQAJ?=
 =?iso-8859-1?Q?zLsJXXtJqBFlH1WOdMb0OgujUl2ZSww9lpY6+tTnwLBnZfR4U0db//d/b2?=
 =?iso-8859-1?Q?6gllO3DdKYHxrqeFDE5h7MmVfwuwQ7uf3EEr1G7C7EZItTP6lS1llm06kY?=
 =?iso-8859-1?Q?8yFa9wxts0iibhRBLWoq6dq707ag+xO0a99YMTYb88fneU1X3fFnEzF2bB?=
 =?iso-8859-1?Q?+5wk0xnwr9Og1N2lJigYfmMMZpI80FVwMqw9OBNQEpvHWqAp7FR4wEYbh1?=
 =?iso-8859-1?Q?ha/Vklj8infKkMHSVsa+kTc1L7K2dov3gtgdHQUn8k0OfaTWbuV/TLfCYU?=
 =?iso-8859-1?Q?ghgEZn/aidAzz+VHrjGZRsFlInxtUwGf5dVWxcToVVk0UN1pIef/i6utej?=
 =?iso-8859-1?Q?sx+xAjlb28687uSMGv/SMoHOPStJRFzZPMMR4vd7t8wgz9B4j4UWJ31oIV?=
 =?iso-8859-1?Q?9HpOpkK2uMEcUnJYwNAQZPi+aGJKKkSR1jAcEEhdMez9+9CY9NXVMD3jew?=
 =?iso-8859-1?Q?3r+l6GaNyh4Xs7+6wQCPkLmmZtb5oxcQDiVQM9+dsMTkSahEewX8CGNn8v?=
 =?iso-8859-1?Q?cLCY5ATj9uLb3Rs+vrz2KFTgB5vm3uEHcn3pOEUhQjMm+r7vv1N4hHAQjh?=
 =?iso-8859-1?Q?2dsZ8S6VfwRLioIJnjPLA9NTlTR8k0CSMusXd7ztSN/60EAj58HLr/2o4I?=
 =?iso-8859-1?Q?hyDp807DNIJgk4TDouH0kHVPtxSnWopV8WSTMfITSOM6J5/JA/E5obU9kl?=
 =?iso-8859-1?Q?itsvtCmBTFuRA2P/ujZdtp+2M7D1zQltIpHr8hWrsuz34sTQXy5gc3utOT?=
 =?iso-8859-1?Q?zDzukXfTHGFnAMQ2Dgg2OpM8N/y6e/QSoMXx0V9n46BduFHyfNlpacazMk?=
 =?iso-8859-1?Q?gtq+wcHyCegnIqIEbnXDIlPwkxgidZBY9z6adk+GUEtOr7FnMJjJU/A1JX?=
 =?iso-8859-1?Q?Yo6FH5qlQCXFVyxBuLjH1Wh4oXLovu3APgLijy5U0MfoH5V5LPHA3gQQHR?=
 =?iso-8859-1?Q?qjB6HLVUHKY/p+CMnLZVl5CrDYXy1ByU5IFxFE/3ZlwIOMLPJvdM3uC66/?=
 =?iso-8859-1?Q?2zZHN/tCKEUslkYDGgYeStlOWtcBm4XtE8Nl/f44VHfoYGZ10HVCd67iL8?=
 =?iso-8859-1?Q?Rt0eAq04dgkjto6fTMcoeZPTtuU3gBkWCR5LhutZutDk519MzspeLzYtr/?=
 =?iso-8859-1?Q?c3wNVkTY4yd6ITOrL1ACIBGfGO6dl2dlYYpQyfF6b6die4BvPvI316qFJN?=
 =?iso-8859-1?Q?R8iJvsiDPUqWzZW4iAFZ3hzudEdc8hdp415gA5Fkprx2VGMxzAB2BISMVz?=
 =?iso-8859-1?Q?N77ha2tHOpgMV4K6oFkoej8BCuSzklEjTLKNCDr7zRPQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR11MB6116.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2uvjrxpfaPflQpSvOrIpxE7L5NWfRMQYOp+nIjuK2nJOsZ6dzAWHgMkxDX?=
 =?iso-8859-1?Q?Vykv1WZO+ArA6ZDuQMxbWAE7ka83++OtfEs7ZJqDEeglTvVJ9qcex3Pu4k?=
 =?iso-8859-1?Q?cgi42QSWfckAnpjlluficciejxHdAk35/QK8QoYt/vwMVRy4mQSCeIFDhm?=
 =?iso-8859-1?Q?X1SOhOR+2tlOS0QbWIzaVPHVbiLhDkrRD7oXqLvpoBMrikmAKe+SI+LKVn?=
 =?iso-8859-1?Q?lqrBG9P3Bg6uCo8z1j76WOVCCDxyWRrlBOvXvAVA8DEO/CpMQWjw2czlSG?=
 =?iso-8859-1?Q?yEgRfFDBXwNmSYIKihvZAgvapOE7o2U2WoV0VAnhgXzt3pWf/8FOWJP0sJ?=
 =?iso-8859-1?Q?QQdxnfYmwqkCZ5Lon1PWoir3/KFdAfX4Ld938SHs73bFnMElIQu0agjxhY?=
 =?iso-8859-1?Q?taJB+ZCFHqIzwJOTtEEkSmbCzC7D7mddngzgIKM3JAlGz5KYfvUAFIOU+n?=
 =?iso-8859-1?Q?6W+eZu8KxgLjeJGIkx9kbWsO83BTizJxcy28/nuEt07c7VPQyD73rQXmjE?=
 =?iso-8859-1?Q?H97MSK2b4hfJLTuKvnirBpS2hiJnKT5lauDwyb5N0BjRzV89C+IGSzHdQC?=
 =?iso-8859-1?Q?lzw8ThHeqzK0SB/FQO71UAWcbeja8LvP9uD6E1lWdLiVCRNim+W0cOxtnL?=
 =?iso-8859-1?Q?M8vNv3bfgJACBJEy/Xt8AOJvuhinut0xByAURS+FI5jZoVJjUc6G9BcWk2?=
 =?iso-8859-1?Q?p2h62RGRJKn0PC5PBR/XJbDOpI1mGz3PhPTklkHBYcPsL3pPvRMACkgfxc?=
 =?iso-8859-1?Q?IyQj4qe/CXNRmyzimrRY/aqUtxH+8ATb2T6QrrkcCS765osH4ayvWZEBng?=
 =?iso-8859-1?Q?n/eaTZ8Kkqs8EMGQxMtZZks4yZ19QtaRbpowlEMflCOrfwbu5UXXWBrVZZ?=
 =?iso-8859-1?Q?FQyo8Xj5XaadSyJpvbWiHI3teEZM/+KWF26V1cD0kMXDnfmsKbTndNlraE?=
 =?iso-8859-1?Q?kebR3OvPQ+KikDhyUNJhK2nrzdyi8cQuNedP1WaCijArtcl4O8q3BbTKEY?=
 =?iso-8859-1?Q?6y7iiFm1NpNxIutf2aZBFz2rORd6N+mj5IoGh1UBeAuKtL/YPrwyDEYeqq?=
 =?iso-8859-1?Q?mYO8hZPcpytFYZckq1VvFnRM+7p3mW18hzyDcvmZgXlNNUjeP6CJPHjkMW?=
 =?iso-8859-1?Q?G8YJRMnMHA//BHLZ4doSo3ewSbUDMm2CBwhMbJyz2fNDBxSdg2DHbOnsPM?=
 =?iso-8859-1?Q?e38zmBYjDLPyF+MmsIMOsrGB7d8PUP7SmM9E1URO4CFx9yrD8UetPDAqCR?=
 =?iso-8859-1?Q?mRuD4T89AB8i9F1gmfA5XsoHyWKPx7KoNq4rVm85WUB7OYg2MzLxgQVqo5?=
 =?iso-8859-1?Q?dNyHGLXBDFkLrF4GLvnhE1m+xuUybpT/yK+DA3zge5yFoqcZGJ0xe8zlAG?=
 =?iso-8859-1?Q?2OzKyDVD39CQQGeJCEU3nySfw6kj/V+mO3nJsT1A4KDpUPLdTx4lfBg/jr?=
 =?iso-8859-1?Q?p2/hz4Hfzl0KzCL0lmpp97zobP3b6nW0R2jO6GI+jPQhSn4s6Ej6BLOVos?=
 =?iso-8859-1?Q?cPvlCkkgpzB9BfXy837jsBvnYxFrvMFUcQsYZYK3ri1qW0Ln8LmfrypbxK?=
 =?iso-8859-1?Q?l9OdXHJ2nrhZaFFoyr3mW8VAB5hg3k8iCB4mXrp9UEgdewNMYF1l1YjX7l?=
 =?iso-8859-1?Q?FWwfK5ZJcMmJ68xnGSUs64fbLzakVtBLbq?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6116.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2abeb72-5791-475b-c4af-08de31832b73
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2025 09:14:17.2299 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aBzTRGKDMwbxy9CG6tvyB/9MKjtkaLT14W815D6pzDeCV+CTgJAygvNp6hSaFAtOtiwDyftRUlCjclg1c+JBBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5251
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

Hi Morten Br=F8rup,

Ok. I will make Mac-anti-spoof disabled by default, gave option to enable i=
t  and send a new patch.

Thank you.

Regards,
Anurag M

-----Original Message-----
From: Morten Br=F8rup <mb@smartsharesystems.com>=20
Sent: 02 December 2025 14:31
To: Mandal, Anurag <anurag.mandal@intel.com>; dev@dpdk.org; Richardson, Bru=
ce <bruce.richardson@intel.com>; Burakov, Anatoly <anatoly.burakov@intel.co=
m>; thomas@monjalon.net; andrew.rybchenko@oktetlabs.ru; Stephen Hemminger <=
stephen@networkplumber.org>
Subject: RE: [PATCH v2] net/ice: add MAC anti-spoof option

+TO: Stephen Hemminger, might have some kernel-related insights on this.

> From: Mandal, Anurag [mailto:anurag.mandal@intel.com]
> Sent: Tuesday, 2 December 2025 09.17
>=20
> Hi Morten Br=F8rup,
>=20
> Apologies for late reply but as the patch was deferred from DPDK 25.11.
> Hence, I was waiting.
> PFB my answers.
>=20
> Q1: " Please disable anti-spoof filtering by default, and provide an=20
> option to enable it.
> Like source-prune."
> [Ans]: MAC anti-spoof is enabled by default in kernel ice driver.
> Hence, it seems a better idea to make it enabled by default to keep it=20
> in sync with kernel and in terms of security.

Mac-source-prune is disabled by default in DPDK, although it is enabled by =
default in the kernel.
Mac-anti-spoof should behave the same way, i.e. disabled by default in DPDK=
.

Also, consider that the kernel is mainly designed for client/server applica=
tions, while DPDK is mainly designed for packet forwarding purposes.
With that in mind, default enabled makes sense for the kernel, and default =
disabled makes sense for DPDK.

>=20
> Q2: " Is support for "vlan-anti-spoof" in the pipeline?"
> [Ans]: Not sure but " vlan_anti_spoof_on" is present in code.

OK.

>=20
> Q3: " What are your thoughts about the generic Ethdev APIs I=20
> suggested, instead of driver specific devargs?"
> [Ans]: It is unlikely that a user would want these mac anti-spoof/src=20
> prune to be set/reset dynamically. Hence,  it seems devargs likely be=20
> a better solution.
> Generic Ethdev APIs is a good idea but should be taken separately as=20
> it will have much beyond scope than this and would need significant=20
> effort.
> Also, that again bring the dynamic nature into the picture.

Good point about not needing the dynamic ability. I agree with that.
But devargs are somewhat difficult to work with for applications not built =
for specific ethdev drivers. E.g. our application detects available hardwar=
e at runtime, and configures it appropriately. Generic APIs are much easier=
 to work with than individual driver-specific devargs.
So I prefer not to introduce more driver specific devargs.

I acknowledge that my Ethdev API extension idea is feature creep, so I will=
 not make it a hard requirement for this patch.
And when mac-anti-spoof is disabled by default (which I do consider a hard =
requirement!), the devarg parameter is reduced to something that enables so=
me exotic filter, which I don't object to.

>=20
> Thank you.
>=20
> Regards,
> Anurag M
>=20
> -----Original Message-----
> From: Morten Br=F8rup <mb@smartsharesystems.com>
> Sent: 17 November 2025 14:36
> To: Mandal, Anurag <anurag.mandal@intel.com>; dev@dpdk.org;=20
> Richardson, Bruce <bruce.richardson@intel.com>; Burakov, Anatoly=20
> <anatoly.burakov@intel.com>; thomas@monjalon.net;=20
> andrew.rybchenko@oktetlabs.ru
> Subject: RE: [PATCH v2] net/ice: add MAC anti-spoof option
>=20
> > From: Mandal, Anurag [mailto:anurag.mandal@intel.com]
> > Sent: Monday, 17 November 2025 06.22
> >
> > Hi Morten Br=F8rup,
> >
> > Thanks for your mail and review. PFB my answers.
> >
> > " This is the same story as with Source Prune.
> > Please disable source-prune filtering by default, and provide an=20
> > option to enable it.
> > Also, suggest shortening the devargs name to simply "anti-spoof",
> like
> > "source-prune"; they both operate on MAC basis."
> >
> > [Ans]: Source prune is disabled by default and option to enable the=20
> > same has been already committed:[
> >
> https://github.com/DPDK/dpdk/commit/980c840a646a2c8ae49a291c17baf20a74
> > f
> > 36086].
>=20
> Sorry, there was a typo... I meant to write:
> Please disable anti-spoof filtering by default, and provide an option=20
> to enable it.
> Like source-prune.
>=20
> > I also wanted to shorten the name to "anti-spoof" but I found=20
> > something called " vsi->vlan_anti_spoof_on" in the same file.
> > Hence, to distinguish between them, used "mac-anti-spoof".
>=20
> OK. Then "mac-anti-spoof" is a good choice.
>=20
> Is support for "vlan-anti-spoof" in the pipeline?
>=20
> What are your thoughts about the generic Ethdev APIs I suggested,=20
> instead of driver specific devargs?
>=20
> >
> > Thank you.
> >
> > Regards,
> > Anurag M
> >
> > -----Original Message-----
> > From: Morten Br=F8rup <mb@smartsharesystems.com>
> > Sent: 16 November 2025 13:14
> > To: Mandal, Anurag <anurag.mandal@intel.com>; dev@dpdk.org;=20
> > Richardson, Bruce <bruce.richardson@intel.com>; Burakov, Anatoly=20
> > <anatoly.burakov@intel.com>; thomas@monjalon.net;=20
> > andrew.rybchenko@oktetlabs.ru
> > Subject: RE: [PATCH v2] net/ice: add MAC anti-spoof option
> >
> > +TO: Ethdev maintainers, regarding new Ethdev APIs
> >
> > > From: Anurag Mandal [mailto:anurag.mandal@intel.com]
> > > Sent: Sunday, 16 November 2025 04.58
> > >
> > > VRRP advertisement packets are dropped as TX-errors upon=20
> > > transmission from a vsi of ice PF due to MAC anti-spoof check=20
> > > which is enabled by default.
> > > There is no way to disable this check in the Tx direction to avoid=20
> > > these packets being dropped.
> > >
> > > This patch introduces devargs "mac-anti-spoof" to allow user to=20
> > > disable MAC anti-spoof check. Disable MAC Anti-spoof check in the
> Tx
> > > direction to avoid getting dropped as TX-errors upon packet=20
> > > transmission when their source MAC address matches one of the MAC=20
> > > addresses assigned to that same NIC port.
> > >
> > > Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> > > ---
> >
> > This is the same story as with Source Prune.
> > Please disable source-prune filtering by default, and provide an=20
> > option to enable it.
> > Also, suggest shortening the devargs name to simply "anti-spoof",
> like
> > "source-prune"; they both operate on MAC basis.
> >
> > Let's make something generic instead, to replace those silly devargs.
> > We have individual Ethdev APIs to enable/disable various Rx
> filtering,
> > e.g. "promiscuous", "all multicast".
> > Obviously, we don't want to introduce new APIs for every semi-exotic=20
> > filter any NIC may offer, like "source prune" and "anti spoof", but
> we
> > could introduce a set of generic Ethdev APIs to support filters such=20
> > as these, using a bitfield enum. E.g.:
> >
> > /* Enable one or more filters. */
> > int rte_ethdev_filter_enable(uin16_t port_id, uint64_t filter);
> >
> > /* Disable one or more filters. */
> > int rte_ethdev_filter_disable(uin16_t port_id, uint64_t filter);
> >
> > /* Get bit field of filters enabled. */ int64_t=20
> > rte_ethdev_filter_get(uin16_t port_id);
> >
> > /* Get bit field of filters supported by device. */ int64_t=20
> > rte_ethdev_filter_capa(uin16_t port_id); /**/
> >
> > /** Destination MAC must match NIC's MAC address.
> >  * (This is the inverse of Promiscuous.)
> >  * Default enabled.
> >  */
> > #define RTE_ETH_FILTER_RX_NON_PROMISC RTE_BIT64(0)
> > /** Multicast Hash.
> >  * (This is the inverse of All Multicast.)
> >  * Default enabled.
> >  */
> > #define RTE_ETH_FILTER_RX_MULTICAST RTE_BIT64(1)
> > /** Source Prune.
> >  * [Insert description here.]
> >  */
> > #define RTE_ETH_FILTER_RX_SOURCE_PRUNE RTE_BIT64(2)
> > /* Add new Rx filters here, in increasing order. */
> > /* Add new Tx filters here, in decreasing order. */
> > /** Anti-Spoof.
> >  * [Insert description here.]
> >  */
> > #define RTE_ETH_FILTER_RX_SOURCE_PRUNE RTE_BIT64(62)
> > /** Used for error return values which are negative. */
> > #define RTE_ETH_FILTER_ERROR           RTE_BIT64(63)

