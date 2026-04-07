Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA7DFEEF59
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 15:02:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D048340265;
	Tue,  7 Apr 2026 17:02:56 +0200 (CEST)
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169]) by mails.dpdk.org (Postfix) with ESMTP id 7A6614025F
 for <dev@dpdk.org>; Tue,  7 Apr 2026 17:02:55 +0200 (CEST)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-2ba895adfeaso5546605eec.0
 for <dev@dpdk.org>; Tue, 07 Apr 2026 08:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775574174;
 x=1776178974; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hXbFWTsUzwtog0Hkk6XsH7i4ZztI0wnftuTE2ZsfT7c=;
 b=Ai6cB9eFanDfHsBENAyTADvBjCC5m/3Z8ZDVaIfKmD6NVMqI+VLLoToJAEByj9V6nR
 gVk3wDlAy3M1feq5KWYrq2ib2awWvAFFxEw+EmeArD61EYmCXABY+IkuWIylq+j8K+dC
 EhiXWxokPdMqw7YG1EDggYpr3kNw+XsUXWOgg0y7LH2vSj4OzA3/Mt/3uPurkX7JnTuO
 P0cT7Z+SjXuJ1Qzg2H0GZIsbTAI9HCXVZT1cR6Xh7Ekb0wAtvaYKiaENmKaHs7x0adOP
 q/qhY31zgXBm+uc3rKK12Nunwo5RI3Y1uonjThK0/6ejNgZvMLV1pwpIDfZNNbZ4lxTC
 iLXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775574174; x=1776178974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hXbFWTsUzwtog0Hkk6XsH7i4ZztI0wnftuTE2ZsfT7c=;
 b=XF1Ak8UmjDm7Z5rmtip5RXJnDfncGx1LenZR2Jb7aezCYI/CfSOoIT1D5Fvty1IJzE
 NpQ7YL/Px+BA0KbByYSF/fx4Hz6FqMCVIJ3sb0hd+Q0SHhWIZYgr7agZ5q5QmqK2+5QB
 ydU423KhI4931+VgNrHggXKQDRc5dLVtj/ubZJjMAN4rgNieDaX5ms24JjERFD/pd2pB
 ImwAPDYGbYDhE8NJRwq7VeAcCmvsVmBaDpDN4Fel0Wx6F7lfZW+bY3taGlzFa8nOjiz2
 VFZ5TItvPq4iJGnMXGpAOUW52V8d3Swr/cENkyqSnwlzZYsq9vk9LEi4QKjx+SfZ+NGV
 Opsg==
X-Gm-Message-State: AOJu0Yw8ZD6FkvHPwPG1LoYE8Wj34kPI36SP8Ose9gWDVNiAf2IFwMU5
 27TYOC8cERIagJpfd+D19CJ15vo9R8JEmWh25iLONvR1qWQYYWkK8L2R3/g3/XZOuOw=
X-Gm-Gg: AeBDiesRAfYvsHIaacCMBfwV9daSV/3UMhOLcaQYPUD6TcPRPw5TmXuvYtgYrXyy0yL
 WsjUJwlXHaWLGWGhLFW2gCisD3MeQxC+ckMOiShaNQlp3XmthE+ttU5EqboKjY4TGhFa1DCrmrt
 TizVc80IN4QGyl62U/pXjrtL/1+cWZQdApCW19bYKeb6wfzW6JjyKR1TLdf3CnuJO1GpLPq/+qr
 1qG6CLiFMlZHW21Ik0MgGhRdNC20JJOlKqyqAsXCi2iKMULbIgX5VeCStC1F40gQ/fKvpDj/5Lk
 0BnRx9cChrn/7y7X4j9JEcmCQXJADreZUtEu715NLwErMQKQzOx9I9A4Yu5oMcfnaN48Pi8GJDN
 MUTr8t7EqnADvrhTJDZLQaD5d1v8wf5T8HebdzSBClee+0JgJyExQd7rTjUGbONqO6ynQlpChnA
 KikcASnv6a2qCameIIp0uFYteROKwIaezWvNo=
X-Received: by 2002:a05:7300:bc0c:b0:2c0:c767:b65 with SMTP id
 5a478bee46e88-2cbfa4c470fmr8818789eec.15.1775574173429; 
 Tue, 07 Apr 2026 08:02:53 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2cee97ff4e8sm8322271eec.25.2026.04.07.08.02.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 08:02:52 -0700 (PDT)
Date: Tue, 7 Apr 2026 07:21:18 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: <pravin.bathija@dell.com>
Cc: <dev@dpdk.org>, <thomas@monjalon.net>, <maxime.coquelin@redhat.com>,
 <fengchengwen@huawei.com>
Subject: Re: [PATCH v9 0/5] Support add/remove memory region and get-max-slots
Message-ID: <20260407072118.341cdd6e@phoenix.local>
In-Reply-To: <20260407080636.3878354-1-pravin.bathija@dell.com>
References: <20260407080636.3878354-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Tue, 7 Apr 2026 08:06:31 +0000
<pravin.bathija@dell.com> wrote:

> From: Pravin M Bathija <pravin.bathija@dell.com>
>=20
> This is version v9 of the patchset and it incorporates the
> recommendations made by Stephen Hemminger.
>=20
> Changes made to patch 3/5
> - Restored max_guest_pages initial value to hardcoded 8 instead of
>   VHOST_MEMORY_MAX_NREGIONS, matching upstream semantics.
>=20
> Changes made to patch 4/5
> - Added close(reg->fd) and reg->fd =3D -1 before goto close_msg_fds in the
>   mmap failure path to fix fd leak after fd was moved from ctx->fds[0].
> - Converted dev_invalidate_vrings from a plain function to a macro +
>   implementation function pair, accepting message ID as a parameter so
>   the static_assert reports the correct handler at each call site.
> - Updated dev_invalidate_vrings call in add_mem_reg to pass
>   VHOST_USER_ADD_MEM_REG as message ID.
> - Updated dev_invalidate_vrings call in rem_mem_reg to pass
>   VHOST_USER_ADD_MEM_REG as message ID.
>=20
> This implementation has been extensively tested by doing Read/Write I/O
> from multiple instances of fio + libblkio (front-end) talking to
> spdk/dpdk (back-end) based drives. Tested with qemu front-end talking to
> dpdk testpmd (back-end) performing add/removal of memory regions. Also
> tested post-copy live migration after doing add_memory_region.
>=20
> Version Log:
> Version v9 (Current version): Incorporate code review suggestions from
> Stephen Hemminger as described above.
> Version v8:  Incorporate code review suggestions from Stephen Hemminger.
> rewrite async_dma_map_region function to iterate guest pages by host
> address range matching
> change function dev_invalidate_vrings to accept a double pointer to
> propagate pointer updates
> new function remove_guest_pages was added
> add_mem_reg error path was narrowed to only clean up the single failed
> region instead of destroting all existing regions
> Version v7: Incorporate code review suggestions from Maxime Coquelin.
> Add debug messages to vhost_postcopy_register function.
> Version v6: Added the enablement of this feature as a final patch in
> this patch-set and other code optimizations as suggested by Maxime
> Coquelin.
> Version v5: removed the patch that increased the number of memory regions
> from 8 to 128. This will be submitted as a separate feature at a later
> point after incorporating additional optimizations. Also includes code
> optimizations as suggested by Feng Cheng Wen.
> Version v4: code optimizations as suggested by Feng Cheng Wen.
> Version v3: code optimizations as suggested by Maxime Coquelin
> and Thomas Monjalon.
> Version v2: code optimizations as suggested by Maxime Coquelin.
> Version v1: Initial patch set.
>=20
> Pravin M Bathija (5):
>   vhost: add user to mailmap and define to vhost hdr
>   vhost_user: header defines for add/rem mem region
>   vhost_user: support function defines for back-end
>   vhost_user: Function defs for add/rem mem regions
>   vhost_user: enable configure memory slots
>=20
>  .mailmap               |   1 +
>  lib/vhost/rte_vhost.h  |   4 +
>  lib/vhost/vhost_user.c | 403 ++++++++++++++++++++++++++++++++++++-----
>  lib/vhost/vhost_user.h |  10 +
>  4 files changed, 375 insertions(+), 43 deletions(-)
>=20

AI review is mostly clean now.

Patch series looks good overall. One issue in 4/5:
In rem_mem_reg, dev_invalidate_vrings (which calls
translate_ring_addresses) runs while the region being removed is still
mapped. Any vring address that resolves into that region will get a
pointer that becomes invalid after the subsequent
free_mem_region/munmap. Consider freeing the region first so translate
only sees surviving regions.

Also minor: the v9 cover letter changelog says rem_mem_reg passes
VHOST_USER_ADD_MEM_REG but the code correctly uses
VHOST_USER_REM_MEM_REG =E2=80=94 just a typo in the changelog.
