Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD76C5DF7D
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 19:31:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AFB1840E45;
	Fri, 21 Aug 2026 21:30:38 +0200 (CEST)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by mails.dpdk.org (Postfix) with ESMTP id 73E9540E54
 for <dev@dpdk.org>; Fri, 21 Aug 2026 21:30:37 +0200 (CEST)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-84a2c90e383so1843413b3a.0
 for <dev@dpdk.org>; Fri, 21 Aug 2026 12:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787340636;
 x=1787945436; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KeuSAIy0j/sL9f1f59AKmKFJ3B1k11xveherJjb1q3A=;
 b=DcBsd+zRbRn2Y1FCbB7fjH4d07n8DcmFdsfA4AYbwpQDbcZCzSV1jUbqmGgJPQKtbZ
 jhvsmdn70TH1vLjSdm1ezCjUQPWEmPXqQNitWMK6lLfsX9L3TBsu8/80uH3CHHEUHzR0
 QGA9Gec5SGMWVv1iG6LY65/W8QSurG8hrSHIKEh03BFw8u2h1e6KRHUYVfIsCBMFudUF
 ej3SRgllXuo2ootCyXiQOKNgY3C1Y2SQjnHEXH+z32eLz7RbGnlm/upLAfUbbkG6Fp18
 euSZb1tI+130USZ+DbFQoDNLSzBRJqe5EqZoqxZkMDxud30GltdrT8KsJ34iE0ntn//Y
 HVyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787340636; x=1787945436;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KeuSAIy0j/sL9f1f59AKmKFJ3B1k11xveherJjb1q3A=;
 b=lCcaMxQLHy9dlohkpsbIVf76WS0eRhTzf8WtZr6mCfI0490E74TQCpWrXO7kY2CWta
 FMDKzNlPVKt9fB6pXIOkaYFHolFJDKH9+qCeHRV5ysjmtzwjiJe7LqhNUAHAHiPB2Te4
 Y7Qi6ibfDcO7jVe+p/EOFxuRyXoERmR6V94uXZYg90DRT9HpF7zYD71KGklPH9KnpryZ
 TNTyUbSQUPczfpom3wgtEfTGxgU71RFVtxsfZx3O45tQsrllJKqq3Fs0iDtI/DMN9w1s
 mDRT7IzbTTI5+vMGcVxa7lvAUVupLJPWB+B/vGPmJUG0uqx2laAfhZdttQQeXv5oGrha
 JhkQ==
X-Gm-Message-State: AFuF++lDqf5D9H27YWaNUbXjn/tiobtxtF031SZM27/qndH5drCX7UKI
 uv4lSW4UloUOKB59qC4NF5O7WOG2+AVoLa1zioQHeBM5JJRVmi58PlMW+GHKYWpbdPheNgjKO/v
 yd6WXk00=
X-Gm-Gg: AR+sD10ehtIrwuUqWbDOrBPT1yueCjWLRNx58iJKjQET0qFIzVgd/W+mvlO8d1UCEBk
 8We/dIcjuATS120iW9ZmiO5adbzwVYMw5n3PQ215PvgYCsHzpBT1VzrMeMlRdFOI2+b7Q9poh56
 P/TGaJ7boAenMMBPqi2sJ+W2M7C8/oHONrqiwpOFJ8FzPjrHxY+jhKOqqmsXAHvSPuXRiGfpLiY
 L8/MxTU2iVNKdspISK6Zu7687X/Sn+Ra0cZA47UOzsgqkjv7OUZzhHrON/gLuEVkk2GHNGCBZne
 ZtaA/mZHlZjzu38MwOcCU6C5vmR4qg7yTYh69IVn9n2bJ/ZQHwK+31OiEx9XciVGSIkCl3HGEEc
 6XqjwVFgfZWUfj0x6EbzT1WfoWn8a4y2f5IKXrFfc/85VouDEcBrA00MTPTdxKqAtMHwnnf2ngT
 7JBUevH/2uM2oqqZGoxAIJXqnLjM/zfOFK+sVAB6cyc0fASoKX70Uco0M4gPh4GZBlWwUr6+eFc
 gy97a4Oc5xShX7KvqDXVFOvZ14=
X-Received: by 2002:a05:6a21:3a46:b0:3c4:3672:b86 with SMTP id
 adf61e73a8af0-3cd3180976dmr8627326637.3.1787340636623; 
 Fri, 21 Aug 2026 12:30:36 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc16c6dd2f4sm1860304a12.17.2026.08.21.12.30.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 12:30:36 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Devendra Singh Rawat <dsinghrawat@marvell.com>,
 Alok Prasad <palok@marvell.com>
Subject: [PATCH v2 45/68] net/qede: replace use of rte_memcpy
Date: Fri, 21 Aug 2026 12:24:40 -0700
Message-ID: <20260821192646.146382-46-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821192646.146382-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
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

Don't need rte_memcpy for fixed size value.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/qede/qede_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/qede/qede_main.c b/drivers/net/qede/qede_main.c
index fd63262f3a..32fa2016d2 100644
--- a/drivers/net/qede/qede_main.c
+++ b/drivers/net/qede/qede_main.c
@@ -180,7 +180,7 @@ static void qed_handle_bulletin_change(struct ecore_hwfn *hwfn)
 	is_mac_exist = ecore_vf_bulletin_get_forced_mac(hwfn, mac,
 						      &is_mac_forced);
 	if (is_mac_exist && is_mac_forced)
-		rte_memcpy(hwfn->hw_info.hw_mac_addr, mac, ETH_ALEN);
+		memcpy(hwfn->hw_info.hw_mac_addr, mac, ETH_ALEN);
 
 	/* Always update link configuration according to bulletin */
 	qed_link_update(hwfn);
-- 
2.53.0

