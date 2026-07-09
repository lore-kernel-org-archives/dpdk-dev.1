Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8BF3C44501
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Jul 2026 09:11:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AE824402BB;
	Thu,  9 Jul 2026 11:11:34 +0200 (CEST)
Received: from alln-iport-3.cisco.com (alln-iport-3.cisco.com [173.37.142.90])
 by mails.dpdk.org (Postfix) with ESMTP id EE1894028C;
 Thu,  9 Jul 2026 11:11:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cisco.com; i=@cisco.com; l=1966; q=dns/txt;
 s=iport01; t=1783588293; x=1784797893;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=NkL28kBSedG36eiOKvN2qyKNiLMPazx0aA9SlAXxl3M=;
 b=BLlPwlT3+bjiGpVNCnsrlyxFLlnf0IwYArzk3xJWCkqZfj2A3FV3CjOd
 YVL5XVpxa/oY9Nq5661ppavTyjO5rr66E4pWmX+FR+V7R6r3CiSPHX0SQ
 PrT9CQ1YhUjtGs6mUU5OitaS9/p1K/as+//W3e1rO31Pm1Us9t6I0gcA9
 hWR/vDHFInDI2XDML6Q/6FNA3Mde82LSQgHx3RcX3prEYCY42ilj+psCW
 qQuwjz8+9HJjYROJqdI9eXjTAUSlW5+2hM6DQetJBTzptzYwh9pglkjGV
 KexqSRSXrLwwfPNFHrbB5mkG35uc/p4YRR4LXIgGaOZkGQAvp9bXRNO0m Q==;
X-CSE-ConnectionGUID: I89PjxnvQtmuHptr7vO6nA==
X-CSE-MsgGUID: M5MERb/XS8Sk/6I2yFXT9g==
X-IPAS-Result: =?us-ascii?q?A0BwAwDkZE9q/5MQJK1aHgEBCxIMZYEGEA8LgWpTgisaL?=
 =?us-ascii?q?4gjA4UriHyBE4pRkjeBfg8BAQENAlEEAQGFBQKNTQImNAkOAQIEAwIDAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBCgEBBQEBAQIBBwWBDhOGXIZaAQEBAQIBEhVSBQcEAgEIDgMEA?=
 =?us-ascii?q?QEvIBEdCAIEAQ0FCBqFGwMPJwMBAqlCAYE9AooqeIEBM4EBtygNgmQUAYE4h?=
 =?us-ascii?q?T+CfB8BAYQ8gSGFFScbgUlEgRVCgjE4PoIfgiaEE4IwBIIigQyRZVJ4HANZL?=
 =?us-ascii?q?AFVExcLBwWBIxAzAyovLSNLBS0dcDMSDx0XFh5YGwcFEiAqQUUjAxpWMRA4C?=
 =?us-ascii?q?0MFgVkCgghOIx8DOX+BMHVKeS2BAAECEB4KbEIkghYCOgMLbT03Bg4bAwSBN?=
 =?us-ascii?q?QWNNRcPgj4BehOBRKYeoQpxCoQdm1+GMheqbJkII5FwlwUCBAIEBQIQAQEGg?=
 =?us-ascii?q?Wg8gVlwFYMiUxkPji0WygB5PQIHAgcOAwuGS40bAQE?=
IronPort-PHdr: A9a23:/lJCoh+YWrklU/9uWBDoyV9kXcBvk7zwOghQ7YIolPcSNK+i5J/le
 kfY4KYlgFzIWNDD4ulfw6rNsq/mUHAd+5vJrn0YcZJNWhNEwcUblgAtGoiEXGXwLeXhaGoxG
 8EqaQ==
IronPort-Data: A9a23:bF18+K2CUMcBzWenXvbD5Ydwkn2cJEfYwER7XKvMYLTBsI5bp2MAy
 2cZUWGCOanZMGaje91ya4Xj/BxSv8PUxtdgQVdp3Hw8FHgiRegpqji6wuYcGwvIc6UvmWo+t
 512huHodZ5yEzmE4EjxYtANlFEkvYmQXL3wFeXYDS54QA5gWU8JhAlq8wIDqtYAbeORXUXX5
 Lsen+WFYAX7g2EsYjpNg06+gEoHUMra6WtwUmMWPZinjHeG/1EJAZQWI72GLneQauF8Au6gS
 u/f+6qy92Xf8g1FIovNfmHTKxBirhb6ZGBiu1IOM0SQqkEqSh8ajs7XAMEhhXJ/0F1lqTzeJ
 OJl7vRcQS9xVkHFdX90vxNwS0mSNoUekFPLzOTWXcG7lyX7n3XQL/pGLRFnBY8I/PhOHWRT1
 eQEMm8TSU6FrrfjqF67YrEEasULJc3vOsYb/3pn1zycVK5gSpHYSKKM7thdtNsyrpkRRrCFO
 YxAN3w2MEuojx5nYj/7DLo+jeCuhXj6WzZZs1mS46Ew5gA/ySQugeOyYYaPK4XiqcN9uxu9i
 1jMuFTCUioZc4K+kyurwk79ibqa9c/8cMdIfFGizdZmjUO7ynQfC1sRT1TTieKlg0S6VvpTM
 0AXvC00osAPGFeDR935WVi85XWDpBNZAoIWGOwh4wbLwa3Ri+qEOlU5ovd6QIVOnOc9RCch0
 RmCmNaBONClmOf9pa61nltMkQ6PBA==
IronPort-HdrOrdr: A9a23:AAl2tau7bxOsiJuh4WCkK/kd7skCeYAji2hC6mlwRA09TyXGrb
 HMoB1L73/JYWgqOU3IwerwRpVoIUmxyXZ0ibNhW4tKLzOWyVdAS7sSorcKogeQVxEWmdQtr5
 uIH5IObOEYSGIK8voSgzPIXerIouP3jZxA7N22pxwCPGMaDp2IrT0JdjpzeXcGPTWucKBJb6
 Z0kfA33wZIF05nCfiTNz0uZcSGjdvNk57tfB4BADAayCTmt1mVwY+/OSK1mjMFXR1y4ZpKyw
 X4uj28yrSosvm9xBOZ7GnO8pRQluLmz9tIFOaMhsIWJjiEsHfoWG1mYdK/lQFwhNvqxEchkd
 HKrRtlFd908Wntcma8pgao8xX80R41gkWSimOwsD/Gm4jUVTg6A81OicZyaR3C8Xctu9l6ze
 Ziw3+ZjZxKFhnN9R6NpeQgFisa03Zck0BS1tL7vEYvF7f2r4Uh9LD3yXklVKvo2hiKsLzPXt
 MeV/00r8wmAW9yJ0qpzVWHhubcHkgbL1OhXlUIvNCT3nx9mXB0yFZd+ekk901wrq7Uj/J/lr
 j52mMCrsAScuYGKa16H+sPWs2xFyjERg/NKnubJRD9GLgAIG+lke+93FwZ3pDiRHUz9up7pL
 3RFFdD8WIicUPnDsODmJVN7xDWWW24GTDg0NtX6ZR1sqD1AOODC1zPdHk+18+75/kPCMzSXP
 i+fJpQHv/4NGPrXYJExRf3VZVeIWQXFMcVptE4UVSTpd+jEPyhisXLNPLIYLb9GzctXW3yRn
 MFQTjoPc1FqlumX3fp6SKhLU8FunaPiq6YPJKqi9T7krJ9RLGkmjJl/GiE2g==
X-Talos-CUID: 9a23:PGOITWOYqgZTve5DeXk2zEwEHN4cbnjA7G/MORCmLjhvYejA
X-Talos-MUID: =?us-ascii?q?9a23=3Ay2FT3g7jD9cqQIxu5cesa7oExoxNvoGDMkpKoa5?=
 =?us-ascii?q?WgMrDaw0qKhmtsGW4F9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
Received: from alln-l-core-10.cisco.com ([173.36.16.147])
 by alln-iport-3.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 09 Jul 2026 09:11:31 +0000
Received: from alln-opgw-4.cisco.com (alln-opgw-4.cisco.com [173.37.147.252])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by alln-l-core-10.cisco.com (Postfix) with ESMTPS id 863641800015D;
 Thu,  9 Jul 2026 09:11:31 +0000 (GMT)
X-CSE-ConnectionGUID: 1kbqSHVSQcG9YFTZsu4klQ==
X-CSE-MsgGUID: 8o4vF0dCRl2T6mmnuUQhyg==
Authentication-Results: alln-opgw-4.cisco.com;
 dkim=pass (signature verified) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="80515280"
Received: from mail-northcentralusazon11010045.outbound.protection.outlook.com
 (HELO CH1PR05CU001.outbound.protection.outlook.com) ([52.101.193.45])
 by alln-opgw-4.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 09 Jul 2026 09:11:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cJHM8SwxWb8/tAL1ySSuGQ19HmwByYfy9i0k1toojUMVZQPnLEL2swxxj8PQr6p9+zzTaqS2LqjFfgDo4u65f0lDnIY0SuFJgqFK72dPP8G1NBVxOpKV5HxSCGLdp5t97pRUawlrbeYKBEg92VuNG/rVBvTzrHfmBD22gk97i4toTelL5oP1UWi6Mx798aG4NyTOlE9EDOa6l5YaYdKH5wLDWahDv3/gr0mE3OEtrVs2I4N7MXTlHBcXDF+urWuVRIBsz6cZj7xm9NPemEVMz41gNnaHqDUcRG05DewheUNUC4o9NF0lwLoi2qW1p3R2CcapO/JONs/oz01wSwJBHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NkL28kBSedG36eiOKvN2qyKNiLMPazx0aA9SlAXxl3M=;
 b=YrO3biAUgLoibe/7/7/KGvP5ZCkLrE5mHpb+bK5IV4FasZKWDIsU0YSq/qjvcDmqjhHutNEXoJJx8tNFAalQ5iEPTltqB6Tig0AyXQGMb7be2ZRh4QyRo6+48/kXhlVRHP9fSXKWNrsmB6QGc1kRPYXeisBN4TtxDBaQ5SLcD7C/ZlnV2tsPySgX+eGwyL6YWTrvGVvj9GX9drptdilRlEJEftYQhu1onViuiJ4Fm44W24F+lr6F6Bx6BhN08rhC/JPp4H++Ozvs2oYqP52d97Molp5JbLAIyyjDOx+RBa9Rcbd0pDCudQ/Iod6rGEDg1KWbuFY0VW6SJgELCOvjjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from IA3PR11MB8987.namprd11.prod.outlook.com (2603:10b6:208:574::18)
 by DM3PPFB266726CF.namprd11.prod.outlook.com (2603:10b6:f:fc00::f46)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 09:11:29 +0000
Received: from IA3PR11MB8987.namprd11.prod.outlook.com
 ([fe80::f91f:4301:96d7:1925]) by IA3PR11MB8987.namprd11.prod.outlook.com
 ([fe80::f91f:4301:96d7:1925%3]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 09:11:29 +0000
From: "Hyong Youb Kim (hyonkim)" <hyonkim@cisco.com>
To: Alexey Simakov <bigalex934@gmail.com>, "John Daley (johndale)"
 <johndale@cisco.com>, "Hyong Youb Kim (hyonkim)" <hyonkim@cisco.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH] net/enic: fix null dereference in flow query count
Thread-Topic: [PATCH] net/enic: fix null dereference in flow query count
Thread-Index: AQHdDgYJgqVJPCv2nEi+VYk7iJK9PLZk5r+w
Date: Thu, 9 Jul 2026 09:11:29 +0000
Message-ID: <IA3PR11MB898706E7BE925AF8A16DC1E2BFFE2@IA3PR11MB8987.namprd11.prod.outlook.com>
References: <20260707114437.94425-1-bigalex934@gmail.com>
In-Reply-To: <20260707114437.94425-1-bigalex934@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8987:EE_|DM3PPFB266726CF:EE_
x-ms-office365-filtering-correlation-id: 5401c9c2-35d6-445a-898a-08dedd9a0fd5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|38070700021|18002099003|22082099003|56012099006|11063799006;
x-microsoft-antispam-message-info: GSH6/hJVoiBTKYCrWBpf89ci+BLRi85Nmho16P3HKNLDoLfqLI3FnmUMhCdLIfWkUgvfOiSwyopyW//YYA8X6KRPNonuG3gkAfRXHSxVQ1VQ5GTDwNO1sbCwNqcavHKypA0Mm0+HNV1fIb+7Z1COKruB6rSd8flrQFWlLrujmJ7h5u87OAOMcbHV/mEvK8v7NqocAI/GGtCrD47MO+hoon/RrYgg9HOA50oDofoqvkeD/H0u78X9nW2Cq4TaTeWDgA6TX/dkQj2/I8+gXSKLeloDc6N128IC605qINluvr5G8iCtjhBX1X0WIj5nlRZTH/Kg2ttG20y1Bz6fqD5IXus5ZZmC9MjqigMHCybxNT1Nk+PPLMEj9oJSFd1qVrXg8/1vVNMqkTxE6h73TW08m5TwoW5vo7u0t1CqEKPmu0Xzl2UMJgCXYXEEfFBRM1UDZt9F355v9BeKbVAactQW0m9TmAvxGHhMY/s51nVosyNi40kPxLCEs21/pHhQVxcHY205u3MNe72mt6s6kVI5ARb1HDrAAhN9RjQFP7gzbh5B+0Oq97Rn5iLEp+xYCeigOIkDKD8nsp/tGYb1kZ788ocz3AzMRvYLuDYvKJyEF0vPnGohWRFRoKR0p8wQfAWfxCdDKz+L+c3K/L/9r1YbQNTYjb0Xzp/hMHj8h7gzZq6eDURzm6s4D/qddzeTONMX6j5Kt2O6vWY3Wm72BgtG2JHOKeSsHsYSr9YvYTGDQj8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8987.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(38070700021)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?mxft2/pV1BouzNEaVaIfYcTrNGvP0PnSIopSKERY+r371GK/3NeafmoZQ3?=
 =?iso-8859-1?Q?xyoXVI3MefsZQKBxmPrGtZ/1C14XRlhumZmJZkSNjRici+SybnOg/dz2TP?=
 =?iso-8859-1?Q?52XVoFOPe0T2HHnLrZuyoIa5acEHqRF8cwCLbA3ZrI/4+lxzVFXMSlA17x?=
 =?iso-8859-1?Q?/7QMMWOhsAC99V9Vam22tFg3V7XQmym3rRcx0JRVXKelqzfAiH6zUGXXYP?=
 =?iso-8859-1?Q?MLuWAQxPONfRxVZTJdupiwYR7Y+isCxelPhfhKTm1p8DW2nMTYOEgvBxcO?=
 =?iso-8859-1?Q?vlr6hvVdORfUGjNGLyfEEm9ijq7kWcMi8GsTxqYsqJcEpYg9T5DCzvDKDS?=
 =?iso-8859-1?Q?/ZLzZqXceA8cIniujHwnxoV8PcDKLKMz/p42lImcxawxE3DYGrD3RWTWMh?=
 =?iso-8859-1?Q?YsTE3nnIrzogP8cXPMclx8ddOUSs2JlS451WZab9eX4iIkEXdrGsJYWiA/?=
 =?iso-8859-1?Q?m2PN8UGOIIzb+mBBWUxJNbYN5/IK8GOnm5Xf6Tk2wAsMmCW4IXBBisa2Vg?=
 =?iso-8859-1?Q?S2NJIsfdIRlCtXReRR3H9UgN8hEdWhWTRq+kG5IwzCWA7OfMK+r2/hNOx0?=
 =?iso-8859-1?Q?Q9y/Im045V1+/jB08HJL2mXpWX6rKSXxMvJ+96R9avNa3dUelcSTrRLCpO?=
 =?iso-8859-1?Q?Da1JJSRViwqYvZ+TKHiIGQ1y+nQ+EmRIM/FnSPxPxX4yh7gjPTNljj270c?=
 =?iso-8859-1?Q?znNMrGthUU5e4YOjNWcSWSdpXS0cqzaNMMRCyq5Jbbsktd8KSLdUIz0zHp?=
 =?iso-8859-1?Q?h9bgIUU+CMx/i/JEACkBcNRmgWN7ZuSeXECYPCuy8hdLCphHLjuNLfnECj?=
 =?iso-8859-1?Q?iWgvKlWp4118+ux7n13iKv/GRKqmiadSE8xWJDLjMiEP7iKUuanvLdmTnw?=
 =?iso-8859-1?Q?34Qad0aMThgjeBQDuR9mK8gTkHSz2TfiaplJlCXMpqpGt5q5aPBfq6m9DM?=
 =?iso-8859-1?Q?DUXATVVfIvSIf/nCSUhlD7EPSoqEW6aBA4UoVSnmvVmb0HYgIiGQo6BGW2?=
 =?iso-8859-1?Q?05Sf8i9U9vKpVo7MuLEP8pED3EIm3IABiYwg5ichQnB8+FuIZMCLQOGl4g?=
 =?iso-8859-1?Q?wQ+ZOhFc0qoNHholJ4uCeoHCrcb3mmceVN/GYqTK/PGWJ31C/cuuPaHH90?=
 =?iso-8859-1?Q?FyUvr8GzCxg6yHbTdK/fseggU6pCKSmahMSbueTnYobqf2TOGNSjtyAf+l?=
 =?iso-8859-1?Q?mKD1QI5cRihSeZbU0dkoXkChCDMGPGx0AyUaQjqQWqOjnJe48PR1K9w9JP?=
 =?iso-8859-1?Q?0CP467cayo8+vWO5a3pWRDEsBZaLNndnjHfMckjwLmftXnXzKWzrHojvoV?=
 =?iso-8859-1?Q?qKm6+Fw+f9uAPZEzUn5NlFJVnUG9p9PziXQJw83gFeiUlTFO3rK3Zmpq7y?=
 =?iso-8859-1?Q?PT/f68dOlZcTKO9YRyYo7B0/9UfNYM9oA1kmC+dijOtf75vq8aze21W42+?=
 =?iso-8859-1?Q?Z/L/CVBtEvFOzatNdrKM2fYa3Hcz3Kh7ua911I/dlWlkOJ214yb0XdLYvP?=
 =?iso-8859-1?Q?aCgoyCvvp/A+eELpn6lmMW79PLKoMj5dnWH9XwIx+F8BHbeaFDNZRmKXbr?=
 =?iso-8859-1?Q?7IKvFU0pCDo4kUtjsbWeFt9XVQtKBSJaDJYxc+h/85wL9zQr4/dyt9t2JY?=
 =?iso-8859-1?Q?P2ex+k2O3n2zhs8Jd3Fm8T+T+xTdMk+X8CnUVGobMEnbaZ4xMfrPdqKMTu?=
 =?iso-8859-1?Q?ehevYkIDQZbYYAOZ3YFjSKOLcCCEdL5JEuCO6EdNea2HYKIjLewn4SjAOR?=
 =?iso-8859-1?Q?/x0n1S7KGSNaBkG0GlMwzPWCvSIhZfogltzVZe0VhBgr5x?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: BGJcu6Ka+btz2eCQKTbFsy1q2se7nuKeYEO7S27DiDResr2M2B6feu672nBpwmoeJPRffj+6BDiBK6rdF1l3WgoK2VS/rE67W3pyP8upkPUc98zxDTF0zk3hZnT0lGFKrKs3o0lQLpOCaSDyRQchsFXEJM+aAB+FwqPEyFfDH4YHTWBE44eFlj/c3SZcKJ4vWe2f3zx5zmT9warsDmc8UJvP0vZXK9o9m+tmdZKYHnT8OM6DUz3TB5SDs303nACZ+88gy9TuBWGD2d3hw5NlBEFNL4dtPZ6QVTpFJs+ILQtd2ZTQGfW2TIdSHkoU116AVgrTwR7ldO0zMBk26RKIDA==
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5401c9c2-35d6-445a-898a-08dedd9a0fd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2026 09:11:29.3145 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iTSiZMfDVNDAh1PSd++M32nHNgVcbLPpFXKHCRKCCadX4GGFP/R/f2MF/FRC3vaHTQZNz3ApxXNgU2Qq9nHPzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFB266726CF
X-Outbound-Client-TLS: ANONYMOUS; alln-opgw-4.cisco.com [173.37.147.252];
 TLSv1.3; TLS_AES_256_GCM_SHA384; 256
X-Outbound-SMTP-Client: 173.37.147.252, alln-opgw-4.cisco.com
X-Outbound-Node: alln-l-core-10.cisco.com
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
> Sent: Tuesday, July 7, 2026 8:45 PM
> To: John Daley (johndale) <johndale@cisco.com>; Hyong Youb Kim (hyonkim)
> <hyonkim@cisco.com>
> Cc: dev@dpdk.org; stable@dpdk.org; Alexey Simakov <bigalex934@gmail.com>
> Subject: [PATCH] net/enic: fix null dereference in flow query count
>=20
> begin_fm() can return NULL when the flow manager is not initialized.
> enic_fm_flow_query_count() did not check the return value, leading
> to a NULL pointer dereference on flowman_cmd() and end_fm().
>=20
> Add NULL check that returns -ENOTSUP with a descriptive error
> message via rte_flow_error_set().
>=20
> Fixes: ea7768b5bba8 ("net/enic: add flow implementation based on Flow
> Manager API")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Alexey Simakov <bigalex934@gmail.com>
> ---
>  drivers/net/enic/enic_fm_flow.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/net/enic/enic_fm_flow.c b/drivers/net/enic/enic_fm_f=
low.c
> index 4b0a513977..28e2a9c1e4 100644
> --- a/drivers/net/enic/enic_fm_flow.c
> +++ b/drivers/net/enic/enic_fm_flow.c
> @@ -2904,6 +2904,13 @@ enic_fm_flow_query_count(struct rte_eth_dev
> *dev,
>=20
>  	ENICPMD_FUNC_TRACE();
>  	fm =3D begin_fm(pmd_priv(dev));
> +
> +	if (!fm) {
> +		return rte_flow_error_set(error, ENOTSUP,
> +			RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
> +			"enic: flowman is not initialized");
> +	}
> +

This function (query) does not check the return value of begin_fm(). I
believe that is intentional. Instead, the driver checks it when the
app creates a flow (see enic_fm_flow_create).

fm =3D=3D NULL in this function likely means a bug in the app
(e.g. passing a wrong pointer), or memory corruption, or ... Perhaps a
debug assertion is more appropriate. Not sure..

Thanks.
-Hyong

>  	query =3D data;
>  	fm_flow =3D flow->fm;
>  	if (!fm_flow->counter_valid) {
> --
> 2.34.1

