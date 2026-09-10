Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E82C79FB9
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Sep 2026 13:57:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 598EE427D7;
	Thu, 10 Sep 2026 15:56:58 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 4E9D3427C4;
 Thu, 10 Sep 2026 15:56:57 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68ACBu2U2333484; Thu, 10 Sep 2026 06:56:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=k2MBDH4o7vzKLPQzTIsF63k
 8kkz7228xu4kgCk8mwk0=; b=bGoUDO2/U4WEgYL3gpwjWPtisRHR5gn5QD4ORQL
 v4VdZditfmi3Qi5BgZ8vZKBgjsux9HsqEtd7O1vq6DEkByMzQMoL4Ozf82n7VIjV
 jgrMRAALTahPkrG44vb4up5YhgDSv4Z0/l/9dlNOy6M4ffGtBfpJdw7PcDUj9/mZ
 22xOIlWax/IqEjyb74JMHCAPHhbm+k0Ve8mG6AwUEFWcQWLP7G10pC+ef93vDyRF
 bR2Q+w5DqnQ4DLIeW+ZpDq7tkC4zqz+TnOI7ACmV7aYcBt5cf1hJiLVizfPIkHQj
 FkI01ZYPD+rbF4yW8D+dHIEiyQW31TF0YdcU+HFEnMJIS2w==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gksnx8pkp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Sep 2026 06:56:56 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Sep 2026 06:56:54 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 10 Sep 2026 06:56:54 -0700
Received: from LYYJYPGKF4.marvell.com (unknown [10.28.165.174])
 by maili.marvell.com (Postfix) with ESMTP id 1A2013F7086;
 Thu, 10 Sep 2026 06:56:52 -0700 (PDT)
From: <pbhagavatula@marvell.com>
To: <jerinj@marvell.com>, Pavan Nikhilesh <pbhagavatula@marvell.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: [PATCH 1/2] eventdev: fix vector adapter power-of-2 size check
Date: Thu, 10 Sep 2026 19:26:48 +0530
Message-ID: <20260910135649.24956-1-pbhagavatula@marvell.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDE2OCBTYWx0ZWRfX+TNY99tCiL8N
 C82/EMh8OzlyEH6RXZXGxfbkUjqovuQa9/ZtonWEaBAGpXWzQV/A0yHN6YEjObET/Z5VZtuitiq
 pQtRKqQj3tp/Ox5n2i/2JnXWOaGlO5o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDE2OCBTYWx0ZWRfX2aFjnzlmtVG2
 Wd18svyvPtWl1G/c9F/axMksOMr2IhE9jZHNverTWhl08t6R+so7a77j9ZREiltqLpFHlgviuFC
 wQbKf2VPks/dAFsFGt6XIZ9aMKRCxCTWba3icWpqMMoAhDIpsn1x7v56H1L0qlHD9dYCRcwJYrg
 DfzBexiV3BwZvvP1POjOt2gM76TZ/1GamlKvr8wmpOpFn4/BqeE3ATslPgzN9ChYyx+u8VrcLYU
 J019jfAKxs6rJP+ExErgSGyRmXfwIQQ28X4Lk+2fgvRAw5iZnoGSroOLbtCJA9VDEk6z+mqPTuY
 dpux4A0rMOqCdVDzhdbnmNpeiJsZtdp6qVFa/MNkeP2XyRTlqfGkjLGCD9RNz7Om1/XMZxAYZb2
 swy6wEpQxQP+jliJGVrmkJ52sokBTqUDWX1bNYF52LpbFskObJHI7Rd8/W0lL8984VOJuut4vEx
 0pC4v2+zzOoWfKGiJ/g==
X-Proofpoint-ORIG-GUID: an638_yZlelSCYzv-OP7U3GZWjwvOHu8
X-Authority-Analysis: v=2.4 cv=EZpd0/mC c=1 sm=1 tr=0 ts=6aa2b728 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8
 a=yuCB_6YaYFFvDLUh0pkA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-GUID: an638_yZlelSCYzv-OP7U3GZWjwvOHu8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_04,2026-09-09_02,2025-10-01_01
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

From: Pavan Nikhilesh <pbhagavatula@marvell.com>

validate_conf() rejected valid configurations and accepted invalid
ones: when the adapter requires a log2 vector size it errored out if
the size *was* a power of 2 (rte_is_power_of_2() != 0) instead of when
it was not. Invert the condition to reject non-power-of-2 sizes.

Fixes: e12c3754da7a ("eventdev/vector: introduce event vector adapter")
Cc: stable@dpdk.org

Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>
---
 lib/eventdev/rte_event_vector_adapter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/eventdev/rte_event_vector_adapter.c b/lib/eventdev/rte_event_vector_adapter.c
index ad764e2882f0..9a839517c865 100644
--- a/lib/eventdev/rte_event_vector_adapter.c
+++ b/lib/eventdev/rte_event_vector_adapter.c
@@ -86,7 +86,7 @@ validate_conf(const struct rte_event_vector_adapter_conf *conf,
 		return rc;
 	}
 
-	if (info->log2_sz && rte_is_power_of_2(conf->vector_sz) != 0) {
+	if (info->log2_sz && rte_is_power_of_2(conf->vector_sz) == 0) {
 		EVVEC_LOG_DBG("invalid vector size %u, should be a power of 2", conf->vector_sz);
 		return rc;
 	}
-- 
2.50.1 (Apple Git-155)

