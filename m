Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7098C88E67
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 05:53:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B14C040E25;
	Mon, 14 Sep 2026 07:51:24 +0200 (CEST)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by mails.dpdk.org (Postfix) with ESMTP id 01ED440E3B
 for <dev@dpdk.org>; Mon, 14 Sep 2026 07:51:24 +0200 (CEST)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-cc1bc88a20eso4056898a12.3
 for <dev@dpdk.org>; Sun, 13 Sep 2026 22:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789365083;
 x=1789969883; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bmT9kKYIpXqADRIXi1MNEXuZvMGijg2pnmmmzBi9wts=;
 b=S1Abx8jF1J9avUnMnoHhKJmLKfCWngDA9VF1qj5MJH1aW7dWD6HzbiOPsJ6jrRtEBh
 W5cgxHu9EfFyBkJei1s8+QgXkjzNxiSy66TOUvAfkcCLTXnLlK3ttBDijWWpYULKKgex
 hVkRDQT75fQepG4YKWfBbL38YReQKjjY4P4edP9FA6D5gdeRFlmSiyoYfcHal96V6PRO
 5aeSd+K6MjkfE9ClNaKJVuY1G8zUxdgL2PCwrOqPJ0KoPUSORjmAeJ2ZpGiQ1lbEfYsL
 nDkGf4kQdB8F5XIhz24zLAZkmddhIaE6rHfpB4x5Dj8LXzJRvxzps7g/vez6qvHtmPea
 /vzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789365083; x=1789969883;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bmT9kKYIpXqADRIXi1MNEXuZvMGijg2pnmmmzBi9wts=;
 b=P9oEtpeKKX88G1HU5MkocDrCYED6tAjLrkp00SKrLkQqvE4ucHjDgy1kQvfRumhpAF
 NsvjSvl8W9Ik1yFyKPJFVCHbUASUveGblpqvyvrLuzy0xNK1Rb7gK12SEt+cVfmu2ISI
 U/JbfSlSuO28dv0MeJG3eWH1uR3rcIcSFUsDneAOhi9cb99zxh7gzYVcMctG31v3NpGO
 nzdTbPahpaPMof4r2lWPuEuHVJtJq2Fr+RgcnnFh/FpiuJ4xCQL6c4fkCniS08tx0l7P
 ik4sFiw0vFjXfY4+8wU/y85Nha6s+Zu5lzcbm9G3K1Dh/E65Pxwriw2AkrnUJ85tRDWu
 C2Jg==
X-Gm-Message-State: AFuF++k8l3NmLeVBc9ANKuAn7JQ1KfpR7sh2Q3JQUIS62QUjgvXwoVaT
 vRqtsPXXfufnu6ggTc/ukHjE+hSnOg0VwHALNINVQVOOk3QA0jPX8gyN2bo2Px5jeYS/Qpzeehp
 TuepZKa0=
X-Gm-Gg: AYBFou0+FBSPfI7BAYPfcmVy03vBVJm8MMYDvRXv6CU60RwwddQ3PPRDkx7VnB4cu/r
 ZxUY350jBj2+YLNt7Q+gYmWrxpcUDuCNAvw8gspmyvmT7GLaUzshdMSc3efVz3rZ4/PKvyn72AV
 YfjsUZJx/EEWQ2GV5ga5hb7xhuaA3nr5xtMf1umvvjYjt/Pm6KptuelNzbP/UMCfjVLb7bbmfbA
 Ix4kaEHrlYM68TwshxWqWYHGjNumPdaxalQVNFzEEwIUpWMiFvU49lSaxn3GW3OCzr4nK76UaOM
 XiA41yKAjVjTgvNZwyw9nZiWLJiBHHJ8rUg4DrV28Zgfit8I0eLc6okEbt8834dCcf0qEspH1/T
 iFmqXqaDUMuaQUjGXvGFbLMpftOGG+JeHg4XP2g4M/ERbQXELS2vwKUbCIFknKg0fvGBhMgmxHN
 BawrglKBG7mRKm2cg1L3gGfNd8+gyeebxj6fomBneLDNsjmdPwlyohI8NYx9uWPn7t+B9KiqYuy
 Hog0qARUl6kGVTBhEbBNR8rF9SsX6ZJSJrxgg==
X-Received: by 2002:a17:90b:1b01:b0:39d:e213:9dd3 with SMTP id
 98e67ed59e1d1-39debf6cf03mr2493047a91.1.1789365083093; 
 Sun, 13 Sep 2026 22:51:23 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d95864b4fsm19794492a91.15.2026.09.13.22.51.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 22:51:22 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 36/62] net/i40e: propagate VF queue number parse errors
Date: Sun, 13 Sep 2026 22:47:07 -0700
Message-ID: <20260914054912.755403-37-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914054912.755403-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
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
index 3b17281952..a218e9f05e 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -4834,6 +4834,7 @@ static int i40e_pf_config_vf_rxq_number(struct rte_eth_dev *dev)
 	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
 	struct rte_kvargs *kvlist;
 	int kvargs_count;
+	int ret;
 
 	/* set default queue number per VF as 4 */
 	pf->vf_nb_qp_max = RTE_LIBRTE_I40E_QUEUE_NUM_PER_VF;
@@ -4856,12 +4857,12 @@ static int i40e_pf_config_vf_rxq_number(struct rte_eth_dev *dev)
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
@@ -4871,13 +4872,16 @@ i40e_pf_parameter_init(struct rte_eth_dev *dev)
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

