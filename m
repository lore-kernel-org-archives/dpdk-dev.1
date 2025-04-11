Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD60FC36010
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Apr 2025 16:22:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9E26F40A7D;
	Fri, 11 Apr 2025 18:22:57 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 026124025F
 for <dev@dpdk.org>; Fri, 11 Apr 2025 18:22:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744388576; x=1775924576;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=NapwWfeBxN+3RJDn9+g2sAkVRRNmtSLkFt0aB2Xf3r0=;
 b=XOUMUbaP/0uhyvQ+4twtSfJeUQAc93QFR+1ainUkNBPZmSZCI3YzKEK0
 yJy7gX8CKoqSkFBvQaD753j9pR+WjflfHIEM1dWdvORsdC0hC0HnSKyYs
 UKNGj1bdeKDbMCvnFyNX4MXaKPUC27YWuNbkFKDqZAbAr6aU1Bjpxb/oz
 YKpsuOR2URp6txqmabF4foo0UqoWlsvH6fikmHhuT02vvRzfjCr/+Y+L5
 s8DzEZt9TyGW7//nrBTvEPAlFPt99uABQ2tLqSFGkgkcvKM2vnARa2PCj
 10vAbU6sSW/TVXnu3YW5yyd9klgbh0EWmdw12sHJ9QOyOjm9Wmt4ba6Ir A==;
X-CSE-ConnectionGUID: TiP/aE7WRJ2O8zaSG32aAg==
X-CSE-MsgGUID: xo2FdWk9SQe3qVfXa2QeQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11401"; a="57315287"
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; d="scan'208";a="57315287"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Apr 2025 09:22:53 -0700
X-CSE-ConnectionGUID: JvyEzXX6RxW8yzQ6rZfYwQ==
X-CSE-MsgGUID: X2QxETVgSs+zVdIqlxzQ6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; d="scan'208";a="129588679"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Apr 2025 09:22:53 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 11 Apr 2025 09:22:52 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 11 Apr 2025 09:22:52 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 11 Apr 2025 09:22:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ip7ozjLqU1fwzGjLvOjyjlzL9REv2XIaYF8/IiAdTJJ0Y8ESRHzYxq//zMV0nr8EGynwqbp0pMywTvgOkcF6FLiQ37XHLeEUmj5PfBCiwX0TfVe69YHm9fXnCCe34r/XkgU0vEhneiUqiQX3lAuCZQS/teQqH/Ws48uJqOrdOaXSBgtCEUD3WqhyIGMBBH5VBnCxATzEd5EeIN+PmmB3YMJcYWYflJA/E35yTxX3x5oQSOGcwbFlU8hiR97OGnVc2uH9YCbX3SGOqkCq5egAL6AFChHeOOm0/Y+aZ5MjnAWf/vNxTEaXjBnBG2uF39Z0f3vNj7/kyoF8ifxs1F53gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NapwWfeBxN+3RJDn9+g2sAkVRRNmtSLkFt0aB2Xf3r0=;
 b=gAE3AUWwtBp+ZNogDh3PvOqvuW6l5kyYW2SB6a2iPkaToH5RBvIBYLhwEQO/ujgVxrYb6Qc3jtZaufr+CABDfegRXT/3TuGR6PJyiLrFr+vFT3m8X6Hnn4fJ0a/8VwKhPfatWAGKCLv2/d6NmToslBCTnCyRqGHcVkKkhaN14wCjDYtISmmglHDlTVE7BICYP5G8CWodJU7NaJ3Jn5io8OFKIxW9N25jgO/xqkfpVHc/Niq+6FsBh1geEVed3KesBQ2uCuG0Qh2ARU+7rCh/320M/TkHxsdDmHj4ryPX6R27zfbeJMA6EBB8h/pFJmSsrcg0r60TkrL7Y6qgO7oU+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB6803.namprd11.prod.outlook.com (2603:10b6:510:1cb::12)
 by DS0PR11MB7629.namprd11.prod.outlook.com (2603:10b6:8:146::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 16:22:19 +0000
Received: from PH8PR11MB6803.namprd11.prod.outlook.com
 ([fe80::8680:ff9f:997:18b4]) by PH8PR11MB6803.namprd11.prod.outlook.com
 ([fe80::8680:ff9f:997:18b4%5]) with mapi id 15.20.8632.017; Fri, 11 Apr 2025
 16:22:18 +0000
From: "Van Haaren, Harry" <harry.van.haaren@intel.com>
To: "Etelson, Gregory" <getelson@nvidia.com>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: Re: [RFC PATCH] add rust binding support to DPDK
Thread-Topic: [RFC PATCH] add rust binding support to DPDK
Thread-Index: AQHbqJbQrTpmpKHoHE2sfKugVvsbB7OcYZ4AgAIImgeAADRNAIAAA2F5
Date: Fri, 11 Apr 2025 16:22:18 +0000
Message-ID: <PH8PR11MB6803A8EFAF0A3E8DA8211254D7B62@PH8PR11MB6803.namprd11.prod.outlook.com>
References: <20250306133713.393057-1-getelson@nvidia.com>
 <20250408145838.2501034-1-bruce.richardson@intel.com>
 <187447a-fb49-2833-7e44-ad5bb0d67a99@nvidia.com>
 <PH8PR11MB6803EEFBDE79D34996494ADAD7B62@PH8PR11MB6803.namprd11.prod.outlook.com>
 <95367723-36f5-13a4-b513-27a7b4f7ee7c@nvidia.com>
In-Reply-To: <95367723-36f5-13a4-b513-27a7b4f7ee7c@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6803:EE_|DS0PR11MB7629:EE_
x-ms-office365-filtering-correlation-id: e33f2f2c-58d5-40bf-1fc1-08dd79150770
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?ouFDHaEY/NXQE+cJbpYbebfTi+ESRFdB9xOWkkZfSUI42wvpGJXyOqqIjM?=
 =?iso-8859-1?Q?1XjZ0BAR7VeoaUJxQwxvaHzkriGThjldqC4JHLw1VDvRlqJ5nyhi88P3sb?=
 =?iso-8859-1?Q?zfz9LDNOGvCZIU9o2qHoT1K6QlL0EYuRiwdN0qOtxdtw71d4pCy2LaWcVd?=
 =?iso-8859-1?Q?ge3QygRslQCiaQS71/uh+btmtLmEdPL6F3eiNuUKrgQ5PqVhnDN5XIcYEE?=
 =?iso-8859-1?Q?P3YYVuDFbp1bzU9mlIoqew/E2aCgPt3F11gV26szkqAn2Up6fE7s5nn/1p?=
 =?iso-8859-1?Q?epcQXMttPtpaJoAJxzbeR0brayGeH2IkyIikkFac8tDX1U9f8BD7gQfr0M?=
 =?iso-8859-1?Q?/k/jeNppc4SnWqf9T+JQf4xU1pRigW5laVqSCWx7aysgfWz+r/UEMlCSNs?=
 =?iso-8859-1?Q?oqTsJD81lCLi4XDEm6wAyGfMrka0hIRblHud8URxPSEiGICGmkzIydRMN+?=
 =?iso-8859-1?Q?nBSqL/xOsjRT2wk7aUiD1/0pSvWvoBj40PLYBoVdi7ybIBFwPAuqIZecej?=
 =?iso-8859-1?Q?FaLohJRJeX0TuAomsJH3GMghpxdO8og9bOvgBlhz4r9OGO/SY56DDkxPzG?=
 =?iso-8859-1?Q?zCBGZ7Pclshjnq29iIhVq2StP06JSU+I9GWgDvSmnTO9Onqt84q1MFnPEU?=
 =?iso-8859-1?Q?qobHEmvadCxNkTdZJwCxtHcf8bT9fiu9WcSrG//Z/Pa3Ct9L8XbR7N/l25?=
 =?iso-8859-1?Q?32XZO2RexmBmLEu/3C+1f9g76MWo+BUPUrWieRwtH5xHZrNAGgjiMmE5dL?=
 =?iso-8859-1?Q?aIaYDH6fwmG3ECcUEkalSLH54fRWDFjy+KTheUq8LEPn0+v/EcpyF3iidE?=
 =?iso-8859-1?Q?x/xNyeUJyRLFkXsys/mgM8qdhCKrorTG5BUFvM+XAORZ+9LYzCDnMYhHbH?=
 =?iso-8859-1?Q?RPtIQwW88jTErdu3+LksxGS4Cz9+iBBsabdMr3ydWi09YGRcG3Z9peoR8k?=
 =?iso-8859-1?Q?GGjC4fRiJrwr7ulRPHOdbj/5TdaWv/d7ThYLJkayilIgzrn7batS9J3zNR?=
 =?iso-8859-1?Q?2lq/PxZWbhGWnRXax3DIO84mP+ZkCNs2t2mzh4L63mlnJluPhxlK65/gRS?=
 =?iso-8859-1?Q?CEOJcy+ZEhZb29L8zskgR7cVfJk+NTbxIkXtDPOih7buGHG9Fx5dQSLHiw?=
 =?iso-8859-1?Q?S+OeWJu263BBtmJ3wYrmToR+6A68KCJ/ycDCojg9n4EK/iGpDa2Xp4wBYj?=
 =?iso-8859-1?Q?V0CZHzvtkcfIaikq/3EOWX1TtpdR48MHgEDDP5R9AP9LRKUzy35lPv1usK?=
 =?iso-8859-1?Q?esYpG3yb/ndOh1lXDTPQqezN9FpZpCSG5BjZcR7ZaByThhgzBFqSJ2i7dX?=
 =?iso-8859-1?Q?MFQSO1f8q28kdI1WEU1nFev4rET3kWRvT5ZC2XNLPDcxy526w9bMfS/DbW?=
 =?iso-8859-1?Q?JAV4avT8g8Y3x8cpwDpzsWiAk/ccYuSg74yNhZeYyJ/YGEiORkPbZ00+Ok?=
 =?iso-8859-1?Q?mjM3UzO4rH2fsnhPtqgierI4ZP1nvufCSlyWak9e0+QW9CJ8Tj8/lNCPyC?=
 =?iso-8859-1?Q?BSWaWayr9qYZfNn8RaqvD4WRFeK4+SX4MWH5YmqUxBedBe3CXZGTBm02WH?=
 =?iso-8859-1?Q?tZJK/II=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6803.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?td1lLmzNNAyn9dBnRxDGTJv1+7jSEvWEYzOjbcy9AsbEGFzIfffcLUEyc1?=
 =?iso-8859-1?Q?5R3Ql7amuzNur+OxTD4AHB4zNM67IwfP9cA6c+BQdtOBV3GEEXK8PHMWQN?=
 =?iso-8859-1?Q?ljw1M97OVkEvVgQel7zjAmrO6g/3eVeoW0L/OkPQ0nCStB2ScrtODkRU0X?=
 =?iso-8859-1?Q?ISSr7N/8uKrV4YF/TFOIXSVTaGB0j8Ub6VkLo/b4gHF8SlQl9z6IQ9uK46?=
 =?iso-8859-1?Q?QPlxpl+In0huiw3dbflcmZEP/wl2LKz4uumRzXIVX+uhup7037SV+Z10Cg?=
 =?iso-8859-1?Q?ZJyYpThw7H30SiOzf+wSXZIFcL3Q+QaZRqLgWDLaWAnIgEPJ3L/+ZnVAxb?=
 =?iso-8859-1?Q?SZRDNrEiPWc9W6wLmKsxzCpv6tTbIc02fVX3z9qDsh9A1EQMKvMdrV7cGJ?=
 =?iso-8859-1?Q?gwAQsavqWS5N2nnefzuEX+vkqaamstp4sEiLHr/4Ui97zEfdhTExwQQBa4?=
 =?iso-8859-1?Q?8kkRf5xJAhqjsgPyYKIUDfj1OsGf12GlgX6EEgmQcu8fcrFr0GkskRJYM9?=
 =?iso-8859-1?Q?gJkLzjcAi5ZMXDBR5/BFY18AytosawG8bJDAzEO/a5i4E1SrB4ZpuAbOJH?=
 =?iso-8859-1?Q?RdOZbCBQ1v528URcPSba7HkrXVxZsLlL+QyulNfYYF7BoiKLlRdCjTJSEt?=
 =?iso-8859-1?Q?BRphUMe8s4T2YvZ5hJtOswT7CcIiKvnOK+fVctFnMLcrP8DCJp1qnb079Q?=
 =?iso-8859-1?Q?/lcA0lusRSOQkHyJX1ao+gMC/vwgtFuC3sdTkuw077JNoQChIS/icszXM9?=
 =?iso-8859-1?Q?gs+KvQlhSIFL0NaNBFF2E/jo0S8gpkXQnOPVr1OXNvF4RoNr31qrDC7OG3?=
 =?iso-8859-1?Q?BUirjwSBIb5lH8SNkAzVRoADcK/HpD4ZqG6qeTUl602UfUrUpFarK7vTC9?=
 =?iso-8859-1?Q?UsEjhN0ZnwtVfX3+JMB9sliMP+LlSD50z9wy6mz8LvFcI8vRNdC2Sct4GO?=
 =?iso-8859-1?Q?Uyzz8rAUuIdWahD8y1DPHH02mEcey5sou3z+jpMX3huk9WeTDx3W9of8CJ?=
 =?iso-8859-1?Q?W/loSOdK+N5o/TPwnNnuTwhqAmHTNtitmxb8wNf9jzjUfbYNyRfzYunipc?=
 =?iso-8859-1?Q?O5G92UEt0ONfASg6SDYlsR7n23/nSSNo2e6eCA3FZrEh8vLlkUuI2590ow?=
 =?iso-8859-1?Q?U4RggeI36c3eB8NQzGD0WODy0B/JhVbSoErLiblt8Bvy3nAh0lJxZS9FBL?=
 =?iso-8859-1?Q?tbFoB0/z43iXFGG741cZcH1qNnhaOzs2EV6jsKFfwOofaLhNDGof4gD+WX?=
 =?iso-8859-1?Q?zbqX6cFLmpsveet+Vw3dr0LLuLBsOKdNZslySu4CaLWm9K252kGS1MB83t?=
 =?iso-8859-1?Q?TKDyXHtNsIIZb+iKhjvbSEkftmq/+iDyNpu0EKSwkWXqK15NNqTylDnXeR?=
 =?iso-8859-1?Q?2GKkOOC5QYiRE2pGwPDcbzyhzhWFIvFQnxE8IGuLHCXR05A3cwZClHbpUx?=
 =?iso-8859-1?Q?B360S4cgw2VYf5m3FLVCiShQMqW5j8nEhj6ENDuOyUPHgVR7xqhjSZss3V?=
 =?iso-8859-1?Q?L4bcegwBMHyP4IODiRk/Mv5pggMQ5uiFXmJWxeU+FiowSoyE0nxTbGHUW4?=
 =?iso-8859-1?Q?HCt8OFv4Z5Amcfly7Ypx0CqXOZqFCM5tka54uM2ZceFXQaAw92b58xJgjJ?=
 =?iso-8859-1?Q?0caqAbqfq15TLOefd0JagvRmnh5CqgDx69?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6803.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e33f2f2c-58d5-40bf-1fc1-08dd79150770
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2025 16:22:18.1946 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ld1C6ugShk4FHzX45CctmbCxINYKEhtgaO4m6ovO3t1jBOba6bHu53fEetW1B/sYhyDfPM1Kvb/YeAK9n9hCkQN9yVZ6jRjBn4Auhh2eYtY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7629
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

> From: Etelson, Gregory=0A=
> Sent: Friday, April 11, 2025 4:39 PM=0A=
> To: Van Haaren, Harry=0A=
> Cc: Richardson, Bruce; dev@dpdk.org=0A=
> Subject: Re: [RFC PATCH] add rust binding support to DPDK=0A=
> =0A=
> Hello Bruce & Harry,=0A=
> =0A=
> <snip>=0A=
> =0A=
> >=0A=
> >> My concern is how to properly maintain Rust crate once DPDK starts to =
implement=0A=
> >> it's own API.=0A=
> >=0A=
> > I'm not really sure what is meant here. I don't understand what "own" w=
ord refers to?=0A=
> >=0A=
> > I see it like this:=0A=
> > - DPDK has the public C API exported (and that stays the same as today,=
 with ABI rules, version.map files, etc)=0A=
> > - The Rust crate consumes the public C API (via bindgen, as done in thi=
s patch. More detail about bindgen below.)=0A=
> >=0A=
> =0A=
> Bindgen cannot provide access to all DPDK public API.=0A=
=0A=
Ah - you're referring to C static inline functions, declared in header file=
s, which bindgen doesn't wrap.=0A=
Correct - thanks - I understand your point now.=0A=
=0A=
> A good example here is rte_eth_rx_burst().=0A=
> That function is defined as inline and bindgen does not translate it.=0A=
> Also, the function definition references rte_eth_fp_ops array that is not=
 part of the=0A=
> public DPDK API. That means Rust cannot duplicate rte_eth_rx_burst() "as-=
is" and=0A=
> the solution can require extensions to existing DPDK API.=0A=
> =0A=
> I added a new public API that exports rte_eth_fp_ops for a given port Id.=
=0A=
> =0A=
> Rust implementation of rte_eth_rx_burst() does not have to follow the ori=
ginal=0A=
> approach.=0A=
> Usage of rte_eth_fp_ops is good for C, but Rust has different methods.=0A=
=0A=
Agreed there is a certain "mismatch" sometimes, if functions aren't in the=
=0A=
actually "C ABI" then they can't be called via bindgen.=0A=
=0A=
Agree that elegant solutions (clean, maintainable, and high performance) wi=
ll have=0A=
to be found here. Many existing solutions just wrap the "static inline" fun=
ction into=0A=
a "non-static" function, and export it as a public symbol. That allows call=
ing into it=0A=
from Rust (via bindgen-generated header) however causes an actual function =
call..=0A=
(LTO _might_ fix/inline it, but not everybody compiles with LTO.. link time=
s!)=0A=
=0A=
As DPDK uses static-inline functions primarily for "packet-at-a-time" perfo=
rmance reasons,=0A=
it is unfortunate to give-up (some small amounts of..?) performance by havi=
ng a C->Rust FFI call.=0A=
We have work to do to find/propose the best solution.=0A=
=0A=
> For conclusion, Rust DPDK infrastructure cannot relay on bindgen only and=
 needs=0A=
> to provide native implementation for some public DPDK API.=0A=
> It can be easier to maintain Rust files separately.=0A=
=0A=
OK, now I understand your "kind-of-C-DPDK, kind of Rust-DPDK" code, or the =
"own" code reference above.=0A=
I'm not sure right now where that would be best implemented/maintained, I'l=
l have to think about it and do a POC.=0A=
=0A=
=0A=
> You can check out my Rust DPDK version here: https://github.com/getelson-=
at-mellanox/rdpdk=0A=
=0A=
Thanks for the link - I see you've been pushing code actively! Good to see =
opportunities,=0A=
and compare approaches and concepts. Have you investigated wrapping the var=
ious pointers=0A=
into structs, and providing safer APIs? For example, the [*mut rte_mbuf; 64=
] array for RX causes=0A=
raw pointers to be handled for all packet-processing - resulting in "unsafe=
{ /* work here */ }" blocks.=0A=
=0A=
The code in the above repo feels like "DPDK C code written in Rust". It is =
a great step towards better=0A=
understanding, and having something that works is very valuable; thanks for=
 sharing it.=0A=
=0A=
A "top down" application view might help to brainstorm idiomatic/Safe Rust =
APIs, and then we can=0A=
discuss/understand how to map these high level APIs onto the "DPDK C in Rus=
t" or even "DPDK C API/ABI" layers.=0A=
=0A=
Does that seem like a good method to you, to achieve an ergonomic Safe Rust=
 API as the end result?=0A=
=0A=
=0A=
> > Next steps are to "allowlist" more DPDK public API functions, and start=
 building "Safe Rust" APIs over=0A=
> > them, in order to expose an ergonomic and misuse-resistant API. As you =
note, this is where a network ports,=0A=
> > lcores, mempools, and ethdev configuration are all required. First goal=
 something like "Safe L2 macswap"?=0A=
> =0A=
> I suggest to set the first goal to initiate a port and run simple Rx/Tx f=
unctions.=0A=
=0A=
Agreed, we need some API to "work towards" (Top down) as well as "work from=
" (DPDK C APIs, and your repo above).=0A=
=0A=
> > I will make some Safe-Rust API suggestions for EAL, and send a patch so=
metime next week to discuss.=0A=
=0A=
Hopefully this Safe-Rust API proposal will be a candidate for "Top Down" AP=
I design approach.=0A=
=0A=
> > Thanks for the inputs! Regards, -Harry=0A=
> =0A=
> Regards,=0A=
> Gregory=0A=
=0A=
Thanks! -Harry=
