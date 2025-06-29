Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D45C7EE30
	for <dpdk-dev@archiver.kernel.org>; Sun, 29 Jun 2025 17:41:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D08BB402D2;
	Sun, 29 Jun 2025 19:41:37 +0200 (CEST)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com
 [209.85.219.43]) by mails.dpdk.org (Postfix) with ESMTP id E3C7240288
 for <dev@dpdk.org>; Sun, 29 Jun 2025 19:41:36 +0200 (CEST)
Received: by mail-qv1-f43.google.com with SMTP id
 6a1803df08f44-6face367320so16294996d6.3
 for <dev@dpdk.org>; Sun, 29 Jun 2025 10:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1751218896;
 x=1751823696; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KE4d+UNWPSTB7l3+5uFH4ebO9gM+KiS6Pa3YS8nrcq8=;
 b=VsiEm9vMNUDtfxWmOIkIg3WnFNTXTpOn1PyTmvRXA/WnzdzHlpfJ8cklR5hbMbAYmo
 CbzDOtQxCmth3ixCm1LIloAYlxoM7fEdagaJmOZYRu5DJXYNmzu+vpe0B3QneqFEAsUx
 D5/8//pYJ8N9P5sFAjUyYTit9jbaOGyoKD5NzBoH/X2gkt4gH7tD3HEG3QX6TZe4YFmi
 uqBNKJOu59ktAeyeRm5ndx68IfRdbu2IbEgL+vP1WNv+MDKRHLj5kygTjRk5ue4LFAal
 +BQQY7TpQUfnzZkmB7yBF04JiTpiqudDccfQZUviayew0HYo+tRJCxuMqDyM5ArXYLYM
 XTLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751218896; x=1751823696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KE4d+UNWPSTB7l3+5uFH4ebO9gM+KiS6Pa3YS8nrcq8=;
 b=WfNrM992IWFeLE61U9cqFOX1KZql1rEsfdsZfnlGnASJJ8+lePzz3UvlzMeOduo0BY
 De45twQ0eTIufmbhekePEzPsxwbtz2mkZ2L1+mPP8S5D+mJE1IEhqUbWI2w9ZqjYnfhY
 ySvkt9gtGXIWjb/fegBt0Kf/q1xVbG73dG11wJAEVDApgu5xe+BtPeanlJB5lKWgwAwI
 qhVozPP77HU511U2bLQLnei/304JzNNCdss2RjAj1JPHApGq/22xtLn0GxwrF026tp3f
 fuT1ft4u96eIHdsAcFz6NbrDVYl9CrhZxF7qUoA3/DcJwOuzfRkU7tTR7F4ClgywFYoL
 cAEA==
X-Gm-Message-State: AOJu0YxeFYNug6BSmwBpaTkJZ7aGmyncXMDGPUl5z0bQ8QFY7VZkslWp
 ruPO7xLGTa+NCserOnvUIM5U0zAg1XQLY73c4KxnZcqkzC3gBg6R6aIGU9GUd+3Sv5almwjBhc/
 ABHqzpkQ=
X-Gm-Gg: ASbGncvSX82Leod9gWFedVRo8dY1PL5THjuhABEI6/FHl1RBvXCJl6Sf9ob1DTRghUG
 5aEvPw8Ur4EhoYOepvJrw6BI2Kfw50pqynILbqf/FUarHcS+06wSUSft92bldbRrepVOlPd8wTP
 pgYE6l3aF4PD/HLa+5YdSUNlpqgn0WA/KfPLL4EStcrVn6YOPf3iXBzV9rXCVi+R1PVHk4ddXvA
 3a7c5ViTMQYvpybpm+J9U+JOwyyJThCh/JPFud7r1JvjmwbwvWfh9m/IuAzdxVIMMyqwtrHZWqF
 sz2g0G8cw8Ub0BIdoiiDrgv9wLLfb0wyDfc47/ujZsfSFrV57dsVHH1Ubr83yr7JS60tEzVu8kn
 NO1p720CT8dVturbrrXHeoS8+NmmuT46OOFXus3I=
X-Google-Smtp-Source: AGHT+IFTYzIUhN7wbqV02bbG5Yf3p2PEfjf0Crbnxij/CJHhjqAxQyHNGPqwjssLll/H/nrqHIRkhg==
X-Received: by 2002:ad4:5fcf:0:b0:6fa:bd17:32a with SMTP id
 6a1803df08f44-70003c91fb8mr168574046d6.29.1751218896141; 
 Sun, 29 Jun 2025 10:41:36 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fd7730ad9asm54187516d6.107.2025.06.29.10.41.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Jun 2025 10:41:36 -0700 (PDT)
Date: Sun, 29 Jun 2025 10:40:55 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dengdui Huang <huangdengdui@huawei.com>
Cc: <dev@dpdk.org>, <lihuisong@huawei.com>, <fengchengwen@huawei.com>,
 <liuyonglong@huawei.com>
Subject: Re: [PATCH 6/6] net/hns3: VF support multi-TCs configure
Message-ID: <20250629104055.0b38c168@hermes.local>
In-Reply-To: <20250611081900.3658421-7-huangdengdui@huawei.com>
References: <20250611081900.3658421-1-huangdengdui@huawei.com>
 <20250611081900.3658421-7-huangdengdui@huawei.com>
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

On Wed, 11 Jun 2025 16:19:00 +0800
Dengdui Huang <huangdengdui@huawei.com> wrote:

> +#pragma pack(1)
> +#define HNS3_MBX_PRIO_SHIFT	4
> +#define HNS3_MBX_PRIO_MASK	0xFu
> +struct hns3_mbx_tc_config {
> +	/*
> +	 * Each four bits correspond to one priority's TC.
> +	 * Bit0-3 correspond to priority-0's TC, bit4-7 correspond to
> +	 * priority-1's TC, and so on.
> +	 */
> +	uint32_t prio_tc_map;
> +	uint8_t tc_dwrr[HNS3_MAX_TC_NUM];
> +	uint8_t num_tc;
> +	/*
> +	 * Each bit correspond to one TC's scheduling mode, 0 means SP
> +	 * scheduling mode, 1 means DWRR scheduling mode.
> +	 * Bit0 corresponds to TC0, bit1 corresponds to TC1, and so on.
> +	 */
> +	uint8_t tc_sch_mode;
>  };
> +#pragma pack()
>  

DPDK has portable macros for packing __rte_packed_begin and __rte_packed_end.
Please change to using those macros.
Then rebase, retest and resubmit this patcheset
