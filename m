Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B602CCCD184
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 22:17:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E64E40E1F;
	Fri, 10 Oct 2025 00:16:17 +0200 (CEST)
Received: from mail-pg1-f228.google.com (mail-pg1-f228.google.com
 [209.85.215.228])
 by mails.dpdk.org (Postfix) with ESMTP id DD05840DF6
 for <dev@dpdk.org>; Fri, 10 Oct 2025 00:16:15 +0200 (CEST)
Received: by mail-pg1-f228.google.com with SMTP id
 41be03b00d2f7-b551350adfaso1199520a12.3
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:16:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760048175; x=1760652975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gkRyulW4lfOVm4TeHnHm5SaaCDky+7PT5BGsz+PYxkw=;
 b=C8wTZrB3gvfK70t49Ejm0CB94X7haiPN6+qWC7+gEV739HZPr/j3AE/glpPzdsJP13
 z5qGAQKNgOww98BvB6THt/CQv/B2+rHkll6wJLZGocDw/BXatzkcJ+Vx1UGJvdPgLEku
 bt7L7mh4TFsx+6V2fUwAvxErvnfKQTnPyHvFZHNcWVkDNdZS7gARvdUYrvk29y7OoN8C
 9UDLCZX6+3eDo2PIOzF0gfXu0MYKpDu/+2X58nMGEo8A2s40Afk7lrQ5qXx4kz07AM57
 /ftdR09ogiPXNuMrhn0KpSNU+j4gaXXWkgq4KwoQ8Rsh5JYYdumwJA84Y3mKPO9AAkvN
 t1+A==
X-Gm-Message-State: AOJu0Yx36Rz8EdpaJQgRpdJ73k2SxAvKLAYIJ12pYRuWqorRiEFE1YAY
 HdgmV7kyA5tBJBMuN60WcS51z6ftz+0pi/+CuCb6JsZjlf+f/bA65fXS10bppSihX8yxbWXXAB6
 9MLsvCECifjS1prVTDxXuhz6Cf/5vnaq2iDMlmO4rrUeZ8cxqosXL8/AA1wK8qvkYaBmTE+E8OO
 5bgoasR3vYJiogRvbVcSW8ssD6iO9MQ6RI8lew0mtLqyOTKcoL8ivS2JJa5dmWTxIznQtm7w==
X-Gm-Gg: ASbGncuUqMuwFOdoPvhyUKpeMuR6RuTgZw0GkqjGtBd/AGdVdkMBhNzgAUlRwuILW6W
 /ukS5VxnrIkqOF9IjWw5yaXtlWtcp9obTM6xSxeMkWfhpnHcmX2wTJMAW4EVKA3UXSWLi8LfRxo
 tghMHPAUeixYu1kOKPBrBuWwuK/1pHJhLEd8rSmkT6godmQYee4Gd4nuh44NSTcjwypxip1pl4G
 XK45dYggnq7d/U+G1EpPGlDmCcRigiRidElV+yGOpOxmlALZ6p+SNzDS6Ff6ECz9agAMFomNaJj
 FsfqI6+zfebW81XyXdofQWYF+MlCbA2ieogK+b7CxbqKWHOrngoPuqdo9qtur7a3iSheNipxqGm
 Ms4YoSeb0qEQY6OdDEf/L97tYxZCKtImUqxmjo03lzIukj5xa05JTz22qItGL0KHWwEiZwAdUd8
 AQ2XFSHUU=
X-Google-Smtp-Source: AGHT+IFt3mhxk0hlNtnt8sNlDhy3GnPEvL4zqxvmtdnwMpHVw1FtL5QCfV6xglGZoWJyxiU5pBxQlZSwRaaN
X-Received: by 2002:a17:903:9cb:b0:261:1abb:e302 with SMTP id
 d9443c01a7336-29027373d8bmr113676275ad.14.1760048175010; 
 Thu, 09 Oct 2025 15:16:15 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-29034df5b0dsm3211255ad.15.2025.10.09.15.16.14
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 09 Oct 2025 15:16:15 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8787a94467cso51695016d6.0
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760048173; x=1760652973; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gkRyulW4lfOVm4TeHnHm5SaaCDky+7PT5BGsz+PYxkw=;
 b=Uc6XnT+1FYdxf/4A+HIUxIwLCbnvpyKwFHkLLYMTGZB2bSN/YP+lLnio25rx6Pzq13
 Tn46Z7+iF0Yx4HYGdDR4DYmHzBHeS39sdvNm6GiFKsSu4l5lj+YzEiddHbKfm1686GlE
 v365tEMZDYSEVU7rKa32K0SKErHiWILW+mh1A=
X-Received: by 2002:a05:6214:5083:b0:783:cc80:1770 with SMTP id
 6a1803df08f44-87b2106d967mr142685516d6.25.1760048173175; 
 Thu, 09 Oct 2025 15:16:13 -0700 (PDT)
X-Received: by 2002:a05:6214:5083:b0:783:cc80:1770 with SMTP id
 6a1803df08f44-87b2106d967mr142684716d6.25.1760048171858; 
 Thu, 09 Oct 2025 15:16:11 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87bc3479344sm4189986d6.17.2025.10.09.15.16.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 15:16:11 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Farah Smith <farah.smith@broadcom.com>,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
 Peter Spreadborough <peter.spreadborough@broadcom.com>
Subject: [PATCH v2 34/54] net/bnxt: fix adding udp_tunnel_port
Date: Thu,  9 Oct 2025 18:11:09 -0400
Message-Id: <20251009221129.28256-35-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251009221129.28256-1-manish.kurup@broadcom.com>
References: <20250930003604.87108-1-manish.kurup@broadcom.com>
 <20251009221129.28256-1-manish.kurup@broadcom.com>
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
index fad357f3ae..a395c2ab47 100644
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

