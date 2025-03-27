Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE40C3600B
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Mar 2025 07:57:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A07FD40275;
	Thu, 27 Mar 2025 08:57:23 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2088.outbound.protection.outlook.com [40.107.20.88])
 by mails.dpdk.org (Postfix) with ESMTP id 3C01040261
 for <dev@dpdk.org>; Thu, 27 Mar 2025 08:57:21 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FWDPAGh8cygiUOEkR7Q3PyYV8GAjRtdNd7CyIDwgQjzdJDdKF7N1nm3HYGdFacAIAi1eeD60jOTHPpPdHVSig22FA7G2onl2Q6r1chAhQNRa0aIszVwetY9fm2Hu6Mf/9XBfLjWaDkKVIC97UrJG6CHrthB7vmEz3uJIuFHa1Iv6vjVZe/mac1nxIi+BYzm0DUs1vGCWdqDHsxx2QQubWKIfTMYUhLfm9TIVhp2aUw0Hi1I8/X4DAE9ZjF6RQHiP/QGkqdxokdlbG9B9qmD8MzDxGszTixza8XI7998ogaMwNMryrM8oX3SL/kkYL5gKwFFEThSpdDuIepb69lAK4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gUp3W8kFHp7Vt9z49K9B34ZzHcuqH0qoAOTY5aN1JCk=;
 b=ZxuelivaINVJEFSNcewRo0CNP5VAjBkFxOfq2lOrJqr5sW7i1AYYcJT2elTvJwpktKRguPjUq2zmAw9I7yScyE1+/K7dqzR5+yQeqlWZ+3LEuLjrvgD01UnNdIcV3q1E9nq5QQhr9T4oANmN+giyIACKgdmXSm460VTV8hepHVRU9d55T+3t8PXhyN/kar780RmJrICTv/jiCrls+NIv4vYSaRFFnaI/UJTjAbr+NW8OV3Z18qzL7I7OnSStnAk++ZYB8J9LexehxB62nrehblL1tPRrw7b4Lrb5a/dM3rXBrejFnYf23vxnTOE3Siu2xDH7LkvgjvYjyJtWe3/47w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-sbell.com; dmarc=pass action=none
 header.from=nokia-sbell.com; dkim=pass header.d=nokia-sbell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-sbell.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUp3W8kFHp7Vt9z49K9B34ZzHcuqH0qoAOTY5aN1JCk=;
 b=Ha3+NgKnqyUBWXutlC0mIucZmacgY+vfBs3uyxQLjEF2gckkSoZ1zOuAMYcrat8hAvaVeFLRrYKxb5ZHCfUDZU7d0ndI7aCzFvilt6dzeNe25sCSOBSFapES7+sBv98KqKt8QD2nJJ79hv1TGaN/0e82n8LlUySO/u+GburVwumqtuhaJ5hOOeT7NOVhl8fAYk0aVsgtBAeFqEFiHN19h/fi9gywU/xCHdEh1+WOk9i8d9SiMxe0iT9HMyXBQ54/SS22giAb07rodye4pfoa3O1++p0tsd5mWcYq3LORpYyxqfEI/ab65Kk/0g8R4QFdxjdI9CD/NTuXvSd6q6GeCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-sbell.com;
Received: from VI1PR07MB9898.eurprd07.prod.outlook.com (2603:10a6:800:119::6)
 by DB9PR07MB7833.eurprd07.prod.outlook.com (2603:10a6:10:2a1::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 07:57:20 +0000
Received: from VI1PR07MB9898.eurprd07.prod.outlook.com
 ([fe80::1928:4afb:4eee:1f21]) by VI1PR07MB9898.eurprd07.prod.outlook.com
 ([fe80::1928:4afb:4eee:1f21%6]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 07:57:20 +0000
From: Yang Ming <ming.1.yang@nokia-sbell.com>
To: dev@dpdk.org
Cc: Yang Ming <ming.1.yang@nokia-sbell.com>
Subject: [PATCH v2] eal/linux: skip vfio for non-privileged container
Date: Thu, 27 Mar 2025 15:57:11 +0800
Message-Id: <20250327075711.648-1-ming.1.yang@nokia-sbell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250117072847.2741-1-ming.1.yang@nokia-sbell.com>
References: <20250117072847.2741-1-ming.1.yang@nokia-sbell.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::13) To VI1PR07MB9898.eurprd07.prod.outlook.com
 (2603:10a6:800:119::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR07MB9898:EE_|DB9PR07MB7833:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b6edf69-ff03-40f9-de49-08dd6d04ffdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?n2V4UehvCYsc+bpeB4xJTD5SI1oJRAXPhcYboUByQAFvLMOoILOGiEo1bwiC?=
 =?us-ascii?Q?lBJWVsAGQmnSU0o4SfHE6S3CVjzixNn9EiKiJQjeOHe9Jt3o8IJ3suO3jkqR?=
 =?us-ascii?Q?zuDkuvxmRnspuWy8ovPsQoxRhimazlCRghBmx5URgmjB8mrS6t3nFb/TuR7t?=
 =?us-ascii?Q?UNkBk3XgHu/n2AWjPCuEBbemSdrdawDR0tPGPc+a8XOzJcu3A0rthklsGqDZ?=
 =?us-ascii?Q?9hGPaU4j5moQ8Ra0EIOq2nxUsfaYWuxkfyeR0kjePKEpbptl0yYDRiocmzhL?=
 =?us-ascii?Q?d7qkybod+Wx3HF4SgJL4l9ZAPKaKfZikT+ZuJXTqsyHJiD0Wwgfk8yDw1URT?=
 =?us-ascii?Q?GJgmzTOrEe+mWMtWgnFA4OveomESvd4LSDxakrML6tfNcoNdzWcq5nynpwo+?=
 =?us-ascii?Q?GExb1WpxuSbP6PepqEWatA4Q0TAGh8BQkTIK+duDt94gpUxU4s6W9Bb5mzQK?=
 =?us-ascii?Q?N23GEE6tk1t2zrVMfgmcobOU5J7IXq/argYd5G3CHhlfIb1f+/3PttKwyp6r?=
 =?us-ascii?Q?e6RgPoACoxpTHgPopx2r0iEoGDxM8bioiR/MOIaj7ow0dWnYiZariir20yK0?=
 =?us-ascii?Q?4VtLtasM6OfG8//cKmNZzB5sTk/uXE+t00B5OFFg1eWyxzBIqbFvenkvtva1?=
 =?us-ascii?Q?wBdnjFlnrx0jKYG++P2RwiNApwXScvSZYelc+UEIKymXlBNmIY7qegkZZRo7?=
 =?us-ascii?Q?Z8/1qutccuiKTv9KkQUvsfzTbjfTr2GSCsP3cONTqftbdhx/xjAKi9fp7I0u?=
 =?us-ascii?Q?OjICTfBVc2huIR+Z0e40RkPvfa96BhgYMSfplDwVU23ugSH4Jj7OUZk3MoU+?=
 =?us-ascii?Q?V/nCj/jPJOMv92EYr7hA+60ICGDa8IpUw5E2UeuIf6sJT+SuII/AjEQE3vmy?=
 =?us-ascii?Q?JKwwFHVkh0GIqIaQXCCM+AdvQ5RYslFwhzuRxYqRHjUbKFgH+w5rTe95UXMf?=
 =?us-ascii?Q?Q1aq70QLTnHRzO1sGibd63WKkxO/RXjRUOOUSexSE0amO1HOQLMGpf91cQXp?=
 =?us-ascii?Q?qUulivB3+VE3MoFeaYmD591G+bPlnKHdPbJFDTak5LLkl2blK8+cyOgXTlLb?=
 =?us-ascii?Q?rYmeG4vX9cpmWp/bTytbNZXpDUAPtk6lbuOpTSuD9N9/P5t8t8Fqsr3HCa0w?=
 =?us-ascii?Q?ma/I2HRc6zkwGiGp/++tD+P9T9QoQ9O4yZuoptI5YKhrHaGQgoGK3oPmIgLS?=
 =?us-ascii?Q?ytW13nUg2FloCTueV2qsVICQ+KnSHpJ4aJ2OFEasslI53h2/yAzrb/pTTzPB?=
 =?us-ascii?Q?KfXVIoVzLNIEG1vwYirv7MQiFeZ3Y3zY1th1NbvECSCW74xNEOjcmmp+b7uN?=
 =?us-ascii?Q?yEVGx9TNzfm2G2nrEsx+uNDQ2ZI1wIxw9yN3gqhslbp0RnHaK35NanYLgObR?=
 =?us-ascii?Q?PTCxhrvNPv8Cd1yGBu3wrGUwE6zj2DbMau6roWjSL1BxCcu+xdpVsq3N88x1?=
 =?us-ascii?Q?rtsEfBDsruY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR07MB9898.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/lZM9fbxxjnIkmtyLp+4KWsoiJnQlYUkYyIv+pnUnfBE9bIYYDi0E2G5Eba3?=
 =?us-ascii?Q?japl/4qcAG0rZL6fVzP9b/Td8RTWyZdVnwTUKF1z9fc2J/f+zNe+/pzKd4Wp?=
 =?us-ascii?Q?W9bl2V7+xXcy1RAAuRZe3DJsdWwqWkjooZF+6NrZqlz3b8uoosi2vJpoL00u?=
 =?us-ascii?Q?0oubdzTp25IJhEQgHTWyhKiKB5EIQv4nvw/U0qI8eL+jOV+6GGqbGZeOZLbS?=
 =?us-ascii?Q?nnyzRM3ChYu5qc1ki5aTZRpgCJG6CchLRN86wbFMi2SPTjLh5qLqL+u576lP?=
 =?us-ascii?Q?QQRktZDoeWYtd6mZmeGfoc+d4sYkb1YeK+lrNEOjy6shx7OLet/DxpYweKZT?=
 =?us-ascii?Q?m/pFdosxY0XGm1cAIbG9Q4nB//9d+Kvxrwib+AyuyrzNn9carO6OscmX/A49?=
 =?us-ascii?Q?qG+xs29E5gFHA28BA5yZBeapHxJmoGJEidrlVyIyTY3lKUjEjiyRv1h8Prkf?=
 =?us-ascii?Q?f7pgnyyUbKf5h60uEnxc3fYKv2+bJD9vCBZ9y/pAMv2yZFxma3ahjSA0q7gF?=
 =?us-ascii?Q?QF6SoZtVLfhjyNkIcjVN2oeuRTAo4nfD4l7q1fp/3EzTVLjUyrFq3KHiRrG5?=
 =?us-ascii?Q?7l0lxjQFvmabsJFhdJbnOO6PE2uaAeY1JZOPOYWcUm6Ck6F9pqjIQN7H3s/F?=
 =?us-ascii?Q?X4fmcw+5kZcmf7mYeTTYoMGRQTOm9bWScajHE4UgCelZ3n/2kOS72eZnrXBz?=
 =?us-ascii?Q?CyyGUQY3BRv3j5/BPuI2B0GOLh6oz7ChejIUYoZG65fUREprQc87rWJclnoJ?=
 =?us-ascii?Q?nQs+d8cZro4itKUB0JiT4g2ejDLPGQwJSg8iG3+zFgrP7BBGycnWJhxMQFjd?=
 =?us-ascii?Q?aDaacwQfKwVNVxp8/iVzwfcFsVlSCKfJtsh5vX24EPoeZ7JMOwgdh4DDeR9k?=
 =?us-ascii?Q?if4o3Dyh9+RKOdtUH4Teuh+brP+fmamKkPlmPWRPESN8j+6WcYhGBoI9XpTj?=
 =?us-ascii?Q?9POSpNDFrTTIUkvqBDdC2qKJwqh1oxlYTIIebvyFWh0pYaERamk3GfuT5nwV?=
 =?us-ascii?Q?8cJYtd2iNHkPWNnD4sAChkZ/zvuV69gKXIM2f3XzbhE66IXxUV73+t0spXQM?=
 =?us-ascii?Q?1PDkO4relH4lJDY2IxD8DBw7UHcYJhRpCuzOtpkbVfhgDsbF1Q3Qx3cihsSV?=
 =?us-ascii?Q?my/aLYuPVc+cRkpeQXnWgXwK87rWfAfJ4Pq1zKG7hEdByawYrtpZjMoCp+Kw?=
 =?us-ascii?Q?c8bqDeyWKA8zxBNV9nK5pTtQMrJNJufQonY8JEvL0mjRDDrZwPG4BXw87+X/?=
 =?us-ascii?Q?bhdLn3i+kAEeJlNu3BEt0d/pBGj09lUKxMyw2eEOa6m6FTj3SkD8lbfdecZ7?=
 =?us-ascii?Q?Vn1CLtpmR9N8t83u7ZXf76LraaeuBZTV4U1vj4fmJioD4r4ETuofm/9SjH1w?=
 =?us-ascii?Q?b/SdKH3gcJfNKHK6mj4IwXPLD3C36JhZpuydrFUY1Jt9XZlr+NgTvsEiKChc?=
 =?us-ascii?Q?1fPREhFHteMFMnW2L3BWj6g1qgaH2i6Hh3Piu6nyTYd5iyHHzFmJRaoztiCu?=
 =?us-ascii?Q?n4d0VVMTyzs0NQw50XtXk39TXsvbslh5pkpZyWjL3SnPkJVfs830oufXnQjv?=
 =?us-ascii?Q?pHm+vx3TRN8j4xrNqYy/2chXt9zzaVYSvGJHYQJPAwHHVpt1oyqW2KLbctw/?=
 =?us-ascii?Q?9w=3D=3D?=
X-OriginatorOrg: nokia-sbell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b6edf69-ff03-40f9-de49-08dd6d04ffdb
X-MS-Exchange-CrossTenant-AuthSource: VI1PR07MB9898.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 07:57:19.9057 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: igM/3icDnC6QR71HHldyPfzjXKCFJvi2ViLvR2T0FxHzmvTzoCEbsuegk0wO1kaQ4HT2TsL4xAmZtXDnIyCj4dNZhd7mX+htV+9njUriMZI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB7833
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

DPDK detect vfio container according the existence of vfio
module. But for container with non-privileged mode, there is
possibility that no VFIO_DIR(/dev/vfio) mapping from host to
container when host have both Intel NIC and Mellanox NIC but
this conntainer only allocate VFs from Mellanox NIC.
In this case, vfio kernel module has already been loaded from
the host.
This scenario will cause the error log occurs in DPDK primary
process as below:
'EAL:   cannot open VFIO container, error 2 (No such file or
directory)'
'EAL: VFIO support could not be initialized'
Because `rte_vfio_enable()` call `rte_vfio_get_container_fd()`
to execute `vfio_container_fd = open(VFIO_CONTAINER_PATH,
O_RDWR);` but VFIO_CONTAINER_PATH(/dev/vfio/vfio) doesn't exist
in this container.
This scenario will also lead to the delay of DPDK secondary
process because `default_vfio_cfg->vfio_enabled = 0` and
`default_vfio_cfg->vfio_container_fd = -1`, socket error will
be set in DPDK primary process when it sync this info to
the secondary process.
This patch use to skip this kind of useless detection for this
scenario.

Signed-off-by: Yang Ming <ming.1.yang@nokia-sbell.com>
---
 lib/eal/linux/eal_vfio.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/lib/eal/linux/eal_vfio.c b/lib/eal/linux/eal_vfio.c
index 7132e24cba..1679d29263 100644
--- a/lib/eal/linux/eal_vfio.c
+++ b/lib/eal/linux/eal_vfio.c
@@ -7,6 +7,7 @@
 #include <fcntl.h>
 #include <unistd.h>
 #include <sys/ioctl.h>
+#include <dirent.h>
 
 #include <rte_errno.h>
 #include <rte_log.h>
@@ -1083,6 +1084,7 @@ rte_vfio_enable(const char *modname)
 	/* initialize group list */
 	int i, j;
 	int vfio_available;
+	DIR *dir;
 	const struct internal_config *internal_conf =
 		eal_get_internal_configuration();
 
@@ -1119,6 +1121,15 @@ rte_vfio_enable(const char *modname)
 		return 0;
 	}
 
+	/* return 0 if VFIO directory not exist for container with non-privileged mode */
+	dir = opendir(VFIO_DIR);
+	if (dir == NULL) {
+		EAL_LOG(DEBUG,
+			"VFIO directory not exist, skipping VFIO support...");
+		return 0;
+	}
+	closedir(dir);
+
 	if (internal_conf->process_type == RTE_PROC_PRIMARY) {
 		if (vfio_mp_sync_setup() == -1) {
 			default_vfio_cfg->vfio_container_fd = -1;
-- 
2.34.1

