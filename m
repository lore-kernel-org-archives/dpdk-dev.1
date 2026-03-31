Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E861FF60C4
	for <dpdk-dev@archiver.kernel.org>; Tue, 31 Mar 2026 04:10:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 78E5240285;
	Tue, 31 Mar 2026 06:10:16 +0200 (CEST)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010007.outbound.protection.outlook.com
 [40.93.198.7]) by mails.dpdk.org (Postfix) with ESMTP id D8CA04025E
 for <dev@dpdk.org>; Tue, 31 Mar 2026 06:10:14 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FX54tOSLYugwOOVPrUM33CTMhrpkTKRzGT4WTwCKtplK+WFHkT89bDYty9xnQsCQBGL0o6l3fVzZXiSdMcwBQeVg9pFM5loA1Ab/2bONCbjJX45Sh4T3cfbBcbZyneOjwf4kHfX3+FSoRvDU0VBx7xgjaQVSsrNfPSJ6V5btAJnRLcCb31G7HJGxFbx0rFubhm0A7IgKIBrqV4jG6AJTBJr7ad/4x6LCiQlF/aLPyv3+qR9hsCjOi3kbvTGH9EpngQpIB7Al2mUGYLqdiGKwXWRBERTpSS8TsCDqGWnQ6lrrB+IRFiELbXVtns9uDamE6Ld5BDO0K+zARcDGC+R/xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cG0eNtIXDY3BN1/XGuFekNpplabwIg+hGFhY04yk3TQ=;
 b=YevjrEj7uBkwQRWlC/ZzVx4pq9lW63MJxwejC8ptPoaVI6qo6wqw9cALD/DhKUJlgEe3yfz2+mGWFRbFbLn4a/0/EH8ybii8PtWG4GvzbbNfiEkMIv2ArFtpHoVNH8x9mJ9/RsLmu4AbAUE+jUz2CLXoNekygZOPbMa7MbqRYU0G2af+/bfM+yiw7Usuuxx6YY8A3IvpCkme7bOr4+bY4JkrtieDsl877z/eLmFFmjyQXY9BLTXa24OUwAneswjS44cfLc6xWhRBMWsZ+/tSGeRE82z3n+mxrk0DBOfSv0ljiAiyzPpEUzgK7e8Kw8nA3xo63necD7KmB1wLwtPJ4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cG0eNtIXDY3BN1/XGuFekNpplabwIg+hGFhY04yk3TQ=;
 b=3wZGDmLN+EqB+ZWHY5dBiUqKwaP6ndE5QOJM/ZAZweyCbykNW35NqgJM0tf20HgN4PD1tgqW8MGHIIWvEJHbVbKxhopOxRiplDTRcrXJtX0QxeDf0vpSLOiNmfKIpCaj/2zS7GrpJfYdLljj0rhk18OPSzMadr2gz0G3FfOqHEk=
Received: from SJ0PR13CA0119.namprd13.prod.outlook.com (2603:10b6:a03:2c5::34)
 by IA1PR12MB9465.namprd12.prod.outlook.com (2603:10b6:208:593::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.14; Tue, 31 Mar
 2026 04:10:12 +0000
Received: from SJ1PEPF000026C6.namprd04.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::99) by SJ0PR13CA0119.outlook.office365.com
 (2603:10b6:a03:2c5::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.15 via Frontend Transport; Tue,
 31 Mar 2026 04:10:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C6.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Tue, 31 Mar 2026 04:10:11 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 30 Mar
 2026 23:10:11 -0500
Received: from epycpwr02.amd.com (10.180.168.240) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 30 Mar
 2026 23:10:10 -0500
From: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
To: <dev@dpdk.org>
CC: Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH] power/amd_uncore: detect esmi lib64 using pkgconfig
Date: Tue, 31 Mar 2026 04:09:58 +0000
Message-ID: <20260331040958.126869-1-sivaprasad.tummala@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb10.amd.com
 (10.181.42.219)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C6:EE_|IA1PR12MB9465:EE_
X-MS-Office365-Filtering-Correlation-Id: f07d31bc-91f9-4032-c012-08de8edb675b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: Dii5NmDHq1YbYK9JczM3jiI5sX+Y1U74F+qiKbAnoaXqk63/It1YBycsMh4FlVjFnjrE2pobZOXF84lXUQIFkhoozbLM1XLH1V0mbRI1l4cYTw1YhH4XXHRuFsE+FsiB8JtUqA6/A38Fe6zBGhEmHQ24XobGaXdm3z4PYLX2nJuribb8GINwRr4Bc5ezqBngO1HWC50+LIy8rUKBoed1q3nTFQXcle/asmfCv+Ro+jW9JE2MMXZ5qAxQ+QbelmHEhO/sKtGCjKZNHRPiN9lNBOkNQbKEXenEHYFKYcH7qk6iO0EeW3M5sxDzDH0gOfo0JLPwDZkAgcstWq7UePPt8tbU+ziQxk35QcdLlaSGqwl+wB+NO8j+OyKdcls/7aTKfI8F7AGAjholJ1+O30qM/yYUGr+Bn/sWovlIouwV4uC5YUaTggWem51VMhPTFfAYjF2sqoTfEuUB/62/FDEtLrRdgA9ihiXLXQeDQeaSOC7oSPHrWVbQw4lvStFa3mitMh8D5wL3PNCke/8xQf4OkvTPIbehjRGtz6YigO6oMU7rB2SoBeXTzuERinUggxM4tPzb4kcF+E7qvZjWpRN4hM188fJwWAZ10rdKwBnXeG6UKDnc87HFBs/BA7FC40g/0AZkLPaA4mDinXvHvj+yx6fQKYq0eXi3kAnl7M9N9nWlYovzd5v/afrfhGqqxHEG7tB11iTOtUyJ501Jd6kcPXEmv4Cq/3fVU1G7fOA2odKmpgqwp8MOhCJkg67zuodOwfBAtse0I+8l5lwp3/iJkA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: U0/UiaDGnK6waedxvEmK2ak0uuzfvUy/Lvolsaj90F3JOFp7Hsfzy4BK2py+0wCWAwp+YDPu4o7oFG/GpYAn1pgwdzS7+X9K+Q4egWCOzJMSBgyyqgzr/5/q5IgYdE7gf2l6mVpsXO1yO0ffXZW8CsiNIJ/Pr8hcyofJqognbm3ugpQiMknduFDbHcHFikk9qlnpNZcx9Pa65TdRNSBH6PYtzOFyOaHaB/RgMGHnLulEs7Bgi09zQqtHF8Bx49PupXXN1Ic4vB8TgIzrujEfe00KjemhEskFVGVV4YCRPtGYnFNkgIzqitaq/PP4IDesVDhZgYr32AQq1xSKTzSGVidJBAe09jq+TWboe1r0KzTvZujgZzKHNGUnE9vrcmBa2ICc93c8OlzX7SwXLDPiMiSLIDFORZ3x/Pk9WOUu4hSeGCxN4JH/FtiATQ2HbDoy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 04:10:11.5394 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f07d31bc-91f9-4032-c012-08de8edb675b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9465
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

Replace manual detection of e_smi_lib64 library from find_library() with
dependency() via pkg-config in meson.

Meson find_library() API may select incompatible libraries,
requiring additional checks. Using pkg-config avoids this
by providing correct build flags via .pc files.

Signed-off-by: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
---
 drivers/power/amd_uncore/meson.build | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/power/amd_uncore/meson.build b/drivers/power/amd_uncore/meson.build
index cab260b64e..378eb72e50 100644
--- a/drivers/power/amd_uncore/meson.build
+++ b/drivers/power/amd_uncore/meson.build
@@ -7,14 +7,12 @@ if not is_linux
     subdir_done()
 endif
 
-ESMI_header = '#include<e_smi/e_smi.h>'
-lib = cc.find_library('e_smi64', required: false)
-if not lib.found() or not cc.links(min_c_code, dependencies: lib)
+dep = dependency('e_smi_lib64', required: false, method: 'pkg-config')
+if not dep.found()
     build = false
-    reason = 'missing dependency, "libe_smi"'
-else
-    ext_deps += lib
+    reason = 'missing dependency, "e_smi_lib64"'
+    subdir_done()
 endif
-
 sources = files('amd_uncore.c')
+ext_deps += dep
 deps += ['power']
-- 
2.43.0

