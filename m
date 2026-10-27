Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47779606A31A
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Oct 2026 06:31:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B0A26400D7;
	Tue, 27 Oct 2026 07:31:34 +0100 (CET)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTPS id F2B53400D5
 for <dev@dpdk.org>; Tue, 27 Oct 2026 07:31:32 +0100 (CET)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id ABCE01A0142;
 Tue, 27 Oct 2026 07:31:32 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 764901A0138;
 Tue, 27 Oct 2026 07:31:32 +0100 (CET)
Received: from lsv03457.swis.in-blr01.nxp.com (lsv03457.swis.in-blr01.nxp.com
 [92.120.147.250])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 960CB18000B5;
 Tue, 27 Oct 2026 14:31:31 +0800 (+08)
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com,
	hemant.agrawal@nxp.com
Subject: [PATCH v2 0/1] DPAA compilation fix ppc64le and riscv
Date: Tue, 27 Oct 2026 12:01:30 +0530
Message-Id: <20261027063131.3979699-1-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261027061531.3970219-1-g.singh@nxp.com>
References: <20261027061531.3970219-1-g.singh@nxp.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

V2-changes:
- updated the Author name.

Stephen Hemminger (1):
  bus/dpaa: fix maybe-uninitialized in bman_release_fast

 drivers/bus/dpaa/base/qbman/bman.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.25.1

