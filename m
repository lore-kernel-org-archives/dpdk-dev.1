Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309D8C9830E
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Sep 2026 16:18:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2D652432A2;
	Thu, 24 Sep 2026 18:15:02 +0200 (CEST)
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12]) by mails.dpdk.org (Postfix) with ESMTP id E4F3443274
 for <dev@dpdk.org>; Thu, 24 Sep 2026 18:14:59 +0200 (CEST)
Received: by mail-pz2-f12.google.com with SMTP id
 d2e1a72fcca58-85469a34907so66692b3a.1
 for <dev@dpdk.org>; Thu, 24 Sep 2026 09:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790266499;
 x=1790871299; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OjsU9ICYnzDFkyQhKfMfbUE2EWhF1sodRQujlRNC00A=;
 b=OUiNEH8T0lGyAFDpt1mmDYYVrAyqcsw7/bK/JFwLwP0qm1dMAi2zWuyXses1PI+5gi
 W10TY/fEL1i6ewPm5CR5UacwkiVZP4JVn4ST4I9tWW5t0dLD1qLmAWoRy6Wjvjb3LEKf
 XHU84V0colq/WOJXLOY4h7VDLhxyKYqHGKA9ZHGXpB5itwQpGjljv8wcukqscfns6YIB
 hc/jpzSuUfhskrCMiu3M6FUtZI7VDnQ8nbhdDA7ZCaw+RS2xKtH2cO8rB+a0SCac7Hrp
 SBjoC7FYUI2h3pINsyqBhDKlR/pkOcXx1OSqXfqP0isTStBgTsG4Xcg/oVEfRpVdV3gy
 Xkpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790266499; x=1790871299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OjsU9ICYnzDFkyQhKfMfbUE2EWhF1sodRQujlRNC00A=;
 b=D4bF/YI+TFd2g2B+ql2fXxlBuOFS5KX2rw1ZH+OzXeGJCeYh8vSPZkBMJ9ZCt6AIL1
 tU9p3CY3sbQ4RTyUjdhoQIaWtvgJP6GNaRzqVXnsFnHuVxKR2hpqVj83DMR6raWU9iz5
 wyV7YJUEdnsIqwldNVZuXHdX6nd6d017hKCDhZV/cPD7bm4uDddY79DmNlZbbOuV+U6V
 +4rmMpwRKq1IUDYLXYm6w4CHmD363Jh0YzFliFkiCKAXbi0gmDdqjBQCMQQk5C9FpD5a
 E/y7tOw+QNXTX1dD+PQtX3tjVRLdxLYVZS054kf4UZOhbGKDkk07Z+aPJPK6+9aMHVEL
 jcVg==
X-Gm-Message-State: AFuF++mjceZ+KoFHT4BX6+PwSUJS04zmBHYE4m/B6eQCyqkD9JlUtRhE
 VEGDOLSRemD3zJJ4BdyRzfrp048fZVD7PDFiKKZ+wZSnB8+TB0Es3dT4gJSQjH9nWpkA8KxU505
 D/l+Xfq8=
X-Gm-Gg: AYBFou1Ijr8OBvJzgYPTsMPdYzwtRDjawpyi96bSvWrwmjFbI5EnswqBXXtAGGXx7tQ
 CveIob83i2hbtvRPA80pdaGwLsb0MMBO2kMV7qX0DFcWC+mU/Yml7SNSG8/NTdUb6BDkZ2jWj8O
 KkMI6/V/65pl9fDlXPOdwU5Pr+OQ8KeaVfOxSeC6cnRE9nMUUKue+8aGQwbZU6ZclGZuA70GZAc
 DAzkRMo3lrddUjHn77Xdn/iiiV3xCyaFJir0uoSU8+DLIYwmdMTObGyaYhMreTTkdLWdJzRFaxV
 AcZAK2i9yJiuHOPH5wVtxjSbaowZvndxj0iXW84iPNYFSXFfuqZUhfh0wrYHuLd2bWP1ti3qnbA
 pBKj7+4d90y+Xi/f5PhM858CnyjMjNU93rbmAijvbVv5wyyb83uk3yAzLndKMxRn3sqvFO1n5uH
 s7NQDsJQrZ+w4V20/3TA+gn1h5hW6d6qEJQhCzKmQ4Pcz2WgpJjEIG01XRWrMViFCHzp6wKoeKG
 xwGeTLYipd32WriHe55wwc03T96AznLKCnXRA==
X-Received: by 2002:a05:6a00:4c9c:b0:878:34d7:6982 with SMTP id
 d2e1a72fcca58-87ea0bc854cmr2399951b3a.48.1790266498892; 
 Thu, 24 Sep 2026 09:14:58 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87d1d5c163bsm3367534b3a.28.2026.09.24.09.14.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 09:14:58 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 1/2] net/nfp: remove redundant link up/down stubs
Date: Thu, 24 Sep 2026 09:09:23 -0700
Message-ID: <20260924161104.335111-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924161104.335111-1-stephen@networkplumber.org>
References: <20260924161104.335111-1-stephen@networkplumber.org>
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

The VF ops nfp_netvf_set_link_up() and nfp_netvf_set_link_down() only
return -ENOTSUP. rte_eth_dev_set_link_up() and its down counterpart
already return -ENOTSUP when the dev_ops entry is NULL, so leaving the
fields unset gives the same result to the application.

These are VF-only; the PF table in nfp_ethdev.c keeps its real
implementations.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/nfp/nfp_ethdev_vf.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/net/nfp/nfp_ethdev_vf.c b/drivers/net/nfp/nfp_ethdev_vf.c
index d81a5052b9..1ed86cfc9f 100644
--- a/drivers/net/nfp/nfp_ethdev_vf.c
+++ b/drivers/net/nfp/nfp_ethdev_vf.c
@@ -144,19 +144,6 @@ nfp_netvf_stop(struct rte_eth_dev *dev)
 	return 0;
 }
 
-static int
-nfp_netvf_set_link_up(struct rte_eth_dev *dev __rte_unused)
-{
-	return -ENOTSUP;
-}
-
-/* Set the link down. */
-static int
-nfp_netvf_set_link_down(struct rte_eth_dev *dev __rte_unused)
-{
-	return -ENOTSUP;
-}
-
 /* Reset and stop device. The device can not be restarted. */
 static int
 nfp_netvf_close(struct rte_eth_dev *dev)
@@ -203,8 +190,6 @@ static const struct eth_dev_ops nfp_netvf_eth_dev_ops = {
 	.dev_configure          = nfp_net_configure,
 	.dev_start              = nfp_netvf_start,
 	.dev_stop               = nfp_netvf_stop,
-	.dev_set_link_up        = nfp_netvf_set_link_up,
-	.dev_set_link_down      = nfp_netvf_set_link_down,
 	.dev_close              = nfp_netvf_close,
 	.promiscuous_enable     = nfp_net_promisc_enable,
 	.promiscuous_disable    = nfp_net_promisc_disable,
-- 
2.53.0

