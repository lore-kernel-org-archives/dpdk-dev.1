Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2696C83F03
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Jul 2025 11:29:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 12BE64028B;
	Fri,  4 Jul 2025 13:29:32 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id E613540267
 for <dev@dpdk.org>; Fri,  4 Jul 2025 13:29:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751628572; x=1783164572;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=oNbBDb0OvDkQ1EPEPvyNDSKPhHvemRXnZkbpDbnVypo=;
 b=N0J5Dq5YKIatHjyvxAot3z9A4ZgQX04eMf9VWAKwgyI29qXenrgdNV4H
 y+ipxvzXYToGpb4QYC34EQh/BJAMd+bhRkuvlR9bIhX2ECW6rOXFa/gn/
 /wA76ypUPequXDJl+h2dkB89KRQ6KwesB92gX2b9LpGMPjR9LmeHj5zPp
 vHEJSToG0NdKvlW7IsyrcaVHEK6cGXuJdY6ULlV/mxtKqVdsyCmiowzWi
 m5TP8/CN2UI4BcxGcKUSCcqg8bBbkbjaZftB73CFOAfKVTEnaPdVpLEFo
 ZfQcNS1P0qx1LlvXusDvSUXYFRZFY6Dfp3FcZJEYUY0+EHWisOCcHZ3HF Q==;
X-CSE-ConnectionGUID: x5+tMND+Sriqene+tEaAlA==
X-CSE-MsgGUID: l4ZXwjQeTGe6G4plJfV2nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="54082400"
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; d="scan'208";a="54082400"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2025 04:29:31 -0700
X-CSE-ConnectionGUID: 6kMjuP0iR3esww4EoH9rgQ==
X-CSE-MsgGUID: XSDRHjeyTW+eJo712Cq1YQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; d="scan'208";a="191791988"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2025 04:29:31 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 4 Jul 2025 04:29:29 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 4 Jul 2025 04:29:29 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.69)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 4 Jul 2025 04:29:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bl1WGf0ZBo6/Or06XDN7NqsmDGzK8CCX8ONS2ERHygsnuzyyzKipfiOOFwLL++HQNJNREzm9bfVtkfoATd+e0Z9+uRPO42ybnxTZyUIK3xwjmJTAeuP9E+gfSWwGKSY7pFDYMuNqruU4sXI+55JlyW0rRplM9GLHTJOjYqeN1CYCkdX9bIyHsCtPV4t0qowlTjnxKYRJtpM5qtR6pB79btC8OMYpxLq5us+jQr/3okWZYPIrkxw3fA6Cm52A+x2gyK2MGDX77z6WzZM+71Jx511ij7lt0LdfOwI6I/jZR6/m/71SfoqmZWoFONk/sOZSMjNuk77Ar6Nw07UQoiS/jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mCJpXmo7Brd667MpnQqtyblU8GgwdflGEBbrTpJuxw0=;
 b=cbRroz9nFEGXi8xAqSXXgDFlGEnoHAV8wm5W5ougwpz/3IowBcqIYOgdpSKB2mR2sjbnRDOt86Ie+617yZFPPS/Wd0TRdifGqS8/RMEqh7cUHDjbI2bNSxknlqsUk0S0qMAWGiUdEHK9v/mng8PN1fRkTyY6Jp4Ur1evLxoGTdfYvSTG3aebfWM5OCbF15ZEXKWY2wKdE+RGH07UhPg+Gy5LKvPnuxD8OFyvD1tyPYB/xqqthSYHDfLI6Eva4rsE5mYYpyUSiMBqKNhheOKoZx0RQQN8i0vO6q4AIrueQh6NX3/tZqVx6CbgXw9XCqZwpbFFjPzBCvpDQlWVYHB0sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB8336.namprd11.prod.outlook.com (2603:10b6:208:490::22)
 by SJ0PR11MB5021.namprd11.prod.outlook.com (2603:10b6:a03:2dc::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Fri, 4 Jul
 2025 11:29:13 +0000
Received: from IA0PR11MB8336.namprd11.prod.outlook.com
 ([fe80::46a3:ee0:a7c5:8518]) by IA0PR11MB8336.namprd11.prod.outlook.com
 ([fe80::46a3:ee0:a7c5:8518%6]) with mapi id 15.20.8901.021; Fri, 4 Jul 2025
 11:29:13 +0000
From: "Jiang, YuX" <yux.jiang@intel.com>
To: Hengqi Chen <hengqi.chen@gmail.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Baoyuan Li <updoing@sina.com>, Maxime Coquelin
 <maxime.coquelin@redhat.com>, Chenbo Xia <chenbox@nvidia.com>
Subject: RE: [PATCH] net/virtio: Fix check of threshold for Tx freeing
Thread-Topic: [PATCH] net/virtio: Fix check of threshold for Tx freeing
Thread-Index: AQHb2Q+ZFqrc5zaxvUa1/Mo9mtXbz7Qh+qnQ
Date: Fri, 4 Jul 2025 11:29:13 +0000
Message-ID: <IA0PR11MB8336E80904EA2B2AC1041C45FE42A@IA0PR11MB8336.namprd11.prod.outlook.com>
References: <20250609072347.1748785-1-hengqi.chen@gmail.com>
In-Reply-To: <20250609072347.1748785-1-hengqi.chen@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB8336:EE_|SJ0PR11MB5021:EE_
x-ms-office365-filtering-correlation-id: bc45c9d0-7c88-4693-8cf1-08ddbaee00af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?z3R0BaPS4vc92Iogi8yQeLoCpuch2/I3AOAhZdCC5il/4L067v/vOpUW7lh0?=
 =?us-ascii?Q?4HdvGhJjC/8EUQeG8FKIDbL5E/2F/kMpLIISz/jwDyxeR2MunI0bBfJ/B6Yc?=
 =?us-ascii?Q?Mw56pif+uRK5LQeWNZUtGf/IbT5aUy6eqV7ZE6gGxJP5arceynjpygfn02LR?=
 =?us-ascii?Q?D1+gAlX2BZ7Iy69MCbAXGWr+eKFWvJLKNr1YSvk8b4uKu+nMNBZpseb8uZyN?=
 =?us-ascii?Q?NSUyYrHMDkDneGxJOcUZvX7zsCTKNkcu73ZFYsUMABsocHjDuVjhcR1sT1aA?=
 =?us-ascii?Q?ctO2n22vX0R1BHL1/BfgBkXd7JK02IWYfIZKs6lptV/sWb0B1/vDgR0hlxJa?=
 =?us-ascii?Q?A0vuS/GnDYuUdSuiFzqRswKjr9kBraKVq+Z/ikQjivnEQ4PlH68zlyKvdN0F?=
 =?us-ascii?Q?jmhvGCwzp6HclaKSYsMIhE8DfYUhC5DLQFCzhIQlqsK2oAVZikq7K2l6kqkL?=
 =?us-ascii?Q?n7fMtpOmh5QSwgYeK3SQ9CXNwyau1hFxyLO31DL/nki14Ym0yKOBQ987RK5M?=
 =?us-ascii?Q?+vVYWebITyhHRacDhvIxEoDKXp+5D+gWspaZZTLOi7ZZLDwTGFqVCRgRGSBe?=
 =?us-ascii?Q?x4EVKIGtdA6iqmCwGIqRfa9z9iRhDeHET5CLMc/XVyqHJiJL/FuojDhU1tJt?=
 =?us-ascii?Q?gZRNg0uDtGKJLTZ5GgsrbAX0j/MM74vKgTpcNsGewF542KXVSwQaFCuQe9HC?=
 =?us-ascii?Q?0E4+X3drZOFtJWVDP6b73WUf4+whN/xV7vBajGE/CyO61oduGMgUdpRdkkO1?=
 =?us-ascii?Q?Vb5VguIiLGwPi1Yy6l4Zf8TseMoXLHL1Zy4qvIFa06C4+QoXaYEaFtZC0kmF?=
 =?us-ascii?Q?fL8sOPJnsS15H5yfXMJpnpgHGEZr9ya/sEuxnw/hY4V5s+WCwpw59kLy0LAP?=
 =?us-ascii?Q?5PUg0Es6vOfvpuwO6sg/8JZBtfYyIUci+4Tn56QZngp/oOLVF5SJ8KgsO05Q?=
 =?us-ascii?Q?gcdwOLaE+eniakIx0HTFBd/GRRswITkQLTFBJw88uhx1Ok4UnLv+8tHrPye2?=
 =?us-ascii?Q?dz3lvHRlrns9SeS5HWyeKo4DM6ELVBHHzkOlPIzC5bJss2pK9Y1/yjRr1sHd?=
 =?us-ascii?Q?USZMYe73Dx9LUTTNQZd1NJ/T1ag3pt6gCOkRFZ5lFJOLmeqNVSgjyg+tklnC?=
 =?us-ascii?Q?FuEeupcuS56+Sr+lU9mBOVuzdkvRhGUZ49p/V2LCUhvOqitOWF2b/TE00FBK?=
 =?us-ascii?Q?onREc0nWAHhs/scBC4pe1VO/b7vDCkNaqYq77ngU1NjD/saWlxZeAFiNuq4m?=
 =?us-ascii?Q?RwLy2CTnYZKyamlPFwBAAp1OI6qV/lvMo9PVxNSaxUcI4jOUMA5FP8xvbokO?=
 =?us-ascii?Q?NbFzZXxbr7O1WQp87RPCfFGxcvat37YZLhqW+wgbeWLMSnp4JyD5LR5yCQpn?=
 =?us-ascii?Q?k0Q46K9uhlSOalBziiVcQA8wqUBVYg8rU6lEIyeakoNWfKPSs/aGhM1U9u1W?=
 =?us-ascii?Q?ZLHDoCElU90=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB8336.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MV/wX7ypHzcIXgHmW0LrOwyYY3RP0lbRPAsfrAPSXmBYFBXdzPCGK+s2Luij?=
 =?us-ascii?Q?0xZ/RGbnuHWlX2CnV9nCr8JPRU5hLkceLCOrR03wuAXo2Q4QKW2+nRY5Cobk?=
 =?us-ascii?Q?PgAMVtzoYIAVJJlW1pzYpbiFBSoSRU9764nzHtwF8FaXG0QQKaeeAhyDZufZ?=
 =?us-ascii?Q?MRrQZuBFr7fOFXnSJHDE0TdeFR/nakiDxiJDkjFzA2pZj3b/3SRSrWxT1Nki?=
 =?us-ascii?Q?hjBLc6e4KwJQdhX2pY7/fOH1inUXX/5BjP29HC4PT2oHbAuIbaNXXFlhmpwm?=
 =?us-ascii?Q?OtD4AIso2ciDvzoUdCOoJuq6b0x0DoZXB9QVuSTJFNuHqi1Y474tyZbfV7lR?=
 =?us-ascii?Q?7lamG46lsNGXBiaFEzCkV/FJWaJh/76TL2L+bIchXDwB2/GNhOn4VzdyfW1x?=
 =?us-ascii?Q?OyA+Z3MqGoU1v6WjWvgCwv6eN+86C45crhOE6par8oGrhao0UkQlwnI9BieO?=
 =?us-ascii?Q?sHM4ajlEiHHvciVArvv/sOoEcAYR/yCBQk531SB8GnkN8rp/mKDxwzGjqZgP?=
 =?us-ascii?Q?eFYY5jXfnk5t4BYcadsxaxwKm9zOw2kWRPzmD2GZUU9jrm3R4YQ4ajDp2P2M?=
 =?us-ascii?Q?Vu5q24kqtuhUisHx/8BpfA/ozkWPEVGcxww1bk6fJkfhJdxVU3fQLm9HKCQi?=
 =?us-ascii?Q?wuHAJKtDc6zPux2BPfZkgbDwk38lgx8aEYGWvocYsfmDuDdvRj8oWMVWHBZG?=
 =?us-ascii?Q?QbM0qKJchLfo1zC5Ufo/9TCIBXh9tJbo1UP4Y/4yx3bA1CNeTXmi46c/ncf7?=
 =?us-ascii?Q?AF8t+gfN2sAAj1FXPmunExBO5rRSkHsLIH1qx3gcCGjjTl4xN7eEpukekF7O?=
 =?us-ascii?Q?/24NsLn7DD1BMQuVnRXSOuHcAhUCwHFsIvS7lvyV38rwk+BHY+lfKdy9zI+3?=
 =?us-ascii?Q?B1S7kI9M2OFFoerKzdtMmFJQPE5dLEErYQReszUioQF3f5yh54peFzQanTud?=
 =?us-ascii?Q?dYDa3NR0HRRfXDxg8nuwOyINVo9tTx2J9yYVxcagFoMEvI2T5XS3TMpXIgr/?=
 =?us-ascii?Q?ztUbsU6lJWzWqHLECyf6rNHmMnV1XvxPx+ChqIaF5VAQDtCAPZCZxh+ARCXF?=
 =?us-ascii?Q?lUeb/HcLW1JmKmqU9DuVaDxuLQW7ZLwcQlN80fAvYoneYPuDqwYlSC2JD8C+?=
 =?us-ascii?Q?er/rc1Mz4PSsnIhY1EEkTS+lrlTe02vEqUqh2rgavFfGNaNhvFVwThoaPBnY?=
 =?us-ascii?Q?Ghqi5hLo3wNxlSWfC0bQ2CPTXgIXodB/u1Y1oSwzF4TSmNfvfOrY7pZoI63K?=
 =?us-ascii?Q?OlAC+eygHEKrDtKy46rw58omI8sdCwxlA7pLWFFbR8PGHOSCJgl6SHoNK3eb?=
 =?us-ascii?Q?dgW7bo+ao5nqXPFHX0MTx7nArV+65gW7Jz5xEpdw9ZmfrOQnfHCnHzJEm5Ld?=
 =?us-ascii?Q?I5dA8FM0LYVBd3dowppDEIyucBdobhEwfz8gmnF4tt7Hn+2uXuSvQNJBxQ1z?=
 =?us-ascii?Q?N29fxSkxQ0hhZsFxFZ/ylglier2VttI0DCEOHz0lD7tVNbTUPkS141Fo0iPk?=
 =?us-ascii?Q?v0uUp4wqHlxSzny+KyJFvucoYf5MR6CMNKNcWEPTeiphEnVnXys6xiWAQJNR?=
 =?us-ascii?Q?vU4s35QyTden8F0ZM40HPVeRDDZZIeTBBTUxB950?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB8336.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc45c9d0-7c88-4693-8cf1-08ddbaee00af
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2025 11:29:13.2824 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ph/VHE/5rOmIIabtW57Zge4Bo6arjqloPN5CU/EUXRzvYjztp+6xKmIahyjXH8n0+qZjPDkLoRytinvZ7Ededw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5021
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

Hi Hengqi,

Can you help to check the ticket: https://bugs.dpdk.org/show_bug.cgi?id=3D1=
747? The perf drop is caused by your patch. Thanks so much.

Best regards,
Yu Jiang

> -----Original Message-----
> From: Hengqi Chen <hengqi.chen@gmail.com>
> Sent: Monday, June 9, 2025 3:24 PM
> To: dev@dpdk.org
> Cc: Hengqi Chen <hengqi.chen@gmail.com>; Baoyuan Li
> <updoing@sina.com>; Maxime Coquelin <maxime.coquelin@redhat.com>;
> Chenbo Xia <chenbox@nvidia.com>
> Subject: [PATCH] net/virtio: Fix check of threshold for Tx freeing
>=20
> Like most dirvers, make the fast path of virtio_xmit_cleanup() behave as
> described by the comments of rte_eth_txconf::tx_free_thresh ([0]):
>     Start freeing Tx buffers if there are
>     less free descriptors than this value.
>=20
> The rationale behind this change is that:
>   * vq->vq_nentries is set during device probe with the queue size specif=
ied
>     by vhost backend, this value does not reflect the real nb_tx_desc
>   * the real available tx desc is set to vq->vq_free_cnt via the nb_tx_de=
sc
>     param of rte_eth_tx_queue_setup() API
>   * so `nb_used > vq->vq_nentries - vq->vq_free_thresh` could never be tr=
ue
>     if say nb_tx_desc=3D2048, vq->vq_nentries=3D4096, vq->vq_free_thresh=
=3D32,
>     see bug report 1716 ([1]) for details.
>=20
> Bugzilla ID: 1716
>=20
>   [0]: https://github.com/DPDK/dpdk/commit/72514b5d5543
>   [1]: https://bugs.dpdk.org/show_bug.cgi?id=3D1716
>=20
> Signed-off-by: Baoyuan Li <updoing@sina.com>
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>  drivers/net/virtio/virtio_rxtx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/virtio/virtio_rxtx.c b/drivers/net/virtio/virtio=
_rxtx.c
> index edecd2011f..ab97f03d7d 100644
> --- a/drivers/net/virtio/virtio_rxtx.c
> +++ b/drivers/net/virtio/virtio_rxtx.c
> @@ -1873,7 +1873,7 @@ virtio_xmit_pkts(void *tx_queue, struct rte_mbuf
> **tx_pkts, uint16_t nb_pkts)
>=20
>  	nb_used =3D virtqueue_nused(vq);
>=20
> -	if (likely(nb_used > vq->vq_nentries - vq->vq_free_thresh))
> +	if (likely(vq->vq_free_cnt < vq->vq_free_thresh))
>  		virtio_xmit_cleanup(vq, nb_used);
>=20
>  	for (nb_tx =3D 0; nb_tx < nb_pkts; nb_tx++) {
> --
> 2.43.5

