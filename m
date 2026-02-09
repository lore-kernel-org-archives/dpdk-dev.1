Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D323EE9E31B
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 15:05:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F5334065C;
	Wed, 11 Feb 2026 16:04:53 +0100 (CET)
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com
 [67.231.149.131])
 by mails.dpdk.org (Postfix) with ESMTP id 59FF14028F
 for <dev@dpdk.org>; Mon,  9 Feb 2026 17:16:14 +0100 (CET)
Received: from pps.filterd (m0122333.ppops.net [127.0.0.1])
 by mx0a-00190b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 619BNjNx1214318; Mon, 9 Feb 2026 16:16:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=jan2016.eng;
 bh=lIhTcxHZcWkQ5/8FLccj2rUUIPXBuRxACR+zuFYN5Qk=; b=Ak5MduMxZwdF
 qL6027ytlYxodF771AjNwCEzQ70BgWWSIy60gzj+gyaN8eVl6YEwL33rWlVjO58q
 6FS1kNiXwIdzx/oc4aYqFAdVCEzxv+uI21RZkmwUKfky/F9lQqiDD8dnuxYHWUT2
 /kWK5miDGXOwsPVYPAdJFltkGkApxiVyxLcs+HtxsT5ndFv3+OSALR0IfuQ2WY2m
 2hW30jKZjzTVGBiiFUWDLpMFOv0IJHW1MLcgmlVi3I+W8LVOn49rMQZEjbiqSYDW
 7HWND18aoWxigBWpP9pns1ZDg/VNJt2SF5Ate3PeBPuJwz8haePmJkzhq9L3QaGW
 MWqAOTe6VA==
Received: from prod-mail-ppoint6 (prod-mail-ppoint6.akamai.com [184.51.33.61])
 by mx0a-00190b01.pphosted.com (PPS) with ESMTPS id 4c5xdvr7xg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Feb 2026 16:16:13 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint6.akamai.com [127.0.0.1])
 by prod-mail-ppoint6.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id
 619BsXYE016769; Mon, 9 Feb 2026 11:16:12 -0500
Received: from email.msg.corp.akamai.com ([172.27.91.40])
 by prod-mail-ppoint6.akamai.com (PPS) with ESMTPS id 4c61m4yhh4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Feb 2026 11:16:11 -0500
Received: from usma1ex-dag5mb1.msg.corp.akamai.com (172.27.91.40) by
 usma1ex-dag5mb1.msg.corp.akamai.com (172.27.91.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 9 Feb 2026 08:16:11 -0800
Received: from lon-lph85swt.london.corp.akamai.com (172.27.164.43) by
 usma1ex-dag5mb1.msg.corp.akamai.com (172.27.91.40) with Microsoft SMTP Server
 id 15.2.2562.29 via Frontend Transport; Mon, 9 Feb 2026 08:16:11 -0800
Received: by lon-lph85swt.london.corp.akamai.com (Postfix, from userid 37336)
 id C81C515634D2; Mon,  9 Feb 2026 16:16:10 +0000 (GMT)
From: Max Tottenham <mtottenh@akamai.com>
To: <dev@dpdk.org>
CC: <dsosnowski@nvidia.com>, <viacheslavo@nvidia.com>, <bingz@nvidia.com>,
 <orika@nvidia.com>, <suanmingm@nvidia.com>, <matan@nvidia.com>,
 <mtottenh@akamai.com>, <johunt@akamai.com>
Subject: [PATCH v2 3/3] net/mlx5: fix vport action flags for hotplugged
 representors
Date: Mon, 9 Feb 2026 16:14:40 +0000
Message-ID: <20260209161440.1947052-4-mtottenh@akamai.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260209161440.1947052-1-mtottenh@akamai.com>
References: <20260209161440.1947052-1-mtottenh@akamai.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602090135
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDEzNyBTYWx0ZWRfX8joGPDH86xJJ
 3IN28oCGEyoz1W4EGJrV1jvybSfaNCUDGk/Go7riwwmeRCHagonaYHwbaK1q5NufznwZboMji6B
 1DDVnykA/MFUhHhyB904n81BBc3BgVQfZzWUyfAfS1vBFKAUb1RChMsWrXXlVXBDKGIicq6JA12
 MfvX+kkKfNiOY9uXktO7S7yOzC7TOsDAGlIFszmt7EIiXepTabk2PpRPGVw8u/ZA3RlmzlPqzWI
 +x1Q0nkrCwTyMS2krGfILvWcwzwKpmg3jkO59DfsGFH0FpFK2cyW3a0G6t+ggR8eI3TKbNAHYzu
 AOKRMPh5jlhNJv3UWEYFsc1BScBEH7tqwHZdXKNrItFm4ThfCaYTZxIenuYv0JQFpZzsfnYqWG3
 RqNqT+DoQt2Cszk8c0akOK7BFlcbYREWe4MICmUU89+CxFENOqRbDEgy3C4lcRKW5cLNsZHnJ0D
 Vbzj/ZrGwnek/w9ykRA==
X-Proofpoint-ORIG-GUID: vZMZ5mI0IHmM1dEj6NSN_M6ERisk2V2J
X-Proofpoint-GUID: vZMZ5mI0IHmM1dEj6NSN_M6ERisk2V2J
X-Authority-Analysis: v=2.4 cv=Uc1ciaSN c=1 sm=1 tr=0 ts=698a084d cx=c_pps
 a=WPLAOKU3JHlOa4eSsQmUFQ==:117 a=WPLAOKU3JHlOa4eSsQmUFQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=X7Ea-ya5AAAA:8 a=xf4vSw0EPypYeUqTEL4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602090137
X-Mailman-Approved-At: Wed, 11 Feb 2026 16:04:47 +0100
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

When creating vport actions for hotplugged SF/VF representors in
flow_hw_create_vport_action(), the function incorrectly used
is_unified_fdb(priv) where priv is the representor's private data.

However, the vport action is stored in proxy_priv->hw_vport[] and
will be used by flows on the proxy port. Since representors have
unified_fdb_en=false while the proxy port (PF) may have it enabled,
this caused a flag mismatch:

- Proxy port (port 0): unified FDB enabled
- SF representors (ports 2, 3): unified FDB disabled
- Vport actions for SFs created with MLX5DR_ACTION_FLAG_HWS_FDB
- But flows on proxy port use unified FDB mode

This resulted in REPRESENTED_PORT actions counting packets correctly
(flow matches work) but not actually forwarding them to the
destination vport.

Fix by using is_unified_fdb(proxy_priv) to ensure the vport action
flags match the proxy port's FDB mode, which is where the action
will actually be used.

Fixes: flow_hw_create_vport_action() vport flag selection
Signed-off-by: Max Tottenham <mtottenh@akamai.com>
---
 drivers/net/mlx5/mlx5_flow_hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index c41b99746f..a9d342579b 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -9528,7 +9528,7 @@ flow_hw_create_vport_action(struct rte_eth_dev *dev)
 	}
 	proxy_priv->hw_vport[port_id] = mlx5dr_action_create_dest_vport
 			(proxy_priv->dr_ctx, priv->dev_port,
-			 is_unified_fdb(priv) ?
+			 is_unified_fdb(proxy_priv) ?
 				(MLX5DR_ACTION_FLAG_HWS_FDB_RX |
 				 MLX5DR_ACTION_FLAG_HWS_FDB_TX |
 				 MLX5DR_ACTION_FLAG_HWS_FDB_UNIFIED) :
-- 
2.52.0

