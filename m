Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBF6CA0EDC
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 Aug 2025 19:46:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5FCE340292;
	Wed, 20 Aug 2025 21:46:48 +0200 (CEST)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45]) by mails.dpdk.org (Postfix) with ESMTP id C9AD44026C
 for <dev@dpdk.org>; Wed, 20 Aug 2025 21:46:46 +0200 (CEST)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-3b9edf504e6so201124f8f.3
 for <dev@dpdk.org>; Wed, 20 Aug 2025 12:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755719206;
 x=1756324006; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uXgv7kp7v9qR4AvonqUjoh5QmzUnaYfDnGkaICm3FoQ=;
 b=Pf17xH+YlpmXYzzAmGyurw1b4uB0lAIWtK8GAPO9zTi71UsCix2fFlTcYd9KBPwxV+
 7FEFFcTHKMmtbzA9JpvYxsFvrZrmaNJ0OcHGnP6M5Ne4uvnQHN3CTW92r6hyNty6+aAz
 Bk7ZR+xH2TAePPcLn9ZPV/ENBNtRl3IDSYEBmxuPzhjRJZQXd58Qq1vQv4FPqFCXr2Xk
 gbx7Zcd3nbcitaPajyEuzmkLX+6xgjmX/kE8XAtUBRWzqEGEI7Y02pOtEMP4P3cjhMWr
 oNQoKSPUSPQ6Ra6o29L5xidccgzbPqc/meTXWoBmYmP17PV50IPtieeU62N8fUXZB+T+
 7LEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755719206; x=1756324006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uXgv7kp7v9qR4AvonqUjoh5QmzUnaYfDnGkaICm3FoQ=;
 b=t60vUVgic1aofoc/P/YVFUH/PW9HTZAdoLmXNKRn6BsrKEFQ7Q7cP96IA5V0UAcm47
 8n/062E8MlnsScIDjXChgmjGk1Fm+SzLZ6VBeQ81J7w5mCZwFJWUibwP25PdbeBIURGL
 vWFMeMtr5nfkvnn+9m2PCY7lw3Hfrp3AhAzgBTZUPJ5wmpgVCffIh7TWXNPBulQcaY35
 NxWk2va2XaIcEFTPel8UMoAmRwihG7q2UXkU75GaBBYb6cpS7oi2XSMspzqkgcf/WUGr
 +2ynMGwnfCFpOUh5r69iLzC4OO3hU1RtCN4/NFf+4TJZcZoMEWVgh6g+RV3pDU1gy5wk
 7hKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZGmeMJkCBcGAd2WkAhsgR0Sy49XmAoYuyuhTdRmMFJ2ZQgMhK4nYJKPzdQRk83nGg4Ew=@dpdk.org
X-Gm-Message-State: AOJu0Yzzdf5l6F/e4ew0OblgeBxa2SdgkB/ck+54NOWiI+EGxgwSNPdW
 bCHc9ZmGf7pSQiHsy6FsEIoOjOKVRyeYUgqkcizhckD1ZzM/nJih9lVSzrmbaIMedVxWyVDdj2m
 su0HjsKE=
X-Gm-Gg: ASbGncvnhwH0e/ACAopoYlPuS3xx+k0tc0AJ2ZqJ2DGEDMCxZ233gu5cOcC0ESQduqR
 VXpjzPCMvmtNERZRE5+bbT+1ncL/jMJsNm59ACfUPzB4g/fwfH3evWn31Dy9hGhF59oLJWrSVuF
 rh3DvLWs4K5Lz+CHg+RXZmGzkx++tZjiiSTBPBpKVjTciUuG9NwHYQoGEpr0uOAiTcyxzsEK/Ks
 90Wm7LW2nqfxfHZUKBkzwFWBXFLEBFUWOH4Ii29NVcEefa8M6Y4x08lMmb/adk0Mlmzw5NlN7EL
 HPgdLhfo+xFiwt6c4nZesd72Q51Y9S7p7qjQIXp0JAb3V4UL6fjN/5Fa7yJwrS3INTh9FfZ+utp
 sKdAppOgZdoQMy4ctrBN0KrO0dhyFKWoU8ncGPYhvdtD7uYuhdRwJ9Ib2kej35IAnPdR6CIh9ED
 I=
X-Google-Smtp-Source: AGHT+IGxPnnNe8/WPDDlcuqnv+cNjviSZIeNFWJNh0xhms3G4sqJQAW7bcKgG9lzuMll9Fk5z1NVMw==
X-Received: by 2002:a05:6000:2c07:b0:3b7:6d94:a032 with SMTP id
 ffacd0b85a97d-3c494fc6289mr50948f8f.3.1755719206269; 
 Wed, 20 Aug 2025 12:46:46 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b47c33203sm44770765e9.9.2025.08.20.12.46.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Aug 2025 12:46:46 -0700 (PDT)
Date: Wed, 20 Aug 2025 12:46:41 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bingbin Chen <chen.bingbin@zte.com.cn>
Cc: ivan.malov@arknetworks.am, wang.junlong1@zte.com.cn,
 yang.yonggang@zte.com.cn, dev@dpdk.org
Subject: Re: [PATCH v6 1/2] net/zxdh: npsdk add flow director table ops
Message-ID: <20250820124641.152b667c@hermes.local>
In-Reply-To: <20250815074221.2254545-2-chen.bingbin@zte.com.cn>
References: <20250814025248.2194951-1-chen.bingbin@zte.com.cn>
 <20250815074221.2254545-1-chen.bingbin@zte.com.cn>
 <20250815074221.2254545-2-chen.bingbin@zte.com.cn>
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

On Fri, 15 Aug 2025 15:42:16 +0800
Bingbin Chen <chen.bingbin@zte.com.cn> wrote:

> +static uint32_t
> +zxdh_np_agent_channel_acl_index_request(uint32_t dev_id, uint32_t sdt_no,
> +			uint32_t vport, uint32_t *p_index)
> +{
> +	uint32_t rc = ZXDH_OK;
> +
> +	uint32_t rsp_buff[2] = {0};
> +	uint32_t msg_result = 0;
> +	uint32_t acl_index = 0;
> +	ZXDH_AGENT_CHANNEL_ACL_MSG_T msgcfg = {
> +		.dev_id = 0,
> +		.type = ZXDH_ACL_MSG,
> +		.oper = ZXDH_ACL_INDEX_REQUEST,
> +		.vport = vport,
> +		.sdt_no = sdt_no,
> +	};
> +	ZXDH_AGENT_CHANNEL_MSG_T agent_msg = {
> +		.msg = (void *)&msgcfg,
> +		.msg_len = sizeof(ZXDH_AGENT_CHANNEL_ACL_MSG_T),
> +	};
> +
> +	rc = zxdh_np_agent_channel_sync_send(dev_id, &agent_msg, rsp_buff, sizeof(rsp_buff));

You were probably taught somewhere to initialize all variables. But that is actually
outdated recommendation. Modern compilers detect uninitialized variables and therefore bugs
rather than just getting what was set before.

For example here. The first declaration sets 'rc' but then the first call is then
setting rc, so the initialization in the declaration is redundent. I see lots of this in this code.

The best way in modern code is to put variable declaration as close
to where it is first used as possible.

	uint32_t rc = zxdh_np_agent_channel_sync_send(dev_id, &agent_msg, rsp_buff, sizeof(rsp_buff));

> +	dump_depth = dump_depth_128bit - start_index_128bit;
> +
> +	dump_data_buff = (uint8_t *)rte_zmalloc(NULL, dump_depth * ZXDH_DTB_LEN_POS_SETP, 0);

Since rte_zmalloc() returns void * cast here is not needed.
This extra cast is done lots of places.

Also, can this be from heap (malloc) or stack (alloca) instead? 
Or does it need to be in hugepages for DMA reasons?
Same for lots of other buffers in the dump code.


