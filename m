Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E49CCF2E3
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 14:06:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6B21740297;
	Mon, 19 Oct 2026 16:06:31 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 842384028E
 for <dev@dpdk.org>; Mon, 19 Oct 2026 16:06:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792418789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IMnpO1C77q+VALRtGu45plkI+bizhEfxcDP41eA2vFY=;
 b=caCD7GP0vBvgkf+5p16jUgzGIkV5VsPXGTdnkZP7QQF04STr6VRDAWnniVwdbcXbDkf3Pe
 hVKaxocLH5x3cTbYdRvdFr/24JyEavALlk7wfET9m0nSpfLszPg5aCko/GpuYmrYeF6Da+
 D0bQQUS1ClqYfV5IiE3t2cIKwxyaHQo=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-HAKr0c3oODydOcgn-Y3Xww-1; Mon, 19 Oct 2026 14:06:28 +0000
X-MC-Unique: HAKr0c3oODydOcgn-Y3Xww-1
X-Mimecast-MFC-AGG-ID: HAKr0c3oODydOcgn-Y3Xww_1792418787
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-3ab36a71c66so7326161fa.1
 for <dev@dpdk.org>; Mon, 19 Oct 2026 07:06:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792418787; x=1793023587;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IMnpO1C77q+VALRtGu45plkI+bizhEfxcDP41eA2vFY=;
 b=zuTpR9x+IblIZJIry02RC+JTrl5nFPGRkHWWPhkLaET+Yp1zbgoNLYuodmz0YjKKOl
 wgpq24Z6cBh1qEEcZTSaAxrB/TJyXmv0ycYSRE2mAxoowf1tGqYhuPAsGgEZxNyfzKUK
 s34tBKOvpRQFSZ15tUdodkFQNW0GIdrqd3sBoH+ZvFhI9Oz5+EvMZRqxs7bu22WS65od
 X+Tt/UmDceaXIBc1DZnZvKSnTlT2Dy7SpYIZdPhFQaDH3Zvo5VA9LAyklDVma4mdE60f
 G6SFTacWcEMBb6M6+C2bSfetlPDYWJ8mtOkP4/fhJsxvoJ77eatKiCQToROPJ5AhPedE
 IYgw==
X-Gm-Message-State: AFq9FYLXcdjIwsO9qFg2I8X4Jghkghd3ic8agsa30Q4tbdt7UMD7lsRS
 hUJ05zszKhUyKt+KxG97tTR6hGp79gMDsapa9B6RviEsKnBxjh0lfqaxNsQhTqQg731qLkev7oM
 JSW02cnYXsBHfe8OGNxP7hlNMdrvAme/fC7FQLo5FKJJgGIigUuWZwc1f+XjgIvnr7k4fhgOo8r
 knLpnEiKyBXR4cK3J/Ilw=
X-Gm-Gg: AYBFou1170Xt4zN9Ow0ya1SuX7M2E3VymICQg0JAbuO1L4yNOf3NB+r4WcuPWIYkpUQ
 bTd6WnQn1XumSBZ4vr+PQKk9HAoho0zR4g63MOrj6sobh7zI3vmiFwkUR1fsyPjg8qLGfMkH020
 /X+y9bbx9K2es57nArRpI3HyJMq4sgq7UD7E8mfN19ADb6o0K9igX28Q24cenJb+H2Bun5CQSA/
 Zl1+zK34gb02cN4aD7X9Pmn2zCDiy9wMRqrXGYupkahcwbImBrj2J8LXHieSDvrjg08fEwKe+Ej
 34qQTlCwY3Vzez0bx/DWwY/G8LQJZQq/n8zc7AGfy7w=
X-Received: by 2002:a05:651c:542:b0:3ab:13ec:d4b with SMTP id
 38308e7fff4ca-3ab292b5f4amr17247661fa.16.1792418786754; 
 Mon, 19 Oct 2026 07:06:26 -0700 (PDT)
X-Received: by 2002:a05:651c:542:b0:3ab:13ec:d4b with SMTP id
 38308e7fff4ca-3ab292b5f4amr17247201fa.16.1792418784671; Mon, 19 Oct 2026
 07:06:24 -0700 (PDT)
MIME-Version: 1.0
References: <20261019134808.192525-1-eperezma@redhat.com>
 <20261019134808.192525-2-eperezma@redhat.com>
In-Reply-To: <20261019134808.192525-2-eperezma@redhat.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Mon, 19 Oct 2026 16:06:11 +0200
X-Gm-Features: AclHuK9FQZVVlxpqXti6MRV0O79tcfLtgzECJxuCAJ11-5UFxXwWeQPpg6h9CIA
Message-ID: <CAO55csx_gH8gmzMqip1-_-NuC+8MNsrSX5qz7WhvfjX6=njEww@mail.gmail.com>
Subject: Re: [PATCH v5 1/9] uapi: import VDUSE and VFIO header from v7.3 kernel
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: dev@dpdk.org, mst@redhat.com, jasowangio@gmail.com, chenbox@nvidia.com, 
 david.marchand@redhat.com, Stephen Hemminger <stephen@networkplumber.org>, 
 Yongji Xie <xieyongji@bytedance.com>,
 Bruce Richardson <bruce.richardson@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MYNRm8hpdY0XT_wTqm8FEBhZbWSRs-jm75O5c7n0kog_1792418787
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

On Mon, Oct 19, 2026 at 3:48=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> This header will be used by the Vhost library.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---
>  kernel/linux/uapi/linux/iommufd.h | 105 +++++++++++++++++++++++++--
>  kernel/linux/uapi/linux/stddef.h  |   4 ++
>  kernel/linux/uapi/linux/vduse.h   | 113 ++++++++++++++++++++++++++++--
>  kernel/linux/uapi/linux/vfio.h    |  51 +++++++++++++-
>  kernel/linux/uapi/version         |   2 +-
>  5 files changed, 261 insertions(+), 14 deletions(-)
>

Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Note that I tested this is properly imported using the linux-uapi.sh checke=
r.

Thanks,
Maxime

