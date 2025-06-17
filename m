Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D30C71136
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 02:42:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6FFB8402D0;
	Tue, 17 Jun 2025 04:42:37 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 8A93540156
 for <dev@dpdk.org>; Tue, 17 Jun 2025 04:42:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750128156; x=1781664156;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=6/eD7MnDuD9YeuZ9PyEgYL8V+tmFnTvoFbBtdXfA6fE=;
 b=JQvKTy1CH7O6KQLVz3qSZw/IpfpDxDcR0HC/5oMfsK73BOEo4m5YWfmf
 MOuGUPjUoFf6q71iHQ4DUky+d91xkzMDE150MG6ojZWo4X+3g6wYGerII
 wJSsYvdYXjQH5+OIRlDXlbqB5pR5spzxFSgdCXtkaEBvh0laxu5GlOFBI
 zSikyChwPCuVSJqwvquZTGFaWSzwuspA0kJzZEAePvoO5o8Sn4Ci/Le4h
 85xRkhr1UylUjg+WEiuNXAtIzClr4J4jT64gHpjT/N7SlYrS+hPv4dmYq
 VDPVfiywgVXJ69Md2UtfynkWiW04BMvjw+J9BhLb2RZZpfAdWVD3WDp/t g==;
X-CSE-ConnectionGUID: if5oH+7qTqqvLY7d930t5g==
X-CSE-MsgGUID: pORUtI66Ttm2rUJMcnzwIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="62940954"
X-IronPort-AV: E=Sophos;i="6.16,242,1744095600"; d="scan'208";a="62940954"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2025 19:42:34 -0700
X-CSE-ConnectionGUID: Bp5ym3giTGypYUTDvZ1j8w==
X-CSE-MsgGUID: GCpT4n8dSTWJFRwgAul20w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,242,1744095600"; d="scan'208";a="153521839"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2025 19:42:33 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Jun 2025 19:42:32 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 16 Jun 2025 19:42:32 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.89) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Jun 2025 19:42:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TZylr+f+79anSuuM+NRcKzhoZGv7FeHSMz018qnMs8TzPPAdkjacYPs/5VPan1UPDbQtlVcOkMu2IBMx4XvJAsZML/QBBgdWEQyKYc08xVf9ooZlSOaTYPY7tq325jyBXPecdPIbs6FB6RFUN4DxjlQsluzBiiGhqYLkWzc+lSYZWUjTGEI2jpGoOhPsea82YQVSWIGyEBdN/IiFsJxCAsSfka/ulRRDgC327sKTz1/BqlEvNAtj9HHRiSqsztAWmp/G4O3+T1TLsyZzowk92tuXH4X6qwGCaRMFQ1QJTFYO9BNagmcIbzfEaOeOL6cYrDOjrYJAMPxPkw62DaVWPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/eD7MnDuD9YeuZ9PyEgYL8V+tmFnTvoFbBtdXfA6fE=;
 b=lImAVzkFriaACRcKQZO5jkcoEY50FHGyQRNMyha4ulJYttJ9XELGIhDVmu9jKfd0Qd2RlX8L5ySbOmD8j6kuDlNJrHovcg5chIYd/jjt6FPl1Gh5kEfX5q1iY7i2ZfrGt3Gv6P7yCjxoXQmBhC6BSsQ08jCYysW0RjtRlEwxt/bCHdl6Rq/MfbO3tg3LD1bOvICWcFQJAB7JWrboKh45aZ1wpU4iBnVMBoRm8dyhNT0pXpOTGu7+6XDwyXj8HYXr8H/UgvaSVXNEa3C6SiRVYuJVNDX+Ysn8sCrjRl6K5EC0tb2W62/zqHXUk/LcQNDwEVsI+O9U2bTKD9GX60itgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH0PR11MB5740.namprd11.prod.outlook.com (2603:10b6:610:101::7)
 by DM6PR11MB4705.namprd11.prod.outlook.com (2603:10b6:5:2a9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Tue, 17 Jun
 2025 02:42:27 +0000
Received: from CH0PR11MB5740.namprd11.prod.outlook.com
 ([fe80::1ec3:bdb4:3611:b959]) by CH0PR11MB5740.namprd11.prod.outlook.com
 ([fe80::1ec3:bdb4:3611:b959%6]) with mapi id 15.20.8813.018; Tue, 17 Jun 2025
 02:42:26 +0000
From: "Jiale, SongX" <songx.jiale@intel.com>
To: "Ye, MingjinX" <mingjinx.ye@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "Ye, MingjinX" <mingjinx.ye@intel.com>, "stable@dpdk.org"
 <stable@dpdk.org>, "Richardson, Bruce" <bruce.richardson@intel.com>,
 "Burakov, Anatoly" <anatoly.burakov@intel.com>
Subject: RE: [PATCH] net/ice: fix DCF RSS hash update
Thread-Topic: [PATCH] net/ice: fix DCF RSS hash update
Thread-Index: AQHb2rtbSVpxWASDu0OgCcaWOs0DabQGrTEg
Date: Tue, 17 Jun 2025 02:42:26 +0000
Message-ID: <CH0PR11MB5740F9F9A82B35746EF092E4E773A@CH0PR11MB5740.namprd11.prod.outlook.com>
References: <20250611095058.114465-1-mingjinx.ye@intel.com>
In-Reply-To: <20250611095058.114465-1-mingjinx.ye@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR11MB5740:EE_|DM6PR11MB4705:EE_
x-ms-office365-filtering-correlation-id: 22f3fa96-84cf-47f9-39ea-08ddad4898a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?p01zaCyTCzJNL+Tod9qgW5APl0s0YyfEsmHP97rAmkB/MEqMniRe1yIfT/zv?=
 =?us-ascii?Q?4ahHGG4FSrgDKgkBXTh4ZwGw9cEO4n9x6+D6EcG/GzGwuzBCR0KXNcoIUFmM?=
 =?us-ascii?Q?4UMmNVYZ+m3Dhh1/NBbxevmmLbLmSXMNy9WTPl24d+ubrjPUWHWv5PxelUaD?=
 =?us-ascii?Q?f6wGobdwoADPKpzbvuITjZHxcnATHDou6/vtFO46TvI1eTB1WtYPdYZyAh4N?=
 =?us-ascii?Q?PNcMOQjDhTM/ET/01oqKNVw5Bia+pRBadvLIRNHhbwQnLOHGbNUEvSsDKlBB?=
 =?us-ascii?Q?tq3lZVMfVhXs6H+NcK8N18dG4miOIRtbjnDb5CI2AY7KBnSYV7DZM7+MVPck?=
 =?us-ascii?Q?bn9eoJQexeHSH7P/6F159N8pI9gzuw53DTSTu+KvQCjrJ9hzHSEBGelCYhd7?=
 =?us-ascii?Q?X+K7gLci9G1KpmcwAfBzU+LaaYbnRlVXqQHcXax/0m2ATOnBy+iHZqnOBOeU?=
 =?us-ascii?Q?HLG6ZzGQWV3o/7To/FO4C7An1BCT5X8pM/+AcLuMNzB1xKMqiYsfDoXsKhQe?=
 =?us-ascii?Q?zfuoQrBmXs9dv3dvZsHwXZKBW1PVwc3yF3pH3d0u434AEYu6PXrWZYWYhIDt?=
 =?us-ascii?Q?O58dk0m04frIYB9/kjSziznaGsyt+8RDpJMLq/UoGMiflj8xr1UCX7KkX/6Q?=
 =?us-ascii?Q?3mYMT1Ukli7eKncZ3Qiz1pZf1rU7h5IUvaVPyG/jbYDokWAbdGF/mcsOMGmJ?=
 =?us-ascii?Q?kqjxXKk4iuGsWNtsKhAgGv+eh+71s3uVLug4m22iXXs4YfC2wucsi4G7wlwH?=
 =?us-ascii?Q?eSHnSMfVUa4sgqQOPV+d/cMmVTjvhvrzmpavLfdgX8eVjNYiKMH8asrsHtYS?=
 =?us-ascii?Q?rFkM2A98eZ5FGFtarAfDDgbMUInZf7fSJdgEq1w85xncSFcGpBRwbD04ZlXD?=
 =?us-ascii?Q?UFGPImpGrYRebSvhcmisIpgxzC5Yw41fglK+u0lvsj7EYBD0w54YJ163w3cK?=
 =?us-ascii?Q?iiNycqJGQRkcYP4Omdv9WJma0whz0L79tv8RfdIyP779sQcsIeXFXmBqbZXo?=
 =?us-ascii?Q?YuQpG1HGAWkYPg/J6IWjv92beTxrDjmQJUFEgQzf8pfAfSxUooVLZSE8gqRW?=
 =?us-ascii?Q?ocvIKFqglVMLSWwDt5/eU9dF/rd37j2UoDNWKmaMMnEh5nW+rkoUUPReZk2a?=
 =?us-ascii?Q?djonqJkRyOe2AXP6x1g1/S7DfAjFuH5j4mWZJ8dGbR1G14zobsAgDGjMb3mG?=
 =?us-ascii?Q?glJeB3ydr5qiNy2jE8gDBKLifv5Of7ngM8qNWEbtlzb1U2fyW1sAo7SmzN+P?=
 =?us-ascii?Q?vCu32QXXEeYSar63HOVE7xuhKztjuTEOSST1vfIk5Qk1S8/Qikp/ddWQ3L+L?=
 =?us-ascii?Q?hxVFhck5iLsIEfDEhPwgCMonW7ciNFAcE1QHgj+zgpD6mWZv1as1L3Elgm54?=
 =?us-ascii?Q?sIou0Qb5jegogYFJ+Rgi/P1AU8/YlU4nCWXczlpCDdvEYb+IeVgUwkKxeibS?=
 =?us-ascii?Q?C8fAyYZwVFVzqRS7bsnx4JX+saSqPwdIVQYqe9NSWxXSmPL5pW83NQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR11MB5740.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sJEEHeE887POAZtBGfMAgmYwkwJlcO5pr989dR3kqGj0rOacmBZ4HqUYVSkX?=
 =?us-ascii?Q?xwoetTVSC65zr8ldqyRMb5vdo881vDTu+XiBqX3HNzfbCMDekbNzRZUY+rhu?=
 =?us-ascii?Q?BcY4p6q/EDJpgzz6h7DZtc3/7FbX9ge4lCd2ITUZRV54Wbg/n93pInqeM8HN?=
 =?us-ascii?Q?hX9qAXAk25PQJm3Kv7Qg1LVbNHfMagzOhzFjpdqBV5JpVWRoRrMtRFxUdOFs?=
 =?us-ascii?Q?dqtdf+90EL8E2Ro4izaPGt0fw00DlzccNtz5lokcYvySA/Sk7T58BbjQhbx4?=
 =?us-ascii?Q?wTOfBZWxxUol6T+zXt0DFo6TTmcLRo3PGwSQrEW0hwvkrtoCUS+S8Y+dqFx/?=
 =?us-ascii?Q?PslY6YSqLEGA8SluZbUmNtaj2/16xWs8Ck30AO/aWKkCARTED5z5Z6NxjGMf?=
 =?us-ascii?Q?m1FIO6fru3Gv0i5Jumqb85GZb0llbkqzoHvMfmhF9TJDztQciPT3/JWbwkEE?=
 =?us-ascii?Q?7uZwRNHJqZQXZ4sPw8R5+Vtc6rSromyfLH/7TwNw37NzefQZWapjCzTKQ3Wj?=
 =?us-ascii?Q?tdyT1uCtOr5qY2FACZ8BCMT1QPcZLBvah6+EBBC2igSBXrIncKeIBgFW4JNp?=
 =?us-ascii?Q?ElmWk+x9G4CF5UNNIfKaIyD/0AvcU30Br2gvusJ9ZY+nQp//CSCqvOLquGP+?=
 =?us-ascii?Q?G4e19tKSLi08aPGlF5Iw/nGheD9n9xeBJITgPFHWkgYTMsWhhJ5hjbvPIQRq?=
 =?us-ascii?Q?Guw8gYv3uk6HR/trqU8uRul8eJ1B6anFAP005+YRBCN7kmqduXAGSHg8hoKS?=
 =?us-ascii?Q?+ieeT0Y9n/+pMtg6YGszGi8xiFGW74cmReGihdaeePS6/BO6P+ql0ECkpIGQ?=
 =?us-ascii?Q?ew8948kwsIjkG0Uz3rw+o++iZpQA0wJnAR/C+EzOkLao+7s9mSjL7ivgH2oZ?=
 =?us-ascii?Q?h0lEHS3CmP7libSVvvWPs5fuTSCKA0TSBkbwtEgrsaQUPsFSp0Ypxt47sX/D?=
 =?us-ascii?Q?d9ypmFqNAazVNKAh2BCwGlPEfkWDUTJKrDPDPqm/b3zZVNzNI2qThfAKqmDX?=
 =?us-ascii?Q?/aXWP8h1JQjfxs+Q3nWXUt7Tb1ue5MaEmatAWno1S+HlbgIMKewiH02G6Nox?=
 =?us-ascii?Q?PzsyXRGb1vNFtyuCJtLMjTFOVH/2WsVUR889QWswisYL/AuiX1aIaTzW7UFE?=
 =?us-ascii?Q?EFfc6Dc3UTfdAKO1fp0mOULB+uw5Ox6qpy8orkZdd8ha6ygmEwOO4IYCnW3/?=
 =?us-ascii?Q?GIrLg+v95MNsi8HholDWx03Dp6tk5Yc2BbnTXQEyqmFzR+E+Oq2wEuGx/bLo?=
 =?us-ascii?Q?PiO5f8WK59j89MaIea9M2LLZtM/CSgdumhOHFeeoX0lnwsdpJWcoEFu92b+1?=
 =?us-ascii?Q?21ZEvhGBgzWks9eIPMcX6vPWscNgj1sBJlnuk2RQGtt4oUpQJMHhGFLcPpgX?=
 =?us-ascii?Q?mTA7kGQBoQSqxgTw50ociDGVBfEngq1wLES0ftPy684gQmGomzM9iUlMcGRc?=
 =?us-ascii?Q?oRhZwlC7eZUTwk2INJoAndiZj0rzLpi9ceTtWpQ5bCZc2MMpDltOjH9WZnXX?=
 =?us-ascii?Q?GA8IsOwrsCkc4aSfpmiNSfiYO+m+3TmDPgLGjmOZszu9IPxhZKh7498URlh3?=
 =?us-ascii?Q?KmMWnnFfsY6OLcXcP6+AUKsCzPOnv/zJ1LRPK0pi?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5740.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22f3fa96-84cf-47f9-39ea-08ddad4898a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2025 02:42:26.6831 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HZOTv3D3H9Z4pYAL2Th2EsxDKAbggC0C+G1AR1twRh4NfoF6wAq/3+MfmowHyqX7BtMu4x4QnD/r32P9bqHaqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4705
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

> -----Original Message-----
> From: Mingjin Ye <mingjinx.ye@intel.com>
> Sent: Wednesday, June 11, 2025 5:51 PM
> To: dev@dpdk.org
> Cc: Ye, MingjinX <mingjinx.ye@intel.com>; stable@dpdk.org; Richardson,
> Bruce <bruce.richardson@intel.com>; Burakov, Anatoly
> <anatoly.burakov@intel.com>
> Subject: [PATCH] net/ice: fix DCF RSS hash update
>=20
> Get rss hash configuration, rss_hf is always the default value.
> The driver does nothing if the rss key is invalid during the rss hash upd=
ate.
>=20
> This patch is get the current configuration of rss_hf. Extract the update=
 rss key
> code from ice_dcf_dev_rss_hash_update to ice_dcf_set_rss_key and make it
> consistent with the pf behaviour.
>=20
> Fixes: c223cadc9e5f ("net/ice: support RSS hash configuration in DCF mode=
")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Mingjin Ye <mingjinx.ye@intel.com>
> ---
Tested-by: Jiale Song <songx.jiale@intel.com>

