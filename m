Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6390F606A324
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 16:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dressler.pro header.i=@dressler.pro header.a=rsa-sha256 header.s=uddkim-202310 header.b=bu2W1LqG
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1BBEA40A67;
	Fri, 23 Oct 2026 18:22:57 +0200 (CEST)
Received: from smtp03-ext2.udag.de (smtp03-ext2.udag.de [62.146.106.30])
 by mails.dpdk.org (Postfix) with ESMTP id 112C540268
 for <dev@dpdk.org>; Fri, 23 Oct 2026 18:22:55 +0200 (CEST)
Received: from machine (unknown [37.228.233.148])
 by smtp03-ext2.udag.de (Postfix) with ESMTPA id 7B152E018F;
 Fri, 23 Oct 2026 18:22:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dressler.pro;
 s=uddkim-202310; t=1792772574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pfz4zFEiDpmrA7eqtV3FS0yDQdHIMBGl5LiF8gQk1Wo=;
 b=bu2W1LqGq770sw2VNH77hFcSYbc8fS8+ukJoF4GH3vIFJvZbHZ+EjN79GevrZZVgtD9Fla
 WilufhwfobWBvuyDZT7RIXS1Qzh8iMl/d0Icxj8+101KCFwfxuz+CvbHOnYCWPCb5vxkWI
 ESc4yAb7KgH9krsrKB0kMKg8ptybKH0EdkImsk5sI69Dj6zHIpjwbeLTvKAhEHEFXcaqym
 rjA/83k85TmNsrdZnE9A6AOGLvUeGvIC3comPUVSKCFlfzkEgFm29R9i/lYx0YH8cd8c9y
 dO0D9gAM0nfOq1zAVF3FU09avLbkHSrfuxBlfOjVIiG7F5/hsTvWs/7nSyNP2Q==
Authentication-Results: smtp03-ext2.udag.de;
 auth=pass smtp.auth=dressler-pro-0001 smtp.mailfrom=frank@dressler.pro
From: Frank Dressler <frank@dressler.pro>
To: stephen@networkplumber.org
Cc: dev@dpdk.org
Subject: [PATCH 2/2] test/af_packet: add test for fanout modes
Date: Fri, 23 Oct 2026 17:22:47 +0100
Message-ID: <20261023162247.276245-3-frank@dressler.pro>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261023162247.276245-1-frank@dressler.pro>
References: <20261023162247.276245-1-frank@dressler.pro>
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

The added test checks if the kernel accepts each of the fanout
modes the AF_PACKET PMD supports.

Signed-off-by: Frank Dressler <frank@dressler.pro>
---
 app/test/test_pmd_af_packet.c | 41 +++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/app/test/test_pmd_af_packet.c b/app/test/test_pmd_af_packet.c
index b668ca5b81..478a0a6355 100644
--- a/app/test/test_pmd_af_packet.c
+++ b/app/test/test_pmd_af_packet.c
@@ -992,6 +992,46 @@ test_af_packet_multi_queue(void)
 	return TEST_SUCCESS;
 }
 
+/*
+ * Test: Fanout modes
+ */
+static int
+test_af_packet_fanout_modes(void)
+{
+	static const char * const modes[] = {
+		"hash", "lb", "cpu", "rollover", "rnd", "qm",
+	};
+	uint16_t test_port;
+	char devargs[256];
+	unsigned int i;
+	int ret;
+
+	if (!tap_created) {
+		printf("SKIPPED: TAP interface not available (need root)\n");
+		return TEST_SKIPPED;
+	}
+
+	for (i = 0; i < RTE_DIM(modes); i++) {
+		snprintf(devargs, sizeof(devargs), "iface=%s,qpairs=2,fanout_mode=%s",
+			 TAP_DEV_NAME, modes[i]);
+
+		ret = rte_vdev_init("net_af_packet_fanout", devargs);
+		TEST_ASSERT(ret == 0,
+			    "Failed to create af_packet sockets with fanout_mode=%s: %d",
+			    modes[i], ret);
+
+		ret = rte_eth_dev_get_port_by_name("net_af_packet_fanout", &test_port);
+		if (ret == 0)
+			rte_eth_dev_close(test_port);
+		rte_vdev_uninit("net_af_packet_fanout");
+		TEST_ASSERT(ret == 0,
+			    "af_packet port with fanout_mode=%s has no port id: %d",
+			    modes[i], ret);
+	}
+
+	return TEST_SUCCESS;
+}
+
 /*
  * Multi-threaded test context
  */
@@ -1108,6 +1148,7 @@ static struct unit_test_suite af_packet_test_suite = {
 		TEST_CASE(test_af_packet_frame_config),
 		TEST_CASE(test_af_packet_qdisc_bypass),
 		TEST_CASE(test_af_packet_multi_queue),
+		TEST_CASE(test_af_packet_fanout_modes),
 
 		TEST_CASES_END() /**< NULL terminate unit test array */
 	}
-- 
2.56.0

