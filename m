Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F248C9832A
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 14:38:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B6B440E22;
	Tue, 29 Sep 2026 16:38:49 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 746A740E0A
 for <dev@dpdk.org>; Tue, 29 Sep 2026 16:38:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790692728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gqo8xmBn7ovkV3jnFYnYKiXcw8dRwqaM+s7kmaTO53w=;
 b=I3XFEydfaZpE70xq3o34z3IewW7Abkw5/+KoAR4a9c0a1gYGk9AM92UpCwTd533qKTaYAT
 orS3c91Q5GcH85Y4fxNvGkgilQC+ZDHKSbNZkcDW4+SfxJdIM9VfVHFe0RxT8xV7FE01VN
 dei00iU5uSyrJB4EX539aWSLEwOl2kk=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-S842JFQ3PiaT2ZyoTcvHjA-1; Tue, 29 Sep 2026 10:38:44 -0400
X-MC-Unique: S842JFQ3PiaT2ZyoTcvHjA-1
X-Mimecast-MFC-AGG-ID: S842JFQ3PiaT2ZyoTcvHjA_1790692723
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5b8ee32b66aso2520454e87.0
 for <dev@dpdk.org>; Tue, 29 Sep 2026 07:38:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790692723; x=1791297523;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Gqo8xmBn7ovkV3jnFYnYKiXcw8dRwqaM+s7kmaTO53w=;
 b=DdHFCFXfUZ83yhb5efMK1VrT0s5Fm/W9q4svVwfJS7y2xp06k69+j49Kwm7SWznroe
 8y8KX+uV20yZZLEpziG1S/UTCxLKXSzMxA6GpltJegTBfywx4yyU7nKZPA7ccl5ZY6Gv
 a+PVx+Kc5jVEtklIc34aX+Pv6eZhUX/6SjVz2naZLggWnM3DiaaQOdVUNqX45/fxjmzk
 3ompWwGXK4FdAofAe4y1o7RdnRtFbSGgoG/XlJQhvSVxd+5c93OGclNo90RmoAMgQp0x
 u6KW33dbrO3ftlGtLZlv2o/aA+QLwV6uc4TMF4LqEm1edUA5wnKU1QhlxTNC0hTyPopl
 WBDQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxADSWI8tA8psiIP7kJfn9nJ+no8upH9LjMAziK29lNpLPt4YjwpQzOcckfNztifc7MeQQ=@dpdk.org
X-Gm-Message-State: AFq9FYIlJTsDZOY7KBLWaA7MrIzPuUmeyWi813eo1GeQOfevSqNI+eNq
 4IpzZftDtvFk5I61hTQwJdOkE3TEQkWcOtGYU+LMEK3pEnr1aMzQ9B8UlEwjNqyVAYTozi4fsjV
 fBq2+jvBU5GbgRch9j5VDPRVTTIVMMtiPMNpdxEVq1tVv3bBY3ntyOnwaijoslAO1qpky3iXfO+
 3bsMfqYeNIjh76Ydn14i8=
X-Gm-Gg: AYBFou1P+bOQ7dT8r1wym4MtEcFNAvGuGKwIsG3IPvHzbA1tXQ4MCSolbzHOM1mVsB7
 6PB3H+suevALpViPeN2ZBy22oacwulQVQ3on8whO/hPzGV9p4cCMB0CUbYEgsa1BX7zYQV4fFfL
 cDIiThDKf0a9a9NTzlq7Ifovs8MXHFV9W6nyJNPNjw5QVAtaqWSewINdlftnSDnNh6SHaC2ITDb
 fZ97yqNFn4co+kB0zlCPRyDMW/RvpJiQ1Py+9S5AY+BN1EU
X-Received: by 2002:a05:6512:3051:b0:5b8:fa05:e49c with SMTP id
 2adb3069b0e04-5b8fa05ef5bmr2241043e87.34.1790692722974; 
 Tue, 29 Sep 2026 07:38:42 -0700 (PDT)
X-Received: by 2002:a05:6512:3051:b0:5b8:fa05:e49c with SMTP id
 2adb3069b0e04-5b8fa05ef5bmr2241027e87.34.1790692722514; Tue, 29 Sep 2026
 07:38:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260929105339.1554051-1-eperezma@redhat.com>
 <20260929105339.1554051-2-eperezma@redhat.com>
In-Reply-To: <20260929105339.1554051-2-eperezma@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 29 Sep 2026 16:38:30 +0200
X-Gm-Features: AclHuK-nG0wGtLbyBRQ8niqVApMpbjOZ-tu9VBBoU44qSnJLofG7fIrxBgCZKm8
Message-ID: <CAJFAV8wCTo6Q2qfncJJPaBk6Gses9s+kERZJsSFbiy-G5k1Dow@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] uapi: import VDUSE and VFIO header from v7.3-rc5
 kernel
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: mst@redhat.com, dev@dpdk.org, Yongji Xie <xieyongji@bytedance.com>, 
 chenbox@nvidia.com, Bruce Richardson <bruce.richardson@intel.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, jasowangio@gmail.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 97kl8UZXYV5DwueaacK-BaBNWH0YrPsswN60TgtVrtI_1790692723
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

On Tue, 29 Sept 2026 at 12:53, Eugenio P=C3=A9rez <eperezma@redhat.com> wro=
te:
>
> This header will be used by the Vhost library.
>
> Including also uapi/linux/stddef.h, which defines __counted_by if the
> compiler does not support it.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Unfortunately, we still have a build issue, since linux/vfio.h
includes linux/types.h -> linux/posix_types.h -> linux/stddef.h.
So our local copy of stddef.h is ignored:
https://github.com/ovsrobot/dpdk/actions/runs/36559664854/job/109377193634#=
step:19:551

I tried to import both those headers, but I hit a guard for a non
sanitised linux/types.h header.

--- /usr/include/linux/types.h 2026-03-04 01:00:00.000000000 +0100
+++ kernel/linux/uapi/linux/types.h 2026-09-29 16:24:57.764056484 +0200
@@ -5,8 +5,13 @@
 #include <asm/types.h>

 #ifndef __ASSEMBLY__
+#ifndef __KERNEL__
+#ifndef __EXPORTED_HEADERS__
+#warning "Attempt to use kernel headers from user space, see
https://kernelnewbies.org/KernelHeaders"
+#endif /* __EXPORTED_HEADERS__ */
+#endif

-#include <linux/posix_types.h>
+#include <uapi/linux/posix_types.h>

 #ifdef __SIZEOF_INT128__
 typedef __signed__ __int128 __s128 __attribute__((aligned(16)));


We are missing an equivalent of scripts/unifdef -U__KERNEL__
-D__EXPORTED_HEADERS__ in the devtools/linux-uapi.sh script.


--=20
David Marchand

