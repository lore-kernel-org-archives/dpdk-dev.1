Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0442AC83030
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Jul 2025 10:20:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D0EC940267;
	Thu,  3 Jul 2025 12:20:54 +0200 (CEST)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by mails.dpdk.org (Postfix) with ESMTP id 07B7240264;
 Thu,  3 Jul 2025 12:20:54 +0200 (CEST)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-74801bc6dc5so660441b3a.1; 
 Thu, 03 Jul 2025 03:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751538053; x=1752142853; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gO1eBxMjsAaYd/HNPNmuJaqypcG471ccO22XIvEsABk=;
 b=WRxXvivyDJDgwGC9vlcQNFBOdtiYz3RxkuLSITUIv0rejuwwrfH291AcvRL5CF7RL3
 oiqLq+RAMCIr//EfcZ2HrvjOOgOY4T6T0/r5he8013y/Ecs1MltoULSbHJWg4lsulpqh
 8I5uiaZYGdiIfYlrfdegS0RGQWCgfDhM8vVdnqQummBGi4vh3jaR6EekZxjurhlBT6ra
 m0SUWt1do7kZqWAg+R8o3JenQ+VePEB8jeFGkhGIvAWjN8SIRYqfoyv0+BSFlBXkdBTC
 nn580C5KNlwz4ewPcHM8484AMlO9Yz3tlI/qptCSNpauzDIqLTuKxmv7EfYVsPYl2tiF
 gmSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751538053; x=1752142853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gO1eBxMjsAaYd/HNPNmuJaqypcG471ccO22XIvEsABk=;
 b=Qim5TzX/4LWuoHg+jJQdM3AQCYWPzoYvIUm8gmBtmWysA7VEbEUDhB3+dUnC96pfRG
 KWJHUECqvBmsJ96NbtguggGO9gztGGBWrqDCEEoGpNVjOvxPZeomS8N9N8lSiSHqAISf
 1TGtJtcBPcNkjeouXtG8n85Tr+1SCl6waIxViL6wc/nMTMfNKwaFWtcrYRjYyB6FUQT9
 uGHXrmI0I65/HhpuLsH31GM6jGv0eHklOhs1SHQNsZFeRw7JiRCZOve5RUEyy6PlPr2S
 iDU3dELzEVWq3IapE61UZtW3TkvgaYSIBRMhIwVpXzCVpkwybuFQgCwOF9emIMrND0Cb
 Lr7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtdfJ+QF9QppLjrYY7Yqq6ec0PP5DWRp5ll8uKw+uIyRBkqXqNKfCWIZUsJVAWouZDoDrXw84=@dpdk.org
X-Gm-Message-State: AOJu0Ywrd6IemmywmPl249ZjM8nnY+rgFjSQRHA7YOz7U1wkc4HtaT68
 3OM1HfB7GyoQFXGdtW4DiydjLjQCr+Tc1uQGrD8TqgTebLkByI7Hk/g5OLrtFvVA
X-Gm-Gg: ASbGnctegWVF+Z+VBO/fOFHrJy1sMg2gmJcLWlD2tZsWIQp6TjFwPfTo5ImGumixjsJ
 YHsJIxvpjhE3yRgYkWVkzCy00rFqwxsNVr/xfZTCxHziP/SfQh+HD89FdADb0DC1tU4IoxgEIgG
 XWgo9B0hLZWTbI1zo1QnfA6DUGbhnceQs+32z+PTpNNm87cKalAv5Q1NgA4CY2K7yzcNPlQJ3On
 TvJ9g9GGMwNPQpIQM2oeNc/o0WX3Y4Ls4LZX1OIC5sZUj3eF0Y95LlboIECaGjC+Tix54htbG56
 0LTKI27Qb2Wenl+aokT1UYBqdZVjWWWcKFG68wYBfVVPPk5RdLIUeImfWO5HlbNZ+qebm0X3S/e
 Us3ecM10i/mbmvIMzONR2
X-Google-Smtp-Source: AGHT+IEHzBoOPb7RrkSpCi+Mwn1FWrVWLL8VVDONXeG1tABiMsE6YcBDhr/bLO2JnbeQakfvdJcnvw==
X-Received: by 2002:a05:6a00:3902:b0:736:4d05:2e35 with SMTP id
 d2e1a72fcca58-74cd56f3efbmr2062641b3a.3.1751538052664; 
 Thu, 03 Jul 2025 03:20:52 -0700 (PDT)
Received: from localhost.localdomain ([101.0.63.207])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74af56ceb74sm16871959b3a.135.2025.07.03.03.20.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 03:20:52 -0700 (PDT)
From: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
To: dev@dpdk.org
Cc: amiyaranjan.mohakud@gmail.com,
	stable@dpdk.org
Subject: [PATCH v2] net/iavf: fix VLAN strip disabling for v2 capability
Date: Thu,  3 Jul 2025 15:50:46 +0530
Message-Id: <20250703102046.10576-1-amiyaranjan.mohakud@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250703084234.8037-1-amiyaranjan.mohakud@gmail.com>
References: <20250703084234.8037-1-amiyaranjan.mohakud@gmail.com>
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

Ensure the correct virtchnl op is called for disabling vlan stripping by
checking if the device supports either v1 or v2 vlan capability and
choosing the op accordingly.

Bugzilla ID:1735
Cc: stable@dpdk.org
Fixes: 3bfad066f9b4 ("net/iavf: fix VLAN strip setting after enabling filter")

Signed-off-by: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
---
 drivers/net/intel/iavf/iavf_ethdev.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index c33fdd9069..335a8126c4 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -1388,6 +1388,7 @@ iavf_disable_vlan_strip_ex(struct rte_eth_dev *dev, int on)
 	 */
 	struct iavf_adapter *adapter =
 		IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
+	struct iavf_info *vf = IAVF_DEV_PRIVATE_TO_VF(adapter);
 	struct rte_eth_conf *dev_conf = &dev->data->dev_conf;
 	int err;
 
@@ -1395,7 +1396,10 @@ iavf_disable_vlan_strip_ex(struct rte_eth_dev *dev, int on)
 	    adapter->hw.mac.type == IAVF_MAC_VF ||
 	    adapter->hw.mac.type == IAVF_MAC_X722_VF) {
 		if (on && !(dev_conf->rxmode.offloads & RTE_ETH_RX_OFFLOAD_VLAN_STRIP)) {
-			err = iavf_disable_vlan_strip(adapter);
+			if (vf->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_VLAN_V2)
+				err = iavf_config_vlan_strip_v2(adapter, false);
+			else
+				err = iavf_disable_vlan_strip(adapter);
 			if (err)
 				return -EIO;
 		}
-- 
2.39.5 (Apple Git-154)

