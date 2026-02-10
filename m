Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C26EA810F
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 13:13:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B99F240654;
	Tue, 10 Feb 2026 14:13:01 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id EE3B1400D6;
 Tue, 10 Feb 2026 14:12:59 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 619NTNYc2972072; Tue, 10 Feb 2026 05:12:59 -0800
Received: from ph8pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11022143.outbound.protection.outlook.com [40.107.209.143])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4c7s9q9far-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 10 Feb 2026 05:12:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q5RrafAG+FGiZjU0mE8fb+PaOfsJ5fHrjqGSOwkWQJNhDJjAPSWN8ya3m6RjU4Yiv65DBe4NWVSJnNc+2NJtu/KIDlAbqPn468K4jzZ6Ys6nHMgNYdNMh/rSmuJPm6r7JfalO9dr5PhbjlFLz6G9s5G+4zzTkAOieQgKnFr99DsUoxMybWESfa39yCheiaaVEVcJdMrn8wQ9we6sWC+cXAtDn/6SJUKn5AUsbYtUwJuYRxqnHvwlM7aHHg6fqNxu+RNViQgxV1mavNIEzZ7aSI92BAphigZ4yrlrNwalXtjNOKNM9U5K/j06wdZGzN/zT4P85RixSuJw4KaAhU2O1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6eVdIKeYtIB7ZHnCcNNPUgXrexWB0ycj0CQ7MMhmoKQ=;
 b=yCZxMN6Gi/G80kExe92O5ZqjXehgJPb8RLLensR2/+bS/K3OknM/XeTB7hsfDmWdV/S0klvB5L4EBEN5QD5Eoj6IVmUHu1hWy35GFJ/Hvr4egqqpcvYi0g6NR4xx5ed1GmoKeqF5H+nIXmjiimENFQeFnzoqOyW4Qt3h/0Q0/AUdIxlK2aRY9aLXRp45r00Qmp8qW69mIXhtdx1VCxIIh8m1COh96o0Yt6fz84itOXthuvbhLWzIAC1V5ilNpwbtRvXyrpqmJo6hSK3ggPJ++XZRTlSZh8el5ylzJDu8X8j2JkO4W0FF/8utTfv9jCNZFoGoIaGFxl1BUOBSp0ilnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6eVdIKeYtIB7ZHnCcNNPUgXrexWB0ycj0CQ7MMhmoKQ=;
 b=KsZLy/7o8ILXKPojuYcT2fCwWml8TJj8YYwExC38zRfrWVNFdJOtNK2m5HkZNSIcPjWpUCWz+dS9ZnGTMndvDQFaDsefzaZjWe8rvP68JiQsKBTnhOP8K1apCzQJPY/7V3NYmtHA1Eb454/YIgnfkhLoIUxms7vUQXzwhHkqzfA=
Received: from CO6PR18MB4484.namprd18.prod.outlook.com (2603:10b6:5:359::9) by
 MW5PR18MB5127.namprd18.prod.outlook.com (2603:10b6:303:1c1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.5; Tue, 10 Feb
 2026 13:12:56 +0000
Received: from CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17]) by CO6PR18MB4484.namprd18.prod.outlook.com
 ([fe80::a2df:a596:cfe:17%4]) with mapi id 15.20.9611.006; Tue, 10 Feb 2026
 13:12:55 +0000
From: Akhil Goyal <gakhil@marvell.com>
To: Anoob Joseph <anoobj@marvell.com>, Radu Nicolau <radu.nicolau@intel.com>, 
 "dev@dpdk.org" <dev@dpdk.org>
CC: "stable@dpdk.org" <stable@dpdk.org>, Volodymyr Fialko
 <vfialko@marvell.com>, Kiran Kumar Kokkilagadda <kirankumark@marvell.com>
Subject: RE: [EXTERNAL] [PATCH 1/2] pdcp: add digest physical address
Thread-Topic: [EXTERNAL] [PATCH 1/2] pdcp: add digest physical address
Thread-Index: AQHcY3jbLWptzkvI2UKMzP14DuShILURbIQAgGrqG+A=
Date: Tue, 10 Feb 2026 13:12:55 +0000
Message-ID: <CO6PR18MB44841DDCE85FA1BD52852627D862A@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20251202104550.849311-1-radu.nicolau@intel.com>
 <PH0PR18MB46728F2A4AFA7F76F6B53724DFA6A@PH0PR18MB4672.namprd18.prod.outlook.com>
In-Reply-To: <PH0PR18MB46728F2A4AFA7F76F6B53724DFA6A@PH0PR18MB4672.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4484:EE_|MW5PR18MB5127:EE_
x-ms-office365-filtering-correlation-id: 736c5ff9-0dfe-40a3-4a5b-08de68a61aee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?wirFadqqPf2I5oPZfDEiZmAUi1kZIE7pQcO6Y2rc5uGAJdlZkMY95AF9tW?=
 =?iso-8859-1?Q?icC5UOq34ZFZohPgEpcAt5SZuot0N9xtN7BnUhbLvLAQkfqVy9kKkp5BZr?=
 =?iso-8859-1?Q?IPfpddzysKrRNBm2BkFDg21sO3t21QbbAmDgFYd7/0HzWoCuNVSMiDLlEj?=
 =?iso-8859-1?Q?z/VuQTZtuWsDaSfI0yGWPMPZ7KvaDxYlJbBvTeJO29RHGr/9JT/kueLdhe?=
 =?iso-8859-1?Q?1v4VI2Zf/dcQiVy/hEL2eCFnIKw9OMCLebo+RDWPBHXdG4uuEltFAJcY3E?=
 =?iso-8859-1?Q?2Js4ND+YUhF5Z4mB9QYOjY2wYYhcD1vpBgw8Cl801aaXuWh4jNrJdwiYyY?=
 =?iso-8859-1?Q?k2YbmeSa6IBHkMneRp7TiS9h0j/lW57Agw1JNikN+h3pbz2Ss3QzzrEZlk?=
 =?iso-8859-1?Q?66xGThPQVijGaqeULsKgxfMvKXi6XQ9syL/w5Q9xyAx86WnJsqr2iFI08Q?=
 =?iso-8859-1?Q?sN//MP7ABUIIUZe2nULHrGsReaXwrDDLIeR6NAfRPcWOu7yFcwCCLh4wIW?=
 =?iso-8859-1?Q?69dWuYNbw/3AfEl8ITaEH69sNOxf6p5U6gnOCP1HHjNIDLEjPBac6KGX+E?=
 =?iso-8859-1?Q?8ZNUAc/ajhRydv+zxrp8Y2eJrI6z/a4pSxJoNALGQXkbuLFIo2zm1BMHUd?=
 =?iso-8859-1?Q?AIGLlrwChZt6+doYMKCxxOM5EuG+mvdnSDAVpeFsZjHl1XSuSUizgi2aJ0?=
 =?iso-8859-1?Q?WFVTj/icRD5SnTJnfPAgaoEfZNhoSr7xem7ChAbmXxjVi0aEGyotbjas8C?=
 =?iso-8859-1?Q?S0S9exwrdmyRtgm3pORyExRoViRL9xXdfkGqMClRBvWOVnUNDI0jltloe+?=
 =?iso-8859-1?Q?rxkfMbSTYdE/Vn4fiwMjfkMQhntZC86L2Sj1pg1/KL28vMwfyTBZeqmOBf?=
 =?iso-8859-1?Q?r6IIXdWTXE6NA4cooLkeopQhqn07+Xa9z7027l6j84ntRMnC5FlKr5KEZ6?=
 =?iso-8859-1?Q?bgEM2BRR5Bm49BasjU46qsWu5hLmw6uf9R57Zzo9Pl9o+T5KmrbO0cPg6F?=
 =?iso-8859-1?Q?3hFgmSYipur7DJvrdVIWjTVpwQynuFCgCy+lkf5FgxhxjXjAHcdzAZwaeM?=
 =?iso-8859-1?Q?AqAkDXjUqjF8Sof2m1cbufCTjoElM7BNWNbkuHpKrDZpcmOj00i8c4cc+e?=
 =?iso-8859-1?Q?LGVbwzktQE/jPpOTY2CpskuT3s5uvat7lQ/yKW4xsYp74KVt5Cu1HeoXFO?=
 =?iso-8859-1?Q?fhmIQpatkqlUVtrLSAW1VZoRxaaHPv9BHk88X1IvAX24my/N2Sbhfnfl9o?=
 =?iso-8859-1?Q?OFwiWrA0LNNPNDZY33kiSpjIDMruy5lEoNV4xzS3vW88VWP8RIEble1Kdb?=
 =?iso-8859-1?Q?GZqPBIAbSjUmJrAatdPSLzSkxMFgge6HCnuGz8wNV2uSHxsIVjUzKn2dKh?=
 =?iso-8859-1?Q?VsCplXFk5UjPF4qeSNK1qF1+bV8XM0+jktk0u5kZI6G/NS/08kyP1s4Shq?=
 =?iso-8859-1?Q?03Px4zNeIHyNhcNspAcqFWujYvvVz6wfdCGAf9dm4uXLE5aKAjcbwHEk/P?=
 =?iso-8859-1?Q?2HC4iT6dIeN1fhrSPxFi6mClu+Qs9l3y4csXC3IOjZTLtPzeMSrvoT0L8d?=
 =?iso-8859-1?Q?NknCpOrETJkZNFSEoINsOB8zP5UhXsuMwZ/m+49/jgJMynyghUx0n7lKDE?=
 =?iso-8859-1?Q?evJMkS+3Y7ThnzDleaVi0gc4iujL+PAl8fW73tQCQpHOROSeArsTDdZmEj?=
 =?iso-8859-1?Q?DOHLkkm7QqIwT4/ytAA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4484.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?8cTxWRs3rjVLroI1CGmJadhhSFUWVY1GlcTC1dVmY/jQ3CQKY8mK3vAuTu?=
 =?iso-8859-1?Q?cb4eO3yecMBfcmWHhIn4CHjTGpQgc3qufjv1j2hUNXBAudz54wJMueVWAo?=
 =?iso-8859-1?Q?JfpUDekc8dCwe1A6FmXKlfNXFJJsaUdvjoryA89k/pl8srkUD+jR1hsGSm?=
 =?iso-8859-1?Q?CXF7dWAwR3Knp3oyH5CRAadZm8D7Y2LI9a+enFoPbgsSjO5gEcXxLd1D2u?=
 =?iso-8859-1?Q?pTDzkYyNp7W1uVlF1TNQcshgGdWuThGezV2d9fICm8P5dn+8Q5t3MwTvuD?=
 =?iso-8859-1?Q?Q7j3gOQlR7onywdCpE0gBoZsknrELXIns96QB7DSWPfLENjMpLDPD7XsCq?=
 =?iso-8859-1?Q?yPgjLXYWrm9qAoRwWpbFTonlzFzd6RVe93TMf9OpSVi26iz4kGwdeNJJqv?=
 =?iso-8859-1?Q?ZT0iNaZMknEFoJVq7sPkJ3S6pu1cAZJLBUOlQVZsw4/RGtj9QrUdbel+ib?=
 =?iso-8859-1?Q?bWJmoXcUpCgrVIM5HkQ6qDLmU5PfssNH1TL07aM6XErCnuN6kzlGiojeCF?=
 =?iso-8859-1?Q?5A1sh4p9ssxqKvR1ZD0Xd62w6LiJO42TEe6cKQyZe1QgjGPRKwcjUq87jk?=
 =?iso-8859-1?Q?rPZbYMCeMqC7RbpyHGsSrNuXd9ln6ZFqxQx4rLHtBeSVKSJ7lf1y88p5L+?=
 =?iso-8859-1?Q?DCPZOs4nkfITI+CbKgqjUn+b3QcyXqunAuAMqx51ZNDRRH0osubkWOXRLc?=
 =?iso-8859-1?Q?ihPz1bd4OCJga23KjhQNdLT00lvpFVfQpdAy8t+dLXLA8FtgHJOh9eagBw?=
 =?iso-8859-1?Q?+uFhUYrMZkP9L5ZYG+WxTcKEYq6GxbBZDZqCeZOvagHoL7MqchQCQYYI1F?=
 =?iso-8859-1?Q?hhYyRSawPwMPFTra92/EuwbHFro4QCH9fuzFfdEZb64EKMXdt5yAwb8Ku9?=
 =?iso-8859-1?Q?bhGb0MRmFvOzI7ya2PSbWPCDrMR6R7ge2uPPp0Ie4lIQONaEhaGdXgL8FH?=
 =?iso-8859-1?Q?PLMXJkIXf67y8NeVzHaIXM3h/mHbqfxqV5OFDAA0rNSwYc76NlMtySeWAn?=
 =?iso-8859-1?Q?eR635U41cNeRO7uIkK77wyHAnUS57L29UBBJ34LMgqZKYDZRo2t3OXuze2?=
 =?iso-8859-1?Q?6YVQBS/EfFYalhzsY7wOFgJKic7oI884MfcoQa3dneEMlaTeQ/UpBF6lNE?=
 =?iso-8859-1?Q?jxz83sEkQ0ycCfPUw/W8bEddb1LaylTD//M+BehZdNH6SgKQA3bCD94RjA?=
 =?iso-8859-1?Q?1Ijj1ICboDfh5ROOo4qwj7V10qHWM4D+jSZhuyeusmgFXf2Uf3384oc+X0?=
 =?iso-8859-1?Q?Ru+e0j7lXIrimqKZfDFt+zS+UtnesFuU7g48g2iqPtTo5rReobOytU0+ie?=
 =?iso-8859-1?Q?9lV6WXPRkyAaDjNkL2+SSG1i3+neQKm1o6U2bU6fsVLWeNRJXzii5Uq57r?=
 =?iso-8859-1?Q?8QReRxY4ubzH9qh5SEQHbNmdoVopmCGaIC61ujxjBLxvqQjC4ZT5cOPqgo?=
 =?iso-8859-1?Q?jPCU7V8hlmzmPl1qSwcT4z5zZiItx4Xdg0HlUEtRII9wRWvAMkk8PkvKAZ?=
 =?iso-8859-1?Q?WFbN/3WnR/+Pvfa8YbaoG9qci6Gt3o6RG9/9f5xuPqKPPm+o9ppsbVxAUL?=
 =?iso-8859-1?Q?UT5HhBrMAOnABgDKUS/hTlFloD35qt5Ht8//EtvxKTdIUDeRMMyoAfFJCB?=
 =?iso-8859-1?Q?TL9rgMAVS/VTj3Hmma2uJTvt7L0fmzHymqoLEp/KQiPxJ68TYgpGoBElcy?=
 =?iso-8859-1?Q?7A8ZEtIxFRM0drDK6vKifEKEYOx9SVBTiptjIDoSQECmwLVUCoXhMk82/s?=
 =?iso-8859-1?Q?ycqSRHW76YkLG0m6yD2fcpjbs9m1sSAgVdcUEfSQJL2fEs?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4484.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 736c5ff9-0dfe-40a3-4a5b-08de68a61aee
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 13:12:55.8626 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qwDAGBT/cPVFPKpLpAWB9NaruDe7qc3lyZBRAQZq0QhnIeOMEgzIW3nrNqxh6XJxH0ju/PPHF/WIdD+uX65dNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR18MB5127
X-Authority-Analysis: v=2.4 cv=a/g9NESF c=1 sm=1 tr=0 ts=698b2eda cx=c_pps
 a=btghaJn+yvodkV72VlSluQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=HzLeVaNsDn8A:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=8rWy6zfcAAAA:8
 a=QyXUC8HyAAAA:8 a=M5GUcnROAAAA:8 a=Dvh7iZ5SR_C3IINBZ-MA:9 a=wPNLvfGTeEIA:10
 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDExMSBTYWx0ZWRfXyC4GErOHyssd
 zsxASvBb43IuDfM/yrZ/4V/zags7K0zoCnAkFF2Pixjp9EjPLcMOLomIOIizOFJdBstzF9ikLTg
 bfI4abYKp+lWHlREUJZoHqfQLqj9/L6xEptNBhsdE7B+Gb4ByPH4IYh9s7xN7EdZXeLOa/QlXL+
 EgjkKgyl25+jVel7d6i5ttmF3HwWPHXjVwWrglhWM6WbAAGA1bjYUbw9uJ/lNg2zxd7Lz/LZ4zS
 LDSvPHKMD4QbkNQkrCR7IeyOl3q1oJqQ/1Nx/KOdG1T8MWoFUCcM85dVyy5dZHKD2uSdAJaNw0u
 K4trfOTdA8Rcp6lKAzpVH5tYQxEpTb1allObkp5kjBARkwAMlZtmMJNs4GAolSMfJx55G8Ar4Mn
 xCNYP+i1dBkd9gMm/EkchY8lpGUDfBO49bfcI82Q/+kYBx12kQhRgJ2Sn4C9j7gGmmcOto34CvA
 Cw/uFKCzn8dfhQskfSg==
X-Proofpoint-GUID: At7Bqy_YpYKIrn6V4I7cOoyR9e-XWzhI
X-Proofpoint-ORIG-GUID: At7Bqy_YpYKIrn6V4I7cOoyR9e-XWzhI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_01,2026-02-10_02,2025-10-01_01
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

> > Subject:=A0[EXTERNAL] [PATCH 1/2] pdcp: add digest physical address
> >
> > Set the physical address for digest buffer.
> >
> > Fixes: a785af14ff79 ("pdcp: add pre and post process for UL")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
>=20
> Acked-by: Anoob Joseph <anoobj@marvell.com>
Applied to dpdk-next-crypto
Thanks.
