Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5ED2C3ABC3
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 May 2025 04:24:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6276540661;
	Fri,  9 May 2025 06:24:18 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 3ADF94026C
 for <dev@dpdk.org>; Fri,  9 May 2025 06:24:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746764654; x=1778300654;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=W2Pk4TJTt2CLWPqu8mohArHAkHsVyZLRrCYvxJeORCY=;
 b=AVc1h1z2cVTEOKduGyaTyNpHJ4ErCbkTRuu42JwNYqMMEMOuC4VIrDH9
 ufvSXUCwB40rpBvreL7MC+7mUhXv9JdwHC02981dEwlCkUmUf2dxbrRCJ
 iOAdXLHZtfJHp/5oQCKX79FSLqMvLIXkL3t37BVXz/r6WsBUuzMN9yPir
 EHlwjJaMyLyUx29ckzrpCbWXJVPsN2Y7U5kZxMAhLuSfAQNh1AqaP7F42
 +8gev2Wpei/16bkJKlzqeifK5xIWZd2VBCoBKAXxiUGPt1WtCQa28nMAi
 vsgTcBh90dcUY5F1dZdecP2JXLU79pFw3oi4P7UrCXqNJK66+OTGjn7zR A==;
X-CSE-ConnectionGUID: KmJlmuJBQki5Qolnj2dCzg==
X-CSE-MsgGUID: MvzJiZFMT0yMI5LF1FbrNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="48692452"
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; d="scan'208";a="48692452"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2025 21:24:13 -0700
X-CSE-ConnectionGUID: PohEWzHOTbCMRtA3Sjz/jQ==
X-CSE-MsgGUID: RGOdCsrJTM61fnNSN88HNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; d="scan'208";a="136388880"
Received: from txanpdk02.an.intel.com ([10.123.117.76])
 by orviesa010.jf.intel.com with ESMTP; 08 May 2025 21:24:13 -0700
From: Pravin Pathak <pravin.pathak@intel.com>
To: dev@dpdk.org
Cc: jerinj@marvell.com, mike.ximing.chen@intel.com, bruce.richardson@intel.com,
 thomas@monjalon.net, david.marchand@redhat.com, nipun.gupta@amd.com,
 chenbox@nvidia.com, tirthendu.sarkar@intel.com,
 Pravin Pathak <pravin.pathak@intel.com>
Subject: [PATCH v1 6/7] event/dlb2: update qid depth xstat in vector path
Date: Thu,  8 May 2025 23:24:00 -0500
Message-Id: <20250509042401.2634765-7-pravin.pathak@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250509042401.2634765-1-pravin.pathak@intel.com>
References: <20250509042401.2634765-1-pravin.pathak@intel.com>
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

Signed-off-by: Pravin Pathak <pravin.pathak@intel.com>
---
 drivers/event/dlb2/dlb2.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/event/dlb2/dlb2.c b/drivers/event/dlb2/dlb2.c
index 5f3b816665..19fe973bff 100644
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
2.25.1

