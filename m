Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1253B606A780
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KEgRqXfl
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 25C6842F5B;
	Tue,  3 Nov 2026 16:19:38 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTPS id 82C7D42F5B
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:19:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793719175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WMmUE0N+9DtsZZC7rmri/rX0Mun+CmplEs1CKJYnIJk=;
 b=KEgRqXflQUuWOqJ008SVQj370WrHiShHoZcWGZ3r7FYsteNCLTBSpEQLJcjH9nFbFuwgbD
 humupXC1c5xZiE4NDXJRNOyiqwqoPi8vxMNYGUsWf4qXRvBw1JpRm90fL6twp08SIHuAyF
 PnypCgUZrLhWZNuqk29IPi8haop2xEw=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-7uhgxObeOWyf6S93XaVvRQ-1; Tue, 03 Nov 2026 10:19:34 -0500
X-MC-Unique: 7uhgxObeOWyf6S93XaVvRQ-1
X-Mimecast-MFC-AGG-ID: 7uhgxObeOWyf6S93XaVvRQ_1793719173
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-3ab217a1d95so21208211fa.2
 for <dev@dpdk.org>; Tue, 03 Nov 2026 07:19:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793719173; x=1794323973;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=WMmUE0N+9DtsZZC7rmri/rX0Mun+CmplEs1CKJYnIJk=;
 b=SOXk64XXCWd00cltkDV7nXAAVy2t9q7u1WQSXwT0tYb27lo47b+d/S1cel32ZM4HTb
 p0RYSbv18tmVozunjNR4Lvik7L6CegzcJl/vMVxNF3Wm4ZBs0iIRKV9rubPcaGBM6bYn
 QDhQD3KtJ8O2Nu+YgBJYCQ5kHhfpK4ewRQDm73tYLdoDGwCjTHuttACljNaXEiMnDlNO
 +T5NmL7NUTtqcqpew84cPiNKYFQIYtSWyOa1NYEm3/oZvQYGwZgKoiD7xn6wJAGyI1/p
 QAEhu7y2HV2OfDoaH6OedTfkVnDzQ2bFjCWHfY2VU8d81gqU2FFCCXM5dQqzF9uiIW39
 fwQg==
X-Gm-Message-State: APuU4Z9aOAMRtvC80IdIZt84kbTje7MxMkmWEORDNQySZr0y+Flt58Hs
 7PJkMEs/5gXVqD+oD+Sfdrdq+L6TvOca/PERQ7mM8cZ7gBCR2V810GbCXAjQujsz2CxADUmicsB
 OMcsFQl76ydEgiaXzKT9yqrCA8mvM7Ae2tkXmqPh/HIsV0Ao5n7q3llqD+kzD+n7nhjUkWizYU8
 rIpGmEm6fcZPonOUR571Y=
X-Gm-Gg: AYBFou1pnyzWPSyGLaem33w67/uH9msuWVqY7+d+0W6OZsAzgOJMj2Q3fjn4QAloI2r
 P1GmYnA2rFd2CsROWB+uHjaN43cD0NsevxsdUfjzprOj7dAxDaJ5MpkN+jMobMQPrDXOke4T3W2
 QYC3rcekSpALXM4bYGAiBj5KaGrtQS0SQj9Vf9zkTlQWKMadgMKBLgS7Rna+nmlfs9GxpUbsVV3
 5NyZy9qEsWIvEAhIrwqEZkhTtt/6df3mpJ/t7H4IQ1f8RkS
X-Received: by 2002:a05:651c:903:b0:3ac:cfdc:d798 with SMTP id
 38308e7fff4ca-3accfdce1c7mr15492111fa.19.1793719172709; 
 Tue, 03 Nov 2026 07:19:32 -0800 (PST)
X-Received: by 2002:a05:651c:903:b0:3ac:cfdc:d798 with SMTP id
 38308e7fff4ca-3accfdce1c7mr15491981fa.19.1793719172193; Tue, 03 Nov 2026
 07:19:32 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261103115752.1557738-3-rjarry@redhat.com>
In-Reply-To: <20261103115752.1557738-3-rjarry@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 3 Nov 2026 16:19:19 +0100
X-Gm-Features: AclHuK-OI_xe-KjKJNipdqDN_S2uj6Erp8fNSsBeWrgJT9kDZeAp5HZgJyVFrYw
Message-ID: <CAJFAV8wARV-ECOO5Jw6ApkO2D5OE8QzHSj0_=BfOb3iMnVrLfg@mail.gmail.com>
Subject: Re: [PATCH dpdk] net/tap: close old LSC socket on netns change
To: Robin Jarry <rjarry@redhat.com>
Cc: dev@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>,
 stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yJxUOKn8yHiVgvQRzViKQdrKZeOM_ppLW5bI2plwJ5Q_1793719173
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 3 Nov 2026 at 12:58, Robin Jarry <rjarry@redhat.com> wrote:
>
> When an interface is moved to another namespace, the LSC netlink socket
> is recreated in the new namespace and the interrupt handle FD is updated
> in place. The old socket is never closed, leaking one FD per move.
>
> Create the new socket first, then close the previous one before updating
> the handle, so that the handle never references a closed FD if socket
> creation fails.
>
> Fixes: aae3a38e9e03 ("net/tap: detect namespace change")
> Cc: stable@dpdk.org
>
> Signed-off-by: Robin Jarry <rjarry@redhat.com>
> ---
>  drivers/net/tap/rte_eth_tap.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/tap/rte_eth_tap.c b/drivers/net/tap/rte_eth_tap.c
> index 1d2b71675a8c..885f1b341388 100644
> --- a/drivers/net/tap/rte_eth_tap.c
> +++ b/drivers/net/tap/rte_eth_tap.c
> @@ -1938,15 +1938,21 @@ tap_lsc_intr_handle_set(struct rte_eth_dev *dev, int set)
>                 return 0;
>         }
>         if (set) {
> +               int fd;
> +
>                 /*
>                  * Subscribe to RTMGRP_LINK to receive RTM_NEWLINK (link state
>                  * changes) events. Also receives RTM_DELLINK events which are
>                  * used for namespace change detection when TUNGETDEVNETNS is
>                  * available.
>                  */
> -               rte_intr_fd_set(pmd->intr_handle, tap_nl_init(RTMGRP_LINK));
> -               if (unlikely(rte_intr_fd_get(pmd->intr_handle) == -1))
> +               fd = tap_nl_init(RTMGRP_LINK);
> +               if (unlikely(fd == -1))
>                         return -EBADF;
> +               /* Close the socket of the previous namespace, if any. */
> +               if (rte_intr_fd_get(pmd->intr_handle) >= 0)
> +                       tap_nl_final(rte_intr_fd_get(pmd->intr_handle));
> +               rte_intr_fd_set(pmd->intr_handle, fd);
>                 return rte_intr_callback_register(
>                         pmd->intr_handle, tap_dev_intr_handler, dev);
>         }

So IIUC, net/tap is changing the FD while the interrupt thread may be
working on it.
This was working "fine" so far as the interrupt thread was working on
a copy, but now, it is racing.

This fix looks correct, however, we have more issues following the
removal of intr_handle duplication.
I would instead make sure the interrupt subsystems acked it stopped
caring about this intr_handle (iow, after this callback returns).
Btw, I see a use after free on port close (probably missing a intr unregister).

I am preparing a different set of fixes (using the same idea than
net/virtio-user).


-- 
David Marchand

