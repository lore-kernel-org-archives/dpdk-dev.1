Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8190BC282DE
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Mar 2025 18:01:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6924A40B94;
	Thu,  6 Mar 2025 19:01:56 +0100 (CET)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53]) by mails.dpdk.org (Postfix) with ESMTP id 8AA1D40B92
 for <dev@dpdk.org>; Thu,  6 Mar 2025 19:01:54 +0100 (CET)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-2ff797f8f1bso600605a91.3
 for <dev@dpdk.org>; Thu, 06 Mar 2025 10:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1741284113; x=1741888913; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Tj4T7RMwE4G6zv9jPgYuheQpBMd7QC0tV/a/9e/zoic=;
 b=U0RGsaNjyBvYAIkSlcCfimSS+g/dI29lr40fPIz5VKQU2nb7svqZhv3lBdSDnu6SSg
 6/c0b4xjIs5LZeyRMSDs3eOoP7uNzz6KjXlg3HLf3239XR9FoiBfcSnCJ2lzjE2QL6Ao
 5LmP6wvas8/e0atPBVu5JVeEwPPfH5FWZhT0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741284113; x=1741888913;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Tj4T7RMwE4G6zv9jPgYuheQpBMd7QC0tV/a/9e/zoic=;
 b=V3BLSWHUAO5zI19Cp+KA6tbHb7O52tKPMEvMEPFTJeErF9lUjBnr6LxKHEzXcRxgj8
 8JbDQYn49I4jzEeLHPPrxsu/RaGsqltkIoFEV1HHNp7sNcJ07A7S1SJrlbawH5uXgBMD
 cBMZQdnFPJVyT/QzuHH931Kj07VOwxjbIzbLNSDBhxUIsn8Qicu/x5YWIbrHReoc2yPK
 /ykFegFMers732xP8gGC/cIk2JWQQ98yM4qXShWuYG5kO1d9hyXHw+IA07lZNy2RPFOd
 CGiLsK08XPp6wm3W9Sll8JwWKPA0LwJZ9yO6QakMCGF3wk1shUfKDdh43rz3/ejzel0i
 Rn1A==
X-Gm-Message-State: AOJu0Ywkng4ES4kpls7PGaA9qvq4nE8coNEBnsTWuAaY7M7KSL/b3nSr
 1tTFi5WCHQ1gXYvHh/SbGQqQaf1vb0U5yKp9YJsDxHADnG0iA5bYjf8WaEbi5Oiv0F04jR6VCGQ
 bKeMtFo+nXiiYmwjeNhWGnVNTLjzUVpoFUgWXhg==
X-Gm-Gg: ASbGncsXlGGmY8GOuFUcgFqFOX7lVA4kTEwx/i1TpovFbcKkcT6A7etgFcZLV3ITSvk
 JZ6tpCdOnf0QDQgfvzGy3etywrxbT/D2f6sRhMUc8+MsSj1+46p7OCowSKzvgFHmdaidP4AT6NK
 fNDYUBTVSUYiSeHusyIBolKQruXbz7/EQWwLaiTsXKlApHQcOCAHUaMlQY2x0=
X-Google-Smtp-Source: AGHT+IGkliiNhwrPhqEWjQyWVhEiLpdmB6jlJei8G27wn7y0hRuMtMOVNEeescXGpycG2vXA/co8Sl0dWbjbNkn0ExQ=
X-Received: by 2002:a17:90b:38c6:b0:2ee:bc7b:9237 with SMTP id
 98e67ed59e1d1-2ff7cef899fmr266443a91.27.1741284113431; Thu, 06 Mar 2025
 10:01:53 -0800 (PST)
MIME-Version: 1.0
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 6 Mar 2025 12:58:17 -0500
X-Gm-Features: AQ5f1JpQKTtpZRx9yZciGb7flhLAa-eZJ9e6s6Ubl_-NljVdnBBOq_FfX0KUVso
Message-ID: <CAJvnSUBEu56v8a27m8BTXTgRB9-n=z6xnHVewtzS8mGCDFo8gA@mail.gmail.com>
Subject: Dev branch on next-dts
To: "NBU-Contact-Thomas Monjalon (EXTERNAL)" <thomas@monjalon.net>,
 David Marchand <david.marchand@redhat.com>
Cc: dev <dev@dpdk.org>, ci@dpdk.org, Paul Szczepanek <Paul.Szczepanek@arm.com>
Content-Type: multipart/alternative; boundary="00000000000008ea1c062fb04db7"
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

--00000000000008ea1c062fb04db7
Content-Type: text/plain; charset="UTF-8"

Hi Thomas/David,

We still have a couple patchseries under review for next-dts which we
intend to push to next-dts/for-main, to be pulled for 25.03. At the same
time, there are some series which we are working on but are now pushed to
the 25.07 release. We want to continue to work on these over the next few
weeks, but don't want to push them to for-main obviously.

Paul (DTS tree maintainer) has suggested that we create a dev branch on
dpdk-next-dts for this. It sounds fine to me - I am just running it by you
both so you are aware.

We'll go ahead in case you have any concerns. Cheers!

-Patrick

--00000000000008ea1c062fb04db7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Thomas/David,</div><div><br></div><div>We still ha=
ve a couple patchseries under review for next-dts which we intend to push t=
o next-dts/for-main, to be pulled for 25.03. At the same time, there are so=
me series which we are working on but are now pushed to the 25.07 release. =
We want to continue to work on these over the next few weeks, but don&#39;t=
 want to push them to for-main obviously.</div><div><br></div><div>Paul (DT=
S tree maintainer) has suggested that we create a dev branch on dpdk-next-d=
ts for this. It sounds fine to me - I am just running it by you both so you=
 are aware. <br></div><div><br></div><div>We&#39;ll go ahead in case you ha=
ve any concerns. Cheers!</div><div><br></div><div>-Patrick</div></div>

--00000000000008ea1c062fb04db7--
