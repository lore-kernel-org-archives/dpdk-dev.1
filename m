Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA6EE9A03B
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 08:52:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 29BEB40299;
	Wed, 18 Feb 2026 09:52:44 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 53E4E4014F
 for <dev@dpdk.org>; Wed, 18 Feb 2026 09:52:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771404762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EvzTOD/V2Ntd5ijyn3/0ZaK2+sverQ0ucbfTbghz0tE=;
 b=e0/4cpZrMB80ivHDZVC7ZYUUug7vppmQG60llVW+jgn9tnCZd/ufOfkh3L6cop9ptK5uV7
 CnwUNJE76JdQxYmU+qXsUkMCmmII3QarVvZr5D1Da/ulJy2GAfKVVW1CNQj5aqdCpPpI3X
 lABqTkRpfB70qu+QMXIV+fKR8WyaB68=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-JNz3udvxPV2JsftIWZG03g-1; Wed, 18 Feb 2026 03:52:41 -0500
X-MC-Unique: JNz3udvxPV2JsftIWZG03g-1
X-Mimecast-MFC-AGG-ID: JNz3udvxPV2JsftIWZG03g_1771404760
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-385d4c511e4so27585611fa.1
 for <dev@dpdk.org>; Wed, 18 Feb 2026 00:52:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771404760; x=1772009560;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EvzTOD/V2Ntd5ijyn3/0ZaK2+sverQ0ucbfTbghz0tE=;
 b=n/IymHbrLmkaQ29ATaHrPKdwczznQA88ROvcCwiizkWYYH4FD+We9rfESTQ1col9l2
 fIUUc+DhOUxyxnGSRbbqm843C1+xyr2uazEpeyBNZALhoSzbqMh2vt9NtYSI1gXNNgSN
 l3+pONaz1KzWSdMaFjOGz78AOMBY+cBImy/9r/EkvEAXqB2e+zPVt2MQ550S/WrFbLMd
 pIPH2FaqqBNWYwWqtVB0AA9xoiaRC97L1yIQfsC6zqo9L1VYbTqg7Y8ky13w6qBX0SgW
 2Z6kUoXMonuGcYTkgQ/BVhNcYyhH7rUunStw+k1GF3ApDWww3FcNMd5x2fsXyz1lLVCa
 52RA==
X-Gm-Message-State: AOJu0YxozWPkEXc3z/N+h1+rWSlKjhuBv3LoBL0da7VyHq3S9WITKv+P
 GEqB4IwLTY3upviUytiSzQi6q+Rg0j6J5RkFvmxheDO2arqDIIkdcxCu5xOkKybiavQgGi7iRHB
 faj3hwLw096bPC9WOJ6K/157oSHsrChbK6P5sWawitgn4Zbxs4pU3iZcbjlsdI2Ge5Y4IMLyYnE
 0dkfF+yRJQqMLmfLHceFo=
X-Gm-Gg: AZuq6aK2QiwUYYyWLitsMbsi30uhefA80sZf6IMNbKv1DiO8zRrDgjCOU9nFIoIdmgj
 k3zh4LbsVlamudkG7lQg3BEg3bJCU+nLW5TMFvElpD8qetLtcDpPX0Gra/I1G3op1gVld3xHNhC
 vSIWtjkOFx2YdRfLx67FQ5SJscyOYPRnCVLHtdWgBJE6WWoSma/PjpgpqMT6jvI0qNWE3jVHe2f
 ZUP/xtVPI1daHi8QiYN2gq/PdQZw6bTaAlP3Z3thTwi/Aq3RRl4L9CUDadZl/drLagH1A==
X-Received: by 2002:a05:6512:3a91:b0:59e:3934:fe39 with SMTP id
 2adb3069b0e04-59f83bc23e8mr342691e87.38.1771404759761; 
 Wed, 18 Feb 2026 00:52:39 -0800 (PST)
X-Received: by 2002:a05:6512:3a91:b0:59e:3934:fe39 with SMTP id
 2adb3069b0e04-59f83bc23e8mr342683e87.38.1771404759352; Wed, 18 Feb 2026
 00:52:39 -0800 (PST)
MIME-Version: 1.0
References: <20260218075016.65429-2-malikovyehor@gmail.com>
 <20260218080155.67111-1-malikovyehor@gmail.com>
In-Reply-To: <20260218080155.67111-1-malikovyehor@gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 18 Feb 2026 09:52:27 +0100
X-Gm-Features: AaiRm53uNsXm0jtLHRKp6kOR9moUpa_K0HDKEQtj6Zv0l1IKCr7sWsQzKWYxob4
Message-ID: <CAJFAV8yjTs8inmZqYyPrTubc_oaKfEi=nv_58HzyXf9f+pPg0Q@mail.gmail.com>
Subject: Re: [PATCH v11] vhost: fix use-after-free in fdset during shutdown
To: Yehor Malikov <malikovyehor@gmail.com>
Cc: dev@dpdk.org, maxime.coquelin@redhat.com, chenbox@nvidia.com, 
 stephen@networkplumber.org, Yehor Malikov <Yehor.Malikov@solidigm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3RtjtJOo53BvPI6KiTn0T14oNz7jcsxXgdeO3i_Y2I4_1771404760
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

Hello,

On Wed, 18 Feb 2026 at 09:02, Yehor Malikov <malikovyehor@gmail.com> wrote:
>
> From: Yehor Malikov <Yehor.Malikov@solidigm.com>
>
> The fdset_event_dispatch thread runs in a loop checking the destroy
> flag after each epoll_wait iteration. During process exit,
> rte_eal_cleanup() frees hugepage memory while the fdset thread is
> still running. Since the fdset structure was allocated with
> rte_zmalloc() (hugepage-backed), accessing it after rte_eal_cleanup()
> causes use-after-free.
>
> Switch fdset allocation from rte_zmalloc/rte_free to libc
> calloc/free. The fdset is a control-path structure that does not
> need hugepage memory. Using libc allocation ensures the fdset
> remains valid after rte_eal_cleanup() releases hugepages.
>
> Fixes: e68a6feaa3b3 ("vhost: improve fdset initialization")
>
> Signed-off-by: Yehor Malikov <Yehor.Malikov@solidigm.com>

On the principle, the fix lgtm and deserves being backported.

The commit e68a6feaa3b3 ("vhost: improve fdset initialization") has
been there since v24.07.
Is this something that you hit easily?


> diff --git a/lib/vhost/fd_man.c b/lib/vhost/fd_man.c
> index f9147edee7..fae6d787b6 100644
> --- a/lib/vhost/fd_man.c
> +++ b/lib/vhost/fd_man.c
> @@ -8,9 +8,10 @@
>  #include <sys/epoll.h>
>  #include <unistd.h>
>
> +#include <stdlib.h>
> +

Nit: this can be fixed when applying, stdlib.h header include can go
in the first block with other libc includes.


-- 
David Marchand

