Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05455C3601E
	for <dpdk-dev@archiver.kernel.org>; Sun, 13 Apr 2025 14:31:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A64464025D;
	Sun, 13 Apr 2025 16:31:47 +0200 (CEST)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by mails.dpdk.org (Postfix) with ESMTP id 0602D40156
 for <dev@dpdk.org>; Sun, 13 Apr 2025 16:31:46 +0200 (CEST)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-736a7e126c7so2981713b3a.3
 for <dev@dpdk.org>; Sun, 13 Apr 2025 07:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1744554706;
 x=1745159506; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u9p1tYlgaZdA+5SoW4OFgtFO4GR4IhqyD0fMjl6yfrg=;
 b=E492z23xnFnPgCfVn6WmFUHCBCibWrTS4FBUYXbMx+OFofb2fSsB2yrKlBjpZ7s0sN
 kM9uKd3rol8x37MnbVLd4WfldaWxaUz+3re16KwZ38JFF8VWuyjI47cs1AP4iV8isrr6
 SolA9DXULir7ByYfqhYzrZ4xqbqYMb2Ee7Xo7VMzNLKGjIoZQoDJGUzg9MI/2ARQHBRL
 tNxnfewa7LkETy2NeGMsE03oXPYY/EbkN3vXxrXp6B2c0rlglT22ll3IFO9HPedBKKJ1
 PL1i/ppkwmRssHWd9/N7SjX55mhrEGmjSfopKCDTsGTotWsxSZ2zWXqGjvUEaRw4qODj
 +hag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744554706; x=1745159506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u9p1tYlgaZdA+5SoW4OFgtFO4GR4IhqyD0fMjl6yfrg=;
 b=jczBzrjk1mx3f/WUFMt1e/xXAzQhVCfEuakCIiTrafSCyvDl9vIkMo9gxkUen13LEt
 w6f6wgZMi5d5fdEvrpP/YbNanPXrhO2mp1Tu+r3QldrK+1FTgX8hWTbqDugQYCezEut1
 3moIcSJjpa/ufD7SV+sLkiHuwg7W+tjNB1oIHBCp86v28xrz+KCPhCbMflf5LGRr8SxK
 G4ogeSVhwZsskeQuf2gLB7LDnZH7V41XAX1/6H1RkcDLMQloflIGOUJhihx2E/qv9w55
 NNpQPUxp71OTfg3LOgEEcePT3MrN5opyhJTMccX0k+iC1GUkg3DPVmiy4wFJuerdJiH+
 Dagw==
X-Gm-Message-State: AOJu0Yy1ybQFYeJ5cP3eB6dkasTe+G0L0Mimw818x74rxLXc1Jh7pzgu
 trdgQJ8WEOzhMYgNCaawVcEEhYWmL2/4Hw3H+I38lICHT+rFNyaTBdW3BYn9rYSkrwyz1KTIFBT
 zXbQ=
X-Gm-Gg: ASbGncs8Kqa0IbB9rIr1jNY4yml33aySMzKFRxuiFEQ7ZZ/D8h0uAX8bnkN3IWPQZa7
 uJfynWdNspz3nJGZWsAqISHorLz1TrqaGR6Mc5Xyi9t2yAbrHZQUi7M2PZhl8bDOTzsn0sP87kh
 JuHFxdrHYX4YVcGlU+E3/8lyCTNOo6bJnZKAEToMuTRRg+nrK04cn23E+xMi8wDZFiLZYYkeLlK
 CsX3cdmazdl8PoLMRrSAu8Ljiz3P29ROfzDTOC8zwdhGfeabWxOIuMoBxosJvAGmL7PUFJSFub/
 KPfeECuWA8gHzkmQpIaAXqPLfAVu/Kc3DD9wWiMh1va4JFCpNBo109mjhXKsCJFWs3NaxTaVkOS
 dzgFONuIXWui+hPb5
X-Google-Smtp-Source: AGHT+IHZS0vgEwTu3Nv8bTnlbENKVTLF5DwOLycpnkmzKzW6FIosLt1LQwfWziPlTQCjEDNxXv69Pg==
X-Received: by 2002:a05:6a00:1886:b0:736:4bd3:ffab with SMTP id
 d2e1a72fcca58-73bd129c5ebmr10958139b3a.17.1744554705658; 
 Sun, 13 Apr 2025 07:31:45 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd23342ccsm4959216b3a.167.2025.04.13.07.31.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Apr 2025 07:31:45 -0700 (PDT)
Date: Sun, 13 Apr 2025 07:31:42 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: <dev@dpdk.org>
Subject: Re: [RFC 08/13] mbuf: add fields for mirroring
Message-ID: <20250413073142.452ca0f2@hermes.local>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FBD1@smartserver.smartshare.dk>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250411234927.114568-9-stephen@networkplumber.org>
 <98CBD80474FA8B44BF855DF32C47DC35E9FBC8@smartserver.smartshare.dk>
 <20250412095659.5f5719e8@hermes.local>
 <98CBD80474FA8B44BF855DF32C47DC35E9FBD1@smartserver.smartshare.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Sun, 13 Apr 2025 09:00:19 +0200
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> > From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> > Sent: Saturday, 12 April 2025 18.57
> >=20
> > On Sat, 12 Apr 2025 11:59:10 +0200
> > Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:
> >  =20
> > > > From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> > > > Sent: Saturday, 12 April 2025 01.45
> > > >
> > > > Add field to union used for sched/event etc, for use when
> > > > an mbuf is mirrored.
> > > >
> > > > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> > > > ---
> > > >  lib/mbuf/rte_mbuf_core.h | 8 ++++++++
> > > >  1 file changed, 8 insertions(+)
> > > >
> > > > diff --git a/lib/mbuf/rte_mbuf_core.h b/lib/mbuf/rte_mbuf_core.h
> > > > index a0df265b5d..1806dddd67 100644
> > > > --- a/lib/mbuf/rte_mbuf_core.h
> > > > +++ b/lib/mbuf/rte_mbuf_core.h
> > > > @@ -589,6 +589,14 @@ struct __rte_cache_aligned rte_mbuf {
> > > >  						 * @see
> > > > rte_event_eth_tx_adapter_txq_set()
> > > >  						 */
> > > >  					} txadapter; /**< Eventdev ethdev Tx
> > > > adapter */
> > > > +					struct rte_mbuf_mirror {
> > > > +						uint32_t orig_len;
> > > > +						uint16_t queue_id;
> > > > +						uint16_t direction;
> > > > +						/**< Port mirroring uses this to
> > > > store origin
> > > > +						 * @see rte_eth_mirror()
> > > > +						 */
> > > > +					} mirror;
> > > >  					uint32_t usr;
> > > >  					/**< User defined tags. See
> > > > rte_distributor_process() */
> > > >  				} hash;                   /**< hash information =20
> > >
> > > Stop overloading the "hash" field!
> > >
> > > We now have dynfields. The mbuf structure's dedicated fields should =
=20
> > be limited to absolute core features. =20
> > >
> > > Long term, the "hash" field should be cleaned up.
> > > E.g. if we get rid of the Flow Director and make the 8 byte "sched" =
=20
> > (Hierarchical Scheduler) a dynfield, the "hash" field can be reduced
> > from 8 byte to 4 byte (RSS hash). =20
> > >
> > > I acknowledge that some mbuf fields can be overloaded and thus used =
=20
> > for multiple purposes - i.e. a value only used for ingress/forwarding
> > (e.g. RSS hash) can share an mbuf field with a value only used for
> > egress (e.g. Scheduler). =20
> > >
> > > The overloading of the "hash" field is too much already. E.g. can the=
 =20
> > Hierarchical Scheduler be used together with the Eventdev ethdev Tx
> > adapter, or are they mutually exclusive due to sharing the same mbuf
> > field? =20
> > >
> > > Going to the extreme, we would completely replace the "hash" field by=
 =20
> > dynfields. =20
> > >
> > > In short: Overloading the "hash" field with port mirror information =
=20
> > is a step in the wrong direction.
> >=20
> > Short answer: Dynamic Fields are hard to work with primary/secondary
> > process model.
> > The goal was to allow dumpcap to run and just work without
> > modifications to the primary application.
> > If secondary creates dynamic field, the primary doesn't see it. =20
>=20
> I skimmed the mbuf dynfield source code, and it looks like it is designed=
 for primary/secondary process model.
> If the primary process doesn't see a dynfield created in a secondary proc=
ess, it is a bug in the mbuf dynfield library. I couldn't find such a bug i=
n Bugzilla.
> I would be much better to fix the bug than overloading the "hash" field.

The problem is that if secondary makes a new field, the primary still has t=
o lookup the offset.
And don't want to do that in the packet path. Need to invoke a control path=
 argument in the primary.
If primary always makes the dynamic field, there really is not much point i=
n it being dynamic.

