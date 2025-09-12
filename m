Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 980F1CA101F
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Sep 2025 16:25:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 94BB04066E;
	Fri, 12 Sep 2025 18:25:40 +0200 (CEST)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com
 [209.85.218.49]) by mails.dpdk.org (Postfix) with ESMTP id A795F4065E
 for <dev@dpdk.org>; Fri, 12 Sep 2025 18:25:39 +0200 (CEST)
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-afcb7a16441so321823566b.2
 for <dev@dpdk.org>; Fri, 12 Sep 2025 09:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1757694339;
 x=1758299139; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O7JPSjQMH++B5bBvxOFXK64vpV2MtITydGC/8zNrjTw=;
 b=l8HTXKqjogqDsw4kHvEareSA4yAa+Icdz01JDSOv7m0nZ+X+GUrYy9SaYmCEo4Nk6i
 qrEeuqXmNSXOD+FtpF0mcNPmQNJvEbm5PQAR3IiZ9kTd8CUbRM/L6LD20vlu4LzYWx7r
 ybfgPpqNvDgvA2iDCcdY4UyOonsJUITda0GXAZBO5N61+tcOX72IOV+PL2e74DdBs1hv
 Jg/O2XiwcObRqEkV3P/k7rezwduKp452jtngTQjQdQaRj2nvXMyYRZGzm6oux9zNxXu7
 wIrKo1azS5AGwLgw+ZgbYT5RauQ2Hu/crenbx0IMJcMssJu+ayliOJ9Am4P54WqjEC2l
 fAQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757694339; x=1758299139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O7JPSjQMH++B5bBvxOFXK64vpV2MtITydGC/8zNrjTw=;
 b=rHtMPHeZ9gdVrfIpr2wrcb1VIsGp68UodA3NS57dwWoFZpThgs8yfTWEHrO85lt7X+
 oHuZYBhCdu4DRJji3LQZNT26MVDrMSP0GsrBaXPZrA8SvRc3bZlK+vNAc5//3u6zIU13
 YqCAYTpCopdvhggTtlSsfswCaqGDLF1FCn//+41hOCKls3qkZxrd0ZPML6eZdXd4dfjJ
 bzVndyzE+QKfrp2ulzpmVLJZGVt4RYBA/pBFZmF2wggWw83QyUYQqmvtoVxbQyBfZTmR
 xkJNYzHoETtmRPgZMTA9zPoyZNqjuyShxqptLYRqXEq6yeI4jK/79j02IbUfYPCfMUqi
 YM5g==
X-Gm-Message-State: AOJu0YzvvERgPJf9sd7yCiL6RsWEIZO2KkCmVmd/XrIQUuDvfsSYhiP3
 o8tQ2mL7mkx5Tx5jwWvppsKETzWTDYUOecItzLenJj6r7sc4UjsbbrfkYd6mujj6Yng=
X-Gm-Gg: ASbGncvNtGBNTOjJ5Wh7x8UISoRq0RG3zP7yh4KF31Z6135sOa6rJ0CmTrJ5xOlDFcM
 t+53DPxeHjkT1qzRs+nxmn4tjJSBLb+iQTWAnd6JtBFnGnHwWCeIPefZ5XQKcbMi02uDMS2P1aY
 f0O8gO3dPN3KTcTC4i7ybRXq4Pm2Bo323//2EghK5yT9HrWnCh9n8jVLQJQqGc1EIr2NNQnH8pi
 AjE0aejNLXjJlBweyx5LzwwDXdHS4/gkPyMJoqioUxmGczR9x8ma8/JZSF2l3NJFEMcqrTnkVWZ
 RLS9DOhai4VevvHH21y/pX+V5slVqwYeHtvfefWxQFpBPCvZJLJWKBHGlqHuy6Zc38nXS04U+uG
 rgHtwZjhffzVs/eRe56XRv4JMFb2yI0uWM+2kYAMZeCFluz8Aot+KE52/D8sxG3fyX95uOtrinF
 iJotfMUSqevQ==
X-Google-Smtp-Source: AGHT+IFFqlVD2hXDbAjpBHZ6CDp1MBwyXyqie0+gSuQ7hpNWs4m+5fukCiNh5vwkNxiuJwMdb696kA==
X-Received: by 2002:a17:907:2da1:b0:b04:2105:e226 with SMTP id
 a640c23a62f3a-b07c34ce55fmr379690966b.16.1757694338518; 
 Fri, 12 Sep 2025 09:25:38 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b07b32f1e54sm399296466b.75.2025.09.12.09.25.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Sep 2025 09:25:38 -0700 (PDT)
Date: Fri, 12 Sep 2025 09:25:31 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Feifei Wang <wff_light@vip.163.com>
Cc: dev@dpdk.org, Feifei Wang <wangfeifei40@huawei.com>, Xin Wang
 <wangxin679@h-partners.com>, Yi Chen <chenyi221@huawei.com>
Subject: Re: [V10 13/17] net/hinic3: add dev ops
Message-ID: <20250912092531.770046f7@hermes.local>
In-Reply-To: <20250910134451.15769-14-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
 <20250910134451.15769-1-wff_light@vip.163.com>
 <20250910134451.15769-14-wff_light@vip.163.com>
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

On Wed, 10 Sep 2025 21:44:35 +0800
Feifei Wang <wff_light@vip.163.com> wrote:

> From: Feifei Wang <wangfeifei40@huawei.com>
> 
> Add ops related function codes.
> 
> Signed-off-by: Feifei Wang <wangfeifei40@huawei.com>
> Signed-off-by: Xin Wang <wangxin679@h-partners.com>
> Reviewed-by: Yi Chen <chenyi221@huawei.com>

> +static void hinic3_deinit_mac_addr(struct rte_eth_dev *eth_dev);
> +
> +static int hinic3_copy_mempool_init(struct hinic3_nic_dev *nic_dev);
> +
> +static void hinic3_copy_mempool_uninit(struct hinic3_nic_dev
> *nic_dev); +

You could reorder code to avoid forward declarations

> +/**
> + * Interrupt handler triggered by NIC for handling specific event.
> + *
> + * @param[in] param
> + * The address of parameter (struct rte_eth_dev *) registered before.
> + */

Using docbook style on internal functions is not needed but OK if you
want.


> +/**
> + * Do the config for TX/Rx queues, include queue number, mtu size
> and RSS.
> + *
> + * @param[in] dev
> + * Pointer to ethernet device structure.
> + *
> + * @return
> + * 0 on success, non-zero on failure.
> + */
> +static int
> +hinic3_dev_configure(struct rte_eth_dev *dev)
> +{
> +	struct hinic3_nic_dev *nic_dev =
> HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev); +
> +	nic_dev->num_sqs = dev->data->nb_tx_queues;
> +	nic_dev->num_rqs = dev->data->nb_rx_queues;
> +
> +	if (nic_dev->num_sqs > nic_dev->max_sqs ||
> +	    nic_dev->num_rqs > nic_dev->max_rqs) {
> +		PMD_DRV_LOG(ERR,
> +			    "num_sqs: %d or num_rqs: %d larger than
> max_sqs: %d or max_rqs: %d",
> +			    nic_dev->num_sqs, nic_dev->num_rqs,
> +			    nic_dev->max_sqs, nic_dev->max_rqs);
> +		return -EINVAL;
> +	}

All this is already checked in ethdev as long as device reports correct
max queue values.

> +
> +	/* The range of mtu is 384~9600. */
> +
> +	if (HINIC3_MAX_RX_PKT_LEN(dev->data->dev_conf.rxmode) <
> +		    HINIC3_MIN_FRAME_SIZE ||
> +	    HINIC3_MAX_RX_PKT_LEN(dev->data->dev_conf.rxmode) >
> +		    HINIC3_MAX_JUMBO_FRAME_SIZE) {
> +		PMD_DRV_LOG(ERR,
> +			    "Max rx pkt len out of range,
> max_rx_pkt_len: %d, expect between %d and %d",
> +
> HINIC3_MAX_RX_PKT_LEN(dev->data->dev_conf.rxmode),
> +			    HINIC3_MIN_FRAME_SIZE,
> HINIC3_MAX_JUMBO_FRAME_SIZE);
> +		return -EINVAL;
> +	}
> +	nic_dev->mtu_size =
> +
> (uint16_t)HINIC3_PKTLEN_TO_MTU(HINIC3_MAX_RX_PKT_LEN(dev->data->dev_conf.rxmode));
> +	if (dev->data->dev_conf.rxmode.mq_mode &
> RTE_ETH_MQ_RX_RSS_FLAG)
> +		dev->data->dev_conf.rxmode.offloads |=
> +			RTE_ETH_RX_OFFLOAD_RSS_HASH;
> +
> +	/* Clear fdir filter. */
> +	hinic3_free_fdir_filter(dev);
> +
> +	return 0;
> +}
> +
> 
> +static int
> +hinic3_fw_version_get(struct rte_eth_dev *dev, char *fw_version,
> size_t fw_size) +{
> +	struct hinic3_nic_dev *nic_dev =
> HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
> +	char mgmt_ver[MGMT_VERSION_MAX_LEN] = {0};
> +	int err;
> +
> +	err = hinic3_get_mgmt_version(nic_dev->hwdev, mgmt_ver,
> +				      HINIC3_MGMT_VERSION_MAX_LEN);
> +	if (err) {
> +		PMD_DRV_LOG(ERR, "Get fw version failed");
> +		return -EIO;
> +	}
> +
> +	if (fw_size < strlen((char *)mgmt_ver) + 1)
> +		return (strlen((char *)mgmt_ver) + 1);

Maybe get length once. Why the cast mgmt_ver is already char *
> +
> +	snprintf(fw_version, fw_size, "%s", mgmt_ver);

Could use strlcpy here.
> +
> +	return 0;
> +}
> +

> +/**
> + * Create the receive queue.
> + *
> + * @param[in] dev
> + * Pointer to ethernet device structure.
> + * @param[in] qid
> + * Receive queue index.
> + * @param[in] nb_desc
> + * Number of descriptors for receive queue.
> + * @param[in] socket_id
> + * Socket index on which memory must be allocated.
> + * @param[in] rx_conf
> + * Thresholds parameters (unused_).
> + * @param[in] mp
> + * Memory pool for buffer allocations.
> + *
> + * @return
> + * 0 on success, non-zero on failure.
> + */
> +static int
> +hinic3_rx_queue_setup(struct rte_eth_dev *dev, uint16_t qid,
> uint16_t nb_desc,
> +		      unsigned int socket_id, const struct
> rte_eth_rxconf *rx_conf,
> +		      struct rte_mempool *mp)
> +{
> +	struct hinic3_nic_dev *nic_dev;
> +	struct hinic3_rxq *rxq = NULL;
> +	const struct rte_memzone *rq_mz = NULL;
> +	const struct rte_memzone *cqe_mz = NULL;
> +	const struct rte_memzone *pi_mz = NULL;
> +	uint16_t rq_depth, rx_free_thresh;
> +	uint32_t queue_buf_size;
> +	void *db_addr = NULL;
> +	int wqe_count;
> +	uint32_t buf_size;
> +	int err;
> +
> +	nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
> +
> +	/* Queue depth must be power of 2, otherwise will be aligned
> up. */
> +	rq_depth = (nb_desc & (nb_desc - 1))
> +			   ? ((uint16_t)(1U <<
> (rte_log2_u32(nb_desc) + 1)))
> +			   : nb_desc;
> +
> +	/*
> +	 * Validate number of receive descriptors.
> +	 * It must not exceed hardware maximum and minimum.
> +	 */
> +	if (rq_depth > HINIC3_MAX_QUEUE_DEPTH ||
> +	    rq_depth < HINIC3_MIN_QUEUE_DEPTH) {
> +		PMD_DRV_LOG(ERR,
> +			    "RX queue depth is out of range from %d
> to %d",
> +			    HINIC3_MIN_QUEUE_DEPTH,
> HINIC3_MAX_QUEUE_DEPTH);
> +		PMD_DRV_LOG(ERR,
> +				"nb_desc: %d, q_depth: %d, port: %d
> queue: %d",
> +				nb_desc, rq_depth,
> dev->data->port_id, qid);
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * The RX descriptor ring will be cleaned after
> rxq->rx_free_thresh
> +	 * descriptors are used or if the number of descriptors
> required
> +	 * to transmit a packet is greater than the number of free RX
> +	 * descriptors.
> +	 * The following constraints must be satisfied:
> +	 * - rx_free_thresh must be greater than 0.
> +	 * - rx_free_thresh must be less than the size of the ring
> minus 1.
> +	 * When set to zero use default values.
> +	 */
> +	rx_free_thresh = rx_conf->rx_free_thresh
> +				 ? rx_conf->rx_free_thresh
> +				 : HINIC3_DEFAULT_RX_FREE_THRESH;
> +	if (rx_free_thresh >= (rq_depth - 1)) {
> +		PMD_DRV_LOG(ERR,
> +			    "rx_free_thresh must be less than the
> number of RX descriptors minus 1, rx_free_thresh: %d port: %d queue:
> %d)",
> +			    rx_free_thresh, dev->data->port_id, qid);
> +		return -EINVAL;
> +	}
> +
> +	rxq = rte_zmalloc_socket("hinic3_rq", sizeof(struct
> hinic3_rxq),
> +				 RTE_CACHE_LINE_SIZE, socket_id);
> +	if (!rxq) {
> +		PMD_DRV_LOG(ERR, "Allocate rxq[%d] failed, dev_name:
> %s", qid,
> +			    dev->data->name);
> +
> +		return -ENOMEM;
> +	}
> +
> +	/* Init rq parameters. */
> +	rxq->nic_dev = nic_dev;
> +	nic_dev->rxqs[qid] = rxq;
> +	rxq->mb_pool = mp;
> +	rxq->q_id = qid;
> +	rxq->next_to_update = 0;

Already zero because the driver used rte_zmalloc()

> +	rxq->q_depth = rq_depth;
> +	rxq->q_mask = rq_depth - 1;
> +	rxq->delta = rq_depth;
> +	rxq->cons_idx = 0;
> +	rxq->prod_idx = 0;
> +	rxq->rx_free_thresh = rx_free_thresh;
> +	rxq->rxinfo_align_end = rxq->q_depth - rxq->rx_free_thresh;
> +	rxq->port_id = dev->data->port_id;
> +	rxq->wait_time_cycle = HINIC3_RX_WAIT_CYCLE_THRESH;
> +
> +	/* If buf_len used for function table, need to translated. */
> +	uint16_t rx_buf_size =
> +		rte_pktmbuf_data_room_size(rxq->mb_pool) -
> RTE_PKTMBUF_HEADROOM;
> +	err = hinic3_convert_rx_buf_size(rx_buf_size, &buf_size);
> +	if (err) {
> +		PMD_DRV_LOG(ERR, "Adjust buf size failed, dev_name:
> %s",
> +			    dev->data->name);
> +		goto adjust_bufsize_fail;
> +	}
> +
> +	if (buf_size >= HINIC3_RX_BUF_SIZE_4K &&
> +	    buf_size < HINIC3_RX_BUF_SIZE_16K)
> +		rxq->wqe_type = HINIC3_EXTEND_RQ_WQE;
> +	else
> +		rxq->wqe_type = HINIC3_NORMAL_RQ_WQE;
> +
> +	rxq->wqebb_shift = HINIC3_RQ_WQEBB_SHIFT + rxq->wqe_type;
> +	rxq->wqebb_size = (uint16_t)RTE_BIT32(rxq->wqebb_shift);
> +
> +	rxq->buf_len = (uint16_t)buf_size;
> +	rxq->rx_buff_shift = rte_log2_u32(rxq->buf_len);
> +
> +	pi_mz = hinic3_dma_zone_reserve(dev, "hinic3_rq_pi", qid,
> RTE_PGSIZE_4K,
> +					RTE_CACHE_LINE_SIZE,
> socket_id);
> +	if (!pi_mz) {
> +		PMD_DRV_LOG(ERR, "Allocate rxq[%d] pi_mz failed,
> dev_name: %s",
> +			    qid, dev->data->name);
> +		err = -ENOMEM;
> +		goto alloc_pi_mz_fail;
> +	}
> +	rxq->pi_mz = pi_mz;
> +	rxq->pi_dma_addr = pi_mz->iova;
> +	rxq->pi_virt_addr = pi_mz->addr;
> +
> +	err = hinic3_alloc_db_addr(nic_dev->hwdev, &db_addr,
> HINIC3_DB_TYPE_RQ);
> +	if (err) {
> +		PMD_DRV_LOG(ERR, "Alloc rq doorbell addr failed");
> +		goto alloc_db_err_fail;
> +	}
> +	rxq->db_addr = db_addr;
> +
> +	queue_buf_size = RTE_BIT32(rxq->wqebb_shift) * rq_depth;
> +	rq_mz = hinic3_dma_zone_reserve(dev, "hinic3_rq_mz", qid,
> +					queue_buf_size,
> RTE_PGSIZE_256K, socket_id);
> +	if (!rq_mz) {
> +		PMD_DRV_LOG(ERR, "Allocate rxq[%d] rq_mz failed,
> dev_name: %s",
> +			    qid, dev->data->name);
> +		err = -ENOMEM;
> +		goto alloc_rq_mz_fail;
> +	}
> +
> +	memset(rq_mz->addr, 0, queue_buf_size);
> +	rxq->rq_mz = rq_mz;
> +	rxq->queue_buf_paddr = rq_mz->iova;
> +	rxq->queue_buf_vaddr = rq_mz->addr;
> +
> +	rxq->rx_info = rte_zmalloc_socket("rx_info",
> +					  rq_depth *
> sizeof(*rxq->rx_info),
> +					  RTE_CACHE_LINE_SIZE,
> socket_id);
> +	if (!rxq->rx_info) {
> +		PMD_DRV_LOG(ERR, "Allocate rx_info failed, dev_name:
> %s",
> +			    dev->data->name);
> +		err = -ENOMEM;
> +		goto alloc_rx_info_fail;
> +	}
> +
> +	cqe_mz = hinic3_dma_zone_reserve(dev, "hinic3_cqe_mz", qid,
> +					 rq_depth *
> sizeof(*rxq->rx_cqe),
> +					 RTE_CACHE_LINE_SIZE,
> socket_id);
> +	if (!cqe_mz) {
> +		PMD_DRV_LOG(ERR, "Allocate cqe mem zone failed,
> dev_name: %s",
> +			    dev->data->name);
> +		err = -ENOMEM;
> +		goto alloc_cqe_mz_fail;
> +	}
> +	memset(cqe_mz->addr, 0, rq_depth * sizeof(*rxq->rx_cqe));
> +	rxq->cqe_mz = cqe_mz;
> +	rxq->cqe_start_paddr = cqe_mz->iova;
> +	rxq->cqe_start_vaddr = cqe_mz->addr;
> +	rxq->rx_cqe = (struct hinic3_rq_cqe *)rxq->cqe_start_vaddr;
> +
> +	wqe_count = hinic3_rx_fill_wqe(rxq);
> +	if (wqe_count != rq_depth) {
> +		PMD_DRV_LOG(ERR, "Fill rx wqe failed, wqe_count: %d,
> dev_name: %s",
> +				wqe_count, dev->data->name);
> +		err = -ENOMEM;
> +		goto fill_rx_wqe_fail;
> +	}
> +	/* Record rxq pointer in rte_eth rx_queues. */
> +	dev->data->rx_queues[qid] = rxq;
> +
> +	return 0;
> +
> +fill_rx_wqe_fail:
> +	hinic3_memzone_free(rxq->cqe_mz);
> +alloc_cqe_mz_fail:
> +	rte_free(rxq->rx_info);
> +
> +alloc_rx_info_fail:
> +	hinic3_memzone_free(rxq->rq_mz);
> +
> +alloc_rq_mz_fail:
> +alloc_db_err_fail:
> +	hinic3_memzone_free(rxq->pi_mz);
> +
> +alloc_pi_mz_fail:
> +adjust_bufsize_fail:
> +	rte_free(rxq);
> +	nic_dev->rxqs[qid] = NULL;
> +
> +	return err;
> +}
> +
> +/**
> + * Create the transmit queue.
> + *
> + * @param[in] dev
> + * Pointer to ethernet device structure.
> + * @param[in] queue_idx
> + * Transmit queue index.
> + * @param[in] nb_desc
> + * Number of descriptors for transmit queue.
> + * @param[in] socket_id
> + * Socket index on which memory must be allocated.
> + * @param[in] tx_conf
> + * Tx queue configuration parameters (unused_).
> + *
> + * @return
> + * 0 on success, non-zero on failure.
> + */
> +static int
> +hinic3_tx_queue_setup(struct rte_eth_dev *dev, uint16_t qid,
> uint16_t nb_desc,
> +		      unsigned int socket_id, const struct
> rte_eth_txconf *tx_conf) +{
> +	struct hinic3_nic_dev *nic_dev;
> +	struct hinic3_hwdev *hwdev;
> +	struct hinic3_txq *txq = NULL;
> +	const struct rte_memzone *sq_mz = NULL;
> +	const struct rte_memzone *ci_mz = NULL;
> +	void *db_addr = NULL;
> +	uint16_t sq_depth, tx_free_thresh;
> +	uint32_t queue_buf_size;
> +	int err;
> +
> +	nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
> +	hwdev = nic_dev->hwdev;
> +
> +	/* Queue depth must be power of 2, otherwise will be aligned
> up. */
> +	sq_depth = (nb_desc & (nb_desc - 1))
> +				? ((uint16_t)(1U <<
> (rte_log2_u32(nb_desc) + 1)))
> +				: nb_desc;
> +
> +	/*
> +	 * Validate number of transmit descriptors.
> +	 * It must not exceed hardware maximum and minimum.
> +	 */
> +	if (sq_depth > HINIC3_MAX_QUEUE_DEPTH ||
> +	    sq_depth < HINIC3_MIN_QUEUE_DEPTH) {
> +		PMD_DRV_LOG(ERR,
> +			    "TX queue depth is out of range from %d
> to %d",
> +			    HINIC3_MIN_QUEUE_DEPTH,
> HINIC3_MAX_QUEUE_DEPTH);
> +		PMD_DRV_LOG(ERR,
> +			    "nb_desc: %d, q_depth: %d, port: %d
> queue: %d",
> +			    nb_desc, sq_depth, dev->data->port_id,
> qid);
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * The TX descriptor ring will be cleaned after
> txq->tx_free_thresh
> +	 * descriptors are used or if the number of descriptors
> required
> +	 * to transmit a packet is greater than the number of free TX
> +	 * descriptors.
> +	 * The following constraints must be satisfied:
> +	 * - tx_free_thresh must be greater than 0.
> +	 * - tx_free_thresh must be less than the size of the ring
> minus 1.
> +	 * When set to zero use default values.
> +	 */
> +	tx_free_thresh = tx_conf->tx_free_thresh
> +				 ? tx_conf->tx_free_thresh
> +				 : HINIC3_DEFAULT_TX_FREE_THRESH;
> +	if (tx_free_thresh >= (sq_depth - 1)) {
> +		PMD_DRV_LOG(ERR,
> +			    "tx_free_thresh must be less than the
> number of tx descriptors minus 1, tx_free_thresh: %d port: %d queue:
> %d",
> +			    tx_free_thresh, dev->data->port_id, qid);
> +		return -EINVAL;
> +	}
> +
> +	txq = rte_zmalloc_socket("hinic3_tx_queue", sizeof(struct
> hinic3_txq),
> +				 RTE_CACHE_LINE_SIZE, socket_id);
> +	if (!txq) {
> +		PMD_DRV_LOG(ERR, "Allocate txq[%d] failed, dev_name:
> %s", qid,
> +			    dev->data->name);
> +		return -ENOMEM;
> +	}
> +	nic_dev->txqs[qid] = txq;
> +	txq->nic_dev = nic_dev;
> +	txq->q_id = qid;
> +	txq->q_depth = sq_depth;
> +	txq->q_mask = sq_depth - 1;
> +	txq->cons_idx = 0;
> +	txq->prod_idx = 0;

Already zero from rte_zmalloc()

> +	txq->wqebb_shift = HINIC3_SQ_WQEBB_SHIFT;
> +	txq->wqebb_size = (uint16_t)RTE_BIT32(txq->wqebb_shift);
> +	txq->tx_free_thresh = tx_free_thresh;
> +	txq->owner = 1;
> +	txq->cos = nic_dev->default_cos;
> +
> +	ci_mz = hinic3_dma_zone_reserve(dev, "hinic3_sq_ci", qid,
> +					HINIC3_CI_Q_ADDR_SIZE,
> +					HINIC3_CI_Q_ADDR_SIZE,
> socket_id);
> +	if (!ci_mz) {
> +		PMD_DRV_LOG(ERR, "Allocate txq[%d] ci_mz failed,
> dev_name: %s",
> +			    qid, dev->data->name);
> +		err = -ENOMEM;
> +		goto alloc_ci_mz_fail;
> +	}
> +	txq->ci_mz = ci_mz;
> +	txq->ci_dma_base = ci_mz->iova;
> +	txq->ci_vaddr_base = (volatile uint16_t *)ci_mz->addr;
> +
> +	queue_buf_size = RTE_BIT32(txq->wqebb_shift) * sq_depth;
> +	sq_mz = hinic3_dma_zone_reserve(dev, "hinic3_sq_mz", qid,
> +					queue_buf_size,
> RTE_PGSIZE_256K, socket_id);
> +	if (!sq_mz) {
> +		PMD_DRV_LOG(ERR, "Allocate txq[%d] sq_mz failed,
> dev_name: %s",
> +			    qid, dev->data->name);
> +		err = -ENOMEM;
> +		goto alloc_sq_mz_fail;
> +	}
> +	memset(sq_mz->addr, 0, queue_buf_size);
> +	txq->sq_mz = sq_mz;
> +	txq->queue_buf_paddr = sq_mz->iova;
> +	txq->queue_buf_vaddr = sq_mz->addr;
> +	txq->sq_head_addr = (uint64_t)txq->queue_buf_vaddr;
> +	txq->sq_bot_sge_addr = txq->sq_head_addr + queue_buf_size;
> +
> +	err = hinic3_alloc_db_addr(hwdev, &db_addr,
> HINIC3_DB_TYPE_SQ);
> +	if (err) {
> +		PMD_DRV_LOG(ERR, "Alloc sq doorbell addr failed");
> +		goto alloc_db_err_fail;
> +	}
> +	txq->db_addr = db_addr;
> +
> +	txq->tx_info = rte_zmalloc_socket("tx_info",
> +					  sq_depth *
> sizeof(*txq->tx_info),
> +					  RTE_CACHE_LINE_SIZE,
> socket_id);
> +	if (!txq->tx_info) {
> +		PMD_DRV_LOG(ERR, "Allocate tx_info failed, dev_name:
> %s",
> +			    dev->data->name);
> +		err = -ENOMEM;
> +		goto alloc_tx_info_fail;
> +	}
> +
> +	/* Record txq pointer in rte_eth tx_queues. */
> +	dev->data->tx_queues[qid] = txq;
> +
> +	return 0;
> +
> +alloc_tx_info_fail:
> +alloc_db_err_fail:
> +	hinic3_memzone_free(txq->sq_mz);
> +
> +alloc_sq_mz_fail:
> +	hinic3_memzone_free(txq->ci_mz);
> +
> +alloc_ci_mz_fail:
> +	rte_free(txq);
> +	return err;
> +}
> +

...

> +/**
> + * Start the device.
> + *
> + * Initialize function table, TXQ and TXQ context, configure RX
> offload, and
> + * enable vport and port to prepare receiving packets.
> + *
> + * @param[in] eth_dev
> + * Pointer to ethernet device structure.
> + *
> + * @return
> + * 0 on success, non-zero on failure.
> + */
> +static int
> +hinic3_dev_start(struct rte_eth_dev *eth_dev)
> +{
> +	struct hinic3_nic_dev *nic_dev = NULL;
> +	uint64_t nic_features;
> +	struct hinic3_rxq *rxq = NULL;
> +	int i;
> +	int err;
> +
> +	nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(eth_dev);
> +	err = hinic3_copy_mempool_init(nic_dev);
> +	if (err) {
> +		PMD_DRV_LOG(ERR, "Create copy mempool failed,
> dev_name: %s",
> +			    eth_dev->data->name);
> +		goto init_mpool_fail;
> +	}
> +	hinic3_update_msix_info(nic_dev->hwdev->hwif);
> +	hinic3_disable_interrupt(eth_dev);
> +	err = hinic3_init_rxq_intr(eth_dev);
> +	if (err) {
> +		PMD_DRV_LOG(ERR, "Init rxq intr fail, eth_dev:%s",
> +			    eth_dev->data->name);
> +		goto init_rxq_intr_fail;
> +	}
> +
> +	hinic3_get_func_rx_buf_size(nic_dev);
> +	err = hinic3_init_function_table(nic_dev->hwdev,
> nic_dev->rx_buff_len);
> +	if (err) {
> +		PMD_DRV_LOG(ERR, "Init function table failed,
> dev_name: %s",
> +			    eth_dev->data->name);
> +		goto init_func_tbl_fail;
> +	}
> +
> +	nic_features = hinic3_get_driver_feature(nic_dev);
> +	/*
> +	 * You can update the features supported by the driver
> according to the
> +	 * scenario here.
> +	 */
> +	nic_features &= DEFAULT_DRV_FEATURE;
> +	hinic3_update_driver_feature(nic_dev, nic_features);
> +
> +	err = hinic3_set_feature_to_hw(nic_dev->hwdev,
> &nic_dev->feature_cap,
> +				       1);

Could fit one line (max length 100)

> +	if (err) {
> +		PMD_DRV_LOG(ERR,
> +			    "Failed to set nic features to hardware,
> err %d",
> +			    err);
> +		goto get_feature_err;
> +	}
> +
> +	/* Reset rx and tx queue. */
> +	hinic3_reset_rx_queue(eth_dev);
> +	hinic3_reset_tx_queue(eth_dev);
> +
> +	/* Init txq and rxq context. */
> +	err = hinic3_init_qp_ctxts(nic_dev);
> +	if (err) {
> +		PMD_DRV_LOG(ERR, "Init qp context failed, dev_name:
> %s",
> +			    eth_dev->data->name);
> +		goto init_qp_fail;
> +	}
> +
> +	/* Set default mtu. */
> +	err = hinic3_set_port_mtu(nic_dev->hwdev, nic_dev->mtu_size);
> +	if (err) {
> +		PMD_DRV_LOG(ERR, "Set mtu_size[%d] failed, dev_name:
> %s",
> +			    nic_dev->mtu_size, eth_dev->data->name);
> +		goto set_mtu_fail;
> +	}
> +	eth_dev->data->mtu = nic_dev->mtu_size;
> +
> +	/* Set rx configuration: rss/checksum/rxmode/lro. */
> +	err = hinic3_set_rxtx_configure(eth_dev);
> +	if (err) {
> +		PMD_DRV_LOG(ERR, "Set rx config failed, dev_name:
> %s",
> +			    eth_dev->data->name);
> +		goto set_rxtx_config_fail;
> +	}
> +
> +	/* Enable dev interrupt. */
> +	hinic3_enable_interrupt(eth_dev);
> +	err = hinic3_start_all_rqs(eth_dev);
> +	if (err) {
> +		PMD_DRV_LOG(ERR, "Set rx config failed, dev_name:
> %s",
> +			    eth_dev->data->name);
> +		goto start_rqs_fail;
> +	}

If device supports start/stop. It should also support deferred start.

> +
> +	hinic3_start_all_sqs(eth_dev);
> +
> +	/* Open virtual port and ready to start packet receiving. */
> +	err = hinic3_set_vport_enable(nic_dev->hwdev, true);
> +	if (err) {
> +		PMD_DRV_LOG(ERR, "Enable vport failed, dev_name: %s",
> +			    eth_dev->data->name);
> +		goto en_vport_fail;
> +	}
> +
> +	/* Open physical port and start packet receiving. */
> +	err = hinic3_set_port_enable(nic_dev->hwdev, true);
> +	if (err) {
> +		PMD_DRV_LOG(ERR, "Enable physical port failed,
> dev_name: %s",
> +			    eth_dev->data->name);
> +		goto en_port_fail;
> +	}
> +
> +	/* Update eth_dev link status. */
> +	if (eth_dev->data->dev_conf.intr_conf.lsc != 0)
> +		hinic3_link_update(eth_dev, 0);
> +
> +	hinic3_set_bit(HINIC3_DEV_START, &nic_dev->dev_status);
> +
> +	return 0;
> +
> +en_port_fail:
> +	hinic3_set_vport_enable(nic_dev->hwdev, false);
> +
> +en_vport_fail:
> +	/* Flush tx && rx chip resources in case of setting vport
> fake fail. */
> +	hinic3_flush_qps_res(nic_dev->hwdev);
> +	rte_delay_ms(DEV_START_DELAY_MS);
> +	for (i = 0; i < nic_dev->num_rqs; i++) {
> +		rxq = nic_dev->rxqs[i];
> +		hinic3_remove_rq_from_rx_queue_list(nic_dev,
> rxq->q_id);
> +		hinic3_free_rxq_mbufs(rxq);
> +		hinic3_dev_rx_queue_intr_disable(eth_dev, rxq->q_id);
> +		eth_dev->data->rx_queue_state[i] =
> RTE_ETH_QUEUE_STATE_STOPPED;
> +		eth_dev->data->tx_queue_state[i] =
> RTE_ETH_QUEUE_STATE_STOPPED;
> +	}
> +start_rqs_fail:
> +	hinic3_remove_rxtx_configure(eth_dev);
> +
> +set_rxtx_config_fail:
> +set_mtu_fail:
> +	hinic3_free_qp_ctxts(nic_dev->hwdev);
> +
> +init_qp_fail:
> +get_feature_err:
> +init_func_tbl_fail:
> +	hinic3_deinit_rxq_intr(eth_dev);
> +init_rxq_intr_fail:
> +	hinic3_copy_mempool_uninit(nic_dev);
> +init_mpool_fail:
> +	return err;
> +}
> +
> +/**
> + * Look up or creates a memory pool for storing packet buffers used
> in copy
> + * operations.
> + *
> + * @param[in] nic_dev
> + * Pointer to NIC device structure.
> + *
> + * @return
> + * 0 on success, non-zero on failure.
> + * `-ENOMEM`: Memory pool creation fails.
> + */
> +static int
> +hinic3_copy_mempool_init(struct hinic3_nic_dev *nic_dev)
> +{
> +	nic_dev->cpy_mpool =
> rte_mempool_lookup(HINCI3_CPY_MEMPOOL_NAME);
> +	if (nic_dev->cpy_mpool == NULL) {
> +		nic_dev->cpy_mpool =
> rte_pktmbuf_pool_create(HINCI3_CPY_MEMPOOL_NAME,
> +			HINIC3_COPY_MEMPOOL_DEPTH,
> HINIC3_COPY_MEMPOOL_CACHE,
> +			0, HINIC3_COPY_MBUF_SIZE, rte_socket_id());
> +		if (nic_dev->cpy_mpool == NULL) {
> +			PMD_DRV_LOG(ERR,
> +				    "Create copy mempool failed,
> errno: %d, dev_name: %s",
> +				    rte_errno,
> HINCI3_CPY_MEMPOOL_NAME);
> +			return -ENOMEM;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * Clear the reference to the copy memory pool without freeing it.
> + *
> + * @param[in] nic_dev
> + * Pointer to NIC device structure.
> + */
> +static void
> +hinic3_copy_mempool_uninit(struct hinic3_nic_dev *nic_dev)
> +{
> +	nic_dev->cpy_mpool = NULL;
> +}
> 

Looks like the copy mbuf pool is only used on transmit of highly
segmented packets. There is a value nb_mtu_seg_max which should be used
to limit the number of segments allowed. The the whole pool would not
be needed.

> +/**
> + * Close the device.
> + *
> + * @param[in] dev
> + * Pointer to ethernet device structure.
> + *
> + * @return
> + * 0 on success, non-zero on failure.
> + */
> +static int
> +hinic3_dev_close(struct rte_eth_dev *eth_dev)
> +{
> +	struct hinic3_nic_dev *nic_dev =
> +		HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(eth_dev);
> +	int ret;
> +
> +	if (hinic3_test_and_set_bit(HINIC3_DEV_CLOSE,
> &nic_dev->dev_status)) {
> +		PMD_DRV_LOG(WARNING, "Device %s already closed",
> +			    nic_dev->dev_name);
> +		return 0;
> +	}
> +
> +	ret = hinic3_dev_stop(eth_dev);
> +
> +	hinic3_dev_release(eth_dev);
> +	return ret;
> +}
> +
> +static int
> +hinic3_dev_reset(__rte_unused struct rte_eth_dev *dev)
> +{
> +	return 0;
> +}


This function is not defined by later patches.
Better to not have a dev_reset handler if device does not
support it. The the ethdev layer will return not supported.
Rather than confusing application.


> +
> +#define MIN_RX_BUFFER_SIZE	      256
> +#define MIN_RX_BUFFER_SIZE_SMALL_MODE 1518
> +
> +static int
> +hinic3_dev_set_mtu(struct rte_eth_dev *dev, uint16_t mtu)
> +{
> +	struct hinic3_nic_dev *nic_dev =
> HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
> +	int err = 0;
> +
> +	PMD_DRV_LOG(INFO, "Set port mtu, port_id: %d, mtu: %d,
> max_pkt_len: %d",
> +		    dev->data->port_id, mtu,
> HINIC3_MTU_TO_PKTLEN(mtu)); +
> +	if (mtu < HINIC3_MIN_MTU_SIZE || mtu > HINIC3_MAX_MTU_SIZE) {
> +		PMD_DRV_LOG(ERR, "Invalid mtu: %d, must between %d
> and %d", mtu,
> +			    HINIC3_MIN_MTU_SIZE,
> HINIC3_MAX_MTU_SIZE);
> +		return -EINVAL;
> +	}

These checks are already done at ethdev layer.

> +
> +	err = hinic3_set_port_mtu(nic_dev->hwdev, mtu);
> +	if (err) {
> +		PMD_DRV_LOG(ERR, "Set port mtu failed, err: %d",
> err);
> +		return err;
> +	}
> +
> +	/* Update max frame size. */
> +	HINIC3_MAX_RX_PKT_LEN(dev->data->dev_conf.rxmode) =
> +		HINIC3_MTU_TO_PKTLEN(mtu);
> +	nic_dev->mtu_size = mtu;
> +	return err;
> +}
> +
> +/**
> + * Add or delete vlan id.
> + *
> + * @param[in] dev
> + * Pointer to ethernet device structure.
> + * @param[in] vlan_id
> + * Vlan id is used to filter vlan packets.
> + * @param[in] enable
> + * Disable or enable vlan filter function.
> + *
> + * @return
> + * 0 on success, non-zero on failure.
> + */
> +static int
> +hinic3_vlan_filter_set(struct rte_eth_dev *dev, uint16_t vlan_id,
> int enable) +{
> +	struct hinic3_nic_dev *nic_dev =
> HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
> +	int err = 0;
> +	uint16_t func_id;
> +
> +	if (vlan_id >= RTE_ETHER_MAX_VLAN_ID)
> +		return -EINVAL;

Already checked at ethdev layer.

> +
> +	if (vlan_id == 0)
> +		return 0;
> +
> +	func_id = hinic3_global_func_id(nic_dev->hwdev);
> +
> +	if (enable) {
> +		/* If vlanid is already set, just return. */
> +		if (hinic3_find_vlan_filter(nic_dev, vlan_id)) {
> +			PMD_DRV_LOG(INFO, "Vlan %u has been added,
> device: %s",
> +				    vlan_id, nic_dev->dev_name);
> +			return 0;
> +		}
> +
> +		err = hinic3_add_vlan(nic_dev->hwdev, vlan_id,
> func_id);
> +	} else {
> +		/* If vlanid can't be found, just return. */
> +		if (!hinic3_find_vlan_filter(nic_dev, vlan_id)) {
> +			PMD_DRV_LOG(INFO,
> +				    "Vlan %u is not in the vlan
> filter list, device: %s",
> +				    vlan_id, nic_dev->dev_name);
> +			return 0;
> +		}
> +
> +		err = hinic3_del_vlan(nic_dev->hwdev, vlan_id,
> func_id);
> +	}
> +
> +	if (err) {
> +		PMD_DRV_LOG(ERR,
> +			    "%s vlan failed, func_id: %d, vlan_id:
> %d, err: %d",
> +			    enable ? "Add" : "Remove", func_id,
> vlan_id, err);
> +		return err;
> +	}
> +
> +	hinic3_store_vlan_filter(nic_dev, vlan_id, enable);
> +
> +	PMD_DRV_LOG(INFO, "%s vlan %u succeed, device: %s",
> +		    enable ? "Add" : "Remove", vlan_id,
> nic_dev->dev_name); +
> +	return 0;
> +}
> +
> +/**
> + * Enable or disable vlan offload.
> + *
> + * @param[in] dev
> + * Pointer to ethernet device structure.
> + * @param[in] mask
> + * Definitions used for VLAN setting, vlan filter of vlan strip.
> + *
> + * @return
> + * 0 on success, non-zero on failure.
> + */
> +static int
> +hinic3_vlan_offload_set(struct rte_eth_dev *dev, int mask)
> +{
> +	struct hinic3_nic_dev *nic_dev =
> HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
> +	struct rte_eth_rxmode *rxmode = &dev->data->dev_conf.rxmode;
> +	bool on;
> +	int err;
> +
> +	/* Enable or disable VLAN filter. */
> +	if (mask & RTE_ETH_VLAN_FILTER_MASK) {
> +		on = (rxmode->offloads &
> RTE_ETH_RX_OFFLOAD_VLAN_FILTER)
> +			     ? true
> +			     : false;
> +		err = hinic3_set_vlan_filter(nic_dev->hwdev, on);
> +		if (err) {
> +			PMD_DRV_LOG(ERR,
> +				    "%s vlan filter failed, device:
> %s, port_id: %d, err: %d",
> +				    on ? "Enable" : "Disable",
> +				    nic_dev->dev_name,
> dev->data->port_id, err);
> +			return err;
> +		}
> +
> +		PMD_DRV_LOG(INFO,
> +			    "%s vlan filter succeed, device: %s,
> port_id: %d",
> +			    on ? "Enable" : "Disable",
> nic_dev->dev_name,
> +			    dev->data->port_id);

Successful operations should be silent. Change messages like this to
DEBUG level.

> +	}
> +
> +	/* Enable or disable VLAN stripping. */
> +	if (mask & RTE_ETH_VLAN_STRIP_MASK) {
> +		on = (rxmode->offloads &
> RTE_ETH_RX_OFFLOAD_VLAN_STRIP) ? true
> +
> 	: false;
> +		err = hinic3_set_rx_vlan_offload(nic_dev->hwdev, on);
> +		if (err) {
> +			PMD_DRV_LOG(ERR,
> +				    "%s vlan strip failed, device:
> %s, port_id: %d, err: %d",
> +				    on ? "Enable" : "Disable",
> +				    nic_dev->dev_name,
> dev->data->port_id, err);
> +			return err;
> +		}
> +
> +		PMD_DRV_LOG(INFO,
> +			    "%s vlan strip succeed, device: %s,
> port_id: %d",
> +			    on ? "Enable" : "Disable",
> nic_dev->dev_name,
> +			    dev->data->port_id);

Ditto

> +	}
> +	return 0;
> +}
> 
> +/**
> + * Get device extended statistics.
> + *
> + * @param[in] dev
> + * Pointer to ethernet device structure.
> + * @param[out] xstats
> + * Pointer to rte extended stats table.
> + * @param[in] n
> + * The size of the stats table.
> + *
> + * @return
> + * positive: Number of extended stats on success and stats is filled.
> + * negative: Failure.
> + */
> +static int
> +hinic3_dev_xstats_get(struct rte_eth_dev *dev, struct rte_eth_xstat
> *xstats,
> +		      unsigned int n)
> +{
> +	struct hinic3_nic_dev *nic_dev;
> +	struct mag_phy_port_stats port_stats;
> +	struct hinic3_vport_stats vport_stats;
> +	struct hinic3_rxq *rxq = NULL;
> +	struct hinic3_rxq_stats rxq_stats;
> +	struct hinic3_txq *txq = NULL;
> +	struct hinic3_txq_stats txq_stats;
> +	uint16_t qid;
> +	uint32_t i, count;
> +	int err;
> +
> +	nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
> +	count = hinic3_xstats_calc_num(nic_dev);
> +	if (n < count)
> +		return count;
> +
> +	count = 0;
> +
> +	/* Get stats from rxq stats structure. */
> +	for (qid = 0; qid < nic_dev->num_rqs; qid++) {
> +		rxq = nic_dev->rxqs[qid];
> +
> +#ifdef HINIC3_XSTAT_RXBUF_INFO
> +		hinic3_get_stats(rxq);
> +#endif
> +
> +#ifdef HINIC3_XSTAT_MBUF_USE
> +		rxq->rxq_stats.rx_left_mbuf_bytes =
> +			rxq->rxq_stats.rx_alloc_mbuf_bytes -
> +			rxq->rxq_stats.rx_free_mbuf_bytes;
> +#endif
> +		rxq->rxq_stats.errors = rxq->rxq_stats.csum_errors +
> +					rxq->rxq_stats.other_errors;
> +
> +		memcpy((void *)&rxq_stats, (void *)&rxq->rxq_stats,
> +		       sizeof(rxq->rxq_stats));
> +
> +		for (i = 0; i < HINIC3_RXQ_XSTATS_NUM; i++) {
> +			xstats[count].value = *(uint64_t *)(((char
> *)&rxq_stats) +
> +
> hinic3_rxq_stats_strings[i].offset);
> +			xstats[count].id = count;
> +			count++;
> +		}
> +	}
> +
> +	/* Get stats from txq stats structure. */
> +	for (qid = 0; qid < nic_dev->num_sqs; qid++) {
> +		txq = nic_dev->txqs[qid];
> +		memcpy((void *)&txq_stats, (void *)&txq->txq_stats,
> +		       sizeof(txq->txq_stats));
> +
> +		for (i = 0; i < HINIC3_TXQ_XSTATS_NUM; i++) {
> +			xstats[count].value = *(uint64_t *)(((char
> *)&txq_stats) +
> +
> hinic3_txq_stats_strings[i].offset);
> +			xstats[count].id = count;
> +			count++;
> +		}
> +	}
> 

OK as is. But you could simplify and use assignment instead of memcpy

diff --git a/drivers/net/hinic3/hinic3_ethdev.c
b/drivers/net/hinic3/hinic3_ethdev.c index 5c6d5a5543..906911c2f9 100644
--- a/drivers/net/hinic3/hinic3_ethdev.c
+++ b/drivers/net/hinic3/hinic3_ethdev.c
@@ -2687,10 +2687,6 @@ hinic3_dev_xstats_get(struct rte_eth_dev *dev,
struct rte_eth_xstat *xstats, struct hinic3_nic_dev *nic_dev;
        struct mag_phy_port_stats port_stats;
        struct hinic3_vport_stats vport_stats;
-       struct hinic3_rxq *rxq = NULL;
-       struct hinic3_rxq_stats rxq_stats;
-       struct hinic3_txq *txq = NULL;
-       struct hinic3_txq_stats txq_stats;
        uint16_t qid;
        uint32_t i, count;
        int err;
@@ -2704,7 +2700,8 @@ hinic3_dev_xstats_get(struct rte_eth_dev *dev,
struct rte_eth_xstat *xstats, 
        /* Get stats from rxq stats structure. */
        for (qid = 0; qid < nic_dev->num_rqs; qid++) {
-               rxq = nic_dev->rxqs[qid];
+               const struct hinic3_rxq *rxq = nic_dev->rxqs[qid];
+               struct hinic3_rxq_stats rxq_stats;
 
 #ifdef HINIC3_XSTAT_RXBUF_INFO
                hinic3_get_stats(rxq);
@@ -2718,8 +2715,7 @@ hinic3_dev_xstats_get(struct rte_eth_dev *dev,
struct rte_eth_xstat *xstats, rxq->rxq_stats.errors =
rxq->rxq_stats.csum_errors + rxq->rxq_stats.other_errors;
 
-               memcpy((void *)&rxq_stats, (void *)&rxq->rxq_stats,
-                      sizeof(rxq->rxq_stats));
+               rxq_stats = rxq->rxq_stats;
 
                for (i = 0; i < HINIC3_RXQ_XSTATS_NUM; i++) {
                        xstats[count].value = *(uint64_t *)(((char
*)&rxq_stats) + @@ -2731,9 +2727,8 @@ hinic3_dev_xstats_get(struct
rte_eth_dev *dev, struct rte_eth_xstat *xstats, 
        /* Get stats from txq stats structure. */
        for (qid = 0; qid < nic_dev->num_sqs; qid++) {
-               txq = nic_dev->txqs[qid];
-               memcpy((void *)&txq_stats, (void *)&txq->txq_stats,
-                      sizeof(txq->txq_stats));
+               const struct hinic3_txq *txq = nic_dev->txqs[qid];
+               struct hinic3_txq_stats txq_stats = txq->txq_stats;
 
                for (i = 0; i < HINIC3_TXQ_XSTATS_NUM; i++) {
                        xstats[count].value = *(uint64_t *)(((char
*)&txq_stats) +

