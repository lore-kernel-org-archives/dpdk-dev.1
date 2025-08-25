Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE853CA0EFA
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 Aug 2025 08:32:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8F2EE4025A;
	Mon, 25 Aug 2025 10:32:39 +0200 (CEST)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by mails.dpdk.org (Postfix) with ESMTP id E74AD40151
 for <dev@dpdk.org>; Mon, 25 Aug 2025 10:32:37 +0200 (CEST)
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-b4bafe2e538so728088a12.3
 for <dev@dpdk.org>; Mon, 25 Aug 2025 01:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wisig-com.20230601.gappssmtp.com; s=20230601; t=1756110757; x=1756715557;
 darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2QxmzSnIFy+2OzOxcXmAzAFr7Oxn59IWE4tm3/3BRpI=;
 b=o79KuEjCryGfsQp4hLO2BywxPtndPd8pQQoJUFIio9SVCaNl/0klCYa2//orKMBFsD
 E8V7ind3tZzOk9ng+TmUY1JCfUH99RPdonpU/uxmxjSfi3I9FlaXjYpgEX00DB0ePL2l
 PFXodc8Op0hoiDkSW8IEsbl8NXD2/3hxSChx6BNUKGlGGy2mf1AcPQNXY0etOKgGiZJP
 IcpRdXiSYv/bSDhuPYj24gVQIPrxWRk4du7PFUMOSPXhTXNuz43dKj3B25AlcNOT4bdF
 0sHWQqk1PK7J57Di5XvGXQEfIIWKMTQaO7mv+1YaIYik+lUpEtcUVjELhbJFSlwgOAH/
 fj2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756110757; x=1756715557;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2QxmzSnIFy+2OzOxcXmAzAFr7Oxn59IWE4tm3/3BRpI=;
 b=DLYGQsZfDUjObPAf6DDwcAZpVMSdr+BFYs9GE2ZP96jdZWwgpWvWw1WXlnTYegAj21
 k4yroF9uk3ZjDeEjgSkCp3zJP7VnUylsjGAOmHOP+RnncDIQ+qiVXFqoc6vXVN+ICLRg
 SKHYEQPanRMnpWT19WU2LCep2yYHpQVm3IjC7om/evwR/DieWQeb7Whb0b8p0JZbUdtd
 4dy2L4t8bCIB+RQNTwsBSuBOhoB57mxEWJSUOh48r6KvBbau3inWMcUnkeZMW+mC4QIk
 tiPXfO8gmABiYNUj0kAJxLQ42YjAhWmQl79dl2lTSkcCmDnmMHLYzpNpR/v8D21T0Mqz
 1p1Q==
X-Gm-Message-State: AOJu0YxMJ79r+RxTDfQepXuC/WoqdBt2rItLiVc5wb0+7l3F/g3D80qM
 P6BlqfM7uOi2/sd7ybFvTKOgnBT2fWp8RkGP7yXd21QEvA2ggvcWhQvePuTZEBc30wE6BWSNr+h
 HYTOVUg==
X-Gm-Gg: ASbGncsZq81ZXEfmGAAQpqI4uAGcSPrOfU5Z2sqM6gO+78hZLKi/5zc8lSZN1PtVril
 sZIMs4x5Ps4nb63rOKkZLnP556IjCWc1Q/hHit8TLn3HATqiV+NefZjeJra1WB3wj9ci3/T80rW
 MVmTIuU43hLvSog6tZXrSD5Cwcd0CV3fQL2LbRXts8mTgQKABIsmDiN9NbuU1qvHcg2+e3b5cO9
 Jj6gPyURAghgOYENcpDgJO51wEgnAHkJApOxsekviiSsKFpWIqCts0umRO83+QanyeiphraTRAx
 S921SSGt0C01ESO6Z6+z7hBUFp/dgqJMJKk3e4+O8wq6r7zHVu4Allbo153n4JRNow//8cOfLWi
 nKSxXqZmInUOkCMZblfT0jc2IfK4=
X-Google-Smtp-Source: AGHT+IGsN3lV6iRPCmgDwa18x8KbdtWNVquOLriGtfRN4KRZh6sTGOj/9Ch2Hia+P09pjA3M55w+yA==
X-Received: by 2002:a17:902:d48d:b0:246:96bf:c90d with SMTP id
 d9443c01a7336-24696bfd5fbmr75313295ad.3.1756110756614; 
 Mon, 25 Aug 2025 01:32:36 -0700 (PDT)
Received: from ash-wisig.wisig.com ([14.195.146.86])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3254b809c9asm6306449a91.26.2025.08.25.01.32.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 01:32:36 -0700 (PDT)
From: Ashwini Sahu <ashwini@wisig.com>
To: dev@dpdk.org
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: [PATCH] vduse: fix typo in struct vduse_iova_info comment
Date: Mon, 25 Aug 2025 14:02:28 +0530
Message-ID: <20250825083229.919586-1-ashwini@wisig.com>
X-Mailer: git-send-email 2.50.1
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

Fixes a typo in the kernel header comment for struct vduse_iova_info
where "IOVA region" was incorrectly repeated.

Signed-off-by: Ashwini Sahu <ashwini@wisig.com>
---
 kernel/linux/uapi/linux/vduse.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/linux/uapi/linux/vduse.h b/kernel/linux/uapi/linux/vduse.h
index 68a627d04a..10ad71aa00 100644
--- a/kernel/linux/uapi/linux/vduse.h
+++ b/kernel/linux/uapi/linux/vduse.h
@@ -237,7 +237,7 @@ struct vduse_iova_umem {
  * struct vduse_iova_info - information of one IOVA region
  * @start: start of the IOVA region
  * @last: last of the IOVA region
- * @capability: capability of the IOVA regsion
+ * @capability: capability of the IOVA region
  * @reserved: for future use, needs to be initialized to zero
  *
  * Structure used by VDUSE_IOTLB_GET_INFO ioctl to get information of
-- 
2.50.1

