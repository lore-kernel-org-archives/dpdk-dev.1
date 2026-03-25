Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64160109C044
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 17:01:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9BB68402CE;
	Wed, 25 Mar 2026 18:01:00 +0100 (CET)
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
 by mails.dpdk.org (Postfix) with ESMTP id 019A74028E
 for <dev@dpdk.org>; Wed, 25 Mar 2026 18:00:59 +0100 (CET)
Received: by mail-dl1-f50.google.com with SMTP id
 a92af1059eb24-12a693cdf29so1092253c88.0
 for <dev@dpdk.org>; Wed, 25 Mar 2026 10:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774458059;
 x=1775062859; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L2T8lAjO9sarIUsdAC0NGN9xZ3UBsf7FLdqjYPowOX0=;
 b=BbdQaaSLoBFvraxVdVp6FYmdiqJt2yKCGVGnPw2t2wXJhjml1beNi8dcequ1ImqL/D
 jUFozF9JwmZ5GTzieaPv8jvXMlAixnMh8Jqspc1R7lkReKc9UElX75SoilDRTYQaL2+J
 hsEH31ivcC8n6KB8sLe2key3d5WSj2QcGz3cXdADswWB4C5bSpd1WaflW7suGcQreoWn
 7CNHA0JBMEJUkKUkhZGnPaIRKacj8rdplzobhsxZEoLBA+sDCOjQHZuPCP0mIPrMbdK4
 bT3Gte7xJvjMsf4DIoPzJpX+YZmLhHcYYhYCsdlEJS2sax6Afon8S1p1pH1a1HMy2mWr
 Rmfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774458059; x=1775062859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L2T8lAjO9sarIUsdAC0NGN9xZ3UBsf7FLdqjYPowOX0=;
 b=hgWAWqoXGFm/vZA1sf34MT+RUgCrSFFZ2yCYOiCGDTLkRmiu5ORF81d6MeCOXvfBn4
 aEbQ7MZXCCz6c3T/IyY+AkQjuvhibLBc6V2mcXiTD1GKWuKNQMVqzQOQdOvuh5Pn+iG7
 /l8GgjMRZH7hKTP5d7mvRxzi5nuMBpl5n3BZQqr+c0gqtDSDjkuBOcITSkuBJ7L2SR+M
 NIR4NmoA4MoLdeyZh8NzmP34Gk3LpKtsicsPCEjisUm8Q5hjxpBeh/Toy3Nrmg8h8dSD
 DSOYfKUbbhBq0+ZS6NP+lmKtChsE3pd2qqd7gEhS2tmQvEW0R6FaiBsns1AqGfCdX0QK
 AQpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIlP8KBi5GqBSBPIljC2jYtOYL/CHkDAekZE3tbr7AwCfP2vKWk/kzQOEHK3YDNNJf7a8=@dpdk.org
X-Gm-Message-State: AOJu0Yx9/idb0tIWtV6m6kgaYXBd8jF+Eo3XEFgAhADUIZ2liNj03thU
 78bcS51zcEzxvolWTXh7PN9lwUyzCu/E7dSsh8VEaHa1sBcXRssPlZNQsI2cH2bCDEE=
X-Gm-Gg: ATEYQzx+JMnKUZmcrWQsuewchSiUK9N6AR+s6RJgTIduxlhs0tvlc40e/363aLQnTu1
 fAuStXOZhfYoqhik/HnwJR3b/PhzPLDMyzN3HK9aPQ+hJMrz4qDDxlJh0Hx+i789vF9pcHx2sjc
 xWtzLTIzQ132Xc06cVMkUpTnKdEMzuV3xOmXqKW14NE/bR9OSjR57ODA8QGd/2BVQoABvkdrROW
 lrBwSUkt4fy9naGtt4A8P9QMCJodKYC2Bd8iqmhu2q752u7HkPTLf3KaZq9EQzF+lwJSsHV6ufj
 RZy465Clbg6YCTRc7O6MepK+rKZpkU9xozmcy+fy5O/OIBQxC8sd5efdW4azE1q0E1FU9NXSxgU
 g0U+hKwpYD7cch6E64fFj4wo2tjymea+AzglewiELYUdgt5bmAfLJCY3HGMZNKQSC/AMcKjM6z/
 ZjJwikwoGOPGzgr3iJ12/6hbDscIDSYepNHPU=
X-Received: by 2002:a05:7022:e98b:b0:12a:6abf:ab1c with SMTP id
 a92af1059eb24-12a968bd551mr1931080c88.11.1774458058652; 
 Wed, 25 Mar 2026 10:00:58 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12aa7827e02sm428531c88.12.2026.03.25.10.00.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 10:00:58 -0700 (PDT)
Date: Wed, 25 Mar 2026 10:00:55 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>,
 <dev@dpdk.org>, "Reshma Pattan" <reshma.pattan@intel.com>
Subject: Re: [PATCH v20 25/25] app/pdump: preserve VLAN tags in captured
 packets
Message-ID: <20260325100055.6edb70ec@phoenix.local>
In-Reply-To: <acOnBrH5VGJNz5CC@bricha3-mobl1.ger.corp.intel.com>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260310161356.194553-1-stephen@networkplumber.org>
 <20260310161356.194553-26-stephen@networkplumber.org>
 <abgi0O1fWFqYIDP5@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6579A@smartserver.smartshare.dk>
 <20260324101209.04ffae54@phoenix.local>
 <98CBD80474FA8B44BF855DF32C47DC35F657C2@smartserver.smartshare.dk>
 <acOnBrH5VGJNz5CC@bricha3-mobl1.ger.corp.intel.com>
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

On Wed, 25 Mar 2026 09:12:38 +0000
Bruce Richardson <bruce.richardson@intel.com> wrote:

> On Wed, Mar 25, 2026 at 08:41:39AM +0100, Morten Br=C3=B8rup wrote:
> > > From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> > > Sent: Tuesday, 24 March 2026 18.12
> > >=20
> > > On Mon, 16 Mar 2026 16:55:29 +0100
> > > Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:
> > >  =20
> > > > >
> > > > > This is an example of something I previously flagged. Like with =
=20
> > > real =20
> > > > > hardware, I think the PMD should be inserting the VLAN tag into t=
he
> > > > > packet
> > > > > as part of the Tx function, not the prepare function. =20
> > > >
> > > > Agree with Bruce on this.
> > > > For simple stuff like VLAN offload, applications should not be =20
> > > required to call tx_prep first. =20
> > > >
> > > > However, the Tx function is supposed to not modify the packets; =20
> > > relevant when refcnt > 1. =20
> > > >
> > > > Instead of modifying the packet data to insert/strip the VLAN tag,
> > > > perhaps the driver can split the write/read operation into multiple=
 =20
> > > write/read operations: =20
> > > > 1. the Ethernet header
> > > > 2. the VLAN tag
> > > > 3. the remaining packet data
> > > >
> > > > I haven't really followed the pcap driver, so maybe my suggestion =
=20
> > > doesn't make sense.
> > >=20
> > > The prepare code and VLAN was copied from virtio.
> > > I assume virtio is widely used already. =20
> >=20
> > OK, that makes it harder to object to.
> >  =20
>=20
> Yes, but I also believe that the topic was not previously discussed and
> that the virtio driver may be wrong in how it behaves.
>=20
> I still think, for consistency with HW drivers, SW drivers should do the
> tagging in the Tx function.
>=20
> I also think that we should provide a DPDK-lib level helper function (be =
it in
> ethdev or elsewhere) for doing this sort of thing for all drivers. That w=
ay
> we can put in the necessary copying of packets with refcnt > 1 and have it
> apply globally.
>=20
> /Bruce

Virtio also requires tx_prepare if doing any form of segmentation offload.

If this is not ok, it should be put somewhere in the docs and virtio fixed.
