Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11121CD6E4C
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 04:27:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 03F9B40264;
	Mon,  1 Jun 2026 06:27:49 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 9F0034025F
 for <dev@dpdk.org>; Mon,  1 Jun 2026 06:27:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780288067; x=1811824067;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=py35n0g44mw3B9SvbyqSPLI6x4YbbUmIRQgrZjGH7OQ=;
 b=K8TjkHuexImO6vV9RM/jXaid9gIn8FdJKOI6JKpzGKk9Cul5U2hlZ+9+
 nBf4q788J/ZigBinKFu36KwoXAfuqwcNSt/R/MqLIzxVaHJb1/ZhuwU8x
 dlEaXCZl9Y0q3ptx0M3iBIm9aaSQCHdoekYnhx1bO/L6G/76GxKtSY4ap
 VHH3qf350sPuYu1R7qWjwGj/GY3yLtFQYWvGd0Ic+npUrANZVg2don1FG
 Q4weNyUZfoQfl2jOfKUYNiH+PEe4CQGJoY8dM/y9MQrYV/uWcIU4iyGhd
 ApwbjUJdjYVts6WxdQdRcgtc9CGqmOyBsMjw81VdJ5SEugIO6Ys2WINE3 w==;
X-CSE-ConnectionGUID: 1re7ewSiR5KX7X9H4fNSrQ==
X-CSE-MsgGUID: lMsJ2sIKTq+gE5WBwpt6Xw==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="91722257"
X-IronPort-AV: E=Sophos;i="6.24,180,1774335600"; d="scan'208";a="91722257"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 May 2026 21:27:46 -0700
X-CSE-ConnectionGUID: J0cU0OV7SEqRPR3DTHbfOw==
X-CSE-MsgGUID: pTjYPSLKRb6qAPHLmHRzyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,180,1774335600"; d="scan'208";a="243574424"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 May 2026 21:27:45 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 31 May 2026 21:27:45 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 31 May 2026 21:27:45 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.50) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 31 May 2026 21:27:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HFDAKTkbbRvtm2ZNZA+y8FHYJq3Rz56Lp6MGApkjqL0onRzDqWp34rFXRwp3VZoIVb3ZsK1GA8VlkKD+3jQ9AMSj+ybTWLD4RbFEk++xmeAW7n+ThJdMZbgbwDE6yegj24diQlkoV1AIn4QPUGVmIANcdzAQPNylpsOI8H07Q4phXjysmZQ6Imt9YhT6rMDPRhmk15b/I1L14fQcN8OJZrnylQw9WkKJ/F6skUa2YIm5NT0uLitl84TaPZ6gERkX9rw+B1B4hNYmdacAXEm+Pe9vqKTSzKEV0qBA5Xl0K1HSL2R0N2ihHSoxukIEvocyCoQDQTTzs637JOSVN1bgSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=py35n0g44mw3B9SvbyqSPLI6x4YbbUmIRQgrZjGH7OQ=;
 b=xxg9X1CtYq+SFsWTPnzKqlrAu7rmYoQjkAb5bou3TaUAHBsd4zG+I4zS3S4vYVfsR8+i47xUDKHin8hRfYhxltL+/6RQnzpghKaUk+4Ss3PwtRYOU0jGnnVMOKmewFmc4go5UTICVvxLpiweBdfdZNZqe+QUjqhOv0Aun9FXKSveAO5oUHctyPlw2CKsxxZjGvEdXd+w5e3m1qcD0d8b1NdzYV2GT6Y1UOUCJbV5EhdqDRjr0lFcxiG6NFXL4H3PqChy6cL2BsVRC0XZ3xrTr9IjeIrgV67WFZ+sOImiWZ5PwAYl/HaC05rA0GSK7QibirnwxWwt1KKxT+EfVQtKjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5892.namprd11.prod.outlook.com (2603:10b6:303:16a::16)
 by DM4PR11MB6430.namprd11.prod.outlook.com (2603:10b6:8:b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 04:27:38 +0000
Received: from MW4PR11MB5892.namprd11.prod.outlook.com
 ([fe80::d917:88c1:d478:1857]) by MW4PR11MB5892.namprd11.prod.outlook.com
 ([fe80::d917:88c1:d478:1857%7]) with mapi id 15.21.0071.015; Mon, 1 Jun 2026
 04:27:38 +0000
From: "Ajmera, Megha" <megha.ajmera@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "Dumitrescu, Cristian"
 <cristian.dumitrescu@intel.com>, "Shetty, Praveen"
 <praveen.shetty@intel.com>, "Singh, Aman Deep" <aman.deep.singh@intel.com>,
 "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH v2] app/test-pmd: add generic PROG action parser support
Thread-Topic: [PATCH v2] app/test-pmd: add generic PROG action parser support
Thread-Index: AQHc7e9F7t08lSBRb06Wxz6MeEO5F7YpIK0w
Date: Mon, 1 Jun 2026 04:27:38 +0000
Message-ID: <MW4PR11MB5892D1ACE60063CF43295B1997152@MW4PR11MB5892.namprd11.prod.outlook.com>
References: <20260521055612.508916-1-megha.ajmera@intel.com>
 <20260521101354.726240-1-megha.ajmera@intel.com>
 <20260527084123.5c7adccc@phoenix.local>
In-Reply-To: <20260527084123.5c7adccc@phoenix.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5892:EE_|DM4PR11MB6430:EE_
x-ms-office365-filtering-correlation-id: 19265f94-39e8-445b-58ea-08debf961cdb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|11063799006|4143699003|5023799004|56012099006|38070700021;
x-microsoft-antispam-message-info: i9Gi+IyMQ3JphzvUQiH37nyLtSgeRp0zDUeCCRcog7qxMrTOA0+E0+Ue6LHivTbEA/jR8TiEet4eI5M9Ray5DQBvGD4964S1jGdAZU5zvQT2LnpbrIhTWn2Rlk0zmDo1wNbp+K5l0tEGsal4venFhfRQha3PHl7JiaJL4sWDuiq6Xxtn1VtG6JUJah/0BIr7iVwklR8+ILYvy4sCK5HTU+NFrDAvJr6SDM9Q/jujKH5g/vHZBbKQ0KikTWw+zSaL4e5NY+rIfS2ID7TMH8yu06QwMqpd+V+ZkgmeMvq9li9qXoYNc5TWuodT8C62CKum03Dap0rlJcTuQI+06ZUhlQcSsH5ZznRoUcKsTB5cwWcuBBQg9YIiRe8Hd+WryxhCOHCobgx/YOkCr4P9Qs20ZMtMj+W863nWspOUkNo5FbGegg/3nITz0MsK7++KN5pIEsUTj5IjpmklEwLZItRZv5rLsq8e+vvhBR4Wsy++lAmPScQMHMFGAP6iZajNX5ALYT7FNfKw4bCpP1GbWFgvUqdLjhdzK0Y+jJTOs5A35dVpraaxKouVvwKYGH5QLEryREnVR8UbKH89NiaTwxa3lz23gBf4w3y3mfGajG03OCCOwoQQyfBpF4d+p12bOtTqMQUc+jEk0o+lrPQQsQf8nEygzfZX7FgS8M+OtQwD9JetCFsV0/I8xGpadzpQ1FbhYW6QCGbN7olNc9bVifn8j1VEeegSDeRSGZtrOaTWZcU/vHj0IerLjk3tQPjIQFqc
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR11MB5892.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(11063799006)(4143699003)(5023799004)(56012099006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8U8VyZYeC9ZE+e7KCnNyF07TnosV9+0y30DybY1JCFW7c+itCfY34OO+b+MJ?=
 =?us-ascii?Q?j7rorm8p7G+5FLSM/lkRj3I8O8+G7Ihweczs/yKZftbVLrvedvQtokXVvb2o?=
 =?us-ascii?Q?yOLdTPcHaZS7WIoBd8UF5EFMEaN7ojCP2S5GqjDfbBnQXsVPZw+bHEphg4vh?=
 =?us-ascii?Q?lJgJ5xD/cjXi5F87pN35WdUAGBkQ3yzJLWRfIN+JLQXsQQzLl8BsLF2OPfYZ?=
 =?us-ascii?Q?qG+UkouJbqLwbUpCvD/TQWWvT3+sJZSBTDOV02pr1QUgysxpHkMBqq9PC6nH?=
 =?us-ascii?Q?L9Rg8Pl5YY3q7I76WhFReuECekwfwjW7cvStGPdKif1B51y997Zlw+MHcF0c?=
 =?us-ascii?Q?uRYxkETBFZkryROZ30YmlLlYCwZ4X/B9UwWes5P+H12M53q7schO9Qvovkzx?=
 =?us-ascii?Q?FNPk9O0kyq3jvfERnn6yjUv/GZq5erFAn2zNETk6SuUt2pbgaX8n9VDGBcdP?=
 =?us-ascii?Q?6i29M1ZN1astAIQ1sgVEFkUzxvooM2GldtChIppgmMg4xh/zVI3Cj+l/8Nrn?=
 =?us-ascii?Q?pWeEUqSpvwkejEJr00ttsNRi4hgVTDJQeS+v5NI4lY/bc3FGqqa5rPARNekl?=
 =?us-ascii?Q?+9HhplhMDkbCwZwSXoF6YXLhPCK8Pyk3NgV/3RfCpjDKcrfxkx4LYKjxIQny?=
 =?us-ascii?Q?7yFK8uIuzSzYEs+O4KvDJzvg3il01CWNkV3CUqxw+WIItpKgpve/B48+/CaB?=
 =?us-ascii?Q?3znAtr3T/jrf82tJc7M3EeoY7cnAbNPGtH7H5bB8iKzaEZBEjjXy1sN91E77?=
 =?us-ascii?Q?EJVRyYUMDMqycwY/OlUHwXJl3nckOUxlHuOF/C0kBlHGPrMNXD+IVABeMt08?=
 =?us-ascii?Q?h+unSCG8iLE16xBdt+MIwDmRUSHPLEf3HSUCWQcSutUG0HfYlbaaISFeOTRo?=
 =?us-ascii?Q?jB4FuOIqKevmeBmFFdYmkIRHUw97ePV24BIzIlL5FGfeBiHe/MXapUVl65Uq?=
 =?us-ascii?Q?bKyvJtGv1pKC9i+m+wHfEGKf7NDm133EXB31v8DTaA+IwTeWYbFABL+1v/T5?=
 =?us-ascii?Q?r/6QWSAxlWQjCYsO1KYIRdo67BTED3Zw2ur5wt0z4e9ZllrcN80lvP9/k2oD?=
 =?us-ascii?Q?mKNZk7xz0XRe0nTKVgowQ+2KRLifeBOM//AdCMeb41vNS54QXi7cHQD1DS0A?=
 =?us-ascii?Q?yMO3laOB34WVe2BBaQm/hE8aMU24SNeDVcHbBFAO5ZLbiJgXRFsVTR39GHd3?=
 =?us-ascii?Q?2ec4U0sD0K0UqvkBOpqA36HtIxGKtn/trSzEuyTWNfuA0NZ4971MI4DCl/Mr?=
 =?us-ascii?Q?Rkp0GqdZCVy+lzyWjkcl257b7hOEe93baqlnEC02h8aqv70OqaZyVfnlje1e?=
 =?us-ascii?Q?aXXpkknZ0u2k8immkd1u+yKxD96ntmMbGMAmnxZk+JcicNLu9ZHpBSzF6Nxk?=
 =?us-ascii?Q?6Z6sQgIAsrk2ouOl3hzvIIBExWnWTd03+0LEilykqu/HXGi3kZLxh6PEyksT?=
 =?us-ascii?Q?Ox8lW+YXpsOZJ1n28xt+ZnmzwT9O9CJUZiFa1EzHy6Y3ls7mUsvLPj9TfioN?=
 =?us-ascii?Q?nD4hw2tO+O2A27mI53eHX6zhobQFuMpxyBnVBwxsZz0WF123VnP7eEJ1eKc7?=
 =?us-ascii?Q?F32hXbuJJjCCGeHCdnAgfcJZWeUUHkxyEOT2e4dvC54bwFlh5eJxBJpgFNwW?=
 =?us-ascii?Q?h2uOLwkRpK3lHCrZrSGrzOJ6sXAy8k8QvFWEwQM5lk9Hy8ECyvcxHuqyNj+x?=
 =?us-ascii?Q?8Ar32VQZOGb3X7S5c3uGN9go7qTQiZp+2PbcjJMT7A0M4rhNN2snADt+PLGP?=
 =?us-ascii?Q?TtRc1BlzlA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: VIfpMASkuHYh+zFIaGFP4zaMpxn2+t0u5JZ8J5BkWWc6lZF7TyMDeBHGSM5vyvavTcykI6OUp/QLOhV6vjgcHspXyQbCNmKhvGuJUm0oWkfPzGWrRRhfrLlvlN3osWew4NkaNbYKAVv44LtjAGd/UKPACqoFgEiFHZsuHOmEqhTO5/YQWrlZVzRq6StlgE87OrrrcMf4DTkn7SaCWe85sM4WuZGVoGORstpJ/F+WaoqQUNv1rDRTPFKl5JBTEuJE1cuDGSJNrlDcjb8YDMU6vFOv2GreHK45/QLCAg4GJfE5ulKjcJ67sC0rkw4qi+kefXFiIm4FHFZTk6pD8qvxpQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5892.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19265f94-39e8-445b-58ea-08debf961cdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2026 04:27:38.2711 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SIBOgCN+AKOY6t+9eR2VbEzb1/R7jqnFvdvnjAXG26i8BzkAMtWaCCirmJhRzU6K4QS4G3PONahG453e82mRlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6430
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

>=20
> Ran AI review on this manually since that gets better context.
> The feedback was:
>=20
Thanks for the review. I have addressed most of the comments in v3 patch.

Comment #11 is intentionally not applied. In the PROG argument parser path,=
 push_args() stores pointers to struct arg entries in ctx->args, and those =
entries are consumed later by subsequent parser callbacks (parse_int() / pa=
rse_string()), not within the same helper call. So if the helper used stack=
-local struct arg, those pointers would become invalid after return (use-af=
ter-scope).


