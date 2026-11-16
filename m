Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D84606A339
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Nov 2026 11:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=WZkvOq0X
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D41B402B9;
	Mon, 16 Nov 2026 12:27:47 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012028.outbound.protection.outlook.com
 [40.93.195.28])
 by mails.dpdk.org (Postfix) with ESMTPS id 07972400EF;
 Mon, 16 Nov 2026 12:27:44 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NVXo42sB17itthq6bqs2Eaw6+bIwLo+6/ELv/9ZsBzsDbybtqqspLWKS+FMoozshUHAVVQhlqmV8bwABo+EuZKUmXzzimgAjWl0gxuIyZqLUItdfWVMU9xbR5jt2Vk/0fYl3HDsYAFeUN6Ff3RVZQi07nQDPEQyEtIve5OtP/DamKepmllHC1FXL/km09AiT9AWwrpnJ2kkSHmnycOUO6U6vSWXF90KXRlABO3XnXtdPGPcfRyYyvdjjeJ0C4eOL5BSj0LMoC3bcnWFmG4AmmVDTWaluCO30nMaF3JbGZ/4O2Iaw5VEFbYa8bf9qnuF9t9ViLYH7Zx3x9wXdCXZshA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XIArLBv54FnxsdjFD+qaEOCi6JSKSamxmSX4lPyQYe4=;
 b=nl57JSMYNhVVFhpLE1HvcW+zz5I5QFtzOYbvkAUsdNF0kHcR8AEWnEOgbA9vqE6XKYE2Q48uZL8llJcVd7OyHi7c86e0f5S3G2giTCFy1I1k14NLuSRMT3QfuevCPOaA+Hh19StfHvowZZ0iTbvj8ZGPBZgrcRZ92qQyzixT1CJmLQ1npzY6xXY0pGHEUJRTXsBHmWW4wIXooQug8QrEvbj9i4qxS1+LvDzHB0Kmqz1tiIpEeGVi4aXXmIcKxvzWzpM8jyUz+rGT6XcFUYdGnCeuHSAHxWGQChCavo4/GC3xOErVElS27AvCWAgqfRh5Ti4BYShjlFASOgCvSe4Lag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XIArLBv54FnxsdjFD+qaEOCi6JSKSamxmSX4lPyQYe4=;
 b=WZkvOq0XFPkQ9YNznSa6Va7JtrsnazPwe/4GcZyrVFZgPKS8Rj+R9/9FdQU4aIfji/AnqWFyApfMdaBn+BljeYjngGlsZj9vIr/2e9C2ofBzDdD0vvmh2oh6Mzg/76RKIXae4oi6aZBU6GaF/IqMujJdMT7t9hEGybFrrrl7qk29E5RQAQQRRji7Y83tX96/Klo5FA+niSrJAjYkoLkWnH2SpaP+0IxBnMd0PSODNL3u5N3DkJQz76PY0YYTwzyNfiPSlA1C2SNiDBo+nl/W3h7UZL7eb/mrbSCWQyDFRHl+M+m2+VB/d/EctNGXpuTW2JowXIa5QtbB+xOyTaEwzA==
Received: from DM6PR02CA0150.namprd02.prod.outlook.com (2603:10b6:5:332::17)
 by CY1PR12MB9582.namprd12.prod.outlook.com (2603:10b6:930:fe::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 11:26:39 +0000
Received: from DS4PEPF000001C4.namprd21.prod.outlook.com
 (2603:10b6:5:332:cafe::1c) by DM6PR02CA0150.outlook.office365.com
 (2603:10b6:5:332::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Mon,
 16 Nov 2026 11:26:39 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS4PEPF000001C4.mail.protection.outlook.com (10.167.23.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.0 via Frontend Transport; Mon, 16 Nov 2026 11:26:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 16 Nov
 2026 03:26:23 -0800
Received: from mec01vdimballas01.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 16 Nov 2026 03:26:21 -0800
From: Mujahed Mohammed <mballas@nvidia.com>
To: <dev@dpdk.org>
CC: Mujahed Mohammed <mballas@nvidia.com>, <stable@dpdk.org>, Thomas Monjalon
 <thomas@monjalon.net>, Aman Singh <aman.deep.singh@intel.com>, "Viacheslav
 Ovsiienko" <viacheslavo@nvidia.com>
Subject: [PATCH v2] app/testpmd: avoid mbuf pool memzone name collision
Date: Mon, 16 Nov 2026 13:25:53 +0200
Message-ID: <20261116112556.535445-1-mballas@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <LV3PR12MB914444BAE4DA3B85B4179A4AD47D2@LV3PR12MB9144.namprd12.prod.outlook.com>
References: <LV3PR12MB914444BAE4DA3B85B4179A4AD47D2@LV3PR12MB9144.namprd12.prod.outlook.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PEPF000001C4:EE_|CY1PR12MB9582:EE_
X-MS-Office365-Filtering-Correlation-Id: c3c8fe7b-fa4b-4b37-ee49-08df43d47b82
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|18002099003|22082099003|11063799006|56012099006|10067099003|261102123227099003|261028144727099003|261026140227099003|261021123027099003|261022105027099003|261021121427099003|261022075727099003;
X-Microsoft-Antispam-Message-Info: tBErFFxvmmPl6E+pttHzpSbx+OF0gLma+3c86rNTpWmwjQTgzwJw8nsLrEaPLWddLWtLR3pleqYsxgU/Ejgtc2CbgYj1soCoUy9y6SsHmoX0dQJ/669vvLwNYdEWxY0AZ9nkpJS5ZhV+IRQdbq8rerSWRLq2heLuGfDzKPwWl7NXeT/Q/QGB2cIwQ4SB2MbqpAYiECj1qcENPaNevPp6LU1pgzwaXRfaenKpRrK8OKqpaXH6cPqOvwlIzacaEItiB62GuNLLwFfn1DsO3Z3wkTYMyIvEU7ldsTVLTva7qq7CKjqseAbuc3ZQYyKIklMNkGyyRAqVjFhW6XrdPeam99bbZ0dpZmdGbc++TGPKqayZJNfiUxsik25LKw1D8L7oes5qzdQgQFt2SV/6rx0h5TuNy3a+6SAr+P2djIreQeaczus+IXo09Z72VpEZ8d1IClsoO3Q6ojbaUaH0tkuDFZQG60Pmx6A072VJEOKnGNeavEHUqDAVoHZWfs8TysSho29O2Av9y+fAVg/vGGqWLXD7w7PvyB6+4uFHZjx+qRN0iR6rVUofndXjg9V0qq+9LyIG1e90w+q6N9rJBw3eYFyUQ6cp7GSFJBhDPb3PZOWjd7f43rk+jtrn6ni9EQGC46zJytUZsw5wrCXiXLjZL6H3PTsvsfma3XVs3F8M/l+mn8oYN/xBBvWWIOXf/GcOJTQ+FKM47LRzf3uUMlBSsA==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003)(261102123227099003)(261028144727099003)(261026140227099003)(261021123027099003)(261022105027099003)(261021121427099003)(261022075727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wwmSROnzDdBJVWbfUQvx4C2jME2/Htf5F4tNDdMYAMNP91iuiIHOmHzQCxGkHqXllDUsoX+voTtkyO6Juif4DzMnbmOiLDUPOhBYacS19MtD2MbEEND+xGMcbExGhwoa4S9mwp+L4rPjcq6D+aJUZR5icGxNlBI5uj2aK8FAaMCEVV/QhC60aH3V6fuBE0yABBS7ehYRVPmkeVQWO31oI/jp9I+9psFW/KZygIKHlA/HwIMUi/2Dg45SK/rzvYXHoTRSiWcrzfmyLnvUbR4s4D/sIyARkLTknGVStEqd0xJuI5MV6VVFNtMSFYqFgM/TsvL/dNOZpYHeIbUzBR/R049Q3LYUJ+YovEXHWcjJrgeOGd4NB7HXoFSqYORLf1BD9XU4gbAeHUWB9hlDA5AlVkptfC86yjIKnOMNvxkXGhTBGjkvKdp/i/xpX8Uymm2v
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 11:26:39.3079 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3c8fe7b-fa4b-4b37-ee49-08df43d47b82
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS4PEPF000001C4.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9582
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Additional mbuf pools append a numeric size index to the base pool
name. Mempool backing chunks also append a numeric chunk index. If
the base pool needs multiple chunks, its chunk name can therefore
match the metadata memzone name of an additional pool.

Add an s marker before additional pool size indexes to keep the two
namespaces distinct while retaining the original index-zero pool
name.

Fixes: 26cbb4191e91 ("app/testpmd: add multiple pools per core creation")

Cc: stable@dpdk.org

Signed-off-by: Mujahed Mohammed <mballas@nvidia.com>
---
 .mailmap               | 1 +
 app/test-pmd/testpmd.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index a4af517007..fc7750a006 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1183,6 +1183,7 @@ Morten Brørup <mb@smartsharesystems.com>
 Moti Haimovsky <motih@mellanox.com>
 Muhammad Ahmad <muhammad.ahmad@emumba.com>
 Muhammad Bilal <m.bilal@emumba.com>
+Mujahed Mohammed <mballas@nvidia.com>
 Mukesh Dua <mukesh.dua81@gmail.com>
 Mukul Katiyar <mukul@versa-networks.com>
 Murphy Yang <murphyx.yang@intel.com>
diff --git a/app/test-pmd/testpmd.h b/app/test-pmd/testpmd.h
index 2ca4aaf086..5736e60a57 100644
--- a/app/test-pmd/testpmd.h
+++ b/app/test-pmd/testpmd.h
@@ -893,8 +893,9 @@ mbuf_poolname_build(unsigned int sock_id, char *mp_name,
 		snprintf(mp_name, name_size,
 			 MBUF_POOL_NAME_PFX "_%u", sock_id);
 	else
+		/* Keep pool indexes distinct from mempool chunk suffixes. */
 		snprintf(mp_name, name_size,
-			 MBUF_POOL_NAME_PFX "_%hu_%hu", (uint16_t)sock_id, idx);
+			 MBUF_POOL_NAME_PFX "_%hu_s%hu", (uint16_t)sock_id, idx);
 }
 
 static inline struct rte_mempool *
-- 
2.43.0

