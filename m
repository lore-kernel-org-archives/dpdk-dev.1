Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78791EA795E
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Feb 2026 09:59:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B041D4029A;
	Fri,  6 Feb 2026 10:59:17 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 6069540293
 for <dev@dpdk.org>; Fri,  6 Feb 2026 10:59:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770371956; x=1801907956;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=xqhig16/TfpuoAPbL33mqVj/HThpgestkbS4f8WBxIs=;
 b=bRo+XqwvO/crykEQErHFt1UYHfp6huN/V6PanOB+SwQhCSCUW021GW3m
 +8GV9FFywJz+VETjx4U9K8W7WGqlxt6OlG+B6gc134TyUjIBwea9JUKcN
 qw50yB6Cmtd5fO9vWgisocSo1CepH9/RMh/8rkvm/Tl5XEW6xvAUC3ILK
 mDzwChHgbyl7R8WOihssuEle8UVHNDCvlisQ3pxZxtikkW1zMzMvd+evX
 bHgsBTasKPIt1r8boa2SgItQWoHycnsE4xBc+/6QFY8CSDwYnFKNeK0tT
 6DpSyNZoLHYHSJNbqNVUpcyHlZSl4EZI3n9k2pRDFNJNMSGIvAHewc/wi A==;
X-CSE-ConnectionGUID: PHT9mML9S2uy6+rKoNETxw==
X-CSE-MsgGUID: BqQM8zS/RG6dXbYwGKkuKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="59150212"
X-IronPort-AV: E=Sophos;i="6.21,276,1763452800"; d="scan'208";a="59150212"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2026 01:59:14 -0800
X-CSE-ConnectionGUID: m1oP3pAdSmeLH7+RJs8uCg==
X-CSE-MsgGUID: 2KcDgNsSSbSsoLy/u9lXVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,276,1763452800"; d="scan'208";a="215798539"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2026 01:59:15 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 6 Feb 2026 01:59:13 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 6 Feb 2026 01:59:13 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.63) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 6 Feb 2026 01:59:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QYOdww5+4CUL/cCJAZS+mSx4Pw3FyOV65w07NoaFh6m6tE0y9/HQQ3nHgx9PsBVt3KAq+yIa4MSZwE28kVYHMLHxvskjSLGQWgUx03G7t/wOhPPYzv7jM9rn2zwgPzvYGB4KCpS7dAqz8czSMcDrwJyTU6ldYEAl+oR8vIPYNaWayu4KdhDQV2xfAFjGEj2SFWmIsDTh6FZqT1/ouzpPBDOiwA+59x8TUda+/HZh5xl3TYJnNaFe05vfMdsBVL7FJ+s9myCrXSYHFdXAog5DZpYNHmom1SxQRp6qq+7laDtuyfdgJ8hhIdD/0BTXoSAuCY6R3LAm1bxgyOZ07pEJCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PBbP4YApkgZoboixsa4HX2KsKF27YhcaFa5cUpkfGrs=;
 b=EfxzJKoE5lNyechfHuSt6reyBeUUNifo87xGcaoBARxw7/cGF0giYBlHqOl3Efqfy/HEnFdL34Y14B0ZKPgxtAQZdyOveDIZqpZ1WfY5CWG3Va89smFlmwOjjcEJElDatsrA7dBX+1XxgH0h6mWgG5BNMTQ8gEJsW4Em0OMhvBFs4/Xj70r8WS+pSi4LVU7vSKvGFg06cR1gtMrDnW5QtPNCQPzuLTP7feT0znCJ5fWuYP0Wn4mQxmGIz0+mqTSPbhG2qShpvkVWIKVPSgzBJeUveqBQfpysvE8Q96KR6XOz1+CHNpVOC4c11Xn6G9OU7Pkfdgd4gwVpxZDwfymlLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f32) by DM3PR11MB8759.namprd11.prod.outlook.com
 (2603:10b6:8:1ac::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Fri, 6 Feb
 2026 09:59:08 +0000
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::5f81:9e50:1761:ca54]) by DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::5f81:9e50:1761:ca54%7]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 09:59:08 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "Shetty, Praveen"
 <praveen.shetty@intel.com>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>, "Burakov, Anatoly"
 <anatoly.burakov@intel.com>, "Wu, Jingjing" <jingjing.wu@intel.com>
Subject: RE: [PATCH v3 02/36] net/intel: use common Tx ring structure
Thread-Topic: [PATCH v3 02/36] net/intel: use common Tx ring structure
Thread-Index: AQHckd2XyOWYS/tEakiP5SstzMAP3bV1ehRQ
Date: Fri, 6 Feb 2026 09:59:08 +0000
Message-ID: <DM3PPF7D18F34A1CC9061AD6F564DE1A8358E66A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260130114207.1126032-1-bruce.richardson@intel.com>
 <20260130114207.1126032-3-bruce.richardson@intel.com>
In-Reply-To: <20260130114207.1126032-3-bruce.richardson@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF7D18F34A1:EE_|DM3PR11MB8759:EE_
x-ms-office365-filtering-correlation-id: d4816bdf-c252-4c37-cd2e-08de65665ee2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?6NWIFgn/+aprYNv9NDW0PnPRp1D67LwR3K3Z7pr/zoAluwLjnK1yXydSToko?=
 =?us-ascii?Q?T23S0WeUQ9rwj6WqW7Iz7yPJrZZQsHn6eEJ1+oBt5w6F2plYwbNIIG21TocN?=
 =?us-ascii?Q?j9lIs7E69R0EUkvoEjIFZpOkn0YtyljRD2l/vwELjeCmEA+uJ3P20OI5t4sM?=
 =?us-ascii?Q?Flkzxmm3Gv14FI9EcITgTKBtnBlP2MFmCMVWhJwHrBeoptYgQD3S169JPRSZ?=
 =?us-ascii?Q?auSU9dzR/MzQDEsMDvkb6a1+1v6uPxEtdrML7yq41gIlxBT13zSkbmFyLL0S?=
 =?us-ascii?Q?XwbZNDbkaiwvn1tpoILPy7WZankmd9dG+hmnjVovDrjbDVxV0PQjU2SCD50n?=
 =?us-ascii?Q?538KRuAFONCApTeTM80ZRX8dxHCUpH1Thh0iclDexr5P8Twsl6Lt8OFE71Ha?=
 =?us-ascii?Q?Oy50H7p7UBI3ToLa0ZMqGGXbR9wcO7vO1NBE1f7ULH/R2k7pMbYAix2jYHW3?=
 =?us-ascii?Q?NIt5iQIkGRYBy8Xs1OyyKIBB/MTMhdGiiQ5TLK7VdSBMTvqe4kyJFVdcl7f5?=
 =?us-ascii?Q?+xInBnTaFcXfk/6RpHdpSRyJuNDA1ZikjsJwDcbNG0WQPjUYZpwFBpBVuWAC?=
 =?us-ascii?Q?dLDR+eIzL4s4tTsQijQK/Qn1f2+Rnjq6fDUO6RB2JeMb5sT2ReAmiqTURdoP?=
 =?us-ascii?Q?2sPU9pG4UCT25fC2e45woY0tgQIW71awz+duUFLcD97qSWwJPKgqcgmsLoR8?=
 =?us-ascii?Q?YPq8r54+jZ6JxSPNBPoarUi+R7nfOzVLqdqt32T5UwDeq0qodYrXgQdA8Gbz?=
 =?us-ascii?Q?Gg8ZAs25yjIJqdzjPIfR6hh16teCWFpajvtQPRNPl/1U0HaxA2rl04EPltnZ?=
 =?us-ascii?Q?v4Fi8PG43FWnBZYhMEoSJ9Oo4mYQTnT99ZkzBytfpTKBE5gOEkC1hX7FUluR?=
 =?us-ascii?Q?pDC101/sfVeN819k6l/NfpW4K6DpIkB6U65bi9LlrZiH2C4cNk5GcMYofO4g?=
 =?us-ascii?Q?gtNH3rjiEpWXvCKO78vXGp3YbgN9XKPiM9iZjFl+emHyoBDLVrLWfM3JQtxm?=
 =?us-ascii?Q?HE1JRP+aZs0TkoQy3LcQJ/RmzKiVY/k6fI72UPofk0Jj3UTaRmT9xn/W5WRK?=
 =?us-ascii?Q?IVFfeLQwaNZdUDgpfczShngMKtVfokuol1clLhESAxauyUdt/LDdVZLE+wYq?=
 =?us-ascii?Q?72hvyBf2uX0zCSxuZjTiWAS6yd8bgbCMIJjKbA6FxtdvLJJ/NyON0mkRkr4o?=
 =?us-ascii?Q?OTd2aQdMGYYvuGfh/VgZ8+gAFBt38SAytbSd/nUFDge7dit+C5wBG0nvIFkr?=
 =?us-ascii?Q?7cTwJysPv2gqKi8jwRgomnQnI2FODStcbjautlreC6FP2NwvWgGZirk+hobX?=
 =?us-ascii?Q?cC15XGwluXwKljTouwTLUR/inePwckODZbNfJerJyivfGfolYLPnkOL+OmvS?=
 =?us-ascii?Q?+oVo+ivEIkPUGyFEeB7SxGc16Q9VaK7+FoUzW3RjNYNaWs9HqDNxmzoPp7zC?=
 =?us-ascii?Q?NoZvyzPd2qHUciSvqF1ezyqj7Vpa/eq44OpvOjaHYA+FbnuxTBtYzDEtXl72?=
 =?us-ascii?Q?ZqJwKJ+JsvkyVRwa4DqVdTXJMAeW9l8wFoVvXLaQeEACdbpxs06gNADoHnii?=
 =?us-ascii?Q?4G01MI1PZPzN11GgdbAHBDkziYPiHlMmPoqyHOQdkV83k13+rQCsCMyXuP3O?=
 =?us-ascii?Q?r4oxdwx6d2/yz2XfydWQ63M=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF7D18F34A1.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?peR2O0nt2Uny/vhuJEjrQC2RmQDPVXxk75dXaoCsxBpq426C103igPYxFgtx?=
 =?us-ascii?Q?fs6uIdZDBskwyii+/5jMtd+FfJbCbk5KvLKO0Txb7uZDcIa1uqq8mum0PdTu?=
 =?us-ascii?Q?cIk09+3bJ4xnAA5KDZGepU5p9GJ74juL2mLmKABOU1KJohsajgcAt7nSw8N8?=
 =?us-ascii?Q?8FRqujh2UxSy3ZNO9EISmDOkMGIaS2RBmENmvH4XeVIv9aCruvF2eD7/KmdC?=
 =?us-ascii?Q?QGmUkZktD6LX0Rzkq6BC0P+ZUbRFYSBN0xNcbzkosiohMYkpsUqawV8YU9Zu?=
 =?us-ascii?Q?8BiztRXL+ZuRfpcLxhmRAnP4QieKTiwSsZ1jdLHF8Wnx8oMkAzfmCA+ieGgO?=
 =?us-ascii?Q?cVs1BYyKe1Ks1CUfTSdkdKp4cpLraEfvjKCXq/NeIxZF/ro7D6KmUvtn1c5A?=
 =?us-ascii?Q?4GIKPVtDV6uMe+HS9UQhLas5vJ96ZuIxMlnbsEGYZc9PUKE2VXdhZy8gpU5b?=
 =?us-ascii?Q?O28AqGagoagp8ufWy2euiF303c5h17gU6yzBQAschnurPnrVEQo399tEWYRy?=
 =?us-ascii?Q?HiAuZDjfk8Y+CwdoeFvWfI4myOEWxxGiERFFR8O73FnVI8otVILO8OiCj8Qw?=
 =?us-ascii?Q?LBOWkN+OXVWSLRvp46qK06pHDKtXo0hIr2TbDQsrfvOoH2ZtsmOAvOdelFTx?=
 =?us-ascii?Q?004C39l7metjBALLVFrxdENefl5+X5AF0VvxloFAol0SvVN3+RF36Df+Tkx8?=
 =?us-ascii?Q?6vOoRnDRRHdmYN//IYjaHVL7i1C9vs7IgCZUcq3Q9sFhgS13RohiUtCX0wRx?=
 =?us-ascii?Q?7EHUtjjziNKrdSJwF2kM+PH8lloc+M1JtvdkIRwkFUUznWIEfUcB+C6XyRQb?=
 =?us-ascii?Q?wDdSPuY9jtE9QJGZn2u2fLCod/s1hpRXfVMiPYp9vxIlS4UqMTDXA5zdfi1C?=
 =?us-ascii?Q?4KV7QIpnTtMVJPCcvndKV94BLFfvvG5PkxjUweuxB+Ltz0Bfl9FUqsG60W29?=
 =?us-ascii?Q?HrzAP4yAPF9VI+IQfTghFzWsfLVqKjUVxSSUE9k9/yi1vQ9SQ7P5uHUAQSCZ?=
 =?us-ascii?Q?IvkrU99yUQMWwdQ++Kp7F/SEEgi0tOoY1jilf4jlyHdSU3mXFs9uVZO/ci8P?=
 =?us-ascii?Q?yf658UvqThISsAnzt6paCqxxm8vQdtm8dz+x6n1sWgdfs7YP5XCHiCYKuOlI?=
 =?us-ascii?Q?mnLtYOrQhNghr/NGEAiUlpSRHdzV0lyrMMP0Z54pS7glXzJHQbRGWsLGsMr7?=
 =?us-ascii?Q?p5NrO6yb8yh2RjfUD1HinaYJbzJRqwdaQ0M8zLFs+RYCuxjvYMi61h1DBXYf?=
 =?us-ascii?Q?QDOZ5LODhTlU6gzZJPDbzxfJk2xTXglHJHmrUrHObMLq4tbjw6DpFo+vSGan?=
 =?us-ascii?Q?OwDgCIuj1BDzZM8GpBoEgueL1nlEA5WNbLubJngj0NJBrmbqF2aTV5DzOHK6?=
 =?us-ascii?Q?fqWy6eDPPiBIRfsgb/xv7PYhARMWULnEMpMa3V9HlfCDAlVZIaEEGvD3Gnjk?=
 =?us-ascii?Q?nLO/X08eAVVDclqmBZdEjwq+itDJV16cDP6PXvZxQwy0qymEv/TpdKCq1+aa?=
 =?us-ascii?Q?SGPSRbxgR25CqW3h/GpUCeavWNlABrR3WzXNXXrKQ10s9dHROtX6qsdoZfBg?=
 =?us-ascii?Q?D6tw9RXBNmxYB20CNRC2/C91cSjstAHJ+FE0K0A4PiuOLVuNbrcjAmQjxc/M?=
 =?us-ascii?Q?eJukyTyK1iYACDLTf/bGxPDS3AiXEax/GJUEFRAysI6bQ+S3wosdkWcr4ytn?=
 =?us-ascii?Q?cLXT1p9wwkVieMLvY5FQz0824e2vmqGtCcYlR/bXwmRnTD18snFHhMW93ukp?=
 =?us-ascii?Q?7Wew22XnQA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF7D18F34A1.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4816bdf-c252-4c37-cd2e-08de65665ee2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2026 09:59:08.6025 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4akKNg2TBTI72r4l/3oOXVXzR9/hdljDDt4BjCOV2zh4v1QGZAFlufB9EioFdZHRgLQ0cL9hi3nkrAVsOIrlvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8759
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

> Subject: [PATCH v3 02/36] net/intel: use common Tx ring structure
>=20
> Rather than having separate per-driver ring pointers in a union, since
> we now have a common descriptor type, we can merge all but the ixgbe
> pointer into one value.
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Acked-by: Ciara Loftus <ciara.loftus@intel.com>

> ---
>  drivers/net/intel/common/tx.h                 |  5 +--
>  drivers/net/intel/cpfl/cpfl_rxtx.c            |  2 +-
>  drivers/net/intel/i40e/i40e_fdir.c            |  6 ++--
>  drivers/net/intel/i40e/i40e_rxtx.c            | 22 ++++++------
>  .../net/intel/i40e/i40e_rxtx_vec_altivec.c    |  6 ++--
>  drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c   |  6 ++--
>  drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c |  6 ++--
>  drivers/net/intel/i40e/i40e_rxtx_vec_common.h |  2 +-
>  drivers/net/intel/i40e/i40e_rxtx_vec_neon.c   |  6 ++--
>  drivers/net/intel/iavf/iavf_rxtx.c            | 14 ++++----
>  drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c   |  6 ++--
>  drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c | 12 +++----
>  drivers/net/intel/iavf/iavf_rxtx_vec_common.h |  2 +-
>  drivers/net/intel/ice/ice_dcf_ethdev.c        |  4 +--
>  drivers/net/intel/ice/ice_rxtx.c              | 34 +++++++++----------
>  drivers/net/intel/ice/ice_rxtx_vec_avx2.c     |  6 ++--
>  drivers/net/intel/ice/ice_rxtx_vec_avx512.c   |  6 ++--
>  drivers/net/intel/ice/ice_rxtx_vec_common.h   |  2 +-
>  drivers/net/intel/idpf/idpf_common_rxtx.c     |  8 ++---
>  .../net/intel/idpf/idpf_common_rxtx_avx2.c    |  6 ++--
>  .../net/intel/idpf/idpf_common_rxtx_avx512.c  |  6 ++--
>  drivers/net/intel/idpf/idpf_rxtx.c            |  2 +-
>  drivers/net/intel/idpf/idpf_rxtx_vec_common.h |  2 +-
>  23 files changed, 84 insertions(+), 87 deletions(-)
>=20
> diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.=
h
> index d7561a2bbb..8cf63e59ab 100644
> --- a/drivers/net/intel/common/tx.h
> +++ b/drivers/net/intel/common/tx.h
> @@ -41,10 +41,7 @@ typedef void (*ice_tx_release_mbufs_t)(struct
> ci_tx_queue *txq);
>=20
>  struct ci_tx_queue {
>  	union { /* TX ring virtual address */
> -		volatile struct ci_tx_desc *i40e_tx_ring;
> -		volatile struct ci_tx_desc *iavf_tx_ring;
> -		volatile struct ci_tx_desc *ice_tx_ring;
> -		volatile struct ci_tx_desc *idpf_tx_ring;
> +		volatile struct ci_tx_desc *ci_tx_ring;
>  		volatile union ixgbe_adv_tx_desc *ixgbe_tx_ring;
>  	};
>  	volatile uint8_t *qtx_tail;               /* register address of tail *=
/
> diff --git a/drivers/net/intel/cpfl/cpfl_rxtx.c
> b/drivers/net/intel/cpfl/cpfl_rxtx.c
> index 78bc3e9b49..bc5bec65f0 100644
> --- a/drivers/net/intel/cpfl/cpfl_rxtx.c
> +++ b/drivers/net/intel/cpfl/cpfl_rxtx.c
> @@ -606,7 +606,7 @@ cpfl_tx_queue_setup(struct rte_eth_dev *dev,
> uint16_t queue_idx,
>  	}
>=20
>  	if (!is_splitq) {
> -		txq->idpf_tx_ring =3D mz->addr;
> +		txq->ci_tx_ring =3D mz->addr;
>  		idpf_qc_single_tx_queue_reset(txq);
>  	} else {
>  		txq->desc_ring =3D mz->addr;
> diff --git a/drivers/net/intel/i40e/i40e_fdir.c
> b/drivers/net/intel/i40e/i40e_fdir.c
> index 605df73c9e..8a01aec0e2 100644
> --- a/drivers/net/intel/i40e/i40e_fdir.c
> +++ b/drivers/net/intel/i40e/i40e_fdir.c
> @@ -1380,7 +1380,7 @@ i40e_find_available_buffer(struct rte_eth_dev
> *dev)
>  		volatile struct ci_tx_desc *tmp_txdp;
>=20
>  		tmp_tail =3D txq->tx_tail;
> -		tmp_txdp =3D &txq->i40e_tx_ring[tmp_tail + 1];
> +		tmp_txdp =3D &txq->ci_tx_ring[tmp_tail + 1];
>=20
>  		do {
>  			if ((tmp_txdp->cmd_type_offset_bsz &
> @@ -1637,7 +1637,7 @@ i40e_flow_fdir_filter_programming(struct i40e_pf
> *pf,
>=20
>  	PMD_DRV_LOG(INFO, "filling filter programming descriptor.");
>  	fdirdp =3D (volatile struct i40e_filter_program_desc *)
> -				(&txq->i40e_tx_ring[txq->tx_tail]);
> +				(&txq->ci_tx_ring[txq->tx_tail]);
>=20
>  	fdirdp->qindex_flex_ptype_vsi =3D
>  			rte_cpu_to_le_32((fdir_action->rx_queue <<
> @@ -1707,7 +1707,7 @@ i40e_flow_fdir_filter_programming(struct i40e_pf
> *pf,
>  	fdirdp->fd_id =3D rte_cpu_to_le_32(filter->soft_id);
>=20
>  	PMD_DRV_LOG(INFO, "filling transmit descriptor.");
> -	txdp =3D &txq->i40e_tx_ring[txq->tx_tail + 1];
> +	txdp =3D &txq->ci_tx_ring[txq->tx_tail + 1];
>  	txdp->buffer_addr =3D rte_cpu_to_le_64(pf->fdir.dma_addr[txq->tx_tail
> >> 1]);
>=20
>  	td_cmd =3D I40E_TX_DESC_CMD_EOP |
> diff --git a/drivers/net/intel/i40e/i40e_rxtx.c
> b/drivers/net/intel/i40e/i40e_rxtx.c
> index 92d49ccb79..210fc0201e 100644
> --- a/drivers/net/intel/i40e/i40e_rxtx.c
> +++ b/drivers/net/intel/i40e/i40e_rxtx.c
> @@ -388,7 +388,7 @@ static inline int
>  i40e_xmit_cleanup(struct ci_tx_queue *txq)
>  {
>  	struct ci_tx_entry *sw_ring =3D txq->sw_ring;
> -	volatile struct ci_tx_desc *txd =3D txq->i40e_tx_ring;
> +	volatile struct ci_tx_desc *txd =3D txq->ci_tx_ring;
>  	uint16_t last_desc_cleaned =3D txq->last_desc_cleaned;
>  	uint16_t nb_tx_desc =3D txq->nb_tx_desc;
>  	uint16_t desc_to_clean_to;
> @@ -1112,7 +1112,7 @@ i40e_xmit_pkts(void *tx_queue, struct rte_mbuf
> **tx_pkts, uint16_t nb_pkts)
>=20
>  	txq =3D tx_queue;
>  	sw_ring =3D txq->sw_ring;
> -	txr =3D txq->i40e_tx_ring;
> +	txr =3D txq->ci_tx_ring;
>  	tx_id =3D txq->tx_tail;
>  	txe =3D &sw_ring[tx_id];
>=20
> @@ -1347,7 +1347,7 @@ i40e_tx_free_bufs(struct ci_tx_queue *txq)
>  	const uint16_t k =3D RTE_ALIGN_FLOOR(tx_rs_thresh,
> I40E_TX_MAX_FREE_BUF_SZ);
>  	const uint16_t m =3D tx_rs_thresh % I40E_TX_MAX_FREE_BUF_SZ;
>=20
> -	if ((txq->i40e_tx_ring[txq->tx_next_dd].cmd_type_offset_bsz &
> +	if ((txq->ci_tx_ring[txq->tx_next_dd].cmd_type_offset_bsz &
>  			rte_cpu_to_le_64(I40E_TXD_QW1_DTYPE_MASK)) !=3D
>=20
> 	rte_cpu_to_le_64(I40E_TX_DESC_DTYPE_DESC_DONE))
>  		return 0;
> @@ -1431,7 +1431,7 @@ i40e_tx_fill_hw_ring(struct ci_tx_queue *txq,
>  		     struct rte_mbuf **pkts,
>  		     uint16_t nb_pkts)
>  {
> -	volatile struct ci_tx_desc *txdp =3D &txq->i40e_tx_ring[txq->tx_tail];
> +	volatile struct ci_tx_desc *txdp =3D &txq->ci_tx_ring[txq->tx_tail];
>  	struct ci_tx_entry *txep =3D &txq->sw_ring[txq->tx_tail];
>  	const int N_PER_LOOP =3D 4;
>  	const int N_PER_LOOP_MASK =3D N_PER_LOOP - 1;
> @@ -1459,7 +1459,7 @@ tx_xmit_pkts(struct ci_tx_queue *txq,
>  	     struct rte_mbuf **tx_pkts,
>  	     uint16_t nb_pkts)
>  {
> -	volatile struct ci_tx_desc *txr =3D txq->i40e_tx_ring;
> +	volatile struct ci_tx_desc *txr =3D txq->ci_tx_ring;
>  	uint16_t n =3D 0;
>=20
>  	/**
> @@ -2421,7 +2421,7 @@ i40e_dev_tx_descriptor_status(void *tx_queue,
> uint16_t offset)
>  			desc -=3D txq->nb_tx_desc;
>  	}
>=20
> -	status =3D &txq->i40e_tx_ring[desc].cmd_type_offset_bsz;
> +	status =3D &txq->ci_tx_ring[desc].cmd_type_offset_bsz;
>  	mask =3D rte_le_to_cpu_64(I40E_TXD_QW1_DTYPE_MASK);
>  	expect =3D rte_cpu_to_le_64(
>  		I40E_TX_DESC_DTYPE_DESC_DONE <<
> I40E_TXD_QW1_DTYPE_SHIFT);
> @@ -2618,7 +2618,7 @@ i40e_dev_tx_queue_setup(struct rte_eth_dev
> *dev,
>  	/* Allocate TX hardware ring descriptors. */
>  	ring_size =3D sizeof(struct ci_tx_desc) * I40E_MAX_RING_DESC;
>  	ring_size =3D RTE_ALIGN(ring_size, I40E_DMA_MEM_ALIGN);
> -	tz =3D rte_eth_dma_zone_reserve(dev, "i40e_tx_ring", queue_idx,
> +	tz =3D rte_eth_dma_zone_reserve(dev, "ci_tx_ring", queue_idx,
>  			      ring_size, I40E_RING_BASE_ALIGN, socket_id);
>  	if (!tz) {
>  		i40e_tx_queue_release(txq);
> @@ -2640,7 +2640,7 @@ i40e_dev_tx_queue_setup(struct rte_eth_dev
> *dev,
>  	txq->tx_deferred_start =3D tx_conf->tx_deferred_start;
>=20
>  	txq->tx_ring_dma =3D tz->iova;
> -	txq->i40e_tx_ring =3D (struct ci_tx_desc *)tz->addr;
> +	txq->ci_tx_ring =3D (struct ci_tx_desc *)tz->addr;
>=20
>  	/* Allocate software ring */
>  	txq->sw_ring =3D
> @@ -2915,11 +2915,11 @@ i40e_reset_tx_queue(struct ci_tx_queue *txq)
>  	txe =3D txq->sw_ring;
>  	size =3D sizeof(struct ci_tx_desc) * txq->nb_tx_desc;
>  	for (i =3D 0; i < size; i++)
> -		((volatile char *)txq->i40e_tx_ring)[i] =3D 0;
> +		((volatile char *)txq->ci_tx_ring)[i] =3D 0;
>=20
>  	prev =3D (uint16_t)(txq->nb_tx_desc - 1);
>  	for (i =3D 0; i < txq->nb_tx_desc; i++) {
> -		volatile struct ci_tx_desc *txd =3D &txq->i40e_tx_ring[i];
> +		volatile struct ci_tx_desc *txd =3D &txq->ci_tx_ring[i];
>=20
>  		txd->cmd_type_offset_bsz =3D
>=20
> 	rte_cpu_to_le_64(I40E_TX_DESC_DTYPE_DESC_DONE);
> @@ -3240,7 +3240,7 @@ i40e_fdir_setup_tx_resources(struct i40e_pf *pf)
>  	txq->i40e_vsi =3D pf->fdir.fdir_vsi;
>=20
>  	txq->tx_ring_dma =3D tz->iova;
> -	txq->i40e_tx_ring =3D (struct ci_tx_desc *)tz->addr;
> +	txq->ci_tx_ring =3D (struct ci_tx_desc *)tz->addr;
>=20
>  	/*
>  	 * don't need to allocate software ring and reset for the fdir
> diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_altivec.c
> b/drivers/net/intel/i40e/i40e_rxtx_vec_altivec.c
> index ef5b252898..81e9e2bc0b 100644
> --- a/drivers/net/intel/i40e/i40e_rxtx_vec_altivec.c
> +++ b/drivers/net/intel/i40e/i40e_rxtx_vec_altivec.c
> @@ -489,7 +489,7 @@ i40e_xmit_fixed_burst_vec(void *tx_queue, struct
> rte_mbuf **tx_pkts,
>  		return 0;
>=20
>  	tx_id =3D txq->tx_tail;
> -	txdp =3D &txq->i40e_tx_ring[tx_id];
> +	txdp =3D &txq->ci_tx_ring[tx_id];
>  	txep =3D &txq->sw_ring_vec[tx_id];
>=20
>  	txq->nb_tx_free =3D (uint16_t)(txq->nb_tx_free - nb_pkts);
> @@ -509,7 +509,7 @@ i40e_xmit_fixed_burst_vec(void *tx_queue, struct
> rte_mbuf **tx_pkts,
>  		txq->tx_next_rs =3D (uint16_t)(txq->tx_rs_thresh - 1);
>=20
>  		/* avoid reach the end of ring */
> -		txdp =3D &txq->i40e_tx_ring[tx_id];
> +		txdp =3D &txq->ci_tx_ring[tx_id];
>  		txep =3D &txq->sw_ring_vec[tx_id];
>  	}
>=20
> @@ -519,7 +519,7 @@ i40e_xmit_fixed_burst_vec(void *tx_queue, struct
> rte_mbuf **tx_pkts,
>=20
>  	tx_id =3D (uint16_t)(tx_id + nb_commit);
>  	if (tx_id > txq->tx_next_rs) {
> -		txq->i40e_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=3D
> +		txq->ci_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=3D
>=20
> 	rte_cpu_to_le_64(((uint64_t)I40E_TX_DESC_CMD_RS) <<
>=20
> 	I40E_TXD_QW1_CMD_SHIFT);
>  		txq->tx_next_rs =3D
> diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c
> b/drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c
> index 137c1f9765..f054bd41bf 100644
> --- a/drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c
> +++ b/drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c
> @@ -753,7 +753,7 @@ i40e_xmit_fixed_burst_vec_avx2(void *tx_queue,
> struct rte_mbuf **tx_pkts,
>  		return 0;
>=20
>  	tx_id =3D txq->tx_tail;
> -	txdp =3D &txq->i40e_tx_ring[tx_id];
> +	txdp =3D &txq->ci_tx_ring[tx_id];
>  	txep =3D &txq->sw_ring_vec[tx_id];
>=20
>  	txq->nb_tx_free =3D (uint16_t)(txq->nb_tx_free - nb_pkts);
> @@ -774,7 +774,7 @@ i40e_xmit_fixed_burst_vec_avx2(void *tx_queue,
> struct rte_mbuf **tx_pkts,
>  		txq->tx_next_rs =3D (uint16_t)(txq->tx_rs_thresh - 1);
>=20
>  		/* avoid reach the end of ring */
> -		txdp =3D &txq->i40e_tx_ring[tx_id];
> +		txdp =3D &txq->ci_tx_ring[tx_id];
>  		txep =3D &txq->sw_ring_vec[tx_id];
>  	}
>=20
> @@ -784,7 +784,7 @@ i40e_xmit_fixed_burst_vec_avx2(void *tx_queue,
> struct rte_mbuf **tx_pkts,
>=20
>  	tx_id =3D (uint16_t)(tx_id + nb_commit);
>  	if (tx_id > txq->tx_next_rs) {
> -		txq->i40e_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=3D
> +		txq->ci_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=3D
>=20
> 	rte_cpu_to_le_64(((uint64_t)I40E_TX_DESC_CMD_RS) <<
>=20
> 	I40E_TXD_QW1_CMD_SHIFT);
>  		txq->tx_next_rs =3D
> diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c
> b/drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c
> index 6971488750..9a967faeee 100644
> --- a/drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c
> +++ b/drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c
> @@ -821,7 +821,7 @@ i40e_xmit_fixed_burst_vec_avx512(void *tx_queue,
> struct rte_mbuf **tx_pkts,
>  		return 0;
>=20
>  	tx_id =3D txq->tx_tail;
> -	txdp =3D &txq->i40e_tx_ring[tx_id];
> +	txdp =3D &txq->ci_tx_ring[tx_id];
>  	txep =3D (void *)txq->sw_ring;
>  	txep +=3D tx_id;
>=20
> @@ -843,7 +843,7 @@ i40e_xmit_fixed_burst_vec_avx512(void *tx_queue,
> struct rte_mbuf **tx_pkts,
>  		txq->tx_next_rs =3D (uint16_t)(txq->tx_rs_thresh - 1);
>=20
>  		/* avoid reach the end of ring */
> -		txdp =3D txq->i40e_tx_ring;
> +		txdp =3D txq->ci_tx_ring;
>  		txep =3D (void *)txq->sw_ring;
>  	}
>=20
> @@ -853,7 +853,7 @@ i40e_xmit_fixed_burst_vec_avx512(void *tx_queue,
> struct rte_mbuf **tx_pkts,
>=20
>  	tx_id =3D (uint16_t)(tx_id + nb_commit);
>  	if (tx_id > txq->tx_next_rs) {
> -		txq->i40e_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=3D
> +		txq->ci_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=3D
>=20
> 	rte_cpu_to_le_64(((uint64_t)I40E_TX_DESC_CMD_RS) <<
>=20
> 	I40E_TXD_QW1_CMD_SHIFT);
>  		txq->tx_next_rs =3D
> diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_common.h
> b/drivers/net/intel/i40e/i40e_rxtx_vec_common.h
> index 14651f2f06..1fd7fc75bf 100644
> --- a/drivers/net/intel/i40e/i40e_rxtx_vec_common.h
> +++ b/drivers/net/intel/i40e/i40e_rxtx_vec_common.h
> @@ -15,7 +15,7 @@
>  static inline int
>  i40e_tx_desc_done(struct ci_tx_queue *txq, uint16_t idx)
>  {
> -	return (txq->i40e_tx_ring[idx].cmd_type_offset_bsz &
> +	return (txq->ci_tx_ring[idx].cmd_type_offset_bsz &
>  			rte_cpu_to_le_64(I40E_TXD_QW1_DTYPE_MASK)) =3D=3D
>=20
> 	rte_cpu_to_le_64(I40E_TX_DESC_DTYPE_DESC_DONE);
>  }
> diff --git a/drivers/net/intel/i40e/i40e_rxtx_vec_neon.c
> b/drivers/net/intel/i40e/i40e_rxtx_vec_neon.c
> index 6404b70c56..0b95152232 100644
> --- a/drivers/net/intel/i40e/i40e_rxtx_vec_neon.c
> +++ b/drivers/net/intel/i40e/i40e_rxtx_vec_neon.c
> @@ -638,7 +638,7 @@ i40e_xmit_fixed_burst_vec(void *__rte_restrict
> tx_queue,
>  		return 0;
>=20
>  	tx_id =3D txq->tx_tail;
> -	txdp =3D &txq->i40e_tx_ring[tx_id];
> +	txdp =3D &txq->ci_tx_ring[tx_id];
>  	txep =3D &txq->sw_ring_vec[tx_id];
>=20
>  	txq->nb_tx_free =3D (uint16_t)(txq->nb_tx_free - nb_pkts);
> @@ -658,7 +658,7 @@ i40e_xmit_fixed_burst_vec(void *__rte_restrict
> tx_queue,
>  		txq->tx_next_rs =3D (uint16_t)(txq->tx_rs_thresh - 1);
>=20
>  		/* avoid reach the end of ring */
> -		txdp =3D &txq->i40e_tx_ring[tx_id];
> +		txdp =3D &txq->ci_tx_ring[tx_id];
>  		txep =3D &txq->sw_ring_vec[tx_id];
>  	}
>=20
> @@ -668,7 +668,7 @@ i40e_xmit_fixed_burst_vec(void *__rte_restrict
> tx_queue,
>=20
>  	tx_id =3D (uint16_t)(tx_id + nb_commit);
>  	if (tx_id > txq->tx_next_rs) {
> -		txq->i40e_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=3D
> +		txq->ci_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=3D
>=20
> 	rte_cpu_to_le_64(((uint64_t)I40E_TX_DESC_CMD_RS) <<
>=20
> 	I40E_TXD_QW1_CMD_SHIFT);
>  		txq->tx_next_rs =3D
> diff --git a/drivers/net/intel/iavf/iavf_rxtx.c
> b/drivers/net/intel/iavf/iavf_rxtx.c
> index e4421a9932..807bc92a45 100644
> --- a/drivers/net/intel/iavf/iavf_rxtx.c
> +++ b/drivers/net/intel/iavf/iavf_rxtx.c
> @@ -269,11 +269,11 @@ reset_tx_queue(struct ci_tx_queue *txq)
>  	txe =3D txq->sw_ring;
>  	size =3D sizeof(struct ci_tx_desc) * txq->nb_tx_desc;
>  	for (i =3D 0; i < size; i++)
> -		((volatile char *)txq->iavf_tx_ring)[i] =3D 0;
> +		((volatile char *)txq->ci_tx_ring)[i] =3D 0;
>=20
>  	prev =3D (uint16_t)(txq->nb_tx_desc - 1);
>  	for (i =3D 0; i < txq->nb_tx_desc; i++) {
> -		txq->iavf_tx_ring[i].cmd_type_offset_bsz =3D
> +		txq->ci_tx_ring[i].cmd_type_offset_bsz =3D
>=20
> 	rte_cpu_to_le_64(IAVF_TX_DESC_DTYPE_DESC_DONE);
>  		txe[i].mbuf =3D  NULL;
>  		txe[i].last_id =3D i;
> @@ -829,7 +829,7 @@ iavf_dev_tx_queue_setup(struct rte_eth_dev *dev,
>  	/* Allocate TX hardware ring descriptors. */
>  	ring_size =3D sizeof(struct ci_tx_desc) * IAVF_MAX_RING_DESC;
>  	ring_size =3D RTE_ALIGN(ring_size, IAVF_DMA_MEM_ALIGN);
> -	mz =3D rte_eth_dma_zone_reserve(dev, "iavf_tx_ring", queue_idx,
> +	mz =3D rte_eth_dma_zone_reserve(dev, "ci_tx_ring", queue_idx,
>  				      ring_size, IAVF_RING_BASE_ALIGN,
>  				      socket_id);
>  	if (!mz) {
> @@ -839,7 +839,7 @@ iavf_dev_tx_queue_setup(struct rte_eth_dev *dev,
>  		return -ENOMEM;
>  	}
>  	txq->tx_ring_dma =3D mz->iova;
> -	txq->iavf_tx_ring =3D (struct ci_tx_desc *)mz->addr;
> +	txq->ci_tx_ring =3D (struct ci_tx_desc *)mz->addr;
>=20
>  	txq->mz =3D mz;
>  	reset_tx_queue(txq);
> @@ -2333,7 +2333,7 @@ iavf_xmit_cleanup(struct ci_tx_queue *txq)
>  	uint16_t desc_to_clean_to;
>  	uint16_t nb_tx_to_clean;
>=20
> -	volatile struct ci_tx_desc *txd =3D txq->iavf_tx_ring;
> +	volatile struct ci_tx_desc *txd =3D txq->ci_tx_ring;
>=20
>  	desc_to_clean_to =3D (uint16_t)(last_desc_cleaned + txq->tx_rs_thresh);
>  	if (desc_to_clean_to >=3D nb_tx_desc)
> @@ -2756,7 +2756,7 @@ uint16_t
>  iavf_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pk=
ts)
>  {
>  	struct ci_tx_queue *txq =3D tx_queue;
> -	volatile struct ci_tx_desc *txr =3D txq->iavf_tx_ring;
> +	volatile struct ci_tx_desc *txr =3D txq->ci_tx_ring;
>  	struct ci_tx_entry *txe_ring =3D txq->sw_ring;
>  	struct ci_tx_entry *txe, *txn;
>  	struct rte_mbuf *mb, *mb_seg;
> @@ -4462,7 +4462,7 @@ iavf_dev_tx_desc_status(void *tx_queue, uint16_t
> offset)
>  			desc -=3D txq->nb_tx_desc;
>  	}
>=20
> -	status =3D &txq->iavf_tx_ring[desc].cmd_type_offset_bsz;
> +	status =3D &txq->ci_tx_ring[desc].cmd_type_offset_bsz;
>  	mask =3D rte_le_to_cpu_64(IAVF_TXD_QW1_DTYPE_MASK);
>  	expect =3D rte_cpu_to_le_64(
>  		 IAVF_TX_DESC_DTYPE_DESC_DONE <<
> IAVF_TXD_QW1_DTYPE_SHIFT);
> diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
> b/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
> index 5b62d51cf7..89ce841b9e 100644
> --- a/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
> +++ b/drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c
> @@ -1729,7 +1729,7 @@ iavf_xmit_fixed_burst_vec_avx2(void *tx_queue,
> struct rte_mbuf **tx_pkts,
>  	nb_commit =3D nb_pkts;
>=20
>  	tx_id =3D txq->tx_tail;
> -	txdp =3D &txq->iavf_tx_ring[tx_id];
> +	txdp =3D &txq->ci_tx_ring[tx_id];
>  	txep =3D &txq->sw_ring_vec[tx_id];
>=20
>  	txq->nb_tx_free =3D (uint16_t)(txq->nb_tx_free - nb_pkts);
> @@ -1750,7 +1750,7 @@ iavf_xmit_fixed_burst_vec_avx2(void *tx_queue,
> struct rte_mbuf **tx_pkts,
>  		txq->tx_next_rs =3D (uint16_t)(txq->tx_rs_thresh - 1);
>=20
>  		/* avoid reach the end of ring */
> -		txdp =3D &txq->iavf_tx_ring[tx_id];
> +		txdp =3D &txq->ci_tx_ring[tx_id];
>  		txep =3D &txq->sw_ring_vec[tx_id];
>  	}
>=20
> @@ -1760,7 +1760,7 @@ iavf_xmit_fixed_burst_vec_avx2(void *tx_queue,
> struct rte_mbuf **tx_pkts,
>=20
>  	tx_id =3D (uint16_t)(tx_id + nb_commit);
>  	if (tx_id > txq->tx_next_rs) {
> -		txq->iavf_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=3D
> +		txq->ci_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=3D
>=20
> 	rte_cpu_to_le_64(((uint64_t)IAVF_TX_DESC_CMD_RS) <<
>  					 IAVF_TXD_QW1_CMD_SHIFT);
>  		txq->tx_next_rs =3D
> diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
> b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
> index d79d96c7b7..ad1b0b90cd 100644
> --- a/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
> +++ b/drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c
> @@ -2219,7 +2219,7 @@ iavf_xmit_fixed_burst_vec_avx512(void
> *tx_queue, struct rte_mbuf **tx_pkts,
>  	nb_commit =3D nb_pkts;
>=20
>  	tx_id =3D txq->tx_tail;
> -	txdp =3D &txq->iavf_tx_ring[tx_id];
> +	txdp =3D &txq->ci_tx_ring[tx_id];
>  	txep =3D (void *)txq->sw_ring;
>  	txep +=3D tx_id;
>=20
> @@ -2241,7 +2241,7 @@ iavf_xmit_fixed_burst_vec_avx512(void
> *tx_queue, struct rte_mbuf **tx_pkts,
>  		txq->tx_next_rs =3D (uint16_t)(txq->tx_rs_thresh - 1);
>=20
>  		/* avoid reach the end of ring */
> -		txdp =3D &txq->iavf_tx_ring[tx_id];
> +		txdp =3D &txq->ci_tx_ring[tx_id];
>  		txep =3D (void *)txq->sw_ring;
>  		txep +=3D tx_id;
>  	}
> @@ -2252,7 +2252,7 @@ iavf_xmit_fixed_burst_vec_avx512(void
> *tx_queue, struct rte_mbuf **tx_pkts,
>=20
>  	tx_id =3D (uint16_t)(tx_id + nb_commit);
>  	if (tx_id > txq->tx_next_rs) {
> -		txq->iavf_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=3D
> +		txq->ci_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=3D
>=20
> 	rte_cpu_to_le_64(((uint64_t)IAVF_TX_DESC_CMD_RS) <<
>  					 IAVF_TXD_QW1_CMD_SHIFT);
>  		txq->tx_next_rs =3D
> @@ -2288,7 +2288,7 @@ iavf_xmit_fixed_burst_vec_avx512_ctx(void
> *tx_queue, struct rte_mbuf **tx_pkts,
>=20
>  	nb_pkts =3D nb_commit >> 1;
>  	tx_id =3D txq->tx_tail;
> -	txdp =3D &txq->iavf_tx_ring[tx_id];
> +	txdp =3D &txq->ci_tx_ring[tx_id];
>  	txep =3D (void *)txq->sw_ring;
>  	txep +=3D (tx_id >> 1);
>=20
> @@ -2309,7 +2309,7 @@ iavf_xmit_fixed_burst_vec_avx512_ctx(void
> *tx_queue, struct rte_mbuf **tx_pkts,
>  		txq->tx_next_rs =3D (uint16_t)(txq->tx_rs_thresh - 1);
>  		tx_id =3D 0;
>  		/* avoid reach the end of ring */
> -		txdp =3D txq->iavf_tx_ring;
> +		txdp =3D txq->ci_tx_ring;
>  		txep =3D (void *)txq->sw_ring;
>  	}
>=20
> @@ -2320,7 +2320,7 @@ iavf_xmit_fixed_burst_vec_avx512_ctx(void
> *tx_queue, struct rte_mbuf **tx_pkts,
>  	tx_id =3D (uint16_t)(tx_id + nb_commit);
>=20
>  	if (tx_id > txq->tx_next_rs) {
> -		txq->iavf_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=3D
> +		txq->ci_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=3D
>=20
> 	rte_cpu_to_le_64(((uint64_t)IAVF_TX_DESC_CMD_RS) <<
>  					 IAVF_TXD_QW1_CMD_SHIFT);
>  		txq->tx_next_rs =3D
> diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
> b/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
> index f1ea57034f..1832b76f89 100644
> --- a/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
> +++ b/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
> @@ -14,7 +14,7 @@
>  static inline int
>  iavf_tx_desc_done(struct ci_tx_queue *txq, uint16_t idx)
>  {
> -	return (txq->iavf_tx_ring[idx].cmd_type_offset_bsz &
> +	return (txq->ci_tx_ring[idx].cmd_type_offset_bsz &
>  			rte_cpu_to_le_64(IAVF_TXD_QW1_DTYPE_MASK)) =3D=3D
>=20
> 	rte_cpu_to_le_64(IAVF_TX_DESC_DTYPE_DESC_DONE);
>  }
> diff --git a/drivers/net/intel/ice/ice_dcf_ethdev.c
> b/drivers/net/intel/ice/ice_dcf_ethdev.c
> index ab1d499cef..5f537b4c12 100644
> --- a/drivers/net/intel/ice/ice_dcf_ethdev.c
> +++ b/drivers/net/intel/ice/ice_dcf_ethdev.c
> @@ -401,11 +401,11 @@ reset_tx_queue(struct ci_tx_queue *txq)
>  	txe =3D txq->sw_ring;
>  	size =3D sizeof(struct ci_tx_desc) * txq->nb_tx_desc;
>  	for (i =3D 0; i < size; i++)
> -		((volatile char *)txq->ice_tx_ring)[i] =3D 0;
> +		((volatile char *)txq->ci_tx_ring)[i] =3D 0;
>=20
>  	prev =3D (uint16_t)(txq->nb_tx_desc - 1);
>  	for (i =3D 0; i < txq->nb_tx_desc; i++) {
> -		txq->ice_tx_ring[i].cmd_type_offset_bsz =3D
> +		txq->ci_tx_ring[i].cmd_type_offset_bsz =3D
>=20
> 	rte_cpu_to_le_64(IAVF_TX_DESC_DTYPE_DESC_DONE);
>  		txe[i].mbuf =3D  NULL;
>  		txe[i].last_id =3D i;
> diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice=
_rxtx.c
> index 74b80e7df3..e3ffbdb587 100644
> --- a/drivers/net/intel/ice/ice_rxtx.c
> +++ b/drivers/net/intel/ice/ice_rxtx.c
> @@ -1117,11 +1117,11 @@ ice_reset_tx_queue(struct ci_tx_queue *txq)
>  	txe =3D txq->sw_ring;
>  	size =3D sizeof(struct ci_tx_desc) * txq->nb_tx_desc;
>  	for (i =3D 0; i < size; i++)
> -		((volatile char *)txq->ice_tx_ring)[i] =3D 0;
> +		((volatile char *)txq->ci_tx_ring)[i] =3D 0;
>=20
>  	prev =3D (uint16_t)(txq->nb_tx_desc - 1);
>  	for (i =3D 0; i < txq->nb_tx_desc; i++) {
> -		volatile struct ci_tx_desc *txd =3D &txq->ice_tx_ring[i];
> +		volatile struct ci_tx_desc *txd =3D &txq->ci_tx_ring[i];
>=20
>  		txd->cmd_type_offset_bsz =3D
>  			rte_cpu_to_le_64(ICE_TX_DESC_DTYPE_DESC_DONE);
> @@ -1625,7 +1625,7 @@ ice_tx_queue_setup(struct rte_eth_dev *dev,
>  	/* Allocate TX hardware ring descriptors. */
>  	ring_size =3D sizeof(struct ci_tx_desc) *
> ICE_MAX_NUM_DESC_BY_MAC(hw);
>  	ring_size =3D RTE_ALIGN(ring_size, ICE_DMA_MEM_ALIGN);
> -	tz =3D rte_eth_dma_zone_reserve(dev, "ice_tx_ring", queue_idx,
> +	tz =3D rte_eth_dma_zone_reserve(dev, "ci_tx_ring", queue_idx,
>  				      ring_size, ICE_RING_BASE_ALIGN,
>  				      socket_id);
>  	if (!tz) {
> @@ -1649,7 +1649,7 @@ ice_tx_queue_setup(struct rte_eth_dev *dev,
>  	txq->tx_deferred_start =3D tx_conf->tx_deferred_start;
>=20
>  	txq->tx_ring_dma =3D tz->iova;
> -	txq->ice_tx_ring =3D tz->addr;
> +	txq->ci_tx_ring =3D tz->addr;
>=20
>  	/* Allocate software ring */
>  	txq->sw_ring =3D
> @@ -2555,7 +2555,7 @@ ice_tx_descriptor_status(void *tx_queue, uint16_t
> offset)
>  			desc -=3D txq->nb_tx_desc;
>  	}
>=20
> -	status =3D &txq->ice_tx_ring[desc].cmd_type_offset_bsz;
> +	status =3D &txq->ci_tx_ring[desc].cmd_type_offset_bsz;
>  	mask =3D rte_cpu_to_le_64(ICE_TXD_QW1_DTYPE_M);
>  	expect =3D rte_cpu_to_le_64(ICE_TX_DESC_DTYPE_DESC_DONE <<
>  				  ICE_TXD_QW1_DTYPE_S);
> @@ -2638,7 +2638,7 @@ ice_fdir_setup_tx_resources(struct ice_pf *pf)
>  	txq->ice_vsi =3D pf->fdir.fdir_vsi;
>=20
>  	txq->tx_ring_dma =3D tz->iova;
> -	txq->ice_tx_ring =3D (struct ci_tx_desc *)tz->addr;
> +	txq->ci_tx_ring =3D (struct ci_tx_desc *)tz->addr;
>  	/*
>  	 * don't need to allocate software ring and reset for the fdir
>  	 * program queue just set the queue has been configured.
> @@ -3027,7 +3027,7 @@ static inline int
>  ice_xmit_cleanup(struct ci_tx_queue *txq)
>  {
>  	struct ci_tx_entry *sw_ring =3D txq->sw_ring;
> -	volatile struct ci_tx_desc *txd =3D txq->ice_tx_ring;
> +	volatile struct ci_tx_desc *txd =3D txq->ci_tx_ring;
>  	uint16_t last_desc_cleaned =3D txq->last_desc_cleaned;
>  	uint16_t nb_tx_desc =3D txq->nb_tx_desc;
>  	uint16_t desc_to_clean_to;
> @@ -3148,7 +3148,7 @@ uint16_t
>  ice_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkt=
s)
>  {
>  	struct ci_tx_queue *txq;
> -	volatile struct ci_tx_desc *ice_tx_ring;
> +	volatile struct ci_tx_desc *ci_tx_ring;
>  	volatile struct ci_tx_desc *txd;
>  	struct ci_tx_entry *sw_ring;
>  	struct ci_tx_entry *txe, *txn;
> @@ -3171,7 +3171,7 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf
> **tx_pkts, uint16_t nb_pkts)
>=20
>  	txq =3D tx_queue;
>  	sw_ring =3D txq->sw_ring;
> -	ice_tx_ring =3D txq->ice_tx_ring;
> +	ci_tx_ring =3D txq->ci_tx_ring;
>  	tx_id =3D txq->tx_tail;
>  	txe =3D &sw_ring[tx_id];
>=20
> @@ -3257,7 +3257,7 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf
> **tx_pkts, uint16_t nb_pkts)
>  			/* Setup TX context descriptor if required */
>  			volatile struct ice_tx_ctx_desc *ctx_txd =3D
>  				(volatile struct ice_tx_ctx_desc *)
> -					&ice_tx_ring[tx_id];
> +					&ci_tx_ring[tx_id];
>  			uint16_t cd_l2tag2 =3D 0;
>  			uint64_t cd_type_cmd_tso_mss =3D
> ICE_TX_DESC_DTYPE_CTX;
>=20
> @@ -3299,7 +3299,7 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf
> **tx_pkts, uint16_t nb_pkts)
>  		m_seg =3D tx_pkt;
>=20
>  		do {
> -			txd =3D &ice_tx_ring[tx_id];
> +			txd =3D &ci_tx_ring[tx_id];
>  			txn =3D &sw_ring[txe->next_id];
>=20
>  			if (txe->mbuf)
> @@ -3327,7 +3327,7 @@ ice_xmit_pkts(void *tx_queue, struct rte_mbuf
> **tx_pkts, uint16_t nb_pkts)
>  				txe->last_id =3D tx_last;
>  				tx_id =3D txe->next_id;
>  				txe =3D txn;
> -				txd =3D &ice_tx_ring[tx_id];
> +				txd =3D &ci_tx_ring[tx_id];
>  				txn =3D &sw_ring[txe->next_id];
>  			}
>=20
> @@ -3410,7 +3410,7 @@ ice_tx_free_bufs(struct ci_tx_queue *txq)
>  	struct ci_tx_entry *txep;
>  	uint16_t i;
>=20
> -	if ((txq->ice_tx_ring[txq->tx_next_dd].cmd_type_offset_bsz &
> +	if ((txq->ci_tx_ring[txq->tx_next_dd].cmd_type_offset_bsz &
>  	     rte_cpu_to_le_64(ICE_TXD_QW1_DTYPE_M)) !=3D
>  	    rte_cpu_to_le_64(ICE_TX_DESC_DTYPE_DESC_DONE))
>  		return 0;
> @@ -3594,7 +3594,7 @@ static inline void
>  ice_tx_fill_hw_ring(struct ci_tx_queue *txq, struct rte_mbuf **pkts,
>  		    uint16_t nb_pkts)
>  {
> -	volatile struct ci_tx_desc *txdp =3D &txq->ice_tx_ring[txq->tx_tail];
> +	volatile struct ci_tx_desc *txdp =3D &txq->ci_tx_ring[txq->tx_tail];
>  	struct ci_tx_entry *txep =3D &txq->sw_ring[txq->tx_tail];
>  	const int N_PER_LOOP =3D 4;
>  	const int N_PER_LOOP_MASK =3D N_PER_LOOP - 1;
> @@ -3627,7 +3627,7 @@ tx_xmit_pkts(struct ci_tx_queue *txq,
>  	     struct rte_mbuf **tx_pkts,
>  	     uint16_t nb_pkts)
>  {
> -	volatile struct ci_tx_desc *txr =3D txq->ice_tx_ring;
> +	volatile struct ci_tx_desc *txr =3D txq->ci_tx_ring;
>  	uint16_t n =3D 0;
>=20
>  	/**
> @@ -4887,11 +4887,11 @@ ice_fdir_programming(struct ice_pf *pf, struct
> ice_fltr_desc *fdir_desc)
>  	uint16_t i;
>=20
>  	fdirdp =3D (volatile struct ice_fltr_desc *)
> -		(&txq->ice_tx_ring[txq->tx_tail]);
> +		(&txq->ci_tx_ring[txq->tx_tail]);
>  	fdirdp->qidx_compq_space_stat =3D fdir_desc->qidx_compq_space_stat;
>  	fdirdp->dtype_cmd_vsi_fdid =3D fdir_desc->dtype_cmd_vsi_fdid;
>=20
> -	txdp =3D &txq->ice_tx_ring[txq->tx_tail + 1];
> +	txdp =3D &txq->ci_tx_ring[txq->tx_tail + 1];
>  	txdp->buffer_addr =3D rte_cpu_to_le_64(pf->fdir.dma_addr);
>  	td_cmd =3D ICE_TX_DESC_CMD_EOP |
>  		ICE_TX_DESC_CMD_RS  |
> diff --git a/drivers/net/intel/ice/ice_rxtx_vec_avx2.c
> b/drivers/net/intel/ice/ice_rxtx_vec_avx2.c
> index bef7bb00ba..0a1df0b2f6 100644
> --- a/drivers/net/intel/ice/ice_rxtx_vec_avx2.c
> +++ b/drivers/net/intel/ice/ice_rxtx_vec_avx2.c
> @@ -869,7 +869,7 @@ ice_xmit_fixed_burst_vec_avx2(void *tx_queue,
> struct rte_mbuf **tx_pkts,
>  		return 0;
>=20
>  	tx_id =3D txq->tx_tail;
> -	txdp =3D &txq->ice_tx_ring[tx_id];
> +	txdp =3D &txq->ci_tx_ring[tx_id];
>  	txep =3D &txq->sw_ring_vec[tx_id];
>=20
>  	txq->nb_tx_free =3D (uint16_t)(txq->nb_tx_free - nb_pkts);
> @@ -890,7 +890,7 @@ ice_xmit_fixed_burst_vec_avx2(void *tx_queue,
> struct rte_mbuf **tx_pkts,
>  		txq->tx_next_rs =3D (uint16_t)(txq->tx_rs_thresh - 1);
>=20
>  		/* avoid reach the end of ring */
> -		txdp =3D &txq->ice_tx_ring[tx_id];
> +		txdp =3D &txq->ci_tx_ring[tx_id];
>  		txep =3D &txq->sw_ring_vec[tx_id];
>  	}
>=20
> @@ -900,7 +900,7 @@ ice_xmit_fixed_burst_vec_avx2(void *tx_queue,
> struct rte_mbuf **tx_pkts,
>=20
>  	tx_id =3D (uint16_t)(tx_id + nb_commit);
>  	if (tx_id > txq->tx_next_rs) {
> -		txq->ice_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=3D
> +		txq->ci_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=3D
>  			rte_cpu_to_le_64(((uint64_t)ICE_TX_DESC_CMD_RS)
> <<
>  					 ICE_TXD_QW1_CMD_S);
>  		txq->tx_next_rs =3D
> diff --git a/drivers/net/intel/ice/ice_rxtx_vec_avx512.c
> b/drivers/net/intel/ice/ice_rxtx_vec_avx512.c
> index 1f6bf5fc8e..d42f41461f 100644
> --- a/drivers/net/intel/ice/ice_rxtx_vec_avx512.c
> +++ b/drivers/net/intel/ice/ice_rxtx_vec_avx512.c
> @@ -933,7 +933,7 @@ ice_xmit_fixed_burst_vec_avx512(void *tx_queue,
> struct rte_mbuf **tx_pkts,
>  		return 0;
>=20
>  	tx_id =3D txq->tx_tail;
> -	txdp =3D &txq->ice_tx_ring[tx_id];
> +	txdp =3D &txq->ci_tx_ring[tx_id];
>  	txep =3D (void *)txq->sw_ring;
>  	txep +=3D tx_id;
>=20
> @@ -955,7 +955,7 @@ ice_xmit_fixed_burst_vec_avx512(void *tx_queue,
> struct rte_mbuf **tx_pkts,
>  		txq->tx_next_rs =3D (uint16_t)(txq->tx_rs_thresh - 1);
>=20
>  		/* avoid reach the end of ring */
> -		txdp =3D txq->ice_tx_ring;
> +		txdp =3D txq->ci_tx_ring;
>  		txep =3D (void *)txq->sw_ring;
>  	}
>=20
> @@ -965,7 +965,7 @@ ice_xmit_fixed_burst_vec_avx512(void *tx_queue,
> struct rte_mbuf **tx_pkts,
>=20
>  	tx_id =3D (uint16_t)(tx_id + nb_commit);
>  	if (tx_id > txq->tx_next_rs) {
> -		txq->ice_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=3D
> +		txq->ci_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=3D
>  			rte_cpu_to_le_64(((uint64_t)ICE_TX_DESC_CMD_RS)
> <<
>  					 ICE_TXD_QW1_CMD_S);
>  		txq->tx_next_rs =3D
> diff --git a/drivers/net/intel/ice/ice_rxtx_vec_common.h
> b/drivers/net/intel/ice/ice_rxtx_vec_common.h
> index ff46a8fb49..8ba591e403 100644
> --- a/drivers/net/intel/ice/ice_rxtx_vec_common.h
> +++ b/drivers/net/intel/ice/ice_rxtx_vec_common.h
> @@ -11,7 +11,7 @@
>  static inline int
>  ice_tx_desc_done(struct ci_tx_queue *txq, uint16_t idx)
>  {
> -	return (txq->ice_tx_ring[idx].cmd_type_offset_bsz &
> +	return (txq->ci_tx_ring[idx].cmd_type_offset_bsz &
>  			rte_cpu_to_le_64(ICE_TXD_QW1_DTYPE_M)) =3D=3D
>=20
> 	rte_cpu_to_le_64(ICE_TX_DESC_DTYPE_DESC_DONE);
>  }
> diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.c
> b/drivers/net/intel/idpf/idpf_common_rxtx.c
> index be3c1ef216..51074bda3a 100644
> --- a/drivers/net/intel/idpf/idpf_common_rxtx.c
> +++ b/drivers/net/intel/idpf/idpf_common_rxtx.c
> @@ -266,11 +266,11 @@ idpf_qc_single_tx_queue_reset(struct ci_tx_queue
> *txq)
>  	txe =3D txq->sw_ring;
>  	size =3D sizeof(struct ci_tx_desc) * txq->nb_tx_desc;
>  	for (i =3D 0; i < size; i++)
> -		((volatile char *)txq->idpf_tx_ring)[i] =3D 0;
> +		((volatile char *)txq->ci_tx_ring)[i] =3D 0;
>=20
>  	prev =3D (uint16_t)(txq->nb_tx_desc - 1);
>  	for (i =3D 0; i < txq->nb_tx_desc; i++) {
> -		txq->idpf_tx_ring[i].cmd_type_offset_bsz =3D
> +		txq->ci_tx_ring[i].cmd_type_offset_bsz =3D
>=20
> 	rte_cpu_to_le_64(IDPF_TX_DESC_DTYPE_DESC_DONE);
>  		txe[i].mbuf =3D  NULL;
>  		txe[i].last_id =3D i;
> @@ -1335,7 +1335,7 @@ idpf_xmit_cleanup(struct ci_tx_queue *txq)
>  	uint16_t desc_to_clean_to;
>  	uint16_t nb_tx_to_clean;
>=20
> -	volatile struct ci_tx_desc *txd =3D txq->idpf_tx_ring;
> +	volatile struct ci_tx_desc *txd =3D txq->ci_tx_ring;
>=20
>  	desc_to_clean_to =3D (uint16_t)(last_desc_cleaned + txq->tx_rs_thresh);
>  	if (desc_to_clean_to >=3D nb_tx_desc)
> @@ -1398,7 +1398,7 @@ idpf_dp_singleq_xmit_pkts(void *tx_queue, struct
> rte_mbuf **tx_pkts,
>  		return nb_tx;
>=20
>  	sw_ring =3D txq->sw_ring;
> -	txr =3D txq->idpf_tx_ring;
> +	txr =3D txq->ci_tx_ring;
>  	tx_id =3D txq->tx_tail;
>  	txe =3D &sw_ring[tx_id];
>=20
> diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
> b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
> index 5f5d538dcb..04efee3722 100644
> --- a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
> +++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
> @@ -573,7 +573,7 @@ idpf_singleq_xmit_fixed_burst_vec_avx2(void
> *tx_queue, struct rte_mbuf **tx_pkts
>  		return 0;
>=20
>  	tx_id =3D txq->tx_tail;
> -	txdp =3D &txq->idpf_tx_ring[tx_id];
> +	txdp =3D &txq->ci_tx_ring[tx_id];
>  	txep =3D &txq->sw_ring_vec[tx_id];
>=20
>  	txq->nb_tx_free =3D (uint16_t)(txq->nb_tx_free - nb_pkts);
> @@ -594,7 +594,7 @@ idpf_singleq_xmit_fixed_burst_vec_avx2(void
> *tx_queue, struct rte_mbuf **tx_pkts
>  		txq->tx_next_rs =3D (uint16_t)(txq->tx_rs_thresh - 1);
>=20
>  		/* avoid reach the end of ring */
> -		txdp =3D &txq->idpf_tx_ring[tx_id];
> +		txdp =3D &txq->ci_tx_ring[tx_id];
>  		txep =3D &txq->sw_ring_vec[tx_id];
>  	}
>=20
> @@ -604,7 +604,7 @@ idpf_singleq_xmit_fixed_burst_vec_avx2(void
> *tx_queue, struct rte_mbuf **tx_pkts
>=20
>  	tx_id =3D (uint16_t)(tx_id + nb_commit);
>  	if (tx_id > txq->tx_next_rs) {
> -		txq->idpf_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=3D
> +		txq->ci_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=3D
>=20
> 	rte_cpu_to_le_64(((uint64_t)IDPF_TX_DESC_CMD_RS) <<
>  					 IDPF_TXD_QW1_CMD_S);
>  		txq->tx_next_rs =3D
> diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
> b/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
> index c1ec3d1222..d5e5a2ca5f 100644
> --- a/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
> +++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
> @@ -1090,7 +1090,7 @@ idpf_singleq_xmit_fixed_burst_vec_avx512(void
> *tx_queue, struct rte_mbuf **tx_pk
>  		return 0;
>=20
>  	tx_id =3D txq->tx_tail;
> -	txdp =3D &txq->idpf_tx_ring[tx_id];
> +	txdp =3D &txq->ci_tx_ring[tx_id];
>  	txep =3D (void *)txq->sw_ring;
>  	txep +=3D tx_id;
>=20
> @@ -1112,7 +1112,7 @@ idpf_singleq_xmit_fixed_burst_vec_avx512(void
> *tx_queue, struct rte_mbuf **tx_pk
>  		txq->tx_next_rs =3D (uint16_t)(txq->tx_rs_thresh - 1);
>=20
>  		/* avoid reach the end of ring */
> -		txdp =3D &txq->idpf_tx_ring[tx_id];
> +		txdp =3D &txq->ci_tx_ring[tx_id];
>  		txep =3D (void *)txq->sw_ring;
>  		txep +=3D tx_id;
>  	}
> @@ -1123,7 +1123,7 @@ idpf_singleq_xmit_fixed_burst_vec_avx512(void
> *tx_queue, struct rte_mbuf **tx_pk
>=20
>  	tx_id =3D (uint16_t)(tx_id + nb_commit);
>  	if (tx_id > txq->tx_next_rs) {
> -		txq->idpf_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=3D
> +		txq->ci_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=3D
>=20
> 	rte_cpu_to_le_64(((uint64_t)IDPF_TX_DESC_CMD_RS) <<
>  					 IDPF_TXD_QW1_CMD_S);
>  		txq->tx_next_rs =3D
> diff --git a/drivers/net/intel/idpf/idpf_rxtx.c
> b/drivers/net/intel/idpf/idpf_rxtx.c
> index 8aa44585fe..0de54d9305 100644
> --- a/drivers/net/intel/idpf/idpf_rxtx.c
> +++ b/drivers/net/intel/idpf/idpf_rxtx.c
> @@ -481,7 +481,7 @@ idpf_tx_queue_setup(struct rte_eth_dev *dev,
> uint16_t queue_idx,
>  	}
>=20
>  	if (!is_splitq) {
> -		txq->idpf_tx_ring =3D mz->addr;
> +		txq->ci_tx_ring =3D mz->addr;
>  		idpf_qc_single_tx_queue_reset(txq);
>  	} else {
>  		txq->desc_ring =3D mz->addr;
> diff --git a/drivers/net/intel/idpf/idpf_rxtx_vec_common.h
> b/drivers/net/intel/idpf/idpf_rxtx_vec_common.h
> index 4702061484..b5e8574667 100644
> --- a/drivers/net/intel/idpf/idpf_rxtx_vec_common.h
> +++ b/drivers/net/intel/idpf/idpf_rxtx_vec_common.h
> @@ -31,7 +31,7 @@ idpf_tx_desc_done(struct ci_tx_queue *txq, uint16_t
> idx)
>  	if (txq->complq !=3D NULL)
>  		return 1;
>=20
> -	return (txq->idpf_tx_ring[idx].cmd_type_offset_bsz &
> +	return (txq->ci_tx_ring[idx].cmd_type_offset_bsz &
>  			rte_cpu_to_le_64(IDPF_TXD_QW1_DTYPE_M)) =3D=3D
>=20
> 	rte_cpu_to_le_64(IDPF_TX_DESC_DTYPE_DESC_DONE);
>  }
> --
> 2.51.0

