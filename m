Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A996C0219E
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 17:38:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9614C40E18;
	Tue, 11 Feb 2025 18:37:43 +0100 (CET)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50]) by mails.dpdk.org (Postfix) with ESMTP id 0E46040DDA
 for <dev@dpdk.org>; Tue, 11 Feb 2025 18:37:40 +0100 (CET)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-2f9f5caa37cso10061429a91.0
 for <dev@dpdk.org>; Tue, 11 Feb 2025 09:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739295459;
 x=1739900259; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AZmRfVHuNAu8WwJa8G2gVzrRUKoolZ9gQmZARtWp9Nw=;
 b=z789w4hJk98DYfXDcAcsaLqgfWkWw3RRgcf3buKK0+RGTtqFUKBwh/YVpjx0cD5oIA
 o/Pk3b3t5VqZnwLr7Xi63owFNPUuo3oXNdgg+b7QfPYQjfGfKEuieEGdt5WGXyN1QOye
 VMTLNr1hPXz8sBRimNzgVEjBr3ZnRwTHtqdswD8Ow4WAXYDsedAYiZWHHxHF6kumldkR
 eB9lvcszkAtpWe5fLlnyGaNSTYFdU8A6Du7qe4Zbjf0kSmRUJU+XqQvRwhVaK4VypvpB
 rJClgnKEP0brjq4TmasHeoIhLfCoczrTet4kHicbTdIuq9frKRou90xQjBI+yHmP3TMu
 1Wxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739295459; x=1739900259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AZmRfVHuNAu8WwJa8G2gVzrRUKoolZ9gQmZARtWp9Nw=;
 b=qghpMR9owr21fT5PvM+DgeNFLo1U/A2gMdz9AUwQGTKpR8EYLp4o9TB+XdGUQSvAXq
 OqCYpGisinJDCbPxE2how7bgTNgRFs5V7Q9p8UaV4UfHBnh+7DnTmHfpubP9yN8LZWUQ
 FDI8hWg2bhIB9jr3A83KfRkhHhSa6u+tlawOprrf78s2AmhhFPFn3C4LibNYrzVeg458
 4XgroHf34i6boB1kAYNK4HEYjrNQdGgrSt8UPTpLXJhAgqeG0FvYjFUhnE3l18cJ6ToG
 EFptfr9RF0EwctOIOKSeAdG2hpK0fGfj27Tk94eTxIOxUxySl5LsliwY1BpPSbqCD3Fy
 LGgA==
X-Gm-Message-State: AOJu0Yzc7NJNy5upbsRPBFZfqvCczO01gjmXj55Q6TlbrSnUaBXdQt+Y
 4Ff34J/JWD5XVGvr2x3w2mUOU+TLIWL/UpvP8N6eRmpPb+QqH2OLFjrE9alwQ//j/kTy+KUJyVY
 R
X-Gm-Gg: ASbGncsM8mA0sSxEZQKs32+QO9/+sB5yhgirHm/Hfh/M/YCfLbGcnU+V/mGXS9HxXjM
 AZoAuHxuePgoMdBAXsr7PxXMENHCO9bnoSNcpeCJXPuUxEg6RCfislMEH/H4e1zEPADC3elFn19
 FhYJBV3bh/9giqiPZFPtmEG8AafoudIVEYY0TSknWUinR0XmeAaUVmmAEfhWkqSYfh137Ke0vyl
 ytcKPjLGWwCYdvuYtKmhH1qy6GGvOFqTkA0cTWmQZfLoBuPOwAROYzxSefEM+bjokA691jhOrHI
 NxGU/+y3wo05ljE3BYeh7YCs3CVL3WxYI3cJcQFa49VjsQvjnmGF5HhTvD9q+OL6wHhK
X-Google-Smtp-Source: AGHT+IFjlPVOdDcIK1nKO4ql9VCjlNtc3e/rbIS410rnedV8sr+dFfdoZvqE3KL5BTSayFG1bfdZVg==
X-Received: by 2002:a17:90b:56c3:b0:2fa:562c:c1cf with SMTP id
 98e67ed59e1d1-2faa05deecemr6780049a91.1.1739295458746; 
 Tue, 11 Feb 2025 09:37:38 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa4656bd27sm7131811a91.42.2025.02.11.09.37.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 09:37:38 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Ashish Gupta <ashish.gupta@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>
Subject: [PATCH v5 07/11] compress/octeontx: remove unnecessary memset
Date: Tue, 11 Feb 2025 09:35:27 -0800
Message-ID: <20250211173720.1188517-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250211173720.1188517-1-stephen@networkplumber.org>
References: <20241114011129.451243-1-stephen@networkplumber.org>
 <20250211173720.1188517-1-stephen@networkplumber.org>
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

Calling memset before rte_free not necessary, and could be
removed by the compiler. In this case, the data is not security
sensitive so the memset can be removed. Some security scanning
tools will flag this.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/compress/octeontx/otx_zip.c     | 1 -
 drivers/compress/octeontx/otx_zip_pmd.c | 2 --
 2 files changed, 3 deletions(-)

diff --git a/drivers/compress/octeontx/otx_zip.c b/drivers/compress/octeontx/otx_zip.c
index 11471dcbb4..331d2d9475 100644
--- a/drivers/compress/octeontx/otx_zip.c
+++ b/drivers/compress/octeontx/otx_zip.c
@@ -81,7 +81,6 @@ zipvf_q_term(struct zipvf_qp *qp)
 	struct zip_vf *vf = qp->vf;
 
 	if (cmdq->va != NULL) {
-		memset(cmdq->va, 0, ZIP_MAX_CMDQ_SIZE);
 		rte_free(cmdq->va);
 	}
 
diff --git a/drivers/compress/octeontx/otx_zip_pmd.c b/drivers/compress/octeontx/otx_zip_pmd.c
index c8f456b319..74e3e942ad 100644
--- a/drivers/compress/octeontx/otx_zip_pmd.c
+++ b/drivers/compress/octeontx/otx_zip_pmd.c
@@ -479,8 +479,6 @@ zip_pmd_stream_free(struct rte_compressdev *dev, void *stream)
 				(void *)&(z_stream->bufs[0]),
 				(MAX_BUFS_PER_STREAM * ZIP_BURST_SIZE));
 
-	/* Zero out the whole structure */
-	memset(stream, 0, sizeof(struct zip_stream));
 	rte_free(stream);
 
 	return 0;
-- 
2.47.2

