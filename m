Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C938BCD8C9F
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Jun 2026 09:58:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 642D3402AD;
	Mon,  8 Jun 2026 11:58:58 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 579F040265;
 Mon,  8 Jun 2026 11:58:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780912736; x=1812448736;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Uuc5C5eOVuTLjxMM7FEAt03zYrtsAdQJF+mHcdz1EFY=;
 b=aJNIV3thC55hV2Ph/C5kDalagQc+4clHYZYfUeT6DqU/MLAmQakTAQ7u
 4Rk/3AxmHlVrNN43+gfslEtvUODyWSzrcuVOjJeVPuYXutWyu1UF5nEU7
 yZtbJePzAmzZEwd4beqk5D2hErIP567yiw6+wndF7uqXEQGNSc46PaQnI
 v7xMI1dURQItXugQaa/ASjfKDl63zj1ki0SWXSeu9P5QWofOVuHgnknTq
 MCG9v/AG/Uz/kozLlTchTC9C1UXz/q6fPsM3E4i34NMEbITJeyrweiWuy
 xwv061ppyV7SfefaxysubcgLy8K2jmf7Y6o8LJ5uCpekXebA8gTOSOB9c g==;
X-CSE-ConnectionGUID: PbZONa5tTjmY0UNasjs55w==
X-CSE-MsgGUID: jZ4Vhx5vTNOgv+b+nnXmQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11810"; a="80777961"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; d="scan'208";a="80777961"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2026 02:58:54 -0700
X-CSE-ConnectionGUID: 7WpkgCJiQwKyM+ky488E3A==
X-CSE-MsgGUID: JBpkAuBDR9ChapM0cwEsfg==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2026 02:58:54 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 8 Jun 2026 02:58:53 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 8 Jun 2026 02:58:53 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.38) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 8 Jun 2026 02:58:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OXmNCo4KkaU3Hc4m91dTI2TwTO0GilGNxrxUoZUq1ECz+x44sGtgYQ/wmIcwoXqrvjC07Rw58wCIwqgYNs0xYok3zOTd9jS90vAmICOAjIJxTIH3szZYEvzRZnw1lViyE835DnF2H02fg4n/YaxKiv7Vu4IJ9PYWrgnHkikX5nwANM7i76mTBVW9yLKcOvXpt4mtWVO62iC1ofVYC5GZ45zHgaXOon3K55ONolaVS4rPA+5gw67schfhISvqL8zpg0n3ysCd5g7p9lt3MU2tBLSGywHXRrvzW1v0kmLfxcSBL0Y9SZvxYjiWBh7KFdqBkIp4NqbZZZX93OKlE2edCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=REBSmUEHeAN9IQOG2Fo2LhNNwZvN1mKP6Q7iyddpRg8=;
 b=paBIAqYHjAGc/hwd6r1QSaWOsbE1hTGWX/KzxkQocqQYDhtwnqI+XZNdk1hWXy08LFV6jnMX5jkLZYAU1xpkLP1gUxOqqkQxGx+2PYYYASNEJs6sFR0vAUgA2xCn5ggzGcnPi0WHsp/gZzORF4VXoAfuJfWfr42M4hqZdisKKSnIL4p4povk40PtOxUQ4l9sVlhLdEB3T0PTT3Cp81oUdTPoQ02Bzv0Z2Bx9XYSnMj2idPLvcyZsbSE/QnjwEB9cDrauNGYQ0gCvtaAZYwkJWhiGkwv+DQDygG89M7IYRkJ6Dr1MyV5YXU786+pz/BFYp9IkX3rOPFDDNoYvoKdoSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA4PR11MB9278.namprd11.prod.outlook.com (2603:10b6:208:563::12)
 by PH0PR11MB4869.namprd11.prod.outlook.com (2603:10b6:510:41::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 09:58:46 +0000
Received: from IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057]) by IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 09:58:38 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Mandal, Anurag" <anurag.mandal@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>, "Mandal, Anurag" <anurag.mandal@intel.com>,
 "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH v3] net/iavf: fix duplicate VF reset during PF reset
 recovery
Thread-Topic: [PATCH v3] net/iavf: fix duplicate VF reset during PF reset
 recovery
Thread-Index: AQHc9woQ8tpgZfyYiEOxc1nIwyjEK7Y0a+7Q
Date: Mon, 8 Jun 2026 09:58:38 +0000
Message-ID: <IA4PR11MB9278AB660100B34D0001DC478E1C2@IA4PR11MB9278.namprd11.prod.outlook.com>
References: <20260605202911.314359-1-anurag.mandal@intel.com>
 <20260608054433.351880-1-anurag.mandal@intel.com>
In-Reply-To: <20260608054433.351880-1-anurag.mandal@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9278:EE_|PH0PR11MB4869:EE_
x-ms-office365-filtering-correlation-id: c2380764-1d35-477c-e567-08dec5448389
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|366016|376014|1800799024|38070700021|4143699003|11063799006|56012099006|6133799003|22082099003|18002099003;
x-microsoft-antispam-message-info: jPibZ4PXAbcv+vtMbTSGK7rpyyXMxvG10t3cF8/stqvKJCacl74lW8wUESqhLV+bzhkKixmMPErfM5rQutwpaoorkzFD7dEOHpiyoJQNMD3pfvpPUX+QYm91inHAsxJrUxJ0PQ66WXx7lU84h4wrro8pUDggAk1kuZ5F1ZEgpovJzpoQ7AT/+mt7bRbTlKO0JVN4IowZZn9krvAy1e8OEKUNC55lejfAnAIu14NCA7thzFVB914BEaozJdGuWmXE41iakEAkHYIhF2qWWQ3vVaIRWGJt8gj1n+KWSCmiJktNoR+vPTrvNMIQORymJheP49cuSyi2f4by66qtT1APNvH9IjhiSj5F3+zOAvDWUutZnIqYuAwsVMY9cC08AzGbCx7d87pwCmLPkgfim+kkF+xiJAgK4jQRNOBdquX2kgIyECpoIuAa5O8EQHCl+djCGdHa1iUg48cwGU2Ie7NvW4FXkiQcrCtHDYhA6TJwhM82EkipisVEv6neSfliLdOGZ8fDooC1Lt9asp0TtlDKWXbSjfJsOQqReIWRb7pQneOW7k5Kj2eGwD8tPBC/fribuDmTllYpFh58r78Hnke3YbIT3fYQnoGdC/tYwxxa5posQs0GDAMbhUVfmxnLSwVLgILsmcFvDval3E46P79xHy3DG0vxxNtBXihF7x0BQG9nQodx73kt+RpvTpexQnANh+n4f+BxCp76EjglKd2y1fnSRt1Y3ypRMAW4uleAKZ9zXJ9Qo4VRR7HYoS2QN8Xs
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9278.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(38070700021)(4143699003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eUPOCMBlP3kRDazgdi6si5VJo+X6wHAdE+j8/YwYuwdyHkTW8vsZ/SBqLARx?=
 =?us-ascii?Q?1jiJLNvCH8vMXWfS8CVUTiFh3XCK6i39qrZPmZ7NwEeb3CXpC1tlvDAMla1q?=
 =?us-ascii?Q?kt6b7XBASLAasp8pl1XOalQbdWMwo/nGFHdxOvR1b3VemJ6jpDIjcN+Pg+gf?=
 =?us-ascii?Q?AtZL6P3wb8/Pnw3iE+ytaXsO2Hke8QRntxVgkxn6UALOlDx+VVMGKoVg14Of?=
 =?us-ascii?Q?u8FymnBKBny6gjKzLkuTqlQ56HekhUq9GD6OhTiK7iBY5+go9c9s2cN3rPC3?=
 =?us-ascii?Q?k5t1rY2aKtBtW+3cVhtk5VYCFT21hqQzmD+sIpBqXJKSEfe9ePVZ44HNDepB?=
 =?us-ascii?Q?WjBZh+DCcby+VvbizmWatLZVilUG0ddCaj/2Wyo9q0fE6EBV4BU0rM27hiGE?=
 =?us-ascii?Q?bzLZ/Fg1isOyrX3hDbtHleh1Ij1EDzIM5R93sQji5laEmkhbzfHmVztpF29t?=
 =?us-ascii?Q?T32tgk7iY3NKYRTGazazDrZ/QZsZwzvTlpTH3Is/HcracxV0jTTEZ+HQGniW?=
 =?us-ascii?Q?NImamYjB3A7upalaqMtePk5+souq7FP8ja5uXH56cjAm5gaGqvbb8gZNWH4o?=
 =?us-ascii?Q?34c39MewCd8W+EhCPcjS08mVuP3a/5laIcWwma4ufaMWkW5HwHu+d+zsLqY9?=
 =?us-ascii?Q?7fTwFNqoHY/BF6rx9o4kcLx8nstfHWBwVZe9ZjUDYZsU9SrPEwfSHH2TVTYt?=
 =?us-ascii?Q?0TPDCJHw7uqHjiInelAA/GeObkQuduvPQVorGFSxacJd/JR2JuA7ze3VoiGc?=
 =?us-ascii?Q?ONYOdL/sk+t+m3s7llhBq6v1/MtTxRnONA/LcxHwm9juKwnFppnLVwySYP7p?=
 =?us-ascii?Q?8vcqEZIXIXtiokdYtFPOk2JtS0l771aNUZRS6fpdPADED4PEJ5ez7TBFpqna?=
 =?us-ascii?Q?szfXniN3IP1/R2VC2X8F+D6vVKlqKjk+du7R/t9/AgqgSINzbt2zIH1I3Hmo?=
 =?us-ascii?Q?nz9FPjN0T1BQcK8AymIIQkveD9Lhd/jZfZ5O7EiRNyYXrlD7ETYwbtcV5GSa?=
 =?us-ascii?Q?as8Q+H1aoTG8+F/+YXQcF5zznwTGfBrIBjANQtbBrzWs0dyTRMPUq1L1ou8y?=
 =?us-ascii?Q?LMDIbmFaVmQFP6JiWeGshH8hVSwlJWOsfOm9Ay82K+c3C9isqk2G/7WxY0Q1?=
 =?us-ascii?Q?IdwpgU43qbMKC6FjyVVOyGAbp7UbGV34W1C22Yj31imJWMNXYZKSbvTym934?=
 =?us-ascii?Q?/D2pO9eHsiHEXKdy8UpXjXE0MYvrxDSLU4Mwlr+QByHqqgI01oHKWjI8kn35?=
 =?us-ascii?Q?t0vfvSqThVyVp/gBi8OArMbdA0WwB1mjT27vQLil0HRlyByps27EsNL3nGQi?=
 =?us-ascii?Q?6pI45nXCsn10AK02JbcCH9JpR6rh85Ace7XKUuc6i/gJDujaT3xRNmBV/9tg?=
 =?us-ascii?Q?wA+918DuPpTjDy1ym/Ab2MfX69DjBO/dJaGGcBumoEsmowMhpO1A4DWochaM?=
 =?us-ascii?Q?rIExS7uYitVluCQKZX2IThZ7vnOpL4jyC0KwsxbbdUS/K0ZSe69Ek1qGVgO9?=
 =?us-ascii?Q?dvwZeLLAKKnvTZ9c6QppXq7p0SydV2U8pxwzVT0AMbnF05K737hV6OmmNwGL?=
 =?us-ascii?Q?W1MQsZp8mF0p0rxwWCWvmHovkrN1u3YAu5qxcOO0h1JXvP6WOnK3M6u3LjUG?=
 =?us-ascii?Q?0goTN27FkZkBMOOAirYyzrlKu5IHccmnertL+NN8zrlia80nmwHrPZMZtEDA?=
 =?us-ascii?Q?HZ0vuvUODJwh490GRVmjNVibhi6nzNln1BROrkKuy/TDRRLnOyMyC8BwBoXS?=
 =?us-ascii?Q?+1xK5FUSGrFDRnxU3rLS+YgtemBaUFzFfs9664HAtgFo9DWFLlVs4hl8XlmE?=
x-ms-exchange-antispam-messagedata-1: ypbb3vn0aTJ4hQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: mAdsqy1EXwgCm8thMBHCc50dct/599gsbCG9NtB0yeanYxy99H+K1Hu+z2nGA/a+zVXLsSgOllUFNDMHw8lpsUE0zp56Co8+BHOhXDn2+8vUHClxcZRTdIt7BKPZm9CBU+bPvPCLhZAJx2kqnUyi10Mbk+6+2xPu39kHyh6NI+T/r3XqW6EyEpF0ETw53B3bE+3aJTVJWrYX8nXD7vD/xk/j+q9wCj51j7X0ADLfXbxqGGEXLVrU36cF/m6dIO3m9e2CZlXnPM/8LY3ff+b81ASAIFTt+7p7WSW+fj3uIbCVMg1x+WIC2QshHKi9SxI/LhPRm0mSN4yYD/pFVHX1cg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2380764-1d35-477c-e567-08dec5448389
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2026 09:58:38.8431 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I8Oyl3i4B9/i9URmMLYv036SwN6uw2Bd1EN1ZRNYk57ww6mKCaZdGeIg8aOB4hO9w+EUOW1QDHQpranlR8oWkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4869
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

> Subject: [PATCH v3] net/iavf: fix duplicate VF reset during PF reset reco=
very
>=20
> During PF initiated reset recovery, iavf_dev_close() sending
> an extra VIRTCHNL_OP_RESET_VF while recovery is already in progress.
> That second reset can leave PF/VF virtchnl state inconsistent and
> cause VIRTCHNL_OP_CONFIG_VSI_QUEUES to fail with ERR_PARAM after
> ToR link flap/power-cycle, leaving the VF unable to recover.
> This results in connection loss.
>=20
> Skipped close-time VF reset and related close-time virtchnl
> operations when PF triggered reset recovery is set. This is
> done to avoid a duplicate VF reset, and keep normal behavior
> for application-driven close.
> Handled link-change events through a common static function that
> reads the correct advanced & legacy link fields properly and
> updates no-poll/watchdog/LSC state consistently.
> Also added IAVF_ERR_ADMIN_QUEUE_NO_WORK in virtchnl message
> drain as a normal empty-queue condition and avoid logging it as
> an misleading AQ failure.
>=20
> Fixes: 675a104e2e94 ("net/iavf: fix abnormal disable HW interrupt")
> Fixes: b34fe66ea893 ("net/iavf: delay VF reset command")
> Fixes: 5e03e316c753 ("net/iavf: handle virtchnl event message without
> interrupt")
> Fixes: 5c8ca9f13c78 ("net/iavf: fix no polling mode switching")
> Fixes: 48de41ca11f0 ("net/avf: enable link status update")
> Fixes: 02d212ca3125 ("net/iavf: rename remaining avf strings")
> Cc: stable@dpdk.org

Hi Anurag,

Thanks for the patch. There seems to be multiple logical fixes/changes in
here and I think it would be good to split them into individual patches,
each with their own Fixes tag where relevant. Having multiple fixes in
one patch with multiple Fixes tags makes backporting tricky.
I think at least logic which prevents the RESET_VF during a PF initiated
reset should be split out from the link-change logic.=20

Thanks,
Ciara

>=20
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> ---
> V3: Addressed latest ai-code-review comments
> V2: Addressed ai-code-review comments
>=20
>  doc/guides/rel_notes/release_26_07.rst |   3 +
>  drivers/net/intel/iavf/iavf_ethdev.c   |  37 +++---
>  drivers/net/intel/iavf/iavf_vchnl.c    | 155 ++++++++++++++++---------
>  3 files changed, 123 insertions(+), 72 deletions(-)
>=20
> diff --git a/doc/guides/rel_notes/release_26_07.rst
> b/doc/guides/rel_notes/release_26_07.rst
> index b8a3e2ced9..e7ac730369 100644
> --- a/doc/guides/rel_notes/release_26_07.rst
> +++ b/doc/guides/rel_notes/release_26_07.rst
> @@ -89,6 +89,9 @@ New Features
>=20
>    * Added support for transmitting LLDP packets based on mbuf packet typ=
e.
>    * Implemented AVX2 context descriptor transmit paths.
> +  * Prevented duplicate 'VIRTCHNL_OP_RESET_VF' during a PF-initiated
> +    reset recovery, which earlier caused virtchnl state corruption
> +    and connection loss after a top-of-rack (ToR) link flap/power-cycle.
>=20
>  * **Updated PCAP ethernet driver.**
>=20
> diff --git a/drivers/net/intel/iavf/iavf_ethdev.c
> b/drivers/net/intel/iavf/iavf_ethdev.c
> index bdf650b822..fb6f287d3c 100644
> --- a/drivers/net/intel/iavf/iavf_ethdev.c
> +++ b/drivers/net/intel/iavf/iavf_ethdev.c
> @@ -3166,24 +3166,27 @@ iavf_dev_close(struct rte_eth_dev *dev)
>=20
>  	ret =3D iavf_dev_stop(dev);
>=20
> -	/*
> -	 * Release redundant queue resource when close the dev
> -	 * so that other vfs can re-use the queues.
> -	 */
> -	if (vf->lv_enabled) {
> -		ret =3D iavf_request_queues(dev,
> IAVF_MAX_NUM_QUEUES_DFLT);
> -		if (ret)
> -			PMD_DRV_LOG(ERR, "Reset the num of queues
> failed");
> +	/* Skip RESET_VF on a PF-initiated reset */
> +	if (!adapter->closed && !vf->in_reset_recovery) {

adapter->closed will always be false here so the check is redundant.

> +		/*
> +		 * Release redundant queue resource when close the dev
> +		 * so that other vfs can re-use the queues.
> +		 */
> +		if (vf->lv_enabled) {
> +			ret =3D iavf_request_queues(dev,
> IAVF_MAX_NUM_QUEUES_DFLT);
> +			if (ret)
> +				PMD_DRV_LOG(ERR, "Reset the num of
> queues failed");
> +			vf->max_rss_qregion =3D
> IAVF_MAX_NUM_QUEUES_DFLT;
> +		}
>=20


