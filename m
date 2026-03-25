Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE34F109C033
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 16:19:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D4EDC402CE;
	Wed, 25 Mar 2026 17:19:26 +0100 (CET)
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182]) by mails.dpdk.org (Postfix) with ESMTP id 885824028E
 for <dev@dpdk.org>; Wed, 25 Mar 2026 17:19:25 +0100 (CET)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-2c0c482e069so49992eec.0
 for <dev@dpdk.org>; Wed, 25 Mar 2026 09:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774455564;
 x=1775060364; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W4U2DKnjxQhugNtExMqWn1ObjQZ3880DSOUInhAijoA=;
 b=x+P1hly8W2dCvl+O5gdChElQp1qmgR2BAoRW9aBjwbUTgmrH6eM8QsHi5qjrIN8UUh
 QWLWNZbD9OUqqefB4/tqSCZ/LCb0L6OOrC2XJdXhByXoKq1Xpi5Ve6Qc7H3TS2C4iyVQ
 Apz6ejlMd8UQAfbEU0UfTT5NnDDvUhyQl6zie0WMdC6up6Tk2Ey8zIG8820zX2DL8tbo
 sCSYb8YafRHVH3OhylBIh/jmLd+xbK7PvxBdh4gKgao8PAhCI2ZNPXwYh7gJ2/5I8A2+
 /a0r+OeutC3xLoqfnfo6XO5UVYGQA+GDTimdyOf5yoFoDngaFXR5VF1oMDe3c2b4ZBkA
 GFWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774455564; x=1775060364;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W4U2DKnjxQhugNtExMqWn1ObjQZ3880DSOUInhAijoA=;
 b=ZabgVXQZI6K625/yNMMvJse2uS07ED5HWynq91/ahNpB0MNGrWVDCWE+E/1epdmWYM
 aAXWFh/OYAS65I6W4zTVcpYcI4Vh057+VblVP+oy/zaYtfk1jFUwCZ2ASFNGK2E1Jqp3
 Inf+D5j3XvCsWX4CBc7s99hOBGaQu0Xrs5PgOcH2PRQBAKxzwaLGz7N5UPNwo80CBdmi
 u62zvJKzqjJbRlk/A5TueHjRUoHwch1H/pPOzRjC6dUo0n2akV7iXukTwdywV2LW5fYj
 pt6tGoN3UmMuX5JHqa4/W21m40Xy/0MxTETP7EWHn0I4dY+VGKlm6Nws7vpgNOPOH+21
 kvaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsotiD0Oh2PInjb8OU0mmTuBuT1Ol3O4gaEftGSp6K/0Mn4MihT4bQrgs2a0uE+mzzLM4=@dpdk.org
X-Gm-Message-State: AOJu0YyFFFgML4ndAYRtKEnIxgJamQKc3x+WgGLTGPNZgkoflysf9skk
 AXbXj9amhWefsyDfMPzsoz55koqz7jY/6v6NIRSpG+TWI4KMVtPXKjrlmOTx1wF7hts=
X-Gm-Gg: ATEYQzwn29BFcMGpROrzzTVLuPCPAiSLUJsnNvNTozVdvhg1HVv8ljS7dMVt5Cx4Yx3
 8PX2aIh3aR++VmkQ0cAuAU4MohPSpEzkwzpCP75h3xL7/5ky/MQqdKQklCOobp4id49CzeJX4w2
 y5MtUQnnv995DqB4Mv30+oPtOYqvxj4CgH86FneTLqECS4uRnvRqtV0hWsdci6r/36MnRLQgse+
 8idqVB7xxwaQP/hG8QxF86o5B6YOyaGTf3FLRbOW3EWCosjOUOmEBXArFI+CjyA7E8kGBMkSfbs
 HE7fUAVrPGhGO4sFxcWY7bi9o0xPc5jjzEA2mMkZomdRR4y++qEnchXGzioki8ZTd1BVktDQAjl
 q9nOEZ0e6gS1Mh9X8mwh1hEC1QIcEgRVZ5kKLHBrU9tqvJCZOFEUcGwL1y+uonubpTcTkJGApEr
 bQv5j/kdl+E7knF5i8I5pDBTckJRGI7o5C7zc=
X-Received: by 2002:a05:7300:2305:b0:2c1:4f1:c87b with SMTP id
 5a478bee46e88-2c15d357a32mr2393594eec.18.1774455564374; 
 Wed, 25 Mar 2026 09:19:24 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c16ed9fac4sm59793eec.17.2026.03.25.09.19.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 09:19:24 -0700 (PDT)
Date: Wed, 25 Mar 2026 09:19:21 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: "Bruce Richardson" <bruce.richardson@intel.com>, <dev@dpdk.org>, "Reshma
 Pattan" <reshma.pattan@intel.com>
Subject: Re: [PATCH v20 25/25] app/pdump: preserve VLAN tags in captured
 packets
Message-ID: <20260325091921.687599ec@phoenix.local>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F657C3@smartserver.smartshare.dk>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260310161356.194553-1-stephen@networkplumber.org>
 <20260310161356.194553-26-stephen@networkplumber.org>
 <abgi0O1fWFqYIDP5@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6579A@smartserver.smartshare.dk>
 <20260324101209.04ffae54@phoenix.local>
 <98CBD80474FA8B44BF855DF32C47DC35F657C2@smartserver.smartshare.dk>
 <acOnBrH5VGJNz5CC@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F657C3@smartserver.smartshare.dk>
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

On Wed, 25 Mar 2026 10:36:56 +0100
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> If an application clones packets instead of copying them, it is probably =
for performance reasons.
> If the drivers start copying those clones, it may defeat the performance =
purpose.
>=20
> <brainstorming>
> Maybe segmentation can be used instead of copying the full packet:
> Make the "copy" packet of two (or more) segments, where the header is cop=
ied into a new mbuf (where the VLAN tag is added), and the remaining part o=
f the packet uses an indirect mbuf referring to the "original" packet at th=
e offset after the header.
> </brainstorming>
>=20
> Furthermore...
> If drivers start copying packets in the Tx function, the Tx queue should =
have its own mbuf pool to allocate these mbufs from.
> Drivers should not steal mbufs from the pools used by the packets being t=
ransmitted.
> E.g. if a segmented packet has a small mbuf for the first few bytes, foll=
owed by a large mbuf (from another pool) for the remaining bytes.
> Or if the "original" mbuf comes from a mempool allocated on different CPU=
 socket, the "copy" would too.


The problem with the Tx function is how backpressure gets handled.
Not sure that it is documented well enough that if a packet is not sent
due to backpressure, the mbuf in the array may still have been replaced.
