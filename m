Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8378CA5FC4
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 22:47:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E5C5542EE5;
	Thu,  1 Oct 2026 00:44:24 +0200 (CEST)
Received: from mail-pj2-f38.google.com (mail-pj2-f38.google.com
 [74.125.227.166])
 by mails.dpdk.org (Postfix) with ESMTP id 9C90542EE5
 for <dev@dpdk.org>; Thu,  1 Oct 2026 00:44:23 +0200 (CEST)
Received: by mail-pj2-f38.google.com with SMTP id
 98e67ed59e1d1-3a4e9fbcc60so362518a91.3
 for <dev@dpdk.org>; Wed, 30 Sep 2026 15:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790808263;
 x=1791413063; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=T1u1dmx56QXBdGhV1hJdxoyeXoF8C8tMMLq7uWArg9Q=;
 b=rzlN9iJiavJ3xFvfOFba8cCnl5MwjNuQR4A4gyulPkXjDjha0HB2BLm0/A87SAm9R7
 93ez7gUao+hk9SBm5L4TvWY/ZOrGF97IWSE/H1fqgfDKQQXqIFL+hFLoZ+z4GhkaPut1
 RPVALjRMIp5nyfeEJKzG64BpRQ4MUFoWAKU0qBMBLIRCkeeNZgWjNw9jGZl0PXl7LNhs
 yc5JYqZH9Qpja9wVwd/f9wHRn/ABMg9apHva3XOyB8rdFF1Top3WWnhE2QzKcxePWyGX
 RWinJABahzoIXa4U2yW8AeejX/QeNI/OvjPOKmmrAElTEdqU/Gf7araOQLJvhz8biDIF
 yqKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790808263; x=1791413063;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=T1u1dmx56QXBdGhV1hJdxoyeXoF8C8tMMLq7uWArg9Q=;
 b=C6spf5YipcbJW4XbalXxK9m8ZE78tgRKntPP3cPF1ysFbbf1rl2lrCbIBDChgnMjDd
 CF+C065lWsE/HsoboDRGOrjJSlj9v+SBcd3T1dWMVrXDH/BARm2HB2NYFxkWxzxPwKDm
 YLTJemt4XedkmbuQyFiTqCZWZVVQQsKrXH37dYWVBFXt79PgY9H9xdC/8PLmI+fsX+QD
 b4YWjY4KZXrDKvZ4ou2LydAXv1FIp7csr8TzPJWxFgZubfy6Es1ertOeNh0LVKlmD6h0
 G+UylbyNhP6KdZf76lNMv0SC8ejCbnraUzTNJ6VDDMsE9rgu3tnvJl609y3RSwx3kz79
 klPQ==
X-Gm-Message-State: AFq9FYJsdPhFuG80je/0tbm2/e4YCaQ2TK0Sw8MZsopBqgHPin3DbacN
 yZ6W3hKV6Em8RCLofLZqYVy/ycKu7LVKkZVw1srDTe5PO8rqx4NH33SBYecH6iVfwiBh+i0zA74
 87st6MBA=
X-Gm-Gg: AYBFou2ZUmS1iuvNksYprkjmr3ZxIRzY7nzF4PDC4CtJFtSF5vmxo3Vnk5Lyfsqo/VP
 sWxPBS9Y1vkVbYBsTcmIdQ1LmY9XodHqOszsq+6QTy1ldgfr1Km6rxb9IjWxn1NisBA1SzbNFg6
 KAdLBnpsoBRD0TCAZ2/6kYuf8HmVzYVDa6ByCN4JMohdNlf+Gdm9j88NOM33womVRIJdbEAn8Uk
 Ul1B7E8jTlaAuZviUMtQojfPe758D+Dwn0LHIFfFH+2VsVHC/PjJYK4ylVxm9Pub7pik3QsjOb0
 nwKLoMssaflpOUuiXCdCfx+0ajmZwgh8b+iCHKA6uFrtsecaIRLAsEcILhP4lY9U2cj4ON9I4/7
 dUBIPLdlTRJtZJgoiN93s4Lp+aiP5T3sGFX0YFgiyyYh51zO6AWYyyHe+Q5ak1nUqxUg095Plj5
 Rd+/1NUcNCssxYUbVc5iy5Mhrhs36sDzc/2LLMZv4KDr3jeVOwDMowHNQlQ1krVCoNyRDKPaGKM
 x7M4v2A6QunjlFwDh+pM6JjD+joNEZeG9Wchg==
X-Received: by 2002:a17:90b:5112:b0:3a0:d7e4:c4bd with SMTP id
 98e67ed59e1d1-3a4d19393eamr2186754a91.60.1790808262619; 
 Wed, 30 Sep 2026 15:44:22 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f4371383sm1258985a91.2.2026.09.30.15.44.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 15:44:22 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 36/65] net/i40e: propagate VF queue number parse errors
Date: Wed, 30 Sep 2026 15:40:54 -0700
Message-ID: <20260930224340.58580-37-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930224340.58580-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260930224340.58580-1-stephen@networkplumber.org>
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

i40e_pf_config_vf_rxq_number() discarded the rte_kvargs_process() return
value and unconditionally returned success, and its own return value was
then discarded by i40e_pf_parameter_init(). A malformed or out of range
queue-num-per-vf value was therefore silently ignored, leaving the
default in place with no indication to the user.

Every other rte_kvargs_process() call site in this driver already checks
its return value. Do the same here, so that a bad value fails probe
rather than being masked.

rte_kvargs_process() stops at the first failing pair, which preserves
the "first invalid or last valid one is used" behaviour already
documented in the warning above the call.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/intel/i40e/i40e_ethdev.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index ad826467de..cdbb4d461e 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -4850,6 +4850,7 @@ static int i40e_pf_config_vf_rxq_number(struct rte_eth_dev *dev)
 	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
 	struct rte_kvargs *kvlist;
 	int kvargs_count;
+	int ret;
 
 	/* set default queue number per VF as 4 */
 	pf->vf_nb_qp_max = RTE_LIBRTE_I40E_QUEUE_NUM_PER_VF;
@@ -4872,12 +4873,12 @@ static int i40e_pf_config_vf_rxq_number(struct rte_eth_dev *dev)
 			    "the first invalid or last valid one is used !",
 			    ETH_I40E_QUEUE_NUM_PER_VF_ARG);
 
-	rte_kvargs_process(kvlist, ETH_I40E_QUEUE_NUM_PER_VF_ARG,
-			   i40e_pf_parse_vf_queue_number_handler, pf);
+	ret = rte_kvargs_process(kvlist, ETH_I40E_QUEUE_NUM_PER_VF_ARG,
+				 i40e_pf_parse_vf_queue_number_handler, pf);
 
 	rte_kvargs_free(kvlist);
 
-	return 0;
+	return ret;
 }
 
 static int
@@ -4887,13 +4888,16 @@ i40e_pf_parameter_init(struct rte_eth_dev *dev)
 	struct i40e_hw *hw = I40E_PF_TO_HW(pf);
 	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	uint16_t qp_count = 0, vsi_count = 0;
+	int ret;
 
 	if (pci_dev->max_vfs && !hw->func_caps.sr_iov_1_1) {
 		PMD_INIT_LOG(ERR, "HW configuration doesn't support SRIOV");
 		return -EINVAL;
 	}
 
-	i40e_pf_config_vf_rxq_number(dev);
+	ret = i40e_pf_config_vf_rxq_number(dev);
+	if (ret != 0)
+		return ret;
 
 	/* Add the parameter init for LFC */
 	pf->fc_conf.pause_time = I40E_DEFAULT_PAUSE_TIME;
-- 
2.53.0

