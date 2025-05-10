Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323A5C3ABC9
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 May 2025 16:06:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1405F40270;
	Sat, 10 May 2025 18:06:03 +0200 (CEST)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2138.outbound.protection.outlook.com [40.107.95.138])
 by mails.dpdk.org (Postfix) with ESMTP id BCB9D4026C
 for <dev@dpdk.org>; Sat, 10 May 2025 18:06:00 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F9EwBSQwWaWmPn/xP6EOFtPcGmP2ZmkMW4nIzYIqNdDa5zFfkEo6HhaFKAykocZ7WpqqdqaygKdozr/ca223tTIfVJP/46YYJ4gPBAibWif+knd7e3ONzFKdNhEUtPyOPUlsBXcxyUmPIphzT96VhXvWOAF7/WNa0DPUGgN6xQCV8NIz4QOH/OG/6+DWLSt8IUgVYWWJx7ARgOELyRSG9+aWEubwu59oz+fewvt9YmbNNE+1my32m4ezKidK948DyK+4RXBpbuEqUYUwDSS1N++/ZKStQ7ZjJDOf1cyDeJn1/k768Xfqu+JFkl38E8pcHu+DsejvrxNQtEK+rlgcvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yoNdEaoATQB30c5mV2J6n6kK9ZWPK/ofY7ynjuYQqWQ=;
 b=nmVi0b/1HF8wtIPO/hA2wcqdWA0AzmIJ2IYtV17e+hTICk17/WLRbr/qh/3RAXwwJuD4mWuifHU2GpQdi8KXJOXJr7aQaxjvBuy62D6CIXBf8CRZPK6KJRGhUY6dDP8m0TnT6y2tJQ3Z+i/NO0Bj8D/pYQQrVbiKa+uA9MoWEV1Uww/Kt6SRb9SZ9oM0XCInDi4HwH9+oh+fxIf2Lpfg4kgj2KhqZJfXysZ9AiV7Ym+cSvj21vg+59/qiwVuZmw2dxEp4Ip38Yd5G7lTsSkeVFu9Jg+G77li/WfgJonkudDUSLBu8R9RGE0gsJiVRAwrAuqQvUjOjj4aZ2iw1nGzCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=unh.edu; dmarc=pass action=none header.from=unh.edu; dkim=pass
 header.d=unh.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unh.edu; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yoNdEaoATQB30c5mV2J6n6kK9ZWPK/ofY7ynjuYQqWQ=;
 b=ph5Kqq+27ncBdRRn1tRDrKZiCIogfc4Jl+pjWEOE2BfzPEG/H2uQwfLigGw43Q9zs7oyMk2yWCfPAf6gGRL3dOTdVgiR/QE7uipfRWnTpp6Pu94rwsvcPZdy9vzf0sdMB+9sx98oXBMTJTpZwsJ3SO1kAwDw588w+uSQDcoKKeI=
Received: from DM8P223MB0383.NAMP223.PROD.OUTLOOK.COM (2603:10b6:8:b::9) by
 LV3P223MB0846.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:1e1::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.21; Sat, 10 May 2025 16:05:57 +0000
Received: from DM8P223MB0383.NAMP223.PROD.OUTLOOK.COM
 ([fe80::e52:6031:810f:a743]) by DM8P223MB0383.NAMP223.PROD.OUTLOOK.COM
 ([fe80::e52:6031:810f:a743%3]) with mapi id 15.20.8722.027; Sat, 10 May 2025
 16:05:56 +0000
From: Owen Hilyard <Owen.Hilyard@unh.edu>
To: "Van Haaren, Harry" <harry.van.haaren@intel.com>, "Etelson, Gregory"
 <getelson@nvidia.com>, "Richardson, Bruce" <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH] rust: RFC/demo of safe API for Dpdk Eal, Eth and Rxq
Thread-Topic: [PATCH] rust: RFC/demo of safe API for Dpdk Eal, Eth and Rxq
Thread-Index: AQHbr6r0sqE17AHXak+XC2nGaMcQ/LOoNgYAgAEX6wCAAvcwAIAGwTaAgATktQCABLEMgIAA3kCAgAHmrICAABRGAIAAP/9tgAY2ToCAA2DxcYABUdkAgAF6Y00=
Date: Sat, 10 May 2025 16:05:56 +0000
Message-ID: <DM8P223MB038385F61173ED438E5066638D95A@DM8P223MB0383.NAMP223.PROD.OUTLOOK.COM>
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
 <DM8P223MB038399660EAB15CCEC365A868D8BA@DM8P223MB0383.NAMP223.PROD.OUTLOOK.COM>
 <PH8PR11MB6803FD2723BE0ECE7DBB44C8D78AA@PH8PR11MB6803.namprd11.prod.outlook.com>
In-Reply-To: <PH8PR11MB6803FD2723BE0ECE7DBB44C8D78AA@PH8PR11MB6803.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=unh.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8P223MB0383:EE_|LV3P223MB0846:EE_
x-ms-office365-filtering-correlation-id: 795722ba-43b3-44e5-f186-08dd8fdc8c67
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?windows-1256?Q?Lbu2OiW+Hzk42ur7hGie928/qzG50O0dWV1f/H1Ak7YqHxM+2OV0vkBQ?=
 =?windows-1256?Q?J0tr4Dbf4udhTwhcAGx918+ot5KoYWSMYCzC4BorwotkvYWUWVLV+l1K?=
 =?windows-1256?Q?HHgZ7thmQk6nGeSrjpIVcp6MbCnz6vdlJU4GPE3mfr7wOfh+/Zt7Ao8k?=
 =?windows-1256?Q?yMnQ9M4w7hghKS6cogWaCPeWnNwR+T2l43lPA/Im2XLqK7RdFLxaOvrk?=
 =?windows-1256?Q?vnO92nCmWMs6ZnGZhvC8qGIV5LUYqMUX3n3S5cFeRp+1eWR+D0vofRdk?=
 =?windows-1256?Q?5UuZJ/wT2JXvlp6ZSu28PAY1wDUTvAhJdQddk2X+r2KbOEwnbXFTGBlU?=
 =?windows-1256?Q?hZbaOuIacEjtXFXYa0GZPUn6L3veHIB9RgtQL7QXUPyM0y0HzrNXyXfh?=
 =?windows-1256?Q?LkMLoYuYpV0blWiUmyrErvwKmuF3FyNkrGxbjhpin7oS7bi1LUBZuBbs?=
 =?windows-1256?Q?30xstUSNeiBMWDNq6pD77bsews7xIWqAIH8v4RbQ5gc1yvRJs0c0WhuO?=
 =?windows-1256?Q?XUjiBbBY0qj8yGB7OZ0twYMaP+xbZWXTChYAnPfy/tk1x+HGKjJ1V3Ym?=
 =?windows-1256?Q?nvoH9Byy0qubHp9Yp0+ieJ1SS2GSXmb0a1Wp6FUYl19dDCQwg+Uxj4aT?=
 =?windows-1256?Q?ePX7f8/bzFw85zmj0Whvi5EgUS2uGUw6dr5ltcdZC3Xl7Q6yE/umzIyn?=
 =?windows-1256?Q?ltFpU7mGzDCeueTliO3GkA+iO36I1eC6ytYiaUj/aQKxPiESGnbe97PC?=
 =?windows-1256?Q?QoAEtNrtTTB19ApGTsqq0BjR5p4Z5lMVO2S50lotYsuIOEZuIaXOQTn9?=
 =?windows-1256?Q?wAuBx7NnXQgkq0WfRBi50UPl0k8jUVm/iQbso6sYxDdy/HosNWcMmY2A?=
 =?windows-1256?Q?YyXUX4y3eLxrnRAjhfPaiwLlc5C72AA+ShXoXRJ49MN0X8fFfA0rl1vF?=
 =?windows-1256?Q?6Z2VVWXTQAd8bp9W8txGMXbbyLow2mqa9m3ho2K9UHh1WMan/UuGr+7l?=
 =?windows-1256?Q?Lvx4J7PjRYVg+6tcXV6mnt6VCo+ZBmgz2XPqy+kgKuM+ydLa15EAjp2G?=
 =?windows-1256?Q?4Cago0I33E1W9c+ml8+GJqiQxgKHdqe4dTteVZExhTlRYwXvhdEP6DgZ?=
 =?windows-1256?Q?fKKOIX17FnQQ5utCDlk6N1k+TrFyrbR3PKl5nsIoMLtVsLKj+v0h6Fv8?=
 =?windows-1256?Q?YNvyJVRlqPwWFlUu3Q4fUYWmWNg/8Cy+jmemWsDwjZT29i2nZrWZlvzp?=
 =?windows-1256?Q?2wlhm2Kh6cAM48/qprToj2nEP39mNw6wABA95T3ck8v5S7vZTN+tUk8Y?=
 =?windows-1256?Q?MukAO66SRXoQEXm70N+yDoB91uTVADeVJ4eNZEBOq5F5vVJa0uRKE4tF?=
 =?windows-1256?Q?hr+woBp5aCvY43Sq6DRYycxVgEALHdcT2Zutc2tDSfkktsjqXyl9DLWe?=
 =?windows-1256?Q?MLrNiF1N+2UYxoEtHRCZDIKyml9MCPOXaxS1cC/Fv7nMX/vecIVDktK0?=
 =?windows-1256?Q?QrR7c86TZnvYa83LXPfTcM6GyFkLHSlR3BYknolFSt3gwex30EM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8P223MB0383.NAMP223.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?windows-1256?Q?kNPYJHSSuVoWTDv791veXNPxEsEewRZU6bqFvgXUN5hlsKKeUiXRbpu/?=
 =?windows-1256?Q?kpiroFlOmnzd0hmuVpiYMY/mbFlP4nCvOqVyWtu4xZa8x7nvtl1jnCut?=
 =?windows-1256?Q?+8OWNAhnbBhgUP4wLpLktKODRzHjwEDYNsSUxaKorP+A/WY0vZmkcPO8?=
 =?windows-1256?Q?5T92Ct+dgYOawdsLh85rpw8NPp5hGdVXmBXm+9rCUWVCtc3V7LHfGZCe?=
 =?windows-1256?Q?oBEMZ/caei4/V8UK9xqmbLxUmBCEOiGpqUZqdi1NSCL9JWbwXeii7ksR?=
 =?windows-1256?Q?1ihYuEvlXjW7+Ty6qGXA2bCuOuRbmz+q8n/j0RMAV+LBN3ZMeI6F3qIc?=
 =?windows-1256?Q?gpT1A1jHwRJHjT0WtWAMbp4NUg8eH1QV9iDhVNJthYtkksex7mKlAW0V?=
 =?windows-1256?Q?kuZs+ZzyKtD7iMNwW7tW+uD2p1pEiDFq31fJzLCd0POS+lDNc/5iFpYN?=
 =?windows-1256?Q?oMF2ZeFPB6agpOQBEkmVoct6ikBtxDWBWylxzWr1Svt4C21xGbKGx7up?=
 =?windows-1256?Q?txdrup7JTzXnwbD2PEnVD+UeMR6n4SDGMJqceggxeumGDnQ0Yy0Md2Cq?=
 =?windows-1256?Q?RV7huDG++dhFaMs8Y3ShdUXxoKEe//sjIpa/yQke7IMaVxCFDEvuqhCz?=
 =?windows-1256?Q?v9ip2ZngN3f1zOIoZg/M3FoQD5vJBkP1vu47kOrMI5N0/I9NpaFmMsqm?=
 =?windows-1256?Q?gO6PC+mb5ddiEUmnnK9OzZJOzUEKYnboheH1O6ViOBCWor/O2+1dWOKP?=
 =?windows-1256?Q?/u4NXPXissYmkdyay2BNyKD2dgi51vloVMgDHnVkxgefFYBgbdwZ+zsP?=
 =?windows-1256?Q?IhMDck+uh0uejDZe81d6VWZFc62/BAEBk1Dc97zu5gopxzd8f9BzBMCF?=
 =?windows-1256?Q?mtQbwi79IGU8+D7OCyAiVrkBMibKGF/uI16RgIDpglypp/TD7NFnN9RW?=
 =?windows-1256?Q?RlGOTdBfIzE/oSNxgRVwe5TS2PZpeJ2jAIPNRKWYWdPqgpyadVc6y0oQ?=
 =?windows-1256?Q?ZppJAFc3FRKccQeF31yJ24KYoMu8cnCpZVklFy3EFKhoGGFPQTtjJWfL?=
 =?windows-1256?Q?mun83MyestwBgOzeALAhz9KNU2j2t71UrL7/Rt8iQY7S5SkOombNjqiy?=
 =?windows-1256?Q?dbDwqW5UN/M5bWl/NBHPnGZNPZrnNNSwbfGVY+0YHKwHB+1CHScz+iDe?=
 =?windows-1256?Q?xLmfmVkFBUkJyKe49nDCG3clzRtG/hFtXHrkD0wKyPNwoe5bOazGak2F?=
 =?windows-1256?Q?DaRE3IrGjidFe5B4OS1JAPy7SqJP9pg7ueKBnYE7biumy7OZtOvSC2T7?=
 =?windows-1256?Q?0CuOwcCJi9j2t78Z2RPZTUH97Yi9deHVMFgXjjfZvzgPrvI05v4M75z1?=
 =?windows-1256?Q?pCWSbJ2JMHWfeut5Yn/yivyt3rvTYhCJxYSVsfZvJE1UEkEP3hKAnSO+?=
 =?windows-1256?Q?u9gOx/tZ3iVBHDvUXyA8J4eJtoENjLZWp+2jHqWUH7vElfXSPwjXLgNK?=
 =?windows-1256?Q?6W+GVN0EUKn2+ydIgGCLcEgtSPhClJDIrxYQXKX71qzzj9e7DmBSyXCm?=
 =?windows-1256?Q?VKZpTl7sO2bJJPXdtuhMNdEIRGvhA4K4g/SnQfBPNyj7NqZQ+dI/iV6V?=
 =?windows-1256?Q?UNe8h5QO4JQqfMoYcl5phbzeExetQpAo8sS+PVQe0fvNBa19kdP0i7aP?=
 =?windows-1256?Q?q0Nc2TCsTU0=3D?=
Content-Type: text/plain; charset="windows-1256"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: unh.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8P223MB0383.NAMP223.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 795722ba-43b3-44e5-f186-08dd8fdc8c67
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2025 16:05:56.7130 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d6241893-512d-46dc-8d2b-be47e25f5666
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Frz9G37OTPtsOcluug5IWDcxVMC8NvCjn9R/8PqKCtSUdVPNeRosGgYqmmaCk9wsv88YDwSsfch3crf6mR/2Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3P223MB0846
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
> Sent:=A0Friday, May 9, 2025 12:24 PM=0A=
> To:=A0Owen Hilyard <Owen.Hilyard@unh.edu>; Etelson, Gregory <getelson@nvi=
dia.com>; Richardson, Bruce <bruce.richardson@intel.com>=0A=
> Cc:=A0dev@dpdk.org <dev@dpdk.org>=0A=
> Subject:=A0Re: [PATCH] rust: RFC/demo of safe API for Dpdk Eal, Eth and R=
xq=0A=
> =0A=
> > From: Owen Hilyard=0A=
> > Sent: Friday, May 09, 2025 12:53 AM=0A=
> > To: Van Haaren, Harry; Etelson, Gregory; Richardson, Bruce=0A=
> > Cc: dev@dpdk.org=0A=
> > Subject: Re: [PATCH] rust: RFC/demo of safe API for Dpdk Eal, Eth and R=
xq=0A=
> >=0A=
<snip>=0A=
=0A=
> > > Maybe it will help to split the conversation into two threads, with o=
ne focussing on=0A=
> > "DPDK used through Safe Rust abstractions", and the other on "future co=
ol use-cases".=0A=
> >=0A=
> > Agree.=0A=
> > =0A=
> > > Perhaps I jumped a bit too far ahead mentioning async runtimes, and w=
hile I like the enthusiasm for designing "cool new stuff", it is probably b=
etter to be realistic around what will get "done": my bad.=0A=
> > >=0A=
> > > I'll reply to the "DPDK via Safe Rust" topics below, and start a new =
thread (with same folks on CC) for "future cool use-cases" when I've had a =
chance to clean up a little demo to showcase them.=0A=
> > > =0A=
> > >=0A=
> > > > > > Thanks for sharing. However, IMHO using EAL for thread manageme=
nt in rust=0A=
> > > > > > is the wrong interface to expose.=0A=
> > > > >=0A=
> > > > > EAL is a singleton object in DPDK architecture.=0A=
> > > > > I see it as a hub for other resources.=0A=
> > >=0A=
> > > Harry Wrote:=0A=
> > > > Yep, i tend to agree here; EAL is central to the rest of DPDK worki=
ng correctly.=0A=
> > > > And given EALs implementation is heavily relying on global static v=
ariables, it is=0A=
> > > > certainly a "singleton" instance, yes.=0A=
> > >=0A=
> > > Owen wrote:=0A=
> > > > I think a singleton one way to implement this, but then you lose so=
me of the RAII/automatic resource management behavior. It would, however, m=
ake some APIs inherently unsafe or very unergonomic unless we were to force=
 rte_eal_cleanup to be run via atexit(3) or the platform equivalent and for=
bid the user from running it themselves. For a lot of Rust runtimes similar=
 to the EAL (tokio, glommio, etc), once you spawn a runtime it's around unt=
il process exit. The other option is to have a handle which represents the =
state of the EAL on the Rust side and runs rte_eal_init on creation and rte=
_eal_cleanup on destruction. There are two ways we can make that safe. Firs=
t, reference counting, once the handles are created, they can be passed aro=
und easily, and the last one runs rte_eal_cleanup when it gets dropped.=A0 =
This avoids having tons of complicated lifetimes and I think that, everywhe=
re that it shouldn't affect fast path performance, we should use refcountin=
g.=0A=
> > >=0A=
> > > Agreed, refcounts for EAL "singleton" concept yes. For the record, th=
e initial patch actually returns a=0A=
> > "dpdk" object from dpdk::Eal::init(), and Drop impl has a // TODO rte_e=
al_cleanup(), so well aligned on approach here.=0A=
> > > https://patches.dpdk.org/project/dpdk/patch/20250418132324.4085336-1-=
harry.van.haaren@intel.com/=0A=
> >=0A=
> > One thing I think I'd like to see is using a "newtype" for important nu=
mbers (ex: "struct EthDevQueueId(pub u16)"). This prevents some classes of =
error but if we make the constructor public it's at most a minor inconvenie=
nce to anyone who has to do something a bit odd.=0A=
> >=0A=
> > > > Owen wrote:=0A=
> > > The other option is to use lifetimes. This is doable, but is going to=
 force people who are more likely to primarily be C or C++ developers to di=
ve deep into Rust's type system if they want to build abstractions over it.=
 If we add async into the mix, as many people are going to want to do, it's=
 going to become much, much harder. As a result, I'd advocate for only usin=
g it for data path components where refcounting isn't an option.=0A=
> > >=0A=
> > > +1 to not using lifetimes here, it is not the right solution for this=
 EAL / singleton type problem.=0A=
> >=0A=
> > Having now looked over the initial patchset in more detail, I think we =
do have a question of how far down "it compiles it works" we want to go. Fo=
r example, using typestates to make Eal::take_eth_ports impossible to call =
more than once using something like this:=0A=
> >=0A=
> > #[derive(Debug, Default)]=0A=
> > pub struct Eal<const HAS_ETHDEV_PORTS: bool> {=0A=
>=A0>=A0=A0=A0 eth_ports: Vec<eth::Port>,=0A=
> > }=0A=
> >=0A=
> > impl<const HAS_ETHDEV_PORTS: bool> Eal<HAS_ETHDEV_PORTS> {=0A=
>=A0>=A0=A0=A0 pub fn init() -> Result<Self, String> {=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0 // EAL init() will do PCI probe and VDev enumer=
ation will find/create eth ports.=0A=
>=A0>=A0=A0=A0=A0=A0=A0=A0 // This code should loop over the ports, and bui=
ld up Rust structs representing them=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0 let eth_port =3D vec![eth::Port::from_u16(0)];=
=0A=
>=A0>=A0=A0=A0=A0=A0=A0=A0 Ok(Eal {=0A=
>=A0>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 eth_ports: Some(eth_port),=0A=
>=A0>=A0=A0=A0=A0=A0=A0=A0 })=0A=
>=A0>=A0=A0 }=0A=
> > }=0A=
> >=0A=
> > impl Eal<true> {=0A=
>=A0>=A0=A0=A0 pub fn take_eth_ports(self) -> (Eal<false>, Vec<eth::Port>) =
{=0A=
>=A0>=A0=A0=A0=A0=A0=A0=A0 (Eal::<false>::default(), self.eth_ports.take())=
=0A=
>=A0>=A0=A0=A0 }=0A=
> > }=0A=
> >=0A=
> > impl<const HAS_ETHDEV_PORTS: bool> Drop for Eal<HAS_ETHDEV_PORTS> {=0A=
>=A0>=A0=A0=A0 fn drop(&mut self) {=0A=
>=A0>=A0=A0=A0=A0=A0=A0=A0 if HAS_ETHDEV_PORTS {=0A=
>=A0>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 // extra desired port cleanup=0A=
>=A0>=A0=A0=A0=A0=A0=A0=A0 }=0A=
>=A0>=A0=A0=A0=A0=A0=A0=A0 // todo: rte_eal_cleanup()=0A=
>=A0>=A0=A0=A0 }=0A=
> > }=0A=
> >=0A=
> > This does add some noise to looking at the struct, but also lets the co=
mpiler enforce what state a struct should be in to call a given function. T=
aken to its logical extreme, we could create an API where many of the "reso=
urce in wrong state" errors should be impossible. However, it also requires=
 more knowledge of Rust's type system on the part of the people making the =
API and can be a bit harder to understand without an LSP helping you along.=
=0A=
> =0A=
> This is too much in my opinion. I know there's value, but the ergonomics =
suffers significantly if we have generics over Eal.=0A=
I'd like to not treat Ethdev "differently" to other Devs. And if we give Et=
hdev a generic for EAL, then the others would too; exploding the generic co=
unts & complixity.=0A=
=0A=
Another option would be to have the EAL init return a tuple or struct you a=
re meant to de-structure. Ex:=0A=
=0A=
#[derive(Debug, Default)]=0A=
pub struct Eal {}=0A=
=0A=
pub struct EalPartsHolder {=0A=
    pub eal: Eal,=0A=
    pub ethdev_ports: Vec<eth::Port>,=0A=
}=0A=
=0A=
impl Eal {=0A=
    pub fn init() -> Result<EalPartsHolder, String> {=0A=
        // EAL init() will do PCI probe and VDev enumeration will find/crea=
te eth ports.=0A=
        // This code should loop over the ports, and build up Rust structs =
representing them=0A=
        let eth_ports =3D vec![eth::Port::from_u16(0)];=0A=
        Ok(EalPartsHolder {=0A=
            eal: Self {},=0A=
            ethdev_ports: eth_ports,=0A=
        })=0A=
    }=0A=
}=0A=
=0A=
pub fn main() {=0A=
    let EalPartsHolder { eal, ethdev_ports } =3D Eal::init().unwrap();=0A=
}=0A=
=0A=
DPDK is complex, especially for new people learning, so I want to create "p=
its of success" where by the time you make the code compile it should work.=
 This destructuring API might be more ergonomic for users, since only state=
 which is expected to be attached to the EAL is kept inside of the EAL stru=
ct, and users can use ".." to "don't care" about any resources they don't p=
lan to use. We can add on other PMD types and resources over time.  =0A=
=0A=
However, I think this does warrant a discussion on how far we're willing to=
 push Rust's type system in the name of "zero overhead abstractions". My ow=
n tolerance for extensive use of generics is fairly high, and I would advoc=
ate for leaving no stone unturned in the type system in order to avoid runt=
ime overhead in a safe API. In the kernel, the Rust for Linux project has h=
ad to make extensive use of advanced type system features in order to encod=
e some more complicated APIs correctly, especially inside of the  DRM and f=
ilesystems abstractions. While I think most of DPDK's APIs are reasonable t=
o encode with simple typestates, in some cases such as async rte_flow I thi=
nk will want to make heavier use of some of these design patterns. What I p=
ropose is that all efforts be made to simplify the API without sacrificing =
safety or performance, but if the API is impossible to encode in "simple Ru=
st", then case-by-case determinations can be made as to whether the users o=
f the API are better served by runtime overhead or cognitive overhead.=0A=
=0A=
<snip>=0A=
=0A=
> So this technique is really cool, but not the right tradeoff in this case=
.=0A=
=0A=
<snip>=0A=
=0A=
> > > The key point above is "except where runtimes force them to mix". The=
 DPDK rxq concept (struct Rxq in the code linked above) is !Send.=0A=
> > > As a result, it cannot be moved between threads. That allows per-lcor=
e concepts to be used for performance.=0A=
> >=0A=
> > The problem is that, with Tokio, it also can't be held across an await =
point. I agree that !Send is correct, but the existence of !Send resources =
means that integration with Tokio is much, much harder. For PMDs with RTE_E=
TH_TX_OFFLOAD_MT_LOCKFREE, TX is fine, but as far as I am aware there is no=
 equivalent for RX. And, to safely take advantage of the TX version, we'd n=
eed to know the capabilities of the target PMD at compile time, which is pa=
rt of why my own bindings "devirtualize" the EAL and require a top-level fu=
nction which dispatches based on the capabilities provided by the PMDs I ma=
ke use of. Glommio was easily able to integrate safely (theoretically Monoi=
o would be too, although I haven't used it), but I haven't found a safe way=
 to mix Tokio and queue handles which doesn't make it nearly impossible to =
use async, even when taking that fairly extreme measure.=0A=
> >=0A=
> > > The point I was trying to make is that we (the DPDK safe rust wrapper=
 API) should not be prescriptive in how it is used.=0A=
> > > In other words: we should allow the user to decide how to spawn/manag=
e/run threads.=0A=
> > >=0A=
> > > We must encode the DPDK requirements of e.g. "Rxq concept" with !Send=
, !Sync marker traits.=0A=
> > > Then the Rust compiler will at compile-time ensure the users code is =
correct.=0A=
> >=0A=
> > I agree that !Send and !Sync are likely correct for Rxqs, however, we a=
lso need to be very careful in documenting the WHY of !Send and !Sync in ea=
ch context. For instance, how are we going to get the queue handles to the =
threads which run the data path if we get all of them from an Eal struct in=
 a Vec on the main thread? We may need to have a way to "deactivate" them s=
o the user can't use them for queue operations but they are Send, !Sync, em=
it a fence, and then when the user "activates" them it performs another fen=
ce to force anything the last thread did with the queue to be visible on th=
e new core. I suspect we'll need to apply a similar pattern for other threa=
d unsafe parts of DPDK in order to get them to where they need to be during=
 execution.=0A=
=0A=
=0A=
> Look at the patch, the difference between a RxqHandle and Rxq encodes exa=
ctly what you're asking.=0A=
> Gregory renamed the "change" function to .activate(), but the fundamental=
 "consume struct and give back !Send pollable Rxq" is the same.=0A=
> Agree we need things documented, but the C API docs should have that alre=
ady, see the Rxq example as explained at Userspace: https://www.youtube.com=
/watch?t=3D890&v=3Dlb6xn2xQ-NQ&feature=3Dyoutu.be=0A=
=0A=
My mistake.=0A=
=0A=
> > > I don't believe that I can identify all use-cases, so we cannot desig=
n requirements around statements like "I think X is more likely than Y".=0A=
> >=0A=
> > I agree, this is why unsafe escape hatches will be necessary. Someone w=
ill have some weird edge-case like a CPU with no cache that makes it fine t=
o move Rxqs around with abandon.=0A=
> =0A=
> No need for unsafe, just not be prescriptive in how threading "should wor=
k", just be flexible and allow the user to decide.=0A=
> All the proposed DPDK-rs does is provides safe Rust structs that encode t=
he correct Send/Sync requirements, nothing more.=0A=
> After that, any user can correctly use our APIs, and if it compiles, then=
 its correct (from a threading POV).=0A=
> Even users with "weird edge-cases like a CPU with no cache" will still wo=
rk correctly.=0A=
=0A=
I think that it is reasonable to have a guarded, easy to find and audit, "t=
rust the developer" escape hatch, not just for threads but for large parts =
of DPDK's API surface. I think we've all had to do slightly odd things to m=
eet a performance target or make a feature work in a codebase without a red=
esign, and an API which allows users to express that they have upheld the i=
nvariants of the C API in ways they cannot tell the compiler about is preci=
sely what may be needed there. Ideally, we can provide flexible enough safe=
 APIs that will work for everyone, but covering every use-case and scenario=
 is impossible. Possibly this can be covered by the "raw" API and the abili=
ty to get the necessary identifiers or pointers out of various handles, and=
 any team which wants to forbid that can stick a #![forbid(unsafe_code)] in=
 their main file or lib file and be on their way. =0A=
=0A=
=0A=
> > > Harry wrote:=0A=
> > > > Lets focus on Tokio first: it is an "async runtime" (two links for =
future readers)=0A=
> > > >=A0=A0=A0=A0 <snip>=0A=
> > > > So an async runtime can run "async" Rust functions (called Futures,=
 or Tasks when run independently..)=0A=
> > > > There are lots of words/concepts, but I'll focus only on the thread=
 creation/control aspect, given the DPDK EAL lcore context.=0A=
> > > >=0A=
> > > > Tokio is a work-stealing scheduler. It spawns "worker" threads, and=
 then gives these "tasks"=0A=
> > > > to various worker cores (similar to how Golang does its work-steali=
ng scheduling). Some=0A=
> > > > DPDK crate users might like this type of workflow, where e.g. RXQ p=
olling is a task, and the=0A=
> > > > "tokio runtime" figures out which worker to run it on. "Spawning" a=
 task causes the "Future"=0A=
> > > > to start executing. (technical Rust note: notice the "Send" bound o=
n Future: https://docs.rs/tokio/latest/tokio/task/fn.spawn.html=A0)=0A=
> > > > The work stealing aspect of Tokio has also led to some issues in th=
e Rust ecosystem. What it effectively means is that every "await" is a plac=
e where you might get moved to another thread. This means that it would be =
unsound to, for example, have a queue handle on devices without MT-safe que=
ues unless we want to put a mutex on top of all of the device queues. I per=
sonally think this is a lot of the source of people thinking that Rust asyn=
c is hard, because Tokio forces you to be thread safe at really weird place=
s in your code and has issues like not being able to hold a mutex over an a=
wait point.=0A=
> > > >=0A=
> > > > Other users might prefer the "thread-per-core" and CPU pinning appr=
oach (like DPDK itself would do).=0A=
> > > > nit: Tokio also spawns a thread per core, it just freely moves task=
s between cores. It doesn't pin because it's designed to interoperate with =
the normal kernel scheduler more nicely. I think that not needing pinned co=
res is nice, but we want the ability to pin for performance reasons, especi=
ally on NUMA/NUCA systems (NUCA =3D Non-Uniform Cache Architecture, almost =
every AMD EPYC above 8 cores, higher core count Intel Xeons for 3 generatio=
ns, etc).=0A=
> > > > Monoio and Glommio both serve these use cases (but in slightly diff=
erent ways!). They both spawn threads and do CPU pinning.=0A=
> > > > Monoio and Glommio say "tasks will always remain on the local threa=
d". In Rust techie terms: "Futures are !Send and !Sync"=0A=
> > > > https://docs.rs/monoio/latest/monoio/fn.spawn.html=0A=
> > > > https://docs.rs/glommio/latest/glommio/fn.spawn_local.html=0A=
> > >=0A=
> > > Owen wrote:=0A=
> > > > There is also another option, one which would eliminate "service co=
res". We provide both a work stealing pool of tasks that have to deal with =
being yanked between cores/EAL threads at any time, but aren't data plane t=
asks, and then a different API for spawning tasks onto the local thread/cor=
e for data plane tasks (ex: something to manage a particular HTTP connectio=
n). This might make writing the runtime harder, but it should provide the b=
est of both worlds provided we can build in a feature (Rust provides a way =
to "ifdef out" code via features) to disable one or the other if someone do=
esn't want the overhead.=0A=
> > >=0A=
> > > Hah, yeah.. (as maintainer of service cores!) I'm aware that the "asy=
nc Rust" cooperative scheduling is very similar.=0A=
> > > That said, the problem service-cores set out to solve is a very diffe=
rent one to how "async Rust" came about.=0A=
> > > The implementations, ergonomics, and the language its written in are =
different too... so they're different beasts!=0A=
> >=0A=
> > I think we could still make use of the idea of separate pools of thread=
 local and global tasks.=0A=
> >=0A=
> > > We don't want to start writing "dpdk-async-runtime". The goal is not =
to duplicate everything, we must integrate with existing.=0A=
> >=0A=
> > What do you picture someone who picks up "dpdk-rs" seeing as the interf=
ace to DPDK when it's fully integrated? Do they enable a feature flag in th=
eir async runtime and the runtime handles it for them, do they set up DPDK =
and start the runtime? Most of the libraries I'm aware of assume the presen=
ce of an OS network stack. Yes, there are some like smoltcp which are capab=
le of operating on top of the l2 interface provided by DPDK, but most are g=
oing to want a network stack to exist on top of.=0A=
> =0A=
> DPDK-rs remains DPDK, and the Rust APIs remain at the same level of C API=
s.=0A=
> When I say "integrate with" I mean that DPDK-rs APIs should enable others=
 to build on top of it.=0A=
> I reference some examples (eg SmolTCP, Tokio etc) because knowledge of ho=
w they could consume DPDK gives good context.=0A=
> =0A=
> I am NOT proposing that DPDK-rs includes more features than DPDK-via-C-AP=
I.=0A=
> DPDK-rs is "just" a safe Rust interface to DPDK functionality.=0A=
> =0A=
> I am advocating that we understand how things integrate and try support/b=
e-aware of those usages,=0A=
> primarily to ensure that topics like threading can be resolved well. Yes =
other libraries expect a TcpListener,=0A=
> and libraries like SmolTCP (or the DemiKernel Netstack, or FuchsiaOS's ne=
tstack3, etc) may provide that bridge.=0A=
> =0A=
> But DPDK-rs is just DPDK: as first priority, a high-performance L2 ethern=
et packet I/O library.=0A=
> Due to Rust language features, we can build in safety via Send/Sync of st=
ructs, and nice API design.=0A=
> To me, that's the goal for a minimal DPDK-rs release.=0A=
=0A=
That makes sense. I thought you were going in a different direction which c=
onfused me.  =0A=
=0A=
> > > I will try provide some examples of integrating DPDK with other Rust =
networking projects, to prove that it can be done, and is useful.=0A=
> > >=0A=
> > > Harry wrote:=0A=
> > > > So there are at least 3 different async runtimes (and I haven't eve=
n talked about async-std, smol, embassy, ...) which=0A=
> > > > all have different use-cases, and methods of running "tasks" on thr=
eads. These runtimes exist, and are widely used,=0A=
> > > > and applications make use of their thread-scheduling capabilities.=
=0A=
> > > >=0A=
> > > > So "async runtimes" do thread creation (and optionally CPU pinning)=
 for the user.=0A=
> > > > Other libraries like "Rayon" are thread-pool managers, those also h=
ave various CPU thread-create/pinning capabilities.=0A=
> > > > If DPDK *also* wants to do thread creation/management and CPU-threa=
d-to-core pinning for the user, that creates tension.=0A=
> > > > The other problem is that most of these async runtimes have IO very=
 tightly integrated into them. A large portion of Tokio had to be forked an=
d rewritten for io_uring support, and DPDK is a rather stark departure from=
 what they were all designed for. I know that both Tokio and Glommio have "=
start a new async runtime on this thread" functions, and I think that Tokio=
 has an "add this thread to a multithreaded runtime" somewhere.=0A=
> > > >=0A=
> > > > I think the main thing that DPDK would need to be concerned about i=
s that many of these runtimes use thread locals, and I'm not sure if that w=
ould be transparently handled by the EAL thread runtime since I've always u=
sed thread per core and then used the Rust runtime to multiplex between tas=
ks instead of spawning more EAL threads.=0A=
> > > >=0A=
> > > > Rayon should probably be thought of in a similar vein to OpenMP, si=
nce it's mainly designed for batch processing. Unless someone is doing some=
 fairly heavy computation (the kind where "do we want a GPU to accelerate t=
his?" becomes a question) inside of their DPDK application, I'm having trou=
ble thinking of a use case that would want both DPDK and Rayon.=0A=
> > > >=0A=
> > > > > Bruce wrote: "so having Rust (not DPDK) do all thread management =
is the way to go (again IMHO)."=0A=
> > > >=0A=
> > > > I think I agree here, in order to make the Rust DPDK crate usable f=
rom the Rust ecosystem,=0A=
> > > > it must align itself with the existing Rust networking ecosystem.=
=0A=
> > > >=0A=
> > > > That means, the DPDK Rust crate should not FORCE the usage of lcore=
 pinnings and mappings.=0A=
> > > > Allowing a Rust application to decide how to best handle threading =
(via Rayon, Tokio, Monoio, etc)=0A=
> > > > will allow much more "native" or "ergonomic" integration of DPDK in=
to Rust applications.=0A=
> > >=0A=
> > > Owen wrote:=0A=
> > > > I'm not sure that using DPDK from Rust will be possible without eit=
her serious performance sacrifices or rewrites of a lot of the networking l=
ibraries. Tokio continues to mimic the BSD sockets API for IO, even with th=
e io_uring version, as does glommio. The idea of the "recv" giving you a bu=
ffer without you passing one in isn't really used outside of some lower-lev=
el io_uring crates. At a bare minimum, even if DPDK managed to offer an API=
 that works exactly the same ways as io_uring or epoll, we would still need=
 to go to all of the async runtimes and get them to plumb DPDK support in o=
r approve someone from the DPDK community maintaining support. If we don't =
offer that API, then we either need rewrites inside of the async runtimes o=
r for individual libraries to provide DPDK support, which is going to be ev=
en more difficult.=0A=
> > >=0A=
> > > Regarding traits used for IO, correct many are focussed on "recv" giv=
ing you a buffer, but not all. Look at Monoio, specifically the *Rent APIs:=
=0A=
> > https://docs.rs/monoio/latest/monoio/io/index.html#traits=0A=
> >=0A=
> > As far as I can tell, the *Rent APIs for Monoio have the same problem, =
they require you to pass in a buffer, and to satisfy that API we'd need to =
throw out zero copy, pass that buffer directly to the PMD, or do some weird=
 thing were we use that API to recycle buffers back into the mempool. I see=
, in Monoio terms, a DPDK API looking more like TcpStream::read(&mut self) =
-> impl Future<Output =3D BufResult<usize, dpdk::PktMbuf>> or some equivale=
nt abstraction on top.=0A=
> >=0A=
> > > Owen wrote:=0A=
> > > > I agree that forcing lcore pinnings and mappings isn't good, but I =
think that DPDK is well within its rights to build its own async runtime wh=
ich exposes a standard API. For one thing, the first thing Rust users will =
ask for is a TCP stack, which the community has been discussing and debatin=
g for a long time. I think we should figure out whether the goal is to allo=
w DPDK applications to be written in Rust, or to allow generic Rust applica=
tions to use DPDK. The former means that the audience would likely be Rust-=
fluent people who would have used DPDK regardless, and are fine dealing wit=
h mempools, mbufs, the eal, and ethdev configuration. The latter is a much =
larger audience who is likely going to be less tolerant of dpdk-rs exposing=
 the true complexity of using DPDK. Yes, Rust can help make the abstraction=
s better, but there's an amount of inherent complexity in "Your NIC can han=
dle IPSec for you and can also direct all IPv6 traffic to one core" that I =
don't think we can remove.=0A=
> > >=0A=
> > > Ok, we're getting very far into future/conceptual design here.=0A=
> > > For me, DPDK having its own async runtime and its own DPDK TCP stack =
is NOT the goal.=0A=
> > > We should try to integrate DPDK with existing software environments -=
 not rewrite the world.=0A=
> >=0A=
> > Which existing software environments are you thinking of exactly? Most =
Rust applications that use networking are going to be using Axum, Tower, an=
d the other crates that you've mentioned, and all of those rely on having a=
 TCP stack to be useful. I have found vanishingly few Rust crates which han=
dle integration with DPDK without me editing them to some degree. I'd like =
to know where you're finding existing Rust software environments which don'=
t care about the presence of a network stack but are still networking orien=
ted. If the goal is to take a DPDK application that would have been written=
 in C/C++ and write it in Rust instead, that is very different than taking =
an application which would have happily used the OS network stack, such as =
an HTTP server which deals with normal (<1k RPS) amounts of traffic, and mo=
ving it onto DPDK, and it seems to me like you are suggesting that we shoul=
d focus on the latter.=0A=
>=0A=
> As above, DPDK-rs is for accelerated packet I/O. Perhaps with some offloa=
d features etc in future,=0A=
> but fundamentally its a high-speed packet I/O library.=0A=
> =0A=
> Other libraries can build on top, I've done a small (sorry for the pun!) =
example with SmolTCP,=0A=
> and integrating DPDK into the "phy" device abstraction: it is not difficu=
lt. This provides a route=0A=
> to TCP with high performance I/O under the hood...=0A=
> =0A=
> So you mention "HTTP is <1k RPS", that assumption is not correct in all c=
ases.=0A=
> Use-cases like Next-Gen-FireWall (NGFW) and Reverse-proxy require L7 HTTP=
 processing.=0A=
> Some even go as far as doing "TLS bumping" (aka MITM inspection; eg inter=
nally in a company network).=0A=
>=0A=
> In these cases, the requirement for L7 HTTP(s) parsing, TLS decrypt/DPI/c=
rypt is huge, with=0A=
> DPDK levels of performance absolutely being required (or scaling to 100s =
of boxes doing <1k RPS each!)=0A=
=0A=
I must have spent too long away from DPDK, because when I think of a typica=
l networked application, in Rust or languages, I think of CRUD apps. I agre=
e that NGFW and L7 proxies/load balancers are a better use-cases for DPDK t=
han low request rate HTTP servers. If DPDK ends where it does now or at a s=
lightly high level (ex: provide "IP sockets" and handle ARP/neighbor discov=
ery to ease adoption), then I think there's a lot more space for applicatio=
ns to integrate DPDK without DPDK being forced to conform to legacy APIs. I=
t also provides space for DPDK to provide integrated APIs that properly lev=
erage the hardware.  =0A=
=0A=
> I believe the above cases are not easily catered for, because the project=
s (e.g, Snort, Envoy)=0A=
> were mostly designed in a pre-DPDK era, and hence expect kernel/FD based =
I/O. I believe that the lack=0A=
> of clear C-API abstraction into L7/HTTP layers has stifled some of those =
projects from consuming DPDK.=0A=
=0A=
Strong agree, Rust should help with that abstraction. =0A=
=0A=
> So yes, DPDK-rs initially should focus on core priorities: L2 ethernet I/=
O.=0A=
> But because the abstractions are more easily ported in Rust, ensuring we =
don't "design out" these=0A=
> other use-cases is very important to me - I believe it can expand the pot=
ential use-cases for the=0A=
> core DPDK functionality (Ethdev and the PMDs) a lot.=0A=
=0A=
I think that's good for an MVP. I also think it would be useful to provide =
abstractions for the security library and other things that DPDK can hardwa=
re accelerate, provided we can implement robust software fallbacks once we'=
ve gotten the basics working.=0A=
=0A=
> > > Owen wrote:=0A=
> > > > I personally think that making an API for DPDK applications to be w=
ritten in Rust, and then steadily adding abstractions on top of that until =
we arrive at something that someone who has never looked at a TCP header ca=
n use without too much confusion. That was part of the goal of the Iris pro=
ject I pitched (and then had to go finish another project so the design is =
still WIP). I think that a move to DPDK is going to be as radical of a chan=
ge as a move to io_uring, however, DPDK is fast enough that I think it may =
be possible to convince people to do a rewrite once we arrive at that high =
level API.=0A=
> > >=0A=
> > > I haven't heard of the Iris project you mentioned, is there something=
 concrete to learn from, or is it too WIP to apply?=0A=
> >=0A=
> > I have some design docs, but nothing concrete. I got pulled back to ano=
ther project which is still ongoing shortly after I gave the talk at the la=
st DPDK summit. The main goal of Iris is to provide a DPDK-based alternativ=
e to something like a gRPC with a message-based API instead of a byte-based=
 one, and to take advantage of the massive amount of extra breathing room u=
nder that new API (as compared to TCP) to plumb in the various accelerators=
 integrated into DPDK alongside a network stack. It's based on observations=
 that many developers aren't even working at a TCP or HTTP level any more, =
but are instead using "JSON RPC over HTTPS which is automatically converted=
 into objects by their HTTP server framework" or something like gRPC to hav=
e a "send message to server" and "get message to server" API. Most of what =
I have for that is a lot of time spent thinking about a Rust-based API on t=
op of DPDK as a foundation for building the rest of the network stack on to=
p.=0A=
=0A=
> Wauw, big project goals; interesting. (Techie note, checkout Zenoh, and c=
heck how SmolTCP allocates its rx/tx buffers allocated in hugepages, lots o=
f cool potential here!)=0A=
=0A=
Well, large project goals are appropriate for a PhD dissertation project. Z=
enoh looks interesting, and is something that I'll take a closer look at. I=
ris is closer to a transport protocol than a pub/sub abstraction, and is de=
signed with the idea of "What if I designed a transport protocol for DPDK, =
to sit on top of DPDK's APIs and make use of all DPDK has to offer?", but t=
hey seem to have some interesting ideas that I might use for handling "reli=
able" (as in TCP) multicast, something database people have increasing inte=
rest in. =0A=
=0A=
> As above, I think DPDK-rs should focus on "Safe L2 packet I/O" for Rust. =
So while "cool stuff" above, my focus is on a good/safe L2 API first and fo=
remost.=0A=
=0A=
That makes sense. =0A=
=0A=
> > Owen wrote:=0A=
> > > "Swap out your sockets and rework the functions that do network IO fo=
r a 5x performance increase" is a very, very attractive offer, but for us t=
o get there I think we need to have DPDK's full potential available in Rust=
, and then build as many zero-overhead (zero cost or you couldn't write it =
better yourself) abstractions as we can on top. I want to avoid a situation=
 where we build up to the high-level APIs as fast as we can and then end up=
 in a situation where you have "Easy Mode" and then "C DPDK written in Rust=
" as your two options.=0A=
> >=0A=
> > My perspective is that we're carefully designing "Safe Rust" APIs, and =
will have "DPDKs full potential" as a result.=0A=
> > I'm not sure where the "easy mode" comment applies. But lets focus on c=
ode - and making concrete progress - over theoretical discussions.=0A=
> >=0A=
> > I'll keep my input more consise in future, and try get more patches on =
list for review.=0A=
> > > > Regards,=0A=
> > > > Gregory=0A=
> > >=0A=
> > > Apologies for the long-form, "wall of text" email, but I hope it capt=
ures the nuance of threading and=0A=
> > > async runtimes, which I believe in the long term will be very nice to=
 capture "async offload" use-cases=0A=
> > > for DPDK. To put it another way, lookaside processing can be hidden b=
ehind async functions & runtimes,=0A=
> > > if we design the APIs right: and that would be really cool for making=
 async-offload code easy to write correctly!=0A=
> > >=0A=
> > > Regards, -Harry=0A=
> > >=0A=
> > > Sorry for my own walls of text. As a consequence of working on Iris I=
've spent a lot of time thinking about how to make DPDK easier to use while=
 keeping the performance intact, and I was already thinking in Rust since i=
t provides one of the better options for these kinds of abstractions (the o=
ther option I see is Mojo, which isn't ready yet). I want to see DPDK becom=
e more accessible, but the performance and access to hardware is one of the=
 main things that make DPDK special, so I don't want to compromise that. I =
definitely agree that we need to force DPDK's existing APIs to justify them=
selves in the face of the new capabilities of Rust, but I think that starti=
ng from "How are Rust applications written today?" is a mistake.=0A=
> > > =0A=
=0A=
<snip>=0A=
=0A=
> Thanks, good input! Regards, -Harry=0A=
=0A=
Happy to provide input, =0A=
Owen=
