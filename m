Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9113EC71157
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 13:56:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DD7C440E7C;
	Tue, 17 Jun 2025 15:56:44 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 12EFA40BA4
 for <dev@dpdk.org>; Tue, 17 Jun 2025 15:56:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750168603; x=1781704603;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=3aOqrk0WH0dhNjW+bk7EZRbgKUGi8gOSeGS/mUEWvnE=;
 b=ez+B7lfvCNrkDQ3pDkO+cnPnYx/PxGE3QcaNUtW8pAcOxeYHY1Jy/1OS
 yR+UtY6kzhEf7uvQOlscHFux/UfXebcHtWnToXFDUOcmMSsWzqvRS6q/F
 hhR9ej8cRWHoRXszovRWLRO04HzuTPNjLUmJaaFpJnq0Co6rlR/1c9VST
 v4jqWS6HesmAZkQfvOOZKymddc8r5q8t8DHAhTohC0fb3DUVfYNE/jxr1
 uIGUjmBDuAxsFcLd4e7B3aFlktNz3neIpH7fQuxR75R111Dj6oLqRRJEf
 GHCamH0Yzz5LBlhgB+C5UBSoM1RR1XVKQjiYIz3ivIgZQkJB19YrnH8DH w==;
X-CSE-ConnectionGUID: 2p/Ka7TOTBuewkchUirFEA==
X-CSE-MsgGUID: mrwkDxgBT3OhVQezjfHMog==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="52217971"
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; d="scan'208,217";a="52217971"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2025 06:56:41 -0700
X-CSE-ConnectionGUID: tCTImJ/0RGab64bbNNE07A==
X-CSE-MsgGUID: uX0UMB6lTgydgVu8MHjkvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; 
 d="scan'208,217";a="153988066"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2025 06:56:41 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Jun 2025 06:56:40 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 17 Jun 2025 06:56:40 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.60)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Jun 2025 06:56:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mVFWsZzvr7EXipcs8G/+ycBRKIcvkJDMMZ/1SMiA5nRjBpylKnpurVX3OnNQHBDBYnu+307rwmq4m20j7+XHhbFT8qqQKFc+DcVhbLpBmDMnc0cn5rkOS/2ZknG2hwQQnySZia5+YDIfopHofkcPvZPIBu+rzA8jACEBm0lMunbjvtUpEiZkxUYJc6jTFVyxye4z9qgzIRqyj91SAYYH2yQbZOymnjvCqFNHdUIYWvPf5PI+H44/+JPmdirpSpiNMxjzSfUDdpolA6b70buwgBw3PVNBHhjbRlnNnMMBcDlVdlocmGAqIRBpgVPIPdurtdr49HtkZ+HSf2N6up1jHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lGk6fz/slTklzkrgYPF3gMUkb/y/vu6RUE5EYviNuiY=;
 b=ZQTnvazSjjZADvw7/n83C1qJlacOYsWuhb/xJXpevyyKbhvVkTKr30iuiS5O5UOGgo61snbaLChbkYKdzuA2C5umwB4a1TiNoOHdt4XZU5/uIOSulVHgB4LG3hcCg28cJVCCoEHIiG2zTMES9zPUhuwzt40kfW6Nctgbh0XXwLXh5jLxCwDIhw7mYBrIWSTLfzumWl3hsmde7u79E5R6QFucXu0moKHsHuE7HDLkwjIR2Y8scC+TMWRqbnx3xKxE9bx7BfQEohHGgqryxng9woeYKulvpxItiwlavHTwdGY3UVePnROE3A4wcbl/Wj2wkB+cJXrkXOYllNJIOicUiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH3PPF37F43E35D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d16) by MW6PR11MB8410.namprd11.prod.outlook.com
 (2603:10b6:303:249::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Tue, 17 Jun
 2025 13:56:37 +0000
Received: from PH3PPF37F43E35D.namprd11.prod.outlook.com
 ([fe80::d6a7:781c:d71a:e817]) by PH3PPF37F43E35D.namprd11.prod.outlook.com
 ([fe80::d6a7:781c:d71a:e817%7]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 13:56:36 +0000
From: "Mcnamara, John" <john.mcnamara@intel.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: "thomas@monjalon.net" <thomas@monjalon.net>, "Marchand, David"
 <david.marchand@redhat.com>
Subject: DPDK Release Status Meeting 2025-06-17
Thread-Topic: DPDK Release Status Meeting 2025-06-17
Thread-Index: Advfj4qDzNJBso/SQCG7TeTTCVjZiA==
Date: Tue, 17 Jun 2025 13:56:36 +0000
Message-ID: <PH3PPF37F43E35DFC385A850AC6DA5FD23FFC73A@PH3PPF37F43E35D.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH3PPF37F43E35D:EE_|MW6PR11MB8410:EE_
x-ms-office365-filtering-correlation-id: 0cd70400-5c83-49d8-37c2-08ddada6c6c6
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?tLvrQj3MeqHzFUfo79sKzd/1Q++dqo9A8Zyl0zOkKKVhH2WNSY5of+Atb72i?=
 =?us-ascii?Q?X1wgcBO+JAbwJ6NMq/UJ5tRXjMKkgdNitIFC/Ch7YLiGWU8aZg2/0dFNfRIh?=
 =?us-ascii?Q?9aG7Y6A3QmKPO/tTyZVWGFWrTq+WfRxtNy1vQ5ICRXYXVO2X3g67hxiJ/RkZ?=
 =?us-ascii?Q?P4dxgjFcbOOF2XsmDYj0nYrMQ+CEF94tny45FxRBNmVnJv6sJBomfy2JVoNB?=
 =?us-ascii?Q?ZUW8bB4q0ViFl1X9QV5yBSmql0PBO3isX6fcqLfSbrlcXy2wzqr+cLfzVJMR?=
 =?us-ascii?Q?6XyMY6Q0IR86bgTPpHo2mNWF0vNWvuFjM6CVUEZJ2NaeYztCMZvN4qXCz2p6?=
 =?us-ascii?Q?IWnEMtW7YkDtUiZZCborXEdFsjgJfrWfPuVWZbFnkQQJHCiq43jpqvZp/jmb?=
 =?us-ascii?Q?HOywKpn7PYuuqtj1lOhHw6V5LkMPHxlzr+pqQnJkwE/OMtx+rOZsX31rzN48?=
 =?us-ascii?Q?MxNjnnlIM64yPQPlk3/GM+QfJijraZb3McF60y8BGB9zrpOMvwtbkjknvwx+?=
 =?us-ascii?Q?ieG+b5xTTu3oJ4E1s0soxI0V75Jc5COTdpErJVNGp9vWz6KTEmJl07MUfKPP?=
 =?us-ascii?Q?nU17X9Q69HfHUSeDcmKlz7wz1yEaduNFy0ypQ6ty9gjdE3iz2O9yujbcwb+U?=
 =?us-ascii?Q?wtf4BYtml/GPqS8uranOMakkmiK1LyANx6auG8XJ2M9nB7sivetLpSG2Swp4?=
 =?us-ascii?Q?Ne9RHdY0oPnUIJ4gKOWHvYIPjpy34DxtVyG75D83yyPrnELDyKN9NT9DWIhs?=
 =?us-ascii?Q?Or9yV50zfpbiSHnCjN1UNs/Y7x4Xdcv/zFjFZKRy0yAgwXPnMqN+Qgxd0RXB?=
 =?us-ascii?Q?O80w5K1c+wNFw2PXmfngN18amb0dMBKmX1kvGgIrpo9f+mmTQelCteDgPity?=
 =?us-ascii?Q?MeiYSi6Y9saPsL+dO+79+aBoSjQF1MJWAQJl4OJVlXY0e1X1lNOckaIwol20?=
 =?us-ascii?Q?/lOK5GHilFsSDNYvG1ECShWAhdZH3J08Udp/kdHog14ZBUOphaCTr+k/uSf5?=
 =?us-ascii?Q?LSi2pJoh2nx/zFUzuYiM9paWmd+SaNXt+iqf0TGpB1fcjLDMmpUy6H+QYTHb?=
 =?us-ascii?Q?gGtPVnqsIZNOBX6HMTi+W9Q0b9//7kOhWLBUdlUmJKzofk1oZaO9Uf7Chd3T?=
 =?us-ascii?Q?vA6Z6KjxfWeLlKr/cUEJemPuu2y1k8DFMZVKdd0Es1i0kaQr5vwxzZYKxaAN?=
 =?us-ascii?Q?KcN0v6ZZGTQILOsQm6fI10VCNl1UDQ6V7zYKSjXxIkN89HGGhiwunRE/MzcW?=
 =?us-ascii?Q?comAj9TdDHD6WG0VgKsIWW7IPqQbn9/YeN8KvXDZl1j8nWJbUPpbpcUoIupD?=
 =?us-ascii?Q?nXZUYKlvn9jNxHYAfloS3ggECDpHPCvP1Tb3/3vc3UVY68TcE/iW6QKYSy95?=
 =?us-ascii?Q?yzYocqPPn4mfECIlioaw7NnLxUbLBOlXmtGMAanyIc0cNMYAGLb/iWAyjOkG?=
 =?us-ascii?Q?sD7Scyd8DLLjMo+2Tm1Y0YkdehKXQCri?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH3PPF37F43E35D.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(8096899003)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Os4/3OSspWuh4pn8fR49D8GeCZxG2GJB2ZGtavwS0AKeDe+uVkqFQvLvECCk?=
 =?us-ascii?Q?YHmB07DDep0Eb23cIBVZHVBe4LIKpiXVvfli2z0FgIQWOpqo0atiyuuXZC5I?=
 =?us-ascii?Q?og2cvq5Ni2Ay7EEWdHxHUh3Us2xmlJbmQhJo6+az3TrXppd/Ieag31h5XChL?=
 =?us-ascii?Q?263TpvNSvkB+qAcpnAsCNdJ/TdXPOPbnjFX/2xb8Z17kfwEcho0e633paScw?=
 =?us-ascii?Q?pbXZRmhDU+Q1twmfoebRxKcR7mqwZDFWBmzjPRI/8sWa0FjSWJIiGmWtZW8h?=
 =?us-ascii?Q?kLKCaVSfaRizrL9HUjpPBJaQR2f2/6Sv6SXKZm1IlI226gNYY5ktWlWu6bAN?=
 =?us-ascii?Q?JB66q5CkkWN7rcQsXq8lmEbEv3aJUI/T1eesJToFg6Yye5NJtjXB9ICbdEbT?=
 =?us-ascii?Q?PIFhK74Nac+dGAatfRlPClCXTvJWQ/8vxWy+WsUitCXjxDkSvC96EIACedq9?=
 =?us-ascii?Q?cBgb48OGEIHm1NPI6dOJqF51fDoVWPS1BjxNnoHRnX32IqC/ZNjxNWlS7d5n?=
 =?us-ascii?Q?wuLVi7w1nc62sO6Z6om1Ong/wUI1R5SpcFGd3TR1pE6XXHT+kOMTCDAWOE1l?=
 =?us-ascii?Q?CZepNDwOom7QZCFchBSReMtZfqGKnJs1uKA6pvg0IMcAq+nBk9bb7IDnK4a+?=
 =?us-ascii?Q?KGIvGcilvUXmr9ypJHggo1uaM1OgsH9s0AqPcxLFcDmGDUDHUyOBi0LBcAi7?=
 =?us-ascii?Q?wXBNXhETNM8WbARMAZACVGmsCokkFl6OzbhkgH78gQNM40c+gvrAB8pKBHeP?=
 =?us-ascii?Q?nfmavJeN0S5rYh1GVLksNrlLPE4svtfm7pDZq27EzERrAJ1pmacmVW36PWnr?=
 =?us-ascii?Q?pDgvWQ5h6ieGi45ANTEu7J4NiWVaP4ZHGmtS7iGPrRqpDFNVrACAuJbRlGfM?=
 =?us-ascii?Q?sA5FzAQ5bRsHyphq42IDxdn29XXIo7NB8Mx6BagbsKgoYCk6LbSHW657T10m?=
 =?us-ascii?Q?v3H/fu3gq3Un8n4TM6LsdAI7vdvih2S1C3GaRsA5jYC5mab6uU3D0uYBaHem?=
 =?us-ascii?Q?um2c+3diOjfCEcKZDGim89Hzd6ErneoAHYJd1q2pwefrm4WbUDLz9IGYngPg?=
 =?us-ascii?Q?0+F8DSOEdlA3aYHzs4e9sizX23ca1LJnYor05HCP7/Y3muw+u+HvRvZMbs3J?=
 =?us-ascii?Q?db3GQOoFUpCXW0VDn5XCUVnAYfrHM/Klc615r9d1VoZUS0sZD8BhRDNBQuq+?=
 =?us-ascii?Q?Ws72VeR2yKhPpu9J0rZ0rBGAK2Lu4CucNZBC309lCM0kB8e3G1tTng3s3nqr?=
 =?us-ascii?Q?6fUVfyNhrS+XVh6UXqu5xObsETPyvt2fxRk4IiATkFAVeTnuXLrRzsuMgs40?=
 =?us-ascii?Q?W3RBif/xfEwNzVLajavxVT3IA+P9Pl6TXC4T9GIAHmp/91iDC+PNmTIkahBR?=
 =?us-ascii?Q?c4zRfGYrf4/C4CPm/1BuWQQ20Yk37PtIaTSUGjx7Qbo2HZMNhvBZxPRtdzI7?=
 =?us-ascii?Q?7KQW8m+zobsfVPhqUTOzFyfQN+qySXCtVgX8pVsc0XKELVwWaX8Po2GboP+f?=
 =?us-ascii?Q?auc1FnMyeaePfwG1Az/tco8eS5kg5KCNrRsGazr7X+zfPJlcuaHMXxFdwxUL?=
 =?us-ascii?Q?4WM0zNAuZiWJfYGZrYWImBNk0iRqTG7Kgvv6rNBX?=
Content-Type: multipart/alternative;
 boundary="_000_PH3PPF37F43E35DFC385A850AC6DA5FD23FFC73APH3PPF37F43E35D_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF37F43E35D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cd70400-5c83-49d8-37c2-08ddada6c6c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2025 13:56:36.7268 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F/mCkrYgQlo7VnbiMmETX9eMWxFR51st5+tbe4AVhE/KJ8Lc86KuM6iEAZENYud+HEb3HsqNddPJvbn+xTfMJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8410
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

--_000_PH3PPF37F43E35DFC385A850AC6DA5FD23FFC73APH3PPF37F43E35D_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Release status meeting minutes 2025-06-17
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
* Debian
* Intel
* Marvell
* Nvidia
* Red Hat


Release Dates
-------------

The following are the proposed working dates for 25.07:

- Proposal deadline (RFC/v1 patches): 20 April 2025
- API freeze (-rc1): 16 June 2025
- PMD features freeze (-rc2): 25 June 2025
- Builtin applications features freeze (-rc3): 2 July 2025
- Release: 11 July 2025

See https://core.dpdk.org/roadmap/


Subtrees
--------

* next-net
  * RC1 released.
  * ~70 patches in review.

* next-net-intel
  * Some patches applied, post RC2.

* next-net-broadcom
  * No updates this week.

* next-net-mlx
  * Some patches in progress for RC2.

* next-net-mvl
  * No updates this week.

* next-eventdev
  * No updates this week.

* next-baseband
  * Tree has been merged.

* next-virtio
  * PR with some fixes ready to be merged.
  * One patch set awaiting revision.

* next-crypto
  * 20+ patches to be merged. In progress.

* next-dts
  * 7-8 patches queued for merged.

* main
  * RC1 released.
  * RC2 in progress.
  * Looking for a new maintainer for eth_dev

  * DPDK Bay Area Summit - Santa Clara, CA
    https://www.dpdk.org/event/dpdk-bay-area-summit-santa-clara-ca-septembe=
r-17-18-2025/


Other
-----
  - None.

LTS
---

Released LTS versions:

* 24.11.2
* 23.11.4
* 22.11.8


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


--_000_PH3PPF37F43E35DFC385A850AC6DA5FD23FFC73APH3PPF37F43E35D_
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
meeting minutes 2025-06-17<o:p></o:p></span></p>
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
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Debian<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Intel<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Marvell<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Nvidia<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* Red Hat<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">Release Dates<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">-------------<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">The following a=
re the proposed working dates for 25.07:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Proposal dead=
line (RFC/v1 patches): 20 April 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- API freeze (-=
rc1): 16 June 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- PMD features =
freeze (-rc2): 25 June 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Builtin appli=
cations features freeze (-rc3): 2 July 2025<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">- Release: 11 J=
uly 2025<o:p></o:p></span></p>
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
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * RC1 re=
leased.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * ~70 pa=
tches in review.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-inte=
l<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Some p=
atches applied, post RC2.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-broa=
dcom<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * No upd=
ates this week.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-mlx<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Some p=
atches in progress for RC2.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-net-mvl<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * No upd=
ates this week.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-eventdev=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * No upd=
ates this week.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-baseband=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Tree h=
as been merged.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-virtio<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * PR wit=
h some fixes ready to be merged.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * One pa=
tch set awaiting revision.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-crypto<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 20+ pa=
tches to be merged. In progress.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* next-dts<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * 7-8 pa=
tches queued for merged.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* main<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * RC1 re=
leased.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * RC2 in=
 progress.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * Lookin=
g for a new maintainer for eth_dev<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas"><o:p>&nbsp;</o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp; * DPDK B=
ay Area Summit &#8211; Santa Clara, CA<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">&nbsp;&nbsp;&nb=
sp; https://www.dpdk.org/event/dpdk-bay-area-summit-santa-clara-ca-septembe=
r-17-18-2025/<o:p></o:p></span></p>
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
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* 24.11.2<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* 23.11.4<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:Consolas">* 22.11.8<o:p><=
/o:p></span></p>
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

--_000_PH3PPF37F43E35DFC385A850AC6DA5FD23FFC73APH3PPF37F43E35D_--
