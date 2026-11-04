Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96541606A328
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Nov 2026 07:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=H1AW/KMq
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 03B85402D4;
	Wed,  4 Nov 2026 08:33:37 +0100 (CET)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com
 [209.85.208.47])
 by mails.dpdk.org (Postfix) with ESMTPS id CD7EB4026E
 for <dev@dpdk.org>; Wed,  4 Nov 2026 08:33:35 +0100 (CET)
Received: by mail-ed1-f47.google.com with SMTP id
 4fb4d7f45d1cf-6b486e1d02eso379042a12.2
 for <dev@dpdk.org>; Tue, 03 Nov 2026 23:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1793777615;
 x=1794382415; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qcWm2RUkNkHfwX4n+3/UpzkQteUxJNqJoebgSec1VAE=;
 b=H1AW/KMq4n2UAYyHbAW+UEB/Msv7P4XKaQwqHnEOpPRGIkZbh4Owy2025l0Qsv96BO
 ibjmXE1mxHOvFmwBo2rr/heN1gYhugMj6TnQY2LJ+5HTsipcvPOCN9Ccc8FhrKFbKHVj
 nCBUE08N9be+n4cNk9G1NdGFH6aazIL/fJrEpfCL1BEBmXF92ioT3uJLnYm7+rYiIeiT
 WVZ4NsPy4wRIm81gbSktcDJ/tWil2hs6PqPX7epFuHeMZEEf3AXHR81ZO4WVea/CzclM
 r9ahRDHqeFSXQmHPKPgTXrsYMFLMaSyJK2dQy8yI3WV/tbkmHqtDAZRrHiAYM8zG5WjP
 Disg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793777615; x=1794382415;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qcWm2RUkNkHfwX4n+3/UpzkQteUxJNqJoebgSec1VAE=;
 b=nEQOzVUVpNd142Vogdk3MkmsFvffnZJXFk7drqNwPp/xT49+/UbH7NxFldHltF4U2b
 /pZBiZlJSm6WmiuXkdR8h+mB3VnwyAbWNkFl/HZwXk3Y+N9B4Wm7jBkT8EqfFfz181Tq
 hzsh9qlNHuiwJmM3walUm7Yt6n10nfMSECZ5LHCSZgg5Gecy7diErmvsfGBki153n0bc
 NGpdTGKt6K3wguhzVQ+25USE0pJY/n1VVpaHAXQLhBK9e0OAy6mciKK7MPbNckkZBDRf
 h0RPcD/9dX7NjbFHxAMUJC62ug+dCgBx4Wx+cvvPKJdTOizqrSILUbEAzHsEB1EADkVG
 zE2Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBy/oNvZk1b6gDRT4xKR5dOtMQxTeeCeZ6tj4X01czfP/zQsm4T+Ner64cNj5WvdsjPVZNk=@dpdk.org
X-Gm-Message-State: APuU4Z/gZpwDWlOB3DBVDHpqQUHWahg/fBpPfmK7Q2AtkArW7eV7clAA
 eD9fo04HuS82bthj2LyF42TLZt47/2NJ/kv8qBkEF6Lon0QZw+ZKD8I44+tQh+IOmmE=
X-Gm-Gg: AYBFou3HMHi69P1VHW7XpugmJqw/aT7zLH3ni0t3nMfFssDwDiLBSJzIuPv+4NobyV4
 klaf6RM5dKf6lySjkV04am/FPoSJptXv9c9AojOKFIcfchqn2t8nuqkhipKo1DCjV38QJOJLlVc
 BnZUTpIBjg5g3gqbQ6b2A+Psg44sqBefs4hEkJdyJCT8YeUgr3PN2dgu72+LCd5MpM7BurLkCa7
 rhYFFXIm8taVqXDdHYrGVoqSRpkJ9xxyz5I7IDpuamfSwIfM4bnz7lLRyj73pY97KrzaDg375z9
 /P3+NoBfZWWCG3LsDzJrMOVqtcxo0Nb+I1lTct7pwBzXTfdcrQXXOnGAcj3zC7EJOESwuRVKcrQ
 arvpkfwmHfRMWDXsva9E4X/9/YLhXDxsZF3itxoKyAEQbK1HxnG5EMjdkDM8zL0zQbDm7s8R6Fw
 +7uypjZvEKgLaIaJhQGP5L0UwvC1SdYplAgpwr60cRloGBAHWH7QI+HVTPSHZReXDbfx07AH6W5
 Bcmwq8GIo+XBU+D0Zp+UnpueBFioBPoQPWYwsw21K1rMBdAWKWZR9n4WNVoDLrzd+qj3Z/f9cLb
 tr6f5QvpwOq+X+60cbU/PkETgwLiSOorRkttfiIrp/41t5Q8Otv4TrakOtp0C4g6/AuuC9ofFKT
 RoT2irdzLftFP/fU=
X-Received: by 2002:a17:907:d92:b0:c2e:5efe:f1cb with SMTP id
 a640c23a62f3a-c4ca7a4bb1cmr1339068266b.8.1793777615270; 
 Tue, 03 Nov 2026 23:33:35 -0800 (PST)
Received: from stephen-xps.local (93.224-78-194.adsl-static.isp.belgacom.be.
 [194.78.224.93]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d0e43f586sm41499766b.35.2026.11.03.23.33.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 23:33:34 -0800 (PST)
Date: Wed, 4 Nov 2026 08:33:32 +0100
From: Stephen Hemminger <stephen@networkplumber.org>
To: Chengwen Feng <chengwen.feng@linux.dev>
Cc: thomas@monjalon.net, konstantin.v.ananyev@yandex.ru, dev@dpdk.org,
 Chengwen Feng <fengchengwen@huawei.com>
Subject: Re: [PATCH 001/227] eal: add NUMA-aware APIs
Message-ID: <20261104083332.54b44fd0@stephen-xps.local>
In-Reply-To: <20261103145306.487255-2-chengwen.feng@linux.dev>
References: <20261103145306.487255-1-chengwen.feng@linux.dev>
 <20261103145306.487255-2-chengwen.feng@linux.dev>
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

On Tue,  3 Nov 2026 22:49:19 +0800
Chengwen Feng <chengwen.feng@linux.dev> wrote:

> From: Chengwen Feng <fengchengwen@huawei.com>
> 
> DPDK has long used socket_id terminology for NUMA allocation,
> which conflates CPU sockets with NUMA memory nodes.
> 
> Add NUMA-named APIs while keeping the legacy socket-named ones
> as functional aliases (to be deprecated once the in-tree
> migration completes):
> 
> - rte_numa_id(), rte_numa_count(), rte_numa_id_by_idx()
> - rte_lcore_to_numa_id()
> - rte_cpu_numa_id() (renamed from experimental rte_cpu_socket_id())
> - rte_malloc_numa(), rte_zmalloc_numa(), rte_calloc_numa(),
>   rte_realloc_numa()
> - rte_malloc_get_numa_stats() and struct rte_malloc_numa_stats
> - rte_malloc_heap_get_numa_id(), rte_malloc_heap_numa_is_external()
> - RTE_NUMA_ID_ANY constant (legacy SOCKET_ID_ANY kept as alias)
> 
> Convert EAL internals, comments, log messages and telemetry keys
> to the NUMA node terminology, and update the EAL programmer guide
> accordingly.
> 
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>

Getting rid of socket as terminology looks like a good thing.
One important step would to make sure DPDK usage matches other libraries
like libnuma.  It would be good to avoid NIH as much as possible
