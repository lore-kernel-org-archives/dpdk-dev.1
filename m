Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9588B606A335
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 16:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RGJt3A6j
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7FC2C40264;
	Thu, 22 Oct 2026 18:46:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id C65914003C
 for <dev@dpdk.org>; Thu, 22 Oct 2026 18:46:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792687598; x=1824223598;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=uer2+D7ukzZAFwCE2NaWUori7GzzMrX+cChOR5fsrPk=;
 b=RGJt3A6jRVt5kWr9JJPM8Xk6e8SkyyiGNJzZ8oR9bupQ5GZ0mtrW4uYB
 0AXZaelDEsL87dKxRK8sn/MxlpS0onNHv5SS1v1Z/6TS+Dznfe2Mqi/nT
 x9NDup1aS5oiA9RCLxSiVlG8/gTsgfkZxurHWJO+2hZVPf1dIbviK9oEP
 9u3XZ+DXi07NQnLzxvrEPZaQhbDuGGdnIWt98W0aRmnoHuf0kSBdq7LsX
 otYFvDb/38dSqO5iNoseBooP2AIOMNaAiXd7iFq88gDeAPmiyYj2pnU/P
 jRI6oGZO5tAYX42P6oqyuE2Lr2pRssNATZCziNu1WjCcHxVRRmeBm3XUs Q==;
X-CSE-ConnectionGUID: gJ7GRJnLRM+v8ZTQEB7CvA==
X-CSE-MsgGUID: rW+jCrRkR8upZjIQfqAROQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1332348"
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="1332348"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2026 09:46:37 -0700
X-CSE-ConnectionGUID: Y0EfYTiHQR+ZgfMVTuy+MA==
X-CSE-MsgGUID: P48wA2HoS8WLDmlL6qY2GA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="3742884"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2026 09:46:37 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 09:46:36 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 22 Oct 2026 09:46:36 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.32) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 09:46:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nhlIOdhLIm+Cs0httK8JO4NpnqcSOfOEl1LoRbM0fAxkmzyrfMTn/cd0MptHIdLhsFmUKXoj+EYpAGgE5ZZkPq26B/JrHbTYYn1gn+1yRCrr9kR65nC0tX9TFypTNe0KA9/ss4ZOZWfYN6QY01vKsh9EwoEgf+sz0FAFPIphbBP2qiRjks0m9q9Fs7yfBvTT3blQpFxoBFT49sWYjvM1tGEL+BzTehW22VyPBdxp+BI79e1Idsbvic3njcA2ENTvoJdFngpXgIxLptXQtOTidvztLxRHhuar90eRcz7LacBbdMpPXB5DP5GO/5wGcWquG3X4SabLpTdJHl2hkSq9nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uer2+D7ukzZAFwCE2NaWUori7GzzMrX+cChOR5fsrPk=;
 b=PzKHMnyg7EV5/5gTZo+il4V50bomfdFDAvJusOKQm8bRbjlqZpw27ZCHS9ZxKCJsI/EHGLOEEGpEe+aTuWHIQN9vM1S6xiI/wFpnzxyMSmhxDF6m573Bqz45FfvEPGjMl9fR6VbUSJnUhBg14BnT7NshdtDy8nwDQdKqz8YOaFd03Efn3MErD97aCw0QqyLTLrAzHM6wn/KshwqO+E4/bDP1+D/e3ASPZ9loqPCAaXfN+FGDzMFzu1lF2NcGZvmPXhUZ8oEoPbRtAp+mr4QvrSHl9+0FVQU5PvcCkFA6X2QNAyAMDb26eEV7Rg5dB1eyjedwcOkKyTT5EwxX84zyQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6806.namprd11.prod.outlook.com (2603:10b6:806:24d::14)
 by SJ0PR11MB6789.namprd11.prod.outlook.com (2603:10b6:a03:47f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 16:46:33 +0000
Received: from SA1PR11MB6806.namprd11.prod.outlook.com
 ([fe80::a2bd:fe68:c55f:a803]) by SA1PR11MB6806.namprd11.prod.outlook.com
 ([fe80::a2bd:fe68:c55f:a803%4]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 16:46:33 +0000
From: "Sarkar, Tirthendu" <tirthendu.sarkar@intel.com>
To: Pravin Pathak <pravinpathakdev@gmail.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "jerinj@marvell.com" <jerinj@marvell.com>, "Richardson, Bruce"
 <bruce.richardson@intel.com>, "thomas@monjalon.net" <thomas@monjalon.net>,
 "david.marchand@redhat.com" <david.marchand@redhat.com>,
 "pravin.pathak.dev@gmail.com" <pravin.pathak.dev@gmail.com>
Subject: RE: [PATCH v1] event/dlb2: race condition during dynamic linking
Thread-Topic: [PATCH v1] event/dlb2: race condition during dynamic linking
Thread-Index: AQHdYYCNNWLZOW8e20u3k5Svnf8zqbcJxFoA
Date: Thu, 22 Oct 2026 16:46:33 +0000
Message-ID: <SA1PR11MB68060466B72DD59668D2890690652@SA1PR11MB6806.namprd11.prod.outlook.com>
References: <20261021172041.433881-1-pravin.pathak.dev@gmail.com>
In-Reply-To: <20261021172041.433881-1-pravin.pathak.dev@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6806:EE_|SJ0PR11MB6789:EE_
x-ms-office365-filtering-correlation-id: 7cf38167-5ecc-49ef-cd8c-08df305c07ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|38070700021|11063799006|10067099003|56012099006;
x-microsoft-antispam-message-info: 0ch26ptoSqVDvpeJRCyjauTBDlM4gPGZ9PxzSTWoKyA2xybWvRRFSy9wMIAjkHGAw1t9kQYZJlLEzQsg4NvyWB6gYIEd6I7DpBzKyjrgFdEW4B15LknCz01b4Yr8dfM8RTTcQvcG1FYCN7oh9SwQGww5MIZPRZveDWDOuadfNtbtjYnzBZFSu9m1Y1ClgHDm09f97zsRw+d7G8VYf/h61kMx88S6u9kM1Sns3pe04Ss/5u3iadAwkk2OShIBvILqAnOJPBYr6kY8o8gPMsEBY9mQS+WUQc8Da2PfT0ATTsShSNqkY8DjLLU8O2s3iJ5sky1hEi0gIuCiNW4j5FSSKB5BsrzYF0rKaCv7pi4vgSJUF8KOJoTYxNl3Nw+93G1zQpdPbXIvGeGu53SVaesQp006hkoVh+mdub6bYhgSQWyas40WSNKt4EuNcN7/wA1P26qepO78z4MTxXn1cWCHqFzbZwLxzpLRGb/dhnXMJzpyz/BqEXSp+jva+OWCsJm3+b74g2EEVW1dPmFEgwZ0Z9FD2m9mtr8IoXRp0WMuoLXGy0S5bzZfaCpeu3AJcacIYmPPrqARIIG1u8f0j8ucdelpjsA/EjSYE6GE2Y+PEFRhRwzZ/B9S0BP4ERaSSFKcC1OwCdlvOw6h16wuG/cr4e2EysZUiGnKN1Ls0oHXWMlKwPWr8QblAvJs/NV4y4TwoWc/oz29IapM2G/RMM3a84Wivt1g40i6CLrl5joo9RQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR11MB6806.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(38070700021)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VQQiK5TwCsjpLrFolTnjcydafA6s7NiFzopWbfGOPNri4GGIOsU/qrR2vPSO?=
 =?us-ascii?Q?dDzvhik6IdalzAH5/T54IxfpU7q935i9JE0phRppNHBL4aJYQBbMmRFsolR2?=
 =?us-ascii?Q?qieLwtm0NEi3frMffUTtHQZgl1zK5G+qIkJ+HqvwEJWRbChEDseAzt+ycaWR?=
 =?us-ascii?Q?zybiZ6CXgakELHhdC7d8umh/3J+UaCmv6YAjPuViSq6sCIAcnExpOwz1pnYo?=
 =?us-ascii?Q?4v9F6XbQKRVy0qdqESuXu8AbS8KFpQuOiwFTvZ6RRkKCPa7LoeuuTfmiKkh5?=
 =?us-ascii?Q?f+psEJJvZ7tO9pD1ib9CUUlPC6xUNv7JzfAa4Ei7PtdvJKYKd2T4K2RfTnwd?=
 =?us-ascii?Q?GIUAJJ3/n9CJeghmKeyr0WnjHkKTu+7sI6sURnB1nVkDOaFCCX4GUex7Vtzd?=
 =?us-ascii?Q?7M9AHxqp18x6kLE0RYIp9usDx43nEkpJytO47gZwVfxo12jTM8NHBKkFf0ve?=
 =?us-ascii?Q?/XynGy9sdzKBwQuLG02pKmG5dgZH1342jf5lzwbVJQca0GlO6HJzpnVrTP6C?=
 =?us-ascii?Q?VlpeGv3jMy01Bofdh0iTuC621LCgEnRWrtXU9FcyvyAD1HxGNUGenayYk9ZE?=
 =?us-ascii?Q?un/UEu9BAS5ckvDbgth+K2jaQOzQBEPFB3rVpv2FXheKAJG1JXDuaBFYLYKt?=
 =?us-ascii?Q?8FyNm8yejcGjTEwkhq7fHoRIhT2V/pWjORWB8zKfspsH+1xFsLWKyYkXc93i?=
 =?us-ascii?Q?FLpU1DW56RETWKQwiIgIXSKQ/ytrZgNNE05kv9QyDd2zYGqulOtuIfZ66S/E?=
 =?us-ascii?Q?TN3iDc53B4uk95tnI4W0F5QMZlxdInRXnqD0JEKQR5S+NMHh7exHG3VeLimF?=
 =?us-ascii?Q?UPuu8ovR8Ky275SU/M9n251IJicjJrx/Udf8SnCd/bligr1H/YU9UOD+Qkz/?=
 =?us-ascii?Q?E5FrGnX88wb1fmR79uzPHWkrrKbh48gYJGHxZg+26SB+uqap6F5yp8+9eyWG?=
 =?us-ascii?Q?M6q/u7jtkGyWdaC1i0PB1BpnqtQnEKwB/M42Itvubcm79cJgxjooG33rJDTu?=
 =?us-ascii?Q?SEd8chMmnr+QIsxjFWSALP7TPD/cv7VZJaTbIFjFqcJghy9pT0WJotVpmDrz?=
 =?us-ascii?Q?Chi7yRdHbatkXx7l4G0fIqtJZrxWAGO6rr78BF/PbUK7sfQC7EvOyZ7i9xSd?=
 =?us-ascii?Q?0Qq+KvkXbLpHarW7ZQIcSJ1pO0xSLmaTlIYmrUp2hR/0G4bNF4NsnTUoAMB9?=
 =?us-ascii?Q?z+C/3sPQJKxfHrl+kgj1d3GHVHgGiFuv4DZQsnc65h3X89h0WzdcTGfDbBya?=
 =?us-ascii?Q?qjqrXk7LgBwttFu3MwgQk0FLf4Wza55InDiZNfGFOSIk8tQYI9WrkXv2H/A/?=
 =?us-ascii?Q?rTNgO0FzhWk0aolSaj5nvFvWtdeVruxCe5NPTf9XR6PwyGJDO8ueq3ThlFzN?=
 =?us-ascii?Q?Ah5GrwhneQ8hQJK5e5/2l4G6ASDo/YD73XRSushyIv5GN1uulDz2tYFqhbAn?=
 =?us-ascii?Q?S6aJfxPm41twUTsfGrJ2sLpnJzF6wDt5zHFOYmhwg8oPtzNJ6OSlF/se+3zb?=
 =?us-ascii?Q?OVKUTfTnYQQNfvCDXjOJ79jjaIHrWcyRHwPbauXfwMRcFJKAa/RE4gWgt1IA?=
 =?us-ascii?Q?/tsz/eTSD+vZSo/QVfKiWZY200m5R/kP4SravxX7cn+9pK+oOxWBBDZDIO/x?=
 =?us-ascii?Q?qHnyDz3PvAji1IjRZjRB8BID08B1/d5d9Fzl1o8Lp8YZLw4Vz76SSeqgiQXm?=
 =?us-ascii?Q?1kmRItks5NYoxg/tS+UAdvt81QYUF/X0UZSRX/YTCOp2zz3/aS84N3aUollx?=
 =?us-ascii?Q?yMZFoAue9g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 4hd5i7ZwAaNiDOt1DwDwiI13Aa6ie4yWW7ooyodDku9+X30rfO2e2Y9M0g70wVldOILVkPzGgChAh9hdcA5g7pfMkuZkoguEDtA0HLoPUrSEg7Vd6275CnP2kx6XBG6jV0YCoe4YSA0+JdYd3hsWfrrDvAQ1R+tyWF16A/zAsteFxFji+6LTSTkxAgplX4+0G4ZV+Wyb7aRzqP4SoAJsK4RS7949xfzWTACJDUlDTdOS/3TIJGekgp7pXx3paehV6DWwKHlXyTsAWxaLuNoO0VHJZc9j7gorHteG/DC6v59CN0wbnJYRAmRHLqbqQPumP0U4tqp3VrZ28AOAQD3gNw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6806.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cf38167-5ecc-49ef-cd8c-08df305c07ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2026 16:46:33.7782 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BxbYPK5/P+xzCAmT8R5VeBngJFL5yhT4H6VT0BBEHFOSF0SfofZQgunTS7AeZCdTrFuScoOOhx+/WOfpJf2W0qvlwavZ8XxSVF/XlOf8fJU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6789
X-OriginatorOrg: intel.com
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 01:20:41PM -0400, Pravin Pathak wrote:
> dlb2 handles dynamic linking and linking asynchronously if queues
> being linked/unlinked have traffic. [...]

Fixes: 5433956d5185 ("event/dlb2: add eventdev probe")
Cc: stable@dpdk.org

Acked-by: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
Tested-by: Tirthendu Sarkar <tirthendu.sarkar@intel.com>

Thanks Pravin. Confirmed on DLB 2.5: without this patch, runtime
unlink/relink under traffic stalls on all ports once the worker exits
before worker_launched is set.

Jerin, please add the Fixes/Cc tags when applying.

Regards
Tirthendu
