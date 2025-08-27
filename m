Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F21D4CA0FED
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 Aug 2025 23:19:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 490D84029E;
	Thu, 28 Aug 2025 01:19:45 +0200 (CEST)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47]) by mails.dpdk.org (Postfix) with ESMTP id 7CE7240298
 for <dev@dpdk.org>; Thu, 28 Aug 2025 01:19:44 +0200 (CEST)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-45a1b05a59fso2474805e9.1
 for <dev@dpdk.org>; Wed, 27 Aug 2025 16:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756336784;
 x=1756941584; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=klYCu4af32A1kHUohkD5HECNl+MnzbIRkUTcbVFIH0s=;
 b=cAA3QwVbz1pHax5NsFm2w/hG4jjn9ZAf8OD8ASbDcxpN7jSuwiYpTne707KWKDKjEb
 9XqM4k3uXaheVrz2dwaK3Sh7I79mybiLgsgXGfRnvsvHR3MdEJVfJ/4efKIvuvzQyE3V
 Apq6/SjKHf08L+vFQ5lePGKN9REzv2UqK2WtNzME5Yh3xStXTIMkjoPJBJDAII6PKKkD
 T9s/7QDuIkTDMFx0d0YTx1WgMswrfn2ZJOu/LslytssvDSx46052l+5RMyo8KkldN+nT
 DB725A6LmHglxT4II7GwuEOzf9vWkE5JgBjHtt/91lPlcnd3pE4AoAXUerQGRiPeyhBB
 F6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756336784; x=1756941584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=klYCu4af32A1kHUohkD5HECNl+MnzbIRkUTcbVFIH0s=;
 b=QJPK4c57cs318ahIi4A5OdcL2/gjT/ai33sZGR7K5IqQIqxOrkfwZDMQlLrxyL1rjX
 wwnzVbasvqeDVXI4nWPKvMOR8AjWTA30xia89naTCmuUrbiSe1TriruQP3c+HBNWbL9j
 hFkRMAIOmFVz642aOy5rcYkMPXfA1jPiY7j7Qk+3UIZASlMnTngUWYBqlXD5S6Fssqcp
 s609pFnIEJtDKe4Zhe1WVIjpjvps/CUwSfy0DOo411NHUnVxovmVSoodgik9gQciNlQ4
 WJE9BB3ErlxCch+eY4yDq1CcyQvHvewVTikdrd/e8Gj8Atn0Ev1CvqbI5xgZjEHwZ4kU
 TDVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9xH3Kfk+yqWkSuAIzXqu84FQ3AZVm62T1RlOMLj6HA+WRl8BeODAZoWgVizZSoO6cJk8=@dpdk.org
X-Gm-Message-State: AOJu0Yyoe9lLR06L4CrfLvb1LUXLdz6f4461eiYGMHkHscQL6PNTygxb
 twepvQL0XJA6DUsKVl9lJuGgHS0FoPmYqPS9btWELkhjM+HyEW5DU/H7FO89nKCs27piL2yCw0L
 Biwgn
X-Gm-Gg: ASbGncs/ilwMOZCB1Ic81vHFdi43lJjkxaXKC4bsGbbExao+3xwkDxePOq7EDhkPlDV
 H4eKm1dagtxVXlgN5XpGsJjzLGFepDFNTki5kv/bVDwLB5gMsc1JE2IleCxJqC/l8qOu12iThQE
 Z0E+20KLul+Z4kXnYc7QjPd5qEmj+vHNSTgTZ7tXV3Jgxwodb3yW6V15l1GD2ivXYEfeIB1CQGH
 JbC6casYjt/XZb6dJXsSo2KpDOYccECSCqPYAWCDXOM7Y9s83hsmciOCkE4vLNE/VRjEDw7j6wP
 +tmCMS3qOq6f+7Y5Uoa5yrkQI6MfPtsrTrINmvjAA7nafK1/P7LdTS+LDspgk1D/AryvlvGcEI7
 /rzD6oFzHe8D0NZO+kk7eQpJP20IQoMvkkuWlBdsUdNdBRH1zaQ68B3K2p5Gwx3ktttbK6A03z6
 6rr8OCo/WC9Q==
X-Google-Smtp-Source: AGHT+IFMiz0vFxw1aZ46wL/3cx7ViZswhMmVxCuDiochRxOyEk0li+FxoNbUSIR+WGDHl/anfrSvbw==
X-Received: by 2002:a05:600c:4511:b0:456:1156:e5f5 with SMTP id
 5b1f17b1804b1-45b517d27f6mr215504105e9.31.1756336784123; 
 Wed, 27 Aug 2025 16:19:44 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b66b6985bsm47362455e9.2.2025.08.27.16.19.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 16:19:43 -0700 (PDT)
Date: Wed, 27 Aug 2025 16:19:39 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bingbin Chen <chen.bingbin@zte.com.cn>
Cc: ivan.malov@arknetworks.am, wang.junlong1@zte.com.cn,
 yang.yonggang@zte.com.cn, dev@dpdk.org
Subject: Re: [PATCH v7 2/2] net/zxdh: add support flow director ops
Message-ID: <20250827161939.1f20eb71@hermes.local>
In-Reply-To: <20250827083909.2849389-3-chen.bingbin@zte.com.cn>
References: <20250815074221.2254545-1-chen.bingbin@zte.com.cn>
 <20250827083909.2849389-1-chen.bingbin@zte.com.cn>
 <20250827083909.2849389-3-chen.bingbin@zte.com.cn>
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

On Wed, 27 Aug 2025 16:39:05 +0800
Bingbin Chen <chen.bingbin@zte.com.cn> wrote:

> Provide support for ETH, VLAN, IPv4/IPv6, TCP/UDP, VXLAN,
> and mask matching, supporting multiple actions
> include drop/count/mark/queue/rss,and vxlan decap/encap.
> 
> Signed-off-by: Bingbin Chen <chen.bingbin@zte.com.cn>

Both patches queued to next-net
