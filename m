Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9E9C369A2
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Apr 2025 06:03:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 64100402EE;
	Mon, 14 Apr 2025 08:02:51 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2103.outbound.protection.outlook.com [40.107.94.103])
 by mails.dpdk.org (Postfix) with ESMTP id 4EAD2402CC;
 Mon, 14 Apr 2025 08:02:49 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k2FeCeXh+KPsksJQZkLXMyMIxZlCvKOlVduCFuaCpvo61BNsu25UTjOGw0UXtHaJ957AJX4mRlgtx5PTyjrDlHV289r2dllboyMGvlPuxsj5fViE24kn+I/6aHOkhyiJDltNaR1CfyDkUljrgWCpJLyX4862D/ikY9vqd1TxwmQhhJX9eNY8QwkIi2eBBLZ/aps2z/7ewMDW+PpYMmMR5bhSxsbdcPjjamn1uIpssOF4llUF1sInWZqJWFpF7o2Okl5u6xqdqPy94OLML5vN0rnF4VUz6rvAdFh9cpPMDm44HVJq7+yNcaiEW2Tha8X7HD8UZBsvvA/eCVkGKAa2Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HpO1khw5woIWeQPA3XCwpP+1A7HPixuhwfbe+0+zsw0=;
 b=foPLZgbpFCuJ0qOfJSr2Xk3VfsscGH1uy1BmRL3m4PHhi2qCdtaTSmH+hU+mUulV+QiFForPpK6Xdmz5wwxPaceVh/L16jcBVtxIdVIhAD5G4Oa0CrFbI8eITtSJCIRah/KFeuC8z1TWrBl5DjgvhvpG+HDKjvsRbpPjDzgh6RzsBYzgejXhijQPLoXyO2GeNHcMmMrU6F6YhclvdXnTAh7DU2J9EYC6vnxry52smssOp+BIfb9EHbkJ4slEjVE3bEZkLFBgDMleFPMEUh1Y9CSGuSRLso9arYL59rD9mtAqMDNpEgKi0d5/8aCGhPbjKO4K3oy0dyDb+l0gF2Rjiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HpO1khw5woIWeQPA3XCwpP+1A7HPixuhwfbe+0+zsw0=;
 b=JHvUy48eAB3H7JMGSwGf0gK/zadjv5tqBUZyV2r7cSsh3KAPKPoxLj+V+67wm0pBhH2Jw+YR8XCev3mgI5/nYY7J9OtqgK0MEYwLt0Rmq79om4tIKujrDIsEJp7s3jmoPZ/CHe1Si8gfdq650x5XLd+tXorgZ1GMIe8hebDoUV4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from SJ0PR13MB5545.namprd13.prod.outlook.com (2603:10b6:a03:424::5)
 by BL3PR13MB5123.namprd13.prod.outlook.com (2603:10b6:208:352::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Mon, 14 Apr
 2025 06:02:47 +0000
Received: from SJ0PR13MB5545.namprd13.prod.outlook.com
 ([fe80::b900:5f05:766f:833]) by SJ0PR13MB5545.namprd13.prod.outlook.com
 ([fe80::b900:5f05:766f:833%6]) with mapi id 15.20.8632.025; Mon, 14 Apr 2025
 06:02:47 +0000
From: Chaoyong He <chaoyong.he@corigine.com>
To: dev@dpdk.org
Cc: oss-drivers@corigine.com, Long Wu <long.wu@corigine.com>,
 chaoyong.he@corigine.com, stable@dpdk.org
Subject: [PATCH 2/2] net/nfp: fix control message over flow problem
Date: Mon, 14 Apr 2025 14:02:27 +0800
Message-ID: <20250414060227.1251817-3-chaoyong.he@corigine.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250414060227.1251817-1-chaoyong.he@corigine.com>
References: <20250414060227.1251817-1-chaoyong.he@corigine.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::19) To SJ0PR13MB5545.namprd13.prod.outlook.com
 (2603:10b6:a03:424::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR13MB5545:EE_|BL3PR13MB5123:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d9b28e7-d613-4219-f494-08dd7b19fb23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?omorj4gc+XhP0OJJ3FHbR5vNaC7wfhRQaktGQc7I7dc/dL1yebbT/ODHIydU?=
 =?us-ascii?Q?UxufWjkGiNxA/7fxXeZfj1ulUvSeK9SPE+Onzr+DA6Pza5Z0Ex6t0xU+YoLN?=
 =?us-ascii?Q?VSZnkKlu1Nhsk//VjT/13i6gUInmPIMAI5es58UNhN/7+bVAft3VLEsDNcA7?=
 =?us-ascii?Q?+kFObujwD6p6UFh0j/lzOHSY0TlgxcnOGSMqExF3Iq//WGwq18OOKNK0q/gb?=
 =?us-ascii?Q?xQJR7843hlioQTqRbXxJOWyAZ2Me4Muo4uaObVUeO+yTn4tJQWb2CEu6XqDv?=
 =?us-ascii?Q?QQ+oefxnJHQaam85swp4HvkBud1T1cGgCOwNX9mqfgQV5R0JKXxh24E++jfS?=
 =?us-ascii?Q?m32l9H0M3Ul9Xk05kU1bbbwA2wp6GcEkPxC6X5PXbUfwTURhhCIINPLz43U+?=
 =?us-ascii?Q?CB2eushDph8rEyVkkjktp77dM/Mnf/tzw+IdnPKrl8Ewt/BcsYSWiIEmTHcN?=
 =?us-ascii?Q?1nDT2JfFmWOJJWl5RIRWhbvX6PmBUBRkSp0NxBXgM8OtpFlNmPcFJWeXLU+A?=
 =?us-ascii?Q?Qrs6aNW9w5xXxYAtpBffdAbti51xAbDSNcGszgF+zYOwrfu10WaMtrsSWOO5?=
 =?us-ascii?Q?UA6Kc6yqHy49V05GIQbmR2lPuyvF/PUX7zwyDTH05oFY0HSCHFSzUXpFBc0c?=
 =?us-ascii?Q?kGwUgvX+NcGpXtW2BvLOm2BuAlqjJRr0lfz76xASfte6FAEk55lsnMm+WwLa?=
 =?us-ascii?Q?7q1RnuojrXFBRfLTS2wLtWmTreYeuBFMagiE7r9jM7a6hxyx/7lHDHfgT/k7?=
 =?us-ascii?Q?BFej+IU5Yvh0cm6BvN1YMRiQLP0e/0WC+bWNEAonhX47Arp0UxizYLMCyvXI?=
 =?us-ascii?Q?yvkJsMIojzr+1Pm3YxIhOfvvKrx1NhbZhT+4ld+UMTsfQTbsbeeTWVQVxOoG?=
 =?us-ascii?Q?3H3lOYUiUSmoHQUy18UrAanfxWwM9a9LfifYUNwP/7t8bETFEums3oyycznN?=
 =?us-ascii?Q?jV0cECX9SUvI8bn24CYj+vSZGLyolQg7RTNS2hZ8Z/cTIl4s7WMOF+fjJ+ey?=
 =?us-ascii?Q?PvyQNHDFamgoYhpM6ZjRBAmfIPgPNSrBdngLuKjVfa1LJWu4Sb7C1l7zMFHB?=
 =?us-ascii?Q?cRu5cZC1eM/mKVPCAhXCUzhFs01u6KwRNkqtWxosa0kVuU5FB2Ob9koc3rOx?=
 =?us-ascii?Q?FcLKY69qsyoBW0k/M/B0vzTXfWWHba1sLdb/EaqXHSpzenSOaPDw88usSCOT?=
 =?us-ascii?Q?xmnA+u9dfbMbVA+v0tt7Qkz9PX5TcDAHrqm09XMmOLFGOoQQVg9EARDVDKc1?=
 =?us-ascii?Q?2hJVliw8HtiwPUPSVgxFBdzAeBP7HZh6oFXNf3fMWiv4TcO7xT3+ZOGYnGS/?=
 =?us-ascii?Q?aqH7lbVLkfvmgKfcUrdD2hhOc2vj9ngtpPqV7Ny91XNmSRxm1L84RDMXCUjD?=
 =?us-ascii?Q?45EtqIF4hVni5bLuV+V5+msyG/OTy/UYiHYk5xFArkRDoNrTNtuzD47wgwW1?=
 =?us-ascii?Q?R/6G55TDjZK/TAUgSZET1zEVTjkFYp6heQIUCLTlSk/GvvUM1SHnYw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR13MB5545.namprd13.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aY5f5F2hpXQRuqzF8hpUtxx/Or333ysK9Pxtl1seuQ1Sm85lc0YIAE281qU+?=
 =?us-ascii?Q?dQwLltUrNghAkx0XwsWSuWZi88C9o3IKmnF/IzNwMkP/9RJfRAZ4gX/+1zI4?=
 =?us-ascii?Q?ufofghAUQOVpKXEAeJUR6os1drUwkl8a7IZFelRoKDJTK9fLM5Y1DhNf0Fx+?=
 =?us-ascii?Q?Uyj6D5rLSMN1uB9uDGrHuDlrRZJQ+JZN5TC+isGSv2P5ZKQk0IcQ2UxdT13b?=
 =?us-ascii?Q?ioSUwsqB237OZcDk40ai9O1PRyQ2YUtQFyp482C3BSlFCn/CgFPiD+ztJi1f?=
 =?us-ascii?Q?aViRn2JvLJvCMqzPsptDkMxTzViAsXj4OqrwhpEzDdU0d7wL1Voy6jQMIhF0?=
 =?us-ascii?Q?PItPhXu3c9lz2Hkdk5Qmjso/JTQWiLCRMwvW/uAsI3SyoU6KKaoCM4yooEtY?=
 =?us-ascii?Q?cH08Oh6O2dTsVxwdjatJB9Yv2i4lpnYGI7ed2S+ShjB+KpvT7R+ntKH3ba+F?=
 =?us-ascii?Q?kmQVcIH1tCNr+WVu4i+5dc7qFyUCyNUQLCAJ/UOIbLc8Kx8XmxPgWJz4MtZC?=
 =?us-ascii?Q?WWsLZ2eHh37fieOJwhuDuYR+dsKUhPQ9y5xRCh7wgsKcyeDm9Vfd7SJP+d0z?=
 =?us-ascii?Q?lJd/JB4AuoL//ML2T4LdmM9hBMmFoybrUE074ile6mgfcKO+blnqmWP+4QyR?=
 =?us-ascii?Q?cBmNZJOX7qsv1CjhsjqVc3vbzht2GKJkF+fBKBGM1UTC6M6k4eaJ7/opccT+?=
 =?us-ascii?Q?JcxIZv3aAQLHmjHrkPtAv7/RU8p5wURet5O+6INi3tFfmHkbXXU/O1SlFIkw?=
 =?us-ascii?Q?NXp+faW7MAwEAALV9etTzfBfZdS/B6DLO8SKmNpgrmZEPt8xdWIHtpjDMJHJ?=
 =?us-ascii?Q?CUNLuT/Ba2N0z2tD6WD3xxVG3CiNvmQf+WQ2iu2bGtsMxMCyzav0UVfpNfPI?=
 =?us-ascii?Q?G+AY7S/c5kfwJza78ZiKGbbQq0fBNscZkNEBvTVG8i5LCLJkfElUoOPNJjnp?=
 =?us-ascii?Q?isZBnz2AhmQ2vxLRqyaYPMcxRTVNYxOuLeq9/S87zRcRFP5AAoqId8iAShST?=
 =?us-ascii?Q?wKsbw3YyzKD4Ma92rzwacEcIuJa4eTjXPbIZbBNKW1DuSyDr4qDBVS4xEfy0?=
 =?us-ascii?Q?YsA83HkvXrySu3E9+TmZnCQC4WQv0vPVyFnmRSCGgKya/rrPo6LjzjoKo4iF?=
 =?us-ascii?Q?PlqSvhAysH1YDfpZ69hGOlKDWzrB+H7E7ZIhIUnPK2lSapK3OL/YFvpoGA85?=
 =?us-ascii?Q?AtvTkVctT2I0Rg3PMcXCczzIDYHxqQjfDE7XJyaFRz5W5epiweIw2iGs8ELB?=
 =?us-ascii?Q?O/Qcamw+vUnrh2ugGGk3Z9NPbNIjvV2pMlN+Pn3CEH3Abre7nHdv3Mw8KXso?=
 =?us-ascii?Q?OYOIAaNOEyDSMsrjIcnxinJHWuw2H7wWVXC4vnD7PuA7g3IrdXY9DWOUWnBX?=
 =?us-ascii?Q?VGjS6ElmHEbFa5DcZPw8KJ4F4WDSELOmmOD8bUmsFDIqmBzA73g7YcXhmfGf?=
 =?us-ascii?Q?55eFo/St8b2nyHvg6pEqpCcbk6YjqFXm/PsuhIt8XOq/IzBbIkmxXvkwOboX?=
 =?us-ascii?Q?WEe2CY26ypzKd/cTi5TCxrATR+x0yhkN/fB7oV6CP1pJJp5vZGgZGyzWFThb?=
 =?us-ascii?Q?rwCNli9/OmzFBjAyd9s9MqZy1eDV6OOGAGqgoNMHTtbHwAPWet/wGhNU4028?=
 =?us-ascii?Q?WA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d9b28e7-d613-4219-f494-08dd7b19fb23
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR13MB5545.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 06:02:47.7577 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ys+ycOxS8ODS5CYxMD2BrNaw/O5unGIDRj4KNasEsXHzC7DbiINi8H90qVYpbpds4q6BucSbPqLZTrGEivlfdKc5NiH4lM0w0yQklS78YyI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR13MB5123
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

From: Long Wu <long.wu@corigine.com>

Control message will send 32 bits data every time, so the number
of write operations should be adjust correctly, or there will be
over flow problem.

Fixes: ca65f2eef224 ("net/nfp: add control message channel")
Cc: chaoyong.he@corigine.com
Cc: stable@dpdk.org

Signed-off-by: Long Wu <long.wu@corigine.com>
Reviewed-by: Chaoyong He <chaoyong.he@corigine.com>
---
 drivers/net/nfp/nfp_net_cmsg.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/nfp/nfp_net_cmsg.c b/drivers/net/nfp/nfp_net_cmsg.c
index 8f77c5588a..1ebd66bb0f 100644
--- a/drivers/net/nfp/nfp_net_cmsg.c
+++ b/drivers/net/nfp/nfp_net_cmsg.c
@@ -36,8 +36,9 @@ nfp_net_cmsg_xmit(struct nfp_net_hw *hw,
 {
 	int ret;
 	uint32_t i;
+	uint32_t data_num = msg_size / sizeof(uint32_t);
 
-	for (i = 0; i < msg_size; i++)
+	for (i = 0; i < data_num; i++)
 		nn_cfg_writel(&hw->super, NFP_NET_CFG_MBOX_VAL + 4 * i, *((uint32_t *)cmsg + i));
 
 	ret = nfp_net_mbox_reconfig(hw, NFP_NET_CFG_MBOX_CMD_FLOW_STEER);
-- 
2.43.5

