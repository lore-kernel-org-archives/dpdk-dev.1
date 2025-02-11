Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E33C0219B
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 17:38:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2069340E48;
	Tue, 11 Feb 2025 18:37:49 +0100 (CET)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51]) by mails.dpdk.org (Postfix) with ESMTP id 3C04540DDA
 for <dev@dpdk.org>; Tue, 11 Feb 2025 18:37:43 +0100 (CET)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-2fa40c0bab2so6718974a91.0
 for <dev@dpdk.org>; Tue, 11 Feb 2025 09:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739295462;
 x=1739900262; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rwLEVOWB8i1GvOPUdpOEN/6mJRr6S6t2BqbR1wTmV6U=;
 b=PtoGnSn4QEHTmzoqhzBh0IzBqRvtkm7HeNl4bjVcR6qdp674NxLFxgGfRKga7xz2QY
 l4J6ROdoePG/jdCm0YWy1sQNhVgyRri/X4U/5WCS7lq4gRCqL7NzT/7JGc9d6ISTBB7M
 YhxSxcYX01SDPVFnXepDTg/Wv6mZUZxvZyO0hKSTeAWy0ZbJnsVRd126YotGhIVRnRjz
 8fI6/m5rAmY6e6KCMiYg4iyEJeNpdRkMkxZdtvA37P65a3WenfN/zhqcUm1Sbv5p/ocS
 jvdpV1cqAwW8Er6c2TkdThY2c+RaM4teCnstuJCycAwv3jx/49u+R1qy1uns3WErfXHf
 KEEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739295462; x=1739900262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rwLEVOWB8i1GvOPUdpOEN/6mJRr6S6t2BqbR1wTmV6U=;
 b=Ynx573dGH6YNxgck2Hh8ASUTQw3zeENGLLbUlvZtJLsqMz9DkxRIoh21WwBrKNKeNn
 08agxd4r0zhMmuZI4fmeFvA/AokZcZ1QaUbCls/mAYmcEiCz7KeiPttBxY42wMsEoOv6
 knDFH9zHhCcwYFjTfnLBEwdNM/SRcJdjv1To9R4qV1djqhAXUPwGae+p9RR3G5HbeoKQ
 mosynhplpWXM1aRPHbpYSw+XOChd3DWnDVg7PHSWCBa8PZ3uj/oc6BIP8RqBhjnS5Y40
 lOLaEaj6ekK4nLXD3G3/vKEsMO4uptpHSrpG6oJKzAQBXatSouz9bFvwqHogKCzDRJvR
 HVUQ==
X-Gm-Message-State: AOJu0YzaupljR3VmSSW0ra3/lEUPgz95CL3ZDA6liePleIS7aBwcwZ1L
 HIPGRwp+odc5roRZbdyd9LbrqM9ji8YHJPjbDlqSZ0BakjmY6Jsds1jTIfSD0RqeLeF74sngZBq
 q
X-Gm-Gg: ASbGncskEV1uycFvJo998xPzloRCEzAjxS3JagjYajFHkkoxF/UD5jNFtJqJL3RjZqo
 Y+2zf+GQOyNXzIrTMVq4vVCSKCCLBY0IM5fG9tBwSjX5dWdTghHeEnZETs9Gp6T3FP06hjdJiVf
 ffyoPdeGz/0NKHJGWLBx4Fbb9p8yzCxCwgipAZKnK/Cs77gw+ywr+KVj2guhpReWxHEkkZPSNos
 3b6TiDqzk3UTa2+S3fzDU22/QbzvRySTN+5T+Q2j9pUHEjV0/muK0/okvqxjkctZ1rAuB/G1p2p
 NMfs8TN9w2nSAuyS2NvMD9w1JKiD+lirD0Vg4f1pI7hgFrcqhvnh/w6h8fgYfKBWiNqR
X-Google-Smtp-Source: AGHT+IGvfgmoOXFq2xFm79zO4+bimGbJWHReeM1yoriLsjbb40laon0M/lHXBzRtFMv1gVU8OCH4uA==
X-Received: by 2002:a17:90b:4d04:b0:2ee:fdf3:38ea with SMTP id
 98e67ed59e1d1-2fb7e8badb9mr748142a91.23.1739295462434; 
 Tue, 11 Feb 2025 09:37:42 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa4656bd27sm7131811a91.42.2025.02.11.09.37.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 09:37:42 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 11/11] devtools/cocci: add script to find problematic memset
Date: Tue, 11 Feb 2025 09:35:31 -0800
Message-ID: <20250211173720.1188517-12-stephen@networkplumber.org>
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

Script that converts memset before free into rte_memset_sensitive
and memset before rte_free into rte_free_sensitive

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 devtools/cocci/memset_free.cocci | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 devtools/cocci/memset_free.cocci

diff --git a/devtools/cocci/memset_free.cocci b/devtools/cocci/memset_free.cocci
new file mode 100644
index 0000000000..834c5dbf2b
--- /dev/null
+++ b/devtools/cocci/memset_free.cocci
@@ -0,0 +1,20 @@
+// Replace calls to memset before free
+@@
+expression E, size;
+@@
+(
+- memset(E, 0, size);
+- free(E);
++ rte_memset_sensitive(E, 0, size);
++ free(E);
+)
+
+// replace to memset before rte_free
+@@
+expression E, size;
+@@
+(
+- memset(E, 0, size);
+- rte_free(E);
++ rte_free_sensitive(E);
+)
-- 
2.47.2

