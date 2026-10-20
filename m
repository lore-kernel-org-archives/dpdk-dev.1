Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24EC60A383B
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 17:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dressler.pro header.i=@dressler.pro header.a=rsa-sha256 header.s=uddkim-202310 header.b=TI77bQaT
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F3600402CE;
	Tue, 20 Oct 2026 19:37:44 +0200 (CEST)
Received: from smtp04-ext3.udag.de (smtp04-ext3.udag.de [62.146.106.41])
 by mails.dpdk.org (Postfix) with ESMTP id CDA1940151;
 Tue, 20 Oct 2026 19:37:43 +0200 (CEST)
Received: from machine (unknown [37.228.233.148])
 by smtp04-ext3.udag.de (Postfix) with ESMTPA id A3192E017E;
 Tue, 20 Oct 2026 19:37:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dressler.pro;
 s=uddkim-202310; t=1792517862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=JM/KBgLzvbYzjNdtfvIIVW8LnKK0jHaaIKAA4D5GW7M=;
 b=TI77bQaThJmBJHpUgluCAKYH4oIrrDjhjIcz+1A8PFxuZ5EUGsZfskZYVW/0OSF0fOWCgW
 mVgWFuRtNYg0dAiFQIdqpmE+/aqeeMAdhAK2GyegOdza8CIRVotyug4AzoOqFBhDpYKG6w
 KHELXdNX1Bno0SMW696vCRyEwNggIunDBynAbrclSSs+F+zP8z+XwzrIyBWBFfeH2KoRGp
 KOEzW03Pzfpn3Y3yhPbVe4sT57GYHw8/B6mV0bkxDSuRPQW1ahjp+JQZHFFxJQzDxztRjj
 hiZPvqPvikPud/84hJRAJiv55SFwP0ndWqmbzYj93Udc7QE0wkheogaaxju4+w==
Authentication-Results: smtp04-ext3.udag.de;
 auth=pass smtp.auth=dressler-pro-0001 smtp.mailfrom=frank@dressler.pro
From: Frank Dressler <frank@dressler.pro>
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	stable@dpdk.org,
	tiago.lam@intel.com
Subject: [PATCH 1/1] doc: fix qdisc bypass default
Date: Tue, 20 Oct 2026 18:37:35 +0100
Message-ID: <20261020173735.94410-1-frank@dressler.pro>
X-Mailer: git-send-email 2.56.0
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
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_PDS_PRO_TLD,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The guide incorrectly stated that qdisc bypass is disabled by
default. However, it has actually been enabled by default ever
since the introduction of the PMD in 2014 (364e08f2bbc0).

Fixes: 6ef75e405d5a ("doc: add af_packet PMD guide")
Cc: stable@dpdk.org

Signed-off-by: Frank Dressler <frank@dressler.pro>
---
 doc/guides/nics/af_packet.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/guides/nics/af_packet.rst b/doc/guides/nics/af_packet.rst
index 1505b98ff7..6ef56254bc 100644
--- a/doc/guides/nics/af_packet.rst
+++ b/doc/guides/nics/af_packet.rst
@@ -22,7 +22,7 @@ Some of these, in turn, will be used to configure the PACKET_MMAP settings.
 *   ``iface`` - name of the Kernel interface to attach to (required);
 *   ``qpairs`` - number of Rx and Tx queues (optional, default 1);
 *   ``qdisc_bypass`` - set PACKET_QDISC_BYPASS option in AF_PACKET (optional,
-    disabled by default);
+    enabled by default);
 *   ``fanout_mode`` - set fanout algorithm.
     Possible choices: hash, lb, cpu, rollover, rnd, qm (optional, default hash);
 *   ``blocksz`` - PACKET_MMAP block size (optional, default 4096);
@@ -75,7 +75,7 @@ framecnt=512):
 
 .. code-block:: console
 
-    --vdev=eth_af_packet0,iface=tap0,blocksz=4096,framesz=2048,framecnt=512,qpairs=1,qdisc_bypass=0,fanout_mode=hash
+    --vdev=eth_af_packet0,iface=tap0,blocksz=4096,framesz=2048,framecnt=512,qpairs=1,qdisc_bypass=1,fanout_mode=hash
 
 Features and Limitations
 ------------------------
-- 
2.56.0

