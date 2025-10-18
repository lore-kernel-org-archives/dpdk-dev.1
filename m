Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2A7CCD184
	for <dpdk-dev@archiver.kernel.org>; Sat, 18 Oct 2025 04:38:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B80BF40150;
	Sat, 18 Oct 2025 06:38:27 +0200 (CEST)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010067.outbound.protection.outlook.com
 [52.101.193.67]) by mails.dpdk.org (Postfix) with ESMTP id 76816400D7
 for <dev@dpdk.org>; Sat, 18 Oct 2025 06:38:26 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dEf5F4SRkqsaoscjlEhd93M/lpqIpDpx6h4XpW4Tgjsh/B0sK2hwBexg1dbFt1D5hhv/EfqblV7rmiow4tT4+6UQmBgLCyoiZccri+UEC9ycLoUOxEYj5OYbpCqf610SE05QcWSwIu3cnui0J5BHt5iiLHjKkH2M8K2snQn5P0xOG5f6VA7E1QtsBMpk1cFvTJniZCBp+VzllzMfX/jqeF5/A0sfcIZKKR2O2Qib7DoSnFG02e/vLkk3wEoWhUN7jbuPCfCKIZiYTb0ZitPwmnFr+UVUQgh7p6w4AVdlZG+bggB/ShW9QTrqUzOYW6+UZLgGerTcnumGeA4bs+ij6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6MofjrShFg80N8Y2Q71Wf0pA7jrpVBKxLP7Z/Euk1jk=;
 b=YbyLUapPnBPWc6RIhTFKPwQkq6UK0eNYpBqeWzeNndxOb6Lm8s038JN/gkxjs8r9ssqrM62AbIDWvwFyGRK3ZeVv6CO1L0gJn7/ftKNf/xlatcbIfFLtMA7pEnXR2G01eXx6vBRDIM8NsiQ796cTu/Gi4s2cS8OoT/xtnWtaa+U+UmQG+GxxfvdK/P9BWpsXqdtDl5PsDNxJvlA5aRrbEpwse3EH3XFC+oHXft8YwbRqQ6k19zNSX8wvJWZru6i4QawlclO3ZMphT+haQVnj+3gdXY/AHEeQ684U/3VNzYT0fGlg/4AtHkL1y2xMm+1xjBoZxLv3tkm2mGiwWQRxnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6MofjrShFg80N8Y2Q71Wf0pA7jrpVBKxLP7Z/Euk1jk=;
 b=yLXhHN/VgzGbJYpV53ro7bbB3DOfnHMImK5f4gepd8tYQAX8IjkapHBO3HwzLc431xmDpz8UOClKH2lG+MQy6CFENR3a0d4q3tH2l1LbMB+MH67VPfUZAlUEvX15ZMIKZf54R5llmwNa+tgzgTeD5+CJ5yfjZkH9OCpC3SdzB+4=
Received: from CH3PR12MB8233.namprd12.prod.outlook.com (2603:10b6:610:129::15)
 by DM4PR12MB6254.namprd12.prod.outlook.com (2603:10b6:8:a5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Sat, 18 Oct
 2025 04:38:22 +0000
Received: from CH3PR12MB8233.namprd12.prod.outlook.com
 ([fe80::278f:5cc5:549c:3515]) by CH3PR12MB8233.namprd12.prod.outlook.com
 ([fe80::278f:5cc5:549c:3515%7]) with mapi id 15.20.9228.011; Sat, 18 Oct 2025
 04:38:21 +0000
From: "Tummala, Sivaprasad" <Sivaprasad.Tummala@amd.com>
To: Bruce Richardson <bruce.richardson@intel.com>
CC: "david.hunt@intel.com" <david.hunt@intel.com>,
 "honnappa.nagarahalli@arm.com" <honnappa.nagarahalli@arm.com>,
 "anatoly.burakov@intel.com" <anatoly.burakov@intel.com>, "jerinj@marvell.com"
 <jerinj@marvell.com>, "radu.nicolau@intel.com" <radu.nicolau@intel.com>,
 "gakhil@marvell.com" <gakhil@marvell.com>, "cristian.dumitrescu@intel.com"
 <cristian.dumitrescu@intel.com>, "Yigit, Ferruh" <Ferruh.Yigit@amd.com>,
 "konstantin.ananyev@huawei.com" <konstantin.ananyev@huawei.com>,
 "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH] test/ring_perf: add optional cross L3 core selection
Thread-Topic: [PATCH] test/ring_perf: add optional cross L3 core selection
Thread-Index: AQHcP4PZtGfQbbZNfUaeA0bdghS9+7TGin2AgADG7Ss=
Date: Sat, 18 Oct 2025 04:38:21 +0000
Message-ID: <CH3PR12MB8233C56EA9E26C5BF20A282686F7A@CH3PR12MB8233.namprd12.prod.outlook.com>
References: <20251017163407.845502-1-sivaprasad.tummala@amd.com>
 <aPJxg1EpxkkcV83f@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aPJxg1EpxkkcV83f@bricha3-mobl1.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-18T04:38:20.876Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=1;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8233:EE_|DM4PR12MB6254:EE_
x-ms-office365-filtering-correlation-id: beecc55a-64e7-41b4-c5dd-08de0e002aea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700021|8096899003|7053199007;
x-microsoft-antispam-message-info: =?Windows-1252?Q?bhvn1fviS2deo5Wjevc7rB+QKSrG9BOXJJ8CDcaoT0hntvYhf7226xTM?=
 =?Windows-1252?Q?ikoyPPakUCyUxJIEH+xI2cELnpT3N+ILIAN1bOporH7Bv0l3PXtRpaaH?=
 =?Windows-1252?Q?oGWvrzTFVgAjcEjh3jUYOxRF/TsuVzUdIaejeS3HU4gx42Ss8FAYSmYv?=
 =?Windows-1252?Q?GMoN7czFhzOK5M9GwZjI1+1WnIFeso1hlOH0Rt7MXenm9L1dfTjaiRpl?=
 =?Windows-1252?Q?9gjxK9MkOWias1eAXVBzTkLOcRESnWFnk294Q0K0QTkzTx2RKDEk+nyS?=
 =?Windows-1252?Q?lxnajoXM6g+W55GFMJ3E4wxd27NMyds8QJLO5AhixLv93neLprKZQLJ4?=
 =?Windows-1252?Q?2ckzdt5kdZBylaDOqlJwbQXIFPwCOzHHjEOvz7BpMs7pLnHNr7KT7CEW?=
 =?Windows-1252?Q?369RD2y0e9tt9DwhXB1VFPqMILHXRSedHgpnfQOTya/xKCwXiLzNj/kI?=
 =?Windows-1252?Q?oIHA66kw7oBnknJTk43CLhtc+CaIr0EKN4IyjUW4vPvbFn/xDUYy9dgJ?=
 =?Windows-1252?Q?j2r7YzH8RU3/B2OMRX1Ik+8J0ML+RmKkL2bMOP8vk3mkOxKJuSYC6Q8I?=
 =?Windows-1252?Q?abM/2iuz1z10uv3xrNj6o3sIPhkhkjRS1yVgq5getp6T5Q4KRn/15W3t?=
 =?Windows-1252?Q?o56a1Tf0ruEpVgvlt3xxA1muyMJVCeq23lkgsmX8FomeIWiOCDbPxD7C?=
 =?Windows-1252?Q?C/4acWnnWqHg/ASaiuBryOJ3Er3jC9zfID4IMAqk0JtOXdkCHisYPaHP?=
 =?Windows-1252?Q?du0AmlFHcvQN4Ta3aAPAgCww+GnjwzgO9o831s5RZaDX5gsDu9SN4WAi?=
 =?Windows-1252?Q?izzqTB78kT5Z2YfL3i70T5ePS7xUSdAbUKp0tkLVYnhzUXQOrKcEIfbU?=
 =?Windows-1252?Q?N4VS7YdoEHEmLcg0qBBXrJcuFhWOpcHdXgJiMSXmVrkpVUS/7fpa4yaX?=
 =?Windows-1252?Q?uak82IiiHnOy3y0NiYXuI8XQ6xiOXcJHwUmKNUIoO2nk9HjzCguRF6fF?=
 =?Windows-1252?Q?VNliuDPk28V+wTElUlzPC1d9xI0XR1gI7AkcDAUX32JryInmiORTGrXB?=
 =?Windows-1252?Q?PMdTX4G92Uu8TuI5FhsNYqWHThUT8Y50HDurUFslzyrdiiNzkgVsCDiU?=
 =?Windows-1252?Q?vqHjUuqpLyUYmqYMFGn2PRbdzab39VvEIBuK4qkk/qvQkw/kgzzQ2j/R?=
 =?Windows-1252?Q?nYYiGVAAD8hoB3oN/ie4pj64rx40O7j1Gv7ztjI4q9PUOPEVcSdZ0jE4?=
 =?Windows-1252?Q?Yna6q/z64aZikrc81ukXy9V4b04FKDM+BqFHaBJVccyJvABXcSKCqOaV?=
 =?Windows-1252?Q?t8sQnLUka1tQQ2uMr9ZmPPRDaG84tICx+V8wUv2Fs18dK1+Z7oHLNKnH?=
 =?Windows-1252?Q?mU09Ge7qR9ZSkSd+yUZy8zrmv37Tm99qibdpjdsKAW7wsyCDSc0U10HX?=
 =?Windows-1252?Q?Ls/vutnJwPaHJYE6rV4NCwGahxRSxu66e5X6KtFTfPHyQelxyN2ukZFE?=
 =?Windows-1252?Q?LE3T+nNHMz6hhbjT7PrQFp4oNML0LxnS06z+ZoVCHuygtDdKWfiqJHPj?=
 =?Windows-1252?Q?JlQttlXQ3C+UAbVN8Yz2nUh5uE9OHYjiEG3JH6PaoIF8rlflW1gl0ReW?=
 =?Windows-1252?Q?xTuKwzZWCe8gInMQ2JDpg7Yn?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8233.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(8096899003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?0hcZkDi9+Cpz9B5LyG88eo051OmoCjIY3V0S2AO3Q73bIWNGxRz1pTet?=
 =?Windows-1252?Q?iJGZ108HbNHjn6/Ap5nQMiSMNap1JjP8XDUr7WsQHti1VRgYILDblh37?=
 =?Windows-1252?Q?Is1/BHo0QQSrL5HtLGKGTQQh3dOKcWSOtvq3FVtLGMFwd+1XjgfoyFtv?=
 =?Windows-1252?Q?dgB9vJ3adJH40qtV7VTmc2000CgaIzm9w5QT7JVFLxN2/Jwc+YHUDnaS?=
 =?Windows-1252?Q?tgGi/Pphb3GcG08zd7gv5vjKOayZQLfuqAEa1ojlPvOrUxuWROWrdTS5?=
 =?Windows-1252?Q?4RYnUISiFoPrc2Y3PahvaVVdQ98c5XghUflr0i1lbwVbXNVMY2z9umyG?=
 =?Windows-1252?Q?HuMB7/KjlI/LUTl7Oq1ZYRWtVomKICUcAhZ21s84cc5d7Zl6EqavzVw9?=
 =?Windows-1252?Q?6LiaKkttiG7u3kdgrAn9fJ+5CaDGJfiXW5xhL9MSd1fr5TMO3KcbZTDb?=
 =?Windows-1252?Q?Zd8rWe5+V7crssKsuFipmwIX0pclk7neeqnUuAczaDbcGt3xnul0NPnM?=
 =?Windows-1252?Q?iSlDMZF9srWQomvf8ur+oHcj/45AGpQZoA9xiOmIN1MUmqjsxb2G8jL8?=
 =?Windows-1252?Q?XlnrIZTeePBGzp46MWhzyHV0W/66zl9wke00GjjfbkWsNGDIbXeQwKUx?=
 =?Windows-1252?Q?zj0nDBhT0+C9Ajo2m0j/ptOkW0EpcjMwY0K7SP4AlCbc6cy7WJasksZx?=
 =?Windows-1252?Q?D4e05mKrAbWQyowx8Jn1pjVjnQmZ+futVttkt5r4OvTO5fHE2T3mnS7m?=
 =?Windows-1252?Q?ABpXyyKxbs1bZUP4y4CDKAqR8MUMGKmlLASXG0pe/B4OFvbHnv1YRSg5?=
 =?Windows-1252?Q?mM24hyiZ2m7gRpP+/Ki8C8KYk9dQfUAE5LrVIofLMtWxRtm6+t4NSqED?=
 =?Windows-1252?Q?WWfv9yEN8VpvYLWfsxZZQ6hzINEJPdRkanSSFqe2VASBZDLj94HAV0Zv?=
 =?Windows-1252?Q?f4f2gpBX7dVV3iPa4Dn4DwIt6IXIwuTKGlKqDlTEgDofBc/Nq/xn1FS0?=
 =?Windows-1252?Q?6cPuPA+bMaCH/L+o8KaB6A9qpc653BYJ9XAH1bzrEG4A8usKAJpACtAV?=
 =?Windows-1252?Q?tu1I6woM3CriAI0dtkwE1/lv0Cyaz37DZuPtcjICN0gBgU325l4KbF7y?=
 =?Windows-1252?Q?FBEui95QNDMRwnLTLryBqYR6kozzLrepe1npT0cDXxhH0YyWpYHqHC7V?=
 =?Windows-1252?Q?ubOvRvWH0j22qu2pCPSML5y1cuGDEjy+2c3Ys7lUSS5jR2UvTjRlnjx0?=
 =?Windows-1252?Q?ISBvbu/yWd7mQOE5wQbm1KSLTBr2u3a2TxkimCGkRlP+qEV+8wuSau3j?=
 =?Windows-1252?Q?0ALUw1TOwAOVf3wOGVE5DXFr6oeU4Q0Iu0hXz/kf/5ZqgsH0pLNtnorh?=
 =?Windows-1252?Q?PSpejRzufMwB7gpAIb5CfVLFqPuOWTYnaTNPgsTUFrDGVXgqtiJ7s92P?=
 =?Windows-1252?Q?3Mx0crlmRg0pM5PiaYX34mJHKMVAsuTToeNlV5MkXYHQTDebd4cdw8Vp?=
 =?Windows-1252?Q?eSMaReBP+fVgtC18+m2Ad+5oAsaGnwxfpnpRyv8OWvcw4A1fHvdwCh1F?=
 =?Windows-1252?Q?+Ik1mg9X1XvBCRgVwfNpcyYo9JPIYm6LQYSP8dA3up2AWJoi+Y+fGwlk?=
 =?Windows-1252?Q?DXfP4P4o4LoOuXSsDJqvny1g2EC1uDPOtit4FcBqw4yLEtxKEikzHQcY?=
 =?Windows-1252?Q?0YlUZ8VDFaQ=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CH3PR12MB8233C56EA9E26C5BF20A282686F7ACH3PR12MB8233namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8233.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beecc55a-64e7-41b4-c5dd-08de0e002aea
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2025 04:38:21.5813 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hQJJnbPPbt3cfgdvjALUWhPDBqiefDNNK4FkS52OiftIE7/nMhlwIDhnCtXPqrw05vvAkv9rii103zy1fa9E0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6254
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

--_000_CH3PR12MB8233C56EA9E26C5BF20A282686F7ACH3PR12MB8233namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Bruce,

________________________________
From: Bruce Richardson <bruce.richardson@intel.com>
Sent: Friday, October 17, 2025 10:10 PM
To: Tummala, Sivaprasad <Sivaprasad.Tummala@amd.com>
Cc: david.hunt@intel.com <david.hunt@intel.com>; honnappa.nagarahalli@arm.c=
om <honnappa.nagarahalli@arm.com>; anatoly.burakov@intel.com <anatoly.burak=
ov@intel.com>; jerinj@marvell.com <jerinj@marvell.com>; radu.nicolau@intel.=
com <radu.nicolau@intel.com>; gakhil@marvell.com <gakhil@marvell.com>; cris=
tian.dumitrescu@intel.com <cristian.dumitrescu@intel.com>; Yigit, Ferruh <F=
erruh.Yigit@amd.com>; konstantin.ananyev@huawei.com <konstantin.ananyev@hua=
wei.com>; dev@dpdk.org <dev@dpdk.org>
Subject: Re: [PATCH] test/ring_perf: add optional cross L3 core selection

Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.


On Fri, Oct 17, 2025 at 04:34:04PM +0000, Sivaprasad Tummala wrote:
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
>> ---
>>  app/test/test_ring_perf.c | 75 +++++++++++++++++++++++++++++++++++++++
>>  config/meson.build        |  8 +++++
>>  2 files changed, 83 insertions(+)
>>
>> diff --git a/app/test/test_ring_perf.c b/app/test/test_ring_perf.c

<snip>

>> diff --git a/config/meson.build b/config/meson.build
>> index b8c1f127a2..75630254f2 100644
>> --- a/config/meson.build
>> +++ b/config/meson.build
>> @@ -313,6 +313,14 @@ else
>>      add_project_arguments('-include', 'rte_config.h', language: 'c')
>>  endif
>>
>> +hwloc_dep =3D dependency('hwloc', required : false)
>> +if hwloc_dep.found()
>> +  add_project_arguments('-DHAVE_HWLOC=3D1', language : 'c')
>> +  add_project_link_arguments('-lhwloc', language: 'c')
>> +  dpdk_extra_ldflags +=3D '-lhwloc'
>> +  message('hwloc found =97 enabling L3 cache=96aware topology support')
>> +endif
>> +
>
> Hi,
>
> I think this is the wrong place to put this. This will make the whole DPD=
K
> build depend on hwloc and add it to the pkg-config file.
>
> Instead, it's only the unit test binary that actually has the dependency,
> based on this patch, so just add the dep there, and add it to the cflags
> for that component only.
>
>/Bruce
ACK, I=92ll restrict the hwloc dependency and related flag to the test appl=
ication only in v2.

--_000_CH3PR12MB8233C56EA9E26C5BF20A282686F7ACH3PR12MB8233namp_
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
<div style=3D"font-family: Verdana, Geneva, sans-serif; font-size: 9pt; col=
or: rgb(0, 0, 0);" class=3D"elementToProof">
Hi Bruce,&nbsp;</div>
<div class=3D"elementToProof"><br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;Bruce Richardson &lt;bruce.richardson@intel.com&gt;<br>
<b>Sent:</b>&nbsp;Friday, October 17, 2025 10:10 PM<br>
<b>To:</b>&nbsp;Tummala, Sivaprasad &lt;Sivaprasad.Tummala@amd.com&gt;<br>
<b>Cc:</b>&nbsp;david.hunt@intel.com &lt;david.hunt@intel.com&gt;; honnappa=
.nagarahalli@arm.com &lt;honnappa.nagarahalli@arm.com&gt;; anatoly.burakov@=
intel.com &lt;anatoly.burakov@intel.com&gt;; jerinj@marvell.com &lt;jerinj@=
marvell.com&gt;; radu.nicolau@intel.com &lt;radu.nicolau@intel.com&gt;;
 gakhil@marvell.com &lt;gakhil@marvell.com&gt;; cristian.dumitrescu@intel.c=
om &lt;cristian.dumitrescu@intel.com&gt;; Yigit, Ferruh &lt;Ferruh.Yigit@am=
d.com&gt;; konstantin.ananyev@huawei.com &lt;konstantin.ananyev@huawei.com&=
gt;; dev@dpdk.org &lt;dev@dpdk.org&gt;<br>
<b>Subject:</b>&nbsp;Re: [PATCH] test/ring_perf: add optional cross L3 core=
 selection </div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-size: 11pt;" class=3D"elementToProof">Caution: This mess=
age originated from an External Source. Use proper caution when opening att=
achments, clicking links, or responding.<br>
<br>
<br>
On Fri, Oct 17, 2025 at 04:34:04PM +0000, Sivaprasad Tummala wrote:<br>
&gt;&gt; Enhances test_ring_perf to optionally select two cores on<br>
&gt;&gt; the same socket but on different L3 caches using hwloc.<br>
&gt;&gt;<br>
&gt;&gt; This allows performance characterization of ring library<br>
&gt;&gt; on processors with split L3 cache architectures, providing<br>
&gt;&gt; more realistic measurements of inter-core communication<br>
&gt;&gt; and cache effects.<br>
&gt;&gt;<br>
&gt;&gt; The feature is conditional on hwloc being present, ensuring<br>
&gt;&gt; builds succeed on systems without hwloc.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Sivaprasad Tummala &lt;sivaprasad.tummala@amd.com&g=
t;<br>
&gt;&gt; ---<br>
&gt;&gt;&nbsp; app/test/test_ring_perf.c | 75 +++++++++++++++++++++++++++++=
++++++++++<br>
&gt;&gt;&nbsp; config/meson.build&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 |&nbsp; 8 +++++<br>
&gt;&gt;&nbsp; 2 files changed, 83 insertions(+)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/app/test/test_ring_perf.c b/app/test/test_ring_perf.c=
<br>
<br>
&lt;snip&gt;<br>
<br>
&gt;&gt; diff --git a/config/meson.build b/config/meson.build<br>
&gt;&gt; index b8c1f127a2..75630254f2 100644<br>
&gt;&gt; --- a/config/meson.build<br>
&gt;&gt; +++ b/config/meson.build<br>
&gt;&gt; @@ -313,6 +313,14 @@ else<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; add_project_arguments('-include', 'r=
te_config.h', language: 'c')<br>
&gt;&gt;&nbsp; endif<br>
&gt;&gt;<br>
&gt;&gt; +hwloc_dep =3D dependency('hwloc', required : false)<br>
&gt;&gt; +if hwloc_dep.found()<br>
&gt;&gt; +&nbsp; add_project_arguments('-DHAVE_HWLOC=3D1', language : 'c')<=
br>
&gt;&gt; +&nbsp; add_project_link_arguments('-lhwloc', language: 'c')<br>
&gt;&gt; +&nbsp; dpdk_extra_ldflags +=3D '-lhwloc'<br>
&gt;&gt; +&nbsp; message('hwloc found =97 enabling L3 cache=96aware topolog=
y support')<br>
&gt;&gt; +endif<br>
&gt;&gt; +<br>
&gt;<br>
&gt; Hi,<br>
&gt;&nbsp;<br>
&gt; I think this is the wrong place to put this. This will make the whole =
DPDK<br>
&gt; build depend on hwloc and add it to the pkg-config file.<br>
&gt;&nbsp;<br>
&gt; Instead, it's only the unit test binary that actually has the dependen=
cy,<br>
&gt; based on this patch, so just add the dep there, and add it to the cfla=
gs<br>
&gt; for that component only.<br>
&gt;<br>
&gt;/Bruce<br>
</div>
<div style=3D"font-size: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProo=
f">ACK, <span style=3D"font-family: Verdana, Geneva, sans-serif;">
I=92ll restrict the hwloc dependency and related flag to the test applicati=
on only in v2.</span></div>
</body>
</html>

--_000_CH3PR12MB8233C56EA9E26C5BF20A282686F7ACH3PR12MB8233namp_--
