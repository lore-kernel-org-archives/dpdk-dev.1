Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14AF8FCC04F
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Mar 2026 17:35:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AA836410D4;
	Fri,  6 Mar 2026 18:35:46 +0100 (CET)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com
 [209.85.160.172])
 by mails.dpdk.org (Postfix) with ESMTP id 74863402E3
 for <dev@dpdk.org>; Fri,  6 Mar 2026 18:35:45 +0100 (CET)
Received: by mail-qt1-f172.google.com with SMTP id
 d75a77b69052e-506989e8516so80788071cf.0
 for <dev@dpdk.org>; Fri, 06 Mar 2026 09:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772818545;
 x=1773423345; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4JrCs0CbpVu0NgyVHo9Y95GveQ/pDF4WT4s+14R0KfU=;
 b=f1nLCI5fOermHKZvDqvbwUfcZfT85/LP6vTCo1DFeqBcFFkE5aoi3A+XJJTBKzYydC
 0uxRjoF1B3ZEBKzq1Y93B9jKYU6EBjQ2XVC20MeMZexEy+mroG2lBDsSIg0VAE/50/5Y
 jwXZXF0dFUoPwiII1l1ZXi7fCkIyXCdWISOMLB83VO1A7LxmMWVIXopENMbEDn715ziT
 9bThhHfcqbXCvsp7sLBubJDIDz9jcbVSzM1+whAgh4Wm4+RKUW0V3wTRRuZ9397rymVK
 5RP9vluLNHgOibu8iQNJR0MQB3H2Ae8fzEFa8y6+cWCjs9e5fFbwGnU/ENtvIGkEjh0t
 p98w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772818545; x=1773423345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4JrCs0CbpVu0NgyVHo9Y95GveQ/pDF4WT4s+14R0KfU=;
 b=EbJy7Lz3wpoBYa/nr6Uh2hOj13NKhVD3qLwL7LdsDWG58deBXe7X+1odpUsdQnPf8+
 O9qceZ3hFzCxB1UBOIjpRtjzvPdM9zPKPDu4cip1uZjNXu5D+JILEMD+4hvfpGUCuJmh
 JEK40exv6OI6wdrm1udjWN3o/u2CfZnhZgJ5igTq0chQULeGAHcS6m/6JhlStTcJWgGJ
 NWEmJCSEgtX0S7Cyl0tqIVCxfxIfydxYzN+ixfMk60NPMW0qjTf1t1ZkH31K/rgW8mOQ
 EcKy5ya4bJl0GoTAGd4wuN371a5FBXpX6kfDhnyQAC4xUWaDrATgOT72gKIUxZSweBt4
 gj/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVT1PLwF3ZBm/PLZQwA8eoF6KgUkotw0hvVTUm5En4FX1exyhP2kHEwOVBQvd+UXT4isPI=@dpdk.org
X-Gm-Message-State: AOJu0YzTw/A5uQdzFmbNbw+4N2+zcyC65TSQ6xZcT4z6zQnzwNK0u4Oc
 T0KMxsI6vevMz5r2M1Xamn8UMyESiFs3AFREqkQPivyLbvPW77JuZGDRGGgaA0vYXNs=
X-Gm-Gg: ATEYQzyr0AumOaa5+H9gOKwgcKQsjQfSa7Xl60GStcKsbGGBh8KiIE8IPvySaYq0fV9
 c6Uo4Xvz4y6AKfpCXxKba7xeAMS9BUixydFl6VIpfVnxW8uRKHZxx1F9NxCHWiEWyiXRARbYb7e
 UaGousObVCeSPFsq2rR2MFcsmUxF4I9uNZCdA1KKETdBddtqk/F/eLq1GtT+zaltJbfq3AqlOgC
 JInYKXs7uBzkky4VDkDVgeeR5ASK36SovwHnOYxnpltMOE9O3SO+n3Tl2Pf9kKloEf1vZKcH2oq
 hqiBfuDRuY9ji6+8vvvk+wiqZ6LsawAZt2rjZE1ykULhszrzqyrNUBlytP2c9SaoaCShAEaxlXS
 tv0P7Xg7si/Y9mrYcvAkdsJxv5RsUByu4Y1MkWYpx39PIqlECEwsKQB6Fedvaq3tq5NAw3aohxw
 5vQ/0ZXmJxzNi3yt1pPjrchhDJ3nakeHhpCLXVvc9AJt5gmlYwqgPJlnFCt58Xgh1f
X-Received: by 2002:ac8:57c5:0:b0:502:9911:d4f8 with SMTP id
 d75a77b69052e-508f497981dmr39392501cf.70.1772818544689; 
 Fri, 06 Mar 2026 09:35:44 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-508f650dc4fsm17045721cf.3.2026.03.06.09.35.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 09:35:44 -0800 (PST)
Date: Fri, 6 Mar 2026 09:35:40 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: "David Marchand" <david.marchand@redhat.com>, "Maxime Leroy"
 <maxime@leroys.fr>, <dev@dpdk.org>, <hemant.agrawal@nxp.com>,
 <stable@dpdk.org>
Subject: Re: [PATCH v2 11/17] net/dpaa2: fix software taildrop buffer access
Message-ID: <20260306093540.07cb4fde@phoenix.local>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65758@smartserver.smartshare.dk>
References: <20260218160453.142311-1-maxime@leroys.fr>
 <20260226143341.282188-12-maxime@leroys.fr>
 <20260226112154.7b2c51d0@phoenix.local>
 <CAJFAV8z0L-KLsNq6JCgaWsEmEaWUqH1rcH_rHcwWVkVisUAMfA@mail.gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65758@smartserver.smartshare.dk>
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

On Fri, 27 Feb 2026 22:29:34 +0100
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> > > It is unsafe to use free_bulk on transmit path because packets in
> > > burst might come from different pools. An example would be a router
> > > forwarding from two incoming NIC's to one outgoing NIC. =20
> >=20
> > Is it?
> >=20
> > IIUC, this helper was added specifically to handle mbufs from multiple
> > mempools.

never mind, that was old brain cells, looks like it got fixed.
