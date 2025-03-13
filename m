Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0DDC282EC
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Mar 2025 06:19:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 34BCF40DFD;
	Thu, 13 Mar 2025 07:19:15 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2084.outbound.protection.outlook.com [40.107.20.84])
 by mails.dpdk.org (Postfix) with ESMTP id 0B64C40B94;
 Thu, 13 Mar 2025 07:19:14 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W65SqoovHMjJDifJKg0OQHS5E4LMEMKQmzBB9R1gkJumZDplpUXtXHD8hqNzXI4k0mzvGa0mghQ/f5iLfhVr0IfJ8kUllvzdLa8tY8pgdXcpwq9zBJfttLIZ6/77Jm9tUxOMIwLmBJZHWNihNuke9BXSrL/LqZPXml3JQH7dVPu0RMZ2VkDMkbU/A07XneUl4S65ruCVXvENZPp5XoCacxpKLHMVV1zxhmD4OFBYSZMEHO7tTFDiF3P7eD0bGsWaFv+BSNplE3zu333da7Sr31xxdDJWLwpsMO/D+jTKwTuiepwHMcG5cSbcgVY5VRSDtd/b9Q1HH+MdbcRXzGYONQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=atnAZ5ANgdeuD72qG2Bq3TNbJhdQ6SyzR7Cdkyq0AlE=;
 b=a4UxuKFo9jZY2a5vh+TAXEhIJUPhauX+gIin1HHVl4I0nlCPMfu88eSgtgfCYsHM0N0sPMV/lC9TJ7haYDDgSluiUBhGh2fbxXXilwJoXdD9JnWX0v7WL+PMkyJ5icMzeXwdfoVr6VorObNBIV1nIl1xIt3pZ9ZtEH+b27BflQHCAcue5sBhV2vgtUH8Es9h5cqqViGIMV+oy9wkKtOmiEq3p8CLC7ZEtI4UfCt8zGWmrmh6cF7TlazmSEnnH7/6xnersQeb3giVz/hkEyFlpsquSd8jaKB4VoSbGt2FdfgpKs+Fp4Xqjj7CJ+Y4cOIq/W2C/SrlmLXNcekytNiLvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-sbell.com; dmarc=pass action=none
 header.from=nokia-sbell.com; dkim=pass header.d=nokia-sbell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-sbell.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=atnAZ5ANgdeuD72qG2Bq3TNbJhdQ6SyzR7Cdkyq0AlE=;
 b=ob6yJVUVYbLMqFxvkrUa1aSsk1rm0Q+HuPwHKRARjOGaqoxJ3Y1kQNX8b5xBaK95I7Q1FfLnG2bU4owrcTCONs35wgTZtl8opq9//icybPRL1ZNweR4ODsq/Z1R+StlXGL2J3CxwEkgKUjjBm9OXRoMuHK4jJzVE435bw+bphsReSxGrgFsgnSGSpMu8xr1BHJ1bNdPAWH6RM8+WUoncyFk9/97plWzHXpHVIdqroiaX5/qenqcxwyjWeMjYiIYiDPv4/LNVoPAWX/+Fy9twQ0a9h0X7wmRMerEyhZ7jzL6aII7QGcyMecggpvOTZSZAvjM76pVlTGekLdrFqKCiOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-sbell.com;
Received: from VI1PR07MB9898.eurprd07.prod.outlook.com (2603:10a6:800:119::6)
 by AS2PR07MB9099.eurprd07.prod.outlook.com (2603:10a6:20b:55a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Thu, 13 Mar
 2025 06:19:12 +0000
Received: from VI1PR07MB9898.eurprd07.prod.outlook.com
 ([fe80::1928:4afb:4eee:1f21]) by VI1PR07MB9898.eurprd07.prod.outlook.com
 ([fe80::1928:4afb:4eee:1f21%6]) with mapi id 15.20.8534.027; Thu, 13 Mar 2025
 06:19:12 +0000
From: Yang Ming <ming.1.yang@nokia-sbell.com>
To: dev@dpdk.org
Cc: Yang Ming <ming.1.yang@nokia-sbell.com>,
	stable@dpdk.org
Subject: [PATCH v2] eal/linux: improve ASLR check
Date: Thu, 13 Mar 2025 14:19:03 +0800
Message-Id: <20250313061904.1466-1-ming.1.yang@nokia-sbell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250228094405.1437-1-ming.1.yang@nokia-sbell.com>
References: <20250228094405.1437-1-ming.1.yang@nokia-sbell.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::34)
 To VI1PR07MB9898.eurprd07.prod.outlook.com
 (2603:10a6:800:119::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR07MB9898:EE_|AS2PR07MB9099:EE_
X-MS-Office365-Filtering-Correlation-Id: 46baab13-54ae-4be9-82e9-08dd61f6f8ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UNUdIrZam0dh9j4TgggK1ky25NL0yFPgkaBOwJih9x88CR28ViX8gJ13vHQG?=
 =?us-ascii?Q?KUZRo1irxxVecmFolME8bsA0bBqcy2dx5me2Ay37nhhex1BSRKAgPjw3rWDg?=
 =?us-ascii?Q?qJkuYAKj/7AePt5Fhq33HtkJ3Umu8TrzehFduzI7NnmyLM4X/Yv3rgnftYDV?=
 =?us-ascii?Q?Qh2yifS5D07YOLNpc5NcmkUVc7/Xq9xgb80SP1bOW6bdhJ4CutLWJzsTq1jf?=
 =?us-ascii?Q?7EKSaxrkrfYle9l6OxEIUe+6kid57o1GLvoJ5N7DCTTwbE/qQHLkUHcwWU0X?=
 =?us-ascii?Q?KWN2y34Q6kF/tebnz7irvnoZaq+g7c9nZSqfErEHTIG1JQ95iF+WaYjUGkav?=
 =?us-ascii?Q?j8dP7MH0iRASrydrfOE6X2Ult1Eg8E7j51QpCN6ZWZ1XDIVnENOKZJXCW5Kg?=
 =?us-ascii?Q?nk3Bxxto/jfJBsUCuclIQrC8XJ51E8UJtIO5hC/k6B8ZOo/sRexIn0pSLT5N?=
 =?us-ascii?Q?qF1hfH+CSa6YwScSPFucibAli1rKcU4qxKXhkouutvuJ9TWzFiiAlYopREBl?=
 =?us-ascii?Q?2qLwWdiY7DThlEzvQieWhTvvqzkOWzD7k4ZS2Tnw4YocNYxhLMDGZtc8Z9ot?=
 =?us-ascii?Q?QQ4DDzDBsVgxUOm9Yk5TJ+QU5zGMvY84oOnAx0c3t/k7ZCpn962B3rqpkK14?=
 =?us-ascii?Q?FzlfZSFVdP1RUZwOU0BIOfa0qDO09CAYZGDCTxY1mk5iEdc/W8A6tvPj3sWZ?=
 =?us-ascii?Q?8LQqdVgN54XZm/rVvIa1GywDP8oQ6+gi0aodfJ4gR5E5T2f6fIMBlzaPg0Bx?=
 =?us-ascii?Q?vlraMlZO3T5GSoBvPu+KjsW7ZoeZpykdZnQUuYQmAMJ4wotgkWlflXyFUehx?=
 =?us-ascii?Q?Gk2dkLpYvxLzc1mpL6D4YN0PQARtBBXcaPZ5aYG8co99OQgPoQoanAoYdWc2?=
 =?us-ascii?Q?gjhNVgABlEwvyOS9qlTcMCdCWo0h5pUaCZGgzylPb4OAxEyumTLbMoIHpz+Q?=
 =?us-ascii?Q?TheO6tQztjBellgLIr+GTSkkkl4AS2hXwsPwiiU3VUxOWLASNGQQjOe7g6Rq?=
 =?us-ascii?Q?kfXPT3dmrS2g88eak/1DFH1QoxRe/Z6DzEgnf2fjVKNp74JuElMD7aUMjtM/?=
 =?us-ascii?Q?sMQeDMM9RhF42CifSHw44UNEApbUfvADqUjJAEjqTwy0GpQ5ujOb3oYwOaPv?=
 =?us-ascii?Q?4TzSGVVymEOfV5bZIlcDof9f9t4jNGY7rWK9gpQAn2vsx/2L2a0ygzDqPJol?=
 =?us-ascii?Q?VVUcT2wc5zS8Q2vhU8eed2pNtfs1Lt4J/Z/ZjEd/o3UBNG4gO8IYeDIj2K7A?=
 =?us-ascii?Q?n1XY9LlIJ/BWD+Xo7PJAJ8Btqkw8J9CPIb2uAduVJmNK1dK0lDhHq5sNRoNt?=
 =?us-ascii?Q?LTxdSARXubx42U0TciNshTohas7nJgA83nvL9hhMH1CiuDjWSMKgsLLptg7o?=
 =?us-ascii?Q?bX+JOpQdtnAXdkv/12/iUXeKNA9c?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR07MB9898.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IV9LqTkI5W+Z4WfEW3DVTEgpF9bT9e2vOOrRVCBxPexxpINbLVzMu2mhVT+U?=
 =?us-ascii?Q?B6RPWT7GbK1nPGc3ZPiNfPT1BqNrLPluSqmjmSOa38jbZ8aOUNRlM6IxSsDK?=
 =?us-ascii?Q?37kc1lQFwqXr54p30MYxvYskK18HwU14Cmgr/IQ1cjHAEjCjQwUOOIQ3327Y?=
 =?us-ascii?Q?Ek+9lBeRIrl+J+LkEZ9Q/ax8XDpivorhHkllcK58L9xyD61MuJiru/lAZMKA?=
 =?us-ascii?Q?H0smpNKWWi2MjMacFMXAsiZsNxs7k6Q5CoMWKknvUMDCRtxjHk02ST4uf2Kb?=
 =?us-ascii?Q?xgr+ddBRbiwfl/o8DH4VKboaBpR3cknzN9HU/+OiRtXU8GEnksP63M0NgIV6?=
 =?us-ascii?Q?7STg66zPl8EJhK+JZ7Q6Dp5ePtOrSFUafbXgMn0TDMOGLyzXjWVZfOC/cZyb?=
 =?us-ascii?Q?dKdNac/f5YkYKiwMG2oltWELFxfPVFGk+j0i7Yi3Sn3L/nzEhUTRiiCs/FwP?=
 =?us-ascii?Q?6p8AF4r364eBE471vRofw/XMhtC1bIe+MX+j7myYgLZ/n1ECprIW1CFAIN8t?=
 =?us-ascii?Q?UIJz8afW/Kj8U7kTNipyCRRsfZWXvpXe5LX8LuLwdpGJXyVFKnPgcFusT75F?=
 =?us-ascii?Q?HELpOvlhMmklMBFEm9jIYswQTU9S6SoQC0OUqb2xWCieKZXyLW/ZOU1DK9Bq?=
 =?us-ascii?Q?h3sb8Y1h5f0LvQrME0/9eCGbVbTP346jpOC6djL2B45cb4KY40gP9yHCzpNT?=
 =?us-ascii?Q?h6YSIwtVkLpRveH5Pqos1IUEQ4cCrHUCjVRZPOnbS4cdGSCba+5cP9gcrscH?=
 =?us-ascii?Q?e3ZUzrQsLOzVfCAkUhdO8Xp3jMsjputRQg1dOxwFUH18y1MxSpVOJuciZ35N?=
 =?us-ascii?Q?uyZe76s6F5GIv0AC5j8YU92z6E8eJL+wlqxOnqMECy/VeMol3DvkUfTyBQ/i?=
 =?us-ascii?Q?so6t2971JkrGKud9VFzkYMkHcvEuHcz51/IgAt6FccJXirJqpoe7LdTFHuj/?=
 =?us-ascii?Q?X3oykoLBrGme4tXOQlSS1pbK7DYjsSAfS6ystw5DQ9epeNQzM+J12TQ7pKet?=
 =?us-ascii?Q?VTiHpH/DfMsKB76EhwseB0zpug/RTH9x0ssoTxO9pZUBdRxCSLaDhxCRJHEg?=
 =?us-ascii?Q?ohmYLrI9OapLGHA+nvmgEuoscFE4aHqkQFUd+ADvNMV1mrAqyBS1eT0HBRNC?=
 =?us-ascii?Q?/e/PoeoIbFRevLop+xhMrLAvPU/HenYD82d/heEJItAySdPmpVcYxc8E4NAL?=
 =?us-ascii?Q?8SZH/IDdg9D3b2mi812KnpewN1roGUNduuWktT/paq+z5uk9LumeHukFS+zD?=
 =?us-ascii?Q?+TrhWG97RIFpUnHIoJ4U9D+FwsvK+Y57rzTvPo2fbpnCb3novC6egIl+rGGA?=
 =?us-ascii?Q?BPxaeame/MeTdhO3tVv4NUBHxLpn3F/w4T547g4KfxeN36A6Qcn5P7nsjC5F?=
 =?us-ascii?Q?GNjJcHMcgA41sxWhT1MNI9/SPAjC/XaGSYG9lEMvUs0A6/BH7gBNENQtcrnG?=
 =?us-ascii?Q?NAa4IuFzhj4dc7q+7VEaD16yX/5SouQaXMfp5kmFsYyFt97IJStwKEN/Mom/?=
 =?us-ascii?Q?rRr6Xeo6qUe/pBVd2noZG5wseInUs3sJ5NE9w0tAuTBB/HSE2L38x6mfym8d?=
 =?us-ascii?Q?u7CCp4QvccMNYUky3GqeEoPKiRwtRZoog/W0IE0lIGiRN6cIqrDtdKyw+LKp?=
 =?us-ascii?Q?8g=3D=3D?=
X-OriginatorOrg: nokia-sbell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46baab13-54ae-4be9-82e9-08dd61f6f8ce
X-MS-Exchange-CrossTenant-AuthSource: VI1PR07MB9898.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 06:19:12.1879 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3kfhW2OaY53OqpEX/Vl8MXz+VZPYJ+3yPbdHUFSXRUCdd4IY236UvyjI5ClTOPgGi4DuvfxQdqJNFNSq0XjxKs3yUDWDphgrHhErdwLiuo8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR07MB9099
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

This change ensures that the current process is checked for
being run with 'setarch' before verifying the value of
'/proc/sys/kernel/randomize_va_space'. The '-R' or
'--addr-no-randomize' parameter of the 'setarch' command is used
to disable the randomization of the virtual address space.

Fixes: af75078fece3 ("first public release")
Cc: stable@dpdk.org

Signed-off-by: Yang Ming <ming.1.yang@nokia-sbell.com>
---
 lib/eal/linux/eal_memory.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/lib/eal/linux/eal_memory.c b/lib/eal/linux/eal_memory.c
index 9dda60c0e1..5ef1575b66 100644
--- a/lib/eal/linux/eal_memory.c
+++ b/lib/eal/linux/eal_memory.c
@@ -15,6 +15,7 @@
 #include <sys/stat.h>
 #include <sys/file.h>
 #include <sys/resource.h>
+#include <sys/personality.h>
 #include <unistd.h>
 #include <limits.h>
 #include <signal.h>
@@ -200,6 +201,17 @@ static int
 aslr_enabled(void)
 {
 	char c;
+
+	/*
+	 * Check whether the current process is executed with the command line
+	 * "setarch ... --addr-no-randomize ..." or "setarch ... -R ..."
+	 * This complements the sysfs check to ensure comprehensive ASLR status detection.
+	 * This check is necessary to support the functionality of the "setarch" command,
+	 * which can disable ASLR by setting the ADDR_NO_RANDOMIZE personality flag.
+	 */
+	if ((personality(0xffffffff) & ADDR_NO_RANDOMIZE) == ADDR_NO_RANDOMIZE)
+		return 0;
+
 	int retval, fd = open(RANDOMIZE_VA_SPACE_FILE, O_RDONLY);
 	if (fd < 0)
 		return -errno;
-- 
2.34.1

