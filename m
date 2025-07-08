Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4542C71130
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Jul 2025 07:10:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0530740608;
	Tue,  8 Jul 2025 09:10:22 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
 by mails.dpdk.org (Postfix) with ESMTP id 9F6A740287;
 Tue,  8 Jul 2025 09:10:20 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wza0xQt4Cqg1/1FP9wdsrkQYzhsG+V8AAhI+vOOvlZcqDQn4r/OEe93AmAxrIhYQZqQ0H9uPDXJs1GP1CQSJDAoQAFqy2zS/NXh/YWHtHx3Vf9sCyvbeASD6Bfm7GIrmFgTKQqsRRdPFwA2OQw/VIJ8Cho4pRIel3LjPYoz4qvyCpkNv6cxLL7byTauCaW7Jcy5GjQcSgMgtwxJmZ8zrXf6IxzacubGQkK7gIZVD6ZzOiXdHEjsoQqFTUXn1mjNYiJQ25d2qp1vh7rgAjRo0Ov2IYYlX6a8vLesg9gJjpMSp60ksiMc+WicnMF2tPa4n45mMEqWfYqMcSnhwsTQvuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jTO3PcgG/yqi2CGQHYhqX4fGpdu6cyx0wtS3+Xh0ERI=;
 b=aqt99otSwW9cxUnUfunIjOaRQjNXG2f6ITeCjGR+nWzp8I9fqWxJk9CXQNrHlszs75TQQRasnLQQOBI1W1aWi/rRsGjZufiHvHB7lmCLj450/sXlU5Uj0+WHjJkoA6Q2HZR/k/x9dJ5NwKHs2UrFUOr5mSbCpH6dJxm2B7g9hDcFM7x5sYJtlE6pKdB2Mv5fD7ErziK5gGs53FiEuqfxXvYWK7MJqMcCXLhNZLy1Qt6EYIHEcYHGB6ZYIRaIAgoF3sBbBwE8JOgcbX8wH/OyALO9NuKL5iBtS2NA5TiXPFf7uhy7C/eAWjVS6ZjjSqyMWKueUhWbZfVbh9dO8PWp5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jTO3PcgG/yqi2CGQHYhqX4fGpdu6cyx0wtS3+Xh0ERI=;
 b=b4eMr63OpJcgAaZuZgW7ytscF+LEQj7oXRW1JBDzmp19E8vJYtt9EFmftXq2JM4VDYlQCiy2J8Eort/eRdYjkAF/Lb4fB7ZAhz0FTzOIwWcDo/1a9L9avucu7Juzkdc6Z/jcqeADaRsbk0FbbCyQUvjfCFQ0Rl5e37ey5qIqPji2sEvc6SIRJGO65MLEuuVhI1Elw3qaigobXgFY05LREVKZpaCe7o2cz4sO2oh6a7r+V6BCF1rONyg5QTKSy19rXRf00wsNYgVxBUPGczvZxGDK6wp2F4JVctgfyPWAz5dsyFiwhqRnkA/Se3g8XboXxE373LHms8ou91kMUpfgbA==
Received: from BYAPR02CA0054.namprd02.prod.outlook.com (2603:10b6:a03:54::31)
 by DS5PPF1ADAD2878.namprd12.prod.outlook.com (2603:10b6:f:fc00::646)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Tue, 8 Jul
 2025 07:10:18 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:54:cafe::6d) by BYAPR02CA0054.outlook.office365.com
 (2603:10b6:a03:54::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.28 via Frontend Transport; Tue,
 8 Jul 2025 07:10:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Tue, 8 Jul 2025 07:10:17 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Jul 2025
 00:10:00 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 8 Jul
 2025 00:10:00 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 8 Jul 2025 00:09:58 -0700
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <rasland@nvidia.com>, <stable@dpdk.org>, "Anatoly
 Burakov" <anatoly.burakov@intel.com>
Subject: [PATCH] examples/multi_process: fix cleanup on exit
Date: Tue, 8 Jul 2025 10:09:54 +0300
Message-ID: <20250708070954.165222-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|DS5PPF1ADAD2878:EE_
X-MS-Office365-Filtering-Correlation-Id: 0884c2c7-497b-4c79-8c5a-08ddbdee7e37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cgY01EbBbg6NCco8bjQE9d+a1SroUgv4yEXYp/sCk7sUQttPCpOvIvbJ1MP5?=
 =?us-ascii?Q?IWNks3t0heKZHjfGtTRQkGVjElR8zCXHbh80ZyyP8j3kispv8XW5ZqFhjJCu?=
 =?us-ascii?Q?dAG86pzFxX5VNnasM5ReW6NTaEAEuLzygtCmPMWRE4ReSiNPoRCCMapkqOug?=
 =?us-ascii?Q?egSZfZnSGH33gtGqYOpGka9/9LLglrs+Ee0gJ2GiEr6uZN8xBPS9X39DjyRK?=
 =?us-ascii?Q?CqKBR8awoFYZu8MVOSxdzvSo4uH03awL2xlyV7HbIsUWKzldVEBvq0pUbpEg?=
 =?us-ascii?Q?g6u8JMJJcMsYtiUZbVK5SlKn8AF54r6HfYUoFg5WA07RAeEKp12w31nyYyw8?=
 =?us-ascii?Q?cXr1H6/vBpsraIrapixfrghbnIrlsr6GZNb2x6qFkDji3upSaKL1T8ZJY0Gt?=
 =?us-ascii?Q?s4E59cPp7iK1dPbVPzW9wWoJo1u5vmcdKemoFn8PWejAujOv5qZ2nE5sOwxj?=
 =?us-ascii?Q?52itwTj4zIOays4hWaq6h9KsAXO2N3yt2k353HviYbtS0eQXHVViQe08+bV3?=
 =?us-ascii?Q?gPme118PHsBLkV3mB657EjD80AosjlMH8GJCkobTAUowT8lO5JvYaRiMzwtR?=
 =?us-ascii?Q?T45yMnnNNEWgFsbO8iJWzWaLfdWKpalhYG8WRgXfb6Y1hQ+xMIEiwcZJ2O3Q?=
 =?us-ascii?Q?ZcD1cqp7HTm8804M8lkYtg5RZGM1auLAYIKK2cuvInTExH15qsA1Qq3kwxLx?=
 =?us-ascii?Q?UNKQVX8SHahKBoB7rYKLLFYNpha0oAmPMWB+jrrcS2OMlREBoS5r7ChQl/2k?=
 =?us-ascii?Q?9BOl+6RmLPs2/aaEl3ZlyjrRgko0vPBk9PlNzkKJMfbujlgfYXHm7lEiTo/Y?=
 =?us-ascii?Q?0DvrpwtWUnuMEJM1a+x97a7lIcYZinrOiG1TMw7tqiMwFONM39L5xvRVIc8n?=
 =?us-ascii?Q?FpgC5keLM59KfIXqOY6dSNSORSFdDJt6ivt7h1k8os9tW3AP31r3cJBFH0PQ?=
 =?us-ascii?Q?J3/Mi5OwQxW99wrOtmLGKA/MJReQVRGqDNZ2AGzLV06V+nD/+dH5uO/wx8Wz?=
 =?us-ascii?Q?a50vWWzgamB075UoffHD6gGiU9n23wYithmmA2jdO4J8L7nX5zfbnwO9YhEm?=
 =?us-ascii?Q?EarcWrejswDZFLRFQ2YaKwDkj7iG0iFlbLY2Y9W/9mZFa4R1dd03xA3IhevY?=
 =?us-ascii?Q?Acj0NpKTEgHhlCt+b9LNGGB3VaVj83nrymLfoWIjFzpH+9Qz/SYfVfw+wzyF?=
 =?us-ascii?Q?PTYi4jzJpkPppJNZmwjC87/kgkRUwjwe9dId7hXfFDz8vjjLKcF83tvxrwdL?=
 =?us-ascii?Q?QFMAbdYu7XqQtg9MKe7qwrbw1/mSBJ8mcoHoQv+vr69iV1xa7dGSvx+JQmN+?=
 =?us-ascii?Q?vSZ9GguPcvpqAwByqf6npbwJiWHtNcHWNMSonQ3ZX48PNwG1ifTSDqvneBeq?=
 =?us-ascii?Q?QTKNPsjqTs85CVBiHKxAsz0xXgU1SKH4XlpyQC5PcwFg0v9DfpNt1spZRgid?=
 =?us-ascii?Q?Z6HN0sVRTXJviOSWlV4loj6ckcgVpjqI4KSQooB/3DOpGxokb4V5U4qjvLQw?=
 =?us-ascii?Q?w3Nr8BzaWrBjKTSI76vwcNaheTBGtery8b55?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 07:10:17.2660 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0884c2c7-497b-4c79-8c5a-08ddbdee7e37
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF1ADAD2878
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

Device was started but not stopped on exit signal.
Added port stop and close on exit.

Fixes: af75078fece3 ("first public release")
Cc: stable@dpdk.org

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
---
 examples/multi_process/symmetric_mp/main.c | 27 ++++++++++++++++++----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/examples/multi_process/symmetric_mp/main.c b/examples/multi_process/symmetric_mp/main.c
index f7d8439cd4e..de16608a0fb 100644
--- a/examples/multi_process/symmetric_mp/main.c
+++ b/examples/multi_process/symmetric_mp/main.c
@@ -92,6 +92,25 @@ smp_usage(const char *prgname, const char *errmsg)
 	exit(1);
 }
 
+static void
+exit_cleanup(void)
+{
+	unsigned int i;
+
+	RTE_LOG(INFO, APP, "Close ports.\n");
+	for (i = 0; i < num_ports; i++) {
+		if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
+			if (rte_eth_dev_stop(ports[i]))
+				rte_exit(EXIT_FAILURE, "Error stopping ports\n");
+			if (rte_eth_dev_close(ports[i]))
+				rte_exit(EXIT_FAILURE, "Error closing ports\n");
+		}
+	}
+
+	/* clean up the EAL */
+	rte_eal_cleanup();
+	exit(0);
+}
 
 /* signal handler configured for SIGTERM and SIGINT to print stats on exit */
 static void
@@ -104,9 +123,10 @@ print_stats(int signum)
 		printf("Port %u: RX - %u, TX - %u, Drop - %u\n", (unsigned)p_num,
 				pstats[p_num].rx, pstats[p_num].tx, pstats[p_num].drop);
 	}
-	exit(0);
+	exit_cleanup();
 }
 
+
 /* Parse the argument given in the command line of the application */
 static int
 smp_parse_args(int argc, char **argv)
@@ -486,8 +506,5 @@ main(int argc, char **argv)
 
 	rte_eal_mp_remote_launch(lcore_main, NULL, CALL_MAIN);
 
-	/* clean up the EAL */
-	rte_eal_cleanup();
-
-	return 0;
+	exit_cleanup();
 }
-- 
2.21.0

