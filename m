Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB36CCF9EB
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 16:20:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3311840A70;
	Wed, 29 Oct 2025 17:20:42 +0100 (CET)
Received: from mail-oa1-f100.google.com (mail-oa1-f100.google.com
 [209.85.160.100])
 by mails.dpdk.org (Postfix) with ESMTP id AB1C540A70
 for <dev@dpdk.org>; Wed, 29 Oct 2025 17:20:40 +0100 (CET)
Received: by mail-oa1-f100.google.com with SMTP id
 586e51a60fabf-3c9975a3d6eso42574fac.2
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:20:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761754840; x=1762359640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TxPsVNdWDee7AzhiTv+7fNvKPbLFqYH7whN7uPHEBz4=;
 b=Wi5j5RXSh0M3hMgZzNvY7+BT7gGpO5C6VS81AQvs17TcKIeW5lJm9LBQsRGwt8aFwj
 qcySUW4WwoYdCmU4gOfagAOzFxTzpiMHzlUdxJcy4+TZ6lDod0jDu3TlvTi9x9QRhJXZ
 CgGUcftCiqBxh5y1pYCjOUq3nmKXQ3xCztZxtz/wUA+FRzKcvnp7S5beW1rYQo0xHM2Q
 fsdCEh27DTTdqsWKKRayrZ6ter+ZeJWyBuqJeC3m5Op2craMfgFS+sU2nqyzIBehx6hy
 SL1+NKfQpWIVn2fE4i6IODZJmAuaXfMhgEHjKaiQ6Khd3DzIci5G0ZV/JDEUuHR8JQb4
 XzDQ==
X-Gm-Message-State: AOJu0YxzwtsL6cJoJduTDVqBdZRsZ1eHu8x3v1R/KfXFIMeiNCc/gNm9
 1VphFPBZLvX3ZrmUac6OiSZ0HOMeVPtWYaT6wRM+do8OyrkwrKFrawHuQe7S4WyznhCZTJ9rMNo
 lNyjnOV0RP9XYhZvM4WiiMHVsnL2GLeUFccC7Kn9q5Ew1jONf/MJZAwLZJteNIuas9LfFeXl+09
 sUJRa56A/inh/RWBO0nlFr7z1hSVP6rbELEsGhnQRI7V40qXSKjkDz0XVneALbLnd/iqA6lQ==
X-Gm-Gg: ASbGncvaB5y+YEiJUMTlcrLfEwOTz0qSJrMyiM/fz01oNO6eaKOYk4cuTyb5+kG1jqG
 xG3L5YtIoCP02X/uo1E/UMWcLJyON92O4P5jtuY/s2xQe2qfJlJImm2yyu6xwkoSp1svic47I8Y
 ocRH4wf7yOvyVP6YvFX8Gsm6rhGngrRJtLxjEJcZweNDbEuxBeEHEFJbE4ifZfJw8uN73Kv4CQN
 YDdB7MeoWomPg5vuGczqNxegHGA+pc0XS73zJvpQv1AK/lDv0drOp323HGrYayqMunV4G/VOA1S
 1UkgfxOX1+L+qKDj2xErsER23YNrtnnBnjP9aKfMTT+1AwM8qpLMhWKDssRK1gcxcIc0tnBy3zP
 7rfUCBNrSHfOxQww9sJHjqXyuhyT7wgljF4gkQsW9nQaZCz+sLRQRdzqrYxhnfV4DmySiMzF9jR
 6gbs9Az0JHVNYKPmIMFEdbnmxdbRNHkCYXqufB
X-Google-Smtp-Source: AGHT+IEi2yVTBSljxzXfAyi1SgyKGtRrSylcGcECjARzPNxago/bVSNa7W/8cKTrR9ORy7ljpk/N3vs+hwlc
X-Received: by 2002:a05:6870:9724:b0:377:8166:9376 with SMTP id
 586e51a60fabf-3d746efdcfcmr1752589fac.28.1761754839880; 
 Wed, 29 Oct 2025 09:20:39 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-103.dlp.protect.broadcom.com. [144.49.247.103])
 by smtp-relay.gmail.com with ESMTPS id
 586e51a60fabf-3d1e21f2633sm1303224fac.2.2025.10.29.09.20.39
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 29 Oct 2025 09:20:39 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8a3c5e46a06so984610685a.1
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761754838; x=1762359638; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TxPsVNdWDee7AzhiTv+7fNvKPbLFqYH7whN7uPHEBz4=;
 b=foz65JYcBOKVmi/bW8WFYutNHrqXl0ngBPhiDudGsEERehoduBcC5IRy+AkH2pjd3z
 e3dLG06DziXlAMPF5qDVG0bWDQMtJfTXD2Vozwn9wCCXlTlLMWqz/92ZKtUHzqexBSLS
 XxEDNIyUtHXxcQ13rGJqmKbG0P5kq+ZaP7P8c=
X-Received: by 2002:a05:620a:4506:b0:8a7:2373:1c75 with SMTP id
 af79cd13be357-8a8eef6267fmr510941985a.49.1761754838602; 
 Wed, 29 Oct 2025 09:20:38 -0700 (PDT)
X-Received: by 2002:a05:620a:4506:b0:8a7:2373:1c75 with SMTP id
 af79cd13be357-8a8eef6267fmr510934885a.49.1761754838000; 
 Wed, 29 Oct 2025 09:20:38 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89f2421fba6sm1089026785a.4.2025.10.29.09.20.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 29 Oct 2025 09:20:37 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>,
 Ning Wang <ning-nw.wang@broadcom.com>,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>
Subject: [PATCH v5 39/57] net/bnxt: avoid iova range check when external
 memory is used
Date: Wed, 29 Oct 2025 12:06:54 -0400
Message-Id: <20251029160712.58519-40-manish.kurup@broadcom.com>
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

From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>

The function checks if the iova is in the valid range. But this check
is not relevant to external memory; avoid it when external memory is
in use.

Signed-off-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Ning Wang <ning-nw.wang@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
---
 drivers/net/bnxt/bnxt_txr.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_txr.c b/drivers/net/bnxt/bnxt_txr.c
index f88e214790..27758898b0 100644
--- a/drivers/net/bnxt/bnxt_txr.c
+++ b/drivers/net/bnxt/bnxt_txr.c
@@ -221,8 +221,9 @@ static int bnxt_invalid_mbuf(struct rte_mbuf *mbuf)
 	if (unlikely(rte_mbuf_check(mbuf, 1, &reason)))
 		return -EINVAL;
 
-	if (unlikely(mbuf->buf_iova < mbuf_size ||
-		     (mbuf->buf_iova != rte_mempool_virt2iova(mbuf) + mbuf_size)))
+	if (unlikely(!(mbuf->ol_flags & RTE_MBUF_F_EXTERNAL) &&
+		     (mbuf->buf_iova < mbuf_size ||
+		      (mbuf->buf_iova != rte_mempool_virt2iova(mbuf) + mbuf_size))))
 		return -EINVAL;
 
 	return 0;
-- 
2.39.5 (Apple Git-154)

