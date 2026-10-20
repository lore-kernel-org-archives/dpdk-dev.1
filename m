Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327B3606A32C
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 15:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QK7o1OqK
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 852D540297;
	Tue, 20 Oct 2026 17:03:56 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id B629A40283
 for <dev@dpdk.org>; Tue, 20 Oct 2026 17:03:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792508634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X2pS1qIsL2b2l6Uf8g9SBT3VSVWjT7B9Gi8QEeQex6A=;
 b=QK7o1OqKQAPF1sKUt5x5zP4i/uu/v3OuF+Ss9d0r46k85oi6Oh0KjMN6VTcNRbtYBkm3MC
 yJvg41LQo8gNC4NsezOM7fidDUpWm7vpbBq8+cfkFuKTBvygYa6n+aeWQ2WTTJ4JBI3Lt0
 Inzic3AObQdz4LY+etT73mepNvo+Kcs=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-q47m-QngMMWivOGu38xMNQ-1; Tue, 20 Oct 2026 15:03:50 +0000
X-MC-Unique: q47m-QngMMWivOGu38xMNQ-1
X-Mimecast-MFC-AGG-ID: q47m-QngMMWivOGu38xMNQ_1792508629
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5be42ea8980so2417494e87.2
 for <dev@dpdk.org>; Tue, 20 Oct 2026 08:03:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792508629; x=1793113429;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=X2pS1qIsL2b2l6Uf8g9SBT3VSVWjT7B9Gi8QEeQex6A=;
 b=MSYvhQhYvaLhimdBFCtUC5GoVeZmvSiCp9n356Qg4L53sASyoZozRY9FNdBplxVQvl
 fN9M6H9OLYI8WMFTudWkElgzni6Kv1tYnNfOxYlz5yrp9/b/lRGSY6nkroie6OPyvAF1
 EalEHy4DiOlB3r2sUYF6kW6r0qi3ePWuUZPP47NHonM/OoiHGHqhEmaCxBMe3FApbCaT
 BiLaQaZer7zPBd173Q2zsShgodssx/1jb3/8XyNWK/LAhJpGt7DMNau8ISgDrfgw8wsP
 PB/6H6cvwm/ynwKbvPE/wIO4SBZDlSOqK+Zzof+Iv7jZPdvBKRaOevNHsJe1ejdG8KTC
 FW0A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxgCzcfeHz96x0c0wKlelit1Aw6GP2PkrQ82QjK3w38bQNwLVJm3/RyPP/NsEDHQ8L4KvM=@dpdk.org
X-Gm-Message-State: AFq9FYKdBxpXFlJJ+/D2QKDbsBhmP0K3AzMrzO66HoqeeXmxNL/zxYoU
 VLh7ZAI1rm5wdGEqqA0At5dGly03mYlogyACGm0+jvX3e9zf50tB2E4vRyv9U+TDXfpuErpLuJd
 RPIrX/n1N1DJpH1SPXGEKhQ1TmZ/ZEyUuHnYzsFujlkWLUMDnChqOmosH1gx6RwUZ1MdKNZpEVO
 uaMNM4vYuY0uRCU8t9kCc=
X-Gm-Gg: AYBFou2M/ExLashj9usIy8Xt+5F0FPT7AGs8GuSzPH2BuE/3jeZ4X5EXlEyFhUOe8z/
 9RO5zIzTaqVrQ1wri0wUJZo+m1U/8gvzQWS8JncopvMxAZvBMzz3lIlyU7kI4DfAjuNbKkUZEum
 Vo+65RfxZNA9pttqf936VSE7yv+XXsY9wjkksTSNIaxtv89t9X4jtgE3HA9xXU79SrLI0Pd9gQf
 OwrxctYoEmmKFBo33pbEiZy0p++17z4dGyqgfbUJRjzrxN5
X-Received: by 2002:a05:6512:2c03:b0:5be:5390:8ec5 with SMTP id
 2adb3069b0e04-5be539090d8mr3831738e87.42.1792508629203; 
 Tue, 20 Oct 2026 08:03:49 -0700 (PDT)
X-Received: by 2002:a05:6512:2c03:b0:5be:5390:8ec5 with SMTP id
 2adb3069b0e04-5be539090d8mr3831716e87.42.1792508628611; Tue, 20 Oct 2026
 08:03:48 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <cover.1787233986.git.anatoly.burakov@intel.com>
 <cover.1791892574.git.anatoly.burakov@intel.com>
 <as5n5Gd_ibUFwu8T@bricha3-mobl1.ger.corp.intel.com>
 <ABC_uunLSjatNxgGlc8CGA@monjalon.net>
In-Reply-To: <ABC_uunLSjatNxgGlc8CGA@monjalon.net>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 20 Oct 2026 17:03:36 +0200
X-Gm-Features: AclHuK_l7qEJdMDlB0-dMbD2VXJtqan-9iWFeQVYn8UDD87fpK5fKFE6Dxh7hUI
Message-ID: <CAJFAV8wfm-d-cgScj5-6rRk39PqjuU38QS3i=hGBQ-x5Z40omA@mail.gmail.com>
Subject: Re: [PATCH v7 00/25] Building a better rte_flow parser
To: Thomas Monjalon <thomas@monjalon.net>,
 Bruce Richardson <bruce.richardson@intel.com>
Cc: Anatoly Burakov <anatoly.burakov@intel.com>, dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -euIMsrEFFpuIl7EBmUimUEXsBoi7mdLnQ9GjEGyCKo_1792508629
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 14 Oct 2026 at 22:50, Thomas Monjalon <thomas@monjalon.net> wrote:
>
> 13/10/2026 19:18, Bruce Richardson:
> > Patchset applied to dpdk-next-net-intel.
> >
> > As well as the arm build issue, I also fixed a number of checkpatch issues,
> > since there were a large number on this set. Most I kept unfixed, since I
> > felt the exceptions were reasonable, but please check what was applied in
> > case some issue was introduced with the checkpatch changes I made on apply.
>
> Unfortunately it fails compiling on my FreeBSD,
> because of an internal API included in a header included in testpmd.
>
> You can make it fail reliably with Clang on Linux with this patch:
> https://patches.dpdk.org/project/dpdk/patch/20261014201627.571496-1-thomas@monjalon.net/

Merged the v2.

-- 
David Marchand

