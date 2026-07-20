Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A75C44520
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Jul 2026 22:56:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 38EEA4028E;
	Tue, 21 Jul 2026 00:56:08 +0200 (CEST)
Received: from rcdn-iport-6.cisco.com (rcdn-iport-6.cisco.com [173.37.86.77])
 by mails.dpdk.org (Postfix) with ESMTP id 4384540288;
 Tue, 21 Jul 2026 00:56:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cisco.com; i=@cisco.com; l=2062; q=dns/txt;
 s=iport01; t=1784588166; x=1785797766;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ekkdJllbLgHKRuPDK5r0q63+3dK/iSJIawXZu54nDAM=;
 b=LG6JEuOniVX6zZEa7BoMBI95RBGG+MXJvi37viKuPW6Cfh+QBweIgFP8
 Q6a+PivwoFJpMWOcgvNKtbYMN4QVS8Ny6YI5IPKYCPqEd9taEgqaZ6G0q
 U0n5/+JU1WmCeUJ2LHFc+36vFzWVl9G2lgKHP2v2Ca9BtBpY3fTEZGIZ2
 h9OiKWu4sGDnjWUaL9vKxMbFu2X89U4ph/yUdxq4C7FR8hG11+rlMOysF
 t2N+FxWmTGqmeyBnkLLoWwahn5K99Hg/t41bt42aA5zb/AAGlGjtUdiH1
 tKJXDyG2VeENhwWlNBtuj+Wr6yUG75SBvPLHMIQ12AvoaBin479v+AbFB Q==;
X-CSE-ConnectionGUID: SRqJvqI8S+G+Dmc4/doHHw==
X-CSE-MsgGUID: r2V+v//VQneZM+qpAGqDYw==
X-IPAS-Result: =?us-ascii?q?A0ADAABapl5q/43/Ja1aGQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RIBAQEBAQEBAQEBAQFlgRcEAQEBAQELAYFtU4EKgSFJiCMDhExfiHkDi2SSN?=
 =?us-ascii?q?4F+DwEBAQ89FAQBAYUFAo1XAiY0CQ4BAgQDAgMBAQEBAQEBAQEBAQsBAQUBA?=
 =?us-ascii?q?QECAQcFgQ4Thk8NhloBAQEBAgESFRM/BQcEAgEIDgMEAQEfECARHQgCBA4FC?=
 =?us-ascii?q?BqCYYI6AxAnAwECDgayOwGBPQKKKniBATOBAd1GDYJeBhQBgTgBhT6CfR8BA?=
 =?us-ascii?q?YQ8gSEBGYR8JxuBSUSBV4JpPoIfgWs7hBOCMASCIoEMg0+CB4wzUnh4LAFVE?=
 =?us-ascii?q?xcLBwWBI0MDgQYjSwUtHYEjIR0XFh5YGwcFEiAqQUUjA08vEDgLQwWBVwKCB?=
 =?us-ascii?q?U4jHwM5f4EvdUp3LWkBAhAXSjgkghICgTsCTgMLbT03FBkDBIE1BY1RI4JAA?=
 =?us-ascii?q?XoJCixQMxWUQoM1kEieaXEKhB2MIY8+hjIXqmyZCI4KhAmRboUXAgQCBAUCE?=
 =?us-ascii?q?AEBBoFoPIFDDwdwFYMiE0AZD5c2ySd5AjsCBwIHDgMLkWgCJgeBTwEB?=
IronPort-PHdr: A9a23:M9dFAhOBs/dl1eY9v7El6nc2WUAX0o4cdiYP4ZYhzrVWfbvmo9LpP
 VfU4rNmi1qaFYnY6vcRk+PNqOigQm0P55+drWoPOIJBTR4LiMga3kQgDceJBFe9LavCZC0hF
 8MEX1hgl0w=
IronPort-Data: A9a23:Yz7/bqnLoeYWZSPdNuj5id7o5gzWJ0RdPkR7XQ2eYbSJt1+Wr1Gzt
 xIeDGqAP/fYa2bwc9wlOY7j8UtXuZKBx9BlSlFs+SkxFVtH+JHPbTi7wugcHM8zwunrFh8PA
 xA2M4GYRCwMZiaC4E/raf658SUUOZigHtLUEPTDNj16WThqQSIgjQMLs+Mii+aEu/Dha++2k
 Y20+ZC31GONgWYubDpLsfrb9nuDgdyr0N8mlg1mDRx0lAe2e0k9VPo3Oay3Jn3kdYhYdsbSb
 /rD1ryw4lTC9B4rDN6/+p6jGqHdauePVeQmoiM+t5mK2nCulARrukoIHKZ0hXNsttm8t4sZJ
 OOhGnCHYVxB0qXkwIzxWvTDes10FfUuFLTveRBTvSEPpqHLWyOE/hlgMK05FbYi48RpGEAez
 r83axwIZUzEi+WW4K3uH4GAhux7RCXqFJkUtnclyXTSCuwrBMifBa7L/tRfmjw3g6iiH96HO
 JFfMmUpNkmdJUQTYz/7C7pm9AusrnnudDtbqVe9rqss6G+Vxwt0uFToGIeMIYTQHZ0Ezi50o
 ErcpVq6HFZdCuWZxAigsWu0r8DWsRLkDdd6+LqQs6QCbEeo7mAeFjUaTVe45/6jhSaWQM5WI
 UgZ0iY2oat081akJuQRRDWiq3KC+xpZUN1KHqhitEeGy7Hf5ECSAW1soiN9VeHKffQeHFQC/
 lSIhNjuQzdotdWopbi1rN94cRva1fApEFI/
IronPort-HdrOrdr: A9a23:hYkQA65zBqdD5LUPbgPXwceCI+orL9Y04lQ7vn2ZFiYlEfBwxv
 rPoB1E737JYW4qKQ8dcLC7VJVpQRvnhPhICPoqTMaftW7dySSVxeBZnMffKlLbalfDH4JmpM
 Ndmu1FeaLN5DtB/IjHCWuDYqsdKbC8mcjC65a9vhJQpENRGt1dBmxCe3+m+zhNNXJ77O0CZe
 KhD6R81l2dUEVSRP6WQlMCWO/OrcDKkpXJXT4qbiRM1CC+yRmTxPrfCRa34jcyOgkj/Z4StU
 TVmQ3w4auu98q81gLd0GHr6ZFXksvKy9dIBsCA4/JlawkEjDzGWK1RH5m5+BwlquCm71gn1P
 PWpQ07Ash143TNOkmovBrEwWDboXUTwk6n7WXdrWrooMT/Sj5/IdFGn5hlfhzQ7FdllM1g0Z
 hMw3mSu/NsfFH9dWXGlp31viNR5w2JSEkZ4KguZrtkINIjgYpq3MgiFYVuYc899WzBmdsa+a
 JVfbHhDb5tACCnhjbizylS6e3peGgvFRGbRUVHkMmU3z9K2E1d9SIjtZYidrNqzuNgd3GCjN
 60b5hAhfVASNQbYrl6A/pEScyrCnbVSRaJK26KJ0/7fZt3cE4lhqSHqYnd3tvaMKAg3d83gt
 DMQVlYvWk9dwbnDtCPxoRC9lTITH+mVTrgx8lC79wh04eMCYbDIGmGUhQjgsGgq/IQDonSXO
 uyIotfB7vmIXH1EYhE0gXiU91ZKGUYUscSptEnMmj+6P7jO8nvrKjWYfzTLL3iHXItXX7+GG
 IKWHzpKMBJ/imQKwnFadjqKgTQk2DEjOZN+fLhjpouIaA2R/hxjjQ=
X-Talos-CUID: 9a23:8CBg+G6z5oclHO+Z0Nssz3QNON48Uy3mj1iTD0qzVSFlT521VgrF
X-Talos-MUID: =?us-ascii?q?9a23=3A/U4sOQ4RrFdvwYoeGOheuYXmxoxyuZrtFgdKr6w?=
 =?us-ascii?q?AtvuhdjVoEhiEoAWoF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-l-core-04.cisco.com ([173.37.255.141])
 by rcdn-iport-6.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 20 Jul 2026 22:56:05 +0000
Received: from rcdn-opgw-4.cisco.com (rcdn-opgw-4.cisco.com [72.163.7.165])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by rcdn-l-core-04.cisco.com (Postfix) with ESMTPS id EAA99180001AB;
 Mon, 20 Jul 2026 22:56:04 +0000 (GMT)
X-CSE-ConnectionGUID: oZ3lF21lQtejDlydTAOR9A==
X-CSE-MsgGUID: ON6k1EW5RvyMk8B1ekcbtw==
Authentication-Results: rcdn-opgw-4.cisco.com;
 dkim=pass (signature verified) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.25,175,1779148800"; d="scan'208";a="88860433"
Received: from mail-southcentralusazon11011012.outbound.protection.outlook.com
 (HELO SN4PR0501CU005.outbound.protection.outlook.com) ([40.93.194.12])
 by rcdn-opgw-4.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 20 Jul 2026 22:56:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OE0E8hTLwwBHVtmG6ZLH4NK2oPMPsd8xMBV1pGM3CvvQsWLaHIxMWcmMiNxysxyWPwUHLEkQaszkngW8rXoxTOD4MMkfzyoxjJTCGSumjzuvOni8u7ckXDtMnjnViT3fE7YyIwrzE2sXGW2SxzuoH3XmMSksC+ZhwtNpPwV+R5CQ1Qaz7V3cm5LgNVaxi9bKP+VksaWNS5ixF7hNm3n0zIZQWMVSOeb0FULSjPMggCYnq2+vsvzVk7O0wrq+oSnyvmwm78moLe/t040D/CqrlZopVOCejGB0WPipjtKGTXLhTpfW0Uu1sWFnv+Oc7KQVourOGGYiy8qp6GZu0Pbp1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ekkdJllbLgHKRuPDK5r0q63+3dK/iSJIawXZu54nDAM=;
 b=hA81M8EL4qUW7pjGG8lBfzKdGJB1bUnnhK+4wwvXPaWLcJrNmn2/OKnDIWA7Xs1zwe7vBmYNRyxj0cGtPxVulUbnRgD49awGL78Oirow3Xo3hAQGUuzmG9pZB3mQtyhyXDEBnHxVMU5EWm9hlWqmbadM0BMJ61SOwngG3WViRlEuKyZwCbcjIUCnCWQ7JiFWs8yDjfFiSGslvWZX5qqliPJSbqiXyNly46LwzIRQsCAw0H/sRX1PFl0e7FgIC2x0kg0uQIvcyQy3x3yGlBADt0/BplEO+twOCgLmgqVa+uOup4nC+l72wXP8oqc1OzvkTl6rF3sUqVDBcE1XiFNx6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from PH3PPF7A88A980A.namprd11.prod.outlook.com
 (2603:10b6:518:1::d32) by PH7PR11MB7122.namprd11.prod.outlook.com
 (2603:10b6:510:20d::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 22:56:00 +0000
Received: from PH3PPF7A88A980A.namprd11.prod.outlook.com
 ([fe80::6512:7c98:831d:3b0d]) by PH3PPF7A88A980A.namprd11.prod.outlook.com
 ([fe80::6512:7c98:831d:3b0d%7]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 22:56:00 +0000
From: "Hyong Youb Kim (hyonkim)" <hyonkim@cisco.com>
To: Alexey Simakov <bigalex934@gmail.com>
CC: "david.marchand@redhat.com" <david.marchand@redhat.com>, "dev@dpdk.org"
 <dev@dpdk.org>, "John Daley (johndale)" <johndale@cisco.com>,
 "ssujith@cisco.com" <ssujith@cisco.com>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH v3] net/enic: check notify set return value during init
Thread-Topic: [PATCH v3] net/enic: check notify set return value during init
Thread-Index: AQHdGCryGLLswzoiVEW5AenB2jvORbZ3BKWQ
Date: Mon, 20 Jul 2026 22:56:00 +0000
Message-ID: <PH3PPF7A88A980A884D92206420445FE4ECBFC32@PH3PPF7A88A980A.namprd11.prod.outlook.com>
References: <IA3PR11MB89877F0FA4E9EF63B478A201BFC42@IA3PR11MB8987.namprd11.prod.outlook.com>
 <20260720093338.92744-2-bigalex934@gmail.com>
In-Reply-To: <20260720093338.92744-2-bigalex934@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH3PPF7A88A980A:EE_|PH7PR11MB7122:EE_
x-ms-office365-filtering-correlation-id: 99705940-8f38-412c-b4da-08dee6b21160
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|38070700021|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info: wFMGVWzvkf/5bp/oG/glV2PBzBuzzyrMtHEVjQ0cFMDP9sLc0Qfm0KVIAIHxCBr3uD6mUQLJL3jAyd3oX5oPb81gW0eS5qaM9JyvDouw9TWfeXWbiN3NgyQD8Y9KkeBoqP84V2zGhAc0tW8XloARLGyRleTJjrt5hR+99u946Hp2lLXYZdWvk1J35abD399sWyHZ0d7Wad+IC3uLdSwvO3XpyDwv26zRMy3nwgHWuR4sY2fpVe20EYktpH1iTAxalsHjPEPciuhPV05FdDnVkHi1fGtGkB18YoHa4HI+YfX85tQFd/9jOzinmFz1gQjk7yvKArbuHGZF3Dx0zziwYpETum4rozxarDVeMmb4lwZ3C2C6iFmR39RM5m+4inv3QgoXbsM4zpiu2CsHOonewxoho2d+jaZrryTp3up6KAUjYcz0tWIGEmWABZO+fCNk9nW/t8gp60XnM4cUFth7909DPZlnhdmOB4aOrdj9pQNJfg4im3qN5NCp06Q7+/esg7udmYhg12jcdsEJqXmFKfHTrxcXHs9c38dseNBdNNztXTB2LEiC8HV6AXV/kYtx+YGs+juUcmTVx56O0H+s3i4binAzXpk+LJzJ5JgoSVGLnHux6Sb91NMfnwNu8ViLUqoW58/r+cXE60CpM2ZOgHNpTGHrxLxJOf1VCrEy2veA9BSuG/P+KMas1UujnbkwmW28YF2d0nxlYXIBAbWuJhIBD2dLbvwovbiXUo10mLg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH3PPF7A88A980A.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DlhlMZWIAWjKcQXGkkWG4eTv+m6eBgnqDLNMmUnRS8eANWgcj16tHf+yNPhC?=
 =?us-ascii?Q?Xeur82UNKVazTumvxaLJL87XqGOMIK1CpPIaCqU9Y0RO4PXu2+Hmp4aibwTr?=
 =?us-ascii?Q?8KKoBGQE4XsN78jMvTcmb7QiR0TX8f8rdggpjKdDlBk7pkUpeuTdi2XgB8uE?=
 =?us-ascii?Q?lOrhhmI9Q5hTUu+A3R9EJsLgZdabpxHBQNI4cSuZIzuts/Uny2nxp1fiqEIY?=
 =?us-ascii?Q?c4OnozY7iLSrbgsz0dRn/cBbnAI0UL8pMujfB5scbsf4fkIWCUBLQ/OYpLuC?=
 =?us-ascii?Q?JoPx5r3FtydA0gPMl1P8/Lgau9PzUd/5niSkPG4aUu13ZSgl66rr/Z0bWHz7?=
 =?us-ascii?Q?aXhRKmOL3L6yrpxZIjLENyILK+kEnVsrLItKZXJQqUtyJvvLeMdcwhtXYP77?=
 =?us-ascii?Q?CcqK0xfJvLM4MLuP/H/Ep7Z/NIOVuDmWmulq/GI5nYJaAWwIGyz9uKR3wdIY?=
 =?us-ascii?Q?mcRanX5pLIQLOxx/35sA7xP2vu8/GgkwIdriKxNmvwUTgkjwDhvaW5TE4Yz3?=
 =?us-ascii?Q?l+533RbI826WgTK5LG/2W7ZW4UYK/SF2rVvrFMJ4ovCC+FIseXc/VY6F5R99?=
 =?us-ascii?Q?toJpy/XnT6V636LHKcXHOKIdVie/MrFVm8szf+9qnhzQUdac00R3Jnl2rEpd?=
 =?us-ascii?Q?M7DL6Q2uHKlIEZLaeB0x6yOOijwX7EDyEuNNiGgA5Ik4wBwRr1gpO4rBmolD?=
 =?us-ascii?Q?M2qAIvA/fdcOH3fWLw/S11D4t1FWbMvu0uLtedG+GKVvAPqyGhAXgn9a+gmV?=
 =?us-ascii?Q?Ho/NfBVI9zz6KHoYhyZe1p8KzMpgUCFFpM7HO5RfgARUx2l0MDWyqtCC8+iZ?=
 =?us-ascii?Q?R9jXDGebb/dYIFw6l4m3yptqLf0jk9bigp8uSt6wXOoDopl72fCYAlJl/x9E?=
 =?us-ascii?Q?r4LICNS8EViBWiHKIENJ5v7fX+Ej7oyxj8Bpfe0Xy7d1SDSubrK83MZr+mnU?=
 =?us-ascii?Q?NCFz85NloHaKtepYhFFIshW9Ib8BEmgesXT/iyXqQa4Sd1UuW5XtoUOJK/fJ?=
 =?us-ascii?Q?cnAbCh6F2D0H/NztCXW8AH1cmw477IuQp0ubFWRjOxju9RonuoEo0VvpV6RQ?=
 =?us-ascii?Q?be76msimaZlzTDueGg3MsXc7mUq16I3m+YtTxcv2RUNHoAZgR6hxI76+SbuG?=
 =?us-ascii?Q?9oKTHuCKCZLBbgCJD+be7TsnDA8HkXOfFCb4erOe0t9OVYu13Z1VKt3rr6+4?=
 =?us-ascii?Q?E8/qiVuV/dlWQi1myK3AQ752ytkEqtv0E1of5AYqzE1Cw6RAIVAow4fFnmhw?=
 =?us-ascii?Q?TLsLLa4yeKiX/+fDKym2O+ic9BXV4nhBALSWTwv2MzcDPAWso17vfS0F1wQr?=
 =?us-ascii?Q?pgCEJkQqCRJ0NhwUsdlPsoFL+cXDfp7kUYEU3epMU02gSlvfzuDf15v4pnGp?=
 =?us-ascii?Q?BmaqrtN2l4cHbV1p4VKnJvcN5FMMV0ocum/tq+QxFrgGmDMXbRA4pObTMBm+?=
 =?us-ascii?Q?DdjVKjuKVpz2kCF7/5U9tkN1yQnAw+Jwhb1gVj3SiFGU09h0GGYWB29a0Ski?=
 =?us-ascii?Q?JcZWMdbNFtfCLqVbJJwbs+ctE0t4sZ4ssHUTNwcHQ6zfvHO8XDE84h+g9B2e?=
 =?us-ascii?Q?Ewy003ep9IO013atfETMd3+6dpJLUikS+JvOcaSG2qL0MizIEsj5nFi8nSWr?=
 =?us-ascii?Q?KUr/LPxKtL/CHiwoG5lEB7n8Au2F246GpDfNkMu9chPTXGn7dHsTxogrQ1z/?=
 =?us-ascii?Q?XW5dtQYGg8qdMhNPquDwIGIJR8eMZowT7KtGsG1ZEGLzNMo5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: M0nlHOyr/u6M1rsiOb1/BfXC6i1WmoksJNpUe6uK6TwTMMalpklNRlOKFgdVktqAr368IxZmwBDG4byxZwCShoxyVFUEsqxgvEp+wetJLvHLe9dkMkjvqPK7bVz4JNVaANqDcE/vp9KuzkMO6qI0Q2kNPB0+AaK9GZy3ZnYWOl/jlb4AqGSpIv7AIIy7QGSOei+AchpYTx4XEBn4fuScyyvYvq2RUwQfyG6kwUgfxD0ixaWLIbBOceSDzkLAiy9vZbUMFMaosL9Hbb8AovTQROx0+m5PIXAZoV+1Lu2LVCcspzP+mg5uCMigucfJkDt3CWns8s9F6uV5/oB2y49OOg==
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF7A88A980A.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99705940-8f38-412c-b4da-08dee6b21160
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2026 22:56:00.3170 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G2OjEhL478xRKcgpAJLeeCTMfYgmG/P3VaEqQGmMm84k8RhX931rGyNt5di8bfYZ+b4H8yBPSFLVQIoJOF/XXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7122
X-Outbound-Client-TLS: ANONYMOUS; rcdn-opgw-4.cisco.com [72.163.7.165]; TLSv1.3;
 TLS_AES_256_GCM_SHA384; 256
X-Outbound-SMTP-Client: 72.163.7.165, rcdn-opgw-4.cisco.com
X-Outbound-Node: rcdn-l-core-04.cisco.com
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
> From: Alexey Simakov <bigalex934@gmail.com>
> Sent: Monday, July 20, 2026 6:34 PM
> To: Hyong Youb Kim (hyonkim) <hyonkim@cisco.com>
> Cc: david.marchand@redhat.com; dev@dpdk.org; John Daley (johndale)
> <johndale@cisco.com>; ssujith@cisco.com; stable@dpdk.org; Alexey Simakov
> <bigalex934@gmail.com>
> Subject: [PATCH v3] net/enic: check notify set return value during init
>=20
> The return value of vnic_dev_notify_set() is silently ignored in
> enic_dev_init(), so a memory allocation failure or hardware command
> error goes unnoticed and the driver continues with uninitialized
> notification state.
>=20
> Check the return value and propagate the error to abort probe when
> notification setup fails.
>=20
> Fixes: fefed3d1e62c ("enic: new driver")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Alexey Simakov <bigalex934@gmail.com>
> ---
>=20
> v3 changes: add log message
>=20
> v2 link: https://patches.dpdk.org/project/dpdk/patch/20260715103105.39417=
-
> 1-bigalex934@gmail.com/
> v2 changes: validate return code of vnic_dev_notify_set() in driver init =
section
>=20
> v1 link: https://patches.dpdk.org/project/dpdk/patch/20260707112014.82821=
-
> 1-bigalex934@gmail.com/
>=20
>  drivers/net/enic/enic_main.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/enic/enic_main.c b/drivers/net/enic/enic_main.c
> index 2696fa77d4..2a1a65d8da 100644
> --- a/drivers/net/enic/enic_main.c
> +++ b/drivers/net/enic/enic_main.c
> @@ -1887,7 +1887,11 @@ static int enic_dev_init(struct enic *enic)
>  	LIST_INIT(&enic->flows);
>=20
>  	/* set up link status checking */
> -	vnic_dev_notify_set(enic->vdev, -1); /* No Intr for notify */
> +	err =3D vnic_dev_notify_set(enic->vdev, -1); /* No Intr for notify */
> +	if (err) {
> +		dev_err(enic, "failed to enable notify buffer\n");
> +		return err;
> +	}
>=20

Acked-by: Hyong Youb Kim <hyonkim@cisco.com>

Thanks.
-Hyong

>  	enic->overlay_offload =3D false;
>  	/*
> --
> 2.53.0

