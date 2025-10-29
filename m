Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B727FCCF9F0
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 16:21:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 17B5240A70;
	Wed, 29 Oct 2025 17:21:43 +0100 (CET)
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com
 [209.85.216.98]) by mails.dpdk.org (Postfix) with ESMTP id 7B03140A6B
 for <dev@dpdk.org>; Wed, 29 Oct 2025 17:21:34 +0100 (CET)
Received: by mail-pj1-f98.google.com with SMTP id
 98e67ed59e1d1-339d7c403b6so93157a91.2
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:21:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761754893; x=1762359693;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m6G2w21fx7JlJx8u8ixxBwrsLjraONRuCRmnm54Ow/0=;
 b=Jgph4+WRuKly2j7hlNTOSk6BmscNb8ZyCAgtbkCRYyzpdcURfp6V61UPz3i5/7LGSN
 Zj1vrXyY2IxhC06bvSee8hFQNaqTUlwpzEr0SWDLNINtF8VU2IIkZl8G8BN9HRTBXl+l
 TiShQ9Nyf/KyRs/moNB8Drfb5JpHpCgrLcZtVpdL0lw9PAX9bW3kkBIkOsKwT734QCY/
 qA2z9dNEU7tVZXsOAL3Menoh3BJADqOZ7Sj67LS8Aju+aOfF7agZh5+OlTb+XFRxV1pY
 js3J8Bs/NAbAMbeTutsD+ckInWjKKikUZxWqdtY80kpO2d8H2i+n7O6KfDJyrW9kcgVm
 XRjg==
X-Gm-Message-State: AOJu0YxYpRcccpaldNzKy7KwiIfz5KCO9fsqMixrUlBC37iUWPpgQeiv
 6SU8xvoE6JJ1Pc13TpeXjcqr4QozgY0kDbc6UbESQPKW8yyoLGfL/pFJ7xvUe6XKKLuybFZUpbk
 9y81Krc+4gigKZuhkt074NMMMSBTlhuRHL7CTvbM1KKrJrW+SzUkfXA+tbd0FGsp6a2Kz6LcauI
 JyyGWXuxpw6mk+E8mo8hV4WkOvAOnT5BRDRcE7pgkjcCoflNK/6gbb1pzm2yyVQsRqxV1f+A==
X-Gm-Gg: ASbGncuLzutxEzwLgO772GaQ8nXKDNpkpcCKTv6ZaTPXE2Pykr8yaJe7r6u1M9C3IJi
 OsgQMT9eC+UuTwxPpHn0eC6WQhupjc/rdwITjWxxfCQzEpZ5nUwSIWVgoRUXaeFBGsXGrY14T7d
 t1q90eI6jNHe1EtXItFAPIJ263TIRDZ+yanMUfsriSdU3jnIMSwEk3U/ef7PbWs6lV6o4FCtdPU
 aFre7jyAljX3XyVoxCX35p8KpR+0GPYJXLC+vvJp9h5z3A6zipRtPwELaPCgdPtBY+JsmbtwTVk
 6WU5T+YrZHoifQd//fEeo9rsXBfwQS0Qj3A6/WQ16qwDpoBv/L80VS3E2qqBKxrG2DQvDuU7idN
 86wmnU53M0aY2CCzlBs4LwcyzObn3HIkkEyrS+vR/9qX3CL9ovcVwfFAzOU7xcyfemDJFoil0Oq
 FnsmEvveQFLo+35DrqcWrWaFHDcEcQOUqHWg==
X-Google-Smtp-Source: AGHT+IFghedqeDT5ZBAVg03ClNcvuW1qYI5ai9640lgb+nUocF2p6hB6voBF0Jbs3yDOqGLVutyYWGQTo1J8
X-Received: by 2002:a17:902:ea08:b0:250:643e:c947 with SMTP id
 d9443c01a7336-294deec67femr43569195ad.28.1761754893491; 
 Wed, 29 Oct 2025 09:21:33 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-29498d40e05sm14806185ad.44.2025.10.29.09.21.33
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 29 Oct 2025 09:21:33 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8a3f828c9bdso2273085a.0
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761754892; x=1762359692; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m6G2w21fx7JlJx8u8ixxBwrsLjraONRuCRmnm54Ow/0=;
 b=G/0hcbw/Rk+5HSXYy2CCkrc1QP63EGzQ5Wne75o8SQmVsF7oGXYW/ffnNl9ePIbX0V
 BYMaXLtLrzQWp9alFrewxuPW9zJ0NlU7t4TViJzxLk2W82FKbpjnQJpqyqIbB/l1lRvv
 Y8oLXZOdK5TnnsskdsdrPzpDccJpkCEUXk7vc=
X-Received: by 2002:a05:620a:1a1f:b0:85c:3bcf:e843 with SMTP id
 af79cd13be357-8a8eef61059mr453956085a.43.1761754891770; 
 Wed, 29 Oct 2025 09:21:31 -0700 (PDT)
X-Received: by 2002:a05:620a:1a1f:b0:85c:3bcf:e843 with SMTP id
 af79cd13be357-8a8eef61059mr453950185a.43.1761754891222; 
 Wed, 29 Oct 2025 09:21:31 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89f2421fba6sm1089026785a.4.2025.10.29.09.21.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 29 Oct 2025 09:21:30 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH v5 43/57] net/bnxt: Skip stats collection when rx queue
 inactive
Date: Wed, 29 Oct 2025 12:06:58 -0400
Message-Id: <20251029160712.58519-44-manish.kurup@broadcom.com>
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

When rx queue is not started and the stats context id is not
allocated then skip the stats collection.

Signed-off-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
 drivers/net/bnxt/bnxt_stats.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/bnxt/bnxt_stats.c b/drivers/net/bnxt/bnxt_stats.c
index 53f5613eb3..3ed1dc8101 100644
--- a/drivers/net/bnxt/bnxt_stats.c
+++ b/drivers/net/bnxt/bnxt_stats.c
@@ -667,6 +667,9 @@ static int bnxt_stats_get_ext(struct rte_eth_dev *eth_dev,
 		if (!rxq->rx_started)
 			continue;
 
+		if (cpr->hw_stats_ctx_id == HWRM_NA_SIGNATURE)
+			continue;
+
 		rc = bnxt_hwrm_ring_stats_ext(bp, cpr->hw_stats_ctx_id, i,
 					      &ring_stats, true);
 		if (unlikely(rc))
@@ -728,6 +731,8 @@ int bnxt_stats_get_op(struct rte_eth_dev *eth_dev,
 
 		if (!rxq->rx_started)
 			continue;
+		if (cpr->hw_stats_ctx_id == HWRM_NA_SIGNATURE)
+			continue;
 
 		rc = bnxt_hwrm_ring_stats(bp, cpr->hw_stats_ctx_id, i,
 					  &ring_stats, true);
-- 
2.39.5 (Apple Git-154)

