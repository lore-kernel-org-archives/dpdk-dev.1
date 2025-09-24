Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97AEDCAC5AE
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 16:55:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5E73F40695;
	Wed, 24 Sep 2025 18:55:38 +0200 (CEST)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com
 [209.85.160.180])
 by mails.dpdk.org (Postfix) with ESMTP id 0149740B8D
 for <dev@dpdk.org>; Wed, 24 Sep 2025 18:55:35 +0200 (CEST)
Received: by mail-qt1-f180.google.com with SMTP id
 d75a77b69052e-4c7de9cc647so530321cf.2
 for <dev@dpdk.org>; Wed, 24 Sep 2025 09:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758732934;
 x=1759337734; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iWWS66bHH58GbqAicQnOhAPRbhwQHho8WNyBAWVapGQ=;
 b=keN67/TqMhYHA/sdVqyKyvn4BZpFSEkJHUTSnwrFZiHzWL+6/gSiZGviXaIEDjMIlA
 biPfAp+RkCninRdGyYIMzgJ6Kgc0+LdNzn67HiG+VIf1BV6cd1I+7Xtuk8/bqGGByJBH
 o53ZqjapTWSsbtv2xQgcOZACopPoIBhzgpn297JPDxOLIM/6JiaHOPFM0ekNTL4oDEwb
 h5ddYoGeSjulK4M3DYU2UuLkbzzdlD/uLaXz3ka1SiUlrxopFquxYmDMqMYrbRBGU8RR
 O73MQ/Wd26XU4VVR/76/Ss/LXDIRJAz4X9OXk69N/jp9O2Oazz2LbtUo1GIGVanngoJQ
 eaaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758732934; x=1759337734;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iWWS66bHH58GbqAicQnOhAPRbhwQHho8WNyBAWVapGQ=;
 b=N5iLpobIaFWQ+6Wm0fj7954IfOZDrDxE2Nzsq1mJW0t1eOsF4h+gG406R22JQ6f3UL
 b8iXEzgMWxSftafPTQOASwFAZ/GqtncPtO80LNzlCuJ/DMUeuQ7gyBVYQq/DL2sddzM8
 YwXsqAY2rFqhA2btxZHqNf3e4KUFqR6QDcd2YbmGyz0EGwqLmqVm9NEda95xKzDhcuSw
 t5yjKlfEp+yrBEyJZ34j3XnQl7wyNHHWw1F4Z8+UdJQ7nLSZo8Gbvz/nZNXKtGkIZEch
 bOYisRPF8P0GmQOdw2hy65GNyveRfH0SVjarKu7x6BkgUGCnF2qdBFVHyOMBB9w+nCtl
 G6/Q==
X-Gm-Message-State: AOJu0YzjdjWGAnRlkzMatjHS1p4kUWuVBy9q28F72andTHFDCiPOhaMa
 SPXROmNJKJOS/5uPSAAXW4f/+bri1CXtVKtrmR9MmRuieQTUsqh0tbg9QNrcUuTMxviePJ/UG7P
 NgmLX
X-Gm-Gg: ASbGnctVVtN4T/M8Sy1Q2TNVxsJwr9OupdqhDVmZI7xxtwMpJTH21WmmN9dvwEf/vEs
 3mXnsfjS5mVIXuTsQDk+NmiuEFEbVXGVQekRmVrd+MVj9TH2l25YZVU2IhJXY8h4s6L9h76Ck4A
 qwQeZ0z2N4CMplStxEl7u1oPd5jj9mk9tmStpRrQepQpy0YuOXxV45fat6GUHy5DGRtxAc0Pfvm
 9aJDbl420K2bnVeO7FH+vdZL84rqmHGWZ99E7KwQnaeV4cs8dyqhQKKK4EJIMAZRnFDJFrg8UZV
 86eG6QDLePKTp0cKbFU/bk5HzKCpgsy3Cg1ELRPMsjzVmD7BOshSqFY90YWVgfF7Fr8Jc4llyZw
 o5ncFdANRI/pNwWucHb/EPwniRkytTgoVfgewSUiJtvFOucLMQj7ROSpyapbQZ2ReP3G70KBV
X-Google-Smtp-Source: AGHT+IFwgcPMuwAmnLS7lI48vSQ1A+oJ9UrxBN9wm7DnoEJQroaRuXENKaexUQGcV4AoL9CzvCoHYQ==
X-Received: by 2002:ac8:58cb:0:b0:4b3:104:792c with SMTP id
 d75a77b69052e-4da4d21f151mr6184811cf.57.1758732934286; 
 Wed, 24 Sep 2025 09:55:34 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4bda15f91a0sm106052751cf.1.2025.09.24.09.55.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 09:55:34 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Rosen Xu <rosen.xu@altera.com>
Subject: [RFC 3/6] raw/ifpga: avoid use of pthread_cancel
Date: Wed, 24 Sep 2025 09:51:10 -0700
Message-ID: <20250924165527.268645-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250924165527.268645-1-stephen@networkplumber.org>
References: <20250924165527.268645-1-stephen@networkplumber.org>
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

Use refcnt to do controlled shutdown of control thread
rather than using pthread_cancel().

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/raw/ifpga/ifpga_rawdev.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/raw/ifpga/ifpga_rawdev.c b/drivers/raw/ifpga/ifpga_rawdev.c
index 5b9b596435..d61927f193 100644
--- a/drivers/raw/ifpga/ifpga_rawdev.c
+++ b/drivers/raw/ifpga/ifpga_rawdev.c
@@ -573,13 +573,7 @@ ifpga_monitor_stop_func(struct ifpga_rawdev *dev)
 
 	dev->poll_enabled = 0;
 
-	if (!(rte_atomic_fetch_sub_explicit(&ifpga_monitor_refcnt, 1,
-			rte_memory_order_relaxed) - 1) &&
-		ifpga_monitor_start_thread.opaque_id != 0) {
-		ret = pthread_cancel((pthread_t)ifpga_monitor_start_thread.opaque_id);
-		if (ret)
-			IFPGA_RAWDEV_PMD_ERR("Can't cancel the thread");
-
+	if (rte_atomic_fetch_sub_explicit(&ifpga_monitor_refcnt, 1, rte_memory_order_relaxed) == 1) {
 		ret = rte_thread_join(ifpga_monitor_start_thread, NULL);
 		if (ret)
 			IFPGA_RAWDEV_PMD_ERR("Can't join the thread");
-- 
2.47.3

