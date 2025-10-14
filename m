Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FED3CCD192
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 13:26:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 90AEB402A8;
	Tue, 14 Oct 2025 15:26:48 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 99B66402A8
 for <dev@dpdk.org>; Tue, 14 Oct 2025 15:26:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760448406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YGSxrAI5rhRL63uxSK0s7hU0r3GRnGXhBm7zgxD4owY=;
 b=AlN4nYZg4cthbnHaG7Pi2GspeuJGPtQ006vAtkCMuKMB8QJmyMX2drRYy7ip+VPySYXd+1
 b/rEnNS/iXdZpYx2HN4X6/oclkIpZCiPY02wfaRBIKUEXZByVuiQN2qS9JBO6osshKZjlC
 hvUe+lqCLdeCJRhvxipZbtX/faz4XZo=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-M9qdOsnjMgqILSWlCBsvhw-1; Tue, 14 Oct 2025 09:26:44 -0400
X-MC-Unique: M9qdOsnjMgqILSWlCBsvhw-1
X-Mimecast-MFC-AGG-ID: M9qdOsnjMgqILSWlCBsvhw_1760448403
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-58afd11b4d4so2420120e87.2
 for <dev@dpdk.org>; Tue, 14 Oct 2025 06:26:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760448403; x=1761053203;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YGSxrAI5rhRL63uxSK0s7hU0r3GRnGXhBm7zgxD4owY=;
 b=U/1btPu7lT13pLpP2kv0GZcqg4za52bfFO01S3sgYXQ9V2qvLDXLCYZ5VXoASv51u1
 HOcWfxbhf6XDUtVcAETlWbrSrGZtUFCrwKDrNKBHSnXUvV6fNGmsvkDLgKmf/mGurs1H
 3mTU+fSCRBQ8HhigBh3P9yNZ1kAPu8N7FnD63H6nmCUt3BRXARyiw/xSNxIjRfofL2yv
 mpPEo1jlJMc8J5BrjJKSPaepH5JA+cWiEnPnZdIzMHTuuc/q6kr5qP1ebNjLGXD8dhJi
 7eipuBo3gf8AuxJFLxKorzegXUAPzKf82ZJYM2egjQzhJVvet1NZSuEW8EWvO9EvCBWJ
 3p1g==
X-Gm-Message-State: AOJu0YyCa470gTFGcEVriX+k8tJLkTVFr1bQDHHBHXM+t+PlMRD3bJsd
 h2saeRevZBGy3WJNvWUs8Jr4oe36hv5jlzvqx9jh87ZHgMpN1ka78DLJg1x5X4y0B4d4Grk3ce2
 kezYavLd4lmC4xldePaDMml2WqCJW6ayUsHcZzQN+TCt1QvK6QZjMpfEuaFIZaLpmZ653L+C9f6
 ArWFO/jbDjzBzrGiEcvkk=
X-Gm-Gg: ASbGnctuKVl+ZRI8v/DXzclRn+ygyfjS2OsKp3vGADXnnPW5nzzBuTtZLI7k1T/coeS
 QvyiIJCQcm4I7YTrZ8sr172L/pDj+VCFuhLhC3cYvv7NrECesEhfqDlkYp0jY4aCRyUG6JYfsNV
 PZEeduI1KXzqcO9iEnYhE=
X-Received: by 2002:a05:6512:104b:b0:590:651b:10e1 with SMTP id
 2adb3069b0e04-5906d9e8a49mr7269527e87.44.1760448403166; 
 Tue, 14 Oct 2025 06:26:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEuM2SuiD+yN6ROmjE0K4cO4SlcCxN7yQP0l80QVJckTX3IQylgw0ptY6wMgWZKxbn06JK2O6nLqdpK3H8tiY=
X-Received: by 2002:a05:6512:104b:b0:590:651b:10e1 with SMTP id
 2adb3069b0e04-5906d9e8a49mr7269505e87.44.1760448402542; Tue, 14 Oct 2025
 06:26:42 -0700 (PDT)
MIME-Version: 1.0
References: <20251007144754.1690606-1-maxime.coquelin@redhat.com>
In-Reply-To: <20251007144754.1690606-1-maxime.coquelin@redhat.com>
From: Maxime Coquelin <mcoqueli@redhat.com>
Date: Tue, 14 Oct 2025 15:26:31 +0200
X-Gm-Features: AS18NWAlTHTX7Stl3CbpT8j2PVrhpydu2gOY98z_NwubqoAs_eeMZTMD2eyjZUA
Message-ID: <CAO55csw=uoafrhp-dzGW8ty_ZDjMQ8OAttBH7wx-QGifzYXA+w@mail.gmail.com>
Subject: Re: [PATCH v2] net/virtio-user: fix used ring address calculation
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: dev@dpdk.org, amorenoz@redhat.com, david.marchand@redhat.com, 
 chenbox@nvidia.com, stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HxL5gBTmgYuN4s_Sh_ye1EfNXAPBK_LeSQlAfK_YbJc_1760448403
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

On Tue, Oct 7, 2025 at 4:48=E2=80=AFPM Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
> This patch fixes the used ring address calculation, to
> avoid Vhost-vDPA backends (such as VDUSE) to fail while
> trying to translate it.
>
> Fixes: 666ef294ddf7 ("net/virtio-user: share descriptor IOVA to backend")
> Cc: stable@dpdk.org
>
> Reported-by: Adrian Moreno <amorenoz@redhat.com>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> ---
>
> Changes in v2:
> - Refactor addresses calculation (David)
>
> ---
>
>
>  .../net/virtio/virtio_user/virtio_user_dev.c  | 30 ++++++++-----------
>  1 file changed, 13 insertions(+), 17 deletions(-)
>

Adding David's Ack as the only change I did was adding his suggestion
(and I checked with him):
Acked-by: David Marchand <david.marchand@redhat.com>

Thanks,
Maxime

