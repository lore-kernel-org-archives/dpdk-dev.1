Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455F2CCD18E
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 09:06:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6D7B740FDE;
	Wed, 15 Oct 2025 11:04:57 +0200 (CEST)
Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com
 [209.85.219.100])
 by mails.dpdk.org (Postfix) with ESMTP id 38E0E40ED8
 for <dev@dpdk.org>; Wed, 15 Oct 2025 11:04:56 +0200 (CEST)
Received: by mail-qv1-f100.google.com with SMTP id
 6a1803df08f44-78f58f4230cso73020866d6.1
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:04:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760519095; x=1761123895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gkRyulW4lfOVm4TeHnHm5SaaCDky+7PT5BGsz+PYxkw=;
 b=dx2Fg4FIwCgOrtvJYx4gdobaHwYawMCKFMiR8Y1Y+7WX8wdQ2PwuUvrNQslz1nfXPn
 k+vETh/gd2mgEXFUp9aJ1THOpcqafsresSAlVQLwcK3KNfsptlsmwdZiFN1jRKFzvjYD
 jhx0HztaWewGMgqkyowsdAbuMYqVh+XAaw70B47ZiJyNm9TzQyrjW0vt+KSFOP3cnN+r
 wXycRpg6mtgoTGSvlCgUfe24nzGgmzI0WJP19Dcore5SlXt9fJjT/8L6HR6r/5Z2Wpy8
 9EvBBE0TvMk1QCuMXHtYQr/B1emJmCg/tiS+ForXfzmUPwGyH4gg03jIutz1UVH09NyD
 UHPA==
X-Gm-Message-State: AOJu0Yz3n6PWNLUQEFY7Q++17+LgD8PnmRnM2O9I5RSxv/WpHzLSBlAu
 jJid+EzD+PQUp4MF9NwB5zTdPpHIhGuebdNbx74o/KbnjyJjIMQRgbnbfr+b2jvPqNLgU1EyNyn
 wteRlRdLUb3U3WZ0Sv3WYhbT9hIYaEeu4DlUuVEOypNLPIY535Pckl766qogvFiLVM+5dnymTmA
 pgXv7WUxf+Ej+/1da/H0HR5DuTaHS11QKfJ+Os/OeAzP5s2O5FGOkAAIowSqYkz578JagiRA==
X-Gm-Gg: ASbGncsKD3X58hXpI9sDu6S00Ah+pNW/cUqB1hGTVlJmXp0R+ppjIs4yfpGDhrNkCIU
 jC6rx8kVbWxw9lf0wvH0jgsx8cTkcKG2MFZya7jO7YvWM+HmXBLR3/0bu4o9zJe07HNlc0w0aqa
 3Z96X44RoDxB/nAdG7AjPYtJQC0AHMLHIx7TELdxv1j/yC9BWMFYHVV+PqjIFwAhUzsGK2wQCWn
 1uh6Kn88a5Ke+2iSuzjqa9dKxPsRGJ69MfCFUGPPFKTHyo+7geM2oNyuSJ049G4KIvQRzgXn96h
 soY3TfYnUvHPX94HXHzxcBgVVzJHK7cHAXUEzzSdcc8hWJTvrwswxQVie4iUNMldgppLWMZf4MX
 +2fYZTcgvW6Se2mewVZxA85Mp89t5pFKJ4ehY4lUtYDNFBr8pr0miXiiwJN30pDROZyKgQgWty7
 0BIw==
X-Google-Smtp-Source: AGHT+IHmfh0LsYZ7Em47S1T7SSAqne5lnP/bTdbLWlvNbeTp9DumRwgu3Y+muNgmJczPTkvBP/ebb2SH8oVr
X-Received: by 2002:a05:6214:2aac:b0:783:2157:5a34 with SMTP id
 6a1803df08f44-87b2f02ba73mr379762736d6.65.1760519095356; 
 Wed, 15 Oct 2025 02:04:55 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
 by smtp-relay.gmail.com with ESMTPS id
 6a1803df08f44-87c0129f706sm1750646d6.27.2025.10.15.02.04.53
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Oct 2025 02:04:54 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-782063922ceso8847411b3a.0
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760519092; x=1761123892; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gkRyulW4lfOVm4TeHnHm5SaaCDky+7PT5BGsz+PYxkw=;
 b=GbL3hNmceGUAtVFhYGs3IWQMai8pcd9zP2S9ged8BvA65l4/oMFyxbJR6KPQTl+cdC
 OvzfbUwpe0bxaA2BrnEg2RguEwPKAxCrM4ZT41jlE5eOmuqdg3nJjSjITDgCv4L4b5lb
 wiL4x5b1eL94LbEMDVMF4RK+R9wlDSFYuGs9I=
X-Received: by 2002:aa7:88d0:0:b0:770:fd32:f365 with SMTP id
 d2e1a72fcca58-79387929af6mr29883684b3a.25.1760519092082; 
 Wed, 15 Oct 2025 02:04:52 -0700 (PDT)
X-Received: by 2002:aa7:88d0:0:b0:770:fd32:f365 with SMTP id
 d2e1a72fcca58-79387929af6mr29883646b3a.25.1760519091427; 
 Wed, 15 Oct 2025 02:04:51 -0700 (PDT)
Received: from localhost.localdomain ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992bc12a8asm17832412b3a.34.2025.10.15.02.04.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Oct 2025 02:04:50 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Farah Smith <farah.smith@broadcom.com>,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
 Peter Spreadborough <peter.spreadborough@broadcom.com>
Subject: [PATCH v3 34/54] net/bnxt: fix adding udp_tunnel_port
Date: Wed, 15 Oct 2025 05:00:04 -0400
Message-Id: <20251015090024.32250-35-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251015090024.32250-1-manish.kurup@broadcom.com>
References: <20251009221129.28256-1-manish.kurup@broadcom.com>
 <20251015090024.32250-1-manish.kurup@broadcom.com>
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

