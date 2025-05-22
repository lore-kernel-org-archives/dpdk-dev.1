Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E046C54E65
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 May 2025 13:00:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C7883402E5;
	Thu, 22 May 2025 15:00:55 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id B9CD4402E0
 for <dev@dpdk.org>; Thu, 22 May 2025 15:00:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747918853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LgFRezh1Q0dMIYRa5LMSBwUjUqY+jTgZxAUm52D6cfQ=;
 b=VEFPQiLmp2VBLVfK2kHk2bMy1pRRdEsoh+N+QDk53gmJsVhflLLeDT9HGFZryHSgTDW94M
 Fq4yHv6FPN58vReQrtiskiSnHTAXjOvdm5YtoR/psIHacpUAR9rQ5F+S9U4TLgxnSXZ6wq
 I5it9MSWaIh0WRpfrfsJNFFPikRjtnI=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-WYdEWLiXPw6NEVQu1g8ELQ-1; Thu, 22 May 2025 09:00:51 -0400
X-MC-Unique: WYdEWLiXPw6NEVQu1g8ELQ-1
X-Mimecast-MFC-AGG-ID: WYdEWLiXPw6NEVQu1g8ELQ_1747918850
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-3292a313051so23802971fa.3
 for <dev@dpdk.org>; Thu, 22 May 2025 06:00:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747918850; x=1748523650;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LgFRezh1Q0dMIYRa5LMSBwUjUqY+jTgZxAUm52D6cfQ=;
 b=ucXBBwanV3mds0GDaUkjQQUMMOq22kAucMpG9pTHVGQxuDmZzSvQ2sALt0McMKBd8f
 1Cs0+53PsSLz+aXVkbLZRJXMZc2EubxF/vUh7AYTVWVXMDdU+47xTUrAC8VjISmz3wmo
 A/tWfLT+Tzf1wthT6+/C8CQwkW9yCMoQTkmj4WgZWAKAW4cPkTTFrJiwNCe5b/HDWZfa
 PAm0SyMROWJZkwRtGJSH+iT6QBhKIyAzRqnX9avrgYv/wbQEgSxhKaDChofiC48QqawP
 AvqH7QHxaWJGO7o9mwjzqR5nhzVlUBYWAFbhsZj7kHLiRv4g12Lp1KJI1DJV4Fq/6QuV
 D+0Q==
X-Gm-Message-State: AOJu0YxPSVlEBwoPfMp8Z9Yj1UsSSgfvSzN+jYASD7ra+41ieIdWQ/t/
 qI9ZDgAByA4WrRP3JOyyIphwptl6TEWbm3kZVaBG+FSpc6mtKuUT9R1GxyeiyhbK/3YvZTmWjoP
 Ov3ND1bBphPC85RMKoCjud3puEei4zeM2LqLD1RH/8yf/nSUzMSue48BwaTE8ZaGcZiqUc2mOY0
 p+nAtidqLCJxeBbY7anv4VMzdiTG2yhQ==
X-Gm-Gg: ASbGnctpAuPoeXFGSBdmiYrfyQQXlDwvEaBndEvuPphYMXSydv4hjNwRZfOPHFuZjJp
 zGNNFsqhG0aR9blqZ1QUWHVTyIvhdS2qg1wr2j+K0M+hUIpzItsWPmOFVBb6+T8Z3Ef+C3is=
X-Received: by 2002:a05:651c:3243:b0:30b:a187:7a77 with SMTP id
 38308e7fff4ca-3280969820dmr62640971fa.4.1747918849443; 
 Thu, 22 May 2025 06:00:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEd2KPn4rMbK1wQKHHVz3TCJSOzqpR2GSJSQh1qgu7F5oVQ1XONbIbNMVBz8fGYOHp2+Wb+XbdZ19sYSpv5cyo=
X-Received: by 2002:a05:651c:3243:b0:30b:a187:7a77 with SMTP id
 38308e7fff4ca-3280969820dmr62639691fa.4.1747918847544; Thu, 22 May 2025
 06:00:47 -0700 (PDT)
MIME-Version: 1.0
References: <PH7PR12MB91737F14D62A8ADDCAE475CDDA99A@PH7PR12MB9173.namprd12.prod.outlook.com>
 <aC7o9q3zGx9d0FG_@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aC7o9q3zGx9d0FG_@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 22 May 2025 15:00:36 +0200
X-Gm-Features: AX0GCFub9svbw--6iK7ftq4kKoUfKDmIDHU--P-RW7Z-ypFkbhteL0ka84CLy2w
Message-ID: <CAJFAV8y7eON8eJM_iLP8zfXv3bXqCLmzGdog0N1PDKEEM7dm2g@mail.gmail.com>
Subject: Re: Addressing git.dpdk.org downtime
To: "dev@dpdk.org" <dev@dpdk.org>
Cc: Ali Alnubani <alialnu@nvidia.com>,
 Bruce Richardson <bruce.richardson@intel.com>, 
 Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CccOxDpOzGlyXTip92hN2LXglzUDn9zQ22DCmB_kojU_1747918850
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

On Thu, May 22, 2025 at 11:06=E2=80=AFAM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Thu, May 22, 2025 at 08:36:28AM +0000, Ali Alnubani wrote:
> > Hello everyone,
> >
> > We=E2=80=99re aware that https://git.dpdk.org has been experiencing ava=
ilability
> > issues lately, largely due to abusive bots and crawlers overloading the=
 servers and ignoring traditional controls like robots.txt.
> >
> > To address this, we're preparing to deploy Anubis, a traffic-challengin=
g tool, to help ensure reliable and continued access for the community, sta=
rting with our cgit instance. This approach has been adopted by several oth=
er open-source projects recently to reduce disruptive automated traffic.
> >
> > Please reach out if you have questions or encounter issues.
> >
> > See: https://github.com/TecharoHQ/anubis
> >
> > Thanks,
> > Ali
>
> Thanks Ali, (and others involved) for taking action on this.
>
> To everyone else in the community, just a reminder that, rather than
> accessing dpdk.org site directly, you can use
> "https://github.com/DPDK/dpdk" as a source for getting and browsing the
> DPDK source code. The github mirror is always in sync with the main tree,
> and, as an added convenience, also has the various "next" trees mirrored =
to
> it too. This means that you don't need to clone multiple trees to get e.g=
.
> next-net tree as well as main tree.

To add on top of this, we discussed some additional mirroring during
the techboard in Prague to ease life for (lazy?) maintainers and users
who are not confortable with manipulating different git repositories.
One request was to add mirroring of the stable branches and tags in a
single repository with the main DPDK branch, and the DPDK/dpdk github
repository seemed like the best location.

I have just set up this mirroring down to 20.11 branch.
The DPDK/dpdk github repository now contains most (if not all) of the
active branches and tags.


--=20
David Marchand

