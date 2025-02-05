Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECBFCC02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 10:48:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0005940B9B;
	Wed,  5 Feb 2025 11:46:31 +0100 (CET)
Received: from egress-ip11a.ess.de.barracuda.com
 (egress-ip11a.ess.de.barracuda.com [18.184.203.234])
 by mails.dpdk.org (Postfix) with ESMTP id 495454067A
 for <dev@dpdk.org>; Wed,  5 Feb 2025 11:46:19 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02lp2043.outbound.protection.outlook.com [104.47.11.43]) by
 mx-outbound43-8.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 05 Feb 2025 10:46:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Neo+592rMRCJTd+9dHFS/iImlMV21zMT1+IPkNkHgaPxiS01hMGoVcAFjCovZ53+nL/dn39qh87WvjA8I+4+3SnPRrukkNzOWYGFKoWbUrOViSMWVn/peLKd9KoJiuPdaXPBsdUipGbeVm3A75Lzv2Me8+/eVAheEOEPPHxBoa0hUtZH4ham+I8BmldMHhGpfK08zFFmcQqqSzw1vbUOzL3Md5WQ6IUyBqNU3RRDfwlAqnVstXkE9WxoAzsN+Zslm4MxLGlROjrlvgTpOpzXB0wvfJjZBX/qPEg+kgSSZK+eDAty6GLqXQ+GtcG84Lrv3QXoriN07F901ebW81vTaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MwuI1bQtyF/7O/nBCp0wG38zG+1DpmYgaws0c15isKk=;
 b=xlSABWN9YGU5xn/6eXZZaLvGZ4umUrkAwrKYWv3G0weouoL4ojiSqxdrMEsTMtrIJBeQScmoZybxCLuW2ySNzBlmJZH/tGVEoOFfZEApKpRCe9iFFmVXTD8C6+IEMuAdYdtZLgtv+k8CAupvsNSf9yMURGZV8uy3y+AeVIe1Xz3geve+NSADlxJdrOWJGaVpfwI44/g7+yVkQO4bG4AlGipdZFEl/atnE98KdBDpqLFWKuV+9i/zrrPmG4tHXpP50FSnV6ruRyvzeiJGq/Ls7C12hGkWsW5MJmziKlPhmnrCBqgvAIZ1aaM13n5wyl49+X+6J3Yv7kQPzBbBu7U+YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwuI1bQtyF/7O/nBCp0wG38zG+1DpmYgaws0c15isKk=;
 b=Y6rQowKxLD9clRPCyf9wtfhWB+ZZ9YtGQz8I91Mnie0Uvu80zcYki2uqCMmCKH/rBvS2kegycn/ZDckgCjXEtSLUML6Xa3No2YbhKw7Vo9yKXKPQ0sS1OzzAJngfORBPSkD2snVbS0IVZ1yxjOjqTmZ2Wia+c8CRVuSpIcBn5hs=
Received: from CWLP265CA0340.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5a::16)
 by PA4P190MB1136.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:10b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.26; Wed, 5 Feb
 2025 10:46:17 +0000
Received: from AMS0EPF000001A5.eurprd05.prod.outlook.com
 (2603:10a6:401:5a:cafe::90) by CWLP265CA0340.outlook.office365.com
 (2603:10a6:401:5a::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.27 via Frontend Transport; Wed,
 5 Feb 2025 10:46:17 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AMS0EPF000001A5.mail.protection.outlook.com (10.167.16.232) with Microsoft
 SMTP Server id 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 10:46:17
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, Oleksandr Kolomeiets <okl-plv@napatech.com>,
 Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v2 23/34] net/ntnic: remove extra check for null
Date: Wed,  5 Feb 2025 11:45:32 +0100
Message-ID: <20250205104548.1533554-24-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250205104548.1533554-1-sil-plv@napatech.com>
References: <20250121170814.3252171-2-sil-plv@napatech.com>
 <20250205104548.1533554-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A5:EE_|PA4P190MB1136:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 51801ba1-83cc-4c54-7bcd-08dd45d251c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?47sxi31woZy1aBlBnSfDDB0nJ0JWVFeDiqWYJTPZf8Jky+fe3s2NuV4WKvuV?=
 =?us-ascii?Q?GiXbEQ2gUjRJsERtkCTTkTTEnnNrfiqY/VxA/i6WpWKCbf32cCymn3lMdCDD?=
 =?us-ascii?Q?cZLzEobAm76lj7CaWbduDbwtTdyuPGrysG+dDcHIihw4mC1iD74LRVa/+rYs?=
 =?us-ascii?Q?UdGU0+Fmi/QGA0Ahki6SPsEC//I0aLFN1fl5j3RwV+ZltMntc4Ur98z0yWUh?=
 =?us-ascii?Q?CM+VJhZF3WpiPyEJjnhsGvljAV1ImUXGAR+LowKHaysJy3fnWWSkutGaCN6U?=
 =?us-ascii?Q?8iXoicOAi28I+AnSc/Jgi1F/PR2bPQ00gzE9+5OhgmpRT99T7hnz861X7lAl?=
 =?us-ascii?Q?mQWmash/WWKBY7lKJlQ531FG7TJv/Apu/vL17gsL/ZWh2LtNC3RsRJBhOFld?=
 =?us-ascii?Q?dzc9eKYG9qTj6UyWaCmKUfxhrl2MfoJw5PHs3fjWcLs47ZKU6cQhuiYDzdm3?=
 =?us-ascii?Q?CWTWppUKpG6EIEQjMnG90bJ+nLMBTbcvr1EkixRmJ53iVEnJ28tMy8h11Krx?=
 =?us-ascii?Q?wBeY4gG3zUsCu6iNhr1KSAtx6FfihcIaWADYxynQf/HgTFsOmYaZLlYHFZds?=
 =?us-ascii?Q?REQZir/St4yWY62nLbkPWm7bYP2dPg/5BCoWsjU4XIyqcJd2suZIm1agTl6e?=
 =?us-ascii?Q?Bs6MxCJvEJCdzdlYJ7PeFXPBgD4i8uwtkFxCeOE65q51WVi0mE9fmIvboBqP?=
 =?us-ascii?Q?msX7TWl97BlQAtll/mISOEv+Y8GQiCNzjO5DHkzAfcQOm+L5rdyDDuwRuW6r?=
 =?us-ascii?Q?kmFojFqhumfwygJltqsQxkd4NT0BgAbLEVzZSttqGw3MR2YGwwWri4IKgA9V?=
 =?us-ascii?Q?qTsFCsKzmOhPeqgkVRGk5cXUmh4VYOfvDhaxMihliQyUOApAgQuPTx41H/9l?=
 =?us-ascii?Q?T0QNm65SUsb88+gxgCZjbmxMgJ2sTI5qH/wEhKVY47qQiqpmKuYJzvDxnPlg?=
 =?us-ascii?Q?bvn1PADKLSPbWo+BFPQl6urGDL1vCjvjyvYZ4bomdwfiAIjGP6yvknle6CRr?=
 =?us-ascii?Q?o+sUJqoA76F0Lw54vQ73Gdlr+Sp+PdIrSoQuk37AfPPj1icG9+rDwJvFZGWw?=
 =?us-ascii?Q?ZmvB6TW918h5hB+HV+bMrsFGLo57xczQhw6gBrW2e1o1TYGj1fMoTJyg7Dk2?=
 =?us-ascii?Q?DbHx8OpbN/MC6X2WqCKNlsxi2qPHxk5qH47tLk3fFdEvxb1VqUYOqMEw089C?=
 =?us-ascii?Q?3C6FKiAy/jlyEkJBotnrcsHeT9b/5x9ibvIqjPLT51kISqSAK21UsrjV38S/?=
 =?us-ascii?Q?kyID+CXBeXe+EHGt4dqqKAi4O8Ao46mA/wZ2pcGNqrUlH5NFd5gMYlMgn6U4?=
 =?us-ascii?Q?JK2YUf960w/e2hh6KXyUr0zpxctcQh3YM9/tpUOoBHOnOukm9/SD7PB5Zbdk?=
 =?us-ascii?Q?HckPJtT751pBkD73iXmdaZxJgWRLtETh8nk2yx95TZn3D/ld5SCBAxDav3tP?=
 =?us-ascii?Q?zeR3UJABXfEzDVTBojR5ORMoHL/r329YkPQ4G/HQUB+JJ2dHpUYwVg=3D=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SjWQjlrGAo0jF8jMTIzYyDzUJm67cHTPsBmET2R7gSCZbHYE0Dsd0h0PLbneda+CG/GS/Qq7MXazIbxEaGJ2VdiwDys6Y2cTUEOUARr6H/vD0NKb6x3dxETV3j7IW/792ak8EVYD3XgR0gpr4ImoiCDFgK8VfGGlyjPPCIofEp+DCcBTj1AwWwLysGo90z7zBNMp6okEpc33V1fJdkvIPCUfGeanuhzJy5OdSwoUYabZ5x8VNTMT5YSKNZeS16TxvDh+TfRgAQR4Ifc+gkEt2gWHPHxmoZq6Is3K7nzX+AiANOGp9386alnLwxmKIhEQEQkPNSeWSf9sesRAoDD41OsOuTEmVLCYu/nNu5ABmxfIy119CQ8qHS7L/U9jBu6KIe3XsTfgbvk83jzETclKveXleL8Uffltsie7L6jHTajygv6NlauE9/DH8A0xKby2XCBnfxyabZwz2D+vOfjBTMSMjLY04CejoY7iq6d4Qd3Qit7zn2khzpVeVZmnpuUhL36SLXMgmXPP2Pfh7uwq8ACYj/mSkR9UOo00PPzPBIZ+wVFDM18V6ZC4KpaVOxa3fXFWXZMo96AinSk6pavWq7BBV/I8Af9alwmj6lmcwF1DrF/33qVmwD2yBoMDDwtDP5Qe6Jxc7b2Sx3CYpXhREA==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 10:46:17.2301 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51801ba1-83cc-4c54-7bcd-08dd45d251c8
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A5.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4P190MB1136
X-BESS-ID: 1738752378-311016-9613-517-1
X-BESS-VER: 2019.1_20250203.2302
X-BESS-Apparent-Source-IP: 104.47.11.43
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYGZpZAVgZQ0CjFMs3E3NzU0t
 zS3Mzc1DzRKMXIxMgozczM1Mw4xThRqTYWAKKAYK1BAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.262304 [from 
 cloudscan10-207.eu-central-1a.ess.aws.cudaops.com]
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

From: Oleksandr Kolomeiets <okl-plv@napatech.com>

pld_ptr points to mp_port_load's element,
which is initialized during driver's probe,
otherwise probe fails and xstats_get_by_id is not called.

Coverity issue: 448945
Fixes: cf6007eac498 ("net/ntnic: add xstats")

Signed-off-by: Oleksandr Kolomeiets <okl-plv@napatech.com>
---
 drivers/net/ntnic/ntnic_xstats/ntnic_xstats.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/net/ntnic/ntnic_xstats/ntnic_xstats.c b/drivers/net/ntnic/ntnic_xstats/ntnic_xstats.c
index 7604afe6a0..cf3271d5de 100644
--- a/drivers/net/ntnic/ntnic_xstats/ntnic_xstats.c
+++ b/drivers/net/ntnic/ntnic_xstats/ntnic_xstats.c
@@ -645,16 +645,8 @@ static int nthw_xstats_get_by_id(nt4ga_stat_t *p_nt4ga_stat,
 				break;
 
 			case 4:
-
 				/* Port Load stat */
-				if (pld_ptr) {
-					/* No reset */
-					values[i] = *((uint64_t *)&pld_ptr[names[i].offset]);
-
-				} else {
-					values[i] = 0;
-				}
-
+				values[i] = *((uint64_t *)&pld_ptr[names[i].offset]);
 				break;
 
 			default:
-- 
2.45.0

