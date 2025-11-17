Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B771CEACEF
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Nov 2025 17:25:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3350C4026A;
	Mon, 17 Nov 2025 18:25:09 +0100 (CET)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by mails.dpdk.org (Postfix) with ESMTP id 78B8B40262
 for <dev@dpdk.org>; Mon, 17 Nov 2025 18:25:07 +0100 (CET)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-bc29d64b39dso2737119a12.3
 for <dev@dpdk.org>; Mon, 17 Nov 2025 09:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763400306;
 x=1764005106; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V3z27S2l56fYBnU+yxh3r4dnrtSrUh2MqVN8pngzn+M=;
 b=HeZ+HWV4QwYsREIvjCIeEfsNi9szGIHfZkkS4H81DvzCfO8lgZlMJw899Q216i4Q5U
 srPD1gri50xLxijlK1yoLGe1rl3v+p8SouGFOJGlE5pIm1l4sHhXyeULT1V40O1VwBrj
 9mlIKcANeEFdF01Vr1ieXsj1cOGcjiRa4+/2abF8T3///+Qagg+7gQ/kLeciYKrotZsa
 dzHiZbH3htPw0CF3op/gceqBZN0bpf2qLkN2cl93ed1eOSCp1NFisRtNb+kTdAp1UOja
 P0Fy2pXqBxnnXkrctXyKRXiE1/vY2yZpQKo5E3GzaS6Hp10tdMNoVlXenx35ynp6Xbtz
 VTLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763400306; x=1764005106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=V3z27S2l56fYBnU+yxh3r4dnrtSrUh2MqVN8pngzn+M=;
 b=GxzeMvpmO35eW9fGnklmX6bn7+iRC2oOygLDWQ6/+hHHkwLol1Le5do8qIlM2zKbbe
 Wg4rYosA+ORJfPsoAn08rEyTiNqtKVotWkA8vslIhPwJS/0GCBAXDAf0Nlntlii6ekYu
 oFWSwLmHvX8CN/jwLUQu3CKWVmjYyi8yu+YwvPzl7+7dDHEM3nJuXq0U1gZ12mlKVY4t
 /tuMvzr1ckowWUCuvfoCEif4gEUxCuUVBCtZwkWCExRX7S+ILf6nwqhQeCi2xetXdLOH
 9LT4zvuUSNAAf2qKobkitCOFfWenwvIjgE2+QsQMK8Bh+Sb7StxGNwYzFRYf9UIpt5eo
 4XjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVwCeWssFIiLtzyF64Pe6UrDfJOTSaRMTveUpHn9VrCNnXpdR/wqxiFHQ29pxABGmnDQI=@dpdk.org
X-Gm-Message-State: AOJu0YyJ9ZXlM90QlVcRkGX5OHEMHG1EugspHQVCXZRqf8wSabsnSKh4
 rriek/HY5uYIyxAAe4z+uV7naWPzXPSrhhvwFjC1mIp98fZWK68lbrea5MaN/1MOOpU=
X-Gm-Gg: ASbGncs3QbQH2SZMuC5iI2QaXodKNT/HCIkyb0rPEDLOZtnOuh392oEL2LnGFA3UiN8
 NanuLnDRZXUupnDoqe/scoIdCVG7zFvpyfMvCFeOcprlkvGk2mQm3fwZcq4kQBQedGH2bkKakVm
 /d2ZoFioEMNjZ2RbPVxqSiA5qvWS50E7YH1TobVtZfkTVN9J/RjMdNOHFD74Xlbz9yVe/hWfnXo
 Jsh5rKhO/V5GyjFOcFSnmeF+ZpcFN6iaacS6QAr277BXvQR/AMIBHyZEOISsVEm9ESaNB2LfdRL
 8eq8XU49tXkXlVpAg/Y4S9Wu3Ec+MHk9LU/LBaYZJ6Qv2z4SFevxXu8dW8IMkLqrh4UKqs6kP6w
 F4J3EVMy2FIyxp445skDj6Ar2anKthiRrPxvv4Ri2pdOq+C5XJrRwH6BGwtDN4CO5X1d7zRNaW2
 EgZ2VDilhCo/Bb0Yg70z4bSR6Oz4Jc5kPpimK1g2l4j1a5szkjT3/paBI=
X-Google-Smtp-Source: AGHT+IHIlaOfybJIuciVdRYNaSr0uRGPcXZeZru1dahzQYPHRbiOyK5tiQ227//Db5D8+VEohPuZDA==
X-Received: by 2002:a05:7022:4401:b0:119:e56b:91da with SMTP id
 a92af1059eb24-11b40f98d46mr7387119c88.11.1763400306249; 
 Mon, 17 Nov 2025 09:25:06 -0800 (PST)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2a49db7a753sm47841501eec.6.2025.11.17.09.25.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 09:25:06 -0800 (PST)
Date: Mon, 17 Nov 2025 09:25:03 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bing Zhao <bingz@nvidia.com>
Cc: <viacheslavo@nvidia.com>, <dev@dpdk.org>, <rasland@nvidia.com>,
 <orika@nvidia.com>, <dsosnowski@nvidia.com>, <suanmingm@nvidia.com>,
 <matan@nvidia.com>, <thomas@monjalon.net>
Subject: Re: [PATCH 1/2] lib/ethdev: support inline calculating masked item
 value
Message-ID: <20251117092503.59952ea6@phoenix>
In-Reply-To: <20251117075407.9632-1-bingz@nvidia.com>
References: <20251117075407.9632-1-bingz@nvidia.com>
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

On Mon, 17 Nov 2025 09:54:07 +0200
Bing Zhao <bingz@nvidia.com> wrote:

> diff --git a/lib/ethdev/rte_flow.c b/lib/ethdev/rte_flow.c
> index fe8f43caff..b94f0e304d 100644
> --- a/lib/ethdev/rte_flow.c
> +++ b/lib/ethdev/rte_flow.c
> @@ -831,6 +831,8 @@ rte_flow_conv_action_conf(void *buf, const size_t size,
>   *   RTE_FLOW_ITEM_TYPE_END is encountered.
>   * @param[out] error
>   *   Perform verbose error reporting if not NULL.
> + * @param[in] with_mask
> + *   If true, @p src mask will be applied to spec and last.
>   *
>   * @return
>   *   A positive value representing the number of bytes needed to store

Sorry, this patch is submitted too late to make it into 25.11 release.
Missing any release note.

This would be a good example of where to use API versioning in a later release.
