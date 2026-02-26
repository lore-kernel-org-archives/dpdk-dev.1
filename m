Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096ADFCE095
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 14:36:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1498740DD8;
	Thu, 26 Feb 2026 15:34:32 +0100 (CET)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48]) by mails.dpdk.org (Postfix) with ESMTP id D2E0040A6F
 for <dev@dpdk.org>; Thu, 26 Feb 2026 15:34:15 +0100 (CET)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-43767807cf3so654970f8f.1
 for <dev@dpdk.org>; Thu, 26 Feb 2026 06:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772116455; x=1772721255; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=78DYjsmaT1ZurMg5DZkZddBJF7SyjyIMpEbp6it0up0=;
 b=Ihzf/fnph2S9ra5MVwxJflHVEeAirfnsgNPX84O7jLlJUuV8IBde7+AylaEXVHvTah
 gzf+w1G50ZU4sgt57lGR5azUanUL9bJ8PFdHmUObsoYBzMHDtL8k3oAWajlYWkBYWuL6
 0Ug29NLxeHLGmHbpph35XFQaYxtyVB6DPtk0nG10l5PUS+xWCOXnH8+Jl74otTDAcMik
 CkNq+H9ORJ6F/TNZDT8Mnp0nbsL2s6EXeQcxLfpUDNA0H1NfxUmTo+l2joc5cjdP9St/
 txFHEAkl1C2i9HLAHDY9gfhL1GEbjGjRzE4ym9v0/AEHOU4znNgB1agmpwQzKteDD0jD
 TelQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772116455; x=1772721255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=78DYjsmaT1ZurMg5DZkZddBJF7SyjyIMpEbp6it0up0=;
 b=UwUECFaqg2rSWLlH/mQIxBQMxmGyRnzpQycNzofaThg+OhxiGQsmbS3BgD6gVnRN+i
 +lEjsvBVBi0Zov+KlsdWOVjfUZx+659EufC35MJGXXQVSYf8/dRO+rxu+Sh6fckk8+59
 gTWs5Edd4D4gI9NhDMyT5lJDxC+HBJ1HNU/XafYuaKjvX/RqhZ3UZBqFCv5q6mi9rRWq
 j4U9ni79I2/FeNGoUxIsEvOWaisdrV5MyNOrUl2ShmzpZD+rFtJ3daV2UWnO0XiDta/v
 it4RwI1+cGBm5k6RZlzgcVFFmQFKcKVzmQ+gpbtThnv9rSGEDt+lJdB6202JH55e+WgC
 pJyQ==
X-Gm-Message-State: AOJu0YxGLdTFi8HEBIWkFlpu3ncHM2Ye3GEICfa5ra/u9gfDo92hEY02
 CPzngukhNpLIrohpQqOUfy5eoTdXaJHK5Z4wSHoDCF+Z7Bi82lLJeyj64H6BQw==
X-Gm-Gg: ATEYQzzOEfE9l575ZZ6EEO+ygLAOk56QWYFYvKckFuO3mMUCcr9lsUH3iQsmLx0Lp+b
 SPY3SEkK9SyKE+2uSiCKY2t9MNkVsgpUvFFPLV24RuhczcBiIMFOq45/7kAFDq1Qn+bCtaCxN7M
 KSO0/eOU2U/gGppZTCpgDeYrjo+qz0TYYvfD+qzGDVk3fCjN8bExIUUa/rYuJ6v8cFOcTibLylj
 IEeq6ByaJlhbEn6PTeTnFZtBQ9laUJCxTLapzJy7SEw6rJP5JBqfSMlV+Mx7YthVRpXPnXQLyEo
 tqQBlAcPc+aFMofOl7ZXbqtcLuyRJ+JIvx69ZI0CndvwpUfpDLwti49hpWqXhqLjoAqKcelyvAo
 pq8hSAGUvm4SIkPW60xRZDcPeve3e0ohE9P7z9A+aJ8JB1N2iZ/kO+NF20IWqBODV9Luad4Byhx
 RJjVtYSI7rNPFtrxYQpqxusdcn8Q==
X-Received: by 2002:a5d:5d05:0:b0:439:869a:a15 with SMTP id
 ffacd0b85a97d-439942fbac8mr7866463f8f.42.1772116455293; 
 Thu, 26 Feb 2026 06:34:15 -0800 (PST)
Received: from freepad.iliad.local ([213.36.9.96])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4398bb96b90sm17993866f8f.9.2026.02.26.06.34.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 06:34:14 -0800 (PST)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, stephen@networkplumber.org,
 david.marchand@redhat.com, Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH v2 15/17] net/dpaa2: use CHECK_INTERVAL macro in set_link_down
Date: Thu, 26 Feb 2026 15:33:39 +0100
Message-ID: <20260226143341.282188-16-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260218160453.142311-1-maxime@leroys.fr>
References: <20260218160453.142311-1-maxime@leroys.fr>
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

Replace hardcoded rte_delay_us(100 * 1000) with
rte_delay_ms(CHECK_INTERVAL) for consistency with the rest of the
driver.

No functional change.

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/net/dpaa2/dpaa2_ethdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index d5e30ce5fb..a70e6895c8 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -2305,7 +2305,7 @@ dpaa2_dev_set_link_down(struct rte_eth_dev *dev)
 		}
 		if (dpni_enabled)
 			/* Allow the MC some slack */
-			rte_delay_us(100 * 1000);
+			rte_delay_ms(CHECK_INTERVAL);
 	} while (dpni_enabled && --retries);
 
 	if (!retries) {
-- 
2.43.0

