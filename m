Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38835C021A6
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Feb 2025 17:04:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA3ED42EDA;
	Thu, 13 Feb 2025 18:04:33 +0100 (CET)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49]) by mails.dpdk.org (Postfix) with ESMTP id 9DEEF42EB1
 for <dev@dpdk.org>; Thu, 13 Feb 2025 18:04:31 +0100 (CET)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-2f9f6a2fa8dso1713059a91.1
 for <dev@dpdk.org>; Thu, 13 Feb 2025 09:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739466270;
 x=1740071070; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bqdNKWAMpdB2Pjbli+WJgcGdEagyoILKg35V6dGsSww=;
 b=CT9HXxfu4jpQ1wi0WhO9PSl1bVHajBJPJgeCpsL5lF7ZUinDmG9JYd1eN04IS5KVhz
 Foe6g3ucomf13P3rjoSgnbIsz9GFLHGSBvMb3jfXzXoGs6y6yoduFmxg8+ab0NPOYK5k
 0S/WuBOwOYMBIWK5ZLlh0kqvR7YWQOfVWAH6o+qgdJrc9IPA8cAgSqcGsLTreSMEUkZw
 cFc1zmwp94X5chXafw7jK5h/1Nrma3GZ2iKbXBRX8f0rMr2qOHQAEA15RBPreSVtKYIO
 XdGewSQOPee1sQpntGstGjr0evfPojRAWuOdbaqAsCvGw2He2cMdSxZIZq4GSHmDDRYk
 I7sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739466270; x=1740071070;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bqdNKWAMpdB2Pjbli+WJgcGdEagyoILKg35V6dGsSww=;
 b=WD/gG/8+ZskP7AJ+TmNNrhB8KKuH/y1hnLQZh//OSsEJhkGFoCuEVbo6W/X2pbg+aF
 dhopUFzaGHw6+zRXQumleG5QEqESbS+v7SbI1c+BQPTx1UH3/AgrU6/1TIjS0B1R53Uq
 +NZxhaYK0J6cn0oVPalfW7qdSRNSMFRMxvk8jKtZKnyuMwMbSHfgUuFzZaAuhW1JYFAF
 gH3HPzUvYZSiiTxLzhAb6lVJ/dYqcBffpV5P0GGLMml3EwFayabTxeVOcOB4DXuCmurS
 IUKML7mST9u/9Gf9kgo8VTD3MAUkwEVCldsv7HSkjONyPpvvo1Gb2v9SVTnjGc2Fwf7g
 klDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWN4BRDIFzGHxA6VUDFBf8IL6CXg9HBpfw56k2P53W0uf2BFkooMzP+3jLxqV6RE43bjvk=@dpdk.org
X-Gm-Message-State: AOJu0Yy69BLLd8LbhJc5rD3wRaWzLfqL8pxpE+SJkTtvsaAcxgfDZ5hW
 bdhsKvVGdR4SdImAmcr7iDpsX+N23/2RCDBwWyayJdzbOEbEcAw2fG0gvoBoRSs=
X-Gm-Gg: ASbGncvw7HKljY3Tadmu3uIVJKCYsh3YzDwAGy3FGtMHdhzYZfVMT1uzohyt18HfLJ8
 Jb/kmy4mMXRovRuo2/xDvJCrYCOwEejGEYxN1H7HQe/Cqxv3CZf4s974PDF03/HNxs2Vu0RcWW3
 4wUSy0NYVMrgrAviZ+vK+P9ynSNtMm1aTeZHTtZrCMfs/YnbByiChEPIBL+Xdr+SpW4DO69dKbx
 FlgPNahAfq3akBZjpkfDXMXcOd/1iJi45pWCkfQFVGtzldGGd3of6EFUtAymG1YdCH3iwkoDMYE
 MxjSPHRfkUWjm5QHzkVND16ZID91xe/u8Vzj5QQsCzG79UXTpyUh3nPVzAecYDJ+kr4g
X-Google-Smtp-Source: AGHT+IF6qFyXzeHILD+A8nzZXFPEw6gPYOmRff7iUjIy9JCekVSQqbNysx3MtvJC3G/UeHwc7/tepg==
X-Received: by 2002:a17:90b:2742:b0:2ee:693e:ed7c with SMTP id
 98e67ed59e1d1-2fbf5c6b76amr14096448a91.33.1739466269896; 
 Thu, 13 Feb 2025 09:04:29 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fc13abfd17sm1490694a91.11.2025.02.13.09.04.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 09:04:29 -0800 (PST)
Date: Thu, 13 Feb 2025 09:04:26 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ariel Otilibili <ariel.otilibili@6wind.com>
Cc: Maryam Tahhan <mtahhan@redhat.com>, dev@dpdk.org, stable@dpdk.org,
 Thomas Monjalon <thomas@monjalon.net>, David Marchand
 <david.marchand@redhat.com>, Ciara Loftus <ciara.loftus@intel.com>
Subject: Re: [PATCH v9 2/2] net/af_xdp: Refactor af_xdp_tx_zc
Message-ID: <20250213090426.67ab2a8c@hermes.local>
In-Reply-To: <CAF1zDgatvhGqZBYf0K=RkVJQvDxo+==WWDAAXREqHAuR15W-2Q@mail.gmail.com>
References: <20250116195640.68885-1-ariel.otilibili@6wind.com>
 <20250207104552.1663519-1-ariel.otilibili@6wind.com>
 <20250207104552.1663519-3-ariel.otilibili@6wind.com>
 <2b6e60c0-4436-44dd-bba2-335c1b22a7e9@redhat.com>
 <CAF1zDgYZJLX7FBCpwMWrfiLm6si-8jpfppQaW1Cd36QoNOCOfw@mail.gmail.com>
 <CAF1zDgatvhGqZBYf0K=RkVJQvDxo+==WWDAAXREqHAuR15W-2Q@mail.gmail.com>
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

On Thu, 13 Feb 2025 12:17:51 +0100
Ariel Otilibili <ariel.otilibili@6wind.com> wrote:

> Hello Maryam, hello Stephen;
>=20
> On Fri, Feb 7, 2025 at 1:33=E2=80=AFPM Ariel Otilibili <ariel.otilibili@6=
wind.com>
> wrote:
>=20
> >
> >
> > On Fri, Feb 7, 2025 at 12:13=E2=80=AFPM Maryam Tahhan <mtahhan@redhat.c=
om> wrote:
> > =20
> >>
> >> On 07/02/2025 10:45, Ariel Otilibili wrote:
> >>
> >> Both legs of the loop share the same logic: the common parts are about
> >> reserving and filling both address and length into the description.
> >>
> >> This is moved into reserve_and_fill().
> >>
> >> Bugzilla ID: 1440
> >> Suggested-by: Maryam Tahhan <mtahhan@redhat.com> <mtahhan@redhat.com>
> >> Signed-off-by: Ariel Otilibili <ariel.otilibili@6wind.com> <ariel.otil=
ibili@6wind.com>
> >>
> >> Acked-by: Maryam Tahhan <mtahhan@redhat.com> <mtahhan@redhat.com>
> >>
> >> =20
> > Thanks for your insight, Maryam; I've learnt a lot along the way.
> > =20
>=20
> Are you expecting anything from me? From what I understood, the series was
> acked. Still, patchwork labels it as* Change Requested.*
>=20
> http://patches.dpdk.org/project/dpdk/patch/20250207104552.1663519-3-ariel=
.otilibili@6wind.com/
>=20
> Let me know,
> Ariel

I was wanting for discussion to end, there seemed to be open issues around =
testing
and the new common code.
