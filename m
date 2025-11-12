Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC96CD4F28
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 07:39:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 25C194065E;
	Thu, 13 Nov 2025 08:39:10 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 475A140697
 for <dev@dpdk.org>; Wed, 12 Nov 2025 14:03:35 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AC8E9Mm3650027; Wed, 12 Nov 2025 05:03:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=iJGfIonFGbX9oLHCNwr+qaQ
 M398rM1ISoSgrI4WIPfU=; b=jIOOjoUXwIWm74MFNqAJzwl+EXEZ2msbbeBwvQ9
 IEhVMYpJTwtSCFCkNslVMTme8x2D7oYG0WizGk60rtneGcl948SCcB4hc59hHOik
 wOfJu1h0yn7ptrXvkeJcs1VGN19yVJiJBz32gvF5Jm59IwknEAjwIqrk7Fb8EG0t
 I2WYLRRcfPHbHp6KAOkeiceedlaBYwbr8fZ+KucJJyug1a3a/k3Wo+9yRflpLmfV
 9/9V5f57seal7KdJ5TqiN5O3ghezlyV151euum4t5NXfF/3cy29wGuDedho72YxQ
 iIC3ZYUNWNrUU0Y8azZV5JCA8+pnQeKrsGlgDe+6OshrNmg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4acpj28jg2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Nov 2025 05:03:34 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 12 Nov 2025 05:03:45 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 12 Nov 2025 05:03:45 -0800
Received: from cavium-ThinkCentre-E73.. (unknown [10.28.37.6])
 by maili.marvell.com (Postfix) with ESMTP id 048A45E686D;
 Wed, 12 Nov 2025 05:03:31 -0800 (PST)
From: Mohit Kumar Parjapat <mprajapat@marvell.com>
To: Reshma Pattan <reshma.pattan@intel.com>
CC: <dev@dpdk.org>, <jerinj@marvell.com>, <hkalra@marvell.com>, "Mohit Kumar
 Parjapat" <mprajapat@marvell.com>
Subject: [PATCH] app/proc-info: allow overriding defaults options
Date: Wed, 12 Nov 2025 18:33:13 +0530
Message-ID: <20251112130326.2674728-1-mprajapat@marvell.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDEwNiBTYWx0ZWRfX5kzF6E/qhBRv
 t7stiXRcPPNKhpiFesDU9yw9ttFknempoBnRDpslltmUWdOm2KlPktaEyaV1uOWF1sjKJXWtHRJ
 kajQtLcCqxneP6fLL+trvyE3VV5JRTQcPsORQ+MIFGSjwGV/y0OgtmdS4lhWVQABBkiV+N+W+2a
 IpWCt+Yha6bNUYtJszaXJ9fSnZqImgnTyeqr41OEZICyydipwRzTevIV7yiUi2+JkqUMTeOPMK0
 k/74MWJdYyaM4qF1Iy7qqu+Pgj/XJxusn5VauABL8bRmbe9Pbkvok9p9SjP7RdgrNqSnrNXmFwp
 ohU2Tm2wdIrW2E4+jybWMfcR5OmZuLxk1T3IdsDkpLfvJNlIUUpttRU3IyWWlLU738URT2dHsGQ
 9c8apGnfTz18tcSjqjhyI83SuyJ7zw==
X-Proofpoint-GUID: j8-PAbZ1KjmTfBvtOvQGW5IFTwRFpsJf
X-Proofpoint-ORIG-GUID: j8-PAbZ1KjmTfBvtOvQGW5IFTwRFpsJf
X-Authority-Analysis: v=2.4 cv=df6NHHXe c=1 sm=1 tr=0 ts=691485a6 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=EyE5V0NTC9j-1uaGqHMA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_03,2025-11-11_03,2025-10-01_01
X-Mailman-Approved-At: Thu, 13 Nov 2025 08:39:08 +0100
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

This patch overcomes the limitation of proc-info application
by allowing users to override the default -l and -n options.

Signed-off-by: Mohit Kumar Parjapat <mprajapat@marvell.com>
---
 app/proc-info/main.c | 42 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 8 deletions(-)

diff --git a/app/proc-info/main.c b/app/proc-info/main.c
index b09c03ab35..bf624ab2fc 100644
--- a/app/proc-info/main.c
+++ b/app/proc-info/main.c
@@ -55,6 +55,9 @@
 #define STATS_BDR_STR(w, s) printf("%.*s%s%.*s\n", w, \
 	STATS_BDR_FMT, s, w, STATS_BDR_FMT)
 
+#define ARG_C_FLAG (1 << 0)
+#define ARG_N_FLAG (1 << 1)
+
 /* mask of enabled ports */
 static unsigned long enabled_port_mask;
 /* Enable stats. */
@@ -2116,6 +2119,19 @@ eventdev_xstats(void)
 	return count;
 }
 
+static void
+check_user_args(int argc, char **argv, uint8_t *arg_bitmap)
+{
+	int i;
+
+	for (i = 1; i < argc; i++) {
+		if (strncmp(argv[i], "-l", 2) == 0)
+			*arg_bitmap |= ARG_C_FLAG;
+		else if (strncmp(argv[i], "-n", 2) == 0)
+			*arg_bitmap |= ARG_N_FLAG;
+	}
+}
+
 int
 main(int argc, char **argv)
 {
@@ -2125,8 +2141,11 @@ main(int argc, char **argv)
 	char n_flag[] = "-n4";
 	char mp_flag[] = "--proc-type=secondary";
 	char log_flag[] = "--log-level=6";
+	uint8_t arg_bitmap = 0;
+	int default_argc = 0;
 	char *argp[argc + 4];
 	uint16_t nb_ports;
+	int argp_idx = 0;
 
 	/* preparse app arguments */
 	ret = proc_info_preparse_args(argc, argv);
@@ -2135,23 +2154,30 @@ main(int argc, char **argv)
 		return -1;
 	}
 
-	argp[0] = argv[0];
-	argp[1] = c_flag;
-	argp[2] = n_flag;
-	argp[3] = mp_flag;
-	argp[4] = log_flag;
+	check_user_args(argc, argv, &arg_bitmap);
+	argp[argp_idx++] = argv[0];
+
+	if (!(arg_bitmap & ARG_C_FLAG))
+		argp[argp_idx++] = c_flag;
+
+	if (!(arg_bitmap & ARG_N_FLAG))
+		argp[argp_idx++] = n_flag;
+
+	argp[argp_idx++] = mp_flag;
+	argp[argp_idx++] = log_flag;
+	default_argc = argp_idx - 1;
 
 	for (i = 1; i < argc; i++)
-		argp[i + 4] = argv[i];
+		argp[argp_idx++] = argv[i];
 
-	argc += 4;
+	argc = argp_idx;
 
 	ret = rte_eal_init(argc, argp);
 	if (ret < 0)
 		rte_panic("Cannot init EAL\n");
 
 	argc -= ret;
-	argv += ret - 4;
+	argv += ret - default_argc;
 
 	if (!rte_eal_primary_proc_alive(NULL))
 		rte_exit(EXIT_FAILURE, "No primary DPDK process is running.\n");
-- 
2.43.0

