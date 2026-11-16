Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA05C606A31C
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Nov 2026 04:06:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0183840150;
	Mon, 16 Nov 2026 05:06:41 +0100 (CET)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTPS id 38054400EF
 for <dev@dpdk.org>; Mon, 16 Nov 2026 05:06:40 +0100 (CET)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C84C91A0007;
 Mon, 16 Nov 2026 05:06:39 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8EB491A0006;
 Mon, 16 Nov 2026 05:06:39 +0100 (CET)
Received: from lsv03457.swis.in-blr01.nxp.com (lsv03457.swis.in-blr01.nxp.com
 [92.120.147.250])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id B015F180006C;
 Mon, 16 Nov 2026 12:06:38 +0800 (+08)
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com,
	hemant.agrawal@nxp.com
Subject: [PATCH v4 0/1] DPAA compilation fix ppc64le and riscv
Date: Mon, 16 Nov 2026 09:36:34 +0530
Message-Id: <20261116040635.639732-1-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261027093335.4109017-1-g.singh@nxp.com>
References: <20261027093335.4109017-1-g.singh@nxp.com>
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

V4-Changes:
- Remove the Patch:
  "bus/dpaa: fix maybe-uninitialized in bman_release_fast"
  as it is already squashed to the next-net.

V3-changes:
- fixed num usage in bman_release()

V2-changes:
- updated the Author name.

Gagandeep Singh (1):
  bus/dpaa: fix unneeded conditional in bman_release

 drivers/bus/dpaa/base/qbman/bman.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

-- 
2.25.1

