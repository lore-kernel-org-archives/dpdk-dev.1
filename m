Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 470E8CA1010
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Sep 2025 15:32:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 973F2402E7;
	Fri,  5 Sep 2025 17:32:27 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id BA9D9402E5
 for <dev@dpdk.org>; Fri,  5 Sep 2025 17:32:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757086346; x=1788622346;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=75X3k5C+N8b9dX85k9nVz4XO+qusa9wUceBG2FGJ9+k=;
 b=kxUduB0VJR+78fEBaDScuRx8p97E0saPaLcKt2U1jBCVn5qQB0yGqcf7
 m+f7blIrt+57Qy/6p+fAyI0HWU2S50OS2dcHNS3gMbv82+Dg4vOsikuJm
 xAgpdJsmgIX2WIE20PxwblDqLSQImdJzeLNHiMpRhGztypwVSi60T1Bwk
 7XNFEWHzYE/qXHYDkzEb4UtXUBveSdn4xmPBwlxc+JORYHeLWqnEmcwKI
 DKYI2S2NsG7KnTii/q5jVDJE+rBzbyh956Q18npqs48uIV8vBbimKAwEo
 ZErmIEBVq/y7TiwW4jOzMmsHRvhitOwGoJXv+CaPY2TGkUw3yWaGLZ8uf w==;
X-CSE-ConnectionGUID: n7uDlJWWQOGrCXFv3VX93Q==
X-CSE-MsgGUID: b+A3V6G/RJKM+SiSdLh3mA==
X-IronPort-AV: E=McAfee;i="6800,10657,11544"; a="70057505"
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; d="scan'208";a="70057505"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Sep 2025 08:32:24 -0700
X-CSE-ConnectionGUID: XwQ2MRCATKaX7DyHoIwSaA==
X-CSE-MsgGUID: E46n12cER5KaKDp06/1KjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; d="scan'208";a="203002377"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Sep 2025 08:32:25 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 08:32:23 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 5 Sep 2025 08:32:23 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.68)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 08:32:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U7RX7Jve9T1MnUlQLcTNtgiv44TXLmM/snKeFJ0IyC//u/ISGhsv6L9uBbDMlICKFkYYFPyEY1vDnVO1/2k0LIHoxoNEB52Ry60tTO5NRQkX0sWYYO+Wm+Oytkbhl2tK0x76CGsQdJYD2MBH8qxSLuGWijLroQW19icIwEn9KgyS0i3f/Tk5+cx5RAp5+N2Rt9/IfI/r5BCJ+khAvWLMahEyA1uJzRZgLwidoaGtmgzCW6ubvg7/BAPbOdtuanWcsH4js9oRyaTNq1YnIYWu8wROtBfdm+PQd6WlpMq1OCGkGkYcFnSv1VOxMnKPoGGoeo70hH3j2LyUr2oGWqHupg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jItEVyvOm8nuJwjFkLT+tlWsh9tDXouvDb9P1UPdo/4=;
 b=fvUSM1fO8AZE8xzVrl5Zuk/APb5dRVcIizTyIdvUJTiaS97sFcmmtn59Q1VzSV2nQnHLv91a+OkUhUH9jynYQuKSFv5biKG0NQza1ClXHlQsP+j17X3CWZwYLFKOSkfTOFiVwtLZ/zcFqJAy2FG/CPkX+pNx+0cXUu9x6tlnGzh7+0cO3xK+C70QA9bq5CPehZ/4nnjN/cHKxwldmBgzdXaEKvFj+ulNNrEjyryvUfYuZnTaX29f1QQHxjDVMSHcslRYdfLDA8P90R3BPHXQ8H4/6Wx+L35hoZaMeQyStqrswkIev5I+W2FAR5Wj+AOC1+A9JcEOWlM/gvjKrR2rKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by CY8PR11MB7012.namprd11.prod.outlook.com (2603:10b6:930:54::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Fri, 5 Sep
 2025 15:32:21 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9094.016; Fri, 5 Sep 2025
 15:32:20 +0000
Date: Fri, 5 Sep 2025 16:32:15 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, <jacob.e.keller@intel.com>
Subject: Re: [PATCH v1 09/12] net/ice/base: improve global config lock behavior
Message-ID: <aLsCf6Of94EA3aP6@bricha3-mobl1.ger.corp.intel.com>
References: <cover.1756833701.git.anatoly.burakov@intel.com>
 <890cfe97d9f716a7a65c028578bd1fc90ff04c4b.1756833701.git.anatoly.burakov@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <890cfe97d9f716a7a65c028578bd1fc90ff04c4b.1756833701.git.anatoly.burakov@intel.com>
X-ClientProxiedBy: DU7P251CA0004.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:551::28) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|CY8PR11MB7012:EE_
X-MS-Office365-Filtering-Correlation-Id: b1070d41-6de0-4361-a3db-08ddec916752
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7iAgs0vKpkblGKhWn+CXzp7A3cSXMZYjTQFARplYOsxypMxcYUNt12rF72q6?=
 =?us-ascii?Q?LvPU61awMyrBNVLBFa8fjjjkqIOPkPwyacM3biHp7lS8e8rt9gcRu8/ipR+v?=
 =?us-ascii?Q?EtacRf2iC5kPImPcsWR94UMNMd2ewEavU87u569T3B5L0nP0/ZBKuyIcAD/2?=
 =?us-ascii?Q?kFY032qLmu5ibWpEmbsZ6amaM0vTv11D3CRjJ8DOklCYxK0r43Xj1Rns/IhG?=
 =?us-ascii?Q?E6VZP+uv67peYQkz/zmRwgc2gCnOp2Yv0jVn8Ggjsczsgc10VqZIacWG+Vfn?=
 =?us-ascii?Q?Uhtl9qJ5NWkAb93KqQYj2vO03V8MeBGzvjZF9y3BopoBS9hHzor73MioE5vZ?=
 =?us-ascii?Q?n8doH5zKHdHlS+Yno3SLgyEX9pBKFt5YBbZmn/9E3AhR5l6mLkXclrEDSdAg?=
 =?us-ascii?Q?FazT631FkcCCAyJ6p+qYX2tiz0RO0p4Fdz+O3qOwwkW21aG4gwUFQGXLRGyo?=
 =?us-ascii?Q?zYCaxIGSkQjU2VwvhJXGNzVVW3uiG4gJ+4xfH9tKsOQG5VXRm8koflPcALsk?=
 =?us-ascii?Q?YFjRdByFWjDyCdKuewqN9Yu3ii0Q5lrrqVcuyzDHq2FX3ZQqxvvObRBBEP6x?=
 =?us-ascii?Q?n6H8Nzkz1HSnJLPbtN6kaF0DJl/IVU3xWP+weMOO8E/A+4jtvqjja9RecMcw?=
 =?us-ascii?Q?pLh/T+N6EJbKyWq9VH6rgF8Pxwa32uC9I8JeIn4IkJnfUFGaGwz+dYS5aebH?=
 =?us-ascii?Q?fyRscYOU4q+T7azqFNySOUwtdSHoalvKIqB3pIsjHjF301jKxU8376CghW31?=
 =?us-ascii?Q?ohRSWWJb+pdImB9tVBw4jQfv59DP8G1djiMJGYdJTnmRWQyBV7lx/c2FWogh?=
 =?us-ascii?Q?hrw6UiqwwwqfheEtfjT6ITSd+ch5LIfAoYjUwnoOcPUlNEhiMW2eWVmprJ8y?=
 =?us-ascii?Q?L2RZHUwr4gAoz1NJ4n18CLzE0pZzY5BsadhebnPAiOGg/FWxAZ4Jkz9uLiz4?=
 =?us-ascii?Q?1eJ/VUE1XxCdYIyc49TNelylE4WUlBDrnhiUghKH8Zs6qXIMvpm/D24OiWVo?=
 =?us-ascii?Q?eR1wWgIYfVeUVQs46pPwnJzthlkyDSU5ZB16WWy5muCNPHF68l0Ydzqy+Zxf?=
 =?us-ascii?Q?qbDsC8syzyod/ZIDChG5gB9aI5P6UqN3Fy4CjagADUvcwH/F4i57qRgLeB/z?=
 =?us-ascii?Q?GXRoS9zIPICLwM1zhGgA36m2Dm/oCtkIN2s+VnayR6XmcuJAoK4vc+27dv24?=
 =?us-ascii?Q?r44fuhKjUvNNgNlcigZjwctHssHTaJC0DA5ejOrcP8U2T+u+DCiRYN+QDj8T?=
 =?us-ascii?Q?ydUOGcdHzu6LDTAyasmmJ3OIJuFJxGx93GYYLqd3Xy1Mc/FBcdqfKipv6Ntv?=
 =?us-ascii?Q?yU5+CCjGhdVvfYxfvFYSxZFUWJPaK3XakZgM2nWX5ZSCVcoh8LKjBjId/QgE?=
 =?us-ascii?Q?bOfxwzPD6LVKj4br/cBMYdkXFTfiYwCZf4HCLbwiQ6MON8mvRiZO1mkVY1eY?=
 =?us-ascii?Q?HCpIPrIJ1Bk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hhcN0bYRBs75DNIu94IRPQJCqJB0GkFgNHhXrBK8qIAXPiKHRRhR0Zek1bwm?=
 =?us-ascii?Q?IDIDLNv2U7fbOVwyepBxPQokwl0ffve3I/FcRWzttylwwlRQeWiCQyM/FOtx?=
 =?us-ascii?Q?WBoD4+JtMFt9hDFpZnYAhAMwhImGNIDJyaFqTTVMF8Coqdc87DcG+qlVzte0?=
 =?us-ascii?Q?ofaEJVQswcZpwzg4xM9tpy3HDAObUnQmj8oDKxtOmTyw24iOO4p8Iu35QUFp?=
 =?us-ascii?Q?5GBvRbgBAWeXhibL3dszNkvd4t2HOmBZQwY1mg/1OijU/80PsDguccF6gmwM?=
 =?us-ascii?Q?+AuxBmJdJ2H0E73vEA6oymSVLISfWcA3zb3h+7rT8rpiGtQUqNb3RnoRLeO0?=
 =?us-ascii?Q?ru0uhWKOB6x+IADXIYP0HJXKhDK3drCZXlp3IP97JnpUNw32K33DVWLUq0az?=
 =?us-ascii?Q?WH0XJusc5AF0EsfSQbD/rc1XO7eME6j5yTgF2dMr11HXfd9f6rCNe01xY7EJ?=
 =?us-ascii?Q?NLwurg78kniciByXJ1jsCKsMDR9x4BjkY5ycGwl4gjiYUtG8odxcbUczhVUq?=
 =?us-ascii?Q?xa2Krr59lOmv2zbx1AWrrnE1OBQzzBlExS6MGNz6oR/QnVIAKGAkgqmKopVu?=
 =?us-ascii?Q?1NWb+iSvnzKLjmBK4BZK/a2SWOgk+5YsM8abJLXDh2ParriBY4EevQM0JloS?=
 =?us-ascii?Q?9d3IksdK2shUIgjLJtFHg2QRsTr2YU0shbQzd9C8dzvzOevwoTKEY6AkUwi0?=
 =?us-ascii?Q?ufXubUve8BRIjRr69Pq/dgzfR5jEzKhZyA3m7hsSWiNU+V7J0R2aDhipzUXT?=
 =?us-ascii?Q?8PBh8Tayr1qv6wGF1JBL1dpNIBofmfn/9p9Q8UIqQMu8Qh5541JLMcLzXtHQ?=
 =?us-ascii?Q?tSGyYkGapRpAp9Dv/MiGeK3NKKBQM9jIkTEvW6wzOh3fd8Fu7xcazKQVAZVp?=
 =?us-ascii?Q?kTzowqSOO3kWocRY2ka0HG5KkuMShTnrP/HRJpzSXvNxfKLKyiiLdidwuPZv?=
 =?us-ascii?Q?UNbSXrmuDLNzZksvX4zoXgUFlDhOKEdiDduhVCNvGRBy/YZbS6vYBJfYAnvj?=
 =?us-ascii?Q?cctKYKVgU0n/F45y5PxQ+eSYLmG/sLMUghq3UBcSplp6yPXPaqAZ0czQQhTz?=
 =?us-ascii?Q?u3iC5RnBVgMxF25aNGzKVlW14gr6SFefmbNxoLDw86MVsMTTZD6FYHvqZx8/?=
 =?us-ascii?Q?+frI8m5nJS3XltJ+CftAeVmhUBP3HDg3WJb6ELvDvwRNq5/rKFc44/wuIDWn?=
 =?us-ascii?Q?qGzUCgQhkfbh9tp4F8l3rmlqTHSlN2v7OQcKcd3pRwVHnWcEjqOJXn6yua62?=
 =?us-ascii?Q?qJRz5U0JdaHQkVU8L0b5hPjlHW8kyuRFBaSBXYK4pGKZZpplZGlR4ESw5/lG?=
 =?us-ascii?Q?VqKrr15oNCgFLuOUoF6rf/pTBg4lut3Aj+CXgsKV2ovUQeuecbNXY9OFyrcn?=
 =?us-ascii?Q?WmPdfkj9pbgJ2g9d3GlLV2xUQiAIyRWfw820+1dKtAh5HTdZIIbPIroAsci7?=
 =?us-ascii?Q?Cpq/va9cKd0G9i/jfXXaRs6p1skUCUt8UPaYY8laOlDeVhZFYtxCSGjkdRwR?=
 =?us-ascii?Q?1en5ra/ZiySbkYBDba5PZPg/JCqdKoAIJjUbwNq7nvc+VXb4+xNiGlw9P++H?=
 =?us-ascii?Q?LYPllDr9KiaYmrrJXHZXKelw+Aaw8wyRLS0nqHdY6qwViOWy/SxFD/sEBACb?=
 =?us-ascii?Q?eg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b1070d41-6de0-4361-a3db-08ddec916752
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 15:32:20.7261 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3rHbJHIjf87pqTrA233yILfitR8PI0aH/wKC4Ez6N4ydUuvpesnH/EHkblXgjvuxvztE3KUIReujHv1l6mirA+Oku9wcMQSAmqdYRpPvX5g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7012
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

On Tue, Sep 02, 2025 at 06:26:59PM +0100, Anatoly Burakov wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The ice_cfg_tx_topo function attempts to apply Tx scheduler topology
> configuration based on NVM parameters, selecting either a 5 or 9 layer
> topology.
> 
> As part of this flow, the driver acquires the "Global Configuration
> Lock", which is a hardware resource associated with programming the DDP
> package to the device. This "lock" is implemented by firmware as a way to
> guarantee that only one PF can program the DDP for a device. Unlike a
> traditional lock, once a PF has acquired this lock, no other PF will be
> able to acquire it again (including that PF) until a core reset of the
> device. Future requests to acquire the lock report that global
> configuration has already completed.
> 
> The following flow is used to program the Tx topology:
> 
>  * Read the DDP package for scheduler configuration data
>  * Acquire the global configuration lock
>  * Program Tx scheduler topology according to DDP package data
>  * Trigger a core reset which clears the global configuration lock
> 
> This is followed by the flow for programming the DDP package:
> 
>  * Acquire the global configuration lock (again)
>  * Download the DDP package to the device
>  * Release the global configuration lock.
> 
> However, if configuration of the Tx topology fails, (i.e.
> ice_get_set_tx_topo() returns an error code), the driver exits
> ice_cfg_tx_topo() immediately, and fails to trigger core reset.
> 
> While the global configuration lock is held, the firmware rejects most
> AdminQ commands, as it is waiting for the DDP package download (or Tx
> scheduler topology programming) to occur.
> 
> The current driver flows assume that the global configuration lock has
> been reset after programming the Tx topology. Thus, the same PF attempts
> to acquire the global lock again, and fails. This results in the driver
> reporting "an unknown error occurred when loading the DDP package". It
> then attempts to enter safe mode, but ultimately fails to finish
> ice_probe() since nearly all AdminQ command report error codes, and the
> driver stops loading the device at some point during its initialization.
> 
> We cannot simply release the global lock after a failed call to
> ice_get_set_tx_topo(). Releasing the lock indicates to firmware that
> global configuration (downloading of the DDP) has completed. Future
> attempts by this or other PFs to load the DDP will fail with a report
> that the DDP package has already been downloaded. Then, PFs will enter
> safe mode as they realize that the package on the device does not meet
> the minimum version requirement to load. The reported error messages are
> confusing, as they indicate the version of the default "safe mode"
> package in the NVM, rather than the version of the DDP package loaded
> from the filesystem.
> 
> Instead, we need to trigger core reset to clear global configuration.
> This is the lowest level of hardware reset which clears the global
> configuration lock and related state. It also clears any already
> downloaded DDP. Crucially, it does *not* clear the Tx scheduler topology
> configuration.
> 
> Refactor ice_cfg_tx_topo() to always trigger a core reset after acquiring
> the global lock, regardless of success or failure of the topology
> configuration.
> 
> We need to re-initialize the HW structure when we trigger the core reset.
> Previously, this was the responsibility of the core driver to cleanup
> after the core reset. Instead, make it the responsibility of this
> function. This avoids needless re-initialization for the cases where no
> reset occurred.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  drivers/net/intel/ice/base/ice_ddp.c | 34 ++++++++++++++++++----------
>  1 file changed, 22 insertions(+), 12 deletions(-)
> 

Acked-by: Bruce Richardson <bruce.richardson@intel.com>

See one comment inline below.


> diff --git a/drivers/net/intel/ice/base/ice_ddp.c b/drivers/net/intel/ice/base/ice_ddp.c
> index 850c722a3f..68e75be4d2 100644
> --- a/drivers/net/intel/ice/base/ice_ddp.c
> +++ b/drivers/net/intel/ice/base/ice_ddp.c
> @@ -2370,7 +2370,7 @@ int ice_cfg_tx_topo(struct ice_hw *hw, u8 *buf, u32 len)
>  	struct ice_buf_hdr *section;
>  	struct ice_pkg_hdr *pkg_hdr;
>  	enum ice_ddp_state state;
> -	u16 i, size = 0, offset;
> +	u16 size = 0, offset;
>  	u32 reg = 0;
>  	int status;
>  	u8 flags;
> @@ -2457,25 +2457,35 @@ int ice_cfg_tx_topo(struct ice_hw *hw, u8 *buf, u32 len)
>  	/* check reset was triggered already or not */
>  	reg = rd32(hw, GLGEN_RSTAT);
>  	if (reg & GLGEN_RSTAT_DEVSTATE_M) {
> -		/* Reset is in progress, re-init the hw again */
>  		ice_debug(hw, ICE_DBG_INIT, "Reset is in progress. layer topology might be applied already\n");
>  		ice_check_reset(hw);
> -		return 0;
> +		/* Reset is in progress, re-init the hw again */
> +		goto reinit_hw;
>  	}
>  
>  	/* set new topology */
>  	status = ice_get_set_tx_topo(hw, new_topo, size, NULL, NULL, true);
>  	if (status) {
> -		ice_debug(hw, ICE_DBG_INIT, "Set tx topology is failed\n");
> -		return status;
> +		ice_debug(hw, ICE_DBG_INIT, "Failed setting Tx topology, status %d\n",
> +			  status);
> +		status = ICE_ERR_CFG;
>  	}
>  
> -	/* new topology is updated, delay 1 second before issuing the CORRER */
> -	for (i = 0; i < 10; i++)
> -		ice_msec_delay(100, true);
> +	/* Even if Tx topology config failed, we need to CORE reset here to
> +	 * clear the global configuration lock. Delay 1 second to allow
> +	 * hardware to settle then issue a CORER
> +	 */
> +	ice_msec_delay(1000, true);
>  	ice_reset(hw, ICE_RESET_CORER);
> -	/* CORER will clear the global lock, so no explicit call
> -	 * required for release
> -	 */
> -	return 0;
> +	ice_check_reset(hw);
> +
> +reinit_hw:
> +	/* Since we triggered a CORER, re-initialize hardware */
> +	ice_deinit_hw(hw);
> +	if (ice_init_hw(hw)) {
> +		ice_debug(hw, ICE_DBG_INIT, "Failed to re-init hardware after setting Tx topology\n");
> +		return ICE_ERR_RESET_FAILED;
> +	}
> +
> +	return status;
>  }

There is a similer deinit + init combo in ice_init_pkg in the same file,
which is the only use of this function (in DPDK anyway). Therefore, I
believe that that code can be removed now that the reinit is handled by the
cfg_tx_topo() function.
