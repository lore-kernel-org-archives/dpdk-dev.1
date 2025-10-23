Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80557CCD1BC
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 16:04:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AB7E540151;
	Thu, 23 Oct 2025 18:04:17 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 7359B40144
 for <dev@dpdk.org>; Thu, 23 Oct 2025 18:04:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761235457; x=1792771457;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=/Jp0h0TzSGCQ24LlD1zNzs+8nqmOAy5moVT0390zhmk=;
 b=heMrbfdneBUxoIm628Cpb7ABp65Yi9gu1u8fm0xT8/ea9owzzxJeVFlN
 2+YjyhW9Y8M7QPUlKtKHtQWmD6o8rKlSHwEenoV75z2+uxD2rkauXKYyG
 /qxFPZH/oCZQPiovZvcfkbcHK1voWJkEz4qwx5LQe6HrzqHkXzb+Wi1AI
 MRAdjbQTu4YK1hVJY0cSx3iMDB0Qkk6mqXIJx6HvnQKN0vLGebHc0mbl/
 U+CHJXRCHfhlZ+pKHqhd0nP8l+xD7Ji6WzCbCxzVGU9vpOxKsE+/wCJCY
 m6ZATzLMWpbPisgV0+HyFfUnkOxH0I+8IIGA0Lbsu41GkwIjk7+KRJfLJ w==;
X-CSE-ConnectionGUID: 0r8HtVpDTxGLPUnD8fXl/g==
X-CSE-MsgGUID: bAtu/QgLR4+/Pb3A2Kfnsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63450213"
X-IronPort-AV: E=Sophos;i="6.19,250,1754982000"; d="scan'208";a="63450213"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2025 09:04:15 -0700
X-CSE-ConnectionGUID: 1IvcJ84KTn+lF6zG2d/2Ow==
X-CSE-MsgGUID: +4m9FpRuTZmf0Jq0XvMdlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,250,1754982000"; d="scan'208";a="215116733"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2025 09:04:14 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 23 Oct 2025 09:04:13 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 23 Oct 2025 09:04:13 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.65) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 23 Oct 2025 09:04:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QD2ogzI6cFxE0VgnXdGzeLmqawCueYl7X4R3ImjFJ087DPaNhRUOWzVNuk+Eq4TKcFG0JJJh4FXbVi+/1G2/YCbXLbi0YTjPc0spvjPqnW/j0LRBffa/GrW6xW3G1ppGBy8CmvpN54WzQw+aa2itWrrHU/HbaQigRvcjgvMmu1yxCB4guqYvaaO4XZeQM/L5xf3CTLV+76LhHjqRPUoc1cNAS5z36sshFIJ4IvdubqNHpQaTdrrC3mnRL4xMs0PqBYwIQM0aplkjplEPxNTkstGjS3ZNNZQ63Kcbe8XTChMdJhnI/sPVI/Qjp9HtqAGMCAGENCtd3jNfdiq+HgddYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kd0nIFdnp0n2dXEvNtpYpL7+D0GwPdFV7yeU0U90Kpg=;
 b=n/R7O2SKq4+/3CzjHlzUpjwKx9myXAtLm6YsjhWY26YpXVrbqP/YLOaBEUiMxkIQBPPKxmc46zxP6/oUEknz5SAmlLKg3jcJGHzAj3pEjVkIolZrxw5Q6btW5ZFL2vM8CR1fGDgHGYoOonmErHmzpGv3Sza8i8MmolCLn/r7fckzmHFW4cScy3RrE8zltOAoo55HPODL60WN4rXq4D5cXlun3+u61Y+fXJXD1VnAEoLfs6GW8zG3PkB4lt8Po8N+UcxTGFbOrEz0ODyFFBtlEAa4z4ZuhHPc5UylSL+F6MqhMVRgnvkENLw1PD+RzEZuXtUOJkiqIcvKgrdgN7U5rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17)
 by PH0PR11MB5157.namprd11.prod.outlook.com (2603:10b6:510:3d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 16:04:11 +0000
Received: from DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b]) by DS0PR11MB7309.namprd11.prod.outlook.com
 ([fe80::f120:cc1f:d78d:ae9b%4]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 16:04:11 +0000
Date: Thu, 23 Oct 2025 17:03:46 +0100
From: Bruce Richardson <bruce.richardson@intel.com>
To: Morten =?iso-8859-1?Q?Br=F8rup?= <mb@smartsharesystems.com>
CC: Konstantin Ananyev <konstantin.ananyev@huawei.com>, <dev@dpdk.org>,
 Stephen Hemminger <stephen@networkplumber.org>, Wathsala Vithanage
 <wathsala.vithanage@arm.com>, Fengchengwen <fengchengwen@huawei.com>
Subject: Re: [PATCH v5] mbuf: optimize segment prefree
Message-ID: <aPpR4jZtBvDM42pL@bricha3-mobl1.ger.corp.intel.com>
References: <20250827213535.21602-1-mb@smartsharesystems.com>
 <20251023080136.165513-1-mb@smartsharesystems.com>
 <c556ea7b92a24bc09ac5240da39bc36c@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F654F7@smartserver.smartshare.dk>
 <6a26d57153714d04865753fd557978dd@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F654FB@smartserver.smartshare.dk>
 <e12aa6583cb34a3595fd518c187bf144@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F654FE@smartserver.smartshare.dk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F654FE@smartserver.smartshare.dk>
X-ClientProxiedBy: DU2PR04CA0284.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::19) To DS0PR11MB7309.namprd11.prod.outlook.com
 (2603:10b6:8:13e::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7309:EE_|PH0PR11MB5157:EE_
X-MS-Office365-Filtering-Correlation-Id: 057aa7ba-9642-4fe7-37a8-08de124dc2a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?gRw/vAK/cBy1D5aMfbviY+kqbu+kIJ7r0IWvt+Toktc/ZWWqP+I8YCYIa8?=
 =?iso-8859-1?Q?ArzUGzCQDgkaSKL8nOHt+ijsgqUewZvNJ4gTesojCVi2n8fbm9Nm9sSClW?=
 =?iso-8859-1?Q?IYttXOIFihr9yNNu9eoR2UC6VLHYUxdah4kiFFJmgXhNXThmHLeJm4SXcZ?=
 =?iso-8859-1?Q?O3PB5XP/y2HIiYcz7rt1EL15oxoqNNl+j3omwfKH1GBVGNwxEOym9jpIPW?=
 =?iso-8859-1?Q?ZiEOzPgRYj8HWqPRlpmFbqxxRlLN//pcoVUOYkIC8tm+BTwlnAAEBvjZUW?=
 =?iso-8859-1?Q?NRcUl1tS9I8RFGhbeSVFd05727OCd0rZSBH68ekPezAgSc4+U/J1TWE1ez?=
 =?iso-8859-1?Q?E0zkUhqCWqnaf3NmzOcSU987goZdr9eAgclmGfk2gwpASnt+U7MbJN+F21?=
 =?iso-8859-1?Q?U2cDfACy2vscfHB0ubhD+UM7FaCBQGrRAwrXc1yFdNGKWoxxnAJ2hE5Lo6?=
 =?iso-8859-1?Q?W4X4s03EcRub5YgtHp6weol1BeR0lik8C+c0ymrWqeucGK9XYhR2imDJKT?=
 =?iso-8859-1?Q?G5GI0IGU8ax+ZsZkvSXFPEEEgRoAYzKxF8rq/cNVhiftBv11+H8XSHoj+N?=
 =?iso-8859-1?Q?hsKdjyqZmB4z6omOeMoT3oe55c+nAMk+I+NWv73HxMohXZILpzFCGbSov8?=
 =?iso-8859-1?Q?s7HPZ+LxZV7She1SMcPhWxexcK/VHPdfhDf+TVdNxlNXhigwkt6TJ2ewof?=
 =?iso-8859-1?Q?eJYQUOE6yNktuMrAIk75+ZnRD46TXIGZkFWAoW9x5O7W1L4FBH4Zb4Ws4K?=
 =?iso-8859-1?Q?3ubxyYKrlJ0W+BBh0Y+++5bCmjuuyXTIFjy/YydwEWUg3t9Ehb8jUMMsCr?=
 =?iso-8859-1?Q?ChB8+FZwlJVLnX+Pn7Q0TSwy/zefaZUS1ZEpv9eomMv0BrjyrBMF84VKJK?=
 =?iso-8859-1?Q?XZ9thRWgMrxHNbxOBcDhO6LPsMxj3Sf9NmYPUDvPAgjs2wwUAsVaz/3aNX?=
 =?iso-8859-1?Q?B+TeLMy9icYe/ef/YcfO/nDWBDsukuo479TQk+TgdCAY9Dwi1xvnbgVD8u?=
 =?iso-8859-1?Q?XWu4hKrHibNXat+9P+HGQJRbzNulkIGLLPgrwHlggRid1CxngEZnAQ3D2P?=
 =?iso-8859-1?Q?Ga3zvLfSB8fUoa2f+nlb8rE5u3OhAz+eLW/l+QhuhPtgVsDLAA4b42WdNd?=
 =?iso-8859-1?Q?oSzfwK7R8zEgDJJvNJu284Fa27lBQbfyecAkW8k9pEdw5jTkgvj+Rc1AEU?=
 =?iso-8859-1?Q?1eG2uHsA5Kjr13YICkGI4dELPDs4m65hH2scXdhorbNrney7clG2swYQWM?=
 =?iso-8859-1?Q?XXwqhZH9e1iWCNuQVna7HrNWgEGFpv1MZHrJbrT+C21HqGRRPdJIzCyDKI?=
 =?iso-8859-1?Q?A9erH/XWVXrIn4lG5IG3/yx1zgtoSplLJchfp6hHQlSZeJcHI5s06Cuk1w?=
 =?iso-8859-1?Q?mgZUBTt08diAM9I245ZjG7p79HE7bi6ObohfrONHijE5fP4bDNiFLbc/SN?=
 =?iso-8859-1?Q?aUKO2+CvpllVrTi667/8FPjvhFucYT8BeW6Uj1rR8ZaQRMyjO1mEBsgLJJ?=
 =?iso-8859-1?Q?RSHtzyLGrY1C66WljBC2Iu?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7309.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?xLkmkBqkiYkkwYOTA8/KOcUN6BzbE6Eof/NPodoGEYpJe8NDi9NEFVUzS/?=
 =?iso-8859-1?Q?HeRXwQhMXjtl0X2d4rdw+9hCETsBmecmk9TZYV9DIuU0z7CBxgu0KMVEN0?=
 =?iso-8859-1?Q?mTjJ50hpxg9nUXfy7VKm4IUQs1m7vo1dYHCJrkC7lhE/qTVXoap+8g3zEC?=
 =?iso-8859-1?Q?ZR+uiPLHYHqgau7fwB5Uc8MafT0wGLvLHTvps2SlyzjryQvoRB+NSG1gVy?=
 =?iso-8859-1?Q?FW35UsiyOwsST6DeoSO6P6qum1MWIama8VREGH8JaOhNYQn1DwstA363WM?=
 =?iso-8859-1?Q?Lz6wVvsPBbXRJywV5/PhnRr2WhgFdgKplEujNuZzq6Lp5r1xYcTdx9nNIu?=
 =?iso-8859-1?Q?cI9aJjeP63rFU23n2gF7+hhJaBQ/Rj077hYm3hLAbPaCxNajiujvEZ7w/w?=
 =?iso-8859-1?Q?4VwJbu48+f/pVoWdWjba7Ombm2cFDDrY2nNbKmsZYfP1sB2yRV9XGE8Y6L?=
 =?iso-8859-1?Q?Zd5E8c5/7uCJQevGZHBcExWwyBMs0Q9Dte2mPWlhKcW+UpBsAKG+BALNR4?=
 =?iso-8859-1?Q?+mfCYhGpA91n2aFkARwP2qnooL3LSNINlnst1R77TDsgR9Wta29AlKs6m5?=
 =?iso-8859-1?Q?Td8ahgpHjC6qJbXM3FRxERZDU4tbD9vEjHiXlZPn0PQWNXU+7hSeUPIwCm?=
 =?iso-8859-1?Q?D86xVl2XaC7WibusQlkFA7aUYMC0y58fQv4WqJfclAQfgo/zGqN4i7LbRr?=
 =?iso-8859-1?Q?O8pFkPak33CVbzGTu+YKybdCgZLz4W5rf4Tkrki2BAfesU9I/nVnn8T1l+?=
 =?iso-8859-1?Q?JTOYSON0KM7qJSdufb75ChyFnMFc1/f1pROJxceeZD6vUivH69QpQQ47Rq?=
 =?iso-8859-1?Q?Fh5rBG3tuwXDwRskHQwB5GokeMOeIODuRP2DtERgYsbqmIrIOVBz+/8LU0?=
 =?iso-8859-1?Q?RGLkf7lWLk6E5z3Mt7472ITGLm0pmmsoI2wGqqVLy4ZEr9VFg5uzA0l9gt?=
 =?iso-8859-1?Q?nfMlIy3u17Mhzp0fKDDtgeNcXnMW75/a3ECvRiqMXF/TP24eM+QaLYlymo?=
 =?iso-8859-1?Q?m1DOLiyiuy6X5T1NKtsNUG53ZXkXlxBhSu2XUTMxE/89Lz98eXxfltQSAy?=
 =?iso-8859-1?Q?KDvbteACeVp8DPdaOVGZMHv4wnkrWNbYw20GonerVLCHj/X7LPWe2GUTr9?=
 =?iso-8859-1?Q?pjG62RryN8bjVlF8KSuOykUaFGieFXFAAzgNX0g0KvLlyKFSr22GWMRrMg?=
 =?iso-8859-1?Q?BS0lNlEDcqucICXpodwjjCDHzbqqHv+ZqwaEJkz486Pi+sR+hwjvMNzngt?=
 =?iso-8859-1?Q?JJSWGM2X3hqeCB+6sSFYy/CZXQiSVGLJ/5JNy86Lfhex61oRyQW1pV4jHQ?=
 =?iso-8859-1?Q?N3SCx4dTu/5v0mZivh/SrGM04ph/wy2cyZNoSnnAxC2miC+2efx5sJPIaI?=
 =?iso-8859-1?Q?yawJ7mPqsyIikYwQuSaJEvh/iqPpEUlByUExFIPQgCt1kre5PkwJdc+rwE?=
 =?iso-8859-1?Q?n8IEE57tgZ5f75Q3aiw6Lq1thjGXlhoTt7KH+GfEraZfRTyJv81FKe5AGR?=
 =?iso-8859-1?Q?WWmxqBWnznzHWewdV6XnnFIca+dMUuyRfRCEhv5HtXZ3FKkwRn7s8asAg+?=
 =?iso-8859-1?Q?+Bi3n+rO/VIdO86FNfPuSmnJuEkdz76xt/nhhMEp0fzTSbVAWnhGc9PDfl?=
 =?iso-8859-1?Q?+/C2h1tsJ5mNJqCaOp1wLYqRSeKOSWkoeuYMl2wdP7ScJre5CWo2zYiw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 057aa7ba-9642-4fe7-37a8-08de124dc2a6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7309.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 16:04:11.4603 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Da45vY9I9HGJYIsDh0wOwxqXljrComDiB9IcdIlsXVenBsUpU6WEms4ROhnUQf1/IazVhcuqQh2PE2vV3qzeoxnfUUT5twr33lDF+L4t9NY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5157
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

On Thu, Oct 23, 2025 at 05:46:49PM +0200, Morten Brørup wrote:
> > From: Konstantin Ananyev [mailto:konstantin.ananyev@huawei.com]
> > Sent: Thursday, 23 October 2025 17.27
> > 
> > > > From: Konstantin Ananyev [mailto:konstantin.ananyev@huawei.com]
> > > > Sent: Thursday, 23 October 2025 16.05
> > > >
> > > > > > From: Konstantin Ananyev [mailto:konstantin.ananyev@huawei.com]
> > > > > > Sent: Thursday, 23 October 2025 10.51
> > > > > >
> > > > > > > -#define RTE_MBUF_DIRECT(mb) \
> > > > > > > -	(!((mb)->ol_flags & (RTE_MBUF_F_INDIRECT |
> > > > RTE_MBUF_F_EXTERNAL)))
> > > > > > > + *
> > > > > > > + * Note: Macro optimized for code size.
> > > > > > > + *
> > > > > > > + * The plain macro would be:
> > > > > > > + *      #define RTE_MBUF_DIRECT(mb) \
> > > > > > > + *          (!((mb)->ol_flags & (RTE_MBUF_F_INDIRECT |
> > > > > > RTE_MBUF_F_EXTERNAL)))
> > > > > > > + *
> > > > > > > + * The flags RTE_MBUF_F_INDIRECT and RTE_MBUF_F_EXTERNAL are
> > > > both in
> > > > > > the
> > > > > > > MSB (most significant
> > > > > > > + * byte) of the 64-bit ol_flags field, so we only compare
> > this
> > > > one
> > > > > > byte instead of all
> > > > > > > 64 bits.
> > > > > > > + *
> > > > > > > + * E.g., GCC version 16.0.0 20251019 (experimental)
> > generates
> > > > the
> > > > > > following code
> > > > > > > for x86-64.
> > > > > > > + *
> > > > > > > + * With the plain macro, 17 bytes of instructions:
> > > > > > > + *      movabs rax,0x6000000000000000       // 10 bytes
> > > > > > > + *      and    rax,QWORD PTR [rdi+0x18]     // 4 bytes
> > > > > > > + *      sete   al                           // 3 bytes
> > > > > > > + * With this optimized macro, only 7 bytes of instructions:
> > > > > > > + *      test   BYTE PTR [rdi+0x1f],0x60     // 4 bytes
> > > > > > > + *      sete   al                           // 3 bytes
> > > > > > > + */
> > > > > > > +#if RTE_BYTE_ORDER == RTE_LITTLE_ENDIAN
> > > > > > > +/* On little endian architecture, the MSB of a 64-bit
> > integer is
> > > > at
> > > > > > byte offset 7. */
> > > > > > > +#define RTE_MBUF_DIRECT(mb)     !(((const char *)(&(mb)-
> > > > > > >ol_flags))[7] & 0x60)
> > > > > > > +#elif RTE_BYTE_ORDER == RTE_BIG_ENDIAN
> > > > > > > +/* On big endian architecture, the MSB of a 64-bit integer
> > is at
> > > > > > byte offset 0. */
> > > > > > > +#define RTE_MBUF_DIRECT(mb)     !(((const char *)(&(mb)-
> > > > > > >ol_flags))[0] & 0x60)
> > > > > >
> > > > > > A stupid q: why then not simply do:
> > > > > > (mb->ol_flags >> 56) & 0x60
> > > > > > then?
> > > > > > Should help to all these LE/BE casts, etc.
> > > > >
> > > > > GCC is too stupid for that too.
> > > > >
> > > > > Playing around with Godbolt shows that
> > > > > 	return !((char)(p[3] >> 56) & 0x60);
> > > > > becomes
> > > > > 	movzx  eax,BYTE PTR [rdi+0x1f]	// 4 bytes
> > > > > 	test   al,0x60				// 2 bytes
> > > > > Instead of simply
> > > > > 	test   BYTE PTR [rdi+0x1f],0x60	// 4 bytes
> > > >
> > > > And these 2 extra bytes in instructions, are that really that
> > critical?
> > > > My guess, we wouldn't notice any real diff here.
> > >
> > > The optimized macro made the common code path of the refactored
> > > rte_pktmbuf_prefree_seg() fit into one cache line.
> > > IIRC, all 10 bytes saving were required for this.
> > 
> > I understand that. but is that change will provide a measurable impact,
> > in terms of cycles/op or pps or so?
> 
> L1 instruction cache is important; reducing code size of a per-packet function might have an effect in some cases.
> I don't have other metrics than code size for this optimization.
> 
> I just tested to see if I recalled correctly, and here's the generated code with the two different macros:
> 
> #define RTE_MBUF_DIRECT(mb)     !(((const char *)(&(mb)->ol_flags))[7] & 0x60)
> 
> 0000000000000670 <review_rte_pktmbuf_prefree_seg>:
>      670:       f3 0f 1e fa             endbr64
>      674:       41 57                   push   %r15
>      676:       41 56                   push   %r14
>      678:       41 55                   push   %r13
>      67a:       41 54                   push   %r12
>      67c:       55                      push   %rbp
>      67d:       53                      push   %rbx
>      67e:       48 89 fb                mov    %rdi,%rbx
>      681:       48 83 ec 18             sub    $0x18,%rsp
>      685:       64 48 8b 04 25 28 00    mov    %fs:0x28,%rax
>      68c:       00 00
>      68e:       48 89 44 24 08          mov    %rax,0x8(%rsp)
>      693:       31 c0                   xor    %eax,%eax
>      695:       0f b7 6f 12             movzwl 0x12(%rdi),%ebp
>      699:       66 83 fd 01             cmp    $0x1,%bp
>      69d:       75 51                   jne    6f0 <review_rte_pktmbuf_prefree_seg+0x80>
> ** Look here {
>      69f:       f6 47 1f 60             testb  $0x60,0x1f(%rdi)
>      6a3:       75 6b                   jne    710 <review_rte_pktmbuf_prefree_seg+0xa0>
> ** }
>      6a5:       66 83 7b 14 01          cmpw   $0x1,0x14(%rbx)
>      6aa:       74 09                   je     6b5 <review_rte_pktmbuf_prefree_seg+0x45>
>      6ac:       b8 01 00 00 00          mov    $0x1,%eax
>      6b1:       66 89 43 14             mov    %ax,0x14(%rbx)
>      6b5:       48 83 7b 40 00          cmpq   $0x0,0x40(%rbx)
>      6ba:       74 08                   je     6c4 <review_rte_pktmbuf_prefree_seg+0x54>
>      6bc:       48 c7 43 40 00 00 00    movq   $0x0,0x40(%rbx)
>      6c3:       00
>      6c4:       48 89 d8                mov    %rbx,%rax
>      6c7:       48 8b 54 24 08          mov    0x8(%rsp),%rdx
>      6cc:       64 48 2b 14 25 28 00    sub    %fs:0x28,%rdx
>      6d3:       00 00
>      6d5:       0f 85 3a 02 00 00       jne    915 <review_rte_pktmbuf_prefree_seg+0x2a5>
>      6db:       48 83 c4 18             add    $0x18,%rsp
>      6df:       5b                      pop    %rbx
>      6e0:       5d                      pop    %rbp
>      6e1:       41 5c                   pop    %r12
>      6e3:       41 5d                   pop    %r13
>      6e5:       41 5e                   pop    %r14
>      6e7:       41 5f                   pop    %r15
>      6e9:       c3                      ret
> 
> #define RTE_MBUF_DIRECT(mb) \
> 	!((char)((mb)->ol_flags >> (7 * CHAR_BIT)) & \
> 	(char)((RTE_MBUF_F_INDIRECT | RTE_MBUF_F_EXTERNAL) >> (7 * CHAR_BIT)))
> 
> 0000000000000690 <review_rte_pktmbuf_prefree_seg>:
>      690:       f3 0f 1e fa             endbr64
>      694:       41 57                   push   %r15
>      696:       41 56                   push   %r14
>      698:       41 55                   push   %r13
>      69a:       41 54                   push   %r12
>      69c:       55                      push   %rbp
>      69d:       53                      push   %rbx
>      69e:       48 89 fb                mov    %rdi,%rbx
>      6a1:       48 83 ec 18             sub    $0x18,%rsp
>      6a5:       64 48 8b 04 25 28 00    mov    %fs:0x28,%rax
>      6ac:       00 00
>      6ae:       48 89 44 24 08          mov    %rax,0x8(%rsp)
>      6b3:       31 c0                   xor    %eax,%eax
>      6b5:       0f b7 6f 12             movzwl 0x12(%rdi),%ebp
>      6b9:       66 83 fd 01             cmp    $0x1,%bp
>      6bd:       75 59                   jne    718 <review_rte_pktmbuf_prefree_seg+0x88>
> ** Look here {
>      6bf:       48 8b 47 18             mov    0x18(%rdi),%rax
>      6c3:       48 89 c2                mov    %rax,%rdx
>      6c6:       48 c1 ea 38             shr    $0x38,%rdx
>      6ca:       83 e2 60                and    $0x60,%edx
>      6cd:       75 71                   jne    740 <review_rte_pktmbuf_prefree_seg+0xb0>
> * }
>      6cf:       66 83 7b 14 01          cmpw   $0x1,0x14(%rbx)
>      6d4:       74 09                   je     6df <review_rte_pktmbuf_prefree_seg+0x4f>
>      6d6:       b8 01 00 00 00          mov    $0x1,%eax
>      6db:       66 89 43 14             mov    %ax,0x14(%rbx)
>      6df:       48 83 7b 40 00          cmpq   $0x0,0x40(%rbx)
>      6e4:       74 08                   je     6ee <review_rte_pktmbuf_prefree_seg+0x5e>
>      6e6:       48 c7 43 40 00 00 00    movq   $0x0,0x40(%rbx)
>      6ed:       00
>      6ee:       48 89 d8                mov    %rbx,%rax
>      6f1:       48 8b 54 24 08          mov    0x8(%rsp),%rdx
>      6f6:       64 48 2b 14 25 28 00    sub    %fs:0x28,%rdx
>      6fd:       00 00
>      6ff:       0f 85 50 02 00 00       jne    955 <review_rte_pktmbuf_prefree_seg+0x2c5>
>      705:       48 83 c4 18             add    $0x18,%rsp
>      709:       5b                      pop    %rbx
>      70a:       5d                      pop    %rbp
>      70b:       41 5c                   pop    %r12
>      70d:       41 5d                   pop    %r13
>      70f:       41 5e                   pop    %r14
>      711:       41 5f                   pop    %r15
>      713:       c3                      ret
> 
> > 
> > > > But if it really is, can I ask you to create a new define for 0x60,
> > > > to avoid hardcoded constants in the code?
> > > > Might be something  like
> > > > #define RTE_MBUF_F_INDIRECT_EXTERNAL_1B ...
> > > > or so.
> > >
> > > I started out using the field names, but Bruce suggested using 0x60
> > for
> > > readability, making the macros shorter, which IMO looks good.
> > >
> > > I don't like adding special names just for this, so either we stick
> > with 0x60 or go for
> > > "(char)((RTE_MBUF_F_INDIRECT | RTE_MBUF_F_EXTERNAL) >> (7 *
> > > CHAR_BIT))", something like this:
> > 
> > My vote would be to use the construction above.
> > Might be put it in a new macro for readability.
> > Konstantin
> 
> The optimization requires casting ol_flags as a byte array and then reading the MSB; otherwise GCC and some other compilers are too stupid to perform the optimization.
> So, should I post a v7 with the code proposed below (to get rid of the 0x60 numerical value)?
> 
While I'm not going to massively complain about removing it, I think using
the numeric value is absolutely fine because we check its validity using a
static_assert, which also serves to document where the constant comes from.

/Bruce
