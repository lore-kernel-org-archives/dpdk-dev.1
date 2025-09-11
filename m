Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A587CAC587
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Sep 2025 14:53:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BA366402D3;
	Thu, 11 Sep 2025 16:53:39 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 15002402C4
 for <dev@dpdk.org>; Thu, 11 Sep 2025 16:53:37 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58B7KQSk030857;
 Thu, 11 Sep 2025 07:53:37 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2133.outbound.protection.outlook.com [40.107.92.133])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 493sxv8v9b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Sep 2025 07:53:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p/Qwh2Ju6vDqTsbXG75BxpjTMIkFjIkgN0FCtuIbgQJVG57HZv6mMoLc1l2NtG91Gj7VSSYI2TKMpRUfrMUqsbu1QGiN5ORFB+1C2WrV09hBVVjGQ3v9eUZks49B848CGc/3LCZSWGyTfWb+OnwkGBhpodG8z7ygZbxcXSOdFR+0ZU0LO4+TUod0IeGHu+WHG0eOXkQbiF4bmTUTwWU/DjHI2/ymENpORL/xfATZ+EgWVWMiFeCins7k34sFwE8N4ksZ1VIy6EJqd7no4XKH7C97rU72csAEHJgIoUk8LTJ7v0a4gQ3hlj+IR7tFv12W72a8fWZ2v02KxOEbPBTzrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n6S5EEuJcpvqpNAs+qlQv3TYOo/WUCDKVaeZjRJa9js=;
 b=p3KPVrSlYwSJMd9nXOy/rLZdYKS4sDSw6MdUTqT0JXyoW3mb1jPuwIpYrYaZtVXgS08295fm14Aek9sWA97f84ZYownxjiQtO7dqTv/1gLD7r+c985T5BkGVtz2x6EOOKtCSpOuuRwbuflVZStlLNuyQg/+6Th1NkqKfOci8mjp0LAndPkyRJKf7nmT5gEudrZ36yHBjPRqW1IPUBW2NntLerSugcRSR8ZLAcYydb+/h5UJ4sKp8LM6QpwnbG67jm6k9UceqmnZ7Ukx1uSNFTgNPmbJmOnoLhLdbg5bC8E1yvH8Bi3KqEMTNxjf/p149bebCh95/b8OI5ue1esi1UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6S5EEuJcpvqpNAs+qlQv3TYOo/WUCDKVaeZjRJa9js=;
 b=evU3I1bf4lqf2HLQtSVOhQ66D4D2fwQioD88Yol+645NSGDJZvNpDQ6O/j6+RKIwdsE6y106c2Ss4+KkQkbY3nBuXYvljmJ0DeUDrwqqWd2VvKDqYc9wXhOFzwi+Ccj8+OLSJgsE3qdkPvy+ciWJaAFMfZg3QjCW2mcUyBrxaKM=
Received: from SJ4PPFEA6F74CA2.namprd18.prod.outlook.com
 (2603:10b6:a0f:fc02::f4b) by MW5PR18MB5239.namprd18.prod.outlook.com
 (2603:10b6:303:1ca::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 14:53:34 +0000
Received: from SJ4PPFEA6F74CA2.namprd18.prod.outlook.com
 ([fe80::afda:792f:469b:631a]) by SJ4PPFEA6F74CA2.namprd18.prod.outlook.com
 ([fe80::afda:792f:469b:631a%2]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 14:53:34 +0000
From: Vamsi Krishna Attunuru <vattunuru@marvell.com>
To: Chengwen Feng <fengchengwen@huawei.com>, "thomas@monjalon.net"
 <thomas@monjalon.net>,
 "honest.jiang@foxmail.com" <honest.jiang@foxmail.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "liuyonglong@huawei.com"
 <liuyonglong@huawei.com>
Subject: RE: [EXTERNAL] [PATCH 00/10] bugfix and refactor of dma-perf
Thread-Topic: [EXTERNAL] [PATCH 00/10] bugfix and refactor of dma-perf
Thread-Index: AQHcCy3Ww6N0Be7oykOWSGfIeU2sZbSOQGlQ
Date: Thu, 11 Sep 2025 14:53:34 +0000
Message-ID: <SJ4PPFEA6F74CA216692DA006E81BDBA44BA609A@SJ4PPFEA6F74CA2.namprd18.prod.outlook.com>
References: <20250811105430.55791-1-fengchengwen@huawei.com>
 <20250812020708.16186-1-fengchengwen@huawei.com>
In-Reply-To: <20250812020708.16186-1-fengchengwen@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ4PPFEA6F74CA2:EE_|MW5PR18MB5239:EE_
x-ms-office365-filtering-correlation-id: 56638bc7-6374-4caf-c874-08ddf142fb62
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?WPpFfmiPS7ftCD5zr4U+4SBECOv7I575yqQE2mJaSsNqpsunpLXxEQ53IRaE?=
 =?us-ascii?Q?tiG4no+I+xaqlEcKifE+JosTgPYfiBSR3lixgj1+NMCUlpMiu6Cu9lBRr3Pm?=
 =?us-ascii?Q?9NzVfIheSJpSJaorocMTYAzCMOQDYkeKTwf3P1R33FmXQTfysXjd3nr46cfL?=
 =?us-ascii?Q?nEoMLX71RxmZduObvk8qE5w0wa1eJrhD4ZzMboQolK5ZCzLNbqkdTBtYAYUU?=
 =?us-ascii?Q?Neb+Ae5Ocrh9mqdvOP5TAr8xPutUXsIBqk48pWTlvQvHQtq8nkOV3XbtH4sA?=
 =?us-ascii?Q?DHJdMGJq8Coof0Rfo14YYe0/BvdnsdA8E4y56ziVbxWsWSo7BBH6ghY6dMdl?=
 =?us-ascii?Q?L5teL0QS43sWwBF/GBEwyBDOJYeu3GorAIXokgosAAB6gjVDMx1vBw+vnfB5?=
 =?us-ascii?Q?rdfOYzHAZvV6BiZk5lNlulmhybFqP9L9EINxRqMUy4g1sH9nchBiPOl+A3+/?=
 =?us-ascii?Q?8ZU40gsli02X9s2O80NfpUL7mEd5ELil6cl58d4ouUdqNiDEPeC0i2uz8Amq?=
 =?us-ascii?Q?Fb4SJuFHLA0fK2mH6qeBDIeTh8F0WhGGDvKGIzCW8wX7hBA8W25h6Mie3zDs?=
 =?us-ascii?Q?1hJSbyZ1DHxFcV/B0Zp4IrGBRJu1ISEUpJ7aYh1RkzLWHBJK8+Aleaj6xCH0?=
 =?us-ascii?Q?pCnjcAn4x8+eth3rw91pnSehVhGiZ5k1g+IjOqoDXayqVl+8i3p5AxZV+06h?=
 =?us-ascii?Q?+LR5APe9IsjyjrIuAvs+9qTMMVbFg8EngEVdRDuDNQUNnjQ9/3tExfWpsy6y?=
 =?us-ascii?Q?7ATJQt4DGpdyKuSvdJXHh0GAKK7uKhLR0V2DteoEGA1niR0MdumXGVwUPth/?=
 =?us-ascii?Q?+WMqnEPaPq49Iv6mdlgOvIwzvypJFoPwpbiqg190LZG43xc5WcZz/yT0kTqF?=
 =?us-ascii?Q?FixNXdiEU0WdeX4lj8Ty7pdDARXVjFVzYE3+y1xHyyj2R0ut3zmjfqnUoqpg?=
 =?us-ascii?Q?myLQG7AmITtmBRtExcmOQgom+56++/K+lhl0vMZS0oRpWfgivYjpnPbNCbli?=
 =?us-ascii?Q?dmTtF1wv6ZIOb4w2MP6XTfYTS44mYE3tONNQSYlykbKF47nt+lUgzv6gWVGW?=
 =?us-ascii?Q?Lo8oMzDUjEOG21gLl9fqW3TPptpVvgFxtjjC4QXyMiROIHdNMMMo+e5HcyeV?=
 =?us-ascii?Q?/7od7dW9ECFnBQ1tsVR0IdtdJU3ZuX/QqlBtVGVSP8EwiW4cC84XAOF3JILd?=
 =?us-ascii?Q?4/oAEz2GP82PFTrzzmGTPNxtL+odyOQ8KqFe0j6p2ND5YHeuOYKnWfin6qJC?=
 =?us-ascii?Q?XdhV7AsGrlo/DQL0TWe4sO/K3aLzD+uAXfOP4A5hwg/u+ePXLgiBmcciLsCS?=
 =?us-ascii?Q?9gUwmYnsDGUhn+jSrCr+B8YdV3RWN5gm80J/2XM75ZdYLIpwPvC9Rw6M9M1L?=
 =?us-ascii?Q?ztSrl41FDDaK58Ox8N5xiN5q4VPMsxomDZZvziDnlyoxyKSfPsitmutvUR3P?=
 =?us-ascii?Q?dcFMrZOFB/o=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ4PPFEA6F74CA2.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nWJGBEN57c3hKFyhhgErSRElMwecWNS0dtRf/C/w04+M9TatqzS8fyHH3TCv?=
 =?us-ascii?Q?ScSXvRsSM2D4Gt4eS+TV44xz1NvqH2WJKGf5GsHaonUhXpAoNvl7I/hCu3Pd?=
 =?us-ascii?Q?Mtlt3/lOHtu8r3Rn9LJZiRJ65aQAb3lXkK87WE8giNCj/av99DruW0Q9YkUf?=
 =?us-ascii?Q?PXyCAdmVu+L14ZkXl83iqkdc5fm9Ks+Cax6KyUTp8ncQ6wi/Q+QOZJ4BlBXu?=
 =?us-ascii?Q?aMIDVRLO9vQRg5008hV9vGmhTUlMLFGodgtzcOdXF+d4fywJul+0Af0L3itH?=
 =?us-ascii?Q?uQRJ9HH9qHCzVoF/KGv1By5vOERBKAUy6cdqWOobK669pJKjTFoMt81wOvxG?=
 =?us-ascii?Q?YmjUQC5O79WSrmG+GetgzueKZefFxUe+f1clEFoAVVh2Hk4hBpu9BUr2AtX2?=
 =?us-ascii?Q?PqcShWxOKz6JtsH5X2dkluCnatVHsnw2UcTbU0LshfNWAMuq1tVBYjlJ7nQR?=
 =?us-ascii?Q?Q+ZqD1GdbPKL4z/BLrFLDH3SddXwHDITnhjaEwIPu9Hrw6goYVyGUNe+cY+e?=
 =?us-ascii?Q?aygwDIrOgclYXB0HORzXq2n5Go7TfxTSVXLPQeM+YBEV+dwdh0c1kwGEzsbS?=
 =?us-ascii?Q?ArJ5nwYBBUNFyQ9zZ/sOvlJ9TLCcllhA8T25mHKIsWSirFPaYM2XMI3GQ7u9?=
 =?us-ascii?Q?QZu09WDJcGLv8teUCHHxwhnTdma8UpdotQqDIS4YJrh+9CpAIl8rMHwcvC6D?=
 =?us-ascii?Q?E0elA1zJjDW8L8zfb4Y16FfcdCFDH1DtIj12GSPbEYStHTsedyyKTRNoAJE/?=
 =?us-ascii?Q?gXzSpKLhEEs8D0T5LcJ88ySu+MHOfjYlL8SyF9xHvkT+Fb+SBX080mqrTkTg?=
 =?us-ascii?Q?c8MSYKj6ChQlWowSFan63xh27Azqho+k/GIRBscrqQoTQg7qeqr+X76q6k0s?=
 =?us-ascii?Q?l8eOiqaz8YiQ0acnwhg3IomTnrSro0+4+83XJN1f8Ifpdpi8+ydcywmKYmKP?=
 =?us-ascii?Q?z5RgF1OLM12gmtHoGjaNQLJy562qPm2vZoaFU65ZGEo5ZJ1qgWi0cXjM/6ru?=
 =?us-ascii?Q?rVq/t4Y7IVZ3hg74ZlOBLXLrxFKBmx56SR3lw9suX3WqF1bmszVyK5RtxZc9?=
 =?us-ascii?Q?ll8wpNHQf6gRslh3JUk3ls/M+kRhsW96QgUcdkI9339qxBY3cHKMuMpwbdu6?=
 =?us-ascii?Q?+0kzdGu/oKsbPnD5bNk+kBBMnk/Se4qk21V4a1t6oYHhg5ke0vZ3bly7ztYW?=
 =?us-ascii?Q?7yA+rTC5mjLsVKyE46mc+15/YLp6H4XSn0/V4kSkN+bhxCf1EnkKjoCC5TtH?=
 =?us-ascii?Q?SP8bbmBCUOnbVc3BRY6TOrkvL4cFCTGXr/S1xg6EwmnHSKtn5eqcLjB5QZqK?=
 =?us-ascii?Q?FFi529SM62jftDJ/mpmgHyikTJxK6nupG8vLFRzgvevyOzYi+0eXXrzwdMy4?=
 =?us-ascii?Q?80f+hjxTDfQ1wZrwowcUfloPIsnDRfdD9IEW++0pWM8rxW0RFCnZBhKxz9A9?=
 =?us-ascii?Q?ydZttmiIE7KhIf+nEOb1UtTQTpWyKJsUilEMLzQ//IL0AKT2SCwH2s9pfFY5?=
 =?us-ascii?Q?0uyEuPvoFG7i+XVLgfhxIAbeWd8MdPJ85m0EzX0F+zTDrfFtmxfl4oNlwWoJ?=
 =?us-ascii?Q?Dj4UWLFMm9X+QM4i5gADrQxN7wZsJDIHp5dHBzMb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ4PPFEA6F74CA2.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56638bc7-6374-4caf-c874-08ddf142fb62
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2025 14:53:34.3773 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XaZ61CIzoeD2T1SnPobvaflylMVjBuZvsEH3n/JiaAYseJJyCDefrZt7+2a92ZDFo2l/NccGG/BlSJfoy9hyrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR18MB5239
X-Proofpoint-ORIG-GUID: __TpgoGVe6QTjP6Hcxiu5D2aDyeVOKRc
X-Authority-Analysis: v=2.4 cv=LrKSymdc c=1 sm=1 tr=0 ts=68c2e271 cx=c_pps
 a=IA3z5DP03+00aNcgMV2pVQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=-AAbraWEqlQA:10
 a=i0EeH86SAAAA:8 a=bt5KbKNvAAAA:8 a=bDN84i_9AAAA:8 a=8rWy6zfcAAAA:8
 a=RpNjiQI2AAAA:8 a=M5GUcnROAAAA:8 a=u1uZkOqfyyUSf7Ke2lAA:9 a=CjuIK1q_8ugA:10
 a=a-zEBD5cKgE7DNtTSb7C:22
 a=J2PsDwZO0S0EpbpLmD-j:22 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: __TpgoGVe6QTjP6Hcxiu5D2aDyeVOKRc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTExMDA2NCBTYWx0ZWRfX+2O2yvV18tzQ
 ev1DVyWFPsqMg/7OMUSMj8sAraHBZcqxIyg03A6hPnKadfbrrzyny3QE6wD2YTD5t7MigiLQkrv
 kCVp9za+OQ1LoUEtLQhP4cjpEol1bOuHu51qwLG1wzZCO8QAxZDSSUGmxZdfCrtpQZSvmR7Yzta
 RZJzl6Kjxio8dsbgxomnj4DSCh+qsgPGVilbYiURR/2JYLIf+p9iR0iyUz7zUec+CfdTKRLvm3z
 FtRFmre1lbQ4vs7Lbt9N9Y52tUUCjrzV32IrcXfo5OikPdb2cjWM9EgRx0J4Kn4F7krM2J2n60X
 0yb9rKelBEjIy18LF7n59XinzOHPuzriz0XJ3pfEK0fBKeN1DkmdRIEoghhnEA+2EBih7LoL95F
 713mC1Cj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-11_01,2025-09-11_02,2025-03-28_01
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



>-----Original Message-----
>From: Chengwen Feng <fengchengwen@huawei.com>
>Sent: Tuesday, August 12, 2025 7:37 AM
>To: thomas@monjalon.net; honest.jiang@foxmail.com
>Cc: dev@dpdk.org; liuyonglong@huawei.com
>Subject: [EXTERNAL] [PATCH 00/10] bugfix and refactor of dma-perf
>
>This patchset contain one bugfix and eight refactor commit for test-dma-pe=
rf
>application. Chengwen Feng (10): app/dma-perf: fix use-after-free app/dma-
>perf: add global section for config file app/dma-perf: use argparse lib to=
 parse
>argument ZjQcmQRYFpfptBannerStart Prioritize security for external emails:
>Confirm sender and content safety before clicking links or opening
>attachments <https://us-phishalarm-
>ewt.proofpoint.com/EWT/v1/CRVmXkqW!ti3Z1f8UAnTa1E-8-
>d26bzh7tQFqbKBdLU9oLN5L-
>Aaqbzf0spmN1mMd9tGvrkwR2vLtT9OuVOzwc_JrGGPezhvZxK2lONqTfg$>
>Report Suspicious
>
>ZjQcmQRYFpfptBannerEnd
>This patchset contain one bugfix and eight refactor commit for test-dma-pe=
rf
>application.
>
>Chengwen Feng (10):
>  app/dma-perf: fix use-after-free
>  app/dma-perf: add global section for config file
>  app/dma-perf: use argparse lib to parse argument
>  app/dma-perf: refactor output csv
>  app/dma-perf: support list DMA devices
>  app/dma-perf: add more global config
>  app/dma-perf: remove invalid or redundant field
>  app/dma-perf: refactor load config function
>  app/dma-perf: refactor benchmark function
>  app/dma-perf: support specific error info
>
>---
>v2: fix CI error: format string is not a string literal
>    add one extra commit: support specific error info
>
> app/test-dma-perf/benchmark.c | 182 ++++++-----  app/test-dma-
>perf/config.ini  |  35 +--
> app/test-dma-perf/main.c      | 573 ++++++++++++++++++----------------
> app/test-dma-perf/main.h      |  28 +-
> app/test-dma-perf/meson.build |   2 +-
> doc/guides/tools/dmaperf.rst  |  50 +--
> 6 files changed, 462 insertions(+), 408 deletions(-)
>
>--
>2.17.1

Thank you, Feng, for the refactoring.

Acked-by: Vamsi Attunuru <vattunuru@marvell.com>

