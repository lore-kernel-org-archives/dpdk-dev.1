Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B15C83038
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Jul 2025 18:39:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D45540E25;
	Wed,  2 Jul 2025 20:39:14 +0200 (CEST)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by mails.dpdk.org (Postfix) with ESMTP id B53404064C;
 Wed,  2 Jul 2025 20:39:13 +0200 (CEST)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-7425bd5a83aso4494385b3a.0; 
 Wed, 02 Jul 2025 11:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751481552; x=1752086352; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z4lJBm9Ea925L9aCAF46pUSatyDOpkSjUFIj/DaVnLM=;
 b=POWiXaRO4NNJu64Xa3rmUKituHA3L9Aul2g6aOcFoGUD9gDqEkuONCAu8jbLuqDr4q
 GbkwNsoq3laoNacBuVqc9F/aVCwj2HWvV1yXw6TksFk3ia5sb2LnrDxdjFFjtfjM9Wvj
 TISqHjAmk1thMQYJSLYDa7z20/InWTh8vpQ53aTzIp1J6pGBHCS0Y9RL1UHp5OpzDOb+
 RlKUIolCgdomWz/5pKWhocMh50aBin700QeHeA5nRVywpMEsC/9uCwdU3GhIdO0LOpBY
 0WTGtqegRmAQFm3m2wnXYBq0J9LgW9PFiNxKdkN9ta6sNJlwsOQUzelHlPZmqPYTCMHK
 PrPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751481552; x=1752086352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z4lJBm9Ea925L9aCAF46pUSatyDOpkSjUFIj/DaVnLM=;
 b=fqTxEzI9v1fVSYAdJaGCsUSQ4g2goxICP/eV+h2kvulUL7/jjnxPalIA8TGIPpdXWV
 55bFQXfF5J1aOAP0zvfsK0tKfRLrVMct/zV/S4w+8TWYfJlMjCht6hv5uRFAwzm7f4EW
 oapL/Yy4dZfDqHw0l0OJyL0bbjqWqWXyX299ZUYx0QVwr451lfwBhof0773WqcofcNYT
 a1MfHzUlgHY4fbP1u6kRPZavhiWqtgPG70RBgAXOHEq/ZII2cb5GnvOlGgxNHsBVDpRW
 I7u44p23vWqeAaBAJm3rkhvFUN0Qo3C3P5f/OgMBnpGca9eHxp94ZXofzlsy+desecDD
 skNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8EhGgSh4t6rEP48N5/dI/HmrZmWEQRr/q8NrYEc6fbTJeAhHiT1z7tA4wQHph9moD0xdg1F8=@dpdk.org
X-Gm-Message-State: AOJu0Yznky56Z7o1z4iALCOJ7IYEoVUnZskMT+9487NeNsvATSOATxAu
 YWCRKDNti/FI8z2aNw7lJp66DPTVes80qwX2ewQaFVshpyoWghWYLVMGZJCYrOK0
X-Gm-Gg: ASbGncsDZWnfqcrX38bhXjiiMfNXSsriLt0vBwdRI2E8lxU5+H6V2D2ZGE8VU31qxZv
 08PgoHJaJRyN2VVfjgfuLXYt/7sKjGblhnrpLVC1wC/MW8Wc8jGZ0IxOQUtxNJr5x1/YtGDih8D
 SOQJ7jf0ehCknhGXtcYwqrL4XhuhH6jGRiQvclvBfjJrBb5Rr7F+me2zPEe9WvGJTQ5hTalTd6K
 t16l1iRnouI9time61yxBDJ0m0/8A8Y/OKQKBr5WdvyAfW/F/wfnn4umwPs9gvlVmd+3JSoNhfV
 vrGZddIQ9ulwNi9VZyC5eqDedz/G5/nwAszB+qvQp9nQHqvVW0HaEa4sGXrzKaomOZgU5NRRx4d
 40YGxtMqC5wJgU3zybXjnagw87+VzJBpFEA==
X-Google-Smtp-Source: AGHT+IFh24X1kAg91VFwqQ1svJvVq/dMYDWKL/x7GLnJ1uoSdHPsK75J3266gGKXYSiY8dgWxQ69Yw==
X-Received: by 2002:a05:6a20:7486:b0:21a:ecf5:ea71 with SMTP id
 adf61e73a8af0-222d7df07c0mr6932781637.15.1751481552305; 
 Wed, 02 Jul 2025 11:39:12 -0700 (PDT)
Received: from localhost.localdomain ([2402:e280:2162:53:bd13:dda6:5d:6065])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b34e300452dsm13513009a12.13.2025.07.02.11.39.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Jul 2025 11:39:11 -0700 (PDT)
From: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
To: dev@dpdk.org
Cc: amiyaranjan.mohakud@gmail.com,
	stable@dpdk.org
Subject: [PATCH v3] net/iavf: fix VLAN offload strip flag
Date: Thu,  3 Jul 2025 00:08:56 +0530
Message-Id: <20250702183856.99326-1-amiyaranjan.mohakud@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250702182251.96427-1-amiyaranjan.mohakud@gmail.com>
References: <20250702182251.96427-1-amiyaranjan.mohakud@gmail.com>
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

For i40e kernel drivers which support either vlan(v1) or vlan(v2)
VIRTCHNL OP,it will set strip on when setting filter on. But dpdk
side will not change strip flag. To be consistent with dpdk side,
explicitly disable strip again.

Bugzilla ID:1725
Cc: stable@dpdk.org

v3:
- Fixed the vlan(v2) scenario by calling appropriate api
- Addresses Bugzilla ID: 1735
v2:
- Fixed indentation in commit message

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

