Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C3ECC021A4
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Feb 2025 22:19:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8C6904067D;
	Thu, 13 Feb 2025 23:18:43 +0100 (CET)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49]) by mails.dpdk.org (Postfix) with ESMTP id 1EFE84066F
 for <dev@dpdk.org>; Thu, 13 Feb 2025 23:18:40 +0100 (CET)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-2fa44590eebso2835138a91.3
 for <dev@dpdk.org>; Thu, 13 Feb 2025 14:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739485119;
 x=1740089919; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AZmRfVHuNAu8WwJa8G2gVzrRUKoolZ9gQmZARtWp9Nw=;
 b=ViWkYfp3Qq3fH/i0GY/S/a46oaOM1jgIuE/K0AqvmOvQXYDLDaQH3kidr1fKDnPxuQ
 Ui/A+A3dUZJDUmifsG0s2arJWm4UsLiVEYkGkG2867oG7TN5olC6RjUqGSzLc+95F6OE
 +KvUnqvrmNyK+vjMVFHGQtfQM8Cc3AtheLlgQ/Y18SoHabfmPReXTFjrQb5MoMQ385V2
 AKjT6vnQBJ0LgL3um3+A844LhahVyP3VDQjbNap1Q+CM8dFMZ9dKfCc+usEa9IPy8pAp
 n4yg57D4OARnmqUXhCN0gTImwlq1CCff0wscRbLd+OCBAcZwhF1D4fBrxFn/C9O107Ct
 wd2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739485119; x=1740089919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AZmRfVHuNAu8WwJa8G2gVzrRUKoolZ9gQmZARtWp9Nw=;
 b=acfC2sMBXKDWRJRkY5IeCbxFxIJo/bR8+5UhjzsxtMhL2/n6gXEoPIr5E1YRyTkEeW
 fFsMoTLtqa5NsT5a8tJIlvuPaV0v9TG++a/tLj4rLHBRM9Fc5k/oPN4Z76d1YXBZXK1N
 r/mUL2mtKLCmrPAbC86W6eosrRenIkRODLJE61ooN6aq2p6aBueN3CpnOWVOntxRHjNi
 IgelrnPz/xpnTgqcIelxNWS30bH0C/UWJLyxWY0wv8g4s4KftrUQmzKSU2g+kbr0FbSM
 ecw5aX8pHN3CfFUFJ5kUqnIX4YyWO+M6b+IAF9PWxE8Bix+rdDmqDsJzdtrqMMc6hQa+
 l1QA==
X-Gm-Message-State: AOJu0YwfkrHI7CLNg3O57ltyQCPt2/X42/LsGEk337pJBP11999HjbHa
 WPYUA2lNejH5QoL/CRzUl2rogGOVK+xZ3+gPWoiq7oYrY3QdAl7AZHOt1QUGRVS5gcBjZMrpW6Z
 Q
X-Gm-Gg: ASbGnctu+NzOnc1C2uXqjDWR4xv+d96c7zKnslRWq2JcDwzkbpN0U/daPPfGuMNrceR
 0D/XHCpaf0dEixXG2VbYCO4g7WnSHiWlv2RrqMyoR91Lhsm8tNOleGeJBgoUXdDoK/7pCtQ+G5S
 pNj3YFR4/Es1rlXi6PQi1FCWPII9RsQ6JM0gHwMg1nGcfXBNtJzFqModpfU4dObcOaDisl4HBIS
 uCfc4TetaXRcl9Wfv4J9JfFTRcDGePQdTZ5G39flrDQCEgs8PvFKWwSYmkWULgGjoaZEqEN03UX
 tCt4xaogT3QJBSIltysQvCeBQfglMYiUgghtRxQDS7sHoSa1OaUh9jnkhf+b1o7W83hs
X-Google-Smtp-Source: AGHT+IGkgR+4IeQdNZJLMX4fo9hT0x8AvZht0HxCXA14TVXmz8MG8Ry/+2KQ/tvvU7AOC/MEAFI+Xg==
X-Received: by 2002:a17:90b:2692:b0:2fa:1851:a023 with SMTP id
 98e67ed59e1d1-2fc0f0fef42mr7040560a91.35.1739485119321; 
 Thu, 13 Feb 2025 14:18:39 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fc13ad726bsm1706826a91.28.2025.02.13.14.18.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 14:18:38 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Ashish Gupta <ashish.gupta@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>
Subject: [PATCH v6 07/11] compress/octeontx: remove unnecessary memset
Date: Thu, 13 Feb 2025 14:16:20 -0800
Message-ID: <20250213221819.1856769-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250213221819.1856769-1-stephen@networkplumber.org>
References: <20241114011129.451243-1-stephen@networkplumber.org>
 <20250213221819.1856769-1-stephen@networkplumber.org>
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

