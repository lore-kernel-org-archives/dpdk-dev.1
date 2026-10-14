Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A29CC6B2D
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 22:55:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 36B794025A;
	Thu, 15 Oct 2026 00:55:44 +0200 (CEST)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mails.dpdk.org (Postfix) with ESMTP id 2FCCD40144
 for <dev@dpdk.org>; Thu, 15 Oct 2026 00:55:43 +0200 (CEST)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2e608cd460eso25323245ad.3
 for <dev@dpdk.org>; Wed, 14 Oct 2026 15:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792018542;
 x=1792623342; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VNxEU6Ey7unu/jlhiuOEINEjeSusU47TTii7J8q6+jo=;
 b=M8/r1W1OeYe1N0Rh85dQT5z9ZOi8iUEWYMG8tiNvl4S8SMbJqKo83k+xy0bOuPWTfH
 WsLXDFBOAad1JdAdAkMG8O8Au6FjeWqc3+TVU8dv2z60EIb2gWF+cDFjcfDvnejHCaNz
 FJCnzXrYFvF/SBQKOihyj4//mVROQl7oUkByNw3XxSspEfFvtfzrMGE2ZWjQTrLJgel8
 sPZWNK5YzTAM9vV1YxM2IykezXX98Sv2zsdpZbEh3iOviJH6c0edP5NaYBXm1yg0Z7wL
 wEdc2sKhMqAghGfqKFOyLaegmOrObmGrrt+srOGDXLDZkK3sFn00LYqlCjR2g4tEG4Me
 WGEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792018542; x=1792623342;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VNxEU6Ey7unu/jlhiuOEINEjeSusU47TTii7J8q6+jo=;
 b=AYHUMx8yK/x1p67MDNmwVuyAAUno5Z+Lz5O6g88iMXP7/ZhUxw0fhPpSOKQ0Fb22vW
 evS8sQu4p3LlnrsfnD9F7Z2YEAOvOETa1G+LI5j5yjCSI76RAj7aDfKOhKjJtPpwG452
 DSyZpR8Ybqm9pUhO1ni19brCVe76SOixSi/jBH1Wq5pedcSOrHhXguR2JSKmgNPTpiwi
 /5Esz/THtkQ5SOVWVIp2gOO/nlAkqSV9OB0BtrHRmgWKc56hFraPjzKubofjEFFrxW+3
 NPu3AL78Imw728obSCB3sjNbQHVL89f9kirc9HAKwQ5ExKbS1U5zpe4GPCkvh7YhIzQ+
 PfEQ==
X-Gm-Message-State: AFq9FYIVb5hO4SIA63FLkZwP8OlU+GN3PpoWe90/0jFV6CTL/KE3nYPZ
 MXq61E/dWKm+dyw9ISAuGQBz18HX6e5JKa6KXLpaETaMfjLVAOAOswHW7cjlg2cWJXs=
X-Gm-Gg: AYBFou1V0l+LlK/FQUm1S6t7ZK3XspP5FivktEercxNH1UfaXWqkLOfYLGEtzIEpxq+
 KdPQ5mCktwdxnVY41z47jH+xn0LoRnCu/ccvLTnVEcdquU7FX/Z5GxoRuMoXxjsUoe5TYxXff46
 vfcDdIafz+dhZueYvuwhbbnCNhJDdxoI9wDhu2SbdL0EuBwEvoaHQ/FcSOOp5+iLoDzqkWEqht4
 eAn8UN64PTWLmAAqGjb9zHndDkoTArvT2+jkpc1JPx1SiquPXPhk7lwARp/EneJF/aTnfg+Q6m0
 PxaGqBbE5C4zUI+Xo7ZYvftKvr/3griojI4vQgXSpi60yrzoPF3FHZui0BMkSlOhiBTs1XPMWWE
 1ef+Wfs8oiZQhPsUr0cb+8cRCgZOmxeenZsggcCHIA9lhstM8aQr9zYHqDIcp1Pkf/9YSSuNw0a
 DHAGD1Hk8RBelgheFaYXqxQnhGCiZUdeRnCdCto9fz8pB94z1Sy0u02qGuXP2C6hbsoZj8KHnnu
 CI+93vgx/4kLWg3+wOOOGqW+bABlqqaGje/w5uR
X-Received: by 2002:a17:90a:da85:b0:3ac:1c76:61c3 with SMTP id
 98e67ed59e1d1-3ac1c767e3fmr7341349a91.27.1792018542276; 
 Wed, 14 Oct 2026 15:55:42 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac943e7548sm1299498a91.1.2026.10.14.15.55.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 15:55:42 -0700 (PDT)
Date: Wed, 14 Oct 2026 15:55:40 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: dev@dpdk.org, rjarry@redhat.com, mb@smartsharesystems.com,
 maxime@leroys.fr, konstantin.ananyev@huawei.com
Subject: Re: [RFC PATCH v2 0/7] VRF support in FIB library
Message-ID: <20261014155540.33820187@phoenix.local>
In-Reply-To: <20261014183921.495158-1-vladimir.medvedkin@intel.com>
References: <20260322154215.3686528-1-vladimir.medvedkin@intel.com>
 <20261014183921.495158-1-vladimir.medvedkin@intel.com>
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

On Wed, 14 Oct 2026 18:39:14 +0000
Vladimir Medvedkin <vladimir.medvedkin@intel.com> wrote:

> This series adds multi-VRF support to the IPv4 FIB, allowing a single FIB
> instance to host multiple isolated routing tables.
> 
> Today a FIB instance is a single routing table, so an application serving
> several VRFs needs one FIB per VRF. In a burst oriented datapath packets of
> one burst can belong to different VRFs, and the application either does
> per-packet lookups in different FIBs or regroups the burst by VRF before
> the lookup. Both are expensive. With this series all the VRFs live in one
> FIB, the bulk lookup takes a VRF ID per address, and the existing API
> operates on VRF 0.
> 
> v1 replicated the 16M entry tbl24 per VRF. That kept the lookup on par with
> the single VRF case, but memory grew linearly with the number of VRFs,
> which was the main concern raised on v1. v2 resolves the issue by adding
> of two dataplane algorithms with different memory/lookup trade-offs.
> 
> DIR8-16-8 is a new three level variant of DIR-24-8 with 8, 16 and 8 bit
> strides. Only the 256 entry root table (2 KB) is replicated per VRF; the
> tbl16 and tbl8 groups come from pools shared by all the VRFs, so memory
> follows the routes actually installed rather than the number of VRFs. The
> cost is an extra memory access for prefixes longer than /8.
> 
> DIR-24-8 gets multi-VRF support by resolving the VRF after the longest
> prefix match, along the lines Konstantin suggested on v1. Instead of a
> vector of next hops per prefix, a single tbl24_8 shared by all the VRFs
> returns an internal prefix ID, and a hash table keyed by {VRF, prefix ID}
> returns the next hop, a miss meaning the VRF default next hop. The aim is
> to resolve the VRF with a single memory access, so buckets hold 8 records
> and there is no probing beyond the bucket.


The problem with existing FIB lookups is they are space intensive.
They tradeoff memory for cache misses. Every level of indirection adds
another cache miss.

Not sure they work well for VRF case at all. Normal LPM is more compact.
For normal mortal size machines having multiple VRF's is going to be huge.
How big are you envisioning this?
