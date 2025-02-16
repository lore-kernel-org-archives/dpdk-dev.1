Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181E8C021A4
	for <dpdk-dev@archiver.kernel.org>; Sun, 16 Feb 2025 17:02:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 228F340FDE;
	Sun, 16 Feb 2025 18:01:42 +0100 (CET)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mails.dpdk.org (Postfix) with ESMTP id 3FD0140E50
 for <dev@dpdk.org>; Sun, 16 Feb 2025 18:01:34 +0100 (CET)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-220d398bea9so49803335ad.3
 for <dev@dpdk.org>; Sun, 16 Feb 2025 09:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739725293;
 x=1740330093; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BWlABOBDjT+D93lC4xk3UAjMk4KNQQKjBPILflrvYnM=;
 b=q7T7amwcYCY/z8DdckZ4O2gG+xtrwuhyVXJNNVtMQoRsOzZhGuZ7QPR2elk6dwAKgP
 FFl48CG2J5mgwBKSqn3I5EkFtop7oiLmt58yGDpK8yV45RMGeYf0SJT+oj+1Xtpjklog
 pai0eBEzvmExYo9TvTCgSnPAQO7LqwviLK1Lela1hOfQw2UDLJWG0CyZDb6hPhmqtDy8
 PgXpS0GWFB48JVA4iesxarfEvx9R7J6V2H8obCO4+GJ+R54ONu7CFQp9LyJjCQMqU3CB
 qcDIfOMYElh+GDW0+9RIXusG/dMXKU+8ICXA8h2IIsnrOpkkd8tqze3JDQEAknfK4FaY
 N6lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739725293; x=1740330093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BWlABOBDjT+D93lC4xk3UAjMk4KNQQKjBPILflrvYnM=;
 b=PKxwMXKRNpuqZB3JL0QaIc6A2VcXF43Ofi/bqtFP7plEdAiLiCUB3WBwmVXtaKQXKj
 /D9brGR/+IoNLsC3I+U17uy8wF96wMvgASifTuOyDSE6iXbMPuk2TrN43xlEKxf0ujSD
 2GJEQ5+leHw+EqdPA/3VDclqrw7eaaiWF3G5kOfRX2BpNfChNJRFoxFQ0zHpFgfr69+f
 dIgNgQvfmjf2hPZi+9fDO1UZPZ100/So+D9XUWtudVBRCqf68AwYOQigNZ+El1qE+L8s
 AIgX40P3jFhCLyHk0XdLlF2rHJoiTN9yEShkzlZmy7tmdAuF4Jmu8FKNlYg3pfOKoRj0
 oZgw==
X-Gm-Message-State: AOJu0Yx4DRs8cYipQqfrcXVtnhlDOdOlKCcmv5si2MVqBc3NyTdPddlB
 Ro+KT24S4po+eCvg5ne50IzLNRMN+rImsLba3WYi/3E2nbopB5DkMIOf5QptzKJ3i9eSoVwKaFW
 i
X-Gm-Gg: ASbGncu1tw3Kt5YtqBSfBUU+H8MLS5nMK1hElzuJlDxM+Lfaj0CqYOtvaV+BsZObv5d
 ZrrrzZWFebpPmSOydkGeusslwy6jRfTOIfFfrlA2XAdNTC/Ys8mVlCJIx4pXqEei1FCdaR2VW9a
 o3NFNCEmm/JS9VzVbmcL+dW1XQ2caTavZfyYt/o/RHxRsQ4x7Sk4CyyuRsGrnKfPd+WWXvf0Ff8
 6h/HmeS/1W2RSDp9idmqZ9G3YEIfSIhTtVUQ5NeKYuddVGxVijMGjYp1g0aMAZdI2GlAzhcSMQl
 k4FRaAC7hJ/58PfVlSKRcTBVWcCUQVZgYtuKrFAHZfPbmRTVJbpJJO0vju3F/WXgJr9c
X-Google-Smtp-Source: AGHT+IH32INqkcGIffUWxZp4AJ+gZZSdORS+zb6PTK/fRlxxO34Pi4eIWwsKG5zMvKuKLl6PEwqWGw==
X-Received: by 2002:a17:902:e88a:b0:220:bf1d:41e9 with SMTP id
 d9443c01a7336-2210405f21fmr105384865ad.23.1739725293463; 
 Sun, 16 Feb 2025 09:01:33 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2211eafd20dsm11196805ad.182.2025.02.16.09.01.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 09:01:33 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Christian Koue Muf <ckm@napatech.com>,
 Serhii Iliushyk <sil-plv@napatech.com>, Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v8 15/17] net/ntnic: check result of malloc
Date: Sun, 16 Feb 2025 08:53:14 -0800
Message-ID: <20250216170110.7230-16-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250216170110.7230-1-stephen@networkplumber.org>
References: <20241114011129.451243-1-stephen@networkplumber.org>
 <20250216170110.7230-1-stephen@networkplumber.org>
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

Need to check the result of malloc() before calling memset.
This is only place in this driver that forgot, other code
does check.

Fixes: 0d9bca480e26 ("net/ntnic: add FPGA modules for initialization")
cc: stable@dpdk.org
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/ntnic/nthw/nthw_rac.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ntnic/nthw/nthw_rac.c b/drivers/net/ntnic/nthw/nthw_rac.c
index ca6aba6db2..f275e64da3 100644
--- a/drivers/net/ntnic/nthw/nthw_rac.c
+++ b/drivers/net/ntnic/nthw/nthw_rac.c
@@ -31,7 +31,9 @@
 nthw_rac_t *nthw_rac_new(void)
 {
 	nthw_rac_t *p = malloc(sizeof(nthw_rac_t));
-	memset(p, 0, sizeof(nthw_rac_t));
+
+	if (p)
+		memset(p, 0, sizeof(nthw_rac_t));
 	return p;
 }
 
-- 
2.47.2

