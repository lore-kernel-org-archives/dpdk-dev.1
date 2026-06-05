Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F11ECD6E7B
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Jun 2026 21:28:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 522F1402DD;
	Fri,  5 Jun 2026 23:28:21 +0200 (CEST)
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173]) by mails.dpdk.org (Postfix) with ESMTP id 7C20F402C4
 for <dev@dpdk.org>; Fri,  5 Jun 2026 23:28:19 +0200 (CEST)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-307631dbfedso5147992eec.0
 for <dev@dpdk.org>; Fri, 05 Jun 2026 14:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780694898;
 x=1781299698; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vPe0em4bYag+o7amsbpJhbJn++XrDPsOKcbfaqC068U=;
 b=b66urDDnUR73pHvrcFUASt0wLqzxFubtxbpLBAfg4Mg3G4KKjoVW4XmdJgnjmr8ATL
 hUKjl5MoqlOepP6GOqAGGCy2IVJKGXDV3HXQCOFL5bJntAP3jFNtnYnFh55RQF8KGi8S
 oBCZk1Uk8+Z1c/5UcayvvPNZ1EWiHof2fJWHVLCS5J2k7S5kcCVyCNs2bvwF6ymDACvj
 n9tYma48M9pO2mX57fZVLnYaFYGYS4Dh1Hltm44uk8sQ4bqVH1lviLPBZNrs0VeJ40pa
 O/owOFAIjQ8xVP2ig+gMjxbUbjYdUM62F+V2+t4HQ94islEsqvkmPOtgl/eX46gSf9d2
 oaIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780694898; x=1781299698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vPe0em4bYag+o7amsbpJhbJn++XrDPsOKcbfaqC068U=;
 b=TRHTjfP3/brsqCVGtbYMk7JcsVUqK9xSMHKiQaNQrch/CMF8z/3QMS5rPaOp7ifvHW
 eZCZMAnyCwBQ5SIgbC03v9/2JagrmoRfzPceofAFHLXfPvW4WoS1eGV7HCBdhoKRTR6Q
 yNKQgFbVMkns2OSBLSQXr5OQAjh3VRzZICTXH41mpDvK3WIrnQDrGN555TRpe4qc2UnE
 mNOCFRytBty+cLJ62ceaZm1PPwW3LxC2ECQuNHXz4DcVTWLW5lgV8G4S3yTGGkBpxxpG
 x8xMI35gSyi2r89FboK/tQI+cSI4/uf2hSssOKa2xi38eaqtt17k9LrOaqY07a05MVil
 jS5g==
X-Gm-Message-State: AOJu0YxYZhOAnkXAa+pQJqfTg86slVFkFnd9hnLLQgusuJwvaLdrEK5A
 9nwAOJ9KKLcc4m2zekurrjEyKAJCLaUfWDQ65WMRfxEBXbYA3yZZ4YJgKrO+jx6l4l8=
X-Gm-Gg: Acq92OG9feI5XYdE+56AmVZygMk3Ni55UEkDQ+ag6/KiQ+CX8teSq5RtTqPONd6uR5f
 GBvc9RqtkwH3TTEuGGz0d3n1aYeMZJzHtbF++xoatwzlcaDus9JXJbJEHugPgJVnw7OPpdx7KWr
 b90Scvnve5KetOayRF3LcII9XU0OovcFGzMjHmn3kMVI6aBrZd5N9jZhxAFAApBxyZuYFwRW9zm
 PG1A2PsIv81JRPk8fu3ArfDPQ8eBRgeSfpuJDXcmigNS6Y0hKPAqdayxpugNLTrztl11rVvFYCj
 ZPJ6kz7EENDmvIXNBPvnBq5h5MMLNwm11DbrQBB4zCzy85U8XsZykl90ouyKD5wXzg3pwWUpVU6
 fTmJyG9N3TisrF5orqwQu6y8X7VO9ShJSHVpVoMF4uzxjTyZTsAu1FWekMYJUit/eHfwOLaYB45
 LkWy3fIQmmCHKqoO7y0wfFtUpqC2t9t6FuOxGAMfZbeAj2Npi73J7cx1D+lgim7LlRI5PglKRze
 lg=
X-Received: by 2002:a05:7300:7250:b0:2ca:8099:ffc0 with SMTP id
 5a478bee46e88-3077b2701b5mr2960579eec.7.1780694898297; 
 Fri, 05 Jun 2026 14:28:18 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074db560d7sm12044782eec.5.2026.06.05.14.28.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 14:28:18 -0700 (PDT)
Date: Fri, 5 Jun 2026 14:28:15 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, Luca Vizzarro <luca.vizzarro@arm.com>, Patrick Robb
 <patrickrobb1997@gmail.com>
Subject: Re: [PATCH v8 9/9] dts: add selective Rx tests
Message-ID: <20260605142815.1aaf727b@phoenix.local>
In-Reply-To: <20260604193324.1996141-10-thomas@monjalon.net>
References: <20260202160903.254621-1-getelson@nvidia.com>
 <20260604193324.1996141-1-thomas@monjalon.net>
 <20260604193324.1996141-10-thomas@monjalon.net>
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

On Thu,  4 Jun 2026 21:31:01 +0200
Thomas Monjalon <thomas@monjalon.net> wrote:

> Add TestSuite_rx_split with 7 test cases:
> - 3 positive: headers only, payload only, two non-contiguous segments
> - 4 negative: missing offload flag, out-of-range, overlap, all-discard
> 
> Add selective Rx capability detection via testpmd "show port info".
> 
> The test suite could be completed later for the basic buffer split
> configuration based on offsets or protocols.
> 
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> ---

AI review found:
Patch 9 (dts: add selective Rx tests)

selective_rx_out_of_range expects a rejection that never happens, so the
negative test will fail. It configures a real segment plus an oversized
discard segment:

	rx_segments_length=[ETHER_IP_HDR_LEN, 20000],
	mbuf_size=[256, 0],

and expects start_all_ports() to fail. But an over-range length on a discard
segment is not rejected anywhere: rte_eth_rx_queue_check_split() does
"continue" for mp == NULL segments, so it never length-checks them, and
mlx5_rxq_new() clamps it:

	if (seg_len > tail_len)
		seg_len = qs_seg->mp != NULL ? buf_len - offset : tail_len;

The discard seg_len becomes the remaining frame length, the queue is built,
the port starts, and the test hits its fail().

Clamping an over-long discard to "the rest" is harmless (the bytes are
discarded anyway), so the cleanest fix is probably to drop or rework this
test rather than add a rejection path. If rejection is the intended
contract, it would have to be added for discard segments in patch 2 or
patch 6 -- a behavior choice, not a correctness requirement.

Minor: expressing a leading discard as --mbuf-size=0,... puts 0 at index 0,
and testpmd treats mbuf_data_size[0] as the primary pool size elsewhere (the
max_rx_pkt_len > mbuf_data_size[0] check, the default mbuf_pool_find(socket,
0)). Only bites an unusual config, but it is a latent foot-gun.
