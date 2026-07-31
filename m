Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB8DC55167
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jul 2026 05:00:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5F7E2406B8;
	Fri, 31 Jul 2026 06:59:57 +0200 (CEST)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by mails.dpdk.org (Postfix) with ESMTP id AA3E040698
 for <dev@dpdk.org>; Fri, 31 Jul 2026 06:59:55 +0200 (CEST)
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-ca97d139d5fso341055a12.0
 for <dev@dpdk.org>; Thu, 30 Jul 2026 21:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785473995;
 x=1786078795; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zFZDpG4eV0HCHZKgDiuGv3S4hmSfbHtRtepgmSaR2HI=;
 b=Hq9ulbbtgzBN5w41onkpI/S1y5ZqxtD7fPHjVl5RhSsbo9DExgNXc+NqNw5qZ5YIC0
 2i6DpsSvUznUKPiiyhO6hR1jA33sviZhzKHXl+1q/LuPGmijPSOAbE6+xlfsVPnxcheb
 +XnCou0GvIdu6Grtn3oQcea+VyvX1tXE2A9m+Fg+gOUO1LAffvck2jhomRrwsSn9ZWB+
 +LBHUrzMsc1JIg+2R280Ls94NSdAbVwTOlYFPJw6O4/nsAM2C4T6imTEUhV+X66/JW8R
 gvGXUvz3pn1CD29+3X9uJj2xIdO+/MEadjHzcNOXQgstYWxxhFohyug46D3o1wscwqsB
 f+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785473995; x=1786078795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zFZDpG4eV0HCHZKgDiuGv3S4hmSfbHtRtepgmSaR2HI=;
 b=VR7vgVZf2xECG82l7B4nsQP/niB5C8ami45JCfPrhI9hp8s5lS7/rG4tcX9RERqvtj
 qqhA9E5KOxugCP3KoubNLZyD0KF0EZjGHjct+0Kw5nx6IoXp52TWFhJ2hB8ftiP2y+og
 Dt/T5y0/dW64KIJQt5jM5Tk8CF9pPC/nh5nuDwUKhkDcqlChaAxPyYce3lYoD4dMZyoq
 hRcRinmXE7991WLW9IiGOxjxQ0nz5ZhR8UJkCWNlOQAl0XguOrXz4WcRgmuPqk2bYz9u
 9odIQZPh+VN98tu89GH/7pN1+r5tWgZd/ER6u48sfMsbUUiSWas4EyiuacOXcEhZALnp
 HnwQ==
X-Gm-Message-State: AOJu0YyLGVA/vFlG+GOjSm20cPKB4OXNp1o14STTPnibvZ7PLwBNbQhg
 IJa8F5w9zZdY8io9hmcZaT3Ch9bo3PcRz1xSOCoqQRD+M3IlAAyayu89zbkZ4JaAXgZN91BjF9g
 xO4Ap
X-Gm-Gg: AR+sD11pLSz8zWCTuZyNFTyh2bcFn7OKyFeu+0M2MwkzcMjCDJOYa14rvGkjj+cZJ9w
 mlNpmVQWcwHw+HZQxmxRnLcJyJu9MtZncuzXMV+tY3XJBgCTllKY58zryXd2jH0zZZEniLEZ9/n
 L2lJbyYGfSu5l7ftx6tJ4knu2Gjl88bbM7Ymfk/wx5yMyR+zXy5NA5+jvJw9HlR9l3DQBmj6DJm
 G1AFLLOEWkAgwoGDBhTNBrwKE2XfWBMbRCuxQGNnpfCleYK5ojp8Ytmfx5rzb0lueQpBsYSC6h7
 sej85BsjNNTOC4bIih3GUTORvoSbR6Hj5XoJTJEFzEoa7+4lxG5wbdlnTDIPo8uvJ0ohd9BMaHO
 krciBE20EEweque4VNdERnayfvIc0g06ArIlNyO8mUgklSFJDShXWqYpnIR8QhcN3zS7+OgZbei
 Lqo1V3HrIJxitCfWifrmaRW9Ov1T2FN1dW4srSzsTRhnAWJLtn/5vwcg5shbYoUKvh0BoldY8Vg
 AxvEBD+CBxflw2vWThhU7heANg=
X-Received: by 2002:a05:6a21:6da9:b0:3c3:9df8:2eed with SMTP id
 adf61e73a8af0-3c91b17daf1mr470557637.31.1785473994903; 
 Thu, 30 Jul 2026 21:59:54 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153e06f0f9sm823245eec.23.2026.07.30.21.59.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 21:59:54 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Dimon Zhao <dimon.zhao@nebula-matrix.com>,
 Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v6 03/24] net/nbl: remove unused rte_atomic16 field
Date: Thu, 30 Jul 2026 21:57:41 -0700
Message-ID: <20260731045948.769926-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731045948.769926-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260731045948.769926-1-stephen@networkplumber.org>
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

The tx_current_queue was defined as rte_atomic16_t which
is deprecated. Remove it since it was never used.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/nbl/nbl_hw/nbl_resource.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/nbl/nbl_hw/nbl_resource.h b/drivers/net/nbl/nbl_hw/nbl_resource.h
index bf5a9461f5..f2182ba6bc 100644
--- a/drivers/net/nbl/nbl_hw/nbl_resource.h
+++ b/drivers/net/nbl/nbl_hw/nbl_resource.h
@@ -225,7 +225,6 @@ struct nbl_res_info {
 	u16 base_qid;
 	u16 lcore_max;
 	u16 *pf_qid_to_lcore_id;
-	rte_atomic16_t tx_current_queue;
 };
 
 struct nbl_resource_mgt {
-- 
2.53.0

