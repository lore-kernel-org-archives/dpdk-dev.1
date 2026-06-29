Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937A4C43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Jun 2026 05:59:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5F01E4021E;
	Mon, 29 Jun 2026 07:59:48 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id C2167400D7;
 Mon, 29 Jun 2026 07:59:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782712787; x=1814248787;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=dBT44PhC48+8SNb+wyUpUhkQCBaoJAr0tY2GUD5UgsY=;
 b=NJ0eo9Slt3ObycYuJ9SeAQUx2ih6RhDuE28bfUV3rKpskk5TULraL3Ef
 gSE6Za041Mj4TsPN8hb34KuUTxe6NF3IwMYPGCYtncV4abWlqZRUeCLj7
 SdnOpGT1d/YI0idvu2JKJ+adb/pJjXy/iTaR86GVOZaEKX2dsukTTJWor
 MNdV4RNSYoOH+20i5B88ac3Zgdyio7xCyZitLl6Dxsr244s5pk+Di+b0L
 sinac//NSaKoAYsMkxgVpaEmsrTbAXEx9nrH6DZI0akrM9lMzA/SAeYHh
 xdmSpOGQSYcZg/rgVE4gE/A/AztA6PJPCch5xVZkjnxVj4jr8h350Wj8/ Q==;
X-CSE-ConnectionGUID: S89lQfmSTaOxIxIEHRlXpQ==
X-CSE-MsgGUID: 9fRxSbMaTxOMEF8QmYum2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11831"; a="100934839"
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600"; d="scan'208";a="100934839"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jun 2026 22:59:45 -0700
X-CSE-ConnectionGUID: mwg921RRS1iMDYXnQGCy6w==
X-CSE-MsgGUID: GUVSsnEkS8uHuYTktlvvTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600"; d="scan'208";a="247410567"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jun 2026 22:59:40 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sun, 28 Jun 2026 22:59:39 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Sun, 28 Jun 2026 22:59:39 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.61) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 28 Jun 2026 22:59:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ksoeJu053v8kl/BPFcCo74AgEwCS305vcfQYYgpajVc3WICOtufTqOAyscgnDh+hH/zeawy00FLmFpwlCxPqlvd6EQg/sm9hdXaHlm84xTkwmyaBuz4/iDMtMT1sSgF08ZqMVFgzmZeoCpjRfY7LozaQc6F6Sq7QsqBH7qTdcBQF2sX9dyqRWrBvDO7OewSuE6CUZiNqT6N4CbXw7es1y5MKZBT7qTipWskuomM7XXlLch3j3R/i1S7ceFsN8ELtjs5bGGCnwV1hztN2nBypk4Qoo0cfYA6nzSLCae/Ru1d4Q1xymzwCN8f+vnd4alL41WAje37QxGrTQCTHImyIJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G1jDYYZxxNLAEOihf6QqCXahx5INd/Y878ffFwTuu28=;
 b=xY7JweafxT6/yP6rUtkqnKTHhPSE/IyeDPdCC+UXv/u12kA6OpW1Ts2fCvmNctjptQZvwGJVY+04udD/khj74Ow59Dzh1JjiL/ZCsq7LxlslLE1YdtPr+AeXlwJBOhQYpovHyz0nPIGcHcO+yj5pJUrIMDuAhxzvCZb5Q30m1qidCDZUORr2LJ7iXYaGVRPGFHS4pxJgWJuu7G29aiaxzcGx8ndNP3QnHP4QDl0lhMdJUi1ILgOAgV1TiOjfsHOQRgQlkGU1GEvFwSHAt/4sAIaicrkxhn7+OmNXzcBcAQ9P4L5fuUo/GBWzfzHxMFZz1TNutoiGBDu5rAJ9Br7BLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9254.namprd11.prod.outlook.com (2603:10b6:208:573::10)
 by DSVPR11MB9916.namprd11.prod.outlook.com (2603:10b6:8:45b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 05:59:37 +0000
Received: from IA3PR11MB9254.namprd11.prod.outlook.com
 ([fe80::e90:fbfd:e161:a4b5]) by IA3PR11MB9254.namprd11.prod.outlook.com
 ([fe80::e90:fbfd:e161:a4b5%3]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 05:59:37 +0000
From: "Song, Yoong Siang" <yoong.siang.song@intel.com>
To: Shuzo Ichiyoshi <deadcafe.beef@gmail.com>, "Zage, David"
 <david.zage@intel.com>, "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH 2/2] net/e1000: fix igc Tx descriptor ring wrap
Thread-Topic: [PATCH 2/2] net/e1000: fix igc Tx descriptor ring wrap
Thread-Index: AQHdB4OXE2lsJnh4W0SOrIcEMvjKJ7ZVCaVQ
Date: Mon, 29 Jun 2026 05:59:37 +0000
Message-ID: <IA3PR11MB92549B10D6A67B13D8AE092FD8E82@IA3PR11MB9254.namprd11.prod.outlook.com>
References: <20260629045511.473850-1-deadcafe.beef@gmail.com>
 <20260629045511.473850-2-deadcafe.beef@gmail.com>
In-Reply-To: <20260629045511.473850-2-deadcafe.beef@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9254:EE_|DSVPR11MB9916:EE_
x-ms-office365-filtering-correlation-id: 7edeaf72-8d7c-4866-02fe-08ded5a39a44
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|38070700021|4143699003|56012099006|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info: t2MFZ9RUAwdEBn4hzIYyU+82JXHpcNs5b6vw5BJmvl6gu1VfvWOBBUNICq8eOL5PD53JBebd0BI01GTBet5/G+lfMThVpU+uYyfNzJxx+kDOA6vpyBJvK6h7shQbOWPKEiP16Ydz+/A2ezY9QNZkcSh6WtN5wZPKY1M6n6AbrbFqVHTcX8bXMAQI18cFRbHat06jqXYvrmspU0T5cY2sHn67/SVhR905l3tIJxuYWIBS54TnIDz1rF0JMj/YBhvzOoXSxUPOrKKV6mCDFqV5e/xZe4xmGqMp+uACiuHSHDxDolQRYaQ2b+nqRbQfZBM+s/YvLeySHWmUvhbntSTuBSqA/eJKdsLimrOiuZKZZxMTre1TswAXlOEy/yohLpUHiKsRL/cqxWU73rr0mbSjz713lFmvnLz865GMrlo958JrO4lM39YCqrU1rEaGlJt7Vwbx98sVGnU/apCZhcT3gK2WylUS1V1MyAqgMW/iEa5ovx+DBKWsNRzTpBeJyDCIghdJxTFtXtlGtolnXvt2PboL08okMMd3oInpNk5lCzBQNN3LU+Kfc6CPXT6jQbmZC9C0Jvcc6fwEqsGiOfFRbYqJF8wcwsJCDppCwFak56MGaVmk0/fAbwdD8ZWi8o9uDudEXFj/gipz9BwgS7KafWpZLNe5KX0JnAL897F61yBxXTBaqP4cK7LIqmE+cyYqB2fjw2A4c5rbXlGHOs2KYukRUOgnH2jh9ope+mPEI0g=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9254.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(38070700021)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qXXa5UEuJQxmsRohpP/A74zksqN37SBHgFzo9vnAiD1uWBPLzHVn3tMHVKK0?=
 =?us-ascii?Q?95Tlh+bl97Hel2B4WZp3eJe4bt7/T2BYHTGdpKsQ3U1kxF6ZrorTWXgHJtGp?=
 =?us-ascii?Q?cfNMAVh8fNA0R4DrubMl7c8s6fvy2NBRIQkEMkjPwQXDjgvZN5C3mN+vCynp?=
 =?us-ascii?Q?80uABeI8aL0CYMUdFTg90CmEXFdDeADwnwvtfltuGfTTg4ISQMJaIbYc7uo5?=
 =?us-ascii?Q?SGTUoV8IzNP97xC6/eRBlI0Egikrl/mqalMtNA+oizthCJeR/ooh+vgMlpRl?=
 =?us-ascii?Q?nrmznBuehkWezeEIU2p8JrxDQXLbpHXfin2ojcCvrxGwtq+Dg8Fon1tHsYNS?=
 =?us-ascii?Q?OCKjUrOA/IVIQZ+ayBwLvS/lUjpM3jHwc3RiSHIv32JMj+r9KchkNlMwfZXg?=
 =?us-ascii?Q?SdsY8zs7mT429e+mdXsp2zEJJinI6JQI9dXeFsDfpCiuJwlzEpQkALB4Dog9?=
 =?us-ascii?Q?QSA8AGhLhVT74J5MTZeter+DAgrMBgZ4FdeSpWzQvsV0RK42kPG/2PgIKa5i?=
 =?us-ascii?Q?2cT0SuRA347INmtyQDN1y+E5/FrLMIoJ1iAIMWPS3GaJ8caHwF2Y1uf9P3Fp?=
 =?us-ascii?Q?Q1rE3HK15/s4OCWXOlRFr0vrkF0DPBFBwwXSXJp+jfFMZqGBwRlN17iKe1ez?=
 =?us-ascii?Q?kgS4enzwO3HvnVcT3LOuXxgKyxROQzMm6R6kXsFuwRiVVZXKpt8YThU1Rrwt?=
 =?us-ascii?Q?jksMVY6SKSFea6bm9aQ8QB4TvIxxc3yx7Z+/UtZwDpVnjtytJXsxTySwt4eN?=
 =?us-ascii?Q?5iuwlGleB562A2Sb/WhtXGhtmcMYkJrleJpiQikdf60bKWLnC+QQqiBEYGZh?=
 =?us-ascii?Q?omwORrDAOwUmaX3hroFGpsK0OaAwpMeHc60E6oxvsj5AAnn7j18rBJPhI9sl?=
 =?us-ascii?Q?duttI2kxqaHxYfGHVJHpWd9jOdGxsqJ8D9rwZpX/7gqulGvQUGpHpbGtOKL/?=
 =?us-ascii?Q?zfrwT3K38pU0aKEmVcSfn1UMOJZ50dqOTavc3J/ACL1ZQF+/Odj2O1hYmW86?=
 =?us-ascii?Q?HC62uuw2KUc8Fq0TqTO/K8CJnLP5Iun4mYFY0IsDYiGikQS2Exz22bUYErnQ?=
 =?us-ascii?Q?+Hm7ArYxToZlrSc5oD1bAcDBAsZFzHIuzfEez+E6omV2nnQ5IEoMX/G99vSo?=
 =?us-ascii?Q?5P6mCGaMg1JPJVncXJM++EGIh4JEhbHSHDISP9Pdft2U0fMBtV+P/rEXgwmb?=
 =?us-ascii?Q?D9bqGpbint+CERReCuDRuTvP6OcwqhcYW9xLDZQXDmKhaIXpM1Dij6JcaOV7?=
 =?us-ascii?Q?oIDtXvzcf2aStEW3N6BzxJhXv/xc6K7ccC2RZmkFl3zavhI9GPdm4C82tCWr?=
 =?us-ascii?Q?5OsjMT3LbAsS3qd6PugbDbapqY4iyh7ez5o3lofs90nQXw8ew5R0RTbmEVBJ?=
 =?us-ascii?Q?V6bS9AH8F2Vr2G6qkw/pax2s+VaFRYZYAPzii96Aikt3PYvUQ7T64Ky/CFqG?=
 =?us-ascii?Q?3tHLIAxsUEtU+rygW+rzaTCMeH2dQl0msHI/1EBd37lWuESHKiFVrpNwhMfx?=
 =?us-ascii?Q?boCvroFM7+Qey1/vozxYFi1dPNF+eI3ZCyYYFzkwr05Uf2CeqK2Osl30VN2s?=
 =?us-ascii?Q?Ql0/ItZ49IHhGPsurxj5MsBG7+GjsNShf9Z0gMn3Js35AQDWeSAD9WLbWWfS?=
 =?us-ascii?Q?JtADJWaD5rGHpHTIWfvOJmhhFpO4YFVmBnKnhhZ/qAyksliZB297it5X0+gR?=
 =?us-ascii?Q?RSMXhhO4nwgNH594LyE6EvS5ukGTDVDS5q30Bh+SoOZO43C6PerRhjOefkpK?=
 =?us-ascii?Q?o9nX67QoNA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: jNvF/Fb/5Ak2coV2d4lcockxZPYFTd04zgDhhYV9WxA1kERZj/AE7SI0Jadk6Zo6+2m5FQ7d0ztMZvRVD5g5nODh3NAOYDZGjF+Ytm1RAVA6Ln+LjbBIITPKZT3tIhsBzggcGJU9YXUeeXTN8Gshr4cqbFoLLXDu7no16IFl5mRzMW4is9HG8n8kNbrDhSMmTa4Pwu4Jz8gllTZjNgJCpsB0urFmUzB0WYcIyRw3j2nr7k4JXYlYPNsVLAb83UAxglmM9Ni/HWiCAMMw4ybd6UuyvBV2cE3OSfEaOP4v6zbN8SHMmwSOc64UK8Oylqrr2nevJNlfAkN8zXqGXY2VdA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9254.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7edeaf72-8d7c-4866-02fe-08ded5a39a44
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2026 05:59:37.7395 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DyEBlspeLpddk3wmpdhHaJwqNWmEZ5DjBaJnq0d8Z/zm1LYgrJfAJU2Y85mFpUo4WVaINz1eKo2AJEx0fwYw+jk6ehMmay+UYrmaupafPi8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR11MB9916
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

On Monday, June 29, 2026 12:51 PM, Shuzo Ichiyoshi <deadcafe.beef@gmail.com=
> wrote:
>igc_xmit_pkts() reserves two extra descriptors for launch time.
>It indexed sw_ring[tx_last + 2] without wrapping the descriptor
>index first.
>
>If tx_last is one of the last two descriptors in the ring, this
>reads past the software ring. Wrap the index before looking up
>last_id.
>
>Fixes: 2e79349dcd07 ("net/e1000: fix igc launch time calculation")
>Cc: stable@dpdk.org
>Signed-off-by: Shuzo Ichiyoshi <deadcafe.beef@gmail.com>

Reviewed-by: Song Yoong Siang <yoong.siang.song@intel.com>

Thanks for the fix.

>---
> drivers/net/intel/e1000/igc_txrx.c | 6 +++++-
> 1 file changed, 5 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/net/intel/e1000/igc_txrx.c
>b/drivers/net/intel/e1000/igc_txrx.c
>index 1ab8f2079d..d61fdb33a8 100644
>--- a/drivers/net/intel/e1000/igc_txrx.c
>+++ b/drivers/net/intel/e1000/igc_txrx.c
>@@ -1834,7 +1834,11 @@ igc_xmit_pkts(void *tx_queue, struct rte_mbuf
>**tx_pkts, uint16_t nb_pkts)
> 		 * The "last descriptor" of the previously sent packet, if any,
> 		 * which used the last descriptor to allocate.
> 		 */
>-		tx_end =3D sw_ring[tx_last + 2].last_id;
>+		tx_end =3D (uint16_t)(tx_last + 2);
>+		if (tx_end >=3D txq->nb_tx_desc)
>+			tx_end =3D (uint16_t)(tx_end - txq->nb_tx_desc);
>+
>+		tx_end =3D sw_ring[tx_end].last_id;
>
> 		/*
> 		 * The next descriptor following that "last descriptor" in the
>--
>2.43.0

