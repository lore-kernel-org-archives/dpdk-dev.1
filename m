Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB44C83F03
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Jul 2025 10:35:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6CF8A4028B;
	Fri,  4 Jul 2025 12:35:18 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 5CB3F40267;
 Fri,  4 Jul 2025 12:35:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751625316; x=1783161316;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=v4zatHYWviw3YTESwZe5VcJoqoqiA1lWyW8deoZp9DU=;
 b=KoVnQdrI35FF3E0QDehrq09QZQxvlg2YGr2jvxkxMjTqTl+qmk87QsxL
 C8t9i4JZw0oqqRwzJMbDJ0OjvV0S71iDYbsRktpOa/QUT/N5AcJCai9wc
 Uj4L9MEVlxDVpbnPlT1MGmSrU/v1fxHk9OCtLZt98s7iATpXCYyqaEMZw
 FGXes88XgWnJuU8WFYLoMx/0VB9MDrC4fiSGmEcWjttnPdZ79lSNi3J/L
 1HDYeICRdqdDeAD4zsjiCpxdxECQ+DgtNJ3sdIlZNuAG+7BLdg9zf9DCz
 XyQOfGQDorR+CXHqsMfopDa1oHMUT0KU9L8VkuhMoed8/wLD3KbiCHgPt g==;
X-CSE-ConnectionGUID: 4ddlqx1ITmqJvX4ezXfyBQ==
X-CSE-MsgGUID: 9qMiFqZzS8ugfT8Rqpj8mA==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="64560869"
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; d="scan'208,217";a="64560869"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2025 03:35:15 -0700
X-CSE-ConnectionGUID: zGh5P46PRZys4lxNu8451g==
X-CSE-MsgGUID: xwwgADycRa+cu9RHBpo9Yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; 
 d="scan'208,217";a="160286641"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2025 03:35:15 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 4 Jul 2025 03:35:14 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 4 Jul 2025 03:35:14 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.82) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 4 Jul 2025 03:35:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gAFTvV2aqQ8qkGbHSkcqJ2flp4sGgXtwd34PuPlZW1mdNx1fE+l4GNDn6xIE8Mp1eUFAqCi9eeI+umHRzSYVDaoc62d7bgUXZwtJgMlEQTwIm2X7YZ0+r8iPW9Mi7YXa2oG2h6PNkexQ3bcHM0/4HotF6KwPwB1PtfpJVm4s/ifGpaXdSW/S10e7NoQz52UPLpQDlSWZaEqg6zfAF+Mq1nAtaTdcNKeb9PFMrH1WvJNFhxJ/PpJif7dY5pvfuARoptfwnJR4zZsQr8m2KuQswJsUB03CgbmnC/7ABz6Jr38ToOaWXu0EuvkPoCDD2qwODovSeTDzeDS0QqEF2Oft7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vcfMrlGNXefL8/1VKflnnaerdrUfILz28Aswis0w6ww=;
 b=i1WLfE/2MAZ8Nv8xkx2aLGeSmeE16qZr2q8Zp5olGKwc++dBgeS8hbjuibksbr29sZUV7sjjCLPGSgSlcq0JR7UyBr95M1RFkZoib0wGGdonjnXi4n1MMCPlttOcapf2B7lMFMhHIosdZcn+0vv8bPlEgfG/WsCWZKE0mtBfR0rnWxH0Ig+41rzpgVHHzpJiNfJFAz/zfmpup+UXd4hnoBohzXTVQxd8z/mHuhTP3GpiFVVXJlzv5sfOib8ufrbqC1LtmBqMh9asW1z8v53O+pOwJG3pblWxrjSjLvn+i/jpFa44zxQrjeBleoD4gijoBHbiwS7cRCqMQCA0vb7B6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7458.namprd11.prod.outlook.com (2603:10b6:8:145::13)
 by DS0PR11MB8052.namprd11.prod.outlook.com (2603:10b6:8:122::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Fri, 4 Jul
 2025 10:35:13 +0000
Received: from DS0PR11MB7458.namprd11.prod.outlook.com
 ([fe80::6d78:37d8:c835:540]) by DS0PR11MB7458.namprd11.prod.outlook.com
 ([fe80::6d78:37d8:c835:540%5]) with mapi id 15.20.8901.021; Fri, 4 Jul 2025
 10:35:12 +0000
From: "Ji, Kai" <kai.ji@intel.com>
To: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>,
	"dev@dpdk.org" <dev@dpdk.org>,
	Ashish Gupta <"ashishg@marvell.comashish.gupta"@marvell.com>,
	Shally Verma <shallyv@marvell.com>, Sunila Sahu <ssahu@marvell.com>
CC: "anoobj@marvell.com" <anoobj@marvell.com>, Akhil Goyal
 <gakhil@marvell.com>, "stable@dpdk.org" <stable@dpdk.org>
Subject: Re: [PATCH 1/3] crypto/openssl: include private exponent in RSA
 session
Thread-Topic: [PATCH 1/3] crypto/openssl: include private exponent in RSA
 session
Thread-Index: AQHb4bwV8qsazOKdEUqEuFwNFNDu37Qh2xG6
Date: Fri, 4 Jul 2025 10:35:12 +0000
Message-ID: <DS0PR11MB74580F9115068E1EDF01ED638142A@DS0PR11MB7458.namprd11.prod.outlook.com>
References: <20250620081921.2145-1-gmuthukrishn@marvell.com>
In-Reply-To: <20250620081921.2145-1-gmuthukrishn@marvell.com>
Accept-Language: en-GB, en-US, en-IE
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7458:EE_|DS0PR11MB8052:EE_
x-ms-office365-filtering-correlation-id: 9df26823-a8ab-4ce4-0c66-08ddbae67540
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|42112799006|376014|366016|38070700018|7053199007|8096899003;
x-microsoft-antispam-message-info: =?us-ascii?Q?d1YFto0Vm1gJl/wHUivJ3zZYiJvLIRd2cz9cNk9kLGin7U6eGR42+UlP2IXw?=
 =?us-ascii?Q?vgltq3b1I7qxl9gSwi9xirpAnCG4rtImm9bqkiPDoiRj7nVGebnCu6pwBZNv?=
 =?us-ascii?Q?QQ9bQuDhha/EA8p4fgglaP/b/upORCf2Ci2kQ5232lR2XP9wOv9zOI7hu+Iy?=
 =?us-ascii?Q?AriimHe5jTTkMKzuz7B3GkV575oKuriozKnMrrnCOa8qXZpjxc9YJMj0kbEw?=
 =?us-ascii?Q?uIYUX7ZzKVWnusBioCc964Qjx6HpJdVYzVx5xmzr+30piWhpT3uwa/XEYIu4?=
 =?us-ascii?Q?Wcw6ckUVQfJrAvhxodOSb/Ew4wVbkIJvVwGXuCbHwjX4Oh3uPh8GCoxrt6rf?=
 =?us-ascii?Q?28BOjevzxbsgOlMJjZa6AYsddd2UxMNLLGHmWabkxPNSJNwraJ8bvXgEDpY6?=
 =?us-ascii?Q?g/PIfl7iJGzv4xffVPCf0KnGlzggbIdb6oyTDDz4yq5qGMOgH9we000fKDM+?=
 =?us-ascii?Q?35sfDcc4WKDk3H304u8r0B2FSo1/58VGsweUXjJFO5SdDoiQa1gVyoOSNO02?=
 =?us-ascii?Q?c3aT7ZlGX9IdgpaLVynMejWVmUcWxE6Kzsu7/rw18MkW7WXw+wsI3YcIF8UO?=
 =?us-ascii?Q?+PUEr4ko+h+p8n2KVKndzeH5LPBezw7rkBVOoEQ+ZJ7OlqB8nQ76yxEsnkUw?=
 =?us-ascii?Q?W4B5Kf4mlosz6e+DK2uHDcFCPX3VjTobJr6igkWaqgvPlsQ4/2Tylkt9KYan?=
 =?us-ascii?Q?eRQ1NrNZGoV7HIMc25mvziz1kpfLO3bUe/Ih5c/Chpcvz1H8lGGP3otfhsYp?=
 =?us-ascii?Q?HqBjBRoE0l3P1ZKDK81dpcGtZrwc2LVI2aOxKkwpaZHiW+oK9zNDuW9A+Y7y?=
 =?us-ascii?Q?aOiBwcLzdzNFebosMC/qBkpdI9mGVi+b5wKY5iK1cDN1mw0T/ivbdiw1Wg9Y?=
 =?us-ascii?Q?1nkXUmKSxT+VNX12lkqbjDQ2Ybeo3WX2NNX8vMVytab+c3dApnIDvu4fM712?=
 =?us-ascii?Q?85qmw4w/wCzyOd4ITi0f5TQYoTNxQzwL4DBdw2LmQGiziHbtijGgoauz/j1L?=
 =?us-ascii?Q?IrMUirUXSO5ByXGOSBQO5ZrZIQ3N5BNBcItsrAoRqluvz6fZM5xZ/ni6PWw7?=
 =?us-ascii?Q?jk7xcPpRcqOLD3ljHveXZHLFtX+HGbcpFoqymv5FDcENnwqV/KgurDlHaqLU?=
 =?us-ascii?Q?dr7urunvFX6MIc9nrYL9i2rDU1FMa4ekN6tGhzRTZOnQSYvjHULxk89450hj?=
 =?us-ascii?Q?SSRQTaSlwxsVGVC8fULSQr5YpUfNAJoo2IJsJoUmOS0J5/c1B23xCgrbQTD+?=
 =?us-ascii?Q?uoC/sIJwW36cy1ZXjU83Y3/gTul2sXwpf7t4B+ER8Tbkz5vjf0QlQmuI8j63?=
 =?us-ascii?Q?PHdOS+bQib0az9jc7ePEf38zVk+wJ20Y3i9RwDU7bRPRfIHuceS54Nr7HLHb?=
 =?us-ascii?Q?7atZFKOCatP7IEhA4pwZ5IHcehBgBpY+Iw1IlIyxmnCcfzihE1Faki+2SlPg?=
 =?us-ascii?Q?4eb2ha5PPQHQKbnbpaWBjoZcJdJWJtp+e5Rmf5Ssdg8vgEy1gV8mEw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7458.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(42112799006)(376014)(366016)(38070700018)(7053199007)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TcOSeyYq0dMwVT0K0W9k9SpePvYVxanYJfPHPbEJYHN6b+R8lvOEdS+7dHiP?=
 =?us-ascii?Q?Yu/8I+sRwXRAfZ2f2pGJvOtO3eLcJbWebhPgbNFfpPaBDbeVxDDbjUbjBnJx?=
 =?us-ascii?Q?A6WNo4PMC40rj+hw4eFxymV08TgZUQVj8b3SVTkp9jCPwFiDNJrcnFItciNO?=
 =?us-ascii?Q?hy+3Ygh5WrHP/RvGm+I3/ntNltVlnR2SXvG1dkq6SINR3Bwb4Ci9k68VFcb/?=
 =?us-ascii?Q?2/YUWXALope9m4vICMj6dqf/ceI9Im61Q++JP3TKorH2OgcP6CPz5wvIsHDt?=
 =?us-ascii?Q?hQXEol0Zerz+/FjJ3be1cUYidXA57wGxUAK42QWuf9iIU2ZV5D3vGwSG1wCb?=
 =?us-ascii?Q?xHX8NFGEt97QsepOw8VCtpSI8rIVpKn/DVeTkVFanFxaMhr4REMzaxuY2ibz?=
 =?us-ascii?Q?RX/CNSHjAyYo/pvxl+cvZLREFAujmco7g7YiM47XO0HZzRLrPJyRvDBVKJO8?=
 =?us-ascii?Q?fqicAP2UVeYA6iqIlv5YKVy4PdUhGyCUBtjbXBZWFn3NazypA2TGBsiZyB2M?=
 =?us-ascii?Q?thhcOxW8w1ype98XAtWryuXw7EbM07ARBXPHmkDFNPpndnGXq2FSLQRiK1TS?=
 =?us-ascii?Q?ywwAiPUCP2J+Kdboi+gMHQd4NRYH0ZkE4llbtzDPTrnrD8q116s/MVGh5esP?=
 =?us-ascii?Q?tf/3/KPw4uHGzXjBfwzJbYI8AWYFfsfyYmmP66Vqlq5Vh9NltnYlZPwl3wNY?=
 =?us-ascii?Q?TWW2ikO7AVU8uhEefOhugwL4xNQgue+UhNfNYbhW9JN5Y7uEvsl4fzMgcyXI?=
 =?us-ascii?Q?lUzqcZ/uERl9vg+G67QQIVrb2/u9gHfiKzP8G4eaH9d5Uks+FN8+VJ6F9VR1?=
 =?us-ascii?Q?7LapbKzuuIrUAWElvR1P0RJXiOFkKPOvBp442NGabkl8W7cKFVYii3c8DiMs?=
 =?us-ascii?Q?L4lUkNc9+ZK035K+SAjWZ4h3jSdR10EELa8q6J5RY2INFoXDPYjdDaRGfbbY?=
 =?us-ascii?Q?IoHQfB78hArcEbZ8ad7IVoVsM4MEiws+CZjaHDS7VR1/HKE4M//u+HOPqq33?=
 =?us-ascii?Q?CmQe1iZsQfPt7eV3sQRnwBYn8R2IgOZBthD2VnncmvWOUckxT+E2GQ+Rh+dP?=
 =?us-ascii?Q?BZB0U47wavG2ohMJEh55Vp59uhVc19jnxc/yRk5HRIJYeh41Yl0WdycwgAhH?=
 =?us-ascii?Q?vLDcukiwkV3yDWnHxXT7ZgYcfXOlXSNdgQMZs4aCIaYc6iOarWpa8X9GaO1Q?=
 =?us-ascii?Q?jnb7la+ZyCRhs7AOOmX1zg129nDSa4vZ+WvuNUKmTKcijVdknlVRHGqCSMsJ?=
 =?us-ascii?Q?5vVUVjfLO2ThaDXyi/Alcrg+hWJHrWVj0d1sT6WG9phEmVZU4KbxqoLhS2Gr?=
 =?us-ascii?Q?77g3AmiSoRFKCF8Yxg45CKbSG1cy1RRNaEei9AtIjWYY8CBUN3Fv0UNjDaIP?=
 =?us-ascii?Q?8RIbzMjVIaMHGfULFPBfXkMvhniJbq1mnrYnmnMvZemQHvq9J3uiXPBKxS/4?=
 =?us-ascii?Q?RmcN3IXqMN1k50sdh3+A3mkS+je0EuMExdwIjoLSc/+ykC4gLGmE91kgkKuY?=
 =?us-ascii?Q?pJIGPo1lyk8RCISlCeffiJ1iuL5FCWn5+BFbfxwa7lvhXN1be/U12R2DDWWx?=
 =?us-ascii?Q?cLvvixLgrmeeqB7VUhYHtcQlQ4U0IqnbaVuk24g3U669IoR3zjg5jUyUR1Lo?=
 =?us-ascii?Q?QLvBNu+PZ0QsXBO82bw776I=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DS0PR11MB74580F9115068E1EDF01ED638142ADS0PR11MB7458namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7458.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9df26823-a8ab-4ce4-0c66-08ddbae67540
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2025 10:35:12.8442 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xxq4zn17Ys8dxPv5afTvrk0vv59p+LAUk7/qbiuJ2/s6KHIk6y9jB455fNVaNe8by8kGb6esjgtiEWtE81WraQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8052
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

--_000_DS0PR11MB74580F9115068E1EDF01ED638142ADS0PR11MB7458namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Acked-by: Kai Ji <kai.ji@intel.com>

________________________________
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
Sent: 20 June 2025 09:19
To: dev@dpdk.org <dev@dpdk.org>; Ji, Kai <kai.ji@intel.com>; Ashish Gupta <=
ashishg@marvell.comashish.gupta@marvell.com>; Shally Verma <shallyv@marvell=
.com>; Sunila Sahu <ssahu@marvell.com>
Cc: anoobj@marvell.com <anoobj@marvell.com>; Akhil Goyal <gakhil@marvell.co=
m>; Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>; stable@dpdk.org =
<stable@dpdk.org>
Subject: [PATCH 1/3] crypto/openssl: include private exponent in RSA sessio=
n

If private exponent is available, it should be included within
RSA session as per RFC 8017 (A.1.2). OpenSSL 1.1.1 implementation
rely on this private exponent, to implicitly reject invalid cipher.
Hence, check if it is available for session and include it.

Fixes: 3e9d6bd447fb ("crypto/openssl: add RSA and mod asym operations")
Cc: stable@dpdk.org

Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
---
 drivers/crypto/openssl/rte_openssl_pmd_ops.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/openssl/rte_openssl_pmd_ops.c b/drivers/crypto/=
openssl/rte_openssl_pmd_ops.c
index 04e018f3df..d3aa396c76 100644
--- a/drivers/crypto/openssl/rte_openssl_pmd_ops.c
+++ b/drivers/crypto/openssl/rte_openssl_pmd_ops.c
@@ -1025,7 +1025,7 @@ static int openssl_set_asym_session_parameters(
                 if (rsa =3D=3D NULL)
                         goto err_rsa;

-               if (xform->rsa.key_type =3D=3D RTE_RSA_KEY_TYPE_EXP) {
+               if (xform->rsa.d.length > 0) {
                         d =3D BN_bin2bn(
                         (const unsigned char *)xform->rsa.d.data,
                         xform->rsa.d.length,
@@ -1034,7 +1034,9 @@ static int openssl_set_asym_session_parameters(
                                 RSA_free(rsa);
                                 goto err_rsa;
                         }
-               } else {
+               }
+
+               if (xform->rsa.key_type =3D=3D RTE_RSA_KEY_TYPE_QT) {
                         p =3D BN_bin2bn((const unsigned char *)
                                         xform->rsa.qt.p.data,
                                         xform->rsa.qt.p.length,
--
2.25.1


--_000_DS0PR11MB74580F9115068E1EDF01ED638142ADS0PR11MB7458namp_
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
<div class=3D"elementToProof" style=3D"font-family: &quot;IntelOne Text&quo=
t;; font-size: 10pt; color: rgb(0, 0, 0);">
Acked-by: Kai Ji &lt;kai.ji@intel.com&gt;</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;IntelOne Text&quo=
t;; font-size: 10pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Gowrishankar Muthukri=
shnan &lt;gmuthukrishn@marvell.com&gt;<br>
<b>Sent:</b> 20 June 2025 09:19<br>
<b>To:</b> dev@dpdk.org &lt;dev@dpdk.org&gt;; Ji, Kai &lt;kai.ji@intel.com&=
gt;; Ashish Gupta &lt;ashishg@marvell.comashish.gupta@marvell.com&gt;; Shal=
ly Verma &lt;shallyv@marvell.com&gt;; Sunila Sahu &lt;ssahu@marvell.com&gt;=
<br>
<b>Cc:</b> anoobj@marvell.com &lt;anoobj@marvell.com&gt;; Akhil Goyal &lt;g=
akhil@marvell.com&gt;; Gowrishankar Muthukrishnan &lt;gmuthukrishn@marvell.=
com&gt;; stable@dpdk.org &lt;stable@dpdk.org&gt;<br>
<b>Subject:</b> [PATCH 1/3] crypto/openssl: include private exponent in RSA=
 session</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">If private exponent is available, it should be inc=
luded within<br>
RSA session as per RFC 8017 (A.1.2). OpenSSL 1.1.1 implementation<br>
rely on this private exponent, to implicitly reject invalid cipher.<br>
Hence, check if it is available for session and include it.<br>
<br>
Fixes: 3e9d6bd447fb (&quot;crypto/openssl: add RSA and mod asym operations&=
quot;)<br>
Cc: stable@dpdk.org<br>
<br>
Signed-off-by: Gowrishankar Muthukrishnan &lt;gmuthukrishn@marvell.com&gt;<=
br>
---<br>
&nbsp;drivers/crypto/openssl/rte_openssl_pmd_ops.c | 6 ++++--<br>
&nbsp;1 file changed, 4 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/crypto/openssl/rte_openssl_pmd_ops.c b/drivers/crypto/=
openssl/rte_openssl_pmd_ops.c<br>
index 04e018f3df..d3aa396c76 100644<br>
--- a/drivers/crypto/openssl/rte_openssl_pmd_ops.c<br>
+++ b/drivers/crypto/openssl/rte_openssl_pmd_ops.c<br>
@@ -1025,7 +1025,7 @@ static int openssl_set_asym_session_parameters(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (rsa =3D=3D NULL)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto =
err_rsa;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (xform-&gt;rsa.key_type =3D=3D RTE_RSA_KEY_TYPE_EXP) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (xform-&gt;rsa.d.length &gt; 0) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; d =3D=
 BN_bin2bn(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (cons=
t unsigned char *)xform-&gt;rsa.d.data,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xform=
-&gt;rsa.d.length,<br>
@@ -1034,7 +1034,9 @@ static int openssl_set_asym_session_parameters(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RSA_free(rsa);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_rsa;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (xform-&gt;rsa.key_type =3D=3D RTE_RSA_KEY_TYPE_QT) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p =3D=
 BN_bin2bn((const unsigned char *)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; xform-&gt;rsa.qt.p.data,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; xform-&gt;rsa.qt.p.length,<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_DS0PR11MB74580F9115068E1EDF01ED638142ADS0PR11MB7458namp_--
