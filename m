Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6956C4450A
	for <dpdk-dev@archiver.kernel.org>; Sun, 19 Jul 2026 11:17:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C19C402AD;
	Sun, 19 Jul 2026 13:17:41 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 1458C40297
 for <dev@dpdk.org>; Sun, 19 Jul 2026 13:17:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784459860; x=1815995860;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=oIWEfy2b0RopFt/iknHb8cZpOo8bMj5gWoKa/Ruz+ic=;
 b=SQn9iB9CkPgWTteUAexHUUPthmpeyd/oqBhLo9pmWs87WBJljAs7l0aW
 cLoPe9InN4TXc8uQ7Uij/jz7DLBDfdxxkMijLVcRUmjc6xbcbg0ang0lf
 PEislUvK2iJ/vxLzVuzip2jjEhMNyHTgxQa6MdAN9f/B6uVIpOzqBsIRX
 DFK98/B4sJXAPxiQ3LpzVx2sINGV1QFYDdnG59eKlV7jK3gdkD0mGQkD1
 hwVfpdzboaP3vt7bGt2NAGkYls281N/xhf3dZb/NbfNgbLqsVTNwZ8EwM
 zVeGoN6qlrzOtP5CzacqINhdJdfDTMy90P854PNSO9EQ1nB7/hl4bxL20 A==;
X-CSE-ConnectionGUID: sH/Dn732TXuM8KkbnPDnTw==
X-CSE-MsgGUID: WZXspAIQRgyIHtf8G+K/Rg==
X-IronPort-AV: E=McAfee;i="6800,10657,11850"; a="85088295"
X-IronPort-AV: E=Sophos;i="6.25,172,1779174000"; d="scan'208";a="85088295"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jul 2026 04:17:38 -0700
X-CSE-ConnectionGUID: YYGq5uqJRGeqBXVxFa5QdQ==
X-CSE-MsgGUID: AAOv5foCT4uqGteknsNrvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,172,1779174000"; d="scan'208";a="255426539"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jul 2026 04:17:38 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sun, 19 Jul 2026 04:17:38 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Sun, 19 Jul 2026 04:17:38 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.53) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sun, 19 Jul 2026 04:17:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Th2Wx9SS20Pe4XfP1wM7wdQ41d9ze9zV5k6SbxNm/5Y4ffwuZjvLDoeUvftDyccP/F5Uha0H6BNbolbq/ZDlhsS0Q07J0opVHhCLkoNymUsXaQ9FsPYz8JqGJoxy/qCP19WuGwcQvv1ys6e4519vSl94xJ/gSiWl8n1IML3fsWypky9Dv7CVEeIzi1kvQ6gp3nCNfJAfrD2yTIg1y51JxoD4qNEBQZ29tcFem99z3hXsSWQkUjdr+/eS5mXmDDtTbQyO0NAypucmy4Q6+G2qMPKuNLoRGZVXL7Eep3lJdqcA1FBdFrxDxnwm+7YuJ+6tkbi1IwoqIgM0fNmuXNZZNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oIWEfy2b0RopFt/iknHb8cZpOo8bMj5gWoKa/Ruz+ic=;
 b=kavr/3fMlH1dk2CA1tf0o2KC5en+RpixelICaKlJNUQuR0/aKXBVyhuIaaPUHieIxPiCq8KQBPyfhQGIYK2G69j7nq2jK2NHB4puwQV80gexU5vNW+EAUWknSBo2k/vrmgnQ+5zBPaS3e28HfDZPMV2AMRKGGMrfkRd6jyXpmIWcs4mRfuD6Zmjyv79VLtdgVReuKoUNQP8TBB3lLp8yd8LtSieEi+LXsJEHHv4h/Q6EIlocRrdvShlzlTvauiUi1AfWZuzxnLyymlRqHn/Mi15OMuqaviIcAT9w+8MDWTCOAlj9Tmbmk2k2cJlOVCI6tKEYAnhk/LBYUKrjB2ZynQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6782.namprd11.prod.outlook.com (2603:10b6:806:25e::11)
 by MW3PR11MB4684.namprd11.prod.outlook.com (2603:10b6:303:5d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Sun, 19 Jul
 2026 11:17:29 +0000
Received: from SA1PR11MB6782.namprd11.prod.outlook.com
 ([fe80::cd29:ea71:32e6:ff0b]) by SA1PR11MB6782.namprd11.prod.outlook.com
 ([fe80::cd29:ea71:32e6:ff0b%5]) with mapi id 15.21.0223.013; Sun, 19 Jul 2026
 11:17:29 +0000
From: "Mandal, Anurag" <anurag.mandal@intel.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: "Mandal, Anurag" <anurag.mandal@intel.com>
Subject: RE: [PATCH] net/iavf: harden reset recovery and data path on link flap
Thread-Topic: [PATCH] net/iavf: harden reset recovery and data path on link
 flap
Thread-Index: AQHdFjGEzH3jBEz9uEuMXkJdviAAArZ0s57w
Date: Sun, 19 Jul 2026 11:17:29 +0000
Message-ID: <SA1PR11MB6782F1ADA2A8747CE3E9F7CCE4C42@SA1PR11MB6782.namprd11.prod.outlook.com>
References: <20260717211526.716220-1-anurag.mandal@intel.com>
In-Reply-To: <20260717211526.716220-1-anurag.mandal@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6782:EE_|MW3PR11MB4684:EE_
x-ms-office365-filtering-correlation-id: 3d3bc2ee-c4cf-4d12-ee15-08dee5875217
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|22082099003|18002099003|38070700021|10067099003|56012099006|11063799006;
x-microsoft-antispam-message-info: AWHW5hka70XXcKX2rESI40bUdmv7KUa6nItZ46oC6XFVKDEAzV3FQDb48tch8KBywpuV9CbjpJjfLgha3NEHZ5zW0VIogGWpNQLrnTsCk+rb2VUmvwFPFXHkPPejxYEy2eydmx4XpSmaUll3Vg52zCd9tL0rF6CkXTxSRiW6VSsyPVR2nCamoNsoV/JL5jGsmGhrp0CLS1RAbebWYoKH1LWa/8F39krG23/WotF7pRo+HjKVEYGpc6JaaHkHBwQCzg29xjEW2IHDMb6YxcLRbaKQGvqQ5gwUv41xx/txxWCYaS8VoZYSC1Ibp4hb2I9J78/TJY8X4xgfinWrsgTfaXEVMv4DPDm4XESRc6ywHxJuizuaH4siboKwcx4jjHioNnhIEZelibUN1XBFgtIE6e77/TkFsYwM+ZB1NqLL4OUvrN+78c/7o+6a8bBUNDxdtt50gM/PLogUXnsujG6HJOBcTXLD3j5yHjSwc4JeJqXB40MwonsOmzRJxiU9AjfiExfM0JjuRaRgPIkPDFCuGQQyxZEXlk5DyM7ByD/zI5c17nhl4QZHhCXfNDkaGDVVzHU85hccTLtxAEsascGdGLQ903aIePSHl1S3dW7xDoSQhpZf6rxoHoERlv8yJhGXBwf1gEDREYKmDVJ9exRQYLpcELDfrxCGAAHdhAMPEoW3pM7yigghYzDIbkRu/h9z9JOHZ/KZUQfUoTutarhDtSLfUp+GKzlxbfIi3BoKjKw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR11MB6782.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(38070700021)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yE7f6W8toeDPzBY1jzfIWI3Ae3rpbDcyWc1yuo06wdJKVVTwke0TMGOD3K7u?=
 =?us-ascii?Q?BcvvqkiDfgA8oCt5rTz8TqwL0+JdcxJ9cxW5spqhtbKqYg9nuy8kF7PbrUuz?=
 =?us-ascii?Q?bgeipumBCMPDyXZTBKKWygttHVR9Fn3D/5xsdF5efm4A6a8g7+Nv9gWVodfD?=
 =?us-ascii?Q?LFB8OuUama2ZFS2A9gwcOhrQ1xU+BOZEO4AUhT3hNz3inkDexjFqHYf53Zl2?=
 =?us-ascii?Q?k0p8Gerbj9d4ZBb0QwLytbjA+tbHDVG4ZSTLmfQgE42k9VntTdLLKUne5vqn?=
 =?us-ascii?Q?6eSHjyWhfpL6k9fzWKas2YalwZDdGC3OtYOhaJvo0dXrN85RTu+ZiLWAO9Aa?=
 =?us-ascii?Q?n7dPDv02XRh6PMsPMua/1SATUgFn3ghGBExwvVm1tFyC8jBLNEgseAQfgnEY?=
 =?us-ascii?Q?RvD1udlex1Z7Da1futSrW4sWxW1wesFgfDa5IOQPgRIP/aBcTQrJenKqVT55?=
 =?us-ascii?Q?t5VlPt1a8JoktpbJXonydmxdv/D+qSR2U5d0oAQX+xOG7g+ETKtdKyUC92+y?=
 =?us-ascii?Q?+fEsKr/IKLsST8+Jm/RJBowR5nG1betvefrDjJ/75ejxqDkdxV5yLsHd1bJe?=
 =?us-ascii?Q?P96DJCtlMAfYfsvFdz3z6Mr+RoLXz2bfr8ha5SZy3WlTeO/NYDmABFad8fnf?=
 =?us-ascii?Q?EYTxa+58ssVe+CkPQLl2tlqsShfEVsLMnIjtRpZXAAiltpLxoisAbazdIDWc?=
 =?us-ascii?Q?vREyKlwNjakd8G/qmBxnso8R9otCo1l5x9ErQFUy8ixv+3am0/tEWSGNHJCH?=
 =?us-ascii?Q?Lkp5dhCDq8WQfGzFRLN7bfobB+egmHmj19gqy7IyZhPUUCbwo0LMJnNV0TwV?=
 =?us-ascii?Q?Xq16z6dwG2hhCeWeG9bwEc7McVJIBSGLkQH1RD7LaGNxnQy7cnSWfU6YXwlh?=
 =?us-ascii?Q?wq4f7IP9uZqE7+cAmCELbIuCB3C+WgmmY+KMFiD/241OgRnBb+Ae2ioDx+1a?=
 =?us-ascii?Q?eHd/ZqgSnO1Vwz8NgU3w0vv+dI3VDdlFWDdlzfEjW+PuA4R48ZJIeaN9cIyA?=
 =?us-ascii?Q?eV3nkPOu3lPq0ZR0b6fN2vhHOEwywakD3vis6UG+XD4W2+17lvneJ0J0pPhL?=
 =?us-ascii?Q?KtiyPLcZEmP57vg3851QrwJumNqXqv1w6GdSKnXB3Qc547PHTAiY9je4C1zH?=
 =?us-ascii?Q?nNGAGU0HPyOK6nw8f5s2xlDD+NlObZL+HQivg2VW/pO3PUg5ttyDOkLJZ5ex?=
 =?us-ascii?Q?aEsHNA8EQA9tNsVGNLcsTT3T/1rulyLT2sPgCHn3Hwr+PhQXluKcrH11THbn?=
 =?us-ascii?Q?N6WRaCKdBbLBt0+EqgoI3Xqf4zVnW2AXoUhQWe6tRD8XST7XIAtO6u680FiU?=
 =?us-ascii?Q?LUS0ESMs5Llnw0cy+i8UtxkJCXx1u8eXTdahCZH2lz441syP4AN0cLGfPlGP?=
 =?us-ascii?Q?rVxu+WVmyAuWvar0prJ5TheGP1IlB21gruw25dJyQc6oIqoPXS3QuGtHwOlW?=
 =?us-ascii?Q?m9VolZYMn+ctQp1Phynsnlvd10+3WaTsrPyl7cnXLk3oZG5C3JedZ2WjGAmD?=
 =?us-ascii?Q?OLg25XD/EMrRno+2AMyfif+MUN17Psig2vKQm0TdeGR5iTDdVpifpZVSmW9J?=
 =?us-ascii?Q?WNW9vc0KIhByJhgn+Nj4XUr8A3nUxH/pVfmXVeGXsU71K2wn0iXzEN4wG3IG?=
 =?us-ascii?Q?5yF97dhEgOXYxv5J5wpOXVRa9NY4kGShmMYiJh9ZG/FxKYREtLoyeJxwzOCh?=
 =?us-ascii?Q?SU6iOF7TdZB2ThCcRiayUnZreVbj+VN4jnyJuEaVjhajO1ISilEBe/g4Cq4z?=
 =?us-ascii?Q?wsEj+p2URg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: IRn7yBSCSNvPYmO6RFSl2ksleNUGqVRUGxPgHYOPkaIcOqZubxO9SzeWgWZCa2MZ1vdeRbBRAq5AT2ci0kqg2+k4LfobZFi6YTt/SnlMXOQYStJ6ho7xfzsaZZBQadJsWzRtnn6cRnJFqCxJjCEIMv2C+OoHbORinXCUwlSuym6Yuqp8KCNr7zK3CTLkAiwmGs57+bCD0Kqyl4egTlPxYvpN6yKeZ1nL+KcBpdDx8ByS3yEP4yv+gMbBHSYSLP1YGToFwcgXOMyzAn0S/nYPX8x4jwayNDB13j7WDK6W3JC+eZgqnaWiscuLSwJMXK/KAgzCUoWahJODKQK9504bbQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6782.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d3bc2ee-c4cf-4d12-ee15-08dee5875217
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2026 11:17:29.3611 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fdxAUuyHZd1C+aBpPlqBTtjfTql5Wnf9lnKprCKxjYXdBV9a4bHHzk8nIvnWa5OzXWPJY6UlGorsE/4xDnaFAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4684
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

Recheck-request: iol-mellanox-Performance


