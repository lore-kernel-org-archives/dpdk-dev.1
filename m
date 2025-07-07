Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 253F3C83F07
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Jul 2025 14:48:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E67F340287;
	Mon,  7 Jul 2025 16:48:37 +0200 (CEST)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com
 [209.85.219.42]) by mails.dpdk.org (Postfix) with ESMTP id 38F7A4025D
 for <dev@dpdk.org>; Mon,  7 Jul 2025 16:48:36 +0200 (CEST)
Received: by mail-qv1-f42.google.com with SMTP id
 6a1803df08f44-6facc3b9559so54206626d6.0
 for <dev@dpdk.org>; Mon, 07 Jul 2025 07:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1751899715;
 x=1752504515; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JDRj3AsesbRVoPxneo22eF1SV0+p3qvsdSCrqArhDAw=;
 b=rPfw820d/06/91OrKmFjZ1vxVXnahM+2ao7e33CW9Ocgb76RBw31YdqaywkKvgBAXk
 elJ42v7KPmgbA0/89Nc9P7/aE+iOxEtwZaHQd7gOLom6pWsq4d9xXvhMGsvps7WiSpny
 r1bZXpyp8JclR1/auWKxmaJBkFB+SB0m+TcexX1Tdq68re3ZPSXn94lABJTu5iDwExxr
 GAO5p+e5v2c1LZSKDAY3jTfiVe7TcgTvk5gU7CnI64uFJXNZ38l1FPOpRBc0K+q+2b7o
 tw3pMPHEhnfUGfpO2ceV3wwUc6V+R758uRYG+HlhPM0faNONrkOq6yJ5kpZtg1FNwG1J
 1gqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751899715; x=1752504515;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JDRj3AsesbRVoPxneo22eF1SV0+p3qvsdSCrqArhDAw=;
 b=dkvdtDoBC52LciLF0Fk9HGSCogZUhcSibf40PdNd6blph7QYqrgaXRnKgeLUO4siDg
 xi0pD3b6FeFCyNicrsmpGzlEpsNBvRo7ULoB8piQqVUeuCot0IhqXo9bwN1MOutFIP/p
 NJIcFtQK3x4klnhrCyV3RYLhEe3fXbxlEfvFW9+7t7oAUqMTkw8VtCpSDonXkAryV1LN
 BBXGjpw9ml91SHz2YdIXT5/cPYcEECk9Slkk69XSeH1kP8+/eCXrSfv3T8vMASUNPG0C
 aKNjUMhhGcUTluw/6T0YUfOpbOSCkVL9rTIPjsQN73AQl5DC4hljQ4FQIipwdx7lexC7
 VkOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUn+7doCelEMAS5BoeJoejJkp5paG8cca/9PFn8ikHmpt4WpwBvJJqzKgJHRtD3413lsLU=@dpdk.org
X-Gm-Message-State: AOJu0Yw+WPK3WiZjN8vkkY1P/nOb77f0AXDKBUTXyFeK9d6Y3u+oWmCK
 zmmgr3A5HKn4sfmJR10Gh31Vf9BTt3IPSYoCiAY3wmwk2zJCP3QzUZxqoM7WqSF25ZTaGefaQKO
 whrOI
X-Gm-Gg: ASbGncthB0iIJ9z2116yk2oPT6pY5YqrgOIyuhgFiwTtUqeVAYLCyHdU49c+6Xanrw3
 aRBScr7ESywb7AB7QetJhx/jfl8hQbNxN9UCGtC4pPmWzVFVSQ8cnV3I6OE1wUg9eV2c+gyIfo/
 dyaxlGitag4P6G3GDxWfWaXReX6ksmobLysJbB207yQojU2VOGEvYKBWc/mmkugdUXcK3l78S9/
 d3bPHUhtnVU+ik+3FAn646g2EUlIKicXNAThbnxWrXgVtcM6IbV+FFNhWoADi8iZFB+Gy6NvVKt
 OLOaleXsuaceZHPjIFd5WSQHVfGBp8lQIt41I5GeVrPR/sEibH8g/AHFaYUB6XWmR/q/GqYLHmm
 1W9QGj1l7rlhNzYSMbIrfa3UliTjfZ+My8tgJnac=
X-Google-Smtp-Source: AGHT+IEF6uWqwkhwXHLpz/HcbJZa5uvpwxVeojrF3d6bKJBf7VFA4ixYrFz2eZ/BKDKQFt3WLU2UCg==
X-Received: by 2002:a05:6214:762:b0:702:bb80:a828 with SMTP id
 6a1803df08f44-702c6d65359mr164625526d6.24.1751899715298; 
 Mon, 07 Jul 2025 07:48:35 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-702c4d5099asm59623686d6.69.2025.07.07.07.48.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Jul 2025 07:48:34 -0700 (PDT)
Date: Mon, 7 Jul 2025 07:48:32 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: "Mario Kuka" <kuka@cesnet.cz>, <dev@dpdk.org>
Subject: Re: [PATCH v2] mbuf: add new ptype for slow protocols
Message-ID: <20250707074832.6ce5fc6d@hermes.local>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FD94@smartserver.smartshare.dk>
References: <20250704084502.237979-1-kuka@cesnet.cz>
 <20250707075100.15034-1-kuka@cesnet.cz>
 <98CBD80474FA8B44BF855DF32C47DC35E9FD94@smartserver.smartshare.dk>
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

On Mon, 7 Jul 2025 14:47:17 +0200
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> > From: Mario Kuka [mailto:kuka@cesnet.cz]
> > Sent: Monday, 7 July 2025 09.51
> >=20
> > Introduce a new ptype for identifying slow protocol packets.
> >=20
> > Signed-off-by: Mario Kuka <kuka@cesnet.cz> =20
>=20
> >   * <'ether type'=3D[0x8847|0x8848]>
> >   */
> >  #define RTE_PTYPE_L2_ETHER_MPLS             0x0000000a
> > +/**
> > + * Ethernet packet type for Slow Protocols.
> > + *
> > + * Packet format:
> > + * <'destination mac'=3D01-80-C2-00-00-02, 'ether type'=3D0x8809>
> > + */
> > +#define RTE_PTYPE_L2_ETHER_SLOW             0x0000000b =20
>=20
> I'm not sure that we want to register individual packet types for Layer 2=
 control protocol type packets, where the packet rate is very low.
>=20
> Consider the endless list of vendor proprietary Layer 2 control protocols=
, such as Cicso Link Layer Protocols, Realtek Layer 2 Protocols, MikroTik R=
oMON, etc. The list would explode if we started adding these.
>=20
> IMO, only data carrying packet types (IPv4, IPv6, PPPoE, etc.) should be =
registered as individual packet types. The rest should be sorted manually b=
y the application.
>=20

The original purpose of ptype was to handle cases where hardware has offload
capability to identify these packets (like IPv4, IPv6, etc). It doesn't mak=
e sense
to me to have all the possible protocols there.
