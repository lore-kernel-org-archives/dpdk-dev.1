Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4ABAC4450A
	for <dpdk-dev@archiver.kernel.org>; Sun, 19 Jul 2026 03:05:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 156BA402A7;
	Sun, 19 Jul 2026 05:04:59 +0200 (CEST)
Received: from rcdn-iport-9.cisco.com (rcdn-iport-9.cisco.com [173.37.86.80])
 by mails.dpdk.org (Postfix) with ESMTP id 4C29840276;
 Sun, 19 Jul 2026 05:04:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cisco.com; i=@cisco.com; l=1852; q=dns/txt;
 s=iport01; t=1784430296; x=1785639896;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=wHtNas9fO53Ebk2g6Z3yap1RriuwptbKSaO9KRn/cI8=;
 b=F6iSUq5mxpA8ngPqQIFJriWuRWFyijcyWex6ewiTcHV6kSR0WG5NWrWA
 v8nPxQt6rs/D56fK4EO95MZf1ekKHwWnnpkHJLrvQ0h2oSZnqwb8krIap
 2a//m72y1tt3LErlYMRMv0XDa/f/sk2wofcLhM614ephxs6EPurvLfuEt
 M1ScojlO/EFLZlg9fEDfvTtjXZcUTJIyBJ5pI0/Ea7wJyRy6fV3xdp91U
 P4amGlywnnZ05gxHh3kQ1I8daFeFzWyK2gUdFIOMu6RR9UtfOWlqHLLMe
 05YfXBRmYwZc+C44b0ICAhSG4kZHJFuWy+TpxFX0s31HeLjxxvxMaX2lv g==;
X-CSE-ConnectionGUID: 8YWwwnl1RmKP33DDW0rLqQ==
X-CSE-MsgGUID: igG2YkKMTO+ZjeuyLv8Lfg==
X-IPAS-Result: =?us-ascii?q?A0AEAAAqPlxq/4z/Ja1aGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBZYEXBQEBAQELAYFtU4IrSYgjA4RMX4h5A4tkkjeBfg8BAQENA?=
 =?us-ascii?q?lEEAQGFBQKNUwImNAkOAQIEAwIDAQEBAQEBAQEBAQELAQEFAQEBAgEHBYEOE?=
 =?us-ascii?q?4ZchloBAQEBAxIVEz8MBAIBCA4DBAEBHxAgER0IAgQOBQgahRsDNwMBArBmA?=
 =?us-ascii?q?YE9AooqeIEBM4EB3UYNgmQVgTgBhT6CfR8BAYQ8gSEBGYR8JxuBSUSBFUKCa?=
 =?us-ascii?q?T6CH4ImhBOCMASCIoEMkWxSeBwDWSwBVRMXCwcFgSNDA4EGI0sFLR2BIyEdF?=
 =?us-ascii?q?xYeWBsHBRIgKkFFIwNPLxA4C0MFgVYCgghOIx8DOX+BMHVKdy1pAQIQF0pBJ?=
 =?us-ascii?q?IIUgToCBwMLbT03FBkDBIE1BY02I4FNawh6JzgCYRUtGTWTR4M1kEieHE1xC?=
 =?us-ascii?q?oQdm1+GMheqbJkIkhOXBQIEAgQFAhABAQaBaDyBWXAVgyJTGQ/gXXk9AgcCB?=
 =?us-ascii?q?w4DC5NmAQE?=
IronPort-PHdr: A9a23:Iuy0RBAbqQlv8wp326M9UyQVXRdPi9zP1kY98JErjfdJaqu8us2kN
 03E7vIrh1jMDs3X6PNB3vLfqLuoGXcB7pCIrG0YfdRSWgUEh8Qbk01oAMOMBUDhav+/Ryc7B
 89FElRi+hmG
IronPort-Data: A9a23:JWyFd6lio1jVnfIDGB39a03o5gzWJ0RdPkR7XQ2eYbSJt1+Wr1Gzt
 xJKX2HXOP2LYzPxf99zaIq//U0A757Xz9FqTlNurH0zEltH+JHPbTi7wugcHM8zwunrFh8PA
 xA2M4GYRCwMZiaC4E/raf658SUUOZigHtLUEPTDNj16WThqQSIgjQMLs+Mii+aEu/Dha++2k
 Y20+ZC31GONgWYubDpLsvPb8XuDgdyr0N8mlg1mDRx0lAe2e0k9VPo3Oay3Jn3kdYhYdsbSb
 /rD1ryw4lTC9B4rDN6/+p6jGqHdauePVeQmoiM+t5mK2nCulARrukoIHKZ0hXNsttm8t4sZJ
 OOhGnCHYVxB0qXkwIzxWvTDes10FfUuFLTveRBTvSEPpqHLWyOE/hlgMK05Fd0pxfloB2UXz
 /k7EGtWQjy83/iS2YvuH4GAhux7RCXqFJkUtnclyXTSCuwrBMiYBa7L/tRfmjw3g6iiH96HO
 JFfMmUpNkmdJUQTYj/7C7pm9AusrnnudDtbqVe9rqss6G+Vxwt0uFToGIeMI4fUHpkJxC50o
 ErH8EujMxI5EeC4igiH/2+9ovGfuS30Ddd6+LqQs6QCbEeo7mAeFjUaTVe45/6jhSaWQM5WI
 UgZ0iY2oat081akJuQRRDWiq3KC+xpZUN1KHqhis0eGy7Hf5ECSAW1soiN9VeHKffQeHFQC/
 lSIhNjuQzdotdWopbi1r994cRva1fApEFI/
IronPort-HdrOrdr: A9a23:nx/ztqCsiLs1RRTlHeijsseALOsnbusQ8zAXPh9KOH9om52j9/
 xGws576fatskduZJhBo7y90KnpewK7yXcH2/hhAV7EZniohILIFvAv0WKM+UybJ8STzJ846U
 4kSdkANDSSNyk1sS+Z2njELz9I+rDum87Y55a6854ud3AXV0gK1XYBNu/vKDwMeOAwP+tAKH
 Pz3LshmxOQPV4sQoCQAH4DU+Lfp9vNuq7HTHc9bSIP2U2ltx/tzKT1PSS5834lPg9n8PMP4G
 LFmwv26uGZte2nyhjT7mnX755HstrswNlOCaW3+4kowzPX5TqAVcBEYfmvrTo1qOag5BIBi9
 /XuSotOMx19jf4Yny1iQGF4Xii7B8er1vZjXOIi3rqpsL0ABggDdBauI5fehzFr2I9odBH1r
 5R1W7xjesUMfqAplW52zH7bWAsqqOGmwtlrQfVtQ0HbWIqUs4UkWXYxjIMLH5PJlOg1GltKp
 gfMCiV3ockTbrdVQGYgkBfhPqxQ380AhCKBmIGusCTznxquUoR9TpD+CTa9U1wqK7UjPJ/lr
 n5G7Utm7dUQsAMa6VhQO8HXMusE2TIBQnBKWSIPD3cZeo60l/22tfKCY8OlamXUY1NyIF3lI
 XKUVteu2J3c0XyCdeW1JkO9hzWWm2yUTnk18kbvvFCy/DBbauuNTfGREElksOmrflaCsrHW+
 yrMJYTB/P4N2PhFYtAwgW7UZhPLnsVVtETp78AKhizi9OOLpevuv3Qcf7VKraoGTE4WnnnCn
 9GRzT3LNUo1DHcZpY5ummnZ5rAQD2KwXsrKtmpwwE68vl5CrFx
X-Talos-CUID: 9a23:sODmm2/a4HVy0waZytmVvx4lJd86dHmE9nLzGxTjJUpWEKexUGbFrQ==
X-Talos-MUID: 9a23:WH6wwwvoMVnYN+JLVc2nhT5NbvZrwIGSLwM/k5gbqu2aZQh+NGLI
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-l-core-03.cisco.com ([173.37.255.140])
 by rcdn-iport-9.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 19 Jul 2026 03:04:55 +0000
Received: from rcdn-opgw-1.cisco.com (rcdn-opgw-1.cisco.com [72.163.7.162])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by rcdn-l-core-03.cisco.com (Postfix) with ESMTPS id 201A4180001C7;
 Sun, 19 Jul 2026 03:04:55 +0000 (GMT)
X-CSE-ConnectionGUID: cPZXnuL4TlajQQCsHFPfIw==
X-CSE-MsgGUID: ykS8jnitTGWxWIcF60vHrQ==
Authentication-Results: rcdn-opgw-1.cisco.com;
 dkim=pass (signature verified) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.25,172,1779148800"; d="scan'208";a="65107860"
Received: from mail-southcentralusazon11013032.outbound.protection.outlook.com
 (HELO SA9PR02CU001.outbound.protection.outlook.com) ([40.93.196.32])
 by rcdn-opgw-1.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 19 Jul 2026 03:04:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lLFZr+0FUuB6zsvwK/QJOdUe8xdeaSmsxU6fUklWxdjwPquxDHTKzOEKs18U86mNQH4WVmv9PEdTV+47n+VI+THt3LyMjqUFDBCjGpZ596vRUSHTZMbdeBiM1EG6/FtGutdADiVMaNgVzZEipfmd+oo3+HUXy7UfrPV2rYfMtoCeW5aJTCHUvg8leJ39mWJHwuMKREc/MwlmIkfGQ9knKXIssR+NUmgxxOz8+uxgYqofk1K7qZESUYqamMUMLdNHTrcmoko+fmEoCwPT47h/c3c1nX01bA2dPI2aMJ+C8rlemATr9WGIKvx+yAsa5pgsW3zBe1+VgUX2f+fRYZOUdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wHtNas9fO53Ebk2g6Z3yap1RriuwptbKSaO9KRn/cI8=;
 b=LosJi/wNogZsqTsXlza36UuKaZ7HlsGWBqiixoJdSn4gZiocKbr/2wNRF//WM+ifQEHGBzyfaZtUL5z5zJ2WLtOClR/HVVbIR2a1epAmHE61fO3tdmiKMtRemONVyhhFkXcqrB/J8Wgd3EvyD9T1kDEI/aMW3fwzFAsaTFm8Odp/pn99I2+9zMOSVFtDLTVGgqGd6YC3ew06dS/VNUhfkwzAQC6AsvswkrxXjnqydlV1lH+H7pHpzuOzo/1mEUPoya7XilExTx1Q/Y2iwVtd4a54RXDYL2Z4B4+MhJREA4LqnwyXAof4eQhoJ0wOfkmmQ+yQx0ws3nPhkwakxrX9Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from IA3PR11MB8987.namprd11.prod.outlook.com (2603:10b6:208:574::18)
 by SA1PR11MB7038.namprd11.prod.outlook.com (2603:10b6:806:2b3::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.15; Sun, 19 Jul
 2026 03:04:52 +0000
Received: from IA3PR11MB8987.namprd11.prod.outlook.com
 ([fe80::f91f:4301:96d7:1925]) by IA3PR11MB8987.namprd11.prod.outlook.com
 ([fe80::f91f:4301:96d7:1925%3]) with mapi id 15.21.0223.013; Sun, 19 Jul 2026
 03:04:52 +0000
From: "Hyong Youb Kim (hyonkim)" <hyonkim@cisco.com>
To: Alexey Simakov <bigalex934@gmail.com>
CC: "John Daley (johndale)" <johndale@cisco.com>, Neil Horman
 <nhorman@tuxdriver.com>, Sujith Sankar <ssujith@cisco.com>, David Marchand
 <david.marchand@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org"
 <stable@dpdk.org>
Subject: RE: [PATCH v2] net/enic: check notify set return value during init
Thread-Topic: [PATCH v2] net/enic: check notify set return value during init
Thread-Index: AQHdFEUdHua/6v8LG0+p6XG+A4LBirZvTUpQgAIl44CAArlMEA==
Date: Sun, 19 Jul 2026 03:04:52 +0000
Message-ID: <IA3PR11MB89877F0FA4E9EF63B478A201BFC42@IA3PR11MB8987.namprd11.prod.outlook.com>
References: <20260715103105.39417-1-bigalex934@gmail.com>
 <IA3PR11MB8987D9D134E71F46596649AEBFC72@IA3PR11MB8987.namprd11.prod.outlook.com>
 <20260717092259.vfwlgwahsquw3z2x@home-server>
In-Reply-To: <20260717092259.vfwlgwahsquw3z2x@home-server>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8987:EE_|SA1PR11MB7038:EE_
x-ms-office365-filtering-correlation-id: c7639ca1-b5fa-40ea-791c-08dee54280bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|10070799003|1800799024|366016|11063799006|4143699003|56012099006|10067099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: fGHtPDiHwgw6h51RgVPypvyYU90eUoeVW5rkAqcjU1cGFntVFnHDM1EzKP1rnPLANuLqaM7nWX7831nYcyrYJCcEiOOggr6liZVY2YELFauwsydLuWpB2Ch7Qe2Cu5c1LxXDmY8Qg/mVwurOWBG9gzeQ9aBmVoxEM7C+RHJpVyuzb7PIDJGNS9D+RRf5M/6DsOQB1MWCNnY2Ey/mD+09pKBaR+B8KcoeBppSC+u/8/y1kSqNVdmilUtRZFnu501rJRybjLu7/uRGUSqBbUa0j6hkkvIxDAk1G6k83Gixw5cRuszBYXJVBXqxmhoLLx3rGAwvafOoQq3X97KzrUGRhAC4haCofoR+WGCGTGPFkwMQZifKuu7MmjZNVhYooSY7JPLtjhjbSdlR4tZuFtnbihFXaKn2MDBwxeHSzeNRd+lCnCShyg3TJeZs4zgZYwlIXDGjt9PefOCB55VvZVzCYAY0VeQJYDdYxa7lEjS/L/MaydgR2RICBTqP1Nfo38xg4WneTW8hbTB5bQxgiR9u+g/HRAczRqLOT9h+gJU83CiW2sTASYi1lPS2lUQkcHvcaSWme3iFIRia7aKvs2DOzskvvH5C0otxidUD9iYdc0JdYLqv2QorIfuaYWUQB+R0OJqXtAJaCoiYCh0bhPkEc3kJNK3f+Rw9nloyCoqdfaTM1Q7g/ry5h3x+HW/mIHNvMLRf8ZdWaGqNAyJWABBwPa5wi3sNU3zrtBBvf5e88bs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8987.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(10070799003)(1800799024)(366016)(11063799006)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qew1VVztYanA3CB2AWcuPuXmoFSv8ggNHK5ONG1Sy4DiRCO8O2pfZrOMBzkR?=
 =?us-ascii?Q?HpO6urKThPL/gk1T5UyROd+Pz/BuSxKUXtiMwyIlDeZ14En+nqPQsv4sJ+hN?=
 =?us-ascii?Q?jrIPElKGVPktLIVpgH77ErNTh5EI5oCCnft08DZR9evGFCj3aeeQUoCl8Y3Y?=
 =?us-ascii?Q?tq5hNRsYvD2iIWo0kepMN4H48PfNSqFqRnPw2lrDM4wi4WLqh7eZ6+OyqroE?=
 =?us-ascii?Q?pEgwTfv2rKMHeye7B0KxpS2+XUvcdzOPZluDCCoSgv7kLpaxOb2H30vl+rKZ?=
 =?us-ascii?Q?6kQ1JX32HSr3Rk721dWeCaQRk0xluXBC6RcUHKdqKsbXxoFMXErzKZ2XXiJX?=
 =?us-ascii?Q?fDzrSAlHOMGsSpL4hKBr9mIhHRwhrt7WejCv10K4vioxa8pejzNcHgHqzEWt?=
 =?us-ascii?Q?0XMabc2Ov6IRug5hplyiRMxTFnoM20Z/KnsnnfHqNzEnWM9fOtBuP7db1cpr?=
 =?us-ascii?Q?9R/UV32oGEU+1cv4VSyxFAUgfwDiNl7dRGhhaStuRbnrAZMbZlWepfLSDlq8?=
 =?us-ascii?Q?DkleD/YwCPbZVuYA6OwwG1apAPT1z6xZCBGXGSycz4/sKC0Gz1Yj9KTq7/hi?=
 =?us-ascii?Q?8xi9ty45A52tFtWV7r3kvJvzhp6CYa6Ou62n/Zvpi+X1UOLJg9ABlBqKH8+i?=
 =?us-ascii?Q?oLuypv90Y9Niugy4M7ipmgC2zCQn6SuQUgXzGSB5IjRnyfRhJRm7D6s+eIFe?=
 =?us-ascii?Q?KS4TJeGQbtMuPgd1pRDfOtbs62YiuQ8wZzwWs+gNjnLZjCU/JjuY5de/REzd?=
 =?us-ascii?Q?33x/Vg+PDXmFBN7TnEoYw6lO4Nt3metxyVyaA60vksNHYEVOkByniB/l8zw+?=
 =?us-ascii?Q?WZ2umapjB0j/9+inSTZK9wi13Vo/X0r9uKCcq0iShwTw3JVo9Yb7P9RsluLO?=
 =?us-ascii?Q?sN4NCTjvj6O1hLAXC51sENJ0FvUDrPB50YMPnfQ/uxVeyedMMHBJWPvLwFMG?=
 =?us-ascii?Q?sjzPBgpwZm2xwGG/dLzTugiWxtMepp4TScbtCnWuYCAF/M6+W/El1AfZmFhA?=
 =?us-ascii?Q?9Fk0pfC6LnnSreAhh0luBJjRq7FQATpwoVvpQlLSO0H9rLUdytmHXlz2WtEW?=
 =?us-ascii?Q?n0ZmlaggdneZgr8cK28QD/Q3V2O4BHAr9YR9BO0s6AymkCC0XOndd1GStT0B?=
 =?us-ascii?Q?Prr8RedzSjRm3L3pdjFi6RyDALRMomNbY+A7mPOwHLe/8tF29Jsm/8hArDQ8?=
 =?us-ascii?Q?sFYub1yH65rv2hyPQA9sCSrHqdunphHrA22gi7Jvhhv9QZqTDOCijVVJm8US?=
 =?us-ascii?Q?l/HzH886t+3vTEmxAeWpBHk3OV0k4Vzy9JSQqzwZotbFgSNxX8wzSElaQcw2?=
 =?us-ascii?Q?z2ltXSq+TZmPA+zlLpUXCUa7mrVNuYpFMQi7A99Z3NYJKSdQFbpyCnVdl4dz?=
 =?us-ascii?Q?rFQlwDOboeMDru0DhmLwJG8as3bEqjZv5kzzlO0LdqnlxCcH53Sf9+PyzLkC?=
 =?us-ascii?Q?0wJKJysiPlHRhY53+A8hk0PuFiQqxUfdvsi5bsiG1zgOIWrwQpxqdcrbg8wE?=
 =?us-ascii?Q?lDXiKOjq+a5gP9fA613Vx1EjzKzn6wc3GiSfq3jTepA/xO0HCNrgWLCFgDAH?=
 =?us-ascii?Q?uUqkHbo+pGjfIjlE07QpfNSy8Bjpr+4rrV2EGgDlaHvyHO/+z4o4s6Fh/IHw?=
 =?us-ascii?Q?cuYBMUjUNygKUH6opGZLH7A9QcHrdmafbvmXi0VXjnCssjc+qacTTPvhdPgS?=
 =?us-ascii?Q?2QLWRuPX9HmB2Yz25F+DS+nZoEOmKAogJ8GS9DkxKLDBb/nx25lXWNBRGz9R?=
 =?us-ascii?Q?t2WhfbOHni+JjbxgrSHPBiwZWqHymxoROv2291gkPWiLNAaOyn2C?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: nqIIFxdnswh7ftbvxuMnBKErElXzOvA50g24hV+MVmEv4ee6Z8964q5MRHA/ekLrY0jA/wqLia9oR/S0PleEadRA4zoC9oYQblv2VVCql+robcTCIXebcIGiTY3/6t6ns8cWdd1nWCq1EtSsNbSF+9c4KZ/VH8ch8BskbF0U7YkzrTIkscJnpAe4L1Fw1+hgTciIlF/ZwjG8ztBn4ojG5I8zItGUF/GKTH56NbI2JOU3U6gTqwoEHqdnsOqqrkkUvHAUDzMq5q8SsNf5+lzIbYbPPIsZNjqjOSBxaUxGHqkffqPk8WJpAP6d9DtepB+dt0PDm+smv0fgI7ec2ZexJA==
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7639ca1-b5fa-40ea-791c-08dee54280bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2026 03:04:52.3392 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZpNkFG/L8TLxfZ3oHSJ90Fa0j36bad4XxgBr+LUyoN9hej6xYX1jE9OClUtDf019pbcJBa80wlW1wcFQjkA3zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7038
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
> Sent: Friday, July 17, 2026 6:23 PM
> To: Hyong Youb Kim (hyonkim) <hyonkim@cisco.com>
> Cc: John Daley (johndale) <johndale@cisco.com>; Neil Horman
> <nhorman@tuxdriver.com>; Sujith Sankar <ssujith@cisco.com>; David
> Marchand <david.marchand@redhat.com>; dev@dpdk.org; stable@dpdk.org
> Subject: Re: [PATCH v2] net/enic: check notify set return value during in=
it
>=20
> Sure, also dpdk ai review higlightet potential problems in memory
> management
>=20
> For example:
>=20
> enic->cq =3D rte_zmalloc("enic_vnic_cq", sizeof(struct vnic_cq) *
> 			       enic->conf_cq_count, 8);
> enic->intr =3D rte_zmalloc("enic_vnic_intr", sizeof(struct vnic_intr) *
> 			enic->conf_intr_count, 8);
> enic->rq =3D rte_zmalloc("enic_vnic_rq", sizeof(struct vnic_rq) *
> 			enic->conf_rq_count, 8);
> enic->wq =3D rte_zmalloc("enic_vnic_wq", sizeof(struct vnic_wq) *
> 			enic->conf_wq_count, 8);
>=20
> if (enic->conf_cq_count > 0 && enic->cq =3D=3D NULL) {
> 	dev_err(enic, "failed to allocate vnic_cq, aborting.\n");
> 	return -1;
> }
> if (enic->conf_intr_count > 0 && enic->intr =3D=3D NULL) {
> 	dev_err(enic, "failed to allocate vnic_intr, aborting.\n");
> 	return -1;
> }
>=20
> Lets imagine that enic->cq is allocated successfully, after that
> when we trying to allocate enic->intr we are failing, so in this
> case we leaking in second if statement, this related to all error
> handling paths in driver, since as far as I understand resource
> free happening only in enic_dev_deinit(...) function.
>=20
> So my question is it problem? If yes, should I address this issue
> in scope of my patch or better to make it in another?

Why don't you create one cleanup patch that addresses both issues,
since they are in the same function?

Thanks.
-Hyong
