Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26162CCD195
	for <dpdk-dev@archiver.kernel.org>; Sun, 19 Oct 2025 16:58:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 09E7042DDE;
	Sun, 19 Oct 2025 18:57:40 +0200 (CEST)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by mails.dpdk.org (Postfix) with ESMTP id 9B711427B4
 for <dev@dpdk.org>; Sun, 19 Oct 2025 18:57:36 +0200 (CEST)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-279e2554c8fso33594735ad.2
 for <dev@dpdk.org>; Sun, 19 Oct 2025 09:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760893056;
 x=1761497856; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6xPyzbUG5UjnmpsRz5YG4ME+8zYRx9mBZSPXn4krcus=;
 b=0CVU+8YAZAygbz8xBhJQbodd/o2th7kYHs0OdFkQbfv3YeToJ0jRajyaqfO5Kjz1hD
 uKP1VXHivsiETXCt2wptcJhY4qvzsejgt+ESi7jY/AQsi0FWC3JKoeaHvCPkhCcvGC8M
 B7Oghyqkwl4OcJNUYpjhio6x/pfvmK5iXVasKJ4a24VN7bCBqE7gMb6deQk2pdTftCHr
 Q391y0j6KJX9Uq7W/aQ9T0FvmbAXR+UMO0XpnxLC7FOmXgH2JsP+UZ7SoM2Hi/fdXW3T
 voIa9eDXfu5Npb8tbZMBAa4RpttyRvF76xkTfGy1Nuj165QZ4DtmNQ1X4Li0RoC9dGh9
 ax1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760893056; x=1761497856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6xPyzbUG5UjnmpsRz5YG4ME+8zYRx9mBZSPXn4krcus=;
 b=HsHkakoOHa7Uow6sr8/wyC8j+UTmsMagKzxWdq+RDnCXmZNB1uau6zAvNeUNxeUh9G
 PoR0wDgzkFACd0OFILVXTpaWf81mX+YpY3Usliyk9M0cXKzCxtA0dZnVAXSjHmcwbcxu
 EH6mXZKOGPoAVQh/P5Iy46uo5vqegSKivhVmOFQ/+DO8ZKzc3tQb9qdUY+uvakxfzVnA
 qfOYdgtWFi1CQb2fSYofRcti5amoz1Doo/3JKWjAk4fLhkXnArj+M51L785xuBpMFHkW
 tbvljny3LmN1souULfG2c2mLefWUlCx6tMQEHc21R2Cf0nQYsuVUZjjuCIV5JK66JtP8
 oPlA==
X-Gm-Message-State: AOJu0Yxms+jTnjhz1BBcqoblyDrMDLCjaWfuCdXufoXdzw3Ia+892veZ
 Y6czvlg7jl9ToWsmuztHSCL7K6jfBlVPT2sEnpt1GaKM//rlTM1ZCuyTLt5iFiNI+LHKs8bumW0
 Q7oUi0g8=
X-Gm-Gg: ASbGncsMgtw0zXeF8y8KqfqAc9M9nP8kuw2bWlI+vbL3sEQ4L+QGkimzDOeaL1tvTD1
 9+hRObGXCFW6IG/gXGc6z1ghsnUO/5OKC+Dwz8Oly/RiBQp0dtimbSpcsleNdX54vQcY4ZrOSHX
 tj0oEFAy5C1fFTHKERZnW8urxcEpWFszO8SlwXhnk628tSn2wBZHSve0Qd64hM7pJllj564YT+N
 3KMVauWsXCTms/+Ok7EpKgQptWkXqp5xX0vN5rcGm5ZVGAXhcgfKr6XbUxdxUFDEAKQwX98DRFQ
 oJVNSBqNBEkAsVn4SmW+khm0pQrRodXqzNYUaML33X5YPX6ze9sl3c0zEBXNSmYyeSbQFLNJv3i
 udIy91O/wi1EGkchp+UQw/XoFJHmV2+7GsSEzhVSYf801M8k3hk1FBRHK62ySUMmtFD/Y9JZ6/c
 gH7GZ5BZ5ZS5HiMwtlPMlf1/Aa731RxFY4TY0mlKM=
X-Google-Smtp-Source: AGHT+IH/Z4pAuCWEN8ZELW6RqpIX/XI9h14l3DoYSvgpltyPXKdDAFtj/Bvrgu3J2xt7MyC6rvWSCA==
X-Received: by 2002:a17:902:e743:b0:269:8059:83ab with SMTP id
 d9443c01a7336-290cb27f849mr89354635ad.51.1760893055782; 
 Sun, 19 Oct 2025 09:57:35 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2924721b6fdsm56940455ad.118.2025.10.19.09.57.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Oct 2025 09:57:35 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v3 5/8] pdump: handle pdump requests from primary
Date: Sun, 19 Oct 2025 09:56:12 -0700
Message-ID: <20251019165728.164929-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251019165728.164929-1-stephen@networkplumber.org>
References: <250811213632.16023-1-stephen@networkplumber.org>
 <20251019165728.164929-1-stephen@networkplumber.org>
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

The primary process will start to notify all secondary processes
about pdump changes. The pdump secondary process can just call
rte_pdump_init() and it take care of that.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/pdump/main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/app/pdump/main.c b/app/pdump/main.c
index 1741d7e709..626ba0ce93 100644
--- a/app/pdump/main.c
+++ b/app/pdump/main.c
@@ -552,6 +552,7 @@ cleanup_pdump_resources(void)
 		}
 
 	}
+	rte_pdump_uninit();
 	cleanup_rings();
 }
 
@@ -822,6 +823,9 @@ enable_pdump(void)
 	struct pdump_tuples *pt;
 	int ret = 0, ret1 = 0;
 
+	if (rte_pdump_init() < 0)
+		rte_exit(EXIT_FAILURE, "pdump init failed\n");
+
 	for (i = 0; i < num_tuples; i++) {
 		pt = &pdump_t[i];
 		if (pt->dir == RTE_PDUMP_FLAG_RXTX) {
-- 
2.51.0

