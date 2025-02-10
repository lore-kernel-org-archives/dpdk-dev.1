Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A344FC02198
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 16:56:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A972427B2;
	Mon, 10 Feb 2025 17:56:11 +0100 (CET)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id DE210427A0
 for <dev@dpdk.org>; Mon, 10 Feb 2025 17:56:09 +0100 (CET)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-21f40deb941so95532435ad.2
 for <dev@dpdk.org>; Mon, 10 Feb 2025 08:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739206569;
 x=1739811369; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7yhp0oQ6xt1oQ/HYuQJKyI1ZRkP//4a5kSqlNtaqDRE=;
 b=su//J5D4ETTns11PooHD3zTYOdUL5NeiWzXzlWHuMP4MDuqudGYc4Ma+Z4H40Q5QBf
 oT75G+ofKY5m8W3UgczxCJAVX5TMNf6TlQadrIa1Fb4iz4U9myz1nSqha3aQPtalH+iu
 6yh8jRenB0i8yJ58L3Zb6VMg3OzUVxvM26Is4PU051lMD76AC/i3/HsqWg1r5jTnxmJB
 m/80tiAnXsuVbfNJ7fJ2g8IO34964kytGrNBH0mODPsJxDmw4JNU8HueDxPHmFIFY6+v
 SHr8LncqUxgIlditzR3L1Ll8hQzPkZd7y5utHlfwVTyNCtXcQlOkbWSdjlSUT90u3zKL
 wgvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739206569; x=1739811369;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7yhp0oQ6xt1oQ/HYuQJKyI1ZRkP//4a5kSqlNtaqDRE=;
 b=j1qxkdMIuEpG3zGptxbnbFuL2pOyrIQfh641Fek/x8wX26ibsyh5jJ4HV4l3RYMlUg
 FNN7zmh9aP6s68f/ZkxnYAKc9snynne15ReNnOoKULlvExZS3sFqumENODV0q7zoYe7W
 G1fWiuWee6OTAMm5//iUkuXzrNhegSY8oYf9bPNNUrPDYFs/7aZHQ84+aGDZbV9D2mnD
 bVo+ZGY1ySziQ+pZ3VPl122vLUuleIHBufAc+ZB1gCigqrOFYpy3/i2N4XAKanLM4AsI
 8eXcDbwThGajpsEc5JJ39wwIL7FUdu2Ae8JVrDp26H+AKnRwOHjA+TpuPcJpZYb3yLga
 vnkA==
X-Gm-Message-State: AOJu0YxquolGwMugzQcmWCIwUJQFHI5y7oeWIXbtvVB2xS3Fqs2le7ql
 D7jM+Ks6HNBZVjIfxdy32rQXetmMxyxTTli3+9wYuBA2qRCr8DIpcR/SfggaeFE=
X-Gm-Gg: ASbGncuJ+OicYeL+R5vvuye0ZegEwXRlVRB+TtChZ8zT8H76nzDeRcZebDyzcHw9IK2
 QpLr22C3qpUVWSplTv0tH19MjGY9zACphG8adSh85ReIg6ccT0CSD2YUL+WUp6/GqFNekoYYrEl
 rcXD0UJHW87ZwpwdGQXm0mfM44jMh0MWOccUcHTUevNETlRENEAaXxWXxDaXd2uQaodwo7QFuiD
 gd7iXQIuv2M8+k9rM+Hy15TCLsAKhUkfVLjwctit3gUrrywl3q8K3UpQDcKgkrSL/8FT2AhEMhI
 uB2ze3Smtf/td4ThUmR2RaeCBA5G9QKJyxPy0T+3lw+E6iIBdKJXwSPzt9jZq3TDreS5
X-Google-Smtp-Source: AGHT+IHDXpKh6L0yBdeWly1GXpSpXZW4YwVyMr+PcgrC7TTkDeqIifPN20YGXVRJqOM/omw286PNHw==
X-Received: by 2002:a17:902:f688:b0:21f:7a8b:d675 with SMTP id
 d9443c01a7336-21f7a8bd917mr163187835ad.4.1739206569001; 
 Mon, 10 Feb 2025 08:56:09 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f3653afb6sm81437255ad.53.2025.02.10.08.56.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 08:56:08 -0800 (PST)
Date: Mon, 10 Feb 2025 08:56:06 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bingbin Chen <chen.bingbin@zte.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v1 01/14] net/zxdh: add network processor registers ops
Message-ID: <20250210085606.3789a116@hermes.local>
In-Reply-To: <20250210011924.4104325-1-chen.bingbin@zte.com.cn>
References: <20250210011924.4104325-1-chen.bingbin@zte.com.cn>
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

On Mon, 10 Feb 2025 09:19:24 +0800
Bingbin Chen <chen.bingbin@zte.com.cn> wrote:

> +ZXDH_REG_T g_dpp_reg_info[] = {
> +	{
> +		"cpu_ind_cmd",
> +		669,
> +		SMMU0,
> +		ZXDH_REG_FLAG_DIRECT,
> +		ZXDH_REG_NUL_ARRAY,
> +		ZXDH_SYS_SE_SMMU0_BASE_ADDR + ZXDH_MODULE_SE_SMMU0_BASE_ADDR + 0x00000014,
> +		(32 / 8),
> +		0,
> +		0,
> +		0,
> +		0,
> +		4,
> +		g_smmu0_smmu0_cpu_ind_cmd_reg,
> +		zxdh_np_se_smmu0_write,
> +		zxdh_np_se_smmu0_read,
> +	},

For complex initializers like this, it is better to use explicit field names.

	{
		.name = "cpu_ind_cmd",
...

The problem is that if you get something in wrong place only some analysis
tool many years later will notice.
