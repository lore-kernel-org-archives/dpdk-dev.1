Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8354C36002
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Apr 2025 03:56:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C6B340651;
	Wed,  9 Apr 2025 05:56:02 +0200 (CEST)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by mails.dpdk.org (Postfix) with ESMTP id 7802040612
 for <dev@dpdk.org>; Wed,  9 Apr 2025 05:56:00 +0200 (CEST)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-736b0c68092so5221726b3a.0
 for <dev@dpdk.org>; Tue, 08 Apr 2025 20:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1744170959;
 x=1744775759; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nH63GZB5VNBG3Z86LPdIZW5fwkqmgYRH14Sd7g04vkU=;
 b=i1co0llunN2b4iiBdF5VdpgWlNmbtc31CQVqd+AJNqhZp2Lk921+kXCuS1ZlvxQTGh
 TBSo7cyknMDPRh0ni9faCyH6oazcEON5SGJltrISFWTHUIq+xXyUn0ofhcIr5TS+L3BP
 KzOYi09y5IBM90uxrW7mXie7347Kg8gGr2cdrDHTaXyiYEQ6UQP8wnc6b3g9WLdYFIkS
 if8qzxoO71/VZSmPlc9yoRS/xu97l5ot4tTRCQGaO+DWhT0ijYDP1VMtjHN3Y6PlOMh6
 1iDIhVLlaAKAK+WZ0VTFzzttdJWxheia1rRu6rConfRDfKbnhvZDwNV+nPPay2y5cxUO
 09lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744170959; x=1744775759;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nH63GZB5VNBG3Z86LPdIZW5fwkqmgYRH14Sd7g04vkU=;
 b=cNm4UvSTr4/+wlDND4Q1PDrGQNcWi622uDwAZADgp7FJqxh7UN4xSEqig+v9mq/iYK
 Q+tIRtbsU0qkta6L5iMIAR0UWAaEJRJrbzlnko4dsNZ8QolfLzP7C4a7Of4IuKC1opvw
 nUTaOYLa4yumTCQoDea84Q4Q4d8BRrz/wI247wZK++PPjRXTHrQxh5qMia1WXDW8ftFB
 POiFNAOfAl1t/6bpCsDx4ZnIlUZeJMdrVUj+PwSlnuIUcYoGtlBP6axB3iawbgM9Ec/t
 jTicfu/x7tPJXPR3xQCJVIBDh1km35naEDLzG86uy29Gk1HJB1K1FdSG+X4NdulIA6Xw
 knmw==
X-Gm-Message-State: AOJu0YwpjLtVxr5onxusvSgt9cBOnXZNugv0h+ptvDhiTETj8NU6JEgj
 XNT7gmSrodYqyriGke2/OEgNE2sL8cZWAG46N0A1wAxfeCSkYuT2YFmahtlqV14=
X-Gm-Gg: ASbGncvlWYSi9NuUeTloZJ3kAMlT6mtcjyfYeRW28Z4sA7ppVmqD8sTNdWD8P/Vlu4j
 YgEH9hzqIj8Vla9P6krfzA7JA5i3TU2kHbURKIeJ40k3TyCupxzG2yewTRNxHEE4VXLc9FxilGh
 b+29UR3YDIaAVSb6F99xbJxLe4qDc/q1jAT37cOpeaDU/uP41Oi6Mq2EztJn9u8vc6nop9kWbyJ
 5+umwsaOVnNq0JdhSSrmSElQFDgHy89bcA55gJa+/iMUSXpGAi/2AfmBJ8vNYnh7geFISZwK2h3
 1sQXWsHpHOra9OhnuMNXlugXeAkYDSWzCyJUTOEjUNYEExmbJowC++EXblvd0YsHcXrqvEDzwpw
 pN+JNh8zemIqgA8c6ZnAp
X-Google-Smtp-Source: AGHT+IFWUyu7ejl6i0WkVVPnd/nMKNsJPvCP5bZXMKHoGqtW7OySTbHWlCqJsncSeMlePPFLb+TG6Q==
X-Received: by 2002:a05:6a00:22d1:b0:736:5504:e8b4 with SMTP id
 d2e1a72fcca58-73bae529febmr1784801b3a.19.1744170959510; 
 Tue, 08 Apr 2025 20:55:59 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bb1d2afa9sm212013b3a.22.2025.04.08.20.55.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Apr 2025 20:55:59 -0700 (PDT)
Date: Tue, 8 Apr 2025 20:55:57 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Kaiwen Deng <kaiwenx.deng@intel.com>
Cc: dev@dpdk.org, stable@dpdk.org, Ferruh Yigit <ferruh.yigit@intel.com>,
 Alvin Zhang <alvinx.zhang@intel.com>
Subject: Re: [PATCH] net/igc: fix xstats name
Message-ID: <20250408205557.6152d29b@hermes.local>
In-Reply-To: <20250409010711.761050-1-kaiwenx.deng@intel.com>
References: <20250409010711.761050-1-kaiwenx.deng@intel.com>
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

On Wed,  9 Apr 2025 09:07:11 +0800
Kaiwen Deng <kaiwenx.deng@intel.com> wrote:

> The xstats name needs to be changed correctly
> tx_size_1023_to_max_packets should be tx_size_1024_to_max_packets.
> 
> Fixes: e6defdfddc3b ("net/igc: enable statistics")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Kaiwen Deng <kaiwenx.deng@intel.com>
> ---
>  drivers/net/intel/e1000/igc_ethdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/intel/e1000/igc_ethdev.c b/drivers/net/intel/e1000/igc_ethdev.c
> index e712cfcf7c..68444e4fba 100644
> --- a/drivers/net/intel/e1000/igc_ethdev.c
> +++ b/drivers/net/intel/e1000/igc_ethdev.c
> @@ -181,7 +181,7 @@ static const struct rte_igc_xstats_name_off rte_igc_stats_strings[] = {
>  	{"tx_size_256_to_511_packets", offsetof(struct e1000_hw_stats, ptc511)},
>  	{"tx_size_512_to_1023_packets", offsetof(struct e1000_hw_stats,
>  		ptc1023)},
> -	{"tx_size_1023_to_max_packets", offsetof(struct e1000_hw_stats,
> +	{"tx_size_1024_to_max_packets", offsetof(struct e1000_hw_stats,
>  		ptc1522)},
>  	{"tx_multicast_packets", offsetof(struct e1000_hw_stats, mptc)},
>  	{"tx_broadcast_packets", offsetof(struct e1000_hw_stats, bptc)},


Please don't send same patch twice.
