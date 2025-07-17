Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BBCC83F1B
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Jul 2025 08:36:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9E0DE402D7;
	Thu, 17 Jul 2025 10:36:53 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 6500E400EF
 for <dev@dpdk.org>; Thu, 17 Jul 2025 10:36:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752741412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nQf+PxUjFdgwuzR3b2ZEPam9LCd4Bs0MKU+U/5d1d/U=;
 b=LTnE5UmPvB2J4+ttpePTfsJjbBL/LVd8H1B5/55+q9NDu2r9qyHr/ywdGhYSpK6wj6Smxb
 /rHLp0c3Wgb/FcKrRi/fGejDNHXP50SBqqz0u8/9lTFOw4E+L9Fqc33bry6+CKqTj6iK69
 yRXqQt8H8NIoiQTR4oWXkd5JtCBsXUw=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-8YHtrn4JPOutS6SMZf6XSw-1; Thu, 17 Jul 2025 04:36:45 -0400
X-MC-Unique: 8YHtrn4JPOutS6SMZf6XSw-1
X-Mimecast-MFC-AGG-ID: 8YHtrn4JPOutS6SMZf6XSw_1752741404
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-32b3162348fso3170361fa.1
 for <dev@dpdk.org>; Thu, 17 Jul 2025 01:36:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752741403; x=1753346203;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nQf+PxUjFdgwuzR3b2ZEPam9LCd4Bs0MKU+U/5d1d/U=;
 b=hKuyGqnIUNMDKIKwKknLpvrhXhhGMLseWqeHdH7ieYnSkv13LHOa8K35CBSWW2FEZe
 9YUI/A+vCOlHTqZRZDYmSmuoDkHgZ3PIxwic/Ur9njmNFyrIHWhsCErDbLC/ZQhD0Qwa
 azP+vkemcyR1HOpkcxVn2Nr/TY5aA0sWdvM8tQr8RqwA2Z4aQvSUt0yUCHyjXetNd5vW
 pHuRAm0uLo005eqM9t6SwkkaHK7J6twmdbx6v8Rd85SpB6YYipXJQVKJ1F0gEWwiH/MA
 lAOpDpH51eRs78LzQI3MQ/44Y3VOKzER9G6Q3Okqqmp2MjEE4hnV5w2QqiNSI8ukGWf9
 Glsw==
X-Gm-Message-State: AOJu0YxUJOwX1eKFj+ma5zLgbnGePAWdKMx+18QAi9DfWhrO7n+O/Xc5
 MZqWANmS/P7ZCoN5amqHRf85hh6OKEg11n9vE8y3AWzU9qeaH9X0EQDIShlx8Li65TPFGXwJqCF
 AyugcHY7o5uthcdYe1bU+A5PwSQTAyhCjl9rvWJ7pTFlkMsOrhxlK7dwNqzm4d4QyLWUa8LP2Q4
 i5EU2H+X3WYqM1jj6ssOY=
X-Gm-Gg: ASbGncsY4kOv6z21UcWfuVfbmswEje764wzui1Se1zNY1yU4LvDbpQnh88J9a/93hrY
 Hh9rGIXTV8qH+jnJ+mgSpo1uTcRy1Q4ZAvt2PEWPs+wo+pGpFopGOs5mPZQjXhmRlysWABbvDmP
 uhfv7dFf7Dq32uVasv0CAC10s=
X-Received: by 2002:a2e:b5a4:0:b0:32a:826a:c9d9 with SMTP id
 38308e7fff4ca-3308e365711mr11116881fa.5.1752741403501; 
 Thu, 17 Jul 2025 01:36:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGo1+UMkawwbZwHQgjH6Y3v5T2t1gCIwTCDKsIOOoGJiOyWaNpwu/S7ChX4/VnMq9zKwHP1RFASA4cnnptCInM=
X-Received: by 2002:a2e:b5a4:0:b0:32a:826a:c9d9 with SMTP id
 38308e7fff4ca-3308e365711mr11116781fa.5.1752741402864; Thu, 17 Jul 2025
 01:36:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250716173922.688476-1-bruce.richardson@intel.com>
 <CAJFAV8waeOp1euderd+t2VTfTfree-rratig_qq+eCGnJgTq5w@mail.gmail.com>
 <aHi1Nnvl4_ezD74S@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <aHi1Nnvl4_ezD74S@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 17 Jul 2025 10:36:31 +0200
X-Gm-Features: Ac12FXwKtDIWsVOECt14hOq9bMZEU_r1vxzmuwP9tmjZskuCe_juikYdDHnjAJo
Message-ID: <CAJFAV8xu0D272PkB3TKK1H59HA+QEE_sKqtRAo=ss41MHeQQqw@mail.gmail.com>
Subject: Re: [PATCH] net/ice: fix assumption about tag placement order
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XUE-KfGGhRVDPaucSb2uqZgngJILoxkJ6aZ9Jb4WOqE_1752741404
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

On Thu, Jul 17, 2025 at 10:33=E2=80=AFAM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Thu, Jul 17, 2025 at 10:19:24AM +0200, David Marchand wrote:
> > On Wed, Jul 16, 2025 at 7:39=E2=80=AFPM Bruce Richardson
> > <bruce.richardson@intel.com> wrote:
> > >
> > > The specific placement of outer/inner VLAN tags in E810 and related N=
ICs
> > > is configurable. Therefore, remove the assumption that if the L2Tag2
> > > field is filled in, that the L2Tag1 must also be. Instead, check the
> > > existing mbuf VLAN flags, and move tags and set flags as appropriate.
> > > This fixes an issue where, with QinQ packets with different Tag ethty=
pes
> > > (0x88a8 vs 0x8100), we get an mbuf reporting two valid tags, but only
> > > having had one tag stripped.
> > >
> > > Fixes: e0dcf94a0d7f ("net/ice: support VLAN ops")
> > > Cc: stable@dpdk.org
> > >
> > > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> >
> > The ice code seems copy/pasted from i40e.
> > So I guess i40e is affected as well.
> >
>
> I'll investigate more. These fixes I intend for 25.11 anyway, since I'd

iavf has a similar helper.

> rather not risk them late in the 25.07 release cycle.

Yes, too late for the current release.


--=20
David Marchand

