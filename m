Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADF5606A31C
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Nov 2026 21:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=jTLsRzF9
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 25D5E4064F;
	Fri, 27 Nov 2026 22:08:20 +0100 (CET)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by mails.dpdk.org (Postfix) with ESMTPS id 293534064A
 for <dev@dpdk.org>; Fri, 27 Nov 2026 22:08:15 +0100 (CET)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-3b3fb193c03so3700941a91.2
 for <dev@dpdk.org>; Fri, 27 Nov 2026 13:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1795813693;
 x=1796418493; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BWkpe9qCMs9BbBrLWhOuYLuHCD+TlRp26+qi56pSuSo=;
 b=jTLsRzF99G5N5cQp6MqjzAr99HRBh+Q22jk1+N5JpEKte4PETNEwy6EIQCxB2cnL29
 NYWKvh5WMGFLr896Vdj7/nrpkBLXLS65tl+Uy5Mt3pRKDlbgBeInGPrxbdifDMwHNi31
 /FvYmfImLJwe/0GKnWxX/OvNqEZs1Yk1+mcZSLnivkK+0oZJxKDMW2esuIS4tgY9FKp7
 gehByl7RzW0XXZVhhAyysi/qUt+rdspncZjX3NyLPwKHB3JVWyjfro5OmXAYWRq2dxPo
 nyGQ/ftLC5bm1b1BzyTYuulybVPfBxSC1t0xiQ8fYIeTUZfpZyH3CL44mEoul1FeH550
 YF/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795813693; x=1796418493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BWkpe9qCMs9BbBrLWhOuYLuHCD+TlRp26+qi56pSuSo=;
 b=wZDt6m/4wXzKhD9L5D+Vzqs3lynQvNoRuvHmGFAB1ZiKwvUX3VpKOyKxHofEYVTYGl
 Z2fWcbALcergMYzX3M5PZkDq33BhEIRv6eE4RP4cM1Ofz4Ho/fKP2I8PY5rSB4ezxT2v
 S/IhncGGa39On9Rr31EcBF/9lDODFUCN59l4jtlo47QnksUuK8UytlaAa+D1hSWOeHsU
 +Rmlsen+a+vLyNUFgxw82GW3jyiOnnMjbtUP9qbL7WFNszLWNgf3H7e9xvJ2hVYBWzi5
 2eFHz2Kg7IslwMyQS2LKXUCqPmDqgFP7T3M7TA/r9LVYO5GQ3mpEau1bInXdz48TRXnD
 STug==
X-Gm-Message-State: APuU4Z9hK6yOIppQBicS7Dhkk6Cs5Wb3VkIKOIxH6GIRSQ0QjX82a5Y2
 nxD37arNhNgui7CLlFR9Y4H4Sh+hHWO3qK7oOeXC2lU9+vi+Gaow5O9do9+HeRBm+0pg8JFah8U
 aSIX5jSU=
X-Gm-Gg: AZFdTZeRisHe5bYZREMtBVuj051cpNXKr1QJ8t6JZ0ZJdnhvmm4EYd96wV2hotUrj/o
 8WKUGFtAnx9Bc15kT/MPMUTb5liPn8Rk1O5tBoBguFUVIr48pKCJ8EVJrPqlXOAq7X8+hXDllaz
 kOWt97fPyHw9AXaiffd1iXF9ZOjfr0xODGOYgKHFLiT806fMy2SkW9rwSyBznGBKQ9QqJVhJe3+
 w3L/fdNPFszR15DJRUwI8ARwI3d9d7F/L04992eE3gNvcLu4QmdwuzPZ5dhfld9UFB2QjNT+B14
 aKy4HaqFRRExgi5I0IsDV4p9SJvMH8HlBU1KzWFBnOelIzSDmNwaPGmqs5f8GAhCqZATXL0FKFZ
 R8lgHV9QK5oo8XDmuu+QDZXcr+3qegdlJDsknrwvH/iNlQ05ORpIJfTRxt9Ab8kF1TGXQ3hwFPQ
 zr8A0GbLdCknIrQJxZLUZyQ33Wv6IqUXGyxoT+ovYsOeG+YdeK7G73tHsFBYgM6Ww3FVvrYvisL
 iZsBZMRpjOKUp1Kj+zMAec5ihCsMWQDUYy2pzio7gRxRT/+gDkLdzxDh6JhgtLs2PrDrrw3mPDi
 ripLLCFLDcQhag4xertdlfjw22cXeV0ux/0Y/ut3ODfdreEeEzyy2vn3zb/7bw109qfi
X-Received: by 2002:a17:90b:3f10:b0:3ac:af8b:6f3 with SMTP id
 98e67ed59e1d1-3b41cb0caa7mr20974493a91.52.1795813693561; 
 Fri, 27 Nov 2026 13:08:13 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b405ffa98esm42457179a91.17.2026.11.27.13.08.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 13:08:12 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH v2 4/6] pdump: release BPF filter on error
Date: Fri, 27 Nov 2026 13:07:06 -0800
Message-ID: <20261127210806.318387-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261127210806.318387-1-stephen@networkplumber.org>
References: <20261028141750.310963-1-stephen@networkplumber.org>
 <20261127210806.318387-1-stephen@networkplumber.org>
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

The BPF filter loaded for a request was leaked if the request
failed. A successful enable keeps it, the callbacks reference it.

Fixes: 278f945402c5 ("pdump: add new library for packet capture")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/pdump/rte_pdump.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/lib/pdump/rte_pdump.c b/lib/pdump/rte_pdump.c
index b5b1c95b07..670ed1bb6a 100644
--- a/lib/pdump/rte_pdump.c
+++ b/lib/pdump/rte_pdump.c
@@ -468,7 +468,8 @@ set_pdump_rxtx_cbs(const struct pdump_request *p)
 		PDUMP_LOG_LINE(ERR,
 			  "failed to get port id for device id=%s",
 			  p->device);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto free_filter;
 	}
 
 	ret = rte_eth_dev_info_get(port, &dev_info);
@@ -476,7 +477,7 @@ set_pdump_rxtx_cbs(const struct pdump_request *p)
 		PDUMP_LOG_LINE(ERR,
 			"Error during getting device (port %u) info: %s",
 			port, strerror(-ret));
-		return ret;
+		goto free_filter;
 	}
 
 	if (queue == RTE_PDUMP_ALL_QUEUES) {
@@ -485,25 +486,29 @@ set_pdump_rxtx_cbs(const struct pdump_request *p)
 		if (nb_rx_q == 0 && flags & RTE_PDUMP_FLAG_RX) {
 			PDUMP_LOG_LINE(ERR,
 				"number of rx queues cannot be 0");
-			return -EINVAL;
+			ret = -EINVAL;
+			goto free_filter;
 		}
 		if (nb_tx_q == 0 && flags & RTE_PDUMP_FLAG_TX) {
 			PDUMP_LOG_LINE(ERR,
 				"number of tx queues cannot be 0");
-			return -EINVAL;
+			ret = -EINVAL;
+			goto free_filter;
 		}
 		if ((nb_tx_q == 0 || nb_rx_q == 0) &&
 			flags == RTE_PDUMP_FLAG_RXTX) {
 			PDUMP_LOG_LINE(ERR,
 				"both tx&rx queues must be non zero");
-			return -EINVAL;
+			ret = -EINVAL;
+			goto free_filter;
 		}
 	} else {
 		if (((flags & RTE_PDUMP_FLAG_RX) && queue >= dev_info.nb_rx_queues) ||
 		    ((flags & RTE_PDUMP_FLAG_TX) && queue >= dev_info.nb_tx_queues)) {
 			PDUMP_LOG_LINE(ERR,
 				"invalid queue %u for port %u", queue, port);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto free_filter;
 		}
 		nb_rx_q = nb_tx_q = queue + 1;
 	}
@@ -512,12 +517,12 @@ set_pdump_rxtx_cbs(const struct pdump_request *p)
 	if (flags & RTE_PDUMP_FLAG_RX) {
 		ret = pdump_check_queues(port, queue, nb_rx_q, true, operation);
 		if (ret < 0)
-			return ret;
+			goto free_filter;
 	}
 	if (flags & RTE_PDUMP_FLAG_TX) {
 		ret = pdump_check_queues(port, queue, nb_tx_q, false, operation);
 		if (ret < 0)
-			return ret;
+			goto free_filter;
 	}
 
 	/* register RX callback */
@@ -557,6 +562,10 @@ set_pdump_rxtx_cbs(const struct pdump_request *p)
 						    DISABLE, p->snaplen);
 	}
 
+free_filter:
+	if (filter != NULL)
+		rte_bpf_destroy(filter);
+
 	return ret;
 }
 
-- 
2.53.0

