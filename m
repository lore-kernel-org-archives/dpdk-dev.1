Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8815C02199
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 15:37:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AD37342E9C;
	Fri,  7 Feb 2025 16:37:44 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id A639242DDC
 for <dev@dpdk.org>; Fri,  7 Feb 2025 16:37:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738942663;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cV9UPO4guwze8bfcFO1QavBxiMYbyWlc1VRSPURGooA=;
 b=HR+S/l5DkKAN8oGbtt8bg1SwsfKSlhu6rGfyphQxF0CFbOtkZpYdQZ9fAGN9z0oOlfa5R+
 uVQb/uvoMn5CJlr8M66UYOWizCcJzLs9+IcgoTtTznmiYoNlI41ZAHYXaeWKvHMeUROgBX
 NDsaXLeYhrK9fZfN+vSA6ce6XAqm3tI=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-X0Z6W8K-MACRZ2MeHNFprQ-1; Fri, 07 Feb 2025 10:37:42 -0500
X-MC-Unique: X0Z6W8K-MACRZ2MeHNFprQ-1
X-Mimecast-MFC-AGG-ID: X0Z6W8K-MACRZ2MeHNFprQ
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-307e4c58bc1so5417341fa.2
 for <dev@dpdk.org>; Fri, 07 Feb 2025 07:37:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738942661; x=1739547461;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cV9UPO4guwze8bfcFO1QavBxiMYbyWlc1VRSPURGooA=;
 b=M9A57pbmieXJXwGFDDeLwirtfr6vggJF6Eab+CdBg/SQxaJ+z1PzzwzRX2AF02MMZP
 DGmIWAouyTnBLGi3Q2gP/2FOynCsG6KFBeMnDFLgtVEYqYXgkBhLamnnShQ3uNcF80o3
 aGYYyMW6LecZp5yoYVXhDrTdcuENv1xKLuYMvMNAYqXe60K+F7J3EqkaNYJ0I867LRYO
 vUnS/HM0bE15CFpBgBeoNwyYuwUSdfyd3RIua3Ygo3ybubcEdg38g1MNRvXQuzewndzy
 iF7A6fa+/ggskdLNpmGcoqG6W2oBRQ//Eexovozlw9kO4ap0MqZio/2ru3/RJJOa4rza
 ZkWw==
X-Gm-Message-State: AOJu0YzLAJPIDmJDFP38wNWtQwjPIDMiVwM0xUaGisFIlkOOJBd7ANfu
 lhq7Mqf3xU223n+gWWPVxoqH1nU0GAULnPRUTGe3wilbHhMlx2ko6VX+3wjQdBe/Wb2RpsXS7zh
 0GPCFqSx5d6KMLdqCF5Qs7U2Xu83UDkOKHLNuXA0/Izn2aWGE1CAVxehWnK2cK4kZWv+VaKPQ1v
 auErCBNb6fzd4NaA4=
X-Gm-Gg: ASbGncvkRV3bp9DtV4LELuuDs/ISTM/+0bra4eBgIFVOapsG79pIgyYoe6KDqg7AO3R
 JAQyHLNk6k04jhxzWguYYUtjAddrubmjZ1ay+Se1/W3PLLxsXnsJ+zi9c9f+TEBbU
X-Received: by 2002:a05:651c:894:b0:307:5879:e7e6 with SMTP id
 38308e7fff4ca-307e5a815a4mr14165761fa.32.1738942660647; 
 Fri, 07 Feb 2025 07:37:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHikWQxUUNqZxi/3Hw1+G4sxntf3yvmt99175uL8jZ61AjP9bXQw4V9rhX6xdjIMl7XneCQa/KgudfJ0nENCT0=
X-Received: by 2002:a05:651c:894:b0:307:5879:e7e6 with SMTP id
 38308e7fff4ca-307e5a815a4mr14165631fa.32.1738942660219; Fri, 07 Feb 2025
 07:37:40 -0800 (PST)
MIME-Version: 1.0
References: <20250120180550.198121-1-stephen@networkplumber.org>
 <20250125184010.782330-1-stephen@networkplumber.org>
In-Reply-To: <20250125184010.782330-1-stephen@networkplumber.org>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 7 Feb 2025 16:37:28 +0100
X-Gm-Features: AWEUYZlAfpQ00iQ9xbKnhkyGrDAbDD37yTllYfkAacg07bsDFliGdxvNxr2UnKE
Message-ID: <CAJFAV8y5Zs3Uf+1LsrDuUpfNNT1cN5oiHgW5jB07QAb_stBYYA@mail.gmail.com>
Subject: Re: [PATCH v6 00/15] Add allocation annotation to more functions
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Fgm6w5ylfA1Cts2NgHnQxSUeNjaiQ2Ur8F_mLCs8VeA_1738942661
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

On Sat, Jan 25, 2025 at 7:40=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> This patch series builds on the allocation function attributes
> added in 24.11 release. These annotations will allow for compiler
> to flag cases where a pointer is allocated with one function
> but incorrectly passed to a different free function.
>
> The current code base does this correctly now, but adding
> attributes will catch future bugs, or errors in user programs.
>
> For each of these patches, the free function prototype
> needs to be reordered to be before the function attribute
> of the allocator.
>
> Checkpatch perl script falsely complains in a couple patches
> because it doesn't really understand C syntax for attributes.
>
> Note: this won't work for functions that are marked experimental.
> The problem is that function attribute for deallocator can't handle the
> case of experimental API. Even if the function in question is experimenta=
l
> the use of experimental free function in the attribute attribute causes p=
roblems.
>
> v6 - drop the pipeline patch (see note)

You forgot to drop the associated RN.

Also fixed the list of functions in RN as an empty line was missing.

Series applied, thanks.


--=20
David Marchand

