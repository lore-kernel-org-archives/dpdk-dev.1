Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067A610F2844
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Mar 2026 15:37:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B5AB40E49;
	Fri, 27 Mar 2026 16:37:59 +0100 (CET)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44]) by mails.dpdk.org (Postfix) with ESMTP id 88001402C5
 for <dev@dpdk.org>; Fri, 27 Mar 2026 16:37:57 +0100 (CET)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-35a094cc3e9so1450805a91.3
 for <dev@dpdk.org>; Fri, 27 Mar 2026 08:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774625876;
 x=1775230676; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=17ueCU5bOQAb6IQ5e6buc9+3x+v3/+x7cHt7ANsaOZI=;
 b=MP9J2cjKq2pcHuAp13sK2WY93/V+S1P7VZWkzDnXCVqDbCrAO07t8rrcFsDRDUYFxg
 kKrqCpOOKG6vzxJ8I4TllP5K1lPm/wdy8b67saOCVc13Cf10QMS+SwEZxuhUYCZ1DUg3
 eT9YP1K/M6ptlFO7QuGjITlZRWp4GHFY0kER43qA0zEp8Bg/Ck8j0osq2EISOrAUvWz4
 uywanKRsnKm29+XOKJq6iR3ELLm6MZcvogtubHr0kE7oor7bMnhe5LqepuVXzIgxCIJA
 8IkVSoER5MKv3lu/kCYpfO+XpKKzObNC/YzJwV0jNuRiQKZ0JxTIJZWXqx0Awu0bXm/G
 9Dtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774625876; x=1775230676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=17ueCU5bOQAb6IQ5e6buc9+3x+v3/+x7cHt7ANsaOZI=;
 b=i9Epgm3XPCJcNgA2wp2geT0ZHS8q7Adxiz9eOFc4fg7gAsMJQmHs1vMK9MB2kTzzvQ
 BDSPXFEnHQkSMc0Bqe7UWyO2xcG7LhX12YojBCPlLJVlqhXzD6i6wQXy3NTqMcA4FRpq
 pe6CEDr1q4WgOU1lHIEwzYbE3NpvHU8SFuu3qot3HNCdg21bDcb02LLH3x+PSgP/duaB
 4FxdTrD1QHj6i0UayMCEtxllQLg7htstiDX3xMt+QmNjJJL179eftR0CnJ78KHL+5eYX
 HX966Pm8UNR+a0mbV/P3mXvdCC9e1Tew4D0+Se5i1KlihrCQnxpX8FAdh2fF2GBjt/Vz
 YDXg==
X-Gm-Message-State: AOJu0YyLgiQfg9Gv715XoO0eHv5REMrAKwee4F/Mq5yqeRuXHeCqYg5m
 OILVNx2F6h3g/7+AHcnmdc18n3qZgTIAlMUJ8NeWJfmVHkyiPpbB7Xo/nSZybiOyaVM=
X-Gm-Gg: ATEYQzyqDIr68CjDhnwaZ4K+FiyC0ChHhd/01cPT/DzRCWXO8I5beX8eXA9/t+PB/qg
 aSeMRW3x6lUxsT+g89dfvSZYnWPD/4R7hVC6gofqkC97BMSke7dSJdnNoEWiWpHIMSaRzB9Uxmy
 c9uAuwp1T7b6XIhhbJNkty0gNNP+6RymOmP4jW164rROvAJtg+W/ebAyUl+6LCYIFdbIs7QFC08
 eV8ySLT+40UxGFxA/ZGYFeMTT3eZlujFc8T9yjAcMo9Hwd6SgVzDYrCNDUxC0lcapfMVFZsJ0Ai
 hPU73+neua8mtZvhZVv+mQyB67c+mVm+qdk4uSsBl6sQFxXbqqQgSi1x/Aj/UObzj2Z/pSFZP+g
 P77/OQfuhd1gavYZyqxnv0sx6RfrCrWVYIRoFLcx5rEhCgvs+3bvaKmp2nEy550RlQT3nlKf+CL
 7DGDMZZahDZ98ZP3bYoc2SQN2AKScceFOSFgY=
X-Received: by 2002:a17:90b:2c88:b0:35b:9ab6:1d4b with SMTP id
 98e67ed59e1d1-35c300bda29mr2903875a91.20.1774625876549; 
 Fri, 27 Mar 2026 08:37:56 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35c22ba7b86sm7133202a91.10.2026.03.27.08.37.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 08:37:56 -0700 (PDT)
Date: Fri, 27 Mar 2026 08:37:48 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2] net/tap: fix close for partially configured port
Message-ID: <20260327083748.4b7ec2c3@phoenix.local>
In-Reply-To: <20260327083903.3394778-1-david.marchand@redhat.com>
References: <20260326124612.2580985-1-david.marchand@redhat.com>
 <20260327083903.3394778-1-david.marchand@redhat.com>
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

On Fri, 27 Mar 2026 09:39:02 +0100
David Marchand <david.marchand@redhat.com> wrote:

> In case no rxq has been set up (like when starting testpmd with no mempool
> drivers), a crash happens in tap_dev_close:
> 
> Thread 1 "dpdk-testpmd" received signal SIGSEGV, Segmentation fault.
> 0x00007ffff7fad68b in tap_dev_close (dev=dev@entry=0x4c4a80
> 	<rte_eth_devices@INTERNAL>) at ../drivers/net/tap/rte_eth_tap.c:1111
> 1111			struct rx_queue *rxq = dev->data->rx_queues[i];
> 
> (gdb) p dev->data->rx_queues
> $4 = (void **) 0x0
> 
> Fixes: 23e2387b49a1 ("net/tap: allocate queue structures dynamically")
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>

Acked-by: Stephen Hemminger <stephen@networkplumber.org>
