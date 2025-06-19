Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D886BC71159
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Jun 2025 04:04:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6860442E4D;
	Thu, 19 Jun 2025 06:03:37 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 5CFE142E4A;
 Thu, 19 Jun 2025 06:03:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750305815; x=1781841815;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pTARDekYzC37CfHTHOJyOIkHFGnEy8CUPLgzcIb8j8I=;
 b=DoOWfvSlg8JjZOk7s+ANd3/3PuymH6Dq1FuJO3/75YVvt9Y146WZU2cw
 D1OfrUWK2v4P63UsNgCZRyPk6EGVHovf3x8hj9YoJLMp8aB+OdY+BYfRV
 ddBMAVBIIlbcZBNcu0S4gtUcTpYkg5g6ODraUfn+6x3SfDaqgNRB2NTQ5
 +gKR41cCZffQ8TJs31kfzYHuk4LgmpIzw2yFd3Z422R1gCnBtHM4hAlo2
 uzmqCMEjP7G1zFMgRXQs1UEUbIjL/vEie754pQgr4JiB2IPrHthagkH1v
 ZD+QXHGreOV+AGbJZY9a0BSFuk0S0kLvzmJfiezv5oWqraAmuSHx41z/W g==;
X-CSE-ConnectionGUID: wSWBYEVKRiGC7C14murwLg==
X-CSE-MsgGUID: vv1ZEshORdCU/Xnk/NwaUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="63592774"
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; d="scan'208";a="63592774"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2025 21:03:34 -0700
X-CSE-ConnectionGUID: N6ejyjF+Tamdl2ESYUhC0w==
X-CSE-MsgGUID: oQFFpPXYSoWE8md1MYzWSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; d="scan'208";a="150665558"
Received: from txanpdk02.an.intel.com ([10.123.117.76])
 by orviesa007.jf.intel.com with ESMTP; 18 Jun 2025 21:03:33 -0700
From: Pravin Pathak <pravin.pathak@intel.com>
To: dev@dpdk.org
Cc: jerinj@marvell.com, mike.ximing.chen@intel.com, bruce.richardson@intel.com,
 thomas@monjalon.net, david.marchand@redhat.com, nipun.gupta@amd.com,
 chenbox@nvidia.com, tirthendu.sarkar@intel.com,
 Pravin Pathak <pravin.pathak@intel.com>, stable@dpdk.org
Subject: [PATCH v4 6/7] event/dlb2: fix qid depth xstat in vector path
Date: Wed, 18 Jun 2025 23:03:15 -0500
Message-Id: <20250619040316.317733-7-pravin.pathak@intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250619040316.317733-1-pravin.pathak@intel.com>
References: <20250509042401.2634765-1-pravin.pathak@intel.com>
 <20250619040316.317733-1-pravin.pathak@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

update QID depth xstats counter in vector dequeue path

Fixes: 000a7b8e7582 ("event/dlb2: optimize dequeue operation")
Cc: stable@dpdk.org

Signed-off-by: Pravin Pathak <pravin.pathak@intel.com>
---
 drivers/event/dlb2/dlb2.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/event/dlb2/dlb2.c b/drivers/event/dlb2/dlb2.c
index f9bdfb3503..fd8cc70f3c 100644
--- a/drivers/event/dlb2/dlb2.c
+++ b/drivers/event/dlb2/dlb2.c
@@ -4145,6 +4145,8 @@ _process_deq_qes_vec_impl(struct dlb2_port *qm_port,
 		_mm_storeu_si128((__m128i *)&events[3], v_ev_3);
 		DLB2_INC_STAT(qm_port->ev_port->stats.rx_sched_cnt[hw_sched3],
 			      1);
+		DLB2_INC_STAT(qm_port->ev_port->stats.queue[ev_qid3].\
+			qid_depth[RTE_PMD_DLB2_GET_QID_DEPTH(&events[3])], 1);
 		/* fallthrough */
 	case 3:
 		v_ev_2 = _mm_unpacklo_epi64(v_unpk_ev_23, v_qe_2);
@@ -4152,6 +4154,8 @@ _process_deq_qes_vec_impl(struct dlb2_port *qm_port,
 		_mm_storeu_si128((__m128i *)&events[2], v_ev_2);
 		DLB2_INC_STAT(qm_port->ev_port->stats.rx_sched_cnt[hw_sched2],
 			      1);
+		DLB2_INC_STAT(qm_port->ev_port->stats.queue[ev_qid2].\
+			qid_depth[RTE_PMD_DLB2_GET_QID_DEPTH(&events[2])], 1);
 		/* fallthrough */
 	case 2:
 		v_ev_1 = _mm_blend_epi16(v_unpk_ev_01, v_qe_1, 0x0F);
@@ -4160,6 +4164,8 @@ _process_deq_qes_vec_impl(struct dlb2_port *qm_port,
 		_mm_storeu_si128((__m128i *)&events[1], v_ev_1);
 		DLB2_INC_STAT(qm_port->ev_port->stats.rx_sched_cnt[hw_sched1],
 			      1);
+		DLB2_INC_STAT(qm_port->ev_port->stats.queue[ev_qid1].\
+			qid_depth[RTE_PMD_DLB2_GET_QID_DEPTH(&events[1])], 1);
 		/* fallthrough */
 	case 1:
 		v_ev_0 = _mm_unpacklo_epi64(v_unpk_ev_01, v_qe_0);
@@ -4167,6 +4173,8 @@ _process_deq_qes_vec_impl(struct dlb2_port *qm_port,
 		_mm_storeu_si128((__m128i *)&events[0], v_ev_0);
 		DLB2_INC_STAT(qm_port->ev_port->stats.rx_sched_cnt[hw_sched0],
 			      1);
+		DLB2_INC_STAT(qm_port->ev_port->stats.queue[ev_qid0].\
+			qid_depth[RTE_PMD_DLB2_GET_QID_DEPTH(&events[0])], 1);
 	}
 	qm_port->reorder_id += valid_events;
 }
-- 
2.39.1

