Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2CFBC3601E
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Apr 2025 06:02:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7E3D640270;
	Mon, 14 Apr 2025 08:02:48 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2098.outbound.protection.outlook.com [40.107.94.98])
 by mails.dpdk.org (Postfix) with ESMTP id CAE2540265
 for <dev@dpdk.org>; Mon, 14 Apr 2025 08:02:46 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nWhzDwKgzlgK/87yJwdTgRzYPLD6pWs6dhoy/Vt8/hz0eEoCqfOL0DQqH7YoWwo9UsdC0xx1lFH14s8mfYkLYB+EgWSyquSrExFlfClc+cjQKj2UOvDZRsJVJ+Acd4JLZ61o/5uFHEMU80rG+2WWpkdWbAiDkNSGh+nalr3J4NAOdLp6guDKxKCEoiOYi3yK5TtMJkvCNaZ90yugP6fmd5xIkboPhOeAyKOaBZmhOlHHMIg5IVkgFVp3I7P2J1s7vfkZ6yEU/V/g+0RuTscrsimuuqxjtC0tm06KQIoZkD41bsZOp6sepPiOg3Bn2Zoewoqp3rHbGGhyOd8iNnbGHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EqOLJQCU6yb2Obffc6kAwuuYGFXzpYIXbG6sRCof6JE=;
 b=DLxN++6dQwzQSutgvg8AWtwZdMpyYLDDPa8FcQaLDLOaG8EkawEhTYZpJJoIFB1/ogv4SCx56OCPrPI0tqLILyeELfA8YIFz8AO9DCH9Hhtwx+00hFa6OOCVNkeBPP8J6M2QNDQm7DnUQqhD6oxofcAgLQ/rNPBHYNFyvyGqENEsixxWALCWLoDMGhl/YS3X5mWR6iITrpRd2ig7RBePEfRvqX0FW70wbMglQjY486ZqTznIEi/gYjy9exPuZgzwFuFveDWi15rXCsOl985+GEmHp84NKSCdTCvWJScU++E2aiIGrMIFhx9DU1BPG/tTe0bvMnLlrWN5k5MqFi7W5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EqOLJQCU6yb2Obffc6kAwuuYGFXzpYIXbG6sRCof6JE=;
 b=okqedZKktRtPPsbfHHPwu46MXjcSnx8f9BU77jZoXrB6iL8tE8BmGKTTzUuDBKHw3EwPAn99kNvf/C1lDwwHLciU8ugseWn+hbWje1OzCzyVLso11lLYMWcRJZVOLyjtDRq91R3E8SeWFkOlPb3ruNCtiuz1glM2YEExm/Sywhk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from SJ0PR13MB5545.namprd13.prod.outlook.com (2603:10b6:a03:424::5)
 by BL3PR13MB5123.namprd13.prod.outlook.com (2603:10b6:208:352::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Mon, 14 Apr
 2025 06:02:43 +0000
Received: from SJ0PR13MB5545.namprd13.prod.outlook.com
 ([fe80::b900:5f05:766f:833]) by SJ0PR13MB5545.namprd13.prod.outlook.com
 ([fe80::b900:5f05:766f:833%6]) with mapi id 15.20.8632.025; Mon, 14 Apr 2025
 06:02:43 +0000
From: Chaoyong He <chaoyong.he@corigine.com>
To: dev@dpdk.org
Cc: oss-drivers@corigine.com,
	Chaoyong He <chaoyong.he@corigine.com>
Subject: [PATCH 0/2] fix two nfp pmd bugs
Date: Mon, 14 Apr 2025 14:02:25 +0800
Message-ID: <20250414060227.1251817-1-chaoyong.he@corigine.com>
X-Mailer: git-send-email 2.43.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::19) To SJ0PR13MB5545.namprd13.prod.outlook.com
 (2603:10b6:a03:424::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR13MB5545:EE_|BL3PR13MB5123:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e9475f6-38d0-4f77-999d-08dd7b19f84e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TdVzOYRldlKh2+i12tRsIZybAbz6yERwNeTFnSjfKyzW2MicFR4jvomTEOZG?=
 =?us-ascii?Q?qu8dUvMZEPmbCH6WHZ0BsEhZj3UtJRSLh/Xfv9wlDNnIwRb/fmB9hIiRFVLd?=
 =?us-ascii?Q?qGG4yyzBkB2FqYyn7RGnws/gGjINXPr01+tmsu0SQI/vx+LYV6sH03dd83q8?=
 =?us-ascii?Q?ka258BBgvmvKraAajor0u9Z1UF+sO40wBmSOo2Zo/KjyeLKq4qoDLW5f3C1B?=
 =?us-ascii?Q?8qNsqXRIU1V6AYaroGBCXUHdgQ2MDzvBg35WcaiWzMDIJwl2MsrxfFqA/d+R?=
 =?us-ascii?Q?vN+9wzG/kfT/5XgQGR0q9dKWA/qhEyt/AlytMd6aB1eMWnf1LcaXX72/qT/F?=
 =?us-ascii?Q?LHuHdsA7gMhAwT7H69Qo3w31PDemjjIVCHglk5qmJ4PwWxjOUTjrzSmua8cF?=
 =?us-ascii?Q?Aa3QVNUgZOSmuK+LU/40psR5KkxeOYgZMRvuAwqQtofHcfRK22EPa0xy/DDi?=
 =?us-ascii?Q?gJtxSxZs0Rp5NLYNXIdTqEmi315hkhf3oG/Uv3iqOJTd/ZHAKs40GFLFShVr?=
 =?us-ascii?Q?DNqwBGHUctBY8Ei99NM7VIhDb0nWMGO3enPQBY+xY/ACr2vaNfi4cT2m1oz2?=
 =?us-ascii?Q?ui/LNPKLRRZ/T8/kc3Z5UrSzjBJXc4qwqaCVybKHGXB46YwKq1TEuI480Uru?=
 =?us-ascii?Q?IufprI4MSGs6AtJ++ubM9ZM6FCO+JnowqWuCNU76db56NS0KoA74wx/x5MHB?=
 =?us-ascii?Q?ooQovtYjuFiI7G6IzGeOOLLaZ17SMKx53bakigRgbH7M2I4SFS0Um8nQcsHl?=
 =?us-ascii?Q?8MgaXeysmnkHk/aui6chofK3nd1F3BqNLbxhHLl0ckrf3cXzHPtlEJA75jJl?=
 =?us-ascii?Q?5g0NfdX4rouJOL/jZE3cUP+AJz0B5CYZGo2wked0ragDuKJw5mJZrwcltHeu?=
 =?us-ascii?Q?sS8Af6OMIdhKrvAxBZyDHaH5LPZzHIUl6owxheqxGQzHX7iVo0zK4y2B8C6Y?=
 =?us-ascii?Q?m7HUjb6kqz+wZkSv2WtNCnBZoSrlULFsC1OZ+hF/46UunKgm3UpqFx8Zd6XC?=
 =?us-ascii?Q?1D/WcIcqyXYoFZVhPI27vVbt4gCPqTjIehidinhV94lQ5saKFvwQwB5nfZnz?=
 =?us-ascii?Q?Ing4ktCmPXNEO8w3S/xgMkGItiW1RZZ3o6p+VkGIM2SxR3BG0Dxgs2cGrm8d?=
 =?us-ascii?Q?rotXR0KZd5efQ4C57ZcN1fOKQtszrM7qzXgV1H7rVl0x/xGwPBFQOaQmXasZ?=
 =?us-ascii?Q?GL1KW9MRtqpTTTSl/mn7Hx+Oy6Tu7SeKAya16BarnnoimEwS7miW0ToWG4SP?=
 =?us-ascii?Q?8fDIxYXvc6t+A2LHyPv5CZJB8l0bVJhE7yglcETJqIgop9CAozPEbgyLRLZ3?=
 =?us-ascii?Q?19Znfc2sVLQ7GU3B/nEUJqZvSSMCZsF9p+K20mWBR4Bvud094sm7/lU6jzIf?=
 =?us-ascii?Q?zenxhO4xqLjyqqPY6hZIRgsaHX4LOM9vfimfNPTpXwgmXXVOqJXScbX+9dBp?=
 =?us-ascii?Q?/qrUm22U0DI4s5Yr9WOsSv6qT8G5Dgwn/NGWIDarwL12kZVgDkW9XA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR13MB5545.namprd13.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3EwZ9hSr3iT94c56Y+Bxr4Z1cfcSxPO8REFW/N9nCBXNwqtZEY8Rd5ypfnuF?=
 =?us-ascii?Q?1cK+g4k4GJB3InFy+RufPQBaHGwdUtJOUgbw6Waa+1kprRqM+yxbS6/AQSTf?=
 =?us-ascii?Q?I1QIRZnJXmWvDBsJX7aKMnzbgDQ+6D4GF5GIaLAJjHhfEa4qxQeI3xomVnKX?=
 =?us-ascii?Q?GjbvX2ZMpwAtwf0Upy1lnkD5GxhmBrTvv8MMKqTGxba886Pa5FLScztftd9B?=
 =?us-ascii?Q?ZZbxYmJF7y7rAfqJBaK+COBNArtk+gCAuMqpUIelrK/OxrMovRJzAzqC2tT2?=
 =?us-ascii?Q?8HM5dJ1aZGKEUzXA1DL9MNQbwLzhTK7A2CnwNBzowAq1pKaibwPlVSmrHgv7?=
 =?us-ascii?Q?rzw0r0Nol012w6QkZ/hq5OTmESXJwICR0EyNIYYqJWZMYuYYG/kxPMoY7uVy?=
 =?us-ascii?Q?LsMuwFc64ktRvEEqo3V9DhhGovMeCwiFYJEFrg6O+hRYrU+KW7GosQMJIjYG?=
 =?us-ascii?Q?0x4KeGGr2st9VCbgwJbhNY8LgqSt3joNEg8TJsJ/VWEUG45TRVvZzk/RnsAV?=
 =?us-ascii?Q?MGQu4FfqmPLhGKCBqxbXcG4PMcHM0MplYS7Rs+ROPQrP4zCoGHbH3eBEvxmr?=
 =?us-ascii?Q?36Do4PDAhaTDrSp5Z1PZjDd282OvPyNqV+DDdDZrNAlfbOxJT2hN933BC6VB?=
 =?us-ascii?Q?XZQpu60A4seRLovFsl/Vi5H+d18/Mb8vCjUg6/unl+RNX6+Jaf9s6+24RfYe?=
 =?us-ascii?Q?wzm2ybSN99hoQczNqEW/vO7sEbjPY6Atc984S83dk3vAFfCMMlQcrRwxnSxS?=
 =?us-ascii?Q?CP747w67oBc5bSjKNmu6zaqFKazq8R0GohP5hi9aF0hVHlfvwmYZjinU9BE8?=
 =?us-ascii?Q?BUIq15+02phKcaYRKPSw1BKjwWgnYvYL55sKlJAj1EQAP6YFaLXCz8k0ce1F?=
 =?us-ascii?Q?btRsmJErMeZOAmowzObHDsTNJgTrH5NROtmSwVr/WUnxpfFQ63pKOfo/2NMr?=
 =?us-ascii?Q?camuqI+0FlipdlIMGnaWUML28nq4MpUNIV3PieETKiCBlWp23IEIyR0yqUs/?=
 =?us-ascii?Q?iFcUqrR1pahJeH4mp65xGASDyvhh4bQMSBdFxtNXfrKNnGY/2etng+cCiD83?=
 =?us-ascii?Q?iCkb/95i4/QqpQyO9OcfwyvpfCSxhAYsVAv5Sl6yajgX2SY145jM6Q0i1kJV?=
 =?us-ascii?Q?Ew7TFE4GZH2cpKjGJTZ0n19j9d91M0bPuXsx0UoaBvkKbi69YWJqLkFs3sId?=
 =?us-ascii?Q?0Zvl2e+WCkCFlz5rXgcoxM76ovIKTVNr22sFzaICzV8eOMcT30zfBQGH9jsd?=
 =?us-ascii?Q?/kF+k19HH9AJr+5Eb48Er6qvprnHNBgbQ5nYz9wEwSVSNjvnRxZ6l7BHofpA?=
 =?us-ascii?Q?kkJSNd97QSPPKXuh8KwwcmFUtfJeJfXeEnnf4ZVkj+cfGwfuxGNWUPmmM47s?=
 =?us-ascii?Q?3A0Yasz+6kqWHMQtgXpoVUqgzdwj9rX5fDpylQX+EoAxkplQfpmM+KJZtE2c?=
 =?us-ascii?Q?G+2P+q8KRhlyLDj0JHj8QOJTlHAn3JMAVhk/l3Qni1R8rS2f8irkFxWfjKOw?=
 =?us-ascii?Q?cJFAJPz1wUrZdCct6swKIl7prRQWjmEr8NYQRRvGQOWhSilRDf36o+mucrnT?=
 =?us-ascii?Q?1rTekshbrcnt+qhzsVWH0uET9CNkzIBVVC2xhk6NjUVPOH/265smtdR4gbN9?=
 =?us-ascii?Q?ng=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e9475f6-38d0-4f77-999d-08dd7b19f84e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR13MB5545.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 06:02:43.0288 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9cLd/R1QtOS/SGBacXc0aYdurpEsInoAcPS+7vdzsuJ+v8lJqCWHwfU584cuIWv96SFHtvdT/aD4lLBSZfLphkMEB8iDQQyUEJm70mZG+zA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR13MB5123
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

This patch series fix one coredump problem and one data over flow
problem.

Long Wu (2):
  net/nfp: fix flow rule free problem
  net/nfp: fix control message over flow problem

 drivers/net/nfp/nfp_net_cmsg.c | 3 ++-
 drivers/net/nfp/nfp_net_flow.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

-- 
2.43.5

