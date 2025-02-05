Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E587C02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 10:48:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C6844064E;
	Wed,  5 Feb 2025 11:46:29 +0100 (CET)
Received: from egress-ip42a.ess.de.barracuda.com
 (egress-ip42a.ess.de.barracuda.com [18.185.115.201])
 by mails.dpdk.org (Postfix) with ESMTP id 853DB4067A
 for <dev@dpdk.org>; Wed,  5 Feb 2025 11:46:18 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03lp2239.outbound.protection.outlook.com [104.47.51.239]) by
 mx-outbound9-60.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 05 Feb 2025 10:46:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qjjmgb6MGtlHdLc+LfHKS80lh6OUcf8fiR/x13nMttVezL4QfpCxISAGgpIdSURL66prRMsE3c1w4UU50mSLu9fENSt7HwgLLIHopK0wRR29TJyGYq4wLdgD+fzdDZexqiiYxGz7mTNHO3Fh9ovYGw2FvPEbltilYjySgmaMNTz23+xxsFiRw9Jx2jVOaXeQ5pK+ZckBFuhcJtmCADcssialLoR/D8Da7gutyPzcjypKlN5G+JU74eZzvbZo8n4OloUE343wVKQY35wE8C6S+7vufsqgNUSOZhjPlya5ad8+sr+bjlF5kOJU3GFgRI32GVOyQA9zX/eK94XYMHpScg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aQLXzW+Psp1yfldVTzAibZM7D+4rBNuVa7ESFPNIR78=;
 b=MIFMEsWdnN+ZUgtHlyfVd63JDUJV8Gb9c0/XoQu8+Nxv3vQnE8UvRcCSgYTFBAa3oA1M7Wr5ZBXJ4MSsA5GOtsG9Y/Nan/Rsz/fSK2qBQZnycOaWjex2hqj22GDUxUgbGqSWUTf/3NlFfiWhnOD9poIaFbJhVcd6EF8/Ie0LQXG1GiqzjHlij5jCyFVMAuJNCWxqbbXyKi8oAARxD/EPIF4Jj1atRfl/NEzKz1pM4AS1VRcjRlnO86fNbvd7O1+eow8j6mZvy0Zc2K5eiLtf++LXbZNAsRyGYuqw/kETrFcosrch27Gc8FFYLbK5MkkfABspbi9ZTPOSsGCRXSnsXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQLXzW+Psp1yfldVTzAibZM7D+4rBNuVa7ESFPNIR78=;
 b=RU5lDhx9/6s5XFJUdo5OpHU8Lay3tFEkTusm8QfHzr/RnmnUNB9lwmiSuZ4k3KOCRal5Oc0twfQu0Q1+vU/Vminz3EytV4YT7hRRUeS7tQSlP2fPoxtEHRdtPBzc/nawIZS1g5p9GiPmwkScffcR0wpmr+bMgypuUVnN+9pXmnw=
Received: from CWLP265CA0346.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5a::22)
 by VI2P190MB2085.EURP190.PROD.OUTLOOK.COM (2603:10a6:800:227::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Wed, 5 Feb
 2025 10:46:14 +0000
Received: from AMS0EPF000001A5.eurprd05.prod.outlook.com
 (2603:10a6:401:5a:cafe::3) by CWLP265CA0346.outlook.office365.com
 (2603:10a6:401:5a::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.26 via Frontend Transport; Wed,
 5 Feb 2025 10:46:14 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AMS0EPF000001A5.mail.protection.outlook.com (10.167.16.232) with Microsoft
 SMTP Server id 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 10:46:14
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v2 20/34] net/ntnic: fix array verification
Date: Wed,  5 Feb 2025 11:45:29 +0100
Message-ID: <20250205104548.1533554-21-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250205104548.1533554-1-sil-plv@napatech.com>
References: <20250121170814.3252171-2-sil-plv@napatech.com>
 <20250205104548.1533554-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A5:EE_|VI2P190MB2085:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e1ca10f2-b1a8-4bb6-5727-08dd45d24fdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KNZWYNKXf/a9qvh3am9NlYqY0GgrnixR9xHLbIqg+jboopkyP0WFzRq5k2x6?=
 =?us-ascii?Q?HF7H/KwVrsVH8fcpiPjH7R8AIVaLPrGYu7843YTiJ34bF20bqyJH5mK47rYt?=
 =?us-ascii?Q?Y0wIzS2nI2m5sU7dkAWxfuVBjmCI7dkB0KEWRib6tt+IMvtaA8DrIlUU1f91?=
 =?us-ascii?Q?MG4gTd/iBc3kA6IRz1mZr6o8lbg5RYqvJXXkNVuSKfl3aQbr02dwn5zX3LvM?=
 =?us-ascii?Q?g99k8fp3yfYFFJRq0IkrY2giLwgYIg0cVrvepBk81Nt7ZGUXtHeY8CIzpHeL?=
 =?us-ascii?Q?0E1qFcsqgoCqi2thCy2Izw/klNEjDm1Z/KIHSGGznnK5qPcHf732MB/tODpz?=
 =?us-ascii?Q?JmHThjjc2zRfxIJFB/QK7a59hL5MUdR6ZGCuUyNXUTfj05l9rXgSmxiMHisR?=
 =?us-ascii?Q?tNhwTwyaBAmXSR2CddiU542L0F9aIi/RBVl2W9SD2ITItPFRArn87XQ5060A?=
 =?us-ascii?Q?3K5+/WxbMtDbjJZJMArghItFTlmVeouYVagRU7c/LkpC+5ULhkHVeAw5IRaz?=
 =?us-ascii?Q?3EhBcyojjMO4gtLCp+PsIONaRp/wdIckwSIOpwbdeFHlYbOblmwM943woGlK?=
 =?us-ascii?Q?PGdBFlNTOgWbQM3RhQ1Gnl5KBKGF9Uuq8Vlrs9HJ5mwB94/kL2kiAiPNi3hC?=
 =?us-ascii?Q?DL0MeqjXvKaB+fmAZcoHFg31nSYeYpZB/rw2mk76BHi3DWE1oCHdha1XDCZh?=
 =?us-ascii?Q?pt1dzgv30VbCcoNNMhztJMKK2JDDO18zMArlb+ox/cVokTDHXRArJvYXO9v2?=
 =?us-ascii?Q?uuH6gJ4AjZ7vVqbzM3n7J/5oVpEmiX17UuQk12E8dEn5temMeS5r6R/WefpM?=
 =?us-ascii?Q?l5NWqA5Z2P/3ezGNWBU57OHYT+Vxio6AFpPx2jb72A1FpgP4mllYVDz4uKPn?=
 =?us-ascii?Q?UZGgufZ/J6GpFNa5znzH5p6yIxnyA6GTZ2pkjt1H/0FQmbU/MhW+QIn2JSG4?=
 =?us-ascii?Q?vQR2/WOAsdPMyj5ONGIQcRuwHpkvIS566F5mkhDIaRza+PBp4czAZ4AwNmQG?=
 =?us-ascii?Q?g8ytEIl6wWr/0Zf3YOnJqs7ehl2IMBUenujiRRN+BmbcTsbOzmnL2ixW9tFL?=
 =?us-ascii?Q?0/jvP8rpNOP9pSLFEHlG9K4mHqgb5frnWZF2hu83hLn7cL/2ydE6gkQ+G3FD?=
 =?us-ascii?Q?Rzewk6qDQX+VpH07OcFnDWFhG4dBUqlcL9SnrGpILESy7ImxFSD1JFY7aHzX?=
 =?us-ascii?Q?ZfSvbu1UHZ1G+nDKYzAyImRfKq7HWYHI5bwHjE9v6MOmoWpIqTn8AA4H0b3n?=
 =?us-ascii?Q?3vawPB9hlG83on4QunfF1Znhe7Ut41v1066wW+Qlz3kKyPNPqXal6g3ZhSD1?=
 =?us-ascii?Q?BcqLI/vY45uCsoeq/nNekTX5z9ELTcVoAcrf3GkHyrLK736dZ8y1p90gmOdE?=
 =?us-ascii?Q?kOIRV9lGUyWDu24dLO6Ul/5nQckXP6KT0vHpeL/OJ+9e0OyxF1o332CNbQFb?=
 =?us-ascii?Q?nlUEx0g4uxrG9qslTKc+vdgF9h5z5iBzh/I1yXmwb7ku+SziNNyiUg=3D=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jHGORN7JqzDVd89TghS4Ra4BM9wbDhLz5WTLKAnkZvAWT0puoNAX63ekWJCgEhifUg4Nv/V1JiHZ7oi/DuybJrvtBWIDGzP18em2UISufty0Tkzq4w69zM7v9xeWbKoAJoKrU8KBkPiBoRRwI53VxBsHqNr8B9aDiTX1y755DNl34z+bf+3oLHhxq09vHADkXkDFOfeTG9PQxFnoCLZpdrTF+xat446hcn4YWImjR0FLgmZGTYeh9GatncQSJcWJxn1oVQNGwiiyYmgGnt/iigmgl/qcpFLNafcoK4Z47TBGlsKibJcBStnxL0ljMhooK7oqDvIz5Da9COUhOP5KdeHvufaBvIs1DMbAbVclUMxRb4AMtj9vEHm3F/43SmlsJRoCLUf65PFB7fYt6Er0VQUj+D9vGPkxI5KBZ7MAo4O/+FN79N/g75UOf8P/Z9dIMjwBX6PJuvCDPeHi+S84LPOJm6dv9rv7c8zovlwlEhRrO8NRGOjbnZFqCbFnd2AbMuN1hCAptClyMD6gdIg/qgTYXnyhQq3OoBWk/eIW25vqA4mfXoU194122o3wk5VFK9/b1ki1JD6W9ZRpqIJuFdH8g3OMNjCcgRgS2BqbkM3A74u55hYWezsvc6EPcniYttNKQnmdgTvh9HssJ70q2w==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 10:46:14.0426 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1ca10f2-b1a8-4bb6-5727-08dd45d24fdd
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A5.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2P190MB2085
X-BESS-ID: 1738752377-302364-7588-668-1
X-BESS-VER: 2019.1_20250203.2302
X-BESS-Apparent-Source-IP: 104.47.51.239
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVpZmRkBGBlDMPC0t0czI2DjZyC
 zNzCDN1NgyOTE5LSXJwNI4ydLINE2pNhYAUYx+T0AAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.262304 [from 
 cloudscan12-59.eu-central-1a.ess.aws.cudaops.com]
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------
 0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS113687 scores of
 KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
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

if statement was modify to ensure that word_off
doesn't exceed the size of the array

Coverity issue: 448958
Fixes: 7fa0bf29e667 ("net/ntnic: add hash module")

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_hsh.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_hsh.c b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_hsh.c
index cc8db2fae5..d19e72e323 100644
--- a/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_hsh.c
+++ b/drivers/net/ntnic/nthw/flow_api/hw_mod/hw_mod_hsh.c
@@ -221,7 +221,7 @@ static int hw_mod_hsh_rcp_mod(struct flow_api_backend_s *be, enum hw_hsh_e field
 			break;
 
 		case HW_HSH_RCP_WORD_MASK:
-			if (word_off > HSH_RCP_WORD_MASK_SIZE) {
+			if (word_off >= HSH_RCP_WORD_MASK_SIZE) {
 				WORD_OFF_TOO_LARGE_LOG;
 				return WORD_OFF_TOO_LARGE;
 			}
-- 
2.45.0

