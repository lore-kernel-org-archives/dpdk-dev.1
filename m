Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EE3606A324
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 17:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=vOCWRJcs
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7E46840658;
	Thu, 22 Oct 2026 19:00:55 +0200 (CEST)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48]) by mails.dpdk.org (Postfix) with ESMTP id ADDC54027D
 for <dev@dpdk.org>; Thu, 22 Oct 2026 19:00:53 +0200 (CEST)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-3ab98332238so26377a91.3
 for <dev@dpdk.org>; Thu, 22 Oct 2026 10:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792688452;
 x=1793293252; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9rihdKtGOBJBdVy6WEG27dO+DxE2sWDJ7GRy3EzYycc=;
 b=vOCWRJcs1pd5LOOVR9c1LuCXr5MG1EsPukZ8fggxGnVI8RDWcqfMME+BcqIkLEmLAc
 vtBN1tY0Q+SprcYx9OJo53yixbtuOgqMh7M/HRBmAE6j9rHhsOI9oAu+jrFiamLyqqFw
 YdBMlL5Nuq5QM6VbJ2aEVmUK569YTBRicB7DFEcLnudy3uXJiNhBEqjZs+tUyK4/DWTC
 dZ9oCyy1SIjT7n9S79TNRgkpcsiGS0hUX6uWPPaiJsDj7Cc1zAavm4mVCmuYHp+Zz6ow
 4AXu//AJqBZwSu8V1DAHwXgV5vzUXVPQp6Voi5wfxcOu7nuxLOchu6Eq3pC0MAGdPZFK
 0toA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792688452; x=1793293252;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9rihdKtGOBJBdVy6WEG27dO+DxE2sWDJ7GRy3EzYycc=;
 b=Dld9JlGeEhQDM00NhniTk0w4DtvVcLS++TO9WlkYWRDXjOR7POIuu9mD9Sd8XiJuYB
 RbOn0TW7gw8Hq3hgiP73I3vkmkst5h99JjZQobg0JO0SKLkUSIFMoRBrYhL9PVdtxi1P
 yWvSFgMLlIGi59SN/kiBZdm0bW6+q7L+HaX264JgEb4AdBlzMS/FxYJtAGNzBXhnAfBI
 M/F5FVzhvtSwsFEQpunhF4x+BkTH6clEHxfqruEqJnwUfOacJqL52ZRObgudwWAgvzJP
 FALHBo2QZG7rjWpAJ3nK3hn8JcERamD12Wv+nyKXvFnxtIhxGj43dJ8O9mokYGe77DTz
 00Ww==
X-Gm-Message-State: AFq9FYIYIV7k2qDmHgGFq2XWbEpJAnMOJjIaDkQHb9SiXg+QeGzpwQAo
 bLzoRs3O46iYkQSjIPYn4eNxMUXxNc328qzouUC7/Xp4Dz64sgo5cytPQ2loAQbEnz4=
X-Gm-Gg: AYBFou3LIKak5CU2Qjwcy1M9P1QzCWq2OPYYOp/A++0jFaJFt0HJLVv3EXsI3gepeXq
 W/76zg/YIhUHTr1h/pZGR6oHhr3Dpu7sK5AQpVVynb5xvfxwPMa3Ul7ZfSezt19uC2b9WBHU+mz
 wdAYYVeZBT2Ds+EjXxndWedVgN/hqNmhIVGPzkdCjjCwypHPKV2JEVj81f9L5zY6DCeZvDu5t1J
 cjTcGGz4YA8zO3e6uHSRt7RwP/cKagCalO+fhYN1LTrPwVwvfn9MBYIYWC4DUR/5IVHZbgQ2XYr
 aZ2Wt3fYiILvwBTLiqc8Z62eRN4kB3VnREDQMOKlJ3t+4n1Jx7Jk9nsMuoDprod3V7VG4r067u9
 stbAuIS0IFv8O3hCKZ6FKmdg9zk1uZtYMA/D6J1gLmMgNFsvVsfCfNS5ZEqs3i6GJiPp+d3NZDg
 RLG+kdW4Fy5kcWp3Ps+pHDZqhfrF8lzjEvf5obf/JV+tBmHH639xiRPZ3XxgnjO1KXwwTP3Ovmn
 iWUQ5H2WA3W62DjECS0acj3dAmCQne04yDWsBmtN5/T7u6hE3BVoEmdR48JLxFIpLwNY+jyTl0G
 aS4EH7o+w6I0A4vwWj3SrAudwfm8Cn9kEKNO5qpdyVM=
X-Received: by 2002:a17:90b:3b44:b0:3ac:9ed8:f30d with SMTP id
 98e67ed59e1d1-3ad86d09d09mr4915364a91.39.1792688452427; 
 Thu, 22 Oct 2026 10:00:52 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ada48a573fsm5214493a91.10.2026.10.22.10.00.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 10:00:51 -0700 (PDT)
Date: Thu, 22 Oct 2026 10:00:49 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ryan Wolfe <rnwolfe@google.com>
Cc: dev@dpdk.org, joshwash@google.com, stable@dpdk.org
Subject: Re: [PATCH] net/gve: check the Rx scatter MTU at device start
Message-ID: <20261022100049.7a318767@phoenix.local>
In-Reply-To: <151e7d5905b8c695d77b4ca03834c22b1caf61a8.1792607101.git.rnwolfe@google.com>
References: <cover.1792439728.git.rnwolfe@google.com>
 <151e7d5905b8c695d77b4ca03834c22b1caf61a8.1792607101.git.rnwolfe@google.com>
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

On Wed, 21 Oct 2026 14:25:22 -0400
Ryan Wolfe <rnwolfe@google.com> wrote:

> rte_eth_dev_configure() sets the MTU from rxmode.mtu without calling
> mtu_set, and keeps Rx queues that are already set up when the queue
> count doesn't change. Stopping the port and reconfiguring it with a
> larger MTU, or without RTE_ETH_RX_OFFLOAD_SCATTER, therefore skipped
> both the MTU change check and the Rx queue setup check, and GQI went
> on to chain large frames for an application that hadn't enabled
> scatter.
> 
> Move the check into gve_rx_check_scatter() and call it from
> gve_dev_start() as well as gve_dev_mtu_set(), so starting such a
> configuration fails with an error log instead.
> 
> Fixes: cffdca824388 ("net/gve: refuse an MTU that needs Rx scatter when it is off")
> Cc: stable@dpdk.org
> 
> Reported-by: Stephen Hemminger <stephen@networkplumber.org>
> Signed-off-by: Ryan Wolfe <rnwolfe@google.com>
> ---

AI found a flaw in this logic

Review: [PATCH] net/gve: check the Rx scatter MTU at device start
Patchwork: 171827

Applied on top of cffdca824388 (next-net-for-main); builds clean with
-Dwerror=true for net/gve.

Warning

gve_dev_start() checks dev->data->mtu, but gve never gives that MTU to
the device. The only caller of ctrl_ops->set_mtu() is gve_dev_mtu_set(),
and rte_eth_dev_configure() just assigns dev->data->mtu from
rxmode.mtu. After configure the gVNIC keeps whatever MTU it had (its
default, or the last mtu_set), so the start check validates a number
the hardware is not using. With rxmode.mtu left at 0 (1500) on a
device running a larger MTU, the check passes and GQI still chains
frames up to the device MTU without scatter.

Program the MTU at start, after the check, so the two agree:

	ret = gve_rx_check_scatter(dev, dev->data->mtu);
	if (ret != 0)
		return ret;

	ret = process_priv->ctrl_ops->set_mtu(priv, dev->data->mtu);
	if (ret != 0) {
		PMD_DRV_LOG(ERR, "Failed to set MTU %u: %d",
			    dev->data->mtu, ret);
		return ret;
	}

(move "priv = dev->data->dev_private;" to the top of the function.)
This also fixes rxmode.mtu being ignored by gve, which is the larger
bug here.

"Not yet run on gVNIC". Please test on GQI before v2: testpmd, port
stop, port config mtu / reconfigure without scatter, port start must
fail; and with the set_mtu change, confirm a 1500 MTU config drops
jumbo frames.

Info

Commit message: ethdev keeps already set up Rx queues below the new
count whether or not the count changes (eth_dev_rx_queue_config only
releases queues >= nb_queues). Drop "when the queue count doesn't
change".

cffdca824388 is only in next-net-for-main, not in any release. This
can be squashed into it when merging; if kept separate, Cc: stable is
not needed since the Fixes target already carries it.
