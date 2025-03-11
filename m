Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A814C28B2F
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Mar 2025 07:42:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC20640263;
	Tue, 11 Mar 2025 08:42:00 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
 by mails.dpdk.org (Postfix) with ESMTP id 60D9740261;
 Tue, 11 Mar 2025 08:41:58 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wmkPsMEWxwHeVbYCNGlT1E6xG47ktDs++DrfPy3XTQ2Re0TeRSJYlbRI+iHllgRZl2fiOjx4/gDIURMMK+WTWRartiLq9QPqbz30gh8BRN/012u+Fapm+zQOEJ5T06tMISaHae5Q9QzJCWEb4e3KOagYAQH4Ex6Q3F6jyQitt1hDVseiCS4F8id/m+UGO866gcjBlwTJRYzl3BcZz4QrQTEKlOr/fy5MHZodbwZ2WcQh37thPetVdTmdUIn/LjwysDv0HP8eY3yJVJkLsdhIRoe15jbt2c64Za+J+gCXOC3EqXjWTEJJkpn3IBwCzDfCWIvmRYKIIzJ3cOY5BDbqcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7yGtSn0tWWyr2hT2A9hk5+6yexgnXUhAIewQsurQo60=;
 b=YACb4BNUUBId8E9sQacIi+YJ2KeEF4EvSP1UcIZZZnbhuW7+01fO76PhvK7I5ZSIqPWkVBhm6amGtMAU4u/WxlrJQeBaa0VeW/Nq++WhKUo9xRT8M9eaYqw0Jg41J5JfN2FiAnaR6fgyKaoMrbqleCw30zw6Q8vbjl9xoOu2/kmVuBAjOFtIRUarW8hZR9NVMespl52XuhFGmq8odRy+4Bqaqe0vBDYNHdU/CbnodhB9Zdd+hJkq9+mplp1xtK2f++gcEAezXTWaqRwzuv6kWw4JypaOXTlN8We8opkaQmrtZpSGXX8DhycAA3Zx8mqZrWbA/fPtvpmxbVHqf5spCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7yGtSn0tWWyr2hT2A9hk5+6yexgnXUhAIewQsurQo60=;
 b=C04RWiDEaJqDbF6+u8dGuZ7Y9XoG3iE+AyHYStRUFD7kCeussMECtCnpOBFmPFa6DSPxScoirBKDxMMt4kO72ep35a9H4cSf+PmKN+eEb/c4/shdFfU4f6BO3jv7Eb1OV8+g80JlllrYLY+jgFNudJs6aI9uq4xtIlw5JX2U4Sb50mQbjG1rC10RM+y4vZywusoxg6DYgoLOPPDU2JYKjzg+Nwq5ETAUg24Jxd4v4WNsnK+55QX4hvBl1nZUmg5w5yTg2/cHzmdz2BO+9o5jDQfHYNXwbnQ752gf96J1H2D3F+fnUXGkrdwSQH/nyxyKte3sHCUId3nKR+QdNBpXRg==
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by PH7PR12MB7456.namprd12.prod.outlook.com (2603:10b6:510:20f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 07:41:54 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%7]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 07:41:54 +0000
From: Raslan Darawsheh <rasland@nvidia.com>
To: Maayan Kashani <mkashani@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Dariusz Sosnowski <dsosnowski@nvidia.com>, "stable@dpdk.org"
 <stable@dpdk.org>, Bing Zhao <bingz@nvidia.com>, Slava Ovsiienko
 <viacheslavo@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: Re: [PATCH] net/mlx5: fix flow create failure with GENEVE options
 match
Thread-Topic: [PATCH] net/mlx5: fix flow create failure with GENEVE options
 match
Thread-Index: AQHbjEBYmNvcFIqWGkar7NbToi7FVLNtmKWQ
Date: Tue, 11 Mar 2025 07:41:54 +0000
Message-ID: <CH3PR12MB8460CFE6C705E58C125C9842CFD12@CH3PR12MB8460.namprd12.prod.outlook.com>
References: <20250303132931.71335-1-mkashani@nvidia.com>
In-Reply-To: <20250303132931.71335-1-mkashani@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8460:EE_|PH7PR12MB7456:EE_
x-ms-office365-filtering-correlation-id: ca6ee21a-eb59-4491-c057-08dd607031d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?bEG19fZ7/vv6/QQS6Gu/z8F9ybRZafawihGcnb7bF7iGFjiCqm38gLVmLE?=
 =?iso-8859-1?Q?CNA6oFxr97+wZQC6PGp3ltt2qcOK+1+b+H6VcW5/eBd3MMZaND2ZiEGDes?=
 =?iso-8859-1?Q?9XE8F+EXBOAknFqv41azvtrzisS0HaDXMewa/hUYyjDuGd/Pqlm5JOVMlQ?=
 =?iso-8859-1?Q?shK+FlWgoaXPtp7GM3QwCT8wbtsVhUhtXe918tciAyKswD4TY66O/dndTa?=
 =?iso-8859-1?Q?i3a1P/u+EzxjXlkYER5aZ6pPF5Z/xGXYbw5vJw5JlTerCpjnqfGNoSQAGC?=
 =?iso-8859-1?Q?Y+MX9mCDXc3fkdsmf4q8JTKvojS38liwusqgkWx47RXp9MeLz+xblz84Tt?=
 =?iso-8859-1?Q?32oGKXVkeZcMxkwC0U2m+RYOnhyeTLfbrLt/d3ZsI/W60fHs83headXjx8?=
 =?iso-8859-1?Q?iIkrj6Wphc8iJRO8bDcltO6nXWXxFQlbhx8ee2vULcia6trZjZ2MLkgRDp?=
 =?iso-8859-1?Q?/ImnPxa6enxPoTRSNBQ8XMw4Xe9ZLQ+fkE8XEHa6AT6/Oyfs0s34jL433v?=
 =?iso-8859-1?Q?3WV4TPXp7iwDLKx9izzCFfO6H1sRl0WqrRj8E1Xr8eNTMYbrMEddlj5ST+?=
 =?iso-8859-1?Q?ps0bd8d81Xxo2lzdeWvZAjyUqZv9jK5mEOrhH3gVUi245sD9NaK2mmqDGN?=
 =?iso-8859-1?Q?YdaaODkJp/IYtypYKrl2q0NBTirM0rAW8VSLb7pDiW/L33bKJEYLa1ytFA?=
 =?iso-8859-1?Q?kqs7Gtf3Ob547ph7+D8N4PnbTSyk/okRO9E9kkzjdG6J/hcdKmEz0BCKnR?=
 =?iso-8859-1?Q?7XpPcHJ+4ipygnX/qKOTzxBTqYn7BvBZEoxTVqT7RUYKX0AHgqcglauKGh?=
 =?iso-8859-1?Q?o2xzJEcIDMxAlJqyGqol2NqAPXt27qlPt2xd7Wx/yBwLRUzE6L3fXjdNOJ?=
 =?iso-8859-1?Q?9FxEvFtwmJ4LYhjArqLYQE2ySCx+NCY9afPk/l2ql8jpqvUvtTBS2qgLJl?=
 =?iso-8859-1?Q?Hp4SXv3DMJJcKLT7dpdT+O6ENOI1JLvcWeAjrtE6AavOiXarLdWzPWkg/Q?=
 =?iso-8859-1?Q?Dph9u2soe18pE5OT4W/DG/XBEkrNB9KWL+zweBoV+006DTX6dhUkDX/SMg?=
 =?iso-8859-1?Q?1VX3qBGs2nFqkcxqfGD1ApEJI6v5nFS9IkUKqDjQzcr5hgjRPsU98dTLj3?=
 =?iso-8859-1?Q?UTp081b5HsYwOBYDEc0j69m9UNKIBMTt5l9CBs/RI039z+pf1v8/Nl2dg7?=
 =?iso-8859-1?Q?7HHoBGBn+/wRQz2Ua5CQHxEqAjfGrsLybZWNM/eXcOHNUd0I0pr82daHNQ?=
 =?iso-8859-1?Q?xL/cktd5t8NLmX424HGb3scQRjfaWTu7Mnx6RzFME/miX2BAH/5JwSlhjW?=
 =?iso-8859-1?Q?TC0k+wN3ouGvTSohj4FL1UAUY7KAqCk/cUluo/xIF6fd8I9cd5QWbEqZ0K?=
 =?iso-8859-1?Q?67YmUD0DZvpJdRCngNzO7tkgBYo1Zm2XEPYsrLrR0EqA5s8niJzTQXFih5?=
 =?iso-8859-1?Q?eU/MRvUHR3DxrZ4fDW+NmJNw2iFY0zDd7o0AXGXyY6lWQeqWdHLrk3/PTC?=
 =?iso-8859-1?Q?nNderRMWDb3UqFO9x06aIC?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?edx0be0mSvIYsoeEjEVOAgTbQ5p+/KVc2RreB/8wdiU2oHOL8zNdHCmcvC?=
 =?iso-8859-1?Q?j0W3R90xpnSf3X83AlzUPWsxy1fFmQB6qjL9gAd+2Kmn4Fgu8JEQ0SsOC1?=
 =?iso-8859-1?Q?wFTVCA9lQuJjdsJCM36RDFAW1eJ/mGc1zFNhWqOe0/bnOB3FZPSqMMR0l4?=
 =?iso-8859-1?Q?VMy6lZtOC8lwhyu92N18PanY54px1ayZ9KNihkNsAqx+O/iqB/aOLNNqAA?=
 =?iso-8859-1?Q?3aEnvtVUVW1Y6hZ8mh3YxAt5TBPgLxnfpga9fKHGK1gUMkPGb3bkN5PnPn?=
 =?iso-8859-1?Q?DP2X5wvnyH6+0hQA9hWDsyxIBgeaP8RtmXV89cDsO2uNSI2SHaJv8YIyWi?=
 =?iso-8859-1?Q?kYdhGbIAO3ycCHYZMWg7SYnoKLUG85Q4fX2C43ORgIF/r6a1lkAwCJCkeF?=
 =?iso-8859-1?Q?RG7J8CUcwPldDdAT0AeaQEQaIFFBQKL7zl+SB8mC6ayEO7MpWAq/pk1F/0?=
 =?iso-8859-1?Q?mTkov8f8iypsZCHN+l9Lr+SnfxnzR/bfmWNS+Ug6qpGXcqhhJzMq8QFOqY?=
 =?iso-8859-1?Q?LnjsgGsOcxHcuQ2qlNSN7qw+pABq6MRNbbbsSaMiOVxYDxHxltBE4hNUf0?=
 =?iso-8859-1?Q?SgqZqItlj8aXCoEtJeUoMbyIRnqPII73c5pfAnFS4ZGQ4UOy5znH0Jj4Lo?=
 =?iso-8859-1?Q?3emkxYjCzQyS2Hapex6BvB22haJLNmwOk8YSi8rfPl0QveqD0kGJSSOBSL?=
 =?iso-8859-1?Q?QfIN7zOqAd7MEtdDV6VaRT1uNObkwCbVAd24NixTUzghvY9PuBbcCeclfv?=
 =?iso-8859-1?Q?qHGi11FzzFKLDdUNJNAZC4FbrVTqIUm5YBSnsSG/BLoTYZ6Nk62x3g7t1s?=
 =?iso-8859-1?Q?fyOW3W8rr2HWYZhRoaGbhc+u1so+ePdCuxStmJEmrN/hDajnGPGQhXbXQ7?=
 =?iso-8859-1?Q?OIWkx22VwaqXjADVNASp8PeF8feolWe57iwjDlIUqla3M+1jacxQWQ6yiy?=
 =?iso-8859-1?Q?PvHwqg4WuHVREZSubYBQvMJYIlWGnAeS3dErl1KgE7B+xN5fGCPcazvJhd?=
 =?iso-8859-1?Q?zIcapKBUND0NlgZf/WWFDqaLlaNyZMpRVu2cMuW86m1uH68Rb9kjfmP3BN?=
 =?iso-8859-1?Q?ZV2Ad3Sm5LwadcmiKmx/mekYB7JzXcr+rNhguSWlYOcfU1+x7LIpQOI94X?=
 =?iso-8859-1?Q?UGhFFTs/3VsjfJF7rft+jwxbaJdF2Dnp0mbOHQJhGqSt0Jn4zct/UEG+jY?=
 =?iso-8859-1?Q?PEblDJ1/5zR+CSOXlSJxVi7PKgbXjXg7zEj19WqcdLBmqhk9v4373yQxV2?=
 =?iso-8859-1?Q?DJJcQWG1CKlgBRzCYevWPVBVP1WpmMbAGy2xl2pFbrRQqk8dqr6V3h4jqR?=
 =?iso-8859-1?Q?iOXksDotWkGzIr4i31ziA/pXMF+9z/r2n0m5YSE8vAwc++JN853ue1l0KH?=
 =?iso-8859-1?Q?dLoLIuQFAb7lW0Y5Ugi7hJuISxV5h1SbC6hvHo2cjUpUEVuWE0rqpvIQEc?=
 =?iso-8859-1?Q?cl8MuPNUw+S8K6CNBuoQ2fDmS5aCD/4+7YmTNoWzN9SPKH/qeFzii+YEqY?=
 =?iso-8859-1?Q?wwEb+OUNjghmNXV7G2PxQ6L72RBYBHDBxO2w1mFyvZbi/3CQtsEjqt5o8X?=
 =?iso-8859-1?Q?c7xGIq7TiwqUvZDSw49SlrneL8eNYF4sBwj9PqHfHbiUNQ+DFYwiCvlch7?=
 =?iso-8859-1?Q?7Z950cLvAQ0cCHtPecz7fHx6HWM1gg3cbJ?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca6ee21a-eb59-4491-c057-08dd607031d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2025 07:41:54.4805 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pYc19RUVoPoFct8t5ykb9OJc5oUxZI+mAALUPUu347JZkeWN9Qdt/YLSita7bscyLW1qu+h9/yes7LABG9yxRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7456
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

Hi,=0A=
=0A=
From: Maayan Kashani <mkashani@nvidia.com>=0A=
Sent: Monday, March 3, 2025 3:29 PM=0A=
To: dev@dpdk.org=0A=
Cc: Maayan Kashani; Dariusz Sosnowski; Raslan Darawsheh; stable@dpdk.org; B=
ing Zhao; Slava Ovsiienko; Ori Kam; Suanming Mou; Matan Azrad=0A=
Subject: [PATCH] net/mlx5: fix flow create failure with GENEVE options matc=
h=0A=
=0A=
For non template API on top of HWS,=0A=
geneve options were missing a parser and therefor it failed.=0A=
In template API it geneve options is configured by the user=0A=
using mlx5 set/apply tlv_options commands.=0A=
=0A=
To support hybrid mode, if no parser exists,=0A=
added inner configuration of geneve parser, else,=0A=
in debug mode, check if the geneve option needed exist in=0A=
current parser configured.=0A=
In release mode, assume the option exist in current configured parser.=0A=
=0A=
Updated needed configuration for geneve options in doc.=0A=
=0A=
Fixes: e38776c36c8a ("net/mlx5: introduce HWS for non-template flow API")=
=0A=
Cc: stable@dpdk.org=0A=
=0A=
Signed-off-by: Maayan Kashani <mkashani@nvidia.com>=0A=
Acked-by: Bing Zhao <bingz@nvidia.com>=0A=
=0A=
=0A=
Patch applied to next-net-mlx,=0A=
=0A=
Kindest regards,=0A=
Raslan Darawsheh=0A=
