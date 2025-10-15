Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A6D2CCD185
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 07:37:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 625CE4067A;
	Wed, 15 Oct 2025 09:36:59 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 3D211402C3
 for <dev@dpdk.org>; Wed, 15 Oct 2025 09:36:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760513817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0MdA9liNbPdIHdFofeolzel4C/urILJbmPLXDYG6XN4=;
 b=VEdiWLyq06UQ4wYykGGTuUboLN2R+pOb0+uPDRSS++tU7ZjdRVSk0RY7DgrcyD8ZILCILW
 kesBCmVIKHrJWdSQ0igDdIUxNoz9tKutjhEkChn09yb6fu1SRLVxwVR/u3yfMhaMs5IfUC
 HPGvTkQ1RkoK3fb/d2ueyopaN0GuejE=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-Eq5LIMADPPWZAgoHQA6GGg-1; Wed, 15 Oct 2025 03:36:56 -0400
X-MC-Unique: Eq5LIMADPPWZAgoHQA6GGg-1
X-Mimecast-MFC-AGG-ID: Eq5LIMADPPWZAgoHQA6GGg_1760513815
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-36c0f8f10e6so50468151fa.2
 for <dev@dpdk.org>; Wed, 15 Oct 2025 00:36:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760513815; x=1761118615;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0MdA9liNbPdIHdFofeolzel4C/urILJbmPLXDYG6XN4=;
 b=etWjg0i8GlQNGSqrHk+Bwry9leQdacLVYmSYT5ZxfXQu4j4AU0wrrYC5zV0ks8tPOw
 h0hGeSaFHyXOY4EgjKn7Q9nlj22bB4j/ATi4lxfSUyjYWIQuAAcBOgMoyoIs5TZqJnlJ
 X1CVAXVi0PDifebPKBAh6StVhgDrK4i4wTgZMQjyvPIgUVC8+3+qApMGBlitC1uzxiZV
 k3QoqDMt+IHJVhshd17st/MXxYa4eYY3pFQjXSPiqOFsPl5QYgExeL0HI0dzfTD/yR/u
 daj7GUmZj3x8ulKztWkIYUc0F8wHGvk6aeoKyYLDUdjqhKrNNlKVkBPg6PJAuZfoSdB+
 MODA==
X-Gm-Message-State: AOJu0YwihXOfasLlGnu5IgR+4FUdyif4+iGvcUj+f0u3zH9tnNRfke1I
 mOhTDsQzDUtemjDPzM4bcQwnci7Gj3qUOj/2VjM6H2kLf1jIf9OU4VN0HUcn1Ig9HaB5Y0lRtRE
 pC2psUb8P59CitZzrvTIIZWYSHyA/wngGciv8PZQYmPxEzfrWPsNeCeXE0Bl7z43WqWqiF0OGi6
 /LiaIvf5rrLlhHtMi8Mk4=
X-Gm-Gg: ASbGncsi89IEnPzLQXRTjLjUYIwCxcIYT8YLagY//mL/KwueLeH3OC0qtyZmybNJ22N
 EN7ihpQoPvVn7jdHQOFUabQUG2fhiq0/JRCqgtbhN1GtvssaZTQp4S1Angk98Y93EL3ib08l0i5
 k+DXVRMHQ8a+975ExuE4Q=
X-Received: by 2002:a05:6512:22c5:b0:591:c325:45bf with SMTP id
 2adb3069b0e04-591c32548b5mr1291565e87.2.1760513815008; 
 Wed, 15 Oct 2025 00:36:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgR2f3RJ1ZtnIcZnX1lO583H4zLx2GcrkIBnmyxwcg17xUgpGlid96+ZnCJo4B+5TYj+58PDjkDIr62JHB6Fs=
X-Received: by 2002:a05:6512:22c5:b0:591:c325:45bf with SMTP id
 2adb3069b0e04-591c32548b5mr1291557e87.2.1760513814608; Wed, 15 Oct 2025
 00:36:54 -0700 (PDT)
MIME-Version: 1.0
References: <20251008090444.2689652-1-pravin.bathija@dell.com>
 <20251008090444.2689652-4-pravin.bathija@dell.com>
In-Reply-To: <20251008090444.2689652-4-pravin.bathija@dell.com>
From: Maxime Coquelin <mcoqueli@redhat.com>
Date: Wed, 15 Oct 2025 09:36:43 +0200
X-Gm-Features: AS18NWAFr_neZ9MaANKBhvf-auhxbwu2eRuKFhIq_uAfa_avw9MDOlu3p6c6CP4
Message-ID: <CAO55cswN99fw=OMjOuq_TKBTHNPHcMJEbgAqjsTEX-1FR8zYFA@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] vhost: hdr file changes for add/remove mem regions
To: Pravin M Bathija <pravin.bathija@dell.com>
Cc: dev@dpdk.org, pravin.m.bathija.dev@gmail.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LlF78hPDs5HegMo1yCDARZV7S8jssaJfDP_tmetCXCg_1760513815
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

On Wed, Oct 8, 2025 at 11:05=E2=80=AFAM Pravin M Bathija
<pravin.bathija@dell.com> wrote:
>
> * add enums to vhost user request for add/remove
>   memory region support
> * data structure that defines single memory region
> * increase max memory regions from 8 to 128
> * 128 add/remove regions tested with qemu virtio with
>   testpmd vhost.

The commit message has to be full sentences, explaining the changes but mor=
e
importantly the purpose of the patch.

For the title, it should not contain variable names or abbreviations.

This comment applies here and to other patches of the series.

> Signed-off-By: Pravin M Bathija <pravin.bathija@dell.com>
> ---
>  lib/vhost/vhost_user.h | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/lib/vhost/vhost_user.h b/lib/vhost/vhost_user.h
> index ef486545ba..c6ad5b76d6 100644
> --- a/lib/vhost/vhost_user.h
> +++ b/lib/vhost/vhost_user.h
> @@ -11,7 +11,7 @@
>
>  /* refer to hw/virtio/vhost-user.c */
>
> -#define VHOST_MEMORY_MAX_NREGIONS 8
> +#define VHOST_MEMORY_MAX_NREGIONS 128
>
>  #define VHOST_USER_NET_SUPPORTED_FEATURES \
>         (VIRTIO_NET_SUPPORTED_FEATURES | \
> @@ -32,6 +32,7 @@
>                                          (1ULL << VHOST_USER_PROTOCOL_F_B=
ACKEND_SEND_FD) | \
>                                          (1ULL << VHOST_USER_PROTOCOL_F_H=
OST_NOTIFIER) | \
>                                          (1ULL << VHOST_USER_PROTOCOL_F_P=
AGEFAULT) | \
> +                                        (1ULL << VHOST_USER_PROTOCOL_F_C=
ONFIGURE_MEM_SLOTS) | \

It should only be enabled once the feature works, so likely as the
last patch of this series.

>                                          (1ULL << VHOST_USER_PROTOCOL_F_S=
TATUS))
>
>  typedef enum VhostUserRequest {
> @@ -67,6 +68,9 @@ typedef enum VhostUserRequest {
>         VHOST_USER_POSTCOPY_END =3D 30,
>         VHOST_USER_GET_INFLIGHT_FD =3D 31,
>         VHOST_USER_SET_INFLIGHT_FD =3D 32,
> +       VHOST_USER_GET_MAX_MEM_SLOTS =3D 36,
> +       VHOST_USER_ADD_MEM_REG =3D 37,
> +       VHOST_USER_REM_MEM_REG =3D 38,
>         VHOST_USER_SET_STATUS =3D 39,
>         VHOST_USER_GET_STATUS =3D 40,
>  } VhostUserRequest;
> @@ -91,6 +95,11 @@ typedef struct VhostUserMemory {
>         VhostUserMemoryRegion regions[VHOST_MEMORY_MAX_NREGIONS];
>  } VhostUserMemory;
>
> +typedef struct VhostUserSingleMemReg {
> +       uint64_t padding;
> +       VhostUserMemoryRegion region;
> +} VhostUserSingleMemReg;
> +
>  typedef struct VhostUserLog {
>         uint64_t mmap_size;
>         uint64_t mmap_offset;
> @@ -186,6 +195,7 @@ typedef struct __rte_packed_begin VhostUserMsg {
>                 struct vhost_vring_state state;
>                 struct vhost_vring_addr addr;
>                 VhostUserMemory memory;
> +               VhostUserSingleMemReg memory_single;
>                 VhostUserLog    log;
>                 struct vhost_iotlb_msg iotlb;
>                 VhostUserCryptoSessionParam crypto_session;
> --
> 2.43.0
>

