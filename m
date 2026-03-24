Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31923F532E6
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 07:08:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 12B53402CC;
	Tue, 24 Mar 2026 08:08:31 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id CF78F4025F
 for <dev@dpdk.org>; Tue, 24 Mar 2026 08:08:29 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62NHXiTw2929876; Tue, 24 Mar 2026 00:08:29 -0700
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11020080.outbound.protection.outlook.com [52.101.201.80])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4d2fk74c39-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 24 Mar 2026 00:08:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KAg3xkh1H+daZH3OddAbzInoVzy1gZupvTDFHXFxd+c4IO7W1FTojHrwaLuBUuwNPDtcM/AthkMIZKl28L226HwlIqSe1qVnp2FPXcj/CWBZjLSjH2XfAXIwqBmvuXYwhG5F2GNWY8s0axkOmBcvPJTROn/Em8w2yxdRvG8lQWGC9h/uBCOr5sQT/EJyUQm/+G2tbSiqPOwe/oEAISDfDt+r/6SyygOVdXW9GVL/WHUg2VE7pmsfvb0Ku8uwP57RMGqObtgfTzuzyGdcQbfr+D9/PTLiYFswSkaNtSntq9GV3g67InnASfO8djQX/IiOkO2ILpaETKAi/x+gYfwX2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aHZniYxJSEAhuUZUmwZhjc5Az0wiN32MtvWdKzdTZm4=;
 b=IPgex3H07npnt7zAKyDhXALWd6ofbywYygJF7WhGrWRiA5dEXeQaav8122l7pyBggSaX+9h9S9ZE4ubP9713ywsDrxSOQuEilHNKg6MoKqTcusnOGHx/IIEYZXQ38wF2YBNgfsSz9tKRh+JY01pcBbFdhV/OCNHzrotKgWn+8hZ55hRCaDvQdIOBsCeABQsgUeUsKoccTzx1QeWjobYKlJWU+qegXlHec8W3WPazmv8MN01qXUl2ct4+UcdJ6Ei28GXxCZJNPGkrszvX8ktt6wLT+LMx4nz1Qe8+/dPo9Mm5/yPvi21aFknoQLAD5FMTHwhYE5T+vANOn5Xc8WHN3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aHZniYxJSEAhuUZUmwZhjc5Az0wiN32MtvWdKzdTZm4=;
 b=ev2zBqPkQZZACKEpG9nL24/Vgd4rA+jx2GQ78QiBhaVOErPdB3ULbXv8tOkurJn7stKHtzsyOif1ptk5Z8EGs7ygv0yKeSVYsErwsPL1wiJqB8IadEYcbaXYDBuSrI+BBnI0tsiSAjdknmLg4LH0AWEPIqwyoT/HqraB8wxkCUE=
Received: from PH3PPFC694D094E.namprd18.prod.outlook.com
 (2603:10b6:518:1::cc8) by BN9PR18MB4203.namprd18.prod.outlook.com
 (2603:10b6:408:118::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 07:08:26 +0000
Received: from PH3PPFC694D094E.namprd18.prod.outlook.com
 ([fe80::9091:180c:559b:8188]) by PH3PPFC694D094E.namprd18.prod.outlook.com
 ([fe80::9091:180c:559b:8188%4]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 07:08:26 +0000
From: Rupesh Chiluka <rchiluka@marvell.com>
To: Emma Finn <emma.finn@intel.com>, Akhil Goyal <gakhil@marvell.com>, Fan
 Zhang <fanzhang.oss@gmail.com>, Kai Ji <kai.ji@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [EXTERNAL] [PATCH 1/2] crypto/qat: fix asym session validation
 and gen4 EC caps
Thread-Topic: [EXTERNAL] [PATCH 1/2] crypto/qat: fix asym session validation
 and gen4 EC caps
Thread-Index: AQHcutcBahwQ4jrMnk+zPELBsa7KFrW9REIQ
Date: Tue, 24 Mar 2026 07:08:26 +0000
Message-ID: <PH3PPFC694D094E8DE0CC5354D498C6EBC3DB48A@PH3PPFC694D094E.namprd18.prod.outlook.com>
References: <20260323150854.2394000-1-emma.finn@intel.com>
In-Reply-To: <20260323150854.2394000-1-emma.finn@intel.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH3PPFC694D094E:EE_|BN9PR18MB4203:EE_
x-ms-office365-filtering-correlation-id: edfe3af6-689a-4423-14df-08de8974251f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|7053199007|18002099003|56012099003|22082099003|8096899003;
x-microsoft-antispam-message-info: F22aUHCZzIxPTduu8ZBDeuXnr5Pv2hnme5QCgSZKBk++RvjKK4jb84kCEQ5v63rZ96JlEsLoVRwd/9KMD4JGg9L2yGqtELiQbcH91b6kPbnDMmCP2P8YYQTr5CpiHz9gz5Iam5P19F1peMJJUsYi5mhNmmaQ2m/9zuldIP9Ir0t5oXfQW6IsaJrKwKVzlDR+JNUysRzZKO3TdqeUMU9ZTd6VVtACCU9jvOabCx/Rx+ryMgCOLZpj+X+mz9Wxg6csT+09t+vXsu6rZDefEHo3+8BVjZ8O3FUQQZvyCJ5ArRKFwEJFukBRAH/dudKDN/6qP9CTAMcBVuq3Maz6HpZKD6qC2+x6Fp6Pd4kT+GSFuZ16SLX/CfrlbeId2igh+SxgAmaKjzMvnm7dEWcAAWzCNGT6iWqeSekeQQDQhQ1NldyMHwBzkcIDJNqmzwXoyScCRkZY/dkqxEcp4dIt5GDHDx1WgkXhGhLyHHfzBZFAm6MATYyP76/SQqTVDzaAwL7WMhMVCNEmZY2ybZe42Ge/zhhKKtL6VLo1QKqttT8v0dEvxjVI6KMxQU/IFEZDirWv1H3y4J/D3k9eTO53JBRtN7mej78Wm0FXRiOMSNLj1m5SXxzkFQ3BV6Iqrg+j2IwbSEnokMv/Br9sugaS+I4InLb5OQMq05dPNRhYtpvWv4HAph7DG8r9Y2rUsHxtAGjewaIn7xanwEIYygiW6n5JQgca25nlfW59yK+qesr0s08DrGXlBVEiRiUqsixZ7iefK/zXC+2s1zr8Nw0kIfJciWsyN13Af6YrDBXFCoGWYoQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH3PPFC694D094E.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(7053199007)(18002099003)(56012099003)(22082099003)(8096899003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EzWSNgoXsLpyboBtDWqUrNSXobSKoRPgNLrSrJRYP6jJBkscT/oiePC7mB6M?=
 =?us-ascii?Q?6Tf5x8fxynzOWZqSjzan18T/ZjpJ3p9UuReF8DoILt8V8Bm2ZKmtqHqIKQKU?=
 =?us-ascii?Q?Oj43j9EtWjv16U1zwvKi6t4RpLldGUoDGMyAV2eqal/gZQurhxEp3MGjV+p/?=
 =?us-ascii?Q?2+pekevxQMgYItBLDp0TdODuaWzefZxLNz1S56pNj0OpNVhqNrhFnUaL8Su8?=
 =?us-ascii?Q?2oqFgrdetwIWiZhztUi+eaunHQaEaDrH4N8HBJbSO5F909SZNGGn7hoyUeog?=
 =?us-ascii?Q?zEBhJllQuUF6eFpnFxb7NPzd+sJFvBXUdlh1FuC/BSzCIV0osbd/TcZTBqRF?=
 =?us-ascii?Q?9IZj34/lg8A0YZZPhFAy6ZZcg2/56iSfCFag/AcDim1piB+rs497gRdNuIDK?=
 =?us-ascii?Q?wwYnHTICwlP+GsTDYS//38eNY+G1tcD67ynKlvMM9ngtdDzakpVwbt+fwElg?=
 =?us-ascii?Q?o3o38/grup/tOI9X0h5wyOwVGDos+RbdWJCvV0qsudcN6cSGye+2GiBVf94v?=
 =?us-ascii?Q?K11RZ0ecWakUN+/ZqnjpJiskg7FvTWEp5dJ+3vNubLIDkjwcRfg3auCzVU/w?=
 =?us-ascii?Q?JUIGPvX0efBAiZvMNI5NdFYSOM6qY+/ghOFsptFEuy5sTD9kBYm9w6gAUV4h?=
 =?us-ascii?Q?jzx/BTCZpvQ4SthUM9ifzgcrSK0coQRWqGRlq9Yi70oBDTmav7gJ8AwP2eok?=
 =?us-ascii?Q?iLD+rYloP563gmzVrp8JbNTzMF7cPRDnJXZhFazzVmUefji7zg3ovffHUg8R?=
 =?us-ascii?Q?O96e5iqe6pF1Njs3u4sQ0VZWozxkZp4Q3bFfjtHBeICkUDs1o9+Rj+S39LC/?=
 =?us-ascii?Q?v+z9hD9pCGjil7HX5IxM5hbBE+daEL1Zv0xkk8sT6D18gu2l/8sz5KAFawQe?=
 =?us-ascii?Q?MceoE0sQ3avRO4NM3BWHYDWDgQobsZyKVMxo/HJAsCIdMYt7NEZZgAHrSHfH?=
 =?us-ascii?Q?rFzC/k01CUaKeOfzuFC2LOH1NFaumDxK/q7SEU4sHiXt4fSIxM7k9DfwxhiA?=
 =?us-ascii?Q?sDqIeo9Jq/OuBDGb4jT+/0oboz/BCRDdc/NAg+RG6arf64eiVF7tQlGigulp?=
 =?us-ascii?Q?92CtXr5eafK1ziP8NXkyt11PFEluLv1T0dM+h5QhP2oQ9WOdF9pUWjsM9ES5?=
 =?us-ascii?Q?MtEECGziCveboyfPfFBrDDDfW1cFvpGGiFlKiTieugMQm0QnAPJXr9+CKXF8?=
 =?us-ascii?Q?e8fME2qjX7oaDOSUIEZThAAzDOKm/58tLJZno1ceOuu2KXTfxRGO/UJNj30T?=
 =?us-ascii?Q?NCL+aGLxxqyGtG3SEc2MfiHahXK4K9hF693u5J3vyBlAEIuit3Vr3u4GDFPQ?=
 =?us-ascii?Q?M/VDg16wJoXftHGh5PUCWKyuGdt7+ugogtH8EYr9Uylm07LhhU6tN1ei81xW?=
 =?us-ascii?Q?k/oci4xb/zZ8U7a43WcZVraMT0hHYcWHJbK73Vw/MYlfsU9AeSPZAnde3DNB?=
 =?us-ascii?Q?05WyLXmbYKAiuPNI0SZHWFQOiunrzHdnOiGzGqpRdPvHV+Cl3jjOPPXWGlcq?=
 =?us-ascii?Q?jtNU6MWhVBSAKbZVjL7aaxL1lAq8yXETmFgee92WVm2dg2tHuvNRuGnEy6jK?=
 =?us-ascii?Q?63WYAn9OVe4u+nu5rHfdF9iEMqL7oIeNR5Tc776ECseYbmPbvzNyLeyMmlTV?=
 =?us-ascii?Q?7rYU6pZBi2dyCtDKffxBIfcaxTaFPN/8s+qPH/yE506RWzTeOtAAmEPBmZkw?=
 =?us-ascii?Q?rKXdsmhFqke/5yy3ePHi7Qnws9mDAFWvxcIrkVbH6+BwnEgi?=
Content-Type: multipart/alternative;
 boundary="_000_PH3PPFC694D094E8DE0CC5354D498C6EBC3DB48APH3PPFC694D094E_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: bZekKVvcSONOgQVQDG1xmJkcvWcnbkn9GpeGpxSWjuyFNEKM6456Zn8yHjDBMqumSbn9k6dJFEOmLwwwtgW5TjJgYD0V5oSXbcls04dRwKxsiMoIJwF6W2G7pouDLe8nSlyn5TQlWRV9DPYLXjoQBq5RlsNh1rmNjU3Z0181XLyByZw+/kpiE5hONvvYadZeuUTtg837Y+qFAbrarwe5Jct/zqdxr94yY1Y7wAOTf9eSSXIQ7eAtSCw/FAdgCuRLf+Pt8b28kKQ39bLf6Y3UgvNuh3lRtKu+I4Ys6+6rjWZAA8dNPt2fhI2X7C2SMo6IGZqKY1gA+4AS8UlYMVErPw==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH3PPFC694D094E.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edfe3af6-689a-4423-14df-08de8974251f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 07:08:26.4923 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 43i8s8ObPMtHpUbBDCc17TZ2uoyovBS8gseBwMZje8Dumcs4AOf1dMSiQvX13dBQ6NSLUfWWOVamtYPFlDRG2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR18MB4203
X-Authority-Analysis: v=2.4 cv=caPfb3DM c=1 sm=1 tr=0 ts=69c2386c cx=c_pps
 a=i2sOhMwyfBi0WFXSdCfb/A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=A1X0JdhQAAAA:8 a=M5GUcnROAAAA:8 a=RpNjiQI2AAAA:8
 a=QyXUC8HyAAAA:8 a=pGLkceISAAAA:8 a=8rWy6zfcAAAA:8 a=aG5E1VyZux3rfYgrVNsA:9
 a=lqcHg5cX4UMA:10 a=CjuIK1q_8ugA:10 a=BrI7-kzjZXSR1f6OrnwA:9
 a=2q4O/K3rjNU7EHYdBHB6dYyilSc=:19 a=xqj3blsoK2t1VVq9:21 a=frz4AuCg-hUA:10
 a=_W_S_7VecoQA:10 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDA1NiBTYWx0ZWRfXyxJnwhuZA2hG
 7HuwAy6bDAhhOgIhUqBM/831ZnFFmAx5BU3geR7VPON2JA4W9sZloUi826TVROXvpB6GBfIpF7b
 axe5OgmlHyInTi1do+Q0XnSf4ebL+JpchgzZh54u2dJGqK4TBVyAvVPolyLeQ3GffEqA81mN3vc
 FBV1WDmm5WteRC6nN7htFAYXNWUEByfgLUiaVZIJqsXEJWt758yd+x5x9T9Yx4wRE+GTrWQrbi3
 cm+iaBHUynXhHt52oDmw7PMfNTzg6wAUJTnXqC9kSdUNjqW3g9wOG8ca7oaQ4HuJsaT5hr2jxk9
 N67YnqXC3sVwwdjjLx6KKrsn74K7O4EZidBFFv5l1Xy8YZEjvv32URIvoAbKeS7eTq+02HgLote
 5jPbcFudNAGZ10gCHnAUNMkOvGWl83N/rooqiwXQTotTmSbJxhDJwvyt66NYzpe7PcOvjrlf8Fj
 +ekrvwYlLY6hVV6VM1w==
X-Proofpoint-GUID: RRO5TkL7XfZ8R5tyKleTRZAtUCpH-AH_
X-Proofpoint-ORIG-GUID: RRO5TkL7XfZ8R5tyKleTRZAtUCpH-AH_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_02,2026-03-23_02,2025-10-01_01
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

--_000_PH3PPFC694D094E8DE0CC5354D498C6EBC3DB48APH3PPFC694D094E_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Acked-by: Rupesh Chiluka <r<mailto:your.email@example.com>chiluka@marvell.c=
om<mailto:chiluka@marvell.com>>
________________________________
From: Emma Finn <emma.finn@intel.com>
Sent: Monday, March 23, 2026 20:38
To: Akhil Goyal <gakhil@marvell.com>; Fan Zhang <fanzhang.oss@gmail.com>; K=
ai Ji <kai.ji@intel.com>; Rupesh Chiluka <rchiluka@marvell.com>
Cc: dev@dpdk.org <dev@dpdk.org>; Emma Finn <emma.finn@intel.com>
Subject: [EXTERNAL] [PATCH 1/2] crypto/qat: fix asym session validation and=
 gen4 EC caps

Fix asym tests to return TEST_SKIPPED when session creation returns -ENOTSU=
P. Add missing ECDH, ECDSA and ECPM capabilities to GEN4 asym caps table. R=
eject unsupported RSA padding and EC curves at session configure time with =
-ENOTSUP. Bugzilla
ZjQcmQRYFpfptBannerStart
Prioritize security for external emails:
Confirm sender and content safety before clicking links or opening attachme=
nts
<https://us-phishalarm-ewt.proofpoint.com/EWT/v1/CRVmXkqW!te3Z1f8UYnW6tG-cG=
dxazuubvGPgl6yTU24HHC1z9RV5wPQjtl7qP0oEMSmeVZTwYYHqm4_Boxty5bBSBE8DJtAeSS0s=
7DY$>
Report Suspicious

ZjQcmQRYFpfptBannerEnd

Fix asym tests to return TEST_SKIPPED when session
creation returns -ENOTSUP. Add missing ECDH, ECDSA and ECPM
capabilities to GEN4 asym caps table. Reject unsupported RSA
padding and EC curves at session configure time with -ENOTSUP.

Bugzilla ID: 1903
Fixes: 064ef1b098d1 ("test/crypto: remove PMD-specific asym test suites")

Signed-off-by: Emma Finn <emma.finn@intel.com>
---
 app/test/test_cryptodev_asym.c               | 38 ++++++++++++++++----
 drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c | 13 +++++++
 drivers/crypto/qat/qat_asym.c                | 10 ++++++
 3 files changed, 55 insertions(+), 6 deletions(-)

diff --git a/app/test/test_cryptodev_asym.c b/app/test/test_cryptodev_asym.=
c
index 793cc5dce6..1515372a35 100644
--- a/app/test/test_cryptodev_asym.c
+++ b/app/test/test_cryptodev_asym.c
@@ -318,6 +318,9 @@ test_rsa_sign_verify(void)
 error_exit:
        rte_cryptodev_asym_session_free(dev_id, sess);

+       if (status =3D=3D TEST_SKIPPED)
+               return status;
+
        TEST_ASSERT_EQUAL(status, 0, "Test failed");

        return status;
@@ -368,6 +371,9 @@ test_rsa_enc_dec(void)

        rte_cryptodev_asym_session_free(dev_id, sess);

+       if (status =3D=3D TEST_SKIPPED)
+               return status;
+
        TEST_ASSERT_EQUAL(status, 0, "Test failed");

        return status;
@@ -414,6 +420,9 @@ test_rsa_sign_verify_crt(void)

        rte_cryptodev_asym_session_free(dev_id, sess);

+       if (status =3D=3D TEST_SKIPPED)
+               return status;
+
        TEST_ASSERT_EQUAL(status, 0, "Test failed");

        return status;
@@ -460,6 +469,9 @@ test_rsa_enc_dec_crt(void)

        rte_cryptodev_asym_session_free(dev_id, sess);

+       if (status =3D=3D TEST_SKIPPED)
+               return status;
+
        TEST_ASSERT_EQUAL(status, 0, "Test failed");

        return status;
@@ -1712,6 +1724,8 @@ test_ecdsa_sign_verify_all_curve(void)
                status =3D test_ecdsa_sign_verify(curve_id);
                if (status =3D=3D TEST_SUCCESS) {
                        msg =3D "succeeded";
+               } else if (status =3D=3D TEST_SKIPPED) {
+                       msg =3D "skipped";
                } else {
                        msg =3D "failed";
                        overall_status =3D status;
@@ -1901,6 +1915,8 @@ test_ecpm_all_curve(void)
                status =3D test_ecpm(curve_id);
                if (status =3D=3D TEST_SUCCESS) {
                        msg =3D "succeeded";
+               } else if (status =3D=3D TEST_SKIPPED) {
+                       msg =3D "skipped";
                } else {
                        msg =3D "failed";
                        overall_status =3D status;
@@ -1956,10 +1972,10 @@ test_ecdh_priv_key_generate(enum curve curve_id)
        idx.type =3D RTE_CRYPTO_ASYM_XFORM_ECDH;
        capa =3D rte_cryptodev_asym_capability_get(dev_id, &idx);
        if (capa =3D=3D NULL)
-               return -ENOTSUP;
+               return TEST_SKIPPED;

        if (!(capa->op_types & (1 <<  RTE_CRYPTO_ASYM_KE_PRIV_KEY_GENERATE)=
))
-               return -ENOTSUP;
+               return TEST_SKIPPED;

        switch (curve_id) {
        case SECP192R1:
@@ -2269,10 +2285,10 @@ test_ecdh_pub_key_verify(enum curve curve_id)
        idx.type =3D RTE_CRYPTO_ASYM_XFORM_ECDH;
        capa =3D rte_cryptodev_asym_capability_get(dev_id, &idx);
        if (capa =3D=3D NULL)
-               return -ENOTSUP;
+               return TEST_SKIPPED;

        if (!(capa->op_types & (1 <<  RTE_CRYPTO_ASYM_KE_PUB_KEY_VERIFY)))
-               return -ENOTSUP;
+               return TEST_SKIPPED;

        switch (curve_id) {
        case SECP192R1:
@@ -2408,10 +2424,10 @@ test_ecdh_shared_secret(enum curve curve_id)
        idx.type =3D RTE_CRYPTO_ASYM_XFORM_ECDH;
        capa =3D rte_cryptodev_asym_capability_get(dev_id, &idx);
        if (capa =3D=3D NULL)
-               return -ENOTSUP;
+               return TEST_SKIPPED;

        if (!(capa->op_types & (1 <<  RTE_CRYPTO_ASYM_KE_SHARED_SECRET_COMP=
UTE)))
-               return -ENOTSUP;
+               return TEST_SKIPPED;

        switch (curve_id) {
        case SECP192R1:
@@ -2668,6 +2684,8 @@ test_ecdh_all_curve(void)
                status =3D test_ecdh_priv_key_generate(curve_id);
                if (status =3D=3D TEST_SUCCESS) {
                        msg =3D "succeeded";
+               } else if (status =3D=3D TEST_SKIPPED) {
+                       msg =3D "skipped";
                } else {
                        msg =3D "failed";
                        overall_status =3D status;
@@ -2700,6 +2718,8 @@ test_ecdh_all_curve(void)
                status =3D test_ecdh_pub_key_verify(curve_id);
                if (status =3D=3D TEST_SUCCESS) {
                        msg =3D "succeeded";
+               } else if (status =3D=3D TEST_SKIPPED) {
+                       msg =3D "skipped";
                } else {
                        msg =3D "failed";
                        overall_status =3D status;
@@ -2715,6 +2735,8 @@ test_ecdh_all_curve(void)
                status =3D test_ecdh_shared_secret(curve_id);
                if (status =3D=3D TEST_SUCCESS) {
                        msg =3D "succeeded";
+               } else if (status =3D=3D TEST_SKIPPED) {
+                       msg =3D "skipped";
                } else {
                        msg =3D "failed";
                        overall_status =3D status;
@@ -2752,6 +2774,8 @@ test_ecdh_qat_curves(void)
                status =3D test_ecdh_pub_key_verify(curve_id);
                if (status =3D=3D TEST_SUCCESS) {
                        msg =3D "succeeded";
+               } else if (status =3D=3D TEST_SKIPPED) {
+                       msg =3D "skipped";
                } else {
                        msg =3D "failed";
                        overall_status =3D status;
@@ -2764,6 +2788,8 @@ test_ecdh_qat_curves(void)
                status =3D test_ecdh_shared_secret(curve_id);
                if (status =3D=3D TEST_SUCCESS) {
                        msg =3D "succeeded";
+               } else if (status =3D=3D TEST_SKIPPED) {
+                       msg =3D "skipped";
                } else {
                        msg =3D "failed";
                        overall_status =3D status;
diff --git a/drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c b/drivers/crypto/=
qat/dev/qat_crypto_pmd_gen4.c
index 82c5a40501..52577f6907 100644
--- a/drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c
+++ b/drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c
@@ -144,6 +144,19 @@ static struct rte_cryptodev_capabilities qat_asym_cryp=
to_caps_gen4[] =3D {
                }
                }
        },
+       QAT_ASYM_CAP(ECDH,
+                       ((1 << RTE_CRYPTO_ASYM_KE_PUB_KEY_GENERATE) |
+                       (1 << RTE_CRYPTO_ASYM_KE_SHARED_SECRET_COMPUTE) |
+                       (1 << RTE_CRYPTO_ASYM_KE_PUB_KEY_VERIFY)),
+                       64, 512, 64),
+       QAT_ASYM_CAP(ECDSA,
+                       ((1 << RTE_CRYPTO_ASYM_OP_SIGN) |
+                       (1 << RTE_CRYPTO_ASYM_OP_VERIFY)),
+                       64, 512, 64),
+       QAT_ASYM_CAP(ECPM,
+                       ((1 << RTE_CRYPTO_ASYM_OP_SIGN) |
+                       (1 << RTE_CRYPTO_ASYM_OP_VERIFY)),
+                       64, 512, 64),
        RTE_CRYPTODEV_END_OF_CAPABILITIES_LIST()
 };

diff --git a/drivers/crypto/qat/qat_asym.c b/drivers/crypto/qat/qat_asym.c
index 06f037cc14..beb5a27805 100644
--- a/drivers/crypto/qat/qat_asym.c
+++ b/drivers/crypto/qat/qat_asym.c
@@ -1483,6 +1483,12 @@ static int
 session_set_ec(struct qat_asym_session *qat_session,
                        struct rte_crypto_asym_xform *xform)
 {
+       /* Validate curve for EC operations using pick_curve (not SM2) */
+       if (xform->xform_type !=3D RTE_CRYPTO_ASYM_XFORM_SM2) {
+               if (pick_curve(xform) < 0)
+                       return -ENOTSUP;
+       }
+
        uint8_t *pkey =3D xform->ec.pkey.data;
        uint8_t *q_x =3D xform->ec.q.x.data;
        uint8_t *q_y =3D xform->ec.q.y.data;
@@ -1545,6 +1551,10 @@ qat_asym_session_configure(struct rte_cryptodev *dev=
 __rte_unused,
                ret =3D session_set_modinv(qat_session, xform);
                break;
        case RTE_CRYPTO_ASYM_XFORM_RSA: {
+               if (xform->rsa.padding.type !=3D RTE_CRYPTO_RSA_PADDING_NON=
E) {
+                       ret =3D -ENOTSUP;
+                       return ret;
+               }
                if (unlikely((xform->rsa.n.length < RSA_MODULUS_2048_BITS)
                                && (crypto_qat->qat_dev->options.legacy_alg=
 =3D=3D 0))) {
                        ret =3D -ENOTSUP;
--
2.43.0



--_000_PH3PPFC694D094E8DE0CC5354D498C6EBC3DB48APH3PPFC694D094E_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Acked-by: Rupesh Chiluka &lt;<a style=3D"color: rgb(18, 100, 163);" rel=3D"=
noopener noreferrer" class=3D"OWAAutoLink" id=3D"OWAc7cb2ab0-0e6c-462c-b31e=
-1c599c0b1041" target=3D"_blank" href=3D"mailto:your.email@example.com">r</=
a><a style=3D"color: rgb(18, 100, 163);" rel=3D"noopener noreferrer" class=
=3D"OWAAutoLink" id=3D"OWA357bd05a-b5f5-2c18-f0c3-4a2e2e651dd0" target=3D"_=
blank" href=3D"mailto:chiluka@marvell.com">chiluka@marvell.com</a>&gt;</div=
>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Emma Finn &lt;emma.fi=
nn@intel.com&gt;<br>
<b>Sent:</b> Monday, March 23, 2026 20:38<br>
<b>To:</b> Akhil Goyal &lt;gakhil@marvell.com&gt;; Fan Zhang &lt;fanzhang.o=
ss@gmail.com&gt;; Kai Ji &lt;kai.ji@intel.com&gt;; Rupesh Chiluka &lt;rchil=
uka@marvell.com&gt;<br>
<b>Cc:</b> dev@dpdk.org &lt;dev@dpdk.org&gt;; Emma Finn &lt;emma.finn@intel=
.com&gt;<br>
<b>Subject:</b> [EXTERNAL] [PATCH 1/2] crypto/qat: fix asym session validat=
ion and gen4 EC caps</font>
<div>&nbsp;</div>
</div>
<div>
<div style=3D"display:none!important; display:none; visibility:hidden; font=
-size:1px; color:#ffffff; line-height:1px; max-height:0px; opacity:0; overf=
low:hidden">
Fix asym tests to return TEST_SKIPPED when session creation returns -ENOTSU=
P. Add missing ECDH, ECDSA and ECPM capabilities to GEN4 asym caps table. R=
eject unsupported RSA padding and EC curves at session configure time with =
-ENOTSUP. Bugzilla</div>
<div style=3D"display:none!important; display:none; visibility:hidden; font=
-size:1px; color:#ffffff; line-height:1px; max-height:0px; opacity:0; overf=
low:hidden">
ZjQcmQRYFpfptBannerStart</div>
<div dir=3D"ltr" lang=3D"en" id=3D"x_pfptBannerj4wdga6" style=3D"display:bl=
ock!important; text-align:left!important; margin:0 0 10px 0!important; padd=
ing:7px 16px 8px 16px!important; border-radius:4px!important; min-width:200=
px!important; background-color:#d2d0d0!important; background-color:#d2d0d0;=
 border-top:4px solid #8d8c8c!important; border-top:4px solid #8d8c8c">
<div id=3D"x_pfptBannerj4wdga6" style=3D"float:left!important; display:bloc=
k!important; margin:1px 0 1px 0!important; max-width:600px!important">
<div id=3D"x_pfptBannerj4wdga6" style=3D"display:block!important; visibilit=
y:visible!important; background-color:#d2d0d0!important; color:#000000!impo=
rtant; color:#000000; font-family:'Arial',sans-serif!important; font-family=
:'Arial',sans-serif; font-weight:bold!important; font-weight:bold; font-siz=
e:14px!important; line-height:1.29!important; line-height:1.29">
Prioritize security for external emails: </div>
<div id=3D"x_pfptBannerj4wdga6" style=3D"display:block!important; visibilit=
y:visible!important; background-color:#d2d0d0!important; color:#000000!impo=
rtant; color:#000000; font-weight:normal; font-family:'Arial',sans-serif!im=
portant; font-family:'Arial',sans-serif; font-size:12px!important; line-hei=
ght:1.5!important; line-height:1.5; margin-top:2px!important">
Confirm sender and content safety before clicking links or opening attachme=
nts </div>
</div>
<div id=3D"x_pfptBannerj4wdga6" style=3D"float:right!important; display:blo=
ck!important; display:block; margin-left:16px!important; margin-top:1px!imp=
ortant; text-align:right!important; width:fit-content!important; font-size:=
12px!important">
<a id=3D"x_pfptBannerj4wdga6" href=3D"https://us-phishalarm-ewt.proofpoint.=
com/EWT/v1/CRVmXkqW!te3Z1f8UYnW6tG-cGdxazuubvGPgl6yTU24HHC1z9RV5wPQjtl7qP0o=
EMSmeVZTwYYHqm4_Boxty5bBSBE8DJtAeSS0s7DY$" style=3D"display:inline-block!im=
portant; text-decoration:none">
<div class=3D"x_pfptPrimaryButtonj4wdga6" style=3D"display:inline-block!imp=
ortant; display:inline-block; visibility:visible!important; opacity:1!impor=
tant; color:#000000!important; color:#000000; font-family:'Arial',sans-seri=
f!important; font-family:'Arial',sans-serif; font-size:14px!important; font=
-weight:normal!important; text-decoration:none!important; border-radius:2px=
!important; margin-top:3px!important; margin-bottom:3px!important; margin-l=
eft:16px!important; padding:7.5px 16px!important; white-space:nowrap!import=
ant; width:fit-content!important; border:1px solid #666666">
Report&nbsp;Suspicious </div>
</a></div>
<div style=3D"clear:both!important; display:block!important; visibility:hid=
den!important; line-height:0!important; font-size:0.01px!important; height:=
0px">
&nbsp;</div>
</div>
<div style=3D"display:none!important; display:none; visibility:hidden; font=
-size:1px; color:#ffffff; line-height:1px; max-height:0px; opacity:0; overf=
low:hidden">
ZjQcmQRYFpfptBannerEnd</div>
<style>
<!--
#x_pfptBannerj4wdga6
	{display:block!important;
	visibility:visible!important;
	opacity:1!important;
	background-color:#d2d0d0!important;
	max-width:none!important;
	max-height:none!important}
html:root, html:root > div
	{display:block!important;
	visibility:visible!important;
	opacity:1!important}
-->
</style>
<pre style=3D"font-family:sans-serif; font-size:100%; white-space:pre-wrap;=
 word-wrap:break-word">Fix asym tests to return TEST_SKIPPED when session
creation returns -ENOTSUP. Add missing ECDH, ECDSA and ECPM
capabilities to GEN4 asym caps table. Reject unsupported RSA
padding and EC curves at session configure time with -ENOTSUP.

Bugzilla ID: 1903
Fixes: 064ef1b098d1 (&quot;test/crypto: remove PMD-specific asym test suite=
s&quot;)

Signed-off-by: Emma Finn &lt;emma.finn@intel.com&gt;
---
 app/test/test_cryptodev_asym.c               | 38 ++++++++++++++++----
 drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c | 13 +++++++
 drivers/crypto/qat/qat_asym.c                | 10 ++++++
 3 files changed, 55 insertions(+), 6 deletions(-)

diff --git a/app/test/test_cryptodev_asym.c b/app/test/test_cryptodev_asym.=
c
index 793cc5dce6..1515372a35 100644
--- a/app/test/test_cryptodev_asym.c
+++ b/app/test/test_cryptodev_asym.c
@@ -318,6 +318,9 @@ test_rsa_sign_verify(void)
 error_exit:
 	rte_cryptodev_asym_session_free(dev_id, sess);
=20
+	if (status =3D=3D TEST_SKIPPED)
+		return status;
+
 	TEST_ASSERT_EQUAL(status, 0, &quot;Test failed&quot;);
=20
 	return status;
@@ -368,6 +371,9 @@ test_rsa_enc_dec(void)
=20
 	rte_cryptodev_asym_session_free(dev_id, sess);
=20
+	if (status =3D=3D TEST_SKIPPED)
+		return status;
+
 	TEST_ASSERT_EQUAL(status, 0, &quot;Test failed&quot;);
=20
 	return status;
@@ -414,6 +420,9 @@ test_rsa_sign_verify_crt(void)
=20
 	rte_cryptodev_asym_session_free(dev_id, sess);
=20
+	if (status =3D=3D TEST_SKIPPED)
+		return status;
+
 	TEST_ASSERT_EQUAL(status, 0, &quot;Test failed&quot;);
=20
 	return status;
@@ -460,6 +469,9 @@ test_rsa_enc_dec_crt(void)
=20
 	rte_cryptodev_asym_session_free(dev_id, sess);
=20
+	if (status =3D=3D TEST_SKIPPED)
+		return status;
+
 	TEST_ASSERT_EQUAL(status, 0, &quot;Test failed&quot;);
=20
 	return status;
@@ -1712,6 +1724,8 @@ test_ecdsa_sign_verify_all_curve(void)
 		status =3D test_ecdsa_sign_verify(curve_id);
 		if (status =3D=3D TEST_SUCCESS) {
 			msg =3D &quot;succeeded&quot;;
+		} else if (status =3D=3D TEST_SKIPPED) {
+			msg =3D &quot;skipped&quot;;
 		} else {
 			msg =3D &quot;failed&quot;;
 			overall_status =3D status;
@@ -1901,6 +1915,8 @@ test_ecpm_all_curve(void)
 		status =3D test_ecpm(curve_id);
 		if (status =3D=3D TEST_SUCCESS) {
 			msg =3D &quot;succeeded&quot;;
+		} else if (status =3D=3D TEST_SKIPPED) {
+			msg =3D &quot;skipped&quot;;
 		} else {
 			msg =3D &quot;failed&quot;;
 			overall_status =3D status;
@@ -1956,10 +1972,10 @@ test_ecdh_priv_key_generate(enum curve curve_id)
 	idx.type =3D RTE_CRYPTO_ASYM_XFORM_ECDH;
 	capa =3D rte_cryptodev_asym_capability_get(dev_id, &amp;idx);
 	if (capa =3D=3D NULL)
-		return -ENOTSUP;
+		return TEST_SKIPPED;
=20
 	if (!(capa-&gt;op_types &amp; (1 &lt;&lt;  RTE_CRYPTO_ASYM_KE_PRIV_KEY_GE=
NERATE)))
-		return -ENOTSUP;
+		return TEST_SKIPPED;
=20
 	switch (curve_id) {
 	case SECP192R1:
@@ -2269,10 +2285,10 @@ test_ecdh_pub_key_verify(enum curve curve_id)
 	idx.type =3D RTE_CRYPTO_ASYM_XFORM_ECDH;
 	capa =3D rte_cryptodev_asym_capability_get(dev_id, &amp;idx);
 	if (capa =3D=3D NULL)
-		return -ENOTSUP;
+		return TEST_SKIPPED;
=20
 	if (!(capa-&gt;op_types &amp; (1 &lt;&lt;  RTE_CRYPTO_ASYM_KE_PUB_KEY_VER=
IFY)))
-		return -ENOTSUP;
+		return TEST_SKIPPED;
=20
 	switch (curve_id) {
 	case SECP192R1:
@@ -2408,10 +2424,10 @@ test_ecdh_shared_secret(enum curve curve_id)
 	idx.type =3D RTE_CRYPTO_ASYM_XFORM_ECDH;
 	capa =3D rte_cryptodev_asym_capability_get(dev_id, &amp;idx);
 	if (capa =3D=3D NULL)
-		return -ENOTSUP;
+		return TEST_SKIPPED;
=20
 	if (!(capa-&gt;op_types &amp; (1 &lt;&lt;  RTE_CRYPTO_ASYM_KE_SHARED_SECR=
ET_COMPUTE)))
-		return -ENOTSUP;
+		return TEST_SKIPPED;
=20
 	switch (curve_id) {
 	case SECP192R1:
@@ -2668,6 +2684,8 @@ test_ecdh_all_curve(void)
 		status =3D test_ecdh_priv_key_generate(curve_id);
 		if (status =3D=3D TEST_SUCCESS) {
 			msg =3D &quot;succeeded&quot;;
+		} else if (status =3D=3D TEST_SKIPPED) {
+			msg =3D &quot;skipped&quot;;
 		} else {
 			msg =3D &quot;failed&quot;;
 			overall_status =3D status;
@@ -2700,6 +2718,8 @@ test_ecdh_all_curve(void)
 		status =3D test_ecdh_pub_key_verify(curve_id);
 		if (status =3D=3D TEST_SUCCESS) {
 			msg =3D &quot;succeeded&quot;;
+		} else if (status =3D=3D TEST_SKIPPED) {
+			msg =3D &quot;skipped&quot;;
 		} else {
 			msg =3D &quot;failed&quot;;
 			overall_status =3D status;
@@ -2715,6 +2735,8 @@ test_ecdh_all_curve(void)
 		status =3D test_ecdh_shared_secret(curve_id);
 		if (status =3D=3D TEST_SUCCESS) {
 			msg =3D &quot;succeeded&quot;;
+		} else if (status =3D=3D TEST_SKIPPED) {
+			msg =3D &quot;skipped&quot;;
 		} else {
 			msg =3D &quot;failed&quot;;
 			overall_status =3D status;
@@ -2752,6 +2774,8 @@ test_ecdh_qat_curves(void)
 		status =3D test_ecdh_pub_key_verify(curve_id);
 		if (status =3D=3D TEST_SUCCESS) {
 			msg =3D &quot;succeeded&quot;;
+		} else if (status =3D=3D TEST_SKIPPED) {
+			msg =3D &quot;skipped&quot;;
 		} else {
 			msg =3D &quot;failed&quot;;
 			overall_status =3D status;
@@ -2764,6 +2788,8 @@ test_ecdh_qat_curves(void)
 		status =3D test_ecdh_shared_secret(curve_id);
 		if (status =3D=3D TEST_SUCCESS) {
 			msg =3D &quot;succeeded&quot;;
+		} else if (status =3D=3D TEST_SKIPPED) {
+			msg =3D &quot;skipped&quot;;
 		} else {
 			msg =3D &quot;failed&quot;;
 			overall_status =3D status;
diff --git a/drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c b/drivers/crypto/=
qat/dev/qat_crypto_pmd_gen4.c
index 82c5a40501..52577f6907 100644
--- a/drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c
+++ b/drivers/crypto/qat/dev/qat_crypto_pmd_gen4.c
@@ -144,6 +144,19 @@ static struct rte_cryptodev_capabilities qat_asym_cryp=
to_caps_gen4[] =3D {
 		}
 		}
 	},
+	QAT_ASYM_CAP(ECDH,
+			((1 &lt;&lt; RTE_CRYPTO_ASYM_KE_PUB_KEY_GENERATE) |
+			(1 &lt;&lt; RTE_CRYPTO_ASYM_KE_SHARED_SECRET_COMPUTE) |
+			(1 &lt;&lt; RTE_CRYPTO_ASYM_KE_PUB_KEY_VERIFY)),
+			64, 512, 64),
+	QAT_ASYM_CAP(ECDSA,
+			((1 &lt;&lt; RTE_CRYPTO_ASYM_OP_SIGN) |
+			(1 &lt;&lt; RTE_CRYPTO_ASYM_OP_VERIFY)),
+			64, 512, 64),
+	QAT_ASYM_CAP(ECPM,
+			((1 &lt;&lt; RTE_CRYPTO_ASYM_OP_SIGN) |
+			(1 &lt;&lt; RTE_CRYPTO_ASYM_OP_VERIFY)),
+			64, 512, 64),
 	RTE_CRYPTODEV_END_OF_CAPABILITIES_LIST()
 };
=20
diff --git a/drivers/crypto/qat/qat_asym.c b/drivers/crypto/qat/qat_asym.c
index 06f037cc14..beb5a27805 100644
--- a/drivers/crypto/qat/qat_asym.c
+++ b/drivers/crypto/qat/qat_asym.c
@@ -1483,6 +1483,12 @@ static int
 session_set_ec(struct qat_asym_session *qat_session,
 			struct rte_crypto_asym_xform *xform)
 {
+	/* Validate curve for EC operations using pick_curve (not SM2) */
+	if (xform-&gt;xform_type !=3D RTE_CRYPTO_ASYM_XFORM_SM2) {
+		if (pick_curve(xform) &lt; 0)
+			return -ENOTSUP;
+	}
+
 	uint8_t *pkey =3D xform-&gt;ec.pkey.data;
 	uint8_t *q_x =3D xform-&gt;ec.q.x.data;
 	uint8_t *q_y =3D xform-&gt;ec.q.y.data;
@@ -1545,6 +1551,10 @@ qat_asym_session_configure(struct rte_cryptodev *dev=
 __rte_unused,
 		ret =3D session_set_modinv(qat_session, xform);
 		break;
 	case RTE_CRYPTO_ASYM_XFORM_RSA: {
+		if (xform-&gt;rsa.padding.type !=3D RTE_CRYPTO_RSA_PADDING_NONE) {
+			ret =3D -ENOTSUP;
+			return ret;
+		}
 		if (unlikely((xform-&gt;rsa.n.length &lt; RSA_MODULUS_2048_BITS)
 				&amp;&amp; (crypto_qat-&gt;qat_dev-&gt;options.legacy_alg =3D=3D 0))) =
{
 			ret =3D -ENOTSUP;
--=20
2.43.0

</pre>
</div>
</body>
</html>

--_000_PH3PPFC694D094E8DE0CC5354D498C6EBC3DB48APH3PPFC694D094E_--
