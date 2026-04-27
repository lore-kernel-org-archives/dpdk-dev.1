Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB4FFF8861
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Apr 2026 09:11:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 609CE40616;
	Mon, 27 Apr 2026 11:11:41 +0200 (CEST)
Received: from TYPPR03CU001.outbound.protection.outlook.com
 (mail-japaneastazon11022099.outbound.protection.outlook.com [52.101.126.99])
 by mails.dpdk.org (Postfix) with ESMTP id E0D60402E1;
 Mon, 27 Apr 2026 11:11:38 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RhVKCZPZEpe/ucpeZI0/gwlBhNuWEJfjH64C+O5fnOJx4NcTXHchQDUnKFlYjxNBp2vEFuPfNhshHTPAZe4uEzztwuEWLVCjBvMC8nzWPDZJH17a46a0F40uQPB0YCuiq62NmVfXGLZ7uckxSvBUg8MNDjrWPksM14wrbMH0ldWNrCmfqTQSNgVfwBDB8HtITChWzOZE/vMP7rhrDZraVJT8f9QeLULL19TUTHUNQ/QmFiL8cX/0p0pKhQ2nPmh2/llw+Ru7ooEMgy6w89hH8PvVDQ53rNJoItxUt8bgs7f0eEicTxnn8DdpsixiN7dwFpHgWmWc/pLXM1O0JiG0Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MzMSnO60BUmTJ1lhHaoUbr7nKf3iEhhlOk4gKvMV0oI=;
 b=jqIzarih88UyX8cMO/qQeY9Sxs+JWqpullb5Xvg4dk8SSAjqqo9uIzSRv4Xpus0jCxmv2L/OE0CD7n+w6f2MML22nAldw1bkPwy6tzk9tfcf8RBU2GQz8wpQQl7QayRou8v91FuHwHvqulH5NDo3p195SPJMGxFuNcJr4O5brhG5xgi8eNcFhF27PxZSS9cbSLm+y2o4WDT2K1bfz9288uYEKBZovOF4d1Tu8qO26A3Wu7SHED7kL4bDTiQGDk4UMPQLAYmVP/EHDtpUpx3nKM04tQwoovyT8ypRWe1S/mvSgW56cEzc4nn2kV9WUWKNpqQSN38yJAsBUbpMydlcwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MzMSnO60BUmTJ1lhHaoUbr7nKf3iEhhlOk4gKvMV0oI=;
 b=fBn6DrI5Sdms0QSnkxBqM0qL05qtKDGMYq3K23jBtZAyyG88O4gGI4PAZFERICXHBHT5w6MDwNteTw3xkbBhW2wsPBfIn0yDI/B4BFpEiQBAU6CWe+UA+p8JLO7iSwIkTC9ZqHkhqosp5aLwxOzeqznwFl898mPJED1z6bnxZxSG80iGe5Ox+rKxGAjD1HF4Qo4rlylXbHOrL4Rxx6K91Nhh+8b3rj1Ih7J7ph7sjr18vbroQ5NJPrT+9QWKM5Wp/768VHwNIYH8WDGfmVfxc4jrIytQMP8LhfLjS6pH+2/D6Mu+vQbTgx/YM1MolwzL5Rs/y0LaacwpxLCCTc6+ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from KL1PR0601MB5567.apcprd06.prod.outlook.com
 (2603:1096:820:c5::14) by KL1PR0601MB5653.apcprd06.prod.outlook.com
 (2603:1096:820:bd::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 09:11:33 +0000
Received: from KL1PR0601MB5567.apcprd06.prod.outlook.com
 ([fe80::5d45:e82a:e0bd:49f5]) by KL1PR0601MB5567.apcprd06.prod.outlook.com
 ([fe80::5d45:e82a:e0bd:49f5%5]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 09:11:33 +0000
From: Sunyang Wu <sunyang.wu@jaguarmicro.com>
To: dev@dpdk.org
Cc: aman.deep.singh@intel.com,
	stable@dpdk.org
Subject: [PATCH] app/testpmd: avoid cmdline use-after-free on SIGINT
Date: Mon, 27 Apr 2026 17:10:55 +0800
Message-Id: <20260427091055.22412-1-sunyang.wu@jaguarmicro.com>
X-Mailer: git-send-email 2.19.0.rc0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0034.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::9) To KL1PR0601MB5567.apcprd06.prod.outlook.com
 (2603:1096:820:c5::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB5567:EE_|KL1PR0601MB5653:EE_
X-MS-Office365-Filtering-Correlation-Id: 2757c9ef-880f-4fa6-92ec-08dea43cfa10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|38350700014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: pmxzrI/tThffgRpw10X+PSfH5S8JepAaTotepRa3nvr7OBoTbVCqELnNHlunz6rmLBep87zRxAk2UnO/P2+3o8Lj8o9QrV3aYbK9vx+49yHkOatqE1Bipi8XhLD+JYc7xC+hNYZV9kY/peosDybyH/yXu6L+QxUa+VovqzFW0E6a7BXKYGpjafPTI8NFIZkQL8N1a4A8OUteGBXGqgCVNJ6JJdAwn2pUhVDtLNqPLel717uLAy+MkTlA+3Dcc2hoVsalrZiSjJQTdICi1/fSAx8zUBlyPTg4rcOWYByUUI0ZQNc2rR3JKSsV7boSrE+fJjb5KkFSInF8g0B1USYckzDcSoAj5Gz0rAtXaoglPlNv9A2GiDCrjD+nCYLQHgQOrAwFlplVvRaeyJ1/2avEi30izg8xJT2C82XXiMaqnHayeksxx4cr4dcv+yBZyF0wcv9jyWPWYXT+iXnowgChENXIk4FXV++winWzHBF+rPk/fw7na0IhmATaZmFCyCRJ9lqxzxYB1khlMgbQyDvQLxeEJ3tDqMYt80tXZxr5vDDp4TByMPPOzlx/ij0Ri7WQ8yY6gDf45VO5aSEhAVLsLdpKFgXa4b0rOivjYyVBVX8coAGXVwF7SV6sAi+GTWf4tC4OzxXli6potALxHcCrSBGd+DwCwpa6yCXaSU+bWz18eLYQ/55OM2A1wNreCboUNr4VlERhLjGEYjCYQOv0Xi8vrrS7ykz4hqZ4YBjB7p2GCtrAMJC/Z3EL6IRsZuXrHQh1XvWS4FrJ/jrpxMfHAxqnrvOGv0UsTX0EenF15zc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR0601MB5567.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014)(18002099003)(56012099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i/+3mPn1ONZ+mw5DzjjdNYqpujSQuI7MWTyx7uDsP3gG7zHvPWrE0JPSfRdw?=
 =?us-ascii?Q?edjVj3cZ+mVPNumAT4YIYHGVipH9qm8pJXdHGF/vDsrl9WWlfpvJE/vjW4DV?=
 =?us-ascii?Q?ww5kvJHdjYYP26O5kyPQ3tOKziGqTp22JWzvE3QAYuelXggwVoF0OhmW6sNB?=
 =?us-ascii?Q?MIJluuktgqxc3k+Wt+qb4O7NQ9+CBnK3Biip0fuWI3cqXBrkstsG8++mNHRE?=
 =?us-ascii?Q?6yXmwBe2V9R9r6bLE9sBHn5suJ43xVY7J41tW/KCKtWnW7OGmiXvV/mkcCCV?=
 =?us-ascii?Q?hFSfREHxMbc2VRbMMmHtcHmSlwENAqyrRbD4UIg/1s7SaSJrqATgW4ySB1Q8?=
 =?us-ascii?Q?oUW9ipc70bdfUF0u1HefKvpCy6seaJhpIUVNO0LsqAnspbtKQ9ObrfbrF45d?=
 =?us-ascii?Q?FgJQDONnw4vV2jhohg0cZMh9K8IzqZjE6OyLM0keEej6zMFoGdqm5A+upVie?=
 =?us-ascii?Q?U6f8poGY07o0hO4taBrbJudu3BHJY9QBQr9R0qyLBlwbAJJlfo84Idm1KXjZ?=
 =?us-ascii?Q?XIwZlYw1uSNUfm+/KA8E+4OlPxEjp0XvjrcAWKL1mWZ6/elLnbCwpPXAB4og?=
 =?us-ascii?Q?zifXdSvz4Qm0nmcUER96+9A5OGzTp+cmyWrSQBlIrzRF3TCBK0SYlIFG/zDo?=
 =?us-ascii?Q?ve5CDPrgQETV3dJTMJFQzq0xEiaKrB3eNGU3bUchHO5OyUpxgHWf9xltR/oz?=
 =?us-ascii?Q?e3awGL5q+zlImfAq//eTkFXsFIKE2hBw/gXIwoqhYRkjWFUijbZMpO4rvVt7?=
 =?us-ascii?Q?nXiO08qtE3Mp7AQipnLkOL7HQPkhUaUZ/6hKp/S+XMwjBVeNrr0BFMRWCCWK?=
 =?us-ascii?Q?3Pv60Nb3f3z7C8J6NCVtm3Af0zKjpSshno9RzgUV5KvJ1VBY0e6D6SwkLQfz?=
 =?us-ascii?Q?iMKQnhT1cY8Bf7N4V6/NQE2iPJvO81JASGBf2qPMsAL2xTEc9KoGyc0CWFxl?=
 =?us-ascii?Q?xVTcrShFWemcheFd2IF0slULH7qnMEOr9UgcnXjsrO6cTXvGTcXisH8bsRwp?=
 =?us-ascii?Q?kw0VN0R2LXPBxOKApnyhXXs+k0oWpJA21UV3GVEZhK4ZOjW73wpZSP0q6Bzc?=
 =?us-ascii?Q?a0soy/LW4QDPhAEk2qC7aLqzq0gOIhRRnBwqAQeYmEl/jmuCDnbACBtxHYNt?=
 =?us-ascii?Q?gA8eyqM6S6ScW+fC6mvX///FyuMwFhlGWmwWXcublpAYy0OAeODknDqiN869?=
 =?us-ascii?Q?U1huRB3CKwoAvTC3DasefsOul3GmMcA3qxgRn4oFAm5H714L8sIa0QfhjowJ?=
 =?us-ascii?Q?Cmj9U3NMrar/ieew8/q+GSi4pkncp2Bm8DzkMNiTSo9bUTQ8pkfy52JUl8pn?=
 =?us-ascii?Q?Belek9EZEui5wcUihmsKs2mPBTu4s17XkgGVbD6CHSuPg5Gdn5GYlsrnhbnW?=
 =?us-ascii?Q?JVdtJjx0JQFr3Q/5rRY3Q6eimU/A0NhoHKhLhrtTVlaTb07Kn7LInW8LCHz4?=
 =?us-ascii?Q?eJqlud2aT6OrL7hkIjUHl3G+3aQ3osrQaLFGuoxbgxUB96aThQtyMF1rlwtC?=
 =?us-ascii?Q?Gnj6WAT7AI+hCMxhTWJSzhrgGDl1AJ/PeSYoilU/MEDmQi1QpPikBIdoKQA7?=
 =?us-ascii?Q?juei4DBieqPh9iAYjKVKHyqhgtSa0m3hE9GycM4lGJyiDGVelrspvTL0HBb1?=
 =?us-ascii?Q?9gU/YHfBgXDdOXEF3jDXs3E0StT26rUa+IM4cUUMmn1I9bE5szbUZzt8r2kP?=
 =?us-ascii?Q?asXx3BsF+eA5g3Ui6BEf5c9amnjKh8VCGfKUtK3IvNwO4BIdyq6mJb1QtZw5?=
 =?us-ascii?Q?7cBnBHJgaQP+MDs6P5E13p0OwzzB9b4=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2757c9ef-880f-4fa6-92ec-08dea43cfa10
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB5567.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 09:11:33.6348 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IxoM2EX35y0p7AHgFMOqlS+1xHfH5AjdtSK/qNYJU7iln3eEBvUUq4ws3dWRc5/t5ptgb334RmdGJoyLyGTXVMWYkLbDdjdRKsbCQ+t0eGg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5653
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
still be cancelled, but store the cmdline object in a local variable
and clear testpmd_cl before freeing it.

This preserves the interactive-mode fix introduced for Windows while
avoiding a shutdown-time use-after-free.

Fixes: f1d0993e034e ("app/testpmd: fix interactive mode on Windows")
Cc: stable@dpdk.org

Signed-off-by: Sunyang Wu <sunyang.wu@jaguarmicro.com>
---
 app/test-pmd/cmdline.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index c5abeb5730..e3ed0f1865 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -14500,22 +14500,28 @@ cmdline_read_from_file(const char *filename, bool echo)
 void
 prompt_exit(void)
 {
-	cmdline_quit(testpmd_cl);
+	if (testpmd_cl != NULL)
+		cmdline_quit(testpmd_cl);
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
+	testpmd_cl = cl;
+	cmdline_interact(cl);
+	/* Clear global pointer before freeing cmdline object. */
+	testpmd_cl = NULL;
+	cmdline_stdin_exit(cl);
 }
 
 void
-- 
2.19.0.rc0.windows.1

