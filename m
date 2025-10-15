Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD42CCD193
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 11:45:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E24D54066F;
	Wed, 15 Oct 2025 13:45:53 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 5137040276
 for <dev@dpdk.org>; Wed, 15 Oct 2025 13:45:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760528751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r7lC/EJuz9t6WvbNJCuAvun4U27aySSl2ERVrYUXrAM=;
 b=Spc4z32oJE/HaR1Fv+7AMRhK04H3vBcMQa1Cq/++VhfT0zmDi6+OXhW9nnNxtUWJmsh5rb
 veaGET+ndu4kCR/1l4+864EsnOB6mppxEoaX6/PRPkx/Thp89SiemecDR1/YgsHsASOkiC
 laS3O8/2Rje+I7L/ToBYh2n5fVP3BNY=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-VrCUdi7DOQS238LVxro8rQ-1; Wed, 15 Oct 2025 07:45:50 -0400
X-MC-Unique: VrCUdi7DOQS238LVxro8rQ-1
X-Mimecast-MFC-AGG-ID: VrCUdi7DOQS238LVxro8rQ_1760528749
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-585b4444460so3811123e87.3
 for <dev@dpdk.org>; Wed, 15 Oct 2025 04:45:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760528749; x=1761133549;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r7lC/EJuz9t6WvbNJCuAvun4U27aySSl2ERVrYUXrAM=;
 b=CT3Q7HD4o/V2pvs8ix8NcCWtaEaCG5RXQJENjh2VTw3qSKB+Ig/xVT8/l7TLGtPiS6
 3wMMRiYVTm1ytGtuuPNWQrNpUB0Xx/29+alGbRNlLKTQv9xawS2cAt+8j8kZijW4xBAJ
 mBzmX+JQkUx87krYnNSQ8j+gE0QBHKWK6luwQv7cRaJ9fz3C3Dqg/ihaNL8/dtneEOLk
 bbfMhiBFjERcJsIKxgj6Md5tMG8Vo6P/yWV9CZXrSaflNPOhXzGM3j2z3W5ih2WDfGpO
 yF2jns3dhH1rJUarIZPp5GNIrWTat1mATM1+2hKmgSyFaPDHoTBhIIJ7PLDDOcqyQx3+
 bOjA==
X-Gm-Message-State: AOJu0YwJ/1cyUCqVpfskr+b6Pe9CM9+xTDx21xuOOe4aRPyu/Yo8QzO2
 KN+NcLW8H7qo4fUSd5EuLHaG3KNJhS8dGeutso3L07k/Y+h+IESzJHfB+6YFUakWwjBp2p2mOEC
 4eGp9NlvG2WZxzWhpZUX1Yy4k8CnQSMZKyHNY8Xa4NPa5u7UsotDnRSE5iDrDI8H8nC+7z3Ul2F
 3/RyVbdXVqGlYQUfhMI3A=
X-Gm-Gg: ASbGnctFBBo0qY27z0LAmnBhL7/5Ph6lXTkB8X98Z0wK0yIODUe3Qa8HryVOF57eZXX
 Dsx3MLBri3hk+x3AFXNEFfP604jx6+z07N5CeYZ6qYgJ2lbcVpu7RrgkcwS4dXdouVFpJGt1k1x
 mpDRFapbyLFtX97WiA4/0=
X-Received: by 2002:a05:6512:318b:b0:57d:d62e:b205 with SMTP id
 2adb3069b0e04-5906dc0fd8emr7694495e87.18.1760528748774; 
 Wed, 15 Oct 2025 04:45:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIvUjGrJVI8Xo/pBsnYPXk6tww6XGl/aIDK+w7gmdFLCGqlGFsseEHGXZ3yfbeHtgtZSMjnJlZemaQwQD0+uc=
X-Received: by 2002:a05:6512:318b:b0:57d:d62e:b205 with SMTP id
 2adb3069b0e04-5906dc0fd8emr7694486e87.18.1760528748383; Wed, 15 Oct 2025
 04:45:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250619115445.257679-1-hengqi.chen@gmail.com>
 <CAEyhmHRs6mwW-uc8XzK6HKRNn8ZnyMrpiBsQE7fdSsMuhxqrUA@mail.gmail.com>
In-Reply-To: <CAEyhmHRs6mwW-uc8XzK6HKRNn8ZnyMrpiBsQE7fdSsMuhxqrUA@mail.gmail.com>
From: Maxime Coquelin <mcoqueli@redhat.com>
Date: Wed, 15 Oct 2025 13:45:37 +0200
X-Gm-Features: AS18NWA-vJxGv1FSFuPu6l6HLBXS5cnGKVDbFkojSY9MjWSPWYHt8kbtSe61nbg
Message-ID: <CAO55csyBWv=w5AuAP1DGR=TtzUfW8wv0qCPgVZ-Mso7h4y=UGA@mail.gmail.com>
Subject: Re: [PATCH] net/virtio: Implement {rxq,txq}_info_get callbacks
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: dev@dpdk.org, Maxime Coquelin <maxime.coquelin@redhat.com>, 
 Chenbo Xia <chenbox@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ibhJk8YENQOTfmKPUwNn8Oqm5unb1Egj6-JQPzZekA8_1760528749
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

On Wed, Jul 2, 2025 at 2:17=E2=80=AFPM Hengqi Chen <hengqi.chen@gmail.com> =
wrote:
>
> Hi Maxime, Chenbo,
>
> Gentle ping on this. Does this change make sense ?
>
> On Thu, Jun 19, 2025 at 7:55=E2=80=AFPM Hengqi Chen <hengqi.chen@gmail.co=
m> wrote:
> >
> > Currently, there are no ways to retrieve the queue size
> > set by vhost backend. Implement the {rxq,txq}_info_get
> > callbacks so that DPDK applications can use the queue
> > size to setup mempool properly.
> >
> > Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> > ---
> >  drivers/net/virtio/virtio_ethdev.c | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >
Applied to next-virtio/for-next-net.

Thanks,
Maxime

