Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A531606A31A
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 17:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=suVKJelG
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 44AF7402A3;
	Mon, 26 Oct 2026 18:02:25 +0100 (CET)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by mails.dpdk.org (Postfix) with ESMTPS id 6437040275
 for <dev@dpdk.org>; Mon, 26 Oct 2026 18:02:24 +0100 (CET)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-3ae25008e2aso513316a91.2
 for <dev@dpdk.org>; Mon, 26 Oct 2026 10:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1793034143;
 x=1793638943; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wSfqxfzD4yXBwVporK2iWpxw1v0smgdj4TJTLqLr94k=;
 b=suVKJelGZc4cY3Rwh7Z+9Zy+ov/tMIbij5adWHf3sCGCslmtp5xlL6KAKvMyBsXNxq
 5hzTIS7YsuxB6We/Q4unYyzqyb3djhLQPDD3v+AlvatprhTCF+k/EwSqSxQlIPZoEg9e
 +Ecek46gP62SLaEW8h8/foOU9ahzq2NV2vi7UnHtHmCXRbSOy3gi9dbD5PbfvbKkonta
 56jMmLetGUINXqeBJcx4M8JhfVaGuB0dG7+ipXh4I/fCUEEenE6tzORv7Tf7H1dSTjrU
 vAvcDNjWF7QIe0ie4SNB5sO38xm9ZC3dpWcVQaCkBBSZPsEi5+q+wdBer1h53+Sx+axW
 8Gxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793034143; x=1793638943;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wSfqxfzD4yXBwVporK2iWpxw1v0smgdj4TJTLqLr94k=;
 b=b7L1RipdK0WxaVnAnEGUAPEI+L9Q7QfF79JvmX/mq7STCWl7SqpvBixnS5k07CN/IA
 C4PFRncinJaUzaNU21Z0u1QDxyokJjy3E4PZurebKS+N15XQvTk5mgqw71+VQIadoKKF
 j48V90KbdQE0pcweroXbopCwLIT+CqmhV8xjLaCqtP3OMkneTz25nuLkuDLnOhH+GBzf
 WOuAroQOQTTxE5Yx9S3ssBN3So4KE/LtR1wtigMPLqylWbkfFZdXaK4EtE9pUwxmN6EF
 sQsG8bxaqYp7V4PCyyyfwBqnJ/59ebleK7gKCLfUVx9D2AsO6w2srzRPY9mLi4jT6cUS
 t8Pw==
X-Gm-Message-State: AFq9FYIEYhyQmtMzoPlRpshO/ZWujVEKN8Z4SvMCwRUUs0WOys2rqZPC
 fToZUrz0Gu5KNRb4uz9n4TNM7X/yl21qSouwcd16Pl0qOzcN6jGqTgbh1JrXUO4kzFxYkMFEP9W
 TCasD
X-Gm-Gg: AYBFou0x8F/z1tX6LeOXhqfs+j5hitOhxkrYvhzU1vbbKGbbEDLFaoP3ROFo3g7E0ya
 fTCsEfcHCuNn68zB+brUlrJa+xclYwrXCEzLXDjHEUCkIhOhgi9PIURskLX+UNFMNqOgJba9P4y
 w/G1S44HIA+ADVVaZoDWT7R64HLaNsjdphMNtHT6uFuXTknbpGWo+UuZdWMkp1W5asPiOO5NsnU
 qCwQmYj5lhlx/znch1pZIMCBjDsaM4jd9+8brJ/hlUXsamJitrI80F4SmAC1Zh8cipQDSW1wSGJ
 f5OlI05FArRelfkgPm8jDyunOytBH52X5DOSw+iuqV5E7DO7uKkDQupAFSAvajkp/Pl5e+2lNht
 zZKMOWjjJprri+ty5Op21yxNS4o3khtThpTagrRPfFCyDihKP2bWHtGRKFn4M1ftXsiHGaWC918
 y4GoxqcH07iylLiwzZ/TAv9jOjobESqVXbNTzjEooeRldGA9b2VT+eys5CK6PwjoNRdvD3OPUyd
 r9v0t/NwicJ2APtGm/LFohvrRDBmu+3e2s6EmINtDV6OPkUCNy6HG/4CmLJwuT6iBMe17tfMjW0
 xsxipHin83zzDsoUtAlFLA==
X-Received: by 2002:a17:90a:dc86:b0:3ae:2961:14d5 with SMTP id
 98e67ed59e1d1-3ae2961167dmr1442251a91.42.1793034142613; 
 Mon, 26 Oct 2026 10:02:22 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae4061578fsm198432a91.6.2026.10.26.10.02.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 10:02:21 -0700 (PDT)
Date: Mon, 26 Oct 2026 10:02:17 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ryan Wolfe <rnwolfe@google.com>
Cc: dev@dpdk.org, joshwash@google.com
Subject: Re: [PATCH v2] net/gve: enforce the Rx scatter offload in GQI
Message-ID: <20261026100217.2730cc07@phoenix.local>
In-Reply-To: <20261022212819.1750996-1-rnwolfe@google.com>
References: <20261022100049.7a318767@phoenix.local>
 <20261022212819.1750996-1-rnwolfe@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 22 Oct 2026 17:28:18 -0400
Ryan Wolfe <rnwolfe@google.com> wrote:

> rte_eth_dev_configure() sets the MTU from rxmode.mtu without calling
> mtu_set, and keeps Rx queues that are already set up. Stopping the port
> and reconfiguring it with a larger MTU, or without
> RTE_ETH_RX_OFFLOAD_SCATTER, therefore skipped both the MTU change check
> and the Rx queue setup check. gve also never gave the device that MTU.
> 
> Even with the MTU programmed, a GQI device does not limit what it
> receives to it: on a network with a larger MTU it still delivers
> bigger frames, chained over several Rx buffers. So the configuration
> checks alone cannot keep chained mbufs from an application that did
> not enable scatter.
> 
> Move the configuration check into gve_rx_check_scatter() and call it
> from gve_dev_start() as well as gve_dev_mtu_set(), program the
> configured MTU into the device at start, and have the GQI Rx path drop
> a frame that spans more than one buffer, counted in the Rx errors,
> when the port has not enabled scatter. A dropped descriptor's mbuf is
> now freed, since the refill replaces it.
> 
> Fixes: cffdca824388 ("net/gve: refuse an MTU that needs Rx scatter when it is off")
> 
> Reported-by: Stephen Hemminger <stephen@networkplumber.org>
> Signed-off-by: Ryan Wolfe <rnwolfe@google.com>
> ---

Looks good applied to next-net
