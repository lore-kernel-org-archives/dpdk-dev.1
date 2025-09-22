Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0781FCAC5A7
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Sep 2025 08:24:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1481240653;
	Mon, 22 Sep 2025 10:24:28 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id D0CE24060A
 for <dev@dpdk.org>; Mon, 22 Sep 2025 10:24:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758529467; x=1790065467;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ys5U9ZVRvZ53c09va0+U1nGb4kBu75aKyqt6fIZvbOk=;
 b=LY3wJ8AO2/xthLYlx+uj8jrosZYxgzo6SHA99DcNaS1Iya2V9nHMA84F
 9rmElHdUIZnpwnkUif4zd2nuXE9GtLouCx+OBU7MoBkOKCKH8kM1nbt/l
 2oMjeW8/WfZ1DS/f9ZNLmuVBbdkINp7tm4BGUWwKb6HjmZPN7Ao4PQiMz
 ww6Wxphh83ic9qHvqu4xa/lFp99PKe4sdW8AqI74SMr+V9h2Dr6ozAXCu
 cOIf/mbpjxsoq3vzYM7f1PZU66whSLTWWsTlcA1TjIFrlDIyQOVGqBxvi
 rdwIfaguEPSoXrYvLn6PFbWrv4I7IuE6VCt0501fkyzH+xuBljN3h2ccx A==;
X-CSE-ConnectionGUID: ZAb1r2yURma9U0FwDCFAeQ==
X-CSE-MsgGUID: eB6KNaA/TGOyZ2Qi+nNzCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11560"; a="59825388"
X-IronPort-AV: E=Sophos;i="6.18,284,1751266800"; d="scan'208";a="59825388"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2025 01:24:26 -0700
X-CSE-ConnectionGUID: lc71mlBYSQ2urxs4w9ftMg==
X-CSE-MsgGUID: hoaRPHvYTqSsO5m+o2UdQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,284,1751266800"; d="scan'208";a="176489116"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2025 01:24:26 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Sep 2025 01:24:25 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 22 Sep 2025 01:24:25 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.7) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Sep 2025 01:24:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gv0OW+eltom4K3uHz7NCYI4Jz06pRuTOqeBo4zY868jDYxvAMOryPJWPY4rffv6+QCcMhDjSLEc9M9IhF0FmNrgG7SCyh4iYRebphkRcGnIVj0ySxeIle1H4Jy+PcVrSRa1XOCEkmNhZJvoWq4Ica3cU6Tfc3D+KKfb4rmANJdH7tCk6OfP+mMhSJfEgJvQqVby6SWLUffsItwOUQwhDJYZ/hGr7qNm9Sh8Sb00D8sjh/qEw/FESV2RyHN+cwX/ApyF5e+e3tVv+MR6BXquiI/zgBD2D9HVxKzdD48p4zxpGLFmhGi1gFsoD/YlpX9RNAXZ+VChimD0fYjPhHcT67A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7yXOQiydcdS44jL+utY0Fr0uZpbgRIdCx6yBbgFJGrA=;
 b=GxhqL0/uk2F7WxOBTSgrG5WfGRoNUteqw1MXYu7jfYhL5bhziJgMGKLoPECgUOubVDFvopgIlPkPRRwMLiA/KSubHsjDOWsrqDx2RM0aAl6xC4LvGjfoM5JABhXwlGwsciU4V93Ogzys/eC7wbzLnOswjJ5rGP3agftgOgV0rKQzxrL1tWSxPLsDC5yrfnUHv7YyswIGhile1NRsPnd8hLQYQgAIMmOSYDonoAGsc9wM0zWbfK1asabknw39kvokopejEXGUgy8cmXhLBdAJ90UkUquEcEJv1hUrKspjm9+tMVByNCYX9ot/aN1zcMYfdaEExROBFtIo4c7ckBeeiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA4PR11MB9034.namprd11.prod.outlook.com (2603:10b6:208:567::22)
 by DS7PR11MB8808.namprd11.prod.outlook.com (2603:10b6:8:257::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 08:24:17 +0000
Received: from IA4PR11MB9034.namprd11.prod.outlook.com
 ([fe80::ee0d:e6ed:9eba:e5a]) by IA4PR11MB9034.namprd11.prod.outlook.com
 ([fe80::ee0d:e6ed:9eba:e5a%6]) with mapi id 15.20.9137.012; Mon, 22 Sep 2025
 08:24:17 +0000
From: "Wani, Shaiq" <shaiq.wani@intel.com>
To: "Loftus, Ciara" <ciara.loftus@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "Loftus, Ciara" <ciara.loftus@intel.com>
Subject: RE: [PATCH v2 0/5] idpf and cpfl rx path selection simplification
Thread-Topic: [PATCH v2 0/5] idpf and cpfl rx path selection simplification
Thread-Index: AQHcJ7P7buC7FgVIt0CA7K4VfeMXkLSe5LUg
Date: Mon, 22 Sep 2025 08:24:17 +0000
Message-ID: <IA4PR11MB90343F79AF837A027743E3BB9212A@IA4PR11MB9034.namprd11.prod.outlook.com>
References: <20250911143145.3355960-1-ciara.loftus@intel.com>
 <20250917091731.3632520-1-ciara.loftus@intel.com>
In-Reply-To: <20250917091731.3632520-1-ciara.loftus@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9034:EE_|DS7PR11MB8808:EE_
x-ms-office365-filtering-correlation-id: f296db68-2e9a-454f-de39-08ddf9b16c34
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?luJkfsO+IF1by1AmClHEXyJ1bTyIjpbTas8igo4FQ6eFP+KT2bIY5BRYwlTN?=
 =?us-ascii?Q?qVD5dh8Cd81lSDJXKI5IO560XI/XaulluzRoyZSF86CT3T+yXdclci5KUN07?=
 =?us-ascii?Q?oWKp6FQRP+XylcId0gu3utlbI+UH0A08HJXNUDCVTjCyXRJhS3Tbls9DMS/v?=
 =?us-ascii?Q?RYHpQN+NKE24B0S4zEy6snqmS7jBaUA6hKxX9m7KiVOqp51SY9S+hDhpSehM?=
 =?us-ascii?Q?XSLow/EfMnc9STst3UXDOHUMf9TsLyoeMmpwTNT721AHYbDs9A7I3Jc1VDLF?=
 =?us-ascii?Q?0+HaKvLI1SSsKWlFPA3hBJtjoXJoXMjRwJm0P9l3UnlDRK7Im88jNxd2RXl5?=
 =?us-ascii?Q?2OHvnA312TIZVXS7v0tajFU7xmtbhOupTUanf+LE8s+kYvby8UIL9X0+FDVA?=
 =?us-ascii?Q?klnBNATUdVU9950ybstYBv4dy0BR8H1wlynUldUV+OkQYj7IXwpH/YFTORaO?=
 =?us-ascii?Q?oQugrX3ytOVpVTLaXKwrT4l3hAUI6iQ+ED3YHMZlpD8sA6/fpjajfTZsUeEw?=
 =?us-ascii?Q?LHT9kc/0kbbLqPl00ozAbd4PfPBJzre4IAG5crj1UJimSZjGd4L9Vosch8je?=
 =?us-ascii?Q?nxQt7v+J45f8dx4QtMW2fSVmZS7Q+acn3+pqn8sDs3292BvnKmpLUo/u26qi?=
 =?us-ascii?Q?LfuWxt5Siy85XC50cOjiEfblXC2y3wj2VlGIsMZVm92DWtHq4V7mKu1HeZFR?=
 =?us-ascii?Q?e7D0X4z8/AMrUCCyFTzET7bWbx3xm42DpY6PDlX4C67+xrKs0L5saO+N24Ya?=
 =?us-ascii?Q?jmFbXLvutC1l45nBsSU7/xfu+9ffBXe5aJpj3z8CjYBdYVIJpCGQkBrkEC91?=
 =?us-ascii?Q?IGS3r7sfiLUUNFvB9eIss2X4IfVrowe757ACX/mcdF/fgNb4t5+MJiDO5mpI?=
 =?us-ascii?Q?RUPpJDrS9npvXx0jY4+BQZGQkff6uuX1SKHjXG7sTv1jC76AyGLh6O1cFWpc?=
 =?us-ascii?Q?tMnlz1fhPyimHj96lNFR+7w4lan4JklC56bVvG4mSt9TKPpdG/JQU1dQc7e0?=
 =?us-ascii?Q?rygyOLtidxv6LUMFclOAnFdrVLYsL7dVsN9Xkk7dYahB/6pzHSGpjPBwrAi6?=
 =?us-ascii?Q?zvCAMr/FdCetqW/RqjRFuXDB/c3DW6nM5JjMxUiHY/mzi4Z3PQlNMCeCSHBc?=
 =?us-ascii?Q?9vudbWgSC3FUb68XPPrWqM1L3F6QbY0bkUfP4YNo1rKJow8xxFalNp06ZjJ+?=
 =?us-ascii?Q?3K7ydrAfQih9kHxezgkJyZL1gmfRy9etF2ILEwK/trGslehThz2HxBLiV6Dd?=
 =?us-ascii?Q?jC9j9Psb4eo8Aw8MMC53hncm+XKmr3e8xZxIfEEMDzaULyrtL+lMkLpePv8R?=
 =?us-ascii?Q?N8AvgBNPrL5D+mgKsFE0XgHwFs3HSTug2+kR/WE1blxKNXeGbttEjrTLZj4p?=
 =?us-ascii?Q?nsA6rYxWtk3EghxW1vJkX7rOxGVWG54YtfsMnr0bK/X3gCfnI3OQ+TlDiODX?=
 =?us-ascii?Q?fmIA3Rw5MT7pP3wg+DB+JmfSZUERAr+Ee0EuGZQMNhfWz2ZtnAoL9Nt1fJ4g?=
 =?us-ascii?Q?5jZiQeScFpOBcic=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9034.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nM4khyWWlngAzDRL9E3H09GBLkWtVZp2DYIBNgz49+MzEiIg8syoN90byUdV?=
 =?us-ascii?Q?sxjboM6DJQ7WB7bm5sgwmc8gnnVK6nwfnzR1doVX3B2UHzHi+ujaG8vBeSe9?=
 =?us-ascii?Q?Jo0eTq2whFBvIsZoD0V+FJy9c4zvIl4n4SeR71/tk1TXShumOFwlCVU8ihdy?=
 =?us-ascii?Q?2GYFu5MGGC2RWHFwnrzQX8pgiwd6B4hK1aJ5pHNV6Hncpt+KkilgjrgCxO7L?=
 =?us-ascii?Q?TI0LVUZeDcFyYTGeKQzIcflUhxNkEczARhDqeLI3rLBAXPsymc2gEKkAVnBs?=
 =?us-ascii?Q?HH44ipNDWy1x1xqMjcxgIXFDC4SdwqcE/7eCx0G28G10BdFOs5tr19i+ETH7?=
 =?us-ascii?Q?5ZvJJafIPZmExnRR8vHYB+yrbsxAc6fQq12mH4FZSPRd4QSBwCjn8avcoG8W?=
 =?us-ascii?Q?1IjES2ggoa1aL5CjOIZT1QKJ3r5BbAXVSURWSYHyEhVZ/7NPzf8EGzgaDITZ?=
 =?us-ascii?Q?kBm5X2260b7c8w//y1v6Ni8L7wEFGwZXjq/X22tm6nLVQuLk0ikQVU5/Fuhr?=
 =?us-ascii?Q?8FITs1IcR5C+NR5cHCRD/KoywYJsTVMIxoT6fv3oewd8lRJxwlAnWVQa9NHK?=
 =?us-ascii?Q?8Nwt5JD6u5xJcuTsSyjHQO6URawrt4MNVWTZl4UEd0XhD9q9BpqpubMWdOiM?=
 =?us-ascii?Q?Z/S1pv0cGkTK+JZeD/pDTlzUsiz3xMqcGrkGRbeKD4Modsbp+YzonJfeS8uU?=
 =?us-ascii?Q?uhDLG07oXjgCf7gf88MqCkDCr5AzWulPcbr9njPXkU8YFKeAWCskgBK67wd+?=
 =?us-ascii?Q?XPdnUag66N+c7bkeKebR+gg/c555yzdiLahZlJlWE0brVMWkdZYYWMski2MC?=
 =?us-ascii?Q?c7nWKeRTN1FXGNL00dOwmlYQsTvJd7mOIgL4C2GAlQJ6My0BEOl5zi3jccCP?=
 =?us-ascii?Q?XS8pFGG+PimrhTaf+BCiWMPJ/jG2N5Ks98raFXqv3+pJ8wsZ7/VL3OUBd2S3?=
 =?us-ascii?Q?u2589wLUdNB5FOl6qBJiu+JZEdftFv5A55Htp+tKL2gtuzSYQhIyFCgLddc+?=
 =?us-ascii?Q?fCoilZZD1SFGe5G8/bWXCBRHnzCEfBw3ezg/6cmRKzwuVtaxtsxpTortjTiw?=
 =?us-ascii?Q?S6IEWdJCMH4RxtUlp9ROO0YRw2Uog2s+Z8eFFW+5lW+2TjaKI1oMqYMjcnTX?=
 =?us-ascii?Q?zkPZdsIacnWNJZlVbIqBtm1W8HouzeWJ0ir8iTzzBUFXgNtwl1bGBtnFYNPc?=
 =?us-ascii?Q?G+ITqvmE0QYk2cOeqOZ47caJVIph7360z5cFs+B7P8mhWT61emLYf+rQbZHB?=
 =?us-ascii?Q?QG4BF3T/kj1qp/XOEwX50zO6LjZknSlz5rKEZh08wpk6CY6PMMMR9rXxp4CR?=
 =?us-ascii?Q?yxuTH/MHuPp85A67sZkX8PbmieElZHhLNvkCA8yJG2gRLkWX3o4GTNbevup6?=
 =?us-ascii?Q?vb4thBt7QSjx3YNvEXUZOuoPqPw6Q4AcKb6xBrm0FDlixxWSX3u7Uegl1Sf5?=
 =?us-ascii?Q?q7RpVzpU/Wp/BmWwQaSKhO8viKXy/70lshfpsv8cyiQ/ycl9YDpICWilOjIP?=
 =?us-ascii?Q?ZkBR5G8hiZC8fgP6fT2EZC0WV6ominyum0KUXEiIPvwZUXf68PedjAyST3tW?=
 =?us-ascii?Q?FMjX11Iwih3nXSiZG6/2mtJvFq/ksHa2ilc+rJgk?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9034.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f296db68-2e9a-454f-de39-08ddf9b16c34
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2025 08:24:17.6021 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LQseeG7eAdg0jpAL4b5rshjgUBR1bj5yGEuYIK/vIyMozzKnmd1RX5E7QvkuBphnaq8TwjD3af6Jp5PUVybfPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB8808
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
> From: Ciara Loftus <ciara.loftus@intel.com>
> Sent: Wednesday, September 17, 2025 2:47 PM
> To: dev@dpdk.org
> Cc: Loftus, Ciara <ciara.loftus@intel.com>
> Subject: [PATCH v2 0/5] idpf and cpfl rx path selection simplification
>=20
> This series refactors the vector capability detection and Rx path selecti=
on code
> in the idpf and cpfl PMDs to use the common functions provided in
> drivers/net/intel/common/rx.h.
>=20
> v2:
> * Moved AVX512DQ check to common code.
> * Refactored rx function array definition for better readability.
> * Restored Rx functions back to their original names.
>=20
> Ciara Loftus (5):
>   net/intel: add AVX512DQ flag to AVX-512 checks
>   net/idpf: use the new common vector capability function
>   net/idpf: use the common Rx path selection infrastructure
>   net/cpfl: use the new common vector capability function
>   net/cpfl: use the common Rx path selection infrastructure
>=20
Tested-by: <shaiq.wani@intel.com>

>  drivers/net/intel/common/rx.h                 |   5 +
>  drivers/net/intel/common/rx_vec_x86.h         |   3 +-
>  drivers/net/intel/cpfl/cpfl_rxtx.c            | 143 +++++-------------
>  drivers/net/intel/cpfl/cpfl_rxtx_vec_common.h |  12 ++
>  drivers/net/intel/idpf/idpf_common_device.h   |  17 ++-
>  drivers/net/intel/idpf/idpf_common_rxtx.c     |  51 +++++++
>  drivers/net/intel/idpf/idpf_common_rxtx.h     |  12 ++
>  drivers/net/intel/idpf/idpf_ethdev.c          |   2 +
>  drivers/net/intel/idpf/idpf_rxtx.c            | 141 +++++------------
>  drivers/net/intel/idpf/idpf_rxtx_vec_common.h |  11 ++
>  10 files changed, 180 insertions(+), 217 deletions(-)
>=20
> --
> 2.34.1

