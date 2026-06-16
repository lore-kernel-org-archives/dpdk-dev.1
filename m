Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C54BCD98DA
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 09:43:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6AAA940298;
	Tue, 16 Jun 2026 11:43:08 +0200 (CEST)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id BC4FE40289
 for <dev@dpdk.org>; Tue, 16 Jun 2026 11:43:07 +0200 (CEST)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-490acbb0f89so28024845e9.0
 for <dev@dpdk.org>; Tue, 16 Jun 2026 02:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781602987; x=1782207787; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=y/OG/IEoRpIAZcFfnUiYFFsyew79MTQ2TPcX4LFRB4Q=;
 b=Cj3ECSH9Dk5Gsaqyl7jkTdc8RlOUms+6SSYZWzgnvT/xkboM/0mB32cQO9haqazpEw
 cx6MlMWuKMzaTnB/NUjjHEvbhA1taRWf7K464y2q3fJEQ52+R9jhWBf+xE3jjmxJuZkU
 76+ZVm851QWOfInpkwykPp4TzLjWLTlpPBQK0Drwz3gY+qIqsWMssPIOrIAyFF6Ti9pT
 afkU/Wqx8p202vzVlLHc3g4pLKkWHbiCwOsz5kF33UJP8kQ8VdA9Z+FLoYWFp7NrO1mB
 f23l2DYMWgTE8ZMB9eRyUB7QCIRY1ZtivKitBz8XEmwsS9rZFa1C8C5SYTPtemgUtY7S
 RndQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781602987; x=1782207787;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y/OG/IEoRpIAZcFfnUiYFFsyew79MTQ2TPcX4LFRB4Q=;
 b=a1C3ZxpmLGmcwK3I+lcwkMudJQu3QdzBOxbdsmvoUVvvfyvaVverKJ0WMaDq7MbROi
 x9KcrbbzDKePTP3lm2yBpD9hj1UD8Ew9r802S4P4Cx2eWE3vP30zU5k7k3KxNTnAfSRz
 cBwZMP3eka1s06iE275kk9dr3G6x7/vJK2T2WyHULQiDH2IkemBEJhDfeyvXl59CqJcN
 fcM3fgg4qVWDxLBE81w4Rg3bg1C+hNtKuzth+PO5qzuTavZIuVs/ZD7ZcP0kz8bRZID6
 /epnFeGpyvRMBOHRWjQSXMt92Sbf5DU2mdI8KwICAJVdkJD374B2XmDtJ5rgAR/OxAWu
 lOXw==
X-Gm-Message-State: AOJu0YyhAFtGvw/D0lsaqwXwd6URyPXsfJqLxhHXdfos02bSZZH1HAo0
 Qad8khtun6oFGc06XlGY9ZZhX63f0YMw8ZKwn77BVcAu6MrsW4EeD37f/bEa8RzK
X-Gm-Gg: Acq92OEaPUHBY7ujty2Qbu48ydTd3c0w2Z4SSeM/5TaoLN96iQlWV6zuzFi9+/m6AnK
 9JSgsBJnCEyuwH2omiCDn20cagDIp/OjfNSeRVcKq/yYygCCKlKcuDVt5fC+4SXy8rRjU394Uav
 zqbHY1oU9Q8yTJmihGlGue4QhItIvK4T8LLUjRcOtqSARo1iJ4U07VsglyYs3z8Hw94noKA5Pza
 pKrqInsAlXh7hZusNlZo2aIjtaPhT8pGvQ6fOmrhmmkyoHisA0mjYwcaRZGoJXNTeEbNBBzrakF
 gSs3FhIUfxo7JZiYOZTXbB25Wquw0zluflTidyUO0qCfRPeWUfoS2m3Zr97AfevrKY2+fkOjeg8
 D3g8d7UNyGcpKdBgFXO2kmVMqRbelHlNf6ZsOeEFkb7uLhgmjecGufoFMZAJ2clgyyYH+3xvpIR
 hpG1m2kpzLute/3lKKvtjxGt3ePteC1ZjJ3Ok0Xt5AZqa3QaqpBv8U
X-Received: by 2002:a7b:c017:0:b0:48e:6db3:ff2e with SMTP id
 5b1f17b1804b1-49220093459mr141526145e9.15.1781602987090; 
 Tue, 16 Jun 2026 02:43:07 -0700 (PDT)
Received: from freepad.iliad.local (free-mobile.vlq16.iliad.fr. [213.36.7.11])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490ea95c51dsm290345795e9.1.2026.06.16.02.43.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 02:43:06 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH 0/2] ethdev: fix fast-path ops on a stopped port
Date: Tue, 16 Jun 2026 11:42:56 +0200
Message-ID: <20260616094259.686555-1-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Two small fixes for fast-path ops on a stopped port:
patch 1 stops rte_eth_rx_queue_count() from dereferencing NULL after a port
stop, patch 2 makes the dummy queue count return 0 (empty queue) instead of
-ENOTSUP.

Maxime Leroy (2):
  ethdev: keep fast-path ops valid after port stop
  ethdev: return 0 from dummy queue count

 lib/ethdev/ethdev_driver.c  | 2 +-
 lib/ethdev/ethdev_private.c | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

-- 
2.43.0

