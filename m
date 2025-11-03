Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FEFCCFA03
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Nov 2025 16:52:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 35BE440E12;
	Mon,  3 Nov 2025 17:50:00 +0100 (CET)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48]) by mails.dpdk.org (Postfix) with ESMTP id BDB3940666
 for <dev@dpdk.org>; Mon,  3 Nov 2025 17:49:54 +0100 (CET)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-340c39ee02dso1896413a91.1
 for <dev@dpdk.org>; Mon, 03 Nov 2025 08:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762188594;
 x=1762793394; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6WmAMpChFGZ+NQ3XgGiUMRN9oARNH1Z+u0iQZKlQ8kY=;
 b=whkx+t4lTOH+uIxQQ8eFkT91HDHSdE2xJP+wxzWhwTN3NyxlY31nxUeZqIxnvAUbNA
 H7T8gvZEJZjthySg98DpjjtC4CEV0u83dv4uBtxoUotwUKM2OQoAscOV/mAb5QxzHK8z
 4NM4RGfDQzAXCPoochl4FHpHzpyob7vy8nT3/EuQnLVb9DUHll3U6cYAvZ9EdqtGH2ZO
 As+otgTt8Qz8M5tqZnBRSYgdlxobciMf9KoAwOLiz0ofdXPs4SvfKGpFUwRIiJNpZY86
 naGrLmQ8DgGOGRJ62BVu4HC0JFiwCm7A9o2MbBirc4ccNetA9/kDDwjELvI2pAKw0Wl1
 bk1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762188594; x=1762793394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6WmAMpChFGZ+NQ3XgGiUMRN9oARNH1Z+u0iQZKlQ8kY=;
 b=kUybIxublaRHVbcQBPNKr1ORu7afDIK4iPtAO/5uwudmySrLDpulJZFEi9wiQjms9R
 W+MdSLlCXPe3TkRREjhyR8QHA/xXKxFeZy34h2/a7zRD+2/LXdxz+wbf9zMDMnVNTG0L
 ZtxI0H3aj3K6ahz1QrGIPkq4q2MfngW8e2GoxA+IK2dwpwDmJHAuYjXxH/dN55HU+FXQ
 j30kuuae0Dm0YOM1vrpS3NFtVQxjvtbKP93XagCU1PYz1Vj0sbEn4C+ZcMZDkjbgDfoD
 JD+YdRNd6UJZEvWqeIItFYwjt/N+cx8k0Ab7uP7eW0N9XLnJSdMO7z5t486pI80pJ/05
 yiQw==
X-Gm-Message-State: AOJu0YymHYjcmkjFbKLif3JYZPTX5jg1lx0aExSCPfc30YDSVT0BUFcr
 clWQIROx/yoyHPXYT/qqFlZFkii5vme4aHzOvaf9Z7IiURxt54v4if+ifZdu76jRRHQZI3sep6J
 xakgw
X-Gm-Gg: ASbGnctchy8BGb35pHY9CKnvAavOyzldaEIuEI9Nm/D+4rjam2TuvjlOgH5bNLQxRfR
 G77Xs0gZC0AouY7J84jnUd9pfbex684JL4qOacvlzBZ2Wkc1nhpCErOm6EWpbsXQ6lITTcHBx8F
 DN32s/z2pWozJ3unI/ho3OsIjMp3SQ1aPJNwo9IDec1BD0YOywzjlHVM8wfoI/yg6hPeMHkA81Z
 5ybcntwUIN5ZowLU1mJuyV7zemXTOMtucpuImOvLIcpd2ISLHH5RfA0NlnwsHRthg4rk/9d4nWn
 z8sZKYyETbbMFCRxl7SfH6dnDemkbCVxBZvmbv0nyhd/8vDRWXT+kbF+0U/KgYU6nVBz5bkhtLk
 7PHSdaFz1IKNzOJULw3MkcD+qCWvYvxL7Rx6FQHAT9Kw9O1T+5fCCTzRN5cc5rRO3eMzL7GZAzI
 Q3cyCUNE3mTM460CEyUuDNhNOeudnBQMbIiFnE9CY=
X-Google-Smtp-Source: AGHT+IGgX1b76KWixz8Hx/ekKApbcseQi2evK8R+kUQswuBpdUbsGSYzJy3Lvi48+gXFXEC+DIbZiQ==
X-Received: by 2002:a17:90b:55cc:b0:330:82b1:ef76 with SMTP id
 98e67ed59e1d1-3408308b48fmr14006190a91.28.1762188593946; 
 Mon, 03 Nov 2025 08:49:53 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3407f26e0a6sm6779040a91.5.2025.11.03.08.49.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 08:49:53 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jakub Grajciar <jgrajcia@cisco.com>
Subject: [PATCH v3 26/44] net/memif: replace use of sys/queue.h
Date: Mon,  3 Nov 2025 08:47:31 -0800
Message-ID: <20251103164915.101713-27-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103164915.101713-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20251103164915.101713-1-stephen@networkplumber.org>
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

Replace use of system sys/queue.h with DPDK rte_bsd_queue.h

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/memif/memif_socket.h  | 1 -
 drivers/net/memif/rte_eth_memif.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/net/memif/memif_socket.h b/drivers/net/memif/memif_socket.h
index b0decbb0a2..f95b64fd61 100644
--- a/drivers/net/memif/memif_socket.h
+++ b/drivers/net/memif/memif_socket.h
@@ -5,7 +5,6 @@
 #ifndef _MEMIF_SOCKET_H_
 #define _MEMIF_SOCKET_H_
 
-#include <sys/queue.h>
 #include <sys/un.h>
 
 /**
diff --git a/drivers/net/memif/rte_eth_memif.h b/drivers/net/memif/rte_eth_memif.h
index d4e625ab51..0154930cb7 100644
--- a/drivers/net/memif/rte_eth_memif.h
+++ b/drivers/net/memif/rte_eth_memif.h
@@ -5,7 +5,6 @@
 #ifndef _RTE_ETH_MEMIF_H_
 #define _RTE_ETH_MEMIF_H_
 
-#include <sys/queue.h>
 
 #include <ethdev_driver.h>
 #include <rte_ether.h>
-- 
2.51.0

