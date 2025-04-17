Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97BC5C369B2
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Apr 2025 05:46:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 675564025A;
	Thu, 17 Apr 2025 07:46:48 +0200 (CEST)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com
 [205.220.178.238])
 by mails.dpdk.org (Postfix) with ESMTP id 0F267400D5
 for <dev@dpdk.org>; Thu, 17 Apr 2025 07:46:45 +0200 (CEST)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53H4jBll020250
 for <dev@dpdk.org>; Thu, 17 Apr 2025 05:46:45 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2041.outbound.protection.outlook.com [104.47.58.41])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45ydd1ntyb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 17 Apr 2025 05:46:44 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z1TSAtvsHQz5T14z3wv0b3J14vHyU+t5a8k7KkEyqJFSuagMVZaZG7l/ruYqc994ubdJywo3CeCdmlEHF5m4YG9ekcPWyOOhwK3wqtUHwP9FXE38KC8cUXAA5wgIryi38AE8cs7cRAAvQLJI4bpwagIEuwnf9h8tdZyVqz6M5baK008AdbsFR3H/mMZSHijYxfv6oP6XfPnZ6yNcABpMRJTAHhaCM15yqGTcjzg+2u+aiABqyRbqeJ/GP4TqI7um4nZD/D7dUwXNrTy5+MIDYQs9yFoRPR9y5i/9rp4GWuRiQLU4R3lb8Y0lUlDSUasSokvNQH6Fex0focMLdKUKag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kbdhuGbCCv/QMUu1dbrh1QIWgAQ6GE+3Hl8BuJfAzGk=;
 b=xPFQ6mBCK47ih3CMWNo+XG8gdCRzJalEn1VOskm3TArhOxplGn+k7DWRpViLPnLsIP5AKj0KOkFYkyxqyO4BywJouDsqtzxuoEVYOmEGEBPrvvo4jtYCJDtVacGTu226Ya9UC3oJV8Ph0gU+Uf1vzXownLdWTkdQAcz/kh+P1/+xPkmUt1uqFTeqZU1PbewqOsqz0iwW9WM/+dCnKyCSXdEojC5f6/AEJda4rYbaFT22xTWf/nkpJW66EN7NZUm+ILdNtnom5+MSBeh9cR0Gu3TmaRQSIe2saKZ94sdvoI6AvXIouBsJad0RagEcz5u3yantk++d/kis2pfB6ahEkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB7312.namprd11.prod.outlook.com (2603:10b6:8:11f::18)
 by DS7PR11MB6248.namprd11.prod.outlook.com (2603:10b6:8:97::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Thu, 17 Apr
 2025 05:46:42 +0000
Received: from DS0PR11MB7312.namprd11.prod.outlook.com
 ([fe80::8436:b2d3:31a9:1c8c]) by DS0PR11MB7312.namprd11.prod.outlook.com
 ([fe80::8436:b2d3:31a9:1c8c%3]) with mapi id 15.20.8655.021; Thu, 17 Apr 2025
 05:46:36 +0000
From: "Li, Changqing" <Changqing.Li@windriver.com>
To: "dev@dpdk.org" <dev@dpdk.org>
CC: "Li, Changqing" <Changqing.Li@windriver.com>
Subject: A compile failure related to "Y2038 Problem"
Thread-Topic: A compile failure related to "Y2038 Problem"
Thread-Index: AQHbr1wDb1pN6rNcv0W4+R44gljMnQ==
Date: Thu, 17 Apr 2025 05:46:36 +0000
Message-ID: <DS0PR11MB731286BF187EB3647769285982BC2@DS0PR11MB7312.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7312:EE_|DS7PR11MB6248:EE_
x-ms-office365-filtering-correlation-id: 7ee66845-0ab4-4f8c-655e-08dd7d733779
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?HyfnpJ5M7+538f1dTS+9TK4SMBYuwbDEAUIAEbL4kp0hgNvHGW3Uy6a73/?=
 =?iso-8859-1?Q?MsXjbg+b31v/f/DDN+L6gDDt5KKUoFLvvmt6w35VyKc5GZke4H7ay57Dk8?=
 =?iso-8859-1?Q?I5hT8npzdb2bD76u9UTOoVqNDA/xaevHduGY7wa/qu50kENV+g9HGiDn/N?=
 =?iso-8859-1?Q?svd1IZc0UaTyoyh4OdpcjQjcACFZaafhBbhjgOJ1gsMbWIAOj1DI60Sc1G?=
 =?iso-8859-1?Q?vfy8E3jVmNuBao59il+eZkVmMKZpwr4nChqDOTbruhHn810S5qhNTnvqSD?=
 =?iso-8859-1?Q?ed0CpSfVzy8Un2BCtLhZ1D3sTKxHcO8b/Uz2hu0wIjk6+avXl3AXkkVjmH?=
 =?iso-8859-1?Q?ZhGmNM4VF4LDivMMz7bu2Q9b1hxJhNRTLZpCBOdzRw5nhQW5xZdwszwzTW?=
 =?iso-8859-1?Q?dBsqetxtaHtrvApj3RbrTohNjI9CohrTzVnqvV2Kmy89G1jbGq2LA3SNtl?=
 =?iso-8859-1?Q?lq0UrM3gYsG6SRjEy5l0xmFU2n04xWAmIPkeJ8a5gKje5PTqM/ExWWK7v6?=
 =?iso-8859-1?Q?L2UxGtfCtXaLa/fAZm77rVJZoJTN1kxqnozX2VJnYi6OHlBZmZgVC2X7el?=
 =?iso-8859-1?Q?bSm8Pma0m71wB3fDc+WC20KghUArxgIqNgw86+Rc+H9gf55n7caqRU1Tit?=
 =?iso-8859-1?Q?pydPEbW5/1vtiVEz9ofcbu7SSSmgLB9BU1kurIjdwzyJQ63OVC5B5+6zEZ?=
 =?iso-8859-1?Q?x6RbvmwUHoM+ogQKvgNbWUbdbkrpcC6cMY3Sw3S6bYKndH7fGrQST66xpc?=
 =?iso-8859-1?Q?yLqfM+7BlXtRHmGBdGWpQ49yaJNRqYhuEAnM6KZB34r3oOkB5rpXl8I62U?=
 =?iso-8859-1?Q?warhqifcAVGYHsH+Ooilqmf2vYbpQBdOQA9Hq1+6wU6qFPggUuU5rIIZXj?=
 =?iso-8859-1?Q?rY/YwNBFpxAULcmvY5lY3FHnZxhefTv4iS/l6VkYcce17dcG2T/mQZ5EIV?=
 =?iso-8859-1?Q?5HGudRSGKIKtydGnUA2hSDYFr0fb+MLwdXivLyXPPnQbBqh4NIJoOVzaF8?=
 =?iso-8859-1?Q?OiukWae/AY4Lb41vxxMAsZclL4xJ1QXhPDHKZ/XriKkhhFSwLCWlrFydb4?=
 =?iso-8859-1?Q?pvMGwRHOsDPHCm1zgq/T8vqiw7QZc/UHpeGlYreHqe/t/SxjxaKSiQ9i3S?=
 =?iso-8859-1?Q?JRry1f1+w9nrBKc90fUx+UfSh2zbB1rYALimXpU6NE0ryjtpZ7ST4OKrtH?=
 =?iso-8859-1?Q?zmUfQbj9ZsO3peC8udW4OQp3vpplFM1RhQ+ifmDoThRsN0ZXfABAWT4xE+?=
 =?iso-8859-1?Q?tRIFvU22pH+MjGnKneb4U+0rOonAnGwZufL7FRYEmYmelGyItksYLvdF7P?=
 =?iso-8859-1?Q?9VnFy2sArvUGpGloAxthI3mOZrPYTV6bG/GD58ISmWMFSZI4wQBn8Sl7h6?=
 =?iso-8859-1?Q?X0ETxYMs2dqCz20vNP18vPLb6IAFfGWzbeEvEcnz7csJGRXEbLohH40xCg?=
 =?iso-8859-1?Q?KVpwJElDOuTgrzUNJTHeDFNNfF4+EFZWHqAFU9RfkvIK/VTHsajl57y6zO?=
 =?iso-8859-1?Q?Iq7SWdyVDvOoWnyfYsWCIY6Cx+tXlz0fBJgtFLUInGCSTMCZZL7Xfp7H99?=
 =?iso-8859-1?Q?IQTTVjo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7312.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?YkB2ZkEOgEx5Y6c1tbX7g3iDgy41YzxB5DOJzJP3rSkTBkte86qr54ZW3K?=
 =?iso-8859-1?Q?wPJClYLa5kjGIsuKPW4jgAMY/VCFXpkXh1JAX8rXzK7e4XIz5wG7jmNJ9z?=
 =?iso-8859-1?Q?RDBOZab6U5wLpFLLEV6z2rj2OSZ7P9WjL3i4EoioHFUacht74AbvGF9miA?=
 =?iso-8859-1?Q?VhekbOUeWZv2zsZeXOh/Dc3vuC5JgSPINYwTDUiC4DFlk23ElzuinR85BX?=
 =?iso-8859-1?Q?wYITmdXrMSzRpsWzp7gMV/5Q03qJywcJ0/mMc0KvPKcQzx0XEi7clsfxi5?=
 =?iso-8859-1?Q?zw2SSUAx4MW0b4k7s5w9S6eM64/S1jk1QJMCy1tbKFD2VQxIxgKQSPSp2C?=
 =?iso-8859-1?Q?ib8dfSUWalXvJuwrMfCcWN4grXtLG5DsN36gaCQSVeoq8NdxWzArNq3l7T?=
 =?iso-8859-1?Q?p/QLaLEAn33D0sTA+/YPBuvW2Da6sGyHp7+4Jx4TXWp3JL+o1suUEoLqkn?=
 =?iso-8859-1?Q?vyp9lpa5DZEQ+P0Oau8Q7vt2q/eczthE8nPoRYT7om97Hsr6slV/qMCKDv?=
 =?iso-8859-1?Q?31lYTMNI/jY3Id+CDHmEOZuzRtB1cwnDIe1oS+R4XXUpMx4OPoPELaYL7u?=
 =?iso-8859-1?Q?aGLrrK3RHCSeacamEWkf8OgZJgGM5HguDOqmhgyH07aWz7MjmumfI+9dzQ?=
 =?iso-8859-1?Q?Of5+lcgR28nBREup0wk7PMpcN2DVB7Gi4jeG81yiV9XMC2x4K9SRG9v+KI?=
 =?iso-8859-1?Q?idwH0hS+tFd+OfWLUO/sNL28T4joOmomZYOYCLkM0l965Am41CvEHROaC9?=
 =?iso-8859-1?Q?U3W3ZKv1q6airpHPrh+ixwu43F7UtaQqBslO9Jmd5XvshnKGSC3Nt5Xr0N?=
 =?iso-8859-1?Q?pH27UuFGvTOOvMUMaf9rMbPvPz62hueT7/0NGxAu5SEmcmgugThiZeOpiy?=
 =?iso-8859-1?Q?N4QkcrPV4ZDEO5Um8+GkDJZ8jKxulUrh/vJRnFpKTPKEVDAa/G0uqq6+bp?=
 =?iso-8859-1?Q?mAjbUcuoq4CrXWyA2h+Lcx1sZPXRGaZv92t8ZAryfPwv8ep9nHdQaQCW9s?=
 =?iso-8859-1?Q?piiLT1P9xN6rqZWInkcYUsFm3ifmqdJL3osrucr1eUGfxs7VUo/+wWgmO4?=
 =?iso-8859-1?Q?64HO0lP5M7Qg+AZojITcTcSD7wB2zzyafDDwzCd/JKaAMX+cnGW+hQwen/?=
 =?iso-8859-1?Q?GEbwzm1wmVR/QMCVi8rtpshUML9jsL134l6dymCvGZlv1gSKwpNwmYLbfG?=
 =?iso-8859-1?Q?lGShRWjNOc8NOaOUZ0FT6W4ekK37NRcgS34TIzLRP3j0UtA5ncmyLtuksW?=
 =?iso-8859-1?Q?m7YkwqXWg0o6DYQXug03bpU+Vgr5G94CFnHDMRw6pekkf8XzawEuXdqOs4?=
 =?iso-8859-1?Q?lrhERT/LQXU/3xHSV0rDCA85trBWX5+YPR5LqdMBdCBroci4xpl7qcpPFH?=
 =?iso-8859-1?Q?AC6mz3ZwX/ckK2vtbkGRNCf8oU34gu8UUo7AB79LqP0caBzZz7ldJgbxut?=
 =?iso-8859-1?Q?3X7J1RfU32OkE7WdobOBedLWu0jHuEobbAzddreo1q48vasDBIbe/Y2v3T?=
 =?iso-8859-1?Q?rjfgQVWcXLOv1/+4qy/wBiT6NpAw4qDUzRsF3/YguUvENcQiyV5SW/8Plo?=
 =?iso-8859-1?Q?5xNHaJjbhgiYr1+8ieY8KoEr/V5puta1DYTMPCbGwm9jaUWggc2UG4XJoq?=
 =?iso-8859-1?Q?dqVM+q3KeZDW7edE+HjFWsACs77vsllB2+?=
Content-Type: multipart/alternative;
 boundary="_000_DS0PR11MB731286BF187EB3647769285982BC2DS0PR11MB7312namp_"
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7312.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ee66845-0ab4-4f8c-655e-08dd7d733779
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2025 05:46:36.1301 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5HKaly67yUPPGCzqre5tzvKivpjPnsymQjYIeeeeuGdJXwg78CKu+VWARH/pBp2aSZvcwnELG8GSztuikECBKoMBHNR4N4gqV+EwTiq9sBw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6248
X-Proofpoint-ORIG-GUID: M9FTqPzruahscsMRmzs4mIhJfFR_0WGr
X-Proofpoint-GUID: M9FTqPzruahscsMRmzs4mIhJfFR_0WGr
X-Authority-Analysis: v=2.4 cv=HecUTjE8 c=1 sm=1 tr=0 ts=680095c5 cx=c_pps
 a=OnljjeCONrlUuPUItWmgXA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=j3GQGqdAxXsBzQ3cLpUA:9 a=wPNLvfGTeEIA:10 a=ritLqX6MTKI1_YPHzy8A:9
 a=ir3JTAPl7zx13AM1:21 a=frz4AuCg-hUA:10 a=_W_S_7VecoQA:10
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_01,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 spamscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504170043
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

--_000_DS0PR11MB731286BF187EB3647769285982BC2DS0PR11MB7312namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi, Dear Maintainers

I  met  the following compile failure  when I pass "-D_TIME_BITS=3D64 -D_FI=
LE_OFFSET_BITS=3D64" to build  32bit  dpdk.  The key command like:
gcc -m32  ...   -D_TIME_BITS=3D64 -D_FILE_OFFSET_BITS=3D64  ...  -o lib/lib=
rte_ethdev.a.p/ethdev_ethdev_trace_points.c.o -c ../git/lib/ethdev/ethdev_t=
race_points.c.

../git/lib/ethdev/ethdev_trace.h: In function 'rte_eth_trace_timesync_write=
_time':
../git/lib/eal/include/rte_common.h:498:55: error: size of unnamed array is=
 negative
  498 | #define RTE_BUILD_BUG_ON(condition) ((void)sizeof(char[1 - 2*!!(con=
dition)]))

[snip]
RTE_TRACE_POINT(
    rte_eth_trace_timesync_write_time,
    RTE_TRACE_POINT_ARGS(uint16_t port_id, const struct timespec *time,
        int ret),
    rte_trace_point_emit_u16(port_id);
    rte_trace_point_emit_size_t(time->tv_sec);
    rte_trace_point_emit_long(time->tv_nsec);
    rte_trace_point_emit_int(ret);
)
[snip]

In order to support Y2038,  "-D_TIME_BITS=3D64 -D_FILE_OFFSET_BITS=3D64"  i=
s passed,  the time->tv_sec is 64bit,  but size_t is 32bits,  so the error =
happend.
if I understand right,  maybe it is possible that  some  codes  will  assig=
n  time->tv_sec to a size_t variable, so this check is meanningful.  Maybe =
what need to do
is make sure the whole project supports Y2038, avoid code similar like  ass=
ign  time->tv_sec to a size_t variable, and then change  rte_trace_point_em=
it_size_t(time->tv_sec);
to  like  rte_trace_point_emit_uint64_t(time->tv_sec);

Could you please help to check if my understanding is correct , and could y=
ou share if there is any plan to support Y2038?   Great Thanks!

Regards
Changqing



--_000_DS0PR11MB731286BF187EB3647769285982BC2DS0PR11MB7312namp_
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
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
background-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
Hi, Dear Maintainers</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
background-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
background-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
I&nbsp; met&nbsp; the following compile failure&nbsp; when I pass &quot;-D_=
TIME_BITS=3D64 -D_FILE_OFFSET_BITS=3D64&quot; to build &nbsp;32bit&nbsp; dp=
dk.&nbsp; The key command like:</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
background-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
gcc -m32&nbsp; ...&nbsp; &nbsp;-D_TIME_BITS=3D64 -D_FILE_OFFSET_BITS=3D64&n=
bsp; ... &nbsp;-o lib/librte_ethdev.a.p/ethdev_ethdev_trace_points.c.o -c .=
./git/lib/ethdev/ethdev_trace_points.c.</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
background-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
background-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
../git/lib/ethdev/ethdev_trace.h: In function 'rte_eth_trace_timesync_write=
_time':</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
background-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
../git/lib/eal/include/rte_common.h:498:55: error: size of unnamed array is=
 negative</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
background-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
&nbsp; 498 | #define RTE_BUILD_BUG_ON(condition) ((void)sizeof(char[1 - 2*!=
!(condition)]))</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
background-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
background-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
[snip]</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
background-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
RTE_TRACE_POINT(</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
background-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; rte_eth_trace_timesync_write_time,</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
background-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; RTE_TRACE_POINT_ARGS(uint16_t port_id, const struct timespec =
*time,</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
background-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; int ret),</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
background-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; rte_trace_point_emit_u16(port_id);</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
background-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;&nbsp;rte_trace_point_emit_size_t(time-&gt;tv_sec);</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
background-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; rte_trace_point_emit_long(time-&gt;tv_nsec);</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
background-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; rte_trace_point_emit_int(ret);</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
background-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
)</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
background-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
[snip]</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
background-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
background-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
In order to support Y2038,&nbsp; &quot;-D_TIME_BITS=3D64 -D_FILE_OFFSET_BIT=
S=3D64&quot;&nbsp; is passed,&nbsp; the time-&gt;tv_sec&nbsp;is 64bit,&nbsp=
; but size_t is 32bits,&nbsp; so the error happend.</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
background-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; color:=
 rgb(0, 0, 0);">
<span style=3D"font-size: 12pt;">if I understand right,&nbsp; maybe it is p=
ossible that &nbsp;some&nbsp; codes&nbsp; will&nbsp; assign &nbsp;</span><s=
pan style=3D"font-size: 16px; background-color: rgb(255, 255, 255);">time-&=
gt;tv_sec to a size_t variable, so this check is meanningful.&nbsp; Maybe
 what need to do</span></div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
background-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; color:=
 rgb(0, 0, 0);">
<span style=3D"font-size: 16px; background-color: rgb(255, 255, 255);">is m=
ake sure the whole project supports Y2038, avoid code similar like
</span><span style=3D"font-size: 12pt; background-color: rgb(255, 255, 255)=
;">&nbsp;assign &nbsp;</span><span style=3D"font-size: 16px; background-col=
or: rgb(255, 255, 255);">time-&gt;tv_sec to a size_t variable, and then cha=
nge&nbsp; rte_trace_point_emit_size_t(time-&gt;tv_sec);</span></div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
background-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 16px; color: rgb(0, 0, 0);">
<span style=3D"background-color: rgb(255, 255, 255);">to&nbsp; like &nbsp;r=
te_trace_point_emit_uint64_t(time-&gt;tv_sec);</span></div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
background-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 16px; color: rgb(0, 0, 0);">
<span style=3D"background-color: rgb(255, 255, 255);"><br>
</span></div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
background-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 16px; color: rgb(0, 0, 0);">
<span style=3D"background-color: rgb(255, 255, 255);">Could you please help=
 to check if my understanding is correct , and could you share if there&nbs=
p;is any plan to support Y2038?&nbsp; &nbsp;Great Thanks!</span></div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
background-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 16px; color: rgb(0, 0, 0);">
<span style=3D"background-color: rgb(255, 255, 255);"><br>
</span></div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
background-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 16px; color: rgb(0, 0, 0);">
<span style=3D"background-color: rgb(255, 255, 255);">Regards</span></div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
background-color: rgb(255, 255, 255); margin: 0px; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 16px; color: rgb(0, 0, 0);">
<span style=3D"background-color: rgb(255, 255, 255);">Changqing</span></div=
>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
</body>
</html>

--_000_DS0PR11MB731286BF187EB3647769285982BC2DS0PR11MB7312namp_--
