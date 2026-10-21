Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E352606A319
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 07:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=selector1 header.b=vvSdg/ht
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3137C4060C;
	Thu, 22 Oct 2026 09:36:20 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 4C8A740041
 for <dev@dpdk.org>; Wed, 21 Oct 2026 11:46:30 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69L9g1kf1671798; Wed, 21 Oct 2026 02:46:29 -0700
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11020123.outbound.protection.outlook.com
 [40.93.198.123])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4heu07g0f3-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 21 Oct 2026 02:46:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QdpqqxtPfKeoVk/GvV9at+Tyo70Zq9IsZ3vewEO94AcOkJIrZ2xtKF3CIn4aHQqCuWdmKOKFgewpz5VLVC+BI5+BzxtHJCU9mYexUgLwQOxzumHNwgVV4rdG0B4GkAjQ5hsuiK2uTqEcMth8Qh9ZAku5iYImSbqAbu2gG39wSaI053W2dWfLFf4SR+8EtDWIfv2qceYPqcvBLAKT35JiyWNodoSQC9fSCGK+QnROe0PTUshmQSQtyT6LJurXT4lleKS5rMWqd37pBtLKDijn+3/6V+/VodeLp/9dPKSwO6N7gY0c05IaNjAHoeFt4XkdH7zSch3iZP+LSuwFiZRbRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y70Ug56dFX5UrKX7yoSPvEs3BAgrQIL2t7RKzQ5ENPo=;
 b=JNcaWII0lM1F2I/C+4/SMqYbWVSvy1af3ukcfXZY7Hwr9uYbKlqJafmtTqLCEZFZeQuTRB/EVuakYJza73vydVy2n5bk2V5TwoSUzO5ij1nbNO31kLqIlOj3M5FWcdT50kU5fIU6eWZVZ5DZSIh+1fCmkSmpoHwQdEwdK8M8L4w5MNPwVVq72P9IAExcEps15lCgpaiDz3HqYq/3kgYcNuxHwttdc2QET/Kk85+Xuv04r2mz8Boujg/+yf85+c459HPeSCqkD+lkZt6SKs+zzb58S6R8hc0/nqTZRcXJ6TIwzPQnTis6k40wvYUQvOm7cCc0KLROC/b4sZDml4NufQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y70Ug56dFX5UrKX7yoSPvEs3BAgrQIL2t7RKzQ5ENPo=;
 b=vvSdg/htaw80J7R9/ZtrhortRUHgrFBMrp03ydwFU69T7iJhcfiiBCrouGKWpFtOj/2sBBjomflASlR7keIDvIONGrKPvKesJYDj2hmpXm9AAtm8I3kA974wFmFOTFDDwQSfyX5ii3xvZJ3EEeTRvjbfw1TTUtQURtIP5YcPt3c=
Received: from LV8PR18MB6078.namprd18.prod.outlook.com (2603:10b6:408:224::5)
 by CO6PR18MB4466.namprd18.prod.outlook.com (2603:10b6:5:35b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 09:46:26 +0000
Received: from LV8PR18MB6078.namprd18.prod.outlook.com
 ([fe80::e753:86c:d16e:63e2]) by LV8PR18MB6078.namprd18.prod.outlook.com
 ([fe80::e753:86c:d16e:63e2%3]) with mapi id 15.21.0522.017; Wed, 21 Oct 2026
 09:46:26 +0000
From: Pratik Senapati <psenapati@marvell.com>
To: Radu Nicolau <radu.nicolau@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Akhil Goyal <gakhil@marvell.com>, Gowrishankar Muthukrishnan
 <gmuthukrishn@marvell.com>, "Ji, Kai" <kai.ji@intel.com>
Subject: Re: [EXTERNAL] [PATCH] test/crypto: add test vectors for more ML-KEM
 and ML-DSA variants
Thread-Topic: [EXTERNAL] [PATCH] test/crypto: add test vectors for more ML-KEM
 and ML-DSA variants
Thread-Index: AQHdRo2wwv3D84xYDkuxjKKJAro46bbSmVBAgAAFD4CAAD7GAIAKwAiKgCpUg0w=
Date: Wed, 21 Oct 2026 09:46:05 +0000
Message-ID: <LV8PR18MB6078406BE61F93954524B0D9BD662@LV8PR18MB6078.namprd18.prod.outlook.com>
References: <20260917101641.335926-1-radu.nicolau@intel.com>
 <SAWPR18MB988310BC52CC8B4B771E060556CBB82@SAWPR18MB988310.namprd18.prod.outlook.com>
 <5ac0b690-b340-4cfa-90e6-33cac4c30eac@intel.com>
 <29a23773-d16f-4065-859f-f85646442cbf@intel.com>
 <LV8PR18MB6078C87C7F16C9DA0692213CBD812@LV8PR18MB6078.namprd18.prod.outlook.com>
In-Reply-To: <LV8PR18MB6078C87C7F16C9DA0692213CBD812@LV8PR18MB6078.namprd18.prod.outlook.com>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-reactions: allow
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=marvell.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR18MB6078:EE_|CO6PR18MB4466:EE_
x-ms-office365-filtering-correlation-id: 7ab2fd18-b827-453b-7677-08df2f582c93
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|18002099003|10067099003|8096899003|22082099003|4143699003|11063799006|56012099006|38070700021;
x-microsoft-antispam-message-info: JgfdY1xGL8itYU7iXhq4ZAZsTZuWjL6CuVp6Hcx/uelfpyNm/F5fOuoIYzgFpZGXoMqrKRLvgwbqWFew/QibejwktMKPoS6swmmT9dBR2i7wGp33iVeeY3Bz+FHBwOhMGIbsfZlh8e+5D5pnC7LPq0og9imue0Jf4RKhyC0grUDY2vwPU0XB2V7rs8siqkQ9hRy4wYR0AUCQTd/8cTm84jE38olg59HM5t14xAOuGwauxjOiaHmhLhNW/YHxNtIhbHntPxOydKKj8H6/DWa8f7/RgfJkXu85BcA0lhQ5LbBQ+KuFhX8Y9iRB3w/qNikkuw1dRowdYX58Nm5J82Zcag+S/eKatonmz/TVzqUxFzTiE5GQEwG4ITCxQQ3c+9ODb7vpWPMOB7zCPLAjDlzKe+wn4wi4IbeO9xungSzmqecOpAYjnepoFLE4SrPPDgqa8DLcO7yPOEpR0yMbXQ/ro/VPLbBvWweLgyJZfv/mOUMnMZ0B4XhdOcCf0BaF7zhtZh2d+lfr71B/+Q/ApZdg6kWEeOhKPzHWRsJMgojxiJXJlTY9Hk5rFtgPKCCUQB2D5gBn/rSU3lbQgKeYMH3IWICWEg+ou26mplC9WDSWhceR8+wpH64/AmjJ5v+UD9TfGXqwtUtWj1cMDSYDBsT1FL5Pao0Pwvp93ixnJ8hoS6HkVAQLmbhb+uU7XVv6omRM7pPT9zxOZymGwShRk3n6sWvinRD223q92TLiJD2qwM8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR18MB6078.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(10067099003)(8096899003)(22082099003)(4143699003)(11063799006)(56012099006)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?f+V7h2qhuHwjAyFVeiSbr1EApTafrRs2wA9yy9xxm804LdW5e4ewzKr9JkRV?=
 =?us-ascii?Q?oVGR9KsAVMJ6kjiiE8MDVL5nu5pKbuZ4u8qFNnKUg2f1D+ChMGlQW51n7a+T?=
 =?us-ascii?Q?rboqfcfgQsE+DOY77lPGxYkhjcVDAdN9ZsRwctCxCV0eBeYHZVsFBKSa7yQB?=
 =?us-ascii?Q?HWGxgJKnvo2//xG1gX9nGrHGJXAdWkJc907jeiJF3JURCfCYSo64bdnNjwgx?=
 =?us-ascii?Q?LsHDuZsbmMgBEoz23FlLr5Ul6QlqBmXQQtu0+WF8TG05z97I2Fu/kayRrQAV?=
 =?us-ascii?Q?vDVdcGt07DJsSkTTOOCQjbC4f9H6vk8rYdE8WGP82bdMWf2ervXAEG1tvu7N?=
 =?us-ascii?Q?30zSGynIMfbOYGa9zoJZr0mz6XhHxtb6T8IxK98iRiIfcDkuIDDvz8n/KY5f?=
 =?us-ascii?Q?0C9W4xlvsl4Ezs7P3gkC/EWULHrc0WDfuiTV0rF4+dtZ85FmFHUAxYsn77gn?=
 =?us-ascii?Q?GOV4If+CpN8bLMVKKzKbAmgCnTmOKEe2NCayYnHt5oHFSBNSLuHCjpZTg/lb?=
 =?us-ascii?Q?+JJtsCLg5dQla8mMLavxxwZ0pHRKP0EMlwbyIdPSekPtrjUne65UT/WOLrdl?=
 =?us-ascii?Q?C4oy3hpaO1xD43Yo5KDqECwpH1nZIP8HJuIipk72F6eiZ6EYnnXI87sDdTUH?=
 =?us-ascii?Q?NcK4FLxqPWi4vDRIjVR8oHL7VAx2HeyEzpQEHCr2MswxrWpiLbimvhO/MZLD?=
 =?us-ascii?Q?8BGy1dTDa+Zqa7fgWl2lHWTmAEajb/CJRlU2SLLFOalvDePibxoTf5ElTaIX?=
 =?us-ascii?Q?CAQ9vnSBfYIO8rJa8SMK5hooJ8/2yxVl2VG7n7E0Zrc9gDcY/SSwkiUHV43p?=
 =?us-ascii?Q?2t5Aj4GiiZ3m5ceyQrFZ75txE/tdYZwr42Li7UcQ6u9P48anST2/bTAMryf7?=
 =?us-ascii?Q?+ct/7goczC5zk/wEKCBv3MaF7PSOphvihIix0auNo/2cpgiQJqxHxKUKr0fJ?=
 =?us-ascii?Q?AA64C/y6pr+NNJhPW3QlRUnsvO76wzCZQl8bQFvUU3uP9eyUJvbC356IDn/J?=
 =?us-ascii?Q?qyuwCJpSLI/vYIdDBrKYInNaV0+ce0XS+LISb+uUumusyfzWrtf74jC3PvLX?=
 =?us-ascii?Q?igOamJbFACEkCwWyso8n3omio1jutFcydIuFIHFCqIysr4D0GBTGzn5CYy5p?=
 =?us-ascii?Q?XcK/J114v1+Opf0o1k4mShKIcuYAS1+JCEt2gJziBEtlIupdjK866U8/OjYl?=
 =?us-ascii?Q?Q0Ugcu01UppLanNi9k8fs/u+qGmpDUYwS+2o93hf7agBlyMsLuLq1GR1VuOp?=
 =?us-ascii?Q?OLQjmUhsd8HbE6gTjfluKcrn34fp2+XVn1eLBtLoo6jwUbaBFbTg52UVUGv6?=
 =?us-ascii?Q?MN/cisynHFVtMpQLNxNol4fanOPg8UisylfpR8exzINKiWRlpXPUOgbEOX/w?=
 =?us-ascii?Q?zRx+KpGXNOJOnuCuoWgJfrqYz92E7rOFY/H70JyWjkaXzNRVbnxBBJatslLX?=
 =?us-ascii?Q?QIkzvs9h6pUdOwpzn5SuZZ//P607gOqp4cHrmydVGLznt9xXhd5I6zuvwSGI?=
 =?us-ascii?Q?070Iy8skOeWQWRiCwKTjv0EBz5fdF7SAYmMeWInsTjcpXeCAjvX72BI++LG2?=
 =?us-ascii?Q?uBkXWlqp+kEvYwFJRg91aS2nQgBT1gRRCrkkyzfFCcu3TcYW4EH8FAVk5uSb?=
 =?us-ascii?Q?vWNi48OpXuu91EWPGZ/WkMJPwxU2odxSQfHyvLgfrlcTEVRw8W6D3nHtfwqw?=
 =?us-ascii?Q?zeDngu5d+9+Vk4emBGXZo7rNzIkCQgo9WtxBgWO23kHNhnPykNmYANuqwN5Y?=
 =?us-ascii?Q?A7VIuL2MkQ=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_LV8PR18MB6078406BE61F93954524B0D9BD662LV8PR18MB6078namp_"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gbZ3DlkMPluvGmslxMMNp0Y7ucpUTClHJJgrGfvSdX8qUHF3pp87h+PEkwcsaP/eAvCeHwfbMnbWxr1otk6BJGjVbn21msj0JpVNkD9mXu6uEiwMGfulCrOJnGhBkZtOANRGgmVBEy5XTEFrPAjBVmUe9YhKtvM0wBoGJHRP+YAjjS5r9uFB90QjL6g9DPdp773lpxcpNj1s6cAEmuRiQ0P1KoOdk17LALZ/3UUQ4uZmf1RuTu64ObZdHGytBWXKG+2Z3e54GfuT79EGY8cZfABy47vwwZ9KeUSMKQ3PNAmqVa5LITpNW0v2D7/OrDu0gdfXW/bEHCJDS4K0+osk5A==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR18MB6078.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ab2fd18-b827-453b-7677-08df2f582c93
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2026 09:46:26.1233 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oU9DCnz4S+IEAc2VoHFaPeLIqn28ZLLYLaiENQD9cLhKf3rzuopl7nucJ+umhjIhU4Dniffxo8VUGfYQJAf1vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR18MB4466
X-Authority-Analysis: v=2.4 cv=DunDa2/+ c=1 sm=1 tr=0 ts=6ad889f5 cx=c_pps
 a=mLoR1drGahLtw5ViIJY7rA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=VBV7Ae_T7gRcw-aUjJYA:9
 a=CjuIK1q_8ugA:10 a=uKCzPqJVP024lqmZcUwA:9 a=u0Lmcj0XaVad8oPr:21
 a=_W_S_7VecoQA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAzOCBTYWx0ZWRfX0QzixPBGeVqf
 h6qdL60RF9u0Cv1shGHye8osQBjDYeIhLUaNAXfyrtKSVBJPEvUC3GgVSvap+dAVRLruI5uXald
 LCxSUHeWBTTtRDPJddEOgwXl8LDbjag=
X-Proofpoint-GUID: Z9KGV961qPX7DwnZil9qz46l9rsIfWwO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAzOCBTYWx0ZWRfX9y3dywOMKVGc
 gRaV4JVHowMxDqOwWMMhPumsAjR3urOyRUwOxHoguSXG6uNMGwJQ7F+W80kxIFmg7UdpHZnpxZq
 B1gKjgoAdFc5VvUd3xhaZtatZCtAbl63w3zxk+KKXrK5UTWTlce3epT2/STsb9AI3HDQF5qiJnv
 pV6Za1Ezxu3h5ScEbcJoYdfQIxtof8G03X0QWrw6vdOWWGjxhPmyS0cCoQxCihlWrztIdKIGSl3
 nRkKZORxcT9Wzb0aCmS9fFsArjpYolek2IJQVCbcyeYaLV+6K7PIEtyr66fyL2Sxv8kjfotgFXr
 +njP3nD6U/n9cnbz7c/L92YUjTHzH7Qe79eATXdydAVKOICm0hE5aqUCXa3skDwowtWkn9Hf8SV
 9rnMO7gWIcIUQYHuwuF6XzMl7Eqc5oI3cGXP0WgNyvXqD/ud6RrfliQF33HpSSyp3j/0KU2Zmv0
 41iZbzHCVCGjy5TuaVg==
X-Proofpoint-ORIG-GUID: Z9KGV961qPX7DwnZil9qz46l9rsIfWwO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_02,2026-10-19_02,2025-10-01_01
X-Mailman-Approved-At: Thu, 22 Oct 2026 09:36:18 +0200
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--_000_LV8PR18MB6078406BE61F93954524B0D9BD662LV8PR18MB6078namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> Hi,
> Thanks for looking into the patches I'll fix the cryptoperf patchset for
> the merge issue and any comments on it and send the v2 patch-set.
> For the remaining test-cases, I have patch-sets ready, I'll send another
> v1 patchset right away.
>
> Thanks,
> Pratik

Hi Radu,

Sending ack here:

Acked-by : Pratik Senapati <psenapati@marvell.com>

Thanks,

Pratik Senapati

--_000_LV8PR18MB6078406BE61F93954524B0D9BD662LV8PR18MB6078namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<div style=3D"direction: ltr; font-family: Aptos; font-size: 11pt; color: b=
lack;">&gt; Hi,<br>
&gt; Thanks for looking into the patches I'll fix the cryptoperf patchset f=
or<br>
&gt; the merge issue and any comments on it and send the v2 patch-set.<br>
&gt; For the remaining test-cases, I have patch-sets ready, I'll send anoth=
er<br>
&gt; v1 patchset right away.<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Pratik</div>
<div style=3D"direction: ltr; font-family: Aptos; font-size: 11pt; color: b=
lack;"><br>
</div>
<div style=3D"direction: ltr; font-family: Aptos; font-size: 11pt; color: b=
lack;">Hi Radu,</div>
<div style=3D"direction: ltr; font-family: Aptos; font-size: 11pt; color: b=
lack;"><br>
</div>
<div style=3D"direction: ltr; font-family: Aptos; font-size: 11pt; color: b=
lack;">Sending ack here:</div>
<div style=3D"direction: ltr; font-family: Aptos; font-size: 11pt; color: b=
lack;"><br>
</div>
<div style=3D"direction: ltr; font-family: Aptos; font-size: 11pt; color: b=
lack;">Acked-by : Pratik Senapati &lt;psenapati@marvell.com&gt;</div>
<div style=3D"direction: ltr; font-family: Aptos; font-size: 11pt; color: b=
lack;"><br>
</div>
<div style=3D"direction: ltr; font-family: Aptos; font-size: 11pt; color: b=
lack;">Thanks,</div>
<div style=3D"direction: ltr; font-family: Aptos; font-size: 11pt; color: b=
lack;"><br>
</div>
<div style=3D"direction: ltr; font-family: Aptos; font-size: 11pt; color: b=
lack;">Pratik Senapati</div>
</body>
</html>

--_000_LV8PR18MB6078406BE61F93954524B0D9BD662LV8PR18MB6078namp_--
