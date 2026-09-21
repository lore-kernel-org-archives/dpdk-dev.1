Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B45C982EE
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 15:54:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 95B05427DD;
	Mon, 21 Sep 2026 17:54:41 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id 4BA4A402B0
 for <dev@dpdk.org>; Mon, 21 Sep 2026 17:54:40 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-39b910bdf2eso2158880a91.2
 for <dev@dpdk.org>; Mon, 21 Sep 2026 08:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790006079;
 x=1790610879; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XS7dT+yBNuxg2pTQVeqFAv9Y6rXYcCdF9+4y5gHZEl4=;
 b=kTYbZ7b7QPyzamuK1KCDmIsES8zsAT/WRE4O5R9LsaflYQR1f99+1hyOdr2X9JPnut
 a4gEleiDyQqvplWKi3tGsLaYXRpA5AiFlWcv0TOFGZVGoJHiJhPKbuGKpca6LMJCgRCf
 IksQTVPnrhSylzxn7hnRHJPMDn877URviQ3BqbTQ3aaKnG1lq+DhNJVEafRenBRqWnme
 Bz/LGPJIf9xbdMwy0VUSzpywb532Buv1upANSCvRVhrQk1Vlc5UX5q7/VutGdhBsiIGw
 Hbhnnr/ffYs/FiqJK63h8lv0xMNXyYh52xD9OqVsmD/+pKgeawD2rtNrAdLlnxi1aBhs
 +6mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790006079; x=1790610879;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XS7dT+yBNuxg2pTQVeqFAv9Y6rXYcCdF9+4y5gHZEl4=;
 b=cL2VXrzdgkAsFJTergoZVdnHuhA9Okl3CuDv4ZctkfNjsmmvdclNdTBJehA/Nfcp3F
 vp/c6HtfjuWWCVMUEpSDVnp8y1ZwKANInEAxIid05rpXcBbvFrRI/ktYt83TfHXt5iqu
 3b+og2Lwk5slB+Gnpi1RwsYFvn867lEI+mTBCp1e2rHt6OzSIX7ojwBKqonudGFfWSk6
 h64IxuXaAbkHhz8GxW6DccbK+puL6ynv0tmGxyRu1J+qK4jMYTMoapx678hXkCdnz5gZ
 EU6ZV1eCn8Mvf2W5sLbswk7A4GlUHCNiE2Ix13yqPLcyTbzbqnxN9QyjDL1hKOi1f3S5
 WFeQ==
X-Gm-Message-State: AFuF++n2Vn95DbZOiaq/lAk6HCaAF4cYQ8eH8TfSaCjEfXmrpQ7BlV17
 iSxl+Uk8SvJEaFabYK0EHhf3I8Xqd9gwqMDK0ii4ctyGqvDJFCB5FPlcy5gt0F3+YBg=
X-Gm-Gg: AYBFou0u67cnTVkVLSIwGKDAm75UxKiynFFn7QcqzRSGLLYyR/JFXGeBFWi2LbEGK4t
 w/z9tUDyZTTu2e7oNOUqhfIsr8lXSKUEAsXN1n0zcCzYHV+RA9iIfzGyIQnyMBiMAuwUg8MBNch
 rBVL87RFWi9dEnaprAzq/DTxWRQXn04KSQ9BpRIES88GzpsHBNANZkrYvvdlLs8O4yO6zyppaYA
 RNo/ixc+uNWQGGxMJ2JJIZ7haidAATUN7xsuLnE/7A5uZ+9aGgswG2k5P9uPx8EtvMU5VJK01VJ
 Ph2PYebcjHmKswvHEiBej6kObWWlGQsl4bB1O2lP9S6dQWPkcrKPEmXjOsJ/BRKkCcgM4cnzBtz
 3++yLtlN+4CdBftk6p2JftgsL4fnnizTh1Yz6jT634O2D84IOa8Hrluqqj2NWH0p/cqloDPu90m
 TDpePF6UGNkfwbCa83fptBWdXIa731I6NX5KzylcAKOd+Zk+1+n1TtmRgZqlCcMVTmfXWj8yAXb
 GhS2f0HfRyqQXupvmFtKQmA2zMsRujWt8tnGI93
X-Received: by 2002:a17:90b:3f4e:b0:39e:6a80:dda0 with SMTP id
 98e67ed59e1d1-39e6a810c46mr10555138a91.39.1790006079254; 
 Mon, 21 Sep 2026 08:54:39 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a063c1994esm735465a91.17.2026.09.21.08.54.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 08:54:38 -0700 (PDT)
Date: Mon, 21 Sep 2026 08:49:57 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Cc: dev@dpdk.org, kishore.padmanabha@broadcom.com, Keegan Freyhof
 <keegan.freyhof@broadcom.com>, Mohammad Shuab Siddique
 <shuab.siddique@broadcom.com>
Subject: Re: [PATCH v2 3/5] net/bnxt: harden sprintf bounds for device
 memory names
Message-ID: <20260921084957.3cb42f6f@phoenix.local>
In-Reply-To: <20260921022420.1034071-4-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260918032752.763408-1-Mohammad-Shuab.Siddique@broadcom.com>
 <20260921022420.1034071-1-Mohammad-Shuab.Siddique@broadcom.com>
 <20260921022420.1034071-4-Mohammad-Shuab.Siddique@broadcom.com>
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

On Sun, 20 Sep 2026 20:24:18 -0600
Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com> wrote:

> From: Keegan Freyhof <keegan.freyhof@broadcom.com>
> 
> sprintf() into fixed-size stack buffers such as
> char type[RTE_MEMZONE_NAMESIZE] does not bound the write to the
> buffer, so a long enough formatted string (e.g. from PCI address
> fields) overflows it.
> 
> Add check_snprintf_rc(), a helper that logs and returns an error on a
> failed snprintf() call and logs (without failing) a truncated one.
> Convert sprintf() calls building a memzone/malloc name to snprintf()
> plus this check, and add the same check to the existing snprintf()
> calls building HWRM CFA pair_name request fields. Unlike a truncated
> memzone/malloc label, a truncated pair_name would be sent to firmware
> and could match the wrong pair or none at all, so
> bnxt_hwrm_cfa_pair_exists()/_alloc()/_free() additionally reject a
> truncated pair_name outright instead of proceeding.
> 
> Three bugs introduced by this change and fixed here: in
> bnxt_hwrm_ver_get(), free bp->hwrm_short_cmd_req_addr (and null it)
> before checking the new snprintf's return, instead of after, so an
> early return on a snprintf failure doesn't leak the previous
> allocation; also clear BNXT_FLAG_SHORT_CMD on that same early return,
> since it may already have been set a few lines above and would
> otherwise claim short-command support with no buffer allocated. In
> bnxt_hwrm_cfa_pair_exists()/_alloc()/_free(), the new early-return
> paths exited without releasing bp->hwrm_lock (held since the
> preceding HWRM_PREP()), which would deadlock every later HWRM call;
> added the missing HWRM_UNLOCK() before each return.
> 
> Signed-off-by: Keegan Freyhof <keegan.freyhof@broadcom.com>
> Signed-off-by: Mohammad Shuab Siddique <shuab.siddique@broadcom.com>
> 
> ---


[PATCH v2 3/5] net/bnxt: harden sprintf bounds for device memory
names

Error: does not apply to main (see summary).

Warning: the rc < 0 branch of check_snprintf_rc() is unreachable.
snprintf() only fails on encoding errors, which cannot happen with
these formats. Every converted name except pair_name is an
rte_malloc()/rte_zmalloc_socket() type label. That label is
informational only, so truncation is harmless.

The only real overflow is a PCI domain above 0xffff with
"bnxt_hwrm_short_": 16 + 8 + 8 = 32 chars plus NUL into 32 bytes.
Plain snprintf() fixes that. Drop the helper and the early-return
paths, including the flag clearing and unlock handling added for
unreachable code.

For pair_name, rejecting truncation is reasonable. A single
"if (snprintf(...) >= sizeof(req.pair_name))" with HWRM_UNLOCK()
covers it.

Warning: the commit body carries review history ("Three bugs
introduced by this change and fixed here..."). Move it below ---.

Info: the flow xstat names can be written with snprintf() directly
into xstats_names[count].name, dropping buf and strlcpy(). "_%d_%d"
cannot exceed 32 bytes, so it needs no check.

Info: if the PCI domain overflow is the motivation, add Fixes: and
Cc: stable@dpdk.org.
