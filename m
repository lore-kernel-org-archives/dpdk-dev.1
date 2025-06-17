Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DEDC71136
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 18:27:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C7A3C427AF;
	Tue, 17 Jun 2025 20:26:50 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 82A0D427A2;
 Tue, 17 Jun 2025 20:26:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750184810; x=1781720810;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4y5M7HZvY3jql6IHKBqVjYBgcPFpf/eTp/yUiKsBeMI=;
 b=VwVKG19+QtLpQbWr/pEi9XbfM6sfutDGOG4C6tGWhISbSzhkKQ2EaS7x
 R09pTTdwejOdcuZgd6CBSs1g2D61ozhFX00lFuqR/b9Qdn5HTcexeDSSJ
 wljgGNl2/4JX6FeWhvzCY6QLVyNXKEzPkVg2TMoXCh2JOPQMB8K2EAp/w
 3bMD/CWipf8oYw8Qvrtkb3KffTc4gSljdglPeKZu1ekad40PuJqCs/ZHb
 lhJ+4qeXEAVvIqKd+htyadtQmcnYEUhA/bkdycjMq/DN9sb9ui60gJzM9
 ALiuZT++EWHfxbL83RLatED+E8wWpW7C9O70dqt9KJbDgaIE93XnoJ8vp Q==;
X-CSE-ConnectionGUID: MVyZfsTYTk6eLRyUYyUb/g==
X-CSE-MsgGUID: MyLc/0FmToGg4TFcL98+Wg==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="63737748"
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; d="scan'208";a="63737748"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2025 11:26:49 -0700
X-CSE-ConnectionGUID: QHBHpY1aRXe8eoJq5Rw60g==
X-CSE-MsgGUID: BCKnwG3LRe+15zA1yz9XYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; d="scan'208";a="153622685"
Received: from txanpdk02.an.intel.com ([10.123.117.76])
 by orviesa003.jf.intel.com with ESMTP; 17 Jun 2025 11:26:48 -0700
From: Pravin Pathak <pravin.pathak@intel.com>
To: dev@dpdk.org
Cc: jerinj@marvell.com, mike.ximing.chen@intel.com, bruce.richardson@intel.com,
 thomas@monjalon.net, david.marchand@redhat.com, nipun.gupta@amd.com,
 chenbox@nvidia.com, tirthendu.sarkar@intel.com,
 Pravin Pathak <pravin.pathak@intel.com>, stable@dpdk.org
Subject: [PATCH v3 6/7] event/dlb2: fix qid depth xstat in vector path
Date: Tue, 17 Jun 2025 13:26:29 -0500
Message-Id: <20250617182631.257612-7-pravin.pathak@intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250617182631.257612-1-pravin.pathak@intel.com>
References: <20250509042401.2634765-1-pravin.pathak@intel.com>
 <20250617182631.257612-1-pravin.pathak@intel.com>
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
index 6734e93eac..6dfb345de8 100644
--- a/drivers/event/dlb2/dlb2.c
+++ b/drivers/event/dlb2/dlb2.c
@@ -4138,6 +4138,8 @@ _process_deq_qes_vec_impl(struct dlb2_port *qm_port,
 		_mm_storeu_si128((__m128i *)&events[3], v_ev_3);
 		DLB2_INC_STAT(qm_port->ev_port->stats.rx_sched_cnt[hw_sched3],
 			      1);
+		DLB2_INC_STAT(qm_port->ev_port->stats.queue[ev_qid3].\
+			qid_depth[RTE_PMD_DLB2_GET_QID_DEPTH(&events[3])], 1);
 		/* fallthrough */
 	case 3:
 		v_ev_2 = _mm_unpacklo_epi64(v_unpk_ev_23, v_qe_2);
@@ -4145,6 +4147,8 @@ _process_deq_qes_vec_impl(struct dlb2_port *qm_port,
 		_mm_storeu_si128((__m128i *)&events[2], v_ev_2);
 		DLB2_INC_STAT(qm_port->ev_port->stats.rx_sched_cnt[hw_sched2],
 			      1);
+		DLB2_INC_STAT(qm_port->ev_port->stats.queue[ev_qid2].\
+			qid_depth[RTE_PMD_DLB2_GET_QID_DEPTH(&events[2])], 1);
 		/* fallthrough */
 	case 2:
 		v_ev_1 = _mm_blend_epi16(v_unpk_ev_01, v_qe_1, 0x0F);
@@ -4153,6 +4157,8 @@ _process_deq_qes_vec_impl(struct dlb2_port *qm_port,
 		_mm_storeu_si128((__m128i *)&events[1], v_ev_1);
 		DLB2_INC_STAT(qm_port->ev_port->stats.rx_sched_cnt[hw_sched1],
 			      1);
+		DLB2_INC_STAT(qm_port->ev_port->stats.queue[ev_qid1].\
+			qid_depth[RTE_PMD_DLB2_GET_QID_DEPTH(&events[1])], 1);
 		/* fallthrough */
 	case 1:
 		v_ev_0 = _mm_unpacklo_epi64(v_unpk_ev_01, v_qe_0);
@@ -4160,6 +4166,8 @@ _process_deq_qes_vec_impl(struct dlb2_port *qm_port,
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

