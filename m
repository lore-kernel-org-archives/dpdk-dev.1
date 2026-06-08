Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43DFACD8C9D
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Jun 2026 16:09:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F0C2402DD;
	Mon,  8 Jun 2026 18:09:29 +0200 (CEST)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com
 [209.85.160.175])
 by mails.dpdk.org (Postfix) with ESMTP id 0CCB64029D
 for <dev@dpdk.org>; Mon,  8 Jun 2026 18:09:28 +0200 (CEST)
Received: by mail-qt1-f175.google.com with SMTP id
 d75a77b69052e-516e1525aa3so54838031cf.3
 for <dev@dpdk.org>; Mon, 08 Jun 2026 09:09:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780934967; cv=none;
 d=google.com; s=arc-20240605;
 b=dkMH7OU8FIxeYVSUcYVr8d/YNLGz2mb9O/lA/T6TR/ffzkSRa+ZlH9QN1q3/Hziy+L
 HnGceO0gqO/Q1PXbF7hxr7Gdajq2AJh03MB3jePivW44qqtfq03/84LSeBcFGVALLARS
 G7w2WyQKkbQGTB1RWiHCZX46XDLIzPAU4IfUA/J5xav3pXilYjIfkd3gTX8NZJRIrvD2
 Vue0fJRa8KVTyLNNZhnj+X5QknjfFOrdH+t4r1LjRwqpIp7eRsi7ilLwfwXtyr+kFRiv
 mpUGsmrAq911If7l9a7hVlwzLumIPvIvftSNH2TH/smPT4i76lClwo448l9AhiOjqZin
 6Wyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=sbe643GVpy59tUM4hu7NYlnSdGZMQWvmGVOw753QZ/o=;
 fh=aTMQnLYYZLpeCtuW0PQBCXMt9AsmjLIm2Q9DxObMXUI=;
 b=V1pelePh8Ycwwj97k6BnxYSf0UcYKE4SylxvxP8RRNxoEqkQ22wh+uedbNUFuBSNxT
 67gsGDBZwiTQFebt0lPr8kMJLHRpiBTH5GVruT1hXz6631UaYSOPx0iEsMeSZq5hTlRF
 VfhVAc5Lr1RtOGbV0ZcnbiDQkWS80oUG5Ix1Pyj9MP+GB8Fw/t/DoAXeFwrODWhnsz1p
 v3ccO6yIPDq4KyhS/ab95kLmAvlD28rmN464PwocdGwkrkfa9xe1nRL7txEMdTDftUnW
 n2aj0sqBrEJEUL9CDGwF/8z4culESwUBtmf+Ww2Z80bAnEzJFjwQDrdswjCdxdaPoesB
 YVkw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780934967; x=1781539767; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sbe643GVpy59tUM4hu7NYlnSdGZMQWvmGVOw753QZ/o=;
 b=HczXbzwpOeu02HNk86y5eQX5lJYSa6bBX01MXPDGhtlmglxowKs/1EDIz3DDqIaUot
 4yxG5LfIYwAMRjsj1kwhVbV5mNS5BfUJf97OHY8KFkK3t/Vq17KLBVPMmtQye/JZT49j
 OM9QolQGjmBcabkRTrNn/mCstqQ7DD7HazVwZ0Zky9cUwEdHZcV51GLNOUTZUQUIi/3W
 sxsG50HcQij04aWLwC0t/xQgJ6bkqVZmTFGQciYE1T2m4xZWltpBHX1MTiOdv6x65gu0
 Er+KDI2A/oE59gGo4KCpkGGR7eaYZltlLLHzfyhqCFzwyV9YZWNWFEpi97rFnIWridL3
 p+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780934967; x=1781539767;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sbe643GVpy59tUM4hu7NYlnSdGZMQWvmGVOw753QZ/o=;
 b=m9STBMlkBP7IiAvYVNLwOqrfND8hbX/toTyi7pC16SYBs5GCvsZ0I4BxxcNGY16eyt
 GNTRe1DaWU8b6B6nkTySmD+0R8KoPsUFGyLxwSvxxYGKs0dsFdvinClrSkjMi1PEA04l
 EdI4bteYiPxgCK7lldbOhP8bDc85drqUfdlmhJAWsiB6dNIfLVSLmHd1d+5+ate7NwZ+
 sxQbWH1gvoVhp1rZdULlrBVXI5bdMMbgBU0s0iQU654s6Mdr9nB8/swrIHmGTGWxZfGD
 7aKfyrCPEZ7o2srwOj/uRySXmz8wLQxBtoaiZAJioxxYdHrR0//NB0pcJsjSe8G3XJjp
 Nzmw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9D/innE+754EiEDBWRroAo7PTtynok6KrrCimBI+76teU24dVNGejrKK5vuk+FjfQ4M5M=@dpdk.org
X-Gm-Message-State: AOJu0YwGHFA1CGB+JjdBYZmKkZ4ZgPAT/rht8R9k77vCCREtvMakUf3F
 9NuPlCih3DmQoEq3Q/SrUJO+NlfTrol4j5E0qXrrHZwBoafShzZdIbt0u9DYDT4ayGLU/U2DBEM
 cGbUEctlFIrErndTV43M7ccboUlNjzB4=
X-Gm-Gg: Acq92OGgUG48APcvMmQxIxjzU3tsdtn+u9wV6VTdpnSzPkAgiSc62d+0HBefzC5xB6p
 ixbALdmHkqQ2n+P9NPfFL5dRFGNfw/Dg47uhNR5ixC4JiLn6MfXo7ECTQ4eB3s7EiyRVhoZLkqB
 qwkg6/r8rRotWlYPcniK/tz7h4s1ygyzJ8uyywXKroQVfuRwZJ5KUhJ/eXw3l3UEfMmtm9ylF+I
 NmuwnxqoJfoX1re85g4QgCpsGAT0jdlvbg0PUqlaRmZSTHLt4ag7+ikxJUdnwmfafxlAcBNWBdp
 WlhlpzQLJwbKkQ==
X-Received: by 2002:ac8:5491:0:b0:517:a9ef:ce30 with SMTP id
 d75a77b69052e-517a9efd0a7mr108065861cf.17.1780934967179; Mon, 08 Jun 2026
 09:09:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260605081620.97056-1-pbhagavatula@marvell.com>
In-Reply-To: <20260605081620.97056-1-pbhagavatula@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Mon, 8 Jun 2026 21:39:00 +0530
X-Gm-Features: AVVi8Cc6xlBfq5lIwHVZwQ-QjoZLOr0x8_oAqNB5DYK_4ZgHJnHGOrWb6xI2El4
Message-ID: <CALBAE1M=CV5NPTxKmf03dx4B5YgUz8c6qRWE8G6sKf4hih7QFg@mail.gmail.com>
Subject: Re: [PATCH] dma/cnxk: fix crash on secondary process cleanup
To: pbhagavatula@marvell.com
Cc: jerinj@marvell.com, Vamsi Attunuru <vattunuru@marvell.com>, 
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Radha Mohan Chintakuntla <radhac@marvell.com>, dev@dpdk.org, 
 stable@dpdk.org
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

On Fri, Jun 5, 2026 at 2:11=E2=80=AFPM <pbhagavatula@marvell.com> wrote:
>
> From: Pavan Nikhilesh <pbhagavatula@marvell.com>
>
> cnxk_dmadev_probe() ran in secondary processes too, overwriting the
> shared rdpi->pci_dev with a process-local pointer and marking the
> device ready. With buses now cleaned up on shutdown, the primary's
> roc_dpi_dev_fini() dereferences that stale pointer and crashes.
>
> Skip HW init in secondary processes: attach to the shared device data
> and return, leaving rdpi and the device state untouched.
>
> Fixes: 53f6d7328bf4 ("dma/cnxk: create and initialize device on PCI probi=
ng")
> Cc: stable@dpdk.org
>
> Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>

Applied to dpdk-next-net-mrvl/for-main. Thanks
