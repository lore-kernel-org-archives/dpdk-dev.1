Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80716CA1002
	for <dpdk-dev@archiver.kernel.org>; Sat,  6 Sep 2025 04:12:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC07D402AF;
	Sat,  6 Sep 2025 06:12:56 +0200 (CEST)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42]) by mails.dpdk.org (Postfix) with ESMTP id F094340156
 for <dev@dpdk.org>; Sat,  6 Sep 2025 06:12:55 +0200 (CEST)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-3da4c14a5f9so2416447f8f.0
 for <dev@dpdk.org>; Fri, 05 Sep 2025 21:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1757131975;
 x=1757736775; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ztbn7XHGFn7E6VyDRiCSuZ5iaMaXOoN2mZ30bACNMmE=;
 b=VGTzHyy+nhtOv/zUTicJkpHHUYdzRZJV0ZxNpAhaOilLrw8FX3uoT6Y/vpSI1zjzyd
 2MNEAIBbKg5kuzAs1OsidRZqFtu12XG2hm8JBnUxhjT112MXswvoWWMHcZPF2SCQiedY
 1UFS73hiFQow6uYIm62DNcJyXGDfH+0QcpQJuiLiUzP+M7EEeptP69fYhyxfDWLRxpQZ
 Zqp5fmci8VV+SUJM7n9jfDaSH4GqHPbHPwXTPPfZr9T0LmIXS8kO70X3fIDVt4IQs833
 0fOfv5K1v/iB6+yW6YCUGe9O5JAYVjPRYTnIMU14uoYT31W16LEUZMj7OVtTL0y+23Yn
 MRHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757131975; x=1757736775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ztbn7XHGFn7E6VyDRiCSuZ5iaMaXOoN2mZ30bACNMmE=;
 b=mnv2AoARTUzFLpl7w7UzV5+r45DrLRL3pxD2XBMFCdrfdp6OKoJ5UxbrtvdX8R6iqC
 X0csIln/w6qKHuDy4/fgcRZmptdmdFVzcBtQeGx0phVzIrZLFIlBGzbkXqLbptiDUkVv
 mw7BBTqt5EMdQLAYOe1SUS5Vzrk7qDOtF2e69IeVk7volXCmsknbZBnB5pHQ5zk+yig6
 N4coQMX8qjo5IkuNJ0uxcbZYs6s14k6fg8Tz8g2/OUWl1HsuSNnYK8+wgHao6h643Z8W
 t3upXU0e2QynylxVZiRlPogPMJ/M1A2lknIt3vUoTKH4S3UCeZ4xoxUvrqRfW2hp5cbu
 lcDQ==
X-Gm-Message-State: AOJu0YzofzkDYiRuS7WU5R3aUpjDXTR9GNxCVsOwyNNpg1ZP8q07/xDO
 HQKUGQiwa0rXi8zMq4EvEYi3RKL3IwVza7/s74k8IvtRHoBQphUL70jkC6i4gdpLGG9iqfeoUrh
 bG4ms
X-Gm-Gg: ASbGnctvZwdDY9jDEV99GEtfgD+D8fgNLCNDFShbIQdGx8sJ3m04Yux2/C8oTo+AYSK
 rJ8AWcDSslRGnuaaJAl200ubSTcn30yYEdxPAL9MVLl7yjvbgA/2QccPxekK+KE36A2KtTYjACg
 ZAymZWrM8/3FfAE3InGmvzSAYRtlsRQfiEi2LOSGdCf+hl6vdokinME3FsO+L7DXau06YtSkUHu
 m/tqGQEBO+axsieuAIWQY4Vkc6vz0RxZeabKp1Q97OvFGOmoFIp9mk6W3B5Bnwfav0cNo4dsxxt
 Imrg9y4auXtQvLFOtd/LxSAIVefjF1g0BuewebbiKvJsATmMhcujWuXqKyQDtHQKAjXbwkR3Kcd
 tNzBz/HzNOZs0Ns2trn5U4u0JCRCkoBBsS4W6/tyDI9DOi2lupqdl/87ankEG7MjL9H7xeg22zK
 b6WaZ/kS0w1g==
X-Google-Smtp-Source: AGHT+IFgRsXyKL75E+l/zvDXxWLE5gt3OaAHrzv/Spl6mpb2osB7QlrLZBrqobuLEzzmFtqVqADqLA==
X-Received: by 2002:a05:6000:2c0e:b0:3d7:df92:5e5a with SMTP id
 ffacd0b85a97d-3e6289f03b6mr542193f8f.12.1757131975595; 
 Fri, 05 Sep 2025 21:12:55 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3dc1cd4a7d2sm13734784f8f.33.2025.09.05.21.12.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Sep 2025 21:12:55 -0700 (PDT)
Date: Fri, 5 Sep 2025 21:12:50 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Feifei Wang <wff_light@vip.163.com>
Cc: dev@dpdk.org
Subject: Re: [V7 00/17] add-hinic3-PMD-driver
Message-ID: <20250905211250.4ffab14b@hermes.local>
In-Reply-To: <20250902040204.9572-1-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
 <20250902040204.9572-1-wff_light@vip.163.com>
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

On Tue,  2 Sep 2025 12:01:34 +0800
Feifei Wang <wff_light@vip.163.com> wrote:

> The hinic3 PMD (**librte_net_hinic3**) provides poll mode driver support
> for 25Gbps/100Gbps/200Gbps Huawei SPx series Network Adapters.
> 
> v7:
> -remove unused-functions


Your mailer glitched and sent it twice.
