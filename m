Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A262CD6E4A
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 05:22:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 12576402BD;
	Wed,  3 Jun 2026 07:22:25 +0200 (CEST)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41]) by mails.dpdk.org (Postfix) with ESMTP id A2584402BD
 for <dev@dpdk.org>; Wed,  3 Jun 2026 07:22:23 +0200 (CEST)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-490a76757e5so25196535e9.2
 for <dev@dpdk.org>; Tue, 02 Jun 2026 22:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780464143; x=1781068943; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=p971Hl2JXK0ZgsFhdFZuPsWJKStjiLTiXu1X5cQT6ZE=;
 b=N7AZrbMLadZFUrZIhabYlf5QYTgQEkNL396/KQDbuSaKgC8gTqHmx0jTgK+kX5Ozpy
 iKP0VbayM49IVYdSo4quyVGcOcb7xvWI08rfaVu5SxGlVVaX8Dtf+xoHDkN1c9ic9nR+
 AikAoah7FNlBHIRTrzwHY3wy3tqJYpLyozlM6YEjKYk17H1t9OiufRbKnFXAkTkjDxTU
 v8ROOtyoNacrEuGVjGdg08mh4hIv6VC6LvQ+sq0RWMGMURX6N5J5+vpNC/1YJu4gvcot
 63UHLaW5er6nvY0Wq7Yvmrki0hWi4QTnnmKZpcjMIdKaNnyhxVqCyc7YrsKb3950hOjv
 MVbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780464143; x=1781068943;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p971Hl2JXK0ZgsFhdFZuPsWJKStjiLTiXu1X5cQT6ZE=;
 b=UfHE3NxV0e8suYPpkI2c6aPs9VJ8hr6sy6isEqK0/j4h+gBQB5V/BOX36SfVNvHwKN
 R1B5xgObL+FQvTDTVRYj5nf45S3eojH2TJwfR+dQoOhQ2ItsHc06Xp8JqGV7WTAsLB34
 VYgZHsKUuhLbQgH9NPD0OC4R6ppv5RlgACaAwvFIkCImnLJPA7sHPpRh7AJbfX+iglzX
 kTawGIZ/5jrVRjRJF3+8jLBs+c2Il9UA7uYz8Mk8ATr/NYSgRcHCvTPG/FDolX4TqpRm
 eG9MQPLcrGF9rNdJjsarxucrZlnTs/bqaGK8+e5jDkn97n5B1G5EBKvW87jUJgvuOYZM
 xdnQ==
X-Gm-Message-State: AOJu0Yyholn4cz1MjEpxoF98NHlEFZ9sB++pvWibZMjmQilk96YKg4sF
 qPXOLACQ4nQ4Ddp75yNfr4o0HukRkfY4aSQ1Bu8eHetWIPzRrw29IefehbsRixYXLJI=
X-Gm-Gg: Acq92OHSHJi7n09HO1ZbbXDajjQlzZ5HV1vyvM7beW6Fu+opkUNezrKO1Fqy8DD0uXK
 Y9A7++5gwpeOIcIFNycBqoVCrD90aLZnD6LRTVM3ug4J1Ib+n2diU9FBk4CjeT5kLKJFytTJXlB
 7gxx9JphlyuFAWmuCljFWNfjAeHWjcEGDljCVYKtYsJbT6R7JK2qY4OX1C3ZhEcYO2hb2GlZPSm
 TWp6+4r2lvq+HGF8c+IVZNw3uSqsiP8WasXL0ucjuf3yMMTvgjV6dSzLi0WWYJ6GCr8vvaifMN2
 kidyrIAn3gDEPt2eRI9lGW2/6ApLDFhA6erfDFWqKibnWYjBh1hXmotp3M1MQQ7YWHZx6T/Xs8T
 9DYN/5SuwcHEiMbaU6/Pm8UHxA35FRJnEdpRtVOqc6Zz+WbLxXiIanxgpk5j3uks6gx05poRo1r
 6Qw1gQigsSWHttdSNcvWYb2My1+NZtwwpGVYmjARy9X6dRXdk12Tq+kBUY
X-Received: by 2002:a05:600c:4e87:b0:490:51e9:deba with SMTP id
 5b1f17b1804b1-490b60e2309mr26315785e9.27.1780464143124; 
 Tue, 02 Jun 2026 22:22:23 -0700 (PDT)
Received: from happy ([185.229.111.129]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490b0e76153sm117700805e9.11.2026.06.02.22.22.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 22:22:22 -0700 (PDT)
From: Denis Sergeev <denserg.edu@gmail.com>
To: dev@dpdk.org
Cc: shepard.siegel@atomicrules.com, ed.czeck@atomicrules.com,
 john.miller@atomicrules.com, stable@dpdk.org, sdl.dpdk@linuxtesting.org,
 Denis Sergeev <denserg.edu@gmail.com>
Subject: [PATCH] net/ark: fix null dereference on allocation failure
Date: Wed,  3 Jun 2026 08:21:54 +0300
Message-ID: <20260603052207.118688-1-denserg.edu@gmail.com>
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

rte_zmalloc_socket() can return NULL when memory is exhausted.
The result is passed directly to memcpy() without a NULL check,
leading to undefined behavior. Add a NULL check consistent with
the existing check for mac_addrs allocation in the same function.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: bf73ee28f4 ("net/ark: support single function with multiple port")
Cc: stable@dpdk.org

Signed-off-by: Denis Sergeev <denserg.edu@gmail.com>
---
 drivers/net/ark/ark_ethdev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ark/ark_ethdev.c b/drivers/net/ark/ark_ethdev.c
index 8b25ed948f..546a44704f 100644
--- a/drivers/net/ark/ark_ethdev.c
+++ b/drivers/net/ark/ark_ethdev.c
@@ -445,6 +445,12 @@ ark_dev_init(struct rte_eth_dev *dev)
 					   sizeof(struct ark_adapter),
 					   RTE_CACHE_LINE_SIZE,
 					   rte_socket_id());
+		if (eth_dev->data->dev_private == NULL) {
+			ARK_PMD_LOG(ERR,
+				    "Memory allocation for dev_private failed!"
+				    " Exiting.\n");
+			goto error;
+		}
 
 		memcpy(eth_dev->data->dev_private, ark,
 		       sizeof(struct ark_adapter));
-- 
2.50.1

