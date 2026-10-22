Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78531606A319
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 12:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.a=rsa-sha256 header.s=selector2 header.b=HLU/Nndo
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B7CCC40264;
	Thu, 22 Oct 2026 14:24:05 +0200 (CEST)
Received: from OS8PR02CU002.outbound.protection.outlook.com
 (mail-japanwestazon11022143.outbound.protection.outlook.com [40.107.75.143])
 by mails.dpdk.org (Postfix) with ESMTP id 528C44003C;
 Thu, 22 Oct 2026 14:24:03 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iylMRYQkXLJ68UzUe/2PYBXgrjDQZ35Vh7fazXPOCaxHXaAXG0jdmxeVCNEsr1RrCAX/JfvUWUYx8utovjKsZCGkopGlflBqemSMGGWysNELLt6z8jVx4lEwDfa4tbOU2S5NtUH2XVncBpGYTi2UuFLPfU/HOOsYLjlvN0OLroZo7vmMvHjx4FBNjs+ttIj+3s1H31cA3Gy6X9WUcBJz1XfD7QXtrN0pvOo6S/1/K4oFcNQN4guOfM6WlqDyJqFYoxk4Ab3zRU4d4PHdiMn8awqPz2+fZr2qTLMQS17zzxj5cO3i/imHUijTor7r6BpzbEo20IZJNFh9R0+8gunqoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y+e2+BmAk1w9DDnIpGY+SphIVkuHGM+wmqM3TWPPrJo=;
 b=aqLTSj+BnYNJCL6kV2bMuM1XPDlGrT9mqHK3g/7pxMCaL8lDGN4o3mn10l/+kQWJmaVi2TbeD8ITzZF7BA74xJFtMepLtlysLK7nsfWt3k/g5dBWOGcXc1IlkvVnGj7mfTzDxCjZ3ThVmE14p+Y14lJzWlWDgE3AhiK4r+mlwJPKl25n6tqiZVh+cBKQVeHUqgiA+3ike9Xltg4YlDCSWyer+K+4Ur6ndloHUoCisDfMBQ+ZKYTXBMMr00AmqJP2dLGRK5s3VShHelh/28jprPrNOTP1Gsmi67ebxOFsXRs5jUqGOpQy9XT4sbgqJsjOIlOzefhrXDqyv9xDAEPpIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+e2+BmAk1w9DDnIpGY+SphIVkuHGM+wmqM3TWPPrJo=;
 b=HLU/Nndoy1TDSxp8lNLwvO+gNy7gwxlx+U7pSA42CP00w8HxdxAgzTaInhifnCTRCM2aeU3cb9FS2SNjRoK7wtpooAuxB9qJ0SysAYWoEVnBbLB8O3S2PVuzmzjU+MiT5RC0B/EFMDGYBB6/GrlIFqot0W3YTB2St59wR6UtwskW+fY9hdPY4Mlh3JQIiYcfzmaXmySRFVuCw5VItWc3qIPQcka9ZCNERVVARJwWRzDlAVbZwxmwiIKwvbCQQTIdPjxT8ZsKRv11DXCIa72hXrkBrQKXGfGaEfAONfPoRcncC1+OGKrKe9hg2lDDVZ4geD/C3M1MKQj7jfGQaf6xng==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from TYZPR06MB7170.apcprd06.prod.outlook.com (2603:1096:405:b4::8)
 by JH0PR06MB7082.apcprd06.prod.outlook.com (2603:1096:990:68::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.2; Thu, 22 Oct
 2026 12:23:58 +0000
Received: from TYZPR06MB7170.apcprd06.prod.outlook.com
 ([fe80::387e:d733:9980:3c98]) by TYZPR06MB7170.apcprd06.prod.outlook.com
 ([fe80::387e:d733:9980:3c98%3]) with mapi id 15.21.0569.000; Thu, 22 Oct 2026
 12:23:58 +0000
From: Wei Chen <allen.chen@jaguarmicro.com>
To: dev@dpdk.org
Cc: cristian.dumitrescu@intel.com,
	stable@dpdk.org
Subject: [PATCH] cfgfile: fix isspace() undefined behavior
Date: Thu, 22 Oct 2026 20:23:48 +0800
Message-Id: <20261022122348.3467-1-allen.chen@jaguarmicro.com>
X-Mailer: git-send-email 2.33.0.windows.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0030.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::15) To TYZPR06MB7170.apcprd06.prod.outlook.com
 (2603:1096:405:b4::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB7170:EE_|JH0PR06MB7082:EE_
X-MS-Office365-Filtering-Correlation-Id: d4e5f399-0180-451c-88e3-08df303758d3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|52116014|1800799024|366016|38350700014|261021121427099003|56012099006|5023799004|261009223027099003|10067099003|261021123027099003|55112099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: Lr7ZSDY3jS5e7Y/v7P5FgAIdb+ojd4U0nOMk7DBXoyjJ9iyjxfa5Z9ivkZkm/0CnQdnywY5YBloQJaeYCS1tEVV1YegItRhOtCzmPibli4sNEq9XHpUNj9ciTJMVlUi3JvD3xqX+F7uFmuCx5X4Tt0nh/MIFGeVXZvW0FCZj/xeEBOvgfiahwuXJioXFxeEDBTErhYvats4SlRD6bp0ucOiabQpnYzwHnQnduImQfoxJNb7Qw99XqfyiqcgNu5P2UysbPNqsWbqx0ZSiJjDIFCC1FJATiY5hx50C9MrNr0mUiOxTuLeq9wUcqA1vKdrmWFFqVxRJjccJkoG4N7hWjwrAbR7P6IsA1HjRyTWbEG4kNUOiUnusts4WKWNjjyW5Uux0XzBR6ubqn0HUjnkcuvubrSIrmLcjDBZeCPTcUCpVCoX8p0tX+NDS3fM05aIhp3F7crnPBNZifZAqH5H+koawTHCCsBNejDNQSsyLv/fvWcgoz+A8hOOK7FLj4KCcQCwUHh9BO+0Dj3uTfsY6+jCoKmsTmdFuoKKIY/7Km1SD4damqoHothEPCBDtYf7TsXW2VijWf6lxaAjhJFGG/YtKOQ+7U+1Dj9HL2SYVaWiUIt8/ctO6TJfl7m8Kf4TpRuF0IIou54NQ7R5QnXiAHxdb72yG3C1nkRP4TWpopAN4lFgXVR8Yk11abZHhzTirtCeqp11pR+47oVqBs86x0N/8AS/t8Ebx0Dce65OWEYI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB7170.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(52116014)(1800799024)(366016)(38350700014)(261021121427099003)(56012099006)(5023799004)(261009223027099003)(10067099003)(261021123027099003)(55112099003)(6133799003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G7xYvnvV6y2AH/Mz3rgrUNTwGbqM+sFJy33FTdgmkkC6Dg06WeLAXfjLc51n?=
 =?us-ascii?Q?eJo1GZMxVgjaaiyBcX25TZmTmfOMhhRSOA1HIa7tWpjr7AgrbP0Qv3IN2pMu?=
 =?us-ascii?Q?dsjdiAq3QekQVhNdlNFb82Q2PeOUQmja1ZWCYRquOwclMVVwwEcgdEX1yuZU?=
 =?us-ascii?Q?rdvoxgqSQVPrd/S8fNxccTWp95zxYn1TIX4UuURoY2LapgG24Iu7YhCLJd3M?=
 =?us-ascii?Q?s0oKz3kuIMvg/d7rYTU0Euf+miIJ3q7OPWYsETHoFWEHBYqB1YA6jQ1jizG/?=
 =?us-ascii?Q?Q/a5P9LuK2nICOWj8GJzo/27oCOvApZ9klY+tX8YiUhCnOXi/2dskAzD5IiR?=
 =?us-ascii?Q?I4WX7Z6q968ja+KMirnnnDv/LvGbo65YT3PtPt9zBNJsY3pg33eC8hcMN/C6?=
 =?us-ascii?Q?fxq6IWpY92gKL8WO8QbyLLrG8/y/YxLypRzve7z9LYLMCbDlp9a5ShMiNS+8?=
 =?us-ascii?Q?Z/jB2GUfbV55VofZsJaTSDsSP51gLqc4VqHcnmg29KzBRIZQt/ItDBXi0eo+?=
 =?us-ascii?Q?hwOw+6lNlv8raS+lWP4XDiJZ4jxX3AJoieEU8WLHEibwcZi6lhrOYTwm92+L?=
 =?us-ascii?Q?qXCl8fbP/0lZ5XURpZqak4X0L3vvAlDThJy6a8OWa/USuiFeHmZFSI+yOeoc?=
 =?us-ascii?Q?ufo8iOw2Um79WgiBZP0sC+i7WdNLGMpqKIIjXR5cwmqGajv9XETwpy0ZJTNE?=
 =?us-ascii?Q?p8BQZPf5WaXQcsbMHtmfoQ9jroPquEP/EpLoOTekNCjSV4d5sCRzt/EnOCDx?=
 =?us-ascii?Q?Hxeb6Wa0svyuqPxhjatHPxsOiCtifu1VvykFEndYRGR7c+Q5R1mw2oPf+yzO?=
 =?us-ascii?Q?DxvsC0D6Ceka73rxy4YAaiP8kP0M1phaEagUfvQ9yPjWuir3URNipVSdd7BE?=
 =?us-ascii?Q?wo9rrlxN0C46SMbhTbmpXsGkq+FWnFeCgiOYFTo42/P6oLkYwFjLlc8vw/nw?=
 =?us-ascii?Q?W1vtuT93bSuIw5CCJ2UdAbnA+CgF+/jzYgcDGrEM6g9P4yLgiDPVl0qzksS9?=
 =?us-ascii?Q?bWDD518nkav/rMPbcxy5hhA5Fn94hy9pat5XJLkXePFMgI4eqr0kv9OoPro9?=
 =?us-ascii?Q?iYhxvJHQCsFGdICeIsdqvmtiVGMVcq/Nw25pWIMBkyGksCaMAw/JphmV9qtF?=
 =?us-ascii?Q?MazePqxroZ+WqEmEpJ+y/g6wAAcpUjvM4HXEOsZHT3HjtIHL1IKdPaNjYF6k?=
 =?us-ascii?Q?FfXVbvia6fFzQos0DYc8866EC3u+Nb/bQLVxxlv/fxfgXQHne5CLNC1BTxTB?=
 =?us-ascii?Q?UfCEEAoKqG0JERLVoRlCKdUzlfIfVquEyik9/wPy1WZapFeZYnomSUeQuU4J?=
 =?us-ascii?Q?/qNrzLtFsXHUthMDb4yL1y5m1j2C7EEvtNGoifuM2KvRyGGakacY4z5V+UD8?=
 =?us-ascii?Q?YU9aJphPWvzCUO8xR4c/V/wvGdVahlyQ50TmEDMthhIHczio2wLnt65sWNv/?=
 =?us-ascii?Q?XlOx3QadbcsSIO7cH1tFEHT0gIo+rXN9Xh3w4gh2qc4rETUw6YzPGbjKorSY?=
 =?us-ascii?Q?aBz5TLlmo3DaoUD884BXywUcUxPeiBQjNhu/hHonDMZFZaYF8R01AnLaxOWx?=
 =?us-ascii?Q?KHQYGZQyr8rKgsaC/i5m0IDMaQHqlsBwFUyLhYGmtYESzfMsX8Aj5iBbcL0Y?=
 =?us-ascii?Q?ySTxPrhpuc0nbNmlhHjOaPUfJBsT36alZupSDmX3Je0HBeH49Nv8rojrAIYB?=
 =?us-ascii?Q?EY8vGhYS6JeFp5LEAIcglnAsFi8p/RHz7uL7scsqsrXGTe2MvWuwDhdtPNXv?=
 =?us-ascii?Q?0rWpFvqe2w=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4e5f399-0180-451c-88e3-08df303758d3
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB7170.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 12:23:58.3698 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zin/tB3likbaojE2+PKUL+POkpshpR+Q/QpbOw7teF0G5ofOslEYKNstA6ZjkXhXG87fZGpcRh70BjJnm1Ja5YjWoh1yaEB2pd3jzg/T+vE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7082
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The _strip() function passes a char directly to isspace(), which is
undefined behavior. The ctype functions require an int argument that is
either an unsigned char value or EOF, but char is signed by default on
x86 and ARM, so any byte >= 0x80 in the input is promoted to a negative
int and indexes the ctype table out of bounds.

Such bytes are reachable from a user-provided config file containing
UTF-8 or other non-ASCII content.

Cast the argument to unsigned char, as is already done in
app/test-bbdev/test_bbdev_vector.c and elsewhere.

Fixes: eaafbad419bf ("cfgfile: library to interpret config files")
Cc: stable@dpdk.org

Signed-off-by: Wei Chen <allen.chen@jaguarmicro.com>
---
 lib/cfgfile/rte_cfgfile.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/cfgfile/rte_cfgfile.c b/lib/cfgfile/rte_cfgfile.c
index 6edd83b5b3..958cec6672 100644
--- a/lib/cfgfile/rte_cfgfile.c
+++ b/lib/cfgfile/rte_cfgfile.c
@@ -97,16 +97,16 @@ _strip(char *str, unsigned len)
 	if (len == 0)
 		return 0;
 
-	if (isspace(str[len-1])) {
+	if (isspace((unsigned char)str[len-1])) {
 		/* strip trailing whitespace */
-		while (newlen > 0 && isspace(str[newlen - 1]))
+		while (newlen > 0 && isspace((unsigned char)str[newlen - 1]))
 			str[--newlen] = '\0';
 	}
 
-	if (isspace(str[0])) {
+	if (isspace((unsigned char)str[0])) {
 		/* strip leading whitespace */
 		int i, start = 1;
-		while (isspace(str[start]) && start < newlen)
+		while (isspace((unsigned char)str[start]) && start < newlen)
 			start++
 			; /* do nothing */
 		newlen -= start;
-- 
2.33.0.windows.2

