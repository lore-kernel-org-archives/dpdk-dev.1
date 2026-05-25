Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7A0CD5BB1
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 May 2026 15:35:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1458A40276;
	Mon, 25 May 2026 17:35:15 +0200 (CEST)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178]) by mails.dpdk.org (Postfix) with ESMTP id CD54940144
 for <dev@dpdk.org>; Mon, 25 May 2026 17:35:13 +0200 (CEST)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-30455f77e0eso5659652eec.0
 for <dev@dpdk.org>; Mon, 25 May 2026 08:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779723312;
 x=1780328112; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cK9vemiHCbyN5F25cS1rChQ7cwe2hhJ3RMpHyF7AnGU=;
 b=Woc6hcao+ov6QkynKsMErKKn1RCKQGw3YDjxfXpvOg8bBQMkyZT/oePu/u1bdgobDW
 /7vAZSt8D5rbCIkjtn6Vrff6ys4FqX4e86arV3nklnDqkdWPtzuOeN/DvjMCxKm8Q+rU
 FpF+JJE8oD0+KIiJfGIIc2e29M7CV0o4/GHf0UkD3GZY///3Ut+GLMdhLx0LxQc+kaGz
 a25qVFCEFlMOJLyPLkl8czGgtypGmwDt4qB3cT7ehA+cX4yPScaczyQdUBQMUdp1KKpx
 lD6U9QJKln9V13EL5KUSWGe+AuZrfVE0Q7WhDLWHRRChCh0IVYU7LBAHbfPi0UThJSPJ
 /r2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779723312; x=1780328112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cK9vemiHCbyN5F25cS1rChQ7cwe2hhJ3RMpHyF7AnGU=;
 b=UeXsqfWFLOByeI0xNrhOxRsNd00m+K4zz9UMUjJU6LhATAOFMVffqX4OT5hh+LtcB4
 nG1XyjAtFznXthrdo5Kf8eSJDwLa07+rFgZY96fImmJX7kDd2fjeEQmzPpm0HvaABvcK
 N4hIQ4x22o63Sl7lxyJB70YpQkU6e4zlePpU8zYCzWsXCaXb/4JEopflMi2Gz9xXMLv1
 4lnUxb4AkhbJHnDn3yO0dEV4TwvWKoVjAbMGcRM5XBk59xO1NhWLPWCCUxrWISiZdLtD
 QiSiX6qwccO2e27SueltN4MuNWq3j9pHD2UhDNSpoHCt57BsaiWTpFS8UQ5ph2iKAH09
 PyAA==
X-Gm-Message-State: AOJu0Ywtc1g68+EnCKnY+g8fKmjmKYcOwepOSObvm1c4hDdx7CC0ZjsO
 NZwhUFrlaFyIjC4GN8LR+qg+k+KeYvK6goppD90Soi/OUjwEBssligSKOuzuBwbwkhM=
X-Gm-Gg: Acq92OHguFrtm1PZIH57+Jey+mTxZMXPBiZOr+lNNnKbJcGyprdCsk+cVagfl+OQ1em
 v4ESxMZf98HHHexaFFOk50lCj2Nepncu1PNB6xeYCC/GAFB7WDpz1bQxcCDeCk2bTParWY/kYVg
 +WwTrnBkLoRh2NWpu9bJD9NKac2BoLWhvI7/2L5l7By4JnQiqY1aVa5uxYms8UnmAN/Eh60X2Hh
 TbGEgZX1Ds/idyuHIPTYXHkCEqmL+kT8WztE5ay5NQIqCDV8zUW4bM15KyuLgrcyJ30fh603Cy9
 gaAaJpGmlf/kU2cqRwWme3992WAD0D3qBkOkdjwuYqhAZQ1gVv6WVNmPywQbt+zIEuKvYs11gJm
 cf8W1N+IpWqB3JnHGzvPspH1QKOqHAnSzN6ao28EUD7g53OG+YEakCPsgcwRvhhg1ONLq9A63KK
 3+BxufhIvkeLa4Nrby+pyVALVQyKjYyqNoxIWtM7QZBm51WN/CPQ/+Zb1ncaEXLg6a
X-Received: by 2002:a05:7301:578b:b0:2e5:5bf4:8869 with SMTP id
 5a478bee46e88-3044914a18dmr6813149eec.21.1779723312550; 
 Mon, 25 May 2026 08:35:12 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304522314a4sm7862704eec.18.2026.05.25.08.35.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 08:35:12 -0700 (PDT)
Date: Mon, 25 May 2026 08:35:09 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH v3 03/27] ring: use compare-and-swap wrapper
Message-ID: <20260525083509.00cf76a1@phoenix.local>
In-Reply-To: <b827bdd2f5994f24b9806e5cbae82cd3@huawei.com>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260523195604.441947-1-stephen@networkplumber.org>
 <20260523195604.441947-4-stephen@networkplumber.org>
 <b827bdd2f5994f24b9806e5cbae82cd3@huawei.com>
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

On Mon, 25 May 2026 07:41:13 +0000
Konstantin Ananyev <konstantin.ananyev@huawei.com> wrote:

> Hi Stephen,
> 
> > The rte_atomic32_cmpset is deprecated. Initial attempts at
> > changing this with direct conversion to
> > rte_atomic_compare_exchange_weak_explicit()
> > regressed MP/MC contended performance on x86 by 10-30%,
> > because the C11 builtin's failure-writeback semantic forces
> > GCC to emit extra instructions on the CAS critical path.
> > 
> > Add an internal __rte_ring_compare_and_swap() wrapper that calls
> > __sync_bool_compare_and_swap() directly, which keeps the original
> > instruction sequence. Add equivalent function for MSVC.  
> 
> In fact, in rte_ring we do have 2 implementations of the same core functions:
> lib/ring/rte_ring_c11_pvt.h  - uses C11 atomics
> lib/ring/rte_ring_generic_pvt.h - uses legacy instructions (smp_mb, extra), 
> If we going remove these legacy instructions anyway (or reimplementing them using C11 atomics),
> then there is probably no point to keep rte_ring_generic_pvt.h.
> Konstantin

Have been deep diving into why C11 atomics give 20-30% performance
drop versus atomic32 version. So far it comes down to GCC optimizer
not doing as well with C11 versus assembly. The C11 form with the
excessive use of always_inline consumes more registers.
