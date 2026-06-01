Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B5BCD6E56
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 11:56:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 030244025F;
	Mon,  1 Jun 2026 13:56:42 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 306BD4025A
 for <dev@dpdk.org>; Mon,  1 Jun 2026 13:56:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780314999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BEmpozmWPFLSxrQRfkSjbN+aIG+a5DVF4zVhphondeA=;
 b=OVIDq3A4//wx0Sn/EoUcg1B4A85vS1UzV6FMB050jFqx4HN4/pJTxA7l6p1GK7f65JEyS0
 LkXtbVT3gmQ34hXXMiI/p0NiBJrVGZ5DxTVMAmSfPIXPmksHPgGKo3D8mfvw8vRwJspPV8
 m2rVeFY7wyxtAO9LFl681hl9p5S5ebM=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-YjZBpt8dOuu5QLu7-NiTPA-1; Mon, 01 Jun 2026 07:55:28 -0400
X-MC-Unique: YjZBpt8dOuu5QLu7-NiTPA-1
X-Mimecast-MFC-AGG-ID: YjZBpt8dOuu5QLu7-NiTPA_1780314927
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5aa661a8129so941457e87.3
 for <dev@dpdk.org>; Mon, 01 Jun 2026 04:55:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780314927; x=1780919727;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BEmpozmWPFLSxrQRfkSjbN+aIG+a5DVF4zVhphondeA=;
 b=kHK6Kk4cVm/fjFCsnBwzrsJDFXa8YCzh8ObYNRzynKrY4NxBef1kj7doGQ9AB+yrR2
 bdPICLjnLFlGbJtiDKLIDHCkXm+L5YdO1x5A/Y+3ko/QnbjOr3zOZTKhTaYAfq/Cm6AR
 wG5a+3f9e08HCdokL1SUxiuIHdwwl51ib7/mq3lR+G3d0J8m8vFjEmXezhp/kaxyxjzK
 fS0UxVb4VvCTa8wAkS/pMmuz0hodx13ZT2OCg7kc+7Z/psemguxpvFoQ0go+BRws4T/R
 a3TcDh5Onwn9NYO971gTLYulliQJ5IzqzWKrdHh9bEsmq43u+BWKBCDSXG1nQy23LniE
 Ev9A==
X-Gm-Message-State: AOJu0Yynw18METaUE66Slr0ahstiiKk0OINQa2mAoK4QBaNCQEzY4+Ob
 UyGcou1+BVZKZNICrTOuSidzI0awoR56avFXeV14ZFe4twelXM70UQy1JRhKDEMFIQWLe6+CNe2
 TLKCliPQ3f1r2I3xTIVKYxwnj1iYKIXnTaXmCX36WjHWt0uHYN1jS0tK3AbH5djF9SqvUK5x9aX
 G/GNjsGU9ryHQ3ZfooOas=
X-Gm-Gg: Acq92OGM7C8RhyRAQ/LzY3X7zZ49fnb5/iJC+itD256yjGYA3ZiZNkPZYUY1+JRdFzv
 rCXf5WopUuOqQSLLnW4H4PYr2yGA/XeQSFM/FUPgw12jwUKX+E3bJd8eTGO/k6WGEcUDB2BufA2
 ENcXjCpMFqhxv8rM++5PjoeiheC1SmXFdpG9cvPF9Mf3sla74wP8RJrygObtU95pgBysRHuw7/9
 m+KvEaKvvq/DixHHqt2DYsnDfuUAqfrUBAWLvRnpC6ubsBqS9biHSZyvxV4inbgVzzsgMtep8o1
 hK5T
X-Received: by 2002:a05:6512:118d:b0:5aa:7397:6cdb with SMTP id
 2adb3069b0e04-5aa73977083mr15505e87.44.1780314927073; 
 Mon, 01 Jun 2026 04:55:27 -0700 (PDT)
X-Received: by 2002:a05:6512:118d:b0:5aa:7397:6cdb with SMTP id
 2adb3069b0e04-5aa73977083mr15487e87.44.1780314926463; Mon, 01 Jun 2026
 04:55:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260527144407.160830-1-stephen@networkplumber.org>
In-Reply-To: <20260527144407.160830-1-stephen@networkplumber.org>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 1 Jun 2026 13:55:13 +0200
X-Gm-Features: AVHnY4KqO8vlv5T_Xi2-9XnTTwvkbNWaxVD8psWDc_yULjxFmiX7zXJPhWr7Ss8
Message-ID: <CAJFAV8ztviupv0rcjvL9MkBQSzY+yfak0RK8GzNbe-8s5JiyEw@mail.gmail.com>
Subject: Re: [PATCH] ethdev: promote experimental API's to stable
To: Stephen Hemminger <stephen@networkplumber.org>, 
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZMq9TmfGVGXe6mfnWCBlISmaXS52AaDOBoDRnOYLYs0_1780314927
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

On Wed, 27 May 2026 at 16:44, Stephen Hemminger
<stephen@networkplumber.org> wrote:
> +  * ``rte_eth_macaddrs_get``

I am not enthousiastic on marking this stable.
It more or less sets in stone that the mac addresses are stored in an array.

The initial goal was to retrieve all mac addresses of a port (21.11
release note entry):
"""
* **Added support to get all MAC addresses of a device.**

  Added ``rte_eth_macaddrs_get`` to allow a user to retrieve all
Ethernet
  addresses assigned to a given Ethernet port.
"""

And this is how it is used in testpmd.
https://git.dpdk.org/dpdk/tree/app/test-pmd/config.c#n7618


I'd rather see an API using an iterator that abstracts how macs are stored.
That would also make it possible to skip null macs (which I find ugly
in existing code).

RTE_ETH_DEV_FOREACH_MAC(mac, port_id) {
}


-- 
David Marchand

