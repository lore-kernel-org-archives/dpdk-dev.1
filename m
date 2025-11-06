Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C103CCFA13
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 19:24:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D2A894021F;
	Thu,  6 Nov 2025 20:24:52 +0100 (CET)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47]) by mails.dpdk.org (Postfix) with ESMTP id A34594013F
 for <dev@dpdk.org>; Thu,  6 Nov 2025 20:24:51 +0100 (CET)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-340ba29d518so989842a91.3
 for <dev@dpdk.org>; Thu, 06 Nov 2025 11:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762457090;
 x=1763061890; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jhoZaxn1p8Zy3e9BxyFhVZ8WXbJyeEZ0Wi0uxnUWYzE=;
 b=VIFh3PLdcj3vkuWqTU8U+5q41WJFDWIDQJQ3sAaY+Fkw6U0IFn5ILgmJMEbzfjfkl7
 GU6ehgWT8I2vt1mm82Erdztcb5ljlJKfMvYKk+Ij0AgVT3+Jc+fBC4TYvzpUuUvrid4i
 IM0w90vYC+cMeboDV1tHR0Iq2Ho/4QJPG4G9gwdlNu3lAJ/WiqGQ/lVOwPMPpT7pi4y9
 CKC8JNGroHi81RTjy6uM6kAfpe0z527qsqB6R75EOYKUhqRyLI5281r5+tERTlAkn+zs
 mkhyS3mFXPvXOFUimI4WXoT1poyqO5a4jdbmJQ5JjWLPRR68Vr/OFyONMCQi5tw4YpDX
 2cBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762457090; x=1763061890;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jhoZaxn1p8Zy3e9BxyFhVZ8WXbJyeEZ0Wi0uxnUWYzE=;
 b=QiXi/EIPiJ8sx1RSw1v8hUEh8oe4t3nw2sKlTAzMAiF9Z04aFHi30Fl8zTZgii8Djo
 NGNe+RFIzs5fOXT37tJNOpBg+kVq7Y7CqLL+fL6wqRFjUoM6p+lKJhUwrrL1KlNMU9Pl
 /iRAd809U1cKJ3a8wmC8QJG8K9JRrXaVTB1TTLFLbMpTrAyJofgDEZA3C4shStbvhTDC
 /yRM5pSqaNYshl0cSELhKXgUwYaHnOm+c2t0lptB16I86xacWJOhKovckJw8dVRDTpr+
 KnLUTG1iULsF8TW/Y7dbRj7YSFtLRIv12o08Jcfc4snpUDZUIiwW0YJ8cf80LGknZKw0
 utKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVk84GwqNCB6NMuRr+XvZeuQjV5e8w0Kyl8HtShTbgOoeUMYDGNyPxwrnOKPna7A/zMM7s=@dpdk.org
X-Gm-Message-State: AOJu0YwKE84ZCkUyc/ymjzsO9KlIe9wTFUMEmdr+plOHWweTmvuZO4pg
 NcEexXvK7aQg0T4VpaGan5FcNFX8zXL51lo6ZY2bDQhBhDsyTutHbzs9oa5lck3zyuc=
X-Gm-Gg: ASbGncthxRDPnJoFzaSLhk+WE1+m5kuEKvlH4L/8NJpj6sLzfgaBA1nItD74INed2wP
 cJ5/Mj/zb09jnGUzMH2DJxBxz9b6vzODJuhYOIVW/0G0sru4HAmDWMAHY60v++knm4fDD98y4wd
 Am2ayZRWeNRXg5tkVSl/TwQTENSgJ8KkaqQm1Yq9+rh65WVPi61YfWPYA+lihTCih6R+7l4sy4X
 C+5nm7khrDBblllcCRCmjq0ivFfSB4wnSjoLm5ThZOH7QIUrPYimuql13QrXkJl0R58EBAvN3WY
 7akroATuU+RNLfxPQnr66rCbZFcW2bm8aMusZXzKpE/nuKvprOIczj57SEVNAwLjV0XaYDQB1AC
 vPr6d5u6VA8KMoQsauJaQeGWw7Cf97HacrjwupVA0tFcFRNa0ZYFdoN5SN90xSx5JIsU7+c13/C
 tTtLHcheA6sjiIU0eDp2UiPPSwTuD5gYUgdg==
X-Google-Smtp-Source: AGHT+IHnUZ+7aIhGLoBCiOcXb/P1sSh9CUMxChfK9+h4M6T88aPVQnJZzUSVDiSZcmZmo6tzrSMU/w==
X-Received: by 2002:a17:90b:2590:b0:33e:2934:6e11 with SMTP id
 98e67ed59e1d1-3434c4f966fmr401594a91.11.1762457090524; 
 Thu, 06 Nov 2025 11:24:50 -0800 (PST)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3434c3569f1sm216192a91.20.2025.11.06.11.24.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Nov 2025 11:24:50 -0800 (PST)
Date: Thu, 6 Nov 2025 11:24:47 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Chengwen Feng <fengchengwen@huawei.com>
Cc: <thomas@monjalon.net>, <dev@dpdk.org>, <aman.deep.singh@intel.com>,
 <liuyonglong@huawei.com>, <yangxingui@huawei.com>, <lihuisong@huawei.com>
Subject: Re: [PATCH v3] app/testpmd: support specify TCs when DCB forward
Message-ID: <20251106112447.7b13d440@phoenix>
In-Reply-To: <20251106124959.2592-1-fengchengwen@huawei.com>
References: <20251104040916.25864-1-fengchengwen@huawei.com>
 <20251106124959.2592-1-fengchengwen@huawei.com>
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

On Thu, 6 Nov 2025 20:49:59 +0800
Chengwen Feng <fengchengwen@huawei.com> wrote:

> +static void
> +dcb_forward_tc_update_dcb_info(struct rte_eth_dcb_info *org_dcb_info)
> +{
> +	struct rte_eth_dcb_info dcb_info = {0};
> +	uint32_t i, vmdq_idx;
> +	uint32_t tc = 0;
> +
> +	if (dcb_fwd_tc_mask == DEFAULT_DCB_FWD_TC_MASK)
> +		return;
> +
> +	/*
> +	 * Use compress scheme to update dcb-info.
> +	 * E.g. If org_dcb_info->nb_tcs is 4 and dcb_fwd_tc_mask is 0x8, it
> +	 *      means only enable TC3, then the new dcb-info's nb_tcs is set to
> +	 *      1, and also move corresponding tc_rxq and tc_txq info to new
> +	 *      index.
> +	 */
> +	for (i = 0; i < org_dcb_info->nb_tcs; i++) {
> +		if (!(dcb_fwd_tc_mask & (1u << i)))
> +			continue;
> +		for (vmdq_idx = 0; vmdq_idx < RTE_ETH_MAX_VMDQ_POOL; vmdq_idx++) {
> +			dcb_info.tc_queue.tc_rxq[vmdq_idx][tc].base =
> +				org_dcb_info->tc_queue.tc_rxq[vmdq_idx][i].base;
> +			dcb_info.tc_queue.tc_rxq[vmdq_idx][tc].nb_queue =
> +				org_dcb_info->tc_queue.tc_rxq[vmdq_idx][i].nb_queue;
> +			dcb_info.tc_queue.tc_txq[vmdq_idx][tc].base =
> +				org_dcb_info->tc_queue.tc_txq[vmdq_idx][i].base;
> +			dcb_info.tc_queue.tc_txq[vmdq_idx][tc].nb_queue =
> +				org_dcb_info->tc_queue.tc_txq[vmdq_idx][i].nb_queue;
> +		}
> +		tc++;
> +	}
> +	dcb_info.nb_tcs = tc;
> +	memcpy(org_dcb_info, &dcb_info, sizeof(struct rte_eth_dcb_info));

Prefer direct structure assignment over memcpy() here.
	*org_dcb_info = dcb_info;

This makes sure types are the same, and compiler generates same code.
