Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 612D0C7EE30
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 21:50:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3DF2640659;
	Thu, 26 Jun 2025 23:50:42 +0200 (CEST)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id 93FB540647
 for <dev@dpdk.org>; Thu, 26 Jun 2025 23:50:39 +0200 (CEST)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-236192f8770so13103665ad.0
 for <dev@dpdk.org>; Thu, 26 Jun 2025 14:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1750974639;
 x=1751579439; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6RRR9eA/VjkaYicI9/HIE4oyEG75yO0SDON1FiHsu8A=;
 b=0Ww2+zhqVrN48+v5UeMQPMyl3hKuLCjKlWU/xfwz+UMcIbfyNrHJjcu81zXKOeKIju
 tHZ8KdLjLdVTdnZ5eBOIr5Fk1bY5cRLnSEpiPa3meaP5Zu90mkIz2ZxFef4RD0+15g/t
 tfVcEC8fYTURzu7zkpfFkyP1iiNcngi7//1+KNVx0693w3XH/wQJPTE9/LKYL39WvpQn
 Dd3UQeGpUg9ey5A5pfxzQxy1w6cejBEr7JYC1UuIQFtpWYtusXeJ4w3nyT5WtqtwXPaF
 iAcMj+AEQQ4HybHhOJhhcVigzEJ/9c1f/sSZxiMFnYc5TbDEHjdX10oBxOzyqT2/ddLu
 uwjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750974639; x=1751579439;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6RRR9eA/VjkaYicI9/HIE4oyEG75yO0SDON1FiHsu8A=;
 b=aK+AgmwVhyrovmXqnLmjJaQTpvkV+USRCvqaaWiybpuKc5ew8mA635taU03qCa5ANw
 v4WD+SoFcSjatnJFQf1+n+WRdHawU5AlPDxxojMr2F2rht63My7Tc2vXQyVtbkM3f96s
 UfU4LAhiMuFNVntAvUfSV6Tm1snTQnKgA/dumd/NFLkR/4oV9g+iezy1JOEqFLPLreKr
 wDdT7spz7HPi7BwfWkAavnC3skgY6vA94mo8peKe6rwPkSPO6nPU4f9qDozAcXjov2W/
 8rlAgeOAo6nBtCfL4FT9XoGiXHOMDIduzP60kdQGxOWNHwb5dk/vX4IkU4N6v4W/daO4
 bxBw==
X-Gm-Message-State: AOJu0YwPZPkjgBFKhmQrJh7+ltuPMpYpFmZEEve/pDayi+hgZycVneKY
 BOHmeQ/GYKaKaMEUC2YzvNtsTBkw9/rhEhh+gELGDlMASxgz0MLYfelrxxtYDP6MdmY=
X-Gm-Gg: ASbGncv1Bhb+nLKh1URT6Q6jL0ZketoQK+NHu2YaX0c0VEuiSZ2Pei5nQM0n8fL7DMj
 cKtL1+f33kzosVFH0U66W1ivduTrUnbNgL10uABSQSuJtV85oi7i2d4NRs6uHvjRsEYANDwaa72
 wEjPljcDZ0PbmuxzPUm0fplsGBI/pWUXCMSKG+4CwtKl6Hm99bDcdjhGlXTwV1we9cBFIzAF9xH
 NHQBVTM+SS+7lAvMFEI2Dv5HcF0Noblg+O/9JCEdTchQLaGr1GVNxF2dmQZUpJKMMLjX1cT+zjt
 XpN+ddWonn+xorni6120eeEm8FfFHbvtVI8s43nCW3YRTlxpVc9W8zfFm60Lb/83Nzd//RlrIc/
 BZSP/ZlUaHvyJYvaQfMf/TImbr0kGwcxkL6HEBDg=
X-Google-Smtp-Source: AGHT+IFybZP8pTDAUMj+W740o+7GSv0w1qhfNommZgYty3z0uNKpBouPvOiRRpO+sDNqGjyB5l5ndg==
X-Received: by 2002:a17:903:8c6:b0:232:59b:5923 with SMTP id
 d9443c01a7336-23ac6375c83mr8837655ad.23.1750974638707; 
 Thu, 26 Jun 2025 14:50:38 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23acb2e25b9sm610335ad.2.2025.06.26.14.50.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 14:50:38 -0700 (PDT)
Date: Thu, 26 Jun 2025 14:40:01 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Feifei Wang <wff_light@vip.163.com>
Cc: dev@dpdk.org, Feifei Wang <wangfeifei40@huawei.com>, Yi Chen
 <chenyi221@huawei.com>, Xin Wang <wangxin679@h-partners.com>
Subject: Re: [RFC 14/18] net/hinic3: add Rx/Tx functions
Message-ID: <20250626144001.77f2340d@hermes.local>
In-Reply-To: <20250418090621.9638-15-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
 <20250418090621.9638-15-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Fri, 18 Apr 2025 17:06:00 +0800
Feifei Wang <wff_light@vip.163.com> wrote:

> From: Feifei Wang <wangfeifei40@huawei.com>
> 
> This patch add package sending and receiving function codes.
> 
> Signed-off-by: Feifei Wang <wangfeifei40@huawei.com>
> Signed-off-by: Yi Chen <chenyi221@huawei.com>
> Reviewed-by: Xin Wang <wangxin679@h-partners.com>
> ---

This code has lots of places where __rte_unused is added, but
the arguments are used.

diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3_ethdev.c
index 51dd5f76fc..7faf3c6dcc 100644
--- a/drivers/net/hinic3/hinic3_ethdev.c
+++ b/drivers/net/hinic3/hinic3_ethdev.c
@@ -677,7 +677,7 @@ hinic3_reset_tx_queue(struct rte_eth_dev *dev)
 static int
 hinic3_rx_queue_setup(struct rte_eth_dev *dev, uint16_t qid, uint16_t nb_desc,
 		      unsigned int socket_id,
-		      __rte_unused const struct rte_eth_rxconf *rx_conf,
+		      const struct rte_eth_rxconf *rx_conf,
 		      struct rte_mempool *mp)
 {
 	struct hinic3_nic_dev *nic_dev;
@@ -898,7 +898,7 @@ hinic3_rx_queue_setup(struct rte_eth_dev *dev, uint16_t qid, uint16_t nb_desc,
 static int
 hinic3_tx_queue_setup(struct rte_eth_dev *dev, uint16_t qid, uint16_t nb_desc,
 		      unsigned int socket_id,
-		      __rte_unused const struct rte_eth_txconf *tx_conf)
+		      const struct rte_eth_txconf *tx_conf)
 {
 	struct hinic3_nic_dev *nic_dev;
 	struct hinic3_hwdev *hwdev;
@@ -1127,8 +1127,8 @@ hinic3_tx_queue_release(struct rte_eth_dev *dev, uint16_t queue_id)
  * 0 on success, non-zero on failure.
  */
 static int
-hinic3_dev_rx_queue_start(__rte_unused struct rte_eth_dev *dev,
-			  __rte_unused uint16_t rq_id)
+hinic3_dev_rx_queue_start(struct rte_eth_dev *dev,
+			  uint16_t rq_id)
 {
 	struct hinic3_rxq *rxq = NULL;
 	int rc;
@@ -1168,8 +1168,8 @@ hinic3_dev_rx_queue_start(__rte_unused struct rte_eth_dev *dev,
  * 0 on success, non-zero on failure.
  */
 static int
-hinic3_dev_rx_queue_stop(__rte_unused struct rte_eth_dev *dev,
-			 __rte_unused uint16_t rq_id)
+hinic3_dev_rx_queue_stop(struct rte_eth_dev *dev,
+			 uint16_t rq_id)
 {
 	struct hinic3_rxq *rxq = NULL;
 	int rc;
@@ -1199,8 +1199,8 @@ hinic3_dev_rx_queue_stop(__rte_unused struct rte_eth_dev *dev,
 }
 
 static int
-hinic3_dev_tx_queue_start(__rte_unused struct rte_eth_dev *dev,
-			  __rte_unused uint16_t sq_id)
+hinic3_dev_tx_queue_start(struct rte_eth_dev *dev,
+			  uint16_t sq_id)
 {
 	struct hinic3_txq *txq = NULL;
 
@@ -1214,8 +1214,8 @@ hinic3_dev_tx_queue_start(__rte_unused struct rte_eth_dev *dev,
 }
 
 static int
-hinic3_dev_tx_queue_stop(__rte_unused struct rte_eth_dev *dev,
-			 __rte_unused uint16_t sq_id)
+hinic3_dev_tx_queue_stop(struct rte_eth_dev *dev,
+			 uint16_t sq_id)
 {
 	struct hinic3_txq *txq = NULL;
 	int rc;
