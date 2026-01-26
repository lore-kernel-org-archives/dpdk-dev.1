Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE569D19502
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Jan 2026 18:08:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2BE55402DD;
	Mon, 26 Jan 2026 19:08:17 +0100 (CET)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41]) by mails.dpdk.org (Postfix) with ESMTP id 312D0402D0
 for <dev@dpdk.org>; Mon, 26 Jan 2026 19:08:14 +0100 (CET)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-47d59da3d81so37399015e9.0
 for <dev@dpdk.org>; Mon, 26 Jan 2026 10:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769450894;
 x=1770055694; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LIwjPUyDgRiD0DHepvJP9myvd6PpuecppEf0i8Ru5EU=;
 b=rgLOJmzQ8vXptQ7RUe36F/7yFthGyiAMbwCzylrzGz4crWR6I6YqWEOxV7q5QZQ9ka
 JJ4F+DosVr9tc9wo7j9Ed5HyUnwQoKpblaUDUPLq6DnEl9Br9yHC0dYBFKRCcigw8nz8
 2O9yBKtNnRYNkSAW5CWNS2ofQPC6aP+qpHkJpYMMfo36exdvYhNuoLSzeJ1CLczi+8Vy
 KtjHLws5zAvKyox0B37nl5qE2nDUfmJdpVy3bEBGsKmG9u29pCxwIBbSl3cHa8b3w3fW
 WM3kDx/M5MiX0zaa8UTgRyJYTNFAZjFl5NYz4A4XTDjLLUtru68yH+hanok6K9qKLWxT
 GM6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769450894; x=1770055694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LIwjPUyDgRiD0DHepvJP9myvd6PpuecppEf0i8Ru5EU=;
 b=dxZ6uouyf1HgFJyXxISaPRVHVQDJLF0OF78MeG52D5Io4+CV2xyh+2a7BxQGJ574Jp
 fEUl7WYZJlOP57/vMSpp/w75VD4eOEBs/YEerQu7JeGHM/T1GLhTkY3nXaCun1q9d4m+
 FhGqsG7OLr04VZpJx14eBGZw+rXU1V2uCml4tLWBdqtpjy1lUNqD0sn+1wK+aJ32F8lO
 G2IxQjaRnpR9hXp5cdHGMqtLXeH96LX+FHLZcht7ati7sPMGIPxEmcwUUBVpgUs+giRj
 fCn4yMRvk99WuPoQzMNJ0XrpECL+Mv+F3kcPebjyoD+OZQ7fNNiaj4QlOuAtnWuVkmjm
 R32w==
X-Gm-Message-State: AOJu0YzxS8WfDYCQb1NEw+sxpRYEDxL6GH5VMnmydHxQqsd7nQPlSgfa
 kyn4oBkktLdCX/XT3ZR3msyHHlMBylBBdEsYqoWyuRPqGt0tw0Yan3Ltv6E5IfDh2v52l8TK0CC
 +et0q
X-Gm-Gg: AZuq6aLLMQpRcmpP4GfMlQ3Ko2Z0LK0a8srx+TgYwFN3CLBGsFqq4upCVugdJmf2Ow7
 WuMMjEWttRObIo/W3JF1i8z/xE4GyYJUNMJFPVnvS+N4lpeiaDq6BPhnrpdr2hb65rUvHgaYR17
 IRvDHZESQOoj1CadzEM49NyiF7qx6q6VYgdUJdfTEXgvuNHUxiqGepihM7uCb+xsRPea3gdjk30
 JAzCheCPZSK9a7K7hLWGF9wIQWfkl/uF8VVzmFr0thlNvdg1MuyLbiAc7ZYMwDo6lL5yq+V+8UT
 UQDztvqNc5e3hhKxK+hqiIKqBjRP7yT7ClRciMrnzjgFeEf+xQz/VBfAZVlQsYMunIHahVzPUIC
 o+Eg76Pb5mmq2QVI0y4OtMWPPWK9zCmCF0cPRFobcyPHyjvs+66W3ok4TKaxQNQGZ9Eg4yVKUZK
 4GF+p82STCoyhmOxkZnb01a0Q5aAZAX0qEWQPvifqKgO1oRElfbg==
X-Received: by 2002:a05:600c:3e88:b0:47d:333d:99c with SMTP id
 5b1f17b1804b1-4805ce574edmr92649305e9.18.1769450893598; 
 Mon, 26 Jan 2026 10:08:13 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c02c91sm31845864f8f.9.2026.01.26.10.08.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 10:08:13 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH v7 01/13] maintainers: update for pcap driver
Date: Mon, 26 Jan 2026 10:06:38 -0800
Message-ID: <20260126180807.100891-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260126180807.100891-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260126180807.100891-1-stephen@networkplumber.org>
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

Nominate myself to take care of this since already doing pcapng
and pdump code.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3e90cb8c28..62da2be759 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1118,6 +1118,7 @@ F: doc/guides/nics/zxdh.rst
 F: doc/guides/nics/features/zxdh.ini
 
 PCAP PMD
+M: Stephen Hemminger <stephen@networkplumber.org>
 F: drivers/net/pcap/
 F: doc/guides/nics/pcap_ring.rst
 F: doc/guides/nics/features/pcap.ini
-- 
2.51.0

