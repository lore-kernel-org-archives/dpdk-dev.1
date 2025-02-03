Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA1FCC02193
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Feb 2025 08:37:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E0C0040B91;
	Mon,  3 Feb 2025 09:37:31 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 86D4140264
 for <dev@dpdk.org>; Mon,  3 Feb 2025 09:37:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738571850; x=1770107850;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=3DAN/Zcr1Ym/UtK+KNvtHJIqVfvGPvFGqQkYIpmoNMs=;
 b=cN/Id5tcY/HFAXdJzUDngOoO42SacqDTOaYb8VOkHIy8+ubQ8tKJzPaZ
 YUWoucESAtg4MiZcLUlTjsxJaKK5trjBSzIqs5jOJ/+xJpw4K2OgIpGju
 CyktZYH6TtDp99MIEWv08sPkSJvahhItILsJsdyWjmFO53mpp/F/TohG8
 PwCF8j10zCKzWtEznzMKTVeONYbgurgIoLecMtmhNKabRq+hVNZ9ootiJ
 dhzcEwBj4R7tpYY4X2ytSCAl5lIcZVCcr3tM4Y2XJ3llJu2b/7xnF2yED
 7tR1sebb5C1YPEHbIuiyt34cqBVOhXTX0qsTl+9APo98hmjP+XxugrVxb Q==;
X-CSE-ConnectionGUID: qbqLswp6QUWGXoiu8BwaKg==
X-CSE-MsgGUID: jM8oWInoQqeIsa2Bunu//w==
X-IronPort-AV: E=McAfee;i="6700,10204,11334"; a="38959709"
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; d="scan'208";a="38959709"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Feb 2025 00:37:28 -0800
X-CSE-ConnectionGUID: OVy/0tPtSFurBT3r4Oncug==
X-CSE-MsgGUID: dxyb1IsPTZGC3avlgK65mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="110673150"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 03 Feb 2025 00:37:29 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 3 Feb 2025 00:37:28 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 3 Feb 2025 00:37:28 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 3 Feb 2025 00:37:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y7ygqjA13bj+bvdQqf6F6qf1+J48c1XkH8xws0/hFngfClYshYmk4M4alACa8ERVxilsLVEOaCgpQn5VGeyNO7D6TyF1zavm0ViuWjQ6hRITw9wCobwnsBWtZKDbgfJ7AZflBd6h3Y0ZnbX2VuuzHv9EMb91M7wn7bQH050JBKYW8ShENgjRO7siZEeai+03nl70Igd/EdCDD/+Wvfn6KzFPsSIamJK7GwmnCHIjUkG6UQjLmrR9JGb96fc0QQPMlZrfOzUbPv0AsgjhBedlLBp5t6v3irZkpyhNF38Dltw7lGuViraYV1Ojmf1m3Vlp77NyUAKbchU3p4I7djanGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P+afVH+UsYgObWI1G+vMGGZFsXB9j1sm63u225nSeNg=;
 b=jnhnWYSN8Zh+PnTJlMk3d3WbC/UKoCKi7WuIHDaXYtISEtXHCROHdWHmtGzUxlfhNOhbmghSFDtumjILtXN07f35UI7VCmZHPp1JlXtoCVtkO0nFHRfWsnzepIZkDhzxgmbRAxYBkbk95HBLfPNQy5JLWHyRnw8RP8k3lSvgP23Vu0lggVhWoERdUwHZ1hCuVqncj9ijfugo78A7Ruf0gspCSg+9/YfQC1TUKImUJ7X2s+niMiRhPhYrU0lLFqv5DBKfGlO7fYDvge6HisSCn/CXK/rFKPFEK4gLqPjzruF6XKMYTy9bcFfQJ62KYTKrNhtwwjBuIW2kNrig/LxYCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5911.namprd11.prod.outlook.com (2603:10b6:303:16b::16)
 by PH7PR11MB6606.namprd11.prod.outlook.com (2603:10b6:510:1b1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Mon, 3 Feb
 2025 08:36:58 +0000
Received: from MW4PR11MB5911.namprd11.prod.outlook.com
 ([fe80::1d00:286c:1800:c2f2]) by MW4PR11MB5911.namprd11.prod.outlook.com
 ([fe80::1d00:286c:1800:c2f2%4]) with mapi id 15.20.8398.021; Mon, 3 Feb 2025
 08:36:58 +0000
From: "Shetty, Praveen" <praveen.shetty@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [PATCH v3 1/4] drivers: merge common and net idpf drivers
Thread-Topic: [PATCH v3 1/4] drivers: merge common and net idpf drivers
Thread-Index: AQHbcyloWLgTEQx/5UKXM5xZLe2MULM1Ru1Q
Date: Mon, 3 Feb 2025 08:36:58 +0000
Message-ID: <MW4PR11MB5911A6B478A678379920B8A69DF52@MW4PR11MB5911.namprd11.prod.outlook.com>
References: <20250128163649.343336-1-bruce.richardson@intel.com>
 <20250130151222.944561-1-bruce.richardson@intel.com>
 <20250130151222.944561-2-bruce.richardson@intel.com>
In-Reply-To: <20250130151222.944561-2-bruce.richardson@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5911:EE_|PH7PR11MB6606:EE_
x-ms-office365-filtering-correlation-id: 1e2f0c78-00e0-44df-507c-08dd442dec31
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?FZYsbVD4+sIhZ9/gSem38v27CrXcNdB+dm45Py/dEkTIcqho7PS58RS7y+og?=
 =?us-ascii?Q?j12iK+zBgc+rQNG8ug9YDrDcUyaFec5Qe7iv+NwJUzfUBjLU7qCiOB4t1adZ?=
 =?us-ascii?Q?g2SJLcb4Id9lUq0VZDPd6R0GWMUyBHppG9gzAsIagIsiup6tvL38OUYy7KfT?=
 =?us-ascii?Q?dd5HkbyyotenNsZu+KcuOM4BAdk2pjUSckc4if/YkhO2PMfgijkVfLUgOyc3?=
 =?us-ascii?Q?FuNZy5mbXHIiBcfx+f0jtiBnV0J7bK/FVEyFoo8chK13j5eb+R8EdBKaxunl?=
 =?us-ascii?Q?JoRcT/l4YhP9wNcLEY09vdKULfRrJOMVd3LW0ln1F5qRXXb11VhQ/LC2IZwz?=
 =?us-ascii?Q?TnnqMWRog09xkPKEtX4mmwrdILEEpIUStQO7FlgLUjG2D84dMzDqQGQBRFSb?=
 =?us-ascii?Q?YNZ4j2RxYd78CAbpl+RpasMmhXRVxaJsO55s3p9jq28TclPz/yu8q67pNxk8?=
 =?us-ascii?Q?rmsW/MBELG94AbkeCfNVYjVO5gAm+GMB8Vx/JBwfRQxhT8YilcKDVb1yLWX2?=
 =?us-ascii?Q?rcC/qNd/7CoBzWFM/Yb2jcQASbUf/iWMI7guvGEF7m821Ia1G6/AG1x8dIfa?=
 =?us-ascii?Q?2G2Bde6R/HD4MsXPExgJrPmD4OhQP80ugsxM5MUm3RNktZe6v0LQPOoKezl7?=
 =?us-ascii?Q?oH9sx16093tbg6hkpDlGS1+Uidxx5p95l10Z31pGRcp7aZYalrUBGTPRZiRP?=
 =?us-ascii?Q?1AFaeAJBPEDK4yt2o3uGsL4uFnLGCoj55Io2Y1axmnqLL1781A+MqhNH6Pf9?=
 =?us-ascii?Q?/Ybg9tMZVkH06ii3vuoazbdFnZ778NCqHhah2QXb9bxE6Pydno4N+FFb+8vH?=
 =?us-ascii?Q?1k197WvtnfRPmfjIMslpk9BhEyolkpJf7Z43MNAQEYhvPvkZAS7O93shCI40?=
 =?us-ascii?Q?SYKGxOV5zgryDYcOdo77jTFeTyYKFPHMQFR14rk8Poo5OToWHs++WOh40Opu?=
 =?us-ascii?Q?YW5IgYTKtq1FushtqyQyAMD9S2TN7fwVIEd0pgljrsL/na4oOX+qQnvCyqB8?=
 =?us-ascii?Q?HQZENJ/8zBqeMv8fIZvqfjMsLYlnd5n+lFwDJJFMUk23FiS7VITBM+v4ND7g?=
 =?us-ascii?Q?2AXpxZkjS7TTG6x5jtuvMfwGReBLRjsonl7JF5nzfVg3JFpqa4x9XHWJVXih?=
 =?us-ascii?Q?DWcFgtzSGDkU/KuRQHJFWDmMHH45SUCF3gsAejUjZcImsjJQfskmwO3nhfF/?=
 =?us-ascii?Q?+epsrpAPAB5dS+Fo33e/WlD3CctdrScDpck2u6pSj+Pm8kYvjuY3r8oHD0+l?=
 =?us-ascii?Q?gmbZrw4ABOVMabkTOdVEuB3BrO2p8tZxcr05vy6l85BMG7xvvtuoiWVliHVh?=
 =?us-ascii?Q?HJHCgF+fc6Isd8mvEShlwf/MqkyWQfrOsSXfuWdhyRBsalBerNUQYdFf++XM?=
 =?us-ascii?Q?Upd16NZGjSgeRaJ90W2BLsxkJ4w9dZOMFmS4FXPbsulMpUk1+J/HfiRxkXwj?=
 =?us-ascii?Q?q0Qt+5k0Wt6dsbsieyvnPU2lSlUc/iYN?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR11MB5911.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Al3/PUO+rAdXay9Ln2+yfn0NpDzEGgW6fU093vFfGXxQJgU/Ss42nvBpN0EI?=
 =?us-ascii?Q?pwVo0ssOTHM9H3pYstbJIFECgmiQDp28zMjolSMpeByuvSqc/xMRAyDGuruq?=
 =?us-ascii?Q?P7+rciMH+5XGX+q4a4jF4kyBNTMKCpiq4UgSdsldOwzYxOCgPTVOQbAO9kwT?=
 =?us-ascii?Q?e4k2Ph9TgM6SPT3jrFAdTJ7v4Kze5D9rsJgW6NalV0vp1kqEzLx5MmiBkU+w?=
 =?us-ascii?Q?9+nCAeWcUgu6RgHluMBFp27W1o/O9wpwHOGIhWyyiyljSd/BJPn1Yl/CbIEr?=
 =?us-ascii?Q?IqCwRxRFwMo7u+4lOa5ak8LnJPOSa8pirk+CJNlXeAq3Y3Z4LGstzp5D3CAp?=
 =?us-ascii?Q?RINAHCrLg8abIYlQ9mmjdERwObl8dXOP1JpLCJr/C4yP97/7thvbI/vjs3K1?=
 =?us-ascii?Q?wzGvyzC7ilbkyIkDCZwCIevWBPSAOn9LKH2kgPRUSxMSA3Dyn5T0hzaxceZn?=
 =?us-ascii?Q?KpUr5PG8Yca+qCactcUGGAsVz6iuAG/ZomMmqvZJQsQM3iuH/2OSXx67bgg3?=
 =?us-ascii?Q?90ToFAZWOIKDBll4qIPrZqQQM6flUQiaF1jsMglfsvFrTBgh5Judkn3EH8to?=
 =?us-ascii?Q?Jfj0opSpnlw/kEukaoO4GjmA6/GP9rTDb5KyMZbXnf9xFLMBpRQxnYCqg8nH?=
 =?us-ascii?Q?OT3jLoT7eu9xt2Gw7eroPg1JFwT3LVfDabRz1dg+uXc1o70fiKQAOEAhmPDS?=
 =?us-ascii?Q?dSXdYyKUBrmJUUqXQwl7sTTmyI1vik+YfzP3x0aJWArg3Vwdri+QTZrvLHZD?=
 =?us-ascii?Q?keyI/TLK3yQguluwV6m+SREBw/dvkDz0TnLIkxZSy9h5dt4FQ0AmNqQYTaF4?=
 =?us-ascii?Q?128r1i/KFbpJ4ZCEpNm34AGLAvkAf70XgB/pqmZ7lDt8Y+wsoHrCVU8PFXHI?=
 =?us-ascii?Q?CYKjPor2fs2KDDMdwkbFI2tJd+qMfSotKyrhT8AGfgz159uo+b+D7RYMw4xl?=
 =?us-ascii?Q?VFjuKYFh0I7pnmxeZ5zd2dYWuwNlPpoLsBKLG8IuqkWHIzDuYSgd2myrwbrC?=
 =?us-ascii?Q?2oDPTdwmyd4vC9VGNvLdCaKVvzY5w1yBtAbaiVuNpouKR3U9goJ+Y1uFIQhI?=
 =?us-ascii?Q?4wzzjZrqcNoiJKhxFsW8MzD1f6xsLxNYVU/l7ewyLjgtHEfwTzOcpAL+wZmZ?=
 =?us-ascii?Q?5IPjNv2nQbO6VRk50wUhGIXqetwFBZLmCp8nTxoMSy3GHEKkxO5eretkR/w7?=
 =?us-ascii?Q?/IaYGufuulDHngMad4xpKOBU6EfwAfmgmV44gW9LhikVZKNVyaSMSKOpVe+u?=
 =?us-ascii?Q?w4My+SDUesodnUIU/kvFMUDi7NyRtwcd8f0quseAQR0ECpa+5A29HcToPMV8?=
 =?us-ascii?Q?O2IWPrG1E3Y96zq7IZUGQxVW9S1ExZadEEbWg/J2yNaswuYbV6HzSJKRZ+tC?=
 =?us-ascii?Q?eLv7689/QKzs4hEc18In41kXQhGFDZQcUUbYEx/L67JMCOmciu3wHYS5hjVZ?=
 =?us-ascii?Q?eHxQOEP/W0JWF4j5X4kgTXbWaZlYwBvMmLZjSl4x4O+AKu5G8cMXsRE1DmkL?=
 =?us-ascii?Q?P43G1j9j4J2Bt7By7whnDwVJLsD3t7YbHWV8M/BvUwKisWwBcdceWoH3wIey?=
 =?us-ascii?Q?xCsa/M0FM5rjCw+0rHhunfXy+1A6/alIzgNBNBK3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5911.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e2f0c78-00e0-44df-507c-08dd442dec31
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2025 08:36:58.2825 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pakowhmDg8WjXLKER6vfKmNA5ywQeK+yD9XIkOVNuIhlheC030hly+5hRCjqEjglN8Xo772J/czBgU/pR7UFrQgmaBk9gJn1/fIq844ZOeI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6606
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

Rather than having some of the idpf code split out into the "common"
directory, used by both a net/idpf and a net/cpfl driver, we can merge all =
idpf code together under net/idpf and have the cpfl driver depend on "net/i=
dpf" rather than "common/idpf".

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 devtools/libabigail.abignore                  |  1 +
 doc/guides/rel_notes/release_25_03.rst        |  6 ++++
 drivers/common/idpf/meson.build               | 34 -------------------
 drivers/common/meson.build                    |  1 -
 drivers/net/intel/cpfl/meson.build            |  2 +-
 .../{common =3D> net/intel}/idpf/base/README    |  0
 .../intel}/idpf/base/idpf_alloc.h             |  0
 .../intel}/idpf/base/idpf_controlq.c          |  0
 .../intel}/idpf/base/idpf_controlq.h          |  0
 .../intel}/idpf/base/idpf_controlq_api.h      |  0
 .../intel}/idpf/base/idpf_controlq_setup.c    |  0
 .../intel}/idpf/base/idpf_devids.h            |  0
 .../intel}/idpf/base/idpf_lan_pf_regs.h       |  0
 .../intel}/idpf/base/idpf_lan_txrx.h          |  0
 .../intel}/idpf/base/idpf_lan_vf_regs.h       |  0
 .../intel}/idpf/base/idpf_osdep.h             |  0
 .../intel}/idpf/base/idpf_prototype.h         |  0
 .../intel}/idpf/base/idpf_type.h              |  0
 .../intel}/idpf/base/meson.build              |  0
 .../intel}/idpf/base/siov_regs.h              |  0
 .../intel}/idpf/base/virtchnl2.h              |  0
 .../intel}/idpf/base/virtchnl2_lan_desc.h     |  0
 .../intel}/idpf/idpf_common_device.c          |  0
 .../intel}/idpf/idpf_common_device.h          |  0
 .../intel}/idpf/idpf_common_logs.h            |  0
 .../intel}/idpf/idpf_common_rxtx.c            |  0
 .../intel}/idpf/idpf_common_rxtx.h            |  0
 .../intel}/idpf/idpf_common_rxtx_avx512.c     |  0
 .../intel}/idpf/idpf_common_virtchnl.c        |  0
 .../intel}/idpf/idpf_common_virtchnl.h        |  0
 drivers/net/intel/idpf/meson.build            | 20 +++++++++--
 .../{common =3D> net/intel}/idpf/version.map    |  0
 drivers/net/meson.build                       |  2 +-
 33 files changed, 27 insertions(+), 39 deletions(-)  delete mode 100644 dr=
ivers/common/idpf/meson.build  rename drivers/{common =3D> net/intel}/idpf/=
base/README (100%)  rename drivers/{common =3D> net/intel}/idpf/base/idpf_a=
lloc.h (100%)  rename drivers/{common =3D> net/intel}/idpf/base/idpf_contro=
lq.c (100%)  rename drivers/{common =3D> net/intel}/idpf/base/idpf_controlq=
.h (100%)  rename drivers/{common =3D> net/intel}/idpf/base/idpf_controlq_a=
pi.h (100%)  rename drivers/{common =3D> net/intel}/idpf/base/idpf_controlq=
_setup.c (100%)  rename drivers/{common =3D> net/intel}/idpf/base/idpf_devi=
ds.h (100%)  rename drivers/{common =3D> net/intel}/idpf/base/idpf_lan_pf_r=
egs.h (100%)  rename drivers/{common =3D> net/intel}/idpf/base/idpf_lan_txr=
x.h (100%)  rename drivers/{common =3D> net/intel}/idpf/base/idpf_lan_vf_re=
gs.h (100%)  rename drivers/{common =3D> net/intel}/idpf/base/idpf_osdep.h =
(100%)  rename drivers/{common =3D> net/intel}/idpf/base/idpf_prototype.h (=
100%)  rename drivers/{common =3D> net/intel}/idpf/base/idpf_type.h (100%) =
 rename drivers/{common =3D> net/intel}/idpf/base/meson.build (100%)  renam=
e drivers/{common =3D> net/intel}/idpf/base/siov_regs.h (100%)  rename driv=
ers/{common =3D> net/intel}/idpf/base/virtchnl2.h (100%)  rename drivers/{c=
ommon =3D> net/intel}/idpf/base/virtchnl2_lan_desc.h (100%)  rename drivers=
/{common =3D> net/intel}/idpf/idpf_common_device.c (100%)  rename drivers/{=
common =3D> net/intel}/idpf/idpf_common_device.h (100%)  rename drivers/{co=
mmon =3D> net/intel}/idpf/idpf_common_logs.h (100%)  rename drivers/{common=
 =3D> net/intel}/idpf/idpf_common_rxtx.c (100%)  rename drivers/{common =3D=
> net/intel}/idpf/idpf_common_rxtx.h (100%)  rename drivers/{common =3D> ne=
t/intel}/idpf/idpf_common_rxtx_avx512.c (100%)  rename drivers/{common =3D>=
 net/intel}/idpf/idpf_common_virtchnl.c (100%)  rename drivers/{common =3D>=
 net/intel}/idpf/idpf_common_virtchnl.h (100%)  rename drivers/{common =3D>=
 net/intel}/idpf/version.map (100%)

diff --git a/devtools/libabigail.abignore b/devtools/libabigail.abignore in=
dex 21b8cd6113..1dee6a954f 100644
--- a/devtools/libabigail.abignore
+++ b/devtools/libabigail.abignore
@@ -25,6 +25,7 @@
 ;
 ; SKIP_LIBRARY=3Dlibrte_common_mlx5_glue
 ; SKIP_LIBRARY=3Dlibrte_net_mlx4_glue
+; SKIP_LIBRARY=3Dlibrte_common_idpf
=20
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ; Experimental APIs exceptions ;
diff --git a/doc/guides/rel_notes/release_25_03.rst b/doc/guides/rel_notes/=
release_25_03.rst
index a88b04d958..79b1116f6e 100644
--- a/doc/guides/rel_notes/release_25_03.rst
+++ b/doc/guides/rel_notes/release_25_03.rst
@@ -115,6 +115,12 @@ API Changes
   but to enable/disable these drivers via Meson option requires use of the=
 new paths.
   For example, ``-Denable_drivers=3D/net/i40e`` becomes ``-Denable_drivers=
=3D/net/intel/i40e``.
=20
+* The driver ``common/idpf`` has been merged into the ``net/intel/idpf`` d=
river.
+  This change should have no impact to end applications, but,
+  when specifying the ``idpf`` or ``cpfl`` net drivers to meson via=20
+``-Denable_drivers`` option,
+  there is no longer any need to also specify the ``common/idpf`` driver.
+  Note, however, ``net/intel/cpfl`` driver now depends upon the ``net/inte=
l/idpf`` driver.
+
=20
 ABI Changes
 -----------
diff --git a/drivers/common/idpf/meson.build b/drivers/common/idpf/meson.bu=
ild deleted file mode 100644 index 46fd45c03b..0000000000
--- a/drivers/common/idpf/meson.build
+++ /dev/null
@@ -1,34 +0,0 @@
-# SPDX-License-Identifier: BSD-3-Clause -# Copyright(c) 2022 Intel Corpora=
tion
-
-if dpdk_conf.get('RTE_IOVA_IN_MBUF') =3D=3D 0
-    subdir_done()
-endif
-
-includes +=3D include_directories('../iavf')
-
-deps +=3D ['mbuf']
-
-sources =3D files(
-        'idpf_common_device.c',
-        'idpf_common_rxtx.c',
-        'idpf_common_virtchnl.c',
-)
-
-if arch_subdir =3D=3D 'x86'
-    if cc_has_avx512
-        cflags +=3D ['-DCC_AVX512_SUPPORT']
-        avx512_args =3D cflags + cc_avx512_flags
-        if cc.has_argument('-march=3Dskylake-avx512')
-            avx512_args +=3D '-march=3Dskylake-avx512'
-        endif
-        idpf_common_avx512_lib =3D static_library('idpf_common_avx512_lib'=
,
-                'idpf_common_rxtx_avx512.c',
-                dependencies: [static_rte_mbuf,],
-                include_directories: includes,
-                c_args: avx512_args)
-        objs +=3D idpf_common_avx512_lib.extract_objects('idpf_common_rxtx=
_avx512.c')
-    endif
-endif
-
-subdir('base')
diff --git a/drivers/common/meson.build b/drivers/common/meson.build index =
8734af36aa..e1e3149d8f 100644
--- a/drivers/common/meson.build
+++ b/drivers/common/meson.build
@@ -6,7 +6,6 @@ drivers =3D [
         'cpt',
         'dpaax',
         'iavf',
-        'idpf',
         'ionic',
         'mvep',
         'octeontx',
diff --git a/drivers/net/intel/cpfl/meson.build b/drivers/net/intel/cpfl/me=
son.build
index 87fcfe0bb1..1f0269d50b 100644
--- a/drivers/net/intel/cpfl/meson.build
+++ b/drivers/net/intel/cpfl/meson.build
@@ -11,7 +11,7 @@ if dpdk_conf.get('RTE_IOVA_IN_MBUF') =3D=3D 0
     subdir_done()
 endif
=20
-deps +=3D ['hash', 'common_idpf']
+deps +=3D ['hash', 'net_idpf']
=20
 sources =3D files(
         'cpfl_ethdev.c',
diff --git a/drivers/common/idpf/base/README b/drivers/net/intel/idpf/base/=
README
similarity index 100%
rename from drivers/common/idpf/base/README rename to drivers/net/intel/idp=
f/base/README
diff --git a/drivers/common/idpf/base/idpf_alloc.h b/drivers/net/intel/idpf=
/base/idpf_alloc.h
similarity index 100%
rename from drivers/common/idpf/base/idpf_alloc.h
rename to drivers/net/intel/idpf/base/idpf_alloc.h
diff --git a/drivers/common/idpf/base/idpf_controlq.c b/drivers/net/intel/i=
dpf/base/idpf_controlq.c
similarity index 100%
rename from drivers/common/idpf/base/idpf_controlq.c
rename to drivers/net/intel/idpf/base/idpf_controlq.c
diff --git a/drivers/common/idpf/base/idpf_controlq.h b/drivers/net/intel/i=
dpf/base/idpf_controlq.h
similarity index 100%
rename from drivers/common/idpf/base/idpf_controlq.h
rename to drivers/net/intel/idpf/base/idpf_controlq.h
diff --git a/drivers/common/idpf/base/idpf_controlq_api.h b/drivers/net/int=
el/idpf/base/idpf_controlq_api.h
similarity index 100%
rename from drivers/common/idpf/base/idpf_controlq_api.h
rename to drivers/net/intel/idpf/base/idpf_controlq_api.h
diff --git a/drivers/common/idpf/base/idpf_controlq_setup.c b/drivers/net/i=
ntel/idpf/base/idpf_controlq_setup.c
similarity index 100%
rename from drivers/common/idpf/base/idpf_controlq_setup.c
rename to drivers/net/intel/idpf/base/idpf_controlq_setup.c
diff --git a/drivers/common/idpf/base/idpf_devids.h b/drivers/net/intel/idp=
f/base/idpf_devids.h
similarity index 100%
rename from drivers/common/idpf/base/idpf_devids.h
rename to drivers/net/intel/idpf/base/idpf_devids.h
diff --git a/drivers/common/idpf/base/idpf_lan_pf_regs.h b/drivers/net/inte=
l/idpf/base/idpf_lan_pf_regs.h
similarity index 100%
rename from drivers/common/idpf/base/idpf_lan_pf_regs.h
rename to drivers/net/intel/idpf/base/idpf_lan_pf_regs.h
diff --git a/drivers/common/idpf/base/idpf_lan_txrx.h b/drivers/net/intel/i=
dpf/base/idpf_lan_txrx.h
similarity index 100%
rename from drivers/common/idpf/base/idpf_lan_txrx.h
rename to drivers/net/intel/idpf/base/idpf_lan_txrx.h
diff --git a/drivers/common/idpf/base/idpf_lan_vf_regs.h b/drivers/net/inte=
l/idpf/base/idpf_lan_vf_regs.h
similarity index 100%
rename from drivers/common/idpf/base/idpf_lan_vf_regs.h
rename to drivers/net/intel/idpf/base/idpf_lan_vf_regs.h
diff --git a/drivers/common/idpf/base/idpf_osdep.h b/drivers/net/intel/idpf=
/base/idpf_osdep.h
similarity index 100%
rename from drivers/common/idpf/base/idpf_osdep.h
rename to drivers/net/intel/idpf/base/idpf_osdep.h
diff --git a/drivers/common/idpf/base/idpf_prototype.h b/drivers/net/intel/=
idpf/base/idpf_prototype.h
similarity index 100%
rename from drivers/common/idpf/base/idpf_prototype.h
rename to drivers/net/intel/idpf/base/idpf_prototype.h
diff --git a/drivers/common/idpf/base/idpf_type.h b/drivers/net/intel/idpf/=
base/idpf_type.h
similarity index 100%
rename from drivers/common/idpf/base/idpf_type.h
rename to drivers/net/intel/idpf/base/idpf_type.h
diff --git a/drivers/common/idpf/base/meson.build b/drivers/net/intel/idpf/=
base/meson.build
similarity index 100%
rename from drivers/common/idpf/base/meson.build
rename to drivers/net/intel/idpf/base/meson.build
diff --git a/drivers/common/idpf/base/siov_regs.h b/drivers/net/intel/idpf/=
base/siov_regs.h
similarity index 100%
rename from drivers/common/idpf/base/siov_regs.h
rename to drivers/net/intel/idpf/base/siov_regs.h
diff --git a/drivers/common/idpf/base/virtchnl2.h b/drivers/net/intel/idpf/=
base/virtchnl2.h
similarity index 100%
rename from drivers/common/idpf/base/virtchnl2.h
rename to drivers/net/intel/idpf/base/virtchnl2.h
diff --git a/drivers/common/idpf/base/virtchnl2_lan_desc.h b/drivers/net/in=
tel/idpf/base/virtchnl2_lan_desc.h
similarity index 100%
rename from drivers/common/idpf/base/virtchnl2_lan_desc.h
rename to drivers/net/intel/idpf/base/virtchnl2_lan_desc.h
diff --git a/drivers/common/idpf/idpf_common_device.c b/drivers/net/intel/i=
dpf/idpf_common_device.c
similarity index 100%
rename from drivers/common/idpf/idpf_common_device.c
rename to drivers/net/intel/idpf/idpf_common_device.c
diff --git a/drivers/common/idpf/idpf_common_device.h b/drivers/net/intel/i=
dpf/idpf_common_device.h
similarity index 100%
rename from drivers/common/idpf/idpf_common_device.h
rename to drivers/net/intel/idpf/idpf_common_device.h
diff --git a/drivers/common/idpf/idpf_common_logs.h b/drivers/net/intel/idp=
f/idpf_common_logs.h
similarity index 100%
rename from drivers/common/idpf/idpf_common_logs.h
rename to drivers/net/intel/idpf/idpf_common_logs.h
diff --git a/drivers/common/idpf/idpf_common_rxtx.c b/drivers/net/intel/idp=
f/idpf_common_rxtx.c
similarity index 100%
rename from drivers/common/idpf/idpf_common_rxtx.c
rename to drivers/net/intel/idpf/idpf_common_rxtx.c
diff --git a/drivers/common/idpf/idpf_common_rxtx.h b/drivers/net/intel/idp=
f/idpf_common_rxtx.h
similarity index 100%
rename from drivers/common/idpf/idpf_common_rxtx.h
rename to drivers/net/intel/idpf/idpf_common_rxtx.h
diff --git a/drivers/common/idpf/idpf_common_rxtx_avx512.c b/drivers/net/in=
tel/idpf/idpf_common_rxtx_avx512.c
similarity index 100%
rename from drivers/common/idpf/idpf_common_rxtx_avx512.c
rename to drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
diff --git a/drivers/common/idpf/idpf_common_virtchnl.c b/drivers/net/intel=
/idpf/idpf_common_virtchnl.c
similarity index 100%
rename from drivers/common/idpf/idpf_common_virtchnl.c
rename to drivers/net/intel/idpf/idpf_common_virtchnl.c
diff --git a/drivers/common/idpf/idpf_common_virtchnl.h b/drivers/net/intel=
/idpf/idpf_common_virtchnl.h
similarity index 100%
rename from drivers/common/idpf/idpf_common_virtchnl.h
rename to drivers/net/intel/idpf/idpf_common_virtchnl.h
diff --git a/drivers/net/intel/idpf/meson.build b/drivers/net/intel/idpf/me=
son.build
index 34cbdc4da0..52405b5b35 100644
--- a/drivers/net/intel/idpf/meson.build
+++ b/drivers/net/intel/idpf/meson.build
@@ -7,13 +7,29 @@ if is_windows
     subdir_done()
 endif
=20
-deps +=3D ['common_idpf']
+includes +=3D include_directories('../../../common/iavf')
=20
 sources =3D files(
+        'idpf_common_device.c',
+        'idpf_common_rxtx.c',
+        'idpf_common_virtchnl.c',
+
         'idpf_ethdev.c',
         'idpf_rxtx.c',
 )
=20
-if arch_subdir =3D=3D 'x86'and cc_has_avx512
+if arch_subdir =3D=3D 'x86' and cc_has_avx512
     cflags +=3D ['-DCC_AVX512_SUPPORT']
+    avx512_args =3D cflags + cc_avx512_flags
+    if cc.has_argument('-march=3Dskylake-avx512')
+        avx512_args +=3D '-march=3Dskylake-avx512'
+    endif
+    idpf_common_avx512_lib =3D static_library('idpf_common_avx512_lib',
+            'idpf_common_rxtx_avx512.c',
+            dependencies: static_rte_mbuf,
+            include_directories: includes,
+            c_args: avx512_args)
+    objs +=3D=20
+ idpf_common_avx512_lib.extract_objects('idpf_common_rxtx_avx512.c')
 endif
+
+subdir('base')
diff --git a/drivers/common/idpf/version.map b/drivers/net/intel/idpf/versi=
on.map
similarity index 100%
rename from drivers/common/idpf/version.map rename to drivers/net/intel/idp=
f/version.map
diff --git a/drivers/net/meson.build b/drivers/net/meson.build index 02a3f5=
a0b6..bcf6f9dc73 100644
--- a/drivers/net/meson.build
+++ b/drivers/net/meson.build
@@ -24,7 +24,6 @@ drivers =3D [
         'gve',
         'hinic',
         'hns3',
-        'intel/cpfl',
         'intel/e1000',
         'intel/fm10k',
         'intel/i40e',
@@ -34,6 +33,7 @@ drivers =3D [
         'intel/igc',
         'intel/ipn3ke',
         'intel/ixgbe',
+        'intel/cpfl',  # depends on idpf, so must come after it
         'ionic',
         'mana',
         'memif',
--
Looks good to me - thanks Bruce!
Acked-by:  Praveen Shetty <praveen.shetty@intel.com>

2.43.0

