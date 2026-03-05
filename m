Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FA8F47CA3
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Mar 2026 17:54:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 38B4E427BF;
	Thu,  5 Mar 2026 18:53:47 +0100 (CET)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com
 [209.85.219.47]) by mails.dpdk.org (Postfix) with ESMTP id 1531D427A9
 for <dev@dpdk.org>; Thu,  5 Mar 2026 18:53:44 +0100 (CET)
Received: by mail-qv1-f47.google.com with SMTP id
 6a1803df08f44-89a05955720so57791206d6.2
 for <dev@dpdk.org>; Thu, 05 Mar 2026 09:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772733223;
 x=1773338023; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oXpYr40cj52PPNa10uK4B4BpDCqwjt/OhTAo308dOR0=;
 b=v8qHCPiiP5tPur2NldLjG2bLufmU5SnpKFqVpJkwGjZRbZJpe1DdoSjrWI2LRNgzbp
 VrFLGs64bC9dZJUwU9am+T8Fo0Q3bKZSCY/tk6Jjar+8mHJRpGIfsFluCh16ZxXVCjc9
 svpBGOCXNDPNsTaSfPInpQmaDPjW/1Oo5xU9ijkeTl8ph+AVJqBd5NdAu/cRC7QxCcKs
 AbEWbjuO8eZYxJNRblYp3Ab3O6nqUs4VuIQnseIc9rbjPRtWfn9JBo6MSJWRQ9BCg+F4
 9sYTt4OovhaH/Nh/SI+nqgXN7pCY1r/En2Ixpo7b9sqiab5+fBOeDBbi9uRyS7zrj/kI
 tnFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772733223; x=1773338023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oXpYr40cj52PPNa10uK4B4BpDCqwjt/OhTAo308dOR0=;
 b=b32dL9Nb0xwRgHfbeNJE0U8pmj5Qg66GbS47+Ccz20IlYcvscIEz9WSgPCwZnmygMF
 z+W8xJBMb23Hk4hHoXYcWuNmoMBLj9LO1brIU+9NIkS1RI+mwH1tULk+xJpPkAa3OvSd
 +rKjKfzbxCxjsKmA6rOU6jQd4za5Zp78lyNOY4bLQSwaJJ5U5JujSuGhVfoCadRpPl+R
 sEOKPycqvSU+mq7TxNBQtu2Bt+6TjFalCiifjzo/DC/QjaQO4FpyLaAc8jTUjx+QTgQe
 6VVvXIhGFQSYpSaBC0UybKdNHYOxxN4sp3O5fAnEZy8LvOkwImWfejChJ+cz/Wjg80kX
 EzVw==
X-Gm-Message-State: AOJu0Yw2ZIjK9P/VsqtHRlsxxwmfebvTtMQ2is5bqcpG1JofeFAnGSXp
 3guZCFVn4hhSyxiY8oAIg/O9UpLkMJFG71PpNphMe1Sx+0XMC4KMxrnsIZew0BTjXSq8fPNH+27
 qkFWy
X-Gm-Gg: ATEYQzxQAJwCiE2gRJf+CQZEX3mENJrrtooIQjqiXiv1abxZ2CDX8ln3Ql5NDCjG5Nt
 R/s6dVOM/kyfEPcQahhHeysSTIaBUR7hIigFK5EhtGRvujjzliA1hgs5kjMn5aTRZW81jNoNqG6
 NcPGN+9tIkX1W+obdVJKdEZigHsVMYfLZyDjRhOL4QvO6x43zbOTWSdsbykA5au5cZV8PClMZ2i
 d5ZpUjDe4HFqR2VgETYhr1kYWmoXGnLRfPALvfwBw4gOJNiyY4Om0X75vFwY3PMk2DQpqkRQSM4
 ZB91jTDbnz3D3JOpZZRdNxmj3DkqVDDqz8wb3XV3q94VNVz7aYAGqf+SaV7B+Con70AM+4FDLEW
 h6HpW+5HJ9xubKOnVi6QivDm+Ykn5NkFkGVcDha7rasvKD28/FEd1wUhF8wb5TukeieoT2xOX65
 60RXxf/yoSeyNMvBz0hcUsVN1DFW19ji9cpejxq3a/xevROQM6mF6zDbltMReZ0Q==
X-Received: by 2002:ad4:5ce6:0:b0:899:f24d:1245 with SMTP id
 6a1803df08f44-89a19aee7f0mr101377036d6.43.1772733223350; 
 Thu, 05 Mar 2026 09:53:43 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a05b72186sm80667766d6.50.2026.03.05.09.53.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 09:53:42 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Marat Khalili <marat.khalili@huawei.com>
Subject: [PATCH v4 11/11] test/bpf: pass correct size for Rx/Tx load tests
Date: Thu,  5 Mar 2026 09:51:05 -0800
Message-ID: <20260305175326.279891-12-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260305175326.279891-1-stephen@networkplumber.org>
References: <20260118201223.323024-1-stephen@networkplumber.org>
 <20260305175326.279891-1-stephen@networkplumber.org>
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

Use the correct size in bpf_prm to help with validation.

Fixes: 81038845c90b ("test/bpf: add Rx and Tx filtering")
Cc: stable@dpdk.org

Suggested-by: Marat Khalili <marat.khalili@huawei.com>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Marat Khalili <marat.khalili@huawei.com>
---
 app/test/test_bpf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
index 144121ac79..dd24722450 100644
--- a/app/test/test_bpf.c
+++ b/app/test/test_bpf.c
@@ -4180,7 +4180,7 @@ static int bpf_tx_test(uint16_t port, const char *tmpfile, struct rte_mempool *p
 	const struct rte_bpf_prm prm = {
 		.prog_arg = {
 			.type = RTE_BPF_ARG_PTR,
-			.size = sizeof(struct rte_mbuf),
+			.size = sizeof(struct dummy_net),
 		},
 	};
 	int ret;
@@ -4279,7 +4279,7 @@ static int bpf_rx_test(uint16_t port, const char *tmpfile, struct rte_mempool *p
 	const struct rte_bpf_prm prm = {
 		.prog_arg = {
 			.type = RTE_BPF_ARG_PTR,
-			.size = sizeof(struct rte_mbuf),
+			.size = sizeof(struct dummy_net),
 		},
 	};
 	int ret;
-- 
2.51.0

