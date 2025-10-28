Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B62CCF9E0
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Oct 2025 13:40:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 96E4E4028D;
	Tue, 28 Oct 2025 14:40:35 +0100 (CET)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47]) by mails.dpdk.org (Postfix) with ESMTP id 2CDAC4021E
 for <dev@dpdk.org>; Tue, 28 Oct 2025 14:40:34 +0100 (CET)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-33d463e79ddso7467921a91.0
 for <dev@dpdk.org>; Tue, 28 Oct 2025 06:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761658833;
 x=1762263633; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vx1x4QsjlP2N5UfkVAHNhtTlL8DSe9FLES9dXmO1ZEE=;
 b=F+O4G2eu7oVDPQOZ5PrYQ6XPpiLztmBpLuPgUFX/qRii6/NKy9xjgFO1syhLEn/veM
 0wz3tZ/hM0+4G0or20gHsodbzM/wwLO+a2S8T7ak0TsR3+1v7jTl//10vDPL2/0t0ncy
 RDdwccL36dI0v4JPZXat1YZ+HTIx+wQzo8R7zgjOoTqkcjmmwU+Izk3BatXDmUp4lFXX
 cZ4jQsTkLgPjWNA1U+7/H1axjM8LDYWV5eFpl/27Et9qXxmmDjb9Ec+wgTvTxP3VcmrX
 jDAEwynLtkj2OSpLE8MuQGTK8ZlLtPvBzNA7tlYD99Qmg5XrMjZtx5FL3Ft7uDi2IYyk
 V68Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761658833; x=1762263633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vx1x4QsjlP2N5UfkVAHNhtTlL8DSe9FLES9dXmO1ZEE=;
 b=E9g53n8tj30Boj8WlNJybWKSyrNij4k/CdtlO/MDUxn+gJCQIjiwUFUbAjk9C0H9fl
 HM9lAYGS92e/KlglY0y0LMgPFQHQ0vODDKPAzUYl4E8ihCDulmPOIJ7ffEDZj3cd32+t
 WsBVgyB+RaEYB5M3w8Z5MsyzpX3ZF1AmEY/D9Pknhog3vAIB2cNiRmG3XqP0pSnjXwQe
 qAcpeKnzPegaDFXArT5wOtFH0l+4dmKGTGYFF5Pgevtey6H3rlFMHv6QULlqf0VqNr+8
 6yLimjVCw7wrMmWX0Mm4agBJnpjNMsTl5Bk9HxUfxZQmBSTHIZ4PlaOWMeUA+3YaI7GR
 bbEw==
X-Gm-Message-State: AOJu0YyRkRPAMLKfDiGK4rRGOnGbhoIyFyJ4/nlIgo1CJ19e4/pMQIQI
 1GAESB47TDOUDZbfyqWV8q3dWtA4AGwNhDtY4a7mAqVbQtmlZzrpmelMlzMtpc6fYNRp3jWfKg8
 qEl7bEBw=
X-Gm-Gg: ASbGncu4M3a6S9evIcVRklL1Ipt2Cwb2lbvcaUDae8N/Gtc1RNrsiaZQ7FbANwyyYJH
 NGl0PlrC7e+/3Gmiyc4iINpyYcVEbPMr9E+GErGl1RoFlUAdwRCUQwOo/1/2+c/0DNyW3HhdUnJ
 aR+7AAPF2PkGzT3Vnpj4A3KnVV6h20AxXT74AK4JdArqVfzcTggNPanRnPQzsoVaFF3VL7YBJAh
 HTUj9ySurw4GqUjgWg4HIZi8QlpCqa4V2UuJHwL5Oiw4maUdtG5Fd0Dt4Hz4tUdfOWH3AdE7Sbq
 NmKWp3PbeawBe131rHUdogt8JRkO4KZ7oBG1yJ7hfmbEGLpnfpa5HMjPg0/4xX0RZf4ZpQgWrQm
 DGSidcCaymzFM/j7dtswIlQcNpce8+HbO012QaozCQlr/KpOv2oPvhB0f7HPp4L9zX3KIJ+M70M
 UCJaHspm90oBT8Z94AmNm0mZ9R0mzsEzKVug==
X-Google-Smtp-Source: AGHT+IFKx88kuiopsKb2MoyJDjTdAEKGEw0I7dOvZ8Ik/CXnjB+JQPFWLNZ317EgfG5m2nR8AvcxCw==
X-Received: by 2002:a17:90a:c2c8:b0:32e:7270:9499 with SMTP id
 98e67ed59e1d1-340276009famr4021338a91.0.1761658832885; 
 Tue, 28 Oct 2025 06:40:32 -0700 (PDT)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b7128884e0asm10689733a12.16.2025.10.28.06.40.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 06:40:32 -0700 (PDT)
Date: Tue, 28 Oct 2025 06:40:30 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Wencheng Li <liwencheng@phytium.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v11 2/3] net/macb: add NEON vectorized Rx/Tx
Message-ID: <20251028064030.6ffe334c@phoenix>
In-Reply-To: <1761640350-80578-1-git-send-email-liwencheng@phytium.com.cn>
References: <1755664435-9462-1-git-send-email-liwencheng@phytium.com.cn>
 <1761640350-80578-1-git-send-email-liwencheng@phytium.com.cn>
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

On Tue, 28 Oct 2025 08:32:30 +0000
Wencheng Li <liwencheng@phytium.com.cn> wrote:

> +static inline uint8x8_t macb_mbuf_initializer(struct macb_rx_queue *rxq)
> +{
> +	uint64x1_t mbuf_initializer;
> +	uint8x8_t rearm_data_vec;
> +	volatile struct rte_mbuf mbuf = {
> +		.buf_addr = 0,
> +		.data_off = RTE_PKTMBUF_HEADROOM + MACB_RX_DATA_OFFSET,
> +		.nb_segs  = 1,
> +		.port     = rxq->port_id,
> +	};
> +
> +	mbuf_initializer = vdup_n_u64(0);
> +	rte_atomic_store_explicit(&mbuf.refcnt, 1, rte_memory_order_relaxed);
> +
> +	/* prevent compiler reordering: rearm_data covers previous fields */
> +	rte_compiler_barrier();
> +	mbuf_initializer =
> +		vset_lane_u64(*(volatile uint64_t *)(&mbuf.rearm_data), mbuf_initializer, 0);

Why is a variable on stack marked volatile.
My understanding is that volatile is for cases where data is accessed
from two contexts (threads or signals). This is not the case for on-stack
variable.

The compiler barrier should be enough protection to prevent reordering.
And setting same variable twice seems wrong as well.
