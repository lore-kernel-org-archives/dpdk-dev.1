Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3292FC71136
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Jun 2025 14:18:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 14981402BC;
	Mon, 16 Jun 2025 16:18:02 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id D0186402B5
 for <dev@dpdk.org>; Mon, 16 Jun 2025 16:17:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750083481; x=1781619481;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=2LuK4hztlIa4XbHxSncEKgG9W0VVov+/HQlp01Av4oA=;
 b=lGmbgNu8aOsiZzT6sxoEtedwwFlppvh2kPNkA4qELmbkH9adfj047vsO
 dOlMvzQVjdtWgArqVZSlAGLHeU0UCThTvm+RHNPaDBRH33aGIw435f0jt
 8+9TUiY/SxauozB1rw+NZzbc0SVOkIasMFQ8bEsb/1MBYUojCR4IgEMzd
 ziSLwOHePY6HfCEheBNYYfruJ8XloH6o6lQr9bUFFsPADW0lpYrOLmVs3
 /TywfimB8X4wwZ474pieIpfS5XJln3CpKDrm8yXyuHLH/+2+genxi19u3
 OLXFlcfaPm4rnl6idEMDm6QUy39Fzg6NGn5Le3qwS6ttM5xMl8TrmtPQe Q==;
X-CSE-ConnectionGUID: ILlxeDCQSqm1OtUqn268pg==
X-CSE-MsgGUID: LQlNUsuKT1KTmYMpZg0L6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="63647041"
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; d="scan'208,217";a="63647041"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2025 07:17:59 -0700
X-CSE-ConnectionGUID: DgXyJAayRQCaagyuhnFADg==
X-CSE-MsgGUID: 7ELlSZhbRtGxqYBINlo65w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; 
 d="scan'208,217";a="148389736"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2025 07:17:58 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Jun 2025 07:17:57 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 16 Jun 2025 07:17:57 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.81)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Jun 2025 07:17:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TBERGI72Ko1Le2bgnJnjzztF6pRPmZigvOOhNGrhLVTtdmbTFHxcEYXYHIDOQ4qwSYd1i6mbFNxolpPg2H8uff/cmMV0n9ogIyXXOHVFo5gkCPYLBBibMSidGRiyPTio6PHkFiK+cxUgTx15oeB0kxRpw5B6WJ5ybVF8vv8X2BOZsmxS3sIQPpTJd9DeUN9aJ1fNqh3byjLZQlPb6aSnqMHGeo4gjRd7FpCElKCIObu1UyWCtzuCkekVmHoklgoADADfIC3jbO3rsPCtL7HeiYbqF28ENqwpz+kGeRs/ahW/5wFzPp1n6bvLF2355XAsKc1I2ilcvfzSAALQVGQtGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d0hvq69jHErqw037nAyCMO+cf2C22SEteF59tZLHAKw=;
 b=xKqiwLAoTSDxUu5b4KdVnZBCAXOcE6vHPndINAhP5SZM7VtMqlTfYJ4Gr9WbSHDP18JRyYrWz85001z1GoBwiqRCOpormw5/q9ZycIXoYdox0iRXOZbC1opK5D0tEVzecG+3dT4zL6n2bGXeXTE9MiUk7wBpn4utZHGZNYvF+pXvs/C1YQ7UycWBtBl02V7G6HKO0kCNrRr3Rl1Fuz5Hz/JWn3mmu2SbikCqNZQgH+6/J0Skd7CKp2BTi6AnntG8oGwjdTRixbP3DVeTm+fetOzKyS3ZvXyFpsHv9FbakDHPiQUAWmV8Z6L9uiJm7Pb86CZeDRwPtm0MqsTP+3Z0qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7458.namprd11.prod.outlook.com (2603:10b6:8:145::13)
 by DS7PR11MB6272.namprd11.prod.outlook.com (2603:10b6:8:94::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.26; Mon, 16 Jun
 2025 14:17:39 +0000
Received: from DS0PR11MB7458.namprd11.prod.outlook.com
 ([fe80::1a9e:53a6:9603:8f79]) by DS0PR11MB7458.namprd11.prod.outlook.com
 ([fe80::1a9e:53a6:9603:8f79%3]) with mapi id 15.20.8835.026; Mon, 16 Jun 2025
 14:17:39 +0000
From: "Ji, Kai" <kai.ji@intel.com>
To: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
CC: Anoob Joseph <anoobj@marvell.com>, "dev@dpdk.org" <dev@dpdk.org>, "Akhil
 Goyal" <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>, Shally Verma
 <shallyv@marvell.com>, Kanaka Durga Kotamarthy <kkotamarthy@marvell.com>,
 Ayuj Verma <ayverma@marvell.com>, "Kusztal, ArkadiuszX"
 <arkadiuszx.kusztal@intel.com>
Subject: Re: [PATCH] test/crypto: fix RSA decrypt op validation
Thread-Topic: [PATCH] test/crypto: fix RSA decrypt op validation
Thread-Index: AQHbwZitI4ZzVejgjUiL1wP+0dVdXLP/h82AgAaC5M4=
Date: Mon, 16 Jun 2025 14:17:39 +0000
Message-ID: <DS0PR11MB7458F54FAE4573EEA5D30AEF8170A@DS0PR11MB7458.namprd11.prod.outlook.com>
References: <20250510104452.2186-1-gmuthukrishn@marvell.com>
 <CO1PR18MB471468B21DE770926E149839CB74A@CO1PR18MB4714.namprd18.prod.outlook.com>
In-Reply-To: <CO1PR18MB471468B21DE770926E149839CB74A@CO1PR18MB4714.namprd18.prod.outlook.com>
Accept-Language: en-GB, en-US, en-IE
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7458:EE_|DS7PR11MB6272:EE_
x-ms-office365-filtering-correlation-id: 93db5ebf-1d39-4fef-0f81-08ddace08cc5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|10070799003|1800799024|8096899003|7053199007|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Ikhw9cigPMSheQMo33B80f5yUSoHVz1nW2Y+YReDU4JpKqDHtrXKZ4h0eN?=
 =?iso-8859-1?Q?CS1JQPP1SBmHRW09FAHY3FXMw2kMhnLeOnwJ2tdCErqw2TZdlzRXRVF1ZO?=
 =?iso-8859-1?Q?EjdjUfDDoC5/Ep5qkB+xjGntpAmCWgLppeMOT+hVLC6+mPk8pkxAACUBkj?=
 =?iso-8859-1?Q?WiB0fTZVicj742lcbMcSKcmHG0Dhx3D/u7LzBuo0gHLjsn9GwFvV3QXyAt?=
 =?iso-8859-1?Q?ROZLPxfT4lfUPIBCZfnNklZZ6hyMVde5sh1Q5LmxcFT+spQA6WjjMYgMz9?=
 =?iso-8859-1?Q?1TGH6tJHSsQ/TOqLPjCMpYf+9glAA35vS402kbAUR960QlJUb7ELqQYNff?=
 =?iso-8859-1?Q?GvsSSYclySNNzewUgxXl36XuulOyTbb/X+/+m4Syyb9bvT4SIjwfivoreP?=
 =?iso-8859-1?Q?9Wd1keFU+gPT0e1bTsNIeYr31ARx7H0eVU6ML6lRAw+ZGEZ34uRuKpIJID?=
 =?iso-8859-1?Q?hNN3YMul6+SP+KHnfAzunQ2eZk7h8N1MGE0fii0EAYmzqsTH3ehIJOmplb?=
 =?iso-8859-1?Q?fgLrEis33SAt2Qt2eVMd0tTjXCgvfbA9wHo8X8h94vaFuLv6VEMsqH9EiG?=
 =?iso-8859-1?Q?PP2Ik8drJY6XanZkuQ2mluL01qSMVVvVrIObHHN0n2bIZTDqf/YCC0oSdp?=
 =?iso-8859-1?Q?3HqMfTQn1MNZv+MOvxYN3IN81L/Mr8T+1tBGWZE4FoqBfqxsxqBxR//RYv?=
 =?iso-8859-1?Q?JE0v1mblRe723cLZpsO1R87bz7GJJWK1/+d7KSoe9uoh9oomdpTARx0kdp?=
 =?iso-8859-1?Q?FyQ9Oa2htPm++QqedG1gaqZODS5yCcucjxmIT0rwYoFXrbWJF57ggWQ8xl?=
 =?iso-8859-1?Q?Fu4pdD0bPITzpq7XSWUtUZz5r6l278CBVybgNVUa/1XHRMVvGW8s1Lmw2L?=
 =?iso-8859-1?Q?Nxf3HkbUWPeBsthHfayDyBFYoTMJlfFPxIeQAW0MNIAePTlKxjiy8ubtf7?=
 =?iso-8859-1?Q?WgKK8+B4XPo+JP4vi53/2haOlFrYJQQryaI5VmXff0ZHrxlpa843B17oq3?=
 =?iso-8859-1?Q?H2G7exvGVQhG2Ry8HWK6u4ewrzxxRbbhslVloDZyQ1GXUsdsa6jwv0eZ29?=
 =?iso-8859-1?Q?cQ0VPyO6oEZcFTpDbhC5jpzzwjdsE/6DUUfEWXW8EfJgtWgzzyZbHEmFqV?=
 =?iso-8859-1?Q?Gp4NGzoPEr1uTuD3ohAcLx2dfXTyjnGgjZ+K12wAtuUWRlsWDbwB/YrHza?=
 =?iso-8859-1?Q?O44a6tZmaU9nTapEUfs4xjnF0JaWW9R6vu5mcMGP+noUyYAsXKh9PcXEKU?=
 =?iso-8859-1?Q?39nB0XxXpXILDSx78534Mun9rbvPSIfOxICMu+Di5WYrw/6bldwj+3Fk0d?=
 =?iso-8859-1?Q?WPix43KNg0+7xk4onWqwQC/o4VBEgBCqpNpjvRf5zTmhzUgD7SAdSENEpU?=
 =?iso-8859-1?Q?TF0IAqBOJXycNWGskuzCpc9M7pgTgennO6/9hNyEycNnGBy3R9OKAYs4pm?=
 =?iso-8859-1?Q?A0XT5FxVRqG1eqYOJXP+sOqNe/hggK/S52WEc/Oter2y+OkNLQUB33QSeQ?=
 =?iso-8859-1?Q?rtHU8VQFJc/uqaiFDZJI437qBPXdm507OFLTa/RslNpg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7458.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(8096899003)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?9gb7KH9L0LkgfTkmQ8rQPJMXbgk6gFWnpOLkal7EY2jRYg17w10jbPcW3G?=
 =?iso-8859-1?Q?QJnaNiuKAhjEgoBdp5FoHQGk/hfOdUI94sXqRwG4D7CuA05yl1ZDmFrIhO?=
 =?iso-8859-1?Q?x4Wn4p9PUpOkm2UWL1yzZMItr1ZMe7Gyt+YVgRmjZmpJ8b0v9Rcf8lm3Rl?=
 =?iso-8859-1?Q?Ev/JzxfQyjX/nooG3hM60dYM4/zmHDDIKkNdevcnK3xeoSqJik9zAsLcNg?=
 =?iso-8859-1?Q?5TD2xCwdKIfSEiHCC6RrbUSZttmzDwP5+cH6ihvAcmapVlyfiYys92bjEI?=
 =?iso-8859-1?Q?KA91B3i5d+0/AeRZ2AGn6MVTTf6pyvCcEx+IiD6TUoKf+H1ok6EjG7Y54p?=
 =?iso-8859-1?Q?HChBKkA/MpuwZHRZvOmycefiO4O1W5W2r2c5cuhp930ztn0HZ1SU9DYv1p?=
 =?iso-8859-1?Q?2J9iR7BW5G7zRsCPa1mHmHQ69hIRbJokQ9NIOiWi5evWuiZzX20W7Lan1c?=
 =?iso-8859-1?Q?tf079EbqxfJlbJVHLpzPw4NtqphdKFSp84WNE69HBmiLqAZjDrpwoAJqy+?=
 =?iso-8859-1?Q?Zr/suE5RTGlN0WH3wnXyOCd7bLmnSzbTylIN7S0M0TFem4amlpi9PHFkZC?=
 =?iso-8859-1?Q?vEIyfkrTmNZo1cgqQMghIDiWILtru1JwfbAtN9ibwmHoDDWnZDOtL67F45?=
 =?iso-8859-1?Q?TAmo/ZoqfVEcXmh+BnRFJLo5+I1JToLbEhQ/qxEdtP+BzLj+/Xek3HBXSx?=
 =?iso-8859-1?Q?clE+kiQYdOVRFuT6YNBJl/POcXNEF3Uv5M+arYpnsiXohxSwg0+hInf86i?=
 =?iso-8859-1?Q?osVdtSpxfozptocYUPIuWp6H7UAD5KHtjs4lOv0pZ8kKdgxg2lMmtI4sVo?=
 =?iso-8859-1?Q?fhLJBSvRyGWH58Dp+5mNRaVTDHDfJ+gS8nXJt9tKe8LqPWdihkuRH9qUfy?=
 =?iso-8859-1?Q?UohwZI2eDXfWbvZe13iQpwHq2HipgaNzvhgijcU+klxH6nEnlFanTeHo89?=
 =?iso-8859-1?Q?5HarcAiT9uHCuR8YbbyAdZZweGcBZn7uFPn9PB/2YwMkfiBT3SNIvdSrEF?=
 =?iso-8859-1?Q?3Lb+kl9p8hgK1aG0mKnO4wWx8liOiYFK6TT1HaMupNf/LLL147sYT+pY8R?=
 =?iso-8859-1?Q?ypoKcY1dkfoSD26ojWXwBJLZDbb9ZAWwGUiOLGLOXB+jAmPS4EP4oN8xp2?=
 =?iso-8859-1?Q?xEmOPSFAHUL2n64jYvfxwj1kLHy7+oGGqHGLwLyh8RlHnWIXzxpe6nhmEs?=
 =?iso-8859-1?Q?H2ZT4gZdoHrELSz099mi4besXte00jb6YEmn7CcnP9PBIAyjW9g4W+oixF?=
 =?iso-8859-1?Q?c9NGtQL6NQS3jjlEJFxYIb5gIl/eJ3P487cYp5ThmNLBN7d1OygW1vo4ey?=
 =?iso-8859-1?Q?QaJWSA21W+b3ZXP+eYsPg1r7txawr7e0iMZy1i83zkEWHj66fhlK98QFf0?=
 =?iso-8859-1?Q?fS+6LSH3Fn/RgPWEWqGQg1Tbr/DjKx+fo2HdDGnNoKhJxaChRipXXLa+Ts?=
 =?iso-8859-1?Q?7G61/EGq6/btq90OlV8J9XEFQHI5T+HgWdRL+CAp62lArYwuxCX1gQsrfv?=
 =?iso-8859-1?Q?qwhPaX5mWy9dbgYpbH0lt57AhlAOcKawsDrKvSDZkIYuuJF4cYLZaBxZKg?=
 =?iso-8859-1?Q?JTMD1NtHvVcQf+txP2Ol41hyxlos/2EtW3aCTUmypnV6k0Y/TqEZTAdgy0?=
 =?iso-8859-1?Q?xUvOnkr6sT+x00YLfhZR6957Ofr5aMRPNcl8J9Qbdt6erhP7v6j5+ZoAwg?=
 =?iso-8859-1?Q?5Tme+X3Y6/kNTnQjE+U=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DS0PR11MB7458F54FAE4573EEA5D30AEF8170ADS0PR11MB7458namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7458.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93db5ebf-1d39-4fef-0f81-08ddace08cc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2025 14:17:39.0667 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a7BmkuHlJHzl/tEAbj3cqEp+fSoFtWOA672Kvdy3tfnazu1My5K+FJ/LuTlTzspYTCoUxiYrnY15Orom/NDvbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6272
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

--_000_DS0PR11MB7458F54FAE4573EEA5D30AEF8170ADS0PR11MB7458namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hi Gowrishankar,

Thanks for reach out, I don't have those environments setup on my end, but =
Ubuntu 20.04 and RHEL8  are old but still common LTS packages.
Are you able to dump the actual msg buffer ?

It is highly possible relates to dsitro-specific patches ? Paddings ? Or cr=
ypto polices in RHEL ?

Regards

Kai

________________________________
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
Sent: Thursday, June 12, 2025 11:33
To: Ji, Kai <kai.ji@intel.com>
Cc: Anoob Joseph <anoobj@marvell.com>; dev@dpdk.org <dev@dpdk.org>; Akhil G=
oyal <gakhil@marvell.com>; Fan Zhang <fanzhang.oss@gmail.com>; Shally Verma=
 <shallyv@marvell.com>; Kanaka Durga Kotamarthy <kkotamarthy@marvell.com>; =
Ayuj Verma <ayverma@marvell.com>; Kusztal, ArkadiuszX <arkadiuszx.kusztal@i=
ntel.com>
Subject: RE: [PATCH] test/crypto: fix RSA decrypt op validation

Hi Kai Ji,
This patch adds a check on cop status after DECRYPT in existing RSA test.Th=
ere are
few CI failures for this patch and the failures are very specific to Openss=
l 1.1.1 variants
used in below platforms:
* Ubuntu 20.04 - Openssl 1.1.1f
* RHEL 8 - Openssl 1.1.1k

When I manually build these Openssl variants in the above platforms (using
Docker images) and execute tests using respective openssl shared libraries,
all tests PASS. If I use Openssl library that is shipped within the above
distributions, the test in patch FAIL.

I would like to get your opinion first to proceed on getting these patches =
CI acked.
In my debug, I don't see any issue with the patch and the patch adds better
Validation indeed. May be that, it has uncovered a potential failure in abo=
ve
Distros. Can you check on your end if these failures disappear in manual tr=
y.
What would you suggest to go forward, for openssl PMD ?

If required, I can start filing a Bugzilla as well.

Thanks,
Gowrishankar

>
> Following RSA encrypt op, same plaintext buffer is used as output buffer =
for
> decrypt op, hence comparing plaintext buffer against same buffer pointer =
in
> crypto op always succeed irrespective of whether decrypt op succeeds or n=
ot.
> This patch fixes this issue with a local buffer for crypto op.
>
> Fixes: 5ae36995f10 ("test/crypto: move RSA enqueue/dequeue into
> functions")
> Cc: stable@dpdk.org
>
> Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>


--_000_DS0PR11MB7458F54FAE4573EEA5D30AEF8170ADS0PR11MB7458namp_
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
<div class=3D"elementToProof" style=3D"font-family: &quot;IntelOne Text&quo=
t;; font-size: 10pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<div class=3D"elementToProof" style=3D"font-family: &quot;IntelOne Text&quo=
t;; font-size: 10pt; color: rgb(0, 0, 0);">
Hi Gowrishankar,</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;IntelOne Text&quo=
t;; font-size: 10pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;IntelOne Text&quo=
t;; font-size: 10pt; color: rgb(0, 0, 0);">
Thanks for reach out, I don't have those environments setup on my end, but =
Ubuntu 20.04 and RHEL8&nbsp; are old but still common LTS packages.&nbsp;</=
div>
<div class=3D"elementToProof" style=3D"font-family: &quot;IntelOne Text&quo=
t;; font-size: 10pt; color: rgb(0, 0, 0);">
Are you able to dump the actual msg buffer ?</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;IntelOne Text&quo=
t;; font-size: 10pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Arial, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
It is highly possible relates to dsitro-specific patches ? Paddings ? Or cr=
ypto polices in RHEL ?&nbsp;</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Arial, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Arial, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Regards</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Arial, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Arial, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Kai</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Arial, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;Gowrishankar Muthukrishnan &lt;gmuthukrishn@marvell.com&g=
t;<br>
<b>Sent:</b>&nbsp;Thursday, June 12, 2025 11:33<br>
<b>To:</b>&nbsp;Ji, Kai &lt;kai.ji@intel.com&gt;<br>
<b>Cc:</b>&nbsp;Anoob Joseph &lt;anoobj@marvell.com&gt;; dev@dpdk.org &lt;d=
ev@dpdk.org&gt;; Akhil Goyal &lt;gakhil@marvell.com&gt;; Fan Zhang &lt;fanz=
hang.oss@gmail.com&gt;; Shally Verma &lt;shallyv@marvell.com&gt;; Kanaka Du=
rga Kotamarthy &lt;kkotamarthy@marvell.com&gt;; Ayuj Verma &lt;ayverma@marv=
ell.com&gt;;
 Kusztal, ArkadiuszX &lt;arkadiuszx.kusztal@intel.com&gt;<br>
<b>Subject:</b>&nbsp;RE: [PATCH] test/crypto: fix RSA decrypt op validation=
 </div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-size: 11pt;">Hi Kai Ji,<br>
This patch adds a check on cop status after DECRYPT in existing RSA test.Th=
ere are<br>
few CI failures for this patch and the failures are very specific to Openss=
l 1.1.1 variants<br>
used in below platforms:<br>
* Ubuntu 20.04 - Openssl 1.1.1f<br>
* RHEL 8 - Openssl 1.1.1k<br>
<br>
When I manually build these Openssl variants in the above platforms (using<=
br>
Docker images) and execute tests using respective openssl shared libraries,=
<br>
all tests PASS. If I use Openssl library that is shipped within the above<b=
r>
distributions, the test in patch FAIL.<br>
<br>
I would like to get your opinion first to proceed on getting these patches =
CI acked.<br>
In my debug, I don't see any issue with the patch and the patch adds better=
<br>
Validation indeed. May be that, it has uncovered a potential failure in abo=
ve<br>
Distros. Can you check on your end if these failures disappear in manual tr=
y.<br>
What would you suggest to go forward, for openssl PMD ?<br>
<br>
If required, I can start filing a Bugzilla as well.<br>
<br>
Thanks,<br>
Gowrishankar<br>
<br>
&gt;<br>
&gt; Following RSA encrypt op, same plaintext buffer is used as output buff=
er for<br>
&gt; decrypt op, hence comparing plaintext buffer against same buffer point=
er in<br>
&gt; crypto op always succeed irrespective of whether decrypt op succeeds o=
r not.<br>
&gt; This patch fixes this issue with a local buffer for crypto op.<br>
&gt;<br>
&gt; Fixes: 5ae36995f10 (&quot;test/crypto: move RSA enqueue/dequeue into<b=
r>
&gt; functions&quot;)<br>
&gt; Cc: stable@dpdk.org<br>
&gt;<br>
&gt; Signed-off-by: Gowrishankar Muthukrishnan &lt;gmuthukrishn@marvell.com=
&gt;<br>
<br>
</div>
</body>
</html>

--_000_DS0PR11MB7458F54FAE4573EEA5D30AEF8170ADS0PR11MB7458namp_--
