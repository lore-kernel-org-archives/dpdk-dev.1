Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE0AC3601E
	for <dpdk-dev@archiver.kernel.org>; Sun, 13 Apr 2025 17:09:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA5CB40156;
	Sun, 13 Apr 2025 19:09:28 +0200 (CEST)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2091.outbound.protection.outlook.com [40.107.101.91])
 by mails.dpdk.org (Postfix) with ESMTP id E8ABB400D7
 for <dev@dpdk.org>; Sun, 13 Apr 2025 19:09:26 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IOwZ40APZBJpJ+oBdOHgZn+1ClB7sfiiNkE3NVa6gc8X38WOGuoiBBdRsMizJ2Wvd/rf6xnTyobXL4yRCFlkBKIASV/N6UiPZifrZhf79p3lsE8QW4iEVhGJGtVtwRvYY7z1dPfCuQFND+looxFm/8Q/s2uW3Q9oOSS5yENLeSgsgaR1KAS68S4xGFUSH6+uelx41+U0p+w/3i+52lNEFXpIUHxH760TTJerdhyuOlnS2oc8+GKha493UKGbaOaY0YrtIBchi3SQCFk6LKRFK5bQEz1wgo39lSmkmu39GB5u6G4E3eRnI2zPewWNEYIz2c9mFJZYjLwletNi3NoR0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ga9jdPXnqYcKWFfmDeYhfBr3a/tqID8W7wgmy/D8g+k=;
 b=UyPD78uywAt/dmL2VGt6BpA6td0EJ2U3fQF/KHnCMan555TsRB/WFTtYw54Y6M7fZwiAzxUciboj4eUK+nzwIdEuG5txKj48PgStBxVsm0zUmv8ura4qsE0Xer6+XBcwhD4vyeB1yCKpKJqi8Wu6vL+wg8oq8ELeZGnS3WYlNDznFwnV0oISgJzFmp98eCIOfUwjDPqiAJYtVn0RTIRJMKfD+CbBZI4/99q0b70mD1kjBqIc/kkKVHRTLw6wrOJRrxwwLBUp8+/pLlruVSIvdSQpFy02YLuUSNY5ZQ7lKEaBD0OPf2ICJLeesAVRlfyuqvQK9blb1rvWh8RMtCgVtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=unh.edu; dmarc=pass action=none header.from=unh.edu; dkim=pass
 header.d=unh.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unh.edu; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ga9jdPXnqYcKWFfmDeYhfBr3a/tqID8W7wgmy/D8g+k=;
 b=OXmAxMj1O/tb4aq9EYYZLK/4YsHcIHCCqm9ZNTxflPGHni6zdJ3biV/vzuetzUu0OlXr1IMhKJF8cNTlFpTWiQXBif8eRn6rCndVD0/GPikYKfui83T0ZPJsMjxubaXG5SjcBQpymjvJLbVvhqfykHgkECJbouYxsrL+ke/Lw2Y=
Received: from DM8P223MB0383.NAMP223.PROD.OUTLOOK.COM (2603:10b6:8:b::9) by
 BL4P223MB1387.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:5a9::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.32; Sun, 13 Apr 2025 17:09:22 +0000
Received: from DM8P223MB0383.NAMP223.PROD.OUTLOOK.COM
 ([fe80::e52:6031:810f:a743]) by DM8P223MB0383.NAMP223.PROD.OUTLOOK.COM
 ([fe80::e52:6031:810f:a743%4]) with mapi id 15.20.8632.024; Sun, 13 Apr 2025
 17:09:21 +0000
From: Owen Hilyard <Owen.Hilyard@unh.edu>
To: "Etelson, Gregory" <getelson@nvidia.com>, "Van Haaren, Harry"
 <harry.van.haaren@intel.com>
CC: "Richardson, Bruce" <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: Re: [RFC PATCH] add rust binding support to DPDK
Thread-Topic: [RFC PATCH] add rust binding support to DPDK
Thread-Index: AQHbqJbE9zt4u569OECnT87PltozubOcYZ4AgAIUIwCAACjEAIAADBcAgAKaSICAAIkFXg==
Date: Sun, 13 Apr 2025 17:09:21 +0000
Message-ID: <DM8P223MB0383C15F887791405AAD784A8DB02@DM8P223MB0383.NAMP223.PROD.OUTLOOK.COM>
References: <20250306133713.393057-1-getelson@nvidia.com>
 <20250408145838.2501034-1-bruce.richardson@intel.com>
 <187447a-fb49-2833-7e44-ad5bb0d67a99@nvidia.com>
 <PH8PR11MB6803EEFBDE79D34996494ADAD7B62@PH8PR11MB6803.namprd11.prod.outlook.com>
 <95367723-36f5-13a4-b513-27a7b4f7ee7c@nvidia.com>
 <PH8PR11MB6803A8EFAF0A3E8DA8211254D7B62@PH8PR11MB6803.namprd11.prod.outlook.com>
 <4bdd732d-03ed-3de1-e412-6d57a1b7a8e4@nvidia.com>
In-Reply-To: <4bdd732d-03ed-3de1-e412-6d57a1b7a8e4@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=unh.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8P223MB0383:EE_|BL4P223MB1387:EE_
x-ms-office365-filtering-correlation-id: 3ceaa8b7-e72b-4612-d1fa-08dd7aadef3e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|13003099007|8096899003; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?uaG/lx/UDuOnFUJzmi3qqfyvEcKNrpLgpfCLoN+JzAPrJwkDpeFOkRpDBU?=
 =?iso-8859-1?Q?PEk8Dqf7v+gT7HwGh7df0ZSTxclzFRyJ8cHZGB69v/lQPyepsVIPAtaesZ?=
 =?iso-8859-1?Q?RHzfKYT6QuUR5aOC3C+FV6Uz1cOyv9HISBvdiur8uF3oFy/H8otDbfanzw?=
 =?iso-8859-1?Q?LV7IYF/JSyUzVVDBsUg52NrBInUZUjMugBE8hXE6HWd4MYQ3H4z+qdI8hB?=
 =?iso-8859-1?Q?v7DqQ81ietiaKp9QkcukprUfL7vFtjSrDOoofrD5v0jRqWTgM1TTfHhYAq?=
 =?iso-8859-1?Q?sK0bYKe2T6ceX2KXkkh+vyUxDUt3+J6P7KZ+eRbdT+DAyVlYw3hpbAMGWt?=
 =?iso-8859-1?Q?7pN/Tggn1v+GcQ5BGNX2kotrYZLj7DklP8RiWWrGIw4ADPYQi6nzrnvD6B?=
 =?iso-8859-1?Q?CsrvvcJLkl98AedlXhMTDayeso21MEUsuGIxD89Uz7kgZhSF/nxU2jJsar?=
 =?iso-8859-1?Q?vGoHLzPfOGEWyYfSQuog63V7VNS7M3r3eoxz/+p7NjOq2pm9Tryl07fch+?=
 =?iso-8859-1?Q?u+qSNKEE/y0zScp6gLXLoeAnNde89e/Gwez+KeyQjMmAY/XPp2R5WArFUi?=
 =?iso-8859-1?Q?UoeXJavQakSs76SU+ZyYoZqETwVsNWBDADpmGIRqqGaQsXznOE655h1ZrM?=
 =?iso-8859-1?Q?b+lkZa1gG9YHraIdf/bIL+XwZpYZyZyk+rsPL0lhM51YZb+uJWCbeAdWy4?=
 =?iso-8859-1?Q?oblCHhF6tYNX390IlsN+qYtNhI9jL8c9ypERyZHjJKBeK/ZAsXz0a+R+5A?=
 =?iso-8859-1?Q?Y+D3vbOldHjPCBTxttW9ha3He58Sln7V2t/svlDIiK0mcMw4B6Xq6bnluV?=
 =?iso-8859-1?Q?ovGHAlI7YQEfVutUD9xIoc6zFOwhY2SchvB9enwTs5pb5tU9hSVwvGE1DJ?=
 =?iso-8859-1?Q?hgYTHcbiG+fS8el5DBpYTH8keXBWMppv7T1fDJSrJMmmxgsFZvIBnrtN29?=
 =?iso-8859-1?Q?VUbF/6x45zxEE24M/afCLs+HpS7Ap1dQsWxg/jrqJgeawNcVySuRS6b2lL?=
 =?iso-8859-1?Q?2Ytex0ilH0oQxRg7ojXr4arMv40DZ1ESX/t+YbYjINYTiVEnUgbIrd5wTC?=
 =?iso-8859-1?Q?8giOv3xCoI7bfVZQaoTeWN/m81oo/RHmCMwHDCLI7NBKxu8pepLmzGwUwN?=
 =?iso-8859-1?Q?B8yZNmt0udi5LAaCvEvdOv7Dt01v4dgVKupYpVgmBjlAdZUYbRrtP+6fgI?=
 =?iso-8859-1?Q?v+fbclAk53u0yRAMfrsVXS5ubVOgj69ePWKDCYVxbrT4R1VMZa/iNStGOX?=
 =?iso-8859-1?Q?5CbCyIfpwxeEBMzuCyaB9Y82w+U5fBDZdCzrQTvqcVbVrMHKJx7EeSSyfD?=
 =?iso-8859-1?Q?0bLfsqH47l79q70OkgS3oAOY2JZQ7TSzQVp7DB4nV4oNExbi35MzgrBZtM?=
 =?iso-8859-1?Q?rDWQo2wIqc6dmmiDFAc49qe7owuhdANnOKIHF74oejutTICytXnLuswe4t?=
 =?iso-8859-1?Q?fTFhigR7AbcBolHyMpvE6p1L128hmuI57uQ1U1H8qHmYhwdNQGrXVaWOvg?=
 =?iso-8859-1?Q?U=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8P223MB0383.NAMP223.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(13003099007)(8096899003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?sARl+A0AUILu9nZ7IaQt8rR34SRoK5WZNCWwm9ASMZw4H4ixChUsnpyn9x?=
 =?iso-8859-1?Q?1cJ10N7wtZ06gpjbohbecSnP/ibi1Qk1cCkgB57jVLpHRs/k8OItLK4SLe?=
 =?iso-8859-1?Q?2EU2AYAYeFgpVgntTgTDKT1zo877A5JPoEygcvYUKlqG7St1GlrEuHorJY?=
 =?iso-8859-1?Q?P1EMbKOVhWmJjjYBfM9bGzW8wwggLimpWvlmfrnb7gvkj5o/WaVmP83rDb?=
 =?iso-8859-1?Q?/CVutD+7DDPnCbvdfbN2WQUJtxCi+JIcHCgpLVexKz/f/Gl7spzLnm3hID?=
 =?iso-8859-1?Q?vmjqsmXUXJd5K1zKE3gGklWseogSZ0Ry6hvIv1QSTvekgSbSBu41LxApIE?=
 =?iso-8859-1?Q?IcQZhxRvtselZzktXBaxQP40CRorMOuyruRIFYQynw1jd3ElvvgwJZ/ZsX?=
 =?iso-8859-1?Q?tIFHpMW4pl1Vye+6eOiMwrGAIGlQWwCwcCKfvqqqANvRkiRhtzbUbvJEsJ?=
 =?iso-8859-1?Q?uag1QbXPypYj6forbx8qA+QItrTmnKuSDUiE3Sh1JvFIbCsfPs499WZH8T?=
 =?iso-8859-1?Q?PpI3j44PvuW6bkA87/XNplZljJp/gb3FzuOI0mlkRim2hijZvrByMHpiGi?=
 =?iso-8859-1?Q?8Bi3NGzFxasIryPk97jIpUMfcl8EZOT+9m8atNgO6a19ada4Z0XOgpJ06v?=
 =?iso-8859-1?Q?mU+x+0zcsuxOR905SHWokFJ3RhKD6RS7Rv7+8Zrxfp2UxQSNCyAseOwmYF?=
 =?iso-8859-1?Q?CvzQP35af619lulSkppiwNQignCNNogMGdRp6VxC0hVR/rd1fN41R//FZf?=
 =?iso-8859-1?Q?ufn1raojWjwxjgLr0dGGCEBeXhFVivwpQT5ZEowppXn+8/x497orOgAcZ2?=
 =?iso-8859-1?Q?Ljvo/bJuPnofe6fTtJ62vEJnT4uMPTawTRDkXJWeieMN3JLZooasvJ0iIY?=
 =?iso-8859-1?Q?NM1DxpEX9nVYEuckRjVz5wLYtCfd1jALrgnc59H7SnUAK3GlLuh8KKhK+X?=
 =?iso-8859-1?Q?dtWeMseZpZBDGnjlDCBfocVmA6HAlZyXbCc1KTxdSkBI5PoWtLJ3lskJQL?=
 =?iso-8859-1?Q?CTrOHh0QsCcmvhyLQpAV5sBonxCoFrcutkoZu+XhrWM1emhXBKJi/mpy3v?=
 =?iso-8859-1?Q?O1PDDvmve+qLdzAkqJEyMUe8PAgOuoGbPaUZkrTwtbcWQFyiYEUEI7EXwo?=
 =?iso-8859-1?Q?+osCAFV4V5HEyLC+OzkOXHBliq0diiaP7sjGJeSqimP9KvmeUSUMaQgsMx?=
 =?iso-8859-1?Q?Zd0UGgjrkPsPNtHIRy93L3q22SQdZvp8iiCdotsumE/h6D22D/7pEErjE9?=
 =?iso-8859-1?Q?wTsEv2fR1/hD/e/96fDKLLADA/kn7fDcZLpgS+RmHvD3Pe6CVfF17uO63R?=
 =?iso-8859-1?Q?t3s7VrOmZZDKU/PDvZU53UGbwTiJUDWgtHo57Xmw2YPtzGpCfJsi6UaqlD?=
 =?iso-8859-1?Q?HC23UIVsGediUDArjznDl1let0lLQLlE/emMl1JHJxbzPbwLNzd8HYs77V?=
 =?iso-8859-1?Q?sVXeFMRU5ovWo66WTTzN/+X0hDLd3fgXS2ZaBqDv2IHYk+6JdmAM7cJkOp?=
 =?iso-8859-1?Q?Vz9vKTYmz+n1u2KoOTJRm8kzKFw42bG2UXKUuxP91d+Dp4rKlOiZHQ+HKU?=
 =?iso-8859-1?Q?Cf3L1zda+9AKYAZPUWQQHql1HUq8yCkKh9ZfHzY9jr7FWzcxoZEVrgOPON?=
 =?iso-8859-1?Q?EgFh4nZ1Q82f4=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM8P223MB0383C15F887791405AAD784A8DB02DM8P223MB0383NAMP_"
MIME-Version: 1.0
X-OriginatorOrg: unh.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8P223MB0383.NAMP223.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ceaa8b7-e72b-4612-d1fa-08dd7aadef3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2025 17:09:21.8236 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d6241893-512d-46dc-8d2b-be47e25f5666
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hUaLwrRyp8yWrtymwIWTdQvFOM2O52scRa3JlBwO+4ymJhKgRJUcDKVdZIto4JXWTROwxE2jjEc170oXm8wYpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4P223MB1387
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

--_000_DM8P223MB0383C15F887791405AAD784A8DB02DM8P223MB0383NAMP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello all,

I wanted to chime in as someone who uses DPDK from Rust in quite a few proj=
ects.

No snips so the conversation can continue past me for things I don't commen=
t on.
Hello Harry,

>>>> My concern is how to properly maintain Rust crate once DPDK starts to =
implement
>>>> it's own API.
>>>
>>> I'm not really sure what is meant here. I don't understand what "own" w=
ord refers to?
>>>
>>> I see it like this:
>>> - DPDK has the public C API exported (and that stays the same as today,=
 with ABI rules, version.map files, etc)
>>> - The Rust crate consumes the public C API (via bindgen, as done in thi=
s patch. More detail about bindgen below.)
>>>
>>
>> Bindgen cannot provide access to all DPDK public API.
>
> Ah - you're referring to C static inline functions, declared in header fi=
les, which bindgen doesn't wrap.
> Correct - thanks - I understand your point now.
>
>> A good example here is rte_eth_rx_burst().
>> That function is defined as inline and bindgen does not translate it.
>> Also, the function definition references rte_eth_fp_ops array that is no=
t part of the
>> public DPDK API. That means Rust cannot duplicate rte_eth_rx_burst() "as=
-is" and
>> the solution can require extensions to existing DPDK API.
>>
>> I added a new public API that exports rte_eth_fp_ops for a given port Id=
.
>>
>> Rust implementation of rte_eth_rx_burst() does not have to follow the or=
iginal
>> approach.
>> Usage of rte_eth_fp_ops is good for C, but Rust has different methods.
>
> Agreed there is a certain "mismatch" sometimes, if functions aren't in th=
e
> actually "C ABI" then they can't be called via bindgen.
>
> Agree that elegant solutions (clean, maintainable, and high performance) =
will have
> to be found here. Many existing solutions just wrap the "static inline" f=
unction into
> a "non-static" function, and export it as a public symbol. That allows ca=
lling into it
> from Rust (via bindgen-generated header) however causes an actual functio=
n call..
> (LTO _might_ fix/inline it, but not everybody compiles with LTO.. link ti=
mes!)
>

The core DPDK code is maintained as a self-contained pure C project.
What about extending that model and provide direct access to DPDK resources=
 that
are needed for Rust API ?
That can be arranged as part of "native" DPDK API or as extension for
Rust-enabled DPDK only.
I'm currently experimenting with the latter in
https://nam12.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithub.=
com%2Fgetelson-at-mellanox%2Frdpdk%2Ftree%2Fmain%2Fdpdk-patches&data=3D05%7=
C02%7Cowen.hilyard%40unh.edu%7C59c29799f1544a59f44108dd7a62352a%7Cd62418935=
12d46dc8d2bbe47e25f5666%7C0%7C0%7C638801284429834568%7CUnknown%7CTWFpbGZsb3=
d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpb=
CIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3D3YrOkklWRWlwKyfg9BblBnLsNqnCEf7RdA=
xdUW3JGgM%3D&reserved=3D0<https://github.com/getelson-at-mellanox/rdpdk/tre=
e/main/dpdk-patches>
There are some performance wins to be found along this path. It's not a lot=
, but you can "devirtualize" a lot of DPDK if you use Rust's generics to sp=
ecialize on particular hardware combinations, at the cost of multiplying co=
de size by the number of supported NICs. I can do this in my bindings since=
 I tend to only need to test a few software PMDs and the hardware I have, w=
ith a fallback to "dyn dpdk::EthDev" which pulls data from info structs all=
 of the time, instead of only pulling runtime-only information (ex: mac add=
r, rss key). This is paired with a top-level function which does dispatch f=
or different hardware to "lift" the runtime information about what NIC is u=
sed to compile time. I think the main win here is from inlining driver func=
tions, but I haven't done a detailed analysis of the "why". These are margi=
nal improvements, around a half percent for nic_single_core_perf on my hard=
ware, but there may be more wins for less heavily optimized paths through D=
PDK where the compiler can do more heavy lifting.
> As DPDK uses static-inline functions primarily for "packet-at-a-time" per=
formance reasons,
> it is unfortunate to give-up (some small amounts of..?) performance by ha=
ving a C->Rust FFI call.
> We have work to do to find/propose the best solution.

What exactly is a small amount of performance degradation ?
For some existing performance oriented projects loosing performance to
eliminate the `unsafe {}` construct is not an option.
If you are willing to compile with clang and use LTO, both rustc and clang =
will emit LLVM IR, which gets inlined at link time. I haven't been able to =
measure a performance difference vs C code even when calling "static inline=
" hot path function wrappers across the FFI boundary. This does increase co=
mpile times by quite a bit, more than LTO with pure C would increase them d=
ue to the amount of LLVM IR that rustc emits, but it means that the perform=
ance difference barely exists if it does at all.
>
>> For conclusion, Rust DPDK infrastructure cannot relay on bindgen only an=
d needs
>> to provide native implementation for some public DPDK API.
>> It can be easier to maintain Rust files separately.
>
> OK, now I understand your "kind-of-C-DPDK, kind of Rust-DPDK" code, or th=
e "own" code reference above.
> I'm not sure right now where that would be best implemented/maintained, I=
'll have to think about it and do a POC.
>
>
>> You can check out my Rust DPDK version here: https://nam12.safelinks.pro=
tection.outlook.com/?url=3Dhttps%3A%2F%2Fgithub.com%2Fgetelson-at-mellanox%=
2Frdpdk&data=3D05%7C02%7Cowen.hilyard%40unh.edu%7C59c29799f1544a59f44108dd7=
a62352a%7Cd6241893512d46dc8d2bbe47e25f5666%7C0%7C0%7C638801284429852869%7CU=
nknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW=
4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DQxiozd%2B2%2Bnl=
qsKeuzzVdsU1egsfukfgNEyQyZASpLr8%3D&reserved=3D0<https://github.com/getelso=
n-at-mellanox/rdpdk>
>
> Thanks for the link - I see you've been pushing code actively! Good to se=
e opportunities,
> and compare approaches and concepts. Have you investigated wrapping the v=
arious pointers
> into structs, and providing safer APIs? For example, the [*mut rte_mbuf; =
64] array for RX causes
> raw pointers to be handled for all packet-processing - resulting in "unsa=
fe{ /* work here */ }" blocks.
>

This construct can work:

struct PktsBuf<const SIZE: usize> {
        buffer: [*mut rte_mbuf; SIZE]
}

I think that they mean a construct that wraps a *mut rte_mbuf and provides =
a safe interface. Another option, depending on how invasive the bindings ar=
e allowed to be, is to make them references with a lifetime tied to the mem=
pool they are allocated from. For many usecases, mempools exist for the ent=
ire lifetime of the program and have static lifetimes, meaning that the ref=
erences have static lifetimes which greatly simplifies a lot of the code. T=
his also gets rid of unsafe accesses. However, it would require a wrapper a=
round the buffer with the valid length, something like a fixed-capacity vec=
tor. Another option is to make the pointers Option<NonNull<rte_mbuf>>, whic=
h has the same ABI as a C *rte_mbuf but forces null checks. This will be an=
noying to program against, but for "one packet at a time to completion" pro=
cessing it's equivalent to "if (buffer[i] !=3D null) { ... }" at the top of=
 the loop. For the pipeline or graph libraries, this latter option will inc=
ur a lot of potentially extra null checks, but the upside is that it's ABI =
compatible with the burst functions from the C API.
> The code in the above repo feels like "DPDK C code written in Rust".

Agree.
At this stage there is no native Rust DPDK API.

> It is a great step towards better
> understanding, and having something that works is very valuable; thanks f=
or sharing it.
>
> A "top down" application view might help to brainstorm idiomatic/Safe Rus=
t APIs, and then we can
> discuss/understand how to map these high level APIs onto the "DPDK C in R=
ust" or even "DPDK C API/ABI" layers.
>
> Does that seem like a good method to you, to achieve an ergonomic Safe Ru=
st API as the end result?
>

I think we need to conclude what the safe API means in terms of DPDK projec=
t.
Because it's possible to provide native Rust API for DPDK what will use FFI=
.
Specially, if Rust PMD is not in plans and performance is one of the main g=
oals.
I think most of the value of Rust can be gotten by making a good Rust API a=
vailable to consumers of DPDK. There is value in having Rust for PMDs, but =
there is a lot more code written which consumes DPDK than code in new PMDs.=
 It might be better to hold that conversation until someone wants to write =
a Rust PMD. I think that there is also value in a version which is "maximum=
 safety" that takes performance hits where necessary. DPDK is far enough ah=
ead of the performance of most other options that "DPDK at 80%" is still go=
ing to be fast enough for many purposes and the extra safety is valuable th=
ere from an ease-of-use perspective. There are, of course, applications whi=
ch need everything DPDK has to offer from a performance perspective, and th=
ose should be served as well, but I think DPDK can offer a spectrum where u=
sers get steadily closer to "zero overhead abstraction over the DPDK C API"=
 the more performance they need, possibly sacrificing some safety along the=
 way.

>
>>> Next steps are to "allowlist" more DPDK public API functions, and start=
 building "Safe Rust" APIs over
>>> them, in order to expose an ergonomic and misuse-resistant API. As you =
note, this is where a network ports,
>>> lcores, mempools, and ethdev configuration are all required. First goal=
 something like "Safe L2 macswap"?

check out for Rx, L2 addr swap, Tx sequence here:
https://nam12.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithub.=
com%2Fgetelson-at-mellanox%2Frdpdk%2Fblob%2F253fde7c16a5514bf99d3823725f825=
262e244c8%2Fapp%2Frunpmd%2Frunpmd.rs%23L156&data=3D05%7C02%7Cowen.hilyard%4=
0unh.edu%7C59c29799f1544a59f44108dd7a62352a%7Cd6241893512d46dc8d2bbe47e25f5=
666%7C0%7C0%7C638801284429865170%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOn=
RydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%=
7C0%7C%7C%7C&sdata=3DDKvEoYTKjKEx75AKr16Ge7wN7vigNrv75O1p%2BwTzdH0%3D&reser=
ved=3D0<https://github.com/getelson-at-mellanox/rdpdk/blob/253fde7c16a5514b=
f99d3823725f825262e244c8/app/runpmd/runpmd.rs#L156>

Regards,
Gregory

--_000_DM8P223MB0383C15F887791405AAD784A8DB02DM8P223MB0383NAMP_
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
<div id=3D"appendonsend">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Hello all,&nbsp;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
I wanted to chime in as someone who uses DPDK from Rust in quite a few proj=
ects.<br>
<br>
No snips so the conversation can continue past me for things I don't commen=
t on.&nbsp;</div>
<blockquote style=3D"margin-left: 0.8ex; padding-left: 1ex; border-left: 3p=
x solid rgb(200, 200, 200);">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Hello Harry,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt;&gt;&gt;&gt; My concern is how to properly maintain Rust crate once DPD=
K starts to implement</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt;&gt;&gt;&gt; it's own API.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt;&gt;&gt;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt;&gt;&gt; I'm not really sure what is meant here. I don't understand wha=
t &quot;own&quot; word refers to?</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt;&gt;&gt;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt;&gt;&gt; I see it like this:</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt;&gt;&gt; - DPDK has the public C API exported (and that stays the same =
as today, with ABI rules, version.map files, etc)</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt;&gt;&gt; - The Rust crate consumes the public C API (via bindgen, as do=
ne in this patch. More detail about bindgen below.)</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt;&gt;&gt;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt;&gt;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt;&gt; Bindgen cannot provide access to all DPDK public API.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt; Ah - you're referring to C static inline functions, declared in header=
 files, which bindgen doesn't wrap.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt; Correct - thanks - I understand your point now.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt;&gt; A good example here is rte_eth_rx_burst().</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt;&gt; That function is defined as inline and bindgen does not translate =
it.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt;&gt; Also, the function definition references rte_eth_fp_ops array that=
 is not part of the</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt;&gt; public DPDK API. That means Rust cannot duplicate rte_eth_rx_burst=
() &quot;as-is&quot; and</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt;&gt; the solution can require extensions to existing DPDK API.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt;&gt;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt;&gt; I added a new public API that exports rte_eth_fp_ops for a given p=
ort Id.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt;&gt;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt;&gt; Rust implementation of rte_eth_rx_burst() does not have to follow =
the original</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt;&gt; approach.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt;&gt; Usage of rte_eth_fp_ops is good for C, but Rust has different meth=
ods.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt; Agreed there is a certain &quot;mismatch&quot; sometimes, if functions=
 aren't in the</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt; actually &quot;C ABI&quot; then they can't be called via bindgen.</div=
>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt; Agree that elegant solutions (clean, maintainable, and high performanc=
e) will have</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt; to be found here. Many existing solutions just wrap the &quot;static i=
nline&quot; function into</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt; a &quot;non-static&quot; function, and export it as a public symbol. T=
hat allows calling into it</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt; from Rust (via bindgen-generated header) however causes an actual func=
tion call..</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt; (LTO _might_ fix/inline it, but not everybody compiles with LTO.. link=
 times!)</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
The core DPDK code is maintained as a self-contained pure C project.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
What about extending that model and provide direct access to DPDK resources=
 that</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
are needed for Rust API ?</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
That can be arranged as part of &quot;native&quot; DPDK API or as extension=
 for</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Rust-enabled DPDK only.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
I'm currently experimenting with the latter in</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<a href=3D"https://github.com/getelson-at-mellanox/rdpdk/tree/main/dpdk-pat=
ches" id=3D"OWA4d4d8fe4-3c49-98d2-ff3f-ab4769d04eb5" class=3D"OWAAutoLink" =
data-auth=3D"NotApplicable">https://nam12.safelinks.protection.outlook.com/=
?url=3Dhttps%3A%2F%2Fgithub.com%2Fgetelson-at-mellanox%2Frdpdk%2Ftree%2Fmai=
n%2Fdpdk-patches&amp;data=3D05%7C02%7Cowen.hilyard%40unh.edu%7C59c29799f154=
4a59f44108dd7a62352a%7Cd6241893512d46dc8d2bbe47e25f5666%7C0%7C0%7C638801284=
429834568%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwM=
CIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&amp;sdata=
=3D3YrOkklWRWlwKyfg9BblBnLsNqnCEf7RdAxdUW3JGgM%3D&amp;reserved=3D0</a></div=
>
</blockquote>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
There are some performance wins to be found along this path. It's not a lot=
, but you can &quot;devirtualize&quot; a lot of DPDK if you use Rust's gene=
rics to specialize on particular hardware combinations, at the cost of mult=
iplying code size by the number of supported
 NICs. I can do this in my bindings since I tend to only need to test a few=
 software PMDs and the hardware I have, with a fallback to &quot;dyn dpdk::=
EthDev&quot; which pulls data from info structs all of the time, instead of=
 only pulling runtime-only information (ex:
 mac addr, rss key). This is paired with a top-level function which does di=
spatch for different hardware to &quot;lift&quot; the runtime information a=
bout what NIC is used to compile time. I think the main win here is from in=
lining driver functions, but I haven't done
 a detailed analysis of the &quot;why&quot;. These are marginal improvement=
s, around a half percent for nic_single_core_perf on my hardware, but there=
 may be more wins for less heavily optimized paths through DPDK where the c=
ompiler can do more heavy lifting.</div>
<blockquote style=3D"margin-left: 0.8ex; padding-left: 1ex; border-left: 3p=
x solid rgb(200, 200, 200);">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt; As DPDK uses static-inline functions primarily for &quot;packet-at-a-t=
ime&quot; performance reasons,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt; it is unfortunate to give-up (some small amounts of..?) performance by=
 having a C-&gt;Rust FFI call.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt; We have work to do to find/propose the best solution.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
What exactly is a small amount of performance degradation ?</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
For some existing performance oriented projects loosing&nbsp;performance to=
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
eliminate the `unsafe {}` construct is not an option.</div>
</blockquote>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
If you are willing to compile with clang and use LTO, both rustc and clang =
will emit LLVM IR, which gets inlined at link time. I haven't been able to =
measure a performance difference vs C code even when calling &quot;static i=
nline&quot; hot path function wrappers across
 the FFI boundary. This does increase compile times by quite a bit, more th=
an LTO with pure C would increase them due to the amount of LLVM IR that ru=
stc emits, but it means that the performance difference barely exists if it=
 does at all.&nbsp;</div>
<blockquote style=3D"margin-left: 0.8ex; padding-left: 1ex; border-left: 3p=
x solid rgb(200, 200, 200);">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt;&gt; For conclusion, Rust DPDK infrastructure cannot relay on bindgen o=
nly and needs</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt;&gt; to provide native implementation for some public DPDK API.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt;&gt; It can be easier to maintain Rust files separately.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt; OK, now I understand your &quot;kind-of-C-DPDK, kind of Rust-DPDK&quot=
; code, or the &quot;own&quot; code reference above.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt; I'm not sure right now where that would be best implemented/maintained=
, I'll have to think about it and do a POC.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt;&gt; You can check out my Rust DPDK version here: <a href=3D"https://gi=
thub.com/getelson-at-mellanox/rdpdk" id=3D"OWAc05e32f7-5041-0133-d7f0-f7dec=
d87a15c" class=3D"OWAAutoLink" data-auth=3D"NotApplicable">
https://nam12.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithub.=
com%2Fgetelson-at-mellanox%2Frdpdk&amp;data=3D05%7C02%7Cowen.hilyard%40unh.=
edu%7C59c29799f1544a59f44108dd7a62352a%7Cd6241893512d46dc8d2bbe47e25f5666%7=
C0%7C0%7C638801284429852869%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWU=
sIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7=
C%7C%7C&amp;sdata=3DQxiozd%2B2%2BnlqsKeuzzVdsU1egsfukfgNEyQyZASpLr8%3D&amp;=
reserved=3D0</a></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt; Thanks for the link - I see you've been pushing code actively! Good to=
 see opportunities,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt; and compare approaches and concepts. Have you investigated wrapping th=
e various pointers</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt; into structs, and providing safer APIs? For example, the [*mut rte_mbu=
f; 64] array for RX causes</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt; raw pointers to be handled for all packet-processing - resulting in &q=
uot;unsafe{ /* work here */ }&quot; blocks.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
This construct can work:</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
struct PktsBuf&lt;const SIZE: usize&gt; {</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer: [*mut rte_mbuf; SIZE]</d=
iv>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
}</div>
</blockquote>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
I think that they mean a construct that wraps a *mut rte_mbuf and provides =
a safe interface. Another option, depending on how invasive the bindings ar=
e allowed to be, is to make them references with a lifetime tied to the mem=
pool they are allocated from. For
 many usecases, mempools exist for the entire lifetime of the program and h=
ave static lifetimes, meaning that the references have static lifetimes whi=
ch greatly simplifies a lot of the code. This also gets rid of unsafe acces=
ses. However, it would require a
 wrapper around the buffer with the valid length, something like a fixed-ca=
pacity vector. Another option is to make the pointers Option&lt;NonNull&lt;=
rte_mbuf&gt;&gt;, which has the same ABI as a C *rte_mbuf but forces null c=
hecks. This will be annoying to program against,
 but for &quot;one packet at a time to completion&quot; processing it's equ=
ivalent to &quot;if (buffer[i] !=3D null) { ... }&quot; at the top of the l=
oop. For the pipeline or graph libraries, this latter option will incur a l=
ot of potentially extra null checks, but the upside&nbsp;is
 that it's ABI compatible with the burst functions from the C&nbsp;API.</di=
v>
<blockquote style=3D"margin-left: 0.8ex; padding-left: 1ex; border-left: 3p=
x solid rgb(200, 200, 200);">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt; The code in the above repo feels like &quot;DPDK C code written in Rus=
t&quot;.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Agree.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
At this stage there is no native Rust DPDK API.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt; It is a great step towards better</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt; understanding, and having something that works is very valuable; thank=
s for sharing it.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt; A &quot;top down&quot; application view might help to brainstorm idiom=
atic/Safe Rust APIs, and then we can</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt; discuss/understand how to map these high level APIs onto the &quot;DPD=
K C in Rust&quot; or even &quot;DPDK C API/ABI&quot; layers.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt; Does that seem like a good method to you, to achieve an ergonomic Safe=
 Rust API as the end result?</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
I think we need to conclude what the safe API means in terms of DPDK projec=
t.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Because it's possible to provide native Rust API for DPDK what will use FFI=
.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Specially, if Rust PMD is not in plans and performance is one of the main g=
oals.</div>
</blockquote>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
I think most of the value of Rust can be gotten by making a good Rust API a=
vailable to consumers of DPDK. There is value in having Rust for PMDs, but =
there is a lot more code written which consumes DPDK than code in new PMDs.=
 It might be better to hold that
 conversation until someone wants to write a Rust PMD. I think that there i=
s also value in a version which is &quot;maximum safety&quot; that takes pe=
rformance hits where necessary. DPDK is far enough ahead of the performance=
 of most other options that &quot;DPDK at 80%&quot;
 is still going to be fast enough for many purposes and the extra safety is=
 valuable there from an ease-of-use perspective. There are, of course, appl=
ications which need everything DPDK has to offer from a performance perspec=
tive, and those should be served
 as well, but I think DPDK can offer a spectrum where users get steadily cl=
oser to &quot;zero overhead abstraction over the DPDK C API&quot;&nbsp;the =
more performance they need, possibly sacrificing some safety along the way.=
&nbsp;</div>
<blockquote style=3D"margin-left: 0.8ex; padding-left: 1ex; border-left: 3p=
x solid rgb(200, 200, 200);">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt;&gt;&gt; Next steps are to &quot;allowlist&quot; more DPDK public API f=
unctions, and start building &quot;Safe Rust&quot; APIs over</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt;&gt;&gt; them, in order to expose an ergonomic and misuse-resistant API=
. As you note, this is where a network ports,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
&gt;&gt;&gt; lcores, mempools, and ethdev configuration are all required. F=
irst goal something like &quot;Safe L2 macswap&quot;?</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
check out for Rx, L2 addr swap, Tx sequence here:</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<a href=3D"https://github.com/getelson-at-mellanox/rdpdk/blob/253fde7c16a55=
14bf99d3823725f825262e244c8/app/runpmd/runpmd.rs#L156" id=3D"OWAf1a87476-66=
ff-5bcc-0863-963a7aef2721" class=3D"OWAAutoLink" data-auth=3D"NotApplicable=
">https://nam12.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithu=
b.com%2Fgetelson-at-mellanox%2Frdpdk%2Fblob%2F253fde7c16a5514bf99d3823725f8=
25262e244c8%2Fapp%2Frunpmd%2Frunpmd.rs%23L156&amp;data=3D05%7C02%7Cowen.hil=
yard%40unh.edu%7C59c29799f1544a59f44108dd7a62352a%7Cd6241893512d46dc8d2bbe4=
7e25f5666%7C0%7C0%7C638801284429865170%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1h=
cGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%=
3D%3D%7C0%7C%7C%7C&amp;sdata=3DDKvEoYTKjKEx75AKr16Ge7wN7vigNrv75O1p%2BwTzdH=
0%3D&amp;reserved=3D0</a></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Gregory</div>
</blockquote>
</div>
</body>
</html>

--_000_DM8P223MB0383C15F887791405AAD784A8DB02DM8P223MB0383NAMP_--
