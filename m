Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6B3F33A62
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Mar 2026 13:53:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B05640A7D;
	Thu,  5 Mar 2026 14:53:13 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 5BE6A40A70
 for <dev@dpdk.org>; Thu,  5 Mar 2026 14:53:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772718791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=prNeU5ubmT58+h0mxTx5E7KcsFWv+Vfqc4FqqpeI3B0=;
 b=U57PAr2QEzhXDvrJe2zAvWAFcrWOME5yd2fm++ePGOdTMk8LlZ0vovgxyLdnGrr7tyrge+
 ryairzy1mMt2IJ+0vdpTIsT8uWIyVtAKyfvod9L4LS7VUg7pWXCQlOOtWVZvqYk/woJP2R
 IanYfpnpHG7kS4uIRYpWZKQYrbgTiRY=
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-pGIA-IP6MTGRK8vuZLL7bw-1; Thu, 05 Mar 2026 08:53:10 -0500
X-MC-Unique: pGIA-IP6MTGRK8vuZLL7bw-1
X-Mimecast-MFC-AGG-ID: pGIA-IP6MTGRK8vuZLL7bw_1772718789
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2be07cafe1cso62588337eec.0
 for <dev@dpdk.org>; Thu, 05 Mar 2026 05:53:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772718789; x=1773323589;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=prNeU5ubmT58+h0mxTx5E7KcsFWv+Vfqc4FqqpeI3B0=;
 b=ihS4eU21YKLSYjc/d7RTHMttTp/5BZKSZuNbT/SQUD8/OKQ+z/Nz616vWhlfvQ+Ytq
 NGh13ILVlYZLsBXvVUWYDh/o4xPW4njMy1lHDSzkhpihGoUB8fbNUB6eTmSZmO55WdtQ
 0Nr7FcLNcojCVa0zEVTV4GwHrEbhU757th8t+bU8mMlVO6qQ4i1RbGrmPwZcyDye4Vlz
 OBrpLhRflDF11I38cdcM8KM4KBx+Q4UOKjL8vg1We53LjA56zp8QJDGJci4CJXa6o3Ej
 jKtUJOht1G5+f2Lwhx1YNdjbU6dZjfEzTbe/AFJbDucwu04uYOi7WPuXLc4oEq0zDDnp
 ZC8A==
X-Gm-Message-State: AOJu0YySseVqdebeyjy94uPNJBw4OKmSCGQRT60+0mKFtKKQORNTwmjO
 dpVpgyNnayW8br6fFWtq4TglumaGKJPWAfF+9d5MvL+RVz4dHNFu1+jM0OJxVdxhuQfsS685wI1
 Tj1fcO9YK5F1ZoyHB1vFmlMGIzBYfoXzKrWxNoKlkVhRTo6fqlteKEsHRGkBZ7jrwsrjdxMZuA0
 sHmrW1hqzAt/ehFdftbV8=
X-Gm-Gg: ATEYQzzUJrrzwDl6NkmCK/LI9FfOg8NY2bxwRJyb7OadmUZLu0whlopD46/Vgy6BFpA
 EOV1QABM3XLnELx7hT2f7NOciPhMxi0b4bcejJDPdSVUyAKZucpKKCLXKWPu5T7pXR7UXhAj4ak
 SlBvX7quMa7sbhPiiC3FONlOQoVGMd2ym/Nrsqg5bZjZ+IEUcjWlhukrUeJeCb/IqRSPtAmwPR/
 3Kk7QnICqVrnjcOvJJyerO2CURUtxCpyXVSJDTtZOQRi3xFq/sYdL/QzBt3N78GfQ==
X-Received: by 2002:a05:7301:1005:b0:2b7:24fc:f638 with SMTP id
 5a478bee46e88-2be30d8824cmr2227040eec.0.1772718787950; 
 Thu, 05 Mar 2026 05:53:07 -0800 (PST)
X-Received: by 2002:a05:7301:1005:b0:2b7:24fc:f638 with SMTP id
 5a478bee46e88-2be30d8824cmr2227028eec.0.1772718787242; Thu, 05 Mar 2026
 05:53:07 -0800 (PST)
MIME-Version: 1.0
References: <CAJFAV8yjTs8inmZqYyPrTubc_oaKfEi=nv_58HzyXf9f+pPg0Q@mail.gmail.com>
 <20260218090540.89215-1-malikovyehor@gmail.com>
 <CAO55csy_NCvfjRdPQ7B8Ke6zx1FX3oC6PX-wF4Ujv-RxsYBfnQ@mail.gmail.com>
In-Reply-To: <CAO55csy_NCvfjRdPQ7B8Ke6zx1FX3oC6PX-wF4Ujv-RxsYBfnQ@mail.gmail.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Thu, 5 Mar 2026 14:52:56 +0100
X-Gm-Features: AaiRm51Rlsf5dyVn9dgnPjJvlIZdvsYyb6CyKA2jzgF7QKatFmsAd3oOZFOmca8
Message-ID: <CAO55csxQxdDjNYvS94yNu8qEy0GJ_OSCyX8yRNgE1YQkH7u2Cw@mail.gmail.com>
Subject: Re: [PATCH v12] vhost: fix use-after-free in fdset during shutdown
To: Yehor Malikov <malikovyehor@gmail.com>
Cc: dev@dpdk.org, david.marchand@redhat.com, chenbox@nvidia.com, 
 stephen@networkplumber.org, Yehor Malikov <Yehor.Malikov@solidigm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: evpr6Rt9jrn02n1npsxbTQQbvcSpFaI5eHtmxmKnWug_1772718789
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

Applied to next-virtio/for-next-net.

Please note that I had to solve a trivial build issue due another
other patch from Shani I applied just before.
Feel free to check my branch to confirm this is OK to you.

Thanks,
Maxime

On Thu, Mar 5, 2026 at 11:50=E2=80=AFAM Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
> On Wed, Feb 18, 2026 at 10:05=E2=80=AFAM Yehor Malikov <malikovyehor@gmai=
l.com> wrote:
> >
> > From: Yehor Malikov <Yehor.Malikov@solidigm.com>
> >
> > The fdset_event_dispatch thread runs in a loop checking the destroy
> > flag after each epoll_wait iteration. During process exit,
> > rte_eal_cleanup() frees hugepage memory while the fdset thread is
> > still running. Since the fdset structure was allocated with
> > rte_zmalloc() (hugepage-backed), accessing it after rte_eal_cleanup()
> > causes use-after-free.
> >
> > Switch fdset allocation from rte_zmalloc/rte_free to libc
> > calloc/free. The fdset is a control-path structure that does not
> > need hugepage memory. Using libc allocation ensures the fdset
> > remains valid after rte_eal_cleanup() releases hugepages.
> >
> > Fixes: e68a6feaa3b3 ("vhost: improve fdset initialization")
> >
> > Signed-off-by: Yehor Malikov <Yehor.Malikov@solidigm.com>
> > ---
> >  .mailmap           | 1 +
> >  lib/vhost/fd_man.c | 6 +++---
> >  2 files changed, 4 insertions(+), 3 deletions(-)
> >
>
> Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>
>
> Thanks,
> Maxime

