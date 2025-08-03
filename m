Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318F8C87FCB
	for <dpdk-dev@archiver.kernel.org>; Sun,  3 Aug 2025 17:35:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F0894026C;
	Sun,  3 Aug 2025 19:35:07 +0200 (CEST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54]) by mails.dpdk.org (Postfix) with ESMTP id E3288400D5
 for <dev@dpdk.org>; Sun,  3 Aug 2025 19:35:03 +0200 (CEST)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-45617887276so13793465e9.2
 for <dev@dpdk.org>; Sun, 03 Aug 2025 10:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754242503;
 x=1754847303; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JTdtXKy5hKDR3SHAhn9lLjW5N0VMb3TiHRGXoBNjX7A=;
 b=u0dh0SSYghJ6vJS3GMKLp0jtm6obmuiGK214RmvoducLbSWu3aZx55h5hfUoANnZaQ
 yO82uMYlEt4KoxxLuXrdhcV1H+v8fEhdgQXzo0QH7KjD4YtBBdI3/GBW7qixvzClDaUw
 Qr5/FybpCdYHyjKD7x2POESY6+DuZMvclCtpyimKWuhyNwAow+gqPGHfYKnyt20F/4d6
 ZfvW0EgMhKsDrJHsPkASFtqO8KzJMgBcxeOVNWkTSeGEJWfahTjIo9/vJc7S/mg6OK/l
 Bpm+KzZTA6hiRlmKfaQ4OEtFIWarwCoTIo8tfg4rXeO889gSpcCqNjgfMu+blUJmozBV
 BihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754242503; x=1754847303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JTdtXKy5hKDR3SHAhn9lLjW5N0VMb3TiHRGXoBNjX7A=;
 b=BGkLWCkPtd5Flfkccx8OT5LxVGyag6qkpkWzdt/bCCkQN62+Lvi5LkachmwAjK7hBH
 qddoV6OQi79pplVa9+i4X/1oVMwUBx84Vk9vWvadUZs0B4b5trncLHa1+fmVxmQlBmww
 H874MPDVPvLaMOwgeh5LEUYab3rTSxEUtYbIc7CkZyajKQIB6FxxuPWTqcprlgIk/5tq
 YueOLoFVXrzeGoCkiYAwvTcvXL/3k0tIgCxUr7uChRg6rdhoXdoFc+afenoeURsploXN
 11P2g4m/rgpjWeWRw1yPjowVxlqH3zVrizLHfhCpNlNPMnR23ZFtCd0xABvnPmLTqFb3
 0/zQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3PRFFjyeK4RkNSJgr+roACGW4Z8I6VRkO5+e2mYb+0pyo3YllHgOEPPAnIDna05UhMHc=@dpdk.org
X-Gm-Message-State: AOJu0YyzE4K1nJh/ATWVr5nK6uBv/A+nim+6lUyJ0jLKPhxHgT9MAIpe
 CJP2iT7cQ2UGb/e9Yvjo7QN2wY8FaxfXmaA8OoT63mxGNeZXNBLvNuk5zeOvqX8eq60=
X-Gm-Gg: ASbGnctABLSiYESa2unvjXCyc9BeLVReD2xrBL1saiNTEZn04MvGMgRr/dYMzvAA6pB
 se/EWYDWwte2OT4S/yYWuZiLedBKrtp31gYz49g4tf2hhiyDUYSZ0QfyAcxJpSjWA6Q3lG6UD+n
 vWEkJpziW8dr7QiWgbuIDDSJwf6v/U/dVwTqnITKixMX6DXfP7Ogo/tsR28t0IC94oXLG+Q1ESy
 fL15y2mvK/ikjNGGO8azXT1iHyJ4tOh3E5Ux8HNm7sYxO4cPUgw+Zmy/3x4U5rgEfGPxvQQPa1L
 xZlfpyTF3GWyrfUXCgD4ARE6YSasTbPar4r6Sp6r3Ool922wxMshqQ1tUlYug0mwLCE0mbR0w8k
 YKEcsJndaAkxKAFbngnYaOLykrNWQS8qMovOUxHHkpOwG8iKimh0fQfAvo4Qp4v/OqRG7WB187f
 0=
X-Google-Smtp-Source: AGHT+IE/q0uI3kDt4x33uEaJ+wAZErN1r1GUxAkXUR6Vnbj2D3Mj28gQAMsuHDiiqNNJJkkknUP40A==
X-Received: by 2002:a05:600c:3b93:b0:459:94a7:220f with SMTP id
 5b1f17b1804b1-45994a72576mr22547055e9.26.1754242503517; 
 Sun, 03 Aug 2025 10:35:03 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c453328sm13380512f8f.46.2025.08.03.10.35.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Aug 2025 10:35:03 -0700 (PDT)
Date: Sun, 3 Aug 2025 10:34:58 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bingbin Chen <chen.bingbin@zte.com.cn>
Cc: wang.junlong1@zte.com.cn, yang.yonggang@zte.com.cn, dev@dpdk.org
Subject: Re: [PATCH v3 2/2] net/zxdh: add support flow director ops
Message-ID: <20250803103458.65408641@hermes.local>
In-Reply-To: <20250702073453.113779-3-chen.bingbin@zte.com.cn>
References: <20250618074936.3616999-1-chen.bingbin@zte.com.cn>
 <20250702073453.113779-1-chen.bingbin@zte.com.cn>
 <20250702073453.113779-3-chen.bingbin@zte.com.cn>
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

On Wed,  2 Jul 2025 15:34:45 +0800
Bingbin Chen <chen.bingbin@zte.com.cn> wrote:

> if (hw->is_pf) {
> +			dtb_qid = hw->dev_sd->dtb_sd.queueid;
> +			fd_entry = rte_malloc(NULL,
> +				sizeof(ZXDH_DTB_ACL_ENTRY_INFO_T) * ZXDH_MAX_FLOW_NUM, 1);
> +			key = rte_malloc(NULL, sizeof(struct fd_flow_key) * ZXDH_MAX_FLOW_NUM, 1);
> +			key_mask = rte_malloc(NULL,
> +				sizeof(struct fd_flow_key) * ZXDH_MAX_FLOW_NUM, 1);
> +			result = rte_malloc(NULL,
> +				sizeof(struct fd_flow_result) * ZXDH_MAX_FLOW_NUM, 1);
> +			if (!fd_entry || !key || !key_mask || !result) {
> +				PMD_DRV_LOG(ERR, "fd_entry malloc failed!");
> +				goto end;
> +			}
> +
> +			for (int i = 0; i < ZXDH_MAX_FLOW_NUM; i++) {
> +				fd_entry[i].key_data = key + i * sizeof(struct fd_flow_key);
> +				fd_entry[i].key_mask = key_mask + i * sizeof(struct fd_flow_key);
> +				fd_entry[i].p_as_rslt = result + i * sizeof(struct fd_flow_result);
> +			}
> +			ret = zxdh_np_dtb_acl_table_dump_by_vport(hw->dev_id, dtb_qid,
> +						ZXDH_SDT_FD_TABLE, hw->vport.vport, &entry_num,
> +						(uint8_t *)fd_entry);
> +			if (ret) {
> +				PMD_DRV_LOG(ERR, "dpp_dtb_acl_table_dump_by_vport failed!");
> +				goto end;
> +			}
> +			for (uint32_t i = 0; i < entry_num; i++) {
> +				offlow_key_dump((struct fd_flow_key *)fd_entry[i].key_data,
> +					(struct fd_flow_key *)fd_entry[i].key_mask, file);
> +				offlow_result_dump((struct fd_flow_result *)fd_entry[i].p_as_rslt,
> +						file);
> +			}
> +			rte_free(result);
> +			rte_free(key_mask);
> +			rte_free(key);
> +			rte_free(fd_entry);
> +		} else {

This code uses rte_malloc for temporary buffers.
It would be faster, safer, and better to use malloc, calloc or alloca
for these arrays. The rte_malloc library allocates from shared huge pages
and the algorithm is slower than malloc, so should only be used when needed.
Also, static analyzer and compiler tools know what malloc is and do
a better job checking that.
