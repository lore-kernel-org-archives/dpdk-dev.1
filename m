Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F76CCD1B9
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Oct 2025 18:57:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DF76D40E22;
	Tue, 21 Oct 2025 20:57:40 +0200 (CEST)
Received: from mail-qv1-f99.google.com (mail-qv1-f99.google.com
 [209.85.219.99]) by mails.dpdk.org (Postfix) with ESMTP id 08CE540E35
 for <dev@dpdk.org>; Tue, 21 Oct 2025 20:57:39 +0200 (CEST)
Received: by mail-qv1-f99.google.com with SMTP id
 6a1803df08f44-87c20106cbeso86613306d6.1
 for <dev@dpdk.org>; Tue, 21 Oct 2025 11:57:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761073058; x=1761677858;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kYg0lcdDHObiw94fyQiudKYNmB7ER5WU1X3PHrvDHGY=;
 b=uRR8Min1pIPXri+xv8RminRSeo7RNZNItEMKY7+b8DsBBqA0/hjbaGMsxsl53FfHvN
 ILUGwTQgHVq2KhPxmqei6mJj+KzoHDq1B3JK20nDsZMB1rG0R3odnYtaGcLc0iRjtxci
 R4LjiRPcLMCDB9pyUFd521cTvdf2j/SEPXxr3cg1tra0BilMfW4ItstTE7UJEkHR5K8d
 1ZUSGbVH/p4bfsvxuSKBk4ALRPDpUKUpDDV7HtNRsFrTWg6UuAfmjtDQjxzYH2PA4HNI
 LjUDwtIiPl4GaLblm/0kSnbs1XdD96lH0QPC6f5klweuqFAKMOM+mACqJ3YLKYB7bM2d
 ropg==
X-Gm-Message-State: AOJu0YwU9pbplC2Fc+thzcqmBY1BsVoqi1gGVyxqXWzDcHnxvdh7WAJd
 bKLxl3FGTm7jSylY4eBY0vn3nzJKiWyFUcgldQhEMR92bP+eFDTTaEbSWzBevXzlYOdu/iCFQf4
 3PZg+i8G6q6+5G2Nt/YltUjpef9NB6kl0cS60NfjXc2lywjL7DrwahnAFCyGFlyZULqe0PK+ajV
 DKhtj9QKyYySNJJSVJKBK3NbmRnz4pLdSk7rsY/XpnSDZ/teHZCMWUFkxVgl4xcXrTg3lKXg==
X-Gm-Gg: ASbGncut4w15aJpvIDjk6knSOqOv5V4Vb/+poVPD7jZEU5uF1NIjpyhzdt2ZdPOBu+M
 +ztTnY9e12ZZRT0K/v72o00TyiE8v84bK5JEx/Lb6945alJc0rVahzIgGuR6SMbSPzdxKNcnMlZ
 6oWPeiyW7niQ+/IqtAahfV6OVnLqlckUgc90Kq9UlG2G6vpFKBcObg8LmgnMWwRSlF4pYw/xpP/
 3cszdVUOE9LUG/bO0peNxWLvZkD4svYQ1aiCYjwKC9Yp8RddfG2uJFpmEcR+aLdnTCtW8DQWLm1
 XbrsPuhtzkXjN8glY4uRR8znYXIKHQXO8MblDq5z7mZ/BJ2Ac17QQsEjsgzAGpwuN2yYOLJAejK
 fSPgAMvWiGP2CPUyISDt9rL7hewpw9+Ij7FZGDbHoloXawsN6dQfZU0gUk+CZFuABvUw4sRqJh1
 Ymp364cBRPi6IzBgMENt6t8J802SXEsauqeQ==
X-Google-Smtp-Source: AGHT+IFcLMrszqH5cHxxA0xGQG0hH0ZK5qpq1sxfY+XBm2PSY11obCPimeBgfdI7H34in7NOpuZFloMsR1CI
X-Received: by 2002:a05:6214:d06:b0:794:5578:70 with SMTP id
 6a1803df08f44-87de7773c74mr50463866d6.6.1761073058298; 
 Tue, 21 Oct 2025 11:57:38 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-72.dlp.protect.broadcom.com. [144.49.247.72])
 by smtp-relay.gmail.com with ESMTPS id
 6a1803df08f44-87cff5f84a3sm13814966d6.33.2025.10.21.11.57.38
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 21 Oct 2025 11:57:38 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-290e4fade70so44680755ad.2
 for <dev@dpdk.org>; Tue, 21 Oct 2025 11:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761073057; x=1761677857; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kYg0lcdDHObiw94fyQiudKYNmB7ER5WU1X3PHrvDHGY=;
 b=EzjNhL4bdSXhqSSq1CuHWEQAHUcflreGykAceQpWFgeCEV5bt791rEuHXQrPX3kC/d
 3iGtp5va7egcAlJsTH5FDiNWXQc1/hHBANQxrlCOI4Ocd+px4RNAG9UdW8/RZyG3nFjA
 5rPT/4popUjG3Tp8wdk5j7xpSj7ILWpoYk7G8=
X-Received: by 2002:a17:902:cf0a:b0:291:2b6f:cf64 with SMTP id
 d9443c01a7336-2912b6fd015mr201633495ad.55.1761073056797; 
 Tue, 21 Oct 2025 11:57:36 -0700 (PDT)
X-Received: by 2002:a17:902:cf0a:b0:291:2b6f:cf64 with SMTP id
 d9443c01a7336-2912b6fd015mr201633255ad.55.1761073056122; 
 Tue, 21 Oct 2025 11:57:36 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29246fdc9cfsm116598155ad.45.2025.10.21.11.57.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 11:57:35 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Farah Smith <farah.smith@broadcom.com>,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
 Peter Spreadborough <peter.spreadborough@broadcom.com>
Subject: [PATCH v4 37/57] net/bnxt: fix adding udp_tunnel_port
Date: Tue, 21 Oct 2025 14:56:41 -0400
Message-Id: <20251021185701.71881-6-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251021185701.71881-1-manish.kurup@broadcom.com>
References: <20251021185701.71881-1-manish.kurup@broadcom.com>
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

