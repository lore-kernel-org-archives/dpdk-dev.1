Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92ABCCA470
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Oct 2025 04:35:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D801402A0;
	Wed,  8 Oct 2025 06:35:38 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011041.outbound.protection.outlook.com [52.101.70.41])
 by mails.dpdk.org (Postfix) with ESMTP id 4326A40297
 for <dev@dpdk.org>; Wed,  8 Oct 2025 06:35:36 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PBShDtkzwKigtxTNHfvmjiG4iN2TG6Rt/VIt0OSS6NFlRXuSFM2bYlipp7YNT2KMmcyVvKVIi3Q+pbE7MflaBIMcvoteqW5SLuEQrViheYB3PMGAz4Ua35qe5fsXKKPkDhjsWH+7RV2nZoBJ1gqN+1N/iQZ3nwqfmKhchKtTORnKCYtx512DkRtaaI7BnPj8j/dF/FAI6+Jn/4l8pu8f7lUavPSdA6auZjsLU89yAY7ClWoirTiPwJ9S3RoeRuipPFrJhBdlOMVqQAqGM6mxAyIjbeULEepc+UPdh/fWkq+kLeuPLWT32lDUhhaS+LPOmvYa95z2ogvZcq9cGGG+CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sGouCyyobKJteByOicwQroyct20jjzjKSjiRBmPwUgg=;
 b=DlBsbQD/btk3x+U5VDUfjg2EEU3Qs6NECGIiB8klhRtfkbODqGGixD3SkcOBDn13B8Le4wD6r7/PpLBwoBjbTTZ12TDUIQE8/gzRmW5zJheRDYOiwX0atDCwMcQn9HtTlG8xxi2TMKp+NTpjewF0gsgqS1gCbFwIMLcwG4HsLdsEjuFHqQj3pRVpjmiEqA72GJdXcr17UnkzzVx1gUZt+C1F8ZaWmRUBMkwmNrtNlSKuewsW9tnvJJdKY6dUR/Y+WfNirRIMyuzrihOBj1ANT2OqyE2vaaVzkY2C2Q7o1V9oPCsB/bLg6Qx24kjsDrj8aTmM6SS6FikxQpidShtaKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGouCyyobKJteByOicwQroyct20jjzjKSjiRBmPwUgg=;
 b=FjJgmLK2nteKXIH04WbRUTK++1Zz87b//ADJ7gIqtSCKUJ/KITtgF0XP+4TtkkIke6Y88FGzepI0A7i82mLgeG1aMZJ+w7KU+q973i5LzU42Gnire8S78VE82/cXuWV2w6uCKqtGCBMIxkNjdEKsZFipFKZ7H54m/NRGRxeHXFoZD8eRm5LxsbcwczJDxsvsCu7uDSJav9Sdty+m70ctCKEz3qmaytgdmTbTYPSL1dAME0CE4fYnN4AR6NrzzMT7QcqdkNeCJyNzuUCAaJKXJGEm0AcYxtmNINFZLH7ME2IsnH14YmTdpwTY5UQUe/p/N+fWnYkzEoZVFtNAjtkMJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by AS8PR04MB8150.eurprd04.prod.outlook.com (2603:10a6:20b:3f0::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 04:35:34 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::c52d:9751:36a3:78f9]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::c52d:9751:36a3:78f9%6]) with mapi id 15.20.9182.017; Wed, 8 Oct 2025
 04:35:34 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com
Subject: [PATCH v2 0/5] DPAA specific changes
Date: Wed,  8 Oct 2025 10:05:14 +0530
Message-Id: <20251008043519.2461707-1-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251007050012.2432449-1-g.singh@nxp.com>
References: <20251007050012.2432449-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::11) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|AS8PR04MB8150:EE_
X-MS-Office365-Filtering-Correlation-Id: 30d96250-dd37-4f78-73c2-08de06241f12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|366016|1800799024|376014|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bfPE+0dkGzHwuzZhc+96alERrCjgENsEWXvm/8/aaBvEpoj0EqtlHRkq8WU9?=
 =?us-ascii?Q?RcftakuMuHnJQ5g/SGv5EzAISwnv7VH7YuOfPg0AGB+2ASYlNFwdVMEBzC1H?=
 =?us-ascii?Q?YsjNz5UFMdwRlJ57mc096N5NwSNxYhOOwpsEGAQ2w9O0d77B9RMPDPslqrLs?=
 =?us-ascii?Q?V9YqHgYs7Vfx6jfay95dpkUV7m8AWt1rnIhaimmwUXZ9f7fJgTRwd/vEuNT4?=
 =?us-ascii?Q?J4r3G1V9hWF55IeY98FNmaBViHvtYd6Ej/YoBI6irng6Esqk++TuJM55GEyS?=
 =?us-ascii?Q?9Vh7TRQ0lG0igG9uhYjy1uQGh8oHWVumProbWX1EJjtvQx0uPVgdMORyB57Y?=
 =?us-ascii?Q?AS/aYiubHENNSyfxMyMtRBq4yjzD0yqzYDbzP5dJI7a4cVZ2QmNhLWdiU3mt?=
 =?us-ascii?Q?0OMUNtRK7rg/7+tES703PFF/OUf+ilFiI4hFW51368EsatAzrJYUGBGo2Jn8?=
 =?us-ascii?Q?gLZqdX0LU/f09t8lZFXn9Vvp/mB/dvsI8MuXcW+Uv0JowVGSYMpOl2K8y1EK?=
 =?us-ascii?Q?L3cva30IBK5sJ0HKXAwKQpMpvt/OFBqzspwarWx+1dwHoDbsvkKrGuLx8uD5?=
 =?us-ascii?Q?kI0TKtnksz/VG9k7DIIPFul/QooUIRW7Ie7yKbxjUHKElCsZAaNqAC26wLvi?=
 =?us-ascii?Q?gCpkfxVQbqdtZh/LQFelvVmUrjJeMbCwivQH9NKgf4wRj5fcHinchJRTwo/x?=
 =?us-ascii?Q?DPFND/0cX9MxFyOFfSZacez73zjOzgRhT3hfpSGkVEuGfnD7Efz8hPKSBOos?=
 =?us-ascii?Q?fpIMGNQEazlWGL+6egH2ZXtTKa7ocMTNEkaSuPZtSiVjKd48N4PyxITUzGi+?=
 =?us-ascii?Q?7c1Ssm/akGtQKhKF6ouHsybXE7KKU2axl5ADkjZSdd4rdWYlTUA1Pk3/dnEo?=
 =?us-ascii?Q?W/8mn/CKt6EGKTVjzezzY+QkqWQvpLCcIn416vOJ69s9UiGhifpNd/PzzUme?=
 =?us-ascii?Q?vk5I1QHcu4FSvvaTyFf9NgtssEAByweo7mXfDZjAXVrIW5dOP9K6HL5uOvfs?=
 =?us-ascii?Q?b16KFuupjTXw4WjbFL7eoPFpIq9ZzEOKZQ3XiVS+uQRawNk+gAiLm7nbfp9K?=
 =?us-ascii?Q?R/O54RrrkPGXzfZob55YaG0lTTCvyuGsqrqRoShRhfdWWZEI0NABNRUIyLcH?=
 =?us-ascii?Q?jvaEDZFJN4ULKUHZl6hVagnQqLk7R0DMxRLPBwekAe1X/kve0kclE3IF7NtU?=
 =?us-ascii?Q?40MRHXXCg7SFbLGscsVi43V/W1h7K+m5immir0JGn4NATd5qPOGBRwWUP5w/?=
 =?us-ascii?Q?HF7BnRS/T04wp9ux7H6OUfk7v6+1pG0mDHnsUXNyDNa9iJ4TrJrqjI9hvzAw?=
 =?us-ascii?Q?q1c8Lw156lv5cnPxRdzn7/ZUjrgAXWKTMsHD8OKv0pMZKUFpK2lDRX+9N/gj?=
 =?us-ascii?Q?PHR/vZKuXlt1evXoWEXnKK7dUDAgisPoQurDMO/Z62HyAuy0yjLlm+ffuaJe?=
 =?us-ascii?Q?VeL160BfMRang5RKZEzhbo/YfICLrHXlmaZPQG4MOLZ3spwlge3Abe5fbUR2?=
 =?us-ascii?Q?xeWj8DBKtxqcxDGpq3rOK7G3gCL731aiMpxq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(366016)(1800799024)(376014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v94mW2TiJo7HvLNxp8UUruvxStxyHrZ7CweGXgSWO3Wgi993OntBu8HJ0m+H?=
 =?us-ascii?Q?qhoXxC+7bwu93F47cOCA7EQdNis6Ft9cTaBQSy6JK9zclpKWTJlNVdJDDVHO?=
 =?us-ascii?Q?tQWlL0D41qH8Z5PSc9e8yLRbvIYiCzJ6rPmlUBggXNsk+GHY6ax6DiKxmxzv?=
 =?us-ascii?Q?SUUEEbmr/0qccD1wW0mSxhXXS+j9rAxeZihbKvYQi0W5kj0JmQ2sIx819XJD?=
 =?us-ascii?Q?qosaQxqhnkJderBVFYkuzXYlrEUwoCt933+gTqGDLwqD3RUbZolN9Vg2phYX?=
 =?us-ascii?Q?86nWp8x3cIY0aUplab4AuK2+ZsLzOyBarSa2C2wXUYxNknOca/eAfzPzkehU?=
 =?us-ascii?Q?tgEbeCbiJEh7Y+ZY55iO2+Al2WXVEmVs7NULu+KE5GxjBof5DwkXA4/0zfzC?=
 =?us-ascii?Q?Odj4Lp0oyi0r+/C8LyBGKSyFWpedbLbc7kyYKMz1nnZN/BNV3gIX7ReSbeRG?=
 =?us-ascii?Q?4vM/w8PcRbkRDQgC7JLDD5LPdDc1+z34yvox8xlGhbD9AIzk29vsIZ9We6E5?=
 =?us-ascii?Q?5WuYZJxyimKEFunMZs6ZFh0WKPd8318zbMg2UTChdUwPPg+3c6bo0veHGSkH?=
 =?us-ascii?Q?nfPCm6z83QI1R4lqNIVLMUBriaznJ4VCTIHrl4xvamrtgPE8v+xLsabdYisK?=
 =?us-ascii?Q?N9ai9SG7mwaXvUWteJ/ZOP/s/3pbEboqAnQ3DiXd80CFqRRyNnPcaXZGFZP4?=
 =?us-ascii?Q?Jvvid8XmhXRjCV49z3fGzNqHIM5svNVDlKDolsbdBvB+oPpxa3TFbwyVR29I?=
 =?us-ascii?Q?Krs8YdnKPduznJyZyxXvrPHftlQgOEjxyUWejFa3XLeAOqHDMz6J/Fjib4JN?=
 =?us-ascii?Q?CogVgJVWtXdxTvNME8TTD+0z38IY0At8uTtuhEHMxD5d1L7q2SNc6w1yJ4j9?=
 =?us-ascii?Q?z4DGfhN19JBpixHnc/Mt/XBErP/ZDMbRIBxZFZvFikUGSSwonhHMgsKPj8Sj?=
 =?us-ascii?Q?NhQTUp0FXUvVUz+w9I5lyVgMuToCgWaPkoSKDUYrfQU++CQpkdIaOc2OBosp?=
 =?us-ascii?Q?36EcEe6hQlsprzCaI8CzvJbfpPD7b44VOhimcx5l7QwbBOnMpJfvvTTaXuUr?=
 =?us-ascii?Q?HlPsQU2V1fATmX3vTBGdVX25O2ah0X+dvLXjistiDr3/rtxkUYRMBEdFbCZI?=
 =?us-ascii?Q?kgKWIEasRv0T80daaG6v5vobiiFbYhXNqxQC/DOUYrgZDKdX+vUoboEHRY2d?=
 =?us-ascii?Q?/18pQcjeveUaSAapwfj5xjtaJ2822B2dXQ5lVVGmOx05So8J5az6uFhD83ox?=
 =?us-ascii?Q?xS49aau2I4LTZf0HuWxdgiyIb54ampsoy1XQcDlNhECkKsbPk7fhk9+Io1O+?=
 =?us-ascii?Q?bmLFVIfwMhasuEASIxyaN+icNoZAjbZGvyHRSobyEijlQLrJJOjvngG+tQmH?=
 =?us-ascii?Q?6dIUQPjvWTZRI7iag/AMncv19LQFPsCjSWPyK4vgAMQtegNSAMGs7IICox62?=
 =?us-ascii?Q?6dUW1MlIEEKQY8Qf6BTfbgXT3Ic97yn6zFduJcYKN/z6x7oYwMd17FrogNI0?=
 =?us-ascii?Q?aQ0hkC7DnzISmoU12eHIkIym0ojjbQOn3oTbeRD4BgJohzJ/73KvwilEaVGZ?=
 =?us-ascii?Q?LS4zN+UMI8RoLuZphAw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30d96250-dd37-4f78-73c2-08de06241f12
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 04:35:34.7238 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5xJdNExVPASumd+EtbGEfYLhlaJ21QSCdm2SCaLa46lAix7yogjmAC9fWcIMeSeo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8150
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

This series support timesync APIs, improves
queue reset logic and include minor fixes.

v2 change log:
 - fix 32 bit compilation

Gagandeep Singh (1):
  bus/dpaa: add FQ shutdown and improve logging

Jun Yang (3):
  net/dpaa: Support IEEE1588 by timesync API
  bus/dpaa: Disable qman Invalid Enqueue State interrupt
  bus/dpaa: Set max push RXQ number

Vanshika Shukla (1):
  net/dpaa: Fix coverity issue

 doc/guides/nics/dpaa.rst                  |   3 -
 drivers/bus/dpaa/base/qbman/qman.c        | 412 +++++++++++++++++++---
 drivers/bus/dpaa/base/qbman/qman_driver.c |  27 +-
 drivers/bus/dpaa/bus_dpaa_driver.h        |   6 +
 drivers/bus/dpaa/dpaa_bus.c               |  51 +++
 drivers/bus/dpaa/include/fsl_qman.h       |   8 +-
 drivers/common/dpaax/dpaax_ptp.h          |  95 +++++
 drivers/net/dpaa/dpaa_ethdev.c            |  69 ++--
 drivers/net/dpaa/dpaa_ethdev.h            |  13 +-
 drivers/net/dpaa/dpaa_flow.c              |   6 +-
 drivers/net/dpaa/dpaa_ptp.c               |  50 ++-
 drivers/net/dpaa/dpaa_rxtx.c              |  93 +++--
 drivers/net/dpaa/dpaa_rxtx.h              |   2 +-
 13 files changed, 672 insertions(+), 163 deletions(-)
 create mode 100644 drivers/common/dpaax/dpaax_ptp.h

-- 
2.25.1

