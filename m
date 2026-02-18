Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A64EE9A047
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 16:05:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B44240651;
	Wed, 18 Feb 2026 17:05:09 +0100 (CET)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53]) by mails.dpdk.org (Postfix) with ESMTP id B566840653
 for <dev@dpdk.org>; Wed, 18 Feb 2026 17:05:06 +0100 (CET)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-483770e0b25so63575e9.0
 for <dev@dpdk.org>; Wed, 18 Feb 2026 08:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771430706; x=1772035506; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fOAy6ibOoY+/rZf51Mfr1P5bEZ4FldQUvV/ph6CHfsM=;
 b=m/U3Noy8BP73wcRkEyQLKIBSzcPdUxoJTj+/h2yuHdL212XRAyuSMXXuO4/DtUD3PM
 4mZBw1REPZ+z3yvAA2pJq2bZuU0Qg0g0Q8FS/70OhhulkWWYkl2DNXEjSNTkYn0sB1L9
 RqENKhOeBeGALe4620P5xW1EZ2POlU18grUZKnk0jXLPugZ+TjAvT4LtMMkPuv9wB0lk
 VEjFQB7J/0rrOPy548gDRdUezyIoQNATvWkRkhmY71wAuRM1Sw2KSA6bSoc1g9xY9fke
 oOUme/6oPyJtDefrS8oGPyZ+5LQ75eId+8CDB6BuIWp+v0NE055JOW2DW5w3zyotpAnO
 1kLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771430706; x=1772035506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fOAy6ibOoY+/rZf51Mfr1P5bEZ4FldQUvV/ph6CHfsM=;
 b=Yqy6nahyigTRNvsQE7bFDNLjIrUzBvBPU7+SKYsmVaKItqcU30SqDULSgiZd93AT1X
 3pSJg7UdSt8w9RHh0UYosMU5hgRXyQtfbkskIA++q8vnl+jxF4Sac87k0RnjucFuc1Pu
 ukq7qbFPAkdpOYj8WvP0c0ddObT9gPhGwVbg0in0yZb7BGWfJHnIXwMfJjOqlVKAJbpx
 xrs4he13u/1oIE0++pu4008x3IFSgplBrnsTfuSSXsPg1ZixGsL7hI/lkKRXUvdJ40eG
 ILim7P3azhQoTf4iklTxWo0jsXjDcB04Bwr4NeqNJmlPD7HZkOKqe+CPcS99p6DmaAb8
 LUXg==
X-Gm-Message-State: AOJu0YxZbS7jfgDE3YFhkGF5wzY+sGDF3GRB2QCdUIk9dd2m1vfmTuvm
 cMx9SvYiLSXORVtU5j1uGnmfDgQVKVIhjWrkx+RcgwLsnJ5BvdsqCOub
X-Gm-Gg: AZuq6aID1b+/xDOb9UlPDNAgcSDl/yt+Z3Qo5n4J3qa63CbncnG4lN/4aSdhfeMUW/H
 VAe6YC+cQsOL7Htp7YGFetCsbaOsMzR7wjCQ/uRCgriIvTXjH81aZE1dSXyjSq2+FSUtO09PdvG
 LFw5Zgl0BjzdicSqCvoXyLg3Ewaa3dYmJbl4SUa/pkL89QIGuh5xUKFYBYhgB8GeLR6ya3PSO9P
 8ZbPSpm494iz+y0gVVeAzK+xJEW1dHP3QsieFfuTsfbEgM1XEvJDHRhHXqgiZ8r6fRniZS6wYYr
 BUMnb6Pl5k80rGowSJxuYgmG18nvmzEmbCxf0buaAJ1bnwiDOEkpO0sADEHnR0cVNQ267ZKM7EL
 zMWdzxK19aRlYLKrfmzqGKIWKlutPCj0ncs80WObJ00dLxxCwQgKuSfr6CFB/xFCooioPtkUHav
 AsPttarkTBZ/9C5mfdG1UWF1y9CL3zFyfEmwEy
X-Received: by 2002:a05:600c:3143:b0:480:53ce:45d3 with SMTP id
 5b1f17b1804b1-483710858d3mr320607475e9.18.1771430706107; 
 Wed, 18 Feb 2026 08:05:06 -0800 (PST)
Received: from freepad.iliad.local ([213.36.9.41])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835dd0e327sm604619175e9.14.2026.02.18.08.05.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 08:05:05 -0800 (PST)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: hemant.agrawal@nxp.com
Cc: dev@dpdk.org,
	Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH 05/11] net/dpaa2: fix resource leak on softparser failure
Date: Wed, 18 Feb 2026 17:04:47 +0100
Message-ID: <20260218160453.142311-6-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260218160453.142311-1-maxime@leroys.fr>
References: <20260218160453.142311-1-maxime@leroys.fr>
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

When soft parser loading or enabling fails during probe, the error
path returns directly instead of going through the init_err label.
This skips dpaa2_dev_close() and leaks all resources allocated during
probe (queues, MAC addresses, extract params).

Fixes: 72ec7a678e70 ("net/dpaa2: add soft parser driver")
Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 drivers/net/dpaa2/dpaa2_ethdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 61dcfafff6..3658e24dd2 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -3164,7 +3164,7 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 		if (ret < 0) {
 			DPAA2_PMD_ERR(" Error(%d) in loading softparser",
 				      ret);
-			return ret;
+			goto init_err;
 		}
 
 		ret = dpaa2_eth_enable_wriop_soft_parser(priv,
@@ -3172,7 +3172,7 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 		if (ret < 0) {
 			DPAA2_PMD_ERR(" Error(%d) in enabling softparser",
 				      ret);
-			return ret;
+			goto init_err;
 		}
 	}
 
-- 
2.43.0

