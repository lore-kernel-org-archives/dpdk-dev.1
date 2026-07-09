Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6EBC43458
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Jul 2026 12:07:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3235140655;
	Thu,  9 Jul 2026 14:07:54 +0200 (CEST)
Received: from alln-iport-2.cisco.com (alln-iport-2.cisco.com [173.37.142.89])
 by mails.dpdk.org (Postfix) with ESMTP id 4DCF1402EA;
 Thu,  9 Jul 2026 14:07:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cisco.com; i=@cisco.com; l=1704; q=dns/txt;
 s=iport01; t=1783598872; x=1784808472;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=qyFV7T5VL6MNNBmZE/DB4Df4OMJ6WpBQdBwiG1OLozg=;
 b=UL9t8FEcE4nbgR+PZVknZD7tZ1a889eOMCjDLIQa5Swq54GYWR9EjBQH
 xOHQl6+va4pXbI1tYqsoO3NI7DAHaqYoyk9GAXeGyasdph4D/2HK5hquB
 rjZKV9BV9cO7k1ps8WATXVcDYXcHakZrdNJbToTAdoOO6jqu0nyvcCSYw
 nBsFKYPXTEgBiBG4kV3S2lKL6fM8vuMnl5xHbJ8T28bIETtFoF7Jttmgu
 H5cVh8+IqVeXVR1q34wRJEj3kcG2/bUWmQwymQBOSUETJNEyDwttjVHak
 cgobZQ3dAmZ/78s4RyX/dDty44TehHwqeOj7Fd2HDiMY80vS0MueK4W+I g==;
X-CSE-ConnectionGUID: 7sPPokDGQ22AF7uzlVKy2w==
X-CSE-MsgGUID: Zmq8cjNbSA2fUH14WLzziA==
X-IPAS-Result: =?us-ascii?q?A0A6AACIjU9q/40QJK1aHQEBAQEJARIBBQUBZYEXCAELA?=
 =?us-ascii?q?YFtU4IrSYRXg0wDhExfiHyLZJI3gX4PAQEBD1EEAQGFBQIWjTcCJjQJDgECB?=
 =?us-ascii?q?AMCAwEBAQEBAQEBAQEBCwEBBQEBAQIBBwWBDhOGXIZaAQEBAQMSERFFDAQCA?=
 =?us-ascii?q?QgRBAEBAwImAgICHhEVCAgCBA4FCBqFGwM2AwECrQYBgT0Ciip6gTKBAd1GD?=
 =?us-ascii?q?YJkFAGBCi4BhT6CfB8BAYFwgkyBIAGFFScbgUlEgVeCaT6CH4ImFYNEOoIwB?=
 =?us-ascii?q?IIigQyRZQlJeHgsAVUTFwsHBWFCQwOBBiMPPAUtHYEjIR0XFh5YGwcFEiAqQ?=
 =?us-ascii?q?UUjAxoxBCFBOAtDBYFZAoIITiMfAzl/gTB1SnktgQABAhAeCmxCJIIWAjoDC?=
 =?us-ascii?q?209NxQbAwQ6ewWNNRcPgj+BDYFEZZcRAUmuaHEKhB2bX4YyF6psmQiSE5cFA?=
 =?us-ascii?q?gQCBAUCEAEBBoFoPIFZcBWDIlMZD44tFtIaeQI7AgcCBw4DC5NmAQE?=
IronPort-PHdr: A9a23:EkjfYBTQv6K2S3dnPrWegp2Qitpso47LVj580XJvo7tKdqLm+IztI
 wmDo/5sl1TOG47c7qEMh+nXtvX4UHcbqdaasX8EeYBRTRJNl8gMngIhDcLEQU32JfLndWo7S
 exJVURu+DewNk09JQ==
IronPort-Data: A9a23:juiBZ6BNKRY9LBVW/33iw5YqxClBgxIJ4kV8jS/XYbTApDsmgzZTm
 zFLDWuCbq3ZN2D3f9ogaIrgpxkF75XcnIMxOVdlrnsFo1CmBibm6XV1Cm+qYkt+++WaFBoPA
 /02M4eGdIZvCCeA+n9BC5C5xVFkz6aEW7HgP+DNPyF1VGdMRTwo4f5Zs7ZRbrVA357jXmthh
 fuo+5eBYAD9i2YtWo4pw/vrRC1H7ayaVAww5jTSVdgT1HfCmn8cCo4oJK3ZBxPQXolOE+emc
 P3Ixbe/83mx109F5gSNy+uTnuUiG9Y+DCDW4pZkc/HKbitq+kTe5p0G2M80Mi+7vdkmc+dZk
 72hvbToIesg0zaldO41C3G0GAkmVUFKFSOuzXWX6aSuI0P6n3TEnO5WNEY1EaIhoLxeLz5T5
 /gmCyFXcUXW7w626OrTpuhEj8AnKozveYgYoHwllW2fBvc9SpeFSKLPjTNa9G5v3YYVQ7CHO
 YxANWMHgBfoO3WjPn8XGZU4n+atrnL+aDZf7lmSoMLb5kCMk1Ariea2bYq9ltqid8BMzk2ag
 Gj91j73PzFDaOO72yiE2yf57gPItWahMG4IL5W0++BCjEWfxSoUEhJ+fUCnqPO9h2ayQ95cb
 UsO9UITQbMa/UivSJz5Gha/unPB5kJaUNtLGOp84waIokbJ3zuk6qE/ZmcpQPQttdQ9Qnoh0
 Vrhoj8jLWUHXGG9IZ5FyoqpkA==
IronPort-HdrOrdr: A9a23:EvwF9qvnwoTT16M26+WIVhFO7skCeYAji2hC6mlwRA09TyXGrb
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
X-Talos-CUID: 9a23:k3qhZ2PsiyJg++5DBzJfzEkXNu8cKCf04ijNMUuGKnczV+jA
X-Talos-MUID: =?us-ascii?q?9a23=3AIEla9w8G7b2zH7J+2CIIctmQf/Vt+vSlCmYHqrx?=
 =?us-ascii?q?ctfSkbHBPHyWPjR3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
Received: from alln-l-core-04.cisco.com ([173.36.16.141])
 by alln-iport-2.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 09 Jul 2026 12:07:51 +0000
Received: from alln-opgw-4.cisco.com (alln-opgw-4.cisco.com [173.37.147.252])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by alln-l-core-04.cisco.com (Postfix) with ESMTPS id 1D39918000B6E;
 Thu,  9 Jul 2026 12:07:51 +0000 (GMT)
X-CSE-ConnectionGUID: whzgIlG7Qcy3A99DAnI9zA==
X-CSE-MsgGUID: WumxO5WORcOMbm+rV3o42g==
Authentication-Results: alln-opgw-4.cisco.com;
 dkim=pass (signature verified) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="80526549"
Received: from mail-westus3azon11011048.outbound.protection.outlook.com (HELO
 PH0PR06CU001.outbound.protection.outlook.com) ([40.107.208.48])
 by alln-opgw-4.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 09 Jul 2026 12:07:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uA7mT25Vjzk+pPDvBDkaNv0Q9JT4yTQG6eDlfPQ7/sVOhXJ1aR9AsWSQYgYOgmVkgTYfqqqHJ0qHOicCWHt7ijicfwzMP38zyTZCDXCBCjpEg4i4KA9o4vd9rIE7XRaMzgMnb4wem+sUxpBs2qffskWuDWz7kYgiRkm2OfJNoxYIdQDauSlB0R2J/mYqe0O+DKxXShhSkD5Vrp9Cv/My4CLwrtzk3XSpbrnLZ5O4ugekRq5uZ5qO+8ZV1af44gJ5v6VyDjquu9cDxzTMS7ehPTuJvAQX8zyzGg325+vQDHTKX55HPDLAz2OxzOcNmZE+2Kba604eRJ0Ectu5HD5xPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qyFV7T5VL6MNNBmZE/DB4Df4OMJ6WpBQdBwiG1OLozg=;
 b=JeictILhv6bojXIUrx0eCpxzJMe3V+iAkrdv3bGnXOgEGQ+tsvg+uj/+buzyM86yY+NRmnWkzLRfy7BAWC9V/LI5awA/ilKH97U1dL6K51bnzYV/1s9XPkZYc/gHBLYdGES30ed2N8tcx1eOUJlrbhnq70PLWCWWk3vsyurYNMgtS3wGrJTEvTJf2O0jS87DXj+KG0UFo+5/ewqEc1iAeWXCqmgdsU21Z55DK8y9Gq9yK0H6RIQO3T7umxOBJmyUusLadfA3JM/kzReZS8mqbtvejVlO/1eJ6XY9t+v+MSQseBLOJyO4H3mZtkjGG1tKoBwcpXuuEqnTZE9sipFiaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from PH3PPF7A88A980A.namprd11.prod.outlook.com
 (2603:10b6:518:1::d32) by DM4PR11MB8201.namprd11.prod.outlook.com
 (2603:10b6:8:18a::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Thu, 9 Jul
 2026 12:07:48 +0000
Received: from PH3PPF7A88A980A.namprd11.prod.outlook.com
 ([fe80::6512:7c98:831d:3b0d]) by PH3PPF7A88A980A.namprd11.prod.outlook.com
 ([fe80::6512:7c98:831d:3b0d%7]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 12:07:47 +0000
From: "Hyong Youb Kim (hyonkim)" <hyonkim@cisco.com>
To: Thomas Monjalon <thomas@monjalon.net>
CC: Alexey Simakov <bigalex934@gmail.com>, "John Daley (johndale)"
 <johndale@cisco.com>, "Nelson Escobar (neescoba)" <neescoba@cisco.com>,
 "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH] net/enic: fix potential null dereference in flow mask
 check
Thread-Topic: [PATCH] net/enic: fix potential null dereference in flow mask
 check
Thread-Index: AQHdDe7O//fhB4P3jkOzms8HGuEnkrZk9jmwgAAj0wCAAAC3AA==
Date: Thu, 9 Jul 2026 12:07:47 +0000
Message-ID: <PH3PPF7A88A980A161AFEFAEED437A8F87BBFFE2@PH3PPF7A88A980A.namprd11.prod.outlook.com>
References: <20260707085831.40355-1-bigalex934@gmail.com>
 <IA3PR11MB8987402CDECFACC6831119E7BFFE2@IA3PR11MB8987.namprd11.prod.outlook.com>
 <Vh3QFBc2TJCkSwMa9Ds4OA@monjalon.net>
In-Reply-To: <Vh3QFBc2TJCkSwMa9Ds4OA@monjalon.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH3PPF7A88A980A:EE_|DM4PR11MB8201:EE_
x-ms-office365-filtering-correlation-id: ad5bf4c5-91c9-4c74-defe-08deddb2b12c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|38070700021|22082099003|18002099003|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info: nmYI3BqPiGD5KuWU0APUM7nK5a1/yCHS5aqe1IGog+6wzPidENC2sUXlbQWW3CVmpaOJGARwxpPdlBAIC3bvUa4Y3wxmLMPxAQ02gtnxJaVBXBDK39PqqdnZePAJLdyB/j8owldaELLz7zT+zc6XUwwrtkiH36EkatehxJn8kR5x29rVpTriS3xtnw/7VxvEXGIAVWqdjESl0pXgv7C/xna9zHqWHcildB7N8/U5js6sv9kKXMtarYN1HypEqr1F8IIjIydj5+/I93ZZqwy7jw/fDLRgUNRksweFmEYhs01PQnfNKYF+XAq++7gmn8IopvhlzhXUJ4yDbdouZtdNZ1F861GHJJV/udEEqtLb+iGhMiXTjgIOmWVu6Jfuml5i8+EFNr0E7F+T/I6oRHWEBJCojrQsiBWw+GWZLUycNMImEojpSLAMguHKzXRku70Wvc9e3CAR/ccOxAQJzpe3loihkK3hlVIZoLPZzit5pLSLlOJ/brvep7OtkP4Zx6X8rT9yLSenEAHOBwb55wMrmbnx4xy+uqLq1pJSy/BKctZIhxEKN868WJzRAuA61D+tPlfj+0c0KAv+VV1uKv4FD1nu4DybYtpfcFQvJHEwA0Ch7+HBt37qtOqL8LWsLuhfOPCh3jUZAuwNe1jYVlaB2ucM4Y05c6YyfQzM4p5V/I02zTLFyygjw8FCeWtjqCfFRj/5+AoU89rLDbo996DIai3UZN64ZpD7uAAgmKuCK1g=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH3PPF7A88A980A.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(38070700021)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ei9raWRjTnM4cXdJUXljNzV3MFZuUjV2bFYrbmlMMDdpSm9rNmVBdng5SW5r?=
 =?utf-8?B?WTh2UmdnYlVtMk94SXpHMjZkMGFUMld3MmIxT0N5cVBPd25XZlNBYXRneC9G?=
 =?utf-8?B?TmNMeklScUYxTHRIRnliYjEwY0VqaFg1VjlKWkpQazZoYTJMTm1TVGtLMmx1?=
 =?utf-8?B?Y1F3QVF6OVhBZXVlZnpSakdsMzI4VDhzWU9sMlRMNlQyN2ZpZzV3aGhoZ0Rp?=
 =?utf-8?B?SmNLd3oreGd6Y3I5b1ZKZ05LVExyR3loZUlMemcwK1gvWUtQL2J0bzZta3ZT?=
 =?utf-8?B?ci85ak9zRDVzVnlqMWVjeHRORk80V3U2NDVrZ2xNRG82cVRLVWhWK3BHZWlw?=
 =?utf-8?B?aGw1UkRlWWFmNTFPZ0J4dUFJRHRqTEdRYnhLeXc2R2VwdW5XU2NTU3gwSEpL?=
 =?utf-8?B?cjdZMExVdFNvVGFlcHVKOEx6SFFtaGRwTEpVWnJXUVcya0RHeWoxZjNCU2dY?=
 =?utf-8?B?eVNBL3BySzNWSVQxOE5TS2tpdmtXcTRYamNNZVVPQnd1bGZXMHZhbTR3cW9P?=
 =?utf-8?B?dWZTNXNWT2JPdEROUWxTVWtuUkF3QkZxL0VvaVljK3BkM2l2RXBaQUM4ZWtN?=
 =?utf-8?B?L2xmWWJNR2ZEeVdmT0dWZERqRkFFYlY4djh6dkRyc2ljRUdCR1ZFQzZvQWdn?=
 =?utf-8?B?L0hNdG9RY3hIbjJYU2c4bGZnR2pEdC85SUk5dGsvVUNMV28zckh1QmI5UXlC?=
 =?utf-8?B?a3BVUG05QXRwKzk5Z2VHU29aVmYvMHNIcTVkamFpVzlsVUlpWFJqUHQ2Yk0y?=
 =?utf-8?B?NEZhaGIwdE1zWlk2MUZJZXlJU0JDZGFlQWlVWVpPMUUwcEZ4ZTIvcjFDZldO?=
 =?utf-8?B?MXF1ck1JR3VHc0VkWm43Q3RZajRidmtBdEhJb09hb1UxN1JDRmsrTEdCa1dY?=
 =?utf-8?B?dytJNG00WkZ2OW9SQmZWM2w4U0NhbnRkNmJXMWZROUJmdkQydlBkK3JWMngw?=
 =?utf-8?B?RUk4RG9KeWFoN3M0V2VPbjdDT1FPRTRFTDE0Qjh2U1VGaGt5dUV6ZkxuU0Fq?=
 =?utf-8?B?S2xpQlY2N0plUmF1cXN0cHRycnlTbmwvK0JLb2Uyb2ZlMWJuYTdIVHZtUncr?=
 =?utf-8?B?Zk56TXF5VzMxTXpDL21tUHNLT0ppbmJpdWxDNGJmbEdKZ0xFMkJnUkV5allW?=
 =?utf-8?B?NHhjWWJFb1Zrc3kzQjBmY1V0dmF2YnQzdU03bHdOVzE2QjNhVlp3eWFhTnZH?=
 =?utf-8?B?czRNY1FiZXJzaS9rVFk4Mld1WFdFbEtsTXlZbmREK21Vamk5Y0tLVHVTWXN0?=
 =?utf-8?B?ZzdVWGNOUnEzc0l1cXUzMjBWelJUaXFKVzdoR3F6aEJqbllYWHc3UFE3VHY3?=
 =?utf-8?B?QVZEZjZxcFJQTmxOOEtaSFprZW15b1Foa1RncUdSdWx5bEdnQkdLVHRNaUpx?=
 =?utf-8?B?d3dma1MwZ25MKzI2NDMvc0ZmK0gwaDFQRy9YdnJIUjlWUHZxYmhmbC93cUlj?=
 =?utf-8?B?Z08xNXZ5V2xIR0lTcWR5dXVIMDdmMmQ0OStKaDVlTlovZmE5R1JZT0tVM1RY?=
 =?utf-8?B?SGs5YzVDU1pUMytjYWZEWjlEdTdsYWNmVHA0bElyUFdKeXM0OXpud3l1U1Uw?=
 =?utf-8?B?TzE1MTBET2E0cFBEUEtkcUVSNzJENFByaUIzOE5TMENpNmp5ZzBIWHptRUZL?=
 =?utf-8?B?UWR2MlFOc2l6ejZDN0FBL01oYTIxYzcwZ2h3eTJ5VUZXRWU5L2lmaDFYeDdm?=
 =?utf-8?B?RmpJV256b3l1ZjVvaXVjRE9iODRvcEVNQkx3bkErQnVLSTYrdVhmUkl3bzZk?=
 =?utf-8?B?ODdOcFRSWTBiekpaWEZ5L21uUUNjVWlLdzE1RVRuSmhRTVoxdngrVWg5Z0lI?=
 =?utf-8?B?UTZzWGR0UHZvekU3NzFFZC9OVjIvVkxlRkcxMjJXRitLeVo2WGVSS1hNaDdE?=
 =?utf-8?B?c0laZENlYU1oZy81U2tPYXBKY080dlAyRnhqVitoR2pFMm85TmNXQnF3N1RP?=
 =?utf-8?B?OWlJMmxvOERZVjl5KzFHcVN3N25JM0w0MDVMOTlKL21YcmlQelREenpTa09p?=
 =?utf-8?B?RFdjanlrNXVRVk9PbEI4eUp1RnBDT0p5OFZXbUMwbVZRUTlDNHRFMEErYmlC?=
 =?utf-8?B?VGtleldYWlBKU0MzUk9KOE95ZjJJUkpORVgxWDQwQzRuUmRqK1hLSjVGMHdL?=
 =?utf-8?B?cnhqa2crT1NLazJNcitOL2NORnB4ZDJ1T3JZWjJKbEF2ZC9HSHZqWnhpNmdH?=
 =?utf-8?B?bXdmK01kK3pENlIxbmc4a1l2Q0Vud2p6YSs5TjJrZDRTbkxpRGRUamZERWg3?=
 =?utf-8?B?dTlqN2hTYkYxdkhlRExUSHZIaEhXQ1VFTjJhZDhRenozcVZINExjQXBqa2ZW?=
 =?utf-8?Q?HGwwM6NDWBk+25QJx3?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: n5FfPH0rlBepLErtXamUwO/4HdCqASnZv++kd3xihqerjslCYArQoMeSJGQO97D95NbJ6rrDqrjFikiE8l3jSnQ0Zlq02ozQT4AkN6lWYosNv/wXxs2VpuZs+n6kZ8yXwAGweIVyXIpNXkjI6+hfen65nuz3Qe6V31KsfSkSXVT9oOGCL96FU/Nf5qLFqy0w3GU+nbt6yhBgvldbJE9aBEjzYXMe1qHsk8Wa9jasi40//X9fDU86iD/FTCpHSgs7aQF5PqzgZ/DLkqbaJ0/SyZ4L337Hc5HgYauknvOl+junedku+/oSmgDwr2wDdEECTmWYMIryRtz2IUEgNruxMg==
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF7A88A980A.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad5bf4c5-91c9-4c74-defe-08deddb2b12c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2026 12:07:47.9156 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GldoXO/HG/BNoaaeuRlRBEHx+xNBt6Jji7fSJDsTke7XaiI0hXfCvRjOZFzLlP5mj8+ADpjAgGKIetd4i21Pkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8201
X-Outbound-Client-TLS: ANONYMOUS; alln-opgw-4.cisco.com [173.37.147.252];
 TLSv1.3; TLS_AES_256_GCM_SHA384; 256
X-Outbound-SMTP-Client: 173.37.147.252, alln-opgw-4.cisco.com
X-Outbound-Node: alln-l-core-04.cisco.com
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVGhvbWFzIE1vbmphbG9u
IDx0aG9tYXNAbW9uamFsb24ubmV0Pg0KPiBTZW50OiBUaHVyc2RheSwgSnVseSA5LCAyMDI2IDk6
MDQgUE0NCj4gVG86IEh5b25nIFlvdWIgS2ltIChoeW9ua2ltKSA8aHlvbmtpbUBjaXNjby5jb20+
DQo+IENjOiBBbGV4ZXkgU2ltYWtvdiA8YmlnYWxleDkzNEBnbWFpbC5jb20+OyBKb2huIERhbGV5
IChqb2huZGFsZSkNCj4gPGpvaG5kYWxlQGNpc2NvLmNvbT47IE5lbHNvbiBFc2NvYmFyIChuZWVz
Y29iYSkgPG5lZXNjb2JhQGNpc2NvLmNvbT47DQo+IGRldkBkcGRrLm9yZzsgc3RhYmxlQGRwZGsu
b3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIG5ldC9lbmljOiBmaXggcG90ZW50aWFsIG51bGwg
ZGVyZWZlcmVuY2UgaW4gZmxvdyBtYXNrIGNoZWNrDQo+IA0KPiAwOS8wNy8yMDI2IDExOjU3LCBI
eW9uZyBZb3ViIEtpbSAoaHlvbmtpbSk6DQo+ID4gRnJvbTogQWxleGV5IFNpbWFrb3YgPGJpZ2Fs
ZXg5MzRAZ21haWwuY29tPg0KPiA+ID4gLS0tIGEvLm1haWxtYXANCj4gPiA+ICsrKyBiLy5tYWls
bWFwDQo+ID4gPiBAQCAtNzEsNiArNzEsNyBAQCBBbGV4YW5kZXIgU2tvcmljaGVua28gPGFza29y
aWNoZW5rb0BuZXRnYXRlLmNvbT4NCj4gPiA+ICBBbGV4YW5kZXIgU29sZ2FuaWsgPHNvbGdhbmlr
QGdtYWlsLmNvbT4NCj4gPiA+ICBBbGV4YW5kZXIgViBHdXRraW4gPGFsZXhhbmRlci52Lmd1dGtp
bkBpbnRlbC5jb20+DQo+ID4gPiAgQWxleGFuZHJlIEZlcnJpZXV4IDxhbGV4YW5kcmUuZmVycmll
dXhAb3JhbmdlLmNvbT4NCj4gPiA+ICtBbGV4ZXkgU2ltYWtvdiA8YmlnYWxleDkzNEBnbWFpbC5j
b20+DQo+ID4gPiAgQWxleGV5IEthcmRhc2hldnNraXkgPGFpa0BvemxhYnMucnU+DQo+ID4gPiAg
QWxmcmVkbyBDYXJkaWdsaWFubyA8Y2FyZGlnbGlhbm9AbnRvcC5vcmc+DQo+ID4gPiAgQWxpIEFs
bnViYW5pIDxhbGlhbG51QG52aWRpYS5jb20+IDxhbGlhbG51QG1lbGxhbm94LmNvbT4NCj4gPg0K
PiA+IENhbiB5b3UgcmVtb3ZlIC5tYWlsbWFwIGRpZmY/DQo+IA0KPiBXaHkgYXJlIHlvdSBhc2tp
bmcgdGhhdD8NCj4gQW55IG5ldyBjb250cmlidXRvciBtdXN0IGJlIGluIHRoaXMgZmlsZS4NCj4g
SWYgaXQgaXMgbm90IGRvbmUsIEkgYWRkIGl0IG1hbnVhbGx5IGluIHRoZSBjb21taXQuDQo+IA0K
DQpNeSBiYWQuIEkgZGlkIG5vdCBrbm93Lg0KDQpUaGFua3MuDQotSHlvbmcNCg0K
