Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3610FCD5BAA
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 17:20:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3DC394042F;
	Wed, 20 May 2026 19:20:36 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id B1CB9400EF
 for <dev@dpdk.org>; Wed, 20 May 2026 19:20:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779297635; x=1810833635;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=+Y3OkkI5JICoTzfh6FrlUGJU6i250ZPENEuuEyKzPCA=;
 b=VGu50XfzwFjPE1Y6E/PxjecwpEZzM5jT3oSRjwL6eAeRc2/f6roRh1Vv
 3HkXwwon2cQQh6mHWxDqczSbPjr31/EByE0fT2Gsqng1sJ3yTSQHdTp4L
 4TSMm1vHd4nqUUC/zF5adMJ89rZoE39U0GUUpIMoz4oqKwBndLR3qhq/V
 /QYXlVA1UkzCNiuam2dyCKTI+/mqPtBspCofEtjJo0hlkhcQ5SWgK6Xdh
 W0T1ddZtJP9wMrh/9fnkLskzfVPWwm9UOg5OXsxCWv8JsdsRft5ZN2iW+
 BqDleSm1ztCO/skBoKZCW175zn+HHNeTA8QYLL0gv4ilahEns/O/bcKDC Q==;
X-CSE-ConnectionGUID: fs4vruQvSiSrdAp0wkQgsA==
X-CSE-MsgGUID: DPdPPlDARUizxrRcaCjP5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="80171401"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="80171401"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 10:20:34 -0700
X-CSE-ConnectionGUID: uWyAaUA3SxumIbbvVRazHg==
X-CSE-MsgGUID: tHgFoh4ESKmy+AcpL/8m7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="242060373"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 10:20:33 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 10:20:32 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 20 May 2026 10:20:32 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.62) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 10:20:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QrRRso6tDFr456xwc6aea20KKaijOtiwSJXWYiDZz1Z/g7B6zAV2h7OOuXxjxkdWu5E85vv25/sadgBA9i2fWI+mFWzEfccnrzYbWwc7tnZAD9+pgLy3PJ3OZnbSYqE4l0fgiOli2gpeS1SpX7WdUzGbNLqESAARdjtCSI/0xjEEe88RudjfZt/s7g2dXT9DXYTUs32MjF4LwtJdf5xrd2kSLGMCkGKLuYn4xCfou1vUqbod2lfdqm+J00Kd/osh/nkMjHLYmBBy3vGjO2V47r+hRsNPkxzCmScTF9SzaQkoBkTdEKa/zuAOkGMEAe8PFuCV0qQJZ6EuMFfrMtk1Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rG5mahzqjU2JuK1fvvO7ljHo1zH879cLpixY0NJoHFI=;
 b=YTFS4dVjYKlcNUkU8du9BxN1ZMEZKf6G5Nmqt8zmv1numlFXmJX0na9WU+87yhgVDcsXW9h7/ouppAcedHVoD3E2/WCfUAqbTAHh4LaP0eRRFXATfykHBvUzfny20TMfB47kTU9OyOu6/mG2wgQa0TJM59A2D1fMoGFmgdSRC+bMnrI8TJm4JHrRjgH/tmJ6W1oZbWnwru1kEAb34IwHYJWCn9ZnP++xlVaHIqmkesFnfk4Sim0QvXMmxp/F9BTxP2NWEPy8afEY+8SyOLzZM1/QqmYmoWRvhe9mfacE6FEpF1uKLLH5SW4517LQS43CVdgqhL6wWUrCYvj28ddmjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by SAWPR11MB9783.namprd11.prod.outlook.com (2603:10b6:806:4c9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Wed, 20 May
 2026 17:20:31 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%5]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 17:20:30 +0000
Date: Wed, 20 May 2026 18:20:25 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <stephen@networkplumber.org>,
 "Kevin Laatz" <kevin.laatz@intel.com>
Subject: Re: [PATCH v2 19/23] dma/idxd: remove specific bus type
Message-ID: <ag3tWZn0f4jIfVWo@bricha3-mobl1.ger.corp.intel.com>
References: <20260429114503.932575-1-david.marchand@redhat.com>
 <20260506155201.2709810-1-david.marchand@redhat.com>
 <20260506155201.2709810-20-david.marchand@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260506155201.2709810-20-david.marchand@redhat.com>
X-ClientProxiedBy: DU6P191CA0038.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53f::22) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|SAWPR11MB9783:EE_
X-MS-Office365-Filtering-Correlation-Id: 838275fe-144a-4862-77d4-08deb69417d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|3023799007|56012099003|22082099003|18002099003|4143699003|11063799006|5023799004|6133799003;
X-Microsoft-Antispam-Message-Info: QzjyyzS+6iOTEhLKOWXI3MqwgaYBkxxaql1YaRQvobTmTwfnY7JABsXo+WICaIV5//mwWmW2QWjrAhdfn5bJpRk+/GuzYTDiK5LJBbfvDh7B0eaeaQI4/dWO+9gXINu3CLn2nBbEx11mTVrqaW9iehGaN09H1njMaZkAEJ44Gs8eynsG8PVljojDfw4do5I+NWy/z0fjoV1NDbpCE8sorQJFRlEeezRd6fEHjkQQp5Fj1Vz7LA3jGLz+xuv4gjSTP1ZUGiA3970lWD+3ybvqkxzK8O3sb4rxz8c0bMLjy7uP2YFFilfKnoZWLQL69wAdjyILaYJ5lUzBWbCibYvSrH20ZoqzsYCAYt7sR/u9LJmaKCsaSRMq1VJVvwdCw471OpC+v7l2C82cin8xv1bca9n+PDwryVrYXzH+JbFfBXeVDg/5s4iWlpTDD+I9BvIA7JYAtKuixGAs+dsf/9sqon5VVCeEOXlZoP7N1Rf9y12AkEKuusHoV0p98YlqCVTf8xsNu1osu83z/A80/BAL8pDTxbnWGI43PdU3DSfFEz+8X7Nz87gYNcyIS4O1ZtZ/K++q50t6I4Y6w3U5oK5dJsRyR5xBnfcZklyBkmr/fvKltI1s9E1o3AmqDM0GYKQjyC8r9t29JLC9XwSIDbMW3lKyVJ3LvoMq7rAI0WqGZt+ibDKcXkusr+nMu6TZHoZ1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(3023799007)(56012099003)(22082099003)(18002099003)(4143699003)(11063799006)(5023799004)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vbvS5tlEjz6zgGhnAYJYh8xhKUQsS9gfOxBpspPpp0oaNe3TvhafkVQzy48c?=
 =?us-ascii?Q?wddKp7+fC1/C/psUe96TUFKMs6LPMnyvxmJUsX1d5Jlfh3xOLdFWRjlHYxCT?=
 =?us-ascii?Q?YzeF7oXVWM/BYtHOdoUcVvZWkrkQ9lRlLVEb5xgGrz17RsDatVy7VDQBpuVg?=
 =?us-ascii?Q?xfbDZM/70kzNAftoJkrORp6Nhefh/Gq68AiV09t9CxHduyVDEoySzhrENLzr?=
 =?us-ascii?Q?4HZELOwaHvxl23NwFIrWH5CIjAqsKGGsxEyhyVLSin0lMDPKXrqeqNAfk0k5?=
 =?us-ascii?Q?UZSS3aWlYYGaLIIysT/e1oU7axNO0auRLDM0K3kInnkh8tW1wpCGfAIG3mqg?=
 =?us-ascii?Q?2WzHVBGidu/eMmD+XhySlbP/u85H8JhAUt1Zhd0VZ0yQtM1awgnGLHRnV6hp?=
 =?us-ascii?Q?S64FrfZeM2QJPwyRYgDB4/cMEBO2h3OaYhQ+dPNVWFky18r089E+FPkR00tS?=
 =?us-ascii?Q?Bkg5sqQm2/Tyq/LF/yszv8TfjrPCZnbej2yM6W+2Eb+gRrOajn528TrAXFfx?=
 =?us-ascii?Q?Gcp1ReX/BaKzUTo+vvsJGPoroWvRiVoeaKphhx8Pkm392KwueQwEiIPYYd20?=
 =?us-ascii?Q?1poWahg392UswWn2i8LB+BQoVV6OFsxufhd5SgAQyAUBC/+oUUx7Ki5n55O4?=
 =?us-ascii?Q?n0bJuHlZ+TOK4trjL9CCROYHIffhdsZw2WfAn/BzMULyF/P7yR+s3egp57Qq?=
 =?us-ascii?Q?A2YsLweqrcAtrgzNGBskXSY6aygnNbPj75KgVC1xSso7kx+ADkgwQ5ZfdlP0?=
 =?us-ascii?Q?PZmZIj8XJsUoa0IxHqoyFRpO5OTwxKhRtg9cBs7nAwqHi9I4VckpdkeDCAEU?=
 =?us-ascii?Q?6UrGJWJQuq4SwnBnYtzFid9k87L5FJCrhpb7r5liGn63CGzt0+We3jH0EsI0?=
 =?us-ascii?Q?pgGDNjBo3zG647lMEl38EFruFuU+iIQG8N7grgWJzwzsvftmskOfROPJoEKN?=
 =?us-ascii?Q?+PZPogK5St6Q9N971Xwjwet4u+Fv/j04JzUab2mKd626YpVV++H7QPI0XSZt?=
 =?us-ascii?Q?IbPOMUjBwaKXzcHf3lwU4Fh5SLQptHbRoa7W33DqbyYgHt+KzNsIKpNbE89w?=
 =?us-ascii?Q?4GCACFfpOo1b8MkgCZ8N1Zj5xFRjkk93oHmKVgL1vgVV4MqD3t4KeHhmsHGp?=
 =?us-ascii?Q?aYaVb7KrB1tV0uQ8q1h0FQUfEeRNnlkRn0rwZdRbQDqpTYNqWRlvUnj3xkiM?=
 =?us-ascii?Q?g7aOcGeg+fMKDGwDvmDy2RiA7w10LoLTedze6sOBPLEF0HL9GiN5vu/QGGk2?=
 =?us-ascii?Q?D3mhoqkYgKxmdCDvemYpbYHwJ2/b8YVFYE8w2DGOkgUjJyvGy8TTobz3XBME?=
 =?us-ascii?Q?IfOxpgBnekgr/LSbWMeCzPWzLIOtquHN51+l1VYcktbH4UNjZB/YncopZAG8?=
 =?us-ascii?Q?YrbxUWDNTlntVYrmiRmrM4F90/1/k/3suAJTiF4y1wxwk5DP31teHvvwuZBg?=
 =?us-ascii?Q?SW3FwwEeAg1TxPI/eO+YdsGHPzKqU44vPO4pI3ymUmMaYhtukEAeWlF73FGl?=
 =?us-ascii?Q?ijKIjKq1Af5Ha7f8iWJs4Ou5mXv48wAKu365bmLZsIJd44wjwsreEoj/UO/S?=
 =?us-ascii?Q?BDuI6cDSw2zcnOE4Fu8drRSrjrPuxmwMsDh9nbS0pTyFh023k06dpiZ7n5o3?=
 =?us-ascii?Q?k7GPQZM88nTDLAVi5Gwe6CZKrs0Sb+rKupSj/dbMrQGlafEg1Awr52SQzhEc?=
 =?us-ascii?Q?Pr60ypFYCesrwdp4LKIpN/6C1MUO7fH/mWMkUw+07RY3j0kwYe6wDEzgf1FJ?=
 =?us-ascii?Q?8FBUKW4UuoOd+AHTDrikpWhAKPvcUMk=3D?=
X-Exchange-RoutingPolicyChecked: kGOvGRBBcrZxA8YdyGlGfMma2/8rEmb04wadRSyCsJQ8aAYlLBdXFJwTtrZ238F1/mBmVGedKUD7Tk5ajSerSe7Vvbv0dnGE37DysAWeRVR2w+JOArUF35bM/nggCRJh9yKCI1oNpyOil4080VVofO7K6fv7F0h6xH5ZyiDuH9B9hPTubYsQMNqSrCXuEILEz27gah5uIH4sklIh9ELI13JTyJ9uyN6usbv4Af85LS98e9JieM9kUJiTsj0RyYlE77RrmwGHKn9jqi++21mMplxUqxTAM4l0vgUudmueljdcQP3XBo845xJhajEOtjm9zz/E/VvmNsxusWoAk6vGzw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 838275fe-144a-4862-77d4-08deb69417d5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 17:20:30.7883 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ypZFeTeGqHn9gRuhXyd6ZTL8rDqjTCvUr5p9zGWxA1E9+qDrnYCOokBNsLJH0LMCG63/gQUp+Z1AYP0EDeX0V1u2mhZjbcvGQQfPkPxFSFI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR11MB9783
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

On Wed, May 06, 2026 at 05:51:51PM +0200, David Marchand wrote:
> There is nothing that requires a specific bus type.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>

This patch exposes an underlying issue with the DSA driver. When applied,
attempting to probe the workqueues gives the output:

"EAL: Device wq0.0 is already probed"

For each device. This is because the device is not zeroed in the scan
function, leaving a non-NULL driver pointer. See inline below.

/Bruce

> ---
>  drivers/dma/idxd/idxd_bus.c | 38 ++++++++++++++-----------------------
>  1 file changed, 14 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/dma/idxd/idxd_bus.c b/drivers/dma/idxd/idxd_bus.c
> index 93bde69ff9..daf5f48ac1 100644
> --- a/drivers/dma/idxd/idxd_bus.c
> +++ b/drivers/dma/idxd/idxd_bus.c
> @@ -41,34 +41,24 @@ struct rte_dsa_device {
>  };
>  
>  /* forward prototypes */
> -struct dsa_bus;
>  static int dsa_scan(void);
>  static bool dsa_match(const struct rte_driver *drv, const struct rte_device *dev);
>  static int dsa_probe_device(struct rte_driver *drv, struct rte_device *dev);
>  static enum rte_iova_mode dsa_get_iommu_class(void);
>  static int dsa_addr_parse(const char *name, void *addr);
>  
> -/**
> - * Structure describing the DSA bus
> - */
> -struct dsa_bus {
> -	struct rte_bus bus;               /**< Inherit the generic class */
> -	struct rte_driver driver;         /**< Driver struct for devices to point to */
> +struct rte_bus dsa_bus = {
> +	.scan = dsa_scan,
> +	.probe = rte_bus_generic_probe,
> +	.match = dsa_match,
> +	.probe_device = dsa_probe_device,
> +	.find_device = rte_bus_generic_find_device,
> +	.get_iommu_class = dsa_get_iommu_class,
> +	.parse = dsa_addr_parse,
>  };
>  
> -struct dsa_bus dsa_bus = {
> -	.bus = {
> -		.scan = dsa_scan,
> -		.probe = rte_bus_generic_probe,
> -		.match = dsa_match,
> -		.probe_device = dsa_probe_device,
> -		.find_device = rte_bus_generic_find_device,
> -		.get_iommu_class = dsa_get_iommu_class,
> -		.parse = dsa_addr_parse,
> -	},
> -	.driver = {
> -		.name = "dmadev_idxd",
> -	},
> +struct rte_driver dsa_driver = {
> +	.name = "dmadev_idxd",
>  };
>  
>  static inline const char *
> @@ -267,7 +257,7 @@ static bool dsa_match(const struct rte_driver *drv, const struct rte_device *dev
>  {
>  	const struct rte_dsa_device *dsa_dev = RTE_BUS_DEVICE(dev, *dsa_dev);
>  
> -	if (drv == &dsa_bus.driver) {
> +	if (drv == &dsa_driver) {
>  		char type[64], name[64];
>  
>  		if (read_wq_string(dsa_dev, "type", type, sizeof(type)) >= 0 &&
> @@ -319,7 +309,7 @@ dsa_scan(void)
>  			continue;
>  		}
>  		strlcpy(dev->wq_name, wq->d_name, sizeof(dev->wq_name));
> -		rte_bus_add_device(&dsa_bus.bus, &dev->device);
> +		rte_bus_add_device(&dsa_bus, &dev->device);

The issue with the driver is here. Before the strlcpy, and the previous
dsa_addr_parse() call, we just need to add:

		memset(dev, 0, sizeof(*dev));

Since malloc does not zero the memory. [Alternatively, we can change malloc
to a zeroing equivalent].

Do you want me to do a separate patch to fix this, or roll the fix change
into this patch?

>  		devcount++;
>  
>  		read_device_int(dev, "numa_node", &numa_node);
> @@ -357,8 +347,8 @@ dsa_addr_parse(const char *name, void *addr)
>  	return 0;
>  }
>  
> -RTE_REGISTER_BUS(dsa, dsa_bus.bus);
> +RTE_REGISTER_BUS(dsa, dsa_bus);
>  RTE_INIT(dsa_bus_init)
>  {
> -	rte_bus_add_driver(&dsa_bus.bus, &dsa_bus.driver);
> +	rte_bus_add_driver(&dsa_bus, &dsa_driver);
>  }
> -- 
> 2.53.0
> 
