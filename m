Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90F5C3ABC0
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 May 2025 10:16:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9090E4025D;
	Wed,  7 May 2025 12:16:16 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 708944025A
 for <dev@dpdk.org>; Wed,  7 May 2025 12:16:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746612974; x=1778148974;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=LvFV4BAfd+9A5Z4ZcbHvZcRruD4NyGNqXMhSFZsVkfc=;
 b=PqNgzpNCphcejmJxQ1Dvi+RnpGjCm7ceIUGQePixJIx5aazCBQyMBhJj
 MixhnE0wqHTAz64n7UrZUK6OiHsxAk0FJZlO/QyRww1WYE+XLwXGC8R2d
 nodgcb4Hvj3DGYY1L12w2p75U1nseTwGRpA2nongEKOkodS6utnL042QJ
 u1PpCLkJWP6NGItM2qZda9q8cBNQ+iMXiuzV1khDSdwnUKwiRMO+9qCob
 239wZo9P5cXa7Dbkc3GAUZGRC+kCSPX7wMCfihvHUiGE2t6hqOmQ+5gao
 +BT9vN+qoH5X56AVxyHSWEESvrTMO2/sZ4C6k2eUeNaw0491grIO40Oax A==;
X-CSE-ConnectionGUID: ShcISXHYTlS6Raeq5JvgYg==
X-CSE-MsgGUID: 0+Chjq0qQJuT7M+tdnSxpw==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="48411613"
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; d="scan'208,217";a="48411613"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2025 03:16:12 -0700
X-CSE-ConnectionGUID: 4zyTvZjtRoibXoDFmQmF0A==
X-CSE-MsgGUID: gk3zXFQITyK+oNBlB4wHpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; 
 d="scan'208,217";a="135873538"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2025 03:16:13 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 7 May 2025 03:16:11 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 7 May 2025 03:16:11 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 7 May 2025 03:15:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s/A9JVqwQVv1n9t5mlzkA74Hw4LOVO3oMrXnvWLRkWINgkmfVH6Q1zEm5XXC5lH8k7pUoE+b6pqN0rKNgo7iz6kaBu+SN6PxsTghc4YHPFsja6tIjzWyrxYAk/bAMWBekXocFEEJgNKT4b0+YQWyNfKWwUDD4LZQwzf2/p+E77kHBw5NHUJTWW7iKszVA9DcfRV2Sc3IYNufh+90t9TOfUtEru9lWZRS/2LWbsJCIDu+fFC8noR03+2MZ/svwx3LtsiGJOGkRJ8uqO6leXqFHfyVlNGyREjLBjFhAhTR51CyBMiwaSaLw4j7qZiv9FRhFSjT/R2xEykdHtsIVPVNRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BhB8P8HxvqVcBPZ91tpaNNnSxQPdtvOBzgvlG0/Gobw=;
 b=NNQ71hTCk//WQqN15KEnyyHHvCbWpmbfKp6c/0VSWYcYT2f1RsXS8M9jqRHxNUS3ajxUlSGtbnYgNjxnmKuZHbFBGG2swVK90/iwG4GzPYzJkTLUzzo7kKZRYGwBg5ys2hxLJ8yIBDWIC0PdVYKH87F+i71u2Yxq7AUC3/y29oGNEX+dRxz76EbWQqCyVSUgCj4rZjkfp0wmQ7U2Cfn0I9yZFyBvjRGhqrnICE8+1uYmS0aSyiekLlMkmYOFPSDmQ9d+WXsJ6suFwc+83CVtKZV5c/YgnkIpkUJpuHT8HHSyD7QU2F1utIG7J9d+wqEhuvzeXg5pxLMowxFUkWy3iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7458.namprd11.prod.outlook.com (2603:10b6:8:145::13)
 by CH3PR11MB7894.namprd11.prod.outlook.com (2603:10b6:610:12c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.20; Wed, 7 May
 2025 10:15:32 +0000
Received: from DS0PR11MB7458.namprd11.prod.outlook.com
 ([fe80::1a9e:53a6:9603:8f79]) by DS0PR11MB7458.namprd11.prod.outlook.com
 ([fe80::1a9e:53a6:9603:8f79%3]) with mapi id 15.20.8722.020; Wed, 7 May 2025
 10:15:32 +0000
From: "Ji, Kai" <kai.ji@intel.com>
To: "Nicolau, Radu" <radu.nicolau@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH] crypto/qat: disable ZUC 256 on selected devices
Thread-Topic: [PATCH] crypto/qat: disable ZUC 256 on selected devices
Thread-Index: AQHbtD2J75eHMkmvqke6HR8WTnEugbPHCVAV
Date: Wed, 7 May 2025 10:15:31 +0000
Message-ID: <DS0PR11MB745813B2785C6CE7517DA22B8188A@DS0PR11MB7458.namprd11.prod.outlook.com>
References: <20250423105007.3285717-1-radu.nicolau@intel.com>
In-Reply-To: <20250423105007.3285717-1-radu.nicolau@intel.com>
Accept-Language: en-GB, en-US, en-IE
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7458:EE_|CH3PR11MB7894:EE_
x-ms-office365-filtering-correlation-id: aadec1d3-2161-4f89-c181-08dd8d501967
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?L1oVnvRd9i+p7jUrDTTzRlllXgzAohMAi+J+oquug7EJLCiXMizS2MkZ9Pw+?=
 =?us-ascii?Q?udSUvKSUshwd5djdhqTWVtJS25u/37t/LjADibSYmGDo0SGBmAIevKtN4TS6?=
 =?us-ascii?Q?1hiawmN832h9ZDlremz1weIq6EM6BsHPETWZ0DOwUZCyHZeu7cS05HF65Qbx?=
 =?us-ascii?Q?AhaNdnKwsVHk7J06HMm5MlgFXyeZ9z3Zp/PMs7p+oh9qKXxIuTrviaK1Dmzs?=
 =?us-ascii?Q?eNzNeDFtd2IRQbZqEJCnvlsqozFEzIBeysRvrMXVM8Bgt3J9g7ZSxH6DbXad?=
 =?us-ascii?Q?3/OMuPMBts5CbR1UyVjFixG6zK0ymH9MIpKry19gVl6prgJLlW8ORdQ2fOgg?=
 =?us-ascii?Q?qfGrvMMGmAZIfSkbhJrl2kK/L54QRMPLsGg/4zQsqT+YllI11M26jfZL3KDy?=
 =?us-ascii?Q?/l+FeQ5+GjHil3tsC7O7O5IJ7SGJsbmejo+DVlkxWlBWXkfwD1tn8YMVRzjF?=
 =?us-ascii?Q?MkT+v2uqXhWKbznDKGuFeqdfSlqr1ML1ln57rYnEw3vHqfsmSYTRRj2l2Q3r?=
 =?us-ascii?Q?sEkOpeA2uNcVsMEyNi2B5OA4JO7AsZZoN0+d5BpG7nC8wYDoczJwQg8iR5JM?=
 =?us-ascii?Q?nEoawjTcySgC13ub8TM9/PQvqCH3kk1X5TICabT+HTVJXFw3ZTnxBKOLPXGH?=
 =?us-ascii?Q?V901a+PCzVDV53cmpbmkuBLiXAgESCXG0aKxVF7CaDqPcvk6e+17Y4kLaaPd?=
 =?us-ascii?Q?EZI/tD3jow8MuxWkCbbxm6COzPxO4ToJGHfMYrSe+/QhOgjqfdflTVXFNcPu?=
 =?us-ascii?Q?7bulSBkQGSpPCLfjTPdd02nTnlDZOW99rrSoJh2XoJLTbBY5hPwb786hP2U6?=
 =?us-ascii?Q?HPL5KH13VJ0fV7unNwWMiVvrBM42vOKZuh8YQcJ6gf4ETd8+COpm60WdNl1J?=
 =?us-ascii?Q?o8w/iIYVFlDULf1RVvdQrm2mmfd41zyCUFYl2++395looXC7vpCPY/jtuWgX?=
 =?us-ascii?Q?qckMjh9ZmOQdvG/cfXQwWysMwa+2cMbBRBx3Pj023ybb/cmjOFHtP/jJJD2n?=
 =?us-ascii?Q?e3568H58Bju49WY5bXEF2n7K6MCa4XP5pbCxrHX2RiGfBK2gujHrOjrJfHf+?=
 =?us-ascii?Q?9+FaN1ygU8MFGIoxWb302BJNdNK7ZYIwdnPMQRL2RMLOLQEv0kS7C1qGt18z?=
 =?us-ascii?Q?FgOsjUF8NqMJ+oyomV4mz4t3CF6LPB2YV4Du6gQm7uGyzJvZxqFoUbOIzkKd?=
 =?us-ascii?Q?IoFL4xyIVf3D9S77zvNA10/GnaC99n5BMsgGkU6dA7dFtBz6Ke4rWQAxiKAn?=
 =?us-ascii?Q?yvMYQnjhrVnTl+Ih/4Ed3zsqbjVnKR9fHeEHa4H0rtkFJY8owzAymCxpix3W?=
 =?us-ascii?Q?a6gMmMNMhumrBSZqN0B2+8BFyrEvODkLdzc58ZY0ErSkcnvQqY6ALGEvSfB8?=
 =?us-ascii?Q?nVd2hM8wG39R4CWxefXW5YcUVDKaxGW9BLhJkJ+1v9a8iI6RPICAWT97py6k?=
 =?us-ascii?Q?hICgOMMFybq4CIn3I8xmpXY0cJHGIP6ge2mSwJbCGltcsIWQzpIngw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7458.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(8096899003)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1ttFjHdkxLmkdVlz+t3bm+GFJkxJzsJqYTCJ8XdSy8+19w5AxbRxCvCuyc9Z?=
 =?us-ascii?Q?ocMNYuuawM2ltftveTGKHTnEcGbKkmHdeSXZCrIETsTHorBBE50buQCAsLSM?=
 =?us-ascii?Q?62FlZBqytZ0h9ikgbX4fj+OIrt7NDO5T1iqnYBaeMPoKu7Iy6i0wwOykJnU7?=
 =?us-ascii?Q?0pwQzivQIBOKx823EEZBZ5xmNr68mz++c5lZGFSSZQ7CImuGtQgr+T/Xh3Hd?=
 =?us-ascii?Q?/zs9wtzZ8bdvUcDffT3QdmnNa3pH4sJBvFFgZjh2nbi81Z5otLlEA9c0l3BJ?=
 =?us-ascii?Q?HanmDnFgUuT6B/txb9pIWT+4B0Nir4tgljIxfl6A9NAebFVwkvl9MSb9OU0p?=
 =?us-ascii?Q?AeJSvTACrJkdcerxGyBB0Tq6ubpDwEV5UhZLWn7V6skyIFiebcf8gc22J2K8?=
 =?us-ascii?Q?t3feSuR48gD0kQNrUDs3lZY3H4Ssrle6DrzGlwm2rndzJNBT5qW8ISEqNH2E?=
 =?us-ascii?Q?21gbN1StEhuqo5n4nb/vrTupKGBb3/SP7ESO6CKOjMDt9OjesP2dWM4+0En3?=
 =?us-ascii?Q?XPb/02g0v8R72S4NdGw0fsDpE32OE6DkSz0mX0YnmHHGc5IPjyfjk1PCLDPz?=
 =?us-ascii?Q?vAi7B9dHv8O2rIjk1JLu+SSXqmrjK1DKERPVhLjihD74Dvd2dOMpiOwGFELO?=
 =?us-ascii?Q?nUVFnMAQ+YlROektHYYfdzzHVxZqabVDjF868Gf8hJxbt7BHdg8qOql2OFaE?=
 =?us-ascii?Q?Iz9dhCTTnWpWevfPMWJFH36jdXQbw/2I5t0veQeJ+Ee6xeHZ9NSWjeeeMrSP?=
 =?us-ascii?Q?cbRP+YdHy1obdocoWCfBmzhwkpbtnBIjI1Ya1b/m8IMRnGu2uhgW8HbTga1I?=
 =?us-ascii?Q?5tY79u2xUNEbEgeYodfRr1bthiy5KdBkHQ7p6NhnElyfdUxWWSlaM6PKE6Qz?=
 =?us-ascii?Q?JYNn23bxYOjWHo7y07JUy33tzrCNcBMdI7SC54r+IB38ttKSfldSYsvBWI+G?=
 =?us-ascii?Q?Tg37wmZxT3cAH7lA8HnIUpZT15wJxqIaXc0ZkKFbSR831bq+dD8DwOptFm6Q?=
 =?us-ascii?Q?k+RSkXDVT8JJBAkJEP+G9NrRsqdxD58bFAliunQFQgJO9frFi5D5pm24P1+1?=
 =?us-ascii?Q?oOg+jSe9GuBPnLvA/rF9y+wbC3qynRYEbrHz//57YoYOQK5OxiWRWtokWSVH?=
 =?us-ascii?Q?G3cj7XPjV+5YL3mmTbrtGN5XL2m0u78MWTZDvm4z14lMg/ZdssumL3cZO7lM?=
 =?us-ascii?Q?sYr5LwnW7LKK5IUKaf2df3U8G9KdNJa6kHfXo/rJfcuKKP8lcxynqoB/aVjf?=
 =?us-ascii?Q?sK7ynQgLZMVJ3QQiygVksudwcTXtqbo2PNhNTtHJwQrT9pMsonAIWvsNdzkL?=
 =?us-ascii?Q?LHWRdPTCqJRLqkVsSzSGNtPKFIL7P/UBu/3pd6B0YE3/qmBS+IHz8rqZUXww?=
 =?us-ascii?Q?boFonHg8wWimfW4flLNm2B0DNcExd9Tr1cBlJLbuvGpLLZ8gA3z0snyRNAwu?=
 =?us-ascii?Q?bV4GlbqzUKqcFx06QyjuDGkxE1wc1aCGI/ck0s/jy3I6bfXeyJMNFtbUHIXy?=
 =?us-ascii?Q?aHJqNS6YHmwbSTYUN8KKMgHGbQHpZ/AT+ZztaECgdXiIokVsdtOpHTWSwQvs?=
 =?us-ascii?Q?/T09F71u0rJqwcmicss=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DS0PR11MB745813B2785C6CE7517DA22B8188ADS0PR11MB7458namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7458.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aadec1d3-2161-4f89-c181-08dd8d501967
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2025 10:15:31.9470 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2qFXCu9RzZ8x/0UJRFs4CyrtvdX73t4qSXL3IrF9Eh6OumdcbpXtXoI0Hq36NHP8Fro1HwiO5sJ66FtcZ1Mnuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7894
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

--_000_DS0PR11MB745813B2785C6CE7517DA22B8188ADS0PR11MB7458namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Acked-by: Kai Ji <kai.ji@intel.com>

________________________________
From: Nicolau, Radu <radu.nicolau@intel.com>
Sent: 23 April 2025 11:50
To: Ji, Kai <kai.ji@intel.com>
Cc: dev@dpdk.org <dev@dpdk.org>; Nicolau, Radu <radu.nicolau@intel.com>
Subject: [PATCH] crypto/qat: disable ZUC 256 on selected devices

Disable ZUC 256 cipher on selected devices.

Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
---
 drivers/common/qat/qat_common.h              | 2 ++
 drivers/common/qat/qat_device.c              | 9 +++++++++
 drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c | 5 ++++-
 drivers/crypto/qat/dev/qat_crypto_pmd_gen5.c | 9 +++++++++
 drivers/crypto/qat/qat_sym_session.c         | 6 ++++++
 5 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/common/qat/qat_common.h b/drivers/common/qat/qat_commo=
n.h
index 51d20267bd..8476021e01 100644
--- a/drivers/common/qat/qat_common.h
+++ b/drivers/common/qat/qat_common.h
@@ -26,6 +26,8 @@ struct qat_options {
         /**< Wireless Slices supported */
         uint8_t legacy_alg;
         /**< are legacy algorithm supported */
+       uint8_t zuc_256_disabled;
+       /**< is ZUC 256 algorithm disabled */
 };

 enum qat_device_gen {
diff --git a/drivers/common/qat/qat_device.c b/drivers/common/qat/qat_devic=
e.c
index b582e3bf8b..35c664e529 100644
--- a/drivers/common/qat/qat_device.c
+++ b/drivers/common/qat/qat_device.c
@@ -169,6 +169,13 @@ wireless_slice_support(uint16_t pci_dev_id)
                         pci_dev_id =3D=3D 0x4947;
 }

+static int
+zuc_256_disabled(uint16_t pci_dev_id)
+{
+       return pci_dev_id =3D=3D 0x578b ||
+                       pci_dev_id =3D=3D 0x4947;
+}
+
 /* This function base on the atoi function peculiarity, non integral part
  * other than the equals sign is ignored. It will not work with other conv=
ersion
  * functions like strt*.
@@ -332,6 +339,8 @@ qat_pci_device_allocate(struct rte_pci_device *pci_dev)

         if (wireless_slice_support(pci_dev->id.device_id))
                 qat_dev->options.has_wireless_slice =3D 1;
+       if (zuc_256_disabled(pci_dev->id.device_id))
+               qat_dev->options.zuc_256_disabled =3D 1;

         ops_hw =3D qat_dev_hw_spec[qat_dev->qat_dev_gen];
         NOT_NULL(ops_hw->qat_dev_get_misc_bar, goto error,
diff --git a/drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c b/drivers/crypto/=
qat/dev/qat_crypto_pmd_gen3.c
index af664fb9b9..11541ee51d 100644
--- a/drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c
+++ b/drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c
@@ -295,7 +295,10 @@ qat_sym_crypto_cap_get_gen3(struct qat_cryptodev_priva=
te *internals,
                         check_cipher_capa(&capabilities[iter],
                                 RTE_CRYPTO_CIPHER_ZUC_EEA3))) {
                         cap =3D addr + curr_capa;
-                       cap->sym.cipher.key_size.max =3D 32;
+                       if (internals->qat_dev->options.zuc_256_disabled)
+                               cap->sym.cipher.key_size.max =3D 16;
+                       else
+                               cap->sym.cipher.key_size.max =3D 32;
                         cap->sym.cipher.key_size.increment =3D 16;
                         cap->sym.cipher.iv_size.max =3D 25;
                         cap->sym.cipher.iv_size.increment =3D 1;
diff --git a/drivers/crypto/qat/dev/qat_crypto_pmd_gen5.c b/drivers/crypto/=
qat/dev/qat_crypto_pmd_gen5.c
index e1302e9b36..70ede22042 100644
--- a/drivers/crypto/qat/dev/qat_crypto_pmd_gen5.c
+++ b/drivers/crypto/qat/dev/qat_crypto_pmd_gen5.c
@@ -205,6 +205,15 @@ qat_sym_crypto_cap_get_gen5(struct qat_cryptodev_priva=
te *internals,

                 memcpy(addr + curr_capa, capabilities + iter,
                         sizeof(struct rte_cryptodev_capabilities));
+
+               if (check_cipher_capa(&capabilities[iter],
+                               RTE_CRYPTO_CIPHER_ZUC_EEA3)) {
+                       struct rte_cryptodev_capabilities *cap =3D
+                               addr + curr_capa;
+                       if (internals->qat_dev->options.zuc_256_disabled)
+                               cap->sym.cipher.key_size.max =3D 16;
+               }
+
                 curr_capa++;
         }
         internals->qat_dev_capabilities =3D internals->capa_mz->addr;
diff --git a/drivers/crypto/qat/qat_sym_session.c b/drivers/crypto/qat/qat_=
sym_session.c
index 7f370f03fb..2481ed7ce5 100644
--- a/drivers/crypto/qat/qat_sym_session.c
+++ b/drivers/crypto/qat/qat_sym_session.c
@@ -526,6 +526,12 @@ qat_sym_session_configure_cipher(struct rte_cryptodev =
*dev,
                 session->qat_mode =3D ICP_QAT_HW_CIPHER_CBC_MODE;
                 break;
         case RTE_CRYPTO_CIPHER_ZUC_EEA3:
+               if (internals->qat_dev->options.zuc_256_disabled &&
+                       cipher_xform->key.length =3D=3D ICP_QAT_HW_ZUC_256_=
KEY_SZ) {
+                       QAT_LOG(ERR, "ZUC 256 disabled on this device");
+                       ret =3D -ENOTSUP;
+                       goto error_out;
+               }
                 if (!qat_is_cipher_alg_supported(
                         cipher_xform->algo, internals)) {
                         QAT_LOG(ERR, "%s not supported on this device",
--
2.43.0


--_000_DS0PR11MB745813B2785C6CE7517DA22B8188ADS0PR11MB7458namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: &quot;IntelOne Text&quo=
t;; font-size: 10pt; color: rgb(0, 0, 0);">
Acked-by: Kai Ji &lt;kai.ji@intel.com&gt;</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;IntelOne Text&quo=
t;; font-size: 10pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Nicolau, Radu &lt;rad=
u.nicolau@intel.com&gt;<br>
<b>Sent:</b> 23 April 2025 11:50<br>
<b>To:</b> Ji, Kai &lt;kai.ji@intel.com&gt;<br>
<b>Cc:</b> dev@dpdk.org &lt;dev@dpdk.org&gt;; Nicolau, Radu &lt;radu.nicola=
u@intel.com&gt;<br>
<b>Subject:</b> [PATCH] crypto/qat: disable ZUC 256 on selected devices</fo=
nt>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Disable ZUC 256 cipher on selected devices.<br>
<br>
Signed-off-by: Radu Nicolau &lt;radu.nicolau@intel.com&gt;<br>
---<br>
&nbsp;drivers/common/qat/qat_common.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 2 ++<br>
&nbsp;drivers/common/qat/qat_device.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 9 +++++++++<br>
&nbsp;drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c | 5 ++++-<br>
&nbsp;drivers/crypto/qat/dev/qat_crypto_pmd_gen5.c | 9 +++++++++<br>
&nbsp;drivers/crypto/qat/qat_sym_session.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; | 6 ++++++<br>
&nbsp;5 files changed, 30 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/common/qat/qat_common.h b/drivers/common/qat/qat_commo=
n.h<br>
index 51d20267bd..8476021e01 100644<br>
--- a/drivers/common/qat/qat_common.h<br>
+++ b/drivers/common/qat/qat_common.h<br>
@@ -26,6 +26,8 @@ struct qat_options {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /**&lt; Wireless Slices su=
pported */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t legacy_alg;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /**&lt; are legacy algorit=
hm supported */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t zuc_256_disabled;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /**&lt; is ZUC 256 algorithm disabled=
 */<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;enum qat_device_gen {<br>
diff --git a/drivers/common/qat/qat_device.c b/drivers/common/qat/qat_devic=
e.c<br>
index b582e3bf8b..35c664e529 100644<br>
--- a/drivers/common/qat/qat_device.c<br>
+++ b/drivers/common/qat/qat_device.c<br>
@@ -169,6 +169,13 @@ wireless_slice_support(uint16_t pci_dev_id)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_d=
ev_id =3D=3D 0x4947;<br>
&nbsp;}<br>
&nbsp;<br>
+static int<br>
+zuc_256_disabled(uint16_t pci_dev_id)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return pci_dev_id =3D=3D 0x578b ||<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_dev_id =3D=
=3D 0x4947;<br>
+}<br>
+<br>
&nbsp;/* This function base on the atoi function peculiarity, non integral =
part<br>
&nbsp; * other than the equals sign is ignored. It will not work with other=
 conversion<br>
&nbsp; * functions like strt*.<br>
@@ -332,6 +339,8 @@ qat_pci_device_allocate(struct rte_pci_device *pci_dev)=
<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (wireless_slice_support=
(pci_dev-&gt;id.device_id))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; qat_dev-&gt;options.has_wireless_slice =3D 1;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (zuc_256_disabled(pci_dev-&gt;id.d=
evice_id))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; qat_dev-&gt;options.zuc_256_disabled =3D 1;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ops_hw =3D qat_dev_hw_spec=
[qat_dev-&gt;qat_dev_gen];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NOT_NULL(ops_hw-&gt;qat_de=
v_get_misc_bar, goto error,<br>
diff --git a/drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c b/drivers/crypto/=
qat/dev/qat_crypto_pmd_gen3.c<br>
index af664fb9b9..11541ee51d 100644<br>
--- a/drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c<br>
+++ b/drivers/crypto/qat/dev/qat_crypto_pmd_gen3.c<br>
@@ -295,7 +295,10 @@ qat_sym_crypto_cap_get_gen3(struct qat_cryptodev_priva=
te *internals,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; check=
_cipher_capa(&amp;capabilities[iter],<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_CRYPTO_CIPHER_ZUC_EEA3))) {<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cap =
=3D addr + curr_capa;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cap-&gt;sym.ciph=
er.key_size.max =3D 32;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (internals-&g=
t;qat_dev-&gt;options.zuc_256_disabled)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cap-&gt;sym.cipher.key_size.max =3D 16;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cap-&gt;sym.cipher.key_size.max =3D 32;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cap-&=
gt;sym.cipher.key_size.increment =3D 16;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cap-&=
gt;sym.cipher.iv_size.max =3D 25;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cap-&=
gt;sym.cipher.iv_size.increment =3D 1;<br>
diff --git a/drivers/crypto/qat/dev/qat_crypto_pmd_gen5.c b/drivers/crypto/=
qat/dev/qat_crypto_pmd_gen5.c<br>
index e1302e9b36..70ede22042 100644<br>
--- a/drivers/crypto/qat/dev/qat_crypto_pmd_gen5.c<br>
+++ b/drivers/crypto/qat/dev/qat_crypto_pmd_gen5.c<br>
@@ -205,6 +205,15 @@ qat_sym_crypto_cap_get_gen5(struct qat_cryptodev_priva=
te *internals,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; memcpy(addr + curr_capa, capabilities + iter,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeo=
f(struct rte_cryptodev_capabilities));<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (check_cipher_capa(&amp;capabilities[iter],<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTE_CRYPTO_CIPHER_ZUC_EEA3)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_crypt=
odev_capabilities *cap =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addr + curr_capa;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (internals-&g=
t;qat_dev-&gt;options.zuc_256_disabled)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cap-&gt;sym.cipher.key_size.max =3D 16;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; curr_capa++;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; internals-&gt;qat_dev_capa=
bilities =3D internals-&gt;capa_mz-&gt;addr;<br>
diff --git a/drivers/crypto/qat/qat_sym_session.c b/drivers/crypto/qat/qat_=
sym_session.c<br>
index 7f370f03fb..2481ed7ce5 100644<br>
--- a/drivers/crypto/qat/qat_sym_session.c<br>
+++ b/drivers/crypto/qat/qat_sym_session.c<br>
@@ -526,6 +526,12 @@ qat_sym_session_configure_cipher(struct rte_cryptodev =
*dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; session-&gt;qat_mode =3D ICP_QAT_HW_CIPHER_CBC_MODE;<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case RTE_CRYPTO_CIPHER_ZUC=
_EEA3:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (internals-&gt;qat_dev-&gt;options.zuc_256_disabled &amp;&amp=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cipher_xform-&gt=
;key.length =3D=3D ICP_QAT_HW_ZUC_256_KEY_SZ) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; QAT_LOG(ERR, &qu=
ot;ZUC 256 disabled on this device&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D -ENOTSUP=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error_out;<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!qat_is_cipher_alg_supported(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ciphe=
r_xform-&gt;algo, internals)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; QAT_L=
OG(ERR, &quot;%s not supported on this device&quot;,<br>
-- <br>
2.43.0<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_DS0PR11MB745813B2785C6CE7517DA22B8188ADS0PR11MB7458namp_--
