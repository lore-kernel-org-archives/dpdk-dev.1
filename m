Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDD7C71135
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Jun 2025 10:03:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F16F42E4E;
	Fri, 13 Jun 2025 12:03:23 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 0C73740151;
 Fri, 13 Jun 2025 12:03:21 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55D5s6Yh001666;
 Fri, 13 Jun 2025 03:03:20 -0700
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2135.outbound.protection.outlook.com [40.107.95.135])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 478e85gdw3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Jun 2025 03:03:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O8s2ypkkQxCSIgTYuahzHO7wQ+mMgevyPOmCcR0f73X4jXckQ/EC+tLzepLr5SsRaocXWi7gjKCnDEBA57aferwU8gZgrH9FhCbX1ohT/cWjBL/34T2hpkA8eRuQBDK/QgR1y+Rw28B8PFbabXK/Qpc4QGCAYBDmMLSi/3DHN31obJhvN3eJICjKlDPsoAlcceBbK5a1iGpjaUvsdy+IpmcH3AVSxoC0AdUltm+wkFtEzMJpJDSDk9Hmc/yceR3sz+/hTshESs+lJNJUo0FQkugxjkcRxj9Nq+SQaZ8Sg3pJBJVMvCU1k8m42DQ0GmlWKc1a1YcecMHAEwTzbNClIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07PbvWByLykpQOGAle1pt1h52EwAjpRpAaLF3T7RqNc=;
 b=BYL5R8sFxzZJtyafaSHLCLisGxeRWX1JH38ELzAxPBYh8vi2DvXailLhaaehZfszTPI2bWOsBpHzFCB4N69gzRP9ZhDvR8llbSbB49TQ9PXB7RdZ1WUXAAwlOEcliJXJ7nO4xxTAqUapFJDPiiw98Iv+Uj651A8adlixs5YiNdvgygCLCyv9pi2omoaiRCmPUkFiZIyp2Ic7OI44YEEqoW3X82SOU44XL+ME8UXdluFQyoIeUwfBcTt1pvvrx9K5imRISz8PpmoY0JhI5M31du71FlxMWlNRUlZ7kpnrrCGZarJa7/5vKjpOKmLM87sHqTQEnbILP7ILfNqU0W71cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07PbvWByLykpQOGAle1pt1h52EwAjpRpAaLF3T7RqNc=;
 b=HepmNphVdVC3M0UpSmq6KlourB7jcOTLS+rBLnVxu9DSLZnpWcc0/TTUwyWRtHmpEWK16617VIkLEX8TtUBdhydRepe2pQcQ/mL7GzCId+YIY/szJ05ginNp+OILlyTTRvynSEx8mmCpn7A1EUs7LLSraiUJojgQN09jGwVAGFM=
Received: from BY3PR18MB4785.namprd18.prod.outlook.com (2603:10b6:a03:3cc::18)
 by PH0PR18MB3957.namprd18.prod.outlook.com (2603:10b6:510:1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Fri, 13 Jun
 2025 10:03:16 +0000
Received: from BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576]) by BY3PR18MB4785.namprd18.prod.outlook.com
 ([fe80::4f9f:e101:dad7:c576%7]) with mapi id 15.20.8835.025; Fri, 13 Jun 2025
 10:03:16 +0000
From: Jerin Jacob <jerinj@marvell.com>
To: dev <dev@dpdk.org>, "techboard@dpdk.org" <techboard@dpdk.org>
Subject: Proposal: AI-Based Code Review for DPDK
Thread-Topic: Proposal: AI-Based Code Review for DPDK
Thread-Index: AdvcSeq/1d1KNYkNTtqMPgr3eYkdSQ==
Date: Fri, 13 Jun 2025 10:03:16 +0000
Message-ID: <BY3PR18MB478574FF76D2777FFACB1B00C877A@BY3PR18MB4785.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4785:EE_|PH0PR18MB3957:EE_
x-ms-office365-filtering-correlation-id: 030240fb-2932-4448-e8df-08ddaa618438
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|3613699012|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?L6DjepOQTSYgC6jmIL9Me4UUFP8b74F8a1OUGoOyBOnbVYQ36j31UM8uIf+C?=
 =?us-ascii?Q?rfTAx7rK9Z9KHKzxMxtZme3Qxsvnl+zjXJH3IR7JnAqZKjPykJBHpBmbs253?=
 =?us-ascii?Q?6zzSQG/VC8lpuHImb7CnYwJi4NgjIL+wmqEDBdq4AaL5c72FnNCdbPNrOOmU?=
 =?us-ascii?Q?iV0HIRZxZK1d/WJT8yv73xuQaJ6Nza/MbTQesNFUdyGzj9cEKf71/WjgrOeL?=
 =?us-ascii?Q?qFchXbSauXl7IzxFnQn9EOQdedC+xmP5k4FTuWyI2ihP8UsIQ3Gmm1j279D6?=
 =?us-ascii?Q?bORZRIxqyh5fukJoxGLWA/zQ8RphciwtftKrx4zakcAAeGY/CwG+gQE4YIt5?=
 =?us-ascii?Q?sGQuRZFqAPnatxAW+6/bA5wKyXdcXC7RV3ckdpr1O3Qc0EGT9+AqAVbC/Vx4?=
 =?us-ascii?Q?H4YoRh0OSfebjxfxzSAtyKiSy2QbcBW4SrgaY0QtK8McF+MhGr8qu11Kc83n?=
 =?us-ascii?Q?8WEsz072ofuCTlcX0FuL+IVgzkvSZQUesyV43D/5mhPNfvrsSueDrkQNvJCr?=
 =?us-ascii?Q?QM5WNV2Q/3mtcxcEsXkzWdBGfqwD97u/opLo3unvS2UG273mHGi+Up59W21U?=
 =?us-ascii?Q?Tg8KRCvG1AdZr/fH47EOofXg8c9vLWGBR7Sry5KcfFQc3uR9mYiX47NONH1m?=
 =?us-ascii?Q?KurYtuzzdxfpmrrvybTzMsFYiTXzt6wbTuSXFhFBzeKufJY3dFZBGkLx3taW?=
 =?us-ascii?Q?12zFne0uK2q5c8rgQSHyOwahM9GrZVI+BJisBGhihnNIzOV8Va/zp/07pVfK?=
 =?us-ascii?Q?qYK4i3vsDCplQYrxV4sr4E8pDS3VoepClknn0fV4maRNB/c9ydKl1MoTXqKq?=
 =?us-ascii?Q?ohJ0xdRX9St/zenzE8xKVtD9Pvt1vTUdioPomOJywCJOuANdmjMWQBk+7QHe?=
 =?us-ascii?Q?wlM+Tk7yrQfEy4T9FHMoB8jkX0Txg3ey7kkUS05LwP9PpMQG5HdAQnQmo2QC?=
 =?us-ascii?Q?wPCuubasVB/EGbF+ZkRmXKUw8OSTiJqv5L5NepBFMV/TmoukfpzapSfnZSTn?=
 =?us-ascii?Q?lL8ab9WF9Tad+sh9zutRR3zz1EveowiH5aBppqOY6PlpnnLTJrIT7w4/zA+P?=
 =?us-ascii?Q?QOi06BbhdsQKwKYZfbD47eXvViKitO2PaIS49jipUkJ83D9OjFoQgjQPNs/e?=
 =?us-ascii?Q?YmvSykB/kL/M/iZi1lBiNr15CdRToqxYyvWrvVQbaH9J/t75Od23RifZDbgv?=
 =?us-ascii?Q?yw7e6d7q4ecMC1J597wFXsU8S7VdzUuU87SDK8S9rBNnHoZiWEnq1G0fZQeR?=
 =?us-ascii?Q?9iUqZkzhhpfBXOpZPJLVsRpyEI7JNVe+g2mcDf6r4oP5ifmfPpLQIzfzIu3t?=
 =?us-ascii?Q?zFXUkEnKCjifJWtG8gkj7A/Bwa0fDxuO71bURqWP2znzPp2lphNMohRmCIjN?=
 =?us-ascii?Q?hnX9sD0Xrrs7nygZJg04G94i9jBGn1HbdAnA/i5oCmXG0mLz8WycOeD2nUXi?=
 =?us-ascii?Q?J7cG6RFin5RxsiBAbfgH0uzjAxig4qKCZhzW86kqaJkEF3s5pGO7fQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY3PR18MB4785.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(3613699012)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?c6UhCdQ++7j943PydO+vYPzWI7MlIClYp9fkB4I8rc5/tbqG76kxxEI3tjnM?=
 =?us-ascii?Q?XeQ/ONGNthtnReq1oHlnVj4wxgiErJRaidIU54sS+BwiAwJaTMUQD9lbSNZa?=
 =?us-ascii?Q?YMYAsXJt+Y30TvoqE5aqOFMOEb/Myw6Hhgq417pLoXdR//zJZbDP/f3LgJIH?=
 =?us-ascii?Q?VGlb6iDrKBseMzX4r9mpdk8T/vg+sYA2aY9Czffvmt9R+vVTptKENq5D04Zr?=
 =?us-ascii?Q?87aA+gh7hD+aWzFAkn17KpPnkwKjpP/C/E1zxcB1sqb4XMtUUEdltcR3tJ8n?=
 =?us-ascii?Q?hRE/AovVsrfm/N9bnuOgQ6uHurdtC8h4iAZemficC2IDy7HnE990UitTsZ67?=
 =?us-ascii?Q?yPBdHC/YQvjAotKcbgcElGJEWmGetbEDPl1vNJYh5XoQzGx6G3zya0IgG2yD?=
 =?us-ascii?Q?fwSBCUpqmLVPkb0xNidtM+6tX/aovUbc4fIChQptMgl+m5zgN2lj/mtFi/iD?=
 =?us-ascii?Q?Ru73aOybeSqYFQIwFsbSjOvsiwkR3x64n2Tob6tEMNRpLzinQUPoyxeuAIZv?=
 =?us-ascii?Q?LUPRpus2Sa+PdHrtKunMyd/QhF81OcVF71q16NtgECD9DAiInoiUEn+jn1NR?=
 =?us-ascii?Q?cNBvCx+FGsGXScsmz20TWTN9EWtGyGl4y9AJPk+MDkUUPsJXbeQh6hktwDOf?=
 =?us-ascii?Q?H9u9OXO1kpmkm3m8baP1WHa6ecCYFlCMvRNTA4iI8FVjlLzYuUOSkcnNiBnt?=
 =?us-ascii?Q?3+OiEVc3eaokiR+bSCRMWItkuQxEIQiMjNqraZzFkZZYxB9IN7Z4edcQe7FW?=
 =?us-ascii?Q?/ITNxoVQ+ahTCPmgwPZBmd4C6mPgJntRW6LTqNe3yRKWAt8g0Nm7GPZuf2DT?=
 =?us-ascii?Q?RCTUxCP+nhp9BW8VcH+yeeUcq6RyhqGYztXgmYFaYRQc4AaT0jZ9glY0S3+x?=
 =?us-ascii?Q?/yvcYJ+GlxNa1w7SwFSMyCQ69Gnn28KZMRzRsCGjjQc/GA9qSpXP65GivMBc?=
 =?us-ascii?Q?EqJAHhcXOIvDK47Oa6tP2FstVWbprtQ7k1YDSIzYnh9X1z2frCGtMtchKXhB?=
 =?us-ascii?Q?lznI/0i6m5BE+vO56Y+QkS8OvqS/8Kbhemfhm0cIi111JbJBz2ilwxFddeNo?=
 =?us-ascii?Q?pKgD0Jl1+o1KBbYNLng/glNpqyHwXrk8HsZadY4LWtG4SQOaRvg4NG+eZXnw?=
 =?us-ascii?Q?LCfSn07CBOlAQoDeUhQU+aS9qgl6zNUsDPN7g9UlelPbEEJHZJRAwaVBlroM?=
 =?us-ascii?Q?yKfS6UzlFeitiD/rp/Jt6RmsmVgxmvic+ZydZL6gABWjcihWg8yhIyqZuwG6?=
 =?us-ascii?Q?UicIkpYLDZpe8CKvvTQ6JU0LcmiMyvX9tOCylov9aEc7FKlWW0iPiNv9uX/8?=
 =?us-ascii?Q?WGlfv0Jp1EHx6PUY36LyogJ8/2aAsB4jv16q0Sy75nenSW2VuR7zoKTvpBzv?=
 =?us-ascii?Q?q+kzbYPd8WpnTpgnWUoxxNLsRe3/+ug49Z65cMVokNyOhjIe3GB2wlk4DJ/R?=
 =?us-ascii?Q?CmIK51n7c5l8OlbsqEf5O7GIS1dEnvJYqehQ+Xo3rMVTpN3PLz9vSL6n48eC?=
 =?us-ascii?Q?DefR3I4Qtm+ITAwo77EbTqVjePb2j7WCSPty4S2lBJcY7Y+p0fokuMGcCn6Q?=
 =?us-ascii?Q?danyNhqJoK0FyOlAvugyt+XVe8+vQxvYUlmljFSY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4785.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 030240fb-2932-4448-e8df-08ddaa618438
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2025 10:03:16.3269 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LQdhtwHaFUTwRQ4lam8THRVEBVX6IlquQkjP/kco/LzJe6PsV1veyQ0Fn+GmQ2HCKUOlI4elADS76jcXC4dQwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB3957
X-Authority-Analysis: v=2.4 cv=PL0P+eqC c=1 sm=1 tr=0 ts=684bf768 cx=c_pps
 a=73ZZgQctQage88DP8+znzA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6IFa9wvqVegA:10 a=-AAbraWEqlQA:10 a=NEAV23lmAAAA:8 a=3JPJ8RGXAAAA:8
 a=C97XvYbR0H-0fQY_KH8A:9 a=CjuIK1q_8ugA:10 a=xsAzC-ErGQJ3RAER8IHn:22
X-Proofpoint-GUID: Yqqw0pQcUCMyxd9r72d__MBCC-Giwxgl
X-Proofpoint-ORIG-GUID: Yqqw0pQcUCMyxd9r72d__MBCC-Giwxgl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEzMDA3MyBTYWx0ZWRfX0/+PcwV0G278
 lGd/RPlRN4pNshynD77pgfN92XDSupHUE9wu13lUGrsDH3dH2Qk4bnkCx0bzJp6gjCnRz9IsFGK
 6aMlHl2xliY5SGfSt9ujSkpKdNnCQC61p0sWs1gODoyfjIchk+Qm48P7Y5GdfZn707h5siPMPHs
 eLGN/0DrNdAXkjxCFvXA5e8Jqih7m7RPP+DPrz7RkW0EeTgJg2iHvBp60ITNihj/7QKmIcpJDe0
 TPPY5Cji1ZBGWJjnPEv4mVnMSoE3sKSnvM9CQVdRbL+Ol44Ktjc86VWZilMiBs2obIvPuEZGjoP
 qAG9wpuaobXBAwlWY9CIOjqua9R5eh9Zpw7PQuv2+Wxow9gw5cRM8Mt3F48ehX8Tlrf4IC+247s
 SMnw70SLgiE9Zi8AgClezOPaLfrD61w620cwv+lDkNyl+cuAVwEX6QaHXArcbeazGcSWAASD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_10,2025-06-12_02,2025-03-28_01
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


Goals
-------

# Leverage modern AI-powered code review tools to accelerate and supplement=
 human review efforts.
# Prevent AI-generated comments from cluttering the mailing list or polluti=
ng the main DPDK GitHub repository.

Setup
-------

# Create a dedicated repository:
Set up a new repository, for example: https://github.com/DPDK/dpdk-ai-code-=
review, under the official DPDK GitHub organization.
This ensures that AI-generated pull requests do not interfere with the main=
 repository (https://github.com/DPDK/dpdk).

# Select an AI review tool:
Use a free, open-source-friendly AI code review service.
One potential candidate is Sourcery: https://sourcery.ai/pricing

# Connect the tool:
Integrate Sourcery with the new repository via: https://app.sourcery.ai/?pr=
oduct=3Dprod_opensource

# Trigger AI reviews:
Once integrated, any pull request to this repository will automatically tri=
gger a code review by the AI tool.
Example of a test PR reviewed by the AI bot:
https://github.com/MarvellEmbeddedProcessors/dao/pull/2

Workflow
-------------

# When a patch is sent to the DPDK mailing list, a bot will convert it into=
 a GitHub pull request on the dpdk-ai-code-review repository.
# The AI tool will review the pull request and leave comments directly on t=
he PR.
# Once the AI review is complete, the bot will close the PR and share the P=
R URL:
- As a comment in Patchwork URL for the given patch
- With the patch author directly.
# The author can review the AI-generated comments by visiting the PR URL, i=
f they choose to do so.


