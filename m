Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24DEC79F82
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 17:18:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D437D402D8;
	Tue,  8 Sep 2026 19:18:24 +0200 (CEST)
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12]) by mails.dpdk.org (Postfix) with ESMTP id 9985C4028D
 for <dev@dpdk.org>; Tue,  8 Sep 2026 19:18:22 +0200 (CEST)
Received: by mail-pz2-f12.google.com with SMTP id
 41be03b00d2f7-cc1cebad4acso139255a12.3
 for <dev@dpdk.org>; Tue, 08 Sep 2026 10:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788887901;
 x=1789492701; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6qHCewcBSOKzxh/LYsS0lRy6p8wUeJly1uLhtuHRkIc=;
 b=pLOXAUzINbR4u7VSYZojnULNnwB023o2HzGrxJyqYHV41prMz/qIn0ynOnq1s5+z+P
 1GkkE0A3WUOFUX2H0oSwXSdpYItVLIO4kNsdcrE5AfOKEf99vsWqMrqHKv3VTfnSTQ1H
 +jFQZeNC0M7FFFPpZvL0MRXIzfo0TDmNuR+Owj5k/2GpljroSCErIVAUpGtBgbKVRZT5
 BHVO6rlFGG4nHQCdlcOQMRENRYQfcL5CwgARZ7fpuymnKwRlkAeu7FkDUobR9aHBuimT
 OXflGlXwfgRIPDSZYkNBLgCXbyIezQeOW24F9Rmja8eDTsp8fsw9nfDYcXeV4i6HwYc3
 ouuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788887901; x=1789492701;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6qHCewcBSOKzxh/LYsS0lRy6p8wUeJly1uLhtuHRkIc=;
 b=jt9/UUg5jOox9RAz/ptD3cMJkDyi4Uv5BnWjqcODRnjdZ3Vaohf8tlwEc9Z8hUR6YU
 uBJu1atk13+aU6wJSC+AVD+nm23gecrW/2FWuOuEi/VVZ/1TXqx/yOd7Zhznsa6Wokk0
 sThzcNe72S+vfaWtqbXAf4lR+utEzVJV3p17zxn3RFH21fGraS+E2dNzUipcRm+241wK
 1mFJRQNLnQVjTItaJBTtXjacOku8OyVyu/v/UlFIV5JGlBqapdtAQJZowfuZZc/eD/G7
 ulMCnfycdmfIgVdWm3xPVOrHpzntAZksHUFGL+CYfUrAoumaLq/vtZb4VJ40NmbWF+H0
 jFBQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzcso4vcnGBRBLRlKYaM3OMKKNIZaUIlSmn6Mmi5RdBgibNIzEjhVKZbiXjIYSTR+ipkoc=@dpdk.org
X-Gm-Message-State: AFuF++lTVaOXbN/mfUSuE17Veycm46QzjSBWU+0Vc9VSP4XMSMan1DEy
 4a568r1uL/St1wHW4UYE86ZT+LYSuyV4M7teDlmj304u8CFlB8ymMrefpCt7tjCvfd9uRWdbaAA
 LmiHn
X-Gm-Gg: AYBFou28ZmfwSLAXti9qtudg2NS92teeX7p5eXJpi5w5G+kNJT/ZIYEgLabXRUbl780
 U6d9W+fIqFkfA7AidubBBaGLJ3zTXbjh7d+hdIU+saG263eQRXrj8IUrCM9uR1/mtvxH8xY8i6k
 /ROALrtLsBqRpR95mwfDBCPvU0L0vfNhU9t0SZo8X4wJbGNVv4yodY28jCjTnIAjjOwLHjtzUzb
 B39Q2K6RuWwXFctIVfXhb9ECqa7V6bbdQRginhq1xeQrYFkUQIrWcVTlBmhTV+/E3ZAI5tyhPMu
 zQQQl5e0YKlabIb1rWClwgafbv/Pgy97PEitc7T3n9SdfUXAt78A+WPaa09Fo6OWBvyyA2qyjBU
 IA1sbF6L6RcPyGFT25U844qnnCB/hJoxeVUHo/yuyZ6J5GGq9KI/ac7icrmKOH0arSHvriOgGQs
 oNzW9GAI/yrpIP9Zn84a6jjDWBFafCfN+zNGLVg3IziGyHetDC2h4af15KhDvmQoqypHEPRu+et
 OmkIRtZvOAz0/U7IY/aotBAk2klYQ==
X-Received: by 2002:a17:90b:5485:b0:396:b918:c2a with SMTP id
 98e67ed59e1d1-39bac34a3cemr1260640a91.12.1788887901433; 
 Tue, 08 Sep 2026 10:18:21 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b2612ba2bsm26722544a91.14.2026.09.08.10.18.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 10:18:21 -0700 (PDT)
Date: Tue, 8 Sep 2026 10:18:12 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Serhii Iliushyk <sil-plv@napatech.com>
Cc: mko-plv@napatech.com, ckm@napatech.com, dev@dpdk.org
Subject: Re: [PATCH v1 0/3]  net/ntnic: fix virt queue data in BSS
Message-ID: <20260908101812.4d6b9d71@phoenix.local>
In-Reply-To: <20260908162724.463767-1-sil-plv@napatech.com>
References: <20260908162724.463767-1-sil-plv@napatech.com>
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

On Tue,  8 Sep 2026 18:27:21 +0200
Serhii Iliushyk <sil-plv@napatech.com> wrote:

> This series addresses the bug report "ntnic: virt queue data in BSS"
> (Bugzilla ID: 1975). The report lists five problems with keeping the
> virt queue state in static arrays; each is addressed as follows.
> 
> - BSS memory is slower than hugepages because of TLB overhead, which
>   can cause performance loss in the hot path.
>   The per-queue state, and the copy of the packet buffer descriptors
>   indexed on every burst, are now allocated from the EAL heap.
> 
> - Hard coding the size wastes space.
>   The 128-entry Rx and Tx arrays are gone; one object is allocated
>   per configured queue and freed when the queue is released.
> 
> - Data in BSS is not visible to a secondary process.
>   The state now lives in EAL memory. The PMD still does not support
>   primary/secondary operation, but this no longer stands in the way.
> 
> - NUMA aware allocation was not possible.
>   Both allocations are made with rte_zmalloc_socket() on the NUMA
>   node of the adapter, next to the rings and buffers they describe.
> 
> - Cache alignment.
>   The queue object is cache line aligned and no longer shares a line
>   with a neighboring queue.
> 
> Patch 1 drops two never-called setup ops so that only the managed
> setup and release paths own the queue state. Patch 2 makes a failed
> hardware setup visible to the caller, which patch 3 relies on to free
> the queue object on failure. Patch 3 is the fix itself; it also fixes
> a leak of the descriptor copy on queue re-setup and an ignored
> allocation failure that led to a NULL dereference in the burst
> functions.
> 
> Serhii Iliushyk (3):
>   net/ntnic: remove unused unmanaged virt queue setup ops
>   net/ntnic: check virt queue hardware setup result
>   net/ntnic: fix virt queue data in BSS
> 
>  drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c | 334 +++++++++++-------
>  drivers/net/ntnic/ntnic_ethdev.c              |  52 ++-
>  drivers/net/ntnic/ntnic_mod_reg.h             |  30 --
>  3 files changed, 245 insertions(+), 171 deletions(-)
> 

Looks good, applied to next-net.
