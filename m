Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C720F8A16F
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Apr 2026 13:04:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3415940297;
	Thu, 16 Apr 2026 15:04:27 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id E0DDC40144
 for <dev@dpdk.org>; Thu, 16 Apr 2026 15:04:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776344665; x=1807880665;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Ih2BSnL08/TdB1OaRl0LtoxHe8N+3k7Yq4IlRGiVGTU=;
 b=gvvmSXRqGQ68Mx6P0ex/F2SegE3bg+t1FRMjrSIkA484Lk3G+qn5+7f/
 psbNfC4zk5r2COexAaYifX91lXbyjt0Y/QD75XYArCQpfnzVgdi/tx7lV
 mJcPksOmht3Ad1UqdoPXVeFw/wIutFPGNt7hcKQ0xhhkFyWUTspuhLD4M
 DvDoKvZp1J9v1LJqpA/XRHvzSmRrJJBGb4PgKtxP8JDjKRJCojU0yCaQI
 0gznm3d/3Nhwk6tfDws4t6ykhy7D9q6djun9pKV87HjddBMi2HiiriPbv
 FbzYydDSpVD6NE8F5qBFusHnsRPQttoYNIvi3DXc/1kXEcZi4I8ULrWHU g==;
X-CSE-ConnectionGUID: 4vDcWAj0TbSsfHrMttC2OA==
X-CSE-MsgGUID: hXw3e6R1RoOFw1j1WzKFgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="64880759"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; d="scan'208";a="64880759"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2026 06:04:24 -0700
X-CSE-ConnectionGUID: VQKXfnnhTxmIDXtzQaBoJA==
X-CSE-MsgGUID: OFnB2KKSTiu0G1rxFYeBEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; d="scan'208";a="230655340"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2026 06:04:24 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 16 Apr 2026 06:04:22 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 16 Apr 2026 06:04:22 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.10) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 16 Apr 2026 06:04:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U4vx6OpeFG8oUrP1ljb49xedJyCFH/NSsnKavHb9UeDq3WzV96r0L3UFobfUJE5wXsS75Iypz6H9JY8Fh/vW3P+PHeUULN/xQW7dvvTPgGcQwM4Tk5HcJ/fiFRuL6/wOkq4kzjGm3fR5JmSchi9DURLShN4vWiZiWrQtVl3JXPAt8R20B+U5xHh6/Qe9qXSE31cWqEQG2kt1SlbKpsKvhscXyADHh0f0znKjtpctptc7OJWQCwXMluWuq36gR9z7sLmZUpiFsbj4JOk9qAYefQdrDrSIxiy3mg0Eq2UVFg+K/l2piWgpLbShHpGwlgnId4eakVQxCMIBvOE6o2uYYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1BADi4C3ElXp9oq0c/ff2DqUKhGzqWZhyVPvySxBQKE=;
 b=bGImKNEmeoMEFwLnjhcEZc5EMAombfyeJZ4a21YFIzUTHIZe5cBqbkmDJo0YEtqEDbOXrIXC+XJpj+4VmxGQ5DtdkLluGPhYffHSIvTrVjL6AX7ktkGRoUEbMqpIKIcDmtes2jmHO8iECftAdg6N6CUPyDcQX0iaehkppZAT8C+8Ex4dwBPs8OJSUYsjNHxqPUySDUwFsedl6uPPMZSTvifnZO1g0zEVToEA2o/VnN76L52Bcd9XnQemju772zLAHl0j0tAag4NuHjY4YyG/Hs5yX6rKetv59/Gx6qKsy8BpViu980lQMk6xk7V8ezPyGYKWO7XFv1f6+Imxvu9lUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CH3PR11MB7299.namprd11.prod.outlook.com (2603:10b6:610:14b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Thu, 16 Apr
 2026 13:04:14 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::2a1:33a9:9f92:b52e%3]) with mapi id 15.20.9818.023; Thu, 16 Apr 2026
 13:04:14 +0000
Date: Thu, 16 Apr 2026 14:04:09 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Jay Wang <jay.wang2@arm.com>
CC: Thomas Monjalon <thomas@monjalon.net>, Anatoly Burakov
 <anatoly.burakov@intel.com>, <dev@dpdk.org>, <nd@arm.com>, Andrew Bailey
 <abailey@iol.unh.edu>
Subject: Re: [PATCH v5] net/ice: add NEON-optimised Rx/Tx vector paths
Message-ID: <aeDeSWNVjk4LbGwi@bricha3-mobl1.ger.corp.intel.com>
References: <20260409164133.1692748-2-jay.wang2@arm.com>
 <20260415145256.2293455-1-jay.wang2@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260415145256.2293455-1-jay.wang2@arm.com>
X-ClientProxiedBy: DB9PR02CA0001.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::6) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CH3PR11MB7299:EE_
X-MS-Office365-Filtering-Correlation-Id: 50f37f99-2fde-4993-4c7a-08de9bb8a8ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: 5Wr/d9VlSOZIaMvHy5D2Av01xVmpda/0RT8Wa7HWsLr2ihTycCQBvnED+QVdpHS962NSSXaj363Tp0GuUbTbgRwBMlae6i5Stv8F7exG/QloO6SZgOvMSWQJG8PbkxyrKmARFOTyatPJ3sjmRklXJvLakjN5Jh4nVKujSj78ZGj6HiUNLiHWrPIO/kSOmb42K5DRJMWtKs5BnHhr9hYPCy56tBNhFCY9DzeKInEz6uW17HxCKu/V+uKnFGoUe/lNXj03Yj5pe7UW0rt/H9FvE9j7vbiOLl+dGq08EcpSAr72bUmHoT1Txr64xgFraOLgcg3YsROVZ1cc0KOXblGQ90sTC/2LNdINRY0RlTiBUIKqEZwxEwRSDYlooFJzueOH7+7eMaQlFcHYLjkUPJZgpM86nRA/Vu07mJmfC8OyxaslixTNv6PZoS+ytMON/2m7KpoMpjhk3Ri7dZZ4jJSzqhvpDWFznaYaT8YTMFUOF1t2yJIsVrathVBjSCVxbI9WbRloMHD4tSCxAnVBZZcKuaKidjbe/NfbmYODHRGlYriTEvTRPfSwkETkxXUlROK66PxgWL5cXaM9iV/T+YzcO32QCVis3eGq7upMbGhEx/3DvcjyZlbYz4VXCR/6ZqGuwqM2QNF1NMLpXsvo4YQlVRfEyKQ6OB5Wie1Zlc70E+pGO2Z1gvWHGWjVcSa5sfSU7KzxQu2TKiwn7yInhvqDuJ4u7Q/YNd2q3gFrNyvVRbE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FjK40pe2qRolw3NIuTnOl7en2WrU+39XAZNs+xHATRLcdvbVrQoVy2khmU3V?=
 =?us-ascii?Q?ZM2p6y4Yqnjbm/dNBVDD4Fe7SvqnkqmrFYRQdrn41Lhu6cYVIlspnTgFwEQI?=
 =?us-ascii?Q?bw8Kz0QGM47OzigRapK5RY8avREfEHjMRjd0JzdDwpduIpTjy5nBCwg/Ghbk?=
 =?us-ascii?Q?utbBD+piCVOQ+oQRRPa/kusv4DiojpPqFfHpuklPr40B/+w3FdsaqEW2nDjh?=
 =?us-ascii?Q?djqz4MnUHdezh8RRPNHHGZUpWxB2mvLDVzFakGsf2pn8yoLN5tR1ZvQQ3fyM?=
 =?us-ascii?Q?h2/OEWhBVYvlTtyqLmSwWN6dOopjYq9XOIK/jvf6GPtgna161fGtBrvIw//U?=
 =?us-ascii?Q?fjAS5EHHJkFsIvrhHw8eDMNun1fYIVKPB+J91ykt4ckzQfT+ANDzIFDw1pqE?=
 =?us-ascii?Q?sdNHnfU81F4M+I5TjLgkaWmwoL1LT0Kytftz64QpazzHPS3+TDDz6RIDCeUc?=
 =?us-ascii?Q?9Zj4NBw429AzbDovmpd40LNXVp5Jcd6s/Ww7b3Bf4EczzvW+zAr/GYGc8Erj?=
 =?us-ascii?Q?eaoSLl5AC3HNYbEiAnFhxBxzjrlQpshQsOr/ooCF1dQPo9f577Z6MfsY5pIK?=
 =?us-ascii?Q?LL6GZMygavGPY2ANny+5T43Zdm3KNbbgHKVGsIhHKTG/vV0HqtR4osbipiI1?=
 =?us-ascii?Q?McQdDVllgroNLKXNmg0JhxTpiLLcrBY8ox56faYgsCuuVYyXr6TqHrm6XIjE?=
 =?us-ascii?Q?z7o30bSptKlXG2+FDcgx4rHFoioxHgPk2JUMsmpS4nCgafFc50a8811U2joL?=
 =?us-ascii?Q?e/K06+Ao3vAE0nNxcnDx5MshjJQLiQXPvpVdsM9XGNX8KfLPPn8f3yeCsLCs?=
 =?us-ascii?Q?obuOeADIbJVF5UQfQCqqBC1xE7MXnKh3VpOppwXsDoOfxeclQ/Q3dt7ZTxbH?=
 =?us-ascii?Q?npBi70PfSv9RHXwR1UR5MK1jGAnjIFaKH8wO7F5IlIJacyASmpZUcg/O/w33?=
 =?us-ascii?Q?cKe+TuiJybfsPISzTyjzoq6veFiouzt6qBkRaCcCvnZh4xedmQ2zm1dUjxHV?=
 =?us-ascii?Q?7E7a9BjfpqxX2Won9lL09YDJfCxEnO7WRnBJYgKuJpTYhnoAiJk6w2dOrckX?=
 =?us-ascii?Q?IJb4hyOEK8zDrdS1JTgemn5SRk8HRxXjfMxUnt97PBOHVGwhrnXrQoE/iV4S?=
 =?us-ascii?Q?yhVcDH4jkhzVOzvhHq0uLLIm94J9LSyXhcmd3bL1ijYbIjUvPAymbK+Qa/Yr?=
 =?us-ascii?Q?6VE2EvI2ZGILMiFG2LMMyPN2lE7YihuKeU47cD7IDW2j9e3rqCT1ey9Cc9dq?=
 =?us-ascii?Q?TKnXT8iTMhDHjPAey/PhrAefAYOWfM5zQ7NlZaZUZ2HelqANfCG9GJVe0Cij?=
 =?us-ascii?Q?mITboJBLM5ypd1kelHO9X0DMo+S+wk5nCWZWFsyJsOFCZ0RJv/Nf3w+vOVlU?=
 =?us-ascii?Q?39V7CLMuBIIk44EUeScEU0BU6oS0YhdYVe6ki98Ni4rhclQJJZTRhNmdVfN8?=
 =?us-ascii?Q?wYvrYOdJzdbMbQsr5HKN5Eq0255oRz9x8NQWaeuhJV40DgqX5g9FdGzTiuWm?=
 =?us-ascii?Q?h5w7TZ9m4gNphQyOy3lekv6bBeMJCiPxt656j+pYspBT80sE0/nNBaq6exEJ?=
 =?us-ascii?Q?TWpWupTt8NNeVNF5XDxVGmxGOpsF9O6aHZbnVgZVyC5MOrM7E/YVb0GLlBwF?=
 =?us-ascii?Q?vALrZfHINtOqpMtFRqyZh/lV5XqJ+2o/p3VzNyQjIWc9veTyCj5ciYMr8vev?=
 =?us-ascii?Q?ry1w6FlQM17qKqaFH9pacsXwDKwdo5gXuuVMBQ5ltrzUiyCo+zRdi+gacgld?=
 =?us-ascii?Q?OmKlhkcUXo+wtuwoBN6F6pkjt3+JPzg=3D?=
X-Exchange-RoutingPolicyChecked: fCEJemJMtDxcMgXOQDxTkWbANvcRp8kTHecIYIL8lysNV3Mod45yWZMtuh9mpTGEUGOAJfvERTRwwCguqXBafR/TRmWpIXxz6MIBRzLfuHu+fy9ttCE/EV1JDXdv5Sw50xh2wsvylpfteS//PAvqndMjOOU7sqIJi0VvEbFWHW3O8pB8Ecu4/o7M40cy9nBmw98qiopxwOUo+HQQjfQpn50Fd02xU06gGOWmZIL3VHvD0/VIvfoe6FA7J0d5mGX/dbHcNtXngUa4gQ0WDlZ63xlJPae7qWh3uvg9mYgttq0b31AI7+oS3Pskt2hnAvOl6PXINUJcwRf+a8p24deELw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 50f37f99-2fde-4993-4c7a-08de9bb8a8ed
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 13:04:14.4878 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U+/dL3D+JpNv3vGagvMeJ2/yqVyBU0Nj/Q6YHfGQrtjb500mzQKkUggYACGg+iXb4veNkCVXRGgQlCnALzrpu/gbTjXEah804/X2Vx7/gro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7299
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

On Wed, Apr 15, 2026 at 02:52:52PM +0000, Jay Wang wrote:
> This patch adds the NEON-optimised Rx and Tx paths to the ice driver on
> AArch64.
> 
> The single-core testpmd benchmarking was conducted by Andrew Bailey on
> an Arm Grace system with an Intel E810 100G NIC. The test was run with
> txq/rxq = 1 and 2048 descriptors. The throughput performance uplift is
> shown in the following table.
> 
> | buffer sz (B) | prev (MPPS) | optimised (MPPS) | uplift |
> | ------------- | ----------- | ---------------- | ------ |
> | 64            | 77.613      | 110.874          | 42.9%  |
> | 128           | 77.187      | 103.547          | 34.2%  |
> | 256           | 55.183      | 55.240           | 0.1%   |
> | 512           | 28.800      | 29.031           | 0.8%   |
> | 1024          | 14.609      | 14.556           | -0.4%  |
> | 1518          | 9.726       | 9.756            | 0.3%   |
> 
> Signed-off-by: Jay Wang <jay.wang2@arm.com>
> Tested-by: Andrew Bailey <abailey@iol.unh.edu>
> ---
Applied to dpdk-next-net-intel.

Thanks,
/Bruce
