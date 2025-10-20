Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE16CCD19F
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Oct 2025 23:27:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9E05240151;
	Tue, 21 Oct 2025 01:27:04 +0200 (CEST)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011071.outbound.protection.outlook.com [52.101.57.71])
 by mails.dpdk.org (Postfix) with ESMTP id 5F168400D5
 for <dev@dpdk.org>; Tue, 21 Oct 2025 01:27:03 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wOEvU+/stewmx9eCpDAkEiDDq1+Kq1D4gT/iOFK2YbGYdCsUX+PalbycGBQT7Zpbckkw10R4O+fwxtEcCnBVK+C9yPAocEyYkc0LVuo+/gZsUEzd52ooKISYwtKVK3h3hGI1O/owXRPRn4sACCXvqJJhaqqUcAXf1ALH/MF1TAq1SHIQJXsIk2uvo6ozhV3r+j8k7qMmf9atyo7LHGODz2gF9hJNfv2+6WVm9UvhIXFOEASs9QoSolAGSa7mrpwGTnXFSH1FIBXd9O9FGqaxmf8Xiuv00uSEPq6YUjbcmsqndM9Zmllcx+gPS1+mudFXH2iQ7/NlvuHNAcdoZSxuqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vx2etEgy0efxPFmfXY/GgaK0JIqayWt7UFINGwXnE8Y=;
 b=LaJJfQkKOYLnyj3j+9oaLSHQrAyYPydo5MEtoWCTiu+FIW2vcloW2+WRqPiHguWrxQxtwSNWgLMlgTnI7sOXkg6+XBI6dlJXZxXkauWA0fLq87kaA9paPpwbplIlKN+v+2oM0eKwGvnTyYqDIQgfvuOLlEd/DNQQA/36wgYEBe8T8aSzuRpO8TqEu3nbQ7dDBKQI7WvY+6v+J4pZ2b5FX+aGJJrkfeSxYxCIsz72asqbC3HT8KtBqUx5goNmDTZe/7MRw6xXwudsX7W2ufSvyaYUIsjwaRorSm5HFJbb2WG7XezXLM/bsNX7sFjdEGb9dOn4WpUbzJbTKUnTPgQxbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vx2etEgy0efxPFmfXY/GgaK0JIqayWt7UFINGwXnE8Y=;
 b=dpEziAuJZgaVjJ4X6ZPQqEH6LwPU68e4oRbqi3dZTlWw3PudZrzJXYs+/jsDwiViUPRS0paDbGEZdItejbAsHBBW56vUjbN8JO7wwjZzlz899GDzAzRCZKp8b3wVPFyO5Ow4XK2l2HhhmDgNdYV29NmPlSFcrxcb2BoyMbwkccE=
Received: from CH3PR12MB8233.namprd12.prod.outlook.com (2603:10b6:610:129::15)
 by PH7PR12MB5926.namprd12.prod.outlook.com (2603:10b6:510:1d9::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 23:26:57 +0000
Received: from CH3PR12MB8233.namprd12.prod.outlook.com
 ([fe80::278f:5cc5:549c:3515]) by CH3PR12MB8233.namprd12.prod.outlook.com
 ([fe80::278f:5cc5:549c:3515%7]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 23:26:57 +0000
From: "Tummala, Sivaprasad" <Sivaprasad.Tummala@amd.com>
To: Bruce Richardson <bruce.richardson@intel.com>
CC: "honnappa.nagarahalli@arm.com" <honnappa.nagarahalli@arm.com>,
 "anatoly.burakov@intel.com" <anatoly.burakov@intel.com>, "jerinj@marvell.com"
 <jerinj@marvell.com>, "radu.nicolau@intel.com" <radu.nicolau@intel.com>,
 "gakhil@marvell.com" <gakhil@marvell.com>, "cristian.dumitrescu@intel.com"
 <cristian.dumitrescu@intel.com>, "Yigit, Ferruh" <Ferruh.Yigit@amd.com>,
 "konstantin.ananyev@huawei.com" <konstantin.ananyev@huawei.com>,
 "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH v2] test/ring_perf: add optional cross L3 core selection
Thread-Topic: [PATCH v2] test/ring_perf: add optional cross L3 core selection
Thread-Index: AQHcP/tKkDfnhb5ok0iPRYcJD4AvBbTKvxwAgADyDkA=
Date: Mon, 20 Oct 2025 23:26:57 +0000
Message-ID: <CH3PR12MB8233E5E483D25DC3F463F89386F5A@CH3PR12MB8233.namprd12.prod.outlook.com>
References: <https://patches.dpdk.org/project/dpdk/patch/20251017163407.845502-1-sivaprasad.tummala@amd.com>
 <20251018064831.1153059-1-sivaprasad.tummala@amd.com>
 <aPX5bkbE-V43O_Tq@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aPX5bkbE-V43O_Tq@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-20T23:26:57.347Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=1;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8233:EE_|PH7PR12MB5926:EE_
x-ms-office365-filtering-correlation-id: 79e23aca-67db-463c-460c-08de1030298b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|7053199007|8096899003; 
x-microsoft-antispam-message-info: =?Windows-1252?Q?deAI1Nt7dGQW9ySFrR1GVpSPuqgKaWOYNG4/N/8m+7Ax6R7sx1kPl+Yw?=
 =?Windows-1252?Q?s6KYbCnvD4Na1PKhHuWYYB0zthXh3JlWLo7HtzIhCKd6QYAAXDopjLSI?=
 =?Windows-1252?Q?uMNqXuFq4fU4FpT19y3b+1Hp8CWfqQ3tsMADkdmk6U2Od/UAK6/BdiPk?=
 =?Windows-1252?Q?b75AwtUm1kKrNyLuW5XEXJiwH8/p9l3wCo2QPIz41n2pYpvab12zvoAt?=
 =?Windows-1252?Q?X/nWrUpm4odePjs4cFjTavl9bo5Zz3h6DeIBIc0tzmJP4+ykR4ETjwrn?=
 =?Windows-1252?Q?bmojhoQTqSNjXrKdA+jWrm49Ww7TNVCta5wMWFJ1aL0qoUdKKdv9qrlY?=
 =?Windows-1252?Q?IVyzDQzoBuyyz9Ot3JbhV0GL/CkLpDiK5NHD0lIfX7YL+GxV0nuq5tK6?=
 =?Windows-1252?Q?I/HN0ApnrEgu4yWBmqy2hZpBBfwje663q99JvcurShOgSD7qC5rGQzGN?=
 =?Windows-1252?Q?voJP5UllN3KBQ0n1cPDR3L4UsVotfir8snN4zvKqXxHcNdWNXmlsEr7h?=
 =?Windows-1252?Q?tKeOFf4WmPpVYWDqQWB/2H6aD3NZ2phbZtsWd9JMWoJuChmwY3GB2gfD?=
 =?Windows-1252?Q?ibikJzg2V7IXVZQ45gx0d4cbdiuIyL0LTAtwX93G3dwcmrb1eGXb4zYQ?=
 =?Windows-1252?Q?ethVG+Uk9fW/1hOdFTKpij7Sr1DuzYlPi5W2uB0H2h+PYRJbxenP2yOj?=
 =?Windows-1252?Q?khzGoCAkEl9l1Onu8R9cL+Issyg4jlMaiypL13yhNMAvXR3/0V0kcH/y?=
 =?Windows-1252?Q?yiEGmmYP3mKPIbovuy1KS9JeMFbRizRDCwbYznGrhT4OiG+BDK/e5AyJ?=
 =?Windows-1252?Q?1sOsgT/Iw34cqVpHJW9LuRjJUIDI/mTL1OaXJJ3tBabIPAWB77MCmxCJ?=
 =?Windows-1252?Q?PBRZQfxy+hxbLerwSAv4BOxm8mLeicyKUlH7fv7R9WZAEskUEHLt/a0F?=
 =?Windows-1252?Q?lTice7KdGrt+KVRpYj0SUklDTPkHjA8HHgkqXNHl3D833G6pNFeoXTbG?=
 =?Windows-1252?Q?Z5L1vItLqY08E5GFXMR00CgLwtYvWdWQMil5Il1mEOp8/9hiwjZG6Oxq?=
 =?Windows-1252?Q?MjcphSq1V2h8kUXjb37yjKoJxPvA8dI0xsfWGedywnnw0T4gUT+Ki7qw?=
 =?Windows-1252?Q?Jc2sW/9+KgDq9gwyR3B4exavRZBL19Hi0kF5wvXgecbnm1IcaY+2BQhL?=
 =?Windows-1252?Q?dJvZ7y3/YBalRYcYWitOecaKgQMwMM8QmHA9G7qOQgVIvy/4TtdbLUiJ?=
 =?Windows-1252?Q?n/3y4uv1tPYolPEepF4Ibb+sOkzZsjW0AWrplAo1sjB0ZAvbEAURg/U7?=
 =?Windows-1252?Q?pNqBZMJfUMpiLX75PAWPx4dgALepAP4mI0SgEtc+iNyObDkAXzXZieZr?=
 =?Windows-1252?Q?AsJ2MBbgc9bxRb1ZFJ6Expx9ZV2Ayaxn+cvrMU5+jlqs67Brbqse87xr?=
 =?Windows-1252?Q?jVjzkUMnPScrQmCIQawR8C8qOYoo6AOz85JsO5Thk9HuA3BlfrUXCXIS?=
 =?Windows-1252?Q?i6Yjr6hbdwW95PfjbLuq0Tq8v5hUFuNRzcgT1htY3FqZqPEIK8n/ZE+C?=
 =?Windows-1252?Q?glbNWcypROiLChJc11KXotPvJVXbE1vlMA7ClIMDmCdng2Oje3GaMlLL?=
 =?Windows-1252?Q?ak2OvEKqq/c0z+yOTCNaRVkx?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8233.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(7053199007)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?SPvvJhjWF1B4NIBlLzNnmsTksrQqJ3GkvIEBOM3dnmiRTus5SD3gjOz8?=
 =?Windows-1252?Q?64qG77PRfuMYFD7F3vUOSK5ZC8tpvlTtvcn43K4VXoMK/465i8kJC9Nx?=
 =?Windows-1252?Q?2DlQmudRgBF5lQdaWXEuegW8031b6sB4j+huCyV9y3d7orz7SY+WOj/a?=
 =?Windows-1252?Q?/HyRAZNb92wRuUq4ic4RDVqxYo/zC+16WJVALqxv7VDDPC9EvZA79QhJ?=
 =?Windows-1252?Q?OuSW4aci/dj7mpusaBCMp1AIbL8F/A/5ErK83AVhnmrZf6V83MPZAT9x?=
 =?Windows-1252?Q?Bk0Ba5c3CL1DOnPfk9wu7nGfN/Zc4xKXdj4LnfzlNOWc/PQ6ZlltR39o?=
 =?Windows-1252?Q?uuZPNsxur/2xeq7pCJdpZHzjlAMeIqC4mPfA1qctRQYS5U9nojIkbUZ6?=
 =?Windows-1252?Q?kth5VMyJ8Glfb+b1CUUGwkoSYEaIoYnFrGDcFsJNvejqAmSMBea+sOtt?=
 =?Windows-1252?Q?AFuSlEOE6ZQBkJVxnLsd6r7Cl6rYR/rtIq45aWmG9gWPasBZK9lfVNO+?=
 =?Windows-1252?Q?lYqVXWpFsPRnEQSmFSxzxqCpSANftaJrNcurBL9SXTv/6QqjIV4tOC6O?=
 =?Windows-1252?Q?eoPKnNPL39CuU0Df1FMbsZAIZ2KxeWkcW9Nb76NHcDlD1vtctGOuC/+g?=
 =?Windows-1252?Q?H52iiaJNiBLb2jOcdMsgddxEARUeKftgjnX8lJ5IlcE9bg9SV66TRbgm?=
 =?Windows-1252?Q?h/u7s/vJiplBRjHYptgB7r0X/KjJR7tMjgEBFS160O+H1tTvkk+6Uq6S?=
 =?Windows-1252?Q?dUhf8iW0TEYpaYWUjtnAcBcEExCZ5sFru2Q3fCl6kUqZ6dBGTTQzusHz?=
 =?Windows-1252?Q?cFNPJDDXbze9If8ek3FS/N3oY0KNGDcoXdBUvH3dCqJH0XPAEVb+dMNX?=
 =?Windows-1252?Q?koXOW12GVBZLjP3HSMPJSB7q2Pxs8oidmKZ+iypv//yjaMJmQS+BiCZa?=
 =?Windows-1252?Q?GFyHR1DSvmc0K2douWnE5HxMvLqmzdXvggkYrq7RtKdPaQNp9EdxB1o8?=
 =?Windows-1252?Q?5RhKIQb6gFBMfFEjIpU/Maz9v/SxrZ7tv2IxRzhpPjPPl1rbqW0QQUJi?=
 =?Windows-1252?Q?g5lwjRnIDzSWTz2PjFWX+AqI+jB1o6NHhfSo78XEwzfWvwvdU9i4hmPa?=
 =?Windows-1252?Q?ynwaQBnffsHxCTg9zDxv0N1nGe3h2a/noeHnCm+XNTpj7t7ehcuDv+cB?=
 =?Windows-1252?Q?em2CM7tNsMbJZ445zYKr928OzEILWUqGi82Jxjt/BRmmDVfcly6kM75f?=
 =?Windows-1252?Q?wiuXpxm9BuZse0iirT4uGOcSk2ZINU+6pm1bhcUduexyl4r0jIUCDgds?=
 =?Windows-1252?Q?TkVo+vpwNA6XG1kZGkaSoWVbaoinw4agpP/E2/kcSAgaLBNSxcqQ4kzS?=
 =?Windows-1252?Q?CURCPexZWutGTw/5e06d8gtTzY5M4hkACeYJiembN8AchVav2F3UUkBX?=
 =?Windows-1252?Q?b0vYb3TS5H45cpIzWO8jsRxjiIqp5M8OV1+LeCzi+G7t3UZDj+FsgYh6?=
 =?Windows-1252?Q?tPfqAUmvaqmo9tmmtER03swzxODkpF3Q1wDNth3PZKqmpts3z16J6p0Z?=
 =?Windows-1252?Q?4qjSZmXZuWuvA7PKSoJbHvzepLA7R2YV4Cv9n0boyUeyqn48lxQ/FTfo?=
 =?Windows-1252?Q?K4XbRZTIar32YxNcSszDa3/mnDSblCJBk7CkhZ/lm0G3bfYLleLaJ3fy?=
 =?Windows-1252?Q?Um5+Q8Ym3ME=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CH3PR12MB8233E5E483D25DC3F463F89386F5ACH3PR12MB8233namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8233.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79e23aca-67db-463c-460c-08de1030298b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2025 23:26:57.4525 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LhOB0d0I0QSEF2GC/7pftKtUDZlm7RnkMK70XXYah9n7ve8Q+gcfPxgF0LDlDLrieejuPUv0XrYY1UhA7MEY7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5926
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

--_000_CH3PR12MB8233E5E483D25DC3F463F89386F5ACH3PR12MB8233namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Bruce,
________________________________
From: Bruce Richardson <bruce.richardson@intel.com>
Sent: Monday, October 20, 2025 2:27 PM
To: Tummala, Sivaprasad <Sivaprasad.Tummala@amd.com>
Cc: honnappa.nagarahalli@arm.com <honnappa.nagarahalli@arm.com>; anatoly.bu=
rakov@intel.com <anatoly.burakov@intel.com>; jerinj@marvell.com <jerinj@mar=
vell.com>; radu.nicolau@intel.com <radu.nicolau@intel.com>; gakhil@marvell.=
com <gakhil@marvell.com>; cristian.dumitrescu@intel.com <cristian.dumitresc=
u@intel.com>; Yigit, Ferruh <Ferruh.Yigit@amd.com>; konstantin.ananyev@huaw=
ei.com <konstantin.ananyev@huawei.com>; dev@dpdk.org <dev@dpdk.org>
Subject: Re: [PATCH v2] test/ring_perf: add optional cross L3 core selectio=
n

Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.


On Sat, Oct 18, 2025 at 06:48:27AM +0000, Sivaprasad Tummala wrote:
>> Enhances test_ring_perf to optionally select two cores on
>> the same socket but on different L3 caches using hwloc.
>>
>> This allows performance characterization of ring library
>> on processors with split L3 cache architectures, providing
>> more realistic measurements of inter-core communication
>> and cache effects.
>>
>> The feature is conditional on hwloc being present, ensuring
>> builds succeed on systems without hwloc.
>>
>> Signed-off-by: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
>>
>> v2:
>> * Localized hwloc dependency to test app only.
>> * Optimized get_two_l3caches() by moving socket and L3 cache ID
>> retrieval to the outer loop.
>> ---
>>  app/meson.build           |  8 ++++-
>> app/test/test_ring_perf.c | 76 +++++++++++++++++++++++++++++++++++++++
>> 2 files changed, 83 insertions(+), 1 deletion(-)
>>
>> diff --git a/app/meson.build b/app/meson.build
>> index 1798db3ae4..5443043f0c 100644
>> --- a/app/meson.build
>> +++ b/app/meson.build
>> @@ -46,6 +46,12 @@ if get_option('default_library') =3D=3D 'static' and =
not is_windows
>>     default_ldflags +=3D ['-Wl,--export-dynamic']
>>  endif
>>
>> +hwloc_dep =3D dependency('hwloc', required : false)
>> +if hwloc_dep.found()
>> +  default_cflags +=3D ['-DHAVE_HWLOC=3D1']
>> +  message('hwloc found =97 enabling L3 cache=96aware topology support')
>> +endif
>> +
>>  foreach app:apps
>>      name =3D app
>>      build =3D true
>> @@ -60,7 +66,7 @@ foreach app:apps
>>
>>      # use "deps" for internal DPDK dependencies, and "ext_deps" for
>>      # external package/library requirements
>> -    ext_deps =3D []
>> +    ext_deps =3D [hwloc_dep]
>>      deps =3D []
>>
>>      if not enable_apps.contains(app)
>
>I still think we can limit this more. No need, for example, for test-pmd o=
r
>test-cmdline, for that matter, to depend on hwloc. Therefore, I'd suggest
>moving the dependency code to app/test/meson.build and adding it there.
>
>/Bruce

ACK! Will fix this in v3


--_000_CH3PR12MB8233E5E483D25DC3F463F89386F5ACH3PR12MB8233namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
[AMD Official Use Only - AMD Internal Distribution Only]</div>
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Hi Bruce,&nbsp;</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;Bruce Richardson &lt;bruce.richardson@intel.com&gt;<br>
<b>Sent:</b>&nbsp;Monday, October 20, 2025 2:27 PM<br>
<b>To:</b>&nbsp;Tummala, Sivaprasad &lt;Sivaprasad.Tummala@amd.com&gt;<br>
<b>Cc:</b>&nbsp;honnappa.nagarahalli@arm.com &lt;honnappa.nagarahalli@arm.c=
om&gt;; anatoly.burakov@intel.com &lt;anatoly.burakov@intel.com&gt;; jerinj=
@marvell.com &lt;jerinj@marvell.com&gt;; radu.nicolau@intel.com &lt;radu.ni=
colau@intel.com&gt;; gakhil@marvell.com &lt;gakhil@marvell.com&gt;;
 cristian.dumitrescu@intel.com &lt;cristian.dumitrescu@intel.com&gt;; Yigit=
, Ferruh &lt;Ferruh.Yigit@amd.com&gt;; konstantin.ananyev@huawei.com &lt;ko=
nstantin.ananyev@huawei.com&gt;; dev@dpdk.org &lt;dev@dpdk.org&gt;<br>
<b>Subject:</b>&nbsp;Re: [PATCH v2] test/ring_perf: add optional cross L3 c=
ore selection
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-size: 11pt;" class=3D"elementToProof">Caution: This mess=
age originated from an External Source. Use proper caution when opening att=
achments, clicking links, or responding.<br>
<br>
<br>
On Sat, Oct 18, 2025 at 06:48:27AM +0000, Sivaprasad Tummala wrote:<br>
&gt;&gt; Enhances test_ring_perf to optionally select two cores on<br>
&gt;&gt; the same socket but on different L3 caches using hwloc.<br>
&gt;&gt;<br>
&gt;&gt; This allows performance characterization of ring library<br>
&gt;&gt; on processors with split L3 cache architectures, providing<br>
&gt;&gt;&nbsp;more realistic measurements of inter-core communication<br>
&gt;&gt; and cache effects.</div>
<div style=3D"font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProo=
f">&gt;&gt;<span style=3D"font-family: Verdana, Geneva, sans-serif;">&nbsp;=
</span></div>
<div style=3D"font-size: 11pt;" class=3D"elementToProof"><span style=3D"col=
or: rgb(0, 0, 0);">&gt;&gt;</span><span style=3D"font-family: Verdana, Gene=
va, sans-serif; color: rgb(0, 0, 0);">&nbsp;</span>The feature is condition=
al on hwloc being present, ensuring</div>
<div style=3D"font-size: 11pt;" class=3D"elementToProof"><span style=3D"col=
or: rgb(0, 0, 0);">&gt;&gt;</span><span style=3D"font-family: Verdana, Gene=
va, sans-serif; color: rgb(0, 0, 0);">&nbsp;</span>builds succeed on system=
s without hwloc.</div>
<div style=3D"font-size: 11pt;" class=3D"elementToProof">&gt;&gt;<br>
&gt;&gt; Signed-off-by: Sivaprasad Tummala &lt;sivaprasad.tummala@amd.com&g=
t;<br>
&gt;&gt;<br>
&gt;&gt; v2:<br>
&gt;&gt; * Localized hwloc dependency to test app only.<br>
&gt;&gt; * Optimized get_two_l3caches() by moving socket and L3 cache ID<br=
>
&gt;&gt; retrieval to the outer loop.<br>
&gt;&gt; ---<br>
&gt;&gt;&nbsp; app/meson.build&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; |&nbsp; 8 ++++-<br>
&gt;&gt; app/test/test_ring_perf.c | 76 +++++++++++++++++++++++++++++++++++=
++++<br>
&gt;&gt; 2 files changed, 83 insertions(+), 1 deletion(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/app/meson.build b/app/meson.build<br>
&gt;&gt; index 1798db3ae4..5443043f0c 100644<br>
&gt;&gt; --- a/app/meson.build<br>
&gt;&gt; +++ b/app/meson.build<br>
&gt;&gt; @@ -46,6 +46,12 @@ if get_option('default_library') =3D=3D 'static=
' and not is_windows<br>
&gt;&gt;&nbsp; &nbsp; &nbsp;default_ldflags +=3D ['-Wl,--export-dynamic']<b=
r>
&gt;&gt;&nbsp; endif<br>
&gt;&gt;<br>
&gt;&gt; +hwloc_dep =3D dependency('hwloc', required : false)<br>
&gt;&gt; +if hwloc_dep.found()<br>
&gt;&gt; +&nbsp; default_cflags +=3D ['-DHAVE_HWLOC=3D1']<br>
&gt;&gt; +&nbsp; message('hwloc found =97 enabling L3 cache=96aware topolog=
y support')<br>
&gt;&gt; +endif<br>
&gt;&gt; +<br>
&gt;&gt;&nbsp; foreach app:apps<br>
&gt;&gt;&nbsp; &nbsp; &nbsp; name =3D app<br>
&gt;&gt;&nbsp; &nbsp; &nbsp; build =3D true<br>
&gt;&gt; @@ -60,7 +66,7 @@ foreach app:apps<br>
&gt;&gt;<br>
&gt;&gt;&nbsp; &nbsp; &nbsp; # use &quot;deps&quot; for internal DPDK depen=
dencies, and &quot;ext_deps&quot; for<br>
&gt;&gt;&nbsp; &nbsp; &nbsp; # external package/library requirements<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp; ext_deps =3D []<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp; ext_deps =3D [hwloc_dep]<br>
&gt;&gt;&nbsp; &nbsp; &nbsp; deps =3D []<br>
&gt;&gt;<br>
&gt;&gt;&nbsp; &nbsp; &nbsp; if not enable_apps.contains(app)<br>
&gt;<br>
&gt;I still think we can limit this more. No need, for example, for test-pm=
d or<br>
&gt;test-cmdline, for that matter, to depend on hwloc. Therefore, I'd sugge=
st<br>
&gt;moving the dependency code to app/test/meson.build and adding it there.=
<br>
&gt;<br>
&gt;/Bruce</div>
<div style=3D"font-size: 11pt;" class=3D"elementToProof"><br>
</div>
<div style=3D"font-size: 11pt;" class=3D"elementToProof">ACK! Will fix this=
 in v3&nbsp;<br>
<br>
</div>
</body>
</html>

--_000_CH3PR12MB8233E5E483D25DC3F463F89386F5ACH3PR12MB8233namp_--
