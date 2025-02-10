Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEBDC02198
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 18:24:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F400440666;
	Mon, 10 Feb 2025 19:24:29 +0100 (CET)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47]) by mails.dpdk.org (Postfix) with ESMTP id 2EB384060F
 for <dev@dpdk.org>; Mon, 10 Feb 2025 19:24:29 +0100 (CET)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-2fa1fb3c445so5637125a91.2
 for <dev@dpdk.org>; Mon, 10 Feb 2025 10:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739211868;
 x=1739816668; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xjwmhHHxRfNKD2dJn7cLWhATSTRBuH5IKDm868vZHPs=;
 b=eu5q6Ce7EZPqRAadyN+VFa475cy/5vozCTjts/+LQjAbirab4UvakLFgZ1kkSF7Ffz
 Tc1074o/bHCZikQaJ+IHxpyP7frZHtKmaCAY39lL88R5V7mAaRYs7B/WAPspIjbMCqlw
 24IC0vbNTJcm7WLGIB4Pnk4QFV9XW822qgZixC1m60PAAC1RIs1FW2NR960NwKffJGJ0
 6PimlHGB8aj0mpB7vEhsBSZ9d9KoETv9/bPCMAbjrWTcqAQpH/5YSNabH3bNU3eLpbe2
 ar1Vjb1ao4dND1NXmKGTM2pvuLv858SEw2nxmpb8B7E0V+2CjIltdTzEghp0phSOISHw
 zpbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739211868; x=1739816668;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xjwmhHHxRfNKD2dJn7cLWhATSTRBuH5IKDm868vZHPs=;
 b=Zb+E69IoS8V+ooDZ2iZP/5xx5ZNTzGk+sovyDqmcwI/hduaHyDeqDXRhGoUD/tvFnR
 kWNZf34a/jnTAFoou6Jp503kPFPPgVszHru8WSwVeWfQs2LNVvuo51luPN4BGVREwRGr
 oFMp1qWMUGR95lrUGhnmJeaCV4n0Jbc7WVbhxjrPOxnnp9bLfWVehDMwopXvwLT9jk/j
 DZ6fD9HgJUfV1xk4u9Uo7PQ6xHcjT6/CnQAB4ud/YI7Vbdx8QQ/jfYFlswh2jOPf/Ziy
 u4hg9vXr2nhrI8O/g/NPdR1/KUnjZEf/X0ltrlLTFT/D4SEE1KPRv2t6xgEpKU2Skthd
 8Z1Q==
X-Gm-Message-State: AOJu0YyfGZ3HihKByrL8K7EHXlJ0/rorMetIsfyidtEJQPJIdUO3/sbv
 cb/O1l4jVFFhMOpbTlVgoO/91HmFDSsuosovagwuxq4UCRmuZrVf02swP84jx2ZigO/mtZ9eJlW
 I
X-Gm-Gg: ASbGncuYHaZACxUqorx6uOWgB8/8/CtgE4WKYK8xggqnvbj7oVNs3mAZqZJ2NZT7Rg4
 xzDfU1U6dkNTjOp+9L2un5WS6qVj4bOEeQcJqoTyn+S2VVw0SMp/anHSu6iU3CF8hxeDQg7RqsR
 zz528Ghgvs42gHOQgu5UqkEvaOKyWiAuin0P3yTSzh1ILdyy8bGwSzOYdiTtV0I+pSxhBnQM3wS
 EBmsTcmnz3jrZ7Bdg6bVMIwb4ReZnnydmF+0/i0IGtvK6MvVQIOCML4LUuFUan2TR4CxH/6oMRF
 dFbmUxnRJ4auHU34F4cz5WRcMHn42T6hEHPoBqWlq/+VJlmploAK4j8jPJ2TCah+E0eX
X-Google-Smtp-Source: AGHT+IHN6ffsYVKjSQ4ELLRzedHL+fTtxVfDfyfmXGPgaRW4A0UPZMfeouhgsCGrAZ52VHxkUuu1lw==
X-Received: by 2002:a17:90b:4d08:b0:2ef:33a4:ae6e with SMTP id
 98e67ed59e1d1-2fa9ed7db98mr939463a91.12.1739211868251; 
 Mon, 10 Feb 2025 10:24:28 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa42dde5e5sm5519217a91.3.2025.02.10.10.24.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 10:24:28 -0800 (PST)
Date: Mon, 10 Feb 2025 09:35:32 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bingbin Chen <chen.bingbin@zte.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v1 07/14] net/zxdh: get flow tables resources
Message-ID: <20250210093532.012adf97@hermes.local>
In-Reply-To: <20250210015017.4105624-2-chen.bingbin@zte.com.cn>
References: <20250210014441.4105335-1-chen.bingbin@zte.com.cn>
 <20250210015017.4105624-1-chen.bingbin@zte.com.cn>
 <20250210015017.4105624-2-chen.bingbin@zte.com.cn>
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

On Mon, 10 Feb 2025 09:50:10 +0800
Bingbin Chen <chen.bingbin@zte.com.cn> wrote:

> +static uint32_t
> +zxdh_np_agent_channel_se_res_get(uint32_t dev_id,
> +								uint32_t sub_type,
> +								uint32_t opr,
> +								uint32_t *p_rsp_buff,
> +								uint32_t buff_size)
> +{
> +	uint32_t rc = ZXDH_OK;
> +
> +	uint32_t msg_result = 0;
> +	ZXDH_AGENT_SE_RES_MSG_T msgcfg = {0};
> +	ZXDH_AGENT_CHANNEL_MSG_T agent_msg = {0};
> +
> +	msgcfg.dev_id = 0;
> +	msgcfg.type = ZXDH_RES_MSG;
> +	msgcfg.sub_type = sub_type;
> +	msgcfg.oper = opr;
> +	agent_msg.msg = (void *)&msgcfg;
> +	agent_msg.msg_len = sizeof(ZXDH_AGENT_SE_RES_MSG_T);

All this would be more readable as one initializer

	ZXDH_AGENT_SE_RES_MSG_T msgcfg = {
		.dev_id = 0,
		.type = ZXDH_RES_MSG,
		.sub_type = sub_type,
		.oper = opr,
	};

etc.
