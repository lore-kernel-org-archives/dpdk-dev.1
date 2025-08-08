Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC40FC87FD3
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 Aug 2025 03:44:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0BC0840270;
	Fri,  8 Aug 2025 05:44:45 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
 by mails.dpdk.org (Postfix) with ESMTP id 520D940150;
 Fri,  8 Aug 2025 05:44:43 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R+t9L9KVgmtG/f8YRy92SYL4nVRQj4a9+vvpGxThSyu7v1GZdGrJyuVfU8GVacJ5sWH61cNy0IOdv83lzMGBq9I0EfQasMPDUXA4wPv87FITBovg1aQNbEGHJ0IuHJj4VIq2WuqnyppLsoLztGSPr2Wk6Vuuh48KnVknHRRQI7COz/DM3sWejU3wl0ryfCR/TrQk8eMymKHJ/JHFwh4aDzwSmF4EEAgfU4Qx79CaS3A/0RfoeVyy+o+f96XugmDdiaze5U/JuydORhyVkCUlMVZguyOOW9sFdQmf66GqqnUyXga/7Ek+SE2DdS3X2kGeXcW/6M+yJfEcQWMP71fpvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4wo1hUknl4uGFSu7nJpy8uJSmUhIDRB68LOFRoN9sEM=;
 b=iouZvwtNjnrp+/JXh85UJ6s0Xm7x6IXSriOYQr1QnW4fHwQ18M2mqQsEhoM2s0bztylFS3NUSbwaqCPCA8fUHgGELTphuuy0Ygf7Lsr2PP803H2y4o2PKhju6XXw8uu3V4npcdllagmo0vwo23uS08zJ8S/3hFJ7c2GeGKNoYZzFPhlIHVKbOhq6VWq+WsKHKEibxbOZxAMtcRI8pPeAWwMPFw/MHj3NS/L5aG0B+22qlAJEkuYPkBraoyAM7lIxxXy/iYa/cu/6zOMrRYqVrbFlKDJF4IdsLuXofN73B2YmekntswFtn4EApjIWIMV4orpt6lq67wDbyB4OWwmtPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4wo1hUknl4uGFSu7nJpy8uJSmUhIDRB68LOFRoN9sEM=;
 b=40lh+4FRntDlo52aFV+Xoiw1MrnjA2UPMSokBEW4Xrt9C9C2IUrnHelFEsVV5Z3Gi3qrMBq8D802msKNw9I6eFfkBVo9VWaN9LUpFX2Fwtic8W5udX95Ry89cvVbcy9/6lI7luCxfsAQrUe7DtfKek4i5Suw3g34ilEastvYz8w=
Received: from PH7PR12MB8596.namprd12.prod.outlook.com (2603:10b6:510:1b7::6)
 by SA5PPFE3F7EF2AE.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8e6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Fri, 8 Aug
 2025 03:44:41 +0000
Received: from PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069]) by PH7PR12MB8596.namprd12.prod.outlook.com
 ([fe80::a011:943d:7291:8069%2]) with mapi id 15.20.9009.013; Fri, 8 Aug 2025
 03:44:40 +0000
From: "Varghese, Vipin" <Vipin.Varghese@amd.com>
To: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>,
 "thomas@monjalon.net" <thomas@monjalon.net>, "Yigit, Ferruh"
 <Ferruh.Yigit@amd.com>, "andrew.rybchenko@oktetlabs.ru"
 <andrew.rybchenko@oktetlabs.ru>
CC: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>
Subject: RE: [PATCH] [PATCH v5] app/testpmd: fix segfault in secondary process
 by monitoring primary
Thread-Topic: [PATCH] [PATCH v5] app/testpmd: fix segfault in secondary
 process by monitoring primary
Thread-Index: AQHcAFOh0w4kQAEhk0S0elww42p95LRJpHsAgAB/NYCADgiKMA==
Date: Fri, 8 Aug 2025 03:44:40 +0000
Message-ID: <PH7PR12MB8596F632CAD6508EA7EAB843822FA@PH7PR12MB8596.namprd12.prod.outlook.com>
References: <20250729144850.2392840f@hermes.local>
 <20250730052412.78178-1-14pwcse1224@uetpeshawar.edu.pk>
In-Reply-To: <20250730052412.78178-1-14pwcse1224@uetpeshawar.edu.pk>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-08T03:42:19.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8596:EE_|SA5PPFE3F7EF2AE:EE_
x-ms-office365-filtering-correlation-id: 1abb4cc6-9670-4f5f-7bd3-08ddd62de7e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?FQJVa5I5yfcpuqgq2D2UvKxPBnAYjxsM9I2Hxuw+gW7ElVlTPcRaveCgfJ?=
 =?iso-8859-1?Q?HCvWugGKXg3k0eJzp4EdSDeuwvY9a8elJSJZ4FsEX/2xoDjuAx3xCAE/Br?=
 =?iso-8859-1?Q?fU77m9VhK995ESyr4UHtJ9O/zWW2wPkJWK8vwKKk3ggBD37NQljeVazMww?=
 =?iso-8859-1?Q?I5JqmOohfFez3NthlP4wcdiOlIVjaJ9hYg3DfKWMwRpxiOb6SGO5h4eiKf?=
 =?iso-8859-1?Q?al6hy1oNkNAi098OupkeceAqWctGeYjCejt+RxJV2QREkwRk1gLENDlj7f?=
 =?iso-8859-1?Q?qDahOAZ7MTpqDlOLjktHEHsBbm+CYrcL+ElFhKCN2yqmeGTXdQEKsu5jRO?=
 =?iso-8859-1?Q?9fiCWb+Gu2RVWGCy5Y9Cz+6KwOCT8owxaLx1s5IqradJF5IEuhmSeTTYcU?=
 =?iso-8859-1?Q?itXHAg2jvBv5r/XeHWq2uuhW9rP64g9y44XzCiop/I6+UjGTFQvGJ+Ik3m?=
 =?iso-8859-1?Q?YbxmBfuPnuazuNswP7aAsGEFshvtjjSCEiCwWcFye8C3V/qdLdCLOOJ3Hx?=
 =?iso-8859-1?Q?17j07ir/qjymnKk4xFrwQM81vtk6TdcbO3pQZ3HUOS5twGk7ldmij6tiPL?=
 =?iso-8859-1?Q?c2eXMjnGcNPSLbcewklSAvjGGsjhpNwC19fiLCNlv8KySzG3RN4JDXYPyO?=
 =?iso-8859-1?Q?OCUVOylp3gxNQYjnQc85Et4m5CD8/Izrf3xA95MqnEr3qPLYwMq0ztkDNR?=
 =?iso-8859-1?Q?aJsHI9tc7/QzcpOeOn1JGrfAY7Mn79R7V8zM6CEmtcb7ji9TvqRnq+ew89?=
 =?iso-8859-1?Q?7votMD5u4tEjPRxUFGYnrYs08UnY5sGBTuP35hycGtkoPD2nVelG1NTum9?=
 =?iso-8859-1?Q?B0N9YBdyNtthMSw+Y/PWPpctWK2JtV/H0ZnACDNVGkCiY+U6//NGu3Vkch?=
 =?iso-8859-1?Q?UHOixiwSpYB/VznMVvAkim3LW30zcuRf2S/UqlEww5EZKwRw51Gri68dY3?=
 =?iso-8859-1?Q?fbi3BRNusaeZH8det1uI4QJTltoQT7Ez3G0trlqPC95+j62r0rzj96prOB?=
 =?iso-8859-1?Q?Eix05OESnFgYs0caFeYuYEfdcU/Io7rWo/fkYBRqbS5c/zdTEjx/nadkLE?=
 =?iso-8859-1?Q?8oCrhqv8/Hj8dYJZlVEQzDBAnP/MhDUw93V0gk7vQ63bWT/VHuHl9AAcwW?=
 =?iso-8859-1?Q?0gFEv/UJUlf2WZ7Xu2raIrRnOTv0dVikfoshq8MwIiiKqskxiSb8GRROYb?=
 =?iso-8859-1?Q?sdymK/in4+3+VBPXl7DByvRYi3yhYJia95XuhYLrkEIG9qQrbxTkMuNua/?=
 =?iso-8859-1?Q?V2Ri1JQtWSju/nRJbTjsxJ49R43FX7Yi3lsXR7U2VZXj9MQNiOWDRaaFw0?=
 =?iso-8859-1?Q?Iy9sSNh+bqVvtwjBK/2IB7C9I+Z5FjXZchKe+Zd1JQph08Ka3Tw1xElN+n?=
 =?iso-8859-1?Q?3JvYA4dzyF20ZylbqYPNnai04zzRrPYeaeJEiwZZalA0XG5wNZXo9iT7c4?=
 =?iso-8859-1?Q?NkXLvIWSf4CYhTNBCGw/xnXfSjtlC0kJz2ZM6WuEtv9u98hg23SYW1leyU?=
 =?iso-8859-1?Q?aMrPQ2ftjTjoZE4Nd96QsnHVu+YFsVNGVD/8a2sUdJJLwASuhtDPhE/7gO?=
 =?iso-8859-1?Q?uMGJP3Q=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?x0KWfwFGEE+pi3ZLwK78xsEt3NX+3+phykiAL5sm6UXY2z4v0pRsNaHaP8?=
 =?iso-8859-1?Q?pEenR+6XuaYgxBV9DBJpf2exGNshEVXbN9Y+OIHVIBrwwuufb319+qWiwd?=
 =?iso-8859-1?Q?UB/zX54IExQQCMpcTYRzmD9AH0z5VWyz2/a/bGC3QLiRtFp4UI4GjeNB1D?=
 =?iso-8859-1?Q?2P+UlAuPqOx+xeuyy+zrdewRAOub1Si3TGgnJsRpW7lxZEZ4XcOe/IozTV?=
 =?iso-8859-1?Q?76DZFyx03M9Gx1Eg1FiApl/keRE3KV2nR5gxDiijo6zv5KbzbH0f1v+rue?=
 =?iso-8859-1?Q?W6PvjbQnccSQNOhVaex2HdNOjyfRqBEKFCMzs0zIZoO+ZalLWPOrj28HVV?=
 =?iso-8859-1?Q?7BvIpaFXqleybB62rRWqxDILB3736w1KbYLNmFTmFaXzNS9wcBL3R7rYmI?=
 =?iso-8859-1?Q?ddYsRuGs6j8KOiU3XDXZ+IVw1G7eJRamjKu0KMzqFXEAR2Wzc+zBp0Clru?=
 =?iso-8859-1?Q?3yOWZfrV8FRUwomR8sp7P9Ghc9FcW0YzsJwReOdVia1aX61KX8eaKAlptQ?=
 =?iso-8859-1?Q?E+fx1T0j+yBOSGEbPrZY2V1NCR2T0TqyhlPLpMYYSj0UdZm7h43A8/Z/HG?=
 =?iso-8859-1?Q?4hNXrL33q3X24PnYiVazi0H7rkUg0BgofEzEd7CbM12uPY6MQZRb9bCGXj?=
 =?iso-8859-1?Q?iPpVQ7sQyu3MmfsLsBg0AQj8IeLc7fSItan6O1veRdMgoWoqJuRoR2s/JG?=
 =?iso-8859-1?Q?99MX29GKvW8OWBa/39rLC1aWgEawyjE6KHUOmhN1LU115BTsZ+F7b8J7Ix?=
 =?iso-8859-1?Q?3AOgy941RNhd3eaGuC8fFICYoMsgqZyMOU2RUK7e2SjTmDmnwSIN5UhR8Q?=
 =?iso-8859-1?Q?nOqjjPcqiOvfWF13aP/1M/J/OV3qRPg/VyrKX3BnRfSy+Rgp3JAGU7ednq?=
 =?iso-8859-1?Q?Mx2bQCrpUfPpNFWIrzg9ZbKlQ5fRTOgEaQQ6yUGZ5Wld8VNJQHmrt5zSuZ?=
 =?iso-8859-1?Q?NDu5Xh1Gq0v/NB+6SODlVuWJqVOkJOai0aKbS+D9QmSlkqlCXV+0UKAkxm?=
 =?iso-8859-1?Q?L0T0EuCXoyrDQgxIs58ibG6QBfQpk4ci0NxUBCa+mhxbm3binaKAPZn3Tl?=
 =?iso-8859-1?Q?HtKI8L5qPHZkT40H70nbLliZXnuM7Z6BvtcAItOlBNka8pCcGyFP2eE8Dn?=
 =?iso-8859-1?Q?l5+fjKRmiW7TARe2ri1LSRggBl5dCpnBHgJDNJ6v3igniZXbF5OgZ2Z/y8?=
 =?iso-8859-1?Q?f+zucPnDIoJj1KKsrP4bfVYZ1iQDvQRZcNrtmDM4f+SAEaVkhbNCySegLO?=
 =?iso-8859-1?Q?7D9xdK0Lep7Ay1U9gIs+Y5g49iytkQdKi4uX08lXv5LuuHbzEQsJVpZFMR?=
 =?iso-8859-1?Q?mdeVvWyuMJLinUYL2SFUotdB1rmzemzd/AYdAxDnH910WlnZ/QiDLFnWDP?=
 =?iso-8859-1?Q?H4v69iM2xoXYZNSXESK6CFnoG2Fp2ceFb7EUoxej+ZQsvW/hIMjIXN4dDS?=
 =?iso-8859-1?Q?bUpOxg6kzT8Davp2nex6D4beEHV6ZJ2biVNjeQVjgnUXd4Y3wjyzIMtX1I?=
 =?iso-8859-1?Q?qx6PYt9/WSrrJTitRhZ4PkbVL4r9RnaKmqg9fFXET7bK2oQ+sTyAvuixX3?=
 =?iso-8859-1?Q?N+sSzC2rq2VDHS+n7smVUT6Q8q8duQHBaZYFS9DvdpheB1RyN+TPlRq1Au?=
 =?iso-8859-1?Q?40o2d57hSOxpumg9niVih1GCP9XNoZ9pP0?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1abb4cc6-9670-4f5f-7bd3-08ddd62de7e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2025 03:44:40.8101 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lgIH5ZibXON6vRmDdG195RAjNjyvHcDXxzkRgBBQRZysEgQfBt6FaXyD7JsHAHHjWOaANVvp7D1wS9GY/G6eqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFE3F7EF2AE
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

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Khadem,

Snipped

>
>
> Hi Stephen,
>
> Many thanks for the fix and for the suggestion that the secondary should =
exit
> immediately without attempting any cleanups once it detects the primary h=
as exited.

Can you please explain why cleanup of secondary resources are not to be don=
e, If there is specific memory like external hugepage backed mempool none o=
f the callback will be called. Also releasing internal stack memory and hea=
p of secondary is not cleaned.

Is there specific reason why you do not want to clean? If yes, can you plea=
se point to the right direction what is breaking?

>
> I completely agree. I=E2EUR(tm)ll supersede this patch with a new version=
 that
> incorporates both of our changes.
>
> Best regards,
> Khadem

