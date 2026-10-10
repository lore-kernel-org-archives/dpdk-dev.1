Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDB6CA9EC0
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 18:32:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 497684067B;
	Sat, 10 Oct 2026 20:32:24 +0200 (CEST)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTP id BA6214069F
 for <dev@dpdk.org>; Sat, 10 Oct 2026 20:32:22 +0200 (CEST)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2e618db81c0so5765445ad.2
 for <dev@dpdk.org>; Sat, 10 Oct 2026 11:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791657142;
 x=1792261942; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=R0if8MGX6wTOGlTVNNEGfyUNOOCG5MVV3eBoDtKNpdo=;
 b=Loy5Rvmiu9hRP3bIFTiVRVUmxxBm9NwZdRgi2s0oo/4Wu4wmWq/YY4STtuLFpXDP8Y
 pGKfS8wATP52P3JZhr2xGFihbep2/atI/ruOhVIEzCOInUbOeUp1XMmuzADuanKdelrA
 8f5HPb6ASqtlOaTAd7HzBIPbWFDdG4hyGO1BcGIL3rz6IxLveYasMMrXI4kzehyq1EsZ
 c8hd/wKltsi7HTzcIeiwyNtspfFYIM+DeMw4A/qqacplLvS4oxfqDEgXE9RGDbYU/7JJ
 6N1wdjxgJPLzGSiy3qYA0FYsjQlFJS+Y2Ekt9OSLm+d3PNtfwyF3A3PPWTuSQAXChq4J
 AXIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791657142; x=1792261942;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=R0if8MGX6wTOGlTVNNEGfyUNOOCG5MVV3eBoDtKNpdo=;
 b=AvgU14UaOxdbb08vtIwSWpFu0dmjzCZBXWJcJDz+wsb/3UAk/Mk6mbjkMGo2W7tPh4
 SiHWfIUMfZrjq1j/8P2lUEACMSzc+4yq0fGizX5vCBQ6SwvjOBSk48JIusbfyH1WiW8a
 uPAYOB+P2zJOwr5OSViBHLPQD5uaYOekAigKMFrQqSda/nrWcejkHy5AomKbYLEC/c4r
 1ZmwaYZfpPTaVeZDOoSSOqAqB3bmAHXqYm18VB6fYvP8tYcFALiuET2f5NrrIZPASXxr
 a4OK9frefiAW++L1sKb2OmtXViBGYcRdZ70kJ93bYyWh7bnTp503Jt5cabbohTp004MQ
 7wow==
X-Gm-Message-State: AFq9FYJ3PJRJiYAgf0D/UjG9iyBmRhvmmn4btTCsqKRgwCqic9RRwEU7
 Len8UIsMb/QPSdpWDduwE/m/GLm95RZJvmfQr0AkTyz3yfz/KvpVY4NmxMFBR+VTBY0=
X-Gm-Gg: AYBFou2SkGttp8C3EBRNyCjwoJ5sPPB75s0Q5VsSiTiw09gREJyHJF4Cg+rqb+xIXfN
 EY6V0GGDkEoBXLrZfuIh2Wfyjz72pSvh1MrUtNnbXw1DcQfC68RtO87TYIAZGDxvMhiQ5vBIxCW
 EXHK2JNZQ/P313ga+6vEYts/evIKcIirBCZhb9HmJWhm0fDTZ63X78YsGI8kPo8BOld7w02N80C
 bVRAtKR1+lMRH4RYYDOWeOacqc/BNEMY6KFoRt8spZJ5FXsSysZHo/nHf671vyC0GvRwgV2fnyC
 Oc7idhekb1VaO4u7eJswC8zJQn5I/gzDNHlHKAFE64d7IeqZhRUvNj4Y+5qAUWoBJ5hSuBmup6c
 DECIHLjRhthL2qv/KT5AD88AHNdrTjWZ4QBaLZ7y7geu9wqB7lYDdI5VL4N3m2epKIElRD/Qkz9
 SGAiEBvdy7HWbM8vTnKrn4GqQeH6iA6ekgm0szoAEcoWTRvZMPMjPWFk+5lNtLBNtRQnpJQlFXP
 /Rl325IsaEW7OGwq8y+tbBZlCQ8aSsTbN6votAZ
X-Received: by 2002:a17:902:ea05:b0:2e8:3a21:cb57 with SMTP id
 d9443c01a7336-2e842cd4478mr50326705ad.19.1791657141813; 
 Sat, 10 Oct 2026 11:32:21 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8419ff572sm24651035ad.2.2026.10.10.11.32.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 11:32:21 -0700 (PDT)
Date: Sat, 10 Oct 2026 11:24:23 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Joshua Washington <joshwash@google.com>
Cc: dev@dpdk.org, blasko@google.com, jtranoleary@google.com
Subject: Re: [PATCH v3 0/8] gve: precursor control plane changes before
 bare-metal support
Message-ID: <20261010112423.3b257960@phoenix.local>
In-Reply-To: <20261010005942.560881-1-joshwash@google.com>
References: <20261005193943.1175072-1-joshwash@google.com>
 <20261010005942.560881-1-joshwash@google.com>
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

On Fri,  9 Oct 2026 17:59:32 -0700
Joshua Washington <joshwash@google.com> wrote:

> This patch series includes a number of precursor changes to the GVE
> ethdev driver layer in preparation for introducing support for a new
> GVE Mailbox control plane (an alternative to the existing AdminQ control
> plane).
> 
> The most major change in this series is the introduction of a new
> control_ops struct that will be used by both AQ and Mailbox for various
> operations which may need to communicate with the device. There are also
> some changes to how RSS and timestamping are handled in ethdev due to
> slight feature differences between the control planes.

Applied to next-net. I fixed the commit messages based on AI review
for patch 6 and 8. The last one is not really needed.

Subject: Re: [PATCH v3 0/8] net/gve control ops rework

Applies cleanly to main; every commit builds with -Dwerror=true.

v3 addresses the v2 errors and warnings. The remaining items are
commit message wording; fix them if there is a v4, otherwise they can
be adjusted on apply.

Info

[PATCH v3 6/8] net/gve: update RSS config just after successful
programming

1. Body starts with "Moving this" with no antecedent. Say what moves:
   "Move gve_update_priv_rss_config() into gve_adminq_configure_rss()
   so the cache is only updated after the device accepts the config."

[PATCH v3 7/8] net/gve: add RSS cache boolean flag

2. The commit message says the cache is invalidated when a configure
   message is sent if queries are supported. No code does that; the
   only place rss_cache_dirty is set true is gve_init_priv(). Describe
   it as a requirement on the query backend. When that backend lands,
   note that gve_dev_configure() returns 0 without regenerating the
   RETA if the query fails with indir set.

[PATCH v3 8/8] net/gve: refactor timestamp support to clock read type

3. On GQI, rte_eth_read_clock() now returns -EOPNOTSUPP; before this
   patch it worked whenever the device offered the timestamp option.
   Mention it alongside the memzone and thread note.

Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
