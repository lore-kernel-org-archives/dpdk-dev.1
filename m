Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7F0CE8D4F
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Nov 2025 16:48:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D095410D2;
	Fri, 14 Nov 2025 17:48:20 +0100 (CET)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by mails.dpdk.org (Postfix) with ESMTP id CA0AC40EE2
 for <dev@dpdk.org>; Fri, 14 Nov 2025 17:48:18 +0100 (CET)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-b55517e74e3so1783089a12.2
 for <dev@dpdk.org>; Fri, 14 Nov 2025 08:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763138898;
 x=1763743698; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6022DqZYczi16rxF1sNBqLXj/Hc+zwo0J/05ee/Cy7g=;
 b=VJD0CfgQemYXSbb2EtEMXSSTRNqlmhXtRfoWrejMEBgoI62h7Ay3J8M2tM5HXLnVTY
 ksmay7GMZDMH9lo7/KK3m5kzcpxxVTyVG1PVRqqI0rlSsyGMOvrPReLqFTF2P3jOQVR3
 B5/16nrE6IgQLix3LWU56Vq7GaG6PlLDO5myRrhdMcvJyLOf0SzPp78/yxl4DzKuHcoQ
 UO2TZzRWJTQ5tqzpoTAOpMmFGX0is+nzqe+IVx27SgSkUd3FPHeGp3wn8i+xCntPJrO5
 PLWmmnGQ4gUOIDIqb8d2u+H0vyOXWzehtNmYC4NqqOXY/7dYHpb8ui/2gfSPavrR9eJj
 qbtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763138898; x=1763743698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6022DqZYczi16rxF1sNBqLXj/Hc+zwo0J/05ee/Cy7g=;
 b=g4CEY+4qYs6vHePOezsKUs+/FWjZEe1w9fFHtC+d1FbbkT74ijN5KOnrswAH20RWQh
 +lAeZjCInZ2EwqzaMpD/S/W4yhPEvDjcUWFhIz/rm8CJsaaFUnjZBe4MO3epyNFGyI9q
 cMlZEeg5e1ZpBBoc3Cnhod8xtvk9t191ZDOlh3ZKqG3kJvnfCyrBx1+8A8+SCxijwELB
 f4NU+wjsnmVh64pD7t8tsTV5Qlz0naVRqFYoOY53AadXEamAxFh7bDIMO52B/Hxr3Bxx
 ZF+HRqNY2DprP1epHFW+m9/VGzriRAOz0My/jzJDwFEJf2vd7P16ujtCw8RfTYr84k40
 fxzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWg6a5CD+d1b0SQUTUQALqcWMqQcyRiCCiWTmo+Y+nQZU/UB52x3BB83MJR9Vchi80zkeE=@dpdk.org
X-Gm-Message-State: AOJu0Yzq7C79Sq0SJzAhMfoLTCCePnILDSF1MEm9HrkXfK73l3WZxFgl
 ok3Az7CwoNvfE3b2x9btoE9DjrDJGyHo3q/rqnwWQ6cb1Fim+LzolgQNjyhdr1olipw=
X-Gm-Gg: ASbGncuLQM12q/K/oNMiwwytJIDLLGI4gfKCzOInA9yDhXt9kQ9gsfKn8c0Qgbrcya1
 KCZMaxEnyXsJ276MTMCOhl/NQ0Bi4hj+pUoXW0ZGxyW/n4dnz7o1eW3KJRaK046sOSVEsVRStQo
 b+5oMUJw1544O9bV6DDRXUkLgz/GrpOXjiq/O6Z5+lTBDYDy7sk9qg9CcMjL03flU01RqsMCTA9
 b4ZviypuLu6cIvbL5qD1FvdHEYsmEBLJeP/LuqC65R4FJlD4Pg8Om2gWojx7G4nIMlfBDD8IRLC
 dDhxRbPhNe0O8uWvOfHrLDkiWtVrxfi4+s2S4nPYfxjVCKPLqo/99OqxXLmIrmKiaREtoRHyIws
 4Lbc921vQU3qJXZIGjOW9PNjci140T4lHdQfPZeVKxTOqubOx+VmQgjbXD4PgXHfT+Tc35iPazd
 gTvQhfm9GeI815SrEigo7qTBH7kXboJZ2AGC0nu+WzTS99
X-Google-Smtp-Source: AGHT+IEAUHr9eC3Y5i055ljtDmO5R3mA7UvbEQJUDkHCkSQX20WZwpQZ7fkWWyU+nUFJGxe+vQBSQQ==
X-Received: by 2002:a05:7022:b902:b0:119:e569:f61e with SMTP id
 a92af1059eb24-11b4140731fmr791189c88.23.1763138897708; 
 Fri, 14 Nov 2025 08:48:17 -0800 (PST)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-11b060885eesm11507900c88.1.2025.11.14.08.48.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 08:48:17 -0800 (PST)
Date: Fri, 14 Nov 2025 08:48:14 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: "Robin Jarry" <rjarry@redhat.com>, <dev@dpdk.org>, "Christophe Fontaine"
 <cfontain@redhat.com>, <stable@dpdk.org>
Subject: Re: [PATCH dpdk] net: ipv6 link local compliance with rfc 4291
Message-ID: <20251114084814.039d2949@phoenix>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65560@smartserver.smartshare.dk>
References: <20251114105751.54802-3-rjarry@redhat.com>
 <20251114080532.1e86d13e@phoenix>
 <98CBD80474FA8B44BF855DF32C47DC35F65560@smartserver.smartshare.dk>
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

On Fri, 14 Nov 2025 17:14:32 +0100
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> > From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> > Sent: Friday, 14 November 2025 17.06
> >=20
> > On Fri, 14 Nov 2025 11:57:53 +0100
> > Robin Jarry <rjarry@redhat.com> wrote:
> >  =20
> > > diff --git a/app/test/test_net_ip6.c b/app/test/test_net_ip6.c
> > > index cfc550940306..e4642c9a39d9 100644
> > > --- a/app/test/test_net_ip6.c
> > > +++ b/app/test/test_net_ip6.c
> > > @@ -160,7 +160,7 @@ test_ipv6_llocal_from_ethernet(void)
> > >  {
> > >  	const struct rte_ether_addr local_mac =3D {{0x04, 0x7b, 0xcb, 0x5c,=
 =20
> > 0x08, 0x44}}; =20
> > >  	const struct rte_ipv6_addr local_ip =3D
> > > -		RTE_IPV6(0xfe80, 0, 0, 0, 0x047b, 0xcbff, 0xfe5c, 0x0844);
> > > +		RTE_IPV6(0xfe80, 0, 0, 0, 0x067b, 0xcbff, 0xfe5c, 0x0844);
> > >  	struct rte_ipv6_addr ip; =20
> >=20
> > Reading the kernel source there is also special handling to include
> > device
> > id into link local address. This is to handle corner case where
> > multiple network
> > cards have same hardware MAC address. =20
>=20
> Multiple physical NICs should never have the same MAC address.
> Lots of stuff will break if they do.
> E.g. a network switch will forward packets to the NIC that most recently =
sent packets, so its MAC address was learned in the MAC address table in th=
e switch.
>=20
> What is the use case justifying this tweak in the kernel?
>=20
> >=20
> > Perhaps DPDK should roll port id into link local address? =20

It is allowed for multiple NIC's to have the same MAC but they
can't be on same network namespace.

Code in Linux is working around special case here:

static inline int addrconf_ifid_eui48(u8 *eui, struct net_device *dev)
{
	if (dev->addr_len !=3D ETH_ALEN)
		return -1;

	/*
	 * The zSeries OSA network cards can be shared among various
	 * OS instances, but the OSA cards have only one MAC address.
	 * This leads to duplicate address conflicts in conjunction
	 * with IPv6 if more than one instance uses the same card.
	 *
	 * The driver for these cards can deliver a unique 16-bit
	 * identifier for each instance sharing the same card.  It is
	 * placed instead of 0xFFFE in the interface identifier.  The
	 * "u" bit of the interface identifier is not inverted in this
	 * case.  Hence the resulting interface identifier has local
	 * scope according to RFC2373.
	 */

	addrconf_addr_eui48_base(eui, dev->dev_addr);

	if (dev->dev_id) {
		eui[3] =3D (dev->dev_id >> 8) & 0xFF;
		eui[4] =3D dev->dev_id & 0xFF;
	} else {
		eui[0] ^=3D 2;
	}

	return 0;
}


