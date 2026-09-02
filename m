Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEF0C624D3
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Sep 2026 14:16:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7FD29402DE;
	Wed,  2 Sep 2026 16:16:29 +0200 (CEST)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by mails.dpdk.org (Postfix) with ESMTP id C6C3740262
 for <dev@dpdk.org>; Wed,  2 Sep 2026 16:16:27 +0200 (CEST)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2d6fe26ef1cso11922115ad.2
 for <dev@dpdk.org>; Wed, 02 Sep 2026 07:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788358587;
 x=1788963387; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8lWK4NLBDWomsY5Sva7BcqMehK+1xJqYvNkTgLlQEY4=;
 b=0wdu6JQo+yrWGwuD9AJuPNK2vedvt1hV8BkAxeGZOYQZrcNuOYllA3soqE+Vhihr9k
 p0rY/f5LMW+k7oxKch/8EVdtzuzG/4wWYKlkfDlXT7GqtlNxNGdCv83bVOMN5WM3V3kT
 B+WPnV5Dmn3TrV4vFT4q3Fz/KKeeNs7TQ2ZaqtZgVMH0zU9ZL+93UHhUTfC//95MXmtg
 m6vRTQr/VokO+2LudoYcY0ykW5gsTBmSiyXrmsMJKR5+RlBfAccMvznShqmUXKK25pFs
 vpdnrSpc4DZze8iMCRPpjLxV9ycXeVEz5Sa7cHwsdyYxioJDdRUDRHAdmCACk1y5sJba
 Aebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788358587; x=1788963387;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8lWK4NLBDWomsY5Sva7BcqMehK+1xJqYvNkTgLlQEY4=;
 b=U3+bFgB8xqv5CPQxf/sggnGAwxdDrRgxH+7p6TEejw5cBTzmwbm1h790MKSct/DXv/
 Cx/qKDm/HxQ4K8Z4uoVVa9Yxxr2DmkU+1hzYdNngqfk9lBKz9s67iRoug/myjBs74ofo
 A/z0oaqo6p4LUX0qXz7+J4tYygRvB5HgPGFUVTJbmmYbuQmdxbmbGlabR+5sD9Z/Kw5D
 ZIcLRjpJvlPnETlNrJjXfVna6s4hFjpU05AABFr2ZkuQTyUwuNGoFY9mpeP/Gf6sJT65
 i0fUUlZnrxocugx6FPfJLp5l45I7me7bkWX5eiC3BGAmxcxq9RsAAYs0D03OhDB1Jxa6
 v6Kg==
X-Gm-Message-State: AFuF++mm1NJ3zLlXI1hG+h6C3qfdSgp44lkgB5K/hWsihrd5sI14jPWY
 He4oDK7B1RAwmVNbHbVxU7GGNDwX9nRKFBul79kapQHuhw8iKF0q0sUNtUlURLISfrQ=
X-Gm-Gg: AYBFou03GHWiNRsXE3DxjhuTHB5XgJ/Qzkggl4UC1DAQIwlZ24mltEkJa12D0aQUAOC
 ZkTsPXwkQxvmS8w1EC+rGuZaGfd1UeV3V1XFtUuJDionXlYKzkNkQfWf+G/En3dLB5JemmdqmB/
 ojlH5mXfkz6B/xKIIgvcOhwLGPQuICkyUzalp22S5uaHOmvkSEusuCbQaTh4f14FVU6TCsohuPI
 uvhlCe+2LvrQeNbyNcntDlfvO9T7JzTqmki3Owc5D44JInq4i+wA6csgOfv2Oe09NoqAMuT2nR6
 e/e4dD2JqmhsCAXg0TdDssDZjhR3x+7ILhsmvh2NMmUdDPcoU4RrcuaIlr2LzdOpmosSrmYnMbT
 EEHfIR5aeaPuNWbrW5Lap9TGNJxdqDF2VNgI1ppw5hfZlNlQ1mTjLU49SEBEbnKNzVJNAMJkbcl
 HiEqogDN51wcdic75RV0q5mZ4B69vIKvhZl1ieODbAzqS19n8m7eps9Mmoha4CRBQaFz+xakpOX
 FI4RpIUdOr7h9DqsSXyS+2wsFE8hA==
X-Received: by 2002:a17:902:f54b:b0:2da:f75f:adbc with SMTP id
 d9443c01a7336-2daf75faf3bmr17831305ad.15.1788358586595; 
 Wed, 02 Sep 2026 07:16:26 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dadd4c4052sm13492685ad.74.2026.09.02.07.16.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 07:16:25 -0700 (PDT)
Date: Wed, 2 Sep 2026 07:16:14 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Rajesh Kumar <rajesh3.kumar@intel.com>
Cc: dev@dpdk.org, thomas@monjalon.net, bruce.richardson@intel.com,
 andrew.rybchenko@oktetlabs.ru, aman.deep.singh@intel.com
Subject: Re: [RFC PATCH v2 0/1] ethdev: add Tx timestamp slot APIs
Message-ID: <20260902071614.45e5a34a@phoenix.local>
In-Reply-To: <20260827123437.243365-1-rajesh3.kumar@intel.com>
References: <20260817192417.3009990-1-rajesh3.kumar@intel.com>
 <20260827123437.243365-1-rajesh3.kumar@intel.com>
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

On Thu, 27 Aug 2026 18:04:33 +0530
Rajesh Kumar <rajesh3.kumar@intel.com> wrote:

> The ethdev timesync API currently exposes Tx timestamps through a shared
> hardware register. This requires applications to serialize timestamped
> packets and does not allow correlation when multiple packets are in
> flight.
> 
> This RFC proposes an ethdev interface for hardware with independent Tx
> timestamp slots. The interface reports the supported timestamping
> mechanism, provides a port-global slot lifecycle, and lets applications
> poll each slot asynchronously after transmission.

Later review with AI assistance also reached conclusion:

Overall, this adds seven new experimental functions plus an exported
array to solve one problem. Before going further, cut it down:

  - drop rte_eth_timesync_tx_slot_dynfield_unregister(), it does nothing
  - drop rte_eth_timesync_tx_slot_dynfield_register(), do it inside
    rte_eth_timesync_enable() and fail enable if there is no dynfield space
  - drop rte_eth_timesync_tx_timestamp_stamp_mbuf(), export the offset
    and flag the same way rte_mbuf_dyn_rx_timestamp does and let the app
    write the field
  - drop the rte_eth_timesync_tx_slot_infos[] array and the static inline,
    PMDs get the two globals from ethdev_driver.h

That leaves caps, alloc, read, release.

For the legacy API: rather than a doc comment pointing at the new one,
have ethdev synthesize SINGLE_REG / max_slots=1 from
timesync_read_tx_timestamp for PMDs without slot ops, convert testpmd
ieee1588fwd and examples/ptpclient in this series, and add a
deprecation notice with a removal release. Otherwise we end up carrying
both forever.
