Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDB1CCF9EB
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 16:20:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1527140A6C;
	Wed, 29 Oct 2025 17:20:11 +0100 (CET)
Received: from mail-il1-f225.google.com (mail-il1-f225.google.com
 [209.85.166.225])
 by mails.dpdk.org (Postfix) with ESMTP id 0A896406BB
 for <dev@dpdk.org>; Wed, 29 Oct 2025 17:20:10 +0100 (CET)
Received: by mail-il1-f225.google.com with SMTP id
 e9e14a558f8ab-430b6a0eaeaso67675645ab.1
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:20:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761754809; x=1762359609;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kYg0lcdDHObiw94fyQiudKYNmB7ER5WU1X3PHrvDHGY=;
 b=qj0d02TDCfV69aM0bxRYgT4ybPRvl5FAXzj8U+E07dBTvCLE6u+Ug0NwPsqviMQoWQ
 5/E4PteTLxYqJajXAdCJu7SixaxZlcIhIa2yZPsmWRkgektIk1m5G9oc54J2ZG14BY/7
 3OujHTr1hG70oDDppd3vVozK+pRw/l/yqkvSV9xBMXqUUnJbeyLOc06RWVsO17KqH0Ft
 WtvNjs6P+P0qssXjxzAIju4XdML3f/mMTviyP+WxDrwVCOfe3S4weJdxk+20s4NjBHNj
 u36m5hShed3WHehxozHWDRao1gzCoi5+NJqPGj28YKH4UHTEBhBSvhJbuylt/YO3vbkH
 H7+Q==
X-Gm-Message-State: AOJu0Yy60yPJgtXNuoRzi4W2pzg5WHC1hpL0TL05Ucz287pMAdSTHOMR
 TMNG//0SH4G3xVK8s/Eu00Tdwnq6qfgglUJlf38sm2CMrmLSvCUW2FW79A5gXDkXiECVF6+MjeJ
 W5M4qTRWgKf6DgP6WdrshkFe9xcTcXO4ujQ7tUI0VJr2hX7oDmjMEkpFRHtD3RQG9iZ9hnxKqUJ
 Q2obhb6GwMkRA3K+g3PA5ljSaCXiC7YNj805HQ9UeMF3YFiPH1+QM1WIlgk9W+fIY25gvfXg==
X-Gm-Gg: ASbGncuBFqOllSwPmuGxU9inGKWsOeH7k/i8tLUCHMsEkYNjJYUgiT5wjqouDfkNx1S
 xCbbCcVE1vmdRKE3pokFSGIGziLLZrCtH0Z8NCJOnwxbMFmBlClPJHfg77XKQ10TvcLSCzq9AtM
 DV1G7TlYcIBz/kzvibRqcPMpymRGTj264r3LOXjZ77wtPdIecjFAaxc2Thr5QHco/9NVMAob+Xw
 w2klyVvTG7/QL6FQps2KgtQu8on968lNcdg0ILtFzNd9EjMudOMuLAbKEWVexZY05YWrd3CGDg3
 FspCtdO6bpocOZY1gKihth5GCJ4JvOWPeb28ps0ZmKZiONthedWoqOLlffSWXdVoBcokDQH9ofP
 JLTG3OdWLqJwTrGQbpL9yUDDepDb/3HTx0u644QXxoPvjcuzddvW8wAebEMP5OMOxim1NjwrxW2
 YW8z8Gx7YQacZLjfj+EV9EdixGuvuM09k=
X-Google-Smtp-Source: AGHT+IETg5UjM09J0/eShKrSfHh7N1vgDFmR3T4+ChHiSsoMK1ZxNTb9lGabD7XZsDsNyEWyyJRBNnbHOiq0
X-Received: by 2002:a05:6e02:16cd:b0:430:ae12:c5bc with SMTP id
 e9e14a558f8ab-432f904afcemr40338365ab.28.1761754809347; 
 Wed, 29 Oct 2025 09:20:09 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
 by smtp-relay.gmail.com with ESMTPS id
 e9e14a558f8ab-431f682f4a9sm13865365ab.15.2025.10.29.09.20.09
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 29 Oct 2025 09:20:09 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-89f7a8b9775so1522030785a.1
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761754808; x=1762359608; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kYg0lcdDHObiw94fyQiudKYNmB7ER5WU1X3PHrvDHGY=;
 b=agToS12b6UKobvymqDDYDyC5aaD7T2H+hXE1I7UwMXqSocZoS0BKU4rimIQ3I++kTv
 WWNmOXyo8aY6Zc/fM/kAeadTCeBr5quELVV6LivuqWpuY0g+or6cPa1ShITCnPArRiym
 V4vF+BeP67demmtvUW2vrHz86IQCGThmi9+xI=
X-Received: by 2002:a05:620a:40c7:b0:890:492:cbcb with SMTP id
 af79cd13be357-8a8e473a5bcmr549512585a.28.1761754808053; 
 Wed, 29 Oct 2025 09:20:08 -0700 (PDT)
X-Received: by 2002:a05:620a:40c7:b0:890:492:cbcb with SMTP id
 af79cd13be357-8a8e473a5bcmr549506685a.28.1761754807502; 
 Wed, 29 Oct 2025 09:20:07 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89f2421fba6sm1089026785a.4.2025.10.29.09.20.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 29 Oct 2025 09:20:07 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Farah Smith <farah.smith@broadcom.com>,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
 Peter Spreadborough <peter.spreadborough@broadcom.com>
Subject: [PATCH v5 37/57] net/bnxt: Correctly account for udp_tunnel_ports
Date: Wed, 29 Oct 2025 12:06:52 -0400
Message-Id: <20251029160712.58519-38-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251029160712.58519-1-manish.kurup@broadcom.com>
References: <20251021175049.46092-1-manish.kurup@broadcom.com>
 <20251029160712.58519-1-manish.kurup@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

From: Farah Smith <farah.smith@broadcom.com>

Do not increment the port count if adding the same value multiple
times.

Signed-off-by: Farah Smith <farah.smith@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Peter Spreadborough <peter.spreadborough@broadcom.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
---
 drivers/net/bnxt/bnxt_ethdev.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.c
index 94bec74c1e..54613076b0 100644
--- a/drivers/net/bnxt/bnxt_ethdev.c
+++ b/drivers/net/bnxt/bnxt_ethdev.c
@@ -2622,7 +2622,6 @@ bnxt_udp_tunnel_port_add_op(struct rte_eth_dev *eth_dev,
 				PMD_DRV_LOG_LINE(ERR, "Only one port allowed");
 				return -ENOSPC;
 			}
-			bp->vxlan_port_cnt++;
 			return 0;
 		}
 		tunnel_type =
@@ -2636,7 +2635,6 @@ bnxt_udp_tunnel_port_add_op(struct rte_eth_dev *eth_dev,
 				PMD_DRV_LOG_LINE(ERR, "Only one port allowed");
 				return -ENOSPC;
 			}
-			bp->geneve_port_cnt++;
 			return 0;
 		}
 		tunnel_type =
@@ -2650,7 +2648,6 @@ bnxt_udp_tunnel_port_add_op(struct rte_eth_dev *eth_dev,
 				PMD_DRV_LOG_LINE(ERR, "Only one port allowed");
 				return -ENOSPC;
 			}
-			bp->ecpri_port_cnt++;
 			return 0;
 		}
 		tunnel_type =
-- 
2.39.5 (Apple Git-154)

