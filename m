Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D24C44501
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Jul 2026 00:40:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B492402D9;
	Thu, 16 Jul 2026 02:40:50 +0200 (CEST)
Received: from rcdn-iport-3.cisco.com (rcdn-iport-3.cisco.com [173.37.86.74])
 by mails.dpdk.org (Postfix) with ESMTP id B2CBD400D5;
 Thu, 16 Jul 2026 02:40:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cisco.com; i=@cisco.com; l=2035; q=dns/txt;
 s=iport01; t=1784162448; x=1785372048;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=KRqtpy1HPagI5RBIwC/Xtlv6RlX+SAMBnMiU0XXk3MI=;
 b=Kg7xJW87eB7pv8PBo0wNKiiR+lEuvrnc4y82Zfeoxa+U/1t5fbI/S93q
 XUGWb41BhMhs86L/y3tmsfmf9woVSa9/jKJslf0FvLtASay04E419tzfV
 C/idoIXzoh02JTF6P7iy5wAIwv98oMgSMioHt7VqHwkzQjji9+8xc+GO5
 efHHw4q1NDFHrfny/+WaLY8z7uMVKikV/9LgDj8YNrWNkT8GfRDSkSRZJ
 sYmk+2yGfgy0tUE+kFFPHMtkirNx21WzPe/PxlXQ7l7STsvwwyBZNWeLR
 CYVUuLz4k9pxr7NP5wJuIHU7VeMGGs0OBf1d+/ircRlWFm9rADfM9/ip1 w==;
X-CSE-ConnectionGUID: kzfAYYvSQtiYegr37dHcTw==
X-CSE-MsgGUID: FBvZYZ3OT9OHH8VH8RIv/g==
X-IPAS-Result: =?us-ascii?q?A0AEAAARKFhq/4z/Ja1aGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBZYEXBQEBAQELAYFtU4EKgSFJiCMDhExfiHkDi2SSN4F+DwEBA?=
 =?us-ascii?q?Q0CPRQEAQGFBQKNUAImNAkOAQIEAwIDAQEBAQEBAQEBAQELAQEFAQEBAgEHB?=
 =?us-ascii?q?YEOE4ZPDYZaAQEBAQIBEhUTPwUHBAIBCA4DBAEBHxAgER0IAgQBDQUIGoJhg?=
 =?us-ascii?q?joDECcDAQIOsUMBgT0Ciip4gQEzgQHdRg2CXgYUAYE4AYU+gn0fAQGEPIEhA?=
 =?us-ascii?q?Rk7hEEnG4FJRIFXgjE4PoIfgWs7hBOCMASCIoEMg1iCBYwlUngcA1ksAVUTF?=
 =?us-ascii?q?wsHBYEeEDMDIAovLQIUDSIPBBYFLR1wDCcSDx0XFh5YGwcFEiAqQUUjAxRRL?=
 =?us-ascii?q?xA4C0MFgVYCgghOIx8DOX+BMHVKdy1pAQIQF2xBJIIUgTsDC209NwYOGwMEg?=
 =?us-ascii?q?TUFjU0lgj8BegkKLFAzFZRCk32eaXEKhB2MIY8+hjIXqmyZCCONZ4QJkW6FF?=
 =?us-ascii?q?wIEAgQFAhABAQaBaDyBWXAVgyITQBkPlzaKKgG+fHkCOwIHAgcOAwuRaAImB?=
 =?us-ascii?q?4FPAQE?=
IronPort-PHdr: A9a23:gJxt2hMG/jjx1o8xi4gl6nc2WUAX0o4cdiYP4ZYhzrVWfbvmptLpP
 VfU4rNmi1qaFYnY6vcRk+PNqOigQm0P55+drWoPOIJBTR4LiMga3kQgDceJBFe9LavCZC0hF
 8MEX1hgl0w=
IronPort-Data: A9a23:y/jUnKhQOHX4UfWu+E2x42jiX161NxEKZh0ujC45NGQN5FlHY01je
 htvCD2Baa2DazHyed5zbYyw8hxT65LWzYQ3TwFornozHnljpJueD7x1DKtf0wB+jyHnZBg6h
 ynLQoCYdKjYdleF+FH1dOOn9SUgvU2xbuKUIPbePSxsThNTRi4kiBZy88Y0mYcAbeKRW2thg
 vus5ZeCULOZ82QsaDxMtPve8EgHUMna4Vv0gHRvPZing3eG/5UlJMp3Db28KXL+Xr5VEoaSL
 87fzKu093/u5BwkDNWoiN7TKiXmlZaLYGBiIlIPM0STqkAqSh4ai87XB9JAAatjsAhlqvgqo
 Dl7WTNcfi9yVkHEsLx1vxC1iEiSN4UekFPMCSDXXcB+UyQqflO0q8iCAn3aMqUb6OheMFBQz
 sUEKQEAYQrY2O6Wy46kH7wEasQLdKEHPasFsX1miDWcBvE8TNWbGOPB5MRT23E7gcUm8fT2P
 pVCL2EwKk6dPlsWZg9/5JEWxI9EglH/Yjpeq1OQjaE2+GPUigd21dABNfKII4TVFJoLzxrwS
 mTu0U7nMCAob/ujmB2l0iKSpr/1vD28V9dHfFG/3rsw6LGJ/UQfBQM+WUO3or++kEHWc8lDI
 kYQ9wIitaQxskuxQbHAswaQunWIuFsYHtFXCeB/sFrLwavP6AHfDW8BJtJcVOEbWAYNbWVC/
 neCnsjiAnpkt7j9dJ5X3u78Qe+aUcTNEVI/WA==
IronPort-HdrOrdr: A9a23:oP8gBagu1TLIq+gJ+Qkkxq1uoXBQX9V23DAbv31ZSRFFG/FwyP
 re/8jzhCWVtN9OYhAdcIi7Sde9qBPnmaKc4eEqTNGftXrdyRqVxeZZnMTfKlzbamHDH4FmpN
 1dmsRFebnN5B1B/LnHCWqDYpgdKbu8gd2VbI7lph8HI3AJGsRdBkVCe3qm+yZNNXB77O8CZe
 GhD7181kKdkBosH6OGL0hAddLu4/fMk5XrawMHARkI1Cmi5AnD1JfKVzKj8lM7ST1g/ZcOmF
 KpryXJoomzufCyzRHRk1TU84lXn9XZzN5CDtyni8QeKDng4zzYJbiJXYfsgBkF5MWUrHo6mt
 jFpBkte+5p7WnKQ22zqRzxnyH9zTcH8RbZuBylqEqmhfa8aCMxCsJHi44cWADe8VAcsNZ117
 8O936FtqBQEQjLkE3Glpr1vlBR5w+JSEgZ4KkuZk9kIM0jgXhq3NUiFXZuYdM99eTBmdga+a
 dVfZrhDb1tACOnhjjizxpSKZqXLzQONybDZFQescqI1DUTtnV4w0wEgPE7pB47hcgAo10u3Z
 WZDkyu/4s+E/M+fOZzAvwMTtCwDXGISRXQMHiKKVCiD60fPWnRwqSHq4ndydvaMaDg9qFC0K
 jpQRddryo/akjuAcqB0NlC9Q3MWny0WXDoxttF75Z0t7XgTP6zWBfzBWwGgo+lubESE8fbU/
 G8NNZfBOLiN3LnHcJM0xflU5dfJHECWIkeu8o9WViJvsXXQ7ea/NDzYbLWPv7gADwkUmTwDj
 8KWyXyPtxJ6gSxVnrxkHHqKgXQk4zEjOVN+YThjpwuIdI2R/9xWyAu+CGE2v0=
X-Talos-CUID: =?us-ascii?q?9a23=3AKCQI8GmBgnooavhLeg7a0fQ2+xDXOX7Pwl7hElG?=
 =?us-ascii?q?DMHpoebCaUwTP9INvr9U7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AsiLnVg578iPXkiRCjje2WFgSxoxGybqcOXJWtql?=
 =?us-ascii?q?XnOmkZRJQaw28knO4F9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-l-core-03.cisco.com ([173.37.255.140])
 by rcdn-iport-3.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 16 Jul 2026 00:40:47 +0000
Received: from rcdn-opgw-1.cisco.com (rcdn-opgw-1.cisco.com [72.163.7.162])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by rcdn-l-core-03.cisco.com (Postfix) with ESMTPS id 54AF9180001C0;
 Thu, 16 Jul 2026 00:40:47 +0000 (GMT)
X-CSE-ConnectionGUID: Vkc8BwE8Q/OUiOh50HJc7w==
X-CSE-MsgGUID: 6Zpa1tVmT3i6a6080LkFOQ==
Authentication-Results: rcdn-opgw-1.cisco.com;
 dkim=pass (signature verified) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.25,166,1779148800"; d="scan'208";a="64785426"
Received: from mail-southcentralusazon11012054.outbound.protection.outlook.com
 (HELO SN4PR2101CU001.outbound.protection.outlook.com) ([40.93.195.54])
 by rcdn-opgw-1.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 16 Jul 2026 00:40:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PBfyGgDoghbtXw5iuG20SjyMPiNZk8rIFCDYIMna1n+JiyxZdEN7LHXzmc5Iph7CC0uL/fowXgFC15Rk9Wic4NkQK9sp5dKJ26grlouKzG2uqnhlrMFXv5QufP+jTFB0mJqJlQKKxIL2pWX/hCwtEbfYPA/N8rpawpm3KHL8Ez1TVHUL2ZuhZMzbu6l3NbUrtdKrVFWK85bAFmYhRtb//ZVgBFTmWL2Mo1jbV6sJ6QOv/8Ym1HeJa8k5HCMY6kPBSFbjAK3cGfujoLxU0fksgiXXrkNigs+wYiBBcoIe8VMg1BWfzjubbjjUNLdEUX2e0nuIyEDMKmCo1RvfEtt5AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KRqtpy1HPagI5RBIwC/Xtlv6RlX+SAMBnMiU0XXk3MI=;
 b=f/FQG4//0Sg6U3FFdu59bV0M+Y8g8ubvLyOKygLghcyWiNa5rtvSDylBtR9qYW2E+zuSjIOWPDZIBOrfahT/wonnALN6JqgPliC88EA1DdvMpKmb7qnxptCECoXPVnYkwrBA6oJ3bJ3IGgc2SMaRHbJc6M9EfgFKrg7lQGdSpa5pZ1SsmlbeJKAaYVgJxDsBnWRfKexv/mJZ2/6QTsQsXjNHND2y4S3xRcU3nTXuDJ0UgVW4xFfKhxMNx4Lwiec4yMQud7QzyToXLNA16L0UbZtYt6ZF7cIL15DfqxHuUxN+GGBZiDt5Y5PMJcEEQTWhz8Zyl3oRlubVOUwrlV895g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from IA3PR11MB8987.namprd11.prod.outlook.com (2603:10b6:208:574::18)
 by LV3PR11MB8507.namprd11.prod.outlook.com (2603:10b6:408:1b0::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Thu, 16 Jul
 2026 00:40:43 +0000
Received: from IA3PR11MB8987.namprd11.prod.outlook.com
 ([fe80::f91f:4301:96d7:1925]) by IA3PR11MB8987.namprd11.prod.outlook.com
 ([fe80::f91f:4301:96d7:1925%3]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 00:40:43 +0000
From: "Hyong Youb Kim (hyonkim)" <hyonkim@cisco.com>
To: Alexey Simakov <bigalex934@gmail.com>, "John Daley (johndale)"
 <johndale@cisco.com>, Neil Horman <nhorman@tuxdriver.com>, Sujith Sankar
 <ssujith@cisco.com>, David Marchand <david.marchand@redhat.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH v2] net/enic: check notify set return value during init
Thread-Topic: [PATCH v2] net/enic: check notify set return value during init
Thread-Index: AQHdFEUdHua/6v8LG0+p6XG+A4LBirZvTUpQ
Date: Thu, 16 Jul 2026 00:40:43 +0000
Message-ID: <IA3PR11MB8987D9D134E71F46596649AEBFC72@IA3PR11MB8987.namprd11.prod.outlook.com>
References: <20260715103105.39417-1-bigalex934@gmail.com>
In-Reply-To: <20260715103105.39417-1-bigalex934@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8987:EE_|LV3PR11MB8507:EE_
x-ms-office365-filtering-correlation-id: 4acbfaba-4a66-4211-ffb5-08dee2d2de8c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|11063799006|38070700021|56012099006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: Gm85PXZ/joeGoG4ldo1qN56nnRaS4SDAsED16t6Ou3xG+c5u1fEQMYAthoauJuvedooXfRHTHYLpn6IHOopH90pWGq6NoUgDG7FF0tX+o9myVJ5kcPz7xEjKfDDyDfj7N6SWhVpSXXm6SaGk9rc7HA/Qp09slIooqufinvGEWyQFWF25VZ1MbwuwPwF8wESRhaxXTZfmIahnG2QcEBp9WiBCcqQqzUNMZ7GmZMn0dykwrZtVJl4ECm4xT4kv+jrqFHVYWoRYGPzBjNflN7chJcgcVQ7/B1SqNff1SVJvujP5awc5gNXGXmjZDLrkSMi1PGeUjCCgRoy5VyD5cL1BiTTdA13CTmcnGe39J3nTLxnWi3lLg9EB29rDmdUWcRSpcbXlCdwyGU2ckC6fzSdzsGFck4P6BdlxPTc+OHwE0K1qyFjz7YsIrmOuYzaYbEDY3PCEdMbxzRBw1SYN0FWiqApS03R7Cz2CdKPS6yurkMJY07Hu+BjF+/hYfnNsAacp2IzrO45mkRb3jXyp+3NIg24WSEQfsExxeBF+vFZOhwvR+jsXRFguHtvb4OCsBlUxW38dnp9iF5xTiZsmy8xFyuABWWHTPMh0JiQSmU7FiYbPFODiC4Da4KmGDpbBixmbTH7k3oshoTbAvDcIhbDupUZDu9grr9T0KIaY2PMWI0YSY3fVqg+Pm+stUEACE9O4Ernjy9amjw1+ZACvSmgpjyWgU8c/VvFQJmcWpc50ims=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8987.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(11063799006)(38070700021)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GPmz1OAsXcpOjUC/M5LSEsgFlQuVoaA0OaSslPIrAXGy8fa+ziKGxJNpktiO?=
 =?us-ascii?Q?bN87bukkTlyThaKFGNxtrhlYq+tznQjtsAW2jZs2seVNqPavi2UKzzeMucuR?=
 =?us-ascii?Q?wtlBFdgEr7+yQCDpvN4zOZYj/D5XqXTF8AezMeBbzGLWt1Gr76mBkSPvufT9?=
 =?us-ascii?Q?ozioF1zxY6cCgInn9Ve9NM7jAWenvhLRxKmOtB0RulVFm1ZiGPqmC0lEi0sK?=
 =?us-ascii?Q?Jo7Lwxx38/co+fQX0S/nxVw8mTtyyVZnNUFcPznC5z2whnMfOeUoQi1CQXxO?=
 =?us-ascii?Q?MlBR3QKWVO1FWmlLUx1NYDQ7yoeNa5YMOoDzpbxL0sBGAx7j25645oF8/s0G?=
 =?us-ascii?Q?Xs8k4uQKlXXrSd4UUUCMNrO4XMlnGLyWjZA0T2Xiptm3WcfqEGD14URSfOPv?=
 =?us-ascii?Q?0CqAKPxeayhHQNwWVshlaVNrvyf39PN5uZCs9ATvQXzOvuKAL8cmZpsDRrf2?=
 =?us-ascii?Q?vryo7ZTdwM+0Kl1TdE1lQrMwAsAEG9wmtmeKUw6sHNiYcH+mTkvMQ3Nf+FN7?=
 =?us-ascii?Q?tDIyPZLdSj6TdqGSwGuf04vaceAz5X+FacIyQkTHweYnx+3i0q0gxo37bAb8?=
 =?us-ascii?Q?X4+kuRE6lDPytcOS7DAtbpk9nHGnSE0KUPrYkuP3Z4sC7C0G3AE0TG7g2eZS?=
 =?us-ascii?Q?ka0lljjDzo/rlmoDrva+7GqyNP3vM1DNiRo9ZHIW4z35/TgMW+tKn57uyrgi?=
 =?us-ascii?Q?KgLv/w3vFJhQH9tDPVaRz1ljAoXH+03DrBUHr5AaRbh8gTLynvFqz3oZf3C1?=
 =?us-ascii?Q?/UyGWXWRzaCFk0k7NwjcaCuVelguFcN1dn3Tx9UWB5mejdM3z63c7W/PlgI3?=
 =?us-ascii?Q?s7QbIsG25UzixRUWCH7NcU9etxomnNUVPk6oLElXl9T9ew1YNuAKICc48RpU?=
 =?us-ascii?Q?XfovsHlFJUcQCKbdvuvpKIZ3biiTS7iHov1zcrVKjlYM31X3776OtOE67T6E?=
 =?us-ascii?Q?1oka2cIM0rJhUwjlCWgU9CWWE2d0K7EZONTaypYjlQfT5SerIYiPBW/I3uHZ?=
 =?us-ascii?Q?gaDgN6705vAz1wKBZpebilLzCayIWBWKrCJ26zv45aL1qUBdtwGMjZaRz+F+?=
 =?us-ascii?Q?+Fxq99yLm7OCq5vP1038mAD+tcWBx0oqJbX+k4m0nfBxXyrBFm+ZfKLrb6qt?=
 =?us-ascii?Q?Sq3meYrQAjNOJnAzF2hvXDNx49kYn4mZ0XqxTyzvZ4e693MUSbZf7L8wiXgA?=
 =?us-ascii?Q?Uoy8uXNb4uhh1d9OjCuOrBiXVA7YJhQG6MF+qEDhn2r623rtK0GEWEB/KJr+?=
 =?us-ascii?Q?GXhKnusQ4SXxSlpHwbAnkmTUMWZp1Ca9RWCigCzIlXmXxPeTQKMySk/0ZKp3?=
 =?us-ascii?Q?katJqSdel/ZdWpyn8L8SDxDKtWOemlMtzsh8Dirmd7z+5yn2tN8+ZBsNuwaL?=
 =?us-ascii?Q?URexdrwG2tmoT/oEthtbk7/S/cTxQKjdNqYxh1LhZBIaGYho8MCldP59EtO5?=
 =?us-ascii?Q?swofVrcahuEp+WN/H6zv/vG/3//NbbleFQ9GRnWSaDxe3bQRhVO67x7VzRAB?=
 =?us-ascii?Q?eywiil+bg8ek6iIOX3kVDnUQs+vxK2IF72tSW3SCiRWM2d9GksKBY++75a/z?=
 =?us-ascii?Q?fCXPHmkE6UMiuyJ8evcGiua/J4f5DCfgSrn6mhwtkrUCMlEqRNrbu8CufgsT?=
 =?us-ascii?Q?Ef2hTLvF44FwbMkweGYdT+eMs2kAppFfud8ZaLSjrNJFUW5beG7TmlLSalLM?=
 =?us-ascii?Q?l/DY68Y8VYckADemaeImx3lTqzIgy/vKmDCRb44yBOfkTy+I?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: WhkwYwRpote0DoE3YffS6kVM5PxL1i+Dzxm5lZnnCX/pMmrVkxzU1pir5LnV/n4PmktTh1OGqSMd/sa6FMTmHQnfYaUdEgMztxpPofwHrCa1dlRn6jnSI2csbsKImrzKXid/5f9+I20M3KzQaUuAgDQraeG2oFcaI76TvosSCKE2wsno32IAiVMSeBHZ0B2u1RrJXJbiU0GNthHUqAyJTwuxS/uVhvgEUNn+2tJyPU4GGDgNeyjiNeGEYdgatiMcIutX3yYxDCkqmw62vqgzKTv+asLm5pjSjACaGC5SZ+RCBS8eueeirV+VYL27iSn4m9HstKlaW6+GfC9qU5hBRg==
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4acbfaba-4a66-4211-ffb5-08dee2d2de8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2026 00:40:43.7957 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V6+J+dTTbefx17r2znDNY7ghXl4+7qJs9hwC8Tm2xJcsK/MFycIKg3+sRXHZLzir4wB2Wi1XLjru78xfOWAV1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8507
X-Outbound-Client-TLS: ANONYMOUS; rcdn-opgw-1.cisco.com [72.163.7.162]; TLSv1.3;
 TLS_AES_256_GCM_SHA384; 256
X-Outbound-SMTP-Client: 72.163.7.162, rcdn-opgw-1.cisco.com
X-Outbound-Node: rcdn-l-core-03.cisco.com
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
> Sent: Wednesday, July 15, 2026 7:31 PM
> To: John Daley (johndale) <johndale@cisco.com>; Hyong Youb Kim (hyonkim)
> <hyonkim@cisco.com>; Neil Horman <nhorman@tuxdriver.com>; Sujith Sankar
> <ssujith@cisco.com>; David Marchand <david.marchand@redhat.com>
> Cc: dev@dpdk.org; stable@dpdk.org; Alexey Simakov <bigalex934@gmail.com>
> Subject: [PATCH v2] net/enic: check notify set return value during init
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
> v2 changes: validate return code of vnic_dev_notify_set()
> in driver init section
> v1 link:
> https://patches.dpdk.org/project/dpdk/patch/20260707112014.82821-1-
> bigalex934@gmail.com/
>=20
>  drivers/net/enic/enic_main.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/enic/enic_main.c b/drivers/net/enic/enic_main.c
> index 2696fa77d4..f46f429135 100644
> --- a/drivers/net/enic/enic_main.c
> +++ b/drivers/net/enic/enic_main.c
> @@ -1887,7 +1887,9 @@ static int enic_dev_init(struct enic *enic)
>  	LIST_INIT(&enic->flows);
>=20
>  	/* set up link status checking */
> -	vnic_dev_notify_set(enic->vdev, -1); /* No Intr for notify */
> +	err =3D vnic_dev_notify_set(enic->vdev, -1); /* No Intr for notify */
> +	if (err)
> +		return err;
>=20

Could you add an error message, like the following? Looks like all error re=
turns in this function log a message.

dev_err(enic, "failed to enable notify buffer\n");

Thanks.
-Hyong

>  	enic->overlay_offload =3D false;
>  	/*
> --
> 2.34.1

