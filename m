Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C11FCCA5FA7
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 16:42:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3A65442EFF;
	Tue, 29 Sep 2026 18:39:33 +0200 (CEST)
Received: from mail-pz2-f38.google.com (mail-pz2-f38.google.com
 [74.125.228.38]) by mails.dpdk.org (Postfix) with ESMTP id 23B9A42E99
 for <dev@dpdk.org>; Tue, 29 Sep 2026 18:38:40 +0200 (CEST)
Received: by mail-pz2-f38.google.com with SMTP id
 d2e1a72fcca58-88272e1d069so1990872b3a.1
 for <dev@dpdk.org>; Tue, 29 Sep 2026 09:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790699919;
 x=1791304719; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=T1u1dmx56QXBdGhV1hJdxoyeXoF8C8tMMLq7uWArg9Q=;
 b=lWDw3H8hDkR4+PfLVKny13YAtyA16u/RPnv6BXLMLetMe/Y0A/WioWSay4Ovjs5lHP
 eb5CK5qeL9H3HCxJLU0J8WXIpfN5rwfXgcIn744vl9KLOxXc8CcRaIEzoNU/OIVTlDMC
 xfbDXw4ES4DfqxCo5wDj5KmXm27JatzAAhMnqgLtI9JoQl1MSt8dGeTnGMt57OPPvMh4
 E08smKyyRwJw9qYLVlWQEzxCUMczMIeC9jhvU/XDOXgd2Y4Cni3+Xw/YBqbwctDEysUb
 61WH3FlX4uLnLMwBw3thhCktREtra3GszoZxhurJAvgueVFgTD2GsqiWWLjJDmndqyrj
 Osnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790699919; x=1791304719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=T1u1dmx56QXBdGhV1hJdxoyeXoF8C8tMMLq7uWArg9Q=;
 b=uHyfzThnWk0ps2ssUQPgePNuBLO2qpsyQXByEpmdMwZh9dBJGn6FAPP/wYEuv4DmRU
 Kfyw2ASsBXuxIO1aLP+QrYgwcCnqHXxpKRTQMxGGaowNb6yLzWRZVcGXlYLp+5ZGpD6p
 mqJTm6OnEy21cJilKyi1iWWVmcsEwvt0MJyhEwHPpjFVrA+tAJPEulS03erxFMpUSVdC
 xIbyi1slW0Pgaprf5qad4NjT9UY6kze4+3BsY1QFI31BeHlsc413Zl3ftSAoHwiRvx+n
 El/RABaMEwYy1upk+YD8i8kKSksf21Q1Y+S3gnDs9oTIM8l4X+AEcmQtoO25+e5ULOZ1
 fg1A==
X-Gm-Message-State: AFuF++k0QDJumwpw+W7gg3AuRtWs0SuYvrqsXeJPy2S8zQ9ffxaZLpnw
 YcxtYvahXo5oxPVnWnJoEvDrQprcbWg58y830IPX8qkin9ZBx+K0naFIty/Kvjln+QW5W+CB+fV
 qSapatnY=
X-Gm-Gg: AYBFou1Q5EX+mcAy7JMAaimQw8VYPjVZpf3i7YcCkgeoaSzA+v8iqVv+O3Cb2229SEl
 T+EuFkdlRN1IuUxUSDTx+FQcGVSPLXz8TTbc7UC9STQFAlqbG9nMDpJIla/J82Y9IPw+NT6V6qZ
 Qpzz0qzfuf9wFUzkOWptpoCdUaUzIAW/2Pq+b8Y01w84vgKlzcN0NtKm7eH/lCXEa01s1Chpclw
 3Q9nvnvhcvw6gYitIztCEgaERhAH857yoEzEo5kgLrVcRZDN2nHb5nkrCs1WYmtssfjFPEzueyu
 bcaZWA7hwRKIAaGgRpAJOHbOhLKm+JbrRIAS4IlqsJRp52vqpLdTJ53k74wy++tu+74jyryF5rW
 +AF4cDIH/GWmkHf3oKdB7eahZtT1xAcWLU3QZhmnnzKarby02g02BWQTPlbAVdy5LJ0kyPISklj
 jCNiGNIAOdPmhWRHMrcms2m6Rhcr5kD0v29OUbd/8yBKuesqjlopi85SI6Nl9WkHnJPnHg+ERFC
 rpzZwcJs6wMMqlD8YLE/q5vofP3XqG5l6+oXw==
X-Received: by 2002:a05:6a00:6f44:b0:886:43d3:1b6e with SMTP id
 d2e1a72fcca58-88643d31d19mr898238b3a.47.1790699919244; 
 Tue, 29 Sep 2026 09:38:39 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8868ba02d02sm232392b3a.21.2026.09.29.09.38.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:38:38 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 35/61] net/i40e: propagate VF queue number parse errors
Date: Tue, 29 Sep 2026 09:36:38 -0700
Message-ID: <20260929163800.1108305-36-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929163800.1108305-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260929163800.1108305-1-stephen@networkplumber.org>
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

