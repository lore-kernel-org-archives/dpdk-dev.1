Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C083FF8861
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Apr 2026 11:14:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7398F40611;
	Mon, 27 Apr 2026 13:14:11 +0200 (CEST)
Received: from TYPPR03CU001.outbound.protection.outlook.com
 (mail-japaneastazon11022096.outbound.protection.outlook.com [52.101.126.96])
 by mails.dpdk.org (Postfix) with ESMTP id 33C2B402BC;
 Mon, 27 Apr 2026 13:14:10 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JFvNIXQZFavYVIzQIWJ/q9Ezt6lU0SEmRQbC7mnMN09fie/dkLzS6bTWsaR7ap8vOZYCd42AUNS3DFbAb7xSO/UOAb2rfOka9mrrhLSnj57CWqsaeRPqvwLo1bmKZqFj3fstO1gW217VWxRh89g+2oVGNgFoxIMJiqZaBI+6UMFt0bCHeTA8BJ4oPxab+eIBHik2u8DhvTViPQRz3bGdWFfiXMgfB+/O66v/gg4SLlij/T1xRcSpWaB2L2fSTVU5eli3VEex0E1J0RNyPqnSzSoH9RQoByNCQPpRQoNW/VpTVpPohh7knT/jxA+nKQbeS5pztutX9bmKtqEDVBYW2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQYCo6URqb4I5o2v2cPiBFcB9efdegnCQnlLEkXANOE=;
 b=PaBdg7RZwKAsIH5WU3jsXkheEAIeTB5NZnpjvqieGbC6WdPOttEjl968OzNioRF8sD5o1N6cJbwuBtrMTTBUjFps6WPxIKWg+PYct+rhU/A+WqwX1wDZEplRxgrze6FKhuNbP+VyKXVgHI5lz2QX34iYD1vPJwTl3UNtol346EB+VbeZzdCy449XsA16+xvPjyTBuH23Lx7w3zDdpVzo2Ga/kpMZjl1TtDbXGULsqqoR7uDpGQp17P6poIb1iKs1eQujoYRRPcZpcf7gGpZGF4a6yFI4MuP//Xd1yxCRy9JpoK9W0ysigA+mc/4ofkuwqD9jYtOag3gGsimPoiFZ5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQYCo6URqb4I5o2v2cPiBFcB9efdegnCQnlLEkXANOE=;
 b=qwzXwO8TzmzulVJhOW4QXkVnBb9xglyd/twqdNDqmWFtjegfIz0EkGtXVtclekAQPpBmSacZ5MxhOEyldot0d7jBxLQrW/Kl3ybWCwHLKXtE4/nAs7nlAfGUG3YGykrgtVr8Km/I3taeo9AWGZFtXFgkPTUXiU+oXwEihMoc7mubgrLCxxsTRwr8IEAVjx63NduXdZrDXkWlgjh1qD6IOLKxlVglhgXSWHOWF1dzoYFBBAoOM55bPH0ZpmatQuxcdkzQzE+SefWbjMMFfa9TnEh+B4Y6qeMEAzNSxJ9xlI6NKDuL0dYFCdAOw4m9tsbn9XT4ojxRpc/5IMCazCVvHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from KL1PR0601MB5567.apcprd06.prod.outlook.com
 (2603:1096:820:c5::14) by KUXPR06MB8099.apcprd06.prod.outlook.com
 (2603:1096:d10:54::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 11:14:05 +0000
Received: from KL1PR0601MB5567.apcprd06.prod.outlook.com
 ([fe80::5d45:e82a:e0bd:49f5]) by KL1PR0601MB5567.apcprd06.prod.outlook.com
 ([fe80::5d45:e82a:e0bd:49f5%5]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 11:14:05 +0000
From: Sunyang Wu <sunyang.wu@jaguarmicro.com>
To: dev@dpdk.org
Cc: aman.deep.singh@intel.com,
	bruce.richardson@intel.com,
	stable@dpdk.org
Subject: [PATCH v3] app/testpmd: avoid cmdline use-after-free on SIGINT
Date: Mon, 27 Apr 2026 19:13:47 +0800
Message-Id: <20260427111347.40520-1-sunyang.wu@jaguarmicro.com>
X-Mailer: git-send-email 2.19.0.rc0.windows.1
In-Reply-To: <20260427105741.14348-1-sunyang.wu@jaguarmicro.com>
References: <20260427105741.14348-1-sunyang.wu@jaguarmicro.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0023.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:a::7)
 To KL1PR0601MB5567.apcprd06.prod.outlook.com
 (2603:1096:820:c5::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB5567:EE_|KUXPR06MB8099:EE_
X-MS-Office365-Filtering-Correlation-Id: 618e4e53-e36e-4174-9fc1-08dea44e1803
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|56012099003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: Gf3Xh8NeFtWxWorZdjUaktOQmqmFtMx+AL95BRaPm8KiNxNS/VUwAVQPYmgiI1k9Wzc5kFU5amL/joKUjyJAAZTfHnXmvLj4I/nldGqFDzGHup97+9f0VMzJ3gy2Aq9UUE+AW9w0GYwYStCBwz6WFziEXSy0/73G3Ejt+C3XnGDlQ4vnQG8MQNOR01bJHn1/ovU3rBRBeTBwk4t4npkUXuMaoS6aFhqwOQWU02wNym9T++tBlgd/AiT1IzLhT104PYlfLJIQVLiuZI+wWxtZkrkMYSbbnEuwnMhoGDBR6t+Ij4q6To7wR9Q3YfuQ4YJ9yK+XtucrcemIfOhgksaMm0XNulzZcAVhqLvnfvtD9bL8e6P5xIJMTWlpx4Z6/ejkVNigCq9QMVIyYZUk9b/+c0aLATQp40vqyug02EeQjAqORkbNZ/h7d7oEE7voyhep+I5rApXgSR4qeEZ6wPxh89SyUESOsV8rhZ1Piql2w5KHbH4VIA2DN8d0nQ9kSycUGMhUAAQZ3aGuWdGliLVdzAszet+8YGyMaiNJ1KzbkRLny5elb8amtgNYzjQrE0/wL4OzAlCLeFSPxV+o7fYF8olqkbQ06e5Tu4qbO4AeickdwC82npMwSlw3GCviajUGdrHt5OLxaQ+c3cLm+VXbvQYn8WfoKclF4MsjSWdTCTz2B4LKVoEqOB4oMXD7K41WcXS0jfgVKEflbxnauJ+z4iIj56xxgOFKXQCd7NdYJfIXsuWqACqcwaWTExywKJ8HLG4SvrIoRYGLYqQbndxYv1kxTnO7VW9lr2X34fhG5ho=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR0601MB5567.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(56012099003)(18002099003)(22082099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K/oHIJRFVPyNPrhrpn+lCBOr+YShj2G20uaYfTUjWZntXzUkpxM5jfcsI5M/?=
 =?us-ascii?Q?y+gC94ophwyVIdlPJxe0NcYjBxqlFZMeodUT9NY08+czpsSGUYOw4cszr8n5?=
 =?us-ascii?Q?X/xHwm/JZ8vnDp8cge5UlXnhwGekzNDcBjylqB2AMPi5dDy5A1h+hdrgVAcX?=
 =?us-ascii?Q?YelUTEanSHFFu9AvdjBdm/jI7rh1PzPYDZHA2tlSzgLpEcNatBKcLLYZvtan?=
 =?us-ascii?Q?+iFk5aQ/gPA007df4xHaDoMZn0DbBRc2l8WNlZ8/2poJufyrufx4uZ5LEorm?=
 =?us-ascii?Q?Ak17A/aXkQedEuxBD6v8HuWO+heqcltTj7ADv9JTqXmn+bbkq7yulpYu3BKH?=
 =?us-ascii?Q?zSD/s12Aymq8lUIVfhwcGdNF2wQmTq+sPnfmxDGsQZHtXkxtP5Npq42ZO5DF?=
 =?us-ascii?Q?sJWHfaKMXKRIBGq1XeXUa4JHG83jSSLSg6BrvMslU0DHtRKfqaVUDuhPEW0X?=
 =?us-ascii?Q?wF06rmNwC25X7oevIareHh88+hyh+xaTOht928n0ccqwD2pFbm1dGNtAvTOG?=
 =?us-ascii?Q?hILmfBS6sEN8HJM+Cvps7HajgRbwen9bKlGKzuQR4mp7xs6Xy80XPM+igHyE?=
 =?us-ascii?Q?C/4+p3YC5FnCE/73gbEYiB/F1WjypgnCo7SyvdvyVMhgL2bH+Eg/UQI5m34I?=
 =?us-ascii?Q?hHXlsDjtqPtiUIXniZH7e6kOSgicmSul+6JFp+HYmCe181pBhttSjlFRH0F6?=
 =?us-ascii?Q?fBxXHcMWvh0nmfUhEhsSstzckDfJMgAC+qHO/DoRbL3aavjOOARN13bBfAb1?=
 =?us-ascii?Q?A1uiCvWKcGEuBcKDB/VUtDJdU93Ec8wWeUTho1DvFwFZsl7UGmkr/ZiApS/S?=
 =?us-ascii?Q?lNRoFB5lYAHCcazQlhZlOZr2zqqCWQHZ7FRhD8SRCBKl4w/YjLbIFao77pwz?=
 =?us-ascii?Q?gfIvyp5BsNP6lYop4lVk0PGA9+6TVgMQYdaV95/P2R99LkEMGatUvvngHrNc?=
 =?us-ascii?Q?WCc/luHudZniVZlVG8gEu+iqrRBnaXFlIrOST9O9moubZkqIPROEEPCa6en4?=
 =?us-ascii?Q?K99hTnsPFaZNpU3k2vLYV9itowYObsXw4aYLl5gNTrtplQqgJ+DUaI/NFinu?=
 =?us-ascii?Q?aL3UaijbYDqFAUJWzUc7O4RR5CM/UBsex0UDXJI/ZlBhWNGO+1NohQ6T+nJh?=
 =?us-ascii?Q?0xcrzC30FOjfrm+GxX6pm48kq+7tDLE/YxJoNm/H8MCOMsQe2mTWc+e/Riso?=
 =?us-ascii?Q?jOgh35XzFIraeCfk8itBLaF0Ur4hIoVTj6LjssIxf8RcNDkWuRTrQQkDSUGn?=
 =?us-ascii?Q?8OCSZ03+9hJx8dNU+6ApFuv7iFNLaQcmcHPtZTMklgWDD+0p6R9amT6z8kpy?=
 =?us-ascii?Q?nCIumAL3/no78JWG8duuBvcZBD9b0XAYAPiZsEvXGy/xPNz/YuKT5yEFTKs5?=
 =?us-ascii?Q?ujbo2kkKgFQyl5j922rfc9ogdVe5xBERCTtDH93dgq61coWvzJmRuMfZTuK7?=
 =?us-ascii?Q?zszY+3sak2zQ7Q/m2skSYh/CVTx0zTFRz3x4JmS/8+4yA6h11aIfMGa2u70V?=
 =?us-ascii?Q?ycm0LdoVxC9z05mKPh0/MpHiATQ3umVjg4TvrOK6nCfW99sMa0hPYluYpljA?=
 =?us-ascii?Q?h2ctzLFbA4LzbEwa5sK7tY4uKEXNI6xs3cNIE76VexaFY4SDAPzQSXis8pyJ?=
 =?us-ascii?Q?y4qDogNUA4isUlWU6SfaDe8nHtEVXosGEgn78jBYf3zzF/dt/5CeYnvd2swc?=
 =?us-ascii?Q?RUiJVlNEEZ7sj3ittfnATFGBx3Ql8RsOKuOZjPodcz1oDVq1KrRiByI6noTy?=
 =?us-ascii?Q?8/ZbD95EvxGAXV/2J34G/oKvOBKyufE=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 618e4e53-e36e-4174-9fc1-08dea44e1803
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB5567.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 11:14:05.2904 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e5VqqfSRyuOpdjPS6vWIZMczxfMB42OLfFpnPA2j0kR0PA2T6IC9csJen2AYYKaq2CYaWLEK/JnjnpfPT65l/kyOLisJ8bpbsEtcBtpaWL4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR06MB8099
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
 app/test-pmd/cmdline.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index c5abeb5730..ee1eff737b 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -41,6 +41,7 @@
 #endif
 #include <rte_mbuf_dyn.h>
 #include <rte_mbuf_history.h>
+#include <rte_stdatomic.h>
 #include <rte_trace.h>
 
 #include <cmdline_rdline.h>
@@ -70,7 +71,7 @@
 #include "cmdline_tm.h"
 #include "bpf_cmd.h"
 
-static struct cmdline *testpmd_cl;
+static RTE_ATOMIC(struct cmdline *) testpmd_cl;
 static cmdline_parse_ctx_t *main_ctx;
 static TAILQ_HEAD(, testpmd_driver_commands) driver_commands_head =
 	TAILQ_HEAD_INITIALIZER(driver_commands_head);
@@ -14500,22 +14501,31 @@ cmdline_read_from_file(const char *filename, bool echo)
 void
 prompt_exit(void)
 {
-	cmdline_quit(testpmd_cl);
+	struct cmdline *cl;
+
+	cl = rte_atomic_load_explicit(&testpmd_cl, rte_memory_order_acquire);
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
+	rte_atomic_store_explicit(&testpmd_cl, cl, rte_memory_order_release);
+	cmdline_interact(cl);
+	/* Clear global pointer before freeing cmdline object. */
+	rte_atomic_store_explicit(&testpmd_cl, NULL, rte_memory_order_release);
+	cmdline_stdin_exit(cl);
 }
 
 void
-- 
2.19.0.rc0.windows.1

