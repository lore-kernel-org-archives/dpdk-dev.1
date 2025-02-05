Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E721C02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 16:25:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA6F34066C;
	Wed,  5 Feb 2025 17:25:13 +0100 (CET)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45]) by mails.dpdk.org (Postfix) with ESMTP id CE9EA4060F
 for <dev@dpdk.org>; Wed,  5 Feb 2025 17:25:07 +0100 (CET)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-2f833af7a09so9457506a91.2
 for <dev@dpdk.org>; Wed, 05 Feb 2025 08:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1738772707;
 x=1739377507; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fnT/3pOH6Z4FzBwUSMIczea55Qnff60OXjfwMyNHJNg=;
 b=Lj9nLe4XZMNsVVpL9ygD6syePFp/pB4XSgBULHbB3hLdHS06Mu5fi4jZT5A8127/aH
 FFA2bgaQAt1OgMGqfy+sIzqGkOI6VtQ6WfzfZtA/eFg/dkpBZZrNDQsc/g+GkyDIdEd1
 RNEhuvEn/Qhdi67qj9flmWACMprCEhaPFqNhelIC3TF/V4mrcTdALL3QqC+Z+3TFweCS
 T0wBZfrzXgq0N6OyfN0NxgUmYRtm0YX5fzeVlIVFvJ8vDxcVTFZ1zUKywdI8nhP8v4xa
 fl5DelW/6QvcQ3r5JR2/5MleuNiMj0KpIIvDLPkZpWMwp/n7s2E4P6EkfmxYxcZhOsoZ
 Xxvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738772707; x=1739377507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fnT/3pOH6Z4FzBwUSMIczea55Qnff60OXjfwMyNHJNg=;
 b=nJhZRZDIBORTwVwVUZPIuKTBj+OTPY5Djk1xtasCndIgdzoOwKr7kEILcH4oejzLpm
 HcSkY5ozoi94yEZNS+/VvFI9JMh6a/P1Yzwd4dtdFTzXNPEYVamS+qmUOQVs+52Xk7gS
 Hw4Z8CiDm+PzUw9AUPd3hMDXIIt9E6fhDMPmEQmwOk3tPs5DHwhgEpMt9ARuPyup6Frq
 Bq1dHsg5lvKddRBOP/ZhHrRkMzxXH40SlEnNw1zsSmKnZ6Hy1vtn5t3kMgEmxmyIsaxf
 /+AcqmSspfSg7vy0sfynswbFCqK/ZJALp1xjAC9ruhT8uJchhaGM/VTCwIefFYFIEZxw
 o34A==
X-Gm-Message-State: AOJu0YwWklW8UHdXqEfN8HDvA76j3+j5wkjNYipzLg7CXXzyPkr2J3jL
 XqtuDQ9mlfXYNofAsoiR0NcpMPMzFu1XCqu3VJ6RwWlRuoXF5zHcagwqqG/RnicJkXlhkrrCBGS
 4
X-Gm-Gg: ASbGncuwJqSQmTZtX2MCQxW111/22lHwGuKRAh32iJmkKjNpHxeVbdCtrJK14cdCCYJ
 Y++YpGyVh8NMnLws05DlT3T5Lc/Uu+xpmwNQ/CldBWzE4/7tmX+/oiVppaajhO3q0DNUuLUWLtd
 3dIOQ7iHyMmvBh6uVDoM9xMRr7nW6V4RXceMCfe7L4S0eO5f2riNz1KF1oRXrNnjWgDOXZA42OX
 VcawkLIkhOMrd63jPXE5BcR82TMwNzVuqqZfLjhrxemSQKDtUTOn5TPV9gKFYHMXy+UjpVJ7clw
 EhZue4t4NgYnDL0QwRW//mxJm2q6Jv2oRtqCk+CwPPZTkisvVQkLbhVYGKG+ITZIcY+7
X-Google-Smtp-Source: AGHT+IEtZGHobkFh85Pvb++64mf1Ek9QGUTIl7Pbk9E9IZWqJzfvRDQGuUEKvJldV8O2W2sFGxvD9w==
X-Received: by 2002:a17:90b:1fc7:b0:2ee:693e:ed7c with SMTP id
 98e67ed59e1d1-2f9e0868531mr6197656a91.33.1738772706969; 
 Wed, 05 Feb 2025 08:25:06 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f9c314b64fsm2138965a91.1.2025.02.05.08.25.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 08:25:06 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Kirill Rybalchenko <kirill.rybalchenko@intel.com>
Subject: [PATCH v3 08/19] examples/ptpclient: replace rte_memcpy with
 assignment
Date: Wed,  5 Feb 2025 08:23:09 -0800
Message-ID: <20250205162448.161161-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250205162448.161161-1-stephen@networkplumber.org>
References: <20241115060738.313190-1-stephen@networkplumber.org>
 <20250205162448.161161-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Don't use rte_memcpy() when not necessary. Structure assignment
is as fast and type safe.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 examples/ptpclient/ptpclient.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/examples/ptpclient/ptpclient.c b/examples/ptpclient/ptpclient.c
index def8de29ff..27d06dd91d 100644
--- a/examples/ptpclient/ptpclient.c
+++ b/examples/ptpclient/ptpclient.c
@@ -363,9 +363,7 @@ parse_sync(struct ptpv2_time_receiver_ordinary *ptp_data, uint16_t rx_tstamp_idx
 	ptp_data->seqID_SYNC = rte_be_to_cpu_16(ptp_hdr->seq_id);
 
 	if (ptp_data->ptpset == 0) {
-		rte_memcpy(&ptp_data->transmitter_clock_id,
-				&ptp_hdr->source_port_id.clock_id,
-				sizeof(struct clock_id));
+		ptp_data->transmitter_clock_id = ptp_hdr->source_port_id.clock_id;
 		ptp_data->ptpset = 1;
 	}
 
@@ -470,9 +468,7 @@ parse_fup(struct ptpv2_time_receiver_ordinary *ptp_data)
 		client_clkid->id[6] = eth_hdr->src_addr.addr_bytes[4];
 		client_clkid->id[7] = eth_hdr->src_addr.addr_bytes[5];
 
-		rte_memcpy(&ptp_data->client_clock_id,
-			   client_clkid,
-			   sizeof(struct clock_id));
+		ptp_data->client_clock_id = *client_clkid;
 
 		/* Enable flag for hardware timestamping. */
 		created_pkt->ol_flags |= RTE_MBUF_F_TX_IEEE1588_TMST;
-- 
2.47.2

