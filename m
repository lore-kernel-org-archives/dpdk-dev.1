Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0584ACD5BB0
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 May 2026 10:26:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F1DCE4029F;
	Fri, 22 May 2026 12:26:49 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 307384028D;
 Fri, 22 May 2026 12:26:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779445607; x=1810981607;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Ehk+zy8CYxQWnCMV0Od441YVa/nLoj4MS+V+VTxt28c=;
 b=Ocoku9p5vjJPSRb/SVN+OScy/tra4T6/0pxXh/B8YgQ7m62xVYxYlOFH
 ZaoMOKFCVyzYx9N2CAW3hXF24eyT4ZWeRh3suxNr/KVsdoU8XV7kG+vj0
 N53GKYmYg0qTwrEAP7nY/QAt/u0M8esACyyjIOIQC/agnjE677VvAjRqw
 wpHfMsNjyiTmGcCYeUBlCQ5BfrEL5YkjJ4zKWkVcjMer6tMjCwOwHVFLD
 GagTJxDYlEsmzhmGba5nLiFcaMvsJ2mi/dEXfid+qnms4U8M6m02YcG6u
 bLgumyo7cKYD0tOwXhCqYIyD8rAj3nnRw/XOn3WYxnVlRRmKUK5x5dEpZ Q==;
X-CSE-ConnectionGUID: vx4CYoNJQoSa5Slemaxg6g==
X-CSE-MsgGUID: PH/6B7HzSv2ShmlAl6wtUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="80359185"
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="80359185"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 03:26:46 -0700
X-CSE-ConnectionGUID: OoBXwsSfQiG6o9AmHRfjag==
X-CSE-MsgGUID: FsjnIs8gRmC4AJI4kVoXtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="278987264"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 03:26:47 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 22 May 2026 03:26:46 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 22 May 2026 03:26:46 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.44) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 22 May 2026 03:26:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g/Hb8R82J3Ie3q6bLAxPMbtC0m8LlvAiE3B/J9wA/gMbZSR43xgMeLyBI0SqlPUCpaQnM98ZMkBudsbsTU4RQilMWngGKIOHzHj1mPHS3nodXg3R5a9eAf8ESYYpUIgT44JfIdWR7yhDeL5ECLCd2sNX9ch0or8t4W8uJIwYmjsXmMpb4aWhtfEl9iNCQKXaUzeXyOQFsSGwdYT0/uBlSbHGdJzLBfp8FZgtfA+zZNvGSfZtpUgjYKve3sKmO4epyhZAnHjO4N7jWXjndRPJ49M/o3XuUSyMKj+X68Ut+Xoeip8MnrY4hFp82MDfGygtBPElZsgJBHzzgtFxCIWg3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/lO9/lF321L+WP6of638QnC2/jE+K69kklVujlmFRrE=;
 b=NLKOuK+w66mGfoqWcYxRKhTI2nYgkgw6+sX8SsFWx9pMls58XHthWu2lSD2UCzmJExWTcei1N/hN29jWkae5r9P20Q+iuWBRIT7Ptn8bXNYOGVMHtX9AGWbVCMi+vXdy+fQdSOMvXj9vPPYmK39ji3N2k4JBQc1vrf4mZ8+lCxN3gFkXbJTg2v7YkzxndZZseXDuZTeGx8Oc90p25hyvmrUNYcUGtugqKNiwHQDix/j7fq6nlwxzXHqWsdxbmXHdRTZ2wxnS7ID5PtWJfH+XaGk4U9qyZ1drGngnars4Dx3m3SUB/jAvAkc4x86gekXd+UTffVPzXddRaiQupBMs4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f32) by SA2PR11MB4860.namprd11.prod.outlook.com
 (2603:10b6:806:11b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 10:26:43 +0000
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::d99e:14f5:fdbb:f2d]) by DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::d99e:14f5:fdbb:f2d%6]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 10:26:42 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Talluri, ChaitanyababuX" <chaitanyababux.talluri@intel.com>,
 "dev@dpdk.org" <dev@dpdk.org>, "Richardson, Bruce"
 <bruce.richardson@intel.com>, "Singh, Aman Deep" <aman.deep.singh@intel.com>
CC: "Wani, Shaiq" <shaiq.wani@intel.com>, "Talluri, ChaitanyababuX"
 <chaitanyababux.talluri@intel.com>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH] net/iavf: fix VF reset race and stale ARQ message handling
Thread-Topic: [PATCH] net/iavf: fix VF reset race and stale ARQ message
 handling
Thread-Index: AQHc5oiL1vmson3sEE+Ckh1tWpu3ALYZ2oIg
Date: Fri, 22 May 2026 10:26:42 +0000
Message-ID: <DM3PPF7D18F34A1AFE8AE5E1CFC82FCBE3B8E0F2@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
References: <20260518054227.110701-1-chaitanyababux.talluri@intel.com>
In-Reply-To: <20260518054227.110701-1-chaitanyababux.talluri@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF7D18F34A1:EE_|SA2PR11MB4860:EE_
x-ms-office365-filtering-correlation-id: 3f23c9d5-2fc4-4fba-a6b2-08deb7ec9e29
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|11063799006|6133799003|3023799007|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: E8vmJiaWUteERrmDRM+xQTF2epN4zLEf8fEJzbNt2PaMzGt9vOHHulYpYu0vjQL5/t4Bx5mbb069G7HvLMLbuC9dpHdcHpjzjiy9rMmX27cMsGVDWm70PxtBvQkgpvb1CEMPJSHZRmfTy+ed52+2PhfrhmQWgY4cHG3IW4GbhD/gK8BnvElsMBp+UqFCqNcPV6xhTTPqkWY9hWODeuIXe3KIlPvb2FOc5N6+/MJ3Np8gPSs6B28x6ErnQrA+Bn1MhR3yjifwGQbE5Z8jUgDqiYnprOkxWu6Ynekf1Woo4irJssiSQgfi28nbGfC56U3PzLDzzpg5emOKAg1+ytEQ8tZjec1SU9dDRGkhxRfJ7l47AdQ7YTUkG+Gu9UpJDaqFGRJCn1dGQMyT3vf3Pq3UOyHLdEQoTLYY+QKuTKxSHVadQd0X9jOq+QQnXtxCIsUSckD7kHkzdzyHWcvU5wMVVNQbyG2wlGk0NmrxkgMzazrrKgGQf4jLVwZP2thPRA5B4od1IasFx4tl9INEGDeJmwm7bJ0BcR5R2pTDcEUzV0epffb9dl5nadUMk+2ru6tJqtvub4pmQNXXu6ksm8x8eABx88kaLgqUyHTZtgjKpUrXNilOankOkLNH+m9HylgvtgzAiHMw4nGRfyP6xIrdmPwO9JrlfWdmzw4EkT+X8nZjZjyXWZoB9mgBuiBLmcgAL7se0da5QCIZTBSIe8gQ809xiob7KU9OtHf3tl0+QeoZLYyA8P9wPhzBAXVxUeTO
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF7D18F34A1.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(11063799006)(6133799003)(3023799007)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YBIyyhgu5YZO8eFUAoTJqYZoSz0TtBTMzbeAepZ18qsVdGnxXXZy/dL8SpD5?=
 =?us-ascii?Q?qWbR/rot9ihLr4+ktHHGSXozUqHuGuQtSPyKUVDVuT0JfkVc4/qlBPSh4ooL?=
 =?us-ascii?Q?tj+c1aMn8NGAriS1A2LoSorhVV2t+jKoot35CionLVTPi7XtsrJP26N0XmPa?=
 =?us-ascii?Q?Ul1mqbT3YMoiZ7AuVAh+jxa2D2l/Yk0f7e02cDIPRQsHEK530qExpJch6VWO?=
 =?us-ascii?Q?mr4kh1g1iSGoOM9ni3otnsFwN2GKcjpXG/bub7ltv3cewcAMH+FWt4NbtHkK?=
 =?us-ascii?Q?fy0IHhSgQ3VHYr53IBFwkD5wK5LK44tTcqWZd6MVWltIuS7ELeMKan8b718T?=
 =?us-ascii?Q?/1bkyF8PjrpJxHUaB2Rr2JSofpxBGI9HsE39PkLg0NGiAndrt7N2mrXTk1Ii?=
 =?us-ascii?Q?xwC0EhAV5k0QZbJZ8BMROiutH+tXdiaE0m017NyA2RWghI0TX/dITNUWuJMj?=
 =?us-ascii?Q?y7marMUfJ7R62IyPB/3zc0CwqxnJH4EIC5zq1vSaPPGtwsp8LWbBdS0fKy2S?=
 =?us-ascii?Q?RAxcE90dEER5zDIp8GvN9HGloIuDXkMrrsJT3rVhXODxgvMTzoqVuHWOzjTW?=
 =?us-ascii?Q?dpwjfU7NV9aUVlliHU/Cakl5fSoYwCKBvwxmAbQe3Nok1Uq+YNhTzqs9i8JS?=
 =?us-ascii?Q?JNQpe03R99YiTtMEep/Xw3uiDJ3MxX8DemPvTlcJvCOwpw6IPsWfN4g0cpt+?=
 =?us-ascii?Q?kZMy47tD5hbBV8zEfvH071u+uMpmgQmkRBtoXjT1wVTmJ1z2dBaTq7f+l6fE?=
 =?us-ascii?Q?/lmPFsXztct4xIYO5jOHwdIgfo4TufkX1rfIYEtzP8GcigwuqkrfTgBjl97U?=
 =?us-ascii?Q?f1BYQINy4dQ6xlYoGJWxkOfAmdV6/ZixO3ECB4e2nn/i2rNojtV1RSHascmX?=
 =?us-ascii?Q?AlkkIpoHwwHyVgp+3G+uuYO3RoQ7OSo86fD7Eou9E7EFWJiIRPStmp/3dPID?=
 =?us-ascii?Q?kSmstnSLcy5YiiOAXDsyDeSx663vn0xE8sS/0C85lHJA1PnB1TbQWMr4E5D/?=
 =?us-ascii?Q?1/G0CSopCeQe8ZN3tR0py7/3GVyejJUdll451ljXrMsL5qX39cmngITvmtvW?=
 =?us-ascii?Q?ZNsQISR+H3skF3KQvLF4vBb1lAy6gvWTZ6jArqdyIlfWDPzjdWVr9siyxiRS?=
 =?us-ascii?Q?OeWtPZcLN3pZ5YykJvgWmDuwnodO24ohUKYxG9iAZKksWRet/4xjh6uBAyZV?=
 =?us-ascii?Q?W4axNQOt/9GDDWeqiytw1ww1qIMmr0wsUDiK9+KjhHud0h6ksbyaJ6tpXc8m?=
 =?us-ascii?Q?0/XFtCLF6sXpym8NwCHMZY3GBQzVCuQzq3HIOokf3A7qz7pgTgQJBbL7F0qy?=
 =?us-ascii?Q?lmNyo0uhb/ePwyrkJUJ09FWS7JRGxdWaHBRuECaIAkE3BkM0gXXUxPwPh6nM?=
 =?us-ascii?Q?5m03FuQN7D9ZmhRPdPsaxkM85F7soy3QpnezbnGcf25At8SwCwFXFwbkB2mk?=
 =?us-ascii?Q?8qhlitwtUnGjEKHPgqCc228JzWsw2zPuHC+k9lvvUfy4frQgMuUXzHzVe6J8?=
 =?us-ascii?Q?TPMi8bPfCBccVdtXmz5AnxXeuMQnSgJq5yMTbMLx1MVahaF1MePerZZiRaGl?=
 =?us-ascii?Q?imhvgecUieuzEj6lFMxLQS64VjiT8bcwrjH8di/Eq3NRI4Gr2QN212SsJNo2?=
 =?us-ascii?Q?Q+9KWe4ygRVJrbDAvzPU8WLtQJ8EOkYFwBwwzYjo4KqpVYNp5V6VOoAlrBUp?=
 =?us-ascii?Q?sn8Wi1KEXefFqXWBYuq/9ZRb5+lXG6d9pcBQB0AqWzvNmN9pQV1kCQ/u6rL3?=
 =?us-ascii?Q?PFKfBhTaeQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: FJxhi2AM7OHvkTq8xbl0n9teGs6LaZNS1cle3mQAPRmNwuJteJyKbc0wU0VMOisVx+uFhYRYYoQUP2qdy3bsFYqmEASVxCug1tx1noEIFdzwnD07q+WNFUsfF4/U0s/3HfvvfXMK+pRmj0JKbTBOhaJ7ZGmar17i3kC9Qv/LPIIUMjoprAf8hYBk2/7BvJMj4oJT/sSSgZMGZHiVa9MU25CtbPRPplUt33fOx/CutuBJGXpEk6iIPmLrwYDSvEw694tdjJoUFcU6gEYsUM1BWUnurKAbDzXva+Ne1HkZx/O+IgMPMwghiecjPNxu//Fhjl1aZKKjzHpZw5bFFBNqNQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF7D18F34A1.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f23c9d5-2fc4-4fba-a6b2-08deb7ec9e29
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2026 10:26:42.6816 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NS4p3BSByoL2eMlzijCjGB43z2DwkxPcUGwyTIbyUR9m0X5ei1U/BLR6N27wP/kvvRqnlw5ICqDGVQ6UA5FnBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4860
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

> Subject: [PATCH] net/iavf: fix VF reset race and stale ARQ message handli=
ng
>=20
> During VF reset, multiple issues can lead to initialization instability.
>=20
> The first issue is a race condition in iavf_check_vf_reset_done(),
> where VFR state VFACTIVE is treated as both "reset not started" and
> "reset completed". This can allow the VF to proceed before the PF
> has acknowledged the reset, resulting in inconsistent initialization.
>=20
> The second issue is the presence of stale messages in the Admin
> Receive Queue (ARQ) after VF reset. These may include opcode 0
> (VIRTCHNL_OP_UNKNOWN) or responses to commands issued before reset,
> which can interfere with API negotiation and cause command mismatch
> errors.
>=20
> Additionally, opcode 0 messages generate excessive warning logs,
> causing unnecessary noise during initialization.
>=20
> The solution involves:
> 1. Introducing a two-phase reset wait mechanism in
>    iavf_check_vf_reset_done():
>    - Wait for RSTAT to leave VFACTIVE to confirm reset start.
>    - Wait for RSTAT to return to VFACTIVE or COMPLETED to confirm
>      reset completion.
>=20
> 2. Draining stale ARQ messages after admin queue initialization
>    and before issuing commands in iavf_init_vf().
>=20
> 3. Downgrading opcode 0 message logging to DEBUG level while
>    preserving mismatch detection for other opcodes.
>=20
> 4. Refactoring reset-start detection and ARQ drain logic into
>    helper functions (iavf_wait_for_reset_start() and
>    iavf_drain_arq()) to improve readability and reuse.
>=20
> This ensures reliable VF reset handling and stable initialization.
>=20
> Fixes: 28a1a72eac26 ("net/iavf: add VF initiated reset")

Is the fix only for the VF initiated reset sequence, or does it aim to
fix other reset sequences as well eg. PF initiated?

> Cc: stable@dpdk.org
>=20
> Signed-off-by: Talluri Chaitanyababu <chaitanyababux.talluri@intel.com>
> ---
>  drivers/net/intel/iavf/iavf_ethdev.c | 54
> ++++++++++++++++++++++++++++
>  drivers/net/intel/iavf/iavf_vchnl.c  | 16 +++++++--
>  2 files changed, 67 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/intel/iavf/iavf_ethdev.c
> b/drivers/net/intel/iavf/iavf_ethdev.c
> index 1eca20bc9a..692e4455dc 100644
> --- a/drivers/net/intel/iavf/iavf_ethdev.c
> +++ b/drivers/net/intel/iavf/iavf_ethdev.c
> @@ -2002,11 +2002,36 @@ iavf_dev_rx_queue_intr_disable(struct
> rte_eth_dev *dev, uint16_t queue_id)
>  	return 0;
>  }
>=20
> +/* Wait until PF acknowledges VF reset (RSTAT leaves VFACTIVE) */
> +static int
> +iavf_wait_for_reset_start(struct iavf_hw *hw)
> +{
> +	int i;
> +	uint32_t rstat;
> +
> +	for (i =3D 0; i < 100; i++) {
> +		rte_delay_ms(10);
> +
> +		rstat =3D IAVF_READ_REG(hw, IAVF_VFGEN_RSTAT);
> +		rstat &=3D IAVF_VFGEN_RSTAT_VFR_STATE_MASK;
> +		rstat >>=3D IAVF_VFGEN_RSTAT_VFR_STATE_SHIFT;
> +
> +		if (rstat !=3D VIRTCHNL_VFR_VFACTIVE)
> +			return 0;
> +	}
> +
> +	return -1;
> +}
> +
>  static int
>  iavf_check_vf_reset_done(struct iavf_hw *hw)
>  {
>  	int i, reset;
>=20
> +	/* Phase 1: wait for reset to start (leave VFACTIVE) */
> +	if (iavf_wait_for_reset_start(hw) !=3D 0)
> +		PMD_DRV_LOG(DEBUG, "VF reset did not start within
> timeout");

There are multiple paths that lead to the iavf_wait_for_reset_start
function being called, including during device initialisation
iavf_init_vf -> iavf_check_vf_reset_done. In this case, we are not
expecting a reset event, just making sure we are not trying to
initialise a VF in the middle of a reset. I think the
iavf_wait_for_reset_start is not needed here, and the associated log
would be incorrect. Can you check that
iavf_wait_for_reset_start is only triggered when absolutely necessary.
Consider these events: device init, pf initiated reset, vf initiated
reset, queue pair change (iavf_queues_req_reset)

> +
>  	for (i =3D 0; i < IAVF_RESET_WAIT_CNT; i++) {
>  		reset =3D IAVF_READ_REG(hw, IAVF_VFGEN_RSTAT) &
>  			IAVF_VFGEN_RSTAT_VFR_STATE_MASK;
> @@ -2517,6 +2542,31 @@ iavf_init_proto_xtr(struct rte_eth_dev *dev)
>  	}
>  }
>=20
> +/* Drain stale Admin Receive Queue messages after reset */
> +static void
> +iavf_drain_arq(struct iavf_hw *hw, struct iavf_info *vf)
> +{
> +	struct iavf_arq_event_info event;
> +	int drain_count =3D 0;
> +
> +	memset(&event, 0, sizeof(event));
> +	event.msg_buf =3D vf->aq_resp;
> +
> +	while (drain_count < IAVF_AQ_LEN) {
> +		event.buf_len =3D IAVF_AQ_BUF_SZ;
> +
> +		if (iavf_clean_arq_element(hw, &event, NULL) !=3D
> IAVF_SUCCESS)
> +			break;
> +
> +		drain_count++;
> +	}
> +
> +	if (drain_count > 0)
> +		PMD_INIT_LOG(DEBUG,
> +				"Drained %d stale ARQ messages",
> +				drain_count);
> +}
> +
>  static int
>  iavf_init_vf(struct rte_eth_dev *dev)
>  {
> @@ -2558,6 +2608,10 @@ iavf_init_vf(struct rte_eth_dev *dev)
>  		PMD_INIT_LOG(ERR, "unable to allocate vf_aq_resp
> memory");
>  		goto err_aq;
>  	}
> +
> +	/* Drain stale ARQ messages after VF reset */
> +	iavf_drain_arq(hw, vf);

Would we expect stale messages in the adminq here, it was only just
allocated a few lines above?

> +
>  	if (iavf_check_api_version(adapter) !=3D 0) {
>  		PMD_INIT_LOG(ERR, "check_api version failed");
>  		goto err_api;
> diff --git a/drivers/net/intel/iavf/iavf_vchnl.c
> b/drivers/net/intel/iavf/iavf_vchnl.c
> index 08dd6f2d7f..a014be8b57 100644
> --- a/drivers/net/intel/iavf/iavf_vchnl.c
> +++ b/drivers/net/intel/iavf/iavf_vchnl.c
> @@ -296,11 +296,21 @@ iavf_read_msg_from_pf(struct iavf_adapter
> *adapter, uint16_t buf_len,
>  					__func__, vpe->event);
>  		}
>  	}  else {
> -		/* async reply msg on command issued by vf previously */
> +		/* Async reply for previously issued VF command.
> +		 * Stale messages from before reset are ignored, and polling
> +		 * continues until the expected response is received.
> +		 */
>  		result =3D IAVF_MSG_CMD;
>  		if (opcode !=3D vf->pend_cmd) {
> -			PMD_DRV_LOG(WARNING, "command mismatch,
> expect %u, get %u",
> -					vf->pend_cmd, opcode);
> +			if (opcode =3D=3D VIRTCHNL_OP_UNKNOWN)
> +				PMD_DRV_LOG(DEBUG,
> +						"Ignoring stale msg (opcode
> 0), pending cmd %u",
> +						vf->pend_cmd);
> +			else
> +				PMD_DRV_LOG(WARNING,
> +						"command mismatch, expect
> %u, get %u",
> +						vf->pend_cmd, opcode);
> +
>  			result =3D IAVF_MSG_ERR;
>  		}
>  	}
> --
> 2.43.0

