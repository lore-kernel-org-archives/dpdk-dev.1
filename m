Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B52CD4F54
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 May 2026 13:23:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F23A4021F;
	Thu, 28 May 2026 15:23:09 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id C959C4021F
 for <dev@dpdk.org>; Thu, 28 May 2026 15:23:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779974586; x=1811510586;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=JhAbrW5sH/hGuWkfe1U3zrbrtegVIb/nOD4Yl4TQbmw=;
 b=UJyyKyJ5H2fPsFVd+N/Tg/uEcwYQdtL2j6njOAHC+G1vYUIlXnltEJ7z
 8SxuSJY8Z0AX+X+I/B+gxFI5LbaegJdOHbYMsaMLMYvGZrRQ+vro+hwUN
 o5f21VSOCEU2Cn1HN8pGXCCv2eijDU/QwPiQ8vWF6wwK774DdQWiDymGs
 GGR2HXRcXx1wffR0NtbRLG1kwV5feIpyJ7uG5Qo1KAsHP6nC7BaDVhEwd
 6l+6C2VRdr6SUDGZBq4iwO/z5FNZ9o7dWMezSJ3FN1MwrXXqR4mF66XC6
 WDpaxp/pj90J5IrSCA3Oj7woNcvhhDJMmXwm9fndkSTszAB82fiFQCLj3 g==;
X-CSE-ConnectionGUID: pb1683JcTwOJLHrFAJJ5Iw==
X-CSE-MsgGUID: 8rJ1wKGpTeKt3CXvmTW5Ag==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="79963956"
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; d="scan'208";a="79963956"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2026 06:23:05 -0700
X-CSE-ConnectionGUID: D1ADBqqtTX6FQD48/GQIvg==
X-CSE-MsgGUID: edIEDU8FQ1yeGS3xn2KoTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; d="scan'208";a="238361165"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2026 06:23:06 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 28 May 2026 06:23:05 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 28 May 2026 06:23:05 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.32) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 28 May 2026 06:23:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VkSayT03b7uwyMBHZc2G4YwJectm6v0+va7iDq5tsJUpBsgg1HNiMBH4NkWxQbz5QqFQ52JUSO5PnQfhJinb8NrQNEwOagcPWygC75u74nkBkapMAfghOCQSmR4FJzs5oisDRHc2k01qon/neGwvGPo1p7zALFJUPiEQebe4zuQiRoGb3DBNyb9tOvTi5eAIHbHmZIFypQ2wYt/3nXz573KIZ7DjJeJr4sZztMpa/+LDmOdCKepTXM1siE8Ou8SLpYLY770lBY7J38cjRPp2MomCAQWU6RLBp68Tq/SSgz1kblDSUgS3ajxa7sw9pWtULA27XAGUgE2MQuIG6x1r+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=83IqbQ9OUXekQOnN99X9GKaTFEWjzAgyzKtNgYQ22Ag=;
 b=q+lLMa0+0eanOWINtZDkj+tC60lsc9epuQDuJwMx5/YM858v9sC0g+rDDF7fyLN/8W+m8U7CAp3rn/cviI/5aLCgPhDiF+i1kavpAlAy6tmKSjc0Q26pNlFd5YRCLTu+Kqjjt47t8xXOxQrQ88WIVK0arMTyAI6JrV6MfFDQlzEjjySLI7hhhJxeush+GqMLdP/+/JZqEnZRenw393c1hM0E8TDTtQfVCZDCW87ORoewEEbrrd0h/MsYHSAVd4IZrsO8Q+VviYp8ECHNQSoKsM723LgMDSPqBa/XlpcK3o7H5T0E9bZMdSXzZrhTgF/cNwUj/Wp1cMJJYcGEn20mhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f32) by SJ5PPFC295640A5.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::852) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 13:23:01 +0000
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::d99e:14f5:fdbb:f2d]) by DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::d99e:14f5:fdbb:f2d%6]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 13:23:00 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "mb@smartsharesystems.com" <mb@smartsharesystems.com>, "Richardson, Bruce"
 <bruce.richardson@intel.com>
Subject: RE: [PATCH v3] net/intel: optimize for fast-free hint
Thread-Topic: [PATCH v3] net/intel: optimize for fast-free hint
Thread-Index: AQHc53+rxGtBR0lx4UiBYn7x6KFtyLYjdC5w
Date: Thu, 28 May 2026 13:23:00 +0000
Message-ID: <DM3PPF7D18F34A17BA228196DB8843D7D6F8E092@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
References: <20260123112032.2174361-1-bruce.richardson@intel.com>
 <20260519110637.964965-1-bruce.richardson@intel.com>
In-Reply-To: <20260519110637.964965-1-bruce.richardson@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF7D18F34A1:EE_|SJ5PPFC295640A5:EE_
x-ms-office365-filtering-correlation-id: cc9ff8c5-ee3c-4c1b-ab70-08debcbc3d6f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|11063799006|4143699003|18002099003|22082099003|38070700021|56012099006;
x-microsoft-antispam-message-info: L4zVugv7O1tWkF/BMJwxqyUvIMrSAKHEvnmClcWLpGxNyXYccVnMKF2dF5scYz/d9hB3iod3O87iFUJHj3TiolINHslFoMETxwlMPDK9TG5o35cm+8tDHNLn60jD96RqZgBJe18TGqE9XHp/UxMgjK6/pjDebhdGFOnSZN3PBsj8q/6kkkU1afXYB8TMVmjUCgva4yZiOESqoGFuYDHQTEdcmCCWdKmEIkdTseEhjYUlf8nBDJYvsCOUCnlod2vsIRLtjfmY/gRhZG/JaZYxdWp1rtarCh3ukhcbrUwU3SU5kCLdNMpLCGKhXnaI5TY7ynL33kIgFhUz7lSHPM+BH48vH9na3hcZ90LyccGJKe8BexFEcbCSATM+mOm/+1yiHpQU1O98TdenebAoZkBFMsYk8wz4qPWSRIODMjtk3p0N6su+rIkWI6dWRd1E+F7Nd/AIUuzLL12hqed3gD7edmwZkHbGR7l55e9gSg26B7rmjRzGmrfZXddl/ZaiCqJnYh840o4uWfAa9UzQdqrBo2OwgHO+No70LONeSZFHsptS2UfE3ERYh/IP6NBMcA75u5TTRpZ9rMX3Rp2Ztu5ERi0qpJs/eFKkC6y7v+PBnQ8E6GcV0UwxiW9qZTLqf4wYdSUslgOpNSdyRODC9YqI4/LYFbmFWsmnL9cZUAYv1osVuNfcT2mgMAsNVtLRiS4M2vJCxlHUMoVqEFG8Nh8Krz1LckSbNxkXbsVCdWfnGenFFrIk2RKk1t+m/HOQxg4A
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF7D18F34A1.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(11063799006)(4143699003)(18002099003)(22082099003)(38070700021)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ogi0rtp35vD77R8VAtRAYRjAWAz+vepnlk9bzp4yhIjXF01XU9d35XuI+Q27?=
 =?us-ascii?Q?lC1FTW/1dMKqGoBcCyxA8N+aM5cdIw24+efsq/9J6nb0Y4djEX0jDQZK4gm1?=
 =?us-ascii?Q?D1Fz126a1fyKWVtTb3BaWtZvODbw3+bkqeK5M2JfQnM/B60rN+a1hnRDiaZY?=
 =?us-ascii?Q?tDEoKKfExJ2E/fBgIztwhb2AmoufvXzlkdEAZxly6tISuOlB5TgPpS/jpXmX?=
 =?us-ascii?Q?JY2/VeILFVEIalpJk6YMpUW38r24GVHLYWJzDtP6PBMb2eY5Ifn2QbCV/Y/v?=
 =?us-ascii?Q?bo16+iiC6RNzC1mvriN59f+QnoGoRjdUf3BZTd0MaWBUMmPrTbDreQOCpmSA?=
 =?us-ascii?Q?1+mzHRR3GXondWNq7H4DU9N+VgFtWEliZU6Pw1XaXFZ2FtCcJI7VbN5vQEza?=
 =?us-ascii?Q?7L83vxKYHtHjMRcQltwS01jb1QSh864YgEZeFnLZrE359gWowCYouuukzsiF?=
 =?us-ascii?Q?CJ/j572GnyBDfPc8PXavpnO3Bq+ZU3YNfuZAyVN7UeR1RoUecjwp0uLhJdrY?=
 =?us-ascii?Q?vXbTH+wS4TU03z0/ZXd+GbkevVdGKVXW20Dcfy8FVwGKrbHK3E6n8zo1T8bP?=
 =?us-ascii?Q?f/SeaxT+LSzSGCzIG0t4WtrHxV+zolzOisliZtfUZZh3LLl7rvB0qR8LZjdS?=
 =?us-ascii?Q?oxcUWjupZUakaVxI6kwvau1/oUf4hG5V3rNIsR9vxNfiuVBgvthsfLPmJtoJ?=
 =?us-ascii?Q?GdFNwIb9znlwwp+VXckq5mTPHE64lItYs30kFOzNJsvoZRR4LT2Y1KgNT4OV?=
 =?us-ascii?Q?K7mmq3snmQj2rQG6cWEYjYDv9WEl/hApuXNKIqxmSGcmF7C5H+wKi6jUTc/9?=
 =?us-ascii?Q?dngupiFM3uRxTsOS7p13iMQb9fY9AwQVNtutA0FOfKOx+nNusni25Ny+ew/C?=
 =?us-ascii?Q?8SS2N7Oo/IGIHjJl/Wo3t1f5INsjsRu2jYJGEWGSUb9TIJK1rlqrVsIUIK0d?=
 =?us-ascii?Q?pITHMz/90rxRHHtS8wFLYEmgncD7Zw71KOwrBroTjq+LhAWZ58risJlzPO2y?=
 =?us-ascii?Q?lPuvwC370d5YrWN4eFeWPf8QKUXXIb1kNvwcIyuIE/Ey1mDdoBAc3rXyIrBs?=
 =?us-ascii?Q?WoBPiovp0X3DAbkL6xadqE/scs2KjFrXffdHtAQTcaiw+teg/gKBc5pSYa4H?=
 =?us-ascii?Q?K4iTx2/BoOhwrqTsgBmPYF66otreyBJyu9p6YvO+s4eJV5TIxVCcs2RxUsm1?=
 =?us-ascii?Q?6kLmywvj0u+D7h5bqSy/qdpOf7wl3LzJ231WZZcsXs7PJYc8imJoz1SE1P4a?=
 =?us-ascii?Q?I2A1XyPl4RPCOYlvv8gYcGGupfHDbKPZSkxElPGWpD2uP1ffIiQClDSNhALW?=
 =?us-ascii?Q?0A9XbeL1bdDH+O1C5b0aOuyriYBh/dOH31g/3+9aZhEAnRHSqtU7yLtF0NL5?=
 =?us-ascii?Q?snYdzUZC9xEJGnUnRg7gcVpcHuJQXaagPTWyztSRu/h6dF09XPS1wJRaVxUj?=
 =?us-ascii?Q?jiGlztONelr+R95e4RFUoeJqgBQRoVdXUbccU/GdjhffbJjdAdC1tsvGwaXj?=
 =?us-ascii?Q?JsOREvXZ98gyDpW5U4KBMrriiQZNotimfF3WK3CUlJf7+ubw7jHu05VBYpVK?=
 =?us-ascii?Q?LQQdsA+F894ZfPEAEMCkshoJUDOuTni59N8hhp5a0EullsFmLlOYSV1ELNR1?=
 =?us-ascii?Q?R67HnODrzC4t7hGBsC4RALCkqx/WFfHi8GtAGxDSuJETndUB1/ofze3H/Lzj?=
 =?us-ascii?Q?oTkbNFG5zA3cI6KeUvA8C4E9SHzA7/W5VTDS9F0thcR2rZ1fwPxds/E1SRlC?=
 =?us-ascii?Q?LCmrRf8cJg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ZjOTexGbw+35TRy3JLtXbi/rUkVDPz5qIwvM8Qha972O20kudL0OUWKxM3fmD1UKN/GgtvAN4SwJ840/VT4dzvTWjmlGi0X7vhU/BQ7jxX8HGEYjmHkb9AwXzbOlemr+Nrfm/CGtA4rFgYIS5atVI9X8yLsp0QPn9xAhc2c9xn5XKRRgNOyrJYe/CmgpDlsI+Fd5nXJ4D9OKy9Ximvtzf7rFLEc5ctNfvrZOkKjIKiBP5CTee42ytEToeTSGqSJoA31IRcppEzUBZ54zo8SYyLC0tlCtKpdnJHBx0B/ojlIugkWWJE3mvPkeINlGkB4ABjNeP/i9wZ5CQjwPOh0hFA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF7D18F34A1.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc9ff8c5-ee3c-4c1b-ab70-08debcbc3d6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2026 13:23:00.3592 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NKpaHYXmXWHXf68wbpOAtbLVhQqY7AFBIkoQUo7aJ+KoPZfINN8tmWom7YTNV4hX7Tda1VxXorwGDOAgvkFAOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFC295640A5
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

> Subject: [PATCH v3] net/intel: optimize for fast-free hint
>=20

snip

> diff --git a/drivers/net/intel/common/tx_scalar.h
> b/drivers/net/intel/common/tx_scalar.h
> index 9fcd2e4733..d27df34dfa 100644
> --- a/drivers/net/intel/common/tx_scalar.h
> +++ b/drivers/net/intel/common/tx_scalar.h
> @@ -197,16 +197,64 @@ ci_tx_xmit_cleanup(struct ci_tx_queue *txq)
>  	const uint16_t rs_idx =3D (last_desc_cleaned =3D=3D nb_tx_desc - 1) ?
>  			0 :
>  			(last_desc_cleaned + 1) >> txq->log2_rs_thresh;
> -	uint16_t desc_to_clean_to =3D (rs_idx << txq->log2_rs_thresh) + (txq-
> >tx_rs_thresh - 1);
> +	const uint16_t dd_idx =3D txq->rs_last_id[rs_idx];
> +	const uint16_t first_to_clean =3D rs_idx << txq->log2_rs_thresh;
>=20
> -	/* Check if descriptor is done  */
> -	if ((txd[txq->rs_last_id[rs_idx]].cmd_type_offset_bsz &
> -			rte_cpu_to_le_64(CI_TXD_QW1_DTYPE_M)) !=3D
> -
> 	rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DESC_DONE))
> +	/* Check if descriptor is done - all drivers use 0xF as done value in b=
its
> 3:0 */
> +	if ((txd[dd_idx].cmd_type_offset_bsz &
> rte_cpu_to_le_64(CI_TXD_QW1_DTYPE_M)) !=3D
> +			rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DESC_DONE))
> +		/* Descriptor not yet processed by hardware */
>  		return -1;
>=20
> +	/* DD bit is set, descriptors are done. Now free the mbufs. */
> +	/* Note: nb_tx_desc is guaranteed to be a multiple of tx_rs_thresh,
> +	 * validated during queue setup. This means cleanup never wraps
> around
> +	 * the ring within a single burst (e.g., ring=3D256, rs_thresh=3D32 giv=
es
> +	 * bursts of 0-31, 32-63, ..., 224-255).
> +	 */
> +	const uint16_t nb_to_clean =3D txq->tx_rs_thresh;
> +	struct ci_tx_entry *sw_ring =3D txq->sw_ring;
> +
> +	/* fast_free_mp is NULL only when the fast free is disabled*/
> +	if (txq->fast_free_mp !=3D NULL) {
> +		/* FAST_FREE path: mbufs are already reset, just return to
> pool */
> +		struct rte_mbuf *free[CI_TX_MAX_FREE_BUF_SZ];
> +		uint16_t nb_free =3D 0;
> +
> +		/* Get cached mempool pointer, or cache it on first use */
> +		struct rte_mempool *mp =3D
> +			likely(txq->fast_free_mp !=3D (void *)UINTPTR_MAX) ?
> +			txq->fast_free_mp :
> +			(txq->fast_free_mp =3D sw_ring[dd_idx].mbuf->pool);

Is the mbuf you are dereferencing here guaranteed to be non NULL?

Other than that concern:

Acked-by: Ciara Loftus <ciara.loftus@intel.com>

> +
> +		/* Pack non-NULL mbufs in-place at start of sw_ring range.
> +		 * No modulo needed in loop since we're guaranteed not to
> wrap.
> +		 */
> +		for (uint16_t i =3D 0; i < nb_to_clean; i++) {

