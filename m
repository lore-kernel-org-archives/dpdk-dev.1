Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D87EACAC5B9
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 07:12:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 98C5240B8F;
	Tue, 30 Sep 2025 09:06:36 +0200 (CEST)
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com
 [209.85.216.98]) by mails.dpdk.org (Postfix) with ESMTP id 92203402A2
 for <dev@dpdk.org>; Tue, 30 Sep 2025 02:37:52 +0200 (CEST)
Received: by mail-pj1-f98.google.com with SMTP id
 98e67ed59e1d1-32eb45ab7a0so5973732a91.0
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:37:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759192672; x=1759797472;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZuLGH3yY0QftvblPy2/QYDcK1QBuOY3rdtImcr+3JJY=;
 b=sGGsAfEoHZWFhn4h8i6jQKYjDp1vnBaBk0y61rdJpArdPkV3nmrx+T11IIOEG5gh4J
 v5DaSz72CkZ+dtXFTLCZrTh2IHNRZ76/4oyk01tFTRmLXxQEesJdtaccL4I9r9nO8XvK
 TnCvbsQINXjQvrQN9xOAkPEptf+umBzY7CGEGy32BAzL/LSMTZf00WReTRFbNckxhe9X
 T7JvaTtdveGAAQEQo8UIlL3Gs3+99Lw2xEKTjWmOEABmnSRVhmw08sNf50pwrFQVqUuC
 0kX/8qFmNOAeDjeUOULyvphBOKbhEN6yd6C2NL0KbGbIe/e3qfPVuubHP02B1ekrHCi+
 2vBQ==
X-Gm-Message-State: AOJu0YyAnrfpyMImrbuATgGsuMG7BPQARr/W7I7KopNrmOnBqbxjggmB
 Ut1m0pTXUqTWmIIVytZ7JSG08v1E77Mp+w/oJn28kAybfVPvAYUYrWKGWbklyr/WZK2gBh2J9Vk
 0piIKMgKLFte7hR2no0fzsy4RClRtQAM9u4/UpLL1fMLoyHpLN4Qag4TpNFzGG/2Jt50syzoXGx
 rVaxvxGDc2PDsG9gleuvPVIqSoScxDH94Y+csGpRNIzq2kD1zB5f66vYdqdwNMLMMhUjPVPw==
X-Gm-Gg: ASbGncumXzUVsCzvU/k5cRabAoQi0DacXG8TxEO8wJnc0CRmAPVyOdd62p9xh8GRX7G
 XHZ2AI2+ZGKadCNJTTS9hLLiWnpROAvDgHcPq3+ws5KeAkbOVbeOwIdY/+yQ2RmsodBCbmjq5vS
 CUaRoiAXwiIeo8/8Qf6LUmGqsNnyezQXngBw/k999HZmXvyTGejLqccnlgN5yMdS1uz5LplN4dw
 WsUr6JRDT1mEYzadUP9N41pmMdyEqHCQ1x0McAiFMH16tc//LQPVuO8hAsq1fTmgn+e9SdRTwrL
 zGfV3bcxrz11awLEkCMmvDhrYbsfWhWMRuBPsOAhP0wuIfhVpXxdZdzQ+TwOGMjKEYo/Z+sJkG/
 3QahfqZAmg0N3CUgzK5YCA/WnDfsl/E1t0ie+KfB88sOpdtC8mhb700M0iUtDWGFn0/aARUib/2
 byIj3EZQo=
X-Google-Smtp-Source: AGHT+IG+RSzuQdVIakO0tUcBij7Foa4DTcsDaSc9d7TNaOud7RoIzof29xEZASCbWOHEu+lFFJefgle9sIyL
X-Received: by 2002:a17:90a:d44c:b0:32e:1188:147f with SMTP id
 98e67ed59e1d1-3342a2c298dmr19994820a91.19.1759192671758; 
 Mon, 29 Sep 2025 17:37:51 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-100.dlp.protect.broadcom.com. [144.49.247.100])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3341bdf72d8sm1035898a91.3.2025.09.29.17.37.51
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Sep 2025 17:37:51 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b56ae0c8226so3642295a12.2
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1759192669; x=1759797469; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZuLGH3yY0QftvblPy2/QYDcK1QBuOY3rdtImcr+3JJY=;
 b=IuxXVD7K+w+COr5Ta+oDWo7ksdOElVnPs9e/ADyJ4CfstfcwJa4b+0B7Tt3VG8LcAu
 AcLAXhYh0+gAKeCNUuqfL5/fMkCj1Ij0haE/yuTNITEy65T9miCJczEkJZSbS+R/dut1
 bfG1KXW4DSTw+USMtvFm3sZtIhH8n3rtvM5+4=
X-Received: by 2002:a05:6a20:7343:b0:2cc:692a:3a30 with SMTP id
 adf61e73a8af0-2e7c19d5a66mr21530740637.13.1759192669585; 
 Mon, 29 Sep 2025 17:37:49 -0700 (PDT)
X-Received: by 2002:a05:6a20:7343:b0:2cc:692a:3a30 with SMTP id
 adf61e73a8af0-2e7c19d5a66mr21530714637.13.1759192669108; 
 Mon, 29 Sep 2025 17:37:49 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c53bb97dsm12234825a12.9.2025.09.29.17.37.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 17:37:48 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Shuanglin Wang <shuanglin.wang@broadcom.com>
Subject: [PATCH 53/54] net/bnxt: add support for truflow promiscuous mode
Date: Mon, 29 Sep 2025 20:36:03 -0400
Message-Id: <20250930003604.87108-54-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250930003604.87108-1-manish.kurup@broadcom.com>
References: <20250930003604.87108-1-manish.kurup@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Mailman-Approved-At: Tue, 30 Sep 2025 09:05:07 +0200
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

