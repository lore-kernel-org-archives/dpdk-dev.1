Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447A0C9832A
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 13:38:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7E71042708;
	Tue, 29 Sep 2026 15:38:22 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 9672040ED1
 for <dev@dpdk.org>; Tue, 29 Sep 2026 15:38:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790689100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4nnLShCVVxjrb/FNXn/wfT2kzVNNxRHBUNKRBG2MRmk=;
 b=I2wsubV5LijinRPdfAAKiaW/DYX3Pke5xg1fBsl8rs6DdLc8ggVMEvVmLfGLlLYlM65gPF
 PSZL81UXPb4AIu/UC0QaDoRFRRCgdCMDdliksvmhUI49WT45ypoo20QTJgu0QuD0ZSsOmB
 4qv/mL6tX5pAdXZWlI5WM+g2XTtMpw4=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-KWwZhvitMg20Of_46eI5JQ-1; Tue, 29 Sep 2026 09:38:19 -0400
X-MC-Unique: KWwZhvitMg20Of_46eI5JQ-1
X-Mimecast-MFC-AGG-ID: KWwZhvitMg20Of_46eI5JQ_1790689098
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-880fc450073so4347774b3a.0
 for <dev@dpdk.org>; Tue, 29 Sep 2026 06:38:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790689096; x=1791293896;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=4nnLShCVVxjrb/FNXn/wfT2kzVNNxRHBUNKRBG2MRmk=;
 b=RJ6O5vCI+XoQ+al8uYFMG1qw8WMa8+SaOPO6LQzgYbzGCfPMSjuHs1gnOEu9p9Fg3s
 Ruz7OD4pFOjqzP1/fXHVsCfppgLcLciKYLOvvyRCz9JL4YkcNlVrr0WkJRKx3sdIkwgI
 318d9/JenwOv+kz299aaw5jNaD5xQTebhap328JLshvu9jtvwiSKp+cAIutGyQY2BBse
 ZsAOYt2vioo7EaMaSSTjjPWSurip5CLcrTvL28EpD5IPvu9ZCfKeIh1QlnvNR5IrYIvI
 3FQzZ90aSdsFHXVyWZtVvGVoU36+u8PB0ynDlVcJ46xhK3S56p7PJOJcTqgAYbfSli7Z
 2Pdg==
X-Gm-Message-State: AFuF++mXpHHDQvC8dyFn6E2oVDfqYREXPqhnwJUTN2Rh0LvhK2oqPr4d
 qR+NueHYE2Mo3CkYTVqMUzsrh5q1mjFg6iIVROSIwIf9XtrX1gb9DvpN9SXziGdlIHN62IhMYaa
 07T2tLzjmSKCRAmgsrHbHIk6f4npo6IzEnBONrZcqO1+Upb+/Ofct1hEzV2k7tFkynJmk5w6Bog
 yGh0t3dIDIRYQSTiqZEsCaMdPqAJE=
X-Gm-Gg: AYBFou0qUnE92I6tZgP+z8g8kzCtpLzcR3oA3eynESitiIxGLuzEv9kQa4UftJoJpWL
 yRKj54/aCB4pPbR/BN8Wt0JoQx7LdEpsL0jb/ujgps9QxW9XDpM8zolZmTSEGobbb1ZuHEZymAf
 faTS1pwbiERP1QO0z6NjjmZM/aLv0qZ/t0tZgY9Pa8AAjhu7yPCdUOjWQuPbxwlNDjUR4L0yXgG
 Lu5+2vHb6i9JbkwzycEnkKx0o9/RTQ/lFxZ66hFUNMtyGHE
X-Received: by 2002:a05:6a00:178c:b0:881:233c:46d4 with SMTP id
 d2e1a72fcca58-881233c5c1amr7964356b3a.43.1790689096116; 
 Tue, 29 Sep 2026 06:38:16 -0700 (PDT)
X-Received: by 2002:a05:6a00:178c:b0:881:233c:46d4 with SMTP id
 d2e1a72fcca58-881233c5c1amr7964335b3a.43.1790689095620; Tue, 29 Sep 2026
 06:38:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260717093006.229370-1-david.marchand@redhat.com>
 <20260922094026.2636265-1-david.marchand@redhat.com>
In-Reply-To: <20260922094026.2636265-1-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 29 Sep 2026 15:38:01 +0200
X-Gm-Features: AclHuK-ekE2gkRS_ghArAjIBh9uaRYM3ynPXwXEzpdPoiv2PqaWGlNLoWiSk3No
Message-ID: <CAJFAV8zLTbnr-EYzxGSh-ty1wRmeO3vBSHXVdS5dk7-CJNEHBg@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] Limit usage of internal API in tests
To: dev@dpdk.org
Cc: bruce.richardson@intel.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WKIggsd7uwceyNl9sEvlj-nEVRQSYURhSrksLwYPB0U_1790689098
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 22 Sept 2026 at 11:40, David Marchand <david.marchand@redhat.com> wrote:
>
> We had a few bug reports related to internal (and experimental) symbols
> issues during 26.07 development.
> See for example https://bugs.dpdk.org/show_bug.cgi?id=1957 or more
> recently https://bugs.dpdk.org/show_bug.cgi?id=1967.
>
> To catch such issues earlier in the CI, this series proposes to run
> the unit tests through meson with the ABI reference unit test binary
> against the current ABI libraries and drivers.
>
> For this to work, some unit tests must be skipped (since meson may
> invoke the ABI reference code with tests that were unknown at the time).
>
> A few unit tests were directly dereferencing internal structures and are
> reworked so they use public APIs.
>
> Additionally, unit tests were allowed to use any internal API which has
> hidden a few issues (like a public API backed by internal symbols in the
> hash library).
> So disable the global ALLLOW_INTERNAL_API and move it to code explicitly
> requiring internal API, with the hope it will push us to have better API.
>
>
> --
> David Marchand
>
> Changes since v3:
> - fixed support of newer meson version in last patch,
>
> Changes since v2:
> - automated tests list generation in last patch,
>
> Changes since v1:
> - rebased,
> - dropped patch 1 on bbdev,
> - dropped dependency on net/ring in devargs test,
> - removed hacks from last patch, flushed excluded tests list,
>   added test-null.sh check,
>
> David Marchand (9):
>   bbdev: add per-queue statistics API
>   hash: fix GFNI stubs export
>   test: uninline helper for forking
>   test/bonding: get MAC address with public API
>   test/devargs: rely on net null driver
>   test/vdev: find device with public API
>   test: limit internal API usage
>   ci: make ABI reference generation faster
>   ci: run reference binaries against current ABI
>
>  .ci/linux-build.sh                     |  44 ++++-
>  MAINTAINERS                            |   1 +
>  app/test-bbdev/test_bbdev_perf.c       |  38 +---
>  app/test/meson.build                   |   7 +-
>  app/test/process.c                     | 231 +++++++++++++++++++++++++
>  app/test/process.h                     | 228 +-----------------------
>  app/test/test_devargs.c                |  21 +--
>  app/test/test_external_mem.c           |   2 +
>  app/test/test_link_bonding.c           |  35 ++--
>  app/test/test_malloc.c                 |   2 +
>  app/test/test_mempool.c                |   2 +
>  app/test/test_pdump.c                  |   3 +
>  app/test/test_pdump.h                  |   3 +
>  app/test/test_vdev.c                   |  85 ++-------
>  app/test/virtual_pmd.c                 |   2 +
>  devtools/test-meson-builds.sh          |   5 +-
>  doc/guides/rel_notes/release_26_11.rst |   5 +
>  lib/bbdev/rte_bbdev.c                  |  20 +++
>  lib/bbdev/rte_bbdev.h                  |  20 +++
>  lib/hash/rte_thash_gfni.c              |   4 +-
>  lib/hash/rte_thash_gfni.h              |   2 -
>  21 files changed, 393 insertions(+), 367 deletions(-)
>  create mode 100644 app/test/process.c

Series applied, thanks for the reviews.


-- 
David Marchand

