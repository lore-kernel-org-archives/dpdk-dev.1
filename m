Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E0C2C5CFEB
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 13:13:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C646402AC;
	Thu, 13 Aug 2026 15:13:03 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id E7B8540298
 for <dev@dpdk.org>; Thu, 13 Aug 2026 15:13:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786626781; x=1818162781;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=iSWOQmiEQS4fLKOy4wK/u14KW/TtFsLBNAKwo+iBlnI=;
 b=GsXuGJeCuzMHpXvuBe1mHxEOP7iaBHwlaTXmh6pYfv4OAUYUjEHmHN1k
 M50dpVcn0G3lLLWiTNsty8gj0tW347ED0Zj35obDeunO7CDNCUSRYl/Zf
 +QAtyhNKVqi2m36HF4xHnl6sl+bwv1GxDj3VyfsTJIVHgG58gq0a3USPs
 RNz2DwgVhbAeivZMv76J8MbpCBPFfgd6gZ+VWidleTiH1cuiYwaWdBVOe
 wOJ5M4zhq9d13vvDOUafQ3wWWWuF+hmbdtTTVWv/oTgIQ2jxKiuovTkzD
 9P/nfY/ApcoscujgG5XA/tI4vmTLt9yhvJaGpbXyj9eNJ+xApS4xwQdkT Q==;
X-CSE-ConnectionGUID: L8qj7CA2TGWqaOwmyq3Gfg==
X-CSE-MsgGUID: DiMHKKxkSt6I+ZfY19TaGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="104733096"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="104733096"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 06:13:00 -0700
X-CSE-ConnectionGUID: XdAMg93vSVOlnHJwefZPLQ==
X-CSE-MsgGUID: g90sHdbyRIOwXefrnjUQuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="288724219"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 06:13:00 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 06:12:59 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 13 Aug 2026 06:12:59 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.46) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 06:12:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MbW8z04FTyMPnfAEIcbXAJk7w3ECMpVePEt0MBXsfN/wW+fnCMGgOluuHPxz5XHEn9FI49CE1j4YBw78dzELSuh1Rwaf0K9brgu6clMdb+Fj68/I9tjvfvZ6c5p5lNhR8a7a0CtydF5fCCVOL0Goouq6dRfbjjAGEgoKy7Xb1UQdpSTk6aWFUoQfbcY6kH96nP/PwxrXDYKsBZK/fJKo4HOwx71TS6q5+JfTBjUpEkfu2mfSEPXqIwr64FfqyZt9bH2w6g6QbsIhJ1M9LYvOnIwS9hKDWMMorjfS/DZqAil/LyeO5OTZE6aa18wl4X1G891S/JH9lKDYU2xEVCts8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iSWOQmiEQS4fLKOy4wK/u14KW/TtFsLBNAKwo+iBlnI=;
 b=DkvN6A0KnWYyTI+lSWxzh0tCXwMDEB2n/+OI+85ZbT8/WHr724qpYJuPd3bXHCfPbwLou6b1lzac4jaUn9RcQ1kooyMLwZrQ5JgLpKnUumf70l35VPI9+viFmyB6hydduqLN5kBPBUEdjA810ujmUr+FC2T8Um5Qg4vjNfzoU8TKVcMEqqsYDCzSYob9EAZWdQtWt0AHKXA0fPsKITPg2Wwa8CkO8X9BfnE2PojM5sA12SeSlAWHtVwZxh+FmT1FfBkHfNJGqxtPhCF7iA+CBt+mDbvmjoYKM69kM90fe/1yWmyK+/ZTQHPMcgviLb6MdtPyaNt/JoFyiA/pT1hNGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA4PR11MB9278.namprd11.prod.outlook.com (2603:10b6:208:563::12)
 by PH7PR11MB6426.namprd11.prod.outlook.com (2603:10b6:510:1f6::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Thu, 13 Aug
 2026 13:12:54 +0000
Received: from IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057]) by IA4PR11MB9278.namprd11.prod.outlook.com
 ([fe80::9bef:c20f:571f:7057%6]) with mapi id 15.21.0270.016; Thu, 13 Aug 2026
 13:12:54 +0000
From: "Loftus, Ciara" <ciara.loftus@intel.com>
To: "Mandal, Anurag" <anurag.mandal@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>
Subject: RE: [PATCH v2 2/7] net/iavf: defer device start when PF VSI not ready
Thread-Topic: [PATCH v2 2/7] net/iavf: defer device start when PF VSI not ready
Thread-Index: AQHdKxEKBmJnZgvmqkq8G3bAhzhsX7ab835A
Date: Thu, 13 Aug 2026 13:12:54 +0000
Message-ID: <IA4PR11MB92787BA8C6BB190A0EE0F31C8EDB2@IA4PR11MB9278.namprd11.prod.outlook.com>
References: <cover.1786617159.git.anurag.mandal@intel.com>
 <3bb2a6e50c1ba06f4929fa9bc8374416d15096eb.1786617159.git.anurag.mandal@intel.com>
In-Reply-To: <3bb2a6e50c1ba06f4929fa9bc8374416d15096eb.1786617159.git.anurag.mandal@intel.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR11MB9278:EE_|PH7PR11MB6426:EE_
x-ms-office365-filtering-correlation-id: 8568e412-0efd-487e-440c-08def93c9643
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|18002099003|22082099003|11063799006|56012099006|4143699003|38070700021|10067099003;
x-microsoft-antispam-message-info: Xrjbhcm6D+Stdjn7TEBF6uxuQoPt6scmtuGeptoOgx/gOQz6uUrTUXFmE1/NychgsE76bjVO2BbYfWBMs6K0RU08J8/AW0jJEQJ6DT3EP2g++wVkilMaAtOJWE8rTaEDCaBH6Vb5jB8GkzICnrT3TImVzrF4+qqPlZyEZ9VmdN+P1dOHxuC18oLWiFuy+bL10OV51NWixIhoFpG1xGUfxqWMhT7ZssTXh7qyQ/hNXTdfZx0qRqqtc1EQdJg2zFC14ANnSJDU3L55DQF+QyLc4q3mFsGy+8dA9FbzcEAH8AGbWvtJ7ZceT9a6cQl0qeN0zHovGPfXU6cbUtYO33hU4k16AkW2DNCrxDje6YvDe9kSveATm4sX2h+zxscbeYrScQPaqeEdIePb1jH5+tonOoIQgBxnB3tu7E1Gn5Dsls46kb47eGRU9vnHgjYOtZ4QBM9ufoe1nI4/z2R+zKGP3KojoOlvUbTR+IJ0Ye9Qun0hpaZSIiJUWxVILKKtO5R6jH7KujO/ZELiARuUuDjGhVQIEa0Qi4sHGFOEC1A7D8XKjlfd4muANDR7EnF9oabD382s/Endr4yi+x51ZCjpSWjSXz9Etux+zUKBTtP2AzLrIhRGN7SUqDtyTBxRUlWo/NXAlsIUUSJ9SDzIz9yzk0G8Dsl2zD6JwieDgYfOosm0Rpmc5DLp+cvRsF0XHgdlD6zqsRGEQjX/gQKDcJpsnlq89vphhUjLkTYLeoe52ZA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR11MB9278.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003)(38070700021)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?w80YqkuiZ/FZs2iK8dkC0aTtzq5rszi/L1JaSK9hNRzl/O8L+q45rHLgalUe?=
 =?us-ascii?Q?MyVPM/rM8RxO97rNECa88OJoI4a+gscn8ZopFVcBvqi2H0MZkR7CcnNGWipJ?=
 =?us-ascii?Q?7Y8uYXH5SI4bgBTSY1VG/Cjf1KYCpVrw/zLCqe5rJiR5zTK44xuocbqJ++g7?=
 =?us-ascii?Q?PcqutDf5M32R+++JP52E30A2s40UAHz1czogpdo8KsJJNa3NOKM4q9GlDLCs?=
 =?us-ascii?Q?vYPXo0Knqtc49xYy3t3w0MYZ0a8mz+3S4un4RrZVUANBpLYwylF+RqWh19y/?=
 =?us-ascii?Q?y6MfSLa0NPWbVUSToCHjMBMCI6GgLZn7iE0QW0KLzoK0yGBTBpvr5GFgJm6h?=
 =?us-ascii?Q?o023ky6etQ0vShWYwxsHtpD26Zis44vxfcuOHUIwk8284EGjvqDbvzsKnshz?=
 =?us-ascii?Q?vtMPqMwHsvVozOVT3bRrZ0jbzTEh9nJP/6CkyV2/xofBj97VuoMZCL3r6nsD?=
 =?us-ascii?Q?3NCCOVal1CZxQcNhFwZsv2R0obmHvWK7k3tA0haE080zI9EWGcVmphvLNJpH?=
 =?us-ascii?Q?r7IGc+4K+sUBbKDMXP9i6s0f8KRWSvTDgRRiSgh9tdvV8xTwIq7foTUqXwNf?=
 =?us-ascii?Q?aTrgPoLWgVaMaH1C5f7LA/rscSTUFFJ/KDHkgfNbmZW/C0stuGAEQgnexcXt?=
 =?us-ascii?Q?tSIcMXqlvn0H54FFBNw+V/7vRvVu2oI4AF+fqv/qhRmutcv64Ogc4z7yhEUn?=
 =?us-ascii?Q?mWQ16n/NUmbltIbm/gE4xivIh1AlAQ04Ey7qP6hw9/Pr2OB0gb4NwqpDMQju?=
 =?us-ascii?Q?kuz81qfW2UdZD7AbMdwePnDGLyJBfmjGfraH4LuXKPpJIHMDYWJmXjR788PR?=
 =?us-ascii?Q?5k7SgKRTsFX24dkIdXFLg9WZ7MmB1kjLIwqyhQ4IYvuhEJzC6YWvSwroRWGF?=
 =?us-ascii?Q?r6ITXNFo7A0hySpxEMaLQK3uxqTzMYxr284EVVgAhsja2U8Sbb+W24IeRriy?=
 =?us-ascii?Q?L1j8FG5bKTaNCDKj2Nuu4P3++eVZPaLtrGAq4dQEMEJ8gmNrmIUZKFjHQ6Aw?=
 =?us-ascii?Q?ZHKimDwYVgZfM5C91kBlbwb3i/7jmEUtVOCJZNhQOkkI563vvaZ1rmOqlybf?=
 =?us-ascii?Q?8GYNKmmp6pXab7ueCfhQdMTVcbgfJxFaakBqNGEfUb66Ro3e6XAiwRCyNCo3?=
 =?us-ascii?Q?hT0tUrxFSX2z30rNnjcML3oFZf3UC953gKkQTkIsndFea6Cxegs7ypCvOl4d?=
 =?us-ascii?Q?AwqvlpGDyt0V3JL3/llFHlECY094uS6CZYgH0E+ikhTbI8mo1INV+R9O7yTm?=
 =?us-ascii?Q?upn3pg3D+9C/Go6zjRpB98yEcwH3JA1AvWeY3JP9W2wdoARB0m6SuogWgf3A?=
 =?us-ascii?Q?3p2A91w/MnKSyOTmd4RBZi2ETAxzZsBgkKRFz/MuLRdVspsLy4ZgDgDsSWbl?=
 =?us-ascii?Q?TG6XRvoMWg46Tl3MwT1MEdL0MUMeM4szytSMbQn0aAgjnnndfgfa1eYe/c6T?=
 =?us-ascii?Q?5nsNiai4nFcY1MV/rt36GyrAABbvntuT7rzt3/n13zZDqzANcYI7R0IIEuCa?=
 =?us-ascii?Q?xovdveUrKKOf5vNnqQAlftiJ0pLVxnjWUeUgCfGN1gdpeYHI9VUkcF09kVR6?=
 =?us-ascii?Q?TuJR0LSXGzjGS5GNiXEDaYJE8rA8HCT7+Ka3Cr5tuUCior9IlC13+iub+SGD?=
 =?us-ascii?Q?tLOpMdwFkJcnjaXk4wxtTG00AqUytDRPvNYfHh4n+2mj46vJhPt1ErF5Gc3o?=
 =?us-ascii?Q?C/m4lr2MmKfYCwnCvpo8wv6v4BAEfIctDQ/NGYeGBWqh3BxqsDjG15g5/Dk/?=
 =?us-ascii?Q?8toB/foMvw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: RD1toGN1YE//ikkO181s2LMzsnqcOrc8gGBWs08KQHtr/6i/6fn58cFk/7LDNLdqWerXiEekffCASDCbJvp/7ygqki6bLSbbVCuaXCxSgm5IkpCbwwkDs1Txh9bOsjiCiQCW3pT4lP3kEkQ+ZDibjcNrqz/ZYExgAaqcHylgwJ1w4rlUmcUF83LwQIQ0hnOmZyYdoi+ToZ1wpHO9bNcvmG/HNbu2BKcGMEcliq8GX9DHYgOgidYahse+ZLlapAydY1lcwo1R2mWUPkAsTAzKNoqVjFaKV8R+K+xH2mpK72RoMiOBDDcafTMro+LxEtVfGN57ZTcUISxx6+cbcHYG4w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR11MB9278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8568e412-0efd-487e-440c-08def93c9643
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2026 13:12:54.6484 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 24c/3k8BjuyFipErRRmM1zgNMl4MTQq/LGXyeoxW+Uc0lQ6kYqri2N/56AJC/wnuOg9YdqYUM//EhIrZMGAE6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6426
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

> Subject: [PATCH v2 2/7] net/iavf: defer device start when PF VSI not read=
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
> Fixes: 105d9fcefbee ("net/iavf: fix race condition on link status change"=
)

I don't think this is the correct Fixes tag. It seems like an issue that ha=
s
been present since the recovery path was introduced. Maybe:
3e6a5d2d310a ("net/iavf: add devargs to enable VF auto-reset") ?

>=20
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> ---

