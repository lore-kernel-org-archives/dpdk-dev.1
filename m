Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A889CCD1A7
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Oct 2025 13:48:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 69FB340653;
	Tue, 21 Oct 2025 15:48:57 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 0146A40652
 for <dev@dpdk.org>; Tue, 21 Oct 2025 15:48:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761054535; x=1792590535;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=SVUiF5EVv7Ags4xDaW8HCV+LQwKEzOO1BAzCwM3aHlM=;
 b=EZJ6bf2g6uvjOxpukodKuWworehFxqYmu5QF+6y54BWLH7QRAxSj8wSM
 YYXl538/62A+Zrt202MRkKl73fi+ML0HubeE4EfwEG3PCV+iSk7a3E6h4
 xrIFCj36S+7fsI4FQNtJ0qby4pl1Dd+F0yNW3bN131X8ezB98VphoquP0
 ZJ8jKqXAi9mEpTgo3GY2QJVDbEXhYHfDLtL2DWHeuMgo6uwSurxfcgCLX
 0E4z+tudTruct4rNkgIWov+u0h/e3f0Dt7jmp+y2E6ZduQEctHQoCDbAG
 6huPH/uGec/9TKb08+eFp/mwiJI++d6OTVZjuARfXeQa436BtC6WXc0hr g==;
X-CSE-ConnectionGUID: dRPdeaw7TauvKFT/qO64QQ==
X-CSE-MsgGUID: L8Ctj3dHQ0yVeHckLlRSZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="50752929"
X-IronPort-AV: E=Sophos;i="6.19,245,1754982000"; d="scan'208,217";a="50752929"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2025 06:48:54 -0700
X-CSE-ConnectionGUID: oVkGfH3PSHKlnAQxt+yyNw==
X-CSE-MsgGUID: s2akXZSRTS2GCobnIb9DTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,245,1754982000"; 
 d="scan'208,217";a="183301479"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2025 06:48:54 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 21 Oct 2025 06:48:53 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 21 Oct 2025 06:48:53 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.27) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 21 Oct 2025 06:48:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MfT/HPGyuhp38ilPOSF6e5QDJ9LC/12Fd/c1D96jjcOYFAPzfVSSvQR171BK3yG0KhCbPlvFbj3DNRf3sLh0lwYFwmcurkfrmlK12lDLlOtCSe+dTwM4p3aLgyYQybTfJ92O0l3CBIUHK+wDA/B0I0nILjO6Wp7QkjycEZedr56SRvgCpjA2Ff1EiAVdS1X5h7bKq9zYGmRBcYIp5PS0GPubYDHhRFf2Os/bSpOmRVixWMNlIZuh0qddw8uL40PlYtRYMW767R4gFO0N4uLF8PhVk6/EyN5c9qyRQ6n4raCfU+vCr7m1TUxSh9Aipo/jByAXT71XUSi2Kgvq4CqAyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9QE1Etj9WmGGnCUQCRiCLl0z9vpU7Mlxu3whWVUfmHk=;
 b=akJ/uV1Ldwjhs7k1Y+1/60wl1f8X76UrvZaJz0edLakmKPQ1ee+EMUi0PmrzMiFU/pBENQFPgoJlzJHMEmMsX0Tti3qBNi2C6xuWi7Fpwfu/64cGX4DFk6V9E9bzkWfgjBFnSLZXmB/nxTjqeRB1Ib2SfjWZWvLIDdD7gEkD2BiK7v4RDUaysu+8LyInb6bVb+cRe6rpVLyJlDNh/KcadrDNIE5Fe/qVl5mvRgQMjJ0K69fWKOkQuORwd6erQyDlASMQ3GFmOtzdIxKkhHvZCGXpv37eI6pgqWmLyn8bcNoPtwmTcMcAWtNoc7m6VMXtxcg4fEjA82hDmSBdiUaVog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH3PPF37F43E35D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d16) by PH3PPF8B755DBFD.namprd11.prod.outlook.com
 (2603:10b6:518:1::d36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Tue, 21 Oct
 2025 13:48:46 +0000
Received: from PH3PPF37F43E35D.namprd11.prod.outlook.com
 ([fe80::2be2:5d5c:1b79:969b]) by PH3PPF37F43E35D.namprd11.prod.outlook.com
 ([fe80::2be2:5d5c:1b79:969b%7]) with mapi id 15.20.9253.011; Tue, 21 Oct 2025
 13:48:46 +0000
From: "Mcnamara, John" <john.mcnamara@intel.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: "thomas@monjalon.net" <thomas@monjalon.net>, "Marchand, David"
 <david.marchand@redhat.com>
Subject: DPDK Release Status Meeting 2025-10-21
Thread-Topic: DPDK Release Status Meeting 2025-10-21
Thread-Index: AdxCkWIPKF8ml3lkQMG4GthVJoOwig==
Date: Tue, 21 Oct 2025 13:48:46 +0000
Message-ID: <PH3PPF37F43E35D0AF04B00895AD995FD81FCF2A@PH3PPF37F43E35D.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH3PPF37F43E35D:EE_|PH3PPF8B755DBFD:EE_
x-ms-office365-filtering-correlation-id: 2b56ab7e-d995-4f15-122e-08de10a88e94
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|8096899003; 
x-microsoft-antispam-message-info: =?us-ascii?Q?89hHo10Blq4xsBgiB9PsrxZTWVGL+AlotgfVMd/KlrtPfm3ZGhrx/M4/Itcc?=
 =?us-ascii?Q?mEKkNqou9PjCrK82XoCrEG2BNdYPhtdekTsmezW9sV077vz0wIdruNk/NSoT?=
 =?us-ascii?Q?7S21WDmKCCjwhFGOLUKlP3dQov6P1z6DnTmH0LR4oMF61aoeeesvR30ADJGG?=
 =?us-ascii?Q?pogoftjJCrtdOYkg8Lwcv8M8LnZdbWxa+Y60bmHRoAgvtgUDs3GJMoQr6eoT?=
 =?us-ascii?Q?mZBgoYfwjM4B9P87Y6nX/bhIr3N4OkUZ9/x/p9Wt1+1cg9ZkLW7MC/3FJEtV?=
 =?us-ascii?Q?PN5rTCyA8ModJYsvHtLMO1osFTpUEnxYXonQF2rho5ixAkg+BvO5Y9YtGt5Z?=
 =?us-ascii?Q?kDPaUGgSjBVHDswlnbWixUgoGL+WH9d1k4pb2BgqG6kNCmZ4Dt4Spcc+W/Yq?=
 =?us-ascii?Q?N4NKcrdWZ8l6wkCkFqMgrLfa6iaViEIsG5MFV1T0V9MIol2P2ojG+CxR16qy?=
 =?us-ascii?Q?3jFO1wcbg+vlPDq/HuZDDyCdfkw17sLskAziF9L7y3s4o6X/JEt2kWX8aMZb?=
 =?us-ascii?Q?6ioEe6qVNZlk+K+2G6NQH8FYmNbxcNikoWbFshIPBtSttBUPO7g3WiiTAoAq?=
 =?us-ascii?Q?kqO9+pKMnzYV0b0OS39wgBlhaB/z3nJSuUAAspWfqM/yHTnT2PF9MIxpC2zC?=
 =?us-ascii?Q?rWaAVCHlFZrUzZ0XTvVDXRhg8mmTES5wgbLV1Jg+BRqXJPQ9o8jA+mMXbTSX?=
 =?us-ascii?Q?wZ2ptMSj+oHBkg8p6gZzaeShJUIP+/jKoy7l0S/sqCCE6gpDjpJOHxW4v/qQ?=
 =?us-ascii?Q?lzU357IILY1QcyE4o8l1I7Qr/5QK5hxwvw5qSbEQNeDOWIjbjtI2v43qfYMp?=
 =?us-ascii?Q?XW1lkj/3/RhyXSOQY6F4UXsHcMcWzK9HIU6KzT9TJi/pOaA6aetZbZEZUHhJ?=
 =?us-ascii?Q?dflA2YX+n7oMzC7Ixr2sbvScBBUeEnuBy7c57xk+7mLNnI+9ApqlgTI1hm1P?=
 =?us-ascii?Q?BLt505SXCCVeVGfAgtUZKSeaPSzbTlTuB/uWjnhv9akKSXuJ+GUxEUaekyp9?=
 =?us-ascii?Q?yqaA/QbiEya9a10QdjSPYJmE6uKR2m5WK7L0eyISCf7ghwylJPzjjZHs4fAZ?=
 =?us-ascii?Q?mZ7aAyjml1e2PdeQfgJgR+f8kuIz8ANZVjtjoLB5uz9T+ufem/64HFZOPY0r?=
 =?us-ascii?Q?yU1hs9ndDcszWVjbpJFpaTGn1YIYZ0z8MO/XzPEQsuOf9PugwSVQHAD7yq5Z?=
 =?us-ascii?Q?h4jFE5YajMVfXS8uajLhzGmx/6Nl+HiNDmpacvD/+3GeuLcF4dgb2pkacj4a?=
 =?us-ascii?Q?Vx+DHuktPCVvhHrZTsPIJcudvk2kIEXuymRaqnt2SatAWh9uVO4tNzaH2vPx?=
 =?us-ascii?Q?ZyMzooKR+zApargy5f+2PHa0Es7rL7oojsyUiZmaENjBs/1MUdNA5eYThNt8?=
 =?us-ascii?Q?5rR7zE+Hyj1/HVsMlxcpkBRPBa4/SLDKnqxIfREaAQ71UgZ0P3+dHJn5M5SK?=
 =?us-ascii?Q?TLMF9IgkQsxu/s/WWnwKssu9F7npqCgGttMYRI67Wqn3ldDVAu31cg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH3PPF37F43E35D.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(8096899003); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uwpwwNsJT2Eff58Shn23SBFLZSKD2FSrjrfRCdb3ufRNmUToR4p1Pe8kyVrR?=
 =?us-ascii?Q?Zd4sjTC2HGrT9vjYx3gAchrTK/H/T82aXcBtUOIqVI37L2mQTVsRDkUxePgu?=
 =?us-ascii?Q?XiLgX+bMjU11JCpEqSnibDEoD73eoC/uPkR/b9W6VFqMYCCu+TPW3+/dPLJB?=
 =?us-ascii?Q?V6S4icex7W8DY3uotUsZh+y4E+hliSwR1Gxh8siv1t85KLM+pcKbg883gYVz?=
 =?us-ascii?Q?RtyKUhlWSVhasRfiN023qlTxYoQE4bDoxQ3PboXXrwpxwHCgydJDV7FndNv2?=
 =?us-ascii?Q?JAVvk7GRAFqjzYNg5Duvd98IAS4Feq+kUzhZhnSpqOVgmu5WoD/Pybd4xhJj?=
 =?us-ascii?Q?vNlXFu67DtX9cQBxcCp7IeSv98YV2ualEF451qEGaqroawPmHdhYDvxqWwnb?=
 =?us-ascii?Q?SSHlUI0rk6z0X362fEc0dvzKokODQRoQaCqaHa0Z/BHy1rFRED/KjHqA2+kc?=
 =?us-ascii?Q?NbL6JAseu4Jni0rvWr/074J67ObwJqUtJ7c+gaORqCVwAQEDOwu2W2S4B1Hi?=
 =?us-ascii?Q?POVRSEAhpFuyk7tnxZSOqbqY9IWt9rUAfqm1quFOD8DnCNZo0k9Ia5Vo/2yB?=
 =?us-ascii?Q?UcfpgURLIa11UsgoFxoCjwXGJPndWOoqEDouRBnQxTxfXI4w1DbDq5XPY+gZ?=
 =?us-ascii?Q?dTveKj1+JYDuJe8p6tUTXAzpLllAk3lV50ad4Jo6cz3wZkjHiZjQTiIrjinQ?=
 =?us-ascii?Q?P3UbO+SbYAyR+cNiMJCwHlA3tLTuMV3wBSI5l4lbqrYaUez9c9clGrbV2n1o?=
 =?us-ascii?Q?Eq8jq05N6MloaH/90VzRQ7cdN5jrZuYnDVPx5mLp9r8x7PmJuMrBmqJyzYtO?=
 =?us-ascii?Q?gBTwQQXWGwwoWcYgv1XHlcBWa3Bq0eFntpkMj+B8ag+RUnL6qklAjO+ntB1r?=
 =?us-ascii?Q?2tNsW91HsDmFm9tLpULA18LIt6EzTciwoGqUp1/SNMfOjzKSFo++zDhxwNWb?=
 =?us-ascii?Q?xbOePDsQ9Dscu99U0AEsV01YscdfgzxJ3beOF5U3gw8DQkb2PGWS1uMmURJ2?=
 =?us-ascii?Q?9HxuIYEAu63TS0i6E1pNW5KDsYsnl01Ktyb+HqjSvd8BsIt4W72v2PKoHsjR?=
 =?us-ascii?Q?Pbtk8awKRnEnC/BLZ6euWKubrrtkxTF2tekirt6xiW3b2gaeCd71AxBpUacE?=
 =?us-ascii?Q?Q09eQ5DFlEjZCpxhfpGBWtvxrHlQ/aDk3lSf707yRtBBN7yqqZFZh0LDrgTA?=
 =?us-ascii?Q?vbOJMbv8mu56JWRaTy4+ENyU9qWONr9bQWAhM6Fj5V9d7iIX7N8WVy+shbBv?=
 =?us-ascii?Q?qO1Jzx2VKvI1MRSF3lABCydXTFDOXWRkEmdGuxuL8H6GHb1PmlcexbymOtrn?=
 =?us-ascii?Q?U0NJu0IPeRxC5TGRKyVRWDm7EqPftDn1UkgCf66RVeM8L2NaFTSnSTg3Q0Zi?=
 =?us-ascii?Q?S1/ULeN1WtBoTEyaGEon+tDuJjvVXfyX0VMRa8Lx+ENNyUeCj9qL07z4AON/?=
 =?us-ascii?Q?qAIXLIpQ78V3rQ4hijzkC8zhbg/VixSyA0DMYt7zQfISy9Z1crHCG5pUxnpr?=
 =?us-ascii?Q?5FNTGgTPwg6gqaCtw1n007ulj8Hhu8yvyTFH08m/FSbf0/LBHrOhU93DCz1d?=
 =?us-ascii?Q?U2Lr50hoqCSF++cl8k/Qex8rJuzC6rXhFlP3vP2N?=
Content-Type: multipart/alternative;
 boundary="_000_PH3PPF37F43E35D0AF04B00895AD995FD81FCF2APH3PPF37F43E35D_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF37F43E35D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b56ab7e-d995-4f15-122e-08de10a88e94
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2025 13:48:46.5726 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6lnRjbo50P0Pic686kGDFV9DjdIWDnhT8QS1fSS3fKO0AAia1H8MX3metuJ/UNsIxVWn2/jJD/1Y7vkIZL12hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF8B755DBFD
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

--_000_PH3PPF37F43E35D0AF04B00895AD995FD81FCF2APH3PPF37F43E35D_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Release status meeting minutes 2025-10-21
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Agenda:
* Release Dates
* Subtrees
* Roadmaps
* LTS
* Defects
* Opens

Participants:
* ARM
* Intel
* Marvell
* Nvidia
* Red Hat
* Stephen Hemminger

Release Dates
-------------

The following are the proposed working dates for 25.11:

- Proposal deadline (RFC/v1 patches): 31 August 2025
- API freeze (-rc1): 6 October 2025
- PMD features freeze (-rc2): 27 October 2025
- Builtin applications features freeze (-rc3): 3 November 2025
- Release: 19 November 2025

See https://core.dpdk.org/roadmap/


Subtrees
--------

* next-net
  * 147 patches pending.
  * 77 to review/merge.

* next-net-intel
  * Tree pulled for RC1.
  * Small number of patches for RC2.

* next-net-mlx
  * Tree pulled for RC1.

* next-broadcom
  * No update.

* next-net-mvl
  * No update.

* next-eventdev
  * No update.

* next-baseband
  * PR ready.

* next-virtio
  * PR ready.

* next-crypto
  * No update.

* next-dts
  * Close to merging the mbuf fast-free test suite.

* main
  * Prepping for RC1.
  * Most submitted trees merged.
  * RC1 probably by 22 October 2025


Other
-----
  - None.

LTS
---

Released LTS versions:

* 24.11.3 - Released 2025-08-19
* 23.11.5 - Released 2025-08-25
* 22.11.9 - Released 2025-08-19
  - 22.11.10 released 2025-09-17 for CVE-2025-23259.


See https://core.dpdk.org/roadmap/#dates

* 20.11.10 - Will only be updated with CVE and critical fixes.
* 19.11.14 - Will only be updated with CVE and critical fixes.


* Distros
  * Debian 12 contains DPDK v22.11
  * Ubuntu 25.04 contains DPDK v24.11
  * Ubuntu 24.04 LTS contains DPDK v23.11
  * RHEL 8/9 contains DPDK 23.11

Defects
-------

* Bugzilla links, 'Bugs',  added for hosted projects
  * https://www.dpdk.org/hosted-projects/



DPDK Release Status Meetings
----------------------------

The DPDK Release Status Meeting is intended for DPDK Committers to discuss =
the
status of the master tree and sub-trees, and for project managers to track
progress or milestone dates.

The meeting occurs on every Tuesday at 14:30 DST over Jitsi on https://meet=
.jit.si/DPDK

You don't need an invite to join the meeting but if you want a calendar rem=
inder just
send an email to "John McNamara <john.mcnamara@intel.com>" for the invite.


--_000_PH3PPF37F43E35D0AF04B00895AD995FD81FCF2APH3PPF37F43E35D_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:EN-US;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Consolas;
	color:windowtext;
	font-weight:normal;
	font-style:normal;
	text-decoration:none none;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:11.0pt;
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-IE" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Release status =
meeting minutes 2025-10-21<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Agenda:<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Release Dates=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Subtrees<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Roadmaps<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* LTS<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Defects<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Opens<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Participants:<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* ARM<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Intel<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Marvell<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Nvidia<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Red Hat<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Stephen Hemmi=
nger<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Release Dates<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">-------------<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">The following a=
re the proposed working dates for 25.11:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Proposal dead=
line (RFC/v1 patches): 31 August 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- API freeze (-=
rc1): 6 October 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- PMD features =
freeze (-rc2): 27 October 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Builtin appli=
cations features freeze (-rc3): 3 November 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Release: 19 N=
ovember 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">See https://cor=
e.dpdk.org/roadmap/<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Subtrees<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">--------<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 147 pa=
tches pending.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 77 to =
review/merge.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-inte=
l<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Tree p=
ulled for RC1.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Small =
number of patches for RC2.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-mlx<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Tree p=
ulled for RC1.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-broadcom=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * No upd=
ate.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-mvl<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * No upd=
ate.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-eventdev=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * No upd=
ate.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-baseband=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * PR rea=
dy.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-virtio<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * PR rea=
dy.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-crypto<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * No upd=
ate.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-dts<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Close =
to merging the mbuf fast-free test suite.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* main<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Preppi=
ng for RC1.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Most s=
ubmitted trees merged.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * RC1 pr=
obably by 22 October 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Other<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">-----<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - None.<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">LTS<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">---<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Released LTS ve=
rsions:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* 24.11.3 - Rel=
eased 2025-08-19<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* 23.11.5 - Rel=
eased 2025-08-25<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* 22.11.9 - Rel=
eased 2025-08-19<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; - 22.11.=
10 released 2025-09-17 for CVE-2025-23259.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">See https://cor=
e.dpdk.org/roadmap/#dates<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* 20.11.10 - Wi=
ll only be updated with CVE and critical fixes.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* 19.11.14 - Wi=
ll only be updated with CVE and critical fixes.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Distros<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Debian=
 12 contains DPDK v22.11<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Ubuntu=
 25.04 contains DPDK v24.11<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Ubuntu=
 24.04 LTS contains DPDK v23.11<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * RHEL 8=
/9 contains DPDK 23.11<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Defects<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">-------<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Bugzilla link=
s, 'Bugs',&nbsp; added for hosted projects<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * https:=
//www.dpdk.org/hosted-projects/<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">DPDK Release St=
atus Meetings<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">---------------=
-------------<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">The DPDK Releas=
e Status Meeting is intended for DPDK Committers to discuss the<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">status of the m=
aster tree and sub-trees, and for project managers to track<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">progress or mil=
estone dates.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">The meeting occ=
urs on every Tuesday at 14:30 DST over Jitsi on https://meet.jit.si/DPDK<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">You don't need =
an invite to join the meeting but if you want a calendar reminder just<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">send an email t=
o &quot;John McNamara &lt;john.mcnamara@intel.com&gt;&quot; for the invite.=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
</div>
</body>
</html>

--_000_PH3PPF37F43E35D0AF04B00895AD995FD81FCF2APH3PPF37F43E35D_--
