Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4CFC88E75
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 13:05:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5B51940DDC;
	Tue, 15 Sep 2026 15:05:23 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 9888A406A2
 for <dev@dpdk.org>; Tue, 15 Sep 2026 15:05:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789477522; x=1821013522;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=iqXwghF1W6A1LvHmUT+7r6i10tBuWZ3iCYsM0ZeuOSc=;
 b=m3B1f9EpufswWzKaiQIHSq1fdBQiWt8vTo2htpupUqva545EXAvHYtpu
 V/8ZaOfq+YBBC9zd04GLler+FwRhWMUJULTWWoc5sbQ1z5XRkgStIIK1h
 Uoy7j/KURlNXQ6RL/Uw8y1zRnHSbhurMSOiMZfrY5NFOkZmuQiRM8jXrh
 AGsxNneVb7lQVFW5MFTgpxjNXK+7UeBMbvSoydv+ag819p1I63dFp4I1p
 Vwlx2KwuSzCaHtsa0NTQMCMDIuyOGn1D2/a9YftFx/t1X0Yj1PD3zTN/Z
 /Uula4KtDOy0VT2AVndFkHMb735BU/RpPEADVjf0mtuh6sXgDXYZd+lSm Q==;
X-CSE-ConnectionGUID: fYIgnbmtTu6W8Bf/SW0Wkw==
X-CSE-MsgGUID: HjH3LAkQTK2TvTH2GSKAjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="93538119"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="93538119"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 06:05:21 -0700
X-CSE-ConnectionGUID: c9EWfiWzS52TrT4vjRtVfg==
X-CSE-MsgGUID: fkWwWksRQjSSxX2hnMUfTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="276530950"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 06:05:21 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 06:05:20 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 15 Sep 2026 06:05:20 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.10) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 06:05:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NogDVjE57JedsdS+U8MKpTSc9eUpot+5VfihKcQA4ndOLD4aqr0fFxQD1pmDyTWj96Qhim+8U42kT+CQsueo86OSJL+Jjps9Jqe0jVN85Rl3ENq5oodemSoKwfwLwMMe4Uup7KGXoSUvfXb3yvT12Jwo58KDrpWz/zOPK5vHW4c8Y8g4G3zhI5cpSA8UDWsY7GAHw0hhLEgW7bTt5Q2rouh7++X2eBAMT4AnmftQbwE3N5Xh2fFL7SS5gALAR9Z6VTneLKtVWo4HwI6FyYUVKAnj901frk9v7AAOtb1IwN4DWKwAM9yNZoJiQ2M5QSRvaiDQK+n8PZP5REWeTvTFdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7dEYSD/BbZX2ugQ5vP99wf6JEm2xNOtsvxepUBzTki4=;
 b=nllMCptlfPw6pji7LLy8TbNz8BHPsj+yKkKjE7dgtGqo0dSLaWAOeInQ5i8cle7CoWu4NZUi/as/uqXygcEs190tv2kGd4zevtfHYvmmhRfN3I2AvndIzUvIeMsa0p2DJKUiDhfjRqD2USrlK8K1L3GgAEVCqHTa5BzI100FmcWHvPItzHGP0lDc2VO6uTG+yCRBrpUgekSf1IROgVwU8+f77Sja6zoMNUoKlXOH0EMG8r1bIKpXkGEy+rirHbEHODopMr6gB5TrRsWj5KXOg+YZqW/srai/EXNaF7Z7d3Bx1jv+Dx+s5es+XntAhs1Nzi13PfvLaxT7o26O6QD6cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from AT6PR11MB044526.namprd11.prod.outlook.com
 (2603:10b6:170:110::22) by IA3PR11MB9135.namprd11.prod.outlook.com
 (2603:10b6:208:579::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Tue, 15 Sep
 2026 13:05:11 +0000
Received: from AT6PR11MB044526.namprd11.prod.outlook.com
 ([fe80::4301:f255:af66:888c]) by AT6PR11MB044526.namprd11.prod.outlook.com
 ([fe80::4301:f255:af66:888c%6]) with mapi id 15.21.0428.008; Tue, 15 Sep 2026
 13:05:11 +0000
From: "Mandal, Anurag" <anurag.mandal@intel.com>
To: "Kumar, Rajesh3" <rajesh3.kumar@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH v3] net/iavf: support reading PHC time
Thread-Topic: [PATCH v3] net/iavf: support reading PHC time
Thread-Index: AQHdRRKMiuxGWrqBekKWxTF8I2Kz1rbPm0RA
Date: Tue, 15 Sep 2026 13:05:11 +0000
Message-ID: <AT6PR11MB044526412999225E7D0FBAB1FAE4BA2@AT6PR11MB044526.namprd11.prod.outlook.com>
References: <20260902055401.36342-1-anurag.mandal@intel.com>
 <20260915130220.1535861-1-rajesh3.kumar@intel.com>
In-Reply-To: <20260915130220.1535861-1-rajesh3.kumar@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AT6PR11MB044526:EE_|IA3PR11MB9135:EE_
x-ms-office365-filtering-correlation-id: 573d180e-0b20-4a01-3a56-08df1329f9ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|4143699003|10067099003|11063799006|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: OZHqMCPsxaKIhxZCxwbdie9hHMmBEpe961/5d0cfSDsRRjHIdFr9ml2cDg0RyzODDrErFZHfT1tDJBW9cQRKm4tUeGdr+VbYxy6r+j43JvZmtR0AJHvl2tRmDPqtvFVVcw4yZls2kW0upZWL7c5+32dduIvJ9/39uudZl0Zd9kKabClmYQUJNGhbP23JaLY4SXMbp0xF+ZalIdP4I3tih9VeRdwGnloa6B+Aen4F3Wl7Hs/ydYS0BwOnuYRBYOA5sUu+2Y6aro46tRw8T/LH7KpNt9KxYPr4dWEzCLn3Epw/aXkY94GRKqThTHllOsnSfOdMxAjD0xBSuIlLMe7cJ6nW3i5hym87Jem1ZS6v7TUDT5P0FZl6rHCsqH5sw0kKLHtsbwS/pXh/iM10nRu8zjCsoxSMIBYYJccfGsv5uEHvcHA1MDStLwp1sFW2+E2vySv0UusRCTGTgupctBDNifi6dUtBq5oL+WuzquvegYTr6JdD4F+k4fAq5hu43wHPojk6I9so63QmxzPzaIpjjt+bBBsvzRZ3T6nn5hRcXTw/CZNN/ozTVfKyZPAvZP2i7jFDnlYdpJDoiS8RRMNix8YiLIQiHpnb19NM3BpRhUfErYQqynZikRNeA/uZjGzqeje633Cm4pqlBgAMh6OfG8VD6X2sIsytMkbuS2uWiAZV4aj6dYQ8/q0vmpNjhCsM7a1jknjgfbM5i27Qa5a2yHGUc/7PwIDq+O880o/brDI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AT6PR11MB044526.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(4143699003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+UaY2Qj3yu9bSNb3UqhEivCUoFcmnEROgkCIZOyRDMYjGUQImXKgQPeCSRva?=
 =?us-ascii?Q?1Xmdk15wif0CjiclLWuvLijonpBv7PVrYj/lYM6Ialh85qZaFNSeR0OXVWf5?=
 =?us-ascii?Q?3sEyS19PV8apJUm/vjpIR8D1OHSn8UpXu/3OVIizvOiQdmhf7worcAiuKToD?=
 =?us-ascii?Q?/a2gZIU+kRwj7RHMESYkeZv3ztRX6dgMinWWPww1RCeMYm4/HwNdFf5cJshB?=
 =?us-ascii?Q?tGwCjOyouaikc5kkIhGOwQ7m4WN1xcTmRBZOArUDMXBkghV61otGR203U2OK?=
 =?us-ascii?Q?5Rn3+GKWKNJoIvJ7MQyrbfZUwlnSBNvhSg6vdb9MHm9G2VEpQICIEkFNvv3O?=
 =?us-ascii?Q?znv8JzQ85W3kQ50OV02BJn7AKbKMZ1VDB3qvU8JmVX+dcHCIemhbkm/oWtlz?=
 =?us-ascii?Q?I/IRAe83KJCTW7bvhjKjaxOlD0hCqk2v6iE3gUqsIeN/hYYoiGEQb5qYnhMz?=
 =?us-ascii?Q?3yi0yQHQadmm7Q5mgxQpZErc9IGZyCjR4SYTAAddHyFhjeHqfOukIniS+svV?=
 =?us-ascii?Q?2j2xVtPqAsSF2CV1KHKXuDRme4axGjaLusxYTfB7PCfEKnuK6nDwasG9TJq1?=
 =?us-ascii?Q?kwMgZ7GT6c5BUvkd4mmzv5lWpH1nM4cDYE3jEHF/XfTRhrLgUNO1tf9U2ER6?=
 =?us-ascii?Q?1pEmWgoPPPG4IRGJwKWRPO+c+R8uYFIFLvd9QgSX7GxFXEi3x7QQj6MlpmW+?=
 =?us-ascii?Q?EpnxnexA/uYwhbHqGnGM5OJziL9BSijkAPb+bMWNXgsPADyi6tMaF8mZO3xk?=
 =?us-ascii?Q?rQthyo4CjAePMMhMA/3wBnEeYclhVyrkhyTdvamdK/Neg8TNCbFiH7uEYyxM?=
 =?us-ascii?Q?WdLtEXHiy88jd+s5qoa1yWC87WpyRAJML8ynBo/0PccFYRYv5n4hAuMvE9sb?=
 =?us-ascii?Q?1eByVTXP5g7Rf7WWbLlbYZkFTvkvlv4A8QeRQk84ys7ZI2FmwujdP2KDl5CD?=
 =?us-ascii?Q?VGX1+pCRrao/wS/kaDjD5lN6uzyvIto7c9AuS8OWgPOHuokU3bUqHW50o4xC?=
 =?us-ascii?Q?DOOPgHtN753yFr06LSPo9H1jAwOGZoOKxkHwTmKjg1SAh/88sp9HbskiVfbP?=
 =?us-ascii?Q?ERj4ZJVaNHe7SYSg8PhVAxVp6zjzTVleEIvLjhbFrxyhaMrfReyohBSOLvAT?=
 =?us-ascii?Q?4fNth3OMBFcfewtLdfk/MDOtRlhU1HbYKRxgDwW+i02xUaIHVibxcYDZctuA?=
 =?us-ascii?Q?Ii2awsECVX21kzxO96Wm9nKFuvK9ze85z8IybfJAltV/gZSfpfzMOHeOw5wB?=
 =?us-ascii?Q?KdaVTWTy2B00KLR9vYdz78mEqYn44k88rOnTzdaJ8YdCbDfjzr8bCi900FPT?=
 =?us-ascii?Q?Kf00RqjY8SPN0EPd9VGDMmcQ0XBSX5dfUn47FG7J+lfMC5nYRZ431t/0nZvI?=
 =?us-ascii?Q?feKU8+nfCWaUuVBd2G/BtoEb5PrcfO+A8i8dSY8Jpoch3MVLt5RiFu5sZcvo?=
 =?us-ascii?Q?KDW3PujvootxInFGAzATRigCso4YWcu+tuish8isjIEciZR2ezHeqgy2wKMk?=
 =?us-ascii?Q?oESNNJ0lrBo4LZLXjgfqtQftz3Lypz9pdMIBkDToiOfx6pcCzlfNIJXcTruc?=
 =?us-ascii?Q?INpqNj1RKZ+GRibO7EBT92P1ZOFkTVXlqbE3K5Eg267rA0FqilfmBwUtWYi6?=
 =?us-ascii?Q?tG6UfOBhS8UJ8U5Yk77w4CgmsxvWpHe2uiD4F4ZRBEH58Aezwv+M+xvg3YB6?=
 =?us-ascii?Q?T7GDHFB73e5WEtcOVjPnymNcye99OF4A3OaBaHB7CodfCAUZo/hxbob+12rV?=
 =?us-ascii?Q?pdqsDcr67g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: r3xuFJuPFuz5alBfVNKKjjav5PcVqvVQYXhsYI1/EQqthb6iDvPsUHTL8tTJIwDuUwXxmRHI0pPRFgX1qvw23cAHPIpXqhbWvy1DnXAVY8h7BPcm/JFcjqCQivS4xJ21vKmDPTnhvf9y2urorjjnbdi7OPPfqYMomp+omEAgmi8d0X+OMuwLTqSGk+8JlSl0EaQSFStE3CYKxOhq55SR/Jjojzk6fn/bjEOg5vidLkpADYFa7IM1eHTVK1puPtQHX87F6R1XF1PWv2wpkJJgTh3MqgU7uC0zp6sk+qA/qRfVpphDqlb1Iz7860NubBW8zrfFGHV4/0TXOUAdUz4I9A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AT6PR11MB044526.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 573d180e-0b20-4a01-3a56-08df1329f9ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2026 13:05:11.4026 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0ee7J+hLRRBKnGwq7iGYXAes/3fQrUe/UDk7J1yFlChKiDUfg71F18Nr/75+7Kl8tTWCaZxG4o7jCzveKFXtqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9135
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

> -----Original Message-----
> From: Kumar, Rajesh3 <rajesh3.kumar@intel.com>
> Sent: 15 September 2026 18:32
> To: Mandal, Anurag <anurag.mandal@intel.com>
> Cc: dev@dpdk.org
> Subject: Re: [PATCH v3] net/iavf: support reading PHC time
>=20
> The new iavf_timesync_read_time() callback converts every error returned =
by
> iavf_phc_get_time() to -EIO. The underlying AdminQ path can return more
> specific errors, including -ENOTSUP and -EINVAL, so this prevents callers=
 from
> distinguishing an unsupported operation from an actual I/O failure.
>=20
> Could the original error be propagated instead?
>=20
>     ret =3D iavf_phc_get_time(adapter, &time);
>     if (ret !=3D 0)
>         return ret;

Sure. Let me try the same.

Thank you.

Regards,
Anurag M
