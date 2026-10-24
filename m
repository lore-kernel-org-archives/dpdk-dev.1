Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F3B606A31A
	for <dpdk-dev@archiver.kernel.org>; Sat, 24 Oct 2026 20:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=NCbn4nwO
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AE8D5402E3;
	Sat, 24 Oct 2026 22:47:23 +0200 (CEST)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mails.dpdk.org (Postfix) with ESMTPS id 995BF402B2
 for <dev@dpdk.org>; Sat, 24 Oct 2026 22:47:21 +0200 (CEST)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2ea138a3497so11302795ad.2
 for <dev@dpdk.org>; Sat, 24 Oct 2026 13:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792874840;
 x=1793479640; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wrC1CwZ57mV/ol1dQ22DG8k7x546Vkvh8TtLSv9SIxY=;
 b=NCbn4nwO+GaurBlwmKjZRyThRTFCgpcV646O3N5pyio1TEqwDfWjC+TF/SPdBCsUWe
 bYTdRy5G2Rw2ignKxKtq9sjB0IjLk2P14qAAfy5KVT855De+G47NG6z8ma+Mrbm3xAed
 sXC8fRMnFNi7zEkekJSomKsy5hNVKVzm5Z7nmEV2klk96oZwT2IKLKGYRFEYuCMYTQX4
 HfX6rhf1tBeg9spfRzIFNjmrdjm7EHU/0+vrseMwqX+D6IZr33bTtPAi/ZGUaMg4MbEm
 OWS+2CJt5dFbTqgkseoa4AK4FKQIJV2rT2SbV/zU1FKshIxZ7q80kXqWQF/tX7yBz6B3
 OeSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792874840; x=1793479640;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wrC1CwZ57mV/ol1dQ22DG8k7x546Vkvh8TtLSv9SIxY=;
 b=w0PCWjZiEO027aTP2A2MESRxloURKd8YkB6TDiCVWow6IP5muhpwk32Xm5VTfxGwdu
 bwVtyPF8K8tOQaFbBXj36+uX1q4S/9ynqTgWt0pGFv2B29YlDtA8ND2Z7uy0CUERdvAV
 hEQIIipwCYPF1Xgb1P12gURnU825ULh/YWBQ59Oo4SwaR0s2HRmVE7hIxcE8f0H7dq7L
 0Ymaz5oP5Ow4I1qKchB+v6bnpa1d5fGqIoYAia7HVmCNZnvIWIvUjSkIFruCS/JYueMe
 ETVLQuN6gUkCzj/BeqYod1U6WjyXPY6vBuz65kDsVzde8JnTVAzvOKKJImlE9gUp96/Y
 IDvw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy13iI+vl7yMorvat0HpreSTcwGks0HLPDC5F+g1gAqfnLPdlMqt2ElaYxPGn/5D5ShpZs=@dpdk.org
X-Gm-Message-State: AFq9FYJIqukqpK/tIwx1zuEBkGMNwxTTAKfXm/a13y+YUVmHRX/9yHri
 +vF4uWMNwyNDv7E8t1oxQQC5GdlaLnpYEBtbr9/vRvO1d0ls8k8gxLbQ2vgRjmTuc7c=
X-Gm-Gg: AYBFou0eOVI4g32/QJQbp/dLs95sb6yOOyQwiDRcuMYv1LEN23oUGkK48rVRHUgYsVo
 QtA0W5uWwZiER1B945Y7ni0Jn4860+iZJyU5ZpfY37cHnL35zRAC2YsW5lr4rwg6Gg2+NhydoRe
 qmFehxn2W0FhfCMycigvN7S5e4w8ucJGzcnYHlVLhnp71BFYcl8nkb6Df/LYFt9HMj83oqAi1Qs
 irtpgPE1qN+8+094XZqdPTlHfAdhiM2NEz3GGguWg1l7gjcQJRBrjMFhB8Iu+W0jxqPXYH/8Q1i
 CwvTPxcz3KrCOSkz8Q49DsEOOA/p3NS7+BAMKaCVN/ZD/uRBsA0l1iRENFEWD5TmqwyotDcUvJ0
 8RQXBj28VgGWA46i1nB6uzAoH4hCBrVMuCkNx/JtIordpB1wWrLE6HhTyk01Tv9rD60n3//fgHf
 hPLPePthVsgDkG490fSjf1GKFSDCzLhhUwkl3dOLNp8liJpMlzmJseh9amaCKW6C9VzsYORzEBl
 OCaj9cWn/Tqd50e5e/FHbVm50h3BL6u1X//oq/p2G+13j5T3H0yEIVBHUk+odnApZC2JF6GQNn9
 5Bnohf8JTAFsQvPJ2n5zrXtq1jr7/Zcv9NLDUsZcViM=
X-Received: by 2002:a17:90b:4ac9:b0:3a7:db88:3491 with SMTP id
 98e67ed59e1d1-3adeabe4324mr2326006a91.33.1792874839880; 
 Sat, 24 Oct 2026 13:47:19 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebe9078asm3592937a91.10.2026.10.24.13.47.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 13:47:19 -0700 (PDT)
Date: Sat, 24 Oct 2026 13:47:16 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Marat Khalili <qm2k21@gmail.com>
Cc: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>, dev@dpdk.org
Subject: Re: [PATCH v2 2/9] bpf: document ethdev callback threading limitations
Message-ID: <20261024134716.64470c74@phoenix.local>
In-Reply-To: <0309fc87-3912-41b1-8b38-7aa581bf07e3@gmail.com>
References: <20261011182158.124246-1-qm2k21@gmail.com>
 <20261012210917.161343-1-qm2k21@gmail.com>
 <20261012210917.161343-3-qm2k21@gmail.com>
 <e5ff5f2b-de4c-48a7-bc0d-3a7392bb6e1a@yandex.ru>
 <0309fc87-3912-41b1-8b38-7aa581bf07e3@gmail.com>
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
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, 24 Oct 2026 15:10:13 +0100
Marat Khalili <qm2k21@gmail.com> wrote:

> On 19/10/2026 22:10, Konstantin Ananyev wrote:
> >> Document the data plane limitation in the file docstring of
> >> rte_bpf_ethdev.h: packet callback execution expects only one
> >> thread per port/queue pair at a time, making concurrent bursts
> >> (such as with RTE_ETH_TX_OFFLOAD_MT_LOCKFREE, shared RX queues,
> >> or multi-threaded software PMDs) unsupported.  
> > Not sure what do you mean by:
> > 'shared RX queues' and 'multi-threaded software PMDs'. Can you 
> > probably clarify?  
> 
> I mean any hypothetical solutions that call rx/tx burst concurrently 
> from multiple threads or processes. To avoid confusion, will just leave 
> only an RTE_ETH_TX_OFFLOAD_MT_LOCKFREE example in the next version.

Other than TX lockfree DPDK is not safe to use rx/tx burst from
multiple threads on the same queue. The queue either needs to be
bound to a thread, or locking in the application. Many drivers
would break if Rx was called concurrently on multiple threads.
This design is intentional and one of the reasons DPDK is fast.
