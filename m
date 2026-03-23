Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A93EC01BD
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 10:13:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CDDDE40268;
	Mon, 23 Mar 2026 11:13:48 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 892324025F;
 Mon, 23 Mar 2026 11:13:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774260828; x=1805796828;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=iXFfxDvPiKonT6m+q1eRd3PiUXf9wCQ4Bdh+kcv2vWM=;
 b=YV8h0FpmRuXiy8zV8I5jhKV0qHCZZBflvHoH2T6Y+3aKVvDW74sC0bNS
 WSABL5ae1M4Vex24t4xAdr8E5wkVJe3xMp2Q0Zn2D8ufj1F3eSpoZHKlD
 Sh2BNadKSTm8i3nuFOgC1FjxBcN4qPKbfEMkV7IbXVhFkMiQFMQjmthSx
 w18jwBGhREMVhnxqeH3geAoGaJ3M1MY3fa405KLus3m7CDCUjyX/NYCLD
 K4t/cFTVbr3j9Lhvwpd18tVprnhr4ZypkNl2A8hveYyOmo7qMqhqNuhFm
 06jyM0/2lmpRnKZlm9gFsKnE70mpuZIPPbt2pzH0A3lrW8OJDTAoq3T3F A==;
X-CSE-ConnectionGUID: wd7HQOTIS7WnebWYvs0c/w==
X-CSE-MsgGUID: z2RfIKTmT+qhpXhYB69/Sg==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="75161596"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; d="scan'208";a="75161596"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 03:13:47 -0700
X-CSE-ConnectionGUID: qoSmIF6aQQyX19q16JuV6A==
X-CSE-MsgGUID: zj4J8aBTRgC4VwtnrUxtsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; d="scan'208";a="254458183"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 03:13:46 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 03:13:45 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 23 Mar 2026 03:13:45 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.51) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 03:13:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MbX/83z9D7ICz3GX00bw/G3Esx3aiWbOzFTBEv/R1KDZy6dCqoGQgjaXSWOOtQHz1c/OOvc3/RlDoVdh2LHo9mAZ5E7iBuMbQhOhLrarTz5Y766vSjqj1y6mOyvblrf6scV/oQ9z8sh1fScEzZQ5MywbhARmVGSm16ZtRp+xulUvno2LxFdyjN0DBKJOM9HiS+ToVoRDoos8hHHkWf13s1AT3UHc/egOnzH1J7+gc4k7Rs6bu588vyHwAIi8m3AScqlIYeLn1awRg+cxecm7+oKxJlzf+CGbaU+LHJQdzbXefJm504ayJUpLJi5BXBhwWr0Q5BhLPDiTphPEF9+8RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2TxcuXAqrR0Uy0xaAxOPllh3U6KZH0zAxmTA9BheomU=;
 b=hAkLUZmyyRQwxK/+X9KLscX3/1z2oxPiYFJ5P7fmkzopHdX+tXXsOQWKAEfx5v9ti5aPRpYXoAg7Qsb0ryHMazFv5y1TS3mmdcsRqfHV02lLphS2ABIKRGNTbCrcWRIqwuvYEGvvpdNiFQxfzw7BTeQpSfIJjT0flBP6YCWbrHAFJYcIrtX17Upc+5BpisoWzwpn4zLOkgM0x2grEh2SHiH7S46y0TRz1xS8eTnZCxDaKGztAcFOCSNq41RrAxarHKdmaGSOOXDCJDbxIqzwK/GYMwoZxEepegeyUGPdUTTfZH07Q+bkkzc+ZK95uQ+06O0UiFAXWd3Zjcb/abl3Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6116.namprd11.prod.outlook.com (2603:10b6:930:2b::14)
 by MN6PR11MB8218.namprd11.prod.outlook.com (2603:10b6:208:47c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 10:13:43 +0000
Received: from CY5PR11MB6116.namprd11.prod.outlook.com
 ([fe80::7243:ab06:2282:cd8b]) by CY5PR11MB6116.namprd11.prod.outlook.com
 ([fe80::7243:ab06:2282:cd8b%5]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 10:13:42 +0000
From: "Mandal, Anurag" <anurag.mandal@intel.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "Burakov, Anatoly"
 <anatoly.burakov@intel.com>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>, "Yang, Qiming" <qiming.yang@intel.com>,
 "alex.chapman@arm.com" <alex.chapman@arm.com>, "stable@dpdk.org"
 <stable@dpdk.org>
Subject: RE: [PATCH v2] net/ice: fix RSS hash function implementation
Thread-Topic: [PATCH v2] net/ice: fix RSS hash function implementation
Thread-Index: AQHctfltVqMAqHYFIkOLhhDRkrH86rW770fw
Date: Mon, 23 Mar 2026 10:13:42 +0000
Message-ID: <CY5PR11MB6116F7BF0702DD94ED10505BE44BA@CY5PR11MB6116.namprd11.prod.outlook.com>
References: <20260309023255.308526-1-anurag.mandal@intel.com>
 <20260317103203.404781-1-anurag.mandal@intel.com>
In-Reply-To: <20260317103203.404781-1-anurag.mandal@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6116:EE_|MN6PR11MB8218:EE_
x-ms-office365-filtering-correlation-id: ec903f78-36f9-4d28-ff66-08de88c4dc9c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|18002099003|22082099003|56012099003|7053199007;
x-microsoft-antispam-message-info: yjz1upFhgQQ+3SJcN9h/24wceqmQ1eGYsIYepfqDbQz4K1CwwaGVMDCAYpUaDfdByoZgwPy19jf4yTTV5j3uEVMAqt7X+z7W4G3NmCfHd3HW8iGQ7ZlwWl/y6W7tdzbSnaOt8qoMGzU8CF9xfP7fzDBRuPSoM/LXamqbijAoP4rqYsIIQ9FF4SBGl0FfeNCr5XnmIyCzf+YoIgy43WXOvnoNdES47NjzpJ4gKXL24z1sU8CIcLfTwjeejEpD17KzR5N1xLR5Qny/Chf1Klsh05ts1UScRKGh+XYX7Kd7Lq46UOaQ8Aq51uBOe0tKFpF3naPZV9ZIbeVeSLe9Zp7JXiyXhE7cvu2O8/bCTp/fMJBJLZIc7eFbkomXCqoQ6MElLZCqDhcxEJDJ4tWQz0A2PDUrA2K59cwCkqkXfJxXrKS34baMfd/rZS3iCZRcGkGTon9oX4vSp1WglfUnE3D9/W/qoo/YNW123LmKoVh7QoBzmDGDfxm6yKJLT/yRWk1o3VVOA5+buqoWH2c2lNoEdcEx/BzYg/gcgLYKOP2d4k1EtfMKro4osKW97wMyE10T6jZ755ghIBC9ChwvT9xzc38YD/sCFIBFbjv5NNs0oEwOnjEllNQN+SWCCX7V/JalRsxVMXBgjBT57BuGEDvBkm8fB/nJdAtxqU4p0swrQyv/1IW8TTNz4KyZRnq0gkwiKuS75jrLtAoPOqyLq3ZPZ5jRPaqF//T65KnvSI6kLJsoXkn/DExcTbBYDjQy9dF/ddwevg9EJRKEXnJum2PjfCcEerNmBO/CT30XfqSeUj8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR11MB6116.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(18002099003)(22082099003)(56012099003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xVPkB8hLoeGGJOK9WEMFtOAAhs6rFapoeoaPyPsYhhvxB9g9Qx5j7J+vnZFB?=
 =?us-ascii?Q?yuDeUNPFP+rfoNgW3zME3y2YrMxhwt0L325++oH9CLzcuKUoA3Ibcx2eV5Cu?=
 =?us-ascii?Q?Jj/qacby6mAPK1Mul4FdbI8xFpKFu54RVIHlOZcs+mrkYbOyknC7mCQQ7qpq?=
 =?us-ascii?Q?+DCAeU1F0f9kLgI1KseS4t4pqZk000AkVrr17TNZuVirH3mDa2FA3DHq0C0C?=
 =?us-ascii?Q?rUYtMID3Z9RMx0zsmlx6K9Ob6cGcUbNqzGaXCgLvJI8jBse4rDLxmT4LxHDO?=
 =?us-ascii?Q?w2Axyhw7A4MkqazTX8iuJGQtO5j5y3yjMWqmIaiYUPOeFIMXFK30giZ8r66Z?=
 =?us-ascii?Q?y5ecmYmMLKi1DjI879VICJo9VZjNQYAByfznj5eRmnheCn5yD0+D9MoW5JhU?=
 =?us-ascii?Q?A/6Gnli7KG8EVK/lV4SIU7P5y4Fdo6P3YM6eji+i56U4YZJq4GvN0PqXT/9C?=
 =?us-ascii?Q?pe8UXaPP5vxNoZxn6xguML/87APFwWILUjt6YMNFM5lCjiL+Slpso6KOL5HV?=
 =?us-ascii?Q?yVcAdl9Tz49jVS68BdhQmyCQ+vddZHINcVSyOXumiYuU0x7/2o5oTXCcr+Tv?=
 =?us-ascii?Q?qrTnrrW2D/Zb79/5iAMo5Yrojp8zJqJdazxB18lkrZ5c9B/2eY5zhG/6vMyh?=
 =?us-ascii?Q?tzYlfLOwMMGA9LbuntANhpqph8PX/03vrbv6XRzb0OETwVaqBfFQPdMgvQwS?=
 =?us-ascii?Q?eFpl43uiFsU5R6BY2bjnoYz5NdFAggVq7ADbVU15nUm9UNj/CLu3Z1hQWzKD?=
 =?us-ascii?Q?3End2zzahMvIWAa7Qjr4LwsjJYEYfBtQUU/zCNszSaZcg5OpgAEaQCyh8eow?=
 =?us-ascii?Q?11J4ZWTWlof8dLsOJa27YIIOmI73VI1GM2d02lwoeTXSETPAHTXZzTbaWDGx?=
 =?us-ascii?Q?Wm/a3CbBQiYfHzsgoqgu0U1MN1DGY7chI7WkuN+tBNarNM8OFOF+QOG0zs+o?=
 =?us-ascii?Q?qJis7s+LWWlwpR7PnblTNaKiuYeqzv8nE+05yOSIYqMwyJmXiS9muTPZbCHU?=
 =?us-ascii?Q?FcfYS/6PCrYUQPwq81FW5WW83QNmbOiEZ8v79z5mDaMG7KIcLkVvX+jHhjHb?=
 =?us-ascii?Q?5gaHo7JtHtP7RkvJeN4uIzEU4DGgdXtatEUMk9s4tnBskPJVwANLGR2jy+3t?=
 =?us-ascii?Q?R2gqqAuRvVr4jYPYv++UpeUC50icn9CBULX6E1Ewq2uxKhTq+bcL1sXbj2Wc?=
 =?us-ascii?Q?CKhMCXNerOCoDKBFOPLn0s6vHt6kwNcWYWqNFLl04RYsZALjg8Px4POUTLQT?=
 =?us-ascii?Q?ba7T5SHm8b/tKOGQGHcHHmjHhF9dCTiXUrvicuHrLXYLNzf4ri6xxn+2yCcp?=
 =?us-ascii?Q?7B13OXd1IHJvmjn5ie2IrksA2L3zfOfcDMvr6FlCZfU6vC1lKuN9BKtmyPD/?=
 =?us-ascii?Q?LxTSzew41nup/PxJHwu0A/GURnpEfAJKoog0T2Cvg93BRjk/LsK4Pmc9xrhC?=
 =?us-ascii?Q?UwzJNYS9GmS1tPGmdFA/i11bCoLqLc8QHpMs1SDGzdObQ8ucWP4HKpiXj5U0?=
 =?us-ascii?Q?zNAcSqvLu1yLVZdgg9fgxg6AAYaGZCK2U7JoEHKQAyoehpQ8k3FTMQl0K2WD?=
 =?us-ascii?Q?NJ/gcurmxvFd/+7YmZFk035cMa5us29wfi4v05Zd3GpKeVjTmM9Qcpg4k3t9?=
 =?us-ascii?Q?GrXtWT+yhnbOQpL/eLyR/iO54qUy0NW2w/9J4KekcncbvYxHTCDR92aa56ME?=
 =?us-ascii?Q?eclZvx/0c3flv1JkBTpAndkTfROp1YxqubDbgmwaTN9M+QAz5ww+A6ghv702?=
 =?us-ascii?Q?BOhTuHAJRg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: AxJ2K0S0hJZ4/JUw2qEHlL08A19/v4QgEYCtGcBsLgOVKLU3Lyj46jMhvEdGIDaiH452TgB/yMRsKDB7rD5gDMKtTjkbD0f27pzXaXPAwkuT6UBXxLrVSk05hjsFYG6d+eU1OcaxKjoJSIyW6j59t/Dedidxh0L3hP1NsopsX7utiPPw57+EuSIl64yRkPag9WvhVcnSqAe48yqBgyvHpk+K5+6NwS1xNLrVD6emvMlU9vzgMvYFlwsPvuo+6F0ZEQo9QMDwryTF/Grwrs00QXXGF2paNMD0C15apW7M+rS/hLWDYrnDHW2VoPj8HM39OgkqFWdwVZO8UZ3UB9VsWg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6116.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec903f78-36f9-4d28-ff66-08de88c4dc9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2026 10:13:42.8906 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GABPgCWVSx5qrejQlqDlz2EkeXI0IiDAPeA/VWN0YP9HvxqL34LVFka2m4sKy7/zz8LE8BD7BvAkXnxYIXK5jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8218
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

Hi Bruce/Vladimir/Anatoly,

Friendly ping for review/upstream.

Thank you.

Regards,
Anurag M

> -----Original Message-----
> From: Mandal, Anurag <anurag.mandal@intel.com>
> Sent: 17 March 2026 16:02
> To: dev@dpdk.org
> Cc: Richardson, Bruce <bruce.richardson@intel.com>; Burakov, Anatoly
> <anatoly.burakov@intel.com>; Medvedkin, Vladimir
> <vladimir.medvedkin@intel.com>; Yang, Qiming <qiming.yang@intel.com>;
> alex.chapman@arm.com; Mandal, Anurag <anurag.mandal@intel.com>;
> stable@dpdk.org
> Subject: [PATCH v2] net/ice: fix RSS hash function implementation
>=20
> Hash function type is not meaningful for non-empty patterns as they are p=
er
> VSI i.e. they are set globally only &  not per pattern.
> So, for non-empty patterns, user should not specify hash function.
> ICE PMD does not adhere to these rules.
>=20
> This patch fixes that by implementing the following:
> - interpret "default" hash function as "currently set up"
> - store the "current" hash function globally per VSI
> - for empty patterns, overwrite the setting
> - for non-empty patterns, disallow hash function that is not "default"
> or does not match currently selected global hash function type
>=20
> Tested the following:
> 1. non-empty pattern with default hash function 2. empty pattern with
> simple_xor/symmetric_toeplitz hash function 3. non-empty pattern with
> simple_xor/symmetric_toeplitz hash function 4. empty pattern with
> no/default hash function
>=20
> Bugzilla ID: 1518
> Fixes: 0b952714e9c1 ("net/ice: refactor PF hash flow")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> ---
> V2: Addressed Vladimir Medvedkin's feedback
>  - interpret "default" hash function as "whatever is currently set up"
>  - store the "current" hash function globally somewhere (in VSI context)
>  - for empty patterns, overwrite the setting
>  - for non-empty patterns, disallow hash function that is not "default"
>    or does not match currently selected global hash function type
>=20
>  drivers/net/intel/ice/ice_ethdev.c |  3 +++  drivers/net/intel/ice/ice_e=
thdev.h
> |  1 +
>  drivers/net/intel/ice/ice_hash.c   | 20 ++++++++++++++++----
>  3 files changed, 20 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/intel/ice/ice_ethdev.c
> b/drivers/net/intel/ice/ice_ethdev.c
> index 0d6b030536..0948a8cb23 100644
> --- a/drivers/net/intel/ice/ice_ethdev.c
> +++ b/drivers/net/intel/ice/ice_ethdev.c
> @@ -3741,6 +3741,7 @@ static int ice_init_rss(struct ice_pf *pf)
>  	vsi->rss_key_size =3D ICE_AQC_GET_SET_RSS_KEY_DATA_RSS_KEY_SIZE
> +
>=20
> ICE_AQC_GET_SET_RSS_KEY_DATA_HASH_KEY_SIZE;
>  	vsi->rss_lut_size =3D pf->hash_lut_size;
> +	vsi->hash_function =3D rss_conf->algorithm;
>=20
>  	if (nb_q =3D=3D 0) {
>  		PMD_DRV_LOG(WARNING,
> @@ -5700,6 +5701,8 @@ ice_rss_hash_update(struct rte_eth_dev *dev,
>  	if (rss_conf->rss_hf =3D=3D 0)
>  		pf->rss_hf =3D 0;
>=20
> +	vsi->hash_function =3D rss_conf->algorithm;
> +
>  	/* RSS hash configuration */
>  	ice_rss_hash_set(pf, rss_conf->rss_hf);
>=20
> diff --git a/drivers/net/intel/ice/ice_ethdev.h
> b/drivers/net/intel/ice/ice_ethdev.h
> index 4b3718f715..d8a01fe7fa 100644
> --- a/drivers/net/intel/ice/ice_ethdev.h
> +++ b/drivers/net/intel/ice/ice_ethdev.h
> @@ -351,6 +351,7 @@ struct ice_vsi {
>  	bool offset_loaded;
>  	/* holds previous values so limitations can be enlarged to 64 bits */
>  	struct ice_vsi_get_stats_fields old_get_stats_fields;
> +	enum rte_eth_hash_function hash_function;
>  };
>=20
>  enum proto_xtr_type {
> diff --git a/drivers/net/intel/ice/ice_hash.c b/drivers/net/intel/ice/ice=
_hash.c
> index 77829e607b..8e97a6fd42 100644
> --- a/drivers/net/intel/ice/ice_hash.c
> +++ b/drivers/net/intel/ice/ice_hash.c
> @@ -1084,6 +1084,10 @@ ice_any_invalid_rss_type(enum
> rte_eth_hash_function rss_func,
>  	/* check not allowed RSS type */
>  	rss_type &=3D ~VALID_RSS_ATTR;
>=20
> +	/* For Empty patterns */
> +	if (!allow_rss_type)
> +		return false;
> +
>  	return ((rss_type & allow_rss_type) !=3D rss_type);  }
>=20
> @@ -1091,7 +1095,8 @@ static int
>  ice_hash_parse_action(struct ice_pattern_match_item *pattern_match_item,
>  		const struct rte_flow_action actions[],
>  		uint64_t pattern_hint, struct ice_rss_meta *rss_meta,
> -		struct rte_flow_error *error)
> +		struct rte_flow_error *error,
> +		enum rte_eth_hash_function *vsi_hash_function)
>  {
>  	struct ice_rss_hash_cfg *cfg =3D pattern_match_item->meta;
>  	enum rte_flow_action_type action_type; @@ -1110,8 +1115,8 @@
> ice_hash_parse_action(struct ice_pattern_match_item *pattern_match_item,
>=20
>  			/* Check hash function and save it to rss_meta. */
>  			if (pattern_match_item->pattern_list !=3D
> -			    pattern_empty && rss->func =3D=3D
> -			    RTE_ETH_HASH_FUNCTION_SIMPLE_XOR) {
> +			    pattern_empty && rss->func &&
> +			    rss->func !=3D *vsi_hash_function) {
>  				return rte_flow_error_set(error, ENOTSUP,
>  					RTE_FLOW_ERROR_TYPE_ACTION,
> action,
>  					"Not supported flow");
> @@ -1119,6 +1124,7 @@ ice_hash_parse_action(struct
> ice_pattern_match_item *pattern_match_item,
>  				   RTE_ETH_HASH_FUNCTION_SIMPLE_XOR){
>  				rss_meta->hash_function =3D
>  				RTE_ETH_HASH_FUNCTION_SIMPLE_XOR;
> +				*vsi_hash_function =3D rss_meta-
> >hash_function;
>  				return 0;
>  			} else if (rss->func =3D=3D
>=20
> RTE_ETH_HASH_FUNCTION_SYMMETRIC_TOEPLITZ) { @@ -1161,7 +1167,12
> @@ ice_hash_parse_action(struct ice_pattern_match_item
> *pattern_match_item,
>  					RTE_FLOW_ERROR_TYPE_ACTION,
>  					action, "RSS type not supported");
>=20
> +			/* For Empty patterns*/
> +			if (cfg->hash_flds =3D=3D ICE_HASH_INVALID)
> +				cfg->hash_flds =3D 1;
>  			rss_meta->cfg =3D *cfg;
> +			if (rss->func)
> +				*vsi_hash_function =3D rss_meta-
> >hash_function;
>  			ice_refine_hash_cfg(&rss_meta->cfg,
>  					    rss_type, pattern_hint);
>  			break;
> @@ -1193,6 +1204,7 @@ ice_hash_parse_pattern_action(__rte_unused
> struct ice_adapter *ad,
>  	struct ice_pattern_match_item *pattern_match_item;
>  	struct ice_rss_meta *rss_meta_ptr;
>  	uint64_t phint =3D ICE_PHINT_NONE;
> +	struct ice_vsi *vsi =3D ad->pf.main_vsi;
>=20
>  	if (priority >=3D 1)
>  		return -rte_errno;
> @@ -1230,7 +1242,7 @@ ice_hash_parse_pattern_action(__rte_unused
> struct ice_adapter *ad,
>=20
>  	/* Check rss action. */
>  	ret =3D ice_hash_parse_action(pattern_match_item, actions, phint,
> -				    rss_meta_ptr, error);
> +				    rss_meta_ptr, error, &vsi->hash_function);
>=20
>  error:
>  	if (!ret && meta)
> --
> 2.34.1

