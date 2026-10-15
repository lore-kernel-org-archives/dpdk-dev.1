Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10175CC6B3A
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 16:25:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 470A8402F0;
	Thu, 15 Oct 2026 18:25:34 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 349B8402DA
 for <dev@dpdk.org>; Thu, 15 Oct 2026 18:25:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792081532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XVmm6n4HP93P2mOW7S3bJzXG4rpgIs9BTYCk2zCMdw8=;
 b=Sjs/0Xkf/gfvZAmD8fptAXaKWPx/TSB+MOTTvh0eA7ZCgoJDSdoyXWJLwr63MeR+OShX9s
 JvhPGJd3vW83MqGRFtYmCcVqTbEHV1cjPjaaPoJYrSfdsAVxUv7SugKPCQ6wDYkuqW1m4/
 77f0we6xKoG1KVGSDBqqGaq5dKwC7x4=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-1woi2qpFOAmFxrYfUohBpQ-1; Thu, 15 Oct 2026 16:25:29 +0000
X-MC-Unique: 1woi2qpFOAmFxrYfUohBpQ-1
X-Mimecast-MFC-AGG-ID: 1woi2qpFOAmFxrYfUohBpQ_1792081527
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5bb78051100so1202326e87.3
 for <dev@dpdk.org>; Thu, 15 Oct 2026 09:25:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792081527; x=1792686327;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=XVmm6n4HP93P2mOW7S3bJzXG4rpgIs9BTYCk2zCMdw8=;
 b=ytKp6V6CBGXdmKCrnm8FqzNhMxGhS9sT3Pk0TlqIoKj+q4cBpf+Coa0fJZlPdv6e2X
 5TfNX6ROefmq91R5jV5ZVWgdHcMWFngRudZM1mPZ/a2kY8GDnmCFCHzEw4hk4O+1N4ls
 /I4pUOFoAuRkR3QYQc0/bAFbBwXAckT+UVEje2kyy8JkPeMhmoyYNo+mA0dRyQhLuvy7
 DPOiku+iZaWb6+KHwkRpwQXpv1Q+0EhpAk4d3zk92Ut/2KswATRh+/cGuF1dl+Es+v3z
 sNSrIJy/2PIE83JPxJAUpK/FB0rgC8FlI0rO0/v+GKY38pZtYhS/ZOg3UvROeiwS8ZBr
 Kv+Q==
X-Gm-Message-State: AFq9FYIyzlKl/BjFVleB6ephhcRBu2sD8S8ghnJYBnFR+l98IhgLKUE2
 lxii9FpUZBB98tJiMqfPeUtJz4BvMN5uE8piqyy8vNVWE3PLEWDfW6KNomNA0HcybRwaCLUcDF8
 rK+XlXaRMm/5XrUBrSQ3m4x7OZuCx86gXr3ytjH+7TzIPXRHFTjEHrFQQH9m85l24/Ky0QDfaZm
 ne0wqYWx1KoyEQTrPzyZM=
X-Gm-Gg: AYBFou33KlfQDBSnE8VtnxLkUVGCaKZyYA80IV78UYDPWxgJ1AAYylhOj/65FLJz9HJ
 S5eqcUSPy+TuygiIRgnMt2NJdykcNjvfoZogzWz7bn84eU9sXbETelAKAJlmp3PdwuwB85SZvtB
 /q+sETo6CylgsWxx0NB/ELmMQ8P//LnACWl5OWU86Rizx3Sh06OPT1HLhJgdZ7zz+MJnykEeQeY
 3q5B4RutBc7ykcReruTdZCmwnMdm96oD8QlR+wxKNg1mp4r
X-Received: by 2002:a05:6512:3a82:b0:5be:4684:d027 with SMTP id
 2adb3069b0e04-5be4684d1d5mr425049e87.12.1792081527350; 
 Thu, 15 Oct 2026 09:25:27 -0700 (PDT)
X-Received: by 2002:a05:6512:3a82:b0:5be:4684:d027 with SMTP id
 2adb3069b0e04-5be4684d1d5mr425040e87.12.1792081526829; Thu, 15 Oct 2026
 09:25:26 -0700 (PDT)
MIME-Version: 1.0
References: <20261015160157.3348253-1-david.marchand@redhat.com>
 <DM5JUAJZOBD1.1MJUHEI3YCXCO@redhat.com>
In-Reply-To: <DM5JUAJZOBD1.1MJUHEI3YCXCO@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 15 Oct 2026 18:25:12 +0200
X-Gm-Features: AclHuK9tAMKOJbUC-gf_xZcBJm7iECb54IyLEfBTaVKDgsquEsqX8s9dI8RCoeA
Message-ID: <CAJFAV8zTVFEwzDrbOt9NLd8QjYNgFw2HEWQz_h=CKVnwaXkMgw@mail.gmail.com>
Subject: Re: [PATCH] ci: fix dependency on cmdline
To: Robin Jarry <rjarry@redhat.com>
Cc: dev@dpdk.org, thomas@monjalon.net, Aaron Conole <aconole@redhat.com>, 
 Bruce Richardson <bruce.richardson@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _K5cE2KF35I-m55y9ArTmvVM_MbHbJQ2iZbug2pWRms_1792081527
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

On Thu, 15 Oct 2026 at 18:23, Robin Jarry <rjarry@redhat.com> wrote:
>
> David Marchand, Oct 15, 2026 at 18:01:
> > The unit tests, testpmd and some examples depend on the cmdline library.
> > Without it, the "mini" target in GHA ends up as a build failure.
> >
> > Fixes: 6de2c9c791b8 ("build: make cmdline optional")
> >
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > ---
> >  .ci/linux-build.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/.ci/linux-build.sh b/.ci/linux-build.sh
> > index 4f266940e9..2c7386d320 100755
> > --- a/.ci/linux-build.sh
> > +++ b/.ci/linux-build.sh
> > @@ -120,7 +120,7 @@ else
> >  fi
> >  if [ "$MINI" = "true" ]; then
> >      OPTS="$OPTS -Denable_drivers=net/null"
> > -    OPTS="$OPTS -Ddisable_libs=*"
> > +    OPTS="$OPTS -Denable_libs=cmdline"
> >      if [ "$DEF_LIB" = "static" ]; then
> >          OPTS="$OPTS -Dexamples=l2fwd"
>
> Why aren't the per-target dependencies honored?

Examples have hardcoded dependencies see examples/meson.build.
Since the mini target explicitly requests l2fwd, this triggers an error.


-- 
David Marchand

