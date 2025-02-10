Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA88FC02198
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 18:24:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7B23040668;
	Mon, 10 Feb 2025 19:24:22 +0100 (CET)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41]) by mails.dpdk.org (Postfix) with ESMTP id B05BB40616
 for <dev@dpdk.org>; Mon, 10 Feb 2025 19:24:20 +0100 (CET)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-2f9bac7699aso6888438a91.1
 for <dev@dpdk.org>; Mon, 10 Feb 2025 10:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739211860;
 x=1739816660; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HeaKLodRa7c631yUTsHaJjJf+2Xq/SIqpCQBXnGjuKs=;
 b=fZRyy9/4J7IsqKjvB+OByGT1a+OddQ10wzRjYSaJGN9TTyE1YE4d+QqzUqJDBAvt1b
 tQbtbNJvIyV+X96PAFzw6HnXVnW79kTiHNy9JsZ9RSecv4+tJeHmUUv3HeqDeav6TP5P
 3EPalKkuUAUYomzSfwCOTCLuamDD9IB84vr5l9zjWlAB1oYvNyty/hJSAwbO2v0gFA5z
 GHTldMwEbG2jQFjr1s8ExmIEuPezsU5dvJh5dNHSZiOm+QiqvaMQGJZfw/Xr07eJeMbI
 Q5VOFjTnEHBlX+3VLy4omOGGKGMJjo11leZwBda7MvA9EaZj6Y5oID35OL/Zn9SK7vUY
 /FhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739211860; x=1739816660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HeaKLodRa7c631yUTsHaJjJf+2Xq/SIqpCQBXnGjuKs=;
 b=HQJV/2a+0rLcJgrNt3JtdXfF3Hyboj2t/MXDJjNxNTFggddGU5XM2UIl/fJoWPqewI
 3T3VPzuIzG2KmoF4KnGvcipXVVGKxDSwj420+Glx5i/sFlkEiJJpG+aPzXLK9JoxXQyG
 H4rQ7llCt1y5kuwydfLEx0N5rkU6DI/oLsG9BzrUoreCjsbDR/Vs6taodH2dHFhTYY0R
 ilW1znIbCsBmjd0V0SvM5pYd4SWuhgLbA5aQgaTUIgQTPzThLGAqNadFsi0bZ5UPKOWS
 9EkbkevwpVSPdVzAwda7YBBpZ0lFN1q47Tf0p4eVzoBt5rRqfA551J8DjLCshG4MdsI6
 kF8Q==
X-Gm-Message-State: AOJu0YwF333F1tLsxulh/qHqTKy++5Cbgb8ayc67/86F56NGuNe5MMAR
 ueJg63rL+/VXsTarBl2Jb+bQ1RxVUyTOKTaai0k0+mDVcXX8BO7p+qsWl0hDqz9klvqNqmVmKNQ
 f
X-Gm-Gg: ASbGncuBNBcspcZZyv0qW/CPwyXOROQ2GMWdeIb7WvTGIN5pnY1NOLaGtIlc1RHOhxJ
 /IO4wlh8ZO/BDnbjCtfvcfLQzcEmxYhI91zAAM0TAsvznwtSQNA9Lj50Ba1qJHJz7tzaXBY9aah
 tK3+7XG8Hx709hptUhfNmoieMXb4MK7qkWSK26mu/7qRiczWqS6sufCo2TzOsg67qvpsfvONxPL
 Gb4jXfNZh1TA2lzCdYFQOW0OBrCzvkf9pVpMAsF/eFE7WrGLbp/mFn1lV5a8Rvq17maIZjujCIw
 wUXkK0PmGJynpXun1GrBsDQyLNKRIMQxx3WUbJWmanYZc8FXq6xKav2qZtjaiidFkGTx
X-Google-Smtp-Source: AGHT+IGJlcbYBknIadiE5UBZKKbBIp+jr95hQu1hjpPeXn3J079rbGUSh3Ecy+EY2S/UQC76s2folQ==
X-Received: by 2002:a17:90b:3e86:b0:2ee:b66d:6576 with SMTP id
 98e67ed59e1d1-2fa9ee31687mr667536a91.30.1739211859927; 
 Mon, 10 Feb 2025 10:24:19 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa42dde5e5sm5519217a91.3.2025.02.10.10.24.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 10:24:19 -0800 (PST)
Date: Mon, 10 Feb 2025 10:19:39 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bingbin Chen <chen.bingbin@zte.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v1 14/14] net/zxdh: clean stat values
Message-ID: <20250210101939.4bc47c61@hermes.local>
In-Reply-To: <20250210015017.4105624-9-chen.bingbin@zte.com.cn>
References: <20250210014441.4105335-1-chen.bingbin@zte.com.cn>
 <20250210015017.4105624-1-chen.bingbin@zte.com.cn>
 <20250210015017.4105624-9-chen.bingbin@zte.com.cn>
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

On Mon, 10 Feb 2025 09:50:17 +0800
Bingbin Chen <chen.bingbin@zte.com.cn> wrote:

> +static uint32_t
> +zxdh_np_se_smmu0_ind_read(uint32_t dev_id,
> +						uint32_t base_addr,
> +						uint32_t index,
> +						uint32_t rd_mode,
> +						uint32_t rd_clr_mode,
> +						uint32_t *p_data)
> +{
> +	uint32_t rc = ZXDH_OK;
> +	uint32_t i = 0;
> +	uint32_t row_index = 0;
> +	uint32_t col_index = 0;
> +	uint32_t temp_data[4] = {0};
> +	uint32_t *p_temp_data = NULL;
> +	ZXDH_SMMU0_SMMU0_CPU_IND_CMD_T cpu_ind_cmd = {0};
> +	ZXDH_MUTEX_T *p_ind_mutex = NULL;
> +
> +	rc = zxdh_np_dev_opr_mutex_get(dev_id, ZXDH_DEV_MUTEX_T_SMMU0, &p_ind_mutex);
> +	ZXDH_COMM_CHECK_DEV_RC(dev_id, rc, "zxdh_np_dev_opr_mutex_get");
> +
> +	rc = zxdh_np_comm_mutex_lock(p_ind_mutex);
> +	ZXDH_COMM_CHECK_DEV_RC(dev_id, rc, "zxdh_np_comm_mutex_lock");
> +
> +	rc = zxdh_np_se_done_status_check(dev_id, ZXDH_SMMU0_SMMU0_WR_ARB_CPU_RDYR, 0);
> +	ZXDH_COMM_CHECK_DEV_RC_UNLOCK(dev_id, rc, "zxdh_np_se_done_status_check", p_ind_mutex);
> +
> +	if (rd_clr_mode == ZXDH_RD_MODE_HOLD) {
> +		cpu_ind_cmd.cpu_ind_rw = ZXDH_SE_OPR_RD;
> +		cpu_ind_cmd.cpu_ind_rd_mode = ZXDH_RD_MODE_HOLD;
> +		cpu_ind_cmd.cpu_req_mode = ZXDH_ERAM128_OPR_128b;
> +
> +		switch (rd_mode) {
> +		case ZXDH_ERAM128_OPR_128b:
> +		{
> +			if ((0xFFFFFFFF - (base_addr)) < (index)) {
> +				rc = zxdh_np_comm_mutex_unlock(p_ind_mutex);
> +				ZXDH_COMM_CHECK_DEV_RC(dev_id, rc, "zxdh_np_comm_mutex_unlock");
> +				PMD_DRV_LOG(ERR, "%s : index 0x%x is invalid!", __func__, index);
> +				return ZXDH_PAR_CHK_INVALID_INDEX;
> +			}
> +			if (base_addr + index > ZXDH_SE_SMMU0_ERAM_ADDR_NUM_TOTAL - 1) {
> +				PMD_DRV_LOG(ERR, "%s : index out of range !", __func__);
> +				rc = zxdh_np_comm_mutex_unlock(p_ind_mutex);
> +				ZXDH_COMM_CHECK_DEV_RC(dev_id, rc, "zxdh_np_comm_mutex_unlock");
> +				return ZXDH_ERR;
> +			}

The error paths here are a bit of a mess.
Do you really have to check return value of mutex_unlock if already have an error?
