Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36863CCD183
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 04:46:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2D43B40616;
	Thu, 16 Oct 2025 06:46:45 +0200 (CEST)
Received: from alln-iport-8.cisco.com (alln-iport-8.cisco.com [173.37.142.95])
 by mails.dpdk.org (Postfix) with ESMTP id 12CF240269
 for <dev@dpdk.org>; Thu, 16 Oct 2025 06:46:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cisco.com; i=@cisco.com; l=1223; q=dns/txt;
 s=iport01; t=1760590003; x=1761799603;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=esNKcs5ijza2dpv30mAwGq/uF8Q1E5/BkH7UheXiF44=;
 b=bnnkM3FaocIxJ+OVU0FfC+U0HykbdaOvx5xTiYTZTgY/fkTEMn1z1i69
 NBT+k5ZTwVKcSkmeF06ru17jMYdhJm/0/SIdP5glpGDzVs20kCBBXe5Jw
 qekwTrYtu8H1C9cQg670zjmQKwkhx4sHFK4OXs6kktY6KYLO3gYOH+RgS
 BhRiroPI3NL8l0pCBJTVHjmE9vcil6QG1bzX7Dmvy9Pd8VvrHy44k/+k7
 6YzXBjwmQ46y8phb5n8gw1M9ID3Ooh4GmdnLHI84bR7aUG2+YSTzAHib1
 OumowZYPdEYUSb8Xuaos8nVW7QGB8mA3kTJrly6PZFfrqY7458+fC3Cc9 g==;
X-CSE-ConnectionGUID: r2roh6iWR7mhlyNi+K+D6A==
X-CSE-MsgGUID: 4Gk2oZUBQO2oUUtpp2WIHw==
X-IPAS-Result: =?us-ascii?q?A0BmAAAzePBo/5MQJK1aGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQCWBK4FuUgeCCRJJiCADhSyIe6AZDwEBAQ0CUQQBAYUHAoxLA?=
 =?us-ascii?q?iY4EwECBAEBAQEDAgMBAQEBAQEBAQEBAQsBAQUBAQECAQcFgQ4ThlyGWgEBA?=
 =?us-ascii?q?QEDEig/DAQCAQgRBAEBHgEQMR0IAgQBDQUIGoVUAwECpAcBgUACiit4gTSBA?=
 =?us-ascii?q?eAmgUoBiFABimQnG4FJRIFXeYFvPoQKO4QTgi8EgiKBDoYwkQdSeBwDWSwBV?=
 =?us-ascii?q?RMXCwcFgSAQMwMqNC0jSwUtHXMMKBIQHxwTYFRAg0kQCwZoDwaBExlJAgICB?=
 =?us-ascii?q?QJCOoFpBhwGHxICAwECAjpXDYF3AgIEgi6BEIIqD4VvAwttPTcGDhsFBIE1B?=
 =?us-ascii?q?ZIRgnyBDoFElCWQQqMvCoQcog0XqmuZBiKodAIEAgQFAhABAQaBfyWBWXAVg?=
 =?us-ascii?q?yJSGQ+OLRbEN3g8AgcLAQEDCZFqgX0BAQ?=
IronPort-PHdr: A9a23:Q/b6lR8fGb1p6v9uWBDoyV9kXcBvk7zwOghQ7YIolPcVNK+i5J/le
 kfY4KYlgFzIWNDD4ulfw6rNsq/mUHAd+5vJrn0YcZJNWhNEwcUblgAtGoiEXGXwLeXhaGoxG
 8EqaQ==
IronPort-Data: A9a23:4zo6gKI78mS7qZluFE+RlJQlxSXFcZb7ZxGr2PjKsXjdYENS0z1Tm
 DYfXzyEafaDYmL3e4tyPN6yo0xQsJWDx9VjSQMd+CA2RRqmiyZq6fd1j6vUF3nPRiEWZBs/t
 63yUvGZcoZsCCWa/073WlTYhSEU/bmSQbbhA/LzNCl0RAt1IA8skhsLd9QR2uaEuvDnRVrc0
 T/Oi5eHYgL8g2cqajt8B5+r8XuDgtyj4Fv0gXRmDRx7lAe2v2UYCpsZOZawIxPQKqFIHvS3T
 vr017qw+GXU5X8FUrtJRZ6iLyXm6paLVeS/oiI+t5qK23CulQRuukoPD8fwXG8M49m/c3+d/
 /0W3XC4YV9B0qQhA43xWTEAe811FfUuFLMqvRFTvOTLp3AqfUcAzN10VlsxPdMZxdwoBGFK5
 NoZaxNOQk6q0rfeLLKTEoGAh+wqKM3teYdasXZ6wHSAVbAtQIvIROPB4towMDUY358VW62AI
 ZNHL2MzM3wsYDUXUrsTIJIvm+Grh3zXeDxDo1XTrq0yi4TW5FEhjei9a4CIJrRmQ+0JsUXCo
 VD71V3eWBYnCcCH0WC601Kz07qncSTTHdh6+KeD3vJnnnWf3mAQThoMWjOGTeKRg0q6XZdbb
 kcT4Cdr9PB0/02wRd67VBq9yJKZgiMhtxNrO7RSwCmGy7Hf5ECSAW1sc9KLQIdOWBMeLdDy6
 mK0og==
IronPort-HdrOrdr: A9a23:gQjjWavODMxK3itr/MEQx/Ox7skCOYAji2hC6mlwRA09TyXGrb
 HMoB1L73/JYWgqOU3IwerwRpVoIUmxyXZ0ibNhW4tKLzOWyVdAS7sSorcKogeQVxEWmdQtr5
 uIH5IObOEYSGIK8voSgzPIXerIouP3jZxA7N22pxwCPGMaDp2IrT0JdjpzeXcGPTWucKBJb6
 Z0kfA33wZIF05nCfiTNz0uZcSGjdvNk57tfB4BADAayCTmt1mVwY+/OSK1mjMFXR1y4ZpKyw
 X4egrCiZmLgrWe8FvxxmXT55NZlJ/K0d1YHvGBjcATN3HFlhuoTJ4JYczDgBkF5MWUrHo6mt
 jFpBkte+5p7WnKQ22zqRzxnyH9zTcV7WP4w1PwuwqhnSW5fkN5NyNyv/McTvLr0TtmgDi66t
 MM44utjesTMfoHplWl2zGHbWAzqqP+mwtTrQdatQ0tbWJZUs4RkWTal3klSqvp20nBmdsaOf
 grA8fG6PlMd1SGK3jfo2l02dSpGm8+BxGcXyE5y4eoOhVt7TlEJnEjtYQit2ZF8Ih4R4hP5u
 zCPKgtnLZSTtUOZaY4AOsaW8O4BmHEXBqJaQupUBnaPbBCP2iIp4/84b0z6u3vcJsUzIEqkJ
 CEVF9Dr2Y9d0/nFMXL1pxW9RLGRnm7QF3Wu4tjzok8vqe5SKvgMCWFRlxrm8y8o+8HCsmeQP
 q3MII+OY6UEYIvI/c/4+TTYegnFZBFarxmhj8SYSP6nv72
X-Talos-CUID: 9a23:DhLk8Wx9TigQWFzfrRvbBgUOQNoiciPc802PJk+8GEBoC57WZQG5rfY=
X-Talos-MUID: 9a23:KWdkaAloEm4jv7N99TV/dno+G8Qy5JaTInkqy5I7htWcLXZPGheC2WE=
X-IronPort-Anti-Spam-Filtered: true
Received: from alln-l-core-10.cisco.com ([173.36.16.147])
 by alln-iport-8.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 16 Oct 2025 04:46:30 +0000
Received: from alln-opgw-3.cisco.com (alln-opgw-3.cisco.com [173.37.147.251])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by alln-l-core-10.cisco.com (Postfix) with ESMTPS id BC7F81800015C
 for <dev@dpdk.org>; Thu, 16 Oct 2025 04:46:30 +0000 (GMT)
X-CSE-ConnectionGUID: /D0AiG/3SMGTyiRFd3fKJA==
X-CSE-MsgGUID: eYryn7QARFixN3ba9pI1IA==
Authentication-Results: alln-opgw-3.cisco.com;
 dkim=pass (signature verified) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.19,233,1754956800"; d="scan'208";a="34681309"
Received: from mail-sj0pr08cu00102.outbound.protection.outlook.com (HELO
 SJ0PR08CU001.outbound.protection.outlook.com) ([40.93.1.74])
 by alln-opgw-3.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 16 Oct 2025 04:46:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NgiqEY69fBxVVsQiVMkLKAtM0rmFlwU8HAj8drsc4iFh9RRGBOTqec6nWzldPnw+DOrr/nA+O4YnFSKvbHLPxHgHvx3fEojbRmSkPXXnG18F80Dh9QshpfyaN0ebmMPPHmMo/Nb3JiZa7qNoOZjLrvGeuDoW0s4VcgXgb9RcyMZbYLJ2O/13ZN9nGxcd5oYxJLa+G7sxutL38NHhop2toWyvurTi+h5C5nNt4NAz6gWrxDssRXF9yBZAmK6keNyPTjmupgEs6wQqhBUScoiDbUGP4tXclBTa8gQ6S4glSkQ7EPpuBAwNrnUPLgk0/MfASD/4V/Z3FUI3DANRarA/TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=esNKcs5ijza2dpv30mAwGq/uF8Q1E5/BkH7UheXiF44=;
 b=ht7KlsQb3lyVKieFISk8gzn699oP+00zWmA/FBQyQ1o33KapfqmDKZ4f+9kryOgXVMiCP+JnboQJ3NsucvdM32XNWH7eh2yAIEGYMkv+yBmAjfyMF3S4VP0wbwX9FuRHcpcmGMa/+pjWT61XCFoRjwwmU/ERc6P6YvYusLJZAXM3FzDCJWKcI4Fpwxp6aQDENsPgElkRXgWMOAXQg1W63NlbG45p85kz/jW5uOUYYFGL6d9dRXnYm08n03NizFsQTFughRW5mnaRh8xTXgEfQ+skSgq6kYg24y4fNvVtoOw0taEhI1x0wXL2Ks2XKV5QIXLfqZRwUh89fyqpQudh7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from IA3PR11MB8987.namprd11.prod.outlook.com (2603:10b6:208:574::18)
 by PH0PR11MB7561.namprd11.prod.outlook.com (2603:10b6:510:282::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Thu, 16 Oct
 2025 04:46:28 +0000
Received: from IA3PR11MB8987.namprd11.prod.outlook.com
 ([fe80::c011:ff94:944e:f96e]) by IA3PR11MB8987.namprd11.prod.outlook.com
 ([fe80::c011:ff94:944e:f96e%6]) with mapi id 15.20.9228.012; Thu, 16 Oct 2025
 04:46:28 +0000
From: "Hyong Youb Kim (hyonkim)" <hyonkim@cisco.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "John Daley (johndale)" <johndale@cisco.com>
Subject: RE: [PATCH] net/enic: make local variable static
Thread-Topic: [PATCH] net/enic: make local variable static
Thread-Index: AQHcPikFkDgoeM7h3kCPJhQu3HHLTrTEMujg
Date: Thu, 16 Oct 2025 04:46:28 +0000
Message-ID: <IA3PR11MB89873567EBB9C96D86B21BEABFE9A@IA3PR11MB8987.namprd11.prod.outlook.com>
References: <20251015231106.876172-1-stephen@networkplumber.org>
In-Reply-To: <20251015231106.876172-1-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8987:EE_|PH0PR11MB7561:EE_
x-ms-office365-filtering-correlation-id: 4042005e-c0e6-44d0-0ad9-08de0c6ef811
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?eZX/rBOg5gcOv5jhvLT4C3z2wz2q7yHgu7IQxSsslbFw9/Z66m8/y/66JGqV?=
 =?us-ascii?Q?FjzsgfmJfOpeLdi4Obt9WjbU0At3/eU4o4U9jczeoevB9jeM/UbZlQz9YTjX?=
 =?us-ascii?Q?XrgoaygXu8umgAKfSABwO2T9EoA7ersRxOZtvVF72JT2jsfTTswA5Q8LkoYh?=
 =?us-ascii?Q?rXo1uJ9WqMCFFcou76Kc31EVnP27stpOb/oBc/3A9qtpRrj8kyuS8uaC21WG?=
 =?us-ascii?Q?O4eGocYkQF6m/4bW0tk7ANyqjNgw/A5zO7MG4mN0Do8Yb9rKoYSpHCMmLD57?=
 =?us-ascii?Q?YjiVph9dQI0Np9XP9DaiUo+nRSwIk3knDTlH2vsCLx5JEauZUN+RFtYvntSE?=
 =?us-ascii?Q?Nuoqnovb7S1lcRQV5l9CP4XvDdbUaw3399aC3MGx7qTxjbt5SxXiug57Dzgc?=
 =?us-ascii?Q?MsYAObYcE+qECiHnEsrfVjtfNDTytmuXSaCioizPrTzADdmcrDNxe/5MKO3c?=
 =?us-ascii?Q?5EistI5JToI8WUQ2fFMyj+wu4x8w6SqZa/Fw05tberbMw+dkoEa3wppaWs+s?=
 =?us-ascii?Q?8kiGtD0R0+oA0cicuwT8xzzrJHMw5S8W2coN0u0W4rc94L7FFDEXHbWyFmLN?=
 =?us-ascii?Q?y65eV4I1uzGZCFrB0kSToSNF+Qk2R+dhBaBmcKY0JcqksyDHTKgprdrcXvwG?=
 =?us-ascii?Q?IqN3LeMEw1Ro41D2kZN536mkS1lKD1TnCMKZlaSOInAhRKsail4L5CxHW9JN?=
 =?us-ascii?Q?uAgiPb6/Qsl9z98N4i8pIP+UiAsfK7rFzAoqEj1n6rPTk4fJ+cuguJKPYjFH?=
 =?us-ascii?Q?EcS+QLC4I8EQfTDkk24FK1bHOOe+2xSpXCiAll/8ecba+T2wcEJrYGOvIHl9?=
 =?us-ascii?Q?a2I991CBPXYZj9ebJxvobyHM28XXQb5SnZ9LBThxUogQ51XB6Z6dd5agM/W1?=
 =?us-ascii?Q?Frx/YFRf9bBaBd/ehm/zZcwli+jfauRbeGmePXSJauQt+8nVTaAoU/8MrBau?=
 =?us-ascii?Q?Dtv6ssS6YAeXhRywl7q/zUP41rX4vSDGALUrZ1+ptXgabQYQxNTXvTgxZcHz?=
 =?us-ascii?Q?7HPTgKZvIQHR3ie/gAUZOsAIPSgdimeOSl3hp5qjG6TjMhQYG/KFpS3ZHo1D?=
 =?us-ascii?Q?MB9HxejRQiIlSXMjMULxwOF0cRGa2AglOjEnhBLC81ttxecJ4KOdczUtJlIw?=
 =?us-ascii?Q?DTWn2eZyEqUb6e5Fx6s7fdc7jbJZyEPhKpio3JYSP+6IIOP38GH0AX6DuFI9?=
 =?us-ascii?Q?DcelWqUYArlaXsxqyvVzUpHsoaG2wZtONyIeDpJn7qIVra+q0Jgmh+J62ThG?=
 =?us-ascii?Q?xRmwjgncreRw04R23GH5Lp0G5Ts45KiYEDJ+TvQygUnPqJ5t4GNfdOK3pg2C?=
 =?us-ascii?Q?lPdJtHJJPqNRCujzyJstZvWjGdgxIkYQo2fDQOFjjEP/EJDo3n5NTHbS1Hsc?=
 =?us-ascii?Q?JEUv+FUfwWvprCBeeS70Vu8VO3RjfPeRl8ysFfDFvDc1SfCEwSnVjRAosMJS?=
 =?us-ascii?Q?ERzz7tFdUYHg+3ka2XxTJYvG8mZiUN9KgOX4UkQg0PobJAPK0G79++lE/tVF?=
 =?us-ascii?Q?bwKXVLI3rxyNR5zvlPt4t8CK+0fKT1VlQXLw?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB8987.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EWym2b5nnB5yPS8psCkHelvSKZRBh9f+v2MC0lnuN1/ikM5hM4cBJVWiVHBB?=
 =?us-ascii?Q?QzX/HQNdDrbfUrBvIPSk5L+2ZKaV/fPN9J4jx0xTiy88t+HOxP08vEwVD+9Q?=
 =?us-ascii?Q?INxXhFWLKyTakGQUIn40uTJSErla/irrzgN/l9bsmA3d7+TRji5pO7YKPmjs?=
 =?us-ascii?Q?cgdkBA07mrZp6muG282R/TrMQyEhkzXr/XbFSwOfknlhezDfnk/7ttkWWoDs?=
 =?us-ascii?Q?+xCjPRZilu7U8HbtMQI/p0cdUcsf/vXAUYHsECYf80D9kMLNSURc+sZfVG3b?=
 =?us-ascii?Q?Z9YTKN4SwiEQmoBEPAeXtak4w6qpu2fMemak4954+kJSGX13xdh88pD9BqeW?=
 =?us-ascii?Q?XyFYFODaC9278g4xDP63fHtEfHRn7Xj0axiMPrmDdcySswrdR6hCzUwSHYgy?=
 =?us-ascii?Q?jg2CiHPnoxReQh9uBo6YW6hsd/CljplhDAfA/ZjgZD8gW5BUcVrjkO3IRJtA?=
 =?us-ascii?Q?2S7wnUTfCeb+FFO4j1MUYSv1+t5fbhQkkeIuM2iboJ/53GwKdPhrwa8fLLsm?=
 =?us-ascii?Q?MU6FV9fW1BlXjHwd2QEH5YFtkcWyALWQJTmUGXgXvhtaroSEXpsNPIOHdf4O?=
 =?us-ascii?Q?5MPQatL1kSZenglPg+JYXjCdqlQIZYzIM787LvgyqU2oixMfxFfDT9619IFg?=
 =?us-ascii?Q?SqzGbxsOz96cWCxnidIxpxaHnHiDDvRlmcaS0VnerT2/Yhz9XGDJczauZgE9?=
 =?us-ascii?Q?7MBtADZNqXweZiBEB3sbpYcnAtEsZXSxQMvGEE3PI4ErwVNa9mqiD3jR3lvi?=
 =?us-ascii?Q?3C5efToDk/6CC6R1bfZWcWt2g4DQONrEvkkG0LWSsjPS14D/pKW71PylDE43?=
 =?us-ascii?Q?ck2sy3a20/FEV/o4lWilST/KfdP3SyygzNYugAdIudygJMwSk9XKbipqnT48?=
 =?us-ascii?Q?5JrjCwDlGa5u5GCYsguFdl9WaC8a2dRdGd72XGa7zWlxR74lz7UbTxQmMgCY?=
 =?us-ascii?Q?rc7VJoE8PBWZ0QaJBFyh5sM5SIZa15dxTQI/8/MJq+9lC71HMITOE+7QGcdp?=
 =?us-ascii?Q?nq2IumtYpL2/xY7ycA2K8Zhtx25A+f95CAdTiXM1jTgSsbpS5daScCUybKJi?=
 =?us-ascii?Q?4A6Qm10E39MLmzrZIPxOyBzkjayk7xt4f4RCYOirpysFYQVf4MnwpJPhBD/I?=
 =?us-ascii?Q?gbejpokIjaXPtmHhqPyUXsaNtCxjWeeuMzdYsGUIzRgthACkgHsbH/U69zNZ?=
 =?us-ascii?Q?QPez0126xWhDpN/ikFoZhSaGx7uV/eK3MsZL8w400ypSzGd8SmzviFtXlVqh?=
 =?us-ascii?Q?2UHsLk5ctZhrSR8PPfAqlCRhQC0M3xOwjuyp2e1nq/BrVmg+hfGnAHYnWfN/?=
 =?us-ascii?Q?KtPCHIvrhB9uwLg51lzcViBE5SGBWxvksh1sIBNxfu/DaFYHjBeGME3r7l/s?=
 =?us-ascii?Q?jXAJuABKQ4TkN594cczDXS3DWmsr5P0DxZQA0DgYnjtkUoW+sMlumMSYu6hA?=
 =?us-ascii?Q?B00iQefuQikmnvK7c+0+5GnXSHbxl4GjeLWLn8G9JMhgWvcY+2eA5xg1ebul?=
 =?us-ascii?Q?CbfiQT/bYUwo22SESsieGCv4zOSxE9jWKMgfi7EIjztsgYq67EUJYGKS9+LP?=
 =?us-ascii?Q?DVuNWU17vEhhGXCf81E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8987.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4042005e-c0e6-44d0-0ad9-08de0c6ef811
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2025 04:46:28.0896 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zV2IS5hu+WeGqyAoZgeOlq1NgBCk015JqKaZeA1bg8BrfAzWQydWZArs6GH6GrAQoOYuN3E12VePSNVaALGy5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7561
X-Outbound-SMTP-Client: 173.37.147.251, alln-opgw-3.cisco.com
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
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Thursday, October 16, 2025 8:11 AM
> To: dev@dpdk.org
> Cc: Stephen Hemminger <stephen@networkplumber.org>; John Daley
> (johndale) <johndale@cisco.com>; Hyong Youb Kim (hyonkim)
> <hyonkim@cisco.com>
> Subject: [PATCH] net/enic: make local variable static
>=20
> Avoid global variable name conflicts.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Acked-by: Hyong Youb Kim <hyonkim@cisco.com>

> ---
>  drivers/net/enic/enic_sriov.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/enic/enic_sriov.c b/drivers/net/enic/enic_sriov.=
c
> index 43072a2287..29faa31512 100644
> --- a/drivers/net/enic/enic_sriov.c
> +++ b/drivers/net/enic/enic_sriov.c
> @@ -13,7 +13,7 @@ static int enic_check_chan_capability(struct enic *enic=
);
>  static int enic_register_vf(struct enic *enic);
>  static void enic_unregister_vf(struct enic *enic);
>=20
> -const char *msg_type_str[ENIC_MBOX_MAX] =3D {
> +static const char *msg_type_str[ENIC_MBOX_MAX] =3D {
>  	"VF_CAPABILITY_REQUEST",
>  	"VF_CAPABILITY_REPLY",
>  	"VF_REGISTER_REQUEST",
> --
> 2.47.3

