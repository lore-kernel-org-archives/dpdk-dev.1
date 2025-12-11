Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6729D41D65
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Dec 2025 15:58:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1D67A406FF;
	Thu, 11 Dec 2025 16:58:22 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 18B5A40151;
 Thu, 11 Dec 2025 16:58:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765468701; x=1797004701;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=lnQ/ibzkhk09PtRUA7GKawEK4Fg0oWiVxq2hRFDvspk=;
 b=LOfHjOH57HRebZc76UYWG1Wieyn1gG6E4akQY7kwJ08mTlhB8XwaGMCe
 taXlvtFTF8LngLI8yavc7qF3vZYl9ofgjF6GgLOz8kiHvzkhh5HPsyAZH
 A73OmCGdDENELW/vM3iP60py53hujItWwbPdoaR4lE+Y5VtSjVuEnWsAd
 ype9kdKcXIzPmup3KNh/2FTjrTtbXppphuaoFyjhxBZoyJpz/ksBRmxUG
 GK0vm53f3G8V3Eu9rngnF0RfFjNKj+pgA2vi00Jv9MnDnNncUHanKdVCa
 5QjeYrwVBsBqPZ+IAPk/EhJ23RB6RrfVf4LUN9jJc5j9jsrd3KgmxyBTU w==;
X-CSE-ConnectionGUID: b0Yq2Bi+QkSkEtV/1fQaOA==
X-CSE-MsgGUID: CLAWrm/NQrumFcJb2032VQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11639"; a="67338643"
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; d="scan'208,217";a="67338643"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2025 07:58:19 -0800
X-CSE-ConnectionGUID: 06+Dhg/qTyKkIRwGMFHiEQ==
X-CSE-MsgGUID: hqG3EW/CTQahjEWxVggGKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; 
 d="scan'208,217";a="196733422"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2025 07:58:18 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 07:58:18 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 11 Dec 2025 07:58:18 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.34) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 07:58:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=De6RvOkv+Qu3leeVRueBRJ1J8xqjOxLIRUNXk2PU4eHqBRpMbzu+7aBvPrWi04iWu09uss1GZwsfkt2Kj4KBM1LI0FEwY73OGtXZwCPrel7JgfRUToD470Cbm7+I7UXP2LAjJ4HJEtH3fpvvLmkcNhVYc/SYq9RXHTsLbfOWsffBRx81YYXg7yYTTPFsxwI4ebhUpaGjVBqXDQ/3kPTs9zIcqv8QDYhUANqnp0oIHk/T17LZxO8ZgkN22sQUsZIf48hnGaRHLYAXmjvQVLAckIQse2UB3Nm6QrA803RejDBHNw7Ge15EEDSuapOx+hNwpbcnYr5VUFTG8OJLYdGMyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=psC/b7kvorcEJKozvdQwLSKUajDNZs2UJ8nkI2I+grs=;
 b=w880//0CxbZhNIsImwiDs3k1AoEXgpxYytRvgM9l1vNpx0tagowmLb29BLi+5YBQudKOu5VhR7FtjGaJRmdqU8XSPBBSoCx/3Rbd/d0EstNsWu5HY0QxTmV4x//QO6PyggZyZtCXEcNMCLsQz9DItYL9DjqKJuNhPkbH4kywvZg/9Q7Zy/HSLpNcnUuoUj6aD5OqNry6P0ZxRaFD47XAG5//JC0Ee/H1Znlvs4X3w9izOlsbKbC3Zq28+4LbGh/edr/5t/O66HREZxJwakjFjdjj9GRZOncO0FJ0aGPnN0wkpc7yXYnxG/xf1mfDNdZ7+xRXqdKio5GIJse8E5C15g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6116.namprd11.prod.outlook.com (2603:10b6:930:2b::14)
 by DS4PPF2B323C540.namprd11.prod.outlook.com (2603:10b6:f:fc02::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Thu, 11 Dec
 2025 15:58:15 +0000
Received: from CY5PR11MB6116.namprd11.prod.outlook.com
 ([fe80::2b59:d9a6:8854:e9b9]) by CY5PR11MB6116.namprd11.prod.outlook.com
 ([fe80::2b59:d9a6:8854:e9b9%4]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 15:58:15 +0000
From: "Mandal, Anurag" <anurag.mandal@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH] net/i40e: fix QinQ stripping
Thread-Topic: [PATCH] net/i40e: fix QinQ stripping
Thread-Index: AQHcZubJ7aQzsnjHQ0+HycBlgorqgLUciqWAgAAPgiA=
Date: Thu, 11 Dec 2025 15:58:15 +0000
Message-ID: <CY5PR11MB6116996E086E2822124322AEE4A1A@CY5PR11MB6116.namprd11.prod.outlook.com>
References: <20251206184312.69020-1-anurag.mandal@intel.com>
 <aTrYFe7rmsCyUfFp@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aTrYFe7rmsCyUfFp@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6116:EE_|DS4PPF2B323C540:EE_
x-ms-office365-filtering-correlation-id: 97c6c7a0-1b6b-4617-768c-08de38ce1875
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|7053199007|8096899003; 
x-microsoft-antispam-message-info: =?us-ascii?Q?YCBK7zonzJRuKnW3hwgEv4bhRotkWSN1/bE67cFfa5k5YxjuwlZM2hpQwMXS?=
 =?us-ascii?Q?5+w22liQrB1XjLgBHf51+5Tg5+4M+KqThKItXkKqjoLjt7B00gXtbQ9nodom?=
 =?us-ascii?Q?O/EgHNicudH1e7XW2tHEqcgrMXMFWG4MG/AAEq+U6J4WaLtQPGSlQLC1mpSp?=
 =?us-ascii?Q?q5WK0tlbizfqBx2JpGJqvdRu/DnkNfpWZgWOvhiTtu9Kt7WEFV1fghLATzWX?=
 =?us-ascii?Q?pQaeh/7kMzxOdNPZGXnkY+/xW0V9ZV6j9xQK0N2wT4NMWoqwXuxqJeozK0FU?=
 =?us-ascii?Q?4wscF1BGWfPgj2QgxasrbT5E/EZm4Hsft7PdFoazgsoYr1QZ3G9pUS0phvPj?=
 =?us-ascii?Q?sg+OzwYyt3bg12SqQ+y/F0AdEgyjF+QIo3DIFDRzcU/ezgqHKgCnzkf01CJW?=
 =?us-ascii?Q?dpkBrsUu+ZUTG7Mxcw4D63UpXXOnzUlE+vl/lBWXLhfi1ahLx9FUG8j+Mcd5?=
 =?us-ascii?Q?7V9FHZfg9IVk+BN/KxFgWsb9AJ3b/HrMCObybEW0hHMpTupmHuqgbF/N0bm+?=
 =?us-ascii?Q?AGB88YmnEdAt0J5O0NGJ7n7q3SjjWHLjQdE1qmePN7D+1TjSmnhOEK22GL2F?=
 =?us-ascii?Q?jA6S890tXQb7b5kBguAhS9hEuzSYdb27Yq9l9IqhZPY84lVXjaNIj4AiJ93+?=
 =?us-ascii?Q?3wy720IrZMGdf32o+Nvb55qrK4OUMZjwH5GWYwqW8INR7CLlz0/TDQjSO1x1?=
 =?us-ascii?Q?6EO9j64lPgeK1boailSIBmRssw4zNkyasrHb4ljjsPzo8JWPyA4Fme5SSDmE?=
 =?us-ascii?Q?hT7pAuwnLySiGGWcwmkPiflNv2weMTbIVf7HUNs+Hw5KdrNLUNkG0Yfi4KVg?=
 =?us-ascii?Q?NMKQLPA3HvUmq7wzGpf+dTVarVhvCRixn0+moxd2CtCk8UTZ+JdgKDsI4ZzY?=
 =?us-ascii?Q?SAr82evy+2EpHJrB3nz/wXNKuZMNX7BArO0DB1Utk1YqqsPN2NTufGl4gn3J?=
 =?us-ascii?Q?Ge7BczMSoG4xgbSHVMP8CyRvH+krX7u67mQZJ+BpzvPuloFawSGBg9WYVLbZ?=
 =?us-ascii?Q?CdcUDRo6GawSzQRJULN1rAyTLpjqmiari2eO9sXK4JWh4Vx6bvg60Z6Rh2bX?=
 =?us-ascii?Q?oI5QOJ/GEFdCVmcJuRv7UlIyEWzfoPoPouopHgamM1ZBJrqza91GcyH861k7?=
 =?us-ascii?Q?1Sr54oLmiMApWK1oDQQZxbbeO9bsxiafsctaFGR1JUP4BN1li0nR+puBs2fC?=
 =?us-ascii?Q?bYUQK70Eoo1sVn5FWOitHBcAmSU+SADqAilXVSPCbhH7a23Cc3sQyTVLctjh?=
 =?us-ascii?Q?+9bzIBVtydr8RM12q+IwPPfMOh+UVXAT/jm9Sb4AkOx0DquCmduVbfO3I/2E?=
 =?us-ascii?Q?SDggATGoAYPWsTTHehT0QCJEbZ1y2ty8wNRx5JhkVXEMyTwhItoW9K1uwf4A?=
 =?us-ascii?Q?+sFb8kzxee17sM67CU13swoCLQ3R/6O7UGK4xROmrRj5Z3tmiXo9Y05w6gUk?=
 =?us-ascii?Q?J3kJNLCbFnaF4HYr8KPVQghc9Cm8mmghCuqd2RXK9VETx28pDlJJYOcRC46v?=
 =?us-ascii?Q?JcZSFJCtxNTo78kRkxkRko3AdiTqocxznar0?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR11MB6116.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(7053199007)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tjXmQm6q2z/NefUFLUdiOq70HsxradvuR7Trz6lD1GMvgobYxJR8B8+qu6Ou?=
 =?us-ascii?Q?FrXjd5Eb+IrwlHfek2Rz2YePHrKAXRLlqSTWjpHkqxNGksswolJdXAv01dlF?=
 =?us-ascii?Q?aCzad5EuDTsUj17vXKsSp4pSyfTyky8faksQwl9Pfo/J3Qw4GOXEU2vb34ec?=
 =?us-ascii?Q?s9X7Qm3HWcURg+8gnXy9bOEe86U7QO5G8sbQXbK4wW9nVVycZ5Ns9X6eYwMr?=
 =?us-ascii?Q?Xp3JQwHsgQMhQWHTSjQ5Un/lglvZSEcfzxx5CoP245to63N7Q0UbKye19IaA?=
 =?us-ascii?Q?o2iJnwC54X2Xok+kw4Fjt+9Oq8n4BjTrOGFeZHeRZ/XnOaAdkevxdn6cLDQ8?=
 =?us-ascii?Q?GyGhmIjo3TfPNewpHg989XnH2GNI4sZ2u+Cnn+KnF7iTRSzxZbli4evV/8Kc?=
 =?us-ascii?Q?Z3WcB9Sv3L9wtW5f2IQuKxHgk1YUec8w1zPFOZT8p+24SRu5fyYns2801dio?=
 =?us-ascii?Q?awfXzcf+XVykohCttPxOU1fC9ceqWWbJhMNABE/fHzpT3p81++RPrsqqvTSw?=
 =?us-ascii?Q?Ws7PLrpdAX9+mnAjzQUs2zzAiAMH6NLJlLaJaLmD4kInkLIWpzmZgygPPtaN?=
 =?us-ascii?Q?JMb/R52FU4RA+8QbzVrkaMRvPWeiDvjcJ2jW0Fm4kXT8RX87D6OI7PVSIcFf?=
 =?us-ascii?Q?8bjAAZQ4RMtn1zXF9SN/jR+Kf/8mIiY+pM7TpMd/ygXTg/IkOzIY5rCGH9Kj?=
 =?us-ascii?Q?imnfxCYOAMVZkT7l4JTxgoHPNNkuFBw/LFJ8Cc8mbyRKaJQaY76KowjKH4VY?=
 =?us-ascii?Q?+8W+od73iiBRe8ouhdtrnDquyEzkLLvbE+k5ZgBZSrE/tMjZFIG7urxHEf5D?=
 =?us-ascii?Q?k7x6TuX4llnemodepcO1n0GS7TV9e+bGV/LW1y+DFthjbMket7NWRZRaKpmd?=
 =?us-ascii?Q?Wl3vfRlMQaR1EENlKpPfOZKGsnbymexowpQrmA7T84yF9T+pI10g3Wjkajsx?=
 =?us-ascii?Q?7GK6qHOQgO0IxbVXtA83QZbN35rH6lGPULrCito+hAP+It5Yz7EigjwZ4wkZ?=
 =?us-ascii?Q?S8gmzgWTr/FWeucX2WA7smi/A4C3ec0B2gou8E8ArwhOTM0jxjCJCtt6SDlK?=
 =?us-ascii?Q?Bk3mVMS0zckb81NcSx+IM9CgpJoBpHP/OqdFIlu2BTBYLUaj3Mi0bn9INntQ?=
 =?us-ascii?Q?KlcMKOAbCgxGQZYS3iZJsk4qI4eIfwDSz+ZGsJT+mtg09T4nprKt0sNK6vFv?=
 =?us-ascii?Q?HcYSOrQ3cBJByp7M8rzoh02qMnwk6vofHaybYf7z5JSkJVt+MSFuTZ5hh/xN?=
 =?us-ascii?Q?ZWZNeJqPSPuSm32fpnT9fqe9TQRLI639kNRTyDHVBRz3kc4ByGpd8sMS5VcA?=
 =?us-ascii?Q?3X+mDU6XoFKBSWMffEd+49/08/q0OGgopSswX6zfDzO1eEjt6ht5hhdiA8or?=
 =?us-ascii?Q?baQ/hHJrwWsZ9RD46NvCuM56L7MTqUYg7lV/mWL2IIL/oUF7vMK2W/K9t/k0?=
 =?us-ascii?Q?b1XHD7YHt6GH7uuksjyVp3goEuyHP8k6+EEMxdO2lLgkpJuCC8GlfQoxsRGy?=
 =?us-ascii?Q?xOt2B2T11AYnx6bXno8EQPsgyZpnvcIQDiuo1goexbZV6NwOappzZc0893kO?=
 =?us-ascii?Q?sLZ7eCmdhh0W7Us5hDgH7vbswS3R4ESdaWFLX2TG?=
Content-Type: multipart/alternative;
 boundary="_000_CY5PR11MB6116996E086E2822124322AEE4A1ACY5PR11MB6116namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6116.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97c6c7a0-1b6b-4617-768c-08de38ce1875
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2025 15:58:15.7690 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5OxpyJrq3o7KB8JvfQrmFDEgbzUiBI3MLQNg52gaG0Y6Euw9MfUId8Bmre2OTXhzLfGQ1zy9Ice0GqN7+Gc1Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF2B323C540
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

--_000_CY5PR11MB6116996E086E2822124322AEE4A1ACY5PR11MB6116namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

-----Original Message-----

From: Richardson, Bruce <bruce.richardson@intel.com<mailto:bruce.richardson=
@intel.com>>

Sent: 11 December 2025 20:11

To: Mandal, Anurag <anurag.mandal@intel.com<mailto:anurag.mandal@intel.com>=
>

Cc: dev@dpdk.org<mailto:dev@dpdk.org>; stable@dpdk.org<mailto:stable@dpdk.o=
rg>

Subject: Re: [PATCH] net/i40e: fix QinQ stripping



On Sat, Dec 06, 2025 at 06:43:11PM +0000, Anurag Mandal wrote:

> Outer VLAN strip gets disabled when inner VLAN stripping is

> enabled/disabled after enabling outer VLAN stripping.

> This happens because the respective register is overridden by the vsi

> params update of inner VLAN stripping.

>

> This patch fixes the issue by re-enabling outer VLAN stripping after

> modification of inner VLAN stripping.

>

> Fixes: c52ff36686a4 ("net/i40e: enable QinQ stripping")

> Cc: stable@dpdk.org<mailto:stable@dpdk.org>

>

> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com<mailto:anurag.manda=
l@intel.com>>

> ---

>  drivers/net/intel/i40e/i40e_ethdev.c | 10 ++++++++++

>  1 file changed, 10 insertions(+)

>

> diff --git a/drivers/net/intel/i40e/i40e_ethdev.c

> b/drivers/net/intel/i40e/i40e_ethdev.c

> index b8ce79061b..c8153f3351 100644

> --- a/drivers/net/intel/i40e/i40e_ethdev.c

> +++ b/drivers/net/intel/i40e/i40e_ethdev.c

> @@ -4150,6 +4150,16 @@ i40e_vlan_offload_set(struct rte_eth_dev *dev, int=
 mask)

>                                         i40e_vsi_config_vlan_stripping(vs=
i, TRUE);

>                           else

>                                         i40e_vsi_config_vlan_stripping(vs=
i, FALSE);

> +

> +                       /* When VLAN strip is enabled/disabled

> +                       * after enabling outer VLAN stripping,

> +                       * outer VLAN stripping gets disabled

> +                       * as the register gets overridden by

> +                       * VLAN's strip vsi param update.

> +                       * Hence, re-enable outer VLAN stripping.

> +                       */

> +                       if (rxmode->offloads & RTE_ETH_RX_OFFLOAD_QINQ_ST=
RIP)

> +                                      i40e_vsi_config_outer_vlan_strippi=
ng(vsi, TRUE);

>            }

>

>Hi,



>to help me test this patch, can you provide a set of instructions as to ho=
w to demonstrate the issue with

>i40e and how to verify the fix?

Hi Bruce,



Thank you for your queries. PFB my response.

Traffic: To observe the issue, one needs QinQ traffic with outer VLAN 802.1=
ad (0x88A8)/802.1Q(0x8100) and inner VLAN 802.1Q(0x8100).



Instructions :Assuming outer VLAN id as 201, inner vlan can be any other.
a. set promisc 0 off

b. vlan set extend on 0

c. vlan set filter on 0

d. vlan set outer tpid 0x88a8 0

e. vlan set inner tpid 0x8100 0

f.  vlan set qinq_strip on 0
g. vlan set strip on 0

h.rx_vlan add 201 0

i. set fwd macswap

j. set verbose 8

k. start



Objective: To get both outer and inner VLANs stripped from the incoming dou=
ble tagged traffic.


Issue:

When outer VLAN strip (qinq_strip) is enabled first[point f) and afterwards=
, inner vlan strip is enabled[point g], QinQ stripping fails.
In verbose o/p we can see incoming packets will still have either type=3D0x=
88a8 or 0x8100 VLAN tag present which is the outer VLAN tag.



Verifying Fix:
No change in instruction order. Verbose o/p will show type=3D0x0800 in inco=
ming order indicating both VLAN tags are removed.

P.S: If traffic type is 0x8100+0x8100, then points d and e are Not needed a=
s when we set VLAN extend, both outer & inner VLAN TPIDs are set to 802.1Q(=
0x8100) by default.

Also, if inner VLAN strip is enabled first and then outer VLAN strip is set=
, QinQ stripping happens smoothly and incoming traffic shows type=3D0x0800.



Thank you.



Regards,

Anurag M



-----Original Message-----

From: Richardson, Bruce <bruce.richardson@intel.com<mailto:bruce.richardson=
@intel.com>>

Sent: 11 December 2025 20:11

To: Mandal, Anurag <anurag.mandal@intel.com<mailto:anurag.mandal@intel.com>=
>

Cc: dev@dpdk.org<mailto:dev@dpdk.org>; stable@dpdk.org<mailto:stable@dpdk.o=
rg>

Subject: Re: [PATCH] net/i40e: fix QinQ stripping



On Sat, Dec 06, 2025 at 06:43:11PM +0000, Anurag Mandal wrote:

> Outer VLAN strip gets disabled when inner VLAN stripping is

> enabled/disabled after enabling outer VLAN stripping.

> This happens because the respective register is overridden by the vsi

> params update of inner VLAN stripping.

>

> This patch fixes the issue by re-enabling outer VLAN stripping after

> modification of inner VLAN stripping.

>

> Fixes: c52ff36686a4 ("net/i40e: enable QinQ stripping")

> Cc: stable@dpdk.org<mailto:stable@dpdk.org>

>

> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com<mailto:anurag.manda=
l@intel.com>>

> ---

>  drivers/net/intel/i40e/i40e_ethdev.c | 10 ++++++++++

>  1 file changed, 10 insertions(+)

>

> diff --git a/drivers/net/intel/i40e/i40e_ethdev.c

> b/drivers/net/intel/i40e/i40e_ethdev.c

> index b8ce79061b..c8153f3351 100644

> --- a/drivers/net/intel/i40e/i40e_ethdev.c

> +++ b/drivers/net/intel/i40e/i40e_ethdev.c

> @@ -4150,6 +4150,16 @@ i40e_vlan_offload_set(struct rte_eth_dev *dev, int=
 mask)

>                                         i40e_vsi_config_vlan_stripping(vs=
i, TRUE);

>                           else

>                                         i40e_vsi_config_vlan_stripping(vs=
i, FALSE);

> +

> +                       /* When VLAN strip is enabled/disabled

> +                       * after enabling outer VLAN stripping,

> +                       * outer VLAN stripping gets disabled

> +                       * as the register gets overridden by

> +                       * VLAN's strip vsi param update.

> +                       * Hence, re-enable outer VLAN stripping.

> +                       */

> +                       if (rxmode->offloads & RTE_ETH_RX_OFFLOAD_QINQ_ST=
RIP)

> +                                      i40e_vsi_config_outer_vlan_strippi=
ng(vsi, TRUE);

>            }

>

Hi,



to help me test this patch, can you provide a set of instructions as to how=
 to demonstrate the issue with i40e and how to verify the fix?



Thanks,

/Bruce

--_000_CY5PR11MB6116996E086E2822124322AEE4A1ACY5PR11MB6116namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Plain Text Char";
	margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:EN-US;}
span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"EN-IN" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoPlainText">-----Original Message-----<o:p></o:p></p>
<p class=3D"MsoPlainText">From: Richardson, Bruce &lt;<a href=3D"mailto:bru=
ce.richardson@intel.com">bruce.richardson@intel.com</a>&gt;
<o:p></o:p></p>
<p class=3D"MsoPlainText">Sent: 11 December 2025 20:11<o:p></o:p></p>
<p class=3D"MsoPlainText">To: Mandal, Anurag &lt;<a href=3D"mailto:anurag.m=
andal@intel.com">anurag.mandal@intel.com</a>&gt;<o:p></o:p></p>
<p class=3D"MsoPlainText">Cc: <a href=3D"mailto:dev@dpdk.org">dev@dpdk.org<=
/a>; <a href=3D"mailto:stable@dpdk.org">
stable@dpdk.org</a><o:p></o:p></p>
<p class=3D"MsoPlainText">Subject: Re: [PATCH] net/i40e: fix QinQ stripping=
<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">On Sat, Dec 06, 2025 at 06:43:11PM +0000, Anurag =
Mandal wrote:<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; Outer VLAN strip gets disabled when inner VL=
AN stripping is
<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; enabled/disabled after enabling outer VLAN s=
tripping.<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; This happens because the respective register=
 is overridden by the vsi
<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; params update of inner VLAN stripping.<o:p><=
/o:p></p>
<p class=3D"MsoPlainText">&gt; <o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; This patch fixes the issue by re-enabling ou=
ter VLAN stripping after
<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; modification of inner VLAN stripping.<o:p></=
o:p></p>
<p class=3D"MsoPlainText">&gt; <o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; Fixes: c52ff36686a4 (&quot;net/i40e: enable =
QinQ stripping&quot;)<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; Cc: <a href=3D"mailto:stable@dpdk.org">stabl=
e@dpdk.org</a><o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; <o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; Signed-off-by: Anurag Mandal &lt;<a href=3D"=
mailto:anurag.mandal@intel.com">anurag.mandal@intel.com</a>&gt;<o:p></o:p><=
/p>
<p class=3D"MsoPlainText">&gt; ---<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp; drivers/net/intel/i40e/i40e_ethdev.c |=
 10 ++++++++++<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp; 1 file changed, 10 insertions(+)<o:p><=
/o:p></p>
<p class=3D"MsoPlainText">&gt; <o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; diff --git a/drivers/net/intel/i40e/i40e_eth=
dev.c <o:p>
</o:p></p>
<p class=3D"MsoPlainText">&gt; b/drivers/net/intel/i40e/i40e_ethdev.c<o:p><=
/o:p></p>
<p class=3D"MsoPlainText">&gt; index b8ce79061b..c8153f3351 100644<o:p></o:=
p></p>
<p class=3D"MsoPlainText">&gt; --- a/drivers/net/intel/i40e/i40e_ethdev.c<o=
:p></o:p></p>
<p class=3D"MsoPlainText">&gt; +++ b/drivers/net/intel/i40e/i40e_ethdev.c<o=
:p></o:p></p>
<p class=3D"MsoPlainText">&gt; @@ -4150,6 +4150,16 @@ i40e_vlan_offload_set=
(struct rte_eth_dev *dev, int mask)<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i40e_vsi_config_vlan_stripping(vsi=
, TRUE);<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i40e_vsi_config_vlan_stripping(vsi=
, FALSE);<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; +<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; /* When VLAN strip is enabled/disabled<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; * after enabling outer VLAN stripping,<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; * outer VLAN stripping gets disabled<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; * as the register gets overridden by<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; * VLAN's strip vsi param update.<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; * Hence, re-enable outer VLAN stripping.<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; */<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (rxmode-&gt;offloads &amp; RTE_ETH_RX_OFFLOAD_QINQ_STRIP)=
<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i40e_vsi_config_outer_vlan_stripping(vsi, TRU=
E);<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp; <o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;Hi,<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">&gt;to help me test this patch, can you provide a=
 set of instructions as to how to demonstrate the issue with
<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;i40e and how to verify the fix?<o:p></o:p></p=
>
<p class=3D"MsoPlainText"><br>
Hi Bruce,<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Thank you for your queries. PFB my response.<br>
<br>
<b>Traffic:</b> To observe the issue, one needs QinQ traffic with outer VLA=
N 802.1ad (0x88A8)/802.1Q(0x8100) and inner VLAN 802.1Q(0x8100).<o:p></o:p>=
</p>
<p class=3D"MsoPlainText"><b><o:p>&nbsp;</o:p></b></p>
<p class=3D"MsoPlainText"><b>Instructions</b> :Assuming outer VLAN id as 20=
1, inner vlan can be any other.<br>
a. set promisc 0 off<o:p></o:p></p>
<p class=3D"MsoPlainText">b. vlan set extend on 0<o:p></o:p></p>
<p class=3D"MsoPlainText">c. vlan set filter on 0<o:p></o:p></p>
<p class=3D"MsoPlainText"><i>d. vlan set outer tpid 0x88a8 0<o:p></o:p></i>=
</p>
<p class=3D"MsoPlainText"><i>e. vlan set inner tpid 0x8100 0<o:p></o:p></i>=
</p>
<p class=3D"MsoPlainText"><b>f. &nbsp;vlan set qinq_strip on 0<br>
g. vlan set strip on 0<o:p></o:p></b></p>
<p class=3D"MsoPlainText">h.rx_vlan add 201 0<o:p></o:p></p>
<p class=3D"MsoPlainText">i. set fwd macswap<o:p></o:p></p>
<p class=3D"MsoPlainText">j. set verbose 8<o:p></o:p></p>
<p class=3D"MsoPlainText">k. start<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText"><b>Objective:</b> To get both outer and inner VLA=
Ns stripped from the incoming double tagged traffic.<br>
<br>
<o:p></o:p></p>
<p class=3D"MsoPlainText"><b>Issue: <o:p></o:p></b></p>
<p class=3D"MsoPlainText">When outer VLAN strip (qinq_strip) is enabled fir=
st[<b>point f</b>) and afterwards, inner vlan strip is enabled[point g], Qi=
nQ stripping fails.
<br>
In verbose o/p we can see incoming packets will still have either <b>type=
=3D0x88a8 or 0x8100</b> VLAN tag present which is the outer VLAN tag.<o:p><=
/o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText"><b>Verifying Fix:<br>
</b>No change in instruction order. Verbose o/p will show <b>type=3D0x0800<=
/b> in incoming order indicating both VLAN tags are removed.<br>
<br>
<b>P.S:</b> If traffic type is 0x8100+0x8100, then <b>points d and e</b> ar=
e Not needed as when we set VLAN extend, both outer &amp; inner VLAN TPIDs =
are set to 802.1Q(0x8100) by default.<b><o:p></o:p></b></p>
<p class=3D"MsoPlainText">Also, if inner VLAN strip is enabled first and th=
en outer VLAN strip is set, QinQ stripping happens smoothly and incoming tr=
affic shows type=3D0x0800.<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Thank you.<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Regards,<o:p></o:p></p>
<p class=3D"MsoPlainText">Anurag M<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">-----Original Message-----<o:p></o:p></p>
<p class=3D"MsoPlainText">From: Richardson, Bruce &lt;<a href=3D"mailto:bru=
ce.richardson@intel.com">bruce.richardson@intel.com</a>&gt;
<o:p></o:p></p>
<p class=3D"MsoPlainText">Sent: 11 December 2025 20:11<o:p></o:p></p>
<p class=3D"MsoPlainText">To: Mandal, Anurag &lt;<a href=3D"mailto:anurag.m=
andal@intel.com">anurag.mandal@intel.com</a>&gt;<o:p></o:p></p>
<p class=3D"MsoPlainText">Cc: <a href=3D"mailto:dev@dpdk.org">dev@dpdk.org<=
/a>; <a href=3D"mailto:stable@dpdk.org">
stable@dpdk.org</a><o:p></o:p></p>
<p class=3D"MsoPlainText">Subject: Re: [PATCH] net/i40e: fix QinQ stripping=
<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">On Sat, Dec 06, 2025 at 06:43:11PM +0000, Anurag =
Mandal wrote:<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; Outer VLAN strip gets disabled when inner VL=
AN stripping is
<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; enabled/disabled after enabling outer VLAN s=
tripping.<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; This happens because the respective register=
 is overridden by the vsi
<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; params update of inner VLAN stripping.<o:p><=
/o:p></p>
<p class=3D"MsoPlainText">&gt; <o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; This patch fixes the issue by re-enabling ou=
ter VLAN stripping after
<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; modification of inner VLAN stripping.<o:p></=
o:p></p>
<p class=3D"MsoPlainText">&gt; <o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; Fixes: c52ff36686a4 (&quot;net/i40e: enable =
QinQ stripping&quot;)<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; Cc: <a href=3D"mailto:stable@dpdk.org">stabl=
e@dpdk.org</a><o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; <o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; Signed-off-by: Anurag Mandal &lt;<a href=3D"=
mailto:anurag.mandal@intel.com">anurag.mandal@intel.com</a>&gt;<o:p></o:p><=
/p>
<p class=3D"MsoPlainText">&gt; ---<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp; drivers/net/intel/i40e/i40e_ethdev.c |=
 10 ++++++++++<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp; 1 file changed, 10 insertions(+)<o:p><=
/o:p></p>
<p class=3D"MsoPlainText">&gt; <o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; diff --git a/drivers/net/intel/i40e/i40e_eth=
dev.c <o:p>
</o:p></p>
<p class=3D"MsoPlainText">&gt; b/drivers/net/intel/i40e/i40e_ethdev.c<o:p><=
/o:p></p>
<p class=3D"MsoPlainText">&gt; index b8ce79061b..c8153f3351 100644<o:p></o:=
p></p>
<p class=3D"MsoPlainText">&gt; --- a/drivers/net/intel/i40e/i40e_ethdev.c<o=
:p></o:p></p>
<p class=3D"MsoPlainText">&gt; +++ b/drivers/net/intel/i40e/i40e_ethdev.c<o=
:p></o:p></p>
<p class=3D"MsoPlainText">&gt; @@ -4150,6 +4150,16 @@ i40e_vlan_offload_set=
(struct rte_eth_dev *dev, int mask)<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i40e_vsi_config_vlan_stripping(vsi=
, TRUE);<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i40e_vsi_config_vlan_stripping(vsi=
, FALSE);<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; +<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; /* When VLAN strip is enabled/disabled<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; * after enabling outer VLAN stripping,<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; * outer VLAN stripping gets disabled<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; * as the register gets overridden by<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; * VLAN's strip vsi param update.<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; * Hence, re-enable outer VLAN stripping.<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; */<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (rxmode-&gt;offloads &amp; RTE_ETH_RX_OFFLOAD_QINQ_STRIP)=
<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i40e_vsi_config_outer_vlan_stripping(vsi, TRU=
E);<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp; <o:p></o:p></p>
<p class=3D"MsoPlainText">Hi,<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">to help me test this patch, can you provide a set=
 of instructions as to how to demonstrate the issue with i40e and how to ve=
rify the fix?<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Thanks,<o:p></o:p></p>
<p class=3D"MsoPlainText">/Bruce<o:p></o:p></p>
</div>
</body>
</html>

--_000_CY5PR11MB6116996E086E2822124322AEE4A1ACY5PR11MB6116namp_--
