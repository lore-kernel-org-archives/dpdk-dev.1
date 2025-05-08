Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0393C3ABBE
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 May 2025 23:53:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 801B64026C;
	Fri,  9 May 2025 01:53:24 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2118.outbound.protection.outlook.com [40.107.243.118])
 by mails.dpdk.org (Postfix) with ESMTP id 0989D4026B
 for <dev@dpdk.org>; Fri,  9 May 2025 01:53:20 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rSN+GWxQ69/yspcwGiarwpu8Xgta3mPAn3VxtxEURY+3Td2GSDOCHSx8aGS9CIZtiK52TQUfoZagQxNKcHNB+CrFQYHQJd0Ig0r3eONoQvMzphjogsB9Nx8r+pmeyyFJ007fJO3OG7SoIyhSWaSlu4DBdsAaP5BLpfTnszSKIigyHZiau1CCIpoWdhsbiaj0Q14J+Ihb9BsdGcf3G2eVKFmtagVIOeP4WeLdigR5bMHVTo9cg83tIP+y5QlutOQC+ggxzG76GS2iCiudWiCk1mIpp+U4JFsVa8dqrqtJXA2Oaom8VlvDhv5siOSE/vDpKh2fNI7MEgCCRJGdLal0rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/f93g8o6g2d3C1TDHVQQJqfqhtFOVUeAWmYUuZqEpI=;
 b=bXeI/NLGI0egDpjxIloUKKSP9L4Ow9dcpjK8f6lq/4g3dtj8WBioHh0Ye7JpnLnTsX8AfXtJGg4FyiM04E1CFHUJMVpgurVaZLeeg8FBhgzyut/PR7eHQ+D4QcjzI9g/s37Ewo4n/9BcZxcSuQG++CfqBBgcZ0YxXRhWJuxIKeRZ8NQDa1HT2TLYofxPXw9xlDvjZtfHXzdsb5LzafRZfILSZtLJgvpq4UO33Sa4Or0QkoCed6qFelgLju9nFGdkiBCrTM5Ugb3ZxBxHnEagpR9S3FcA4haSoKDJxFyw0Aggx/KN2qRd6bFUP2JsNkbJ/tVz8S1F70MyAOPxWCHqiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=unh.edu; dmarc=pass action=none header.from=unh.edu; dkim=pass
 header.d=unh.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unh.edu; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/f93g8o6g2d3C1TDHVQQJqfqhtFOVUeAWmYUuZqEpI=;
 b=CTtXABHxQmslekSy2wb8WGu0UJ82CR5vGFNUrHO4voas7klcdEnSL5CP2aPUP46bfrTm+Q1FlSwAJGMsSewCEAtjJB9q2CUB8VUsnR9fpCHiKlAGsagu0znAUbngwI+9IpQ7KeUJX8KMqkM4KfVK3+wrO7SudvUV3h0DL7lxSP8=
Received: from DM8P223MB0383.NAMP223.PROD.OUTLOOK.COM (2603:10b6:8:b::9) by
 CH0P223MB0124.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:f5::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.21; Thu, 8 May 2025 23:53:16 +0000
Received: from DM8P223MB0383.NAMP223.PROD.OUTLOOK.COM
 ([fe80::e52:6031:810f:a743]) by DM8P223MB0383.NAMP223.PROD.OUTLOOK.COM
 ([fe80::e52:6031:810f:a743%3]) with mapi id 15.20.8722.021; Thu, 8 May 2025
 23:53:16 +0000
From: Owen Hilyard <Owen.Hilyard@unh.edu>
To: "Van Haaren, Harry" <harry.van.haaren@intel.com>, "Etelson, Gregory"
 <getelson@nvidia.com>, "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH] rust: RFC/demo of safe API for Dpdk Eal, Eth and Rxq
Thread-Topic: [PATCH] rust: RFC/demo of safe API for Dpdk Eal, Eth and Rxq
Thread-Index: AQHbr6r0sqE17AHXak+XC2nGaMcQ/LOoNgYAgAEX6wCAAvcwAIAGwTaAgATktQCABLEMgIAA3kCAgAHmrICAABRGAIAAP/9tgAY2ToCAA2DxcQ==
Date: Thu, 8 May 2025 23:53:16 +0000
Message-ID: <DM8P223MB038399660EAB15CCEC365A868D8BA@DM8P223MB0383.NAMP223.PROD.OUTLOOK.COM>
References: <20250417151039.186448-1-harry.van.haaren@intel.com>
 <9c4a970a-576c-7b0b-7685-791c4dd2689d@nvidia.com>
 <PH8PR11MB6803458E6348B4D167C47C91D7BF2@PH8PR11MB6803.namprd11.prod.outlook.com>
 <IA1PR12MB63308A2F69036E3ACCC605D0A5B92@IA1PR12MB6330.namprd12.prod.outlook.com>
 <PH8PR11MB680363E200616CBB39DDDCB6D7852@PH8PR11MB6803.namprd11.prod.outlook.com>
 <c5387a8c-b560-3fde-3453-c2478d8e6969@nvidia.com>
 <IA1PR12MB6330872DB96BB9D83EF7EFF2A5832@IA1PR12MB6330.namprd12.prod.outlook.com>
 <aBMmUZ2RDSXQOHXg@bricha3-mobl1.ger.corp.intel.com>
 <a1161f7d-1a55-6200-7440-d615d5a41a6c@nvidia.com>
 <PH8PR11MB6803B2CD0BF276C6164C3D97D78D2@PH8PR11MB6803.namprd11.prod.outlook.com>
 <DM8P223MB038323681A4BEA771CF92A6D8D8D2@DM8P223MB0383.NAMP223.PROD.OUTLOOK.COM>
 <PH8PR11MB6803AD18258A79734D9ABD79D789A@PH8PR11MB6803.namprd11.prod.outlook.com>
In-Reply-To: <PH8PR11MB6803AD18258A79734D9ABD79D789A@PH8PR11MB6803.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=unh.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8P223MB0383:EE_|CH0P223MB0124:EE_
x-ms-office365-filtering-correlation-id: e552dfee-a792-42e7-a699-08dd8e8b8053
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?windows-1256?Q?GrI1wZiTCBrpLth1X9/UcEmfYJ++wtc8NKlZsny1hoH+ZD08gg17GcU/?=
 =?windows-1256?Q?qGX41Oko1jX2b/zjkvuoMuBagb27LVZKO1HT63Fb2OQ5YqAPK5YWj+eV?=
 =?windows-1256?Q?YBmxL6fPHqDbiqcUyedTWh0bMxvnHB1FiZ4r2R6TfjdhapxNX0fN+Ys+?=
 =?windows-1256?Q?ndKBeny7mXpvhEk579YGqHqE4oac52vtnUsHK6/q8GRDpbm9bM8e75/O?=
 =?windows-1256?Q?rb0QH+ibj8R5vZAByANiDPINptd8dk1rUhgEe+2SRnu2VU31J28UV8yd?=
 =?windows-1256?Q?6KNj3yP6c1s5vCi9UmWkPyELCA3JifaoaXiChXvxGtHHbtBDiMyo8k6h?=
 =?windows-1256?Q?dbsI7n17k06iUAIAZQcD3Ij99BfX36p0lA8+vWUL9jSbSlVBnwvDQWbi?=
 =?windows-1256?Q?u4wbhgdj4zyLUCooSra0bp/XkqkzpjTqXUcGX3Csl4zlAQUS6RUqjvyj?=
 =?windows-1256?Q?/TcCeGRmgehupRa9JEurQyS8jOCtJIWP9FrtNT+QNklTGO5Ep02oqLgN?=
 =?windows-1256?Q?LgAosjIhdeuy3d8JtylKYK6Q/zHFz+YtSHiOWRpYGp7cHPj1YRgpkjz+?=
 =?windows-1256?Q?Has8KRDBEryurb4ZPndddROjpzBiB2viY/Q5vwaJdz8pyRzEef+GQmQO?=
 =?windows-1256?Q?TbmHHl1eXZ6Z+Cb1WMW+rYLWbEUtL6zmbNqzq5cMRQEYyf3fogkZZQJi?=
 =?windows-1256?Q?/YQ7DFYNMK9WQpoRWWrXYo72hVvFpoBRLeFa0oz5oyHCXy3XzJhdMbq7?=
 =?windows-1256?Q?ZPAIvbZQTMuuUjBqHNfnwYjXe/Qb2JhSEBPYGmG6+Th5e+Odh9qHxUYF?=
 =?windows-1256?Q?MHbpCZmkbtLP8J9hoCIWdMjT+7Ygh2bhfvLEE8ES0Ss4TGDoBS+ydKK6?=
 =?windows-1256?Q?C2k+w5sWVPEjcUikuSg3+Zyr3cXzsmvpeA6TMx46myPlqL6IKZ3Opvpv?=
 =?windows-1256?Q?EQ1PuT8l23/6D8fegidhj+VWtDZhe++sC5mz4Z/DmoE8uyHlTz8Yx4jg?=
 =?windows-1256?Q?5DgODEEu/TXp0uRPn+l3z3EbRHjr5QnzfN1UBllVk1vIS0shDaHrivlV?=
 =?windows-1256?Q?gGiBijOI5vjS6R1Gw6eQ5rAhOV+AgzXa9nEHWFICupAXvMF1xAaWmEoJ?=
 =?windows-1256?Q?wKZrFKsNR2HjfcGt0oKAThd3/CarNxNBB7tuQrZn4T4aUoAi1WRqaH5I?=
 =?windows-1256?Q?BO5GhgUPRM/hzca6oVm/hDGulkFMCbtTP/M9LsfggV3udwp33kJimVOQ?=
 =?windows-1256?Q?V1cuyPCbH0TWS7FUJWeG/H4g8IDa/ZuosTFVY6XZiG10RU6BAsZNVuA+?=
 =?windows-1256?Q?YEGL+3ccD04ylU3s4lnKBvw7uZ1b59+JSAy4oJIrLVCYZAWiywhxmLFe?=
 =?windows-1256?Q?TlQG6vM7jM2pBSABH5zWVGOcwfxVD8JtuR3f/OsvOE0O7d1Vw3NW9HH7?=
 =?windows-1256?Q?7/SBv+ZR1SJ081QqmG4cKMFfLGePDe/SRsRWlzll3WOYbxMHhhU6Xr/W?=
 =?windows-1256?Q?VfFDUmZ3vsFsZVYeS7K17eo5G/hdlHBOzbApgC0k94hsBxT8BJ0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8P223MB0383.NAMP223.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?windows-1256?Q?tUmB/CGWGcRtT3wZyuU4y19XJt4w4hE4N8W+DkmDgOFtoeImA9Av/xoF?=
 =?windows-1256?Q?+QIYN/FKX0nAFleC4Pm7xwUQYVF6o0TYBKWTehHHvogMevAfIiM2yIPQ?=
 =?windows-1256?Q?G6wB5FFxXh9HdWkz3CjERNc7uXXwB4Xy8OKpGAs71iyDMQ274HuaL9xd?=
 =?windows-1256?Q?Cht6FSXYPP231GEg8dAuRZ38IQ82jtCbvzx1ZjYrk/dGnuKUr/5i1T/8?=
 =?windows-1256?Q?QN2MT1xWzHoetNDcGKCqTwGTQVpFQIDn8hGjN402sxQI50dSnm7+fRGj?=
 =?windows-1256?Q?j81rkIkvdXuWbTJ0384Bnez5hTKcjcLoN8cAH989KYsVIJaJrkybbksS?=
 =?windows-1256?Q?wy8rw7RekcSKrvQYat8D7KGNd+GA2EE65Vfm0N9UsbieNZPgMSnsd+H8?=
 =?windows-1256?Q?qt0tYWDEIznLzLwU+cNcTCB+CEnRrBq20vkhX+9EpUZufC6c/rCFrhB9?=
 =?windows-1256?Q?hjXGTKn03H4zmW8ag5eldvMSV3eiCFU9Xxpg8Dq7nJN6vkFSHFUbv+yB?=
 =?windows-1256?Q?D6V+1dJnrPvV5yQc83bkhffGVu3ucLc8bEpoY5MROtIElPSu8j+INPTw?=
 =?windows-1256?Q?DAP+Ky9+WasB8/cwRNNV5SqEPcpNJ3KdUB4WDAR5vj9yd6eW8OhpO/zW?=
 =?windows-1256?Q?6hUbXVNg09Y+lYTd5eKHk429SLLOIPI1tkx+Qf1T5dJODoqWSMWasAMr?=
 =?windows-1256?Q?ZBdACnUu5XMEHVOGOMKNpz7a72ad0rMlrutzzf2tNPpjk55DvvW6m0qp?=
 =?windows-1256?Q?oVkVXMuknekA/LFjn/fohG+oCz/nkdm6eVnJlN0PaI36yi2f15JFzWc1?=
 =?windows-1256?Q?Y2AHjHhAbu1bQFbn51nCMq8XE3p+1sg7/5q7Ky0WFS4hHQIEipAI9DtR?=
 =?windows-1256?Q?qHsQCLYeoyrYQ/AUNYDJNur+FeHN5GRzEl4NmFjWpD0Olp+P6iWo+mWJ?=
 =?windows-1256?Q?wijb6mKwiZbt9ay/6Z6t9inwY4OGE7YjmijXNeaNK6bLwDi8VIR/zctC?=
 =?windows-1256?Q?e00ho+aGDVRWBmj39pQbeiI18+Q19Q4CkDGWdvmRQrL67OLY2WaLaVJy?=
 =?windows-1256?Q?6LRR3z6h9UVGXr5j6uPoxszVJE51eV2Avs+cF2OxvkWXkCEdfqnRzmuc?=
 =?windows-1256?Q?b3h8GGLrQdHnURowwWAimTxkdXwvfMOgxIv7aJXP/FwLTtsF5xuXVSc9?=
 =?windows-1256?Q?N3Hro3dzwcTI9yRuYigIMboPPHmJQxlTq5CWMV0H2xBBi9fSqXYKgCjQ?=
 =?windows-1256?Q?H6UW+bPg9iuVzWu6FaIeRxkqa8bF4eElLdVPp+vtJ0Udrardir9wvkiZ?=
 =?windows-1256?Q?LsAgZYNj4jRDS0GNJxgFDssswxARRSeDhIKJWB+0H3xCEq6FhCXdCxod?=
 =?windows-1256?Q?kBnr8UmRrqUHvUZJvGG6OjXNOytAsbMa9wV69SvXjfsSDOIfNng6VFFu?=
 =?windows-1256?Q?sbfly+lNIkqFo2Dufl42pqjP/pfS7LXeSsN0POWkq/Mu1ApPKqzAfNPe?=
 =?windows-1256?Q?KLI0D/9pjEtLFQ3PxJSKq73MQjs10yKp85H5UZiPs2x9ap8XQqceDdeY?=
 =?windows-1256?Q?P5r86O4SHcqOVDcJARWFpl8Pou5fx+D2OnG2f/Bb2yV8B6gzo+O/3MI8?=
 =?windows-1256?Q?DoIT2xdRj3ht/cL6yA7rTj3vJLAeX1GrqIdQQXTUzVzGGtqIa/LUYAKa?=
 =?windows-1256?Q?wZiaTM2FIWo=3D?=
Content-Type: text/plain; charset="windows-1256"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: unh.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8P223MB0383.NAMP223.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e552dfee-a792-42e7-a699-08dd8e8b8053
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2025 23:53:16.0930 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d6241893-512d-46dc-8d2b-be47e25f5666
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kSGdKh++sorN87IUjcGpcmZZVBld9qq6S8pjbsusRvMaNmYoMGM1L/gvd+sJv5sRZpmxLQNov1xbDEMok+YnzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0P223MB0124
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

> =FDFrom:=A0Van Haaren, Harry <harry.van.haaren@intel.com>=0A=
> Sent:=A0Tuesday, May 6, 2025 12:39 PM=0A=
> To:=A0Owen Hilyard <Owen.Hilyard@unh.edu>; Etelson, Gregory <getelson@nvi=
dia.com>; Richardson, Bruce <bruce.richardson@intel.com>=0A=
> Cc:=A0dev@dpdk.org <dev@dpdk.org>=0A=
> Subject:=A0Re: [PATCH] rust: RFC/demo of safe API for Dpdk Eal, Eth and R=
xq=0A=
=0A=
> > From: Owen Hilyard=0A=
> > Sent: Saturday, May 03, 2025 6:13 PM=0A=
> > To: Van Haaren, Harry; Etelson, Gregory; Richardson, Bruce=0A=
> > Cc: dev@dpdk.org=0A=
> > Subject: Re: [PATCH] rust: RFC/demo of safe API for Dpdk Eal, Eth and R=
xq=0A=
> >=0A=
> > From: Van Haaren, Harry <harry.van.haaren@intel.com>=0A=
> > Sent: Friday, May 2, 2025 9:58 AM=0A=
> > To: Etelson, Gregory <getelson@nvidia.com>; Richardson, Bruce <bruce.ri=
chardson@intel.com>=0A=
> > Cc: dev@dpdk.org <dev@dpdk.org>; Owen Hilyard <owen.hilyard@unh.edu>=0A=
> > Subject: Re: [PATCH] rust: RFC/demo of safe API for Dpdk Eal, Eth and R=
xq=0A=
> >=0A=
> > > From: Etelson, Gregory=0A=
> > > Sent: Friday, May 02, 2025 1:46 PM=0A=
> > > To: Richardson, Bruce=0A=
> > > Cc: Gregory Etelson; Van Haaren, Harry; dev@dpdk.org; owen.hilyard@un=
h.edu=0A=
> > > Subject: Re: [PATCH] rust: RFC/demo of safe API for Dpdk Eal, Eth and=
 Rxq=0A=
> > >=0A=
> > > Hello Bruce,=0A=
> >=0A=
> > Hi All,=0A=
> > Hi All,=0A=
>=0A=
> Hi All!=0A=
>=0A=
> Great to see passionate & detailed replies & input!=0A=
>=0A=
> Please folks - lets try remember to send plain-text emails, and use=A0 >=
=A0 to indent each reply.=0A=
>Its hard to identify what I wrote (1) compared to Owen's replies (2) in th=
e archives otherwise.=0A=
> (Adding some "Harry wrote" and "Owen wrote" annotations to try help futur=
e readability.)=0A=
=0A=
My apologies, I'll be more careful with that.=0A=
=0A=
> Maybe it will help to split the conversation into two threads, with one f=
ocussing on=0A=
"DPDK used through Safe Rust abstractions", and the other on "future cool u=
se-cases".=0A=
=0A=
Agree. =0A=
=0A=
> Perhaps I jumped a bit too far ahead mentioning async runtimes, and while=
 I like the enthusiasm for designing "cool new stuff", it is probably bette=
r to be realistic around what will get "done": my bad.=0A=
> =0A=
> I'll reply to the "DPDK via Safe Rust" topics below, and start a new thre=
ad (with same folks on CC) for "future cool use-cases" when I've had a chan=
ce to clean up a little demo to showcase them.=0A=
>=0A=
>=0A=
> > > > Thanks for sharing. However, IMHO using EAL for thread management i=
n rust=0A=
> > > > is the wrong interface to expose.=0A=
> > >=0A=
> > > EAL is a singleton object in DPDK architecture.=0A=
> > > I see it as a hub for other resources.=0A=
>=0A=
> Harry Wrote:=0A=
> > Yep, i tend to agree here; EAL is central to the rest of DPDK working c=
orrectly.=0A=
> > And given EALs implementation is heavily relying on global static varia=
bles, it is=0A=
> > certainly a "singleton" instance, yes.=0A=
> =0A=
> Owen wrote:=0A=
> > I think a singleton one way to implement this, but then you lose some o=
f the RAII/automatic resource management behavior. It would, however, make =
some APIs inherently unsafe or very unergonomic unless we were to force rte=
_eal_cleanup to be run via atexit(3) or the platform equivalent and forbid =
the user from running it themselves. For a lot of Rust runtimes similar to =
the EAL (tokio, glommio, etc), once you spawn a runtime it's around until p=
rocess exit. The other option is to have a handle which represents the stat=
e of the EAL on the Rust side and runs rte_eal_init on creation and rte_eal=
_cleanup on destruction. There are two ways we can make that safe. First, r=
eference counting, once the handles are created, they can be passed around =
easily, and the last one runs rte_eal_cleanup when it gets dropped.=A0 This=
 avoids having tons of complicated lifetimes and I think that, everywhere t=
hat it shouldn't affect fast path performance, we should use refcounting.=
=0A=
>=0A=
> Agreed, refcounts for EAL "singleton" concept yes. For the record, the in=
itial patch actually returns a=0A=
"dpdk" object from dpdk::Eal::init(), and Drop impl has a // TODO rte_eal_c=
leanup(), so well aligned on approach here.=0A=
> https://patches.dpdk.org/project/dpdk/patch/20250418132324.4085336-1-harr=
y.van.haaren@intel.com/=0A=
=0A=
One thing I think I'd like to see is using a "newtype" for important number=
s (ex: "struct EthDevQueueId(pub u16)"). This prevents some classes of erro=
r but if we make the constructor public it's at most a minor inconvenience =
to anyone who has to do something a bit odd. =0A=
=0A=
> > Owen wrote:=0A=
> > The other option is to use lifetimes. This is doable, but is going to f=
orce people who are more likely to primarily be C or C++ developers to dive=
 deep into Rust's type system if they want to build abstractions over it. I=
f we add async into the mix, as many people are going to want to do, it's g=
oing to become much, much harder. As a result, I'd advocate for only using =
it for data path components where refcounting isn't an option.=0A=
>=0A=
> +1 to not using lifetimes here, it is not the right solution for this EAL=
 / singleton type problem.=0A=
=0A=
Having now looked over the initial patchset in more detail, I think we do h=
ave a question of how far down "it compiles it works" we want to go. For ex=
ample, using typestates to make Eal::take_eth_ports impossible to call more=
 than once using something like this:=0A=
=0A=
#[derive(Debug, Default)]=0A=
pub struct Eal<const HAS_ETHDEV_PORTS: bool> {=0A=
    eth_ports: Vec<eth::Port>,=0A=
}=0A=
=0A=
impl<const HAS_ETHDEV_PORTS: bool> Eal<HAS_ETHDEV_PORTS> {=0A=
    pub fn init() -> Result<Self, String> {=0A=
        // EAL init() will do PCI probe and VDev enumeration will find/crea=
te eth ports.=0A=
        // This code should loop over the ports, and build up Rust structs =
representing them=0A=
        let eth_port =3D vec![eth::Port::from_u16(0)];=0A=
        Ok(Eal {=0A=
            eth_ports: Some(eth_port),=0A=
        })=0A=
    }=0A=
}=0A=
=0A=
impl Eal<true> {=0A=
    pub fn take_eth_ports(self) -> (Eal<false>, Vec<eth::Port>) {=0A=
        (Eal::<false>::default(), self.eth_ports.take())=0A=
    }=0A=
}=0A=
=0A=
impl<const HAS_ETHDEV_PORTS: bool> Drop for Eal<HAS_ETHDEV_PORTS> {=0A=
    fn drop(&mut self) {=0A=
        if HAS_ETHDEV_PORTS {=0A=
            // extra desired port cleanup=0A=
        }=0A=
        // todo: rte_eal_cleanup()=0A=
    }=0A=
}=0A=
=0A=
This does add some noise to looking at the struct, but also lets the compil=
er enforce what state a struct should be in to call a given function. Taken=
 to its logical extreme, we could create an API where many of the "resource=
 in wrong state" errors should be impossible. However, it also requires mor=
e knowledge of Rust's type system on the part of the people making the API =
and can be a bit harder to understand without an LSP helping you along.=0A=
=0A=
> Gregory wrote:=0A=
> > > Following that idea, the EAL structure can be divided to hold the=0A=
> > > "original" resources inherited from librte_eal and new resources=0A=
> > > introduced in Rust EAL.=0A=
> =0A=
> Harry wrote:=0A=
> > Here we can look from different perspectives. Should "Rust EAL" even ex=
ist?=0A=
> > If so, why? The DPDK C APIs were designed in baremetal/linux days, wher=
e=0A=
> > certain "best-practices" didn't exist yet, and Rust language was pre 1.=
0 release.=0A=
> >=0A=
> > Of course, certain parts of Rust API must depend on EAL being initializ=
ed.=0A=
> > There is a logical flow to DPDK initialization, these must be kept for =
correct functionality.=0A=
> >=0A=
> > I guess I'm saying, perhaps we can do better than mirroring the concept=
 of=0A=
> > "DPDK EAL in C" in to "DPDK EAL in Rust".=0A=
> =0A=
> Owen wrote:=0A=
> > I think that there will need to be some kind of runtime exposed by the =
library. A lot of the existing EAL abstractions may need to be reworked, es=
pecially those dealing with memory, but I think a lot of things can be laye=
red on top of the C API. However, I think many of the invariants in the EAL=
 could be enforced at compile time for free, which may mean the creation of=
 a lot of "unchecked" function variants which skip over null checks and oth=
er validation.=0A=
> =0A=
> Agree that most (if not all?) things can be layered on top of the C API. =
Lets leave the "unchecked" function variants discussion until we have code =
to discuss, its hard to know right now because we don't have an implementat=
ion to talk about.=0A=
=0A=
ack. I was mostly referring to eliminating null checks or "does this queue/=
port exist?" checks, but that can be a later discussion.=0A=
=0A=
> Owen wrote:=0A=
> > As was mentioned before, it may also make sense for some abstractions i=
n the C EAL to be lifted to compile time. I've spent a lot of time thinking=
 about how to use something like Rust's traits for "it just works" capabili=
ties where you can declare what features you want (ex: scatter/gather) and =
it will either be done in hardware or fall back to software, since you were=
 going to need to do it anyway. This might lead to parameterizing a lot of =
user code on the devices they expect to interact with and then having some =
"dyn EthDev" as a fallback, which should be roughly equivalent to what we h=
ave now. I can explain that in more detail if there's interest.=0A=
> =0A=
> This goes into the "cool new stuff" category in my head: I agree these co=
ncepts are possible, =0A=
> but i feel we must prioritize the "DPDK via Safe Rust" and achieve that f=
irst. We cannot put the=0A=
> cherry on the cake, if the cake is still under construction :)=0A=
> =0A=
> (Techie note, the description is for a "polyfill" of specific functionali=
ty. This is often done via=0A=
> stacking or layering operations that all provide the same trait in Rust. =
This is very nice, as one=0A=
> can provide a specific implementation of a functionality, and compose it =
with other functionalities.=0A=
> For examples look at how the "tower" crate: "a library of modular and reu=
sable components for building robust networking clients and servers"=0A=
> =0A=
> To be very clear - cool techie stuff, but we need to get the basics in pl=
ace first, before looking at dyn Ethdev type concepts.=0A=
>=0A=
> Harry/Gregory/Bruce wrote (in order of indentation):=0A=
> > > > Instead, I believe we should be=0A=
> > > > encouraging native rust thread management, and not exposing any DPD=
K=0A=
> > > > threading APIs except those necessary to have rust threads work wit=
h DPDK,=0A=
> > > > i.e. with an lcore ID. Many years ago when DPDK started, and in the=
 C=0A=
> > > > world, having DPDK as a runtime environment made sense, but times h=
ave=0A=
> > > > changed and for Rust, there is a whole ecosystem out there already =
that we=0A=
> > > > need to "play nice with", so having Rust (not DPDK) do all thread=
=0A=
> > > > management is the way to go (again IMHO).=0A=
> > > >=0A=
> > >=0A=
> > > I'm not sure what exposed DPDK API you refer to.=0A=
> >=0A=
> > I think that's the point :) Perhaps the Rust application should decide =
how/when to=0A=
> create threads, and how to schedule & pin them. Not the "DPDK crate for R=
ust".=0A=
> To give a more concrete examples, lets look at Tokio (or Monoio, or Glomm=
io, or .. )=0A=
> which are prominent players in the Rust ecosystem, particularly for netwo=
rking workloads=0A=
> where request/response patterns are well served by the "async" programmin=
g model (e.g HTTP server).=0A=
>=0A=
> Owen wrote:=0A=
> > Rust doesn't really care about threads that much. Yes, it has std::thre=
ad as a pthread equivalent, but on Linux those literally call pthread. Enfo=
rcing the correctness of the Send and Sync traits (responsible for helping =
enforce thread safety) in APIs is left to library authors. I've used Rust w=
ith EAL threads and it's fine, although a slightly nicer API for launching =
based on a closure (which is a function pointer and a struct with the captu=
red inputs) would be nice. In Rust, I'd say that async and threads are orth=
ogonal concepts, except where runtimes force them to mix. Async is a way to=
 write a state machine or (with some more abstraction) an execution graph, =
and Rust the language doesn't care whether a library decides to run some de=
pendencies in parallel. What I think Rust is more likely to want is thread =
per core and then running either a single async runtime over all of them or=
 an async runtime per core.=0A=
> =0A=
> The key point above is "except where runtimes force them to mix". The DPD=
K rxq concept (struct Rxq in the code linked above) is !Send.=0A=
> As a result, it cannot be moved between threads. That allows per-lcore co=
ncepts to be used for performance.=0A=
=0A=
The problem is that, with Tokio, it also can't be held across an await poin=
t. I agree that !Send is correct, but the existence of !Send resources mean=
s that integration with Tokio is much, much harder. For PMDs with RTE_ETH_T=
X_OFFLOAD_MT_LOCKFREE, TX is fine, but as far as I am aware there is no equ=
ivalent for RX. And, to safely take advantage of the TX version, we'd need =
to know the capabilities of the target PMD at compile time, which is part o=
f why my own bindings "devirtualize" the EAL and require a top-level functi=
on which dispatches based on the capabilities provided by the PMDs I make u=
se of. Glommio was easily able to integrate safely (theoretically Monoio wo=
uld be too, although I haven't used it), but I haven't found a safe way to =
mix Tokio and queue handles which doesn't make it nearly impossible to use =
async, even when taking that fairly extreme measure. =0A=
=0A=
> The point I was trying to make is that we (the DPDK safe rust wrapper API=
) should not be prescriptive in how it is used.=0A=
> In other words: we should allow the user to decide how to spawn/manage/ru=
n threads.=0A=
>=0A=
> We must encode the DPDK requirements of e.g. "Rxq concept" with !Send, !S=
ync marker traits.=0A=
> Then the Rust compiler will at compile-time ensure the users code is corr=
ect.=0A=
=0A=
I agree that !Send and !Sync are likely correct for Rxqs, however, we also =
need to be very careful in documenting the WHY of !Send and !Sync in each c=
ontext. For instance, how are we going to get the queue handles to the thre=
ads which run the data path if we get all of them from an Eal struct in a V=
ec on the main thread? We may need to have a way to "deactivate" them so th=
e user can't use them for queue operations but they are Send, !Sync, emit a=
 fence, and then when the user "activates" them it performs another fence t=
o force anything the last thread did with the queue to be visible on the ne=
w core. I suspect we'll need to apply a similar pattern for other thread un=
safe parts of DPDK in order to get them to where they need to be during exe=
cution. =0A=
=0A=
> I don't believe that I can identify all use-cases, so we cannot design re=
quirements around statements like "I think X is more likely than Y".=0A=
=0A=
I agree, this is why unsafe escape hatches will be necessary. Someone will =
have some weird edge-case like a CPU with no cache that makes it fine to mo=
ve Rxqs around with abandon. =0A=
=0A=
> Harry wrote:=0A=
> > Lets focus on Tokio first: it is an "async runtime" (two links for futu=
re readers)=0A=
> >=A0=A0=A0=A0 <snip>=0A=
> > So an async runtime can run "async" Rust functions (called Futures, or =
Tasks when run independently..)=0A=
> > There are lots of words/concepts, but I'll focus only on the thread cre=
ation/control aspect, given the DPDK EAL lcore context.=0A=
> > =0A=
> > Tokio is a work-stealing scheduler. It spawns "worker" threads, and the=
n gives these "tasks"=0A=
> > to various worker cores (similar to how Golang does its work-stealing s=
cheduling). Some=0A=
> > DPDK crate users might like this type of workflow, where e.g. RXQ polli=
ng is a task, and the=0A=
> > "tokio runtime" figures out which worker to run it on. "Spawning" a tas=
k causes the "Future"=0A=
> > to start executing. (technical Rust note: notice the "Send" bound on Fu=
ture: https://docs.rs/tokio/latest/tokio/task/fn.spawn.html=A0)=0A=
> > The work stealing aspect of Tokio has also led to some issues in the Ru=
st ecosystem. What it effectively means is that every "await" is a place wh=
ere you might get moved to another thread. This means that it would be unso=
und to, for example, have a queue handle on devices without MT-safe queues =
unless we want to put a mutex on top of all of the device queues. I persona=
lly think this is a lot of the source of people thinking that Rust async is=
 hard, because Tokio forces you to be thread safe at really weird places in=
 your code and has issues like not being able to hold a mutex over an await=
 point.=0A=
> >=0A=
> > Other users might prefer the "thread-per-core" and CPU pinning approach=
 (like DPDK itself would do).=0A=
> > nit: Tokio also spawns a thread per core, it just freely moves tasks be=
tween cores. It doesn't pin because it's designed to interoperate with the =
normal kernel scheduler more nicely. I think that not needing pinned cores =
is nice, but we want the ability to pin for performance reasons, especially=
 on NUMA/NUCA systems (NUCA =3D Non-Uniform Cache Architecture, almost ever=
y AMD EPYC above 8 cores, higher core count Intel Xeons for 3 generations, =
etc).=0A=
> > Monoio and Glommio both serve these use cases (but in slightly differen=
t ways!). They both spawn threads and do CPU pinning.=0A=
> > Monoio and Glommio say "tasks will always remain on the local thread". =
In Rust techie terms: "Futures are !Send and !Sync"=0A=
>=A0> https://docs.rs/monoio/latest/monoio/fn.spawn.html=A0=A0=A0=A0 =0A=
> > https://docs.rs/glommio/latest/glommio/fn.spawn_local.html=0A=
> =0A=
> Owen wrote:=0A=
> > There is also another option, one which would eliminate "service cores"=
. We provide both a work stealing pool of tasks that have to deal with bein=
g yanked between cores/EAL threads at any time, but aren't data plane tasks=
, and then a different API for spawning tasks onto the local thread/core fo=
r data plane tasks (ex: something to manage a particular HTTP connection). =
This might make writing the runtime harder, but it should provide the best =
of both worlds provided we can build in a feature (Rust provides a way to "=
ifdef out" code via features) to disable one or the other if someone doesn'=
t want the overhead.=0A=
> =0A=
> Hah, yeah.. (as maintainer of service cores!) I'm aware that the "async R=
ust" cooperative scheduling is very similar.=0A=
> That said, the problem service-cores set out to solve is a very different=
 one to how "async Rust" came about.=0A=
> The implementations, ergonomics, and the language its written in are diff=
erent too... so they're different beasts!=0A=
=0A=
I think we could still make use of the idea of separate pools of thread loc=
al and global tasks. =0A=
=0A=
> We don't want to start writing "dpdk-async-runtime". The goal is not to d=
uplicate everything, we must integrate with existing.=0A=
=0A=
What do you picture someone who picks up "dpdk-rs" seeing as the interface =
to DPDK when it's fully integrated? Do they enable a feature flag in their =
async runtime and the runtime handles it for them, do they set up DPDK and =
start the runtime? Most of the libraries I'm aware of assume the presence o=
f an OS network stack. Yes, there are some like smoltcp which are capable o=
f operating on top of the l2 interface provided by DPDK, but most are going=
 to want a network stack to exist on top of. =0A=
=0A=
> I will try provide some examples of integrating DPDK with other Rust netw=
orking projects, to prove that it can be done, and is useful.=0A=
>=0A=
> Harry wrote:=0A=
> > So there are at least 3 different async runtimes (and I haven't even ta=
lked about async-std, smol, embassy, ...) which=0A=
> > all have different use-cases, and methods of running "tasks" on threads=
. These runtimes exist, and are widely used,=0A=
> > and applications make use of their thread-scheduling capabilities.=0A=
> >=0A=
> > So "async runtimes" do thread creation (and optionally CPU pinning) for=
 the user.=0A=
> > Other libraries like "Rayon" are thread-pool managers, those also have =
various CPU thread-create/pinning capabilities.=0A=
> > If DPDK *also* wants to do thread creation/management and CPU-thread-to=
-core pinning for the user, that creates tension.=0A=
> > The other problem is that most of these async runtimes have IO very tig=
htly integrated into them. A large portion of Tokio had to be forked and re=
written for io_uring support, and DPDK is a rather stark departure from wha=
t they were all designed for. I know that both Tokio and Glommio have "star=
t a new async runtime on this thread" functions, and I think that Tokio has=
 an "add this thread to a multithreaded runtime" somewhere.=0A=
> >=0A=
> > I think the main thing that DPDK would need to be concerned about is th=
at many of these runtimes use thread locals, and I'm not sure if that would=
 be transparently handled by the EAL thread runtime since I've always used =
thread per core and then used the Rust runtime to multiplex between tasks i=
nstead of spawning more EAL threads.=0A=
> >=0A=
> > Rayon should probably be thought of in a similar vein to OpenMP, since =
it's mainly designed for batch processing. Unless someone is doing some fai=
rly heavy computation (the kind where "do we want a GPU to accelerate this?=
" becomes a question) inside of their DPDK application, I'm having trouble =
thinking of a use case that would want both DPDK and Rayon.=0A=
>> =0A=
> > > Bruce wrote: "so having Rust (not DPDK) do all thread management is t=
he way to go (again IMHO)."=0A=
> >=0A=
> > I think I agree here, in order to make the Rust DPDK crate usable from =
the Rust ecosystem,=0A=
> > it must align itself with the existing Rust networking ecosystem.=0A=
> > =0A=
> > That means, the DPDK Rust crate should not FORCE the usage of lcore pin=
nings and mappings.=0A=
> > Allowing a Rust application to decide how to best handle threading (via=
 Rayon, Tokio, Monoio, etc)=0A=
> > will allow much more "native" or "ergonomic" integration of DPDK into R=
ust applications.=0A=
> =0A=
> Owen wrote:=0A=
> > I'm not sure that using DPDK from Rust will be possible without either =
serious performance sacrifices or rewrites of a lot of the networking libra=
ries. Tokio continues to mimic the BSD sockets API for IO, even with the io=
_uring version, as does glommio. The idea of the "recv" giving you a buffer=
 without you passing one in isn't really used outside of some lower-level i=
o_uring crates. At a bare minimum, even if DPDK managed to offer an API tha=
t works exactly the same ways as io_uring or epoll, we would still need to =
go to all of the async runtimes and get them to plumb DPDK support in or ap=
prove someone from the DPDK community maintaining support. If we don't offe=
r that API, then we either need rewrites inside of the async runtimes or fo=
r individual libraries to provide DPDK support, which is going to be even m=
ore difficult.=0A=
> =0A=
> Regarding traits used for IO, correct many are focussed on "recv" giving =
you a buffer, but not all. Look at Monoio, specifically the *Rent APIs:=0A=
> https://docs.rs/monoio/latest/monoio/io/index.html#traits=0A=
=0A=
As far as I can tell, the *Rent APIs for Monoio have the same problem, they=
 require you to pass in a buffer, and to satisfy that API we'd need to thro=
w out zero copy, pass that buffer directly to the PMD, or do some weird thi=
ng were we use that API to recycle buffers back into the mempool. I see, in=
 Monoio terms, a DPDK API looking more like TcpStream::read(&mut self) -> i=
mpl Future<Output =3D BufResult<usize, dpdk::PktMbuf>> or some equivalent a=
bstraction on top. =0A=
=0A=
> Owen wrote:=0A=
> > I agree that forcing lcore pinnings and mappings isn't good, but I thin=
k that DPDK is well within its rights to build its own async runtime which =
exposes a standard API. For one thing, the first thing Rust users will ask =
for is a TCP stack, which the community has been discussing and debating fo=
r a long time. I think we should figure out whether the goal is to allow DP=
DK applications to be written in Rust, or to allow generic Rust application=
s to use DPDK. The former means that the audience would likely be Rust-flue=
nt people who would have used DPDK regardless, and are fine dealing with me=
mpools, mbufs, the eal, and ethdev configuration. The latter is a much larg=
er audience who is likely going to be less tolerant of dpdk-rs exposing the=
 true complexity of using DPDK. Yes, Rust can help make the abstractions be=
tter, but there's an amount of inherent complexity in "Your NIC can handle =
IPSec for you and can also direct all IPv6 traffic to one core" that I don'=
t think we can remove.=0A=
> =0A=
> Ok, we're getting very far into future/conceptual design here.=0A=
> For me, DPDK having its own async runtime and its own DPDK TCP stack is N=
OT the goal.=0A=
> We should try to integrate DPDK with existing software environments - not=
 rewrite the world.=0A=
=0A=
Which existing software environments are you thinking of exactly? Most Rust=
 applications that use networking are going to be using Axum, Tower, and th=
e other crates that you've mentioned, and all of those rely on having a TCP=
 stack to be useful. I have found vanishingly few Rust crates which handle =
integration with DPDK without me editing them to some degree. I'd like to k=
now where you're finding existing Rust software environments which don't ca=
re about the presence of a network stack but are still networking oriented.=
 If the goal is to take a DPDK application that would have been written in =
C/C++ and write it in Rust instead, that is very different than taking an a=
pplication which would have happily used the OS network stack, such as an H=
TTP server which deals with normal (<1k RPS) amounts of traffic, and moving=
 it onto DPDK, and it seems to me like you are suggesting that we should fo=
cus on the latter.=0A=
=0A=
> Owen wrote:=0A=
> > I personally think that making an API for DPDK applications to be writt=
en in Rust, and then steadily adding abstractions on top of that until we a=
rrive at something that someone who has never looked at a TCP header can us=
e without too much confusion. That was part of the goal of the Iris project=
 I pitched (and then had to go finish another project so the design is stil=
l WIP). I think that a move to DPDK is going to be as radical of a change a=
s a move to io_uring, however, DPDK is fast enough that I think it may be p=
ossible to convince people to do a rewrite once we arrive at that high leve=
l API.=0A=
> =0A=
> I haven't heard of the Iris project you mentioned, is there something con=
crete to learn from, or is it too WIP to apply?=0A=
=0A=
I have some design docs, but nothing concrete. I got pulled back to another=
 project which is still ongoing shortly after I gave the talk at the last D=
PDK summit. The main goal of Iris is to provide a DPDK-based alternative to=
 something like a gRPC with a message-based API instead of a byte-based one=
, and to take advantage of the massive amount of extra breathing room under=
 that new API (as compared to TCP) to plumb in the various accelerators int=
egrated into DPDK alongside a network stack. It's based on observations tha=
t many developers aren't even working at a TCP or HTTP level any more, but =
are instead using "JSON RPC over HTTPS which is automatically converted int=
o objects by their HTTP server framework" or something like gRPC to have a =
"send message to server" and "get message to server" API. Most of what I ha=
ve for that is a lot of time spent thinking about a Rust-based API on top o=
f DPDK as a foundation for building the rest of the network stack on top. =
=0A=
=0A=
> Owen wrote:=0A=
> > "Swap out your sockets and rework the functions that do network IO for =
a 5x performance increase" is a very, very attractive offer, but for us to =
get there I think we need to have DPDK's full potential available in Rust, =
and then build as many zero-overhead (zero cost or you couldn't write it be=
tter yourself) abstractions as we can on top. I want to avoid a situation w=
here we build up to the high-level APIs as fast as we can and then end up i=
n a situation where you have "Easy Mode" and then "C DPDK written in Rust" =
as your two options.=0A=
> =0A=
> My perspective is that we're carefully designing "Safe Rust" APIs, and wi=
ll have "DPDKs full potential" as a result.=0A=
> I'm not sure where the "easy mode" comment applies. But lets focus on cod=
e - and making concrete progress - over theoretical discussions.=0A=
> =0A=
> I'll keep my input more consise in future, and try get more patches on li=
st for review.=0A=
> > > Regards,=0A=
> > > Gregory=0A=
> >=0A=
> > Apologies for the long-form, "wall of text" email, but I hope it captur=
es the nuance of threading and=0A=
> > async runtimes, which I believe in the long term will be very nice to c=
apture "async offload" use-cases=0A=
> > for DPDK. To put it another way, lookaside processing can be hidden beh=
ind async functions & runtimes,=0A=
> > if we design the APIs right: and that would be really cool for making a=
sync-offload code easy to write correctly!=0A=
> >=0A=
> > Regards, -Harry=0A=
> >=0A=
> > Sorry for my own walls of text. As a consequence of working on Iris I'v=
e spent a lot of time thinking about how to make DPDK easier to use while k=
eeping the performance intact, and I was already thinking in Rust since it =
provides one of the better options for these kinds of abstractions (the oth=
er option I see is Mojo, which isn't ready yet). I want to see DPDK become =
more accessible, but the performance and access to hardware is one of the m=
ain things that make DPDK special, so I don't want to compromise that. I de=
finitely agree that we need to force DPDK's existing APIs to justify themse=
lves in the face of the new capabilities of Rust, but I think that starting=
 from "How are Rust applications written today?" is a mistake.=0A=
> >=0A=
> > Regards,=0A=
> > Owen=0A=
> =0A=
> Generally agree, but just this line stood out to me:=0A=
> > Owen wrote:=A0=A0 I think that starting from "How are Rust applications=
 written today?" is a mistake.=0A=
> =0A=
> We have to understand how applications are written today, in order to und=
erstand what it would take to move them to a DPDK backend.=0A=
> In C, consuming DPDK is hard, as applications expect TCP via sockets, and=
 DPDK provides mbuf*s: that's a large mismatch. (Yes I'm aware of various D=
PDK-aware TCP stacks etc.)=0A=
>=0A=
> In Rust, applications expect a "let tcp_port =3D TcpListener::bind()", an=
d then to "tcp_port.accept()" incoming requests.=0A=
> Those requirements can be met by: std::net::TcpListener, tokio::net::TcpL=
istener, and in future, some DPDK (SmolTCP?) based TcpListener.=0A=
> - https://doc.rust-lang.org/std/net/struct.TcpListener.html=0A=
> - https://docs.rs/tokio/latest/tokio/net/struct.TcpListener.html=0A=
> =0A=
> The ability to move between abstractions is much easier in Rust. As a res=
ult, providing "normal looking APIs" is IMO the best way forward.=0A=
=0A=
Yes, moving between abstractions is easier in Rust, but I think that the ab=
straction provided by std::net::TcpListener and tokio::net::TcpListener is =
flawed. I'm not sure there is a good way to provide a "normal" API without =
fairly serious performance compromises. For example, as I'm sure everyone h=
ere is aware, the traditional BSD sockets API requires double the memory ba=
ndwidth that a zero-copy one does on the rx path. Those APIs also ignore TL=
S, meaning that we would actually need to go look at a wrapper over rustls =
or some other TLS implementation as what users interact with. I can keep go=
ing up levels, but this is why I decided to put the highest level of abstra=
ction in Iris, the one I intend most people to interact with at "get this b=
lob of bytes over to that other server as a message, possibly encrypting it=
, compressing it, doing zero trust checks, etc". I'm not sure if applicatio=
ns expect a TcpListener, so much as an HttpListener, or a JsonRPCListener. =
I think it would be wise to determine what type of API people would want fo=
r a dpdk-rs, rather than making an assumption that they want something like=
 BSD sockets. Even inside of the kernel io_uring has been breaking away fro=
m that API with an API that looks a lot more like what I would expect from =
DPDK, and providing ergonomics benefits to users while doing it. =0A=
=0A=
> Regards, and thanks for the input & discussion. -Harry=0A=
=0A=
Thanks for the discussion, and I hope to continue to work with all of you o=
n this,=0A=
Owen=
