Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2898FC83029
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Jun 2025 15:12:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 45B5D402A5;
	Mon, 30 Jun 2025 17:12:17 +0200 (CEST)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com
 [209.85.222.179])
 by mails.dpdk.org (Postfix) with ESMTP id 9BA3040291
 for <dev@dpdk.org>; Mon, 30 Jun 2025 17:12:15 +0200 (CEST)
Received: by mail-qk1-f179.google.com with SMTP id
 af79cd13be357-7d44e3a0169so134019185a.0
 for <dev@dpdk.org>; Mon, 30 Jun 2025 08:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1751296335;
 x=1751901135; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7IuCk0F+RGYHL48/3Y8SRNV0vA87k0wGbGa4xNyRmtI=;
 b=qw1WSZXzmDbgdLc14yWU67lUJ3VJvk+ri0LsZGg38kM1YtkVpbmritHmvw7pLLEq/i
 4cjltR6sKPpFzFt9JW8Khf3LySE7kjGffxYBJi9AC8bpNSIeBmKJ0MwAG2PrBAjJbYFN
 xoKvaJbssrmcLcPYXzZL1Q6Q11R40Lb9Yr/hKyxX7U+qoTq2zcnP28uivRupd3AOVVSJ
 k1KW/axzyYE/FfVaGjdfuSkTZ+7Bmv6xrE5BCwVMTT07MisdlhihT8nFTYMFf2LurHd8
 pEAk7Ek7mgEiQ6fRIA2Aq+NpY6lXM0Q6Z3cKH9we2pE/pnIe4ZApxxKF9i9qVittXugz
 dAfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751296335; x=1751901135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7IuCk0F+RGYHL48/3Y8SRNV0vA87k0wGbGa4xNyRmtI=;
 b=VZmitFDkN5/UEOWZSDVhKwE3C3yFuH5WgA8AjsWB6aZCzBad2wIYd4GffYoCDFq04u
 YW9Cdh1OKd/pIpIQ3UgbZEHHzaRwxcd1xzDFGu516szrNxYN6AT76ev40GGWqxD/cxiz
 vEiOx/ihKHlG/ZGyMVZZCeZrBHTAqyMVF1VynQJRdt8y3mt/WixYy+VMhLRy8EzBViQ6
 ul2ZN+qLPvVYZuw5aL5/ztV77OGsuz+WK8NQw4OV8PoZY1rtx9yn4q0lqk0EuunkyePj
 z6pD7falXQ4qtOSSCwTV/Kke3KY1rW/gLfdOLPaNbRaItdeyCRGCopOj/cJfWvsp5KWv
 rM7g==
X-Gm-Message-State: AOJu0YyBSVqE39aPJxrnCR8eei8qCLwJjB3OJ3Tx76Hwj5qgg0ZMUwfz
 1/VhfvVtFZnpHkjBp045X9cwZlWdUEPOM1mkbXhK+/7GWTHh2AZKJlCs/xRDhlB1j+0=
X-Gm-Gg: ASbGnctLX1bVLDgD/6tBauDjGBLYd6OjOA4YIRq+YoXePl1NJGcfkdU7/7I1818/RBT
 yEDEuNz4W6JVtzLqHCm+OvnRRXASRxsRHrSzpK/TIFx+4wRuLorCFRZuH/mw1UTi/vdE599fTtB
 oyYiYBcI5vvpVeF3EzrtSB22Xhy2PrRBg/jYBDUxGruHk085ZF9vLoZW5t5FRFpKpTMj2nhmvjg
 EuOeYLcDl+o8iwuezMpPJNYM2ccicdgazclDZx6rkqllYaF/zD8jHtPCzprI720f1ZIG/VahU8u
 d5LnVDagflUp8jJZPRjcYBB6XBmDWNicZ7IQ+SaEADUO2yVN1LC58tknHrak/MOMm6wPAzmc8MQ
 aOWHoHZQ4Dcdp6SzmhQQKR7rtXpmKXIDXl3L/jzc=
X-Google-Smtp-Source: AGHT+IEEAvT2jl0tukQz3p4lDGNSRpHitzq0XtKEnMg8xlaMak6wmu8s6mqobNDkeLgqMONma8ClfA==
X-Received: by 2002:a05:620a:470c:b0:7d2:3db:6816 with SMTP id
 af79cd13be357-7d443a07613mr2132635785a.47.1751296334669; 
 Mon, 30 Jun 2025 08:12:14 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d44320323esm606612585a.59.2025.06.30.08.12.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 08:12:14 -0700 (PDT)
Date: Mon, 30 Jun 2025 08:12:11 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gagandeep Singh <g.singh@nxp.com>
Cc: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>, Sachin Saxena
 <sachin.saxena@nxp.com>
Subject: Re: [PATCH v6 6/6] net/dpaa2: enable software taildrop for ordered
 queues
Message-ID: <20250630081211.6fd6793b@hermes.local>
In-Reply-To: <20250630095800.2943863-7-g.singh@nxp.com>
References: <20250613021125.790614-1-g.singh@nxp.com>
 <20250630095800.2943863-1-g.singh@nxp.com>
 <20250630095800.2943863-7-g.singh@nxp.com>
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

On Mon, 30 Jun 2025 15:28:00 +0530
Gagandeep Singh <g.singh@nxp.com> wrote:

> This patch adds support for software taildrop on ordered queues
> in the DPAA2 driver.
> It also enables congestion notification by default on
> traffic management (TM) queues,  which is a prerequisite for
> software taildrop functionality.
> 
> Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
> ---
>  doc/guides/rel_notes/release_25_07.rst |  1 +
>  drivers/net/dpaa2/dpaa2_rxtx.c         | 24 ++++++++++-
>  drivers/net/dpaa2/dpaa2_tm.c           | 60 +++++++++++++-------------
>  3 files changed, 53 insertions(+), 32 deletions(-)
> 
> diff --git a/doc/guides/rel_notes/release_25_07.rst b/doc/guides/rel_notes/release_25_07.rst
> index 53a1c8756d..dd8bc74946 100644
> --- a/doc/guides/rel_notes/release_25_07.rst
> +++ b/doc/guides/rel_notes/release_25_07.rst
> @@ -163,6 +163,7 @@ New Features
>  * **Updated DPAA2 ethernet driver.**
>  
>    * Added DPBP APIs for setting mempool depletion thresholds.
> +  * Enabled software taildrop for ordered queues.
>  
>  Removed Items
>  -------------
> diff --git a/drivers/net/dpaa2/dpaa2_rxtx.c b/drivers/net/dpaa2/dpaa2_rxtx.c
> index 67d065bb7c..dce1da80bb 100644
> --- a/drivers/net/dpaa2/dpaa2_rxtx.c
> +++ b/drivers/net/dpaa2/dpaa2_rxtx.c
> @@ -1800,8 +1800,11 @@ dpaa2_dev_tx_ordered(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
>  		while (qbman_result_SCN_state(dpaa2_q->cscn)) {
>  			retry_count++;
>  			/* Retry for some time before giving up */
> -			if (retry_count > CONG_RETRY_COUNT)
> +			if (retry_count > CONG_RETRY_COUNT) {
> +				if (dpaa2_q->tm_sw_td)
> +					goto sw_td;
>  				goto skip_tx;
> +			}
>  		}
>  
>  		frames_to_send = (nb_pkts > dpaa2_eqcr_size) ?
> @@ -1961,6 +1964,25 @@ dpaa2_dev_tx_ordered(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
>  			rte_pktmbuf_free_seg(buf_to_free[loop].seg);
>  	}
>  
> +	return num_tx;
> +sw_td:
> +	loop = 0;
> +	while (loop < num_tx) {
> +		if (unlikely(RTE_MBUF_HAS_EXTBUF(*bufs)))
> +			rte_pktmbuf_free(*bufs);
> +		bufs++;
> +		loop++;
> +	}

This looks like a possible bug.
Is there a double free here if there are external buffers.

> +
> +	/* free the pending buffers */
> +	while (nb_pkts) {
> +		rte_pktmbuf_free(*bufs);
> +		bufs++;
> +		nb_pkts--;
> +		num_tx++;
> +	}

Why not use rte_pktmbuf_free_bulk here?

> +	dpaa2_q->tx_pkts += num_tx;
> +
>  	return num_tx;
>  }
>  
> diff --git a/drivers/net/dpaa2/dpaa2_tm.c b/drivers/net/dpaa2/dpaa2_tm.c
> index dbf66c756e..36e815c356 100644
> --- a/drivers/net/dpaa2/dpaa2_tm.c
> +++ b/drivers/net/dpaa2/dpaa2_tm.c
> @@ -611,41 +611,39 @@ dpaa2_tm_configure_queue(struct rte_eth_dev *dev, struct dpaa2_tm_node *node)
>  	}
>  	dpaa2_q->fqid = qid.fqid;
>  
> -	/* setting congestion notification */
> -	if (!(priv->flags & DPAA2_TX_CGR_OFF)) {
> -		struct dpni_congestion_notification_cfg cong_notif_cfg = {0};
> -
> -		cong_notif_cfg.units = DPNI_CONGESTION_UNIT_FRAMES;
> -		cong_notif_cfg.threshold_entry = dpaa2_q->nb_desc;
> -		/* Notify that the queue is not congested when the data in
> -		 * the queue is below this thershold.(90% of value)
> -		 */
> -		cong_notif_cfg.threshold_exit = (dpaa2_q->nb_desc * 9) / 10;
> -		cong_notif_cfg.message_ctx = 0;
> -		iova = DPAA2_VADDR_TO_IOVA_AND_CHECK(dpaa2_q->cscn,
> -				sizeof(struct qbman_result));
> -		if (iova == RTE_BAD_IOVA) {
> -			DPAA2_PMD_ERR("No IOMMU map for cscn(%p)", dpaa2_q->cscn);
> -			return -ENOBUFS;
> -		}
> -		cong_notif_cfg.message_iova = iova;
> -		cong_notif_cfg.dest_cfg.dest_type = DPNI_DEST_NONE;
> -		cong_notif_cfg.notification_mode =
> +	/* setting taildrop through congestion notification */
> +	struct dpni_congestion_notification_cfg cong_notif_cfg = {0};
> +
> +	cong_notif_cfg.units = DPNI_CONGESTION_UNIT_FRAMES;
> +	cong_notif_cfg.threshold_entry = dpaa2_q->nb_desc;
> +	/* Notify that the queue is not congested when the data in
> +	 * the queue is below this thershold.(90% of value)
> +	 */
> +	cong_notif_cfg.threshold_exit = (dpaa2_q->nb_desc * 9) / 10;
> +	cong_notif_cfg.message_ctx = 0;
> +
> +	iova = DPAA2_VADDR_TO_IOVA_AND_CHECK(dpaa2_q->cscn,
> +			sizeof(struct qbman_result));
> +	if (iova == RTE_BAD_IOVA) {
> +		DPAA2_PMD_ERR("No IOMMU map for cscn(%p)", dpaa2_q->cscn);
> +		return -ENOBUFS;
> +	}
> +	cong_notif_cfg.message_iova = iova;
> +	cong_notif_cfg.dest_cfg.dest_type = DPNI_DEST_NONE;
> +	cong_notif_cfg.notification_mode =
>  					DPNI_CONG_OPT_WRITE_MEM_ON_ENTER |
>  					DPNI_CONG_OPT_WRITE_MEM_ON_EXIT |
>  					DPNI_CONG_OPT_COHERENT_WRITE;
> -		cong_notif_cfg.cg_point = DPNI_CP_QUEUE;
> +	cong_notif_cfg.cg_point = DPNI_CP_QUEUE;
>  
> -		ret = dpni_set_congestion_notification(dpni, CMD_PRI_LOW,
> -					priv->token,
> -					DPNI_QUEUE_TX,
> -					((node->parent->channel_id << 8) | tc_id),
> -					&cong_notif_cfg);
> -		if (ret) {
> -			DPAA2_PMD_ERR("Error in setting tx congestion notification: "
> -				"err=%d", ret);
> -			return -ret;
> -		}
> +	ret = dpni_set_congestion_notification(dpni, CMD_PRI_LOW,
> +			priv->token, DPNI_QUEUE_TX,
> +			((node->parent->channel_id << 8) | tc_id),
> +			&cong_notif_cfg);
> +	if (ret) {
> +		DPAA2_PMD_ERR("Error in setting tx congestion notification: "
> +			"err=%d", ret);
> +		return -ret;
>  	}
>  	dpaa2_q->tm_sw_td = true;
>  

