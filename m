Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB181C43458
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Jul 2026 09:57:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E2D7E402BB;
	Thu,  9 Jul 2026 11:57:09 +0200 (CEST)
Received: from rcdn-iport-3.cisco.com (rcdn-iport-3.cisco.com [173.37.86.74])
 by mails.dpdk.org (Postfix) with ESMTP id D080F4028C;
 Thu,  9 Jul 2026 11:57:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cisco.com; i=@cisco.com; l=3227; q=dns/txt;
 s=iport01; t=1783591028; x=1784800628;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=GKJbpQmaqlpu9bRij6e1SYiSm8lrvsdcZ7EjrNhjl5U=;
 b=bIJ6tKXprEs1sftQEOzZh0359rPaV9mNS8JdbXrhG/uv0Y6bIxVzWEBc
 /qiXaFzyL4cz9htk15r5w5mUmwm4FBt7szRP5dOVfksvQf33d22PbZMLO
 ej/s8WrKJ8SfTJaHCYbPaJb+37YyM7A9Q9PHdT8UMzpWnNug2F4b0Ib3+
 n2tQl4RopKkdD9nlA8W3S0+05iTPgxQwG+BAzIsS6isOg785i1nTP319C
 ioIm6cLAV31NJnZbkadJtLZMJ4X3DI/umxXhTLJpbwVFKzlUrNTHocb6K
 S6OBPn0RPR+svxw3N8WMtQp27YyE2d8ieuFYbVhsnyhD9SSR4atKR2BYc g==;
X-CSE-ConnectionGUID: KP2hZumzQTC30jN/5Lu/YA==
X-CSE-MsgGUID: 8dK7CK51SpW9mqEGSIC//Q==
X-IPAS-Result: =?us-ascii?q?A0A6AAD5bk9q/5D/Ja1aHQEBAQEJARIBBQUBZYEXCAELA?=
 =?us-ascii?q?YFtU4IrSYgjA4RMX4h5A4tkkjeBfg8BAQENAlEEAQGFBQKNTQImNAkOAQIEA?=
 =?us-ascii?q?wIDAQEBAQEBAQEBAQELAQEFAQEBAgEHBYEOE4ZchloBAQEBAxIVEz8MBAIBC?=
 =?us-ascii?q?A4DBAEBHxAgER0IAgQBDQUIGoUbAzYDAQKsVQGBPQKKKniBATOBAd1GDYJkF?=
 =?us-ascii?q?AGBOAGFPoJ8HwEBhDyBIAFUhEEnG4FJRIEVQoJpPoIfgiaEE4IwBIIigQyRZ?=
 =?us-ascii?q?VJ4HANZLAFVExcLBwWBIxAzAyAKLy0CFA0PEw8aBS0dcAwnEg8dFxYeWBsHB?=
 =?us-ascii?q?RIgKkFFIwMaA1MxEDgLQwWBWQKCCE4jHwM5f4EwdUp5LYEAAQIQHgpsQiSCF?=
 =?us-ascii?q?gI6AwttPTcGDhsDBIE1BY01Fw+CPgGBDoFDZVECxXBxCoQdm1+GMheqbJkII?=
 =?us-ascii?q?5FwlwUCBAIEBQIQAQEGgWg8gVlwFYMiUxkP4F15AjsCBwIHDgMLkWotgU8BA?=
 =?us-ascii?q?Q?=
IronPort-PHdr: A9a23:1iPn7hfngbv4saidN+ZbL+oYlGM/gIqcDmcuAtIPkblCdOGk55v9e
 RGZ7vR2h1iPVoLeuLpIiOvT5rjpQndIoY2Av3YLbIFWWlcbhN8XkQ0tDI/NCUDyIPPwKS1vN
 M9DT1RiuXq8NCBo
IronPort-Data: A9a23:D7ExDK2/SPsoUnNHWvbD5YRwkn2cJEfYwER7XKvMYLTBsI5bp2YDm
 zAdCG+FPfjeZmXwct11PYmyoBgA75fXnddqTgdp3Hw8FHgiRegpqji6wuYcGwvIc6UvmWo+t
 512huHodZ5yFjmH4E/xbtANlFEkvYmQXL3wFeXYDS54QA5gWU8JhAlq8wIDqtYAbeORXUXX5
 Lsen+WFYAX7g2EsYjpNg06+gEoHUMra6WtwUmMWPZinjHeG/1EJAZQWI72GLneQauF8Au6gS
 u/f+6qy92Xf8g1FIovNfmHTKxBirhb6ZGBiu1IOM0SQqkEqSh8ajs7XAMEhhXJ/0F1lqTzeJ
 OJl7vRcQS9xVkHFdX90vxNwS0mSNoUekFPLzOTWXcG7lyX7n3XQL/pGL3lsPb8F//ROPUoVr
 f4+b20pc1eyrrfjqF67YrEEasULNsLnOsYb/3pn1zycValgSpHYSKKM7thdtNsyrpkRRrCFO
 IxDNGcpNUicC/FMEg9/5JYWnPavgHr+dhVTqUmeouw85G27IAlZjeCybYeEJ4DWLSlTthaUh
 T3t3DmgOQklZdmG5BW+01nrwdaayEsXX6pXTtVU7MVCjFCN7mALBB5QUkG0ydGilke0X993J
 1QY+Wwpt6dayaCwZsP2Uxv9pDuPuQQRHoIPVeY78wqKjKHT5m51G1Q5c9KIU/R/3OceTj0x3
 VjPlNTsbQGDepXOIZ5B3t94dQ+PBBU=
IronPort-HdrOrdr: A9a23:BchGzq4rWvR23OCXVQPXwceCI+orL9Y04lQ7vn2ZFiYlEfBwxv
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
X-Talos-CUID: 9a23:EXTT+m29GbvfyVUcINTjobxfOfh/ck/AyWXpH2TjUWRPD+CxVBih0fYx
X-Talos-MUID: =?us-ascii?q?9a23=3AVXOF6w71RFHvNg97kPtoZ6Gvxow474fxI2NQyK4?=
 =?us-ascii?q?ehJiBLAFfABa2y3OOF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-l-core-07.cisco.com ([173.37.255.144])
 by rcdn-iport-3.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 09 Jul 2026 09:57:06 +0000
Received: from rcdn-opgw-5.cisco.com (rcdn-opgw-5.cisco.com [72.163.7.169])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by rcdn-l-core-07.cisco.com (Postfix) with ESMTPS id 77FDD18000491;
 Thu,  9 Jul 2026 09:57:06 +0000 (GMT)
X-CSE-ConnectionGUID: ejx+dASOQniwuE63+yRzWw==
X-CSE-MsgGUID: 6/DZT35ERIKwFa8dIfqqjQ==
Authentication-Results: rcdn-opgw-5.cisco.com;
 dkim=pass (signature verified) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="62608252"
Received: from mail-centralusazon11011034.outbound.protection.outlook.com
 (HELO DM5PR21CU001.outbound.protection.outlook.com) ([52.101.62.34])
 by rcdn-opgw-5.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 09 Jul 2026 09:57:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mokxv8tNWoYLyLocLklpkdv0D9YbvkcMjgPN9GfPMqEc6ctbhlNrVcXSGMMHZrtLTgwq4hjKIbRzis1SQdPLbOi3EB3yTyFksj6w9CZRkX5U3XQeqH507c62B/cqYGon3Ouwoy+/tHnzO7iEzGLG4CoV7IEW4PK4QmHr+Tqogsulw1CdiTd2008p8shSfnJdBnZdpozO8xcQHrBBWy9jEJ0anlyoZ9n9/24ObVrhXVvybMgeI3NPvKS0by3aKIA+OkjLQDSMIhyB6mXF+AfTG46bUpqKPwqVHu23M35wITw2nigLctDwwgaxN1ykzdNZQwbLlEwEP8KSv2Nwal000g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GKJbpQmaqlpu9bRij6e1SYiSm8lrvsdcZ7EjrNhjl5U=;
 b=T+dl6VS4c4zGI+xFqZ15r2fRWKs7poS8UmZF7V1RVLTW2pnIVCPjkZMPCwMI3Ga8yckfxLw7DA70Cr1UaHK/IfWHYG8vJrr7YQgWdeqOAOYqJI6nC6DP5f0gZwagpEMO1NS9Ru2SbIYmLQ2dHHkM1QhxeVAnv2bQ02FjCukQDNDH+80+b9xv21SuiOlH6TGgV0uGmHPBlVntmMSX6zboina9QNv2BekH/IPbzm+xAYMUnCYBFwPP9gUZtrY3pMFdV8ZpnuTGIEGNXddDmKd1cyepMs4rm86E9T9bSs+IxY7vufNNQpTuuzNBszgAgSDswleAeWqvyb5ATldtK1iYPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from IA3PR11MB8987.namprd11.prod.outlook.com (2603:10b6:208:574::18)
 by DS3PR11MB9671.namprd11.prod.outlook.com (2603:10b6:8:38e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 9 Jul 2026
 09:57:04 +0000
Received: from IA3PR11MB8987.namprd11.prod.outlook.com
 ([fe80::f91f:4301:96d7:1925]) by IA3PR11MB8987.namprd11.prod.outlook.com
 ([fe80::f91f:4301:96d7:1925%3]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 09:57:04 +0000
From: "Hyong Youb Kim (hyonkim)" <hyonkim@cisco.com>
To: Alexey Simakov <bigalex934@gmail.com>, Thomas Monjalon
 <thomas@monjalon.net>, "John Daley (johndale)" <johndale@cisco.com>, "Nelson
 Escobar (neescoba)" <neescoba@cisco.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH] net/enic: fix potential null dereference in flow mask
 check
Thread-Topic: [PATCH] net/enic: fix potential null dereference in flow mask
 check
Thread-Index: AQHdDe7O//fhB4P3jkOzms8HGuEnkrZk9jmw
Date: Thu, 9 Jul 2026 09:57:04 +0000
Message-ID: <IA3PR11MB8987402CDECFACC6831119E7BFFE2@IA3PR11MB8987.namprd11.prod.outlook.com>
References: <20260707085831.40355-1-bigalex934@gmail.com>
In-Reply-To: <20260707085831.40355-1-bigalex934@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8987:EE_|DS3PR11MB9671:EE_
x-ms-office365-filtering-correlation-id: ec1855f1-85b9-4883-e776-08dedda06e4a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|18002099003|38070700021|22082099003|56012099006|11063799006|6133799003;
x-microsoft-antispam-message-info: cYJ3AewzwBt5bk/km+WDr4VL7mZSp+q+QdSE27w1D3+/sRq6RZWt9YT+V0FyvkNRWv7Z2ngF8gJIlUxxUA0RyFakHRWqFUFz1ui4jQ5FNGHYyU1Fg79hv05tXAzArewaWN06rOe/VFiYhirPltjOtxeR9bq9x9wAm44tD3z45CCY/AmYWS16+CBiak/sLS1Br8MRIBPXA5Qq7YziO1zpk9CV6ZbFqwI4OWTUG09ZQmaWqiewppO1Ul/Mphu/pU7alKhHSAGh3AvuII+Aoooo1LxK2X/LKzvz2Ir+hOiaU06vYQONa/imXu/kfKphJzp6vYGkXGGpwqESov9pcsit1u7UHsdRR5tynpp6t3hmKuxJkeIZ5V8Ra6yXUOzAV1aKu3vuZuMA0jR3rRWXGnCiNaTBOeRNYOzf3grkx6rAhJMRnsJvQC6Fug6zHAiKApFnSA21tdb0JGObJbpHiwzuyaYtemnGT/8eDzGG9Mvej45AF/cP9m8PRJs37QYL0/skhmaB0ewGwgE5iobsbld9H9m//IXh2Kw9Dgevf4ONBZvkX2ezK7vrNLMrpyYCpQc+DYJwT4sjWT4M6I9cTWMqi3ZCBLlWWwZqNYV/tLipO32zHLmBxxm4FB4v9ILHv0j7/W6iAi5chcQa9MmKeOQ8rSe/XmyqeqvWHgwYNLt3HTe2YU8B+dQAXt+K0JbUNiLvemc5fZxvEKg8B9aWnSsdMOpPw8pbfZnuX37aZPg3Wec=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8987.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(18002099003)(38070700021)(22082099003)(56012099006)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MgGfEixj41e6WR+kHTtz3cPqQINsVZYK02C8CYaXq0/Ye0Aohi8w98o9XkMg?=
 =?us-ascii?Q?W7/YmF0lqxHm4Gq6Q9pJd8cbN83iCnZ/NC3lvcq8t3qLW0Uz3knTa8vq+fnq?=
 =?us-ascii?Q?ZPO2SOEScWV4aMosBkq9CW9xFH4+yZD/PXGcNZuAotD4mhGDCpaw7vUTuLep?=
 =?us-ascii?Q?DjiMaq/9pbNwZrgxDsaQ55gjuQvLmJoMTq2NidFkthOM51CQYQ1CIywJu/Z+?=
 =?us-ascii?Q?8Kgqnx5q2iVsawVNl+vD7GRoQt26nJ7fzOVjUpZzK2HQzZyd8H2taDFjNXAr?=
 =?us-ascii?Q?e/CmdPdmiO0GN5feAzKMyet2Pl1zsyeBiMGqfiz/iEZx61AcQDwfDEogiPAm?=
 =?us-ascii?Q?69NDjO7AMoeOovd9iHZi3afN8NqEZ1qUxQ/UlwlNw07AgktbCBo5HO3vQ9IX?=
 =?us-ascii?Q?w7QFqFrdPCwYYqQVRBJbz8SvAOnLoJVSqJj6v4vu0jrM0KrnBMQ1zZnPKTLP?=
 =?us-ascii?Q?1hW1l1Oun6JShHd0lxIsFVwd+yAXp/K1LYbH1nUdfbnRXZIYlbleqpOmlY7y?=
 =?us-ascii?Q?6KWNfAg58+DCrCXzCU5ypVMaO2hd5IImZWZpVwTpEwNf/kpxz51/bTL7/opl?=
 =?us-ascii?Q?K0wKtS+wGyEvR2KZmuMcy2Um2cqg4s7dxbYtbwSVqmbSTGnCrUu74dyNDtXq?=
 =?us-ascii?Q?KLZh/mi9NNPYsJFI7lhZUegjuHHQVqT0tqp4xKcTf3AnOVs9SS8TDCt+GV6e?=
 =?us-ascii?Q?bhrmcWrvZCp3YVLz0imxs523VewB3lKY6cL4WEoFD7oG8zv0rOdVjfv2OhhQ?=
 =?us-ascii?Q?AQ28a6NNAZoy51mbul8fZtLjiGPIQJ+hxMmHsDoqgz0JfPY7jMHiVmDA6qqf?=
 =?us-ascii?Q?EQP6moZ+1GAOTz/gvEfog/7W8vvprlnyttREfIY2MWP1Xr0efALZYXc9+//b?=
 =?us-ascii?Q?l80gMnp1XZdQd0QVQGwJB+Y6o6Kir+U6ga9OJbu4HmwgIrzjztis24H12/17?=
 =?us-ascii?Q?lgBZYuWSvNmCThuSzKJsLp9YbO7Qyck7D87erKseboAapHvaR0ZRFgqfULrS?=
 =?us-ascii?Q?Y3V98V+PBLUlo7HD2xYDBUMIt323TMe4f8CVcw61L/tUk5vkeFNsP1rAILly?=
 =?us-ascii?Q?LBzGWBAVDogJKbZgAgYp/XVI0pp94mYVkqW+6CCnsFrvOwEBY4IMXEltd9+p?=
 =?us-ascii?Q?dPJTboUhDP777Tvgga7bCn1rT9WYoO6C/4ZiKpb1fjAonEHGHxIzjtg9zYgd?=
 =?us-ascii?Q?qE8y/lyCNZDOs6KMclKXCoiIClYmeLADEV9gxHbbq+PRnOy/C0dMZ5rTtqap?=
 =?us-ascii?Q?mDYZ766fMB8Lz3IHzC7kYRvA68iZ65LVK4YzraRfO7o/zikTO/65wsin+Ctp?=
 =?us-ascii?Q?Pht1iFYbPEy0HkB8E2tc0ZBlcMIzw7PaKNFG8hwY1cAdV5y70ltMf7zVBqiy?=
 =?us-ascii?Q?prKOB6606IzJq+l1P0jLgTDMLKbNMcV2mkKk8cwryXAt1hxwuQoDs/F19XyO?=
 =?us-ascii?Q?wwJif4b1GG18nBzYTVDr2d9gtqu+T473KLXNGoAgo/0Z3Rhr1j7n9sigJoDR?=
 =?us-ascii?Q?zMfYp4s9ZddsLHixZq1C00u/GjALHMegnP8ypD0agxw4llF6Nq5Mk73OA27D?=
 =?us-ascii?Q?8GNuw29sGyqq03GUqQjCahGrCEwKVzAT5yOVZ8I1NatxOBXuqj0KgFgWyT9p?=
 =?us-ascii?Q?WN30SEy9arRuduX38PFg7iY3XiyJcUgtDtrHfYFNhUOfs3N1TsbxYTp39sbj?=
 =?us-ascii?Q?xsLuOtdy25aEdHgaWfd6S3tDcHIEc2opLA7pRbo/wqq3YA5n?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: EVcBViCwCsozWTVvXHbBeIYw1R66cOnx+aPBgr5bsUxTc/FzHTooNVGdQv1ughu23njNBYMxHWhx11lKik5SsdfQZ7o7rZk38MfCXEOK81CQ2qaNd/TAvrfy3XnrC9qZPk3wbM12jCWxSzs6bdjOvjiVbjQ2rsHT1abVoNpYzP7HeQI6gM20v/jOvnoOqKKydQ0iDNr9RpOr6TBnCtI5ZGlsg4a6mP9hcafSV2yaFioPnO1uvr5DrdhCUUPKnm/niU3C09c8aAKnb3zCxn5QXu3wsj0QZOofKIx7BS0JcO78p0XblpljBSaLu2smN1bStklGF2Zvjmy6xPB1rP4I0A==
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec1855f1-85b9-4883-e776-08dedda06e4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2026 09:57:04.8008 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SIMPY62FYCkIkErjYNcddpHA6Y2xuJIO4buPYmFM3BQT7B15JQBRvUSPNKf2u/SdxcDprXB9gUlBhmgPzhGTsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR11MB9671
X-Outbound-Client-TLS: ANONYMOUS; rcdn-opgw-5.cisco.com [72.163.7.169]; TLSv1.3;
 TLS_AES_256_GCM_SHA384; 256
X-Outbound-SMTP-Client: 72.163.7.169, rcdn-opgw-5.cisco.com
X-Outbound-Node: rcdn-l-core-07.cisco.com
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
> Sent: Tuesday, July 7, 2026 5:59 PM
> To: Thomas Monjalon <thomas@monjalon.net>; John Daley (johndale)
> <johndale@cisco.com>; Hyong Youb Kim (hyonkim) <hyonkim@cisco.com>;
> Nelson Escobar (neescoba) <neescoba@cisco.com>
> Cc: dev@dpdk.org; stable@dpdk.org; Alexey Simakov
> <bigalex934@gmail.com>
> Subject: [PATCH] net/enic: fix potential null dereference in flow mask ch=
eck
>=20
> The functions enic_copy_item_ipv4_v1(), enic_copy_item_udp_v1(), and
> enic_copy_item_tcp_v1() each initialize a local 'mask' variable from
> item->mask and substitute it with a hardcoded mask if NULL. However,
> the subsequent mask_exact_match() call uses item->mask directly
> instead of the local 'mask' variable, which will dereference NULL
> when item->mask is NULL.
>=20
> Use the local 'mask' variable (which has been validated and possibly
> substituted) instead of item->mask.
>=20
> Fixes: aa3d2ff82198 ("net/enic: flow API for Legacy NICs")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Alexey Simakov <bigalex934@gmail.com>
> ---
>  .mailmap                     | 1 +
>  drivers/net/enic/enic_flow.c | 6 +++---
>  2 files changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/.mailmap b/.mailmap
> index 4b5eb0c841..b154cd25a9 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -71,6 +71,7 @@ Alexander Skorichenko <askorichenko@netgate.com>
>  Alexander Solganik <solganik@gmail.com>
>  Alexander V Gutkin <alexander.v.gutkin@intel.com>
>  Alexandre Ferrieux <alexandre.ferrieux@orange.com>
> +Alexey Simakov <bigalex934@gmail.com>
>  Alexey Kardashevskiy <aik@ozlabs.ru>
>  Alfredo Cardigliano <cardigliano@ntop.org>
>  Ali Alnubani <alialnu@nvidia.com> <alialnu@mellanox.com>
> diff --git a/drivers/net/enic/enic_flow.c b/drivers/net/enic/enic_flow.c
> index 758000ea21..539b0eb725 100644
> --- a/drivers/net/enic/enic_flow.c
> +++ b/drivers/net/enic/enic_flow.c
> @@ -407,7 +407,7 @@ enic_copy_item_ipv4_v1(struct copy_item_args *arg)
>=20
>  	/* check that the supplied mask exactly matches capability */
>  	if (!mask_exact_match((const uint8_t *)&supported_mask,
> -			      (const uint8_t *)item->mask, sizeof(*mask))) {
> +			      (const uint8_t *)mask, sizeof(*mask))) {
>  		ENICPMD_LOG(ERR, "IPv4 exact match mask");
>  		return ENOTSUP;
>  	}
> @@ -445,7 +445,7 @@ enic_copy_item_udp_v1(struct copy_item_args *arg)
>=20
>  	/* check that the supplied mask exactly matches capability */
>  	if (!mask_exact_match((const uint8_t *)&supported_mask,
> -			      (const uint8_t *)item->mask, sizeof(*mask))) {
> +			      (const uint8_t *)mask, sizeof(*mask))) {
>  		ENICPMD_LOG(ERR, "UDP exact match mask");
>  		return ENOTSUP;
>  	}
> @@ -484,7 +484,7 @@ enic_copy_item_tcp_v1(struct copy_item_args *arg)
>=20
>  	/* check that the supplied mask exactly matches capability */
>  	if (!mask_exact_match((const uint8_t *)&supported_mask,
> -			     (const uint8_t *)item->mask, sizeof(*mask))) {
> +			     (const uint8_t *)mask, sizeof(*mask))) {
>  		ENICPMD_LOG(ERR, "TCP exact match mask");
>  		return ENOTSUP;
>  	}
> --
> 2.34.1

Can you remove .mailmap diff?

The enic patch looks like a valid fix.
Acked-by: Hyong Youb Kim <hyonkim@cisco.com>

Thanks.
-Hyong

