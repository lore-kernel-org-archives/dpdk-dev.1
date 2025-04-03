Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE0AC36014
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Apr 2025 01:44:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 39E9B4029A;
	Thu,  3 Apr 2025 03:44:02 +0200 (CEST)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTP id DB8774014F
 for <dev@dpdk.org>; Thu,  3 Apr 2025 03:44:00 +0200 (CEST)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-225477548e1so4542095ad.0
 for <dev@dpdk.org>; Wed, 02 Apr 2025 18:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1743644640;
 x=1744249440; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AYZYa75hrJCn4BOHrd+SooPbAae55Rr6WYA5w9C537o=;
 b=a4GmuH//QWh4t6XOaXC5t/aZsKhkbkK4vf58HcuMulpP1v9YP9FDB8aYHNxllOb+Oq
 N5YDZ4xm7Dmd92oMMtuOFiK7SUUb/sEsVwCkMsHzkJePDEZ3yKU9ciFklIzbulKCDrGS
 9VF+K6Q3rR2iHEFQXfnd33pjB4bxhlGw0MiY+ZgYloFNlYh3ktvNZwRC90PDE+VzTQKE
 JYW5y4EkyJ10wS3Yeg4NU6AGnv4adt+mW2Zlpu/+q6Sxv3D39yV1or8ZPVmRpTLm+S3b
 yYl0EZgJnTk5lXH5oH5kfYYZOibpiHDHTcuWr3b/iA0ffIgIz4VQ/KN2j5vXoPy2qLrY
 vL0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743644640; x=1744249440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AYZYa75hrJCn4BOHrd+SooPbAae55Rr6WYA5w9C537o=;
 b=nFqP5C8g72YiKwRTnfQ+WprETayQfrmwr5HmUj2z24Y2Drk/MPblOW0YJdZ1gqwNP1
 rR0sSUjKVhyVq/L4++CVtMCXfffV4HFDUiwa/3OCKDuSJy23VNUzB5LUrGm5ccGwNlOd
 yci0WaMTBnL2SYHLohLKUbnv1ybbTeg2e55cgplSVpTKK2zVL6+Gp41JF3K/6E+VMoc0
 lbc+iVo6yPF4nTaFbZIt7fftePmfEHZiDP9FbdhA6TMHC/89bqsZ/2/AP17d15Qu2x3O
 tAmeVPciqdlaiL60Pir6fbCIcCWiDw1ScNMgVmKOs9o9o6ISTsIxl3FlEUV+YY2i5WhH
 zHiQ==
X-Gm-Message-State: AOJu0Yz47Xd1eTk6iudHX2nndLcCizn+nJeKcmyP3co/2ts2+hXs7O0Y
 uWYtwXNtlEUTTFT/YK4vEaq6LPyDiRInlxlxbUW8lyt5TqVeYJ7YzGE5z0BmEYY=
X-Gm-Gg: ASbGncszMN8tFAh5lnaSK8vz/F+mqhoGR/lkqBuMKeFZH+OgP5qcDnSVuVYe8xn0X6U
 5fsH9xGy3OwTRBUnVzXFR1BMZ6OCQfBhv21jB9tsb9urqo8Fg5IySLOEs04XEmIWVJQp//w+NYS
 2nwhYeNk2rIlFOntd38dx+T8ztwazKKKsdovfWTpa+AExhJ8iyBsP1jQfgidy6Yd+/6CFgLTCrX
 kSmEDGlOt+WCRvHJduB6WIbWUk0nq2FDnWw0nKMSu9BOWnPpvbVgoblJIRFMk302DuI5ZYqYJMx
 NQawxek8YXM6jOq3xGKWaFPWhVckZbKDXG2Sw0oC48F0LuBoidDQhn7JrduvS9LpgYhjGUQc1AH
 1DDi3LIlhBjXbv2R1GvfK
X-Google-Smtp-Source: AGHT+IGJyJFlwjDC/RRsK05l+FCg5PgdG7bK0F5NmiT7zSTmnaoCnyiYJ8Hryw9h2XkOMHxmP6q88Q==
X-Received: by 2002:a17:902:e887:b0:223:44c5:4eb8 with SMTP id
 d9443c01a7336-2292f9dd795mr282449305ad.32.1743644640026; 
 Wed, 02 Apr 2025 18:44:00 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2297865e093sm2636585ad.132.2025.04.02.18.43.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Apr 2025 18:43:59 -0700 (PDT)
Date: Wed, 2 Apr 2025 18:43:53 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liwencheng <liwencheng@phytium.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v4 2/4] net/macb: add new poll mode driver
Message-ID: <20250402184353.206864a6@hermes.local>
In-Reply-To: <1743577136-119797-1-git-send-email-liwencheng@phytium.com.cn>
References: <1743577136-119797-1-git-send-email-liwencheng@phytium.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Wed,  2 Apr 2025 06:58:56 +0000
liwencheng <liwencheng@phytium.com.cn> wrote:

> add Phytium NIC MACB ethdev PMD driver.
> 
> v4:
> * Changed functions that always return 0 and whose return value
> is unused to void type, improving code simplicity and readability.
> * Fixed the implicit conversion issues in the
> macb_usxgmii_pcs_check_for_link and
> macb_usxgmii_pcs_check_for_link functions.
> * Added the missing SPDX license tags.
> * Fix tab errors in meson.build file.
> * Use RTE_LOG_LINE instead of rte_log.
> * Replace %l with %PRI*64.
> * Replace rte_smp_[r/w]mb with rte_[r/w]mb.
> * Do not use variadic arguments in macros.
> * Do not use variable-length array pkts[nb_bufs].
> * Use __rte_cache_aligned only for struct or union types alignment.
> * Support hardware Rx/Tx checksum offload.
> * Fixed some code style issues.
> 
> Signed-off-by: liwencheng <liwencheng@phytium.com.cn>

These checkpatch warnings can be avoided by putting __rte_unused after the declaration.

I.e 
eth_macb_xmit_pkts_vec(void *tx_queue __rte_unused,

CHECK:SPACING: spaces preferred around that '*' (ctx:WxV)
#7246: FILE: drivers/net/macb/macb_rxtx.c:1370:
+eth_macb_recv_pkts_vec(void __rte_unused *rx_queue,
                                          ^

CHECK:SPACING: spaces preferred around that '*' (ctx:WxO)
#7247: FILE: drivers/net/macb/macb_rxtx.c:1371:
+		       struct rte_mbuf __rte_unused **rx_pkts,
 		                                    ^

CHECK:SPACING: spaces preferred around that '*' (ctx:WxV)
#7254: FILE: drivers/net/macb/macb_rxtx.c:1378:
+eth_macb_recv_scattered_pkts_vec(void __rte_unused *rx_queue,
                                                    ^

CHECK:SPACING: spaces preferred around that '*' (ctx:WxO)
#7255: FILE: drivers/net/macb/macb_rxtx.c:1379:
+				  struct rte_mbuf __rte_unused **rx_pkts,
 				                               ^

CHECK:SPACING: spaces preferred around that '*' (ctx:WxV)
#7262: FILE: drivers/net/macb/macb_rxtx.c:1386:
+eth_macb_xmit_pkts_vec(void __rte_unused *tx_queue,
                                          ^

CHECK:SPACING: spaces preferred around that '*' (ctx:WxO)
#7263: FILE: drivers/net/macb/macb_rxtx.c:1387:
+				struct rte_mbuf __rte_unused **tx_pkts,
 				                             ^

