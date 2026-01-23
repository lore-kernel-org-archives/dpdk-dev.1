Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6B0D77881
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 16:34:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7163A40269;
	Fri, 23 Jan 2026 17:34:18 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 89DCD4021F
 for <dev@dpdk.org>; Fri, 23 Jan 2026 17:34:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769186057; x=1800722057;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=dGXLHpyvzvutEhfgzUGqzgMxS8I21h+4vdj9R+UTbXs=;
 b=YuVDWtNt1XQ3uB92BxazzGZLXGr5eIKLyE3ai1YnOj0dczraFqKPzGw9
 0kWo9b3+MZ01lalksaEYD0eDtLuSJiSQn/IYnftQq82y4xlQpcQk3Bvst
 AZGiD6WC1NyHmSxrmiBIgZknuGJ0YMK39eSTAKKjyCgBa+ARRqzMw/v1u
 ijgqgX/fbetBMuHFUOuQA42x3poblxgntC0XDqThbouBSAHjzjHQPIOq3
 jaYCKcGkbTaLdctDD3tptGUZpMaHyZ1u5fjQ7TGqs4ZYgmkxbH9EG1Yj1
 gNRpYPjy0S+kzSliBo8FxrCwqfkZG2zbu5GFuAQpf1tT3MzrABCxr3Qna Q==;
X-CSE-ConnectionGUID: WRjeT1TnT3Cf64XBnTMk/A==
X-CSE-MsgGUID: 0S5R87m5SUmh90pkz5iY5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11680"; a="80747126"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; d="scan'208,217";a="80747126"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jan 2026 08:34:16 -0800
X-CSE-ConnectionGUID: 21s2GaadS+2xfr1uwkKGGw==
X-CSE-MsgGUID: FYvTQ/HNTDmSUi8svbDwdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
 d="scan'208,217";a="238315580"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jan 2026 08:34:15 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 23 Jan 2026 08:34:13 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 23 Jan 2026 08:34:13 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.39) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 23 Jan 2026 08:34:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=joolsu1s77sAWgEw8fTeMz/MTjXVfiU3iSHNI/03+HsI05VEBEcVIUyFgy/eU7/yCNFxjDUhsUo6ltnyaTS+evRH/KzgfTXHYZAOfHNb9r+En5F8HuWR7s5W/CTH325qP/NFasyPq/OS0beuw6xuDdE8SylmackMLNxNl+S4VwesDJquzEalodOGfJBKnoBCa9aGudd5YB+h5/Ws5sipdHp2zmwee+5ibykEQHwn0MRSPactrxC+eYccNtQCiGHlf+dO9NR2dpeOd5+BYcamtN1GAkPjDWrxLruwJm3dVvh0dv5chl077CcfBqXTu2PgvR2/vHTgf/KuU4VD3L1oQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CW4A/75egtTPKPV2jci49rZIQi+Dc3BDtiLaIDANp/8=;
 b=pF0cBzZhJZ31u9N3yF8Jzuz7JiosWBMjLgI6HkcE2F5LgaFaImfSB8K7vEILuHMZc+FIY18p4rVk0hOtUX90vPqRV3v3uFSB7YHkSAxl4caKW97nep61KLNqOp/o0NlFdDh3x2pw9arXfkjZeIhwKIlEHx/oE1dR87zKxEa2rYNXZNnme7mV9NgZ7LP/xJysS8mVfGHRnWBCWLucny8R9fVtSLSs4pJf9G6FyRDUxP2TlkG8U1JNW+Qx39MT4BDAOS9IeDQCnFA+cOc2DG8Y58Yfnp3Kgxsx+RIcDOLxQ+k/vC+gv7SYZKDdujesn3reGtcu1hORCIf0Gvwku2RnCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7458.namprd11.prod.outlook.com (2603:10b6:8:145::13)
 by CH3PR11MB7323.namprd11.prod.outlook.com (2603:10b6:610:152::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.12; Fri, 23 Jan
 2026 16:34:10 +0000
Received: from DS0PR11MB7458.namprd11.prod.outlook.com
 ([fe80::6d78:37d8:c835:540]) by DS0PR11MB7458.namprd11.prod.outlook.com
 ([fe80::6d78:37d8:c835:540%4]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 16:34:10 +0000
From: "Ji, Kai" <kai.ji@intel.com>
To: "Finn, Emma" <emma.finn@intel.com>, Akhil Goyal <gakhil@marvell.com>, "Fan
 Zhang" <fanzhang.oss@gmail.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [v2] crypto/openssl: Add support for SHAKE algorithms
Thread-Topic: [v2] crypto/openssl: Add support for SHAKE algorithms
Thread-Index: AQHcgLQv/lA+roeH8EKcBSQrRU1zWrVgCo4D
Date: Fri, 23 Jan 2026 16:34:10 +0000
Message-ID: <DS0PR11MB745818A0CF1BD235D978E79D8194A@DS0PR11MB7458.namprd11.prod.outlook.com>
References: <20260108143837.2412053-1-emma.finn@intel.com>
 <20260108153330.2441799-1-emma.finn@intel.com>
In-Reply-To: <20260108153330.2441799-1-emma.finn@intel.com>
Accept-Language: en-GB, en-US, en-IE
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7458:EE_|CH3PR11MB7323:EE_
x-ms-office365-filtering-correlation-id: 3542e80a-e0da-46b8-f412-08de5a9d3c58
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|42112799006|366016|7053199007|38070700021|8096899003;
x-microsoft-antispam-message-info: =?us-ascii?Q?a1fuN3hW3tw+ZonQwVbjMAOUELZ+ty2bs/1U6Ull7QW1IXXFrnlR3O7xDAeq?=
 =?us-ascii?Q?+/r3K/qSc+wIL5qwsqm1S9bRa7aFkhwVuCmaZA48byJB7xnRFrRKOvFwtYv+?=
 =?us-ascii?Q?O+EJcxJssJ/4IxsaFlIBAN8b6XWoXBKE5KOESgcF4jUWsNxAwh38YbaFcnEB?=
 =?us-ascii?Q?mrzKllicU4P5b8I1nmHV5uoVqNrXo+VpRoVOey8ewCHgj4XdrqJY11TaW0KF?=
 =?us-ascii?Q?O9kax88j8G1lo3ijQ4cWig1SEEZfQkEZ6Cz/FN+qoXrppiycnD2HUXghJikq?=
 =?us-ascii?Q?fi2HR/12Efg19muJsvisZUOqfhTrUivjSV8Vy7B7cIKs/aHsgBd/6dbcZB1J?=
 =?us-ascii?Q?n58+iR76LQN0xuYS7nSkHRcmQJvOMncqAV19f+Ur1KmOUsXSEluw/WsocqmA?=
 =?us-ascii?Q?x7hJ5nKjiyG19qUt5TqncOlmdc65PEj8NFd+SWObF9BbrmEkPVG/QMlfJQjw?=
 =?us-ascii?Q?OGxtXkMxd2J/VZn3uTdj3htWL0hQ5+jZZjIzH3wtVPC3dwXeFsuSLhk6n1Dc?=
 =?us-ascii?Q?zD7LshpEOYPGl4IHQmpWDfwEfTy/PvsoRhqHOQYykSLdSUlkwWtPCmb9BqyN?=
 =?us-ascii?Q?9cqkeMyNnuV1c43Sv4kScvibtNpM+bCacssWtOLJv02HwtxIIySolnzcJtPe?=
 =?us-ascii?Q?ROubWlnw3tjVZgL70lgog9U0sTFfsTL2Q52NhbwHc0lko3kMRfxFqjlj1e41?=
 =?us-ascii?Q?P5GfxJad8aINJyEAhQXVAy1NL7wW92c9zPwBq5IFV8ZOY1pd1lw9VK7DzxuC?=
 =?us-ascii?Q?oy8ka2VEXcuUKgs4RAbS80WqrTUa0xI1/xMb0WuvgPYXFGxZl9ZCqIZcObfs?=
 =?us-ascii?Q?zr0ue7tu7Z1HlTOfBwbni+pIAbP1DoB7PpfJM/lRKHY5+GrCdbrzClxc+fuQ?=
 =?us-ascii?Q?TQk2RUpFE/Zh++8yPn4mDy5H1Owbue/j4AfsdhUfwNpZtBnkuugKLZEkHran?=
 =?us-ascii?Q?CehVj3+SGR2+oF9CNXHrz8aSfF9NsitWiFSR78lJIJId1VlXMz/tBx9PNvyt?=
 =?us-ascii?Q?d+eNAYYE9WcZ1D1ADvnTtbzL203syjUgx+JeNAiePusU7IRdzjMkhxjlr3CF?=
 =?us-ascii?Q?4LTuWPUwFxbVw3XfmEz1Sq2NGp12fsrOBAnutet/J5yrTptbignldzmEKn0f?=
 =?us-ascii?Q?SdIq74S7X7QFW8o0PUSAZic9LvCHjMRRBx3r4NXLLRWwZ+YUK3p7AM6aK5B1?=
 =?us-ascii?Q?jd1VihAcgEB0xqtgBSOYBlbUr99GnvEofKCAq80GrlgNeOd0Z14pKH/qlZBd?=
 =?us-ascii?Q?M4H3Jaj2G+vHMUeAZqsasGDzlK09xHwDy8oieeNrI7Na4Gjs7JlKA5pL9y1x?=
 =?us-ascii?Q?uRY/Z9TqFktHVUJTa9V9a2IyRlzG71nshI6Xa96vIEraFgwETI5n0h70a5WO?=
 =?us-ascii?Q?jdTBYyEw0823tVsBcojREU4hwZqBM1E1QqlLKJdY+z9FKQcZwbIlUQvkjTcm?=
 =?us-ascii?Q?3sx6mIVKP/V0sELgdMMSSGk0beyi9OsxOLAiV93bTJwNywpqHwexEEmTHfeV?=
 =?us-ascii?Q?jvrNUU45naJ+Yrdac+IlSy5dyY7bQzdMK6IZVu3Hp0lnQImLcb3GO2xeEwDi?=
 =?us-ascii?Q?uf5fuIIxloAqIvmDH+JPhACHStNOFKE9indJfFPQb/UEm9/ErSBOVZhEPaf+?=
 =?us-ascii?Q?KFR27eExkSSlTdiKrq1vJcw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7458.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(42112799006)(366016)(7053199007)(38070700021)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MI/g8a1CrWEn2vljYrsNC+fB3NtoZ0sIjqx+hgL4gJ+RuhA6usVQv3fovxIc?=
 =?us-ascii?Q?9a0IXcSymqSWWJ5PjmhSYJm+xQ/39694aoEKR5d8PACFv4BWs0Vj5CmpXik8?=
 =?us-ascii?Q?qYtQ1Gr408U/3tjzvgoBcVin5aX11bLffJqkrWFiPPGhVBktW6rXarRE2/0g?=
 =?us-ascii?Q?ECtZZzXtHGeIdpn8Qnk6cNUOi79hnNXelhWBN8uR8oVdAR8874zsJ61bLu4F?=
 =?us-ascii?Q?pQo6jljDEbPPPhUUYjiCKR3k5+KpvmNGyhbjWJoXO8S6v+TYDTvL4KXyLCTH?=
 =?us-ascii?Q?C7+nCrh+2EXLLv5Ic2WG3w8D/PdK7Xwo5Q/mrOmf/K8dm+GTXKdPwKm9kP6Y?=
 =?us-ascii?Q?6RbK1ZvKb58NTUAKfdq0pprbsN+J6Uvp315XRx1MaNw2roH1WlWysJlquoem?=
 =?us-ascii?Q?IkVSXPe4XEmBjM9dHTcAPCXjFbcJeH8ZIwwhxYTzlke04Uo2HhiH7QoMKCW3?=
 =?us-ascii?Q?oaYjdHB46RBh7RMEn7ffVAYVtRtknXWsR8U+b/8K/9rhxBhC05baXvbi3ZZ6?=
 =?us-ascii?Q?+NBMToUDCwzvNohARikJKH57iQ5p9EgCMjAyZ2bCsAjVEa7uM5WwcaUX3/hx?=
 =?us-ascii?Q?Uznnvx7A4C1ToKzcXwzg1oqlcmDpNwrY2SWBrb66ZF7hKPT0QkAurzmRnOJr?=
 =?us-ascii?Q?CfgPW3sHF6rGFKyQirGDyC6Tv8dkEQZS/P5dn+9SjjrTkcY6GHxcJyH6wRT3?=
 =?us-ascii?Q?kV1lgQDeW3L4PO5eu94bPqNAbZDhVHNp1BVQku30+7q12N9ro83PboNWBM03?=
 =?us-ascii?Q?F6tYVHByXLJmQJaH5pBft27bL6Pk55JaHAPRAQHOCFyGMOjdW2hEKM4UW/Vd?=
 =?us-ascii?Q?wMx2BFDRRFSy6vEzyTuKBfdV8/uUxSc0zKWa5KMYK9xrh1wbnARi7kVEYWH0?=
 =?us-ascii?Q?EfVEqhAJ0myaA8S472liYgkptN56fXGPRUw1zDtPk7Djai3tGas3bMkrBkEf?=
 =?us-ascii?Q?zU8m2WTtWaGaUp/8bR8P+r4NBdNfuGekAIzNxOuo/IJUh1vn1J5O5oRw2qgI?=
 =?us-ascii?Q?Q9YIQt+GrbODFHRTsIBSXzzXlXNQ+mYyCj5n9X4llT2+eD4BsS2EhcDGGSfP?=
 =?us-ascii?Q?LnvB65ZgqVBKHNjozqx9lFS8IOFhWiB8V3aw6OqhoGKyVQ6USlNvAZdsfPfK?=
 =?us-ascii?Q?whDoMhqS4BITR6n13v4Z1WXfZgRIqyZ+Gx1Kq73d4fReZ8W8LX+btm8dfben?=
 =?us-ascii?Q?hwOtY7zc8OiWVU9XA/HoyiHXLhdTUlAIj6TWDWQm+X6wqt9DjLFPVuTeYblO?=
 =?us-ascii?Q?nqSS2dqA9l0+PSFAq1V1UGxapob9cIE5nrGYYkzTwjnMRBlWdi6rdbtH1DT9?=
 =?us-ascii?Q?ca2zETUJ6mMyuuXqIVX1Drs4b4x822jKt0+QRLGx5NE147PswNoWEfaa4iHh?=
 =?us-ascii?Q?HyJfdpp3fIgRFG80nAO9yBFrZzN6CJ6uUwcp5w5/GDnpvjMEyQdQDukLf+fK?=
 =?us-ascii?Q?BWPpgT+gk5oOYhvepNuppl4OcwSNg2pZwSOb6CPHSBjRWQjY0E0Hcbm7QGb6?=
 =?us-ascii?Q?knuZ6QC1D4Cvt9l1Ta8B8+gDpn1z4pKHcW9+xxyjt8BEbPS9CpVUdmdxeLYU?=
 =?us-ascii?Q?SGy1r63cIJuGqiYwvTFHiddk33eWteOsuIyYqhjlx+augQD9txgu6zCYsE7/?=
 =?us-ascii?Q?mPdaiySJXr6sX8wi5FnIH4M9dWAnNEMoJdS+nApA4u6ApjfQJTizuaHnAAQI?=
 =?us-ascii?Q?rHQt7FrgqGejeSaCHjrRkepAgL+6qWNExIPiLI223MwcwsHP?=
Content-Type: multipart/alternative;
 boundary="_000_DS0PR11MB745818A0CF1BD235D978E79D8194ADS0PR11MB7458namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7458.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3542e80a-e0da-46b8-f412-08de5a9d3c58
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2026 16:34:10.1581 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HX7bwn15d67uAvgZULf5HjQXuFaHSTLHajbR7LQtsU521zd6lKu5gEGym1FmXgx2LiM4IZHjLtb00QV9vSdNzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7323
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

--_000_DS0PR11MB745818A0CF1BD235D978E79D8194ADS0PR11MB7458namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Release note and PMD documentation need update to support SHAKE algo
________________________________
From: Finn, Emma <emma.finn@intel.com>
Sent: 08 January 2026 15:33
To: Akhil Goyal <gakhil@marvell.com>; Fan Zhang <fanzhang.oss@gmail.com>; J=
i, Kai <kai.ji@intel.com>
Cc: dev@dpdk.org <dev@dpdk.org>; Finn, Emma <emma.finn@intel.com>
Subject: [v2] crypto/openssl: Add support for SHAKE algorithms

OpenSSL 3.X has support for SHAKE, Hence adding
SHAKE-128 and SHAKE-256 support to the OpenSSL PMD.

Signed-off-by: Emma Finn <emma.finn@intel.com>
---
v2:
* Fixed unused digest_length variable
---
 app/test/test_cryptodev_blockcipher.c        |  4 +-
 drivers/crypto/openssl/rte_openssl_pmd.c     | 30 ++++++++++++--
 drivers/crypto/openssl/rte_openssl_pmd_ops.c | 42 ++++++++++++++++++++
 3 files changed, 72 insertions(+), 4 deletions(-)

diff --git a/app/test/test_cryptodev_blockcipher.c b/app/test/test_cryptode=
v_blockcipher.c
index 6b37347789..1438f24993 100644
--- a/app/test/test_cryptodev_blockcipher.c
+++ b/app/test/test_cryptodev_blockcipher.c
@@ -1174,7 +1174,9 @@ authonly_setup(void)
                 RTE_CRYPTO_AUTH_SHA512_HMAC,
                 RTE_CRYPTO_AUTH_AES_CMAC,
                 RTE_CRYPTO_AUTH_NULL,
-               RTE_CRYPTO_AUTH_AES_XCBC_MAC
+               RTE_CRYPTO_AUTH_AES_XCBC_MAC,
+               RTE_CRYPTO_AUTH_SHAKE_128,
+               RTE_CRYPTO_AUTH_SHAKE_256
         };

         rte_cryptodev_info_get(dev_id, &dev_info);
diff --git a/drivers/crypto/openssl/rte_openssl_pmd.c b/drivers/crypto/open=
ssl/rte_openssl_pmd.c
index 4f171f48cc..755674f71a 100644
--- a/drivers/crypto/openssl/rte_openssl_pmd.c
+++ b/drivers/crypto/openssl/rte_openssl_pmd.c
@@ -270,6 +270,12 @@ get_auth_algo(enum rte_crypto_auth_algorithm sessalgo,
                 case RTE_CRYPTO_AUTH_SHA512_HMAC:
                         *algo =3D EVP_sha512();
                         break;
+               case RTE_CRYPTO_AUTH_SHAKE_128:
+                       *algo =3D EVP_shake128();
+                       break;
+               case RTE_CRYPTO_AUTH_SHAKE_256:
+                       *algo =3D EVP_shake256();
+                       break;
                 default:
                         res =3D -EINVAL;
                         break;
@@ -659,6 +665,8 @@ openssl_set_session_auth_parameters(struct openssl_sess=
ion *sess,
         case RTE_CRYPTO_AUTH_SHA256:
         case RTE_CRYPTO_AUTH_SHA384:
         case RTE_CRYPTO_AUTH_SHA512:
+       case RTE_CRYPTO_AUTH_SHAKE_128:
+       case RTE_CRYPTO_AUTH_SHAKE_256:
                 sess->auth.mode =3D OPENSSL_AUTH_AS_AUTH;
                 if (get_auth_algo(xform->auth.algo,
                                 &sess->auth.auth.evp_algo) !=3D 0)
@@ -1397,7 +1405,7 @@ process_openssl_auth_decryption_ccm(struct rte_mbuf *=
mbuf_src, int offset,
 static int
 process_openssl_auth(struct rte_mbuf *mbuf_src, uint8_t *dst, int offset,
                 __rte_unused uint8_t *iv, __rte_unused EVP_PKEY * pkey,
-               int srclen, EVP_MD_CTX *ctx, const EVP_MD *algo)
+               int srclen, EVP_MD_CTX *ctx, const EVP_MD *algo, int digest=
_length)
 {
         size_t dstlen;
         struct rte_mbuf *m;
@@ -1437,8 +1445,24 @@ process_openssl_auth(struct rte_mbuf *mbuf_src, uint=
8_t *dst, int offset,
         }

 process_auth_final:
-       if (EVP_DigestFinal_ex(ctx, dst, (unsigned int *)&dstlen) <=3D 0)
+       /* SHAKE algorithms are XOFs and require EVP_DigestFinalXOF */
+       if (algo =3D=3D EVP_shake128() || algo =3D=3D EVP_shake256()) {
+#if (OPENSSL_VERSION_NUMBER >=3D 0x30000000L)
+               /* Set XOF output length before calling EVP_DigestFinalXOF =
*/
+               if (EVP_MD_CTX_ctrl(ctx, EVP_MD_CTRL_XOF_LEN, digest_length=
, NULL) <=3D 0)
+                       goto process_auth_err;
+               if (EVP_DigestFinalXOF(ctx, dst, digest_length) <=3D 0)
+                       goto process_auth_err;
+#else
+               RTE_SET_USED(digest_length);
+               OPENSSL_LOG(ERR, "SHAKE algorithms require OpenSSL 3.0+");
                 goto process_auth_err;
+#endif
+       } else {
+               if (EVP_DigestFinal_ex(ctx, dst, (unsigned int *)&dstlen) <=
=3D 0)
+                       goto process_auth_err;
+       }
+
         return 0;

 process_auth_err:
@@ -1995,7 +2019,7 @@ process_openssl_auth_op(struct openssl_qp *qp, struct=
 rte_crypto_op *op,
                 ctx_a =3D get_local_auth_ctx(sess, qp);
                 status =3D process_openssl_auth(mbuf_src, dst,
                                 op->sym->auth.data.offset, NULL, NULL, src=
len,
-                               ctx_a, sess->auth.auth.evp_algo);
+                               ctx_a, sess->auth.auth.evp_algo, sess->auth=
.digest_length);
                 break;
         case OPENSSL_AUTH_AS_HMAC:
                 ctx_h =3D get_local_hmac_ctx(sess, qp);
diff --git a/drivers/crypto/openssl/rte_openssl_pmd_ops.c b/drivers/crypto/=
openssl/rte_openssl_pmd_ops.c
index 5095e6cbea..f6c32fdcb6 100644
--- a/drivers/crypto/openssl/rte_openssl_pmd_ops.c
+++ b/drivers/crypto/openssl/rte_openssl_pmd_ops.c
@@ -269,6 +269,48 @@ static const struct rte_cryptodev_capabilities openssl=
_pmd_capabilities[] =3D {
                         }, }
                 }, }
         },
+       {   /* SHAKE_128 */
+               .op =3D RTE_CRYPTO_OP_TYPE_SYMMETRIC,
+               {.sym =3D {
+                       .xform_type =3D RTE_CRYPTO_SYM_XFORM_AUTH,
+                       {.auth =3D {
+                               .algo =3D RTE_CRYPTO_AUTH_SHAKE_128,
+                               .block_size =3D 168,
+                               .key_size =3D {
+                                       .min =3D 0,
+                                       .max =3D 0,
+                                       .increment =3D 0
+                               },
+                               .digest_size =3D {
+                                       .min =3D 1,
+                                       .max =3D 256,
+                                       .increment =3D 1
+                               },
+                               .iv_size =3D { 0 }
+                       }, }
+               }, }
+       },
+       {   /* SHAKE_256 */
+               .op =3D RTE_CRYPTO_OP_TYPE_SYMMETRIC,
+               {.sym =3D {
+                       .xform_type =3D RTE_CRYPTO_SYM_XFORM_AUTH,
+                       {.auth =3D {
+                               .algo =3D RTE_CRYPTO_AUTH_SHAKE_256,
+                               .block_size =3D 136,
+                               .key_size =3D {
+                                       .min =3D 0,
+                                       .max =3D 0,
+                                       .increment =3D 0
+                               },
+                               .digest_size =3D {
+                                       .min =3D 1,
+                                       .max =3D 256,
+                                       .increment =3D 1
+                               },
+                               .iv_size =3D { 0 }
+                       }, }
+               }, }
+       },
         {       /* AES CBC */
                 .op =3D RTE_CRYPTO_OP_TYPE_SYMMETRIC,
                 {.sym =3D {
--
2.43.0


--_000_DS0PR11MB745818A0CF1BD235D978E79D8194ADS0PR11MB7458namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: &quot;IntelOne Text&quot;; font-size: 10pt; colo=
r: rgb(0, 0, 0);" class=3D"elementToProof">
Release note and PMD documentation need update to support SHAKE algo&nbsp;<=
/div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Finn, Emma &lt;emma.f=
inn@intel.com&gt;<br>
<b>Sent:</b> 08 January 2026 15:33<br>
<b>To:</b> Akhil Goyal &lt;gakhil@marvell.com&gt;; Fan Zhang &lt;fanzhang.o=
ss@gmail.com&gt;; Ji, Kai &lt;kai.ji@intel.com&gt;<br>
<b>Cc:</b> dev@dpdk.org &lt;dev@dpdk.org&gt;; Finn, Emma &lt;emma.finn@inte=
l.com&gt;<br>
<b>Subject:</b> [v2] crypto/openssl: Add support for SHAKE algorithms</font=
>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">OpenSSL 3.X has support for SHAKE, Hence adding<br=
>
SHAKE-128 and SHAKE-256 support to the OpenSSL PMD.<br>
<br>
Signed-off-by: Emma Finn &lt;emma.finn@intel.com&gt;<br>
---<br>
v2:<br>
* Fixed unused digest_length variable<br>
---<br>
&nbsp;app/test/test_cryptodev_blockcipher.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; |&nbsp; 4 +-<br>
&nbsp;drivers/crypto/openssl/rte_openssl_pmd.c&nbsp;&nbsp;&nbsp;&nbsp; | 30=
 ++++++++++++--<br>
&nbsp;drivers/crypto/openssl/rte_openssl_pmd_ops.c | 42 +++++++++++++++++++=
+<br>
&nbsp;3 files changed, 72 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/app/test/test_cryptodev_blockcipher.c b/app/test/test_cryptode=
v_blockcipher.c<br>
index 6b37347789..1438f24993 100644<br>
--- a/app/test/test_cryptodev_blockcipher.c<br>
+++ b/app/test/test_cryptodev_blockcipher.c<br>
@@ -1174,7 +1174,9 @@ authonly_setup(void)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; RTE_CRYPTO_AUTH_SHA512_HMAC,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; RTE_CRYPTO_AUTH_AES_CMAC,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; RTE_CRYPTO_AUTH_NULL,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; RTE_CRYPTO_AUTH_AES_XCBC_MAC<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; RTE_CRYPTO_AUTH_AES_XCBC_MAC,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; RTE_CRYPTO_AUTH_SHAKE_128,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; RTE_CRYPTO_AUTH_SHAKE_256<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rte_cryptodev_info_get(dev=
_id, &amp;dev_info);<br>
diff --git a/drivers/crypto/openssl/rte_openssl_pmd.c b/drivers/crypto/open=
ssl/rte_openssl_pmd.c<br>
index 4f171f48cc..755674f71a 100644<br>
--- a/drivers/crypto/openssl/rte_openssl_pmd.c<br>
+++ b/drivers/crypto/openssl/rte_openssl_pmd.c<br>
@@ -270,6 +270,12 @@ get_auth_algo(enum rte_crypto_auth_algorithm sessalgo,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case RTE_CRYPTO_AUTH_SHA512_HMAC:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *algo=
 =3D EVP_sha512();<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case RTE_CRYPTO_AUTH_SHAKE_128:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *algo =3D EVP_sh=
ake128();<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case RTE_CRYPTO_AUTH_SHAKE_256:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *algo =3D EVP_sh=
ake256();<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; res =
=3D -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
@@ -659,6 +665,8 @@ openssl_set_session_auth_parameters(struct openssl_sess=
ion *sess,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case RTE_CRYPTO_AUTH_SHA25=
6:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case RTE_CRYPTO_AUTH_SHA38=
4:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case RTE_CRYPTO_AUTH_SHA51=
2:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case RTE_CRYPTO_AUTH_SHAKE_128:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case RTE_CRYPTO_AUTH_SHAKE_256:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; sess-&gt;auth.mode =3D OPENSSL_AUTH_AS_AUTH;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (get_auth_algo(xform-&gt;auth.algo,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;sess-&gt;auth.auth.evp_algo=
) !=3D 0)<br>
@@ -1397,7 +1405,7 @@ process_openssl_auth_decryption_ccm(struct rte_mbuf *=
mbuf_src, int offset,<br>
&nbsp;static int<br>
&nbsp;process_openssl_auth(struct rte_mbuf *mbuf_src, uint8_t *dst, int off=
set,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; __rte_unused uint8_t *iv, __rte_unused EVP_PKEY * pke=
y,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; int srclen, EVP_MD_CTX *ctx, const EVP_MD *algo)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; int srclen, EVP_MD_CTX *ctx, const EVP_MD *algo, int digest_leng=
th)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_t dstlen;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rte_mbuf *m;<br>
@@ -1437,8 +1445,24 @@ process_openssl_auth(struct rte_mbuf *mbuf_src, uint=
8_t *dst, int offset,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;process_auth_final:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (EVP_DigestFinal_ex(ctx, dst, (uns=
igned int *)&amp;dstlen) &lt;=3D 0)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* SHAKE algorithms are XOFs and requ=
ire EVP_DigestFinalXOF */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (algo =3D=3D EVP_shake128() || alg=
o =3D=3D EVP_shake256()) {<br>
+#if (OPENSSL_VERSION_NUMBER &gt;=3D 0x30000000L)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* Set XOF output length before calling EVP_DigestFinalXOF */<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (EVP_MD_CTX_ctrl(ctx, EVP_MD_CTRL_XOF_LEN, digest_length, NUL=
L) &lt;=3D 0)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto process_aut=
h_err;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (EVP_DigestFinalXOF(ctx, dst, digest_length) &lt;=3D 0)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto process_aut=
h_err;<br>
+#else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; RTE_SET_USED(digest_length);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; OPENSSL_LOG(ERR, &quot;SHAKE algorithms require OpenSSL 3.0+&quo=
t;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto process_auth_err;<br>
+#endif<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (EVP_DigestFinal_ex(ctx, dst, (unsigned int *)&amp;dstlen) &l=
t;=3D 0)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto process_aut=
h_err;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
&nbsp;process_auth_err:<br>
@@ -1995,7 +2019,7 @@ process_openssl_auth_op(struct openssl_qp *qp, struct=
 rte_crypto_op *op,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ctx_a =3D get_local_auth_ctx(sess, qp);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; status =3D process_openssl_auth(mbuf_src, dst,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; op-&gt;sym-&gt;auth.data.offset,=
 NULL, NULL, srclen,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx_a, sess-&gt;auth.auth.evp_algo);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx_a, sess-&gt;auth.auth.evp_algo, sess-&g=
t;auth.digest_length);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case OPENSSL_AUTH_AS_HMAC:=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ctx_h =3D get_local_hmac_ctx(sess, qp);<br>
diff --git a/drivers/crypto/openssl/rte_openssl_pmd_ops.c b/drivers/crypto/=
openssl/rte_openssl_pmd_ops.c<br>
index 5095e6cbea..f6c32fdcb6 100644<br>
--- a/drivers/crypto/openssl/rte_openssl_pmd_ops.c<br>
+++ b/drivers/crypto/openssl/rte_openssl_pmd_ops.c<br>
@@ -269,6 +269,48 @@ static const struct rte_cryptodev_capabilities openssl=
_pmd_capabilities[] =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }, }<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }, }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {&nbsp;&nbsp; /* SHAKE_128 */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .op =3D RTE_CRYPTO_OP_TYPE_SYMMETRIC,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; {.sym =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .xform_type =3D =
RTE_CRYPTO_SYM_XFORM_AUTH,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {.auth =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .algo =3D RTE_CRYPTO_AUTH_SHAKE_128,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .block_size =3D 168,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .key_size =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .min =3D 0,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .max =3D 0,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .increment =3D 0<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .digest_size =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .min =3D 1,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .max =3D 256,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .increment =3D 1<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .iv_size =3D { 0 }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }, }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }, }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {&nbsp;&nbsp; /* SHAKE_256 */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; .op =3D RTE_CRYPTO_OP_TYPE_SYMMETRIC,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; {.sym =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .xform_type =3D =
RTE_CRYPTO_SYM_XFORM_AUTH,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {.auth =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .algo =3D RTE_CRYPTO_AUTH_SHAKE_256,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .block_size =3D 136,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .key_size =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .min =3D 0,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .max =3D 0,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .increment =3D 0<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .digest_size =3D {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .min =3D 1,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .max =3D 256,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; .increment =3D 1<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .iv_size =3D { 0 }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }, }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }, }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; /* AES CBC */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .op =3D RTE_CRYPTO_OP_TYPE_SYMMETRIC,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; {.sym =3D {<br>
-- <br>
2.43.0<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_DS0PR11MB745818A0CF1BD235D978E79D8194ADS0PR11MB7458namp_--
