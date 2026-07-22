Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84636C44536
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Jul 2026 23:08:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C4D7F40616;
	Thu, 23 Jul 2026 01:08:16 +0200 (CEST)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50]) by mails.dpdk.org (Postfix) with ESMTP id 77988402AD
 for <dev@dpdk.org>; Thu, 23 Jul 2026 01:08:15 +0200 (CEST)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-38e347638adso18754a91.0
 for <dev@dpdk.org>; Wed, 22 Jul 2026 16:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1784761694;
 x=1785366494; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3xNHBCHRvm6YNrXVKA1fbq7MRPcYzqvU8gI0MBJ5Jfk=;
 b=joPfx1nlP+TYeLi6w6PHMAcS10+gCCXtSPUfdLFxQ1xM6nxwmr7W/4OgzELLTl2w48
 ManyYIE0STr2Lbf+zI3oSsMRegwCeu1cMY8sSdLsACUl3KgSn2pvS3UDj7xprzlLY7lJ
 lmQKel/6b4W+NgtZ10uN5ePOcg5WIC0Q/kPOLtjU4PNrBO7AcIdYYExyUxOODVk6UYIR
 yGqhBuAW/96BxtsvQWuRaNpMSYvpL17+tfVH7YcCK4J/FLI3EeuVhcNeVWloppuzWKun
 OlApbGCUmDf9ePwoqPZOb22HghZgAV3dPFI+NXnjs7WOP0G0J8/wdfSvubNUHhSK1g/i
 p9zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784761694; x=1785366494;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3xNHBCHRvm6YNrXVKA1fbq7MRPcYzqvU8gI0MBJ5Jfk=;
 b=i6LnW9noQ8CV9ASdMUcXQ8Uw08xiaEYNyzc0sM0dw9LP8wbwjhZ0zhmlzwhxpCQo/P
 fhh6tLxmlsGfzoEsjtyNnRV0ACdYnjGmKrIETE/R/gRou/3deTJ0mhXEdGpFCyHYwiek
 42M10plOB8MeLBeo+ah6sqzm8RpRyDnys02YkukwMZVMnPfAokXfPjGD9xr3u/SIa1er
 u3OhW00+WgAXGx/Z9jddpS7teAmCOjtv6BW9NLtYYT8tAWUh0jA9MoRcvK+9dWB7aX8B
 C/zVPjNDG16FyQ9BXkyeno8kh/aHzXrgdFBUdPn8jy4JLGHhC+BuQQQCMWwIAtIF6PT/
 1/6A==
X-Forwarded-Encrypted: i=1;
 AHgh+RpkjUJ8wyPuQzyJoWlw1My19sn9y7P4T2fLNK2mzP6xwXoc5kRDehUDnNmqm2H6ZeoqjRE=@dpdk.org
X-Gm-Message-State: AOJu0YwEY20DqahKWHdLocxkXioHTPAy/gEOneo9Yythypij9kBdaFgo
 7HN3S7/N3hY+zmVYr7NUH7N65GOpNtPvbBghXl8YrISlnhqaXwjec/FlZPLLdE604iQ=
X-Gm-Gg: AR+sD12ALCi7ukOBOvG32uBXGT6BCbNXAvBse+jJ/Anlr2Q+V5NChM1G9PfE56PNVQT
 RcdVuAmZuifYB8EVgykdYAGi3QB2MYOX0P86nC7I1C2aNCkoklkYCYqysq/8YVHu5PqnarqBIpv
 +P/mexBZkam1+y++EdD2l+bpnp0TWHUoE/sxyOOdE4LMFr9vrNg8M61FQoPptgevRWEL+yx4ip3
 6Z7/lI6ncjrFb4585z5V4a9bRW4k8kkwT+RhJhWuAvn6fpf3bMTPaHuiz4Sw6lJQwO1XUk4tvOw
 ApfYI1q+YkkxvjwOFoZ+VQ6K9PPJ4mt9OSoTgoexIMpRuxsaUA+3NJsEL/VVe+YoxsPAA9E5Y+b
 3hvkKCs+X9pSBPLrgkm7OT3u/+N5VpIzoRPn9Irb/TU1y0Tkyaz+d7axWhVnqWSXYWMHFkTKAmI
 mfEgbra0n3x6eiVYJAJhfBVFjh4CM5PN/KdCmOFEVNbd0=
X-Received: by 2002:a05:6a21:a89:b0:3c0:b766:74f4 with SMTP id
 adf61e73a8af0-3c44b04cc2dmr573979637.31.1784761694209; 
 Wed, 22 Jul 2026 16:08:14 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147e1b6a45sm12280156eec.28.2026.07.22.16.08.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 16:08:13 -0700 (PDT)
Date: Wed, 22 Jul 2026 16:08:11 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Anton Vanda <avanda@ptsecurity.com>
Cc: Thomas Monjalon <thomas@monjalon.net>, Maxime Coquelin
 <maxime.coquelin@redhat.com>, Chenbo Xia <chenbox@nvidia.com>, Yuan Wang
 <yuanx.wang@intel.com>, Cheng Jiang <honest.jiang@foxmail.com>,
 <dev@dpdk.org>, <stable@dpdk.org>, <cheng1.jiang@intel.com>
Subject: Re: [PATCH] vhost: fix null dereference in async packed dequeue
Message-ID: <20260722160811.190a7b44@phoenix.local>
In-Reply-To: <20260707135044.7488-1-avanda@ptsecurity.com>
References: <20260707135044.7488-1-avanda@ptsecurity.com>
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

On Tue, 7 Jul 2026 16:50:44 +0300
Anton Vanda <avanda@ptsecurity.com> wrote:

> In the batch path of the asynchronous packed ring dequeue, the address
> of the virtio net header is obtained from vhost_iova_to_vva(), which
> returns 0 when a guest-provided descriptor address cannot be fully
> translated.  The batch check only validates that the descriptor address
> is non-zero and that the length is consistent. A malicious or buggy
> guest could therefore trigger a NULL pointer dereference and crash the
> vhost application (denial of service).
> 
> Check the translation result and leave the batch fast path with an error
> on failure, so the single-packet path handles the invalid descriptor, as
> is already done for the non-batch async dequeue path.
> 
> Perform the header translation before the DMA iovec setup so that the
> early return cannot leave the async iterator state partially updated.
> 
> Fixes: c2fa52bf1e5d ("vhost: add batch dequeue in async vhost packed ring")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Anton Vanda <avanda@ptsecurity.com>
> ---

Since vhost is so security sensitive asked for more detailed AI review (Claude Fable).
It found some issues that need addressing before merge.


Review: [PATCH] vhost: fix null dereference in async packed dequeue

Errors
------

1. The check is incomplete: a non-zero return from vhost_iova_to_vva()
   does not mean the header is fully mapped. The function shrinks *len
   to the contiguously mapped length and returns a valid VVA whenever
   the start address falls inside a region (rte_vhost_va_from_guest_pa
   caps *len at region end; the IOTLB path does the same per entry).
   A guest that places a descriptor in the last 1-9 bytes of a memory
   region gets desc_vva != 0 with lens[i] < sizeof(struct virtio_net_hdr),
   and *hdr then reads past the end of the region mmap -- the same
   guest-triggerable crash class this patch is closing.

   Compare the other two paths:
   - single-packet: copy_vnet_hdr_from_desc() assembles a header that
     spans mappings from buf_vec chunks (virtio_net.c:2922).
   - sync batch: virtio_dev_tx_batch_packed_check() rejects partial
     mappings via lens[i] != descs[...].len after translation.

   Suggested fix -- translate only the header and verify coverage:

	uint64_t hdr_len = sizeof(struct virtio_net_hdr);

	desc_vva = vhost_iova_to_vva(dev, vq, desc_addrs[i],
				&hdr_len, VHOST_ACCESS_RO);
	if (unlikely(!desc_vva ||
		     hdr_len < sizeof(struct virtio_net_hdr)))
		return -1;

   Using a local length also stops clobbering lens[i]. That is harmless
   today (lens[] is dead after this point in the function) but fragile
   against future reordering.

TOCTOU assessment (requested)
-----------------------------

No TOCTOU introduced by this patch:

- No re-reads of the descriptor ring: the translation uses the
  desc_addrs[]/lens[] snapshots taken in
  vhost_async_tx_batch_packed_check(); guest-shared memory is not
  consulted again for validation.
- The header is consumed via a single struct copy into
  pkts_info[slot_idx + i].nethdr; the completion path parses that
  snapshot, so concurrent guest writes to the header cannot produce
  inconsistent offload parsing. The store escapes to the heap, so the
  compiler cannot elide or delay the copy -- the rte_compiler_barrier()
  that desc_to_mbuf() needs for its stack-local tmp_hdr is not needed
  here.
- Moving the block before the iovec setup does not open a check/use
  window: the same snapshot address feeds both the header translation
  and gpa_to_first_hpa().
- The early return leaves no partial state: async->iter_idx and the
  iovec array are untouched, last_avail_idx and the shadow ring are not
  advanced, and the caller falls through to the single-packet path,
  whose desc_to_mbuf() rewrites nethdr for any lanes the failed batch
  already filled. The reordering rationale in the commit message is
  correct.

Info
----

1. Same function, same threat model, pre-existing: host_iova[i] from
   gpa_to_first_hpa() is never checked; on translation failure
   rte_dma_copy() is issued with source IOVA 0, and a short mapped_len[i]
   silently truncates the copy. Worth a follow-up patch in this series
   or after.

2. .mailmap uses C-locale ordering ("Anup Prabhu" before
   "Anupam Kapoor"), so "Anton Vanda" sorts before "Antonio Fischetti"
   -- the new entry belongs one line up, after "Anthony Harivel".

