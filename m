Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7731AC282D1
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Mar 2025 19:26:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7AE3540B94;
	Thu,  6 Mar 2025 20:26:20 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 5459040B92
 for <dev@dpdk.org>; Thu,  6 Mar 2025 20:26:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741289179; x=1772825179;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=cUW59J+Am0LF4EBFEC+yg0eN5mWOOn1De0T8VdjyrcQ=;
 b=Ls4Q1pq2GyRf0hDbTMa2F77d/GsOI+V81igmorP6lV3azcc1wX6qQlw0
 j3uDPRAS6kSBidzcqCdSHEGcH8XrPpEiHAIzcfRJtBoQj0/dJXTFFktlo
 9ZgCFXxqnhZuEh0AvyWCYT5JaAkTOtG5t6+mZQqLrpmCjpa7JKB6IPOz/
 maN+ESF0gWjOr8LJv9PONVMbXqi6dq25LoiosBXLicTzfp2Ycgo8oFlvL
 UsnyHADfF82igIO4rwDqhJWX+D7RNm8o2PyiTpcF4peUo3Y8EAa57Hb/5
 tFog9oOjzBdjspP/Qf6Q46azUd6ac48SWZ0joqwHLqtbhmPm2umhSUVlN Q==;
X-CSE-ConnectionGUID: jsw6M9BXQyerA2fbqIKP3A==
X-CSE-MsgGUID: sFfs+Eh4SmKoBOTiSlot5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42557995"
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; d="scan'208";a="42557995"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Mar 2025 11:26:18 -0800
X-CSE-ConnectionGUID: UGFsgoCITSCu6+O0F2x4UA==
X-CSE-MsgGUID: doD10QujSpOk3XNHUHpACw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; d="scan'208";a="119813517"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Mar 2025 11:26:12 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Thu, 6 Mar 2025 11:26:11 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 6 Mar 2025 11:26:11 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 6 Mar 2025 11:26:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ory+W5Y2nAJLZkg3C9/V3FOwQhBHKTKkQ7gqxj+jFDjX6iZKv1trlWo7cu+067uDPmDbFXVZrKHj8jB9I1bikwNjv1efXVeDkaJ/y+iD3exmrEo2oYW/OpgBNPxrT+B08IjLzOsoSZnT/bw48Itk+V33km7qBVs6cvhFr4yrKrym0fjrSOLnhNUwTkbZYst5laZDvSXtvphgY+4PCW+oMH+wgZpHFVCAOcJ05FVID4al9OEulGoqNKn/Hkvvck6plZ3Toc6J9PtJLT0EmVWgA74FW14bjwZs4+U04wC9YuHnE4JFS+87EO5d4UEIWJSeT/l9BDZONen32JwxSKsIlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cUW59J+Am0LF4EBFEC+yg0eN5mWOOn1De0T8VdjyrcQ=;
 b=bh6H0neHh1iqe/95tLK0IJnu0sXdI0mQ71xVsGDOmfDaV3tsvpYMu6lb0C3d7Xeozft8/ypF95glVFOte5zDLf62Jm2CkrcwUdJs97lxB6IPkdKnvXIjWpa/iLuQNgySSe3QaiJfnAn29+akcoUCo88vgDrQlR8mhbA86a2i4e2Mp6+7NKVwcUoU+vDxEv3syUz06tLVJuI1Ne1keebxUdkIcSHzhptuIj7USGydijr+LoMhjIGN8fclgy3pfAExBRMTUiOeyAMVi4qHSydLvE26Xk+Rq8RF0ZkPubLEQdeFeeNKlo6y82rMqcTZVsKn/3yI/CCOu8wr0TtRe4W14A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB6803.namprd11.prod.outlook.com (2603:10b6:510:1cb::12)
 by CY5PR11MB6137.namprd11.prod.outlook.com (2603:10b6:930:2b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 19:26:09 +0000
Received: from PH8PR11MB6803.namprd11.prod.outlook.com
 ([fe80::8680:ff9f:997:18b4]) by PH8PR11MB6803.namprd11.prod.outlook.com
 ([fe80::8680:ff9f:997:18b4%5]) with mapi id 15.20.8489.025; Thu, 6 Mar 2025
 19:26:09 +0000
From: "Van Haaren, Harry" <harry.van.haaren@intel.com>
To: Gregory Etelson <getelson@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "thomas@monjalon.net" <thomas@monjalon.net>, "mkashani@nvidia.com"
 <mkashani@nvidia.com>, "Richardson, Bruce" <bruce.richardson@intel.com>
Subject: Re: [PATCH] rust: support DPDK API
Thread-Topic: [PATCH] rust: support DPDK API
Thread-Index: AQHbjp0TZmxpO4GtBEmJszAY7GicS7NmeChT
Date: Thu, 6 Mar 2025 19:26:09 +0000
Message-ID: <PH8PR11MB68034D4DDB371E3197C7F82ED7CA2@PH8PR11MB6803.namprd11.prod.outlook.com>
References: <20250306133713.393057-1-getelson@nvidia.com>
In-Reply-To: <20250306133713.393057-1-getelson@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6803:EE_|CY5PR11MB6137:EE_
x-ms-office365-filtering-correlation-id: 1ba4b949-0203-4814-f3ca-08dd5ce4bf72
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?WRYzxHHCmCdLBiAkq+Vuh3spWcY3OPs5Aig4eXde3lvoBfQMRkKn+LUFsP?=
 =?iso-8859-1?Q?lGbQxESbVMzim2+fxZO9he/TDY1CWDydaaamO8JEouQ0anVG9SlO/k+16Y?=
 =?iso-8859-1?Q?oFPZNl0TR0m3v/0mJ/FEq4qoQ2nIuD55hKwu2lHYpOBl0mEJVw7MSqh/Gi?=
 =?iso-8859-1?Q?da3ysmgAPDnmZufDNvdTJU6jMtieJnthuyw88FP0FAi5I+02iaQPuM7+p0?=
 =?iso-8859-1?Q?F+0DbI5wQARGci+l5lWBM6JToS6Oz3lWKTZikfqV3PwnhS3ds74u6630NL?=
 =?iso-8859-1?Q?T62IGwtfbLMt4KEKEFa42IozX1rP7i+Nc5JyA1Q+nQFWG3k8Arc7BrEMei?=
 =?iso-8859-1?Q?iXv3AnckYJrhT03gEmobdFJ17FkFxvP7NMEv61bBNYB1pOIU5gp18F8bxR?=
 =?iso-8859-1?Q?KniVS5pyF1UMGB3TOf3vkyhL/r2W61ooX5UxNetQNyUcfFuyLiwj6Q7Qw/?=
 =?iso-8859-1?Q?yYS5he/8ECy2EQv7pmQ4mnW9cAVIcWeFLwZXkC7fPkCX4l6Xw4WWgzv0Lw?=
 =?iso-8859-1?Q?EP+qIT5jsj7hKjDxF7pJGJEcc7sSNtAVVMgpoFEyB+zsVAej1ETn+iaiCi?=
 =?iso-8859-1?Q?8eWUXN56/4mt2YLh0ELVD6Yt6VXxjZcNPTKY22T53DJ/xrxT7hSDSXwDIi?=
 =?iso-8859-1?Q?+3vJTkpJhd1P+LaKCsol388lTo9jgtKkofxnZLtucw7XNPOkVQHP1EH14F?=
 =?iso-8859-1?Q?rtRuQUAztWOhNiEQL1gcXa5hedt+Ff7M4iq6fGD5SISNkv8gLl1hFnQOkx?=
 =?iso-8859-1?Q?X4jtHqoN/j+M0tg6NM4FD4NqLsVPL0sG8DRnxX5bXKQLLVki4o+4ok0soJ?=
 =?iso-8859-1?Q?mvOCZBu0rBDZHOjIiXPtYYUNsRLXAusb0p0ftRqkyr+n6KLdJABEK2KLFE?=
 =?iso-8859-1?Q?RSsHjM1QeJHglSaaJLmzQgY4lKbFZ7Zu8CmyCujJQYgUj9krgxTF5giowU?=
 =?iso-8859-1?Q?OfrH67pJKoDAtKM8ou6p+Bxr6ThATj7UNQXpPU85IOwd8P9gS4GhA3Luos?=
 =?iso-8859-1?Q?3xn7YVkXC3Jnd9AtVN9FpxtBdp6KV711dMwKwuixqYcuO9uSeF386U588r?=
 =?iso-8859-1?Q?eaS4VmiQ9bRSg1bqeWr7VPnoUwOBklHy8f8d/xyLCXPNJi6GP0r8k4oh8J?=
 =?iso-8859-1?Q?/z2GbOCl1pkYTaSPF7dW+LKWwRYkRinTeAH+ccADWeOXA7iP6AReAYoFU0?=
 =?iso-8859-1?Q?xnQI0WKwLkeV2N0rCRjo/EFEiScfjH26ibv32eoGNYxksavIEm6kCdQqu2?=
 =?iso-8859-1?Q?5IunkWC78tERB3WH5xEcTy1rCdPyR9M2OjevZaIIeELsB93oGGEdLD60SI?=
 =?iso-8859-1?Q?lmAUhAgkuh05pE8d/YHS03nQCFPRE5IPiL+IQUn5kXy9TOUUqlO61olCPj?=
 =?iso-8859-1?Q?syxOLKqi9fF1zJ79OR3NA0JndOgAKd4DniZcDJGTz9G9ksjSHi2n3IGVLr?=
 =?iso-8859-1?Q?2Rw/Rt3l/bG2pwI9?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6803.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?gZ79dMgld/6zF9YGFOVGTPqchZUiOJw0ae9fjGhcRyxqOCbAZqiaBxDVF/?=
 =?iso-8859-1?Q?NLyPBCOpoIqnVE24kkXHw8UhC299yuMntUpcwU5DtocU5a9+PqFxksgztj?=
 =?iso-8859-1?Q?03sOghChuqjZ0FfYjkecLtUbUS1UY2y+8xGQiwAwpjoBbgl7M0laAr80Vc?=
 =?iso-8859-1?Q?5i27urqQrFIfRRqnM0fsVcdlkEsE5Y7h6dv2BgZ9WbT4ItDGsgtLHVi1EE?=
 =?iso-8859-1?Q?2bdMSZJ1hlJ6l33jKHJSHiIZK8sGOO4MVTghxcY4dzBUtY17N+uKUy3Alg?=
 =?iso-8859-1?Q?U33JX2gDKW/rIuM9d/0mHHLxlt9LDBYUhKq1/iPxm/fiV/IAriIRdqBY1T?=
 =?iso-8859-1?Q?fUmU9nZVz2aAW5mggILsdfmydjPFI/H8bCW3lnpVj5I/hSfn6KFKQah0eh?=
 =?iso-8859-1?Q?nLVWDFdzXs6YapPuGrQUadPNUl2j0ZD7oxOnAeU6F8Q5JICdC9VAO4Q/Yg?=
 =?iso-8859-1?Q?6i/kRs4lFrirgbnhdAG71xbemD4KeHa/Dp8PyRZptvWoq1bEl7erlie0du?=
 =?iso-8859-1?Q?sE6Zeoi99Vv2TpJTqzQrfie860U1lkh+HW14WoOVA04FYgj4dcZzxz7stI?=
 =?iso-8859-1?Q?SYdxu3/FSQYwBR5CN+UuaZ/cOxYvWSt++kUTI0mOFICMiTI7CHxcRmzS9D?=
 =?iso-8859-1?Q?k3KpHmeTB7MoBND16IV8JhjObpy1AV/csHJXPPyHixhhOXjxqDFSZAcB88?=
 =?iso-8859-1?Q?MnHia8V5ALm13DxLq5zZMl9Kb0EdAlVJf5edmN3W0XCyu89CsxoKjPR/KZ?=
 =?iso-8859-1?Q?b/lytfzhRNcgh3h2DXws2GNoF0JNNrVErX8LqvfP8/d297/Z+AbTPNnYfE?=
 =?iso-8859-1?Q?ZJsNjoNcMEHjjRM2OKpMZD9sWhPZQjhepf9Nv/B03qo8UhTT28pvGCTIyk?=
 =?iso-8859-1?Q?UBcctBySlaXTnvYPXxJgC+EMiW6tW5aBfmardlUubHNEftOUeAJcadxFZu?=
 =?iso-8859-1?Q?eb8bcxosoIZeLGXWdCWOcAw+gIsk45XIXB2fzKx1zSfV6dOtldfL4U0l24?=
 =?iso-8859-1?Q?vaYU9nFrztgN5ziLEpU7/XtGM2/FZ3qkRa0gUftn2OPDQdpTj5r4FCzG6O?=
 =?iso-8859-1?Q?WQf73EZB1Lo0+/Rlu55S3gmlDyDqJ2g0eqA44X+rAdjkmQKsXCBxFEOkYt?=
 =?iso-8859-1?Q?g38cFiinfDKnUGjA+sdeA/7FZxKDZ5kuZZnW7Wkv1W4wlzVnhnKbTfDqsj?=
 =?iso-8859-1?Q?LPGdT5GXLz8CU7WLXfhQNBwq0g6+BlQKcbdzbDC144/1fcc28sDeo1yMMF?=
 =?iso-8859-1?Q?WeyPKj1WyqzarcMQWumQCFulfiRAlMaHy5+WUkZYPDrgHphJwt6pgYyOsc?=
 =?iso-8859-1?Q?4WixYsUFF4l9IgQG9C4KfgyQsALpY9hmZTr5GPiNUIEdSfgvznNVT/C6xM?=
 =?iso-8859-1?Q?tlOpD1YnELM3PsDmdHQ7uQrV2b8mRSX/4PJHHKxYM9n/jn4aNSdh5aTnCR?=
 =?iso-8859-1?Q?YAkzTqL0C8DHiDtrvcUh6STDEssO1XDfmC+FMIkJPnka3RMPLcCkFzWESt?=
 =?iso-8859-1?Q?8KXYEuJBMPr0w9LhwB/MI/V3YMNAunFID5i9jRYbHxuPzgr2D/lK4KeX6w?=
 =?iso-8859-1?Q?25lS1L5ksABG1TVRYuA0WbH9giCpLg/HyTK2eI8rIoPzDAERjELJYngNTN?=
 =?iso-8859-1?Q?5DoUV3HFroqGtPdd9Gt11nkShOyV3yc2Er?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6803.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ba4b949-0203-4814-f3ca-08dd5ce4bf72
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 19:26:09.0357 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vGa+puJIH8AAxpYPpi3F60MtiF8IF1tvcYo3VOtRxSAe03za94cQ/q1pbvk6N3+6bFXB1zftD6KP+yQVQm/PqJJLJ+h9n1m7+MGwhTLe/JA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6137
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

> From: Gregory Etelson <getelson@nvidia.com>=0A=
> Sent: Thursday, March 6, 2025 1:37 PM=0A=
> To: dev@dpdk.org <dev@dpdk.org>=0A=
> Cc: getelson@nvidia.com <getelson@nvidia.com>; thomas@monjalon.net <thoma=
s@monjalon.net>; mkashani@nvidia.com <mkashani@nvidia.com>; Richardson, Bru=
ce <bruce.richardson@intel.com>=0A=
> Subject: [PATCH] rust: support DPDK API=0A=
=0A=
Cool, I like this subject, great!=0A=
=0A=
> The patch converts include files with DPDK API to RUST and binds new=0A=
> RUST API files info dpdklib package.=0A=
>=0A=
> The RUST dpdklib files and DPDK libraries build from C sources=0A=
> allow creation of DPDK application in RUST.=0A=
>=0A=
> RUST DPDK application must specify the `dpdklib` package as=0A=
> dependency in Cargo.toml file.=0A=
>=0A=
> RUST `dpdklib` package is installed into=0A=
> MESON_INSTALL_DESTDIR_PREFIX/rust directory.=0A=
>=0A=
> Software requirements:=0A=
> - clang=0A=
> - RUST installation=0A=
> - bindgen-cli crate=0A=
>=0A=
> RUST dpdklib installation instructions:=0A=
> 1. Configure DPDK with `-Deanble_rust=3Dtrue`=0A=
> 2. Build and install DPDK. The installation procedure will create=0A=
> =A0 =A0MESON_INSTALL_DESTDIR_PREFIX/rust directory.=0A=
> 3. Update PKG_CONFIG_PATH to point to DPDK installation.=0A=
=0A=
Interesting approach to automate it; are there specific reasons that this a=
pproach was taken,=0A=
or did this just seem the easiest/best way to include "Rust support" into u=
pstream DPDK?=0A=
Alternatives could be (*not* suggesting to rework the patch!) a dpdk-sys=0A=
crate where the bindgen etc is done externally to DPDK itself. Many existin=
g=0A=
approaches (some examples: https://youtu.be/lb6xn2xQ-NQ?t=3D130) use that m=
ethod.=0A=
=0A=
I kind of like (this approach) of having the binding generation upstream wi=
th DPDK itself;=0A=
it makes the Rust support upstream and keeps it close to DPDK... however it=
=0A=
means that it is "the one" official/DPDK-community-approved library/crate.=
=0A=
=0A=
There's some nice tidy-ups to cleanup the namespaces possible if this is "t=
he crate".=0A=
Perhaps (sorry, borderline bikeshed-topics..) renames for clarity & readabi=
lity, e.g.:=0A=
dpdklib::rte_eal::rte_eal_init()=0A=
=A0 =A0to=0A=
dpdk::eal::init()=0A=
=0A=
> Signed-off-by: Gregory Etelson <getelson@nvidia.com>=0A=
=0A=
I'll get to a testing & review in the next days, however I'd like to ask so=
me bigger picture=0A=
questions, to understand/provide input on approach, and how big an effor to=
 expect here!=0A=
See above linked youtube video - I had sketched out some API concepts for e=
xposing a=0A=
"safe Rust API" wrapper around the DPDK C API, which also encodes threading=
 requirements.=0A=
=0A=
Some questions:=0A=
- Is there an overaching "we're trying to achieve X with Rust", or specific=
ally "safe Rust"?=0A=
- Is this patch the "get DPDK + Rust working", with follow up patches for "=
safe wrappers" the intention?=0A=
- Or is this patch all to expect for now?=0A=
=0A=
Again, thanks for the patch, I think Rust is important for DPDK & infrastru=
cture software,=0A=
and will try make time to help test/review/discuss this patch, and the wide=
r Rust effort!=0A=
=0A=
Regards, -Harry=0A=
=0A=
<snip code itself>=
