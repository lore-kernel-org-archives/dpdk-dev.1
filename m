Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC12CCD18E
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 09:08:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CE745410D4;
	Wed, 15 Oct 2025 11:05:45 +0200 (CEST)
Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com
 [209.85.215.225])
 by mails.dpdk.org (Postfix) with ESMTP id 1713D42789
 for <dev@dpdk.org>; Wed, 15 Oct 2025 11:05:44 +0200 (CEST)
Received: by mail-pg1-f225.google.com with SMTP id
 41be03b00d2f7-b49c1c130c9so4004775a12.0
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:05:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760519143; x=1761123943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZuLGH3yY0QftvblPy2/QYDcK1QBuOY3rdtImcr+3JJY=;
 b=GO0S51dViyXdUAU8wNe04yvek9W7EbYVExofQtvWHYpCNdS09ctUuNcPECInp5JsyS
 td3ou045tWYVRNr3qSC9aCAzIF6ow46Kg2tGbEE4lrp+CuBycOm8anVDoqk7/Xks8AyJ
 eYGQSTtOkbyRcia3fDESMBn6eaJSHdlT3FbnXrP9v5G1YZftIU1Zfch468NvfBYZMnCI
 Y3+/srE/2153cAzBOdTzD6K8of2PdcpwTYEPYEUoPa/ioGNiARH1rcPrZA6utyDYET2X
 HnGnMYRjT8G0dnMzweZkBK+MKezBJVEXkcObBwoXG8fZWatm5vX9x3PltgFHdmhiFAUC
 BU0g==
X-Gm-Message-State: AOJu0Yxevcq0u767SuFCYsZYyuOJfQTqNga74QhFADdFWu+9bKw8oPRL
 d4au5b3BcP/J2k0Rja82ZQmiePdXKSfqPpsYHjjG875hrAM5vyWOUKB5ymdXJrD+r5xaMuL32BQ
 QS7dT6l7cmuOAZg1kx3ZBBwNAaSUAdKa543luJHeomsEvSNWwWoemdGIANX7YQP+RzuFd8+2Ty3
 lZmp+jQ7We06fBs43QtChyhaihsoOFlDjevV0mVwkO5KlWtjhTJsDXycRZDAeBvqYIgB2TRg==
X-Gm-Gg: ASbGnctosxjW5ilo+YCj49hNI30ofoYkjyztRbq3WKE1YZDK/JEVFSNxzXcbchufJHh
 wDtmvoZx2/VJZTZk3IsrYwLv33OQGpX4oJFhDaQQlQSAdNmzNdmBSxRQb7+cM9ZDjg+00Tf1h1E
 eUmgEL1QGl7sG6JLJtxoyMdWPktrQLI4+WhQIv3crhJOoXfqIwGbACnEZGHVb+YAGyJ4YbekQxO
 3z0NtksGNUYTRkohTeeoYzN/c4WXLEVBBDY+ZE/DOYqob2RYdXDKEo5w1GK29RLst+9rLqLwNFg
 cgx6d6onOUreWu7LITjW65Ftu9XgGlqDFQ4KwuT8Co4NbZx02HvxTfMwo7PjixJLRZIxOIUp1ZI
 /nlXvC78q2WP7XFehyB8xKYQBwTtpQEc+sF0DURBDIASIVbgJHbrSnDaUKG5y1YKiBqQoxCvGOO
 ak2cDsEA1vbdC/T3YHS0wqDvw80NUOcgWEzqaz
X-Google-Smtp-Source: AGHT+IHXIQtDRwYSDTqfyGckOe3LYBRBkL/DvUvxVF0so2u9ZBbdSVqf7+jFuvQUh4WxdjP8Ngt7kxqK3y7I
X-Received: by 2002:a17:902:e54b:b0:258:c13d:9b1a with SMTP id
 d9443c01a7336-290272dcdaemr376776215ad.41.1760519143165; 
 Wed, 15 Oct 2025 02:05:43 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-29034f5e7d7sm15140725ad.63.2025.10.15.02.05.42
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Oct 2025 02:05:43 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-7810912fc31so9397165b3a.3
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760519141; x=1761123941; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZuLGH3yY0QftvblPy2/QYDcK1QBuOY3rdtImcr+3JJY=;
 b=g/Lt6EGULWZSvS8dWUmkow2gMkNkYrZMVr0y+etcC7PWIROP6gxByzSoNIUU9MAJhK
 6bjYs1Cm7XZ8B7Zj0tCkTfaR+KNzdUQpZW6iui+Q4CTpmBNqLpMjm269dVD1xeX+O5vu
 Dyfbc64NaYuPN5hSsbqh/Lvc7cWI1n0sy4HLU=
X-Received: by 2002:a05:6a00:3d54:b0:781:be:277e with SMTP id
 d2e1a72fcca58-7938513618fmr30776531b3a.4.1760519141050; 
 Wed, 15 Oct 2025 02:05:41 -0700 (PDT)
X-Received: by 2002:a05:6a00:3d54:b0:781:be:277e with SMTP id
 d2e1a72fcca58-7938513618fmr30776497b3a.4.1760519140382; 
 Wed, 15 Oct 2025 02:05:40 -0700 (PDT)
Received: from localhost.localdomain ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992bc12a8asm17832412b3a.34.2025.10.15.02.05.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Oct 2025 02:05:39 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Shuanglin Wang <shuanglin.wang@broadcom.com>
Subject: [PATCH v3 53/54] net/bnxt: add support for truflow promiscuous mode
Date: Wed, 15 Oct 2025 05:00:23 -0400
Message-Id: <20251015090024.32250-54-manish.kurup@broadcom.com>
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

From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>

The truflow application support promiscuous mode to enable
or disable receiving the packets with unknown destination mac addresses.

Signed-off-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Reviewed-by: Shuanglin Wang <shuanglin.wang@broadcom.com>
---
 drivers/net/bnxt/bnxt_ethdev.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.c
index 854c8b7371..f37136c8f4 100644
--- a/drivers/net/bnxt/bnxt_ethdev.c
+++ b/drivers/net/bnxt/bnxt_ethdev.c
@@ -2161,9 +2161,15 @@ static int bnxt_promiscuous_enable_op(struct rte_eth_dev *eth_dev)
 	old_flags = vnic->flags;
 	vnic->flags |= BNXT_VNIC_INFO_PROMISC;
 	rc = bnxt_hwrm_cfa_l2_set_rx_mask(bp, vnic, 0, NULL);
-	if (rc != 0)
+	if (rc != 0) {
 		vnic->flags = old_flags;
-
+		return rc;
+	}
+	rc = bnxt_ulp_promisc_mode_set(bp, 1);
+	if (rc != 0) {
+		vnic->flags = old_flags;
+		rc = bnxt_hwrm_cfa_l2_set_rx_mask(bp, vnic, 0, NULL);
+	}
 	return rc;
 }
 
@@ -2185,6 +2191,11 @@ static int bnxt_promiscuous_disable_op(struct rte_eth_dev *eth_dev)
 	if (bp->vnic_info == NULL)
 		return 0;
 
+	if (bnxt_ulp_promisc_mode_set(bp, 0)) {
+		PMD_DRV_LOG_LINE(ERR, "Unable to disable promiscuous mode");
+		return -EINVAL;
+	}
+
 	vnic = bnxt_get_default_vnic(bp);
 
 	old_flags = vnic->flags;
-- 
2.39.5 (Apple Git-154)

