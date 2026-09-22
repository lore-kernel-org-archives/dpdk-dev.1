Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D848BC982FA
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Sep 2026 18:25:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 234F340609;
	Tue, 22 Sep 2026 20:25:09 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 58AFB402DE
 for <dev@dpdk.org>; Tue, 22 Sep 2026 20:25:07 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MIJo29023731; Tue, 22 Sep 2026 11:25:06 -0700
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11023074.outbound.protection.outlook.com
 [40.93.196.74])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4guw118utj-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 11:25:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FoRxFezOvj/3hMiyFGqI1QMC6R4APYjt+3taULbJyAr7Keilx6Zxiy2X5SC3e1vDMBK5g9SAqf9ay9or9kkmVB3ghW6esASC/1TPOB8z7pksHLB/vj5OanyIk9535+L2/AuXqL3T//KUxkwqIBcKRdkb1kCWWC7hVePbJJ/PKPzIZGc6jbPFD5Q9wOBvPHMo+TOq+lWgpoyEswwTYVPnGF8PCj04wVrfIKmGONhRdnNrFCbS6sgain2Y2IXNnv4qKS/Qj7jHt+WF+tyv+mrABopv2+gsGdF7MKzg83chvpzCDsULXqOWrAAJPBUw7iBBXc4xMxLNZ7pSx3ufwx4cpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NGBPy3YoV31dAjA4jPUlyFXbsNae1fMSKzu7WN5YnW0=;
 b=hiUxh7Y5fDGTkz1dAFc8keBMcqOcbbtPX205S9nawU/xAC5xOyR8flmEq4/3bxmH40OD9/qJqLEcJH9m0PA1o384p6IN7Avpj4PdR0yC8RafmNnYhSV9e8Bju9xDlq20+CAF/v/f8ko4TTGSuJeu0dxGMFKoxKVZgpDZns3i7UtXY99unjUa85unHrZCxPfF9sjSbkbVV9+Pyq6YNN48KbEV1NV+M4CfikNoA5Ps6MYSK6SR/t7TZKUx5/FVVQwZkaOMaOJKPwYrNiRBDVkGnuS8/TrC/NhmYZyMTKH3P2wzGqhCgBB4wfpmFaPRq4Naq6GKvp1/gwFobZcFuJtSrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NGBPy3YoV31dAjA4jPUlyFXbsNae1fMSKzu7WN5YnW0=;
 b=dIUI+7LDnVg2ngfHxUeeqZro/tLKWn1yn8kWZL+f/65AqFEwvwQMLkdIMG8m8VjWRRQIWupXcwHOxiigld7Ap2E6MsdAx9sgji+M4k6iP0wa/uryrmBQLG7X7PuvUVaYED8Fw+BuP3bMliyaQzTQtNGUt5g8tq/7sCAqmeQi1k8=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 LV3PR18MB6217.namprd18.prod.outlook.com (2603:10b6:408:277::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 18:25:02 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%5]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 18:25:02 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Kai Ji <kai.ji@intel.com>, Kiran Kumar Kokkilagadda
 <kirankumark@marvell.com>
Subject: RE: [EXTERNAL] [PATCH v2 1/3] app/crypto-perf: fix asymmetric op pool
 name size
Thread-Topic: [EXTERNAL] [PATCH v2 1/3] app/crypto-perf: fix asymmetric op
 pool name size
Thread-Index: AQHdSqpwvsx/J9zjZEi8Mvw85Ax4Jrba6bxA
Date: Tue, 22 Sep 2026 18:25:01 +0000
Message-ID: <CO6PR18MB448441216A8FAF832FE73902D8832@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20260921215733.404686-1-stephen@networkplumber.org>
 <20260922155249.3115271-1-stephen@networkplumber.org>
 <20260922155249.3115271-2-stephen@networkplumber.org>
In-Reply-To: <20260922155249.3115271-2-stephen@networkplumber.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|LV3PR18MB6217:EE_
x-ms-office365-filtering-correlation-id: eb93a4ae-b290-49c6-d8f3-08df18d6d12b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|10067099003|11063799006|22082099003|18002099003|56012099006|4143699003|38070700021;
x-microsoft-antispam-message-info: nnW14sIj3f/cPT3J0ICKiFXhsYIFMjVbPU/Zo2JCWrhEARI6oIjyzkfQO3w+2EgolLnjXSPCy0gYC3O+fBQACt/HvZDJaz+C0lm7UgbpIsgf4kTOPK7pG+pYzr2W88hNv1SLSuGa/xwauoE97Dm9MH5ZKrO37KbgWr5QoKfQQM/nQKSmBUbAE9KbgJSh5GBH8LLwvNrH6EZf8cxm2L8qcPN+GyHVLtN1OyZRcuLIep0Nis4h+hkWu2ZhQflDmP+rQrHRyzshVs7lJrPNdZTAZA9e3oQMf8A/ko9n2tnLeOlOOsCOzUEOQ0Ue+EswGIGgti+wFEoyGvr7jjovJDUxdaboYKctyfkAdWx+YAw+mSAJ7Eu4CKymPJutMC9pSIFgFLnr7ItERhtyxYzaUHUf9zTMK/5OnhVAnBACCMvd3TiLBeuzHq26/VF/zXY5AMuKv2zrHCkuUb12dFiwcKE/Yt2sF4EdKsLLRR45bxEg7ETp7afvJkmTdnDfxiCKaWkmUtzEyxS0t9PiPr++uclLcBXLaCwvU3BLv38IoGqOR4is3Kq8RwWRShEIMUj6hkPd4vwtVPY0/X9/HLA7nhrp2Iby6yP2tj081bEHdRjOpK82EyIN38y7AO/PYurM1s9RMLM7IYG1yISFSuVWPdUU9o63xNudQVkoYV5X8bKe7cjneup3GcXFayfHskZGBQs25XiZ/EpJhF9wBQnexsI9cGboaJXglu3JAq3eXLUCPzE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(10067099003)(11063799006)(22082099003)(18002099003)(56012099006)(4143699003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PhKvUW7D2EDeQN6qisQRhLipnMk5UKqcmEevE8OAvjql6lUVHwFqNBEJTpCe?=
 =?us-ascii?Q?xKht6/HV1FAMMoLmh0v7ZgX0fcboLFWq+tPQZkGWvmVJQyRcrzou4NzvSZ2m?=
 =?us-ascii?Q?1P1ju0tn383mXzwhwywuUxeYIeBxD+EsZWwiysIK2jsvQTqSbxJTrsaPhKeE?=
 =?us-ascii?Q?t5wVgolXPOunNh2NZ02ulWFgxZx+4r3xo+GqEEznnC9DdVvnDCAcoyULKg8B?=
 =?us-ascii?Q?JbN8WoEUkKqi9KOlng9h2rBIsxa10XgPdXiQP+i5kh5W/24glMxP8obad2nV?=
 =?us-ascii?Q?lAEoSV8jsKumYph+z1ZZWB+5sPWfJ8d8BxREvBhTa5M09HhmywJ5rhvfrYpF?=
 =?us-ascii?Q?b0uRYdpXo4euNwbdbIi3jL/nH5E11i0TzbPTmx8FFRKfEH51H38LV3ntm9qU?=
 =?us-ascii?Q?lxPVk04FOGLdZDZDcosPHVin7onVr/rstL91GPFRJwYlgAMvIopk33WPzMVk?=
 =?us-ascii?Q?Rz8rAiEzCgsJlCRxHadVg4cPJOLPSgDbm8yfdQWpH60Vmpv7IHHH2OsWL+Zb?=
 =?us-ascii?Q?jGzXflQVmwKOL4ywwqJjMryg3eEDImcneD1qMt2BqomC+mQtmBHI0K69lVX3?=
 =?us-ascii?Q?vz1Rgj8xf2ZWEduuaG3KB3TlS6gzpwZCc+l42AKN3QPS0KMLsjCHv7iCMy+6?=
 =?us-ascii?Q?dKNPWRbzjHV2JHr613kqq/NJrlFNlCr/AUsXBa413D/NPoKrWUsVvml+Cshq?=
 =?us-ascii?Q?K12fMzkPofLPRx2AR6MrM4EL9RGVTmixzu+tzZ3XI/2DKh3QPtPX8QJjd2lq?=
 =?us-ascii?Q?mfT1Hney7enT0nW0N4nUx9IlGhyx22w2B0idwXpp2PaDIDZi5h+DjdM0DK42?=
 =?us-ascii?Q?HCZ7zT9TS+7B/bjPPv60IvnvIXojNxUeRnU1Cr31D0xAPHIuWsQqjN4uIVC1?=
 =?us-ascii?Q?AUdrvEub1N9We/mFAjkJ/2omJ8XCmSolM0Ilt/nsjzdrWy4YbXKURKVfvEho?=
 =?us-ascii?Q?JD7kyLwU+tksZ6JX2m0O0qlgrhiGZLffwyzohpNC7FCxLqSSqweI82YW05sh?=
 =?us-ascii?Q?A61RdrrY+QVl+YIcHYE4DDgGeNhEo4b/B674mm11h5KnSUtzft08kdk8dUQI?=
 =?us-ascii?Q?gN2lDdsNok/bRGDwmMSDUeMKnzHNaZiaOo/753iHfN+THwwsWi1Ore/8EmUS?=
 =?us-ascii?Q?YEnpvn+fV1ZxXRPlqMEZKwiZob0MamkxFuXt5yNXa/RaSoQrNUId3XYVWSf/?=
 =?us-ascii?Q?PEHCUWILA6BAxEDypC5b+f9Ck7apKHRhNC122jILiXSl+ifLR4pTqlOrlPOm?=
 =?us-ascii?Q?V0nsIGjZ2toFAR6mrCQ0i6Nd93+B5sZblHcnxRVWHUCfXTfg6AADptHNP/T6?=
 =?us-ascii?Q?6oCXUIyzzOi06OqIMZki80+92+/JFdpwTsOWqku8IcW0d2pCDW/LTLeOj+uS?=
 =?us-ascii?Q?yfmcsuC7QzVqxqYx9i1obGvYsPp2bm/BlgwrAwZEVmT+ArQjwT9mtr8Hh+9n?=
 =?us-ascii?Q?JyD0z4gaH2jqhwMNnEuFFEW0TIBjzQZPq67YggFK4UrJPtcHHYcceRD1rXZZ?=
 =?us-ascii?Q?cCtpdNu4NNMu0jVsxFA68PaXji7N7xLLI8RRYnJ3XUP1EN4HEL75t6HAWw9q?=
 =?us-ascii?Q?44LebRdrg0QlpfQQ97RKIcvF8ep8mc2yvPQcTn/IBd0iXN6otZ9AMCbe46ms?=
 =?us-ascii?Q?9l62Fjd9J1xBilU2QQTs0yX9lyGNmb9UH3wbpKUbdULlrXRC+FWeRLPhUd9C?=
 =?us-ascii?Q?t/zi84b4k+H7dyWY5cyrOP8qk31OxhUj0FfeI7mR+3sBuLCX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: v4IyFVP0pOEU1p4vaej9+gq4gNjy3HNXk8ejuhWz8IyG1MpP9RmBYa1WTHcEDGpqVimIRH/k5/sshAPbi4hqfFnRKlm3eu9L6yz7S7wwpyXHv3GW23Y8gmTuSFYjCc4fLuEHxTzbMkdMLrmNudSKl6oWv5pQfyHQX993njwx/3WOlbUZ6+stL8o//SMPaWNT31T3Is+y4Ag59bKMLHS+cGOfjjAvgQpw5wuebDIvDM+6oYOPC5G+58iRVYSaeM6VmnnqAQnz4ED55Li5DDIsc+3JiTgqPDQhVbLYkT+yizZRTWgA672l+8V/nR++yyrjuw3GhhMVrYLSWGiHEMMtCA==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb93a4ae-b290-49c6-d8f3-08df18d6d12b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 18:25:02.0997 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WIkuiikdWHlzdm9JozcnCqdrC7ZQdpVidc78GEzXoJ+9J5apkss4Vd68TzRHJ/6BJNln3itXKLJLSW+7o+n1Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR18MB6217
X-Proofpoint-ORIG-GUID: NbSYhB1MKkZKQHo9jzwdT7as-NoVFUcI
X-Proofpoint-GUID: NbSYhB1MKkZKQHo9jzwdT7as-NoVFUcI
X-Authority-Analysis: v=2.4 cv=LJDz05W9 c=1 sm=1 tr=0 ts=6ab2c802 cx=c_pps
 a=4ttq6o7tdMcthBZxVtZj+g==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=jZVsG21pAAAA:8
 a=M5GUcnROAAAA:8 a=mOalFBwhp4XI3fzHUk0A:9 a=CjuIK1q_8ugA:10
 a=3Sh2lD0sZASs_lUdrUhf:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI3MCBTYWx0ZWRfX1X706Az9IWQj
 spqnkxYRwgrUNcvw9khnBxeamZFnFAxnFvUhEZaxEZNNFjQumYEKiM5zdUJcd0SwAmI9QVawUs7
 bFmzlNIXyjRnMsj6jlOyM38cyuDZlGE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI3MCBTYWx0ZWRfX1/UnoEYEqKeE
 9UQsVYlHAApjaIsD8JqlP78D7uwzBDpPdsQYqgYnqTRa6zwgD/SjXU+qL9wnLytjBuvPVlquIlf
 l55qz1wYJqi7rx9Of6VKmW1KCPtpk6B0VL4APpZfwKIOy0vojFhb9XKar1u3S+8d4YI1jfFz+57
 FfRoQ0cClrZCUF5/pdN4ni01VDLtORfmEtapmWADCaPpvynwYNJg+gqyoV9ugCYcRN9zV/vphy2
 aansi7f7GsNusGCK5ZLDUgkjexNjIpVs3Q8/6TNUqHKaA6yT/4AiOj7gNbyBfTBqflE3nRcewvR
 kcsuFC77sxsXRM7o3xFeAhobxR3WtdY1WuHs7ypda+f39lC6FSSkDqJq9lywUbne2lepvgBvRvU
 Vyy6HilrknIfSVBaEDg1rorwifN+uam67DZmo4OdP85LbaZmHH6AD2TPZDTOkl7f1SW/lcOJMX9
 o1X3j4LUgcq2BVB0WSA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
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

> The asymmetric op pool name buffer is 32 bytes but snprintf is given
> RTE_MEMPOOL_NAMESIZE as the size. This is harmless only as long as
> RTE_MEMPOOL_NAMESIZE is not larger than 32.
>=20
> Size the buffer with RTE_MEMPOOL_NAMESIZE and use sizeof() for the
> snprintf limit, as the symmetric path already does.
>=20
> Fixes: ba588ce3f933 ("test/crypto-perf: test asymmetric crypto throughput=
")
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  app/test-crypto-perf/cperf_test_common.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Akhil Goyal <gakhil@marvell.com>

