Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD94C021A4
	for <dpdk-dev@archiver.kernel.org>; Sat, 15 Feb 2025 19:07:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 863B840E11;
	Sat, 15 Feb 2025 20:06:13 +0100 (CET)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mails.dpdk.org (Postfix) with ESMTP id D8AB640DD2
 for <dev@dpdk.org>; Sat, 15 Feb 2025 20:06:06 +0100 (CET)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-21f3c119fe6so74785065ad.0
 for <dev@dpdk.org>; Sat, 15 Feb 2025 11:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739646366;
 x=1740251166; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AZmRfVHuNAu8WwJa8G2gVzrRUKoolZ9gQmZARtWp9Nw=;
 b=Jw1+/7IzaQozhX/n6NL4jUJ+t8NMRw1jmT2SdRfjmHz1fbfslQowYGpDiGldm4qbH8
 NaX8gs2QsIIRHfz4Rd4PYUiVQKnK71stPrwtg+4xXk3TppJOchrZFstvDductc7bP5MA
 3bgKBa3xnuXS0RQfPSWEyZrA6s704DicZZ6c8cS8A84Il5lpM/9jO7T//2n6Z2mQR4Bz
 9lLnlv3fR/QHAD7hLWPMQyIYNFITFiMf0DQiUWU6Oy5uG7TMz1YfUI7U+KSPMmwHgvv3
 b24f36xDgSDikMVRQSw06SlcJqE5UElHldcskay5hJMfzq3c6ZT8B9/PfLRcai2MHpRs
 eM6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739646366; x=1740251166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AZmRfVHuNAu8WwJa8G2gVzrRUKoolZ9gQmZARtWp9Nw=;
 b=wUnceVzbaktqBY4KT0kzgymQBNaYH64ahaThQClmC4wPrCS+JCQsoUndRQvkjhcupG
 poO2BchTjlTomgtgywHaXLmxb3gZsjFAxdRTFs/FvmdKsHN0geZLJ5QNb9WUI5T1XBYD
 qLcLOakTSzrlTW70so5ql+aA0AQJ5oMa6+WvU+Yk05r81MN1QVFAQnJapta+ys1K2Od6
 ID0DdioowDDUqKCcdEfEOon9U7zsUJOGZckHDj1pYAoX0Vdryf+WPT4bC9Hpc6zTInyr
 AbJNWujwOVMQEoXMV0CbMyVc3iwHUdZA/PFFJdkkpVepIZnqoERRaTZAOENM7pzdTj4i
 y4eA==
X-Gm-Message-State: AOJu0Yy3rQmePWuyzT7n1Jrhkv41b/kGtyPA8XASdioCFHA2TA3gEJEH
 NEySnP265qhFvsjvDNBj2HFHvpjBOaJy0ZxRB01/iRRoVltZTtWLBMTewYrzpkPj16+BYez8YLY
 f
X-Gm-Gg: ASbGncswQf8LWVJxaJkwNk3HbazqPxkSldKboLCJwX/zCXyVbYVRK+e5cTtUVkQoFjr
 t+vDo2pKH87tfBBU2CuJjCLkuu+5YsLSTJBQ2HkeDPYmloD4v5y372jt5chSlvee1Bfibtfru1t
 V5D0p0lnenxKxGPL3/+FFfVpHx4gFpDahpqBQ4mZ2n5jhDpHm7bqCdnN3I3FoppD4eL29Jy2YJh
 fHb7eAHE5kAWz9Y2r8TYZ2Q31GqGin0sL7guYyOiNgZ9W7qDXaNCBMkPOZQN2IhLsSXa/SfAg1g
 yLdjbq+XN36o3nlfRSOpZYa7vU2nmT4Uf7wqGLTm5BUK7cFpJvLR7TxdbU2HAN2cPVm6
X-Google-Smtp-Source: AGHT+IE4wt3GwTNvNSYxgQ5MV/PkQnSZJ4y7zH4Rl3MXtboLysjdb7L/SQlzvZUFt6qzG0/dY7FGyQ==
X-Received: by 2002:a05:6a00:4f88:b0:732:516f:21fa with SMTP id
 d2e1a72fcca58-732617d014fmr6261407b3a.14.1739646366053; 
 Sat, 15 Feb 2025 11:06:06 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7324254685csm5080179b3a.4.2025.02.15.11.06.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2025 11:06:05 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Ashish Gupta <ashish.gupta@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>
Subject: [PATCH v7 12/16] compress/octeontx: remove unnecessary memset
Date: Sat, 15 Feb 2025 11:04:40 -0800
Message-ID: <20250215190544.988310-13-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250215190544.988310-1-stephen@networkplumber.org>
References: <20241114011129.451243-1-stephen@networkplumber.org>
 <20250215190544.988310-1-stephen@networkplumber.org>
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

