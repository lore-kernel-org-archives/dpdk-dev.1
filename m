Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63CA5CA9EC7
	for <dpdk-dev@archiver.kernel.org>; Sun, 11 Oct 2026 19:54:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6CA5F40279;
	Sun, 11 Oct 2026 21:54:21 +0200 (CEST)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43]) by mails.dpdk.org (Postfix) with ESMTP id A5EE04026D
 for <dev@dpdk.org>; Sun, 11 Oct 2026 21:54:20 +0200 (CEST)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-381b831d535so1438695a91.0
 for <dev@dpdk.org>; Sun, 11 Oct 2026 12:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791748460;
 x=1792353260; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tOpKVjFIhgDSGCrrDhWBSpGqTKLljFxa3jc2d8qFNPA=;
 b=KZFtHIAB8U1CjKUBgRW34Zpv6lMpsEH1W2/0yxzZUnVKbKxapArenM6ponXCQ/auCV
 zKFzaZpac0VeBVzJs+z7BB6eXJxl1IqtMmcnKv8qaHRBX4lEd4rvKospEi85RsQjlpvL
 1sAFS3O0eDQoRe2NQhj5tpH1P1PENuj70zSoHNA49FzkeciSw106xsbZwu2zI7h4cTms
 N0R9vp981WPCKNZ3IuSbi9tjW+/ZDrBZdop7h1qu56p6+Xe6phaBCpFl3bcVhbcOte0x
 Yy9UFwIFFWO/AlC16dvS1ejZ/YJjH0/dlzWvBpJcpA1yEB3dcwJZeFdIT6K6CY0Dqc7e
 ZmBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791748460; x=1792353260;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tOpKVjFIhgDSGCrrDhWBSpGqTKLljFxa3jc2d8qFNPA=;
 b=UNVseQ0ycl+ovzKpjnS1XW+OWdyRtf6FtyMolTrtckvuDwJb/tC5Is+6B5hc6Mv0X1
 7J/5YsN7Df3ShwsbTIqF53OB1IRz154/Dtki3xdB6Mc2BDN0+xDelou6L/Wsbz2YNvNw
 SVEf+RNYTqCMSy0oDlVmm++cxSknc5SlgB42PyGDJcEdvnzctObRxqKzr8LaYRV245o0
 udClnIUkX1oieb6HWFv6crUHlN9VbaZvQva0hmgezHbbWEKTjJgIs/rj8mFpvlPOTAt/
 piD1IjNVGQjmtZpOSSLF7nnPaMxIToLS5WFvwIzmWP0pOOEOYJS2+nF2evd9nnTv57fR
 0TLA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzj6DKzsB/8+SSc/iR+sIV2ajubXtyygQF7BWC+jek3O9J0iZJrmTJMCvO2BKOWfsMYxBc=@dpdk.org
X-Gm-Message-State: AFq9FYLUY9AVQSpUYRdcsEJD13I1YGVuGBz6ZIyIXM2u1W3nts7kJdW/
 645za8swwbjHk1xVCGa/kvXv6Ov0rMHbCEQ1fLGjvYMCDKEHwozs4JqIScwjCEUGHvU=
X-Gm-Gg: AYBFou2ZjX1StNVXLMxT6AyYH5aCfmbSDPHpYg43BLZUJ1aJAKoPHrpS6O0E+hN9wNl
 yT9pCIoGMHUgedb5t4SvFY1aU1O2Qese8uhDwEdlvX5c/6wgXnhpIfrN16KLSmDsCEcVijr6Rqa
 UmiqlfUKA9L9tcZz5JTEMOeyvN4jhoc6nA4phVQQIWJB/HZ3QNTOcoDOq2vemGQGM+6E0wMEd3w
 Sn13/MbKgLTMmi2MmAP/50KTeuUPq1xZNOjAt3CaN0LByllSY26gumA3VmuYbJREfgLLd2UXiwD
 5mqP6MehwjCy8g/nPwx3C5jQZdp5xynpFH0OtxNH0gsKpien07efQMQzcawb7LM6h4fm9FmHykB
 awyD0vL4JISMyqrR+rWIYElZsqKdFVcrom43JprxDiHHIJNhZIzHXN/N4tcHvl4sGcfwDkiH+V2
 ZegOvE8bHnAFWOp9YFw2u938Mye32UiX6fdhj9OV3mD1Y21vztrlXtxIOlsGYvVlbjntej7w1Ct
 X3Ry3q3759uTDaByR6rx2JXKf40FMpmEkuyREPQ
X-Received: by 2002:a17:90b:3d81:b0:3a7:9adb:2a18 with SMTP id
 98e67ed59e1d1-3ab3ae6964cmr6440249a91.62.1791748459677; 
 Sun, 11 Oct 2026 12:54:19 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac05cac83bsm426122a91.10.2026.10.11.12.54.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 12:54:19 -0700 (PDT)
Date: Sun, 11 Oct 2026 12:54:17 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Marat Khalili <qm2k21@gmail.com>
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>, dev@dpdk.org
Subject: Re: [PATCH 9/9] bpf: make callback handle atomic with relaxed access
Message-ID: <20261011125417.132bcbbb@phoenix.local>
In-Reply-To: <20261011182158.124246-10-qm2k21@gmail.com>
References: <20261011182158.124246-1-qm2k21@gmail.com>
 <20261011182158.124246-10-qm2k21@gmail.com>
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

On Sun, 11 Oct 2026 18:21:57 +0000
Marat Khalili <qm2k21@gmail.com> wrote:

> The callback handle member cb of struct bpf_eth_cbi is concurrently
> cleared by the control plane on unload and read by the datapath to
> decide whether to execute the BPF filter program. Without atomic typing,
> this concurrent access constitutes a data race in the C11 memory model,
> even though hardware pointer accesses are single-copy atomic and untorn.
> 
> Change cb to RTE_ATOMIC and use rte_atomic_load_explicit() and
> rte_atomic_store_explicit() with rte_memory_order_relaxed for all its
> accesses. On modern architectures this produces the exact same machine
> code while eliminating undefined behavior.
> 
> In addition, marking cb as atomic improves code self-documentation by
> making it immediately evident that cb is an active part of the cross-
> thread synchronization mechanism on par with use.
> 
> Signed-off-by: Marat Khalili <qm2k21@gmail.com>
> ---

Since inuse and cb are inter-related would be easier to squash the mb
conversion and the bool and the atomic cb into one patch.

