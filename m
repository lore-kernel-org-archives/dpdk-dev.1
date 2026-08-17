Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361BBC5DF66
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Aug 2026 09:34:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C57C40275;
	Mon, 17 Aug 2026 11:34:03 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 36E934021F
 for <dev@dpdk.org>; Mon, 17 Aug 2026 11:34:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786959243; x=1818495243;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=mlgC70HuItgkQGfNfA8HBgnRQzv93rmRpB16XXMqT8E=;
 b=B3qNRJ7pBq58sigyv1NM29VgRc2IXtiQ8mYN7r8RoIPIG3e4sSv1hosW
 zoGVitH5NEdKbIXq/ZOKVPdojL+uSzreuTOinzxb1aQX61jm5rjbI/MX5
 6gNbtNeWbd4mkV5u13IkijhakSaxebUGxc3DCHDBmghhKoqxZjbGeYK3V
 07q7GaOX66qhxKm+OKC9lq46l/c9wsr4qALH9/hBXn2GcAeQD9dq+JIvA
 X8giHQx0S6e76uC+PaEvN0hJLecqkVNFjsenqsixYZH6mgaFG8Zy2nf2p
 6GAQt3Nwm50cQXvWq3X+PqaB/SQNzRVcVgi+Vk9tcLDHuogGeC9FyTtdE Q==;
X-CSE-ConnectionGUID: FdVYEhORTRGEeomhLjMWRw==
X-CSE-MsgGUID: XzG+sSztSEiiZAnkeD2yug==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="98947443"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; d="scan'208";a="98947443"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2026 02:34:00 -0700
X-CSE-ConnectionGUID: +ECz3n4kRXucClumjA0QhA==
X-CSE-MsgGUID: ZKeWHk2uQIOAwPJEbpS2tA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; d="scan'208";a="270065277"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2026 02:34:00 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 17 Aug 2026 02:33:59 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 17 Aug 2026 02:33:59 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.37) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 17 Aug 2026 02:33:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NC1GoHL4RvnsYjpv2qEs394VBAkM+Q+bv867sVK+yP0dncwi+YthfdWUXEEqHHfdlxtG6KfmVy+TDQ/F5Vqe3+sO6mcOZlMOlu+TxiXkjE+YGlWleHrn5LfiS4sI7glGD1J3G2qBVDPmfVt64ZXzZISnhj5F6UClm/RvuBp3mm25Uy36b3OKPeDbUo9o9WICLUelvUdTnn1Gjrd6QV7n/8y7wLAJ5a1/Yu7dnnwhQHZKz5z4j7hHP2MyZmliovl02PuDTyRjuUIZb/pRhisoR9HvGrdbXJgQAapDuHkgmOLa6XvXugbA2CwQ1xTFGj7JktKMaxpDYS0ZgTq74jJ4nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t4Bi7DI9QUCrQVYdQBHlc7fbHWqj82flQGPfjiUsAdk=;
 b=MstKSvUGDt6lYS+7uBdvw3BJmB6egAMjXdhzeeSz9jskEDhFLeFJ8MN55vgji/CYQyJiPJZd6fQJQWHpeqCt8fRUjDKxdQ4DenpRzZUMx89c20aga6m4aDiExEgSSL6H6ms7h0+JXrSvPnG5B55bdd34oxsjnuGv/75rgtB5A360l6Qh2DvvuftejR3IG9iiS+tfYGkOs60MNmaM7+9/XVqAcFQKqnRfURv59zcUD5hxti3uZqyvM3zIYlxYeKgIRbcoX0UoFrJ/abA9jDUXkM1N+NnUsmg0mcDCcyELTaV9eCRGEYYe9yjrbZAURVpx4OfxxhhkKBrLfw/JYgNjRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA4PR11MB9278.namprd11.prod.outlook.com (2603:10b6:208:563::12)
 by LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 09:33:57 +0000
Received: from IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057]) by IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057%6]) with mapi id 15.21.0315.014; Mon, 17 Aug 2026
 09:33:57 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Mandal, Anurag" <anurag.mandal@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>
Subject: RE: [PATCH v3 2/7] net/iavf: defer device start when PF VSI not ready
Thread-Topic: [PATCH v3 2/7] net/iavf: defer device start when PF VSI not ready
Thread-Index: AQHdLhSfF1L8Zb79b0G3LKhYb/8i/Lah+oOw
Date: Mon, 17 Aug 2026 09:33:57 +0000
Message-ID: <IA4PR11MB9278B6A992F4069DAD8D4EA88EA72@IA4PR11MB9278.namprd11.prod.outlook.com>
References: <cover.1786948817.git.anurag.mandal@intel.com>
 <ce23295863326e2e77edfb71cfcb7e48b1b496c8.1786948817.git.anurag.mandal@intel.com>
In-Reply-To: <ce23295863326e2e77edfb71cfcb7e48b1b496c8.1786948817.git.anurag.mandal@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9278:EE_|LV3PR11MB8603:EE_
x-ms-office365-filtering-correlation-id: 968f9250-febf-4c3d-8c98-08defc42a957
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|38070700021|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: ai0BTAIxJjCfy44MFereV4XB+SWM1wGqnPqt7Ye2xADT/YSbW58o6Lw63fOS8VvXn8hE42AiFRdE6pDlLsWnTccE93eig2VFZ4YBaWwfPzUGbZpMm+aXCKmBVFvRM5r5OTWmQE+SZEK3ejlg3MFRtGCR4iccdeXW64WqY71EQbeeQLxQaYebCOBHCntulAcQy4J/Xho1fHltnF6CX/AF+Wv+eKB/SO9Ck/9colDaLE2SDFzYOgKsFf3dFYEwJ/aLYTdI7zshXg1pje5sbFWEEl/w4CUvjoMNxgADlpMd7q32gxEgj1nrh1nE4yGP5bnyzAL4bPaJ2C4+1dwrbtLZYDYuJOzsTY4dTXEHCzmhJC4ZyQJ8e+evs3hw5x7B5fzzPaFCb1WDI253nMBmERJl36bcxUu950NCBy6Czo62elVlo/dnLdP/ctcAXVxpkVlGMciBiv55nKthpdGFn5to9PKxjvimqB/I3KahGuouhnVTV7oFLvsYeTowagJx4o8ROUZDlqM7EKCeOlP4IQgnPpdfcLGN5ScF6iuTUZP9vU8SFMQMyGmqj2t80/knDSOLI1bVUf8IaJ0N5PWHRpeOoDdSQU1bEhwXIfzMYgatYAr/T3L6TkmwPuFyRa88+sNL8YNUPeE/kUiwwnBeIjkZxFLeD2+tC17hlGIl/cvh0m0XAH8UPWs3UnjOfl+ayMpe3lWw9oSSbpLW3IvHxja4ST6PoQOHe7pNgp/NuxkfggU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9278.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1gBry4/dd2khkdLcCmyWjt+D4b4kg+gem/H/xTDIBpp0gxXhhuJ8jYmRcS9y?=
 =?us-ascii?Q?afds3225qyNfbaQkG8UqD+DdwoK0vu5yh6R6XPRV2zX2sZMKcV/3Of5lojfT?=
 =?us-ascii?Q?jIWA2NQc0bADuxMU0SIlt4D1o3Pg/My55KQk2/1aDwmMdVN6YODhVBoXQcmG?=
 =?us-ascii?Q?UqH5uEPCIZoOtROCLWmkC4N+WuGRc+OEtfvzVsWXr2S7oyaErUYyqkvrEYKK?=
 =?us-ascii?Q?EAA+E9D5w10uCB7lzDDd3j86viC+MydOgoJMn8DQUviGGs2aVPIXuloOueeR?=
 =?us-ascii?Q?da2ftz2leZBHMMeMK14Y4CxQ+j+VtEtTZiUvu5a1bjGKiZfkx6UgQHepWJWo?=
 =?us-ascii?Q?VpLIicbSfwIEoacl2axw9Dft/lTUTKpbsWKHfW0xg2W0kPgA5SkidJRa6f26?=
 =?us-ascii?Q?fzNlGmza6/yqwwv+5AR7n5ku6GxK33Ql6bH4a8DhPbb5QRsviifIcRE9jaFx?=
 =?us-ascii?Q?qn/TrNYTsV/jTJtoDWRg9eJfGcbuwYU8PnlOHizlMfQ4Yz1wo3j+t4lPtIyb?=
 =?us-ascii?Q?NFXR34XKovicAtSeBP7/H9aBN47lbTIMR77AlCiV2OOXmZUEuRAq/KD2/TWm?=
 =?us-ascii?Q?69dwnQRZYeNJRW3iVlOFeO6MA1NY4jgEcIdG/Pp28tHYugwT6GNLiKp5eAde?=
 =?us-ascii?Q?5QFuCsPDagrIACyhmhEA74Yzhr/bOzkldfsCBCytK6Flah1SX6LmDztFuZHG?=
 =?us-ascii?Q?qyHc0kisv2HyxP6Dfotxno7xiBMQrgUTJ9mBCjsjcopTcM3Va4GU070MricA?=
 =?us-ascii?Q?G+y4xTXMZnbw7Gbn8U/yqYcMhiHjySSMKznMYTNOvgqohbHuJKADI1vATYSu?=
 =?us-ascii?Q?LEoEtHJprA0aG7YsTQrGGuCZv1nbtfbXvndykBBmSP8ZaSX5kOZoZv5/08Mc?=
 =?us-ascii?Q?+UMRGVYAiqb8xM/F4cd2VpCohLqfu9hCmJ8tzycdnGxsjfkzm8+6f97N6Z78?=
 =?us-ascii?Q?OwuSSiT33RkCt00igPfGYJcRrOW5jxyAI/JQ3LYe1ZDkZ43ifnmIuFvCMonX?=
 =?us-ascii?Q?UtSYgODUh8ZeBV1gbDqQoQtXAPARzsXH2ENZumagBQxci38puludXaW0H2+k?=
 =?us-ascii?Q?/q1k1aMV+u1qqWJUApSNyzHswjvBQUYkUIaBJN/V/rM25IvwP/c1l/f6Df4V?=
 =?us-ascii?Q?pC1pCOHUhUVJVwsInR3SY7waS2CnpBtwh8xnWlTRXR/6Q2lImBN0whQAl7u+?=
 =?us-ascii?Q?XvtW3XtwTMTXSRRehTRV+2kDHmRQdv0WEhCAng0E0Azj1zZ/+W5NunEze34+?=
 =?us-ascii?Q?22GxX0OEbVbyV8qCRAJOQs3hIxi6qg2px6wT+4udWMr83rsz8CMpPn/mJl0P?=
 =?us-ascii?Q?+/fUtpSbOklnRbP0C+ItBiawN9Ig+m5XOJOouWFYAqUybs6DKiXutrJgBsXD?=
 =?us-ascii?Q?56FgimcXMgqIVIszCK7swIG0tc1/XkmfSetzMzj29bFYUBVTaLtidud8Yzoh?=
 =?us-ascii?Q?4OkINSPlHVdkIm8Aoz5DQcwuDyMJpjUg/hLM4PUVdSMykbuWjz+LeYr3uRMh?=
 =?us-ascii?Q?D/xjDLj/f1XhRiPxjFUDHZZGbwXp1RDR52wZZjdsKZq9DF9s3nl6dSKykdcX?=
 =?us-ascii?Q?+NRZSsw4KoTsDWhsP/u481cErz0Z4Dug+0CzoNQG77VHaL2sdZ62m3dEVcId?=
 =?us-ascii?Q?QZH5iUK3iNH/IIEytB18WhFWjHh/ExWpSGMD72aAEh3tmyE96oqjziuKcI26?=
 =?us-ascii?Q?2tzCNOLebtVXFVpgQaVGq+T9VDHDa3lUAeFKpIHwtMtUi4ylvP9mjRK08hA2?=
 =?us-ascii?Q?koxc9lhQkg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: pmiq1FE1iyIdawr0wz5jnH+cuGV0QrMgM0JrSyFzClyVOqFrn7r2zbnH5d2zVLev1hm/gcaU4bmn6hRGxxewNSmtnXhImnvvhiN6bYhYb/GnnSRyC1BR+4f0ZVKK/ntxUAV2XV5cfh8GoaE1iEDRrIqcte/AhFR8qOD2g7346U2Uhxz/PZovB0qt8HwSxumJjB6pQrDPYDAUGt7gXnW8cn+zF00oKbAK6IKKTN+pA7OM4mFIHuRcODQ0eIz53cqecWIOGDv1VrHJyonSjLwOJE08X9073gbFnETzYHl37vUjHtD9UgpvmcxBzj4mFm3pvNQyi7w+5XMNbzpzk0+t1w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 968f9250-febf-4c3d-8c98-08defc42a957
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2026 09:33:57.1818 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jXFWMRbDE2kdtmODtrt9o+O34XohcB5WkXyT19BpDj94jRs9+Dd7ytaI/QqZZ69eQcO+/F5V7lomdWLp+MEYpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8603
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
> From: Mandal, Anurag <anurag.mandal@intel.com>
> Sent: 17 August 2026 07:49
> To: dev@dpdk.org
> Cc: Richardson, Bruce <bruce.richardson@intel.com>; Medvedkin, Vladimir
> <vladimir.medvedkin@intel.com>; Loftus, Ciara <ciara.loftus@intel.com>;
> Mandal, Anurag <anurag.mandal@intel.com>
> Subject: [PATCH v3 2/7] net/iavf: defer device start when PF VSI not read=
y
>=20
> During reset recovery iavf_dev_start() might fail (typically -EIO
> from VIRTCHNL_OP_CONFIG_VSI_QUEUES) because the PF VSI is not yet
> active, leaving the VF down and requiring manual intervention
> to recover.
>=20
> Added a start_pending flag: when device start fails during recovery,
> defer it instead of erroring out and resume it from newly added
> iavf_resume_pending_start() on the next link-up event, so the
> VF comes back automatically.
>=20
> Fixes: 3e6a5d2d310a ("net/iavf: add devargs to enable VF auto-reset")
>=20
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>

Acked-by: Ciara Loftus <ciara.loftus@intel.com>

> ---
>  drivers/net/intel/iavf/iavf.h        |  2 +
>  drivers/net/intel/iavf/iavf_ethdev.c | 61 ++++++++++++++++++++++++++--
>  drivers/net/intel/iavf/iavf_vchnl.c  |  3 ++
>  3 files changed, 62 insertions(+), 4 deletions(-)
>=20

