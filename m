Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09133C369AE
	for <dpdk-dev@archiver.kernel.org>; Sat, 12 Apr 2025 16:57:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E7A9A40156;
	Sat, 12 Apr 2025 18:57:04 +0200 (CEST)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mails.dpdk.org (Postfix) with ESMTP id C7CA640041
 for <dev@dpdk.org>; Sat, 12 Apr 2025 18:57:03 +0200 (CEST)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-22435603572so28740215ad.1
 for <dev@dpdk.org>; Sat, 12 Apr 2025 09:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1744477022;
 x=1745081822; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4p7KwrqUm3pGaiMqG71/lAH8Tc89yKBMHpnrC9pxUy4=;
 b=K4cg6m1bynQLXmY/VYGGYNOeYZ1jVGMY7sY40NkT36pPeglvCy5FS2ZM50vHB/TswN
 1Oj5oq4N5SdsF2bPgEKlUI/JFFepF7DBrmdP8cP/IBvOVfJOYEW95eA5Dr/osMhLTEu8
 75tC6XYKM2gKCL+KSdquk2BmvlXPKRmyA/Av1S3+vrUeSnlgpojfzQ9pIyBGuzxIA18c
 GFyY6/WLNRkI4KzYMbZ8sAOs14goos1nwQgkaET8jy7qHo1bFl6XSWJn1Nw01eKgsR8b
 7knfOcKaSZoMvZW2rRsoCKHIoDB68zHjiQa+LhfpuPv73kJsb+UnSCSmy9DHy0e7/cN0
 3DLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744477022; x=1745081822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4p7KwrqUm3pGaiMqG71/lAH8Tc89yKBMHpnrC9pxUy4=;
 b=asBT77KHbL6q00mAhYGnSVP9f+ioO5UFP2oVLtZE5lZ3K/BIsyoQGmBRxad6mB6Uy0
 BcAI0rru3W6YMyQMIoDnIlq4H4CEYMZvR6g0rWRE8oWCxK1+Rqtig+fHEitGcRUV+SbE
 8bSA9DrRpprf85gb8qE92YvfR8ywputcWbzuKTnc5ZTuBPrQT9YdAfWz8+CGY8OgIEjI
 0cq/7d3P6pQZL4tzntxbr87UCckafQq1g8dlWg+M11CYaf1I0z5//hFETQyEBA2sbQI3
 ZwOVBQv/e68LQhVAx081mKeqfGmf2YcueYUEaBzddqS1cK8x3nbacvALFVfYIB7vtG1Y
 ajxw==
X-Gm-Message-State: AOJu0Yzx91Gvlspo2tB6MUOIu+BKDCGSbJE2LbirfhyrMxgAviy4+O4O
 SGePjiVnFlgCNw3j3SMEcpnesHyYOXceQ8pp+VC7GZn5HNiHvVViqWoNlJyl5teVIgrFVAPaFw4
 c
X-Gm-Gg: ASbGnctzETjB7ahewOnE6ZHCH6mJ6QbfMUK5RXqvwtgs1mKeh+RwRvE/SoGtKClCvUP
 casNwUssAnrahnH3T+14kXrqVvE53mPrpPHyoqmzPOP87wH88i1Ll2BeMDBEFIDGFiPrDQjOSlg
 xiF6lqQXatROdJfUUvV3daYJ4DCBUuCYM3IlPiwgvHpTL8TL5h3aq6TFxX4pBgBIYYgsVzgNuvd
 3wXqtfKAh+rmviAow/5/KoDXcbCFYG/aj9pEaVXt5bxwXOvbOlIXqTVf4p+durBvBfaimlO2+58
 U+iBcX+5t/ibHEig/+enPxbkxMdEW1mcOl9dBNWM4qJaBQ4wCjHdyBLSffm0uJATe+zxqarAphl
 Zlp/i3CwGjYHkICCW
X-Google-Smtp-Source: AGHT+IHrqhkYMXGpMDcP5TH4ohxaHn5WgxqehED4VvzmhWidJXWpjgJ+ZfDNRzu+yazPsXV0F3jVew==
X-Received: by 2002:a17:903:3bd0:b0:223:5525:6239 with SMTP id
 d9443c01a7336-22bea4efe9bmr114377335ad.38.1744477022197; 
 Sat, 12 Apr 2025 09:57:02 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd21c670esm3716582b3a.69.2025.04.12.09.57.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Apr 2025 09:57:01 -0700 (PDT)
Date: Sat, 12 Apr 2025 09:56:59 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: <dev@dpdk.org>
Subject: Re: [RFC 08/13] mbuf: add fields for mirroring
Message-ID: <20250412095659.5f5719e8@hermes.local>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FBC8@smartserver.smartshare.dk>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250411234927.114568-9-stephen@networkplumber.org>
 <98CBD80474FA8B44BF855DF32C47DC35E9FBC8@smartserver.smartshare.dk>
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

On Sat, 12 Apr 2025 11:59:10 +0200
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> > From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> > Sent: Saturday, 12 April 2025 01.45
> >=20
> > Add field to union used for sched/event etc, for use when
> > an mbuf is mirrored.
> >=20
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> > ---
> >  lib/mbuf/rte_mbuf_core.h | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >=20
> > diff --git a/lib/mbuf/rte_mbuf_core.h b/lib/mbuf/rte_mbuf_core.h
> > index a0df265b5d..1806dddd67 100644
> > --- a/lib/mbuf/rte_mbuf_core.h
> > +++ b/lib/mbuf/rte_mbuf_core.h
> > @@ -589,6 +589,14 @@ struct __rte_cache_aligned rte_mbuf {
> >  						 * @see
> > rte_event_eth_tx_adapter_txq_set()
> >  						 */
> >  					} txadapter; /**< Eventdev ethdev Tx
> > adapter */
> > +					struct rte_mbuf_mirror {
> > +						uint32_t orig_len;
> > +						uint16_t queue_id;
> > +						uint16_t direction;
> > +						/**< Port mirroring uses this to
> > store origin
> > +						 * @see rte_eth_mirror()
> > +						 */
> > +					} mirror;
> >  					uint32_t usr;
> >  					/**< User defined tags. See
> > rte_distributor_process() */
> >  				} hash;                   /**< hash information =20
>=20
> Stop overloading the "hash" field!
>=20
> We now have dynfields. The mbuf structure's dedicated fields should be li=
mited to absolute core features.
>=20
> Long term, the "hash" field should be cleaned up.
> E.g. if we get rid of the Flow Director and make the 8 byte "sched" (Hier=
archical Scheduler) a dynfield, the "hash" field can be reduced from 8 byte=
 to 4 byte (RSS hash).
>=20
> I acknowledge that some mbuf fields can be overloaded and thus used for m=
ultiple purposes - i.e. a value only used for ingress/forwarding (e.g. RSS =
hash) can share an mbuf field with a value only used for egress (e.g. Sched=
uler).
>=20
> The overloading of the "hash" field is too much already. E.g. can the Hie=
rarchical Scheduler be used together with the Eventdev ethdev Tx adapter, o=
r are they mutually exclusive due to sharing the same mbuf field?
>=20
> Going to the extreme, we would completely replace the "hash" field by dyn=
fields.
>=20
> In short: Overloading the "hash" field with port mirror information is a =
step in the wrong direction.

Short answer: Dynamic Fields are hard to work with primary/secondary proces=
s model.
The goal was to allow dumpcap to run and just work without modifications to=
 the primary application.
If secondary creates dynamic field, the primary doesn't see it.

The hash field is not going away, flow director is stuck, it has been sched=
uled for removal
for 3 years and Intel still needs it. Other uses such as storing received h=
ash value are
still needed.

Long answer:
It maybe possible. The patchset went through many revisions during developm=
ent.
Ended up having to have MP server for start/stop, and if that code was exte=
nded
to allow secondary to proxy setting up mirror, then the code in handling mi=
rror() on
primary could also setup the dynamic fields. But accessing dynamic fields i=
s slower,
not that it matters that much if we have to copy mbuf anyway. Other option
would be to pre-pend a pseudo header that capture could then use.
