Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C3DCC6B19
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 17:16:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DFCD940A77;
	Tue, 13 Oct 2026 19:16:19 +0200 (CEST)
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com
 [209.85.216.98]) by mails.dpdk.org (Postfix) with ESMTP id 67CBE40A77
 for <dev@dpdk.org>; Tue, 13 Oct 2026 19:16:17 +0200 (CEST)
Received: by mail-pj1-f98.google.com with SMTP id
 98e67ed59e1d1-3ab2bf5e75bso1761944a91.3
 for <dev@dpdk.org>; Tue, 13 Oct 2026 10:16:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791911776; x=1792516576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5bQ3GekSM1IX9sNTJCi1GQQF+TC6DFUK2hUzVoxKp/o=;
 b=iZ/M65UhpvAHjmazC7H6djXi88TPlRJE79/y0d84JuF+gZ2LXUby8ukG8gqofck+0f
 FLIcrAi6djF3m2OlNXYWqMTU2PdvXFYZqR/08pgY6XRG6B3pvQu/bOkHGLPmRDjZVQYn
 I0VlmPBGwfEBCotzslWfxlG5Jn3Zwm77dq7uymq/irrA2jqJpQ8OKPfKn6w9YwQatUqi
 TQ38J7nF1PGWh9n8A8JPgpJf/Ip3hsG43smc2wb75T6f25Of+pq4pXNpBT72+0vQZGWh
 5QSg+q79KxJQdgG6MBtiuboUT9PrdOmKr9QWLn0Q5kwoCtdVdE8yEa5nGdnMW218AGrM
 qFug==
X-Gm-Message-State: AFq9FYKsh8GfoIVtUkeEKYG8+XC1ghXanrI1B0cR49lzqYj9YYUgAv7f
 3DhOt7vBmb46xGjF8mAwL2Kx82wQ+OARBjkZ4WkX0ugBqHOu2KMjOjAIX/ro6pF3voCPCcAlPSh
 GPXmtH1e/JX0JwGvTDv7cNz1q2nZ8Dd/cfnMwQ1pkClbsFVY6zPdRCYZTVEz1kNYTp4v4KFLWuB
 y84K/jzG3ZQx3FEbyAZOvkNFsnsFuuzK2k0grnKvawtdcdlxVX3vde32xkSxuC0mROqZsP/2rgN
 CSnISmiRjSp
X-Gm-Gg: AYBFou0HOi9ybDAoEeLXJIyZxy5KDKE8ONqtPk0/Q3JXDDa5W1anwC8ayzOfF5LGQj5
 ElnanQlS8ysZp7ptkrNPrn5SgRyL4y4FQDu8kDu64DExuBPpSkxyf2Oltx2KO/yRQNeCtsUx17X
 nUEqjSN0Gm+2jxHjg8fFz46shkuFnrSs1335qEK2+CmmPPBZioD4Lt8eg94Y4z1vQK2vxDAeFSA
 QCJT94hGZJ1Lll3jPaNoTfdnCNfOx8zUg4rib3QV5jndkisoQclknmQxsvN18LYtR18W4G7xJuR
 DFE5a2uJdSEMpPpBRTyoOnFe0QFpForS1+XTHyEgRvSWB1QTXzSRU9Yd4+mn6fMcz9Xkj8T7HIc
 Bz4RdXqYhKMu5g9wSfF6CSPeDaXXVzx8vQj5ynFJhItYjg2sSYqU29aW/QDXs8KvinZTm5geobD
 PFefvlCaoFr0SpZy0+mkw1sjAaUoD0YploxMZpHLZxymgUcYPnkJBw
X-Received: by 2002:a17:90b:3143:b0:3aa:548f:eb77 with SMTP id
 98e67ed59e1d1-3ab3ac95141mr12309016a91.56.1791911776332; 
 Tue, 13 Oct 2026 10:16:16 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3ac5f1e2cd0sm124327a91.6.2026.10.13.10.16.15
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 13 Oct 2026 10:16:16 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91786abb5abso51934856d6.3
 for <dev@dpdk.org>; Tue, 13 Oct 2026 10:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1791911775; x=1792516575; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5bQ3GekSM1IX9sNTJCi1GQQF+TC6DFUK2hUzVoxKp/o=;
 b=K12gHSdUjpjnlxc7U6gtsUJF+Qg0ILOa2b8sWOAfbJLDRNFsOhuMT1I6XdR8WD3xmG
 mqO47Jxbb1Im6eU6bEKzz7KH94++uZzJz5uL4S2RG3mGlBtxS7txAsKO60EF3g/ZoC9I
 ZSQWU1S+bFGoCMfhmjS0IBizh5k3fnMxvxs34=
X-Received: by 2002:a05:620a:470b:b0:93e:c12c:440b with SMTP id
 af79cd13be357-93ec12c4a20mr2073002685a.71.1791911774623; 
 Tue, 13 Oct 2026 10:16:14 -0700 (PDT)
X-Received: by 2002:a05:620a:470b:b0:93e:c12c:440b with SMTP id
 af79cd13be357-93ec12c4a20mr2072995685a.71.1791911773734; 
 Tue, 13 Oct 2026 10:16:13 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93ef5028051sm283063785a.18.2026.10.13.10.16.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 10:16:13 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, manish.kurup@broadcom.com,
 Dakota Sicher <dakota.sicher@broadcom.com>,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH v2 2/2] net/bnxt: remove VLA from EM key block swap
Date: Tue, 13 Oct 2026 11:19:55 -0600
Message-ID: <20261013171955.452416-3-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261013171955.452416-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20261005151727.1706155-1-manish.kurup@broadcom.com>
 <20261013171955.452416-1-Mohammad-Shuab.Siddique@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

From: Dakota Sicher <dakota.sicher@broadcom.com>

ulp_mapper_blob_block_swap() used a variable-length array on the
stack as scratch space for the block swap. The block size comes from
the device table and is small, but a VLA is still undesirable. Swap
the blocks in place instead, which needs no scratch buffer.

Signed-off-by: Dakota Sicher <dakota.sicher@broadcom.com>
Signed-off-by: Manish Kurup <manish.kurup@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
 drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c b/drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c
index 2d89f10d5e8..2cba6fffa81 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c
@@ -388,10 +388,9 @@ static const char * const mpc_error_str[] = {
 static int32_t
 ulp_mapper_blob_block_swap(struct ulp_blob *blob, uint32_t block_sz)
 {
-	uint8_t data[block_sz]; /* size of a block for temp storage */
 	uint16_t num_words, data_sz;
-	uint8_t *pdata;
-	int i;
+	uint8_t *pdata, *lo, *hi, tmp;
+	uint32_t i, j;
 
 	/* Shouldn't happen since it is internal function, but check anyway */
 	if (unlikely(blob == NULL || !block_sz)) {
@@ -407,13 +406,16 @@ ulp_mapper_blob_block_swap(struct ulp_blob *blob, uint32_t block_sz)
 		return -EINVAL;
 	}
 
+	/* Swap the blocks in place, one byte at a time, no temp buffer */
 	num_words = data_sz / block_sz;
 	for (i = 0; i < num_words / 2; i++) {
-		memcpy(data, &pdata[i * block_sz], block_sz);
-		memcpy(&pdata[i * block_sz],
-		       &pdata[(num_words - 1 - i) * block_sz], block_sz);
-		memcpy(&pdata[(num_words - 1 - i) * block_sz],
-		       data, block_sz);
+		lo = &pdata[i * block_sz];
+		hi = &pdata[(num_words - 1 - i) * block_sz];
+		for (j = 0; j < block_sz; j++) {
+			tmp = lo[j];
+			lo[j] = hi[j];
+			hi[j] = tmp;
+		}
 	}
 	return 0;
 }
-- 
2.47.3

