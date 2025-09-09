Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD998CAC583
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Sep 2025 16:17:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7A13240649;
	Tue,  9 Sep 2025 18:17:33 +0200 (CEST)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41]) by mails.dpdk.org (Postfix) with ESMTP id 48D8940281
 for <dev@dpdk.org>; Tue,  9 Sep 2025 18:17:32 +0200 (CEST)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-3dea538b826so4990068f8f.2
 for <dev@dpdk.org>; Tue, 09 Sep 2025 09:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1757434652;
 x=1758039452; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pC1rLhUqkQ8WYd1JJ8zuldIQ4OqE6neQrDusL+z/eII=;
 b=otY5SmfGG2Cl66MCNVMwMy5UCpovYK1P0aAmrDpf+V7HMqZNrHbwTeFEmQmuA/vp+s
 FFQEd/02+0J4EuBtTzZeH1vaVNY1LvLjidM00Rw8zDQizLkD/mtICG0VjYbkza6OatvW
 EMgLtYXIUPnfZFRP0C5U2nMEJ4BFWhMeDB9sv2w65j8yh6PV7IHzfROQ2Ap6XfRVhQWZ
 JWVtYqNI3fUzg5p1VS6YcLmhVXUF+ZJ5ZivwM8b8eQy60Tr7HNk+e22d4/ksODfbSWUc
 Ij1dvg6UdAeoiIYgcXEJMSyiz3UHnbAyc4RLRv8UjxHRgoNIQz/8UIdjA8gVgsjFKosk
 rTtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757434652; x=1758039452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pC1rLhUqkQ8WYd1JJ8zuldIQ4OqE6neQrDusL+z/eII=;
 b=ZRvZthhXotZ9pIjlK7dJ68RVCX5TmlZpPCgvVQmjnsSLHMYTCSXvBykQRKasTYANbj
 BGwG6Lb5DRT2LmNE/xLcq8qnUAZTxxxXqiYVmDD69WykkIjJqAxRRr/4XZY2A2Pd+2MQ
 E8uVy6r01GqjQK2rgja2p7KjM4Kc7eyFPUsucQmP1rDnzy2Bn6eiBHMjRmEA8hgODpHh
 5wjDTLMpgFibexWFS0aHaWlzxGmhiyo5GAFYiatCH9cyF3AfHezZu8T8tP/wpYDm32rF
 KuXf4p6e+etzs4/P1NwCym83SU4nZFjQW0RKwWK1NOoWbG4DMx894kGWRm4p3iBXq1ja
 7Llw==
X-Gm-Message-State: AOJu0YwrdTyvwxK/HQ5oEN12E4OGhuH4Jfq6uiv3xUSAtHWYWx6p8Lkw
 iLLG56nOuLhoz5Xce/lYahZ+fpsIHAIkgtTlnM08XR2gVtQf315FgRhgtfkUput+Ogg=
X-Gm-Gg: ASbGncs1BrPRzNDnDUqVwlfvezJ1qWZmb146qJyUm+t8Dn4x0TEDMnwAMYjP/NqD4l4
 WnFeGy5eE4W0GGuM9qAmRxr67fott7Jopllm4fYu5lmb5voO673WGmyeeqds5o5Q1AdXWPDf6B6
 QpyEnLC0jD0oBK5U21IZ9OmIMbGCDfPkVtH1grvVrWybkQLVGrc98Bs+9uVGHMNBuoCFuwzZ4/m
 mO0EOnl0EfK62K7e3fI7yBbiaHF8JIqTK1QOx2rP7w2cfJhqPDoBkkkjxAo7TCktjBRu1xh+W3d
 waYS0Lin8Y5HkUnLqLWUg64I/VFxMRc4mRIot2+qzqyLRYFh4XfS35spIg6Sxt+5jsYaAfOTIQG
 rFZ7akm+MQW7R9U2m2iVgZR5OVUADajdpEQlq3f01F87kJTxsOM63Z0iBjPrGIM1zogUJ71Wf7o
 Y=
X-Google-Smtp-Source: AGHT+IEVAt6BDyvK7o7sZlfUpi2tk8e44aBbAZdAc8n0DKGnYXo4ftQF0BKi91Oz3JnRzbzepXjImQ==
X-Received: by 2002:a05:6000:2c05:b0:3de:293c:9377 with SMTP id
 ffacd0b85a97d-3e64ca76b1fmr10065563f8f.63.1757434651658; 
 Tue, 09 Sep 2025 09:17:31 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45dda4f2a0dsm191559295e9.2.2025.09.09.09.17.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Sep 2025 09:17:31 -0700 (PDT)
Date: Tue, 9 Sep 2025 09:17:24 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Thierry Herbelot <thierry.herbelot@6wind.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, Devendra Singh
 Rawat <dsinghrawat@marvell.com>, Alok Prasad <palok@marvell.com>, Jerin
 Jacob <jerinj@marvell.com>, Olivier Matz <olivier.matz@6wind.com>, Edwin
 Brossette <edwin.brossette@6wind.com>, stable@dpdk.org
Subject: Re: [V3] net/qede: reduce the optimization level for gcc > 11
Message-ID: <20250909091724.2ea0615e@hermes.local>
In-Reply-To: <20250909054023.3263401-1-thierry.herbelot@6wind.com>
References: <20250908070414.1297844-1-thierry.herbelot@6wind.com>
 <20250909054023.3263401-1-thierry.herbelot@6wind.com>
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

On Tue,  9 Sep 2025 07:40:23 +0200
Thierry Herbelot <thierry.herbelot@6wind.com> wrote:

> The qede PMD stopped working under Ubuntu-24.04 (using gcc-13) when
> compiled with -O3 (default level for all DPDK code). A bug is opened
> for this issue (see Link). The same issue is also seen with gcc-12
> and gcc-14. The issue is not seen with clang-20.
> 
> A first workaround is to just disable all optimizations (-O0), which
> restores packet Rx with Qlogic NICs. However, the performance impact
> is not acceptable (around 50% drop).
> 
> A better compromise is to use -O1 for the qede PMD:
> - there is some perf impact,
> - but the PMD is working as expected (packets are correctly received).
> 
> When compiling with both -O2 and -O3 and gcc > 11, there is no packet
> reception when using the qede PMD. The root cause could be missing
> 'volatile' keywords or missing memory barriers in the qede PMD code.
> 
> Link: https://bugs.dpdk.org/show_bug.cgi?id=1379
> Signed-off-by: Thierry Herbelot <thierry.herbelot@6wind.com>

Which rx_burst gets used on that hardware?

Is there any indication of errors (like rx_mbuf_alloc_failed) in the stats.

The driver does not appear to have any write barrier after updating the consumed packets.

Would this help?
diff --git a/drivers/net/qede/qede_rxtx.c b/drivers/net/qede/qede_rxtx.c
index 25e28fd9f6..1b5109d966 100644
--- a/drivers/net/qede/qede_rxtx.c
+++ b/drivers/net/qede/qede_rxtx.c
@@ -1295,6 +1295,8 @@ static inline void qede_rx_bd_ring_consume(struct qede_rx_queue *rxq)
 {
        ecore_chain_consume(&rxq->rx_bd_ring);
        rxq->sw_rx_cons++;
+
+       rte_wmb();
 }
 



