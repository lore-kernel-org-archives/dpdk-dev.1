Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72814C61DBE
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Aug 2026 15:55:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 89534402B8;
	Tue, 25 Aug 2026 17:55:09 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 949944013F
 for <dev@dpdk.org>; Tue, 25 Aug 2026 17:55:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787673308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wion0mkxZRJmoSfA/DmkN1LxG3wcoTHeuSsoTGz7Mzw=;
 b=jIfqNHIdB5nU32HqUK+YR4G9Edx2zsAZ06Q2yY96qqabf4G3rjEenwOMcy2YN8kcqQD/Vw
 g0KLKafwPPlmFUMcJspPluEpCnl8lva6bZWZjf2bVCDZMrl8qGouknQqoOMHGOFfppfSde
 W7G1hZvkPBxTrG0Xci1gOOEASL0gAPw=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-IpdrcqfPPbWy7IHBTOodMQ-1; Tue, 25 Aug 2026 11:55:06 -0400
X-MC-Unique: IpdrcqfPPbWy7IHBTOodMQ-1
X-Mimecast-MFC-AGG-ID: IpdrcqfPPbWy7IHBTOodMQ_1787673305
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-39c791b2842so25551771fa.3
 for <dev@dpdk.org>; Tue, 25 Aug 2026 08:55:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787673305; x=1788278105;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Wion0mkxZRJmoSfA/DmkN1LxG3wcoTHeuSsoTGz7Mzw=;
 b=btfwAbHHDVdG6crrTqnhOZnw5D3x3pZmUsJX/1BtOaAE+xfs7QKfwZpXOqrKdbka0z
 UnmG4CzZZbe5cQJwhNGtddJ7cFHVZeU3gHYmMZeSLmBL2aqLc02KP2pjr2wo4Sz9fqcm
 U+9mgRBZDg2vIrRjw1W2q9iod0FuhrOxz58eufihtloCQvQI82gC/JSWx7LuMKJrDOTR
 8zOghKscD9fxhUW4geguVFtgy56i7yZWFYVO/VnVG3w/TlZc3CYRm73JPRvCXyyQjcHI
 +jveQRgJqVJ1gOK+c6N55DRClnLEjkg0TY6bSWXJkinkrrPmwn+grOIgkGygDgc6233N
 rXJQ==
X-Gm-Message-State: AFuF++mNox3Nc+ksaT+UDMMsxRNA5MTTntUXaCeE0aOUGdSeNUP+ZEN0
 Lsb4ykdTPPvLAKCjYPbb53awWhH8Ym0AOO3Mci3GXoNHohGVP8P0FvmeZqGYVJ97GRRqZeLs20P
 M/BC3HvvdBcfC6kkaPZ5U1zYVA7MsU6AyENF/skUzc8G/zHO9DGEFMJbNL3jZOq3N+urImeLkDF
 fxJd5wLveeQNy+4CGYUZQ=
X-Gm-Gg: AR+sD11ArwdesWLwWo5QX38r6pZNoIbtzugM5dGHHQplWQn1pfWP5AGljmictfXljaZ
 /ppv6+VG8yBFIPTwg//au45agdmwmuzq1PxxsdrLx7OCm/7ydYhK8qrOp2VwF6NEQPKIKc0Athq
 enHNmA5gQptkor7kmU5p0Uay1RgxJGzIWRiGa21x3F9RYMJQZef9FP+7Vxjo+LZcX5iJePhI1HN
 KQZBxmPRBPibWrGG1xhOs0hujHOk2eSANVdj7SjBTBIZ/3x
X-Received: by 2002:a05:6512:3b87:b0:5ae:ba7a:1789 with SMTP id
 2adb3069b0e04-5b49cdb0656mr2595916e87.13.1787673304938; 
 Tue, 25 Aug 2026 08:55:04 -0700 (PDT)
X-Received: by 2002:a05:6512:3b87:b0:5ae:ba7a:1789 with SMTP id
 2adb3069b0e04-5b49cdb0656mr2595894e87.13.1787673304350; Tue, 25 Aug 2026
 08:55:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260814153755.940302-1-bruce.richardson@intel.com>
 <20260825151533.535102-1-bruce.richardson@intel.com>
In-Reply-To: <20260825151533.535102-1-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 25 Aug 2026 17:54:51 +0200
X-Gm-Features: AcwNN1Xr6oH9WdF0jFyjGj64FxMeoVuIWIx9LnibcqK0shWKeC7DmzVDh05Y6xU
Message-ID: <CAJFAV8zAQwFzNSPiw+brajW1wh4nvTF-VA20teXEx5qeRxpYKw@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] remove non-base files from base folders
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9xCumA0fwcTqibveWeTDR0Zp475XWnyk_RhzLJT9eBw_1787673305
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

On Tue, 25 Aug 2026 at 17:16, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> The base code folders for intel drivers contained the compatibility
> *_osdep.h files as well as meson.build files, both of which are
> editable via regular DPDK patches. Although the DPDK documentation
> allows this arrangement, I (for one) have always found it a little
> awkward and confusing to have editable and non-editable files mixed.
>
> For Intel drivers only, this patchset moves osdep file out of base,
> and merges the (in most cases trivial) meson.build files from base
> into the main driver meson.build file.
>
> After this patch we have a clean separation - any files in base,
> with no exceptions, should be updated only via snapshot update
> patchsets from Intel. All files outside base are normal DPDK files
> that can be modified by any patch.
>
> v2: remove unnecessary edits to ixgbe files, keeping the "base/"
>     prefix on includes.
>
> Bruce Richardson (8):
>   net/e1000: move editable files out of base folder
>   net/fm10k: move editable files out of base folder
>   net/i40e: move editable files out of base folder
>   net/iavf: move editable files out of base folder
>   net/ice: move editable files out of base folder
>   net/idpf: move editable files out of base folder
>   net/ixgbe: move editable files out of base folder
>   net/ice: consolidate the sources list
>
>  drivers/net/intel/cpfl/cpfl_actions.h         |  2 +-
>  drivers/net/intel/cpfl/cpfl_controlq.h        |  2 +-
>  drivers/net/intel/e1000/base/README           |  9 ---
>  drivers/net/intel/e1000/base/meson.build      | 24 -------
>  .../net/intel/e1000/{base => }/e1000_osdep.c  |  0
>  .../net/intel/e1000/{base => }/e1000_osdep.h  |  4 +-
>  drivers/net/intel/e1000/em_rxtx.c             |  2 +-
>  drivers/net/intel/e1000/igc_ethdev.h          |  2 +-
>  drivers/net/intel/e1000/meson.build           | 22 ++++++-
>  drivers/net/intel/fm10k/base/meson.build      | 11 ----
>  .../net/intel/fm10k/{base => }/fm10k_osdep.h  |  4 +-
>  drivers/net/intel/fm10k/meson.build           |  9 ++-
>  drivers/net/intel/i40e/base/README            |  8 ---
>  drivers/net/intel/i40e/base/meson.build       | 12 ----
>  .../net/intel/i40e/{base => }/i40e_osdep.h    |  4 +-
>  drivers/net/intel/i40e/meson.build            | 10 ++-
>  drivers/net/intel/iavf/base/README            |  8 ---
>  .../iavf/{base/iavf_impl.c => iavf_osdep.c}   |  0
>  .../net/intel/iavf/{base => }/iavf_osdep.h    |  2 +
>  drivers/net/intel/iavf/meson.build            |  2 +-
>  drivers/net/intel/ice/base/README             |  8 ---
>  drivers/net/intel/ice/base/meson.build        | 51 ---------------
>  drivers/net/intel/ice/{base => }/ice_osdep.h  |  4 +-
>  drivers/net/intel/ice/meson.build             | 62 ++++++++++++++++---
>  drivers/net/intel/idpf/base/README            |  8 ---
>  drivers/net/intel/idpf/base/meson.build       |  7 ---
>  .../net/intel/idpf/{base => }/idpf_osdep.h    |  4 +-
>  drivers/net/intel/idpf/idpf_ptp.h             |  2 +-
>  drivers/net/intel/idpf/meson.build            |  5 +-
>  drivers/net/intel/ixgbe/base/README           |  9 ---
>  drivers/net/intel/ixgbe/base/meson.build      | 19 ------
>  drivers/net/intel/ixgbe/ixgbe_ethdev.c        |  2 +-
>  drivers/net/intel/ixgbe/ixgbe_flow.c          |  2 +-
>  .../net/intel/ixgbe/{base => }/ixgbe_osdep.h  |  2 +
>  drivers/net/intel/ixgbe/meson.build           | 17 ++++-
>  35 files changed, 138 insertions(+), 201 deletions(-)
>  delete mode 100644 drivers/net/intel/e1000/base/meson.build
>  rename drivers/net/intel/e1000/{base => }/e1000_osdep.c (100%)
>  rename drivers/net/intel/e1000/{base => }/e1000_osdep.h (98%)
>  delete mode 100644 drivers/net/intel/fm10k/base/meson.build
>  rename drivers/net/intel/fm10k/{base => }/fm10k_osdep.h (98%)
>  delete mode 100644 drivers/net/intel/i40e/base/meson.build
>  rename drivers/net/intel/i40e/{base => }/i40e_osdep.h (98%)
>  rename drivers/net/intel/iavf/{base/iavf_impl.c => iavf_osdep.c} (100%)
>  rename drivers/net/intel/iavf/{base => }/iavf_osdep.h (98%)
>  delete mode 100644 drivers/net/intel/ice/base/meson.build
>  rename drivers/net/intel/ice/{base => }/ice_osdep.h (99%)
>  delete mode 100644 drivers/net/intel/idpf/base/meson.build
>  rename drivers/net/intel/idpf/{base => }/idpf_osdep.h (99%)
>  delete mode 100644 drivers/net/intel/ixgbe/base/meson.build
>  rename drivers/net/intel/ixgbe/{base => }/ixgbe_osdep.h (99%)

Looks like some update is missing in net/ice (reference to iavf_impl.c).

Once fixed, for the series:
Acked-by: David Marchand <david.marchand@redhat.com>


-- 
David Marchand

