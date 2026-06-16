Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32CCCD98DA
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 10:47:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8985E40E13;
	Tue, 16 Jun 2026 12:47:47 +0200 (CEST)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46]) by mails.dpdk.org (Postfix) with ESMTP id 25B7F40DF8
 for <dev@dpdk.org>; Tue, 16 Jun 2026 12:47:46 +0200 (CEST)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-461a5a39da1so292999f8f.2
 for <dev@dpdk.org>; Tue, 16 Jun 2026 03:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781606866; x=1782211666; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6NszZiya2bLdBjmKd/u/w3EGB/GsfGxaZV5rsEIgukw=;
 b=ahgqoLJjZxAwnz806RxlYoi6TdUUy+wJb8wB8lHWrcglBouLPNsv4Di990SexsAFeW
 RcEsVQfYIhmw6WIaJixva4KR9pVSOppsZDckqwVsF3icYdjyv2AB0viJYa2gpsmWMqyC
 cVgEaYTsZHQd1T3yA3CoNEJ0Ypud4gXDSQ+MtmTSE9mEKENey8MeysSc4KYqT2tWg4hX
 KTyq2xili56aM6bz/fpy3oc6OYesp2QmVtGbgX0h59Nd+lAtdDpOphEjYnGDek7mMAHT
 NHfNsBbizhP3ScuymJIk0ErMWhsjh1631luqLwuzhUGEyR5s5NBhCyFXZ+YpmdRx0BLi
 2oRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781606866; x=1782211666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6NszZiya2bLdBjmKd/u/w3EGB/GsfGxaZV5rsEIgukw=;
 b=m2LCpgnW14hN4fdM9PQS/VB09YerXK1y/3gmiqm2IfA8IYfGEDzOLXPRqSzh8xKYNj
 41IWVT6p1IjQQghSgp6lBn54jES7kxZToSKFlZNNEppjS1lgE+UekRsPj2N1okJw9Xv7
 pE991Zemmmiz/TRfPfncyn3ma5hAeZQ5XAFPu2+u1EHsUEFB6SZnHuKbr3chPPOq2SlP
 oemMOfAwfgpKj7JdMalKgMs1RkcE787q2Pu6+wh7VtKOz4r4VODqRt2nwX6RnGI/DDYD
 Kstnb03ahee55T8wAlh5b+rXo9MZhLUkF0hliXFLQJS07Xr7QPnRbrO4VLRyt8yyPsOv
 Vl7w==
X-Gm-Message-State: AOJu0YyaCsa/TO+2xd1yjL8e+G0M7u4EHITR75d4o2/T6JgSbh7xobxj
 7WhIjRlFqAPjmo15YtGmFTDmcFVGEhoFUsuEd7yfyeyCDmddjjNWJK+8jlxE3SNk
X-Gm-Gg: Acq92OHb0R5sgTMS1q7RuayO5iCVbR15vmADE9Rz2BzEi4nZ062OqAsyfEEreWI86dB
 VU+8lUn+AyQyWMlUgquFAjpu6l0HthU5Xd8J5pf5wJeXAtZQ2qYoOkOjzp+z8fMciYH4mUAL+lY
 WKXO0cB2vnUGYB81hB6MBY2DSXSDCs73rD7yWDvGlVCnjvVk0z/b6ZazGZNZvO2ApXZsO4CcbxA
 5QDzFDnd/WLUXiARi8O1LFSIWMq7S26yw4I673Wx9+RwrpTWEjkb0Ai5GADcz16dnXtjTKDoQjR
 aRk//ienLKN1RckZLVaSLHS4hu4/HyH3zfuwe7iQqUwQH2u9+kY8N3y+atLkhakD1BGPNdBqDsj
 P5PwpVnlyMa/DZiBUDyN3hFXzaUP0tJ6+BC/lpc57lmhi7aIkdX8B7058eDUSqDuvycYT8fx2my
 cvhrCH6qOwSsVS3sYG5ylml22U/5qqjS+6vWgzrwKPqrgmAWugb1Ss
X-Received: by 2002:a05:6000:1a87:b0:461:a19d:31c8 with SMTP id
 ffacd0b85a97d-461a19d3414mr3401746f8f.39.1781606865693; 
 Tue, 16 Jun 2026 03:47:45 -0700 (PDT)
Received: from freepad.iliad.local (free-mobile.vlq16.iliad.fr. [213.36.7.11])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26f309sm40916009f8f.14.2026.06.16.03.47.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:47:45 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: Maxime Leroy <maxime@leroys.fr>, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH 3/6] net/dpaa2: drop stray extract count bump in RSS key build
Date: Tue, 16 Jun 2026 12:47:12 +0200
Message-ID: <20260616104717.723087-4-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616104717.723087-1-maxime@leroys.fr>
References: <20260616104717.723087-1-maxime@leroys.fr>
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

The IPv4/IPv6 L3 case bumped kg_cfg->num_extracts once in the middle of
the loop, while every other case relies on the final
'kg_cfg->num_extracts = i' that overwrites it. The increment was dead and
misleading; remove it.

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 drivers/net/dpaa2/base/dpaa2_hw_dpni.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/dpaa2/base/dpaa2_hw_dpni.c b/drivers/net/dpaa2/base/dpaa2_hw_dpni.c
index 4df66d8f33..f1d670f213 100644
--- a/drivers/net/dpaa2/base/dpaa2_hw_dpni.c
+++ b/drivers/net/dpaa2/base/dpaa2_hw_dpni.c
@@ -397,7 +397,6 @@ dpaa2_distset_to_dpkg_profile_cfg(
 					DPKG_EXTRACT_FROM_HDR;
 				kg_cfg->extracts[i].extract.from_hdr.type =
 					DPKG_FULL_FIELD;
-				kg_cfg->num_extracts++;
 				i++;
 			break;
 
-- 
2.43.0

