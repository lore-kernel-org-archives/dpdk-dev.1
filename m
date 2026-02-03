Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5CB8E87835
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Feb 2026 14:12:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ED4B14029D;
	Tue,  3 Feb 2026 15:12:22 +0100 (CET)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50]) by mails.dpdk.org (Postfix) with ESMTP id E4B794013F
 for <dev@dpdk.org>; Tue,  3 Feb 2026 15:12:21 +0100 (CET)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-42fbc305914so5029926f8f.0
 for <dev@dpdk.org>; Tue, 03 Feb 2026 06:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770127941;
 x=1770732741; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FcO0mYpDxy4DrnvWcvHg+cT7AT0lxyikfwcjFyCsm7A=;
 b=a9tj+8qrJwiX68XOVytBAO5ukTsFmrew+F4I4iMPyjYGqCWkBhi+rmkruHOnQCyQQT
 jlZUQaThHo3WEH9epx2qjo2FdV7e7LynT5j3Xivj8DP46PpTHWcIL9zgGymt7Ob6QRG0
 c2fzx3ijK/GnxmcAphOGaMSos2S5LxxAVnLTOC2rC5k6s7BijnwO70WkxsAT6ayTZAM5
 bFV7XmEPmrGaNZLsKnaW0mNRl0rLfvR5PFIUPIyTGcho1lsBjsMaSVNJj8juV0oLjCcg
 TzokUnClBzoI5djsD2XddpsCtpsxgdmLr4zKC5yVGksboY+C7hBSc3AonUi8jNfVvk54
 Dbdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770127941; x=1770732741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FcO0mYpDxy4DrnvWcvHg+cT7AT0lxyikfwcjFyCsm7A=;
 b=k9cYipvqqhsg2mQ1kWglWQQCfmH4zgNa66qRFWRkES1uvnqTxwt/ccXm/ILC77IkJV
 XKvggfrlkFhr1oP0IFeSfDQ9BlEjNgR9xb1+KAXfsnl3wYquqlfytnswT8xsqqQEAOpW
 Sybd7EwfLyXkohwfGKFuF1WCekhrHgbhdNqVk3VzKl/2M8e/AZ7iQOSl0hf1K32uBanR
 Do+z2trDkR7vxPjN4OFnY6jyEaLPoEP5tsxubrKCViOxxtzwa6uVaOkiw50LnlYYMupT
 b3zR1wOd68kvtgFrRYkzeuk3yWK8f1cIJgJCYg236gpme7P3nz2RZnlYnyGsSxzWWa1G
 nz6A==
X-Gm-Message-State: AOJu0YydpojdP9vqqdOxVIa9ysx+uwlhnftl0uZqSosx5lpyoyOAwtps
 OAIqCx/AEKoai5SEiJFzcm4sS3DhX0/w0A2gdQY9z4c0rEpQBUKibXanUQnhgX1vCN8=
X-Gm-Gg: AZuq6aLRhstldmNw9tB96AiX4LwHmeLQhEBfbMFU2OdoJBBk+m3WayuO2I3/fM05vCJ
 s/TMRBqw7b5CbeLIxzLod7VgI9+9FLJXgfDHevN/81OO0cxv9vpMUtFRp501OghV+d2Xu273XGo
 NAvCdDx0iVioPbrjCjEFlm1rDRhQX0zmM4vaR7DA0vaAaUrJFM5rbS6lrqSO+HVsXvNPaeVCOII
 xgooFrCafCEw4T+/uivnrhLeFQq8O2GmfIR1h1Ojy46VQ0XVsvEzUfzU4G/ZuulaGIGpXYERL9S
 n7nGI/KUSCPkmfNqz0vaFeIFiTFu9uykOBQBM6n1D7W2DPlL/AMLAQO3Jg/8eLYXAS5NKyHUON3
 eLspX+BUMBiLpzIQQ7LpLnmIYXoLDa4bBBCbjx0uY9ZMMN3aheWvoEP94hEsKsP4IW5ao4Wcm0A
 8dfRphCzYhl/sZnxdYssowRCOxpxmpBarV89J2wx2h5z/gIC0sqVyr
X-Received: by 2002:a05:6000:40cf:b0:435:a363:f29e with SMTP id
 ffacd0b85a97d-435f3a81f40mr24371997f8f.11.1770127941154; 
 Tue, 03 Feb 2026 06:12:21 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10edfe7sm51273026f8f.14.2026.02.03.06.12.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 06:12:20 -0800 (PST)
Date: Tue, 3 Feb 2026 06:12:14 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Scott Mitchell <scott.k.mitch1@gmail.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v5 4/4] net/af_packet: add software checksum offload
 support
Message-ID: <20260203061214.770b5f00@phoenix.local>
In-Reply-To: <CAFn2buBHCKj52h0k3ApW_5jG5BK7PUYu2Agmqs0576mUZ_+yXw@mail.gmail.com>
References: <20260202081456.4322-1-scott.k.mitch1@gmail.com>
 <20260203070740.62305-1-scott.k.mitch1@gmail.com>
 <20260203070740.62305-5-scott.k.mitch1@gmail.com>
 <CAFn2buBHCKj52h0k3ApW_5jG5BK7PUYu2Agmqs0576mUZ_+yXw@mail.gmail.com>
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

On Tue, 3 Feb 2026 00:20:43 -0800
Scott Mitchell <scott.k.mitch1@gmail.com> wrote:

> gcc warnings are resolved when built with Depends-on patch
> (https://patches.dpdk.org/project/dpdk/patch/20260202044841.90945-2-scott=
.k.mitch1@gmail.com/).
> Did I indicate the dependency correctly (reference
> https://doc.dpdk.org/guides/contributing/patches.html#patch-dependencies),
> and is CI expected to apply dependent patches before the current patch
> series?
>=20
> ../lib/net/rte_net.c:672:28: error: taking address of packed member of
> =E2=80=98struct rte_udp_hdr=E2=80=99 may result in an unaligned pointer v=
alue
> [-Werror=3Daddress-of-packed-member]
>   672 |                 l4_cksum =3D &rte_pktmbuf_mtod_offset(mbuf,
> struct rte_udp_hdr *,
>       |
> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   673 |                                 l4_offset)->dgram_cksum;
>       |                                 ~~~~~~~~~~~~~~~~~~~~~~~
> ../lib/net/rte_net.c:675:28: error: taking address of packed member of
> =E2=80=98struct rte_tcp_hdr=E2=80=99 may result in an unaligned pointer v=
alue
> [-Werror=3Daddress-of-packed-member]
>   675 |                 l4_cksum =3D &rte_pktmbuf_mtod_offset(mbuf,
> struct rte_tcp_hdr *, l4_offset)->cksum;
>       |
> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

CI system doesn't know what Depends-on is yet.
