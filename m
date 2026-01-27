Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 633A4D340A5
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Jan 2026 16:34:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 88863410DF;
	Tue, 27 Jan 2026 17:33:25 +0100 (CET)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51]) by mails.dpdk.org (Postfix) with ESMTP id AC404410D0
 for <dev@dpdk.org>; Tue, 27 Jan 2026 17:33:23 +0100 (CET)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-47ee07570deso45701815e9.1
 for <dev@dpdk.org>; Tue, 27 Jan 2026 08:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769531603;
 x=1770136403; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Avhl9YgiSxxdK9mVnQKAOQQ+ilaSko/avISOyDtECRA=;
 b=rFztPB0JwdlYNnvkk9KdpEheP8RpJ6oXGZjd9gLmFepZBd2d3S1DG4G3Rq3gJObstZ
 jdHh9PAYiB62Sd0QXK9GYVxnYtc7SqErzuAuQGvd1tEgCBrITkwtWlx71lhLOcI7ccuF
 fuzHqPXjcAcDFU5pZI+q1uQD7ns5jOCQxycd1SJVw+nPfDflOjsWnk8FEH+jT8bnbtM0
 CCl1+pZpbURIzvO/4NkQo5Kn10kfCvMKh1ly3afy9hHtUmSBOKv+1r9QZho90SHZJnQK
 KcgYFMDPCUDUVV+Z1u14ywIaRpQ00LY/Tf/KFfeCyz0DVgZrO5FXW/sfH6cp6MEi+2Fe
 Da7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769531603; x=1770136403;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Avhl9YgiSxxdK9mVnQKAOQQ+ilaSko/avISOyDtECRA=;
 b=mRuxqO3Xnnr/dMNs4wKkA3iMWEYuvOB2o15plDQ8tnW84LgtIj9v6/1bVDtiXa8z5I
 I3/t25JkvRq8Ne9BF6GM9yCEwL9yiI47u1eBp0y/m895CzR2o2Z02uQ2nNA9qZ27o8Kd
 3IEB2juvIIVq/SJiRJCnF65XbXpSIbXAMy1OGfF+xtiz6xsvaDTuazsJMQAjRjmCgNo9
 xEyyMdUzPiAJg0SWKOshjsD3XkUWvIl+p4X0bwSXgCTXRzk+dcEMKuv9m5J+ui2fd0Zr
 hbAk8L5DmJs0oVFRLo2xw1TTR9sbpoND3DUFyjH5rP9jvPuhTO3muyrLLFpV0OoOPHYc
 gQAQ==
X-Gm-Message-State: AOJu0Yx9tPNkFibAXhsC1iWPr6eRtS9oxz/Y45fqpYkbENLpbJsy3CaQ
 xhK0tcpCIZp4Jx3dgqTm+MzYe/f7dja79SmeF53muYf0+re8yzqRVGvP8hJws4YXmKjqaoP2PE0
 8RGyO
X-Gm-Gg: AZuq6aJkH6DyCKpEc7RGOMrJdiYfP6BDzlhFDrUTNYGQiTN927QYUL/rNiJ7yCvDsHM
 C6KHrrm0mMX6eTLMVryPhPLkZr17PDsZru2nZPPNmDYzABhNnH5BHBN7XtmKxP0fVryG1E4MXzL
 F313TMwfXq94iMBMd79QkoXFmOmVib59hu62zKUAi4w3EhCrvX8yXEvwIisMae9pb5H6J+IodUN
 Aplgixn5vGVbflhN3WeRdNDqUrvJK7OSULVjgYBdf0NbWc6vTuTBxUW6RECGv0QTRjVisUIRaDj
 1xcC5JX2a0qvY6dykyixftNT2iLFWgE3de2zBVyBTNVQr/b1GGZwSMHCKSiwJGURny3piLZQFfa
 wQwPlOJKxin64LKT179qL28BqBy89E4865fLRXZbfWeAPKfzHRv2+GpURREqVvidmAkwAtqRiTM
 DGjWFYPVoaQmr09MILhoFeWIpM0hjScKIouZy0rynjKtA5O2eXfQ==
X-Received: by 2002:a05:600c:4689:b0:480:6941:d38b with SMTP id
 5b1f17b1804b1-48069c92bd8mr31418755e9.30.1769531603218; 
 Tue, 27 Jan 2026 08:33:23 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1f745dbsm39978513f8f.34.2026.01.27.08.33.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 08:33:22 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v13 09/17] eal: avoid format overflow when handling addresses
Date: Tue, 27 Jan 2026 08:30:23 -0800
Message-ID: <20260127163258.75566-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260127163258.75566-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20260127163258.75566-1-stephen@networkplumber.org>
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

The largest possible string in this code 0xFFFFFFFFFFFFFFFF
which will overflow with only 15 character buffer.
Increase to 20.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/common/eal_common_memory.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/eal/common/eal_common_memory.c b/lib/eal/common/eal_common_memory.c
index c62edf5e55..dccf9406c5 100644
--- a/lib/eal/common/eal_common_memory.c
+++ b/lib/eal/common/eal_common_memory.c
@@ -1153,8 +1153,9 @@ rte_eal_memory_init(void)
 #define EAL_MEMSEG_INFO_REQ		"/eal/memseg_info"
 #define EAL_ELEMENT_LIST_REQ		"/eal/mem_element_list"
 #define EAL_ELEMENT_INFO_REQ		"/eal/mem_element_info"
-#define ADDR_STR			15
 
+/* Address string is "0x" prefix + 16 hex digits + null */
+#define ADDR_STR			20
 
 /* Telemetry callback handler to return heap stats for requested heap id. */
 static int
-- 
2.51.0

