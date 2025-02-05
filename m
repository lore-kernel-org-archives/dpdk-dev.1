Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58EADC02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 10:48:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B347A40DCE;
	Wed,  5 Feb 2025 11:46:34 +0100 (CET)
Received: from egress-ip11a.ess.de.barracuda.com
 (egress-ip11a.ess.de.barracuda.com [18.184.203.234])
 by mails.dpdk.org (Postfix) with ESMTP id 5187B4069F
 for <dev@dpdk.org>; Wed,  5 Feb 2025 11:46:23 +0100 (CET)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03lp2108.outbound.protection.outlook.com [104.47.30.108]) by
 mx-outbound9-60.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 05 Feb 2025 10:46:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZyOM3y4pTXIgcCO/29EOo2p7iOk0mFCruTKwXQYAOdHeW21u6YWWPwL6piNnbtDhhmYMDFqSa9xF+BzLBjhB3CWX3F1cJpV8qP7fxau3RzUNPAxZV8egD2uxK9Zci0FyUejcXA7usAPNrQOK0a99n3nYk+m71nSU44Bbk388sHKELrzsX9NNJgPyYxUeKwVtDwfMdWUA0k5k6U/8XsU+yLSk7yL4vFBrLJ3Qknsr+9gEWb3gUm5IE92BqRHmDB4v5aZm3ELuOAq50mrOz9Gc7UqKKojLL0NiV4NwMO4zbrIjKf+fH3bYsdVftytlvvzZg3QL81KZjoVefbvB8dQM3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XG0jMfQh/DWx1b53rlN7LGLeXBBmH9xldmz+tbA9+iY=;
 b=U32drq1cEXkpcqOMZbRbqvuIaYCMO5LzJuVBIi1sYuGlK+Q90oO6j4zPgzOKsEu6C0fYXfwUlINjEs+A0Bw/U/WZ/pURdJz/N2HRE0BHNRVR0zuA9QWZfE7iHl/fP9U7L6+8P6/SSQrOolVsZyW1XhKNvUbZs4Ienf8bf94+F7cKyqxTVqe5BZ7XDIwktKPd6tHQC5xbsilU75fGP2BQBsWJ1jOy0N8J/F9Q2ectfNcfHuvH3eJKLmdX2lXVVi5yfDm2aG9u5ZID/MwjsiuuyuTVK+zJ9CQZixVI8XDoF77C8bf0zwy6lgq5xe+EEDq3H+zyuvRRD1uPMyW1EtdVuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XG0jMfQh/DWx1b53rlN7LGLeXBBmH9xldmz+tbA9+iY=;
 b=VrxmviB5k/wKphHs/K+GwTE8OmTYL1e3c/Q8xg39VEg3bop1vAQzUuX457MNNtGfXosumkxNyzBHSQqPxjcIZrLwJ2BgV1uJVg3oOmih67irhsbS6w7tM2utNfy743jh3THKjWJHR2+tmWldWImzHRaEgarWMWrN5/mzKcZ2eMM=
Received: from CWLP265CA0340.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5a::16)
 by DB9P190MB1273.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:22f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Wed, 5 Feb
 2025 10:46:20 +0000
Received: from AMS0EPF000001A5.eurprd05.prod.outlook.com
 (2603:10a6:401:5a:cafe::8e) by CWLP265CA0340.outlook.office365.com
 (2603:10a6:401:5a::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.27 via Frontend Transport; Wed,
 5 Feb 2025 10:46:20 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AMS0EPF000001A5.mail.protection.outlook.com (10.167.16.232) with Microsoft
 SMTP Server id 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 10:46:20
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v2 26/34] net/ntnic: fix age timeout recalculation into fpga
 unit
Date: Wed,  5 Feb 2025 11:45:35 +0100
Message-ID: <20250205104548.1533554-27-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250205104548.1533554-1-sil-plv@napatech.com>
References: <20250121170814.3252171-2-sil-plv@napatech.com>
 <20250205104548.1533554-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A5:EE_|DB9P190MB1273:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 61fdeac3-2a77-432c-17f4-08dd45d2538b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qbgpdd+dM0rgYKYZ9RLvqQeYtXXcQRarb/p1NParCujomKCtBs4lf2vMgy0e?=
 =?us-ascii?Q?NUDnxKe1p1GxMrjeAOYB8u9ss5TXY6+OOZ9UQCvDR0u5mUjiSrzn3zvvZAHJ?=
 =?us-ascii?Q?7Xhz9O24mYEoWWtbxj6yQWedW13o5x79X6pzjgm/sCM70Qai9I4P7ARKEGaV?=
 =?us-ascii?Q?xcz+M1A57Nn8rZ/qxtMX6Vs7rel8NI8qhrcu8IY6Ddc3mTwOCnBb8cIk39OU?=
 =?us-ascii?Q?FODPhCH9TXWvkyQPhoEVKf1e1hVdMjEUiLUPbMHOwGHOO+V8qIV0+LU5YqUc?=
 =?us-ascii?Q?AwoOOhvpfGAe6Uj1H1PnhVebXbsTMGyVUgA5R+zUYNXyYlHIViBAuLH3/+vo?=
 =?us-ascii?Q?vHFlY4rs3AiQGbQZivwM0Nbukl6EqVXp79SdFgVfUdcLW2oSjTTiLzXSoypN?=
 =?us-ascii?Q?O1MYW38E4pWqYhMqUcXMZgCwQXGrjMRYzCm0m0x67HZMUrBcoOaYDhWWoYNW?=
 =?us-ascii?Q?rzNShxT8I8a4diYz9WV8MqEgUPMQTb3YlJFUNUFwRHa7wSFNDxNdiTPAUtNV?=
 =?us-ascii?Q?t9ezAFyNirAbDo2xEf4pNnKvD2sJhKEREAizUknskBywYy74Tz5LzxtiMItb?=
 =?us-ascii?Q?ntK5RgSxCEiRsGznSpb0mHCWJbPnaDRuzdbqMvc96lgYTM65OS5eZnK/t65P?=
 =?us-ascii?Q?lZqKB0sOXf4PahFPu+a0yDgddPNdQxZIAGGm+Hp15s0nBG7gkotyh4eYKsfe?=
 =?us-ascii?Q?9c3TZp+RYklxBwq1JsbdhV7uilfE0mS4vGNzLrCAvi7my8/IU/CuuVuhozEO?=
 =?us-ascii?Q?x243oQoWx4eknsGTCFbOw1D6fge8DSIjx6UPrgGjjIXlZH9Zy5/HIPG0pGCp?=
 =?us-ascii?Q?Sr35uM4Rd8mf2qo7PY8qhRMzZ9+wI/daNtf4mSaBUk06/t7lroZFR3gYaGSq?=
 =?us-ascii?Q?uVhJU4+mDLVE9caovGgGrdmMp9gZWNLSZ31te54blwFV9J7mVRUtA6vWKAEh?=
 =?us-ascii?Q?vjt1a7ASyAXu4TJrvsd8vyW7WLLQoVHRjYvyaggQKI4z8xWGIlGVmLTbGpUt?=
 =?us-ascii?Q?dapFnGixKbM467iuRLcgZcJsOpIrUWHbH0mmmtmeCTfIy/wC5RgXWHWCkoqx?=
 =?us-ascii?Q?LQI4FOd5XB9mFhnaHlInaUYFL7avBQd0rI3EMOvPtYqrjPbJZF7nQKi3QReg?=
 =?us-ascii?Q?javnwULBuoYIZ930gldUo0cAbl3JvLJvObCIR7b/0ryaYqiR3Jjm1ZjJyDN+?=
 =?us-ascii?Q?uvoXjDOtsXgUsa0pxyG9saRBkFRMWQ3izN67QfO0ew0x1Ga3QduxyB+A0SmH?=
 =?us-ascii?Q?tS44MK+w7bBmrx/43U/nWD1L7WE2rXgIJ+0fZY5jd5zmY4nQlI3JaxrEnAOM?=
 =?us-ascii?Q?Y1yB+3XJPFGRyGd/XGsUFNYvRj5CXRiyvr2TMP/IzPuRd83vXtpgi7EWnJKM?=
 =?us-ascii?Q?izjUtcGNq9kPTVrQUQUbs8Q7jBcHf1jFE8eHem9R3l3nGpdM0Rr/r/5CRnmI?=
 =?us-ascii?Q?NN6URpkhGtIGEa3z9TPoJlPaU6qtbdyNmG5wElpbJTWnN4Uxh/w0VYBqcPQJ?=
 =?us-ascii?Q?lVjW87HcTalX5us=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: aWLDwBFy71JJObIPDGfVUVF55JKZkU3n2W8t3zhQ00a7gEPif1knFr0ryd1MZNGgRDGpOBC3TnGAQ5xtOC5zzWOJ88sSPaDeVmfJwKKoKMLfGmo1qdb+WUnFjaimc1c/mzjM4vB2NgvmV7fV2B+yZRfxzwvNI4GaFpeqHmOZgDuqpt9ayl5KXS3K3wF1PL2bI802X/upB1ZYMrXXlhjzAW0j1oJO9zFP7mVV0idQ32GNLNdy950SIa4ttd/bCmcrU+T1q715x8gYDo4taJUPu3p7HmxhuY2pULtey+TG5Ik0wCR+ioR6E1rUBOK6DEtLCQlWDDPDmfwXfw9ai0QZSZMTKrlYCOb9X4YIce7o8lAJ6R3OatQnfpx5Wu89xYWMBohFO1G+DWi7W7po1iohD8IzNrO+CHpazG+CvKc8NmoJ5yHPrbiygGiSC90EQiJz/HD2n1tp+3B7QgeAABrkt1L3WRqEX63Mzewcjp5xBcbBhKInlR/5c/wZo3lpWi1zfOQqbN1zqNJtxl+oCD6iNXYTpIwrqcAusMLFQLeyO7oYhYdmDaJBiRc4qZE3JtrctQEngTwzCQRANJdQwT02uQ5HaqOf/HxevJ3mwD1bJt1S5/R87lN5QLCjH+wWc1W4S42wBcSvQUUZ8a23NiMR5A==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 10:46:20.2145 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61fdeac3-2a77-432c-17f4-08dd45d2538b
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A5.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P190MB1273
X-BESS-ID: 1738752381-302364-7584-675-1
X-BESS-VER: 2019.1_20250203.2302
X-BESS-Apparent-Source-IP: 104.47.30.108
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkYGJoZAVgZQ0DjJ0sTIEAjNki
 0NklMMLMyNk8wMDA1NDAxNUswtU5VqYwG0A2rUQQAAAA==
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.262304 [from 
 cloudscan16-182.eu-central-1b.ess.aws.cudaops.com]
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------
 0.50 BSF_RULE7568M          META: Custom Rule 7568M 
 0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS113687 scores of
 KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
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

From: Danylo Vodopianov <dvo-plv@napatech.com>

The FPGA scrub T parameter shall be encoded timeout using internal unit,
which is measured in 2^30 nanoseconds. It is approx 1.074 times longer
than age timeout specified in seconds. Internal method
hw_mod_flm_inf_sta_data_update_get() was updated to perform conversion
between age time and internal FPGA scrub T time unit.

Fixes: c0d44442b831 ("net/ntnic: add flow aging event")

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 .../net/ntnic/nthw/flow_api/hw_mod/hw_mod_flm.c    | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_flm.c b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_flm.c
index 14dd95a150..5cf8264909 100644
--- a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_flm.c
+++ b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_flm.c
@@ -969,16 +969,22 @@ int hw_mod_flm_inf_sta_data_update_get(struct flow_api_backend_s *be, enum hw_fl
  *
  * (T[7:3] != 0) ? ((8 + T[2:0]) shift-left (T[7:3] - 1)) : T[2:0]
  *
- * The maximum allowed value is 0xEF (127 years).
+ * The maximum allowed value is 0xEF (137 years).
  *
  * Note that this represents a lower bound on the timeout, depending on the flow
  * scanner interval and overall load, the timeout can be substantially longer.
  */
 uint32_t hw_mod_flm_scrub_timeout_decode(uint32_t t_enc)
 {
-	uint8_t t_bits_2_0 = t_enc & 0x07;
-	uint8_t t_bits_7_3 = (t_enc >> 3) & 0x1F;
-	return t_bits_7_3 != 0 ? ((8 + t_bits_2_0) << (t_bits_7_3 - 1)) : t_bits_2_0;
+	uint32_t t_bits_2_0 = t_enc & 0x07;
+	uint32_t t_bits_7_3 = (t_enc >> 3) & 0x1F;
+	uint32_t t_dec = t_bits_7_3 != 0 ? ((8U + t_bits_2_0) << (t_bits_7_3 - 1U))
+		: t_bits_2_0;
+	/* convert internal FPGA scrub time unit into seconds, i.e. 2^30/1e9 is
+	 * approx 1.074 sec per internal unit
+	 */
+	uint64_t t_sec = (uint64_t)t_dec * 1074UL / 1000UL;
+	return t_sec > UINT32_MAX ? UINT32_MAX : (uint32_t)t_sec;
 }
 
 uint32_t hw_mod_flm_scrub_timeout_encode(uint32_t t)
-- 
2.45.0

