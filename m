Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF1BC021B8
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 11:56:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7997A40612;
	Wed, 26 Feb 2025 12:56:54 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id B680940616
 for <dev@dpdk.org>; Wed, 26 Feb 2025 12:56:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740571013; x=1772107013;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=OkY76IM5VIdGiMCj3B7d9w1KUlNDyZYO4A0GkuXzJSA=;
 b=MD69yPKENg8TVJQjq1L3AsDP6JOZYOvxEeQejnym8xYnTt6WVrHnWHyD
 JZflFaoXOwB9CPXg/Hh4WbYCWBDR2h/dqau1Z/w1QA7CHlKIOmc22h9DF
 cuEKY3RQ+RLQmcByXPxAoPLYlP/Q83rewWE0ZR+2TgeuTpnCGI/6sd6Xv
 6kjleKpjmJGtu0k5uXwopMexsmPl9mK7nCxwQRgXrhliGXIuHsCO4XpOf
 UQexPM4AMZ0TvxX3pc5CTKHHgLb6UF4ZU8bP9dEhUrT+Pwojd7L3jdNz7
 phWPzamkn7UKoKQItGNP3ic7zMKv5KNYv2Ww57zGWVh2Dr7VVQp2DBSCt A==;
X-CSE-ConnectionGUID: 8yUqi9BDT+2MGk5LLeFNyg==
X-CSE-MsgGUID: DEHdPmx6ThC1E4plveXo+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="58947049"
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; d="scan'208";a="58947049"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2025 03:56:51 -0800
X-CSE-ConnectionGUID: OvnsAHnbSAiSqNmPJT+FXg==
X-CSE-MsgGUID: MgKFvi5oS/esvcjADTZ3Tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; d="scan'208";a="116493326"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 26 Feb 2025 03:56:51 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 26 Feb 2025 03:56:50 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 26 Feb 2025 03:56:50 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Feb 2025 03:56:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cJL9osj7W7lj3RmgaLrsFsvEEJ5583IDr/ZWZqe/I9EyXefXaJatIn2qxwlBcYnQBql/vEg7MY1do3PJ5cq7sJbZz8yodGjVpW86EwExaj3CkCAZL95kJapgyvkkuGsJU8Rp3ip8Gu7ueI4YPLy0vcu5scMHsEs9+W7FdeoI5sKC9Ip4kUGSDY3+kD2U+4bl6Kiuz2Dk+N5iNMj7ZuRyiHfeu3XaCs+Sqq07bJYZ39aO8Q148kWQiQmCRlp27JE0xPrHkvLqn4bfGcSmTKhPpMKI9ErooqlExpvKBYuvf99pfO0SpQ4Gcy4Owx/JUJgpB2DLbFgL+pI+Qzgpm1GQlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OkY76IM5VIdGiMCj3B7d9w1KUlNDyZYO4A0GkuXzJSA=;
 b=ZFrGf8gL9l5/Pc1XhF5hP4tXq5hoWQKcFngrPHGBLPgbODPzSmbqvtme8xLXspVECTBjUcLBAk5Gk191Aa/FzNUwXUp30TqvioEesfIOzCriBd/mCxV7ffwcjquCMh0grf+x0TZIg4B1X62+cuMoo0bCIlUE/Dt3o8UKXmMAQkGG0kSVbWqxJzrY21m6Jaz7hRsJTcDJ3OXrNW9fnrG+hNrF20O0q1++NapOKUplF2C7KcRozUQ9DST41D60KM0OByW2O/buvMpspc/m5xGYJvjRDmT6aNtdZUfyOoCEkAnfErmZzpEth8RHpEvGcQi6btPi+FO40DHPZvoslPLuYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5591.namprd11.prod.outlook.com (2603:10b6:8:38::23) by
 SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.20; Wed, 26 Feb 2025 11:56:48 +0000
Received: from DM8PR11MB5591.namprd11.prod.outlook.com
 ([fe80::4d18:36da:367b:5e82]) by DM8PR11MB5591.namprd11.prod.outlook.com
 ([fe80::4d18:36da:367b:5e82%7]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 11:56:48 +0000
From: "De Lara Guarch, Pablo" <pablo.de.lara.guarch@intel.com>
To: "Dooley, Brian" <brian.dooley@intel.com>, "Ji, Kai" <kai.ji@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "gakhil@marvell.com" <gakhil@marvell.com>
Subject: RE: [PATCH v5 2/3] crypto/ipsec_mb: add SM4 GCM support
Thread-Topic: [PATCH v5 2/3] crypto/ipsec_mb: add SM4 GCM support
Thread-Index: AQHbht2II8sGGVZT80W8b4wXOlyN8LNZfT8Q
Date: Wed, 26 Feb 2025 11:56:48 +0000
Message-ID: <DM8PR11MB5591176A9D1A4F7A0B9AA32C84C22@DM8PR11MB5591.namprd11.prod.outlook.com>
References: <20241213125850.2714328-1-brian.dooley@intel.com>
 <20250224165939.717714-1-brian.dooley@intel.com>
 <20250224165939.717714-2-brian.dooley@intel.com>
In-Reply-To: <20250224165939.717714-2-brian.dooley@intel.com>
Accept-Language: en-US, en-IE, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5591:EE_|SJ1PR11MB6083:EE_
x-ms-office365-filtering-correlation-id: 1be89708-6617-455d-9cf8-08dd565ca63f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|10070799003|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?R6mlPaXsVGphQU0KNWcsgpmvFg3hpoBVI+wucT1AEI/21P2yihZYTWgSPyM5?=
 =?us-ascii?Q?qpoLuSziBjF4wbc7KSYiYc5okv5bozRUS8ejAbSCuZReL2E1oOAE+zFVf3U0?=
 =?us-ascii?Q?hdA32BxcoFKv52GUlA1Vaq171xBudOFnktabG2Vx7tJMnTKgVNPW0sT5n07o?=
 =?us-ascii?Q?n1rGqDeocDudJUsHwJHHKoUpR6rL8B4xB4nT0i317E/kn6gXtiXH9K9C1pu0?=
 =?us-ascii?Q?nTiYZP/rDZZtLvfylGs3AWvI2mAH4IrnIgw119yrW3HubdQ4v7Ncxki2Wav6?=
 =?us-ascii?Q?dNLpDotdm22zNUdEPpn56lICwKpE5+HvTdOxjAPTp4Xm9poGUGgiNKeATgQf?=
 =?us-ascii?Q?efhD9C3AR6Xd/f9uchLvxiyV7xmao3SpSInk62QI1ASB99lfAq1z5KFnZdL4?=
 =?us-ascii?Q?2Z29ASh9ty+BenV45yxVThvWoF93GTvox9KEvno3ht4pUoxEBTPDZSleOhR8?=
 =?us-ascii?Q?Vg5cFyjVupI0RDCFXr7GvZq6RvAOmfmmRzHAUC0w3JKKdBom96apbAWznlFK?=
 =?us-ascii?Q?DbmyawoNeGljM1ieakGi/dkLLzlVm1fe69gw63N0aLMmgXp0r32muFly7jZa?=
 =?us-ascii?Q?lBZ92BQ8vWxou/iB1Mi32fmnoM660AZXA3mc2l3Fl/uyUua/cjlLSJvkvEd8?=
 =?us-ascii?Q?RG2b68wsN771ryDY1qktzMPKNCcA5rDrnS/5HiJrEfh8bPvtI6bKcF5DWEPQ?=
 =?us-ascii?Q?xrNc3blaErnAjOHfbf/V0wPyi4hfUxRbW/HtWUJtWPfSLxkDizEfaAZoqWcC?=
 =?us-ascii?Q?IUMhtXwC7A6ajfdHudSUHt/ZkBUhKqbqPyD876SY768Osxlhy8SkYq+1JBso?=
 =?us-ascii?Q?sik/k/vrWH7Yx8GqMtC9hf5uzCr6ZGXPKXvoo+8qj5/xHcaYmzJgBnRWHQIw?=
 =?us-ascii?Q?60RBtcXvO0OEYwVEt9HujLXpw5lBwlVv6oDFcuUhabollBZ4q1z4lzPGKLQr?=
 =?us-ascii?Q?G7wKZA67rI8S0Ny5rJ37bOXPU+d9b5KBPq08E1tabcpwWozJAxoo1GaQbEMp?=
 =?us-ascii?Q?IJvP/7gPNGJ7JFHs2OFo3jKkA3ZvhASkxfjQz8x8J62vlwZE52gyT0KX1kQl?=
 =?us-ascii?Q?guU5wibTgL1u8qG4PlweGjWXJDLE2tx+GQcPI64BA+0IzuMi6PFsp9gl/8L8?=
 =?us-ascii?Q?LMER8wWXgGGh1+mCwA2gpTrfy5S58n7O/0ia4jOgU6y5IqO0u332uPyaBcC0?=
 =?us-ascii?Q?Fu7H4UtfXHhLoLVtFdngvepkYRIhspMmr4HxqFhgYpICJ7rMgY7BhxnSUqn7?=
 =?us-ascii?Q?kY06t3ZAHTa+tI6UQVN+g408lXhKIq2jRZVcPEbKc2EE8obo93TjI7Y9+zkb?=
 =?us-ascii?Q?GkEMvYFjtb+EhMFTEdgYh86fTLZ7AphrHxX1Dp71YakWUVAtNNFLsMjAEdvH?=
 =?us-ascii?Q?nfYTgGCONlGgSBVxQv6bkwiKKeBYk6FO+VMsqFNLB1tu4Sj30rHzL5dV9t1X?=
 =?us-ascii?Q?mu06VkpdLM8hmEOIJv4N5qeCiUBwqB05?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR11MB5591.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lmAbpnoGoBJHY85PJ45yzkmVARws6nrLk6W0nZtoYcngANv00Y5bNPmV8sDy?=
 =?us-ascii?Q?4X4a870pGwPWXpMFiC8hspOq5rE+w916ZPiC8bJSSNznPXAXy3SE8TpfOJLF?=
 =?us-ascii?Q?D95347XTVpBZ8FrEB228dbtsPzuBpF8Tvi1WX2/db+5Ngl365WcDjBLV8fkJ?=
 =?us-ascii?Q?graNhFSVU5hT3LOUKK/8UjabwKYa4iAJTJuWq4Yt3mpjmyJLkSqM1mQ9JLP0?=
 =?us-ascii?Q?fBGBe6tW2cED9ZzvMHxFyvA7vpEh9U6Y2FYnQO5PAFV3ki96CrnhcD1QPjC4?=
 =?us-ascii?Q?ssdqXtDDtSil/5DJxW9nUmlm8UJ3Sxo73dkk/tbcn7SaeU1abrWTWPtpB4pa?=
 =?us-ascii?Q?uj0dMGhZxPTnEZ+/iYSENvNWguWdTVvBKK7ed7E65lJA6GWiEuA3a1tjMWv9?=
 =?us-ascii?Q?9WMIUO63xcRMYTVHDbOWKkQeKUDTdkQpAjuCMbUK35EFjhEeO7fitD7QnGke?=
 =?us-ascii?Q?DD5D9JIC48x2boN5aZynTFkCQbi6q4B6VvI1WqXxCHOgaWgZBtUQeCW9Ae1S?=
 =?us-ascii?Q?7vHqwoiLajXECNuHk6zaVAV9sS7y+zyEb0W5pGjvL1bE9oi/KFhJZ3TR/FKH?=
 =?us-ascii?Q?XcXQSLAmQxyvSWk4bfQ/UkrbZkwNFUAGS8hUdGEGF8ODwx/HJokrPz9M2wVz?=
 =?us-ascii?Q?QD8f3p5aiMoG6+1FldwYLap+2xW8CjB99kQwuaZJASHO5JQpmUFlOq/R8FcK?=
 =?us-ascii?Q?nEQgoRuPLbJfCdYGDWcJ++iN2U7aw/kIijkG1GzEcwWO6tOykTC84CmKWkFd?=
 =?us-ascii?Q?m2NRzTY3R7uHblL1qyXfS27FGVWeR7f3B2i8fbi5JSbijIadQMXBTaKp9MrQ?=
 =?us-ascii?Q?qQ6onjjmrRJtKnqj9R8oO9N5yxzftMi/hNSP1Q9JJ1udVUegetuFPgd6cs/V?=
 =?us-ascii?Q?9UldY0LcANRoKxxvtemBnveIAQ8NFug7Prl+oB47boSQX/O0HtHB11Qk9gCu?=
 =?us-ascii?Q?yXJqBX+U8NLFNqD5qorRIqTXAs2Bj2uNLwfui/z/RtDRlIPlgjPtfXqr8z4l?=
 =?us-ascii?Q?Lr1ohOAPthIi8zmlfrv2EuhyggJRC8P++zptqTKYZam6QPFIGJePnLCU8aq5?=
 =?us-ascii?Q?Dq6HGcDUJdGrLjaJ/Rn8HRWhMZANt5sAXFiyBOsWBJj6KDTNiqL79qjzRdZb?=
 =?us-ascii?Q?i75uzOCRJGPY5NDfknegzuXtfhHvpxZGzIpWbAuJyz/MtctorgQfnFQYKC28?=
 =?us-ascii?Q?w50llSSiShMIuchi0iDs5tVvNLQneSyB8IIVSmyLn8buCfxdJbnEzl2qcyid?=
 =?us-ascii?Q?VJKWyH7PB3tXoULBVs+qa5GqfUW7HWlL8AWklWfFpWNJSEhzlMz3ZOzYvvmw?=
 =?us-ascii?Q?KkVfHsKlLvk5QeWE4GY/m2v1BC12oamsCHa0YEHKE4YUaC8YTTKXWAJ+Y013?=
 =?us-ascii?Q?Ho/i/C1JyjZerqqOtW6JUrhGqDSnOorU2i/D1sxk9pJJ4UpfeqgGxMVJPf0u?=
 =?us-ascii?Q?v9lcp0fNHLEukuw7d6UVVy/gNBq7jOSZ1dKPHldu0wEUV26z6g9tD3EyF2n3?=
 =?us-ascii?Q?Giz6GVGUMZ5o6rS6CK8eKYyXhk2IfeHacjKNyCXJxYjbM5abNC8DvEbmezb5?=
 =?us-ascii?Q?yZxE4RBqJzuMzkTQ0ZmnNjqazrV21vNB9J9JCVaRvBlJ+N5VE8F7XzpuDR1H?=
 =?us-ascii?Q?DKgRJcmqDxUC+cPtJuNUjt+bEGzXRUUuwxTzn9gPzNpa+vjzHmLPdArHiUIV?=
 =?us-ascii?Q?KpOM2g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5591.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1be89708-6617-455d-9cf8-08dd565ca63f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 11:56:48.2182 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ANIzdm3cc2E8g9xhVNSvk1fvpdlMPL676m1XxwikC809/4I3ThWZOQVxD+XG3kkFRX+Aam0KpHgxgofJYJRzz3adzSMBSNF+r+KYNAiPGNA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6083
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
> From: Dooley, Brian <brian.dooley@intel.com>
> Sent: Monday, February 24, 2025 6:00 PM
> To: Ji, Kai <kai.ji@intel.com>; De Lara Guarch, Pablo
> <pablo.de.lara.guarch@intel.com>
> Cc: dev@dpdk.org; gakhil@marvell.com; Dooley, Brian
> <brian.dooley@intel.com>
> Subject: [PATCH v5 2/3] crypto/ipsec_mb: add SM4 GCM support
>=20
> This patch introduces SM4 GCM algorithm support to the AESNI_MB PMD.
> SM4 GCM is available in the v2.0 release of Intel IPsec MB.
>=20
> Signed-off-by: Brian Dooley <brian.dooley@intel.com>

Acked-by: Pablo de Lara <pablo.de.lara.guarch@intel.com>
