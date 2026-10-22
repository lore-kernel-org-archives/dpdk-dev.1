Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6811F606A31B
	for <dpdk-dev@archiver.kernel.org>; Sat, 24 Oct 2026 16:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.a=rsa-sha256 header.s=selector2 header.b=W6l6K/hy
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 629A140269;
	Sat, 24 Oct 2026 18:47:08 +0200 (CEST)
Received: from TYPPR03CU001.outbound.protection.outlook.com
 (mail-japaneastazon11022105.outbound.protection.outlook.com [52.101.126.105])
 by mails.dpdk.org (Postfix) with ESMTP id A199F4003C;
 Thu, 22 Oct 2026 14:05:46 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sDK/7ps4EHoQ2rVbh/WNPkaSwwiX7TNUg05XwjjRlOEfnm8tTfH6DuIfVKPiKWwH0+NuOzld1FhSdcV95IT9nBbZivKauG9smQjm9/FM6cC+GR4pPqWRVCDgElyzaCOAmwG/Az8IW5ASEUfypCd0LHTxv0YBJQBbi+PGZBTc3h16HTsYAgVI6cPI5/kaYZ2dfcbFEFisK7GRZQ9WBKqKMBw/HWPNjmQEecnfK+BmpdewUVtdrGO763DJEHL0HW+yRyb4EmN2RXOXUel0EokE3C0R/EBMx8MLnT+pbsLAWbYITYid3I1ZH1Xi/EfRwT56vg2KxGKDlfuqYGUFfmPing==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y+e2+BmAk1w9DDnIpGY+SphIVkuHGM+wmqM3TWPPrJo=;
 b=cIAdnTbE4tBC4vt9xztnAlBjHHV1OosDbfs3fe1sgTqlh71lYFAxeTmy5v2EAM2Mt8R1+80szf83iGTevhjtQEDws5B9orKaEtSOTVhCz3r01N44RLOO/hsUMRSfXRUlR0xRDdQ+DVAupaVN3QIl1ozCBId9i6WacvQUUmgMblKWPRm/7QS4rqFsSZgiu54s3I9YyeuCohKFoKsqlbx8+6DFHGCUVcCqdCFF/f9R8uk2nknuYgxkRrbHXUJz7XKnlmQYKlVrzTLYaWXOKwF4okeJsMh8AS8vlduik4rpG63lyGd8+6qCPVbDuHodLBNomQLvOLwDAq2m0tcMupdSjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+e2+BmAk1w9DDnIpGY+SphIVkuHGM+wmqM3TWPPrJo=;
 b=W6l6K/hyP9IheoXyt72Gafi9vwubwqg1cyy4ntdhKOnA4rYuJzOfcgH7LNzOkkPpoNyC0kR8Bzyo4Pz0opbvdq1jxY269jZQb3QXvbvG6SZnagMbo3J0TsMCDpG9qE7EkzaNXAOVxSdtQRoIGn3ycd6F1GD3eRUbOsqoIPwWqfFf8FESl1N0uSymF9/BNdu9/jAm8nkeQSX1JXPLV+z6HdXj3XzbbF1eVMH1bT78fD6eXGlE3lG2TCJHKw/ogwneFsK/Ak4Eia4nd8UE2Cc57V3Q1J4isZOS06uaUyd10lIBRPANb8T+Hmf9hU6KDdUNdDLnjnYH6icdTwOD4srR6w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from TYZPR06MB7170.apcprd06.prod.outlook.com (2603:1096:405:b4::8)
 by SEZPR06MB7238.apcprd06.prod.outlook.com (2603:1096:101:226::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.2; Thu, 22 Oct
 2026 12:05:42 +0000
Received: from TYZPR06MB7170.apcprd06.prod.outlook.com
 ([fe80::387e:d733:9980:3c98]) by TYZPR06MB7170.apcprd06.prod.outlook.com
 ([fe80::387e:d733:9980:3c98%3]) with mapi id 15.21.0569.000; Thu, 22 Oct 2026
 12:05:42 +0000
From: Wei Chen <allen.chen@jaguarmicro.com>
To: dev@dpdk.org
Cc: cristian.dumitrescu@intel.com,
	stable@dpdk.org
Subject: [PATCH] cfgfile: fix isspace() undefined behavior
Date: Thu, 22 Oct 2026 20:05:30 +0800
Message-Id: <20261022120530.3452-1-allen.chen@jaguarmicro.com>
X-Mailer: git-send-email 2.33.0.windows.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:295::9) To TYZPR06MB7170.apcprd06.prod.outlook.com
 (2603:1096:405:b4::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB7170:EE_|SEZPR06MB7238:EE_
X-MS-Office365-Filtering-Correlation-Id: 101e30d1-7b58-432d-a1d6-08df3034cb26
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|52116014|1800799024|366016|38350700014|261021121427099003|56012099006|5023799004|261009223027099003|10067099003|261021123027099003|55112099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: 0GuiVkrCz/F+++r6Ir7kQHXO41aWr3WZGZ2MzOO1etkHpSAGCXeJ+uayJhEcSEV+A5g3x2IJoJlRPRch+G7VRR4ESGEvFwU7yF+7UXTS70Aqqzd2n+D0ha0xiJ2hceBDwJQSKG/dVejPct334l1mNOy+jgHoaryoLOXsR1LMEo3R13vPnyq5Au4VBMzBDqeiYXqxt1LrIhTJEUaEaQXWDKLvbrJb37xM2HWIAeE6teoLCwKnVaeyEqXQGXVjAKblBF6HsKMmCAb1KzGTWQ0MhLXF3z+uk6puq2Xh4x6tvoAtnH2ppIXZJYE3C7hj64Yg/Ss/aSPqA+ggWsugU1MtGAomeybvpS8S9NPJQBVK3MjeQapTFIDv8R4J1Ym/TrpLwwe8qDtv3CHRNDMpYbzQDK73Rl2jg1KwDCdcOMcMxfHv23AzDUSQYpt+Y5hWsXLKdVPzl4DKqAOo/d3MpWKCA+eiN1+VzbdDK3M1ed88O7u1GnOX+FdfajM++aDywTmUpcZrkG9INwmvEv1XD0e4Agg52SloGjM3QK449602Zo4XZDWiZIjJTF9c3eZgbNZWfzAu65Cfam128F3cZFn9fWpM9zt1bRN/b/dIu1jRvJRZ3DT5r/M/yRkFzruAImUm4S2xFP2W780hQp17HQAWNnkvqCHMB80epicL7Gqz5mn99m715FoB47zxrXwHkrx15NOfXTlkDmezCoHCW+Y5aAop6+d7Qpvf7j1OduDI1LQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB7170.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(52116014)(1800799024)(366016)(38350700014)(261021121427099003)(56012099006)(5023799004)(261009223027099003)(10067099003)(261021123027099003)(55112099003)(6133799003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pZL717oUIY5Azo1HZnMQvhRcivR1qQHPtR21+COyKihnTu/zksMT1TX6CUut?=
 =?us-ascii?Q?XE7iNQjBqI7FcvwUnBmyW+RpFfMILqGV2cmtyLaNMYK+8g1vKnFFzikJFeuO?=
 =?us-ascii?Q?NR5UhMXBQVZYO7y72Cd5eePGwiuBwXXiJIka/TLi7GXNTyHthUrUWlFvemOc?=
 =?us-ascii?Q?8LvWlQA8J9ppAknzWHm4LVhC+MupMhFiX58DVMFpZaPnZbmOpg0oqFag5LM1?=
 =?us-ascii?Q?M74TmMNAbfcGxNyKzqyMUkco6CPPkPVGsyEFxdG9oZBMET1q5tgD0jNc8svI?=
 =?us-ascii?Q?Bzzo7bRXOZgusw7qSXzfqTJDHhYLlGY2qMzVbdCvCC8gJLd6XUQNRIE6a3eN?=
 =?us-ascii?Q?WetkAM8KvAStAqsA0T8qTtNiiFN3gyPBnTcWK+DqG9nf1FIW2UfyTuF/HSoY?=
 =?us-ascii?Q?CD1x7MiCzGRgwy8/pootZnT508MfFyRu849RQHp4TlYeAxMz3bn5+IbOOw9Q?=
 =?us-ascii?Q?yiTVdT0vTXVqgNEC7Qo/Ga9SqcMDszd/Aj4E6ODTXWKW8rlBfgP6hClmb8bW?=
 =?us-ascii?Q?pP1mMVEHVZRs6Nsgdpu5JQqyxdnb0CbnadFxhjDM3o1ulaaCHPa9GLc0RKuN?=
 =?us-ascii?Q?b9YvW0k6Kux7GV6ZDV1ffISWz73Kta43dz43rVsb5S9foAeaYNpBZZEbYg+X?=
 =?us-ascii?Q?y95ttt6PT9IPhMoZR76nbUZWcQRZ5tHN4GEWNgGOnKxz3CvM7TnnXj51kopP?=
 =?us-ascii?Q?Cnui2nFknKmQjGSsfHM1hCxzjaGt7snywZkHHeg3qQu9k0XN9i6ZGjrKHd8v?=
 =?us-ascii?Q?QhBVA02neF9Y+FQloZW/lStr+x+/7lh8lkXCQmH8SHGxivCMK3GoXqEmA7JW?=
 =?us-ascii?Q?NmVibTFjRsJvTF2ZRy+TiaxZvI+f02WxMbxN7KGWwyr9S94cUyxgZJTF/nVe?=
 =?us-ascii?Q?283MEPhC9R9z1Kw28q92xaiNcAJwPwmqoPX4E3Bw+Xb4g9UnC04Le4kPQwHj?=
 =?us-ascii?Q?5R4CPUqYy0XQA9YyYks0D3qFTUTanz/Bit/L7tMutKZKjdpaCee3sHOaVR6u?=
 =?us-ascii?Q?92H8C8a5FujBBf0i/yzMyLdSWZKyNb+xUEk4JOMoVTJ6aHCYAqPZmYdqewzL?=
 =?us-ascii?Q?l5d90pjcXH/0lTwDryeCuu0FnE1Gt16SLrF+8Qng+fPKk4JAgeTuCECgWSU4?=
 =?us-ascii?Q?fp+AG829vOUt257eacdZjcbHdzzAcV4I0SKy7DlrTwho3bZSveglNEbnJRR9?=
 =?us-ascii?Q?pSBinrRthu1naPAp2C45oZfYQzjIkh4ZdL73/2Z057PPy/GzRTknDbWLnOH1?=
 =?us-ascii?Q?zujOZ/DdKSWMFH70VwtxiiTvXNTZ7ROGCpJN3/rP1NFvoj65675v3XoWTd2n?=
 =?us-ascii?Q?VSttcEXYwx3ATRuWbpcWR50of8O0vyaKLEvvefm8YAEIQAg6vsWySfqoAafn?=
 =?us-ascii?Q?l3aqEJHEC9lJ7pvxThLwo15Pha0x2kCQ2GLwisB5zgiFQx1RhAd4QsAeKErL?=
 =?us-ascii?Q?HEdU0+Z0rg2vyvU4LguzGcwNs73kqbBf+g+j/sy68AMYTilrT14/lfvhCjVT?=
 =?us-ascii?Q?IVg+SmNl7OqyFl00RJoydQVoI3WkSEAiFrZ90adwa81LApbN7g53AmXAG9pX?=
 =?us-ascii?Q?kM4rdNtmtO1jbYhQ3DYb6HXCc24ahOybERAFObFjqr7pTBIuGYR3FyGoQJkd?=
 =?us-ascii?Q?zQM7CQ+xNnVn5rAS/yEi5myLBH+qzlu117QyzyOXCdVlf9B7desxu36oyf7k?=
 =?us-ascii?Q?329gTZxSnkBy9nPUh2YP3Ob5j2/MceLBHcOMlIIsrwtz7YR0BFh9hUbGRd2V?=
 =?us-ascii?Q?tG/zO8Fe9DML/rAHD6HaSBeQJ0WFhlE=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 101e30d1-7b58-432d-a1d6-08df3034cb26
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB7170.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 12:05:41.9134 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eJLrujR9X3ZfWy6NUWMk9dtslFyWRpjtU5SxwxvBz5cI9HZqUIudAqPDtyt89tsKPzMHkPCq+DYul8WCwX4S0+YFzQqdwxJAtSFFbR0o6vc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7238
X-Mailman-Approved-At: Sat, 24 Oct 2026 18:47:07 +0200
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The _strip() function passes a char directly to isspace(), which is
undefined behavior. The ctype functions require an int argument that is
either an unsigned char value or EOF, but char is signed by default on
x86 and ARM, so any byte >= 0x80 in the input is promoted to a negative
int and indexes the ctype table out of bounds.

Such bytes are reachable from a user-provided config file containing
UTF-8 or other non-ASCII content.

Cast the argument to unsigned char, as is already done in
app/test-bbdev/test_bbdev_vector.c and elsewhere.

Fixes: eaafbad419bf ("cfgfile: library to interpret config files")
Cc: stable@dpdk.org

Signed-off-by: Wei Chen <allen.chen@jaguarmicro.com>
---
 lib/cfgfile/rte_cfgfile.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/cfgfile/rte_cfgfile.c b/lib/cfgfile/rte_cfgfile.c
index 6edd83b5b3..958cec6672 100644
--- a/lib/cfgfile/rte_cfgfile.c
+++ b/lib/cfgfile/rte_cfgfile.c
@@ -97,16 +97,16 @@ _strip(char *str, unsigned len)
 	if (len == 0)
 		return 0;
 
-	if (isspace(str[len-1])) {
+	if (isspace((unsigned char)str[len-1])) {
 		/* strip trailing whitespace */
-		while (newlen > 0 && isspace(str[newlen - 1]))
+		while (newlen > 0 && isspace((unsigned char)str[newlen - 1]))
 			str[--newlen] = '\0';
 	}
 
-	if (isspace(str[0])) {
+	if (isspace((unsigned char)str[0])) {
 		/* strip leading whitespace */
 		int i, start = 1;
-		while (isspace(str[start]) && start < newlen)
+		while (isspace((unsigned char)str[start]) && start < newlen)
 			start++
 			; /* do nothing */
 		newlen -= start;
-- 
2.33.0.windows.2

