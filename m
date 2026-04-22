Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6725CF94CDE
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Apr 2026 08:22:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 916D640272;
	Wed, 22 Apr 2026 10:22:03 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 46D9240144
 for <dev@dpdk.org>; Wed, 22 Apr 2026 10:22:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776846123; x=1808382123;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=9DZkcofBH0+i3oorL9WaZvQ/5iuT8FmjVVNp+hSoFLw=;
 b=ElCSEQqXfR+PcQhSldnsOLynHmnNVJhTL9oI3Zc0jcC7gwfNwBnArU1D
 /ZJO3ujRaiPvfD+iaw/p8LOWGhbapnuQxU1wH7uwukmQNkFvhOWEqeuoU
 PCrEijirV+FppazEMYGUzIV6aWl/73poQJ7+hAwfD9uMGYVZOUhJx8dAr
 YT8oDuEoK+rlieEC+EpGfSvZC7PGT1pDJuRmuvUj4u31OYQlhOBeAlI6P
 ISSRdymqqOV3QjScdhNd0AQ7irOt1v4YTzTFbhaHbTodjZFyTOX8Nd3hw
 s6kSNOPAU6sPXukksbvSnTuY91zrZLfGILyJj3hu0pNvet01enYKYkwXw g==;
X-CSE-ConnectionGUID: TwB4nCDwSseIOxPQ65vz4g==
X-CSE-MsgGUID: JiYci4TBQICTEXFdb81SOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="77707764"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; d="scan'208,217";a="77707764"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2026 01:21:59 -0700
X-CSE-ConnectionGUID: taWfSHX4T6ilXWEElrPRKg==
X-CSE-MsgGUID: CaoeMZ7HTd2SX81L1Aqfsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
 d="scan'208,217";a="234079115"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2026 01:21:50 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 22 Apr 2026 01:21:50 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 22 Apr 2026 01:21:50 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.51) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 22 Apr 2026 01:21:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LcHCco6rDwmopRrhypgJZvQAW2C38UmUCsgVZM6JGn3HfxG1148/lDj7xEVJIch3z44TXua6k06XT25oqWZCH804A/3PhQ2tZCUdKhWiMHQzUDdkAPabeADUEhC/N/t3SYd5Vfxxe61lAV3h2uAILKNlH969idHwXqm2IEsTahJ25EcEjkF/ws7P6+1XjsxJ9p11kAdrB0NHFnly1zku2Zj783mU5KRwcN8VPlH8w2JEepzO+beUXKTjGlMVgYLBHcWUQ6RjILcf7uf0fGiE/U2u6YTjeWHMpz3bkFk54R2LhTnlOz7rAKplzZPtTBehuAfXRIFs/SPI6+3s9xBkvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9DZkcofBH0+i3oorL9WaZvQ/5iuT8FmjVVNp+hSoFLw=;
 b=RZAAWn3aJMbhW2L1bXiWk+V0o0AO77ROEmwNBCXjgsT7HjoGet+1nZf/9vievRgpKgsN+KnoCcxRqrqbCPPi4jwArGJuMtLy8IEsaSAttKfQ0CkqatHPtRj9sZjkqC9BdPpeeFJT1eXJEmG9xkp/IaQh0ajfkNi548dvLjJ/pZKYqySFVndNPn9nKrqNMpHLhagZlxxQDevt8N66km32o43nqiHAZFni+thwvyniu1PIae2I8KRjbr52oTYN0x4vlvpmz1ht/R7m8zFQUyG6ZARL6wZU/Ktl3RG4V1oAXD8qgGgr5/evCM5ElvuJCFxX1W5K9zDtEeacHuJNTieWkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6318.namprd11.prod.outlook.com (2603:10b6:930:3e::5)
 by SA1PR11MB8351.namprd11.prod.outlook.com (2603:10b6:806:384::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.19; Wed, 22 Apr
 2026 08:21:47 +0000
Received: from CY5PR11MB6318.namprd11.prod.outlook.com
 ([fe80::f4a9:9b9e:f0ee:84e]) by CY5PR11MB6318.namprd11.prod.outlook.com
 ([fe80::f4a9:9b9e:f0ee:84e%6]) with mapi id 15.20.9846.016; Wed, 22 Apr 2026
 08:21:47 +0000
From: "Mcnamara, John" <john.mcnamara@intel.com>
To: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "Xu, Weihua  (Altera Corp)" <rosen.xu@altera.com>, "thomas@monjalon.net"
 <thomas@monjalon.net>
Subject: Re: [PATCH] raw/ifpga: target main tree not next-net-intel
Thread-Topic: [PATCH] raw/ifpga: target main tree not next-net-intel
Thread-Index: AQHcyClfxytvWzefn0aO2gNjRQycuLXq0bek
Date: Wed, 22 Apr 2026 08:21:47 +0000
Message-ID: <CY5PR11MB63183599D36796F0202F45A2FC2D2@CY5PR11MB6318.namprd11.prod.outlook.com>
References: <20260409140023.462128-1-bruce.richardson@intel.com>
In-Reply-To: <20260409140023.462128-1-bruce.richardson@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6318:EE_|SA1PR11MB8351:EE_
x-ms-office365-filtering-correlation-id: 7830de26-06f5-4db5-0ffa-08dea0483262
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|8096899003|18002099003|22082099003|38070700021|56012099003;
x-microsoft-antispam-message-info: V1DSKbF9+bWThwg/nLlTfG1SaGQUqOq9rosG/YicJvCKgHCWsSltI4T1bkfDl0OL2g3f0XIsoBeb0yNq5Nw6KbRvbhFfLhDgsDDAQy90XH+ZOU1UsFKN3W9uQpBSpe4R4w7RxEuXPD10tBW/gt+nAE9EIwF5hqDLTtbnCbVnbGq+Q5QC3YHfQeTWhoBbUglECCtCyr73/cHaPGvBh4GFeYHBZtSB/JE75p6CwGtD5HHgGW/ezDi0MW6QI4lA/QOoxsdbkjV375Jbh+4vCjPznRR0sKqYQFxQxS9JVCKiXmNP95Kkz5n9YWov5uuIa9spcuKXXMvdFufxRdh2g4RSlNr3+Vj7wHe+ouYqNUFRrTbfZWsP3x0MnW3lExpaezxd2U1BhyA83YG+oWuTgvFcY8iL7tg3Nb1AUudpUZ9Jb/mfjsr5q1CyXj6oszyDK2GJ+ZLsaxiP3xlglfGN247rtQu3AbOr0vU0jumc5uDaVynsniFod6JLBYbp+uSQcUYkDrYMS1DhXQyv9iRgqhAQJfjMwV2r8vEHEay3HYmaEeVnYlf7pWg9qfX7K3X1lobKYlE6BlasQCn7sYH7QuR4nx7dzAew5coH8uLBM1WuvBODxhQ/kDH7pMP69koZ/X7Yjq3pXCs4AqZ/mEbLFXnPpc2KqFnLhaR9iAdSRNKSn6DCfPWj+PkfJyToc9xtOdnr5xjxcz1+YBck4eYDj8d5VhnpfZCck9tDxcz29dj+gpGBUZN4hZvxrYiRQjE/uiUF8mqzBn5rMUZdkDV7xw7Mppib/a3YBAP3cz1z7KHjK1s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR11MB6318.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003)(18002099003)(22082099003)(38070700021)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?vE3fZp4Hh6Jh4QLwdnvxCKB/umeLvDzMFSQrrV5lAYT13Kok0Up0/6frkN?=
 =?iso-8859-1?Q?VkoHlhktmSFY1vQK62UZ9VF9mSZ5rGhCuAHFJHjIZKRFYezJldNO1V/iRO?=
 =?iso-8859-1?Q?jWjS0xHXGOmRv+Zvj4BWxqS04En8bvZXGr48Hg0gUaWH2qsYrHsG+U3GCx?=
 =?iso-8859-1?Q?nkmnZLI2ed1fRSG/vYVhdd0JiR2HVXgc4u+HnkkHkIb4D6IhlvKSSQFh87?=
 =?iso-8859-1?Q?hJpyW0aai7UekMpD8HgEGDItoPTUcHDWFuNXxOYjHMXSr5cgigq/sXdiCE?=
 =?iso-8859-1?Q?qCoIvd2dGeuPbhn15+yRiOJPHdc9f2o7BIV/7X50kTHCsUz2uT5NkpPoHH?=
 =?iso-8859-1?Q?RCAvGfPNqima9vSGRuf2QpTxNZD4HSkd2mCBZkzEfEzbivuX+ZoggVOOcX?=
 =?iso-8859-1?Q?0aPoz4h2b4p1Ss13PAm2mQ2wW+ViL6BDZ1PWpl8U3Q4qZv2V8xqZbcQYYp?=
 =?iso-8859-1?Q?BELwtz0uMQjUl2BFcSS0C9cB8E0ob/Mb5v6q1/XxRzCCMIR1Ri3rc6yK32?=
 =?iso-8859-1?Q?54mDZwlDkOVWRNnJN0yyzp+uDRJ3IqMT1EshXqe0FtZJV3FdThqK09JVHv?=
 =?iso-8859-1?Q?RDpoBOouxtRCO9LLCsrqa+BM81uqTipFphY60omJHDjRgWXCr5Qh+Ew+Hl?=
 =?iso-8859-1?Q?FbRn5k9Rek4xOIlS/A3rHU+LUWxg1GtSxm5+jFmuDC7gFajJgGov9gcqak?=
 =?iso-8859-1?Q?FBAKGX94F4EQvN9oUTvsULga77NDTFgXERnsEPDvzf2PEglsxty0pl+WrX?=
 =?iso-8859-1?Q?VfUldau5lAX0wU3FyL1rzyOvMaBTjrjS3W1x5KVNxxDmO2eIoAoGe63daT?=
 =?iso-8859-1?Q?XRx7EadvQSEydDLSpCiXNyEcsD3h+rSQiSNht9aNcd+VtRH+hGCv6w4guC?=
 =?iso-8859-1?Q?rwDJ/MsD2Iuhp9Whqa1cvMF64w6bho+ttgZ0DTxBBWIoEIm5AWx1dJWtY9?=
 =?iso-8859-1?Q?Bt3wExWqEHy5p3xXgtDs4Zwym9fYejhKbU9hWGDLYhrvp7I/bhz0EuSgMP?=
 =?iso-8859-1?Q?Lc+3cFttcKpwEzeFfaGtyeprJMSDcs6rmJmmA31QKPX2mQnGQBB3ZohoCU?=
 =?iso-8859-1?Q?1hpTTkTTfd1x+beArCiMa75AG56WKU1QFAragq3wZ/MRdqe9Ve8RNzkc+Y?=
 =?iso-8859-1?Q?/IrCf1LK74aba8PINjDU0b2tD+oPqYfRBkBgJVNY4EJsf+F1GQd0anESKH?=
 =?iso-8859-1?Q?+P0tyEDG1MAjB7+d4xWHxxcW+Pqb2BXa7gmuWcrCmwuvWDMOOgDSFf0kAN?=
 =?iso-8859-1?Q?P+PlKtodeH1dBpXjKGCn7VDte58KTaXlPX7ap3V9/0xUC8gIWqOG7qeCPq?=
 =?iso-8859-1?Q?whpFohnDRVUOiDrD1iIZlFAzIThIKy1Bu7Ot2/OESaLEIAidP2cpzdnhhA?=
 =?iso-8859-1?Q?BVKzZiYb9SeRi08Xb1BvN81jPFcKI5g7iTTryKtakaH7u8/CEBU/3Zy3FP?=
 =?iso-8859-1?Q?cysBOELJ9CnQR8v594U/mciCyL0Ne/c0C3BNmjEXbZpZh3T/jqI/W0tzwc?=
 =?iso-8859-1?Q?CNghUZafwQvugvRLpJSWWUDKnkerfWFB1rEmsPuYx+vPUvMMU2kgolquwD?=
 =?iso-8859-1?Q?woMc4TLnP7GI7K+Cp4tLwbZECzsM8Nu2aLmNv2oy5MWbR7loFvdzE2rVoT?=
 =?iso-8859-1?Q?UsX4PEBD4dlyKTNzsjK/W8yx6NbepTu+6I/tXOkF6I7DeUPTrBJEcoIwdg?=
 =?iso-8859-1?Q?MK3eeIussAMaRxybBfL96p7NzhPbdG6GZGDrz0UFt4J7g8vNVixtgxIBl6?=
 =?iso-8859-1?Q?6J7B442Xv2bGDBceIOx8LYyQTE5IXY1H1vlzWuW1FYZneXI8wm0azBmEPS?=
 =?iso-8859-1?Q?3hkRyVRL0w=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CY5PR11MB63183599D36796F0202F45A2FC2D2CY5PR11MB6318namp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: vnWWU3O6IMWKPH+8qBncDS3BNVzovi+plqGGFxHSmvOkQSUKki8wmz1FovXz/cJvJ0spLe5SG7pmZ1AT11k9Y38FeSZdKMiXJ/QvZ7K/J7HFA8M/iYzVZZGxdhmiG4K0i+F4+38dnKmZ4Dkk8TKosVTNhqSecTZygkOCBwIbxBkV7nbTDiWfWjai5KtGFwXyerlxmE4v5brPG4z1ySmXHB25iKf8At2scUwEU+vI90RK/MKSwzFzYN3G0CuWWYTHWqMGj4bwVgiXqdiyPTk8+88X9Fu+3dSxkB5jTi+xTBcpBoXWKIFdlvRw+WbxAOPdq6UlrvyVpgDIOQ1I5gpKhA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6318.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7830de26-06f5-4db5-0ffa-08dea0483262
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2026 08:21:47.6507 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y9EEhDt2eSLz4tC3qqtayO4/evcSrKtcK/HxfdgrCVAaZCLL1ADkP6sOa1hKjIg7D1Zi/RglEDUGsopKv/VVQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8351
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

--_000_CY5PR11MB63183599D36796F0202F45A2FC2D2CY5PR11MB6318namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable




________________________________
From: Bruce Richardson <bruce.richardson@intel.com>
Sent: Thursday, April 9, 2026 3:00 PM
To: dev@dpdk.org <dev@dpdk.org>
Cc: Xu, Weihua (Altera Corp) <rosen.xu@altera.com>; thomas@monjalon.net <th=
omas@monjalon.net>; Richardson, Bruce <bruce.richardson@intel.com>
Subject: [PATCH] raw/ifpga: target main tree not next-net-intel

The raw/ifpga driver does not belong in the next-net-intel tree because:
a) it's not a "net" driver
b) it's now maintained by Altera

So remove the line in MAINTAINERS targeting patches for that driver at
next-net-intel tree.

Acked-by: John McNamara <john.mcnamara@intel.com>


--_000_CY5PR11MB63183599D36796F0202F45A2FC2D2CY5PR11MB6318namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<div><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;Bruce Richardson &lt;bruce.richardson@intel.com&gt;<br>
<b>Sent:</b>&nbsp;Thursday, April 9, 2026 3:00 PM<br>
<b>To:</b>&nbsp;dev@dpdk.org &lt;dev@dpdk.org&gt;<br>
<b>Cc:</b>&nbsp;Xu, Weihua (Altera Corp) &lt;rosen.xu@altera.com&gt;; thoma=
s@monjalon.net &lt;thomas@monjalon.net&gt;; Richardson, Bruce &lt;bruce.ric=
hardson@intel.com&gt;<br>
<b>Subject:</b>&nbsp;[PATCH] raw/ifpga: target main tree not next-net-intel=
 </div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-size: 11pt;">The raw/ifpga driver does not belong in the=
 next-net-intel tree because:<br>
a) it's not a &quot;net&quot; driver<br>
b) it's now maintained by Altera<br>
<br>
So remove the line in MAINTAINERS targeting patches for that driver at<br>
next-net-intel tree.<br>
<br>
<span style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService,=
 Calibri, Helvetica, sans-serif; color: rgb(0, 0, 0);">Acked-by: John McNam=
ara &lt;john.mcnamara@intel.com&gt;<br>
</span><br>
</div>
</body>
</html>

--_000_CY5PR11MB63183599D36796F0202F45A2FC2D2CY5PR11MB6318namp_--
