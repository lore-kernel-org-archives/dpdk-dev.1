Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DECCCCD1A5
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Oct 2025 18:59:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A8B964114B;
	Tue, 21 Oct 2025 20:58:28 +0200 (CEST)
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com
 [209.85.216.100])
 by mails.dpdk.org (Postfix) with ESMTP id 6227840E54
 for <dev@dpdk.org>; Tue, 21 Oct 2025 20:58:27 +0200 (CEST)
Received: by mail-pj1-f100.google.com with SMTP id
 98e67ed59e1d1-33db8fde85cso2580579a91.0
 for <dev@dpdk.org>; Tue, 21 Oct 2025 11:58:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761073106; x=1761677906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6r7Qif1e6qR0S1W944y6YqfDW70xyXuCLOdv23P+g6w=;
 b=eBRmSo0KfvfdErrWAKdReNqeXM5TfW3sLymbvS79+ZbMTCQQLlNcwVhw6ghEa7n4PQ
 JMKA1T3UVUWJMrdYCVdSxqCYy7hJVLnc6GvcmU7ss7a4NipesQ9hTpeJAwtUbi9f23GQ
 B7w4fpsvcZGUSYyEY1nAEivWAgCSqliRbZO1Ot/ugzoVu3n/EkLUsVye5zLK4qaLG2zq
 /pK3oyAsiJygVXD7oGI4xYzalV0zfLFpJwYD+QPxT97CSffyuA2KykCifN5UeE19tupM
 AR5FHiX5a0foLMHvhFpPzs62ULSI/9vwPJ5FOn3AW13V943tPC13KMgOw0WqhzuPbxVR
 SgBA==
X-Gm-Message-State: AOJu0Yz5WkBVYcLQ3pO/HfOOPDuAj15Zq5MfGlAuJGFB9yuy1CTMuAUr
 vO61We9TP7bDuGsPBA+BH35MAd2PO80f8EYorJMzWsF5LHYdB6jeBZte3VEMPa5jbN9EPkzOYfH
 igqd1ieSzc/etxUokSX2zhTONqPzjQu79Hkeir8TGUWrZEpNFMv6M4wsR8c6Dxrdmo18qbHNCc5
 UrwQ0pl6Ry6eQP0nPCzVcyTd70J9sWjbev/Xq8HLYanh1BEq5CQotmU+iCpw7DpvE5W1Bhog==
X-Gm-Gg: ASbGnctB9m+ZV/5yn8tbWrSANSt2V1pnplRF1Nr5G/Yf7Va2vv/ZI585LvEkd9nKGaF
 +lwo0xChVk73z7QqQ4A6/h9egR0UOlhYTrN0yNeWYzyhCsTiLrysdwfjVJJ4Cdv71zVS9gCf8sU
 2nvsSwFysV8ZogwP2LWRKr+lYCCAWkQQH+6c8A4n9zLE+e+6KthQiGmrnu2uDnYUO8nYdwOmHi1
 qGJ4DEdDfc8l/+ghQV/Dh1Lo42KN0d53cEQDChh9gIhb09mtPeJ3xb7Soczoa9FbfO9DV4SWmh3
 MhgRMHtnfEOrI56adF1d/8DMnRGV5C9B0PNUtZaCLTLG8uto2yCoRZFBHa2mnbvryYVihro+Pg4
 zdSHksY0OiP2AWxfzn+4uFxFNP0osiDOJRsffKn7DN6VhneVoG9++dUQ19TlK5o5Bm4UBlvduga
 wLtO8x6oq6r9AlT6hRO5AtW0hQaZVO7bGoFTbx
X-Google-Smtp-Source: AGHT+IF6PP4akAVl21Qg4gt7qFNFP/70kR+3h/srWawlzb3bdj8FoPtzg6Pba3R7w5c4sgroMAFvVq2ZRtfV
X-Received: by 2002:a17:90b:3f85:b0:33b:b078:d6d3 with SMTP id
 98e67ed59e1d1-33bcf8e5ebfmr24533580a91.23.1761073106518; 
 Tue, 21 Oct 2025 11:58:26 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-33e2245c55asm28805a91.3.2025.10.21.11.58.26
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 21 Oct 2025 11:58:26 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b55443b4114so3566025a12.2
 for <dev@dpdk.org>; Tue, 21 Oct 2025 11:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761073104; x=1761677904; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6r7Qif1e6qR0S1W944y6YqfDW70xyXuCLOdv23P+g6w=;
 b=HROnhpBweHIX7QjxM2192o5nEBvYtOXkddgjHEnDcKaOWffNJt6awQz5d2AyCzi8cR
 gJRCF5OmiZVTi05yfcUCnqBU3GGxZbhUcKZOY2sTcZ5x/sYYnPpcpT4aiij+72nE7PeQ
 I4FhIBLanVm/8yak4+JVTCf8ON9jn5Aa5fH/Q=
X-Received: by 2002:a17:902:d50a:b0:27d:339c:4b0 with SMTP id
 d9443c01a7336-290cba4efb1mr232809405ad.35.1761073104329; 
 Tue, 21 Oct 2025 11:58:24 -0700 (PDT)
X-Received: by 2002:a17:902:d50a:b0:27d:339c:4b0 with SMTP id
 d9443c01a7336-290cba4efb1mr232809025ad.35.1761073103796; 
 Tue, 21 Oct 2025 11:58:23 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29246fdc9cfsm116598155ad.45.2025.10.21.11.58.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 11:58:23 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com
Subject: [PATCH v4 48/57] net/bnxt: add meson build options for TruFlow
Date: Tue, 21 Oct 2025 14:56:52 -0400
Message-Id: <20251021185701.71881-17-manish.kurup@broadcom.com>
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

Add meson options for
1. TF template
2. TF feature bits

Signed-off-by: Manish Kurup <manish.kurup@broadcom.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
---
 meson_options.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/meson_options.txt b/meson_options.txt
index e28d24054c..3354ef2b4f 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -58,3 +58,7 @@ option('tests', type: 'boolean', value: true, description:
        'build unit tests')
 option('use_hpet', type: 'boolean', value: false, description:
        'use HPET timer in EAL')
+option('bnxt_tf_template', type: 'string', value: 'default', description:
+       'Truflow template selection')
+option('bnxt_tf_feat_bits', type: 'integer', value: 0, description:
+       'Truflow feature bits')
-- 
2.39.5 (Apple Git-154)

