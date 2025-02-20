Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56202C021B2
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 16:43:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2467940676;
	Thu, 20 Feb 2025 17:42:18 +0100 (CET)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTP id EDA3C40658
 for <dev@dpdk.org>; Thu, 20 Feb 2025 17:42:12 +0100 (CET)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2212a930001so30762215ad.0
 for <dev@dpdk.org>; Thu, 20 Feb 2025 08:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740069732;
 x=1740674532; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AZmRfVHuNAu8WwJa8G2gVzrRUKoolZ9gQmZARtWp9Nw=;
 b=WbCn7zyynam37FfkVBSxD9d4qairQnI96sTV8pt4nn43swzfIQ6W5F9Cwy1Nv1pMV7
 IdFAy0uCLfX6TTwVtfC564Spg0lTAUk6o2e+9ZA53/PWyHdPxfB8947TfUxXYp1KIPXS
 UooKaC6psqLxfzqHqp1o2QHEzoKFwR5nj5DKSONL6J0yIQwyjhN0RoLBYBB2S2nwB9qD
 S8zjEuKLTtKCQLA4mFFaZD2XHznzeNI1fmpx8wGb5chL7jr41cOWIJjcMAPkMd6RlyPb
 Wu1J29piUGtz+pOcRMkj7gMzfU9gT8nI9hTtUAr2FtivQa7HBJJZBuN53RpovzZg3RI/
 2BYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740069732; x=1740674532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AZmRfVHuNAu8WwJa8G2gVzrRUKoolZ9gQmZARtWp9Nw=;
 b=IduzfgKtVfnatFPVwH5Pp92eIc/w+8ammXN0eYfj/1Kh+zsfYZwVcieYyzuLPjsRBW
 7AZ/6AKjjk/G3aDpsmsefGEGxt2/bAUNWpEwHGCUgmjecQtwfPNmxKqTBTO1bhDzC4d+
 YfddJMDR+7H4HkEdZnzzW6a+FATcs8aij+ivzp4CokO3FNcRY3W2Qga4IPxiPzJ9XVYs
 baQTPpaqrrUgA5ClOynDeh3JuGxwIQi+K4GLy63HroW1VxS1lLYtqNnLsyBJ+GZ/5CsW
 EQHPF5V+QRcoD7vEANtxNWwp4O9kOiygSWXPzDMdjN09WEDZkyB2/UmUjgsRRH6JQ41u
 t1uw==
X-Gm-Message-State: AOJu0YwMWCIclgfJpgspIpEsadIcfBAFOEk4fqVjm9iLn52FwlEJxHGX
 t2gzaCTxmBn2SNhe16Q6yuruZWfvf+V8tLlP8Czu5TjTbJktrNaPbeeTvUyVfnYbSawk0A9T7W2
 L
X-Gm-Gg: ASbGnct/zKRpBc3xoWvCtX5QZgEKeNEkXHsMXfj0KhFSxN/JKSoT3ACVdrOSSAvVlWO
 RFZw++TdeA2Qv+BVHT2+m4KTG1ZAFJ3FpVucNSbHGPDIdHA9fLFtigxnGRKeUp5repN2qTKllge
 hFQVPoCqElwygl4kQlyap15CrWDjXTHWrXUM07Stx51iWe8JVHzLpnSYLhPewQtXnKUMhVzlclB
 Kk0JrEkCkVpjVJEMlcCdZqvL23bY3ktsxyzv/JeWVcSNnBlLrwDhsICV2wH1J93vkK2NsvZJQCR
 NVEycyrgaptx8TDcIzybOv3sKN/+kz2VoePwWJ2VjpNTPd8a0aEiGnpVhBYPHSfH68/u
X-Google-Smtp-Source: AGHT+IEuEpYMnZMmf+6kLA1mAyodxlPf/5sySB26BuTpjYdiwsvYGBnJfv8hGId6/EFWNhPq28kjZA==
X-Received: by 2002:a17:903:1a05:b0:220:f1db:d96b with SMTP id
 d9443c01a7336-2211c55234cmr346512585ad.41.1740069732189; 
 Thu, 20 Feb 2025 08:42:12 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5348e68sm123798305ad.28.2025.02.20.08.42.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:42:11 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Ashish Gupta <ashish.gupta@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>
Subject: [PATCH v9 11/15] compress/octeontx: remove unnecessary memset
Date: Thu, 20 Feb 2025 08:27:17 -0800
Message-ID: <20250220164151.9606-12-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250220164151.9606-1-stephen@networkplumber.org>
References: <20241114011129.451243-1-stephen@networkplumber.org>
 <20250220164151.9606-1-stephen@networkplumber.org>
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

