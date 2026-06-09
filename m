Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBE4CD6E79
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 10:02:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B5AFA402BE;
	Tue,  9 Jun 2026 12:02:38 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 456DD4025E;
 Tue,  9 Jun 2026 12:02:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780999357; x=1812535357;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=nyYjCudmwgIPjRZDYFC056XqlwXn2mPkGKw7LVn9p3k=;
 b=aRwbAsn9a/DXOdxUKvGIqFVYfBrrTBBurZirob2WJKce4OwMI60c/L0b
 l8Kh+2FAXmovLqnI1NKwH1QhoDgp2AKLlXA1Xni9CN5Y9Te/wRnXNAasn
 4Yagqj9ZMY1nmQDqsY0bIFH4NDfDgmT6yyJuhRGRueiKXsgkb2HTPYTYv
 X27gqrx5prRohv3xNedyhPX/BL7dYZ0gQk2ZO4w+etJCDL5zcJdv2EYtk
 Xev9qoH4ZK9oqp0uzYr6VeTry4MzuR7xyyVvKtnpCp1lJFzGm7N/sOiNZ
 8kozaKyipUK0bODcNA6iSyZ3tkb9gkjfWKkO3nFH5mRyzhty5mNWDxG3X A==;
X-CSE-ConnectionGUID: mzsffYXRRbmpaEepoU9Ptw==
X-CSE-MsgGUID: WA8tAEWtQcON81hvzV/w1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="81866714"
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; d="scan'208";a="81866714"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 03:02:36 -0700
X-CSE-ConnectionGUID: VjeqKLdVRF+B/dnD8jj/oQ==
X-CSE-MsgGUID: JD3Su5pwQoSitmkDmU2ZnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; d="scan'208";a="241655248"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 03:02:35 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 03:02:34 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 9 Jun 2026 03:02:34 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.47)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 03:02:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S4xsGiYB+yF2Y3tTw3imKfOAOiViTmD/snU1YcFKyDiZHNX63O/25oSwmZEYEDV3tCdwadpXssXjVbLl48IU1OROosQajm9D9ZPdGkWpBzpl5z60aV83bm/MsEwiqQEwC/ki5W8JEdaPjfoOcqlvsTFK1e58r+nBF6aqiXF/VeIPOzpoKCrVokW1/DNW0kVRtt/z8jZVaVU55Tm6C9+H//QhpDM3m+hFn3X6Lb8VS2a/Z6P0wAyBli1RlLCBIiEnQwehZW/l7HicdQOhaX8vx45w0XRGxiH5RIHNe/QFtH7d3NrHenRJiCaTTf/fq1nD8oyYFGdcZBL/Y2vX//sT/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Co8K2geqMFcVaBUR9/U3EptBG6qHDf0iyfpdYfpSP4=;
 b=GGeI9Z0FPde9qQWtQ4lsQ79rykUNAa3Yw5B0WMCgsUikDlILnmbgl2Tvfiky6uzxNSso0EQLqvjilZ3Ee3XBHd09K8eNU8fYZinpuiYwik8BgLFAZIDsANxm42G11CN120jGHAUtANB23pqK0pPGK1GWsH3KwGqSWGdDqwAn16RqyS3yz1YcGBc8zgiBe/lWNjwmJ7o6epVLyNMx5MrFFGzPtjK/IDnFxWWTpEXBlSKd3jHPBMUbEy3ip2JLIX/vyZ+I00/XK6Mf+MDE9G4WdVqfpqLzupzVZ7Qgp0V9rHqRRT9whfQoW2LSqVVzm8I6t+/nA4BzSPgZ8AZiM7p4FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA4PR11MB9278.namprd11.prod.outlook.com (2603:10b6:208:563::12)
 by CY5PR11MB6318.namprd11.prod.outlook.com (2603:10b6:930:3e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 10:02:21 +0000
Received: from IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057]) by IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057%6]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 10:02:21 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Mandal, Anurag" <anurag.mandal@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH] net/iavf: fix to consolidate link change event handling
Thread-Topic: [PATCH] net/iavf: fix to consolidate link change event handling
Thread-Index: AQHc96RYzj3KWfIz+ECl4LnXNbzu77Y1/G9w
Date: Tue, 9 Jun 2026 10:02:20 +0000
Message-ID: <IA4PR11MB92782B6A7F4F58953DE954DE8E1D2@IA4PR11MB9278.namprd11.prod.outlook.com>
References: <20260609001022.357509-1-anurag.mandal@intel.com>
In-Reply-To: <20260609001022.357509-1-anurag.mandal@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9278:EE_|CY5PR11MB6318:EE_
x-ms-office365-filtering-correlation-id: fd59fc11-dedf-43da-0f02-08dec60e3260
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|6133799003|56012099006|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: LwgQsGpMj2pJMa5+VAHVkqduq/+EwqOwGVq6QsFWjCbawaDpjdTr8NXdQ6iNnLdpp9IOeT8r1lzaMzNwKVST4rrRnupAWpuKczMo8alyMY26qb08/MyPT4LngGWwcQ5mnlc7VRYAmUgpy1rXsJZfB1LlECa4vmU0Ss7M5D4TS4ngW5hRRo61pv0Mz3KeVTk3H/DOb/5ZlD/JFYk89N7MRHyLHcvNaO9KbHh6X7ZfjGVuRtNQHcWhBNm4ipPygW+NA3aF+7XJZvdSfHO58cu1CjZQAZKT0phl+yJP78YhsS54/tIDKIcLzdxmMZC8W5DRBv/amUhiumlFwmhm/0Wxq3N1XcfXKemuE8C+prrQLkMZbZx7yYNGjV0JY3UGOzX/FxWygpZRAQbwOgypH6fSyRtntFinHqvpcE47t3/z60O5q8PAzD+D/Uk0ZUkZA+EuDSP3MK0CpT7JxOgtJtjN+/15l2GD2PPt7C0TBOYRF6MnFNDAhRK/v3u3W8TayCLgSM5lFO5pPIqy3s9jpInORVzpQxDlVcg7630IO4GJzVcQ2trvbSAM4WTHv1m7p6IEKBiGpGKXoci+hhCenluo+ajt/QJPdwUR1MWDXAgeJqIzLVVpwpc339GYhUGcuq9vdalrdAoxDu86NCkURtVCxCCUCy/siXmQzKQOBhmsyZdc4c4Fztxdc/RWv8ZpGTa2W5y5u8QZeAtyLw57CwItfH4kDccKPFpxv0HQToYsq8Ry8MJKBcmL/76nJkYL0N0O
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9278.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(6133799003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JxyC6M0HgwKSDHoIfYkSaV+4NZT7QyOnMsqRdbJ8ZAG6+bOp6yWaK8motxkG?=
 =?us-ascii?Q?ZMRWJFcEllosiRc8KXXPzJK/5MlHIncM88ixXRVpuv/s8NRMGzxPoZ9C4JBg?=
 =?us-ascii?Q?m/Ge8v7r5ATQ8JfhnaAELkRxuBf3oe9g4wglpqHAEM2bUvL/EtJ1uSgprqZ2?=
 =?us-ascii?Q?osLgtUtwu3aZUsGkPnsL+UZmpHheoRu/xs79oMBlWgHPohNGfPb7StcDdXFD?=
 =?us-ascii?Q?D/SC+cWEAtVqST+Kxr4tCwn2Ze8uQ/vILmytJ6nSVpfQ9j7i6zFgmPbN2imo?=
 =?us-ascii?Q?WDAriJJgSko3E9sgdZ1WeiFjK7DAkVn4dIdWZweGi+MSJSQCKGbjtgiSHLSW?=
 =?us-ascii?Q?lvrR5XjuKCVM0zptwbi9AQ8f1RtC7Ozd5tjpotpg40By96iayUDv9rMVnOQN?=
 =?us-ascii?Q?Li3vcPe/5oPCmJp5wzhuZA+dC0WSdEGTDzrGCPvPFLEdN7WGuCB3TqWE0EyB?=
 =?us-ascii?Q?/e0sOjPYULHTZedtwBhkuADzV2TYpMBkP6RN9PNnWaFJUOe+Yf1WecgJ5Eu+?=
 =?us-ascii?Q?uVUrFcme5fyZaGq8cS01pcXJyNyFhQzaxAuaB25Hc0T7H7f+cZWoU7/EAkFa?=
 =?us-ascii?Q?YuL5WqzDr4byfcBmBY71IEEeFRHHDO7s81y6Gx0SlptXyHWe11IdUPgSEjRu?=
 =?us-ascii?Q?RR+v1WoaQkDnxwzeJtkPu/G/YsL9kz2LdbGaK9d0cKgQ6MM1Ln2P43vpNkGF?=
 =?us-ascii?Q?6a6ow365OTBWGikEbRO/T/YWvAntSB6tr8M6MIgW39v2XA+uI9abR6zVRN78?=
 =?us-ascii?Q?X9NvM5YTsziKoQk4m8l+nsN0X4qwdE9DE3RLjr+uXZLQXtEXIS7CMez1Q5yC?=
 =?us-ascii?Q?xPQ+EoqHTqxEo1PN3jQnrUWu3QzTCHTJiHAW9HaswYPQvmMA0YQ9NsxuwfIl?=
 =?us-ascii?Q?MSPaMNl4T9IG6hlzI/zujMoaA9Yyatr4BCLZ1/PAE+HVhWYP3b1az7ylQxgu?=
 =?us-ascii?Q?+K1h/CLKhnqOdl0731imXdlt8K7iFUbX8Gnab50Io71702Ww30o0y0khoNmG?=
 =?us-ascii?Q?ek49ZDmTuXSZL9ATs68NiLCwZwjr2aJvFHT0DO0buaAnuWhf3kfsL30rGiKt?=
 =?us-ascii?Q?k3TIvgKzjqM1GjYFgyF4PK0nBcC3ituHnA/7aG8ECmvE7f5dII/Lz6rUm8kN?=
 =?us-ascii?Q?rrI2XNZxJW7tNY2G6H1lwJBOfxHYt5eIrJxBcMXtdgM2MN0ZlX3LlLGcjRXg?=
 =?us-ascii?Q?C8/afayR1C9rEGU40WMq+gKz3AFvo9r2gdqH3JjXht1xDSOpbWGZMoXtjlqA?=
 =?us-ascii?Q?OUhpU+OqgERBXRVekz0yL7TrTKdi76O3Ow3dmI6r3Rv5vBrDpQbWQ+qzyvpN?=
 =?us-ascii?Q?zxbh3zG3TizWDUOcjN5PWhCT7aq5xCXsHcVyXVKmUe9xilz9gOIJItHNDABV?=
 =?us-ascii?Q?EVJEpGJY6wkD5FKGr45odwne6jGi80gPYLanF7jrz7h0gXI/YpPFuC2j5+Cl?=
 =?us-ascii?Q?sDng0s2qJb3QDG/aQNOdSYRv5Z7CvJ8pM1WYyuOAUks8iyW65+z50qMgopJ0?=
 =?us-ascii?Q?/BTBQglc9nsP5NNDRjr1GOPe2RUnhrvLgvFWUn09U5IXJ7QXqeU3ef2/CKNd?=
 =?us-ascii?Q?KX/fm2mHS0X098wDU0pU8PW2TrPLX63x0vongycqzXhgd/y8xh17z8wOLR1r?=
 =?us-ascii?Q?H12hBw3Wcab1y95nGyB9VqVDAs8B7QS2j+IDpSAwhDKeHSzebNPOwyG2ENQr?=
 =?us-ascii?Q?hDpAi2qQ9Ax2Hmp9l771cZ5rAXLtTeUSkf96BGaYJmr9DoWp+oSWq/y2tEFP?=
 =?us-ascii?Q?5QxBK0HJQg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: D8bMXlG4A7FSoRHpmK4TIwWTMRO//kv4fCkS+siywSWLzzkbRqS31KIZA8NTZphX4EcfauP/PqaH+8aiATTH5B8S1KyJlN0ou87uuQllZ4V520gvvu+9M8/jhd1LdmU+PSV1oKi1y8hYPSzyMSK9I8eqDuC7F5HtfVGuwB1bLSKRw1JpwUQs6SC9g2mnIEDfiq8yLUBqNNotKqiQnvmKujttm3Pe7NGsWO0ZfGUAd9aKtNLA6CXiF7xrtUH9XmTcNbWGmRlpiVl1MIzeNRIvLd3FGr3ZTljM22bpoP/Q9Ed1gmyhRBueN1zuXh/aIXGTgwl6g55FFFGUa1fn2dR5Mw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd59fc11-dedf-43da-0f02-08dec60e3260
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2026 10:02:20.9855 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FbkbTiS97T3icMGy7h35dQpiLTYUwLRw1blHGbfETMC6vdQEjBwxf7IZ2cyuuCrQidl/lSUA5awm7UsNsEf7Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6318
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

> Subject: [PATCH] net/iavf: fix to consolidate link change event handling
>=20
> Handled link-change events through a common static function that
> reads the correct advanced & legacy link fields properly and
> updates no-poll/watchdog/LSC state consistently.
>=20
> Fixes: 5e03e316c753 ("net/iavf: handle virtchnl event message without
> interrupt")
> Fixes: 48de41ca11f0 ("net/avf: enable link status update")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> ---
>  drivers/net/intel/iavf/iavf_vchnl.c | 133 +++++++++++++++++-----------
>  1 file changed, 81 insertions(+), 52 deletions(-)
>=20
> diff --git a/drivers/net/intel/iavf/iavf_vchnl.c
> b/drivers/net/intel/iavf/iavf_vchnl.c
> index 94ccfb5d6e..6454632541 100644
> --- a/drivers/net/intel/iavf/iavf_vchnl.c
> +++ b/drivers/net/intel/iavf/iavf_vchnl.c
> @@ -216,6 +216,75 @@ iavf_convert_link_speed(enum virtchnl_link_speed
> virt_link_speed)
>  	return speed;
>  }
>=20
> +/*
> + * iavf_handle_link_change_event: common handler for VIRTCHNL link
> change events
> + *
> + * @dev: pointer to rte_eth_dev for this VF
> + * @vpe: pointer to the virtchnl_pf_event payload received from the PF
> + *
> + * Handle PF link-change event: decode adv/legacy link info, update VF
> + * link state, sync no-poll/watchdog behavior & notify app via LSC event=
.
> + */
> +static void
> +iavf_handle_link_change_event(struct rte_eth_dev *dev,
> +			      struct virtchnl_pf_event *vpe)
> +{
> +	struct iavf_adapter *adapter;
> +	struct iavf_info *vf;
> +	bool adv_link_speed;
> +
> +	if (dev =3D=3D NULL || dev->data =3D=3D NULL ||
> +	    dev->data->dev_private =3D=3D NULL || vpe =3D=3D NULL) {
> +		PMD_DRV_LOG(ERR, "Invalid device pointer in link change
> handler");
> +		return;
> +	}

Thanks for splitting this out into a standalone patch.
I'm not sure if all of the above NULL checking is necessary. Especially
vpe =3D=3D NULL considering you've checked that for NULL in both
iavf_read_msg_from_pf and iavf_handle_pf_event_msg before entering this
function. It's recommended to avoid overly defensive checks that can
never trigger so I suggest taking a look at this again. Other than that
the changes looks good to me.

> +
> +	adapter =3D IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data-
> >dev_private);
> +	vf =3D &adapter->vf;
> +
> +	adv_link_speed =3D (vf->vf_res !=3D NULL) &&
> +		((vf->vf_res->vf_cap_flags &
> VIRTCHNL_VF_CAP_ADV_LINK_SPEED) !=3D 0);
> +

