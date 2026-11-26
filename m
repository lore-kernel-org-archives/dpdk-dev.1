Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F35606A31C
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Nov 2026 07:35:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9841A40693;
	Thu, 26 Nov 2026 08:34:51 +0100 (CET)
Received: from out28-145.mail.aliyun.com (out28-145.mail.aliyun.com
 [115.124.28.145])
 by mails.dpdk.org (Postfix) with ESMTPS id B673740655
 for <dev@dpdk.org>; Thu, 26 Nov 2026 08:34:45 +0100 (CET)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.2571452|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_enroll_verification|0.0815929-0.00236039-0.916047;
 FP=16890042763342108771|0|0|0|0|-1|-1|-1;
 HT=maildocker-contentspam033037034017; MF=dimon.zhao@nebula-matrix.com; NM=1;
 PH=DS; RN=4; RT=4; SR=0; TI=SMTPD_---.kAe1YwN_1795678482; 
Received: from
 dimonzhao-1.NEBULA-MATRIX.COM(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.kAe1YwN_1795678482 cluster:ay29) by smtp.aliyun-inc.com;
 Thu, 26 Nov 2026 15:34:42 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	dev@dpdk.org
Cc: Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v1 11/11] doc: update nbl driver guide for draco
Date: Thu, 26 Nov 2026 15:34:28 +0800
Message-ID: <20261126073430.3168813-12-dimon.zhao@nebula-matrix.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126073430.3168813-1-dimon.zhao@nebula-matrix.com>
References: <20261126073430.3168813-1-dimon.zhao@nebula-matrix.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Update nbl.rst to list supported draco NIC models and state that
draco PFs support coexistence mode only.

Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
---
 doc/guides/nics/nbl.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/doc/guides/nics/nbl.rst b/doc/guides/nics/nbl.rst
index 81ed163..2c39676 100644
--- a/doc/guides/nics/nbl.rst
+++ b/doc/guides/nics/nbl.rst
@@ -34,6 +34,13 @@ The following Nebulamatrix device models are supported by the same nbl driver:
 - S1205CQ-A00CSP
 - S1055AS-A00CSP
 - S1052AS-A00CSP
+- S2055AS-A00CHT
+- S2025XS-A00CHT
+- S2045XS-A00CHT
+- S2025XT-A00CHT-F
+- S2045XT-A00CHT-F
+- S2055AS-A00CSP
+- S2048XS-A00CFT
 
 
 Linux Prerequisites
@@ -79,6 +86,7 @@ to be mapped to physical address (PA)
 with the EAL command line option ``--iova-mode=pa``.
 
 Only PF supports coexistence between DPDK and kernel driver; VF does not.
+Draco PFs support coexistence mode only.
 
 
 Prerequisites
-- 
2.53.0

