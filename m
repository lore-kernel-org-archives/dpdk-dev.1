Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC54EC43458
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Jul 2026 00:57:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A539440268;
	Thu,  9 Jul 2026 02:57:37 +0200 (CEST)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53]) by mails.dpdk.org (Postfix) with ESMTP id 3878B40265
 for <dev@dpdk.org>; Thu,  9 Jul 2026 02:57:36 +0200 (CEST)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-47ddf7b09aaso869588f8f.3
 for <dev@dpdk.org>; Wed, 08 Jul 2026 17:57:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783558656; cv=none;
 d=google.com; s=arc-20260327;
 b=FOCd+t1g87uUFt1nBiDguoh7Mz1QjmszdB9IOM9KfrBmfjrjM3tF+PIxTiD9uCSWV1
 UjVLyPiuVKFwTlNeZjO4nvC7KGRaAYv65dX52zz5hQBZyEZVo2dc+fe34Z6+qMcXId4h
 b9YHJrpfzFeCkUHCPKRvB2qQoMDf/lBeKTLX4eHHXkGg6GWT28pAaHXNzMQNFqkYpu0p
 fADRb1GClWFpSqjay7sb3VLFuU1J/4JMRwypxWLxTClFx/43cphwFHuPE0jjLh3kio0Y
 O6kyNxh8iTtUX7mlkEzPGK+BE2i5UjWSivBNu58uE3eolDtcM+dHonG4/Mut8534yY+n
 zgcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ojZfBeo6pcM3uI4c4XKA6Faf8XD7eoHjdmPrIkqV5nU=;
 fh=iCEkq2NlOBZ9YZRdZ1zQDLeKgWB8XrJzbIJcJKtfssM=;
 b=MJsW2CB0bzGxZoP8zFrSSN9EF6gTmUZztGk1MjJUm92YLnMLNmt48REgec9pmfM2Fp
 YgYAFs/VvvsyG5x5ws9O4Hd+3VBNdTXWZVLZxPkXh9KGXFbKxRc1xgMQsFeKDNJ2f0kF
 XBV4rIWI6aCn7LaLvt+pURJDig2A50ztLCrKiT1JXU39GB/YuFn+4KA3S00MllO1raCo
 W9HS3vc5kStjQgDpLHdcdsuvyOyLrtzy8NSTIjjaxJT1L9qYoYUn/klyXWfmo2nyhhmZ
 Y5cMJII8Fjtra3QvOz/fHF5NPBZLqZ9Wstetv96BxHEZtU1Wdmc9r3IU3g1+Nq9o+Ydk
 CWJw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783558656; x=1784163456; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ojZfBeo6pcM3uI4c4XKA6Faf8XD7eoHjdmPrIkqV5nU=;
 b=KVOkQEjXujUsA5JBxZwq19aBqWmBZC/yZfAFtSG9A0oGdByPqrbs/E2obqYQYr29Tz
 ecs3zRXmnOQWvEubxCShTpUB5jfncrbRLkAciFFP+qXKP35PNwjtmChDpfXkrUr6wONv
 sMymxiC4nDjBy3xisLyjepzDameHPI2+F+icQ5npMaT3Jbh1lKgiDxYzQRJQpr9tvUdT
 wh11Ql7xoEVZTXkWt4PRAF8XOq5fuMEaaUM8N/xGAwWr3xiHW/+Kdl4kRgXRSBiC7zY0
 ea9W77ybQYSDDK9f4sWZQQdrwkwzT8dNr9PMcvgvTZvGW1brQo+RRupBYbSz0qnI6UEV
 j2Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783558656; x=1784163456;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ojZfBeo6pcM3uI4c4XKA6Faf8XD7eoHjdmPrIkqV5nU=;
 b=AFPmKCZsOTpqET0ZjZLUoVVM/yYo0khQpjNx45a61S6eDevWdc0uUS+lmgJ9gfkl8G
 IJcCC+kIA4L5y/LSa7Svqw4GsxnmhcDwUAa3QH19JKAT5EEnLzs8xe+ciXg1foqWvP8g
 V4ZgLTiWOPHW992I1cXuyTkc/udgQD0sISTo0/ow2dMvfzoylev8Fcg/7jhOu38Xxp5y
 vyHsFsRfP1s9NqdizHUjirJqDz+o9u3rHPSNJIFLAriRjJIk1WvzouPtCF53wuQ088HK
 QpyLsflLHeH8+qD+LG5dnF9Su4N+DNPpcJfDxaP9kCAzklMXC0FDD5QXd/r+1TV25isB
 sSYg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqLEGSe93WPrgKmb/h/F8lGaWvwP20tha+Wlv4ndnRNPMp9A7OTNwQrbhhjq8yfWIiHxqc=@dpdk.org
X-Gm-Message-State: AOJu0Ywj1Hh2KgCmgWEXCuAWN+IleHFa9jnCQT3wTmWU3G2VNAWjB4Yl
 fUgUKUVvDTpVlqujUR4Iw/lMMEGMmcHoYpxP1MBsabhPplyOtoeN+fAipxC/BtXvI1VMuBW4Jke
 dOUFuND34A7AUR1tXoz9JwUjpl2fxR2v2t1E9Gnk=
X-Gm-Gg: AfdE7cksUHw6jATZhj+VIYIZb4hsvLFlo8aBnWDy0h+cIIbhi+n4QyNDHcQsW4/WIBW
 4vzI92X36NJEkaf64tsnEI81MEWO4XhXjp3tT93OUyCsKlNrtSf9+3sAsE/0Cj38RSjKMbBolt9
 IeZVPAR8dvIAmuJN3R4Uh8rDZ/kOj4wq+f6ObjzUOCPF1hW0UJYUvz19aUYMi3WFkskyB7QwVnl
 zdC7Py+hgEEf4bTA1qzx5WlITiMTcqaNDqLbxnCDw7bP+4uLxQ6DLz6V3P5oneMRQ2v7engkx3F
 WvedWO7EdMB3Qy+Z1a/S1ZZy93k/Oxo2uDalcoI55WT4HuEuhLW+KArq
X-Received: by 2002:a05:6000:41ee:b0:46e:6210:ad4a with SMTP id
 ffacd0b85a97d-47df071e518mr4566619f8f.5.1783558655560; Wed, 08 Jul 2026
 17:57:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260602163647.101815-1-knimoji@iol.unh.edu>
 <20260625154712.2255474-1-knimoji@iol.unh.edu>
 <CAK6DuxvEjRGOQJMY-Amd+QUxQBAV9ihp35fX1PQ2D5p7bt=L8w@mail.gmail.com>
In-Reply-To: <CAK6DuxvEjRGOQJMY-Amd+QUxQBAV9ihp35fX1PQ2D5p7bt=L8w@mail.gmail.com>
From: Patrick Robb <patrickrobb1997@gmail.com>
Date: Wed, 8 Jul 2026 20:57:24 -0400
X-Gm-Features: AUfX_mwGb7HBSgiBIHi3FyNu6w1w4ccWaTe19UAqZ_hrLkR2wrbQgRP1ni56LZM
Message-ID: <CAK6DuxskqPSX-wgxHLOmhd7U=HSYg2js99E7th76LeAY4CBbHA@mail.gmail.com>
Subject: Re: [PATCH v5] dts: report dut/NIC info during DTS run
To: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Cc: luca.vizzarro@arm.com, dev@dpdk.org, abailey@iol.unh.edu, 
 ahassick@iol.unh.edu, lylavoie@iol.unh.edu
Content-Type: multipart/alternative; boundary="00000000000019cde40656231cad"
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

--00000000000019cde40656231cad
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Please make sure you always run checkpatches, check-git-log,
dts-check-format, and a doc build or each patch you send. I will update the
commit message before applying. The mailmap issue will go away when your
other series (with the mailmap addition) is applied.

Thanks for the patch! Applying to next-dts.

./devtools/check-git-log.sh -n 1
Wrong headline case:
                        "dts: report dut and nic info during DTS run": nic
--> NIC
Contributor name/email mismatch with .mailmap:
        Koushik Bhargav Nimoji <knimoji@iol.unh.edu> is unknown in .mailmap

Invalid patch(es) found - checked 1 patch

On Tue, Jul 7, 2026 at 9:46=E2=80=AFPM Patrick Robb <patrickrobb1997@gmail.=
com>
wrote:

> Tested-by: Patrick Robb <patrickrobb1997@gmail.com>
>

--00000000000019cde40656231cad
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Please make sure you always run checkpatches, check-git-lo=
g, dts-check-format, and a doc build or each patch you send. I will update =
the commit=C2=A0message before applying. The mailmap issue will go away whe=
n your other series (with the mailmap addition) is applied.<div><br></div><=
div>Thanks for the patch! Applying to next-dts.<br><div><br></div><div>./de=
vtools/check-git-log.sh -n 1<br>Wrong headline case:<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;dt=
s: report dut and nic info during DTS run&quot;: nic --&gt; NIC<br>Contribu=
tor name/email mismatch with .mailmap: <br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 Kous=
hik Bhargav Nimoji &lt;<a href=3D"mailto:knimoji@iol.unh.edu">knimoji@iol.u=
nh.edu</a>&gt; is unknown in .mailmap<br><br>Invalid patch(es) found - chec=
ked 1 patch</div></div></div><br><div class=3D"gmail_quote gmail_quote_cont=
ainer"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jul 7, 2026 at 9:46=E2=
=80=AFPM Patrick Robb &lt;<a href=3D"mailto:patrickrobb1997@gmail.com">patr=
ickrobb1997@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex"><div dir=3D"ltr">Tested-by: Patrick Robb &lt;<a href=
=3D"mailto:patrickrobb1997@gmail.com" target=3D"_blank">patrickrobb1997@gma=
il.com</a>&gt;</div>
</blockquote></div>

--00000000000019cde40656231cad--
