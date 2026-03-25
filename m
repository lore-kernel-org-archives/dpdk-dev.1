Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 374BA109C058
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 18:42:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 81CFD41148;
	Wed, 25 Mar 2026 19:42:45 +0100 (CET)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172]) by mails.dpdk.org (Postfix) with ESMTP id 56C004114B
 for <dev@dpdk.org>; Wed, 25 Mar 2026 19:42:44 +0100 (CET)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-2c160cb021cso208517eec.1
 for <dev@dpdk.org>; Wed, 25 Mar 2026 11:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774464163;
 x=1775068963; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=guZ7TYFLh/ACrDF4OnVaQZgzT8HaM7z0DhFaUJgXRv8=;
 b=yqCECNI3O4upR8xj2LlZe8lHOfPJkhr6xahLb2a93VrXpugKt7GSO0t6kGxAxFdqHE
 5tmpOj2S77udB/3KrUHpcujxoFhQX7fUWa5F5IpoXiFR2Razd87NGTT718aBJImC+GPF
 KaxjrqDdRoLGfqduez0vfGamX2nxh0Dr4/6zraZVLPKyz1ARd3wJrIV0NyUOAApod4cD
 Zs5AxHRE1bZTgnaL3HJk7LA1kMJ4q5UdpcDKcG+KN8yP1z0Pcdrazh3uPj7aE1ecF0G1
 YTEVUHyaIJmTr+Y0CvRmojfCKcRrkfmYilm5ERsM3w5TeLjom/pmi4dKewEc1GPII49R
 uEHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774464163; x=1775068963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=guZ7TYFLh/ACrDF4OnVaQZgzT8HaM7z0DhFaUJgXRv8=;
 b=RdB06PBAEl9hfhpIlEU1OqxqbK8AAVG+cxIVrh2Xco0ZVH4p7MDRIpoC6VUEQnBrzB
 o0EuXWV+DZkqoFnaeJrGHFWST/xyJXiq56DnRWfRQT4yK0G2j4lmMSIu7S+WpR4xJUpY
 TCOTE8h6trmbibVi01/kq7MRxWtmFJ74FiXXZE0ydM1wa36m6A/fhAcxXC961MNPRL87
 Mn5dWQLu0JxHgi3ewA4lFGzQPZv5KOKe5gDpZieM3yXIhmNHJ+oCUpbHZySGaLE2hzo4
 mdkXYmd972jVsEdeFP71ODJwheo3C9ldRwveDsHSEb4kT9Gb3Nc+z3JP1PKKgaNTE31C
 6lPQ==
X-Gm-Message-State: AOJu0Ywr/Hsnwf7LutVx/gvK1o6X4/RjO8wGDlvfETKxH4cwxOsnkDEI
 3HOkpaf3wlBcW172xqQJnwPsbRcY5iCrlz8DLJ1hU9tVwVa0z8y8ETKnLgyq69mcauqnI+weiLQ
 dp6as
X-Gm-Gg: ATEYQzzYV2nOEtx7JsdbB8ci/0jGTmHo/savEfh8tiVspxs0qil4aCkg6BE//8XhObo
 a7nPSIe8NkLnek3VWMyy5uR+VMo9C//0K0gYws0a9bLsRkU70+hsiBW7lycgqkUClz4s6xuIjDv
 lLAgaXhbUuddtSL8gWm9DNr1ko+XS7JmX7d1HGCMHaBk45P6HNbsbyVp7bdA0ajW5Fm9icMQJgV
 aUaC2grWQBIhAawVxR2WDS6Em9dmU93GBoMKaRjtPFkATmnR1kmtmbcish8iqFjKH/HORMGZhsV
 vWjAd5GRPBPim/D/SDcLfstzYy7JycESqChO5xMFporUKRZricaT3OfiZIystCrkIwJi4sDKkRl
 8J5GLbeMKloS7RVLBAh2d5A3FlX9ZH3mL7qZj8hIOAZnxur69awdtxNQEJxRsa2JfAGOzuTcD31
 ZIFP3/kpLuTP6/yeOb7uhK2oF8buwHYtipO2I=
X-Received: by 2002:a05:7301:d8a:b0:2c0:ae1b:4573 with SMTP id
 5a478bee46e88-2c15d32bc87mr2368221eec.7.1774464163138; 
 Wed, 25 Mar 2026 11:42:43 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c16ec257b4sm386958eec.6.2026.03.25.11.42.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 11:42:42 -0700 (PDT)
Date: Wed, 25 Mar 2026 10:31:56 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
Cc: <dev@dpdk.org>, <xavier.guillaume@ovhcloud.com>, <robin.l.lin@ericsson.com>
Subject: Re: [PATCH v6] net/af_packet: add Rx scatter for jumbo frames
Message-ID: <20260325103156.1742d922@phoenix.local>
In-Reply-To: <20260324162952.2827453-1-sriram.yagnaraman@ericsson.com>
References: <20260318094726.1284454-1-sriram.yagnaraman@ericsson.com>
 <20260324162952.2827453-1-sriram.yagnaraman@ericsson.com>
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

On Tue, 24 Mar 2026 17:29:52 +0100
Sriram Yagnaraman <sriram.yagnaraman@ericsson.com> wrote:

> +/*
> + * Copy packet data into chained mbufs when it exceeds single mbuf tailroom.
> + * Returns 0 on success, -1 on mbuf allocation failure.
> + */
> +static int
> +eth_af_packet_rx_scatter(struct rte_mempool *mb_pool, struct rte_mbuf *mbuf,
> +		const uint8_t *data, uint32_t data_len)
> +{
> +	uint16_t len = rte_pktmbuf_tailroom(mbuf);
> +	struct rte_mbuf *m = mbuf;
> +
> +	memcpy(rte_pktmbuf_mtod(mbuf, void *), data, len);
> +	rte_pktmbuf_data_len(mbuf) = len;

Very minor personal preference here. I prefer avoiding using
rte_pktmbuf_data_len() and rte_pktmbuf_pkt_len() since they are
really macros and the use of data_len and pkt_len directly is clearer
in code that is manipulating other mbuf fields.

Applied to next-net
