Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A550FD0048
	for <dpdk-dev@archiver.kernel.org>; Sun,  1 Mar 2026 02:08:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D3B8640E01;
	Sun,  1 Mar 2026 03:07:42 +0100 (CET)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com
 [209.85.222.176])
 by mails.dpdk.org (Postfix) with ESMTP id 69341402DC
 for <dev@dpdk.org>; Sun,  1 Mar 2026 03:07:40 +0100 (CET)
Received: by mail-qk1-f176.google.com with SMTP id
 af79cd13be357-8c70b5594f4so352849285a.1
 for <dev@dpdk.org>; Sat, 28 Feb 2026 18:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772330860;
 x=1772935660; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qr2ibaKZFZ1WwKRZQD97rDlklZTjrIslHzDyjV82s/Y=;
 b=t+KvxnDIHEuGd6Zam1eS0COk0QFEWqSrK/ATfPp7iimYbCaC51Nw2jZ8Y/jHgRu+ls
 bj/3g5AXNyoZp2Z1hclz6/RCtZXvuwb22PDRppcPMWI5Akk62b4VaS6vgD7O0zIZ2b8M
 6mtPS45JiXzA6YXCsNDsld70iq9xtRxgRhcUWjvjQ0kKueBwYHBI7NlVBBg+9kxQepVL
 XGP/GSw6j/t0Hj6Wn2wK0LBcYoquH7fV/TFKfsIB8yabevLF+Z6L7wIkpXavLHNdNutn
 L2KgSUsAMVzNRzGmaGDvctLIVbHZWdN1Jej/NqeMbITps4m+xos/sS3UbN2yslXjPoAs
 45qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772330860; x=1772935660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qr2ibaKZFZ1WwKRZQD97rDlklZTjrIslHzDyjV82s/Y=;
 b=rolmBNZUM3eSEfRIhpWMtyMC/AmaJnUkLyTZp9xB3n+baZNcp6pOV9ySbYA4GJoO6P
 76hFKr9yMkI/EqUMBKK+OKltKPHcLZSOqzVxLePNWDqa9PYUBnFgUUeRlPMInfwctKCb
 McNv/UOt0ln8yHr3KFWYN+g9WZqPEqWZszHS3+QSkj+mj3/AgT/l8lYYo/d18cOS5pAe
 /1hlVKN5jX14d2YKMe8WQN1//7I3ACsYNxueXpXtAw7yq97rXYljSwb6XEJW5OOJmwQh
 tSObdr8qoQfjZk0ayvEcw0ZQ5zn9JXKsyV+KBZw0iP1nv3vQgCIfjFnx4lVJD48pU0NS
 pZXw==
X-Gm-Message-State: AOJu0YyfUBMHaEjNgG6KVh4+uxg5NyRAJ2uom4U6w748IzYElHjmQZzM
 mAMJlvLGrmytKhisgG8/ruxxYgjT8PyRTfxU0BySFtzfl31ZOi6YNp/ZJm1p2GjYfQv4V0H8VAm
 mtjGn
X-Gm-Gg: ATEYQzza1UheCroqG9cU2cTle1bCpxRSvWgZiE8EOlqhMhb47iMewFDbbp+R8tra2Og
 SVLd6rlxFQtgdrZxJ6rhH6Sr9Wihrf7w7NHRS5e2lMi/hbYp7Ha07f3UEZwY3rcowrDPK6MM0h3
 ZyAs8jf32ImQUtrqdsgn2N6dlScedZ4WRXfjkt4pYFREeTr2VXH6hXSg38LJDg4SeUM1mqcCHx6
 AXDTfHqjLJfduebI7dlZyx6QazQlYnaiLt2DdKxJZXQ23QS3lPoEyDGJhRR4oMLvrEPV9j+30l8
 dG8O1Brx6oaxiab9f6bNHXhIRan8HGwZYPBVi+5mHkKQrZ8/Z4mgho5tx1RK4P2V7IXxQRTE9R9
 fG5A9haEPoOlfEq4wG2F3xoIB9FjURy9WPoiqScvPouxw0gutDplFWRqwBQ55xnIy65dXj+vo6N
 5W3wsWYXEBzL0xBPe39F9qe0G5omNdcoyVVemqFclrTfsClKqhNfAq1HzEP5mi/g==
X-Received: by 2002:a05:620a:711b:b0:8b2:e177:ddb0 with SMTP id
 af79cd13be357-8cbc8cc8cd6mr916246785a.23.1772330859710; 
 Sat, 28 Feb 2026 18:07:39 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf736bffsm802292985a.50.2026.02.28.18.07.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Feb 2026 18:07:39 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v18 05/23] net/pcap: remove unnecessary casts
Date: Sat, 28 Feb 2026 18:05:38 -0800
Message-ID: <20260301020726.852401-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260301020726.852401-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260301020726.852401-1-stephen@networkplumber.org>
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

