Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA6AC71135
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Jun 2025 23:15:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9BC34402AF;
	Sat, 14 Jun 2025 01:15:27 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 64FBF40275
 for <dev@dpdk.org>; Sat, 14 Jun 2025 01:15:26 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55DLtCK5018841
 for <dev@dpdk.org>; Fri, 13 Jun 2025 16:15:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=g2uF9LezegQ4/v1zAuNT5Xt
 aKiwWs0ckCrZAHa/BWj4=; b=gRlfSHSDSuauef4XwW2Ax/QmSVVv0Wn8+ZDDtez
 ENOWRiLPFdb26uHb6+4dvjvGXRim0Up4ibJvSdY8Mm2+LQYdH0oOSTeqvaarISnt
 OCxkipK5sjFk4OWb6c1lXAvhMrbQ6Ufcmmn1w2YT7j1DX73zlU+vVwZ01z58LxoI
 DDUiSHOuo27zbtWWpX6yJmShggd+Rpp3ytrYsQAbcrrvIHzyvSmZHi7lIv1Q9Di1
 S/1Q1+aWthsG9h2kUwkC3WI+YO2ckLVPz297TI936fel9Dob1YtNRJH/dZIdl5Pd
 nZ4LRcyyg+89RohjALrlS+gDVlZH+hS8Q6cEK4yBj+2x1xg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4788ns2axp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 13 Jun 2025 16:15:25 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 13 Jun 2025 16:15:24 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 13 Jun 2025 16:15:24 -0700
Received: from LYYJYPGKF4.marvell.com (unknown [10.28.164.240])
 by maili.marvell.com (Postfix) with ESMTP id 507075B6931;
 Fri, 13 Jun 2025 16:15:22 -0700 (PDT)
From: <pbhagavatula@marvell.com>
To: <jerinj@marvell.com>, Amit Prakash Shukla <amitprakashs@marvell.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>
CC: <dev@dpdk.org>
Subject: [PATCH] doc: fix missing feature matrix for event device
Date: Sat, 14 Jun 2025 04:45:19 +0530
Message-ID: <20250613231519.32933-1-pbhagavatula@marvell.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: sVwbd_DGNwtSi3VLHpzlLJmYfRtpJC-Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEzMDE3MSBTYWx0ZWRfX9musmXX/NBMv
 DpsRgmInCAseSufSj1VWsSp1fbLcj2CrkEV2XTBMgsKSygYzNMKepp1aiyqvtc13gJ+l7YvZDme
 n9BRicCHRrb7L81U3vQzLnglrojU5wbbhviE7Sl1rEXsymzDEwgqqsd36vRTsEzLtjHhN2oSnXI
 CO9/jJn+Yj6W0sI5d99K7cpIceWuNEx1eKUf73ybYAeEXsgI0CNuioYFV/My1C26O5qAKg8wcZ9
 N0rT4UlgVDug1ExKnpcuz0zBJFv6Mj+lRfvZtBxQxxRlxaBX5Res4u5Z/uePly1eOVQqvrrjPGg
 a3AxrH/k7D6ypgPxJD/qaMJTCztpezkSffubfIZo+8Vt8RrEWeEEmjKUKGMMTB1aa4grGunHXRj
 AKbAkFeCpNL69uQzVMLlFM5wbqA5YARVyTU1ZteSQ61KqSWCfymCvL7otAwZFRQAJ4jt0hP9
X-Proofpoint-ORIG-GUID: sVwbd_DGNwtSi3VLHpzlLJmYfRtpJC-Y
X-Authority-Analysis: v=2.4 cv=G7ocE8k5 c=1 sm=1 tr=0 ts=684cb10d cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=RCNVbf192YJgKJdcm-wA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-13_04,2025-06-13_01,2025-03-28_01
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

Fix missing feature matrix addition for event device DMA and
vector adapters.

Fixes: 66a30a29387a ("eventdev/dma: introduce DMA adapter")
Fixes: e12c3754da7a ("eventdev/vector: introduce event vector adapter")

Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>
---
 .gitignore                             |  2 ++
 doc/guides/conf.py                     | 12 +++++++++++-
 doc/guides/eventdevs/features/cnxk.ini |  8 ++++++++
 doc/guides/eventdevs/overview.rst      | 15 +++++++++++++++
 4 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/.gitignore b/.gitignore
index 48b4ce2908f9..c5349f6e979c 100644
--- a/.gitignore
+++ b/.gitignore
@@ -26,6 +26,8 @@ doc/guides/eventdevs/overview_rx_adptr_feature_table.txt
 doc/guides/eventdevs/overview_tx_adptr_feature_table.txt
 doc/guides/eventdevs/overview_crypto_adptr_feature_table.txt
 doc/guides/eventdevs/overview_timer_adptr_feature_table.txt
+doc/guides/eventdevs/overview_dma_adptr_feature_table.txt
+doc/guides/eventdevs/overview_vector_adptr_feature_table.txt
 
 # ignore generated ctags/cscope files
 cscope.out.po
diff --git a/doc/guides/conf.py b/doc/guides/conf.py
index 565f5705d8b8..4b1059c202b5 100644
--- a/doc/guides/conf.py
+++ b/doc/guides/conf.py
@@ -477,11 +477,21 @@ def setup(app):
                             'Crypto adapter Features',
                             'Features availability for Crypto adapters',
                             'Feature')
-    table_file = dirname(__file__) + '/eventdevs/overview_timer_adptr_feature_table.txt'
+    table_file = dirname(__file__) + '/eventdevs/overview_dma_adptr_feature_table.txt'
     generate_overview_table(table_file, 5,
+                            'DMA adapter Features',
+                            'Features availability for DMA adapters',
+                            'Feature')
+    table_file = dirname(__file__) + '/eventdevs/overview_timer_adptr_feature_table.txt'
+    generate_overview_table(table_file, 6,
                             'Timer adapter Features',
                             'Features availability for Timer adapters',
                             'Feature')
+    table_file = dirname(__file__) + '/eventdevs/overview_vector_adptr_feature_table.txt'
+    generate_overview_table(table_file, 7,
+                            'Vector adapter Features',
+                            'Features availability for Vector adapters',
+                            'Feature')
 
     if Version(sphinx_version) < Version('1.3.1'):
         print('Upgrade sphinx to version >= 1.3.1 for '
diff --git a/doc/guides/eventdevs/features/cnxk.ini b/doc/guides/eventdevs/features/cnxk.ini
index 5ba528f0861d..af093dda61f3 100644
--- a/doc/guides/eventdevs/features/cnxk.ini
+++ b/doc/guides/eventdevs/features/cnxk.ini
@@ -29,6 +29,14 @@ event_vector               = Y
 internal_port              = Y
 event_vector               = Y
 
+;
+; Features of a default DMA adapter.
+;
+[DMA adapter Features]
+internal_port_op_new       = Y
+internal_port_op_fwd       = Y
+internal_port_vchan_ev_bind =
+
 [Crypto adapter Features]
 internal_port_op_fwd       = Y
 session_private_data       = Y
diff --git a/doc/guides/eventdevs/overview.rst b/doc/guides/eventdevs/overview.rst
index 3c5ee515f8b5..decae3bd4eaa 100644
--- a/doc/guides/eventdevs/overview.rst
+++ b/doc/guides/eventdevs/overview.rst
@@ -32,9 +32,24 @@ Crypto device adapter supported features
 
 .. include:: overview_crypto_adptr_feature_table.txt
 
+DMA adapter supported features
+------------------------------
+
+.. _table_dma_adapter_features:
+
+.. include:: overview_dma_adptr_feature_table.txt
+
+
 Timer adapter supported features
 --------------------------------
 
 .. _table_timer_adapter_features:
 
 .. include:: overview_timer_adptr_feature_table.txt
+
+Event vector adapter supported features
+---------------------------------------
+
+.. _table_vector_adapter_features:
+
+.. include:: overview_vector_adptr_feature_table.txt
-- 
2.39.5 (Apple Git-154)

