Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFAF4C02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 16:26:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 45C2240A6D;
	Wed,  5 Feb 2025 17:25:15 +0100 (CET)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41]) by mails.dpdk.org (Postfix) with ESMTP id DCFDF4065B
 for <dev@dpdk.org>; Wed,  5 Feb 2025 17:25:08 +0100 (CET)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-2f9d5f6df4cso2357389a91.1
 for <dev@dpdk.org>; Wed, 05 Feb 2025 08:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1738772708;
 x=1739377508; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zB6hIMtxNUEA8p6kUttERH7GJP97SxLZf0I+dhffzHM=;
 b=aexkUW/yDg/OEtvAzCvWsr7kTH8cHTARmXnUMOvNOQJauYVKEU771NmjX4w0PbhxiT
 +xi6N/Xf8DvYTVyo4wsDsCpYaoW8qQ1y6HNwJjxH7q+5ie/89dbxn89BxpnSRTB0UFmr
 rAaqows5yAMiQTiywGoeuO8xXzsY0cE6S/xwyqcojRiirzHhCubkzMlAd0zNguyJ7o30
 zG6zH/dNeNB193nVCqvSrqWjr1CJqe6Z4wlP3bSqkAPQ1qUeSe6TQg6m6JOYZPlYsnSS
 ZODNXeclXzxmaQhS37IF94/inQNplXD1t+OjhbdvkI/BM6w+UK/cJ4GlQ8oNgTUQo9uX
 Mq2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738772708; x=1739377508;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zB6hIMtxNUEA8p6kUttERH7GJP97SxLZf0I+dhffzHM=;
 b=Jrt7l7kV9nXQ+AzhIW4ghXdB2E7d/UIkMvHnqYtu9WBLsBOHUkWcvBmxUbYF9aUh5S
 W6BLZgmeaddc1djEFSXxNDMW4BXKFD2YYSHg2oP01p4SS99zKX8fX8PMg5wi1q0C5FZy
 H6mr7kM53wo3fzcaaSkblxwCL2M3AxjGBTHu0hth/QH5VqMvLRfMF+79P1WdD06xVLdG
 l1Rxl/B30EWyUNszHVtY0jbUcd50yWjV+0+fS5Ru609pUJ5/Ia3JyjZaE49OWQzWC9N0
 jNGeHI/5Zaus+QD5TH4SLDJNeH1s1OTqYS8zbEdAbctK8InNMuLwaU+7/xDT51fwgc8o
 s6VQ==
X-Gm-Message-State: AOJu0YwTtf73QH9udmY7Ijdu2BUprB7+fff77M+rHNcF2ZyCRweCaqzW
 nwFq0GwbUS0hozBjyAFD6EuigxjfN6lJ/deGoP0ldNIv/F1jxWl4WLcznirjvGkw4js3Kt8Gtbo
 l
X-Gm-Gg: ASbGncu0pwvEB5n68Np3zU5dqVClBY6Yqze8vdxGI8Zy3ppOoAnvjx7wGQDXYkeWCoC
 NTgXUVQEBA3W1dlCzetahhE2kZ+3VFH8ciavmjBUhS8amS1vbKyLy3P7GXizsoCBVdW/pUQervz
 XKL1D/b/nfG1QqbCYwXaLxWpszNPgZVU2/NswsYSHHU/xNAKf6EmaqrVPGqYXqwBXTOgPuEqov7
 WgQYw/JhOc1ByzSPRsyn1BuIA/GgLtBqOxtSP9gnK4ICM+xIBh0pPH9a8hWxudga/LaGmv3YP7I
 SkgZQVvPgGZ+R5rbTlWmc2HmDkAIeHLIfntveWSFoU6BN/wPNLmH7y3oyuLWJPHufTHT
X-Google-Smtp-Source: AGHT+IHOZIYwSOGWklF9gT/z6zxUTnxmaqPiYXrpkJ6BBKzS6sna/JPi3Mm+bBVXVphJ5NDZlhK9fg==
X-Received: by 2002:a17:90b:4fcc:b0:2ee:8031:cdbc with SMTP id
 98e67ed59e1d1-2f9e080004dmr4303528a91.23.1738772708002; 
 Wed, 05 Feb 2025 08:25:08 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f9c314b64fsm2138965a91.1.2025.02.05.08.25.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 08:25:07 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 danielx.t.mrzyglod@intel.com, stable@dpdk.org,
 Kirill Rybalchenko <kirill.rybalchenko@intel.com>,
 Pablo de Lara <pablo.de.lara.guarch@intel.com>,
 John McNamara <john.mcnamara@intel.com>
Subject: [PATCH v3 09/19] examples/ptpclient: fix self memcmp
Date: Wed,  5 Feb 2025 08:23:10 -0800
Message-ID: <20250205162448.161161-10-stephen@networkplumber.org>
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

Calling memcmp on same structure will always be true.
Replace with same conditional used elsewhere.

Link: https://pvs-studio.com/en/blog/posts/cpp/1183/

Fixes: ab129e9065a5 ("examples/ptpclient: add minimal PTP client")
Cc: danielx.t.mrzyglod@intel.com
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 examples/ptpclient/ptpclient.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/examples/ptpclient/ptpclient.c b/examples/ptpclient/ptpclient.c
index 27d06dd91d..c344e7db1e 100644
--- a/examples/ptpclient/ptpclient.c
+++ b/examples/ptpclient/ptpclient.c
@@ -367,7 +367,7 @@ parse_sync(struct ptpv2_time_receiver_ordinary *ptp_data, uint16_t rx_tstamp_idx
 		ptp_data->ptpset = 1;
 	}
 
-	if (memcmp(&ptp_hdr->source_port_id.clock_id,
+	if (memcmp(&ptp_data->transmitter_clock_id,
 			&ptp_hdr->source_port_id.clock_id,
 			sizeof(struct clock_id)) == 0) {
 
-- 
2.47.2

