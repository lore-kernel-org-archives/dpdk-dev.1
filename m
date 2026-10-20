Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B41606A31F
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 14:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=yEXj43UR
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4301A40283;
	Tue, 20 Oct 2026 16:46:01 +0200 (CEST)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mails.dpdk.org (Postfix) with ESMTP id 0B6B44025A
 for <dev@dpdk.org>; Tue, 20 Oct 2026 16:46:00 +0200 (CEST)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2ea138a3497so8436975ad.2
 for <dev@dpdk.org>; Tue, 20 Oct 2026 07:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792507559;
 x=1793112359; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xHViUaNJ7WS9Sbi5m4EKWURk+/wOqnD7BpnVl1TMqEg=;
 b=yEXj43UROrVps+qzzF/22SLC04s/PEn1txevDFgbu2kt6sNUw5H492/5d6ZcIkW8pk
 ODOttW0LhTlmpXneHMtWK+XrVEiP847gQO507fx56QzRx+8/dW5B7qTJ8u07yAmHF9r5
 MC0AM5x7DGgOB7SVE9uOcsOBvYVO8y3/7w6fLrkLuMSPDE5ngsiTFWs4Ta0VqIGXZhwF
 AEEJdA9NgLMfBDzP7ONdnbUAe8nmNNyuZs2HkOQfBkaMfbr2aiPYRdaj1pP2p3ALDa4Q
 cvCSIbr8lv+jNa4Ti68ozlocwFCozVJ685gVeqiFxNnbEbbjuo/EPvPz109GYLlyt9FZ
 qFSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792507559; x=1793112359;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xHViUaNJ7WS9Sbi5m4EKWURk+/wOqnD7BpnVl1TMqEg=;
 b=sNH/oWmv7vOjzJ9wApUhINbVMBPY72QpUkX2M7McRJwcUhOG0xXTLh8on2Vlyz7tGQ
 8n07wmztiFVtH10+P1dFEDF0GPZNbBCsp+nyfxSvMB1nae/yLNjtbDp1BKG7RDgRZ/KS
 OiTygRwUvrpJxis9Bkyq3R0MXXr4RrHd7n6q1x9xy1Vt3bFjYLEA7qIkgXfgA5m8j+3J
 cagP+bITRpuQ+sB3DmAwXAr2dtEPZCtR1JLxgoTWebjx8Lp7l4fdXp0bsiZYoWjUViOn
 Wd0BJ585idrB7U8CliFtyGF++aYC/cVpMMzPHituWoKbJEqKo65addix1FoZIQm/0heS
 hVmw==
X-Gm-Message-State: AFq9FYLorn5lmnBlQxXLWWfyd1wdRqj1ISCtWtiJu298T8QcNLNEMFIy
 YLxrRwcbT816rxRBoQ2g0eCLDvbXzbVkcQ+gi5V4G732MiHicDfS+jvVD04wL5pjs9cF7mqfFlA
 tQ4TmleE=
X-Gm-Gg: AYBFou1D3us54cMTcdUNQb68bbV7hCL5qlLMA02JznU8cupkJHH28zdidbR0CYk0EPe
 kdipssdFHzWKJCIB2BmvqeJvONtUn4hHs+fV+ikn566haPnfQEOTr3R1fdfHahv2ib5bZQKsVjK
 0mnBjVJ9TF1kaQUQW7w05VwKIXDQHd07xVQypX3s/iI1ajKbGDD4NT3FSdAoo9saYRkCdSUldLN
 EhFcsMo9H9YjEOnOYIq/7206NXQzJSEUCEVQu7Ml13yGsizH650LD91N7R8395ENaLX9ffvHsDM
 IxG8DDwqAixo7Sn6rEzCqLbKstj0K/aFhB/ZW1xVGHiFH8Xn5hgWtUOHs6Asy1+CVGUBzmm+tyJ
 ssoZfc01J+1RC48Gv7OQO65DyojD5+B+7lxPWdqNrVPjqnlJkpwyvXMzaWBpZ/03aUgcZPkQXef
 nNrcIwCogYIFhX3skwwuEg0YQOcWtXFwI9+gtemidoGFfXpyHLhaV92v/iKW+i1TEq5SV4/4hFI
 5FRVTBSKq/nUZF/KhNGsr/POHNGWuBCmV5pljiz
X-Received: by 2002:a17:903:2290:b0:2e9:3dd2:a904 with SMTP id
 d9443c01a7336-2e9a69f724emr87969355ad.16.1792507557313; 
 Tue, 20 Oct 2026 07:45:57 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ea3b41097dsm19005ad.18.2026.10.20.07.45.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 07:45:57 -0700 (PDT)
Date: Tue, 20 Oct 2026 07:45:55 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dimon Zhao <dimon.zhao@nebula-matrix.com>
Cc: dev@dpdk.org, Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen
 <sam.chen@nebula-matrix.com>
Subject: Re: [PATCH v1 1/1] net/nbl: allow MTU change when port is started
Message-ID: <20261020074555.166d6461@phoenix.local>
In-Reply-To: <20261020094227.166491-2-dimon.zhao@nebula-matrix.com>
References: <20261020094227.166491-1-dimon.zhao@nebula-matrix.com>
 <20261020094227.166491-2-dimon.zhao@nebula-matrix.com>
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

On Tue, 20 Oct 2026 02:42:27 -0700
Dimon Zhao <dimon.zhao@nebula-matrix.com> wrote:

> Remove the dev_started check in nbl_mtu_set() to allow MTU
> configuration while the port is started.
> 
> Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
> ---

I was suspicious of this since changing MTU often requires driver to
reset lots of receive state. And AI analysis confirmed it.

[PATCH v1 1/1] net/nbl: allow MTU change when port is started

Error

The check being removed is what kept the Rx path consistent. Rx
buffer layout and scattered_rx are decided once, at queue start, in
nbl_res_alloc_rx_bufs():

	u32 frame_size = rxq->eth_dev->data->mtu + NBL_ETH_OVERHEAD +
			 rxq->exthdr_len;
	...
	if (frame_size > rxq->buf_length)
		rxq->eth_dev->data->scattered_rx = 1;

With the check gone, an application running with 2K mbufs and
MTU 1500 can raise the MTU to 9000 on a started port. Nothing
re-evaluates scattered_rx, and the application never enabled
RTE_ETH_RX_OFFLOAD_SCATTER, but it will start receiving chained
mbufs. Other PMDs that allow runtime MTU change (ixgbe, ice) reject
the case where the new frame no longer fits a single Rx buffer and
scatter is not already active. Do the same here, e.g.:

	struct rte_eth_dev_data *dev_data = eth_dev->data;
	uint32_t frame_size = mtu + NBL_ETH_OVERHEAD;

	if (dev_data->dev_started && !dev_data->scattered_rx &&
	    frame_size > dev_data->min_rx_buf_size - RTE_PKTMBUF_HEADROOM) {
		NBL_LOG(ERR, "port %u must be stopped to set MTU %u",
			dev_data->port_id, mtu);
		return -EBUSY;
	}

The limit needs to account for the Rx extended header the same way
nbl_res_alloc_rx_bufs() does (rxq->exthdr_len), so expose that
value or a per-port max single-buffer frame size to the dev layer
rather than open-coding it.

Warning

Commit message says what the patch does, not why it is now safe.
The original comment said MTU setting is forbidden while started;
something must have changed for that to no longer hold. Say what:
does the PF/management side handling NBL_CHAN_MSG_MTU_SET now apply
the new MTU to a running VSI without a queue restart, on both PF
and VF? Which firmware/kernel driver version is required? State how
this was tested (e.g. testpmd "port config mtu" with traffic
running, both growing and shrinking the MTU).
