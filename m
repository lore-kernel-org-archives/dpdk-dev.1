Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 925C4D19517
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Jan 2026 19:37:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7A379402AB;
	Mon, 26 Jan 2026 20:37:44 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 51187402A0
 for <dev@dpdk.org>; Mon, 26 Jan 2026 20:37:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769456262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sXr+y6/R4KNLsfzPMqkVmGzDra5pGvJdEFxNRMrDVRs=;
 b=C1hv1jFvRh8Is7p9sOUASQ4eG7S6cMM4sKcTuasl40sk/PNtdX8sK0YQ2BREVATqU+dEPn
 Fk2L/1TOfj6fadVio0NeBf/7qfNU9wMugiGTJVec5ebymihpwnfQ0Tm+4AGffU72dDmuwo
 r39oIxszhruwq3iQNr9SB+z6K+56ypU=
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-BeAOa_D4PQyjjPzBUb8pmA-1; Mon, 26 Jan 2026 14:37:41 -0500
X-MC-Unique: BeAOa_D4PQyjjPzBUb8pmA-1
X-Mimecast-MFC-AGG-ID: BeAOa_D4PQyjjPzBUb8pmA_1769456260
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2b6f0b345e3so22390538eec.0
 for <dev@dpdk.org>; Mon, 26 Jan 2026 11:37:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769456260; x=1770061060;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sXr+y6/R4KNLsfzPMqkVmGzDra5pGvJdEFxNRMrDVRs=;
 b=kaYwlyZs4aeg0kIbltb5dITDDU/GiceVDstOyDK1eya98eJo5pVhsk2ZVhsB+CjseS
 sje8N1YOuE1PL+Mce5eauovS5hswsMtroxCiXJ0mLeeECVUQHVC2CL7hGhSZf2gQ0P5X
 rSjHGPpGgdsIZXvXegDfY2o6Oiantq3jaSNmC0uM7RK835tMu2ZrK1maWJ8fzAwTsp0D
 MHZ6FBgu0arJp+Q7P4o8Ez75Aoy4UX/l1v8Dk/mNSUNlma7T9fU/VIEyzJFYII0FzHyD
 IGzBT8udRRC+TZ20OTRadqoO97swcbf7CNxvYbhOSV+yC8zmiET65ydhXoMvQhzBbEOP
 eJoQ==
X-Gm-Message-State: AOJu0YyaLcifhfizjNwlKfV+RynIqKFxPF65p6lGEYA2q6Gh8QqVyLxz
 CZ1EGJjM154imWwE9h5nd8V4L0h3Q/HTDGh0bdRlPFqlGEgbLvGfVfMHA1RkaTMwYyzP6lkeG7h
 QLZnzay1yJ51m+rqrfMl5+lwGTA0BwihfnVBKftSFD+HP1XTgC1E/HiEmShq38yapBB/GditxM2
 l/ObI2NaP1tCjE9w/+J99u7txfs6w=
X-Gm-Gg: AZuq6aK3kbZ4DCiyh0/kMOdJ/vA53f7NHE7xZm+ZfeD0+blVi9hf7KZKDyphVqebN9n
 qSOMQfMJQ3OXviuwrJic4rbo3vLHbXX34JQcy1hoHsi0+6HcFPmUIt9hAJUVk2EH/5MtQ3hIU7P
 E9/kO33Y+Zgwm5r6FsKPp+wiTCKqKrwZ9lNq/HNQHkpX9F4QgI1WZlWcBI2/QYOsctclnCLDzJN
 1HA9/xrqEN54UeiXe8vHx6vIqsm2GWyHUSa8CoKdGWqa/ZXllDXpw==
X-Received: by 2002:a05:701b:2206:b0:11b:9386:825c with SMTP id
 a92af1059eb24-1248ec6efadmr2426677c88.41.1769456259724; 
 Mon, 26 Jan 2026 11:37:39 -0800 (PST)
X-Received: by 2002:a05:701b:2206:b0:11b:9386:825c with SMTP id
 a92af1059eb24-1248ec6efadmr2426661c88.41.1769456259216; Mon, 26 Jan 2026
 11:37:39 -0800 (PST)
MIME-Version: 1.0
References: <20260114153445.2751895-1-maxime.coquelin@redhat.com>
In-Reply-To: <20260114153445.2751895-1-maxime.coquelin@redhat.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Mon, 26 Jan 2026 20:37:28 +0100
X-Gm-Features: AZwV_QiIHYU2FsyOT8vUVzywfTYai9Cd4iXtzEB1-1ux4NtM9lkBcRsLiTD2sZ0
Message-ID: <CAO55csxgmhXh96By4uA1FBZ0dV3JeoMsahBr_sq7DdL5dhRZdA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] vhost: VDUSE-related fixes
To: dev@dpdk.org, chenbox@nvidia.com, david.marchand@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9uEfk1rBA4BBnJ-Hc3I5FTCE8zV1Y5ReGelwWFoR40E_1769456260
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

On Wed, Jan 14, 2026 at 4:34=E2=80=AFPM Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
> This series contains 3 fixes for issues spotted by Claude Code.
>
> The first one is to avoid out-of-bound accesses in virtqueues array
> in the case we have the maximum supported queue pairs and control queue.
>
> Second one is a security issue that could result in theory in a denial
> of service, but a CVE was not created because the control queue support
> cannot currently be negotiated with the Kernel VDUSE driver.
>
> Last patch is fixing mmap error handling in the VDUSE IOTLB miss handler.
>
> Maxime Coquelin (3):
>   vhost: fix virtqueue array size for control queue
>   vhost: fix descriptor chain bounds check in control queue
>   vhost: fix mmap error check in VDUSE IOTLB miss handler
>
> Changes in v2:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> - use post-increment for readability and consistency.
>
>  lib/vhost/vduse.c           |  5 +++--
>  lib/vhost/vhost.h           |  5 +++--
>  lib/vhost/virtio_net_ctrl.c | 22 ++++++++++++++++++++--
>  3 files changed, 26 insertions(+), 6 deletions(-)
>
> --
> 2.52.0
>

Applied to next-virtio/for-next-net.

Thanks,
Maxime

