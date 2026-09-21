Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67B8C982E6
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 15:54:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3472542831;
	Mon, 21 Sep 2026 17:54:50 +0200 (CEST)
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12]) by mails.dpdk.org (Postfix) with ESMTP id C489F427E8
 for <dev@dpdk.org>; Mon, 21 Sep 2026 17:54:48 +0200 (CEST)
Received: by mail-pz2-f12.google.com with SMTP id
 41be03b00d2f7-cc4c3304833so2213420a12.3
 for <dev@dpdk.org>; Mon, 21 Sep 2026 08:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790006088;
 x=1790610888; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AQu3sug953Gs/0oqOS+e8nMzNSNZIYblqjbK3bcPRRc=;
 b=n8B+RFZPehe8mI0jwhOPL6PIssCul3+02jo6cm6wCr7K2fWjAtNlfomu8SXtnXhvU4
 bciPvy7LLl+knn7kc4/ECD3x8aAEcmHz9YabGEvDbwXI5SzYSHjYFNdBuVatqCzRL0aZ
 gV7pV9XH3+TxC+Y7FDEXEaxfLBz3wyp8fTiYGAWGhS6PzSkEukzQKofBZC7X4eThsn1b
 5c1xKUzoh0bQaLM2i+RnVraS+TXYNjQR9y1UUzxzIl+CkfnIdTLYXchxy/r6HYONyWqZ
 NYYc1XSnFDTfCNbAEkwnr540leSo57MCuezBXQBAdpfPX2TaMrQ0A+4TxH6IDU4vJP5F
 XsrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790006088; x=1790610888;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AQu3sug953Gs/0oqOS+e8nMzNSNZIYblqjbK3bcPRRc=;
 b=MtGnKRQam7jm93bnCE6KtM9PW6x0ydKkVj57wjmslwvf9NOD5u7MoRdg8gJM/DCL/H
 sbNJ+vGo9PLheaVMR8Y5u9o4z/QVTNqB48Ncs6xEMeZM/O3It5mmDyS6QomtJkLIC4dm
 159P7dC76IRKhlr7KaLGKILD+5QpAxD2b5lyqUE8SJhn5cyLy/MPFVFj+yCR4rVQG+c1
 VFU7XKieN1lWq3DaEOB1O9Wvew7PneVlNOyVqVv7/iTu9Wx8z75tX0kOncm1/btnE83L
 u4htjNdmY9Dc5tzNEuGyhchhzgLVV01owdpb81NOVIcA1IOxM1vNNnTcBnDAfs6AlyrB
 uURw==
X-Gm-Message-State: AFuF++n0sSNo4leIHh6/ZSEucs9ha+s96WbIujvE/UiWdg+lfpTDzTF9
 31h/dXCIZCPbUgpOTtQ7uX/QcUnmvgjbtSzQcbaNFPstML6N3T3WEemT5KNSSCr1SCM=
X-Gm-Gg: AYBFou2BjQ7y2K/xqjyzfEr0Ofl3YsIF4cLBB432RuzHotFy0LWMa3f5TwlHo/t7Hv+
 IGlrC2ia8jEpUeuXHhVxqCJdnvL5PqBvyK2N83JvkJvAHbjsggaeIXjs8/GLUtMqPg3G+g8j1sc
 pHSbv0MeVvUxzKQQkGUR+2tNKO2+gKKKdjBAIhooy8fcbavM3N7/GJBci6TFG5J8/BPp4CGS1vR
 lmDxjENISeJjYzVizt4TLHnu2EhOSU2Bsrb39s+PTpGDJK8NWZTxdz7P240zgzJQN9fnJ6URW/w
 XbA5yyHJckGQ7IzQLyPOOo44DWvviTf88izX6YI4HLaF0fs7HGweAH9j3Wi5hmwyxweph980Taz
 heDjTlm4PgWt0jMfpKLRIeNWItw0CcNK6A/YxCiorFYK8bA4Z2nRDFBuYRl1g1694MfLAn2hvEO
 VMCLGEFFAsPMQ87kffbB7j/XJV/s/T8ovFKmo3XCUnZ5reuC6BarCNm7o5dqiJdeuj1GR1qgJby
 BEnskJhhlVeOlSgHzYlqmVyXbrK86xsmWhStNd0
X-Received: by 2002:a17:90b:1845:b0:3a0:42a9:9c7c with SMTP id
 98e67ed59e1d1-3a042a9a00fmr5079806a91.39.1790006087854; 
 Mon, 21 Sep 2026 08:54:47 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a063c1994esm735465a91.17.2026.09.21.08.54.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 08:54:47 -0700 (PDT)
Date: Mon, 21 Sep 2026 08:47:27 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Cc: dev@dpdk.org, kishore.padmanabha@broadcom.com, Joseph Wong
 <joseph.wong@broadcom.com>, stable@dpdk.org
Subject: Re: [PATCH v2 2/5] net/bnxt: fix bounds on firmware-reported
 resource counts
Message-ID: <20260921084727.6d55953f@phoenix.local>
In-Reply-To: <20260921022002.1033815-3-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260918032726.763384-1-Mohammad-Shuab.Siddique@broadcom.com>
 <20260921022002.1033815-1-Mohammad-Shuab.Siddique@broadcom.com>
 <20260921022002.1033815-3-Mohammad-Shuab.Siddique@broadcom.com>
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

On Sun, 20 Sep 2026 20:19:59 -0600
Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com> wrote:

> From: Joseph Wong <joseph.wong@broadcom.com>
> 
> When parsing max_ring_grps and max_l2_ctx values from firmware, clamp
> values if they exceed a 16-bit value. max_hw_ring_grps is received as
> 32-bit in __bnxt_hwrm_func_qcaps() (the func_qcaps response) but cast
> to 16-bit when used; add the clamp there and, as defense-in-depth,
> also in bnxt_hwrm_func_resc_qcaps() in case that response's field ever
> widens. max_l2_ctx is 16-bit in both responses, but its post-read
> addition with max_rx_em_flows can overflow a 16-bit sum; widen the
> addition to 32-bit and clamp the result.
> 
> Fixes: 2691827e82c0 ("net/bnxt: add HWRM VNIC alloc")
> Fixes: 80bf6811fa0f ("net/bnxt: fix L2 context calculation for Thor")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Joseph Wong <joseph.wong@broadcom.com>
> Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
> ---

Better  AI review flagged:



[PATCH v2 2/5] net/bnxt: fix bounds on firmware-reported resource
counts

Warning: in bnxt_hwrm_func_resc_qcaps(), resp->max_hw_ring_grps is
uint16_t in hwrm_func_resource_qcaps_output but is read with
rte_le_to_cpu_32(). On little endian the new clamp is dead code. On
big endian the 32-bit swap of a 16-bit field yields value << 16,
which the clamp turns into 65535. The fix is rte_le_to_cpu_16(); the
"in case the field ever widens" clamp should go.
