Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225CCC369C2
	for <dpdk-dev@archiver.kernel.org>; Sat,  3 May 2025 17:13:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A59824025D;
	Sat,  3 May 2025 19:13:53 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2131.outbound.protection.outlook.com [40.107.94.131])
 by mails.dpdk.org (Postfix) with ESMTP id C181740156
 for <dev@dpdk.org>; Sat,  3 May 2025 19:13:51 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eZldm0Deqx0WEqSCjdN130QMLJXYwbQS6byxLhLVKc+JFgf/3hDC8oHj3MkHpW5vIjXDAFLV9zXiKrDfWOhughXSsUL+BAT8DLaU+EvDA2UjHVnY2MR3EopYR2KWg6MS3ojRU/OJOmI05iFXobl/mVGOm9ZNhbMucEOX5AWu1/S+Y656gLaM+Ql6DfpU1Me9efJxIuF6M4GsNX5NHMunJp4wm+P1qPsqqyffv5WB5B/Kz9b3wd1MmYPxsH5x/LjLzHzdoAy7x4cDZsyFIufsjGYnrK30ANgolO18xJ0nPSYYfPX621LX08kaDwav7+5tl0oIHTZsS5EPWy8RUrjxQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2+oOU15RVTH1xpLt4syGh8WYU4fzaUDUeI9WLlXVlY4=;
 b=LYy8g7sBWvtlmovWkjvl0OWUpFPbwlfhXJopFrcfiWCHli0+qCIbsv+8m0wpWeCb/ts1uSnEX/PVj0TwqZpQzzuoGFxvN+YbiUWUkX3CToUDCWVYk1iq/U9xu0yutZC5U+H67AZ4rcoZpC8HNYkMluXY08pmT2V/x2NVtl0e5NA7Ov5PgG5rsGoXXW9iY59pZux1zGs2KsShdZn2eimz/5VqLbMSFkMdakGJH0ZYPdknhJX11cEG1/eSk74MbTVgJEoSfWqeO/WLaC4YcVY+eDuTIUhMGvHXB6EhqCU7X2OOPv5GEzfyhJguxs4SwSdlYwJIHo/v1G4rzf8iktWs7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=unh.edu; dmarc=pass action=none header.from=unh.edu; dkim=pass
 header.d=unh.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unh.edu; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2+oOU15RVTH1xpLt4syGh8WYU4fzaUDUeI9WLlXVlY4=;
 b=MMYFQuREgBw4fyj26JxdampNA4Pr720CcsBeX/Gyw4+5Il0JbLOh6LPcmwv4zePE4p+kEffzOXGbcCtBSfGKuq6N3WFU3noS9W95tcxq8wZf4Yf+4bUZwFZFo6GI+VvznRlvUsQpoFJdl1StXZuvrxkOFbvEDu3svFBzc7RICa0=
Received: from DM8P223MB0383.NAMP223.PROD.OUTLOOK.COM (2603:10b6:8:b::9) by
 SJ5PPF6327F1ED3.NAMP223.PROD.OUTLOOK.COM (2603:10b6:a0f:fc02::61a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Sat, 3 May
 2025 17:13:47 +0000
Received: from DM8P223MB0383.NAMP223.PROD.OUTLOOK.COM
 ([fe80::e52:6031:810f:a743]) by DM8P223MB0383.NAMP223.PROD.OUTLOOK.COM
 ([fe80::e52:6031:810f:a743%3]) with mapi id 15.20.8699.022; Sat, 3 May 2025
 17:13:47 +0000
From: Owen Hilyard <Owen.Hilyard@unh.edu>
To: "Van Haaren, Harry" <harry.van.haaren@intel.com>, "Etelson, Gregory"
 <getelson@nvidia.com>, Bruce Richardson <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH] rust: RFC/demo of safe API for Dpdk Eal, Eth and Rxq
Thread-Topic: [PATCH] rust: RFC/demo of safe API for Dpdk Eal, Eth and Rxq
Thread-Index: AQHbr6r0sqE17AHXak+XC2nGaMcQ/LOoNgYAgAEX6wCAAvcwAIAGwTaAgATktQCABLEMgIAA3kCAgAHmrICAABRGAIAAP/9t
Date: Sat, 3 May 2025 17:13:47 +0000
Message-ID: <DM8P223MB038323681A4BEA771CF92A6D8D8D2@DM8P223MB0383.NAMP223.PROD.OUTLOOK.COM>
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
In-Reply-To: <PH8PR11MB6803B2CD0BF276C6164C3D97D78D2@PH8PR11MB6803.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=unh.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8P223MB0383:EE_|SJ5PPF6327F1ED3:EE_
x-ms-office365-filtering-correlation-id: a2421719-070e-4e88-5a2e-08dd8a65dde4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018|13003099007|8096899003|7053199007;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?gfRIfIb795VkLBBp9xu7e/J1j46XUrjTsTLE77OiXz8DqpNhz76KV6pTCL?=
 =?iso-8859-1?Q?tCNi9seD1vKxBHbjyPgDJugSzFdK/7YDhWXKDOYKQaSj+oMzFmcTFiTP7u?=
 =?iso-8859-1?Q?60dOWmKwOxTgYMQQUc4/rBzUh0aKF0WtaX5T1r7SaaMhAX9JNkg8X6DToa?=
 =?iso-8859-1?Q?hOAu4tox4FAmTYfrbgAd++lg34Z1fe1WGyChSLlMKVr3eGOuhKKfDO6dCy?=
 =?iso-8859-1?Q?AuXifhdjK/txus9x8rOtmhZPDFPWtHfsmU9Ryzm3WmGjj1OFloAbgSGsi9?=
 =?iso-8859-1?Q?t+tYcd5C+motobjEUI82or7l7Yh1HfGABntKXlVQr2smwuByQOrgTX0Q9F?=
 =?iso-8859-1?Q?KGiACALbOdUW4ANrGuv3fZRrE4Z+fFHEM5+xk6lapBs/b8vQhUCaLmHYoU?=
 =?iso-8859-1?Q?/T+6Hn0pz6n0NnWdjpsN4Z/JLUbwvkIewK4GrMg3TWckSqA5iaqnkfh+jv?=
 =?iso-8859-1?Q?xwXLM9TcMwNk1cVeRUpFZ06Xwquc3FBp1L598Kq3zW8r/PatMiRfN7vvWB?=
 =?iso-8859-1?Q?vJbi913FdNQF3V08jajQ+FhIls2nW5k9TufeXdVkpTHf+z89jiDfC0Cnyb?=
 =?iso-8859-1?Q?yCZ4bZA/I2yfElZB7zCOg40kpSVfzH52MGi4uRVW6nnEAxHq//vPaEB8fg?=
 =?iso-8859-1?Q?BCL3QpzSQGVFTKb2pkgUcnh41ENoGXq6dKWDW/9ppkVH7jnE2oBIE1xIv9?=
 =?iso-8859-1?Q?8Tbzc6UYpSUlA+RtoktcrdicTjf99fqoBEIQ4/cBUXtbX/HifxapL5a/2q?=
 =?iso-8859-1?Q?HShtPIowaU8Xv+d6LwmXp9ypBWUFsn/r0kDehgjMU0PSrLtQ6E74bWvmub?=
 =?iso-8859-1?Q?A8IgyCbHCqV/9AAWldOohk5N3ElbfIrcIqssR7R4lcARDt45GUPBPBkLmu?=
 =?iso-8859-1?Q?ZZC35fqCkW3o3+fTXcLylnSNz2+jraiB4UpnMdk71LWEnv4p5bTr0tdRRf?=
 =?iso-8859-1?Q?OKalWwco1oTVDF5qrXh4KpXqm2h8nB0WiPYE+o0ooW6zHZILAc/So70Yqx?=
 =?iso-8859-1?Q?XxqzGi7g8kU5p3bcSxhHE2klS3QewvPcEAsXVCwHM0ZNgcgJWoYy4JDQhO?=
 =?iso-8859-1?Q?ghRIbmk99osGkhHhyqKsLsM6Aa1ETc19rA2Rpo/zk7MJnLG9o4fASeH7zw?=
 =?iso-8859-1?Q?GfxlKqDaEc4Anhs4A9wj7nBb28tZKMymAV0IdZ7o9mkenRHtuxgSVLwmyp?=
 =?iso-8859-1?Q?OClhLOKkeslTIh7uIru3HXMoReWvErODKM1Tdk0L8NAnjKee7ccVw088Pb?=
 =?iso-8859-1?Q?dPVdYOEpGyAT07RtirmtDK+xZd2qc9otIblopdER4x9OyVBwwoEXPmc/+V?=
 =?iso-8859-1?Q?KsSuLxQTwdQgxlV76HjU6ZPdVjXxghTt4cyTyja1xWr7AJmsQOAXDtJlRM?=
 =?iso-8859-1?Q?iEzKe0Hk1t6bsFi+1nJ+WsonluUNAAgLo2/CoDqKjLNNnXVIBsJrihrhRi?=
 =?iso-8859-1?Q?Yjj4To1H46cnaiSdvxvwXxRly8+aXdMNvbJtD8J05yvoVIElYuI8uAVApC?=
 =?iso-8859-1?Q?A=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8P223MB0383.NAMP223.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(13003099007)(8096899003)(7053199007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?A457S9RcF+ZudOeA152Lti6TTyHbv0XWo9JBcNYo3IgGcDaCuk8MUC7c4x?=
 =?iso-8859-1?Q?tf1fHTYOhT5x49uI2FPjDmGxyPPdpeZNbXinrd4uzXwjzj0omx9ryx8a7T?=
 =?iso-8859-1?Q?PrrfPZ7XaHzAeggPQ8AR39//DmprtA/30aj9I6mcIXdKBM43rKaTGWa+gy?=
 =?iso-8859-1?Q?j6hc3zPMx5kXknmW2vJASDh9kYhwkGlzeq2gkBSiF1V0iL/TVQ4XoPlT8u?=
 =?iso-8859-1?Q?TpPLHEEg6xcqJWWHgV31BkIRoyF+KF1JwUgeY/MpPXljQak1Lm/NWoZfcF?=
 =?iso-8859-1?Q?NP7gB766aEaHpKGja7Bk8HnFxPPEmTlr/pIlxIclf0ECn74tJWF/8j0CLH?=
 =?iso-8859-1?Q?Y6XdNhFWS6Z5Dizmxt3f2B/8cd22Ct/lfaknIWwWzIifTe87wbNZ/hdEkB?=
 =?iso-8859-1?Q?kgMkrROjq8qqG6LEn44NxsPvDrUIIzaQ9ueD0oOowsciVylWI13il3Zmxk?=
 =?iso-8859-1?Q?t5dtNyRIF9ayJWtq6wi8i/8CL+ZnwFkPH3poFr78LG4F7XTGwURDKgr4pb?=
 =?iso-8859-1?Q?+Dg49USNkKb2sbHzaGgN2RW03QHxtObl5QkDQFHTDkOS4qEJKOY+IfPEr/?=
 =?iso-8859-1?Q?Tf862dsCJAtnmYYumCSBZUGhlgpPBB6LeEemFnZ9NzbFzNHYO2Ilgxv2Pq?=
 =?iso-8859-1?Q?U6Pxg6EBxl1eX3K3Z+XRC4kzwuYa+0VNAKizo5qQeu1o79I1Vvo8r/uOxG?=
 =?iso-8859-1?Q?JgdocSWmWAEXOLtEmgNXFVtAUHfL+KSHvhCpe4gmPQz5g/h5cV6WQcvrjU?=
 =?iso-8859-1?Q?2EIW7pk5gtZo+k+yF9R16jvD2XCneKS+8S0LwRKH74HMMk3HsXxPSmZwUs?=
 =?iso-8859-1?Q?Dz1rY2GBqixeAu7GdNFkQubbfnuv4DYcj6zdIEMzaTEhhfNRezE7qUWBHX?=
 =?iso-8859-1?Q?HIUp7FQtRT7JQcmMS2GMgQzRakYhhbu26Nk50NVNS7XErAkfB2PHn80yQE?=
 =?iso-8859-1?Q?mLtzcjCFXe6v3SU2vIz+k0KujmsV+RpLXldmOsYRYKDjBAQghfF4V5V1ZV?=
 =?iso-8859-1?Q?h+sHYChaK+uqEh94filnB0ALjygFXMcfBFqO+e41zegOtC6/yCDDz5TtSS?=
 =?iso-8859-1?Q?XE1OfUlx3yzPK0rNpHGG3PLdB/AjgZP653TpJgf9UultBISE8UZFkha/vW?=
 =?iso-8859-1?Q?pU/YDkAAH2e/Zi41KRahxYmr9STz5ty8QV308TW9TBNUGydR4+04O0kW76?=
 =?iso-8859-1?Q?arldzildjuH2F5gghO9ujddbEviSDQCUNo2421fFdqAX3zDnsnKyA6m0L5?=
 =?iso-8859-1?Q?KR/MgU1vpxUbOR0K7xrSdkp6egO/bkFnqAAbOIoL4AijeTCXJrH2Kom/fu?=
 =?iso-8859-1?Q?YIAXUWfmc1gPxog2kRAdofVRs4xw1r0uap7B+/KtPu0gLC1hvpSyP9ESH2?=
 =?iso-8859-1?Q?LaV03EQCHvohbIJVN4Xyx6sjzQeEmBhJabpxIVHpJ6oB3mpi581YRj4umR?=
 =?iso-8859-1?Q?/5tqyFzYiYeDc0/pjHRJ4/MzgHzpCemhGCAlAYt6LeExsL4d2ZwTAz4kjw?=
 =?iso-8859-1?Q?bpWsyNdMX3gpLXaMpm3qq/sFWrmME1bqzGP60L4C4SZU4vifckl/d+Pgqw?=
 =?iso-8859-1?Q?y5dJrHeHvbg9Rnl3Ndgk0vqqx/1P8wrbUzR8Dx4eM/5noNFExRj8gsfzKq?=
 =?iso-8859-1?Q?ndSy8VxD5a3nA=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM8P223MB038323681A4BEA771CF92A6D8D8D2DM8P223MB0383NAMP_"
MIME-Version: 1.0
X-OriginatorOrg: unh.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8P223MB0383.NAMP223.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a2421719-070e-4e88-5a2e-08dd8a65dde4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2025 17:13:47.5394 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d6241893-512d-46dc-8d2b-be47e25f5666
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S5BjEf2AwAucUAOMhUtWxRaQF/IAPtcvqaEtROAVhCT1n9qwwNiq8uouRUmCghuD+mYP++Q8FPIxix/2c/+8pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF6327F1ED3
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

--_000_DM8P223MB038323681A4BEA771CF92A6D8D8D2DM8P223MB0383NAMP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

From: Van Haaren, Harry <harry.van.haaren@intel.com>
Sent: Friday, May 2, 2025 9:58 AM
To: Etelson, Gregory <getelson@nvidia.com>; Richardson, Bruce <bruce.richar=
dson@intel.com>
Cc: dev@dpdk.org <dev@dpdk.org>; Owen Hilyard <owen.hilyard@unh.edu>
Subject: Re: [PATCH] rust: RFC/demo of safe API for Dpdk Eal, Eth and Rxq

> From: Etelson, Gregory
> Sent: Friday, May 02, 2025 1:46 PM
> To: Richardson, Bruce
> Cc: Gregory Etelson; Van Haaren, Harry; dev@dpdk.org; owen.hilyard@unh.ed=
u
> Subject: Re: [PATCH] rust: RFC/demo of safe API for Dpdk Eal, Eth and Rxq
>
> Hello Bruce,

Hi All,
Hi All,

> > Thanks for sharing. However, IMHO using EAL for thread management in ru=
st
> > is the wrong interface to expose.
>
> EAL is a singleton object in DPDK architecture.
> I see it as a hub for other resources.

Yep, i tend to agree here; EAL is central to the rest of DPDK working corre=
ctly.
And given EALs implementation is heavily relying on global static variables=
, it is
certainly a "singleton" instance, yes.
I think a singleton one way to implement this, but then you lose some of th=
e RAII/automatic resource management behavior. It would, however, make some=
 APIs inherently unsafe or very unergonomic unless we were to force rte_eal=
_cleanup to be run via atexit(3) or the platform equivalent and forbid the =
user from running it themselves. For a lot of Rust runtimes similar to the =
EAL (tokio, glommio, etc), once you spawn a runtime it's around until proce=
ss exit. The other option is to have a handle which represents the state of=
 the EAL on the Rust side and runs rte_eal_init on creation and rte_eal_cle=
anup on destruction. There are two ways we can make that safe. First, refer=
ence counting, once the handles are created, they can be passed around easi=
ly, and the last one runs rte_eal_cleanup when it gets dropped.  This avoid=
s having tons of complicated lifetimes and I think that, everywhere that it=
 shouldn't affect fast path performance, we should use refcounting. The oth=
er option is to use lifetimes. This is doable, but is going to force people=
 who are more likely to primarily be C or C++ developers to dive deep into =
Rust's type system if they want to build abstractions over it. If we add as=
ync into the mix, as many people are going to want to do, it's going to bec=
ome much, much harder. As a result, I'd advocate for only using it for data=
 path components where refcounting isn't an option.

> Following that idea, the EAL structure can be divided to hold the
> "original" resources inherited from librte_eal and new resources
> introduced in Rust EAL.

Here we can look from different perspectives. Should "Rust EAL" even exist?
If so, why? The DPDK C APIs were designed in baremetal/linux days, where
certain "best-practices" didn't exist yet, and Rust language was pre 1.0 re=
lease.

Of course, certain parts of Rust API must depend on EAL being initialized.
There is a logical flow to DPDK initialization, these must be kept for corr=
ect functionality.

I guess I'm saying, perhaps we can do better than mirroring the concept of
"DPDK EAL in C" in to "DPDK EAL in Rust".

I think that there will need to be some kind of runtime exposed by the libr=
ary. A lot of the existing EAL abstractions may need to be reworked, especi=
ally those dealing with memory, but I think a lot of things can be layered =
on top of the C API. However, I think many of the invariants in the EAL cou=
ld be enforced at compile time for free, which may mean the creation of a l=
ot of "unchecked" function variants which skip over null checks and other v=
alidation.

As was mentioned before, it may also make sense for some abstractions in th=
e C EAL to be lifted to compile time. I've spent a lot of time thinking abo=
ut how to use something like Rust's traits for "it just works" capabilities=
 where you can declare what features you want (ex: scatter/gather) and it w=
ill either be done in hardware or fall back to software, since you were goi=
ng to need to do it anyway. This might lead to parameterizing a lot of user=
 code on the devices they expect to interact with and then having some "dyn=
 EthDev" as a fallback, which should be roughly equivalent to what we have =
now. I can explain that in more detail if there's interest.

> > Instead, I believe we should be
> > encouraging native rust thread management, and not exposing any DPDK
> > threading APIs except those necessary to have rust threads work with DP=
DK,
> > i.e. with an lcore ID. Many years ago when DPDK started, and in the C
> > world, having DPDK as a runtime environment made sense, but times have
> > changed and for Rust, there is a whole ecosystem out there already that=
 we
> > need to "play nice with", so having Rust (not DPDK) do all thread
> > management is the way to go (again IMHO).
> >
>
> I'm not sure what exposed DPDK API you refer to.

I think that's the point :) Perhaps the Rust application should decide how/=
when to
create threads, and how to schedule & pin them. Not the "DPDK crate for Rus=
t".
To give a more concrete examples, lets look at Tokio (or Monoio, or Glommio=
, or .. )
which are prominent players in the Rust ecosystem, particularly for network=
ing workloads
where request/response patterns are well served by the "async" programming =
model (e.g HTTP server).
Rust doesn't really care about threads that much. Yes, it has std::thread a=
s a pthread equivalent, but on Linux those literally call pthread. Enforcin=
g the correctness of the Send and Sync traits (responsible for helping enfo=
rce thread safety) in APIs is left to library authors. I've used Rust with =
EAL threads and it's fine, although a slightly nicer API for launching base=
d on a closure (which is a function pointer and a struct with the captured =
inputs) would be nice. In Rust, I'd say that async and threads are orthogon=
al concepts, except where runtimes force them to mix. Async is a way to wri=
te a state machine or (with some more abstraction) an execution graph, and =
Rust the language doesn't care whether a library decides to run some depend=
encies in parallel. What I think Rust is more likely to want is thread per =
core and then running either a single async runtime over all of them or an =
async runtime per core.

Lets focus on Tokio first: it is an "async runtime" (two links for future r=
eaders)
    <snip>
So an async runtime can run "async" Rust functions (called Futures, or Task=
s when run independently..)
There are lots of words/concepts, but I'll focus only on the thread creatio=
n/control aspect, given the DPDK EAL lcore context.

Tokio is a work-stealing scheduler. It spawns "worker" threads, and then gi=
ves these "tasks"
to various worker cores (similar to how Golang does its work-stealing sched=
uling). Some
DPDK crate users might like this type of workflow, where e.g. RXQ polling i=
s a task, and the
"tokio runtime" figures out which worker to run it on. "Spawning" a task ca=
uses the "Future"
to start executing. (technical Rust note: notice the "Send" bound on Future=
: https://docs.rs/tokio/latest/tokio/task/fn.spawn.html )
The work stealing aspect of Tokio has also led to some issues in the Rust e=
cosystem. What it effectively means is that every "await" is a place where =
you might get moved to another thread. This means that it would be unsound =
to, for example, have a queue handle on devices without MT-safe queues unle=
ss we want to put a mutex on top of all of the device queues. I personally =
think this is a lot of the source of people thinking that Rust async is har=
d, because Tokio forces you to be thread safe at really weird places in you=
r code and has issues like not being able to hold a mutex over an await poi=
nt.

Other users might prefer the "thread-per-core" and CPU pinning approach (li=
ke DPDK itself would do).
nit: Tokio also spawns a thread per core, it just freely moves tasks betwee=
n cores. It doesn't pin because it's designed to interoperate with the norm=
al kernel scheduler more nicely. I think that not needing pinned cores is n=
ice, but we want the ability to pin for performance reasons, especially on =
NUMA/NUCA systems (NUCA =3D Non-Uniform Cache Architecture, almost every AM=
D EPYC above 8 cores, higher core count Intel Xeons for 3 generations, etc)=
.
Monoio and Glommio both serve these use cases (but in slightly different wa=
ys!). They both spawn threads and do CPU pinning.
Monoio and Glommio say "tasks will always remain on the local thread". In R=
ust techie terms: "Futures are !Send and !Sync"
    https://docs.rs/monoio/latest/monoio/fn.spawn.html
    https://docs.rs/glommio/latest/glommio/fn.spawn_local.html
There is also another option, one which would eliminate "service cores". We=
 provide both a work stealing pool of tasks that have to deal with being ya=
nked between cores/EAL threads at any time, but aren't data plane tasks, an=
d then a different API for spawning tasks onto the local thread/core for da=
ta plane tasks (ex: something to manage a particular HTTP connection). This=
 might make writing the runtime harder, but it should provide the best of b=
oth worlds provided we can build in a feature (Rust provides a way to "ifde=
f out" code via features) to disable one or the other if someone doesn't wa=
nt the overhead.

So there are at least 3 different async runtimes (and I haven't even talked=
 about async-std, smol, embassy, ...) which
all have different use-cases, and methods of running "tasks" on threads. Th=
ese runtimes exist, and are widely used,
and applications make use of their thread-scheduling capabilities.

So "async runtimes" do thread creation (and optionally CPU pinning) for the=
 user.
Other libraries like "Rayon" are thread-pool managers, those also have vari=
ous CPU thread-create/pinning capabilities.
If DPDK *also* wants to do thread creation/management and CPU-thread-to-cor=
e pinning for the user, that creates tension.
The other problem is that most of these async runtimes have IO very tightly=
 integrated into them. A large portion of Tokio had to be forked and rewrit=
ten for io_uring support, and DPDK is a rather stark departure from what th=
ey were all designed for. I know that both Tokio and Glommio have "start a =
new async runtime on this thread" functions, and I think that Tokio has an =
"add this thread to a multithreaded runtime" somewhere.

I think the main thing that DPDK would need to be concerned about is that m=
any of these runtimes use thread locals, and I'm not sure if that would be =
transparently handled by the EAL thread runtime since I've always used thre=
ad per core and then used the Rust runtime to multiplex between tasks inste=
ad of spawning more EAL threads.

Rayon should probably be thought of in a similar vein to OpenMP, since it's=
 mainly designed for batch processing. Unless someone is doing some fairly =
heavy computation (the kind where "do we want a GPU to accelerate this?" be=
comes a question) inside of their DPDK application, I'm having trouble thin=
king of a use case that would want both DPDK and Rayon.

> Bruce wrote: "so having Rust (not DPDK) do all thread management is the w=
ay to go (again IMHO)."

I think I agree here, in order to make the Rust DPDK crate usable from the =
Rust ecosystem,
it must align itself with the existing Rust networking ecosystem.

That means, the DPDK Rust crate should not FORCE the usage of lcore pinning=
s and mappings.
Allowing a Rust application to decide how to best handle threading (via Ray=
on, Tokio, Monoio, etc)
will allow much more "native" or "ergonomic" integration of DPDK into Rust =
applications.
I'm not sure that using DPDK from Rust will be possible without either seri=
ous performance sacrifices or rewrites of a lot of the networking libraries=
. Tokio continues to mimic the BSD sockets API for IO, even with the io_uri=
ng version, as does glommio. The idea of the "recv" giving you a buffer wit=
hout you passing one in isn't really used outside of some lower-level io_ur=
ing crates. At a bare minimum, even if DPDK managed to offer an API that wo=
rks exactly the same ways as io_uring or epoll, we would still need to go t=
o all of the async runtimes and get them to plumb DPDK support in or approv=
e someone from the DPDK community maintaining support. If we don't offer th=
at API, then we either need rewrites inside of the async runtimes or for in=
dividual libraries to provide DPDK support, which is going to be even more =
difficult.

I agree that forcing lcore pinnings and mappings isn't good, but I think th=
at DPDK is well within its rights to build its own async runtime which expo=
ses a standard API. For one thing, the first thing Rust users will ask for =
is a TCP stack, which the community has been discussing and debating for a =
long time. I think we should figure out whether the goal is to allow DPDK a=
pplications to be written in Rust, or to allow generic Rust applications to=
 use DPDK. The former means that the audience would likely be Rust-fluent p=
eople who would have used DPDK regardless, and are fine dealing with mempoo=
ls, mbufs, the eal, and ethdev configuration. The latter is a much larger a=
udience who is likely going to be less tolerant of dpdk-rs exposing the tru=
e complexity of using DPDK. Yes, Rust can help make the abstractions better=
, but there's an amount of inherent complexity in "Your NIC can handle IPSe=
c for you and can also direct all IPv6 traffic to one core" that I don't th=
ink we can remove.

I personally think that making an API for DPDK applications to be written i=
n Rust, and then steadily adding abstractions on top of that until we arriv=
e at something that someone who has never looked at a TCP header can use wi=
thout too much confusion. That was part of the goal of the Iris project I p=
itched (and then had to go finish another project so the design is still WI=
P). I think that a move to DPDK is going to be as radical of a change as a =
move to io_uring, however, DPDK is fast enough that I think it may be possi=
ble to convince people to do a rewrite once we arrive at that high level AP=
I. "Swap out your sockets and rework the functions that do network IO for a=
 5x performance increase" is a very, very attractive offer, but for us to g=
et there I think we need to have DPDK's full potential available in Rust, a=
nd then build as many zero-overhead (zero cost or you couldn't write it bet=
ter yourself) abstractions as we can on top. I want to avoid a situation wh=
ere we build up to the high-level APIs as fast as we can and then end up in=
 a situation where you have "Easy Mode" and then "C DPDK written in Rust" a=
s your two options.
> Regards,
> Gregory

Apologies for the long-form, "wall of text" email, but I hope it captures t=
he nuance of threading and
async runtimes, which I believe in the long term will be very nice to captu=
re "async offload" use-cases
for DPDK. To put it another way, lookaside processing can be hidden behind =
async functions & runtimes,
if we design the APIs right: and that would be really cool for making async=
-offload code easy to write correctly!

Regards, -Harry

Sorry for my own walls of text. As a consequence of working on Iris I've sp=
ent a lot of time thinking about how to make DPDK easier to use while keepi=
ng the performance intact, and I was already thinking in Rust since it prov=
ides one of the better options for these kinds of abstractions (the other o=
ption I see is Mojo, which isn't ready yet). I want to see DPDK become more=
 accessible, but the performance and access to hardware is one of the main =
things that make DPDK special, so I don't want to compromise that. I defini=
tely agree that we need to force DPDK's existing APIs to justify themselves=
 in the face of the new capabilities of Rust, but I think that starting fro=
m "How are Rust applications written today?" is a mistake.

Regards,
Owen

--_000_DM8P223MB038323681A4BEA771CF92A6D8D8D2DM8P223MB0383NAMP_
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
<div id=3D"appendonsend"></div>
<blockquote style=3D"margin-left: 0.8ex; padding-left: 1ex; border-left: 3p=
x solid rgb(200, 200, 200);">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
From:&nbsp;Van Haaren, Harry &lt;harry.van.haaren@intel.com&gt;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Sent:&nbsp;Friday, May 2, 2025 9:58 AM</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
To:&nbsp;Etelson, Gregory &lt;getelson@nvidia.com&gt;; Richardson, Bruce &l=
t;bruce.richardson@intel.com&gt;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Cc:&nbsp;dev@dpdk.org &lt;dev@dpdk.org&gt;; Owen Hilyard &lt;owen.hilyard@u=
nh.edu&gt;</div>
</blockquote>
<div id=3D"divRplyFwdMsg" dir=3D"ltr" class=3D"elementToProof">
<blockquote style=3D"margin-left: 0.8ex; padding-left: 1ex; border-left: 3p=
x solid rgb(200, 200, 200);">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Subject:&nbsp;Re: [PATCH] rust: RFC/demo of safe API for Dpdk Eal, Eth and =
Rxq</div>
</blockquote>
</div>
<blockquote style=3D"margin-left: 0.8ex; padding-left: 1ex; border-left: 3p=
x solid rgb(200, 200, 200);">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&gt; From: Etelson, Gregory</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&gt; Sent: Friday, May 02, 2025 1:46 PM</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&gt; To: Richardson, Bruce</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&gt; Cc: Gregory Etelson; Van Haaren, Harry; dev@dpdk.org; owen.hilyard@unh=
.edu</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&gt; Subject: Re: [PATCH] rust: RFC/demo of safe API for Dpdk Eal, Eth and =
Rxq</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&gt;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&gt; Hello Bruce,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Hi All,</div>
</blockquote>
<div class=3D"elementToProof" style=3D"font-size: 11pt;">Hi All,</div>
<blockquote style=3D"margin-left: 0.8ex; padding-left: 1ex; border-left: 3p=
x solid rgb(200, 200, 200);">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&gt; &gt; Thanks for sharing. However, IMHO using EAL for thread management=
 in rust</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&gt; &gt; is the wrong interface to expose.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&gt;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&gt; EAL is a singleton object in DPDK architecture.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&gt; I see it as a hub for other resources.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Yep, i tend to agree here; EAL is central to the rest of DPDK working corre=
ctly.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
And given EALs implementation is heavily relying on global static variables=
, it is</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
certainly a &quot;singleton&quot; instance, yes.</div>
</blockquote>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
I think a singleton one way to implement this, but then you lose some of th=
e RAII/automatic resource management behavior. It would, however, make some=
 APIs inherently unsafe or very unergonomic unless we were to force rte_eal=
_cleanup to be run via atexit(3)
 or the platform equivalent and forbid the user from running it themselves.=
 For a lot of Rust runtimes similar to the EAL (tokio, glommio, etc), once =
you spawn a runtime it's around until process exit. The other option is to =
have a handle which represents the
 state of the EAL on the Rust side and runs rte_eal_init on creation and rt=
e_eal_cleanup on destruction. There are two ways we can make that safe. Fir=
st, reference counting, once the handles are created, they can be passed ar=
ound easily, and the last one runs
 rte_eal_cleanup when it gets dropped.&nbsp; This avoids having tons of com=
plicated lifetimes and I think that, everywhere that it shouldn't affect fa=
st path performance, we should use refcounting. The other option is to use =
lifetimes. This is doable, but is going
 to force people who are more likely to primarily be C or C++ developers to=
 dive deep into Rust's type system if they want to build abstractions over =
it. If we add async into the mix, as many people are going to want to do, i=
t's going to become much, much harder.
 As a result, I'd advocate for only using it for data path components where=
 refcounting isn't an option.&nbsp;</div>
<blockquote style=3D"margin-left: 0.8ex; padding-left: 1ex; border-left: 3p=
x solid rgb(200, 200, 200);">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&gt; Following&nbsp;that idea, the EAL structure can be divided to hold the=
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&gt; &quot;original&quot; resources inherited from librte_eal and new resou=
rces</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&gt; introduced in Rust EAL.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Here we can look from different perspectives. Should &quot;Rust EAL&quot; e=
ven exist?</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
If so, why? The DPDK C APIs were designed in&nbsp;baremetal/linux days, whe=
re</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
certain &quot;best-practices&quot; didn't exist yet, and Rust language was =
pre 1.0 release.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Of course, certain parts of Rust API must depend on EAL being initialized.<=
/div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
There is a logical flow to DPDK initialization, these must be kept for corr=
ect functionality.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
I guess I'm saying, perhaps we can do better than mirroring the concept of<=
/div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&quot;DPDK EAL in C&quot; in to &quot;DPDK EAL in Rust&quot;.</div>
</blockquote>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
I think that there will need to be some kind of runtime exposed by the libr=
ary. A lot of the existing EAL abstractions may need to be reworked, especi=
ally those dealing with memory, but I think a lot of things can be layered =
on top of the C API. However, I
 think many of the invariants in the EAL could be enforced at compile time =
for free, which may mean the creation of a lot of &quot;unchecked&quot; fun=
ction variants which skip over null checks and other validation.<br>
<br>
As was mentioned before, it may also make sense for some abstractions in th=
e C EAL to be lifted to compile time. I've spent a lot of time thinking abo=
ut how to use something like Rust's traits for &quot;it just works&quot; ca=
pabilities where you can declare what features
 you want (ex: scatter/gather) and it will either be done in hardware or fa=
ll back to software, since you were going to need to do it anyway. This mig=
ht lead to parameterizing a lot of user code on the devices they expect to =
interact with and then having some
 &quot;dyn EthDev&quot; as a fallback, which should be roughly equivalent t=
o what we have now. I can explain that in more detail if there's interest.<=
br>
<br>
</div>
<blockquote style=3D"margin-left: 0.8ex; padding-left: 1ex; border-left: 3p=
x solid rgb(200, 200, 200);">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&gt; &gt; Instead, I believe we should be</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&gt; &gt; encouraging native rust thread management, and not exposing any D=
PDK</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&gt; &gt; threading APIs except those necessary to have rust threads work w=
ith DPDK,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&gt; &gt; i.e. with an lcore ID. Many years ago when DPDK started, and in t=
he C</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&gt; &gt; world, having DPDK as a runtime environment made sense, but times=
 have</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&gt; &gt; changed and for Rust, there is a whole ecosystem out there alread=
y that we</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&gt; &gt; need to &quot;play nice with&quot;, so having Rust (not DPDK) do =
all thread</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&gt; &gt; management is the way to go (again IMHO).</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&gt; &gt;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&gt;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&gt; I'm not sure what exposed DPDK API you refer to.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
I think that's the point :) Perhaps the Rust application should decide how/=
when to</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
create threads, and how to schedule &amp; pin them. Not the &quot;DPDK crat=
e for Rust&quot;.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
To give a more concrete examples, lets look at Tokio (or Monoio, or Glommio=
, or .. )</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
which are prominent players in the Rust ecosystem, particularly for network=
ing workloads</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
where request/response patterns are well served by the &quot;async&quot; pr=
ogramming model (e.g HTTP server).</div>
</blockquote>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Rust doesn't really care about threads that much. Yes, it has std::thread a=
s a pthread equivalent, but on Linux those literally call pthread. Enforcin=
g the correctness of the Send and Sync traits (responsible for helping enfo=
rce thread safety) in APIs is left
 to library authors. I've used Rust with EAL threads and it's fine, althoug=
h a slightly nicer API for launching based on a closure (which is a functio=
n pointer and a struct with the captured inputs) would be nice. In Rust, I'=
d say that async and threads are
 orthogonal concepts, except where runtimes force them to mix. Async is a w=
ay to write a state machine or (with some more abstraction) an execution gr=
aph, and Rust the language doesn't care whether a library decides to run so=
me dependencies in parallel. What
 I think Rust is more likely to want is thread per core&nbsp;and then runni=
ng either a single async runtime over all of them or an async runtime per c=
ore.</div>
<blockquote style=3D"margin-left: 0.8ex; padding-left: 1ex; border-left: 3p=
x solid rgb(200, 200, 200);">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Lets focus on Tokio first: it is an &quot;async runtime&quot; (two links fo=
r future readers)</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp;&nbsp;&nbsp; &lt;snip&gt;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
So an async runtime can run &quot;async&quot; Rust functions (called Future=
s, or Tasks when run independently..)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
There are lots of words/concepts, but I'll focus only on the thread creatio=
n/control aspect, given the DPDK EAL lcore context.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Tokio is a work-stealing scheduler. It spawns &quot;worker&quot; threads, a=
nd then gives these &quot;tasks&quot;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
to various worker cores (similar to how Golang does&nbsp;its work-stealing =
scheduling). Some</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
DPDK crate users might like this type of workflow, where e.g. RXQ polling i=
s a task, and the</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&quot;tokio runtime&quot; figures out which worker to run it on. &quot;Spaw=
ning&quot; a task causes the &quot;Future&quot;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
to start executing. (technical Rust note: notice the &quot;Send&quot; bound=
 on Future: <a href=3D"https://docs.rs/tokio/latest/tokio/task/fn.spawn.htm=
l" id=3D"LPlnk652562" class=3D"OWAAutoLink">
https://docs.rs/tokio/latest/tokio/task/fn.spawn.html</a>&nbsp;)</div>
</blockquote>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
The work stealing aspect of Tokio has also led to some issues in the Rust e=
cosystem. What it effectively means is that every &quot;await&quot; is a pl=
ace where you might get moved to another thread. This means that it would b=
e unsound to, for example, have a queue handle
 on devices without MT-safe queues unless we want to put a mutex on top of =
all of the device queues. I personally think this is a lot of the source of=
 people thinking that Rust async is hard, because Tokio forces you to be th=
read safe at really weird places
 in your code and has issues like not being able to hold a mutex over an aw=
ait point.<br>
<br>
</div>
<blockquote style=3D"margin-left: 0.8ex; padding-left: 1ex; border-left: 3p=
x solid rgb(200, 200, 200);">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Other users might prefer the &quot;thread-per-core&quot; and CPU pinning ap=
proach (like DPDK itself would do).</div>
</blockquote>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
nit: Tokio also spawns a thread per core, it just freely moves tasks betwee=
n cores. It doesn't pin because it's designed to interoperate with the norm=
al kernel scheduler more nicely. I think that not needing pinned cores is n=
ice, but we want the ability to
 pin for performance reasons, especially on NUMA/NUCA systems (NUCA =3D Non=
-Uniform Cache Architecture, almost every AMD EPYC above 8 cores, higher co=
re count Intel Xeons for 3 generations, etc).</div>
<blockquote style=3D"margin-left: 0.8ex; padding-left: 1ex; border-left: 3p=
x solid rgb(200, 200, 200);">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Monoio and Glommio both serve these use cases (but in slightly different wa=
ys!). They both spawn threads and do CPU pinning.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Monoio and Glommio say &quot;tasks will always remain on the local thread&q=
uot;. In Rust techie terms: &quot;Futures are !Send and !Sync&quot;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp;&nbsp;&nbsp; <a href=3D"https://docs.rs/monoio/latest/monoio/fn.spawn=
.html" id=3D"LPlnk846468" class=3D"OWAAutoLink">
https://docs.rs/monoio/latest/monoio/fn.spawn.html</a></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp;&nbsp;&nbsp; <a href=3D"https://docs.rs/glommio/latest/glommio/fn.spa=
wn_local.html" id=3D"LPlnk988575" class=3D"OWAAutoLink">
https://docs.rs/glommio/latest/glommio/fn.spawn_local.html</a></div>
</blockquote>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
There is also another option, one which would eliminate &quot;service cores=
&quot;. We provide both a work stealing pool of tasks that have to deal wit=
h being yanked between cores/EAL threads at any time, but aren't data plane=
 tasks, and then a different API for spawning
 tasks onto the local thread/core for data plane tasks (ex: something to ma=
nage a particular HTTP connection). This might make writing the runtime har=
der, but it should provide the best of both worlds provided we can build in=
 a feature (Rust provides a way
 to &quot;ifdef out&quot; code via features) to disable one or the other if=
 someone doesn't want the overhead.</div>
<blockquote style=3D"margin-left: 0.8ex; padding-left: 1ex; border-left: 3p=
x solid rgb(200, 200, 200);">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
So there are at least 3 different async runtimes (and I haven't even talked=
 about async-std, smol, embassy, ...) which</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
all have different use-cases, and methods of running &quot;tasks&quot; on t=
hreads. These runtimes exist, and are widely used,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
and applications make use of their thread-scheduling capabilities.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
So &quot;async runtimes&quot; do thread creation (and optionally CPU pinnin=
g) for the user.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Other libraries like &quot;Rayon&quot; are thread-pool managers, those also=
 have various CPU thread-create/pinning capabilities.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
If DPDK *also* wants to do thread creation/management and CPU-thread-to-cor=
e pinning for the user, that creates tension.</div>
</blockquote>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
The other problem is that most of these async runtimes have IO very tightly=
 integrated into them.&nbsp;A large portion of Tokio had to be forked and r=
ewritten for io_uring support, and DPDK is a rather stark departure&nbsp;fr=
om what they were all designed for. I know
 that both Tokio and Glommio have &quot;start a new async runtime on this t=
hread&quot; functions, and I think that Tokio has an &quot;add this thread =
to a multithreaded&nbsp;runtime&quot; somewhere.<br>
<br>
I think the main thing that DPDK would need to be concerned about is that m=
any of these runtimes use thread locals, and I'm not sure if that would be =
transparently handled by the EAL thread runtime since I've always used thre=
ad per core and then used the Rust
 runtime to multiplex between tasks instead of spawning more EAL threads.<b=
r>
<br>
Rayon should probably be thought of in a similar vein to OpenMP, since it's=
 mainly designed for batch processing. Unless someone is doing some fairly =
heavy computation (the kind where &quot;do we want a GPU to accelerate this=
?&quot; becomes a question) inside of their
 DPDK application, I'm having trouble thinking of a use case that would wan=
t both DPDK and Rayon.&nbsp;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<blockquote style=3D"margin-left: 0.8ex; padding-left: 1ex; border-left: 3p=
x solid rgb(200, 200, 200);">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&gt; Bruce wrote: &quot;so having Rust (not DPDK) do all thread management =
is the way to go (again IMHO).&quot;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
I think I agree here, in order to make the Rust DPDK crate usable from the =
Rust ecosystem,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
it must align itself with the existing Rust networking ecosystem.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
That means, the DPDK Rust crate should not FORCE the usage of lcore pinning=
s and mappings.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Allowing a Rust application to decide how to best handle threading (via Ray=
on, Tokio, Monoio, etc)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
will allow much more &quot;native&quot; or &quot;ergonomic&quot; integratio=
n of DPDK into Rust applications.</div>
</blockquote>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
I'm not sure that using DPDK from Rust will be possible without either seri=
ous performance sacrifices or rewrites of a lot of the networking libraries=
. Tokio continues to mimic the BSD sockets API for IO, even with the io_uri=
ng version, as does glommio. The
 idea of the &quot;recv&quot; giving you a buffer without you passing one i=
n isn't really used outside of some lower-level io_uring crates. At a bare =
minimum, even if DPDK managed to offer an API that works exactly the same w=
ays as io_uring or epoll, we would still need
 to go to all of the async runtimes and get them to plumb DPDK support in o=
r approve someone from the DPDK community maintaining support. If we don't =
offer that API, then we either need rewrites inside of the async runtimes o=
r for individual libraries to provide
 DPDK support, which is going to be even more difficult.<br>
<br>
I agree that forcing lcore pinnings and mappings isn't good, but I think th=
at DPDK is well within its rights to build its own async runtime which expo=
ses a standard API. For one thing, the first thing Rust users will ask for =
is a TCP stack, which the community
 has been discussing and debating for a long time. I think we should figure=
 out whether the goal is to allow DPDK applications to be written in Rust, =
or to allow generic Rust applications to use DPDK. The former means that th=
e audience would likely be Rust-fluent
 people who would have used DPDK regardless, and are fine dealing with memp=
ools, mbufs, the eal, and ethdev configuration. The latter is a much larger=
 audience who is likely going to be less tolerant of dpdk-rs exposing the t=
rue complexity of using DPDK. Yes,
 Rust can help make the abstractions better, but there's an amount of inher=
ent complexity in &quot;Your NIC can handle IPSec for you and can also dire=
ct all IPv6 traffic to one core&quot; that I don't think we can remove.&nbs=
p;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
I personally think that making an API for DPDK applications to be written i=
n Rust, and then steadily adding abstractions on top of that until we arriv=
e at something that someone who has never looked at a TCP header can use wi=
thout too much confusion. That was
 part of the goal of the Iris project I pitched (and then had to go finish =
another project so the design is still WIP). I think that a move to DPDK is=
 going to be as radical of a change as a move to io_uring, however, DPDK is=
 fast enough that I think it may
 be possible to convince people to do a rewrite once we arrive at that high=
 level API. &quot;Swap out your sockets and rework the functions that do ne=
twork IO for a 5x performance increase&quot;&nbsp;is a very, very attractiv=
e offer, but for us to get there I think we need
 to have DPDK's full potential available in Rust, and then build as many ze=
ro-overhead (zero cost or you couldn't write it better yourself) abstractio=
ns as we can on top. I want to avoid a situation where we build up to the h=
igh-level APIs as fast as we can
 and then end up in a situation where you have &quot;Easy Mode&quot; and th=
en &quot;C DPDK written in Rust&quot; as your two options.&nbsp;</div>
<blockquote style=3D"margin-left: 0.8ex; padding-left: 1ex; border-left: 3p=
x solid rgb(200, 200, 200);">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&gt; Regards,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
&gt; Gregory</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Apologies for the long-form, &quot;wall of text&quot; email, but I hope it =
captures the nuance of threading and</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
async runtimes, which I believe in the long term will be very nice to captu=
re &quot;async offload&quot; use-cases</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
for DPDK. To put it another way, lookaside processing can be hidden behind =
async functions &amp; runtimes,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
if we design the APIs right: and that would&nbsp;be really cool for making =
async-offload code easy to write correctly!</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Regards, -Harry<br>
<br>
</div>
</blockquote>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Sorry for my own walls of text. As a consequence of working on Iris I've&nb=
sp;spent a lot of time thinking about how to make DPDK easier to use while =
keeping the performance intact, and I was already thinking in Rust since it=
 provides one of the better options for
 these kinds of abstractions (the other option I see is Mojo, which isn't r=
eady yet). I want to see DPDK become more accessible, but the performance a=
nd access to hardware is one of the main things that make DPDK special, so =
I don't want to compromise that.
 I definitely agree that we need to force DPDK's existing APIs to justify t=
hemselves in the face of the new capabilities of Rust, but I think that sta=
rting from &quot;How are Rust applications written today?&quot; is a mistak=
e.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Owen</div>
</body>
</html>

--_000_DM8P223MB038323681A4BEA771CF92A6D8D8D2DM8P223MB0383NAMP_--
