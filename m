Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D288CA9EC9
	for <dpdk-dev@archiver.kernel.org>; Sun, 11 Oct 2026 07:41:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C8B44026F;
	Sun, 11 Oct 2026 09:41:41 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 3E377402D5
 for <dev@dpdk.org>; Fri,  9 Oct 2026 12:50:37 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6998IoQl2797427; Fri, 9 Oct 2026 03:50:36 -0700
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11020121.outbound.protection.outlook.com
 [40.93.198.121])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4h6kjs2exp-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 09 Oct 2026 03:50:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tRyGcbSqKmm2roY/fhop4NbsFTHgCTLp4D54K301OUISDjfm9inx02yPreoG7hlJ7V3fyRHV0iMvCpIUUxgG183ECC6DIdehWVwBNeG3CSuNmSSyn3k9UDOS96m/KK3ocZGuIZeiNKKgR7cDW7+QFm4/H14YdOXu/ly8VGhEkGzffAGSvmkcJNbQyVfkGNAtDN6YedFs9cWeGxZ/oddiqqdB4R1mQz+11SoxjsuUgZq12tdMj0p6XYOReIEvVOPKmQKboO/ULPXA5sENPHQvXAm2/LcKkr2g9oHmUGyONoRV9eKy4suwMIXGZf4OZd1sWkjRv6mStbgzbCIN2aT4Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFndQRpIsfzUwM202aMcSYx5MdPmX11QNAtXnObDYkg=;
 b=IoiBdY/XyhKoNJkUt8g6DqSdh9dn1wGvJBzHRs4kzlzhDQt7OB99dv6JoHgE+RnBvg+HgLMBRDTT3paZqtINA1B18TTc1LywswFMjUdin4Pv5wMdMI14rSm168bV9GuTTTS5P72cMQHll4dECAnk2gmzTPDtZMnBMbGD/6QomXwN6AXk10BKwuqR5OlumhXwUMbUBOYlov322nRNxbJDxXTNqGMOmf8n5/SFM4exO1i7XgrseQoX0IrhkVQmivk9XPSUrFMXM1oBTsocgseRYU33yW8jOlfZjO8TIrpQbIC1lClixrGfSlFTl+zDt94ewmvZ+pOWnhknu0hHkeQwlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFndQRpIsfzUwM202aMcSYx5MdPmX11QNAtXnObDYkg=;
 b=lOAo99cg7FRm81+3fmdgPO4cAKTyLx4gP5VKokW4kVOdDsgxIbgO+t7onyaXMUIb/A07hhu9E8GSzejun7l7TXlauqiBzQYdOKApm1Oiwyh2Lv2IEfJRJYdB6CVcsUwbcbWJcpmWZjWlnnskL4WoQzUk2QMASR5F69XjoKShvOs=
Received: from LV8PR18MB6078.namprd18.prod.outlook.com (2603:10b6:408:224::5)
 by LV3PR18MB6290.namprd18.prod.outlook.com (2603:10b6:408:26c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 10:50:34 +0000
Received: from LV8PR18MB6078.namprd18.prod.outlook.com
 ([fe80::e753:86c:d16e:63e2]) by LV8PR18MB6078.namprd18.prod.outlook.com
 ([fe80::e753:86c:d16e:63e2%3]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 10:50:33 +0000
From: Pratik Senapati <psenapati@marvell.com>
To: Radu Nicolau <radu.nicolau@intel.com>, "dev@dpdk.org" <dev@dpdk.org>
CC: Akhil Goyal <gakhil@marvell.com>, Gowrishankar Muthukrishnan
 <gmuthukrishn@marvell.com>, "kai.ji@intel.com" <kai.ji@intel.com>
Subject: Re: [EXTERNAL] Re: [PATCH v4 1/4] app/crypto-perf: support mldsa
 Sign-Iteration
Thread-Topic: [EXTERNAL] Re: [PATCH v4 1/4] app/crypto-perf: support mldsa
 Sign-Iteration
Thread-Index: AQHdUNMO4kpxJPSEtEK5+qTuymlXQLboxxNRgAAWKACADC72wg==
Date: Fri, 9 Oct 2026 10:50:33 +0000
Message-ID: <LV8PR18MB60783614DA6DF49EBF7CB654BD922@LV8PR18MB6078.namprd18.prod.outlook.com>
References: <20260929105851.1305127-1-psenapati@marvell.com>
 <20260929122044.1344518-1-psenapati@marvell.com>
 <64d81a94-4578-4362-920d-a049e0207c68@intel.com>
 <LV8PR18MB6078F14394D1B1812C574D15BD8A2@LV8PR18MB6078.namprd18.prod.outlook.com>
 <9df33b27-970c-4f9a-a452-36ba6c6eb92b@intel.com>
In-Reply-To: <9df33b27-970c-4f9a-a452-36ba6c6eb92b@intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=marvell.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR18MB6078:EE_|LV3PR18MB6290:EE_
x-ms-office365-filtering-correlation-id: 0c85b51c-7c6d-4f27-8a9f-08df25f324e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|10067099003|4143699003|11063799006|38070700021|56012099006;
x-microsoft-antispam-message-info: SS/LvEDJAyuq4cO47kXekOawEEzk02fpLWUCSPkAwPu15V6EtABVVoU9qEybnoL0iRSeo3fmnJHX9Sox7HFEO4Z2Hdvz0YVg9xZQn5solK/uu5fJmDq210kydQ9Nz/7cptrPsZnNZe9EPAe/epbFx0bPj1XMJr4XSmRCVufbS1fHplzVCbZCONnjY9A3HjGd0bMyc6MiSFMbQWOjuBJLz/ZxIW600Y5VmJ2PAgndy8FW/Qx5+9RBo39B86WtmHSYCaJlvhy8V9SMHlgmieVl9UO6OuJHIf4egZxfLtXYAS7kyfIsDT6SfF8u7UJg7Xs4B9DCHgrLSHBGpOycyyulYw3REFar8SQL3++6MLkkDrx3z+PP2G6lXiMXwgIIUz+t8tLtND4I8o1+piy3J83ww5nV4yy39S40LXT2qawVCD8uv0sM/dxs8r7lMxpkhNLJlLA+UvrpUvb9L4+BFBV2r5H2390FYNW/KZiBwBk0b7MqKGLT/w/X6O7OYS1TvUt7sLvsLnD+IjpvJJ4vkimZIO9kDLOFKMYYIlzqudRndML8IuFD1F7efLI+m75ri3HV5aA37kFLHa9E+5rcAj0qDCPK/t73+WgwZN4/gqV6k7npL94mdD7k9B4x0F5pnKxiEJJBCIKiPg1UWYp+CC8pyBSeSTqRu1CK8G7Hjkvsip2S4pVCCE4kI4VOE9tUZzf6g4TGd6/Rne1o8qmfMPYWpaf2NVRQKpep0hH/RvOAnOM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR18MB6078.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(10067099003)(4143699003)(11063799006)(38070700021)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?KpG9tFfX9CyOOpklUA6w/LWpUfwySK0VZKuI44sx8nyLAniCxm9NA52mtC?=
 =?iso-8859-1?Q?pvNurHCmxe8yLP5+wOyIpikDWmuLicdluvnec0d42Ps9SX+XbqgA35WpNq?=
 =?iso-8859-1?Q?yziRLFqdCQPuCNVStsUbiGVCl79WwVWLOreAm7FP6OIWAStbirdZhYJEkI?=
 =?iso-8859-1?Q?qtuyJVC/+kbF0ohvGdhePXWzlrzx6uKv8voEbsulWtTTwWVrBqeqgAeuIf?=
 =?iso-8859-1?Q?A5MwXkPc8+ykrhqQ5sA+z4Tn7xbF/XHQR+klOin+ltMtSsaJsNSGTBV/UP?=
 =?iso-8859-1?Q?fGr2AQcqgHPwyCruJXWnJEci15L33ZVnX3DvaTcrHaB9HP7kY58ixpqm+0?=
 =?iso-8859-1?Q?nfNkpx1gZxQB3IjOwdetTPXqaltBQvedU49PWKZA+A0k/mttNF1LaarZY1?=
 =?iso-8859-1?Q?DHfQX2kSqhibg+jlmdnYftgDwUsLV9U3IN9hjSEkiaurseLLEnszdLqo0W?=
 =?iso-8859-1?Q?ZaE0CXRJAxufIf3Pmh+qufZmLMlTmckwcm9/xF2THXrFP6LsW5IwpCQoEH?=
 =?iso-8859-1?Q?VSaz/JI6j3l2OmWWrBOAojqSvI1UbZENKKo82X8gvY38RuHXUCHggoiVv7?=
 =?iso-8859-1?Q?fvkBlykJPawBJ5vCTg6xjHTqAGHbJahc+RhU2losK1uoMpa6hyYahrV+/W?=
 =?iso-8859-1?Q?MfIYbNF1x0gXyy8LQOn6xmrsfpky16ygZY+i79wlhKzbuAI6MMpnFsmQPY?=
 =?iso-8859-1?Q?zp4QxYNYmMgi7qbX56k8sfA+A7VXZ1VhwtUh+IR2IIqt6upsli2lScfVk6?=
 =?iso-8859-1?Q?+kczp0B+eC9e5A1X3mTNHzU2N8jGwr2gOsSniDobtI1kBef+oEYJRo8cuv?=
 =?iso-8859-1?Q?xFYxFDTW+CHBodN4p5bYtCxGIPoCVArvTCn7ER+jVKlPmLW8P/gmk6MnrY?=
 =?iso-8859-1?Q?qjtPD1CaoSmZU/5ik2hI2M7Yro7BWAHgfLksEVNzcTg4+OeYSq0mPOxWA9?=
 =?iso-8859-1?Q?zcrxWNsQqPfTLjBbN5quQNDR8gbwCSGHo4oI5gHYpF9FVpEDrrbbxUsirH?=
 =?iso-8859-1?Q?zqsOGDz/YvlNsJqZZCBgUOj+85GXvlCDF8qPTGsJU8ee1Hp7AIbc6OkNkF?=
 =?iso-8859-1?Q?iSrfSguOu9LCpZLDPhlCWUe9T+bjN8DGPDEDy19R/Ai0GLA+hJVoo63RZR?=
 =?iso-8859-1?Q?zHNmmXGxDJ5gPh7XeaLxdEM+HaUEbit+cdIwAKxP04Hce8QUYSFGVcNSdX?=
 =?iso-8859-1?Q?Kk8/R6nJoIN/xypFMjNbx64CGlg9lOImUEn8C5+FgXJeQDnIgU+/u+847L?=
 =?iso-8859-1?Q?UC7pS2ISA+OqrWo5vxVtZXHmcNABPy9sC6OF+McJpwKVQJyL2TR4Htdpv2?=
 =?iso-8859-1?Q?U/L6d5PNFiFaRWRBH/DBg4UYo49ZVg2h0J5JHH9mWwrb8qd4cJ6gnPLmMS?=
 =?iso-8859-1?Q?7y9CvgOsWao+DH14986T64KNDqpQqBfpN4GmS7qydM3ebYkNEZo2lKq32v?=
 =?iso-8859-1?Q?R+Eq08DPDWnv1DCsVNeT4MVeLpnyYYTKgTuvP/eWI6Vw8V1CZ0z2uuFm2Y?=
 =?iso-8859-1?Q?6iogXIgqfLeoEJkNeMBPvurtQvDoqMdxkHy9oGJ+NDm01ekpEZFrdeaC9l?=
 =?iso-8859-1?Q?ceR6Y8NNG92v89K5hWmY5UHMP/+y19zKT6m/JmXyyx0z1qc8j4INIFrWGi?=
 =?iso-8859-1?Q?js6/JjCOb5mUTRgF1GBsWxehfXVWPCgdul95UkVzC7aLpaEhAHbgOYlZtm?=
 =?iso-8859-1?Q?nirhwxyqXYCWvokxruQrXuvhNEYkreZANF65uWF6Hxd0u2BynwTUgAuvhx?=
 =?iso-8859-1?Q?LvvCCY+2y4IsqAPxN4eng76bsScAUd3TiUzO20hI/0McE7?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: vB+N+/DUiGxYiks6IIAkmrCfek+UJUXrHzQyM5Qyhl85MbwYHmspuMHl67fRdlQYGPyqzgSIu3GWnrRk9xsaYotmVu9tt2aRJHyoSw+R9MtZ1HX6ST7RM06ZYxiyhmSHlEtrwspxvXUZCMvBppJ+NIHrLudu1JA5tIwuktE2lBn5oXkj/aN5wnPHojH/HYyykcOUobrEyaGb9eUj4nFTLlsT1rHmgvZpH+xL9HzJIEC6IU5b2XCENTXx3VoCE8fCT019+ROPguWXRyMRW+E/VKpi+GRtlt8oij2JL7AtuG+iYCfN2UKxiBZU+5MoEv2kI20D/ptUxDijievaRfFtrw==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR18MB6078.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c85b51c-7c6d-4f27-8a9f-08df25f324e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 10:50:33.6022 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GnMcePC01dMhxHmxg9m0kixqc/ZBpYQf6Jkfk38V50ZPZ5z47JqCv1sWWHXJt0ChBauhwDaySM8nM6cEKlw9mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR18MB6290
X-Proofpoint-GUID: G9TzHt51W_3gaihSf7Djq1Z2eBi1y1lA
X-Proofpoint-ORIG-GUID: G9TzHt51W_3gaihSf7Djq1Z2eBi1y1lA
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA0MiBTYWx0ZWRfX28J44PfNPjXH
 k1IuO/Yj2AQpdRqSnyWEtZjYo9Z4AE18Cm+Avnq0y7m5w0rvZZ7i0Cz9j7CucXEUF7GAvp3P/5P
 wr7ujWafS69rrawnsjDbqgEKyLt4DgE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA0MiBTYWx0ZWRfXxPBp0En8uShY
 JtDdYlAZj8wl0hKCIZMDigr37C72FFZ8m0+FwaoaXLT3c3+h/yypB4bL+Jpd8tAcrWNO7JBkiYV
 1au64OJ7lIxCiranUs+tl5QMMx1oj3oLuUItBT2zExvKLvnfYvuy2WetYTxPuNIkKnE1fn2AI4v
 D7F1xG/jJEiigUFKSNos+Lj7aP2tCQts7JDQeCl34wz5QfP/IpwVv+0fxd/V+uAsPZSvIMoyICY
 KoLAnCkR6h0WOae8Y+MvRAM1deq/ZM+E6N823czUMmr0gux9dOkYboQ4OBOYumMZjTuDk3mpugP
 XNNUOp+OB+4RLt+uwcdgeeW1iVzRz3eLxEqDLzzA2WbBGzj6nrT2wSR4I5THgyFvo/y5VtIzDEu
 kozXgOXWM3dLPhGfx9VogahaZFwGsQdxC+yoSX1kGkAXrRE/ZJedoaX0BvjzEm1ggzo23J9s0Ug
 KSjt0DM3qmBl4Rxm+8g==
X-Authority-Analysis: v=2.4 cv=BPQmP1QG c=1 sm=1 tr=0 ts=6ac8c6fc cx=c_pps
 a=cKBc+2/Vqua3nEp0WttuKg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=660iZSQnnn4A:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=gzfXvaMnAAAA:8
 a=IgsfXGlzfr8HMuHhcMYA:9 a=wPNLvfGTeEIA:10 a=2EI2vyesNBw-DWbTCw85:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Mailman-Approved-At: Sun, 11 Oct 2026 09:41:40 +0200
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

> The best approach, which includes most of our work, will be:=0A=
> 1. retain my patch for the test app, which covers more test cases.=0A=
> 2. retain your patchset for the crypto-perf app, which has all the=0A=
> variants that mine has, and in addition the sign iterations argument.=0A=
>=0A=
> Regards,=0A=
> Radu=0A=
=0A=
Hello Radu,=0A=
=0A=
Agreed on the approach. Let's proceed with that, I've tested your patches a=
nd all test-cases pass.=0A=
=0A=
Tested-by: Pratik Senapati <psenapati-marvell.com>=0A=
=0A=
Thanks, =0A=
Pratik Senapati=0A=
=0A=
