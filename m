Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19743CCD195
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 18:16:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DDE7B42E49;
	Fri, 17 Oct 2025 20:15:59 +0200 (CEST)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by mails.dpdk.org (Postfix) with ESMTP id F270242E47
 for <dev@dpdk.org>; Fri, 17 Oct 2025 20:15:58 +0200 (CEST)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-b5579235200so1408423a12.3
 for <dev@dpdk.org>; Fri, 17 Oct 2025 11:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760724958;
 x=1761329758; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YVKEl++4CzhuaRoKLO3E7JjlmwAd5A7YPbibvI+G/9o=;
 b=fhcIqDlZDtHAIMBLo36UthLO+1gD0ZBjw0k911nN3qhcYQ2z1sQIprPluv3xtEo22W
 yrC3T4ZWYBipzvdurLTxzo61WMVKNu3e5oWMeaTjPFlc8PbIHNdUYx7FWvrER6aBjHT3
 Tqr/8iBZwRrJolX+DJMaKLfJ1czHfRjKhzzm4eOwh2xqwpXd0QFxLD5NbLl+XX2GT6tq
 Bdz/oXpXDLiiqtMNUsSo3U0yTyGg9mLZHLq8BSsEK4LywFmI9PeuSTSegafQf9pPELKu
 zJadH16Nk2mbEOmwPoH8KoD5mDn5uwVSA42TNmwyT1ZAj0pPy1D7YOM+kBzDV9xSwm8D
 0ISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760724958; x=1761329758;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YVKEl++4CzhuaRoKLO3E7JjlmwAd5A7YPbibvI+G/9o=;
 b=ofnEpd3c5XhpFOHE2l6MrTBxsNy59fKPzqTwV9GMSgqdkBGx6h2X9Xxf9XK+jJ38YK
 CWaxgiQJGq4xNOajtR3aA+r4s6Ize1NgUfM3fzGgkx5PtrokBekx1DBXXHEG9E4ETUtZ
 BFGQoz272EOnq1b8oO6NPCzs0fQwgC7v+YWoaFn2cobA3lQKCJHeZtxBjoDPA6nOTu5E
 cFZAhYPizA+VFNqiNAsXSMNpSoEOV2UVmopmBFKSHCXbfb5zeo5L4NgLU/+oMciE/Jv2
 aoDX6gUU77rbBk0BMDSC7j/ajfteunyeDPct696RHXSeAFyro3+9eunfkmwB/k2dAFGk
 mPbw==
X-Gm-Message-State: AOJu0Yxa3YbKLDKwbmPh7paYN3ifmF4vXAIrJ/5ApBU4P9hW1CMDQStC
 chd/5BocFBUdKEBAGhaV/yuu/0FG0CbyE+Sl2jwVgcdVcZsr1RqqpJpywqWKLysVLVXvLQ9fEoQ
 xzclzQuA=
X-Gm-Gg: ASbGncuHZJIoKkteoVPPyf5WfLwfAqHZ2/VKTEMrNew57JJ5iOkN7lcN1YKrfeK697m
 xJti/6y8/gkBQRKHaa1L976hdtHMBlnkSVHqM5LWOc16zD8PiK1UelG9D5nwrgIHPMcoapTPHwf
 2dL5oZe5rQReazjGQUl/0E7oqNqeqpzXzvS2WNVW7G3SY0GVkGvgmSwa2ML9JMIlTIb4cJa5m3n
 i6E0yjcx+v+39fpGaf+Flvln3TcDjNaP4G2yuQjvMrHjTdpo8rIQuybNkw5l2VsEnLTAmQf7b3O
 pO5fp0ghHZ427QDd4cy+Lm4b5Y1AP8RbTyCVJsSo0fFUHjJ3IqybyrhTA2QbzhP34GKoJtPxC0i
 qwD69JYN2yPHqQe/VRIFvGhRkeUFUD5r/2tfHPdDVkJeSQE+xSQfcxw619wy1UK/qH7HQ5kkvcJ
 Pe8lj3SFCS8BV2ay1rsu0NRhUk/xGhbmorMY/S6vE=
X-Google-Smtp-Source: AGHT+IGzIN/gPL/i37pTZohvOqoFKlcnt0YT5PygYdzWoWvL8x/qGiJtgpqBLDmEg6PGHo3dExFwKA==
X-Received: by 2002:a17:903:1d1:b0:264:ee2:c3f5 with SMTP id
 d9443c01a7336-290c9cbcca1mr61346675ad.19.1760724957928; 
 Fri, 17 Oct 2025 11:15:57 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29246ebcdefsm1825405ad.16.2025.10.17.11.15.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 11:15:57 -0700 (PDT)
Date: Fri, 17 Oct 2025 18:52:36 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gagandeep Singh <g.singh@nxp.com>
Cc: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>, Sachin Saxena
 <sachin.saxena@nxp.com>, Jun Yang <jun.yang@nxp.com>
Subject: Re: [PATCH v5 5/6] bus/dpaa: Set max push RXQ number
Message-ID: <20251017185236.05ba6d9b@phoenix.lan>
In-Reply-To: <20251017044848.3269627-6-g.singh@nxp.com>
References: <20251017044256.3264737-1-g.singh@nxp.com>
 <20251017044848.3269627-1-g.singh@nxp.com>
 <20251017044848.3269627-6-g.singh@nxp.com>
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

On Fri, 17 Oct 2025 10:18:47 +0530
Gagandeep Singh <g.singh@nxp.com> wrote:

>  
> +	/* Disabling the default push mode for LS1043A */
> +	if (rte_dpaa_bus.svr_ver == SVR_LS1043A_FAMILY) {
> +		rte_dpaa_bus.max_push_rxq_num = 0;
> +		return 0;
> +	}
> +
> +	penv = getenv("DPAA_PUSH_QUEUES_NUMBER");
> +	if (penv)
> +		rte_dpaa_bus.max_push_rxq_num = atoi(penv);
> +	if (rte_dpaa_bus.max_push_rxq_num > DPAA_MAX_PUSH_MODE_QUEUE)
> +		rte_dpaa_bus.max_push_rxq_num = DPAA_MAX_PUSH_MODE_QUEUE;

Please don't use environment variables for configuration.
We have devargs for that.
