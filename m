Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FA7606A328
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 09:42:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8AA9E40283;
	Tue, 20 Oct 2026 11:42:52 +0200 (CEST)
Received: from out28-1.mail.aliyun.com (out28-1.mail.aliyun.com [115.124.28.1])
 by mails.dpdk.org (Postfix) with ESMTP id 7F85040144
 for <dev@dpdk.org>; Tue, 20 Oct 2026 11:42:50 +0200 (CEST)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.2845634|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.00661468-0.00238667-0.990999;
 FP=10318946105463281324|0|0|0|0|-1|-1|-1;
 HT=maildocker-contentspam033025068124; MF=dimon.zhao@nebula-matrix.com; NM=1;
 PH=DS; RN=2; RT=2; SR=0; TI=SMTPD_---.jliCkFk_1792489362; 
Received: from ubuntu.localdomain(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.jliCkFk_1792489362 cluster:ay29) by smtp.aliyun-inc.com;
 Tue, 20 Oct 2026 17:42:47 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dev@dpdk.org
Cc: Dimon Zhao <dimon.zhao@nebula-matrix.com>
Subject: [PATCH v1 0/1] allow MTU change when port is started
Date: Tue, 20 Oct 2026 02:42:26 -0700
Message-Id: <20261020094227.166491-1-dimon.zhao@nebula-matrix.com>
X-Mailer: git-send-email 2.34.1
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
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Remove the dev_started check in nbl_mtu_set() to allow MTU
configuration while the port is started.

Dimon Zhao (1):
  net/nbl: allow MTU change when port is started

 drivers/net/nbl/nbl_dev/nbl_dev.c | 7 -------
 1 file changed, 7 deletions(-)

-- 
2.34.1

