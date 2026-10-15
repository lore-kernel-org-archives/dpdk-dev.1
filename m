Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17603CC6B39
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 16:23:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2A6D7402DF;
	Thu, 15 Oct 2026 18:23:37 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id C0FE4402DA
 for <dev@dpdk.org>; Thu, 15 Oct 2026 18:23:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792081415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DVxwU4zOF2tQ7YYA7RwpSXBK6bPQIRW7HqoxuljO8Pg=;
 b=VLKcD1JxgU1GMgPaclgYyllia167/HTmQ6wddlM0zpbvzZGVt/Tzwk7W68vROfYEMSlavF
 /UYR8L0gEh1ad9UWl++Rw32yhPxxOoGtSkss+d2NUC2c3qY7elipL1cWEY3e6re7mVBjGn
 BEWuI1Dm2eNKdtIsJVUKzAOImYexxa4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-G_Ua7xK6NeW0uOaj2hpBeQ-1; Thu, 15 Oct 2026 16:23:33 +0000
X-MC-Unique: G_Ua7xK6NeW0uOaj2hpBeQ-1
X-Mimecast-MFC-AGG-ID: G_Ua7xK6NeW0uOaj2hpBeQ_1792081412
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4a16db51147so36546175e9.3
 for <dev@dpdk.org>; Thu, 15 Oct 2026 09:23:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792081412; x=1792686212;
 h=in-reply-to:references:user-agent:subject:to:from:cc:message-id
 :date:content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DVxwU4zOF2tQ7YYA7RwpSXBK6bPQIRW7HqoxuljO8Pg=;
 b=JV1B8QE/JKBly2cueuQOQZS2T6CRPA9nCR8oRQSbaD0mQ4rDtBPMZKopNUVTycoQFf
 FTYrIRNrfN7E6XUN8glpYi6n5eYc5Vrgky+t4m9dU0psyIDRbeDkJUsR21MaIAIdhi50
 /DDYCHFDantSIeXleSVXbi9WlZ2ZJuARfyKRfDR78EowUtRkYFEzsXoQFxqYzmy5/80k
 CDsuC+MVNfE24bikB+nwtprH6sNGdBiFBVprDAlOBzzEXmGoEvmGI+xMs7jxCfWAtUT2
 8IZ7HDqdysWP6IpxUfE/HQ0l5yPbr5iu81XPaDbGo6LInszgvfl7VC29GVEcd54A0GK4
 gocw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzPs3HSdVwuDb0v/j9ZGgymLaR5DsXfzVSJat5inRpj2HAkOFLXIpg82lvnDlf8TxZ+l28=@dpdk.org
X-Gm-Message-State: AFq9FYIhmiGwX3c5XC/WC+X5+frlLzG+6fOExrmioQ3AOx9v2KBZ8JlZ
 t40HrIx6xSAT9UxvRq0/fN57bRYNCUv+uRPcZRKZ8wnQ1hE7MLUaMckNOL9Jz3ZsEGyaVkHzwrF
 NVnZu09cvnUPKYPkamDKrMKSdKc5zr7KHtVZv8n6XRRNd
X-Gm-Gg: AYBFou2xQg8ayARQrr5Ss+52pSnFRmC2COzI+g8Vqr/qKTUc5bFVsEm+v7DwbshEN4x
 m+CSz2adnKdI2jBSkXqep/cEPctGi2GPl8eQ4xBRoH6PRkxF+f61+bkdvspbiNIFmo/4F+FPuu3
 TZmbeIbPFBlXHnQnDFzEcDx92UTrnjkNUg2YCxj+8ulvSqVmfQwU2tBPmnKwocr/PWgwxGm42+T
 Y7IJWClkbHGUA+8vZ0M65h/W1UKLsbPVt8ojYExHhTgDlPTLZKbCbvUh5aUG1IYXewskVJSzWv2
 AlPuFNCqii0W5XJ8uvu6FQ0IfeVGSTY9g9Pzkr3KmOK6AZtebzuH9O4KrPTxDGcsJrEW8nogZPM
 k7PtsERlxUuXYF1A1e6rubcombmVfQfFLEjkt+XnD3z/DejEu/bqlveQI
X-Received: by 2002:a05:600c:524d:b0:4a1:80d8:aeb3 with SMTP id
 5b1f17b1804b1-4a18e4a95c2mr395957565e9.12.1792081412354; 
 Thu, 15 Oct 2026 09:23:32 -0700 (PDT)
X-Received: by 2002:a05:600c:524d:b0:4a1:80d8:aeb3 with SMTP id
 5b1f17b1804b1-4a18e4a95c2mr395956075e9.12.1792081411377; 
 Thu, 15 Oct 2026 09:23:31 -0700 (PDT)
Received: from localhost (2a01cb00021ec0002e23edbec21b0e73.ipv6.abo.wanadoo.fr.
 [2a01:cb00:21e:c000:2e23:edbe:c21b:e73])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd972aebsm90439015e9.1.2026.10.15.09.23.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 09:23:30 -0700 (PDT)
Mime-Version: 1.0
Date: Thu, 15 Oct 2026 18:23:30 +0200
Message-Id: <DM5JUAJZOBD1.1MJUHEI3YCXCO@redhat.com>
Cc: <thomas@monjalon.net>, "Aaron Conole" <aconole@redhat.com>, "Bruce
 Richardson" <bruce.richardson@intel.com>
From: "Robin Jarry" <rjarry@redhat.com>
To: "David Marchand" <david.marchand@redhat.com>, <dev@dpdk.org>
Subject: Re: [PATCH] ci: fix dependency on cmdline
User-Agent: aerc/0.22.0-33-gba1d070bca97
References: <20261015160157.3348253-1-david.marchand@redhat.com>
In-Reply-To: <20261015160157.3348253-1-david.marchand@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0rybwK6If_qKR21l3Bkxqq4_d_oApuQrmszGccE_-H0_1792081412
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8; format=flowed
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

David Marchand, Oct 15, 2026 at 18:01:
> The unit tests, testpmd and some examples depend on the cmdline library.
> Without it, the "mini" target in GHA ends up as a build failure.
>
> Fixes: 6de2c9c791b8 ("build: make cmdline optional")
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
>  .ci/linux-build.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/.ci/linux-build.sh b/.ci/linux-build.sh
> index 4f266940e9..2c7386d320 100755
> --- a/.ci/linux-build.sh
> +++ b/.ci/linux-build.sh
> @@ -120,7 +120,7 @@ else
>  fi
>  if [ "$MINI" =3D "true" ]; then
>      OPTS=3D"$OPTS -Denable_drivers=3Dnet/null"
> -    OPTS=3D"$OPTS -Ddisable_libs=3D*"
> +    OPTS=3D"$OPTS -Denable_libs=3Dcmdline"
>      if [ "$DEF_LIB" =3D "static" ]; then
>          OPTS=3D"$OPTS -Dexamples=3Dl2fwd"

Why aren't the per-target dependencies honored?

--=20
Robin

# At participating locations only.

