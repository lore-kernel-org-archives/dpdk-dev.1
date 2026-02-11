Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EEFEECD6F6
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 22:22:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E0ED340662;
	Wed, 11 Feb 2026 23:21:49 +0100 (CET)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id 2A7AE40657
 for <dev@dpdk.org>; Wed, 11 Feb 2026 23:21:48 +0100 (CET)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-48069a48629so65908355e9.0
 for <dev@dpdk.org>; Wed, 11 Feb 2026 14:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770848508;
 x=1771453308; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qr2ibaKZFZ1WwKRZQD97rDlklZTjrIslHzDyjV82s/Y=;
 b=Kww7v7lNLlwEmkkqHuZjxIVVt94XhcgTZbWkrkV8pN77pRLek3NaQsSiZSfSp9DQqr
 Z7qlL1F0Egb9G7woVoCXjNhlxVfvnOAGv2bE4M/OQdiNR6YNi3VzRIdTgtonDS0PnN82
 l7T4kL0pKfZ4EQr6THSD/TmJZ6i0VaRToLKPQA1JvLp+RvLIe07GHVLVJEu0VD9DozWe
 Qn9sxm1d7Kd/ps2mFVUXbKMIWsu+9Ra8EM89vJgxrransw/T0eV/O+WdR0kPXyzOGe3O
 HjdtWsiQpe5SS9NOcXsrNKjf1TCT0Efstg8ZLI2jx8qmcjKRjoKFf1kKkkqjmBfxMFCx
 am7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770848508; x=1771453308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qr2ibaKZFZ1WwKRZQD97rDlklZTjrIslHzDyjV82s/Y=;
 b=MKgJw/IqYgRatbBOML8bMIqKzrFrL4X2n26C9W8d2/rB9xVcgM4+T/V7/VfsV2w+wy
 52p8ayYn5rpqF5k5VQvXbzWG1eeCUa2hVSwuGLMU+UoHCXPh58D89w00fndWNfw0sIuW
 xTccgWs9BNGv3RqahxqysX6P31agvbUKd1btZRY9YQ71Aj00x3AJaquElfBpAqcUHK34
 Fc0QYXaKFobgLw0GoUVVYNmzrJUpICTBhUjVQdaF3z8qXN1SCR2m6Hphemu/3kK3kDEq
 xHgNBwk8t2uLolcGuEZ6OPM0qxGg3swxH8lppsM1OqINRe9QROke/jTVo/ai4MghKOr/
 YPGg==
X-Gm-Message-State: AOJu0Yzb0iGSeEDQ7CgB2jsDI+2xgsqXN+FSGuDcRo9UHPHKld4Aiajp
 fhlGiPjbTgIArDYZ7f6o76SQqMF7CZIuH/+zj+d5VxvXvmwnViT563sk+VigzPFJEwM0fxU6EOR
 +eHzK
X-Gm-Gg: AZuq6aJe6m3qiP9bTv/eXPgiGG1HvTuwIoQkQPOvb6DOtwzRD3n03qHssa/PojDFGjI
 k2qxMW3pd6Qsg6iAOKHB+6Qj/PcWR1WoKmLxt7EI2nLYEczzG326/0N7tVt04JT/jAjgdZjXir2
 HD2lg5f1qJ7JPlk5Itta9w3yWhNixhu/bz/trlIXiDLhYpAu9VkxmF5+GjOblLqOfhHaC/XjjPn
 r7uV9uCCfWzC+cxtYLfTNufFQicdBmY5H6nxi28P0Z0rPCJ939HzlO5JQvDbZ4YVmzJVTkjns8l
 nYd9xGcAUwAXYWpgg6K1s7HLMJhdwBC1L+vX/A5rKWfS3mvLkzBOltx6+/oV3Ep+B7S9fPun5uy
 ZuOG9P6gw6qTeBISOPGEdfUbCBnLtEstNE1E8kIlgXmsyR/p+rejBpxA5JXcZAKYaaixfy+pqko
 mwaB7TGNv54FjTNByTiVqS6EzdVn67b12l352KjR0hIWVpBbge0TUwzWhNifv2bg==
X-Received: by 2002:a05:600c:a08:b0:46f:c55a:5a8d with SMTP id
 5b1f17b1804b1-483656ab4dbmr8796375e9.4.1770848507699; 
 Wed, 11 Feb 2026 14:21:47 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43783e0196bsm7877965f8f.23.2026.02.11.14.21.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 14:21:47 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v14 04/18] net/pcap: remove unnecessary casts
Date: Wed, 11 Feb 2026 13:09:37 -0800
Message-ID: <20260211222130.338797-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260211222130.338797-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260211222130.338797-1-stephen@networkplumber.org>
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

The function rte_zmalloc returns void * so cast is unnecessary.

Correct the indentation in that code. Not really worth backporting.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pcap/pcap_ethdev.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 4513d46d61..fbd1021c39 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -1220,9 +1220,8 @@ pmd_init_internals(struct rte_vdev_device *vdev,
 	PMD_LOG(INFO, "Creating pcap-backed ethdev on numa socket %d",
 		numa_node);
 
-	pp = (struct pmd_process_private *)
-		rte_zmalloc(NULL, sizeof(struct pmd_process_private),
-				RTE_CACHE_LINE_SIZE);
+	pp = rte_zmalloc(NULL, sizeof(struct pmd_process_private),
+			 RTE_CACHE_LINE_SIZE);
 
 	if (pp == NULL) {
 		PMD_LOG(ERR,
@@ -1590,10 +1589,8 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
 		unsigned int i;
 
 		internal = eth_dev->data->dev_private;
-			pp = (struct pmd_process_private *)
-				rte_zmalloc(NULL,
-					sizeof(struct pmd_process_private),
-					RTE_CACHE_LINE_SIZE);
+		pp = rte_zmalloc(NULL, sizeof(struct pmd_process_private),
+				 RTE_CACHE_LINE_SIZE);
 
 		if (pp == NULL) {
 			PMD_LOG(ERR,
-- 
2.51.0

