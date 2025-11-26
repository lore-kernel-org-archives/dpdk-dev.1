Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E414D10F21
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Nov 2025 11:00:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6F9F840DD8;
	Wed, 26 Nov 2025 12:00:25 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id AEC5E4042F
 for <dev@dpdk.org>; Wed, 26 Nov 2025 12:00:23 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AQ97qfv890381; Wed, 26 Nov 2025 03:00:19 -0800
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11022091.outbound.protection.outlook.com [52.101.48.91])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4anxn386sj-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 26 Nov 2025 03:00:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OZ3bnC37gORsRJsAd0ufQ5haijx8Mpxfe6VqL04SMiehVsiREFeqoGnseRhitI4m2EUaTflJdKcjgxxjkT6NDk45BDVxign6PoTxiqCcd2BWEilqNCZ2C0EibMCJbmfLJyQWaepk4JWIwJD+JNA2DTpD99s8h8rFYSoxJRkHqCnBgGIY55ZesxAG8UHXkexyGX6oZDgdCqJ2ZD+YQkb3/uMXpSFG37XN4XXMpAEUsYRXiuYvINDz/xFPH5miz5DOVGiCdGh4Jmtv+V2CJyKhQtrFhE3d42+MYcu4JbhELVPLWfM5JWCdvWf+Z5swLsr2+VO/4ORDfdI/rfelqbPjdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPs4G+tgEM8tdgYXlV/ETIPNwsteuVRB48L3H6FsIdA=;
 b=AQ8PcX2BHo+vrQEUOHu8Hz1dLGz8qVMJCGGHSHwm+3tv5QDV8/V1FQdMmfE01YlG1Nfj6kF/jJlAu1JtnttAVw0YHckkyhEPOKUNElf6XSsSpu2Hxm8yD9011RpfxpT62GoBtq2jSAclaiTlIbIfutw3Tr0jMXJuCUwIuJNmh1VaZQ1CrNpVSYFHzrerMzxCJNL5Ou7yMFoAhBXWJAuVWiyOCTvixhxw/+V0dafq3lpydQmbWrw5xZmRl/chuI/nIRxU1TqmmX5qB+fZjxRh8XCaIRMYTy2A7CDFYH4l+sV3AFWM/u/bwHiBOS5ph1F4jsHEYD+q2DAcGNXrj/a6HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPs4G+tgEM8tdgYXlV/ETIPNwsteuVRB48L3H6FsIdA=;
 b=r1jggMZQ5DHxeMVaRszA06v8Vtsmv5gxFYj95w7xZURjgpHe5YCUyNidOZ97yJyB4KlpN0IaBab3IoOVyz1scLUEjHzphl+5mXEr8voEpWUEB8wtKWmAnmm753LSvYknoCMz8j9rem4lDkYALNJkef4nG4ld7MthFGrweYmNICA=
Received: from PH0PR18MB4086.namprd18.prod.outlook.com (2603:10b6:510:3::9) by
 LV8PR18MB5988.namprd18.prod.outlook.com (2603:10b6:408:232::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 11:00:16 +0000
Received: from PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::5757:762c:5bd5:938a]) by PH0PR18MB4086.namprd18.prod.outlook.com
 ([fe80::5757:762c:5bd5:938a%6]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 11:00:16 +0000
From: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>
To: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>, Jerin Jacob
 <jerinj@marvell.com>, Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Bruce Richardson <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [RFC 1/2] config: add optimal burst size configuration
Thread-Topic: [RFC 1/2] config: add optimal burst size configuration
Thread-Index: AQHcXq4VsKPYWcJQ0Eu6wbp/mlvALLUEuLeAgAARbwI=
Date: Wed, 26 Nov 2025 11:00:16 +0000
Message-ID: <PH0PR18MB4086DAA3DC6D60E7790A3722DEDEA@PH0PR18MB4086.namprd18.prod.outlook.com>
References: <20251126082414.91933-1-pbhagavatula@marvell.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65592@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65592@smartserver.smartshare.dk>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4086:EE_|LV8PR18MB5988:EE_
x-ms-office365-filtering-correlation-id: 5089df3e-99e9-49d7-f2fc-08de2cdafb6b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?KK6OWndbGYOezBqfjnwEzwJDXr28jSnDjwyt65o1W9rIn7Iv4hr8M3DaWu?=
 =?iso-8859-1?Q?tsfZuOnz6JKxTD+RhWUngblC8IOuLcp4/YL4+bBlxttDL4f0Ktpr4pjM31?=
 =?iso-8859-1?Q?UDIo6kT0kz7ECH6bYnHALh32SCYSBbmR+mipoZ49apMZJHtFUiI98gLKRY?=
 =?iso-8859-1?Q?3wUCggcYdpTDtyGIvxlQa7AlezQxqByCzOLboUL7hf3iw+Zl+mDkYeicmG?=
 =?iso-8859-1?Q?OJwNsleRYltrEOGyGINqmMKzSvjBWotQFMGirK7ddhlLa0I0aguR0qYcez?=
 =?iso-8859-1?Q?lfMvED9QtFWPMxvgLDmA/qMObW0zbbFlSCsaC7bKH0unFV7wF+B5gwmQ8+?=
 =?iso-8859-1?Q?5wxp+1db1XU7SyusEED2TzOpdgMttRgo4vUzaZRyVeMHtcNF0t0BEHc7P7?=
 =?iso-8859-1?Q?kBlIzqtrOXMLY/XFM1Ebyn4f1SV3bjkr9carfFDLPXBwP6d2ZbI4YId8Lo?=
 =?iso-8859-1?Q?jbp9cqKzTJeTBXEbU5mFYyNyRwNw1U3JWZ4otWwXrw+z+WfREd/t9JXUis?=
 =?iso-8859-1?Q?Ot8hm8ryCqoljE2665YrlB0wZJS8yULX+B5FcrcRpuOqR/BH+uWL3tsXkx?=
 =?iso-8859-1?Q?bmpiHUE/aNZPqSlTBoSuUngHWDFvbuN+b6G/U2+S+rYAdvUNBH2ss2uvL8?=
 =?iso-8859-1?Q?dH0Yta+drHabFaGszMItfhklrq7t//fC8Gk90jWzSItVV1DYTilKExE8ha?=
 =?iso-8859-1?Q?A3bbDQ7No+AuCwCGgz71GMLRz3ZwLjq9zAahHDJLQ5tArnts4Pp2NpMjUW?=
 =?iso-8859-1?Q?3roJoGMJMBmxbqwb8Kn6yJnhY+BxCCxDPlcDS+C3e4IVgIwdnxhq5MF9oF?=
 =?iso-8859-1?Q?BMr9VzekIfhLurGGANyAmDkCAL4q66oU9NRsb7V4omk/bDvg5TqfObeQL2?=
 =?iso-8859-1?Q?MrxxgU528ixdiYuD89A8XjuoeHgINEGZFV4Vxxs3B4knnp88wU+8SLJULG?=
 =?iso-8859-1?Q?DJ5Y6gNjP/anuL1qYhMkZ+elkvs7/5fNSVdjuILTKmU2awH4nDOz3TeL+x?=
 =?iso-8859-1?Q?HAkxFlC5EMm5N00dV3YOS8LBaliNVuNoURDG6k+ffwplP3uUKsQPfPUYTu?=
 =?iso-8859-1?Q?sY7zLme51m9ZcfTJhUJe31wcQviqOTQEywQ+K59vyoVcbwJwTRi+2KLJHF?=
 =?iso-8859-1?Q?adVc0qXr8Eb7D107wLk5lCrpYwhqpuWUDYIYBl+AfJTSNA1ZM+X/zEt8rl?=
 =?iso-8859-1?Q?T+DRRLIvMn9tZPlxVOlRl5/E1zC6pbiCy3EXh/KelnjhbM6qyn1HBonYUq?=
 =?iso-8859-1?Q?kTD/xvV9AU4GbbtMOtuO+Im3Mbr14KUFL3KA+KzPB2FUwfxXiHo464onHj?=
 =?iso-8859-1?Q?eTDv0KTh4PPA3mghSg/CU6t07pDwnMjYTG0ixlGmHLPuVCGwAqqIH9bStv?=
 =?iso-8859-1?Q?iiEGBCSCb/YFOo/Cq0iQOGoeORm9G5Z1xOXmAlTNS7f/0a/jvj+tHCEviX?=
 =?iso-8859-1?Q?IftORa0keNiIP+0w6we2s8hBD2d8u7e/0C6Crl29l5UgL0ISN+wGembCBY?=
 =?iso-8859-1?Q?mYFLYKu7fyiSXIqvsoSp7LpKysUXVdm3pCw09VQLPS5OKjm0dgST8hAhhy?=
 =?iso-8859-1?Q?yVgUCvebBYcdBzGLblkgO086Usor?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR18MB4086.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Xiq/zsGXmTZ4FlqMK1VYGAl3fsKXn+1pI13pn2J4Cok/7moecIRp3mvLiX?=
 =?iso-8859-1?Q?bxYyaeC8mu4rwI2k/ie7BWKUMSJJaJvK4pNMh8MHgA9LvxVR3oXGwYaCoB?=
 =?iso-8859-1?Q?5Dgf2Z8RvoYcSAKyffy/ajjOuxmnppvM6tJC7vw02L8+weN6xaaP/+120H?=
 =?iso-8859-1?Q?c7ilHuU8bPpX3LIFJclNOSuuhs0rHzmZqzOstI5FesvpaYIXFFkKbxIoaK?=
 =?iso-8859-1?Q?FeqaKjSEBe+RTdWNdBln4SWsLbqgFD1O/JMlFF4XQttvbQaFeBJIyVn8hd?=
 =?iso-8859-1?Q?B70GkXRp+oAUYpO80pkRzpNFaCAXAiamXZJWapBqDHKuTcYlIIIdXsemKR?=
 =?iso-8859-1?Q?qqXdFnab4CyQ8z083OEWebz9VyHwFrS4Zc5I2zYzASyNzmjV2vfEt8XDbV?=
 =?iso-8859-1?Q?RxegaHZPWzr9EtpRttDmk+ST8MiJExTboozB1VjYK/a0ISbjZfU0zezL/L?=
 =?iso-8859-1?Q?cjjO9FnlnN2o9t1h4AeWF5TswiZiEXE2eJhgY9FvaM9VAvWPTe27f8iam4?=
 =?iso-8859-1?Q?dIpemT6CAE964ciddcLWtP3wgJSwe6Hq2vYVsJdPF6vSK+1AiRnfd6lxK3?=
 =?iso-8859-1?Q?wBMLHDXMXjgkbxPjqvuqtP2OqQN3YlMZOCKW/GXxmY0a76JXSOgfLYemTL?=
 =?iso-8859-1?Q?Qm9BOatO+ok6hghbppi1l8m2y5vp11/uhg/wC6Ahd/aT0J68KzD1Bx+I/q?=
 =?iso-8859-1?Q?xkC/ekpQxAam26/MjbjtxzdDO+ISYoq9J0Mv7+Y0FuUt+VLvhGlFGMD+iJ?=
 =?iso-8859-1?Q?oveXACzq41QrMbfJb/HpOpO5+bSSMr1oAWNRPmq/56n66pOfFGFGi23dFc?=
 =?iso-8859-1?Q?syCgRw18PAvuMyFKgSupEKWvz7XEpQuJzHiCkCC/xs+xfvoqkLyJqMAklp?=
 =?iso-8859-1?Q?KMljLON6EXuyjZ/23IXn3U8EEdGKAhx9l0p8JdCUBNocgFZdVK5Q8L1+qa?=
 =?iso-8859-1?Q?hIcpzjryg2VsrsBjk9qxUv3Du0UYTbenE9yqVmmiqTYIT4XHRTOewbqDj4?=
 =?iso-8859-1?Q?LZNXKaeH+k2Jk9EN/+40n4uLOeNyRTYGkNnGmFtRctkvHz4yON6i1SvAgH?=
 =?iso-8859-1?Q?qHOR9RSlXMb/hZRWhFLWB5GocB57W5CU0qj5pwBY19WzcpQd7w6yKH314f?=
 =?iso-8859-1?Q?zREt/9ea0zVUuqan0ACilHG2Z53IVo65PDNXsFEvlu4jziQnRoYBadmjJe?=
 =?iso-8859-1?Q?3GUsSbekw5iiBSZnzGooIIbgSnOTA52G+l1cr6AYGHsqx+pAMql+xsejLz?=
 =?iso-8859-1?Q?Z5IJGdQrlJydUTZx3urkiXssSBuh0w/mt6cHgL2Pe6W7lFJfW+CDESotv9?=
 =?iso-8859-1?Q?kt6RLY36ABr9uVIYWnm7qOX3pcWPKA1eLY4KPYqy+BB4Y1y83nSStQVbGc?=
 =?iso-8859-1?Q?yGrw6E+EQ4qlA8mlfCIE3fMTWlw3BLa1T3fjbAjsgrF87Day7GAJ0YhnmV?=
 =?iso-8859-1?Q?/TW5XgQLHg6bWCGZAy8cMxjMWgUiE9n7JcOwzt5hamtJs30sWAecseWEXO?=
 =?iso-8859-1?Q?DA/W1cC+M+RvlrSClCIOgTeUkw+QrjV5dBI86Xka19v0Jg8s016R5q+27z?=
 =?iso-8859-1?Q?RUxDS2yHS69+pVS2SwSMsSK7P3vV6yhTmkiYcjn8cn6sgE9ohUswfyXHtS?=
 =?iso-8859-1?Q?FKHEWI4Qelh65YRjygwaRp/drksTt1JEFi?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4086.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5089df3e-99e9-49d7-f2fc-08de2cdafb6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2025 11:00:16.5506 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uDPKQHPYTTijzUqXw9t8AnkuXrjf/7aDy+lyeIYHm7kAKWyylPKgJRD9Vd118LukIAREHQfUeR7WQ/speeceWEdGDZij4r0b/xMq3NHqFpk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR18MB5988
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI2MDA5MCBTYWx0ZWRfX0vgcNaN96sFX
 o304XNa+IqvxiQeeUEbTsKzxAuLWh83T94whumBJjGTxFs59HjQpXO+UzlK0L9y8Hh73uKwNFYP
 FE01gSFgp87vLOqHriFxjbs+kntI/RHtk/6ebVPSwOZ566Cu3om32lhqUQP8LG+dHIUPxeMHBqP
 9ScpS6A8q09poO1N0P7NBDPVgirNqCBe3Iiw8D2AuvOi5tuuajfUjvajPUmW7q/lIzOoOtZRLTr
 ZXlux9l4HZp0eHy2qkE/hUy0yDVIY+ASgZugjKSn2qrjxxkaUcYdxU4UtoD/XdusIK4jrReDtkG
 0hvPhXoFTuy7QH9gwd/PUW3JikhH7WbQ2JHiXriq8queARtkjAeCvpFiDN4TPwQqcHIRWyZca+0
 hjFmMm5YdretrHdwzGnFdXr78vkNHg==
X-Proofpoint-GUID: k36ck8_-A7VmYdgkAnjqaZ4Xj3Hc90KN
X-Proofpoint-ORIG-GUID: k36ck8_-A7VmYdgkAnjqaZ4Xj3Hc90KN
X-Authority-Analysis: v=2.4 cv=V75wEOni c=1 sm=1 tr=0 ts=6926ddc3 cx=c_pps
 a=gqqRaR/JtIFMplGXl4YyTg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=6UeiqGixMTsA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=M5GUcnROAAAA:8 a=EqOJO2NitPL47AO-mHAA:9 a=wPNLvfGTeEIA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
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

>> From: Pavan Nikhilesh <pbhagavatula@marvell.com>=0A=
>>=0A=
>> Add RTE_OPTIMAL_BURST_SIZE to allow platforms to configure the=0A=
>> optimal burst size.=0A=
>>=0A=
>> Set default value to 64 for soc_cn10k and 32 generally.=0A=
>>=0A=
>> Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>=0A=
>> ---=0A=
>> This improves performance by 5% on l2fwd, other examples showed=0A=
>> negligible difference on CN10K.=0A=
>>=0A=
>=0A=
>I support the concept of having a recommended mbuf burst size, targeting t=
he majority of generic applications.=0A=
>Making it CPU dependent seems like a good choice.=0A=
>=0A=
>It should be named differently.=0A=
>First of all, "optimal" depends on the use case; if targeting low latency,=
 shorter bursts are better, so "OPTIMAL" should not be part of the name.=0A=
>Second, I would guess that it only targets mbuf bursts, not also bursts of=
 other operations (e.g. hash lookups), so "MBUF" should be part of the name=
.=0A=
>=0A=
>Suggestion:=0A=
>/* Recommended burst size for generic applications, striking a balance bet=
ween throughput and latency. */=0A=
>dpdk_conf.set('RTE_MBUF_BURST_SIZE_MAX' (or _DEFAULT), 64)=0A=
>=0A=
=0A=
Agreed, would the comment be enough to say that it is a recommendation and =
not an enforcement? or should it be added to the macro name?=0A=
I am sceptical of changing burst size of 64 since most of the applications =
_today_ use 32, might cause unintended regression.=0A=
=0A=
RTE_MBUF_BURST_SIZE_(REC)_PERF?=0A=
=0A=
><feature creep>=0A=
>/* Recommended burst size for generic applications targeting low latency. =
*/=0A=
>dpdk_conf.set('RTE_MBUF_BURST_SIZE_MIN', 4)=0A=
></feature creep>=0A=
=0A=
RTE_MBUF_BURST_SIZE_(REC)_LAT?=0A=
=0A=
(I am bad at names)=0A=
>=0A=
>Having these standardized will also allow libraries and drivers to optimiz=
e for them, e.g. drivers should support bursts sizes all the way down to RT=
E_MBUF_BURST_SIZE_MIN, and can static_assert() that the RTE_MBUF_BURST_SIZE=
_MIN is not lower than supported by the driver/hardware.=0A=
>=0A=
><more feature creep>=0A=
>rte_config.h could have "#define RTE_MBUF_BURST_SIZE RTE_MBUF_BURST_SIZE_M=
AX", for the application developer to change to RTE_MBUF_BURST_SIZE_MIN for=
 low latency applications.=0A=
>This will let the libraries and drivers optimize for the specific burst si=
ze used by the application.=0A=
></more feature creep>=0A=
=0A=
This is fine with me, we can wrap it around a meson option to avoid manuall=
y changing rte_config.h=0A=
=0A=
>=0A=
><rambling>=0A=
>Intuitively, I would assume that the optimal burst size essentially depend=
s on the CPU's L1D cache size and the application's number of non-mbuf cach=
e lines accessed per burst.=0A=
>Let's say a CPU core has 32 KiB cache (=3D 512 cache lines), and each burs=
t touches 4 cache lines per packet:=0A=
>2 cache lines for the mbuf=0A=
>1 cache line for the packet data=0A=
>1 cache line per packet for some table lookup/forwarding entry=0A=
>=0A=
>Then the mbuf burst should be max 512/4 =3D 128.=0A=
>But local variables also use memory during processing, so using a burst of=
 64 would leave room for that and some more.=0A=
></rambling>=0A=
=0A=
We could probably read `/sys/devices/system/cpu/cpu0/cache/index0/size` in =
meson and calculate the number of lines and burst but, I dont think its=0A=
that simple, for example, CN10K has 64KiB L1D cache and anything above 64 b=
urst size causes performance loss.=0A=
=0A=
Thanks,=0A=
Pavan=0A=
=0A=
>=0A=
>>  config/arm/meson.build | 1 +=0A=
>>  config/meson.build     | 1 +=0A=
>>  2 files changed, 2 insertions(+)=0A=
>>=0A=
>> diff --git a/config/arm/meson.build b/config/arm/meson.build=0A=
>> index 523b0fc0ed50..fa64c07016b1 100644=0A=
>> --- a/config/arm/meson.build=0A=
>> +++ b/config/arm/meson.build=0A=
>> @@ -481,6 +481,7 @@ soc_cn10k =3D {=0A=
>>          ['RTE_MAX_LCORE', 24],=0A=
>>          ['RTE_MAX_NUMA_NODES', 1],=0A=
>>          ['RTE_MEMPOOL_ALIGN', 128],=0A=
>> +        ['RTE_OPTIMAL_BURST_SIZE', 64],=0A=
>>      ],=0A=
>>      'part_number': '0xd49',=0A=
>>      'extra_march_features': ['crypto'],=0A=
>> diff --git a/config/meson.build b/config/meson.build=0A=
>> index 0cb074ab95b7..95367ae88e2d 100644=0A=
>> --- a/config/meson.build=0A=
>> +++ b/config/meson.build=0A=
>> @@ -386,6 +386,7 @@ if get_option('mbuf_refcnt_atomic')=0A=
>>      dpdk_conf.set('RTE_MBUF_REFCNT_ATOMIC', true)=0A=
>>  endif=0A=
>>  dpdk_conf.set10('RTE_IOVA_IN_MBUF', get_option('enable_iova_as_pa'))=0A=
>> +dpdk_conf.set('RTE_OPTIMAL_BURST_SIZE', 32)=0A=
>>=0A=
>>  compile_time_cpuflags =3D []=0A=
>>  subdir(arch_subdir)=0A=
>> --=0A=
>> 2.50.1 (Apple Git-155)=
