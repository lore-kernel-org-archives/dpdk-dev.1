Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC56FDEE46
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Apr 2026 18:57:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 988E040272;
	Thu, 23 Apr 2026 20:57:34 +0200 (CEST)
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by mails.dpdk.org (Postfix) with ESMTP id E151840270
 for <dev@dpdk.org>; Thu, 23 Apr 2026 20:57:32 +0200 (CEST)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-12c565476d7so1360775c88.1
 for <dev@dpdk.org>; Thu, 23 Apr 2026 11:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776970652;
 x=1777575452; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FZuKFwsLmlJWgNagBAjq9W8EVxkGjH1RtO23SopbtoI=;
 b=BeQkkQR0Yh+50ElMFJdL6cnZAuoZ4T652uwib94Lw967LtwIDkdaaUEIYUUgCKjDZn
 fU/MevDTMUMYIeIiRM+Uc0IGLep/CRCHFU30smbj021/8zn6CLkl1qT/z9CHO8hmjT9H
 8yu5s+AM5ShYFyA8Qb3oNnFE0Qx4kUsH7zCAX+MG+NKZYyt9X98sJyMBuHjsE8WbbLH2
 IzEw1NQSfGYA3SqXJMn3llrtQ94Q7LSPO/+b0kzxM0lD9XcLYrmAG7ubSGviGpm2Vw1A
 rmqpz3yCfRvl6z7jdNxUISs8nw/KIzNB9TTkspAuqNLLkfT+CGH5D89RpgPkd7C81BJT
 STXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776970652; x=1777575452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FZuKFwsLmlJWgNagBAjq9W8EVxkGjH1RtO23SopbtoI=;
 b=EchqUKW9NbU/bqiaT2plHT/0OyeaYCQnEqIqHvCWO5iHm06q1SoEYtZFNTNzhUDwrk
 EVjO3jYdMHHVIA2y2FyyXaux4lpVAPU8TWlEzH+QWqJyBs5WZSOuMsPbStqu02orbbAH
 7M5TXrVTnj1gUAqRZoqoGE8QQp8Vqe9CUczN/b0SMqKvraNyNBW1sK+Yw+PVgJVSGuIl
 4x3fQy6kmmFqkoNwB+EgAd6mnj9hwD9tKYUVNu9oPbekOaog8uLuKMIl28jtz2RkfhwS
 GXk9e1iOuQDDpBmB8dkfDxDWl80qaIPwZqS2aa9dI3WQ+4kz5AlPprVhCVk2BIk7QyEt
 opkA==
X-Gm-Message-State: AOJu0YyvMe0wgUzCMIETVU5aCmcH9yGafjr+q2Sr+PEz/H+kTHJ0gwiN
 8kJ5ZFzOWddxKBVJErg2oFjqwLZiTrHCrEtp7x89m+LQa9rhkySE2DAY39qmhGu5k2pYZzuhsrf
 2UN70
X-Gm-Gg: AeBDieso97dWyj2AocOsNUI1n7wzwKA8PFGe71ITs+qOgvq1y5CBeYICSZ3eM5paskt
 fSVfdvnvorR/9kxq34SYHz4lfGIpE1wjePJJdRfiFzF2Bv6WGIeQfDXkOXMXHglFY40mcVgnx7h
 uTexFACOzDufxK9TshqPpri4bMA6SdMSyzXzfbzTnyWa5JpQhP2+VP9ru62CFzBzygWiAycjzrb
 5yR/xCHIH4YcVjWXXZ+ENheqOxhw5wi2GrBk+PSoBQ+gRh3hd7Va+xlkYty8t8c3C0V78dOLKc2
 FaR0qJWbP7uvzs74N561wFovxg9Mx3ngDhberZcRYIPtrAdhFKwj2RlAp4HEicC0VooiGjh/XgG
 8v3sgkPbQa2CM7mbiHCsQeBkCbzTbg4oecR7KMiRQ3ujNb+S51U+3CBhwl6GDrA5OSNZKQs9YvK
 Q9QY4qZkQLKB+pD44D3fqQ2XmS9xtouGl/Cy+sPXp5rsvu6A==
X-Received: by 2002:a05:7022:eac8:b0:123:2c98:f6af with SMTP id
 a92af1059eb24-12c73f75a96mr16338527c88.14.1776970651521; 
 Thu, 23 Apr 2026 11:57:31 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c837f7feasm31210618c88.0.2026.04.23.11.57.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 11:57:31 -0700 (PDT)
Date: Thu, 23 Apr 2026 11:57:27 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Junlong Wang <wang.junlong1@zte.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2 1/3] net/zxdh: optimize queue structure to improve
 performance
Message-ID: <20260423115727.62d3470e@phoenix.local>
In-Reply-To: <20260423011820.2426203-2-wang.junlong1@zte.com.cn>
References: <20260326022828.998541-1-wang.junlong1@zte.com.cn>
 <20260423011820.2426203-1-wang.junlong1@zte.com.cn>
 <20260423011820.2426203-2-wang.junlong1@zte.com.cn>
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

On Thu, 23 Apr 2026 09:18:16 +0800
Junlong Wang <wang.junlong1@zte.com.cn> wrote:

> @@ -1537,8 +1516,6 @@ static const struct eth_dev_ops zxdh_eth_dev_ops = {
>  	.dev_infos_get			 = zxdh_dev_infos_get,
>  	.rx_queue_setup			 = zxdh_dev_rx_queue_setup,
>  	.tx_queue_setup			 = zxdh_dev_tx_queue_setup,
> -	.rx_queue_intr_enable	 = zxdh_dev_rx_queue_intr_enable,
> -	.rx_queue_intr_disable	 = zxdh_dev_rx_queue_intr_disable,
>  	.rxq_info_get			 = zxdh_rxq_info_get,
>  	.txq_info_get			 = zxdh_txq_info_get,
>  	.link_update			 = zxdh_dev_link_update,

Dropping rx_queue interrupt support.
Not good, but if you are doing that need a release note and change to features matrix.

In zxdh_init_queue:
> +	if (hdr_mz)
> +		rte_memzone_free(hdr_mz);

Null check here is redundant since rte_memzone_free(NULL)
does the right thing if needed.
