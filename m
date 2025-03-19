Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBEF7C35FFA
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Mar 2025 10:14:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A03D14026B;
	Wed, 19 Mar 2025 11:14:31 +0100 (CET)
Received: from alln-iport-1.cisco.com (alln-iport-1.cisco.com [173.37.142.88])
 by mails.dpdk.org (Postfix) with ESMTP id 0DE1B4025A
 for <dev@dpdk.org>; Wed, 19 Mar 2025 08:21:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cisco.com; i=@cisco.com; l=15152; q=dns/txt;
 s=iport01; t=1742368894; x=1743578494;
 h=from:to:subject:date:message-id:mime-version;
 bh=1OYsq2CJibJHpehKnCRpfwW4bc8y1VxAtOim75qzXo0=;
 b=UqVSHJ8FoPw+WkcQGeeRq+dZOFk4Kd+5Qd4Zb4Y1hU8+RyjWAXwIRc8P
 GsjfIl5kOwyMuKcE/BFR6CRinGim4935fsA+GxwKzG8Ak4XFj715p0kgd
 7nEVSl8XzjAASCRo/89+hqYcHm6oKTU2MKR8Auyb2etFG0aaM9xaCOhxZ
 sFoFaSyxeZOoXNMTiIH6KjAoIlsljRGybN35COy4gblZOMU4WW3Sy00kV
 vbKrAipCu/dvjYhQracQWFICMa2f18vncLkqqo4DLvnsruzqBgT5kgMt/
 twzAgERio5W8T5TuhNa/40/680SgaCXKokE9gowKRZEmlggleSm32imvy g==;
X-CSE-ConnectionGUID: To7eOefcSaWFeDZbN5ZRQQ==
X-CSE-MsgGUID: iGZYU149R3udDL3dI/ohjQ==
X-IPAS-Result: =?us-ascii?q?A0CjAwDzb9pn/40QJK1aHgEBCxIMQCWBIwuBQQEwKigHd?=
 =?us-ascii?q?oEcSIghA4UthlSCIZdChlWBfg8BAQENAjkLBAEBhQcCix8CJjQJDgECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEBAQEBAQsBAQUBAQECAQcFgQ4ThXsBDIZzG14BfyYBBBsMD?=
 =?us-ascii?q?oJhghxIAwEQBqEnAYFAAooreIE0gQGDbEHbbQaBSIUDg00BKoEzhA84hD8nG?=
 =?us-ascii?q?4FJRIEVQoI3g1ADgWEMhAeCLwSCGBdFdoNthjaIHYgKE5NPgUciAyYzLAFVE?=
 =?us-ascii?q?xcLBwWBbAMqNBUcgUVDNTeCDWlJOgINAjWCGyRYgiiETYQ+hECFUIIRhDaHA?=
 =?us-ascii?q?oRhLVCCFh1AAwttPTcUGwUEgTUFoTwKEFs7hRZlAlB9GzEYCgIJknePaYQci?=
 =?us-ascii?q?j+VEgqEG4wYlWYXqleICpB0Io1jmwQCBAIEBQIPAQEGgWc8gVlwFYMiUhkPj?=
 =?us-ascii?q?08BC4dTsAF4AjoCBwsBAQMJkWUBAQ?=
IronPort-PHdr: A9a23:VHFpeBdm/q1YCgH7+x91YNSblGM/gIqcDmcuAtIPgrZKdOGk55v9e
 RCZ7vR2h1iPVoLeuLpIiOvT5rjpQndIoY2Av3YLbIFWWlcbhN8XkQ0tDI/NCUDyIPPwKS1vN
 M9DT1RiuXq8NCBo
IronPort-Data: A9a23:LLwpUqpiN0QCXHtbJx7i9OTayjleBmJcZBIvgKrLsJaIsI4StFCzt
 garIBnSbquKNGOjL9wnb9ji9E9TsZ6DzYdlG1Y6+SAxQy9BpePIVI+TRqvS04x+DSFioGZPt
 Zh2hgzodZhsJpPkjk7zdOCn9T8kiPngqoPUUIbsIjp2SRJvVBAvgBdin/9RqoNziLBVOSvV0
 T/Ji5OZYQPNNwJcaDpOtvrY8UI35ZwehRtB1rAATaET1LPhvyF94KI3fcmZM3b+S49IKe+2L
 86r5K255G7Q4yA2AdqjlLvhGmVSKlIFFVHT4pb+c/HKbilq/kTe4I5iXBYvQRs/ZwGyojxE4
 I4lWapc5useFvakdOw1C3G0GszlVEFM0OevzXOX6aR/w6BaGpfh660GMa04AWEX0tpwXmxp+
 PITEzkyQB2vteiQnYCBc9A506zPLOGzVG8eknhkyTecCbMtRorOBv2Wo9RZxzw3wMtJGJ4yZ
 eJANmEpN0qGOkMJYwtOYH49tL/Aan3XaTRapV2SqK4f6GnIxws327/oWDbQUoDWFJoFxx3A9
 woq+Uz4LSMrCYXDmADe736AorTDvGT8WIArQejQGvlCxQf7KnYoIBEbS3O3ufW6zEmkVLpix
 1c88y4qq+02sUesVNS4B0H+q3+ftRlaUN1VewEn1DywJmPvy1/xLkAPTyVKb5ots8peeNDg/
 gbhcw/BbdC3jICodA==
IronPort-HdrOrdr: A9a23:47y2aKrgk5f77VwteI3AbKIaV5uNL9V00zEX/kB9WHVpm5Oj5q
 OTdaUgtSMc1gxxZJh5o6H8BEDhex/hHO1OkPUs1NaZLULbUQSTXfpfBOfZslnd8k7Fh6RgPM
 VbAtJD4bTLZDAQ47eZkWyF+r0bsb+6GdWT9J/jJgBWPHhXgs9bnmBEIzfeOHdbACNBAp00Ho
 ed4M1omxqMEE58Uu2LQlM+c6zmvdPkqLLKCCRqO/cg0mazpALtzIS/PwmT3x8YXT8K66wl63
 L5nwvw4bjmm+2nyzfHvlWjo6h+qZ/E8J9uFcaMgs8aJnHHkQCzfrlsXLWEoXQcvPyv0lA3i9
 PByi1QcPibqkmhMF1dkyGdmzUI4wxeqEMKDmXow0cLlPaJBQ7SzfAxwL6xPCGpr3bI9+sMr5
 6jl1jpyaa/Symw0RgUI7PzJldXfo3emwtkrccDy3NYSocQc7lXsMgW+15UCo4JGGbg5JkgC/
 QGNrCr2B96SyLvU5nihBgZ/PW8GnAoWhuWSEkLvcKYlzBQgXBi1kMdgMgShG0J+p4xQ4RNo7
 2sCNUhqJheCssNKa5tDuYIRsW6TmTLXBLXKWqXZVDqDrsONX7Bo4P+pL81+OapcpoVy4Zaou
 WJbHpI8WopP07+A8yH25NGthjLXWWmRDzojtpT4pBo04eMMYYD8RfzOmzGv/HQ0Mn3WPerKs
 pbEKgmc8PeEQ==
X-Talos-CUID: 9a23:yOJfuWGwanKgErYbqmJb8xEZPc0reUbU81ndD32yLztbcoSsHAo=
X-Talos-MUID: 9a23:SdNBywv37Wg7jXGZrc2nhR5QBfoxv/WUU10BvbFdt+jDMixyAmLI
X-IronPort-Anti-Spam-Filtered: true
Received: from alln-l-core-04.cisco.com ([173.36.16.141])
 by alln-iport-1.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 19 Mar 2025 07:21:32 +0000
Received: from alln-opgw-4.cisco.com (alln-opgw-4.cisco.com [173.37.147.252])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by alln-l-core-04.cisco.com (Postfix) with ESMTPS id A6B301800019A
 for <dev@dpdk.org>; Wed, 19 Mar 2025 07:21:32 +0000 (GMT)
X-CSE-ConnectionGUID: rvqJJ5GjTiu2ePJ8+wRveg==
X-CSE-MsgGUID: Yoglh1pmQLa1kk7axQw4Ew==
Authentication-Results: alln-opgw-4.cisco.com;
 dkim=pass (signature verified) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.14,259,1736812800"; d="scan'208,217";a="44687095"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
 by alln-opgw-4.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 19 Mar 2025 07:21:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bVO/09gFB+50kvORaG6iRh6/7LaMIswRn+gdIS4R6lCCG00wJ+ZuRAFVDZpy3PQ/SZIhXYu7iatPSnLIFx7dywflI6FjMYwSqoxqvdsLywCG2ZeFfm0T9K9Z3NbWiNyCCeE9XHzCFrKTfozwq98GzHyuSjgUAs1sCasgW3kpUj6VKKUcfYiuiSLcGwv1KWv1doHTd43Td6RsIXdYUiuuXOoiFnuhfzQDkETaDI+jZ7rV+yjV91gXcOFw1oyWuFOo1kYrxtXnkUrn9RKdEku2qgBc02iju9LkNK9xufLUgPL88FuO7StSHt6V+oFlUvPKihcpJ2LmBh9mgwbsvYDq3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1OYsq2CJibJHpehKnCRpfwW4bc8y1VxAtOim75qzXo0=;
 b=NymNr243jgHqgcfhm0gxgGLIq4h3L8bt/ULd65guBkb2QLJ3iH4XKBENDFfSvd/XxX8CTeOKFuT06zKeJ0JhmQr0m6OcV42IgM/jKahQc2o0ffp8EqiwwAMlrqWWRqJtVXMEV9ttuoP9gTG5pQqf8VoL8O725mhXa5MkRMZRj9LjFf/1JcyMUdfj6tSW9tXmQ7ddB3ZINlAi0/BDJEJQPYOu9hYhoceWb6h1LnYnPSRloAt3UhLPr0dwD8L6N9iC02cLFIkyJxfflN0Rci0et7ZQhPySdXpBmyNmvbNfC4UAxzNx5Rw7/XVVEbtsm+8s/GvTk8MJbD+umkzYlbDwfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from BN9PR11MB5354.namprd11.prod.outlook.com (2603:10b6:408:11b::7)
 by DS0PR11MB8083.namprd11.prod.outlook.com (2603:10b6:8:15e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 07:21:31 +0000
Received: from BN9PR11MB5354.namprd11.prod.outlook.com
 ([fe80::5e9:ab74:5c12:ee2d]) by BN9PR11MB5354.namprd11.prod.outlook.com
 ([fe80::5e9:ab74:5c12:ee2d%5]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 07:21:30 +0000
From: "Rajesh Goel (rajegoel)" <rajegoel@cisco.com>
To: "dev@dpdk.org" <dev@dpdk.org>
Subject: Dpdk-pdump not capturing packet for vmxnet3 device
Thread-Topic: Dpdk-pdump not capturing packet for vmxnet3 device
Thread-Index: AduYl47uBAWkTPkqQ9ilcJultX2k8w==
Date: Wed, 19 Mar 2025 07:21:30 +0000
Message-ID: <BN9PR11MB53545D51138B2F27A402659EDDD92@BN9PR11MB5354.namprd11.prod.outlook.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5354:EE_|DS0PR11MB8083:EE_
x-ms-office365-filtering-correlation-id: 13f37886-7268-4269-4b5f-08dd66b6ab7c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?v0v4g0ocSRrsQu53NPV9GwYUxSaK+vau5D2z//DqexLd/kSclXwiWSL51MDd?=
 =?us-ascii?Q?M7nPwa1eN/MfvWXTBoBUjhnTlQzfVI5mN4ALNYqxa8670btyPDEbnD1qrduA?=
 =?us-ascii?Q?wIHhbbmans580hY9p1/maNO0Cu5VLu6Xh0+FrKzy2cfn8i9ws8uuZvb7pj//?=
 =?us-ascii?Q?MtgdgRnAVCyLLlud+kkloHNtpuWuZoc38cz9fKFEnedc4uot9+BM4qCmKxCX?=
 =?us-ascii?Q?zNBquPHgF+WXyk2NFs4NjYz3l8JB0YYvH2wTIxI0dZZj5KPq9TQuCbpEWHE7?=
 =?us-ascii?Q?sWQsI/6yqJx1W8cr/aypZLB4SQV6EXeRwUbzW81z7jmb3P/eJpXpP231NdhF?=
 =?us-ascii?Q?5AZ2c3BpR7de8dWQ/NWabYv6QeTpC/CogLM9UPAak2bsMc+cVU8kZCkSV/mf?=
 =?us-ascii?Q?xgb5WNNY6kwKT4ffZHudgX4vSLyr6vOrU8Ymwh3dUGqrsEeIKarzif3lEuPb?=
 =?us-ascii?Q?TT/u9OFagPjnuGPuUoOGVylDGZ5xk5qfDcJu6Uc8S3Ue8OYRXFnoTmMj5TcQ?=
 =?us-ascii?Q?6cCYw6sksacG47D7oJFg8/lOGvofmPyuOMVplwyS6pHyfY0G2n+RoEmS68An?=
 =?us-ascii?Q?c15Tx2Ld2biFfcR9x0gUTZKHdw0/w4TwoE1ByLoP/NxOEGmxKBKeeR2K+dIm?=
 =?us-ascii?Q?SNo/v06YuT2T6ETvPsCyu7ti6ewmufMdXiH0uhTFGlmmoCTwAOpXVK1syoMC?=
 =?us-ascii?Q?knI7TvDdo42dza89zUquj2GHxswJ4ZS0AJWsUbZp4LJIZKt4nDfdlleij2LU?=
 =?us-ascii?Q?C15o45s/lrynDkvuL9zaMOaLrxaI2+/5yFhiKUCtYi5TONFojy5R4jWxswC/?=
 =?us-ascii?Q?Vqsx4SzQz+deH23U1T0mjLtQn7aohAgspu2TqMlLhrE4+hu6WnlH1lyCOeh1?=
 =?us-ascii?Q?V4R5jeXIWK0UwYUDjnPxXirkv8QTEmq51tOHiZKR8GaK+8cSjsbbp3a9WixG?=
 =?us-ascii?Q?IZ+g/eO8Ao3gAFoEdct7RxHifpciGncixUz0SBsYAlOk7bvfgpFI2R57ZBj9?=
 =?us-ascii?Q?NsP4M/MlQR0AikJusWKBDyQKIgg1+cTm6cTthObSP5glv0ksJQ8F1398pGks?=
 =?us-ascii?Q?WP049eCxM0S7rAEwj90j9YjIzpctOBV9yuvLK92jGAU7XamkjnB1WVAu1RXt?=
 =?us-ascii?Q?brUH8z0keOzFNvV+u5+xl9i1pqV+i1ZJ4kA2yfX+m8CPnbZXmPRWk6kNm1AZ?=
 =?us-ascii?Q?u0L8yrNHLYfJcjHg5sSSHXGAUPwzFx/0qH8F71zp1a6OjD+hkrgKgaUfM/Y7?=
 =?us-ascii?Q?OQWgb13JrlQdzxThjMzdmF6s3X7O+RFf06umvfWody0xo5Wiahs5x70UmH/F?=
 =?us-ascii?Q?F04BCTPgnRdAG+PFoHO3D3jx2uuqdqB6M2aDu7/SJK5h6aE4jEiAWnzyDltF?=
 =?us-ascii?Q?PgtX6JKVnVXk1RCPOHvkSEIeUr00hdGz0Dl8g2ipTtA2uHPrrwbMKgWA7Xuz?=
 =?us-ascii?Q?mhR5Tds0yV05+Vf3dEa9XbPAilKDSMoV?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5354.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pCMfO+r6fI3YePuvHq81BMP4yKasOcnFp10s6ocY45+hgcDSPEGP3YttW3Iu?=
 =?us-ascii?Q?y2X2HqeR1dnHfMPcF0Q3YVaqpKEJdVZYM+K8HcJ9PA7je0cY8BKs3BU33k3C?=
 =?us-ascii?Q?NsKsdtdbZdn/PA4+d2z7qC1DC/B1+RMZcmA5htaCGjfGMFGUVbBeCf/IBUWN?=
 =?us-ascii?Q?293Z+3okqLq1xulWWqfOkvdYLA2RqJDXOsu1mfO9xzoQQclcGuTgaSDAZ92K?=
 =?us-ascii?Q?mEZBx+9SOTVPbiW6o0EPjdR1PxmVDqjBMi0xKfaqEBNSo3LoHGnMNUoOQlQH?=
 =?us-ascii?Q?tI6eHICTLdoj0DXh7GPmyPmq3RQNITwSV20LBOJg30uPqXE7LiE9w5Zj7KKz?=
 =?us-ascii?Q?4ALEgEpN7kzkXildQpEXBA42QoZJN/aTygXkgtW0RuaLCWQAMUthvFpPhi+n?=
 =?us-ascii?Q?IuLKp93dmMMoUvdvzgpGx3eKjstri+XLIE7GUPwHW+kN8u3TF5dMGZp9mTGg?=
 =?us-ascii?Q?3JAEabyK58dozn2G0lF9D4eyVMGpCkHcbIDRCKOctA4/tO1NxKFZUlb5UD18?=
 =?us-ascii?Q?18ZJNDTU4lcKMuZAiajrxTAMDH4xuzVjVwPGigD5AW544Zfp07wPwa41guHG?=
 =?us-ascii?Q?tZg8Fz07mYCRibq3xyO9CXK6ucq8oiN9Dwvc0iAAE/Cb+oNBYwMu4lhbhBeU?=
 =?us-ascii?Q?DNwBxYhVbXCGTzH/R4iFztamFCAT4F5GSGxjJaKAz1PHjuNl29G+gezqnFnR?=
 =?us-ascii?Q?yfvXlR0KtRx5xT/RZhZRIE6u7guUpbD4YEAP5FzP9Ky9nbkkDU1gjBtCT8BX?=
 =?us-ascii?Q?KVM4EkGwcjYRqqGFRql0sbEq8MpWLwWa8EYdyFXQZK48gSqej1orUIPHVdgo?=
 =?us-ascii?Q?WYiFJE9oevG2NJMgbARpGYmQvalq/erPe647gwUYMrMzxLddWnnryA1HahhA?=
 =?us-ascii?Q?fydayW8mw/dCwwyUEaAeAev3XV2B/dW2g+bNorkLDRzbbFInMtr+B52t059M?=
 =?us-ascii?Q?HCt4C8HLIc4GoXkphbL1ZWlB1ajPzGK+awyAMSWVBjzNWfdbbiL/f5PLbeq0?=
 =?us-ascii?Q?mM0FCi8xjhMKz2QJzOzQLrf1DTHscUnV6EA24+tcPHuFyMpM7dQVpAaKyY01?=
 =?us-ascii?Q?pQX6vSVAACEICOjY1n01++7QRceu2b548Hu1pN96O19IwlJICBqITSHQxVa5?=
 =?us-ascii?Q?C4UNATBBYqraLws8Yef0uqTNoQafGbiye+OZSi8vS79jaqUMJ2AllCyFt3Mg?=
 =?us-ascii?Q?ClEKYTf0wKHjcreIfbyKbWwS8K58YEDIgSRchPp7XUAnGTP5FhwFoB85+8BE?=
 =?us-ascii?Q?8NT3e2n48wVpYH/c18psVAsJjZUHJ3HmWfOObhhSb70AJ58C8sjpF/flKe7y?=
 =?us-ascii?Q?oPQyTPr21y+DOOkWspUxEiGI6f0jGx/iKTIrty8/nmKNaaPvwinF9wZkKZH5?=
 =?us-ascii?Q?CNbqqtXL2spvd6tRlKPE6LRWIZ9scEDsoFRhyGw9IWYwG37lzU2qgJqcLyBg?=
 =?us-ascii?Q?wtdIgEIsw0LKQ4sY8DbzJiLvpTnEcChqHjyezijp/oE20J92VkOnWgsubT3M?=
 =?us-ascii?Q?GmMFH4SPKtI3y1VKfdlfGlFwKkqlEp03YlWhFUzfOZnTSpz1zGZFDiF6a2FV?=
 =?us-ascii?Q?EE11PUwGQThoN3UGgQ9XQU+fKz+89aMI1bNkp6SO?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR11MB53545D51138B2F27A402659EDDD92BN9PR11MB5354namp_"
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5354.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13f37886-7268-4269-4b5f-08dd66b6ab7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2025 07:21:30.3313 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nYFoW40QA6v2JsHdpBN9OL59Ikll9m3l2TqKHJZpkeJY/JX7fEk96Jb26zt8y4kSyRgxwMQwN7jj2cWbCzIg1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8083
X-Outbound-SMTP-Client: 173.37.147.252, alln-opgw-4.cisco.com
X-Outbound-Node: alln-l-core-04.cisco.com
X-Mailman-Approved-At: Wed, 19 Mar 2025 11:14:30 +0100
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

--_000_BN9PR11MB53545D51138B2F27A402659EDDD92BN9PR11MB5354namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi DPDK community,

I need some urgent help.

1)      Iam running my dpdk application on a VMware based VM. Iam using 20.=
11.9 dpdk version
Iam directly connected to the PCI device to receive pkts on my application.

      :
      EAL: Detected 16 lcore(s)
      EAL: Detected 1 NUMA nodes
      EAL: Detected shared linkage of DPDK
      EAL: Multi-process socket /var/run/dpdk/rte/mp_socket
      EAL: Selected IOVA mode 'PA'
      EAL: No available hugepages reported in hugepages-1048576kB
      EAL: Probing VFIO support...
      EAL: VFIO support initialized
      EAL: Probe PCI driver: net_vmxnet3 (15ad:7b0) device: 0000:04:00.0 (s=
ocket 0)
      EAL: No legacy callbacks, legacy socket not created
      :

2)      Iam trying to use dpdk-pdump application to capture packets.

      dpdk-pdump -l 3 -- --pdump 'device_id=3D0000:04:00.0,queue=3D*,rx-dev=
=3D/tmp/rx.pcap,total-num-mbufs=3D8192,ring-size=3D128'

      EAL: Detected 16 lcore(s)
      EAL: Detected 1 NUMA nodes
      EAL: Detected static linkage of DPDK
      EAL: Multi-process socket /var/run/dpdk/rte/mp_socket_644376_50d5dc20=
612f8
      EAL: Selected IOVA mode 'PA'
      EAL: Probing VFIO support...
      EAL: VFIO support initialized
      EAL: Probe PCI driver: net_vmxnet3 (15ad:7b0) device: 0000:04:00.0 (s=
ocket 0)
      Port 1 MAC: 02 70 63 61 70 00
       core (3), capture for (1) tuples
       - port 0 device (0000:04:00.0) queue 65535
      ^C

      Signal 2 received, preparing to exit...
      ##### PDUMP DEBUG STATS #####
       -packets dequeued:                                       0
       -packets transmitted to vdev:            0
       -packets freed:                                  0

This is the mempool and ring which got created in app side

            ring <MP_pdump_pool_0>@0x10045db00
              flags=3D0
              size=3D16384
              capacity=3D16383
              ct=3D0
              ch=3D0
              pt=3D8192
              ph=3D8192
              used=3D8192
              avail=3D8191
            ring <rx_ring_0>@0x102802680
              flags=3D0
              size=3D128
              capacity=3D127
              ct=3D0
              ch=3D0
              pt=3D0
              ph=3D0
              used=3D0
              avail=3D127

This is the port output, port 0 is application and port 1 is created by pdu=
mp and no pkt is seen to be captured.

Port 0 stats:
 - link status: 1
 - Pkts in:   50
 - Pkts out:  0
 - total ibytes: 4024
 - total obytes: 0
 - rx miss: 0
 - In Errs:   0
 - Out Errs:  0
 - Mbuf Errs: 0
 - Q Rx Packets:

Port 1 stats:
 - link status: 1
 - Pkts in:   0
 - Pkts out:  0
 - total ibytes: 0
 - total obytes: 0
 - rx miss: 0
 - In Errs:   0
 - Out Errs:  0
 - Mbuf Errs: 0
 - Q Rx Packets:

3)      I see the same result while using dpdk-testpmd on the APP side.

4)      As per this page, https://doc.dpdk.org/guides/tools/pdump.html.
      Is this applicable to vmxnet3 device here ??

*       As of now the dpdk-pdump tool cannot capture the packets of virtual=
 devices in the primary process due to a bug in the ethdev library. Due to =
this bug, in a multi process context, when the primary and secondary have d=
ifferent ports set, then the secondary process (here the dpdk-pdump tool) o=
verwrites the rte_eth_devices[] entries of the primary process.

Thanks
Rajesh



--_000_BN9PR11MB53545D51138B2F27A402659EDDD92BN9PR11MB5354namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from rtf -->
<style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left:=
 #800000 2px solid; } --></style>
</head>
<body>
<font face=3D"Aptos" size=3D"3"><span style=3D"font-size:12pt;">
<div>Hi DPDK community, </div>
<div>&nbsp;</div>
<div>I need some urgent help.</div>
<div>&nbsp;</div>
<ol style=3D"margin:0;padding-left:36pt;list-style-type:decimal;">
<li>Iam running my dpdk application on a VMware based VM. <span style=3D"ba=
ckground-color:yellow;"><b>Iam using 20.11.9 </b></span><span style=3D"back=
ground-color:yellow;"><b>dpdk </b></span><span style=3D"background-color:ye=
llow;"><b>version</b></span></li></ol>
<div style=3D"text-indent:36pt;">Iam directly connected to the PCI device t=
o receive pkts on my application. </div>
<div>&nbsp;</div>
<div style=3D"text-indent:36pt;padding-left:36pt;"><font face=3D"Courier Ne=
w">: </font></div>
<div style=3D"text-indent:36pt;padding-left:36pt;"><font face=3D"Courier Ne=
w">EAL: Detected 16 lcore(s)</font></div>
<div style=3D"text-indent:36pt;padding-left:36pt;"><font face=3D"Courier Ne=
w">EAL: Detected 1 NUMA nodes</font></div>
<div style=3D"text-indent:36pt;padding-left:36pt;"><font face=3D"Courier Ne=
w">EAL: Detected shared linkage of DPDK</font></div>
<div style=3D"text-indent:36pt;padding-left:36pt;"><font face=3D"Courier Ne=
w">EAL: Multi-process socket /var/run/dpdk/rte/mp_socket</font></div>
<div style=3D"text-indent:36pt;padding-left:36pt;"><font face=3D"Courier Ne=
w">EAL: Selected IOVA mode 'PA'</font></div>
<div style=3D"text-indent:36pt;padding-left:36pt;"><font face=3D"Courier Ne=
w">EAL: No available hugepages reported in hugepages-1048576kB</font></div>
<div style=3D"text-indent:36pt;padding-left:36pt;"><font face=3D"Courier Ne=
w">EAL: Probing VFIO support...</font></div>
<div style=3D"text-indent:36pt;padding-left:36pt;"><font face=3D"Courier Ne=
w">EAL: VFIO support initialized</font></div>
<div style=3D"text-indent:36pt;padding-left:36pt;"><font face=3D"Courier Ne=
w">EAL: Probe PCI driver: net_vmxnet3 (15ad:7b0) device: 0000:04:00.0 (sock=
et 0)</font></div>
<div style=3D"text-indent:36pt;padding-left:36pt;"><font face=3D"Courier Ne=
w">EAL: No legacy callbacks, legacy socket not created</font></div>
<div style=3D"text-indent:36pt;padding-left:36pt;"><font face=3D"Courier Ne=
w"><b>:</b></font></div>
<div>&nbsp;</div>
<ol start=3D"2" style=3D"margin:0;padding-left:36pt;list-style-type:decimal=
;">
<li>Iam trying to use dpdk-pdump application to capture packets.</li></ol>
<div>&nbsp;</div>
<div style=3D"text-indent:36pt;padding-left:36pt;"><font face=3D"Courier Ne=
w">dpdk-pdump -l 3 -- --pdump 'device_id=3D0000:04:00.0,queue=3D*,rx-dev=3D=
/tmp/rx.pcap,total-num-mbufs=3D8192,ring-size=3D128'</font></div>
<div style=3D"text-indent:36pt;padding-left:36pt;">&nbsp;</div>
<div style=3D"text-indent:36pt;padding-left:36pt;"><font face=3D"Courier Ne=
w">EAL: Detected 16 lcore(s)</font></div>
<div style=3D"text-indent:36pt;padding-left:36pt;"><font face=3D"Courier Ne=
w">EAL: Detected 1 NUMA nodes</font></div>
<div style=3D"text-indent:36pt;padding-left:36pt;"><font face=3D"Courier Ne=
w">EAL: Detected static linkage of DPDK</font></div>
<div style=3D"text-indent:36pt;padding-left:36pt;"><font face=3D"Courier Ne=
w">EAL: Multi-process socket /var/run/dpdk/rte/mp_socket_644376_50d5dc20612=
f8</font></div>
<div style=3D"text-indent:36pt;padding-left:36pt;"><font face=3D"Courier Ne=
w">EAL: Selected IOVA mode 'PA'</font></div>
<div style=3D"text-indent:36pt;padding-left:36pt;"><font face=3D"Courier Ne=
w">EAL: Probing VFIO support...</font></div>
<div style=3D"text-indent:36pt;padding-left:36pt;"><font face=3D"Courier Ne=
w">EAL: VFIO support initialized</font></div>
<div style=3D"text-indent:36pt;padding-left:36pt;"><font face=3D"Courier Ne=
w">EAL: Probe PCI driver: net_vmxnet3 (15ad:7b0) device: 0000:04:00.0 (sock=
et 0)</font></div>
<div style=3D"text-indent:36pt;padding-left:36pt;"><font face=3D"Courier Ne=
w"><b>Port 1 MAC: 02 70 63 61 70 00</b></font></div>
<div style=3D"text-indent:36pt;padding-left:36pt;"><font face=3D"Courier Ne=
w"> <b>core (3), capture for (1) tuples</b></font></div>
<div style=3D"text-indent:36pt;padding-left:36pt;"><font face=3D"Courier Ne=
w"> - <b>port 0 device (0000:04:00.0) queue 65535</b></font></div>
<div style=3D"text-indent:36pt;padding-left:36pt;"><font face=3D"Courier Ne=
w">^C</font></div>
<div style=3D"text-indent:36pt;padding-left:36pt;"><font face=3D"Courier Ne=
w">&nbsp;</font></div>
<div style=3D"text-indent:36pt;padding-left:36pt;"><font face=3D"Courier Ne=
w">Signal 2 received, preparing to exit...</font></div>
<div style=3D"text-indent:36pt;padding-left:36pt;"><font face=3D"Courier Ne=
w">##### PDUMP DEBUG STATS #####</font></div>
<div style=3D"text-indent:36pt;padding-left:36pt;"><font face=3D"Courier Ne=
w"> -packets dequeued:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0</font></div>
<div style=3D"text-indent:36pt;padding-left:36pt;"><font face=3D"Courier Ne=
w"> -packets transmitted to vdev:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; 0</font></div>
<div style=3D"text-indent:36pt;padding-left:36pt;"><font face=3D"Courier Ne=
w"> -packets freed:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; 0</font></div>
<div>&nbsp;</div>
<div style=3D"text-indent:36pt;">This is the mempool and ring which got cre=
ated in app side</div>
<div>&nbsp;</div>
<div style=3D"padding-left:72pt;"><font face=3D"Courier New">ring &lt;MP_pd=
ump_pool_0&gt;@0x10045db00</font></div>
<div style=3D"padding-left:72pt;"><font face=3D"Courier New">&nbsp; flags=
=3D0</font></div>
<div style=3D"padding-left:72pt;"><font face=3D"Courier New">&nbsp; size=3D=
16384</font></div>
<div style=3D"padding-left:72pt;"><font face=3D"Courier New">&nbsp; capacit=
y=3D16383</font></div>
<div style=3D"padding-left:72pt;"><font face=3D"Courier New">&nbsp; ct=3D0<=
/font></div>
<div style=3D"padding-left:72pt;"><font face=3D"Courier New">&nbsp; ch=3D0<=
/font></div>
<div style=3D"padding-left:72pt;"><font face=3D"Courier New">&nbsp; pt=3D81=
92</font></div>
<div style=3D"padding-left:72pt;"><font face=3D"Courier New">&nbsp; ph=3D81=
92</font></div>
<div style=3D"padding-left:72pt;"><font face=3D"Courier New">&nbsp; used=3D=
8192</font></div>
<div style=3D"padding-left:72pt;"><font face=3D"Courier New">&nbsp; avail=
=3D8191</font></div>
<div style=3D"padding-left:72pt;"><font face=3D"Courier New">ring &lt;rx_ri=
ng_0&gt;@0x102802680</font></div>
<div style=3D"padding-left:72pt;"><font face=3D"Courier New">&nbsp; flags=
=3D0</font></div>
<div style=3D"padding-left:72pt;"><font face=3D"Courier New">&nbsp; size=3D=
128</font></div>
<div style=3D"padding-left:72pt;"><font face=3D"Courier New">&nbsp; capacit=
y=3D127</font></div>
<div style=3D"padding-left:72pt;"><font face=3D"Courier New">&nbsp; <b>ct=
=3D0</b></font></div>
<div style=3D"padding-left:72pt;"><font face=3D"Courier New"><b>&nbsp; ch=
=3D0</b></font></div>
<div style=3D"padding-left:72pt;"><font face=3D"Courier New"><b>&nbsp; pt=
=3D0</b></font></div>
<div style=3D"padding-left:72pt;"><font face=3D"Courier New"><b>&nbsp; ph=
=3D0</b></font></div>
<div style=3D"padding-left:72pt;"><font face=3D"Courier New">&nbsp; used=3D=
0</font></div>
<div style=3D"padding-left:72pt;"><font face=3D"Courier New">&nbsp; avail=
=3D127</font></div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </div>
<div style=3D"text-indent:36pt;">This is the port output, port 0 is applica=
tion and port 1 is created by pdump and no pkt is seen to be captured.</div=
>
<div style=3D"text-indent:36pt;">&nbsp;</div>
<div style=3D"text-indent:36pt;"><font face=3D"Courier New">Port 0 stats:</=
font></div>
<div style=3D"text-indent:36pt;"><font face=3D"Courier New"> - link status:=
 1</font></div>
<div style=3D"text-indent:36pt;"><font face=3D"Courier New"> <b>- Pkts in:&=
nbsp;&nbsp; 50</b></font></div>
<div style=3D"text-indent:36pt;"><font face=3D"Courier New"> - Pkts out:&nb=
sp; 0</font></div>
<div style=3D"text-indent:36pt;"><font face=3D"Courier New"> - total ibytes=
: 4024</font></div>
<div style=3D"text-indent:36pt;"><font face=3D"Courier New"> - total obytes=
: 0</font></div>
<div style=3D"text-indent:36pt;"><font face=3D"Courier New"> - rx miss: 0</=
font></div>
<div style=3D"text-indent:36pt;"><font face=3D"Courier New"> - In Errs:&nbs=
p;&nbsp; 0</font></div>
<div style=3D"text-indent:36pt;"><font face=3D"Courier New"> - Out Errs:&nb=
sp; 0</font></div>
<div style=3D"text-indent:36pt;"><font face=3D"Courier New"> - Mbuf Errs: 0=
</font></div>
<div style=3D"text-indent:36pt;"><font face=3D"Courier New"> - Q Rx Packets=
: </font></div>
<div style=3D"text-indent:36pt;"><font face=3D"Courier New">&nbsp;</font></=
div>
<div style=3D"text-indent:36pt;"><font face=3D"Courier New">Port 1 stats:&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </font></div>
<div style=3D"text-indent:36pt;"><font face=3D"Courier New"> - link status:=
 1</font></div>
<div style=3D"text-indent:36pt;"><font face=3D"Courier New"><b> - Pkts in:&=
nbsp;&nbsp; 0</b></font></div>
<div style=3D"text-indent:36pt;"><font face=3D"Courier New"> - Pkts out:&nb=
sp; 0</font></div>
<div style=3D"text-indent:36pt;"><font face=3D"Courier New"> - total ibytes=
: 0</font></div>
<div style=3D"text-indent:36pt;"><font face=3D"Courier New"> - total obytes=
: 0</font></div>
<div style=3D"text-indent:36pt;"><font face=3D"Courier New"> - rx miss: 0</=
font></div>
<div style=3D"text-indent:36pt;"><font face=3D"Courier New"> - In Errs:&nbs=
p;&nbsp; 0</font></div>
<div style=3D"text-indent:36pt;"><font face=3D"Courier New"> - Out Errs:&nb=
sp; 0</font></div>
<div style=3D"text-indent:36pt;"><font face=3D"Courier New"> - Mbuf Errs: 0=
</font></div>
<div style=3D"text-indent:36pt;"><font face=3D"Courier New"> - Q Rx Packets=
:</font></div>
<div>&nbsp;</div>
<ol start=3D"3" style=3D"margin:0;padding-left:36pt;list-style-type:decimal=
;">
<li>I see the same result while using dpdk-testpmd on the APP side.</li></o=
l>
<div>&nbsp;</div>
<ol start=3D"4" style=3D"margin:0;padding-left:36pt;list-style-type:decimal=
;">
<li>As per this page, <a href=3D"https://doc.dpdk.org/guides/tools/pdump.ht=
ml"><font color=3D"#467886"><u>https://doc.dpdk.org/guides/tools/pdump.html=
</u></font></a>.</li></ol>
<div style=3D"padding-left:36pt;">Is this applicable to vmxnet3 device here=
 ??</div>
<div style=3D"padding-left:36pt;">&nbsp;</div>
<ul style=3D"margin:0;padding-left:54pt;">
<li><span style=3D"background-color:yellow;"><i>As of now the&nbsp;dpdk-pdu=
mp&nbsp;tool cannot capture the packets of virtual devices in the primary p=
rocess due to a bug in the ethdev library. Due to this bug, in a multi proc=
ess context, when the primary and secondary
have different ports set, then the secondary process (here the&nbsp;dpdk-pd=
ump&nbsp;tool) overwrites the&nbsp;rte_eth_devices[]&nbsp;entries of the pr=
imary process.</i></span></li></ul>
<div>&nbsp;</div>
<div>Thanks</div>
<div>Rajesh </div>
<div style=3D"padding-left:36pt;">&nbsp;</div>
<div style=3D"padding-left:36pt;">&nbsp;</div>
</span></font>
</body>
</html>

--_000_BN9PR11MB53545D51138B2F27A402659EDDD92BN9PR11MB5354namp_--
