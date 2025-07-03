Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F3FC77B7C
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Jul 2025 08:18:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AFE5E40298;
	Thu,  3 Jul 2025 10:18:06 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 5438C40285;
 Thu,  3 Jul 2025 10:18:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751530685; x=1783066685;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=u64yPHt0+bj3Nr0bpm2HJU0iBSz2FAuvw47oC675Fhk=;
 b=MmWVK65DgQ/F7IRFuszH1dg/JyufciKtEdi4g1L442rVqreW6fp/LiOF
 +bZuFQsZ3QpcB4K/69C08aaJJNwLNm3WDmkd6bg0/U7AJSB7TjpR8VROz
 8gX+ADAXoMdl9wQsY7NNH/lnmLLIvg5KtYNr1xZtC1Eqq0rOyMG8nrkLD
 su+9D/tB/9dKps8KtVgfxtdOEWjhhH3usn46WhMEqcjwFmIf/1VFBO/v0
 rci3HsLo2f5f6XJg8NibHOJC4OeYKV9B/f7CMnQPvmWOeQAWjwUIcH9Ye
 6YMvTNKL0EWdDf5R+Sjx1jpWxQ1mGTruqeFW46U4wC2Fa+LkEmv/1YHiX w==;
X-CSE-ConnectionGUID: meiQKvPPQH6oqOuTkBoCTA==
X-CSE-MsgGUID: CfDoFJFlRO6QJAd24U1fVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="53815056"
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; d="scan'208";a="53815056"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 01:18:03 -0700
X-CSE-ConnectionGUID: DLOwyTvfRcm9ROAWrh39VA==
X-CSE-MsgGUID: n70U8J9sQNqzTTSdRp5K1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; d="scan'208";a="153736033"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 01:17:59 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 3 Jul 2025 01:17:58 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 3 Jul 2025 01:17:58 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.62)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 3 Jul 2025 01:17:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u697oBsUXQJb1lHYHloZowrrlCN2IxVPEFeeNTqasp8oc+r4ZdLioy9Najzx6lmQrLU7YwaM0og18OZ2B2pgFnCelu538TH4xbzoB5Qzvf12Po0h4ttld2sS1hyV2froYcdLmYiOCNuI4dSMuqvGHIwesst1FZrX/Y/4k58GrC4swBCH2zRtvqluXrv/lgQIvk0jfnF9funvVmuha8jauIsy8vEQDEzDKME5rNFYk5FZ9blmbug/5Z61s8jh7aY4nFvN/wC3ZoRCA+b5cdk89vsv5xSn5l7aDeQByhQ9gxBbre7E1FxiW7l+8Lk7cHsyCOR4qL/Pln4D+6D3rSwMDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2GTaW6H1K5gQf1SoLprHvYgkPTQIUVzyf/6ruOm6TPg=;
 b=PpA0OsDz2ByP2q4Z7B7vapmBWe92gBeMBgv6YKAz9smG2hCxjPJBkgH/OO5H+XpRSa8R5t17G0z68UK313WxAMyULwNoqZzKYKPC1x7bi5vAYuCgE0hl/5DOinrdau/+In4Ukt8EEOTFAPtxQvgWt0aFgFXLphB5JOKeW6tB7Wb55r/z9OLbnQraUi7mHUJZulugxKtydnxd2VfayspymAoDu3+zVNsAeZ7rWno+u6B2MNC+5TJXPon02kHf3rVgh60raNBX6H/Sm0kBwEzOCh+hmjHnlNDTXKnLVaVWlaKWuV3Q+SNZUvMwegLvmTq/0yOPMZ7iehSvkawvLX1ieg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f32) by PH0PR11MB4934.namprd11.prod.outlook.com
 (2603:10b6:510:30::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Thu, 3 Jul
 2025 08:17:29 +0000
Received: from DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::19b1:dfa1:9d1f:38e9]) by DM3PPF7D18F34A1.namprd11.prod.outlook.com
 ([fe80::19b1:dfa1:9d1f:38e9%8]) with mapi id 15.20.8769.025; Thu, 3 Jul 2025
 08:17:29 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
CC: "stable@dpdk.org" <stable@dpdk.org>, "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH v3] net/iavf: fix VLAN offload strip flag
Thread-Topic: [PATCH v3] net/iavf: fix VLAN offload strip flag
Thread-Index: AQHb635r52J8+dM1xkOk37Sk+UPNlLQfKiUAgADj3ZA=
Date: Thu, 3 Jul 2025 08:17:29 +0000
Message-ID: <DM3PPF7D18F34A1E4C9969B1703BF0F09B18E43A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
References: <20250702182251.96427-1-amiyaranjan.mohakud@gmail.com>
 <20250702183856.99326-1-amiyaranjan.mohakud@gmail.com>
In-Reply-To: <20250702183856.99326-1-amiyaranjan.mohakud@gmail.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF7D18F34A1:EE_|PH0PR11MB4934:EE_
x-ms-office365-filtering-correlation-id: 0719496a-1e75-4ce1-2974-08ddba0a0d69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?M+f8hwrSDETNB+3KJ0Y7uEN8te+AiIBrfiE03wXY0Xdlrg1P+vXcAOV1nLUG?=
 =?us-ascii?Q?x6+RUE1KcRm+AZ0Um5SO5w3rrlQQGU5oCzaJSVDEUehWV/Lov/VC8Bgw9mv9?=
 =?us-ascii?Q?QeoaKf8LmIizuj1Qa6Ei++EtQEYDUJbNt8666THiSCm3lIDJSLDuBzVjrhrE?=
 =?us-ascii?Q?744YKt72EtGxSsG3jeZ2TOL91+t6G5J4bISQd75DIGqyPJ74IUd9Gj/UQ3zQ?=
 =?us-ascii?Q?Gjo5q8pYxMHGSqMfN8ZmdPcNcvBdqpLMuwl+5fihSsOBrQ9y1hkaqAX1rixj?=
 =?us-ascii?Q?KKtBGEb2udKV5FY4nBfzy0C2y5sSFLmGXrwdPGM8/4CeBM7OVz54wtyMJeT2?=
 =?us-ascii?Q?tsN7BHcPABKtMNUMeLXUMmOjJhx/00ixRy/gp9jDoiJXzgxeGAU87bgr/Zps?=
 =?us-ascii?Q?/v2F0wXmu0uM0oYko2yykei53GcNMyG8YosT4xCjYPAlDoQYB3/eINHNEd+u?=
 =?us-ascii?Q?Hcp94l2LCe1zYu9KcdgXeIrR5V3czcKoI0a2F/iTHizwvuVM3+g2e+0rHDYA?=
 =?us-ascii?Q?fCrIyqgMzmMKl1tE8o5mTwzYwM3GyD002qutfqbCQSuVaO9P5jKn7IcX7xWb?=
 =?us-ascii?Q?IKI5K2H6Kzncw+CW6CKwOUyvdyda4XTyREruur64zbb1dkmJdptFRkQgLt9Y?=
 =?us-ascii?Q?PsuFe4t3lw21IM7jLJ5S5qivcV802rUzvtaHOFMYWUxL1NZYXZOMfTUnnzVg?=
 =?us-ascii?Q?LJWZSN9vGkM4y/d8u1OL3CnSEOCG6B46dePu9fDkaYg/Kvl9I4fi7qXrzPqD?=
 =?us-ascii?Q?Wcgve9GKhITHAkel58lwHysD9qGQNhpLutBYxGlNMrrPrEA/J4wGjmaIXoev?=
 =?us-ascii?Q?rU3ec7cvNe4YE0q2SDeyJfa+r1mTX74Wb7BE9kzbF4a9l1BfFgSwpQf1eTEs?=
 =?us-ascii?Q?Rrjhvo9KSFphjMQCRKzwmo6pmH8nGR/cS8ajx9PtGjaog8S+6YDEv+stYGuq?=
 =?us-ascii?Q?nvr7HscKdFDbi69bD4mKUEXgi7Wc9EgtFwvK0SrGmgP49aTf6w+/Wg32/tZi?=
 =?us-ascii?Q?gVbms5041RKRykB2UDhidwHW5j9mRjtiWLzol913y5rPN+WMIVfcYNG8QU70?=
 =?us-ascii?Q?i4ncQkc5bMuLoRphSgKhRA8Blr2R6JVbpJZZZMSdTm58/VyXMvTt59IRYXvQ?=
 =?us-ascii?Q?vCpPSb74WFZIT5EP43P1YiQOQZzoNK864/DlPP2z+aKgdJkZ85bqkphhOoHZ?=
 =?us-ascii?Q?+nK6xK2UKbyLyusv5XP+6qk9yBUbyxL5uHw8Jery5w5dVwSrXlbeVVBQ0PpH?=
 =?us-ascii?Q?SacwBSOlqj3cxchqvs7DLTp9xk1CIOAW/QIYDwvcikZzDXgBAA4UqnW7uxuK?=
 =?us-ascii?Q?qjlS6/z3LoDgZ60LWocbLE/pmwmiOXWYO2ao4/gv1UWjdf6GGG0xByPl/SLc?=
 =?us-ascii?Q?dLCxbeEOgTJY4Z0kpeOHSJiXh2p4ntq6OKQ/0Y+RBxhbibRHT3irGCJQ7mzX?=
 =?us-ascii?Q?b8WCV3i8aMPnHwcGIRbl9btNi51iBLJxNS8ibhWXMfWfwL2n9/VIlw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF7D18F34A1.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?U/SWC1vQuQV3GM0x15oyDY13i4w+dGB8BushkN57uCxX8aUuHDQuLSXpdjFL?=
 =?us-ascii?Q?P09YoIgf1ZnIzHEzaQeIxteVoBmg49eURyL0BkkWieRO79nzURcH++jD9SrU?=
 =?us-ascii?Q?hwiFuITlXujxNiHSMFz+26Jry/IjbPY8C1UQt6Ba4PrMQqIBbUWVyeKAdQxx?=
 =?us-ascii?Q?gyd+8i2MO3dUQnOkQgzXYS3bX24M03vJ9Y496wzSAxgqn5Kp/mbi3j/bnSLz?=
 =?us-ascii?Q?lUO+PH1WdR3m5YHKuKpvv+MSIGYFDIWRyY8b0focovsZZXyieQAynQwjyQl1?=
 =?us-ascii?Q?q1mIat7rRttp7MrdpwvoqkhnrqQ+HKn4XBbQj+yEb76ccPNSDMFCzXsToJ2x?=
 =?us-ascii?Q?9wGSJikun0zQmD8fGS/3zbiqdixIfPGV5tUQq4uQdhXOJ+ld9qVYiGHYRgdN?=
 =?us-ascii?Q?P9qmCSQIUO77YKH1VcMOI9ayFj/VA0LOPzJAzAsx+SZyqwjZnIPobJ8zDd1U?=
 =?us-ascii?Q?m8TWGqBIWJ/K83bmNgc9kNDPQKgn+O6vqhRK6ad/88hgb4F9d4oO/qgUOrJL?=
 =?us-ascii?Q?3YoLLWXybPUpfNKLGjtUpScfCHgCPx42XCdeI9bseFbzqiHW+l0FA2fYAU0l?=
 =?us-ascii?Q?0hjhqnxaSntc64rauINcFDBBIexdx40ireMjKwQ3x244cpVo47Ds8cjn5NMP?=
 =?us-ascii?Q?A/MoNSI4xh15k+E+NRtRTAlcchzTF/FEAWGyI+Cg0MJ8liX5YcwawcA9g+78?=
 =?us-ascii?Q?OUbuZHuXKSIrPxuHFurprxQvxBs/d7lbW1AzfAlu+ExM1Kob1Zg0GGgv78uA?=
 =?us-ascii?Q?XFA8HkU2bSovh/aNSeVYRdHvuMCZ3rPSupihhYDLt9OoiUAdbEY94tqhhlIQ?=
 =?us-ascii?Q?eCKYuFNltl8rdM1QUyoT3JeaoPr6aegIaTqW4mi3oSTwiieAHoA1Ala5P/J1?=
 =?us-ascii?Q?ILpn1bJiML26mSPFSdvqHj6eOjaZyX40KPK3QBMMO6vN7lpmgxt5+RGrBMy5?=
 =?us-ascii?Q?08FYtBXJ5SRE1rR2s/oiKf3aIm5xpqYu+vM7WrccQIbdA3VRDhJNYI03W2Y4?=
 =?us-ascii?Q?k/XX0MkAtrgE1zT440SO+nrtKY+7/R7QA7IXS2lsj6tCrJGZBlnHSEDHP+i9?=
 =?us-ascii?Q?3E9xdzwMv+IPsQYyK1WHIVNDCtEqOF11Q+EM7MVE/S6jdm/g/8KorjJGlXSS?=
 =?us-ascii?Q?NBNz//j5zwW2fcGemh2hpFpdwSciofeI0o3ApKA4zOl6BetxxM49v46UYHR/?=
 =?us-ascii?Q?ovZ4nBvd7x0eMqDObm8GnlLaCARPRh/sye97/NJTgqYFz9ktiDaOOp4/Ajkn?=
 =?us-ascii?Q?KqWzCI1t0vKhvBYK5+E0E26pin1hC1YhjZX0Ko8cBM+GN+pfmrDrqqASw8om?=
 =?us-ascii?Q?p5/n0faG49X9Shk3ucoELln/Ch03j1vb2tqt5g9MAadlbYF5JgeLiYAZZBdB?=
 =?us-ascii?Q?sKD/3ylqIhqqlULEIb6hqfhbXCYmYJ8dBfWQf2yDB5930WllLgfh8EUjNm9E?=
 =?us-ascii?Q?AAPsI9P4M8V8cJdbPekBaehpGA7BzG6+wnbEy95UaCl+whaGuJcBY7oySs7B?=
 =?us-ascii?Q?PzVzO7r69C9LCh3h27HA7ZIo+Al7+CX1ieu9ynOmoq9uoRVvAkIElAC3RZ92?=
 =?us-ascii?Q?xtScV4jNjhOOetcX8OsXYTOeWNt3nyGOG0fyW2R+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF7D18F34A1.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0719496a-1e75-4ce1-2974-08ddba0a0d69
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2025 08:17:29.3456 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dXJvx+yYH6DLG+nADIOUjdyVsbZNTM47BnyFgRNgM/QLBk1Nf1YzPxsZHLYyMizuf99n/mbvR2D5TtgHMhYTMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4934
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

> Subject: [PATCH v3] net/iavf: fix VLAN offload strip flag
>=20
> For i40e kernel drivers which support either vlan(v1) or vlan(v2)
> VIRTCHNL OP,it will set strip on when setting filter on. But dpdk
> side will not change strip flag. To be consistent with dpdk side,
> explicitly disable strip again.
>=20
> Bugzilla ID:1725
> Cc: stable@dpdk.org
>=20
> v3:
> - Fixed the vlan(v2) scenario by calling appropriate api
> - Addresses Bugzilla ID: 1735
> v2:
> - Fixed indentation in commit message
>=20
> Signed-off-by: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>

Hi Amiya,

Thanks for the patch.
Since your first patch was already merged into the main branch, this patch =
is considered a new patch (v1).
If you submit another revision, it should be labelled v2.

Since it's a new patch, it needs a new commit message. Something like:

net/iavf: fix VLAN strip disabling for v2 capability

Ensure the correct virtchnl op is called for disabling vlan stripping by ch=
ecking if the device supports either v1 or v2 vlan capability and choosing =
the op accordingly.

You should include the below line in the commit message which indicates it =
is a fix for the first patch:
Fixes: 3bfad066f9b4 ("net/iavf: fix VLAN strip setting after enabling filte=
r")

Thanks,
Ciara

> ---
>  drivers/net/intel/iavf/iavf_ethdev.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/intel/iavf/iavf_ethdev.c
> b/drivers/net/intel/iavf/iavf_ethdev.c
> index c33fdd9069..335a8126c4 100644
> --- a/drivers/net/intel/iavf/iavf_ethdev.c
> +++ b/drivers/net/intel/iavf/iavf_ethdev.c
> @@ -1388,6 +1388,7 @@ iavf_disable_vlan_strip_ex(struct rte_eth_dev
> *dev, int on)
>  	 */
>  	struct iavf_adapter *adapter =3D
>  		IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
> +	struct iavf_info *vf =3D IAVF_DEV_PRIVATE_TO_VF(adapter);
>  	struct rte_eth_conf *dev_conf =3D &dev->data->dev_conf;
>  	int err;
>=20
> @@ -1395,7 +1396,10 @@ iavf_disable_vlan_strip_ex(struct rte_eth_dev
> *dev, int on)
>  	    adapter->hw.mac.type =3D=3D IAVF_MAC_VF ||
>  	    adapter->hw.mac.type =3D=3D IAVF_MAC_X722_VF) {
>  		if (on && !(dev_conf->rxmode.offloads &
> RTE_ETH_RX_OFFLOAD_VLAN_STRIP)) {
> -			err =3D iavf_disable_vlan_strip(adapter);
> +			if (vf->vf_res->vf_cap_flags &
> VIRTCHNL_VF_OFFLOAD_VLAN_V2)
> +				err =3D iavf_config_vlan_strip_v2(adapter, false);
> +			else
> +				err =3D iavf_disable_vlan_strip(adapter);
>  			if (err)
>  				return -EIO;
>  		}
> --
> 2.39.5 (Apple Git-154)

