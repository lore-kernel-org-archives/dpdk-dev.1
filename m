Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97A9C44529
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Jul 2026 10:25:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E7018402A7;
	Tue, 21 Jul 2026 12:25:41 +0200 (CEST)
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com
 [74.125.224.41]) by mails.dpdk.org (Postfix) with ESMTP id 099EC40289
 for <dev@dpdk.org>; Tue, 21 Jul 2026 12:25:40 +0200 (CEST)
Received: by mail-yx1-f41.google.com with SMTP id
 956f58d0204a3-668432d50b0so3163943d50.1
 for <dev@dpdk.org>; Tue, 21 Jul 2026 03:25:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784629539; cv=none;
 d=google.com; s=arc-20260327;
 b=R2X8s9Z7EYBNFgWTKTzTIFYiOyUuJHjsPpKbLKUGkxKfQD03miEQ+6d86BhubbO5Jt
 CwTTsOAR4o6OuCyZrxLArshBIt/pEnxpiqcyxLdDB/deYM4Z05D0BT+OVn7Q92cDTo3A
 /hqVdObbpZj24jADZHqT1IpKAh1nOb14mPrW0MbbrSXIASvARszR4UDdRc/8Fd+XisQK
 R7dA6SxezrfR89PxIYoHcz5f4DPd73FvXpPYdc/LJ7ZUjD/iDfaj14cpNLwiKdKaf1Z+
 HQkh/TWF9i9rxsEX0VEy3J1pCpXjfVbudVaWLKmbpLN4vjT/JML9XkaljJqvho146TXk
 yzxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jOmGPNfAUeS90aIoYi8y0YyiYOAEIDNh62ObkwQLI64=;
 fh=Dzvm8iYfj2/D8mm9PlzwoKEpJYZTAuYoKcsQxrv5mXo=;
 b=MAz5QI4MlH4CuCdb0vf8Io0jPlj+KdCQ5HFV6pSWEDOSYHJjM0KbneOvOU4m7tnFJZ
 JN567RlFRtICObXLP/UlqgC/57misraIFpw9k3B65/DuEu0xfa/JJjsToMwLO+rZu7Wf
 9KjAuLS68l61BysQvCaGhSdfIE+ZTQridhD6P3EHDHZ3T18eZkpjz4iNHy+AI+Inp9QQ
 /1pTHBF5T0Pz7EkfB3gBUrwZO7MGtfUfBjDYOd+P632JewHBo9PMWTA1nLWr7tBezcin
 oEU5dFa37wkUmd+w8++8Bx0OIrRL8dXzt/oxYk6JnTkdMMcJerIk9aRMoRlU6tedMfd8
 7drQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784629539; x=1785234339; darn=dpdk.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jOmGPNfAUeS90aIoYi8y0YyiYOAEIDNh62ObkwQLI64=;
 b=l1ZFDodnqthK9Y5xhl74r9THnN1SCxNr8k4oa/zBW15b2JVhYvKz4sNxSRNky0t0Fq
 act6V4irtXWnF7FkosQZ4Ipc2XiGuAMPeMvEBI2U5JdnBlY4gtKd8VdvcOwGvDGYMvoR
 ma3CS7e2b38rnteJHddC0ystTDoigMUKhvmCjXhxE3Lh3+4fxHYv9UtygbRGAGAe7in6
 orASAVKgIuS6LYSFeJeKAtDDdLWTnYCDEsPbTybLMMKy3Z0QVf3Ep0yEvTZeG4kcp1eT
 Lu98+Gnfw5G444/RNo8Ls3N6ZeHHGu8qHan5k6FIoxe7Kh7q+vVu2fIAVWTAKzVfcsec
 V5iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784629539; x=1785234339;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jOmGPNfAUeS90aIoYi8y0YyiYOAEIDNh62ObkwQLI64=;
 b=Csyvdyle8X1ZfdUAh/uLcBtMVz1By12rnxGw5WipE90VX7jG32PU5Fg6s90Tm7L4Ur
 yo++xybt0CvAiGxwULY99yND5i/8xFzjorlTZipOap0ikWdPzKu3A8g3o/VqiaK0Zkmz
 llCSv2YI1OnWiGlq0flbDZVJg0RS+A14vh4Jq5tkkNDHjjcZkzJ7hWbo8jMgVQY0NMWa
 mmLWxuNlw4XmbPLNMqzcv15n1GoapjDbCvTytdcGlkbmWei07LGHYLAbpJrOGDzoyuzR
 83SyC/I8Q+o9jGPOXDPg/37haCvD7oCdbrN4xjnwjGVQP8Bm9Pm7CqhxJ6TbE4big+EA
 JKUA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrfB2ffj+mX9VuyZigFS9tIsEplD41jt4L7g5BmLWaU9pLUyvTXBmRyH4MlONLWL+k+XAA=@dpdk.org
X-Gm-Message-State: AOJu0YxXNmHzQTtaDHtb9G2/F/EEYN/548QAasknIQOTYQ7Rbwns3t8y
 QF9uHKrfPiI8CaKn4xSt+4dudLJnnyfjcFm4EL8TKYm5kjVwbyWZ1eH6JRd3sanQaFSRzYXUZZT
 wD8QP8p+u7Yr3SFV24ArRXdOBdegyqJY=
X-Gm-Gg: AR+sD11Uufl4OZD84RmGxuS2V4FRx58NEvgVHWhR8hnLsxLD4m+gdJuORgGKnWH2u4v
 5RW1fjC+XWXRTUbV9O3I2llBmT4xhGZpNRo8wRt0VaM46uR/AwzgpMS+Jg3OaDAYvNlYFb4GRPi
 7Z9lhLiARJ10UO2hqrWN71keFhfAY5p8w7P8Oi8Z5q44sECXziCU48Woo9iAriJvtJ4s9E6YuNF
 HQRU81It48WhzTiHl/W2K6f5+wUF2YjJ5ue1k/jNFHXMwX2UmlA5U3AIN+rnXEIhi7qGOr6gMLU
 eEM36K3pqxeFcbAegfTS683VBHmyvg2Bug64SA==
X-Received: by 2002:a53:ec47:0:b0:665:a15a:71aa with SMTP id
 956f58d0204a3-6683bd2c3ccmr3638671d50.72.1784629539232; Tue, 21 Jul 2026
 03:25:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260603023207.31974-1-stephen@networkplumber.org>
 <CAJFAV8zhrp3ke9k_RnwG28x-M8MzhK7R+=BKvc_+piZ+a7VcfQ@mail.gmail.com>
In-Reply-To: <CAJFAV8zhrp3ke9k_RnwG28x-M8MzhK7R+=BKvc_+piZ+a7VcfQ@mail.gmail.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Tue, 21 Jul 2026 15:55:12 +0530
X-Gm-Features: AUfX_mzTKej1ZWL4G83TEUcaBbL374xxU7bs75t7qYwTZ4t2rf3TOo2vE0W88GI
Message-ID: <CALBAE1M+w=jEmEcd_455jsH6Pa+pUMYzS0yqW121Tff=eTzNbw@mail.gmail.com>
Subject: Re: [PATCH] doc: add deprecation notice about upcoming change to
 ethdev API
To: David Marchand <david.marchand@redhat.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
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

On Tue, Jul 21, 2026 at 3:37=E2=80=AFPM David Marchand
<david.marchand@redhat.com> wrote:
>
> On Wed, 3 Jun 2026 at 04:32, Stephen Hemminger
> <stephen@networkplumber.org> wrote:
> >
> > Inform users that rte_eth_dev_get_name_by_port() will add a size
> > parameter in next release.
> >
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
>
> Acked-by: David Marchand <david.marchand@redhat.com>

Acked-by: Jerin Jacob <jerinj@marvell.com>


>
> --
> David Marchand
>
