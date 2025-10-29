Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864FDCCF9EB
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 16:21:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B9E2040B99;
	Wed, 29 Oct 2025 17:21:51 +0100 (CET)
Received: from mail-qv1-f97.google.com (mail-qv1-f97.google.com
 [209.85.219.97]) by mails.dpdk.org (Postfix) with ESMTP id CDD1640B9D
 for <dev@dpdk.org>; Wed, 29 Oct 2025 17:21:50 +0100 (CET)
Received: by mail-qv1-f97.google.com with SMTP id
 6a1803df08f44-87c217f4aaaso1526666d6.0
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:21:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761754910; x=1762359710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Saz+LUnU2NUljE7rSnTwk7kDpDsiFFBwF+PqT9tABKw=;
 b=vW/3WcoPT2oEvX7kiaG6lbm7Akr0LsfupNfOZxC/XITxmEtqU65qsNCa3AfQZybWU0
 cXXmygXn6zw8bVYiOQGI6r2G9nCayjoQCtYXvIL8b8UXbdZhqwzsdi0JQ3Jn3yfYEkuX
 WzebVD8YSM8xOXnw1NAZvUb0XRkAoMy4PsGdM2GH7g8lpoWpkxjwxD8HFZTp1GBLGux3
 YIhPyP0cyxXIDTMnxBkZLakb2+DPwI0x+jBSKGxbyl2pmSQo5bugCL2xSnmvd/9VwQaC
 zDqHumDIPv6I8omQ20CEEemOH2dOB8xOfwdhDVV54ZZJP1HR0BrvIHVKlXDtneSLNkS1
 9zYA==
X-Gm-Message-State: AOJu0Yz4BVLc/5aSrkjQux46bjBL3q9z9HMQuh9XaiL2sVJeEd2qc9rm
 MF6+aouGsAhX3s2+u9EALR57X+vV74bkG4DS6F2vOFC8+5k9dz03rv/OgeIqGgppVxIaDS2Ea7w
 5hSq1ogZKEOqm4V3mkG/afmDYaa5Mif42o5ePm484k3VvKrNZhfN7eLfMHU4DoBvhxtvax+dwQN
 8jC923g/CVzsnHxz43KP0BBP3NWZ3RhTwiYrfZs8eNkxlQPfQ/vE4NHEpcUTB+iPP6KHqRSg==
X-Gm-Gg: ASbGncuAl6xaS+TqR9PXnPnyDIt02WSnxw/AfEAxCuxJ92iYk6mp4gZ3iTARI7YxrjF
 wI7qYpTiM0F/UTzblZ641exNlOl7+NrHhf15AtHz1CWr2k6ghATxWD7/LkgRvakZswSWqjOR56V
 e/8ZSAn/2ntbeBVZ+1Au3u9JD6R0O81AFyIzeQtGtA7H+QnG+69YKlzC4FvGjoU81qDl/NYkpgd
 BojDUTC/YCfqYrue1w06GvxGjpap4wOeL7mbOQMQIY/TiYetJLU6sUVgvjw4SkBcfQwclzyjDPm
 tMRbOw39lVhAErhOKOdS11WH9yL0BbdLJgjzeiMLUEyzomZtPaaYtW/Mc7j+emYbq+O6cBAH4yo
 QwO/LkxWOEkVq5uRF8GuYdUsm/fo64oGkxc99jhAKp0jnSWvMOdmbSPL3hXDWeczgJoP8uMLEbO
 FGGL9s+l1np1WUhN2DtGP8mY4d7UglOAg=
X-Google-Smtp-Source: AGHT+IGu43W2qjziIt/UejRslbzX1JsHLmlK0m6NxB2+zYCddeb0NIwH68KPm9Ue4vYKytHd6x0B3NQREX/T
X-Received: by 2002:a05:6214:519b:b0:87c:2938:c357 with SMTP id
 6a1803df08f44-8801b1ba996mr986746d6.29.1761754910035; 
 Wed, 29 Oct 2025 09:21:50 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
 by smtp-relay.gmail.com with ESMTPS id
 6a1803df08f44-87fc48db352sm14548956d6.1.2025.10.29.09.21.49
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 29 Oct 2025 09:21:50 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8a96b2264a8so209585985a.2
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761754909; x=1762359709; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Saz+LUnU2NUljE7rSnTwk7kDpDsiFFBwF+PqT9tABKw=;
 b=F5YD+EHejXsKCtG5E1W1CVeC5vuDMvMN69NFN6aQXxB5IxCspiOjZQvr9oBM/2P4oF
 BSWt5wR30PZz1BCbml6p8cFqmLNPEg5sLSxCpkFFpRBhxGmOtnDG0EDDJN+JR/CkzLy9
 e98v3FjMjC7OiiYKveDZQsbR74GY6a5PmLy3Q=
X-Received: by 2002:a05:620a:1987:b0:8a1:b435:9845 with SMTP id
 af79cd13be357-8aa2e43bc25mr22525685a.76.1761754908958; 
 Wed, 29 Oct 2025 09:21:48 -0700 (PDT)
X-Received: by 2002:a05:620a:1987:b0:8a1:b435:9845 with SMTP id
 af79cd13be357-8aa2e43bc25mr22518885a.76.1761754908240; 
 Wed, 29 Oct 2025 09:21:48 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89f2421fba6sm1089026785a.4.2025.10.29.09.21.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 29 Oct 2025 09:21:47 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>,
 Peter Spreadborough <peter.spreadborough@broadcom.com>,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH v5 45/57] net/bnxt: packet drop after port stop and start
Date: Wed, 29 Oct 2025 12:07:00 -0400
Message-Id: <20251029160712.58519-46-manish.kurup@broadcom.com>
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
index 4ed2bf2a1a..50bc0f1f9e 100644
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

