Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CD6C021B2
	for <dpdk-dev@archiver.kernel.org>; Sun, 23 Feb 2025 13:04:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E6CBD402E0;
	Sun, 23 Feb 2025 14:04:27 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
 by mails.dpdk.org (Postfix) with ESMTP id AB2B3402C1;
 Sun, 23 Feb 2025 14:04:22 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QJ9xarNXPjBE8nPLrUIrWa/pSyGyz7tZQqrO9GZTJ7medARyXGjOyAfA/daHCsUYTQLJJIWjF1wR6YvzkPMoFX6axwz8LJpwXWEm4LQiq5YUWY1T262z8hUNvlxSEOmlZfAPxOzXK2r5G3sz36v7y35ALU8fJuuteEv59DUiMdMPypkmzy+sIcFn0jLJR4E0mKdY2Wd57Drc3CHsAYPCiQoe0hhV7V8WJ5b2RwHzOquSv+4FwEbcObySvsLLLxJDlrLrVNhPtBg8S6+2nRGJrrYN5P43cOnkP5zIJ6A9WvTC8/AJaHs1rjZh+KF0UvVf+vpmXmnjDSYqzbEFTXKDvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5vRPyD5xbfj85sjD9QumcD8xhhZ+TXXORbW/uGIMu9Q=;
 b=Z0pCTWNvpvJbPske/g7suO/rcenROp0o1v/8BbS4QV+vLQOfTKpaQ/1T8MSbSfSh4spr+7ZdnZlAJtbye4scBxw0uqhC5TVLqjP1PI9e9NQyH2d0hVJj5OYk0PZxgQU0v+GeMqbLtDuXq4iEQ/7eaF6apueNlmvHOs5szQUhdkjl4aMdmI0eOuoAPZfxLGp4BtnWzNWwe5O9pj+dvfqGfcLZ5FTMW1mQaLqr2py/Kc04FPR+FuyBkOwa5ispCw9ZB7lEwaytMF3WQJ0A8tL22ErEnR3edcIS8HQl/TMV3DzBrDJkGjjP5unFlpCkF581Z/vbhRvYY+/VMQWUAW8o2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vRPyD5xbfj85sjD9QumcD8xhhZ+TXXORbW/uGIMu9Q=;
 b=L4q1zmEclkKpQldhzMqHKJYggLCt8Kx+8UWeCoQew8zWlsR9IYB4qKRHI2t4+XeQH5yFQl6r/PJWkFj7gxKhQrbq1aMdUKlXWu4AQYiI+u2VBX1UjaHk3I4WKpMIIp1HGZ2gSqx/pOWUD3GIaLZ2KEVOvaxf0myXQCAarphfJOgupdH4uDk687edJ5zcPi+l8KPN1RAIitp5C0Ongb6KoYUObnw+/m5QamM0GSFcf2cYs3ZrwREi/8FRSnjcumvwofgIS7GjcW5I19rxr4YlJpWUQJnd9efqfVdTrMiTE/Nt/KhpC2PUxZ1++jCFDrUQZLCxrPEONvNhuuV7F146Ig==
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by PH8PR12MB8432.namprd12.prod.outlook.com (2603:10b6:510:25b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Sun, 23 Feb
 2025 13:04:16 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%7]) with mapi id 15.20.8466.016; Sun, 23 Feb 2025
 13:04:16 +0000
From: Raslan Darawsheh <rasland@nvidia.com>
To: David Marchand <david.marchand@redhat.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>, Slava Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Jack Min
 <jackmin@nvidia.com>
Subject: Re: [PATCH] net/mlx5: fix leak in HWS flow counter action
Thread-Topic: [PATCH] net/mlx5: fix leak in HWS flow counter action
Thread-Index: AQHbcKnKPKjL9lilzkesfpmAwy2cPrNVBWMI
Date: Sun, 23 Feb 2025 13:04:16 +0000
Message-ID: <CH3PR12MB846071D4CB83E666AAC6D06ACFC12@CH3PR12MB8460.namprd12.prod.outlook.com>
References: <20250127105347.1077802-1-david.marchand@redhat.com>
In-Reply-To: <20250127105347.1077802-1-david.marchand@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8460:EE_|PH8PR12MB8432:EE_
x-ms-office365-filtering-correlation-id: b8323225-0e37-491e-3f38-08dd540a9426
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Vk2tg2lBddGBKjElUDVvsXnp9yRtBhdvT7hea4Pgq5hm133F227GCne9mX?=
 =?iso-8859-1?Q?voay20huDJ4cGYY8YIwDodDyUyiO21eCJlPzg84I3YvH5ftid44/JDbvxM?=
 =?iso-8859-1?Q?vYWmS0pYP/RzyRUiwUUoY+Y92p4zJ9VtAlkAz7GWasMhOqKEh37IqE1abI?=
 =?iso-8859-1?Q?ZhsWQzSdhHGTt85SWAmRdGuZ9WmV8TOVC/B48ebxbNtQauD8lWY1kyOgge?=
 =?iso-8859-1?Q?eBK6ijV1EJ96oQkZF/+mvQdbEWDiMKwDMeDDK/rgT6H5jB7oDSpTDGHlqX?=
 =?iso-8859-1?Q?rIMcrtQySHFS30IliieKGLK54APfRX5szBDRijnguTm+fUca+Q7plD1TOi?=
 =?iso-8859-1?Q?MWF4QxE3thd2saOaT8kE9fqx87H9E3ga6NVlrkXluEPh1zHup4dCQ/P2JL?=
 =?iso-8859-1?Q?P7t+MlTfqKH3Hnkxq0XD/CAfA8gZlsJmSMLD3dsWA/20bXLN8vrR+cAnXi?=
 =?iso-8859-1?Q?KuBqT63C/m8Fit16UoYVSqKvnSWhjcueSmMQO6iPzREVGqaIUnVtHRLs1+?=
 =?iso-8859-1?Q?M3FZ3YNPsPiNnc1f/WB6nVUuVA/JCZLgKzJu/f5+SJ/4D9pq772XFXhkbv?=
 =?iso-8859-1?Q?TN0TojG2z7B1QGzXs+UgGDaYUEbmhNNXTeNiwk83di0opGhgFLAQrDHZm8?=
 =?iso-8859-1?Q?yUp5+IJzLRHxQzHyqBWvcW0JivFFl0k6fTviefy3TOq8Xr0ihAKdrt/lNB?=
 =?iso-8859-1?Q?sfzddwH4ALgFMak6/L+ddP/oZrpUHvGgWKN6/Sm2Gl4uHrjupaA2n8VXjS?=
 =?iso-8859-1?Q?f3ROfjqyDkTNoisainiZcxWxt61EwNsudqPagrGKfHRatpXn4UEasvNcte?=
 =?iso-8859-1?Q?jX6WKVQhNUhK1IFMpa32weNSYYksuYNNik+jdCj18B2d/6SNZU1iPt9C6Z?=
 =?iso-8859-1?Q?umacV1zsqdvoGSxYk37dMEcp754PoFbbCH2pYgWo7w7UgN8wdATY/Ln6Js?=
 =?iso-8859-1?Q?UgPtmtzz2760xyml4zIdCZTyYld+immPdE57PAaLr5i1j7TFjgnn4h4bG6?=
 =?iso-8859-1?Q?K/ThdxfeWncVLlXq5QobmP0YsUTee3R/hohh/znhb1YZcxL0Aikix/0to7?=
 =?iso-8859-1?Q?infqzBDu7l9lGJwNaIIZZwuV8AjKVUHjQf5cnAa9caN3uS5m0PRuMfjDST?=
 =?iso-8859-1?Q?Rr1TE6znaqXFuULAOqzjVGHhLxa5FSDUT22luuDMPvE+RehiErRmuy7CGN?=
 =?iso-8859-1?Q?k6cGWFstCrKSfc3PrKeHeBR3Y9lLmIc2sw2cJ63jLDCGifu1maFCsiv4jR?=
 =?iso-8859-1?Q?HioTxOuaEiklCnqxG3JNHVH6rqLjpEZsfN2Cb9HCNrcrZTe1oeX2rCQNxF?=
 =?iso-8859-1?Q?QBJARHFurOGipBpLjJpzFzFnbtVr120pAvcjs6Riazhjx6r5vRjEHjM0UV?=
 =?iso-8859-1?Q?HfidtQW9cN4tFwrZAGKAD4aiUE6vJ/7Fo5cCu7GODf8Ftba5+cXHK9fgH2?=
 =?iso-8859-1?Q?/Hrl3my2UaKbS4OnR+9fYsOfZR6gpVTrN6pcPhGl43bDqu3ss55Iydu3Sg?=
 =?iso-8859-1?Q?Uz/YKcSS2ixV/vYmxb0GrT?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?uKosnZwjw23Nkv2eNV9u9wpfoz1oBeoIT58TZCKm2QiOx3SqrN5WPQUe5E?=
 =?iso-8859-1?Q?8VMLD/XTDAM5NSHJa4SiaRwUBb4QYvj0lWDSUVv7ditb14+dmAQ3g8+0Q8?=
 =?iso-8859-1?Q?lT1Gjm+b7gum4PeZOcLFD5ZE+r0R0+PM4d17vFVVJAdg96czhc0q5kRU3b?=
 =?iso-8859-1?Q?nIaJzXCU9yeOQ7EAN3xVPQQPTNqfqSeqlWq0c8c+U7GOVvpXPaD/sWPwmM?=
 =?iso-8859-1?Q?/JreEg4SEXviI6GBuIuz8SfKiR97Yy0uHWpmActwHmNet+BdwoVW0EcmFT?=
 =?iso-8859-1?Q?3pDQOZhi5PHrgFndSiiGd8J61H1EVNu9EjENwq0b9v3Gk4AVuskn22/kw6?=
 =?iso-8859-1?Q?8m0rf2GxYPCC5PXe2GeDkkIIdxOm9vKWfpzRv6c70fPcqlk/u8Blr2UjvQ?=
 =?iso-8859-1?Q?G8dfBuGfACWdlWJdNCa/VpsOeJuy6DUFW38qB9LPFCtw9MEWFjmHuh2OkZ?=
 =?iso-8859-1?Q?DkDXFmwZBPI53Y6TEYGWa19vBny+cfUc6pioIntzTVev2seDqOe+L7gTFw?=
 =?iso-8859-1?Q?wBW1aLZUOwZL+9GTNvtN5qHJ6Nk3QC+zk0Gzh6VuKX7rzyigrElZo7MBC+?=
 =?iso-8859-1?Q?J/+nBwy+2m9Hk7K/JZH9gTfrDlsb4xQUBQBJs/LL8UOMrFVFtCYbB/1hGX?=
 =?iso-8859-1?Q?vJakg3ewVEc85i9e4U8pZIyZkbxWRpHFSOoNfjDaUilvwKTSH+sCG+Cd0r?=
 =?iso-8859-1?Q?sioHm48MwbHhw8KHQzc1StN27Kx+91EJ6QJedxhLMYwZlJnLX/hc68foRA?=
 =?iso-8859-1?Q?Uu6/ARA0g7+yY70mYGIQyWfUnjo87x1hQswaFBLEpIOKwqP0F3z7aUMmfm?=
 =?iso-8859-1?Q?Y8iRaW8b0EQz0UoUt3CryrtcJJEoV9ZBNuONG/FQyBDjvp5b2bZ3JVESJw?=
 =?iso-8859-1?Q?YSDnOYvThvch9YlHBSLmSVY9OoksjKfAyzy96wjOFmRjz6nTD2z+Yfz9Xv?=
 =?iso-8859-1?Q?7JsN18x/4SbbZlZW1PqJsWyI81NiilFbtBZkXXeG6i8oFT2n0OTCRShlnu?=
 =?iso-8859-1?Q?UBYX6x69exnwWUWUJNDhW9oqhntp4kFIddrOsrjp23dVN07J0Baee3ljFz?=
 =?iso-8859-1?Q?i2Se0QQHuPqTjJLgQgbaIQZ7u0T2DzIuAJrOkMRgvI2vZ/M5jcFcE+SgI3?=
 =?iso-8859-1?Q?6hesL2exwjuv7675mEgXSpbvjk9pus/KPG6Ja0+rEqRxUo/8PYVH7qTkxi?=
 =?iso-8859-1?Q?kGpqwg8jvNe/bJO97Fq0uAVna7WMJoZEBIoyDhH11Aoi5t2h2ndRI0IQmd?=
 =?iso-8859-1?Q?kS3axTtK02afJiS9sERsTJTtyxg84z9P0T4zV/a+yi8SM55xUXt9kxvYUI?=
 =?iso-8859-1?Q?pGo8WaZ6TmduS5CpWtTh0AAICj4yvLvKtLzw4B7cjGzzwqCB1dDmxFsK+W?=
 =?iso-8859-1?Q?/+TzcTS6I08y8TjF1Gsu2f6WmELjx4mrLJPgjECINyBKK4bXdEAo9Flp4L?=
 =?iso-8859-1?Q?hzve77+0GoMu9C3XvSYzKfivwmSn89XaqvXtlSlJHoXTHUVAtsO+GmAFOX?=
 =?iso-8859-1?Q?QJMp5Er6pN5W1wQxHfSmumz7JqYhyrJZxtD0NHESMMajCOKwpKfvqN7UIF?=
 =?iso-8859-1?Q?3I7/rxUG5MyUvrXtC9B1cA7cUelKoGXw7u30L778QWGAyLQuPxK9EenTL5?=
 =?iso-8859-1?Q?boLQ1MThItf18=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8323225-0e37-491e-3f38-08dd540a9426
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2025 13:04:16.7804 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jM+IVYQnW/xkwmDA4wgcwUoAX17jjZ7Q2H9R/A/N5qIq94EXEYgtvRWVKZWmjgX9FnKBJcRt0BFxDYNs8O6vbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8432
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

Hi,=0A=
=0A=
From: David Marchand <david.marchand@redhat.com>=0A=
Sent: Monday, January 27, 2025 12:53 PM=0A=
To: dev@dpdk.org=0A=
Cc: stable@dpdk.org; Dariusz Sosnowski; Slava Ovsiienko; Bing Zhao; Ori Kam=
; Suanming Mou; Matan Azrad; Jack Min=0A=
Subject: [PATCH] net/mlx5: fix leak in HWS flow counter action=0A=
=0A=
This was caught by our internal covscan.=0A=
mp_name can be leaked in case of errors.=0A=
=0A=
Fixes: 4d368e1da3a4 ("net/mlx5: support flow counter action for HWS")=0A=
Cc: stable@dpdk.org=0A=
=0A=
Signed-off-by: David Marchand <david.marchand@redhat.com>=0A=
=0A=
Patch applied to next-net-mlx,=0A=
=0A=
Kindest regards,=0A=
Raslan Darawsheh=0A=
=0A=
