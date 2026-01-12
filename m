Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8AA0D25030
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Jan 2026 01:15:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 95E4940693;
	Mon, 12 Jan 2026 02:15:05 +0100 (CET)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50]) by mails.dpdk.org (Postfix) with ESMTP id 742944067E
 for <dev@dpdk.org>; Mon, 12 Jan 2026 02:15:04 +0100 (CET)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-47bdbc90dcaso41480855e9.1
 for <dev@dpdk.org>; Sun, 11 Jan 2026 17:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768180504;
 x=1768785304; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0WS1/g8ADeP+1EFi394eOxEIa5LQfrh6ifXXACYGbao=;
 b=JPfNMSufmcB3X8PXR669kTjLCkyuVNwaWOfgV91TrXqb9wMBPXQ1h9zyPGpaHeKWI7
 sv2QcgwDgMvw/qKoS52Y/SNyYDt78xxBsBxgZ2sLzmQd7Tj5I5eNQ0WBfEutN4wK7ieY
 oPqrS77t4Ry6cBj06TzqVULWiug+QxvYGG65R8boYBn6jdCJhVlEf3Sh+45n+D+boq0X
 6PvmdTvD1d1zPrWQp1LwarA5fvT/u0x8a/fe5k4VtpoyUJRBaX8wopFt1mvprxcp5OvC
 kxjVE9tddUVeMAS1e4f3NjZXHpnZgdNdREbTX5VxJOhQ1dcUZTHkHppugoOARhFlDOjJ
 zokQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768180504; x=1768785304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0WS1/g8ADeP+1EFi394eOxEIa5LQfrh6ifXXACYGbao=;
 b=MW/BWMuNg/IKrSntKsPFKIcSPZzyLve1zJTSNh21Aq50HyNy4+85Xr2K10D7gQKE6c
 SHzJ9EVAc9HfHPyeJ3lBA4Y3knocozGLzdtfiWYEl4tN6x/OlmE+EyQc5IxvzLWIQwpc
 AxC2zbRNYZS6S15VRklwu5jp6ImXiSUCrx/Z9GKU849PH4h4Pn+q3irU1nJWFMKUGT+n
 imtgzRVklOa5BihXNEoJUkqmIXBe8/+mlRR7ZF/IJbxEwt0IQ2X45AUqFwL/ncwX7rtj
 x1oW5QUEXiIYcKcT94Lg5CEDTLlaGTSuBF6zyNP4uJcDJId++D2AXkBXlgfUz5uJ2QyK
 7p+w==
X-Gm-Message-State: AOJu0YyjoWqeM4w/cYTrZQzI2Ch4FmklptY5x5NzreLu1M+j0ZxbKvmW
 q0chZ0xekBTtkSvRS/zniwdA0ahRPdbcDgpY7qH2zXS4WcoV7+tpxQGNo2wCNuoZLnVX3NqlsxD
 omTGv
X-Gm-Gg: AY/fxX6PaazhLMNijn79CNOTgXmW1ElIHYliISskC1kaa/aFBj+S1Yr7ZNT6A5gWG+H
 wuQA2ddVqjzfzbtoIsOa6YRiwKzF5k9Igqgwr1r0oEimLOWbfkUH7zLAgoDZLC8ri+E59BnSaFv
 uCdhyA+OX89KnrobHL4jsZMXa2WqNwCITJfcAiHBXcWAREuFSDVKRuVypASV5fK6H4PpQE3EiQ7
 h5EUaOsj9/ALhfC/q6o3PXg37RJKrrjooax1COyMR3OGXXsCTCNpgBR0I4dXzgyqr6vVMsJQQFf
 Ke7jMI5+cqWIviAHO/Ac5o6/olJdgDD3syRGu5eGh1FOWU185heWhH13y/7daC5WbNM9SEKvB2L
 YY6adxkwuhCbbEg6hPH8CaKWcy9Bs2Atv2cr4/clDFuhSVkTtFA6eprJbksylVHtkGowaa+qwtG
 uHcWynEnzVFFDA27htvhlKpiXXFR+FARagJ6/7FFAD2bFIl4scxyZB
X-Google-Smtp-Source: AGHT+IFbYxUTqQx+VTuLTdDZV8GqepmhNJexpIor0MTS30NNf7t8BMRYKPtwzMZgnM/apSuye8pMEQ==
X-Received: by 2002:a05:600c:c091:b0:47a:935f:618e with SMTP id
 5b1f17b1804b1-47d88aff9e4mr126925665e9.15.1768180504081; 
 Sun, 11 Jan 2026 17:15:04 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f65d9f0sm338085875e9.12.2026.01.11.17.15.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jan 2026 17:15:03 -0800 (PST)
Date: Sun, 11 Jan 2026 17:14:59 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: "John W. Linville" <linville@tuxdriver.com>
Subject: Re: [PATCH 2/2] net/af_packet: remove unused attribute
Message-ID: <20260111171459.3dfeb3eb@phoenix.local>
In-Reply-To: <20260101181345.201601-2-stephen@networkplumber.org>
References: <20260101181345.201601-1-stephen@networkplumber.org>
 <20260101181345.201601-2-stephen@networkplumber.org>
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

On Thu,  1 Jan 2026 10:13:44 -0800
Stephen Hemminger <stephen@networkplumber.org> wrote:

> The device configure callback does use the device argument.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

Queued to next-net
