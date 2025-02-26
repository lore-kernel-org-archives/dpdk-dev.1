Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFA9C021BF
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 13:55:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3005640616;
	Wed, 26 Feb 2025 14:55:48 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
 by mails.dpdk.org (Postfix) with ESMTP id 4AD854060B
 for <dev@dpdk.org>; Wed, 26 Feb 2025 14:55:46 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zzbh+UlSY/TITw8Q5jOdfJUSB4bDfJUB53FykvwMHQ08Mz8I+uHHQjKy95SK9ZDmr9nQk0EX6+jtxBuqmB1D7w0BgOAkKqE5A6Jpg8ZOMwdCti3c2qDF7wD/1ddJoR90AsbaRyx6RMPOwIo7bz2xo2ehTVbQbwbgZrkWrXHnxOn775b3lnUlxw5HqGULJjCy5joiYjNdu3DMOkZphxDkyqqyhmjMWCBfWp0FQGBVaUpycR7zMouOrSAcAd7nDMoDcPQ3zrBGnEEBcof2xefP/HxyNS/us7LjXJyNTk5wG+WmIaUNnvXHyNewwZGsFLN8E+LOB/kkv8R7ZB9XPNF7Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FV6TulyMutJKcoMuJO1Wencgc1F4U777wGk2z9MXJyI=;
 b=tVv+ipl609utbdgP0Vky2hrCyaAygpAnN/4TSXrDdU2VdFrJS93kbLKsiNG2Uhj71Y67XvILYOVnVu3VR9wkftZT+K2pWT2kIxIYeYoOS4W/PmLm1wZ31dzlmuwne8DmiEbC6pqxn65/2OYwIlA39CW8h8yrkR4BejtNshdbMqOuMrKFpzzjT+MohrQdlvdJScsD0pgk4KhlWX79pTzxZY6Ac6qPU7KvUwjrwUDLSUfDk0fy1VEjQ13Tkds5QWnGYtHMwGoXTVpi7mIL9YWdH6lD3lPj7DiNWfs301d189igNo4OWj9Q3+EQeF4mqxCrCL7xarHuPJTgtXkl822jQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FV6TulyMutJKcoMuJO1Wencgc1F4U777wGk2z9MXJyI=;
 b=DWhm9GhPTJ609AUgQOBDrqpNcBHXoZB3ngf1vrdtG1lVyjujtfTJ/22w86Z2bW877bz6KfoWWGhtCeW+9N/86b58pwmiIhwfbapQPAfdBl4xvl9eGQEVerye5jzbUmMM7MVpBzDRQQHFzROn3vngN/h23WGE9/taCJR1cbcl5mVGrw1exXdYgdMW59P7wTh6beBEzDIbhngiUF/kVVEQ+/hP49VwG1XqOjReSnmpAdZOnJXhBj/jDhRX+zrfsEqTqIl3P+H+4LRcTO5C0EvY3HE5Hm4XQlI3JDiIHi/TrDMNzcmo7LTF8OGRGoqbuKAvWyoTI6Dwugb88GTUlegIWw==
Received: from CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15)
 by MN0PR12MB6126.namprd12.prod.outlook.com (2603:10b6:208:3c6::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Wed, 26 Feb
 2025 13:55:44 +0000
Received: from CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5]) by CH3PR12MB8460.namprd12.prod.outlook.com
 ([fe80::2e9d:7265:3b84:59b5%7]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 13:55:43 +0000
From: Raslan Darawsheh <rasland@nvidia.com>
To: Gregory Etelson <getelson@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Maayan Kashani <mkashani@nvidia.com>
Subject: Re: [PATCH] net/mlx5: support ESP in non-template RSS expansion
Thread-Topic: [PATCH] net/mlx5: support ESP in non-template RSS expansion
Thread-Index: AQHbgQt+piw+aNNlXkutf10bxZQtGLNZqhkY
Date: Wed, 26 Feb 2025 13:55:43 +0000
Message-ID: <CH3PR12MB84601B1C1A2E85C7E7A53036CFC22@CH3PR12MB8460.namprd12.prod.outlook.com>
References: <20250217071316.37195-1-getelson@nvidia.com>
In-Reply-To: <20250217071316.37195-1-getelson@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8460:EE_|MN0PR12MB6126:EE_
x-ms-office365-filtering-correlation-id: 79a35621-1ecf-454c-105c-08dd566d436b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?JZetCxuy6TwDIs6jer0SoEy4wCN0l0w0oWS+v+Tazyy0NTmstRY1PBvNOa?=
 =?iso-8859-1?Q?C8Dt1wJBo1cbrPAiqWkNXneleJthxRbdprtQIqp0dQaGZTPPdjunCWdD7F?=
 =?iso-8859-1?Q?dcal8kDlcKmlIC6qv6lrfD2MVnraYNGPWFp6VqbLDnnirrGdQH6aOf2vex?=
 =?iso-8859-1?Q?nQXnhdpuFGJg58GX/h3DQ/Yio6DFnYKFfcSYln3jWOas16sbmAOMhueyzU?=
 =?iso-8859-1?Q?nMxrpXSlTvvEmH/eZGU5u+q25xzA1+kZ1g4VDU4T5W3VWggqo+eBpfC5JJ?=
 =?iso-8859-1?Q?e77txLuwRIwotfVeFn2ITNGB+31Am/ZxXsBkw6XdpoS/nH8nLpnrVWGIOc?=
 =?iso-8859-1?Q?h60COM9TMBf5jQ5xbHMDOyTF+Vm7b+TBW/z2MQPEhmZcv+AZXm2xsi0gbq?=
 =?iso-8859-1?Q?f5AvMFm/aCZJWQL3nETfTtrUylhp8FQCmIhCpba+rOYetkZtSXkWFDo4jT?=
 =?iso-8859-1?Q?2eStqQMQle04qqivD+3qQKiprZfIPk6ldJi0eN90HeOD354mpFM8x+xZa3?=
 =?iso-8859-1?Q?EDPA81bZh6umPaW5Y3+ww20IoGn6SQ9+cI/6LAzUMW3rgZyGd2kyEaQaaE?=
 =?iso-8859-1?Q?6vEjjXs3WDbEr9WVQc/BHZNWp2PpJmBsIDL4wgYb7weGrQ17iEgp+B7A98?=
 =?iso-8859-1?Q?blaiS6jCy58zxXSFmYvbyQuWRsbXrHzHQrc/G+6VM6EVzZEkHioAdrs/5e?=
 =?iso-8859-1?Q?jj4X9ehw7DHW9Yn4n31PS+kr6cYIYMAl4Ee1rLs0PzmBYtdHwbPtedLIok?=
 =?iso-8859-1?Q?7yUCwz7zBkjbkQraXe1hG8QhsnAcS1VoYw6Md3x3VvFeo8UhTcui8EV1nV?=
 =?iso-8859-1?Q?qEocNkNi7PNG5SNn0Zb5cOScFotuo+fRrj0QwV1USXzsjSY0KRw8f8H6BE?=
 =?iso-8859-1?Q?BU5vF4psDs3I83A2t5kXsoL/3EoQg6YbCLvut8lxn0O/2wUze7jGAF1Im6?=
 =?iso-8859-1?Q?WbJdUxs+so3GFs0jZ266v1DBw2CT5iTn0xsvSJXNoi3i4pNwoG2DiQl2Jl?=
 =?iso-8859-1?Q?Lh1Wr2Fj1SWH4MAE5DdQqno+93to0kFXYNutBYRnk+SjniTpivesS/XPha?=
 =?iso-8859-1?Q?YR+V1Sxd4uqT3B5QqfiTcrldGd/6NS8vIn5pc7Yk1KtNC71erj1g7Gg+bE?=
 =?iso-8859-1?Q?yBA+NuPYRkmAXRe7KiOuxOfIoREqDTQIMP/wkz/1nofj2lL1QhYIFsRY6S?=
 =?iso-8859-1?Q?Ae0o936Eh4cHwD74roc2hP/9CnlI0S8kxxrijpVx1o4bB45A5ZihFS4hYY?=
 =?iso-8859-1?Q?WU1apa4U6EXBqhlYO2Lo8IPhiOQnd3K/YAdBswuaxedegnOhveSEI4VxVU?=
 =?iso-8859-1?Q?zKfCh3Fczj2+1OZ5BKdJ0wl6EM1TcXdLE/51y38s9UlyAS6EQVe3p5CXMn?=
 =?iso-8859-1?Q?CLXG0TGmwIIfX09eeCOdrvPAA/Fj5NBFAKeC4S5hvwq6B7Vto29N4kNdE8?=
 =?iso-8859-1?Q?R+jbfU82GObRL1cbR8OGGZTsqlGH7K4BOMPjLOljT6eTPcsnO6UIZpCfdh?=
 =?iso-8859-1?Q?tdXpM6koUoZvLSxOG5VVNS?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8460.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?HWMSDV4o/iq8kxfOPtZBXiOQ10TPHGvD4D2b+EBQzytAvbKqJq0PmJV2ng?=
 =?iso-8859-1?Q?X6R1Iqi1neSBszQoMZlNjj/Oe+R26TNiyyYqKxwoE66vOMPgmf+41Rfu3t?=
 =?iso-8859-1?Q?1miJQ9IW4g6/d91tDq5QcgGRmFgy00t2PqolRytaxM8KHH03SJ6U6eMKsd?=
 =?iso-8859-1?Q?SzjOPU96PSQx80SZofTZqeJqEoojNw/dG/yRExqFFPMzZOZOni9ZveGlfX?=
 =?iso-8859-1?Q?cCtREc0LbEgMATKsVBtqq1DVIgp12JNOnFuEgcLCJjtgDezD/wxYhL4k9X?=
 =?iso-8859-1?Q?Xp3T11LahwnbDsp56KkuThSm1SapcQgSOxwQq2C3Bf0um/731ZCH1vqh3w?=
 =?iso-8859-1?Q?JHl1NK7h3KgWShfzbE8+ovPzNuo2nOFliuMuYPvTKOaqrgoDuYUxjezEX9?=
 =?iso-8859-1?Q?1WYg15wy8dXdLbbfeLwMJJP8/VGPx5TnlviV9XNe0tsLbYNGkQwIM4NRSO?=
 =?iso-8859-1?Q?vsMX51BUL+jwlSi9BuoFwxHJb3zfn0FFccdVtFpofsN6huwjGQCe4+S/H2?=
 =?iso-8859-1?Q?KsD7Pb9GJ0cHok6kZRE19KQ92d/Dy0ZOHbu5MraTKw72sLa66rSCVgFwDQ?=
 =?iso-8859-1?Q?7WOtoxLZdGHiP3DzhU+WVQLRvgk4bQeBe77XiKyDIsXUPQeZsOnTKPYXa8?=
 =?iso-8859-1?Q?grKEmmT/CUfKJAavF16LDupiaUEZC0OFQr+ytkPb/eaavz1n0XXJ5mkAW5?=
 =?iso-8859-1?Q?MPwTZg3otFslUjsH81vESVtt+idtAfADhWjinmERksICPDuHzG/vcGuZpG?=
 =?iso-8859-1?Q?woETpCLGcglyOtfBhwhNXIKpZB3OYH3GQ18j/Odvbid4ubkXoQupDWyMb/?=
 =?iso-8859-1?Q?KefRnX2yg0VE6ht0XbcrhRslbSFf2XwilT2pC61o+KCSjrGL8OnO8Xle+5?=
 =?iso-8859-1?Q?ocelwz6VJP2NXFxdc9KStMxr0d9QIGXWM1Yab+8HZC5q5MNEdKN0NW4W01?=
 =?iso-8859-1?Q?+ndHf1CBJLFlMHcq8oQ7ydHyllq9pg4KSF3HtRCZXng/rK6zCJX4rqbel7?=
 =?iso-8859-1?Q?cRtRKyQ/vwedu3abghwdeDrexHlODyMkMWE11gzdRzXSflOu/LswG4oCWR?=
 =?iso-8859-1?Q?ym0zKTkeqkSepx3DVGDsYTIsRA/bNHusypQoRj+b5+5cS4KNsFrxKcqDLv?=
 =?iso-8859-1?Q?GMIzkfoGLiCWxtZTwjQaTr55eO95MRE86IpR4OUZxTM3sOtYEV1G6wh/gp?=
 =?iso-8859-1?Q?VxyLmCl97a/4xq+u6wWEni3mrqFljrTlSmEb63lAl/4FXPIYw8ySO1grca?=
 =?iso-8859-1?Q?HXWJnofJmLnYx+MbyioLF3yIk1ign5MBo+C5COUKT5YL4CkX/FxBTLs5uJ?=
 =?iso-8859-1?Q?PGi+h92YJ3+ijrOI47yCFWBewaDM+WTJxv61Q3RKFPw/I9R/uO8Ix8aoMO?=
 =?iso-8859-1?Q?WlitmIOY/tMXFguT8JZQQysEAcy9RdXwWbRRBKeMzgUwLKUvY5jvOMJTmz?=
 =?iso-8859-1?Q?dNfFnUJ926wOiCKUOZSaYu1jB+8ITeKbQy1tkIVitezM1A80UZ5VRhlszI?=
 =?iso-8859-1?Q?5joZ1+vjKPyGMKEWGZXIQue7T1+FylFutUnOatBzwnQs8x+hqCaCLEyEhq?=
 =?iso-8859-1?Q?/c9fFzvdWtWsC+2kqykYNJ/669k9LYa/m8dT5H51K9OArAWjCje1ws5t/b?=
 =?iso-8859-1?Q?SzE8oYnmVIS32NLY/ifEq5PG9foiBr65Eh?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79a35621-1ecf-454c-105c-08dd566d436b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 13:55:43.8614 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e3waP43IH2x8F1zusF9O9EpYbMnRA1v1DpYTX4mdbuROiKRmMX4cqNykgwgiomwUkGIcdNm8PJqkVZBWcTuj6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6126
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
From: Gregory Etelson <getelson@nvidia.com>=0A=
Sent: Monday, February 17, 2025 9:13 AM=0A=
To: dev@dpdk.org=0A=
Cc: Gregory Etelson; Maayan Kashani; Raslan Darawsheh=0A=
Subject: [PATCH] net/mlx5: support ESP in non-template RSS expansion=0A=
=0A=
Add support for the ESP protocol in non-template RSS expansion.=0A=
=0A=
Signed-off-by: Gregory Etelson <getelson@nvidia.com>=0A=
=0A=
=0A=
Patch applied to next-net-mlx,=0A=
=0A=
Kindest regards,=0A=
Raslan Darawsheh=0A=
