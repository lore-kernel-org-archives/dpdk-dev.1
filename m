Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8814CAC5B8
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 07:10:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2216340EDF;
	Tue, 30 Sep 2025 09:06:19 +0200 (CEST)
Received: from mail-io1-f100.google.com (mail-io1-f100.google.com
 [209.85.166.100])
 by mails.dpdk.org (Postfix) with ESMTP id A50D9402A2
 for <dev@dpdk.org>; Tue, 30 Sep 2025 02:37:37 +0200 (CEST)
Received: by mail-io1-f100.google.com with SMTP id
 ca18e2360f4ac-91f6ccdbfc8so110615439f.1
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:37:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759192657; x=1759797457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7O0q2HyM4GTrzmKAh1MoIZWWaXw+xyJ0JG4jLWcsGB4=;
 b=Nr/Q8+aYYWYVN9Ngt8Kp3rrJT7yjWJPDThuZ/AbPBdu3cHgPBhIomrHZQ4GJyjz8C1
 9DxPqE3zD/js2JoYp0PiLdM/KFymgTIpOayXSukwJLokRo1Ns7ksy9qSYbxM9xvY8oPB
 BZd5i1VleQVT2uOC/qSFc/30Q3dRBpAZYO3IMtZdegFlPqvAgfQuYexYzUKBienQyzmj
 izCfUcidRmwrCRs6CDjFzAhU75zP8K7uWKpTW470UpXY8RhF7QTjLILSWImoVRHc0YnB
 NTR3U7XLkxyLohDO02z7AK2tHhsABplPm1+i6R7qZYreW573PNoLM1iEPY0JD3jJfK26
 OfTA==
X-Gm-Message-State: AOJu0YyhheiKwrQwUK75WZ6PKdSie9xhREjikTnQGZVsm1z/82bkSIyv
 UCCrwl9dMCw7nxHcOPfRDS7bkDlWwncqj9OCwdk5sELGVVAMSvhPeUJp0tAKkfadnLAb4vx1okm
 AeiLqqfEsx0v5yx9P+p10EEscqoe0i+vnTp2xJm8n8QvWSCdfHkT4iIVf50UGjGfUCrZombnmHM
 1m1wH/0zHtWxCQzddUOyoiEjV3bmzxYRgXwAul6SXFno1uK2ns1rCJYh5M3a3R2zegs1XHaQ==
X-Gm-Gg: ASbGncv2E9MHyxOrgFxhdiHzrYMTEUfTZKE0wfX95Ltq4+rYw62hW1kzBLeSof6OL8Q
 7a76lNA7tAQ0RuRtE2mSY4aN/CkRz0Ssk0wOAIqvRUSg689121fuDWyO6pC/UQE0gxHN4GT8Bca
 zMfcPW+sUEvrsbhUDnEEJgUtYepCqcSgaO9UoaOAlv72wWGYj+ejeJL0Iq8Rx4sJFI1/vSShnoZ
 A2FwhR8Qz+EaBy6HZuPJDuvGzXiSy5YUALWz/MocH5gSRSNB0cOZZQjeTRsJ7FHTS4IYttKSqe0
 /mvTHYYRuxbfdtsFB0P+kDB1oQVcbZMr/g2AXdMRtuEgrehtX9g1nvBiNMHe29xuKpKsJRO0RdK
 m6O8E52UhkLzJ+IrHvledrXk9f4J0vCLbZzKbc0eVESjAzNZKM/yIm4vrliXuaxla0JHrm0m4Eh
 5zQg==
X-Google-Smtp-Source: AGHT+IEcnq5kvEOcrJqNtMLm38zuiX0aMHCaXLqen1t/Rv+lH6Ka/TXE/Gqrh9lhwGRaNEadTF4sZhOxwYgA
X-Received: by 2002:a05:6602:3401:b0:925:821c:437c with SMTP id
 ca18e2360f4ac-925821c4697mr817505639f.0.1759192656910; 
 Mon, 29 Sep 2025 17:37:36 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
 by smtp-relay.gmail.com with ESMTPS id
 ca18e2360f4ac-903f900eb7fsm47675039f.3.2025.09.29.17.37.35
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Sep 2025 17:37:36 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-32df881dce2so5520181a91.2
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1759192654; x=1759797454; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7O0q2HyM4GTrzmKAh1MoIZWWaXw+xyJ0JG4jLWcsGB4=;
 b=gdnC1s47IJGlig0Pk7+LXVKw03ESd6oA2qWEjXq0SQEEETI9npvt2x701NAf8BsV3+
 cHb6SqQTy5NpjthAUt4NLM2bcN0pWIQLvXX5LujwjTdKsuEEvvZ/cLZJef6S1692Bw1x
 R5poP/3deh/YDVpmNTL8dicikIe8i9sfvcHbY=
X-Received: by 2002:a17:90b:380f:b0:329:e703:d00b with SMTP id
 98e67ed59e1d1-3342a2f8adfmr19117840a91.19.1759192654171; 
 Mon, 29 Sep 2025 17:37:34 -0700 (PDT)
X-Received: by 2002:a17:90b:380f:b0:329:e703:d00b with SMTP id
 98e67ed59e1d1-3342a2f8adfmr19117807a91.19.1759192653574; 
 Mon, 29 Sep 2025 17:37:33 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c53bb97dsm12234825a12.9.2025.09.29.17.37.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 17:37:33 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>,
 Peter Spreadborough <peter.spreadborough@broadcom.com>,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH 42/54] net/bnxt: packet drop after port stop and start
Date: Mon, 29 Sep 2025 20:35:52 -0400
Message-Id: <20250930003604.87108-43-manish.kurup@broadcom.com>
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

The packets are getting dropped if some of the queues are configured
to stop and if the bnxt driver is reset due to port stop all and
port start all then when the bnxt driver comes up, the driver is
overwriting the queue configuration to operationally started
instead of stopping the queues that was previously stopped. The
stopped queues were getting added to the rss context resulting in
the packet drops.

Added a fix to address this issue, the rxq structure is not cleared
during the stop and start process and retains the context, that flag
is used to set the queue state. Thus stopped queues shall not be added
to the rss context on recovery from a stop and start. The queues that
were configured to be stopped have to explicitly started to see
traffic on those queues.

Signed-off-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Peter Spreadborough <peter.spreadborough@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
---
 drivers/net/bnxt/bnxt_ethdev.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.c
index efecbba2c3..c92e335a51 100644
--- a/drivers/net/bnxt/bnxt_ethdev.c
+++ b/drivers/net/bnxt/bnxt_ethdev.c
@@ -925,11 +925,13 @@ static int bnxt_start_nic(struct bnxt *bp)
 	for (j = 0; j < bp->rx_nr_rings; j++) {
 		struct bnxt_rx_queue *rxq = bp->rx_queues[j];
 
+		__rte_assume(j < RTE_MAX_QUEUES_PER_PORT);
+		/* If not deferred start then change only the state of the */
+		/* queue based on the queue rx_started flag */
 		if (!rxq->rx_deferred_start) {
-			__rte_assume(j < RTE_MAX_QUEUES_PER_PORT);
-			bp->eth_dev->data->rx_queue_state[j] =
+			if (rxq->rx_started)
+				bp->eth_dev->data->rx_queue_state[j] =
 				RTE_ETH_QUEUE_STATE_STARTED;
-			rxq->rx_started = true;
 		}
 	}
 
-- 
2.39.5 (Apple Git-154)

