Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECEDDCD4F54
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 07:12:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2C04040296;
	Tue, 19 May 2026 09:12:05 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id D38494021E
 for <dev@dpdk.org>; Tue, 19 May 2026 09:12:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779174723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MnbsjB5oG8CFuFW5vg4aZ9+bc3/z6wxV0CPncCDLV/I=;
 b=PqSqoWCy1C+0U0lZLq15gG6SWhVTz12/dyzCYLD0CLDeOTG7ODFnw/QS5RFjseusaaG+50
 WEoveTqEfvScrfXeG5yXMyk2+2BkuPdWaTzjHX8j1g3JHt8cF4ADP5Z4vd6GVgD2yirhBh
 jhk1zl3pZBjZ/+qDQwGt/IaTHXIw1dU=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-uh65DxKYNZOb7ceZRsrvTA-1; Tue, 19 May 2026 03:11:59 -0400
X-MC-Unique: uh65DxKYNZOb7ceZRsrvTA-1
X-Mimecast-MFC-AGG-ID: uh65DxKYNZOb7ceZRsrvTA_1779174718
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5a40505f715so1826769e87.3
 for <dev@dpdk.org>; Tue, 19 May 2026 00:11:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779174718; x=1779779518;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MnbsjB5oG8CFuFW5vg4aZ9+bc3/z6wxV0CPncCDLV/I=;
 b=V74/9qa5KCmdO1VJ/BbyePaWHV3Dm8HfoWMdDl+Zx12Zy08oEbV+z3efcAFdPMgiRe
 +FDwz4iQ9Ykoc3sA1UqZXTRhjBCgCp2es8BStMPV/jKreHMFU0XsibN8yH/R8cQrn6iG
 8zY1lRIo1KQyG+bnYxmY9UPvIBicV/vvlojIgm0c5HmG9cJFOvuYCjgMbY+MqrDp+KUV
 RflPPDDW9NRMkxjXfBMhA2YCaaq6FmMt3P/a2gTK8mC+T3hArarNs0MDqlVWp/91kq9H
 Ba3nXDZ7nP2qk7ZQ3KcHKM5AvK6la/dbyBcKq4Bej/qvda8+3C5attIYi42sI8wq2WFf
 99IA==
X-Gm-Message-State: AOJu0Yzra3XRqPdW4Fply98ny41lVmO3cbfxNa5oXPlgKICx+uIpkh5d
 ELTqXVVckfQLjyz76cbZby98obIyaYsYPz2t6XVBZKjA/isXOqOVy62GY5MklSKM0lJNV9FYCUm
 5I3uuII6qvvMgl8ZtfwbqEychBdoIoI4iXwsAZ/nGDG5qXBlgv1LFHsMoeSD5Zf5/p8ttiipepf
 PGeH9YPGR1OiiJrbXV640=
X-Gm-Gg: Acq92OEj2DlZqg2QtJkjxByEzy1kzhW2J+qA5u9YIChYgrWKyNeja0+Sm/7uw7WqYWW
 /p82OjMIhOvxHfFpKoS7HoglWAO3A3WgomrvRCZ5vSnY/YOkbpuOEuz+OgBYFwiaxLLrWJCD4Jq
 My5hcx30waMNksAUtrQ8aA5f34inhtUAWQmJHqwZiZ5POTNri7uzB2lI2NwOmnGZb3Imh/VGOYP
 5qdPksRrOozpC0EMnawt19YxrRnzI3RuvB22xzirutZo0JCPDg+ETOPL+cS9fd/S0/9yw==
X-Received: by 2002:a05:6512:b9d:b0:5a8:e5f6:ad15 with SMTP id
 2adb3069b0e04-5aa0e74727cmr5035592e87.39.1779174718022; 
 Tue, 19 May 2026 00:11:58 -0700 (PDT)
X-Received: by 2002:a05:6512:b9d:b0:5a8:e5f6:ad15 with SMTP id
 2adb3069b0e04-5aa0e74727cmr5035580e87.39.1779174717470; Tue, 19 May 2026
 00:11:57 -0700 (PDT)
MIME-Version: 1.0
References: <CH3PR14MB63465CDF386C7768B0B65621BF032@CH3PR14MB6346.namprd14.prod.outlook.com>
In-Reply-To: <CH3PR14MB63465CDF386C7768B0B65621BF032@CH3PR14MB6346.namprd14.prod.outlook.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 19 May 2026 09:11:45 +0200
X-Gm-Features: AVHnY4JxBYfpyGwAhpjNMBYw2XsnearvaZAcTCObQ_PvHvxgoPWh6DE80ynxEfU
Message-ID: <CAJFAV8xaZcteWBtkF+Na6F1ye33GFqW7+k0KnKoCVtQ7h4Z-EQ@mail.gmail.com>
Subject: Re: Bad gateawy on DPDK kernel mods git URL
To: Noah Bloom <nbloom@nrao.edu>
Cc: "dev@dpdk.org" <dev@dpdk.org>, Ali Alnubani <alialnu@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lEphEpucBZwD-7EPajoQEw6-mG15rtAA9j0ndD5c5SY_1779174718
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

Hello Noah,

On Tue, 19 May 2026 at 09:07, Noah Bloom <nbloom@nrao.edu> wrote:
>
> I've been running a third-party script that installs DPDK kernel modules =
from the DPDK.org git repository and it has recently started failing with a=
 502/Bad Gateway error.  This was previously working as recently as May 14 =
(4 days ago) but has been happening since at least May 16 (2 days ago).  Is=
 this expected?
>
> Here is the specific error:
>
> $ git clone http://dpdk.org/git/dpdk-kmods
> Cloning into 'dpdk-kmods'...
> fatal: unable to access 'http://dpdk.org/git/dpdk-kmods/': The requested =
URL returned error: 502

Thanks for reporting.

The issue was global to dpdk git repos, not only the dpdk-kmods repo.
I had reported the errors to Ali, and this issue should be fixed since
yesterday afternoon (CET).


--=20
David Marchand

