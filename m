Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B88606A31C
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Nov 2026 14:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=qlkUiY7O
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 41CC640296;
	Tue, 10 Nov 2026 15:36:57 +0100 (CET)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by mails.dpdk.org (Postfix) with ESMTPS id 90E8740E64
 for <dev@dpdk.org>; Tue, 10 Nov 2026 15:36:55 +0100 (CET)
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-89d6bd67045so1135228b3a.0
 for <dev@dpdk.org>; Tue, 10 Nov 2026 06:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794321414;
 x=1794926214; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dkSDb9PiOcUPvyBW5GGkY0DYVVAt7Iti0U9fU0x3uTc=;
 b=qlkUiY7OOvStyxP8g5PA7q8wPpWMnMb+O+KLiItm96ycM1bnLEnio5zk7glD5HI8v2
 uc+QpUteC48CJhxGG6PUePfbPl3wCQOlKDULcMViFhVVcUVOPiahQH9V7HaGoW+QR2O8
 dUDcJN9hlJkvCLxVF815MF+NU6wuwHTzVaoCBfyfco4I9KxgHtauD9LmWlyrWst9vA81
 K20ncyzEv73vmytAlulB8CVgki9c0ufSTFvR8x6Vd9iKFvq4hXCHfBhXznYCsjjsUJWE
 aK6kUAP2xulfSPVlygoKX5Zcw/72ydvihaR6hWEwoS2dWQEp5p/bIgPArUBtHvK14utE
 ZG9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794321414; x=1794926214;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dkSDb9PiOcUPvyBW5GGkY0DYVVAt7Iti0U9fU0x3uTc=;
 b=nHlVmzHVX0MhN3oni8bNc3b2IvZaWt/j/bYZZEyQ52Pup4PAJufQAxcQw3A35NiLdP
 UFu51K2WsLXAzefcngt7XUH/WhWkvSwDwbNT+NSj93EiWmZ6STZP6jQuhYBcfXXjONoM
 0is1cIqUPp0uLUV8jV2BvFk1DJxp3xNR8hP8Ni+Anb5o6I4cdvwkph7D2T4HtdbX8U1P
 yG9fw/JEBVas0nBEuFsJJLgNSnKNWd7c1oXFzvEIfzYm+OvCUODN+K/o36fRg9f6hhJQ
 DtWR4nO7VGW1v/FFVBgc1yjosbjmXGa444Ut6knRFC+YE5Qx/awVDbD0nyCgjZ5fkPMM
 zLxQ==
X-Gm-Message-State: APuU4Z+/lfTq29fxeBHCGuKD0xJuiex5GMeUAIZYNGclhrYktHc28HUk
 fa/N+9olrfAUX+4fgp7XKGh6urzJembss8KXWLr/YePDNJnLBdZEbsIviwZaaDqDfjk=
X-Gm-Gg: AYBFou0Vj9WG7hTfdyEV+x3ttxQus8Z6Rybytn8JhH84wMEzjrCCo7S225Boim61IgA
 BwgwigV/AuaKbo4jgj+3FxB51BH2j3xH3GepjqmTHmJpYcKREJjOKZU6gdczuR1ODPfvlyTj0jD
 Zc5AKwPpW4hso06A0RaIUzFFLI0sVnix1BqCqRurz4aTtdiZCiMJzj2yCSinaS8WkQSjxUi+2CF
 TH8FyCGAAy1hEc9oK5HSEveTht0YaWgaIhnyeECMr2jrh/MXbcLGqNOrzLTPV2CbGANKU9K9UoG
 C7l9pCMJiqHtrm2R0bA/z9eB8gDzqRRkOB92SPZt6COiPN3bfjaPhj+DPOqFpWfmSH0ceeC0Z5v
 2N0DPKGmNnhx6Ps0KNh1WPFKFehpSYMPdYxlA8iXgnpiVHDTYxh7ZLl5fxYXVF4oZ2+d6Jgi2ND
 c0JGm3ZYvEsdfQT02U9sSNNZFveA59Eq6fIX4SQ+wYA4CeTFl/J8yqIFevlBpRXA4KfLXPjjW7Z
 aHURLDSxg7fS9uzSyXnvA8O+YmXfrR5hu0G8rQhCwrf/ElEvwpF6oloLg8zKAqTfLG76J7EicG/
 Mk/AkG5uvNXHltF9ZiOZz7JysZA3dBVHRjqQcO+bKSQZ+o4xIKYRYJPs2HcqngIXCQ205QY=
X-Received: by 2002:a05:6a00:12d4:b0:89f:2b65:2a1 with SMTP id
 d2e1a72fcca58-8ba934c905amr2109205b3a.8.1794321413911; 
 Tue, 10 Nov 2026 06:36:53 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8baaac46b20sm972054b3a.30.2026.11.10.06.36.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 06:36:53 -0800 (PST)
Date: Tue, 10 Nov 2026 06:36:50 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, Jakub
 Grajciar <jgrajcia@cisco.com>, Thomas Monjalon <thomas@monjalon.net>
Subject: Re: [PATCH v2] net/memif: fix use after free on listener socket close
Message-ID: <20261110063650.38e0ab72@phoenix.local>
In-Reply-To: <CAJFAV8w0gWA+jJmTcFOeJTi1S+j5+rSq9Ltn+aWn59yJu0Oy5g@mail.gmail.com>
References: <20261104164153.1674329-1-david.marchand@redhat.com>
 <20261106145730.2561787-1-david.marchand@redhat.com>
 <20261109141354.23e03f2c@phoenix.local>
 <CAJFAV8w0gWA+jJmTcFOeJTi1S+j5+rSq9Ltn+aWn59yJu0Oy5g@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 10 Nov 2026 08:43:28 +0100
David Marchand <david.marchand@redhat.com> wrote:

> On Mon, 9 Nov 2026 at 23:14, Stephen Hemminger
> <stephen@networkplumber.org> wrote:
> >
> > On Fri,  6 Nov 2026 15:57:29 +0100
> > David Marchand <david.marchand@redhat.com> wrote:
> >  
> > > memif_socket_remove_device() calls rte_intr_callback_unregister() on
> > > the listener socket interrupt handle. If memif_listener_handler() is
> > > active at that point, the unregister returns -EAGAIN and the code
> > > proceeds to close and free the handle while the handler is still
> > > running.
> > >
> > > Use rte_intr_callback_unregister_sync() which retries until the
> > > handler completes.
> > >
> > > Fixes: 7281511c2cfa ("net/memif: fix some interrupt FD leaks")
> > >
> > > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > > Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
> > > ---
> > > Changes since v1:
> > > - added missing _sync in other call,  
> >
> >
> > Applied to next-net but dropped the Fixes line since that commit
> > is after the last release. Fixes is not necessary during the merge
> > cycle.  
> 
> I disagree.
> 
> Fixes: tag are not *only* for backport purpose.
> Those tags also give useful information when looking back in git
> history, to understand why change X is done.

Makes sense, just don't cc stable
