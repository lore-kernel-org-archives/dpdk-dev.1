Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6159CA0FE1
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 Aug 2025 07:15:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ED88B4025A;
	Mon, 25 Aug 2025 09:15:18 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by mails.dpdk.org (Postfix) with ESMTP id B18F740151;
 Mon, 25 Aug 2025 09:15:17 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CWFSMrSNVeTBBmwevz+gkDKacgy51x3sXj7Fod/scpvhUuH78jJFMcJh4RWN+7TALBKeX8GbU4L3u+bnb4xI1PVLLi88EZotrpZaHsVOJsMr5EOGxdPups5/jAffcgzRQyz1Cku/XnF6RnKIr38CIl//H7e47vXoi/JyZOMJWk8ZFsR0JMH9dHseqVeT+aBxUjYsIUGEHyOTpdhAcP/7NlyYK6+ynnNt7bGYc1iTuuO3lee6NwvibvRgkEqnYsOVzEP5x7yncNcoczJmR59QxMcKdcL9zEbpxS3/D5zugx+h1lB/PDJ0GrZfm9pi8aY73ArzDgRCyU7S/oi1ZyeVUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0j/JSY8BaEmqHeLzzSuUnqixbDq+hPeZCqdiWhMBqQw=;
 b=iL2MTusDGyMls44v2T0T/OzzoIA5m1YvMAUrrgNoiFuICOVDrt0uwCaPVndJgy3iQSd2bK1oty2K8E/HrPLs+AjJ+uKwgo/i3PN9yk87S7bTEdgSgCk4O2dyeqMEHgoBR1dRtnIblV23POj+JXT5vm9pProi1xxoKhT8wXrqmOzyT6BN41mZOkPI8aAUo/tmNYt2yqvU853Z+1H2QWjdT8eLCyGp+sdIDDGzKTaMHEcIgaqIp4El5uaz2icODFc66wiVR++F+yHNxtAVn68ezYbQsnVATUeb50gWbngFr0jZtyPYtjtyUAGbIzK6WC8Hq4Fn3tv5ZM/84TCA1o5OtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0j/JSY8BaEmqHeLzzSuUnqixbDq+hPeZCqdiWhMBqQw=;
 b=BZpsRtn+OjIyc2CYsWWp5MlENCd1RtlQgWX9gpf8w8epT2zRwXeSFj06csNb0Zjr7PJ6xCuXqvCOatDLbpn6oKmTkqCVyeFOlystwWgHzlATiI73ZE/0CyUL5QDa2GteIjztwlTzUmUAUlSXH3++w0c+zqtHNwmALtakoi56IoIpFkUYMZoDXRfkw+la1t2COl00jvIooJY8z82r/r0t8OVqZkqdnjpttwu0fiT8MULlyfDBKGzUcqThQ//+gXQj2zwu4fwyCth4aNC//2O2q79BAx7a3MisYKAWIHXyhIC2+1PEYoYeDclB65zyQB1oQJIdtu6jVnF1EGYz8uhC9A==
Received: from BL0PR0102CA0056.prod.exchangelabs.com (2603:10b6:208:25::33) by
 DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.21; Mon, 25 Aug 2025 07:15:12 +0000
Received: from CH1PEPF0000AD7F.namprd04.prod.outlook.com
 (2603:10b6:208:25:cafe::3b) by BL0PR0102CA0056.outlook.office365.com
 (2603:10b6:208:25::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.20 via Frontend Transport; Mon,
 25 Aug 2025 07:14:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH1PEPF0000AD7F.mail.protection.outlook.com (10.167.244.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Mon, 25 Aug 2025 07:15:11 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 25 Aug
 2025 00:14:57 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 25 Aug 2025 00:14:56 -0700
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 25 Aug 2025 00:14:54 -0700
From: Shani Peretz <shperetz@nvidia.com>
To: <dev@dpdk.org>
CC: <stephen@networkplumber.org>, Shani Peretz <shperetz@nvidia.com>,
 <stable@dpdk.org>, Kai Ji <kai.ji@intel.com>, Declan Doherty
 <declan.doherty@intel.com>, Marcin Kerlin <marcinx.kerlin@intel.com>,
 Slawomir Mrozowicz <slawomirx.mrozowicz@intel.com>, Michal Kobylinski
 <michalx.kobylinski@intel.com>, Piotr Azarewicz <piotr.azarewicz@intel.com>
Subject: [PATCH v2] app/crypto-perf: fix plaintext size exceeds buffer size
Date: Mon, 25 Aug 2025 10:14:50 +0300
Message-ID: <20250825071450.25314-1-shperetz@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250805063800.225231-1-shperetz@nvidia.com>
References: <20250805063800.225231-1-shperetz@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7F:EE_|DM6PR12MB4250:EE_
X-MS-Office365-Filtering-Correlation-Id: 34cbe90b-0934-4884-ba83-08dde3a7213a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OMh9bnI9El2cBGHWsjH6WSTRI+hNDzNAEgEgGnHovYl/9d3OX2uH+Or2nk7a?=
 =?us-ascii?Q?ZMfYimIMotR9XtBmuCkYB90jmYMi2s+YltXZ3CeqrEQByufzHRvqWyTSGypG?=
 =?us-ascii?Q?Lmq+TLbMI2QBv9YgsIYX6N7LJYMFgoGMUEplZSE9OsjdzfO5MCl0sZHNDT49?=
 =?us-ascii?Q?cOe3XmNUC9MrcI2uEpFi0kp98usK4k0Kd1wbSKOoNfA/GZVHoRR8Q9qBl0tV?=
 =?us-ascii?Q?1KPmgGzM2gwj0v57x4cVb+VY1luFxiwkxmuM9FtOqzC3CJ9vKSIG21ZLyTwQ?=
 =?us-ascii?Q?mpkQsTYoeHmTlcpUWPp/sD3fvBGiyQd1KJztb7e8H8TZgrJI4xKke3FpBI9p?=
 =?us-ascii?Q?K1QHbYeyvQNdCKgMo4dW9KpwSYwE3SYc1q+FiPwDJm4pV31YyqJPI0UaUHs7?=
 =?us-ascii?Q?vnDnCsIn4b1Vy5x/o1y3ZyO+KVtxGXbFnSLuOdVjPrW8c4V6UnbxIEZm8J0/?=
 =?us-ascii?Q?WmE2BpQCfPncsXB4gMd99eBL4A2n0LNxdGiBHL4y3W3epVWiDejoSoKZAiqq?=
 =?us-ascii?Q?QFORY+c6NoFukPa68XeXsxQyF+r2OukhK3LZa7d87EY6M5je42hfoqho5prL?=
 =?us-ascii?Q?bC87jywWMPk73YzaR1OdRf+Ud/+cRaegQSXrV6ogSkINSu+6LUziNsNbNOjL?=
 =?us-ascii?Q?Af0MxtQaP1seIZ8i8nDxDFIHiTaB6rqrIjfACFm0FlkwvnH7CvkL39kz6nIO?=
 =?us-ascii?Q?gQLJhzh7isrYrgZahHNm8UaBDq5XH+4DOUEzlRHP+Akce1qWw83WRr/7g6r6?=
 =?us-ascii?Q?lzIe+cZB3IsNdRpmIC82PU9vVEmEDjdooe+0AYUdUasXNCeWo+Syo19vM7EM?=
 =?us-ascii?Q?doCXv2nwaNI8uAbzn5RUvsIV2k6UO99PFIn/gt/vMLZhHVmzfp7hR66aXpkt?=
 =?us-ascii?Q?6+tIYUjpvaftm0RNimaQYGIk77IESiZfvaBZNXB6OsEnQDQie8Wupbmv6HFD?=
 =?us-ascii?Q?fE6UEGAxxJpDL/N9wI4YczGRlLekDmD330xc3LkfD1NmMlX7shn00WDp0uvp?=
 =?us-ascii?Q?uw/dBunKshDWrkRptZbna8zvxWWZkFT9uQOiFn35Sz0TJ9NuyOkHZKlvdDK+?=
 =?us-ascii?Q?Kh61euFir7G9ev+AgrgqnZsyGS8r9wp1w6AehlFQM+8KdpYJCe65OElETCjE?=
 =?us-ascii?Q?asnO6L06m/YH/J3gcX0nCtZOeq4NjBIjUXneCiB3V9AndobrimIvYzMzQ093?=
 =?us-ascii?Q?E9lwDHCrUWBrq6g4zjYTsF2akVupdHjDL5d9meuYO7qaH8sT2mHHE1y/qxsR?=
 =?us-ascii?Q?EAGfkgB8LxfbbKIQJUx7+48iFFJNOEv1Oqm7IuaSxwYqJqTzdJt2wNHrZVej?=
 =?us-ascii?Q?4pKYR0RBOgk3i1eiXoABw1luzaUBPXZPlZpgnxoX7OvCKvvCO3h4NBRXM0oY?=
 =?us-ascii?Q?+EwG+HOgZTm3c0yHXcXNbC+DaSI3BjY60hdo19SawcCakcPqDnDe5dUr+CDk?=
 =?us-ascii?Q?54AI6kxsCwPhucjhmp6IuuQn0WtaXLmD9n/VCOFcOyfYOIaj3so4pwcVIwyq?=
 =?us-ascii?Q?jd2A+tmWfyASWW9FPxvV7ynYGiAmJ1JlK1Tx?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 07:15:11.1588 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34cbe90b-0934-4884-ba83-08dde3a7213a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4250
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

When test vector plaintext exceeds buffer size, only the first
max_buffer_size bytes are processed, causing incorrect digest
verification (computed vs expected mismatch).

This patch fixes this issue by checking that the plaintext size is
larger than the buffer size and returns an error with a log.

Fixes: f8be1786b1b8 ("app/crypto-perf: introduce performance test application")
Cc: stable@dpdk.org

Signed-off-by: Shani Peretz <shperetz@nvidia.com>

------------------
v2: added sizes to the log

---
 .../cperf_test_vector_parsing.c               | 47 +++++++++++--------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/app/test-crypto-perf/cperf_test_vector_parsing.c b/app/test-crypto-perf/cperf_test_vector_parsing.c
index 737d61d4af..5665fb425b 100644
--- a/app/test-crypto-perf/cperf_test_vector_parsing.c
+++ b/app/test-crypto-perf/cperf_test_vector_parsing.c
@@ -308,12 +308,19 @@ parse_entry(char *entry, struct cperf_test_vector *vector,
 	if (strstr(key_token, "plaintext")) {
 		rte_free(vector->plaintext.data);
 		vector->plaintext.data = data;
+
+		if (opts->test == CPERF_TEST_TYPE_VERIFY && data_length > opts->max_buffer_size) {
+			printf("Global plaintext (%u) larger than buffer_sz (%u)\n",
+				data_length, opts->max_buffer_size);
+			return -1;
+		}
+
 		if (tc_found)
 			vector->plaintext.length = data_length;
 		else {
 			if (opts->max_buffer_size > data_length) {
-				printf("Global plaintext shorter than "
-					"buffer_sz\n");
+				printf("Global plaintext (%u) shorter than "
+					"buffer_sz (%u)\n", data_length, opts->max_buffer_size);
 				return -1;
 			}
 			vector->plaintext.length = opts->max_buffer_size;
@@ -326,8 +333,8 @@ parse_entry(char *entry, struct cperf_test_vector *vector,
 			vector->cipher_key.length = data_length;
 		else {
 			if (opts->cipher_key_sz > data_length) {
-				printf("Global cipher_key shorter than "
-					"cipher_key_sz\n");
+				printf("Global cipher_key (%u) shorter than "
+					"cipher_key_sz (%u)\n", data_length, opts->cipher_key_sz);
 				return -1;
 			}
 			vector->cipher_key.length = opts->cipher_key_sz;
@@ -340,8 +347,8 @@ parse_entry(char *entry, struct cperf_test_vector *vector,
 			vector->auth_key.length = data_length;
 		else {
 			if (opts->auth_key_sz > data_length) {
-				printf("Global auth_key shorter than "
-					"auth_key_sz\n");
+				printf("Global auth_key (%u) shorter than "
+					"auth_key_sz (%u)\n", data_length, opts->auth_key_sz);
 				return -1;
 			}
 			vector->auth_key.length = opts->auth_key_sz;
@@ -354,8 +361,8 @@ parse_entry(char *entry, struct cperf_test_vector *vector,
 			vector->aead_key.length = data_length;
 		else {
 			if (opts->aead_key_sz > data_length) {
-				printf("Global aead_key shorter than "
-					"aead_key_sz\n");
+				printf("Global aead_key (%u) shorter than "
+					"aead_key_sz (%u)\n", data_length, opts->aead_key_sz);
 				return -1;
 			}
 			vector->aead_key.length = opts->aead_key_sz;
@@ -368,8 +375,8 @@ parse_entry(char *entry, struct cperf_test_vector *vector,
 			vector->cipher_iv.length = data_length;
 		else {
 			if (opts->cipher_iv_sz > data_length) {
-				printf("Global cipher iv shorter than "
-					"cipher_iv_sz\n");
+				printf("Global cipher iv (%u) shorter than "
+					"cipher_iv_sz (%u)\n", data_length, opts->cipher_iv_sz);
 				return -1;
 			}
 			vector->cipher_iv.length = opts->cipher_iv_sz;
@@ -382,8 +389,8 @@ parse_entry(char *entry, struct cperf_test_vector *vector,
 			vector->auth_iv.length = data_length;
 		else {
 			if (opts->auth_iv_sz > data_length) {
-				printf("Global auth iv shorter than "
-					"auth_iv_sz\n");
+				printf("Global auth iv (%u) shorter than "
+					"auth_iv_sz (%u)\n", data_length, opts->auth_iv_sz);
 				return -1;
 			}
 			vector->auth_iv.length = opts->auth_iv_sz;
@@ -396,8 +403,8 @@ parse_entry(char *entry, struct cperf_test_vector *vector,
 			vector->aead_iv.length = data_length;
 		else {
 			if (opts->aead_iv_sz > data_length) {
-				printf("Global aead iv shorter than "
-					"aead_iv_sz\n");
+				printf("Global aead iv (%u) shorter than "
+					"aead_iv_sz (%u)\n", data_length, opts->aead_iv_sz);
 				return -1;
 			}
 			vector->aead_iv.length = opts->aead_iv_sz;
@@ -410,8 +417,8 @@ parse_entry(char *entry, struct cperf_test_vector *vector,
 			vector->ciphertext.length = data_length;
 		else {
 			if (opts->max_buffer_size > data_length) {
-				printf("Global ciphertext shorter than "
-					"buffer_sz\n");
+				printf("Global ciphertext (%u) shorter than "
+					"buffer_sz (%u)\n", data_length, opts->max_buffer_size);
 				return -1;
 			}
 			vector->ciphertext.length = opts->max_buffer_size;
@@ -425,8 +432,8 @@ parse_entry(char *entry, struct cperf_test_vector *vector,
 			vector->aad.length = data_length;
 		else {
 			if (opts->aead_aad_sz > data_length) {
-				printf("Global aad shorter than "
-					"aead_aad_sz\n");
+				printf("Global aad (%u) shorter than "
+					"aead_aad_sz (%u)\n", data_length, opts->aead_aad_sz);
 				return -1;
 			}
 			vector->aad.length = opts->aead_aad_sz;
@@ -441,8 +448,8 @@ parse_entry(char *entry, struct cperf_test_vector *vector,
 			vector->digest.length = data_length;
 		else {
 			if (opts->digest_sz > data_length) {
-				printf("Global digest shorter than "
-					"digest_sz\n");
+				printf("Global digest (%u) shorter than "
+					"digest_sz (%u)\n", data_length, opts->digest_sz);
 				return -1;
 			}
 			vector->digest.length = opts->digest_sz;
-- 
2.34.1

