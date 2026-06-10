Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04705CD98C7
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Jun 2026 08:13:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA71D4026D;
	Wed, 10 Jun 2026 10:13:28 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 9471140151
 for <dev@dpdk.org>; Wed, 10 Jun 2026 10:13:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781079208; x=1812615208;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=xnq8oKq4sRvbRrFGRmeBKDkTuiy2cxHwX+WQNN7kKMY=;
 b=UlVE/o5LN0FOwClRVG5+1+5N+SsxRcACUcHmnQyGVJEIe0Wy3p0YdJvB
 uS9oHXXrUpmDgVGvTuUoHvDXSyITOjvfd5iN6ip38JK8LzkFotLZdLg6W
 jv/SfZgYbK8s3jl5cWkHKy7TyCDmCtLP/XejUC4dm94OP4Y8X+gYF/+uv
 VPwy9WFHR/DKRoPxFpreoOv8rtcMZwqZMVlwnJsjARGVODznnzLplsFBn
 1bwTdVUqBTrifzP7kde5YrivQ+nV1840RQ/bPbwDrtV0urr7VZ4grCKf3
 ZDcCewyaH3/Zg4ZO0ZwbRVleKZbiQPl1ffInLwpbA5QILMw6JhQBio3zC w==;
X-CSE-ConnectionGUID: 46Q03Ws6RtG6X5pHyndX+w==
X-CSE-MsgGUID: 3+KBI/bxTyS4ZHG9EG8aPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="99443280"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; d="scan'208";a="99443280"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2026 01:13:26 -0700
X-CSE-ConnectionGUID: 96iFW3srQYeB4kW8458LBQ==
X-CSE-MsgGUID: VwjCrKBcSXi04QCVEFa2ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; d="scan'208";a="247961175"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2026 01:13:26 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 10 Jun 2026 01:13:25 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 10 Jun 2026 01:13:25 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.30) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 10 Jun 2026 01:13:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PAtXaZL01LJMw/1m3Bem0dRsKgv4QS0qtJNCdbqwX2dR5KAQynmBqswK1JdmgTWVr4gSYMm7afjyGvmXpxSCKRON8nS44aR/aRnf5QlczfOIj4U4jVjr0F1VPjKZDSImcybDhAQyF7ywLPBaAdUKhSXt9wrwV0PUCiPTIv2EyXo4+9oFkcs7H2WnTOTZm6vCdKc4iryUrSc2IQw9Y/oRXR3UeceLKE8Vb9QENmBXLfoCYGqT/MVHJFSly8cbiBX2w0rpzO/oFnInIGG1bdJqJXYAGQjIYHGSd348i9qMBUOGKvyFQSYULEXb9iW/TH5KWuoIZX0LgLl9lhhdWh//ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LVYv8pqN5B26930nBqUvTlXyX9FFO+JbHVUF3Bc2tbY=;
 b=vyS7PznSswF/IFfjtNpFpi8lhmElMYRyHomP2oiiPLVuMJAX2oagg8A44qgU8SsGP/d7ICuiJnbnE52HLByjFIVZ1YTERD4Lq/MD5QhBo5rFlu686p4FRC6uxyGIGT8Vsykh3/8qBJFfOtr0yYLobcgD7S22aKioMRoyCmVCut4VmzIeP5+DKnRhCcScmPvIkgVyTy3s37W3UJKjnl1yq/SY9Jj6t/5V8yZHsWL61FHOxkfeUueLgHyBwW1LKV2ztNOI10ReCfv2w9bqlN9npjAXWI35vVs7zxMEm90duK4dB1w7/+6TpCh0dAcyVz/yUaJoVxpNYgTvgGqXK/1ceg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA4PR11MB9278.namprd11.prod.outlook.com (2603:10b6:208:563::12)
 by PH7PR11MB5942.namprd11.prod.outlook.com (2603:10b6:510:13e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Wed, 10 Jun
 2026 08:13:21 +0000
Received: from IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057]) by IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 08:13:21 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "Talluri, ChaitanyababuX"
 <chaitanyababux.talluri@intel.com>
Subject: RE: [PATCH 1/3] net/iavf: downgrade opcode 0 ARQ log to debug
Thread-Topic: [PATCH 1/3] net/iavf: downgrade opcode 0 ARQ log to debug
Thread-Index: AQHc91bsnO7G93sWEUmfjDJuUJF287Y2SdMAgAEpaFA=
Date: Wed, 10 Jun 2026 08:13:21 +0000
Message-ID: <IA4PR11MB927828E81A5F1EC7C81BABF48E1A2@IA4PR11MB9278.namprd11.prod.outlook.com>
References: <20260608145518.1705524-1-ciara.loftus@intel.com>
 <20260608145518.1705524-2-ciara.loftus@intel.com>
 <aigjEm-RskU5s45v@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aigjEm-RskU5s45v@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9278:EE_|PH7PR11MB5942:EE_
x-ms-office365-filtering-correlation-id: b3c0a1fb-5740-4b36-8e87-08dec6c822f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|38070700021|56012099006|11063799006|4143699003|6133799003|22082099003|18002099003;
x-microsoft-antispam-message-info: yfaFinP1L2gfdxTC5OsReaAz15z/hmYpMWyGmHni6Ia+4c7Qukg4ITJOGidzOWHqhRGosPTgP9kl2I2+7p6bnqurUGkkfVzvVRA6YpuSbC04H8QSusy1tRA7BBTJVFmiRSJWkz/n5KIe64Pb6dRUUNU0SHvJCg5RVMraOaQVcw5K8s21qZiF+19pbZkHDlar2ILtSUwiShrgBFQS4mzJq1IIZ4lw/UfxfHC58hSx0zRwXyPXks9eZMzi4HTfi74tEP32A/mBz1wJJIPfgqVe5PSiuM9J4k5bf4fr3jiyflSPG394YuGddATrmzqoE6MiNfgTa0EbJ05EYa3sJP06YxxdIEhUHkDBI40aLe+nICIW22c5+vGhU9YCHPV5boA7pOGa440dApTM335uKXolvG8ZKoOOMET9uzvkoDq7FW+p0SNaFogRxFNJ2RiGtZXg5QsWCg5peY9gV4+IOEYNk6zU7RPReKYKqiMlXHXOt0lmylvgQiRNbdlRZZqcz+PwAIXxHxEV9TuZXnW+z2sH3TMIo82o/3QAbCLpsrEUXo0cjXSVB48kJAT/eoh9BjY1p3ZNCW8y5RGencN+2JMITNyKE4Bjx4GALsUE2Gxg6ua4Nd4zUJbKrKq8LPZ8g1nITLYBC1CYsEi5s+Of2v7JBoO9m1TdxcRkUrCvstRJfWRxeDrzxR7mkL54mfLarbvvDjGy9P1wNRQ9h5j4ZSELtts573SyFbCvl2faTnt7WWUODDVYcL0mfRuYE5BFdhA2
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9278.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(56012099006)(11063799006)(4143699003)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?R973DTjo/aWTNF8q5j5dxvGR1XqXTUPLGWF+KnJRkM43kCRkhxe5eOBpv1dP?=
 =?us-ascii?Q?PFCIacbJ9KBcFvSZ8wGyTKL5Ci8VGPdp3RLSsa1Ub6np1UzZdYv/xjzwaG2A?=
 =?us-ascii?Q?/TN7sewogJr54Zgy7hv6Ydo89EsoT/ryY/ZGJBFo//tF/XF7nsT/2lbqb7Cl?=
 =?us-ascii?Q?36M9koKF/FI4vqaYiRkazsZgUs73CqmiGpV2wLt1vCtxy0Fp5HJ2d+yBA0jQ?=
 =?us-ascii?Q?tXLaVFqB3Vpafk3RSO5I7glk8FFISVoL1/FEmBTjV3xOaklkhe2JRgprh03l?=
 =?us-ascii?Q?8KI+tR4+ZRLCUPzVwq/nXz7agl8rVssIst5xVIhC3jGlgaiRHiUvX51kQ3s9?=
 =?us-ascii?Q?TBBo4vZBKpnRoi7wMUXPTcrSfpHME6S0CIy/oNHTLCcNw1krTwK4Yq3FFPiA?=
 =?us-ascii?Q?hc/NNDQym/M6SJlm9QzHpm8I7XLpKzlfN+XELQqJephB+SjrmcRbt3AN4Dal?=
 =?us-ascii?Q?kIXRXk4zcPQT06afJoK+wDNqDu0cO4jyNtqOhFYDvYHNgsCBFZwTAioHn8Ne?=
 =?us-ascii?Q?Q2WrDeCT3YX6qp/hdRt/Cxs5grNcso5S66OBP599iik2SjCIcgdosWzYvWAx?=
 =?us-ascii?Q?hhw30x2epmYhY4YtLEQrlyyeVrgGXCcwgDpW1/LQAp0iwuvIp0Na1kzYBOQO?=
 =?us-ascii?Q?Kyk0OlaSxtnIREcnUQSl90/79A+U0ggS/Y/ZPbFVnXQ0ofXaJuzrHXnVjc7S?=
 =?us-ascii?Q?gkvumfR4iBPlZsPDdT0JCGfZZQoDJdVqjQX7J6TS6d3ToNQ3XMhGgJMk8rwK?=
 =?us-ascii?Q?y3lrR4JqdRgG3v3owr5GEtVKjhsaxzZWJE4L50ZJHZVdtQrscj0jogtJyZh1?=
 =?us-ascii?Q?FtfMEgF5TKrT8YYGbEWbz+U1+XmBJrdzR6p9eWhH247207L4VGYnlG3Xirly?=
 =?us-ascii?Q?mwoghwONOXHLuFcknemONlvwRHsvMakt0QYttU9k+vZkY5kbokzTi90x79yt?=
 =?us-ascii?Q?bG/u/L/jBeW3Hr51g591s4yuxJarG6jCZtrYp0pZODPZzuM61ayQkCBrCP61?=
 =?us-ascii?Q?EkvPkx8usH2ixNuthko/VAjzpZaNdfCZYKN5aLBNGrxInwaVxF6HeWXmu1Xo?=
 =?us-ascii?Q?bVzb6WoJfVCVl8gyJbCRvKya0Z8q1Yy4kj9e+kPh4OjEC6GKwk9fD7yNiMAr?=
 =?us-ascii?Q?IPsJU4YErEpwDlpmbu11zI6irUYyD3WnNlzRsvKCJFZonMcu59RfoyIVjZMk?=
 =?us-ascii?Q?RGUegVEGUb2VsO1HXqMrMJyScDr0Jhzl8rUIo/wVkjm2gK8hbqePiIwyCeWf?=
 =?us-ascii?Q?qo5L17WNGu5pChqucTSUaaDyhna4lZjRk0oTARBbpvwVYrqWnM64LQ7t6MJv?=
 =?us-ascii?Q?vGOPe7BNkXqVkXmNsbOk+oCSgRenH/hMjFYWC8JAy2qvTMvtCpEjyvYyX7d4?=
 =?us-ascii?Q?zW0y5LgNsge4Ik3Ahlmx9Fgpbaj+tmJEYWF86J08Gsh2Wba2vRHr4Tjg/VDf?=
 =?us-ascii?Q?S4Fy4M3isvCCL8vVC1ph7egBXnJHD3+Es5d8MbZLs2ZPjYdCQq7P9eG0D3H3?=
 =?us-ascii?Q?hvEyXiTY6JYkM2HrFNM/amFaiW2eLbwVg8leMPU7qweSeNUa1voXaOOdBnMr?=
 =?us-ascii?Q?CaSLt4NKoQh9s8UDrUNqpDiLCNotBHeK0DR+S7jFFzaar3Mi66azC6Qchz7N?=
 =?us-ascii?Q?XaLusQHtAbv5/8KHwu1jlyOsmGeiuOoMQ9pyZm/LUf3tlJ8TBADCbfKPsZft?=
 =?us-ascii?Q?WnCl7aCW0pxczxe3lneJREN9ZUe+hbIxdo+OFToj17OHrlPTJqOVIUWlUh71?=
 =?us-ascii?Q?oRMVZnI3PA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: W6XPQThZuSQ8dSl/+lW2UJr7MQ3Q1qJtfw5b/Vr9L+NMWeR+wHqW8jdiLqs5/JU1gUueUzEYh/rMdwKjhPu6BXikW9rl9JSx/mSnQJ4dpgZ0mf/CXR0TyiwKLXh83IgetMYw0xPd7QiRg3lGJbTU48Ls8KVHoC5D7YsDt8/SNouXc4cPyuIIndRUFmyj+wHQfxl0XC8Qzyn5h28x3gJTM9+HjUby+WC0uPxuFnB4wdG8tRjERGBSbPlRLVHNt5wHlsegg6/GrfzPqTD0v1QGwR6D6AQ/RoSRlEt4YUT8Ncsolux1Lz3VlbD0eReMKHOx6fztpJJNuZeb3wT9PUmTVw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3c0a1fb-5740-4b36-8e87-08dec6c822f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2026 08:13:21.5501 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TaWPpKnxLRJa1/ARhZ5o6549fNpWd8yiQwVi5sOzOFXz76uEsxMzKbAkcnuGx1fbbaTK0yc1WliHR/hVQ1vr8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5942
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

> Subject: Re: [PATCH 1/3] net/iavf: downgrade opcode 0 ARQ log to debug
>=20
> On Mon, Jun 08, 2026 at 02:55:16PM +0000, Ciara Loftus wrote:
> > From: Talluri Chaitanyababu <chaitanyababux.talluri@intel.com>
> >
> > After admin queue reinitialisation, completions from uninitialised
> > ARQ ring descriptor memory may arrive before any real PF response.
> > These carry opcode 0 (`VIRTCHNL_OP_UNKNOWN`) and trigger a WARNING
> > log on every poll iteration, flooding the log during reset recovery.
> >
> > Treat opcode 0 as a distinct case and log it at DEBUG level, while
> > retaining WARNING for genuine opcode mismatches.
> >
> > Signed-off-by: Talluri Chaitanyababu <chaitanyababux.talluri@intel.com>
> > ---
> >  drivers/net/intel/iavf/iavf_vchnl.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> >
> Should this be backported as a bugfix?

The issue has been present since the driver was added, but only
triggered in practise more recently with the addition of the reset
logic.
I think this tag can be added:

Fixes: 2d23ed74c079 ("net/iavf: enable iavf PMD")
Cc: stable@dpdk.org

Let me know if you need a respin.
