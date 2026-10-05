Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A663CA5FF5
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 23:51:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E60CF40E4B;
	Tue,  6 Oct 2026 01:51:07 +0200 (CEST)
Received: from mail-yw1-f228.google.com (mail-yw1-f228.google.com
 [209.85.128.228])
 by mails.dpdk.org (Postfix) with ESMTP id 7DA0640E2D
 for <dev@dpdk.org>; Tue,  6 Oct 2026 01:51:06 +0200 (CEST)
Received: by mail-yw1-f228.google.com with SMTP id
 00721157ae682-888cbacf70eso1840497b3.1
 for <dev@dpdk.org>; Mon, 05 Oct 2026 16:51:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791244266; x=1791849066;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=9uMs4kBY/j1MP0PM1kkkc/VSycvpPVquFcd6SCNz+Zg=;
 b=bkaE6dfvPC9bYjvivHNnnbksBCFXq2HeOPmvp70w/EmfDPyp3xGUDcuedlyu7G7wAm
 ddKQg4k/1Y3nC//9UXul8wGmlDRRJyE73GBjJUxme/gSyJHfVWg6I8gtSuywsM2KfQ2Y
 uP7NanWWZFlIN+Ou2XOtxOzVF92GHhA6LpHx4t72x6dnJKWY5lP9Jea9tgFK022KCP31
 Xf6PVKR3lV6UzQ62z4Np3+csk2bprxTKLk23rS+hm3aYWHLbTwjYtcC307UI3UL2bc+M
 Lw0oncKJ7j6vO/MYmHnfcCo/y5ZOPMbBsbAo/ZNLLDgjNwpe5cjt+U3usTCjsrkzF+1C
 tP+Q==
X-Gm-Message-State: AFq9FYKm/KlsSvjIST4EzfDCB7P2tGDKka/E0IHQZrdCb040ObmYszPw
 vmN6Q9lGh+VazMc7UKaw/VshEKzYBIqOCBDVCJuHfktAdd175L1f6SKnA5H/OtObptigo+TSG9e
 e8t1LAXyrtBvOxkKZSWMt3Wg2y912MtZq61ufEc8w18V/tPJmpJJT2u7iTsjGTX2yDUEdOkVteM
 Il2xnF7+gwKGY5RlSKZIp9reZL2uqyxGbGkZZH8jgRz6jmmrrDJZPWQNA+/N8deqkPx6UcGQ==
X-Gm-Gg: AYBFou1oi2eWoqEYAhu8JWNjTJPYnaHu0V64LOl7dPd8HMztTeYqv4R9M4JOGEvxX+9
 /gODE7f+1X4p2CLInoSEgxGVn3lo93q69NiYljVvKPFTLseO0zfErddNZR0dsomsne1qj4LLHW0
 qR0imFU3RMXy6R4O3f1nO4/3O3YTUhAl0WJYKlQIh6hvlgrqpWNegLEh0SJByosbOdDoGeOxfmA
 tMhCfe5xECziRSVzWWfvmd9C3xNrZIr3aIT2STuPyAfydM8OFNwGPJQIp6EN/ZdexaA+lygmKux
 VSOoqOk6ykkrsvHSNenWzhWRvyJ9wDCQyJTEoRhcBlOtjxkro2D2M/QIgEC93njBfXarNIql4eT
 mjRXkW5E7v8+B/CVZFYbtC4YD/12w/L0i3Cyiaj5xq/sWX7WmnZBpuf77aGILOpqawz6Le3pzEu
 Xw/RM9PE6+DB4GFV/8XV0eoiyRCzFY1+U06EkG1Q==
X-Received: by 2002:a05:690e:191a:b0:677:ce61:dcd with SMTP id
 956f58d0204a3-677ce611865mr1892125d50.115.1791244265766; 
 Mon, 05 Oct 2026 16:51:05 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
 by smtp-relay.gmail.com with ESMTPS id
 956f58d0204a3-677c1b46f44sm1497304d50.20.2026.10.05.16.51.05
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 05 Oct 2026 16:51:05 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93e834ff4d0so165928785a.3
 for <dev@dpdk.org>; Mon, 05 Oct 2026 16:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1791244265; x=1791849065; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9uMs4kBY/j1MP0PM1kkkc/VSycvpPVquFcd6SCNz+Zg=;
 b=N9RdrlHnRMi/+9GldAa1k0sBS/3DWMza3A8vkMMtr8np1GVd+fqbocv4BugdSfqxLS
 XX9XoZ80WUr2H1wQW0kImRGAQHMc04hMjaTbEDCJAFbPdq/XBFbdNHaiHk7mAkf338lF
 XWtgyWWOQIC0CtD4zum0tPs2Dmq0pMYVMHCXE=
X-Received: by 2002:a05:620a:c50:b0:93e:4417:9ed5 with SMTP id
 af79cd13be357-93e4417a96emr2082417785a.19.1791244265060; 
 Mon, 05 Oct 2026 16:51:05 -0700 (PDT)
X-Received: by 2002:a05:620a:c50:b0:93e:4417:9ed5 with SMTP id
 af79cd13be357-93e4417a96emr2082412585a.19.1791244264383; 
 Mon, 05 Oct 2026 16:51:04 -0700 (PDT)
Received: from r740-105-132.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93e4e96acebsm773656385a.21.2026.10.05.16.51.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 16:51:04 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
	stable@dpdk.org
Subject: [PATCH] net/bnxt: fix promiscuous mode set
Date: Mon,  5 Oct 2026 18:51:01 -0500
Message-Id: <20261005235101.27226-1-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.31.1
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

From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>

Promiscuous mode set is only supported on Thor and Thor2 platforms,
not on Whitney. Skip the operation on unsupported platforms instead
of proceeding.

Fixes: c9a3c921d0c3 ("net/bnxt/tf_ulp: support unicast-only feature")
Cc: stable@dpdk.org

Signed-off-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Signed-off-by: Manish Kurup <manish.kurup@broadcom.com>
---
 drivers/net/bnxt/tf_ulp/ulp_def_rules.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/bnxt/tf_ulp/ulp_def_rules.c b/drivers/net/bnxt/tf_ulp/ulp_def_rules.c
index 8ff3c24993..e37ba29488 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_def_rules.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_def_rules.c
@@ -829,6 +829,10 @@ bnxt_ulp_promisc_mode_set(struct bnxt *bp, uint8_t enable)
 	    !bp->ulp_ctx)
 		return rc;
 
+	/* This mode set is supported only on thor and thor2 */
+	if (!BNXT_CHIP_P5_P7(bp))
+		return rc;
+
 	port_id = bp->eth_dev->data->port_id;
 	info = &bp->ulp_ctx->cfg_data->df_rule_info[port_id];
 
-- 
2.31.1

