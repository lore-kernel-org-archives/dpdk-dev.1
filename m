Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4780BCA5FD4
	for <dpdk-dev@archiver.kernel.org>; Fri,  2 Oct 2026 17:17:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D1D24026C;
	Fri,  2 Oct 2026 19:17:13 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id 1E5304003C
 for <dev@dpdk.org>; Fri,  2 Oct 2026 19:17:12 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-396ccc09d65so121756a91.3
 for <dev@dpdk.org>; Fri, 02 Oct 2026 10:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790961431;
 x=1791566231; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=r01naxdc34IOYSKSD5/3wAn1+wkQTocZLMHcfOWRRGc=;
 b=W4xCfmCS/e8nY270Iv8BXi/Fgi6RjhKtW3sJZMgdpxMyS6Mxbmxfnp/KH+vdMBGjT8
 egnchlr/6g7xfX4IvSkkrEAzjcEXNbY7l0l4hsJWqTkPyB3VF6FbBJkgQaGZreEhPUQF
 pcYWck+Qe6UtShEg6Wwa4HDzSj/JjF2RlyqIXJ2+ix4ioAxQ0B4Lx8d7GCA3MoMLDFhG
 NrWydKNp+MZ5TtcVXg8zq0uGJFN8oJDVSCJm78hBDxfojhY1MBf1RxPKxNyhxK8ch4Oa
 qw02EBmYPjDD2yhKh5lol+33qwKs23fRjB2+LxoOlUdvXAQ9LD4uD74kDSm5Dk++KoGz
 fu9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790961431; x=1791566231;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=r01naxdc34IOYSKSD5/3wAn1+wkQTocZLMHcfOWRRGc=;
 b=oxxs2TR6oJUMcESnBO3zbZp20Wt99i9TLdIbqt+1sMb8++11EDQvBt7ASP3kyqDZYn
 HHwWHrFuldQEev4whdibZzbLMIscboNF73gndL/7orqpg24HYSPabjSekKLeBD6/b+op
 kinh1sq6TytbzzSrAuPXIkunWjLOGTK9EVzfxMXUlfKMsVg8jQh67WhikW8zGCMFZQB/
 ksDDsSWZfMe8kZCqEvprK9Hf85sOJ5RjMyuKUdi771LOar0EzgqMB/nIMAFdBHB6JpKr
 /TTHpvCFlRQFtT0WjWcZo7dfu1Uj5DGm1iJFXl3hGeKtKle+FUkzGi5A9LUWDglMM6fs
 6NiA==
X-Gm-Message-State: AFq9FYL4i9LIoeLbT4hcPWBJ7FTSd+JuD0tiCsaBm5f2GJ+KgbmP7FI+
 zhW7rQN8nprLkEF40Q/OQVxZue81oK+Zkj6BXKsMIpdr+Ly637xBYoWBVLNogHI+yPrg1cwfZiz
 JvM7c8hs=
X-Gm-Gg: AYBFou2Jhst2Qna5dB2CNY27PrihiM3tfqhHrzkwgjYOEc3o9cIG8cJT8UhL15auiYt
 VLOKAfjVYTgDKzPaHgEUXS2kanZ36KQqFfn8w3IH6TR/8m2yKzop6Z30A5fXR7XhEzmcx9FtXla
 ilYlVTNqu0tbPZX9z23emCU1p/phwGm4RZ+KRN2+S5jKNCnqBmT2n5hi4EQ9gL+74kgjds0YJ3S
 BBAn/JBePmqZMC07vkMN1GUY/pLJ5fcfFJymlbS5YYPV9d/Cvdq2j11NOotYVtwe5ca9Xmrzpg5
 o3qa0rXgraXPnJZdCto50eCKXWJXkihg0GqYYSkLCzr8RqH+99Y7c39v6Zh3tr0hEeGkSfcsdQP
 jqrWqToop5n3K88Y2RV1KA4Va7/VK1sUIfYOq+i2S+uB+54y/YgkxZ5tOd3xBHX7TXUHF4+u6Es
 pZQ6n5xhlrDe+06aXbrJ2qQSe/VmFrg6dYWqqfNifUz7oKhOQRQHLRSI1XlCpcKFmZKT+w8QOfq
 7MMIu7jdG4O4nt1S7CXNrOeIpjs3/F/Lxr0RA==
X-Received: by 2002:a17:90b:4a4e:b0:3a0:a83d:dd0c with SMTP id
 98e67ed59e1d1-3a6ce6dc8f9mr3199783a91.17.1790961430772; 
 Fri, 02 Oct 2026 10:17:10 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e4b068a060sm6793025ad.56.2026.10.02.10.17.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 10:17:10 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH] test: remove unneeded null check before free
Date: Fri,  2 Oct 2026 10:17:07 -0700
Message-ID: <20261002171707.928034-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

Found by devtools/null_free.cocci.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_cksum.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/app/test/test_cksum.c b/app/test/test_cksum.c
index 73f2511731..d94539820a 100644
--- a/app/test/test_cksum.c
+++ b/app/test/test_cksum.c
@@ -320,8 +320,7 @@ test_l4_cksum_mbuf_chain(struct rte_mempool *pktmbuf_pool, const char *pktdata,
 	return 0;
 
 fail:
-	if (m_hdr)
-		rte_pktmbuf_free(m_hdr);
+	rte_pktmbuf_free(m_hdr);
 
 	return -1;
 }
-- 
2.53.0

