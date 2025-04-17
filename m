Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743A6C369B2
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Apr 2025 12:27:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D7A5400D6;
	Thu, 17 Apr 2025 14:27:12 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 8772E400D5
 for <dev@dpdk.org>; Thu, 17 Apr 2025 14:27:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744892831; x=1776428831;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=nVR/g1YYG6wKTC49xDelusU2zMmB9XmQQNjEeDZ5IPY=;
 b=Xw4p+oScIpXMytIM2ZaOnELd3oQdxfQqNjd7vIxZvjpx9uAD5tbhHNE/
 qwmJTyMxxLTzmRKDlZ2O7N4hehF+ju9IxhfEoTT8EoOJ8Ufsr+A3fcz2h
 3RKn5l8mzC1uEgMMx1MIrCsb4shcGptghrxI1xrjojoGPN+7ODYVUN2Q9
 SYsiReIgrBcMUC+gUTAFlcwVTnaKYbSRkm3e6P0OW6O4Tzc1nGyzBbq9F
 UU0pXf+LO4um+DT+GjEVbch+UuLeD/VrYdMnpwIRgCxesHosu1svpEolw
 jRZ28p/QA50eLuvks/DZLBaCasqOcHF4RYOwe6PQZVlX6wpH7YZ4t7gwU g==;
X-CSE-ConnectionGUID: PCYNtlErQZKYwyGnKpOuKQ==
X-CSE-MsgGUID: NGlwwOgYTJizyrY09w2FXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11405"; a="46190736"
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; d="scan'208";a="46190736"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2025 05:27:09 -0700
X-CSE-ConnectionGUID: 9+kRDaFBQw+PkzHKxw+nGw==
X-CSE-MsgGUID: 4um3NI7cRw2RFa6U+T5I8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; d="scan'208";a="135606266"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2025 05:27:09 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 17 Apr 2025 05:27:08 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 17 Apr 2025 05:27:08 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 17 Apr 2025 05:27:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wy1mdLRUuCb5jc83IFTXngILvbnnSh6B2t5/vGaX+dywi3CVqFcj1hgF1oSgAPePlQwRys10zzD+QU/OCVIrEZf2vsBGqDbXE9cUK0REMI7C9Q3lPRDGa9mqgWpI1kvkeBe3hT858xBjozjaywrQIv3jQDRBT2ZJyxouelXzB3Q/vkkHX9S2zDy9PAMSE86y+wDYU5yiKQc8Z2rPGRbbKEXATyECb8FxkZcXXKPXs/sEoPfJ4qoJga7fmzJLdh3OqAEkPhzgtsAmAxNkIMkLBwn4/ktNG0xmWut2hL2JMSNz+BiJRsHdQdoQfqcE04otdeeQ4GtQIWUDu4g+E7/91A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eWv83wbNVuJvvPENw1Iuo/9NufnZoDCVsTmhYKVjrwM=;
 b=vQ3rYy5r7/D7t6ybTJIjF+4HYcaRXThODeB/Zs9Q89kDqWHjeGABh2G18dXE4dExkD0+o0Nz0+A8cL7NKZuzFi7zQEnscCoqTtQF75kplWlo/WRDNkrotXjWkvbVySIYy/iXcB2la4pigXnXTxEX+2uVakJm5U4QW/VFiHhQS33+no+QaQTV7RcfkWEBfuZnpCA6m8+wsYFqAeko2nkaQzDWtLnbCRtY2PnsrRCT3gUBRP+LWDfkgVmXPba9racUkdI4BtjNNjY0vVIYEMulvVJZy+Zaz3HwQmkbxx2/EN+GQgFGU5awOZGYw5OXdcneFKgRa6fJl8LiLDSK7F2MNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB6803.namprd11.prod.outlook.com (2603:10b6:510:1cb::12)
 by IA0PR11MB8379.namprd11.prod.outlook.com (2603:10b6:208:488::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Thu, 17 Apr
 2025 12:26:45 +0000
Received: from PH8PR11MB6803.namprd11.prod.outlook.com
 ([fe80::8680:ff9f:997:18b4]) by PH8PR11MB6803.namprd11.prod.outlook.com
 ([fe80::8680:ff9f:997:18b4%5]) with mapi id 15.20.8632.035; Thu, 17 Apr 2025
 12:26:44 +0000
From: "Van Haaren, Harry" <harry.van.haaren@intel.com>
To: Gregory Etelson <getelson@nvidia.com>, "Richardson, Bruce"
 <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [RFC] add Rust API for basic port operations
Thread-Topic: [RFC] add Rust API for basic port operations
Thread-Index: AQHbrr+LK/ZTHNB7W0+EGKQZdXJ9pbOntYIl
Date: Thu, 17 Apr 2025 12:26:44 +0000
Message-ID: <PH8PR11MB680361C556B7E2164363C5E3D7BC2@PH8PR11MB6803.namprd11.prod.outlook.com>
References: <IA1PR12MB633009C4430CF2081D824D3AA5BD2@IA1PR12MB6330.namprd12.prod.outlook.com>
In-Reply-To: <IA1PR12MB633009C4430CF2081D824D3AA5BD2@IA1PR12MB6330.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6803:EE_|IA0PR11MB8379:EE_
x-ms-office365-filtering-correlation-id: 9724c41a-56ed-4e39-d9e5-08dd7dab1dc8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?NPzkiHxcOM7/JFet1lMXQcP0J/fqz39uCgG9cenflckO+PSqsKjwh3Kzio?=
 =?iso-8859-1?Q?7foea8gVbhM82x/HrHPWIOhL4l4DwzKDUWWusatjDhQFrniklJSYhJu8qC?=
 =?iso-8859-1?Q?bmFrRmOegxzefvgLICCkt7JAdh7sqZ3oCOTC0B2/zevJEzsoEuVUZSScrc?=
 =?iso-8859-1?Q?c5t+Dhs4vWPj2dFKOgaHxpiVncHvJ/AofkerH1qngLyPEKnt3p+VWVjuP7?=
 =?iso-8859-1?Q?ZSt7GqS6+7B1rwUyv91sDmhJ7DP8tSBrt02hFQ/dx7AquriYbIxRmKHdvI?=
 =?iso-8859-1?Q?SNWLOpTcgItbl6g+JfPpJzUUCbWinGttPPMiwxgRUlxxasdyzcjo/QW/mC?=
 =?iso-8859-1?Q?8zqsUmK3bIPprtiL39De6+/3eF6znYNSgZnwyMKT9LR9TWI4z8Sq695w7N?=
 =?iso-8859-1?Q?4tCwly+66F7XyYsCxYeq2BYk3qB6dbs04tl+0GR8gecPhiBjJWV+nHtkcr?=
 =?iso-8859-1?Q?bv+cXImhXQI6oLYwFKCcZvx0YqPkCaiJkJ4qrcgwNNRrEdJe/NxPLEPDzt?=
 =?iso-8859-1?Q?r7NXooi55lwH/uli4JXaZsTF1J83CDzZ5ycsFdJoTX62VctSy3I7dn9QsC?=
 =?iso-8859-1?Q?+hLAxfHMGiEZo4DeOd4/hUJrbSPNVuD8DUZPsgKlSE64+xd0Yi9jsMXhWm?=
 =?iso-8859-1?Q?onL6Lg1S5evl7Nija5BVQ1V8LWAkno1nolqTsSbuYXWDPG0y9DAKvTF462?=
 =?iso-8859-1?Q?VOwtF21+sSsCzEYVfD0bTsCngyKqCxxROPEFdI5hqRLFHR2BydeYHZOLHe?=
 =?iso-8859-1?Q?ILv0cI4Cumwy8I2RRYRbe8gWzDStNQlql/WXU9947jO9wNTuc/1drVaHmo?=
 =?iso-8859-1?Q?4oDetMJgPIkK3dfSwzq368iUAVJr+tRqKPXnXOmxYDXUctxjaoH7P8upk9?=
 =?iso-8859-1?Q?zM8a855T4sc9qbB5La66sbqrUSTqJWEGn9lHix7+ILZFg71jr/KrCuWp4w?=
 =?iso-8859-1?Q?jpnj8rMVB9+36E3+eJ/ADVaWVDeokaoiNbtJ4xrMkEPXVM/pCNvIhc5007?=
 =?iso-8859-1?Q?OUL1VUR516ADWjBbUhLcs9/xRjnY9AWntoN+vK99vZUMBCxCiOVsagAiwJ?=
 =?iso-8859-1?Q?QShDgdLg/p3hvvyzqwLiIJqXeNY31YTSxEGpbjj6Y3DpPLFSzs8RCZNSoZ?=
 =?iso-8859-1?Q?LSdUmTM9jIVxH+KNh32I/STkVK4rmLu1piMr/GB0lLn/nx/FU3rpvssclw?=
 =?iso-8859-1?Q?yJWrz68X6xn7Yk4lFP9FQfOjFAJfhryG5NB3Km2kE4leYSf9kU+LgJ9NYK?=
 =?iso-8859-1?Q?f8i7bPNXtmK4ErsKp5TJPR3AR+EPRrvAXXeb49w34aQ4+Xa42rVtRWyRee?=
 =?iso-8859-1?Q?N7LbJtPi0Qk3Oov0vyCfFyRsoAg+ZE8RqgS3ivSMZW0YOzKIG48ffwuBH+?=
 =?iso-8859-1?Q?n1iTXj/YVveBZ7vGEtzQG41IXYSvQlAh+v1mSxtMivISUdjmBXSCoXYZX0?=
 =?iso-8859-1?Q?TKAuMhU7JeBMQFjnOivPjcD3EgL7VYHmCsrJXJan51lc5DIu3tjQqWB6r9?=
 =?iso-8859-1?Q?M=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6803.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?RNa+TuhNB/ILFgSw77mAcj0kBu+Gl4Y/ACb9/yi7XvlGCpW1lA8XsT3C1d?=
 =?iso-8859-1?Q?V3u1Us24MHbqa2rsUxL9vPizl/wJ0EsQV9BWpzDx2S49ykvcQ9i2DvUME0?=
 =?iso-8859-1?Q?2cETtv60H7olVw88bU5VqkPYyzF3Vvdzo17p7YthILZzrWEexI67mausF4?=
 =?iso-8859-1?Q?aOugqZN3lJBp6+jpfZJ0ik++m+C8VYwFTRwlax5GuIyDjSrFrzsUta82fx?=
 =?iso-8859-1?Q?ea4i+rvskp4w5mSoEr0iOeAxDMRGSEqaCnszcpZx86GaL6m+lK1Z1XJVEu?=
 =?iso-8859-1?Q?8Qhq0CmZF/7Wl5MoWZTlmtH35P/RGLM6CC82/8a1lMpKxseVUxp5n3/jtk?=
 =?iso-8859-1?Q?KaiHWbqvC6z7MavUD3sxRUvQIXFMILVojv+KWznVxKAjcf0hugSB3aBDW/?=
 =?iso-8859-1?Q?a3aAjwmrZLpM7AOe8/Kb0NpPjsluQF08CgWidtHRampKaXo0R+dyQ5uCkG?=
 =?iso-8859-1?Q?SdyWmpqlZu/d4OS58JUQ9v9LMBWPaCEUpzGk2w7R19FGyVIdQR5kn+Lnc9?=
 =?iso-8859-1?Q?sY9leys5uGw6wuTveqPgKVoDTolsEvi3dcm+RiKp65cvw0d4gRCrUuqvas?=
 =?iso-8859-1?Q?FqOkjuY45Wi5E28KjErzNHac9vRPUE8RG0ZDiyFcnn4FDu4HatCg2dSb8V?=
 =?iso-8859-1?Q?/sfW0YIwjL0uFKIx8Nv0iCpD4/wNoUGaofb3twMV8IJjRObxIDO6fJ7YQT?=
 =?iso-8859-1?Q?JoxmuSvQCb5SL6f86N/M+v8r6C6RVXXQoFstSN3I1r7U5E2A3zMdrOhSKj?=
 =?iso-8859-1?Q?0rWXd2U0OQjnqPPngAb/kJSFLemV9KyXQs05awcBH866YBVWKQJk2UNDEs?=
 =?iso-8859-1?Q?Bj3YvrYHD9dAh5ZiP5+y4O+rk31LGn31sPtOVtbzh69UD5ME5/FkLlIYkN?=
 =?iso-8859-1?Q?yzkUo/Lu8wx6CivNCJVzfhZzzM719IzVij/hhnty1iNaXhYHeePWYTgHVp?=
 =?iso-8859-1?Q?oE7/45D03ivGUbK5WMV3TAU/WjtfWVtCjG/96342Fnj3ZDhVYThfqp4gnn?=
 =?iso-8859-1?Q?sCi1+kokrc6J/brlOtVwkR9uCQL22FMEh+Ojm2Gij7U23OFvpFy3jHMVlU?=
 =?iso-8859-1?Q?q49atr2z8LoZ6QjC6Hz/qCI47HidE95kojlzTOvRJcyukiPnHvsLSbJXMX?=
 =?iso-8859-1?Q?LjtgmDe/+IV3ilyHs31yMOsB6d6pJH1bcAv6Vkt6Aetxcdh23bM1sdBR8t?=
 =?iso-8859-1?Q?WOSFstcs5lRIPGlKGKxTQejsmiBk/IZPXfUGrv2tDwTSE6VSRwxIQPK1ft?=
 =?iso-8859-1?Q?VoI8jKWQgKkf7Pje30J0o0SxP+I2jqUExyR5BujFy4rnriqSSzAurmF5b9?=
 =?iso-8859-1?Q?tqPkM1H3IAJey/8fgHDG3Br2EhO4rK/VYQC90uWFDIKJxRIMiUyStaPCGF?=
 =?iso-8859-1?Q?z1aIb9S71YzA3twtDSch6N9hZAUkyNXdOuDHVd5tKFdIDGbFlU+Mhkkzsc?=
 =?iso-8859-1?Q?c8lyd7sCYCgTuDVZPINadjv5RHuSqxmfss1HkOJS4KDPy+iKY1o5PRms/f?=
 =?iso-8859-1?Q?hezsidFxhyiSjpTevDkCp+y8ZZqNqrfZxcKMmPZ818OWsAlpvE1pUmcE8M?=
 =?iso-8859-1?Q?/sH7P3u5J1YjfO6OWhQfGAPRldHtW6wmCx3et2tpvUeRj2PdyzyCGMNZRP?=
 =?iso-8859-1?Q?3b/cLMVa562KzCw8KgT/PWSSr7k6ziBew4?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6803.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9724c41a-56ed-4e39-d9e5-08dd7dab1dc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2025 12:26:44.8871 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gYpgzLpsWdmVRxeiZ7DtT+u7W8BRmr2DKrUjCcxsUP29CFVJD585HEu7tzWqDNvK0WeH1xMl2woOpCaUfijXzeRkpDNWwIBVjduwaLOMWVk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8379
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

> From: Gregory Etelson=0A=
> Sent: Wednesday, April 16, 2025 12:42 PM=0A=
> To: Van Haaren, Harry; Richardson, Bruce=0A=
> Cc: dev@dpdk.org=0A=
> Subject: [RFC] add Rust API for basic port operations=0A=
> =0A=
> This RFC proposes Rust API for basic DPDK port management and IO operatio=
ns.=0A=
=0A=
Thanks for posting this RFC. I'll share my API RFC in the coming days too, =
for now=0A=
some feedback (which is already integrated/existing in the API I've been wo=
rking on)=0A=
=0A=
Bigger picture; the APIs below implement "DPDK C API thinking" in Rust. I'd=
 like to rework the APIs to be "DPDK with Rust Ergonomics" instead:=0A=
=0A=
Example:=0A=
1) DpdkPortConf::new_from(0, c_dev_conf_struct, c_rx_conf_struct, c_tx_conf=
_struct, 8, 8, 512, 512, mempool (or None));=0A=
    - the API here is not use case focussed. The values passed in are docum=
ented, but not easy to explore/understand.=0A=
=0A=
2) let ports =3D dpdk::get_ports(); // returns a Vec<DpdkPort>=0A=
   let p =3D ports.get(0);=0A=
   p.rxqs(8, rx_mempool)?;=0A=
   p.rx_crc_strip(true);=0A=
   p.set_rss_hash(&[0,1,2,3..N])?;=0A=
   =0A=
   // Notes: configure RX values: note the type-safe, and english-syntax fu=
nctions.=0A=
   // These functions prompt in modern IDEs, making "exploring" APIs easy/f=
ast/intuitive (struct member bit-fields are not as easy to explore)=0A=
   // The "rxqs()" function takes the parameters it needs (u16 count, and a=
 Arc<Dpdk::mempool> object)=0A=
   //   - this avoids exposing an "Option<Arc<Mempool>>" publically, hiding=
 impl detail, giving better ergonomics=0A=
   // Notice the "?" operator, this can be used "inline" to early-return an=
d error (e.g. rss_hash array has incorrect length)=0A=
=0A=
=0A=
The ability to error check individual functions/APIs allow better error rep=
orting to the user,=0A=
specifically at the point where the error occurred. As these are not datapa=
th APIs, allocations and=0A=
overhead in the failure case should not be a problem - user-experience is t=
he goal:=0A=
=0A=
1) on error: -EINVAL returned from rte_eth_rxq_configure(), difficult to se=
e what parameter caused the -EINVAL.=0A=
2) on error: "rss_hash has invalid lenght of 42" (or whatever we make the D=
ebug/std::error::Error impl say)=0A=
=0A=
To summarize, "use-case focused APIs" are easier to read, debug, and mainta=
in.=0A=
The work here is to design/build these Rust ergonomic APIs: it takes DPDK k=
nowledge, and some Rust API=0A=
best-practices to figure these out. There's probably a "playbook" of like 3=
 rules/strategies, which will=0A=
cover 90%+ of the API design.=0A=
=0A=
Hopefully this email is a starting point; some resources for future reader'=
s reference;=0A=
- https://burntsushi.net/rust-error-handling/=0A=
- https://corrode.dev/blog/idiomatic-rust-resources/ (look for "error-handl=
ing" tag)=0A=
=0A=
=0A=
> ```rust=0A=
> /// Configuration details for a DPDK port.=0A=
> ///=0A=
> /// # Overview=0A=
> ///=0A=
> /// `DpdkPortConf` is used to initialize and configure ports in a DPDK en=
vironment. It includes:=0A=
> /// - Device information (`dev_info`) pulled from DPDK.=0A=
> /// - Transmit and receive configurations, including queue settings and m=
emory pools.=0A=
> /// - Details about the number of queues and descriptors for transmission=
 and reception.=0A=
> ///=0A=
> /// This struct is typically instantiated using the [`DpdkPortConf::new_f=
rom`] method.=0A=
> ///=0A=
> /// # Example=0A=
> ///=0A=
> /// ```=0A=
> /// let conf =3D DpdkPortConf::new_from(=0A=
> ///     port_id,=0A=
> ///     dev_conf,=0A=
> ///     tx_conf,=0A=
> ///     rx_conf,=0A=
> ///     8,               // Number of RX queues=0A=
> ///     8,               // Number of TX queues=0A=
> ///     512,             // RX descriptors=0A=
> ///     512,             // TX descriptors=0A=
> ///     0,               // RX queue socket ID=0A=
> ///     0,               // TX queue socket ID=0A=
> ///     Some(rx_mempool) // RX queue mempool=0A=
> /// ).unwrap();=0A=
=0A=
A few observations; The DpdkPortConf itself is a Rust struct, but internall=
y it exposes a number=0A=
of "pub" fields (rte_eth_dev_info, _eth_conf, rte_eth_rxconf, ...), which a=
re directly bindgen-ed=0A=
from the DPDK C API. While this works, it will not provide the ergonomics w=
e'd like for Rust code.=0A=
=0A=
For example, the eth_dev_info->driver_name is a CString (aka, const char *)=
, which needs to be=0A=
converted to a safe Rust CString or CStr (see https://doc.rust-lang.org/bet=
a/std/ffi/struct.CStr.html#method.from_ptr)=0A=
=0A=
A big value add in Rust development is the automatic "Debug" implementation=
s, allowing one to just=0A=
        println!("{dev_info:?}");=0A=
 a struct, and that the compiler is able to identify the contents, and pres=
ent them automatically.=0A=
 That will not work if we have C structures with pointers, resulting in bad=
 debug/logging for users.=0A=
=0A=
=0A=
> /// =0A=
> #[derive(Clone)]=0A=
> pub struct DpdkPortConf {=0A=
>     /// Information about the DPDK Ethernet device (e.g., driver, capabil=
ities, etc.).=0A=
>     pub dev_info: rte_eth_dev_info,=0A=
> =0A=
>     /// Configuration for the Ethernet device. Determines the overall beh=
avior of the device.=0A=
>     pub dev_conf: rte_eth_conf,=0A=
> =0A=
>     /// Configuration for transmitting (Tx) packets on the Ethernet devic=
e.=0A=
>     pub tx_conf: rte_eth_txconf,=0A=
> =0A=
>     /// Configuration for receiving (Rx) packets on the Ethernet device.=
=0A=
>     pub rx_conf: rte_eth_rxconf,=0A=
> =0A=
>     /// Number of receive (Rx) queues configured on this port.=0A=
>     pub rxq_num: u16,=0A=
> =0A=
>     /// Number of transmit (Tx) queues configured on this port.=0A=
>     pub txq_num: u16,=0A=
> =0A=
>     /// Number of descriptors for each transmit (Tx) queue.=0A=
>     /// Descriptors represent items in a queue to handle packets.=0A=
>     pub tx_desc_num: u16,=0A=
> =0A=
>     /// Number of descriptors for each receive (Rx) queue.=0A=
>     pub rx_desc_num: u16,=0A=
> =0A=
>     /// NUMA socket ID associated with the memory used by receive (Rx) qu=
eues.=0A=
>     pub rxq_socket_id: u32,=0A=
> =0A=
>     /// NUMA socket ID associated with the memory used by transmit (Tx) q=
ueues.=0A=
>     pub txq_socket_id: u32,=0A=
> =0A=
>     /// Memory pool associated with receive (Rx) queues.=0A=
>     /// This manages the buffers used for storing incoming packets.=0A=
>     pub rxq_mempool: Option<Arc<DpdkMempool>>,=0A=
> }=0A=
=0A=
Any reaons that rxq_mempool has an Option<>..? Is it for TX-only port confi=
gurations?=0A=
That's the only thing I could imagine is a cause. See above API where RX an=
d TX are=0A=
configured independently - this avoids passing an "RX mempool" at all, if o=
nly TX is configured!=0A=
=0A=
=0A=
> /// A trait defining basic operations for managing and interacting with a=
 DPDK port.=0A=
> ///=0A=
> /// # Overview=0A=
> ///=0A=
> /// The `DpdkPort` trait standardizes how to operate on DPDK ports, makin=
g it possible to:=0A=
> /// - Configure the Ethernet device using [`configure`].=0A=
> /// - Start the device using [`start`].=0A=
> /// - Handle Rx and Tx bursts of packets using [`rx_burst`] and [`tx_burs=
t`].=0A=
> ///=0A=
> pub trait DpdkPort: Send + Sync {=0A=
=0A=
This trait provides a very C API centric view. Unfortunately, that view doe=
s not include the=0A=
Rust API semantics we need for RXQ and TXQ being Send/!Sync (see https://yo=
utu.be/lb6xn2xQ-NQ?t=3D802)=0A=
=0A=
Example of INCORRECT usage of this RFC API (that Rust compiler cannot help =
with)=0A=
 (refer to https://github.com/getelson-at-mellanox/rdpdk/blob/main/port/mlx=
5/mlx5_port.rs#L30 for port creation)=0A=
thread 1:=0A=
   let port =3D Mlx5::from(0, &port_conf);=0A=
   let pkts =3D &mut [*mut rte_mbuf; 32];=0A=
   port.rx_burst(0, &mut pkts); // segfault simulateous access on (port/que=
ue combo)=0A=
=0A=
thread 2:=0A=
   let port =3D Mlx5::from(0, &port_conf);=0A=
   let pkts =3D &mut [*mut rte_mbuf; 32];=0A=
   port.rx_burst(0, &mut pkts); // segfault simulateous access on (port/que=
ue combo)=0A=
=0A=
The problem here is that the user was able to create two "handles" to the s=
ame "port".=0A=
And from that handle of a port, it was possible to call rx_burst(), (or tx_=
burst(), etc).=0A=
=0A=
The Rust compiler cannot identify that Mlx5::from(0) is not safe to call tw=
ice.=0A=
My current preferred solution is to have a Dpdk::eth::get_ports() API, whic=
h returns=0A=
all the port instances. This removes the user's ability to "create" ports a=
t all, and hence=0A=
it cannot be mis-used either.=0A=
=0A=
All in all, the method in which C DPDK APIs work (pass in integer ID for po=
rt/queue), is=0A=
a very different to how safe Rust APIs will look when building in Send/Sync=
 safety.=0A=
=0A=
=0A=
=0A=
>     /// Returns the port ID of the DPDK port.=0A=
>     ///=0A=
>     /// # Return Value=0A=
>     /// A `u16` that uniquely identifies the DPDK port.=0A=
>     ///=0A=
>     /// # Example=0A=
>     /// ```=0A=
>     /// let port_id =3D dpdk_port.port_id();=0A=
>     /// println!("DPDK port ID: {}", port_id);=0A=
>     /// ```=0A=
>     fn port_id(&self) -> u16;=0A=
> =0A=
>     /// Returns a reference to the configuration object of the DPDK port.=
=0A=
>     ///=0A=
>     /// # Return Value=0A=
>     /// A reference to [`DpdkPortConf`], which contains various settings =
like Rx/Tx queue configurations,=0A=
>     /// memory pools, and NUMA socket IDs.=0A=
>     ///=0A=
>     /// # Example=0A=
>     /// ```=0A=
>     /// let port_config =3D dpdk_port.port_conf();=0A=
>     /// println!("Rx queues: {}", port_config.rxq_num);=0A=
>     /// ```=0A=
>     fn port_conf(&self) -> &DpdkPortConf;=0A=
> =0A=
>     /// Configures the DPDK Ethernet device with the settings specified i=
n the port configuration.=0A=
>     ///=0A=
>     /// This method is typically called before starting the port to ensur=
e it is prepared for Rx and Tx operations.=0A=
>     ///=0A=
>     /// # Return Value=0A=
>     /// - `Ok(())` if the configuration was applied successfully.=0A=
>     /// - `Err(String)` with a descriptive error message if the configura=
tion failed.=0A=
>     ///=0A=
>     /// # Example=0A=
>     /// ```=0A=
>     /// let result =3D dpdk_port.configure();=0A=
>     /// if let Err(err) =3D result {=0A=
>     ///     eprintln!("Failed to configure the port: {}", err);=0A=
>     /// }=0A=
>     /// ```=0A=
>     fn configure(&mut self) -> Result<(), String>;=0A=
> =0A=
>     /// Starts the DPDK Ethernet device.=0A=
>     ///=0A=
>     /// This method initializes the Rx and Tx queues, making the port rea=
dy for data transmission=0A=
>     /// and reception.=0A=
>     ///=0A=
>     /// # Return Value=0A=
>     /// - `Ok(())` if the port was started successfully.=0A=
>     /// - `Err(String)` if the startup process failed, with a descriptive=
 error message.=0A=
>     ///=0A=
>     /// # Example=0A=
>     /// ```=0A=
>     /// let result =3D dpdk_port.start();=0A=
>     /// if let Err(err) =3D result {=0A=
>     ///     eprintln!("Failed to start the port: {}", err);=0A=
>     /// }=0A=
>     /// ```=0A=
>     fn start(&mut self) -> Result<(), String>;=0A=
> =0A=
>     /// Receives a burst of packets on the specified Rx queue.=0A=
>     ///=0A=
>     /// # Parameters=0A=
>     /// - `queue_id`: The ID of the Rx queue to receive packets from.=0A=
>     /// - `pkts`: A mutable reference to an array of packet buffers (`*mu=
t rte_mbuf`) where received packets=0A=
>     ///   will be written.=0A=
>     ///=0A=
>     /// # Return Value=0A=
>     /// - `Ok(u16)` containing the number of packets successfully receive=
d.=0A=
>     /// - `Err(String)` if the operation failed.=0A=
>     ///=0A=
>     /// # Example=0A=
>     /// ```=0A=
>     /// let pkts: Vec<*mut rte_mbuf> =3D vec![std::ptr::null_mut(); 32];=
=0A=
>     /// let received =3D dpdk_port.rx_burst(0, &pkts);=0A=
>     /// match received {=0A=
>     ///     Ok(count) =3D> println!("Received {} packets", count),=0A=
>     ///     Err(err) =3D> eprintln!("Rx burst failed: {}", err),=0A=
>     /// }=0A=
>     /// ```=0A=
>     fn rx_burst(&mut self, queue_id: u16, pkts: &[*mut rte_mbuf]) -> Resu=
lt<u16, String>;=0A=
> =0A=
>     /// Sends a burst of packets on the specified Tx queue.=0A=
>     ///=0A=
>     /// # Parameters=0A=
>     /// - `queue_id`: The ID of the Tx queue to send packets on.=0A=
>     /// - `pkts`: A reference to an array of packet buffers (`*mut rte_mb=
uf`) to send.=0A=
>     ///=0A=
>     /// # Return Value=0A=
>     /// - `Ok(u16)` containing the number of packets successfully sent.=
=0A=
>     /// - `Err(String)` if the operation failed.=0A=
>     ///=0A=
>     /// # Example=0A=
>     /// ```=0A=
>     /// let pkts: Vec<*mut rte_mbuf> =3D vec![some_packet_ptr1, some_pack=
et_ptr2];=0A=
>     /// let sent =3D dpdk_port.tx_burst(0, &pkts);=0A=
>     /// match sent {=0A=
>     ///     Ok(count) =3D> println!("Sent {} packets", count),=0A=
>     ///     Err(err) =3D> eprintln!("Tx burst failed: {}", err),=0A=
>     /// }=0A=
>     /// ```=0A=
>     fn tx_burst(&mut self, queue_id: u16, pkts: &[*mut rte_mbuf]) -> Resu=
lt<u16, String>;=0A=
> }=0A=
> ```=0A=
=0A=
Having a single trait with configure(), start() and rx_burst() makes it imp=
ossible to encode the=0A=
Send/Sync attributes of the "Port" concept, and the "RxQueue" concept seper=
ately.=0A=
So perhaps a solution with two traits could work; I haven't investigated in=
 detail yet.=0A=
=0A=
=0A=
> The API uses raw FFI pointers in DpdkPort rx_burst() and tx_burst() to pr=
eserve DPDK performance.=0A=
=0A=
Cool, nice trick... but does it remove all virtual functions/function-point=
er dispatch?=0A=
- https://github.com/getelson-at-mellanox/rdpdk/blob/main/app/runpmd/runpmd=
.rs#L143=0A=
This seems to accept a "&mut Vec<Box<dyn DpdkPort>>", which would mean the =
".rx_burst()"=0A=
is a virtual-function into the trait, and then a function-pointer into the =
PMD?=0A=
=0A=
It could be interesting to change "do_io" to a generic function, taking a g=
eneric DpdkPort instance? Then the first level=0A=
trait-resolution would become compile-time (through Rust compiler monomorph=
isation of the generic do_io<Pmd: impl DpdkPort>() into a=0A=
more specific  "do_io<Mlx5>()"  code?=0A=
=0A=
I don't believe this to *actually* matter for performance. It might matter =
for an IO-forward, 0 packet data processing test.=0A=
So micro-benchmark bragging, yes this has impact... but touch the packet da=
ta and it no longer matters!=0A=
=0A=
=0A=
> The API implementation is here:=0A=
> =0A=
> API definition:=0A=
> https://github.com/getelson-at-mellanox/rdpdk/blob/main/lib/port/port.rs=
=0A=
> =0A=
> API implementation with RTE function calls:=0A=
> https://github.com/getelson-at-mellanox/rdpdk/blob/main/lib/port/raw_port=
.rs=0A=
> =0A=
> Implement direct calls to mlx5 Rx/Tx IO functions: =0A=
> https://github.com/getelson-at-mellanox/rdpdk/blob/main/port/mlx5/mlx5_po=
rt.rs=0A=
> =0A=
> =0A=
> Signed-off-by: Gregory Etelson <getelson@nvidia.com>=0A=
=0A=
Thanks for sharing the links and RFC!=0A=
=0A=
I will share the RFC API that communicates the Send/Sync requirements to th=
e Rust compiler for Ethdev Port Rxq as a sample,=0A=
and we can try compare/converge the "trait DpdkPort" and the compile-time-t=
hread-safe approaches into the best API?=0A=
=0A=
Regards, -Harry=
