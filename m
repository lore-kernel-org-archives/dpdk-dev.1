Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBFDCA100C
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Sep 2025 09:38:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1232B402BC;
	Wed,  3 Sep 2025 11:38:31 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
 by mails.dpdk.org (Postfix) with ESMTP id 7F05140261
 for <dev@dpdk.org>; Wed,  3 Sep 2025 11:38:28 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i2PRyUj7p55yUY697TK6DaEPApOqiVxQyUG3mrqjWWvNadFtDOegVkfc2aRyIaqOxg5PUu6R08NjEoWYkPkF4cJpqB3JAHfRDz7w2A4LztA7Fv1dvKsqIyRh/s81BttB55LAfCgwyJZMKxMzhBN6jUA604zkAsBBNnFyo4D2MPnuEOfPjEXVp39fFUZJ/Y3WR2Nze2PmE5Rl/vnGiMv1ZFvNziWSeEIFoOPSgTqcw2ZNAxlIPT3tPVDKh54tCg/mb/qVbPqm2pHW0BwBlE+8uRmyL89XVmP9/XaqqZz4Gz2jkGICOiRclQewd+B9ImdGTHdnokzsfGsjLu/G3YARYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F8BTdW7RA3NlHwbCImmNi7jBkFTsoOzXlFQf7zQB3gc=;
 b=r54skumIoUikYEgApjhT1L1imRmv19K9bHwFmn31EHCkgDhmzt1DyTxSwsYk6dlinO0ObEqj9HJDciPlnO25Owle732gOX9RxE+2s9QBi5dXvQycKnjcVAacHQlmOGor1VEfqpRslP7dnLvXXl6GYthux8NAOQ+EilpzKK97J8sULIMBT552ToAyMhboNur5NTiI5QRHGo2OgTmPqniOOMwtSXZJl/FGC1zaFEfUutV/bLBcreVv/pT1JXimn0cHenwPQ/wEiLPPJs9GQgY7PoFGvS30xyPDui0NKUHCHhpPT0geE2S6Qv5fNULWB5sOtvJPRSSKqn3lqLDjlF3tlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F8BTdW7RA3NlHwbCImmNi7jBkFTsoOzXlFQf7zQB3gc=;
 b=BSKxF6qu20lXQpzO249bEiELlsFl9eU1dHIhUL5JwmAha6wxty1oz/fZD+J5izABv0zMRMFec32tIhKe5+WH6itPYo4vfA9N3Yjnim916A0oCru6QPJaskHURwUoWzd1bRZec+Qy7nnZrzKXHtb/RRAkU4vxxmzM0F+Xk8U3K0apDOOuEMfPL5iL1q/pD+z2dAsA8dgalMBj6NITYKP/vJ5aaYd52CSJ3WX1WPKU7BVPdLW34PsrzA5W62esA0fcuYRbCwv+ByjIkASOhBY1PnSWCUgPyGciKvW33MhAuH658m/0yL4p4FTmgffKWF92Vb8sIpu74DMfSaKQW1E45w==
Received: from BY5PR03MB5234.namprd03.prod.outlook.com (2603:10b6:a03:219::14)
 by SA3PR03MB7345.namprd03.prod.outlook.com (2603:10b6:806:37e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Wed, 3 Sep
 2025 09:38:26 +0000
Received: from BY5PR03MB5234.namprd03.prod.outlook.com
 ([fe80::5116:191e:bbfe:5859]) by BY5PR03MB5234.namprd03.prod.outlook.com
 ([fe80::5116:191e:bbfe:5859%6]) with mapi id 15.20.9094.016; Wed, 3 Sep 2025
 09:38:25 +0000
From: "Xu, Rosen" <rosen.xu@altera.com>
To: David Marchand <david.marchand@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "thomas@monjalon.net" <thomas@monjalon.net>, "maxime.coquelin@redhat.com"
 <maxime.coquelin@redhat.com>, Nipun Gupta <nipun.gupta@amd.com>, Nikhil
 Agarwal <nikhil.agarwal@amd.com>, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Anatoly Burakov
 <anatoly.burakov@intel.com>, Chenbo Xia <chenbox@nvidia.com>, Tomasz
 Duszynski <tduszynski@marvell.com>, Kai Ji <kai.ji@intel.com>, Ajit Khaparde
 <ajit.khaparde@broadcom.com>, Vikas Gupta <vikas.gupta@broadcom.com>, Dengdui
 Huang <huangdengdui@huawei.com>, Chaoyong He <chaoyong.he@corigine.com>,
 Vijay Kumar Srivastava <vsrivast@xilinx.com>, Tyler Retzlaff
 <roretzla@linux.microsoft.com>, Harman Kalra <hkalra@marvell.com>
Subject: RE: [RFC 6/8] vfio: stop including Linux kernel header in public and
 driver API
Thread-Topic: [RFC 6/8] vfio: stop including Linux kernel header in public and
 driver API
Thread-Index: AQHcHKSGhGu1WMbzE0GM2AHZ0Kj/zbSBM04Q
Date: Wed, 3 Sep 2025 09:38:25 +0000
Message-ID: <BY5PR03MB5234ED41DC3B58F0BF54A1C1FC01A@BY5PR03MB5234.namprd03.prod.outlook.com>
References: <20250903072826.1727004-1-david.marchand@redhat.com>
 <20250903072826.1727004-7-david.marchand@redhat.com>
In-Reply-To: <20250903072826.1727004-7-david.marchand@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR03MB5234:EE_|SA3PR03MB7345:EE_
x-ms-office365-filtering-correlation-id: 42a7359a-8175-4e6f-6f54-08ddeacda1af
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|366016|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?7GWVdR1ptptZU/209ocJp4Ds7dz1QlHsYvWShyevs23H3gAu/2KA0b5ony/r?=
 =?us-ascii?Q?0WNSEdyOdgU07UDP/5FP6/r8sMKWR8zjcxcnOjkPDb7L2Z4hROUJGjMC/ECt?=
 =?us-ascii?Q?rDydo0O1us7JW+AyxbuJHM5zQYMqfv2UPRiaSc4GVu4W0yAOo6Ucw67Jw1Ta?=
 =?us-ascii?Q?nTdk1Ve9J5/Qpjz2l6qR/sUYC/f4AlYXgf9gppTNRGMqcWa9N5hpsKA3CYTd?=
 =?us-ascii?Q?TpVffuS6xvwFKsu/gnXtlEDerQtbcwZw1Dgc+01NDlOs71f9PH0IZWJrHUVa?=
 =?us-ascii?Q?O0otsr/iQr5Mh2zvEBGq6SbO/MCXd2YJBjaIuD9DwXYQAXtNDXTnPoCybM6y?=
 =?us-ascii?Q?5oqL1w3B8nWrn3TGMHQsidqrdgQtNHjHOrq5QFqxH3huYw5d9k3HwrlkUjJR?=
 =?us-ascii?Q?ss2JVKQd9RZHNCl3alSzWbU85SYBooggAMATCzwou+OsRp7OHy+ckN6eR2Vc?=
 =?us-ascii?Q?boIupGIDd08oQHlmpFu8a6Lip0vpfWH+ypu6ofj+9C76QX3ELDju2HzL4a3l?=
 =?us-ascii?Q?6ya40j9QSWXs27kHPl1iwpr+kfTQa/LSGJIVHvXY35cLmJ52XKW5lpvUV+eO?=
 =?us-ascii?Q?oOsZuEdfv5ULAkPyM+JG5NZrsfZUbRxQcwWS9eI9cj7Fs7WALblQUbGdnAvy?=
 =?us-ascii?Q?PT7ZdfG395PqAE4zeh7NgWHDmXOs6nVASj+rb1IMbrUFNIeZpFwdP/BLOfjo?=
 =?us-ascii?Q?aag6e+3h+yM1FVVo9q98OdppAU2XTwI1tUO097a9dJyECejp0TDXxkL1urYD?=
 =?us-ascii?Q?33TuR2Gg1jtCbd3VzGYMwUqPsXSaNGYWVEhZ5onNrS/breeNDPtqP9MONmiv?=
 =?us-ascii?Q?UBiHnUi2WIPwg3sXDNnnVewSJO90NhoRQ7pthnUuM5NFv+IvyoeLYzVQu8Cq?=
 =?us-ascii?Q?YeL2WJdg1jQk2f2qr4e07hns3Q2sxwPe408MLxI36Dqp70O9hqbNFNiZYoAD?=
 =?us-ascii?Q?5HI+uu1g412JsWrVFYsQ1bDy4+qJcF8NH1MCpsssXrn41BmtLbVSfrvBoQem?=
 =?us-ascii?Q?iQUthQI3InLWxh6So7ex/N6SFPQX6AN0re7911Sf21bBJFal6mHtpfD4Y+6x?=
 =?us-ascii?Q?yjJxk3eh4XJDl4xdIwxsxvpbPAJl8CuxQk7Df3MSIYP1O5Q9IGqeLSGtyIkm?=
 =?us-ascii?Q?AQz2UnHEhfFI54Zm1lBO6nt0w+YcQIiYkmpBUToXVZbd48HWbk5htFXTmiNZ?=
 =?us-ascii?Q?hy5K3wO76ciR0MmJpt9npevQrUqfp2mxl/kZasZpDjwahJS0xHuNxt5xCtGm?=
 =?us-ascii?Q?YueobB+yOKKeM+hezkp3MIF+95EmY6ZTLMiWAjav01HcRUjM0CE4oVhoV7mk?=
 =?us-ascii?Q?a0ylTuzEah8MNyV9XB6hNftdVKKnhpYSJ2j8eyoD6x4MPN8k6gYA2ueLYt0Q?=
 =?us-ascii?Q?OyuO3gSkFzWrFoi8r71OaK07xRh70bQDByCibjCSQf3E4mpWG2HoRdazb/YH?=
 =?us-ascii?Q?Q5VmFCP81ti+SZ0azeej86koqSlaGOu9a+L6ZKyB8kLtyujCCzc+aQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR03MB5234.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ojApcrgRVHdtfYKiC9AP6kLKfVXu2PetErwhyDlBWnRFoyYKfaTY+YFBYOA8?=
 =?us-ascii?Q?0TQKX/dnKm4aakh7NbFCyg1ULjmAlYArYr/9IF2EnliZT6MlCsXRXkHzmjJN?=
 =?us-ascii?Q?iEgWuF3NUsR+wNv8I9PwDy8goB6c8/6zweUpzSa1ImeW7j0ItuGu3in8hvaz?=
 =?us-ascii?Q?o66uAczn8RVz8CntD2bdVzcRd46wyX30JmOc5v/z25ucvIBDnKePZ4p/MCh1?=
 =?us-ascii?Q?8rCCZAinis+PN1eo32Z93AqE7JfBEuV1jrMkAlw1/TycUY5pEloLLo30pbL6?=
 =?us-ascii?Q?bjcVInegw0ncQiyN1S0iZpH+isiSsdCu3NaLZhEPzx4MdApX9Ue6Mg9F2GTH?=
 =?us-ascii?Q?hVUsE+VSZrH0W57WqKPyNeoeL+7t1FldYMUUT7K24YSS7vcRvwF4BA1pLc7H?=
 =?us-ascii?Q?utphBcl9ezUIlxkNjDaoPUHxLqVxCRJlvkUJl5Rf90mGPRwdlFbifk7tObs3?=
 =?us-ascii?Q?3TOKpKNg4+oLtruoh1LbpMEwD6B7gRQ98eD1kI1FUeKT6lIYnEZ96bTaTpCd?=
 =?us-ascii?Q?MrN8BR5tutbYkSNYRKk5qxUe+bUSZyy+hmuMhy8CK2wqtWKoejRdJu3UtlmK?=
 =?us-ascii?Q?jLjQzksknMn7syn1J4Ao9cjSH+6IEAt6P7zg4D+WJobzYnk3nJpEYaafZ6a/?=
 =?us-ascii?Q?9cHiI0uuDfDC07LfI5+9c7Bn8JZdH7Xn43ebTPfF5iA2X1P9iOtZWXibUGjg?=
 =?us-ascii?Q?bbue6gPRvT+ork4AOpW2oWg1C4RExyDjan9Qq3rlLQ1zBKhQ8J4+Z/tEPdXb?=
 =?us-ascii?Q?MIKeqmtTVbHJ3/mQbPr/Yqs398GSytBp5wSgSAPxIRioK0GalREJZbdfwqyT?=
 =?us-ascii?Q?oPHTfu4zLQSwZ+Ml2r5rfKjl/llUb0/6FaSrH0lLivMNd8ru7PrlotEfOumY?=
 =?us-ascii?Q?BlL1fwxuri/sU8KIyP/EeuLceJLgDpST0T1sDW6kUZFN2AfXCtnFIB5W0f6A?=
 =?us-ascii?Q?lwFDwL+Oc+VOroBqn0DadI5qJT8pUl7wWU6SakqjUyCNL+Egbf0XkbqZiGLg?=
 =?us-ascii?Q?wXBxWLMJHHld2wyskApDoPC5OBgaC5hZ6ugHc5ZlLUJOkyOENwazeYzCSuvn?=
 =?us-ascii?Q?Zj5Cdgb3RqWOp8dsbcLl5I7WP0CqTn4nD9zVAoaysJcwWa6TzU2ZWoLxncG7?=
 =?us-ascii?Q?qiD8wM+XkY/pcdsBk2noY29OrP6nq3TDAZwoyiWULWP9nOq+JgfEMB3vtjbx?=
 =?us-ascii?Q?v+xAotDrwlSernk7wYUG8+v5F/gbicealWSEosdrAqTVoK5cwqSpu1Z9zCO9?=
 =?us-ascii?Q?YPLsVSN+XCmA2VoJSuyLWSjLufvInuZ3lXRKI9SB8XjYEoMRcI4vjvZFjp85?=
 =?us-ascii?Q?h0RnI78FdWa6GEmpQ3SsrhnupC7+tk3IG/WIaL4TZVAnDY67tiOcFGjKFm3M?=
 =?us-ascii?Q?Hq1aSc5BhEhNHETOTnTocv8X7XaVMcIA7h3LQp1qTD9jTdoqcYwF36OsgUgO?=
 =?us-ascii?Q?ThnJYDFv5HrexsQE5onQN7nAoEonww9o9Hvq6ljd3aYY9y2SeTtnyInRnZIA?=
 =?us-ascii?Q?opczASWCVgN+0xk4vbzPYGO6JKdKb9z5EgD7fbS+I0JEpF2N7Ko1tQ+5HCX/?=
 =?us-ascii?Q?TA/+7Y/uL2d5kv8ePWgw+AMb2mNxD44R+4SQV0zO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR03MB5234.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42a7359a-8175-4e6f-6f54-08ddeacda1af
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2025 09:38:25.7765 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YmlxaNBRQKq0UZNkCYkyE9iRKvxB91szsGazZlWs/rhoe0tOgc77OXwUVc/gvHb3TMV5ZYIm608GKCR/Z34kJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB7345
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

Hi

> -----Original Message-----
> From: David Marchand <david.marchand@redhat.com>
> Sent: Wednesday, September 3, 2025 3:28 PM
> To: dev@dpdk.org
> Cc: thomas@monjalon.net; maxime.coquelin@redhat.com; Nipun Gupta
> <nipun.gupta@amd.com>; Nikhil Agarwal <nikhil.agarwal@amd.com>;
> Hemant Agrawal <hemant.agrawal@nxp.com>; Sachin Saxena
> <sachin.saxena@nxp.com>; Anatoly Burakov <anatoly.burakov@intel.com>;
> Chenbo Xia <chenbox@nvidia.com>; Tomasz Duszynski
> <tduszynski@marvell.com>; Kai Ji <kai.ji@intel.com>; Ajit Khaparde
> <ajit.khaparde@broadcom.com>; Vikas Gupta
> <vikas.gupta@broadcom.com>; Dengdui Huang
> <huangdengdui@huawei.com>; Xu, Rosen <rosen.xu@altera.com>;
> Chaoyong He <chaoyong.he@corigine.com>; Vijay Kumar Srivastava
> <vsrivast@xilinx.com>; Tyler Retzlaff <roretzla@linux.microsoft.com>;
> Harman Kalra <hkalra@marvell.com>
> Subject: [RFC 6/8] vfio: stop including Linux kernel header in public and=
 driver
> API
>=20
> [CAUTION: This email is from outside your organization. Unless you trust =
the
> sender, do not click on links or open attachments as it may be a fraudule=
nt
> email attempting to steal your information and/or compromise your
> computer.]
>=20
> The DPDK API is not dependent on the VFIO API itself.
> Remove inclusion in rte_vfio.h (and bus_fslmc_driver.h) and add explicit
> inclusion where needed.
>=20
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
>  drivers/bus/cdx/cdx_vfio.c                 | 3 +++
>  drivers/bus/fslmc/bus_fslmc_driver.h       | 3 ++-
>  drivers/bus/fslmc/fslmc_bus.c              | 1 +
>  drivers/bus/fslmc/fslmc_vfio.c             | 2 ++
>  drivers/bus/fslmc/fslmc_vfio.h             | 1 -
>  drivers/bus/fslmc/portal/dpaa2_hw_dpio.c   | 1 +
>  drivers/bus/pci/linux/pci_vfio.c           | 2 ++
>  drivers/bus/platform/platform.c            | 2 ++
>  drivers/common/qat/dev/qat_dev_gen_lce.c   | 3 ++-
>  drivers/crypto/bcmfs/bcmfs_vfio.c          | 2 ++
>  drivers/net/hns3/hns3_ethdev_vf.c          | 1 -
>  drivers/raw/ifpga/afu_pmd_he_hssi.c        | 1 -
>  drivers/raw/ifpga/afu_pmd_he_lpbk.c        | 1 -
>  drivers/raw/ifpga/afu_pmd_he_mem.c         | 1 -
>  drivers/raw/ifpga/afu_pmd_n3000.c          | 3 ++-
>  drivers/raw/ifpga/base/ifpga_feature_dev.c | 2 +-
>  drivers/vdpa/ifc/ifcvf_vdpa.c              | 2 ++
>  drivers/vdpa/nfp/nfp_vdpa.c                | 2 ++
>  drivers/vdpa/sfc/sfc_vdpa_ops.c            | 3 ++-
>  lib/eal/include/rte_vfio.h                 | 8 --------
>  lib/eal/linux/eal_interrupts.c             | 3 ++-
>  lib/eal/linux/eal_vfio.c                   | 1 +
>  22 files changed, 29 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/bus/cdx/cdx_vfio.c b/drivers/bus/cdx/cdx_vfio.c inde=
x
> 03d156388e..576718a659 100644
> --- a/drivers/bus/cdx/cdx_vfio.c
> +++ b/drivers/bus/cdx/cdx_vfio.c
> @@ -17,6 +17,9 @@
>  #include <sys/socket.h>
>  #include <sys/ioctl.h>
>  #include <sys/mman.h>
> +
> +#include <linux/vfio.h>
> +
>  #include <eal_export.h>
>  #include <rte_eal_paging.h>
>  #include <rte_malloc.h>
> diff --git a/drivers/bus/fslmc/bus_fslmc_driver.h
> b/drivers/bus/fslmc/bus_fslmc_driver.h
> index 442de1a3fb..74ce7381d7 100644
> --- a/drivers/bus/fslmc/bus_fslmc_driver.h
> +++ b/drivers/bus/fslmc/bus_fslmc_driver.h
> @@ -20,7 +20,6 @@
>  #include <sys/queue.h>
>  #include <stdint.h>
>  #include <inttypes.h>
> -#include <linux/vfio.h>
>=20
>  #include <rte_compat.h>
>  #include <rte_debug.h>
> @@ -37,6 +36,8 @@
>  extern "C" {
>  #endif
>=20
> +struct vfio_device_info;
> +
>  #define FSLMC_OBJECT_MAX_LEN 32   /**< Length of each device on bus */
>=20
>  #define DPAA2_INVALID_MBUF_SEQN        0
> diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.=
c
> index 20458d5030..49c61c9d2d 100644
> --- a/drivers/bus/fslmc/fslmc_bus.c
> +++ b/drivers/bus/fslmc/fslmc_bus.c
> @@ -17,6 +17,7 @@
>  #include <rte_memcpy.h>
>  #include <ethdev_driver.h>
>  #include <rte_mbuf_dyn.h>
> +#include <rte_vfio.h>
>=20
>  #include "private.h"
>  #include <fslmc_vfio.h>
> diff --git a/drivers/bus/fslmc/fslmc_vfio.c b/drivers/bus/fslmc/fslmc_vfi=
o.c
> index c08c316c94..3f041f447c 100644
> --- a/drivers/bus/fslmc/fslmc_vfio.c
> +++ b/drivers/bus/fslmc/fslmc_vfio.c
> @@ -20,6 +20,7 @@
>  #include <dirent.h>
>  #include <sys/eventfd.h>
>  #include <ctype.h>
> +#include <linux/vfio.h>
>=20
>  #include <eal_export.h>
>  #include <eal_filesystem.h>
> @@ -32,6 +33,7 @@
>  #include <rte_kvargs.h>
>  #include <dev_driver.h>
>  #include <rte_eal_memconfig.h>
> +#include <rte_vfio.h>
>  #include <eal_vfio.h>
>=20
>  #include "private.h"
> diff --git a/drivers/bus/fslmc/fslmc_vfio.h b/drivers/bus/fslmc/fslmc_vfi=
o.h
> index 815970ec38..c995fd67b8 100644
> --- a/drivers/bus/fslmc/fslmc_vfio.h
> +++ b/drivers/bus/fslmc/fslmc_vfio.h
> @@ -9,7 +9,6 @@
>  #define _FSLMC_VFIO_H_
>=20
>  #include <rte_compat.h>
> -#include <rte_vfio.h>
>=20
>  /* Pathname of FSL-MC devices directory. */
>  #define SYSFS_FSL_MC_DEVICES   "/sys/bus/fsl-mc/devices"
> diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
> b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
> index e32471d8b5..cffbf3c28a 100644
> --- a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
> +++ b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
> @@ -22,6 +22,7 @@
>  #include <sys/epoll.h>
>  #include <sys/eventfd.h>
>  #include <sys/syscall.h>
> +#include <linux/vfio.h>
>=20
>  #include <eal_export.h>
>  #include <rte_mbuf.h>
> diff --git a/drivers/bus/pci/linux/pci_vfio.c b/drivers/bus/pci/linux/pci=
_vfio.c
> index 9e5776ce3c..46b87c7c38 100644
> --- a/drivers/bus/pci/linux/pci_vfio.c
> +++ b/drivers/bus/pci/linux/pci_vfio.c
> @@ -11,6 +11,8 @@
>  #include <sys/mman.h>
>  #include <stdbool.h>
>=20
> +#include <linux/vfio.h>
> +
>  #include <rte_log.h>
>  #include <rte_pci.h>
>  #include <rte_bus_pci.h>
> diff --git a/drivers/bus/platform/platform.c
> b/drivers/bus/platform/platform.c index 90524fd961..149cba81a7 100644
> --- a/drivers/bus/platform/platform.c
> +++ b/drivers/bus/platform/platform.c
> @@ -11,6 +11,8 @@
>  #include <sys/queue.h>
>  #include <unistd.h>
>=20
> +#include <linux/vfio.h>
> +
>  #include <bus_driver.h>
>  #include <bus_platform_driver.h>
>  #include <eal_export.h>
> diff --git a/drivers/common/qat/dev/qat_dev_gen_lce.c
> b/drivers/common/qat/dev/qat_dev_gen_lce.c
> index 6514321c32..466878bf76 100644
> --- a/drivers/common/qat/dev/qat_dev_gen_lce.c
> +++ b/drivers/common/qat/dev/qat_dev_gen_lce.c
> @@ -3,7 +3,8 @@
>   */
>=20
>  #include <rte_pci.h>
> -#include <rte_vfio.h>
> +
> +#include <linux/vfio.h>
>=20
>  #include "qat_device.h"
>  #include "qat_qp.h"
> diff --git a/drivers/crypto/bcmfs/bcmfs_vfio.c
> b/drivers/crypto/bcmfs/bcmfs_vfio.c
> index 9138f96eb0..e747bef924 100644
> --- a/drivers/crypto/bcmfs/bcmfs_vfio.c
> +++ b/drivers/crypto/bcmfs/bcmfs_vfio.c
> @@ -7,6 +7,8 @@
>  #include <sys/mman.h>
>  #include <sys/ioctl.h>
>=20
> +#include <linux/vfio.h>
> +
>  #include <rte_vfio.h>
>=20
>  #include "bcmfs_device.h"
> diff --git a/drivers/net/hns3/hns3_ethdev_vf.c
> b/drivers/net/hns3/hns3_ethdev_vf.c
> index f9ef3dbb06..59fb790240 100644
> --- a/drivers/net/hns3/hns3_ethdev_vf.c
> +++ b/drivers/net/hns3/hns3_ethdev_vf.c
> @@ -5,7 +5,6 @@
>  #include <rte_alarm.h>
>  #include <ethdev_pci.h>
>  #include <rte_io.h>
> -#include <rte_vfio.h>
>=20
>  #include "hns3_ethdev.h"
>  #include "hns3_common.h"
> diff --git a/drivers/raw/ifpga/afu_pmd_he_hssi.c
> b/drivers/raw/ifpga/afu_pmd_he_hssi.c
> index 859f28dcc1..bcb952935a 100644
> --- a/drivers/raw/ifpga/afu_pmd_he_hssi.c
> +++ b/drivers/raw/ifpga/afu_pmd_he_hssi.c
> @@ -17,7 +17,6 @@
>  #include <rte_malloc.h>
>  #include <rte_memcpy.h>
>  #include <rte_io.h>
> -#include <rte_vfio.h>
>  #include <bus_pci_driver.h>
>  #include <bus_ifpga_driver.h>
>  #include <rte_rawdev.h>
> diff --git a/drivers/raw/ifpga/afu_pmd_he_lpbk.c
> b/drivers/raw/ifpga/afu_pmd_he_lpbk.c
> index c7c5cda48c..df3b093157 100644
> --- a/drivers/raw/ifpga/afu_pmd_he_lpbk.c
> +++ b/drivers/raw/ifpga/afu_pmd_he_lpbk.c
> @@ -17,7 +17,6 @@
>  #include <rte_malloc.h>
>  #include <rte_memcpy.h>
>  #include <rte_io.h>
> -#include <rte_vfio.h>
>  #include <bus_pci_driver.h>
>  #include <bus_ifpga_driver.h>
>  #include <rte_rawdev.h>
> diff --git a/drivers/raw/ifpga/afu_pmd_he_mem.c
> b/drivers/raw/ifpga/afu_pmd_he_mem.c
> index a1db533eeb..b595cd729c 100644
> --- a/drivers/raw/ifpga/afu_pmd_he_mem.c
> +++ b/drivers/raw/ifpga/afu_pmd_he_mem.c
> @@ -16,7 +16,6 @@
>  #include <rte_malloc.h>
>  #include <rte_memcpy.h>
>  #include <rte_io.h>
> -#include <rte_vfio.h>
>  #include <bus_pci_driver.h>
>  #include <bus_ifpga_driver.h>
>  #include <rte_rawdev.h>
> diff --git a/drivers/raw/ifpga/afu_pmd_n3000.c
> b/drivers/raw/ifpga/afu_pmd_n3000.c
> index 0882a27701..ec2fdd46df 100644
> --- a/drivers/raw/ifpga/afu_pmd_n3000.c
> +++ b/drivers/raw/ifpga/afu_pmd_n3000.c
> @@ -13,11 +13,12 @@
>  #include <sys/eventfd.h>
>  #include <sys/ioctl.h>
>=20
> +#include <linux/vfio.h>
> +
>  #include <rte_eal.h>
>  #include <rte_malloc.h>
>  #include <rte_memcpy.h>
>  #include <rte_io.h>
> -#include <rte_vfio.h>
>  #include <bus_pci_driver.h>
>  #include <bus_ifpga_driver.h>
>  #include <rte_rawdev.h>
> diff --git a/drivers/raw/ifpga/base/ifpga_feature_dev.c
> b/drivers/raw/ifpga/base/ifpga_feature_dev.c
> index 0a00af1b6b..3402ad97e4 100644
> --- a/drivers/raw/ifpga/base/ifpga_feature_dev.c
> +++ b/drivers/raw/ifpga/base/ifpga_feature_dev.c
> @@ -3,7 +3,7 @@
>   */
>=20
>  #include <sys/ioctl.h>
> -#include <rte_vfio.h>
> +#include <linux/vfio.h>
>=20
>  #include "ifpga_feature_dev.h"
>=20
> diff --git a/drivers/vdpa/ifc/ifcvf_vdpa.c b/drivers/vdpa/ifc/ifcvf_vdpa.=
c
> index 65de383b95..c8e47e41c1 100644
> --- a/drivers/vdpa/ifc/ifcvf_vdpa.c
> +++ b/drivers/vdpa/ifc/ifcvf_vdpa.c
> @@ -11,6 +11,8 @@
>  #include <linux/virtio_net.h>
>  #include <stdbool.h>
>=20
> +#include <linux/vfio.h>
> +
>  #include <rte_eal_paging.h>
>  #include <rte_malloc.h>
>  #include <rte_memory.h>
> diff --git a/drivers/vdpa/nfp/nfp_vdpa.c b/drivers/vdpa/nfp/nfp_vdpa.c
> index 7f2f21ec6c..c1ffbd1f91 100644
> --- a/drivers/vdpa/nfp/nfp_vdpa.c
> +++ b/drivers/vdpa/nfp/nfp_vdpa.c
> @@ -8,6 +8,8 @@
>  #include <sys/ioctl.h>
>  #include <unistd.h>
>=20
> +#include <linux/vfio.h>
> +
>  #include <nfp_common_pci.h>
>  #include <nfp_dev.h>
>  #include <rte_vfio.h>
> diff --git a/drivers/vdpa/sfc/sfc_vdpa_ops.c
> b/drivers/vdpa/sfc/sfc_vdpa_ops.c index 00f9a4b04c..1ece47d373 100644
> --- a/drivers/vdpa/sfc/sfc_vdpa_ops.c
> +++ b/drivers/vdpa/sfc/sfc_vdpa_ops.c
> @@ -6,10 +6,11 @@
>  #include <unistd.h>
>  #include <sys/ioctl.h>
>=20
> +#include <linux/vfio.h>
> +
>  #include <rte_errno.h>
>  #include <rte_malloc.h>
>  #include <rte_vdpa.h>
> -#include <rte_vfio.h>
>  #include <rte_vhost.h>
>=20
>  #include <vdpa_driver.h>
> diff --git a/lib/eal/include/rte_vfio.h b/lib/eal/include/rte_vfio.h inde=
x
> 509ffec80c..683affa933 100644
> --- a/lib/eal/include/rte_vfio.h
> +++ b/lib/eal/include/rte_vfio.h
> @@ -19,17 +19,9 @@
>  extern "C" {
>  #endif
>=20
> -#ifdef RTE_EXEC_ENV_LINUX
> -
> -#include <linux/vfio.h>
> -
> -#else /* ! RTE_EXEC_ENV_LINUX */
> -
>  /* we don't need an actual definition, only pointer is used */  struct
> vfio_device_info;
>=20
> -#endif /* RTE_EXEC_ENV_LINUX */
> -
>  #define RTE_VFIO_DEFAULT_CONTAINER_FD (-1)
>=20
>  /**
> diff --git a/lib/eal/linux/eal_interrupts.c b/lib/eal/linux/eal_interrupt=
s.c
> index 43e05c86a2..d1789cbda2 100644
> --- a/lib/eal/linux/eal_interrupts.c
> +++ b/lib/eal/linux/eal_interrupts.c
> @@ -15,6 +15,8 @@
>  #include <assert.h>
>  #include <stdbool.h>
>=20
> +#include <linux/vfio.h>
> +
>  #include <eal_export.h>
>  #include <eal_trace_internal.h>
>  #include <rte_common.h>
> @@ -28,7 +30,6 @@
>  #include <rte_errno.h>
>  #include <rte_spinlock.h>
>  #include <rte_pause.h>
> -#include <rte_vfio.h>
>=20
>  #include "eal_private.h"
>=20
> diff --git a/lib/eal/linux/eal_vfio.c b/lib/eal/linux/eal_vfio.c index
> c6aed44946..62f9d05e63 100644
> --- a/lib/eal/linux/eal_vfio.c
> +++ b/lib/eal/linux/eal_vfio.c
> @@ -8,6 +8,7 @@
>  #include <unistd.h>
>  #include <sys/ioctl.h>
>  #include <dirent.h>
> +#include <linux/vfio.h>
>=20
>  #include <rte_errno.h>
>  #include <rte_log.h>
> --
> 2.51.0

Reviewed-by: Rosen Xu <rosen.xu@altera.com>
