Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC0BC369AE
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Apr 2025 23:50:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 59CE640E2F;
	Sat, 12 Apr 2025 01:49:52 +0200 (CEST)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41]) by mails.dpdk.org (Postfix) with ESMTP id 88B0A40E0F
 for <dev@dpdk.org>; Sat, 12 Apr 2025 01:49:46 +0200 (CEST)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-2ff6e91cff5so2653560a91.2
 for <dev@dpdk.org>; Fri, 11 Apr 2025 16:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1744415386;
 x=1745020186; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=96mexB0Iy/kQg/XAR7PKNCoZdtGJWzlZ/7+vjECaKdQ=;
 b=3JfPFjKrH+N+kIRlziFYEvny967lzS8ag0b5HWsiVnILGIfaKF5KnHvXhPO54baZVV
 /V4vUzy3vmz6CSBK+JTsJZBbx7f97/5Y5W2SO0guqwn5s0gaQPBk1aL1w34lIKCTXpb4
 AsdKc5w4vK9fnjGlBRioeT4dhRMStzprCOBDEylQjlRm2DQ7FEU5aIok2bgXGKkwHmK/
 KIKc0185A0+qd9NWaLDY6i0O3OXxoxbe9zeUFytOUXQDF7/VfoxukbeOSaSEeNgzpqwF
 QrOpSTXE2b6MvfqAHHK/wdOivx+Ko7bVDlKDtTH3iIumodugORg0mHXDEUN1FcshyUow
 YFrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744415386; x=1745020186;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=96mexB0Iy/kQg/XAR7PKNCoZdtGJWzlZ/7+vjECaKdQ=;
 b=O2t3yUZy8zSH/R1pAM2GOoBMroZLZbqlYWIUxmwRw/fhifZJq+v1l7kztsVC1c1K4l
 bSAqqsNYMabScKRZzh/gRGV/gz+Ot2+0a0omYh3hJIbp/gn+87DDvdiouij+9ewq+OGv
 2icHzLSTeH5g/fzeOdbJsSTqOXO/CtnNr2koCxk0Ktdd1HwKxrNgF9kTwvhn7pmA5Q3R
 8AxoCjJ7YomGy/1R/UYBfPLTDbF5BORw2Ws0UXg0wbfqtPrPCJE6Ju6OPuOD1shZDhUD
 sc8DOzrWAEKWQYSvU8Mb3EKIWnv9Ab6Ql+qtLOYp8S92jqmJquELrjIHqDxq2vlwMl22
 AGZg==
X-Gm-Message-State: AOJu0YzadVDXI6VhB3iaKecfYlhmJzcFgacJHIW6Eo8YyT9Po6/UZdtY
 fiZ656nKP31qQZ/d6rkS0E2EN65914ORLz/1jIaXE+jht084ObFmODH0CXba1kvgGzE2/zJgcOX
 X
X-Gm-Gg: ASbGncuFKF/aHeO+860dSBPMTcE8gX5DwHmSYxQPNErbRZscXJEH++ehzNtONKsJXYu
 CdnhlGN0zqnXk9AsUrFxFND3IfmRvr1Vn1JR0fg8A+WtfSJivdQvVh5xKo70ucD2qa6eddfhM0n
 3t+JmLnjUSVVjSqkd1wJK1UWRF66CJDos/N88tb/xmiVG5GKN/BAU4BsfjqfOXUJ/e9BGBojt/L
 R4k6yGkfyRJUqvap8cpTwOLhh4wFxPgxV/vmdZMvypfZFFAqlbO0MuDo4bf6NXVut1rHGesPB6r
 5kKgWpmItbQOqcDF5OuhC37nGt6fVYaoPKYMPlvv+beIakyeZACYqddaaBBgRv+dccmB5OTZJrz
 OwAe4jMDqih/7Z4Fk
X-Google-Smtp-Source: AGHT+IE2ytYnuD04nmz1JM6BfHi+KquJ26BISSLFjZudz4W0swL3m+q5LNgHmKvYs8NCxmEjJmKjbg==
X-Received: by 2002:a17:90b:3811:b0:2ee:c2b5:97a0 with SMTP id
 98e67ed59e1d1-3082367cc82mr5444642a91.25.1744415385604; 
 Fri, 11 Apr 2025 16:49:45 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-306dd11e643sm6538661a91.12.2025.04.11.16.49.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 16:49:45 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC 08/13] mbuf: add fields for mirroring
Date: Fri, 11 Apr 2025 16:44:45 -0700
Message-ID: <20250411234927.114568-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250411234927.114568-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
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

Add field to union used for sched/event etc, for use when
an mbuf is mirrored.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/mbuf/rte_mbuf_core.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/mbuf/rte_mbuf_core.h b/lib/mbuf/rte_mbuf_core.h
index a0df265b5d..1806dddd67 100644
--- a/lib/mbuf/rte_mbuf_core.h
+++ b/lib/mbuf/rte_mbuf_core.h
@@ -589,6 +589,14 @@ struct __rte_cache_aligned rte_mbuf {
 						 * @see rte_event_eth_tx_adapter_txq_set()
 						 */
 					} txadapter; /**< Eventdev ethdev Tx adapter */
+					struct rte_mbuf_mirror {
+						uint32_t orig_len;
+						uint16_t queue_id;
+						uint16_t direction;
+						/**< Port mirroring uses this to store origin
+						 * @see rte_eth_mirror()
+						 */
+					} mirror;
 					uint32_t usr;
 					/**< User defined tags. See rte_distributor_process() */
 				} hash;                   /**< hash information */
-- 
2.47.2

