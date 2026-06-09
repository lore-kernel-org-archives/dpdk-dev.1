Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFE5CD6E79
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 09:30:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D0F24402BE;
	Tue,  9 Jun 2026 11:30:51 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 7CAA74025E
 for <dev@dpdk.org>; Tue,  9 Jun 2026 11:30:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780997449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d/4mtMWX2gInumRoZ2kFNZlV2jQvxMrXffN8fON83kY=;
 b=PABjhPKR3U76W3Zcp+jVK/+Ms0jf5LZ4u8l4LF3gL+7x6fC6GYKyDL87b8stEPKRkwSqux
 PPHrajPNo+0tgidIsk6HsnfrT1lO+7NMhIwbZ3+fZv/NTYZiWvJnCKz4x1OLqZpoZjMCBm
 1N2L9dij3rxnqAG2eXiiZawIDCKSTTc=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-cxSXZ8p6N_y5QM_7hELaTw-1; Tue, 09 Jun 2026 05:30:48 -0400
X-MC-Unique: cxSXZ8p6N_y5QM_7hELaTw-1
X-Mimecast-MFC-AGG-ID: cxSXZ8p6N_y5QM_7hELaTw_1780997447
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5aa68cf0a4bso3537420e87.0
 for <dev@dpdk.org>; Tue, 09 Jun 2026 02:30:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780997447; x=1781602247;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d/4mtMWX2gInumRoZ2kFNZlV2jQvxMrXffN8fON83kY=;
 b=Jo4Ehr7Fi/0jD4QjvI3vxNLwi7AMvtZlbVvg0O9914S4b3rpHgaoeV2RBkcIZGzfoZ
 MFiahHGXgtnEITWkeJfrEt85HNS2sQyjsSrLmbzPwvbAdc9EDP8Ubv05ljowVlebsAJS
 XmsTKmlp95akyoKSAKMJPk5348EaIlu0viDxGGxREpJYC/5euHMOgmBH6ncQUz31vCd4
 x0YC9/RBmnJ4Vxdgay0eezdJGXSy8s5r9p8oidEwbq8A609yzSejhQU5qTHSQPvuk7HA
 hOFwrsuJ98Q2dKdVBv4xoaaAwW1ltR01EG3dCoiiF5TtZhI0TSUWGb4pcNf+0kiXmq7e
 WjLg==
X-Gm-Message-State: AOJu0Yy+zRGeGkmXNwYpHoLL2QPwfdDUTylOYtodlvcmPaECIFKB0T81
 vLefU4F3rNZvkE8ZJwkt8OOHFIMw0rGNx4KhJPh1ZIvkQezhVyaCrTinsOc9recv38Luwbby77f
 +m6Gn3WcKRMSvA7pZX8K398bMqG2fteaM+7wNCbYmb0/GizaK5cRNPTmdftI6pdp6k2goNektKT
 kvZRQxyQuZXAbHGoHMCYk=
X-Gm-Gg: Acq92OE4EVYVjz8ZtoDRUe7ldm/b0rcL+oxnOwaskTqGofYMb1EiIEoHVM5O07BhZcG
 O+I929maQR4uea4QI9nwbY6asRfMitkW7i8w+sKpFxwW4z0biLwMGH5zVwx+mB/5xBATU17gvtT
 kR+jXyErCjxjf3hLLtaGPCNJKfP36ilUhPTKwzYTbktx6QQy8O8WE1Rw/rre4EJ/VcsUN9WlsL5
 jBbr8A0fzHwxylZVd1/H9dFWER6L9F2TNveLDe3Y6shw6I3gQhOBDR0ULiHJ4JO/nDggRqbuOVE
 /hsW
X-Received: by 2002:a05:6512:1591:b0:5aa:5dc5:3e00 with SMTP id
 2adb3069b0e04-5aa88669c20mr5368031e87.6.1780997446803; 
 Tue, 09 Jun 2026 02:30:46 -0700 (PDT)
X-Received: by 2002:a05:6512:1591:b0:5aa:5dc5:3e00 with SMTP id
 2adb3069b0e04-5aa88669c20mr5368013e87.6.1780997446196; Tue, 09 Jun 2026
 02:30:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260325014506.1866374-1-longli@microsoft.com>
In-Reply-To: <20260325014506.1866374-1-longli@microsoft.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 9 Jun 2026 11:30:34 +0200
X-Gm-Features: AVVi8CewjeDkTmSNbsIIWTmnATtpCD_RLQfo30xNDUrN55mfCyhjouq4TStNBoo
Message-ID: <CAJFAV8ye5NG=-xkXjNX5+jBpJgV1S5oe02_+rAa9BYwNv_wmAA@mail.gmail.com>
Subject: Re: [PATCH 1/2] eal: return error on devargs truncation in hotplug MP
 messages
To: Long Li <longli@microsoft.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com, stephen@networkplumber.org, 
 "Burakov, Anatoly" <anatoly.burakov@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sddy2l8n3GOSFxIQSAaRnWg-MBpUGA_6UmmvzGe5qZA_1780997447
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

On Wed, 25 Mar 2026 at 02:45, Long Li <longli@microsoft.com> wrote:
>
> The EAL hotplug multi-process messaging uses a fixed-size buffer
> (EAL_DEV_MP_DEV_ARGS_MAX_LEN, 128 bytes) for device arguments.
> When devargs exceeds this limit, strlcpy silently truncates the
> string. This causes secondary processes to receive incomplete
> devargs during hotplug re-add, leading to failed port
> re-initialization.
>
> For example, a MANA PCI device with 6 mac= arguments:
>
>   mac=AA:BB:CC:DD:EE:01,mac=AA:BB:CC:DD:EE:02,
>   mac=AA:BB:CC:DD:EE:03,mac=AA:BB:CC:DD:EE:04,
>   mac=AA:BB:CC:DD:EE:05,mac=AA:BB:CC:DD:EE:06
>
> produces a 131-byte devargs string that gets silently truncated
> to 127 bytes, losing the last MAC address.
>
> Return -E2BIG from rte_dev_probe() and rte_dev_remove() when
> devargs would be truncated, instead of silently corrupting data.
>
> Signed-off-by: Long Li <longli@microsoft.com>

Worth a Fixes: tag and Cc: stable.

> ---
>  lib/eal/common/eal_common_dev.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/lib/eal/common/eal_common_dev.c b/lib/eal/common/eal_common_dev.c
> index 7185de0cb9..de24d14d28 100644
> --- a/lib/eal/common/eal_common_dev.c
> +++ b/lib/eal/common/eal_common_dev.c
> @@ -250,6 +250,11 @@ rte_dev_probe(const char *devargs)
>
>         memset(&req, 0, sizeof(req));
>         req.t = EAL_DEV_REQ_TYPE_ATTACH;
> +       if (strlen(devargs) >= EAL_DEV_MP_DEV_ARGS_MAX_LEN) {
> +               EAL_LOG(ERR, "devargs truncated (len %zu, max %d)",
> +                       strlen(devargs), EAL_DEV_MP_DEV_ARGS_MAX_LEN);
> +               return -E2BIG;
> +       }
>         strlcpy(req.devargs, devargs, EAL_DEV_MP_DEV_ARGS_MAX_LEN);

Please move the check before the memset().

>
>         if (rte_eal_process_type() != RTE_PROC_PRIMARY) {
> @@ -397,6 +402,12 @@ rte_dev_remove(struct rte_device *dev)
>
>         memset(&req, 0, sizeof(req));
>         req.t = EAL_DEV_REQ_TYPE_DETACH;
> +       if (strlen(devargs) >= EAL_DEV_MP_DEV_ARGS_MAX_LEN) {
> +               EAL_LOG(ERR, "devargs truncated (len %zu, max %d)",
> +                       strlen(devargs), EAL_DEV_MP_DEV_ARGS_MAX_LEN);
> +               free(devargs);
> +               return -E2BIG;
> +       }
>         strlcpy(req.devargs, devargs, EAL_DEV_MP_DEV_ARGS_MAX_LEN);
>         free(devargs);
>

Why do we need to validate devargs on cleanup?
Its length should have been validated during probe.


-- 
David Marchand

