Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D07BFF8861
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Apr 2026 10:58:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CB0134064F;
	Mon, 27 Apr 2026 12:58:11 +0200 (CEST)
Received: from TYDPR03CU002.outbound.protection.outlook.com
 (mail-japaneastazon11023130.outbound.protection.outlook.com [52.101.127.130])
 by mails.dpdk.org (Postfix) with ESMTP id BD1CD402B2;
 Mon, 27 Apr 2026 12:58:10 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZDVNv84qE4Xy5ZNnAPVLxpa4/lEJQCnVhcF8MxH1immLfduY0S+hsPTrKZ3IUrUmZVSMDs7O+IbLbvQbC43Eo15INoQKnL4padok46ZgdEMR02cRmHYJ2JEdq9VnMYOefiCoINjz0wB/gFxUax7Bns0VUU+YPO6tlts1aQGYq3RLfGikYTX04iEPowYmKHXWsrbeGZ8ukbTtKLue8YOqTUTvcmagpDCrWhksBln6GOvjoIt8XGr098qB6gLRpoFqrZOLT1PX0CdJd/N1MA5AObKXLKk+MPEItASl6zuSYHpzLQfEKlgyZZaPc439TW7n5Ele43YMns7DEIb3ZX8A3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bNFyDwVhPMmrjEgkLcgCObIhBtBBwW+ZnFcP47SHHYU=;
 b=sT2PSmiAOKNHK747fVqKTahs3YO1bFtxP6scP5KuB22kZw5aUC3KWe1B9UXP70+W2jo4I6cubtUtfUIDmdZrTiLCo7KVKUQyY1en9FbwdAQIE9xvJjRqlfpbs83oOuXZUCxRhcNu4a2jpz0HEovowtDJR9KH7Imn6oKJh6Jm7VbRJg5yUDtLM0PCU4wHC3GKoKaH9xXRo/dU0JKFOgbXoiyMMZebX5ZFeoMo1Ytw3m3Mu+gW1AbkPebbnoeFULzN2s2mk+SfZLAGb3R0syarYJSUDtNAbPrzRcAsVALH7dUmhUk7XtmOmqCZfgL83Imdmnj3G0tVnoSUKr6DtCdjmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bNFyDwVhPMmrjEgkLcgCObIhBtBBwW+ZnFcP47SHHYU=;
 b=d2h35VokP07Wto1+DVqQ5BjWZXqFO8Pz1lgtz73VYYHdCBIWUWYpKIo4s+E3OJpA5jVt3iBBRMA55hX9aSiM9eAKl2d3kPvEFQJ5H8p6/SXBr+cu759ux+Pw9pMzC0S3c3SwDpMMQXXS/7yNVjf2NIhoZnRuImDs1QKzdZQW2L5zIC4l5lbOOoZl2ldgOz4KPBpNqU6jhWg9MLI/1d5nmWeVP1SU9+LyJ4cT2DxhrFS34JkitI1sIuPhs0PjMqOwdBUddeO0D+R2iB+cOSGGjES6KBObMhC5rmU2RkjgLYA+82YKbYVYvDDg5shCkrJEBCLkR6WXy05Gr29rj0MxuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from KL1PR0601MB5567.apcprd06.prod.outlook.com
 (2603:1096:820:c5::14) by SEYPR06MB5352.apcprd06.prod.outlook.com
 (2603:1096:101:68::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 10:58:07 +0000
Received: from KL1PR0601MB5567.apcprd06.prod.outlook.com
 ([fe80::5d45:e82a:e0bd:49f5]) by KL1PR0601MB5567.apcprd06.prod.outlook.com
 ([fe80::5d45:e82a:e0bd:49f5%5]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 10:58:07 +0000
From: Sunyang Wu <sunyang.wu@jaguarmicro.com>
To: dev@dpdk.org
Cc: aman.deep.singh@intel.com,
	bruce.richardson@intel.com,
	stable@dpdk.org
Subject: [PATCH v2] app/testpmd: avoid cmdline use-after-free on SIGINT
Date: Mon, 27 Apr 2026 18:57:41 +0800
Message-Id: <20260427105741.14348-1-sunyang.wu@jaguarmicro.com>
X-Mailer: git-send-email 2.19.0.rc0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0001.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::12) To KL1PR0601MB5567.apcprd06.prod.outlook.com
 (2603:1096:820:c5::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB5567:EE_|SEYPR06MB5352:EE_
X-MS-Office365-Filtering-Correlation-Id: 54848044-a3f0-495f-dc03-08dea44bdcf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|56012099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: V+WzB58Wzcq60SV5XufPJDL43YRHR73Z2TkGv0h2RSdAEwpkb2/dbkL2WDexb6kL2tuIFCkm192QvsSu+TQZ+MVO/alwSyycYL26DiubAir5e9vFIgvwVogkW5gARi2QamLIqdoiDPeMhztmYBWi7orMjeXTAChZpXEHdUUeU5UNJx/6KSq/sx+poIeYqxdxeqZ54/kjEZUtsdHZdaf6r23oLPlNNxtuPvGIaXej2t8uiL0KO5XefnxiQ7SUCSKM54nKsPZsUNJFGoAXugwcm3kHTW7yKJZ+DEK6RzOsTztRyvVYknyV7orq//bEmujmJPQKHJLvl9/XsarsGpSRiWjYJVXVSDMx5Vc2w516MATnMM7shFJfrEtwuxWRrIYFRmIYqmmCET8FoijXxRZQFJZ9he98ruu9MiOk1yexPizOb4L6+ILPBOLvEpUpMSEVXp2zFd1AUqdtK8rzpj18cMbVZYJY6iCHd7stYaA+5dH0mrAyezTYV+rt1J1DlGmlwl0cjEwFEbQMGjDEFcHK1YS4RtNvlAlaOWTfT1JCZ4hFLpBllgfLeRDX5l6By0fsYW1V1n38AyE6MhKNrj4dZu8js63YCOud/GDwHIVNeAYNvpsmrEEEOijS83I2Ggl+F94cZX3ukU0AjeVQ2U16oLmhq744Zd8V3poyuSjNBsyRmIundnpPq+JbQexkGieX3ZYWXBCdORksk2UGaiGKeiipSLTyune1PNCwbxJCK8gJbPC2iPd/HT3/3VbSyjzxWaGBsTvh706zc8jU2OlEnX/SgVIrFM5VXT39Na8Uc1M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR0601MB5567.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(56012099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hTTmmrberxRBrAyjYCaD1awK02IDxZsvgVS4FTEEoQE0A7YUJCxxV5G+jiwM?=
 =?us-ascii?Q?IMlQZb5/nk/bVuHMb13AelVLppEV9BGub/5+WmLXB5jpEjKQSgRqBEd4Bo4Z?=
 =?us-ascii?Q?hmgbaHO8+oVN0BZKy/T5l41jVcqTQzRPY5PEDP6BDBjXcAzGFDlMbFm4bMCl?=
 =?us-ascii?Q?x+uzQmKav59IbDZMyItOgrwN9OIGQzategvwPkvyr7X4hNlB2EvRAOvvT0sr?=
 =?us-ascii?Q?OOpPXVs0XMLxAyWm8qOFdb0wVUARejO8mjqhrIDzTf7PZYC3njngDwDbYmml?=
 =?us-ascii?Q?Fa3E/nLsOL/VFXe6BNPZ35JNue4EspVs/IZmItkqjh5ExOH7sRNR1YNLkasX?=
 =?us-ascii?Q?FL2tg1r6LBCpc40A8r/3nk/6APwG22QIwFDsWewQeKOROLJh1T72chtNMexA?=
 =?us-ascii?Q?DX3bE73KG9GCP2MXqFOL8DnSbCXEpVkJ4dX2v6Tm6hS9SuJOpl/nJUHmZvof?=
 =?us-ascii?Q?kIbg7mxqHVj2jdZSrUNUt5WBsOGZC2ZInnHmJluR2zToClgJOCtsPr+7aY+v?=
 =?us-ascii?Q?XZ3NQoPCFx1qG7q1pLs1UMh53W6EUfuICtjGRWVMOPRJTPe6KvuycRBXINkT?=
 =?us-ascii?Q?wz18MbebYO0CsPj+uaT7lgl6w403YQdnYblI7J3UrJCYjZrnBpMdgw0QEHn3?=
 =?us-ascii?Q?QUy47OKubiKxeyYTDC5TTTCxHmGPwz7QItdQ9cKtpqcX7wiVOWvVr3fiU1TG?=
 =?us-ascii?Q?t8iE02YIutEVPJlG8hu7Qqixq5NvtjLhQp2oAuSq1b9mUa/gN+FdbePDkLhH?=
 =?us-ascii?Q?zF3WixldSNohrr0xjGmjBwlXbD6mLl4BZb7PnPgGsuVYxI+R6X+GMBUEGIH7?=
 =?us-ascii?Q?xdPUGC8ltEiqNuMo2DJ2gswsPWi/XyvxHhik4EaAl3C7eHqhICBfQAxRP2Qu?=
 =?us-ascii?Q?ypFye4g+Z1PGDWs2ayxn6b804CJY2V3LAF4KoMYoD7ihZFRv7pl9QgQflJJD?=
 =?us-ascii?Q?lWM+iyiXwR++LeepqgruU2IEoEWUUeD0DGHGoDN2I6anGTG9zKsqS2490o77?=
 =?us-ascii?Q?BTW9RFfqtKRr9dnsuPUa8BjL1/T2fmqLZwsu7BXHIozafuaSDi0wXpsLJ4+4?=
 =?us-ascii?Q?gVNCLObUi7VxJJECmbXLpAJDRFJmTDLYL5FAtYkNa08w070z4OCbRJEjj8XC?=
 =?us-ascii?Q?e/OegaBehIS//ujrMixK5G7DvcRGAwdLf9M8HKDn1f2MgUK9N4nM7J1KfkJ6?=
 =?us-ascii?Q?r+V/MBG6e/PK/eHdDkLsIRFQqhXtfkmsk/b5TlQAaMi8/gZk1h2+LGvdtydM?=
 =?us-ascii?Q?S89pkYzyKvwrLXjr62Ia2v/DPjkZIRRdB5Cso6ZApQh2rmI12Ipf20xas1Bv?=
 =?us-ascii?Q?ewSaI+DB0G3Dt+me3lG0cSyfMPnOkiEhmT6UiWxFXmwpoWcitkusMlLdqwEK?=
 =?us-ascii?Q?xKHJMZ5lhZAC2Zqtxyu+MpSLJmbnQoLgvsTCxSf6Lujs8xtTGfWush4Pmz6q?=
 =?us-ascii?Q?QdyUmfkN/vft0VKLnKnfP4g8ZbMnVkK7hvD0Dqdf8i/MH61YYBaA3h7MOlin?=
 =?us-ascii?Q?mcb4GqGUiXXgvd8ockRl6KHVC/mj5U8mBFf6nq5oy6bOYUHS7Ewi659X7/n2?=
 =?us-ascii?Q?YHBn0UzMEZxRH0sG8vzhOJqOI4aoG76DeT+w+3G45iLsu49vOMefuhb8MpuZ?=
 =?us-ascii?Q?+chKsuczRc6JxSMY+INU6n8Z21ZRT1oWWNQQ16/nhWQxtWjI26pazWh6LMe7?=
 =?us-ascii?Q?FmJUrv4cVLjqN48pA0jRTlPwMabFGz4c8V1/JoydtorNhibABaTxmYUqMTFa?=
 =?us-ascii?Q?62EGJK8k2dNgsLHLnFX1JPwge7V62p0=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54848044-a3f0-495f-dc03-08dea44bdcf8
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB5567.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 10:58:07.2257 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iAnzx74AtJ8pPjbglL6HUqsUHKVfLvX7+r/BSx4+cuSNOpjCuttYyll65Nr3m7IsCZuF9kIa52wyLRg9nHtWsQOzJAW/Yuhmd1zbPpLRJ8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5352
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

When testpmd runs in interactive mode, SIGINT is handled by setting
the quit flag and calling prompt_exit() so the cmdline input path can
be interrupted.

However, prompt() frees the cmdline object with cmdline_stdin_exit()
after cmdline_interact() returns, while the global testpmd_cl pointer
may still be observed by a later signal during shutdown. If SIGINT
arrives after the cmdline object is freed, prompt_exit() may call
cmdline_quit() on stale state and trigger a use-after-free.

Keep the existing prompt_exit() behavior so interactive input can
still be cancelled, but move the cmdline object lifetime under a
local pointer and use atomic load/store for testpmd_cl so the signal
path cannot observe freed state.

This preserves the interactive-mode fix introduced for Windows while
avoiding a shutdown-time use-after-free.

Fixes: f1d0993e034e ("app/testpmd: fix interactive mode on Windows")
Cc: stable@dpdk.org

Signed-off-by: Sunyang Wu <sunyang.wu@jaguarmicro.com>
---
 app/test-pmd/cmdline.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index c5abeb5730..bdc5c3e3eb 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -14500,22 +14500,31 @@ cmdline_read_from_file(const char *filename, bool echo)
 void
 prompt_exit(void)
 {
-	cmdline_quit(testpmd_cl);
+	struct cmdline *cl;
+
+	cl = __atomic_load_n(&testpmd_cl, __ATOMIC_ACQUIRE);
+	if (cl != NULL)
+		cmdline_quit(cl);
 }
 
 /* prompt function, called from main on MAIN lcore */
 void
 prompt(void)
 {
-	testpmd_cl = cmdline_stdin_new(main_ctx, "testpmd> ");
-	if (testpmd_cl == NULL) {
+	struct cmdline *cl;
+
+	cl = cmdline_stdin_new(main_ctx, "testpmd> ");
+	if (cl == NULL) {
 		fprintf(stderr,
 			"Failed to create stdin based cmdline context\n");
 		return;
 	}
 
-	cmdline_interact(testpmd_cl);
-	cmdline_stdin_exit(testpmd_cl);
+	__atomic_store_n(&testpmd_cl, cl, __ATOMIC_RELEASE);
+	cmdline_interact(cl);
+	/* Clear global pointer before freeing cmdline object. */
+	__atomic_store_n(&testpmd_cl, NULL, __ATOMIC_RELEASE);
+	cmdline_stdin_exit(cl);
 }
 
 void
-- 
2.19.0.rc0.windows.1

