Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24924C79F83
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Sep 2026 09:20:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 12C5E42E5B;
	Fri,  4 Sep 2026 11:20:32 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id B1F0542E56
 for <dev@dpdk.org>; Fri,  4 Sep 2026 11:20:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788513629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XEfg+EoFCjDVRb+nhrgXFR3RjGo1xaMRFd6Ef1bWbrE=;
 b=i1jnpk8jghvjqQ0VpQQz7kGU8fIhnpy3s1m8cikKhhGSbx6EE0Z4pggHmxTNcEivyvL2Ex
 PM0fZrg7JZ6BW8eox53O+sxST/vuDPDAPOSsDjzkIOPf5qWc6OgWUEKvPtrMQVkGbwhNe8
 xEZBOTjUolFXzKkMJZbFZ6vfuGzZF/s=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-wKuS0vwTPFKfwqb2O6S7Og-1; Fri, 04 Sep 2026 05:20:27 -0400
X-MC-Unique: wKuS0vwTPFKfwqb2O6S7Og-1
X-Mimecast-MFC-AGG-ID: wKuS0vwTPFKfwqb2O6S7Og_1788513626
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5b4abd479cfso1410401e87.1
 for <dev@dpdk.org>; Fri, 04 Sep 2026 02:20:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788513626; x=1789118426;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=XEfg+EoFCjDVRb+nhrgXFR3RjGo1xaMRFd6Ef1bWbrE=;
 b=Z/fQcDfIxzWOXvIQQp/rgozmAcITC5P26v76T549QYCebT83icFzt/EcIJFWbq+hJH
 tghxN+DL+nYljUvxfeQ0cmDIGmtwlprPZ2ZnOWMAEsRh3qRIdoeC05d7L5YIjAh6yY3v
 OR7gbklFmCWMMnmh9ORqdk7Kk/piaOvcCdwNR8rvQ8YZ6ORzWak6ioeTuJolnAhODPnf
 jgaIC1ik6me49Y+0gV5XUoNK488ni1LvwZLq6Nl6mIaKYpvWU8OCHT8UIg9SxNc3GCMX
 +Kn4ADP+TdMJy+hjqmi03vvtgXnVqjqva9BrTXJiSQzxcx/2ZGCNAPwvOlDR+XY/Xwob
 QFbQ==
X-Gm-Message-State: AFuF++lShwAoNZniVhzQsRdZY4a9M0zNSIXNdsUYbsXFgDD6HkyQqOJw
 ZMhURTF/Y73wWtfRePlUkGKYDyvWAonhjWb8VGFYTABFA/oTbfS98ZtMS4QXVUvOsU4SQTxkvc8
 xeIt09K/R0xKtdj1GBddPz8Wh/sxhoYDViytP+24wmTCtI3y2zms6I6/CGTifFhKXdvla9IVJiR
 QvqCkO8IbyLE8vieKSdtc=
X-Gm-Gg: AYBFou37SR8TQvlGoCvcba0rrmInrrka3+norDpJsI6rDTjORoK5aLszkrTaW5GTR0a
 o2zZcgcZIehwGw056vzJNr5KlAJPntVjoNiZS6/hX250BcjwX3dDLMMD2adhXpxhOwGpV4jIkFj
 arhYLZusuJLWdbXJvB78t+pMFK0DrjzDP/CrEaIvhIJhMba7SevKjCrNrj/v+aZdqLxOPbV/YN1
 CPNJWaSg/Uobz0jZY9bi+93iU9qmPueYftuWAjZ7jppNqDR
X-Received: by 2002:a05:6512:a348:b0:5b6:15fe:212f with SMTP id
 2adb3069b0e04-5b615fe2d0bmr501643e87.45.1788513626094; 
 Fri, 04 Sep 2026 02:20:26 -0700 (PDT)
X-Received: by 2002:a05:6512:a348:b0:5b6:15fe:212f with SMTP id
 2adb3069b0e04-5b615fe2d0bmr501634e87.45.1788513625602; Fri, 04 Sep 2026
 02:20:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260720080035.673782-1-maxime@leroys.fr>
 <20260720080035.673782-6-maxime@leroys.fr>
In-Reply-To: <20260720080035.673782-6-maxime@leroys.fr>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 4 Sep 2026 11:20:13 +0200
X-Gm-Features: AcwNN1UGHLtIR-2fuH-DB6WaWHvD8XHw_vJ-n9mdzyDpkYm3zhR-aZq0clqFGBI
Message-ID: <CAJFAV8yvvtysXvHcZm3+BC3Rvhn3+8QHyWAkA9j6mxGrpZ+0JA@mail.gmail.com>
Subject: Re: [PATCH 5/6] examples/l3fwd-power: recheck Rx queues before
 sleeping
To: Maxime Leroy <maxime@leroys.fr>
Cc: dev@dpdk.org, anatoly.burakov@intel.com, sivaprasad.tummala@amd.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Yna8G4HHbIxe9wwtv0PNnVRgPtQWTT2b0TyqvKeBi7E_1788513626
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

On Mon, 20 Jul 2026 at 10:01, Maxime Leroy <maxime@leroys.fr> wrote:
>
> After arming the Rx interrupts rx_interrupt_wait() sleeps in
> rte_epoll_wait(). A packet that arrived between the last poll and the arm
> can be missed on PMDs whose interrupt is edge-triggered on an empty to
> non-empty transition, such as dpaa2: arming a queue that is already
> non-empty raises no notification, so the lcore sleeps until the next
> packet.
>
> Before sleeping, check whether any queue already holds traffic and, if
> so, skip the wait and go back to polling. NICs with level-triggered
> interrupts are unaffected: a pending packet keeps the interrupt asserted,
> so rte_epoll_wait() would return immediately anyway.
>
> Signed-off-by: Maxime Leroy <maxime@leroys.fr>
> ---
>  examples/l3fwd-power/main.c | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/examples/l3fwd-power/main.c b/examples/l3fwd-power/main.c
> index fa64e28e5c..c423b0dba5 100644
> --- a/examples/l3fwd-power/main.c
> +++ b/examples/l3fwd-power/main.c
> @@ -949,6 +949,26 @@ static int event_register(struct lcore_conf *qconf)
>         return 0;
>  }
>
> +static bool
> +rx_queue_pending(struct lcore_conf *qconf)
> +{
> +       struct lcore_rx_queue *rx_queue;
> +       uint16_t queue_id;
> +       uint16_t port_id;
> +       int i;
> +
> +       for (i = 0; i < qconf->n_rx_queue; ++i) {
> +               rx_queue = &(qconf->rx_queue_list[i]);
> +               port_id = rx_queue->port_id;
> +               queue_id = rx_queue->queue_id;
> +
> +               if (rte_eth_rx_queue_count(port_id, queue_id) > 0)
> +                       return true;
> +       }
> +
> +       return false;
> +}
> +
>  static int
>  rx_interrupt_wait(struct lcore_conf *qconf, int *intr_registered)
>  {
> @@ -968,7 +988,12 @@ rx_interrupt_wait(struct lcore_conf *qconf, int *intr_registered)
>                 *intr_registered = 1;
>         }
>
> -       sleep_until_rx_interrupt(qconf->n_rx_queue, rte_lcore_id());
> +       /*
> +        * A packet that arrived during the arm window raises no new wakeup on
> +        * edge-triggered PMDs, so skip the sleep if a queue already has traffic.
> +        */
> +       if (!rx_queue_pending(qconf))
> +               sleep_until_rx_interrupt(qconf->n_rx_queue, rte_lcore_id());
>         rx_intr_disable_all(qconf);
>         return 0;
>  }

I don't see how this solves the race.
There is stil a window between checking the queue count and sleeping.

Looks like a bug that should be solved in the driver.


-- 
David Marchand

