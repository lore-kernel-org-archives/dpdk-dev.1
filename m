Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A99606A330
	for <dpdk-dev@archiver.kernel.org>; Sat, 21 Nov 2026 16:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=snlCpzER
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DDD6540395;
	Sat, 21 Nov 2026 17:53:19 +0100 (CET)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTPS id DB4A8402E8
 for <dev@dpdk.org>; Sat, 21 Nov 2026 17:53:17 +0100 (CET)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2f0634667aaso3131005ad.0
 for <dev@dpdk.org>; Sat, 21 Nov 2026 08:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1795279996;
 x=1795884796; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cbJuafJKo9CvaSqGanK04b++H3+YmjpP3h+FWgxbzrQ=;
 b=snlCpzER6BWVlyU0nJ+BqCiTKfOCobyTctE9qvh0ye8rmXtVhISPRoADWu0x/lQyX1
 5bfpznLhvRBiV02N7r1zo6ncR8Qd71Z2rFZrNvW5Lg3HkR0qs9Gr7zoC5Skm5QWDpI2X
 vECEIzKvGDQ9Fc5w1tUsvAP44CMft30i/zkBZIj72W2KtKrhfYa/pQoO2u93vjqiOb2A
 w+BWEAvN6DGWGOfvmhQUu27/Aim4xEUrzm2Ng3bhUzbjIxXf6lsDdKlhobtaRs/1UKAf
 CzxwSkY4ukwTfcy4UyFxe5sO/A0ax0cypM0kjm/+DbJorcq7321Bj9d8JHpgkScT7Sf7
 ZR2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795279996; x=1795884796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cbJuafJKo9CvaSqGanK04b++H3+YmjpP3h+FWgxbzrQ=;
 b=XDka/WUmzoMFCpJt5wcgd+yR9/UFMYZmbkKsbi0b+nRaihEezLga/T3s2+WW2wgTXd
 WrX8vN0ry+kJpid03X0wrlO7nt90r/ioxZRm2tPPHTRlp13m65IX2AYjfK2oZh/BANtP
 aD3/8zKqT/7UHkttcRpaXEzYVoaTn+T1GpEL9OzZOayXNSSo4gMx+308+8/i7bcw7393
 n3m4LmNjJwMMxYOQqQzBwUDrZ6dh/neA+5GY7tuMjIkJIiOg4pGw0TtkjX5ZaPW53J1W
 AsXGvsUxhakXO0frsvQgJKon6GJQrK+xajd+NnCX9lzNmmeXcSjInI+7/z5QvwATEw3R
 G0yg==
X-Gm-Message-State: APuU4Z+NAz1TNWU/rqKxe+mCv7l5qbxDjreE1nyWu02ECc1/IeV4adOx
 7SsGIK0a/37OfzwNuUsvLS0/k/bIGyVW0DaFR/795HBCbIqt4/EM5FVpm0LTcs4l+Os8SldSvSO
 cROq6yKg=
X-Gm-Gg: AZFdTZc0fck7Hrt384U2qyPd1RqR/Vb6VKaCSO/BiXwuIlBSwLdzv1tNl4q/0APrObA
 Uv1+xdXhydOgrF2MJpMZNmoehQ7jr5wGnjFRObqUYsSRmbsUcFdlluZa7YSvei8LAUbAxVpIfIF
 tSCkL27QSyswLs/RvyN+9mfG0PlFJfVPuUVfvDVXZWloSeUEq8OodCoegwTNa0x3BcCGB6DzZb9
 dI3GSYfs0eSg/vqoWtm5VLNkoQ4Mw6bkvdK2o5qzFON4w7zVmtVsCdDRPQGGk8S0XxKrvg6rvuX
 R/pI94+DujoZ5aO2yBAxxg8wU5XAU2rjVZnMT1uy9aKEta7j+QLpi6px6jLx6f/GnfIF+8btiGO
 o2tWjEtJSpa5aHCEYoyZ+1rpJL34XJh3L2s2IWdRf5tFtykPPG/N7w/XvK8BTWMPn6UED7sE8Fi
 I/jBHLenn8cpUzpoYVtQo/dwE/4snKarNplEEELdMi6ENxMdpbnYOe1566ZPJJ9olokH/9NE5ar
 LvmekohferbOEBibacBJ37OS7VQLqs0g1Zkh/RB70ZCInyMdSCCUQxXi7WlhTN3K8mQqkDyJD1D
 2XU9dVv4QGI7Rl6KVKj2PR5kivKJIAkYPbXn5WzwAEu3Lki1oFwGoNawCle4+w0jWc34bQ==
X-Received: by 2002:a17:90b:442c:b0:3ab:8288:b8ce with SMTP id
 98e67ed59e1d1-3b41c92c161mr4230287a91.24.1795279996261; 
 Sat, 21 Nov 2026 08:53:16 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b405ec698dsm12104874a91.14.2026.11.21.08.53.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 08:53:15 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH 2/2] test: add test for IPv6 fragmentation id
Date: Sat, 21 Nov 2026 08:51:53 -0800
Message-ID: <20261121165311.1547352-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261121165311.1547352-1-stephen@networkplumber.org>
References: <20261121165311.1547352-1-stephen@networkplumber.org>
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The fragment id's must be consistent across all fragments
and should be random.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_ipfrag.c | 54 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/app/test/test_ipfrag.c b/app/test/test_ipfrag.c
index 247575d6c5..e518b5eb3a 100644
--- a/app/test/test_ipfrag.c
+++ b/app/test/test_ipfrag.c
@@ -483,6 +483,57 @@ test_ip_frag(void)
 	return result;
 }
 
+/*
+ * All fragments of one IPv6 packet carry the same Identification, and two
+ * packets get different ones (RFC 8200 section 4.5).
+ */
+static int
+test_ipv6_frag_id(void)
+{
+	rte_be32_t ids[2];
+	size_t i;
+
+	for (i = 0; i < RTE_DIM(ids); i++) {
+		struct rte_mbuf *pkts_out[BURST];
+		struct rte_mbuf *b = rte_pktmbuf_alloc(pkt_pool);
+		int32_t len, j;
+
+		RTE_TEST_ASSERT_NOT_EQUAL(b, NULL, "Failed to allocate pkt.");
+
+		v6_allocate_packet_of(b, 0x41414141, 1400, 64, IPPROTO_ICMP,
+				      rte_rand_max(UINT16_MAX));
+
+		len = rte_ipv6_fragment_packet(b, pkts_out, BURST, 1280,
+					       direct_pool, indirect_pool);
+		rte_pktmbuf_free(b);
+		RTE_TEST_ASSERT_EQUAL(len, 2, "Failed to fragment packet %zd.",
+				      i);
+
+		ids[i] = 0;
+		for (j = 0; j < len; j++) {
+			struct rte_ipv6_fragment_ext *fh =
+				rte_pktmbuf_mtod_offset(pkts_out[j],
+					struct rte_ipv6_fragment_ext *,
+					sizeof(struct rte_ipv6_hdr));
+
+			if (j == 0)
+				ids[i] = fh->id;
+			else if (fh->id != ids[i]) {
+				test_free_fragments(pkts_out, len);
+				RTE_TEST_ASSERT(0,
+					"Fragments of packet %zd differ in id.",
+					i);
+			}
+		}
+		test_free_fragments(pkts_out, len);
+	}
+
+	RTE_TEST_ASSERT_NOT_EQUAL(ids[0], ids[1],
+				  "Two packets share a fragment id.");
+
+	return TEST_SUCCESS;
+}
+
 static struct unit_test_suite ipfrag_testsuite  = {
 	.suite_name = "IP Frag Unit Test Suite",
 	.setup = testsuite_setup,
@@ -490,7 +541,8 @@ static struct unit_test_suite ipfrag_testsuite  = {
 	.unit_test_cases = {
 		TEST_CASE_ST(ut_setup, ut_teardown,
 			     test_ip_frag),
-
+		TEST_CASE_ST(ut_setup, ut_teardown,
+			     test_ipv6_frag_id),
 		TEST_CASES_END() /**< NULL terminate unit test array */
 	}
 };
-- 
2.53.0

