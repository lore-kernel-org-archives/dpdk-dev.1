Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B588C61CE8
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 10:24:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A14540661;
	Mon,  9 Jun 2025 12:24:03 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 0969640658
 for <dev@dpdk.org>; Mon,  9 Jun 2025 12:24:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749464642; x=1781000642;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=qxzEwDwnccez33ZbmDWVqvBP7qejJVsKIvQsJzK/cEU=;
 b=R6H9CtKqLGCxQBsViYAcCEkm/rxH7gS6QITvbp5qm0VxfP9+1a/Dy4GB
 2w/ksojIUJi6uHvpKPOMlYa39nRM/CbhaqAqjhbUj7LG/Q4FhPierR7Er
 hh9NqwHAF6L14QYd13jIFdosNS7Tw58hcqBVOSVsQrNve0a1JnmKpspTF
 fo7F6tND84Ggz2s3J6isJh50Edk0G+bstT2TgH6Gye5GNHKGbkhim2cr5
 Cl8XyVP09fLzg6et4pnqRV9sfzkc3FhR+43nKYq5ccWUBLyTrRox7cSiL
 wIK/G4U9Cp4h/uB1ajOVhjjkk6dT97rtTQlbee5+Wp06Y4coV9fEsWQ/l Q==;
X-CSE-ConnectionGUID: qAuR9RaGT62g7k4vtE1Lbg==
X-CSE-MsgGUID: ekwyD6YTQqu5vTr1mNjhSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11458"; a="74068220"
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="74068220"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 03:24:01 -0700
X-CSE-ConnectionGUID: m+wHsbnURTi+Pjo5wV0HNQ==
X-CSE-MsgGUID: TLW0O93wSzCms/lvi/CSkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="151347312"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 03:24:01 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 9 Jun 2025 03:24:00 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 9 Jun 2025 03:24:00 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (40.107.95.43) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 9 Jun 2025 03:23:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TNYL/GuC0KKC4UudEZm67hQjHRxRxhmM9TaCOrg3w8n1TuwVzuYGlp503tA5d8i5rVktjV15g1lMV4BZo6LdnKjwrklSTl+D1lOzNuMK+ANeDaCzs6zLyuHIdWRiiCdHpaMoQXs4pM2HXAzQogs3aB5B31uKBpxIMXK8c+IWdlv1ZiKEMqw9E72dVe6uq5rTYlO2k5QRb1GK4FNtGdEGFdorbV59ZVNuSTlqcru98EWHbJ2oD77yR29ZY9plhDv9oX5Q9cMgAwJtmkAEJlKJiAEGak8IeymlmrcVZ3H59EII6WrjAwScpYJUUN1FdojdrYLuZRzKUmvBYtMt7jh4Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+8obo7d2DFA2ve9wavBMGxh8p6tk9yoR6HXTQiXaHz8=;
 b=kLa5XrC+ApsQeCxgZLYNjevESCg0eKN3+H+uP+rILMu+NYE2j2fQ1x5bmVt/tF3r74QnYNt71bRUiDnb1ZO/3gbYq+AQDW4cT+pqM219OSDRPYDQ5ZG65x4tH9x1r4ajHmeS6WnYUnZ1p6/oIsOGLibsANm/kkhB/7hYuDv61j7WNIJ5h6HYgEZIAWtM1MdkqOEufgza8wiRhDTW4rTZULe0/RqDwTXly4k9QJ69058PSbKfL9UZQY6epB88hoxt9elKDv9FJpDBpDYAAEGRmLkPDfyNIMN2jxDkJ8JwIqeiCdJLszZmwM7e6Omek6kHFlcv768RlMTnKHSXoD27rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by DS7PR11MB7888.namprd11.prod.outlook.com (2603:10b6:8:e6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.29; Mon, 9 Jun
 2025 10:23:44 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%5]) with mapi id 15.20.8813.021; Mon, 9 Jun 2025
 10:23:44 +0000
Date: Mon, 9 Jun 2025 11:23:38 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v5 08/34] net/iavf: remove 16-byte descriptor define
Message-ID: <aEa2Kk4eHH_d_9jf@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1749229650.git.anatoly.burakov@intel.com>
 <cover.1749229650.git.anatoly.burakov@intel.com>
 <d9821e8463a0d494ac1f1f08f27389c26b33d5ce.1749229650.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d9821e8463a0d494ac1f1f08f27389c26b33d5ce.1749229650.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DB9PR01CA0013.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::18) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|DS7PR11MB7888:EE_
X-MS-Office365-Filtering-Correlation-Id: 91880839-bbaf-47b5-02d5-08dda73fb679
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3jwYeUVG9Xl9L96bnGabs1A/eZ/H3Rty1lX1CEI7SxeC3ccg/dyahdfqGg9m?=
 =?us-ascii?Q?Wirmb1QGgREQLDjwrwvSdHL01ocI9SIluzOCNsy1+/xUkfpieBU8iRJXdDun?=
 =?us-ascii?Q?EMmpBlgh2gNRZrKdozUozEX/7BdZcM4yqSMFpXI74N3V2XsrSIuX8W3sggcP?=
 =?us-ascii?Q?sia8fNdWe9LGdMXMZw3WbMJl0oXfLM4x3Ex8ExkxVNfgprRTGRoMYTH1qxyM?=
 =?us-ascii?Q?oSRRf/spLDJqIJkv0rhWhrtlnLHoSpdt4pvLc+LurWcv9OeUOATaoXu/rUxe?=
 =?us-ascii?Q?oJIWl6oHAaQaUZp58uIO4HxM1ldAj4WueDVY4gxkViMgnIKg3pkLjqE/YA28?=
 =?us-ascii?Q?miFkQQkpfK3qldC/ts8d1OqU9hbdNhp/g/F99L/ijI1sOZ+gQmFzPBNpO3EP?=
 =?us-ascii?Q?9gRGxI2FV0bpmC3uYGvXBDLHTXDVf43QErmdmDO22lKihGEadG1E7cjllmLF?=
 =?us-ascii?Q?UAsg7c1TT2/glQ9ZY9w2G0N0cCUO1vqVHypsDHMMzvIyut/ZTBqEzY2TI4TQ?=
 =?us-ascii?Q?QA976XafTFkxIGzUiRF7y/aVtwFrzBBjwQ8SvPwun/BducUTFdUkYQQ7cb1E?=
 =?us-ascii?Q?5Ds45Z0wxYOSI1oB7Fg1cfCtMcO1S3pt+YXxZFO9U4V2rSEPdkt5QbAogxoV?=
 =?us-ascii?Q?QEXpnrdW3SbgZNe/qhPRNy9K12m2b3BStX0jQ7n8ugE2ae8EOrJ7cSvIejyN?=
 =?us-ascii?Q?tce0vNgA24aN4EDy9cosBac554dOWVdeHd3ORy4ILlY1Hc+L+9p/gZiBngO6?=
 =?us-ascii?Q?tCWltktnLAwS/WUjYmJeOqucACDjX/66ooBauSp+C1hCf2i3XepCw9e7LOfp?=
 =?us-ascii?Q?ABLBJzzuP3r7HvenpyaLuJ/1G7aBygJ72gIOVIm1rtCNlTE15QB6d12U/f3O?=
 =?us-ascii?Q?k0nXqSS6NAoTcX5rkYnbsYK8TeiMrK5t6uUxAE49Xdj0bhbPMKweKEFND0ih?=
 =?us-ascii?Q?dOhjQtusqQi6YL9JQ+3aFTFR/KPKFZ1RiHy37Rxhp8iEYaXXcOqp5kMnmwWL?=
 =?us-ascii?Q?vMQtkLBOqwXExihGS9ok7+V0nfrFDRi9YsTuVMx8cNv5gu/ANbOktCoTdXc1?=
 =?us-ascii?Q?5sbMYKb2qq9ffn45zwhEj+UMVEb3hiveSeXsKKMuXXwY008p83UF3jFek+Gk?=
 =?us-ascii?Q?oCVrEsBWkHfcJtoA9AP70zc/WrjAENKHwjhdYA0wgJ6j/GpqCQnSuBLaM4Uh?=
 =?us-ascii?Q?jC1e/TqdiI1G3MvMzRO6/lVcDV3IuvHZDf5GNTWCvLiQkZ1AcR+cwycQkGft?=
 =?us-ascii?Q?grSF3G+nmpaQy6SsVRrL0tHl7smMrPxIAP6zBD2UdUo9xi3kgh4C8fSoy71W?=
 =?us-ascii?Q?0kpWBtr0+UFDX96pxyt9DqNzZXCbt6VHmZWr8iZPv/qEOOec26J92Rfukdo9?=
 =?us-ascii?Q?RjKV2Od1L5wo7peiLxbb/kCxnuebXddp32bD7Ni5X/HqxXVkEw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4p7Y9EwwImO8Hf/RwHYczxS7fD8JE8HMOB/6ITM/R21wDe4oMpNZjipdpINN?=
 =?us-ascii?Q?zoKD1X1Ek7qJ7cH55HK3WxqMJL4GKlfdIzaaIIseOy8ezBYqVfe6NanrPYDS?=
 =?us-ascii?Q?zhxDRC+UhL/jsSsd/i0y13kXq8qhkxXf8hzPCkZCbYxHVtBRsKDzGPHnRv7Y?=
 =?us-ascii?Q?HEb6cp0NRWKm9d5OuDfmvCT5xqHcaUlsDnyQmK5r/NcqY792tZUz4p3KR283?=
 =?us-ascii?Q?EGOAMmypdnMmZS7hc0KyhoOBgGW25WkedL6ffc58sHUq0AF/1yObOZhLbf5t?=
 =?us-ascii?Q?kHV/X5iprrmysCsBgTzLXtLg/uvZQTnNU3fMmvPEMu+imv/0Q1SmA1n3Zvvv?=
 =?us-ascii?Q?kCrpnaaDsIhJRD2B2aDD3uYNjpJ3zYzNYHqtO4bmbOQoQd7RfYIg7kqFlPf5?=
 =?us-ascii?Q?n/5pY2dwzlaRTAki0Hjh5Dhv2VZqLM87qUcBRgga//mW3AFXhitrGMBrYAAv?=
 =?us-ascii?Q?VV2rvIryPtYzGHgbD0gbabHow4g6g33GLfODLCVYVttLi5kH83FqXqTOMmhg?=
 =?us-ascii?Q?2nyztaFQsmcbQU5ba4hNs6oLqWQjaEC7xj9mYY/lkEqHZK9/o/sx1mcAWjWY?=
 =?us-ascii?Q?BcUkx/qXQQ4wmU/smDyS1MY6X2Axo9zQCOr03LZEhEkQ7BS1EgXWQ2MfE+JG?=
 =?us-ascii?Q?sI/AkKS4jkiOmPckKMvHDR9rZMaKgFbVmdWyv9jcdOCqm1/aHG+WAC/t5BQV?=
 =?us-ascii?Q?b/O+GeBKGMh+AfdbgSh4KZaGq1NpvP++lBw8RMtqSizk0rSL0zF/qALuwsXG?=
 =?us-ascii?Q?8mt3E3wHhBIIFNlPRuOKu1D51dxSXkpBh0QujjlJFuDBY+YpMWwVzgiq48qf?=
 =?us-ascii?Q?x+nom0icUoa3OHygRu6pukMuLcJpoXDNuJP4k8Kz3P4yCmOUEVakPV9rnufD?=
 =?us-ascii?Q?s9TmFLSBM7raMBhnR9MESE6NbwozHWKxIU82WB6Q/NrVR3Qt8Pzikz+kkjH+?=
 =?us-ascii?Q?mSpiJsXcIMWx2PD2sIJGEmPCDbO4fkaUEXSSpIKKdYdULc03FzyCvMt2RYOK?=
 =?us-ascii?Q?UrVAQhCh65dABvtJsFfzX2QeL8X1vLHH3ZztQFU2Wr3jJNt+danwqF+Vfl6A?=
 =?us-ascii?Q?zJGtSTwZPqC6cHGSdCxlMmxuSbGBReFyL4gaLtEwlzOdcT0oZVs4YdJVR4rU?=
 =?us-ascii?Q?3iDDCneelsMcKuzglW9A1oWlVIb3oIFymgWMxDlGzD8rKd1L+1n9Z37kevf5?=
 =?us-ascii?Q?grtKYlTm6vmEgmjhFemlx7u9uhK80wQ8PXOytHjLf2wXC6hCb1OiQZPhPxah?=
 =?us-ascii?Q?PV6nXGGlcspMS39P6dHTU+iDt7/1tJ2bevu/TRq5ClU3beKgmDsRILssZssc?=
 =?us-ascii?Q?eSdO5v91zRCPGF7wD1a1LKKgt0oNmz+40Fm+8dgzx8qFXuAtnkE9MonFAZ9g?=
 =?us-ascii?Q?GyBVoTXjOaQpJjbQ28OxZlr09jWtzhPDs+GOU16En9LL8awyEiW2804uPmCA?=
 =?us-ascii?Q?7p5a7icSndSI5IK2QYS1/cxgv+bYL3S6A0LobFjPKxmnAksnqSmw5Kv3r/wH?=
 =?us-ascii?Q?pvbGQ6fqS9sXhs3kcWhwE0TcBjlhb9yObIDgNsO52zP60fDerSZv8sLRnY/w?=
 =?us-ascii?Q?jSrBaogu1emz9iYiaLQy0G6GkZcfl3OltGH9bWT7dJK7XG20Mim+hIVlblM8?=
 =?us-ascii?Q?uw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 91880839-bbaf-47b5-02d5-08dda73fb679
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 10:23:44.4348 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EeOhXQkd5tTryeyRDt8Ox6WWNS+77V0V8TNnq4y+8fbNC0+GKUD6p1hlXgJ56DJ7aFsmcun915qA5DFuG3Lt/wzApeajyrSg/OgFwWEY5c4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7888
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

On Fri, Jun 06, 2025 at 06:08:47PM +0100, Anatoly Burakov wrote:
> There are no physical functions that support having VF use 16-byte
> descriptors, so remove all 16-byte descriptor related code from the driver.
> 
> Suggested-by: Bruce Richardson <bruce.richardson@intel.com>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
> 
To the best of my knowledge, this flag was also never documented, as well
as being unusable.

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

