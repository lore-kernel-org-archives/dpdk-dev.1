Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F85BCD98CC
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 12:00:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5505E43250;
	Thu, 11 Jun 2026 14:00:07 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id AC8B040041;
 Thu, 11 Jun 2026 14:00:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781179207; x=1812715207;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Opq26a+5bOYVNEsckUoB2AreUxTJxy0mbNyKHJ4YgVc=;
 b=IW3D0QUfbjcq4z+08z3/l031ZS/0hrVWDP0ElDjSXCunzbuaWIGLbU5T
 I6f0RlOBeES05unYuBTgOogjB1gIHCvV9BfUnfe3ZB40PmlXi0d3dG0O2
 JwmXip2eRH+AJSehBLzVPxSCwe1RchmvtczRCCG+xBXVT5L89LV38PzKE
 CPjL5L+FLgfhcKYr7EAjaOTNCRX+Kph0SRGsQ1n2JCnPwZ38mEuRl4jTK
 6+adQIJ87r2ISXETy48bL3aj/GQAze/5vvMI29SqTwJDx5B46AeHsv6M9
 C6wvCW2hnWDheHpgI9oLNzVBlpX1l8QjKcRvbjK3qhKpJVEm5HzgJRjTw w==;
X-CSE-ConnectionGUID: /diKfOQFTp+IUGows53RUA==
X-CSE-MsgGUID: egt0/rbKRxyinYZvdJTGGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="85827538"
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; d="scan'208";a="85827538"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2026 05:00:06 -0700
X-CSE-ConnectionGUID: lDIgpt/WQWKme+HHptk0gg==
X-CSE-MsgGUID: ilijKPB8Q0ifPQKE2rEQYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; d="scan'208";a="245342710"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2026 05:00:05 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 05:00:03 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 11 Jun 2026 05:00:03 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.28) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 05:00:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U2Ya+BiVIrK3Evhtz4ftcE2NkYBnbHM8TRTLKQfLBKhwo004mLVdZUJv39rbm2CfeKqv9JTOyR2Tluf4WoC/rwzJsAbYiloTyd99sMiYpXIpkZjlBfswJzxpggQ0HLrb3DWj53e1PuV3gATObD8WUusT9tgYeWGeQIXf5l6z/+PDv3S560JNjaN1qq2SMyxMoJ0tii+KsJ6BF9efYpH2JiP1FeInwucencgSiozCm2pwuQS4nCqQ3DjDn4B6cntfy5yq/qtgG8r7Ai+4QjElkcAihrhFHp5DIrT3HSVG3IcnFjLw9h8IENts5ansphGHqpl58PXraGqm3ZpZxRrCwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Opq26a+5bOYVNEsckUoB2AreUxTJxy0mbNyKHJ4YgVc=;
 b=vYaMss6EfepSsmxlSxvdj57aA5XCQDXGWmnWtbavTDXk0YQJlE6YZ8M1klCaMrDVgxthosFp5bppsmHGdUE1SA71pf3gkXGCoWG70N+a00xGfO1Ve3Qc2ImoeEx7yWXS7Y4AMxzuF2aML2+eAVv1bqKI7aVnoleSW6+m898bVUt6KzgZzcOo+3Ina3GjD7G8lV8WaZmtspIZXUAqGXpVZJpPeZbaivBC8OYKzGhBsTWSQ9yyLk1ia78EYUEz9MlcHBXMloh8mbflBWA4O461JEfZcr/gzg0rSkXBBWWo9yJBRGOmey0UsSK8WGN89FKuoBEAu91OnBlms9yNvM8r+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF6915D992B.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::29) by BL1PR11MB5285.namprd11.prod.outlook.com
 (2603:10b6:208:309::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 11:59:56 +0000
Received: from DS4PPF6915D992B.namprd11.prod.outlook.com
 ([fe80::2ef7:faa5:9104:f49c]) by DS4PPF6915D992B.namprd11.prod.outlook.com
 ([fe80::2ef7:faa5:9104:f49c%8]) with mapi id 15.21.0113.013; Thu, 11 Jun 2026
 11:59:55 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "Mandal, Anurag" <anurag.mandal@intel.com>, "dev@dpdk.org" <dev@dpdk.org>, 
 "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>, "stable@dpdk.org"
 <stable@dpdk.org>
Subject: RE: [PATCH v3] net/iavf: fix to consolidate link change event handling
Thread-Topic: [PATCH v3] net/iavf: fix to consolidate link change event
 handling
Thread-Index: AQHc+OMovL/9+858oEap82xC9/0lLbY32oqAgAFH7YCAAB6zkA==
Date: Thu, 11 Jun 2026 11:59:55 +0000
Message-ID: <DS4PPF6915D992B77353318BC850C46DA5C8E1B2@DS4PPF6915D992B.namprd11.prod.outlook.com>
References: <20260609001022.357509-1-anurag.mandal@intel.com>
 <20260610141230.369232-1-anurag.mandal@intel.com>
 <IA4PR11MB927893A5541358313C538CA28E1A2@IA4PR11MB9278.namprd11.prod.outlook.com>
 <aiqI5XxPOvu1m0Bj@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aiqI5XxPOvu1m0Bj@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF6915D992B:EE_|BL1PR11MB5285:EE_
x-ms-office365-filtering-correlation-id: 4d48a2e8-7543-4b3a-bb1b-08dec7b0f43c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|4143699003|11063799006|56012099006|38070700021|22082099003|18002099003;
x-microsoft-antispam-message-info: HV5sKNTVpR4xIFJhIFhSPTxKZwfjGfy6x/O+5udg5oNgAjnLeZJkG/YRwzLnaHDA+hJZof8TxLNzMQxPx+oAhb7waF4ue94xD2ECqwhBFQ+oVCzLNF3GLRzeVXdTOYM6tFa54/1n1jkO8c3kjEhvojBTJPwQ0yGQE7qKCGyJOW+Anwt5fERufKrhVrfyfxyKQlrRaMc4p8jvZMv4AArvi6YbfsgFKW0jpWvkaGCQl8+XKu3oZgqUPyasGhgDinCb3Ej5kEMkFv0a+ZM8uXO44AWcixz/zhR38DtU0MyQqt7nlZp+xDaYnJ5i8xY7+HkzvH+8VGf4v6GMvoDcviof/LU3B+n7RAEB56jedR18BqOiA0qHh3BB9uoCLEQj7TJ99IHPfTYilIb/JkebCZpEVY+1cOiGEWOWu9OliB1DkbaAbwzrZVUwHK2sFJgF+fpb+RDhpCh91T4C5LzhBZCmtJMXG90nSUUBUVpigrWEcXD//pWkUOy6Ws6KgOTfsj3GNofujcCslGWrUxiBcWjSbvVY5V2F2dt9+jubDzaxKY3jv1Yl+f7qWTDJmINPPZ33zJz3jo1mN1Tr7PgmKbmidpUilIgiPxog1Bcvci7553/cVqgK41mxyJHIw6X6N5Gv13TLTgHKtsFhWWfZH1DFIKGWmO+5NR/OlwrfXWzF15yNeyrhE0lnpMmNpU63pMcZ4r/FfVNbkdRvYXlE/jG8pBdnP9DkjlhkFfJ3gLW6+lD6yY94j4eJHqgO7OWggg/0
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPF6915D992B.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(4143699003)(11063799006)(56012099006)(38070700021)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0PkbNc9vfCrjA9aUPTI76N7KdqgP4igZ965LZk0uLaQyiTh7S5jzZjL0mXmx?=
 =?us-ascii?Q?4AXobu0NRt2coW86D3sLBuVkWTUwzwQy0mlCSHtjysYTs/slK034twdovD08?=
 =?us-ascii?Q?ckqT5n5aFqdxVw3PMmL6wMrEENDl3mlyBpG6LVoOsp8lmrpqVzuDPzFOJphV?=
 =?us-ascii?Q?44vKJJrIvgIe+n3MmVdVqIITBWrvcr2axOTAE93tAdtgFsiXLYXMxWVden5J?=
 =?us-ascii?Q?kuSJXMQb0tPp9gijdXwixVV+o01lXZ1mBrOLWMj4oGGQIhTPCjkr7zrlmnZF?=
 =?us-ascii?Q?0VNXGG05moa0d+F+96xkxOlU6F2+vWOXRs+okd3h5zNy6lVEtjYQvYgcN2qP?=
 =?us-ascii?Q?LRoOxj3sM61OMulCASvMO13K66E3+TbwRsmjLb9NG9iCVaQWw5e/5xkv+mtm?=
 =?us-ascii?Q?+2u8C00yLyCmoXIlmAMnItgzm0iyZ/W5AgGK48GZJXerc5pUNlpT0Sju5qjp?=
 =?us-ascii?Q?CRlS3ErUNIZ/rayTzCldKItxSHIwM53sqSI5ah+WZL/7JhBrcc4FtjgwW2v8?=
 =?us-ascii?Q?oXanwGa1u8D1f43vGsk2iSd4/cRrv4ZGayEGvTWgbXl6h6VIqm8JgV4SnvcX?=
 =?us-ascii?Q?UpmwxRGxukRJiZXnMDKMMzE9T/aD7u8gAp8seH6WgUJx9in5Xy+Ge50JcTHu?=
 =?us-ascii?Q?f4DYTVdIN4XmB51ijlGsq9tF5ClkXbR0tdsgsE1ah73NOjBNEA/o6sNTzwqM?=
 =?us-ascii?Q?tIFiSFWJbt2/gOtcmHXqofjdxDDj+ze430tuTLUd0L0A1Fd+WuENjP8cN08v?=
 =?us-ascii?Q?rMcTZJUa8CAUNtZJzS/+mSqTPK7BhSUF8DIEvM7+fAnbfELVcNGv7lF20dyj?=
 =?us-ascii?Q?u0HQgY1wT0dQhpTjGx7xvvG0D/KPQt0Ttx6UPd93Y/BC3lpSH20WTpMf4jMf?=
 =?us-ascii?Q?xaogA1PP9amrMqWxsHAhLsnq/DqIUOXR0z9+CVNAYyVX420WeTEFEvSnSz7O?=
 =?us-ascii?Q?ln8ciiaCt7vr55cwvuo+8Jqsy2Vw0tR6Eh+SByjMCtvJaQJPSavJHRT/sYVR?=
 =?us-ascii?Q?LviX2749K2JVulZOi9ikWnJy1cnN6tdO8l4JG3itCjGQ1l0K6uegkhXM3SNT?=
 =?us-ascii?Q?UQxHrMFiZTb8JiJKj/ot8fzMuXYpJSZ1auiSVe90rCBih9aWsyZMET38OFcJ?=
 =?us-ascii?Q?IsoarfG1goamkvS/xHkr8Ig+rY/eg/STcBR12+AWrZlfzZo7T7nlts40vhZe?=
 =?us-ascii?Q?3ozSLJMuM/MD0MEzeDkDFFQ/OsUwJPfqwSQFhZv75ANrQNf1TQyc88n7O9i1?=
 =?us-ascii?Q?1maA4q8TBM3PY/9dGjeR+cQ/vbPc9YmpWpW6OE2QkMxVHqLktEG/6Duwu8LF?=
 =?us-ascii?Q?c1njtRpp5eZgLsvtCIvtrEk6SC+KOAqAaLZ2EkkZxyAq9v6WT8GMDGaAAUcl?=
 =?us-ascii?Q?gFKVCE8W3vSU8aCChITDdIsDBokVxadogELXslETyasSGRfRXLb1XLqv2FvO?=
 =?us-ascii?Q?Sj2nD6M6o5XDA2gV7SxIBqU1eXHFJrGc57JXsDo/8R4QAP4UtymtUS9fqoGy?=
 =?us-ascii?Q?tTxzvaiMxtyu5hix5b+nhxLPW1Hh5fb4PptkSgQ/S2yiv1kh/OJHwEdv+a0x?=
 =?us-ascii?Q?3srGnIT+rNrDGh5/mI6dH2yo2oV2F3yQAqQ/3DgIM5HpyJOxUbkLvUh1x/6Y?=
 =?us-ascii?Q?oZbbpabKHM5ZppO7zZio/cJ9Jq0uT+/YfqG2BBDCvVKdJ91xYXjZOXVfLQ5Z?=
 =?us-ascii?Q?bDcJ/0rr98LYtyAPSP2WOqDGzv9MpOmxSTezfah9rXAyhwyK/3WPPL32DwKq?=
 =?us-ascii?Q?RqQmp6jaAg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: riTh8hKw/vq0x3fGrgHdT2UYmaEQlAVm8DQpVi+v74QYY5x9iojdY1yDolV+RgEP3RN8EaypCw78Xt12kne/Aw5fDojV8tdQAzNFD51L12uUuMkDA7dbW1mf/ibrRFM5Y0BDepx4YjYvEPYa/aETej02qYJbiD/RCgYTM7iMBqlKg+r970rtSdNBCUi2TGdA2F0E7aBbaJqIC1+fBxiUvd8AzUKFMZUVWoOMM6q+6jTIN9WjpDOqb+R/15HTpLpsfc8MyVbhL5RIfsNqIQADsCX2GmdPUfwZS12oGzJx0f74OE4mz7Epn3S0syaywH4hEC9sSifvYDO8SDQ0FaQiZg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF6915D992B.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d48a2e8-7543-4b3a-bb1b-08dec7b0f43c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2026 11:59:55.8485 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fxAJOUFf7mMSO0aC91/ctC5It4ZbgtoIDzs4fgsxuYNJhYx5/lygakci/ommtGQhwyid7iE8a8f+YR1rIJQRbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5285
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

> Subject: Re: [PATCH v3] net/iavf: fix to consolidate link change event ha=
ndling
>=20
> On Wed, Jun 10, 2026 at 03:34:27PM +0100, Loftus, Ciara wrote:
> > > Subject: [PATCH v3] net/iavf: fix to consolidate link change event ha=
ndling
> > >
> > > Handled link-change events through a common static function that
> > > reads the correct advanced & legacy link fields properly and
> > > updates no-poll/watchdog/LSC state consistently.
> > >
> > > Fixes: 5e03e316c753 ("net/iavf: handle virtchnl event message without
> > > interrupt")
> > > Fixes: 48de41ca11f0 ("net/avf: enable link status update")
> > > Cc: stable@dpdk.org
> > >
> > > Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> >
> > Thanks Anurag.
> >
> > Acked-by: Ciara Loftus <ciara.loftus@intel.com>
> >
> Just to confirm something here: does this change fix an actual underlying
> issue, or is it just a code cleanup? If the latter we probably don't want
> to backport it, but if it is a bug-fix, I'd like to include some details =
in
> the commit log of what the observed issue was.

Hi Bruce, I believe there 2 underlying issues being fixed here:=20

1. Ensuring LSC event is sent to the application AFTER configuring
watchdog/no_poll state.
2. Ensuring watchdog is re-armed on LSC event, if a reset is detected.
(Before it was only re-armed if link was down).

The comment in the new function iavf_handle_link_change_event explains
the reasoning. Perhaps an update to the commit message could be pulled
from there.

Thanks,
Ciara

>=20
> Thanks,
> /Bruce
