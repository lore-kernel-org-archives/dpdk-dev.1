Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 610A2CAC5A8
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Sep 2025 11:06:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 196EC40288;
	Thu, 18 Sep 2025 13:06:58 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 768E54027A
 for <dev@dpdk.org>; Thu, 18 Sep 2025 13:06:56 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IAHPwG028474;
 Thu, 18 Sep 2025 04:06:55 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2137.outbound.protection.outlook.com [40.107.93.137])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 498g6m8414-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Sep 2025 04:06:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ijhdHSBBu/pEkIJ4/flQqPey7Ore//Uf0XM6doTYgKu6IK68Lhc23Br1QWBsHtYd8wO3qyTgXm2wvSEueBierTLJBmuII7AlcBVJABhsbyZxGxa2RMZcKEX1DxfR0LR049TNskC6Xg/YgzKXjZVQJrYWKLC4xB5m4JhGzI3TJKZbUs3xF7XiZWQcTV217mD1yDeBmuX+DkePTt2ZuXMrgKE/C2EYdIZD3bp7qqQG0zKyZTaaueAOHg7/TOMFMylfKezY5Ma8zacMf1WkLgaeIRKYNAeFwFJaTE4Hk5IaEf9GITJ6F/aQ00m6Dt4LRJpjNq/ae4RN581IPGztBAqnyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xsrqoswoTEOMMlSboQAT8/Ydvm/0n/2A9LjG6iIDhyA=;
 b=chVtuNMEd5ZwJE8JqPItzY4lIKXeJjV5sftzV57bk9H1sUoB4xaOdiTcNxxLAZHT8ItbV8gJmR0g4dB0Tn9Y9DGcxzjPYNFn0+vrJ8ZhVuisiqUtCT+nEjf7sRfCHuEW9XFjcZe8lMmS7GjIOjwJaCjBzE5yO1vrifGVnmMVXBfcgi5iwBwxlYvPb+bqkDHJAbUsgh10ndPiiChUR2sP7Qrmh1HRmQttXhdcZT1QdYnI8Q2aL+RF3coFVPentRX/H23x798lWpvsPHiUm22hnCAZg/c991/UIC0osIsPNn+eDTbBxjZ8WMIoSgc8ETQJQhrnWs8yuwuYkMmYVEjCjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xsrqoswoTEOMMlSboQAT8/Ydvm/0n/2A9LjG6iIDhyA=;
 b=B9sRHYI7UnilwKYEeiCCyADbeuFnisIc36Fi6cRADNWEYLxntiCye4ly/NzGFm8mIgQ2XtM+o/HS/hq+y44s0yUw7ujt2YspcYClrE+A1XElQ+zlBlSdTOOaQGsvZBKFbiHw4AtPxmbVYZqoHVdf+L3GS5ZLJvYUEv8HHr1azKo=
Received: from SJ4PPFEA6F74CA2.namprd18.prod.outlook.com
 (2603:10b6:a0f:fc02::f4b) by DM6PR18MB3587.namprd18.prod.outlook.com
 (2603:10b6:5:2ac::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Thu, 18 Sep
 2025 11:06:51 +0000
Received: from SJ4PPFEA6F74CA2.namprd18.prod.outlook.com
 ([fe80::2a2c:7ed8:2041:544b]) by SJ4PPFEA6F74CA2.namprd18.prod.outlook.com
 ([fe80::2a2c:7ed8:2041:544b%4]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 11:06:51 +0000
From: Vamsi Krishna Attunuru <vattunuru@marvell.com>
To: Vamsi Krishna Attunuru <vattunuru@marvell.com>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: "fengchengwen@huawei.com" <fengchengwen@huawei.com>, "thomas@monjalon.net"
 <thomas@monjalon.net>, "bruce.richardson@intel.com"
 <bruce.richardson@intel.com>, "vladimir.medvedkin@intel.com"
 <vladimir.medvedkin@intel.com>, "anatoly.burakov@intel.com"
 <anatoly.burakov@intel.com>,
 "kevin.laatz@intel.com" <kevin.laatz@intel.com>,
 Jerin Jacob <jerinj@marvell.com>
Subject: RE: [RFC] lib/dma: introduce inter-process and inter-OS DMA
Thread-Topic: [RFC] lib/dma: introduce inter-process and inter-OS DMA
Thread-Index: AQHcGzy5YkOIwkQZ3keJnCVDiFvIxLSY4ZDg
Date: Thu, 18 Sep 2025 11:06:51 +0000
Message-ID: <SJ4PPFEA6F74CA2B00528C5655954B002A3A616A@SJ4PPFEA6F74CA2.namprd18.prod.outlook.com>
References: <20250901123341.2665186-1-vattunuru@marvell.com>
In-Reply-To: <20250901123341.2665186-1-vattunuru@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ4PPFEA6F74CA2:EE_|DM6PR18MB3587:EE_
x-ms-office365-filtering-correlation-id: 7ff3788b-8d9f-4345-67d4-08ddf6a37823
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?dX4TwtIYlzzH8O3dfQBkRuF+HjIpCF5Fnhyz0e15aIhJtArAsqEuEbbsQG6+?=
 =?us-ascii?Q?FYP6P1mjPKpjDyVoPMRLhfglNRHqJChdBkN/FMNbpG6UuhQmvbS2OPz5qotS?=
 =?us-ascii?Q?w1JyAPN3IgwFYryYlGR47RNXqzzqaYu9S7jC4WcE3aOeB/zcUi2I1x7xal9o?=
 =?us-ascii?Q?Ho2/ETZ4GHJv1vpVdmEdrWh+YbjuS62H/N/Wb0rGyrPP3Jx5XnRVwxUcmR3U?=
 =?us-ascii?Q?QeUkjsAU/9VQfPcWXWQUWlE4b7wAv99fpTPwwm0cIyP/gqEsYkY3lNfQbw5Q?=
 =?us-ascii?Q?Em+X1FRtfi8qUJk1RxpUNdvgu7dOiaHF7DZEuWuYFtz/5SmXFaOLlS0cdGY1?=
 =?us-ascii?Q?chbtzFIigC9QbrLJuNs+bjLIs46sGvhlySS6CAcxhmK3s2DdBGZU1W4I5kD8?=
 =?us-ascii?Q?RTe4JK+x16t22+KOzv2gT4wQ+/VhE/B52VK5yJVvjOc3Uuy3sqvsa01gK9Qa?=
 =?us-ascii?Q?PsqGBQHRzeqmvHoVW9iXcC0a1VqSpjAtq3yaLXPV1Et38mYhv5psBpSMLUis?=
 =?us-ascii?Q?y1NAYqDzkGQxcr8I21s5y5uNCKjj2UOXzb8VdZwpZUp+hlu+Oyg3IELrek8Y?=
 =?us-ascii?Q?HNt5VKj/tWcwmkGHp96guirLUL/h4rtsmQHgM0L4AOs66yXnG33yV1AVTWSN?=
 =?us-ascii?Q?KZp1qV95+X65o/+fL+L/2CPe+jJXm5YwAxYID27e5LpRfcrpB/1uod+yh+e1?=
 =?us-ascii?Q?PHSCh6v6Q8AbciT3Tt4b6zXZBLHazqtKqhRsSPMovawpr66EGjn8I4vqMw5M?=
 =?us-ascii?Q?5ySaSwJ2hY/IJoSds3ZvE9T6HgPLkMQnjnOu79K/6CiBAkSQhWKdoBQwU3jo?=
 =?us-ascii?Q?qWqG+Rbm5e19LHbz9lexniC3Cr3DcVLfEgwn+rEfUWhs+JpG+GNcjpZO8WJZ?=
 =?us-ascii?Q?svYLb5WoC4WTnSPj09AWX+RNKcEDarGqPOsu7mjsBHsn60e1/VUpQaPBr5Ji?=
 =?us-ascii?Q?xZJ1iMwZ6mnN6Ou/UnlXL57T7F2h+yPqtaBiYVRFsaAXGplelnjJ4bTTZ3RO?=
 =?us-ascii?Q?zVeZgnI+CFvEzgc496btZsdL9OxMZlEaN8ZcnYJwFtPpddEHcAgs5qN8uZdD?=
 =?us-ascii?Q?J2QD5wcsL+TM3oow5PD6mWoTwhdA6F5hFGFGXIdbFrbRp2p6WPT170HUVbZH?=
 =?us-ascii?Q?MTtBY9znimg8LXLbuojWeC4FbnwzeWyAvZtBK6nK/Kr/2rnHK5+TC7LyJQ0M?=
 =?us-ascii?Q?1G5G8j5wH3gbzQvnIFLGyWRvdYPmnGc9ZxM4B33OTD+7uEAcyRyN105g+bs/?=
 =?us-ascii?Q?c8BfAUSYAD9gnVeJ5adwIZJf8CKFrWZxYwDNDa/Wbyk9XzjfhjAixoYoXflZ?=
 =?us-ascii?Q?joM9d/vj1rs6LHqOmeVWl2UItAp31tdAukxhEQMPxkL+F1bTZuz8s3g0aPBL?=
 =?us-ascii?Q?UtoXmAzSSenvcUFITdIbwyPLq3H/fzhg+6bF39efPZAbRaNDP+LyyK6AdJRc?=
 =?us-ascii?Q?ZvPtTvfrD9vEHbQXGyDxvzT16WLNuewywvyl7yvllzvbVZ+KLcqWbQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ4PPFEA6F74CA2.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3J7OQqLafRUH2WydzoahmSr294lU+ZyAtn2dz8qBR/Mo5GOUF9qkmQfCiBo7?=
 =?us-ascii?Q?soWEMKw0NH07wqHnt6lbqOnSeCIzoLUWEB3wQzV/LXZWRewhpfPl/lbk/rnz?=
 =?us-ascii?Q?s9dTpMYOYnKjMWYuf+WAf85BBZEA3BwEUi3ouLzdejWnZLhrB18Do7KBAOmw?=
 =?us-ascii?Q?u+1S21qmdc4f5f6Wx71ZiAwxq7wSsE3fX8eKT7qKmzRKwcP6tYsWweDIRTmt?=
 =?us-ascii?Q?DnfwMZWWd2uzBpHdlCM+S3l+YcT1heM+sIf9QP/c+kRettD5bJoOA9db7SZ/?=
 =?us-ascii?Q?V6jEm63Ruv7ExUbX1OSDCQtWlz9iMhdzuhxPZCkRiCBwav/HABJGrrXB1wxE?=
 =?us-ascii?Q?VBuwhFkZGVj8Im/iuLd/hlM9GWAVFqUZjarkqlATQcgKJKd8xxct0mSgDRxM?=
 =?us-ascii?Q?FowzYDasKyps3zPkSqu9DmgVN1XjeC7R0nEvzlyLhcirTItsbj0eb1sbmhI9?=
 =?us-ascii?Q?n8VLOyX41qAGBwXVGzPsW1seUmmDCHFrENFXECJ/+zfk/T7VyedeEWRS9efr?=
 =?us-ascii?Q?L0tLD3Spf1XqbCMHmT8oYmd6pZT5v+qVZMXJUdp4F2rQueMT0AgY7xGFmg0E?=
 =?us-ascii?Q?kdsDoySk614iIIYMCSc0IXAQE0CJ2rw3AzmV4R9xOkBPnebF4QwiWfh/GIF0?=
 =?us-ascii?Q?DEsfxFWtezNc6p3GFgYKPV1xtffzz1O36ZOyc6RE7adAU+iZgZfzJfcvkmRf?=
 =?us-ascii?Q?Kp+qNFHRI5CO7VvLfCKG9/hy52PTK/XEU0dVDnbxKDXUaDmvStxX08cq7Dcz?=
 =?us-ascii?Q?o5pGiaEeJk/jeGKlEGgnMjP1QwWup64HkuDxE7PcCLSrGgqZpYnAqu+XI4g3?=
 =?us-ascii?Q?hYXYujwB4ZwEFwEmX+wby7ftPde1X5zZQysO/Fwyxovwm0mMJcsOKi577H4g?=
 =?us-ascii?Q?wDot+lC7FPxudYbtU8bwaoFpisE/kFwXztC2wbGc4/yaa+vM7XvG3Idbd56Q?=
 =?us-ascii?Q?2JN3gv2s1PBLnqtRZxX7KvvfqFsHNpjmM9DcPitvOnDURnmrh/qIZKv2ClW1?=
 =?us-ascii?Q?yzcU7qVfe7bIyeusB2oLCxLVwHmlzWCANHGFEaucuJ5wgbfCqPKA/BPf/e7B?=
 =?us-ascii?Q?5IH4lB9jbPAJOVFiON6grFrhmX7RWF3CM8fsyBpXjKMTcxcokFN219/bzUyL?=
 =?us-ascii?Q?Zx/ZywT5KRwFtNDf/AUh4wVYhaSF0ExboTKTHDro8hB2wLuFI73UGY6WhYie?=
 =?us-ascii?Q?fHeKSmVqcUGCt2evpEfEtI5hGomO0iMJ6OUMvfXg7MU5zl/QzTCk4/toNwvL?=
 =?us-ascii?Q?qilYP91XcqqqDDKOdEYMpMUN54grxIqElxzzvpM4BcEVDc9lzmmqMyA2vhbN?=
 =?us-ascii?Q?4PlNijJffvIaX3mjWfcGKWS5tsQ86VB0iSFIyRxbGkO3VMhggrHJGv2PbNTo?=
 =?us-ascii?Q?sSeDaxdV6aVvNCP/y/zBUl5FycqUg3BTwj+8eEApPA6x85h8g4rVMz6qfrHq?=
 =?us-ascii?Q?MxfrlotCXMpMvKrUrPra9P7DgFoj/X4mwL7ThFL9PTjSf63LR86esmnUwFNo?=
 =?us-ascii?Q?pe6siijcWXQZvm5c/M/oLNfPHoK7jrjOk6mlGQm93pTrpHlefJNm55IR34g0?=
 =?us-ascii?Q?LCv3Bu21w5u6FmSAEj5EkimiAeCjgzbiolYLTss0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ4PPFEA6F74CA2.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ff3788b-8d9f-4345-67d4-08ddf6a37823
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2025 11:06:51.1975 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DcQ9Vcg3z4LB6S/bGSsJt6GZrHzHqGRF1JDVuZ3RHwfmh1dftmdPKHySeO8H7Y7jLSmvcejoOh/FsljzE7VbQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB3587
X-Proofpoint-GUID: WJXiEisyp78yFTw5Yox-3fh1vSNEztaA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE4MDA5NCBTYWx0ZWRfXxEMfnq1OeYar
 NiBIenJGUNcw0vTNBJc60CcYagUs0VPrskXxf049uOvOZV8UhYQuedwysm06DNwisePw8gedUNZ
 3wRynj5/XmZGfVaHUg087WsYhSTseaOVpT3049hPuopQCqlsEozhs83WQhArkoYY20uuMlMfDXT
 DvqYhogFd4DzAbZI4TEqEW209t7kLP+eD0ZeoDbIHBE+Hvg0lsj4iyT12IZBZQyI1h7o7pmuN6d
 0S8wrg8DQm2BExKAnzCUrldbCrOxv9ZsR9PSnc+DzoN+auv7FUwxhe/LrV2k6J/hV6BItL2SeDw
 TpHXTXKubuXf4gp9BSPAZytmhyd+diiGYs17cUhb1vF014BqgC/0w/IAlnJd2hyvO4D5Mwy7adr
 YTJxJWdX
X-Proofpoint-ORIG-GUID: WJXiEisyp78yFTw5Yox-3fh1vSNEztaA
X-Authority-Analysis: v=2.4 cv=F7hXdrhN c=1 sm=1 tr=0 ts=68cbe7cf cx=c_pps
 a=VX/sFGoG5OGT23SVPy1oZw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=-AAbraWEqlQA:10
 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8 a=i0EeH86SAAAA:8 a=bt5KbKNvAAAA:8
 a=QyXUC8HyAAAA:8 a=f2lqtYuETKqCj9CHLVAA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
 a=a-zEBD5cKgE7DNtTSb7C:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_02,2025-03-28_01
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

Hi Feng, Anatoly,

Gentle ping for the review.

Thanks

>-----Original Message-----
>From: Vamsi Krishna <vattunuru@marvell.com>
>Sent: Monday, September 1, 2025 6:04 PM
>To: dev@dpdk.org
>Cc: fengchengwen@huawei.com; thomas@monjalon.net;
>bruce.richardson@intel.com; vladimir.medvedkin@intel.com;
>anatoly.burakov@intel.com; kevin.laatz@intel.com; Jerin Jacob
><jerinj@marvell.com>; Vamsi Krishna Attunuru <vattunuru@marvell.com>
>Subject: [RFC] lib/dma: introduce inter-process and inter-OS DMA
>
>From: Vamsi Attunuru <vattunuru@marvell.com>
>
>Modern DMA hardware supports data transfers between multiple DMA
>devices, facilitating data communication across isolated domains,
>containers, or operating systems. These DMA transfers function as
>standard memory-to-memory operations, but with source or destination
>addresses residing in different process or OS address space. The
>exchange of these addresses between processes is handled through
>private driver mechanism, which are beyond the scope of this
>specification change.
>
>This commit introduces new capability flags to advertise driver support
>for inter-process or inter-OS DMA transfers. It provides two mechanisms
>for specifying source and destination handlers: either through the vchan
>configuration or via the flags parameter in DMA enqueue APIs. This commit
>also adds a controller ID field to specify the device hierarchy details
>when applicable.
>
>To ensure secure and controlled DMA transfers, this commit adds a set
>of APIs for creating and managing access groups. Devices can create or
>join an access group using token-based authentication, and only devices
>within the same group are permitted to perform DMA transfers across
>processes or OS domains. This approach enhances security and flexibility
>for advanced DMA use cases in multi-tenant or virtualized environments.
>
>The following flow demonstrates how two processes (a group creator and a
>group joiner) use the DMA access group APIs to securely set up and
>manage inter-process DMA transfers:
>
>1) Process 1 (Group Creator):
>   Calls rte_dma_access_group_create(group_token, &group_id) to create a
>   new access group.
>   Shares group_id and group_token with Process 2 via IPC.
>2) Process 2 (Group Joiner):
>   Receives group_id and group_token from Process 1.
>   Calls rte_dma_access_group_join(group_id, group_token) to join the
>   group.
>3) Both Processes:
>   Use rte_dma_access_group_size_get() to check the number of devices in
>   the group.
>   Use rte_dma_access_group_get() to retrieve the group table and
>   handler information.
>
>   Perform DMA transfers as needed.
>
>4) Process 2 (when done):
>   Calls rte_dma_access_group_leave(group_id) to leave the group.
>5) Process 1:
>   Receives RTE_DMA_EVENT_ACCESS_TABLE_UPDATE to be notified of group
>   changes.
>   Uses rte_dma_access_group_size_get() to confirm the group size.
>
>This flow ensures only authenticated and authorized devices can
>participate in inter-process or inter-OS DMA transfers, enhancing
>security and isolation.
>
>Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
>---
> lib/dmadev/rte_dmadev.c       | 320
>++++++++++++++++++++++++++++++++++
> lib/dmadev/rte_dmadev.h       | 255 +++++++++++++++++++++++++++
> lib/dmadev/rte_dmadev_pmd.h   |  48 +++++
> lib/dmadev/rte_dmadev_trace.h |  51 ++++++
> 4 files changed, 674 insertions(+)
>
>diff --git a/lib/dmadev/rte_dmadev.c b/lib/dmadev/rte_dmadev.c
>index 17ee0808a9..a6e5e4071d 100644
>--- a/lib/dmadev/rte_dmadev.c
>+++ b/lib/dmadev/rte_dmadev.c
>@@ -9,11 +9,13 @@
>
> #include <eal_export.h>
> #include <rte_eal.h>
>+#include <rte_errno.h>
> #include <rte_lcore.h>
> #include <rte_log.h>
> #include <rte_malloc.h>
> #include <rte_memzone.h>
> #include <rte_string_fns.h>
>+#include <rte_tailq.h>
> #include <rte_telemetry.h>
>
> #include "rte_dmadev.h"
>@@ -33,6 +35,14 @@ static struct {
> 	struct rte_dma_dev_data data[0];
> } *dma_devices_shared_data;
>
>+/** List of callback functions registered by an application */
>+struct rte_dma_dev_callback {
>+	TAILQ_ENTRY(rte_dma_dev_callback) next;  /** Callbacks list */
>+	rte_dma_event_callback cb_fn; /** Callback address */
>+	void *cb_arg;  /** Parameter for callback */
>+	enum rte_dma_event event; /** Interrupt event type */
>+};
>+
> RTE_LOG_REGISTER_DEFAULT(rte_dma_logtype, INFO);
> #define RTE_LOGTYPE_DMADEV rte_dma_logtype
>
>@@ -789,6 +799,310 @@ rte_dma_vchan_status(int16_t dev_id, uint16_t
>vchan, enum rte_dma_vchan_status *
> 	return dev->dev_ops->vchan_status(dev, vchan, status);
> }
>
>+int
>+rte_dma_access_group_create(int16_t dev_id, rte_uuid_t token, uint16_t
>*group_id)
>+{
>+	struct rte_dma_info dev_info;
>+	struct rte_dma_dev *dev;
>+
>+	if (!rte_dma_is_valid(dev_id) || group_id =3D=3D NULL)
>+		return -EINVAL;
>+	dev =3D &rte_dma_devices[dev_id];
>+
>+	if (rte_dma_info_get(dev_id, &dev_info)) {
>+		RTE_DMA_LOG(ERR, "Device %d get device info fail", dev_id);
>+		return -EINVAL;
>+	}
>+
>+	if (!((dev_info.dev_capa &
>RTE_DMA_CAPA_INTER_PROCESS_DOMAIN) ||
>+	    (dev_info.dev_capa & RTE_DMA_CAPA_INTER_OS_DOMAIN))) {
>+		RTE_DMA_LOG(ERR, "Device %d don't support inter-process
>or inter-os transfers",
>+			    dev_id);
>+		return -EINVAL;
>+	}
>+	if (*dev->dev_ops->access_group_create =3D=3D NULL)
>+		return -ENOTSUP;
>+	return (*dev->dev_ops->access_group_create)(dev, token,
>group_id);
>+}
>+
>+int
>+rte_dma_access_group_destroy(int16_t dev_id, uint16_t group_id)
>+{
>+	struct rte_dma_info dev_info;
>+	struct rte_dma_dev *dev;
>+
>+	if (!rte_dma_is_valid(dev_id))
>+		return -EINVAL;
>+	dev =3D &rte_dma_devices[dev_id];
>+
>+	if (rte_dma_info_get(dev_id, &dev_info)) {
>+		RTE_DMA_LOG(ERR, "Device %d get device info fail", dev_id);
>+		return -EINVAL;
>+	}
>+
>+	if (!((dev_info.dev_capa &
>RTE_DMA_CAPA_INTER_PROCESS_DOMAIN) ||
>+	    (dev_info.dev_capa & RTE_DMA_CAPA_INTER_OS_DOMAIN))) {
>+		RTE_DMA_LOG(ERR, "Device %d don't support inter-process
>or inter-os transfers",
>+			    dev_id);
>+		return -EINVAL;
>+	}
>+
>+	if (dev_info.nb_access_groups <=3D group_id) {
>+		RTE_DMA_LOG(ERR, "Group id should be < %u for device
>%d",
>+			    dev_info.nb_access_groups, dev_id);
>+		return -EINVAL;
>+	}
>+	if (*dev->dev_ops->access_group_destroy =3D=3D NULL)
>+		return -ENOTSUP;
>+	return (*dev->dev_ops->access_group_destroy)(dev, group_id);
>+}
>+
>+int
>+rte_dma_access_group_join(int16_t dev_id, uint16_t group_id, rte_uuid_t
>token)
>+{
>+	struct rte_dma_info dev_info;
>+	struct rte_dma_dev *dev;
>+
>+	if (!rte_dma_is_valid(dev_id))
>+		return -EINVAL;
>+	dev =3D &rte_dma_devices[dev_id];
>+
>+	if (rte_dma_info_get(dev_id, &dev_info)) {
>+		RTE_DMA_LOG(ERR, "Device %d get device info fail", dev_id);
>+		return -EINVAL;
>+	}
>+
>+	if (!((dev_info.dev_capa &
>RTE_DMA_CAPA_INTER_PROCESS_DOMAIN) ||
>+	    (dev_info.dev_capa & RTE_DMA_CAPA_INTER_OS_DOMAIN))) {
>+		RTE_DMA_LOG(ERR, "Device %d don't support inter-process
>or inter-os transfers",
>+			    dev_id);
>+		return -EINVAL;
>+	}
>+
>+	if (dev_info.nb_access_groups <=3D group_id) {
>+		RTE_DMA_LOG(ERR, "Group id should be < %u for device
>%d",
>+			    dev_info.nb_access_groups, dev_id);
>+		return -EINVAL;
>+	}
>+	if (*dev->dev_ops->access_group_join =3D=3D NULL)
>+		return -ENOTSUP;
>+	return (*dev->dev_ops->access_group_join)(dev, group_id, token);
>+}
>+
>+int
>+rte_dma_access_group_leave(int16_t dev_id, uint16_t group_id)
>+{
>+	struct rte_dma_info dev_info;
>+	struct rte_dma_dev *dev;
>+
>+	if (!rte_dma_is_valid(dev_id))
>+		return -EINVAL;
>+	dev =3D &rte_dma_devices[dev_id];
>+
>+	if (rte_dma_info_get(dev_id, &dev_info)) {
>+		RTE_DMA_LOG(ERR, "Device %d get device info fail", dev_id);
>+		return -EINVAL;
>+	}
>+
>+	if (!((dev_info.dev_capa &
>RTE_DMA_CAPA_INTER_PROCESS_DOMAIN) ||
>+	    (dev_info.dev_capa & RTE_DMA_CAPA_INTER_OS_DOMAIN))) {
>+		RTE_DMA_LOG(ERR, "Device %d don't support inter-process
>or inter-os transfers",
>+			    dev_id);
>+		return -EINVAL;
>+	}
>+
>+	if (dev_info.nb_access_groups <=3D group_id) {
>+		RTE_DMA_LOG(ERR, "Group id should be < %u for device
>%d",
>+			    dev_info.nb_access_groups, dev_id);
>+		return -EINVAL;
>+	}
>+	if (*dev->dev_ops->access_group_leave =3D=3D NULL)
>+		return -ENOTSUP;
>+	return (*dev->dev_ops->access_group_leave)(dev, group_id);
>+}
>+
>+uint16_t
>+rte_dma_access_group_size_get(int16_t dev_id, uint16_t group_id)
>+{
>+	struct rte_dma_info dev_info;
>+	struct rte_dma_dev *dev;
>+
>+	if (!rte_dma_is_valid(dev_id))
>+		return -EINVAL;
>+	dev =3D &rte_dma_devices[dev_id];
>+
>+	if (rte_dma_info_get(dev_id, &dev_info)) {
>+		RTE_DMA_LOG(ERR, "Device %d get device info fail", dev_id);
>+		return -EINVAL;
>+	}
>+
>+	if (!((dev_info.dev_capa &
>RTE_DMA_CAPA_INTER_PROCESS_DOMAIN) ||
>+	    (dev_info.dev_capa & RTE_DMA_CAPA_INTER_OS_DOMAIN))) {
>+		RTE_DMA_LOG(ERR, "Device %d don't support inter-process
>or inter-os transfers",
>+			    dev_id);
>+		return -EINVAL;
>+	}
>+
>+	if (dev_info.nb_access_groups <=3D group_id) {
>+		RTE_DMA_LOG(ERR, "Group id should be < %u for device
>%d",
>+			    dev_info.nb_access_groups, dev_id);
>+		return -EINVAL;
>+	}
>+	if (*dev->dev_ops->access_group_size_get =3D=3D NULL)
>+		return -ENOTSUP;
>+	return (*dev->dev_ops->access_group_size_get)(dev, group_id);
>+}
>+
>+int
>+rte_dma_access_group_get(int16_t dev_id, uint16_t group_id, uint64_t
>*group_tbl, uint16_t size)
>+{
>+	struct rte_dma_info dev_info;
>+	struct rte_dma_dev *dev;
>+
>+	if (!rte_dma_is_valid(dev_id) || group_tbl =3D=3D NULL)
>+		return -EINVAL;
>+	dev =3D &rte_dma_devices[dev_id];
>+
>+	if (rte_dma_info_get(dev_id, &dev_info)) {
>+		RTE_DMA_LOG(ERR, "Device %d get device info fail", dev_id);
>+		return -EINVAL;
>+	}
>+
>+	if (!((dev_info.dev_capa &
>RTE_DMA_CAPA_INTER_PROCESS_DOMAIN) ||
>+	    (dev_info.dev_capa & RTE_DMA_CAPA_INTER_OS_DOMAIN))) {
>+		RTE_DMA_LOG(ERR, "Device %d don't support inter-process
>or inter-os transfers",
>+			    dev_id);
>+		return -EINVAL;
>+	}
>+
>+	if (dev_info.nb_access_groups <=3D group_id) {
>+		RTE_DMA_LOG(ERR, "Group id should be < %u for device
>%d",
>+			    dev_info.nb_access_groups, dev_id);
>+		return -EINVAL;
>+	}
>+	if (*dev->dev_ops->access_group_get =3D=3D NULL)
>+		return -ENOTSUP;
>+	return (*dev->dev_ops->access_group_get)(dev, group_id,
>group_tbl, size);
>+}
>+
>+int
>+rte_dma_event_callback_register(uint16_t dev_id, enum rte_dma_event
>event,
>+				rte_dma_event_callback cb_fn, void *cb_arg)
>+{
>+	struct rte_dma_dev_callback *user_cb;
>+	struct rte_dma_dev *dev;
>+	int ret =3D 0;
>+
>+	if (!rte_dma_is_valid(dev_id))
>+		return -EINVAL;
>+
>+	dev =3D &rte_dma_devices[dev_id];
>+
>+	if (event >=3D RTE_DMA_EVENT_MAX) {
>+		RTE_DMA_LOG(ERR, "Invalid event type (%u), should be less
>than %u", event,
>+			    RTE_DMA_EVENT_MAX);
>+		return -EINVAL;
>+	}
>+
>+	if (cb_fn =3D=3D NULL) {
>+		RTE_DMA_LOG(ERR, "NULL callback function");
>+		return -EINVAL;
>+	}
>+
>+	rte_mcfg_tailq_write_lock();
>+	TAILQ_FOREACH(user_cb, &(dev->list_cbs), next) {
>+		if (user_cb->cb_fn =3D=3D cb_fn && user_cb->cb_arg =3D=3D cb_arg
>&&
>+		    user_cb->event =3D=3D event) {
>+			ret =3D -EEXIST;
>+			goto exit;
>+		}
>+	}
>+
>+	user_cb =3D rte_zmalloc("INTR_USER_CALLBACK", sizeof(struct
>rte_dma_dev_callback), 0);
>+	if (user_cb =3D=3D NULL) {
>+		ret =3D -ENOMEM;
>+		goto exit;
>+	}
>+
>+	user_cb->cb_fn =3D cb_fn;
>+	user_cb->cb_arg =3D cb_arg;
>+	user_cb->event =3D event;
>+	TAILQ_INSERT_TAIL(&(dev->list_cbs), user_cb, next);
>+
>+exit:
>+	rte_mcfg_tailq_write_unlock();
>+	rte_errno =3D -ret;
>+	return ret;
>+}
>+
>+int
>+rte_dma_event_callback_unregister(uint16_t dev_id, enum rte_dma_event
>event,
>+				  rte_dma_event_callback cb_fn, void
>*cb_arg)
>+{
>+	struct rte_dma_dev_callback *cb;
>+	struct rte_dma_dev *dev;
>+	int ret =3D -ENOENT;
>+
>+	if (!rte_dma_is_valid(dev_id))
>+		return -EINVAL;
>+	dev =3D &rte_dma_devices[dev_id];
>+
>+	if (event >=3D RTE_DMA_EVENT_MAX) {
>+		RTE_DMA_LOG(ERR, "Invalid event type (%u), should be less
>than %u", event,
>+			    RTE_DMA_EVENT_MAX);
>+		return -EINVAL;
>+	}
>+
>+	if (cb_fn =3D=3D NULL) {
>+		RTE_DMA_LOG(ERR, "NULL callback function cannot be
>unregistered");
>+		return -EINVAL;
>+	}
>+
>+	rte_mcfg_tailq_write_lock();
>+	TAILQ_FOREACH(cb, &dev->list_cbs, next) {
>+		if (cb->cb_fn =3D=3D cb_fn || cb->event =3D=3D event || cb->cb_arg
>=3D=3D cb_arg) {
>+			TAILQ_REMOVE(&(dev->list_cbs), cb, next);
>+			ret =3D 0;
>+			break;
>+		}
>+	}
>+	rte_mcfg_tailq_write_unlock();
>+
>+	if (ret =3D=3D 0)
>+		rte_free(cb);
>+
>+	rte_errno =3D -ret;
>+	return ret;
>+}
>+
>+RTE_EXPORT_INTERNAL_SYMBOL(rte_dma_event_pmd_callback_process)
>+void
>+rte_dma_event_pmd_callback_process(struct rte_dma_dev *dev, enum
>rte_dma_event event)
>+{
>+	struct rte_dma_dev_callback *cb;
>+	void *tmp;
>+
>+	if (dev =3D=3D NULL) {
>+		RTE_DMA_LOG(ERR, "NULL device");
>+		return;
>+	}
>+
>+	if (event >=3D RTE_DMA_EVENT_MAX) {
>+		RTE_DMA_LOG(ERR, "Invalid event type (%u), should be less
>than %u", event,
>+			    RTE_DMA_EVENT_MAX);
>+		return;
>+	}
>+
>+	rte_mcfg_tailq_read_lock();
>+	RTE_TAILQ_FOREACH_SAFE(cb, &(dev->list_cbs), next, tmp) {
>+		rte_mcfg_tailq_read_unlock();
>+		if (cb->cb_fn !=3D NULL || cb->event =3D=3D event)
>+			cb->cb_fn(dev->data->dev_id, cb->event, cb-
>>cb_arg);
>+		rte_mcfg_tailq_read_lock();
>+	}
>+	rte_mcfg_tailq_read_unlock();
>+}
>+
> static const char *
> dma_capability_name(uint64_t capability)
> {
>@@ -805,6 +1119,8 @@ dma_capability_name(uint64_t capability)
> 		{ RTE_DMA_CAPA_HANDLES_ERRORS, "handles_errors" },
> 		{ RTE_DMA_CAPA_M2D_AUTO_FREE,  "m2d_auto_free"  },
> 		{ RTE_DMA_CAPA_PRI_POLICY_SP,  "pri_policy_sp" },
>+		{ RTE_DMA_CAPA_INTER_PROCESS_DOMAIN,
>"inter_process_domain" },
>+		{ RTE_DMA_CAPA_INTER_OS_DOMAIN, "inter_os_domain" },
> 		{ RTE_DMA_CAPA_OPS_COPY,    "copy"    },
> 		{ RTE_DMA_CAPA_OPS_COPY_SG, "copy_sg" },
> 		{ RTE_DMA_CAPA_OPS_FILL,    "fill"    },
>@@ -999,6 +1315,8 @@ dmadev_handle_dev_info(const char *cmd
>__rte_unused,
> 	rte_tel_data_add_dict_int(d, "max_desc", dma_info.max_desc);
> 	rte_tel_data_add_dict_int(d, "min_desc", dma_info.min_desc);
> 	rte_tel_data_add_dict_int(d, "max_sges", dma_info.max_sges);
>+	rte_tel_data_add_dict_int(d, "nb_access_groups",
>dma_info.nb_access_groups);
>+	rte_tel_data_add_dict_int(d, "controller_id",
>dma_info.controller_id);
>
> 	dma_caps =3D rte_tel_data_alloc();
> 	if (!dma_caps)
>@@ -1014,6 +1332,8 @@ dmadev_handle_dev_info(const char *cmd
>__rte_unused,
> 	ADD_CAPA(dma_caps, dev_capa,
>RTE_DMA_CAPA_HANDLES_ERRORS);
> 	ADD_CAPA(dma_caps, dev_capa,
>RTE_DMA_CAPA_M2D_AUTO_FREE);
> 	ADD_CAPA(dma_caps, dev_capa, RTE_DMA_CAPA_PRI_POLICY_SP);
>+	ADD_CAPA(dma_caps, dev_capa,
>RTE_DMA_CAPA_INTER_PROCESS_DOMAIN);
>+	ADD_CAPA(dma_caps, dev_capa,
>RTE_DMA_CAPA_INTER_OS_DOMAIN);
> 	ADD_CAPA(dma_caps, dev_capa, RTE_DMA_CAPA_OPS_COPY);
> 	ADD_CAPA(dma_caps, dev_capa, RTE_DMA_CAPA_OPS_COPY_SG);
> 	ADD_CAPA(dma_caps, dev_capa, RTE_DMA_CAPA_OPS_FILL);
>diff --git a/lib/dmadev/rte_dmadev.h b/lib/dmadev/rte_dmadev.h
>index 550dbfbf75..23ab62c5e3 100644
>--- a/lib/dmadev/rte_dmadev.h
>+++ b/lib/dmadev/rte_dmadev.h
>@@ -148,6 +148,7 @@
>
> #include <rte_bitops.h>
> #include <rte_common.h>
>+#include <rte_uuid.h>
>
> #ifdef __cplusplus
> extern "C" {
>@@ -265,6 +266,18 @@ int16_t rte_dma_next_dev(int16_t start_dev_id);
>  * known from 'nb_priorities' field in struct rte_dma_info.
>  */
> #define RTE_DMA_CAPA_PRI_POLICY_SP	RTE_BIT64(8)
>+/** Support inter-process DMA transfers.
>+ *
>+ * When this bit is set, the DMA device can perform memory transfers
>between
>+ * different process memory spaces.
>+ */
>+#define RTE_DMA_CAPA_INTER_PROCESS_DOMAIN	RTE_BIT64(9)
>+/** Support inter-OS domain DMA transfers.
>+ *
>+ * The DMA device can perform memory transfers across different operating
>+ * system domains.
>+ */
>+#define RTE_DMA_CAPA_INTER_OS_DOMAIN		RTE_BIT64(10)
>
> /** Support copy operation.
>  * This capability start with index of 32, so that it could leave gap bet=
ween
>@@ -308,6 +321,13 @@ struct rte_dma_info {
> 	 * 0 otherwise.
> 	 */
> 	uint16_t nb_priorities;
>+	/** Number of access groups supported by the DMA controller.
>+	 * If the device does not support INTER_PROCESS_DOMAIN or
>INTER_OS_DOMAIN transfers,
>+	 * this value can be zero.
>+	 */
>+	uint16_t nb_access_groups;
>+	/** Controller ID, -1 if unknown */
>+	uint16_t controller_id;
> };
>
> /**
>@@ -564,6 +584,35 @@ struct rte_dma_auto_free_param {
> 	uint64_t reserved[2];
> };
>
>+/**
>+ * Inter-DMA transfer type.
>+ *
>+ * Specifies the type of DMA transfer, indicating whether the operation
>+ * is within the same domain, between different processes, or across
>different
>+ * operating system domains.
>+ *
>+ * @see struct rte_dma_inter_transfer_param:transfer_type
>+ */
>+enum rte_dma_inter_transfer_type {
>+	RTE_DMA_INTER_TRANSFER_NONE, /**< No inter-domain transfer.
>*/
>+	RTE_DMA_INTER_PROCESS_TRANSFER, /**< Transfer is between
>different processes. */
>+	RTE_DMA_INTER_OS_TRANSFER, /**< Transfer is between different
>OS domains. */
>+};
>+
>+/**
>+ * Parameters for inter-process or inter-OS DMA transfers.
>+ *
>+ * This structure holds the necessary information to perform DMA transfer=
s
>+ * between different processes or operating system domains, including the
>+ * transfer type and handler identifiers for the source and destination.
>+ */
>+struct rte_dma_inter_transfer_param {
>+	enum rte_dma_inter_transfer_type transfer_type; /**< Type of
>inter-domain transfer. */
>+	uint16_t src_handler; /**< Source handler identifier. */
>+	uint16_t dst_handler; /**< Destination handler identifier. */
>+	uint64_t reserved[2]; /**< Reserved for future fields. */
>+};
>+
> /**
>  * A structure used to configure a virtual DMA channel.
>  *
>@@ -601,6 +650,14 @@ struct rte_dma_vchan_conf {
> 	 * @see struct rte_dma_auto_free_param
> 	 */
> 	struct rte_dma_auto_free_param auto_free;
>+	/** Parameters for inter-process or inter-OS DMA transfers to specify
>+	 * the source and destination handlers.
>+	 *
>+	 * @see RTE_DMA_CAPA_INTER_PROCESS_DOMAIN
>+	 * @see RTE_DMA_CAPA_INTER_OS_DOMAIN
>+	 * @see struct rte_dma_inter_transfer_param
>+	 */
>+	struct rte_dma_inter_transfer_param inter_transfer;
> };
>
> /**
>@@ -720,6 +777,163 @@ rte_dma_vchan_status(int16_t dev_id, uint16_t
>vchan, enum rte_dma_vchan_status *
>  */
> int rte_dma_dump(int16_t dev_id, FILE *f);
>
>+/**
>+ * Create an access group to enable inter-process or inter-OS DMA transfe=
rs
>between devices
>+ * in the group.
>+ *
>+ * @param dev_id
>+ *   The identifier of the device.
>+ * @param token
>+ *   The unique token used to create the access group.
>+ * @param[out] group_id
>+ *   The ID of the created access group.
>+ * @return
>+ *   0 on success,
>+ *   negative value on failure indicating the error code.
>+ */
>+int rte_dma_access_group_create(int16_t dev_id, rte_uuid_t token,
>uint16_t *group_id);
>+/**
>+ * Destroy an access group if all other devices have exited. This functio=
n will
>only succeed
>+ * when called by the device that created the group; it will fail for all=
 other
>devices.
>+ *
>+ * @param dev_id
>+ *   The identifier of the device.
>+ * @param group_id
>+ *   The ID of the access group to be destroyed.
>+ * @return
>+ *   0 on success,
>+ *   negative value on failure indicating the error code.
>+ */
>+int rte_dma_access_group_destroy(int16_t dev_id, uint16_t group_id);
>+/**
>+ * Join an access group to enable inter-process or inter-OS DMA transfers
>with other devices
>+ * in the group.
>+ *
>+ * @param dev_id
>+ *   The device identifier.
>+ * @param group_id
>+ *   The access group ID to join.
>+ * @param token
>+ *   The unique token used to authenticate joining the access group
>+ * @return
>+ *   0 on success,
>+ *   negative value on failure indicating the error code.
>+ */
>+int rte_dma_access_group_join(int16_t dev_id, uint16_t group_id,
>rte_uuid_t token);
>+/**
>+ * Leave an access group, The device's details will be removed from the
>access group table,
>+ * disabling inter-DMA transfers to and from this device. Remaining devic=
es
>in the group
>+ * must be notified of the table update. This function will fail if calle=
d by the
>device
>+ * that created the access group.
>+ *
>+ * @param dev_id
>+ *   The device identifier.
>+ * @param group_id
>+ *   The access group ID to exit
>+ * @return
>+ *   0 on success,
>+ *   negative value on failure indicating the error code.
>+ */
>+int rte_dma_access_group_leave(int16_t dev_id, uint16_t group_id);
>+/**
>+ * Retrieve the size of an access group
>+ *
>+ * @param dev_id
>+ *   The identifier of the device.
>+ * @param group_id
>+ *   The access group ID
>+ * @return
>+ *   0 if the group is empty
>+ *   non-zero value if the group contains devices.
>+ */
>+uint16_t rte_dma_access_group_size_get(int16_t dev_id, uint16_t
>group_id);
>+/**
>+ * Retrieve the access group table, which contains source & destination
>handler
>+ * information used by the application to initiate inter-process or inter=
-OS
>DMA transfers.
>+ *
>+ * @param dev_id
>+ *   The device identifier.
>+ * @param group_id
>+ *   The access group ID
>+ * @param group_tbl
>+ *   Pointer to the memory where the access group table will be copied
>+ * @param size
>+ *   The size of the group table
>+ * @return
>+ *   0 on success,
>+ *   negative value on failure indicating the error code.
>+ */
>+int rte_dma_access_group_get(int16_t dev_id, uint16_t group_id, uint64_t
>*group_tbl, uint16_t size);
>+
>+/**
>+ * Enumeration of DMA device event types.
>+ *
>+ * These events notify the application about changes to the DMA access
>group table,
>+ * such as updates or destruction.
>+ *
>+ * @internal
>+ */
>+enum rte_dma_event {
>+	RTE_DMA_EVENT_ACCESS_TABLE_UPDATE =3D 0,	/**< Access
>group table has been updated. */
>+	RTE_DMA_EVENT_ACCESS_TABLE_DESTROY =3D 1,	/**< Access
>group table has been destroyed. */
>+	RTE_DMA_EVENT_MAX  /**< max value of this enum */
>+};
>+
>+/**
>+ * DMA device event callback function type.
>+ *
>+ * This callback is invoked when a DMA device event occurs.
>+ *
>+ * @param dma_id
>+ *   The identifier of the DMA device associated with the event.
>+ * @param event
>+ *   The DMA event type.
>+ * @param user_data
>+ *   User-defined data provided during callback registration.
>+ */
>+typedef void (*rte_dma_event_callback)(int16_t dma_id, enum
>rte_dma_event event, void *user_data);
>+
>+/**
>+ * Register a callback function for DMA device events.
>+ *
>+ * The specified callback will be invoked when a DMA event (such as acces=
s
>table update or destroy)
>+ * occurs. Only one callback can be registered at a time.
>+ *
>+ * @param dma_id
>+ *   The identifier of the DMA device.
>+ * @param event
>+ *   The DMA event type.
>+ * @param cb_fn
>+ *   Pointer to the callback function to register.
>+ * @param cb_arg
>+ *   Pointer to user-defined data that will be passed to the callback whe=
n
>invoked.
>+ * @return
>+ *   0 on success,
>+ *   negative value on failure indicating the error code.
>+ */
>+int rte_dma_event_callback_register(uint16_t dev_id, enum
>rte_dma_event event,
>+				    rte_dma_event_callback cb_fn, void
>*cb_arg);
>+
>+/**
>+ * Unregister a previously registered DMA event callback function.
>+ *
>+ * This function removes the callback associated with the specified funct=
ion
>pointer and user data.
>+ *
>+ * @param dma_id
>+ *   The identifier of the DMA device.
>+ * @param event
>+ *   The DMA event type.
>+ * @param cb_fn
>+ *   Pointer to the callback function to unregister.
>+ * @param cb_arg
>+ *   Pointer to the user-defined data associated with the callback.
>+ * @return
>+ *   0 on success,
>+ *   negative value on failure indicating the error code.
>+ */
>+int rte_dma_event_callback_unregister(uint16_t dev_id, enum
>rte_dma_event event,
>+				      rte_dma_event_callback cb_fn, void
>*cb_arg);
>+
> /**
>  * DMA transfer result status code defines.
>  *
>@@ -834,6 +1048,38 @@ extern "C" {
>  * @see struct rte_dma_vchan_conf::auto_free
>  */
> #define RTE_DMA_OP_FLAG_AUTO_FREE	RTE_BIT64(3)
>+/** Indicates a valid inter-process source handler.
>+ * This flag signifies that the inter-process source handler is provided =
in the
>flags
>+ * parameter (for all enqueue APIs) and is valid.
>+ *
>+ * Applicable only if the DMA device supports inter-process DMA capabilit=
y.
>+ * @see struct rte_dma_info::dev_capa
>+ */
>+#define RTE_DMA_OP_FLAG_SRC_INTER_PROCESS_DOMAIN_HANDLE
>		RTE_BITS64(4)
>+/** Indicates a valid inter-process destination handler.
>+ * This flag signifies that the inter-process destination handler is prov=
ided in
>the flags
>+ * parameter (for all enqueue APIs) and is valid.
>+ *
>+ * Applicable only if the DMA device supports inter-process DMA capabilit=
y.
>+ * @see struct rte_dma_info::dev_capa
>+ */
>+#define RTE_DMA_OP_FLAG_DST_INTER_PROCESS_DOMAIN_HANDLE
>		RTE_BITS64(5)
>+/** Indicates a valid inter-OS source handler.
>+ * This flag signifies that the inter-OS source handler is provided in th=
e flags
>+ * parameter (for all enqueue APIs) and is valid.
>+ *
>+ * Applicable only if the DMA device supports inter-OS DMA capability.
>+ * @see struct rte_dma_info::dev_capa
>+ */
>+#define RTE_DMA_OP_FLAG_SRC_INTER_OS_DOMAIN_HANDLE
>	RTE_BITS64(6)
>+/** Indicates a valid inter-OS destination handler.
>+ * This flag signifies that the inter-OS destination handler is provided =
in the
>flags
>+ * parameter (for all enqueue APIs) and is valid.
>+ *
>+ * Applicable only if the DMA device supports inter-OS DMA capability.
>+ * @see struct rte_dma_info::dev_capa
>+ */
>+#define RTE_DMA_OP_FLAG_DST_INTER_OS_DOMAIN_HANDLE
>	RTE_BITS64(7)
> /**@}*/
>
> /**
>@@ -856,6 +1102,9 @@ extern "C" {
>  * @param flags
>  *   An flags for this operation.
>  *   @see RTE_DMA_OP_FLAG_*
>+ *   The upper 32 bits of the flags parameter specify the source & destin=
ation
>handlers
>+ *   when any RTE_DMA_OP_FLAG_*_INTER_* flags are set.
>+ *   @see RTE_DMA_OP_FLAG_*_INTER_*
>  *
>  * @return
>  *   - 0..UINT16_MAX: index of enqueued job.
>@@ -906,6 +1155,9 @@ rte_dma_copy(int16_t dev_id, uint16_t vchan,
>rte_iova_t src, rte_iova_t dst,
>  * @param flags
>  *   An flags for this operation.
>  *   @see RTE_DMA_OP_FLAG_*
>+ *   The upper 32 bits of the flags parameter specify the source & destin=
ation
>handlers
>+ *   when any RTE_DMA_OP_FLAG_*_INTER_* flags are set.
>+ *   @see RTE_DMA_OP_FLAG_*_INTER_*
>  *
>  * @return
>  *   - 0..UINT16_MAX: index of enqueued job.
>@@ -955,6 +1207,9 @@ rte_dma_copy_sg(int16_t dev_id, uint16_t vchan,
>struct rte_dma_sge *src,
>  * @param flags
>  *   An flags for this operation.
>  *   @see RTE_DMA_OP_FLAG_*
>+ *   The upper 16 bits of the flags parameter specify the destination han=
dler
>+ *   when any RTE_DMA_OP_FLAG_DST_INTER_* flags are set.
>+ *   @see RTE_DMA_OP_FLAG_DST_INTER_*
>  *
>  * @return
>  *   - 0..UINT16_MAX: index of enqueued job.
>diff --git a/lib/dmadev/rte_dmadev_pmd.h
>b/lib/dmadev/rte_dmadev_pmd.h
>index 58729088ff..ab1b1c4a00 100644
>--- a/lib/dmadev/rte_dmadev_pmd.h
>+++ b/lib/dmadev/rte_dmadev_pmd.h
>@@ -25,6 +25,9 @@ extern "C" {
>
> struct rte_dma_dev;
>
>+/** Structure to keep track of registered callbacks */
>+RTE_TAILQ_HEAD(rte_dma_dev_cb_list, rte_dma_dev_callback);
>+
> /** @internal Used to get device information of a device. */
> typedef int (*rte_dma_info_get_t)(const struct rte_dma_dev *dev,
> 				  struct rte_dma_info *dev_info,
>@@ -64,6 +67,28 @@ typedef int (*rte_dma_vchan_status_t)(const struct
>rte_dma_dev *dev, uint16_t vc
> /** @internal Used to dump internal information. */
> typedef int (*rte_dma_dump_t)(const struct rte_dma_dev *dev, FILE *f);
>
>+/** @internal Used to create an access group for inter-process or inter-O=
S
>DMA transfers. */
>+typedef int (*rte_dma_access_group_create_t)(const struct rte_dma_dev
>*dev, rte_uuid_t token,
>+					     uint16_t *group_id);
>+
>+/** @internal Used to destroy an access group if all other devices have
>exited. */
>+typedef int (*rte_dma_access_group_destroy_t)(const struct rte_dma_dev
>*dev, uint16_t group_id);
>+
>+/** @internal Used to join an access group for inter-process or inter-OS
>DMA transfers. */
>+typedef int (*rte_dma_access_group_join_t)(const struct rte_dma_dev
>*dev, uint16_t group_id,
>+					   rte_uuid_t token);
>+
>+/** @internal Used to leave an access group, removing the device from the
>group. */
>+typedef int (*rte_dma_access_group_leave_t)(const struct rte_dma_dev
>*dev, uint16_t group_id);
>+
>+/** @internal Used to retrieve the size of an access group. */
>+typedef uint16_t (*rte_dma_access_group_size_get_t)(const struct
>rte_dma_dev *dev,
>+						    uint16_t group_id);
>+
>+/** @internal Used to retrieve the access group table containing handler
>information. */
>+typedef int (*rte_dma_access_group_get_t)(const struct rte_dma_dev
>*dev, uint16_t group_id,
>+					  uint64_t *group_tbl, uint16_t size);
>+
> /**
>  * DMA device operations function pointer table.
>  *
>@@ -83,6 +108,13 @@ struct rte_dma_dev_ops {
>
> 	rte_dma_vchan_status_t     vchan_status;
> 	rte_dma_dump_t             dev_dump;
>+
>+	rte_dma_access_group_create_t	access_group_create;
>+	rte_dma_access_group_destroy_t	access_group_destroy;
>+	rte_dma_access_group_join_t	access_group_join;
>+	rte_dma_access_group_leave_t	access_group_leave;
>+	rte_dma_access_group_size_get_t	access_group_size_get;
>+	rte_dma_access_group_get_t	access_group_get;
> };
>
> /**
>@@ -131,6 +163,7 @@ struct __rte_cache_aligned rte_dma_dev {
> 	/** Functions implemented by PMD. */
> 	const struct rte_dma_dev_ops *dev_ops;
> 	enum rte_dma_dev_state state; /**< Flag indicating the device state.
>*/
>+	struct rte_dma_dev_cb_list list_cbs;/**< Event callback list. */
> 	uint64_t reserved[2]; /**< Reserved for future fields. */
> };
>
>@@ -180,6 +213,21 @@ int rte_dma_pmd_release(const char *name);
> __rte_internal
> struct rte_dma_dev *rte_dma_pmd_get_dev_by_id(int16_t dev_id);
>
>+/**
>+ * @internal
>+ * Process and invoke all registered PMD (Poll Mode Driver) callbacks for=
 a
>given DMA event.
>+ *
>+ * This function is typically called by the driver when a specific DMA ev=
ent
>occurs,
>+ * triggering all registered callbacks for the specified device and event=
 type.
>+ *
>+ * @param dev
>+ *   Pointer to the DMA device structure.
>+ * @param event
>+ *   The DMA event type to process.
>+ */
>+__rte_internal
>+void rte_dma_event_pmd_callback_process(struct rte_dma_dev *dev,
>enum rte_dma_event event);
>+
> #ifdef __cplusplus
> }
> #endif
>diff --git a/lib/dmadev/rte_dmadev_trace.h
>b/lib/dmadev/rte_dmadev_trace.h
>index 1de92655f2..2e55543c5a 100644
>--- a/lib/dmadev/rte_dmadev_trace.h
>+++ b/lib/dmadev/rte_dmadev_trace.h
>@@ -32,6 +32,8 @@ RTE_TRACE_POINT(
> 	rte_trace_point_emit_i16(dev_info->numa_node);
> 	rte_trace_point_emit_u16(dev_info->nb_vchans);
> 	rte_trace_point_emit_u16(dev_info->nb_priorities);
>+	rte_trace_point_emit_u16(dev_info->nb_access_groups);
>+	rte_trace_point_emit_u16(dev_info->controller_id);
> )
>
> RTE_TRACE_POINT(
>@@ -79,6 +81,9 @@ RTE_TRACE_POINT(
> 	rte_trace_point_emit_int(conf->dst_port.port_type);
> 	rte_trace_point_emit_u64(conf->dst_port.pcie.val);
> 	rte_trace_point_emit_ptr(conf->auto_free.m2d.pool);
>+	rte_trace_point_emit_int(conf->inter_transfer.transfer_type);
>+	rte_trace_point_emit_u16(conf->inter_transfer.src_handler);
>+	rte_trace_point_emit_u16(conf->inter_transfer.dst_handler);
> 	rte_trace_point_emit_int(ret);
> )
>
>@@ -98,6 +103,52 @@ RTE_TRACE_POINT(
> 	rte_trace_point_emit_int(ret);
> )
>
>+RTE_TRACE_POINT(
>+	rte_dma_trace_access_group_create,
>+	RTE_TRACE_POINT_ARGS(int16_t dev_id, rte_uuid_t token, uint16_t
>*group_id),
>+	rte_trace_point_emit_i16(dev_id);
>+	rte_trace_point_emit_u8_ptr(&token[0]);
>+	rte_trace_point_emit_ptr(group_id);
>+)
>+
>+RTE_TRACE_POINT(
>+	rte_dma_trace_access_group_destroy,
>+	RTE_TRACE_POINT_ARGS(int16_t dev_id, uint16_t group_id),
>+	rte_trace_point_emit_i16(dev_id);
>+	rte_trace_point_emit_u16(group_id);
>+)
>+
>+RTE_TRACE_POINT(
>+	rte_dma_trace_access_group_join,
>+	RTE_TRACE_POINT_ARGS(int16_t dev_id, uint16_t group_id,
>rte_uuid_t token),
>+	rte_trace_point_emit_i16(dev_id);
>+	rte_trace_point_emit_u16(group_id);
>+	rte_trace_point_emit_u8_ptr(&token[0]);
>+)
>+
>+RTE_TRACE_POINT(
>+	rte_dma_trace_access_group_leave,
>+	RTE_TRACE_POINT_ARGS(int16_t dev_id, uint16_t group_id),
>+	rte_trace_point_emit_i16(dev_id);
>+	rte_trace_point_emit_u16(group_id);
>+)
>+
>+RTE_TRACE_POINT(
>+	rte_dma_trace_access_group_size_get,
>+	RTE_TRACE_POINT_ARGS(int16_t dev_id, uint16_t group_id),
>+	rte_trace_point_emit_i16(dev_id);
>+	rte_trace_point_emit_u16(group_id);
>+)
>+
>+RTE_TRACE_POINT(
>+	rte_dma_trace_access_group_get,
>+	RTE_TRACE_POINT_ARGS(int16_t dev_id, uint16_t group_id, uint64_t
>*group_tbl, uint16_t size),
>+	rte_trace_point_emit_i16(dev_id);
>+	rte_trace_point_emit_u16(group_id);
>+	rte_trace_point_emit_ptr(group_tbl);
>+	rte_trace_point_emit_u16(size);
>+)
>+
> #ifdef __cplusplus
> }
> #endif
>--
>2.34.1

