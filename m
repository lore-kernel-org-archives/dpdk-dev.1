Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5773ED3E79D
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Dec 2025 07:32:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F72E40BA5;
	Thu, 11 Dec 2025 08:32:17 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 0562440285
 for <dev@dpdk.org>; Thu, 11 Dec 2025 08:32:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765438336; x=1796974336;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=q2TerH98Ok+n7OwiLwn1r9/tbGJP+KQow4KHoCUzPVQ=;
 b=n13YbDHBj1NsCrEkYdw7ylvn8ZliGy2suF9P6cSfZ4qpBlRlO7WKDQN+
 yNr7005rpT/k1+h0TpSc+bkBUBRXvSR2KCgxbNFGjxOXRl0TufJVfLjUa
 qZ6E1Juimu4Z9BSLlQSrQu0Y2k2hCGYg5478P2MVk4Jvtrqfo99OrD1BD
 lBfpIdXDAUGABDOieLA9IkhBhPFiaq3MhVX/XgYf3YMouUoR/IG2RU+WT
 fbl+RrABbkSrx2WKk/CSIDlekfquzgjbtjrZE+pmIqgKdj9CIkhYAUv4v
 Aweuapx3bfmLmZbSYugE4lcFWq+nTWw7xX9r6BZJNRGfy1nGhNUJxHa9l w==;
X-CSE-ConnectionGUID: aI6qichOTSSE3AjPIPggDg==
X-CSE-MsgGUID: Dkm3B2DgREKqeKMqsoIYQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="84824155"
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="84824155"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2025 23:32:14 -0800
X-CSE-ConnectionGUID: b6Vv1dreR1m+VW+cc2EZjQ==
X-CSE-MsgGUID: p4AJkRzDRdWXylWgPisyEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="197216827"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2025 23:32:14 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 10 Dec 2025 23:32:13 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 10 Dec 2025 23:32:13 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.26) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 10 Dec 2025 23:32:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qDQkSbiHPG1YkaT1TR6mS1NyeteRfhPCbP9giLNbuYDgtT3h88oj2cfYTSug2/7Xa3V/QztBc1uINpWzI4ffG8jM0M/eI131qxj8+jIK4LEe4IQzaoN1+fzPXRJYi6WFXSQUKPaOhV1H++Elk5FZpxCjHGgMZy5aa4w9TV9Rm3K5kzQ+J9P/RZfWD0+v2PwtdL37mXf+dq3hFv6CMDCG7PqVrVCduC+JuQ6CZ+LjqMH/OTEvdYS5Qn4N0S2mEHsaWlWxqf8quvizRGfUTPryjBMLavyuLLjY0g6H6TjNj5HPY1eMIdznkKLW7T6H/9P3cdhBdhQcflspVbuocfn27A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RPF5628aREl/ls88MF8gTpRpVyN7gaOXgdTQxcM1ZHk=;
 b=B0ZGdfElZzvgJHLtyEJYNrv0asNojbt6Lm/AXatI6BszFqvnaeRe1XT48WLKRhF4OQ2IQXX+jufzoNPzctd4nEdNe96a0pLF+Kril7c2ZBnsn3v0k+fC8QQ0ljgF54ES6Le6DRLhHnnA27uNk4ln3bXhk95LOBbJnqJSQAhJykyjVh6k93MWY1oDrHG+azBBgWmN40I+As4dYY6IbBdHjv3y39izrZ1JxsxxwXcgH7aK3Uey5aZetJiEtNZSOUVBctW3FfRszzzVXYuEL8ITNbFHA/oKn4VmktZRwDbOs/XsNJ/DTfybBuQDuespDrfC6514BgTFxBDOyeP+5/GdzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PPF291EF9BF1.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f15) by SN7PR11MB7568.namprd11.prod.outlook.com
 (2603:10b6:806:34e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Thu, 11 Dec
 2025 07:32:02 +0000
Received: from DM3PPF291EF9BF1.namprd11.prod.outlook.com
 ([fe80::bf1f:4648:d54b:308a]) by DM3PPF291EF9BF1.namprd11.prod.outlook.com
 ([fe80::bf1f:4648:d54b:308a%6]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 07:32:02 +0000
From: "Shetty, Praveen" <praveen.shetty@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "stable@dpdk.org"
 <stable@dpdk.org>, Stephen Hemminger <stephen@networkplumber.org>
Subject: RE: [PATCH v3 16/31] net/cpfl: fix build with shadow warnings enabled
Thread-Topic: [PATCH v3 16/31] net/cpfl: fix build with shadow warnings enabled
Thread-Index: AQHcYrh2/qgUVCsRIUuMHI27zxQ267UcGO1w
Date: Thu, 11 Dec 2025 07:32:02 +0000
Message-ID: <DM3PPF291EF9BF16B3BA075D591011F19B59DA1A@DM3PPF291EF9BF1.namprd11.prod.outlook.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20251201114448.1441377-1-bruce.richardson@intel.com>
 <20251201114448.1441377-17-bruce.richardson@intel.com>
In-Reply-To: <20251201114448.1441377-17-bruce.richardson@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PPF291EF9BF1:EE_|SN7PR11MB7568:EE_
x-ms-office365-filtering-correlation-id: 99ff3d06-1dce-4f31-6531-08de38876075
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?odx2lBD6B5Hx+nknK7s2YwVyp45H3hJJY8jM+tahmu21pB/PKaOR1mubjnGJ?=
 =?us-ascii?Q?ZWJtrxpNXvWf+bFFdlYS9zLy5cfv02Pjm8ZKZhhCjREeMmbz5z+RRFTkXVed?=
 =?us-ascii?Q?WGy/FXh/wWb+MwGCVp6biR9ZQ1rMsTJp9kH8rdDXLacZFrmUKCyjWjDhxCZr?=
 =?us-ascii?Q?9SdZac0INgvju3bM8MCcvunO5aBityjJ+UPUzg4Iycyd7B0a9wYZV4VivJwr?=
 =?us-ascii?Q?P9f4qE/trDr5CVPmABdXVFHFjEPg1KqX3jeWKz+8kk5Mx79t1pdfMOGCYeJJ?=
 =?us-ascii?Q?OkYbm9uu2N3nLp1TiEWdCB6CuvcM7imHsjEJO6LumWE8JBq7kZEOM29TR8ux?=
 =?us-ascii?Q?vUpc3eqls6mVnrBudhOeNP+XGjy+RrnXcZb3XPYVHO9a9A/qs7L97dZk0z9y?=
 =?us-ascii?Q?7zRV+g2Clq35RVOaR2vNRtM0aJPQqscXzAc0Kv8dRuAqB5QQAoA5iDhuWP3H?=
 =?us-ascii?Q?r+q7SXw+usM4fU5+H0QVeGQzIh4sQoMWZEp6yWBwrF/1LJyuPwk0cM0Ypdqy?=
 =?us-ascii?Q?llTNqgCLgD4JpgSVLkfTRCL2uI5W8ern+eHjkvnMGhNd44Pm/BtM++JkEMJj?=
 =?us-ascii?Q?XKyFUQfEoEuwZjxXpnvLl4JbZhiFVoB/+d1ZMCQMwjT1sdj6hSUdZI9vUck3?=
 =?us-ascii?Q?kjqKbp0F/0qPEv4j/9ODDviHMjBGfOOy495+SFFv+zVFDS33sQShp6A0PZOz?=
 =?us-ascii?Q?qNyz9veFgXzipk5lIKEoLG9fOZuTHyOpZmj5lRYM/O5vtH3N8YOlQj+CRa+w?=
 =?us-ascii?Q?+xd/nqk874VcAR9ejKpImoCSLXBCQ60VVPgZleOdfxD3YLR4vbuGq9iTuy8b?=
 =?us-ascii?Q?jdOQieKUiXlzYY5GZO+k41Fp1ziEVd8fMoA04KXz9gyChXnI7jfacsjsNnwT?=
 =?us-ascii?Q?DSO7m2ExZqZHnBlSyMoM6tStehRQMfaNL6VV4JGrzHMW5HvniFuU97KwNVkA?=
 =?us-ascii?Q?iyNkfPnBV4DSYJzoSbCKLv5bcsywdNAZ6hR0dWGz504jZOAohtNN5+og98yZ?=
 =?us-ascii?Q?1Cp2CyTb60cWXk/fLEk4RV9YOssXP+2/LL+wdi7KcChCg+L6ZRX0cLy2gGeY?=
 =?us-ascii?Q?0im3zHIEGW9yjwEcMsD5sY0FTgI2/LTiX7AAGgAVjLSS0hx3cOPORQ7KhFwY?=
 =?us-ascii?Q?5bAxCqrWzMEAxaowkRZBgaklm925OhqiraAlrNjup5JtBPf0sMCJQ27nxQxq?=
 =?us-ascii?Q?zQR28qbKKKopSbOLD4lrOan1P8GZK4jCOnmknK/guyeNFIPrMTMyKMdZ7Llv?=
 =?us-ascii?Q?NLnDpWl4ELQNa4MXg4tHP42/OU5I4QLLchxvVnG7hXAMezgelFGoTfB/7JXG?=
 =?us-ascii?Q?wea1L1/Yr8PHT2kwH5G6z85NHeCkoOnQUbyCJtujsMaDdJRFVGQBCfvOrBF6?=
 =?us-ascii?Q?IV4itC9B1a/LdsQvyVwYs05zfKCWs3se2ePrIgy2B8/zSrYxJEZxxQmHCMVq?=
 =?us-ascii?Q?bpSLrUP7MhnWUVJNUfW19Pg9hJb2hZDkX9Go+NvVRfiqFoHrRWGr18PVKFZi?=
 =?us-ascii?Q?pPakxfAzyr4B0wTv9vkuaPQCe+mZTmn84vE9?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PPF291EF9BF1.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7FVM+AgJ1vyIOYM2M0mVOjzfOLsN04sQ8HuVWWVAX5aKRL+g/Zk5yVKqFIgY?=
 =?us-ascii?Q?42dsKnLZ1R2QyIkyHFx9AMBUrfAYzYzFhjKvdEJEYIWhjDDbQdAxdLv/5b5/?=
 =?us-ascii?Q?s5wXSWtUz7uBa9QR1YOGKNv6WapgqYwzPFSs5Cvwl0+d8HnH2BY9eW2MMpC9?=
 =?us-ascii?Q?xOMPyYYeuj/+NVVeh5BLISmMGaVnHtPQuq/KppfMsrX1NByerFXEEAezbTVo?=
 =?us-ascii?Q?DfqTa52VjH+RpMudbNInx9n4P0rCnZVzL5S2dzZ4E68J+Y8j0dDY5TvRY8pa?=
 =?us-ascii?Q?TfDYndx9E8JbFwGi4NnJFDQXC8fqiiasBP7y+Grs0CyPZG2Tr3JXvA0QFQDn?=
 =?us-ascii?Q?Vkm60zlmCX0k0meNvZVKwRGEkN4j9tKeamRWPAMb+HVdiIMKIUYRoCRd+vp2?=
 =?us-ascii?Q?hp3XuJqgw32SBr5bvLGDiQvL0RPhNKrzZk1fhNiZuOYY3XcLg/ZOJjcMyyC9?=
 =?us-ascii?Q?soXFxbZg1P8ksovwPYHgjqAPRnyD7zwDJNkZPHaD1VdddJ06CoZpU/gEK/jZ?=
 =?us-ascii?Q?mvjw9+JNRncdab7dUKg9RvPZ52Xn3Pxe3gD6Q/BMYBrZM30a5hugLOHPoEys?=
 =?us-ascii?Q?7ilN2BPT5CX4cxEN0KtmHSUnWh4JkhzuaUNnvAJFdFWQErz/IuYoUMKwEGI5?=
 =?us-ascii?Q?7Hc5VA03bpCpoGZFFA0e3j7jVnePfaEYJy17maDgOlWyi8T5PmD0i8/gzAOJ?=
 =?us-ascii?Q?4NxO7MTvyfWsOp+bMXxLzjGR5gEk0fMn0ZDNXj8fduBlFDHBAD3YPgfZ261x?=
 =?us-ascii?Q?wPKHNcNqzXou0V1UDYVSXoQNLFD+KuycWMxSWHKo7y5LbeehjWo0TNoJ0q1G?=
 =?us-ascii?Q?2rcJMhd9RNnPmiweJwpkz0G3UhFXJ4mQx/RZ6Ktm1J+ZujR5qmRlWjXRmKP2?=
 =?us-ascii?Q?+YLwEYa2ZDZJrL5nhym3ZocFta5EwTJlcEoZBc0puUiCOqbHQwXPeyQ2fI86?=
 =?us-ascii?Q?/LlA5RJcMLsUeGheIS8lDNzig+PQ8+l9E8GUqwXSfiNlFobA+HgABoGTUJVF?=
 =?us-ascii?Q?rZPsTMpO84eCn+chKHKKehtUcAq+VLVGOoDfzCO3/vIGUR+rqBQy9/443BNb?=
 =?us-ascii?Q?PeF+nkFnIN+f28p4dlXMffG1OP3I9TAtglQO2o2GDtTbS7S42t4FNzyEVLuy?=
 =?us-ascii?Q?+cTOccdbLs6N8vyPNIy2ykmqxbgsQeoYdW3JxmjTCl9jN51rpSSQJONJUkF1?=
 =?us-ascii?Q?2vyBFg6fjkynRT/6ce6AEFeuZUFMrsq/AmgcK7XIyHV2DID0p0Jg+f9b0YvB?=
 =?us-ascii?Q?QBSKl14AT01JLuWhrfFWeYXb0TwgP00Juxg9rN6S8bnFEvbaUNI99vzVxCl6?=
 =?us-ascii?Q?5oXBBRD5ZXb089d5jkHChtHdcrsNZIyJjwn8sxPxKdXGyaz2dQeBZbpWdB0w?=
 =?us-ascii?Q?98WSKccg8N8KwBTsnh+YQ37y0pyZektbA10nPdcw1fMSgi/Yr2vUvyAaMbzt?=
 =?us-ascii?Q?mj+VZQ7Ta12LnC/0xtPGi2U6BbusaGc8tkx3rFWfjyPyx3mCCSuvw64mr9qU?=
 =?us-ascii?Q?EZmu0jL3REYEMfl4N4067QfZsuXcOo+sHxZomGW7nbU9KOZx6QbAYRhi0a7Y?=
 =?us-ascii?Q?vrPo6gLLKYNa63QR3k4w9ZV+50UQSFynigaehTfS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF291EF9BF1.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99ff3d06-1dce-4f31-6531-08de38876075
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2025 07:32:02.3037 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m4nkvv8N1nZ/CDRLO0XacUW0KxHCqdZ0WIMVmM+kg7E0CMalbjVK6/2L/g0dQXgr+DCNHJB4z9ACVMpLnDiMGRxoH/1n58sIbBSfVyYyP3g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7568
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

Remove unnecessary variable definitions to ensure compiling with -Wshadow e=
nabled.

Fixes: db042ef09d26 ("net/cpfl: implement FXP rule creation and destroying"=
)
Fixes: 41f20298ee8c ("net/cpfl: parse flow offloading hint from JSON")
Fixes: 3ca8f6b55435 ("net/cpfl: remove devargs from adapter structure")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/intel/cpfl/cpfl_flow_engine_fxp.c | 2 --
 drivers/net/intel/cpfl/cpfl_flow_parser.c     | 6 +++---
 drivers/net/intel/cpfl/cpfl_fxp_rule.h        | 2 --
 drivers/net/intel/cpfl/cpfl_representor.h     | 2 +-
 4 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/intel/cpfl/cpfl_flow_engine_fxp.c b/drivers/net/in=
tel/cpfl/cpfl_flow_engine_fxp.c
index 689ed82f18..361827cb10 100644
--- a/drivers/net/intel/cpfl/cpfl_flow_engine_fxp.c
+++ b/drivers/net/intel/cpfl/cpfl_flow_engine_fxp.c
@@ -386,8 +386,6 @@ cpfl_fxp_parse_action(struct cpfl_itf *itf,
 	}
=20
 	if (mr_action) {
-		uint32_t i;
-
 		for (i =3D 0; i < rim->mr_num; i++)
 			if (cpfl_parse_mod_content(itf->adapter, rinfo,
 						   &rim->rules[rim->pr_num + i],
diff --git a/drivers/net/intel/cpfl/cpfl_flow_parser.c b/drivers/net/intel/=
cpfl/cpfl_flow_parser.c
index a67c773d18..e7deb619ee 100644
--- a/drivers/net/intel/cpfl/cpfl_flow_parser.c
+++ b/drivers/net/intel/cpfl/cpfl_flow_parser.c
@@ -1098,12 +1098,12 @@ cpfl_parse_fieldvectors(struct cpfl_itf *itf, struc=
t cpfl_flow_js_fv *js_fvs, in
 			fv[2 * offset] =3D (uint8_t)(temp_fv >> 8);
 			fv[2 * offset + 1] =3D (uint8_t)(temp_fv & 0x00ff);
 		} else if (type =3D=3D CPFL_FV_TYPE_METADATA) {
-			uint16_t type, v_offset, mask;
+			uint16_t v_offset, mask;
=20
-			type =3D js_fv->meta.type;
 			v_offset =3D js_fv->meta.offset;
 			mask =3D js_fv->meta.mask;
-			temp_fv =3D cpfl_metadata_read16(&itf->adapter->meta, type, v_offset) &=
 mask;
+			temp_fv =3D cpfl_metadata_read16(&itf->adapter->meta, js_fv->meta.type,
+					v_offset) & mask;
 			fv[2 * offset] =3D (uint8_t)(temp_fv & 0x00ff);
 			fv[2 * offset + 1] =3D (uint8_t)(temp_fv >> 8);
 		} else if (type =3D=3D CPFL_FV_TYPE_PROTOCOL) { diff --git a/drivers/net=
/intel/cpfl/cpfl_fxp_rule.h b/drivers/net/intel/cpfl/cpfl_fxp_rule.h
index ed757b80b1..94eab6808c 100644
--- a/drivers/net/intel/cpfl/cpfl_fxp_rule.h
+++ b/drivers/net/intel/cpfl/cpfl_fxp_rule.h
@@ -53,8 +53,6 @@ struct cpfl_rule_info {
 	};
 };
=20
-extern struct cpfl_vport_ext *vport;
-
 int cpfl_rule_process(struct cpfl_itf *itf,
 		      struct idpf_ctlq_info *tx_cq,
 		      struct idpf_ctlq_info *rx_cq,
diff --git a/drivers/net/intel/cpfl/cpfl_representor.h b/drivers/net/intel/=
cpfl/cpfl_representor.h
index d7f6e186f8..5c3d3aa3f6 100644
--- a/drivers/net/intel/cpfl/cpfl_representor.h
+++ b/drivers/net/intel/cpfl/cpfl_representor.h
@@ -21,7 +21,7 @@ struct cpfl_repr_param {
 	struct cpfl_vport_info *vport_info;
 };
=20
-extern struct cpfl_devargs *devargs;
+struct cpfl_devargs;
=20
 int cpfl_repr_devargs_process(struct cpfl_adapter_ext *adapter, struct cpf=
l_devargs *devargs);  int cpfl_repr_create(struct rte_pci_device *pci_dev, =
struct cpfl_adapter_ext *adapter);
--

Looks good to me,
Acked-by: Praveen Shetty <praveen.shetty@intel.com>

2.51.0

