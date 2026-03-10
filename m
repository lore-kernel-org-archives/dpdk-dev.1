Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5310BFD4F03
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 16:14:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0234840E22;
	Tue, 10 Mar 2026 17:14:09 +0100 (CET)
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com
 [209.85.210.44]) by mails.dpdk.org (Postfix) with ESMTP id E93AA40E16
 for <dev@dpdk.org>; Tue, 10 Mar 2026 17:14:06 +0100 (CET)
Received: by mail-ot1-f44.google.com with SMTP id
 46e09a7af769-7d74a59262fso2284139a34.0
 for <dev@dpdk.org>; Tue, 10 Mar 2026 09:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773159246;
 x=1773764046; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qr2ibaKZFZ1WwKRZQD97rDlklZTjrIslHzDyjV82s/Y=;
 b=EVSWeRsQsCP50pxzcei3dHfpY2iphiVssA5VdO+Z4EuTdJDEJpJbh8JGXi1whcpGnt
 eiE1AAFVkMLrGZa3Bzj5YNwDq7F1Jf8JVRyGo59fzPx+b6Vc4E2PizjlFd64sq/nmxXl
 GtyMTnd/ZtYHrhXHuwbM+1qqrpQpQHbplowLcF8V28RQdXdd4cEOXRW6oMKuJZ9eT4BB
 5kUntcTuFiFrKDAuITMNwtkHDMw95Rq0tVfj384GYnev/+vAgSwfZ5K0HLzFaaicjPKK
 3ipIe4/uFl6+4DlTRN+YTHP68l+TWt1/nn85QNhBObU92/0GXcy4PQ094EdY5YOXdMCm
 4pLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773159246; x=1773764046;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qr2ibaKZFZ1WwKRZQD97rDlklZTjrIslHzDyjV82s/Y=;
 b=TfbxANt4Jer3wQygXsyd+7bTAfU8svqjiQCdakVz4dD4Sp7iFLgmF79skr5da5k1GB
 aiwLZx3sbeGlHcrbaz993PKx4YWKXm0sOp84h8wnUg15LOIPTPCUbJJ3kZLdHQdtmmrE
 ZYDx9fTB5fpJ8YcPuiOAyUKPTjf3at9IwQtTYWNDiGpp4ewshMUJxNfl2xgVi4Sl11Sl
 Eel/rJRNZSUWFT5TDQKrxQ+9trgjBJcVBqCKwlM7PtNROjZYIwfQII784WI1Uuw+FQZG
 b8SdYE58CR/wZRHGrackplQAfz4SUaE8CVQh0jEePZI87AbCrJ3IJFTXNVZ6hDKs4mW6
 OgoQ==
X-Gm-Message-State: AOJu0Yyz3xYF6gynwFtYCMmTVmY6F16KVLWG2OJskE3MAo7PTaXXz+JX
 bNoJ9NAd3Ln+X+f1xzxsiLQO8KODKZ2+Y/IO2ps7BNoJw9D/9je1QRy6IddGQjTUB+v9Tr3WcIj
 S2zdVXus=
X-Gm-Gg: ATEYQzy64yE5mNU0D9EC6NKbS/NszmJ/kuBIADvqnVLfVhyndLGmnbcohktHxf+3s8b
 41ReADvrUM/rsM+luIaboNPVjz1ibAZxmqC7GrlNhSxgJMUJL4H7+bqyI4Gu8xrEQL9X1R0t/zD
 SOmgML7mIZob378cb4iu57HPTbwj+avtoewEN3tDTvJa9UoEzVaT+TNcRRN9fx5bhP77BglB+C8
 hCNjCJ1hEXYZC7eF0yQXzrVGWbAkbS+fzNSI0HbiNxnVkG2Ycv1S0rPHep7Of00Zuhk8xewzqYA
 HcGrjKC4LF2KqqIen+OPjQG+MQ9rH5be4Ca4mBlme2JRUsag6jWLDD/HBKnBkFOJ9UYGtY4lWmb
 GUrYJlHare7PWFUcL2g5oQ5vPnxyDem85CCRiBStJvOo5NTxOKp80iolNoNZuanaHgc/qCycdd8
 NMoYebAcI0/J6YJs9Q13u6Zx0ngiAXzqC0
X-Received: by 2002:a05:6830:438e:b0:7d7:6610:73ae with SMTP id
 46e09a7af769-7d766107b56mr311429a34.25.1773159246275; 
 Tue, 10 Mar 2026 09:14:06 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d738e3f421sm7304004a34.25.2026.03.10.09.14.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 09:14:05 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v20 05/25] net/pcap: remove unnecessary casts
Date: Tue, 10 Mar 2026 09:09:43 -0700
Message-ID: <20260310161356.194553-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260310161356.194553-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260310161356.194553-1-stephen@networkplumber.org>
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

