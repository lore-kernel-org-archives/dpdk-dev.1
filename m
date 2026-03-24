Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC4FF54ADF
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 17:12:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3492340B91;
	Tue, 24 Mar 2026 18:12:17 +0100 (CET)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178]) by mails.dpdk.org (Postfix) with ESMTP id 704C040B95
 for <dev@dpdk.org>; Tue, 24 Mar 2026 18:12:15 +0100 (CET)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-2c0f754e756so1861796eec.1
 for <dev@dpdk.org>; Tue, 24 Mar 2026 10:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774372334;
 x=1774977134; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=igHrx8wFtcC2gk9p805wYgEpCiZDpMZfk5UpdIGOCm4=;
 b=EishPbrW6ypjuQ42q/NU2cx+9wlGP/9M/Yb+mw+L784Qowjb7aBoDvbIiLtx7qcM/s
 aLZsvjR+LmBhQxtn+VC1di3GgnhBlyR5ABUoHT4KshHC8bfs4+VsA8MR+U5smJtw6jBG
 Gt+K2b1UYvoOb23qa8p6KRxbhsQtg9Oy8+4Xsz1YEC5XkR5zc5qZtReGZYNSG+qkqv1R
 oKn9KELn9OmEMPGsV5G+W+kXf7QYkvgmL/ZE/3TnlcgW3IaXaCWEZXdKtftyrOtD98n/
 setRqncrjJshs5zsnB+htmMINFwR5d8KJKs5mNz1PckRiIHU+w6bzrH3MgKPcrz44Ii5
 I5Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774372334; x=1774977134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=igHrx8wFtcC2gk9p805wYgEpCiZDpMZfk5UpdIGOCm4=;
 b=SAf8rNSMvnqGVZ4lZPIEo1s5eFnKT5WIr2qfyQ+n3tr3Cz2aJlQ/9uQMQkGK8kMyQG
 WSy7mSFmMv13SEH2Bs8IqpGhfs3o2qtJJxzi0GETcPd18fFP/ClnFN0qZw/4ZzNInmdT
 qloiqrliPPbl6Bv0oSadVcgYN0oIdJwU7dUsHGxqptvqkOo+nEI34AWTOiy25V8f4l6/
 abNeAGYkpNy6dlD+zWyqY3bdquBYigtkYJntNUXnbWxrLaUraAUeYHdMeiEFQYjk/ndb
 t+YqeN0j958qvr35edJWv7iBjqAobRORFQGfy5ssijbKZzkGWvh8eIzje8GsbezbDwQC
 5ZVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtDLVnC+Cpi2K0dLsGOxjFqsQW4ga2ZhDYAr64rXWU58wHsAjn+zKO+MM4op98PzRRq7I=@dpdk.org
X-Gm-Message-State: AOJu0YxxzG8r3y4Qe/5j1z3uRN6rzIfFwH0AeAUgVIJx0oh071JTLKHZ
 rAv6rBKkI5xb5AB4/zlqyKYZp/Ggjfu8jYM91ynM74v2QYeQ7IlvA9kyOqEk+ZBdCSs=
X-Gm-Gg: ATEYQzzjw0M+ASEwKOWRNpiK/GtkUc2/MD6Fte3PYaghmH/dGtxJAxYTABRzzuMcviE
 jLszOzn4xuwHkp5hs7Tn991HjxuI/ymV+sugl145+VTCAy8UmYomtjGjB/0WDSDCO1LV8n8wjte
 zoWlfipdaj2eKNL0zxnfzq5BrPneIsiLi69TK5YNQr22GfCdTj1479g0Uh0x7xTyNrZ5ncsHeA6
 vpxQ+dgrmeMg9wTcdq3btwdhGE+gXySkmZjkJIowtyse1ZT2EvHeYIKVOFWgb3D+gRY8bhVLByz
 jb6FpnqQo9xcL6yIbN7A2VHioVvUG3w74OvcBFxfAr3sVX1pz7FSIRUKEKkGbjwUZ2mVxo7Jt//
 270Y5VxC3V5cMz2URTpGfkDe5AXkjS8Azgim/SvmkAW2fjlYE9/Vby50wki0+0RwhJMoIsFZeMN
 /18x6AWhweehtBIrY3QfbYo452ouBQ0GgRAQ4=
X-Received: by 2002:a05:7301:1984:b0:2be:aa:9a4a with SMTP id
 5a478bee46e88-2c15d18640dmr101312eec.0.1774372334427; 
 Tue, 24 Mar 2026 10:12:14 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b2ce04asm15837160eec.21.2026.03.24.10.12.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 10:12:14 -0700 (PDT)
Date: Tue, 24 Mar 2026 10:12:09 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: "Bruce Richardson" <bruce.richardson@intel.com>, <dev@dpdk.org>, "Reshma
 Pattan" <reshma.pattan@intel.com>
Subject: Re: [PATCH v20 25/25] app/pdump: preserve VLAN tags in captured
 packets
Message-ID: <20260324101209.04ffae54@phoenix.local>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F6579A@smartserver.smartshare.dk>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260310161356.194553-1-stephen@networkplumber.org>
 <20260310161356.194553-26-stephen@networkplumber.org>
 <abgi0O1fWFqYIDP5@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6579A@smartserver.smartshare.dk>
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

On Mon, 16 Mar 2026 16:55:29 +0100
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> >=20
> > This is an example of something I previously flagged. Like with real
> > hardware, I think the PMD should be inserting the VLAN tag into the
> > packet
> > as part of the Tx function, not the prepare function. =20
>=20
> Agree with Bruce on this.
> For simple stuff like VLAN offload, applications should not be required t=
o call tx_prep first.
>=20
> However, the Tx function is supposed to not modify the packets; relevant =
when refcnt > 1.
>=20
> Instead of modifying the packet data to insert/strip the VLAN tag,
> perhaps the driver can split the write/read operation into multiple write=
/read operations:
> 1. the Ethernet header
> 2. the VLAN tag
> 3. the remaining packet data
>=20
> I haven't really followed the pcap driver, so maybe my suggestion doesn't=
 make sense.

The prepare code and VLAN was copied from virtio.
I assume virtio is widely used already.
