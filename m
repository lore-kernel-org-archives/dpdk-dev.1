Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A5AC02194
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 14:41:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E3F1A42E86;
	Fri,  7 Feb 2025 15:41:24 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 0104B410E3
 for <dev@dpdk.org>; Fri,  7 Feb 2025 15:41:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738939282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mNlWZVG6V1O4Elg6eLB35ubsz91znETIwE1eCauRS/o=;
 b=Wg8lNctpuQjmXztJBtKCxdTDd6SYMT3uTnvHw+aHyTkOqkoia7G2/TLF0oDpN+rnPuTJEN
 88Mx8leLg8VVyl2VhFkFeRhy347mhQW8UiWz5TaPu0WCEBINGNMQdFj6RItyyWATWp9sXC
 fvwwk7riARtTe7/kzuK1Wblq2XJdsNg=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-NL-h5jRYOL6vRqALboHKqA-1; Fri, 07 Feb 2025 09:41:20 -0500
X-MC-Unique: NL-h5jRYOL6vRqALboHKqA-1
X-Mimecast-MFC-AGG-ID: NL-h5jRYOL6vRqALboHKqA
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-545014aea84so75649e87.2
 for <dev@dpdk.org>; Fri, 07 Feb 2025 06:41:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738939279; x=1739544079;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mNlWZVG6V1O4Elg6eLB35ubsz91znETIwE1eCauRS/o=;
 b=tYFZ+buPyNwt00RZl0M+2ROKMNLeudOV2FL3snhVCisOpzhr6DAWg6Ro6jyvK89BYK
 bSgIknc/Xg3SfElRw6bJCzf8XF/kVHrV1rzRC5UILc3EGKeqR1Xr1ZJiR2atQEtYIe5c
 sZz3G9j7RvEJpM/0yO2VnQ7dvYg1Py3uEJmq3EU+08XrxLrUMH5O3Lrl8OIzWJ8YDqp3
 yTIXgzFHNKa5tkg+cac7+5ai/zYzXNaNP8rDakd7z4aOZayxRCMecR0Om/1jBqN8SgIA
 PYoQMERW59jdRZo1eHuyAjbSXomn5T6jk9S3oj75al9B2QptI7HoiWYpBE5tNOa0aheA
 35Gw==
X-Gm-Message-State: AOJu0YydiHbjdl1wTLx5ue9FVv/NmJv+CgCjHzeAB3IvFRPjtLTSCL0R
 Fa9HCR3SLZmB67pEBcfX53PAXexvl00d70smqS/M3lPgw4QD53kbzrXGgMP8TpVZSZkeLP86E8I
 yWCsgPNpFeZPi6mC9P6bGBI52tt/+ebGxhSA7hm2Mj6pwfSWGprhDG/+OTrVtMLwautxzkfC0YX
 xMDl1kpuclGx4uHnA=
X-Gm-Gg: ASbGncvsRKCdbZWujkNeh3nno19YuT+EJ9qn+PiYsBeyK7UNe9BAmrI1WtdCQj1JIBf
 zcYlhf8OEf44GQXTcwBb5aEW7VQSM7LbMN8rJdr4Y+rQPIgOUCmhgCboFLYx6cxKN
X-Received: by 2002:a05:6512:718:b0:544:11e4:d53e with SMTP id
 2adb3069b0e04-54414b06e0fmr990116e87.48.1738939279059; 
 Fri, 07 Feb 2025 06:41:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHncPa5Rh7OH4JeNZcLbFhs5BAjt3qXZ0WKlPuTvmY7IQ37Z+rKvmTNY+nfm2iQDVuqXgNJhxwEaDmM60/oTHk=
X-Received: by 2002:a05:6512:718:b0:544:11e4:d53e with SMTP id
 2adb3069b0e04-54414b06e0fmr990109e87.48.1738939278669; Fri, 07 Feb 2025
 06:41:18 -0800 (PST)
MIME-Version: 1.0
References: <20241226081020.3479-1-ming.1.yang@nokia-sbell.com>
 <20250102085838.991-1-ming.1.yang@nokia-sbell.com>
In-Reply-To: <20250102085838.991-1-ming.1.yang@nokia-sbell.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 7 Feb 2025 15:41:06 +0100
X-Gm-Features: AWEUYZny6B2wnTYn7c2w8azRUUyl1CWrh3vFR7c1zthrAc6Lc2Bhixw_WPfVK2Y
Message-ID: <CAJFAV8w3Dh9Axgo6Gr68qBKh+rc+vqyfByKRhSekydJqVtWD5Q@mail.gmail.com>
Subject: Re: [PATCH v2] eal: fix unused memseg length
To: Yang Ming <ming.1.yang@nokia-sbell.com>
Cc: dev@dpdk.org, anatoly.burakov@intel.com, stable@dpdk.org, 
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2s-UHrgihYRYgiz9mHq2jcZKybPih_WoM75vInOZJIg_1738939279
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Thu, Jan 2, 2025 at 9:59=E2=80=AFAM Yang Ming <ming.1.yang@nokia-sbell.c=
om> wrote:
>
> Fix the issue where OS memory is mistakenly freed with rte_free
> by setting the length (len) of unused memseg to 0.
>
> When `eal_legacy_hugepage_init()` releases the VA space for
> unused memseg lists(MSLs), it does not reset MSLs' length to 0.
> As a result, `mlx5_mem_is_rte()` may incorrectly identify OS
> memory as rte memory.
> This can lead to `mlx_free()` calling `rte_free()` on OS memory,
> causing an "EAL: Error: Invalid memory" log and failing to free
> the OS memory.
>
> This issue is occasional and occurs when the DPDK program=E2=80=99s
> memory map places the heap address range between 0 and len(32G).
> In such cases, malloc may return an address less than len,
> causing `mlx5_mem_is_rte()` to incorrectly treat it as rte
> memory.
>
> Also, consider how the MSL with `base_va =3D=3D NULL` ends up in
> `mlx5_mem_is_rte()`. It comes from `rte_mem_virt2memseg_list()`
> which iterates MSLs and checks that an address belongs to
> [`base_va`; `base_va+len`) without checking whether
> `base_va =3D=3D NULL` i.e. that the MSL is inactive. So this patch
> also corrects `rte_mem_virt2memseg_list()` behavior.
>
> Fixes: 66cc45e293ed ("mem: replace memseg with memseg lists")
> Cc: stable@dpdk.org
>
> Signed-off-by: Yang Ming <ming.1.yang@nokia-sbell.com>
> Acked-by: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>

Applied, thanks for the fix.


--=20
David Marchand

